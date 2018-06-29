
kernel：     文件格式 elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 d0 10 00       	mov    $0x10d000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 f6 10 80       	mov    $0x8010f6c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 02 37 10 80       	mov    $0x80103702,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	83 ec 08             	sub    $0x8,%esp
8010003d:	68 1c b4 10 80       	push   $0x8010b41c
80100042:	68 c0 f6 10 80       	push   $0x8010f6c0
80100047:	e8 cf 4d 00 00       	call   80104e1b <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 f0 0b 11 80 e4 	movl   $0x80110be4,0x80110bf0
80100056:	0b 11 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 f4 0b 11 80 e4 	movl   $0x80110be4,0x80110bf4
80100060:	0b 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100063:	c7 45 f4 f4 f6 10 80 	movl   $0x8010f6f4,-0xc(%ebp)
8010006a:	eb 3a                	jmp    801000a6 <binit+0x72>
    b->next = bcache.head.next;
8010006c:	8b 15 f4 0b 11 80    	mov    0x80110bf4,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 0c e4 0b 11 80 	movl   $0x80110be4,0xc(%eax)
    b->dev = -1;
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008c:	a1 f4 0b 11 80       	mov    0x80110bf4,%eax
80100091:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100094:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100097:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010009a:	a3 f4 0b 11 80       	mov    %eax,0x80110bf4

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009f:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a6:	b8 e4 0b 11 80       	mov    $0x80110be4,%eax
801000ab:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801000ae:	72 bc                	jb     8010006c <binit+0x38>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000b0:	90                   	nop
801000b1:	c9                   	leave  
801000b2:	c3                   	ret    

801000b3 <bget>:
// Look through buffer cache for sector on device dev.
// If not found, allocate fresh block.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint sector)
{
801000b3:	55                   	push   %ebp
801000b4:	89 e5                	mov    %esp,%ebp
801000b6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000b9:	83 ec 0c             	sub    $0xc,%esp
801000bc:	68 c0 f6 10 80       	push   $0x8010f6c0
801000c1:	e8 77 4d 00 00       	call   80104e3d <acquire>
801000c6:	83 c4 10             	add    $0x10,%esp

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c9:	a1 f4 0b 11 80       	mov    0x80110bf4,%eax
801000ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000d1:	eb 67                	jmp    8010013a <bget+0x87>
    if(b->dev == dev && b->sector == sector){
801000d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000d6:	8b 40 04             	mov    0x4(%eax),%eax
801000d9:	3b 45 08             	cmp    0x8(%ebp),%eax
801000dc:	75 53                	jne    80100131 <bget+0x7e>
801000de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e1:	8b 40 08             	mov    0x8(%eax),%eax
801000e4:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e7:	75 48                	jne    80100131 <bget+0x7e>
      if(!(b->flags & B_BUSY)){
801000e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ec:	8b 00                	mov    (%eax),%eax
801000ee:	83 e0 01             	and    $0x1,%eax
801000f1:	85 c0                	test   %eax,%eax
801000f3:	75 27                	jne    8010011c <bget+0x69>
        b->flags |= B_BUSY;
801000f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f8:	8b 00                	mov    (%eax),%eax
801000fa:	83 c8 01             	or     $0x1,%eax
801000fd:	89 c2                	mov    %eax,%edx
801000ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100102:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
80100104:	83 ec 0c             	sub    $0xc,%esp
80100107:	68 c0 f6 10 80       	push   $0x8010f6c0
8010010c:	e8 93 4d 00 00       	call   80104ea4 <release>
80100111:	83 c4 10             	add    $0x10,%esp
        return b;
80100114:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100117:	e9 98 00 00 00       	jmp    801001b4 <bget+0x101>
      }
      sleep(b, &bcache.lock);
8010011c:	83 ec 08             	sub    $0x8,%esp
8010011f:	68 c0 f6 10 80       	push   $0x8010f6c0
80100124:	ff 75 f4             	pushl  -0xc(%ebp)
80100127:	e8 18 4a 00 00       	call   80104b44 <sleep>
8010012c:	83 c4 10             	add    $0x10,%esp
      goto loop;
8010012f:	eb 98                	jmp    801000c9 <bget+0x16>

  acquire(&bcache.lock);

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100131:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100134:	8b 40 10             	mov    0x10(%eax),%eax
80100137:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010013a:	81 7d f4 e4 0b 11 80 	cmpl   $0x80110be4,-0xc(%ebp)
80100141:	75 90                	jne    801000d3 <bget+0x20>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100143:	a1 f0 0b 11 80       	mov    0x80110bf0,%eax
80100148:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010014b:	eb 51                	jmp    8010019e <bget+0xeb>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
8010014d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100150:	8b 00                	mov    (%eax),%eax
80100152:	83 e0 01             	and    $0x1,%eax
80100155:	85 c0                	test   %eax,%eax
80100157:	75 3c                	jne    80100195 <bget+0xe2>
80100159:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015c:	8b 00                	mov    (%eax),%eax
8010015e:	83 e0 04             	and    $0x4,%eax
80100161:	85 c0                	test   %eax,%eax
80100163:	75 30                	jne    80100195 <bget+0xe2>
      b->dev = dev;
80100165:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100168:	8b 55 08             	mov    0x8(%ebp),%edx
8010016b:	89 50 04             	mov    %edx,0x4(%eax)
      b->sector = sector;
8010016e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100171:	8b 55 0c             	mov    0xc(%ebp),%edx
80100174:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
80100177:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010017a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
80100180:	83 ec 0c             	sub    $0xc,%esp
80100183:	68 c0 f6 10 80       	push   $0x8010f6c0
80100188:	e8 17 4d 00 00       	call   80104ea4 <release>
8010018d:	83 c4 10             	add    $0x10,%esp
      return b;
80100190:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100193:	eb 1f                	jmp    801001b4 <bget+0x101>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100195:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100198:	8b 40 0c             	mov    0xc(%eax),%eax
8010019b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010019e:	81 7d f4 e4 0b 11 80 	cmpl   $0x80110be4,-0xc(%ebp)
801001a5:	75 a6                	jne    8010014d <bget+0x9a>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
801001a7:	83 ec 0c             	sub    $0xc,%esp
801001aa:	68 23 b4 10 80       	push   $0x8010b423
801001af:	e8 b2 03 00 00       	call   80100566 <panic>
}
801001b4:	c9                   	leave  
801001b5:	c3                   	ret    

801001b6 <bread>:

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
801001b6:	55                   	push   %ebp
801001b7:	89 e5                	mov    %esp,%ebp
801001b9:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, sector);
801001bc:	83 ec 08             	sub    $0x8,%esp
801001bf:	ff 75 0c             	pushl  0xc(%ebp)
801001c2:	ff 75 08             	pushl  0x8(%ebp)
801001c5:	e8 e9 fe ff ff       	call   801000b3 <bget>
801001ca:	83 c4 10             	add    $0x10,%esp
801001cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID))
801001d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d3:	8b 00                	mov    (%eax),%eax
801001d5:	83 e0 02             	and    $0x2,%eax
801001d8:	85 c0                	test   %eax,%eax
801001da:	75 0e                	jne    801001ea <bread+0x34>
    iderw(b);
801001dc:	83 ec 0c             	sub    $0xc,%esp
801001df:	ff 75 f4             	pushl  -0xc(%ebp)
801001e2:	e8 c0 27 00 00       	call   801029a7 <iderw>
801001e7:	83 c4 10             	add    $0x10,%esp
  return b;
801001ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001ed:	c9                   	leave  
801001ee:	c3                   	ret    

801001ef <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001ef:	55                   	push   %ebp
801001f0:	89 e5                	mov    %esp,%ebp
801001f2:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
801001f5:	8b 45 08             	mov    0x8(%ebp),%eax
801001f8:	8b 00                	mov    (%eax),%eax
801001fa:	83 e0 01             	and    $0x1,%eax
801001fd:	85 c0                	test   %eax,%eax
801001ff:	75 0d                	jne    8010020e <bwrite+0x1f>
    panic("bwrite");
80100201:	83 ec 0c             	sub    $0xc,%esp
80100204:	68 34 b4 10 80       	push   $0x8010b434
80100209:	e8 58 03 00 00       	call   80100566 <panic>
  b->flags |= B_DIRTY;
8010020e:	8b 45 08             	mov    0x8(%ebp),%eax
80100211:	8b 00                	mov    (%eax),%eax
80100213:	83 c8 04             	or     $0x4,%eax
80100216:	89 c2                	mov    %eax,%edx
80100218:	8b 45 08             	mov    0x8(%ebp),%eax
8010021b:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010021d:	83 ec 0c             	sub    $0xc,%esp
80100220:	ff 75 08             	pushl  0x8(%ebp)
80100223:	e8 7f 27 00 00       	call   801029a7 <iderw>
80100228:	83 c4 10             	add    $0x10,%esp
}
8010022b:	90                   	nop
8010022c:	c9                   	leave  
8010022d:	c3                   	ret    

8010022e <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
8010022e:	55                   	push   %ebp
8010022f:	89 e5                	mov    %esp,%ebp
80100231:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
80100234:	8b 45 08             	mov    0x8(%ebp),%eax
80100237:	8b 00                	mov    (%eax),%eax
80100239:	83 e0 01             	and    $0x1,%eax
8010023c:	85 c0                	test   %eax,%eax
8010023e:	75 0d                	jne    8010024d <brelse+0x1f>
    panic("brelse");
80100240:	83 ec 0c             	sub    $0xc,%esp
80100243:	68 3b b4 10 80       	push   $0x8010b43b
80100248:	e8 19 03 00 00       	call   80100566 <panic>

  acquire(&bcache.lock);
8010024d:	83 ec 0c             	sub    $0xc,%esp
80100250:	68 c0 f6 10 80       	push   $0x8010f6c0
80100255:	e8 e3 4b 00 00       	call   80104e3d <acquire>
8010025a:	83 c4 10             	add    $0x10,%esp

  b->next->prev = b->prev;
8010025d:	8b 45 08             	mov    0x8(%ebp),%eax
80100260:	8b 40 10             	mov    0x10(%eax),%eax
80100263:	8b 55 08             	mov    0x8(%ebp),%edx
80100266:	8b 52 0c             	mov    0xc(%edx),%edx
80100269:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
8010026c:	8b 45 08             	mov    0x8(%ebp),%eax
8010026f:	8b 40 0c             	mov    0xc(%eax),%eax
80100272:	8b 55 08             	mov    0x8(%ebp),%edx
80100275:	8b 52 10             	mov    0x10(%edx),%edx
80100278:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
8010027b:	8b 15 f4 0b 11 80    	mov    0x80110bf4,%edx
80100281:	8b 45 08             	mov    0x8(%ebp),%eax
80100284:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
80100287:	8b 45 08             	mov    0x8(%ebp),%eax
8010028a:	c7 40 0c e4 0b 11 80 	movl   $0x80110be4,0xc(%eax)
  bcache.head.next->prev = b;
80100291:	a1 f4 0b 11 80       	mov    0x80110bf4,%eax
80100296:	8b 55 08             	mov    0x8(%ebp),%edx
80100299:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
8010029c:	8b 45 08             	mov    0x8(%ebp),%eax
8010029f:	a3 f4 0b 11 80       	mov    %eax,0x80110bf4

  b->flags &= ~B_BUSY;
801002a4:	8b 45 08             	mov    0x8(%ebp),%eax
801002a7:	8b 00                	mov    (%eax),%eax
801002a9:	83 e0 fe             	and    $0xfffffffe,%eax
801002ac:	89 c2                	mov    %eax,%edx
801002ae:	8b 45 08             	mov    0x8(%ebp),%eax
801002b1:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801002b3:	83 ec 0c             	sub    $0xc,%esp
801002b6:	ff 75 08             	pushl  0x8(%ebp)
801002b9:	e8 71 49 00 00       	call   80104c2f <wakeup>
801002be:	83 c4 10             	add    $0x10,%esp

  release(&bcache.lock);
801002c1:	83 ec 0c             	sub    $0xc,%esp
801002c4:	68 c0 f6 10 80       	push   $0x8010f6c0
801002c9:	e8 d6 4b 00 00       	call   80104ea4 <release>
801002ce:	83 c4 10             	add    $0x10,%esp
}
801002d1:	90                   	nop
801002d2:	c9                   	leave  
801002d3:	c3                   	ret    

801002d4 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002d4:	55                   	push   %ebp
801002d5:	89 e5                	mov    %esp,%ebp
801002d7:	83 ec 14             	sub    $0x14,%esp
801002da:	8b 45 08             	mov    0x8(%ebp),%eax
801002dd:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002e1:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801002e5:	89 c2                	mov    %eax,%edx
801002e7:	ec                   	in     (%dx),%al
801002e8:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801002eb:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801002ef:	c9                   	leave  
801002f0:	c3                   	ret    

801002f1 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002f1:	55                   	push   %ebp
801002f2:	89 e5                	mov    %esp,%ebp
801002f4:	83 ec 08             	sub    $0x8,%esp
801002f7:	8b 55 08             	mov    0x8(%ebp),%edx
801002fa:	8b 45 0c             	mov    0xc(%ebp),%eax
801002fd:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80100301:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100304:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80100308:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010030c:	ee                   	out    %al,(%dx)
}
8010030d:	90                   	nop
8010030e:	c9                   	leave  
8010030f:	c3                   	ret    

80100310 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80100310:	55                   	push   %ebp
80100311:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80100313:	fa                   	cli    
}
80100314:	90                   	nop
80100315:	5d                   	pop    %ebp
80100316:	c3                   	ret    

80100317 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100317:	55                   	push   %ebp
80100318:	89 e5                	mov    %esp,%ebp
8010031a:	53                   	push   %ebx
8010031b:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010031e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100322:	74 1c                	je     80100340 <printint+0x29>
80100324:	8b 45 08             	mov    0x8(%ebp),%eax
80100327:	c1 e8 1f             	shr    $0x1f,%eax
8010032a:	0f b6 c0             	movzbl %al,%eax
8010032d:	89 45 10             	mov    %eax,0x10(%ebp)
80100330:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100334:	74 0a                	je     80100340 <printint+0x29>
    x = -xx;
80100336:	8b 45 08             	mov    0x8(%ebp),%eax
80100339:	f7 d8                	neg    %eax
8010033b:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010033e:	eb 06                	jmp    80100346 <printint+0x2f>
  else
    x = xx;
80100340:	8b 45 08             	mov    0x8(%ebp),%eax
80100343:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100346:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
8010034d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100350:	8d 41 01             	lea    0x1(%ecx),%eax
80100353:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100356:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100359:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010035c:	ba 00 00 00 00       	mov    $0x0,%edx
80100361:	f7 f3                	div    %ebx
80100363:	89 d0                	mov    %edx,%eax
80100365:	0f b6 80 04 c0 10 80 	movzbl -0x7fef3ffc(%eax),%eax
8010036c:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
  }while((x /= base) != 0);
80100370:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100373:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100376:	ba 00 00 00 00       	mov    $0x0,%edx
8010037b:	f7 f3                	div    %ebx
8010037d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100380:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100384:	75 c7                	jne    8010034d <printint+0x36>

  if(sign)
80100386:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010038a:	74 2a                	je     801003b6 <printint+0x9f>
    buf[i++] = '-';
8010038c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010038f:	8d 50 01             	lea    0x1(%eax),%edx
80100392:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100395:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
8010039a:	eb 1a                	jmp    801003b6 <printint+0x9f>
    consputc(buf[i]);
8010039c:	8d 55 e0             	lea    -0x20(%ebp),%edx
8010039f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003a2:	01 d0                	add    %edx,%eax
801003a4:	0f b6 00             	movzbl (%eax),%eax
801003a7:	0f be c0             	movsbl %al,%eax
801003aa:	83 ec 0c             	sub    $0xc,%esp
801003ad:	50                   	push   %eax
801003ae:	e8 c3 03 00 00       	call   80100776 <consputc>
801003b3:	83 c4 10             	add    $0x10,%esp
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801003b6:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003ba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003be:	79 dc                	jns    8010039c <printint+0x85>
    consputc(buf[i]);
}
801003c0:	90                   	nop
801003c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801003c4:	c9                   	leave  
801003c5:	c3                   	ret    

801003c6 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003c6:	55                   	push   %ebp
801003c7:	89 e5                	mov    %esp,%ebp
801003c9:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003cc:	a1 34 e6 10 80       	mov    0x8010e634,%eax
801003d1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003d4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003d8:	74 10                	je     801003ea <cprintf+0x24>
    acquire(&cons.lock);
801003da:	83 ec 0c             	sub    $0xc,%esp
801003dd:	68 00 e6 10 80       	push   $0x8010e600
801003e2:	e8 56 4a 00 00       	call   80104e3d <acquire>
801003e7:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
801003ea:	8b 45 08             	mov    0x8(%ebp),%eax
801003ed:	85 c0                	test   %eax,%eax
801003ef:	75 0d                	jne    801003fe <cprintf+0x38>
    panic("null fmt");
801003f1:	83 ec 0c             	sub    $0xc,%esp
801003f4:	68 42 b4 10 80       	push   $0x8010b442
801003f9:	e8 68 01 00 00       	call   80100566 <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003fe:	8d 45 0c             	lea    0xc(%ebp),%eax
80100401:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100404:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010040b:	e9 1a 01 00 00       	jmp    8010052a <cprintf+0x164>
    if(c != '%'){
80100410:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
80100414:	74 13                	je     80100429 <cprintf+0x63>
      consputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	ff 75 e4             	pushl  -0x1c(%ebp)
8010041c:	e8 55 03 00 00       	call   80100776 <consputc>
80100421:	83 c4 10             	add    $0x10,%esp
      continue;
80100424:	e9 fd 00 00 00       	jmp    80100526 <cprintf+0x160>
    }
    c = fmt[++i] & 0xff;
80100429:	8b 55 08             	mov    0x8(%ebp),%edx
8010042c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100430:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100433:	01 d0                	add    %edx,%eax
80100435:	0f b6 00             	movzbl (%eax),%eax
80100438:	0f be c0             	movsbl %al,%eax
8010043b:	25 ff 00 00 00       	and    $0xff,%eax
80100440:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
80100443:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100447:	0f 84 ff 00 00 00    	je     8010054c <cprintf+0x186>
      break;
    switch(c){
8010044d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100450:	83 f8 70             	cmp    $0x70,%eax
80100453:	74 47                	je     8010049c <cprintf+0xd6>
80100455:	83 f8 70             	cmp    $0x70,%eax
80100458:	7f 13                	jg     8010046d <cprintf+0xa7>
8010045a:	83 f8 25             	cmp    $0x25,%eax
8010045d:	0f 84 98 00 00 00    	je     801004fb <cprintf+0x135>
80100463:	83 f8 64             	cmp    $0x64,%eax
80100466:	74 14                	je     8010047c <cprintf+0xb6>
80100468:	e9 9d 00 00 00       	jmp    8010050a <cprintf+0x144>
8010046d:	83 f8 73             	cmp    $0x73,%eax
80100470:	74 47                	je     801004b9 <cprintf+0xf3>
80100472:	83 f8 78             	cmp    $0x78,%eax
80100475:	74 25                	je     8010049c <cprintf+0xd6>
80100477:	e9 8e 00 00 00       	jmp    8010050a <cprintf+0x144>
    case 'd':
      printint(*argp++, 10, 1);
8010047c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010047f:	8d 50 04             	lea    0x4(%eax),%edx
80100482:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100485:	8b 00                	mov    (%eax),%eax
80100487:	83 ec 04             	sub    $0x4,%esp
8010048a:	6a 01                	push   $0x1
8010048c:	6a 0a                	push   $0xa
8010048e:	50                   	push   %eax
8010048f:	e8 83 fe ff ff       	call   80100317 <printint>
80100494:	83 c4 10             	add    $0x10,%esp
      break;
80100497:	e9 8a 00 00 00       	jmp    80100526 <cprintf+0x160>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010049c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010049f:	8d 50 04             	lea    0x4(%eax),%edx
801004a2:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004a5:	8b 00                	mov    (%eax),%eax
801004a7:	83 ec 04             	sub    $0x4,%esp
801004aa:	6a 00                	push   $0x0
801004ac:	6a 10                	push   $0x10
801004ae:	50                   	push   %eax
801004af:	e8 63 fe ff ff       	call   80100317 <printint>
801004b4:	83 c4 10             	add    $0x10,%esp
      break;
801004b7:	eb 6d                	jmp    80100526 <cprintf+0x160>
    case 's':
      if((s = (char*)*argp++) == 0)
801004b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004bc:	8d 50 04             	lea    0x4(%eax),%edx
801004bf:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004c2:	8b 00                	mov    (%eax),%eax
801004c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004cb:	75 22                	jne    801004ef <cprintf+0x129>
        s = "(null)";
801004cd:	c7 45 ec 4b b4 10 80 	movl   $0x8010b44b,-0x14(%ebp)
      for(; *s; s++)
801004d4:	eb 19                	jmp    801004ef <cprintf+0x129>
        consputc(*s);
801004d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004d9:	0f b6 00             	movzbl (%eax),%eax
801004dc:	0f be c0             	movsbl %al,%eax
801004df:	83 ec 0c             	sub    $0xc,%esp
801004e2:	50                   	push   %eax
801004e3:	e8 8e 02 00 00       	call   80100776 <consputc>
801004e8:	83 c4 10             	add    $0x10,%esp
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004eb:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801004ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004f2:	0f b6 00             	movzbl (%eax),%eax
801004f5:	84 c0                	test   %al,%al
801004f7:	75 dd                	jne    801004d6 <cprintf+0x110>
        consputc(*s);
      break;
801004f9:	eb 2b                	jmp    80100526 <cprintf+0x160>
    case '%':
      consputc('%');
801004fb:	83 ec 0c             	sub    $0xc,%esp
801004fe:	6a 25                	push   $0x25
80100500:	e8 71 02 00 00       	call   80100776 <consputc>
80100505:	83 c4 10             	add    $0x10,%esp
      break;
80100508:	eb 1c                	jmp    80100526 <cprintf+0x160>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
8010050a:	83 ec 0c             	sub    $0xc,%esp
8010050d:	6a 25                	push   $0x25
8010050f:	e8 62 02 00 00       	call   80100776 <consputc>
80100514:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100517:	83 ec 0c             	sub    $0xc,%esp
8010051a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010051d:	e8 54 02 00 00       	call   80100776 <consputc>
80100522:	83 c4 10             	add    $0x10,%esp
      break;
80100525:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100526:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010052a:	8b 55 08             	mov    0x8(%ebp),%edx
8010052d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100530:	01 d0                	add    %edx,%eax
80100532:	0f b6 00             	movzbl (%eax),%eax
80100535:	0f be c0             	movsbl %al,%eax
80100538:	25 ff 00 00 00       	and    $0xff,%eax
8010053d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100540:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100544:	0f 85 c6 fe ff ff    	jne    80100410 <cprintf+0x4a>
8010054a:	eb 01                	jmp    8010054d <cprintf+0x187>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
8010054c:	90                   	nop
      consputc(c);
      break;
    }
  }

  if(locking)
8010054d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100551:	74 10                	je     80100563 <cprintf+0x19d>
    release(&cons.lock);
80100553:	83 ec 0c             	sub    $0xc,%esp
80100556:	68 00 e6 10 80       	push   $0x8010e600
8010055b:	e8 44 49 00 00       	call   80104ea4 <release>
80100560:	83 c4 10             	add    $0x10,%esp
}
80100563:	90                   	nop
80100564:	c9                   	leave  
80100565:	c3                   	ret    

80100566 <panic>:

void
panic(char *s)
{
80100566:	55                   	push   %ebp
80100567:	89 e5                	mov    %esp,%ebp
80100569:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];
  
  cli();
8010056c:	e8 9f fd ff ff       	call   80100310 <cli>
  cons.locking = 0;
80100571:	c7 05 34 e6 10 80 00 	movl   $0x0,0x8010e634
80100578:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
8010057b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100581:	0f b6 00             	movzbl (%eax),%eax
80100584:	0f b6 c0             	movzbl %al,%eax
80100587:	83 ec 08             	sub    $0x8,%esp
8010058a:	50                   	push   %eax
8010058b:	68 52 b4 10 80       	push   $0x8010b452
80100590:	e8 31 fe ff ff       	call   801003c6 <cprintf>
80100595:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
80100598:	8b 45 08             	mov    0x8(%ebp),%eax
8010059b:	83 ec 0c             	sub    $0xc,%esp
8010059e:	50                   	push   %eax
8010059f:	e8 22 fe ff ff       	call   801003c6 <cprintf>
801005a4:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
801005a7:	83 ec 0c             	sub    $0xc,%esp
801005aa:	68 61 b4 10 80       	push   $0x8010b461
801005af:	e8 12 fe ff ff       	call   801003c6 <cprintf>
801005b4:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005b7:	83 ec 08             	sub    $0x8,%esp
801005ba:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005bd:	50                   	push   %eax
801005be:	8d 45 08             	lea    0x8(%ebp),%eax
801005c1:	50                   	push   %eax
801005c2:	e8 2f 49 00 00       	call   80104ef6 <getcallerpcs>
801005c7:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005d1:	eb 1c                	jmp    801005ef <panic+0x89>
    cprintf(" %p", pcs[i]);
801005d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005d6:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005da:	83 ec 08             	sub    $0x8,%esp
801005dd:	50                   	push   %eax
801005de:	68 63 b4 10 80       	push   $0x8010b463
801005e3:	e8 de fd ff ff       	call   801003c6 <cprintf>
801005e8:	83 c4 10             	add    $0x10,%esp
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005eb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005ef:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005f3:	7e de                	jle    801005d3 <panic+0x6d>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005f5:	c7 05 e0 e5 10 80 01 	movl   $0x1,0x8010e5e0
801005fc:	00 00 00 
  for(;;)
    ;
801005ff:	eb fe                	jmp    801005ff <panic+0x99>

80100601 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
80100601:	55                   	push   %ebp
80100602:	89 e5                	mov    %esp,%ebp
80100604:	83 ec 18             	sub    $0x18,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
80100607:	6a 0e                	push   $0xe
80100609:	68 d4 03 00 00       	push   $0x3d4
8010060e:	e8 de fc ff ff       	call   801002f1 <outb>
80100613:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
80100616:	68 d5 03 00 00       	push   $0x3d5
8010061b:	e8 b4 fc ff ff       	call   801002d4 <inb>
80100620:	83 c4 04             	add    $0x4,%esp
80100623:	0f b6 c0             	movzbl %al,%eax
80100626:	c1 e0 08             	shl    $0x8,%eax
80100629:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
8010062c:	6a 0f                	push   $0xf
8010062e:	68 d4 03 00 00       	push   $0x3d4
80100633:	e8 b9 fc ff ff       	call   801002f1 <outb>
80100638:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
8010063b:	68 d5 03 00 00       	push   $0x3d5
80100640:	e8 8f fc ff ff       	call   801002d4 <inb>
80100645:	83 c4 04             	add    $0x4,%esp
80100648:	0f b6 c0             	movzbl %al,%eax
8010064b:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
8010064e:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100652:	75 30                	jne    80100684 <cgaputc+0x83>
    pos += 80 - pos%80;
80100654:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100657:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010065c:	89 c8                	mov    %ecx,%eax
8010065e:	f7 ea                	imul   %edx
80100660:	c1 fa 05             	sar    $0x5,%edx
80100663:	89 c8                	mov    %ecx,%eax
80100665:	c1 f8 1f             	sar    $0x1f,%eax
80100668:	29 c2                	sub    %eax,%edx
8010066a:	89 d0                	mov    %edx,%eax
8010066c:	c1 e0 02             	shl    $0x2,%eax
8010066f:	01 d0                	add    %edx,%eax
80100671:	c1 e0 04             	shl    $0x4,%eax
80100674:	29 c1                	sub    %eax,%ecx
80100676:	89 ca                	mov    %ecx,%edx
80100678:	b8 50 00 00 00       	mov    $0x50,%eax
8010067d:	29 d0                	sub    %edx,%eax
8010067f:	01 45 f4             	add    %eax,-0xc(%ebp)
80100682:	eb 34                	jmp    801006b8 <cgaputc+0xb7>
  else if(c == BACKSPACE){
80100684:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010068b:	75 0c                	jne    80100699 <cgaputc+0x98>
    if(pos > 0) --pos;
8010068d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100691:	7e 25                	jle    801006b8 <cgaputc+0xb7>
80100693:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100697:	eb 1f                	jmp    801006b8 <cgaputc+0xb7>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100699:	8b 0d 00 c0 10 80    	mov    0x8010c000,%ecx
8010069f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801006a2:	8d 50 01             	lea    0x1(%eax),%edx
801006a5:	89 55 f4             	mov    %edx,-0xc(%ebp)
801006a8:	01 c0                	add    %eax,%eax
801006aa:	01 c8                	add    %ecx,%eax
801006ac:	8b 55 08             	mov    0x8(%ebp),%edx
801006af:	0f b6 d2             	movzbl %dl,%edx
801006b2:	80 ce 07             	or     $0x7,%dh
801006b5:	66 89 10             	mov    %dx,(%eax)
  
  if((pos/80) >= 24){  // Scroll up.
801006b8:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
801006bf:	7e 4c                	jle    8010070d <cgaputc+0x10c>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006c1:	a1 00 c0 10 80       	mov    0x8010c000,%eax
801006c6:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
801006cc:	a1 00 c0 10 80       	mov    0x8010c000,%eax
801006d1:	83 ec 04             	sub    $0x4,%esp
801006d4:	68 60 0e 00 00       	push   $0xe60
801006d9:	52                   	push   %edx
801006da:	50                   	push   %eax
801006db:	e8 7f 4a 00 00       	call   8010515f <memmove>
801006e0:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
801006e3:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006e7:	b8 80 07 00 00       	mov    $0x780,%eax
801006ec:	2b 45 f4             	sub    -0xc(%ebp),%eax
801006ef:	8d 14 00             	lea    (%eax,%eax,1),%edx
801006f2:	a1 00 c0 10 80       	mov    0x8010c000,%eax
801006f7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801006fa:	01 c9                	add    %ecx,%ecx
801006fc:	01 c8                	add    %ecx,%eax
801006fe:	83 ec 04             	sub    $0x4,%esp
80100701:	52                   	push   %edx
80100702:	6a 00                	push   $0x0
80100704:	50                   	push   %eax
80100705:	e8 96 49 00 00       	call   801050a0 <memset>
8010070a:	83 c4 10             	add    $0x10,%esp
  }
  
  outb(CRTPORT, 14);
8010070d:	83 ec 08             	sub    $0x8,%esp
80100710:	6a 0e                	push   $0xe
80100712:	68 d4 03 00 00       	push   $0x3d4
80100717:	e8 d5 fb ff ff       	call   801002f1 <outb>
8010071c:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
8010071f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100722:	c1 f8 08             	sar    $0x8,%eax
80100725:	0f b6 c0             	movzbl %al,%eax
80100728:	83 ec 08             	sub    $0x8,%esp
8010072b:	50                   	push   %eax
8010072c:	68 d5 03 00 00       	push   $0x3d5
80100731:	e8 bb fb ff ff       	call   801002f1 <outb>
80100736:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
80100739:	83 ec 08             	sub    $0x8,%esp
8010073c:	6a 0f                	push   $0xf
8010073e:	68 d4 03 00 00       	push   $0x3d4
80100743:	e8 a9 fb ff ff       	call   801002f1 <outb>
80100748:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
8010074b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010074e:	0f b6 c0             	movzbl %al,%eax
80100751:	83 ec 08             	sub    $0x8,%esp
80100754:	50                   	push   %eax
80100755:	68 d5 03 00 00       	push   $0x3d5
8010075a:	e8 92 fb ff ff       	call   801002f1 <outb>
8010075f:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
80100762:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80100767:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010076a:	01 d2                	add    %edx,%edx
8010076c:	01 d0                	add    %edx,%eax
8010076e:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
80100773:	90                   	nop
80100774:	c9                   	leave  
80100775:	c3                   	ret    

80100776 <consputc>:

void
consputc(int c)
{
80100776:	55                   	push   %ebp
80100777:	89 e5                	mov    %esp,%ebp
80100779:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
8010077c:	a1 e0 e5 10 80       	mov    0x8010e5e0,%eax
80100781:	85 c0                	test   %eax,%eax
80100783:	74 07                	je     8010078c <consputc+0x16>
    cli();
80100785:	e8 86 fb ff ff       	call   80100310 <cli>
    for(;;)
      ;
8010078a:	eb fe                	jmp    8010078a <consputc+0x14>
  }

  if(c == BACKSPACE){
8010078c:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100793:	75 29                	jne    801007be <consputc+0x48>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100795:	83 ec 0c             	sub    $0xc,%esp
80100798:	6a 08                	push   $0x8
8010079a:	e8 33 62 00 00       	call   801069d2 <uartputc>
8010079f:	83 c4 10             	add    $0x10,%esp
801007a2:	83 ec 0c             	sub    $0xc,%esp
801007a5:	6a 20                	push   $0x20
801007a7:	e8 26 62 00 00       	call   801069d2 <uartputc>
801007ac:	83 c4 10             	add    $0x10,%esp
801007af:	83 ec 0c             	sub    $0xc,%esp
801007b2:	6a 08                	push   $0x8
801007b4:	e8 19 62 00 00       	call   801069d2 <uartputc>
801007b9:	83 c4 10             	add    $0x10,%esp
801007bc:	eb 0e                	jmp    801007cc <consputc+0x56>
  } else
    uartputc(c);
801007be:	83 ec 0c             	sub    $0xc,%esp
801007c1:	ff 75 08             	pushl  0x8(%ebp)
801007c4:	e8 09 62 00 00       	call   801069d2 <uartputc>
801007c9:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
801007cc:	83 ec 0c             	sub    $0xc,%esp
801007cf:	ff 75 08             	pushl  0x8(%ebp)
801007d2:	e8 2a fe ff ff       	call   80100601 <cgaputc>
801007d7:	83 c4 10             	add    $0x10,%esp
}
801007da:	90                   	nop
801007db:	c9                   	leave  
801007dc:	c3                   	ret    

801007dd <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007dd:	55                   	push   %ebp
801007de:	89 e5                	mov    %esp,%ebp
801007e0:	83 ec 18             	sub    $0x18,%esp
  int c;

  acquire(&input.lock);
801007e3:	83 ec 0c             	sub    $0xc,%esp
801007e6:	68 00 0e 11 80       	push   $0x80110e00
801007eb:	e8 4d 46 00 00       	call   80104e3d <acquire>
801007f0:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
801007f3:	e9 42 01 00 00       	jmp    8010093a <consoleintr+0x15d>
    switch(c){
801007f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007fb:	83 f8 10             	cmp    $0x10,%eax
801007fe:	74 1e                	je     8010081e <consoleintr+0x41>
80100800:	83 f8 10             	cmp    $0x10,%eax
80100803:	7f 0a                	jg     8010080f <consoleintr+0x32>
80100805:	83 f8 08             	cmp    $0x8,%eax
80100808:	74 69                	je     80100873 <consoleintr+0x96>
8010080a:	e9 99 00 00 00       	jmp    801008a8 <consoleintr+0xcb>
8010080f:	83 f8 15             	cmp    $0x15,%eax
80100812:	74 31                	je     80100845 <consoleintr+0x68>
80100814:	83 f8 7f             	cmp    $0x7f,%eax
80100817:	74 5a                	je     80100873 <consoleintr+0x96>
80100819:	e9 8a 00 00 00       	jmp    801008a8 <consoleintr+0xcb>
    case C('P'):  // Process listing.
      procdump();
8010081e:	e8 c7 44 00 00       	call   80104cea <procdump>
      break;
80100823:	e9 12 01 00 00       	jmp    8010093a <consoleintr+0x15d>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100828:	a1 bc 0e 11 80       	mov    0x80110ebc,%eax
8010082d:	83 e8 01             	sub    $0x1,%eax
80100830:	a3 bc 0e 11 80       	mov    %eax,0x80110ebc
        consputc(BACKSPACE);
80100835:	83 ec 0c             	sub    $0xc,%esp
80100838:	68 00 01 00 00       	push   $0x100
8010083d:	e8 34 ff ff ff       	call   80100776 <consputc>
80100842:	83 c4 10             	add    $0x10,%esp
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100845:	8b 15 bc 0e 11 80    	mov    0x80110ebc,%edx
8010084b:	a1 b8 0e 11 80       	mov    0x80110eb8,%eax
80100850:	39 c2                	cmp    %eax,%edx
80100852:	0f 84 e2 00 00 00    	je     8010093a <consoleintr+0x15d>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100858:	a1 bc 0e 11 80       	mov    0x80110ebc,%eax
8010085d:	83 e8 01             	sub    $0x1,%eax
80100860:	83 e0 7f             	and    $0x7f,%eax
80100863:	0f b6 80 34 0e 11 80 	movzbl -0x7feef1cc(%eax),%eax
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010086a:	3c 0a                	cmp    $0xa,%al
8010086c:	75 ba                	jne    80100828 <consoleintr+0x4b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
8010086e:	e9 c7 00 00 00       	jmp    8010093a <consoleintr+0x15d>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100873:	8b 15 bc 0e 11 80    	mov    0x80110ebc,%edx
80100879:	a1 b8 0e 11 80       	mov    0x80110eb8,%eax
8010087e:	39 c2                	cmp    %eax,%edx
80100880:	0f 84 b4 00 00 00    	je     8010093a <consoleintr+0x15d>
        input.e--;
80100886:	a1 bc 0e 11 80       	mov    0x80110ebc,%eax
8010088b:	83 e8 01             	sub    $0x1,%eax
8010088e:	a3 bc 0e 11 80       	mov    %eax,0x80110ebc
        consputc(BACKSPACE);
80100893:	83 ec 0c             	sub    $0xc,%esp
80100896:	68 00 01 00 00       	push   $0x100
8010089b:	e8 d6 fe ff ff       	call   80100776 <consputc>
801008a0:	83 c4 10             	add    $0x10,%esp
      }
      break;
801008a3:	e9 92 00 00 00       	jmp    8010093a <consoleintr+0x15d>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801008ac:	0f 84 87 00 00 00    	je     80100939 <consoleintr+0x15c>
801008b2:	8b 15 bc 0e 11 80    	mov    0x80110ebc,%edx
801008b8:	a1 b4 0e 11 80       	mov    0x80110eb4,%eax
801008bd:	29 c2                	sub    %eax,%edx
801008bf:	89 d0                	mov    %edx,%eax
801008c1:	83 f8 7f             	cmp    $0x7f,%eax
801008c4:	77 73                	ja     80100939 <consoleintr+0x15c>
        c = (c == '\r') ? '\n' : c;
801008c6:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
801008ca:	74 05                	je     801008d1 <consoleintr+0xf4>
801008cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801008cf:	eb 05                	jmp    801008d6 <consoleintr+0xf9>
801008d1:	b8 0a 00 00 00       	mov    $0xa,%eax
801008d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
801008d9:	a1 bc 0e 11 80       	mov    0x80110ebc,%eax
801008de:	8d 50 01             	lea    0x1(%eax),%edx
801008e1:	89 15 bc 0e 11 80    	mov    %edx,0x80110ebc
801008e7:	83 e0 7f             	and    $0x7f,%eax
801008ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
801008ed:	88 90 34 0e 11 80    	mov    %dl,-0x7feef1cc(%eax)
        consputc(c);
801008f3:	83 ec 0c             	sub    $0xc,%esp
801008f6:	ff 75 f4             	pushl  -0xc(%ebp)
801008f9:	e8 78 fe ff ff       	call   80100776 <consputc>
801008fe:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100901:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
80100905:	74 18                	je     8010091f <consoleintr+0x142>
80100907:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
8010090b:	74 12                	je     8010091f <consoleintr+0x142>
8010090d:	a1 bc 0e 11 80       	mov    0x80110ebc,%eax
80100912:	8b 15 b4 0e 11 80    	mov    0x80110eb4,%edx
80100918:	83 ea 80             	sub    $0xffffff80,%edx
8010091b:	39 d0                	cmp    %edx,%eax
8010091d:	75 1a                	jne    80100939 <consoleintr+0x15c>
          input.w = input.e;
8010091f:	a1 bc 0e 11 80       	mov    0x80110ebc,%eax
80100924:	a3 b8 0e 11 80       	mov    %eax,0x80110eb8
          wakeup(&input.r);
80100929:	83 ec 0c             	sub    $0xc,%esp
8010092c:	68 b4 0e 11 80       	push   $0x80110eb4
80100931:	e8 f9 42 00 00       	call   80104c2f <wakeup>
80100936:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
80100939:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
8010093a:	8b 45 08             	mov    0x8(%ebp),%eax
8010093d:	ff d0                	call   *%eax
8010093f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100942:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100946:	0f 89 ac fe ff ff    	jns    801007f8 <consoleintr+0x1b>
        }
      }
      break;
    }
  }
  release(&input.lock);
8010094c:	83 ec 0c             	sub    $0xc,%esp
8010094f:	68 00 0e 11 80       	push   $0x80110e00
80100954:	e8 4b 45 00 00       	call   80104ea4 <release>
80100959:	83 c4 10             	add    $0x10,%esp
}
8010095c:	90                   	nop
8010095d:	c9                   	leave  
8010095e:	c3                   	ret    

8010095f <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
8010095f:	55                   	push   %ebp
80100960:	89 e5                	mov    %esp,%ebp
80100962:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80100965:	83 ec 0c             	sub    $0xc,%esp
80100968:	ff 75 08             	pushl  0x8(%ebp)
8010096b:	e8 df 10 00 00       	call   80101a4f <iunlock>
80100970:	83 c4 10             	add    $0x10,%esp
  target = n;
80100973:	8b 45 10             	mov    0x10(%ebp),%eax
80100976:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&input.lock);
80100979:	83 ec 0c             	sub    $0xc,%esp
8010097c:	68 00 0e 11 80       	push   $0x80110e00
80100981:	e8 b7 44 00 00       	call   80104e3d <acquire>
80100986:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
80100989:	e9 ac 00 00 00       	jmp    80100a3a <consoleread+0xdb>
    while(input.r == input.w){
      if(proc->killed){
8010098e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100994:	8b 40 24             	mov    0x24(%eax),%eax
80100997:	85 c0                	test   %eax,%eax
80100999:	74 28                	je     801009c3 <consoleread+0x64>
        release(&input.lock);
8010099b:	83 ec 0c             	sub    $0xc,%esp
8010099e:	68 00 0e 11 80       	push   $0x80110e00
801009a3:	e8 fc 44 00 00       	call   80104ea4 <release>
801009a8:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
801009ab:	83 ec 0c             	sub    $0xc,%esp
801009ae:	ff 75 08             	pushl  0x8(%ebp)
801009b1:	e8 41 0f 00 00       	call   801018f7 <ilock>
801009b6:	83 c4 10             	add    $0x10,%esp
        return -1;
801009b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801009be:	e9 ab 00 00 00       	jmp    80100a6e <consoleread+0x10f>
      }
      sleep(&input.r, &input.lock);
801009c3:	83 ec 08             	sub    $0x8,%esp
801009c6:	68 00 0e 11 80       	push   $0x80110e00
801009cb:	68 b4 0e 11 80       	push   $0x80110eb4
801009d0:	e8 6f 41 00 00       	call   80104b44 <sleep>
801009d5:	83 c4 10             	add    $0x10,%esp

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
801009d8:	8b 15 b4 0e 11 80    	mov    0x80110eb4,%edx
801009de:	a1 b8 0e 11 80       	mov    0x80110eb8,%eax
801009e3:	39 c2                	cmp    %eax,%edx
801009e5:	74 a7                	je     8010098e <consoleread+0x2f>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801009e7:	a1 b4 0e 11 80       	mov    0x80110eb4,%eax
801009ec:	8d 50 01             	lea    0x1(%eax),%edx
801009ef:	89 15 b4 0e 11 80    	mov    %edx,0x80110eb4
801009f5:	83 e0 7f             	and    $0x7f,%eax
801009f8:	0f b6 80 34 0e 11 80 	movzbl -0x7feef1cc(%eax),%eax
801009ff:	0f be c0             	movsbl %al,%eax
80100a02:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
80100a05:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100a09:	75 17                	jne    80100a22 <consoleread+0xc3>
      if(n < target){
80100a0b:	8b 45 10             	mov    0x10(%ebp),%eax
80100a0e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100a11:	73 2f                	jae    80100a42 <consoleread+0xe3>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100a13:	a1 b4 0e 11 80       	mov    0x80110eb4,%eax
80100a18:	83 e8 01             	sub    $0x1,%eax
80100a1b:	a3 b4 0e 11 80       	mov    %eax,0x80110eb4
      }
      break;
80100a20:	eb 20                	jmp    80100a42 <consoleread+0xe3>
    }
    *dst++ = c;
80100a22:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a25:	8d 50 01             	lea    0x1(%eax),%edx
80100a28:	89 55 0c             	mov    %edx,0xc(%ebp)
80100a2b:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a2e:	88 10                	mov    %dl,(%eax)
    --n;
80100a30:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100a34:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a38:	74 0b                	je     80100a45 <consoleread+0xe6>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
80100a3a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100a3e:	7f 98                	jg     801009d8 <consoleread+0x79>
80100a40:	eb 04                	jmp    80100a46 <consoleread+0xe7>
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
80100a42:	90                   	nop
80100a43:	eb 01                	jmp    80100a46 <consoleread+0xe7>
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
80100a45:	90                   	nop
  }
  release(&input.lock);
80100a46:	83 ec 0c             	sub    $0xc,%esp
80100a49:	68 00 0e 11 80       	push   $0x80110e00
80100a4e:	e8 51 44 00 00       	call   80104ea4 <release>
80100a53:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100a56:	83 ec 0c             	sub    $0xc,%esp
80100a59:	ff 75 08             	pushl  0x8(%ebp)
80100a5c:	e8 96 0e 00 00       	call   801018f7 <ilock>
80100a61:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100a64:	8b 45 10             	mov    0x10(%ebp),%eax
80100a67:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a6a:	29 c2                	sub    %eax,%edx
80100a6c:	89 d0                	mov    %edx,%eax
}
80100a6e:	c9                   	leave  
80100a6f:	c3                   	ret    

80100a70 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100a70:	55                   	push   %ebp
80100a71:	89 e5                	mov    %esp,%ebp
80100a73:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100a76:	83 ec 0c             	sub    $0xc,%esp
80100a79:	ff 75 08             	pushl  0x8(%ebp)
80100a7c:	e8 ce 0f 00 00       	call   80101a4f <iunlock>
80100a81:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100a84:	83 ec 0c             	sub    $0xc,%esp
80100a87:	68 00 e6 10 80       	push   $0x8010e600
80100a8c:	e8 ac 43 00 00       	call   80104e3d <acquire>
80100a91:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100a94:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a9b:	eb 21                	jmp    80100abe <consolewrite+0x4e>
    consputc(buf[i] & 0xff);
80100a9d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100aa0:	8b 45 0c             	mov    0xc(%ebp),%eax
80100aa3:	01 d0                	add    %edx,%eax
80100aa5:	0f b6 00             	movzbl (%eax),%eax
80100aa8:	0f be c0             	movsbl %al,%eax
80100aab:	0f b6 c0             	movzbl %al,%eax
80100aae:	83 ec 0c             	sub    $0xc,%esp
80100ab1:	50                   	push   %eax
80100ab2:	e8 bf fc ff ff       	call   80100776 <consputc>
80100ab7:	83 c4 10             	add    $0x10,%esp
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100aba:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100abe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ac1:	3b 45 10             	cmp    0x10(%ebp),%eax
80100ac4:	7c d7                	jl     80100a9d <consolewrite+0x2d>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100ac6:	83 ec 0c             	sub    $0xc,%esp
80100ac9:	68 00 e6 10 80       	push   $0x8010e600
80100ace:	e8 d1 43 00 00       	call   80104ea4 <release>
80100ad3:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100ad6:	83 ec 0c             	sub    $0xc,%esp
80100ad9:	ff 75 08             	pushl  0x8(%ebp)
80100adc:	e8 16 0e 00 00       	call   801018f7 <ilock>
80100ae1:	83 c4 10             	add    $0x10,%esp

  return n;
80100ae4:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100ae7:	c9                   	leave  
80100ae8:	c3                   	ret    

80100ae9 <consoleinit>:

void
consoleinit(void)
{
80100ae9:	55                   	push   %ebp
80100aea:	89 e5                	mov    %esp,%ebp
80100aec:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100aef:	83 ec 08             	sub    $0x8,%esp
80100af2:	68 67 b4 10 80       	push   $0x8010b467
80100af7:	68 00 e6 10 80       	push   $0x8010e600
80100afc:	e8 1a 43 00 00       	call   80104e1b <initlock>
80100b01:	83 c4 10             	add    $0x10,%esp
  initlock(&input.lock, "input");
80100b04:	83 ec 08             	sub    $0x8,%esp
80100b07:	68 6f b4 10 80       	push   $0x8010b46f
80100b0c:	68 00 0e 11 80       	push   $0x80110e00
80100b11:	e8 05 43 00 00       	call   80104e1b <initlock>
80100b16:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100b19:	c7 05 6c 18 11 80 70 	movl   $0x80100a70,0x8011186c
80100b20:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b23:	c7 05 68 18 11 80 5f 	movl   $0x8010095f,0x80111868
80100b2a:	09 10 80 
  cons.locking = 1;
80100b2d:	c7 05 34 e6 10 80 01 	movl   $0x1,0x8010e634
80100b34:	00 00 00 

  picenable(IRQ_KBD);
80100b37:	83 ec 0c             	sub    $0xc,%esp
80100b3a:	6a 01                	push   $0x1
80100b3c:	e8 67 32 00 00       	call   80103da8 <picenable>
80100b41:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80100b44:	83 ec 08             	sub    $0x8,%esp
80100b47:	6a 00                	push   $0x0
80100b49:	6a 01                	push   $0x1
80100b4b:	e8 24 20 00 00       	call   80102b74 <ioapicenable>
80100b50:	83 c4 10             	add    $0x10,%esp
}
80100b53:	90                   	nop
80100b54:	c9                   	leave  
80100b55:	c3                   	ret    

80100b56 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b56:	55                   	push   %ebp
80100b57:	89 e5                	mov    %esp,%ebp
80100b59:	81 ec 18 01 00 00    	sub    $0x118,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  if((ip = namei(path)) == 0)
80100b5f:	83 ec 0c             	sub    $0xc,%esp
80100b62:	ff 75 08             	pushl  0x8(%ebp)
80100b65:	e8 94 1a 00 00       	call   801025fe <namei>
80100b6a:	83 c4 10             	add    $0x10,%esp
80100b6d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b70:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b74:	75 0a                	jne    80100b80 <exec+0x2a>
    return -1;
80100b76:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b7b:	e9 c4 03 00 00       	jmp    80100f44 <exec+0x3ee>
  ilock(ip);
80100b80:	83 ec 0c             	sub    $0xc,%esp
80100b83:	ff 75 d8             	pushl  -0x28(%ebp)
80100b86:	e8 6c 0d 00 00       	call   801018f7 <ilock>
80100b8b:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100b8e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100b95:	6a 34                	push   $0x34
80100b97:	6a 00                	push   $0x0
80100b99:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100b9f:	50                   	push   %eax
80100ba0:	ff 75 d8             	pushl  -0x28(%ebp)
80100ba3:	e8 06 14 00 00       	call   80101fae <readi>
80100ba8:	83 c4 10             	add    $0x10,%esp
80100bab:	83 f8 33             	cmp    $0x33,%eax
80100bae:	0f 86 44 03 00 00    	jbe    80100ef8 <exec+0x3a2>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100bb4:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bba:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100bbf:	0f 85 36 03 00 00    	jne    80100efb <exec+0x3a5>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100bc5:	e8 5d 6f 00 00       	call   80107b27 <setupkvm>
80100bca:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100bcd:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100bd1:	0f 84 27 03 00 00    	je     80100efe <exec+0x3a8>
    goto bad;

  // Load program into memory.
  sz = 0;
80100bd7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bde:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100be5:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100beb:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100bee:	e9 ab 00 00 00       	jmp    80100c9e <exec+0x148>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bf3:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100bf6:	6a 20                	push   $0x20
80100bf8:	50                   	push   %eax
80100bf9:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100bff:	50                   	push   %eax
80100c00:	ff 75 d8             	pushl  -0x28(%ebp)
80100c03:	e8 a6 13 00 00       	call   80101fae <readi>
80100c08:	83 c4 10             	add    $0x10,%esp
80100c0b:	83 f8 20             	cmp    $0x20,%eax
80100c0e:	0f 85 ed 02 00 00    	jne    80100f01 <exec+0x3ab>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100c14:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c1a:	83 f8 01             	cmp    $0x1,%eax
80100c1d:	75 71                	jne    80100c90 <exec+0x13a>
      continue;
    if(ph.memsz < ph.filesz)
80100c1f:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100c25:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c2b:	39 c2                	cmp    %eax,%edx
80100c2d:	0f 82 d1 02 00 00    	jb     80100f04 <exec+0x3ae>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c33:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c39:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c3f:	01 d0                	add    %edx,%eax
80100c41:	83 ec 04             	sub    $0x4,%esp
80100c44:	50                   	push   %eax
80100c45:	ff 75 e0             	pushl  -0x20(%ebp)
80100c48:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c4b:	e8 7e 72 00 00       	call   80107ece <allocuvm>
80100c50:	83 c4 10             	add    $0x10,%esp
80100c53:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c56:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100c5a:	0f 84 a7 02 00 00    	je     80100f07 <exec+0x3b1>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c60:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100c66:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c6c:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100c72:	83 ec 0c             	sub    $0xc,%esp
80100c75:	52                   	push   %edx
80100c76:	50                   	push   %eax
80100c77:	ff 75 d8             	pushl  -0x28(%ebp)
80100c7a:	51                   	push   %ecx
80100c7b:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c7e:	e8 74 71 00 00       	call   80107df7 <loaduvm>
80100c83:	83 c4 20             	add    $0x20,%esp
80100c86:	85 c0                	test   %eax,%eax
80100c88:	0f 88 7c 02 00 00    	js     80100f0a <exec+0x3b4>
80100c8e:	eb 01                	jmp    80100c91 <exec+0x13b>
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
80100c90:	90                   	nop
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c91:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100c95:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c98:	83 c0 20             	add    $0x20,%eax
80100c9b:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100c9e:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100ca5:	0f b7 c0             	movzwl %ax,%eax
80100ca8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80100cab:	0f 8f 42 ff ff ff    	jg     80100bf3 <exec+0x9d>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100cb1:	83 ec 0c             	sub    $0xc,%esp
80100cb4:	ff 75 d8             	pushl  -0x28(%ebp)
80100cb7:	e8 f5 0e 00 00       	call   80101bb1 <iunlockput>
80100cbc:	83 c4 10             	add    $0x10,%esp
  ip = 0;
80100cbf:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100cc6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cc9:	05 ff 0f 00 00       	add    $0xfff,%eax
80100cce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100cd3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100cd6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cd9:	05 00 20 00 00       	add    $0x2000,%eax
80100cde:	83 ec 04             	sub    $0x4,%esp
80100ce1:	50                   	push   %eax
80100ce2:	ff 75 e0             	pushl  -0x20(%ebp)
80100ce5:	ff 75 d4             	pushl  -0x2c(%ebp)
80100ce8:	e8 e1 71 00 00       	call   80107ece <allocuvm>
80100ced:	83 c4 10             	add    $0x10,%esp
80100cf0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100cf3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100cf7:	0f 84 10 02 00 00    	je     80100f0d <exec+0x3b7>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cfd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d00:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d05:	83 ec 08             	sub    $0x8,%esp
80100d08:	50                   	push   %eax
80100d09:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d0c:	e8 e3 73 00 00       	call   801080f4 <clearpteu>
80100d11:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100d14:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d17:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d1a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100d21:	e9 96 00 00 00       	jmp    80100dbc <exec+0x266>
    if(argc >= MAXARG)
80100d26:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100d2a:	0f 87 e0 01 00 00    	ja     80100f10 <exec+0x3ba>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d30:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d33:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d3a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d3d:	01 d0                	add    %edx,%eax
80100d3f:	8b 00                	mov    (%eax),%eax
80100d41:	83 ec 0c             	sub    $0xc,%esp
80100d44:	50                   	push   %eax
80100d45:	e8 a3 45 00 00       	call   801052ed <strlen>
80100d4a:	83 c4 10             	add    $0x10,%esp
80100d4d:	89 c2                	mov    %eax,%edx
80100d4f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d52:	29 d0                	sub    %edx,%eax
80100d54:	83 e8 01             	sub    $0x1,%eax
80100d57:	83 e0 fc             	and    $0xfffffffc,%eax
80100d5a:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d5d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d60:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d67:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d6a:	01 d0                	add    %edx,%eax
80100d6c:	8b 00                	mov    (%eax),%eax
80100d6e:	83 ec 0c             	sub    $0xc,%esp
80100d71:	50                   	push   %eax
80100d72:	e8 76 45 00 00       	call   801052ed <strlen>
80100d77:	83 c4 10             	add    $0x10,%esp
80100d7a:	83 c0 01             	add    $0x1,%eax
80100d7d:	89 c1                	mov    %eax,%ecx
80100d7f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d82:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d89:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d8c:	01 d0                	add    %edx,%eax
80100d8e:	8b 00                	mov    (%eax),%eax
80100d90:	51                   	push   %ecx
80100d91:	50                   	push   %eax
80100d92:	ff 75 dc             	pushl  -0x24(%ebp)
80100d95:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d98:	e8 fb 74 00 00       	call   80108298 <copyout>
80100d9d:	83 c4 10             	add    $0x10,%esp
80100da0:	85 c0                	test   %eax,%eax
80100da2:	0f 88 6b 01 00 00    	js     80100f13 <exec+0x3bd>
      goto bad;
    ustack[3+argc] = sp;
80100da8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dab:	8d 50 03             	lea    0x3(%eax),%edx
80100dae:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100db1:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100db8:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100dbc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dbf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dc6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dc9:	01 d0                	add    %edx,%eax
80100dcb:	8b 00                	mov    (%eax),%eax
80100dcd:	85 c0                	test   %eax,%eax
80100dcf:	0f 85 51 ff ff ff    	jne    80100d26 <exec+0x1d0>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100dd5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dd8:	83 c0 03             	add    $0x3,%eax
80100ddb:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100de2:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100de6:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100ded:	ff ff ff 
  ustack[1] = argc;
80100df0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100df3:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100df9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dfc:	83 c0 01             	add    $0x1,%eax
80100dff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e06:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e09:	29 d0                	sub    %edx,%eax
80100e0b:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100e11:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e14:	83 c0 04             	add    $0x4,%eax
80100e17:	c1 e0 02             	shl    $0x2,%eax
80100e1a:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e1d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e20:	83 c0 04             	add    $0x4,%eax
80100e23:	c1 e0 02             	shl    $0x2,%eax
80100e26:	50                   	push   %eax
80100e27:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100e2d:	50                   	push   %eax
80100e2e:	ff 75 dc             	pushl  -0x24(%ebp)
80100e31:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e34:	e8 5f 74 00 00       	call   80108298 <copyout>
80100e39:	83 c4 10             	add    $0x10,%esp
80100e3c:	85 c0                	test   %eax,%eax
80100e3e:	0f 88 d2 00 00 00    	js     80100f16 <exec+0x3c0>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e44:	8b 45 08             	mov    0x8(%ebp),%eax
80100e47:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100e4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100e50:	eb 17                	jmp    80100e69 <exec+0x313>
    if(*s == '/')
80100e52:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e55:	0f b6 00             	movzbl (%eax),%eax
80100e58:	3c 2f                	cmp    $0x2f,%al
80100e5a:	75 09                	jne    80100e65 <exec+0x30f>
      last = s+1;
80100e5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e5f:	83 c0 01             	add    $0x1,%eax
80100e62:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e65:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100e69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e6c:	0f b6 00             	movzbl (%eax),%eax
80100e6f:	84 c0                	test   %al,%al
80100e71:	75 df                	jne    80100e52 <exec+0x2fc>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100e73:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e79:	83 c0 6c             	add    $0x6c,%eax
80100e7c:	83 ec 04             	sub    $0x4,%esp
80100e7f:	6a 10                	push   $0x10
80100e81:	ff 75 f0             	pushl  -0x10(%ebp)
80100e84:	50                   	push   %eax
80100e85:	e8 19 44 00 00       	call   801052a3 <safestrcpy>
80100e8a:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100e8d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e93:	8b 40 04             	mov    0x4(%eax),%eax
80100e96:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100e99:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e9f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100ea2:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100ea5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eab:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100eae:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100eb0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eb6:	8b 40 18             	mov    0x18(%eax),%eax
80100eb9:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100ebf:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100ec2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ec8:	8b 40 18             	mov    0x18(%eax),%eax
80100ecb:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100ece:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100ed1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ed7:	83 ec 0c             	sub    $0xc,%esp
80100eda:	50                   	push   %eax
80100edb:	e8 2e 6d 00 00       	call   80107c0e <switchuvm>
80100ee0:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100ee3:	83 ec 0c             	sub    $0xc,%esp
80100ee6:	ff 75 d0             	pushl  -0x30(%ebp)
80100ee9:	e8 66 71 00 00       	call   80108054 <freevm>
80100eee:	83 c4 10             	add    $0x10,%esp
  return 0;
80100ef1:	b8 00 00 00 00       	mov    $0x0,%eax
80100ef6:	eb 4c                	jmp    80100f44 <exec+0x3ee>
  ilock(ip);
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
80100ef8:	90                   	nop
80100ef9:	eb 1c                	jmp    80100f17 <exec+0x3c1>
  if(elf.magic != ELF_MAGIC)
    goto bad;
80100efb:	90                   	nop
80100efc:	eb 19                	jmp    80100f17 <exec+0x3c1>

  if((pgdir = setupkvm()) == 0)
    goto bad;
80100efe:	90                   	nop
80100eff:	eb 16                	jmp    80100f17 <exec+0x3c1>

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
80100f01:	90                   	nop
80100f02:	eb 13                	jmp    80100f17 <exec+0x3c1>
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
80100f04:	90                   	nop
80100f05:	eb 10                	jmp    80100f17 <exec+0x3c1>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
80100f07:	90                   	nop
80100f08:	eb 0d                	jmp    80100f17 <exec+0x3c1>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
80100f0a:	90                   	nop
80100f0b:	eb 0a                	jmp    80100f17 <exec+0x3c1>

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
80100f0d:	90                   	nop
80100f0e:	eb 07                	jmp    80100f17 <exec+0x3c1>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
80100f10:	90                   	nop
80100f11:	eb 04                	jmp    80100f17 <exec+0x3c1>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
80100f13:	90                   	nop
80100f14:	eb 01                	jmp    80100f17 <exec+0x3c1>
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;
80100f16:	90                   	nop
  switchuvm(proc);
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
80100f17:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100f1b:	74 0e                	je     80100f2b <exec+0x3d5>
    freevm(pgdir);
80100f1d:	83 ec 0c             	sub    $0xc,%esp
80100f20:	ff 75 d4             	pushl  -0x2c(%ebp)
80100f23:	e8 2c 71 00 00       	call   80108054 <freevm>
80100f28:	83 c4 10             	add    $0x10,%esp
  if(ip)
80100f2b:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100f2f:	74 0e                	je     80100f3f <exec+0x3e9>
    iunlockput(ip);
80100f31:	83 ec 0c             	sub    $0xc,%esp
80100f34:	ff 75 d8             	pushl  -0x28(%ebp)
80100f37:	e8 75 0c 00 00       	call   80101bb1 <iunlockput>
80100f3c:	83 c4 10             	add    $0x10,%esp
  return -1;
80100f3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f44:	c9                   	leave  
80100f45:	c3                   	ret    

80100f46 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f46:	55                   	push   %ebp
80100f47:	89 e5                	mov    %esp,%ebp
80100f49:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
80100f4c:	83 ec 08             	sub    $0x8,%esp
80100f4f:	68 75 b4 10 80       	push   $0x8010b475
80100f54:	68 c0 0e 11 80       	push   $0x80110ec0
80100f59:	e8 bd 3e 00 00       	call   80104e1b <initlock>
80100f5e:	83 c4 10             	add    $0x10,%esp
}
80100f61:	90                   	nop
80100f62:	c9                   	leave  
80100f63:	c3                   	ret    

80100f64 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f64:	55                   	push   %ebp
80100f65:	89 e5                	mov    %esp,%ebp
80100f67:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
80100f6a:	83 ec 0c             	sub    $0xc,%esp
80100f6d:	68 c0 0e 11 80       	push   $0x80110ec0
80100f72:	e8 c6 3e 00 00       	call   80104e3d <acquire>
80100f77:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f7a:	c7 45 f4 f4 0e 11 80 	movl   $0x80110ef4,-0xc(%ebp)
80100f81:	eb 2d                	jmp    80100fb0 <filealloc+0x4c>
    if(f->ref == 0){
80100f83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f86:	8b 40 04             	mov    0x4(%eax),%eax
80100f89:	85 c0                	test   %eax,%eax
80100f8b:	75 1f                	jne    80100fac <filealloc+0x48>
      f->ref = 1;
80100f8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f90:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80100f97:	83 ec 0c             	sub    $0xc,%esp
80100f9a:	68 c0 0e 11 80       	push   $0x80110ec0
80100f9f:	e8 00 3f 00 00       	call   80104ea4 <release>
80100fa4:	83 c4 10             	add    $0x10,%esp
      return f;
80100fa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100faa:	eb 23                	jmp    80100fcf <filealloc+0x6b>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100fac:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100fb0:	b8 54 18 11 80       	mov    $0x80111854,%eax
80100fb5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100fb8:	72 c9                	jb     80100f83 <filealloc+0x1f>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100fba:	83 ec 0c             	sub    $0xc,%esp
80100fbd:	68 c0 0e 11 80       	push   $0x80110ec0
80100fc2:	e8 dd 3e 00 00       	call   80104ea4 <release>
80100fc7:	83 c4 10             	add    $0x10,%esp
  return 0;
80100fca:	b8 00 00 00 00       	mov    $0x0,%eax
}
80100fcf:	c9                   	leave  
80100fd0:	c3                   	ret    

80100fd1 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100fd1:	55                   	push   %ebp
80100fd2:	89 e5                	mov    %esp,%ebp
80100fd4:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
80100fd7:	83 ec 0c             	sub    $0xc,%esp
80100fda:	68 c0 0e 11 80       	push   $0x80110ec0
80100fdf:	e8 59 3e 00 00       	call   80104e3d <acquire>
80100fe4:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80100fe7:	8b 45 08             	mov    0x8(%ebp),%eax
80100fea:	8b 40 04             	mov    0x4(%eax),%eax
80100fed:	85 c0                	test   %eax,%eax
80100fef:	7f 0d                	jg     80100ffe <filedup+0x2d>
    panic("filedup");
80100ff1:	83 ec 0c             	sub    $0xc,%esp
80100ff4:	68 7c b4 10 80       	push   $0x8010b47c
80100ff9:	e8 68 f5 ff ff       	call   80100566 <panic>
  f->ref++;
80100ffe:	8b 45 08             	mov    0x8(%ebp),%eax
80101001:	8b 40 04             	mov    0x4(%eax),%eax
80101004:	8d 50 01             	lea    0x1(%eax),%edx
80101007:	8b 45 08             	mov    0x8(%ebp),%eax
8010100a:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
8010100d:	83 ec 0c             	sub    $0xc,%esp
80101010:	68 c0 0e 11 80       	push   $0x80110ec0
80101015:	e8 8a 3e 00 00       	call   80104ea4 <release>
8010101a:	83 c4 10             	add    $0x10,%esp
  return f;
8010101d:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101020:	c9                   	leave  
80101021:	c3                   	ret    

80101022 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101022:	55                   	push   %ebp
80101023:	89 e5                	mov    %esp,%ebp
80101025:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  acquire(&ftable.lock);
80101028:	83 ec 0c             	sub    $0xc,%esp
8010102b:	68 c0 0e 11 80       	push   $0x80110ec0
80101030:	e8 08 3e 00 00       	call   80104e3d <acquire>
80101035:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101038:	8b 45 08             	mov    0x8(%ebp),%eax
8010103b:	8b 40 04             	mov    0x4(%eax),%eax
8010103e:	85 c0                	test   %eax,%eax
80101040:	7f 0d                	jg     8010104f <fileclose+0x2d>
    panic("fileclose");
80101042:	83 ec 0c             	sub    $0xc,%esp
80101045:	68 84 b4 10 80       	push   $0x8010b484
8010104a:	e8 17 f5 ff ff       	call   80100566 <panic>
  if(--f->ref > 0){
8010104f:	8b 45 08             	mov    0x8(%ebp),%eax
80101052:	8b 40 04             	mov    0x4(%eax),%eax
80101055:	8d 50 ff             	lea    -0x1(%eax),%edx
80101058:	8b 45 08             	mov    0x8(%ebp),%eax
8010105b:	89 50 04             	mov    %edx,0x4(%eax)
8010105e:	8b 45 08             	mov    0x8(%ebp),%eax
80101061:	8b 40 04             	mov    0x4(%eax),%eax
80101064:	85 c0                	test   %eax,%eax
80101066:	7e 15                	jle    8010107d <fileclose+0x5b>
    release(&ftable.lock);
80101068:	83 ec 0c             	sub    $0xc,%esp
8010106b:	68 c0 0e 11 80       	push   $0x80110ec0
80101070:	e8 2f 3e 00 00       	call   80104ea4 <release>
80101075:	83 c4 10             	add    $0x10,%esp
80101078:	e9 8b 00 00 00       	jmp    80101108 <fileclose+0xe6>
    return;
  }
  ff = *f;
8010107d:	8b 45 08             	mov    0x8(%ebp),%eax
80101080:	8b 10                	mov    (%eax),%edx
80101082:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101085:	8b 50 04             	mov    0x4(%eax),%edx
80101088:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010108b:	8b 50 08             	mov    0x8(%eax),%edx
8010108e:	89 55 e8             	mov    %edx,-0x18(%ebp)
80101091:	8b 50 0c             	mov    0xc(%eax),%edx
80101094:	89 55 ec             	mov    %edx,-0x14(%ebp)
80101097:	8b 50 10             	mov    0x10(%eax),%edx
8010109a:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010109d:	8b 40 14             	mov    0x14(%eax),%eax
801010a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
801010a3:	8b 45 08             	mov    0x8(%ebp),%eax
801010a6:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
801010ad:	8b 45 08             	mov    0x8(%ebp),%eax
801010b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
801010b6:	83 ec 0c             	sub    $0xc,%esp
801010b9:	68 c0 0e 11 80       	push   $0x80110ec0
801010be:	e8 e1 3d 00 00       	call   80104ea4 <release>
801010c3:	83 c4 10             	add    $0x10,%esp
  
  if(ff.type == FD_PIPE)
801010c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010c9:	83 f8 01             	cmp    $0x1,%eax
801010cc:	75 19                	jne    801010e7 <fileclose+0xc5>
    pipeclose(ff.pipe, ff.writable);
801010ce:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
801010d2:	0f be d0             	movsbl %al,%edx
801010d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801010d8:	83 ec 08             	sub    $0x8,%esp
801010db:	52                   	push   %edx
801010dc:	50                   	push   %eax
801010dd:	e8 2f 2f 00 00       	call   80104011 <pipeclose>
801010e2:	83 c4 10             	add    $0x10,%esp
801010e5:	eb 21                	jmp    80101108 <fileclose+0xe6>
  else if(ff.type == FD_INODE){
801010e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010ea:	83 f8 02             	cmp    $0x2,%eax
801010ed:	75 19                	jne    80101108 <fileclose+0xe6>
    begin_trans();
801010ef:	e8 ef 23 00 00       	call   801034e3 <begin_trans>
    iput(ff.ip);
801010f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801010f7:	83 ec 0c             	sub    $0xc,%esp
801010fa:	50                   	push   %eax
801010fb:	e8 c1 09 00 00       	call   80101ac1 <iput>
80101100:	83 c4 10             	add    $0x10,%esp
    commit_trans();
80101103:	e8 2e 24 00 00       	call   80103536 <commit_trans>
  }
}
80101108:	c9                   	leave  
80101109:	c3                   	ret    

8010110a <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
8010110a:	55                   	push   %ebp
8010110b:	89 e5                	mov    %esp,%ebp
8010110d:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
80101110:	8b 45 08             	mov    0x8(%ebp),%eax
80101113:	8b 00                	mov    (%eax),%eax
80101115:	83 f8 02             	cmp    $0x2,%eax
80101118:	75 40                	jne    8010115a <filestat+0x50>
    ilock(f->ip);
8010111a:	8b 45 08             	mov    0x8(%ebp),%eax
8010111d:	8b 40 10             	mov    0x10(%eax),%eax
80101120:	83 ec 0c             	sub    $0xc,%esp
80101123:	50                   	push   %eax
80101124:	e8 ce 07 00 00       	call   801018f7 <ilock>
80101129:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
8010112c:	8b 45 08             	mov    0x8(%ebp),%eax
8010112f:	8b 40 10             	mov    0x10(%eax),%eax
80101132:	83 ec 08             	sub    $0x8,%esp
80101135:	ff 75 0c             	pushl  0xc(%ebp)
80101138:	50                   	push   %eax
80101139:	e8 2a 0e 00 00       	call   80101f68 <stati>
8010113e:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
80101141:	8b 45 08             	mov    0x8(%ebp),%eax
80101144:	8b 40 10             	mov    0x10(%eax),%eax
80101147:	83 ec 0c             	sub    $0xc,%esp
8010114a:	50                   	push   %eax
8010114b:	e8 ff 08 00 00       	call   80101a4f <iunlock>
80101150:	83 c4 10             	add    $0x10,%esp
    return 0;
80101153:	b8 00 00 00 00       	mov    $0x0,%eax
80101158:	eb 05                	jmp    8010115f <filestat+0x55>
  }
  return -1;
8010115a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010115f:	c9                   	leave  
80101160:	c3                   	ret    

80101161 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101161:	55                   	push   %ebp
80101162:	89 e5                	mov    %esp,%ebp
80101164:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
80101167:	8b 45 08             	mov    0x8(%ebp),%eax
8010116a:	0f b6 40 08          	movzbl 0x8(%eax),%eax
8010116e:	84 c0                	test   %al,%al
80101170:	75 0a                	jne    8010117c <fileread+0x1b>
    return -1;
80101172:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101177:	e9 9b 00 00 00       	jmp    80101217 <fileread+0xb6>
  if(f->type == FD_PIPE)
8010117c:	8b 45 08             	mov    0x8(%ebp),%eax
8010117f:	8b 00                	mov    (%eax),%eax
80101181:	83 f8 01             	cmp    $0x1,%eax
80101184:	75 1a                	jne    801011a0 <fileread+0x3f>
    return piperead(f->pipe, addr, n);
80101186:	8b 45 08             	mov    0x8(%ebp),%eax
80101189:	8b 40 0c             	mov    0xc(%eax),%eax
8010118c:	83 ec 04             	sub    $0x4,%esp
8010118f:	ff 75 10             	pushl  0x10(%ebp)
80101192:	ff 75 0c             	pushl  0xc(%ebp)
80101195:	50                   	push   %eax
80101196:	e8 1e 30 00 00       	call   801041b9 <piperead>
8010119b:	83 c4 10             	add    $0x10,%esp
8010119e:	eb 77                	jmp    80101217 <fileread+0xb6>
  if(f->type == FD_INODE){
801011a0:	8b 45 08             	mov    0x8(%ebp),%eax
801011a3:	8b 00                	mov    (%eax),%eax
801011a5:	83 f8 02             	cmp    $0x2,%eax
801011a8:	75 60                	jne    8010120a <fileread+0xa9>
    ilock(f->ip);
801011aa:	8b 45 08             	mov    0x8(%ebp),%eax
801011ad:	8b 40 10             	mov    0x10(%eax),%eax
801011b0:	83 ec 0c             	sub    $0xc,%esp
801011b3:	50                   	push   %eax
801011b4:	e8 3e 07 00 00       	call   801018f7 <ilock>
801011b9:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801011bc:	8b 4d 10             	mov    0x10(%ebp),%ecx
801011bf:	8b 45 08             	mov    0x8(%ebp),%eax
801011c2:	8b 50 14             	mov    0x14(%eax),%edx
801011c5:	8b 45 08             	mov    0x8(%ebp),%eax
801011c8:	8b 40 10             	mov    0x10(%eax),%eax
801011cb:	51                   	push   %ecx
801011cc:	52                   	push   %edx
801011cd:	ff 75 0c             	pushl  0xc(%ebp)
801011d0:	50                   	push   %eax
801011d1:	e8 d8 0d 00 00       	call   80101fae <readi>
801011d6:	83 c4 10             	add    $0x10,%esp
801011d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801011dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801011e0:	7e 11                	jle    801011f3 <fileread+0x92>
      f->off += r;
801011e2:	8b 45 08             	mov    0x8(%ebp),%eax
801011e5:	8b 50 14             	mov    0x14(%eax),%edx
801011e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011eb:	01 c2                	add    %eax,%edx
801011ed:	8b 45 08             	mov    0x8(%ebp),%eax
801011f0:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
801011f3:	8b 45 08             	mov    0x8(%ebp),%eax
801011f6:	8b 40 10             	mov    0x10(%eax),%eax
801011f9:	83 ec 0c             	sub    $0xc,%esp
801011fc:	50                   	push   %eax
801011fd:	e8 4d 08 00 00       	call   80101a4f <iunlock>
80101202:	83 c4 10             	add    $0x10,%esp
    return r;
80101205:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101208:	eb 0d                	jmp    80101217 <fileread+0xb6>
  }
  panic("fileread");
8010120a:	83 ec 0c             	sub    $0xc,%esp
8010120d:	68 8e b4 10 80       	push   $0x8010b48e
80101212:	e8 4f f3 ff ff       	call   80100566 <panic>
}
80101217:	c9                   	leave  
80101218:	c3                   	ret    

80101219 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101219:	55                   	push   %ebp
8010121a:	89 e5                	mov    %esp,%ebp
8010121c:	53                   	push   %ebx
8010121d:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
80101220:	8b 45 08             	mov    0x8(%ebp),%eax
80101223:	0f b6 40 09          	movzbl 0x9(%eax),%eax
80101227:	84 c0                	test   %al,%al
80101229:	75 0a                	jne    80101235 <filewrite+0x1c>
    return -1;
8010122b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101230:	e9 1b 01 00 00       	jmp    80101350 <filewrite+0x137>
  if(f->type == FD_PIPE)
80101235:	8b 45 08             	mov    0x8(%ebp),%eax
80101238:	8b 00                	mov    (%eax),%eax
8010123a:	83 f8 01             	cmp    $0x1,%eax
8010123d:	75 1d                	jne    8010125c <filewrite+0x43>
    return pipewrite(f->pipe, addr, n);
8010123f:	8b 45 08             	mov    0x8(%ebp),%eax
80101242:	8b 40 0c             	mov    0xc(%eax),%eax
80101245:	83 ec 04             	sub    $0x4,%esp
80101248:	ff 75 10             	pushl  0x10(%ebp)
8010124b:	ff 75 0c             	pushl  0xc(%ebp)
8010124e:	50                   	push   %eax
8010124f:	e8 67 2e 00 00       	call   801040bb <pipewrite>
80101254:	83 c4 10             	add    $0x10,%esp
80101257:	e9 f4 00 00 00       	jmp    80101350 <filewrite+0x137>
  if(f->type == FD_INODE){
8010125c:	8b 45 08             	mov    0x8(%ebp),%eax
8010125f:	8b 00                	mov    (%eax),%eax
80101261:	83 f8 02             	cmp    $0x2,%eax
80101264:	0f 85 d9 00 00 00    	jne    80101343 <filewrite+0x12a>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
8010126a:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
80101271:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
80101278:	e9 a3 00 00 00       	jmp    80101320 <filewrite+0x107>
      int n1 = n - i;
8010127d:	8b 45 10             	mov    0x10(%ebp),%eax
80101280:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101283:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
80101286:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101289:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010128c:	7e 06                	jle    80101294 <filewrite+0x7b>
        n1 = max;
8010128e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101291:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_trans();
80101294:	e8 4a 22 00 00       	call   801034e3 <begin_trans>
      ilock(f->ip);
80101299:	8b 45 08             	mov    0x8(%ebp),%eax
8010129c:	8b 40 10             	mov    0x10(%eax),%eax
8010129f:	83 ec 0c             	sub    $0xc,%esp
801012a2:	50                   	push   %eax
801012a3:	e8 4f 06 00 00       	call   801018f7 <ilock>
801012a8:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801012ab:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801012ae:	8b 45 08             	mov    0x8(%ebp),%eax
801012b1:	8b 50 14             	mov    0x14(%eax),%edx
801012b4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801012b7:	8b 45 0c             	mov    0xc(%ebp),%eax
801012ba:	01 c3                	add    %eax,%ebx
801012bc:	8b 45 08             	mov    0x8(%ebp),%eax
801012bf:	8b 40 10             	mov    0x10(%eax),%eax
801012c2:	51                   	push   %ecx
801012c3:	52                   	push   %edx
801012c4:	53                   	push   %ebx
801012c5:	50                   	push   %eax
801012c6:	e8 3a 0e 00 00       	call   80102105 <writei>
801012cb:	83 c4 10             	add    $0x10,%esp
801012ce:	89 45 e8             	mov    %eax,-0x18(%ebp)
801012d1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801012d5:	7e 11                	jle    801012e8 <filewrite+0xcf>
        f->off += r;
801012d7:	8b 45 08             	mov    0x8(%ebp),%eax
801012da:	8b 50 14             	mov    0x14(%eax),%edx
801012dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012e0:	01 c2                	add    %eax,%edx
801012e2:	8b 45 08             	mov    0x8(%ebp),%eax
801012e5:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
801012e8:	8b 45 08             	mov    0x8(%ebp),%eax
801012eb:	8b 40 10             	mov    0x10(%eax),%eax
801012ee:	83 ec 0c             	sub    $0xc,%esp
801012f1:	50                   	push   %eax
801012f2:	e8 58 07 00 00       	call   80101a4f <iunlock>
801012f7:	83 c4 10             	add    $0x10,%esp
      commit_trans();
801012fa:	e8 37 22 00 00       	call   80103536 <commit_trans>

      if(r < 0)
801012ff:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101303:	78 29                	js     8010132e <filewrite+0x115>
        break;
      if(r != n1)
80101305:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101308:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010130b:	74 0d                	je     8010131a <filewrite+0x101>
        panic("short filewrite");
8010130d:	83 ec 0c             	sub    $0xc,%esp
80101310:	68 97 b4 10 80       	push   $0x8010b497
80101315:	e8 4c f2 ff ff       	call   80100566 <panic>
      i += r;
8010131a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010131d:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101320:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101323:	3b 45 10             	cmp    0x10(%ebp),%eax
80101326:	0f 8c 51 ff ff ff    	jl     8010127d <filewrite+0x64>
8010132c:	eb 01                	jmp    8010132f <filewrite+0x116>
        f->off += r;
      iunlock(f->ip);
      commit_trans();

      if(r < 0)
        break;
8010132e:	90                   	nop
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
8010132f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101332:	3b 45 10             	cmp    0x10(%ebp),%eax
80101335:	75 05                	jne    8010133c <filewrite+0x123>
80101337:	8b 45 10             	mov    0x10(%ebp),%eax
8010133a:	eb 14                	jmp    80101350 <filewrite+0x137>
8010133c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101341:	eb 0d                	jmp    80101350 <filewrite+0x137>
  }
  panic("filewrite");
80101343:	83 ec 0c             	sub    $0xc,%esp
80101346:	68 a7 b4 10 80       	push   $0x8010b4a7
8010134b:	e8 16 f2 ff ff       	call   80100566 <panic>
}
80101350:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101353:	c9                   	leave  
80101354:	c3                   	ret    

80101355 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101355:	55                   	push   %ebp
80101356:	89 e5                	mov    %esp,%ebp
80101358:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
8010135b:	8b 45 08             	mov    0x8(%ebp),%eax
8010135e:	83 ec 08             	sub    $0x8,%esp
80101361:	6a 01                	push   $0x1
80101363:	50                   	push   %eax
80101364:	e8 4d ee ff ff       	call   801001b6 <bread>
80101369:	83 c4 10             	add    $0x10,%esp
8010136c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
8010136f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101372:	83 c0 18             	add    $0x18,%eax
80101375:	83 ec 04             	sub    $0x4,%esp
80101378:	6a 10                	push   $0x10
8010137a:	50                   	push   %eax
8010137b:	ff 75 0c             	pushl  0xc(%ebp)
8010137e:	e8 dc 3d 00 00       	call   8010515f <memmove>
80101383:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101386:	83 ec 0c             	sub    $0xc,%esp
80101389:	ff 75 f4             	pushl  -0xc(%ebp)
8010138c:	e8 9d ee ff ff       	call   8010022e <brelse>
80101391:	83 c4 10             	add    $0x10,%esp
}
80101394:	90                   	nop
80101395:	c9                   	leave  
80101396:	c3                   	ret    

80101397 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
80101397:	55                   	push   %ebp
80101398:	89 e5                	mov    %esp,%ebp
8010139a:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
8010139d:	8b 55 0c             	mov    0xc(%ebp),%edx
801013a0:	8b 45 08             	mov    0x8(%ebp),%eax
801013a3:	83 ec 08             	sub    $0x8,%esp
801013a6:	52                   	push   %edx
801013a7:	50                   	push   %eax
801013a8:	e8 09 ee ff ff       	call   801001b6 <bread>
801013ad:	83 c4 10             	add    $0x10,%esp
801013b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
801013b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013b6:	83 c0 18             	add    $0x18,%eax
801013b9:	83 ec 04             	sub    $0x4,%esp
801013bc:	68 00 02 00 00       	push   $0x200
801013c1:	6a 00                	push   $0x0
801013c3:	50                   	push   %eax
801013c4:	e8 d7 3c 00 00       	call   801050a0 <memset>
801013c9:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801013cc:	83 ec 0c             	sub    $0xc,%esp
801013cf:	ff 75 f4             	pushl  -0xc(%ebp)
801013d2:	e8 c4 21 00 00       	call   8010359b <log_write>
801013d7:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801013da:	83 ec 0c             	sub    $0xc,%esp
801013dd:	ff 75 f4             	pushl  -0xc(%ebp)
801013e0:	e8 49 ee ff ff       	call   8010022e <brelse>
801013e5:	83 c4 10             	add    $0x10,%esp
}
801013e8:	90                   	nop
801013e9:	c9                   	leave  
801013ea:	c3                   	ret    

801013eb <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801013eb:	55                   	push   %ebp
801013ec:	89 e5                	mov    %esp,%ebp
801013ee:	83 ec 28             	sub    $0x28,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
801013f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  readsb(dev, &sb);
801013f8:	8b 45 08             	mov    0x8(%ebp),%eax
801013fb:	83 ec 08             	sub    $0x8,%esp
801013fe:	8d 55 d8             	lea    -0x28(%ebp),%edx
80101401:	52                   	push   %edx
80101402:	50                   	push   %eax
80101403:	e8 4d ff ff ff       	call   80101355 <readsb>
80101408:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
8010140b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101412:	e9 15 01 00 00       	jmp    8010152c <balloc+0x141>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
80101417:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010141a:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80101420:	85 c0                	test   %eax,%eax
80101422:	0f 48 c2             	cmovs  %edx,%eax
80101425:	c1 f8 0c             	sar    $0xc,%eax
80101428:	89 c2                	mov    %eax,%edx
8010142a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010142d:	c1 e8 03             	shr    $0x3,%eax
80101430:	01 d0                	add    %edx,%eax
80101432:	83 c0 03             	add    $0x3,%eax
80101435:	83 ec 08             	sub    $0x8,%esp
80101438:	50                   	push   %eax
80101439:	ff 75 08             	pushl  0x8(%ebp)
8010143c:	e8 75 ed ff ff       	call   801001b6 <bread>
80101441:	83 c4 10             	add    $0x10,%esp
80101444:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101447:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010144e:	e9 a6 00 00 00       	jmp    801014f9 <balloc+0x10e>
      m = 1 << (bi % 8);
80101453:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101456:	99                   	cltd   
80101457:	c1 ea 1d             	shr    $0x1d,%edx
8010145a:	01 d0                	add    %edx,%eax
8010145c:	83 e0 07             	and    $0x7,%eax
8010145f:	29 d0                	sub    %edx,%eax
80101461:	ba 01 00 00 00       	mov    $0x1,%edx
80101466:	89 c1                	mov    %eax,%ecx
80101468:	d3 e2                	shl    %cl,%edx
8010146a:	89 d0                	mov    %edx,%eax
8010146c:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010146f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101472:	8d 50 07             	lea    0x7(%eax),%edx
80101475:	85 c0                	test   %eax,%eax
80101477:	0f 48 c2             	cmovs  %edx,%eax
8010147a:	c1 f8 03             	sar    $0x3,%eax
8010147d:	89 c2                	mov    %eax,%edx
8010147f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101482:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
80101487:	0f b6 c0             	movzbl %al,%eax
8010148a:	23 45 e8             	and    -0x18(%ebp),%eax
8010148d:	85 c0                	test   %eax,%eax
8010148f:	75 64                	jne    801014f5 <balloc+0x10a>
        bp->data[bi/8] |= m;  // Mark block in use.
80101491:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101494:	8d 50 07             	lea    0x7(%eax),%edx
80101497:	85 c0                	test   %eax,%eax
80101499:	0f 48 c2             	cmovs  %edx,%eax
8010149c:	c1 f8 03             	sar    $0x3,%eax
8010149f:	8b 55 ec             	mov    -0x14(%ebp),%edx
801014a2:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801014a7:	89 d1                	mov    %edx,%ecx
801014a9:	8b 55 e8             	mov    -0x18(%ebp),%edx
801014ac:	09 ca                	or     %ecx,%edx
801014ae:	89 d1                	mov    %edx,%ecx
801014b0:	8b 55 ec             	mov    -0x14(%ebp),%edx
801014b3:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
801014b7:	83 ec 0c             	sub    $0xc,%esp
801014ba:	ff 75 ec             	pushl  -0x14(%ebp)
801014bd:	e8 d9 20 00 00       	call   8010359b <log_write>
801014c2:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
801014c5:	83 ec 0c             	sub    $0xc,%esp
801014c8:	ff 75 ec             	pushl  -0x14(%ebp)
801014cb:	e8 5e ed ff ff       	call   8010022e <brelse>
801014d0:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
801014d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014d9:	01 c2                	add    %eax,%edx
801014db:	8b 45 08             	mov    0x8(%ebp),%eax
801014de:	83 ec 08             	sub    $0x8,%esp
801014e1:	52                   	push   %edx
801014e2:	50                   	push   %eax
801014e3:	e8 af fe ff ff       	call   80101397 <bzero>
801014e8:	83 c4 10             	add    $0x10,%esp
        return b + bi;
801014eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014f1:	01 d0                	add    %edx,%eax
801014f3:	eb 52                	jmp    80101547 <balloc+0x15c>

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014f5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801014f9:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
80101500:	7f 15                	jg     80101517 <balloc+0x12c>
80101502:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101505:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101508:	01 d0                	add    %edx,%eax
8010150a:	89 c2                	mov    %eax,%edx
8010150c:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010150f:	39 c2                	cmp    %eax,%edx
80101511:	0f 82 3c ff ff ff    	jb     80101453 <balloc+0x68>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101517:	83 ec 0c             	sub    $0xc,%esp
8010151a:	ff 75 ec             	pushl  -0x14(%ebp)
8010151d:	e8 0c ed ff ff       	call   8010022e <brelse>
80101522:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
80101525:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010152c:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010152f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101532:	39 c2                	cmp    %eax,%edx
80101534:	0f 87 dd fe ff ff    	ja     80101417 <balloc+0x2c>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010153a:	83 ec 0c             	sub    $0xc,%esp
8010153d:	68 b1 b4 10 80       	push   $0x8010b4b1
80101542:	e8 1f f0 ff ff       	call   80100566 <panic>
}
80101547:	c9                   	leave  
80101548:	c3                   	ret    

80101549 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101549:	55                   	push   %ebp
8010154a:	89 e5                	mov    %esp,%ebp
8010154c:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  readsb(dev, &sb);
8010154f:	83 ec 08             	sub    $0x8,%esp
80101552:	8d 45 dc             	lea    -0x24(%ebp),%eax
80101555:	50                   	push   %eax
80101556:	ff 75 08             	pushl  0x8(%ebp)
80101559:	e8 f7 fd ff ff       	call   80101355 <readsb>
8010155e:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb.ninodes));
80101561:	8b 45 0c             	mov    0xc(%ebp),%eax
80101564:	c1 e8 0c             	shr    $0xc,%eax
80101567:	89 c2                	mov    %eax,%edx
80101569:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010156c:	c1 e8 03             	shr    $0x3,%eax
8010156f:	01 d0                	add    %edx,%eax
80101571:	8d 50 03             	lea    0x3(%eax),%edx
80101574:	8b 45 08             	mov    0x8(%ebp),%eax
80101577:	83 ec 08             	sub    $0x8,%esp
8010157a:	52                   	push   %edx
8010157b:	50                   	push   %eax
8010157c:	e8 35 ec ff ff       	call   801001b6 <bread>
80101581:	83 c4 10             	add    $0x10,%esp
80101584:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101587:	8b 45 0c             	mov    0xc(%ebp),%eax
8010158a:	25 ff 0f 00 00       	and    $0xfff,%eax
8010158f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80101592:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101595:	99                   	cltd   
80101596:	c1 ea 1d             	shr    $0x1d,%edx
80101599:	01 d0                	add    %edx,%eax
8010159b:	83 e0 07             	and    $0x7,%eax
8010159e:	29 d0                	sub    %edx,%eax
801015a0:	ba 01 00 00 00       	mov    $0x1,%edx
801015a5:	89 c1                	mov    %eax,%ecx
801015a7:	d3 e2                	shl    %cl,%edx
801015a9:	89 d0                	mov    %edx,%eax
801015ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
801015ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015b1:	8d 50 07             	lea    0x7(%eax),%edx
801015b4:	85 c0                	test   %eax,%eax
801015b6:	0f 48 c2             	cmovs  %edx,%eax
801015b9:	c1 f8 03             	sar    $0x3,%eax
801015bc:	89 c2                	mov    %eax,%edx
801015be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015c1:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
801015c6:	0f b6 c0             	movzbl %al,%eax
801015c9:	23 45 ec             	and    -0x14(%ebp),%eax
801015cc:	85 c0                	test   %eax,%eax
801015ce:	75 0d                	jne    801015dd <bfree+0x94>
    panic("freeing free block");
801015d0:	83 ec 0c             	sub    $0xc,%esp
801015d3:	68 c7 b4 10 80       	push   $0x8010b4c7
801015d8:	e8 89 ef ff ff       	call   80100566 <panic>
  bp->data[bi/8] &= ~m;
801015dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015e0:	8d 50 07             	lea    0x7(%eax),%edx
801015e3:	85 c0                	test   %eax,%eax
801015e5:	0f 48 c2             	cmovs  %edx,%eax
801015e8:	c1 f8 03             	sar    $0x3,%eax
801015eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015ee:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801015f3:	89 d1                	mov    %edx,%ecx
801015f5:	8b 55 ec             	mov    -0x14(%ebp),%edx
801015f8:	f7 d2                	not    %edx
801015fa:	21 ca                	and    %ecx,%edx
801015fc:	89 d1                	mov    %edx,%ecx
801015fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101601:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
80101605:	83 ec 0c             	sub    $0xc,%esp
80101608:	ff 75 f4             	pushl  -0xc(%ebp)
8010160b:	e8 8b 1f 00 00       	call   8010359b <log_write>
80101610:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101613:	83 ec 0c             	sub    $0xc,%esp
80101616:	ff 75 f4             	pushl  -0xc(%ebp)
80101619:	e8 10 ec ff ff       	call   8010022e <brelse>
8010161e:	83 c4 10             	add    $0x10,%esp
}
80101621:	90                   	nop
80101622:	c9                   	leave  
80101623:	c3                   	ret    

80101624 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
80101624:	55                   	push   %ebp
80101625:	89 e5                	mov    %esp,%ebp
80101627:	83 ec 08             	sub    $0x8,%esp
  initlock(&icache.lock, "icache");
8010162a:	83 ec 08             	sub    $0x8,%esp
8010162d:	68 da b4 10 80       	push   $0x8010b4da
80101632:	68 c0 18 11 80       	push   $0x801118c0
80101637:	e8 df 37 00 00       	call   80104e1b <initlock>
8010163c:	83 c4 10             	add    $0x10,%esp
}
8010163f:	90                   	nop
80101640:	c9                   	leave  
80101641:	c3                   	ret    

80101642 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101642:	55                   	push   %ebp
80101643:	89 e5                	mov    %esp,%ebp
80101645:	83 ec 38             	sub    $0x38,%esp
80101648:	8b 45 0c             	mov    0xc(%ebp),%eax
8010164b:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
8010164f:	8b 45 08             	mov    0x8(%ebp),%eax
80101652:	83 ec 08             	sub    $0x8,%esp
80101655:	8d 55 dc             	lea    -0x24(%ebp),%edx
80101658:	52                   	push   %edx
80101659:	50                   	push   %eax
8010165a:	e8 f6 fc ff ff       	call   80101355 <readsb>
8010165f:	83 c4 10             	add    $0x10,%esp

  for(inum = 1; inum < sb.ninodes; inum++){
80101662:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80101669:	e9 98 00 00 00       	jmp    80101706 <ialloc+0xc4>
    bp = bread(dev, IBLOCK(inum));
8010166e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101671:	c1 e8 03             	shr    $0x3,%eax
80101674:	83 c0 02             	add    $0x2,%eax
80101677:	83 ec 08             	sub    $0x8,%esp
8010167a:	50                   	push   %eax
8010167b:	ff 75 08             	pushl  0x8(%ebp)
8010167e:	e8 33 eb ff ff       	call   801001b6 <bread>
80101683:	83 c4 10             	add    $0x10,%esp
80101686:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
80101689:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010168c:	8d 50 18             	lea    0x18(%eax),%edx
8010168f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101692:	83 e0 07             	and    $0x7,%eax
80101695:	c1 e0 06             	shl    $0x6,%eax
80101698:	01 d0                	add    %edx,%eax
8010169a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
8010169d:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016a0:	0f b7 00             	movzwl (%eax),%eax
801016a3:	66 85 c0             	test   %ax,%ax
801016a6:	75 4c                	jne    801016f4 <ialloc+0xb2>
      memset(dip, 0, sizeof(*dip));
801016a8:	83 ec 04             	sub    $0x4,%esp
801016ab:	6a 40                	push   $0x40
801016ad:	6a 00                	push   $0x0
801016af:	ff 75 ec             	pushl  -0x14(%ebp)
801016b2:	e8 e9 39 00 00       	call   801050a0 <memset>
801016b7:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
801016ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016bd:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
801016c1:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
801016c4:	83 ec 0c             	sub    $0xc,%esp
801016c7:	ff 75 f0             	pushl  -0x10(%ebp)
801016ca:	e8 cc 1e 00 00       	call   8010359b <log_write>
801016cf:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
801016d2:	83 ec 0c             	sub    $0xc,%esp
801016d5:	ff 75 f0             	pushl  -0x10(%ebp)
801016d8:	e8 51 eb ff ff       	call   8010022e <brelse>
801016dd:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
801016e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016e3:	83 ec 08             	sub    $0x8,%esp
801016e6:	50                   	push   %eax
801016e7:	ff 75 08             	pushl  0x8(%ebp)
801016ea:	e8 ef 00 00 00       	call   801017de <iget>
801016ef:	83 c4 10             	add    $0x10,%esp
801016f2:	eb 2d                	jmp    80101721 <ialloc+0xdf>
    }
    brelse(bp);
801016f4:	83 ec 0c             	sub    $0xc,%esp
801016f7:	ff 75 f0             	pushl  -0x10(%ebp)
801016fa:	e8 2f eb ff ff       	call   8010022e <brelse>
801016ff:	83 c4 10             	add    $0x10,%esp
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
80101702:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101706:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101709:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010170c:	39 c2                	cmp    %eax,%edx
8010170e:	0f 87 5a ff ff ff    	ja     8010166e <ialloc+0x2c>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101714:	83 ec 0c             	sub    $0xc,%esp
80101717:	68 e1 b4 10 80       	push   $0x8010b4e1
8010171c:	e8 45 ee ff ff       	call   80100566 <panic>
}
80101721:	c9                   	leave  
80101722:	c3                   	ret    

80101723 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80101723:	55                   	push   %ebp
80101724:	89 e5                	mov    %esp,%ebp
80101726:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
80101729:	8b 45 08             	mov    0x8(%ebp),%eax
8010172c:	8b 40 04             	mov    0x4(%eax),%eax
8010172f:	c1 e8 03             	shr    $0x3,%eax
80101732:	8d 50 02             	lea    0x2(%eax),%edx
80101735:	8b 45 08             	mov    0x8(%ebp),%eax
80101738:	8b 00                	mov    (%eax),%eax
8010173a:	83 ec 08             	sub    $0x8,%esp
8010173d:	52                   	push   %edx
8010173e:	50                   	push   %eax
8010173f:	e8 72 ea ff ff       	call   801001b6 <bread>
80101744:	83 c4 10             	add    $0x10,%esp
80101747:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010174a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010174d:	8d 50 18             	lea    0x18(%eax),%edx
80101750:	8b 45 08             	mov    0x8(%ebp),%eax
80101753:	8b 40 04             	mov    0x4(%eax),%eax
80101756:	83 e0 07             	and    $0x7,%eax
80101759:	c1 e0 06             	shl    $0x6,%eax
8010175c:	01 d0                	add    %edx,%eax
8010175e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
80101761:	8b 45 08             	mov    0x8(%ebp),%eax
80101764:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101768:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010176b:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010176e:	8b 45 08             	mov    0x8(%ebp),%eax
80101771:	0f b7 50 12          	movzwl 0x12(%eax),%edx
80101775:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101778:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
8010177c:	8b 45 08             	mov    0x8(%ebp),%eax
8010177f:	0f b7 50 14          	movzwl 0x14(%eax),%edx
80101783:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101786:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
8010178a:	8b 45 08             	mov    0x8(%ebp),%eax
8010178d:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101791:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101794:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101798:	8b 45 08             	mov    0x8(%ebp),%eax
8010179b:	8b 50 18             	mov    0x18(%eax),%edx
8010179e:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017a1:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017a4:	8b 45 08             	mov    0x8(%ebp),%eax
801017a7:	8d 50 1c             	lea    0x1c(%eax),%edx
801017aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017ad:	83 c0 0c             	add    $0xc,%eax
801017b0:	83 ec 04             	sub    $0x4,%esp
801017b3:	6a 34                	push   $0x34
801017b5:	52                   	push   %edx
801017b6:	50                   	push   %eax
801017b7:	e8 a3 39 00 00       	call   8010515f <memmove>
801017bc:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801017bf:	83 ec 0c             	sub    $0xc,%esp
801017c2:	ff 75 f4             	pushl  -0xc(%ebp)
801017c5:	e8 d1 1d 00 00       	call   8010359b <log_write>
801017ca:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801017cd:	83 ec 0c             	sub    $0xc,%esp
801017d0:	ff 75 f4             	pushl  -0xc(%ebp)
801017d3:	e8 56 ea ff ff       	call   8010022e <brelse>
801017d8:	83 c4 10             	add    $0x10,%esp
}
801017db:	90                   	nop
801017dc:	c9                   	leave  
801017dd:	c3                   	ret    

801017de <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801017de:	55                   	push   %ebp
801017df:	89 e5                	mov    %esp,%ebp
801017e1:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
801017e4:	83 ec 0c             	sub    $0xc,%esp
801017e7:	68 c0 18 11 80       	push   $0x801118c0
801017ec:	e8 4c 36 00 00       	call   80104e3d <acquire>
801017f1:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
801017f4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801017fb:	c7 45 f4 f4 18 11 80 	movl   $0x801118f4,-0xc(%ebp)
80101802:	eb 5d                	jmp    80101861 <iget+0x83>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101804:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101807:	8b 40 08             	mov    0x8(%eax),%eax
8010180a:	85 c0                	test   %eax,%eax
8010180c:	7e 39                	jle    80101847 <iget+0x69>
8010180e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101811:	8b 00                	mov    (%eax),%eax
80101813:	3b 45 08             	cmp    0x8(%ebp),%eax
80101816:	75 2f                	jne    80101847 <iget+0x69>
80101818:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010181b:	8b 40 04             	mov    0x4(%eax),%eax
8010181e:	3b 45 0c             	cmp    0xc(%ebp),%eax
80101821:	75 24                	jne    80101847 <iget+0x69>
      ip->ref++;
80101823:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101826:	8b 40 08             	mov    0x8(%eax),%eax
80101829:	8d 50 01             	lea    0x1(%eax),%edx
8010182c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010182f:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101832:	83 ec 0c             	sub    $0xc,%esp
80101835:	68 c0 18 11 80       	push   $0x801118c0
8010183a:	e8 65 36 00 00       	call   80104ea4 <release>
8010183f:	83 c4 10             	add    $0x10,%esp
      return ip;
80101842:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101845:	eb 74                	jmp    801018bb <iget+0xdd>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101847:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010184b:	75 10                	jne    8010185d <iget+0x7f>
8010184d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101850:	8b 40 08             	mov    0x8(%eax),%eax
80101853:	85 c0                	test   %eax,%eax
80101855:	75 06                	jne    8010185d <iget+0x7f>
      empty = ip;
80101857:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010185a:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010185d:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
80101861:	81 7d f4 94 28 11 80 	cmpl   $0x80112894,-0xc(%ebp)
80101868:	72 9a                	jb     80101804 <iget+0x26>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
8010186a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010186e:	75 0d                	jne    8010187d <iget+0x9f>
    panic("iget: no inodes");
80101870:	83 ec 0c             	sub    $0xc,%esp
80101873:	68 f3 b4 10 80       	push   $0x8010b4f3
80101878:	e8 e9 ec ff ff       	call   80100566 <panic>

  ip = empty;
8010187d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101880:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
80101883:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101886:	8b 55 08             	mov    0x8(%ebp),%edx
80101889:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
8010188b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010188e:	8b 55 0c             	mov    0xc(%ebp),%edx
80101891:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
80101894:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101897:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
8010189e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018a1:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
801018a8:	83 ec 0c             	sub    $0xc,%esp
801018ab:	68 c0 18 11 80       	push   $0x801118c0
801018b0:	e8 ef 35 00 00       	call   80104ea4 <release>
801018b5:	83 c4 10             	add    $0x10,%esp

  return ip;
801018b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801018bb:	c9                   	leave  
801018bc:	c3                   	ret    

801018bd <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801018bd:	55                   	push   %ebp
801018be:	89 e5                	mov    %esp,%ebp
801018c0:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
801018c3:	83 ec 0c             	sub    $0xc,%esp
801018c6:	68 c0 18 11 80       	push   $0x801118c0
801018cb:	e8 6d 35 00 00       	call   80104e3d <acquire>
801018d0:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
801018d3:	8b 45 08             	mov    0x8(%ebp),%eax
801018d6:	8b 40 08             	mov    0x8(%eax),%eax
801018d9:	8d 50 01             	lea    0x1(%eax),%edx
801018dc:	8b 45 08             	mov    0x8(%ebp),%eax
801018df:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
801018e2:	83 ec 0c             	sub    $0xc,%esp
801018e5:	68 c0 18 11 80       	push   $0x801118c0
801018ea:	e8 b5 35 00 00       	call   80104ea4 <release>
801018ef:	83 c4 10             	add    $0x10,%esp
  return ip;
801018f2:	8b 45 08             	mov    0x8(%ebp),%eax
}
801018f5:	c9                   	leave  
801018f6:	c3                   	ret    

801018f7 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
801018f7:	55                   	push   %ebp
801018f8:	89 e5                	mov    %esp,%ebp
801018fa:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
801018fd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101901:	74 0a                	je     8010190d <ilock+0x16>
80101903:	8b 45 08             	mov    0x8(%ebp),%eax
80101906:	8b 40 08             	mov    0x8(%eax),%eax
80101909:	85 c0                	test   %eax,%eax
8010190b:	7f 0d                	jg     8010191a <ilock+0x23>
    panic("ilock");
8010190d:	83 ec 0c             	sub    $0xc,%esp
80101910:	68 03 b5 10 80       	push   $0x8010b503
80101915:	e8 4c ec ff ff       	call   80100566 <panic>

  acquire(&icache.lock);
8010191a:	83 ec 0c             	sub    $0xc,%esp
8010191d:	68 c0 18 11 80       	push   $0x801118c0
80101922:	e8 16 35 00 00       	call   80104e3d <acquire>
80101927:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
8010192a:	eb 13                	jmp    8010193f <ilock+0x48>
    sleep(ip, &icache.lock);
8010192c:	83 ec 08             	sub    $0x8,%esp
8010192f:	68 c0 18 11 80       	push   $0x801118c0
80101934:	ff 75 08             	pushl  0x8(%ebp)
80101937:	e8 08 32 00 00       	call   80104b44 <sleep>
8010193c:	83 c4 10             	add    $0x10,%esp

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
8010193f:	8b 45 08             	mov    0x8(%ebp),%eax
80101942:	8b 40 0c             	mov    0xc(%eax),%eax
80101945:	83 e0 01             	and    $0x1,%eax
80101948:	85 c0                	test   %eax,%eax
8010194a:	75 e0                	jne    8010192c <ilock+0x35>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
8010194c:	8b 45 08             	mov    0x8(%ebp),%eax
8010194f:	8b 40 0c             	mov    0xc(%eax),%eax
80101952:	83 c8 01             	or     $0x1,%eax
80101955:	89 c2                	mov    %eax,%edx
80101957:	8b 45 08             	mov    0x8(%ebp),%eax
8010195a:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
8010195d:	83 ec 0c             	sub    $0xc,%esp
80101960:	68 c0 18 11 80       	push   $0x801118c0
80101965:	e8 3a 35 00 00       	call   80104ea4 <release>
8010196a:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
8010196d:	8b 45 08             	mov    0x8(%ebp),%eax
80101970:	8b 40 0c             	mov    0xc(%eax),%eax
80101973:	83 e0 02             	and    $0x2,%eax
80101976:	85 c0                	test   %eax,%eax
80101978:	0f 85 ce 00 00 00    	jne    80101a4c <ilock+0x155>
    bp = bread(ip->dev, IBLOCK(ip->inum));
8010197e:	8b 45 08             	mov    0x8(%ebp),%eax
80101981:	8b 40 04             	mov    0x4(%eax),%eax
80101984:	c1 e8 03             	shr    $0x3,%eax
80101987:	8d 50 02             	lea    0x2(%eax),%edx
8010198a:	8b 45 08             	mov    0x8(%ebp),%eax
8010198d:	8b 00                	mov    (%eax),%eax
8010198f:	83 ec 08             	sub    $0x8,%esp
80101992:	52                   	push   %edx
80101993:	50                   	push   %eax
80101994:	e8 1d e8 ff ff       	call   801001b6 <bread>
80101999:	83 c4 10             	add    $0x10,%esp
8010199c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010199f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019a2:	8d 50 18             	lea    0x18(%eax),%edx
801019a5:	8b 45 08             	mov    0x8(%ebp),%eax
801019a8:	8b 40 04             	mov    0x4(%eax),%eax
801019ab:	83 e0 07             	and    $0x7,%eax
801019ae:	c1 e0 06             	shl    $0x6,%eax
801019b1:	01 d0                	add    %edx,%eax
801019b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
801019b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019b9:	0f b7 10             	movzwl (%eax),%edx
801019bc:	8b 45 08             	mov    0x8(%ebp),%eax
801019bf:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
801019c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019c6:	0f b7 50 02          	movzwl 0x2(%eax),%edx
801019ca:	8b 45 08             	mov    0x8(%ebp),%eax
801019cd:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
801019d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019d4:	0f b7 50 04          	movzwl 0x4(%eax),%edx
801019d8:	8b 45 08             	mov    0x8(%ebp),%eax
801019db:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
801019df:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019e2:	0f b7 50 06          	movzwl 0x6(%eax),%edx
801019e6:	8b 45 08             	mov    0x8(%ebp),%eax
801019e9:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
801019ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019f0:	8b 50 08             	mov    0x8(%eax),%edx
801019f3:	8b 45 08             	mov    0x8(%ebp),%eax
801019f6:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801019f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019fc:	8d 50 0c             	lea    0xc(%eax),%edx
801019ff:	8b 45 08             	mov    0x8(%ebp),%eax
80101a02:	83 c0 1c             	add    $0x1c,%eax
80101a05:	83 ec 04             	sub    $0x4,%esp
80101a08:	6a 34                	push   $0x34
80101a0a:	52                   	push   %edx
80101a0b:	50                   	push   %eax
80101a0c:	e8 4e 37 00 00       	call   8010515f <memmove>
80101a11:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101a14:	83 ec 0c             	sub    $0xc,%esp
80101a17:	ff 75 f4             	pushl  -0xc(%ebp)
80101a1a:	e8 0f e8 ff ff       	call   8010022e <brelse>
80101a1f:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
80101a22:	8b 45 08             	mov    0x8(%ebp),%eax
80101a25:	8b 40 0c             	mov    0xc(%eax),%eax
80101a28:	83 c8 02             	or     $0x2,%eax
80101a2b:	89 c2                	mov    %eax,%edx
80101a2d:	8b 45 08             	mov    0x8(%ebp),%eax
80101a30:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80101a33:	8b 45 08             	mov    0x8(%ebp),%eax
80101a36:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101a3a:	66 85 c0             	test   %ax,%ax
80101a3d:	75 0d                	jne    80101a4c <ilock+0x155>
      panic("ilock: no type");
80101a3f:	83 ec 0c             	sub    $0xc,%esp
80101a42:	68 09 b5 10 80       	push   $0x8010b509
80101a47:	e8 1a eb ff ff       	call   80100566 <panic>
  }
}
80101a4c:	90                   	nop
80101a4d:	c9                   	leave  
80101a4e:	c3                   	ret    

80101a4f <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101a4f:	55                   	push   %ebp
80101a50:	89 e5                	mov    %esp,%ebp
80101a52:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80101a55:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101a59:	74 17                	je     80101a72 <iunlock+0x23>
80101a5b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a5e:	8b 40 0c             	mov    0xc(%eax),%eax
80101a61:	83 e0 01             	and    $0x1,%eax
80101a64:	85 c0                	test   %eax,%eax
80101a66:	74 0a                	je     80101a72 <iunlock+0x23>
80101a68:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6b:	8b 40 08             	mov    0x8(%eax),%eax
80101a6e:	85 c0                	test   %eax,%eax
80101a70:	7f 0d                	jg     80101a7f <iunlock+0x30>
    panic("iunlock");
80101a72:	83 ec 0c             	sub    $0xc,%esp
80101a75:	68 18 b5 10 80       	push   $0x8010b518
80101a7a:	e8 e7 ea ff ff       	call   80100566 <panic>

  acquire(&icache.lock);
80101a7f:	83 ec 0c             	sub    $0xc,%esp
80101a82:	68 c0 18 11 80       	push   $0x801118c0
80101a87:	e8 b1 33 00 00       	call   80104e3d <acquire>
80101a8c:	83 c4 10             	add    $0x10,%esp
  ip->flags &= ~I_BUSY;
80101a8f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a92:	8b 40 0c             	mov    0xc(%eax),%eax
80101a95:	83 e0 fe             	and    $0xfffffffe,%eax
80101a98:	89 c2                	mov    %eax,%edx
80101a9a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9d:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101aa0:	83 ec 0c             	sub    $0xc,%esp
80101aa3:	ff 75 08             	pushl  0x8(%ebp)
80101aa6:	e8 84 31 00 00       	call   80104c2f <wakeup>
80101aab:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80101aae:	83 ec 0c             	sub    $0xc,%esp
80101ab1:	68 c0 18 11 80       	push   $0x801118c0
80101ab6:	e8 e9 33 00 00       	call   80104ea4 <release>
80101abb:	83 c4 10             	add    $0x10,%esp
}
80101abe:	90                   	nop
80101abf:	c9                   	leave  
80101ac0:	c3                   	ret    

80101ac1 <iput>:
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void
iput(struct inode *ip)
{
80101ac1:	55                   	push   %ebp
80101ac2:	89 e5                	mov    %esp,%ebp
80101ac4:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101ac7:	83 ec 0c             	sub    $0xc,%esp
80101aca:	68 c0 18 11 80       	push   $0x801118c0
80101acf:	e8 69 33 00 00       	call   80104e3d <acquire>
80101ad4:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101ad7:	8b 45 08             	mov    0x8(%ebp),%eax
80101ada:	8b 40 08             	mov    0x8(%eax),%eax
80101add:	83 f8 01             	cmp    $0x1,%eax
80101ae0:	0f 85 a9 00 00 00    	jne    80101b8f <iput+0xce>
80101ae6:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae9:	8b 40 0c             	mov    0xc(%eax),%eax
80101aec:	83 e0 02             	and    $0x2,%eax
80101aef:	85 c0                	test   %eax,%eax
80101af1:	0f 84 98 00 00 00    	je     80101b8f <iput+0xce>
80101af7:	8b 45 08             	mov    0x8(%ebp),%eax
80101afa:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101afe:	66 85 c0             	test   %ax,%ax
80101b01:	0f 85 88 00 00 00    	jne    80101b8f <iput+0xce>
    // inode has no links: truncate and free inode.
    if(ip->flags & I_BUSY)
80101b07:	8b 45 08             	mov    0x8(%ebp),%eax
80101b0a:	8b 40 0c             	mov    0xc(%eax),%eax
80101b0d:	83 e0 01             	and    $0x1,%eax
80101b10:	85 c0                	test   %eax,%eax
80101b12:	74 0d                	je     80101b21 <iput+0x60>
      panic("iput busy");
80101b14:	83 ec 0c             	sub    $0xc,%esp
80101b17:	68 20 b5 10 80       	push   $0x8010b520
80101b1c:	e8 45 ea ff ff       	call   80100566 <panic>
    ip->flags |= I_BUSY;
80101b21:	8b 45 08             	mov    0x8(%ebp),%eax
80101b24:	8b 40 0c             	mov    0xc(%eax),%eax
80101b27:	83 c8 01             	or     $0x1,%eax
80101b2a:	89 c2                	mov    %eax,%edx
80101b2c:	8b 45 08             	mov    0x8(%ebp),%eax
80101b2f:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101b32:	83 ec 0c             	sub    $0xc,%esp
80101b35:	68 c0 18 11 80       	push   $0x801118c0
80101b3a:	e8 65 33 00 00       	call   80104ea4 <release>
80101b3f:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
80101b42:	83 ec 0c             	sub    $0xc,%esp
80101b45:	ff 75 08             	pushl  0x8(%ebp)
80101b48:	e8 f7 02 00 00       	call   80101e44 <itrunc>
80101b4d:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
80101b50:	8b 45 08             	mov    0x8(%ebp),%eax
80101b53:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101b59:	83 ec 0c             	sub    $0xc,%esp
80101b5c:	ff 75 08             	pushl  0x8(%ebp)
80101b5f:	e8 bf fb ff ff       	call   80101723 <iupdate>
80101b64:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
80101b67:	83 ec 0c             	sub    $0xc,%esp
80101b6a:	68 c0 18 11 80       	push   $0x801118c0
80101b6f:	e8 c9 32 00 00       	call   80104e3d <acquire>
80101b74:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101b77:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7a:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101b81:	83 ec 0c             	sub    $0xc,%esp
80101b84:	ff 75 08             	pushl  0x8(%ebp)
80101b87:	e8 a3 30 00 00       	call   80104c2f <wakeup>
80101b8c:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
80101b8f:	8b 45 08             	mov    0x8(%ebp),%eax
80101b92:	8b 40 08             	mov    0x8(%eax),%eax
80101b95:	8d 50 ff             	lea    -0x1(%eax),%edx
80101b98:	8b 45 08             	mov    0x8(%ebp),%eax
80101b9b:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101b9e:	83 ec 0c             	sub    $0xc,%esp
80101ba1:	68 c0 18 11 80       	push   $0x801118c0
80101ba6:	e8 f9 32 00 00       	call   80104ea4 <release>
80101bab:	83 c4 10             	add    $0x10,%esp
}
80101bae:	90                   	nop
80101baf:	c9                   	leave  
80101bb0:	c3                   	ret    

80101bb1 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101bb1:	55                   	push   %ebp
80101bb2:	89 e5                	mov    %esp,%ebp
80101bb4:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101bb7:	83 ec 0c             	sub    $0xc,%esp
80101bba:	ff 75 08             	pushl  0x8(%ebp)
80101bbd:	e8 8d fe ff ff       	call   80101a4f <iunlock>
80101bc2:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101bc5:	83 ec 0c             	sub    $0xc,%esp
80101bc8:	ff 75 08             	pushl  0x8(%ebp)
80101bcb:	e8 f1 fe ff ff       	call   80101ac1 <iput>
80101bd0:	83 c4 10             	add    $0x10,%esp
}
80101bd3:	90                   	nop
80101bd4:	c9                   	leave  
80101bd5:	c3                   	ret    

80101bd6 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101bd6:	55                   	push   %ebp
80101bd7:	89 e5                	mov    %esp,%ebp
80101bd9:	53                   	push   %ebx
80101bda:	83 ec 14             	sub    $0x14,%esp
    uint addr, *a;
    struct buf *bp;
    
    if(bn < NDIRECT){
80101bdd:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101be1:	77 42                	ja     80101c25 <bmap+0x4f>
        if((addr = ip->addrs[bn]) == 0)
80101be3:	8b 45 08             	mov    0x8(%ebp),%eax
80101be6:	8b 55 0c             	mov    0xc(%ebp),%edx
80101be9:	83 c2 04             	add    $0x4,%edx
80101bec:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101bf0:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101bf3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101bf7:	75 24                	jne    80101c1d <bmap+0x47>
            ip->addrs[bn] = addr = balloc(ip->dev);
80101bf9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bfc:	8b 00                	mov    (%eax),%eax
80101bfe:	83 ec 0c             	sub    $0xc,%esp
80101c01:	50                   	push   %eax
80101c02:	e8 e4 f7 ff ff       	call   801013eb <balloc>
80101c07:	83 c4 10             	add    $0x10,%esp
80101c0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c0d:	8b 45 08             	mov    0x8(%ebp),%eax
80101c10:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c13:	8d 4a 04             	lea    0x4(%edx),%ecx
80101c16:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c19:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
        return addr;
80101c1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c20:	e9 1a 02 00 00       	jmp    80101e3f <bmap+0x269>
    }
    bn -= NDIRECT;
80101c25:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)
    
    if(bn < NINDIRECT){
80101c29:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101c2d:	0f 87 b3 00 00 00    	ja     80101ce6 <bmap+0x110>
        // Load indirect block, allocating if necessary.
        if((addr = ip->addrs[NDIRECT]) == 0)
80101c33:	8b 45 08             	mov    0x8(%ebp),%eax
80101c36:	8b 40 4c             	mov    0x4c(%eax),%eax
80101c39:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c3c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c40:	75 1d                	jne    80101c5f <bmap+0x89>
            ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101c42:	8b 45 08             	mov    0x8(%ebp),%eax
80101c45:	8b 00                	mov    (%eax),%eax
80101c47:	83 ec 0c             	sub    $0xc,%esp
80101c4a:	50                   	push   %eax
80101c4b:	e8 9b f7 ff ff       	call   801013eb <balloc>
80101c50:	83 c4 10             	add    $0x10,%esp
80101c53:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c56:	8b 45 08             	mov    0x8(%ebp),%eax
80101c59:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c5c:	89 50 4c             	mov    %edx,0x4c(%eax)
        bp = bread(ip->dev, addr);
80101c5f:	8b 45 08             	mov    0x8(%ebp),%eax
80101c62:	8b 00                	mov    (%eax),%eax
80101c64:	83 ec 08             	sub    $0x8,%esp
80101c67:	ff 75 f4             	pushl  -0xc(%ebp)
80101c6a:	50                   	push   %eax
80101c6b:	e8 46 e5 ff ff       	call   801001b6 <bread>
80101c70:	83 c4 10             	add    $0x10,%esp
80101c73:	89 45 f0             	mov    %eax,-0x10(%ebp)
        a = (uint*)bp->data;
80101c76:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c79:	83 c0 18             	add    $0x18,%eax
80101c7c:	89 45 ec             	mov    %eax,-0x14(%ebp)
        if((addr = a[bn]) == 0){
80101c7f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c82:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101c89:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c8c:	01 d0                	add    %edx,%eax
80101c8e:	8b 00                	mov    (%eax),%eax
80101c90:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c93:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c97:	75 37                	jne    80101cd0 <bmap+0xfa>
            a[bn] = addr = balloc(ip->dev);
80101c99:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c9c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101ca3:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ca6:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101ca9:	8b 45 08             	mov    0x8(%ebp),%eax
80101cac:	8b 00                	mov    (%eax),%eax
80101cae:	83 ec 0c             	sub    $0xc,%esp
80101cb1:	50                   	push   %eax
80101cb2:	e8 34 f7 ff ff       	call   801013eb <balloc>
80101cb7:	83 c4 10             	add    $0x10,%esp
80101cba:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cc0:	89 03                	mov    %eax,(%ebx)
            log_write(bp);
80101cc2:	83 ec 0c             	sub    $0xc,%esp
80101cc5:	ff 75 f0             	pushl  -0x10(%ebp)
80101cc8:	e8 ce 18 00 00       	call   8010359b <log_write>
80101ccd:	83 c4 10             	add    $0x10,%esp
        }
        brelse(bp);
80101cd0:	83 ec 0c             	sub    $0xc,%esp
80101cd3:	ff 75 f0             	pushl  -0x10(%ebp)
80101cd6:	e8 53 e5 ff ff       	call   8010022e <brelse>
80101cdb:	83 c4 10             	add    $0x10,%esp
        return addr;
80101cde:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ce1:	e9 59 01 00 00       	jmp    80101e3f <bmap+0x269>
    }
    bn -= NINDIRECT;
80101ce6:	83 45 0c 80          	addl   $0xffffff80,0xc(%ebp)
    
    if(bn < NINDIRECT * NINDIRECT){
80101cea:	81 7d 0c ff 3f 00 00 	cmpl   $0x3fff,0xc(%ebp)
80101cf1:	0f 87 3b 01 00 00    	ja     80101e32 <bmap+0x25c>
        if ((addr = ip->addrs[NDIRECT+1]) == 0)
80101cf7:	8b 45 08             	mov    0x8(%ebp),%eax
80101cfa:	8b 40 50             	mov    0x50(%eax),%eax
80101cfd:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d00:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101d04:	75 1d                	jne    80101d23 <bmap+0x14d>
            ip->addrs[NDIRECT+1] = addr = balloc(ip->dev);
80101d06:	8b 45 08             	mov    0x8(%ebp),%eax
80101d09:	8b 00                	mov    (%eax),%eax
80101d0b:	83 ec 0c             	sub    $0xc,%esp
80101d0e:	50                   	push   %eax
80101d0f:	e8 d7 f6 ff ff       	call   801013eb <balloc>
80101d14:	83 c4 10             	add    $0x10,%esp
80101d17:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d1a:	8b 45 08             	mov    0x8(%ebp),%eax
80101d1d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d20:	89 50 50             	mov    %edx,0x50(%eax)
        bp = bread(ip->dev, addr);
80101d23:	8b 45 08             	mov    0x8(%ebp),%eax
80101d26:	8b 00                	mov    (%eax),%eax
80101d28:	83 ec 08             	sub    $0x8,%esp
80101d2b:	ff 75 f4             	pushl  -0xc(%ebp)
80101d2e:	50                   	push   %eax
80101d2f:	e8 82 e4 ff ff       	call   801001b6 <bread>
80101d34:	83 c4 10             	add    $0x10,%esp
80101d37:	89 45 f0             	mov    %eax,-0x10(%ebp)
        a = (uint*)bp->data;
80101d3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d3d:	83 c0 18             	add    $0x18,%eax
80101d40:	89 45 ec             	mov    %eax,-0x14(%ebp)
        if((addr = a[bn/NINDIRECT]) == 0){
80101d43:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d46:	c1 e8 07             	shr    $0x7,%eax
80101d49:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d50:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d53:	01 d0                	add    %edx,%eax
80101d55:	8b 00                	mov    (%eax),%eax
80101d57:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d5a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101d5e:	75 3a                	jne    80101d9a <bmap+0x1c4>
            a[bn/NINDIRECT] = addr = balloc(ip->dev);
80101d60:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d63:	c1 e8 07             	shr    $0x7,%eax
80101d66:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d6d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d70:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101d73:	8b 45 08             	mov    0x8(%ebp),%eax
80101d76:	8b 00                	mov    (%eax),%eax
80101d78:	83 ec 0c             	sub    $0xc,%esp
80101d7b:	50                   	push   %eax
80101d7c:	e8 6a f6 ff ff       	call   801013eb <balloc>
80101d81:	83 c4 10             	add    $0x10,%esp
80101d84:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d8a:	89 03                	mov    %eax,(%ebx)
            log_write(bp);
80101d8c:	83 ec 0c             	sub    $0xc,%esp
80101d8f:	ff 75 f0             	pushl  -0x10(%ebp)
80101d92:	e8 04 18 00 00       	call   8010359b <log_write>
80101d97:	83 c4 10             	add    $0x10,%esp
        }
        brelse(bp);
80101d9a:	83 ec 0c             	sub    $0xc,%esp
80101d9d:	ff 75 f0             	pushl  -0x10(%ebp)
80101da0:	e8 89 e4 ff ff       	call   8010022e <brelse>
80101da5:	83 c4 10             	add    $0x10,%esp
        bp = bread(ip->dev, addr);
80101da8:	8b 45 08             	mov    0x8(%ebp),%eax
80101dab:	8b 00                	mov    (%eax),%eax
80101dad:	83 ec 08             	sub    $0x8,%esp
80101db0:	ff 75 f4             	pushl  -0xc(%ebp)
80101db3:	50                   	push   %eax
80101db4:	e8 fd e3 ff ff       	call   801001b6 <bread>
80101db9:	83 c4 10             	add    $0x10,%esp
80101dbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
        a = (uint*)bp->data;
80101dbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101dc2:	83 c0 18             	add    $0x18,%eax
80101dc5:	89 45 ec             	mov    %eax,-0x14(%ebp)
        if((addr = a[bn%NINDIRECT]) == 0){
80101dc8:	8b 45 0c             	mov    0xc(%ebp),%eax
80101dcb:	83 e0 7f             	and    $0x7f,%eax
80101dce:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101dd5:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101dd8:	01 d0                	add    %edx,%eax
80101dda:	8b 00                	mov    (%eax),%eax
80101ddc:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101ddf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101de3:	75 3a                	jne    80101e1f <bmap+0x249>
            a[bn%NINDIRECT] = addr = balloc(ip->dev);
80101de5:	8b 45 0c             	mov    0xc(%ebp),%eax
80101de8:	83 e0 7f             	and    $0x7f,%eax
80101deb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101df2:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101df5:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101df8:	8b 45 08             	mov    0x8(%ebp),%eax
80101dfb:	8b 00                	mov    (%eax),%eax
80101dfd:	83 ec 0c             	sub    $0xc,%esp
80101e00:	50                   	push   %eax
80101e01:	e8 e5 f5 ff ff       	call   801013eb <balloc>
80101e06:	83 c4 10             	add    $0x10,%esp
80101e09:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101e0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101e0f:	89 03                	mov    %eax,(%ebx)
            log_write(bp);
80101e11:	83 ec 0c             	sub    $0xc,%esp
80101e14:	ff 75 f0             	pushl  -0x10(%ebp)
80101e17:	e8 7f 17 00 00       	call   8010359b <log_write>
80101e1c:	83 c4 10             	add    $0x10,%esp
        }
        brelse(bp);
80101e1f:	83 ec 0c             	sub    $0xc,%esp
80101e22:	ff 75 f0             	pushl  -0x10(%ebp)
80101e25:	e8 04 e4 ff ff       	call   8010022e <brelse>
80101e2a:	83 c4 10             	add    $0x10,%esp
        return addr;
80101e2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101e30:	eb 0d                	jmp    80101e3f <bmap+0x269>
    }
    
    panic("bmap: out of range");
80101e32:	83 ec 0c             	sub    $0xc,%esp
80101e35:	68 2a b5 10 80       	push   $0x8010b52a
80101e3a:	e8 27 e7 ff ff       	call   80100566 <panic>
}
80101e3f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101e42:	c9                   	leave  
80101e43:	c3                   	ret    

80101e44 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101e44:	55                   	push   %ebp
80101e45:	89 e5                	mov    %esp,%ebp
80101e47:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101e4a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101e51:	eb 45                	jmp    80101e98 <itrunc+0x54>
    if(ip->addrs[i]){
80101e53:	8b 45 08             	mov    0x8(%ebp),%eax
80101e56:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101e59:	83 c2 04             	add    $0x4,%edx
80101e5c:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101e60:	85 c0                	test   %eax,%eax
80101e62:	74 30                	je     80101e94 <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
80101e64:	8b 45 08             	mov    0x8(%ebp),%eax
80101e67:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101e6a:	83 c2 04             	add    $0x4,%edx
80101e6d:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101e71:	8b 55 08             	mov    0x8(%ebp),%edx
80101e74:	8b 12                	mov    (%edx),%edx
80101e76:	83 ec 08             	sub    $0x8,%esp
80101e79:	50                   	push   %eax
80101e7a:	52                   	push   %edx
80101e7b:	e8 c9 f6 ff ff       	call   80101549 <bfree>
80101e80:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101e83:	8b 45 08             	mov    0x8(%ebp),%eax
80101e86:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101e89:	83 c2 04             	add    $0x4,%edx
80101e8c:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101e93:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101e94:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101e98:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101e9c:	7e b5                	jle    80101e53 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
80101e9e:	8b 45 08             	mov    0x8(%ebp),%eax
80101ea1:	8b 40 4c             	mov    0x4c(%eax),%eax
80101ea4:	85 c0                	test   %eax,%eax
80101ea6:	0f 84 a1 00 00 00    	je     80101f4d <itrunc+0x109>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101eac:	8b 45 08             	mov    0x8(%ebp),%eax
80101eaf:	8b 50 4c             	mov    0x4c(%eax),%edx
80101eb2:	8b 45 08             	mov    0x8(%ebp),%eax
80101eb5:	8b 00                	mov    (%eax),%eax
80101eb7:	83 ec 08             	sub    $0x8,%esp
80101eba:	52                   	push   %edx
80101ebb:	50                   	push   %eax
80101ebc:	e8 f5 e2 ff ff       	call   801001b6 <bread>
80101ec1:	83 c4 10             	add    $0x10,%esp
80101ec4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101ec7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101eca:	83 c0 18             	add    $0x18,%eax
80101ecd:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101ed0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101ed7:	eb 3c                	jmp    80101f15 <itrunc+0xd1>
      if(a[j])
80101ed9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101edc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101ee3:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101ee6:	01 d0                	add    %edx,%eax
80101ee8:	8b 00                	mov    (%eax),%eax
80101eea:	85 c0                	test   %eax,%eax
80101eec:	74 23                	je     80101f11 <itrunc+0xcd>
        bfree(ip->dev, a[j]);
80101eee:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ef1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101ef8:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101efb:	01 d0                	add    %edx,%eax
80101efd:	8b 00                	mov    (%eax),%eax
80101eff:	8b 55 08             	mov    0x8(%ebp),%edx
80101f02:	8b 12                	mov    (%edx),%edx
80101f04:	83 ec 08             	sub    $0x8,%esp
80101f07:	50                   	push   %eax
80101f08:	52                   	push   %edx
80101f09:	e8 3b f6 ff ff       	call   80101549 <bfree>
80101f0e:	83 c4 10             	add    $0x10,%esp
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101f11:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101f15:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f18:	83 f8 7f             	cmp    $0x7f,%eax
80101f1b:	76 bc                	jbe    80101ed9 <itrunc+0x95>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101f1d:	83 ec 0c             	sub    $0xc,%esp
80101f20:	ff 75 ec             	pushl  -0x14(%ebp)
80101f23:	e8 06 e3 ff ff       	call   8010022e <brelse>
80101f28:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101f2b:	8b 45 08             	mov    0x8(%ebp),%eax
80101f2e:	8b 40 4c             	mov    0x4c(%eax),%eax
80101f31:	8b 55 08             	mov    0x8(%ebp),%edx
80101f34:	8b 12                	mov    (%edx),%edx
80101f36:	83 ec 08             	sub    $0x8,%esp
80101f39:	50                   	push   %eax
80101f3a:	52                   	push   %edx
80101f3b:	e8 09 f6 ff ff       	call   80101549 <bfree>
80101f40:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80101f43:	8b 45 08             	mov    0x8(%ebp),%eax
80101f46:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80101f4d:	8b 45 08             	mov    0x8(%ebp),%eax
80101f50:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80101f57:	83 ec 0c             	sub    $0xc,%esp
80101f5a:	ff 75 08             	pushl  0x8(%ebp)
80101f5d:	e8 c1 f7 ff ff       	call   80101723 <iupdate>
80101f62:	83 c4 10             	add    $0x10,%esp
}
80101f65:	90                   	nop
80101f66:	c9                   	leave  
80101f67:	c3                   	ret    

80101f68 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101f68:	55                   	push   %ebp
80101f69:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101f6b:	8b 45 08             	mov    0x8(%ebp),%eax
80101f6e:	8b 00                	mov    (%eax),%eax
80101f70:	89 c2                	mov    %eax,%edx
80101f72:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f75:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101f78:	8b 45 08             	mov    0x8(%ebp),%eax
80101f7b:	8b 50 04             	mov    0x4(%eax),%edx
80101f7e:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f81:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101f84:	8b 45 08             	mov    0x8(%ebp),%eax
80101f87:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101f8b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f8e:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101f91:	8b 45 08             	mov    0x8(%ebp),%eax
80101f94:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101f98:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f9b:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101f9f:	8b 45 08             	mov    0x8(%ebp),%eax
80101fa2:	8b 50 18             	mov    0x18(%eax),%edx
80101fa5:	8b 45 0c             	mov    0xc(%ebp),%eax
80101fa8:	89 50 10             	mov    %edx,0x10(%eax)
}
80101fab:	90                   	nop
80101fac:	5d                   	pop    %ebp
80101fad:	c3                   	ret    

80101fae <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101fae:	55                   	push   %ebp
80101faf:	89 e5                	mov    %esp,%ebp
80101fb1:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101fb4:	8b 45 08             	mov    0x8(%ebp),%eax
80101fb7:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101fbb:	66 83 f8 03          	cmp    $0x3,%ax
80101fbf:	75 5c                	jne    8010201d <readi+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101fc1:	8b 45 08             	mov    0x8(%ebp),%eax
80101fc4:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fc8:	66 85 c0             	test   %ax,%ax
80101fcb:	78 20                	js     80101fed <readi+0x3f>
80101fcd:	8b 45 08             	mov    0x8(%ebp),%eax
80101fd0:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fd4:	66 83 f8 09          	cmp    $0x9,%ax
80101fd8:	7f 13                	jg     80101fed <readi+0x3f>
80101fda:	8b 45 08             	mov    0x8(%ebp),%eax
80101fdd:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fe1:	98                   	cwtl   
80101fe2:	8b 04 c5 60 18 11 80 	mov    -0x7feee7a0(,%eax,8),%eax
80101fe9:	85 c0                	test   %eax,%eax
80101feb:	75 0a                	jne    80101ff7 <readi+0x49>
      return -1;
80101fed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ff2:	e9 0c 01 00 00       	jmp    80102103 <readi+0x155>
    return devsw[ip->major].read(ip, dst, n);
80101ff7:	8b 45 08             	mov    0x8(%ebp),%eax
80101ffa:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101ffe:	98                   	cwtl   
80101fff:	8b 04 c5 60 18 11 80 	mov    -0x7feee7a0(,%eax,8),%eax
80102006:	8b 55 14             	mov    0x14(%ebp),%edx
80102009:	83 ec 04             	sub    $0x4,%esp
8010200c:	52                   	push   %edx
8010200d:	ff 75 0c             	pushl  0xc(%ebp)
80102010:	ff 75 08             	pushl  0x8(%ebp)
80102013:	ff d0                	call   *%eax
80102015:	83 c4 10             	add    $0x10,%esp
80102018:	e9 e6 00 00 00       	jmp    80102103 <readi+0x155>
  }

  if(off > ip->size || off + n < off)
8010201d:	8b 45 08             	mov    0x8(%ebp),%eax
80102020:	8b 40 18             	mov    0x18(%eax),%eax
80102023:	3b 45 10             	cmp    0x10(%ebp),%eax
80102026:	72 0d                	jb     80102035 <readi+0x87>
80102028:	8b 55 10             	mov    0x10(%ebp),%edx
8010202b:	8b 45 14             	mov    0x14(%ebp),%eax
8010202e:	01 d0                	add    %edx,%eax
80102030:	3b 45 10             	cmp    0x10(%ebp),%eax
80102033:	73 0a                	jae    8010203f <readi+0x91>
    return -1;
80102035:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010203a:	e9 c4 00 00 00       	jmp    80102103 <readi+0x155>
  if(off + n > ip->size)
8010203f:	8b 55 10             	mov    0x10(%ebp),%edx
80102042:	8b 45 14             	mov    0x14(%ebp),%eax
80102045:	01 c2                	add    %eax,%edx
80102047:	8b 45 08             	mov    0x8(%ebp),%eax
8010204a:	8b 40 18             	mov    0x18(%eax),%eax
8010204d:	39 c2                	cmp    %eax,%edx
8010204f:	76 0c                	jbe    8010205d <readi+0xaf>
    n = ip->size - off;
80102051:	8b 45 08             	mov    0x8(%ebp),%eax
80102054:	8b 40 18             	mov    0x18(%eax),%eax
80102057:	2b 45 10             	sub    0x10(%ebp),%eax
8010205a:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010205d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102064:	e9 8b 00 00 00       	jmp    801020f4 <readi+0x146>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102069:	8b 45 10             	mov    0x10(%ebp),%eax
8010206c:	c1 e8 09             	shr    $0x9,%eax
8010206f:	83 ec 08             	sub    $0x8,%esp
80102072:	50                   	push   %eax
80102073:	ff 75 08             	pushl  0x8(%ebp)
80102076:	e8 5b fb ff ff       	call   80101bd6 <bmap>
8010207b:	83 c4 10             	add    $0x10,%esp
8010207e:	89 c2                	mov    %eax,%edx
80102080:	8b 45 08             	mov    0x8(%ebp),%eax
80102083:	8b 00                	mov    (%eax),%eax
80102085:	83 ec 08             	sub    $0x8,%esp
80102088:	52                   	push   %edx
80102089:	50                   	push   %eax
8010208a:	e8 27 e1 ff ff       	call   801001b6 <bread>
8010208f:	83 c4 10             	add    $0x10,%esp
80102092:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102095:	8b 45 10             	mov    0x10(%ebp),%eax
80102098:	25 ff 01 00 00       	and    $0x1ff,%eax
8010209d:	ba 00 02 00 00       	mov    $0x200,%edx
801020a2:	29 c2                	sub    %eax,%edx
801020a4:	8b 45 14             	mov    0x14(%ebp),%eax
801020a7:	2b 45 f4             	sub    -0xc(%ebp),%eax
801020aa:	39 c2                	cmp    %eax,%edx
801020ac:	0f 46 c2             	cmovbe %edx,%eax
801020af:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
801020b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020b5:	8d 50 18             	lea    0x18(%eax),%edx
801020b8:	8b 45 10             	mov    0x10(%ebp),%eax
801020bb:	25 ff 01 00 00       	and    $0x1ff,%eax
801020c0:	01 d0                	add    %edx,%eax
801020c2:	83 ec 04             	sub    $0x4,%esp
801020c5:	ff 75 ec             	pushl  -0x14(%ebp)
801020c8:	50                   	push   %eax
801020c9:	ff 75 0c             	pushl  0xc(%ebp)
801020cc:	e8 8e 30 00 00       	call   8010515f <memmove>
801020d1:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801020d4:	83 ec 0c             	sub    $0xc,%esp
801020d7:	ff 75 f0             	pushl  -0x10(%ebp)
801020da:	e8 4f e1 ff ff       	call   8010022e <brelse>
801020df:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801020e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020e5:	01 45 f4             	add    %eax,-0xc(%ebp)
801020e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020eb:	01 45 10             	add    %eax,0x10(%ebp)
801020ee:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020f1:	01 45 0c             	add    %eax,0xc(%ebp)
801020f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801020f7:	3b 45 14             	cmp    0x14(%ebp),%eax
801020fa:	0f 82 69 ff ff ff    	jb     80102069 <readi+0xbb>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80102100:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102103:	c9                   	leave  
80102104:	c3                   	ret    

80102105 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102105:	55                   	push   %ebp
80102106:	89 e5                	mov    %esp,%ebp
80102108:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
8010210b:	8b 45 08             	mov    0x8(%ebp),%eax
8010210e:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102112:	66 83 f8 03          	cmp    $0x3,%ax
80102116:	75 5c                	jne    80102174 <writei+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102118:	8b 45 08             	mov    0x8(%ebp),%eax
8010211b:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010211f:	66 85 c0             	test   %ax,%ax
80102122:	78 20                	js     80102144 <writei+0x3f>
80102124:	8b 45 08             	mov    0x8(%ebp),%eax
80102127:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010212b:	66 83 f8 09          	cmp    $0x9,%ax
8010212f:	7f 13                	jg     80102144 <writei+0x3f>
80102131:	8b 45 08             	mov    0x8(%ebp),%eax
80102134:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102138:	98                   	cwtl   
80102139:	8b 04 c5 64 18 11 80 	mov    -0x7feee79c(,%eax,8),%eax
80102140:	85 c0                	test   %eax,%eax
80102142:	75 0a                	jne    8010214e <writei+0x49>
      return -1;
80102144:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102149:	e9 3d 01 00 00       	jmp    8010228b <writei+0x186>
    return devsw[ip->major].write(ip, src, n);
8010214e:	8b 45 08             	mov    0x8(%ebp),%eax
80102151:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102155:	98                   	cwtl   
80102156:	8b 04 c5 64 18 11 80 	mov    -0x7feee79c(,%eax,8),%eax
8010215d:	8b 55 14             	mov    0x14(%ebp),%edx
80102160:	83 ec 04             	sub    $0x4,%esp
80102163:	52                   	push   %edx
80102164:	ff 75 0c             	pushl  0xc(%ebp)
80102167:	ff 75 08             	pushl  0x8(%ebp)
8010216a:	ff d0                	call   *%eax
8010216c:	83 c4 10             	add    $0x10,%esp
8010216f:	e9 17 01 00 00       	jmp    8010228b <writei+0x186>
  }

  if(off > ip->size || off + n < off)
80102174:	8b 45 08             	mov    0x8(%ebp),%eax
80102177:	8b 40 18             	mov    0x18(%eax),%eax
8010217a:	3b 45 10             	cmp    0x10(%ebp),%eax
8010217d:	72 0d                	jb     8010218c <writei+0x87>
8010217f:	8b 55 10             	mov    0x10(%ebp),%edx
80102182:	8b 45 14             	mov    0x14(%ebp),%eax
80102185:	01 d0                	add    %edx,%eax
80102187:	3b 45 10             	cmp    0x10(%ebp),%eax
8010218a:	73 0a                	jae    80102196 <writei+0x91>
    return -1;
8010218c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102191:	e9 f5 00 00 00       	jmp    8010228b <writei+0x186>
  if(off + n > MAXFILE*BSIZE)
80102196:	8b 55 10             	mov    0x10(%ebp),%edx
80102199:	8b 45 14             	mov    0x14(%ebp),%eax
8010219c:	01 d0                	add    %edx,%eax
8010219e:	3d 00 18 01 00       	cmp    $0x11800,%eax
801021a3:	76 0a                	jbe    801021af <writei+0xaa>
    return -1;
801021a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021aa:	e9 dc 00 00 00       	jmp    8010228b <writei+0x186>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801021af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801021b6:	e9 99 00 00 00       	jmp    80102254 <writei+0x14f>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801021bb:	8b 45 10             	mov    0x10(%ebp),%eax
801021be:	c1 e8 09             	shr    $0x9,%eax
801021c1:	83 ec 08             	sub    $0x8,%esp
801021c4:	50                   	push   %eax
801021c5:	ff 75 08             	pushl  0x8(%ebp)
801021c8:	e8 09 fa ff ff       	call   80101bd6 <bmap>
801021cd:	83 c4 10             	add    $0x10,%esp
801021d0:	89 c2                	mov    %eax,%edx
801021d2:	8b 45 08             	mov    0x8(%ebp),%eax
801021d5:	8b 00                	mov    (%eax),%eax
801021d7:	83 ec 08             	sub    $0x8,%esp
801021da:	52                   	push   %edx
801021db:	50                   	push   %eax
801021dc:	e8 d5 df ff ff       	call   801001b6 <bread>
801021e1:	83 c4 10             	add    $0x10,%esp
801021e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801021e7:	8b 45 10             	mov    0x10(%ebp),%eax
801021ea:	25 ff 01 00 00       	and    $0x1ff,%eax
801021ef:	ba 00 02 00 00       	mov    $0x200,%edx
801021f4:	29 c2                	sub    %eax,%edx
801021f6:	8b 45 14             	mov    0x14(%ebp),%eax
801021f9:	2b 45 f4             	sub    -0xc(%ebp),%eax
801021fc:	39 c2                	cmp    %eax,%edx
801021fe:	0f 46 c2             	cmovbe %edx,%eax
80102201:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
80102204:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102207:	8d 50 18             	lea    0x18(%eax),%edx
8010220a:	8b 45 10             	mov    0x10(%ebp),%eax
8010220d:	25 ff 01 00 00       	and    $0x1ff,%eax
80102212:	01 d0                	add    %edx,%eax
80102214:	83 ec 04             	sub    $0x4,%esp
80102217:	ff 75 ec             	pushl  -0x14(%ebp)
8010221a:	ff 75 0c             	pushl  0xc(%ebp)
8010221d:	50                   	push   %eax
8010221e:	e8 3c 2f 00 00       	call   8010515f <memmove>
80102223:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
80102226:	83 ec 0c             	sub    $0xc,%esp
80102229:	ff 75 f0             	pushl  -0x10(%ebp)
8010222c:	e8 6a 13 00 00       	call   8010359b <log_write>
80102231:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80102234:	83 ec 0c             	sub    $0xc,%esp
80102237:	ff 75 f0             	pushl  -0x10(%ebp)
8010223a:	e8 ef df ff ff       	call   8010022e <brelse>
8010223f:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102242:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102245:	01 45 f4             	add    %eax,-0xc(%ebp)
80102248:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010224b:	01 45 10             	add    %eax,0x10(%ebp)
8010224e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102251:	01 45 0c             	add    %eax,0xc(%ebp)
80102254:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102257:	3b 45 14             	cmp    0x14(%ebp),%eax
8010225a:	0f 82 5b ff ff ff    	jb     801021bb <writei+0xb6>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80102260:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80102264:	74 22                	je     80102288 <writei+0x183>
80102266:	8b 45 08             	mov    0x8(%ebp),%eax
80102269:	8b 40 18             	mov    0x18(%eax),%eax
8010226c:	3b 45 10             	cmp    0x10(%ebp),%eax
8010226f:	73 17                	jae    80102288 <writei+0x183>
    ip->size = off;
80102271:	8b 45 08             	mov    0x8(%ebp),%eax
80102274:	8b 55 10             	mov    0x10(%ebp),%edx
80102277:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
8010227a:	83 ec 0c             	sub    $0xc,%esp
8010227d:	ff 75 08             	pushl  0x8(%ebp)
80102280:	e8 9e f4 ff ff       	call   80101723 <iupdate>
80102285:	83 c4 10             	add    $0x10,%esp
  }
  return n;
80102288:	8b 45 14             	mov    0x14(%ebp),%eax
}
8010228b:	c9                   	leave  
8010228c:	c3                   	ret    

8010228d <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
8010228d:	55                   	push   %ebp
8010228e:	89 e5                	mov    %esp,%ebp
80102290:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
80102293:	83 ec 04             	sub    $0x4,%esp
80102296:	6a 0e                	push   $0xe
80102298:	ff 75 0c             	pushl  0xc(%ebp)
8010229b:	ff 75 08             	pushl  0x8(%ebp)
8010229e:	e8 52 2f 00 00       	call   801051f5 <strncmp>
801022a3:	83 c4 10             	add    $0x10,%esp
}
801022a6:	c9                   	leave  
801022a7:	c3                   	ret    

801022a8 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
801022a8:	55                   	push   %ebp
801022a9:	89 e5                	mov    %esp,%ebp
801022ab:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
801022ae:	8b 45 08             	mov    0x8(%ebp),%eax
801022b1:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801022b5:	66 83 f8 01          	cmp    $0x1,%ax
801022b9:	74 0d                	je     801022c8 <dirlookup+0x20>
    panic("dirlookup not DIR");
801022bb:	83 ec 0c             	sub    $0xc,%esp
801022be:	68 3d b5 10 80       	push   $0x8010b53d
801022c3:	e8 9e e2 ff ff       	call   80100566 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
801022c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801022cf:	eb 7b                	jmp    8010234c <dirlookup+0xa4>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801022d1:	6a 10                	push   $0x10
801022d3:	ff 75 f4             	pushl  -0xc(%ebp)
801022d6:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022d9:	50                   	push   %eax
801022da:	ff 75 08             	pushl  0x8(%ebp)
801022dd:	e8 cc fc ff ff       	call   80101fae <readi>
801022e2:	83 c4 10             	add    $0x10,%esp
801022e5:	83 f8 10             	cmp    $0x10,%eax
801022e8:	74 0d                	je     801022f7 <dirlookup+0x4f>
      panic("dirlink read");
801022ea:	83 ec 0c             	sub    $0xc,%esp
801022ed:	68 4f b5 10 80       	push   $0x8010b54f
801022f2:	e8 6f e2 ff ff       	call   80100566 <panic>
    if(de.inum == 0)
801022f7:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801022fb:	66 85 c0             	test   %ax,%ax
801022fe:	74 47                	je     80102347 <dirlookup+0x9f>
      continue;
    if(namecmp(name, de.name) == 0){
80102300:	83 ec 08             	sub    $0x8,%esp
80102303:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102306:	83 c0 02             	add    $0x2,%eax
80102309:	50                   	push   %eax
8010230a:	ff 75 0c             	pushl  0xc(%ebp)
8010230d:	e8 7b ff ff ff       	call   8010228d <namecmp>
80102312:	83 c4 10             	add    $0x10,%esp
80102315:	85 c0                	test   %eax,%eax
80102317:	75 2f                	jne    80102348 <dirlookup+0xa0>
      // entry matches path element
      if(poff)
80102319:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010231d:	74 08                	je     80102327 <dirlookup+0x7f>
        *poff = off;
8010231f:	8b 45 10             	mov    0x10(%ebp),%eax
80102322:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102325:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
80102327:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010232b:	0f b7 c0             	movzwl %ax,%eax
8010232e:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
80102331:	8b 45 08             	mov    0x8(%ebp),%eax
80102334:	8b 00                	mov    (%eax),%eax
80102336:	83 ec 08             	sub    $0x8,%esp
80102339:	ff 75 f0             	pushl  -0x10(%ebp)
8010233c:	50                   	push   %eax
8010233d:	e8 9c f4 ff ff       	call   801017de <iget>
80102342:	83 c4 10             	add    $0x10,%esp
80102345:	eb 19                	jmp    80102360 <dirlookup+0xb8>

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
80102347:	90                   	nop
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102348:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
8010234c:	8b 45 08             	mov    0x8(%ebp),%eax
8010234f:	8b 40 18             	mov    0x18(%eax),%eax
80102352:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80102355:	0f 87 76 ff ff ff    	ja     801022d1 <dirlookup+0x29>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
8010235b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102360:	c9                   	leave  
80102361:	c3                   	ret    

80102362 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102362:	55                   	push   %ebp
80102363:	89 e5                	mov    %esp,%ebp
80102365:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102368:	83 ec 04             	sub    $0x4,%esp
8010236b:	6a 00                	push   $0x0
8010236d:	ff 75 0c             	pushl  0xc(%ebp)
80102370:	ff 75 08             	pushl  0x8(%ebp)
80102373:	e8 30 ff ff ff       	call   801022a8 <dirlookup>
80102378:	83 c4 10             	add    $0x10,%esp
8010237b:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010237e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102382:	74 18                	je     8010239c <dirlink+0x3a>
    iput(ip);
80102384:	83 ec 0c             	sub    $0xc,%esp
80102387:	ff 75 f0             	pushl  -0x10(%ebp)
8010238a:	e8 32 f7 ff ff       	call   80101ac1 <iput>
8010238f:	83 c4 10             	add    $0x10,%esp
    return -1;
80102392:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102397:	e9 9c 00 00 00       	jmp    80102438 <dirlink+0xd6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
8010239c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801023a3:	eb 39                	jmp    801023de <dirlink+0x7c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801023a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023a8:	6a 10                	push   $0x10
801023aa:	50                   	push   %eax
801023ab:	8d 45 e0             	lea    -0x20(%ebp),%eax
801023ae:	50                   	push   %eax
801023af:	ff 75 08             	pushl  0x8(%ebp)
801023b2:	e8 f7 fb ff ff       	call   80101fae <readi>
801023b7:	83 c4 10             	add    $0x10,%esp
801023ba:	83 f8 10             	cmp    $0x10,%eax
801023bd:	74 0d                	je     801023cc <dirlink+0x6a>
      panic("dirlink read");
801023bf:	83 ec 0c             	sub    $0xc,%esp
801023c2:	68 4f b5 10 80       	push   $0x8010b54f
801023c7:	e8 9a e1 ff ff       	call   80100566 <panic>
    if(de.inum == 0)
801023cc:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801023d0:	66 85 c0             	test   %ax,%ax
801023d3:	74 18                	je     801023ed <dirlink+0x8b>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801023d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023d8:	83 c0 10             	add    $0x10,%eax
801023db:	89 45 f4             	mov    %eax,-0xc(%ebp)
801023de:	8b 45 08             	mov    0x8(%ebp),%eax
801023e1:	8b 50 18             	mov    0x18(%eax),%edx
801023e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023e7:	39 c2                	cmp    %eax,%edx
801023e9:	77 ba                	ja     801023a5 <dirlink+0x43>
801023eb:	eb 01                	jmp    801023ee <dirlink+0x8c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      break;
801023ed:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
801023ee:	83 ec 04             	sub    $0x4,%esp
801023f1:	6a 0e                	push   $0xe
801023f3:	ff 75 0c             	pushl  0xc(%ebp)
801023f6:	8d 45 e0             	lea    -0x20(%ebp),%eax
801023f9:	83 c0 02             	add    $0x2,%eax
801023fc:	50                   	push   %eax
801023fd:	e8 49 2e 00 00       	call   8010524b <strncpy>
80102402:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
80102405:	8b 45 10             	mov    0x10(%ebp),%eax
80102408:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010240c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010240f:	6a 10                	push   $0x10
80102411:	50                   	push   %eax
80102412:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102415:	50                   	push   %eax
80102416:	ff 75 08             	pushl  0x8(%ebp)
80102419:	e8 e7 fc ff ff       	call   80102105 <writei>
8010241e:	83 c4 10             	add    $0x10,%esp
80102421:	83 f8 10             	cmp    $0x10,%eax
80102424:	74 0d                	je     80102433 <dirlink+0xd1>
    panic("dirlink");
80102426:	83 ec 0c             	sub    $0xc,%esp
80102429:	68 5c b5 10 80       	push   $0x8010b55c
8010242e:	e8 33 e1 ff ff       	call   80100566 <panic>
  
  return 0;
80102433:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102438:	c9                   	leave  
80102439:	c3                   	ret    

8010243a <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
8010243a:	55                   	push   %ebp
8010243b:	89 e5                	mov    %esp,%ebp
8010243d:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
80102440:	eb 04                	jmp    80102446 <skipelem+0xc>
    path++;
80102442:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80102446:	8b 45 08             	mov    0x8(%ebp),%eax
80102449:	0f b6 00             	movzbl (%eax),%eax
8010244c:	3c 2f                	cmp    $0x2f,%al
8010244e:	74 f2                	je     80102442 <skipelem+0x8>
    path++;
  if(*path == 0)
80102450:	8b 45 08             	mov    0x8(%ebp),%eax
80102453:	0f b6 00             	movzbl (%eax),%eax
80102456:	84 c0                	test   %al,%al
80102458:	75 07                	jne    80102461 <skipelem+0x27>
    return 0;
8010245a:	b8 00 00 00 00       	mov    $0x0,%eax
8010245f:	eb 7b                	jmp    801024dc <skipelem+0xa2>
  s = path;
80102461:	8b 45 08             	mov    0x8(%ebp),%eax
80102464:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
80102467:	eb 04                	jmp    8010246d <skipelem+0x33>
    path++;
80102469:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
8010246d:	8b 45 08             	mov    0x8(%ebp),%eax
80102470:	0f b6 00             	movzbl (%eax),%eax
80102473:	3c 2f                	cmp    $0x2f,%al
80102475:	74 0a                	je     80102481 <skipelem+0x47>
80102477:	8b 45 08             	mov    0x8(%ebp),%eax
8010247a:	0f b6 00             	movzbl (%eax),%eax
8010247d:	84 c0                	test   %al,%al
8010247f:	75 e8                	jne    80102469 <skipelem+0x2f>
    path++;
  len = path - s;
80102481:	8b 55 08             	mov    0x8(%ebp),%edx
80102484:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102487:	29 c2                	sub    %eax,%edx
80102489:	89 d0                	mov    %edx,%eax
8010248b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
8010248e:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80102492:	7e 15                	jle    801024a9 <skipelem+0x6f>
    memmove(name, s, DIRSIZ);
80102494:	83 ec 04             	sub    $0x4,%esp
80102497:	6a 0e                	push   $0xe
80102499:	ff 75 f4             	pushl  -0xc(%ebp)
8010249c:	ff 75 0c             	pushl  0xc(%ebp)
8010249f:	e8 bb 2c 00 00       	call   8010515f <memmove>
801024a4:	83 c4 10             	add    $0x10,%esp
801024a7:	eb 26                	jmp    801024cf <skipelem+0x95>
  else {
    memmove(name, s, len);
801024a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801024ac:	83 ec 04             	sub    $0x4,%esp
801024af:	50                   	push   %eax
801024b0:	ff 75 f4             	pushl  -0xc(%ebp)
801024b3:	ff 75 0c             	pushl  0xc(%ebp)
801024b6:	e8 a4 2c 00 00       	call   8010515f <memmove>
801024bb:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
801024be:	8b 55 f0             	mov    -0x10(%ebp),%edx
801024c1:	8b 45 0c             	mov    0xc(%ebp),%eax
801024c4:	01 d0                	add    %edx,%eax
801024c6:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801024c9:	eb 04                	jmp    801024cf <skipelem+0x95>
    path++;
801024cb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801024cf:	8b 45 08             	mov    0x8(%ebp),%eax
801024d2:	0f b6 00             	movzbl (%eax),%eax
801024d5:	3c 2f                	cmp    $0x2f,%al
801024d7:	74 f2                	je     801024cb <skipelem+0x91>
    path++;
  return path;
801024d9:	8b 45 08             	mov    0x8(%ebp),%eax
}
801024dc:	c9                   	leave  
801024dd:	c3                   	ret    

801024de <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801024de:	55                   	push   %ebp
801024df:	89 e5                	mov    %esp,%ebp
801024e1:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
801024e4:	8b 45 08             	mov    0x8(%ebp),%eax
801024e7:	0f b6 00             	movzbl (%eax),%eax
801024ea:	3c 2f                	cmp    $0x2f,%al
801024ec:	75 17                	jne    80102505 <namex+0x27>
    ip = iget(ROOTDEV, ROOTINO);
801024ee:	83 ec 08             	sub    $0x8,%esp
801024f1:	6a 01                	push   $0x1
801024f3:	6a 01                	push   $0x1
801024f5:	e8 e4 f2 ff ff       	call   801017de <iget>
801024fa:	83 c4 10             	add    $0x10,%esp
801024fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102500:	e9 bb 00 00 00       	jmp    801025c0 <namex+0xe2>
  else
    ip = idup(proc->cwd);
80102505:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010250b:	8b 40 68             	mov    0x68(%eax),%eax
8010250e:	83 ec 0c             	sub    $0xc,%esp
80102511:	50                   	push   %eax
80102512:	e8 a6 f3 ff ff       	call   801018bd <idup>
80102517:	83 c4 10             	add    $0x10,%esp
8010251a:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
8010251d:	e9 9e 00 00 00       	jmp    801025c0 <namex+0xe2>
    ilock(ip);
80102522:	83 ec 0c             	sub    $0xc,%esp
80102525:	ff 75 f4             	pushl  -0xc(%ebp)
80102528:	e8 ca f3 ff ff       	call   801018f7 <ilock>
8010252d:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
80102530:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102533:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102537:	66 83 f8 01          	cmp    $0x1,%ax
8010253b:	74 18                	je     80102555 <namex+0x77>
      iunlockput(ip);
8010253d:	83 ec 0c             	sub    $0xc,%esp
80102540:	ff 75 f4             	pushl  -0xc(%ebp)
80102543:	e8 69 f6 ff ff       	call   80101bb1 <iunlockput>
80102548:	83 c4 10             	add    $0x10,%esp
      return 0;
8010254b:	b8 00 00 00 00       	mov    $0x0,%eax
80102550:	e9 a7 00 00 00       	jmp    801025fc <namex+0x11e>
    }
    if(nameiparent && *path == '\0'){
80102555:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102559:	74 20                	je     8010257b <namex+0x9d>
8010255b:	8b 45 08             	mov    0x8(%ebp),%eax
8010255e:	0f b6 00             	movzbl (%eax),%eax
80102561:	84 c0                	test   %al,%al
80102563:	75 16                	jne    8010257b <namex+0x9d>
      // Stop one level early.
      iunlock(ip);
80102565:	83 ec 0c             	sub    $0xc,%esp
80102568:	ff 75 f4             	pushl  -0xc(%ebp)
8010256b:	e8 df f4 ff ff       	call   80101a4f <iunlock>
80102570:	83 c4 10             	add    $0x10,%esp
      return ip;
80102573:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102576:	e9 81 00 00 00       	jmp    801025fc <namex+0x11e>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
8010257b:	83 ec 04             	sub    $0x4,%esp
8010257e:	6a 00                	push   $0x0
80102580:	ff 75 10             	pushl  0x10(%ebp)
80102583:	ff 75 f4             	pushl  -0xc(%ebp)
80102586:	e8 1d fd ff ff       	call   801022a8 <dirlookup>
8010258b:	83 c4 10             	add    $0x10,%esp
8010258e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102591:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102595:	75 15                	jne    801025ac <namex+0xce>
      iunlockput(ip);
80102597:	83 ec 0c             	sub    $0xc,%esp
8010259a:	ff 75 f4             	pushl  -0xc(%ebp)
8010259d:	e8 0f f6 ff ff       	call   80101bb1 <iunlockput>
801025a2:	83 c4 10             	add    $0x10,%esp
      return 0;
801025a5:	b8 00 00 00 00       	mov    $0x0,%eax
801025aa:	eb 50                	jmp    801025fc <namex+0x11e>
    }
    iunlockput(ip);
801025ac:	83 ec 0c             	sub    $0xc,%esp
801025af:	ff 75 f4             	pushl  -0xc(%ebp)
801025b2:	e8 fa f5 ff ff       	call   80101bb1 <iunlockput>
801025b7:	83 c4 10             	add    $0x10,%esp
    ip = next;
801025ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
801025bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
801025c0:	83 ec 08             	sub    $0x8,%esp
801025c3:	ff 75 10             	pushl  0x10(%ebp)
801025c6:	ff 75 08             	pushl  0x8(%ebp)
801025c9:	e8 6c fe ff ff       	call   8010243a <skipelem>
801025ce:	83 c4 10             	add    $0x10,%esp
801025d1:	89 45 08             	mov    %eax,0x8(%ebp)
801025d4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801025d8:	0f 85 44 ff ff ff    	jne    80102522 <namex+0x44>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801025de:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801025e2:	74 15                	je     801025f9 <namex+0x11b>
    iput(ip);
801025e4:	83 ec 0c             	sub    $0xc,%esp
801025e7:	ff 75 f4             	pushl  -0xc(%ebp)
801025ea:	e8 d2 f4 ff ff       	call   80101ac1 <iput>
801025ef:	83 c4 10             	add    $0x10,%esp
    return 0;
801025f2:	b8 00 00 00 00       	mov    $0x0,%eax
801025f7:	eb 03                	jmp    801025fc <namex+0x11e>
  }
  return ip;
801025f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801025fc:	c9                   	leave  
801025fd:	c3                   	ret    

801025fe <namei>:

struct inode*
namei(char *path)
{
801025fe:	55                   	push   %ebp
801025ff:	89 e5                	mov    %esp,%ebp
80102601:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102604:	83 ec 04             	sub    $0x4,%esp
80102607:	8d 45 ea             	lea    -0x16(%ebp),%eax
8010260a:	50                   	push   %eax
8010260b:	6a 00                	push   $0x0
8010260d:	ff 75 08             	pushl  0x8(%ebp)
80102610:	e8 c9 fe ff ff       	call   801024de <namex>
80102615:	83 c4 10             	add    $0x10,%esp
}
80102618:	c9                   	leave  
80102619:	c3                   	ret    

8010261a <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
8010261a:	55                   	push   %ebp
8010261b:	89 e5                	mov    %esp,%ebp
8010261d:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
80102620:	83 ec 04             	sub    $0x4,%esp
80102623:	ff 75 0c             	pushl  0xc(%ebp)
80102626:	6a 01                	push   $0x1
80102628:	ff 75 08             	pushl  0x8(%ebp)
8010262b:	e8 ae fe ff ff       	call   801024de <namex>
80102630:	83 c4 10             	add    $0x10,%esp
}
80102633:	c9                   	leave  
80102634:	c3                   	ret    

80102635 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102635:	55                   	push   %ebp
80102636:	89 e5                	mov    %esp,%ebp
80102638:	83 ec 14             	sub    $0x14,%esp
8010263b:	8b 45 08             	mov    0x8(%ebp),%eax
8010263e:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102642:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102646:	89 c2                	mov    %eax,%edx
80102648:	ec                   	in     (%dx),%al
80102649:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
8010264c:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102650:	c9                   	leave  
80102651:	c3                   	ret    

80102652 <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
80102652:	55                   	push   %ebp
80102653:	89 e5                	mov    %esp,%ebp
80102655:	57                   	push   %edi
80102656:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
80102657:	8b 55 08             	mov    0x8(%ebp),%edx
8010265a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010265d:	8b 45 10             	mov    0x10(%ebp),%eax
80102660:	89 cb                	mov    %ecx,%ebx
80102662:	89 df                	mov    %ebx,%edi
80102664:	89 c1                	mov    %eax,%ecx
80102666:	fc                   	cld    
80102667:	f3 6d                	rep insl (%dx),%es:(%edi)
80102669:	89 c8                	mov    %ecx,%eax
8010266b:	89 fb                	mov    %edi,%ebx
8010266d:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102670:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
80102673:	90                   	nop
80102674:	5b                   	pop    %ebx
80102675:	5f                   	pop    %edi
80102676:	5d                   	pop    %ebp
80102677:	c3                   	ret    

80102678 <outb>:

static inline void
outb(ushort port, uchar data)
{
80102678:	55                   	push   %ebp
80102679:	89 e5                	mov    %esp,%ebp
8010267b:	83 ec 08             	sub    $0x8,%esp
8010267e:	8b 55 08             	mov    0x8(%ebp),%edx
80102681:	8b 45 0c             	mov    0xc(%ebp),%eax
80102684:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102688:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010268b:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010268f:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102693:	ee                   	out    %al,(%dx)
}
80102694:	90                   	nop
80102695:	c9                   	leave  
80102696:	c3                   	ret    

80102697 <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
80102697:	55                   	push   %ebp
80102698:	89 e5                	mov    %esp,%ebp
8010269a:	56                   	push   %esi
8010269b:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
8010269c:	8b 55 08             	mov    0x8(%ebp),%edx
8010269f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801026a2:	8b 45 10             	mov    0x10(%ebp),%eax
801026a5:	89 cb                	mov    %ecx,%ebx
801026a7:	89 de                	mov    %ebx,%esi
801026a9:	89 c1                	mov    %eax,%ecx
801026ab:	fc                   	cld    
801026ac:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801026ae:	89 c8                	mov    %ecx,%eax
801026b0:	89 f3                	mov    %esi,%ebx
801026b2:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801026b5:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
801026b8:	90                   	nop
801026b9:	5b                   	pop    %ebx
801026ba:	5e                   	pop    %esi
801026bb:	5d                   	pop    %ebp
801026bc:	c3                   	ret    

801026bd <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
801026bd:	55                   	push   %ebp
801026be:	89 e5                	mov    %esp,%ebp
801026c0:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
801026c3:	90                   	nop
801026c4:	68 f7 01 00 00       	push   $0x1f7
801026c9:	e8 67 ff ff ff       	call   80102635 <inb>
801026ce:	83 c4 04             	add    $0x4,%esp
801026d1:	0f b6 c0             	movzbl %al,%eax
801026d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
801026d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
801026da:	25 c0 00 00 00       	and    $0xc0,%eax
801026df:	83 f8 40             	cmp    $0x40,%eax
801026e2:	75 e0                	jne    801026c4 <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801026e4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801026e8:	74 11                	je     801026fb <idewait+0x3e>
801026ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
801026ed:	83 e0 21             	and    $0x21,%eax
801026f0:	85 c0                	test   %eax,%eax
801026f2:	74 07                	je     801026fb <idewait+0x3e>
    return -1;
801026f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801026f9:	eb 05                	jmp    80102700 <idewait+0x43>
  return 0;
801026fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102700:	c9                   	leave  
80102701:	c3                   	ret    

80102702 <ideinit>:

void
ideinit(void)
{
80102702:	55                   	push   %ebp
80102703:	89 e5                	mov    %esp,%ebp
80102705:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
80102708:	83 ec 08             	sub    $0x8,%esp
8010270b:	68 64 b5 10 80       	push   $0x8010b564
80102710:	68 40 e6 10 80       	push   $0x8010e640
80102715:	e8 01 27 00 00       	call   80104e1b <initlock>
8010271a:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
8010271d:	83 ec 0c             	sub    $0xc,%esp
80102720:	6a 0e                	push   $0xe
80102722:	e8 81 16 00 00       	call   80103da8 <picenable>
80102727:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
8010272a:	a1 60 2f 11 80       	mov    0x80112f60,%eax
8010272f:	83 e8 01             	sub    $0x1,%eax
80102732:	83 ec 08             	sub    $0x8,%esp
80102735:	50                   	push   %eax
80102736:	6a 0e                	push   $0xe
80102738:	e8 37 04 00 00       	call   80102b74 <ioapicenable>
8010273d:	83 c4 10             	add    $0x10,%esp
  idewait(0);
80102740:	83 ec 0c             	sub    $0xc,%esp
80102743:	6a 00                	push   $0x0
80102745:	e8 73 ff ff ff       	call   801026bd <idewait>
8010274a:	83 c4 10             	add    $0x10,%esp
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
8010274d:	83 ec 08             	sub    $0x8,%esp
80102750:	68 f0 00 00 00       	push   $0xf0
80102755:	68 f6 01 00 00       	push   $0x1f6
8010275a:	e8 19 ff ff ff       	call   80102678 <outb>
8010275f:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
80102762:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102769:	eb 24                	jmp    8010278f <ideinit+0x8d>
    if(inb(0x1f7) != 0){
8010276b:	83 ec 0c             	sub    $0xc,%esp
8010276e:	68 f7 01 00 00       	push   $0x1f7
80102773:	e8 bd fe ff ff       	call   80102635 <inb>
80102778:	83 c4 10             	add    $0x10,%esp
8010277b:	84 c0                	test   %al,%al
8010277d:	74 0c                	je     8010278b <ideinit+0x89>
      havedisk1 = 1;
8010277f:	c7 05 78 e6 10 80 01 	movl   $0x1,0x8010e678
80102786:	00 00 00 
      break;
80102789:	eb 0d                	jmp    80102798 <ideinit+0x96>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
8010278b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010278f:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
80102796:	7e d3                	jle    8010276b <ideinit+0x69>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
80102798:	83 ec 08             	sub    $0x8,%esp
8010279b:	68 e0 00 00 00       	push   $0xe0
801027a0:	68 f6 01 00 00       	push   $0x1f6
801027a5:	e8 ce fe ff ff       	call   80102678 <outb>
801027aa:	83 c4 10             	add    $0x10,%esp
}
801027ad:	90                   	nop
801027ae:	c9                   	leave  
801027af:	c3                   	ret    

801027b0 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801027b0:	55                   	push   %ebp
801027b1:	89 e5                	mov    %esp,%ebp
801027b3:	83 ec 08             	sub    $0x8,%esp
  if(b == 0)
801027b6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801027ba:	75 0d                	jne    801027c9 <idestart+0x19>
    panic("idestart");
801027bc:	83 ec 0c             	sub    $0xc,%esp
801027bf:	68 68 b5 10 80       	push   $0x8010b568
801027c4:	e8 9d dd ff ff       	call   80100566 <panic>

  idewait(0);
801027c9:	83 ec 0c             	sub    $0xc,%esp
801027cc:	6a 00                	push   $0x0
801027ce:	e8 ea fe ff ff       	call   801026bd <idewait>
801027d3:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
801027d6:	83 ec 08             	sub    $0x8,%esp
801027d9:	6a 00                	push   $0x0
801027db:	68 f6 03 00 00       	push   $0x3f6
801027e0:	e8 93 fe ff ff       	call   80102678 <outb>
801027e5:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, 1);  // number of sectors
801027e8:	83 ec 08             	sub    $0x8,%esp
801027eb:	6a 01                	push   $0x1
801027ed:	68 f2 01 00 00       	push   $0x1f2
801027f2:	e8 81 fe ff ff       	call   80102678 <outb>
801027f7:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, b->sector & 0xff);
801027fa:	8b 45 08             	mov    0x8(%ebp),%eax
801027fd:	8b 40 08             	mov    0x8(%eax),%eax
80102800:	0f b6 c0             	movzbl %al,%eax
80102803:	83 ec 08             	sub    $0x8,%esp
80102806:	50                   	push   %eax
80102807:	68 f3 01 00 00       	push   $0x1f3
8010280c:	e8 67 fe ff ff       	call   80102678 <outb>
80102811:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (b->sector >> 8) & 0xff);
80102814:	8b 45 08             	mov    0x8(%ebp),%eax
80102817:	8b 40 08             	mov    0x8(%eax),%eax
8010281a:	c1 e8 08             	shr    $0x8,%eax
8010281d:	0f b6 c0             	movzbl %al,%eax
80102820:	83 ec 08             	sub    $0x8,%esp
80102823:	50                   	push   %eax
80102824:	68 f4 01 00 00       	push   $0x1f4
80102829:	e8 4a fe ff ff       	call   80102678 <outb>
8010282e:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (b->sector >> 16) & 0xff);
80102831:	8b 45 08             	mov    0x8(%ebp),%eax
80102834:	8b 40 08             	mov    0x8(%eax),%eax
80102837:	c1 e8 10             	shr    $0x10,%eax
8010283a:	0f b6 c0             	movzbl %al,%eax
8010283d:	83 ec 08             	sub    $0x8,%esp
80102840:	50                   	push   %eax
80102841:	68 f5 01 00 00       	push   $0x1f5
80102846:	e8 2d fe ff ff       	call   80102678 <outb>
8010284b:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
8010284e:	8b 45 08             	mov    0x8(%ebp),%eax
80102851:	8b 40 04             	mov    0x4(%eax),%eax
80102854:	83 e0 01             	and    $0x1,%eax
80102857:	c1 e0 04             	shl    $0x4,%eax
8010285a:	89 c2                	mov    %eax,%edx
8010285c:	8b 45 08             	mov    0x8(%ebp),%eax
8010285f:	8b 40 08             	mov    0x8(%eax),%eax
80102862:	c1 e8 18             	shr    $0x18,%eax
80102865:	83 e0 0f             	and    $0xf,%eax
80102868:	09 d0                	or     %edx,%eax
8010286a:	83 c8 e0             	or     $0xffffffe0,%eax
8010286d:	0f b6 c0             	movzbl %al,%eax
80102870:	83 ec 08             	sub    $0x8,%esp
80102873:	50                   	push   %eax
80102874:	68 f6 01 00 00       	push   $0x1f6
80102879:	e8 fa fd ff ff       	call   80102678 <outb>
8010287e:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
80102881:	8b 45 08             	mov    0x8(%ebp),%eax
80102884:	8b 00                	mov    (%eax),%eax
80102886:	83 e0 04             	and    $0x4,%eax
80102889:	85 c0                	test   %eax,%eax
8010288b:	74 30                	je     801028bd <idestart+0x10d>
    outb(0x1f7, IDE_CMD_WRITE);
8010288d:	83 ec 08             	sub    $0x8,%esp
80102890:	6a 30                	push   $0x30
80102892:	68 f7 01 00 00       	push   $0x1f7
80102897:	e8 dc fd ff ff       	call   80102678 <outb>
8010289c:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, 512/4);
8010289f:	8b 45 08             	mov    0x8(%ebp),%eax
801028a2:	83 c0 18             	add    $0x18,%eax
801028a5:	83 ec 04             	sub    $0x4,%esp
801028a8:	68 80 00 00 00       	push   $0x80
801028ad:	50                   	push   %eax
801028ae:	68 f0 01 00 00       	push   $0x1f0
801028b3:	e8 df fd ff ff       	call   80102697 <outsl>
801028b8:	83 c4 10             	add    $0x10,%esp
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
801028bb:	eb 12                	jmp    801028cf <idestart+0x11f>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  } else {
    outb(0x1f7, IDE_CMD_READ);
801028bd:	83 ec 08             	sub    $0x8,%esp
801028c0:	6a 20                	push   $0x20
801028c2:	68 f7 01 00 00       	push   $0x1f7
801028c7:	e8 ac fd ff ff       	call   80102678 <outb>
801028cc:	83 c4 10             	add    $0x10,%esp
  }
}
801028cf:	90                   	nop
801028d0:	c9                   	leave  
801028d1:	c3                   	ret    

801028d2 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801028d2:	55                   	push   %ebp
801028d3:	89 e5                	mov    %esp,%ebp
801028d5:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801028d8:	83 ec 0c             	sub    $0xc,%esp
801028db:	68 40 e6 10 80       	push   $0x8010e640
801028e0:	e8 58 25 00 00       	call   80104e3d <acquire>
801028e5:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
801028e8:	a1 74 e6 10 80       	mov    0x8010e674,%eax
801028ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028f0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801028f4:	75 15                	jne    8010290b <ideintr+0x39>
    release(&idelock);
801028f6:	83 ec 0c             	sub    $0xc,%esp
801028f9:	68 40 e6 10 80       	push   $0x8010e640
801028fe:	e8 a1 25 00 00       	call   80104ea4 <release>
80102903:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
80102906:	e9 9a 00 00 00       	jmp    801029a5 <ideintr+0xd3>
  }
  idequeue = b->qnext;
8010290b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010290e:	8b 40 14             	mov    0x14(%eax),%eax
80102911:	a3 74 e6 10 80       	mov    %eax,0x8010e674

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102916:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102919:	8b 00                	mov    (%eax),%eax
8010291b:	83 e0 04             	and    $0x4,%eax
8010291e:	85 c0                	test   %eax,%eax
80102920:	75 2d                	jne    8010294f <ideintr+0x7d>
80102922:	83 ec 0c             	sub    $0xc,%esp
80102925:	6a 01                	push   $0x1
80102927:	e8 91 fd ff ff       	call   801026bd <idewait>
8010292c:	83 c4 10             	add    $0x10,%esp
8010292f:	85 c0                	test   %eax,%eax
80102931:	78 1c                	js     8010294f <ideintr+0x7d>
    insl(0x1f0, b->data, 512/4);
80102933:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102936:	83 c0 18             	add    $0x18,%eax
80102939:	83 ec 04             	sub    $0x4,%esp
8010293c:	68 80 00 00 00       	push   $0x80
80102941:	50                   	push   %eax
80102942:	68 f0 01 00 00       	push   $0x1f0
80102947:	e8 06 fd ff ff       	call   80102652 <insl>
8010294c:	83 c4 10             	add    $0x10,%esp
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010294f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102952:	8b 00                	mov    (%eax),%eax
80102954:	83 c8 02             	or     $0x2,%eax
80102957:	89 c2                	mov    %eax,%edx
80102959:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010295c:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
8010295e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102961:	8b 00                	mov    (%eax),%eax
80102963:	83 e0 fb             	and    $0xfffffffb,%eax
80102966:	89 c2                	mov    %eax,%edx
80102968:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010296b:	89 10                	mov    %edx,(%eax)
  wakeup(b);
8010296d:	83 ec 0c             	sub    $0xc,%esp
80102970:	ff 75 f4             	pushl  -0xc(%ebp)
80102973:	e8 b7 22 00 00       	call   80104c2f <wakeup>
80102978:	83 c4 10             	add    $0x10,%esp
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
8010297b:	a1 74 e6 10 80       	mov    0x8010e674,%eax
80102980:	85 c0                	test   %eax,%eax
80102982:	74 11                	je     80102995 <ideintr+0xc3>
    idestart(idequeue);
80102984:	a1 74 e6 10 80       	mov    0x8010e674,%eax
80102989:	83 ec 0c             	sub    $0xc,%esp
8010298c:	50                   	push   %eax
8010298d:	e8 1e fe ff ff       	call   801027b0 <idestart>
80102992:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
80102995:	83 ec 0c             	sub    $0xc,%esp
80102998:	68 40 e6 10 80       	push   $0x8010e640
8010299d:	e8 02 25 00 00       	call   80104ea4 <release>
801029a2:	83 c4 10             	add    $0x10,%esp
}
801029a5:	c9                   	leave  
801029a6:	c3                   	ret    

801029a7 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801029a7:	55                   	push   %ebp
801029a8:	89 e5                	mov    %esp,%ebp
801029aa:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
801029ad:	8b 45 08             	mov    0x8(%ebp),%eax
801029b0:	8b 00                	mov    (%eax),%eax
801029b2:	83 e0 01             	and    $0x1,%eax
801029b5:	85 c0                	test   %eax,%eax
801029b7:	75 0d                	jne    801029c6 <iderw+0x1f>
    panic("iderw: buf not busy");
801029b9:	83 ec 0c             	sub    $0xc,%esp
801029bc:	68 71 b5 10 80       	push   $0x8010b571
801029c1:	e8 a0 db ff ff       	call   80100566 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801029c6:	8b 45 08             	mov    0x8(%ebp),%eax
801029c9:	8b 00                	mov    (%eax),%eax
801029cb:	83 e0 06             	and    $0x6,%eax
801029ce:	83 f8 02             	cmp    $0x2,%eax
801029d1:	75 0d                	jne    801029e0 <iderw+0x39>
    panic("iderw: nothing to do");
801029d3:	83 ec 0c             	sub    $0xc,%esp
801029d6:	68 85 b5 10 80       	push   $0x8010b585
801029db:	e8 86 db ff ff       	call   80100566 <panic>
  if(b->dev != 0 && !havedisk1)
801029e0:	8b 45 08             	mov    0x8(%ebp),%eax
801029e3:	8b 40 04             	mov    0x4(%eax),%eax
801029e6:	85 c0                	test   %eax,%eax
801029e8:	74 16                	je     80102a00 <iderw+0x59>
801029ea:	a1 78 e6 10 80       	mov    0x8010e678,%eax
801029ef:	85 c0                	test   %eax,%eax
801029f1:	75 0d                	jne    80102a00 <iderw+0x59>
    panic("iderw: ide disk 1 not present");
801029f3:	83 ec 0c             	sub    $0xc,%esp
801029f6:	68 9a b5 10 80       	push   $0x8010b59a
801029fb:	e8 66 db ff ff       	call   80100566 <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102a00:	83 ec 0c             	sub    $0xc,%esp
80102a03:	68 40 e6 10 80       	push   $0x8010e640
80102a08:	e8 30 24 00 00       	call   80104e3d <acquire>
80102a0d:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
80102a10:	8b 45 08             	mov    0x8(%ebp),%eax
80102a13:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102a1a:	c7 45 f4 74 e6 10 80 	movl   $0x8010e674,-0xc(%ebp)
80102a21:	eb 0b                	jmp    80102a2e <iderw+0x87>
80102a23:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a26:	8b 00                	mov    (%eax),%eax
80102a28:	83 c0 14             	add    $0x14,%eax
80102a2b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102a2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a31:	8b 00                	mov    (%eax),%eax
80102a33:	85 c0                	test   %eax,%eax
80102a35:	75 ec                	jne    80102a23 <iderw+0x7c>
    ;
  *pp = b;
80102a37:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a3a:	8b 55 08             	mov    0x8(%ebp),%edx
80102a3d:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
80102a3f:	a1 74 e6 10 80       	mov    0x8010e674,%eax
80102a44:	3b 45 08             	cmp    0x8(%ebp),%eax
80102a47:	75 23                	jne    80102a6c <iderw+0xc5>
    idestart(b);
80102a49:	83 ec 0c             	sub    $0xc,%esp
80102a4c:	ff 75 08             	pushl  0x8(%ebp)
80102a4f:	e8 5c fd ff ff       	call   801027b0 <idestart>
80102a54:	83 c4 10             	add    $0x10,%esp
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102a57:	eb 13                	jmp    80102a6c <iderw+0xc5>
    sleep(b, &idelock);
80102a59:	83 ec 08             	sub    $0x8,%esp
80102a5c:	68 40 e6 10 80       	push   $0x8010e640
80102a61:	ff 75 08             	pushl  0x8(%ebp)
80102a64:	e8 db 20 00 00       	call   80104b44 <sleep>
80102a69:	83 c4 10             	add    $0x10,%esp
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102a6c:	8b 45 08             	mov    0x8(%ebp),%eax
80102a6f:	8b 00                	mov    (%eax),%eax
80102a71:	83 e0 06             	and    $0x6,%eax
80102a74:	83 f8 02             	cmp    $0x2,%eax
80102a77:	75 e0                	jne    80102a59 <iderw+0xb2>
    sleep(b, &idelock);
  }

  release(&idelock);
80102a79:	83 ec 0c             	sub    $0xc,%esp
80102a7c:	68 40 e6 10 80       	push   $0x8010e640
80102a81:	e8 1e 24 00 00       	call   80104ea4 <release>
80102a86:	83 c4 10             	add    $0x10,%esp
}
80102a89:	90                   	nop
80102a8a:	c9                   	leave  
80102a8b:	c3                   	ret    

80102a8c <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102a8c:	55                   	push   %ebp
80102a8d:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102a8f:	a1 94 28 11 80       	mov    0x80112894,%eax
80102a94:	8b 55 08             	mov    0x8(%ebp),%edx
80102a97:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102a99:	a1 94 28 11 80       	mov    0x80112894,%eax
80102a9e:	8b 40 10             	mov    0x10(%eax),%eax
}
80102aa1:	5d                   	pop    %ebp
80102aa2:	c3                   	ret    

80102aa3 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102aa3:	55                   	push   %ebp
80102aa4:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102aa6:	a1 94 28 11 80       	mov    0x80112894,%eax
80102aab:	8b 55 08             	mov    0x8(%ebp),%edx
80102aae:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102ab0:	a1 94 28 11 80       	mov    0x80112894,%eax
80102ab5:	8b 55 0c             	mov    0xc(%ebp),%edx
80102ab8:	89 50 10             	mov    %edx,0x10(%eax)
}
80102abb:	90                   	nop
80102abc:	5d                   	pop    %ebp
80102abd:	c3                   	ret    

80102abe <ioapicinit>:

void
ioapicinit(void)
{
80102abe:	55                   	push   %ebp
80102abf:	89 e5                	mov    %esp,%ebp
80102ac1:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  if(!ismp)
80102ac4:	a1 64 29 11 80       	mov    0x80112964,%eax
80102ac9:	85 c0                	test   %eax,%eax
80102acb:	0f 84 a0 00 00 00    	je     80102b71 <ioapicinit+0xb3>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102ad1:	c7 05 94 28 11 80 00 	movl   $0xfec00000,0x80112894
80102ad8:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102adb:	6a 01                	push   $0x1
80102add:	e8 aa ff ff ff       	call   80102a8c <ioapicread>
80102ae2:	83 c4 04             	add    $0x4,%esp
80102ae5:	c1 e8 10             	shr    $0x10,%eax
80102ae8:	25 ff 00 00 00       	and    $0xff,%eax
80102aed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80102af0:	6a 00                	push   $0x0
80102af2:	e8 95 ff ff ff       	call   80102a8c <ioapicread>
80102af7:	83 c4 04             	add    $0x4,%esp
80102afa:	c1 e8 18             	shr    $0x18,%eax
80102afd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102b00:	0f b6 05 60 29 11 80 	movzbl 0x80112960,%eax
80102b07:	0f b6 c0             	movzbl %al,%eax
80102b0a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80102b0d:	74 10                	je     80102b1f <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102b0f:	83 ec 0c             	sub    $0xc,%esp
80102b12:	68 b8 b5 10 80       	push   $0x8010b5b8
80102b17:	e8 aa d8 ff ff       	call   801003c6 <cprintf>
80102b1c:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102b1f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102b26:	eb 3f                	jmp    80102b67 <ioapicinit+0xa9>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102b28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b2b:	83 c0 20             	add    $0x20,%eax
80102b2e:	0d 00 00 01 00       	or     $0x10000,%eax
80102b33:	89 c2                	mov    %eax,%edx
80102b35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b38:	83 c0 08             	add    $0x8,%eax
80102b3b:	01 c0                	add    %eax,%eax
80102b3d:	83 ec 08             	sub    $0x8,%esp
80102b40:	52                   	push   %edx
80102b41:	50                   	push   %eax
80102b42:	e8 5c ff ff ff       	call   80102aa3 <ioapicwrite>
80102b47:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102b4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b4d:	83 c0 08             	add    $0x8,%eax
80102b50:	01 c0                	add    %eax,%eax
80102b52:	83 c0 01             	add    $0x1,%eax
80102b55:	83 ec 08             	sub    $0x8,%esp
80102b58:	6a 00                	push   $0x0
80102b5a:	50                   	push   %eax
80102b5b:	e8 43 ff ff ff       	call   80102aa3 <ioapicwrite>
80102b60:	83 c4 10             	add    $0x10,%esp
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102b63:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102b67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b6a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102b6d:	7e b9                	jle    80102b28 <ioapicinit+0x6a>
80102b6f:	eb 01                	jmp    80102b72 <ioapicinit+0xb4>
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
    return;
80102b71:	90                   	nop
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102b72:	c9                   	leave  
80102b73:	c3                   	ret    

80102b74 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102b74:	55                   	push   %ebp
80102b75:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102b77:	a1 64 29 11 80       	mov    0x80112964,%eax
80102b7c:	85 c0                	test   %eax,%eax
80102b7e:	74 39                	je     80102bb9 <ioapicenable+0x45>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102b80:	8b 45 08             	mov    0x8(%ebp),%eax
80102b83:	83 c0 20             	add    $0x20,%eax
80102b86:	89 c2                	mov    %eax,%edx
80102b88:	8b 45 08             	mov    0x8(%ebp),%eax
80102b8b:	83 c0 08             	add    $0x8,%eax
80102b8e:	01 c0                	add    %eax,%eax
80102b90:	52                   	push   %edx
80102b91:	50                   	push   %eax
80102b92:	e8 0c ff ff ff       	call   80102aa3 <ioapicwrite>
80102b97:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102b9a:	8b 45 0c             	mov    0xc(%ebp),%eax
80102b9d:	c1 e0 18             	shl    $0x18,%eax
80102ba0:	89 c2                	mov    %eax,%edx
80102ba2:	8b 45 08             	mov    0x8(%ebp),%eax
80102ba5:	83 c0 08             	add    $0x8,%eax
80102ba8:	01 c0                	add    %eax,%eax
80102baa:	83 c0 01             	add    $0x1,%eax
80102bad:	52                   	push   %edx
80102bae:	50                   	push   %eax
80102baf:	e8 ef fe ff ff       	call   80102aa3 <ioapicwrite>
80102bb4:	83 c4 08             	add    $0x8,%esp
80102bb7:	eb 01                	jmp    80102bba <ioapicenable+0x46>

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
    return;
80102bb9:	90                   	nop
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102bba:	c9                   	leave  
80102bbb:	c3                   	ret    

80102bbc <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80102bbc:	55                   	push   %ebp
80102bbd:	89 e5                	mov    %esp,%ebp
80102bbf:	8b 45 08             	mov    0x8(%ebp),%eax
80102bc2:	05 00 00 00 80       	add    $0x80000000,%eax
80102bc7:	5d                   	pop    %ebp
80102bc8:	c3                   	ret    

80102bc9 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102bc9:	55                   	push   %ebp
80102bca:	89 e5                	mov    %esp,%ebp
80102bcc:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102bcf:	83 ec 08             	sub    $0x8,%esp
80102bd2:	68 ea b5 10 80       	push   $0x8010b5ea
80102bd7:	68 a0 28 11 80       	push   $0x801128a0
80102bdc:	e8 3a 22 00 00       	call   80104e1b <initlock>
80102be1:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102be4:	c7 05 d4 28 11 80 00 	movl   $0x0,0x801128d4
80102beb:	00 00 00 
  freerange(vstart, vend);
80102bee:	83 ec 08             	sub    $0x8,%esp
80102bf1:	ff 75 0c             	pushl  0xc(%ebp)
80102bf4:	ff 75 08             	pushl  0x8(%ebp)
80102bf7:	e8 2a 00 00 00       	call   80102c26 <freerange>
80102bfc:	83 c4 10             	add    $0x10,%esp
}
80102bff:	90                   	nop
80102c00:	c9                   	leave  
80102c01:	c3                   	ret    

80102c02 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102c02:	55                   	push   %ebp
80102c03:	89 e5                	mov    %esp,%ebp
80102c05:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
80102c08:	83 ec 08             	sub    $0x8,%esp
80102c0b:	ff 75 0c             	pushl  0xc(%ebp)
80102c0e:	ff 75 08             	pushl  0x8(%ebp)
80102c11:	e8 10 00 00 00       	call   80102c26 <freerange>
80102c16:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
80102c19:	c7 05 d4 28 11 80 01 	movl   $0x1,0x801128d4
80102c20:	00 00 00 
}
80102c23:	90                   	nop
80102c24:	c9                   	leave  
80102c25:	c3                   	ret    

80102c26 <freerange>:

void
freerange(void *vstart, void *vend)
{
80102c26:	55                   	push   %ebp
80102c27:	89 e5                	mov    %esp,%ebp
80102c29:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102c2c:	8b 45 08             	mov    0x8(%ebp),%eax
80102c2f:	05 ff 0f 00 00       	add    $0xfff,%eax
80102c34:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102c39:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102c3c:	eb 15                	jmp    80102c53 <freerange+0x2d>
    kfree(p);
80102c3e:	83 ec 0c             	sub    $0xc,%esp
80102c41:	ff 75 f4             	pushl  -0xc(%ebp)
80102c44:	e8 1a 00 00 00       	call   80102c63 <kfree>
80102c49:	83 c4 10             	add    $0x10,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102c4c:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102c53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c56:	05 00 10 00 00       	add    $0x1000,%eax
80102c5b:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102c5e:	76 de                	jbe    80102c3e <freerange+0x18>
    kfree(p);
}
80102c60:	90                   	nop
80102c61:	c9                   	leave  
80102c62:	c3                   	ret    

80102c63 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102c63:	55                   	push   %ebp
80102c64:	89 e5                	mov    %esp,%ebp
80102c66:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102c69:	8b 45 08             	mov    0x8(%ebp),%eax
80102c6c:	25 ff 0f 00 00       	and    $0xfff,%eax
80102c71:	85 c0                	test   %eax,%eax
80102c73:	75 1b                	jne    80102c90 <kfree+0x2d>
80102c75:	81 7d 08 84 b4 11 80 	cmpl   $0x8011b484,0x8(%ebp)
80102c7c:	72 12                	jb     80102c90 <kfree+0x2d>
80102c7e:	ff 75 08             	pushl  0x8(%ebp)
80102c81:	e8 36 ff ff ff       	call   80102bbc <v2p>
80102c86:	83 c4 04             	add    $0x4,%esp
80102c89:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102c8e:	76 0d                	jbe    80102c9d <kfree+0x3a>
    panic("kfree");
80102c90:	83 ec 0c             	sub    $0xc,%esp
80102c93:	68 ef b5 10 80       	push   $0x8010b5ef
80102c98:	e8 c9 d8 ff ff       	call   80100566 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102c9d:	83 ec 04             	sub    $0x4,%esp
80102ca0:	68 00 10 00 00       	push   $0x1000
80102ca5:	6a 01                	push   $0x1
80102ca7:	ff 75 08             	pushl  0x8(%ebp)
80102caa:	e8 f1 23 00 00       	call   801050a0 <memset>
80102caf:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102cb2:	a1 d4 28 11 80       	mov    0x801128d4,%eax
80102cb7:	85 c0                	test   %eax,%eax
80102cb9:	74 10                	je     80102ccb <kfree+0x68>
    acquire(&kmem.lock);
80102cbb:	83 ec 0c             	sub    $0xc,%esp
80102cbe:	68 a0 28 11 80       	push   $0x801128a0
80102cc3:	e8 75 21 00 00       	call   80104e3d <acquire>
80102cc8:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102ccb:	8b 45 08             	mov    0x8(%ebp),%eax
80102cce:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102cd1:	8b 15 d8 28 11 80    	mov    0x801128d8,%edx
80102cd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cda:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102cdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cdf:	a3 d8 28 11 80       	mov    %eax,0x801128d8
  if(kmem.use_lock)
80102ce4:	a1 d4 28 11 80       	mov    0x801128d4,%eax
80102ce9:	85 c0                	test   %eax,%eax
80102ceb:	74 10                	je     80102cfd <kfree+0x9a>
    release(&kmem.lock);
80102ced:	83 ec 0c             	sub    $0xc,%esp
80102cf0:	68 a0 28 11 80       	push   $0x801128a0
80102cf5:	e8 aa 21 00 00       	call   80104ea4 <release>
80102cfa:	83 c4 10             	add    $0x10,%esp
}
80102cfd:	90                   	nop
80102cfe:	c9                   	leave  
80102cff:	c3                   	ret    

80102d00 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102d00:	55                   	push   %ebp
80102d01:	89 e5                	mov    %esp,%ebp
80102d03:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102d06:	a1 d4 28 11 80       	mov    0x801128d4,%eax
80102d0b:	85 c0                	test   %eax,%eax
80102d0d:	74 10                	je     80102d1f <kalloc+0x1f>
    acquire(&kmem.lock);
80102d0f:	83 ec 0c             	sub    $0xc,%esp
80102d12:	68 a0 28 11 80       	push   $0x801128a0
80102d17:	e8 21 21 00 00       	call   80104e3d <acquire>
80102d1c:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102d1f:	a1 d8 28 11 80       	mov    0x801128d8,%eax
80102d24:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102d27:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102d2b:	74 0a                	je     80102d37 <kalloc+0x37>
    kmem.freelist = r->next;
80102d2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d30:	8b 00                	mov    (%eax),%eax
80102d32:	a3 d8 28 11 80       	mov    %eax,0x801128d8
  if(kmem.use_lock)
80102d37:	a1 d4 28 11 80       	mov    0x801128d4,%eax
80102d3c:	85 c0                	test   %eax,%eax
80102d3e:	74 10                	je     80102d50 <kalloc+0x50>
    release(&kmem.lock);
80102d40:	83 ec 0c             	sub    $0xc,%esp
80102d43:	68 a0 28 11 80       	push   $0x801128a0
80102d48:	e8 57 21 00 00       	call   80104ea4 <release>
80102d4d:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80102d50:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102d53:	c9                   	leave  
80102d54:	c3                   	ret    

80102d55 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102d55:	55                   	push   %ebp
80102d56:	89 e5                	mov    %esp,%ebp
80102d58:	83 ec 14             	sub    $0x14,%esp
80102d5b:	8b 45 08             	mov    0x8(%ebp),%eax
80102d5e:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d62:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102d66:	89 c2                	mov    %eax,%edx
80102d68:	ec                   	in     (%dx),%al
80102d69:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102d6c:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102d70:	c9                   	leave  
80102d71:	c3                   	ret    

80102d72 <kbdInterupt>:

extern void sendMessage(int wndId,AMessage *msg);
extern AWndList wndList;

void kbdInterupt()
{
80102d72:	55                   	push   %ebp
80102d73:	89 e5                	mov    %esp,%ebp
80102d75:	83 ec 28             	sub    $0x28,%esp
		normalMap, e0Map
	};

	uint st, data;

	st = inb(KBSTATP);
80102d78:	6a 64                	push   $0x64
80102d7a:	e8 d6 ff ff ff       	call   80102d55 <inb>
80102d7f:	83 c4 04             	add    $0x4,%esp
80102d82:	0f b6 c0             	movzbl %al,%eax
80102d85:	89 45 f4             	mov    %eax,-0xc(%ebp)
	data = inb(KBDATAP);
80102d88:	6a 60                	push   $0x60
80102d8a:	e8 c6 ff ff ff       	call   80102d55 <inb>
80102d8f:	83 c4 04             	add    $0x4,%esp
80102d92:	0f b6 c0             	movzbl %al,%eax
80102d95:	89 45 f0             	mov    %eax,-0x10(%ebp)

	//cprintf("state : %d\n", st);
	//cprintf("data  : %d\n", data);
	if ((st & KBS_DIB) == 0 || (st & 0x20) != 0)
80102d98:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d9b:	83 e0 01             	and    $0x1,%eax
80102d9e:	85 c0                	test   %eax,%eax
80102da0:	0f 84 cd 00 00 00    	je     80102e73 <kbdInterupt+0x101>
80102da6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102da9:	83 e0 20             	and    $0x20,%eax
80102dac:	85 c0                	test   %eax,%eax
80102dae:	0f 85 bf 00 00 00    	jne    80102e73 <kbdInterupt+0x101>
	{
		//cprintf("kbdInterupt return : %d\n", st);
		return;
	}

	if (data == 0xE0) {
80102db4:	81 7d f0 e0 00 00 00 	cmpl   $0xe0,-0x10(%ebp)
80102dbb:	75 0f                	jne    80102dcc <kbdInterupt+0x5a>
		//cprintf("kbd error data 0xE0\n");
		shift = 1;
80102dbd:	c7 05 7c e6 10 80 01 	movl   $0x1,0x8010e67c
80102dc4:	00 00 00 
		return;
80102dc7:	e9 a8 00 00 00       	jmp    80102e74 <kbdInterupt+0x102>
	}
	else if (data & 0x80) {
80102dcc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102dcf:	25 80 00 00 00       	and    $0x80,%eax
80102dd4:	85 c0                	test   %eax,%eax
80102dd6:	74 50                	je     80102e28 <kbdInterupt+0xb6>
		//cprintf("test2");
		// Key released
        //cprintf("key released!\n");
		data &= 0x7F;
80102dd8:	83 65 f0 7f          	andl   $0x7f,-0x10(%ebp)
		AMessage msg;
		msg.type = MSG_KEY_UP;
80102ddc:	c7 45 d8 05 00 00 00 	movl   $0x5,-0x28(%ebp)
		msg.param = charcode[shift][data];
80102de3:	a1 7c e6 10 80       	mov    0x8010e67c,%eax
80102de8:	8b 14 85 20 c7 10 80 	mov    -0x7fef38e0(,%eax,4),%edx
80102def:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102df2:	01 d0                	add    %edx,%eax
80102df4:	0f b6 00             	movzbl (%eax),%eax
80102df7:	0f b6 c0             	movzbl %al,%eax
80102dfa:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if (shift)
80102dfd:	a1 7c e6 10 80       	mov    0x8010e67c,%eax
80102e02:	85 c0                	test   %eax,%eax
80102e04:	74 0a                	je     80102e10 <kbdInterupt+0x9e>
			shift = 0;
80102e06:	c7 05 7c e6 10 80 00 	movl   $0x0,0x8010e67c
80102e0d:	00 00 00 

        //cprintf("sending message!\n");
		sendMessage(wndList.head, &msg);
80102e10:	a1 70 78 11 80       	mov    0x80117870,%eax
80102e15:	83 ec 08             	sub    $0x8,%esp
80102e18:	8d 55 d8             	lea    -0x28(%ebp),%edx
80102e1b:	52                   	push   %edx
80102e1c:	50                   	push   %eax
80102e1d:	e8 99 78 00 00       	call   8010a6bb <sendMessage>
80102e22:	83 c4 10             	add    $0x10,%esp
        //cprintf("kdb message sent!\n");
		return;
80102e25:	90                   	nop
80102e26:	eb 4c                	jmp    80102e74 <kbdInterupt+0x102>
	}
	AMessage msg;
	msg.type = MSG_KEY_DOWN;
80102e28:	c7 45 e4 06 00 00 00 	movl   $0x6,-0x1c(%ebp)
	msg.param = charcode[shift][data];
80102e2f:	a1 7c e6 10 80       	mov    0x8010e67c,%eax
80102e34:	8b 14 85 20 c7 10 80 	mov    -0x7fef38e0(,%eax,4),%edx
80102e3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102e3e:	01 d0                	add    %edx,%eax
80102e40:	0f b6 00             	movzbl (%eax),%eax
80102e43:	0f b6 c0             	movzbl %al,%eax
80102e46:	89 45 e8             	mov    %eax,-0x18(%ebp)
	//cprintf("msg.param send:%d\n",msg.param);
	if (shift)
80102e49:	a1 7c e6 10 80       	mov    0x8010e67c,%eax
80102e4e:	85 c0                	test   %eax,%eax
80102e50:	74 0a                	je     80102e5c <kbdInterupt+0xea>
		shift = 0;
80102e52:	c7 05 7c e6 10 80 00 	movl   $0x0,0x8010e67c
80102e59:	00 00 00 
    //cprintf("sending message!\n");
	sendMessage(wndList.head, &msg);
80102e5c:	a1 70 78 11 80       	mov    0x80117870,%eax
80102e61:	83 ec 08             	sub    $0x8,%esp
80102e64:	8d 55 e4             	lea    -0x1c(%ebp),%edx
80102e67:	52                   	push   %edx
80102e68:	50                   	push   %eax
80102e69:	e8 4d 78 00 00       	call   8010a6bb <sendMessage>
80102e6e:	83 c4 10             	add    $0x10,%esp
80102e71:	eb 01                	jmp    80102e74 <kbdInterupt+0x102>
	//cprintf("state : %d\n", st);
	//cprintf("data  : %d\n", data);
	if ((st & KBS_DIB) == 0 || (st & 0x20) != 0)
	{
		//cprintf("kbdInterupt return : %d\n", st);
		return;
80102e73:	90                   	nop
		shift = 0;
    //cprintf("sending message!\n");
	sendMessage(wndList.head, &msg);
    //cprintf("kdb message sent!\n");

}
80102e74:	c9                   	leave  
80102e75:	c3                   	ret    

80102e76 <kbdgetc>:

int
kbdgetc(void)
{
80102e76:	55                   	push   %ebp
80102e77:	89 e5                	mov    %esp,%ebp
80102e79:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102e7c:	6a 64                	push   $0x64
80102e7e:	e8 d2 fe ff ff       	call   80102d55 <inb>
80102e83:	83 c4 04             	add    $0x4,%esp
80102e86:	0f b6 c0             	movzbl %al,%eax
80102e89:	89 45 f4             	mov    %eax,-0xc(%ebp)
  data = inb(KBDATAP);
80102e8c:	6a 60                	push   $0x60
80102e8e:	e8 c2 fe ff ff       	call   80102d55 <inb>
80102e93:	83 c4 04             	add    $0x4,%esp
80102e96:	0f b6 c0             	movzbl %al,%eax
80102e99:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if((st & KBS_DIB) == 0 || (st & 0x20) != 0)
80102e9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e9f:	83 e0 01             	and    $0x1,%eax
80102ea2:	85 c0                	test   %eax,%eax
80102ea4:	74 0a                	je     80102eb0 <kbdgetc+0x3a>
80102ea6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ea9:	83 e0 20             	and    $0x20,%eax
80102eac:	85 c0                	test   %eax,%eax
80102eae:	74 0a                	je     80102eba <kbdgetc+0x44>
    return -1;
80102eb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102eb5:	e9 29 01 00 00       	jmp    80102fe3 <kbdgetc+0x16d>

  if (st & 0xc0)
80102eba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ebd:	25 c0 00 00 00       	and    $0xc0,%eax
80102ec2:	85 c0                	test   %eax,%eax
80102ec4:	74 0a                	je     80102ed0 <kbdgetc+0x5a>
  {
    return -1;
80102ec6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102ecb:	e9 13 01 00 00       	jmp    80102fe3 <kbdgetc+0x16d>
  }
    
  if(data == 0xE0){
80102ed0:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102ed7:	75 17                	jne    80102ef0 <kbdgetc+0x7a>
    shift |= E0ESC;
80102ed9:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102ede:	83 c8 40             	or     $0x40,%eax
80102ee1:	a3 80 e6 10 80       	mov    %eax,0x8010e680
    return 0;
80102ee6:	b8 00 00 00 00       	mov    $0x0,%eax
80102eeb:	e9 f3 00 00 00       	jmp    80102fe3 <kbdgetc+0x16d>
  } else if(data & 0x80){
80102ef0:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102ef3:	25 80 00 00 00       	and    $0x80,%eax
80102ef8:	85 c0                	test   %eax,%eax
80102efa:	74 45                	je     80102f41 <kbdgetc+0xcb>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102efc:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f01:	83 e0 40             	and    $0x40,%eax
80102f04:	85 c0                	test   %eax,%eax
80102f06:	75 08                	jne    80102f10 <kbdgetc+0x9a>
80102f08:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f0b:	83 e0 7f             	and    $0x7f,%eax
80102f0e:	eb 03                	jmp    80102f13 <kbdgetc+0x9d>
80102f10:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f13:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102f16:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f19:	05 20 c0 10 80       	add    $0x8010c020,%eax
80102f1e:	0f b6 00             	movzbl (%eax),%eax
80102f21:	83 c8 40             	or     $0x40,%eax
80102f24:	0f b6 c0             	movzbl %al,%eax
80102f27:	f7 d0                	not    %eax
80102f29:	89 c2                	mov    %eax,%edx
80102f2b:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f30:	21 d0                	and    %edx,%eax
80102f32:	a3 80 e6 10 80       	mov    %eax,0x8010e680
    return 0;
80102f37:	b8 00 00 00 00       	mov    $0x0,%eax
80102f3c:	e9 a2 00 00 00       	jmp    80102fe3 <kbdgetc+0x16d>
  } else if(shift & E0ESC){
80102f41:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f46:	83 e0 40             	and    $0x40,%eax
80102f49:	85 c0                	test   %eax,%eax
80102f4b:	74 14                	je     80102f61 <kbdgetc+0xeb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102f4d:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102f54:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f59:	83 e0 bf             	and    $0xffffffbf,%eax
80102f5c:	a3 80 e6 10 80       	mov    %eax,0x8010e680
  }

  shift |= shiftcode[data];
80102f61:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f64:	05 20 c0 10 80       	add    $0x8010c020,%eax
80102f69:	0f b6 00             	movzbl (%eax),%eax
80102f6c:	0f b6 d0             	movzbl %al,%edx
80102f6f:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f74:	09 d0                	or     %edx,%eax
80102f76:	a3 80 e6 10 80       	mov    %eax,0x8010e680
  shift ^= togglecode[data];
80102f7b:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f7e:	05 20 c1 10 80       	add    $0x8010c120,%eax
80102f83:	0f b6 00             	movzbl (%eax),%eax
80102f86:	0f b6 d0             	movzbl %al,%edx
80102f89:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f8e:	31 d0                	xor    %edx,%eax
80102f90:	a3 80 e6 10 80       	mov    %eax,0x8010e680
  c = charcode[shift & (CTL | SHIFT)][data];
80102f95:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f9a:	83 e0 03             	and    $0x3,%eax
80102f9d:	8b 14 85 28 c7 10 80 	mov    -0x7fef38d8(,%eax,4),%edx
80102fa4:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102fa7:	01 d0                	add    %edx,%eax
80102fa9:	0f b6 00             	movzbl (%eax),%eax
80102fac:	0f b6 c0             	movzbl %al,%eax
80102faf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102fb2:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102fb7:	83 e0 08             	and    $0x8,%eax
80102fba:	85 c0                	test   %eax,%eax
80102fbc:	74 22                	je     80102fe0 <kbdgetc+0x16a>
    if('a' <= c && c <= 'z')
80102fbe:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102fc2:	76 0c                	jbe    80102fd0 <kbdgetc+0x15a>
80102fc4:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102fc8:	77 06                	ja     80102fd0 <kbdgetc+0x15a>
      c += 'A' - 'a';
80102fca:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102fce:	eb 10                	jmp    80102fe0 <kbdgetc+0x16a>
    else if('A' <= c && c <= 'Z')
80102fd0:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102fd4:	76 0a                	jbe    80102fe0 <kbdgetc+0x16a>
80102fd6:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102fda:	77 04                	ja     80102fe0 <kbdgetc+0x16a>
      c += 'a' - 'A';
80102fdc:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  
  return c;
80102fe0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102fe3:	c9                   	leave  
80102fe4:	c3                   	ret    

80102fe5 <kbdintr>:

void
kbdintr(void)
{
80102fe5:	55                   	push   %ebp
80102fe6:	89 e5                	mov    %esp,%ebp
80102fe8:	83 ec 08             	sub    $0x8,%esp
  //consoleintr(kbdgetc);
	kbdInterupt();
80102feb:	e8 82 fd ff ff       	call   80102d72 <kbdInterupt>
}
80102ff0:	90                   	nop
80102ff1:	c9                   	leave  
80102ff2:	c3                   	ret    

80102ff3 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80102ff3:	55                   	push   %ebp
80102ff4:	89 e5                	mov    %esp,%ebp
80102ff6:	83 ec 08             	sub    $0x8,%esp
80102ff9:	8b 55 08             	mov    0x8(%ebp),%edx
80102ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
80102fff:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103003:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103006:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010300a:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010300e:	ee                   	out    %al,(%dx)
}
8010300f:	90                   	nop
80103010:	c9                   	leave  
80103011:	c3                   	ret    

80103012 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80103012:	55                   	push   %ebp
80103013:	89 e5                	mov    %esp,%ebp
80103015:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103018:	9c                   	pushf  
80103019:	58                   	pop    %eax
8010301a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
8010301d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103020:	c9                   	leave  
80103021:	c3                   	ret    

80103022 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80103022:	55                   	push   %ebp
80103023:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80103025:	a1 dc 28 11 80       	mov    0x801128dc,%eax
8010302a:	8b 55 08             	mov    0x8(%ebp),%edx
8010302d:	c1 e2 02             	shl    $0x2,%edx
80103030:	01 c2                	add    %eax,%edx
80103032:	8b 45 0c             	mov    0xc(%ebp),%eax
80103035:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80103037:	a1 dc 28 11 80       	mov    0x801128dc,%eax
8010303c:	83 c0 20             	add    $0x20,%eax
8010303f:	8b 00                	mov    (%eax),%eax
}
80103041:	90                   	nop
80103042:	5d                   	pop    %ebp
80103043:	c3                   	ret    

80103044 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80103044:	55                   	push   %ebp
80103045:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
80103047:	a1 dc 28 11 80       	mov    0x801128dc,%eax
8010304c:	85 c0                	test   %eax,%eax
8010304e:	0f 84 0b 01 00 00    	je     8010315f <lapicinit+0x11b>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80103054:	68 3f 01 00 00       	push   $0x13f
80103059:	6a 3c                	push   $0x3c
8010305b:	e8 c2 ff ff ff       	call   80103022 <lapicw>
80103060:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80103063:	6a 0b                	push   $0xb
80103065:	68 f8 00 00 00       	push   $0xf8
8010306a:	e8 b3 ff ff ff       	call   80103022 <lapicw>
8010306f:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80103072:	68 20 00 02 00       	push   $0x20020
80103077:	68 c8 00 00 00       	push   $0xc8
8010307c:	e8 a1 ff ff ff       	call   80103022 <lapicw>
80103081:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000); 
80103084:	68 80 96 98 00       	push   $0x989680
80103089:	68 e0 00 00 00       	push   $0xe0
8010308e:	e8 8f ff ff ff       	call   80103022 <lapicw>
80103093:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80103096:	68 00 00 01 00       	push   $0x10000
8010309b:	68 d4 00 00 00       	push   $0xd4
801030a0:	e8 7d ff ff ff       	call   80103022 <lapicw>
801030a5:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
801030a8:	68 00 00 01 00       	push   $0x10000
801030ad:	68 d8 00 00 00       	push   $0xd8
801030b2:	e8 6b ff ff ff       	call   80103022 <lapicw>
801030b7:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801030ba:	a1 dc 28 11 80       	mov    0x801128dc,%eax
801030bf:	83 c0 30             	add    $0x30,%eax
801030c2:	8b 00                	mov    (%eax),%eax
801030c4:	c1 e8 10             	shr    $0x10,%eax
801030c7:	0f b6 c0             	movzbl %al,%eax
801030ca:	83 f8 03             	cmp    $0x3,%eax
801030cd:	76 12                	jbe    801030e1 <lapicinit+0x9d>
    lapicw(PCINT, MASKED);
801030cf:	68 00 00 01 00       	push   $0x10000
801030d4:	68 d0 00 00 00       	push   $0xd0
801030d9:	e8 44 ff ff ff       	call   80103022 <lapicw>
801030de:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
801030e1:	6a 33                	push   $0x33
801030e3:	68 dc 00 00 00       	push   $0xdc
801030e8:	e8 35 ff ff ff       	call   80103022 <lapicw>
801030ed:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
801030f0:	6a 00                	push   $0x0
801030f2:	68 a0 00 00 00       	push   $0xa0
801030f7:	e8 26 ff ff ff       	call   80103022 <lapicw>
801030fc:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
801030ff:	6a 00                	push   $0x0
80103101:	68 a0 00 00 00       	push   $0xa0
80103106:	e8 17 ff ff ff       	call   80103022 <lapicw>
8010310b:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
8010310e:	6a 00                	push   $0x0
80103110:	6a 2c                	push   $0x2c
80103112:	e8 0b ff ff ff       	call   80103022 <lapicw>
80103117:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
8010311a:	6a 00                	push   $0x0
8010311c:	68 c4 00 00 00       	push   $0xc4
80103121:	e8 fc fe ff ff       	call   80103022 <lapicw>
80103126:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80103129:	68 00 85 08 00       	push   $0x88500
8010312e:	68 c0 00 00 00       	push   $0xc0
80103133:	e8 ea fe ff ff       	call   80103022 <lapicw>
80103138:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
8010313b:	90                   	nop
8010313c:	a1 dc 28 11 80       	mov    0x801128dc,%eax
80103141:	05 00 03 00 00       	add    $0x300,%eax
80103146:	8b 00                	mov    (%eax),%eax
80103148:	25 00 10 00 00       	and    $0x1000,%eax
8010314d:	85 c0                	test   %eax,%eax
8010314f:	75 eb                	jne    8010313c <lapicinit+0xf8>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80103151:	6a 00                	push   $0x0
80103153:	6a 20                	push   $0x20
80103155:	e8 c8 fe ff ff       	call   80103022 <lapicw>
8010315a:	83 c4 08             	add    $0x8,%esp
8010315d:	eb 01                	jmp    80103160 <lapicinit+0x11c>

void
lapicinit(void)
{
  if(!lapic) 
    return;
8010315f:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80103160:	c9                   	leave  
80103161:	c3                   	ret    

80103162 <cpunum>:

int
cpunum(void)
{
80103162:	55                   	push   %ebp
80103163:	89 e5                	mov    %esp,%ebp
80103165:	83 ec 08             	sub    $0x8,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80103168:	e8 a5 fe ff ff       	call   80103012 <readeflags>
8010316d:	25 00 02 00 00       	and    $0x200,%eax
80103172:	85 c0                	test   %eax,%eax
80103174:	74 26                	je     8010319c <cpunum+0x3a>
    static int n;
    if(n++ == 0)
80103176:	a1 84 e6 10 80       	mov    0x8010e684,%eax
8010317b:	8d 50 01             	lea    0x1(%eax),%edx
8010317e:	89 15 84 e6 10 80    	mov    %edx,0x8010e684
80103184:	85 c0                	test   %eax,%eax
80103186:	75 14                	jne    8010319c <cpunum+0x3a>
      cprintf("cpu called from %x with interrupts enabled\n",
80103188:	8b 45 04             	mov    0x4(%ebp),%eax
8010318b:	83 ec 08             	sub    $0x8,%esp
8010318e:	50                   	push   %eax
8010318f:	68 f8 b5 10 80       	push   $0x8010b5f8
80103194:	e8 2d d2 ff ff       	call   801003c6 <cprintf>
80103199:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
8010319c:	a1 dc 28 11 80       	mov    0x801128dc,%eax
801031a1:	85 c0                	test   %eax,%eax
801031a3:	74 0f                	je     801031b4 <cpunum+0x52>
    return lapic[ID]>>24;
801031a5:	a1 dc 28 11 80       	mov    0x801128dc,%eax
801031aa:	83 c0 20             	add    $0x20,%eax
801031ad:	8b 00                	mov    (%eax),%eax
801031af:	c1 e8 18             	shr    $0x18,%eax
801031b2:	eb 05                	jmp    801031b9 <cpunum+0x57>
  return 0;
801031b4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801031b9:	c9                   	leave  
801031ba:	c3                   	ret    

801031bb <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
801031bb:	55                   	push   %ebp
801031bc:	89 e5                	mov    %esp,%ebp
  if(lapic)
801031be:	a1 dc 28 11 80       	mov    0x801128dc,%eax
801031c3:	85 c0                	test   %eax,%eax
801031c5:	74 0c                	je     801031d3 <lapiceoi+0x18>
    lapicw(EOI, 0);
801031c7:	6a 00                	push   $0x0
801031c9:	6a 2c                	push   $0x2c
801031cb:	e8 52 fe ff ff       	call   80103022 <lapicw>
801031d0:	83 c4 08             	add    $0x8,%esp
}
801031d3:	90                   	nop
801031d4:	c9                   	leave  
801031d5:	c3                   	ret    

801031d6 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801031d6:	55                   	push   %ebp
801031d7:	89 e5                	mov    %esp,%ebp
}
801031d9:	90                   	nop
801031da:	5d                   	pop    %ebp
801031db:	c3                   	ret    

801031dc <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801031dc:	55                   	push   %ebp
801031dd:	89 e5                	mov    %esp,%ebp
801031df:	83 ec 14             	sub    $0x14,%esp
801031e2:	8b 45 08             	mov    0x8(%ebp),%eax
801031e5:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
801031e8:	6a 0f                	push   $0xf
801031ea:	6a 70                	push   $0x70
801031ec:	e8 02 fe ff ff       	call   80102ff3 <outb>
801031f1:	83 c4 08             	add    $0x8,%esp
  outb(IO_RTC+1, 0x0A);
801031f4:	6a 0a                	push   $0xa
801031f6:	6a 71                	push   $0x71
801031f8:	e8 f6 fd ff ff       	call   80102ff3 <outb>
801031fd:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80103200:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80103207:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010320a:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
8010320f:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103212:	83 c0 02             	add    $0x2,%eax
80103215:	8b 55 0c             	mov    0xc(%ebp),%edx
80103218:	c1 ea 04             	shr    $0x4,%edx
8010321b:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
8010321e:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103222:	c1 e0 18             	shl    $0x18,%eax
80103225:	50                   	push   %eax
80103226:	68 c4 00 00 00       	push   $0xc4
8010322b:	e8 f2 fd ff ff       	call   80103022 <lapicw>
80103230:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80103233:	68 00 c5 00 00       	push   $0xc500
80103238:	68 c0 00 00 00       	push   $0xc0
8010323d:	e8 e0 fd ff ff       	call   80103022 <lapicw>
80103242:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80103245:	68 c8 00 00 00       	push   $0xc8
8010324a:	e8 87 ff ff ff       	call   801031d6 <microdelay>
8010324f:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
80103252:	68 00 85 00 00       	push   $0x8500
80103257:	68 c0 00 00 00       	push   $0xc0
8010325c:	e8 c1 fd ff ff       	call   80103022 <lapicw>
80103261:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80103264:	6a 64                	push   $0x64
80103266:	e8 6b ff ff ff       	call   801031d6 <microdelay>
8010326b:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
8010326e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103275:	eb 3d                	jmp    801032b4 <lapicstartap+0xd8>
    lapicw(ICRHI, apicid<<24);
80103277:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
8010327b:	c1 e0 18             	shl    $0x18,%eax
8010327e:	50                   	push   %eax
8010327f:	68 c4 00 00 00       	push   $0xc4
80103284:	e8 99 fd ff ff       	call   80103022 <lapicw>
80103289:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
8010328c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010328f:	c1 e8 0c             	shr    $0xc,%eax
80103292:	80 cc 06             	or     $0x6,%ah
80103295:	50                   	push   %eax
80103296:	68 c0 00 00 00       	push   $0xc0
8010329b:	e8 82 fd ff ff       	call   80103022 <lapicw>
801032a0:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
801032a3:	68 c8 00 00 00       	push   $0xc8
801032a8:	e8 29 ff ff ff       	call   801031d6 <microdelay>
801032ad:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801032b0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801032b4:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
801032b8:	7e bd                	jle    80103277 <lapicstartap+0x9b>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801032ba:	90                   	nop
801032bb:	c9                   	leave  
801032bc:	c3                   	ret    

801032bd <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
801032bd:	55                   	push   %ebp
801032be:	89 e5                	mov    %esp,%ebp
801032c0:	83 ec 18             	sub    $0x18,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
801032c3:	83 ec 08             	sub    $0x8,%esp
801032c6:	68 24 b6 10 80       	push   $0x8010b624
801032cb:	68 e0 28 11 80       	push   $0x801128e0
801032d0:	e8 46 1b 00 00       	call   80104e1b <initlock>
801032d5:	83 c4 10             	add    $0x10,%esp
  readsb(ROOTDEV, &sb);
801032d8:	83 ec 08             	sub    $0x8,%esp
801032db:	8d 45 e8             	lea    -0x18(%ebp),%eax
801032de:	50                   	push   %eax
801032df:	6a 01                	push   $0x1
801032e1:	e8 6f e0 ff ff       	call   80101355 <readsb>
801032e6:	83 c4 10             	add    $0x10,%esp
  log.start = sb.size - sb.nlog;
801032e9:	8b 55 e8             	mov    -0x18(%ebp),%edx
801032ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801032ef:	29 c2                	sub    %eax,%edx
801032f1:	89 d0                	mov    %edx,%eax
801032f3:	a3 14 29 11 80       	mov    %eax,0x80112914
  log.size = sb.nlog;
801032f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801032fb:	a3 18 29 11 80       	mov    %eax,0x80112918
  log.dev = ROOTDEV;
80103300:	c7 05 20 29 11 80 01 	movl   $0x1,0x80112920
80103307:	00 00 00 
  recover_from_log();
8010330a:	e8 b2 01 00 00       	call   801034c1 <recover_from_log>
}
8010330f:	90                   	nop
80103310:	c9                   	leave  
80103311:	c3                   	ret    

80103312 <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
80103312:	55                   	push   %ebp
80103313:	89 e5                	mov    %esp,%ebp
80103315:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103318:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010331f:	e9 95 00 00 00       	jmp    801033b9 <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103324:	8b 15 14 29 11 80    	mov    0x80112914,%edx
8010332a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010332d:	01 d0                	add    %edx,%eax
8010332f:	83 c0 01             	add    $0x1,%eax
80103332:	89 c2                	mov    %eax,%edx
80103334:	a1 20 29 11 80       	mov    0x80112920,%eax
80103339:	83 ec 08             	sub    $0x8,%esp
8010333c:	52                   	push   %edx
8010333d:	50                   	push   %eax
8010333e:	e8 73 ce ff ff       	call   801001b6 <bread>
80103343:	83 c4 10             	add    $0x10,%esp
80103346:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
80103349:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010334c:	83 c0 10             	add    $0x10,%eax
8010334f:	8b 04 85 e8 28 11 80 	mov    -0x7feed718(,%eax,4),%eax
80103356:	89 c2                	mov    %eax,%edx
80103358:	a1 20 29 11 80       	mov    0x80112920,%eax
8010335d:	83 ec 08             	sub    $0x8,%esp
80103360:	52                   	push   %edx
80103361:	50                   	push   %eax
80103362:	e8 4f ce ff ff       	call   801001b6 <bread>
80103367:	83 c4 10             	add    $0x10,%esp
8010336a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
8010336d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103370:	8d 50 18             	lea    0x18(%eax),%edx
80103373:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103376:	83 c0 18             	add    $0x18,%eax
80103379:	83 ec 04             	sub    $0x4,%esp
8010337c:	68 00 02 00 00       	push   $0x200
80103381:	52                   	push   %edx
80103382:	50                   	push   %eax
80103383:	e8 d7 1d 00 00       	call   8010515f <memmove>
80103388:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
8010338b:	83 ec 0c             	sub    $0xc,%esp
8010338e:	ff 75 ec             	pushl  -0x14(%ebp)
80103391:	e8 59 ce ff ff       	call   801001ef <bwrite>
80103396:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf); 
80103399:	83 ec 0c             	sub    $0xc,%esp
8010339c:	ff 75 f0             	pushl  -0x10(%ebp)
8010339f:	e8 8a ce ff ff       	call   8010022e <brelse>
801033a4:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
801033a7:	83 ec 0c             	sub    $0xc,%esp
801033aa:	ff 75 ec             	pushl  -0x14(%ebp)
801033ad:	e8 7c ce ff ff       	call   8010022e <brelse>
801033b2:	83 c4 10             	add    $0x10,%esp
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801033b5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801033b9:	a1 24 29 11 80       	mov    0x80112924,%eax
801033be:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801033c1:	0f 8f 5d ff ff ff    	jg     80103324 <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
801033c7:	90                   	nop
801033c8:	c9                   	leave  
801033c9:	c3                   	ret    

801033ca <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
801033ca:	55                   	push   %ebp
801033cb:	89 e5                	mov    %esp,%ebp
801033cd:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
801033d0:	a1 14 29 11 80       	mov    0x80112914,%eax
801033d5:	89 c2                	mov    %eax,%edx
801033d7:	a1 20 29 11 80       	mov    0x80112920,%eax
801033dc:	83 ec 08             	sub    $0x8,%esp
801033df:	52                   	push   %edx
801033e0:	50                   	push   %eax
801033e1:	e8 d0 cd ff ff       	call   801001b6 <bread>
801033e6:	83 c4 10             	add    $0x10,%esp
801033e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
801033ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033ef:	83 c0 18             	add    $0x18,%eax
801033f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
801033f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033f8:	8b 00                	mov    (%eax),%eax
801033fa:	a3 24 29 11 80       	mov    %eax,0x80112924
  for (i = 0; i < log.lh.n; i++) {
801033ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103406:	eb 1b                	jmp    80103423 <read_head+0x59>
    log.lh.sector[i] = lh->sector[i];
80103408:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010340b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010340e:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103412:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103415:	83 c2 10             	add    $0x10,%edx
80103418:	89 04 95 e8 28 11 80 	mov    %eax,-0x7feed718(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
8010341f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103423:	a1 24 29 11 80       	mov    0x80112924,%eax
80103428:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010342b:	7f db                	jg     80103408 <read_head+0x3e>
    log.lh.sector[i] = lh->sector[i];
  }
  brelse(buf);
8010342d:	83 ec 0c             	sub    $0xc,%esp
80103430:	ff 75 f0             	pushl  -0x10(%ebp)
80103433:	e8 f6 cd ff ff       	call   8010022e <brelse>
80103438:	83 c4 10             	add    $0x10,%esp
}
8010343b:	90                   	nop
8010343c:	c9                   	leave  
8010343d:	c3                   	ret    

8010343e <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
8010343e:	55                   	push   %ebp
8010343f:	89 e5                	mov    %esp,%ebp
80103441:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103444:	a1 14 29 11 80       	mov    0x80112914,%eax
80103449:	89 c2                	mov    %eax,%edx
8010344b:	a1 20 29 11 80       	mov    0x80112920,%eax
80103450:	83 ec 08             	sub    $0x8,%esp
80103453:	52                   	push   %edx
80103454:	50                   	push   %eax
80103455:	e8 5c cd ff ff       	call   801001b6 <bread>
8010345a:	83 c4 10             	add    $0x10,%esp
8010345d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
80103460:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103463:	83 c0 18             	add    $0x18,%eax
80103466:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
80103469:	8b 15 24 29 11 80    	mov    0x80112924,%edx
8010346f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103472:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103474:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010347b:	eb 1b                	jmp    80103498 <write_head+0x5a>
    hb->sector[i] = log.lh.sector[i];
8010347d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103480:	83 c0 10             	add    $0x10,%eax
80103483:	8b 0c 85 e8 28 11 80 	mov    -0x7feed718(,%eax,4),%ecx
8010348a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010348d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103490:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103494:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103498:	a1 24 29 11 80       	mov    0x80112924,%eax
8010349d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801034a0:	7f db                	jg     8010347d <write_head+0x3f>
    hb->sector[i] = log.lh.sector[i];
  }
  bwrite(buf);
801034a2:	83 ec 0c             	sub    $0xc,%esp
801034a5:	ff 75 f0             	pushl  -0x10(%ebp)
801034a8:	e8 42 cd ff ff       	call   801001ef <bwrite>
801034ad:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
801034b0:	83 ec 0c             	sub    $0xc,%esp
801034b3:	ff 75 f0             	pushl  -0x10(%ebp)
801034b6:	e8 73 cd ff ff       	call   8010022e <brelse>
801034bb:	83 c4 10             	add    $0x10,%esp
}
801034be:	90                   	nop
801034bf:	c9                   	leave  
801034c0:	c3                   	ret    

801034c1 <recover_from_log>:

static void
recover_from_log(void)
{
801034c1:	55                   	push   %ebp
801034c2:	89 e5                	mov    %esp,%ebp
801034c4:	83 ec 08             	sub    $0x8,%esp
  read_head();      
801034c7:	e8 fe fe ff ff       	call   801033ca <read_head>
  install_trans(); // if committed, copy from log to disk
801034cc:	e8 41 fe ff ff       	call   80103312 <install_trans>
  log.lh.n = 0;
801034d1:	c7 05 24 29 11 80 00 	movl   $0x0,0x80112924
801034d8:	00 00 00 
  write_head(); // clear the log
801034db:	e8 5e ff ff ff       	call   8010343e <write_head>
}
801034e0:	90                   	nop
801034e1:	c9                   	leave  
801034e2:	c3                   	ret    

801034e3 <begin_trans>:

void
begin_trans(void)
{
801034e3:	55                   	push   %ebp
801034e4:	89 e5                	mov    %esp,%ebp
801034e6:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
801034e9:	83 ec 0c             	sub    $0xc,%esp
801034ec:	68 e0 28 11 80       	push   $0x801128e0
801034f1:	e8 47 19 00 00       	call   80104e3d <acquire>
801034f6:	83 c4 10             	add    $0x10,%esp
  while (log.busy) {
801034f9:	eb 15                	jmp    80103510 <begin_trans+0x2d>
    sleep(&log, &log.lock);
801034fb:	83 ec 08             	sub    $0x8,%esp
801034fe:	68 e0 28 11 80       	push   $0x801128e0
80103503:	68 e0 28 11 80       	push   $0x801128e0
80103508:	e8 37 16 00 00       	call   80104b44 <sleep>
8010350d:	83 c4 10             	add    $0x10,%esp

void
begin_trans(void)
{
  acquire(&log.lock);
  while (log.busy) {
80103510:	a1 1c 29 11 80       	mov    0x8011291c,%eax
80103515:	85 c0                	test   %eax,%eax
80103517:	75 e2                	jne    801034fb <begin_trans+0x18>
    sleep(&log, &log.lock);
  }
  log.busy = 1;
80103519:	c7 05 1c 29 11 80 01 	movl   $0x1,0x8011291c
80103520:	00 00 00 
  release(&log.lock);
80103523:	83 ec 0c             	sub    $0xc,%esp
80103526:	68 e0 28 11 80       	push   $0x801128e0
8010352b:	e8 74 19 00 00       	call   80104ea4 <release>
80103530:	83 c4 10             	add    $0x10,%esp
}
80103533:	90                   	nop
80103534:	c9                   	leave  
80103535:	c3                   	ret    

80103536 <commit_trans>:

void
commit_trans(void)
{
80103536:	55                   	push   %ebp
80103537:	89 e5                	mov    %esp,%ebp
80103539:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
8010353c:	a1 24 29 11 80       	mov    0x80112924,%eax
80103541:	85 c0                	test   %eax,%eax
80103543:	7e 19                	jle    8010355e <commit_trans+0x28>
    write_head();    // Write header to disk -- the real commit
80103545:	e8 f4 fe ff ff       	call   8010343e <write_head>
    install_trans(); // Now install writes to home locations
8010354a:	e8 c3 fd ff ff       	call   80103312 <install_trans>
    log.lh.n = 0; 
8010354f:	c7 05 24 29 11 80 00 	movl   $0x0,0x80112924
80103556:	00 00 00 
    write_head();    // Erase the transaction from the log
80103559:	e8 e0 fe ff ff       	call   8010343e <write_head>
  }
  
  acquire(&log.lock);
8010355e:	83 ec 0c             	sub    $0xc,%esp
80103561:	68 e0 28 11 80       	push   $0x801128e0
80103566:	e8 d2 18 00 00       	call   80104e3d <acquire>
8010356b:	83 c4 10             	add    $0x10,%esp
  log.busy = 0;
8010356e:	c7 05 1c 29 11 80 00 	movl   $0x0,0x8011291c
80103575:	00 00 00 
  wakeup(&log);
80103578:	83 ec 0c             	sub    $0xc,%esp
8010357b:	68 e0 28 11 80       	push   $0x801128e0
80103580:	e8 aa 16 00 00       	call   80104c2f <wakeup>
80103585:	83 c4 10             	add    $0x10,%esp
  release(&log.lock);
80103588:	83 ec 0c             	sub    $0xc,%esp
8010358b:	68 e0 28 11 80       	push   $0x801128e0
80103590:	e8 0f 19 00 00       	call   80104ea4 <release>
80103595:	83 c4 10             	add    $0x10,%esp
}
80103598:	90                   	nop
80103599:	c9                   	leave  
8010359a:	c3                   	ret    

8010359b <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
8010359b:	55                   	push   %ebp
8010359c:	89 e5                	mov    %esp,%ebp
8010359e:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801035a1:	a1 24 29 11 80       	mov    0x80112924,%eax
801035a6:	83 f8 09             	cmp    $0x9,%eax
801035a9:	7f 12                	jg     801035bd <log_write+0x22>
801035ab:	a1 24 29 11 80       	mov    0x80112924,%eax
801035b0:	8b 15 18 29 11 80    	mov    0x80112918,%edx
801035b6:	83 ea 01             	sub    $0x1,%edx
801035b9:	39 d0                	cmp    %edx,%eax
801035bb:	7c 2a                	jl     801035e7 <log_write+0x4c>
  {
      cprintf("%d %d\n", log.lh.n, log.size);
801035bd:	8b 15 18 29 11 80    	mov    0x80112918,%edx
801035c3:	a1 24 29 11 80       	mov    0x80112924,%eax
801035c8:	83 ec 04             	sub    $0x4,%esp
801035cb:	52                   	push   %edx
801035cc:	50                   	push   %eax
801035cd:	68 28 b6 10 80       	push   $0x8010b628
801035d2:	e8 ef cd ff ff       	call   801003c6 <cprintf>
801035d7:	83 c4 10             	add    $0x10,%esp
      panic("too big a transaction");
801035da:	83 ec 0c             	sub    $0xc,%esp
801035dd:	68 2f b6 10 80       	push   $0x8010b62f
801035e2:	e8 7f cf ff ff       	call   80100566 <panic>
  }
  if (!log.busy)
801035e7:	a1 1c 29 11 80       	mov    0x8011291c,%eax
801035ec:	85 c0                	test   %eax,%eax
801035ee:	75 0d                	jne    801035fd <log_write+0x62>
    panic("write outside of trans");
801035f0:	83 ec 0c             	sub    $0xc,%esp
801035f3:	68 45 b6 10 80       	push   $0x8010b645
801035f8:	e8 69 cf ff ff       	call   80100566 <panic>

  for (i = 0; i < log.lh.n; i++) {
801035fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103604:	eb 1d                	jmp    80103623 <log_write+0x88>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
80103606:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103609:	83 c0 10             	add    $0x10,%eax
8010360c:	8b 04 85 e8 28 11 80 	mov    -0x7feed718(,%eax,4),%eax
80103613:	89 c2                	mov    %eax,%edx
80103615:	8b 45 08             	mov    0x8(%ebp),%eax
80103618:	8b 40 08             	mov    0x8(%eax),%eax
8010361b:	39 c2                	cmp    %eax,%edx
8010361d:	74 10                	je     8010362f <log_write+0x94>
      panic("too big a transaction");
  }
  if (!log.busy)
    panic("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
8010361f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103623:	a1 24 29 11 80       	mov    0x80112924,%eax
80103628:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010362b:	7f d9                	jg     80103606 <log_write+0x6b>
8010362d:	eb 01                	jmp    80103630 <log_write+0x95>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
      break;
8010362f:	90                   	nop
  }
  log.lh.sector[i] = b->sector;
80103630:	8b 45 08             	mov    0x8(%ebp),%eax
80103633:	8b 40 08             	mov    0x8(%eax),%eax
80103636:	89 c2                	mov    %eax,%edx
80103638:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010363b:	83 c0 10             	add    $0x10,%eax
8010363e:	89 14 85 e8 28 11 80 	mov    %edx,-0x7feed718(,%eax,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
80103645:	8b 15 14 29 11 80    	mov    0x80112914,%edx
8010364b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010364e:	01 d0                	add    %edx,%eax
80103650:	83 c0 01             	add    $0x1,%eax
80103653:	89 c2                	mov    %eax,%edx
80103655:	8b 45 08             	mov    0x8(%ebp),%eax
80103658:	8b 40 04             	mov    0x4(%eax),%eax
8010365b:	83 ec 08             	sub    $0x8,%esp
8010365e:	52                   	push   %edx
8010365f:	50                   	push   %eax
80103660:	e8 51 cb ff ff       	call   801001b6 <bread>
80103665:	83 c4 10             	add    $0x10,%esp
80103668:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(lbuf->data, b->data, BSIZE);
8010366b:	8b 45 08             	mov    0x8(%ebp),%eax
8010366e:	8d 50 18             	lea    0x18(%eax),%edx
80103671:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103674:	83 c0 18             	add    $0x18,%eax
80103677:	83 ec 04             	sub    $0x4,%esp
8010367a:	68 00 02 00 00       	push   $0x200
8010367f:	52                   	push   %edx
80103680:	50                   	push   %eax
80103681:	e8 d9 1a 00 00       	call   8010515f <memmove>
80103686:	83 c4 10             	add    $0x10,%esp
  bwrite(lbuf);
80103689:	83 ec 0c             	sub    $0xc,%esp
8010368c:	ff 75 f0             	pushl  -0x10(%ebp)
8010368f:	e8 5b cb ff ff       	call   801001ef <bwrite>
80103694:	83 c4 10             	add    $0x10,%esp
  brelse(lbuf);
80103697:	83 ec 0c             	sub    $0xc,%esp
8010369a:	ff 75 f0             	pushl  -0x10(%ebp)
8010369d:	e8 8c cb ff ff       	call   8010022e <brelse>
801036a2:	83 c4 10             	add    $0x10,%esp
  if (i == log.lh.n)
801036a5:	a1 24 29 11 80       	mov    0x80112924,%eax
801036aa:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801036ad:	75 0d                	jne    801036bc <log_write+0x121>
    log.lh.n++;
801036af:	a1 24 29 11 80       	mov    0x80112924,%eax
801036b4:	83 c0 01             	add    $0x1,%eax
801036b7:	a3 24 29 11 80       	mov    %eax,0x80112924
  b->flags |= B_DIRTY; // XXX prevent eviction
801036bc:	8b 45 08             	mov    0x8(%ebp),%eax
801036bf:	8b 00                	mov    (%eax),%eax
801036c1:	83 c8 04             	or     $0x4,%eax
801036c4:	89 c2                	mov    %eax,%edx
801036c6:	8b 45 08             	mov    0x8(%ebp),%eax
801036c9:	89 10                	mov    %edx,(%eax)
}
801036cb:	90                   	nop
801036cc:	c9                   	leave  
801036cd:	c3                   	ret    

801036ce <v2p>:
801036ce:	55                   	push   %ebp
801036cf:	89 e5                	mov    %esp,%ebp
801036d1:	8b 45 08             	mov    0x8(%ebp),%eax
801036d4:	05 00 00 00 80       	add    $0x80000000,%eax
801036d9:	5d                   	pop    %ebp
801036da:	c3                   	ret    

801036db <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801036db:	55                   	push   %ebp
801036dc:	89 e5                	mov    %esp,%ebp
801036de:	8b 45 08             	mov    0x8(%ebp),%eax
801036e1:	05 00 00 00 80       	add    $0x80000000,%eax
801036e6:	5d                   	pop    %ebp
801036e7:	c3                   	ret    

801036e8 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
801036e8:	55                   	push   %ebp
801036e9:	89 e5                	mov    %esp,%ebp
801036eb:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801036ee:	8b 55 08             	mov    0x8(%ebp),%edx
801036f1:	8b 45 0c             	mov    0xc(%ebp),%eax
801036f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
801036f7:	f0 87 02             	lock xchg %eax,(%edx)
801036fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
801036fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103700:	c9                   	leave  
80103701:	c3                   	ret    

80103702 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103702:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103706:	83 e4 f0             	and    $0xfffffff0,%esp
80103709:	ff 71 fc             	pushl  -0x4(%ecx)
8010370c:	55                   	push   %ebp
8010370d:	89 e5                	mov    %esp,%ebp
8010370f:	51                   	push   %ecx
80103710:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103713:	83 ec 08             	sub    $0x8,%esp
80103716:	68 00 00 40 80       	push   $0x80400000
8010371b:	68 84 b4 11 80       	push   $0x8011b484
80103720:	e8 a4 f4 ff ff       	call   80102bc9 <kinit1>
80103725:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
80103728:	e8 ac 44 00 00       	call   80107bd9 <kvmalloc>
  mpinit();        // collect info about this machine
8010372d:	e8 4d 04 00 00       	call   80103b7f <mpinit>
  lapicinit();
80103732:	e8 0d f9 ff ff       	call   80103044 <lapicinit>
  seginit();       // set up segments
80103737:	e8 46 3e 00 00       	call   80107582 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
8010373c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103742:	0f b6 00             	movzbl (%eax),%eax
80103745:	0f b6 c0             	movzbl %al,%eax
80103748:	83 ec 08             	sub    $0x8,%esp
8010374b:	50                   	push   %eax
8010374c:	68 5c b6 10 80       	push   $0x8010b65c
80103751:	e8 70 cc ff ff       	call   801003c6 <cprintf>
80103756:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
80103759:	e8 77 06 00 00       	call   80103dd5 <picinit>
  ioapicinit();    // another interrupt controller
8010375e:	e8 5b f3 ff ff       	call   80102abe <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
80103763:	e8 81 d3 ff ff       	call   80100ae9 <consoleinit>
  uartinit();      // serial port
80103768:	e8 71 31 00 00       	call   801068de <uartinit>
  pinit();         // process table
8010376d:	e8 60 0b 00 00       	call   801042d2 <pinit>
  tvinit();        // trap vectors
80103772:	e8 17 2d 00 00       	call   8010648e <tvinit>
  binit();         // buffer cache
80103777:	e8 b8 c8 ff ff       	call   80100034 <binit>
  fileinit();      // file table
8010377c:	e8 c5 d7 ff ff       	call   80100f46 <fileinit>
  iinit();         // inode cache
80103781:	e8 9e de ff ff       	call   80101624 <iinit>
  ideinit();       // disk
80103786:	e8 77 ef ff ff       	call   80102702 <ideinit>
  if(!ismp)
8010378b:	a1 64 29 11 80       	mov    0x80112964,%eax
80103790:	85 c0                	test   %eax,%eax
80103792:	75 05                	jne    80103799 <main+0x97>
    timerinit();   // uniprocessor timer
80103794:	e8 52 2c 00 00       	call   801063eb <timerinit>
  startothers();   // start other processors
80103799:	e8 84 00 00 00       	call   80103822 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
8010379e:	83 ec 08             	sub    $0x8,%esp
801037a1:	68 00 00 00 8e       	push   $0x8e000000
801037a6:	68 00 00 40 80       	push   $0x80400000
801037ab:	e8 52 f4 ff ff       	call   80102c02 <kinit2>
801037b0:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
801037b3:	e8 3e 0c 00 00       	call   801043f6 <userinit>
    
  //InitHandle();
  APGuiInit();
801037b8:	e8 9b 65 00 00       	call   80109d58 <APGuiInit>
    
  // Finish setting up this processor in mpmain.
  mpmain();
801037bd:	e8 1a 00 00 00       	call   801037dc <mpmain>

801037c2 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801037c2:	55                   	push   %ebp
801037c3:	89 e5                	mov    %esp,%ebp
801037c5:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
801037c8:	e8 24 44 00 00       	call   80107bf1 <switchkvm>
  seginit();
801037cd:	e8 b0 3d 00 00       	call   80107582 <seginit>
  lapicinit();
801037d2:	e8 6d f8 ff ff       	call   80103044 <lapicinit>
  mpmain();
801037d7:	e8 00 00 00 00       	call   801037dc <mpmain>

801037dc <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801037dc:	55                   	push   %ebp
801037dd:	89 e5                	mov    %esp,%ebp
801037df:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
801037e2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801037e8:	0f b6 00             	movzbl (%eax),%eax
801037eb:	0f b6 c0             	movzbl %al,%eax
801037ee:	83 ec 08             	sub    $0x8,%esp
801037f1:	50                   	push   %eax
801037f2:	68 73 b6 10 80       	push   $0x8010b673
801037f7:	e8 ca cb ff ff       	call   801003c6 <cprintf>
801037fc:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
801037ff:	e8 00 2e 00 00       	call   80106604 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103804:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010380a:	05 a8 00 00 00       	add    $0xa8,%eax
8010380f:	83 ec 08             	sub    $0x8,%esp
80103812:	6a 01                	push   $0x1
80103814:	50                   	push   %eax
80103815:	e8 ce fe ff ff       	call   801036e8 <xchg>
8010381a:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
8010381d:	e8 55 11 00 00       	call   80104977 <scheduler>

80103822 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103822:	55                   	push   %ebp
80103823:	89 e5                	mov    %esp,%ebp
80103825:	53                   	push   %ebx
80103826:	83 ec 14             	sub    $0x14,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
80103829:	68 00 70 00 00       	push   $0x7000
8010382e:	e8 a8 fe ff ff       	call   801036db <p2v>
80103833:	83 c4 04             	add    $0x4,%esp
80103836:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103839:	b8 8a 00 00 00       	mov    $0x8a,%eax
8010383e:	83 ec 04             	sub    $0x4,%esp
80103841:	50                   	push   %eax
80103842:	68 38 e5 10 80       	push   $0x8010e538
80103847:	ff 75 f0             	pushl  -0x10(%ebp)
8010384a:	e8 10 19 00 00       	call   8010515f <memmove>
8010384f:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80103852:	c7 45 f4 80 29 11 80 	movl   $0x80112980,-0xc(%ebp)
80103859:	e9 90 00 00 00       	jmp    801038ee <startothers+0xcc>
    if(c == cpus+cpunum())  // We've started already.
8010385e:	e8 ff f8 ff ff       	call   80103162 <cpunum>
80103863:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103869:	05 80 29 11 80       	add    $0x80112980,%eax
8010386e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103871:	74 73                	je     801038e6 <startothers+0xc4>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103873:	e8 88 f4 ff ff       	call   80102d00 <kalloc>
80103878:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
8010387b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010387e:	83 e8 04             	sub    $0x4,%eax
80103881:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103884:	81 c2 00 10 00 00    	add    $0x1000,%edx
8010388a:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
8010388c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010388f:	83 e8 08             	sub    $0x8,%eax
80103892:	c7 00 c2 37 10 80    	movl   $0x801037c2,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
80103898:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010389b:	8d 58 f4             	lea    -0xc(%eax),%ebx
8010389e:	83 ec 0c             	sub    $0xc,%esp
801038a1:	68 00 d0 10 80       	push   $0x8010d000
801038a6:	e8 23 fe ff ff       	call   801036ce <v2p>
801038ab:	83 c4 10             	add    $0x10,%esp
801038ae:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
801038b0:	83 ec 0c             	sub    $0xc,%esp
801038b3:	ff 75 f0             	pushl  -0x10(%ebp)
801038b6:	e8 13 fe ff ff       	call   801036ce <v2p>
801038bb:	83 c4 10             	add    $0x10,%esp
801038be:	89 c2                	mov    %eax,%edx
801038c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038c3:	0f b6 00             	movzbl (%eax),%eax
801038c6:	0f b6 c0             	movzbl %al,%eax
801038c9:	83 ec 08             	sub    $0x8,%esp
801038cc:	52                   	push   %edx
801038cd:	50                   	push   %eax
801038ce:	e8 09 f9 ff ff       	call   801031dc <lapicstartap>
801038d3:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801038d6:	90                   	nop
801038d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038da:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801038e0:	85 c0                	test   %eax,%eax
801038e2:	74 f3                	je     801038d7 <startothers+0xb5>
801038e4:	eb 01                	jmp    801038e7 <startothers+0xc5>
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
801038e6:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
801038e7:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
801038ee:	a1 60 2f 11 80       	mov    0x80112f60,%eax
801038f3:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801038f9:	05 80 29 11 80       	add    $0x80112980,%eax
801038fe:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103901:	0f 87 57 ff ff ff    	ja     8010385e <startothers+0x3c>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
80103907:	90                   	nop
80103908:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010390b:	c9                   	leave  
8010390c:	c3                   	ret    

8010390d <p2v>:
8010390d:	55                   	push   %ebp
8010390e:	89 e5                	mov    %esp,%ebp
80103910:	8b 45 08             	mov    0x8(%ebp),%eax
80103913:	05 00 00 00 80       	add    $0x80000000,%eax
80103918:	5d                   	pop    %ebp
80103919:	c3                   	ret    

8010391a <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
8010391a:	55                   	push   %ebp
8010391b:	89 e5                	mov    %esp,%ebp
8010391d:	83 ec 14             	sub    $0x14,%esp
80103920:	8b 45 08             	mov    0x8(%ebp),%eax
80103923:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103927:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
8010392b:	89 c2                	mov    %eax,%edx
8010392d:	ec                   	in     (%dx),%al
8010392e:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103931:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103935:	c9                   	leave  
80103936:	c3                   	ret    

80103937 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103937:	55                   	push   %ebp
80103938:	89 e5                	mov    %esp,%ebp
8010393a:	83 ec 08             	sub    $0x8,%esp
8010393d:	8b 55 08             	mov    0x8(%ebp),%edx
80103940:	8b 45 0c             	mov    0xc(%ebp),%eax
80103943:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103947:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010394a:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010394e:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103952:	ee                   	out    %al,(%dx)
}
80103953:	90                   	nop
80103954:	c9                   	leave  
80103955:	c3                   	ret    

80103956 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103956:	55                   	push   %ebp
80103957:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103959:	a1 88 e6 10 80       	mov    0x8010e688,%eax
8010395e:	89 c2                	mov    %eax,%edx
80103960:	b8 80 29 11 80       	mov    $0x80112980,%eax
80103965:	29 c2                	sub    %eax,%edx
80103967:	89 d0                	mov    %edx,%eax
80103969:	c1 f8 02             	sar    $0x2,%eax
8010396c:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
80103972:	5d                   	pop    %ebp
80103973:	c3                   	ret    

80103974 <sum>:

static uchar
sum(uchar *addr, int len)
{
80103974:	55                   	push   %ebp
80103975:	89 e5                	mov    %esp,%ebp
80103977:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
8010397a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103981:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103988:	eb 15                	jmp    8010399f <sum+0x2b>
    sum += addr[i];
8010398a:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010398d:	8b 45 08             	mov    0x8(%ebp),%eax
80103990:	01 d0                	add    %edx,%eax
80103992:	0f b6 00             	movzbl (%eax),%eax
80103995:	0f b6 c0             	movzbl %al,%eax
80103998:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
8010399b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010399f:	8b 45 fc             	mov    -0x4(%ebp),%eax
801039a2:	3b 45 0c             	cmp    0xc(%ebp),%eax
801039a5:	7c e3                	jl     8010398a <sum+0x16>
    sum += addr[i];
  return sum;
801039a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
801039aa:	c9                   	leave  
801039ab:	c3                   	ret    

801039ac <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801039ac:	55                   	push   %ebp
801039ad:	89 e5                	mov    %esp,%ebp
801039af:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
801039b2:	ff 75 08             	pushl  0x8(%ebp)
801039b5:	e8 53 ff ff ff       	call   8010390d <p2v>
801039ba:	83 c4 04             	add    $0x4,%esp
801039bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
801039c0:	8b 55 0c             	mov    0xc(%ebp),%edx
801039c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039c6:	01 d0                	add    %edx,%eax
801039c8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
801039cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
801039d1:	eb 36                	jmp    80103a09 <mpsearch1+0x5d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801039d3:	83 ec 04             	sub    $0x4,%esp
801039d6:	6a 04                	push   $0x4
801039d8:	68 84 b6 10 80       	push   $0x8010b684
801039dd:	ff 75 f4             	pushl  -0xc(%ebp)
801039e0:	e8 22 17 00 00       	call   80105107 <memcmp>
801039e5:	83 c4 10             	add    $0x10,%esp
801039e8:	85 c0                	test   %eax,%eax
801039ea:	75 19                	jne    80103a05 <mpsearch1+0x59>
801039ec:	83 ec 08             	sub    $0x8,%esp
801039ef:	6a 10                	push   $0x10
801039f1:	ff 75 f4             	pushl  -0xc(%ebp)
801039f4:	e8 7b ff ff ff       	call   80103974 <sum>
801039f9:	83 c4 10             	add    $0x10,%esp
801039fc:	84 c0                	test   %al,%al
801039fe:	75 05                	jne    80103a05 <mpsearch1+0x59>
      return (struct mp*)p;
80103a00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a03:	eb 11                	jmp    80103a16 <mpsearch1+0x6a>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103a05:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103a09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a0c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103a0f:	72 c2                	jb     801039d3 <mpsearch1+0x27>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103a11:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103a16:	c9                   	leave  
80103a17:	c3                   	ret    

80103a18 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103a18:	55                   	push   %ebp
80103a19:	89 e5                	mov    %esp,%ebp
80103a1b:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103a1e:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103a25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a28:	83 c0 0f             	add    $0xf,%eax
80103a2b:	0f b6 00             	movzbl (%eax),%eax
80103a2e:	0f b6 c0             	movzbl %al,%eax
80103a31:	c1 e0 08             	shl    $0x8,%eax
80103a34:	89 c2                	mov    %eax,%edx
80103a36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a39:	83 c0 0e             	add    $0xe,%eax
80103a3c:	0f b6 00             	movzbl (%eax),%eax
80103a3f:	0f b6 c0             	movzbl %al,%eax
80103a42:	09 d0                	or     %edx,%eax
80103a44:	c1 e0 04             	shl    $0x4,%eax
80103a47:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103a4a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103a4e:	74 21                	je     80103a71 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103a50:	83 ec 08             	sub    $0x8,%esp
80103a53:	68 00 04 00 00       	push   $0x400
80103a58:	ff 75 f0             	pushl  -0x10(%ebp)
80103a5b:	e8 4c ff ff ff       	call   801039ac <mpsearch1>
80103a60:	83 c4 10             	add    $0x10,%esp
80103a63:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103a66:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103a6a:	74 51                	je     80103abd <mpsearch+0xa5>
      return mp;
80103a6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103a6f:	eb 61                	jmp    80103ad2 <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103a71:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a74:	83 c0 14             	add    $0x14,%eax
80103a77:	0f b6 00             	movzbl (%eax),%eax
80103a7a:	0f b6 c0             	movzbl %al,%eax
80103a7d:	c1 e0 08             	shl    $0x8,%eax
80103a80:	89 c2                	mov    %eax,%edx
80103a82:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a85:	83 c0 13             	add    $0x13,%eax
80103a88:	0f b6 00             	movzbl (%eax),%eax
80103a8b:	0f b6 c0             	movzbl %al,%eax
80103a8e:	09 d0                	or     %edx,%eax
80103a90:	c1 e0 0a             	shl    $0xa,%eax
80103a93:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103a96:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a99:	2d 00 04 00 00       	sub    $0x400,%eax
80103a9e:	83 ec 08             	sub    $0x8,%esp
80103aa1:	68 00 04 00 00       	push   $0x400
80103aa6:	50                   	push   %eax
80103aa7:	e8 00 ff ff ff       	call   801039ac <mpsearch1>
80103aac:	83 c4 10             	add    $0x10,%esp
80103aaf:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103ab2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103ab6:	74 05                	je     80103abd <mpsearch+0xa5>
      return mp;
80103ab8:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103abb:	eb 15                	jmp    80103ad2 <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80103abd:	83 ec 08             	sub    $0x8,%esp
80103ac0:	68 00 00 01 00       	push   $0x10000
80103ac5:	68 00 00 0f 00       	push   $0xf0000
80103aca:	e8 dd fe ff ff       	call   801039ac <mpsearch1>
80103acf:	83 c4 10             	add    $0x10,%esp
}
80103ad2:	c9                   	leave  
80103ad3:	c3                   	ret    

80103ad4 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103ad4:	55                   	push   %ebp
80103ad5:	89 e5                	mov    %esp,%ebp
80103ad7:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103ada:	e8 39 ff ff ff       	call   80103a18 <mpsearch>
80103adf:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103ae2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103ae6:	74 0a                	je     80103af2 <mpconfig+0x1e>
80103ae8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103aeb:	8b 40 04             	mov    0x4(%eax),%eax
80103aee:	85 c0                	test   %eax,%eax
80103af0:	75 0a                	jne    80103afc <mpconfig+0x28>
    return 0;
80103af2:	b8 00 00 00 00       	mov    $0x0,%eax
80103af7:	e9 81 00 00 00       	jmp    80103b7d <mpconfig+0xa9>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103afc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103aff:	8b 40 04             	mov    0x4(%eax),%eax
80103b02:	83 ec 0c             	sub    $0xc,%esp
80103b05:	50                   	push   %eax
80103b06:	e8 02 fe ff ff       	call   8010390d <p2v>
80103b0b:	83 c4 10             	add    $0x10,%esp
80103b0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103b11:	83 ec 04             	sub    $0x4,%esp
80103b14:	6a 04                	push   $0x4
80103b16:	68 89 b6 10 80       	push   $0x8010b689
80103b1b:	ff 75 f0             	pushl  -0x10(%ebp)
80103b1e:	e8 e4 15 00 00       	call   80105107 <memcmp>
80103b23:	83 c4 10             	add    $0x10,%esp
80103b26:	85 c0                	test   %eax,%eax
80103b28:	74 07                	je     80103b31 <mpconfig+0x5d>
    return 0;
80103b2a:	b8 00 00 00 00       	mov    $0x0,%eax
80103b2f:	eb 4c                	jmp    80103b7d <mpconfig+0xa9>
  if(conf->version != 1 && conf->version != 4)
80103b31:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b34:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103b38:	3c 01                	cmp    $0x1,%al
80103b3a:	74 12                	je     80103b4e <mpconfig+0x7a>
80103b3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b3f:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103b43:	3c 04                	cmp    $0x4,%al
80103b45:	74 07                	je     80103b4e <mpconfig+0x7a>
    return 0;
80103b47:	b8 00 00 00 00       	mov    $0x0,%eax
80103b4c:	eb 2f                	jmp    80103b7d <mpconfig+0xa9>
  if(sum((uchar*)conf, conf->length) != 0)
80103b4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b51:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103b55:	0f b7 c0             	movzwl %ax,%eax
80103b58:	83 ec 08             	sub    $0x8,%esp
80103b5b:	50                   	push   %eax
80103b5c:	ff 75 f0             	pushl  -0x10(%ebp)
80103b5f:	e8 10 fe ff ff       	call   80103974 <sum>
80103b64:	83 c4 10             	add    $0x10,%esp
80103b67:	84 c0                	test   %al,%al
80103b69:	74 07                	je     80103b72 <mpconfig+0x9e>
    return 0;
80103b6b:	b8 00 00 00 00       	mov    $0x0,%eax
80103b70:	eb 0b                	jmp    80103b7d <mpconfig+0xa9>
  *pmp = mp;
80103b72:	8b 45 08             	mov    0x8(%ebp),%eax
80103b75:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103b78:	89 10                	mov    %edx,(%eax)
  return conf;
80103b7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103b7d:	c9                   	leave  
80103b7e:	c3                   	ret    

80103b7f <mpinit>:

void
mpinit(void)
{
80103b7f:	55                   	push   %ebp
80103b80:	89 e5                	mov    %esp,%ebp
80103b82:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103b85:	c7 05 88 e6 10 80 80 	movl   $0x80112980,0x8010e688
80103b8c:	29 11 80 
  if((conf = mpconfig(&mp)) == 0)
80103b8f:	83 ec 0c             	sub    $0xc,%esp
80103b92:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103b95:	50                   	push   %eax
80103b96:	e8 39 ff ff ff       	call   80103ad4 <mpconfig>
80103b9b:	83 c4 10             	add    $0x10,%esp
80103b9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103ba1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103ba5:	0f 84 96 01 00 00    	je     80103d41 <mpinit+0x1c2>
    return;
  ismp = 1;
80103bab:	c7 05 64 29 11 80 01 	movl   $0x1,0x80112964
80103bb2:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103bb5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bb8:	8b 40 24             	mov    0x24(%eax),%eax
80103bbb:	a3 dc 28 11 80       	mov    %eax,0x801128dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103bc0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bc3:	83 c0 2c             	add    $0x2c,%eax
80103bc6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103bc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bcc:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103bd0:	0f b7 d0             	movzwl %ax,%edx
80103bd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bd6:	01 d0                	add    %edx,%eax
80103bd8:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103bdb:	e9 f2 00 00 00       	jmp    80103cd2 <mpinit+0x153>
    switch(*p){
80103be0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103be3:	0f b6 00             	movzbl (%eax),%eax
80103be6:	0f b6 c0             	movzbl %al,%eax
80103be9:	83 f8 04             	cmp    $0x4,%eax
80103bec:	0f 87 bc 00 00 00    	ja     80103cae <mpinit+0x12f>
80103bf2:	8b 04 85 cc b6 10 80 	mov    -0x7fef4934(,%eax,4),%eax
80103bf9:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103bfb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bfe:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103c01:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103c04:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103c08:	0f b6 d0             	movzbl %al,%edx
80103c0b:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103c10:	39 c2                	cmp    %eax,%edx
80103c12:	74 2b                	je     80103c3f <mpinit+0xc0>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103c14:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103c17:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103c1b:	0f b6 d0             	movzbl %al,%edx
80103c1e:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103c23:	83 ec 04             	sub    $0x4,%esp
80103c26:	52                   	push   %edx
80103c27:	50                   	push   %eax
80103c28:	68 8e b6 10 80       	push   $0x8010b68e
80103c2d:	e8 94 c7 ff ff       	call   801003c6 <cprintf>
80103c32:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
80103c35:	c7 05 64 29 11 80 00 	movl   $0x0,0x80112964
80103c3c:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103c3f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103c42:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103c46:	0f b6 c0             	movzbl %al,%eax
80103c49:	83 e0 02             	and    $0x2,%eax
80103c4c:	85 c0                	test   %eax,%eax
80103c4e:	74 15                	je     80103c65 <mpinit+0xe6>
        bcpu = &cpus[ncpu];
80103c50:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103c55:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103c5b:	05 80 29 11 80       	add    $0x80112980,%eax
80103c60:	a3 88 e6 10 80       	mov    %eax,0x8010e688
      cpus[ncpu].id = ncpu;
80103c65:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103c6a:	8b 15 60 2f 11 80    	mov    0x80112f60,%edx
80103c70:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103c76:	05 80 29 11 80       	add    $0x80112980,%eax
80103c7b:	88 10                	mov    %dl,(%eax)
      ncpu++;
80103c7d:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103c82:	83 c0 01             	add    $0x1,%eax
80103c85:	a3 60 2f 11 80       	mov    %eax,0x80112f60
      p += sizeof(struct mpproc);
80103c8a:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103c8e:	eb 42                	jmp    80103cd2 <mpinit+0x153>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103c90:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c93:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103c96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103c99:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103c9d:	a2 60 29 11 80       	mov    %al,0x80112960
      p += sizeof(struct mpioapic);
80103ca2:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103ca6:	eb 2a                	jmp    80103cd2 <mpinit+0x153>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103ca8:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103cac:	eb 24                	jmp    80103cd2 <mpinit+0x153>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103cae:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cb1:	0f b6 00             	movzbl (%eax),%eax
80103cb4:	0f b6 c0             	movzbl %al,%eax
80103cb7:	83 ec 08             	sub    $0x8,%esp
80103cba:	50                   	push   %eax
80103cbb:	68 ac b6 10 80       	push   $0x8010b6ac
80103cc0:	e8 01 c7 ff ff       	call   801003c6 <cprintf>
80103cc5:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
80103cc8:	c7 05 64 29 11 80 00 	movl   $0x0,0x80112964
80103ccf:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103cd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cd5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103cd8:	0f 82 02 ff ff ff    	jb     80103be0 <mpinit+0x61>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103cde:	a1 64 29 11 80       	mov    0x80112964,%eax
80103ce3:	85 c0                	test   %eax,%eax
80103ce5:	75 1d                	jne    80103d04 <mpinit+0x185>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103ce7:	c7 05 60 2f 11 80 01 	movl   $0x1,0x80112f60
80103cee:	00 00 00 
    lapic = 0;
80103cf1:	c7 05 dc 28 11 80 00 	movl   $0x0,0x801128dc
80103cf8:	00 00 00 
    ioapicid = 0;
80103cfb:	c6 05 60 29 11 80 00 	movb   $0x0,0x80112960
    return;
80103d02:	eb 3e                	jmp    80103d42 <mpinit+0x1c3>
  }

  if(mp->imcrp){
80103d04:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103d07:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103d0b:	84 c0                	test   %al,%al
80103d0d:	74 33                	je     80103d42 <mpinit+0x1c3>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103d0f:	83 ec 08             	sub    $0x8,%esp
80103d12:	6a 70                	push   $0x70
80103d14:	6a 22                	push   $0x22
80103d16:	e8 1c fc ff ff       	call   80103937 <outb>
80103d1b:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103d1e:	83 ec 0c             	sub    $0xc,%esp
80103d21:	6a 23                	push   $0x23
80103d23:	e8 f2 fb ff ff       	call   8010391a <inb>
80103d28:	83 c4 10             	add    $0x10,%esp
80103d2b:	83 c8 01             	or     $0x1,%eax
80103d2e:	0f b6 c0             	movzbl %al,%eax
80103d31:	83 ec 08             	sub    $0x8,%esp
80103d34:	50                   	push   %eax
80103d35:	6a 23                	push   $0x23
80103d37:	e8 fb fb ff ff       	call   80103937 <outb>
80103d3c:	83 c4 10             	add    $0x10,%esp
80103d3f:	eb 01                	jmp    80103d42 <mpinit+0x1c3>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
80103d41:	90                   	nop
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103d42:	c9                   	leave  
80103d43:	c3                   	ret    

80103d44 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103d44:	55                   	push   %ebp
80103d45:	89 e5                	mov    %esp,%ebp
80103d47:	83 ec 08             	sub    $0x8,%esp
80103d4a:	8b 55 08             	mov    0x8(%ebp),%edx
80103d4d:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d50:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103d54:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103d57:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103d5b:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103d5f:	ee                   	out    %al,(%dx)
}
80103d60:	90                   	nop
80103d61:	c9                   	leave  
80103d62:	c3                   	ret    

80103d63 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103d63:	55                   	push   %ebp
80103d64:	89 e5                	mov    %esp,%ebp
80103d66:	83 ec 04             	sub    $0x4,%esp
80103d69:	8b 45 08             	mov    0x8(%ebp),%eax
80103d6c:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103d70:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103d74:	66 a3 00 e0 10 80    	mov    %ax,0x8010e000
  outb(IO_PIC1+1, mask);
80103d7a:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103d7e:	0f b6 c0             	movzbl %al,%eax
80103d81:	50                   	push   %eax
80103d82:	6a 21                	push   $0x21
80103d84:	e8 bb ff ff ff       	call   80103d44 <outb>
80103d89:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80103d8c:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103d90:	66 c1 e8 08          	shr    $0x8,%ax
80103d94:	0f b6 c0             	movzbl %al,%eax
80103d97:	50                   	push   %eax
80103d98:	68 a1 00 00 00       	push   $0xa1
80103d9d:	e8 a2 ff ff ff       	call   80103d44 <outb>
80103da2:	83 c4 08             	add    $0x8,%esp
}
80103da5:	90                   	nop
80103da6:	c9                   	leave  
80103da7:	c3                   	ret    

80103da8 <picenable>:

void
picenable(int irq)
{
80103da8:	55                   	push   %ebp
80103da9:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80103dab:	8b 45 08             	mov    0x8(%ebp),%eax
80103dae:	ba 01 00 00 00       	mov    $0x1,%edx
80103db3:	89 c1                	mov    %eax,%ecx
80103db5:	d3 e2                	shl    %cl,%edx
80103db7:	89 d0                	mov    %edx,%eax
80103db9:	f7 d0                	not    %eax
80103dbb:	89 c2                	mov    %eax,%edx
80103dbd:	0f b7 05 00 e0 10 80 	movzwl 0x8010e000,%eax
80103dc4:	21 d0                	and    %edx,%eax
80103dc6:	0f b7 c0             	movzwl %ax,%eax
80103dc9:	50                   	push   %eax
80103dca:	e8 94 ff ff ff       	call   80103d63 <picsetmask>
80103dcf:	83 c4 04             	add    $0x4,%esp
}
80103dd2:	90                   	nop
80103dd3:	c9                   	leave  
80103dd4:	c3                   	ret    

80103dd5 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103dd5:	55                   	push   %ebp
80103dd6:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103dd8:	68 ff 00 00 00       	push   $0xff
80103ddd:	6a 21                	push   $0x21
80103ddf:	e8 60 ff ff ff       	call   80103d44 <outb>
80103de4:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80103de7:	68 ff 00 00 00       	push   $0xff
80103dec:	68 a1 00 00 00       	push   $0xa1
80103df1:	e8 4e ff ff ff       	call   80103d44 <outb>
80103df6:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103df9:	6a 11                	push   $0x11
80103dfb:	6a 20                	push   $0x20
80103dfd:	e8 42 ff ff ff       	call   80103d44 <outb>
80103e02:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103e05:	6a 20                	push   $0x20
80103e07:	6a 21                	push   $0x21
80103e09:	e8 36 ff ff ff       	call   80103d44 <outb>
80103e0e:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103e11:	6a 04                	push   $0x4
80103e13:	6a 21                	push   $0x21
80103e15:	e8 2a ff ff ff       	call   80103d44 <outb>
80103e1a:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103e1d:	6a 03                	push   $0x3
80103e1f:	6a 21                	push   $0x21
80103e21:	e8 1e ff ff ff       	call   80103d44 <outb>
80103e26:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103e29:	6a 11                	push   $0x11
80103e2b:	68 a0 00 00 00       	push   $0xa0
80103e30:	e8 0f ff ff ff       	call   80103d44 <outb>
80103e35:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103e38:	6a 28                	push   $0x28
80103e3a:	68 a1 00 00 00       	push   $0xa1
80103e3f:	e8 00 ff ff ff       	call   80103d44 <outb>
80103e44:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103e47:	6a 02                	push   $0x2
80103e49:	68 a1 00 00 00       	push   $0xa1
80103e4e:	e8 f1 fe ff ff       	call   80103d44 <outb>
80103e53:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103e56:	6a 03                	push   $0x3
80103e58:	68 a1 00 00 00       	push   $0xa1
80103e5d:	e8 e2 fe ff ff       	call   80103d44 <outb>
80103e62:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103e65:	6a 68                	push   $0x68
80103e67:	6a 20                	push   $0x20
80103e69:	e8 d6 fe ff ff       	call   80103d44 <outb>
80103e6e:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103e71:	6a 0a                	push   $0xa
80103e73:	6a 20                	push   $0x20
80103e75:	e8 ca fe ff ff       	call   80103d44 <outb>
80103e7a:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
80103e7d:	6a 68                	push   $0x68
80103e7f:	68 a0 00 00 00       	push   $0xa0
80103e84:	e8 bb fe ff ff       	call   80103d44 <outb>
80103e89:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
80103e8c:	6a 0a                	push   $0xa
80103e8e:	68 a0 00 00 00       	push   $0xa0
80103e93:	e8 ac fe ff ff       	call   80103d44 <outb>
80103e98:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
80103e9b:	0f b7 05 00 e0 10 80 	movzwl 0x8010e000,%eax
80103ea2:	66 83 f8 ff          	cmp    $0xffff,%ax
80103ea6:	74 13                	je     80103ebb <picinit+0xe6>
    picsetmask(irqmask);
80103ea8:	0f b7 05 00 e0 10 80 	movzwl 0x8010e000,%eax
80103eaf:	0f b7 c0             	movzwl %ax,%eax
80103eb2:	50                   	push   %eax
80103eb3:	e8 ab fe ff ff       	call   80103d63 <picsetmask>
80103eb8:	83 c4 04             	add    $0x4,%esp
}
80103ebb:	90                   	nop
80103ebc:	c9                   	leave  
80103ebd:	c3                   	ret    

80103ebe <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103ebe:	55                   	push   %ebp
80103ebf:	89 e5                	mov    %esp,%ebp
80103ec1:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80103ec4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103ecb:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ece:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103ed4:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ed7:	8b 10                	mov    (%eax),%edx
80103ed9:	8b 45 08             	mov    0x8(%ebp),%eax
80103edc:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103ede:	e8 81 d0 ff ff       	call   80100f64 <filealloc>
80103ee3:	89 c2                	mov    %eax,%edx
80103ee5:	8b 45 08             	mov    0x8(%ebp),%eax
80103ee8:	89 10                	mov    %edx,(%eax)
80103eea:	8b 45 08             	mov    0x8(%ebp),%eax
80103eed:	8b 00                	mov    (%eax),%eax
80103eef:	85 c0                	test   %eax,%eax
80103ef1:	0f 84 cb 00 00 00    	je     80103fc2 <pipealloc+0x104>
80103ef7:	e8 68 d0 ff ff       	call   80100f64 <filealloc>
80103efc:	89 c2                	mov    %eax,%edx
80103efe:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f01:	89 10                	mov    %edx,(%eax)
80103f03:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f06:	8b 00                	mov    (%eax),%eax
80103f08:	85 c0                	test   %eax,%eax
80103f0a:	0f 84 b2 00 00 00    	je     80103fc2 <pipealloc+0x104>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103f10:	e8 eb ed ff ff       	call   80102d00 <kalloc>
80103f15:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103f18:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103f1c:	0f 84 9f 00 00 00    	je     80103fc1 <pipealloc+0x103>
    goto bad;
  p->readopen = 1;
80103f22:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f25:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103f2c:	00 00 00 
  p->writeopen = 1;
80103f2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f32:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103f39:	00 00 00 
  p->nwrite = 0;
80103f3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f3f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103f46:	00 00 00 
  p->nread = 0;
80103f49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f4c:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103f53:	00 00 00 
  initlock(&p->lock, "pipe");
80103f56:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f59:	83 ec 08             	sub    $0x8,%esp
80103f5c:	68 e0 b6 10 80       	push   $0x8010b6e0
80103f61:	50                   	push   %eax
80103f62:	e8 b4 0e 00 00       	call   80104e1b <initlock>
80103f67:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103f6a:	8b 45 08             	mov    0x8(%ebp),%eax
80103f6d:	8b 00                	mov    (%eax),%eax
80103f6f:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103f75:	8b 45 08             	mov    0x8(%ebp),%eax
80103f78:	8b 00                	mov    (%eax),%eax
80103f7a:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103f7e:	8b 45 08             	mov    0x8(%ebp),%eax
80103f81:	8b 00                	mov    (%eax),%eax
80103f83:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103f87:	8b 45 08             	mov    0x8(%ebp),%eax
80103f8a:	8b 00                	mov    (%eax),%eax
80103f8c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103f8f:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103f92:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f95:	8b 00                	mov    (%eax),%eax
80103f97:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103f9d:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fa0:	8b 00                	mov    (%eax),%eax
80103fa2:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103fa6:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fa9:	8b 00                	mov    (%eax),%eax
80103fab:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103faf:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fb2:	8b 00                	mov    (%eax),%eax
80103fb4:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103fb7:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80103fba:	b8 00 00 00 00       	mov    $0x0,%eax
80103fbf:	eb 4e                	jmp    8010400f <pipealloc+0x151>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
80103fc1:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
80103fc2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103fc6:	74 0e                	je     80103fd6 <pipealloc+0x118>
    kfree((char*)p);
80103fc8:	83 ec 0c             	sub    $0xc,%esp
80103fcb:	ff 75 f4             	pushl  -0xc(%ebp)
80103fce:	e8 90 ec ff ff       	call   80102c63 <kfree>
80103fd3:	83 c4 10             	add    $0x10,%esp
  if(*f0)
80103fd6:	8b 45 08             	mov    0x8(%ebp),%eax
80103fd9:	8b 00                	mov    (%eax),%eax
80103fdb:	85 c0                	test   %eax,%eax
80103fdd:	74 11                	je     80103ff0 <pipealloc+0x132>
    fileclose(*f0);
80103fdf:	8b 45 08             	mov    0x8(%ebp),%eax
80103fe2:	8b 00                	mov    (%eax),%eax
80103fe4:	83 ec 0c             	sub    $0xc,%esp
80103fe7:	50                   	push   %eax
80103fe8:	e8 35 d0 ff ff       	call   80101022 <fileclose>
80103fed:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ff3:	8b 00                	mov    (%eax),%eax
80103ff5:	85 c0                	test   %eax,%eax
80103ff7:	74 11                	je     8010400a <pipealloc+0x14c>
    fileclose(*f1);
80103ff9:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ffc:	8b 00                	mov    (%eax),%eax
80103ffe:	83 ec 0c             	sub    $0xc,%esp
80104001:	50                   	push   %eax
80104002:	e8 1b d0 ff ff       	call   80101022 <fileclose>
80104007:	83 c4 10             	add    $0x10,%esp
  return -1;
8010400a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010400f:	c9                   	leave  
80104010:	c3                   	ret    

80104011 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104011:	55                   	push   %ebp
80104012:	89 e5                	mov    %esp,%ebp
80104014:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
80104017:	8b 45 08             	mov    0x8(%ebp),%eax
8010401a:	83 ec 0c             	sub    $0xc,%esp
8010401d:	50                   	push   %eax
8010401e:	e8 1a 0e 00 00       	call   80104e3d <acquire>
80104023:	83 c4 10             	add    $0x10,%esp
  if(writable){
80104026:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010402a:	74 23                	je     8010404f <pipeclose+0x3e>
    p->writeopen = 0;
8010402c:	8b 45 08             	mov    0x8(%ebp),%eax
8010402f:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80104036:	00 00 00 
    wakeup(&p->nread);
80104039:	8b 45 08             	mov    0x8(%ebp),%eax
8010403c:	05 34 02 00 00       	add    $0x234,%eax
80104041:	83 ec 0c             	sub    $0xc,%esp
80104044:	50                   	push   %eax
80104045:	e8 e5 0b 00 00       	call   80104c2f <wakeup>
8010404a:	83 c4 10             	add    $0x10,%esp
8010404d:	eb 21                	jmp    80104070 <pipeclose+0x5f>
  } else {
    p->readopen = 0;
8010404f:	8b 45 08             	mov    0x8(%ebp),%eax
80104052:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80104059:	00 00 00 
    wakeup(&p->nwrite);
8010405c:	8b 45 08             	mov    0x8(%ebp),%eax
8010405f:	05 38 02 00 00       	add    $0x238,%eax
80104064:	83 ec 0c             	sub    $0xc,%esp
80104067:	50                   	push   %eax
80104068:	e8 c2 0b 00 00       	call   80104c2f <wakeup>
8010406d:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104070:	8b 45 08             	mov    0x8(%ebp),%eax
80104073:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104079:	85 c0                	test   %eax,%eax
8010407b:	75 2c                	jne    801040a9 <pipeclose+0x98>
8010407d:	8b 45 08             	mov    0x8(%ebp),%eax
80104080:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104086:	85 c0                	test   %eax,%eax
80104088:	75 1f                	jne    801040a9 <pipeclose+0x98>
    release(&p->lock);
8010408a:	8b 45 08             	mov    0x8(%ebp),%eax
8010408d:	83 ec 0c             	sub    $0xc,%esp
80104090:	50                   	push   %eax
80104091:	e8 0e 0e 00 00       	call   80104ea4 <release>
80104096:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
80104099:	83 ec 0c             	sub    $0xc,%esp
8010409c:	ff 75 08             	pushl  0x8(%ebp)
8010409f:	e8 bf eb ff ff       	call   80102c63 <kfree>
801040a4:	83 c4 10             	add    $0x10,%esp
801040a7:	eb 0f                	jmp    801040b8 <pipeclose+0xa7>
  } else
    release(&p->lock);
801040a9:	8b 45 08             	mov    0x8(%ebp),%eax
801040ac:	83 ec 0c             	sub    $0xc,%esp
801040af:	50                   	push   %eax
801040b0:	e8 ef 0d 00 00       	call   80104ea4 <release>
801040b5:	83 c4 10             	add    $0x10,%esp
}
801040b8:	90                   	nop
801040b9:	c9                   	leave  
801040ba:	c3                   	ret    

801040bb <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801040bb:	55                   	push   %ebp
801040bc:	89 e5                	mov    %esp,%ebp
801040be:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
801040c1:	8b 45 08             	mov    0x8(%ebp),%eax
801040c4:	83 ec 0c             	sub    $0xc,%esp
801040c7:	50                   	push   %eax
801040c8:	e8 70 0d 00 00       	call   80104e3d <acquire>
801040cd:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
801040d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801040d7:	e9 ad 00 00 00       	jmp    80104189 <pipewrite+0xce>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
801040dc:	8b 45 08             	mov    0x8(%ebp),%eax
801040df:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
801040e5:	85 c0                	test   %eax,%eax
801040e7:	74 0d                	je     801040f6 <pipewrite+0x3b>
801040e9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801040ef:	8b 40 24             	mov    0x24(%eax),%eax
801040f2:	85 c0                	test   %eax,%eax
801040f4:	74 19                	je     8010410f <pipewrite+0x54>
        release(&p->lock);
801040f6:	8b 45 08             	mov    0x8(%ebp),%eax
801040f9:	83 ec 0c             	sub    $0xc,%esp
801040fc:	50                   	push   %eax
801040fd:	e8 a2 0d 00 00       	call   80104ea4 <release>
80104102:	83 c4 10             	add    $0x10,%esp
        return -1;
80104105:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010410a:	e9 a8 00 00 00       	jmp    801041b7 <pipewrite+0xfc>
      }
      wakeup(&p->nread);
8010410f:	8b 45 08             	mov    0x8(%ebp),%eax
80104112:	05 34 02 00 00       	add    $0x234,%eax
80104117:	83 ec 0c             	sub    $0xc,%esp
8010411a:	50                   	push   %eax
8010411b:	e8 0f 0b 00 00       	call   80104c2f <wakeup>
80104120:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104123:	8b 45 08             	mov    0x8(%ebp),%eax
80104126:	8b 55 08             	mov    0x8(%ebp),%edx
80104129:	81 c2 38 02 00 00    	add    $0x238,%edx
8010412f:	83 ec 08             	sub    $0x8,%esp
80104132:	50                   	push   %eax
80104133:	52                   	push   %edx
80104134:	e8 0b 0a 00 00       	call   80104b44 <sleep>
80104139:	83 c4 10             	add    $0x10,%esp
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010413c:	8b 45 08             	mov    0x8(%ebp),%eax
8010413f:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80104145:	8b 45 08             	mov    0x8(%ebp),%eax
80104148:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
8010414e:	05 00 02 00 00       	add    $0x200,%eax
80104153:	39 c2                	cmp    %eax,%edx
80104155:	74 85                	je     801040dc <pipewrite+0x21>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104157:	8b 45 08             	mov    0x8(%ebp),%eax
8010415a:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104160:	8d 48 01             	lea    0x1(%eax),%ecx
80104163:	8b 55 08             	mov    0x8(%ebp),%edx
80104166:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
8010416c:	25 ff 01 00 00       	and    $0x1ff,%eax
80104171:	89 c1                	mov    %eax,%ecx
80104173:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104176:	8b 45 0c             	mov    0xc(%ebp),%eax
80104179:	01 d0                	add    %edx,%eax
8010417b:	0f b6 10             	movzbl (%eax),%edx
8010417e:	8b 45 08             	mov    0x8(%ebp),%eax
80104181:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80104185:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104189:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010418c:	3b 45 10             	cmp    0x10(%ebp),%eax
8010418f:	7c ab                	jl     8010413c <pipewrite+0x81>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80104191:	8b 45 08             	mov    0x8(%ebp),%eax
80104194:	05 34 02 00 00       	add    $0x234,%eax
80104199:	83 ec 0c             	sub    $0xc,%esp
8010419c:	50                   	push   %eax
8010419d:	e8 8d 0a 00 00       	call   80104c2f <wakeup>
801041a2:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801041a5:	8b 45 08             	mov    0x8(%ebp),%eax
801041a8:	83 ec 0c             	sub    $0xc,%esp
801041ab:	50                   	push   %eax
801041ac:	e8 f3 0c 00 00       	call   80104ea4 <release>
801041b1:	83 c4 10             	add    $0x10,%esp
  return n;
801041b4:	8b 45 10             	mov    0x10(%ebp),%eax
}
801041b7:	c9                   	leave  
801041b8:	c3                   	ret    

801041b9 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801041b9:	55                   	push   %ebp
801041ba:	89 e5                	mov    %esp,%ebp
801041bc:	53                   	push   %ebx
801041bd:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
801041c0:	8b 45 08             	mov    0x8(%ebp),%eax
801041c3:	83 ec 0c             	sub    $0xc,%esp
801041c6:	50                   	push   %eax
801041c7:	e8 71 0c 00 00       	call   80104e3d <acquire>
801041cc:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801041cf:	eb 3f                	jmp    80104210 <piperead+0x57>
    if(proc->killed){
801041d1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801041d7:	8b 40 24             	mov    0x24(%eax),%eax
801041da:	85 c0                	test   %eax,%eax
801041dc:	74 19                	je     801041f7 <piperead+0x3e>
      release(&p->lock);
801041de:	8b 45 08             	mov    0x8(%ebp),%eax
801041e1:	83 ec 0c             	sub    $0xc,%esp
801041e4:	50                   	push   %eax
801041e5:	e8 ba 0c 00 00       	call   80104ea4 <release>
801041ea:	83 c4 10             	add    $0x10,%esp
      return -1;
801041ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801041f2:	e9 bf 00 00 00       	jmp    801042b6 <piperead+0xfd>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801041f7:	8b 45 08             	mov    0x8(%ebp),%eax
801041fa:	8b 55 08             	mov    0x8(%ebp),%edx
801041fd:	81 c2 34 02 00 00    	add    $0x234,%edx
80104203:	83 ec 08             	sub    $0x8,%esp
80104206:	50                   	push   %eax
80104207:	52                   	push   %edx
80104208:	e8 37 09 00 00       	call   80104b44 <sleep>
8010420d:	83 c4 10             	add    $0x10,%esp
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104210:	8b 45 08             	mov    0x8(%ebp),%eax
80104213:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104219:	8b 45 08             	mov    0x8(%ebp),%eax
8010421c:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104222:	39 c2                	cmp    %eax,%edx
80104224:	75 0d                	jne    80104233 <piperead+0x7a>
80104226:	8b 45 08             	mov    0x8(%ebp),%eax
80104229:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
8010422f:	85 c0                	test   %eax,%eax
80104231:	75 9e                	jne    801041d1 <piperead+0x18>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104233:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010423a:	eb 49                	jmp    80104285 <piperead+0xcc>
    if(p->nread == p->nwrite)
8010423c:	8b 45 08             	mov    0x8(%ebp),%eax
8010423f:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104245:	8b 45 08             	mov    0x8(%ebp),%eax
80104248:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010424e:	39 c2                	cmp    %eax,%edx
80104250:	74 3d                	je     8010428f <piperead+0xd6>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104252:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104255:	8b 45 0c             	mov    0xc(%ebp),%eax
80104258:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010425b:	8b 45 08             	mov    0x8(%ebp),%eax
8010425e:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104264:	8d 48 01             	lea    0x1(%eax),%ecx
80104267:	8b 55 08             	mov    0x8(%ebp),%edx
8010426a:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
80104270:	25 ff 01 00 00       	and    $0x1ff,%eax
80104275:	89 c2                	mov    %eax,%edx
80104277:	8b 45 08             	mov    0x8(%ebp),%eax
8010427a:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
8010427f:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104281:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104285:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104288:	3b 45 10             	cmp    0x10(%ebp),%eax
8010428b:	7c af                	jl     8010423c <piperead+0x83>
8010428d:	eb 01                	jmp    80104290 <piperead+0xd7>
    if(p->nread == p->nwrite)
      break;
8010428f:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80104290:	8b 45 08             	mov    0x8(%ebp),%eax
80104293:	05 38 02 00 00       	add    $0x238,%eax
80104298:	83 ec 0c             	sub    $0xc,%esp
8010429b:	50                   	push   %eax
8010429c:	e8 8e 09 00 00       	call   80104c2f <wakeup>
801042a1:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801042a4:	8b 45 08             	mov    0x8(%ebp),%eax
801042a7:	83 ec 0c             	sub    $0xc,%esp
801042aa:	50                   	push   %eax
801042ab:	e8 f4 0b 00 00       	call   80104ea4 <release>
801042b0:	83 c4 10             	add    $0x10,%esp
  return i;
801042b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801042b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042b9:	c9                   	leave  
801042ba:	c3                   	ret    

801042bb <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
801042bb:	55                   	push   %ebp
801042bc:	89 e5                	mov    %esp,%ebp
801042be:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801042c1:	9c                   	pushf  
801042c2:	58                   	pop    %eax
801042c3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801042c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801042c9:	c9                   	leave  
801042ca:	c3                   	ret    

801042cb <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
801042cb:	55                   	push   %ebp
801042cc:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
801042ce:	fb                   	sti    
}
801042cf:	90                   	nop
801042d0:	5d                   	pop    %ebp
801042d1:	c3                   	ret    

801042d2 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801042d2:	55                   	push   %ebp
801042d3:	89 e5                	mov    %esp,%ebp
801042d5:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
801042d8:	83 ec 08             	sub    $0x8,%esp
801042db:	68 e5 b6 10 80       	push   $0x8010b6e5
801042e0:	68 80 2f 11 80       	push   $0x80112f80
801042e5:	e8 31 0b 00 00       	call   80104e1b <initlock>
801042ea:	83 c4 10             	add    $0x10,%esp
}
801042ed:	90                   	nop
801042ee:	c9                   	leave  
801042ef:	c3                   	ret    

801042f0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801042f6:	83 ec 0c             	sub    $0xc,%esp
801042f9:	68 80 2f 11 80       	push   $0x80112f80
801042fe:	e8 3a 0b 00 00       	call   80104e3d <acquire>
80104303:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104306:	c7 45 f4 b4 2f 11 80 	movl   $0x80112fb4,-0xc(%ebp)
8010430d:	eb 0e                	jmp    8010431d <allocproc+0x2d>
    if(p->state == UNUSED)
8010430f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104312:	8b 40 0c             	mov    0xc(%eax),%eax
80104315:	85 c0                	test   %eax,%eax
80104317:	74 27                	je     80104340 <allocproc+0x50>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104319:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
8010431d:	81 7d f4 b4 4e 11 80 	cmpl   $0x80114eb4,-0xc(%ebp)
80104324:	72 e9                	jb     8010430f <allocproc+0x1f>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
80104326:	83 ec 0c             	sub    $0xc,%esp
80104329:	68 80 2f 11 80       	push   $0x80112f80
8010432e:	e8 71 0b 00 00       	call   80104ea4 <release>
80104333:	83 c4 10             	add    $0x10,%esp
  return 0;
80104336:	b8 00 00 00 00       	mov    $0x0,%eax
8010433b:	e9 b4 00 00 00       	jmp    801043f4 <allocproc+0x104>
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
80104340:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80104341:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104344:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
8010434b:	a1 04 e0 10 80       	mov    0x8010e004,%eax
80104350:	8d 50 01             	lea    0x1(%eax),%edx
80104353:	89 15 04 e0 10 80    	mov    %edx,0x8010e004
80104359:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010435c:	89 42 10             	mov    %eax,0x10(%edx)
  release(&ptable.lock);
8010435f:	83 ec 0c             	sub    $0xc,%esp
80104362:	68 80 2f 11 80       	push   $0x80112f80
80104367:	e8 38 0b 00 00       	call   80104ea4 <release>
8010436c:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010436f:	e8 8c e9 ff ff       	call   80102d00 <kalloc>
80104374:	89 c2                	mov    %eax,%edx
80104376:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104379:	89 50 08             	mov    %edx,0x8(%eax)
8010437c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010437f:	8b 40 08             	mov    0x8(%eax),%eax
80104382:	85 c0                	test   %eax,%eax
80104384:	75 11                	jne    80104397 <allocproc+0xa7>
    p->state = UNUSED;
80104386:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104389:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
80104390:	b8 00 00 00 00       	mov    $0x0,%eax
80104395:	eb 5d                	jmp    801043f4 <allocproc+0x104>
  }
  sp = p->kstack + KSTACKSIZE;
80104397:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010439a:	8b 40 08             	mov    0x8(%eax),%eax
8010439d:	05 00 10 00 00       	add    $0x1000,%eax
801043a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801043a5:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
801043a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043ac:	8b 55 f0             	mov    -0x10(%ebp),%edx
801043af:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
801043b2:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
801043b6:	ba 48 64 10 80       	mov    $0x80106448,%edx
801043bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801043be:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
801043c0:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
801043c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043c7:	8b 55 f0             	mov    -0x10(%ebp),%edx
801043ca:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
801043cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043d0:	8b 40 1c             	mov    0x1c(%eax),%eax
801043d3:	83 ec 04             	sub    $0x4,%esp
801043d6:	6a 14                	push   $0x14
801043d8:	6a 00                	push   $0x0
801043da:	50                   	push   %eax
801043db:	e8 c0 0c 00 00       	call   801050a0 <memset>
801043e0:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801043e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043e6:	8b 40 1c             	mov    0x1c(%eax),%eax
801043e9:	ba 13 4b 10 80       	mov    $0x80104b13,%edx
801043ee:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
801043f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801043f4:	c9                   	leave  
801043f5:	c3                   	ret    

801043f6 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801043f6:	55                   	push   %ebp
801043f7:	89 e5                	mov    %esp,%ebp
801043f9:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
801043fc:	e8 ef fe ff ff       	call   801042f0 <allocproc>
80104401:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
80104404:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104407:	a3 8c e6 10 80       	mov    %eax,0x8010e68c
  if((p->pgdir = setupkvm()) == 0)
8010440c:	e8 16 37 00 00       	call   80107b27 <setupkvm>
80104411:	89 c2                	mov    %eax,%edx
80104413:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104416:	89 50 04             	mov    %edx,0x4(%eax)
80104419:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010441c:	8b 40 04             	mov    0x4(%eax),%eax
8010441f:	85 c0                	test   %eax,%eax
80104421:	75 0d                	jne    80104430 <userinit+0x3a>
    panic("userinit: out of memory?");
80104423:	83 ec 0c             	sub    $0xc,%esp
80104426:	68 ec b6 10 80       	push   $0x8010b6ec
8010442b:	e8 36 c1 ff ff       	call   80100566 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104430:	ba 2c 00 00 00       	mov    $0x2c,%edx
80104435:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104438:	8b 40 04             	mov    0x4(%eax),%eax
8010443b:	83 ec 04             	sub    $0x4,%esp
8010443e:	52                   	push   %edx
8010443f:	68 0c e5 10 80       	push   $0x8010e50c
80104444:	50                   	push   %eax
80104445:	e8 37 39 00 00       	call   80107d81 <inituvm>
8010444a:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
8010444d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104450:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
80104456:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104459:	8b 40 18             	mov    0x18(%eax),%eax
8010445c:	83 ec 04             	sub    $0x4,%esp
8010445f:	6a 4c                	push   $0x4c
80104461:	6a 00                	push   $0x0
80104463:	50                   	push   %eax
80104464:	e8 37 0c 00 00       	call   801050a0 <memset>
80104469:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010446c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010446f:	8b 40 18             	mov    0x18(%eax),%eax
80104472:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104478:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010447b:	8b 40 18             	mov    0x18(%eax),%eax
8010447e:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104484:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104487:	8b 40 18             	mov    0x18(%eax),%eax
8010448a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010448d:	8b 52 18             	mov    0x18(%edx),%edx
80104490:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104494:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104498:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010449b:	8b 40 18             	mov    0x18(%eax),%eax
8010449e:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044a1:	8b 52 18             	mov    0x18(%edx),%edx
801044a4:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801044a8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801044ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044af:	8b 40 18             	mov    0x18(%eax),%eax
801044b2:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801044b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044bc:	8b 40 18             	mov    0x18(%eax),%eax
801044bf:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801044c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044c9:	8b 40 18             	mov    0x18(%eax),%eax
801044cc:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
801044d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044d6:	83 c0 6c             	add    $0x6c,%eax
801044d9:	83 ec 04             	sub    $0x4,%esp
801044dc:	6a 10                	push   $0x10
801044de:	68 05 b7 10 80       	push   $0x8010b705
801044e3:	50                   	push   %eax
801044e4:	e8 ba 0d 00 00       	call   801052a3 <safestrcpy>
801044e9:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
801044ec:	83 ec 0c             	sub    $0xc,%esp
801044ef:	68 0e b7 10 80       	push   $0x8010b70e
801044f4:	e8 05 e1 ff ff       	call   801025fe <namei>
801044f9:	83 c4 10             	add    $0x10,%esp
801044fc:	89 c2                	mov    %eax,%edx
801044fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104501:	89 50 68             	mov    %edx,0x68(%eax)

  p->state = RUNNABLE;
80104504:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104507:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
8010450e:	90                   	nop
8010450f:	c9                   	leave  
80104510:	c3                   	ret    

80104511 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104511:	55                   	push   %ebp
80104512:	89 e5                	mov    %esp,%ebp
80104514:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  
  sz = proc->sz;
80104517:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010451d:	8b 00                	mov    (%eax),%eax
8010451f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80104522:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104526:	7e 31                	jle    80104559 <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80104528:	8b 55 08             	mov    0x8(%ebp),%edx
8010452b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010452e:	01 c2                	add    %eax,%edx
80104530:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104536:	8b 40 04             	mov    0x4(%eax),%eax
80104539:	83 ec 04             	sub    $0x4,%esp
8010453c:	52                   	push   %edx
8010453d:	ff 75 f4             	pushl  -0xc(%ebp)
80104540:	50                   	push   %eax
80104541:	e8 88 39 00 00       	call   80107ece <allocuvm>
80104546:	83 c4 10             	add    $0x10,%esp
80104549:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010454c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104550:	75 3e                	jne    80104590 <growproc+0x7f>
      return -1;
80104552:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104557:	eb 59                	jmp    801045b2 <growproc+0xa1>
  } else if(n < 0){
80104559:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010455d:	79 31                	jns    80104590 <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
8010455f:	8b 55 08             	mov    0x8(%ebp),%edx
80104562:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104565:	01 c2                	add    %eax,%edx
80104567:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010456d:	8b 40 04             	mov    0x4(%eax),%eax
80104570:	83 ec 04             	sub    $0x4,%esp
80104573:	52                   	push   %edx
80104574:	ff 75 f4             	pushl  -0xc(%ebp)
80104577:	50                   	push   %eax
80104578:	e8 1a 3a 00 00       	call   80107f97 <deallocuvm>
8010457d:	83 c4 10             	add    $0x10,%esp
80104580:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104583:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104587:	75 07                	jne    80104590 <growproc+0x7f>
      return -1;
80104589:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010458e:	eb 22                	jmp    801045b2 <growproc+0xa1>
  }
  proc->sz = sz;
80104590:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104596:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104599:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
8010459b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045a1:	83 ec 0c             	sub    $0xc,%esp
801045a4:	50                   	push   %eax
801045a5:	e8 64 36 00 00       	call   80107c0e <switchuvm>
801045aa:	83 c4 10             	add    $0x10,%esp
  return 0;
801045ad:	b8 00 00 00 00       	mov    $0x0,%eax
}
801045b2:	c9                   	leave  
801045b3:	c3                   	ret    

801045b4 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801045b4:	55                   	push   %ebp
801045b5:	89 e5                	mov    %esp,%ebp
801045b7:	57                   	push   %edi
801045b8:	56                   	push   %esi
801045b9:	53                   	push   %ebx
801045ba:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
801045bd:	e8 2e fd ff ff       	call   801042f0 <allocproc>
801045c2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801045c5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801045c9:	75 0a                	jne    801045d5 <fork+0x21>
    return -1;
801045cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045d0:	e9 48 01 00 00       	jmp    8010471d <fork+0x169>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
801045d5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045db:	8b 10                	mov    (%eax),%edx
801045dd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045e3:	8b 40 04             	mov    0x4(%eax),%eax
801045e6:	83 ec 08             	sub    $0x8,%esp
801045e9:	52                   	push   %edx
801045ea:	50                   	push   %eax
801045eb:	e8 45 3b 00 00       	call   80108135 <copyuvm>
801045f0:	83 c4 10             	add    $0x10,%esp
801045f3:	89 c2                	mov    %eax,%edx
801045f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801045f8:	89 50 04             	mov    %edx,0x4(%eax)
801045fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801045fe:	8b 40 04             	mov    0x4(%eax),%eax
80104601:	85 c0                	test   %eax,%eax
80104603:	75 30                	jne    80104635 <fork+0x81>
    kfree(np->kstack);
80104605:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104608:	8b 40 08             	mov    0x8(%eax),%eax
8010460b:	83 ec 0c             	sub    $0xc,%esp
8010460e:	50                   	push   %eax
8010460f:	e8 4f e6 ff ff       	call   80102c63 <kfree>
80104614:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
80104617:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010461a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80104621:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104624:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
8010462b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104630:	e9 e8 00 00 00       	jmp    8010471d <fork+0x169>
  }
  np->sz = proc->sz;
80104635:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010463b:	8b 10                	mov    (%eax),%edx
8010463d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104640:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
80104642:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104649:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010464c:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
8010464f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104652:	8b 50 18             	mov    0x18(%eax),%edx
80104655:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010465b:	8b 40 18             	mov    0x18(%eax),%eax
8010465e:	89 c3                	mov    %eax,%ebx
80104660:	b8 13 00 00 00       	mov    $0x13,%eax
80104665:	89 d7                	mov    %edx,%edi
80104667:	89 de                	mov    %ebx,%esi
80104669:	89 c1                	mov    %eax,%ecx
8010466b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
8010466d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104670:	8b 40 18             	mov    0x18(%eax),%eax
80104673:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
8010467a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104681:	eb 43                	jmp    801046c6 <fork+0x112>
    if(proc->ofile[i])
80104683:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104689:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010468c:	83 c2 08             	add    $0x8,%edx
8010468f:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104693:	85 c0                	test   %eax,%eax
80104695:	74 2b                	je     801046c2 <fork+0x10e>
      np->ofile[i] = filedup(proc->ofile[i]);
80104697:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010469d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801046a0:	83 c2 08             	add    $0x8,%edx
801046a3:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801046a7:	83 ec 0c             	sub    $0xc,%esp
801046aa:	50                   	push   %eax
801046ab:	e8 21 c9 ff ff       	call   80100fd1 <filedup>
801046b0:	83 c4 10             	add    $0x10,%esp
801046b3:	89 c1                	mov    %eax,%ecx
801046b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046b8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801046bb:	83 c2 08             	add    $0x8,%edx
801046be:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801046c2:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801046c6:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
801046ca:	7e b7                	jle    80104683 <fork+0xcf>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
801046cc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046d2:	8b 40 68             	mov    0x68(%eax),%eax
801046d5:	83 ec 0c             	sub    $0xc,%esp
801046d8:	50                   	push   %eax
801046d9:	e8 df d1 ff ff       	call   801018bd <idup>
801046de:	83 c4 10             	add    $0x10,%esp
801046e1:	89 c2                	mov    %eax,%edx
801046e3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046e6:	89 50 68             	mov    %edx,0x68(%eax)
 
  pid = np->pid;
801046e9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046ec:	8b 40 10             	mov    0x10(%eax),%eax
801046ef:	89 45 dc             	mov    %eax,-0x24(%ebp)
  np->state = RUNNABLE;
801046f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046f5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
801046fc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104702:	8d 50 6c             	lea    0x6c(%eax),%edx
80104705:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104708:	83 c0 6c             	add    $0x6c,%eax
8010470b:	83 ec 04             	sub    $0x4,%esp
8010470e:	6a 10                	push   $0x10
80104710:	52                   	push   %edx
80104711:	50                   	push   %eax
80104712:	e8 8c 0b 00 00       	call   801052a3 <safestrcpy>
80104717:	83 c4 10             	add    $0x10,%esp
  return pid;
8010471a:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
8010471d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104720:	5b                   	pop    %ebx
80104721:	5e                   	pop    %esi
80104722:	5f                   	pop    %edi
80104723:	5d                   	pop    %ebp
80104724:	c3                   	ret    

80104725 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80104725:	55                   	push   %ebp
80104726:	89 e5                	mov    %esp,%ebp
80104728:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
8010472b:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104732:	a1 8c e6 10 80       	mov    0x8010e68c,%eax
80104737:	39 c2                	cmp    %eax,%edx
80104739:	75 0d                	jne    80104748 <exit+0x23>
    panic("init exiting");
8010473b:	83 ec 0c             	sub    $0xc,%esp
8010473e:	68 10 b7 10 80       	push   $0x8010b710
80104743:	e8 1e be ff ff       	call   80100566 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104748:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010474f:	eb 48                	jmp    80104799 <exit+0x74>
    if(proc->ofile[fd]){
80104751:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104757:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010475a:	83 c2 08             	add    $0x8,%edx
8010475d:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104761:	85 c0                	test   %eax,%eax
80104763:	74 30                	je     80104795 <exit+0x70>
      fileclose(proc->ofile[fd]);
80104765:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010476b:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010476e:	83 c2 08             	add    $0x8,%edx
80104771:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104775:	83 ec 0c             	sub    $0xc,%esp
80104778:	50                   	push   %eax
80104779:	e8 a4 c8 ff ff       	call   80101022 <fileclose>
8010477e:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
80104781:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104787:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010478a:	83 c2 08             	add    $0x8,%edx
8010478d:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104794:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104795:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104799:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
8010479d:	7e b2                	jle    80104751 <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
8010479f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047a5:	8b 40 68             	mov    0x68(%eax),%eax
801047a8:	83 ec 0c             	sub    $0xc,%esp
801047ab:	50                   	push   %eax
801047ac:	e8 10 d3 ff ff       	call   80101ac1 <iput>
801047b1:	83 c4 10             	add    $0x10,%esp
  proc->cwd = 0;
801047b4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047ba:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
801047c1:	83 ec 0c             	sub    $0xc,%esp
801047c4:	68 80 2f 11 80       	push   $0x80112f80
801047c9:	e8 6f 06 00 00       	call   80104e3d <acquire>
801047ce:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
801047d1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047d7:	8b 40 14             	mov    0x14(%eax),%eax
801047da:	83 ec 0c             	sub    $0xc,%esp
801047dd:	50                   	push   %eax
801047de:	e8 0d 04 00 00       	call   80104bf0 <wakeup1>
801047e3:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047e6:	c7 45 f4 b4 2f 11 80 	movl   $0x80112fb4,-0xc(%ebp)
801047ed:	eb 3c                	jmp    8010482b <exit+0x106>
    if(p->parent == proc){
801047ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047f2:	8b 50 14             	mov    0x14(%eax),%edx
801047f5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047fb:	39 c2                	cmp    %eax,%edx
801047fd:	75 28                	jne    80104827 <exit+0x102>
      p->parent = initproc;
801047ff:	8b 15 8c e6 10 80    	mov    0x8010e68c,%edx
80104805:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104808:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
8010480b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010480e:	8b 40 0c             	mov    0xc(%eax),%eax
80104811:	83 f8 05             	cmp    $0x5,%eax
80104814:	75 11                	jne    80104827 <exit+0x102>
        wakeup1(initproc);
80104816:	a1 8c e6 10 80       	mov    0x8010e68c,%eax
8010481b:	83 ec 0c             	sub    $0xc,%esp
8010481e:	50                   	push   %eax
8010481f:	e8 cc 03 00 00       	call   80104bf0 <wakeup1>
80104824:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104827:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
8010482b:	81 7d f4 b4 4e 11 80 	cmpl   $0x80114eb4,-0xc(%ebp)
80104832:	72 bb                	jb     801047ef <exit+0xca>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80104834:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010483a:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
80104841:	e8 d6 01 00 00       	call   80104a1c <sched>
  panic("zombie exit");
80104846:	83 ec 0c             	sub    $0xc,%esp
80104849:	68 1d b7 10 80       	push   $0x8010b71d
8010484e:	e8 13 bd ff ff       	call   80100566 <panic>

80104853 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104853:	55                   	push   %ebp
80104854:	89 e5                	mov    %esp,%ebp
80104856:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80104859:	83 ec 0c             	sub    $0xc,%esp
8010485c:	68 80 2f 11 80       	push   $0x80112f80
80104861:	e8 d7 05 00 00       	call   80104e3d <acquire>
80104866:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80104869:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104870:	c7 45 f4 b4 2f 11 80 	movl   $0x80112fb4,-0xc(%ebp)
80104877:	e9 a6 00 00 00       	jmp    80104922 <wait+0xcf>
      if(p->parent != proc)
8010487c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010487f:	8b 50 14             	mov    0x14(%eax),%edx
80104882:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104888:	39 c2                	cmp    %eax,%edx
8010488a:	0f 85 8d 00 00 00    	jne    8010491d <wait+0xca>
        continue;
      havekids = 1;
80104890:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80104897:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010489a:	8b 40 0c             	mov    0xc(%eax),%eax
8010489d:	83 f8 05             	cmp    $0x5,%eax
801048a0:	75 7c                	jne    8010491e <wait+0xcb>
        // Found one.
        pid = p->pid;
801048a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048a5:	8b 40 10             	mov    0x10(%eax),%eax
801048a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
801048ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048ae:	8b 40 08             	mov    0x8(%eax),%eax
801048b1:	83 ec 0c             	sub    $0xc,%esp
801048b4:	50                   	push   %eax
801048b5:	e8 a9 e3 ff ff       	call   80102c63 <kfree>
801048ba:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
801048bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048c0:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
801048c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048ca:	8b 40 04             	mov    0x4(%eax),%eax
801048cd:	83 ec 0c             	sub    $0xc,%esp
801048d0:	50                   	push   %eax
801048d1:	e8 7e 37 00 00       	call   80108054 <freevm>
801048d6:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
801048d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048dc:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
801048e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048e6:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
801048ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048f0:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
801048f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048fa:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
801048fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104901:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
80104908:	83 ec 0c             	sub    $0xc,%esp
8010490b:	68 80 2f 11 80       	push   $0x80112f80
80104910:	e8 8f 05 00 00       	call   80104ea4 <release>
80104915:	83 c4 10             	add    $0x10,%esp
        return pid;
80104918:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010491b:	eb 58                	jmp    80104975 <wait+0x122>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
8010491d:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010491e:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104922:	81 7d f4 b4 4e 11 80 	cmpl   $0x80114eb4,-0xc(%ebp)
80104929:	0f 82 4d ff ff ff    	jb     8010487c <wait+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
8010492f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104933:	74 0d                	je     80104942 <wait+0xef>
80104935:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010493b:	8b 40 24             	mov    0x24(%eax),%eax
8010493e:	85 c0                	test   %eax,%eax
80104940:	74 17                	je     80104959 <wait+0x106>
      release(&ptable.lock);
80104942:	83 ec 0c             	sub    $0xc,%esp
80104945:	68 80 2f 11 80       	push   $0x80112f80
8010494a:	e8 55 05 00 00       	call   80104ea4 <release>
8010494f:	83 c4 10             	add    $0x10,%esp
      return -1;
80104952:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104957:	eb 1c                	jmp    80104975 <wait+0x122>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104959:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010495f:	83 ec 08             	sub    $0x8,%esp
80104962:	68 80 2f 11 80       	push   $0x80112f80
80104967:	50                   	push   %eax
80104968:	e8 d7 01 00 00       	call   80104b44 <sleep>
8010496d:	83 c4 10             	add    $0x10,%esp
  }
80104970:	e9 f4 fe ff ff       	jmp    80104869 <wait+0x16>
}
80104975:	c9                   	leave  
80104976:	c3                   	ret    

80104977 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80104977:	55                   	push   %ebp
80104978:	89 e5                	mov    %esp,%ebp
8010497a:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
8010497d:	e8 49 f9 ff ff       	call   801042cb <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104982:	83 ec 0c             	sub    $0xc,%esp
80104985:	68 80 2f 11 80       	push   $0x80112f80
8010498a:	e8 ae 04 00 00       	call   80104e3d <acquire>
8010498f:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104992:	c7 45 f4 b4 2f 11 80 	movl   $0x80112fb4,-0xc(%ebp)
80104999:	eb 63                	jmp    801049fe <scheduler+0x87>
      if(p->state != RUNNABLE)
8010499b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010499e:	8b 40 0c             	mov    0xc(%eax),%eax
801049a1:	83 f8 03             	cmp    $0x3,%eax
801049a4:	75 53                	jne    801049f9 <scheduler+0x82>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
801049a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049a9:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
801049af:	83 ec 0c             	sub    $0xc,%esp
801049b2:	ff 75 f4             	pushl  -0xc(%ebp)
801049b5:	e8 54 32 00 00       	call   80107c0e <switchuvm>
801049ba:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
801049bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049c0:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
801049c7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049cd:	8b 40 1c             	mov    0x1c(%eax),%eax
801049d0:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801049d7:	83 c2 04             	add    $0x4,%edx
801049da:	83 ec 08             	sub    $0x8,%esp
801049dd:	50                   	push   %eax
801049de:	52                   	push   %edx
801049df:	e8 30 09 00 00       	call   80105314 <swtch>
801049e4:	83 c4 10             	add    $0x10,%esp
      switchkvm();
801049e7:	e8 05 32 00 00       	call   80107bf1 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
801049ec:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
801049f3:	00 00 00 00 
801049f7:	eb 01                	jmp    801049fa <scheduler+0x83>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;
801049f9:	90                   	nop
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049fa:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
801049fe:	81 7d f4 b4 4e 11 80 	cmpl   $0x80114eb4,-0xc(%ebp)
80104a05:	72 94                	jb     8010499b <scheduler+0x24>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80104a07:	83 ec 0c             	sub    $0xc,%esp
80104a0a:	68 80 2f 11 80       	push   $0x80112f80
80104a0f:	e8 90 04 00 00       	call   80104ea4 <release>
80104a14:	83 c4 10             	add    $0x10,%esp

  }
80104a17:	e9 61 ff ff ff       	jmp    8010497d <scheduler+0x6>

80104a1c <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104a1c:	55                   	push   %ebp
80104a1d:	89 e5                	mov    %esp,%ebp
80104a1f:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104a22:	83 ec 0c             	sub    $0xc,%esp
80104a25:	68 80 2f 11 80       	push   $0x80112f80
80104a2a:	e8 41 05 00 00       	call   80104f70 <holding>
80104a2f:	83 c4 10             	add    $0x10,%esp
80104a32:	85 c0                	test   %eax,%eax
80104a34:	75 0d                	jne    80104a43 <sched+0x27>
    panic("sched ptable.lock");
80104a36:	83 ec 0c             	sub    $0xc,%esp
80104a39:	68 29 b7 10 80       	push   $0x8010b729
80104a3e:	e8 23 bb ff ff       	call   80100566 <panic>
  if(cpu->ncli != 1)
80104a43:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104a49:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104a4f:	83 f8 01             	cmp    $0x1,%eax
80104a52:	74 0d                	je     80104a61 <sched+0x45>
    panic("sched locks");
80104a54:	83 ec 0c             	sub    $0xc,%esp
80104a57:	68 3b b7 10 80       	push   $0x8010b73b
80104a5c:	e8 05 bb ff ff       	call   80100566 <panic>
  if(proc->state == RUNNING)
80104a61:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a67:	8b 40 0c             	mov    0xc(%eax),%eax
80104a6a:	83 f8 04             	cmp    $0x4,%eax
80104a6d:	75 0d                	jne    80104a7c <sched+0x60>
    panic("sched running");
80104a6f:	83 ec 0c             	sub    $0xc,%esp
80104a72:	68 47 b7 10 80       	push   $0x8010b747
80104a77:	e8 ea ba ff ff       	call   80100566 <panic>
  if(readeflags()&FL_IF)
80104a7c:	e8 3a f8 ff ff       	call   801042bb <readeflags>
80104a81:	25 00 02 00 00       	and    $0x200,%eax
80104a86:	85 c0                	test   %eax,%eax
80104a88:	74 0d                	je     80104a97 <sched+0x7b>
    panic("sched interruptible");
80104a8a:	83 ec 0c             	sub    $0xc,%esp
80104a8d:	68 55 b7 10 80       	push   $0x8010b755
80104a92:	e8 cf ba ff ff       	call   80100566 <panic>
  intena = cpu->intena;
80104a97:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104a9d:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104aa3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104aa6:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104aac:	8b 40 04             	mov    0x4(%eax),%eax
80104aaf:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104ab6:	83 c2 1c             	add    $0x1c,%edx
80104ab9:	83 ec 08             	sub    $0x8,%esp
80104abc:	50                   	push   %eax
80104abd:	52                   	push   %edx
80104abe:	e8 51 08 00 00       	call   80105314 <swtch>
80104ac3:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80104ac6:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104acc:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104acf:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104ad5:	90                   	nop
80104ad6:	c9                   	leave  
80104ad7:	c3                   	ret    

80104ad8 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104ad8:	55                   	push   %ebp
80104ad9:	89 e5                	mov    %esp,%ebp
80104adb:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104ade:	83 ec 0c             	sub    $0xc,%esp
80104ae1:	68 80 2f 11 80       	push   $0x80112f80
80104ae6:	e8 52 03 00 00       	call   80104e3d <acquire>
80104aeb:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104aee:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104af4:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104afb:	e8 1c ff ff ff       	call   80104a1c <sched>
  release(&ptable.lock);
80104b00:	83 ec 0c             	sub    $0xc,%esp
80104b03:	68 80 2f 11 80       	push   $0x80112f80
80104b08:	e8 97 03 00 00       	call   80104ea4 <release>
80104b0d:	83 c4 10             	add    $0x10,%esp
}
80104b10:	90                   	nop
80104b11:	c9                   	leave  
80104b12:	c3                   	ret    

80104b13 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104b13:	55                   	push   %ebp
80104b14:	89 e5                	mov    %esp,%ebp
80104b16:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104b19:	83 ec 0c             	sub    $0xc,%esp
80104b1c:	68 80 2f 11 80       	push   $0x80112f80
80104b21:	e8 7e 03 00 00       	call   80104ea4 <release>
80104b26:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104b29:	a1 08 e0 10 80       	mov    0x8010e008,%eax
80104b2e:	85 c0                	test   %eax,%eax
80104b30:	74 0f                	je     80104b41 <forkret+0x2e>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104b32:	c7 05 08 e0 10 80 00 	movl   $0x0,0x8010e008
80104b39:	00 00 00 
    initlog();
80104b3c:	e8 7c e7 ff ff       	call   801032bd <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80104b41:	90                   	nop
80104b42:	c9                   	leave  
80104b43:	c3                   	ret    

80104b44 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104b44:	55                   	push   %ebp
80104b45:	89 e5                	mov    %esp,%ebp
80104b47:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
80104b4a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b50:	85 c0                	test   %eax,%eax
80104b52:	75 0d                	jne    80104b61 <sleep+0x1d>
    panic("sleep");
80104b54:	83 ec 0c             	sub    $0xc,%esp
80104b57:	68 69 b7 10 80       	push   $0x8010b769
80104b5c:	e8 05 ba ff ff       	call   80100566 <panic>

  if(lk == 0)
80104b61:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104b65:	75 0d                	jne    80104b74 <sleep+0x30>
    panic("sleep without lk");
80104b67:	83 ec 0c             	sub    $0xc,%esp
80104b6a:	68 6f b7 10 80       	push   $0x8010b76f
80104b6f:	e8 f2 b9 ff ff       	call   80100566 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104b74:	81 7d 0c 80 2f 11 80 	cmpl   $0x80112f80,0xc(%ebp)
80104b7b:	74 1e                	je     80104b9b <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104b7d:	83 ec 0c             	sub    $0xc,%esp
80104b80:	68 80 2f 11 80       	push   $0x80112f80
80104b85:	e8 b3 02 00 00       	call   80104e3d <acquire>
80104b8a:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104b8d:	83 ec 0c             	sub    $0xc,%esp
80104b90:	ff 75 0c             	pushl  0xc(%ebp)
80104b93:	e8 0c 03 00 00       	call   80104ea4 <release>
80104b98:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80104b9b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ba1:	8b 55 08             	mov    0x8(%ebp),%edx
80104ba4:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104ba7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bad:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104bb4:	e8 63 fe ff ff       	call   80104a1c <sched>

  // Tidy up.
  proc->chan = 0;
80104bb9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bbf:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104bc6:	81 7d 0c 80 2f 11 80 	cmpl   $0x80112f80,0xc(%ebp)
80104bcd:	74 1e                	je     80104bed <sleep+0xa9>
    release(&ptable.lock);
80104bcf:	83 ec 0c             	sub    $0xc,%esp
80104bd2:	68 80 2f 11 80       	push   $0x80112f80
80104bd7:	e8 c8 02 00 00       	call   80104ea4 <release>
80104bdc:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104bdf:	83 ec 0c             	sub    $0xc,%esp
80104be2:	ff 75 0c             	pushl  0xc(%ebp)
80104be5:	e8 53 02 00 00       	call   80104e3d <acquire>
80104bea:	83 c4 10             	add    $0x10,%esp
  }
}
80104bed:	90                   	nop
80104bee:	c9                   	leave  
80104bef:	c3                   	ret    

80104bf0 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104bf6:	c7 45 fc b4 2f 11 80 	movl   $0x80112fb4,-0x4(%ebp)
80104bfd:	eb 24                	jmp    80104c23 <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104bff:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c02:	8b 40 0c             	mov    0xc(%eax),%eax
80104c05:	83 f8 02             	cmp    $0x2,%eax
80104c08:	75 15                	jne    80104c1f <wakeup1+0x2f>
80104c0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c0d:	8b 40 20             	mov    0x20(%eax),%eax
80104c10:	3b 45 08             	cmp    0x8(%ebp),%eax
80104c13:	75 0a                	jne    80104c1f <wakeup1+0x2f>
      p->state = RUNNABLE;
80104c15:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c18:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c1f:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
80104c23:	81 7d fc b4 4e 11 80 	cmpl   $0x80114eb4,-0x4(%ebp)
80104c2a:	72 d3                	jb     80104bff <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
80104c2c:	90                   	nop
80104c2d:	c9                   	leave  
80104c2e:	c3                   	ret    

80104c2f <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104c2f:	55                   	push   %ebp
80104c30:	89 e5                	mov    %esp,%ebp
80104c32:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104c35:	83 ec 0c             	sub    $0xc,%esp
80104c38:	68 80 2f 11 80       	push   $0x80112f80
80104c3d:	e8 fb 01 00 00       	call   80104e3d <acquire>
80104c42:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104c45:	83 ec 0c             	sub    $0xc,%esp
80104c48:	ff 75 08             	pushl  0x8(%ebp)
80104c4b:	e8 a0 ff ff ff       	call   80104bf0 <wakeup1>
80104c50:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104c53:	83 ec 0c             	sub    $0xc,%esp
80104c56:	68 80 2f 11 80       	push   $0x80112f80
80104c5b:	e8 44 02 00 00       	call   80104ea4 <release>
80104c60:	83 c4 10             	add    $0x10,%esp
}
80104c63:	90                   	nop
80104c64:	c9                   	leave  
80104c65:	c3                   	ret    

80104c66 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104c66:	55                   	push   %ebp
80104c67:	89 e5                	mov    %esp,%ebp
80104c69:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104c6c:	83 ec 0c             	sub    $0xc,%esp
80104c6f:	68 80 2f 11 80       	push   $0x80112f80
80104c74:	e8 c4 01 00 00       	call   80104e3d <acquire>
80104c79:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c7c:	c7 45 f4 b4 2f 11 80 	movl   $0x80112fb4,-0xc(%ebp)
80104c83:	eb 45                	jmp    80104cca <kill+0x64>
    if(p->pid == pid){
80104c85:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c88:	8b 40 10             	mov    0x10(%eax),%eax
80104c8b:	3b 45 08             	cmp    0x8(%ebp),%eax
80104c8e:	75 36                	jne    80104cc6 <kill+0x60>
      p->killed = 1;
80104c90:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c93:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104c9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c9d:	8b 40 0c             	mov    0xc(%eax),%eax
80104ca0:	83 f8 02             	cmp    $0x2,%eax
80104ca3:	75 0a                	jne    80104caf <kill+0x49>
        p->state = RUNNABLE;
80104ca5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ca8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104caf:	83 ec 0c             	sub    $0xc,%esp
80104cb2:	68 80 2f 11 80       	push   $0x80112f80
80104cb7:	e8 e8 01 00 00       	call   80104ea4 <release>
80104cbc:	83 c4 10             	add    $0x10,%esp
      return 0;
80104cbf:	b8 00 00 00 00       	mov    $0x0,%eax
80104cc4:	eb 22                	jmp    80104ce8 <kill+0x82>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cc6:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104cca:	81 7d f4 b4 4e 11 80 	cmpl   $0x80114eb4,-0xc(%ebp)
80104cd1:	72 b2                	jb     80104c85 <kill+0x1f>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104cd3:	83 ec 0c             	sub    $0xc,%esp
80104cd6:	68 80 2f 11 80       	push   $0x80112f80
80104cdb:	e8 c4 01 00 00       	call   80104ea4 <release>
80104ce0:	83 c4 10             	add    $0x10,%esp
  return -1;
80104ce3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ce8:	c9                   	leave  
80104ce9:	c3                   	ret    

80104cea <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104cea:	55                   	push   %ebp
80104ceb:	89 e5                	mov    %esp,%ebp
80104ced:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cf0:	c7 45 f0 b4 2f 11 80 	movl   $0x80112fb4,-0x10(%ebp)
80104cf7:	e9 d7 00 00 00       	jmp    80104dd3 <procdump+0xe9>
    if(p->state == UNUSED)
80104cfc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104cff:	8b 40 0c             	mov    0xc(%eax),%eax
80104d02:	85 c0                	test   %eax,%eax
80104d04:	0f 84 c4 00 00 00    	je     80104dce <procdump+0xe4>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104d0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d0d:	8b 40 0c             	mov    0xc(%eax),%eax
80104d10:	83 f8 05             	cmp    $0x5,%eax
80104d13:	77 23                	ja     80104d38 <procdump+0x4e>
80104d15:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d18:	8b 40 0c             	mov    0xc(%eax),%eax
80104d1b:	8b 04 85 0c e0 10 80 	mov    -0x7fef1ff4(,%eax,4),%eax
80104d22:	85 c0                	test   %eax,%eax
80104d24:	74 12                	je     80104d38 <procdump+0x4e>
      state = states[p->state];
80104d26:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d29:	8b 40 0c             	mov    0xc(%eax),%eax
80104d2c:	8b 04 85 0c e0 10 80 	mov    -0x7fef1ff4(,%eax,4),%eax
80104d33:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104d36:	eb 07                	jmp    80104d3f <procdump+0x55>
    else
      state = "???";
80104d38:	c7 45 ec 80 b7 10 80 	movl   $0x8010b780,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104d3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d42:	8d 50 6c             	lea    0x6c(%eax),%edx
80104d45:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d48:	8b 40 10             	mov    0x10(%eax),%eax
80104d4b:	52                   	push   %edx
80104d4c:	ff 75 ec             	pushl  -0x14(%ebp)
80104d4f:	50                   	push   %eax
80104d50:	68 84 b7 10 80       	push   $0x8010b784
80104d55:	e8 6c b6 ff ff       	call   801003c6 <cprintf>
80104d5a:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80104d5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d60:	8b 40 0c             	mov    0xc(%eax),%eax
80104d63:	83 f8 02             	cmp    $0x2,%eax
80104d66:	75 54                	jne    80104dbc <procdump+0xd2>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104d68:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d6b:	8b 40 1c             	mov    0x1c(%eax),%eax
80104d6e:	8b 40 0c             	mov    0xc(%eax),%eax
80104d71:	83 c0 08             	add    $0x8,%eax
80104d74:	89 c2                	mov    %eax,%edx
80104d76:	83 ec 08             	sub    $0x8,%esp
80104d79:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104d7c:	50                   	push   %eax
80104d7d:	52                   	push   %edx
80104d7e:	e8 73 01 00 00       	call   80104ef6 <getcallerpcs>
80104d83:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104d86:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104d8d:	eb 1c                	jmp    80104dab <procdump+0xc1>
        cprintf(" %p", pc[i]);
80104d8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d92:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104d96:	83 ec 08             	sub    $0x8,%esp
80104d99:	50                   	push   %eax
80104d9a:	68 8d b7 10 80       	push   $0x8010b78d
80104d9f:	e8 22 b6 ff ff       	call   801003c6 <cprintf>
80104da4:	83 c4 10             	add    $0x10,%esp
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104da7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104dab:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104daf:	7f 0b                	jg     80104dbc <procdump+0xd2>
80104db1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104db4:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104db8:	85 c0                	test   %eax,%eax
80104dba:	75 d3                	jne    80104d8f <procdump+0xa5>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104dbc:	83 ec 0c             	sub    $0xc,%esp
80104dbf:	68 91 b7 10 80       	push   $0x8010b791
80104dc4:	e8 fd b5 ff ff       	call   801003c6 <cprintf>
80104dc9:	83 c4 10             	add    $0x10,%esp
80104dcc:	eb 01                	jmp    80104dcf <procdump+0xe5>
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
80104dce:	90                   	nop
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104dcf:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104dd3:	81 7d f0 b4 4e 11 80 	cmpl   $0x80114eb4,-0x10(%ebp)
80104dda:	0f 82 1c ff ff ff    	jb     80104cfc <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104de0:	90                   	nop
80104de1:	c9                   	leave  
80104de2:	c3                   	ret    

80104de3 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104de3:	55                   	push   %ebp
80104de4:	89 e5                	mov    %esp,%ebp
80104de6:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104de9:	9c                   	pushf  
80104dea:	58                   	pop    %eax
80104deb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104dee:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104df1:	c9                   	leave  
80104df2:	c3                   	ret    

80104df3 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80104df3:	55                   	push   %ebp
80104df4:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104df6:	fa                   	cli    
}
80104df7:	90                   	nop
80104df8:	5d                   	pop    %ebp
80104df9:	c3                   	ret    

80104dfa <sti>:

static inline void
sti(void)
{
80104dfa:	55                   	push   %ebp
80104dfb:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104dfd:	fb                   	sti    
}
80104dfe:	90                   	nop
80104dff:	5d                   	pop    %ebp
80104e00:	c3                   	ret    

80104e01 <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80104e01:	55                   	push   %ebp
80104e02:	89 e5                	mov    %esp,%ebp
80104e04:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104e07:	8b 55 08             	mov    0x8(%ebp),%edx
80104e0a:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e0d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e10:	f0 87 02             	lock xchg %eax,(%edx)
80104e13:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104e16:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104e19:	c9                   	leave  
80104e1a:	c3                   	ret    

80104e1b <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104e1b:	55                   	push   %ebp
80104e1c:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104e1e:	8b 45 08             	mov    0x8(%ebp),%eax
80104e21:	8b 55 0c             	mov    0xc(%ebp),%edx
80104e24:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104e27:	8b 45 08             	mov    0x8(%ebp),%eax
80104e2a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104e30:	8b 45 08             	mov    0x8(%ebp),%eax
80104e33:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104e3a:	90                   	nop
80104e3b:	5d                   	pop    %ebp
80104e3c:	c3                   	ret    

80104e3d <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104e3d:	55                   	push   %ebp
80104e3e:	89 e5                	mov    %esp,%ebp
80104e40:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104e43:	e8 52 01 00 00       	call   80104f9a <pushcli>
  if(holding(lk))
80104e48:	8b 45 08             	mov    0x8(%ebp),%eax
80104e4b:	83 ec 0c             	sub    $0xc,%esp
80104e4e:	50                   	push   %eax
80104e4f:	e8 1c 01 00 00       	call   80104f70 <holding>
80104e54:	83 c4 10             	add    $0x10,%esp
80104e57:	85 c0                	test   %eax,%eax
80104e59:	74 0d                	je     80104e68 <acquire+0x2b>
    panic("acquire");
80104e5b:	83 ec 0c             	sub    $0xc,%esp
80104e5e:	68 bd b7 10 80       	push   $0x8010b7bd
80104e63:	e8 fe b6 ff ff       	call   80100566 <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80104e68:	90                   	nop
80104e69:	8b 45 08             	mov    0x8(%ebp),%eax
80104e6c:	83 ec 08             	sub    $0x8,%esp
80104e6f:	6a 01                	push   $0x1
80104e71:	50                   	push   %eax
80104e72:	e8 8a ff ff ff       	call   80104e01 <xchg>
80104e77:	83 c4 10             	add    $0x10,%esp
80104e7a:	85 c0                	test   %eax,%eax
80104e7c:	75 eb                	jne    80104e69 <acquire+0x2c>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104e7e:	8b 45 08             	mov    0x8(%ebp),%eax
80104e81:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104e88:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104e8b:	8b 45 08             	mov    0x8(%ebp),%eax
80104e8e:	83 c0 0c             	add    $0xc,%eax
80104e91:	83 ec 08             	sub    $0x8,%esp
80104e94:	50                   	push   %eax
80104e95:	8d 45 08             	lea    0x8(%ebp),%eax
80104e98:	50                   	push   %eax
80104e99:	e8 58 00 00 00       	call   80104ef6 <getcallerpcs>
80104e9e:	83 c4 10             	add    $0x10,%esp
}
80104ea1:	90                   	nop
80104ea2:	c9                   	leave  
80104ea3:	c3                   	ret    

80104ea4 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80104ea4:	55                   	push   %ebp
80104ea5:	89 e5                	mov    %esp,%ebp
80104ea7:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
80104eaa:	83 ec 0c             	sub    $0xc,%esp
80104ead:	ff 75 08             	pushl  0x8(%ebp)
80104eb0:	e8 bb 00 00 00       	call   80104f70 <holding>
80104eb5:	83 c4 10             	add    $0x10,%esp
80104eb8:	85 c0                	test   %eax,%eax
80104eba:	75 0d                	jne    80104ec9 <release+0x25>
    panic("release");
80104ebc:	83 ec 0c             	sub    $0xc,%esp
80104ebf:	68 c5 b7 10 80       	push   $0x8010b7c5
80104ec4:	e8 9d b6 ff ff       	call   80100566 <panic>

  lk->pcs[0] = 0;
80104ec9:	8b 45 08             	mov    0x8(%ebp),%eax
80104ecc:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104ed3:	8b 45 08             	mov    0x8(%ebp),%eax
80104ed6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80104edd:	8b 45 08             	mov    0x8(%ebp),%eax
80104ee0:	83 ec 08             	sub    $0x8,%esp
80104ee3:	6a 00                	push   $0x0
80104ee5:	50                   	push   %eax
80104ee6:	e8 16 ff ff ff       	call   80104e01 <xchg>
80104eeb:	83 c4 10             	add    $0x10,%esp

  popcli();
80104eee:	e8 ec 00 00 00       	call   80104fdf <popcli>
}
80104ef3:	90                   	nop
80104ef4:	c9                   	leave  
80104ef5:	c3                   	ret    

80104ef6 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104ef6:	55                   	push   %ebp
80104ef7:	89 e5                	mov    %esp,%ebp
80104ef9:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80104efc:	8b 45 08             	mov    0x8(%ebp),%eax
80104eff:	83 e8 08             	sub    $0x8,%eax
80104f02:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80104f05:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80104f0c:	eb 38                	jmp    80104f46 <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f0e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80104f12:	74 53                	je     80104f67 <getcallerpcs+0x71>
80104f14:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80104f1b:	76 4a                	jbe    80104f67 <getcallerpcs+0x71>
80104f1d:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80104f21:	74 44                	je     80104f67 <getcallerpcs+0x71>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104f23:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104f26:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104f2d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f30:	01 c2                	add    %eax,%edx
80104f32:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f35:	8b 40 04             	mov    0x4(%eax),%eax
80104f38:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80104f3a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f3d:	8b 00                	mov    (%eax),%eax
80104f3f:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104f42:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104f46:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104f4a:	7e c2                	jle    80104f0e <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104f4c:	eb 19                	jmp    80104f67 <getcallerpcs+0x71>
    pcs[i] = 0;
80104f4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104f51:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104f58:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f5b:	01 d0                	add    %edx,%eax
80104f5d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104f63:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104f67:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104f6b:	7e e1                	jle    80104f4e <getcallerpcs+0x58>
    pcs[i] = 0;
}
80104f6d:	90                   	nop
80104f6e:	c9                   	leave  
80104f6f:	c3                   	ret    

80104f70 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104f70:	55                   	push   %ebp
80104f71:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80104f73:	8b 45 08             	mov    0x8(%ebp),%eax
80104f76:	8b 00                	mov    (%eax),%eax
80104f78:	85 c0                	test   %eax,%eax
80104f7a:	74 17                	je     80104f93 <holding+0x23>
80104f7c:	8b 45 08             	mov    0x8(%ebp),%eax
80104f7f:	8b 50 08             	mov    0x8(%eax),%edx
80104f82:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104f88:	39 c2                	cmp    %eax,%edx
80104f8a:	75 07                	jne    80104f93 <holding+0x23>
80104f8c:	b8 01 00 00 00       	mov    $0x1,%eax
80104f91:	eb 05                	jmp    80104f98 <holding+0x28>
80104f93:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104f98:	5d                   	pop    %ebp
80104f99:	c3                   	ret    

80104f9a <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104f9a:	55                   	push   %ebp
80104f9b:	89 e5                	mov    %esp,%ebp
80104f9d:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80104fa0:	e8 3e fe ff ff       	call   80104de3 <readeflags>
80104fa5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80104fa8:	e8 46 fe ff ff       	call   80104df3 <cli>
  if(cpu->ncli++ == 0)
80104fad:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104fb4:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80104fba:	8d 48 01             	lea    0x1(%eax),%ecx
80104fbd:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
80104fc3:	85 c0                	test   %eax,%eax
80104fc5:	75 15                	jne    80104fdc <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
80104fc7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104fcd:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104fd0:	81 e2 00 02 00 00    	and    $0x200,%edx
80104fd6:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104fdc:	90                   	nop
80104fdd:	c9                   	leave  
80104fde:	c3                   	ret    

80104fdf <popcli>:

void
popcli(void)
{
80104fdf:	55                   	push   %ebp
80104fe0:	89 e5                	mov    %esp,%ebp
80104fe2:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
80104fe5:	e8 f9 fd ff ff       	call   80104de3 <readeflags>
80104fea:	25 00 02 00 00       	and    $0x200,%eax
80104fef:	85 c0                	test   %eax,%eax
80104ff1:	74 0d                	je     80105000 <popcli+0x21>
    panic("popcli - interruptible");
80104ff3:	83 ec 0c             	sub    $0xc,%esp
80104ff6:	68 cd b7 10 80       	push   $0x8010b7cd
80104ffb:	e8 66 b5 ff ff       	call   80100566 <panic>
  if(--cpu->ncli < 0)
80105000:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105006:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
8010500c:	83 ea 01             	sub    $0x1,%edx
8010500f:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80105015:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010501b:	85 c0                	test   %eax,%eax
8010501d:	79 0d                	jns    8010502c <popcli+0x4d>
    panic("popcli");
8010501f:	83 ec 0c             	sub    $0xc,%esp
80105022:	68 e4 b7 10 80       	push   $0x8010b7e4
80105027:	e8 3a b5 ff ff       	call   80100566 <panic>
  if(cpu->ncli == 0 && cpu->intena)
8010502c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105032:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105038:	85 c0                	test   %eax,%eax
8010503a:	75 15                	jne    80105051 <popcli+0x72>
8010503c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105042:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80105048:	85 c0                	test   %eax,%eax
8010504a:	74 05                	je     80105051 <popcli+0x72>
    sti();
8010504c:	e8 a9 fd ff ff       	call   80104dfa <sti>
}
80105051:	90                   	nop
80105052:	c9                   	leave  
80105053:	c3                   	ret    

80105054 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
80105054:	55                   	push   %ebp
80105055:	89 e5                	mov    %esp,%ebp
80105057:	57                   	push   %edi
80105058:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80105059:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010505c:	8b 55 10             	mov    0x10(%ebp),%edx
8010505f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105062:	89 cb                	mov    %ecx,%ebx
80105064:	89 df                	mov    %ebx,%edi
80105066:	89 d1                	mov    %edx,%ecx
80105068:	fc                   	cld    
80105069:	f3 aa                	rep stos %al,%es:(%edi)
8010506b:	89 ca                	mov    %ecx,%edx
8010506d:	89 fb                	mov    %edi,%ebx
8010506f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105072:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105075:	90                   	nop
80105076:	5b                   	pop    %ebx
80105077:	5f                   	pop    %edi
80105078:	5d                   	pop    %ebp
80105079:	c3                   	ret    

8010507a <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
8010507a:	55                   	push   %ebp
8010507b:	89 e5                	mov    %esp,%ebp
8010507d:	57                   	push   %edi
8010507e:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
8010507f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105082:	8b 55 10             	mov    0x10(%ebp),%edx
80105085:	8b 45 0c             	mov    0xc(%ebp),%eax
80105088:	89 cb                	mov    %ecx,%ebx
8010508a:	89 df                	mov    %ebx,%edi
8010508c:	89 d1                	mov    %edx,%ecx
8010508e:	fc                   	cld    
8010508f:	f3 ab                	rep stos %eax,%es:(%edi)
80105091:	89 ca                	mov    %ecx,%edx
80105093:	89 fb                	mov    %edi,%ebx
80105095:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105098:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
8010509b:	90                   	nop
8010509c:	5b                   	pop    %ebx
8010509d:	5f                   	pop    %edi
8010509e:	5d                   	pop    %ebp
8010509f:	c3                   	ret    

801050a0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
801050a3:	8b 45 08             	mov    0x8(%ebp),%eax
801050a6:	83 e0 03             	and    $0x3,%eax
801050a9:	85 c0                	test   %eax,%eax
801050ab:	75 43                	jne    801050f0 <memset+0x50>
801050ad:	8b 45 10             	mov    0x10(%ebp),%eax
801050b0:	83 e0 03             	and    $0x3,%eax
801050b3:	85 c0                	test   %eax,%eax
801050b5:	75 39                	jne    801050f0 <memset+0x50>
    c &= 0xFF;
801050b7:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801050be:	8b 45 10             	mov    0x10(%ebp),%eax
801050c1:	c1 e8 02             	shr    $0x2,%eax
801050c4:	89 c1                	mov    %eax,%ecx
801050c6:	8b 45 0c             	mov    0xc(%ebp),%eax
801050c9:	c1 e0 18             	shl    $0x18,%eax
801050cc:	89 c2                	mov    %eax,%edx
801050ce:	8b 45 0c             	mov    0xc(%ebp),%eax
801050d1:	c1 e0 10             	shl    $0x10,%eax
801050d4:	09 c2                	or     %eax,%edx
801050d6:	8b 45 0c             	mov    0xc(%ebp),%eax
801050d9:	c1 e0 08             	shl    $0x8,%eax
801050dc:	09 d0                	or     %edx,%eax
801050de:	0b 45 0c             	or     0xc(%ebp),%eax
801050e1:	51                   	push   %ecx
801050e2:	50                   	push   %eax
801050e3:	ff 75 08             	pushl  0x8(%ebp)
801050e6:	e8 8f ff ff ff       	call   8010507a <stosl>
801050eb:	83 c4 0c             	add    $0xc,%esp
801050ee:	eb 12                	jmp    80105102 <memset+0x62>
  } else
    stosb(dst, c, n);
801050f0:	8b 45 10             	mov    0x10(%ebp),%eax
801050f3:	50                   	push   %eax
801050f4:	ff 75 0c             	pushl  0xc(%ebp)
801050f7:	ff 75 08             	pushl  0x8(%ebp)
801050fa:	e8 55 ff ff ff       	call   80105054 <stosb>
801050ff:	83 c4 0c             	add    $0xc,%esp
  return dst;
80105102:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105105:	c9                   	leave  
80105106:	c3                   	ret    

80105107 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105107:	55                   	push   %ebp
80105108:	89 e5                	mov    %esp,%ebp
8010510a:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
8010510d:	8b 45 08             	mov    0x8(%ebp),%eax
80105110:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
80105113:	8b 45 0c             	mov    0xc(%ebp),%eax
80105116:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
80105119:	eb 30                	jmp    8010514b <memcmp+0x44>
    if(*s1 != *s2)
8010511b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010511e:	0f b6 10             	movzbl (%eax),%edx
80105121:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105124:	0f b6 00             	movzbl (%eax),%eax
80105127:	38 c2                	cmp    %al,%dl
80105129:	74 18                	je     80105143 <memcmp+0x3c>
      return *s1 - *s2;
8010512b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010512e:	0f b6 00             	movzbl (%eax),%eax
80105131:	0f b6 d0             	movzbl %al,%edx
80105134:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105137:	0f b6 00             	movzbl (%eax),%eax
8010513a:	0f b6 c0             	movzbl %al,%eax
8010513d:	29 c2                	sub    %eax,%edx
8010513f:	89 d0                	mov    %edx,%eax
80105141:	eb 1a                	jmp    8010515d <memcmp+0x56>
    s1++, s2++;
80105143:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105147:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010514b:	8b 45 10             	mov    0x10(%ebp),%eax
8010514e:	8d 50 ff             	lea    -0x1(%eax),%edx
80105151:	89 55 10             	mov    %edx,0x10(%ebp)
80105154:	85 c0                	test   %eax,%eax
80105156:	75 c3                	jne    8010511b <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80105158:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010515d:	c9                   	leave  
8010515e:	c3                   	ret    

8010515f <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
8010515f:	55                   	push   %ebp
80105160:	89 e5                	mov    %esp,%ebp
80105162:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
80105165:	8b 45 0c             	mov    0xc(%ebp),%eax
80105168:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
8010516b:	8b 45 08             	mov    0x8(%ebp),%eax
8010516e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80105171:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105174:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105177:	73 54                	jae    801051cd <memmove+0x6e>
80105179:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010517c:	8b 45 10             	mov    0x10(%ebp),%eax
8010517f:	01 d0                	add    %edx,%eax
80105181:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105184:	76 47                	jbe    801051cd <memmove+0x6e>
    s += n;
80105186:	8b 45 10             	mov    0x10(%ebp),%eax
80105189:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
8010518c:	8b 45 10             	mov    0x10(%ebp),%eax
8010518f:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
80105192:	eb 13                	jmp    801051a7 <memmove+0x48>
      *--d = *--s;
80105194:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80105198:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
8010519c:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010519f:	0f b6 10             	movzbl (%eax),%edx
801051a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051a5:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801051a7:	8b 45 10             	mov    0x10(%ebp),%eax
801051aa:	8d 50 ff             	lea    -0x1(%eax),%edx
801051ad:	89 55 10             	mov    %edx,0x10(%ebp)
801051b0:	85 c0                	test   %eax,%eax
801051b2:	75 e0                	jne    80105194 <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801051b4:	eb 24                	jmp    801051da <memmove+0x7b>
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;
801051b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051b9:	8d 50 01             	lea    0x1(%eax),%edx
801051bc:	89 55 f8             	mov    %edx,-0x8(%ebp)
801051bf:	8b 55 fc             	mov    -0x4(%ebp),%edx
801051c2:	8d 4a 01             	lea    0x1(%edx),%ecx
801051c5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
801051c8:	0f b6 12             	movzbl (%edx),%edx
801051cb:	88 10                	mov    %dl,(%eax)
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801051cd:	8b 45 10             	mov    0x10(%ebp),%eax
801051d0:	8d 50 ff             	lea    -0x1(%eax),%edx
801051d3:	89 55 10             	mov    %edx,0x10(%ebp)
801051d6:	85 c0                	test   %eax,%eax
801051d8:	75 dc                	jne    801051b6 <memmove+0x57>
      *d++ = *s++;

  return dst;
801051da:	8b 45 08             	mov    0x8(%ebp),%eax
}
801051dd:	c9                   	leave  
801051de:	c3                   	ret    

801051df <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801051df:	55                   	push   %ebp
801051e0:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
801051e2:	ff 75 10             	pushl  0x10(%ebp)
801051e5:	ff 75 0c             	pushl  0xc(%ebp)
801051e8:	ff 75 08             	pushl  0x8(%ebp)
801051eb:	e8 6f ff ff ff       	call   8010515f <memmove>
801051f0:	83 c4 0c             	add    $0xc,%esp
}
801051f3:	c9                   	leave  
801051f4:	c3                   	ret    

801051f5 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801051f5:	55                   	push   %ebp
801051f6:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
801051f8:	eb 0c                	jmp    80105206 <strncmp+0x11>
    n--, p++, q++;
801051fa:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801051fe:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105202:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80105206:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010520a:	74 1a                	je     80105226 <strncmp+0x31>
8010520c:	8b 45 08             	mov    0x8(%ebp),%eax
8010520f:	0f b6 00             	movzbl (%eax),%eax
80105212:	84 c0                	test   %al,%al
80105214:	74 10                	je     80105226 <strncmp+0x31>
80105216:	8b 45 08             	mov    0x8(%ebp),%eax
80105219:	0f b6 10             	movzbl (%eax),%edx
8010521c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010521f:	0f b6 00             	movzbl (%eax),%eax
80105222:	38 c2                	cmp    %al,%dl
80105224:	74 d4                	je     801051fa <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
80105226:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010522a:	75 07                	jne    80105233 <strncmp+0x3e>
    return 0;
8010522c:	b8 00 00 00 00       	mov    $0x0,%eax
80105231:	eb 16                	jmp    80105249 <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
80105233:	8b 45 08             	mov    0x8(%ebp),%eax
80105236:	0f b6 00             	movzbl (%eax),%eax
80105239:	0f b6 d0             	movzbl %al,%edx
8010523c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010523f:	0f b6 00             	movzbl (%eax),%eax
80105242:	0f b6 c0             	movzbl %al,%eax
80105245:	29 c2                	sub    %eax,%edx
80105247:	89 d0                	mov    %edx,%eax
}
80105249:	5d                   	pop    %ebp
8010524a:	c3                   	ret    

8010524b <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
8010524b:	55                   	push   %ebp
8010524c:	89 e5                	mov    %esp,%ebp
8010524e:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105251:	8b 45 08             	mov    0x8(%ebp),%eax
80105254:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
80105257:	90                   	nop
80105258:	8b 45 10             	mov    0x10(%ebp),%eax
8010525b:	8d 50 ff             	lea    -0x1(%eax),%edx
8010525e:	89 55 10             	mov    %edx,0x10(%ebp)
80105261:	85 c0                	test   %eax,%eax
80105263:	7e 2c                	jle    80105291 <strncpy+0x46>
80105265:	8b 45 08             	mov    0x8(%ebp),%eax
80105268:	8d 50 01             	lea    0x1(%eax),%edx
8010526b:	89 55 08             	mov    %edx,0x8(%ebp)
8010526e:	8b 55 0c             	mov    0xc(%ebp),%edx
80105271:	8d 4a 01             	lea    0x1(%edx),%ecx
80105274:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80105277:	0f b6 12             	movzbl (%edx),%edx
8010527a:	88 10                	mov    %dl,(%eax)
8010527c:	0f b6 00             	movzbl (%eax),%eax
8010527f:	84 c0                	test   %al,%al
80105281:	75 d5                	jne    80105258 <strncpy+0xd>
    ;
  while(n-- > 0)
80105283:	eb 0c                	jmp    80105291 <strncpy+0x46>
    *s++ = 0;
80105285:	8b 45 08             	mov    0x8(%ebp),%eax
80105288:	8d 50 01             	lea    0x1(%eax),%edx
8010528b:	89 55 08             	mov    %edx,0x8(%ebp)
8010528e:	c6 00 00             	movb   $0x0,(%eax)
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80105291:	8b 45 10             	mov    0x10(%ebp),%eax
80105294:	8d 50 ff             	lea    -0x1(%eax),%edx
80105297:	89 55 10             	mov    %edx,0x10(%ebp)
8010529a:	85 c0                	test   %eax,%eax
8010529c:	7f e7                	jg     80105285 <strncpy+0x3a>
    *s++ = 0;
  return os;
8010529e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801052a1:	c9                   	leave  
801052a2:	c3                   	ret    

801052a3 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801052a3:	55                   	push   %ebp
801052a4:	89 e5                	mov    %esp,%ebp
801052a6:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
801052a9:	8b 45 08             	mov    0x8(%ebp),%eax
801052ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
801052af:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801052b3:	7f 05                	jg     801052ba <safestrcpy+0x17>
    return os;
801052b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052b8:	eb 31                	jmp    801052eb <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
801052ba:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801052be:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801052c2:	7e 1e                	jle    801052e2 <safestrcpy+0x3f>
801052c4:	8b 45 08             	mov    0x8(%ebp),%eax
801052c7:	8d 50 01             	lea    0x1(%eax),%edx
801052ca:	89 55 08             	mov    %edx,0x8(%ebp)
801052cd:	8b 55 0c             	mov    0xc(%ebp),%edx
801052d0:	8d 4a 01             	lea    0x1(%edx),%ecx
801052d3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
801052d6:	0f b6 12             	movzbl (%edx),%edx
801052d9:	88 10                	mov    %dl,(%eax)
801052db:	0f b6 00             	movzbl (%eax),%eax
801052de:	84 c0                	test   %al,%al
801052e0:	75 d8                	jne    801052ba <safestrcpy+0x17>
    ;
  *s = 0;
801052e2:	8b 45 08             	mov    0x8(%ebp),%eax
801052e5:	c6 00 00             	movb   $0x0,(%eax)
  return os;
801052e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801052eb:	c9                   	leave  
801052ec:	c3                   	ret    

801052ed <strlen>:

int
strlen(const char *s)
{
801052ed:	55                   	push   %ebp
801052ee:	89 e5                	mov    %esp,%ebp
801052f0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
801052f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801052fa:	eb 04                	jmp    80105300 <strlen+0x13>
801052fc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105300:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105303:	8b 45 08             	mov    0x8(%ebp),%eax
80105306:	01 d0                	add    %edx,%eax
80105308:	0f b6 00             	movzbl (%eax),%eax
8010530b:	84 c0                	test   %al,%al
8010530d:	75 ed                	jne    801052fc <strlen+0xf>
    ;
  return n;
8010530f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105312:	c9                   	leave  
80105313:	c3                   	ret    

80105314 <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105314:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105318:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
8010531c:	55                   	push   %ebp
  pushl %ebx
8010531d:	53                   	push   %ebx
  pushl %esi
8010531e:	56                   	push   %esi
  pushl %edi
8010531f:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105320:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105322:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80105324:	5f                   	pop    %edi
  popl %esi
80105325:	5e                   	pop    %esi
  popl %ebx
80105326:	5b                   	pop    %ebx
  popl %ebp
80105327:	5d                   	pop    %ebp
  ret
80105328:	c3                   	ret    

80105329 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105329:	55                   	push   %ebp
8010532a:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
8010532c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105332:	8b 00                	mov    (%eax),%eax
80105334:	3b 45 08             	cmp    0x8(%ebp),%eax
80105337:	76 12                	jbe    8010534b <fetchint+0x22>
80105339:	8b 45 08             	mov    0x8(%ebp),%eax
8010533c:	8d 50 04             	lea    0x4(%eax),%edx
8010533f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105345:	8b 00                	mov    (%eax),%eax
80105347:	39 c2                	cmp    %eax,%edx
80105349:	76 07                	jbe    80105352 <fetchint+0x29>
    return -1;
8010534b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105350:	eb 0f                	jmp    80105361 <fetchint+0x38>
  *ip = *(int*)(addr);
80105352:	8b 45 08             	mov    0x8(%ebp),%eax
80105355:	8b 10                	mov    (%eax),%edx
80105357:	8b 45 0c             	mov    0xc(%ebp),%eax
8010535a:	89 10                	mov    %edx,(%eax)
  return 0;
8010535c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105361:	5d                   	pop    %ebp
80105362:	c3                   	ret    

80105363 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105363:	55                   	push   %ebp
80105364:	89 e5                	mov    %esp,%ebp
80105366:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
80105369:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010536f:	8b 00                	mov    (%eax),%eax
80105371:	3b 45 08             	cmp    0x8(%ebp),%eax
80105374:	77 07                	ja     8010537d <fetchstr+0x1a>
    return -1;
80105376:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010537b:	eb 46                	jmp    801053c3 <fetchstr+0x60>
  *pp = (char*)addr;
8010537d:	8b 55 08             	mov    0x8(%ebp),%edx
80105380:	8b 45 0c             	mov    0xc(%ebp),%eax
80105383:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
80105385:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010538b:	8b 00                	mov    (%eax),%eax
8010538d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
80105390:	8b 45 0c             	mov    0xc(%ebp),%eax
80105393:	8b 00                	mov    (%eax),%eax
80105395:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105398:	eb 1c                	jmp    801053b6 <fetchstr+0x53>
    if(*s == 0)
8010539a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010539d:	0f b6 00             	movzbl (%eax),%eax
801053a0:	84 c0                	test   %al,%al
801053a2:	75 0e                	jne    801053b2 <fetchstr+0x4f>
      return s - *pp;
801053a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
801053a7:	8b 45 0c             	mov    0xc(%ebp),%eax
801053aa:	8b 00                	mov    (%eax),%eax
801053ac:	29 c2                	sub    %eax,%edx
801053ae:	89 d0                	mov    %edx,%eax
801053b0:	eb 11                	jmp    801053c3 <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801053b2:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801053b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053b9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801053bc:	72 dc                	jb     8010539a <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
801053be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053c3:	c9                   	leave  
801053c4:	c3                   	ret    

801053c5 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801053c5:	55                   	push   %ebp
801053c6:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801053c8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053ce:	8b 40 18             	mov    0x18(%eax),%eax
801053d1:	8b 40 44             	mov    0x44(%eax),%eax
801053d4:	8b 55 08             	mov    0x8(%ebp),%edx
801053d7:	c1 e2 02             	shl    $0x2,%edx
801053da:	01 d0                	add    %edx,%eax
801053dc:	83 c0 04             	add    $0x4,%eax
801053df:	ff 75 0c             	pushl  0xc(%ebp)
801053e2:	50                   	push   %eax
801053e3:	e8 41 ff ff ff       	call   80105329 <fetchint>
801053e8:	83 c4 08             	add    $0x8,%esp
}
801053eb:	c9                   	leave  
801053ec:	c3                   	ret    

801053ed <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801053ed:	55                   	push   %ebp
801053ee:	89 e5                	mov    %esp,%ebp
801053f0:	83 ec 10             	sub    $0x10,%esp
  int i;
  
  if(argint(n, &i) < 0)
801053f3:	8d 45 fc             	lea    -0x4(%ebp),%eax
801053f6:	50                   	push   %eax
801053f7:	ff 75 08             	pushl  0x8(%ebp)
801053fa:	e8 c6 ff ff ff       	call   801053c5 <argint>
801053ff:	83 c4 08             	add    $0x8,%esp
80105402:	85 c0                	test   %eax,%eax
80105404:	79 07                	jns    8010540d <argptr+0x20>
    return -1;
80105406:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010540b:	eb 3b                	jmp    80105448 <argptr+0x5b>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
8010540d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105413:	8b 00                	mov    (%eax),%eax
80105415:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105418:	39 d0                	cmp    %edx,%eax
8010541a:	76 16                	jbe    80105432 <argptr+0x45>
8010541c:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010541f:	89 c2                	mov    %eax,%edx
80105421:	8b 45 10             	mov    0x10(%ebp),%eax
80105424:	01 c2                	add    %eax,%edx
80105426:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010542c:	8b 00                	mov    (%eax),%eax
8010542e:	39 c2                	cmp    %eax,%edx
80105430:	76 07                	jbe    80105439 <argptr+0x4c>
    return -1;
80105432:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105437:	eb 0f                	jmp    80105448 <argptr+0x5b>
  *pp = (char*)i;
80105439:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010543c:	89 c2                	mov    %eax,%edx
8010543e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105441:	89 10                	mov    %edx,(%eax)
  return 0;
80105443:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105448:	c9                   	leave  
80105449:	c3                   	ret    

8010544a <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
8010544a:	55                   	push   %ebp
8010544b:	89 e5                	mov    %esp,%ebp
8010544d:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105450:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105453:	50                   	push   %eax
80105454:	ff 75 08             	pushl  0x8(%ebp)
80105457:	e8 69 ff ff ff       	call   801053c5 <argint>
8010545c:	83 c4 08             	add    $0x8,%esp
8010545f:	85 c0                	test   %eax,%eax
80105461:	79 07                	jns    8010546a <argstr+0x20>
    return -1;
80105463:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105468:	eb 0f                	jmp    80105479 <argstr+0x2f>
  return fetchstr(addr, pp);
8010546a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010546d:	ff 75 0c             	pushl  0xc(%ebp)
80105470:	50                   	push   %eax
80105471:	e8 ed fe ff ff       	call   80105363 <fetchstr>
80105476:	83 c4 08             	add    $0x8,%esp
}
80105479:	c9                   	leave  
8010547a:	c3                   	ret    

8010547b <syscall>:
    
};

void
syscall(void)
{
8010547b:	55                   	push   %ebp
8010547c:	89 e5                	mov    %esp,%ebp
8010547e:	53                   	push   %ebx
8010547f:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
80105482:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105488:	8b 40 18             	mov    0x18(%eax),%eax
8010548b:	8b 40 1c             	mov    0x1c(%eax),%eax
8010548e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105491:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105495:	7e 30                	jle    801054c7 <syscall+0x4c>
80105497:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010549a:	83 f8 1c             	cmp    $0x1c,%eax
8010549d:	77 28                	ja     801054c7 <syscall+0x4c>
8010549f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054a2:	8b 04 85 40 e0 10 80 	mov    -0x7fef1fc0(,%eax,4),%eax
801054a9:	85 c0                	test   %eax,%eax
801054ab:	74 1a                	je     801054c7 <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
801054ad:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054b3:	8b 58 18             	mov    0x18(%eax),%ebx
801054b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054b9:	8b 04 85 40 e0 10 80 	mov    -0x7fef1fc0(,%eax,4),%eax
801054c0:	ff d0                	call   *%eax
801054c2:	89 43 1c             	mov    %eax,0x1c(%ebx)
801054c5:	eb 34                	jmp    801054fb <syscall+0x80>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
801054c7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054cd:	8d 50 6c             	lea    0x6c(%eax),%edx
801054d0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801054d6:	8b 40 10             	mov    0x10(%eax),%eax
801054d9:	ff 75 f4             	pushl  -0xc(%ebp)
801054dc:	52                   	push   %edx
801054dd:	50                   	push   %eax
801054de:	68 eb b7 10 80       	push   $0x8010b7eb
801054e3:	e8 de ae ff ff       	call   801003c6 <cprintf>
801054e8:	83 c4 10             	add    $0x10,%esp
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
801054eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054f1:	8b 40 18             	mov    0x18(%eax),%eax
801054f4:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801054fb:	90                   	nop
801054fc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801054ff:	c9                   	leave  
80105500:	c3                   	ret    

80105501 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80105501:	55                   	push   %ebp
80105502:	89 e5                	mov    %esp,%ebp
80105504:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80105507:	83 ec 08             	sub    $0x8,%esp
8010550a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010550d:	50                   	push   %eax
8010550e:	ff 75 08             	pushl  0x8(%ebp)
80105511:	e8 af fe ff ff       	call   801053c5 <argint>
80105516:	83 c4 10             	add    $0x10,%esp
80105519:	85 c0                	test   %eax,%eax
8010551b:	79 07                	jns    80105524 <argfd+0x23>
    return -1;
8010551d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105522:	eb 50                	jmp    80105574 <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80105524:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105527:	85 c0                	test   %eax,%eax
80105529:	78 21                	js     8010554c <argfd+0x4b>
8010552b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010552e:	83 f8 0f             	cmp    $0xf,%eax
80105531:	7f 19                	jg     8010554c <argfd+0x4b>
80105533:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105539:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010553c:	83 c2 08             	add    $0x8,%edx
8010553f:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105543:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105546:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010554a:	75 07                	jne    80105553 <argfd+0x52>
    return -1;
8010554c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105551:	eb 21                	jmp    80105574 <argfd+0x73>
  if(pfd)
80105553:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105557:	74 08                	je     80105561 <argfd+0x60>
    *pfd = fd;
80105559:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010555c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010555f:	89 10                	mov    %edx,(%eax)
  if(pf)
80105561:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105565:	74 08                	je     8010556f <argfd+0x6e>
    *pf = f;
80105567:	8b 45 10             	mov    0x10(%ebp),%eax
8010556a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010556d:	89 10                	mov    %edx,(%eax)
  return 0;
8010556f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105574:	c9                   	leave  
80105575:	c3                   	ret    

80105576 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80105576:	55                   	push   %ebp
80105577:	89 e5                	mov    %esp,%ebp
80105579:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
8010557c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105583:	eb 30                	jmp    801055b5 <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
80105585:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010558b:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010558e:	83 c2 08             	add    $0x8,%edx
80105591:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105595:	85 c0                	test   %eax,%eax
80105597:	75 18                	jne    801055b1 <fdalloc+0x3b>
      proc->ofile[fd] = f;
80105599:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010559f:	8b 55 fc             	mov    -0x4(%ebp),%edx
801055a2:	8d 4a 08             	lea    0x8(%edx),%ecx
801055a5:	8b 55 08             	mov    0x8(%ebp),%edx
801055a8:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
801055ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055af:	eb 0f                	jmp    801055c0 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801055b1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801055b5:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
801055b9:	7e ca                	jle    80105585 <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
801055bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055c0:	c9                   	leave  
801055c1:	c3                   	ret    

801055c2 <sys_dup>:

int
sys_dup(void)
{
801055c2:	55                   	push   %ebp
801055c3:	89 e5                	mov    %esp,%ebp
801055c5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
801055c8:	83 ec 04             	sub    $0x4,%esp
801055cb:	8d 45 f0             	lea    -0x10(%ebp),%eax
801055ce:	50                   	push   %eax
801055cf:	6a 00                	push   $0x0
801055d1:	6a 00                	push   $0x0
801055d3:	e8 29 ff ff ff       	call   80105501 <argfd>
801055d8:	83 c4 10             	add    $0x10,%esp
801055db:	85 c0                	test   %eax,%eax
801055dd:	79 07                	jns    801055e6 <sys_dup+0x24>
    return -1;
801055df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055e4:	eb 31                	jmp    80105617 <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
801055e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801055e9:	83 ec 0c             	sub    $0xc,%esp
801055ec:	50                   	push   %eax
801055ed:	e8 84 ff ff ff       	call   80105576 <fdalloc>
801055f2:	83 c4 10             	add    $0x10,%esp
801055f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801055f8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801055fc:	79 07                	jns    80105605 <sys_dup+0x43>
    return -1;
801055fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105603:	eb 12                	jmp    80105617 <sys_dup+0x55>
  filedup(f);
80105605:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105608:	83 ec 0c             	sub    $0xc,%esp
8010560b:	50                   	push   %eax
8010560c:	e8 c0 b9 ff ff       	call   80100fd1 <filedup>
80105611:	83 c4 10             	add    $0x10,%esp
  return fd;
80105614:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105617:	c9                   	leave  
80105618:	c3                   	ret    

80105619 <sys_read>:

int
sys_read(void)
{
80105619:	55                   	push   %ebp
8010561a:	89 e5                	mov    %esp,%ebp
8010561c:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010561f:	83 ec 04             	sub    $0x4,%esp
80105622:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105625:	50                   	push   %eax
80105626:	6a 00                	push   $0x0
80105628:	6a 00                	push   $0x0
8010562a:	e8 d2 fe ff ff       	call   80105501 <argfd>
8010562f:	83 c4 10             	add    $0x10,%esp
80105632:	85 c0                	test   %eax,%eax
80105634:	78 2e                	js     80105664 <sys_read+0x4b>
80105636:	83 ec 08             	sub    $0x8,%esp
80105639:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010563c:	50                   	push   %eax
8010563d:	6a 02                	push   $0x2
8010563f:	e8 81 fd ff ff       	call   801053c5 <argint>
80105644:	83 c4 10             	add    $0x10,%esp
80105647:	85 c0                	test   %eax,%eax
80105649:	78 19                	js     80105664 <sys_read+0x4b>
8010564b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010564e:	83 ec 04             	sub    $0x4,%esp
80105651:	50                   	push   %eax
80105652:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105655:	50                   	push   %eax
80105656:	6a 01                	push   $0x1
80105658:	e8 90 fd ff ff       	call   801053ed <argptr>
8010565d:	83 c4 10             	add    $0x10,%esp
80105660:	85 c0                	test   %eax,%eax
80105662:	79 07                	jns    8010566b <sys_read+0x52>
    return -1;
80105664:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105669:	eb 17                	jmp    80105682 <sys_read+0x69>
  return fileread(f, p, n);
8010566b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010566e:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105671:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105674:	83 ec 04             	sub    $0x4,%esp
80105677:	51                   	push   %ecx
80105678:	52                   	push   %edx
80105679:	50                   	push   %eax
8010567a:	e8 e2 ba ff ff       	call   80101161 <fileread>
8010567f:	83 c4 10             	add    $0x10,%esp
}
80105682:	c9                   	leave  
80105683:	c3                   	ret    

80105684 <sys_write>:

int
sys_write(void)
{
80105684:	55                   	push   %ebp
80105685:	89 e5                	mov    %esp,%ebp
80105687:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010568a:	83 ec 04             	sub    $0x4,%esp
8010568d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105690:	50                   	push   %eax
80105691:	6a 00                	push   $0x0
80105693:	6a 00                	push   $0x0
80105695:	e8 67 fe ff ff       	call   80105501 <argfd>
8010569a:	83 c4 10             	add    $0x10,%esp
8010569d:	85 c0                	test   %eax,%eax
8010569f:	78 2e                	js     801056cf <sys_write+0x4b>
801056a1:	83 ec 08             	sub    $0x8,%esp
801056a4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056a7:	50                   	push   %eax
801056a8:	6a 02                	push   $0x2
801056aa:	e8 16 fd ff ff       	call   801053c5 <argint>
801056af:	83 c4 10             	add    $0x10,%esp
801056b2:	85 c0                	test   %eax,%eax
801056b4:	78 19                	js     801056cf <sys_write+0x4b>
801056b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801056b9:	83 ec 04             	sub    $0x4,%esp
801056bc:	50                   	push   %eax
801056bd:	8d 45 ec             	lea    -0x14(%ebp),%eax
801056c0:	50                   	push   %eax
801056c1:	6a 01                	push   $0x1
801056c3:	e8 25 fd ff ff       	call   801053ed <argptr>
801056c8:	83 c4 10             	add    $0x10,%esp
801056cb:	85 c0                	test   %eax,%eax
801056cd:	79 07                	jns    801056d6 <sys_write+0x52>
    return -1;
801056cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056d4:	eb 17                	jmp    801056ed <sys_write+0x69>
  return filewrite(f, p, n);
801056d6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801056d9:	8b 55 ec             	mov    -0x14(%ebp),%edx
801056dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056df:	83 ec 04             	sub    $0x4,%esp
801056e2:	51                   	push   %ecx
801056e3:	52                   	push   %edx
801056e4:	50                   	push   %eax
801056e5:	e8 2f bb ff ff       	call   80101219 <filewrite>
801056ea:	83 c4 10             	add    $0x10,%esp
}
801056ed:	c9                   	leave  
801056ee:	c3                   	ret    

801056ef <sys_close>:

int
sys_close(void)
{
801056ef:	55                   	push   %ebp
801056f0:	89 e5                	mov    %esp,%ebp
801056f2:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
801056f5:	83 ec 04             	sub    $0x4,%esp
801056f8:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056fb:	50                   	push   %eax
801056fc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056ff:	50                   	push   %eax
80105700:	6a 00                	push   $0x0
80105702:	e8 fa fd ff ff       	call   80105501 <argfd>
80105707:	83 c4 10             	add    $0x10,%esp
8010570a:	85 c0                	test   %eax,%eax
8010570c:	79 07                	jns    80105715 <sys_close+0x26>
    return -1;
8010570e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105713:	eb 28                	jmp    8010573d <sys_close+0x4e>
  proc->ofile[fd] = 0;
80105715:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010571b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010571e:	83 c2 08             	add    $0x8,%edx
80105721:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105728:	00 
  fileclose(f);
80105729:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010572c:	83 ec 0c             	sub    $0xc,%esp
8010572f:	50                   	push   %eax
80105730:	e8 ed b8 ff ff       	call   80101022 <fileclose>
80105735:	83 c4 10             	add    $0x10,%esp
  return 0;
80105738:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010573d:	c9                   	leave  
8010573e:	c3                   	ret    

8010573f <sys_fstat>:

int
sys_fstat(void)
{
8010573f:	55                   	push   %ebp
80105740:	89 e5                	mov    %esp,%ebp
80105742:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105745:	83 ec 04             	sub    $0x4,%esp
80105748:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010574b:	50                   	push   %eax
8010574c:	6a 00                	push   $0x0
8010574e:	6a 00                	push   $0x0
80105750:	e8 ac fd ff ff       	call   80105501 <argfd>
80105755:	83 c4 10             	add    $0x10,%esp
80105758:	85 c0                	test   %eax,%eax
8010575a:	78 17                	js     80105773 <sys_fstat+0x34>
8010575c:	83 ec 04             	sub    $0x4,%esp
8010575f:	6a 14                	push   $0x14
80105761:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105764:	50                   	push   %eax
80105765:	6a 01                	push   $0x1
80105767:	e8 81 fc ff ff       	call   801053ed <argptr>
8010576c:	83 c4 10             	add    $0x10,%esp
8010576f:	85 c0                	test   %eax,%eax
80105771:	79 07                	jns    8010577a <sys_fstat+0x3b>
    return -1;
80105773:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105778:	eb 13                	jmp    8010578d <sys_fstat+0x4e>
  return filestat(f, st);
8010577a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010577d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105780:	83 ec 08             	sub    $0x8,%esp
80105783:	52                   	push   %edx
80105784:	50                   	push   %eax
80105785:	e8 80 b9 ff ff       	call   8010110a <filestat>
8010578a:	83 c4 10             	add    $0x10,%esp
}
8010578d:	c9                   	leave  
8010578e:	c3                   	ret    

8010578f <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
8010578f:	55                   	push   %ebp
80105790:	89 e5                	mov    %esp,%ebp
80105792:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105795:	83 ec 08             	sub    $0x8,%esp
80105798:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010579b:	50                   	push   %eax
8010579c:	6a 00                	push   $0x0
8010579e:	e8 a7 fc ff ff       	call   8010544a <argstr>
801057a3:	83 c4 10             	add    $0x10,%esp
801057a6:	85 c0                	test   %eax,%eax
801057a8:	78 15                	js     801057bf <sys_link+0x30>
801057aa:	83 ec 08             	sub    $0x8,%esp
801057ad:	8d 45 dc             	lea    -0x24(%ebp),%eax
801057b0:	50                   	push   %eax
801057b1:	6a 01                	push   $0x1
801057b3:	e8 92 fc ff ff       	call   8010544a <argstr>
801057b8:	83 c4 10             	add    $0x10,%esp
801057bb:	85 c0                	test   %eax,%eax
801057bd:	79 0a                	jns    801057c9 <sys_link+0x3a>
    return -1;
801057bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057c4:	e9 63 01 00 00       	jmp    8010592c <sys_link+0x19d>
  if((ip = namei(old)) == 0)
801057c9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801057cc:	83 ec 0c             	sub    $0xc,%esp
801057cf:	50                   	push   %eax
801057d0:	e8 29 ce ff ff       	call   801025fe <namei>
801057d5:	83 c4 10             	add    $0x10,%esp
801057d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801057db:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801057df:	75 0a                	jne    801057eb <sys_link+0x5c>
    return -1;
801057e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057e6:	e9 41 01 00 00       	jmp    8010592c <sys_link+0x19d>

  begin_trans();
801057eb:	e8 f3 dc ff ff       	call   801034e3 <begin_trans>

  ilock(ip);
801057f0:	83 ec 0c             	sub    $0xc,%esp
801057f3:	ff 75 f4             	pushl  -0xc(%ebp)
801057f6:	e8 fc c0 ff ff       	call   801018f7 <ilock>
801057fb:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
801057fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105801:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105805:	66 83 f8 01          	cmp    $0x1,%ax
80105809:	75 1d                	jne    80105828 <sys_link+0x99>
    iunlockput(ip);
8010580b:	83 ec 0c             	sub    $0xc,%esp
8010580e:	ff 75 f4             	pushl  -0xc(%ebp)
80105811:	e8 9b c3 ff ff       	call   80101bb1 <iunlockput>
80105816:	83 c4 10             	add    $0x10,%esp
    commit_trans();
80105819:	e8 18 dd ff ff       	call   80103536 <commit_trans>
    return -1;
8010581e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105823:	e9 04 01 00 00       	jmp    8010592c <sys_link+0x19d>
  }

  ip->nlink++;
80105828:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010582b:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010582f:	83 c0 01             	add    $0x1,%eax
80105832:	89 c2                	mov    %eax,%edx
80105834:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105837:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
8010583b:	83 ec 0c             	sub    $0xc,%esp
8010583e:	ff 75 f4             	pushl  -0xc(%ebp)
80105841:	e8 dd be ff ff       	call   80101723 <iupdate>
80105846:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80105849:	83 ec 0c             	sub    $0xc,%esp
8010584c:	ff 75 f4             	pushl  -0xc(%ebp)
8010584f:	e8 fb c1 ff ff       	call   80101a4f <iunlock>
80105854:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
80105857:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010585a:	83 ec 08             	sub    $0x8,%esp
8010585d:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105860:	52                   	push   %edx
80105861:	50                   	push   %eax
80105862:	e8 b3 cd ff ff       	call   8010261a <nameiparent>
80105867:	83 c4 10             	add    $0x10,%esp
8010586a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010586d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105871:	74 71                	je     801058e4 <sys_link+0x155>
    goto bad;
  ilock(dp);
80105873:	83 ec 0c             	sub    $0xc,%esp
80105876:	ff 75 f0             	pushl  -0x10(%ebp)
80105879:	e8 79 c0 ff ff       	call   801018f7 <ilock>
8010587e:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105881:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105884:	8b 10                	mov    (%eax),%edx
80105886:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105889:	8b 00                	mov    (%eax),%eax
8010588b:	39 c2                	cmp    %eax,%edx
8010588d:	75 1d                	jne    801058ac <sys_link+0x11d>
8010588f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105892:	8b 40 04             	mov    0x4(%eax),%eax
80105895:	83 ec 04             	sub    $0x4,%esp
80105898:	50                   	push   %eax
80105899:	8d 45 e2             	lea    -0x1e(%ebp),%eax
8010589c:	50                   	push   %eax
8010589d:	ff 75 f0             	pushl  -0x10(%ebp)
801058a0:	e8 bd ca ff ff       	call   80102362 <dirlink>
801058a5:	83 c4 10             	add    $0x10,%esp
801058a8:	85 c0                	test   %eax,%eax
801058aa:	79 10                	jns    801058bc <sys_link+0x12d>
    iunlockput(dp);
801058ac:	83 ec 0c             	sub    $0xc,%esp
801058af:	ff 75 f0             	pushl  -0x10(%ebp)
801058b2:	e8 fa c2 ff ff       	call   80101bb1 <iunlockput>
801058b7:	83 c4 10             	add    $0x10,%esp
    goto bad;
801058ba:	eb 29                	jmp    801058e5 <sys_link+0x156>
  }
  iunlockput(dp);
801058bc:	83 ec 0c             	sub    $0xc,%esp
801058bf:	ff 75 f0             	pushl  -0x10(%ebp)
801058c2:	e8 ea c2 ff ff       	call   80101bb1 <iunlockput>
801058c7:	83 c4 10             	add    $0x10,%esp
  iput(ip);
801058ca:	83 ec 0c             	sub    $0xc,%esp
801058cd:	ff 75 f4             	pushl  -0xc(%ebp)
801058d0:	e8 ec c1 ff ff       	call   80101ac1 <iput>
801058d5:	83 c4 10             	add    $0x10,%esp

  commit_trans();
801058d8:	e8 59 dc ff ff       	call   80103536 <commit_trans>

  return 0;
801058dd:	b8 00 00 00 00       	mov    $0x0,%eax
801058e2:	eb 48                	jmp    8010592c <sys_link+0x19d>
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
801058e4:	90                   	nop
  commit_trans();

  return 0;

bad:
  ilock(ip);
801058e5:	83 ec 0c             	sub    $0xc,%esp
801058e8:	ff 75 f4             	pushl  -0xc(%ebp)
801058eb:	e8 07 c0 ff ff       	call   801018f7 <ilock>
801058f0:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
801058f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058f6:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801058fa:	83 e8 01             	sub    $0x1,%eax
801058fd:	89 c2                	mov    %eax,%edx
801058ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105902:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105906:	83 ec 0c             	sub    $0xc,%esp
80105909:	ff 75 f4             	pushl  -0xc(%ebp)
8010590c:	e8 12 be ff ff       	call   80101723 <iupdate>
80105911:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105914:	83 ec 0c             	sub    $0xc,%esp
80105917:	ff 75 f4             	pushl  -0xc(%ebp)
8010591a:	e8 92 c2 ff ff       	call   80101bb1 <iunlockput>
8010591f:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105922:	e8 0f dc ff ff       	call   80103536 <commit_trans>
  return -1;
80105927:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010592c:	c9                   	leave  
8010592d:	c3                   	ret    

8010592e <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
8010592e:	55                   	push   %ebp
8010592f:	89 e5                	mov    %esp,%ebp
80105931:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105934:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
8010593b:	eb 40                	jmp    8010597d <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010593d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105940:	6a 10                	push   $0x10
80105942:	50                   	push   %eax
80105943:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105946:	50                   	push   %eax
80105947:	ff 75 08             	pushl  0x8(%ebp)
8010594a:	e8 5f c6 ff ff       	call   80101fae <readi>
8010594f:	83 c4 10             	add    $0x10,%esp
80105952:	83 f8 10             	cmp    $0x10,%eax
80105955:	74 0d                	je     80105964 <isdirempty+0x36>
      panic("isdirempty: readi");
80105957:	83 ec 0c             	sub    $0xc,%esp
8010595a:	68 07 b8 10 80       	push   $0x8010b807
8010595f:	e8 02 ac ff ff       	call   80100566 <panic>
    if(de.inum != 0)
80105964:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105968:	66 85 c0             	test   %ax,%ax
8010596b:	74 07                	je     80105974 <isdirempty+0x46>
      return 0;
8010596d:	b8 00 00 00 00       	mov    $0x0,%eax
80105972:	eb 1b                	jmp    8010598f <isdirempty+0x61>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105974:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105977:	83 c0 10             	add    $0x10,%eax
8010597a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010597d:	8b 45 08             	mov    0x8(%ebp),%eax
80105980:	8b 50 18             	mov    0x18(%eax),%edx
80105983:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105986:	39 c2                	cmp    %eax,%edx
80105988:	77 b3                	ja     8010593d <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
8010598a:	b8 01 00 00 00       	mov    $0x1,%eax
}
8010598f:	c9                   	leave  
80105990:	c3                   	ret    

80105991 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105991:	55                   	push   %ebp
80105992:	89 e5                	mov    %esp,%ebp
80105994:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105997:	83 ec 08             	sub    $0x8,%esp
8010599a:	8d 45 cc             	lea    -0x34(%ebp),%eax
8010599d:	50                   	push   %eax
8010599e:	6a 00                	push   $0x0
801059a0:	e8 a5 fa ff ff       	call   8010544a <argstr>
801059a5:	83 c4 10             	add    $0x10,%esp
801059a8:	85 c0                	test   %eax,%eax
801059aa:	79 0a                	jns    801059b6 <sys_unlink+0x25>
    return -1;
801059ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059b1:	e9 b7 01 00 00       	jmp    80105b6d <sys_unlink+0x1dc>
  if((dp = nameiparent(path, name)) == 0)
801059b6:	8b 45 cc             	mov    -0x34(%ebp),%eax
801059b9:	83 ec 08             	sub    $0x8,%esp
801059bc:	8d 55 d2             	lea    -0x2e(%ebp),%edx
801059bf:	52                   	push   %edx
801059c0:	50                   	push   %eax
801059c1:	e8 54 cc ff ff       	call   8010261a <nameiparent>
801059c6:	83 c4 10             	add    $0x10,%esp
801059c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801059cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801059d0:	75 0a                	jne    801059dc <sys_unlink+0x4b>
    return -1;
801059d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059d7:	e9 91 01 00 00       	jmp    80105b6d <sys_unlink+0x1dc>

  begin_trans();
801059dc:	e8 02 db ff ff       	call   801034e3 <begin_trans>

  ilock(dp);
801059e1:	83 ec 0c             	sub    $0xc,%esp
801059e4:	ff 75 f4             	pushl  -0xc(%ebp)
801059e7:	e8 0b bf ff ff       	call   801018f7 <ilock>
801059ec:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801059ef:	83 ec 08             	sub    $0x8,%esp
801059f2:	68 19 b8 10 80       	push   $0x8010b819
801059f7:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801059fa:	50                   	push   %eax
801059fb:	e8 8d c8 ff ff       	call   8010228d <namecmp>
80105a00:	83 c4 10             	add    $0x10,%esp
80105a03:	85 c0                	test   %eax,%eax
80105a05:	0f 84 4a 01 00 00    	je     80105b55 <sys_unlink+0x1c4>
80105a0b:	83 ec 08             	sub    $0x8,%esp
80105a0e:	68 1b b8 10 80       	push   $0x8010b81b
80105a13:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105a16:	50                   	push   %eax
80105a17:	e8 71 c8 ff ff       	call   8010228d <namecmp>
80105a1c:	83 c4 10             	add    $0x10,%esp
80105a1f:	85 c0                	test   %eax,%eax
80105a21:	0f 84 2e 01 00 00    	je     80105b55 <sys_unlink+0x1c4>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105a27:	83 ec 04             	sub    $0x4,%esp
80105a2a:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105a2d:	50                   	push   %eax
80105a2e:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105a31:	50                   	push   %eax
80105a32:	ff 75 f4             	pushl  -0xc(%ebp)
80105a35:	e8 6e c8 ff ff       	call   801022a8 <dirlookup>
80105a3a:	83 c4 10             	add    $0x10,%esp
80105a3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105a40:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105a44:	0f 84 0a 01 00 00    	je     80105b54 <sys_unlink+0x1c3>
    goto bad;
  ilock(ip);
80105a4a:	83 ec 0c             	sub    $0xc,%esp
80105a4d:	ff 75 f0             	pushl  -0x10(%ebp)
80105a50:	e8 a2 be ff ff       	call   801018f7 <ilock>
80105a55:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105a58:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a5b:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105a5f:	66 85 c0             	test   %ax,%ax
80105a62:	7f 0d                	jg     80105a71 <sys_unlink+0xe0>
    panic("unlink: nlink < 1");
80105a64:	83 ec 0c             	sub    $0xc,%esp
80105a67:	68 1e b8 10 80       	push   $0x8010b81e
80105a6c:	e8 f5 aa ff ff       	call   80100566 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105a71:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a74:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105a78:	66 83 f8 01          	cmp    $0x1,%ax
80105a7c:	75 25                	jne    80105aa3 <sys_unlink+0x112>
80105a7e:	83 ec 0c             	sub    $0xc,%esp
80105a81:	ff 75 f0             	pushl  -0x10(%ebp)
80105a84:	e8 a5 fe ff ff       	call   8010592e <isdirempty>
80105a89:	83 c4 10             	add    $0x10,%esp
80105a8c:	85 c0                	test   %eax,%eax
80105a8e:	75 13                	jne    80105aa3 <sys_unlink+0x112>
    iunlockput(ip);
80105a90:	83 ec 0c             	sub    $0xc,%esp
80105a93:	ff 75 f0             	pushl  -0x10(%ebp)
80105a96:	e8 16 c1 ff ff       	call   80101bb1 <iunlockput>
80105a9b:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105a9e:	e9 b2 00 00 00       	jmp    80105b55 <sys_unlink+0x1c4>
  }

  memset(&de, 0, sizeof(de));
80105aa3:	83 ec 04             	sub    $0x4,%esp
80105aa6:	6a 10                	push   $0x10
80105aa8:	6a 00                	push   $0x0
80105aaa:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105aad:	50                   	push   %eax
80105aae:	e8 ed f5 ff ff       	call   801050a0 <memset>
80105ab3:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105ab6:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105ab9:	6a 10                	push   $0x10
80105abb:	50                   	push   %eax
80105abc:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105abf:	50                   	push   %eax
80105ac0:	ff 75 f4             	pushl  -0xc(%ebp)
80105ac3:	e8 3d c6 ff ff       	call   80102105 <writei>
80105ac8:	83 c4 10             	add    $0x10,%esp
80105acb:	83 f8 10             	cmp    $0x10,%eax
80105ace:	74 0d                	je     80105add <sys_unlink+0x14c>
    panic("unlink: writei");
80105ad0:	83 ec 0c             	sub    $0xc,%esp
80105ad3:	68 30 b8 10 80       	push   $0x8010b830
80105ad8:	e8 89 aa ff ff       	call   80100566 <panic>
  if(ip->type == T_DIR){
80105add:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ae0:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105ae4:	66 83 f8 01          	cmp    $0x1,%ax
80105ae8:	75 21                	jne    80105b0b <sys_unlink+0x17a>
    dp->nlink--;
80105aea:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105aed:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105af1:	83 e8 01             	sub    $0x1,%eax
80105af4:	89 c2                	mov    %eax,%edx
80105af6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105af9:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105afd:	83 ec 0c             	sub    $0xc,%esp
80105b00:	ff 75 f4             	pushl  -0xc(%ebp)
80105b03:	e8 1b bc ff ff       	call   80101723 <iupdate>
80105b08:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80105b0b:	83 ec 0c             	sub    $0xc,%esp
80105b0e:	ff 75 f4             	pushl  -0xc(%ebp)
80105b11:	e8 9b c0 ff ff       	call   80101bb1 <iunlockput>
80105b16:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80105b19:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b1c:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105b20:	83 e8 01             	sub    $0x1,%eax
80105b23:	89 c2                	mov    %eax,%edx
80105b25:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b28:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105b2c:	83 ec 0c             	sub    $0xc,%esp
80105b2f:	ff 75 f0             	pushl  -0x10(%ebp)
80105b32:	e8 ec bb ff ff       	call   80101723 <iupdate>
80105b37:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105b3a:	83 ec 0c             	sub    $0xc,%esp
80105b3d:	ff 75 f0             	pushl  -0x10(%ebp)
80105b40:	e8 6c c0 ff ff       	call   80101bb1 <iunlockput>
80105b45:	83 c4 10             	add    $0x10,%esp

  commit_trans();
80105b48:	e8 e9 d9 ff ff       	call   80103536 <commit_trans>

  return 0;
80105b4d:	b8 00 00 00 00       	mov    $0x0,%eax
80105b52:	eb 19                	jmp    80105b6d <sys_unlink+0x1dc>
  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
80105b54:	90                   	nop
  commit_trans();

  return 0;

bad:
  iunlockput(dp);
80105b55:	83 ec 0c             	sub    $0xc,%esp
80105b58:	ff 75 f4             	pushl  -0xc(%ebp)
80105b5b:	e8 51 c0 ff ff       	call   80101bb1 <iunlockput>
80105b60:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105b63:	e8 ce d9 ff ff       	call   80103536 <commit_trans>
  return -1;
80105b68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b6d:	c9                   	leave  
80105b6e:	c3                   	ret    

80105b6f <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105b6f:	55                   	push   %ebp
80105b70:	89 e5                	mov    %esp,%ebp
80105b72:	83 ec 38             	sub    $0x38,%esp
80105b75:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105b78:	8b 55 10             	mov    0x10(%ebp),%edx
80105b7b:	8b 45 14             	mov    0x14(%ebp),%eax
80105b7e:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105b82:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105b86:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105b8a:	83 ec 08             	sub    $0x8,%esp
80105b8d:	8d 45 de             	lea    -0x22(%ebp),%eax
80105b90:	50                   	push   %eax
80105b91:	ff 75 08             	pushl  0x8(%ebp)
80105b94:	e8 81 ca ff ff       	call   8010261a <nameiparent>
80105b99:	83 c4 10             	add    $0x10,%esp
80105b9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105b9f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105ba3:	75 0a                	jne    80105baf <create+0x40>
    return 0;
80105ba5:	b8 00 00 00 00       	mov    $0x0,%eax
80105baa:	e9 90 01 00 00       	jmp    80105d3f <create+0x1d0>
  ilock(dp);
80105baf:	83 ec 0c             	sub    $0xc,%esp
80105bb2:	ff 75 f4             	pushl  -0xc(%ebp)
80105bb5:	e8 3d bd ff ff       	call   801018f7 <ilock>
80105bba:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
80105bbd:	83 ec 04             	sub    $0x4,%esp
80105bc0:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105bc3:	50                   	push   %eax
80105bc4:	8d 45 de             	lea    -0x22(%ebp),%eax
80105bc7:	50                   	push   %eax
80105bc8:	ff 75 f4             	pushl  -0xc(%ebp)
80105bcb:	e8 d8 c6 ff ff       	call   801022a8 <dirlookup>
80105bd0:	83 c4 10             	add    $0x10,%esp
80105bd3:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105bd6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105bda:	74 50                	je     80105c2c <create+0xbd>
    iunlockput(dp);
80105bdc:	83 ec 0c             	sub    $0xc,%esp
80105bdf:	ff 75 f4             	pushl  -0xc(%ebp)
80105be2:	e8 ca bf ff ff       	call   80101bb1 <iunlockput>
80105be7:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80105bea:	83 ec 0c             	sub    $0xc,%esp
80105bed:	ff 75 f0             	pushl  -0x10(%ebp)
80105bf0:	e8 02 bd ff ff       	call   801018f7 <ilock>
80105bf5:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80105bf8:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105bfd:	75 15                	jne    80105c14 <create+0xa5>
80105bff:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c02:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105c06:	66 83 f8 02          	cmp    $0x2,%ax
80105c0a:	75 08                	jne    80105c14 <create+0xa5>
      return ip;
80105c0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c0f:	e9 2b 01 00 00       	jmp    80105d3f <create+0x1d0>
    iunlockput(ip);
80105c14:	83 ec 0c             	sub    $0xc,%esp
80105c17:	ff 75 f0             	pushl  -0x10(%ebp)
80105c1a:	e8 92 bf ff ff       	call   80101bb1 <iunlockput>
80105c1f:	83 c4 10             	add    $0x10,%esp
    return 0;
80105c22:	b8 00 00 00 00       	mov    $0x0,%eax
80105c27:	e9 13 01 00 00       	jmp    80105d3f <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105c2c:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105c30:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c33:	8b 00                	mov    (%eax),%eax
80105c35:	83 ec 08             	sub    $0x8,%esp
80105c38:	52                   	push   %edx
80105c39:	50                   	push   %eax
80105c3a:	e8 03 ba ff ff       	call   80101642 <ialloc>
80105c3f:	83 c4 10             	add    $0x10,%esp
80105c42:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105c45:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105c49:	75 0d                	jne    80105c58 <create+0xe9>
    panic("create: ialloc");
80105c4b:	83 ec 0c             	sub    $0xc,%esp
80105c4e:	68 3f b8 10 80       	push   $0x8010b83f
80105c53:	e8 0e a9 ff ff       	call   80100566 <panic>

  ilock(ip);
80105c58:	83 ec 0c             	sub    $0xc,%esp
80105c5b:	ff 75 f0             	pushl  -0x10(%ebp)
80105c5e:	e8 94 bc ff ff       	call   801018f7 <ilock>
80105c63:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80105c66:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c69:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105c6d:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80105c71:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c74:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105c78:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80105c7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c7f:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105c85:	83 ec 0c             	sub    $0xc,%esp
80105c88:	ff 75 f0             	pushl  -0x10(%ebp)
80105c8b:	e8 93 ba ff ff       	call   80101723 <iupdate>
80105c90:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
80105c93:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105c98:	75 6a                	jne    80105d04 <create+0x195>
    dp->nlink++;  // for ".."
80105c9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c9d:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105ca1:	83 c0 01             	add    $0x1,%eax
80105ca4:	89 c2                	mov    %eax,%edx
80105ca6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ca9:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105cad:	83 ec 0c             	sub    $0xc,%esp
80105cb0:	ff 75 f4             	pushl  -0xc(%ebp)
80105cb3:	e8 6b ba ff ff       	call   80101723 <iupdate>
80105cb8:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105cbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cbe:	8b 40 04             	mov    0x4(%eax),%eax
80105cc1:	83 ec 04             	sub    $0x4,%esp
80105cc4:	50                   	push   %eax
80105cc5:	68 19 b8 10 80       	push   $0x8010b819
80105cca:	ff 75 f0             	pushl  -0x10(%ebp)
80105ccd:	e8 90 c6 ff ff       	call   80102362 <dirlink>
80105cd2:	83 c4 10             	add    $0x10,%esp
80105cd5:	85 c0                	test   %eax,%eax
80105cd7:	78 1e                	js     80105cf7 <create+0x188>
80105cd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cdc:	8b 40 04             	mov    0x4(%eax),%eax
80105cdf:	83 ec 04             	sub    $0x4,%esp
80105ce2:	50                   	push   %eax
80105ce3:	68 1b b8 10 80       	push   $0x8010b81b
80105ce8:	ff 75 f0             	pushl  -0x10(%ebp)
80105ceb:	e8 72 c6 ff ff       	call   80102362 <dirlink>
80105cf0:	83 c4 10             	add    $0x10,%esp
80105cf3:	85 c0                	test   %eax,%eax
80105cf5:	79 0d                	jns    80105d04 <create+0x195>
      panic("create dots");
80105cf7:	83 ec 0c             	sub    $0xc,%esp
80105cfa:	68 4e b8 10 80       	push   $0x8010b84e
80105cff:	e8 62 a8 ff ff       	call   80100566 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105d04:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d07:	8b 40 04             	mov    0x4(%eax),%eax
80105d0a:	83 ec 04             	sub    $0x4,%esp
80105d0d:	50                   	push   %eax
80105d0e:	8d 45 de             	lea    -0x22(%ebp),%eax
80105d11:	50                   	push   %eax
80105d12:	ff 75 f4             	pushl  -0xc(%ebp)
80105d15:	e8 48 c6 ff ff       	call   80102362 <dirlink>
80105d1a:	83 c4 10             	add    $0x10,%esp
80105d1d:	85 c0                	test   %eax,%eax
80105d1f:	79 0d                	jns    80105d2e <create+0x1bf>
    panic("create: dirlink");
80105d21:	83 ec 0c             	sub    $0xc,%esp
80105d24:	68 5a b8 10 80       	push   $0x8010b85a
80105d29:	e8 38 a8 ff ff       	call   80100566 <panic>

  iunlockput(dp);
80105d2e:	83 ec 0c             	sub    $0xc,%esp
80105d31:	ff 75 f4             	pushl  -0xc(%ebp)
80105d34:	e8 78 be ff ff       	call   80101bb1 <iunlockput>
80105d39:	83 c4 10             	add    $0x10,%esp

  return ip;
80105d3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105d3f:	c9                   	leave  
80105d40:	c3                   	ret    

80105d41 <sys_open>:

int
sys_open(void)
{
80105d41:	55                   	push   %ebp
80105d42:	89 e5                	mov    %esp,%ebp
80105d44:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105d47:	83 ec 08             	sub    $0x8,%esp
80105d4a:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105d4d:	50                   	push   %eax
80105d4e:	6a 00                	push   $0x0
80105d50:	e8 f5 f6 ff ff       	call   8010544a <argstr>
80105d55:	83 c4 10             	add    $0x10,%esp
80105d58:	85 c0                	test   %eax,%eax
80105d5a:	78 15                	js     80105d71 <sys_open+0x30>
80105d5c:	83 ec 08             	sub    $0x8,%esp
80105d5f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d62:	50                   	push   %eax
80105d63:	6a 01                	push   $0x1
80105d65:	e8 5b f6 ff ff       	call   801053c5 <argint>
80105d6a:	83 c4 10             	add    $0x10,%esp
80105d6d:	85 c0                	test   %eax,%eax
80105d6f:	79 0a                	jns    80105d7b <sys_open+0x3a>
    return -1;
80105d71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d76:	e9 4d 01 00 00       	jmp    80105ec8 <sys_open+0x187>
  if(omode & O_CREATE){
80105d7b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105d7e:	25 00 02 00 00       	and    $0x200,%eax
80105d83:	85 c0                	test   %eax,%eax
80105d85:	74 2f                	je     80105db6 <sys_open+0x75>
    begin_trans();
80105d87:	e8 57 d7 ff ff       	call   801034e3 <begin_trans>
    ip = create(path, T_FILE, 0, 0);
80105d8c:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105d8f:	6a 00                	push   $0x0
80105d91:	6a 00                	push   $0x0
80105d93:	6a 02                	push   $0x2
80105d95:	50                   	push   %eax
80105d96:	e8 d4 fd ff ff       	call   80105b6f <create>
80105d9b:	83 c4 10             	add    $0x10,%esp
80105d9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    commit_trans();
80105da1:	e8 90 d7 ff ff       	call   80103536 <commit_trans>
    if(ip == 0)
80105da6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105daa:	75 66                	jne    80105e12 <sys_open+0xd1>
      return -1;
80105dac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105db1:	e9 12 01 00 00       	jmp    80105ec8 <sys_open+0x187>
  } else {
    if((ip = namei(path)) == 0)
80105db6:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105db9:	83 ec 0c             	sub    $0xc,%esp
80105dbc:	50                   	push   %eax
80105dbd:	e8 3c c8 ff ff       	call   801025fe <namei>
80105dc2:	83 c4 10             	add    $0x10,%esp
80105dc5:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105dc8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105dcc:	75 0a                	jne    80105dd8 <sys_open+0x97>
      return -1;
80105dce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dd3:	e9 f0 00 00 00       	jmp    80105ec8 <sys_open+0x187>
    ilock(ip);
80105dd8:	83 ec 0c             	sub    $0xc,%esp
80105ddb:	ff 75 f4             	pushl  -0xc(%ebp)
80105dde:	e8 14 bb ff ff       	call   801018f7 <ilock>
80105de3:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80105de6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105de9:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105ded:	66 83 f8 01          	cmp    $0x1,%ax
80105df1:	75 1f                	jne    80105e12 <sys_open+0xd1>
80105df3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105df6:	85 c0                	test   %eax,%eax
80105df8:	74 18                	je     80105e12 <sys_open+0xd1>
      iunlockput(ip);
80105dfa:	83 ec 0c             	sub    $0xc,%esp
80105dfd:	ff 75 f4             	pushl  -0xc(%ebp)
80105e00:	e8 ac bd ff ff       	call   80101bb1 <iunlockput>
80105e05:	83 c4 10             	add    $0x10,%esp
      return -1;
80105e08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e0d:	e9 b6 00 00 00       	jmp    80105ec8 <sys_open+0x187>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105e12:	e8 4d b1 ff ff       	call   80100f64 <filealloc>
80105e17:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105e1a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e1e:	74 17                	je     80105e37 <sys_open+0xf6>
80105e20:	83 ec 0c             	sub    $0xc,%esp
80105e23:	ff 75 f0             	pushl  -0x10(%ebp)
80105e26:	e8 4b f7 ff ff       	call   80105576 <fdalloc>
80105e2b:	83 c4 10             	add    $0x10,%esp
80105e2e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105e31:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105e35:	79 29                	jns    80105e60 <sys_open+0x11f>
    if(f)
80105e37:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e3b:	74 0e                	je     80105e4b <sys_open+0x10a>
      fileclose(f);
80105e3d:	83 ec 0c             	sub    $0xc,%esp
80105e40:	ff 75 f0             	pushl  -0x10(%ebp)
80105e43:	e8 da b1 ff ff       	call   80101022 <fileclose>
80105e48:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105e4b:	83 ec 0c             	sub    $0xc,%esp
80105e4e:	ff 75 f4             	pushl  -0xc(%ebp)
80105e51:	e8 5b bd ff ff       	call   80101bb1 <iunlockput>
80105e56:	83 c4 10             	add    $0x10,%esp
    return -1;
80105e59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e5e:	eb 68                	jmp    80105ec8 <sys_open+0x187>
  }
  iunlock(ip);
80105e60:	83 ec 0c             	sub    $0xc,%esp
80105e63:	ff 75 f4             	pushl  -0xc(%ebp)
80105e66:	e8 e4 bb ff ff       	call   80101a4f <iunlock>
80105e6b:	83 c4 10             	add    $0x10,%esp

  f->type = FD_INODE;
80105e6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e71:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80105e77:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e7a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105e7d:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80105e80:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e83:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80105e8a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105e8d:	83 e0 01             	and    $0x1,%eax
80105e90:	85 c0                	test   %eax,%eax
80105e92:	0f 94 c0             	sete   %al
80105e95:	89 c2                	mov    %eax,%edx
80105e97:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e9a:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ea0:	83 e0 01             	and    $0x1,%eax
80105ea3:	85 c0                	test   %eax,%eax
80105ea5:	75 0a                	jne    80105eb1 <sys_open+0x170>
80105ea7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105eaa:	83 e0 02             	and    $0x2,%eax
80105ead:	85 c0                	test   %eax,%eax
80105eaf:	74 07                	je     80105eb8 <sys_open+0x177>
80105eb1:	b8 01 00 00 00       	mov    $0x1,%eax
80105eb6:	eb 05                	jmp    80105ebd <sys_open+0x17c>
80105eb8:	b8 00 00 00 00       	mov    $0x0,%eax
80105ebd:	89 c2                	mov    %eax,%edx
80105ebf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ec2:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80105ec5:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80105ec8:	c9                   	leave  
80105ec9:	c3                   	ret    

80105eca <sys_mkdir>:

int
sys_mkdir(void)
{
80105eca:	55                   	push   %ebp
80105ecb:	89 e5                	mov    %esp,%ebp
80105ecd:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_trans();
80105ed0:	e8 0e d6 ff ff       	call   801034e3 <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105ed5:	83 ec 08             	sub    $0x8,%esp
80105ed8:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105edb:	50                   	push   %eax
80105edc:	6a 00                	push   $0x0
80105ede:	e8 67 f5 ff ff       	call   8010544a <argstr>
80105ee3:	83 c4 10             	add    $0x10,%esp
80105ee6:	85 c0                	test   %eax,%eax
80105ee8:	78 1b                	js     80105f05 <sys_mkdir+0x3b>
80105eea:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105eed:	6a 00                	push   $0x0
80105eef:	6a 00                	push   $0x0
80105ef1:	6a 01                	push   $0x1
80105ef3:	50                   	push   %eax
80105ef4:	e8 76 fc ff ff       	call   80105b6f <create>
80105ef9:	83 c4 10             	add    $0x10,%esp
80105efc:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105eff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f03:	75 0c                	jne    80105f11 <sys_mkdir+0x47>
    commit_trans();
80105f05:	e8 2c d6 ff ff       	call   80103536 <commit_trans>
    return -1;
80105f0a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f0f:	eb 18                	jmp    80105f29 <sys_mkdir+0x5f>
  }
  iunlockput(ip);
80105f11:	83 ec 0c             	sub    $0xc,%esp
80105f14:	ff 75 f4             	pushl  -0xc(%ebp)
80105f17:	e8 95 bc ff ff       	call   80101bb1 <iunlockput>
80105f1c:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105f1f:	e8 12 d6 ff ff       	call   80103536 <commit_trans>
  return 0;
80105f24:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105f29:	c9                   	leave  
80105f2a:	c3                   	ret    

80105f2b <sys_mknod>:

int
sys_mknod(void)
{
80105f2b:	55                   	push   %ebp
80105f2c:	89 e5                	mov    %esp,%ebp
80105f2e:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
80105f31:	e8 ad d5 ff ff       	call   801034e3 <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
80105f36:	83 ec 08             	sub    $0x8,%esp
80105f39:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105f3c:	50                   	push   %eax
80105f3d:	6a 00                	push   $0x0
80105f3f:	e8 06 f5 ff ff       	call   8010544a <argstr>
80105f44:	83 c4 10             	add    $0x10,%esp
80105f47:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f4a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f4e:	78 4f                	js     80105f9f <sys_mknod+0x74>
     argint(1, &major) < 0 ||
80105f50:	83 ec 08             	sub    $0x8,%esp
80105f53:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105f56:	50                   	push   %eax
80105f57:	6a 01                	push   $0x1
80105f59:	e8 67 f4 ff ff       	call   801053c5 <argint>
80105f5e:	83 c4 10             	add    $0x10,%esp
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
80105f61:	85 c0                	test   %eax,%eax
80105f63:	78 3a                	js     80105f9f <sys_mknod+0x74>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105f65:	83 ec 08             	sub    $0x8,%esp
80105f68:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f6b:	50                   	push   %eax
80105f6c:	6a 02                	push   $0x2
80105f6e:	e8 52 f4 ff ff       	call   801053c5 <argint>
80105f73:	83 c4 10             	add    $0x10,%esp
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105f76:	85 c0                	test   %eax,%eax
80105f78:	78 25                	js     80105f9f <sys_mknod+0x74>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80105f7a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f7d:	0f bf c8             	movswl %ax,%ecx
80105f80:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105f83:	0f bf d0             	movswl %ax,%edx
80105f86:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105f89:	51                   	push   %ecx
80105f8a:	52                   	push   %edx
80105f8b:	6a 03                	push   $0x3
80105f8d:	50                   	push   %eax
80105f8e:	e8 dc fb ff ff       	call   80105b6f <create>
80105f93:	83 c4 10             	add    $0x10,%esp
80105f96:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105f99:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f9d:	75 0c                	jne    80105fab <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    commit_trans();
80105f9f:	e8 92 d5 ff ff       	call   80103536 <commit_trans>
    return -1;
80105fa4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fa9:	eb 18                	jmp    80105fc3 <sys_mknod+0x98>
  }
  iunlockput(ip);
80105fab:	83 ec 0c             	sub    $0xc,%esp
80105fae:	ff 75 f0             	pushl  -0x10(%ebp)
80105fb1:	e8 fb bb ff ff       	call   80101bb1 <iunlockput>
80105fb6:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105fb9:	e8 78 d5 ff ff       	call   80103536 <commit_trans>
  return 0;
80105fbe:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105fc3:	c9                   	leave  
80105fc4:	c3                   	ret    

80105fc5 <sys_chdir>:

int
sys_chdir(void)
{
80105fc5:	55                   	push   %ebp
80105fc6:	89 e5                	mov    %esp,%ebp
80105fc8:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80105fcb:	83 ec 08             	sub    $0x8,%esp
80105fce:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105fd1:	50                   	push   %eax
80105fd2:	6a 00                	push   $0x0
80105fd4:	e8 71 f4 ff ff       	call   8010544a <argstr>
80105fd9:	83 c4 10             	add    $0x10,%esp
80105fdc:	85 c0                	test   %eax,%eax
80105fde:	78 18                	js     80105ff8 <sys_chdir+0x33>
80105fe0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fe3:	83 ec 0c             	sub    $0xc,%esp
80105fe6:	50                   	push   %eax
80105fe7:	e8 12 c6 ff ff       	call   801025fe <namei>
80105fec:	83 c4 10             	add    $0x10,%esp
80105fef:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ff2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105ff6:	75 07                	jne    80105fff <sys_chdir+0x3a>
    return -1;
80105ff8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ffd:	eb 64                	jmp    80106063 <sys_chdir+0x9e>
  ilock(ip);
80105fff:	83 ec 0c             	sub    $0xc,%esp
80106002:	ff 75 f4             	pushl  -0xc(%ebp)
80106005:	e8 ed b8 ff ff       	call   801018f7 <ilock>
8010600a:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
8010600d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106010:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106014:	66 83 f8 01          	cmp    $0x1,%ax
80106018:	74 15                	je     8010602f <sys_chdir+0x6a>
    iunlockput(ip);
8010601a:	83 ec 0c             	sub    $0xc,%esp
8010601d:	ff 75 f4             	pushl  -0xc(%ebp)
80106020:	e8 8c bb ff ff       	call   80101bb1 <iunlockput>
80106025:	83 c4 10             	add    $0x10,%esp
    return -1;
80106028:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010602d:	eb 34                	jmp    80106063 <sys_chdir+0x9e>
  }
  iunlock(ip);
8010602f:	83 ec 0c             	sub    $0xc,%esp
80106032:	ff 75 f4             	pushl  -0xc(%ebp)
80106035:	e8 15 ba ff ff       	call   80101a4f <iunlock>
8010603a:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
8010603d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106043:	8b 40 68             	mov    0x68(%eax),%eax
80106046:	83 ec 0c             	sub    $0xc,%esp
80106049:	50                   	push   %eax
8010604a:	e8 72 ba ff ff       	call   80101ac1 <iput>
8010604f:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
80106052:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106058:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010605b:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
8010605e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106063:	c9                   	leave  
80106064:	c3                   	ret    

80106065 <sys_exec>:

int
sys_exec(void)
{
80106065:	55                   	push   %ebp
80106066:	89 e5                	mov    %esp,%ebp
80106068:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010606e:	83 ec 08             	sub    $0x8,%esp
80106071:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106074:	50                   	push   %eax
80106075:	6a 00                	push   $0x0
80106077:	e8 ce f3 ff ff       	call   8010544a <argstr>
8010607c:	83 c4 10             	add    $0x10,%esp
8010607f:	85 c0                	test   %eax,%eax
80106081:	78 18                	js     8010609b <sys_exec+0x36>
80106083:	83 ec 08             	sub    $0x8,%esp
80106086:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
8010608c:	50                   	push   %eax
8010608d:	6a 01                	push   $0x1
8010608f:	e8 31 f3 ff ff       	call   801053c5 <argint>
80106094:	83 c4 10             	add    $0x10,%esp
80106097:	85 c0                	test   %eax,%eax
80106099:	79 0a                	jns    801060a5 <sys_exec+0x40>
    return -1;
8010609b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060a0:	e9 c6 00 00 00       	jmp    8010616b <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
801060a5:	83 ec 04             	sub    $0x4,%esp
801060a8:	68 80 00 00 00       	push   $0x80
801060ad:	6a 00                	push   $0x0
801060af:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801060b5:	50                   	push   %eax
801060b6:	e8 e5 ef ff ff       	call   801050a0 <memset>
801060bb:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
801060be:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
801060c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060c8:	83 f8 1f             	cmp    $0x1f,%eax
801060cb:	76 0a                	jbe    801060d7 <sys_exec+0x72>
      return -1;
801060cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060d2:	e9 94 00 00 00       	jmp    8010616b <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801060d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060da:	c1 e0 02             	shl    $0x2,%eax
801060dd:	89 c2                	mov    %eax,%edx
801060df:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
801060e5:	01 c2                	add    %eax,%edx
801060e7:	83 ec 08             	sub    $0x8,%esp
801060ea:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801060f0:	50                   	push   %eax
801060f1:	52                   	push   %edx
801060f2:	e8 32 f2 ff ff       	call   80105329 <fetchint>
801060f7:	83 c4 10             	add    $0x10,%esp
801060fa:	85 c0                	test   %eax,%eax
801060fc:	79 07                	jns    80106105 <sys_exec+0xa0>
      return -1;
801060fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106103:	eb 66                	jmp    8010616b <sys_exec+0x106>
    if(uarg == 0){
80106105:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010610b:	85 c0                	test   %eax,%eax
8010610d:	75 27                	jne    80106136 <sys_exec+0xd1>
      argv[i] = 0;
8010610f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106112:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80106119:	00 00 00 00 
      break;
8010611d:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
8010611e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106121:	83 ec 08             	sub    $0x8,%esp
80106124:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
8010612a:	52                   	push   %edx
8010612b:	50                   	push   %eax
8010612c:	e8 25 aa ff ff       	call   80100b56 <exec>
80106131:	83 c4 10             	add    $0x10,%esp
80106134:	eb 35                	jmp    8010616b <sys_exec+0x106>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106136:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010613c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010613f:	c1 e2 02             	shl    $0x2,%edx
80106142:	01 c2                	add    %eax,%edx
80106144:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010614a:	83 ec 08             	sub    $0x8,%esp
8010614d:	52                   	push   %edx
8010614e:	50                   	push   %eax
8010614f:	e8 0f f2 ff ff       	call   80105363 <fetchstr>
80106154:	83 c4 10             	add    $0x10,%esp
80106157:	85 c0                	test   %eax,%eax
80106159:	79 07                	jns    80106162 <sys_exec+0xfd>
      return -1;
8010615b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106160:	eb 09                	jmp    8010616b <sys_exec+0x106>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80106162:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
80106166:	e9 5a ff ff ff       	jmp    801060c5 <sys_exec+0x60>
  return exec(path, argv);
}
8010616b:	c9                   	leave  
8010616c:	c3                   	ret    

8010616d <sys_pipe>:

int
sys_pipe(void)
{
8010616d:	55                   	push   %ebp
8010616e:	89 e5                	mov    %esp,%ebp
80106170:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106173:	83 ec 04             	sub    $0x4,%esp
80106176:	6a 08                	push   $0x8
80106178:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010617b:	50                   	push   %eax
8010617c:	6a 00                	push   $0x0
8010617e:	e8 6a f2 ff ff       	call   801053ed <argptr>
80106183:	83 c4 10             	add    $0x10,%esp
80106186:	85 c0                	test   %eax,%eax
80106188:	79 0a                	jns    80106194 <sys_pipe+0x27>
    return -1;
8010618a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010618f:	e9 af 00 00 00       	jmp    80106243 <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
80106194:	83 ec 08             	sub    $0x8,%esp
80106197:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010619a:	50                   	push   %eax
8010619b:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010619e:	50                   	push   %eax
8010619f:	e8 1a dd ff ff       	call   80103ebe <pipealloc>
801061a4:	83 c4 10             	add    $0x10,%esp
801061a7:	85 c0                	test   %eax,%eax
801061a9:	79 0a                	jns    801061b5 <sys_pipe+0x48>
    return -1;
801061ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061b0:	e9 8e 00 00 00       	jmp    80106243 <sys_pipe+0xd6>
  fd0 = -1;
801061b5:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801061bc:	8b 45 e8             	mov    -0x18(%ebp),%eax
801061bf:	83 ec 0c             	sub    $0xc,%esp
801061c2:	50                   	push   %eax
801061c3:	e8 ae f3 ff ff       	call   80105576 <fdalloc>
801061c8:	83 c4 10             	add    $0x10,%esp
801061cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
801061ce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061d2:	78 18                	js     801061ec <sys_pipe+0x7f>
801061d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801061d7:	83 ec 0c             	sub    $0xc,%esp
801061da:	50                   	push   %eax
801061db:	e8 96 f3 ff ff       	call   80105576 <fdalloc>
801061e0:	83 c4 10             	add    $0x10,%esp
801061e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
801061e6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801061ea:	79 3f                	jns    8010622b <sys_pipe+0xbe>
    if(fd0 >= 0)
801061ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061f0:	78 14                	js     80106206 <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
801061f2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801061f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801061fb:	83 c2 08             	add    $0x8,%edx
801061fe:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80106205:	00 
    fileclose(rf);
80106206:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106209:	83 ec 0c             	sub    $0xc,%esp
8010620c:	50                   	push   %eax
8010620d:	e8 10 ae ff ff       	call   80101022 <fileclose>
80106212:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
80106215:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106218:	83 ec 0c             	sub    $0xc,%esp
8010621b:	50                   	push   %eax
8010621c:	e8 01 ae ff ff       	call   80101022 <fileclose>
80106221:	83 c4 10             	add    $0x10,%esp
    return -1;
80106224:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106229:	eb 18                	jmp    80106243 <sys_pipe+0xd6>
  }
  fd[0] = fd0;
8010622b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010622e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106231:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80106233:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106236:	8d 50 04             	lea    0x4(%eax),%edx
80106239:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010623c:	89 02                	mov    %eax,(%edx)
  return 0;
8010623e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106243:	c9                   	leave  
80106244:	c3                   	ret    

80106245 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106245:	55                   	push   %ebp
80106246:	89 e5                	mov    %esp,%ebp
80106248:	83 ec 08             	sub    $0x8,%esp
  return fork();
8010624b:	e8 64 e3 ff ff       	call   801045b4 <fork>
}
80106250:	c9                   	leave  
80106251:	c3                   	ret    

80106252 <sys_exit>:

int
sys_exit(void)
{
80106252:	55                   	push   %ebp
80106253:	89 e5                	mov    %esp,%ebp
80106255:	83 ec 08             	sub    $0x8,%esp
  exit();
80106258:	e8 c8 e4 ff ff       	call   80104725 <exit>
  return 0;  // not reached
8010625d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106262:	c9                   	leave  
80106263:	c3                   	ret    

80106264 <sys_wait>:

int
sys_wait(void)
{
80106264:	55                   	push   %ebp
80106265:	89 e5                	mov    %esp,%ebp
80106267:	83 ec 08             	sub    $0x8,%esp
  return wait();
8010626a:	e8 e4 e5 ff ff       	call   80104853 <wait>
}
8010626f:	c9                   	leave  
80106270:	c3                   	ret    

80106271 <sys_kill>:

int
sys_kill(void)
{
80106271:	55                   	push   %ebp
80106272:	89 e5                	mov    %esp,%ebp
80106274:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106277:	83 ec 08             	sub    $0x8,%esp
8010627a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010627d:	50                   	push   %eax
8010627e:	6a 00                	push   $0x0
80106280:	e8 40 f1 ff ff       	call   801053c5 <argint>
80106285:	83 c4 10             	add    $0x10,%esp
80106288:	85 c0                	test   %eax,%eax
8010628a:	79 07                	jns    80106293 <sys_kill+0x22>
    return -1;
8010628c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106291:	eb 0f                	jmp    801062a2 <sys_kill+0x31>
  return kill(pid);
80106293:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106296:	83 ec 0c             	sub    $0xc,%esp
80106299:	50                   	push   %eax
8010629a:	e8 c7 e9 ff ff       	call   80104c66 <kill>
8010629f:	83 c4 10             	add    $0x10,%esp
}
801062a2:	c9                   	leave  
801062a3:	c3                   	ret    

801062a4 <sys_getpid>:

int
sys_getpid(void)
{
801062a4:	55                   	push   %ebp
801062a5:	89 e5                	mov    %esp,%ebp
  return proc->pid;
801062a7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062ad:	8b 40 10             	mov    0x10(%eax),%eax
}
801062b0:	5d                   	pop    %ebp
801062b1:	c3                   	ret    

801062b2 <sys_sbrk>:

int
sys_sbrk(void)
{
801062b2:	55                   	push   %ebp
801062b3:	89 e5                	mov    %esp,%ebp
801062b5:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801062b8:	83 ec 08             	sub    $0x8,%esp
801062bb:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062be:	50                   	push   %eax
801062bf:	6a 00                	push   $0x0
801062c1:	e8 ff f0 ff ff       	call   801053c5 <argint>
801062c6:	83 c4 10             	add    $0x10,%esp
801062c9:	85 c0                	test   %eax,%eax
801062cb:	79 07                	jns    801062d4 <sys_sbrk+0x22>
    return -1;
801062cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062d2:	eb 28                	jmp    801062fc <sys_sbrk+0x4a>
  addr = proc->sz;
801062d4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062da:	8b 00                	mov    (%eax),%eax
801062dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
801062df:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062e2:	83 ec 0c             	sub    $0xc,%esp
801062e5:	50                   	push   %eax
801062e6:	e8 26 e2 ff ff       	call   80104511 <growproc>
801062eb:	83 c4 10             	add    $0x10,%esp
801062ee:	85 c0                	test   %eax,%eax
801062f0:	79 07                	jns    801062f9 <sys_sbrk+0x47>
    return -1;
801062f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062f7:	eb 03                	jmp    801062fc <sys_sbrk+0x4a>
  return addr;
801062f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801062fc:	c9                   	leave  
801062fd:	c3                   	ret    

801062fe <sys_sleep>:

int
sys_sleep(void)
{
801062fe:	55                   	push   %ebp
801062ff:	89 e5                	mov    %esp,%ebp
80106301:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
80106304:	83 ec 08             	sub    $0x8,%esp
80106307:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010630a:	50                   	push   %eax
8010630b:	6a 00                	push   $0x0
8010630d:	e8 b3 f0 ff ff       	call   801053c5 <argint>
80106312:	83 c4 10             	add    $0x10,%esp
80106315:	85 c0                	test   %eax,%eax
80106317:	79 07                	jns    80106320 <sys_sleep+0x22>
    return -1;
80106319:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010631e:	eb 77                	jmp    80106397 <sys_sleep+0x99>
  acquire(&tickslock);
80106320:	83 ec 0c             	sub    $0xc,%esp
80106323:	68 c0 4e 11 80       	push   $0x80114ec0
80106328:	e8 10 eb ff ff       	call   80104e3d <acquire>
8010632d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80106330:	a1 00 57 11 80       	mov    0x80115700,%eax
80106335:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80106338:	eb 39                	jmp    80106373 <sys_sleep+0x75>
    if(proc->killed){
8010633a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106340:	8b 40 24             	mov    0x24(%eax),%eax
80106343:	85 c0                	test   %eax,%eax
80106345:	74 17                	je     8010635e <sys_sleep+0x60>
      release(&tickslock);
80106347:	83 ec 0c             	sub    $0xc,%esp
8010634a:	68 c0 4e 11 80       	push   $0x80114ec0
8010634f:	e8 50 eb ff ff       	call   80104ea4 <release>
80106354:	83 c4 10             	add    $0x10,%esp
      return -1;
80106357:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010635c:	eb 39                	jmp    80106397 <sys_sleep+0x99>
    }
    sleep(&ticks, &tickslock);
8010635e:	83 ec 08             	sub    $0x8,%esp
80106361:	68 c0 4e 11 80       	push   $0x80114ec0
80106366:	68 00 57 11 80       	push   $0x80115700
8010636b:	e8 d4 e7 ff ff       	call   80104b44 <sleep>
80106370:	83 c4 10             	add    $0x10,%esp
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106373:	a1 00 57 11 80       	mov    0x80115700,%eax
80106378:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010637b:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010637e:	39 d0                	cmp    %edx,%eax
80106380:	72 b8                	jb     8010633a <sys_sleep+0x3c>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80106382:	83 ec 0c             	sub    $0xc,%esp
80106385:	68 c0 4e 11 80       	push   $0x80114ec0
8010638a:	e8 15 eb ff ff       	call   80104ea4 <release>
8010638f:	83 c4 10             	add    $0x10,%esp
  return 0;
80106392:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106397:	c9                   	leave  
80106398:	c3                   	ret    

80106399 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106399:	55                   	push   %ebp
8010639a:	89 e5                	mov    %esp,%ebp
8010639c:	83 ec 18             	sub    $0x18,%esp
  uint xticks;
  
  acquire(&tickslock);
8010639f:	83 ec 0c             	sub    $0xc,%esp
801063a2:	68 c0 4e 11 80       	push   $0x80114ec0
801063a7:	e8 91 ea ff ff       	call   80104e3d <acquire>
801063ac:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
801063af:	a1 00 57 11 80       	mov    0x80115700,%eax
801063b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
801063b7:	83 ec 0c             	sub    $0xc,%esp
801063ba:	68 c0 4e 11 80       	push   $0x80114ec0
801063bf:	e8 e0 ea ff ff       	call   80104ea4 <release>
801063c4:	83 c4 10             	add    $0x10,%esp
  return xticks;
801063c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801063ca:	c9                   	leave  
801063cb:	c3                   	ret    

801063cc <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801063cc:	55                   	push   %ebp
801063cd:	89 e5                	mov    %esp,%ebp
801063cf:	83 ec 08             	sub    $0x8,%esp
801063d2:	8b 55 08             	mov    0x8(%ebp),%edx
801063d5:	8b 45 0c             	mov    0xc(%ebp),%eax
801063d8:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801063dc:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801063df:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801063e3:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801063e7:	ee                   	out    %al,(%dx)
}
801063e8:	90                   	nop
801063e9:	c9                   	leave  
801063ea:	c3                   	ret    

801063eb <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
801063eb:	55                   	push   %ebp
801063ec:	89 e5                	mov    %esp,%ebp
801063ee:	83 ec 08             	sub    $0x8,%esp
  // Interrupt --- 100 ticks/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
801063f1:	6a 34                	push   $0x34
801063f3:	6a 43                	push   $0x43
801063f5:	e8 d2 ff ff ff       	call   801063cc <outb>
801063fa:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
801063fd:	68 9c 00 00 00       	push   $0x9c
80106402:	6a 40                	push   $0x40
80106404:	e8 c3 ff ff ff       	call   801063cc <outb>
80106409:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
8010640c:	6a 2e                	push   $0x2e
8010640e:	6a 40                	push   $0x40
80106410:	e8 b7 ff ff ff       	call   801063cc <outb>
80106415:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
80106418:	83 ec 0c             	sub    $0xc,%esp
8010641b:	6a 00                	push   $0x0
8010641d:	e8 86 d9 ff ff       	call   80103da8 <picenable>
80106422:	83 c4 10             	add    $0x10,%esp
}
80106425:	90                   	nop
80106426:	c9                   	leave  
80106427:	c3                   	ret    

80106428 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106428:	1e                   	push   %ds
  pushl %es
80106429:	06                   	push   %es
  pushl %fs
8010642a:	0f a0                	push   %fs
  pushl %gs
8010642c:	0f a8                	push   %gs
  pushal
8010642e:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
8010642f:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106433:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106435:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80106437:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
8010643b:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
8010643d:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
8010643f:	54                   	push   %esp
  call trap
80106440:	e8 d7 01 00 00       	call   8010661c <trap>
  addl $4, %esp
80106445:	83 c4 04             	add    $0x4,%esp

80106448 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106448:	61                   	popa   
  popl %gs
80106449:	0f a9                	pop    %gs
  popl %fs
8010644b:	0f a1                	pop    %fs
  popl %es
8010644d:	07                   	pop    %es
  popl %ds
8010644e:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010644f:	83 c4 08             	add    $0x8,%esp
  iret
80106452:	cf                   	iret   

80106453 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
80106453:	55                   	push   %ebp
80106454:	89 e5                	mov    %esp,%ebp
80106456:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80106459:	8b 45 0c             	mov    0xc(%ebp),%eax
8010645c:	83 e8 01             	sub    $0x1,%eax
8010645f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106463:	8b 45 08             	mov    0x8(%ebp),%eax
80106466:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010646a:	8b 45 08             	mov    0x8(%ebp),%eax
8010646d:	c1 e8 10             	shr    $0x10,%eax
80106470:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106474:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106477:	0f 01 18             	lidtl  (%eax)
}
8010647a:	90                   	nop
8010647b:	c9                   	leave  
8010647c:	c3                   	ret    

8010647d <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
8010647d:	55                   	push   %ebp
8010647e:	89 e5                	mov    %esp,%ebp
80106480:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106483:	0f 20 d0             	mov    %cr2,%eax
80106486:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80106489:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010648c:	c9                   	leave  
8010648d:	c3                   	ret    

8010648e <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010648e:	55                   	push   %ebp
8010648f:	89 e5                	mov    %esp,%ebp
80106491:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
80106494:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010649b:	e9 c3 00 00 00       	jmp    80106563 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801064a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064a3:	8b 04 85 b4 e0 10 80 	mov    -0x7fef1f4c(,%eax,4),%eax
801064aa:	89 c2                	mov    %eax,%edx
801064ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064af:	66 89 14 c5 00 4f 11 	mov    %dx,-0x7feeb100(,%eax,8)
801064b6:	80 
801064b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064ba:	66 c7 04 c5 02 4f 11 	movw   $0x8,-0x7feeb0fe(,%eax,8)
801064c1:	80 08 00 
801064c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064c7:	0f b6 14 c5 04 4f 11 	movzbl -0x7feeb0fc(,%eax,8),%edx
801064ce:	80 
801064cf:	83 e2 e0             	and    $0xffffffe0,%edx
801064d2:	88 14 c5 04 4f 11 80 	mov    %dl,-0x7feeb0fc(,%eax,8)
801064d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064dc:	0f b6 14 c5 04 4f 11 	movzbl -0x7feeb0fc(,%eax,8),%edx
801064e3:	80 
801064e4:	83 e2 1f             	and    $0x1f,%edx
801064e7:	88 14 c5 04 4f 11 80 	mov    %dl,-0x7feeb0fc(,%eax,8)
801064ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064f1:	0f b6 14 c5 05 4f 11 	movzbl -0x7feeb0fb(,%eax,8),%edx
801064f8:	80 
801064f9:	83 e2 f0             	and    $0xfffffff0,%edx
801064fc:	83 ca 0e             	or     $0xe,%edx
801064ff:	88 14 c5 05 4f 11 80 	mov    %dl,-0x7feeb0fb(,%eax,8)
80106506:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106509:	0f b6 14 c5 05 4f 11 	movzbl -0x7feeb0fb(,%eax,8),%edx
80106510:	80 
80106511:	83 e2 ef             	and    $0xffffffef,%edx
80106514:	88 14 c5 05 4f 11 80 	mov    %dl,-0x7feeb0fb(,%eax,8)
8010651b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010651e:	0f b6 14 c5 05 4f 11 	movzbl -0x7feeb0fb(,%eax,8),%edx
80106525:	80 
80106526:	83 e2 9f             	and    $0xffffff9f,%edx
80106529:	88 14 c5 05 4f 11 80 	mov    %dl,-0x7feeb0fb(,%eax,8)
80106530:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106533:	0f b6 14 c5 05 4f 11 	movzbl -0x7feeb0fb(,%eax,8),%edx
8010653a:	80 
8010653b:	83 ca 80             	or     $0xffffff80,%edx
8010653e:	88 14 c5 05 4f 11 80 	mov    %dl,-0x7feeb0fb(,%eax,8)
80106545:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106548:	8b 04 85 b4 e0 10 80 	mov    -0x7fef1f4c(,%eax,4),%eax
8010654f:	c1 e8 10             	shr    $0x10,%eax
80106552:	89 c2                	mov    %eax,%edx
80106554:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106557:	66 89 14 c5 06 4f 11 	mov    %dx,-0x7feeb0fa(,%eax,8)
8010655e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010655f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106563:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
8010656a:	0f 8e 30 ff ff ff    	jle    801064a0 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106570:	a1 b4 e1 10 80       	mov    0x8010e1b4,%eax
80106575:	66 a3 00 51 11 80    	mov    %ax,0x80115100
8010657b:	66 c7 05 02 51 11 80 	movw   $0x8,0x80115102
80106582:	08 00 
80106584:	0f b6 05 04 51 11 80 	movzbl 0x80115104,%eax
8010658b:	83 e0 e0             	and    $0xffffffe0,%eax
8010658e:	a2 04 51 11 80       	mov    %al,0x80115104
80106593:	0f b6 05 04 51 11 80 	movzbl 0x80115104,%eax
8010659a:	83 e0 1f             	and    $0x1f,%eax
8010659d:	a2 04 51 11 80       	mov    %al,0x80115104
801065a2:	0f b6 05 05 51 11 80 	movzbl 0x80115105,%eax
801065a9:	83 c8 0f             	or     $0xf,%eax
801065ac:	a2 05 51 11 80       	mov    %al,0x80115105
801065b1:	0f b6 05 05 51 11 80 	movzbl 0x80115105,%eax
801065b8:	83 e0 ef             	and    $0xffffffef,%eax
801065bb:	a2 05 51 11 80       	mov    %al,0x80115105
801065c0:	0f b6 05 05 51 11 80 	movzbl 0x80115105,%eax
801065c7:	83 c8 60             	or     $0x60,%eax
801065ca:	a2 05 51 11 80       	mov    %al,0x80115105
801065cf:	0f b6 05 05 51 11 80 	movzbl 0x80115105,%eax
801065d6:	83 c8 80             	or     $0xffffff80,%eax
801065d9:	a2 05 51 11 80       	mov    %al,0x80115105
801065de:	a1 b4 e1 10 80       	mov    0x8010e1b4,%eax
801065e3:	c1 e8 10             	shr    $0x10,%eax
801065e6:	66 a3 06 51 11 80    	mov    %ax,0x80115106
  
  initlock(&tickslock, "time");
801065ec:	83 ec 08             	sub    $0x8,%esp
801065ef:	68 6c b8 10 80       	push   $0x8010b86c
801065f4:	68 c0 4e 11 80       	push   $0x80114ec0
801065f9:	e8 1d e8 ff ff       	call   80104e1b <initlock>
801065fe:	83 c4 10             	add    $0x10,%esp
}
80106601:	90                   	nop
80106602:	c9                   	leave  
80106603:	c3                   	ret    

80106604 <idtinit>:

void
idtinit(void)
{
80106604:	55                   	push   %ebp
80106605:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
80106607:	68 00 08 00 00       	push   $0x800
8010660c:	68 00 4f 11 80       	push   $0x80114f00
80106611:	e8 3d fe ff ff       	call   80106453 <lidt>
80106616:	83 c4 08             	add    $0x8,%esp
}
80106619:	90                   	nop
8010661a:	c9                   	leave  
8010661b:	c3                   	ret    

8010661c <trap>:
extern void TimerCount();

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
8010661c:	55                   	push   %ebp
8010661d:	89 e5                	mov    %esp,%ebp
8010661f:	57                   	push   %edi
80106620:	56                   	push   %esi
80106621:	53                   	push   %ebx
80106622:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
80106625:	8b 45 08             	mov    0x8(%ebp),%eax
80106628:	8b 40 30             	mov    0x30(%eax),%eax
8010662b:	83 f8 40             	cmp    $0x40,%eax
8010662e:	75 3e                	jne    8010666e <trap+0x52>
    if(proc->killed)
80106630:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106636:	8b 40 24             	mov    0x24(%eax),%eax
80106639:	85 c0                	test   %eax,%eax
8010663b:	74 05                	je     80106642 <trap+0x26>
      exit();
8010663d:	e8 e3 e0 ff ff       	call   80104725 <exit>
    proc->tf = tf;
80106642:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106648:	8b 55 08             	mov    0x8(%ebp),%edx
8010664b:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
8010664e:	e8 28 ee ff ff       	call   8010547b <syscall>
    if(proc->killed)
80106653:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106659:	8b 40 24             	mov    0x24(%eax),%eax
8010665c:	85 c0                	test   %eax,%eax
8010665e:	0f 84 35 02 00 00    	je     80106899 <trap+0x27d>
      exit();
80106664:	e8 bc e0 ff ff       	call   80104725 <exit>
    return;
80106669:	e9 2b 02 00 00       	jmp    80106899 <trap+0x27d>
  }

  switch(tf->trapno){
8010666e:	8b 45 08             	mov    0x8(%ebp),%eax
80106671:	8b 40 30             	mov    0x30(%eax),%eax
80106674:	83 e8 20             	sub    $0x20,%eax
80106677:	83 f8 1f             	cmp    $0x1f,%eax
8010667a:	0f 87 da 00 00 00    	ja     8010675a <trap+0x13e>
80106680:	8b 04 85 24 b9 10 80 	mov    -0x7fef46dc(,%eax,4),%eax
80106687:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
80106689:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010668f:	0f b6 00             	movzbl (%eax),%eax
80106692:	84 c0                	test   %al,%al
80106694:	75 3d                	jne    801066d3 <trap+0xb7>
      acquire(&tickslock);
80106696:	83 ec 0c             	sub    $0xc,%esp
80106699:	68 c0 4e 11 80       	push   $0x80114ec0
8010669e:	e8 9a e7 ff ff       	call   80104e3d <acquire>
801066a3:	83 c4 10             	add    $0x10,%esp
      ticks++;
801066a6:	a1 00 57 11 80       	mov    0x80115700,%eax
801066ab:	83 c0 01             	add    $0x1,%eax
801066ae:	a3 00 57 11 80       	mov    %eax,0x80115700
      wakeup(&ticks);
801066b3:	83 ec 0c             	sub    $0xc,%esp
801066b6:	68 00 57 11 80       	push   $0x80115700
801066bb:	e8 6f e5 ff ff       	call   80104c2f <wakeup>
801066c0:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
801066c3:	83 ec 0c             	sub    $0xc,%esp
801066c6:	68 c0 4e 11 80       	push   $0x80114ec0
801066cb:	e8 d4 e7 ff ff       	call   80104ea4 <release>
801066d0:	83 c4 10             	add    $0x10,%esp
    }
	//DealHandleMessage(ticks);
    TimerCount();
801066d3:	e8 c3 46 00 00       	call   8010ad9b <TimerCount>
    lapiceoi();
801066d8:	e8 de ca ff ff       	call   801031bb <lapiceoi>
    break;
801066dd:	e9 31 01 00 00       	jmp    80106813 <trap+0x1f7>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801066e2:	e8 eb c1 ff ff       	call   801028d2 <ideintr>
    lapiceoi();
801066e7:	e8 cf ca ff ff       	call   801031bb <lapiceoi>
    break;
801066ec:	e9 22 01 00 00       	jmp    80106813 <trap+0x1f7>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    //cprintf("kbd pressed!\n");
    kbdintr();
801066f1:	e8 ef c8 ff ff       	call   80102fe5 <kbdintr>
    lapiceoi();
801066f6:	e8 c0 ca ff ff       	call   801031bb <lapiceoi>
    break;
801066fb:	e9 13 01 00 00       	jmp    80106813 <trap+0x1f7>
  //  break;

  case T_IRQ0 + IRQ_MOUSE:
    //HandleInterupt();
    //lapiceoi();
     cprintf("mouse clicked!\n");
80106700:	83 ec 0c             	sub    $0xc,%esp
80106703:	68 71 b8 10 80       	push   $0x8010b871
80106708:	e8 b9 9c ff ff       	call   801003c6 <cprintf>
8010670d:	83 c4 10             	add    $0x10,%esp
     break;
80106710:	e9 fe 00 00 00       	jmp    80106813 <trap+0x1f7>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106715:	e8 60 03 00 00       	call   80106a7a <uartintr>
    lapiceoi();
8010671a:	e8 9c ca ff ff       	call   801031bb <lapiceoi>
    break;
8010671f:	e9 ef 00 00 00       	jmp    80106813 <trap+0x1f7>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106724:	8b 45 08             	mov    0x8(%ebp),%eax
80106727:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
8010672a:	8b 45 08             	mov    0x8(%ebp),%eax
8010672d:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106731:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
80106734:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010673a:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010673d:	0f b6 c0             	movzbl %al,%eax
80106740:	51                   	push   %ecx
80106741:	52                   	push   %edx
80106742:	50                   	push   %eax
80106743:	68 84 b8 10 80       	push   $0x8010b884
80106748:	e8 79 9c ff ff       	call   801003c6 <cprintf>
8010674d:	83 c4 10             	add    $0x10,%esp
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
80106750:	e8 66 ca ff ff       	call   801031bb <lapiceoi>
    break;
80106755:	e9 b9 00 00 00       	jmp    80106813 <trap+0x1f7>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
8010675a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106760:	85 c0                	test   %eax,%eax
80106762:	74 11                	je     80106775 <trap+0x159>
80106764:	8b 45 08             	mov    0x8(%ebp),%eax
80106767:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
8010676b:	0f b7 c0             	movzwl %ax,%eax
8010676e:	83 e0 03             	and    $0x3,%eax
80106771:	85 c0                	test   %eax,%eax
80106773:	75 40                	jne    801067b5 <trap+0x199>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106775:	e8 03 fd ff ff       	call   8010647d <rcr2>
8010677a:	89 c3                	mov    %eax,%ebx
8010677c:	8b 45 08             	mov    0x8(%ebp),%eax
8010677f:	8b 48 38             	mov    0x38(%eax),%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
80106782:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106788:	0f b6 00             	movzbl (%eax),%eax
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010678b:	0f b6 d0             	movzbl %al,%edx
8010678e:	8b 45 08             	mov    0x8(%ebp),%eax
80106791:	8b 40 30             	mov    0x30(%eax),%eax
80106794:	83 ec 0c             	sub    $0xc,%esp
80106797:	53                   	push   %ebx
80106798:	51                   	push   %ecx
80106799:	52                   	push   %edx
8010679a:	50                   	push   %eax
8010679b:	68 a8 b8 10 80       	push   $0x8010b8a8
801067a0:	e8 21 9c ff ff       	call   801003c6 <cprintf>
801067a5:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
801067a8:	83 ec 0c             	sub    $0xc,%esp
801067ab:	68 da b8 10 80       	push   $0x8010b8da
801067b0:	e8 b1 9d ff ff       	call   80100566 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801067b5:	e8 c3 fc ff ff       	call   8010647d <rcr2>
801067ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801067bd:	8b 45 08             	mov    0x8(%ebp),%eax
801067c0:	8b 70 38             	mov    0x38(%eax),%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801067c3:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801067c9:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801067cc:	0f b6 d8             	movzbl %al,%ebx
801067cf:	8b 45 08             	mov    0x8(%ebp),%eax
801067d2:	8b 48 34             	mov    0x34(%eax),%ecx
801067d5:	8b 45 08             	mov    0x8(%ebp),%eax
801067d8:	8b 50 30             	mov    0x30(%eax),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801067db:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801067e1:	8d 78 6c             	lea    0x6c(%eax),%edi
801067e4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801067ea:	8b 40 10             	mov    0x10(%eax),%eax
801067ed:	ff 75 e4             	pushl  -0x1c(%ebp)
801067f0:	56                   	push   %esi
801067f1:	53                   	push   %ebx
801067f2:	51                   	push   %ecx
801067f3:	52                   	push   %edx
801067f4:	57                   	push   %edi
801067f5:	50                   	push   %eax
801067f6:	68 e0 b8 10 80       	push   $0x8010b8e0
801067fb:	e8 c6 9b ff ff       	call   801003c6 <cprintf>
80106800:	83 c4 20             	add    $0x20,%esp
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
80106803:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106809:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106810:	eb 01                	jmp    80106813 <trap+0x1f7>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106812:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106813:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106819:	85 c0                	test   %eax,%eax
8010681b:	74 24                	je     80106841 <trap+0x225>
8010681d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106823:	8b 40 24             	mov    0x24(%eax),%eax
80106826:	85 c0                	test   %eax,%eax
80106828:	74 17                	je     80106841 <trap+0x225>
8010682a:	8b 45 08             	mov    0x8(%ebp),%eax
8010682d:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106831:	0f b7 c0             	movzwl %ax,%eax
80106834:	83 e0 03             	and    $0x3,%eax
80106837:	83 f8 03             	cmp    $0x3,%eax
8010683a:	75 05                	jne    80106841 <trap+0x225>
    exit();
8010683c:	e8 e4 de ff ff       	call   80104725 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106841:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106847:	85 c0                	test   %eax,%eax
80106849:	74 1e                	je     80106869 <trap+0x24d>
8010684b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106851:	8b 40 0c             	mov    0xc(%eax),%eax
80106854:	83 f8 04             	cmp    $0x4,%eax
80106857:	75 10                	jne    80106869 <trap+0x24d>
80106859:	8b 45 08             	mov    0x8(%ebp),%eax
8010685c:	8b 40 30             	mov    0x30(%eax),%eax
8010685f:	83 f8 20             	cmp    $0x20,%eax
80106862:	75 05                	jne    80106869 <trap+0x24d>
    yield();
80106864:	e8 6f e2 ff ff       	call   80104ad8 <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106869:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010686f:	85 c0                	test   %eax,%eax
80106871:	74 27                	je     8010689a <trap+0x27e>
80106873:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106879:	8b 40 24             	mov    0x24(%eax),%eax
8010687c:	85 c0                	test   %eax,%eax
8010687e:	74 1a                	je     8010689a <trap+0x27e>
80106880:	8b 45 08             	mov    0x8(%ebp),%eax
80106883:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106887:	0f b7 c0             	movzwl %ax,%eax
8010688a:	83 e0 03             	and    $0x3,%eax
8010688d:	83 f8 03             	cmp    $0x3,%eax
80106890:	75 08                	jne    8010689a <trap+0x27e>
    exit();
80106892:	e8 8e de ff ff       	call   80104725 <exit>
80106897:	eb 01                	jmp    8010689a <trap+0x27e>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
80106899:	90                   	nop
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
8010689a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010689d:	5b                   	pop    %ebx
8010689e:	5e                   	pop    %esi
8010689f:	5f                   	pop    %edi
801068a0:	5d                   	pop    %ebp
801068a1:	c3                   	ret    

801068a2 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801068a2:	55                   	push   %ebp
801068a3:	89 e5                	mov    %esp,%ebp
801068a5:	83 ec 14             	sub    $0x14,%esp
801068a8:	8b 45 08             	mov    0x8(%ebp),%eax
801068ab:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801068af:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801068b3:	89 c2                	mov    %eax,%edx
801068b5:	ec                   	in     (%dx),%al
801068b6:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801068b9:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801068bd:	c9                   	leave  
801068be:	c3                   	ret    

801068bf <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801068bf:	55                   	push   %ebp
801068c0:	89 e5                	mov    %esp,%ebp
801068c2:	83 ec 08             	sub    $0x8,%esp
801068c5:	8b 55 08             	mov    0x8(%ebp),%edx
801068c8:	8b 45 0c             	mov    0xc(%ebp),%eax
801068cb:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801068cf:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801068d2:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801068d6:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801068da:	ee                   	out    %al,(%dx)
}
801068db:	90                   	nop
801068dc:	c9                   	leave  
801068dd:	c3                   	ret    

801068de <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
801068de:	55                   	push   %ebp
801068df:	89 e5                	mov    %esp,%ebp
801068e1:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
801068e4:	6a 00                	push   $0x0
801068e6:	68 fa 03 00 00       	push   $0x3fa
801068eb:	e8 cf ff ff ff       	call   801068bf <outb>
801068f0:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
801068f3:	68 80 00 00 00       	push   $0x80
801068f8:	68 fb 03 00 00       	push   $0x3fb
801068fd:	e8 bd ff ff ff       	call   801068bf <outb>
80106902:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80106905:	6a 0c                	push   $0xc
80106907:	68 f8 03 00 00       	push   $0x3f8
8010690c:	e8 ae ff ff ff       	call   801068bf <outb>
80106911:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80106914:	6a 00                	push   $0x0
80106916:	68 f9 03 00 00       	push   $0x3f9
8010691b:	e8 9f ff ff ff       	call   801068bf <outb>
80106920:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106923:	6a 03                	push   $0x3
80106925:	68 fb 03 00 00       	push   $0x3fb
8010692a:	e8 90 ff ff ff       	call   801068bf <outb>
8010692f:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106932:	6a 00                	push   $0x0
80106934:	68 fc 03 00 00       	push   $0x3fc
80106939:	e8 81 ff ff ff       	call   801068bf <outb>
8010693e:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106941:	6a 01                	push   $0x1
80106943:	68 f9 03 00 00       	push   $0x3f9
80106948:	e8 72 ff ff ff       	call   801068bf <outb>
8010694d:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106950:	68 fd 03 00 00       	push   $0x3fd
80106955:	e8 48 ff ff ff       	call   801068a2 <inb>
8010695a:	83 c4 04             	add    $0x4,%esp
8010695d:	3c ff                	cmp    $0xff,%al
8010695f:	74 6e                	je     801069cf <uartinit+0xf1>
    return;
  uart = 1;
80106961:	c7 05 90 e6 10 80 01 	movl   $0x1,0x8010e690
80106968:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
8010696b:	68 fa 03 00 00       	push   $0x3fa
80106970:	e8 2d ff ff ff       	call   801068a2 <inb>
80106975:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80106978:	68 f8 03 00 00       	push   $0x3f8
8010697d:	e8 20 ff ff ff       	call   801068a2 <inb>
80106982:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
80106985:	83 ec 0c             	sub    $0xc,%esp
80106988:	6a 04                	push   $0x4
8010698a:	e8 19 d4 ff ff       	call   80103da8 <picenable>
8010698f:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
80106992:	83 ec 08             	sub    $0x8,%esp
80106995:	6a 00                	push   $0x0
80106997:	6a 04                	push   $0x4
80106999:	e8 d6 c1 ff ff       	call   80102b74 <ioapicenable>
8010699e:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801069a1:	c7 45 f4 a4 b9 10 80 	movl   $0x8010b9a4,-0xc(%ebp)
801069a8:	eb 19                	jmp    801069c3 <uartinit+0xe5>
    uartputc(*p);
801069aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069ad:	0f b6 00             	movzbl (%eax),%eax
801069b0:	0f be c0             	movsbl %al,%eax
801069b3:	83 ec 0c             	sub    $0xc,%esp
801069b6:	50                   	push   %eax
801069b7:	e8 16 00 00 00       	call   801069d2 <uartputc>
801069bc:	83 c4 10             	add    $0x10,%esp
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801069bf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801069c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069c6:	0f b6 00             	movzbl (%eax),%eax
801069c9:	84 c0                	test   %al,%al
801069cb:	75 dd                	jne    801069aa <uartinit+0xcc>
801069cd:	eb 01                	jmp    801069d0 <uartinit+0xf2>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
801069cf:	90                   	nop
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
801069d0:	c9                   	leave  
801069d1:	c3                   	ret    

801069d2 <uartputc>:

void
uartputc(int c)
{
801069d2:	55                   	push   %ebp
801069d3:	89 e5                	mov    %esp,%ebp
801069d5:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
801069d8:	a1 90 e6 10 80       	mov    0x8010e690,%eax
801069dd:	85 c0                	test   %eax,%eax
801069df:	74 53                	je     80106a34 <uartputc+0x62>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801069e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801069e8:	eb 11                	jmp    801069fb <uartputc+0x29>
    microdelay(10);
801069ea:	83 ec 0c             	sub    $0xc,%esp
801069ed:	6a 0a                	push   $0xa
801069ef:	e8 e2 c7 ff ff       	call   801031d6 <microdelay>
801069f4:	83 c4 10             	add    $0x10,%esp
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801069f7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801069fb:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
801069ff:	7f 1a                	jg     80106a1b <uartputc+0x49>
80106a01:	83 ec 0c             	sub    $0xc,%esp
80106a04:	68 fd 03 00 00       	push   $0x3fd
80106a09:	e8 94 fe ff ff       	call   801068a2 <inb>
80106a0e:	83 c4 10             	add    $0x10,%esp
80106a11:	0f b6 c0             	movzbl %al,%eax
80106a14:	83 e0 20             	and    $0x20,%eax
80106a17:	85 c0                	test   %eax,%eax
80106a19:	74 cf                	je     801069ea <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
80106a1b:	8b 45 08             	mov    0x8(%ebp),%eax
80106a1e:	0f b6 c0             	movzbl %al,%eax
80106a21:	83 ec 08             	sub    $0x8,%esp
80106a24:	50                   	push   %eax
80106a25:	68 f8 03 00 00       	push   $0x3f8
80106a2a:	e8 90 fe ff ff       	call   801068bf <outb>
80106a2f:	83 c4 10             	add    $0x10,%esp
80106a32:	eb 01                	jmp    80106a35 <uartputc+0x63>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
80106a34:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106a35:	c9                   	leave  
80106a36:	c3                   	ret    

80106a37 <uartgetc>:

static int
uartgetc(void)
{
80106a37:	55                   	push   %ebp
80106a38:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106a3a:	a1 90 e6 10 80       	mov    0x8010e690,%eax
80106a3f:	85 c0                	test   %eax,%eax
80106a41:	75 07                	jne    80106a4a <uartgetc+0x13>
    return -1;
80106a43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a48:	eb 2e                	jmp    80106a78 <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80106a4a:	68 fd 03 00 00       	push   $0x3fd
80106a4f:	e8 4e fe ff ff       	call   801068a2 <inb>
80106a54:	83 c4 04             	add    $0x4,%esp
80106a57:	0f b6 c0             	movzbl %al,%eax
80106a5a:	83 e0 01             	and    $0x1,%eax
80106a5d:	85 c0                	test   %eax,%eax
80106a5f:	75 07                	jne    80106a68 <uartgetc+0x31>
    return -1;
80106a61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a66:	eb 10                	jmp    80106a78 <uartgetc+0x41>
  return inb(COM1+0);
80106a68:	68 f8 03 00 00       	push   $0x3f8
80106a6d:	e8 30 fe ff ff       	call   801068a2 <inb>
80106a72:	83 c4 04             	add    $0x4,%esp
80106a75:	0f b6 c0             	movzbl %al,%eax
}
80106a78:	c9                   	leave  
80106a79:	c3                   	ret    

80106a7a <uartintr>:

void
uartintr(void)
{
80106a7a:	55                   	push   %ebp
80106a7b:	89 e5                	mov    %esp,%ebp
80106a7d:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80106a80:	83 ec 0c             	sub    $0xc,%esp
80106a83:	68 37 6a 10 80       	push   $0x80106a37
80106a88:	e8 50 9d ff ff       	call   801007dd <consoleintr>
80106a8d:	83 c4 10             	add    $0x10,%esp
}
80106a90:	90                   	nop
80106a91:	c9                   	leave  
80106a92:	c3                   	ret    

80106a93 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106a93:	6a 00                	push   $0x0
  pushl $0
80106a95:	6a 00                	push   $0x0
  jmp alltraps
80106a97:	e9 8c f9 ff ff       	jmp    80106428 <alltraps>

80106a9c <vector1>:
.globl vector1
vector1:
  pushl $0
80106a9c:	6a 00                	push   $0x0
  pushl $1
80106a9e:	6a 01                	push   $0x1
  jmp alltraps
80106aa0:	e9 83 f9 ff ff       	jmp    80106428 <alltraps>

80106aa5 <vector2>:
.globl vector2
vector2:
  pushl $0
80106aa5:	6a 00                	push   $0x0
  pushl $2
80106aa7:	6a 02                	push   $0x2
  jmp alltraps
80106aa9:	e9 7a f9 ff ff       	jmp    80106428 <alltraps>

80106aae <vector3>:
.globl vector3
vector3:
  pushl $0
80106aae:	6a 00                	push   $0x0
  pushl $3
80106ab0:	6a 03                	push   $0x3
  jmp alltraps
80106ab2:	e9 71 f9 ff ff       	jmp    80106428 <alltraps>

80106ab7 <vector4>:
.globl vector4
vector4:
  pushl $0
80106ab7:	6a 00                	push   $0x0
  pushl $4
80106ab9:	6a 04                	push   $0x4
  jmp alltraps
80106abb:	e9 68 f9 ff ff       	jmp    80106428 <alltraps>

80106ac0 <vector5>:
.globl vector5
vector5:
  pushl $0
80106ac0:	6a 00                	push   $0x0
  pushl $5
80106ac2:	6a 05                	push   $0x5
  jmp alltraps
80106ac4:	e9 5f f9 ff ff       	jmp    80106428 <alltraps>

80106ac9 <vector6>:
.globl vector6
vector6:
  pushl $0
80106ac9:	6a 00                	push   $0x0
  pushl $6
80106acb:	6a 06                	push   $0x6
  jmp alltraps
80106acd:	e9 56 f9 ff ff       	jmp    80106428 <alltraps>

80106ad2 <vector7>:
.globl vector7
vector7:
  pushl $0
80106ad2:	6a 00                	push   $0x0
  pushl $7
80106ad4:	6a 07                	push   $0x7
  jmp alltraps
80106ad6:	e9 4d f9 ff ff       	jmp    80106428 <alltraps>

80106adb <vector8>:
.globl vector8
vector8:
  pushl $8
80106adb:	6a 08                	push   $0x8
  jmp alltraps
80106add:	e9 46 f9 ff ff       	jmp    80106428 <alltraps>

80106ae2 <vector9>:
.globl vector9
vector9:
  pushl $0
80106ae2:	6a 00                	push   $0x0
  pushl $9
80106ae4:	6a 09                	push   $0x9
  jmp alltraps
80106ae6:	e9 3d f9 ff ff       	jmp    80106428 <alltraps>

80106aeb <vector10>:
.globl vector10
vector10:
  pushl $10
80106aeb:	6a 0a                	push   $0xa
  jmp alltraps
80106aed:	e9 36 f9 ff ff       	jmp    80106428 <alltraps>

80106af2 <vector11>:
.globl vector11
vector11:
  pushl $11
80106af2:	6a 0b                	push   $0xb
  jmp alltraps
80106af4:	e9 2f f9 ff ff       	jmp    80106428 <alltraps>

80106af9 <vector12>:
.globl vector12
vector12:
  pushl $12
80106af9:	6a 0c                	push   $0xc
  jmp alltraps
80106afb:	e9 28 f9 ff ff       	jmp    80106428 <alltraps>

80106b00 <vector13>:
.globl vector13
vector13:
  pushl $13
80106b00:	6a 0d                	push   $0xd
  jmp alltraps
80106b02:	e9 21 f9 ff ff       	jmp    80106428 <alltraps>

80106b07 <vector14>:
.globl vector14
vector14:
  pushl $14
80106b07:	6a 0e                	push   $0xe
  jmp alltraps
80106b09:	e9 1a f9 ff ff       	jmp    80106428 <alltraps>

80106b0e <vector15>:
.globl vector15
vector15:
  pushl $0
80106b0e:	6a 00                	push   $0x0
  pushl $15
80106b10:	6a 0f                	push   $0xf
  jmp alltraps
80106b12:	e9 11 f9 ff ff       	jmp    80106428 <alltraps>

80106b17 <vector16>:
.globl vector16
vector16:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $16
80106b19:	6a 10                	push   $0x10
  jmp alltraps
80106b1b:	e9 08 f9 ff ff       	jmp    80106428 <alltraps>

80106b20 <vector17>:
.globl vector17
vector17:
  pushl $17
80106b20:	6a 11                	push   $0x11
  jmp alltraps
80106b22:	e9 01 f9 ff ff       	jmp    80106428 <alltraps>

80106b27 <vector18>:
.globl vector18
vector18:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $18
80106b29:	6a 12                	push   $0x12
  jmp alltraps
80106b2b:	e9 f8 f8 ff ff       	jmp    80106428 <alltraps>

80106b30 <vector19>:
.globl vector19
vector19:
  pushl $0
80106b30:	6a 00                	push   $0x0
  pushl $19
80106b32:	6a 13                	push   $0x13
  jmp alltraps
80106b34:	e9 ef f8 ff ff       	jmp    80106428 <alltraps>

80106b39 <vector20>:
.globl vector20
vector20:
  pushl $0
80106b39:	6a 00                	push   $0x0
  pushl $20
80106b3b:	6a 14                	push   $0x14
  jmp alltraps
80106b3d:	e9 e6 f8 ff ff       	jmp    80106428 <alltraps>

80106b42 <vector21>:
.globl vector21
vector21:
  pushl $0
80106b42:	6a 00                	push   $0x0
  pushl $21
80106b44:	6a 15                	push   $0x15
  jmp alltraps
80106b46:	e9 dd f8 ff ff       	jmp    80106428 <alltraps>

80106b4b <vector22>:
.globl vector22
vector22:
  pushl $0
80106b4b:	6a 00                	push   $0x0
  pushl $22
80106b4d:	6a 16                	push   $0x16
  jmp alltraps
80106b4f:	e9 d4 f8 ff ff       	jmp    80106428 <alltraps>

80106b54 <vector23>:
.globl vector23
vector23:
  pushl $0
80106b54:	6a 00                	push   $0x0
  pushl $23
80106b56:	6a 17                	push   $0x17
  jmp alltraps
80106b58:	e9 cb f8 ff ff       	jmp    80106428 <alltraps>

80106b5d <vector24>:
.globl vector24
vector24:
  pushl $0
80106b5d:	6a 00                	push   $0x0
  pushl $24
80106b5f:	6a 18                	push   $0x18
  jmp alltraps
80106b61:	e9 c2 f8 ff ff       	jmp    80106428 <alltraps>

80106b66 <vector25>:
.globl vector25
vector25:
  pushl $0
80106b66:	6a 00                	push   $0x0
  pushl $25
80106b68:	6a 19                	push   $0x19
  jmp alltraps
80106b6a:	e9 b9 f8 ff ff       	jmp    80106428 <alltraps>

80106b6f <vector26>:
.globl vector26
vector26:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $26
80106b71:	6a 1a                	push   $0x1a
  jmp alltraps
80106b73:	e9 b0 f8 ff ff       	jmp    80106428 <alltraps>

80106b78 <vector27>:
.globl vector27
vector27:
  pushl $0
80106b78:	6a 00                	push   $0x0
  pushl $27
80106b7a:	6a 1b                	push   $0x1b
  jmp alltraps
80106b7c:	e9 a7 f8 ff ff       	jmp    80106428 <alltraps>

80106b81 <vector28>:
.globl vector28
vector28:
  pushl $0
80106b81:	6a 00                	push   $0x0
  pushl $28
80106b83:	6a 1c                	push   $0x1c
  jmp alltraps
80106b85:	e9 9e f8 ff ff       	jmp    80106428 <alltraps>

80106b8a <vector29>:
.globl vector29
vector29:
  pushl $0
80106b8a:	6a 00                	push   $0x0
  pushl $29
80106b8c:	6a 1d                	push   $0x1d
  jmp alltraps
80106b8e:	e9 95 f8 ff ff       	jmp    80106428 <alltraps>

80106b93 <vector30>:
.globl vector30
vector30:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $30
80106b95:	6a 1e                	push   $0x1e
  jmp alltraps
80106b97:	e9 8c f8 ff ff       	jmp    80106428 <alltraps>

80106b9c <vector31>:
.globl vector31
vector31:
  pushl $0
80106b9c:	6a 00                	push   $0x0
  pushl $31
80106b9e:	6a 1f                	push   $0x1f
  jmp alltraps
80106ba0:	e9 83 f8 ff ff       	jmp    80106428 <alltraps>

80106ba5 <vector32>:
.globl vector32
vector32:
  pushl $0
80106ba5:	6a 00                	push   $0x0
  pushl $32
80106ba7:	6a 20                	push   $0x20
  jmp alltraps
80106ba9:	e9 7a f8 ff ff       	jmp    80106428 <alltraps>

80106bae <vector33>:
.globl vector33
vector33:
  pushl $0
80106bae:	6a 00                	push   $0x0
  pushl $33
80106bb0:	6a 21                	push   $0x21
  jmp alltraps
80106bb2:	e9 71 f8 ff ff       	jmp    80106428 <alltraps>

80106bb7 <vector34>:
.globl vector34
vector34:
  pushl $0
80106bb7:	6a 00                	push   $0x0
  pushl $34
80106bb9:	6a 22                	push   $0x22
  jmp alltraps
80106bbb:	e9 68 f8 ff ff       	jmp    80106428 <alltraps>

80106bc0 <vector35>:
.globl vector35
vector35:
  pushl $0
80106bc0:	6a 00                	push   $0x0
  pushl $35
80106bc2:	6a 23                	push   $0x23
  jmp alltraps
80106bc4:	e9 5f f8 ff ff       	jmp    80106428 <alltraps>

80106bc9 <vector36>:
.globl vector36
vector36:
  pushl $0
80106bc9:	6a 00                	push   $0x0
  pushl $36
80106bcb:	6a 24                	push   $0x24
  jmp alltraps
80106bcd:	e9 56 f8 ff ff       	jmp    80106428 <alltraps>

80106bd2 <vector37>:
.globl vector37
vector37:
  pushl $0
80106bd2:	6a 00                	push   $0x0
  pushl $37
80106bd4:	6a 25                	push   $0x25
  jmp alltraps
80106bd6:	e9 4d f8 ff ff       	jmp    80106428 <alltraps>

80106bdb <vector38>:
.globl vector38
vector38:
  pushl $0
80106bdb:	6a 00                	push   $0x0
  pushl $38
80106bdd:	6a 26                	push   $0x26
  jmp alltraps
80106bdf:	e9 44 f8 ff ff       	jmp    80106428 <alltraps>

80106be4 <vector39>:
.globl vector39
vector39:
  pushl $0
80106be4:	6a 00                	push   $0x0
  pushl $39
80106be6:	6a 27                	push   $0x27
  jmp alltraps
80106be8:	e9 3b f8 ff ff       	jmp    80106428 <alltraps>

80106bed <vector40>:
.globl vector40
vector40:
  pushl $0
80106bed:	6a 00                	push   $0x0
  pushl $40
80106bef:	6a 28                	push   $0x28
  jmp alltraps
80106bf1:	e9 32 f8 ff ff       	jmp    80106428 <alltraps>

80106bf6 <vector41>:
.globl vector41
vector41:
  pushl $0
80106bf6:	6a 00                	push   $0x0
  pushl $41
80106bf8:	6a 29                	push   $0x29
  jmp alltraps
80106bfa:	e9 29 f8 ff ff       	jmp    80106428 <alltraps>

80106bff <vector42>:
.globl vector42
vector42:
  pushl $0
80106bff:	6a 00                	push   $0x0
  pushl $42
80106c01:	6a 2a                	push   $0x2a
  jmp alltraps
80106c03:	e9 20 f8 ff ff       	jmp    80106428 <alltraps>

80106c08 <vector43>:
.globl vector43
vector43:
  pushl $0
80106c08:	6a 00                	push   $0x0
  pushl $43
80106c0a:	6a 2b                	push   $0x2b
  jmp alltraps
80106c0c:	e9 17 f8 ff ff       	jmp    80106428 <alltraps>

80106c11 <vector44>:
.globl vector44
vector44:
  pushl $0
80106c11:	6a 00                	push   $0x0
  pushl $44
80106c13:	6a 2c                	push   $0x2c
  jmp alltraps
80106c15:	e9 0e f8 ff ff       	jmp    80106428 <alltraps>

80106c1a <vector45>:
.globl vector45
vector45:
  pushl $0
80106c1a:	6a 00                	push   $0x0
  pushl $45
80106c1c:	6a 2d                	push   $0x2d
  jmp alltraps
80106c1e:	e9 05 f8 ff ff       	jmp    80106428 <alltraps>

80106c23 <vector46>:
.globl vector46
vector46:
  pushl $0
80106c23:	6a 00                	push   $0x0
  pushl $46
80106c25:	6a 2e                	push   $0x2e
  jmp alltraps
80106c27:	e9 fc f7 ff ff       	jmp    80106428 <alltraps>

80106c2c <vector47>:
.globl vector47
vector47:
  pushl $0
80106c2c:	6a 00                	push   $0x0
  pushl $47
80106c2e:	6a 2f                	push   $0x2f
  jmp alltraps
80106c30:	e9 f3 f7 ff ff       	jmp    80106428 <alltraps>

80106c35 <vector48>:
.globl vector48
vector48:
  pushl $0
80106c35:	6a 00                	push   $0x0
  pushl $48
80106c37:	6a 30                	push   $0x30
  jmp alltraps
80106c39:	e9 ea f7 ff ff       	jmp    80106428 <alltraps>

80106c3e <vector49>:
.globl vector49
vector49:
  pushl $0
80106c3e:	6a 00                	push   $0x0
  pushl $49
80106c40:	6a 31                	push   $0x31
  jmp alltraps
80106c42:	e9 e1 f7 ff ff       	jmp    80106428 <alltraps>

80106c47 <vector50>:
.globl vector50
vector50:
  pushl $0
80106c47:	6a 00                	push   $0x0
  pushl $50
80106c49:	6a 32                	push   $0x32
  jmp alltraps
80106c4b:	e9 d8 f7 ff ff       	jmp    80106428 <alltraps>

80106c50 <vector51>:
.globl vector51
vector51:
  pushl $0
80106c50:	6a 00                	push   $0x0
  pushl $51
80106c52:	6a 33                	push   $0x33
  jmp alltraps
80106c54:	e9 cf f7 ff ff       	jmp    80106428 <alltraps>

80106c59 <vector52>:
.globl vector52
vector52:
  pushl $0
80106c59:	6a 00                	push   $0x0
  pushl $52
80106c5b:	6a 34                	push   $0x34
  jmp alltraps
80106c5d:	e9 c6 f7 ff ff       	jmp    80106428 <alltraps>

80106c62 <vector53>:
.globl vector53
vector53:
  pushl $0
80106c62:	6a 00                	push   $0x0
  pushl $53
80106c64:	6a 35                	push   $0x35
  jmp alltraps
80106c66:	e9 bd f7 ff ff       	jmp    80106428 <alltraps>

80106c6b <vector54>:
.globl vector54
vector54:
  pushl $0
80106c6b:	6a 00                	push   $0x0
  pushl $54
80106c6d:	6a 36                	push   $0x36
  jmp alltraps
80106c6f:	e9 b4 f7 ff ff       	jmp    80106428 <alltraps>

80106c74 <vector55>:
.globl vector55
vector55:
  pushl $0
80106c74:	6a 00                	push   $0x0
  pushl $55
80106c76:	6a 37                	push   $0x37
  jmp alltraps
80106c78:	e9 ab f7 ff ff       	jmp    80106428 <alltraps>

80106c7d <vector56>:
.globl vector56
vector56:
  pushl $0
80106c7d:	6a 00                	push   $0x0
  pushl $56
80106c7f:	6a 38                	push   $0x38
  jmp alltraps
80106c81:	e9 a2 f7 ff ff       	jmp    80106428 <alltraps>

80106c86 <vector57>:
.globl vector57
vector57:
  pushl $0
80106c86:	6a 00                	push   $0x0
  pushl $57
80106c88:	6a 39                	push   $0x39
  jmp alltraps
80106c8a:	e9 99 f7 ff ff       	jmp    80106428 <alltraps>

80106c8f <vector58>:
.globl vector58
vector58:
  pushl $0
80106c8f:	6a 00                	push   $0x0
  pushl $58
80106c91:	6a 3a                	push   $0x3a
  jmp alltraps
80106c93:	e9 90 f7 ff ff       	jmp    80106428 <alltraps>

80106c98 <vector59>:
.globl vector59
vector59:
  pushl $0
80106c98:	6a 00                	push   $0x0
  pushl $59
80106c9a:	6a 3b                	push   $0x3b
  jmp alltraps
80106c9c:	e9 87 f7 ff ff       	jmp    80106428 <alltraps>

80106ca1 <vector60>:
.globl vector60
vector60:
  pushl $0
80106ca1:	6a 00                	push   $0x0
  pushl $60
80106ca3:	6a 3c                	push   $0x3c
  jmp alltraps
80106ca5:	e9 7e f7 ff ff       	jmp    80106428 <alltraps>

80106caa <vector61>:
.globl vector61
vector61:
  pushl $0
80106caa:	6a 00                	push   $0x0
  pushl $61
80106cac:	6a 3d                	push   $0x3d
  jmp alltraps
80106cae:	e9 75 f7 ff ff       	jmp    80106428 <alltraps>

80106cb3 <vector62>:
.globl vector62
vector62:
  pushl $0
80106cb3:	6a 00                	push   $0x0
  pushl $62
80106cb5:	6a 3e                	push   $0x3e
  jmp alltraps
80106cb7:	e9 6c f7 ff ff       	jmp    80106428 <alltraps>

80106cbc <vector63>:
.globl vector63
vector63:
  pushl $0
80106cbc:	6a 00                	push   $0x0
  pushl $63
80106cbe:	6a 3f                	push   $0x3f
  jmp alltraps
80106cc0:	e9 63 f7 ff ff       	jmp    80106428 <alltraps>

80106cc5 <vector64>:
.globl vector64
vector64:
  pushl $0
80106cc5:	6a 00                	push   $0x0
  pushl $64
80106cc7:	6a 40                	push   $0x40
  jmp alltraps
80106cc9:	e9 5a f7 ff ff       	jmp    80106428 <alltraps>

80106cce <vector65>:
.globl vector65
vector65:
  pushl $0
80106cce:	6a 00                	push   $0x0
  pushl $65
80106cd0:	6a 41                	push   $0x41
  jmp alltraps
80106cd2:	e9 51 f7 ff ff       	jmp    80106428 <alltraps>

80106cd7 <vector66>:
.globl vector66
vector66:
  pushl $0
80106cd7:	6a 00                	push   $0x0
  pushl $66
80106cd9:	6a 42                	push   $0x42
  jmp alltraps
80106cdb:	e9 48 f7 ff ff       	jmp    80106428 <alltraps>

80106ce0 <vector67>:
.globl vector67
vector67:
  pushl $0
80106ce0:	6a 00                	push   $0x0
  pushl $67
80106ce2:	6a 43                	push   $0x43
  jmp alltraps
80106ce4:	e9 3f f7 ff ff       	jmp    80106428 <alltraps>

80106ce9 <vector68>:
.globl vector68
vector68:
  pushl $0
80106ce9:	6a 00                	push   $0x0
  pushl $68
80106ceb:	6a 44                	push   $0x44
  jmp alltraps
80106ced:	e9 36 f7 ff ff       	jmp    80106428 <alltraps>

80106cf2 <vector69>:
.globl vector69
vector69:
  pushl $0
80106cf2:	6a 00                	push   $0x0
  pushl $69
80106cf4:	6a 45                	push   $0x45
  jmp alltraps
80106cf6:	e9 2d f7 ff ff       	jmp    80106428 <alltraps>

80106cfb <vector70>:
.globl vector70
vector70:
  pushl $0
80106cfb:	6a 00                	push   $0x0
  pushl $70
80106cfd:	6a 46                	push   $0x46
  jmp alltraps
80106cff:	e9 24 f7 ff ff       	jmp    80106428 <alltraps>

80106d04 <vector71>:
.globl vector71
vector71:
  pushl $0
80106d04:	6a 00                	push   $0x0
  pushl $71
80106d06:	6a 47                	push   $0x47
  jmp alltraps
80106d08:	e9 1b f7 ff ff       	jmp    80106428 <alltraps>

80106d0d <vector72>:
.globl vector72
vector72:
  pushl $0
80106d0d:	6a 00                	push   $0x0
  pushl $72
80106d0f:	6a 48                	push   $0x48
  jmp alltraps
80106d11:	e9 12 f7 ff ff       	jmp    80106428 <alltraps>

80106d16 <vector73>:
.globl vector73
vector73:
  pushl $0
80106d16:	6a 00                	push   $0x0
  pushl $73
80106d18:	6a 49                	push   $0x49
  jmp alltraps
80106d1a:	e9 09 f7 ff ff       	jmp    80106428 <alltraps>

80106d1f <vector74>:
.globl vector74
vector74:
  pushl $0
80106d1f:	6a 00                	push   $0x0
  pushl $74
80106d21:	6a 4a                	push   $0x4a
  jmp alltraps
80106d23:	e9 00 f7 ff ff       	jmp    80106428 <alltraps>

80106d28 <vector75>:
.globl vector75
vector75:
  pushl $0
80106d28:	6a 00                	push   $0x0
  pushl $75
80106d2a:	6a 4b                	push   $0x4b
  jmp alltraps
80106d2c:	e9 f7 f6 ff ff       	jmp    80106428 <alltraps>

80106d31 <vector76>:
.globl vector76
vector76:
  pushl $0
80106d31:	6a 00                	push   $0x0
  pushl $76
80106d33:	6a 4c                	push   $0x4c
  jmp alltraps
80106d35:	e9 ee f6 ff ff       	jmp    80106428 <alltraps>

80106d3a <vector77>:
.globl vector77
vector77:
  pushl $0
80106d3a:	6a 00                	push   $0x0
  pushl $77
80106d3c:	6a 4d                	push   $0x4d
  jmp alltraps
80106d3e:	e9 e5 f6 ff ff       	jmp    80106428 <alltraps>

80106d43 <vector78>:
.globl vector78
vector78:
  pushl $0
80106d43:	6a 00                	push   $0x0
  pushl $78
80106d45:	6a 4e                	push   $0x4e
  jmp alltraps
80106d47:	e9 dc f6 ff ff       	jmp    80106428 <alltraps>

80106d4c <vector79>:
.globl vector79
vector79:
  pushl $0
80106d4c:	6a 00                	push   $0x0
  pushl $79
80106d4e:	6a 4f                	push   $0x4f
  jmp alltraps
80106d50:	e9 d3 f6 ff ff       	jmp    80106428 <alltraps>

80106d55 <vector80>:
.globl vector80
vector80:
  pushl $0
80106d55:	6a 00                	push   $0x0
  pushl $80
80106d57:	6a 50                	push   $0x50
  jmp alltraps
80106d59:	e9 ca f6 ff ff       	jmp    80106428 <alltraps>

80106d5e <vector81>:
.globl vector81
vector81:
  pushl $0
80106d5e:	6a 00                	push   $0x0
  pushl $81
80106d60:	6a 51                	push   $0x51
  jmp alltraps
80106d62:	e9 c1 f6 ff ff       	jmp    80106428 <alltraps>

80106d67 <vector82>:
.globl vector82
vector82:
  pushl $0
80106d67:	6a 00                	push   $0x0
  pushl $82
80106d69:	6a 52                	push   $0x52
  jmp alltraps
80106d6b:	e9 b8 f6 ff ff       	jmp    80106428 <alltraps>

80106d70 <vector83>:
.globl vector83
vector83:
  pushl $0
80106d70:	6a 00                	push   $0x0
  pushl $83
80106d72:	6a 53                	push   $0x53
  jmp alltraps
80106d74:	e9 af f6 ff ff       	jmp    80106428 <alltraps>

80106d79 <vector84>:
.globl vector84
vector84:
  pushl $0
80106d79:	6a 00                	push   $0x0
  pushl $84
80106d7b:	6a 54                	push   $0x54
  jmp alltraps
80106d7d:	e9 a6 f6 ff ff       	jmp    80106428 <alltraps>

80106d82 <vector85>:
.globl vector85
vector85:
  pushl $0
80106d82:	6a 00                	push   $0x0
  pushl $85
80106d84:	6a 55                	push   $0x55
  jmp alltraps
80106d86:	e9 9d f6 ff ff       	jmp    80106428 <alltraps>

80106d8b <vector86>:
.globl vector86
vector86:
  pushl $0
80106d8b:	6a 00                	push   $0x0
  pushl $86
80106d8d:	6a 56                	push   $0x56
  jmp alltraps
80106d8f:	e9 94 f6 ff ff       	jmp    80106428 <alltraps>

80106d94 <vector87>:
.globl vector87
vector87:
  pushl $0
80106d94:	6a 00                	push   $0x0
  pushl $87
80106d96:	6a 57                	push   $0x57
  jmp alltraps
80106d98:	e9 8b f6 ff ff       	jmp    80106428 <alltraps>

80106d9d <vector88>:
.globl vector88
vector88:
  pushl $0
80106d9d:	6a 00                	push   $0x0
  pushl $88
80106d9f:	6a 58                	push   $0x58
  jmp alltraps
80106da1:	e9 82 f6 ff ff       	jmp    80106428 <alltraps>

80106da6 <vector89>:
.globl vector89
vector89:
  pushl $0
80106da6:	6a 00                	push   $0x0
  pushl $89
80106da8:	6a 59                	push   $0x59
  jmp alltraps
80106daa:	e9 79 f6 ff ff       	jmp    80106428 <alltraps>

80106daf <vector90>:
.globl vector90
vector90:
  pushl $0
80106daf:	6a 00                	push   $0x0
  pushl $90
80106db1:	6a 5a                	push   $0x5a
  jmp alltraps
80106db3:	e9 70 f6 ff ff       	jmp    80106428 <alltraps>

80106db8 <vector91>:
.globl vector91
vector91:
  pushl $0
80106db8:	6a 00                	push   $0x0
  pushl $91
80106dba:	6a 5b                	push   $0x5b
  jmp alltraps
80106dbc:	e9 67 f6 ff ff       	jmp    80106428 <alltraps>

80106dc1 <vector92>:
.globl vector92
vector92:
  pushl $0
80106dc1:	6a 00                	push   $0x0
  pushl $92
80106dc3:	6a 5c                	push   $0x5c
  jmp alltraps
80106dc5:	e9 5e f6 ff ff       	jmp    80106428 <alltraps>

80106dca <vector93>:
.globl vector93
vector93:
  pushl $0
80106dca:	6a 00                	push   $0x0
  pushl $93
80106dcc:	6a 5d                	push   $0x5d
  jmp alltraps
80106dce:	e9 55 f6 ff ff       	jmp    80106428 <alltraps>

80106dd3 <vector94>:
.globl vector94
vector94:
  pushl $0
80106dd3:	6a 00                	push   $0x0
  pushl $94
80106dd5:	6a 5e                	push   $0x5e
  jmp alltraps
80106dd7:	e9 4c f6 ff ff       	jmp    80106428 <alltraps>

80106ddc <vector95>:
.globl vector95
vector95:
  pushl $0
80106ddc:	6a 00                	push   $0x0
  pushl $95
80106dde:	6a 5f                	push   $0x5f
  jmp alltraps
80106de0:	e9 43 f6 ff ff       	jmp    80106428 <alltraps>

80106de5 <vector96>:
.globl vector96
vector96:
  pushl $0
80106de5:	6a 00                	push   $0x0
  pushl $96
80106de7:	6a 60                	push   $0x60
  jmp alltraps
80106de9:	e9 3a f6 ff ff       	jmp    80106428 <alltraps>

80106dee <vector97>:
.globl vector97
vector97:
  pushl $0
80106dee:	6a 00                	push   $0x0
  pushl $97
80106df0:	6a 61                	push   $0x61
  jmp alltraps
80106df2:	e9 31 f6 ff ff       	jmp    80106428 <alltraps>

80106df7 <vector98>:
.globl vector98
vector98:
  pushl $0
80106df7:	6a 00                	push   $0x0
  pushl $98
80106df9:	6a 62                	push   $0x62
  jmp alltraps
80106dfb:	e9 28 f6 ff ff       	jmp    80106428 <alltraps>

80106e00 <vector99>:
.globl vector99
vector99:
  pushl $0
80106e00:	6a 00                	push   $0x0
  pushl $99
80106e02:	6a 63                	push   $0x63
  jmp alltraps
80106e04:	e9 1f f6 ff ff       	jmp    80106428 <alltraps>

80106e09 <vector100>:
.globl vector100
vector100:
  pushl $0
80106e09:	6a 00                	push   $0x0
  pushl $100
80106e0b:	6a 64                	push   $0x64
  jmp alltraps
80106e0d:	e9 16 f6 ff ff       	jmp    80106428 <alltraps>

80106e12 <vector101>:
.globl vector101
vector101:
  pushl $0
80106e12:	6a 00                	push   $0x0
  pushl $101
80106e14:	6a 65                	push   $0x65
  jmp alltraps
80106e16:	e9 0d f6 ff ff       	jmp    80106428 <alltraps>

80106e1b <vector102>:
.globl vector102
vector102:
  pushl $0
80106e1b:	6a 00                	push   $0x0
  pushl $102
80106e1d:	6a 66                	push   $0x66
  jmp alltraps
80106e1f:	e9 04 f6 ff ff       	jmp    80106428 <alltraps>

80106e24 <vector103>:
.globl vector103
vector103:
  pushl $0
80106e24:	6a 00                	push   $0x0
  pushl $103
80106e26:	6a 67                	push   $0x67
  jmp alltraps
80106e28:	e9 fb f5 ff ff       	jmp    80106428 <alltraps>

80106e2d <vector104>:
.globl vector104
vector104:
  pushl $0
80106e2d:	6a 00                	push   $0x0
  pushl $104
80106e2f:	6a 68                	push   $0x68
  jmp alltraps
80106e31:	e9 f2 f5 ff ff       	jmp    80106428 <alltraps>

80106e36 <vector105>:
.globl vector105
vector105:
  pushl $0
80106e36:	6a 00                	push   $0x0
  pushl $105
80106e38:	6a 69                	push   $0x69
  jmp alltraps
80106e3a:	e9 e9 f5 ff ff       	jmp    80106428 <alltraps>

80106e3f <vector106>:
.globl vector106
vector106:
  pushl $0
80106e3f:	6a 00                	push   $0x0
  pushl $106
80106e41:	6a 6a                	push   $0x6a
  jmp alltraps
80106e43:	e9 e0 f5 ff ff       	jmp    80106428 <alltraps>

80106e48 <vector107>:
.globl vector107
vector107:
  pushl $0
80106e48:	6a 00                	push   $0x0
  pushl $107
80106e4a:	6a 6b                	push   $0x6b
  jmp alltraps
80106e4c:	e9 d7 f5 ff ff       	jmp    80106428 <alltraps>

80106e51 <vector108>:
.globl vector108
vector108:
  pushl $0
80106e51:	6a 00                	push   $0x0
  pushl $108
80106e53:	6a 6c                	push   $0x6c
  jmp alltraps
80106e55:	e9 ce f5 ff ff       	jmp    80106428 <alltraps>

80106e5a <vector109>:
.globl vector109
vector109:
  pushl $0
80106e5a:	6a 00                	push   $0x0
  pushl $109
80106e5c:	6a 6d                	push   $0x6d
  jmp alltraps
80106e5e:	e9 c5 f5 ff ff       	jmp    80106428 <alltraps>

80106e63 <vector110>:
.globl vector110
vector110:
  pushl $0
80106e63:	6a 00                	push   $0x0
  pushl $110
80106e65:	6a 6e                	push   $0x6e
  jmp alltraps
80106e67:	e9 bc f5 ff ff       	jmp    80106428 <alltraps>

80106e6c <vector111>:
.globl vector111
vector111:
  pushl $0
80106e6c:	6a 00                	push   $0x0
  pushl $111
80106e6e:	6a 6f                	push   $0x6f
  jmp alltraps
80106e70:	e9 b3 f5 ff ff       	jmp    80106428 <alltraps>

80106e75 <vector112>:
.globl vector112
vector112:
  pushl $0
80106e75:	6a 00                	push   $0x0
  pushl $112
80106e77:	6a 70                	push   $0x70
  jmp alltraps
80106e79:	e9 aa f5 ff ff       	jmp    80106428 <alltraps>

80106e7e <vector113>:
.globl vector113
vector113:
  pushl $0
80106e7e:	6a 00                	push   $0x0
  pushl $113
80106e80:	6a 71                	push   $0x71
  jmp alltraps
80106e82:	e9 a1 f5 ff ff       	jmp    80106428 <alltraps>

80106e87 <vector114>:
.globl vector114
vector114:
  pushl $0
80106e87:	6a 00                	push   $0x0
  pushl $114
80106e89:	6a 72                	push   $0x72
  jmp alltraps
80106e8b:	e9 98 f5 ff ff       	jmp    80106428 <alltraps>

80106e90 <vector115>:
.globl vector115
vector115:
  pushl $0
80106e90:	6a 00                	push   $0x0
  pushl $115
80106e92:	6a 73                	push   $0x73
  jmp alltraps
80106e94:	e9 8f f5 ff ff       	jmp    80106428 <alltraps>

80106e99 <vector116>:
.globl vector116
vector116:
  pushl $0
80106e99:	6a 00                	push   $0x0
  pushl $116
80106e9b:	6a 74                	push   $0x74
  jmp alltraps
80106e9d:	e9 86 f5 ff ff       	jmp    80106428 <alltraps>

80106ea2 <vector117>:
.globl vector117
vector117:
  pushl $0
80106ea2:	6a 00                	push   $0x0
  pushl $117
80106ea4:	6a 75                	push   $0x75
  jmp alltraps
80106ea6:	e9 7d f5 ff ff       	jmp    80106428 <alltraps>

80106eab <vector118>:
.globl vector118
vector118:
  pushl $0
80106eab:	6a 00                	push   $0x0
  pushl $118
80106ead:	6a 76                	push   $0x76
  jmp alltraps
80106eaf:	e9 74 f5 ff ff       	jmp    80106428 <alltraps>

80106eb4 <vector119>:
.globl vector119
vector119:
  pushl $0
80106eb4:	6a 00                	push   $0x0
  pushl $119
80106eb6:	6a 77                	push   $0x77
  jmp alltraps
80106eb8:	e9 6b f5 ff ff       	jmp    80106428 <alltraps>

80106ebd <vector120>:
.globl vector120
vector120:
  pushl $0
80106ebd:	6a 00                	push   $0x0
  pushl $120
80106ebf:	6a 78                	push   $0x78
  jmp alltraps
80106ec1:	e9 62 f5 ff ff       	jmp    80106428 <alltraps>

80106ec6 <vector121>:
.globl vector121
vector121:
  pushl $0
80106ec6:	6a 00                	push   $0x0
  pushl $121
80106ec8:	6a 79                	push   $0x79
  jmp alltraps
80106eca:	e9 59 f5 ff ff       	jmp    80106428 <alltraps>

80106ecf <vector122>:
.globl vector122
vector122:
  pushl $0
80106ecf:	6a 00                	push   $0x0
  pushl $122
80106ed1:	6a 7a                	push   $0x7a
  jmp alltraps
80106ed3:	e9 50 f5 ff ff       	jmp    80106428 <alltraps>

80106ed8 <vector123>:
.globl vector123
vector123:
  pushl $0
80106ed8:	6a 00                	push   $0x0
  pushl $123
80106eda:	6a 7b                	push   $0x7b
  jmp alltraps
80106edc:	e9 47 f5 ff ff       	jmp    80106428 <alltraps>

80106ee1 <vector124>:
.globl vector124
vector124:
  pushl $0
80106ee1:	6a 00                	push   $0x0
  pushl $124
80106ee3:	6a 7c                	push   $0x7c
  jmp alltraps
80106ee5:	e9 3e f5 ff ff       	jmp    80106428 <alltraps>

80106eea <vector125>:
.globl vector125
vector125:
  pushl $0
80106eea:	6a 00                	push   $0x0
  pushl $125
80106eec:	6a 7d                	push   $0x7d
  jmp alltraps
80106eee:	e9 35 f5 ff ff       	jmp    80106428 <alltraps>

80106ef3 <vector126>:
.globl vector126
vector126:
  pushl $0
80106ef3:	6a 00                	push   $0x0
  pushl $126
80106ef5:	6a 7e                	push   $0x7e
  jmp alltraps
80106ef7:	e9 2c f5 ff ff       	jmp    80106428 <alltraps>

80106efc <vector127>:
.globl vector127
vector127:
  pushl $0
80106efc:	6a 00                	push   $0x0
  pushl $127
80106efe:	6a 7f                	push   $0x7f
  jmp alltraps
80106f00:	e9 23 f5 ff ff       	jmp    80106428 <alltraps>

80106f05 <vector128>:
.globl vector128
vector128:
  pushl $0
80106f05:	6a 00                	push   $0x0
  pushl $128
80106f07:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106f0c:	e9 17 f5 ff ff       	jmp    80106428 <alltraps>

80106f11 <vector129>:
.globl vector129
vector129:
  pushl $0
80106f11:	6a 00                	push   $0x0
  pushl $129
80106f13:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106f18:	e9 0b f5 ff ff       	jmp    80106428 <alltraps>

80106f1d <vector130>:
.globl vector130
vector130:
  pushl $0
80106f1d:	6a 00                	push   $0x0
  pushl $130
80106f1f:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106f24:	e9 ff f4 ff ff       	jmp    80106428 <alltraps>

80106f29 <vector131>:
.globl vector131
vector131:
  pushl $0
80106f29:	6a 00                	push   $0x0
  pushl $131
80106f2b:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106f30:	e9 f3 f4 ff ff       	jmp    80106428 <alltraps>

80106f35 <vector132>:
.globl vector132
vector132:
  pushl $0
80106f35:	6a 00                	push   $0x0
  pushl $132
80106f37:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106f3c:	e9 e7 f4 ff ff       	jmp    80106428 <alltraps>

80106f41 <vector133>:
.globl vector133
vector133:
  pushl $0
80106f41:	6a 00                	push   $0x0
  pushl $133
80106f43:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106f48:	e9 db f4 ff ff       	jmp    80106428 <alltraps>

80106f4d <vector134>:
.globl vector134
vector134:
  pushl $0
80106f4d:	6a 00                	push   $0x0
  pushl $134
80106f4f:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106f54:	e9 cf f4 ff ff       	jmp    80106428 <alltraps>

80106f59 <vector135>:
.globl vector135
vector135:
  pushl $0
80106f59:	6a 00                	push   $0x0
  pushl $135
80106f5b:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106f60:	e9 c3 f4 ff ff       	jmp    80106428 <alltraps>

80106f65 <vector136>:
.globl vector136
vector136:
  pushl $0
80106f65:	6a 00                	push   $0x0
  pushl $136
80106f67:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106f6c:	e9 b7 f4 ff ff       	jmp    80106428 <alltraps>

80106f71 <vector137>:
.globl vector137
vector137:
  pushl $0
80106f71:	6a 00                	push   $0x0
  pushl $137
80106f73:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106f78:	e9 ab f4 ff ff       	jmp    80106428 <alltraps>

80106f7d <vector138>:
.globl vector138
vector138:
  pushl $0
80106f7d:	6a 00                	push   $0x0
  pushl $138
80106f7f:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106f84:	e9 9f f4 ff ff       	jmp    80106428 <alltraps>

80106f89 <vector139>:
.globl vector139
vector139:
  pushl $0
80106f89:	6a 00                	push   $0x0
  pushl $139
80106f8b:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106f90:	e9 93 f4 ff ff       	jmp    80106428 <alltraps>

80106f95 <vector140>:
.globl vector140
vector140:
  pushl $0
80106f95:	6a 00                	push   $0x0
  pushl $140
80106f97:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106f9c:	e9 87 f4 ff ff       	jmp    80106428 <alltraps>

80106fa1 <vector141>:
.globl vector141
vector141:
  pushl $0
80106fa1:	6a 00                	push   $0x0
  pushl $141
80106fa3:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106fa8:	e9 7b f4 ff ff       	jmp    80106428 <alltraps>

80106fad <vector142>:
.globl vector142
vector142:
  pushl $0
80106fad:	6a 00                	push   $0x0
  pushl $142
80106faf:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106fb4:	e9 6f f4 ff ff       	jmp    80106428 <alltraps>

80106fb9 <vector143>:
.globl vector143
vector143:
  pushl $0
80106fb9:	6a 00                	push   $0x0
  pushl $143
80106fbb:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106fc0:	e9 63 f4 ff ff       	jmp    80106428 <alltraps>

80106fc5 <vector144>:
.globl vector144
vector144:
  pushl $0
80106fc5:	6a 00                	push   $0x0
  pushl $144
80106fc7:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106fcc:	e9 57 f4 ff ff       	jmp    80106428 <alltraps>

80106fd1 <vector145>:
.globl vector145
vector145:
  pushl $0
80106fd1:	6a 00                	push   $0x0
  pushl $145
80106fd3:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106fd8:	e9 4b f4 ff ff       	jmp    80106428 <alltraps>

80106fdd <vector146>:
.globl vector146
vector146:
  pushl $0
80106fdd:	6a 00                	push   $0x0
  pushl $146
80106fdf:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106fe4:	e9 3f f4 ff ff       	jmp    80106428 <alltraps>

80106fe9 <vector147>:
.globl vector147
vector147:
  pushl $0
80106fe9:	6a 00                	push   $0x0
  pushl $147
80106feb:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106ff0:	e9 33 f4 ff ff       	jmp    80106428 <alltraps>

80106ff5 <vector148>:
.globl vector148
vector148:
  pushl $0
80106ff5:	6a 00                	push   $0x0
  pushl $148
80106ff7:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106ffc:	e9 27 f4 ff ff       	jmp    80106428 <alltraps>

80107001 <vector149>:
.globl vector149
vector149:
  pushl $0
80107001:	6a 00                	push   $0x0
  pushl $149
80107003:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107008:	e9 1b f4 ff ff       	jmp    80106428 <alltraps>

8010700d <vector150>:
.globl vector150
vector150:
  pushl $0
8010700d:	6a 00                	push   $0x0
  pushl $150
8010700f:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107014:	e9 0f f4 ff ff       	jmp    80106428 <alltraps>

80107019 <vector151>:
.globl vector151
vector151:
  pushl $0
80107019:	6a 00                	push   $0x0
  pushl $151
8010701b:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107020:	e9 03 f4 ff ff       	jmp    80106428 <alltraps>

80107025 <vector152>:
.globl vector152
vector152:
  pushl $0
80107025:	6a 00                	push   $0x0
  pushl $152
80107027:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010702c:	e9 f7 f3 ff ff       	jmp    80106428 <alltraps>

80107031 <vector153>:
.globl vector153
vector153:
  pushl $0
80107031:	6a 00                	push   $0x0
  pushl $153
80107033:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80107038:	e9 eb f3 ff ff       	jmp    80106428 <alltraps>

8010703d <vector154>:
.globl vector154
vector154:
  pushl $0
8010703d:	6a 00                	push   $0x0
  pushl $154
8010703f:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107044:	e9 df f3 ff ff       	jmp    80106428 <alltraps>

80107049 <vector155>:
.globl vector155
vector155:
  pushl $0
80107049:	6a 00                	push   $0x0
  pushl $155
8010704b:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107050:	e9 d3 f3 ff ff       	jmp    80106428 <alltraps>

80107055 <vector156>:
.globl vector156
vector156:
  pushl $0
80107055:	6a 00                	push   $0x0
  pushl $156
80107057:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010705c:	e9 c7 f3 ff ff       	jmp    80106428 <alltraps>

80107061 <vector157>:
.globl vector157
vector157:
  pushl $0
80107061:	6a 00                	push   $0x0
  pushl $157
80107063:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107068:	e9 bb f3 ff ff       	jmp    80106428 <alltraps>

8010706d <vector158>:
.globl vector158
vector158:
  pushl $0
8010706d:	6a 00                	push   $0x0
  pushl $158
8010706f:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107074:	e9 af f3 ff ff       	jmp    80106428 <alltraps>

80107079 <vector159>:
.globl vector159
vector159:
  pushl $0
80107079:	6a 00                	push   $0x0
  pushl $159
8010707b:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107080:	e9 a3 f3 ff ff       	jmp    80106428 <alltraps>

80107085 <vector160>:
.globl vector160
vector160:
  pushl $0
80107085:	6a 00                	push   $0x0
  pushl $160
80107087:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010708c:	e9 97 f3 ff ff       	jmp    80106428 <alltraps>

80107091 <vector161>:
.globl vector161
vector161:
  pushl $0
80107091:	6a 00                	push   $0x0
  pushl $161
80107093:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107098:	e9 8b f3 ff ff       	jmp    80106428 <alltraps>

8010709d <vector162>:
.globl vector162
vector162:
  pushl $0
8010709d:	6a 00                	push   $0x0
  pushl $162
8010709f:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801070a4:	e9 7f f3 ff ff       	jmp    80106428 <alltraps>

801070a9 <vector163>:
.globl vector163
vector163:
  pushl $0
801070a9:	6a 00                	push   $0x0
  pushl $163
801070ab:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801070b0:	e9 73 f3 ff ff       	jmp    80106428 <alltraps>

801070b5 <vector164>:
.globl vector164
vector164:
  pushl $0
801070b5:	6a 00                	push   $0x0
  pushl $164
801070b7:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801070bc:	e9 67 f3 ff ff       	jmp    80106428 <alltraps>

801070c1 <vector165>:
.globl vector165
vector165:
  pushl $0
801070c1:	6a 00                	push   $0x0
  pushl $165
801070c3:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801070c8:	e9 5b f3 ff ff       	jmp    80106428 <alltraps>

801070cd <vector166>:
.globl vector166
vector166:
  pushl $0
801070cd:	6a 00                	push   $0x0
  pushl $166
801070cf:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801070d4:	e9 4f f3 ff ff       	jmp    80106428 <alltraps>

801070d9 <vector167>:
.globl vector167
vector167:
  pushl $0
801070d9:	6a 00                	push   $0x0
  pushl $167
801070db:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801070e0:	e9 43 f3 ff ff       	jmp    80106428 <alltraps>

801070e5 <vector168>:
.globl vector168
vector168:
  pushl $0
801070e5:	6a 00                	push   $0x0
  pushl $168
801070e7:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801070ec:	e9 37 f3 ff ff       	jmp    80106428 <alltraps>

801070f1 <vector169>:
.globl vector169
vector169:
  pushl $0
801070f1:	6a 00                	push   $0x0
  pushl $169
801070f3:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801070f8:	e9 2b f3 ff ff       	jmp    80106428 <alltraps>

801070fd <vector170>:
.globl vector170
vector170:
  pushl $0
801070fd:	6a 00                	push   $0x0
  pushl $170
801070ff:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107104:	e9 1f f3 ff ff       	jmp    80106428 <alltraps>

80107109 <vector171>:
.globl vector171
vector171:
  pushl $0
80107109:	6a 00                	push   $0x0
  pushl $171
8010710b:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107110:	e9 13 f3 ff ff       	jmp    80106428 <alltraps>

80107115 <vector172>:
.globl vector172
vector172:
  pushl $0
80107115:	6a 00                	push   $0x0
  pushl $172
80107117:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010711c:	e9 07 f3 ff ff       	jmp    80106428 <alltraps>

80107121 <vector173>:
.globl vector173
vector173:
  pushl $0
80107121:	6a 00                	push   $0x0
  pushl $173
80107123:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107128:	e9 fb f2 ff ff       	jmp    80106428 <alltraps>

8010712d <vector174>:
.globl vector174
vector174:
  pushl $0
8010712d:	6a 00                	push   $0x0
  pushl $174
8010712f:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107134:	e9 ef f2 ff ff       	jmp    80106428 <alltraps>

80107139 <vector175>:
.globl vector175
vector175:
  pushl $0
80107139:	6a 00                	push   $0x0
  pushl $175
8010713b:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107140:	e9 e3 f2 ff ff       	jmp    80106428 <alltraps>

80107145 <vector176>:
.globl vector176
vector176:
  pushl $0
80107145:	6a 00                	push   $0x0
  pushl $176
80107147:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010714c:	e9 d7 f2 ff ff       	jmp    80106428 <alltraps>

80107151 <vector177>:
.globl vector177
vector177:
  pushl $0
80107151:	6a 00                	push   $0x0
  pushl $177
80107153:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107158:	e9 cb f2 ff ff       	jmp    80106428 <alltraps>

8010715d <vector178>:
.globl vector178
vector178:
  pushl $0
8010715d:	6a 00                	push   $0x0
  pushl $178
8010715f:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107164:	e9 bf f2 ff ff       	jmp    80106428 <alltraps>

80107169 <vector179>:
.globl vector179
vector179:
  pushl $0
80107169:	6a 00                	push   $0x0
  pushl $179
8010716b:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107170:	e9 b3 f2 ff ff       	jmp    80106428 <alltraps>

80107175 <vector180>:
.globl vector180
vector180:
  pushl $0
80107175:	6a 00                	push   $0x0
  pushl $180
80107177:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010717c:	e9 a7 f2 ff ff       	jmp    80106428 <alltraps>

80107181 <vector181>:
.globl vector181
vector181:
  pushl $0
80107181:	6a 00                	push   $0x0
  pushl $181
80107183:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107188:	e9 9b f2 ff ff       	jmp    80106428 <alltraps>

8010718d <vector182>:
.globl vector182
vector182:
  pushl $0
8010718d:	6a 00                	push   $0x0
  pushl $182
8010718f:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107194:	e9 8f f2 ff ff       	jmp    80106428 <alltraps>

80107199 <vector183>:
.globl vector183
vector183:
  pushl $0
80107199:	6a 00                	push   $0x0
  pushl $183
8010719b:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801071a0:	e9 83 f2 ff ff       	jmp    80106428 <alltraps>

801071a5 <vector184>:
.globl vector184
vector184:
  pushl $0
801071a5:	6a 00                	push   $0x0
  pushl $184
801071a7:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801071ac:	e9 77 f2 ff ff       	jmp    80106428 <alltraps>

801071b1 <vector185>:
.globl vector185
vector185:
  pushl $0
801071b1:	6a 00                	push   $0x0
  pushl $185
801071b3:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801071b8:	e9 6b f2 ff ff       	jmp    80106428 <alltraps>

801071bd <vector186>:
.globl vector186
vector186:
  pushl $0
801071bd:	6a 00                	push   $0x0
  pushl $186
801071bf:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801071c4:	e9 5f f2 ff ff       	jmp    80106428 <alltraps>

801071c9 <vector187>:
.globl vector187
vector187:
  pushl $0
801071c9:	6a 00                	push   $0x0
  pushl $187
801071cb:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801071d0:	e9 53 f2 ff ff       	jmp    80106428 <alltraps>

801071d5 <vector188>:
.globl vector188
vector188:
  pushl $0
801071d5:	6a 00                	push   $0x0
  pushl $188
801071d7:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801071dc:	e9 47 f2 ff ff       	jmp    80106428 <alltraps>

801071e1 <vector189>:
.globl vector189
vector189:
  pushl $0
801071e1:	6a 00                	push   $0x0
  pushl $189
801071e3:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801071e8:	e9 3b f2 ff ff       	jmp    80106428 <alltraps>

801071ed <vector190>:
.globl vector190
vector190:
  pushl $0
801071ed:	6a 00                	push   $0x0
  pushl $190
801071ef:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801071f4:	e9 2f f2 ff ff       	jmp    80106428 <alltraps>

801071f9 <vector191>:
.globl vector191
vector191:
  pushl $0
801071f9:	6a 00                	push   $0x0
  pushl $191
801071fb:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107200:	e9 23 f2 ff ff       	jmp    80106428 <alltraps>

80107205 <vector192>:
.globl vector192
vector192:
  pushl $0
80107205:	6a 00                	push   $0x0
  pushl $192
80107207:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010720c:	e9 17 f2 ff ff       	jmp    80106428 <alltraps>

80107211 <vector193>:
.globl vector193
vector193:
  pushl $0
80107211:	6a 00                	push   $0x0
  pushl $193
80107213:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107218:	e9 0b f2 ff ff       	jmp    80106428 <alltraps>

8010721d <vector194>:
.globl vector194
vector194:
  pushl $0
8010721d:	6a 00                	push   $0x0
  pushl $194
8010721f:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107224:	e9 ff f1 ff ff       	jmp    80106428 <alltraps>

80107229 <vector195>:
.globl vector195
vector195:
  pushl $0
80107229:	6a 00                	push   $0x0
  pushl $195
8010722b:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107230:	e9 f3 f1 ff ff       	jmp    80106428 <alltraps>

80107235 <vector196>:
.globl vector196
vector196:
  pushl $0
80107235:	6a 00                	push   $0x0
  pushl $196
80107237:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010723c:	e9 e7 f1 ff ff       	jmp    80106428 <alltraps>

80107241 <vector197>:
.globl vector197
vector197:
  pushl $0
80107241:	6a 00                	push   $0x0
  pushl $197
80107243:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107248:	e9 db f1 ff ff       	jmp    80106428 <alltraps>

8010724d <vector198>:
.globl vector198
vector198:
  pushl $0
8010724d:	6a 00                	push   $0x0
  pushl $198
8010724f:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107254:	e9 cf f1 ff ff       	jmp    80106428 <alltraps>

80107259 <vector199>:
.globl vector199
vector199:
  pushl $0
80107259:	6a 00                	push   $0x0
  pushl $199
8010725b:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107260:	e9 c3 f1 ff ff       	jmp    80106428 <alltraps>

80107265 <vector200>:
.globl vector200
vector200:
  pushl $0
80107265:	6a 00                	push   $0x0
  pushl $200
80107267:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010726c:	e9 b7 f1 ff ff       	jmp    80106428 <alltraps>

80107271 <vector201>:
.globl vector201
vector201:
  pushl $0
80107271:	6a 00                	push   $0x0
  pushl $201
80107273:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107278:	e9 ab f1 ff ff       	jmp    80106428 <alltraps>

8010727d <vector202>:
.globl vector202
vector202:
  pushl $0
8010727d:	6a 00                	push   $0x0
  pushl $202
8010727f:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107284:	e9 9f f1 ff ff       	jmp    80106428 <alltraps>

80107289 <vector203>:
.globl vector203
vector203:
  pushl $0
80107289:	6a 00                	push   $0x0
  pushl $203
8010728b:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107290:	e9 93 f1 ff ff       	jmp    80106428 <alltraps>

80107295 <vector204>:
.globl vector204
vector204:
  pushl $0
80107295:	6a 00                	push   $0x0
  pushl $204
80107297:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010729c:	e9 87 f1 ff ff       	jmp    80106428 <alltraps>

801072a1 <vector205>:
.globl vector205
vector205:
  pushl $0
801072a1:	6a 00                	push   $0x0
  pushl $205
801072a3:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801072a8:	e9 7b f1 ff ff       	jmp    80106428 <alltraps>

801072ad <vector206>:
.globl vector206
vector206:
  pushl $0
801072ad:	6a 00                	push   $0x0
  pushl $206
801072af:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801072b4:	e9 6f f1 ff ff       	jmp    80106428 <alltraps>

801072b9 <vector207>:
.globl vector207
vector207:
  pushl $0
801072b9:	6a 00                	push   $0x0
  pushl $207
801072bb:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801072c0:	e9 63 f1 ff ff       	jmp    80106428 <alltraps>

801072c5 <vector208>:
.globl vector208
vector208:
  pushl $0
801072c5:	6a 00                	push   $0x0
  pushl $208
801072c7:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801072cc:	e9 57 f1 ff ff       	jmp    80106428 <alltraps>

801072d1 <vector209>:
.globl vector209
vector209:
  pushl $0
801072d1:	6a 00                	push   $0x0
  pushl $209
801072d3:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801072d8:	e9 4b f1 ff ff       	jmp    80106428 <alltraps>

801072dd <vector210>:
.globl vector210
vector210:
  pushl $0
801072dd:	6a 00                	push   $0x0
  pushl $210
801072df:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801072e4:	e9 3f f1 ff ff       	jmp    80106428 <alltraps>

801072e9 <vector211>:
.globl vector211
vector211:
  pushl $0
801072e9:	6a 00                	push   $0x0
  pushl $211
801072eb:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801072f0:	e9 33 f1 ff ff       	jmp    80106428 <alltraps>

801072f5 <vector212>:
.globl vector212
vector212:
  pushl $0
801072f5:	6a 00                	push   $0x0
  pushl $212
801072f7:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801072fc:	e9 27 f1 ff ff       	jmp    80106428 <alltraps>

80107301 <vector213>:
.globl vector213
vector213:
  pushl $0
80107301:	6a 00                	push   $0x0
  pushl $213
80107303:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107308:	e9 1b f1 ff ff       	jmp    80106428 <alltraps>

8010730d <vector214>:
.globl vector214
vector214:
  pushl $0
8010730d:	6a 00                	push   $0x0
  pushl $214
8010730f:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107314:	e9 0f f1 ff ff       	jmp    80106428 <alltraps>

80107319 <vector215>:
.globl vector215
vector215:
  pushl $0
80107319:	6a 00                	push   $0x0
  pushl $215
8010731b:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107320:	e9 03 f1 ff ff       	jmp    80106428 <alltraps>

80107325 <vector216>:
.globl vector216
vector216:
  pushl $0
80107325:	6a 00                	push   $0x0
  pushl $216
80107327:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010732c:	e9 f7 f0 ff ff       	jmp    80106428 <alltraps>

80107331 <vector217>:
.globl vector217
vector217:
  pushl $0
80107331:	6a 00                	push   $0x0
  pushl $217
80107333:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107338:	e9 eb f0 ff ff       	jmp    80106428 <alltraps>

8010733d <vector218>:
.globl vector218
vector218:
  pushl $0
8010733d:	6a 00                	push   $0x0
  pushl $218
8010733f:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107344:	e9 df f0 ff ff       	jmp    80106428 <alltraps>

80107349 <vector219>:
.globl vector219
vector219:
  pushl $0
80107349:	6a 00                	push   $0x0
  pushl $219
8010734b:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107350:	e9 d3 f0 ff ff       	jmp    80106428 <alltraps>

80107355 <vector220>:
.globl vector220
vector220:
  pushl $0
80107355:	6a 00                	push   $0x0
  pushl $220
80107357:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010735c:	e9 c7 f0 ff ff       	jmp    80106428 <alltraps>

80107361 <vector221>:
.globl vector221
vector221:
  pushl $0
80107361:	6a 00                	push   $0x0
  pushl $221
80107363:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107368:	e9 bb f0 ff ff       	jmp    80106428 <alltraps>

8010736d <vector222>:
.globl vector222
vector222:
  pushl $0
8010736d:	6a 00                	push   $0x0
  pushl $222
8010736f:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107374:	e9 af f0 ff ff       	jmp    80106428 <alltraps>

80107379 <vector223>:
.globl vector223
vector223:
  pushl $0
80107379:	6a 00                	push   $0x0
  pushl $223
8010737b:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107380:	e9 a3 f0 ff ff       	jmp    80106428 <alltraps>

80107385 <vector224>:
.globl vector224
vector224:
  pushl $0
80107385:	6a 00                	push   $0x0
  pushl $224
80107387:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010738c:	e9 97 f0 ff ff       	jmp    80106428 <alltraps>

80107391 <vector225>:
.globl vector225
vector225:
  pushl $0
80107391:	6a 00                	push   $0x0
  pushl $225
80107393:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107398:	e9 8b f0 ff ff       	jmp    80106428 <alltraps>

8010739d <vector226>:
.globl vector226
vector226:
  pushl $0
8010739d:	6a 00                	push   $0x0
  pushl $226
8010739f:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801073a4:	e9 7f f0 ff ff       	jmp    80106428 <alltraps>

801073a9 <vector227>:
.globl vector227
vector227:
  pushl $0
801073a9:	6a 00                	push   $0x0
  pushl $227
801073ab:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801073b0:	e9 73 f0 ff ff       	jmp    80106428 <alltraps>

801073b5 <vector228>:
.globl vector228
vector228:
  pushl $0
801073b5:	6a 00                	push   $0x0
  pushl $228
801073b7:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801073bc:	e9 67 f0 ff ff       	jmp    80106428 <alltraps>

801073c1 <vector229>:
.globl vector229
vector229:
  pushl $0
801073c1:	6a 00                	push   $0x0
  pushl $229
801073c3:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801073c8:	e9 5b f0 ff ff       	jmp    80106428 <alltraps>

801073cd <vector230>:
.globl vector230
vector230:
  pushl $0
801073cd:	6a 00                	push   $0x0
  pushl $230
801073cf:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801073d4:	e9 4f f0 ff ff       	jmp    80106428 <alltraps>

801073d9 <vector231>:
.globl vector231
vector231:
  pushl $0
801073d9:	6a 00                	push   $0x0
  pushl $231
801073db:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801073e0:	e9 43 f0 ff ff       	jmp    80106428 <alltraps>

801073e5 <vector232>:
.globl vector232
vector232:
  pushl $0
801073e5:	6a 00                	push   $0x0
  pushl $232
801073e7:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801073ec:	e9 37 f0 ff ff       	jmp    80106428 <alltraps>

801073f1 <vector233>:
.globl vector233
vector233:
  pushl $0
801073f1:	6a 00                	push   $0x0
  pushl $233
801073f3:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801073f8:	e9 2b f0 ff ff       	jmp    80106428 <alltraps>

801073fd <vector234>:
.globl vector234
vector234:
  pushl $0
801073fd:	6a 00                	push   $0x0
  pushl $234
801073ff:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107404:	e9 1f f0 ff ff       	jmp    80106428 <alltraps>

80107409 <vector235>:
.globl vector235
vector235:
  pushl $0
80107409:	6a 00                	push   $0x0
  pushl $235
8010740b:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107410:	e9 13 f0 ff ff       	jmp    80106428 <alltraps>

80107415 <vector236>:
.globl vector236
vector236:
  pushl $0
80107415:	6a 00                	push   $0x0
  pushl $236
80107417:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010741c:	e9 07 f0 ff ff       	jmp    80106428 <alltraps>

80107421 <vector237>:
.globl vector237
vector237:
  pushl $0
80107421:	6a 00                	push   $0x0
  pushl $237
80107423:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107428:	e9 fb ef ff ff       	jmp    80106428 <alltraps>

8010742d <vector238>:
.globl vector238
vector238:
  pushl $0
8010742d:	6a 00                	push   $0x0
  pushl $238
8010742f:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107434:	e9 ef ef ff ff       	jmp    80106428 <alltraps>

80107439 <vector239>:
.globl vector239
vector239:
  pushl $0
80107439:	6a 00                	push   $0x0
  pushl $239
8010743b:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107440:	e9 e3 ef ff ff       	jmp    80106428 <alltraps>

80107445 <vector240>:
.globl vector240
vector240:
  pushl $0
80107445:	6a 00                	push   $0x0
  pushl $240
80107447:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010744c:	e9 d7 ef ff ff       	jmp    80106428 <alltraps>

80107451 <vector241>:
.globl vector241
vector241:
  pushl $0
80107451:	6a 00                	push   $0x0
  pushl $241
80107453:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107458:	e9 cb ef ff ff       	jmp    80106428 <alltraps>

8010745d <vector242>:
.globl vector242
vector242:
  pushl $0
8010745d:	6a 00                	push   $0x0
  pushl $242
8010745f:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107464:	e9 bf ef ff ff       	jmp    80106428 <alltraps>

80107469 <vector243>:
.globl vector243
vector243:
  pushl $0
80107469:	6a 00                	push   $0x0
  pushl $243
8010746b:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107470:	e9 b3 ef ff ff       	jmp    80106428 <alltraps>

80107475 <vector244>:
.globl vector244
vector244:
  pushl $0
80107475:	6a 00                	push   $0x0
  pushl $244
80107477:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010747c:	e9 a7 ef ff ff       	jmp    80106428 <alltraps>

80107481 <vector245>:
.globl vector245
vector245:
  pushl $0
80107481:	6a 00                	push   $0x0
  pushl $245
80107483:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107488:	e9 9b ef ff ff       	jmp    80106428 <alltraps>

8010748d <vector246>:
.globl vector246
vector246:
  pushl $0
8010748d:	6a 00                	push   $0x0
  pushl $246
8010748f:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107494:	e9 8f ef ff ff       	jmp    80106428 <alltraps>

80107499 <vector247>:
.globl vector247
vector247:
  pushl $0
80107499:	6a 00                	push   $0x0
  pushl $247
8010749b:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801074a0:	e9 83 ef ff ff       	jmp    80106428 <alltraps>

801074a5 <vector248>:
.globl vector248
vector248:
  pushl $0
801074a5:	6a 00                	push   $0x0
  pushl $248
801074a7:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801074ac:	e9 77 ef ff ff       	jmp    80106428 <alltraps>

801074b1 <vector249>:
.globl vector249
vector249:
  pushl $0
801074b1:	6a 00                	push   $0x0
  pushl $249
801074b3:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801074b8:	e9 6b ef ff ff       	jmp    80106428 <alltraps>

801074bd <vector250>:
.globl vector250
vector250:
  pushl $0
801074bd:	6a 00                	push   $0x0
  pushl $250
801074bf:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801074c4:	e9 5f ef ff ff       	jmp    80106428 <alltraps>

801074c9 <vector251>:
.globl vector251
vector251:
  pushl $0
801074c9:	6a 00                	push   $0x0
  pushl $251
801074cb:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801074d0:	e9 53 ef ff ff       	jmp    80106428 <alltraps>

801074d5 <vector252>:
.globl vector252
vector252:
  pushl $0
801074d5:	6a 00                	push   $0x0
  pushl $252
801074d7:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801074dc:	e9 47 ef ff ff       	jmp    80106428 <alltraps>

801074e1 <vector253>:
.globl vector253
vector253:
  pushl $0
801074e1:	6a 00                	push   $0x0
  pushl $253
801074e3:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801074e8:	e9 3b ef ff ff       	jmp    80106428 <alltraps>

801074ed <vector254>:
.globl vector254
vector254:
  pushl $0
801074ed:	6a 00                	push   $0x0
  pushl $254
801074ef:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801074f4:	e9 2f ef ff ff       	jmp    80106428 <alltraps>

801074f9 <vector255>:
.globl vector255
vector255:
  pushl $0
801074f9:	6a 00                	push   $0x0
  pushl $255
801074fb:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107500:	e9 23 ef ff ff       	jmp    80106428 <alltraps>

80107505 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
80107505:	55                   	push   %ebp
80107506:	89 e5                	mov    %esp,%ebp
80107508:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
8010750b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010750e:	83 e8 01             	sub    $0x1,%eax
80107511:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107515:	8b 45 08             	mov    0x8(%ebp),%eax
80107518:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010751c:	8b 45 08             	mov    0x8(%ebp),%eax
8010751f:	c1 e8 10             	shr    $0x10,%eax
80107522:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107526:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107529:	0f 01 10             	lgdtl  (%eax)
}
8010752c:	90                   	nop
8010752d:	c9                   	leave  
8010752e:	c3                   	ret    

8010752f <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
8010752f:	55                   	push   %ebp
80107530:	89 e5                	mov    %esp,%ebp
80107532:	83 ec 04             	sub    $0x4,%esp
80107535:	8b 45 08             	mov    0x8(%ebp),%eax
80107538:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
8010753c:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107540:	0f 00 d8             	ltr    %ax
}
80107543:	90                   	nop
80107544:	c9                   	leave  
80107545:	c3                   	ret    

80107546 <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
80107546:	55                   	push   %ebp
80107547:	89 e5                	mov    %esp,%ebp
80107549:	83 ec 04             	sub    $0x4,%esp
8010754c:	8b 45 08             	mov    0x8(%ebp),%eax
8010754f:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
80107553:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107557:	8e e8                	mov    %eax,%gs
}
80107559:	90                   	nop
8010755a:	c9                   	leave  
8010755b:	c3                   	ret    

8010755c <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
8010755c:	55                   	push   %ebp
8010755d:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010755f:	8b 45 08             	mov    0x8(%ebp),%eax
80107562:	0f 22 d8             	mov    %eax,%cr3
}
80107565:	90                   	nop
80107566:	5d                   	pop    %ebp
80107567:	c3                   	ret    

80107568 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80107568:	55                   	push   %ebp
80107569:	89 e5                	mov    %esp,%ebp
8010756b:	8b 45 08             	mov    0x8(%ebp),%eax
8010756e:	05 00 00 00 80       	add    $0x80000000,%eax
80107573:	5d                   	pop    %ebp
80107574:	c3                   	ret    

80107575 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80107575:	55                   	push   %ebp
80107576:	89 e5                	mov    %esp,%ebp
80107578:	8b 45 08             	mov    0x8(%ebp),%eax
8010757b:	05 00 00 00 80       	add    $0x80000000,%eax
80107580:	5d                   	pop    %ebp
80107581:	c3                   	ret    

80107582 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107582:	55                   	push   %ebp
80107583:	89 e5                	mov    %esp,%ebp
80107585:	53                   	push   %ebx
80107586:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107589:	e8 d4 bb ff ff       	call   80103162 <cpunum>
8010758e:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80107594:	05 80 29 11 80       	add    $0x80112980,%eax
80107599:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010759c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010759f:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801075a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075a8:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801075ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075b1:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801075b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075b8:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801075bc:	83 e2 f0             	and    $0xfffffff0,%edx
801075bf:	83 ca 0a             	or     $0xa,%edx
801075c2:	88 50 7d             	mov    %dl,0x7d(%eax)
801075c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075c8:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801075cc:	83 ca 10             	or     $0x10,%edx
801075cf:	88 50 7d             	mov    %dl,0x7d(%eax)
801075d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075d5:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801075d9:	83 e2 9f             	and    $0xffffff9f,%edx
801075dc:	88 50 7d             	mov    %dl,0x7d(%eax)
801075df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075e2:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801075e6:	83 ca 80             	or     $0xffffff80,%edx
801075e9:	88 50 7d             	mov    %dl,0x7d(%eax)
801075ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075ef:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801075f3:	83 ca 0f             	or     $0xf,%edx
801075f6:	88 50 7e             	mov    %dl,0x7e(%eax)
801075f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075fc:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107600:	83 e2 ef             	and    $0xffffffef,%edx
80107603:	88 50 7e             	mov    %dl,0x7e(%eax)
80107606:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107609:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010760d:	83 e2 df             	and    $0xffffffdf,%edx
80107610:	88 50 7e             	mov    %dl,0x7e(%eax)
80107613:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107616:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010761a:	83 ca 40             	or     $0x40,%edx
8010761d:	88 50 7e             	mov    %dl,0x7e(%eax)
80107620:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107623:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107627:	83 ca 80             	or     $0xffffff80,%edx
8010762a:	88 50 7e             	mov    %dl,0x7e(%eax)
8010762d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107630:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107634:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107637:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
8010763e:	ff ff 
80107640:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107643:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
8010764a:	00 00 
8010764c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010764f:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107656:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107659:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107660:	83 e2 f0             	and    $0xfffffff0,%edx
80107663:	83 ca 02             	or     $0x2,%edx
80107666:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010766c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010766f:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107676:	83 ca 10             	or     $0x10,%edx
80107679:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010767f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107682:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107689:	83 e2 9f             	and    $0xffffff9f,%edx
8010768c:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107692:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107695:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010769c:	83 ca 80             	or     $0xffffff80,%edx
8010769f:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801076a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076a8:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076af:	83 ca 0f             	or     $0xf,%edx
801076b2:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801076b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076bb:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076c2:	83 e2 ef             	and    $0xffffffef,%edx
801076c5:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801076cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076ce:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076d5:	83 e2 df             	and    $0xffffffdf,%edx
801076d8:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801076de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076e1:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076e8:	83 ca 40             	or     $0x40,%edx
801076eb:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801076f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076f4:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076fb:	83 ca 80             	or     $0xffffff80,%edx
801076fe:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107704:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107707:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010770e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107711:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107718:	ff ff 
8010771a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010771d:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107724:	00 00 
80107726:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107729:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107730:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107733:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
8010773a:	83 e2 f0             	and    $0xfffffff0,%edx
8010773d:	83 ca 0a             	or     $0xa,%edx
80107740:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107746:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107749:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107750:	83 ca 10             	or     $0x10,%edx
80107753:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107759:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010775c:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107763:	83 ca 60             	or     $0x60,%edx
80107766:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010776c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010776f:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107776:	83 ca 80             	or     $0xffffff80,%edx
80107779:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010777f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107782:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107789:	83 ca 0f             	or     $0xf,%edx
8010778c:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107792:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107795:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
8010779c:	83 e2 ef             	and    $0xffffffef,%edx
8010779f:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077a8:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077af:	83 e2 df             	and    $0xffffffdf,%edx
801077b2:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077bb:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077c2:	83 ca 40             	or     $0x40,%edx
801077c5:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077ce:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077d5:	83 ca 80             	or     $0xffffff80,%edx
801077d8:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077e1:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801077e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077eb:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
801077f2:	ff ff 
801077f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077f7:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
801077fe:	00 00 
80107800:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107803:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
8010780a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010780d:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107814:	83 e2 f0             	and    $0xfffffff0,%edx
80107817:	83 ca 02             	or     $0x2,%edx
8010781a:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107820:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107823:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010782a:	83 ca 10             	or     $0x10,%edx
8010782d:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107833:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107836:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010783d:	83 ca 60             	or     $0x60,%edx
80107840:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107846:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107849:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107850:	83 ca 80             	or     $0xffffff80,%edx
80107853:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107859:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010785c:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107863:	83 ca 0f             	or     $0xf,%edx
80107866:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010786c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010786f:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107876:	83 e2 ef             	and    $0xffffffef,%edx
80107879:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010787f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107882:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107889:	83 e2 df             	and    $0xffffffdf,%edx
8010788c:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107892:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107895:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
8010789c:	83 ca 40             	or     $0x40,%edx
8010789f:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078a8:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801078af:	83 ca 80             	or     $0xffffff80,%edx
801078b2:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078bb:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801078c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078c5:	05 b4 00 00 00       	add    $0xb4,%eax
801078ca:	89 c3                	mov    %eax,%ebx
801078cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078cf:	05 b4 00 00 00       	add    $0xb4,%eax
801078d4:	c1 e8 10             	shr    $0x10,%eax
801078d7:	89 c2                	mov    %eax,%edx
801078d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078dc:	05 b4 00 00 00       	add    $0xb4,%eax
801078e1:	c1 e8 18             	shr    $0x18,%eax
801078e4:	89 c1                	mov    %eax,%ecx
801078e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078e9:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
801078f0:	00 00 
801078f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078f5:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
801078fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078ff:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80107905:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107908:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010790f:	83 e2 f0             	and    $0xfffffff0,%edx
80107912:	83 ca 02             	or     $0x2,%edx
80107915:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
8010791b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010791e:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107925:	83 ca 10             	or     $0x10,%edx
80107928:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
8010792e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107931:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107938:	83 e2 9f             	and    $0xffffff9f,%edx
8010793b:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107941:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107944:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010794b:	83 ca 80             	or     $0xffffff80,%edx
8010794e:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107954:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107957:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
8010795e:	83 e2 f0             	and    $0xfffffff0,%edx
80107961:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107967:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010796a:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107971:	83 e2 ef             	and    $0xffffffef,%edx
80107974:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
8010797a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010797d:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107984:	83 e2 df             	and    $0xffffffdf,%edx
80107987:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
8010798d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107990:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107997:	83 ca 40             	or     $0x40,%edx
8010799a:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801079a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079a3:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801079aa:	83 ca 80             	or     $0xffffff80,%edx
801079ad:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801079b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079b6:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
801079bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079bf:	83 c0 70             	add    $0x70,%eax
801079c2:	83 ec 08             	sub    $0x8,%esp
801079c5:	6a 38                	push   $0x38
801079c7:	50                   	push   %eax
801079c8:	e8 38 fb ff ff       	call   80107505 <lgdt>
801079cd:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
801079d0:	83 ec 0c             	sub    $0xc,%esp
801079d3:	6a 18                	push   $0x18
801079d5:	e8 6c fb ff ff       	call   80107546 <loadgs>
801079da:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
801079dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079e0:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
801079e6:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
801079ed:	00 00 00 00 
}
801079f1:	90                   	nop
801079f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801079f5:	c9                   	leave  
801079f6:	c3                   	ret    

801079f7 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801079f7:	55                   	push   %ebp
801079f8:	89 e5                	mov    %esp,%ebp
801079fa:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801079fd:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a00:	c1 e8 16             	shr    $0x16,%eax
80107a03:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107a0a:	8b 45 08             	mov    0x8(%ebp),%eax
80107a0d:	01 d0                	add    %edx,%eax
80107a0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107a12:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a15:	8b 00                	mov    (%eax),%eax
80107a17:	83 e0 01             	and    $0x1,%eax
80107a1a:	85 c0                	test   %eax,%eax
80107a1c:	74 18                	je     80107a36 <walkpgdir+0x3f>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107a1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a21:	8b 00                	mov    (%eax),%eax
80107a23:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107a28:	50                   	push   %eax
80107a29:	e8 47 fb ff ff       	call   80107575 <p2v>
80107a2e:	83 c4 04             	add    $0x4,%esp
80107a31:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107a34:	eb 48                	jmp    80107a7e <walkpgdir+0x87>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107a36:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107a3a:	74 0e                	je     80107a4a <walkpgdir+0x53>
80107a3c:	e8 bf b2 ff ff       	call   80102d00 <kalloc>
80107a41:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107a44:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107a48:	75 07                	jne    80107a51 <walkpgdir+0x5a>
      return 0;
80107a4a:	b8 00 00 00 00       	mov    $0x0,%eax
80107a4f:	eb 44                	jmp    80107a95 <walkpgdir+0x9e>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107a51:	83 ec 04             	sub    $0x4,%esp
80107a54:	68 00 10 00 00       	push   $0x1000
80107a59:	6a 00                	push   $0x0
80107a5b:	ff 75 f4             	pushl  -0xc(%ebp)
80107a5e:	e8 3d d6 ff ff       	call   801050a0 <memset>
80107a63:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107a66:	83 ec 0c             	sub    $0xc,%esp
80107a69:	ff 75 f4             	pushl  -0xc(%ebp)
80107a6c:	e8 f7 fa ff ff       	call   80107568 <v2p>
80107a71:	83 c4 10             	add    $0x10,%esp
80107a74:	83 c8 07             	or     $0x7,%eax
80107a77:	89 c2                	mov    %eax,%edx
80107a79:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a7c:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107a7e:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a81:	c1 e8 0c             	shr    $0xc,%eax
80107a84:	25 ff 03 00 00       	and    $0x3ff,%eax
80107a89:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107a90:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a93:	01 d0                	add    %edx,%eax
}
80107a95:	c9                   	leave  
80107a96:	c3                   	ret    

80107a97 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107a97:	55                   	push   %ebp
80107a98:	89 e5                	mov    %esp,%ebp
80107a9a:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107a9d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107aa0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107aa5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107aa8:	8b 55 0c             	mov    0xc(%ebp),%edx
80107aab:	8b 45 10             	mov    0x10(%ebp),%eax
80107aae:	01 d0                	add    %edx,%eax
80107ab0:	83 e8 01             	sub    $0x1,%eax
80107ab3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ab8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107abb:	83 ec 04             	sub    $0x4,%esp
80107abe:	6a 01                	push   $0x1
80107ac0:	ff 75 f4             	pushl  -0xc(%ebp)
80107ac3:	ff 75 08             	pushl  0x8(%ebp)
80107ac6:	e8 2c ff ff ff       	call   801079f7 <walkpgdir>
80107acb:	83 c4 10             	add    $0x10,%esp
80107ace:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107ad1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107ad5:	75 07                	jne    80107ade <mappages+0x47>
      return -1;
80107ad7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107adc:	eb 47                	jmp    80107b25 <mappages+0x8e>
    if(*pte & PTE_P)
80107ade:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107ae1:	8b 00                	mov    (%eax),%eax
80107ae3:	83 e0 01             	and    $0x1,%eax
80107ae6:	85 c0                	test   %eax,%eax
80107ae8:	74 0d                	je     80107af7 <mappages+0x60>
      panic("remap");
80107aea:	83 ec 0c             	sub    $0xc,%esp
80107aed:	68 ac b9 10 80       	push   $0x8010b9ac
80107af2:	e8 6f 8a ff ff       	call   80100566 <panic>
    *pte = pa | perm | PTE_P;
80107af7:	8b 45 18             	mov    0x18(%ebp),%eax
80107afa:	0b 45 14             	or     0x14(%ebp),%eax
80107afd:	83 c8 01             	or     $0x1,%eax
80107b00:	89 c2                	mov    %eax,%edx
80107b02:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107b05:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107b07:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b0a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107b0d:	74 10                	je     80107b1f <mappages+0x88>
      break;
    a += PGSIZE;
80107b0f:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107b16:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80107b1d:	eb 9c                	jmp    80107abb <mappages+0x24>
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
80107b1f:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107b20:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107b25:	c9                   	leave  
80107b26:	c3                   	ret    

80107b27 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107b27:	55                   	push   %ebp
80107b28:	89 e5                	mov    %esp,%ebp
80107b2a:	53                   	push   %ebx
80107b2b:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107b2e:	e8 cd b1 ff ff       	call   80102d00 <kalloc>
80107b33:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107b36:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107b3a:	75 0a                	jne    80107b46 <setupkvm+0x1f>
    return 0;
80107b3c:	b8 00 00 00 00       	mov    $0x0,%eax
80107b41:	e9 8e 00 00 00       	jmp    80107bd4 <setupkvm+0xad>
  memset(pgdir, 0, PGSIZE);
80107b46:	83 ec 04             	sub    $0x4,%esp
80107b49:	68 00 10 00 00       	push   $0x1000
80107b4e:	6a 00                	push   $0x0
80107b50:	ff 75 f0             	pushl  -0x10(%ebp)
80107b53:	e8 48 d5 ff ff       	call   801050a0 <memset>
80107b58:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107b5b:	83 ec 0c             	sub    $0xc,%esp
80107b5e:	68 00 00 00 0e       	push   $0xe000000
80107b63:	e8 0d fa ff ff       	call   80107575 <p2v>
80107b68:	83 c4 10             	add    $0x10,%esp
80107b6b:	3d 00 00 00 fc       	cmp    $0xfc000000,%eax
80107b70:	76 0d                	jbe    80107b7f <setupkvm+0x58>
    panic("PHYSTOP too high");
80107b72:	83 ec 0c             	sub    $0xc,%esp
80107b75:	68 b2 b9 10 80       	push   $0x8010b9b2
80107b7a:	e8 e7 89 ff ff       	call   80100566 <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107b7f:	c7 45 f4 c0 e4 10 80 	movl   $0x8010e4c0,-0xc(%ebp)
80107b86:	eb 40                	jmp    80107bc8 <setupkvm+0xa1>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107b88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b8b:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
80107b8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b91:	8b 50 04             	mov    0x4(%eax),%edx
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107b94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b97:	8b 58 08             	mov    0x8(%eax),%ebx
80107b9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b9d:	8b 40 04             	mov    0x4(%eax),%eax
80107ba0:	29 c3                	sub    %eax,%ebx
80107ba2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ba5:	8b 00                	mov    (%eax),%eax
80107ba7:	83 ec 0c             	sub    $0xc,%esp
80107baa:	51                   	push   %ecx
80107bab:	52                   	push   %edx
80107bac:	53                   	push   %ebx
80107bad:	50                   	push   %eax
80107bae:	ff 75 f0             	pushl  -0x10(%ebp)
80107bb1:	e8 e1 fe ff ff       	call   80107a97 <mappages>
80107bb6:	83 c4 20             	add    $0x20,%esp
80107bb9:	85 c0                	test   %eax,%eax
80107bbb:	79 07                	jns    80107bc4 <setupkvm+0x9d>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80107bbd:	b8 00 00 00 00       	mov    $0x0,%eax
80107bc2:	eb 10                	jmp    80107bd4 <setupkvm+0xad>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107bc4:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107bc8:	81 7d f4 00 e5 10 80 	cmpl   $0x8010e500,-0xc(%ebp)
80107bcf:	72 b7                	jb     80107b88 <setupkvm+0x61>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80107bd1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107bd4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107bd7:	c9                   	leave  
80107bd8:	c3                   	ret    

80107bd9 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107bd9:	55                   	push   %ebp
80107bda:	89 e5                	mov    %esp,%ebp
80107bdc:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107bdf:	e8 43 ff ff ff       	call   80107b27 <setupkvm>
80107be4:	a3 58 57 11 80       	mov    %eax,0x80115758
  switchkvm();
80107be9:	e8 03 00 00 00       	call   80107bf1 <switchkvm>
}
80107bee:	90                   	nop
80107bef:	c9                   	leave  
80107bf0:	c3                   	ret    

80107bf1 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107bf1:	55                   	push   %ebp
80107bf2:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107bf4:	a1 58 57 11 80       	mov    0x80115758,%eax
80107bf9:	50                   	push   %eax
80107bfa:	e8 69 f9 ff ff       	call   80107568 <v2p>
80107bff:	83 c4 04             	add    $0x4,%esp
80107c02:	50                   	push   %eax
80107c03:	e8 54 f9 ff ff       	call   8010755c <lcr3>
80107c08:	83 c4 04             	add    $0x4,%esp
}
80107c0b:	90                   	nop
80107c0c:	c9                   	leave  
80107c0d:	c3                   	ret    

80107c0e <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107c0e:	55                   	push   %ebp
80107c0f:	89 e5                	mov    %esp,%ebp
80107c11:	56                   	push   %esi
80107c12:	53                   	push   %ebx
  pushcli();
80107c13:	e8 82 d3 ff ff       	call   80104f9a <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107c18:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107c1e:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107c25:	83 c2 08             	add    $0x8,%edx
80107c28:	89 d6                	mov    %edx,%esi
80107c2a:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107c31:	83 c2 08             	add    $0x8,%edx
80107c34:	c1 ea 10             	shr    $0x10,%edx
80107c37:	89 d3                	mov    %edx,%ebx
80107c39:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107c40:	83 c2 08             	add    $0x8,%edx
80107c43:	c1 ea 18             	shr    $0x18,%edx
80107c46:	89 d1                	mov    %edx,%ecx
80107c48:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107c4f:	67 00 
80107c51:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
80107c58:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80107c5e:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107c65:	83 e2 f0             	and    $0xfffffff0,%edx
80107c68:	83 ca 09             	or     $0x9,%edx
80107c6b:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107c71:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107c78:	83 ca 10             	or     $0x10,%edx
80107c7b:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107c81:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107c88:	83 e2 9f             	and    $0xffffff9f,%edx
80107c8b:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107c91:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107c98:	83 ca 80             	or     $0xffffff80,%edx
80107c9b:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107ca1:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107ca8:	83 e2 f0             	and    $0xfffffff0,%edx
80107cab:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107cb1:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107cb8:	83 e2 ef             	and    $0xffffffef,%edx
80107cbb:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107cc1:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107cc8:	83 e2 df             	and    $0xffffffdf,%edx
80107ccb:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107cd1:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107cd8:	83 ca 40             	or     $0x40,%edx
80107cdb:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107ce1:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107ce8:	83 e2 7f             	and    $0x7f,%edx
80107ceb:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107cf1:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107cf7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107cfd:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107d04:	83 e2 ef             	and    $0xffffffef,%edx
80107d07:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107d0d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d13:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80107d19:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d1f:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107d26:	8b 52 08             	mov    0x8(%edx),%edx
80107d29:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107d2f:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80107d32:	83 ec 0c             	sub    $0xc,%esp
80107d35:	6a 30                	push   $0x30
80107d37:	e8 f3 f7 ff ff       	call   8010752f <ltr>
80107d3c:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80107d3f:	8b 45 08             	mov    0x8(%ebp),%eax
80107d42:	8b 40 04             	mov    0x4(%eax),%eax
80107d45:	85 c0                	test   %eax,%eax
80107d47:	75 0d                	jne    80107d56 <switchuvm+0x148>
    panic("switchuvm: no pgdir");
80107d49:	83 ec 0c             	sub    $0xc,%esp
80107d4c:	68 c3 b9 10 80       	push   $0x8010b9c3
80107d51:	e8 10 88 ff ff       	call   80100566 <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80107d56:	8b 45 08             	mov    0x8(%ebp),%eax
80107d59:	8b 40 04             	mov    0x4(%eax),%eax
80107d5c:	83 ec 0c             	sub    $0xc,%esp
80107d5f:	50                   	push   %eax
80107d60:	e8 03 f8 ff ff       	call   80107568 <v2p>
80107d65:	83 c4 10             	add    $0x10,%esp
80107d68:	83 ec 0c             	sub    $0xc,%esp
80107d6b:	50                   	push   %eax
80107d6c:	e8 eb f7 ff ff       	call   8010755c <lcr3>
80107d71:	83 c4 10             	add    $0x10,%esp
  popcli();
80107d74:	e8 66 d2 ff ff       	call   80104fdf <popcli>
}
80107d79:	90                   	nop
80107d7a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107d7d:	5b                   	pop    %ebx
80107d7e:	5e                   	pop    %esi
80107d7f:	5d                   	pop    %ebp
80107d80:	c3                   	ret    

80107d81 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107d81:	55                   	push   %ebp
80107d82:	89 e5                	mov    %esp,%ebp
80107d84:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
80107d87:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80107d8e:	76 0d                	jbe    80107d9d <inituvm+0x1c>
    panic("inituvm: more than a page");
80107d90:	83 ec 0c             	sub    $0xc,%esp
80107d93:	68 d7 b9 10 80       	push   $0x8010b9d7
80107d98:	e8 c9 87 ff ff       	call   80100566 <panic>
  mem = kalloc();
80107d9d:	e8 5e af ff ff       	call   80102d00 <kalloc>
80107da2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80107da5:	83 ec 04             	sub    $0x4,%esp
80107da8:	68 00 10 00 00       	push   $0x1000
80107dad:	6a 00                	push   $0x0
80107daf:	ff 75 f4             	pushl  -0xc(%ebp)
80107db2:	e8 e9 d2 ff ff       	call   801050a0 <memset>
80107db7:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107dba:	83 ec 0c             	sub    $0xc,%esp
80107dbd:	ff 75 f4             	pushl  -0xc(%ebp)
80107dc0:	e8 a3 f7 ff ff       	call   80107568 <v2p>
80107dc5:	83 c4 10             	add    $0x10,%esp
80107dc8:	83 ec 0c             	sub    $0xc,%esp
80107dcb:	6a 06                	push   $0x6
80107dcd:	50                   	push   %eax
80107dce:	68 00 10 00 00       	push   $0x1000
80107dd3:	6a 00                	push   $0x0
80107dd5:	ff 75 08             	pushl  0x8(%ebp)
80107dd8:	e8 ba fc ff ff       	call   80107a97 <mappages>
80107ddd:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
80107de0:	83 ec 04             	sub    $0x4,%esp
80107de3:	ff 75 10             	pushl  0x10(%ebp)
80107de6:	ff 75 0c             	pushl  0xc(%ebp)
80107de9:	ff 75 f4             	pushl  -0xc(%ebp)
80107dec:	e8 6e d3 ff ff       	call   8010515f <memmove>
80107df1:	83 c4 10             	add    $0x10,%esp
}
80107df4:	90                   	nop
80107df5:	c9                   	leave  
80107df6:	c3                   	ret    

80107df7 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107df7:	55                   	push   %ebp
80107df8:	89 e5                	mov    %esp,%ebp
80107dfa:	53                   	push   %ebx
80107dfb:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107dfe:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e01:	25 ff 0f 00 00       	and    $0xfff,%eax
80107e06:	85 c0                	test   %eax,%eax
80107e08:	74 0d                	je     80107e17 <loaduvm+0x20>
    panic("loaduvm: addr must be page aligned");
80107e0a:	83 ec 0c             	sub    $0xc,%esp
80107e0d:	68 f4 b9 10 80       	push   $0x8010b9f4
80107e12:	e8 4f 87 ff ff       	call   80100566 <panic>
  for(i = 0; i < sz; i += PGSIZE){
80107e17:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107e1e:	e9 95 00 00 00       	jmp    80107eb8 <loaduvm+0xc1>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107e23:	8b 55 0c             	mov    0xc(%ebp),%edx
80107e26:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e29:	01 d0                	add    %edx,%eax
80107e2b:	83 ec 04             	sub    $0x4,%esp
80107e2e:	6a 00                	push   $0x0
80107e30:	50                   	push   %eax
80107e31:	ff 75 08             	pushl  0x8(%ebp)
80107e34:	e8 be fb ff ff       	call   801079f7 <walkpgdir>
80107e39:	83 c4 10             	add    $0x10,%esp
80107e3c:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107e3f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107e43:	75 0d                	jne    80107e52 <loaduvm+0x5b>
      panic("loaduvm: address should exist");
80107e45:	83 ec 0c             	sub    $0xc,%esp
80107e48:	68 17 ba 10 80       	push   $0x8010ba17
80107e4d:	e8 14 87 ff ff       	call   80100566 <panic>
    pa = PTE_ADDR(*pte);
80107e52:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107e55:	8b 00                	mov    (%eax),%eax
80107e57:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e5c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80107e5f:	8b 45 18             	mov    0x18(%ebp),%eax
80107e62:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107e65:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80107e6a:	77 0b                	ja     80107e77 <loaduvm+0x80>
      n = sz - i;
80107e6c:	8b 45 18             	mov    0x18(%ebp),%eax
80107e6f:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107e72:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107e75:	eb 07                	jmp    80107e7e <loaduvm+0x87>
    else
      n = PGSIZE;
80107e77:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80107e7e:	8b 55 14             	mov    0x14(%ebp),%edx
80107e81:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e84:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80107e87:	83 ec 0c             	sub    $0xc,%esp
80107e8a:	ff 75 e8             	pushl  -0x18(%ebp)
80107e8d:	e8 e3 f6 ff ff       	call   80107575 <p2v>
80107e92:	83 c4 10             	add    $0x10,%esp
80107e95:	ff 75 f0             	pushl  -0x10(%ebp)
80107e98:	53                   	push   %ebx
80107e99:	50                   	push   %eax
80107e9a:	ff 75 10             	pushl  0x10(%ebp)
80107e9d:	e8 0c a1 ff ff       	call   80101fae <readi>
80107ea2:	83 c4 10             	add    $0x10,%esp
80107ea5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107ea8:	74 07                	je     80107eb1 <loaduvm+0xba>
      return -1;
80107eaa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107eaf:	eb 18                	jmp    80107ec9 <loaduvm+0xd2>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107eb1:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107eb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ebb:	3b 45 18             	cmp    0x18(%ebp),%eax
80107ebe:	0f 82 5f ff ff ff    	jb     80107e23 <loaduvm+0x2c>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80107ec4:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107ec9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107ecc:	c9                   	leave  
80107ecd:	c3                   	ret    

80107ece <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107ece:	55                   	push   %ebp
80107ecf:	89 e5                	mov    %esp,%ebp
80107ed1:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80107ed4:	8b 45 10             	mov    0x10(%ebp),%eax
80107ed7:	85 c0                	test   %eax,%eax
80107ed9:	79 0a                	jns    80107ee5 <allocuvm+0x17>
    return 0;
80107edb:	b8 00 00 00 00       	mov    $0x0,%eax
80107ee0:	e9 b0 00 00 00       	jmp    80107f95 <allocuvm+0xc7>
  if(newsz < oldsz)
80107ee5:	8b 45 10             	mov    0x10(%ebp),%eax
80107ee8:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107eeb:	73 08                	jae    80107ef5 <allocuvm+0x27>
    return oldsz;
80107eed:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ef0:	e9 a0 00 00 00       	jmp    80107f95 <allocuvm+0xc7>

  a = PGROUNDUP(oldsz);
80107ef5:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ef8:	05 ff 0f 00 00       	add    $0xfff,%eax
80107efd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f02:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
80107f05:	eb 7f                	jmp    80107f86 <allocuvm+0xb8>
    mem = kalloc();
80107f07:	e8 f4 ad ff ff       	call   80102d00 <kalloc>
80107f0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80107f0f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107f13:	75 2b                	jne    80107f40 <allocuvm+0x72>
      cprintf("allocuvm out of memory\n");
80107f15:	83 ec 0c             	sub    $0xc,%esp
80107f18:	68 35 ba 10 80       	push   $0x8010ba35
80107f1d:	e8 a4 84 ff ff       	call   801003c6 <cprintf>
80107f22:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
80107f25:	83 ec 04             	sub    $0x4,%esp
80107f28:	ff 75 0c             	pushl  0xc(%ebp)
80107f2b:	ff 75 10             	pushl  0x10(%ebp)
80107f2e:	ff 75 08             	pushl  0x8(%ebp)
80107f31:	e8 61 00 00 00       	call   80107f97 <deallocuvm>
80107f36:	83 c4 10             	add    $0x10,%esp
      return 0;
80107f39:	b8 00 00 00 00       	mov    $0x0,%eax
80107f3e:	eb 55                	jmp    80107f95 <allocuvm+0xc7>
    }
    memset(mem, 0, PGSIZE);
80107f40:	83 ec 04             	sub    $0x4,%esp
80107f43:	68 00 10 00 00       	push   $0x1000
80107f48:	6a 00                	push   $0x0
80107f4a:	ff 75 f0             	pushl  -0x10(%ebp)
80107f4d:	e8 4e d1 ff ff       	call   801050a0 <memset>
80107f52:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107f55:	83 ec 0c             	sub    $0xc,%esp
80107f58:	ff 75 f0             	pushl  -0x10(%ebp)
80107f5b:	e8 08 f6 ff ff       	call   80107568 <v2p>
80107f60:	83 c4 10             	add    $0x10,%esp
80107f63:	89 c2                	mov    %eax,%edx
80107f65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f68:	83 ec 0c             	sub    $0xc,%esp
80107f6b:	6a 06                	push   $0x6
80107f6d:	52                   	push   %edx
80107f6e:	68 00 10 00 00       	push   $0x1000
80107f73:	50                   	push   %eax
80107f74:	ff 75 08             	pushl  0x8(%ebp)
80107f77:	e8 1b fb ff ff       	call   80107a97 <mappages>
80107f7c:	83 c4 20             	add    $0x20,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107f7f:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107f86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f89:	3b 45 10             	cmp    0x10(%ebp),%eax
80107f8c:	0f 82 75 ff ff ff    	jb     80107f07 <allocuvm+0x39>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
80107f92:	8b 45 10             	mov    0x10(%ebp),%eax
}
80107f95:	c9                   	leave  
80107f96:	c3                   	ret    

80107f97 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107f97:	55                   	push   %ebp
80107f98:	89 e5                	mov    %esp,%ebp
80107f9a:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80107f9d:	8b 45 10             	mov    0x10(%ebp),%eax
80107fa0:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107fa3:	72 08                	jb     80107fad <deallocuvm+0x16>
    return oldsz;
80107fa5:	8b 45 0c             	mov    0xc(%ebp),%eax
80107fa8:	e9 a5 00 00 00       	jmp    80108052 <deallocuvm+0xbb>

  a = PGROUNDUP(newsz);
80107fad:	8b 45 10             	mov    0x10(%ebp),%eax
80107fb0:	05 ff 0f 00 00       	add    $0xfff,%eax
80107fb5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107fba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107fbd:	e9 81 00 00 00       	jmp    80108043 <deallocuvm+0xac>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107fc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fc5:	83 ec 04             	sub    $0x4,%esp
80107fc8:	6a 00                	push   $0x0
80107fca:	50                   	push   %eax
80107fcb:	ff 75 08             	pushl  0x8(%ebp)
80107fce:	e8 24 fa ff ff       	call   801079f7 <walkpgdir>
80107fd3:	83 c4 10             	add    $0x10,%esp
80107fd6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80107fd9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107fdd:	75 09                	jne    80107fe8 <deallocuvm+0x51>
      a += (NPTENTRIES - 1) * PGSIZE;
80107fdf:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
80107fe6:	eb 54                	jmp    8010803c <deallocuvm+0xa5>
    else if((*pte & PTE_P) != 0){
80107fe8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107feb:	8b 00                	mov    (%eax),%eax
80107fed:	83 e0 01             	and    $0x1,%eax
80107ff0:	85 c0                	test   %eax,%eax
80107ff2:	74 48                	je     8010803c <deallocuvm+0xa5>
      pa = PTE_ADDR(*pte);
80107ff4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ff7:	8b 00                	mov    (%eax),%eax
80107ff9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ffe:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
80108001:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108005:	75 0d                	jne    80108014 <deallocuvm+0x7d>
        panic("kfree");
80108007:	83 ec 0c             	sub    $0xc,%esp
8010800a:	68 4d ba 10 80       	push   $0x8010ba4d
8010800f:	e8 52 85 ff ff       	call   80100566 <panic>
      char *v = p2v(pa);
80108014:	83 ec 0c             	sub    $0xc,%esp
80108017:	ff 75 ec             	pushl  -0x14(%ebp)
8010801a:	e8 56 f5 ff ff       	call   80107575 <p2v>
8010801f:	83 c4 10             	add    $0x10,%esp
80108022:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
80108025:	83 ec 0c             	sub    $0xc,%esp
80108028:	ff 75 e8             	pushl  -0x18(%ebp)
8010802b:	e8 33 ac ff ff       	call   80102c63 <kfree>
80108030:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80108033:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108036:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010803c:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108043:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108046:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108049:	0f 82 73 ff ff ff    	jb     80107fc2 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
8010804f:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108052:	c9                   	leave  
80108053:	c3                   	ret    

80108054 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108054:	55                   	push   %ebp
80108055:	89 e5                	mov    %esp,%ebp
80108057:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
8010805a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010805e:	75 0d                	jne    8010806d <freevm+0x19>
    panic("freevm: no pgdir");
80108060:	83 ec 0c             	sub    $0xc,%esp
80108063:	68 53 ba 10 80       	push   $0x8010ba53
80108068:	e8 f9 84 ff ff       	call   80100566 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
8010806d:	83 ec 04             	sub    $0x4,%esp
80108070:	6a 00                	push   $0x0
80108072:	68 00 00 00 80       	push   $0x80000000
80108077:	ff 75 08             	pushl  0x8(%ebp)
8010807a:	e8 18 ff ff ff       	call   80107f97 <deallocuvm>
8010807f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108082:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108089:	eb 4f                	jmp    801080da <freevm+0x86>
    if(pgdir[i] & PTE_P){
8010808b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010808e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108095:	8b 45 08             	mov    0x8(%ebp),%eax
80108098:	01 d0                	add    %edx,%eax
8010809a:	8b 00                	mov    (%eax),%eax
8010809c:	83 e0 01             	and    $0x1,%eax
8010809f:	85 c0                	test   %eax,%eax
801080a1:	74 33                	je     801080d6 <freevm+0x82>
      char * v = p2v(PTE_ADDR(pgdir[i]));
801080a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801080ad:	8b 45 08             	mov    0x8(%ebp),%eax
801080b0:	01 d0                	add    %edx,%eax
801080b2:	8b 00                	mov    (%eax),%eax
801080b4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080b9:	83 ec 0c             	sub    $0xc,%esp
801080bc:	50                   	push   %eax
801080bd:	e8 b3 f4 ff ff       	call   80107575 <p2v>
801080c2:	83 c4 10             	add    $0x10,%esp
801080c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
801080c8:	83 ec 0c             	sub    $0xc,%esp
801080cb:	ff 75 f0             	pushl  -0x10(%ebp)
801080ce:	e8 90 ab ff ff       	call   80102c63 <kfree>
801080d3:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801080d6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801080da:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
801080e1:	76 a8                	jbe    8010808b <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801080e3:	83 ec 0c             	sub    $0xc,%esp
801080e6:	ff 75 08             	pushl  0x8(%ebp)
801080e9:	e8 75 ab ff ff       	call   80102c63 <kfree>
801080ee:	83 c4 10             	add    $0x10,%esp
}
801080f1:	90                   	nop
801080f2:	c9                   	leave  
801080f3:	c3                   	ret    

801080f4 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801080f4:	55                   	push   %ebp
801080f5:	89 e5                	mov    %esp,%ebp
801080f7:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801080fa:	83 ec 04             	sub    $0x4,%esp
801080fd:	6a 00                	push   $0x0
801080ff:	ff 75 0c             	pushl  0xc(%ebp)
80108102:	ff 75 08             	pushl  0x8(%ebp)
80108105:	e8 ed f8 ff ff       	call   801079f7 <walkpgdir>
8010810a:	83 c4 10             	add    $0x10,%esp
8010810d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
80108110:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108114:	75 0d                	jne    80108123 <clearpteu+0x2f>
    panic("clearpteu");
80108116:	83 ec 0c             	sub    $0xc,%esp
80108119:	68 64 ba 10 80       	push   $0x8010ba64
8010811e:	e8 43 84 ff ff       	call   80100566 <panic>
  *pte &= ~PTE_U;
80108123:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108126:	8b 00                	mov    (%eax),%eax
80108128:	83 e0 fb             	and    $0xfffffffb,%eax
8010812b:	89 c2                	mov    %eax,%edx
8010812d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108130:	89 10                	mov    %edx,(%eax)
}
80108132:	90                   	nop
80108133:	c9                   	leave  
80108134:	c3                   	ret    

80108135 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108135:	55                   	push   %ebp
80108136:	89 e5                	mov    %esp,%ebp
80108138:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
8010813b:	e8 e7 f9 ff ff       	call   80107b27 <setupkvm>
80108140:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108143:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108147:	75 0a                	jne    80108153 <copyuvm+0x1e>
    return 0;
80108149:	b8 00 00 00 00       	mov    $0x0,%eax
8010814e:	e9 e9 00 00 00       	jmp    8010823c <copyuvm+0x107>
  for(i = 0; i < sz; i += PGSIZE){
80108153:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010815a:	e9 b5 00 00 00       	jmp    80108214 <copyuvm+0xdf>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
8010815f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108162:	83 ec 04             	sub    $0x4,%esp
80108165:	6a 00                	push   $0x0
80108167:	50                   	push   %eax
80108168:	ff 75 08             	pushl  0x8(%ebp)
8010816b:	e8 87 f8 ff ff       	call   801079f7 <walkpgdir>
80108170:	83 c4 10             	add    $0x10,%esp
80108173:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108176:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010817a:	75 0d                	jne    80108189 <copyuvm+0x54>
      panic("copyuvm: pte should exist");
8010817c:	83 ec 0c             	sub    $0xc,%esp
8010817f:	68 6e ba 10 80       	push   $0x8010ba6e
80108184:	e8 dd 83 ff ff       	call   80100566 <panic>
    if(!(*pte & PTE_P))
80108189:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010818c:	8b 00                	mov    (%eax),%eax
8010818e:	83 e0 01             	and    $0x1,%eax
80108191:	85 c0                	test   %eax,%eax
80108193:	75 0d                	jne    801081a2 <copyuvm+0x6d>
      panic("copyuvm: page not present");
80108195:	83 ec 0c             	sub    $0xc,%esp
80108198:	68 88 ba 10 80       	push   $0x8010ba88
8010819d:	e8 c4 83 ff ff       	call   80100566 <panic>
    pa = PTE_ADDR(*pte);
801081a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801081a5:	8b 00                	mov    (%eax),%eax
801081a7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801081ac:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if((mem = kalloc()) == 0)
801081af:	e8 4c ab ff ff       	call   80102d00 <kalloc>
801081b4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801081b7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
801081bb:	74 68                	je     80108225 <copyuvm+0xf0>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
801081bd:	83 ec 0c             	sub    $0xc,%esp
801081c0:	ff 75 e8             	pushl  -0x18(%ebp)
801081c3:	e8 ad f3 ff ff       	call   80107575 <p2v>
801081c8:	83 c4 10             	add    $0x10,%esp
801081cb:	83 ec 04             	sub    $0x4,%esp
801081ce:	68 00 10 00 00       	push   $0x1000
801081d3:	50                   	push   %eax
801081d4:	ff 75 e4             	pushl  -0x1c(%ebp)
801081d7:	e8 83 cf ff ff       	call   8010515f <memmove>
801081dc:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
801081df:	83 ec 0c             	sub    $0xc,%esp
801081e2:	ff 75 e4             	pushl  -0x1c(%ebp)
801081e5:	e8 7e f3 ff ff       	call   80107568 <v2p>
801081ea:	83 c4 10             	add    $0x10,%esp
801081ed:	89 c2                	mov    %eax,%edx
801081ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081f2:	83 ec 0c             	sub    $0xc,%esp
801081f5:	6a 06                	push   $0x6
801081f7:	52                   	push   %edx
801081f8:	68 00 10 00 00       	push   $0x1000
801081fd:	50                   	push   %eax
801081fe:	ff 75 f0             	pushl  -0x10(%ebp)
80108201:	e8 91 f8 ff ff       	call   80107a97 <mappages>
80108206:	83 c4 20             	add    $0x20,%esp
80108209:	85 c0                	test   %eax,%eax
8010820b:	78 1b                	js     80108228 <copyuvm+0xf3>
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010820d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108214:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108217:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010821a:	0f 82 3f ff ff ff    	jb     8010815f <copyuvm+0x2a>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
  }
  return d;
80108220:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108223:	eb 17                	jmp    8010823c <copyuvm+0x107>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
80108225:	90                   	nop
80108226:	eb 01                	jmp    80108229 <copyuvm+0xf4>
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
80108228:	90                   	nop
  }
  return d;

bad:
  freevm(d);
80108229:	83 ec 0c             	sub    $0xc,%esp
8010822c:	ff 75 f0             	pushl  -0x10(%ebp)
8010822f:	e8 20 fe ff ff       	call   80108054 <freevm>
80108234:	83 c4 10             	add    $0x10,%esp
  return 0;
80108237:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010823c:	c9                   	leave  
8010823d:	c3                   	ret    

8010823e <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
8010823e:	55                   	push   %ebp
8010823f:	89 e5                	mov    %esp,%ebp
80108241:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108244:	83 ec 04             	sub    $0x4,%esp
80108247:	6a 00                	push   $0x0
80108249:	ff 75 0c             	pushl  0xc(%ebp)
8010824c:	ff 75 08             	pushl  0x8(%ebp)
8010824f:	e8 a3 f7 ff ff       	call   801079f7 <walkpgdir>
80108254:	83 c4 10             	add    $0x10,%esp
80108257:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
8010825a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010825d:	8b 00                	mov    (%eax),%eax
8010825f:	83 e0 01             	and    $0x1,%eax
80108262:	85 c0                	test   %eax,%eax
80108264:	75 07                	jne    8010826d <uva2ka+0x2f>
    return 0;
80108266:	b8 00 00 00 00       	mov    $0x0,%eax
8010826b:	eb 29                	jmp    80108296 <uva2ka+0x58>
  if((*pte & PTE_U) == 0)
8010826d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108270:	8b 00                	mov    (%eax),%eax
80108272:	83 e0 04             	and    $0x4,%eax
80108275:	85 c0                	test   %eax,%eax
80108277:	75 07                	jne    80108280 <uva2ka+0x42>
    return 0;
80108279:	b8 00 00 00 00       	mov    $0x0,%eax
8010827e:	eb 16                	jmp    80108296 <uva2ka+0x58>
  return (char*)p2v(PTE_ADDR(*pte));
80108280:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108283:	8b 00                	mov    (%eax),%eax
80108285:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010828a:	83 ec 0c             	sub    $0xc,%esp
8010828d:	50                   	push   %eax
8010828e:	e8 e2 f2 ff ff       	call   80107575 <p2v>
80108293:	83 c4 10             	add    $0x10,%esp
}
80108296:	c9                   	leave  
80108297:	c3                   	ret    

80108298 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108298:	55                   	push   %ebp
80108299:	89 e5                	mov    %esp,%ebp
8010829b:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
8010829e:	8b 45 10             	mov    0x10(%ebp),%eax
801082a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
801082a4:	eb 7f                	jmp    80108325 <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
801082a6:	8b 45 0c             	mov    0xc(%ebp),%eax
801082a9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
801082b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801082b4:	83 ec 08             	sub    $0x8,%esp
801082b7:	50                   	push   %eax
801082b8:	ff 75 08             	pushl  0x8(%ebp)
801082bb:	e8 7e ff ff ff       	call   8010823e <uva2ka>
801082c0:	83 c4 10             	add    $0x10,%esp
801082c3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
801082c6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801082ca:	75 07                	jne    801082d3 <copyout+0x3b>
      return -1;
801082cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801082d1:	eb 61                	jmp    80108334 <copyout+0x9c>
    n = PGSIZE - (va - va0);
801082d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801082d6:	2b 45 0c             	sub    0xc(%ebp),%eax
801082d9:	05 00 10 00 00       	add    $0x1000,%eax
801082de:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
801082e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801082e4:	3b 45 14             	cmp    0x14(%ebp),%eax
801082e7:	76 06                	jbe    801082ef <copyout+0x57>
      n = len;
801082e9:	8b 45 14             	mov    0x14(%ebp),%eax
801082ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
801082ef:	8b 45 0c             	mov    0xc(%ebp),%eax
801082f2:	2b 45 ec             	sub    -0x14(%ebp),%eax
801082f5:	89 c2                	mov    %eax,%edx
801082f7:	8b 45 e8             	mov    -0x18(%ebp),%eax
801082fa:	01 d0                	add    %edx,%eax
801082fc:	83 ec 04             	sub    $0x4,%esp
801082ff:	ff 75 f0             	pushl  -0x10(%ebp)
80108302:	ff 75 f4             	pushl  -0xc(%ebp)
80108305:	50                   	push   %eax
80108306:	e8 54 ce ff ff       	call   8010515f <memmove>
8010830b:	83 c4 10             	add    $0x10,%esp
    len -= n;
8010830e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108311:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
80108314:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108317:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
8010831a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010831d:	05 00 10 00 00       	add    $0x1000,%eax
80108322:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108325:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80108329:	0f 85 77 ff ff ff    	jne    801082a6 <copyout+0xe>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010832f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108334:	c9                   	leave  
80108335:	c3                   	ret    

80108336 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
80108336:	55                   	push   %ebp
80108337:	89 e5                	mov    %esp,%ebp
80108339:	83 ec 1c             	sub    $0x1c,%esp
8010833c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010833f:	8b 55 10             	mov    0x10(%ebp),%edx
80108342:	8b 45 14             	mov    0x14(%ebp),%eax
80108345:	88 4d ec             	mov    %cl,-0x14(%ebp)
80108348:	88 55 e8             	mov    %dl,-0x18(%ebp)
8010834b:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
8010834e:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80108352:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
80108355:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
80108359:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
8010835c:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
80108360:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
80108363:	8b 45 08             	mov    0x8(%ebp),%eax
80108366:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
8010836a:	66 89 10             	mov    %dx,(%eax)
8010836d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
80108371:	88 50 02             	mov    %dl,0x2(%eax)
}
80108374:	8b 45 08             	mov    0x8(%ebp),%eax
80108377:	c9                   	leave  
80108378:	c2 04 00             	ret    $0x4

8010837b <APCharacterMove>:
//0 -- left 1--right
int direction = 1;


void APCharacterMove(int direction)
{
8010837b:	55                   	push   %ebp
8010837c:	89 e5                	mov    %esp,%ebp
{

}


}
8010837e:	90                   	nop
8010837f:	5d                   	pop    %ebp
80108380:	c3                   	ret    

80108381 <APDrawCharacter>:

//character_move
void APDrawCharacter(int is_grid)
{
80108381:	55                   	push   %ebp
80108382:	89 e5                	mov    %esp,%ebp
80108384:	56                   	push   %esi
80108385:	53                   	push   %ebx
80108386:	83 ec 20             	sub    $0x20,%esp
    //cprintf("in drawCharacter!\n");
    acquire(&screenLock);
80108389:	83 ec 0c             	sub    $0xc,%esp
8010838c:	68 60 57 11 80       	push   $0x80115760
80108391:	e8 a7 ca ff ff       	call   80104e3d <acquire>
80108396:	83 c4 10             	add    $0x10,%esp
    if (is_grid)
80108399:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010839d:	0f 84 df 01 00 00    	je     80108582 <APDrawCharacter+0x201>
    {
        int off = (character_pre_y * GRID_WIDTH + WND_TITLE_HEIGHT)* screenWidth + character_pre_x * GRID_WIDTH;
801083a3:	a1 a0 e6 10 80       	mov    0x8010e6a0,%eax
801083a8:	83 c0 01             	add    $0x1,%eax
801083ab:	6b d0 32             	imul   $0x32,%eax,%edx
801083ae:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
801083b5:	0f b7 c0             	movzwl %ax,%eax
801083b8:	0f af d0             	imul   %eax,%edx
801083bb:	a1 9c e6 10 80       	mov    0x8010e69c,%eax
801083c0:	6b c0 32             	imul   $0x32,%eax,%eax
801083c3:	01 d0                	add    %edx,%eax
801083c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        int size = sizeof(AColor) * GRID_WIDTH;
801083c8:	c7 45 e4 96 00 00 00 	movl   $0x96,-0x1c(%ebp)
        for (int j = 0; j < GRID_WIDTH; j++)
801083cf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801083d6:	eb 77                	jmp    8010844f <APDrawCharacter+0xce>
        {
            memmove(screenBuf + off, screenContent + off,size);
801083d8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801083db:	8b 1d b0 e6 10 80    	mov    0x8010e6b0,%ebx
801083e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801083e4:	89 d0                	mov    %edx,%eax
801083e6:	01 c0                	add    %eax,%eax
801083e8:	01 d0                	add    %edx,%eax
801083ea:	01 c3                	add    %eax,%ebx
801083ec:	8b 35 ac e6 10 80    	mov    0x8010e6ac,%esi
801083f2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801083f5:	89 d0                	mov    %edx,%eax
801083f7:	01 c0                	add    %eax,%eax
801083f9:	01 d0                	add    %edx,%eax
801083fb:	01 f0                	add    %esi,%eax
801083fd:	83 ec 04             	sub    $0x4,%esp
80108400:	51                   	push   %ecx
80108401:	53                   	push   %ebx
80108402:	50                   	push   %eax
80108403:	e8 57 cd ff ff       	call   8010515f <memmove>
80108408:	83 c4 10             	add    $0x10,%esp
            memmove(screenAddr + off,screenContent + off,size);
8010840b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010840e:	8b 1d b0 e6 10 80    	mov    0x8010e6b0,%ebx
80108414:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108417:	89 d0                	mov    %edx,%eax
80108419:	01 c0                	add    %eax,%eax
8010841b:	01 d0                	add    %edx,%eax
8010841d:	01 c3                	add    %eax,%ebx
8010841f:	8b 35 a8 e6 10 80    	mov    0x8010e6a8,%esi
80108425:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108428:	89 d0                	mov    %edx,%eax
8010842a:	01 c0                	add    %eax,%eax
8010842c:	01 d0                	add    %edx,%eax
8010842e:	01 f0                	add    %esi,%eax
80108430:	83 ec 04             	sub    $0x4,%esp
80108433:	51                   	push   %ecx
80108434:	53                   	push   %ebx
80108435:	50                   	push   %eax
80108436:	e8 24 cd ff ff       	call   8010515f <memmove>
8010843b:	83 c4 10             	add    $0x10,%esp
            off += screenWidth;
8010843e:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80108445:	0f b7 c0             	movzwl %ax,%eax
80108448:	01 45 f4             	add    %eax,-0xc(%ebp)
    acquire(&screenLock);
    if (is_grid)
    {
        int off = (character_pre_y * GRID_WIDTH + WND_TITLE_HEIGHT)* screenWidth + character_pre_x * GRID_WIDTH;
        int size = sizeof(AColor) * GRID_WIDTH;
        for (int j = 0; j < GRID_WIDTH; j++)
8010844b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010844f:	83 7d f0 31          	cmpl   $0x31,-0x10(%ebp)
80108453:	7e 83                	jle    801083d8 <APDrawCharacter+0x57>
        {
            memmove(screenBuf + off, screenContent + off,size);
            memmove(screenAddr + off,screenContent + off,size);
            off += screenWidth;
        }
        off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT) * screenWidth + character_x * GRID_WIDTH;
80108455:	a1 04 e5 10 80       	mov    0x8010e504,%eax
8010845a:	83 c0 01             	add    $0x1,%eax
8010845d:	6b d0 32             	imul   $0x32,%eax,%edx
80108460:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80108467:	0f b7 c0             	movzwl %ax,%eax
8010846a:	0f af d0             	imul   %eax,%edx
8010846d:	a1 00 e5 10 80       	mov    0x8010e500,%eax
80108472:	6b c0 32             	imul   $0x32,%eax,%eax
80108475:	01 d0                	add    %edx,%eax
80108477:	89 45 f4             	mov    %eax,-0xc(%ebp)
        
            
        for (int j = 0; j < GRID_WIDTH; j++)
8010847a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80108481:	e9 f2 00 00 00       	jmp    80108578 <APDrawCharacter+0x1f7>
        {
            for (int i = 0; i < GRID_WIDTH; i++)
80108486:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
8010848d:	e9 cb 00 00 00       	jmp    8010855d <APDrawCharacter+0x1dc>
            {
                AColor c;
                if (direction == 1) c = character_img[i][j];
80108492:	a1 08 e5 10 80       	mov    0x8010e508,%eax
80108497:	83 f8 01             	cmp    $0x1,%eax
8010849a:	75 29                	jne    801084c5 <APDrawCharacter+0x144>
8010849c:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010849f:	8b 4d e8             	mov    -0x18(%ebp),%ecx
801084a2:	89 d0                	mov    %edx,%eax
801084a4:	01 c0                	add    %eax,%eax
801084a6:	01 d0                	add    %edx,%eax
801084a8:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801084ae:	01 d0                	add    %edx,%eax
801084b0:	05 c0 78 11 80       	add    $0x801178c0,%eax
801084b5:	0f b7 10             	movzwl (%eax),%edx
801084b8:	66 89 55 e1          	mov    %dx,-0x1f(%ebp)
801084bc:	0f b6 40 02          	movzbl 0x2(%eax),%eax
801084c0:	88 45 e3             	mov    %al,-0x1d(%ebp)
801084c3:	eb 30                	jmp    801084f5 <APDrawCharacter+0x174>
                else if (direction == 0)  c = character_img2[i][j];
801084c5:	a1 08 e5 10 80       	mov    0x8010e508,%eax
801084ca:	85 c0                	test   %eax,%eax
801084cc:	75 27                	jne    801084f5 <APDrawCharacter+0x174>
801084ce:	8b 55 ec             	mov    -0x14(%ebp),%edx
801084d1:	8b 4d e8             	mov    -0x18(%ebp),%ecx
801084d4:	89 d0                	mov    %edx,%eax
801084d6:	01 c0                	add    %eax,%eax
801084d8:	01 d0                	add    %edx,%eax
801084da:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801084e0:	01 d0                	add    %edx,%eax
801084e2:	05 20 96 11 80       	add    $0x80119620,%eax
801084e7:	0f b7 10             	movzwl (%eax),%edx
801084ea:	66 89 55 e1          	mov    %dx,-0x1f(%ebp)
801084ee:	0f b6 40 02          	movzbl 0x2(%eax),%eax
801084f2:	88 45 e3             	mov    %al,-0x1d(%ebp)
                
                if (c.r != COLOR_TRANSPARENT || c.g != COLOR_TRANSPARENT || c.b != COLOR_TRANSPARENT)
801084f5:	0f b6 45 e3          	movzbl -0x1d(%ebp),%eax
801084f9:	3c 0c                	cmp    $0xc,%al
801084fb:	75 10                	jne    8010850d <APDrawCharacter+0x18c>
801084fd:	0f b6 45 e2          	movzbl -0x1e(%ebp),%eax
80108501:	3c 0c                	cmp    $0xc,%al
80108503:	75 08                	jne    8010850d <APDrawCharacter+0x18c>
80108505:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
80108509:	3c 0c                	cmp    $0xc,%al
8010850b:	74 4c                	je     80108559 <APDrawCharacter+0x1d8>
                {
                    screenBuf[off + i] = c;
8010850d:	8b 15 ac e6 10 80    	mov    0x8010e6ac,%edx
80108513:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80108516:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108519:	01 c8                	add    %ecx,%eax
8010851b:	89 c1                	mov    %eax,%ecx
8010851d:	89 c8                	mov    %ecx,%eax
8010851f:	01 c0                	add    %eax,%eax
80108521:	01 c8                	add    %ecx,%eax
80108523:	01 d0                	add    %edx,%eax
80108525:	0f b7 55 e1          	movzwl -0x1f(%ebp),%edx
80108529:	66 89 10             	mov    %dx,(%eax)
8010852c:	0f b6 55 e3          	movzbl -0x1d(%ebp),%edx
80108530:	88 50 02             	mov    %dl,0x2(%eax)
                    screenAddr[off + i] = c;
80108533:	8b 15 a8 e6 10 80    	mov    0x8010e6a8,%edx
80108539:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010853c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010853f:	01 c8                	add    %ecx,%eax
80108541:	89 c1                	mov    %eax,%ecx
80108543:	89 c8                	mov    %ecx,%eax
80108545:	01 c0                	add    %eax,%eax
80108547:	01 c8                	add    %ecx,%eax
80108549:	01 d0                	add    %edx,%eax
8010854b:	0f b7 55 e1          	movzwl -0x1f(%ebp),%edx
8010854f:	66 89 10             	mov    %dx,(%eax)
80108552:	0f b6 55 e3          	movzbl -0x1d(%ebp),%edx
80108556:	88 50 02             	mov    %dl,0x2(%eax)
        off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT) * screenWidth + character_x * GRID_WIDTH;
        
            
        for (int j = 0; j < GRID_WIDTH; j++)
        {
            for (int i = 0; i < GRID_WIDTH; i++)
80108559:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
8010855d:	83 7d e8 31          	cmpl   $0x31,-0x18(%ebp)
80108561:	0f 8e 2b ff ff ff    	jle    80108492 <APDrawCharacter+0x111>
                {
                    screenBuf[off + i] = c;
                    screenAddr[off + i] = c;
                }
            }
            off += screenWidth;
80108567:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010856e:	0f b7 c0             	movzwl %ax,%eax
80108571:	01 45 f4             	add    %eax,-0xc(%ebp)
            off += screenWidth;
        }
        off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT) * screenWidth + character_x * GRID_WIDTH;
        
            
        for (int j = 0; j < GRID_WIDTH; j++)
80108574:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80108578:	83 7d ec 31          	cmpl   $0x31,-0x14(%ebp)
8010857c:	0f 8e 04 ff ff ff    	jle    80108486 <APDrawCharacter+0x105>
                }
            }
            off += screenWidth;
        }
    }
    release(&screenLock);
80108582:	83 ec 0c             	sub    $0xc,%esp
80108585:	68 60 57 11 80       	push   $0x80115760
8010858a:	e8 15 c9 ff ff       	call   80104ea4 <release>
8010858f:	83 c4 10             	add    $0x10,%esp
}
80108592:	90                   	nop
80108593:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108596:	5b                   	pop    %ebx
80108597:	5e                   	pop    %esi
80108598:	5d                   	pop    %ebp
80108599:	c3                   	ret    

8010859a <APCharacterInit>:
ATimerList timerList;

int timerListReady = 0;

void APCharacterInit(void)
{
8010859a:	55                   	push   %ebp
8010859b:	89 e5                	mov    %esp,%ebp
8010859d:	53                   	push   %ebx
8010859e:	81 ec b4 00 00 00    	sub    $0xb4,%esp
    for (int j = 0; j < GRID_WIDTH; j++)
801085a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801085ab:	e9 a4 00 00 00       	jmp    80108654 <APCharacterInit+0xba>
        for (int i = 0; i < GRID_WIDTH; i++)
801085b0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801085b7:	e9 8a 00 00 00       	jmp    80108646 <APCharacterInit+0xac>
        {
            character_img[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
801085bc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801085bf:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801085c2:	89 d0                	mov    %edx,%eax
801085c4:	01 c0                	add    %eax,%eax
801085c6:	01 d0                	add    %edx,%eax
801085c8:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801085ce:	01 d0                	add    %edx,%eax
801085d0:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801085d6:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801085dc:	6a 0c                	push   $0xc
801085de:	6a 0c                	push   $0xc
801085e0:	6a 0c                	push   $0xc
801085e2:	50                   	push   %eax
801085e3:	e8 4e fd ff ff       	call   80108336 <RGB>
801085e8:	83 c4 0c             	add    $0xc,%esp
801085eb:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801085f2:	66 89 03             	mov    %ax,(%ebx)
801085f5:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801085fc:	88 43 02             	mov    %al,0x2(%ebx)
            character_img2[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
801085ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108602:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80108605:	89 d0                	mov    %edx,%eax
80108607:	01 c0                	add    %eax,%eax
80108609:	01 d0                	add    %edx,%eax
8010860b:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108611:	01 d0                	add    %edx,%eax
80108613:	8d 98 20 96 11 80    	lea    -0x7fee69e0(%eax),%ebx
80108619:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010861f:	6a 0c                	push   $0xc
80108621:	6a 0c                	push   $0xc
80108623:	6a 0c                	push   $0xc
80108625:	50                   	push   %eax
80108626:	e8 0b fd ff ff       	call   80108336 <RGB>
8010862b:	83 c4 0c             	add    $0xc,%esp
8010862e:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108635:	66 89 03             	mov    %ax,(%ebx)
80108638:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010863f:	88 43 02             	mov    %al,0x2(%ebx)
int timerListReady = 0;

void APCharacterInit(void)
{
    for (int j = 0; j < GRID_WIDTH; j++)
        for (int i = 0; i < GRID_WIDTH; i++)
80108642:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80108646:	83 7d f0 31          	cmpl   $0x31,-0x10(%ebp)
8010864a:	0f 8e 6c ff ff ff    	jle    801085bc <APCharacterInit+0x22>

int timerListReady = 0;

void APCharacterInit(void)
{
    for (int j = 0; j < GRID_WIDTH; j++)
80108650:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108654:	83 7d f4 31          	cmpl   $0x31,-0xc(%ebp)
80108658:	0f 8e 52 ff ff ff    	jle    801085b0 <APCharacterInit+0x16>
            character_img[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
            character_img2[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
        }
    //

    int line=0;
8010865e:	c7 85 64 ff ff ff 00 	movl   $0x0,-0x9c(%ebp)
80108665:	00 00 00 
  
    for(int j=line;j<line+3;j++)
80108668:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010866e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108671:	eb 5d                	jmp    801086d0 <APCharacterInit+0x136>
	for(int i=10;i<25;i++)
80108673:	c7 45 e8 0a 00 00 00 	movl   $0xa,-0x18(%ebp)
8010867a:	eb 4a                	jmp    801086c6 <APCharacterInit+0x12c>
		character_img[i][j] = RGB(0xff,0x00,0x00);
8010867c:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010867f:	8b 4d e8             	mov    -0x18(%ebp),%ecx
80108682:	89 d0                	mov    %edx,%eax
80108684:	01 c0                	add    %eax,%eax
80108686:	01 d0                	add    %edx,%eax
80108688:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010868e:	01 d0                	add    %edx,%eax
80108690:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108696:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010869c:	6a 00                	push   $0x0
8010869e:	6a 00                	push   $0x0
801086a0:	68 ff 00 00 00       	push   $0xff
801086a5:	50                   	push   %eax
801086a6:	e8 8b fc ff ff       	call   80108336 <RGB>
801086ab:	83 c4 0c             	add    $0xc,%esp
801086ae:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801086b5:	66 89 03             	mov    %ax,(%ebx)
801086b8:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801086bf:	88 43 02             	mov    %al,0x2(%ebx)
    //

    int line=0;
  
    for(int j=line;j<line+3;j++)
	for(int i=10;i<25;i++)
801086c2:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
801086c6:	83 7d e8 18          	cmpl   $0x18,-0x18(%ebp)
801086ca:	7e b0                	jle    8010867c <APCharacterInit+0xe2>
        }
    //

    int line=0;
  
    for(int j=line;j<line+3;j++)
801086cc:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801086d0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801086d6:	83 c0 03             	add    $0x3,%eax
801086d9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801086dc:	7f 95                	jg     80108673 <APCharacterInit+0xd9>
	for(int i=10;i<25;i++)
		character_img[i][j] = RGB(0xff,0x00,0x00);
    line=line+3;
801086de:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
    for(int j=line;j<line+3;j++)
801086e5:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801086eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801086ee:	eb 5d                	jmp    8010874d <APCharacterInit+0x1b3>
        for(int i=5;i<40;i++)
801086f0:	c7 45 e0 05 00 00 00 	movl   $0x5,-0x20(%ebp)
801086f7:	eb 4a                	jmp    80108743 <APCharacterInit+0x1a9>
            character_img[i][j] = RGB(0xff,0x00,0x00);
801086f9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801086fc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801086ff:	89 d0                	mov    %edx,%eax
80108701:	01 c0                	add    %eax,%eax
80108703:	01 d0                	add    %edx,%eax
80108705:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010870b:	01 d0                	add    %edx,%eax
8010870d:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108713:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108719:	6a 00                	push   $0x0
8010871b:	6a 00                	push   $0x0
8010871d:	68 ff 00 00 00       	push   $0xff
80108722:	50                   	push   %eax
80108723:	e8 0e fc ff ff       	call   80108336 <RGB>
80108728:	83 c4 0c             	add    $0xc,%esp
8010872b:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108732:	66 89 03             	mov    %ax,(%ebx)
80108735:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010873c:	88 43 02             	mov    %al,0x2(%ebx)
    for(int j=line;j<line+3;j++)
	for(int i=10;i<25;i++)
		character_img[i][j] = RGB(0xff,0x00,0x00);
    line=line+3;
    for(int j=line;j<line+3;j++)
        for(int i=5;i<40;i++)
8010873f:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
80108743:	83 7d e0 27          	cmpl   $0x27,-0x20(%ebp)
80108747:	7e b0                	jle    801086f9 <APCharacterInit+0x15f>
  
    for(int j=line;j<line+3;j++)
	for(int i=10;i<25;i++)
		character_img[i][j] = RGB(0xff,0x00,0x00);
    line=line+3;
    for(int j=line;j<line+3;j++)
80108749:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010874d:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108753:	83 c0 03             	add    $0x3,%eax
80108756:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
80108759:	7f 95                	jg     801086f0 <APCharacterInit+0x156>
        for(int i=5;i<40;i++)
            character_img[i][j] = RGB(0xff,0x00,0x00);

    line=line+3;
8010875b:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)

    for(int j=line;j<line+3;j++){
80108762:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108768:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010876b:	e9 78 01 00 00       	jmp    801088e8 <APCharacterInit+0x34e>
        for(int i=5;i<30;i++){
80108770:	c7 45 d8 05 00 00 00 	movl   $0x5,-0x28(%ebp)
80108777:	e9 5e 01 00 00       	jmp    801088da <APCharacterInit+0x340>
               if(i<15)
8010877c:	83 7d d8 0e          	cmpl   $0xe,-0x28(%ebp)
80108780:	7f 4b                	jg     801087cd <APCharacterInit+0x233>
			character_img[i][j] = RGB(128,64,0);
80108782:	8b 55 dc             	mov    -0x24(%ebp),%edx
80108785:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80108788:	89 d0                	mov    %edx,%eax
8010878a:	01 c0                	add    %eax,%eax
8010878c:	01 d0                	add    %edx,%eax
8010878e:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108794:	01 d0                	add    %edx,%eax
80108796:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010879c:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801087a2:	6a 00                	push   $0x0
801087a4:	6a 40                	push   $0x40
801087a6:	68 80 00 00 00       	push   $0x80
801087ab:	50                   	push   %eax
801087ac:	e8 85 fb ff ff       	call   80108336 <RGB>
801087b1:	83 c4 0c             	add    $0xc,%esp
801087b4:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801087bb:	66 89 03             	mov    %ax,(%ebx)
801087be:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801087c5:	88 43 02             	mov    %al,0x2(%ebx)
801087c8:	e9 09 01 00 00       	jmp    801088d6 <APCharacterInit+0x33c>
		else if(i>=15&&i<22)
801087cd:	83 7d d8 0e          	cmpl   $0xe,-0x28(%ebp)
801087d1:	7e 57                	jle    8010882a <APCharacterInit+0x290>
801087d3:	83 7d d8 15          	cmpl   $0x15,-0x28(%ebp)
801087d7:	7f 51                	jg     8010882a <APCharacterInit+0x290>
			character_img[i][j] = RGB(249,236,236);
801087d9:	8b 55 dc             	mov    -0x24(%ebp),%edx
801087dc:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801087df:	89 d0                	mov    %edx,%eax
801087e1:	01 c0                	add    %eax,%eax
801087e3:	01 d0                	add    %edx,%eax
801087e5:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801087eb:	01 d0                	add    %edx,%eax
801087ed:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801087f3:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801087f9:	68 ec 00 00 00       	push   $0xec
801087fe:	68 ec 00 00 00       	push   $0xec
80108803:	68 f9 00 00 00       	push   $0xf9
80108808:	50                   	push   %eax
80108809:	e8 28 fb ff ff       	call   80108336 <RGB>
8010880e:	83 c4 0c             	add    $0xc,%esp
80108811:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108818:	66 89 03             	mov    %ax,(%ebx)
8010881b:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108822:	88 43 02             	mov    %al,0x2(%ebx)
80108825:	e9 ac 00 00 00       	jmp    801088d6 <APCharacterInit+0x33c>
		else if(i>=22&&i<26)
8010882a:	83 7d d8 15          	cmpl   $0x15,-0x28(%ebp)
8010882e:	7e 4e                	jle    8010887e <APCharacterInit+0x2e4>
80108830:	83 7d d8 19          	cmpl   $0x19,-0x28(%ebp)
80108834:	7f 48                	jg     8010887e <APCharacterInit+0x2e4>
			character_img[i][j] = RGB(128,64,0);
80108836:	8b 55 dc             	mov    -0x24(%ebp),%edx
80108839:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010883c:	89 d0                	mov    %edx,%eax
8010883e:	01 c0                	add    %eax,%eax
80108840:	01 d0                	add    %edx,%eax
80108842:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108848:	01 d0                	add    %edx,%eax
8010884a:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108850:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108856:	6a 00                	push   $0x0
80108858:	6a 40                	push   $0x40
8010885a:	68 80 00 00 00       	push   $0x80
8010885f:	50                   	push   %eax
80108860:	e8 d1 fa ff ff       	call   80108336 <RGB>
80108865:	83 c4 0c             	add    $0xc,%esp
80108868:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010886f:	66 89 03             	mov    %ax,(%ebx)
80108872:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108879:	88 43 02             	mov    %al,0x2(%ebx)
8010887c:	eb 58                	jmp    801088d6 <APCharacterInit+0x33c>
		else if(i>=26&&i<30)
8010887e:	83 7d d8 19          	cmpl   $0x19,-0x28(%ebp)
80108882:	7e 52                	jle    801088d6 <APCharacterInit+0x33c>
80108884:	83 7d d8 1d          	cmpl   $0x1d,-0x28(%ebp)
80108888:	7f 4c                	jg     801088d6 <APCharacterInit+0x33c>
			character_img[i][j] = RGB(249,236,236);
8010888a:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010888d:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80108890:	89 d0                	mov    %edx,%eax
80108892:	01 c0                	add    %eax,%eax
80108894:	01 d0                	add    %edx,%eax
80108896:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010889c:	01 d0                	add    %edx,%eax
8010889e:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801088a4:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801088aa:	68 ec 00 00 00       	push   $0xec
801088af:	68 ec 00 00 00       	push   $0xec
801088b4:	68 f9 00 00 00       	push   $0xf9
801088b9:	50                   	push   %eax
801088ba:	e8 77 fa ff ff       	call   80108336 <RGB>
801088bf:	83 c4 0c             	add    $0xc,%esp
801088c2:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801088c9:	66 89 03             	mov    %ax,(%ebx)
801088cc:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801088d3:	88 43 02             	mov    %al,0x2(%ebx)
            character_img[i][j] = RGB(0xff,0x00,0x00);

    line=line+3;

    for(int j=line;j<line+3;j++){
        for(int i=5;i<30;i++){
801088d6:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
801088da:	83 7d d8 1d          	cmpl   $0x1d,-0x28(%ebp)
801088de:	0f 8e 98 fe ff ff    	jle    8010877c <APCharacterInit+0x1e2>
        for(int i=5;i<40;i++)
            character_img[i][j] = RGB(0xff,0x00,0x00);

    line=line+3;

    for(int j=line;j<line+3;j++){
801088e4:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
801088e8:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801088ee:	83 c0 03             	add    $0x3,%eax
801088f1:	3b 45 dc             	cmp    -0x24(%ebp),%eax
801088f4:	0f 8f 76 fe ff ff    	jg     80108770 <APCharacterInit+0x1d6>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=26&&i<30)
			character_img[i][j] = RGB(249,236,236);

        }}
line=line+3;
801088fa:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108901:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108907:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010890a:	e9 2c 02 00 00       	jmp    80108b3b <APCharacterInit+0x5a1>
	for(int i=0;i<40;i++){
8010890f:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
80108916:	e9 12 02 00 00       	jmp    80108b2d <APCharacterInit+0x593>
               if(i<5)
8010891b:	83 7d d0 04          	cmpl   $0x4,-0x30(%ebp)
8010891f:	7f 4b                	jg     8010896c <APCharacterInit+0x3d2>
			character_img[i][j] = RGB(128,64,0);
80108921:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80108924:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80108927:	89 d0                	mov    %edx,%eax
80108929:	01 c0                	add    %eax,%eax
8010892b:	01 d0                	add    %edx,%eax
8010892d:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108933:	01 d0                	add    %edx,%eax
80108935:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010893b:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108941:	6a 00                	push   $0x0
80108943:	6a 40                	push   $0x40
80108945:	68 80 00 00 00       	push   $0x80
8010894a:	50                   	push   %eax
8010894b:	e8 e6 f9 ff ff       	call   80108336 <RGB>
80108950:	83 c4 0c             	add    $0xc,%esp
80108953:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010895a:	66 89 03             	mov    %ax,(%ebx)
8010895d:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108964:	88 43 02             	mov    %al,0x2(%ebx)
80108967:	e9 bd 01 00 00       	jmp    80108b29 <APCharacterInit+0x58f>
		else if(i>=5&&i<10)
8010896c:	83 7d d0 04          	cmpl   $0x4,-0x30(%ebp)
80108970:	7e 57                	jle    801089c9 <APCharacterInit+0x42f>
80108972:	83 7d d0 09          	cmpl   $0x9,-0x30(%ebp)
80108976:	7f 51                	jg     801089c9 <APCharacterInit+0x42f>
			character_img[i][j] = RGB(249,236,236);
80108978:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010897b:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010897e:	89 d0                	mov    %edx,%eax
80108980:	01 c0                	add    %eax,%eax
80108982:	01 d0                	add    %edx,%eax
80108984:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010898a:	01 d0                	add    %edx,%eax
8010898c:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108992:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108998:	68 ec 00 00 00       	push   $0xec
8010899d:	68 ec 00 00 00       	push   $0xec
801089a2:	68 f9 00 00 00       	push   $0xf9
801089a7:	50                   	push   %eax
801089a8:	e8 89 f9 ff ff       	call   80108336 <RGB>
801089ad:	83 c4 0c             	add    $0xc,%esp
801089b0:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801089b7:	66 89 03             	mov    %ax,(%ebx)
801089ba:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801089c1:	88 43 02             	mov    %al,0x2(%ebx)
801089c4:	e9 60 01 00 00       	jmp    80108b29 <APCharacterInit+0x58f>
		else if(i>=10&&i<13)
801089c9:	83 7d d0 09          	cmpl   $0x9,-0x30(%ebp)
801089cd:	7e 51                	jle    80108a20 <APCharacterInit+0x486>
801089cf:	83 7d d0 0c          	cmpl   $0xc,-0x30(%ebp)
801089d3:	7f 4b                	jg     80108a20 <APCharacterInit+0x486>
			character_img[i][j] = RGB(128,64,0);
801089d5:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801089d8:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801089db:	89 d0                	mov    %edx,%eax
801089dd:	01 c0                	add    %eax,%eax
801089df:	01 d0                	add    %edx,%eax
801089e1:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801089e7:	01 d0                	add    %edx,%eax
801089e9:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801089ef:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801089f5:	6a 00                	push   $0x0
801089f7:	6a 40                	push   $0x40
801089f9:	68 80 00 00 00       	push   $0x80
801089fe:	50                   	push   %eax
801089ff:	e8 32 f9 ff ff       	call   80108336 <RGB>
80108a04:	83 c4 0c             	add    $0xc,%esp
80108a07:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108a0e:	66 89 03             	mov    %ax,(%ebx)
80108a11:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108a18:	88 43 02             	mov    %al,0x2(%ebx)
80108a1b:	e9 09 01 00 00       	jmp    80108b29 <APCharacterInit+0x58f>
		else if(i>=13&&i<22)
80108a20:	83 7d d0 0c          	cmpl   $0xc,-0x30(%ebp)
80108a24:	7e 57                	jle    80108a7d <APCharacterInit+0x4e3>
80108a26:	83 7d d0 15          	cmpl   $0x15,-0x30(%ebp)
80108a2a:	7f 51                	jg     80108a7d <APCharacterInit+0x4e3>
			character_img[i][j] = RGB(249,236,236);
80108a2c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80108a2f:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80108a32:	89 d0                	mov    %edx,%eax
80108a34:	01 c0                	add    %eax,%eax
80108a36:	01 d0                	add    %edx,%eax
80108a38:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108a3e:	01 d0                	add    %edx,%eax
80108a40:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108a46:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108a4c:	68 ec 00 00 00       	push   $0xec
80108a51:	68 ec 00 00 00       	push   $0xec
80108a56:	68 f9 00 00 00       	push   $0xf9
80108a5b:	50                   	push   %eax
80108a5c:	e8 d5 f8 ff ff       	call   80108336 <RGB>
80108a61:	83 c4 0c             	add    $0xc,%esp
80108a64:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108a6b:	66 89 03             	mov    %ax,(%ebx)
80108a6e:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108a75:	88 43 02             	mov    %al,0x2(%ebx)
80108a78:	e9 ac 00 00 00       	jmp    80108b29 <APCharacterInit+0x58f>
		else if(i>=22&&i<26)
80108a7d:	83 7d d0 15          	cmpl   $0x15,-0x30(%ebp)
80108a81:	7e 4e                	jle    80108ad1 <APCharacterInit+0x537>
80108a83:	83 7d d0 19          	cmpl   $0x19,-0x30(%ebp)
80108a87:	7f 48                	jg     80108ad1 <APCharacterInit+0x537>
			character_img[i][j] = RGB(128,64,0);
80108a89:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80108a8c:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80108a8f:	89 d0                	mov    %edx,%eax
80108a91:	01 c0                	add    %eax,%eax
80108a93:	01 d0                	add    %edx,%eax
80108a95:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108a9b:	01 d0                	add    %edx,%eax
80108a9d:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108aa3:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108aa9:	6a 00                	push   $0x0
80108aab:	6a 40                	push   $0x40
80108aad:	68 80 00 00 00       	push   $0x80
80108ab2:	50                   	push   %eax
80108ab3:	e8 7e f8 ff ff       	call   80108336 <RGB>
80108ab8:	83 c4 0c             	add    $0xc,%esp
80108abb:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108ac2:	66 89 03             	mov    %ax,(%ebx)
80108ac5:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108acc:	88 43 02             	mov    %al,0x2(%ebx)
80108acf:	eb 58                	jmp    80108b29 <APCharacterInit+0x58f>
		else if(i>=26&&i<35)
80108ad1:	83 7d d0 19          	cmpl   $0x19,-0x30(%ebp)
80108ad5:	7e 52                	jle    80108b29 <APCharacterInit+0x58f>
80108ad7:	83 7d d0 22          	cmpl   $0x22,-0x30(%ebp)
80108adb:	7f 4c                	jg     80108b29 <APCharacterInit+0x58f>
			character_img[i][j] = RGB(249,236,236);
80108add:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80108ae0:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80108ae3:	89 d0                	mov    %edx,%eax
80108ae5:	01 c0                	add    %eax,%eax
80108ae7:	01 d0                	add    %edx,%eax
80108ae9:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108aef:	01 d0                	add    %edx,%eax
80108af1:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108af7:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108afd:	68 ec 00 00 00       	push   $0xec
80108b02:	68 ec 00 00 00       	push   $0xec
80108b07:	68 f9 00 00 00       	push   $0xf9
80108b0c:	50                   	push   %eax
80108b0d:	e8 24 f8 ff ff       	call   80108336 <RGB>
80108b12:	83 c4 0c             	add    $0xc,%esp
80108b15:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108b1c:	66 89 03             	mov    %ax,(%ebx)
80108b1f:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108b26:	88 43 02             	mov    %al,0x2(%ebx)
			character_img[i][j] = RGB(249,236,236);

        }}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80108b29:	83 45 d0 01          	addl   $0x1,-0x30(%ebp)
80108b2d:	83 7d d0 27          	cmpl   $0x27,-0x30(%ebp)
80108b31:	0f 8e e4 fd ff ff    	jle    8010891b <APCharacterInit+0x381>
		else if(i>=26&&i<30)
			character_img[i][j] = RGB(249,236,236);

        }}
line=line+3;
  for(int j=line;j<line+3;j++){
80108b37:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
80108b3b:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108b41:	83 c0 03             	add    $0x3,%eax
80108b44:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
80108b47:	0f 8f c2 fd ff ff    	jg     8010890f <APCharacterInit+0x375>
		else if(i>=22&&i<26)
			character_img[i][j] = RGB(128,64,0);
		else if(i>=26&&i<35)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
80108b4d:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108b54:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108b5a:	89 45 cc             	mov    %eax,-0x34(%ebp)
80108b5d:	e9 2c 02 00 00       	jmp    80108d8e <APCharacterInit+0x7f4>
	for(int i=0;i<44;i++){
80108b62:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
80108b69:	e9 12 02 00 00       	jmp    80108d80 <APCharacterInit+0x7e6>
               if(i<5)
80108b6e:	83 7d c8 04          	cmpl   $0x4,-0x38(%ebp)
80108b72:	7f 4b                	jg     80108bbf <APCharacterInit+0x625>
			character_img[i][j] = RGB(128,64,0);
80108b74:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108b77:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108b7a:	89 d0                	mov    %edx,%eax
80108b7c:	01 c0                	add    %eax,%eax
80108b7e:	01 d0                	add    %edx,%eax
80108b80:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108b86:	01 d0                	add    %edx,%eax
80108b88:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108b8e:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108b94:	6a 00                	push   $0x0
80108b96:	6a 40                	push   $0x40
80108b98:	68 80 00 00 00       	push   $0x80
80108b9d:	50                   	push   %eax
80108b9e:	e8 93 f7 ff ff       	call   80108336 <RGB>
80108ba3:	83 c4 0c             	add    $0xc,%esp
80108ba6:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108bad:	66 89 03             	mov    %ax,(%ebx)
80108bb0:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108bb7:	88 43 02             	mov    %al,0x2(%ebx)
80108bba:	e9 bd 01 00 00       	jmp    80108d7c <APCharacterInit+0x7e2>
		else if(i>=5&&i<10)
80108bbf:	83 7d c8 04          	cmpl   $0x4,-0x38(%ebp)
80108bc3:	7e 57                	jle    80108c1c <APCharacterInit+0x682>
80108bc5:	83 7d c8 09          	cmpl   $0x9,-0x38(%ebp)
80108bc9:	7f 51                	jg     80108c1c <APCharacterInit+0x682>
			character_img[i][j] = RGB(249,236,236);
80108bcb:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108bce:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108bd1:	89 d0                	mov    %edx,%eax
80108bd3:	01 c0                	add    %eax,%eax
80108bd5:	01 d0                	add    %edx,%eax
80108bd7:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108bdd:	01 d0                	add    %edx,%eax
80108bdf:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108be5:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108beb:	68 ec 00 00 00       	push   $0xec
80108bf0:	68 ec 00 00 00       	push   $0xec
80108bf5:	68 f9 00 00 00       	push   $0xf9
80108bfa:	50                   	push   %eax
80108bfb:	e8 36 f7 ff ff       	call   80108336 <RGB>
80108c00:	83 c4 0c             	add    $0xc,%esp
80108c03:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108c0a:	66 89 03             	mov    %ax,(%ebx)
80108c0d:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108c14:	88 43 02             	mov    %al,0x2(%ebx)
80108c17:	e9 60 01 00 00       	jmp    80108d7c <APCharacterInit+0x7e2>
		else if(i>=10&&i<16)
80108c1c:	83 7d c8 09          	cmpl   $0x9,-0x38(%ebp)
80108c20:	7e 51                	jle    80108c73 <APCharacterInit+0x6d9>
80108c22:	83 7d c8 0f          	cmpl   $0xf,-0x38(%ebp)
80108c26:	7f 4b                	jg     80108c73 <APCharacterInit+0x6d9>
			character_img[i][j] = RGB(128,64,0);
80108c28:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108c2b:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108c2e:	89 d0                	mov    %edx,%eax
80108c30:	01 c0                	add    %eax,%eax
80108c32:	01 d0                	add    %edx,%eax
80108c34:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108c3a:	01 d0                	add    %edx,%eax
80108c3c:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108c42:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108c48:	6a 00                	push   $0x0
80108c4a:	6a 40                	push   $0x40
80108c4c:	68 80 00 00 00       	push   $0x80
80108c51:	50                   	push   %eax
80108c52:	e8 df f6 ff ff       	call   80108336 <RGB>
80108c57:	83 c4 0c             	add    $0xc,%esp
80108c5a:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108c61:	66 89 03             	mov    %ax,(%ebx)
80108c64:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108c6b:	88 43 02             	mov    %al,0x2(%ebx)
80108c6e:	e9 09 01 00 00       	jmp    80108d7c <APCharacterInit+0x7e2>
		else if(i>=16&&i<26)
80108c73:	83 7d c8 0f          	cmpl   $0xf,-0x38(%ebp)
80108c77:	7e 57                	jle    80108cd0 <APCharacterInit+0x736>
80108c79:	83 7d c8 19          	cmpl   $0x19,-0x38(%ebp)
80108c7d:	7f 51                	jg     80108cd0 <APCharacterInit+0x736>
			character_img[i][j] = RGB(249,236,236);
80108c7f:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108c82:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108c85:	89 d0                	mov    %edx,%eax
80108c87:	01 c0                	add    %eax,%eax
80108c89:	01 d0                	add    %edx,%eax
80108c8b:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108c91:	01 d0                	add    %edx,%eax
80108c93:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108c99:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108c9f:	68 ec 00 00 00       	push   $0xec
80108ca4:	68 ec 00 00 00       	push   $0xec
80108ca9:	68 f9 00 00 00       	push   $0xf9
80108cae:	50                   	push   %eax
80108caf:	e8 82 f6 ff ff       	call   80108336 <RGB>
80108cb4:	83 c4 0c             	add    $0xc,%esp
80108cb7:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108cbe:	66 89 03             	mov    %ax,(%ebx)
80108cc1:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108cc8:	88 43 02             	mov    %al,0x2(%ebx)
80108ccb:	e9 ac 00 00 00       	jmp    80108d7c <APCharacterInit+0x7e2>
		else if(i>=26&&i<30)
80108cd0:	83 7d c8 19          	cmpl   $0x19,-0x38(%ebp)
80108cd4:	7e 4e                	jle    80108d24 <APCharacterInit+0x78a>
80108cd6:	83 7d c8 1d          	cmpl   $0x1d,-0x38(%ebp)
80108cda:	7f 48                	jg     80108d24 <APCharacterInit+0x78a>
			character_img[i][j] = RGB(128,64,0);
80108cdc:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108cdf:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108ce2:	89 d0                	mov    %edx,%eax
80108ce4:	01 c0                	add    %eax,%eax
80108ce6:	01 d0                	add    %edx,%eax
80108ce8:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108cee:	01 d0                	add    %edx,%eax
80108cf0:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108cf6:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108cfc:	6a 00                	push   $0x0
80108cfe:	6a 40                	push   $0x40
80108d00:	68 80 00 00 00       	push   $0x80
80108d05:	50                   	push   %eax
80108d06:	e8 2b f6 ff ff       	call   80108336 <RGB>
80108d0b:	83 c4 0c             	add    $0xc,%esp
80108d0e:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108d15:	66 89 03             	mov    %ax,(%ebx)
80108d18:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108d1f:	88 43 02             	mov    %al,0x2(%ebx)
80108d22:	eb 58                	jmp    80108d7c <APCharacterInit+0x7e2>
		else if(i>=30&&i<40)
80108d24:	83 7d c8 1d          	cmpl   $0x1d,-0x38(%ebp)
80108d28:	7e 52                	jle    80108d7c <APCharacterInit+0x7e2>
80108d2a:	83 7d c8 27          	cmpl   $0x27,-0x38(%ebp)
80108d2e:	7f 4c                	jg     80108d7c <APCharacterInit+0x7e2>
			character_img[i][j] = RGB(249,236,236);
80108d30:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108d33:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108d36:	89 d0                	mov    %edx,%eax
80108d38:	01 c0                	add    %eax,%eax
80108d3a:	01 d0                	add    %edx,%eax
80108d3c:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108d42:	01 d0                	add    %edx,%eax
80108d44:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108d4a:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108d50:	68 ec 00 00 00       	push   $0xec
80108d55:	68 ec 00 00 00       	push   $0xec
80108d5a:	68 f9 00 00 00       	push   $0xf9
80108d5f:	50                   	push   %eax
80108d60:	e8 d1 f5 ff ff       	call   80108336 <RGB>
80108d65:	83 c4 0c             	add    $0xc,%esp
80108d68:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108d6f:	66 89 03             	mov    %ax,(%ebx)
80108d72:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108d79:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=26&&i<35)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<44;i++){
80108d7c:	83 45 c8 01          	addl   $0x1,-0x38(%ebp)
80108d80:	83 7d c8 2b          	cmpl   $0x2b,-0x38(%ebp)
80108d84:	0f 8e e4 fd ff ff    	jle    80108b6e <APCharacterInit+0x5d4>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=26&&i<35)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
80108d8a:	83 45 cc 01          	addl   $0x1,-0x34(%ebp)
80108d8e:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108d94:	83 c0 03             	add    $0x3,%eax
80108d97:	3b 45 cc             	cmp    -0x34(%ebp),%eax
80108d9a:	0f 8f c2 fd ff ff    	jg     80108b62 <APCharacterInit+0x5c8>
		else if(i>=26&&i<30)
			character_img[i][j] = RGB(128,64,0);
		else if(i>=30&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
80108da0:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108da7:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108dad:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80108db0:	e9 1b 01 00 00       	jmp    80108ed0 <APCharacterInit+0x936>
	for(int i=0;i<40;i++){
80108db5:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
80108dbc:	e9 01 01 00 00       	jmp    80108ec2 <APCharacterInit+0x928>
               if(i<10)
80108dc1:	83 7d c0 09          	cmpl   $0x9,-0x40(%ebp)
80108dc5:	7f 4b                	jg     80108e12 <APCharacterInit+0x878>
			character_img[i][j] = RGB(128,64,0);
80108dc7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80108dca:	8b 4d c0             	mov    -0x40(%ebp),%ecx
80108dcd:	89 d0                	mov    %edx,%eax
80108dcf:	01 c0                	add    %eax,%eax
80108dd1:	01 d0                	add    %edx,%eax
80108dd3:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108dd9:	01 d0                	add    %edx,%eax
80108ddb:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108de1:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108de7:	6a 00                	push   $0x0
80108de9:	6a 40                	push   $0x40
80108deb:	68 80 00 00 00       	push   $0x80
80108df0:	50                   	push   %eax
80108df1:	e8 40 f5 ff ff       	call   80108336 <RGB>
80108df6:	83 c4 0c             	add    $0xc,%esp
80108df9:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108e00:	66 89 03             	mov    %ax,(%ebx)
80108e03:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108e0a:	88 43 02             	mov    %al,0x2(%ebx)
80108e0d:	e9 ac 00 00 00       	jmp    80108ebe <APCharacterInit+0x924>
		else if(i>=10&&i<22)
80108e12:	83 7d c0 09          	cmpl   $0x9,-0x40(%ebp)
80108e16:	7e 54                	jle    80108e6c <APCharacterInit+0x8d2>
80108e18:	83 7d c0 15          	cmpl   $0x15,-0x40(%ebp)
80108e1c:	7f 4e                	jg     80108e6c <APCharacterInit+0x8d2>
			character_img[i][j] = RGB(249,236,236);
80108e1e:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80108e21:	8b 4d c0             	mov    -0x40(%ebp),%ecx
80108e24:	89 d0                	mov    %edx,%eax
80108e26:	01 c0                	add    %eax,%eax
80108e28:	01 d0                	add    %edx,%eax
80108e2a:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108e30:	01 d0                	add    %edx,%eax
80108e32:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108e38:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108e3e:	68 ec 00 00 00       	push   $0xec
80108e43:	68 ec 00 00 00       	push   $0xec
80108e48:	68 f9 00 00 00       	push   $0xf9
80108e4d:	50                   	push   %eax
80108e4e:	e8 e3 f4 ff ff       	call   80108336 <RGB>
80108e53:	83 c4 0c             	add    $0xc,%esp
80108e56:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108e5d:	66 89 03             	mov    %ax,(%ebx)
80108e60:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108e67:	88 43 02             	mov    %al,0x2(%ebx)
80108e6a:	eb 52                	jmp    80108ebe <APCharacterInit+0x924>
		else if(i>=22&&i<35)
80108e6c:	83 7d c0 15          	cmpl   $0x15,-0x40(%ebp)
80108e70:	7e 4c                	jle    80108ebe <APCharacterInit+0x924>
80108e72:	83 7d c0 22          	cmpl   $0x22,-0x40(%ebp)
80108e76:	7f 46                	jg     80108ebe <APCharacterInit+0x924>
			character_img[i][j] = RGB(128,64,0);
80108e78:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80108e7b:	8b 4d c0             	mov    -0x40(%ebp),%ecx
80108e7e:	89 d0                	mov    %edx,%eax
80108e80:	01 c0                	add    %eax,%eax
80108e82:	01 d0                	add    %edx,%eax
80108e84:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108e8a:	01 d0                	add    %edx,%eax
80108e8c:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108e92:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108e98:	6a 00                	push   $0x0
80108e9a:	6a 40                	push   $0x40
80108e9c:	68 80 00 00 00       	push   $0x80
80108ea1:	50                   	push   %eax
80108ea2:	e8 8f f4 ff ff       	call   80108336 <RGB>
80108ea7:	83 c4 0c             	add    $0xc,%esp
80108eaa:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108eb1:	66 89 03             	mov    %ax,(%ebx)
80108eb4:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108ebb:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=30&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80108ebe:	83 45 c0 01          	addl   $0x1,-0x40(%ebp)
80108ec2:	83 7d c0 27          	cmpl   $0x27,-0x40(%ebp)
80108ec6:	0f 8e f5 fe ff ff    	jle    80108dc1 <APCharacterInit+0x827>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=30&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
80108ecc:	83 45 c4 01          	addl   $0x1,-0x3c(%ebp)
80108ed0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108ed6:	83 c0 03             	add    $0x3,%eax
80108ed9:	3b 45 c4             	cmp    -0x3c(%ebp),%eax
80108edc:	0f 8f d3 fe ff ff    	jg     80108db5 <APCharacterInit+0x81b>
			character_img[i][j] = RGB(249,236,236);
		else if(i>=22&&i<35)
			character_img[i][j] = RGB(128,64,0);
		
}}
line=line+3;
80108ee2:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108ee9:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108eef:	89 45 bc             	mov    %eax,-0x44(%ebp)
80108ef2:	eb 69                	jmp    80108f5d <APCharacterInit+0x9c3>
	for(int i=10;i<40;i++){
80108ef4:	c7 45 b8 0a 00 00 00 	movl   $0xa,-0x48(%ebp)
80108efb:	eb 56                	jmp    80108f53 <APCharacterInit+0x9b9>
               if(i<30)
80108efd:	83 7d b8 1d          	cmpl   $0x1d,-0x48(%ebp)
80108f01:	7f 4c                	jg     80108f4f <APCharacterInit+0x9b5>
			character_img[i][j] = RGB(249,236,236);
80108f03:	8b 55 bc             	mov    -0x44(%ebp),%edx
80108f06:	8b 4d b8             	mov    -0x48(%ebp),%ecx
80108f09:	89 d0                	mov    %edx,%eax
80108f0b:	01 c0                	add    %eax,%eax
80108f0d:	01 d0                	add    %edx,%eax
80108f0f:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108f15:	01 d0                	add    %edx,%eax
80108f17:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108f1d:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108f23:	68 ec 00 00 00       	push   $0xec
80108f28:	68 ec 00 00 00       	push   $0xec
80108f2d:	68 f9 00 00 00       	push   $0xf9
80108f32:	50                   	push   %eax
80108f33:	e8 fe f3 ff ff       	call   80108336 <RGB>
80108f38:	83 c4 0c             	add    $0xc,%esp
80108f3b:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108f42:	66 89 03             	mov    %ax,(%ebx)
80108f45:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108f4c:	88 43 02             	mov    %al,0x2(%ebx)
			character_img[i][j] = RGB(128,64,0);
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=10;i<40;i++){
80108f4f:	83 45 b8 01          	addl   $0x1,-0x48(%ebp)
80108f53:	83 7d b8 27          	cmpl   $0x27,-0x48(%ebp)
80108f57:	7e a4                	jle    80108efd <APCharacterInit+0x963>
		else if(i>=22&&i<35)
			character_img[i][j] = RGB(128,64,0);
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
80108f59:	83 45 bc 01          	addl   $0x1,-0x44(%ebp)
80108f5d:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108f63:	83 c0 03             	add    $0x3,%eax
80108f66:	3b 45 bc             	cmp    -0x44(%ebp),%eax
80108f69:	7f 89                	jg     80108ef4 <APCharacterInit+0x95a>
               if(i<30)
			character_img[i][j] = RGB(249,236,236);
		
		
}}
line=line+3;
80108f6b:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108f72:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108f78:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80108f7b:	e9 15 01 00 00       	jmp    80109095 <APCharacterInit+0xafb>
	for(int i=5;i<40;i++){
80108f80:	c7 45 b0 05 00 00 00 	movl   $0x5,-0x50(%ebp)
80108f87:	e9 fb 00 00 00       	jmp    80109087 <APCharacterInit+0xaed>
               if(i<11)
80108f8c:	83 7d b0 0a          	cmpl   $0xa,-0x50(%ebp)
80108f90:	7f 4b                	jg     80108fdd <APCharacterInit+0xa43>
			character_img[i][j] = RGB(128,64,0);
80108f92:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80108f95:	8b 4d b0             	mov    -0x50(%ebp),%ecx
80108f98:	89 d0                	mov    %edx,%eax
80108f9a:	01 c0                	add    %eax,%eax
80108f9c:	01 d0                	add    %edx,%eax
80108f9e:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108fa4:	01 d0                	add    %edx,%eax
80108fa6:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108fac:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108fb2:	6a 00                	push   $0x0
80108fb4:	6a 40                	push   $0x40
80108fb6:	68 80 00 00 00       	push   $0x80
80108fbb:	50                   	push   %eax
80108fbc:	e8 75 f3 ff ff       	call   80108336 <RGB>
80108fc1:	83 c4 0c             	add    $0xc,%esp
80108fc4:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108fcb:	66 89 03             	mov    %ax,(%ebx)
80108fce:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108fd5:	88 43 02             	mov    %al,0x2(%ebx)
80108fd8:	e9 a6 00 00 00       	jmp    80109083 <APCharacterInit+0xae9>
		else if(i>=11&&i<14)
80108fdd:	83 7d b0 0a          	cmpl   $0xa,-0x50(%ebp)
80108fe1:	7e 4e                	jle    80109031 <APCharacterInit+0xa97>
80108fe3:	83 7d b0 0d          	cmpl   $0xd,-0x50(%ebp)
80108fe7:	7f 48                	jg     80109031 <APCharacterInit+0xa97>
			character_img[i][j] = RGB(255,0,0);	
80108fe9:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80108fec:	8b 4d b0             	mov    -0x50(%ebp),%ecx
80108fef:	89 d0                	mov    %edx,%eax
80108ff1:	01 c0                	add    %eax,%eax
80108ff3:	01 d0                	add    %edx,%eax
80108ff5:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108ffb:	01 d0                	add    %edx,%eax
80108ffd:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109003:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109009:	6a 00                	push   $0x0
8010900b:	6a 00                	push   $0x0
8010900d:	68 ff 00 00 00       	push   $0xff
80109012:	50                   	push   %eax
80109013:	e8 1e f3 ff ff       	call   80108336 <RGB>
80109018:	83 c4 0c             	add    $0xc,%esp
8010901b:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109022:	66 89 03             	mov    %ax,(%ebx)
80109025:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010902c:	88 43 02             	mov    %al,0x2(%ebx)
8010902f:	eb 52                	jmp    80109083 <APCharacterInit+0xae9>
		else if(i>=14&&i<25)
80109031:	83 7d b0 0d          	cmpl   $0xd,-0x50(%ebp)
80109035:	7e 4c                	jle    80109083 <APCharacterInit+0xae9>
80109037:	83 7d b0 18          	cmpl   $0x18,-0x50(%ebp)
8010903b:	7f 46                	jg     80109083 <APCharacterInit+0xae9>
			character_img[i][j] = RGB(128,64,0);
8010903d:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80109040:	8b 4d b0             	mov    -0x50(%ebp),%ecx
80109043:	89 d0                	mov    %edx,%eax
80109045:	01 c0                	add    %eax,%eax
80109047:	01 d0                	add    %edx,%eax
80109049:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010904f:	01 d0                	add    %edx,%eax
80109051:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109057:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010905d:	6a 00                	push   $0x0
8010905f:	6a 40                	push   $0x40
80109061:	68 80 00 00 00       	push   $0x80
80109066:	50                   	push   %eax
80109067:	e8 ca f2 ff ff       	call   80108336 <RGB>
8010906c:	83 c4 0c             	add    $0xc,%esp
8010906f:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109076:	66 89 03             	mov    %ax,(%ebx)
80109079:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109080:	88 43 02             	mov    %al,0x2(%ebx)
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=5;i<40;i++){
80109083:	83 45 b0 01          	addl   $0x1,-0x50(%ebp)
80109087:	83 7d b0 27          	cmpl   $0x27,-0x50(%ebp)
8010908b:	0f 8e fb fe ff ff    	jle    80108f8c <APCharacterInit+0x9f2>
			character_img[i][j] = RGB(249,236,236);
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
80109091:	83 45 b4 01          	addl   $0x1,-0x4c(%ebp)
80109095:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010909b:	83 c0 03             	add    $0x3,%eax
8010909e:	3b 45 b4             	cmp    -0x4c(%ebp),%eax
801090a1:	0f 8f d9 fe ff ff    	jg     80108f80 <APCharacterInit+0x9e6>
		else if(i>=14&&i<25)
			character_img[i][j] = RGB(128,64,0);
		
		
}}
line=line+3;
801090a7:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
801090ae:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801090b4:	89 45 ac             	mov    %eax,-0x54(%ebp)
801090b7:	e9 c3 01 00 00       	jmp    8010927f <APCharacterInit+0xce5>
	for(int i=3;i<40;i++){
801090bc:	c7 45 a8 03 00 00 00 	movl   $0x3,-0x58(%ebp)
801090c3:	e9 a9 01 00 00       	jmp    80109271 <APCharacterInit+0xcd7>
               if(i<11)
801090c8:	83 7d a8 0a          	cmpl   $0xa,-0x58(%ebp)
801090cc:	7f 4b                	jg     80109119 <APCharacterInit+0xb7f>
			character_img[i][j] = RGB(128,64,0);
801090ce:	8b 55 ac             	mov    -0x54(%ebp),%edx
801090d1:	8b 4d a8             	mov    -0x58(%ebp),%ecx
801090d4:	89 d0                	mov    %edx,%eax
801090d6:	01 c0                	add    %eax,%eax
801090d8:	01 d0                	add    %edx,%eax
801090da:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801090e0:	01 d0                	add    %edx,%eax
801090e2:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801090e8:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801090ee:	6a 00                	push   $0x0
801090f0:	6a 40                	push   $0x40
801090f2:	68 80 00 00 00       	push   $0x80
801090f7:	50                   	push   %eax
801090f8:	e8 39 f2 ff ff       	call   80108336 <RGB>
801090fd:	83 c4 0c             	add    $0xc,%esp
80109100:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109107:	66 89 03             	mov    %ax,(%ebx)
8010910a:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109111:	88 43 02             	mov    %al,0x2(%ebx)
80109114:	e9 54 01 00 00       	jmp    8010926d <APCharacterInit+0xcd3>
		else if(i>=11&&i<14)
80109119:	83 7d a8 0a          	cmpl   $0xa,-0x58(%ebp)
8010911d:	7e 51                	jle    80109170 <APCharacterInit+0xbd6>
8010911f:	83 7d a8 0d          	cmpl   $0xd,-0x58(%ebp)
80109123:	7f 4b                	jg     80109170 <APCharacterInit+0xbd6>
			character_img[i][j] = RGB(255,0,0);
80109125:	8b 55 ac             	mov    -0x54(%ebp),%edx
80109128:	8b 4d a8             	mov    -0x58(%ebp),%ecx
8010912b:	89 d0                	mov    %edx,%eax
8010912d:	01 c0                	add    %eax,%eax
8010912f:	01 d0                	add    %edx,%eax
80109131:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109137:	01 d0                	add    %edx,%eax
80109139:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010913f:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109145:	6a 00                	push   $0x0
80109147:	6a 00                	push   $0x0
80109149:	68 ff 00 00 00       	push   $0xff
8010914e:	50                   	push   %eax
8010914f:	e8 e2 f1 ff ff       	call   80108336 <RGB>
80109154:	83 c4 0c             	add    $0xc,%esp
80109157:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010915e:	66 89 03             	mov    %ax,(%ebx)
80109161:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109168:	88 43 02             	mov    %al,0x2(%ebx)
8010916b:	e9 fd 00 00 00       	jmp    8010926d <APCharacterInit+0xcd3>
		else if(i>=14&&i<22)
80109170:	83 7d a8 0d          	cmpl   $0xd,-0x58(%ebp)
80109174:	7e 51                	jle    801091c7 <APCharacterInit+0xc2d>
80109176:	83 7d a8 15          	cmpl   $0x15,-0x58(%ebp)
8010917a:	7f 4b                	jg     801091c7 <APCharacterInit+0xc2d>
			character_img[i][j] = RGB(128,64,0);
8010917c:	8b 55 ac             	mov    -0x54(%ebp),%edx
8010917f:	8b 4d a8             	mov    -0x58(%ebp),%ecx
80109182:	89 d0                	mov    %edx,%eax
80109184:	01 c0                	add    %eax,%eax
80109186:	01 d0                	add    %edx,%eax
80109188:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010918e:	01 d0                	add    %edx,%eax
80109190:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109196:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010919c:	6a 00                	push   $0x0
8010919e:	6a 40                	push   $0x40
801091a0:	68 80 00 00 00       	push   $0x80
801091a5:	50                   	push   %eax
801091a6:	e8 8b f1 ff ff       	call   80108336 <RGB>
801091ab:	83 c4 0c             	add    $0xc,%esp
801091ae:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801091b5:	66 89 03             	mov    %ax,(%ebx)
801091b8:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801091bf:	88 43 02             	mov    %al,0x2(%ebx)
801091c2:	e9 a6 00 00 00       	jmp    8010926d <APCharacterInit+0xcd3>
		else if(i>=22&&i<25)
801091c7:	83 7d a8 15          	cmpl   $0x15,-0x58(%ebp)
801091cb:	7e 4e                	jle    8010921b <APCharacterInit+0xc81>
801091cd:	83 7d a8 18          	cmpl   $0x18,-0x58(%ebp)
801091d1:	7f 48                	jg     8010921b <APCharacterInit+0xc81>
			character_img[i][j] = RGB(255,0,0);
801091d3:	8b 55 ac             	mov    -0x54(%ebp),%edx
801091d6:	8b 4d a8             	mov    -0x58(%ebp),%ecx
801091d9:	89 d0                	mov    %edx,%eax
801091db:	01 c0                	add    %eax,%eax
801091dd:	01 d0                	add    %edx,%eax
801091df:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801091e5:	01 d0                	add    %edx,%eax
801091e7:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801091ed:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801091f3:	6a 00                	push   $0x0
801091f5:	6a 00                	push   $0x0
801091f7:	68 ff 00 00 00       	push   $0xff
801091fc:	50                   	push   %eax
801091fd:	e8 34 f1 ff ff       	call   80108336 <RGB>
80109202:	83 c4 0c             	add    $0xc,%esp
80109205:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010920c:	66 89 03             	mov    %ax,(%ebx)
8010920f:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109216:	88 43 02             	mov    %al,0x2(%ebx)
80109219:	eb 52                	jmp    8010926d <APCharacterInit+0xcd3>
		else if(i>=25&&i<35)
8010921b:	83 7d a8 18          	cmpl   $0x18,-0x58(%ebp)
8010921f:	7e 4c                	jle    8010926d <APCharacterInit+0xcd3>
80109221:	83 7d a8 22          	cmpl   $0x22,-0x58(%ebp)
80109225:	7f 46                	jg     8010926d <APCharacterInit+0xcd3>
			character_img[i][j] = RGB(128,64,0);
80109227:	8b 55 ac             	mov    -0x54(%ebp),%edx
8010922a:	8b 4d a8             	mov    -0x58(%ebp),%ecx
8010922d:	89 d0                	mov    %edx,%eax
8010922f:	01 c0                	add    %eax,%eax
80109231:	01 d0                	add    %edx,%eax
80109233:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109239:	01 d0                	add    %edx,%eax
8010923b:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109241:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109247:	6a 00                	push   $0x0
80109249:	6a 40                	push   $0x40
8010924b:	68 80 00 00 00       	push   $0x80
80109250:	50                   	push   %eax
80109251:	e8 e0 f0 ff ff       	call   80108336 <RGB>
80109256:	83 c4 0c             	add    $0xc,%esp
80109259:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109260:	66 89 03             	mov    %ax,(%ebx)
80109263:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010926a:	88 43 02             	mov    %al,0x2(%ebx)
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=3;i<40;i++){
8010926d:	83 45 a8 01          	addl   $0x1,-0x58(%ebp)
80109271:	83 7d a8 27          	cmpl   $0x27,-0x58(%ebp)
80109275:	0f 8e 4d fe ff ff    	jle    801090c8 <APCharacterInit+0xb2e>
			character_img[i][j] = RGB(128,64,0);
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
8010927b:	83 45 ac 01          	addl   $0x1,-0x54(%ebp)
8010927f:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109285:	83 c0 03             	add    $0x3,%eax
80109288:	3b 45 ac             	cmp    -0x54(%ebp),%eax
8010928b:	0f 8f 2b fe ff ff    	jg     801090bc <APCharacterInit+0xb22>
		else if(i>=22&&i<25)
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<35)
			character_img[i][j] = RGB(128,64,0);
        
    }}line=line+3;
80109291:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80109298:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010929e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
801092a1:	e9 15 01 00 00       	jmp    801093bb <APCharacterInit+0xe21>
	for(int i=0;i<40;i++){
801092a6:	c7 45 a0 00 00 00 00 	movl   $0x0,-0x60(%ebp)
801092ad:	e9 fb 00 00 00       	jmp    801093ad <APCharacterInit+0xe13>
               if(i<11)
801092b2:	83 7d a0 0a          	cmpl   $0xa,-0x60(%ebp)
801092b6:	7f 4b                	jg     80109303 <APCharacterInit+0xd69>
			character_img[i][j] = RGB(128,64,0);
801092b8:	8b 55 a4             	mov    -0x5c(%ebp),%edx
801092bb:	8b 4d a0             	mov    -0x60(%ebp),%ecx
801092be:	89 d0                	mov    %edx,%eax
801092c0:	01 c0                	add    %eax,%eax
801092c2:	01 d0                	add    %edx,%eax
801092c4:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801092ca:	01 d0                	add    %edx,%eax
801092cc:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801092d2:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801092d8:	6a 00                	push   $0x0
801092da:	6a 40                	push   $0x40
801092dc:	68 80 00 00 00       	push   $0x80
801092e1:	50                   	push   %eax
801092e2:	e8 4f f0 ff ff       	call   80108336 <RGB>
801092e7:	83 c4 0c             	add    $0xc,%esp
801092ea:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801092f1:	66 89 03             	mov    %ax,(%ebx)
801092f4:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801092fb:	88 43 02             	mov    %al,0x2(%ebx)
801092fe:	e9 a6 00 00 00       	jmp    801093a9 <APCharacterInit+0xe0f>
		else if(i>=11&&i<25)
80109303:	83 7d a0 0a          	cmpl   $0xa,-0x60(%ebp)
80109307:	7e 4e                	jle    80109357 <APCharacterInit+0xdbd>
80109309:	83 7d a0 18          	cmpl   $0x18,-0x60(%ebp)
8010930d:	7f 48                	jg     80109357 <APCharacterInit+0xdbd>
			character_img[i][j] = RGB(255,0,0);
8010930f:	8b 55 a4             	mov    -0x5c(%ebp),%edx
80109312:	8b 4d a0             	mov    -0x60(%ebp),%ecx
80109315:	89 d0                	mov    %edx,%eax
80109317:	01 c0                	add    %eax,%eax
80109319:	01 d0                	add    %edx,%eax
8010931b:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109321:	01 d0                	add    %edx,%eax
80109323:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109329:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010932f:	6a 00                	push   $0x0
80109331:	6a 00                	push   $0x0
80109333:	68 ff 00 00 00       	push   $0xff
80109338:	50                   	push   %eax
80109339:	e8 f8 ef ff ff       	call   80108336 <RGB>
8010933e:	83 c4 0c             	add    $0xc,%esp
80109341:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109348:	66 89 03             	mov    %ax,(%ebx)
8010934b:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109352:	88 43 02             	mov    %al,0x2(%ebx)
80109355:	eb 52                	jmp    801093a9 <APCharacterInit+0xe0f>
		else if(i>=25&&i<40)
80109357:	83 7d a0 18          	cmpl   $0x18,-0x60(%ebp)
8010935b:	7e 4c                	jle    801093a9 <APCharacterInit+0xe0f>
8010935d:	83 7d a0 27          	cmpl   $0x27,-0x60(%ebp)
80109361:	7f 46                	jg     801093a9 <APCharacterInit+0xe0f>
			character_img[i][j] = RGB(128,64,0);
80109363:	8b 55 a4             	mov    -0x5c(%ebp),%edx
80109366:	8b 4d a0             	mov    -0x60(%ebp),%ecx
80109369:	89 d0                	mov    %edx,%eax
8010936b:	01 c0                	add    %eax,%eax
8010936d:	01 d0                	add    %edx,%eax
8010936f:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109375:	01 d0                	add    %edx,%eax
80109377:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010937d:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109383:	6a 00                	push   $0x0
80109385:	6a 40                	push   $0x40
80109387:	68 80 00 00 00       	push   $0x80
8010938c:	50                   	push   %eax
8010938d:	e8 a4 ef ff ff       	call   80108336 <RGB>
80109392:	83 c4 0c             	add    $0xc,%esp
80109395:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010939c:	66 89 03             	mov    %ax,(%ebx)
8010939f:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801093a6:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=25&&i<35)
			character_img[i][j] = RGB(128,64,0);
        
    }}line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
801093a9:	83 45 a0 01          	addl   $0x1,-0x60(%ebp)
801093ad:	83 7d a0 27          	cmpl   $0x27,-0x60(%ebp)
801093b1:	0f 8e fb fe ff ff    	jle    801092b2 <APCharacterInit+0xd18>
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<35)
			character_img[i][j] = RGB(128,64,0);
        
    }}line=line+3;
  for(int j=line;j<line+3;j++){
801093b7:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
801093bb:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801093c1:	83 c0 03             	add    $0x3,%eax
801093c4:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
801093c7:	0f 8f d9 fe ff ff    	jg     801092a6 <APCharacterInit+0xd0c>
		else if(i>=11&&i<25)
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<40)
			character_img[i][j] = RGB(128,64,0);
}}
line =line +3;
801093cd:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
801093d4:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801093da:	89 45 9c             	mov    %eax,-0x64(%ebp)
801093dd:	e9 37 03 00 00       	jmp    80109719 <APCharacterInit+0x117f>
	for(int i=0;i<40;i++){
801093e2:	c7 45 98 00 00 00 00 	movl   $0x0,-0x68(%ebp)
801093e9:	e9 1d 03 00 00       	jmp    8010970b <APCharacterInit+0x1171>
               if(i<5)
801093ee:	83 7d 98 04          	cmpl   $0x4,-0x68(%ebp)
801093f2:	7f 51                	jg     80109445 <APCharacterInit+0xeab>
			character_img[i][j] = RGB(249,236,236);
801093f4:	8b 55 9c             	mov    -0x64(%ebp),%edx
801093f7:	8b 4d 98             	mov    -0x68(%ebp),%ecx
801093fa:	89 d0                	mov    %edx,%eax
801093fc:	01 c0                	add    %eax,%eax
801093fe:	01 d0                	add    %edx,%eax
80109400:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109406:	01 d0                	add    %edx,%eax
80109408:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010940e:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109414:	68 ec 00 00 00       	push   $0xec
80109419:	68 ec 00 00 00       	push   $0xec
8010941e:	68 f9 00 00 00       	push   $0xf9
80109423:	50                   	push   %eax
80109424:	e8 0d ef ff ff       	call   80108336 <RGB>
80109429:	83 c4 0c             	add    $0xc,%esp
8010942c:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109433:	66 89 03             	mov    %ax,(%ebx)
80109436:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010943d:	88 43 02             	mov    %al,0x2(%ebx)
80109440:	e9 c2 02 00 00       	jmp    80109707 <APCharacterInit+0x116d>
		else if(i>=5&&i<8)
80109445:	83 7d 98 04          	cmpl   $0x4,-0x68(%ebp)
80109449:	7e 51                	jle    8010949c <APCharacterInit+0xf02>
8010944b:	83 7d 98 07          	cmpl   $0x7,-0x68(%ebp)
8010944f:	7f 4b                	jg     8010949c <APCharacterInit+0xf02>
			character_img[i][j] = RGB(128,64,0);
80109451:	8b 55 9c             	mov    -0x64(%ebp),%edx
80109454:	8b 4d 98             	mov    -0x68(%ebp),%ecx
80109457:	89 d0                	mov    %edx,%eax
80109459:	01 c0                	add    %eax,%eax
8010945b:	01 d0                	add    %edx,%eax
8010945d:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109463:	01 d0                	add    %edx,%eax
80109465:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010946b:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109471:	6a 00                	push   $0x0
80109473:	6a 40                	push   $0x40
80109475:	68 80 00 00 00       	push   $0x80
8010947a:	50                   	push   %eax
8010947b:	e8 b6 ee ff ff       	call   80108336 <RGB>
80109480:	83 c4 0c             	add    $0xc,%esp
80109483:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010948a:	66 89 03             	mov    %ax,(%ebx)
8010948d:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109494:	88 43 02             	mov    %al,0x2(%ebx)
80109497:	e9 6b 02 00 00       	jmp    80109707 <APCharacterInit+0x116d>
		else if(i>=8&&i<11)
8010949c:	83 7d 98 07          	cmpl   $0x7,-0x68(%ebp)
801094a0:	7e 51                	jle    801094f3 <APCharacterInit+0xf59>
801094a2:	83 7d 98 0a          	cmpl   $0xa,-0x68(%ebp)
801094a6:	7f 4b                	jg     801094f3 <APCharacterInit+0xf59>
			character_img[i][j] = RGB(255,0,0);
801094a8:	8b 55 9c             	mov    -0x64(%ebp),%edx
801094ab:	8b 4d 98             	mov    -0x68(%ebp),%ecx
801094ae:	89 d0                	mov    %edx,%eax
801094b0:	01 c0                	add    %eax,%eax
801094b2:	01 d0                	add    %edx,%eax
801094b4:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801094ba:	01 d0                	add    %edx,%eax
801094bc:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801094c2:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801094c8:	6a 00                	push   $0x0
801094ca:	6a 00                	push   $0x0
801094cc:	68 ff 00 00 00       	push   $0xff
801094d1:	50                   	push   %eax
801094d2:	e8 5f ee ff ff       	call   80108336 <RGB>
801094d7:	83 c4 0c             	add    $0xc,%esp
801094da:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801094e1:	66 89 03             	mov    %ax,(%ebx)
801094e4:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801094eb:	88 43 02             	mov    %al,0x2(%ebx)
801094ee:	e9 14 02 00 00       	jmp    80109707 <APCharacterInit+0x116d>
		else if(i>=11&&i<14)
801094f3:	83 7d 98 0a          	cmpl   $0xa,-0x68(%ebp)
801094f7:	7e 57                	jle    80109550 <APCharacterInit+0xfb6>
801094f9:	83 7d 98 0d          	cmpl   $0xd,-0x68(%ebp)
801094fd:	7f 51                	jg     80109550 <APCharacterInit+0xfb6>
			character_img[i][j] = RGB(249,236,236);
801094ff:	8b 55 9c             	mov    -0x64(%ebp),%edx
80109502:	8b 4d 98             	mov    -0x68(%ebp),%ecx
80109505:	89 d0                	mov    %edx,%eax
80109507:	01 c0                	add    %eax,%eax
80109509:	01 d0                	add    %edx,%eax
8010950b:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109511:	01 d0                	add    %edx,%eax
80109513:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109519:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010951f:	68 ec 00 00 00       	push   $0xec
80109524:	68 ec 00 00 00       	push   $0xec
80109529:	68 f9 00 00 00       	push   $0xf9
8010952e:	50                   	push   %eax
8010952f:	e8 02 ee ff ff       	call   80108336 <RGB>
80109534:	83 c4 0c             	add    $0xc,%esp
80109537:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010953e:	66 89 03             	mov    %ax,(%ebx)
80109541:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109548:	88 43 02             	mov    %al,0x2(%ebx)
8010954b:	e9 b7 01 00 00       	jmp    80109707 <APCharacterInit+0x116d>
		else if(i>=14&&i<22)
80109550:	83 7d 98 0d          	cmpl   $0xd,-0x68(%ebp)
80109554:	7e 51                	jle    801095a7 <APCharacterInit+0x100d>
80109556:	83 7d 98 15          	cmpl   $0x15,-0x68(%ebp)
8010955a:	7f 4b                	jg     801095a7 <APCharacterInit+0x100d>
			character_img[i][j] = RGB(255,0,0);
8010955c:	8b 55 9c             	mov    -0x64(%ebp),%edx
8010955f:	8b 4d 98             	mov    -0x68(%ebp),%ecx
80109562:	89 d0                	mov    %edx,%eax
80109564:	01 c0                	add    %eax,%eax
80109566:	01 d0                	add    %edx,%eax
80109568:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010956e:	01 d0                	add    %edx,%eax
80109570:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109576:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010957c:	6a 00                	push   $0x0
8010957e:	6a 00                	push   $0x0
80109580:	68 ff 00 00 00       	push   $0xff
80109585:	50                   	push   %eax
80109586:	e8 ab ed ff ff       	call   80108336 <RGB>
8010958b:	83 c4 0c             	add    $0xc,%esp
8010958e:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109595:	66 89 03             	mov    %ax,(%ebx)
80109598:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010959f:	88 43 02             	mov    %al,0x2(%ebx)
801095a2:	e9 60 01 00 00       	jmp    80109707 <APCharacterInit+0x116d>
		else if(i>=22&&i<25)
801095a7:	83 7d 98 15          	cmpl   $0x15,-0x68(%ebp)
801095ab:	7e 57                	jle    80109604 <APCharacterInit+0x106a>
801095ad:	83 7d 98 18          	cmpl   $0x18,-0x68(%ebp)
801095b1:	7f 51                	jg     80109604 <APCharacterInit+0x106a>
			character_img[i][j] = RGB(249,236,236);
801095b3:	8b 55 9c             	mov    -0x64(%ebp),%edx
801095b6:	8b 4d 98             	mov    -0x68(%ebp),%ecx
801095b9:	89 d0                	mov    %edx,%eax
801095bb:	01 c0                	add    %eax,%eax
801095bd:	01 d0                	add    %edx,%eax
801095bf:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801095c5:	01 d0                	add    %edx,%eax
801095c7:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801095cd:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801095d3:	68 ec 00 00 00       	push   $0xec
801095d8:	68 ec 00 00 00       	push   $0xec
801095dd:	68 f9 00 00 00       	push   $0xf9
801095e2:	50                   	push   %eax
801095e3:	e8 4e ed ff ff       	call   80108336 <RGB>
801095e8:	83 c4 0c             	add    $0xc,%esp
801095eb:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801095f2:	66 89 03             	mov    %ax,(%ebx)
801095f5:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801095fc:	88 43 02             	mov    %al,0x2(%ebx)
801095ff:	e9 03 01 00 00       	jmp    80109707 <APCharacterInit+0x116d>
		else if(i>=25&&i<28)
80109604:	83 7d 98 18          	cmpl   $0x18,-0x68(%ebp)
80109608:	7e 51                	jle    8010965b <APCharacterInit+0x10c1>
8010960a:	83 7d 98 1b          	cmpl   $0x1b,-0x68(%ebp)
8010960e:	7f 4b                	jg     8010965b <APCharacterInit+0x10c1>
			character_img[i][j] = RGB(255,0,0);
80109610:	8b 55 9c             	mov    -0x64(%ebp),%edx
80109613:	8b 4d 98             	mov    -0x68(%ebp),%ecx
80109616:	89 d0                	mov    %edx,%eax
80109618:	01 c0                	add    %eax,%eax
8010961a:	01 d0                	add    %edx,%eax
8010961c:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109622:	01 d0                	add    %edx,%eax
80109624:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010962a:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109630:	6a 00                	push   $0x0
80109632:	6a 00                	push   $0x0
80109634:	68 ff 00 00 00       	push   $0xff
80109639:	50                   	push   %eax
8010963a:	e8 f7 ec ff ff       	call   80108336 <RGB>
8010963f:	83 c4 0c             	add    $0xc,%esp
80109642:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109649:	66 89 03             	mov    %ax,(%ebx)
8010964c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109653:	88 43 02             	mov    %al,0x2(%ebx)
80109656:	e9 ac 00 00 00       	jmp    80109707 <APCharacterInit+0x116d>
		else if(i>=28&&i<32)
8010965b:	83 7d 98 1b          	cmpl   $0x1b,-0x68(%ebp)
8010965f:	7e 4e                	jle    801096af <APCharacterInit+0x1115>
80109661:	83 7d 98 1f          	cmpl   $0x1f,-0x68(%ebp)
80109665:	7f 48                	jg     801096af <APCharacterInit+0x1115>
			character_img[i][j] = RGB(128,64,0);
80109667:	8b 55 9c             	mov    -0x64(%ebp),%edx
8010966a:	8b 4d 98             	mov    -0x68(%ebp),%ecx
8010966d:	89 d0                	mov    %edx,%eax
8010966f:	01 c0                	add    %eax,%eax
80109671:	01 d0                	add    %edx,%eax
80109673:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109679:	01 d0                	add    %edx,%eax
8010967b:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109681:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109687:	6a 00                	push   $0x0
80109689:	6a 40                	push   $0x40
8010968b:	68 80 00 00 00       	push   $0x80
80109690:	50                   	push   %eax
80109691:	e8 a0 ec ff ff       	call   80108336 <RGB>
80109696:	83 c4 0c             	add    $0xc,%esp
80109699:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801096a0:	66 89 03             	mov    %ax,(%ebx)
801096a3:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801096aa:	88 43 02             	mov    %al,0x2(%ebx)
801096ad:	eb 58                	jmp    80109707 <APCharacterInit+0x116d>
		else if(i>=32&&i<40)
801096af:	83 7d 98 1f          	cmpl   $0x1f,-0x68(%ebp)
801096b3:	7e 52                	jle    80109707 <APCharacterInit+0x116d>
801096b5:	83 7d 98 27          	cmpl   $0x27,-0x68(%ebp)
801096b9:	7f 4c                	jg     80109707 <APCharacterInit+0x116d>
			character_img[i][j] = RGB(249,236,236);
801096bb:	8b 55 9c             	mov    -0x64(%ebp),%edx
801096be:	8b 4d 98             	mov    -0x68(%ebp),%ecx
801096c1:	89 d0                	mov    %edx,%eax
801096c3:	01 c0                	add    %eax,%eax
801096c5:	01 d0                	add    %edx,%eax
801096c7:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801096cd:	01 d0                	add    %edx,%eax
801096cf:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801096d5:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801096db:	68 ec 00 00 00       	push   $0xec
801096e0:	68 ec 00 00 00       	push   $0xec
801096e5:	68 f9 00 00 00       	push   $0xf9
801096ea:	50                   	push   %eax
801096eb:	e8 46 ec ff ff       	call   80108336 <RGB>
801096f0:	83 c4 0c             	add    $0xc,%esp
801096f3:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801096fa:	66 89 03             	mov    %ax,(%ebx)
801096fd:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109704:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=25&&i<40)
			character_img[i][j] = RGB(128,64,0);
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109707:	83 45 98 01          	addl   $0x1,-0x68(%ebp)
8010970b:	83 7d 98 27          	cmpl   $0x27,-0x68(%ebp)
8010970f:	0f 8e d9 fc ff ff    	jle    801093ee <APCharacterInit+0xe54>
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<40)
			character_img[i][j] = RGB(128,64,0);
}}
line =line +3;
for(int j=line;j<line+3;j++){
80109715:	83 45 9c 01          	addl   $0x1,-0x64(%ebp)
80109719:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010971f:	83 c0 03             	add    $0x3,%eax
80109722:	3b 45 9c             	cmp    -0x64(%ebp),%eax
80109725:	0f 8f b7 fc ff ff    	jg     801093e2 <APCharacterInit+0xe48>
		else if(i>=28&&i<32)
			character_img[i][j] = RGB(128,64,0);
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line =line +3;
8010972b:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
80109732:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109738:	89 45 94             	mov    %eax,-0x6c(%ebp)
8010973b:	e9 21 01 00 00       	jmp    80109861 <APCharacterInit+0x12c7>
	for(int i=0;i<40;i++){
80109740:	c7 45 90 00 00 00 00 	movl   $0x0,-0x70(%ebp)
80109747:	e9 07 01 00 00       	jmp    80109853 <APCharacterInit+0x12b9>
               if(i<8)
8010974c:	83 7d 90 07          	cmpl   $0x7,-0x70(%ebp)
80109750:	7f 51                	jg     801097a3 <APCharacterInit+0x1209>
			character_img[i][j] = RGB(249,236,236);
80109752:	8b 55 94             	mov    -0x6c(%ebp),%edx
80109755:	8b 4d 90             	mov    -0x70(%ebp),%ecx
80109758:	89 d0                	mov    %edx,%eax
8010975a:	01 c0                	add    %eax,%eax
8010975c:	01 d0                	add    %edx,%eax
8010975e:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109764:	01 d0                	add    %edx,%eax
80109766:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010976c:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109772:	68 ec 00 00 00       	push   $0xec
80109777:	68 ec 00 00 00       	push   $0xec
8010977c:	68 f9 00 00 00       	push   $0xf9
80109781:	50                   	push   %eax
80109782:	e8 af eb ff ff       	call   80108336 <RGB>
80109787:	83 c4 0c             	add    $0xc,%esp
8010978a:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109791:	66 89 03             	mov    %ax,(%ebx)
80109794:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010979b:	88 43 02             	mov    %al,0x2(%ebx)
8010979e:	e9 ac 00 00 00       	jmp    8010984f <APCharacterInit+0x12b5>
		else if(i>=8&&i<28)
801097a3:	83 7d 90 07          	cmpl   $0x7,-0x70(%ebp)
801097a7:	7e 4e                	jle    801097f7 <APCharacterInit+0x125d>
801097a9:	83 7d 90 1b          	cmpl   $0x1b,-0x70(%ebp)
801097ad:	7f 48                	jg     801097f7 <APCharacterInit+0x125d>
			character_img[i][j] = RGB(255,0,0);
801097af:	8b 55 94             	mov    -0x6c(%ebp),%edx
801097b2:	8b 4d 90             	mov    -0x70(%ebp),%ecx
801097b5:	89 d0                	mov    %edx,%eax
801097b7:	01 c0                	add    %eax,%eax
801097b9:	01 d0                	add    %edx,%eax
801097bb:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801097c1:	01 d0                	add    %edx,%eax
801097c3:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801097c9:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801097cf:	6a 00                	push   $0x0
801097d1:	6a 00                	push   $0x0
801097d3:	68 ff 00 00 00       	push   $0xff
801097d8:	50                   	push   %eax
801097d9:	e8 58 eb ff ff       	call   80108336 <RGB>
801097de:	83 c4 0c             	add    $0xc,%esp
801097e1:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801097e8:	66 89 03             	mov    %ax,(%ebx)
801097eb:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801097f2:	88 43 02             	mov    %al,0x2(%ebx)
801097f5:	eb 58                	jmp    8010984f <APCharacterInit+0x12b5>
		else if(i>=28&&i<40)
801097f7:	83 7d 90 1b          	cmpl   $0x1b,-0x70(%ebp)
801097fb:	7e 52                	jle    8010984f <APCharacterInit+0x12b5>
801097fd:	83 7d 90 27          	cmpl   $0x27,-0x70(%ebp)
80109801:	7f 4c                	jg     8010984f <APCharacterInit+0x12b5>
			character_img[i][j] = RGB(249,236,236);
80109803:	8b 55 94             	mov    -0x6c(%ebp),%edx
80109806:	8b 4d 90             	mov    -0x70(%ebp),%ecx
80109809:	89 d0                	mov    %edx,%eax
8010980b:	01 c0                	add    %eax,%eax
8010980d:	01 d0                	add    %edx,%eax
8010980f:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109815:	01 d0                	add    %edx,%eax
80109817:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010981d:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109823:	68 ec 00 00 00       	push   $0xec
80109828:	68 ec 00 00 00       	push   $0xec
8010982d:	68 f9 00 00 00       	push   $0xf9
80109832:	50                   	push   %eax
80109833:	e8 fe ea ff ff       	call   80108336 <RGB>
80109838:	83 c4 0c             	add    $0xc,%esp
8010983b:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109842:	66 89 03             	mov    %ax,(%ebx)
80109845:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010984c:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
8010984f:	83 45 90 01          	addl   $0x1,-0x70(%ebp)
80109853:	83 7d 90 27          	cmpl   $0x27,-0x70(%ebp)
80109857:	0f 8e ef fe ff ff    	jle    8010974c <APCharacterInit+0x11b2>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line =line +3;
for(int j=line;j<line+3;j++){
8010985d:	83 45 94 01          	addl   $0x1,-0x6c(%ebp)
80109861:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109867:	83 c0 03             	add    $0x3,%eax
8010986a:	3b 45 94             	cmp    -0x6c(%ebp),%eax
8010986d:	0f 8f cd fe ff ff    	jg     80109740 <APCharacterInit+0x11a6>
		else if(i>=28&&i<40)
			character_img[i][j] = RGB(249,236,236);

		
}}
line =line +3;
80109873:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
8010987a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109880:	89 45 8c             	mov    %eax,-0x74(%ebp)
80109883:	e9 21 01 00 00       	jmp    801099a9 <APCharacterInit+0x140f>
	for(int i=0;i<40;i++){
80109888:	c7 45 88 00 00 00 00 	movl   $0x0,-0x78(%ebp)
8010988f:	e9 07 01 00 00       	jmp    8010999b <APCharacterInit+0x1401>
               if(i<5)
80109894:	83 7d 88 04          	cmpl   $0x4,-0x78(%ebp)
80109898:	7f 51                	jg     801098eb <APCharacterInit+0x1351>
			character_img[i][j] = RGB(249,236,236);
8010989a:	8b 55 8c             	mov    -0x74(%ebp),%edx
8010989d:	8b 4d 88             	mov    -0x78(%ebp),%ecx
801098a0:	89 d0                	mov    %edx,%eax
801098a2:	01 c0                	add    %eax,%eax
801098a4:	01 d0                	add    %edx,%eax
801098a6:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801098ac:	01 d0                	add    %edx,%eax
801098ae:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801098b4:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801098ba:	68 ec 00 00 00       	push   $0xec
801098bf:	68 ec 00 00 00       	push   $0xec
801098c4:	68 f9 00 00 00       	push   $0xf9
801098c9:	50                   	push   %eax
801098ca:	e8 67 ea ff ff       	call   80108336 <RGB>
801098cf:	83 c4 0c             	add    $0xc,%esp
801098d2:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801098d9:	66 89 03             	mov    %ax,(%ebx)
801098dc:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801098e3:	88 43 02             	mov    %al,0x2(%ebx)
801098e6:	e9 ac 00 00 00       	jmp    80109997 <APCharacterInit+0x13fd>
	
		else if(i>=5&&i<32)
801098eb:	83 7d 88 04          	cmpl   $0x4,-0x78(%ebp)
801098ef:	7e 4e                	jle    8010993f <APCharacterInit+0x13a5>
801098f1:	83 7d 88 1f          	cmpl   $0x1f,-0x78(%ebp)
801098f5:	7f 48                	jg     8010993f <APCharacterInit+0x13a5>
			character_img[i][j] = RGB(255,0,0);
801098f7:	8b 55 8c             	mov    -0x74(%ebp),%edx
801098fa:	8b 4d 88             	mov    -0x78(%ebp),%ecx
801098fd:	89 d0                	mov    %edx,%eax
801098ff:	01 c0                	add    %eax,%eax
80109901:	01 d0                	add    %edx,%eax
80109903:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109909:	01 d0                	add    %edx,%eax
8010990b:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109911:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109917:	6a 00                	push   $0x0
80109919:	6a 00                	push   $0x0
8010991b:	68 ff 00 00 00       	push   $0xff
80109920:	50                   	push   %eax
80109921:	e8 10 ea ff ff       	call   80108336 <RGB>
80109926:	83 c4 0c             	add    $0xc,%esp
80109929:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109930:	66 89 03             	mov    %ax,(%ebx)
80109933:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010993a:	88 43 02             	mov    %al,0x2(%ebx)
8010993d:	eb 58                	jmp    80109997 <APCharacterInit+0x13fd>
		
		else if(i>=32&&i<40)
8010993f:	83 7d 88 1f          	cmpl   $0x1f,-0x78(%ebp)
80109943:	7e 52                	jle    80109997 <APCharacterInit+0x13fd>
80109945:	83 7d 88 27          	cmpl   $0x27,-0x78(%ebp)
80109949:	7f 4c                	jg     80109997 <APCharacterInit+0x13fd>
			character_img[i][j] = RGB(249,236,236);
8010994b:	8b 55 8c             	mov    -0x74(%ebp),%edx
8010994e:	8b 4d 88             	mov    -0x78(%ebp),%ecx
80109951:	89 d0                	mov    %edx,%eax
80109953:	01 c0                	add    %eax,%eax
80109955:	01 d0                	add    %edx,%eax
80109957:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010995d:	01 d0                	add    %edx,%eax
8010995f:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109965:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010996b:	68 ec 00 00 00       	push   $0xec
80109970:	68 ec 00 00 00       	push   $0xec
80109975:	68 f9 00 00 00       	push   $0xf9
8010997a:	50                   	push   %eax
8010997b:	e8 b6 e9 ff ff       	call   80108336 <RGB>
80109980:	83 c4 0c             	add    $0xc,%esp
80109983:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010998a:	66 89 03             	mov    %ax,(%ebx)
8010998d:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109994:	88 43 02             	mov    %al,0x2(%ebx)

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109997:	83 45 88 01          	addl   $0x1,-0x78(%ebp)
8010999b:	83 7d 88 27          	cmpl   $0x27,-0x78(%ebp)
8010999f:	0f 8e ef fe ff ff    	jle    80109894 <APCharacterInit+0x12fa>
			character_img[i][j] = RGB(249,236,236);

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
801099a5:	83 45 8c 01          	addl   $0x1,-0x74(%ebp)
801099a9:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801099af:	83 c0 03             	add    $0x3,%eax
801099b2:	3b 45 8c             	cmp    -0x74(%ebp),%eax
801099b5:	0f 8f cd fe ff ff    	jg     80109888 <APCharacterInit+0x12ee>
		
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);

		
}}line =line +3;
801099bb:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
801099c2:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801099c8:	89 45 84             	mov    %eax,-0x7c(%ebp)
801099cb:	e9 c4 00 00 00       	jmp    80109a94 <APCharacterInit+0x14fa>
	for(int i=0;i<40;i++){
801099d0:	c7 45 80 00 00 00 00 	movl   $0x0,-0x80(%ebp)
801099d7:	e9 aa 00 00 00       	jmp    80109a86 <APCharacterInit+0x14ec>
               if(i>=5&&i<14)
801099dc:	83 7d 80 04          	cmpl   $0x4,-0x80(%ebp)
801099e0:	7e 4e                	jle    80109a30 <APCharacterInit+0x1496>
801099e2:	83 7d 80 0d          	cmpl   $0xd,-0x80(%ebp)
801099e6:	7f 48                	jg     80109a30 <APCharacterInit+0x1496>
			character_img[i][j] = RGB(255,0,0);
801099e8:	8b 55 84             	mov    -0x7c(%ebp),%edx
801099eb:	8b 4d 80             	mov    -0x80(%ebp),%ecx
801099ee:	89 d0                	mov    %edx,%eax
801099f0:	01 c0                	add    %eax,%eax
801099f2:	01 d0                	add    %edx,%eax
801099f4:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801099fa:	01 d0                	add    %edx,%eax
801099fc:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109a02:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109a08:	6a 00                	push   $0x0
80109a0a:	6a 00                	push   $0x0
80109a0c:	68 ff 00 00 00       	push   $0xff
80109a11:	50                   	push   %eax
80109a12:	e8 1f e9 ff ff       	call   80108336 <RGB>
80109a17:	83 c4 0c             	add    $0xc,%esp
80109a1a:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109a21:	66 89 03             	mov    %ax,(%ebx)
80109a24:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109a2b:	88 43 02             	mov    %al,0x2(%ebx)
80109a2e:	eb 52                	jmp    80109a82 <APCharacterInit+0x14e8>
		
		else if(i>=22&&i<32)
80109a30:	83 7d 80 15          	cmpl   $0x15,-0x80(%ebp)
80109a34:	7e 4c                	jle    80109a82 <APCharacterInit+0x14e8>
80109a36:	83 7d 80 1f          	cmpl   $0x1f,-0x80(%ebp)
80109a3a:	7f 46                	jg     80109a82 <APCharacterInit+0x14e8>
			character_img[i][j] = RGB(255,0,0);
80109a3c:	8b 55 84             	mov    -0x7c(%ebp),%edx
80109a3f:	8b 4d 80             	mov    -0x80(%ebp),%ecx
80109a42:	89 d0                	mov    %edx,%eax
80109a44:	01 c0                	add    %eax,%eax
80109a46:	01 d0                	add    %edx,%eax
80109a48:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109a4e:	01 d0                	add    %edx,%eax
80109a50:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109a56:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109a5c:	6a 00                	push   $0x0
80109a5e:	6a 00                	push   $0x0
80109a60:	68 ff 00 00 00       	push   $0xff
80109a65:	50                   	push   %eax
80109a66:	e8 cb e8 ff ff       	call   80108336 <RGB>
80109a6b:	83 c4 0c             	add    $0xc,%esp
80109a6e:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109a75:	66 89 03             	mov    %ax,(%ebx)
80109a78:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109a7f:	88 43 02             	mov    %al,0x2(%ebx)
			character_img[i][j] = RGB(249,236,236);

		
}}line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109a82:	83 45 80 01          	addl   $0x1,-0x80(%ebp)
80109a86:	83 7d 80 27          	cmpl   $0x27,-0x80(%ebp)
80109a8a:	0f 8e 4c ff ff ff    	jle    801099dc <APCharacterInit+0x1442>
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);

		
}}line =line +3;
for(int j=line;j<line+3;j++){
80109a90:	83 45 84 01          	addl   $0x1,-0x7c(%ebp)
80109a94:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109a9a:	83 c0 03             	add    $0x3,%eax
80109a9d:	3b 45 84             	cmp    -0x7c(%ebp),%eax
80109aa0:	0f 8f 2a ff ff ff    	jg     801099d0 <APCharacterInit+0x1436>
		else if(i>=22&&i<32)
			character_img[i][j] = RGB(255,0,0);

		
}}
 line =line +3;
80109aa6:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
80109aad:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109ab3:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
80109ab9:	e9 e8 00 00 00       	jmp    80109ba6 <APCharacterInit+0x160c>
	for(int i=0;i<40;i++){
80109abe:	c7 85 78 ff ff ff 00 	movl   $0x0,-0x88(%ebp)
80109ac5:	00 00 00 
80109ac8:	e9 c5 00 00 00       	jmp    80109b92 <APCharacterInit+0x15f8>
               if(i>=2&&i<11)
80109acd:	83 bd 78 ff ff ff 01 	cmpl   $0x1,-0x88(%ebp)
80109ad4:	7e 57                	jle    80109b2d <APCharacterInit+0x1593>
80109ad6:	83 bd 78 ff ff ff 0a 	cmpl   $0xa,-0x88(%ebp)
80109add:	7f 4e                	jg     80109b2d <APCharacterInit+0x1593>
			character_img[i][j] = RGB(128,64,0);
80109adf:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
80109ae5:	8b 8d 78 ff ff ff    	mov    -0x88(%ebp),%ecx
80109aeb:	89 d0                	mov    %edx,%eax
80109aed:	01 c0                	add    %eax,%eax
80109aef:	01 d0                	add    %edx,%eax
80109af1:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109af7:	01 d0                	add    %edx,%eax
80109af9:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109aff:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109b05:	6a 00                	push   $0x0
80109b07:	6a 40                	push   $0x40
80109b09:	68 80 00 00 00       	push   $0x80
80109b0e:	50                   	push   %eax
80109b0f:	e8 22 e8 ff ff       	call   80108336 <RGB>
80109b14:	83 c4 0c             	add    $0xc,%esp
80109b17:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109b1e:	66 89 03             	mov    %ax,(%ebx)
80109b21:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109b28:	88 43 02             	mov    %al,0x2(%ebx)
80109b2b:	eb 5e                	jmp    80109b8b <APCharacterInit+0x15f1>
		
		else if(i>=25&&i<34)
80109b2d:	83 bd 78 ff ff ff 18 	cmpl   $0x18,-0x88(%ebp)
80109b34:	7e 55                	jle    80109b8b <APCharacterInit+0x15f1>
80109b36:	83 bd 78 ff ff ff 21 	cmpl   $0x21,-0x88(%ebp)
80109b3d:	7f 4c                	jg     80109b8b <APCharacterInit+0x15f1>
			character_img[i][j] = RGB(128,64,0);
80109b3f:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
80109b45:	8b 8d 78 ff ff ff    	mov    -0x88(%ebp),%ecx
80109b4b:	89 d0                	mov    %edx,%eax
80109b4d:	01 c0                	add    %eax,%eax
80109b4f:	01 d0                	add    %edx,%eax
80109b51:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109b57:	01 d0                	add    %edx,%eax
80109b59:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109b5f:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109b65:	6a 00                	push   $0x0
80109b67:	6a 40                	push   $0x40
80109b69:	68 80 00 00 00       	push   $0x80
80109b6e:	50                   	push   %eax
80109b6f:	e8 c2 e7 ff ff       	call   80108336 <RGB>
80109b74:	83 c4 0c             	add    $0xc,%esp
80109b77:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109b7e:	66 89 03             	mov    %ax,(%ebx)
80109b81:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109b88:	88 43 02             	mov    %al,0x2(%ebx)

		
}}
 line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109b8b:	83 85 78 ff ff ff 01 	addl   $0x1,-0x88(%ebp)
80109b92:	83 bd 78 ff ff ff 27 	cmpl   $0x27,-0x88(%ebp)
80109b99:	0f 8e 2e ff ff ff    	jle    80109acd <APCharacterInit+0x1533>
			character_img[i][j] = RGB(255,0,0);

		
}}
 line =line +3;
for(int j=line;j<line+3;j++){
80109b9f:	83 85 7c ff ff ff 01 	addl   $0x1,-0x84(%ebp)
80109ba6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109bac:	83 c0 03             	add    $0x3,%eax
80109baf:	3b 85 7c ff ff ff    	cmp    -0x84(%ebp),%eax
80109bb5:	0f 8f 03 ff ff ff    	jg     80109abe <APCharacterInit+0x1524>
		else if(i>=25&&i<34)
			character_img[i][j] = RGB(128,64,0);

		
}}
line =line +3;
80109bbb:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
80109bc2:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109bc8:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
80109bce:	e9 df 00 00 00       	jmp    80109cb2 <APCharacterInit+0x1718>
	for(int i=0;i<40;i++){
80109bd3:	c7 85 70 ff ff ff 00 	movl   $0x0,-0x90(%ebp)
80109bda:	00 00 00 
80109bdd:	e9 bc 00 00 00       	jmp    80109c9e <APCharacterInit+0x1704>
               if(i<11)
80109be2:	83 bd 70 ff ff ff 0a 	cmpl   $0xa,-0x90(%ebp)
80109be9:	7f 4e                	jg     80109c39 <APCharacterInit+0x169f>
			character_img[i][j] = RGB(128,64,0);
80109beb:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
80109bf1:	8b 8d 70 ff ff ff    	mov    -0x90(%ebp),%ecx
80109bf7:	89 d0                	mov    %edx,%eax
80109bf9:	01 c0                	add    %eax,%eax
80109bfb:	01 d0                	add    %edx,%eax
80109bfd:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109c03:	01 d0                	add    %edx,%eax
80109c05:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109c0b:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109c11:	6a 00                	push   $0x0
80109c13:	6a 40                	push   $0x40
80109c15:	68 80 00 00 00       	push   $0x80
80109c1a:	50                   	push   %eax
80109c1b:	e8 16 e7 ff ff       	call   80108336 <RGB>
80109c20:	83 c4 0c             	add    $0xc,%esp
80109c23:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109c2a:	66 89 03             	mov    %ax,(%ebx)
80109c2d:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109c34:	88 43 02             	mov    %al,0x2(%ebx)
80109c37:	eb 5e                	jmp    80109c97 <APCharacterInit+0x16fd>
		
		else if(i>=25&&i<35)
80109c39:	83 bd 70 ff ff ff 18 	cmpl   $0x18,-0x90(%ebp)
80109c40:	7e 55                	jle    80109c97 <APCharacterInit+0x16fd>
80109c42:	83 bd 70 ff ff ff 22 	cmpl   $0x22,-0x90(%ebp)
80109c49:	7f 4c                	jg     80109c97 <APCharacterInit+0x16fd>
			character_img[i][j] = RGB(128,64,0);
80109c4b:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
80109c51:	8b 8d 70 ff ff ff    	mov    -0x90(%ebp),%ecx
80109c57:	89 d0                	mov    %edx,%eax
80109c59:	01 c0                	add    %eax,%eax
80109c5b:	01 d0                	add    %edx,%eax
80109c5d:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109c63:	01 d0                	add    %edx,%eax
80109c65:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109c6b:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109c71:	6a 00                	push   $0x0
80109c73:	6a 40                	push   $0x40
80109c75:	68 80 00 00 00       	push   $0x80
80109c7a:	50                   	push   %eax
80109c7b:	e8 b6 e6 ff ff       	call   80108336 <RGB>
80109c80:	83 c4 0c             	add    $0xc,%esp
80109c83:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109c8a:	66 89 03             	mov    %ax,(%ebx)
80109c8d:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109c94:	88 43 02             	mov    %al,0x2(%ebx)

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109c97:	83 85 70 ff ff ff 01 	addl   $0x1,-0x90(%ebp)
80109c9e:	83 bd 70 ff ff ff 27 	cmpl   $0x27,-0x90(%ebp)
80109ca5:	0f 8e 37 ff ff ff    	jle    80109be2 <APCharacterInit+0x1648>
			character_img[i][j] = RGB(128,64,0);

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
80109cab:	83 85 74 ff ff ff 01 	addl   $0x1,-0x8c(%ebp)
80109cb2:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109cb8:	83 c0 03             	add    $0x3,%eax
80109cbb:	3b 85 74 ff ff ff    	cmp    -0x8c(%ebp),%eax
80109cc1:	0f 8f 0c ff ff ff    	jg     80109bd3 <APCharacterInit+0x1639>
			character_img[i][j] = RGB(128,64,0);

		
}}

   for(int j=0;j<GRID_WIDTH;j++)
80109cc7:	c7 85 6c ff ff ff 00 	movl   $0x0,-0x94(%ebp)
80109cce:	00 00 00 
80109cd1:	eb 76                	jmp    80109d49 <APCharacterInit+0x17af>
   	for(int i=0;i<GRID_WIDTH;i++)
80109cd3:	c7 85 68 ff ff ff 00 	movl   $0x0,-0x98(%ebp)
80109cda:	00 00 00 
80109cdd:	eb 5a                	jmp    80109d39 <APCharacterInit+0x179f>
      		character_img2[GRID_WIDTH-1-i][j] = character_img[i][j];
80109cdf:	b8 31 00 00 00       	mov    $0x31,%eax
80109ce4:	2b 85 68 ff ff ff    	sub    -0x98(%ebp),%eax
80109cea:	89 c1                	mov    %eax,%ecx
80109cec:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
80109cf2:	89 d0                	mov    %edx,%eax
80109cf4:	01 c0                	add    %eax,%eax
80109cf6:	01 d0                	add    %edx,%eax
80109cf8:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109cfe:	01 d0                	add    %edx,%eax
80109d00:	8d 90 20 96 11 80    	lea    -0x7fee69e0(%eax),%edx
80109d06:	8b 8d 6c ff ff ff    	mov    -0x94(%ebp),%ecx
80109d0c:	8b 9d 68 ff ff ff    	mov    -0x98(%ebp),%ebx
80109d12:	89 c8                	mov    %ecx,%eax
80109d14:	01 c0                	add    %eax,%eax
80109d16:	01 c8                	add    %ecx,%eax
80109d18:	69 cb 96 00 00 00    	imul   $0x96,%ebx,%ecx
80109d1e:	01 c8                	add    %ecx,%eax
80109d20:	05 c0 78 11 80       	add    $0x801178c0,%eax
80109d25:	0f b7 08             	movzwl (%eax),%ecx
80109d28:	66 89 0a             	mov    %cx,(%edx)
80109d2b:	0f b6 40 02          	movzbl 0x2(%eax),%eax
80109d2f:	88 42 02             	mov    %al,0x2(%edx)

		
}}

   for(int j=0;j<GRID_WIDTH;j++)
   	for(int i=0;i<GRID_WIDTH;i++)
80109d32:	83 85 68 ff ff ff 01 	addl   $0x1,-0x98(%ebp)
80109d39:	83 bd 68 ff ff ff 31 	cmpl   $0x31,-0x98(%ebp)
80109d40:	7e 9d                	jle    80109cdf <APCharacterInit+0x1745>
			character_img[i][j] = RGB(128,64,0);

		
}}

   for(int j=0;j<GRID_WIDTH;j++)
80109d42:	83 85 6c ff ff ff 01 	addl   $0x1,-0x94(%ebp)
80109d49:	83 bd 6c ff ff ff 31 	cmpl   $0x31,-0x94(%ebp)
80109d50:	7e 81                	jle    80109cd3 <APCharacterInit+0x1739>
   	for(int i=0;i<GRID_WIDTH;i++)
      		character_img2[GRID_WIDTH-1-i][j] = character_img[i][j];
}
80109d52:	90                   	nop
80109d53:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80109d56:	c9                   	leave  
80109d57:	c3                   	ret    

80109d58 <APGuiInit>:

void APGuiInit(void)
{
80109d58:	55                   	push   %ebp
80109d59:	89 e5                	mov    %esp,%ebp
80109d5b:	53                   	push   %ebx
80109d5c:	83 ec 04             	sub    $0x4,%esp
    screenAddr = (AColor *)(*((uint*)P2V(0x1028)));
80109d5f:	b8 28 10 00 80       	mov    $0x80001028,%eax
80109d64:	8b 00                	mov    (%eax),%eax
80109d66:	a3 a8 e6 10 80       	mov    %eax,0x8010e6a8
    screenWidth = *((ushort *)P2V(0x1012));
80109d6b:	b8 12 10 00 80       	mov    $0x80001012,%eax
80109d70:	0f b7 00             	movzwl (%eax),%eax
80109d73:	66 a3 94 e6 10 80    	mov    %ax,0x8010e694
    screenHeight = *((ushort *)P2V(0x1014));
80109d79:	b8 14 10 00 80       	mov    $0x80001014,%eax
80109d7e:	0f b7 00             	movzwl (%eax),%eax
80109d81:	66 a3 96 e6 10 80    	mov    %ax,0x8010e696
    bitsPerPixel = *((uchar*)P2V(0x1019));
80109d87:	b8 19 10 00 80       	mov    $0x80001019,%eax
80109d8c:	0f b6 00             	movzbl (%eax),%eax
80109d8f:	a2 98 e6 10 80       	mov    %al,0x8010e698
    screenBuf = screenAddr + screenWidth * screenHeight;
80109d94:	8b 15 a8 e6 10 80    	mov    0x8010e6a8,%edx
80109d9a:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109da1:	0f b7 c8             	movzwl %ax,%ecx
80109da4:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
80109dab:	0f b7 c0             	movzwl %ax,%eax
80109dae:	0f af c1             	imul   %ecx,%eax
80109db1:	89 c1                	mov    %eax,%ecx
80109db3:	89 c8                	mov    %ecx,%eax
80109db5:	01 c0                	add    %eax,%eax
80109db7:	01 c8                	add    %ecx,%eax
80109db9:	01 d0                	add    %edx,%eax
80109dbb:	a3 ac e6 10 80       	mov    %eax,0x8010e6ac
    screenContent = screenBuf + screenWidth * screenHeight;
80109dc0:	8b 15 ac e6 10 80    	mov    0x8010e6ac,%edx
80109dc6:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109dcd:	0f b7 c8             	movzwl %ax,%ecx
80109dd0:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
80109dd7:	0f b7 c0             	movzwl %ax,%eax
80109dda:	0f af c1             	imul   %ecx,%eax
80109ddd:	89 c1                	mov    %eax,%ecx
80109ddf:	89 c8                	mov    %ecx,%eax
80109de1:	01 c0                	add    %eax,%eax
80109de3:	01 c8                	add    %ecx,%eax
80109de5:	01 d0                	add    %edx,%eax
80109de7:	a3 b0 e6 10 80       	mov    %eax,0x8010e6b0
    
    cprintf("screen addr : %x, screen width : %d, screen height : %d, bitsPerPixel: %d \n",
80109dec:	0f b6 05 98 e6 10 80 	movzbl 0x8010e698,%eax
80109df3:	0f b6 d8             	movzbl %al,%ebx
80109df6:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
80109dfd:	0f b7 c8             	movzwl %ax,%ecx
80109e00:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109e07:	0f b7 d0             	movzwl %ax,%edx
80109e0a:	a1 a8 e6 10 80       	mov    0x8010e6a8,%eax
80109e0f:	83 ec 0c             	sub    $0xc,%esp
80109e12:	53                   	push   %ebx
80109e13:	51                   	push   %ecx
80109e14:	52                   	push   %edx
80109e15:	50                   	push   %eax
80109e16:	68 a4 ba 10 80       	push   $0x8010baa4
80109e1b:	e8 a6 65 ff ff       	call   801003c6 <cprintf>
80109e20:	83 c4 20             	add    $0x20,%esp
            screenAddr, screenWidth,screenHeight,bitsPerPixel);
    
    initlock(&screenLock,"sreenLock");
80109e23:	83 ec 08             	sub    $0x8,%esp
80109e26:	68 f0 ba 10 80       	push   $0x8010baf0
80109e2b:	68 60 57 11 80       	push   $0x80115760
80109e30:	e8 e6 af ff ff       	call   80104e1b <initlock>
80109e35:	83 c4 10             	add    $0x10,%esp
    APCharacterInit();
80109e38:	e8 5d e7 ff ff       	call   8010859a <APCharacterInit>
    APTimerListInit(&timerList);
80109e3d:	83 ec 0c             	sub    $0xc,%esp
80109e40:	68 80 b3 11 80       	push   $0x8011b380
80109e45:	e8 51 10 00 00       	call   8010ae9b <APTimerListInit>
80109e4a:	83 c4 10             	add    $0x10,%esp
}
80109e4d:	90                   	nop
80109e4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80109e51:	c9                   	leave  
80109e52:	c3                   	ret    

80109e53 <APBufPaint>:

//将左上角坐标为(x1,y1),右下角坐标为(x2,y2)的矩形区域从Buf绘制到屏幕上
void APBufPaint(int x1,int y1,int x2,int y2,int is_grid)
{
80109e53:	55                   	push   %ebp
80109e54:	89 e5                	mov    %esp,%ebp
80109e56:	56                   	push   %esi
80109e57:	53                   	push   %ebx
80109e58:	83 ec 20             	sub    $0x20,%esp
    acquire(&screenLock);
80109e5b:	83 ec 0c             	sub    $0xc,%esp
80109e5e:	68 60 57 11 80       	push   $0x80115760
80109e63:	e8 d5 af ff ff       	call   80104e3d <acquire>
80109e68:	83 c4 10             	add    $0x10,%esp
    x2 -= x1;
80109e6b:	8b 45 08             	mov    0x8(%ebp),%eax
80109e6e:	29 45 10             	sub    %eax,0x10(%ebp)
    x2 *= sizeof(AColor);
80109e71:	8b 55 10             	mov    0x10(%ebp),%edx
80109e74:	89 d0                	mov    %edx,%eax
80109e76:	01 c0                	add    %eax,%eax
80109e78:	01 d0                	add    %edx,%eax
80109e7a:	89 45 10             	mov    %eax,0x10(%ebp)
    int off = x1 + y1 * screenWidth;
80109e7d:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109e84:	0f b7 c0             	movzwl %ax,%eax
80109e87:	0f af 45 0c          	imul   0xc(%ebp),%eax
80109e8b:	89 c2                	mov    %eax,%edx
80109e8d:	8b 45 08             	mov    0x8(%ebp),%eax
80109e90:	01 d0                	add    %edx,%eax
80109e92:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (int y = y1 ; y <= y2; y++)
80109e95:	8b 45 0c             	mov    0xc(%ebp),%eax
80109e98:	89 45 f0             	mov    %eax,-0x10(%ebp)
80109e9b:	eb 77                	jmp    80109f14 <APBufPaint+0xc1>
    {
        memmove(screenBuf + off , screenContent + off, x2);
80109e9d:	8b 4d 10             	mov    0x10(%ebp),%ecx
80109ea0:	8b 1d b0 e6 10 80    	mov    0x8010e6b0,%ebx
80109ea6:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109ea9:	89 d0                	mov    %edx,%eax
80109eab:	01 c0                	add    %eax,%eax
80109ead:	01 d0                	add    %edx,%eax
80109eaf:	01 c3                	add    %eax,%ebx
80109eb1:	8b 35 ac e6 10 80    	mov    0x8010e6ac,%esi
80109eb7:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109eba:	89 d0                	mov    %edx,%eax
80109ebc:	01 c0                	add    %eax,%eax
80109ebe:	01 d0                	add    %edx,%eax
80109ec0:	01 f0                	add    %esi,%eax
80109ec2:	83 ec 04             	sub    $0x4,%esp
80109ec5:	51                   	push   %ecx
80109ec6:	53                   	push   %ebx
80109ec7:	50                   	push   %eax
80109ec8:	e8 92 b2 ff ff       	call   8010515f <memmove>
80109ecd:	83 c4 10             	add    $0x10,%esp
        memmove(screenAddr + off, screenContent + off, x2);
80109ed0:	8b 4d 10             	mov    0x10(%ebp),%ecx
80109ed3:	8b 1d b0 e6 10 80    	mov    0x8010e6b0,%ebx
80109ed9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109edc:	89 d0                	mov    %edx,%eax
80109ede:	01 c0                	add    %eax,%eax
80109ee0:	01 d0                	add    %edx,%eax
80109ee2:	01 c3                	add    %eax,%ebx
80109ee4:	8b 35 a8 e6 10 80    	mov    0x8010e6a8,%esi
80109eea:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109eed:	89 d0                	mov    %edx,%eax
80109eef:	01 c0                	add    %eax,%eax
80109ef1:	01 d0                	add    %edx,%eax
80109ef3:	01 f0                	add    %esi,%eax
80109ef5:	83 ec 04             	sub    $0x4,%esp
80109ef8:	51                   	push   %ecx
80109ef9:	53                   	push   %ebx
80109efa:	50                   	push   %eax
80109efb:	e8 5f b2 ff ff       	call   8010515f <memmove>
80109f00:	83 c4 10             	add    $0x10,%esp
        off += screenWidth;
80109f03:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109f0a:	0f b7 c0             	movzwl %ax,%eax
80109f0d:	01 45 f4             	add    %eax,-0xc(%ebp)
{
    acquire(&screenLock);
    x2 -= x1;
    x2 *= sizeof(AColor);
    int off = x1 + y1 * screenWidth;
    for (int y = y1 ; y <= y2; y++)
80109f10:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80109f14:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109f17:	3b 45 14             	cmp    0x14(%ebp),%eax
80109f1a:	7e 81                	jle    80109e9d <APBufPaint+0x4a>
        memmove(screenBuf + off , screenContent + off, x2);
        memmove(screenAddr + off, screenContent + off, x2);
        off += screenWidth;
    }
    
    if (is_grid)
80109f1c:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
80109f20:	0f 84 d6 01 00 00    	je     8010a0fc <APBufPaint+0x2a9>
    {
        
        if (x1 <= character_x * GRID_WIDTH + GRID_WIDTH && x2 >= character_x * GRID_WIDTH
80109f26:	a1 00 e5 10 80       	mov    0x8010e500,%eax
80109f2b:	83 c0 01             	add    $0x1,%eax
80109f2e:	6b c0 32             	imul   $0x32,%eax,%eax
80109f31:	3b 45 08             	cmp    0x8(%ebp),%eax
80109f34:	0f 8c c2 01 00 00    	jl     8010a0fc <APBufPaint+0x2a9>
80109f3a:	a1 00 e5 10 80       	mov    0x8010e500,%eax
80109f3f:	6b c0 32             	imul   $0x32,%eax,%eax
80109f42:	3b 45 10             	cmp    0x10(%ebp),%eax
80109f45:	0f 8f b1 01 00 00    	jg     8010a0fc <APBufPaint+0x2a9>
            && y1 <= character_y * GRID_WIDTH + GRID_WIDTH + WND_TITLE_HEIGHT && y2 >= character_y * GRID_WIDTH + WND_TITLE_HEIGHT)
80109f4b:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80109f50:	83 c0 02             	add    $0x2,%eax
80109f53:	6b c0 32             	imul   $0x32,%eax,%eax
80109f56:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109f59:	0f 8c 9d 01 00 00    	jl     8010a0fc <APBufPaint+0x2a9>
80109f5f:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80109f64:	83 c0 01             	add    $0x1,%eax
80109f67:	6b c0 32             	imul   $0x32,%eax,%eax
80109f6a:	3b 45 14             	cmp    0x14(%ebp),%eax
80109f6d:	0f 8f 89 01 00 00    	jg     8010a0fc <APBufPaint+0x2a9>
        {
            for (int j = 0; j < GRID_WIDTH ; j++)
80109f73:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80109f7a:	e9 70 01 00 00       	jmp    8010a0ef <APBufPaint+0x29c>
            {
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
80109f7f:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80109f84:	83 c0 01             	add    $0x1,%eax
80109f87:	6b d0 32             	imul   $0x32,%eax,%edx
80109f8a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109f8d:	01 c2                	add    %eax,%edx
80109f8f:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109f96:	0f b7 c0             	movzwl %ax,%eax
80109f99:	0f af d0             	imul   %eax,%edx
80109f9c:	a1 00 e5 10 80       	mov    0x8010e500,%eax
80109fa1:	6b c0 32             	imul   $0x32,%eax,%eax
80109fa4:	01 d0                	add    %edx,%eax
80109fa6:	89 45 f4             	mov    %eax,-0xc(%ebp)
                if (character_y * GRID_WIDTH + j < y1)
80109fa9:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80109fae:	6b d0 32             	imul   $0x32,%eax,%edx
80109fb1:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109fb4:	01 d0                	add    %edx,%eax
80109fb6:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109fb9:	0f 8c 28 01 00 00    	jl     8010a0e7 <APBufPaint+0x294>
                    continue;
                if (character_y * GRID_WIDTH + j > y2)
80109fbf:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80109fc4:	6b d0 32             	imul   $0x32,%eax,%edx
80109fc7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109fca:	01 d0                	add    %edx,%eax
80109fcc:	3b 45 14             	cmp    0x14(%ebp),%eax
80109fcf:	0f 8f 26 01 00 00    	jg     8010a0fb <APBufPaint+0x2a8>
                    break;
                for (int i = 0; i < GRID_WIDTH; i++)
80109fd5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
80109fdc:	e9 fa 00 00 00       	jmp    8010a0db <APBufPaint+0x288>
                {
                    if (character_x * GRID_WIDTH + i < x1)
80109fe1:	a1 00 e5 10 80       	mov    0x8010e500,%eax
80109fe6:	6b d0 32             	imul   $0x32,%eax,%edx
80109fe9:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109fec:	01 d0                	add    %edx,%eax
80109fee:	3b 45 08             	cmp    0x8(%ebp),%eax
80109ff1:	0f 8c df 00 00 00    	jl     8010a0d6 <APBufPaint+0x283>
                        continue;
                    if (character_x * GRID_WIDTH + i > x2)
80109ff7:	a1 00 e5 10 80       	mov    0x8010e500,%eax
80109ffc:	6b d0 32             	imul   $0x32,%eax,%edx
80109fff:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a002:	01 d0                	add    %edx,%eax
8010a004:	3b 45 10             	cmp    0x10(%ebp),%eax
8010a007:	0f 8f dd 00 00 00    	jg     8010a0ea <APBufPaint+0x297>
                        break;
                    
                    AColor c;
                    if (direction == 1) c = character_img[i][j];
8010a00d:	a1 08 e5 10 80       	mov    0x8010e508,%eax
8010a012:	83 f8 01             	cmp    $0x1,%eax
8010a015:	75 29                	jne    8010a040 <APBufPaint+0x1ed>
8010a017:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010a01a:	8b 4d e8             	mov    -0x18(%ebp),%ecx
8010a01d:	89 d0                	mov    %edx,%eax
8010a01f:	01 c0                	add    %eax,%eax
8010a021:	01 d0                	add    %edx,%eax
8010a023:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010a029:	01 d0                	add    %edx,%eax
8010a02b:	05 c0 78 11 80       	add    $0x801178c0,%eax
8010a030:	0f b7 10             	movzwl (%eax),%edx
8010a033:	66 89 55 e5          	mov    %dx,-0x1b(%ebp)
8010a037:	0f b6 40 02          	movzbl 0x2(%eax),%eax
8010a03b:	88 45 e7             	mov    %al,-0x19(%ebp)
8010a03e:	eb 30                	jmp    8010a070 <APBufPaint+0x21d>
                    else if (direction == 0)  c = character_img2[i][j];
8010a040:	a1 08 e5 10 80       	mov    0x8010e508,%eax
8010a045:	85 c0                	test   %eax,%eax
8010a047:	75 27                	jne    8010a070 <APBufPaint+0x21d>
8010a049:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010a04c:	8b 4d e8             	mov    -0x18(%ebp),%ecx
8010a04f:	89 d0                	mov    %edx,%eax
8010a051:	01 c0                	add    %eax,%eax
8010a053:	01 d0                	add    %edx,%eax
8010a055:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010a05b:	01 d0                	add    %edx,%eax
8010a05d:	05 20 96 11 80       	add    $0x80119620,%eax
8010a062:	0f b7 10             	movzwl (%eax),%edx
8010a065:	66 89 55 e5          	mov    %dx,-0x1b(%ebp)
8010a069:	0f b6 40 02          	movzbl 0x2(%eax),%eax
8010a06d:	88 45 e7             	mov    %al,-0x19(%ebp)
                    
                    if (c.r != COLOR_TRANSPARENT || c.g!=COLOR_TRANSPARENT || c.b !=COLOR_TRANSPARENT)
8010a070:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010a074:	3c 0c                	cmp    $0xc,%al
8010a076:	75 10                	jne    8010a088 <APBufPaint+0x235>
8010a078:	0f b6 45 e6          	movzbl -0x1a(%ebp),%eax
8010a07c:	3c 0c                	cmp    $0xc,%al
8010a07e:	75 08                	jne    8010a088 <APBufPaint+0x235>
8010a080:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
8010a084:	3c 0c                	cmp    $0xc,%al
8010a086:	74 4f                	je     8010a0d7 <APBufPaint+0x284>
                    {
                        screenBuf [off + i] = c;
8010a088:	8b 15 ac e6 10 80    	mov    0x8010e6ac,%edx
8010a08e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010a091:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a094:	01 c8                	add    %ecx,%eax
8010a096:	89 c1                	mov    %eax,%ecx
8010a098:	89 c8                	mov    %ecx,%eax
8010a09a:	01 c0                	add    %eax,%eax
8010a09c:	01 c8                	add    %ecx,%eax
8010a09e:	01 d0                	add    %edx,%eax
8010a0a0:	0f b7 55 e5          	movzwl -0x1b(%ebp),%edx
8010a0a4:	66 89 10             	mov    %dx,(%eax)
8010a0a7:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
8010a0ab:	88 50 02             	mov    %dl,0x2(%eax)
                        screenAddr[off + i] = c;
8010a0ae:	8b 15 a8 e6 10 80    	mov    0x8010e6a8,%edx
8010a0b4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010a0b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a0ba:	01 c8                	add    %ecx,%eax
8010a0bc:	89 c1                	mov    %eax,%ecx
8010a0be:	89 c8                	mov    %ecx,%eax
8010a0c0:	01 c0                	add    %eax,%eax
8010a0c2:	01 c8                	add    %ecx,%eax
8010a0c4:	01 d0                	add    %edx,%eax
8010a0c6:	0f b7 55 e5          	movzwl -0x1b(%ebp),%edx
8010a0ca:	66 89 10             	mov    %dx,(%eax)
8010a0cd:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
8010a0d1:	88 50 02             	mov    %dl,0x2(%eax)
8010a0d4:	eb 01                	jmp    8010a0d7 <APBufPaint+0x284>
                if (character_y * GRID_WIDTH + j > y2)
                    break;
                for (int i = 0; i < GRID_WIDTH; i++)
                {
                    if (character_x * GRID_WIDTH + i < x1)
                        continue;
8010a0d6:	90                   	nop
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
                if (character_y * GRID_WIDTH + j < y1)
                    continue;
                if (character_y * GRID_WIDTH + j > y2)
                    break;
                for (int i = 0; i < GRID_WIDTH; i++)
8010a0d7:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
8010a0db:	83 7d e8 31          	cmpl   $0x31,-0x18(%ebp)
8010a0df:	0f 8e fc fe ff ff    	jle    80109fe1 <APBufPaint+0x18e>
8010a0e5:	eb 04                	jmp    8010a0eb <APBufPaint+0x298>
        {
            for (int j = 0; j < GRID_WIDTH ; j++)
            {
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
                if (character_y * GRID_WIDTH + j < y1)
                    continue;
8010a0e7:	90                   	nop
8010a0e8:	eb 01                	jmp    8010a0eb <APBufPaint+0x298>
                for (int i = 0; i < GRID_WIDTH; i++)
                {
                    if (character_x * GRID_WIDTH + i < x1)
                        continue;
                    if (character_x * GRID_WIDTH + i > x2)
                        break;
8010a0ea:	90                   	nop
    {
        
        if (x1 <= character_x * GRID_WIDTH + GRID_WIDTH && x2 >= character_x * GRID_WIDTH
            && y1 <= character_y * GRID_WIDTH + GRID_WIDTH + WND_TITLE_HEIGHT && y2 >= character_y * GRID_WIDTH + WND_TITLE_HEIGHT)
        {
            for (int j = 0; j < GRID_WIDTH ; j++)
8010a0eb:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
8010a0ef:	83 7d ec 31          	cmpl   $0x31,-0x14(%ebp)
8010a0f3:	0f 8e 86 fe ff ff    	jle    80109f7f <APBufPaint+0x12c>
8010a0f9:	eb 01                	jmp    8010a0fc <APBufPaint+0x2a9>
            {
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
                if (character_y * GRID_WIDTH + j < y1)
                    continue;
                if (character_y * GRID_WIDTH + j > y2)
                    break;
8010a0fb:	90                   	nop
            }
        }
    }
    //cprintf("arbitrary set window color!\n");
    //memset(screenAddr, DEFAULT_WINDOW_COLOR, sizeof(AColor) * screenWidth * screenHeight);
    release(&screenLock);
8010a0fc:	83 ec 0c             	sub    $0xc,%esp
8010a0ff:	68 60 57 11 80       	push   $0x80115760
8010a104:	e8 9b ad ff ff       	call   80104ea4 <release>
8010a109:	83 c4 10             	add    $0x10,%esp
}
8010a10c:	90                   	nop
8010a10d:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010a110:	5b                   	pop    %ebx
8010a111:	5e                   	pop    %esi
8010a112:	5d                   	pop    %ebp
8010a113:	c3                   	ret    

8010a114 <sys_paintWindow>:

//paintwindow: (hwnd,wx,wy,hdc,sx,sy,w,h,is_grid,pos_x,pos_y)
int sys_paintWindow(void)
{
8010a114:	55                   	push   %ebp
8010a115:	89 e5                	mov    %esp,%ebp
8010a117:	56                   	push   %esi
8010a118:	53                   	push   %ebx
8010a119:	83 ec 50             	sub    $0x50,%esp
    //cprintf("in paintWindow function:---- 1  \n");
    AHwnd hwnd = 0;
8010a11c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    AHdc hdc = 0;
8010a123:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    int wx,wy,sx,sy,w,h,is_grid,pos_x,pos_y;
    //从控制台获取数据，并检验值是否合法
    if (argstr(0, (char **)&hwnd) < 0 || argint(1, &wx) < 0 || argint(2, &wy) < 0
8010a12a:	83 ec 08             	sub    $0x8,%esp
8010a12d:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010a130:	50                   	push   %eax
8010a131:	6a 00                	push   $0x0
8010a133:	e8 12 b3 ff ff       	call   8010544a <argstr>
8010a138:	83 c4 10             	add    $0x10,%esp
8010a13b:	85 c0                	test   %eax,%eax
8010a13d:	0f 88 de 00 00 00    	js     8010a221 <sys_paintWindow+0x10d>
8010a143:	83 ec 08             	sub    $0x8,%esp
8010a146:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010a149:	50                   	push   %eax
8010a14a:	6a 01                	push   $0x1
8010a14c:	e8 74 b2 ff ff       	call   801053c5 <argint>
8010a151:	83 c4 10             	add    $0x10,%esp
8010a154:	85 c0                	test   %eax,%eax
8010a156:	0f 88 c5 00 00 00    	js     8010a221 <sys_paintWindow+0x10d>
8010a15c:	83 ec 08             	sub    $0x8,%esp
8010a15f:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010a162:	50                   	push   %eax
8010a163:	6a 02                	push   $0x2
8010a165:	e8 5b b2 ff ff       	call   801053c5 <argint>
8010a16a:	83 c4 10             	add    $0x10,%esp
8010a16d:	85 c0                	test   %eax,%eax
8010a16f:	0f 88 ac 00 00 00    	js     8010a221 <sys_paintWindow+0x10d>
        || argstr(3, (char **)&hdc) < 0 || argint(4, &sx) < 0
8010a175:	83 ec 08             	sub    $0x8,%esp
8010a178:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010a17b:	50                   	push   %eax
8010a17c:	6a 03                	push   $0x3
8010a17e:	e8 c7 b2 ff ff       	call   8010544a <argstr>
8010a183:	83 c4 10             	add    $0x10,%esp
8010a186:	85 c0                	test   %eax,%eax
8010a188:	0f 88 93 00 00 00    	js     8010a221 <sys_paintWindow+0x10d>
8010a18e:	83 ec 08             	sub    $0x8,%esp
8010a191:	8d 45 d0             	lea    -0x30(%ebp),%eax
8010a194:	50                   	push   %eax
8010a195:	6a 04                	push   $0x4
8010a197:	e8 29 b2 ff ff       	call   801053c5 <argint>
8010a19c:	83 c4 10             	add    $0x10,%esp
8010a19f:	85 c0                	test   %eax,%eax
8010a1a1:	78 7e                	js     8010a221 <sys_paintWindow+0x10d>
        || argint(5, &sy) < 0 || argint(6, &w) < 0 || argint(7, &h) < 0
8010a1a3:	83 ec 08             	sub    $0x8,%esp
8010a1a6:	8d 45 cc             	lea    -0x34(%ebp),%eax
8010a1a9:	50                   	push   %eax
8010a1aa:	6a 05                	push   $0x5
8010a1ac:	e8 14 b2 ff ff       	call   801053c5 <argint>
8010a1b1:	83 c4 10             	add    $0x10,%esp
8010a1b4:	85 c0                	test   %eax,%eax
8010a1b6:	78 69                	js     8010a221 <sys_paintWindow+0x10d>
8010a1b8:	83 ec 08             	sub    $0x8,%esp
8010a1bb:	8d 45 c8             	lea    -0x38(%ebp),%eax
8010a1be:	50                   	push   %eax
8010a1bf:	6a 06                	push   $0x6
8010a1c1:	e8 ff b1 ff ff       	call   801053c5 <argint>
8010a1c6:	83 c4 10             	add    $0x10,%esp
8010a1c9:	85 c0                	test   %eax,%eax
8010a1cb:	78 54                	js     8010a221 <sys_paintWindow+0x10d>
8010a1cd:	83 ec 08             	sub    $0x8,%esp
8010a1d0:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010a1d3:	50                   	push   %eax
8010a1d4:	6a 07                	push   $0x7
8010a1d6:	e8 ea b1 ff ff       	call   801053c5 <argint>
8010a1db:	83 c4 10             	add    $0x10,%esp
8010a1de:	85 c0                	test   %eax,%eax
8010a1e0:	78 3f                	js     8010a221 <sys_paintWindow+0x10d>
        || argint(8, &is_grid) < 0 ||argint(9, &pos_x) < 0 || argint(10, &pos_y) < 0)
8010a1e2:	83 ec 08             	sub    $0x8,%esp
8010a1e5:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010a1e8:	50                   	push   %eax
8010a1e9:	6a 08                	push   $0x8
8010a1eb:	e8 d5 b1 ff ff       	call   801053c5 <argint>
8010a1f0:	83 c4 10             	add    $0x10,%esp
8010a1f3:	85 c0                	test   %eax,%eax
8010a1f5:	78 2a                	js     8010a221 <sys_paintWindow+0x10d>
8010a1f7:	83 ec 08             	sub    $0x8,%esp
8010a1fa:	8d 45 bc             	lea    -0x44(%ebp),%eax
8010a1fd:	50                   	push   %eax
8010a1fe:	6a 09                	push   $0x9
8010a200:	e8 c0 b1 ff ff       	call   801053c5 <argint>
8010a205:	83 c4 10             	add    $0x10,%esp
8010a208:	85 c0                	test   %eax,%eax
8010a20a:	78 15                	js     8010a221 <sys_paintWindow+0x10d>
8010a20c:	83 ec 08             	sub    $0x8,%esp
8010a20f:	8d 45 b8             	lea    -0x48(%ebp),%eax
8010a212:	50                   	push   %eax
8010a213:	6a 0a                	push   $0xa
8010a215:	e8 ab b1 ff ff       	call   801053c5 <argint>
8010a21a:	83 c4 10             	add    $0x10,%esp
8010a21d:	85 c0                	test   %eax,%eax
8010a21f:	79 0a                	jns    8010a22b <sys_paintWindow+0x117>
        return -1;
8010a221:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a226:	e9 77 02 00 00       	jmp    8010a4a2 <sys_paintWindow+0x38e>
    
    if (sx < 0 || sy < 0 || h <= 0 || w <= 0 || sx + w > hdc->size.cx || sy + h > hdc->size.cy)
8010a22b:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010a22e:	85 c0                	test   %eax,%eax
8010a230:	78 38                	js     8010a26a <sys_paintWindow+0x156>
8010a232:	8b 45 cc             	mov    -0x34(%ebp),%eax
8010a235:	85 c0                	test   %eax,%eax
8010a237:	78 31                	js     8010a26a <sys_paintWindow+0x156>
8010a239:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a23c:	85 c0                	test   %eax,%eax
8010a23e:	7e 2a                	jle    8010a26a <sys_paintWindow+0x156>
8010a240:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a243:	85 c0                	test   %eax,%eax
8010a245:	7e 23                	jle    8010a26a <sys_paintWindow+0x156>
8010a247:	8b 55 d0             	mov    -0x30(%ebp),%edx
8010a24a:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a24d:	01 c2                	add    %eax,%edx
8010a24f:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a252:	8b 00                	mov    (%eax),%eax
8010a254:	39 c2                	cmp    %eax,%edx
8010a256:	7f 12                	jg     8010a26a <sys_paintWindow+0x156>
8010a258:	8b 55 cc             	mov    -0x34(%ebp),%edx
8010a25b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a25e:	01 c2                	add    %eax,%edx
8010a260:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a263:	8b 40 04             	mov    0x4(%eax),%eax
8010a266:	39 c2                	cmp    %eax,%edx
8010a268:	7e 0a                	jle    8010a274 <sys_paintWindow+0x160>
        return 0;
8010a26a:	b8 00 00 00 00       	mov    $0x0,%eax
8010a26f:	e9 2e 02 00 00       	jmp    8010a4a2 <sys_paintWindow+0x38e>
    
    if (wx < 0 || wy < 0 || wx + w > screenWidth || wy + h > screenHeight)
8010a274:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a277:	85 c0                	test   %eax,%eax
8010a279:	78 33                	js     8010a2ae <sys_paintWindow+0x19a>
8010a27b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a27e:	85 c0                	test   %eax,%eax
8010a280:	78 2c                	js     8010a2ae <sys_paintWindow+0x19a>
8010a282:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010a285:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a288:	01 c2                	add    %eax,%edx
8010a28a:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010a291:	0f b7 c0             	movzwl %ax,%eax
8010a294:	39 c2                	cmp    %eax,%edx
8010a296:	7f 16                	jg     8010a2ae <sys_paintWindow+0x19a>
8010a298:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a29b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a29e:	01 c2                	add    %eax,%edx
8010a2a0:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
8010a2a7:	0f b7 c0             	movzwl %ax,%eax
8010a2aa:	39 c2                	cmp    %eax,%edx
8010a2ac:	7e 0a                	jle    8010a2b8 <sys_paintWindow+0x1a4>
        return 0;
8010a2ae:	b8 00 00 00 00       	mov    $0x0,%eax
8010a2b3:	e9 ea 01 00 00       	jmp    8010a4a2 <sys_paintWindow+0x38e>
    
    character_x = pos_x;
8010a2b8:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010a2bb:	a3 00 e5 10 80       	mov    %eax,0x8010e500
    character_y = pos_y;
8010a2c0:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010a2c3:	a3 04 e5 10 80       	mov    %eax,0x8010e504
    //wx,wy是window重绘左上角坐标
    //int id = hwnd ->id;
    //cprintf("in paintWindow function:-----2  \n");
    AColor *data = hdc->content;
8010a2c8:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a2cb:	8b 40 18             	mov    0x18(%eax),%eax
8010a2ce:	89 45 ec             	mov    %eax,-0x14(%ebp)
    
    int j;
    for (int i = 0; i < h;i++)
8010a2d1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010a2d8:	e9 18 01 00 00       	jmp    8010a3f5 <sys_paintWindow+0x2e1>
    {
        if (wy + i < 0)
8010a2dd:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a2e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a2e3:	01 d0                	add    %edx,%eax
8010a2e5:	85 c0                	test   %eax,%eax
8010a2e7:	79 0d                	jns    8010a2f6 <sys_paintWindow+0x1e2>
        {
            i = -wy - 1;
8010a2e9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a2ec:	f7 d0                	not    %eax
8010a2ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
            continue;
8010a2f1:	e9 fb 00 00 00       	jmp    8010a3f1 <sys_paintWindow+0x2dd>
        }
        else if (wy + i >= screenHeight)
8010a2f6:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a2f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a2fc:	01 c2                	add    %eax,%edx
8010a2fe:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
8010a305:	0f b7 c0             	movzwl %ax,%eax
8010a308:	39 c2                	cmp    %eax,%edx
8010a30a:	0f 8d f3 00 00 00    	jge    8010a403 <sys_paintWindow+0x2ef>
            break;
        int off_x = (sy + i) * hdc->size.cx + sx;
8010a310:	8b 55 cc             	mov    -0x34(%ebp),%edx
8010a313:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a316:	01 c2                	add    %eax,%edx
8010a318:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a31b:	8b 00                	mov    (%eax),%eax
8010a31d:	0f af d0             	imul   %eax,%edx
8010a320:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010a323:	01 d0                	add    %edx,%eax
8010a325:	89 45 e8             	mov    %eax,-0x18(%ebp)
        int screen_off_x = (wy + i) * screenWidth + wx;
8010a328:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a32b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a32e:	01 c2                	add    %eax,%edx
8010a330:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010a337:	0f b7 c0             	movzwl %ax,%eax
8010a33a:	0f af d0             	imul   %eax,%edx
8010a33d:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a340:	01 d0                	add    %edx,%eax
8010a342:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        for (j = 0; j < w; ++j)
8010a345:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010a34c:	e9 91 00 00 00       	jmp    8010a3e2 <sys_paintWindow+0x2ce>
        {
            if (wx + j < 0)
8010a351:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010a354:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a357:	01 d0                	add    %edx,%eax
8010a359:	85 c0                	test   %eax,%eax
8010a35b:	79 0a                	jns    8010a367 <sys_paintWindow+0x253>
            {
                j = -wx - 1;
8010a35d:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a360:	f7 d0                	not    %eax
8010a362:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010a365:	eb 77                	jmp    8010a3de <sys_paintWindow+0x2ca>
                continue;
            }
            else if (wx + j >= screenWidth)
8010a367:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010a36a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a36d:	01 c2                	add    %eax,%edx
8010a36f:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010a376:	0f b7 c0             	movzwl %ax,%eax
8010a379:	39 c2                	cmp    %eax,%edx
8010a37b:	7d 73                	jge    8010a3f0 <sys_paintWindow+0x2dc>
                break;
            
            AColor c = data[off_x + j];
8010a37d:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010a380:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a383:	01 d0                	add    %edx,%eax
8010a385:	89 c2                	mov    %eax,%edx
8010a387:	89 d0                	mov    %edx,%eax
8010a389:	01 c0                	add    %eax,%eax
8010a38b:	01 c2                	add    %eax,%edx
8010a38d:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a390:	01 d0                	add    %edx,%eax
8010a392:	0f b7 10             	movzwl (%eax),%edx
8010a395:	66 89 55 b5          	mov    %dx,-0x4b(%ebp)
8010a399:	0f b6 40 02          	movzbl 0x2(%eax),%eax
8010a39d:	88 45 b7             	mov    %al,-0x49(%ebp)
            if (c.r != COLOR_TRANSPARENT || c.g != COLOR_TRANSPARENT || c.b != COLOR_TRANSPARENT )
8010a3a0:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010a3a4:	3c 0c                	cmp    $0xc,%al
8010a3a6:	75 10                	jne    8010a3b8 <sys_paintWindow+0x2a4>
8010a3a8:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
8010a3ac:	3c 0c                	cmp    $0xc,%al
8010a3ae:	75 08                	jne    8010a3b8 <sys_paintWindow+0x2a4>
8010a3b0:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010a3b4:	3c 0c                	cmp    $0xc,%al
8010a3b6:	74 26                	je     8010a3de <sys_paintWindow+0x2ca>
                screenContent[screen_off_x + j] = c;
8010a3b8:	8b 15 b0 e6 10 80    	mov    0x8010e6b0,%edx
8010a3be:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010a3c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a3c4:	01 c8                	add    %ecx,%eax
8010a3c6:	89 c1                	mov    %eax,%ecx
8010a3c8:	89 c8                	mov    %ecx,%eax
8010a3ca:	01 c0                	add    %eax,%eax
8010a3cc:	01 c8                	add    %ecx,%eax
8010a3ce:	01 d0                	add    %edx,%eax
8010a3d0:	0f b7 55 b5          	movzwl -0x4b(%ebp),%edx
8010a3d4:	66 89 10             	mov    %dx,(%eax)
8010a3d7:	0f b6 55 b7          	movzbl -0x49(%ebp),%edx
8010a3db:	88 50 02             	mov    %dl,0x2(%eax)
        }
        else if (wy + i >= screenHeight)
            break;
        int off_x = (sy + i) * hdc->size.cx + sx;
        int screen_off_x = (wy + i) * screenWidth + wx;
        for (j = 0; j < w; ++j)
8010a3de:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010a3e2:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a3e5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010a3e8:	0f 8c 63 ff ff ff    	jl     8010a351 <sys_paintWindow+0x23d>
8010a3ee:	eb 01                	jmp    8010a3f1 <sys_paintWindow+0x2dd>
            {
                j = -wx - 1;
                continue;
            }
            else if (wx + j >= screenWidth)
                break;
8010a3f0:	90                   	nop
    //int id = hwnd ->id;
    //cprintf("in paintWindow function:-----2  \n");
    AColor *data = hdc->content;
    
    int j;
    for (int i = 0; i < h;i++)
8010a3f1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010a3f5:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a3f8:	39 45 f0             	cmp    %eax,-0x10(%ebp)
8010a3fb:	0f 8c dc fe ff ff    	jl     8010a2dd <sys_paintWindow+0x1c9>
8010a401:	eb 01                	jmp    8010a404 <sys_paintWindow+0x2f0>
        {
            i = -wy - 1;
            continue;
        }
        else if (wy + i >= screenHeight)
            break;
8010a403:	90                   	nop
            AColor c = data[off_x + j];
            if (c.r != COLOR_TRANSPARENT || c.g != COLOR_TRANSPARENT || c.b != COLOR_TRANSPARENT )
                screenContent[screen_off_x + j] = c;
        }
    }
    w += wx - 1;
8010a404:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a407:	8d 50 ff             	lea    -0x1(%eax),%edx
8010a40a:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a40d:	01 d0                	add    %edx,%eax
8010a40f:	89 45 c8             	mov    %eax,-0x38(%ebp)
    h += wy - 1;
8010a412:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a415:	8d 50 ff             	lea    -0x1(%eax),%edx
8010a418:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a41b:	01 d0                	add    %edx,%eax
8010a41d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    if (wx < 0)
8010a420:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a423:	85 c0                	test   %eax,%eax
8010a425:	79 07                	jns    8010a42e <sys_paintWindow+0x31a>
        wx = 0;
8010a427:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    if (wy < 0)
8010a42e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a431:	85 c0                	test   %eax,%eax
8010a433:	79 07                	jns    8010a43c <sys_paintWindow+0x328>
        wy = 0;
8010a435:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    if (h >= screenHeight)
8010a43c:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
8010a443:	0f b7 d0             	movzwl %ax,%edx
8010a446:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a449:	39 c2                	cmp    %eax,%edx
8010a44b:	7f 10                	jg     8010a45d <sys_paintWindow+0x349>
        h = screenHeight - 1;
8010a44d:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
8010a454:	0f b7 c0             	movzwl %ax,%eax
8010a457:	83 e8 01             	sub    $0x1,%eax
8010a45a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    if (w >= screenWidth)
8010a45d:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010a464:	0f b7 d0             	movzwl %ax,%edx
8010a467:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a46a:	39 c2                	cmp    %eax,%edx
8010a46c:	7f 10                	jg     8010a47e <sys_paintWindow+0x36a>
        w = screenWidth - 1;
8010a46e:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010a475:	0f b7 c0             	movzwl %ax,%eax
8010a478:	83 e8 01             	sub    $0x1,%eax
8010a47b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    //release(&videoLock);
    APBufPaint(wx, wy, w, h,is_grid);
8010a47e:	8b 75 c0             	mov    -0x40(%ebp),%esi
8010a481:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
8010a484:	8b 4d c8             	mov    -0x38(%ebp),%ecx
8010a487:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a48a:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a48d:	83 ec 0c             	sub    $0xc,%esp
8010a490:	56                   	push   %esi
8010a491:	53                   	push   %ebx
8010a492:	51                   	push   %ecx
8010a493:	52                   	push   %edx
8010a494:	50                   	push   %eax
8010a495:	e8 b9 f9 ff ff       	call   80109e53 <APBufPaint>
8010a49a:	83 c4 20             	add    $0x20,%esp
    return 0;
8010a49d:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a4a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010a4a5:	5b                   	pop    %ebx
8010a4a6:	5e                   	pop    %esi
8010a4a7:	5d                   	pop    %ebp
8010a4a8:	c3                   	ret    

8010a4a9 <sys_changePosition>:

int sys_changePosition(void)
{
8010a4a9:	55                   	push   %ebp
8010a4aa:	89 e5                	mov    %esp,%ebp
8010a4ac:	83 ec 18             	sub    $0x18,%esp
    int x,y,d;
    if (argint(0, &x) < 0 || argint(1, &y) < 0 || argint(2, &d) < 0)
8010a4af:	83 ec 08             	sub    $0x8,%esp
8010a4b2:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010a4b5:	50                   	push   %eax
8010a4b6:	6a 00                	push   $0x0
8010a4b8:	e8 08 af ff ff       	call   801053c5 <argint>
8010a4bd:	83 c4 10             	add    $0x10,%esp
8010a4c0:	85 c0                	test   %eax,%eax
8010a4c2:	78 2a                	js     8010a4ee <sys_changePosition+0x45>
8010a4c4:	83 ec 08             	sub    $0x8,%esp
8010a4c7:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010a4ca:	50                   	push   %eax
8010a4cb:	6a 01                	push   $0x1
8010a4cd:	e8 f3 ae ff ff       	call   801053c5 <argint>
8010a4d2:	83 c4 10             	add    $0x10,%esp
8010a4d5:	85 c0                	test   %eax,%eax
8010a4d7:	78 15                	js     8010a4ee <sys_changePosition+0x45>
8010a4d9:	83 ec 08             	sub    $0x8,%esp
8010a4dc:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010a4df:	50                   	push   %eax
8010a4e0:	6a 02                	push   $0x2
8010a4e2:	e8 de ae ff ff       	call   801053c5 <argint>
8010a4e7:	83 c4 10             	add    $0x10,%esp
8010a4ea:	85 c0                	test   %eax,%eax
8010a4ec:	79 07                	jns    8010a4f5 <sys_changePosition+0x4c>
        return -1;
8010a4ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a4f3:	eb 46                	jmp    8010a53b <sys_changePosition+0x92>
    
    //cprintf("in changePosition\n");
    character_pre_y = character_y;
8010a4f5:	a1 04 e5 10 80       	mov    0x8010e504,%eax
8010a4fa:	a3 a0 e6 10 80       	mov    %eax,0x8010e6a0
    character_pre_x = character_x;
8010a4ff:	a1 00 e5 10 80       	mov    0x8010e500,%eax
8010a504:	a3 9c e6 10 80       	mov    %eax,0x8010e69c
    character_x = x;
8010a509:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a50c:	a3 00 e5 10 80       	mov    %eax,0x8010e500
    character_y = y;
8010a511:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a514:	a3 04 e5 10 80       	mov    %eax,0x8010e504
    if (d != 2)
8010a519:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a51c:	83 f8 02             	cmp    $0x2,%eax
8010a51f:	74 08                	je     8010a529 <sys_changePosition+0x80>
        direction = d;
8010a521:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a524:	a3 08 e5 10 80       	mov    %eax,0x8010e508
    APDrawCharacter(True);
8010a529:	83 ec 0c             	sub    $0xc,%esp
8010a52c:	6a 01                	push   $0x1
8010a52e:	e8 4e de ff ff       	call   80108381 <APDrawCharacter>
8010a533:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a536:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a53b:	c9                   	leave  
8010a53c:	c3                   	ret    

8010a53d <sys_sendMessage>:

int sys_sendMessage(void)
{
8010a53d:	55                   	push   %ebp
8010a53e:	89 e5                	mov    %esp,%ebp
8010a540:	83 ec 18             	sub    $0x18,%esp
    int wndId = 0;
8010a543:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    AMessage * msg = 0;
8010a54a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    if (argint(0, &wndId) < 0 || argstr(1, (char**)&msg) < 0)
8010a551:	83 ec 08             	sub    $0x8,%esp
8010a554:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010a557:	50                   	push   %eax
8010a558:	6a 00                	push   $0x0
8010a55a:	e8 66 ae ff ff       	call   801053c5 <argint>
8010a55f:	83 c4 10             	add    $0x10,%esp
8010a562:	85 c0                	test   %eax,%eax
8010a564:	78 15                	js     8010a57b <sys_sendMessage+0x3e>
8010a566:	83 ec 08             	sub    $0x8,%esp
8010a569:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010a56c:	50                   	push   %eax
8010a56d:	6a 01                	push   $0x1
8010a56f:	e8 d6 ae ff ff       	call   8010544a <argstr>
8010a574:	83 c4 10             	add    $0x10,%esp
8010a577:	85 c0                	test   %eax,%eax
8010a579:	79 07                	jns    8010a582 <sys_sendMessage+0x45>
        return -1;
8010a57b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a580:	eb 18                	jmp    8010a59a <sys_sendMessage+0x5d>
    
    //cprintf("in sys_sendMessage\n");
    
    sendMessage(wndId, msg);
8010a582:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010a585:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a588:	83 ec 08             	sub    $0x8,%esp
8010a58b:	52                   	push   %edx
8010a58c:	50                   	push   %eax
8010a58d:	e8 29 01 00 00       	call   8010a6bb <sendMessage>
8010a592:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a595:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a59a:	c9                   	leave  
8010a59b:	c3                   	ret    

8010a59c <sys_registWindow>:

int sys_registWindow(void)
{
8010a59c:	55                   	push   %ebp
8010a59d:	89 e5                	mov    %esp,%ebp
8010a59f:	83 ec 18             	sub    $0x18,%esp
    AHwnd hwnd = 0;
8010a5a2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (argstr(0, (char **)&hwnd) < 0)
8010a5a9:	83 ec 08             	sub    $0x8,%esp
8010a5ac:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010a5af:	50                   	push   %eax
8010a5b0:	6a 00                	push   $0x0
8010a5b2:	e8 93 ae ff ff       	call   8010544a <argstr>
8010a5b7:	83 c4 10             	add    $0x10,%esp
8010a5ba:	85 c0                	test   %eax,%eax
8010a5bc:	79 07                	jns    8010a5c5 <sys_registWindow+0x29>
        return -1;
8010a5be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a5c3:	eb 19                	jmp    8010a5de <sys_registWindow+0x42>
    APWndListAddToHead(&wndList, hwnd);
8010a5c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a5c8:	83 ec 08             	sub    $0x8,%esp
8010a5cb:	50                   	push   %eax
8010a5cc:	68 a0 57 11 80       	push   $0x801157a0
8010a5d1:	e8 9c 02 00 00       	call   8010a872 <APWndListAddToHead>
8010a5d6:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a5d9:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a5de:	c9                   	leave  
8010a5df:	c3                   	ret    

8010a5e0 <sys_getMessage>:

int sys_getMessage(void)
{
8010a5e0:	55                   	push   %ebp
8010a5e1:	89 e5                	mov    %esp,%ebp
8010a5e3:	53                   	push   %ebx
8010a5e4:	83 ec 24             	sub    $0x24,%esp

    AHwnd hwnd = 0;
8010a5e7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (argstr(0, (char **)&hwnd) < 0)
8010a5ee:	83 ec 08             	sub    $0x8,%esp
8010a5f1:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010a5f4:	50                   	push   %eax
8010a5f5:	6a 00                	push   $0x0
8010a5f7:	e8 4e ae ff ff       	call   8010544a <argstr>
8010a5fc:	83 c4 10             	add    $0x10,%esp
8010a5ff:	85 c0                	test   %eax,%eax
8010a601:	79 0a                	jns    8010a60d <sys_getMessage+0x2d>
        return -1;
8010a603:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a608:	e9 a9 00 00 00       	jmp    8010a6b6 <sys_getMessage+0xd6>
    int wndId = hwnd->id;
8010a60d:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a610:	8b 00                	mov    (%eax),%eax
8010a612:	89 45 f4             	mov    %eax,-0xc(%ebp)
    //int pid = hwnd->pid;
    
    //cprintf("in function --- getMessage:WndId: %d\n",wndId);
    
    acquire(&wndList.data[wndId].lock);
8010a615:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a618:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a61e:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a623:	83 c0 08             	add    $0x8,%eax
8010a626:	83 ec 0c             	sub    $0xc,%esp
8010a629:	50                   	push   %eax
8010a62a:	e8 0e a8 ff ff       	call   80104e3d <acquire>
8010a62f:	83 c4 10             	add    $0x10,%esp
    AMsgQueue * queue = &wndList.data[wndId].msgQueue;
8010a632:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a635:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a63b:	83 c0 30             	add    $0x30,%eax
8010a63e:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a643:	83 c0 0c             	add    $0xc,%eax
8010a646:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (queue->head == queue->tail)
    {
        //cprintf("WND: %d is sleeping\n",wndId);
        //sleep((void *)pid,&wndList.data[wndId].lock);
    }
    if (wndList.data[wndId].hwnd->msg.type == MSG_NULL)
8010a649:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a64c:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a652:	05 e4 5a 11 80       	add    $0x80115ae4,%eax
8010a657:	8b 00                	mov    (%eax),%eax
8010a659:	8b 40 74             	mov    0x74(%eax),%eax
8010a65c:	85 c0                	test   %eax,%eax
8010a65e:	75 34                	jne    8010a694 <sys_getMessage+0xb4>
    {
      //  cprintf("poping msg!\n");
        wndList.data[wndId].hwnd->msg = APMsgQueueDeQueue(queue);
8010a660:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a663:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a669:	05 e4 5a 11 80       	add    $0x80115ae4,%eax
8010a66e:	8b 18                	mov    (%eax),%ebx
8010a670:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010a673:	83 ec 08             	sub    $0x8,%esp
8010a676:	ff 75 f0             	pushl  -0x10(%ebp)
8010a679:	50                   	push   %eax
8010a67a:	e8 8d 06 00 00       	call   8010ad0c <APMsgQueueDeQueue>
8010a67f:	83 c4 0c             	add    $0xc,%esp
8010a682:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a685:	89 43 74             	mov    %eax,0x74(%ebx)
8010a688:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a68b:	89 43 78             	mov    %eax,0x78(%ebx)
8010a68e:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010a691:	89 43 7c             	mov    %eax,0x7c(%ebx)
    }
    
    release(&wndList.data[wndId].lock);
8010a694:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a697:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a69d:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a6a2:	83 c0 08             	add    $0x8,%eax
8010a6a5:	83 ec 0c             	sub    $0xc,%esp
8010a6a8:	50                   	push   %eax
8010a6a9:	e8 f6 a7 ff ff       	call   80104ea4 <release>
8010a6ae:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a6b1:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a6b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010a6b9:	c9                   	leave  
8010a6ba:	c3                   	ret    

8010a6bb <sendMessage>:


void sendMessage(int wndId, AMessage *msg)
{
8010a6bb:	55                   	push   %ebp
8010a6bc:	89 e5                	mov    %esp,%ebp
8010a6be:	83 ec 18             	sub    $0x18,%esp
    //cprintf("sendMessage,Messgaetype:%d\n",msg->type);
    if (wndId == -1 || wndList.data[wndId].hwnd == 0)
8010a6c1:	83 7d 08 ff          	cmpl   $0xffffffff,0x8(%ebp)
8010a6c5:	0f 84 86 00 00 00    	je     8010a751 <sendMessage+0x96>
8010a6cb:	8b 45 08             	mov    0x8(%ebp),%eax
8010a6ce:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a6d4:	05 e4 5a 11 80       	add    $0x80115ae4,%eax
8010a6d9:	8b 00                	mov    (%eax),%eax
8010a6db:	85 c0                	test   %eax,%eax
8010a6dd:	74 72                	je     8010a751 <sendMessage+0x96>
        return;
    //cprintf("in send Message\n");
    //cprintf("send message: WndID:%d \n",wndId);
    AMsgQueue * queue = &wndList.data[wndId].msgQueue;
8010a6df:	8b 45 08             	mov    0x8(%ebp),%eax
8010a6e2:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a6e8:	83 c0 30             	add    $0x30,%eax
8010a6eb:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a6f0:	83 c0 0c             	add    $0xc,%eax
8010a6f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    msg->wndID = wndId;
8010a6f6:	8b 55 08             	mov    0x8(%ebp),%edx
8010a6f9:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a6fc:	89 50 08             	mov    %edx,0x8(%eax)
    APMsgQueueEnQueue(queue, *msg);
8010a6ff:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a702:	ff 70 08             	pushl  0x8(%eax)
8010a705:	ff 70 04             	pushl  0x4(%eax)
8010a708:	ff 30                	pushl  (%eax)
8010a70a:	ff 75 f4             	pushl  -0xc(%ebp)
8010a70d:	e8 7f 05 00 00       	call   8010ac91 <APMsgQueueEnQueue>
8010a712:	83 c4 10             	add    $0x10,%esp
    //cprintf("message has entered the queue\n",wndId);
    acquire(&wndList.data[wndId].lock);
8010a715:	8b 45 08             	mov    0x8(%ebp),%eax
8010a718:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a71e:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a723:	83 c0 08             	add    $0x8,%eax
8010a726:	83 ec 0c             	sub    $0xc,%esp
8010a729:	50                   	push   %eax
8010a72a:	e8 0e a7 ff ff       	call   80104e3d <acquire>
8010a72f:	83 c4 10             	add    $0x10,%esp
    //cprintf("lock has acquired!\n");
    //wakeup((void *)wndList.data[wndId].hwnd->pid);
    release(&wndList.data[wndId].lock);
8010a732:	8b 45 08             	mov    0x8(%ebp),%eax
8010a735:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a73b:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a740:	83 c0 08             	add    $0x8,%eax
8010a743:	83 ec 0c             	sub    $0xc,%esp
8010a746:	50                   	push   %eax
8010a747:	e8 58 a7 ff ff       	call   80104ea4 <release>
8010a74c:	83 c4 10             	add    $0x10,%esp
8010a74f:	eb 01                	jmp    8010a752 <sendMessage+0x97>

void sendMessage(int wndId, AMessage *msg)
{
    //cprintf("sendMessage,Messgaetype:%d\n",msg->type);
    if (wndId == -1 || wndList.data[wndId].hwnd == 0)
        return;
8010a751:	90                   	nop
    acquire(&wndList.data[wndId].lock);
    //cprintf("lock has acquired!\n");
    //wakeup((void *)wndList.data[wndId].hwnd->pid);
    release(&wndList.data[wndId].lock);
    //cprintf("Wnd %d has waken up!\n",wndId);
}
8010a752:	c9                   	leave  
8010a753:	c3                   	ret    

8010a754 <APWndListInit>:
//------------------------------------------------------------------------------------
//WndList

//space--insert_position
void APWndListInit(AWndList * list)
{
8010a754:	55                   	push   %ebp
8010a755:	89 e5                	mov    %esp,%ebp
8010a757:	83 ec 18             	sub    $0x18,%esp
    int i = 0;
8010a75a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    for (i = 0; i < MAX_WND_NUM; ++i)
8010a761:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010a768:	e9 8c 00 00 00       	jmp    8010a7f9 <APWndListInit+0xa5>
    {
        list->data[i].hwnd = 0;
8010a76d:	8b 55 08             	mov    0x8(%ebp),%edx
8010a770:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a773:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a779:	01 d0                	add    %edx,%eax
8010a77b:	05 44 03 00 00       	add    $0x344,%eax
8010a780:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
        list->data[i].prev = -1;
8010a786:	8b 55 08             	mov    0x8(%ebp),%edx
8010a789:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a78c:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a792:	01 d0                	add    %edx,%eax
8010a794:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
        list->data[i].next = i + 1;
8010a79a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a79d:	8d 50 01             	lea    0x1(%eax),%edx
8010a7a0:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010a7a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a7a6:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a7ac:	01 c8                	add    %ecx,%eax
8010a7ae:	83 c0 04             	add    $0x4,%eax
8010a7b1:	89 10                	mov    %edx,(%eax)
        APMsgQueueInit(&list->data[i].msgQueue);
8010a7b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a7b6:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a7bc:	8d 50 30             	lea    0x30(%eax),%edx
8010a7bf:	8b 45 08             	mov    0x8(%ebp),%eax
8010a7c2:	01 d0                	add    %edx,%eax
8010a7c4:	83 c0 0c             	add    $0xc,%eax
8010a7c7:	83 ec 0c             	sub    $0xc,%esp
8010a7ca:	50                   	push   %eax
8010a7cb:	e8 9c 04 00 00       	call   8010ac6c <APMsgQueueInit>
8010a7d0:	83 c4 10             	add    $0x10,%esp
        initlock(&list->data[i].lock, "msglock");
8010a7d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a7d6:	69 d0 48 03 00 00    	imul   $0x348,%eax,%edx
8010a7dc:	8b 45 08             	mov    0x8(%ebp),%eax
8010a7df:	01 d0                	add    %edx,%eax
8010a7e1:	83 c0 08             	add    $0x8,%eax
8010a7e4:	83 ec 08             	sub    $0x8,%esp
8010a7e7:	68 fa ba 10 80       	push   $0x8010bafa
8010a7ec:	50                   	push   %eax
8010a7ed:	e8 29 a6 ff ff       	call   80104e1b <initlock>
8010a7f2:	83 c4 10             	add    $0x10,%esp

//space--insert_position
void APWndListInit(AWndList * list)
{
    int i = 0;
    for (i = 0; i < MAX_WND_NUM; ++i)
8010a7f5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010a7f9:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010a7fd:	0f 8e 6a ff ff ff    	jle    8010a76d <APWndListInit+0x19>
        list->data[i].prev = -1;
        list->data[i].next = i + 1;
        APMsgQueueInit(&list->data[i].msgQueue);
        initlock(&list->data[i].lock, "msglock");
    }
    list->data[i - 1].next = -1;
8010a803:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a806:	83 e8 01             	sub    $0x1,%eax
8010a809:	8b 55 08             	mov    0x8(%ebp),%edx
8010a80c:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a812:	01 d0                	add    %edx,%eax
8010a814:	83 c0 04             	add    $0x4,%eax
8010a817:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    initlock(&list->lock, "wndListLock");
8010a81d:	8b 45 08             	mov    0x8(%ebp),%eax
8010a820:	05 e0 20 00 00       	add    $0x20e0,%eax
8010a825:	83 ec 08             	sub    $0x8,%esp
8010a828:	68 02 bb 10 80       	push   $0x8010bb02
8010a82d:	50                   	push   %eax
8010a82e:	e8 e8 a5 ff ff       	call   80104e1b <initlock>
8010a833:	83 c4 10             	add    $0x10,%esp
    list->head = list->tail  = -1;
8010a836:	8b 45 08             	mov    0x8(%ebp),%eax
8010a839:	c7 80 d4 20 00 00 ff 	movl   $0xffffffff,0x20d4(%eax)
8010a840:	ff ff ff 
8010a843:	8b 45 08             	mov    0x8(%ebp),%eax
8010a846:	8b 90 d4 20 00 00    	mov    0x20d4(%eax),%edx
8010a84c:	8b 45 08             	mov    0x8(%ebp),%eax
8010a84f:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
    list->desktop = 0;
8010a855:	8b 45 08             	mov    0x8(%ebp),%eax
8010a858:	c7 80 dc 20 00 00 00 	movl   $0x0,0x20dc(%eax)
8010a85f:	00 00 00 
    list->space = 0;
8010a862:	8b 45 08             	mov    0x8(%ebp),%eax
8010a865:	c7 80 d8 20 00 00 00 	movl   $0x0,0x20d8(%eax)
8010a86c:	00 00 00 
}
8010a86f:	90                   	nop
8010a870:	c9                   	leave  
8010a871:	c3                   	ret    

8010a872 <APWndListAddToHead>:

void APWndListAddToHead(AWndList * list, AHwnd hwnd)
{
8010a872:	55                   	push   %ebp
8010a873:	89 e5                	mov    %esp,%ebp
8010a875:	83 ec 18             	sub    $0x18,%esp
    acquire(&list->lock);
8010a878:	8b 45 08             	mov    0x8(%ebp),%eax
8010a87b:	05 e0 20 00 00       	add    $0x20e0,%eax
8010a880:	83 ec 0c             	sub    $0xc,%esp
8010a883:	50                   	push   %eax
8010a884:	e8 b4 a5 ff ff       	call   80104e3d <acquire>
8010a889:	83 c4 10             	add    $0x10,%esp
    int p = list->space;
8010a88c:	8b 45 08             	mov    0x8(%ebp),%eax
8010a88f:	8b 80 d8 20 00 00    	mov    0x20d8(%eax),%eax
8010a895:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == -1)
8010a898:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010a89c:	75 15                	jne    8010a8b3 <APWndListAddToHead+0x41>
    {
        cprintf("too much window\n");
8010a89e:	83 ec 0c             	sub    $0xc,%esp
8010a8a1:	68 0e bb 10 80       	push   $0x8010bb0e
8010a8a6:	e8 1b 5b ff ff       	call   801003c6 <cprintf>
8010a8ab:	83 c4 10             	add    $0x10,%esp
        return;
8010a8ae:	e9 c8 00 00 00       	jmp    8010a97b <APWndListAddToHead+0x109>
    }
    list->space = list->data[list->space].next;
8010a8b3:	8b 45 08             	mov    0x8(%ebp),%eax
8010a8b6:	8b 80 d8 20 00 00    	mov    0x20d8(%eax),%eax
8010a8bc:	8b 55 08             	mov    0x8(%ebp),%edx
8010a8bf:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a8c5:	01 d0                	add    %edx,%eax
8010a8c7:	83 c0 04             	add    $0x4,%eax
8010a8ca:	8b 10                	mov    (%eax),%edx
8010a8cc:	8b 45 08             	mov    0x8(%ebp),%eax
8010a8cf:	89 90 d8 20 00 00    	mov    %edx,0x20d8(%eax)
    list->data[p].hwnd = hwnd;
8010a8d5:	8b 55 08             	mov    0x8(%ebp),%edx
8010a8d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a8db:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a8e1:	01 d0                	add    %edx,%eax
8010a8e3:	8d 90 44 03 00 00    	lea    0x344(%eax),%edx
8010a8e9:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a8ec:	89 02                	mov    %eax,(%edx)
    
    hwnd->id = p;
8010a8ee:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a8f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a8f4:	89 10                	mov    %edx,(%eax)
    
    //desktop ---- id = 0
    list->data[p].next = list->head;
8010a8f6:	8b 45 08             	mov    0x8(%ebp),%eax
8010a8f9:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010a8ff:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010a902:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a905:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010a90b:	01 ca                	add    %ecx,%edx
8010a90d:	83 c2 04             	add    $0x4,%edx
8010a910:	89 02                	mov    %eax,(%edx)
    list->data[p].prev = -1;
8010a912:	8b 55 08             	mov    0x8(%ebp),%edx
8010a915:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a918:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a91e:	01 d0                	add    %edx,%eax
8010a920:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    if (list->head == -1)
8010a926:	8b 45 08             	mov    0x8(%ebp),%eax
8010a929:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010a92f:	83 f8 ff             	cmp    $0xffffffff,%eax
8010a932:	75 0e                	jne    8010a942 <APWndListAddToHead+0xd0>
        list->tail = p;
8010a934:	8b 45 08             	mov    0x8(%ebp),%eax
8010a937:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a93a:	89 90 d4 20 00 00    	mov    %edx,0x20d4(%eax)
8010a940:	eb 19                	jmp    8010a95b <APWndListAddToHead+0xe9>
    else
        list->data[list->head].prev = p;
8010a942:	8b 45 08             	mov    0x8(%ebp),%eax
8010a945:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010a94b:	8b 55 08             	mov    0x8(%ebp),%edx
8010a94e:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a954:	01 c2                	add    %eax,%edx
8010a956:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a959:	89 02                	mov    %eax,(%edx)
    
    list->head = p;
8010a95b:	8b 45 08             	mov    0x8(%ebp),%eax
8010a95e:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a961:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
    //cprintf("the wndlist head is %d\n",p);
    release(&list->lock);
8010a967:	8b 45 08             	mov    0x8(%ebp),%eax
8010a96a:	05 e0 20 00 00       	add    $0x20e0,%eax
8010a96f:	83 ec 0c             	sub    $0xc,%esp
8010a972:	50                   	push   %eax
8010a973:	e8 2c a5 ff ff       	call   80104ea4 <release>
8010a978:	83 c4 10             	add    $0x10,%esp
}
8010a97b:	c9                   	leave  
8010a97c:	c3                   	ret    

8010a97d <APWndListMoveToHead>:

void APWndListMoveToHead(AWndList * list, int wndId)
{
8010a97d:	55                   	push   %ebp
8010a97e:	89 e5                	mov    %esp,%ebp
8010a980:	83 ec 08             	sub    $0x8,%esp
    if (wndId < 0)
8010a983:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010a987:	0f 88 27 01 00 00    	js     8010aab4 <APWndListMoveToHead+0x137>
        return;
    acquire(&list->lock);
8010a98d:	8b 45 08             	mov    0x8(%ebp),%eax
8010a990:	05 e0 20 00 00       	add    $0x20e0,%eax
8010a995:	83 ec 0c             	sub    $0xc,%esp
8010a998:	50                   	push   %eax
8010a999:	e8 9f a4 ff ff       	call   80104e3d <acquire>
8010a99e:	83 c4 10             	add    $0x10,%esp
    if (wndId != list->head)
8010a9a1:	8b 45 08             	mov    0x8(%ebp),%eax
8010a9a4:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010a9aa:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010a9ad:	0f 84 eb 00 00 00    	je     8010aa9e <APWndListMoveToHead+0x121>
    {
        list->data[list->data[wndId].prev].next = list->data[wndId].next;
8010a9b3:	8b 55 08             	mov    0x8(%ebp),%edx
8010a9b6:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a9b9:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a9bf:	01 d0                	add    %edx,%eax
8010a9c1:	8b 10                	mov    (%eax),%edx
8010a9c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010a9c6:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a9c9:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a9cf:	01 c8                	add    %ecx,%eax
8010a9d1:	83 c0 04             	add    $0x4,%eax
8010a9d4:	8b 00                	mov    (%eax),%eax
8010a9d6:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010a9d9:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010a9df:	01 ca                	add    %ecx,%edx
8010a9e1:	83 c2 04             	add    $0x4,%edx
8010a9e4:	89 02                	mov    %eax,(%edx)
        if (list->data[wndId].next == -1)
8010a9e6:	8b 55 08             	mov    0x8(%ebp),%edx
8010a9e9:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a9ec:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a9f2:	01 d0                	add    %edx,%eax
8010a9f4:	83 c0 04             	add    $0x4,%eax
8010a9f7:	8b 00                	mov    (%eax),%eax
8010a9f9:	83 f8 ff             	cmp    $0xffffffff,%eax
8010a9fc:	75 1b                	jne    8010aa19 <APWndListMoveToHead+0x9c>
            list->tail = list->data[wndId].prev;
8010a9fe:	8b 55 08             	mov    0x8(%ebp),%edx
8010aa01:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa04:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa0a:	01 d0                	add    %edx,%eax
8010aa0c:	8b 10                	mov    (%eax),%edx
8010aa0e:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa11:	89 90 d4 20 00 00    	mov    %edx,0x20d4(%eax)
8010aa17:	eb 30                	jmp    8010aa49 <APWndListMoveToHead+0xcc>
        else
            list->data[list->data[wndId].next].prev = list->data[wndId].prev;
8010aa19:	8b 55 08             	mov    0x8(%ebp),%edx
8010aa1c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa1f:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa25:	01 d0                	add    %edx,%eax
8010aa27:	83 c0 04             	add    $0x4,%eax
8010aa2a:	8b 10                	mov    (%eax),%edx
8010aa2c:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aa2f:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa32:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa38:	01 c8                	add    %ecx,%eax
8010aa3a:	8b 00                	mov    (%eax),%eax
8010aa3c:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aa3f:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010aa45:	01 ca                	add    %ecx,%edx
8010aa47:	89 02                	mov    %eax,(%edx)

        list->data[list->head].prev = wndId;
8010aa49:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa4c:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010aa52:	8b 55 08             	mov    0x8(%ebp),%edx
8010aa55:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa5b:	01 c2                	add    %eax,%edx
8010aa5d:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa60:	89 02                	mov    %eax,(%edx)
        list->data[wndId].prev = -1;
8010aa62:	8b 55 08             	mov    0x8(%ebp),%edx
8010aa65:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa68:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa6e:	01 d0                	add    %edx,%eax
8010aa70:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
        list->data[wndId].next = list->head;
8010aa76:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa79:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010aa7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aa82:	8b 55 0c             	mov    0xc(%ebp),%edx
8010aa85:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010aa8b:	01 ca                	add    %ecx,%edx
8010aa8d:	83 c2 04             	add    $0x4,%edx
8010aa90:	89 02                	mov    %eax,(%edx)
        list->head = wndId;
8010aa92:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa95:	8b 55 0c             	mov    0xc(%ebp),%edx
8010aa98:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
    }
    release(&list->lock);
8010aa9e:	8b 45 08             	mov    0x8(%ebp),%eax
8010aaa1:	05 e0 20 00 00       	add    $0x20e0,%eax
8010aaa6:	83 ec 0c             	sub    $0xc,%esp
8010aaa9:	50                   	push   %eax
8010aaaa:	e8 f5 a3 ff ff       	call   80104ea4 <release>
8010aaaf:	83 c4 10             	add    $0x10,%esp
8010aab2:	eb 01                	jmp    8010aab5 <APWndListMoveToHead+0x138>
}

void APWndListMoveToHead(AWndList * list, int wndId)
{
    if (wndId < 0)
        return;
8010aab4:	90                   	nop
        list->data[wndId].prev = -1;
        list->data[wndId].next = list->head;
        list->head = wndId;
    }
    release(&list->lock);
}
8010aab5:	c9                   	leave  
8010aab6:	c3                   	ret    

8010aab7 <APWndListRemove>:

void APWndListRemove(AWndList * list, int wndId)
{
8010aab7:	55                   	push   %ebp
8010aab8:	89 e5                	mov    %esp,%ebp
8010aaba:	83 ec 08             	sub    $0x8,%esp
    if (wndId < 0)
8010aabd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010aac1:	0f 88 71 01 00 00    	js     8010ac38 <APWndListRemove+0x181>
        return;
    acquire(&list->lock);
8010aac7:	8b 45 08             	mov    0x8(%ebp),%eax
8010aaca:	05 e0 20 00 00       	add    $0x20e0,%eax
8010aacf:	83 ec 0c             	sub    $0xc,%esp
8010aad2:	50                   	push   %eax
8010aad3:	e8 65 a3 ff ff       	call   80104e3d <acquire>
8010aad8:	83 c4 10             	add    $0x10,%esp
    if (wndId == list->head)
8010aadb:	8b 45 08             	mov    0x8(%ebp),%eax
8010aade:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010aae4:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010aae7:	75 7a                	jne    8010ab63 <APWndListRemove+0xac>
    {
        if (list->data[wndId].next == -1)
8010aae9:	8b 55 08             	mov    0x8(%ebp),%edx
8010aaec:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aaef:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aaf5:	01 d0                	add    %edx,%eax
8010aaf7:	83 c0 04             	add    $0x4,%eax
8010aafa:	8b 00                	mov    (%eax),%eax
8010aafc:	83 f8 ff             	cmp    $0xffffffff,%eax
8010aaff:	75 24                	jne    8010ab25 <APWndListRemove+0x6e>
            list->head = list->tail = -1;
8010ab01:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab04:	c7 80 d4 20 00 00 ff 	movl   $0xffffffff,0x20d4(%eax)
8010ab0b:	ff ff ff 
8010ab0e:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab11:	8b 90 d4 20 00 00    	mov    0x20d4(%eax),%edx
8010ab17:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab1a:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
8010ab20:	e9 88 00 00 00       	jmp    8010abad <APWndListRemove+0xf6>
        else
        {
            list->head = list->data[list->head].next;
8010ab25:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab28:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010ab2e:	8b 55 08             	mov    0x8(%ebp),%edx
8010ab31:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ab37:	01 d0                	add    %edx,%eax
8010ab39:	83 c0 04             	add    $0x4,%eax
8010ab3c:	8b 10                	mov    (%eax),%edx
8010ab3e:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab41:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
            list->data[list->head].prev = -1;
8010ab47:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab4a:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010ab50:	8b 55 08             	mov    0x8(%ebp),%edx
8010ab53:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ab59:	01 d0                	add    %edx,%eax
8010ab5b:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
8010ab61:	eb 4a                	jmp    8010abad <APWndListRemove+0xf6>
        }
    }
    else if (wndId == list->tail)
8010ab63:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab66:	8b 80 d4 20 00 00    	mov    0x20d4(%eax),%eax
8010ab6c:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010ab6f:	75 3c                	jne    8010abad <APWndListRemove+0xf6>
    {
        list->tail = list->data[list->tail].prev;
8010ab71:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab74:	8b 80 d4 20 00 00    	mov    0x20d4(%eax),%eax
8010ab7a:	8b 55 08             	mov    0x8(%ebp),%edx
8010ab7d:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ab83:	01 d0                	add    %edx,%eax
8010ab85:	8b 10                	mov    (%eax),%edx
8010ab87:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab8a:	89 90 d4 20 00 00    	mov    %edx,0x20d4(%eax)
        list->data[list->tail].next = -1;
8010ab90:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab93:	8b 80 d4 20 00 00    	mov    0x20d4(%eax),%eax
8010ab99:	8b 55 08             	mov    0x8(%ebp),%edx
8010ab9c:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aba2:	01 d0                	add    %edx,%eax
8010aba4:	83 c0 04             	add    $0x4,%eax
8010aba7:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    }
    list->data[wndId].prev = -1;
8010abad:	8b 55 08             	mov    0x8(%ebp),%edx
8010abb0:	8b 45 0c             	mov    0xc(%ebp),%eax
8010abb3:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010abb9:	01 d0                	add    %edx,%eax
8010abbb:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    list->data[wndId].next = list->space;
8010abc1:	8b 45 08             	mov    0x8(%ebp),%eax
8010abc4:	8b 80 d8 20 00 00    	mov    0x20d8(%eax),%eax
8010abca:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010abcd:	8b 55 0c             	mov    0xc(%ebp),%edx
8010abd0:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010abd6:	01 ca                	add    %ecx,%edx
8010abd8:	83 c2 04             	add    $0x4,%edx
8010abdb:	89 02                	mov    %eax,(%edx)
    list->data[wndId].hwnd = 0;
8010abdd:	8b 55 08             	mov    0x8(%ebp),%edx
8010abe0:	8b 45 0c             	mov    0xc(%ebp),%eax
8010abe3:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010abe9:	01 d0                	add    %edx,%eax
8010abeb:	05 44 03 00 00       	add    $0x344,%eax
8010abf0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    list->space = wndId;
8010abf6:	8b 45 08             	mov    0x8(%ebp),%eax
8010abf9:	8b 55 0c             	mov    0xc(%ebp),%edx
8010abfc:	89 90 d8 20 00 00    	mov    %edx,0x20d8(%eax)

    APMsgQueueInit(&list->data[wndId].msgQueue);
8010ac02:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ac05:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ac0b:	8d 50 30             	lea    0x30(%eax),%edx
8010ac0e:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac11:	01 d0                	add    %edx,%eax
8010ac13:	83 c0 0c             	add    $0xc,%eax
8010ac16:	83 ec 0c             	sub    $0xc,%esp
8010ac19:	50                   	push   %eax
8010ac1a:	e8 4d 00 00 00       	call   8010ac6c <APMsgQueueInit>
8010ac1f:	83 c4 10             	add    $0x10,%esp
    
    release(&list->lock);
8010ac22:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac25:	05 e0 20 00 00       	add    $0x20e0,%eax
8010ac2a:	83 ec 0c             	sub    $0xc,%esp
8010ac2d:	50                   	push   %eax
8010ac2e:	e8 71 a2 ff ff       	call   80104ea4 <release>
8010ac33:	83 c4 10             	add    $0x10,%esp
8010ac36:	eb 01                	jmp    8010ac39 <APWndListRemove+0x182>
}

void APWndListRemove(AWndList * list, int wndId)
{
    if (wndId < 0)
        return;
8010ac38:	90                   	nop
    list->space = wndId;

    APMsgQueueInit(&list->data[wndId].msgQueue);
    
    release(&list->lock);
}
8010ac39:	c9                   	leave  
8010ac3a:	c3                   	ret    

8010ac3b <APWndListDestroy>:

void APWndListDestroy(AWndList * list)
{
8010ac3b:	55                   	push   %ebp
8010ac3c:	89 e5                	mov    %esp,%ebp
8010ac3e:	83 ec 08             	sub    $0x8,%esp
    acquire(&list->lock);
8010ac41:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac44:	05 e0 20 00 00       	add    $0x20e0,%eax
8010ac49:	83 ec 0c             	sub    $0xc,%esp
8010ac4c:	50                   	push   %eax
8010ac4d:	e8 eb a1 ff ff       	call   80104e3d <acquire>
8010ac52:	83 c4 10             	add    $0x10,%esp
    release(&list->lock);
8010ac55:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac58:	05 e0 20 00 00       	add    $0x20e0,%eax
8010ac5d:	83 ec 0c             	sub    $0xc,%esp
8010ac60:	50                   	push   %eax
8010ac61:	e8 3e a2 ff ff       	call   80104ea4 <release>
8010ac66:	83 c4 10             	add    $0x10,%esp
}
8010ac69:	90                   	nop
8010ac6a:	c9                   	leave  
8010ac6b:	c3                   	ret    

8010ac6c <APMsgQueueInit>:

//Msg Queue
//head = start, tail = end next

void APMsgQueueInit(AMsgQueue * queue)
{
8010ac6c:	55                   	push   %ebp
8010ac6d:	89 e5                	mov    %esp,%ebp
    // as an array
    queue->head = queue->tail = 0;
8010ac6f:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac72:	c7 80 04 03 00 00 00 	movl   $0x0,0x304(%eax)
8010ac79:	00 00 00 
8010ac7c:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac7f:	8b 90 04 03 00 00    	mov    0x304(%eax),%edx
8010ac85:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac88:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
}
8010ac8e:	90                   	nop
8010ac8f:	5d                   	pop    %ebp
8010ac90:	c3                   	ret    

8010ac91 <APMsgQueueEnQueue>:

void APMsgQueueEnQueue(AMsgQueue * queue, AMessage msg)
{
8010ac91:	55                   	push   %ebp
8010ac92:	89 e5                	mov    %esp,%ebp
8010ac94:	83 ec 08             	sub    $0x8,%esp
    if ((queue->tail + 1) % MESSAGE_QUEUE_SIZE == queue->head)
8010ac97:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac9a:	8b 80 04 03 00 00    	mov    0x304(%eax),%eax
8010aca0:	83 c0 01             	add    $0x1,%eax
8010aca3:	83 e0 3f             	and    $0x3f,%eax
8010aca6:	89 c2                	mov    %eax,%edx
8010aca8:	8b 45 08             	mov    0x8(%ebp),%eax
8010acab:	8b 80 00 03 00 00    	mov    0x300(%eax),%eax
8010acb1:	39 c2                	cmp    %eax,%edx
8010acb3:	75 12                	jne    8010acc7 <APMsgQueueEnQueue+0x36>
    {
        cprintf("Error! Message Queue is full\n");
8010acb5:	83 ec 0c             	sub    $0xc,%esp
8010acb8:	68 1f bb 10 80       	push   $0x8010bb1f
8010acbd:	e8 04 57 ff ff       	call   801003c6 <cprintf>
8010acc2:	83 c4 10             	add    $0x10,%esp
        return;
8010acc5:	eb 43                	jmp    8010ad0a <APMsgQueueEnQueue+0x79>
    }
    
    switch (msg.type)
    {
        default:
            break;
8010acc7:	90                   	nop
    }
    //cprintf("MsgQueue-En-Queue:tail %d \n",queue->tail);
    queue->data[queue->tail] = msg;
8010acc8:	8b 45 08             	mov    0x8(%ebp),%eax
8010accb:	8b 90 04 03 00 00    	mov    0x304(%eax),%edx
8010acd1:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010acd4:	89 d0                	mov    %edx,%eax
8010acd6:	01 c0                	add    %eax,%eax
8010acd8:	01 d0                	add    %edx,%eax
8010acda:	c1 e0 02             	shl    $0x2,%eax
8010acdd:	01 c8                	add    %ecx,%eax
8010acdf:	8b 55 0c             	mov    0xc(%ebp),%edx
8010ace2:	89 10                	mov    %edx,(%eax)
8010ace4:	8b 55 10             	mov    0x10(%ebp),%edx
8010ace7:	89 50 04             	mov    %edx,0x4(%eax)
8010acea:	8b 55 14             	mov    0x14(%ebp),%edx
8010aced:	89 50 08             	mov    %edx,0x8(%eax)
    queue->tail = (queue->tail + 1) % MESSAGE_QUEUE_SIZE;
8010acf0:	8b 45 08             	mov    0x8(%ebp),%eax
8010acf3:	8b 80 04 03 00 00    	mov    0x304(%eax),%eax
8010acf9:	83 c0 01             	add    $0x1,%eax
8010acfc:	83 e0 3f             	and    $0x3f,%eax
8010acff:	89 c2                	mov    %eax,%edx
8010ad01:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad04:	89 90 04 03 00 00    	mov    %edx,0x304(%eax)
    //cprintf("MsgQueue-En-Queue:after add tail %d \n",queue->tail);
}
8010ad0a:	c9                   	leave  
8010ad0b:	c3                   	ret    

8010ad0c <APMsgQueueDeQueue>:

//弹出消息队列顶端
AMessage APMsgQueueDeQueue(AMsgQueue * queue)
{
8010ad0c:	55                   	push   %ebp
8010ad0d:	89 e5                	mov    %esp,%ebp
8010ad0f:	53                   	push   %ebx
8010ad10:	83 ec 10             	sub    $0x10,%esp
    if (queue->head == queue->tail)
8010ad13:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad16:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010ad1c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad1f:	8b 80 04 03 00 00    	mov    0x304(%eax),%eax
8010ad25:	39 c2                	cmp    %eax,%edx
8010ad27:	75 1d                	jne    8010ad46 <APMsgQueueDeQueue+0x3a>
    {
        AMessage msg;
        msg.type = MSG_NULL;
8010ad29:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        return msg;
8010ad30:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad33:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010ad36:	89 10                	mov    %edx,(%eax)
8010ad38:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010ad3b:	89 50 04             	mov    %edx,0x4(%eax)
8010ad3e:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ad41:	89 50 08             	mov    %edx,0x8(%eax)
8010ad44:	eb 4a                	jmp    8010ad90 <APMsgQueueDeQueue+0x84>
    }
    int p = queue->head;
8010ad46:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad49:	8b 80 00 03 00 00    	mov    0x300(%eax),%eax
8010ad4f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    queue->head = (queue->head + 1) % MESSAGE_QUEUE_SIZE;
8010ad52:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad55:	8b 80 00 03 00 00    	mov    0x300(%eax),%eax
8010ad5b:	83 c0 01             	add    $0x1,%eax
8010ad5e:	83 e0 3f             	and    $0x3f,%eax
8010ad61:	89 c2                	mov    %eax,%edx
8010ad63:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad66:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
    return queue->data[p];
8010ad6c:	8b 55 08             	mov    0x8(%ebp),%edx
8010ad6f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010ad72:	8b 4d f8             	mov    -0x8(%ebp),%ecx
8010ad75:	89 c8                	mov    %ecx,%eax
8010ad77:	01 c0                	add    %eax,%eax
8010ad79:	01 c8                	add    %ecx,%eax
8010ad7b:	c1 e0 02             	shl    $0x2,%eax
8010ad7e:	01 d8                	add    %ebx,%eax
8010ad80:	8b 08                	mov    (%eax),%ecx
8010ad82:	89 0a                	mov    %ecx,(%edx)
8010ad84:	8b 48 04             	mov    0x4(%eax),%ecx
8010ad87:	89 4a 04             	mov    %ecx,0x4(%edx)
8010ad8a:	8b 40 08             	mov    0x8(%eax),%eax
8010ad8d:	89 42 08             	mov    %eax,0x8(%edx)
}
8010ad90:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad93:	83 c4 10             	add    $0x10,%esp
8010ad96:	5b                   	pop    %ebx
8010ad97:	5d                   	pop    %ebp
8010ad98:	c2 04 00             	ret    $0x4

8010ad9b <TimerCount>:

//-----------------------------------------------------------------------------
//Timer
void TimerCount()
{
8010ad9b:	55                   	push   %ebp
8010ad9c:	89 e5                	mov    %esp,%ebp
8010ad9e:	83 ec 18             	sub    $0x18,%esp
    if (!timerListReady)
8010ada1:	a1 a4 e6 10 80       	mov    0x8010e6a4,%eax
8010ada6:	85 c0                	test   %eax,%eax
8010ada8:	0f 84 ea 00 00 00    	je     8010ae98 <TimerCount+0xfd>
        return;
    acquire(&timerList.lock);
8010adae:	83 ec 0c             	sub    $0xc,%esp
8010adb1:	68 50 b4 11 80       	push   $0x8011b450
8010adb6:	e8 82 a0 ff ff       	call   80104e3d <acquire>
8010adbb:	83 c4 10             	add    $0x10,%esp
    int p = timerList.head;
8010adbe:	a1 48 b4 11 80       	mov    0x8011b448,%eax
8010adc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while(p != -1)
8010adc6:	e9 b1 00 00 00       	jmp    8010ae7c <TimerCount+0xe1>
    {
        timerList.data[p].count ++;
8010adcb:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010adce:	89 d0                	mov    %edx,%eax
8010add0:	c1 e0 02             	shl    $0x2,%eax
8010add3:	01 d0                	add    %edx,%eax
8010add5:	c1 e0 02             	shl    $0x2,%eax
8010add8:	05 8c b3 11 80       	add    $0x8011b38c,%eax
8010addd:	8b 00                	mov    (%eax),%eax
8010addf:	8d 48 01             	lea    0x1(%eax),%ecx
8010ade2:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ade5:	89 d0                	mov    %edx,%eax
8010ade7:	c1 e0 02             	shl    $0x2,%eax
8010adea:	01 d0                	add    %edx,%eax
8010adec:	c1 e0 02             	shl    $0x2,%eax
8010adef:	05 8c b3 11 80       	add    $0x8011b38c,%eax
8010adf4:	89 08                	mov    %ecx,(%eax)
        if (timerList.data[p].count >= timerList.data[p].interval)
8010adf6:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010adf9:	89 d0                	mov    %edx,%eax
8010adfb:	c1 e0 02             	shl    $0x2,%eax
8010adfe:	01 d0                	add    %edx,%eax
8010ae00:	c1 e0 02             	shl    $0x2,%eax
8010ae03:	05 8c b3 11 80       	add    $0x8011b38c,%eax
8010ae08:	8b 08                	mov    (%eax),%ecx
8010ae0a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae0d:	89 d0                	mov    %edx,%eax
8010ae0f:	c1 e0 02             	shl    $0x2,%eax
8010ae12:	01 d0                	add    %edx,%eax
8010ae14:	c1 e0 02             	shl    $0x2,%eax
8010ae17:	05 88 b3 11 80       	add    $0x8011b388,%eax
8010ae1c:	8b 00                	mov    (%eax),%eax
8010ae1e:	39 c1                	cmp    %eax,%ecx
8010ae20:	7c 43                	jl     8010ae65 <TimerCount+0xca>
        {
            timerList.data[p].count = 0;
8010ae22:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae25:	89 d0                	mov    %edx,%eax
8010ae27:	c1 e0 02             	shl    $0x2,%eax
8010ae2a:	01 d0                	add    %edx,%eax
8010ae2c:	c1 e0 02             	shl    $0x2,%eax
8010ae2f:	05 8c b3 11 80       	add    $0x8011b38c,%eax
8010ae34:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
            AMessage msg;
            msg.type = MSG_TIMEOUT;
8010ae3a:	c7 45 e8 04 00 00 00 	movl   $0x4,-0x18(%ebp)
            sendMessage(timerList.data[p].wndId,&msg);
8010ae41:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae44:	89 d0                	mov    %edx,%eax
8010ae46:	c1 e0 02             	shl    $0x2,%eax
8010ae49:	01 d0                	add    %edx,%eax
8010ae4b:	c1 e0 02             	shl    $0x2,%eax
8010ae4e:	05 80 b3 11 80       	add    $0x8011b380,%eax
8010ae53:	8b 00                	mov    (%eax),%eax
8010ae55:	83 ec 08             	sub    $0x8,%esp
8010ae58:	8d 55 e8             	lea    -0x18(%ebp),%edx
8010ae5b:	52                   	push   %edx
8010ae5c:	50                   	push   %eax
8010ae5d:	e8 59 f8 ff ff       	call   8010a6bb <sendMessage>
8010ae62:	83 c4 10             	add    $0x10,%esp
        }
        p = timerList.data[p].next;
8010ae65:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae68:	89 d0                	mov    %edx,%eax
8010ae6a:	c1 e0 02             	shl    $0x2,%eax
8010ae6d:	01 d0                	add    %edx,%eax
8010ae6f:	c1 e0 02             	shl    $0x2,%eax
8010ae72:	05 90 b3 11 80       	add    $0x8011b390,%eax
8010ae77:	8b 00                	mov    (%eax),%eax
8010ae79:	89 45 f4             	mov    %eax,-0xc(%ebp)
{
    if (!timerListReady)
        return;
    acquire(&timerList.lock);
    int p = timerList.head;
    while(p != -1)
8010ae7c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010ae80:	0f 85 45 ff ff ff    	jne    8010adcb <TimerCount+0x30>
            msg.type = MSG_TIMEOUT;
            sendMessage(timerList.data[p].wndId,&msg);
        }
        p = timerList.data[p].next;
    }
    release(&timerList.lock);
8010ae86:	83 ec 0c             	sub    $0xc,%esp
8010ae89:	68 50 b4 11 80       	push   $0x8011b450
8010ae8e:	e8 11 a0 ff ff       	call   80104ea4 <release>
8010ae93:	83 c4 10             	add    $0x10,%esp
8010ae96:	eb 01                	jmp    8010ae99 <TimerCount+0xfe>
//-----------------------------------------------------------------------------
//Timer
void TimerCount()
{
    if (!timerListReady)
        return;
8010ae98:	90                   	nop
            sendMessage(timerList.data[p].wndId,&msg);
        }
        p = timerList.data[p].next;
    }
    release(&timerList.lock);
}
8010ae99:	c9                   	leave  
8010ae9a:	c3                   	ret    

8010ae9b <APTimerListInit>:


void APTimerListInit(ATimerList * list)
{
8010ae9b:	55                   	push   %ebp
8010ae9c:	89 e5                	mov    %esp,%ebp
8010ae9e:	53                   	push   %ebx
8010ae9f:	83 ec 14             	sub    $0x14,%esp
    int i;
    for (i = 0; i < MAX_TIMER_NUM; i++)
8010aea2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010aea9:	eb 21                	jmp    8010aecc <APTimerListInit+0x31>
        list->data[i].next = i + 1;
8010aeab:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010aeae:	8d 48 01             	lea    0x1(%eax),%ecx
8010aeb1:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010aeb4:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010aeb7:	89 d0                	mov    %edx,%eax
8010aeb9:	c1 e0 02             	shl    $0x2,%eax
8010aebc:	01 d0                	add    %edx,%eax
8010aebe:	c1 e0 02             	shl    $0x2,%eax
8010aec1:	01 d8                	add    %ebx,%eax
8010aec3:	83 c0 10             	add    $0x10,%eax
8010aec6:	89 08                	mov    %ecx,(%eax)


void APTimerListInit(ATimerList * list)
{
    int i;
    for (i = 0; i < MAX_TIMER_NUM; i++)
8010aec8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010aecc:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010aed0:	7e d9                	jle    8010aeab <APTimerListInit+0x10>
        list->data[i].next = i + 1;
    list->head = -1;
8010aed2:	8b 45 08             	mov    0x8(%ebp),%eax
8010aed5:	c7 80 c8 00 00 00 ff 	movl   $0xffffffff,0xc8(%eax)
8010aedc:	ff ff ff 
    list->space = 0;
8010aedf:	8b 45 08             	mov    0x8(%ebp),%eax
8010aee2:	c7 80 cc 00 00 00 00 	movl   $0x0,0xcc(%eax)
8010aee9:	00 00 00 
    list->data[i].next = -1;
8010aeec:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aeef:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010aef2:	89 d0                	mov    %edx,%eax
8010aef4:	c1 e0 02             	shl    $0x2,%eax
8010aef7:	01 d0                	add    %edx,%eax
8010aef9:	c1 e0 02             	shl    $0x2,%eax
8010aefc:	01 c8                	add    %ecx,%eax
8010aefe:	83 c0 10             	add    $0x10,%eax
8010af01:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    initlock(&list->lock, "timerLock");
8010af07:	8b 45 08             	mov    0x8(%ebp),%eax
8010af0a:	05 d0 00 00 00       	add    $0xd0,%eax
8010af0f:	83 ec 08             	sub    $0x8,%esp
8010af12:	68 3d bb 10 80       	push   $0x8010bb3d
8010af17:	50                   	push   %eax
8010af18:	e8 fe 9e ff ff       	call   80104e1b <initlock>
8010af1d:	83 c4 10             	add    $0x10,%esp
    timerListReady = 1;
8010af20:	c7 05 a4 e6 10 80 01 	movl   $0x1,0x8010e6a4
8010af27:	00 00 00 
}
8010af2a:	90                   	nop
8010af2b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010af2e:	c9                   	leave  
8010af2f:	c3                   	ret    

8010af30 <APTimerListAddToHead>:

void APTimerListAddToHead(ATimerList * list, int wndId, int id, int interval)
{
8010af30:	55                   	push   %ebp
8010af31:	89 e5                	mov    %esp,%ebp
8010af33:	53                   	push   %ebx
8010af34:	83 ec 14             	sub    $0x14,%esp
    acquire(&list->lock);
8010af37:	8b 45 08             	mov    0x8(%ebp),%eax
8010af3a:	05 d0 00 00 00       	add    $0xd0,%eax
8010af3f:	83 ec 0c             	sub    $0xc,%esp
8010af42:	50                   	push   %eax
8010af43:	e8 f5 9e ff ff       	call   80104e3d <acquire>
8010af48:	83 c4 10             	add    $0x10,%esp
    int p = list->space;
8010af4b:	8b 45 08             	mov    0x8(%ebp),%eax
8010af4e:	8b 80 cc 00 00 00    	mov    0xcc(%eax),%eax
8010af54:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == -1)
8010af57:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010af5b:	75 15                	jne    8010af72 <APTimerListAddToHead+0x42>
    {
        cprintf("Error! Too much Timer!\n");
8010af5d:	83 ec 0c             	sub    $0xc,%esp
8010af60:	68 47 bb 10 80       	push   $0x8010bb47
8010af65:	e8 5c 54 ff ff       	call   801003c6 <cprintf>
8010af6a:	83 c4 10             	add    $0x10,%esp
        return;
8010af6d:	e9 c7 00 00 00       	jmp    8010b039 <APTimerListAddToHead+0x109>
    }
    list->space = list->data[p].next;
8010af72:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010af75:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010af78:	89 d0                	mov    %edx,%eax
8010af7a:	c1 e0 02             	shl    $0x2,%eax
8010af7d:	01 d0                	add    %edx,%eax
8010af7f:	c1 e0 02             	shl    $0x2,%eax
8010af82:	01 c8                	add    %ecx,%eax
8010af84:	83 c0 10             	add    $0x10,%eax
8010af87:	8b 10                	mov    (%eax),%edx
8010af89:	8b 45 08             	mov    0x8(%ebp),%eax
8010af8c:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
    list->data[p].next = list->head;
8010af92:	8b 45 08             	mov    0x8(%ebp),%eax
8010af95:	8b 88 c8 00 00 00    	mov    0xc8(%eax),%ecx
8010af9b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010af9e:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010afa1:	89 d0                	mov    %edx,%eax
8010afa3:	c1 e0 02             	shl    $0x2,%eax
8010afa6:	01 d0                	add    %edx,%eax
8010afa8:	c1 e0 02             	shl    $0x2,%eax
8010afab:	01 d8                	add    %ebx,%eax
8010afad:	83 c0 10             	add    $0x10,%eax
8010afb0:	89 08                	mov    %ecx,(%eax)
    list->head = p;
8010afb2:	8b 45 08             	mov    0x8(%ebp),%eax
8010afb5:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010afb8:	89 90 c8 00 00 00    	mov    %edx,0xc8(%eax)
    list->data[p].wndId = wndId;
8010afbe:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010afc1:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010afc4:	89 d0                	mov    %edx,%eax
8010afc6:	c1 e0 02             	shl    $0x2,%eax
8010afc9:	01 d0                	add    %edx,%eax
8010afcb:	c1 e0 02             	shl    $0x2,%eax
8010afce:	8d 14 01             	lea    (%ecx,%eax,1),%edx
8010afd1:	8b 45 0c             	mov    0xc(%ebp),%eax
8010afd4:	89 02                	mov    %eax,(%edx)
    list->data[p].id = id;
8010afd6:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010afd9:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010afdc:	89 d0                	mov    %edx,%eax
8010afde:	c1 e0 02             	shl    $0x2,%eax
8010afe1:	01 d0                	add    %edx,%eax
8010afe3:	c1 e0 02             	shl    $0x2,%eax
8010afe6:	01 c8                	add    %ecx,%eax
8010afe8:	8d 50 04             	lea    0x4(%eax),%edx
8010afeb:	8b 45 10             	mov    0x10(%ebp),%eax
8010afee:	89 02                	mov    %eax,(%edx)
    list->data[p].interval = interval;
8010aff0:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aff3:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010aff6:	89 d0                	mov    %edx,%eax
8010aff8:	c1 e0 02             	shl    $0x2,%eax
8010affb:	01 d0                	add    %edx,%eax
8010affd:	c1 e0 02             	shl    $0x2,%eax
8010b000:	01 c8                	add    %ecx,%eax
8010b002:	8d 50 08             	lea    0x8(%eax),%edx
8010b005:	8b 45 14             	mov    0x14(%ebp),%eax
8010b008:	89 02                	mov    %eax,(%edx)
    list->data[p].count = 0;
8010b00a:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b00d:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b010:	89 d0                	mov    %edx,%eax
8010b012:	c1 e0 02             	shl    $0x2,%eax
8010b015:	01 d0                	add    %edx,%eax
8010b017:	c1 e0 02             	shl    $0x2,%eax
8010b01a:	01 c8                	add    %ecx,%eax
8010b01c:	83 c0 0c             	add    $0xc,%eax
8010b01f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    release(&list->lock);
8010b025:	8b 45 08             	mov    0x8(%ebp),%eax
8010b028:	05 d0 00 00 00       	add    $0xd0,%eax
8010b02d:	83 ec 0c             	sub    $0xc,%esp
8010b030:	50                   	push   %eax
8010b031:	e8 6e 9e ff ff       	call   80104ea4 <release>
8010b036:	83 c4 10             	add    $0x10,%esp
    
}
8010b039:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010b03c:	c9                   	leave  
8010b03d:	c3                   	ret    

8010b03e <APTimerListRemoveWnd>:

void APTimerListRemoveWnd(ATimerList * list, int wndId)
{
8010b03e:	55                   	push   %ebp
8010b03f:	89 e5                	mov    %esp,%ebp
8010b041:	53                   	push   %ebx
8010b042:	83 ec 14             	sub    $0x14,%esp
    acquire(&list->lock);
8010b045:	8b 45 08             	mov    0x8(%ebp),%eax
8010b048:	05 d0 00 00 00       	add    $0xd0,%eax
8010b04d:	83 ec 0c             	sub    $0xc,%esp
8010b050:	50                   	push   %eax
8010b051:	e8 e7 9d ff ff       	call   80104e3d <acquire>
8010b056:	83 c4 10             	add    $0x10,%esp
    int p = list->head;
8010b059:	8b 45 08             	mov    0x8(%ebp),%eax
8010b05c:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b062:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int q = p;
8010b065:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b068:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (p != -1)
8010b06b:	e9 24 01 00 00       	jmp    8010b194 <APTimerListRemoveWnd+0x156>
    {
        if (list->data[p].wndId == wndId)
8010b070:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b073:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b076:	89 d0                	mov    %edx,%eax
8010b078:	c1 e0 02             	shl    $0x2,%eax
8010b07b:	01 d0                	add    %edx,%eax
8010b07d:	c1 e0 02             	shl    $0x2,%eax
8010b080:	01 c8                	add    %ecx,%eax
8010b082:	8b 00                	mov    (%eax),%eax
8010b084:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010b087:	0f 85 e7 00 00 00    	jne    8010b174 <APTimerListRemoveWnd+0x136>
        {
            if (p == list->head)
8010b08d:	8b 45 08             	mov    0x8(%ebp),%eax
8010b090:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b096:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010b099:	75 63                	jne    8010b0fe <APTimerListRemoveWnd+0xc0>
            {
                list->head = list->data[p].next;
8010b09b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b09e:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b0a1:	89 d0                	mov    %edx,%eax
8010b0a3:	c1 e0 02             	shl    $0x2,%eax
8010b0a6:	01 d0                	add    %edx,%eax
8010b0a8:	c1 e0 02             	shl    $0x2,%eax
8010b0ab:	01 c8                	add    %ecx,%eax
8010b0ad:	83 c0 10             	add    $0x10,%eax
8010b0b0:	8b 10                	mov    (%eax),%edx
8010b0b2:	8b 45 08             	mov    0x8(%ebp),%eax
8010b0b5:	89 90 c8 00 00 00    	mov    %edx,0xc8(%eax)
                list->data[p].next = list->space;
8010b0bb:	8b 45 08             	mov    0x8(%ebp),%eax
8010b0be:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b0c4:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b0c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b0ca:	89 d0                	mov    %edx,%eax
8010b0cc:	c1 e0 02             	shl    $0x2,%eax
8010b0cf:	01 d0                	add    %edx,%eax
8010b0d1:	c1 e0 02             	shl    $0x2,%eax
8010b0d4:	01 d8                	add    %ebx,%eax
8010b0d6:	83 c0 10             	add    $0x10,%eax
8010b0d9:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b0db:	8b 45 08             	mov    0x8(%ebp),%eax
8010b0de:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b0e1:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->head;
8010b0e7:	8b 45 08             	mov    0x8(%ebp),%eax
8010b0ea:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b0f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
                q = p;
8010b0f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b0f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010b0f9:	e9 96 00 00 00       	jmp    8010b194 <APTimerListRemoveWnd+0x156>
            }
            else
            {
                list->data[q].next = list->data[p].next;
8010b0fe:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b101:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b104:	89 d0                	mov    %edx,%eax
8010b106:	c1 e0 02             	shl    $0x2,%eax
8010b109:	01 d0                	add    %edx,%eax
8010b10b:	c1 e0 02             	shl    $0x2,%eax
8010b10e:	01 c8                	add    %ecx,%eax
8010b110:	83 c0 10             	add    $0x10,%eax
8010b113:	8b 08                	mov    (%eax),%ecx
8010b115:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b118:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b11b:	89 d0                	mov    %edx,%eax
8010b11d:	c1 e0 02             	shl    $0x2,%eax
8010b120:	01 d0                	add    %edx,%eax
8010b122:	c1 e0 02             	shl    $0x2,%eax
8010b125:	01 d8                	add    %ebx,%eax
8010b127:	83 c0 10             	add    $0x10,%eax
8010b12a:	89 08                	mov    %ecx,(%eax)
                list->data[p].next = list->space;
8010b12c:	8b 45 08             	mov    0x8(%ebp),%eax
8010b12f:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b135:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b138:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b13b:	89 d0                	mov    %edx,%eax
8010b13d:	c1 e0 02             	shl    $0x2,%eax
8010b140:	01 d0                	add    %edx,%eax
8010b142:	c1 e0 02             	shl    $0x2,%eax
8010b145:	01 d8                	add    %ebx,%eax
8010b147:	83 c0 10             	add    $0x10,%eax
8010b14a:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b14c:	8b 45 08             	mov    0x8(%ebp),%eax
8010b14f:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b152:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->data[q].next;
8010b158:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b15b:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b15e:	89 d0                	mov    %edx,%eax
8010b160:	c1 e0 02             	shl    $0x2,%eax
8010b163:	01 d0                	add    %edx,%eax
8010b165:	c1 e0 02             	shl    $0x2,%eax
8010b168:	01 c8                	add    %ecx,%eax
8010b16a:	83 c0 10             	add    $0x10,%eax
8010b16d:	8b 00                	mov    (%eax),%eax
8010b16f:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010b172:	eb 20                	jmp    8010b194 <APTimerListRemoveWnd+0x156>
            }
        }
        else
        {
            q = p;
8010b174:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b177:	89 45 f0             	mov    %eax,-0x10(%ebp)
            p = list->data[p].next;
8010b17a:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b17d:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b180:	89 d0                	mov    %edx,%eax
8010b182:	c1 e0 02             	shl    $0x2,%eax
8010b185:	01 d0                	add    %edx,%eax
8010b187:	c1 e0 02             	shl    $0x2,%eax
8010b18a:	01 c8                	add    %ecx,%eax
8010b18c:	83 c0 10             	add    $0x10,%eax
8010b18f:	8b 00                	mov    (%eax),%eax
8010b191:	89 45 f4             	mov    %eax,-0xc(%ebp)
void APTimerListRemoveWnd(ATimerList * list, int wndId)
{
    acquire(&list->lock);
    int p = list->head;
    int q = p;
    while (p != -1)
8010b194:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010b198:	0f 85 d2 fe ff ff    	jne    8010b070 <APTimerListRemoveWnd+0x32>
        {
            q = p;
            p = list->data[p].next;
        }
    }
    release(&list->lock);
8010b19e:	8b 45 08             	mov    0x8(%ebp),%eax
8010b1a1:	05 d0 00 00 00       	add    $0xd0,%eax
8010b1a6:	83 ec 0c             	sub    $0xc,%esp
8010b1a9:	50                   	push   %eax
8010b1aa:	e8 f5 9c ff ff       	call   80104ea4 <release>
8010b1af:	83 c4 10             	add    $0x10,%esp
}
8010b1b2:	90                   	nop
8010b1b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010b1b6:	c9                   	leave  
8010b1b7:	c3                   	ret    

8010b1b8 <APTimerListRemoveID>:

void APTimerListRemoveID(ATimerList * list, int wndId, int id)
{
8010b1b8:	55                   	push   %ebp
8010b1b9:	89 e5                	mov    %esp,%ebp
8010b1bb:	53                   	push   %ebx
8010b1bc:	83 ec 14             	sub    $0x14,%esp
    acquire(&list->lock);
8010b1bf:	8b 45 08             	mov    0x8(%ebp),%eax
8010b1c2:	05 d0 00 00 00       	add    $0xd0,%eax
8010b1c7:	83 ec 0c             	sub    $0xc,%esp
8010b1ca:	50                   	push   %eax
8010b1cb:	e8 6d 9c ff ff       	call   80104e3d <acquire>
8010b1d0:	83 c4 10             	add    $0x10,%esp
    int p = list->head;
8010b1d3:	8b 45 08             	mov    0x8(%ebp),%eax
8010b1d6:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b1dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int q = p;
8010b1df:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b1e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (p != -1)
8010b1e5:	e9 44 01 00 00       	jmp    8010b32e <APTimerListRemoveID+0x176>
    {
        if (list->data[p].wndId == wndId && list->data[p].id == id)
8010b1ea:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b1ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b1f0:	89 d0                	mov    %edx,%eax
8010b1f2:	c1 e0 02             	shl    $0x2,%eax
8010b1f5:	01 d0                	add    %edx,%eax
8010b1f7:	c1 e0 02             	shl    $0x2,%eax
8010b1fa:	01 c8                	add    %ecx,%eax
8010b1fc:	8b 00                	mov    (%eax),%eax
8010b1fe:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010b201:	0f 85 07 01 00 00    	jne    8010b30e <APTimerListRemoveID+0x156>
8010b207:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b20a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b20d:	89 d0                	mov    %edx,%eax
8010b20f:	c1 e0 02             	shl    $0x2,%eax
8010b212:	01 d0                	add    %edx,%eax
8010b214:	c1 e0 02             	shl    $0x2,%eax
8010b217:	01 c8                	add    %ecx,%eax
8010b219:	83 c0 04             	add    $0x4,%eax
8010b21c:	8b 00                	mov    (%eax),%eax
8010b21e:	3b 45 10             	cmp    0x10(%ebp),%eax
8010b221:	0f 85 e7 00 00 00    	jne    8010b30e <APTimerListRemoveID+0x156>
        {
            if (p == list->head)
8010b227:	8b 45 08             	mov    0x8(%ebp),%eax
8010b22a:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b230:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010b233:	75 63                	jne    8010b298 <APTimerListRemoveID+0xe0>
            {
                list->head = list->data[p].next;
8010b235:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b238:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b23b:	89 d0                	mov    %edx,%eax
8010b23d:	c1 e0 02             	shl    $0x2,%eax
8010b240:	01 d0                	add    %edx,%eax
8010b242:	c1 e0 02             	shl    $0x2,%eax
8010b245:	01 c8                	add    %ecx,%eax
8010b247:	83 c0 10             	add    $0x10,%eax
8010b24a:	8b 10                	mov    (%eax),%edx
8010b24c:	8b 45 08             	mov    0x8(%ebp),%eax
8010b24f:	89 90 c8 00 00 00    	mov    %edx,0xc8(%eax)
                list->data[p].next = list->space;
8010b255:	8b 45 08             	mov    0x8(%ebp),%eax
8010b258:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b25e:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b261:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b264:	89 d0                	mov    %edx,%eax
8010b266:	c1 e0 02             	shl    $0x2,%eax
8010b269:	01 d0                	add    %edx,%eax
8010b26b:	c1 e0 02             	shl    $0x2,%eax
8010b26e:	01 d8                	add    %ebx,%eax
8010b270:	83 c0 10             	add    $0x10,%eax
8010b273:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b275:	8b 45 08             	mov    0x8(%ebp),%eax
8010b278:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b27b:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->head;
8010b281:	8b 45 08             	mov    0x8(%ebp),%eax
8010b284:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b28a:	89 45 f4             	mov    %eax,-0xc(%ebp)
                q = p;
8010b28d:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b290:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010b293:	e9 96 00 00 00       	jmp    8010b32e <APTimerListRemoveID+0x176>
            }
            else
            {
                list->data[q].next = list->data[p].next;
8010b298:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b29b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b29e:	89 d0                	mov    %edx,%eax
8010b2a0:	c1 e0 02             	shl    $0x2,%eax
8010b2a3:	01 d0                	add    %edx,%eax
8010b2a5:	c1 e0 02             	shl    $0x2,%eax
8010b2a8:	01 c8                	add    %ecx,%eax
8010b2aa:	83 c0 10             	add    $0x10,%eax
8010b2ad:	8b 08                	mov    (%eax),%ecx
8010b2af:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b2b2:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b2b5:	89 d0                	mov    %edx,%eax
8010b2b7:	c1 e0 02             	shl    $0x2,%eax
8010b2ba:	01 d0                	add    %edx,%eax
8010b2bc:	c1 e0 02             	shl    $0x2,%eax
8010b2bf:	01 d8                	add    %ebx,%eax
8010b2c1:	83 c0 10             	add    $0x10,%eax
8010b2c4:	89 08                	mov    %ecx,(%eax)
                list->data[p].next = list->space;
8010b2c6:	8b 45 08             	mov    0x8(%ebp),%eax
8010b2c9:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b2cf:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b2d2:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b2d5:	89 d0                	mov    %edx,%eax
8010b2d7:	c1 e0 02             	shl    $0x2,%eax
8010b2da:	01 d0                	add    %edx,%eax
8010b2dc:	c1 e0 02             	shl    $0x2,%eax
8010b2df:	01 d8                	add    %ebx,%eax
8010b2e1:	83 c0 10             	add    $0x10,%eax
8010b2e4:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b2e6:	8b 45 08             	mov    0x8(%ebp),%eax
8010b2e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b2ec:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->data[q].next;
8010b2f2:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b2f5:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b2f8:	89 d0                	mov    %edx,%eax
8010b2fa:	c1 e0 02             	shl    $0x2,%eax
8010b2fd:	01 d0                	add    %edx,%eax
8010b2ff:	c1 e0 02             	shl    $0x2,%eax
8010b302:	01 c8                	add    %ecx,%eax
8010b304:	83 c0 10             	add    $0x10,%eax
8010b307:	8b 00                	mov    (%eax),%eax
8010b309:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int q = p;
    while (p != -1)
    {
        if (list->data[p].wndId == wndId && list->data[p].id == id)
        {
            if (p == list->head)
8010b30c:	eb 20                	jmp    8010b32e <APTimerListRemoveID+0x176>
                p = list->data[q].next;
            }
        }
        else
        {
            q = p;
8010b30e:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b311:	89 45 f0             	mov    %eax,-0x10(%ebp)
            p = list->data[p].next;
8010b314:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b317:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b31a:	89 d0                	mov    %edx,%eax
8010b31c:	c1 e0 02             	shl    $0x2,%eax
8010b31f:	01 d0                	add    %edx,%eax
8010b321:	c1 e0 02             	shl    $0x2,%eax
8010b324:	01 c8                	add    %ecx,%eax
8010b326:	83 c0 10             	add    $0x10,%eax
8010b329:	8b 00                	mov    (%eax),%eax
8010b32b:	89 45 f4             	mov    %eax,-0xc(%ebp)
void APTimerListRemoveID(ATimerList * list, int wndId, int id)
{
    acquire(&list->lock);
    int p = list->head;
    int q = p;
    while (p != -1)
8010b32e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010b332:	0f 85 b2 fe ff ff    	jne    8010b1ea <APTimerListRemoveID+0x32>
        {
            q = p;
            p = list->data[p].next;
        }
    }
    release(&list->lock);
8010b338:	8b 45 08             	mov    0x8(%ebp),%eax
8010b33b:	05 d0 00 00 00       	add    $0xd0,%eax
8010b340:	83 ec 0c             	sub    $0xc,%esp
8010b343:	50                   	push   %eax
8010b344:	e8 5b 9b ff ff       	call   80104ea4 <release>
8010b349:	83 c4 10             	add    $0x10,%esp
}
8010b34c:	90                   	nop
8010b34d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010b350:	c9                   	leave  
8010b351:	c3                   	ret    

8010b352 <sys_setupTimer>:

void sys_setupTimer(void)
{
8010b352:	55                   	push   %ebp
8010b353:	89 e5                	mov    %esp,%ebp
8010b355:	83 ec 18             	sub    $0x18,%esp
    AHwnd hwnd;
    int id,interval;
    if (argstr(0, (char **)&hwnd) < 0 || argint(1, &id) < 0 || argint(2, &interval) < 0)
8010b358:	83 ec 08             	sub    $0x8,%esp
8010b35b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010b35e:	50                   	push   %eax
8010b35f:	6a 00                	push   $0x0
8010b361:	e8 e4 a0 ff ff       	call   8010544a <argstr>
8010b366:	83 c4 10             	add    $0x10,%esp
8010b369:	85 c0                	test   %eax,%eax
8010b36b:	78 5c                	js     8010b3c9 <sys_setupTimer+0x77>
8010b36d:	83 ec 08             	sub    $0x8,%esp
8010b370:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010b373:	50                   	push   %eax
8010b374:	6a 01                	push   $0x1
8010b376:	e8 4a a0 ff ff       	call   801053c5 <argint>
8010b37b:	83 c4 10             	add    $0x10,%esp
8010b37e:	85 c0                	test   %eax,%eax
8010b380:	78 47                	js     8010b3c9 <sys_setupTimer+0x77>
8010b382:	83 ec 08             	sub    $0x8,%esp
8010b385:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010b388:	50                   	push   %eax
8010b389:	6a 02                	push   $0x2
8010b38b:	e8 35 a0 ff ff       	call   801053c5 <argint>
8010b390:	83 c4 10             	add    $0x10,%esp
8010b393:	85 c0                	test   %eax,%eax
8010b395:	78 32                	js     8010b3c9 <sys_setupTimer+0x77>
        return ;
    APTimerListAddToHead(&timerList,hwnd->id,id,interval/10);
8010b397:	8b 4d ec             	mov    -0x14(%ebp),%ecx
8010b39a:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010b39f:	89 c8                	mov    %ecx,%eax
8010b3a1:	f7 ea                	imul   %edx
8010b3a3:	c1 fa 02             	sar    $0x2,%edx
8010b3a6:	89 c8                	mov    %ecx,%eax
8010b3a8:	c1 f8 1f             	sar    $0x1f,%eax
8010b3ab:	89 d1                	mov    %edx,%ecx
8010b3ad:	29 c1                	sub    %eax,%ecx
8010b3af:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b3b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b3b5:	8b 00                	mov    (%eax),%eax
8010b3b7:	51                   	push   %ecx
8010b3b8:	52                   	push   %edx
8010b3b9:	50                   	push   %eax
8010b3ba:	68 80 b3 11 80       	push   $0x8011b380
8010b3bf:	e8 6c fb ff ff       	call   8010af30 <APTimerListAddToHead>
8010b3c4:	83 c4 10             	add    $0x10,%esp
8010b3c7:	eb 01                	jmp    8010b3ca <sys_setupTimer+0x78>
void sys_setupTimer(void)
{
    AHwnd hwnd;
    int id,interval;
    if (argstr(0, (char **)&hwnd) < 0 || argint(1, &id) < 0 || argint(2, &interval) < 0)
        return ;
8010b3c9:	90                   	nop
    APTimerListAddToHead(&timerList,hwnd->id,id,interval/10);
}
8010b3ca:	c9                   	leave  
8010b3cb:	c3                   	ret    

8010b3cc <sys_deleteTimer>:
void sys_deleteTimer(void)
{
8010b3cc:	55                   	push   %ebp
8010b3cd:	89 e5                	mov    %esp,%ebp
8010b3cf:	83 ec 18             	sub    $0x18,%esp
    AHwnd hwnd;
    int id;
    if (argstr(0, (char **)&hwnd) < 0 || argint(1, &id) < 0)
8010b3d2:	83 ec 08             	sub    $0x8,%esp
8010b3d5:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010b3d8:	50                   	push   %eax
8010b3d9:	6a 00                	push   $0x0
8010b3db:	e8 6a a0 ff ff       	call   8010544a <argstr>
8010b3e0:	83 c4 10             	add    $0x10,%esp
8010b3e3:	85 c0                	test   %eax,%eax
8010b3e5:	78 31                	js     8010b418 <sys_deleteTimer+0x4c>
8010b3e7:	83 ec 08             	sub    $0x8,%esp
8010b3ea:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010b3ed:	50                   	push   %eax
8010b3ee:	6a 01                	push   $0x1
8010b3f0:	e8 d0 9f ff ff       	call   801053c5 <argint>
8010b3f5:	83 c4 10             	add    $0x10,%esp
8010b3f8:	85 c0                	test   %eax,%eax
8010b3fa:	78 1c                	js     8010b418 <sys_deleteTimer+0x4c>
        return ;
    APTimerListRemoveID(&timerList,hwnd->id,id);
8010b3fc:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b3ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b402:	8b 00                	mov    (%eax),%eax
8010b404:	83 ec 04             	sub    $0x4,%esp
8010b407:	52                   	push   %edx
8010b408:	50                   	push   %eax
8010b409:	68 80 b3 11 80       	push   $0x8011b380
8010b40e:	e8 a5 fd ff ff       	call   8010b1b8 <APTimerListRemoveID>
8010b413:	83 c4 10             	add    $0x10,%esp
8010b416:	eb 01                	jmp    8010b419 <sys_deleteTimer+0x4d>
void sys_deleteTimer(void)
{
    AHwnd hwnd;
    int id;
    if (argstr(0, (char **)&hwnd) < 0 || argint(1, &id) < 0)
        return ;
8010b418:	90                   	nop
    APTimerListRemoveID(&timerList,hwnd->id,id);
}
8010b419:	c9                   	leave  
8010b41a:	c3                   	ret    
