
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
80100028:	bc b0 f6 10 80       	mov    $0x8010f6b0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 25 37 10 80       	mov    $0x80103725,%eax
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
8010003d:	68 dc b3 10 80       	push   $0x8010b3dc
80100042:	68 c0 f6 10 80       	push   $0x8010f6c0
80100047:	e8 f2 4d 00 00       	call   80104e3e <initlock>
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
801000c1:	e8 9a 4d 00 00       	call   80104e60 <acquire>
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
8010010c:	e8 b6 4d 00 00       	call   80104ec7 <release>
80100111:	83 c4 10             	add    $0x10,%esp
        return b;
80100114:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100117:	e9 98 00 00 00       	jmp    801001b4 <bget+0x101>
      }
      sleep(b, &bcache.lock);
8010011c:	83 ec 08             	sub    $0x8,%esp
8010011f:	68 c0 f6 10 80       	push   $0x8010f6c0
80100124:	ff 75 f4             	pushl  -0xc(%ebp)
80100127:	e8 3b 4a 00 00       	call   80104b67 <sleep>
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
80100188:	e8 3a 4d 00 00       	call   80104ec7 <release>
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
801001aa:	68 e3 b3 10 80       	push   $0x8010b3e3
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
80100204:	68 f4 b3 10 80       	push   $0x8010b3f4
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
80100243:	68 fb b3 10 80       	push   $0x8010b3fb
80100248:	e8 19 03 00 00       	call   80100566 <panic>

  acquire(&bcache.lock);
8010024d:	83 ec 0c             	sub    $0xc,%esp
80100250:	68 c0 f6 10 80       	push   $0x8010f6c0
80100255:	e8 06 4c 00 00       	call   80104e60 <acquire>
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
801002b9:	e8 94 49 00 00       	call   80104c52 <wakeup>
801002be:	83 c4 10             	add    $0x10,%esp

  release(&bcache.lock);
801002c1:	83 ec 0c             	sub    $0xc,%esp
801002c4:	68 c0 f6 10 80       	push   $0x8010f6c0
801002c9:	e8 f9 4b 00 00       	call   80104ec7 <release>
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
801003e2:	e8 79 4a 00 00       	call   80104e60 <acquire>
801003e7:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
801003ea:	8b 45 08             	mov    0x8(%ebp),%eax
801003ed:	85 c0                	test   %eax,%eax
801003ef:	75 0d                	jne    801003fe <cprintf+0x38>
    panic("null fmt");
801003f1:	83 ec 0c             	sub    $0xc,%esp
801003f4:	68 02 b4 10 80       	push   $0x8010b402
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
801004cd:	c7 45 ec 0b b4 10 80 	movl   $0x8010b40b,-0x14(%ebp)
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
8010055b:	e8 67 49 00 00       	call   80104ec7 <release>
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
8010058b:	68 12 b4 10 80       	push   $0x8010b412
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
801005aa:	68 21 b4 10 80       	push   $0x8010b421
801005af:	e8 12 fe ff ff       	call   801003c6 <cprintf>
801005b4:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005b7:	83 ec 08             	sub    $0x8,%esp
801005ba:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005bd:	50                   	push   %eax
801005be:	8d 45 08             	lea    0x8(%ebp),%eax
801005c1:	50                   	push   %eax
801005c2:	e8 52 49 00 00       	call   80104f19 <getcallerpcs>
801005c7:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005d1:	eb 1c                	jmp    801005ef <panic+0x89>
    cprintf(" %p", pcs[i]);
801005d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005d6:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005da:	83 ec 08             	sub    $0x8,%esp
801005dd:	50                   	push   %eax
801005de:	68 23 b4 10 80       	push   $0x8010b423
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
801006db:	e8 a2 4a 00 00       	call   80105182 <memmove>
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
80100705:	e8 b9 49 00 00       	call   801050c3 <memset>
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
8010079a:	e8 41 62 00 00       	call   801069e0 <uartputc>
8010079f:	83 c4 10             	add    $0x10,%esp
801007a2:	83 ec 0c             	sub    $0xc,%esp
801007a5:	6a 20                	push   $0x20
801007a7:	e8 34 62 00 00       	call   801069e0 <uartputc>
801007ac:	83 c4 10             	add    $0x10,%esp
801007af:	83 ec 0c             	sub    $0xc,%esp
801007b2:	6a 08                	push   $0x8
801007b4:	e8 27 62 00 00       	call   801069e0 <uartputc>
801007b9:	83 c4 10             	add    $0x10,%esp
801007bc:	eb 0e                	jmp    801007cc <consputc+0x56>
  } else
    uartputc(c);
801007be:	83 ec 0c             	sub    $0xc,%esp
801007c1:	ff 75 08             	pushl  0x8(%ebp)
801007c4:	e8 17 62 00 00       	call   801069e0 <uartputc>
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
801007eb:	e8 70 46 00 00       	call   80104e60 <acquire>
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
8010081e:	e8 ea 44 00 00       	call   80104d0d <procdump>
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
80100931:	e8 1c 43 00 00       	call   80104c52 <wakeup>
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
80100954:	e8 6e 45 00 00       	call   80104ec7 <release>
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
80100981:	e8 da 44 00 00       	call   80104e60 <acquire>
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
801009a3:	e8 1f 45 00 00       	call   80104ec7 <release>
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
801009d0:	e8 92 41 00 00       	call   80104b67 <sleep>
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
80100a4e:	e8 74 44 00 00       	call   80104ec7 <release>
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
80100a8c:	e8 cf 43 00 00       	call   80104e60 <acquire>
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
80100ace:	e8 f4 43 00 00       	call   80104ec7 <release>
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
80100af2:	68 27 b4 10 80       	push   $0x8010b427
80100af7:	68 00 e6 10 80       	push   $0x8010e600
80100afc:	e8 3d 43 00 00       	call   80104e3e <initlock>
80100b01:	83 c4 10             	add    $0x10,%esp
  initlock(&input.lock, "input");
80100b04:	83 ec 08             	sub    $0x8,%esp
80100b07:	68 2f b4 10 80       	push   $0x8010b42f
80100b0c:	68 00 0e 11 80       	push   $0x80110e00
80100b11:	e8 28 43 00 00       	call   80104e3e <initlock>
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
80100b3c:	e8 8a 32 00 00       	call   80103dcb <picenable>
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
80100bc5:	e8 6b 6f 00 00       	call   80107b35 <setupkvm>
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
80100c4b:	e8 8c 72 00 00       	call   80107edc <allocuvm>
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
80100c7e:	e8 82 71 00 00       	call   80107e05 <loaduvm>
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
80100ce8:	e8 ef 71 00 00       	call   80107edc <allocuvm>
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
80100d0c:	e8 f1 73 00 00       	call   80108102 <clearpteu>
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
80100d45:	e8 c6 45 00 00       	call   80105310 <strlen>
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
80100d72:	e8 99 45 00 00       	call   80105310 <strlen>
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
80100d98:	e8 09 75 00 00       	call   801082a6 <copyout>
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
80100e34:	e8 6d 74 00 00       	call   801082a6 <copyout>
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
80100e85:	e8 3c 44 00 00       	call   801052c6 <safestrcpy>
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
80100edb:	e8 3c 6d 00 00       	call   80107c1c <switchuvm>
80100ee0:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100ee3:	83 ec 0c             	sub    $0xc,%esp
80100ee6:	ff 75 d0             	pushl  -0x30(%ebp)
80100ee9:	e8 74 71 00 00       	call   80108062 <freevm>
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
80100f23:	e8 3a 71 00 00       	call   80108062 <freevm>
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
80100f4f:	68 35 b4 10 80       	push   $0x8010b435
80100f54:	68 c0 0e 11 80       	push   $0x80110ec0
80100f59:	e8 e0 3e 00 00       	call   80104e3e <initlock>
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
80100f72:	e8 e9 3e 00 00       	call   80104e60 <acquire>
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
80100f9f:	e8 23 3f 00 00       	call   80104ec7 <release>
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
80100fc2:	e8 00 3f 00 00       	call   80104ec7 <release>
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
80100fdf:	e8 7c 3e 00 00       	call   80104e60 <acquire>
80100fe4:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80100fe7:	8b 45 08             	mov    0x8(%ebp),%eax
80100fea:	8b 40 04             	mov    0x4(%eax),%eax
80100fed:	85 c0                	test   %eax,%eax
80100fef:	7f 0d                	jg     80100ffe <filedup+0x2d>
    panic("filedup");
80100ff1:	83 ec 0c             	sub    $0xc,%esp
80100ff4:	68 3c b4 10 80       	push   $0x8010b43c
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
80101015:	e8 ad 3e 00 00       	call   80104ec7 <release>
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
80101030:	e8 2b 3e 00 00       	call   80104e60 <acquire>
80101035:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101038:	8b 45 08             	mov    0x8(%ebp),%eax
8010103b:	8b 40 04             	mov    0x4(%eax),%eax
8010103e:	85 c0                	test   %eax,%eax
80101040:	7f 0d                	jg     8010104f <fileclose+0x2d>
    panic("fileclose");
80101042:	83 ec 0c             	sub    $0xc,%esp
80101045:	68 44 b4 10 80       	push   $0x8010b444
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
80101070:	e8 52 3e 00 00       	call   80104ec7 <release>
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
801010be:	e8 04 3e 00 00       	call   80104ec7 <release>
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
801010dd:	e8 52 2f 00 00       	call   80104034 <pipeclose>
801010e2:	83 c4 10             	add    $0x10,%esp
801010e5:	eb 21                	jmp    80101108 <fileclose+0xe6>
  else if(ff.type == FD_INODE){
801010e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010ea:	83 f8 02             	cmp    $0x2,%eax
801010ed:	75 19                	jne    80101108 <fileclose+0xe6>
    begin_trans();
801010ef:	e8 12 24 00 00       	call   80103506 <begin_trans>
    iput(ff.ip);
801010f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801010f7:	83 ec 0c             	sub    $0xc,%esp
801010fa:	50                   	push   %eax
801010fb:	e8 c1 09 00 00       	call   80101ac1 <iput>
80101100:	83 c4 10             	add    $0x10,%esp
    commit_trans();
80101103:	e8 51 24 00 00       	call   80103559 <commit_trans>
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
80101196:	e8 41 30 00 00       	call   801041dc <piperead>
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
8010120d:	68 4e b4 10 80       	push   $0x8010b44e
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
8010124f:	e8 8a 2e 00 00       	call   801040de <pipewrite>
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
80101294:	e8 6d 22 00 00       	call   80103506 <begin_trans>
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
801012fa:	e8 5a 22 00 00       	call   80103559 <commit_trans>

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
80101310:	68 57 b4 10 80       	push   $0x8010b457
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
80101346:	68 67 b4 10 80       	push   $0x8010b467
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
8010137e:	e8 ff 3d 00 00       	call   80105182 <memmove>
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
801013c4:	e8 fa 3c 00 00       	call   801050c3 <memset>
801013c9:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801013cc:	83 ec 0c             	sub    $0xc,%esp
801013cf:	ff 75 f4             	pushl  -0xc(%ebp)
801013d2:	e8 e7 21 00 00       	call   801035be <log_write>
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
801014bd:	e8 fc 20 00 00       	call   801035be <log_write>
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
8010153d:	68 71 b4 10 80       	push   $0x8010b471
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
801015d3:	68 87 b4 10 80       	push   $0x8010b487
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
8010160b:	e8 ae 1f 00 00       	call   801035be <log_write>
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
8010162d:	68 9a b4 10 80       	push   $0x8010b49a
80101632:	68 c0 18 11 80       	push   $0x801118c0
80101637:	e8 02 38 00 00       	call   80104e3e <initlock>
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
801016b2:	e8 0c 3a 00 00       	call   801050c3 <memset>
801016b7:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
801016ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016bd:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
801016c1:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
801016c4:	83 ec 0c             	sub    $0xc,%esp
801016c7:	ff 75 f0             	pushl  -0x10(%ebp)
801016ca:	e8 ef 1e 00 00       	call   801035be <log_write>
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
80101717:	68 a1 b4 10 80       	push   $0x8010b4a1
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
801017b7:	e8 c6 39 00 00       	call   80105182 <memmove>
801017bc:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801017bf:	83 ec 0c             	sub    $0xc,%esp
801017c2:	ff 75 f4             	pushl  -0xc(%ebp)
801017c5:	e8 f4 1d 00 00       	call   801035be <log_write>
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
801017ec:	e8 6f 36 00 00       	call   80104e60 <acquire>
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
8010183a:	e8 88 36 00 00       	call   80104ec7 <release>
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
80101873:	68 b3 b4 10 80       	push   $0x8010b4b3
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
801018b0:	e8 12 36 00 00       	call   80104ec7 <release>
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
801018cb:	e8 90 35 00 00       	call   80104e60 <acquire>
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
801018ea:	e8 d8 35 00 00       	call   80104ec7 <release>
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
80101910:	68 c3 b4 10 80       	push   $0x8010b4c3
80101915:	e8 4c ec ff ff       	call   80100566 <panic>

  acquire(&icache.lock);
8010191a:	83 ec 0c             	sub    $0xc,%esp
8010191d:	68 c0 18 11 80       	push   $0x801118c0
80101922:	e8 39 35 00 00       	call   80104e60 <acquire>
80101927:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
8010192a:	eb 13                	jmp    8010193f <ilock+0x48>
    sleep(ip, &icache.lock);
8010192c:	83 ec 08             	sub    $0x8,%esp
8010192f:	68 c0 18 11 80       	push   $0x801118c0
80101934:	ff 75 08             	pushl  0x8(%ebp)
80101937:	e8 2b 32 00 00       	call   80104b67 <sleep>
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
80101965:	e8 5d 35 00 00       	call   80104ec7 <release>
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
80101a0c:	e8 71 37 00 00       	call   80105182 <memmove>
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
80101a42:	68 c9 b4 10 80       	push   $0x8010b4c9
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
80101a75:	68 d8 b4 10 80       	push   $0x8010b4d8
80101a7a:	e8 e7 ea ff ff       	call   80100566 <panic>

  acquire(&icache.lock);
80101a7f:	83 ec 0c             	sub    $0xc,%esp
80101a82:	68 c0 18 11 80       	push   $0x801118c0
80101a87:	e8 d4 33 00 00       	call   80104e60 <acquire>
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
80101aa6:	e8 a7 31 00 00       	call   80104c52 <wakeup>
80101aab:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80101aae:	83 ec 0c             	sub    $0xc,%esp
80101ab1:	68 c0 18 11 80       	push   $0x801118c0
80101ab6:	e8 0c 34 00 00       	call   80104ec7 <release>
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
80101acf:	e8 8c 33 00 00       	call   80104e60 <acquire>
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
80101b17:	68 e0 b4 10 80       	push   $0x8010b4e0
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
80101b3a:	e8 88 33 00 00       	call   80104ec7 <release>
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
80101b6f:	e8 ec 32 00 00       	call   80104e60 <acquire>
80101b74:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101b77:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7a:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101b81:	83 ec 0c             	sub    $0xc,%esp
80101b84:	ff 75 08             	pushl  0x8(%ebp)
80101b87:	e8 c6 30 00 00       	call   80104c52 <wakeup>
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
80101ba6:	e8 1c 33 00 00       	call   80104ec7 <release>
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
80101cc8:	e8 f1 18 00 00       	call   801035be <log_write>
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
80101d92:	e8 27 18 00 00       	call   801035be <log_write>
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
80101e17:	e8 a2 17 00 00       	call   801035be <log_write>
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
80101e35:	68 ea b4 10 80       	push   $0x8010b4ea
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
801020cc:	e8 b1 30 00 00       	call   80105182 <memmove>
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
8010221e:	e8 5f 2f 00 00       	call   80105182 <memmove>
80102223:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
80102226:	83 ec 0c             	sub    $0xc,%esp
80102229:	ff 75 f0             	pushl  -0x10(%ebp)
8010222c:	e8 8d 13 00 00       	call   801035be <log_write>
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
8010229e:	e8 75 2f 00 00       	call   80105218 <strncmp>
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
801022be:	68 fd b4 10 80       	push   $0x8010b4fd
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
801022ed:	68 0f b5 10 80       	push   $0x8010b50f
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
801023c2:	68 0f b5 10 80       	push   $0x8010b50f
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
801023fd:	e8 6c 2e 00 00       	call   8010526e <strncpy>
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
80102429:	68 1c b5 10 80       	push   $0x8010b51c
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
8010249f:	e8 de 2c 00 00       	call   80105182 <memmove>
801024a4:	83 c4 10             	add    $0x10,%esp
801024a7:	eb 26                	jmp    801024cf <skipelem+0x95>
  else {
    memmove(name, s, len);
801024a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801024ac:	83 ec 04             	sub    $0x4,%esp
801024af:	50                   	push   %eax
801024b0:	ff 75 f4             	pushl  -0xc(%ebp)
801024b3:	ff 75 0c             	pushl  0xc(%ebp)
801024b6:	e8 c7 2c 00 00       	call   80105182 <memmove>
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
8010270b:	68 24 b5 10 80       	push   $0x8010b524
80102710:	68 40 e6 10 80       	push   $0x8010e640
80102715:	e8 24 27 00 00       	call   80104e3e <initlock>
8010271a:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
8010271d:	83 ec 0c             	sub    $0xc,%esp
80102720:	6a 0e                	push   $0xe
80102722:	e8 a4 16 00 00       	call   80103dcb <picenable>
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
801027bf:	68 28 b5 10 80       	push   $0x8010b528
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
801028e0:	e8 7b 25 00 00       	call   80104e60 <acquire>
801028e5:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
801028e8:	a1 74 e6 10 80       	mov    0x8010e674,%eax
801028ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028f0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801028f4:	75 15                	jne    8010290b <ideintr+0x39>
    release(&idelock);
801028f6:	83 ec 0c             	sub    $0xc,%esp
801028f9:	68 40 e6 10 80       	push   $0x8010e640
801028fe:	e8 c4 25 00 00       	call   80104ec7 <release>
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
80102973:	e8 da 22 00 00       	call   80104c52 <wakeup>
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
8010299d:	e8 25 25 00 00       	call   80104ec7 <release>
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
801029bc:	68 31 b5 10 80       	push   $0x8010b531
801029c1:	e8 a0 db ff ff       	call   80100566 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801029c6:	8b 45 08             	mov    0x8(%ebp),%eax
801029c9:	8b 00                	mov    (%eax),%eax
801029cb:	83 e0 06             	and    $0x6,%eax
801029ce:	83 f8 02             	cmp    $0x2,%eax
801029d1:	75 0d                	jne    801029e0 <iderw+0x39>
    panic("iderw: nothing to do");
801029d3:	83 ec 0c             	sub    $0xc,%esp
801029d6:	68 45 b5 10 80       	push   $0x8010b545
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
801029f6:	68 5a b5 10 80       	push   $0x8010b55a
801029fb:	e8 66 db ff ff       	call   80100566 <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102a00:	83 ec 0c             	sub    $0xc,%esp
80102a03:	68 40 e6 10 80       	push   $0x8010e640
80102a08:	e8 53 24 00 00       	call   80104e60 <acquire>
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
80102a64:	e8 fe 20 00 00       	call   80104b67 <sleep>
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
80102a81:	e8 41 24 00 00       	call   80104ec7 <release>
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
80102b12:	68 78 b5 10 80       	push   $0x8010b578
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
80102bd2:	68 aa b5 10 80       	push   $0x8010b5aa
80102bd7:	68 a0 28 11 80       	push   $0x801128a0
80102bdc:	e8 5d 22 00 00       	call   80104e3e <initlock>
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
80102c75:	81 7d 08 e0 ba 15 80 	cmpl   $0x8015bae0,0x8(%ebp)
80102c7c:	72 12                	jb     80102c90 <kfree+0x2d>
80102c7e:	ff 75 08             	pushl  0x8(%ebp)
80102c81:	e8 36 ff ff ff       	call   80102bbc <v2p>
80102c86:	83 c4 04             	add    $0x4,%esp
80102c89:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102c8e:	76 0d                	jbe    80102c9d <kfree+0x3a>
    panic("kfree");
80102c90:	83 ec 0c             	sub    $0xc,%esp
80102c93:	68 af b5 10 80       	push   $0x8010b5af
80102c98:	e8 c9 d8 ff ff       	call   80100566 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102c9d:	83 ec 04             	sub    $0x4,%esp
80102ca0:	68 00 10 00 00       	push   $0x1000
80102ca5:	6a 01                	push   $0x1
80102ca7:	ff 75 08             	pushl  0x8(%ebp)
80102caa:	e8 14 24 00 00       	call   801050c3 <memset>
80102caf:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102cb2:	a1 d4 28 11 80       	mov    0x801128d4,%eax
80102cb7:	85 c0                	test   %eax,%eax
80102cb9:	74 10                	je     80102ccb <kfree+0x68>
    acquire(&kmem.lock);
80102cbb:	83 ec 0c             	sub    $0xc,%esp
80102cbe:	68 a0 28 11 80       	push   $0x801128a0
80102cc3:	e8 98 21 00 00       	call   80104e60 <acquire>
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
80102cf5:	e8 cd 21 00 00       	call   80104ec7 <release>
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
80102d17:	e8 44 21 00 00       	call   80104e60 <acquire>
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
80102d48:	e8 7a 21 00 00       	call   80104ec7 <release>
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
	cprintf("state : %d\n", st);
80102d98:	83 ec 08             	sub    $0x8,%esp
80102d9b:	ff 75 f4             	pushl  -0xc(%ebp)
80102d9e:	68 b5 b5 10 80       	push   $0x8010b5b5
80102da3:	e8 1e d6 ff ff       	call   801003c6 <cprintf>
80102da8:	83 c4 10             	add    $0x10,%esp
	cprintf("data  : %d\n", data);
80102dab:	83 ec 08             	sub    $0x8,%esp
80102dae:	ff 75 f0             	pushl  -0x10(%ebp)
80102db1:	68 c1 b5 10 80       	push   $0x8010b5c1
80102db6:	e8 0b d6 ff ff       	call   801003c6 <cprintf>
80102dbb:	83 c4 10             	add    $0x10,%esp

	if ((st & KBS_DIB) == 0 || (st & 0x20) != 0)
80102dbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102dc1:	83 e0 01             	and    $0x1,%eax
80102dc4:	85 c0                	test   %eax,%eax
80102dc6:	74 0a                	je     80102dd2 <kbdInterupt+0x60>
80102dc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102dcb:	83 e0 20             	and    $0x20,%eax
80102dce:	85 c0                	test   %eax,%eax
80102dd0:	74 18                	je     80102dea <kbdInterupt+0x78>
	{
		cprintf("kbdInterupt return : %d\n", st);
80102dd2:	83 ec 08             	sub    $0x8,%esp
80102dd5:	ff 75 f4             	pushl  -0xc(%ebp)
80102dd8:	68 cd b5 10 80       	push   $0x8010b5cd
80102ddd:	e8 e4 d5 ff ff       	call   801003c6 <cprintf>
80102de2:	83 c4 10             	add    $0x10,%esp
		return;
80102de5:	e9 cd 00 00 00       	jmp    80102eb7 <kbdInterupt+0x145>
	}

	if (data == 0xE0) {
80102dea:	81 7d f0 e0 00 00 00 	cmpl   $0xe0,-0x10(%ebp)
80102df1:	75 0f                	jne    80102e02 <kbdInterupt+0x90>
		shift = 1;
80102df3:	c7 05 7c e6 10 80 01 	movl   $0x1,0x8010e67c
80102dfa:	00 00 00 
		return;
80102dfd:	e9 b5 00 00 00       	jmp    80102eb7 <kbdInterupt+0x145>
	}
	else if (data & 0x80) {
80102e02:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102e05:	25 80 00 00 00       	and    $0x80,%eax
80102e0a:	85 c0                	test   %eax,%eax
80102e0c:	74 60                	je     80102e6e <kbdInterupt+0xfc>
		cprintf("test2");
80102e0e:	83 ec 0c             	sub    $0xc,%esp
80102e11:	68 e6 b5 10 80       	push   $0x8010b5e6
80102e16:	e8 ab d5 ff ff       	call   801003c6 <cprintf>
80102e1b:	83 c4 10             	add    $0x10,%esp
		// Key released
		data &= 0x7F;
80102e1e:	83 65 f0 7f          	andl   $0x7f,-0x10(%ebp)
		AMessage msg;
		msg.type = MSG_KEY_UP;
80102e22:	c7 45 d8 05 00 00 00 	movl   $0x5,-0x28(%ebp)
		msg.param = charcode[shift][data];
80102e29:	a1 7c e6 10 80       	mov    0x8010e67c,%eax
80102e2e:	8b 14 85 20 c7 10 80 	mov    -0x7fef38e0(,%eax,4),%edx
80102e35:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102e38:	01 d0                	add    %edx,%eax
80102e3a:	0f b6 00             	movzbl (%eax),%eax
80102e3d:	0f b6 c0             	movzbl %al,%eax
80102e40:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if (shift)
80102e43:	a1 7c e6 10 80       	mov    0x8010e67c,%eax
80102e48:	85 c0                	test   %eax,%eax
80102e4a:	74 0a                	je     80102e56 <kbdInterupt+0xe4>
			shift = 0;
80102e4c:	c7 05 7c e6 10 80 00 	movl   $0x0,0x8010e67c
80102e53:	00 00 00 

		sendMessage(wndList.entry, &msg);
80102e56:	a1 80 78 11 80       	mov    0x80117880,%eax
80102e5b:	83 ec 08             	sub    $0x8,%esp
80102e5e:	8d 55 d8             	lea    -0x28(%ebp),%edx
80102e61:	52                   	push   %edx
80102e62:	50                   	push   %eax
80102e63:	e8 47 78 00 00       	call   8010a6af <sendMessage>
80102e68:	83 c4 10             	add    $0x10,%esp
		return;
80102e6b:	90                   	nop
80102e6c:	eb 49                	jmp    80102eb7 <kbdInterupt+0x145>
	}
	AMessage msg;
	msg.type = MSG_KEY_DOWN;
80102e6e:	c7 45 e4 06 00 00 00 	movl   $0x6,-0x1c(%ebp)
	msg.param = charcode[shift][data];
80102e75:	a1 7c e6 10 80       	mov    0x8010e67c,%eax
80102e7a:	8b 14 85 20 c7 10 80 	mov    -0x7fef38e0(,%eax,4),%edx
80102e81:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102e84:	01 d0                	add    %edx,%eax
80102e86:	0f b6 00             	movzbl (%eax),%eax
80102e89:	0f b6 c0             	movzbl %al,%eax
80102e8c:	89 45 e8             	mov    %eax,-0x18(%ebp)
	if (shift)
80102e8f:	a1 7c e6 10 80       	mov    0x8010e67c,%eax
80102e94:	85 c0                	test   %eax,%eax
80102e96:	74 0a                	je     80102ea2 <kbdInterupt+0x130>
		shift = 0;
80102e98:	c7 05 7c e6 10 80 00 	movl   $0x0,0x8010e67c
80102e9f:	00 00 00 
	sendMessage(wndList.entry, &msg);
80102ea2:	a1 80 78 11 80       	mov    0x80117880,%eax
80102ea7:	83 ec 08             	sub    $0x8,%esp
80102eaa:	8d 55 e4             	lea    -0x1c(%ebp),%edx
80102ead:	52                   	push   %edx
80102eae:	50                   	push   %eax
80102eaf:	e8 fb 77 00 00       	call   8010a6af <sendMessage>
80102eb4:	83 c4 10             	add    $0x10,%esp

}
80102eb7:	c9                   	leave  
80102eb8:	c3                   	ret    

80102eb9 <kbdgetc>:

int
kbdgetc(void)
{
80102eb9:	55                   	push   %ebp
80102eba:	89 e5                	mov    %esp,%ebp
80102ebc:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102ebf:	6a 64                	push   $0x64
80102ec1:	e8 8f fe ff ff       	call   80102d55 <inb>
80102ec6:	83 c4 04             	add    $0x4,%esp
80102ec9:	0f b6 c0             	movzbl %al,%eax
80102ecc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102ecf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ed2:	83 e0 01             	and    $0x1,%eax
80102ed5:	85 c0                	test   %eax,%eax
80102ed7:	75 0a                	jne    80102ee3 <kbdgetc+0x2a>
    return -1;
80102ed9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102ede:	e9 23 01 00 00       	jmp    80103006 <kbdgetc+0x14d>
  data = inb(KBDATAP);
80102ee3:	6a 60                	push   $0x60
80102ee5:	e8 6b fe ff ff       	call   80102d55 <inb>
80102eea:	83 c4 04             	add    $0x4,%esp
80102eed:	0f b6 c0             	movzbl %al,%eax
80102ef0:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102ef3:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102efa:	75 17                	jne    80102f13 <kbdgetc+0x5a>
    shift |= E0ESC;
80102efc:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f01:	83 c8 40             	or     $0x40,%eax
80102f04:	a3 80 e6 10 80       	mov    %eax,0x8010e680
    return 0;
80102f09:	b8 00 00 00 00       	mov    $0x0,%eax
80102f0e:	e9 f3 00 00 00       	jmp    80103006 <kbdgetc+0x14d>
  } else if(data & 0x80){
80102f13:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f16:	25 80 00 00 00       	and    $0x80,%eax
80102f1b:	85 c0                	test   %eax,%eax
80102f1d:	74 45                	je     80102f64 <kbdgetc+0xab>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102f1f:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f24:	83 e0 40             	and    $0x40,%eax
80102f27:	85 c0                	test   %eax,%eax
80102f29:	75 08                	jne    80102f33 <kbdgetc+0x7a>
80102f2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f2e:	83 e0 7f             	and    $0x7f,%eax
80102f31:	eb 03                	jmp    80102f36 <kbdgetc+0x7d>
80102f33:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f36:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102f39:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f3c:	05 20 c0 10 80       	add    $0x8010c020,%eax
80102f41:	0f b6 00             	movzbl (%eax),%eax
80102f44:	83 c8 40             	or     $0x40,%eax
80102f47:	0f b6 c0             	movzbl %al,%eax
80102f4a:	f7 d0                	not    %eax
80102f4c:	89 c2                	mov    %eax,%edx
80102f4e:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f53:	21 d0                	and    %edx,%eax
80102f55:	a3 80 e6 10 80       	mov    %eax,0x8010e680
    return 0;
80102f5a:	b8 00 00 00 00       	mov    $0x0,%eax
80102f5f:	e9 a2 00 00 00       	jmp    80103006 <kbdgetc+0x14d>
  } else if(shift & E0ESC){
80102f64:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f69:	83 e0 40             	and    $0x40,%eax
80102f6c:	85 c0                	test   %eax,%eax
80102f6e:	74 14                	je     80102f84 <kbdgetc+0xcb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102f70:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102f77:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f7c:	83 e0 bf             	and    $0xffffffbf,%eax
80102f7f:	a3 80 e6 10 80       	mov    %eax,0x8010e680
  }

  shift |= shiftcode[data];
80102f84:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f87:	05 20 c0 10 80       	add    $0x8010c020,%eax
80102f8c:	0f b6 00             	movzbl (%eax),%eax
80102f8f:	0f b6 d0             	movzbl %al,%edx
80102f92:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f97:	09 d0                	or     %edx,%eax
80102f99:	a3 80 e6 10 80       	mov    %eax,0x8010e680
  shift ^= togglecode[data];
80102f9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102fa1:	05 20 c1 10 80       	add    $0x8010c120,%eax
80102fa6:	0f b6 00             	movzbl (%eax),%eax
80102fa9:	0f b6 d0             	movzbl %al,%edx
80102fac:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102fb1:	31 d0                	xor    %edx,%eax
80102fb3:	a3 80 e6 10 80       	mov    %eax,0x8010e680
  c = charcode[shift & (CTL | SHIFT)][data];
80102fb8:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102fbd:	83 e0 03             	and    $0x3,%eax
80102fc0:	8b 14 85 28 c7 10 80 	mov    -0x7fef38d8(,%eax,4),%edx
80102fc7:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102fca:	01 d0                	add    %edx,%eax
80102fcc:	0f b6 00             	movzbl (%eax),%eax
80102fcf:	0f b6 c0             	movzbl %al,%eax
80102fd2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102fd5:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102fda:	83 e0 08             	and    $0x8,%eax
80102fdd:	85 c0                	test   %eax,%eax
80102fdf:	74 22                	je     80103003 <kbdgetc+0x14a>
    if('a' <= c && c <= 'z')
80102fe1:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102fe5:	76 0c                	jbe    80102ff3 <kbdgetc+0x13a>
80102fe7:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102feb:	77 06                	ja     80102ff3 <kbdgetc+0x13a>
      c += 'A' - 'a';
80102fed:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102ff1:	eb 10                	jmp    80103003 <kbdgetc+0x14a>
    else if('A' <= c && c <= 'Z')
80102ff3:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102ff7:	76 0a                	jbe    80103003 <kbdgetc+0x14a>
80102ff9:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102ffd:	77 04                	ja     80103003 <kbdgetc+0x14a>
      c += 'a' - 'A';
80102fff:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  
  return c;
80103003:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103006:	c9                   	leave  
80103007:	c3                   	ret    

80103008 <kbdintr>:

void
kbdintr(void)
{
80103008:	55                   	push   %ebp
80103009:	89 e5                	mov    %esp,%ebp
8010300b:	83 ec 08             	sub    $0x8,%esp
  //consoleintr(kbdgetc);
	kbdInterupt();
8010300e:	e8 5f fd ff ff       	call   80102d72 <kbdInterupt>
}
80103013:	90                   	nop
80103014:	c9                   	leave  
80103015:	c3                   	ret    

80103016 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103016:	55                   	push   %ebp
80103017:	89 e5                	mov    %esp,%ebp
80103019:	83 ec 08             	sub    $0x8,%esp
8010301c:	8b 55 08             	mov    0x8(%ebp),%edx
8010301f:	8b 45 0c             	mov    0xc(%ebp),%eax
80103022:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103026:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103029:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010302d:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103031:	ee                   	out    %al,(%dx)
}
80103032:	90                   	nop
80103033:	c9                   	leave  
80103034:	c3                   	ret    

80103035 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80103035:	55                   	push   %ebp
80103036:	89 e5                	mov    %esp,%ebp
80103038:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010303b:	9c                   	pushf  
8010303c:	58                   	pop    %eax
8010303d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80103040:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103043:	c9                   	leave  
80103044:	c3                   	ret    

80103045 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80103045:	55                   	push   %ebp
80103046:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80103048:	a1 dc 28 11 80       	mov    0x801128dc,%eax
8010304d:	8b 55 08             	mov    0x8(%ebp),%edx
80103050:	c1 e2 02             	shl    $0x2,%edx
80103053:	01 c2                	add    %eax,%edx
80103055:	8b 45 0c             	mov    0xc(%ebp),%eax
80103058:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
8010305a:	a1 dc 28 11 80       	mov    0x801128dc,%eax
8010305f:	83 c0 20             	add    $0x20,%eax
80103062:	8b 00                	mov    (%eax),%eax
}
80103064:	90                   	nop
80103065:	5d                   	pop    %ebp
80103066:	c3                   	ret    

80103067 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80103067:	55                   	push   %ebp
80103068:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
8010306a:	a1 dc 28 11 80       	mov    0x801128dc,%eax
8010306f:	85 c0                	test   %eax,%eax
80103071:	0f 84 0b 01 00 00    	je     80103182 <lapicinit+0x11b>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80103077:	68 3f 01 00 00       	push   $0x13f
8010307c:	6a 3c                	push   $0x3c
8010307e:	e8 c2 ff ff ff       	call   80103045 <lapicw>
80103083:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80103086:	6a 0b                	push   $0xb
80103088:	68 f8 00 00 00       	push   $0xf8
8010308d:	e8 b3 ff ff ff       	call   80103045 <lapicw>
80103092:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80103095:	68 20 00 02 00       	push   $0x20020
8010309a:	68 c8 00 00 00       	push   $0xc8
8010309f:	e8 a1 ff ff ff       	call   80103045 <lapicw>
801030a4:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000); 
801030a7:	68 80 96 98 00       	push   $0x989680
801030ac:	68 e0 00 00 00       	push   $0xe0
801030b1:	e8 8f ff ff ff       	call   80103045 <lapicw>
801030b6:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
801030b9:	68 00 00 01 00       	push   $0x10000
801030be:	68 d4 00 00 00       	push   $0xd4
801030c3:	e8 7d ff ff ff       	call   80103045 <lapicw>
801030c8:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
801030cb:	68 00 00 01 00       	push   $0x10000
801030d0:	68 d8 00 00 00       	push   $0xd8
801030d5:	e8 6b ff ff ff       	call   80103045 <lapicw>
801030da:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801030dd:	a1 dc 28 11 80       	mov    0x801128dc,%eax
801030e2:	83 c0 30             	add    $0x30,%eax
801030e5:	8b 00                	mov    (%eax),%eax
801030e7:	c1 e8 10             	shr    $0x10,%eax
801030ea:	0f b6 c0             	movzbl %al,%eax
801030ed:	83 f8 03             	cmp    $0x3,%eax
801030f0:	76 12                	jbe    80103104 <lapicinit+0x9d>
    lapicw(PCINT, MASKED);
801030f2:	68 00 00 01 00       	push   $0x10000
801030f7:	68 d0 00 00 00       	push   $0xd0
801030fc:	e8 44 ff ff ff       	call   80103045 <lapicw>
80103101:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80103104:	6a 33                	push   $0x33
80103106:	68 dc 00 00 00       	push   $0xdc
8010310b:	e8 35 ff ff ff       	call   80103045 <lapicw>
80103110:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80103113:	6a 00                	push   $0x0
80103115:	68 a0 00 00 00       	push   $0xa0
8010311a:	e8 26 ff ff ff       	call   80103045 <lapicw>
8010311f:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80103122:	6a 00                	push   $0x0
80103124:	68 a0 00 00 00       	push   $0xa0
80103129:	e8 17 ff ff ff       	call   80103045 <lapicw>
8010312e:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80103131:	6a 00                	push   $0x0
80103133:	6a 2c                	push   $0x2c
80103135:	e8 0b ff ff ff       	call   80103045 <lapicw>
8010313a:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
8010313d:	6a 00                	push   $0x0
8010313f:	68 c4 00 00 00       	push   $0xc4
80103144:	e8 fc fe ff ff       	call   80103045 <lapicw>
80103149:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
8010314c:	68 00 85 08 00       	push   $0x88500
80103151:	68 c0 00 00 00       	push   $0xc0
80103156:	e8 ea fe ff ff       	call   80103045 <lapicw>
8010315b:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
8010315e:	90                   	nop
8010315f:	a1 dc 28 11 80       	mov    0x801128dc,%eax
80103164:	05 00 03 00 00       	add    $0x300,%eax
80103169:	8b 00                	mov    (%eax),%eax
8010316b:	25 00 10 00 00       	and    $0x1000,%eax
80103170:	85 c0                	test   %eax,%eax
80103172:	75 eb                	jne    8010315f <lapicinit+0xf8>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80103174:	6a 00                	push   $0x0
80103176:	6a 20                	push   $0x20
80103178:	e8 c8 fe ff ff       	call   80103045 <lapicw>
8010317d:	83 c4 08             	add    $0x8,%esp
80103180:	eb 01                	jmp    80103183 <lapicinit+0x11c>

void
lapicinit(void)
{
  if(!lapic) 
    return;
80103182:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80103183:	c9                   	leave  
80103184:	c3                   	ret    

80103185 <cpunum>:

int
cpunum(void)
{
80103185:	55                   	push   %ebp
80103186:	89 e5                	mov    %esp,%ebp
80103188:	83 ec 08             	sub    $0x8,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
8010318b:	e8 a5 fe ff ff       	call   80103035 <readeflags>
80103190:	25 00 02 00 00       	and    $0x200,%eax
80103195:	85 c0                	test   %eax,%eax
80103197:	74 26                	je     801031bf <cpunum+0x3a>
    static int n;
    if(n++ == 0)
80103199:	a1 84 e6 10 80       	mov    0x8010e684,%eax
8010319e:	8d 50 01             	lea    0x1(%eax),%edx
801031a1:	89 15 84 e6 10 80    	mov    %edx,0x8010e684
801031a7:	85 c0                	test   %eax,%eax
801031a9:	75 14                	jne    801031bf <cpunum+0x3a>
      cprintf("cpu called from %x with interrupts enabled\n",
801031ab:	8b 45 04             	mov    0x4(%ebp),%eax
801031ae:	83 ec 08             	sub    $0x8,%esp
801031b1:	50                   	push   %eax
801031b2:	68 ec b5 10 80       	push   $0x8010b5ec
801031b7:	e8 0a d2 ff ff       	call   801003c6 <cprintf>
801031bc:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
801031bf:	a1 dc 28 11 80       	mov    0x801128dc,%eax
801031c4:	85 c0                	test   %eax,%eax
801031c6:	74 0f                	je     801031d7 <cpunum+0x52>
    return lapic[ID]>>24;
801031c8:	a1 dc 28 11 80       	mov    0x801128dc,%eax
801031cd:	83 c0 20             	add    $0x20,%eax
801031d0:	8b 00                	mov    (%eax),%eax
801031d2:	c1 e8 18             	shr    $0x18,%eax
801031d5:	eb 05                	jmp    801031dc <cpunum+0x57>
  return 0;
801031d7:	b8 00 00 00 00       	mov    $0x0,%eax
}
801031dc:	c9                   	leave  
801031dd:	c3                   	ret    

801031de <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
801031de:	55                   	push   %ebp
801031df:	89 e5                	mov    %esp,%ebp
  if(lapic)
801031e1:	a1 dc 28 11 80       	mov    0x801128dc,%eax
801031e6:	85 c0                	test   %eax,%eax
801031e8:	74 0c                	je     801031f6 <lapiceoi+0x18>
    lapicw(EOI, 0);
801031ea:	6a 00                	push   $0x0
801031ec:	6a 2c                	push   $0x2c
801031ee:	e8 52 fe ff ff       	call   80103045 <lapicw>
801031f3:	83 c4 08             	add    $0x8,%esp
}
801031f6:	90                   	nop
801031f7:	c9                   	leave  
801031f8:	c3                   	ret    

801031f9 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801031f9:	55                   	push   %ebp
801031fa:	89 e5                	mov    %esp,%ebp
}
801031fc:	90                   	nop
801031fd:	5d                   	pop    %ebp
801031fe:	c3                   	ret    

801031ff <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801031ff:	55                   	push   %ebp
80103200:	89 e5                	mov    %esp,%ebp
80103202:	83 ec 14             	sub    $0x14,%esp
80103205:	8b 45 08             	mov    0x8(%ebp),%eax
80103208:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
8010320b:	6a 0f                	push   $0xf
8010320d:	6a 70                	push   $0x70
8010320f:	e8 02 fe ff ff       	call   80103016 <outb>
80103214:	83 c4 08             	add    $0x8,%esp
  outb(IO_RTC+1, 0x0A);
80103217:	6a 0a                	push   $0xa
80103219:	6a 71                	push   $0x71
8010321b:	e8 f6 fd ff ff       	call   80103016 <outb>
80103220:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80103223:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
8010322a:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010322d:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80103232:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103235:	83 c0 02             	add    $0x2,%eax
80103238:	8b 55 0c             	mov    0xc(%ebp),%edx
8010323b:	c1 ea 04             	shr    $0x4,%edx
8010323e:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103241:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103245:	c1 e0 18             	shl    $0x18,%eax
80103248:	50                   	push   %eax
80103249:	68 c4 00 00 00       	push   $0xc4
8010324e:	e8 f2 fd ff ff       	call   80103045 <lapicw>
80103253:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80103256:	68 00 c5 00 00       	push   $0xc500
8010325b:	68 c0 00 00 00       	push   $0xc0
80103260:	e8 e0 fd ff ff       	call   80103045 <lapicw>
80103265:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80103268:	68 c8 00 00 00       	push   $0xc8
8010326d:	e8 87 ff ff ff       	call   801031f9 <microdelay>
80103272:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
80103275:	68 00 85 00 00       	push   $0x8500
8010327a:	68 c0 00 00 00       	push   $0xc0
8010327f:	e8 c1 fd ff ff       	call   80103045 <lapicw>
80103284:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80103287:	6a 64                	push   $0x64
80103289:	e8 6b ff ff ff       	call   801031f9 <microdelay>
8010328e:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80103291:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103298:	eb 3d                	jmp    801032d7 <lapicstartap+0xd8>
    lapicw(ICRHI, apicid<<24);
8010329a:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
8010329e:	c1 e0 18             	shl    $0x18,%eax
801032a1:	50                   	push   %eax
801032a2:	68 c4 00 00 00       	push   $0xc4
801032a7:	e8 99 fd ff ff       	call   80103045 <lapicw>
801032ac:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
801032af:	8b 45 0c             	mov    0xc(%ebp),%eax
801032b2:	c1 e8 0c             	shr    $0xc,%eax
801032b5:	80 cc 06             	or     $0x6,%ah
801032b8:	50                   	push   %eax
801032b9:	68 c0 00 00 00       	push   $0xc0
801032be:	e8 82 fd ff ff       	call   80103045 <lapicw>
801032c3:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
801032c6:	68 c8 00 00 00       	push   $0xc8
801032cb:	e8 29 ff ff ff       	call   801031f9 <microdelay>
801032d0:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801032d3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801032d7:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
801032db:	7e bd                	jle    8010329a <lapicstartap+0x9b>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801032dd:	90                   	nop
801032de:	c9                   	leave  
801032df:	c3                   	ret    

801032e0 <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
801032e0:	55                   	push   %ebp
801032e1:	89 e5                	mov    %esp,%ebp
801032e3:	83 ec 18             	sub    $0x18,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
801032e6:	83 ec 08             	sub    $0x8,%esp
801032e9:	68 18 b6 10 80       	push   $0x8010b618
801032ee:	68 e0 28 11 80       	push   $0x801128e0
801032f3:	e8 46 1b 00 00       	call   80104e3e <initlock>
801032f8:	83 c4 10             	add    $0x10,%esp
  readsb(ROOTDEV, &sb);
801032fb:	83 ec 08             	sub    $0x8,%esp
801032fe:	8d 45 e8             	lea    -0x18(%ebp),%eax
80103301:	50                   	push   %eax
80103302:	6a 01                	push   $0x1
80103304:	e8 4c e0 ff ff       	call   80101355 <readsb>
80103309:	83 c4 10             	add    $0x10,%esp
  log.start = sb.size - sb.nlog;
8010330c:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010330f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103312:	29 c2                	sub    %eax,%edx
80103314:	89 d0                	mov    %edx,%eax
80103316:	a3 14 29 11 80       	mov    %eax,0x80112914
  log.size = sb.nlog;
8010331b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010331e:	a3 18 29 11 80       	mov    %eax,0x80112918
  log.dev = ROOTDEV;
80103323:	c7 05 20 29 11 80 01 	movl   $0x1,0x80112920
8010332a:	00 00 00 
  recover_from_log();
8010332d:	e8 b2 01 00 00       	call   801034e4 <recover_from_log>
}
80103332:	90                   	nop
80103333:	c9                   	leave  
80103334:	c3                   	ret    

80103335 <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
80103335:	55                   	push   %ebp
80103336:	89 e5                	mov    %esp,%ebp
80103338:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010333b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103342:	e9 95 00 00 00       	jmp    801033dc <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103347:	8b 15 14 29 11 80    	mov    0x80112914,%edx
8010334d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103350:	01 d0                	add    %edx,%eax
80103352:	83 c0 01             	add    $0x1,%eax
80103355:	89 c2                	mov    %eax,%edx
80103357:	a1 20 29 11 80       	mov    0x80112920,%eax
8010335c:	83 ec 08             	sub    $0x8,%esp
8010335f:	52                   	push   %edx
80103360:	50                   	push   %eax
80103361:	e8 50 ce ff ff       	call   801001b6 <bread>
80103366:	83 c4 10             	add    $0x10,%esp
80103369:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
8010336c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010336f:	83 c0 10             	add    $0x10,%eax
80103372:	8b 04 85 e8 28 11 80 	mov    -0x7feed718(,%eax,4),%eax
80103379:	89 c2                	mov    %eax,%edx
8010337b:	a1 20 29 11 80       	mov    0x80112920,%eax
80103380:	83 ec 08             	sub    $0x8,%esp
80103383:	52                   	push   %edx
80103384:	50                   	push   %eax
80103385:	e8 2c ce ff ff       	call   801001b6 <bread>
8010338a:	83 c4 10             	add    $0x10,%esp
8010338d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103390:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103393:	8d 50 18             	lea    0x18(%eax),%edx
80103396:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103399:	83 c0 18             	add    $0x18,%eax
8010339c:	83 ec 04             	sub    $0x4,%esp
8010339f:	68 00 02 00 00       	push   $0x200
801033a4:	52                   	push   %edx
801033a5:	50                   	push   %eax
801033a6:	e8 d7 1d 00 00       	call   80105182 <memmove>
801033ab:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
801033ae:	83 ec 0c             	sub    $0xc,%esp
801033b1:	ff 75 ec             	pushl  -0x14(%ebp)
801033b4:	e8 36 ce ff ff       	call   801001ef <bwrite>
801033b9:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf); 
801033bc:	83 ec 0c             	sub    $0xc,%esp
801033bf:	ff 75 f0             	pushl  -0x10(%ebp)
801033c2:	e8 67 ce ff ff       	call   8010022e <brelse>
801033c7:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
801033ca:	83 ec 0c             	sub    $0xc,%esp
801033cd:	ff 75 ec             	pushl  -0x14(%ebp)
801033d0:	e8 59 ce ff ff       	call   8010022e <brelse>
801033d5:	83 c4 10             	add    $0x10,%esp
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801033d8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801033dc:	a1 24 29 11 80       	mov    0x80112924,%eax
801033e1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801033e4:	0f 8f 5d ff ff ff    	jg     80103347 <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
801033ea:	90                   	nop
801033eb:	c9                   	leave  
801033ec:	c3                   	ret    

801033ed <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
801033ed:	55                   	push   %ebp
801033ee:	89 e5                	mov    %esp,%ebp
801033f0:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
801033f3:	a1 14 29 11 80       	mov    0x80112914,%eax
801033f8:	89 c2                	mov    %eax,%edx
801033fa:	a1 20 29 11 80       	mov    0x80112920,%eax
801033ff:	83 ec 08             	sub    $0x8,%esp
80103402:	52                   	push   %edx
80103403:	50                   	push   %eax
80103404:	e8 ad cd ff ff       	call   801001b6 <bread>
80103409:	83 c4 10             	add    $0x10,%esp
8010340c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
8010340f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103412:	83 c0 18             	add    $0x18,%eax
80103415:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
80103418:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010341b:	8b 00                	mov    (%eax),%eax
8010341d:	a3 24 29 11 80       	mov    %eax,0x80112924
  for (i = 0; i < log.lh.n; i++) {
80103422:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103429:	eb 1b                	jmp    80103446 <read_head+0x59>
    log.lh.sector[i] = lh->sector[i];
8010342b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010342e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103431:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103435:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103438:	83 c2 10             	add    $0x10,%edx
8010343b:	89 04 95 e8 28 11 80 	mov    %eax,-0x7feed718(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80103442:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103446:	a1 24 29 11 80       	mov    0x80112924,%eax
8010344b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010344e:	7f db                	jg     8010342b <read_head+0x3e>
    log.lh.sector[i] = lh->sector[i];
  }
  brelse(buf);
80103450:	83 ec 0c             	sub    $0xc,%esp
80103453:	ff 75 f0             	pushl  -0x10(%ebp)
80103456:	e8 d3 cd ff ff       	call   8010022e <brelse>
8010345b:	83 c4 10             	add    $0x10,%esp
}
8010345e:	90                   	nop
8010345f:	c9                   	leave  
80103460:	c3                   	ret    

80103461 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103461:	55                   	push   %ebp
80103462:	89 e5                	mov    %esp,%ebp
80103464:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103467:	a1 14 29 11 80       	mov    0x80112914,%eax
8010346c:	89 c2                	mov    %eax,%edx
8010346e:	a1 20 29 11 80       	mov    0x80112920,%eax
80103473:	83 ec 08             	sub    $0x8,%esp
80103476:	52                   	push   %edx
80103477:	50                   	push   %eax
80103478:	e8 39 cd ff ff       	call   801001b6 <bread>
8010347d:	83 c4 10             	add    $0x10,%esp
80103480:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
80103483:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103486:	83 c0 18             	add    $0x18,%eax
80103489:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
8010348c:	8b 15 24 29 11 80    	mov    0x80112924,%edx
80103492:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103495:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103497:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010349e:	eb 1b                	jmp    801034bb <write_head+0x5a>
    hb->sector[i] = log.lh.sector[i];
801034a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801034a3:	83 c0 10             	add    $0x10,%eax
801034a6:	8b 0c 85 e8 28 11 80 	mov    -0x7feed718(,%eax,4),%ecx
801034ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801034b3:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801034b7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801034bb:	a1 24 29 11 80       	mov    0x80112924,%eax
801034c0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801034c3:	7f db                	jg     801034a0 <write_head+0x3f>
    hb->sector[i] = log.lh.sector[i];
  }
  bwrite(buf);
801034c5:	83 ec 0c             	sub    $0xc,%esp
801034c8:	ff 75 f0             	pushl  -0x10(%ebp)
801034cb:	e8 1f cd ff ff       	call   801001ef <bwrite>
801034d0:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
801034d3:	83 ec 0c             	sub    $0xc,%esp
801034d6:	ff 75 f0             	pushl  -0x10(%ebp)
801034d9:	e8 50 cd ff ff       	call   8010022e <brelse>
801034de:	83 c4 10             	add    $0x10,%esp
}
801034e1:	90                   	nop
801034e2:	c9                   	leave  
801034e3:	c3                   	ret    

801034e4 <recover_from_log>:

static void
recover_from_log(void)
{
801034e4:	55                   	push   %ebp
801034e5:	89 e5                	mov    %esp,%ebp
801034e7:	83 ec 08             	sub    $0x8,%esp
  read_head();      
801034ea:	e8 fe fe ff ff       	call   801033ed <read_head>
  install_trans(); // if committed, copy from log to disk
801034ef:	e8 41 fe ff ff       	call   80103335 <install_trans>
  log.lh.n = 0;
801034f4:	c7 05 24 29 11 80 00 	movl   $0x0,0x80112924
801034fb:	00 00 00 
  write_head(); // clear the log
801034fe:	e8 5e ff ff ff       	call   80103461 <write_head>
}
80103503:	90                   	nop
80103504:	c9                   	leave  
80103505:	c3                   	ret    

80103506 <begin_trans>:

void
begin_trans(void)
{
80103506:	55                   	push   %ebp
80103507:	89 e5                	mov    %esp,%ebp
80103509:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
8010350c:	83 ec 0c             	sub    $0xc,%esp
8010350f:	68 e0 28 11 80       	push   $0x801128e0
80103514:	e8 47 19 00 00       	call   80104e60 <acquire>
80103519:	83 c4 10             	add    $0x10,%esp
  while (log.busy) {
8010351c:	eb 15                	jmp    80103533 <begin_trans+0x2d>
    sleep(&log, &log.lock);
8010351e:	83 ec 08             	sub    $0x8,%esp
80103521:	68 e0 28 11 80       	push   $0x801128e0
80103526:	68 e0 28 11 80       	push   $0x801128e0
8010352b:	e8 37 16 00 00       	call   80104b67 <sleep>
80103530:	83 c4 10             	add    $0x10,%esp

void
begin_trans(void)
{
  acquire(&log.lock);
  while (log.busy) {
80103533:	a1 1c 29 11 80       	mov    0x8011291c,%eax
80103538:	85 c0                	test   %eax,%eax
8010353a:	75 e2                	jne    8010351e <begin_trans+0x18>
    sleep(&log, &log.lock);
  }
  log.busy = 1;
8010353c:	c7 05 1c 29 11 80 01 	movl   $0x1,0x8011291c
80103543:	00 00 00 
  release(&log.lock);
80103546:	83 ec 0c             	sub    $0xc,%esp
80103549:	68 e0 28 11 80       	push   $0x801128e0
8010354e:	e8 74 19 00 00       	call   80104ec7 <release>
80103553:	83 c4 10             	add    $0x10,%esp
}
80103556:	90                   	nop
80103557:	c9                   	leave  
80103558:	c3                   	ret    

80103559 <commit_trans>:

void
commit_trans(void)
{
80103559:	55                   	push   %ebp
8010355a:	89 e5                	mov    %esp,%ebp
8010355c:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
8010355f:	a1 24 29 11 80       	mov    0x80112924,%eax
80103564:	85 c0                	test   %eax,%eax
80103566:	7e 19                	jle    80103581 <commit_trans+0x28>
    write_head();    // Write header to disk -- the real commit
80103568:	e8 f4 fe ff ff       	call   80103461 <write_head>
    install_trans(); // Now install writes to home locations
8010356d:	e8 c3 fd ff ff       	call   80103335 <install_trans>
    log.lh.n = 0; 
80103572:	c7 05 24 29 11 80 00 	movl   $0x0,0x80112924
80103579:	00 00 00 
    write_head();    // Erase the transaction from the log
8010357c:	e8 e0 fe ff ff       	call   80103461 <write_head>
  }
  
  acquire(&log.lock);
80103581:	83 ec 0c             	sub    $0xc,%esp
80103584:	68 e0 28 11 80       	push   $0x801128e0
80103589:	e8 d2 18 00 00       	call   80104e60 <acquire>
8010358e:	83 c4 10             	add    $0x10,%esp
  log.busy = 0;
80103591:	c7 05 1c 29 11 80 00 	movl   $0x0,0x8011291c
80103598:	00 00 00 
  wakeup(&log);
8010359b:	83 ec 0c             	sub    $0xc,%esp
8010359e:	68 e0 28 11 80       	push   $0x801128e0
801035a3:	e8 aa 16 00 00       	call   80104c52 <wakeup>
801035a8:	83 c4 10             	add    $0x10,%esp
  release(&log.lock);
801035ab:	83 ec 0c             	sub    $0xc,%esp
801035ae:	68 e0 28 11 80       	push   $0x801128e0
801035b3:	e8 0f 19 00 00       	call   80104ec7 <release>
801035b8:	83 c4 10             	add    $0x10,%esp
}
801035bb:	90                   	nop
801035bc:	c9                   	leave  
801035bd:	c3                   	ret    

801035be <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801035be:	55                   	push   %ebp
801035bf:	89 e5                	mov    %esp,%ebp
801035c1:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801035c4:	a1 24 29 11 80       	mov    0x80112924,%eax
801035c9:	83 f8 09             	cmp    $0x9,%eax
801035cc:	7f 12                	jg     801035e0 <log_write+0x22>
801035ce:	a1 24 29 11 80       	mov    0x80112924,%eax
801035d3:	8b 15 18 29 11 80    	mov    0x80112918,%edx
801035d9:	83 ea 01             	sub    $0x1,%edx
801035dc:	39 d0                	cmp    %edx,%eax
801035de:	7c 2a                	jl     8010360a <log_write+0x4c>
  {
      cprintf("%d %d\n", log.lh.n, log.size);
801035e0:	8b 15 18 29 11 80    	mov    0x80112918,%edx
801035e6:	a1 24 29 11 80       	mov    0x80112924,%eax
801035eb:	83 ec 04             	sub    $0x4,%esp
801035ee:	52                   	push   %edx
801035ef:	50                   	push   %eax
801035f0:	68 1c b6 10 80       	push   $0x8010b61c
801035f5:	e8 cc cd ff ff       	call   801003c6 <cprintf>
801035fa:	83 c4 10             	add    $0x10,%esp
      panic("too big a transaction");
801035fd:	83 ec 0c             	sub    $0xc,%esp
80103600:	68 23 b6 10 80       	push   $0x8010b623
80103605:	e8 5c cf ff ff       	call   80100566 <panic>
  }
  if (!log.busy)
8010360a:	a1 1c 29 11 80       	mov    0x8011291c,%eax
8010360f:	85 c0                	test   %eax,%eax
80103611:	75 0d                	jne    80103620 <log_write+0x62>
    panic("write outside of trans");
80103613:	83 ec 0c             	sub    $0xc,%esp
80103616:	68 39 b6 10 80       	push   $0x8010b639
8010361b:	e8 46 cf ff ff       	call   80100566 <panic>

  for (i = 0; i < log.lh.n; i++) {
80103620:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103627:	eb 1d                	jmp    80103646 <log_write+0x88>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
80103629:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010362c:	83 c0 10             	add    $0x10,%eax
8010362f:	8b 04 85 e8 28 11 80 	mov    -0x7feed718(,%eax,4),%eax
80103636:	89 c2                	mov    %eax,%edx
80103638:	8b 45 08             	mov    0x8(%ebp),%eax
8010363b:	8b 40 08             	mov    0x8(%eax),%eax
8010363e:	39 c2                	cmp    %eax,%edx
80103640:	74 10                	je     80103652 <log_write+0x94>
      panic("too big a transaction");
  }
  if (!log.busy)
    panic("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
80103642:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103646:	a1 24 29 11 80       	mov    0x80112924,%eax
8010364b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010364e:	7f d9                	jg     80103629 <log_write+0x6b>
80103650:	eb 01                	jmp    80103653 <log_write+0x95>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
      break;
80103652:	90                   	nop
  }
  log.lh.sector[i] = b->sector;
80103653:	8b 45 08             	mov    0x8(%ebp),%eax
80103656:	8b 40 08             	mov    0x8(%eax),%eax
80103659:	89 c2                	mov    %eax,%edx
8010365b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010365e:	83 c0 10             	add    $0x10,%eax
80103661:	89 14 85 e8 28 11 80 	mov    %edx,-0x7feed718(,%eax,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
80103668:	8b 15 14 29 11 80    	mov    0x80112914,%edx
8010366e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103671:	01 d0                	add    %edx,%eax
80103673:	83 c0 01             	add    $0x1,%eax
80103676:	89 c2                	mov    %eax,%edx
80103678:	8b 45 08             	mov    0x8(%ebp),%eax
8010367b:	8b 40 04             	mov    0x4(%eax),%eax
8010367e:	83 ec 08             	sub    $0x8,%esp
80103681:	52                   	push   %edx
80103682:	50                   	push   %eax
80103683:	e8 2e cb ff ff       	call   801001b6 <bread>
80103688:	83 c4 10             	add    $0x10,%esp
8010368b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(lbuf->data, b->data, BSIZE);
8010368e:	8b 45 08             	mov    0x8(%ebp),%eax
80103691:	8d 50 18             	lea    0x18(%eax),%edx
80103694:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103697:	83 c0 18             	add    $0x18,%eax
8010369a:	83 ec 04             	sub    $0x4,%esp
8010369d:	68 00 02 00 00       	push   $0x200
801036a2:	52                   	push   %edx
801036a3:	50                   	push   %eax
801036a4:	e8 d9 1a 00 00       	call   80105182 <memmove>
801036a9:	83 c4 10             	add    $0x10,%esp
  bwrite(lbuf);
801036ac:	83 ec 0c             	sub    $0xc,%esp
801036af:	ff 75 f0             	pushl  -0x10(%ebp)
801036b2:	e8 38 cb ff ff       	call   801001ef <bwrite>
801036b7:	83 c4 10             	add    $0x10,%esp
  brelse(lbuf);
801036ba:	83 ec 0c             	sub    $0xc,%esp
801036bd:	ff 75 f0             	pushl  -0x10(%ebp)
801036c0:	e8 69 cb ff ff       	call   8010022e <brelse>
801036c5:	83 c4 10             	add    $0x10,%esp
  if (i == log.lh.n)
801036c8:	a1 24 29 11 80       	mov    0x80112924,%eax
801036cd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801036d0:	75 0d                	jne    801036df <log_write+0x121>
    log.lh.n++;
801036d2:	a1 24 29 11 80       	mov    0x80112924,%eax
801036d7:	83 c0 01             	add    $0x1,%eax
801036da:	a3 24 29 11 80       	mov    %eax,0x80112924
  b->flags |= B_DIRTY; // XXX prevent eviction
801036df:	8b 45 08             	mov    0x8(%ebp),%eax
801036e2:	8b 00                	mov    (%eax),%eax
801036e4:	83 c8 04             	or     $0x4,%eax
801036e7:	89 c2                	mov    %eax,%edx
801036e9:	8b 45 08             	mov    0x8(%ebp),%eax
801036ec:	89 10                	mov    %edx,(%eax)
}
801036ee:	90                   	nop
801036ef:	c9                   	leave  
801036f0:	c3                   	ret    

801036f1 <v2p>:
801036f1:	55                   	push   %ebp
801036f2:	89 e5                	mov    %esp,%ebp
801036f4:	8b 45 08             	mov    0x8(%ebp),%eax
801036f7:	05 00 00 00 80       	add    $0x80000000,%eax
801036fc:	5d                   	pop    %ebp
801036fd:	c3                   	ret    

801036fe <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801036fe:	55                   	push   %ebp
801036ff:	89 e5                	mov    %esp,%ebp
80103701:	8b 45 08             	mov    0x8(%ebp),%eax
80103704:	05 00 00 00 80       	add    $0x80000000,%eax
80103709:	5d                   	pop    %ebp
8010370a:	c3                   	ret    

8010370b <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
8010370b:	55                   	push   %ebp
8010370c:	89 e5                	mov    %esp,%ebp
8010370e:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103711:	8b 55 08             	mov    0x8(%ebp),%edx
80103714:	8b 45 0c             	mov    0xc(%ebp),%eax
80103717:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010371a:	f0 87 02             	lock xchg %eax,(%edx)
8010371d:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80103720:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103723:	c9                   	leave  
80103724:	c3                   	ret    

80103725 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103725:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103729:	83 e4 f0             	and    $0xfffffff0,%esp
8010372c:	ff 71 fc             	pushl  -0x4(%ecx)
8010372f:	55                   	push   %ebp
80103730:	89 e5                	mov    %esp,%ebp
80103732:	51                   	push   %ecx
80103733:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103736:	83 ec 08             	sub    $0x8,%esp
80103739:	68 00 00 40 80       	push   $0x80400000
8010373e:	68 e0 ba 15 80       	push   $0x8015bae0
80103743:	e8 81 f4 ff ff       	call   80102bc9 <kinit1>
80103748:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
8010374b:	e8 97 44 00 00       	call   80107be7 <kvmalloc>
  mpinit();        // collect info about this machine
80103750:	e8 4d 04 00 00       	call   80103ba2 <mpinit>
  lapicinit();
80103755:	e8 0d f9 ff ff       	call   80103067 <lapicinit>
  seginit();       // set up segments
8010375a:	e8 31 3e 00 00       	call   80107590 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
8010375f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103765:	0f b6 00             	movzbl (%eax),%eax
80103768:	0f b6 c0             	movzbl %al,%eax
8010376b:	83 ec 08             	sub    $0x8,%esp
8010376e:	50                   	push   %eax
8010376f:	68 50 b6 10 80       	push   $0x8010b650
80103774:	e8 4d cc ff ff       	call   801003c6 <cprintf>
80103779:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
8010377c:	e8 77 06 00 00       	call   80103df8 <picinit>
  ioapicinit();    // another interrupt controller
80103781:	e8 38 f3 ff ff       	call   80102abe <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
80103786:	e8 5e d3 ff ff       	call   80100ae9 <consoleinit>
  uartinit();      // serial port
8010378b:	e8 5c 31 00 00       	call   801068ec <uartinit>
  pinit();         // process table
80103790:	e8 60 0b 00 00       	call   801042f5 <pinit>
  tvinit();        // trap vectors
80103795:	e8 17 2d 00 00       	call   801064b1 <tvinit>
  binit();         // buffer cache
8010379a:	e8 95 c8 ff ff       	call   80100034 <binit>
  fileinit();      // file table
8010379f:	e8 a2 d7 ff ff       	call   80100f46 <fileinit>
  iinit();         // inode cache
801037a4:	e8 7b de ff ff       	call   80101624 <iinit>
  ideinit();       // disk
801037a9:	e8 54 ef ff ff       	call   80102702 <ideinit>
  if(!ismp)
801037ae:	a1 64 29 11 80       	mov    0x80112964,%eax
801037b3:	85 c0                	test   %eax,%eax
801037b5:	75 05                	jne    801037bc <main+0x97>
    timerinit();   // uniprocessor timer
801037b7:	e8 52 2c 00 00       	call   8010640e <timerinit>
  startothers();   // start other processors
801037bc:	e8 84 00 00 00       	call   80103845 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801037c1:	83 ec 08             	sub    $0x8,%esp
801037c4:	68 00 00 00 8e       	push   $0x8e000000
801037c9:	68 00 00 40 80       	push   $0x80400000
801037ce:	e8 2f f4 ff ff       	call   80102c02 <kinit2>
801037d3:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
801037d6:	e8 3e 0c 00 00       	call   80104419 <userinit>
    
  //InitHandle();
  APGuiInit();
801037db:	e8 47 65 00 00       	call   80109d27 <APGuiInit>
    
  // Finish setting up this processor in mpmain.
  mpmain();
801037e0:	e8 1a 00 00 00       	call   801037ff <mpmain>

801037e5 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801037e5:	55                   	push   %ebp
801037e6:	89 e5                	mov    %esp,%ebp
801037e8:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
801037eb:	e8 0f 44 00 00       	call   80107bff <switchkvm>
  seginit();
801037f0:	e8 9b 3d 00 00       	call   80107590 <seginit>
  lapicinit();
801037f5:	e8 6d f8 ff ff       	call   80103067 <lapicinit>
  mpmain();
801037fa:	e8 00 00 00 00       	call   801037ff <mpmain>

801037ff <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801037ff:	55                   	push   %ebp
80103800:	89 e5                	mov    %esp,%ebp
80103802:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
80103805:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010380b:	0f b6 00             	movzbl (%eax),%eax
8010380e:	0f b6 c0             	movzbl %al,%eax
80103811:	83 ec 08             	sub    $0x8,%esp
80103814:	50                   	push   %eax
80103815:	68 67 b6 10 80       	push   $0x8010b667
8010381a:	e8 a7 cb ff ff       	call   801003c6 <cprintf>
8010381f:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
80103822:	e8 00 2e 00 00       	call   80106627 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103827:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010382d:	05 a8 00 00 00       	add    $0xa8,%eax
80103832:	83 ec 08             	sub    $0x8,%esp
80103835:	6a 01                	push   $0x1
80103837:	50                   	push   %eax
80103838:	e8 ce fe ff ff       	call   8010370b <xchg>
8010383d:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
80103840:	e8 55 11 00 00       	call   8010499a <scheduler>

80103845 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103845:	55                   	push   %ebp
80103846:	89 e5                	mov    %esp,%ebp
80103848:	53                   	push   %ebx
80103849:	83 ec 14             	sub    $0x14,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
8010384c:	68 00 70 00 00       	push   $0x7000
80103851:	e8 a8 fe ff ff       	call   801036fe <p2v>
80103856:	83 c4 04             	add    $0x4,%esp
80103859:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
8010385c:	b8 8a 00 00 00       	mov    $0x8a,%eax
80103861:	83 ec 04             	sub    $0x4,%esp
80103864:	50                   	push   %eax
80103865:	68 3c e5 10 80       	push   $0x8010e53c
8010386a:	ff 75 f0             	pushl  -0x10(%ebp)
8010386d:	e8 10 19 00 00       	call   80105182 <memmove>
80103872:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80103875:	c7 45 f4 80 29 11 80 	movl   $0x80112980,-0xc(%ebp)
8010387c:	e9 90 00 00 00       	jmp    80103911 <startothers+0xcc>
    if(c == cpus+cpunum())  // We've started already.
80103881:	e8 ff f8 ff ff       	call   80103185 <cpunum>
80103886:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010388c:	05 80 29 11 80       	add    $0x80112980,%eax
80103891:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103894:	74 73                	je     80103909 <startothers+0xc4>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103896:	e8 65 f4 ff ff       	call   80102d00 <kalloc>
8010389b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
8010389e:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038a1:	83 e8 04             	sub    $0x4,%eax
801038a4:	8b 55 ec             	mov    -0x14(%ebp),%edx
801038a7:	81 c2 00 10 00 00    	add    $0x1000,%edx
801038ad:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
801038af:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038b2:	83 e8 08             	sub    $0x8,%eax
801038b5:	c7 00 e5 37 10 80    	movl   $0x801037e5,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
801038bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038be:	8d 58 f4             	lea    -0xc(%eax),%ebx
801038c1:	83 ec 0c             	sub    $0xc,%esp
801038c4:	68 00 d0 10 80       	push   $0x8010d000
801038c9:	e8 23 fe ff ff       	call   801036f1 <v2p>
801038ce:	83 c4 10             	add    $0x10,%esp
801038d1:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
801038d3:	83 ec 0c             	sub    $0xc,%esp
801038d6:	ff 75 f0             	pushl  -0x10(%ebp)
801038d9:	e8 13 fe ff ff       	call   801036f1 <v2p>
801038de:	83 c4 10             	add    $0x10,%esp
801038e1:	89 c2                	mov    %eax,%edx
801038e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038e6:	0f b6 00             	movzbl (%eax),%eax
801038e9:	0f b6 c0             	movzbl %al,%eax
801038ec:	83 ec 08             	sub    $0x8,%esp
801038ef:	52                   	push   %edx
801038f0:	50                   	push   %eax
801038f1:	e8 09 f9 ff ff       	call   801031ff <lapicstartap>
801038f6:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801038f9:	90                   	nop
801038fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038fd:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103903:	85 c0                	test   %eax,%eax
80103905:	74 f3                	je     801038fa <startothers+0xb5>
80103907:	eb 01                	jmp    8010390a <startothers+0xc5>
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
80103909:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010390a:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103911:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103916:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010391c:	05 80 29 11 80       	add    $0x80112980,%eax
80103921:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103924:	0f 87 57 ff ff ff    	ja     80103881 <startothers+0x3c>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
8010392a:	90                   	nop
8010392b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010392e:	c9                   	leave  
8010392f:	c3                   	ret    

80103930 <p2v>:
80103930:	55                   	push   %ebp
80103931:	89 e5                	mov    %esp,%ebp
80103933:	8b 45 08             	mov    0x8(%ebp),%eax
80103936:	05 00 00 00 80       	add    $0x80000000,%eax
8010393b:	5d                   	pop    %ebp
8010393c:	c3                   	ret    

8010393d <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
8010393d:	55                   	push   %ebp
8010393e:	89 e5                	mov    %esp,%ebp
80103940:	83 ec 14             	sub    $0x14,%esp
80103943:	8b 45 08             	mov    0x8(%ebp),%eax
80103946:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010394a:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
8010394e:	89 c2                	mov    %eax,%edx
80103950:	ec                   	in     (%dx),%al
80103951:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103954:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103958:	c9                   	leave  
80103959:	c3                   	ret    

8010395a <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
8010395a:	55                   	push   %ebp
8010395b:	89 e5                	mov    %esp,%ebp
8010395d:	83 ec 08             	sub    $0x8,%esp
80103960:	8b 55 08             	mov    0x8(%ebp),%edx
80103963:	8b 45 0c             	mov    0xc(%ebp),%eax
80103966:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010396a:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010396d:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103971:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103975:	ee                   	out    %al,(%dx)
}
80103976:	90                   	nop
80103977:	c9                   	leave  
80103978:	c3                   	ret    

80103979 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103979:	55                   	push   %ebp
8010397a:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
8010397c:	a1 88 e6 10 80       	mov    0x8010e688,%eax
80103981:	89 c2                	mov    %eax,%edx
80103983:	b8 80 29 11 80       	mov    $0x80112980,%eax
80103988:	29 c2                	sub    %eax,%edx
8010398a:	89 d0                	mov    %edx,%eax
8010398c:	c1 f8 02             	sar    $0x2,%eax
8010398f:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
80103995:	5d                   	pop    %ebp
80103996:	c3                   	ret    

80103997 <sum>:

static uchar
sum(uchar *addr, int len)
{
80103997:	55                   	push   %ebp
80103998:	89 e5                	mov    %esp,%ebp
8010399a:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
8010399d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
801039a4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801039ab:	eb 15                	jmp    801039c2 <sum+0x2b>
    sum += addr[i];
801039ad:	8b 55 fc             	mov    -0x4(%ebp),%edx
801039b0:	8b 45 08             	mov    0x8(%ebp),%eax
801039b3:	01 d0                	add    %edx,%eax
801039b5:	0f b6 00             	movzbl (%eax),%eax
801039b8:	0f b6 c0             	movzbl %al,%eax
801039bb:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
801039be:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801039c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
801039c5:	3b 45 0c             	cmp    0xc(%ebp),%eax
801039c8:	7c e3                	jl     801039ad <sum+0x16>
    sum += addr[i];
  return sum;
801039ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
801039cd:	c9                   	leave  
801039ce:	c3                   	ret    

801039cf <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801039cf:	55                   	push   %ebp
801039d0:	89 e5                	mov    %esp,%ebp
801039d2:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
801039d5:	ff 75 08             	pushl  0x8(%ebp)
801039d8:	e8 53 ff ff ff       	call   80103930 <p2v>
801039dd:	83 c4 04             	add    $0x4,%esp
801039e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
801039e3:	8b 55 0c             	mov    0xc(%ebp),%edx
801039e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039e9:	01 d0                	add    %edx,%eax
801039eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
801039ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
801039f4:	eb 36                	jmp    80103a2c <mpsearch1+0x5d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801039f6:	83 ec 04             	sub    $0x4,%esp
801039f9:	6a 04                	push   $0x4
801039fb:	68 78 b6 10 80       	push   $0x8010b678
80103a00:	ff 75 f4             	pushl  -0xc(%ebp)
80103a03:	e8 22 17 00 00       	call   8010512a <memcmp>
80103a08:	83 c4 10             	add    $0x10,%esp
80103a0b:	85 c0                	test   %eax,%eax
80103a0d:	75 19                	jne    80103a28 <mpsearch1+0x59>
80103a0f:	83 ec 08             	sub    $0x8,%esp
80103a12:	6a 10                	push   $0x10
80103a14:	ff 75 f4             	pushl  -0xc(%ebp)
80103a17:	e8 7b ff ff ff       	call   80103997 <sum>
80103a1c:	83 c4 10             	add    $0x10,%esp
80103a1f:	84 c0                	test   %al,%al
80103a21:	75 05                	jne    80103a28 <mpsearch1+0x59>
      return (struct mp*)p;
80103a23:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a26:	eb 11                	jmp    80103a39 <mpsearch1+0x6a>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103a28:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103a2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a2f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103a32:	72 c2                	jb     801039f6 <mpsearch1+0x27>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103a34:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103a39:	c9                   	leave  
80103a3a:	c3                   	ret    

80103a3b <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103a3b:	55                   	push   %ebp
80103a3c:	89 e5                	mov    %esp,%ebp
80103a3e:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103a41:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103a48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a4b:	83 c0 0f             	add    $0xf,%eax
80103a4e:	0f b6 00             	movzbl (%eax),%eax
80103a51:	0f b6 c0             	movzbl %al,%eax
80103a54:	c1 e0 08             	shl    $0x8,%eax
80103a57:	89 c2                	mov    %eax,%edx
80103a59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a5c:	83 c0 0e             	add    $0xe,%eax
80103a5f:	0f b6 00             	movzbl (%eax),%eax
80103a62:	0f b6 c0             	movzbl %al,%eax
80103a65:	09 d0                	or     %edx,%eax
80103a67:	c1 e0 04             	shl    $0x4,%eax
80103a6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103a6d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103a71:	74 21                	je     80103a94 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103a73:	83 ec 08             	sub    $0x8,%esp
80103a76:	68 00 04 00 00       	push   $0x400
80103a7b:	ff 75 f0             	pushl  -0x10(%ebp)
80103a7e:	e8 4c ff ff ff       	call   801039cf <mpsearch1>
80103a83:	83 c4 10             	add    $0x10,%esp
80103a86:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103a89:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103a8d:	74 51                	je     80103ae0 <mpsearch+0xa5>
      return mp;
80103a8f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103a92:	eb 61                	jmp    80103af5 <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103a94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a97:	83 c0 14             	add    $0x14,%eax
80103a9a:	0f b6 00             	movzbl (%eax),%eax
80103a9d:	0f b6 c0             	movzbl %al,%eax
80103aa0:	c1 e0 08             	shl    $0x8,%eax
80103aa3:	89 c2                	mov    %eax,%edx
80103aa5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103aa8:	83 c0 13             	add    $0x13,%eax
80103aab:	0f b6 00             	movzbl (%eax),%eax
80103aae:	0f b6 c0             	movzbl %al,%eax
80103ab1:	09 d0                	or     %edx,%eax
80103ab3:	c1 e0 0a             	shl    $0xa,%eax
80103ab6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103ab9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103abc:	2d 00 04 00 00       	sub    $0x400,%eax
80103ac1:	83 ec 08             	sub    $0x8,%esp
80103ac4:	68 00 04 00 00       	push   $0x400
80103ac9:	50                   	push   %eax
80103aca:	e8 00 ff ff ff       	call   801039cf <mpsearch1>
80103acf:	83 c4 10             	add    $0x10,%esp
80103ad2:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103ad5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103ad9:	74 05                	je     80103ae0 <mpsearch+0xa5>
      return mp;
80103adb:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103ade:	eb 15                	jmp    80103af5 <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80103ae0:	83 ec 08             	sub    $0x8,%esp
80103ae3:	68 00 00 01 00       	push   $0x10000
80103ae8:	68 00 00 0f 00       	push   $0xf0000
80103aed:	e8 dd fe ff ff       	call   801039cf <mpsearch1>
80103af2:	83 c4 10             	add    $0x10,%esp
}
80103af5:	c9                   	leave  
80103af6:	c3                   	ret    

80103af7 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103af7:	55                   	push   %ebp
80103af8:	89 e5                	mov    %esp,%ebp
80103afa:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103afd:	e8 39 ff ff ff       	call   80103a3b <mpsearch>
80103b02:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103b05:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103b09:	74 0a                	je     80103b15 <mpconfig+0x1e>
80103b0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b0e:	8b 40 04             	mov    0x4(%eax),%eax
80103b11:	85 c0                	test   %eax,%eax
80103b13:	75 0a                	jne    80103b1f <mpconfig+0x28>
    return 0;
80103b15:	b8 00 00 00 00       	mov    $0x0,%eax
80103b1a:	e9 81 00 00 00       	jmp    80103ba0 <mpconfig+0xa9>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103b1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b22:	8b 40 04             	mov    0x4(%eax),%eax
80103b25:	83 ec 0c             	sub    $0xc,%esp
80103b28:	50                   	push   %eax
80103b29:	e8 02 fe ff ff       	call   80103930 <p2v>
80103b2e:	83 c4 10             	add    $0x10,%esp
80103b31:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103b34:	83 ec 04             	sub    $0x4,%esp
80103b37:	6a 04                	push   $0x4
80103b39:	68 7d b6 10 80       	push   $0x8010b67d
80103b3e:	ff 75 f0             	pushl  -0x10(%ebp)
80103b41:	e8 e4 15 00 00       	call   8010512a <memcmp>
80103b46:	83 c4 10             	add    $0x10,%esp
80103b49:	85 c0                	test   %eax,%eax
80103b4b:	74 07                	je     80103b54 <mpconfig+0x5d>
    return 0;
80103b4d:	b8 00 00 00 00       	mov    $0x0,%eax
80103b52:	eb 4c                	jmp    80103ba0 <mpconfig+0xa9>
  if(conf->version != 1 && conf->version != 4)
80103b54:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b57:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103b5b:	3c 01                	cmp    $0x1,%al
80103b5d:	74 12                	je     80103b71 <mpconfig+0x7a>
80103b5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b62:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103b66:	3c 04                	cmp    $0x4,%al
80103b68:	74 07                	je     80103b71 <mpconfig+0x7a>
    return 0;
80103b6a:	b8 00 00 00 00       	mov    $0x0,%eax
80103b6f:	eb 2f                	jmp    80103ba0 <mpconfig+0xa9>
  if(sum((uchar*)conf, conf->length) != 0)
80103b71:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b74:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103b78:	0f b7 c0             	movzwl %ax,%eax
80103b7b:	83 ec 08             	sub    $0x8,%esp
80103b7e:	50                   	push   %eax
80103b7f:	ff 75 f0             	pushl  -0x10(%ebp)
80103b82:	e8 10 fe ff ff       	call   80103997 <sum>
80103b87:	83 c4 10             	add    $0x10,%esp
80103b8a:	84 c0                	test   %al,%al
80103b8c:	74 07                	je     80103b95 <mpconfig+0x9e>
    return 0;
80103b8e:	b8 00 00 00 00       	mov    $0x0,%eax
80103b93:	eb 0b                	jmp    80103ba0 <mpconfig+0xa9>
  *pmp = mp;
80103b95:	8b 45 08             	mov    0x8(%ebp),%eax
80103b98:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103b9b:	89 10                	mov    %edx,(%eax)
  return conf;
80103b9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103ba0:	c9                   	leave  
80103ba1:	c3                   	ret    

80103ba2 <mpinit>:

void
mpinit(void)
{
80103ba2:	55                   	push   %ebp
80103ba3:	89 e5                	mov    %esp,%ebp
80103ba5:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103ba8:	c7 05 88 e6 10 80 80 	movl   $0x80112980,0x8010e688
80103baf:	29 11 80 
  if((conf = mpconfig(&mp)) == 0)
80103bb2:	83 ec 0c             	sub    $0xc,%esp
80103bb5:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103bb8:	50                   	push   %eax
80103bb9:	e8 39 ff ff ff       	call   80103af7 <mpconfig>
80103bbe:	83 c4 10             	add    $0x10,%esp
80103bc1:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103bc4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103bc8:	0f 84 96 01 00 00    	je     80103d64 <mpinit+0x1c2>
    return;
  ismp = 1;
80103bce:	c7 05 64 29 11 80 01 	movl   $0x1,0x80112964
80103bd5:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bdb:	8b 40 24             	mov    0x24(%eax),%eax
80103bde:	a3 dc 28 11 80       	mov    %eax,0x801128dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103be3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103be6:	83 c0 2c             	add    $0x2c,%eax
80103be9:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103bec:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bef:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103bf3:	0f b7 d0             	movzwl %ax,%edx
80103bf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bf9:	01 d0                	add    %edx,%eax
80103bfb:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103bfe:	e9 f2 00 00 00       	jmp    80103cf5 <mpinit+0x153>
    switch(*p){
80103c03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c06:	0f b6 00             	movzbl (%eax),%eax
80103c09:	0f b6 c0             	movzbl %al,%eax
80103c0c:	83 f8 04             	cmp    $0x4,%eax
80103c0f:	0f 87 bc 00 00 00    	ja     80103cd1 <mpinit+0x12f>
80103c15:	8b 04 85 c0 b6 10 80 	mov    -0x7fef4940(,%eax,4),%eax
80103c1c:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103c1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c21:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103c24:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103c27:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103c2b:	0f b6 d0             	movzbl %al,%edx
80103c2e:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103c33:	39 c2                	cmp    %eax,%edx
80103c35:	74 2b                	je     80103c62 <mpinit+0xc0>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103c37:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103c3a:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103c3e:	0f b6 d0             	movzbl %al,%edx
80103c41:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103c46:	83 ec 04             	sub    $0x4,%esp
80103c49:	52                   	push   %edx
80103c4a:	50                   	push   %eax
80103c4b:	68 82 b6 10 80       	push   $0x8010b682
80103c50:	e8 71 c7 ff ff       	call   801003c6 <cprintf>
80103c55:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
80103c58:	c7 05 64 29 11 80 00 	movl   $0x0,0x80112964
80103c5f:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103c62:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103c65:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103c69:	0f b6 c0             	movzbl %al,%eax
80103c6c:	83 e0 02             	and    $0x2,%eax
80103c6f:	85 c0                	test   %eax,%eax
80103c71:	74 15                	je     80103c88 <mpinit+0xe6>
        bcpu = &cpus[ncpu];
80103c73:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103c78:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103c7e:	05 80 29 11 80       	add    $0x80112980,%eax
80103c83:	a3 88 e6 10 80       	mov    %eax,0x8010e688
      cpus[ncpu].id = ncpu;
80103c88:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103c8d:	8b 15 60 2f 11 80    	mov    0x80112f60,%edx
80103c93:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103c99:	05 80 29 11 80       	add    $0x80112980,%eax
80103c9e:	88 10                	mov    %dl,(%eax)
      ncpu++;
80103ca0:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103ca5:	83 c0 01             	add    $0x1,%eax
80103ca8:	a3 60 2f 11 80       	mov    %eax,0x80112f60
      p += sizeof(struct mpproc);
80103cad:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103cb1:	eb 42                	jmp    80103cf5 <mpinit+0x153>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103cb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cb6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103cb9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103cbc:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103cc0:	a2 60 29 11 80       	mov    %al,0x80112960
      p += sizeof(struct mpioapic);
80103cc5:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103cc9:	eb 2a                	jmp    80103cf5 <mpinit+0x153>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103ccb:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103ccf:	eb 24                	jmp    80103cf5 <mpinit+0x153>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103cd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cd4:	0f b6 00             	movzbl (%eax),%eax
80103cd7:	0f b6 c0             	movzbl %al,%eax
80103cda:	83 ec 08             	sub    $0x8,%esp
80103cdd:	50                   	push   %eax
80103cde:	68 a0 b6 10 80       	push   $0x8010b6a0
80103ce3:	e8 de c6 ff ff       	call   801003c6 <cprintf>
80103ce8:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
80103ceb:	c7 05 64 29 11 80 00 	movl   $0x0,0x80112964
80103cf2:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103cf5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cf8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103cfb:	0f 82 02 ff ff ff    	jb     80103c03 <mpinit+0x61>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103d01:	a1 64 29 11 80       	mov    0x80112964,%eax
80103d06:	85 c0                	test   %eax,%eax
80103d08:	75 1d                	jne    80103d27 <mpinit+0x185>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103d0a:	c7 05 60 2f 11 80 01 	movl   $0x1,0x80112f60
80103d11:	00 00 00 
    lapic = 0;
80103d14:	c7 05 dc 28 11 80 00 	movl   $0x0,0x801128dc
80103d1b:	00 00 00 
    ioapicid = 0;
80103d1e:	c6 05 60 29 11 80 00 	movb   $0x0,0x80112960
    return;
80103d25:	eb 3e                	jmp    80103d65 <mpinit+0x1c3>
  }

  if(mp->imcrp){
80103d27:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103d2a:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103d2e:	84 c0                	test   %al,%al
80103d30:	74 33                	je     80103d65 <mpinit+0x1c3>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103d32:	83 ec 08             	sub    $0x8,%esp
80103d35:	6a 70                	push   $0x70
80103d37:	6a 22                	push   $0x22
80103d39:	e8 1c fc ff ff       	call   8010395a <outb>
80103d3e:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103d41:	83 ec 0c             	sub    $0xc,%esp
80103d44:	6a 23                	push   $0x23
80103d46:	e8 f2 fb ff ff       	call   8010393d <inb>
80103d4b:	83 c4 10             	add    $0x10,%esp
80103d4e:	83 c8 01             	or     $0x1,%eax
80103d51:	0f b6 c0             	movzbl %al,%eax
80103d54:	83 ec 08             	sub    $0x8,%esp
80103d57:	50                   	push   %eax
80103d58:	6a 23                	push   $0x23
80103d5a:	e8 fb fb ff ff       	call   8010395a <outb>
80103d5f:	83 c4 10             	add    $0x10,%esp
80103d62:	eb 01                	jmp    80103d65 <mpinit+0x1c3>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
80103d64:	90                   	nop
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103d65:	c9                   	leave  
80103d66:	c3                   	ret    

80103d67 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103d67:	55                   	push   %ebp
80103d68:	89 e5                	mov    %esp,%ebp
80103d6a:	83 ec 08             	sub    $0x8,%esp
80103d6d:	8b 55 08             	mov    0x8(%ebp),%edx
80103d70:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d73:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103d77:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103d7a:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103d7e:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103d82:	ee                   	out    %al,(%dx)
}
80103d83:	90                   	nop
80103d84:	c9                   	leave  
80103d85:	c3                   	ret    

80103d86 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103d86:	55                   	push   %ebp
80103d87:	89 e5                	mov    %esp,%ebp
80103d89:	83 ec 04             	sub    $0x4,%esp
80103d8c:	8b 45 08             	mov    0x8(%ebp),%eax
80103d8f:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103d93:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103d97:	66 a3 00 e0 10 80    	mov    %ax,0x8010e000
  outb(IO_PIC1+1, mask);
80103d9d:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103da1:	0f b6 c0             	movzbl %al,%eax
80103da4:	50                   	push   %eax
80103da5:	6a 21                	push   $0x21
80103da7:	e8 bb ff ff ff       	call   80103d67 <outb>
80103dac:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80103daf:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103db3:	66 c1 e8 08          	shr    $0x8,%ax
80103db7:	0f b6 c0             	movzbl %al,%eax
80103dba:	50                   	push   %eax
80103dbb:	68 a1 00 00 00       	push   $0xa1
80103dc0:	e8 a2 ff ff ff       	call   80103d67 <outb>
80103dc5:	83 c4 08             	add    $0x8,%esp
}
80103dc8:	90                   	nop
80103dc9:	c9                   	leave  
80103dca:	c3                   	ret    

80103dcb <picenable>:

void
picenable(int irq)
{
80103dcb:	55                   	push   %ebp
80103dcc:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80103dce:	8b 45 08             	mov    0x8(%ebp),%eax
80103dd1:	ba 01 00 00 00       	mov    $0x1,%edx
80103dd6:	89 c1                	mov    %eax,%ecx
80103dd8:	d3 e2                	shl    %cl,%edx
80103dda:	89 d0                	mov    %edx,%eax
80103ddc:	f7 d0                	not    %eax
80103dde:	89 c2                	mov    %eax,%edx
80103de0:	0f b7 05 00 e0 10 80 	movzwl 0x8010e000,%eax
80103de7:	21 d0                	and    %edx,%eax
80103de9:	0f b7 c0             	movzwl %ax,%eax
80103dec:	50                   	push   %eax
80103ded:	e8 94 ff ff ff       	call   80103d86 <picsetmask>
80103df2:	83 c4 04             	add    $0x4,%esp
}
80103df5:	90                   	nop
80103df6:	c9                   	leave  
80103df7:	c3                   	ret    

80103df8 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103df8:	55                   	push   %ebp
80103df9:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103dfb:	68 ff 00 00 00       	push   $0xff
80103e00:	6a 21                	push   $0x21
80103e02:	e8 60 ff ff ff       	call   80103d67 <outb>
80103e07:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80103e0a:	68 ff 00 00 00       	push   $0xff
80103e0f:	68 a1 00 00 00       	push   $0xa1
80103e14:	e8 4e ff ff ff       	call   80103d67 <outb>
80103e19:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103e1c:	6a 11                	push   $0x11
80103e1e:	6a 20                	push   $0x20
80103e20:	e8 42 ff ff ff       	call   80103d67 <outb>
80103e25:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103e28:	6a 20                	push   $0x20
80103e2a:	6a 21                	push   $0x21
80103e2c:	e8 36 ff ff ff       	call   80103d67 <outb>
80103e31:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103e34:	6a 04                	push   $0x4
80103e36:	6a 21                	push   $0x21
80103e38:	e8 2a ff ff ff       	call   80103d67 <outb>
80103e3d:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103e40:	6a 03                	push   $0x3
80103e42:	6a 21                	push   $0x21
80103e44:	e8 1e ff ff ff       	call   80103d67 <outb>
80103e49:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103e4c:	6a 11                	push   $0x11
80103e4e:	68 a0 00 00 00       	push   $0xa0
80103e53:	e8 0f ff ff ff       	call   80103d67 <outb>
80103e58:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103e5b:	6a 28                	push   $0x28
80103e5d:	68 a1 00 00 00       	push   $0xa1
80103e62:	e8 00 ff ff ff       	call   80103d67 <outb>
80103e67:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103e6a:	6a 02                	push   $0x2
80103e6c:	68 a1 00 00 00       	push   $0xa1
80103e71:	e8 f1 fe ff ff       	call   80103d67 <outb>
80103e76:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103e79:	6a 03                	push   $0x3
80103e7b:	68 a1 00 00 00       	push   $0xa1
80103e80:	e8 e2 fe ff ff       	call   80103d67 <outb>
80103e85:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103e88:	6a 68                	push   $0x68
80103e8a:	6a 20                	push   $0x20
80103e8c:	e8 d6 fe ff ff       	call   80103d67 <outb>
80103e91:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103e94:	6a 0a                	push   $0xa
80103e96:	6a 20                	push   $0x20
80103e98:	e8 ca fe ff ff       	call   80103d67 <outb>
80103e9d:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
80103ea0:	6a 68                	push   $0x68
80103ea2:	68 a0 00 00 00       	push   $0xa0
80103ea7:	e8 bb fe ff ff       	call   80103d67 <outb>
80103eac:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
80103eaf:	6a 0a                	push   $0xa
80103eb1:	68 a0 00 00 00       	push   $0xa0
80103eb6:	e8 ac fe ff ff       	call   80103d67 <outb>
80103ebb:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
80103ebe:	0f b7 05 00 e0 10 80 	movzwl 0x8010e000,%eax
80103ec5:	66 83 f8 ff          	cmp    $0xffff,%ax
80103ec9:	74 13                	je     80103ede <picinit+0xe6>
    picsetmask(irqmask);
80103ecb:	0f b7 05 00 e0 10 80 	movzwl 0x8010e000,%eax
80103ed2:	0f b7 c0             	movzwl %ax,%eax
80103ed5:	50                   	push   %eax
80103ed6:	e8 ab fe ff ff       	call   80103d86 <picsetmask>
80103edb:	83 c4 04             	add    $0x4,%esp
}
80103ede:	90                   	nop
80103edf:	c9                   	leave  
80103ee0:	c3                   	ret    

80103ee1 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103ee1:	55                   	push   %ebp
80103ee2:	89 e5                	mov    %esp,%ebp
80103ee4:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80103ee7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103eee:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ef1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103ef7:	8b 45 0c             	mov    0xc(%ebp),%eax
80103efa:	8b 10                	mov    (%eax),%edx
80103efc:	8b 45 08             	mov    0x8(%ebp),%eax
80103eff:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103f01:	e8 5e d0 ff ff       	call   80100f64 <filealloc>
80103f06:	89 c2                	mov    %eax,%edx
80103f08:	8b 45 08             	mov    0x8(%ebp),%eax
80103f0b:	89 10                	mov    %edx,(%eax)
80103f0d:	8b 45 08             	mov    0x8(%ebp),%eax
80103f10:	8b 00                	mov    (%eax),%eax
80103f12:	85 c0                	test   %eax,%eax
80103f14:	0f 84 cb 00 00 00    	je     80103fe5 <pipealloc+0x104>
80103f1a:	e8 45 d0 ff ff       	call   80100f64 <filealloc>
80103f1f:	89 c2                	mov    %eax,%edx
80103f21:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f24:	89 10                	mov    %edx,(%eax)
80103f26:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f29:	8b 00                	mov    (%eax),%eax
80103f2b:	85 c0                	test   %eax,%eax
80103f2d:	0f 84 b2 00 00 00    	je     80103fe5 <pipealloc+0x104>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103f33:	e8 c8 ed ff ff       	call   80102d00 <kalloc>
80103f38:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103f3b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103f3f:	0f 84 9f 00 00 00    	je     80103fe4 <pipealloc+0x103>
    goto bad;
  p->readopen = 1;
80103f45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f48:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103f4f:	00 00 00 
  p->writeopen = 1;
80103f52:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f55:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103f5c:	00 00 00 
  p->nwrite = 0;
80103f5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f62:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103f69:	00 00 00 
  p->nread = 0;
80103f6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f6f:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103f76:	00 00 00 
  initlock(&p->lock, "pipe");
80103f79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f7c:	83 ec 08             	sub    $0x8,%esp
80103f7f:	68 d4 b6 10 80       	push   $0x8010b6d4
80103f84:	50                   	push   %eax
80103f85:	e8 b4 0e 00 00       	call   80104e3e <initlock>
80103f8a:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103f8d:	8b 45 08             	mov    0x8(%ebp),%eax
80103f90:	8b 00                	mov    (%eax),%eax
80103f92:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103f98:	8b 45 08             	mov    0x8(%ebp),%eax
80103f9b:	8b 00                	mov    (%eax),%eax
80103f9d:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103fa1:	8b 45 08             	mov    0x8(%ebp),%eax
80103fa4:	8b 00                	mov    (%eax),%eax
80103fa6:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103faa:	8b 45 08             	mov    0x8(%ebp),%eax
80103fad:	8b 00                	mov    (%eax),%eax
80103faf:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103fb2:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fb8:	8b 00                	mov    (%eax),%eax
80103fba:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103fc0:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fc3:	8b 00                	mov    (%eax),%eax
80103fc5:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103fc9:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fcc:	8b 00                	mov    (%eax),%eax
80103fce:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103fd2:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fd5:	8b 00                	mov    (%eax),%eax
80103fd7:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103fda:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80103fdd:	b8 00 00 00 00       	mov    $0x0,%eax
80103fe2:	eb 4e                	jmp    80104032 <pipealloc+0x151>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
80103fe4:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
80103fe5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103fe9:	74 0e                	je     80103ff9 <pipealloc+0x118>
    kfree((char*)p);
80103feb:	83 ec 0c             	sub    $0xc,%esp
80103fee:	ff 75 f4             	pushl  -0xc(%ebp)
80103ff1:	e8 6d ec ff ff       	call   80102c63 <kfree>
80103ff6:	83 c4 10             	add    $0x10,%esp
  if(*f0)
80103ff9:	8b 45 08             	mov    0x8(%ebp),%eax
80103ffc:	8b 00                	mov    (%eax),%eax
80103ffe:	85 c0                	test   %eax,%eax
80104000:	74 11                	je     80104013 <pipealloc+0x132>
    fileclose(*f0);
80104002:	8b 45 08             	mov    0x8(%ebp),%eax
80104005:	8b 00                	mov    (%eax),%eax
80104007:	83 ec 0c             	sub    $0xc,%esp
8010400a:	50                   	push   %eax
8010400b:	e8 12 d0 ff ff       	call   80101022 <fileclose>
80104010:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80104013:	8b 45 0c             	mov    0xc(%ebp),%eax
80104016:	8b 00                	mov    (%eax),%eax
80104018:	85 c0                	test   %eax,%eax
8010401a:	74 11                	je     8010402d <pipealloc+0x14c>
    fileclose(*f1);
8010401c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010401f:	8b 00                	mov    (%eax),%eax
80104021:	83 ec 0c             	sub    $0xc,%esp
80104024:	50                   	push   %eax
80104025:	e8 f8 cf ff ff       	call   80101022 <fileclose>
8010402a:	83 c4 10             	add    $0x10,%esp
  return -1;
8010402d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104032:	c9                   	leave  
80104033:	c3                   	ret    

80104034 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104034:	55                   	push   %ebp
80104035:	89 e5                	mov    %esp,%ebp
80104037:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
8010403a:	8b 45 08             	mov    0x8(%ebp),%eax
8010403d:	83 ec 0c             	sub    $0xc,%esp
80104040:	50                   	push   %eax
80104041:	e8 1a 0e 00 00       	call   80104e60 <acquire>
80104046:	83 c4 10             	add    $0x10,%esp
  if(writable){
80104049:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010404d:	74 23                	je     80104072 <pipeclose+0x3e>
    p->writeopen = 0;
8010404f:	8b 45 08             	mov    0x8(%ebp),%eax
80104052:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80104059:	00 00 00 
    wakeup(&p->nread);
8010405c:	8b 45 08             	mov    0x8(%ebp),%eax
8010405f:	05 34 02 00 00       	add    $0x234,%eax
80104064:	83 ec 0c             	sub    $0xc,%esp
80104067:	50                   	push   %eax
80104068:	e8 e5 0b 00 00       	call   80104c52 <wakeup>
8010406d:	83 c4 10             	add    $0x10,%esp
80104070:	eb 21                	jmp    80104093 <pipeclose+0x5f>
  } else {
    p->readopen = 0;
80104072:	8b 45 08             	mov    0x8(%ebp),%eax
80104075:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
8010407c:	00 00 00 
    wakeup(&p->nwrite);
8010407f:	8b 45 08             	mov    0x8(%ebp),%eax
80104082:	05 38 02 00 00       	add    $0x238,%eax
80104087:	83 ec 0c             	sub    $0xc,%esp
8010408a:	50                   	push   %eax
8010408b:	e8 c2 0b 00 00       	call   80104c52 <wakeup>
80104090:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104093:	8b 45 08             	mov    0x8(%ebp),%eax
80104096:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
8010409c:	85 c0                	test   %eax,%eax
8010409e:	75 2c                	jne    801040cc <pipeclose+0x98>
801040a0:	8b 45 08             	mov    0x8(%ebp),%eax
801040a3:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801040a9:	85 c0                	test   %eax,%eax
801040ab:	75 1f                	jne    801040cc <pipeclose+0x98>
    release(&p->lock);
801040ad:	8b 45 08             	mov    0x8(%ebp),%eax
801040b0:	83 ec 0c             	sub    $0xc,%esp
801040b3:	50                   	push   %eax
801040b4:	e8 0e 0e 00 00       	call   80104ec7 <release>
801040b9:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
801040bc:	83 ec 0c             	sub    $0xc,%esp
801040bf:	ff 75 08             	pushl  0x8(%ebp)
801040c2:	e8 9c eb ff ff       	call   80102c63 <kfree>
801040c7:	83 c4 10             	add    $0x10,%esp
801040ca:	eb 0f                	jmp    801040db <pipeclose+0xa7>
  } else
    release(&p->lock);
801040cc:	8b 45 08             	mov    0x8(%ebp),%eax
801040cf:	83 ec 0c             	sub    $0xc,%esp
801040d2:	50                   	push   %eax
801040d3:	e8 ef 0d 00 00       	call   80104ec7 <release>
801040d8:	83 c4 10             	add    $0x10,%esp
}
801040db:	90                   	nop
801040dc:	c9                   	leave  
801040dd:	c3                   	ret    

801040de <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801040de:	55                   	push   %ebp
801040df:	89 e5                	mov    %esp,%ebp
801040e1:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
801040e4:	8b 45 08             	mov    0x8(%ebp),%eax
801040e7:	83 ec 0c             	sub    $0xc,%esp
801040ea:	50                   	push   %eax
801040eb:	e8 70 0d 00 00       	call   80104e60 <acquire>
801040f0:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
801040f3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801040fa:	e9 ad 00 00 00       	jmp    801041ac <pipewrite+0xce>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
801040ff:	8b 45 08             	mov    0x8(%ebp),%eax
80104102:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104108:	85 c0                	test   %eax,%eax
8010410a:	74 0d                	je     80104119 <pipewrite+0x3b>
8010410c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104112:	8b 40 24             	mov    0x24(%eax),%eax
80104115:	85 c0                	test   %eax,%eax
80104117:	74 19                	je     80104132 <pipewrite+0x54>
        release(&p->lock);
80104119:	8b 45 08             	mov    0x8(%ebp),%eax
8010411c:	83 ec 0c             	sub    $0xc,%esp
8010411f:	50                   	push   %eax
80104120:	e8 a2 0d 00 00       	call   80104ec7 <release>
80104125:	83 c4 10             	add    $0x10,%esp
        return -1;
80104128:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010412d:	e9 a8 00 00 00       	jmp    801041da <pipewrite+0xfc>
      }
      wakeup(&p->nread);
80104132:	8b 45 08             	mov    0x8(%ebp),%eax
80104135:	05 34 02 00 00       	add    $0x234,%eax
8010413a:	83 ec 0c             	sub    $0xc,%esp
8010413d:	50                   	push   %eax
8010413e:	e8 0f 0b 00 00       	call   80104c52 <wakeup>
80104143:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104146:	8b 45 08             	mov    0x8(%ebp),%eax
80104149:	8b 55 08             	mov    0x8(%ebp),%edx
8010414c:	81 c2 38 02 00 00    	add    $0x238,%edx
80104152:	83 ec 08             	sub    $0x8,%esp
80104155:	50                   	push   %eax
80104156:	52                   	push   %edx
80104157:	e8 0b 0a 00 00       	call   80104b67 <sleep>
8010415c:	83 c4 10             	add    $0x10,%esp
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010415f:	8b 45 08             	mov    0x8(%ebp),%eax
80104162:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80104168:	8b 45 08             	mov    0x8(%ebp),%eax
8010416b:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104171:	05 00 02 00 00       	add    $0x200,%eax
80104176:	39 c2                	cmp    %eax,%edx
80104178:	74 85                	je     801040ff <pipewrite+0x21>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010417a:	8b 45 08             	mov    0x8(%ebp),%eax
8010417d:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104183:	8d 48 01             	lea    0x1(%eax),%ecx
80104186:	8b 55 08             	mov    0x8(%ebp),%edx
80104189:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
8010418f:	25 ff 01 00 00       	and    $0x1ff,%eax
80104194:	89 c1                	mov    %eax,%ecx
80104196:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104199:	8b 45 0c             	mov    0xc(%ebp),%eax
8010419c:	01 d0                	add    %edx,%eax
8010419e:	0f b6 10             	movzbl (%eax),%edx
801041a1:	8b 45 08             	mov    0x8(%ebp),%eax
801041a4:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
801041a8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801041ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041af:	3b 45 10             	cmp    0x10(%ebp),%eax
801041b2:	7c ab                	jl     8010415f <pipewrite+0x81>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801041b4:	8b 45 08             	mov    0x8(%ebp),%eax
801041b7:	05 34 02 00 00       	add    $0x234,%eax
801041bc:	83 ec 0c             	sub    $0xc,%esp
801041bf:	50                   	push   %eax
801041c0:	e8 8d 0a 00 00       	call   80104c52 <wakeup>
801041c5:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801041c8:	8b 45 08             	mov    0x8(%ebp),%eax
801041cb:	83 ec 0c             	sub    $0xc,%esp
801041ce:	50                   	push   %eax
801041cf:	e8 f3 0c 00 00       	call   80104ec7 <release>
801041d4:	83 c4 10             	add    $0x10,%esp
  return n;
801041d7:	8b 45 10             	mov    0x10(%ebp),%eax
}
801041da:	c9                   	leave  
801041db:	c3                   	ret    

801041dc <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801041dc:	55                   	push   %ebp
801041dd:	89 e5                	mov    %esp,%ebp
801041df:	53                   	push   %ebx
801041e0:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
801041e3:	8b 45 08             	mov    0x8(%ebp),%eax
801041e6:	83 ec 0c             	sub    $0xc,%esp
801041e9:	50                   	push   %eax
801041ea:	e8 71 0c 00 00       	call   80104e60 <acquire>
801041ef:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801041f2:	eb 3f                	jmp    80104233 <piperead+0x57>
    if(proc->killed){
801041f4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801041fa:	8b 40 24             	mov    0x24(%eax),%eax
801041fd:	85 c0                	test   %eax,%eax
801041ff:	74 19                	je     8010421a <piperead+0x3e>
      release(&p->lock);
80104201:	8b 45 08             	mov    0x8(%ebp),%eax
80104204:	83 ec 0c             	sub    $0xc,%esp
80104207:	50                   	push   %eax
80104208:	e8 ba 0c 00 00       	call   80104ec7 <release>
8010420d:	83 c4 10             	add    $0x10,%esp
      return -1;
80104210:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104215:	e9 bf 00 00 00       	jmp    801042d9 <piperead+0xfd>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010421a:	8b 45 08             	mov    0x8(%ebp),%eax
8010421d:	8b 55 08             	mov    0x8(%ebp),%edx
80104220:	81 c2 34 02 00 00    	add    $0x234,%edx
80104226:	83 ec 08             	sub    $0x8,%esp
80104229:	50                   	push   %eax
8010422a:	52                   	push   %edx
8010422b:	e8 37 09 00 00       	call   80104b67 <sleep>
80104230:	83 c4 10             	add    $0x10,%esp
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104233:	8b 45 08             	mov    0x8(%ebp),%eax
80104236:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
8010423c:	8b 45 08             	mov    0x8(%ebp),%eax
8010423f:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104245:	39 c2                	cmp    %eax,%edx
80104247:	75 0d                	jne    80104256 <piperead+0x7a>
80104249:	8b 45 08             	mov    0x8(%ebp),%eax
8010424c:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104252:	85 c0                	test   %eax,%eax
80104254:	75 9e                	jne    801041f4 <piperead+0x18>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104256:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010425d:	eb 49                	jmp    801042a8 <piperead+0xcc>
    if(p->nread == p->nwrite)
8010425f:	8b 45 08             	mov    0x8(%ebp),%eax
80104262:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104268:	8b 45 08             	mov    0x8(%ebp),%eax
8010426b:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104271:	39 c2                	cmp    %eax,%edx
80104273:	74 3d                	je     801042b2 <piperead+0xd6>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104275:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104278:	8b 45 0c             	mov    0xc(%ebp),%eax
8010427b:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010427e:	8b 45 08             	mov    0x8(%ebp),%eax
80104281:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104287:	8d 48 01             	lea    0x1(%eax),%ecx
8010428a:	8b 55 08             	mov    0x8(%ebp),%edx
8010428d:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
80104293:	25 ff 01 00 00       	and    $0x1ff,%eax
80104298:	89 c2                	mov    %eax,%edx
8010429a:	8b 45 08             	mov    0x8(%ebp),%eax
8010429d:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
801042a2:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801042a4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801042a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042ab:	3b 45 10             	cmp    0x10(%ebp),%eax
801042ae:	7c af                	jl     8010425f <piperead+0x83>
801042b0:	eb 01                	jmp    801042b3 <piperead+0xd7>
    if(p->nread == p->nwrite)
      break;
801042b2:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801042b3:	8b 45 08             	mov    0x8(%ebp),%eax
801042b6:	05 38 02 00 00       	add    $0x238,%eax
801042bb:	83 ec 0c             	sub    $0xc,%esp
801042be:	50                   	push   %eax
801042bf:	e8 8e 09 00 00       	call   80104c52 <wakeup>
801042c4:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801042c7:	8b 45 08             	mov    0x8(%ebp),%eax
801042ca:	83 ec 0c             	sub    $0xc,%esp
801042cd:	50                   	push   %eax
801042ce:	e8 f4 0b 00 00       	call   80104ec7 <release>
801042d3:	83 c4 10             	add    $0x10,%esp
  return i;
801042d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801042d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042dc:	c9                   	leave  
801042dd:	c3                   	ret    

801042de <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
801042de:	55                   	push   %ebp
801042df:	89 e5                	mov    %esp,%ebp
801042e1:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801042e4:	9c                   	pushf  
801042e5:	58                   	pop    %eax
801042e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801042e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801042ec:	c9                   	leave  
801042ed:	c3                   	ret    

801042ee <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
801042ee:	55                   	push   %ebp
801042ef:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
801042f1:	fb                   	sti    
}
801042f2:	90                   	nop
801042f3:	5d                   	pop    %ebp
801042f4:	c3                   	ret    

801042f5 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801042f5:	55                   	push   %ebp
801042f6:	89 e5                	mov    %esp,%ebp
801042f8:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
801042fb:	83 ec 08             	sub    $0x8,%esp
801042fe:	68 d9 b6 10 80       	push   $0x8010b6d9
80104303:	68 80 2f 11 80       	push   $0x80112f80
80104308:	e8 31 0b 00 00       	call   80104e3e <initlock>
8010430d:	83 c4 10             	add    $0x10,%esp
}
80104310:	90                   	nop
80104311:	c9                   	leave  
80104312:	c3                   	ret    

80104313 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104313:	55                   	push   %ebp
80104314:	89 e5                	mov    %esp,%ebp
80104316:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80104319:	83 ec 0c             	sub    $0xc,%esp
8010431c:	68 80 2f 11 80       	push   $0x80112f80
80104321:	e8 3a 0b 00 00       	call   80104e60 <acquire>
80104326:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104329:	c7 45 f4 b4 2f 11 80 	movl   $0x80112fb4,-0xc(%ebp)
80104330:	eb 0e                	jmp    80104340 <allocproc+0x2d>
    if(p->state == UNUSED)
80104332:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104335:	8b 40 0c             	mov    0xc(%eax),%eax
80104338:	85 c0                	test   %eax,%eax
8010433a:	74 27                	je     80104363 <allocproc+0x50>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010433c:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104340:	81 7d f4 b4 4e 11 80 	cmpl   $0x80114eb4,-0xc(%ebp)
80104347:	72 e9                	jb     80104332 <allocproc+0x1f>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
80104349:	83 ec 0c             	sub    $0xc,%esp
8010434c:	68 80 2f 11 80       	push   $0x80112f80
80104351:	e8 71 0b 00 00       	call   80104ec7 <release>
80104356:	83 c4 10             	add    $0x10,%esp
  return 0;
80104359:	b8 00 00 00 00       	mov    $0x0,%eax
8010435e:	e9 b4 00 00 00       	jmp    80104417 <allocproc+0x104>
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
80104363:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80104364:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104367:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
8010436e:	a1 04 e0 10 80       	mov    0x8010e004,%eax
80104373:	8d 50 01             	lea    0x1(%eax),%edx
80104376:	89 15 04 e0 10 80    	mov    %edx,0x8010e004
8010437c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010437f:	89 42 10             	mov    %eax,0x10(%edx)
  release(&ptable.lock);
80104382:	83 ec 0c             	sub    $0xc,%esp
80104385:	68 80 2f 11 80       	push   $0x80112f80
8010438a:	e8 38 0b 00 00       	call   80104ec7 <release>
8010438f:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104392:	e8 69 e9 ff ff       	call   80102d00 <kalloc>
80104397:	89 c2                	mov    %eax,%edx
80104399:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010439c:	89 50 08             	mov    %edx,0x8(%eax)
8010439f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043a2:	8b 40 08             	mov    0x8(%eax),%eax
801043a5:	85 c0                	test   %eax,%eax
801043a7:	75 11                	jne    801043ba <allocproc+0xa7>
    p->state = UNUSED;
801043a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043ac:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
801043b3:	b8 00 00 00 00       	mov    $0x0,%eax
801043b8:	eb 5d                	jmp    80104417 <allocproc+0x104>
  }
  sp = p->kstack + KSTACKSIZE;
801043ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043bd:	8b 40 08             	mov    0x8(%eax),%eax
801043c0:	05 00 10 00 00       	add    $0x1000,%eax
801043c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801043c8:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
801043cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043cf:	8b 55 f0             	mov    -0x10(%ebp),%edx
801043d2:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
801043d5:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
801043d9:	ba 6b 64 10 80       	mov    $0x8010646b,%edx
801043de:	8b 45 f0             	mov    -0x10(%ebp),%eax
801043e1:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
801043e3:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
801043e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043ea:	8b 55 f0             	mov    -0x10(%ebp),%edx
801043ed:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
801043f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043f3:	8b 40 1c             	mov    0x1c(%eax),%eax
801043f6:	83 ec 04             	sub    $0x4,%esp
801043f9:	6a 14                	push   $0x14
801043fb:	6a 00                	push   $0x0
801043fd:	50                   	push   %eax
801043fe:	e8 c0 0c 00 00       	call   801050c3 <memset>
80104403:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104406:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104409:	8b 40 1c             	mov    0x1c(%eax),%eax
8010440c:	ba 36 4b 10 80       	mov    $0x80104b36,%edx
80104411:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
80104414:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104417:	c9                   	leave  
80104418:	c3                   	ret    

80104419 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80104419:	55                   	push   %ebp
8010441a:	89 e5                	mov    %esp,%ebp
8010441c:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
8010441f:	e8 ef fe ff ff       	call   80104313 <allocproc>
80104424:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
80104427:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010442a:	a3 8c e6 10 80       	mov    %eax,0x8010e68c
  if((p->pgdir = setupkvm()) == 0)
8010442f:	e8 01 37 00 00       	call   80107b35 <setupkvm>
80104434:	89 c2                	mov    %eax,%edx
80104436:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104439:	89 50 04             	mov    %edx,0x4(%eax)
8010443c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010443f:	8b 40 04             	mov    0x4(%eax),%eax
80104442:	85 c0                	test   %eax,%eax
80104444:	75 0d                	jne    80104453 <userinit+0x3a>
    panic("userinit: out of memory?");
80104446:	83 ec 0c             	sub    $0xc,%esp
80104449:	68 e0 b6 10 80       	push   $0x8010b6e0
8010444e:	e8 13 c1 ff ff       	call   80100566 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104453:	ba 2c 00 00 00       	mov    $0x2c,%edx
80104458:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010445b:	8b 40 04             	mov    0x4(%eax),%eax
8010445e:	83 ec 04             	sub    $0x4,%esp
80104461:	52                   	push   %edx
80104462:	68 10 e5 10 80       	push   $0x8010e510
80104467:	50                   	push   %eax
80104468:	e8 22 39 00 00       	call   80107d8f <inituvm>
8010446d:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
80104470:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104473:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
80104479:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010447c:	8b 40 18             	mov    0x18(%eax),%eax
8010447f:	83 ec 04             	sub    $0x4,%esp
80104482:	6a 4c                	push   $0x4c
80104484:	6a 00                	push   $0x0
80104486:	50                   	push   %eax
80104487:	e8 37 0c 00 00       	call   801050c3 <memset>
8010448c:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010448f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104492:	8b 40 18             	mov    0x18(%eax),%eax
80104495:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010449b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010449e:	8b 40 18             	mov    0x18(%eax),%eax
801044a1:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
801044a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044aa:	8b 40 18             	mov    0x18(%eax),%eax
801044ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044b0:	8b 52 18             	mov    0x18(%edx),%edx
801044b3:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801044b7:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801044bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044be:	8b 40 18             	mov    0x18(%eax),%eax
801044c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044c4:	8b 52 18             	mov    0x18(%edx),%edx
801044c7:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801044cb:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801044cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044d2:	8b 40 18             	mov    0x18(%eax),%eax
801044d5:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801044dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044df:	8b 40 18             	mov    0x18(%eax),%eax
801044e2:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801044e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044ec:	8b 40 18             	mov    0x18(%eax),%eax
801044ef:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
801044f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044f9:	83 c0 6c             	add    $0x6c,%eax
801044fc:	83 ec 04             	sub    $0x4,%esp
801044ff:	6a 10                	push   $0x10
80104501:	68 f9 b6 10 80       	push   $0x8010b6f9
80104506:	50                   	push   %eax
80104507:	e8 ba 0d 00 00       	call   801052c6 <safestrcpy>
8010450c:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
8010450f:	83 ec 0c             	sub    $0xc,%esp
80104512:	68 02 b7 10 80       	push   $0x8010b702
80104517:	e8 e2 e0 ff ff       	call   801025fe <namei>
8010451c:	83 c4 10             	add    $0x10,%esp
8010451f:	89 c2                	mov    %eax,%edx
80104521:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104524:	89 50 68             	mov    %edx,0x68(%eax)

  p->state = RUNNABLE;
80104527:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010452a:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
80104531:	90                   	nop
80104532:	c9                   	leave  
80104533:	c3                   	ret    

80104534 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104534:	55                   	push   %ebp
80104535:	89 e5                	mov    %esp,%ebp
80104537:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  
  sz = proc->sz;
8010453a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104540:	8b 00                	mov    (%eax),%eax
80104542:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80104545:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104549:	7e 31                	jle    8010457c <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
8010454b:	8b 55 08             	mov    0x8(%ebp),%edx
8010454e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104551:	01 c2                	add    %eax,%edx
80104553:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104559:	8b 40 04             	mov    0x4(%eax),%eax
8010455c:	83 ec 04             	sub    $0x4,%esp
8010455f:	52                   	push   %edx
80104560:	ff 75 f4             	pushl  -0xc(%ebp)
80104563:	50                   	push   %eax
80104564:	e8 73 39 00 00       	call   80107edc <allocuvm>
80104569:	83 c4 10             	add    $0x10,%esp
8010456c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010456f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104573:	75 3e                	jne    801045b3 <growproc+0x7f>
      return -1;
80104575:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010457a:	eb 59                	jmp    801045d5 <growproc+0xa1>
  } else if(n < 0){
8010457c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104580:	79 31                	jns    801045b3 <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80104582:	8b 55 08             	mov    0x8(%ebp),%edx
80104585:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104588:	01 c2                	add    %eax,%edx
8010458a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104590:	8b 40 04             	mov    0x4(%eax),%eax
80104593:	83 ec 04             	sub    $0x4,%esp
80104596:	52                   	push   %edx
80104597:	ff 75 f4             	pushl  -0xc(%ebp)
8010459a:	50                   	push   %eax
8010459b:	e8 05 3a 00 00       	call   80107fa5 <deallocuvm>
801045a0:	83 c4 10             	add    $0x10,%esp
801045a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801045a6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801045aa:	75 07                	jne    801045b3 <growproc+0x7f>
      return -1;
801045ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045b1:	eb 22                	jmp    801045d5 <growproc+0xa1>
  }
  proc->sz = sz;
801045b3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045bc:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
801045be:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045c4:	83 ec 0c             	sub    $0xc,%esp
801045c7:	50                   	push   %eax
801045c8:	e8 4f 36 00 00       	call   80107c1c <switchuvm>
801045cd:	83 c4 10             	add    $0x10,%esp
  return 0;
801045d0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801045d5:	c9                   	leave  
801045d6:	c3                   	ret    

801045d7 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801045d7:	55                   	push   %ebp
801045d8:	89 e5                	mov    %esp,%ebp
801045da:	57                   	push   %edi
801045db:	56                   	push   %esi
801045dc:	53                   	push   %ebx
801045dd:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
801045e0:	e8 2e fd ff ff       	call   80104313 <allocproc>
801045e5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801045e8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801045ec:	75 0a                	jne    801045f8 <fork+0x21>
    return -1;
801045ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045f3:	e9 48 01 00 00       	jmp    80104740 <fork+0x169>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
801045f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045fe:	8b 10                	mov    (%eax),%edx
80104600:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104606:	8b 40 04             	mov    0x4(%eax),%eax
80104609:	83 ec 08             	sub    $0x8,%esp
8010460c:	52                   	push   %edx
8010460d:	50                   	push   %eax
8010460e:	e8 30 3b 00 00       	call   80108143 <copyuvm>
80104613:	83 c4 10             	add    $0x10,%esp
80104616:	89 c2                	mov    %eax,%edx
80104618:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010461b:	89 50 04             	mov    %edx,0x4(%eax)
8010461e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104621:	8b 40 04             	mov    0x4(%eax),%eax
80104624:	85 c0                	test   %eax,%eax
80104626:	75 30                	jne    80104658 <fork+0x81>
    kfree(np->kstack);
80104628:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010462b:	8b 40 08             	mov    0x8(%eax),%eax
8010462e:	83 ec 0c             	sub    $0xc,%esp
80104631:	50                   	push   %eax
80104632:	e8 2c e6 ff ff       	call   80102c63 <kfree>
80104637:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
8010463a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010463d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80104644:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104647:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
8010464e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104653:	e9 e8 00 00 00       	jmp    80104740 <fork+0x169>
  }
  np->sz = proc->sz;
80104658:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010465e:	8b 10                	mov    (%eax),%edx
80104660:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104663:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
80104665:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010466c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010466f:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
80104672:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104675:	8b 50 18             	mov    0x18(%eax),%edx
80104678:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010467e:	8b 40 18             	mov    0x18(%eax),%eax
80104681:	89 c3                	mov    %eax,%ebx
80104683:	b8 13 00 00 00       	mov    $0x13,%eax
80104688:	89 d7                	mov    %edx,%edi
8010468a:	89 de                	mov    %ebx,%esi
8010468c:	89 c1                	mov    %eax,%ecx
8010468e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104690:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104693:	8b 40 18             	mov    0x18(%eax),%eax
80104696:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
8010469d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801046a4:	eb 43                	jmp    801046e9 <fork+0x112>
    if(proc->ofile[i])
801046a6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046ac:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801046af:	83 c2 08             	add    $0x8,%edx
801046b2:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801046b6:	85 c0                	test   %eax,%eax
801046b8:	74 2b                	je     801046e5 <fork+0x10e>
      np->ofile[i] = filedup(proc->ofile[i]);
801046ba:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046c0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801046c3:	83 c2 08             	add    $0x8,%edx
801046c6:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801046ca:	83 ec 0c             	sub    $0xc,%esp
801046cd:	50                   	push   %eax
801046ce:	e8 fe c8 ff ff       	call   80100fd1 <filedup>
801046d3:	83 c4 10             	add    $0x10,%esp
801046d6:	89 c1                	mov    %eax,%ecx
801046d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046db:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801046de:	83 c2 08             	add    $0x8,%edx
801046e1:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801046e5:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801046e9:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
801046ed:	7e b7                	jle    801046a6 <fork+0xcf>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
801046ef:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046f5:	8b 40 68             	mov    0x68(%eax),%eax
801046f8:	83 ec 0c             	sub    $0xc,%esp
801046fb:	50                   	push   %eax
801046fc:	e8 bc d1 ff ff       	call   801018bd <idup>
80104701:	83 c4 10             	add    $0x10,%esp
80104704:	89 c2                	mov    %eax,%edx
80104706:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104709:	89 50 68             	mov    %edx,0x68(%eax)
 
  pid = np->pid;
8010470c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010470f:	8b 40 10             	mov    0x10(%eax),%eax
80104712:	89 45 dc             	mov    %eax,-0x24(%ebp)
  np->state = RUNNABLE;
80104715:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104718:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
8010471f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104725:	8d 50 6c             	lea    0x6c(%eax),%edx
80104728:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010472b:	83 c0 6c             	add    $0x6c,%eax
8010472e:	83 ec 04             	sub    $0x4,%esp
80104731:	6a 10                	push   $0x10
80104733:	52                   	push   %edx
80104734:	50                   	push   %eax
80104735:	e8 8c 0b 00 00       	call   801052c6 <safestrcpy>
8010473a:	83 c4 10             	add    $0x10,%esp
  return pid;
8010473d:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80104740:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104743:	5b                   	pop    %ebx
80104744:	5e                   	pop    %esi
80104745:	5f                   	pop    %edi
80104746:	5d                   	pop    %ebp
80104747:	c3                   	ret    

80104748 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80104748:	55                   	push   %ebp
80104749:	89 e5                	mov    %esp,%ebp
8010474b:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
8010474e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104755:	a1 8c e6 10 80       	mov    0x8010e68c,%eax
8010475a:	39 c2                	cmp    %eax,%edx
8010475c:	75 0d                	jne    8010476b <exit+0x23>
    panic("init exiting");
8010475e:	83 ec 0c             	sub    $0xc,%esp
80104761:	68 04 b7 10 80       	push   $0x8010b704
80104766:	e8 fb bd ff ff       	call   80100566 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
8010476b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104772:	eb 48                	jmp    801047bc <exit+0x74>
    if(proc->ofile[fd]){
80104774:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010477a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010477d:	83 c2 08             	add    $0x8,%edx
80104780:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104784:	85 c0                	test   %eax,%eax
80104786:	74 30                	je     801047b8 <exit+0x70>
      fileclose(proc->ofile[fd]);
80104788:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010478e:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104791:	83 c2 08             	add    $0x8,%edx
80104794:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104798:	83 ec 0c             	sub    $0xc,%esp
8010479b:	50                   	push   %eax
8010479c:	e8 81 c8 ff ff       	call   80101022 <fileclose>
801047a1:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
801047a4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047aa:	8b 55 f0             	mov    -0x10(%ebp),%edx
801047ad:	83 c2 08             	add    $0x8,%edx
801047b0:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801047b7:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801047b8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801047bc:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
801047c0:	7e b2                	jle    80104774 <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
801047c2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047c8:	8b 40 68             	mov    0x68(%eax),%eax
801047cb:	83 ec 0c             	sub    $0xc,%esp
801047ce:	50                   	push   %eax
801047cf:	e8 ed d2 ff ff       	call   80101ac1 <iput>
801047d4:	83 c4 10             	add    $0x10,%esp
  proc->cwd = 0;
801047d7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047dd:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
801047e4:	83 ec 0c             	sub    $0xc,%esp
801047e7:	68 80 2f 11 80       	push   $0x80112f80
801047ec:	e8 6f 06 00 00       	call   80104e60 <acquire>
801047f1:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
801047f4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047fa:	8b 40 14             	mov    0x14(%eax),%eax
801047fd:	83 ec 0c             	sub    $0xc,%esp
80104800:	50                   	push   %eax
80104801:	e8 0d 04 00 00       	call   80104c13 <wakeup1>
80104806:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104809:	c7 45 f4 b4 2f 11 80 	movl   $0x80112fb4,-0xc(%ebp)
80104810:	eb 3c                	jmp    8010484e <exit+0x106>
    if(p->parent == proc){
80104812:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104815:	8b 50 14             	mov    0x14(%eax),%edx
80104818:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010481e:	39 c2                	cmp    %eax,%edx
80104820:	75 28                	jne    8010484a <exit+0x102>
      p->parent = initproc;
80104822:	8b 15 8c e6 10 80    	mov    0x8010e68c,%edx
80104828:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010482b:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
8010482e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104831:	8b 40 0c             	mov    0xc(%eax),%eax
80104834:	83 f8 05             	cmp    $0x5,%eax
80104837:	75 11                	jne    8010484a <exit+0x102>
        wakeup1(initproc);
80104839:	a1 8c e6 10 80       	mov    0x8010e68c,%eax
8010483e:	83 ec 0c             	sub    $0xc,%esp
80104841:	50                   	push   %eax
80104842:	e8 cc 03 00 00       	call   80104c13 <wakeup1>
80104847:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010484a:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
8010484e:	81 7d f4 b4 4e 11 80 	cmpl   $0x80114eb4,-0xc(%ebp)
80104855:	72 bb                	jb     80104812 <exit+0xca>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80104857:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010485d:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
80104864:	e8 d6 01 00 00       	call   80104a3f <sched>
  panic("zombie exit");
80104869:	83 ec 0c             	sub    $0xc,%esp
8010486c:	68 11 b7 10 80       	push   $0x8010b711
80104871:	e8 f0 bc ff ff       	call   80100566 <panic>

80104876 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104876:	55                   	push   %ebp
80104877:	89 e5                	mov    %esp,%ebp
80104879:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
8010487c:	83 ec 0c             	sub    $0xc,%esp
8010487f:	68 80 2f 11 80       	push   $0x80112f80
80104884:	e8 d7 05 00 00       	call   80104e60 <acquire>
80104889:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
8010488c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104893:	c7 45 f4 b4 2f 11 80 	movl   $0x80112fb4,-0xc(%ebp)
8010489a:	e9 a6 00 00 00       	jmp    80104945 <wait+0xcf>
      if(p->parent != proc)
8010489f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048a2:	8b 50 14             	mov    0x14(%eax),%edx
801048a5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048ab:	39 c2                	cmp    %eax,%edx
801048ad:	0f 85 8d 00 00 00    	jne    80104940 <wait+0xca>
        continue;
      havekids = 1;
801048b3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
801048ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048bd:	8b 40 0c             	mov    0xc(%eax),%eax
801048c0:	83 f8 05             	cmp    $0x5,%eax
801048c3:	75 7c                	jne    80104941 <wait+0xcb>
        // Found one.
        pid = p->pid;
801048c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048c8:	8b 40 10             	mov    0x10(%eax),%eax
801048cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
801048ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048d1:	8b 40 08             	mov    0x8(%eax),%eax
801048d4:	83 ec 0c             	sub    $0xc,%esp
801048d7:	50                   	push   %eax
801048d8:	e8 86 e3 ff ff       	call   80102c63 <kfree>
801048dd:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
801048e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048e3:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
801048ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048ed:	8b 40 04             	mov    0x4(%eax),%eax
801048f0:	83 ec 0c             	sub    $0xc,%esp
801048f3:	50                   	push   %eax
801048f4:	e8 69 37 00 00       	call   80108062 <freevm>
801048f9:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
801048fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048ff:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
80104906:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104909:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104910:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104913:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
8010491a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010491d:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104921:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104924:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
8010492b:	83 ec 0c             	sub    $0xc,%esp
8010492e:	68 80 2f 11 80       	push   $0x80112f80
80104933:	e8 8f 05 00 00       	call   80104ec7 <release>
80104938:	83 c4 10             	add    $0x10,%esp
        return pid;
8010493b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010493e:	eb 58                	jmp    80104998 <wait+0x122>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
80104940:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104941:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104945:	81 7d f4 b4 4e 11 80 	cmpl   $0x80114eb4,-0xc(%ebp)
8010494c:	0f 82 4d ff ff ff    	jb     8010489f <wait+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104952:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104956:	74 0d                	je     80104965 <wait+0xef>
80104958:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010495e:	8b 40 24             	mov    0x24(%eax),%eax
80104961:	85 c0                	test   %eax,%eax
80104963:	74 17                	je     8010497c <wait+0x106>
      release(&ptable.lock);
80104965:	83 ec 0c             	sub    $0xc,%esp
80104968:	68 80 2f 11 80       	push   $0x80112f80
8010496d:	e8 55 05 00 00       	call   80104ec7 <release>
80104972:	83 c4 10             	add    $0x10,%esp
      return -1;
80104975:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010497a:	eb 1c                	jmp    80104998 <wait+0x122>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
8010497c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104982:	83 ec 08             	sub    $0x8,%esp
80104985:	68 80 2f 11 80       	push   $0x80112f80
8010498a:	50                   	push   %eax
8010498b:	e8 d7 01 00 00       	call   80104b67 <sleep>
80104990:	83 c4 10             	add    $0x10,%esp
  }
80104993:	e9 f4 fe ff ff       	jmp    8010488c <wait+0x16>
}
80104998:	c9                   	leave  
80104999:	c3                   	ret    

8010499a <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
8010499a:	55                   	push   %ebp
8010499b:	89 e5                	mov    %esp,%ebp
8010499d:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
801049a0:	e8 49 f9 ff ff       	call   801042ee <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
801049a5:	83 ec 0c             	sub    $0xc,%esp
801049a8:	68 80 2f 11 80       	push   $0x80112f80
801049ad:	e8 ae 04 00 00       	call   80104e60 <acquire>
801049b2:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049b5:	c7 45 f4 b4 2f 11 80 	movl   $0x80112fb4,-0xc(%ebp)
801049bc:	eb 63                	jmp    80104a21 <scheduler+0x87>
      if(p->state != RUNNABLE)
801049be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049c1:	8b 40 0c             	mov    0xc(%eax),%eax
801049c4:	83 f8 03             	cmp    $0x3,%eax
801049c7:	75 53                	jne    80104a1c <scheduler+0x82>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
801049c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049cc:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
801049d2:	83 ec 0c             	sub    $0xc,%esp
801049d5:	ff 75 f4             	pushl  -0xc(%ebp)
801049d8:	e8 3f 32 00 00       	call   80107c1c <switchuvm>
801049dd:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
801049e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049e3:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
801049ea:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049f0:	8b 40 1c             	mov    0x1c(%eax),%eax
801049f3:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801049fa:	83 c2 04             	add    $0x4,%edx
801049fd:	83 ec 08             	sub    $0x8,%esp
80104a00:	50                   	push   %eax
80104a01:	52                   	push   %edx
80104a02:	e8 30 09 00 00       	call   80105337 <swtch>
80104a07:	83 c4 10             	add    $0x10,%esp
      switchkvm();
80104a0a:	e8 f0 31 00 00       	call   80107bff <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80104a0f:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104a16:	00 00 00 00 
80104a1a:	eb 01                	jmp    80104a1d <scheduler+0x83>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;
80104a1c:	90                   	nop
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a1d:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104a21:	81 7d f4 b4 4e 11 80 	cmpl   $0x80114eb4,-0xc(%ebp)
80104a28:	72 94                	jb     801049be <scheduler+0x24>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80104a2a:	83 ec 0c             	sub    $0xc,%esp
80104a2d:	68 80 2f 11 80       	push   $0x80112f80
80104a32:	e8 90 04 00 00       	call   80104ec7 <release>
80104a37:	83 c4 10             	add    $0x10,%esp

  }
80104a3a:	e9 61 ff ff ff       	jmp    801049a0 <scheduler+0x6>

80104a3f <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104a3f:	55                   	push   %ebp
80104a40:	89 e5                	mov    %esp,%ebp
80104a42:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104a45:	83 ec 0c             	sub    $0xc,%esp
80104a48:	68 80 2f 11 80       	push   $0x80112f80
80104a4d:	e8 41 05 00 00       	call   80104f93 <holding>
80104a52:	83 c4 10             	add    $0x10,%esp
80104a55:	85 c0                	test   %eax,%eax
80104a57:	75 0d                	jne    80104a66 <sched+0x27>
    panic("sched ptable.lock");
80104a59:	83 ec 0c             	sub    $0xc,%esp
80104a5c:	68 1d b7 10 80       	push   $0x8010b71d
80104a61:	e8 00 bb ff ff       	call   80100566 <panic>
  if(cpu->ncli != 1)
80104a66:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104a6c:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104a72:	83 f8 01             	cmp    $0x1,%eax
80104a75:	74 0d                	je     80104a84 <sched+0x45>
    panic("sched locks");
80104a77:	83 ec 0c             	sub    $0xc,%esp
80104a7a:	68 2f b7 10 80       	push   $0x8010b72f
80104a7f:	e8 e2 ba ff ff       	call   80100566 <panic>
  if(proc->state == RUNNING)
80104a84:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a8a:	8b 40 0c             	mov    0xc(%eax),%eax
80104a8d:	83 f8 04             	cmp    $0x4,%eax
80104a90:	75 0d                	jne    80104a9f <sched+0x60>
    panic("sched running");
80104a92:	83 ec 0c             	sub    $0xc,%esp
80104a95:	68 3b b7 10 80       	push   $0x8010b73b
80104a9a:	e8 c7 ba ff ff       	call   80100566 <panic>
  if(readeflags()&FL_IF)
80104a9f:	e8 3a f8 ff ff       	call   801042de <readeflags>
80104aa4:	25 00 02 00 00       	and    $0x200,%eax
80104aa9:	85 c0                	test   %eax,%eax
80104aab:	74 0d                	je     80104aba <sched+0x7b>
    panic("sched interruptible");
80104aad:	83 ec 0c             	sub    $0xc,%esp
80104ab0:	68 49 b7 10 80       	push   $0x8010b749
80104ab5:	e8 ac ba ff ff       	call   80100566 <panic>
  intena = cpu->intena;
80104aba:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104ac0:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104ac6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104ac9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104acf:	8b 40 04             	mov    0x4(%eax),%eax
80104ad2:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104ad9:	83 c2 1c             	add    $0x1c,%edx
80104adc:	83 ec 08             	sub    $0x8,%esp
80104adf:	50                   	push   %eax
80104ae0:	52                   	push   %edx
80104ae1:	e8 51 08 00 00       	call   80105337 <swtch>
80104ae6:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80104ae9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104aef:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104af2:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104af8:	90                   	nop
80104af9:	c9                   	leave  
80104afa:	c3                   	ret    

80104afb <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104afb:	55                   	push   %ebp
80104afc:	89 e5                	mov    %esp,%ebp
80104afe:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104b01:	83 ec 0c             	sub    $0xc,%esp
80104b04:	68 80 2f 11 80       	push   $0x80112f80
80104b09:	e8 52 03 00 00       	call   80104e60 <acquire>
80104b0e:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104b11:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b17:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104b1e:	e8 1c ff ff ff       	call   80104a3f <sched>
  release(&ptable.lock);
80104b23:	83 ec 0c             	sub    $0xc,%esp
80104b26:	68 80 2f 11 80       	push   $0x80112f80
80104b2b:	e8 97 03 00 00       	call   80104ec7 <release>
80104b30:	83 c4 10             	add    $0x10,%esp
}
80104b33:	90                   	nop
80104b34:	c9                   	leave  
80104b35:	c3                   	ret    

80104b36 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104b36:	55                   	push   %ebp
80104b37:	89 e5                	mov    %esp,%ebp
80104b39:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104b3c:	83 ec 0c             	sub    $0xc,%esp
80104b3f:	68 80 2f 11 80       	push   $0x80112f80
80104b44:	e8 7e 03 00 00       	call   80104ec7 <release>
80104b49:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104b4c:	a1 08 e0 10 80       	mov    0x8010e008,%eax
80104b51:	85 c0                	test   %eax,%eax
80104b53:	74 0f                	je     80104b64 <forkret+0x2e>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104b55:	c7 05 08 e0 10 80 00 	movl   $0x0,0x8010e008
80104b5c:	00 00 00 
    initlog();
80104b5f:	e8 7c e7 ff ff       	call   801032e0 <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80104b64:	90                   	nop
80104b65:	c9                   	leave  
80104b66:	c3                   	ret    

80104b67 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104b67:	55                   	push   %ebp
80104b68:	89 e5                	mov    %esp,%ebp
80104b6a:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
80104b6d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b73:	85 c0                	test   %eax,%eax
80104b75:	75 0d                	jne    80104b84 <sleep+0x1d>
    panic("sleep");
80104b77:	83 ec 0c             	sub    $0xc,%esp
80104b7a:	68 5d b7 10 80       	push   $0x8010b75d
80104b7f:	e8 e2 b9 ff ff       	call   80100566 <panic>

  if(lk == 0)
80104b84:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104b88:	75 0d                	jne    80104b97 <sleep+0x30>
    panic("sleep without lk");
80104b8a:	83 ec 0c             	sub    $0xc,%esp
80104b8d:	68 63 b7 10 80       	push   $0x8010b763
80104b92:	e8 cf b9 ff ff       	call   80100566 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104b97:	81 7d 0c 80 2f 11 80 	cmpl   $0x80112f80,0xc(%ebp)
80104b9e:	74 1e                	je     80104bbe <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104ba0:	83 ec 0c             	sub    $0xc,%esp
80104ba3:	68 80 2f 11 80       	push   $0x80112f80
80104ba8:	e8 b3 02 00 00       	call   80104e60 <acquire>
80104bad:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104bb0:	83 ec 0c             	sub    $0xc,%esp
80104bb3:	ff 75 0c             	pushl  0xc(%ebp)
80104bb6:	e8 0c 03 00 00       	call   80104ec7 <release>
80104bbb:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80104bbe:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bc4:	8b 55 08             	mov    0x8(%ebp),%edx
80104bc7:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104bca:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bd0:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104bd7:	e8 63 fe ff ff       	call   80104a3f <sched>

  // Tidy up.
  proc->chan = 0;
80104bdc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104be2:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104be9:	81 7d 0c 80 2f 11 80 	cmpl   $0x80112f80,0xc(%ebp)
80104bf0:	74 1e                	je     80104c10 <sleep+0xa9>
    release(&ptable.lock);
80104bf2:	83 ec 0c             	sub    $0xc,%esp
80104bf5:	68 80 2f 11 80       	push   $0x80112f80
80104bfa:	e8 c8 02 00 00       	call   80104ec7 <release>
80104bff:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104c02:	83 ec 0c             	sub    $0xc,%esp
80104c05:	ff 75 0c             	pushl  0xc(%ebp)
80104c08:	e8 53 02 00 00       	call   80104e60 <acquire>
80104c0d:	83 c4 10             	add    $0x10,%esp
  }
}
80104c10:	90                   	nop
80104c11:	c9                   	leave  
80104c12:	c3                   	ret    

80104c13 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104c13:	55                   	push   %ebp
80104c14:	89 e5                	mov    %esp,%ebp
80104c16:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c19:	c7 45 fc b4 2f 11 80 	movl   $0x80112fb4,-0x4(%ebp)
80104c20:	eb 24                	jmp    80104c46 <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104c22:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c25:	8b 40 0c             	mov    0xc(%eax),%eax
80104c28:	83 f8 02             	cmp    $0x2,%eax
80104c2b:	75 15                	jne    80104c42 <wakeup1+0x2f>
80104c2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c30:	8b 40 20             	mov    0x20(%eax),%eax
80104c33:	3b 45 08             	cmp    0x8(%ebp),%eax
80104c36:	75 0a                	jne    80104c42 <wakeup1+0x2f>
      p->state = RUNNABLE;
80104c38:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c3b:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c42:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
80104c46:	81 7d fc b4 4e 11 80 	cmpl   $0x80114eb4,-0x4(%ebp)
80104c4d:	72 d3                	jb     80104c22 <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
80104c4f:	90                   	nop
80104c50:	c9                   	leave  
80104c51:	c3                   	ret    

80104c52 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104c52:	55                   	push   %ebp
80104c53:	89 e5                	mov    %esp,%ebp
80104c55:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104c58:	83 ec 0c             	sub    $0xc,%esp
80104c5b:	68 80 2f 11 80       	push   $0x80112f80
80104c60:	e8 fb 01 00 00       	call   80104e60 <acquire>
80104c65:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104c68:	83 ec 0c             	sub    $0xc,%esp
80104c6b:	ff 75 08             	pushl  0x8(%ebp)
80104c6e:	e8 a0 ff ff ff       	call   80104c13 <wakeup1>
80104c73:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104c76:	83 ec 0c             	sub    $0xc,%esp
80104c79:	68 80 2f 11 80       	push   $0x80112f80
80104c7e:	e8 44 02 00 00       	call   80104ec7 <release>
80104c83:	83 c4 10             	add    $0x10,%esp
}
80104c86:	90                   	nop
80104c87:	c9                   	leave  
80104c88:	c3                   	ret    

80104c89 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104c89:	55                   	push   %ebp
80104c8a:	89 e5                	mov    %esp,%ebp
80104c8c:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104c8f:	83 ec 0c             	sub    $0xc,%esp
80104c92:	68 80 2f 11 80       	push   $0x80112f80
80104c97:	e8 c4 01 00 00       	call   80104e60 <acquire>
80104c9c:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c9f:	c7 45 f4 b4 2f 11 80 	movl   $0x80112fb4,-0xc(%ebp)
80104ca6:	eb 45                	jmp    80104ced <kill+0x64>
    if(p->pid == pid){
80104ca8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cab:	8b 40 10             	mov    0x10(%eax),%eax
80104cae:	3b 45 08             	cmp    0x8(%ebp),%eax
80104cb1:	75 36                	jne    80104ce9 <kill+0x60>
      p->killed = 1;
80104cb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cb6:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104cbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cc0:	8b 40 0c             	mov    0xc(%eax),%eax
80104cc3:	83 f8 02             	cmp    $0x2,%eax
80104cc6:	75 0a                	jne    80104cd2 <kill+0x49>
        p->state = RUNNABLE;
80104cc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ccb:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104cd2:	83 ec 0c             	sub    $0xc,%esp
80104cd5:	68 80 2f 11 80       	push   $0x80112f80
80104cda:	e8 e8 01 00 00       	call   80104ec7 <release>
80104cdf:	83 c4 10             	add    $0x10,%esp
      return 0;
80104ce2:	b8 00 00 00 00       	mov    $0x0,%eax
80104ce7:	eb 22                	jmp    80104d0b <kill+0x82>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ce9:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104ced:	81 7d f4 b4 4e 11 80 	cmpl   $0x80114eb4,-0xc(%ebp)
80104cf4:	72 b2                	jb     80104ca8 <kill+0x1f>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104cf6:	83 ec 0c             	sub    $0xc,%esp
80104cf9:	68 80 2f 11 80       	push   $0x80112f80
80104cfe:	e8 c4 01 00 00       	call   80104ec7 <release>
80104d03:	83 c4 10             	add    $0x10,%esp
  return -1;
80104d06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d0b:	c9                   	leave  
80104d0c:	c3                   	ret    

80104d0d <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104d0d:	55                   	push   %ebp
80104d0e:	89 e5                	mov    %esp,%ebp
80104d10:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d13:	c7 45 f0 b4 2f 11 80 	movl   $0x80112fb4,-0x10(%ebp)
80104d1a:	e9 d7 00 00 00       	jmp    80104df6 <procdump+0xe9>
    if(p->state == UNUSED)
80104d1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d22:	8b 40 0c             	mov    0xc(%eax),%eax
80104d25:	85 c0                	test   %eax,%eax
80104d27:	0f 84 c4 00 00 00    	je     80104df1 <procdump+0xe4>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104d2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d30:	8b 40 0c             	mov    0xc(%eax),%eax
80104d33:	83 f8 05             	cmp    $0x5,%eax
80104d36:	77 23                	ja     80104d5b <procdump+0x4e>
80104d38:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d3b:	8b 40 0c             	mov    0xc(%eax),%eax
80104d3e:	8b 04 85 0c e0 10 80 	mov    -0x7fef1ff4(,%eax,4),%eax
80104d45:	85 c0                	test   %eax,%eax
80104d47:	74 12                	je     80104d5b <procdump+0x4e>
      state = states[p->state];
80104d49:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d4c:	8b 40 0c             	mov    0xc(%eax),%eax
80104d4f:	8b 04 85 0c e0 10 80 	mov    -0x7fef1ff4(,%eax,4),%eax
80104d56:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104d59:	eb 07                	jmp    80104d62 <procdump+0x55>
    else
      state = "???";
80104d5b:	c7 45 ec 74 b7 10 80 	movl   $0x8010b774,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104d62:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d65:	8d 50 6c             	lea    0x6c(%eax),%edx
80104d68:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d6b:	8b 40 10             	mov    0x10(%eax),%eax
80104d6e:	52                   	push   %edx
80104d6f:	ff 75 ec             	pushl  -0x14(%ebp)
80104d72:	50                   	push   %eax
80104d73:	68 78 b7 10 80       	push   $0x8010b778
80104d78:	e8 49 b6 ff ff       	call   801003c6 <cprintf>
80104d7d:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80104d80:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d83:	8b 40 0c             	mov    0xc(%eax),%eax
80104d86:	83 f8 02             	cmp    $0x2,%eax
80104d89:	75 54                	jne    80104ddf <procdump+0xd2>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104d8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d8e:	8b 40 1c             	mov    0x1c(%eax),%eax
80104d91:	8b 40 0c             	mov    0xc(%eax),%eax
80104d94:	83 c0 08             	add    $0x8,%eax
80104d97:	89 c2                	mov    %eax,%edx
80104d99:	83 ec 08             	sub    $0x8,%esp
80104d9c:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104d9f:	50                   	push   %eax
80104da0:	52                   	push   %edx
80104da1:	e8 73 01 00 00       	call   80104f19 <getcallerpcs>
80104da6:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104da9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104db0:	eb 1c                	jmp    80104dce <procdump+0xc1>
        cprintf(" %p", pc[i]);
80104db2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104db5:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104db9:	83 ec 08             	sub    $0x8,%esp
80104dbc:	50                   	push   %eax
80104dbd:	68 81 b7 10 80       	push   $0x8010b781
80104dc2:	e8 ff b5 ff ff       	call   801003c6 <cprintf>
80104dc7:	83 c4 10             	add    $0x10,%esp
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104dca:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104dce:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104dd2:	7f 0b                	jg     80104ddf <procdump+0xd2>
80104dd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104dd7:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104ddb:	85 c0                	test   %eax,%eax
80104ddd:	75 d3                	jne    80104db2 <procdump+0xa5>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104ddf:	83 ec 0c             	sub    $0xc,%esp
80104de2:	68 85 b7 10 80       	push   $0x8010b785
80104de7:	e8 da b5 ff ff       	call   801003c6 <cprintf>
80104dec:	83 c4 10             	add    $0x10,%esp
80104def:	eb 01                	jmp    80104df2 <procdump+0xe5>
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
80104df1:	90                   	nop
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104df2:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104df6:	81 7d f0 b4 4e 11 80 	cmpl   $0x80114eb4,-0x10(%ebp)
80104dfd:	0f 82 1c ff ff ff    	jb     80104d1f <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104e03:	90                   	nop
80104e04:	c9                   	leave  
80104e05:	c3                   	ret    

80104e06 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104e06:	55                   	push   %ebp
80104e07:	89 e5                	mov    %esp,%ebp
80104e09:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104e0c:	9c                   	pushf  
80104e0d:	58                   	pop    %eax
80104e0e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104e11:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104e14:	c9                   	leave  
80104e15:	c3                   	ret    

80104e16 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80104e16:	55                   	push   %ebp
80104e17:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104e19:	fa                   	cli    
}
80104e1a:	90                   	nop
80104e1b:	5d                   	pop    %ebp
80104e1c:	c3                   	ret    

80104e1d <sti>:

static inline void
sti(void)
{
80104e1d:	55                   	push   %ebp
80104e1e:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104e20:	fb                   	sti    
}
80104e21:	90                   	nop
80104e22:	5d                   	pop    %ebp
80104e23:	c3                   	ret    

80104e24 <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80104e24:	55                   	push   %ebp
80104e25:	89 e5                	mov    %esp,%ebp
80104e27:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104e2a:	8b 55 08             	mov    0x8(%ebp),%edx
80104e2d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e30:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e33:	f0 87 02             	lock xchg %eax,(%edx)
80104e36:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104e39:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104e3c:	c9                   	leave  
80104e3d:	c3                   	ret    

80104e3e <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104e3e:	55                   	push   %ebp
80104e3f:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104e41:	8b 45 08             	mov    0x8(%ebp),%eax
80104e44:	8b 55 0c             	mov    0xc(%ebp),%edx
80104e47:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104e4a:	8b 45 08             	mov    0x8(%ebp),%eax
80104e4d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104e53:	8b 45 08             	mov    0x8(%ebp),%eax
80104e56:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104e5d:	90                   	nop
80104e5e:	5d                   	pop    %ebp
80104e5f:	c3                   	ret    

80104e60 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104e66:	e8 52 01 00 00       	call   80104fbd <pushcli>
  if(holding(lk))
80104e6b:	8b 45 08             	mov    0x8(%ebp),%eax
80104e6e:	83 ec 0c             	sub    $0xc,%esp
80104e71:	50                   	push   %eax
80104e72:	e8 1c 01 00 00       	call   80104f93 <holding>
80104e77:	83 c4 10             	add    $0x10,%esp
80104e7a:	85 c0                	test   %eax,%eax
80104e7c:	74 0d                	je     80104e8b <acquire+0x2b>
    panic("acquire");
80104e7e:	83 ec 0c             	sub    $0xc,%esp
80104e81:	68 b1 b7 10 80       	push   $0x8010b7b1
80104e86:	e8 db b6 ff ff       	call   80100566 <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80104e8b:	90                   	nop
80104e8c:	8b 45 08             	mov    0x8(%ebp),%eax
80104e8f:	83 ec 08             	sub    $0x8,%esp
80104e92:	6a 01                	push   $0x1
80104e94:	50                   	push   %eax
80104e95:	e8 8a ff ff ff       	call   80104e24 <xchg>
80104e9a:	83 c4 10             	add    $0x10,%esp
80104e9d:	85 c0                	test   %eax,%eax
80104e9f:	75 eb                	jne    80104e8c <acquire+0x2c>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104ea1:	8b 45 08             	mov    0x8(%ebp),%eax
80104ea4:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104eab:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104eae:	8b 45 08             	mov    0x8(%ebp),%eax
80104eb1:	83 c0 0c             	add    $0xc,%eax
80104eb4:	83 ec 08             	sub    $0x8,%esp
80104eb7:	50                   	push   %eax
80104eb8:	8d 45 08             	lea    0x8(%ebp),%eax
80104ebb:	50                   	push   %eax
80104ebc:	e8 58 00 00 00       	call   80104f19 <getcallerpcs>
80104ec1:	83 c4 10             	add    $0x10,%esp
}
80104ec4:	90                   	nop
80104ec5:	c9                   	leave  
80104ec6:	c3                   	ret    

80104ec7 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80104ec7:	55                   	push   %ebp
80104ec8:	89 e5                	mov    %esp,%ebp
80104eca:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
80104ecd:	83 ec 0c             	sub    $0xc,%esp
80104ed0:	ff 75 08             	pushl  0x8(%ebp)
80104ed3:	e8 bb 00 00 00       	call   80104f93 <holding>
80104ed8:	83 c4 10             	add    $0x10,%esp
80104edb:	85 c0                	test   %eax,%eax
80104edd:	75 0d                	jne    80104eec <release+0x25>
    panic("release");
80104edf:	83 ec 0c             	sub    $0xc,%esp
80104ee2:	68 b9 b7 10 80       	push   $0x8010b7b9
80104ee7:	e8 7a b6 ff ff       	call   80100566 <panic>

  lk->pcs[0] = 0;
80104eec:	8b 45 08             	mov    0x8(%ebp),%eax
80104eef:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104ef6:	8b 45 08             	mov    0x8(%ebp),%eax
80104ef9:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80104f00:	8b 45 08             	mov    0x8(%ebp),%eax
80104f03:	83 ec 08             	sub    $0x8,%esp
80104f06:	6a 00                	push   $0x0
80104f08:	50                   	push   %eax
80104f09:	e8 16 ff ff ff       	call   80104e24 <xchg>
80104f0e:	83 c4 10             	add    $0x10,%esp

  popcli();
80104f11:	e8 ec 00 00 00       	call   80105002 <popcli>
}
80104f16:	90                   	nop
80104f17:	c9                   	leave  
80104f18:	c3                   	ret    

80104f19 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104f19:	55                   	push   %ebp
80104f1a:	89 e5                	mov    %esp,%ebp
80104f1c:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80104f1f:	8b 45 08             	mov    0x8(%ebp),%eax
80104f22:	83 e8 08             	sub    $0x8,%eax
80104f25:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80104f28:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80104f2f:	eb 38                	jmp    80104f69 <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f31:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80104f35:	74 53                	je     80104f8a <getcallerpcs+0x71>
80104f37:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80104f3e:	76 4a                	jbe    80104f8a <getcallerpcs+0x71>
80104f40:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80104f44:	74 44                	je     80104f8a <getcallerpcs+0x71>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104f46:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104f49:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104f50:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f53:	01 c2                	add    %eax,%edx
80104f55:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f58:	8b 40 04             	mov    0x4(%eax),%eax
80104f5b:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80104f5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f60:	8b 00                	mov    (%eax),%eax
80104f62:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104f65:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104f69:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104f6d:	7e c2                	jle    80104f31 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104f6f:	eb 19                	jmp    80104f8a <getcallerpcs+0x71>
    pcs[i] = 0;
80104f71:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104f74:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104f7b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f7e:	01 d0                	add    %edx,%eax
80104f80:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104f86:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104f8a:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104f8e:	7e e1                	jle    80104f71 <getcallerpcs+0x58>
    pcs[i] = 0;
}
80104f90:	90                   	nop
80104f91:	c9                   	leave  
80104f92:	c3                   	ret    

80104f93 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104f93:	55                   	push   %ebp
80104f94:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80104f96:	8b 45 08             	mov    0x8(%ebp),%eax
80104f99:	8b 00                	mov    (%eax),%eax
80104f9b:	85 c0                	test   %eax,%eax
80104f9d:	74 17                	je     80104fb6 <holding+0x23>
80104f9f:	8b 45 08             	mov    0x8(%ebp),%eax
80104fa2:	8b 50 08             	mov    0x8(%eax),%edx
80104fa5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104fab:	39 c2                	cmp    %eax,%edx
80104fad:	75 07                	jne    80104fb6 <holding+0x23>
80104faf:	b8 01 00 00 00       	mov    $0x1,%eax
80104fb4:	eb 05                	jmp    80104fbb <holding+0x28>
80104fb6:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104fbb:	5d                   	pop    %ebp
80104fbc:	c3                   	ret    

80104fbd <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104fbd:	55                   	push   %ebp
80104fbe:	89 e5                	mov    %esp,%ebp
80104fc0:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80104fc3:	e8 3e fe ff ff       	call   80104e06 <readeflags>
80104fc8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80104fcb:	e8 46 fe ff ff       	call   80104e16 <cli>
  if(cpu->ncli++ == 0)
80104fd0:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104fd7:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80104fdd:	8d 48 01             	lea    0x1(%eax),%ecx
80104fe0:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
80104fe6:	85 c0                	test   %eax,%eax
80104fe8:	75 15                	jne    80104fff <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
80104fea:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104ff0:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104ff3:	81 e2 00 02 00 00    	and    $0x200,%edx
80104ff9:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104fff:	90                   	nop
80105000:	c9                   	leave  
80105001:	c3                   	ret    

80105002 <popcli>:

void
popcli(void)
{
80105002:	55                   	push   %ebp
80105003:	89 e5                	mov    %esp,%ebp
80105005:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
80105008:	e8 f9 fd ff ff       	call   80104e06 <readeflags>
8010500d:	25 00 02 00 00       	and    $0x200,%eax
80105012:	85 c0                	test   %eax,%eax
80105014:	74 0d                	je     80105023 <popcli+0x21>
    panic("popcli - interruptible");
80105016:	83 ec 0c             	sub    $0xc,%esp
80105019:	68 c1 b7 10 80       	push   $0x8010b7c1
8010501e:	e8 43 b5 ff ff       	call   80100566 <panic>
  if(--cpu->ncli < 0)
80105023:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105029:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
8010502f:	83 ea 01             	sub    $0x1,%edx
80105032:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80105038:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010503e:	85 c0                	test   %eax,%eax
80105040:	79 0d                	jns    8010504f <popcli+0x4d>
    panic("popcli");
80105042:	83 ec 0c             	sub    $0xc,%esp
80105045:	68 d8 b7 10 80       	push   $0x8010b7d8
8010504a:	e8 17 b5 ff ff       	call   80100566 <panic>
  if(cpu->ncli == 0 && cpu->intena)
8010504f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105055:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010505b:	85 c0                	test   %eax,%eax
8010505d:	75 15                	jne    80105074 <popcli+0x72>
8010505f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105065:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
8010506b:	85 c0                	test   %eax,%eax
8010506d:	74 05                	je     80105074 <popcli+0x72>
    sti();
8010506f:	e8 a9 fd ff ff       	call   80104e1d <sti>
}
80105074:	90                   	nop
80105075:	c9                   	leave  
80105076:	c3                   	ret    

80105077 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
80105077:	55                   	push   %ebp
80105078:	89 e5                	mov    %esp,%ebp
8010507a:	57                   	push   %edi
8010507b:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
8010507c:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010507f:	8b 55 10             	mov    0x10(%ebp),%edx
80105082:	8b 45 0c             	mov    0xc(%ebp),%eax
80105085:	89 cb                	mov    %ecx,%ebx
80105087:	89 df                	mov    %ebx,%edi
80105089:	89 d1                	mov    %edx,%ecx
8010508b:	fc                   	cld    
8010508c:	f3 aa                	rep stos %al,%es:(%edi)
8010508e:	89 ca                	mov    %ecx,%edx
80105090:	89 fb                	mov    %edi,%ebx
80105092:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105095:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105098:	90                   	nop
80105099:	5b                   	pop    %ebx
8010509a:	5f                   	pop    %edi
8010509b:	5d                   	pop    %ebp
8010509c:	c3                   	ret    

8010509d <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
8010509d:	55                   	push   %ebp
8010509e:	89 e5                	mov    %esp,%ebp
801050a0:	57                   	push   %edi
801050a1:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
801050a2:	8b 4d 08             	mov    0x8(%ebp),%ecx
801050a5:	8b 55 10             	mov    0x10(%ebp),%edx
801050a8:	8b 45 0c             	mov    0xc(%ebp),%eax
801050ab:	89 cb                	mov    %ecx,%ebx
801050ad:	89 df                	mov    %ebx,%edi
801050af:	89 d1                	mov    %edx,%ecx
801050b1:	fc                   	cld    
801050b2:	f3 ab                	rep stos %eax,%es:(%edi)
801050b4:	89 ca                	mov    %ecx,%edx
801050b6:	89 fb                	mov    %edi,%ebx
801050b8:	89 5d 08             	mov    %ebx,0x8(%ebp)
801050bb:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
801050be:	90                   	nop
801050bf:	5b                   	pop    %ebx
801050c0:	5f                   	pop    %edi
801050c1:	5d                   	pop    %ebp
801050c2:	c3                   	ret    

801050c3 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801050c3:	55                   	push   %ebp
801050c4:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
801050c6:	8b 45 08             	mov    0x8(%ebp),%eax
801050c9:	83 e0 03             	and    $0x3,%eax
801050cc:	85 c0                	test   %eax,%eax
801050ce:	75 43                	jne    80105113 <memset+0x50>
801050d0:	8b 45 10             	mov    0x10(%ebp),%eax
801050d3:	83 e0 03             	and    $0x3,%eax
801050d6:	85 c0                	test   %eax,%eax
801050d8:	75 39                	jne    80105113 <memset+0x50>
    c &= 0xFF;
801050da:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801050e1:	8b 45 10             	mov    0x10(%ebp),%eax
801050e4:	c1 e8 02             	shr    $0x2,%eax
801050e7:	89 c1                	mov    %eax,%ecx
801050e9:	8b 45 0c             	mov    0xc(%ebp),%eax
801050ec:	c1 e0 18             	shl    $0x18,%eax
801050ef:	89 c2                	mov    %eax,%edx
801050f1:	8b 45 0c             	mov    0xc(%ebp),%eax
801050f4:	c1 e0 10             	shl    $0x10,%eax
801050f7:	09 c2                	or     %eax,%edx
801050f9:	8b 45 0c             	mov    0xc(%ebp),%eax
801050fc:	c1 e0 08             	shl    $0x8,%eax
801050ff:	09 d0                	or     %edx,%eax
80105101:	0b 45 0c             	or     0xc(%ebp),%eax
80105104:	51                   	push   %ecx
80105105:	50                   	push   %eax
80105106:	ff 75 08             	pushl  0x8(%ebp)
80105109:	e8 8f ff ff ff       	call   8010509d <stosl>
8010510e:	83 c4 0c             	add    $0xc,%esp
80105111:	eb 12                	jmp    80105125 <memset+0x62>
  } else
    stosb(dst, c, n);
80105113:	8b 45 10             	mov    0x10(%ebp),%eax
80105116:	50                   	push   %eax
80105117:	ff 75 0c             	pushl  0xc(%ebp)
8010511a:	ff 75 08             	pushl  0x8(%ebp)
8010511d:	e8 55 ff ff ff       	call   80105077 <stosb>
80105122:	83 c4 0c             	add    $0xc,%esp
  return dst;
80105125:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105128:	c9                   	leave  
80105129:	c3                   	ret    

8010512a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
8010512a:	55                   	push   %ebp
8010512b:	89 e5                	mov    %esp,%ebp
8010512d:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
80105130:	8b 45 08             	mov    0x8(%ebp),%eax
80105133:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
80105136:	8b 45 0c             	mov    0xc(%ebp),%eax
80105139:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
8010513c:	eb 30                	jmp    8010516e <memcmp+0x44>
    if(*s1 != *s2)
8010513e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105141:	0f b6 10             	movzbl (%eax),%edx
80105144:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105147:	0f b6 00             	movzbl (%eax),%eax
8010514a:	38 c2                	cmp    %al,%dl
8010514c:	74 18                	je     80105166 <memcmp+0x3c>
      return *s1 - *s2;
8010514e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105151:	0f b6 00             	movzbl (%eax),%eax
80105154:	0f b6 d0             	movzbl %al,%edx
80105157:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010515a:	0f b6 00             	movzbl (%eax),%eax
8010515d:	0f b6 c0             	movzbl %al,%eax
80105160:	29 c2                	sub    %eax,%edx
80105162:	89 d0                	mov    %edx,%eax
80105164:	eb 1a                	jmp    80105180 <memcmp+0x56>
    s1++, s2++;
80105166:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010516a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010516e:	8b 45 10             	mov    0x10(%ebp),%eax
80105171:	8d 50 ff             	lea    -0x1(%eax),%edx
80105174:	89 55 10             	mov    %edx,0x10(%ebp)
80105177:	85 c0                	test   %eax,%eax
80105179:	75 c3                	jne    8010513e <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010517b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105180:	c9                   	leave  
80105181:	c3                   	ret    

80105182 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105182:	55                   	push   %ebp
80105183:	89 e5                	mov    %esp,%ebp
80105185:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
80105188:	8b 45 0c             	mov    0xc(%ebp),%eax
8010518b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
8010518e:	8b 45 08             	mov    0x8(%ebp),%eax
80105191:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80105194:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105197:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010519a:	73 54                	jae    801051f0 <memmove+0x6e>
8010519c:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010519f:	8b 45 10             	mov    0x10(%ebp),%eax
801051a2:	01 d0                	add    %edx,%eax
801051a4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801051a7:	76 47                	jbe    801051f0 <memmove+0x6e>
    s += n;
801051a9:	8b 45 10             	mov    0x10(%ebp),%eax
801051ac:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
801051af:	8b 45 10             	mov    0x10(%ebp),%eax
801051b2:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
801051b5:	eb 13                	jmp    801051ca <memmove+0x48>
      *--d = *--s;
801051b7:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
801051bb:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
801051bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051c2:	0f b6 10             	movzbl (%eax),%edx
801051c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051c8:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801051ca:	8b 45 10             	mov    0x10(%ebp),%eax
801051cd:	8d 50 ff             	lea    -0x1(%eax),%edx
801051d0:	89 55 10             	mov    %edx,0x10(%ebp)
801051d3:	85 c0                	test   %eax,%eax
801051d5:	75 e0                	jne    801051b7 <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801051d7:	eb 24                	jmp    801051fd <memmove+0x7b>
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;
801051d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051dc:	8d 50 01             	lea    0x1(%eax),%edx
801051df:	89 55 f8             	mov    %edx,-0x8(%ebp)
801051e2:	8b 55 fc             	mov    -0x4(%ebp),%edx
801051e5:	8d 4a 01             	lea    0x1(%edx),%ecx
801051e8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
801051eb:	0f b6 12             	movzbl (%edx),%edx
801051ee:	88 10                	mov    %dl,(%eax)
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801051f0:	8b 45 10             	mov    0x10(%ebp),%eax
801051f3:	8d 50 ff             	lea    -0x1(%eax),%edx
801051f6:	89 55 10             	mov    %edx,0x10(%ebp)
801051f9:	85 c0                	test   %eax,%eax
801051fb:	75 dc                	jne    801051d9 <memmove+0x57>
      *d++ = *s++;

  return dst;
801051fd:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105200:	c9                   	leave  
80105201:	c3                   	ret    

80105202 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105202:	55                   	push   %ebp
80105203:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
80105205:	ff 75 10             	pushl  0x10(%ebp)
80105208:	ff 75 0c             	pushl  0xc(%ebp)
8010520b:	ff 75 08             	pushl  0x8(%ebp)
8010520e:	e8 6f ff ff ff       	call   80105182 <memmove>
80105213:	83 c4 0c             	add    $0xc,%esp
}
80105216:	c9                   	leave  
80105217:	c3                   	ret    

80105218 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105218:	55                   	push   %ebp
80105219:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
8010521b:	eb 0c                	jmp    80105229 <strncmp+0x11>
    n--, p++, q++;
8010521d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105221:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105225:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80105229:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010522d:	74 1a                	je     80105249 <strncmp+0x31>
8010522f:	8b 45 08             	mov    0x8(%ebp),%eax
80105232:	0f b6 00             	movzbl (%eax),%eax
80105235:	84 c0                	test   %al,%al
80105237:	74 10                	je     80105249 <strncmp+0x31>
80105239:	8b 45 08             	mov    0x8(%ebp),%eax
8010523c:	0f b6 10             	movzbl (%eax),%edx
8010523f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105242:	0f b6 00             	movzbl (%eax),%eax
80105245:	38 c2                	cmp    %al,%dl
80105247:	74 d4                	je     8010521d <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
80105249:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010524d:	75 07                	jne    80105256 <strncmp+0x3e>
    return 0;
8010524f:	b8 00 00 00 00       	mov    $0x0,%eax
80105254:	eb 16                	jmp    8010526c <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
80105256:	8b 45 08             	mov    0x8(%ebp),%eax
80105259:	0f b6 00             	movzbl (%eax),%eax
8010525c:	0f b6 d0             	movzbl %al,%edx
8010525f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105262:	0f b6 00             	movzbl (%eax),%eax
80105265:	0f b6 c0             	movzbl %al,%eax
80105268:	29 c2                	sub    %eax,%edx
8010526a:	89 d0                	mov    %edx,%eax
}
8010526c:	5d                   	pop    %ebp
8010526d:	c3                   	ret    

8010526e <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
8010526e:	55                   	push   %ebp
8010526f:	89 e5                	mov    %esp,%ebp
80105271:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105274:	8b 45 08             	mov    0x8(%ebp),%eax
80105277:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
8010527a:	90                   	nop
8010527b:	8b 45 10             	mov    0x10(%ebp),%eax
8010527e:	8d 50 ff             	lea    -0x1(%eax),%edx
80105281:	89 55 10             	mov    %edx,0x10(%ebp)
80105284:	85 c0                	test   %eax,%eax
80105286:	7e 2c                	jle    801052b4 <strncpy+0x46>
80105288:	8b 45 08             	mov    0x8(%ebp),%eax
8010528b:	8d 50 01             	lea    0x1(%eax),%edx
8010528e:	89 55 08             	mov    %edx,0x8(%ebp)
80105291:	8b 55 0c             	mov    0xc(%ebp),%edx
80105294:	8d 4a 01             	lea    0x1(%edx),%ecx
80105297:	89 4d 0c             	mov    %ecx,0xc(%ebp)
8010529a:	0f b6 12             	movzbl (%edx),%edx
8010529d:	88 10                	mov    %dl,(%eax)
8010529f:	0f b6 00             	movzbl (%eax),%eax
801052a2:	84 c0                	test   %al,%al
801052a4:	75 d5                	jne    8010527b <strncpy+0xd>
    ;
  while(n-- > 0)
801052a6:	eb 0c                	jmp    801052b4 <strncpy+0x46>
    *s++ = 0;
801052a8:	8b 45 08             	mov    0x8(%ebp),%eax
801052ab:	8d 50 01             	lea    0x1(%eax),%edx
801052ae:	89 55 08             	mov    %edx,0x8(%ebp)
801052b1:	c6 00 00             	movb   $0x0,(%eax)
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801052b4:	8b 45 10             	mov    0x10(%ebp),%eax
801052b7:	8d 50 ff             	lea    -0x1(%eax),%edx
801052ba:	89 55 10             	mov    %edx,0x10(%ebp)
801052bd:	85 c0                	test   %eax,%eax
801052bf:	7f e7                	jg     801052a8 <strncpy+0x3a>
    *s++ = 0;
  return os;
801052c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801052c4:	c9                   	leave  
801052c5:	c3                   	ret    

801052c6 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801052c6:	55                   	push   %ebp
801052c7:	89 e5                	mov    %esp,%ebp
801052c9:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
801052cc:	8b 45 08             	mov    0x8(%ebp),%eax
801052cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
801052d2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801052d6:	7f 05                	jg     801052dd <safestrcpy+0x17>
    return os;
801052d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052db:	eb 31                	jmp    8010530e <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
801052dd:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801052e1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801052e5:	7e 1e                	jle    80105305 <safestrcpy+0x3f>
801052e7:	8b 45 08             	mov    0x8(%ebp),%eax
801052ea:	8d 50 01             	lea    0x1(%eax),%edx
801052ed:	89 55 08             	mov    %edx,0x8(%ebp)
801052f0:	8b 55 0c             	mov    0xc(%ebp),%edx
801052f3:	8d 4a 01             	lea    0x1(%edx),%ecx
801052f6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
801052f9:	0f b6 12             	movzbl (%edx),%edx
801052fc:	88 10                	mov    %dl,(%eax)
801052fe:	0f b6 00             	movzbl (%eax),%eax
80105301:	84 c0                	test   %al,%al
80105303:	75 d8                	jne    801052dd <safestrcpy+0x17>
    ;
  *s = 0;
80105305:	8b 45 08             	mov    0x8(%ebp),%eax
80105308:	c6 00 00             	movb   $0x0,(%eax)
  return os;
8010530b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010530e:	c9                   	leave  
8010530f:	c3                   	ret    

80105310 <strlen>:

int
strlen(const char *s)
{
80105310:	55                   	push   %ebp
80105311:	89 e5                	mov    %esp,%ebp
80105313:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
80105316:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010531d:	eb 04                	jmp    80105323 <strlen+0x13>
8010531f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105323:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105326:	8b 45 08             	mov    0x8(%ebp),%eax
80105329:	01 d0                	add    %edx,%eax
8010532b:	0f b6 00             	movzbl (%eax),%eax
8010532e:	84 c0                	test   %al,%al
80105330:	75 ed                	jne    8010531f <strlen+0xf>
    ;
  return n;
80105332:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105335:	c9                   	leave  
80105336:	c3                   	ret    

80105337 <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105337:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010533b:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
8010533f:	55                   	push   %ebp
  pushl %ebx
80105340:	53                   	push   %ebx
  pushl %esi
80105341:	56                   	push   %esi
  pushl %edi
80105342:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105343:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105345:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80105347:	5f                   	pop    %edi
  popl %esi
80105348:	5e                   	pop    %esi
  popl %ebx
80105349:	5b                   	pop    %ebx
  popl %ebp
8010534a:	5d                   	pop    %ebp
  ret
8010534b:	c3                   	ret    

8010534c <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
8010534c:	55                   	push   %ebp
8010534d:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
8010534f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105355:	8b 00                	mov    (%eax),%eax
80105357:	3b 45 08             	cmp    0x8(%ebp),%eax
8010535a:	76 12                	jbe    8010536e <fetchint+0x22>
8010535c:	8b 45 08             	mov    0x8(%ebp),%eax
8010535f:	8d 50 04             	lea    0x4(%eax),%edx
80105362:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105368:	8b 00                	mov    (%eax),%eax
8010536a:	39 c2                	cmp    %eax,%edx
8010536c:	76 07                	jbe    80105375 <fetchint+0x29>
    return -1;
8010536e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105373:	eb 0f                	jmp    80105384 <fetchint+0x38>
  *ip = *(int*)(addr);
80105375:	8b 45 08             	mov    0x8(%ebp),%eax
80105378:	8b 10                	mov    (%eax),%edx
8010537a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010537d:	89 10                	mov    %edx,(%eax)
  return 0;
8010537f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105384:	5d                   	pop    %ebp
80105385:	c3                   	ret    

80105386 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105386:	55                   	push   %ebp
80105387:	89 e5                	mov    %esp,%ebp
80105389:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
8010538c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105392:	8b 00                	mov    (%eax),%eax
80105394:	3b 45 08             	cmp    0x8(%ebp),%eax
80105397:	77 07                	ja     801053a0 <fetchstr+0x1a>
    return -1;
80105399:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010539e:	eb 46                	jmp    801053e6 <fetchstr+0x60>
  *pp = (char*)addr;
801053a0:	8b 55 08             	mov    0x8(%ebp),%edx
801053a3:	8b 45 0c             	mov    0xc(%ebp),%eax
801053a6:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
801053a8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053ae:	8b 00                	mov    (%eax),%eax
801053b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
801053b3:	8b 45 0c             	mov    0xc(%ebp),%eax
801053b6:	8b 00                	mov    (%eax),%eax
801053b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
801053bb:	eb 1c                	jmp    801053d9 <fetchstr+0x53>
    if(*s == 0)
801053bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053c0:	0f b6 00             	movzbl (%eax),%eax
801053c3:	84 c0                	test   %al,%al
801053c5:	75 0e                	jne    801053d5 <fetchstr+0x4f>
      return s - *pp;
801053c7:	8b 55 fc             	mov    -0x4(%ebp),%edx
801053ca:	8b 45 0c             	mov    0xc(%ebp),%eax
801053cd:	8b 00                	mov    (%eax),%eax
801053cf:	29 c2                	sub    %eax,%edx
801053d1:	89 d0                	mov    %edx,%eax
801053d3:	eb 11                	jmp    801053e6 <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801053d5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801053d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053dc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801053df:	72 dc                	jb     801053bd <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
801053e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053e6:	c9                   	leave  
801053e7:	c3                   	ret    

801053e8 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801053e8:	55                   	push   %ebp
801053e9:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801053eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053f1:	8b 40 18             	mov    0x18(%eax),%eax
801053f4:	8b 40 44             	mov    0x44(%eax),%eax
801053f7:	8b 55 08             	mov    0x8(%ebp),%edx
801053fa:	c1 e2 02             	shl    $0x2,%edx
801053fd:	01 d0                	add    %edx,%eax
801053ff:	83 c0 04             	add    $0x4,%eax
80105402:	ff 75 0c             	pushl  0xc(%ebp)
80105405:	50                   	push   %eax
80105406:	e8 41 ff ff ff       	call   8010534c <fetchint>
8010540b:	83 c4 08             	add    $0x8,%esp
}
8010540e:	c9                   	leave  
8010540f:	c3                   	ret    

80105410 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	83 ec 10             	sub    $0x10,%esp
  int i;
  
  if(argint(n, &i) < 0)
80105416:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105419:	50                   	push   %eax
8010541a:	ff 75 08             	pushl  0x8(%ebp)
8010541d:	e8 c6 ff ff ff       	call   801053e8 <argint>
80105422:	83 c4 08             	add    $0x8,%esp
80105425:	85 c0                	test   %eax,%eax
80105427:	79 07                	jns    80105430 <argptr+0x20>
    return -1;
80105429:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010542e:	eb 3b                	jmp    8010546b <argptr+0x5b>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80105430:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105436:	8b 00                	mov    (%eax),%eax
80105438:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010543b:	39 d0                	cmp    %edx,%eax
8010543d:	76 16                	jbe    80105455 <argptr+0x45>
8010543f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105442:	89 c2                	mov    %eax,%edx
80105444:	8b 45 10             	mov    0x10(%ebp),%eax
80105447:	01 c2                	add    %eax,%edx
80105449:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010544f:	8b 00                	mov    (%eax),%eax
80105451:	39 c2                	cmp    %eax,%edx
80105453:	76 07                	jbe    8010545c <argptr+0x4c>
    return -1;
80105455:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010545a:	eb 0f                	jmp    8010546b <argptr+0x5b>
  *pp = (char*)i;
8010545c:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010545f:	89 c2                	mov    %eax,%edx
80105461:	8b 45 0c             	mov    0xc(%ebp),%eax
80105464:	89 10                	mov    %edx,(%eax)
  return 0;
80105466:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010546b:	c9                   	leave  
8010546c:	c3                   	ret    

8010546d <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
8010546d:	55                   	push   %ebp
8010546e:	89 e5                	mov    %esp,%ebp
80105470:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105473:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105476:	50                   	push   %eax
80105477:	ff 75 08             	pushl  0x8(%ebp)
8010547a:	e8 69 ff ff ff       	call   801053e8 <argint>
8010547f:	83 c4 08             	add    $0x8,%esp
80105482:	85 c0                	test   %eax,%eax
80105484:	79 07                	jns    8010548d <argstr+0x20>
    return -1;
80105486:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010548b:	eb 0f                	jmp    8010549c <argstr+0x2f>
  return fetchstr(addr, pp);
8010548d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105490:	ff 75 0c             	pushl  0xc(%ebp)
80105493:	50                   	push   %eax
80105494:	e8 ed fe ff ff       	call   80105386 <fetchstr>
80105499:	83 c4 08             	add    $0x8,%esp
}
8010549c:	c9                   	leave  
8010549d:	c3                   	ret    

8010549e <syscall>:
    
};

void
syscall(void)
{
8010549e:	55                   	push   %ebp
8010549f:	89 e5                	mov    %esp,%ebp
801054a1:	53                   	push   %ebx
801054a2:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
801054a5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054ab:	8b 40 18             	mov    0x18(%eax),%eax
801054ae:	8b 40 1c             	mov    0x1c(%eax),%eax
801054b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801054b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801054b8:	7e 30                	jle    801054ea <syscall+0x4c>
801054ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054bd:	83 f8 1a             	cmp    $0x1a,%eax
801054c0:	77 28                	ja     801054ea <syscall+0x4c>
801054c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054c5:	8b 04 85 40 e0 10 80 	mov    -0x7fef1fc0(,%eax,4),%eax
801054cc:	85 c0                	test   %eax,%eax
801054ce:	74 1a                	je     801054ea <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
801054d0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054d6:	8b 58 18             	mov    0x18(%eax),%ebx
801054d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054dc:	8b 04 85 40 e0 10 80 	mov    -0x7fef1fc0(,%eax,4),%eax
801054e3:	ff d0                	call   *%eax
801054e5:	89 43 1c             	mov    %eax,0x1c(%ebx)
801054e8:	eb 34                	jmp    8010551e <syscall+0x80>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
801054ea:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054f0:	8d 50 6c             	lea    0x6c(%eax),%edx
801054f3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801054f9:	8b 40 10             	mov    0x10(%eax),%eax
801054fc:	ff 75 f4             	pushl  -0xc(%ebp)
801054ff:	52                   	push   %edx
80105500:	50                   	push   %eax
80105501:	68 df b7 10 80       	push   $0x8010b7df
80105506:	e8 bb ae ff ff       	call   801003c6 <cprintf>
8010550b:	83 c4 10             	add    $0x10,%esp
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
8010550e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105514:	8b 40 18             	mov    0x18(%eax),%eax
80105517:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
8010551e:	90                   	nop
8010551f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105522:	c9                   	leave  
80105523:	c3                   	ret    

80105524 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80105524:	55                   	push   %ebp
80105525:	89 e5                	mov    %esp,%ebp
80105527:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010552a:	83 ec 08             	sub    $0x8,%esp
8010552d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105530:	50                   	push   %eax
80105531:	ff 75 08             	pushl  0x8(%ebp)
80105534:	e8 af fe ff ff       	call   801053e8 <argint>
80105539:	83 c4 10             	add    $0x10,%esp
8010553c:	85 c0                	test   %eax,%eax
8010553e:	79 07                	jns    80105547 <argfd+0x23>
    return -1;
80105540:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105545:	eb 50                	jmp    80105597 <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80105547:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010554a:	85 c0                	test   %eax,%eax
8010554c:	78 21                	js     8010556f <argfd+0x4b>
8010554e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105551:	83 f8 0f             	cmp    $0xf,%eax
80105554:	7f 19                	jg     8010556f <argfd+0x4b>
80105556:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010555c:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010555f:	83 c2 08             	add    $0x8,%edx
80105562:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105566:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105569:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010556d:	75 07                	jne    80105576 <argfd+0x52>
    return -1;
8010556f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105574:	eb 21                	jmp    80105597 <argfd+0x73>
  if(pfd)
80105576:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010557a:	74 08                	je     80105584 <argfd+0x60>
    *pfd = fd;
8010557c:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010557f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105582:	89 10                	mov    %edx,(%eax)
  if(pf)
80105584:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105588:	74 08                	je     80105592 <argfd+0x6e>
    *pf = f;
8010558a:	8b 45 10             	mov    0x10(%ebp),%eax
8010558d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105590:	89 10                	mov    %edx,(%eax)
  return 0;
80105592:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105597:	c9                   	leave  
80105598:	c3                   	ret    

80105599 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80105599:	55                   	push   %ebp
8010559a:	89 e5                	mov    %esp,%ebp
8010559c:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
8010559f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801055a6:	eb 30                	jmp    801055d8 <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
801055a8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055ae:	8b 55 fc             	mov    -0x4(%ebp),%edx
801055b1:	83 c2 08             	add    $0x8,%edx
801055b4:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801055b8:	85 c0                	test   %eax,%eax
801055ba:	75 18                	jne    801055d4 <fdalloc+0x3b>
      proc->ofile[fd] = f;
801055bc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
801055c5:	8d 4a 08             	lea    0x8(%edx),%ecx
801055c8:	8b 55 08             	mov    0x8(%ebp),%edx
801055cb:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
801055cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055d2:	eb 0f                	jmp    801055e3 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801055d4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801055d8:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
801055dc:	7e ca                	jle    801055a8 <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
801055de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055e3:	c9                   	leave  
801055e4:	c3                   	ret    

801055e5 <sys_dup>:

int
sys_dup(void)
{
801055e5:	55                   	push   %ebp
801055e6:	89 e5                	mov    %esp,%ebp
801055e8:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
801055eb:	83 ec 04             	sub    $0x4,%esp
801055ee:	8d 45 f0             	lea    -0x10(%ebp),%eax
801055f1:	50                   	push   %eax
801055f2:	6a 00                	push   $0x0
801055f4:	6a 00                	push   $0x0
801055f6:	e8 29 ff ff ff       	call   80105524 <argfd>
801055fb:	83 c4 10             	add    $0x10,%esp
801055fe:	85 c0                	test   %eax,%eax
80105600:	79 07                	jns    80105609 <sys_dup+0x24>
    return -1;
80105602:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105607:	eb 31                	jmp    8010563a <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
80105609:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010560c:	83 ec 0c             	sub    $0xc,%esp
8010560f:	50                   	push   %eax
80105610:	e8 84 ff ff ff       	call   80105599 <fdalloc>
80105615:	83 c4 10             	add    $0x10,%esp
80105618:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010561b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010561f:	79 07                	jns    80105628 <sys_dup+0x43>
    return -1;
80105621:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105626:	eb 12                	jmp    8010563a <sys_dup+0x55>
  filedup(f);
80105628:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010562b:	83 ec 0c             	sub    $0xc,%esp
8010562e:	50                   	push   %eax
8010562f:	e8 9d b9 ff ff       	call   80100fd1 <filedup>
80105634:	83 c4 10             	add    $0x10,%esp
  return fd;
80105637:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010563a:	c9                   	leave  
8010563b:	c3                   	ret    

8010563c <sys_read>:

int
sys_read(void)
{
8010563c:	55                   	push   %ebp
8010563d:	89 e5                	mov    %esp,%ebp
8010563f:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105642:	83 ec 04             	sub    $0x4,%esp
80105645:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105648:	50                   	push   %eax
80105649:	6a 00                	push   $0x0
8010564b:	6a 00                	push   $0x0
8010564d:	e8 d2 fe ff ff       	call   80105524 <argfd>
80105652:	83 c4 10             	add    $0x10,%esp
80105655:	85 c0                	test   %eax,%eax
80105657:	78 2e                	js     80105687 <sys_read+0x4b>
80105659:	83 ec 08             	sub    $0x8,%esp
8010565c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010565f:	50                   	push   %eax
80105660:	6a 02                	push   $0x2
80105662:	e8 81 fd ff ff       	call   801053e8 <argint>
80105667:	83 c4 10             	add    $0x10,%esp
8010566a:	85 c0                	test   %eax,%eax
8010566c:	78 19                	js     80105687 <sys_read+0x4b>
8010566e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105671:	83 ec 04             	sub    $0x4,%esp
80105674:	50                   	push   %eax
80105675:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105678:	50                   	push   %eax
80105679:	6a 01                	push   $0x1
8010567b:	e8 90 fd ff ff       	call   80105410 <argptr>
80105680:	83 c4 10             	add    $0x10,%esp
80105683:	85 c0                	test   %eax,%eax
80105685:	79 07                	jns    8010568e <sys_read+0x52>
    return -1;
80105687:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010568c:	eb 17                	jmp    801056a5 <sys_read+0x69>
  return fileread(f, p, n);
8010568e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105691:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105694:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105697:	83 ec 04             	sub    $0x4,%esp
8010569a:	51                   	push   %ecx
8010569b:	52                   	push   %edx
8010569c:	50                   	push   %eax
8010569d:	e8 bf ba ff ff       	call   80101161 <fileread>
801056a2:	83 c4 10             	add    $0x10,%esp
}
801056a5:	c9                   	leave  
801056a6:	c3                   	ret    

801056a7 <sys_write>:

int
sys_write(void)
{
801056a7:	55                   	push   %ebp
801056a8:	89 e5                	mov    %esp,%ebp
801056aa:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801056ad:	83 ec 04             	sub    $0x4,%esp
801056b0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056b3:	50                   	push   %eax
801056b4:	6a 00                	push   $0x0
801056b6:	6a 00                	push   $0x0
801056b8:	e8 67 fe ff ff       	call   80105524 <argfd>
801056bd:	83 c4 10             	add    $0x10,%esp
801056c0:	85 c0                	test   %eax,%eax
801056c2:	78 2e                	js     801056f2 <sys_write+0x4b>
801056c4:	83 ec 08             	sub    $0x8,%esp
801056c7:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056ca:	50                   	push   %eax
801056cb:	6a 02                	push   $0x2
801056cd:	e8 16 fd ff ff       	call   801053e8 <argint>
801056d2:	83 c4 10             	add    $0x10,%esp
801056d5:	85 c0                	test   %eax,%eax
801056d7:	78 19                	js     801056f2 <sys_write+0x4b>
801056d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801056dc:	83 ec 04             	sub    $0x4,%esp
801056df:	50                   	push   %eax
801056e0:	8d 45 ec             	lea    -0x14(%ebp),%eax
801056e3:	50                   	push   %eax
801056e4:	6a 01                	push   $0x1
801056e6:	e8 25 fd ff ff       	call   80105410 <argptr>
801056eb:	83 c4 10             	add    $0x10,%esp
801056ee:	85 c0                	test   %eax,%eax
801056f0:	79 07                	jns    801056f9 <sys_write+0x52>
    return -1;
801056f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056f7:	eb 17                	jmp    80105710 <sys_write+0x69>
  return filewrite(f, p, n);
801056f9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801056fc:	8b 55 ec             	mov    -0x14(%ebp),%edx
801056ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105702:	83 ec 04             	sub    $0x4,%esp
80105705:	51                   	push   %ecx
80105706:	52                   	push   %edx
80105707:	50                   	push   %eax
80105708:	e8 0c bb ff ff       	call   80101219 <filewrite>
8010570d:	83 c4 10             	add    $0x10,%esp
}
80105710:	c9                   	leave  
80105711:	c3                   	ret    

80105712 <sys_close>:

int
sys_close(void)
{
80105712:	55                   	push   %ebp
80105713:	89 e5                	mov    %esp,%ebp
80105715:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
80105718:	83 ec 04             	sub    $0x4,%esp
8010571b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010571e:	50                   	push   %eax
8010571f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105722:	50                   	push   %eax
80105723:	6a 00                	push   $0x0
80105725:	e8 fa fd ff ff       	call   80105524 <argfd>
8010572a:	83 c4 10             	add    $0x10,%esp
8010572d:	85 c0                	test   %eax,%eax
8010572f:	79 07                	jns    80105738 <sys_close+0x26>
    return -1;
80105731:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105736:	eb 28                	jmp    80105760 <sys_close+0x4e>
  proc->ofile[fd] = 0;
80105738:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010573e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105741:	83 c2 08             	add    $0x8,%edx
80105744:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010574b:	00 
  fileclose(f);
8010574c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010574f:	83 ec 0c             	sub    $0xc,%esp
80105752:	50                   	push   %eax
80105753:	e8 ca b8 ff ff       	call   80101022 <fileclose>
80105758:	83 c4 10             	add    $0x10,%esp
  return 0;
8010575b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105760:	c9                   	leave  
80105761:	c3                   	ret    

80105762 <sys_fstat>:

int
sys_fstat(void)
{
80105762:	55                   	push   %ebp
80105763:	89 e5                	mov    %esp,%ebp
80105765:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105768:	83 ec 04             	sub    $0x4,%esp
8010576b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010576e:	50                   	push   %eax
8010576f:	6a 00                	push   $0x0
80105771:	6a 00                	push   $0x0
80105773:	e8 ac fd ff ff       	call   80105524 <argfd>
80105778:	83 c4 10             	add    $0x10,%esp
8010577b:	85 c0                	test   %eax,%eax
8010577d:	78 17                	js     80105796 <sys_fstat+0x34>
8010577f:	83 ec 04             	sub    $0x4,%esp
80105782:	6a 14                	push   $0x14
80105784:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105787:	50                   	push   %eax
80105788:	6a 01                	push   $0x1
8010578a:	e8 81 fc ff ff       	call   80105410 <argptr>
8010578f:	83 c4 10             	add    $0x10,%esp
80105792:	85 c0                	test   %eax,%eax
80105794:	79 07                	jns    8010579d <sys_fstat+0x3b>
    return -1;
80105796:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010579b:	eb 13                	jmp    801057b0 <sys_fstat+0x4e>
  return filestat(f, st);
8010579d:	8b 55 f0             	mov    -0x10(%ebp),%edx
801057a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057a3:	83 ec 08             	sub    $0x8,%esp
801057a6:	52                   	push   %edx
801057a7:	50                   	push   %eax
801057a8:	e8 5d b9 ff ff       	call   8010110a <filestat>
801057ad:	83 c4 10             	add    $0x10,%esp
}
801057b0:	c9                   	leave  
801057b1:	c3                   	ret    

801057b2 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
801057b2:	55                   	push   %ebp
801057b3:	89 e5                	mov    %esp,%ebp
801057b5:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801057b8:	83 ec 08             	sub    $0x8,%esp
801057bb:	8d 45 d8             	lea    -0x28(%ebp),%eax
801057be:	50                   	push   %eax
801057bf:	6a 00                	push   $0x0
801057c1:	e8 a7 fc ff ff       	call   8010546d <argstr>
801057c6:	83 c4 10             	add    $0x10,%esp
801057c9:	85 c0                	test   %eax,%eax
801057cb:	78 15                	js     801057e2 <sys_link+0x30>
801057cd:	83 ec 08             	sub    $0x8,%esp
801057d0:	8d 45 dc             	lea    -0x24(%ebp),%eax
801057d3:	50                   	push   %eax
801057d4:	6a 01                	push   $0x1
801057d6:	e8 92 fc ff ff       	call   8010546d <argstr>
801057db:	83 c4 10             	add    $0x10,%esp
801057de:	85 c0                	test   %eax,%eax
801057e0:	79 0a                	jns    801057ec <sys_link+0x3a>
    return -1;
801057e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057e7:	e9 63 01 00 00       	jmp    8010594f <sys_link+0x19d>
  if((ip = namei(old)) == 0)
801057ec:	8b 45 d8             	mov    -0x28(%ebp),%eax
801057ef:	83 ec 0c             	sub    $0xc,%esp
801057f2:	50                   	push   %eax
801057f3:	e8 06 ce ff ff       	call   801025fe <namei>
801057f8:	83 c4 10             	add    $0x10,%esp
801057fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
801057fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105802:	75 0a                	jne    8010580e <sys_link+0x5c>
    return -1;
80105804:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105809:	e9 41 01 00 00       	jmp    8010594f <sys_link+0x19d>

  begin_trans();
8010580e:	e8 f3 dc ff ff       	call   80103506 <begin_trans>

  ilock(ip);
80105813:	83 ec 0c             	sub    $0xc,%esp
80105816:	ff 75 f4             	pushl  -0xc(%ebp)
80105819:	e8 d9 c0 ff ff       	call   801018f7 <ilock>
8010581e:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
80105821:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105824:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105828:	66 83 f8 01          	cmp    $0x1,%ax
8010582c:	75 1d                	jne    8010584b <sys_link+0x99>
    iunlockput(ip);
8010582e:	83 ec 0c             	sub    $0xc,%esp
80105831:	ff 75 f4             	pushl  -0xc(%ebp)
80105834:	e8 78 c3 ff ff       	call   80101bb1 <iunlockput>
80105839:	83 c4 10             	add    $0x10,%esp
    commit_trans();
8010583c:	e8 18 dd ff ff       	call   80103559 <commit_trans>
    return -1;
80105841:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105846:	e9 04 01 00 00       	jmp    8010594f <sys_link+0x19d>
  }

  ip->nlink++;
8010584b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010584e:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105852:	83 c0 01             	add    $0x1,%eax
80105855:	89 c2                	mov    %eax,%edx
80105857:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010585a:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
8010585e:	83 ec 0c             	sub    $0xc,%esp
80105861:	ff 75 f4             	pushl  -0xc(%ebp)
80105864:	e8 ba be ff ff       	call   80101723 <iupdate>
80105869:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
8010586c:	83 ec 0c             	sub    $0xc,%esp
8010586f:	ff 75 f4             	pushl  -0xc(%ebp)
80105872:	e8 d8 c1 ff ff       	call   80101a4f <iunlock>
80105877:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
8010587a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010587d:	83 ec 08             	sub    $0x8,%esp
80105880:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105883:	52                   	push   %edx
80105884:	50                   	push   %eax
80105885:	e8 90 cd ff ff       	call   8010261a <nameiparent>
8010588a:	83 c4 10             	add    $0x10,%esp
8010588d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105890:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105894:	74 71                	je     80105907 <sys_link+0x155>
    goto bad;
  ilock(dp);
80105896:	83 ec 0c             	sub    $0xc,%esp
80105899:	ff 75 f0             	pushl  -0x10(%ebp)
8010589c:	e8 56 c0 ff ff       	call   801018f7 <ilock>
801058a1:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801058a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058a7:	8b 10                	mov    (%eax),%edx
801058a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058ac:	8b 00                	mov    (%eax),%eax
801058ae:	39 c2                	cmp    %eax,%edx
801058b0:	75 1d                	jne    801058cf <sys_link+0x11d>
801058b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058b5:	8b 40 04             	mov    0x4(%eax),%eax
801058b8:	83 ec 04             	sub    $0x4,%esp
801058bb:	50                   	push   %eax
801058bc:	8d 45 e2             	lea    -0x1e(%ebp),%eax
801058bf:	50                   	push   %eax
801058c0:	ff 75 f0             	pushl  -0x10(%ebp)
801058c3:	e8 9a ca ff ff       	call   80102362 <dirlink>
801058c8:	83 c4 10             	add    $0x10,%esp
801058cb:	85 c0                	test   %eax,%eax
801058cd:	79 10                	jns    801058df <sys_link+0x12d>
    iunlockput(dp);
801058cf:	83 ec 0c             	sub    $0xc,%esp
801058d2:	ff 75 f0             	pushl  -0x10(%ebp)
801058d5:	e8 d7 c2 ff ff       	call   80101bb1 <iunlockput>
801058da:	83 c4 10             	add    $0x10,%esp
    goto bad;
801058dd:	eb 29                	jmp    80105908 <sys_link+0x156>
  }
  iunlockput(dp);
801058df:	83 ec 0c             	sub    $0xc,%esp
801058e2:	ff 75 f0             	pushl  -0x10(%ebp)
801058e5:	e8 c7 c2 ff ff       	call   80101bb1 <iunlockput>
801058ea:	83 c4 10             	add    $0x10,%esp
  iput(ip);
801058ed:	83 ec 0c             	sub    $0xc,%esp
801058f0:	ff 75 f4             	pushl  -0xc(%ebp)
801058f3:	e8 c9 c1 ff ff       	call   80101ac1 <iput>
801058f8:	83 c4 10             	add    $0x10,%esp

  commit_trans();
801058fb:	e8 59 dc ff ff       	call   80103559 <commit_trans>

  return 0;
80105900:	b8 00 00 00 00       	mov    $0x0,%eax
80105905:	eb 48                	jmp    8010594f <sys_link+0x19d>
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
80105907:	90                   	nop
  commit_trans();

  return 0;

bad:
  ilock(ip);
80105908:	83 ec 0c             	sub    $0xc,%esp
8010590b:	ff 75 f4             	pushl  -0xc(%ebp)
8010590e:	e8 e4 bf ff ff       	call   801018f7 <ilock>
80105913:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
80105916:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105919:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010591d:	83 e8 01             	sub    $0x1,%eax
80105920:	89 c2                	mov    %eax,%edx
80105922:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105925:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105929:	83 ec 0c             	sub    $0xc,%esp
8010592c:	ff 75 f4             	pushl  -0xc(%ebp)
8010592f:	e8 ef bd ff ff       	call   80101723 <iupdate>
80105934:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105937:	83 ec 0c             	sub    $0xc,%esp
8010593a:	ff 75 f4             	pushl  -0xc(%ebp)
8010593d:	e8 6f c2 ff ff       	call   80101bb1 <iunlockput>
80105942:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105945:	e8 0f dc ff ff       	call   80103559 <commit_trans>
  return -1;
8010594a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010594f:	c9                   	leave  
80105950:	c3                   	ret    

80105951 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105951:	55                   	push   %ebp
80105952:	89 e5                	mov    %esp,%ebp
80105954:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105957:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
8010595e:	eb 40                	jmp    801059a0 <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105960:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105963:	6a 10                	push   $0x10
80105965:	50                   	push   %eax
80105966:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105969:	50                   	push   %eax
8010596a:	ff 75 08             	pushl  0x8(%ebp)
8010596d:	e8 3c c6 ff ff       	call   80101fae <readi>
80105972:	83 c4 10             	add    $0x10,%esp
80105975:	83 f8 10             	cmp    $0x10,%eax
80105978:	74 0d                	je     80105987 <isdirempty+0x36>
      panic("isdirempty: readi");
8010597a:	83 ec 0c             	sub    $0xc,%esp
8010597d:	68 fb b7 10 80       	push   $0x8010b7fb
80105982:	e8 df ab ff ff       	call   80100566 <panic>
    if(de.inum != 0)
80105987:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
8010598b:	66 85 c0             	test   %ax,%ax
8010598e:	74 07                	je     80105997 <isdirempty+0x46>
      return 0;
80105990:	b8 00 00 00 00       	mov    $0x0,%eax
80105995:	eb 1b                	jmp    801059b2 <isdirempty+0x61>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105997:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010599a:	83 c0 10             	add    $0x10,%eax
8010599d:	89 45 f4             	mov    %eax,-0xc(%ebp)
801059a0:	8b 45 08             	mov    0x8(%ebp),%eax
801059a3:	8b 50 18             	mov    0x18(%eax),%edx
801059a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059a9:	39 c2                	cmp    %eax,%edx
801059ab:	77 b3                	ja     80105960 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
801059ad:	b8 01 00 00 00       	mov    $0x1,%eax
}
801059b2:	c9                   	leave  
801059b3:	c3                   	ret    

801059b4 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
801059b4:	55                   	push   %ebp
801059b5:	89 e5                	mov    %esp,%ebp
801059b7:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801059ba:	83 ec 08             	sub    $0x8,%esp
801059bd:	8d 45 cc             	lea    -0x34(%ebp),%eax
801059c0:	50                   	push   %eax
801059c1:	6a 00                	push   $0x0
801059c3:	e8 a5 fa ff ff       	call   8010546d <argstr>
801059c8:	83 c4 10             	add    $0x10,%esp
801059cb:	85 c0                	test   %eax,%eax
801059cd:	79 0a                	jns    801059d9 <sys_unlink+0x25>
    return -1;
801059cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059d4:	e9 b7 01 00 00       	jmp    80105b90 <sys_unlink+0x1dc>
  if((dp = nameiparent(path, name)) == 0)
801059d9:	8b 45 cc             	mov    -0x34(%ebp),%eax
801059dc:	83 ec 08             	sub    $0x8,%esp
801059df:	8d 55 d2             	lea    -0x2e(%ebp),%edx
801059e2:	52                   	push   %edx
801059e3:	50                   	push   %eax
801059e4:	e8 31 cc ff ff       	call   8010261a <nameiparent>
801059e9:	83 c4 10             	add    $0x10,%esp
801059ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
801059ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801059f3:	75 0a                	jne    801059ff <sys_unlink+0x4b>
    return -1;
801059f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059fa:	e9 91 01 00 00       	jmp    80105b90 <sys_unlink+0x1dc>

  begin_trans();
801059ff:	e8 02 db ff ff       	call   80103506 <begin_trans>

  ilock(dp);
80105a04:	83 ec 0c             	sub    $0xc,%esp
80105a07:	ff 75 f4             	pushl  -0xc(%ebp)
80105a0a:	e8 e8 be ff ff       	call   801018f7 <ilock>
80105a0f:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105a12:	83 ec 08             	sub    $0x8,%esp
80105a15:	68 0d b8 10 80       	push   $0x8010b80d
80105a1a:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105a1d:	50                   	push   %eax
80105a1e:	e8 6a c8 ff ff       	call   8010228d <namecmp>
80105a23:	83 c4 10             	add    $0x10,%esp
80105a26:	85 c0                	test   %eax,%eax
80105a28:	0f 84 4a 01 00 00    	je     80105b78 <sys_unlink+0x1c4>
80105a2e:	83 ec 08             	sub    $0x8,%esp
80105a31:	68 0f b8 10 80       	push   $0x8010b80f
80105a36:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105a39:	50                   	push   %eax
80105a3a:	e8 4e c8 ff ff       	call   8010228d <namecmp>
80105a3f:	83 c4 10             	add    $0x10,%esp
80105a42:	85 c0                	test   %eax,%eax
80105a44:	0f 84 2e 01 00 00    	je     80105b78 <sys_unlink+0x1c4>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105a4a:	83 ec 04             	sub    $0x4,%esp
80105a4d:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105a50:	50                   	push   %eax
80105a51:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105a54:	50                   	push   %eax
80105a55:	ff 75 f4             	pushl  -0xc(%ebp)
80105a58:	e8 4b c8 ff ff       	call   801022a8 <dirlookup>
80105a5d:	83 c4 10             	add    $0x10,%esp
80105a60:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105a63:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105a67:	0f 84 0a 01 00 00    	je     80105b77 <sys_unlink+0x1c3>
    goto bad;
  ilock(ip);
80105a6d:	83 ec 0c             	sub    $0xc,%esp
80105a70:	ff 75 f0             	pushl  -0x10(%ebp)
80105a73:	e8 7f be ff ff       	call   801018f7 <ilock>
80105a78:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105a7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a7e:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105a82:	66 85 c0             	test   %ax,%ax
80105a85:	7f 0d                	jg     80105a94 <sys_unlink+0xe0>
    panic("unlink: nlink < 1");
80105a87:	83 ec 0c             	sub    $0xc,%esp
80105a8a:	68 12 b8 10 80       	push   $0x8010b812
80105a8f:	e8 d2 aa ff ff       	call   80100566 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105a94:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a97:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105a9b:	66 83 f8 01          	cmp    $0x1,%ax
80105a9f:	75 25                	jne    80105ac6 <sys_unlink+0x112>
80105aa1:	83 ec 0c             	sub    $0xc,%esp
80105aa4:	ff 75 f0             	pushl  -0x10(%ebp)
80105aa7:	e8 a5 fe ff ff       	call   80105951 <isdirempty>
80105aac:	83 c4 10             	add    $0x10,%esp
80105aaf:	85 c0                	test   %eax,%eax
80105ab1:	75 13                	jne    80105ac6 <sys_unlink+0x112>
    iunlockput(ip);
80105ab3:	83 ec 0c             	sub    $0xc,%esp
80105ab6:	ff 75 f0             	pushl  -0x10(%ebp)
80105ab9:	e8 f3 c0 ff ff       	call   80101bb1 <iunlockput>
80105abe:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105ac1:	e9 b2 00 00 00       	jmp    80105b78 <sys_unlink+0x1c4>
  }

  memset(&de, 0, sizeof(de));
80105ac6:	83 ec 04             	sub    $0x4,%esp
80105ac9:	6a 10                	push   $0x10
80105acb:	6a 00                	push   $0x0
80105acd:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105ad0:	50                   	push   %eax
80105ad1:	e8 ed f5 ff ff       	call   801050c3 <memset>
80105ad6:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105ad9:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105adc:	6a 10                	push   $0x10
80105ade:	50                   	push   %eax
80105adf:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105ae2:	50                   	push   %eax
80105ae3:	ff 75 f4             	pushl  -0xc(%ebp)
80105ae6:	e8 1a c6 ff ff       	call   80102105 <writei>
80105aeb:	83 c4 10             	add    $0x10,%esp
80105aee:	83 f8 10             	cmp    $0x10,%eax
80105af1:	74 0d                	je     80105b00 <sys_unlink+0x14c>
    panic("unlink: writei");
80105af3:	83 ec 0c             	sub    $0xc,%esp
80105af6:	68 24 b8 10 80       	push   $0x8010b824
80105afb:	e8 66 aa ff ff       	call   80100566 <panic>
  if(ip->type == T_DIR){
80105b00:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b03:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105b07:	66 83 f8 01          	cmp    $0x1,%ax
80105b0b:	75 21                	jne    80105b2e <sys_unlink+0x17a>
    dp->nlink--;
80105b0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b10:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105b14:	83 e8 01             	sub    $0x1,%eax
80105b17:	89 c2                	mov    %eax,%edx
80105b19:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b1c:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105b20:	83 ec 0c             	sub    $0xc,%esp
80105b23:	ff 75 f4             	pushl  -0xc(%ebp)
80105b26:	e8 f8 bb ff ff       	call   80101723 <iupdate>
80105b2b:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80105b2e:	83 ec 0c             	sub    $0xc,%esp
80105b31:	ff 75 f4             	pushl  -0xc(%ebp)
80105b34:	e8 78 c0 ff ff       	call   80101bb1 <iunlockput>
80105b39:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80105b3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b3f:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105b43:	83 e8 01             	sub    $0x1,%eax
80105b46:	89 c2                	mov    %eax,%edx
80105b48:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b4b:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105b4f:	83 ec 0c             	sub    $0xc,%esp
80105b52:	ff 75 f0             	pushl  -0x10(%ebp)
80105b55:	e8 c9 bb ff ff       	call   80101723 <iupdate>
80105b5a:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105b5d:	83 ec 0c             	sub    $0xc,%esp
80105b60:	ff 75 f0             	pushl  -0x10(%ebp)
80105b63:	e8 49 c0 ff ff       	call   80101bb1 <iunlockput>
80105b68:	83 c4 10             	add    $0x10,%esp

  commit_trans();
80105b6b:	e8 e9 d9 ff ff       	call   80103559 <commit_trans>

  return 0;
80105b70:	b8 00 00 00 00       	mov    $0x0,%eax
80105b75:	eb 19                	jmp    80105b90 <sys_unlink+0x1dc>
  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
80105b77:	90                   	nop
  commit_trans();

  return 0;

bad:
  iunlockput(dp);
80105b78:	83 ec 0c             	sub    $0xc,%esp
80105b7b:	ff 75 f4             	pushl  -0xc(%ebp)
80105b7e:	e8 2e c0 ff ff       	call   80101bb1 <iunlockput>
80105b83:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105b86:	e8 ce d9 ff ff       	call   80103559 <commit_trans>
  return -1;
80105b8b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b90:	c9                   	leave  
80105b91:	c3                   	ret    

80105b92 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105b92:	55                   	push   %ebp
80105b93:	89 e5                	mov    %esp,%ebp
80105b95:	83 ec 38             	sub    $0x38,%esp
80105b98:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105b9b:	8b 55 10             	mov    0x10(%ebp),%edx
80105b9e:	8b 45 14             	mov    0x14(%ebp),%eax
80105ba1:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105ba5:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105ba9:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105bad:	83 ec 08             	sub    $0x8,%esp
80105bb0:	8d 45 de             	lea    -0x22(%ebp),%eax
80105bb3:	50                   	push   %eax
80105bb4:	ff 75 08             	pushl  0x8(%ebp)
80105bb7:	e8 5e ca ff ff       	call   8010261a <nameiparent>
80105bbc:	83 c4 10             	add    $0x10,%esp
80105bbf:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105bc2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105bc6:	75 0a                	jne    80105bd2 <create+0x40>
    return 0;
80105bc8:	b8 00 00 00 00       	mov    $0x0,%eax
80105bcd:	e9 90 01 00 00       	jmp    80105d62 <create+0x1d0>
  ilock(dp);
80105bd2:	83 ec 0c             	sub    $0xc,%esp
80105bd5:	ff 75 f4             	pushl  -0xc(%ebp)
80105bd8:	e8 1a bd ff ff       	call   801018f7 <ilock>
80105bdd:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
80105be0:	83 ec 04             	sub    $0x4,%esp
80105be3:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105be6:	50                   	push   %eax
80105be7:	8d 45 de             	lea    -0x22(%ebp),%eax
80105bea:	50                   	push   %eax
80105beb:	ff 75 f4             	pushl  -0xc(%ebp)
80105bee:	e8 b5 c6 ff ff       	call   801022a8 <dirlookup>
80105bf3:	83 c4 10             	add    $0x10,%esp
80105bf6:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105bf9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105bfd:	74 50                	je     80105c4f <create+0xbd>
    iunlockput(dp);
80105bff:	83 ec 0c             	sub    $0xc,%esp
80105c02:	ff 75 f4             	pushl  -0xc(%ebp)
80105c05:	e8 a7 bf ff ff       	call   80101bb1 <iunlockput>
80105c0a:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80105c0d:	83 ec 0c             	sub    $0xc,%esp
80105c10:	ff 75 f0             	pushl  -0x10(%ebp)
80105c13:	e8 df bc ff ff       	call   801018f7 <ilock>
80105c18:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80105c1b:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105c20:	75 15                	jne    80105c37 <create+0xa5>
80105c22:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c25:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105c29:	66 83 f8 02          	cmp    $0x2,%ax
80105c2d:	75 08                	jne    80105c37 <create+0xa5>
      return ip;
80105c2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c32:	e9 2b 01 00 00       	jmp    80105d62 <create+0x1d0>
    iunlockput(ip);
80105c37:	83 ec 0c             	sub    $0xc,%esp
80105c3a:	ff 75 f0             	pushl  -0x10(%ebp)
80105c3d:	e8 6f bf ff ff       	call   80101bb1 <iunlockput>
80105c42:	83 c4 10             	add    $0x10,%esp
    return 0;
80105c45:	b8 00 00 00 00       	mov    $0x0,%eax
80105c4a:	e9 13 01 00 00       	jmp    80105d62 <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105c4f:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105c53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c56:	8b 00                	mov    (%eax),%eax
80105c58:	83 ec 08             	sub    $0x8,%esp
80105c5b:	52                   	push   %edx
80105c5c:	50                   	push   %eax
80105c5d:	e8 e0 b9 ff ff       	call   80101642 <ialloc>
80105c62:	83 c4 10             	add    $0x10,%esp
80105c65:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105c68:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105c6c:	75 0d                	jne    80105c7b <create+0xe9>
    panic("create: ialloc");
80105c6e:	83 ec 0c             	sub    $0xc,%esp
80105c71:	68 33 b8 10 80       	push   $0x8010b833
80105c76:	e8 eb a8 ff ff       	call   80100566 <panic>

  ilock(ip);
80105c7b:	83 ec 0c             	sub    $0xc,%esp
80105c7e:	ff 75 f0             	pushl  -0x10(%ebp)
80105c81:	e8 71 bc ff ff       	call   801018f7 <ilock>
80105c86:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80105c89:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c8c:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105c90:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80105c94:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c97:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105c9b:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80105c9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ca2:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105ca8:	83 ec 0c             	sub    $0xc,%esp
80105cab:	ff 75 f0             	pushl  -0x10(%ebp)
80105cae:	e8 70 ba ff ff       	call   80101723 <iupdate>
80105cb3:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
80105cb6:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105cbb:	75 6a                	jne    80105d27 <create+0x195>
    dp->nlink++;  // for ".."
80105cbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cc0:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105cc4:	83 c0 01             	add    $0x1,%eax
80105cc7:	89 c2                	mov    %eax,%edx
80105cc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ccc:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105cd0:	83 ec 0c             	sub    $0xc,%esp
80105cd3:	ff 75 f4             	pushl  -0xc(%ebp)
80105cd6:	e8 48 ba ff ff       	call   80101723 <iupdate>
80105cdb:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105cde:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ce1:	8b 40 04             	mov    0x4(%eax),%eax
80105ce4:	83 ec 04             	sub    $0x4,%esp
80105ce7:	50                   	push   %eax
80105ce8:	68 0d b8 10 80       	push   $0x8010b80d
80105ced:	ff 75 f0             	pushl  -0x10(%ebp)
80105cf0:	e8 6d c6 ff ff       	call   80102362 <dirlink>
80105cf5:	83 c4 10             	add    $0x10,%esp
80105cf8:	85 c0                	test   %eax,%eax
80105cfa:	78 1e                	js     80105d1a <create+0x188>
80105cfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cff:	8b 40 04             	mov    0x4(%eax),%eax
80105d02:	83 ec 04             	sub    $0x4,%esp
80105d05:	50                   	push   %eax
80105d06:	68 0f b8 10 80       	push   $0x8010b80f
80105d0b:	ff 75 f0             	pushl  -0x10(%ebp)
80105d0e:	e8 4f c6 ff ff       	call   80102362 <dirlink>
80105d13:	83 c4 10             	add    $0x10,%esp
80105d16:	85 c0                	test   %eax,%eax
80105d18:	79 0d                	jns    80105d27 <create+0x195>
      panic("create dots");
80105d1a:	83 ec 0c             	sub    $0xc,%esp
80105d1d:	68 42 b8 10 80       	push   $0x8010b842
80105d22:	e8 3f a8 ff ff       	call   80100566 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105d27:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d2a:	8b 40 04             	mov    0x4(%eax),%eax
80105d2d:	83 ec 04             	sub    $0x4,%esp
80105d30:	50                   	push   %eax
80105d31:	8d 45 de             	lea    -0x22(%ebp),%eax
80105d34:	50                   	push   %eax
80105d35:	ff 75 f4             	pushl  -0xc(%ebp)
80105d38:	e8 25 c6 ff ff       	call   80102362 <dirlink>
80105d3d:	83 c4 10             	add    $0x10,%esp
80105d40:	85 c0                	test   %eax,%eax
80105d42:	79 0d                	jns    80105d51 <create+0x1bf>
    panic("create: dirlink");
80105d44:	83 ec 0c             	sub    $0xc,%esp
80105d47:	68 4e b8 10 80       	push   $0x8010b84e
80105d4c:	e8 15 a8 ff ff       	call   80100566 <panic>

  iunlockput(dp);
80105d51:	83 ec 0c             	sub    $0xc,%esp
80105d54:	ff 75 f4             	pushl  -0xc(%ebp)
80105d57:	e8 55 be ff ff       	call   80101bb1 <iunlockput>
80105d5c:	83 c4 10             	add    $0x10,%esp

  return ip;
80105d5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105d62:	c9                   	leave  
80105d63:	c3                   	ret    

80105d64 <sys_open>:

int
sys_open(void)
{
80105d64:	55                   	push   %ebp
80105d65:	89 e5                	mov    %esp,%ebp
80105d67:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105d6a:	83 ec 08             	sub    $0x8,%esp
80105d6d:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105d70:	50                   	push   %eax
80105d71:	6a 00                	push   $0x0
80105d73:	e8 f5 f6 ff ff       	call   8010546d <argstr>
80105d78:	83 c4 10             	add    $0x10,%esp
80105d7b:	85 c0                	test   %eax,%eax
80105d7d:	78 15                	js     80105d94 <sys_open+0x30>
80105d7f:	83 ec 08             	sub    $0x8,%esp
80105d82:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d85:	50                   	push   %eax
80105d86:	6a 01                	push   $0x1
80105d88:	e8 5b f6 ff ff       	call   801053e8 <argint>
80105d8d:	83 c4 10             	add    $0x10,%esp
80105d90:	85 c0                	test   %eax,%eax
80105d92:	79 0a                	jns    80105d9e <sys_open+0x3a>
    return -1;
80105d94:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d99:	e9 4d 01 00 00       	jmp    80105eeb <sys_open+0x187>
  if(omode & O_CREATE){
80105d9e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105da1:	25 00 02 00 00       	and    $0x200,%eax
80105da6:	85 c0                	test   %eax,%eax
80105da8:	74 2f                	je     80105dd9 <sys_open+0x75>
    begin_trans();
80105daa:	e8 57 d7 ff ff       	call   80103506 <begin_trans>
    ip = create(path, T_FILE, 0, 0);
80105daf:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105db2:	6a 00                	push   $0x0
80105db4:	6a 00                	push   $0x0
80105db6:	6a 02                	push   $0x2
80105db8:	50                   	push   %eax
80105db9:	e8 d4 fd ff ff       	call   80105b92 <create>
80105dbe:	83 c4 10             	add    $0x10,%esp
80105dc1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    commit_trans();
80105dc4:	e8 90 d7 ff ff       	call   80103559 <commit_trans>
    if(ip == 0)
80105dc9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105dcd:	75 66                	jne    80105e35 <sys_open+0xd1>
      return -1;
80105dcf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dd4:	e9 12 01 00 00       	jmp    80105eeb <sys_open+0x187>
  } else {
    if((ip = namei(path)) == 0)
80105dd9:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105ddc:	83 ec 0c             	sub    $0xc,%esp
80105ddf:	50                   	push   %eax
80105de0:	e8 19 c8 ff ff       	call   801025fe <namei>
80105de5:	83 c4 10             	add    $0x10,%esp
80105de8:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105deb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105def:	75 0a                	jne    80105dfb <sys_open+0x97>
      return -1;
80105df1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105df6:	e9 f0 00 00 00       	jmp    80105eeb <sys_open+0x187>
    ilock(ip);
80105dfb:	83 ec 0c             	sub    $0xc,%esp
80105dfe:	ff 75 f4             	pushl  -0xc(%ebp)
80105e01:	e8 f1 ba ff ff       	call   801018f7 <ilock>
80105e06:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e0c:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105e10:	66 83 f8 01          	cmp    $0x1,%ax
80105e14:	75 1f                	jne    80105e35 <sys_open+0xd1>
80105e16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105e19:	85 c0                	test   %eax,%eax
80105e1b:	74 18                	je     80105e35 <sys_open+0xd1>
      iunlockput(ip);
80105e1d:	83 ec 0c             	sub    $0xc,%esp
80105e20:	ff 75 f4             	pushl  -0xc(%ebp)
80105e23:	e8 89 bd ff ff       	call   80101bb1 <iunlockput>
80105e28:	83 c4 10             	add    $0x10,%esp
      return -1;
80105e2b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e30:	e9 b6 00 00 00       	jmp    80105eeb <sys_open+0x187>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105e35:	e8 2a b1 ff ff       	call   80100f64 <filealloc>
80105e3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105e3d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e41:	74 17                	je     80105e5a <sys_open+0xf6>
80105e43:	83 ec 0c             	sub    $0xc,%esp
80105e46:	ff 75 f0             	pushl  -0x10(%ebp)
80105e49:	e8 4b f7 ff ff       	call   80105599 <fdalloc>
80105e4e:	83 c4 10             	add    $0x10,%esp
80105e51:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105e54:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105e58:	79 29                	jns    80105e83 <sys_open+0x11f>
    if(f)
80105e5a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e5e:	74 0e                	je     80105e6e <sys_open+0x10a>
      fileclose(f);
80105e60:	83 ec 0c             	sub    $0xc,%esp
80105e63:	ff 75 f0             	pushl  -0x10(%ebp)
80105e66:	e8 b7 b1 ff ff       	call   80101022 <fileclose>
80105e6b:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105e6e:	83 ec 0c             	sub    $0xc,%esp
80105e71:	ff 75 f4             	pushl  -0xc(%ebp)
80105e74:	e8 38 bd ff ff       	call   80101bb1 <iunlockput>
80105e79:	83 c4 10             	add    $0x10,%esp
    return -1;
80105e7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e81:	eb 68                	jmp    80105eeb <sys_open+0x187>
  }
  iunlock(ip);
80105e83:	83 ec 0c             	sub    $0xc,%esp
80105e86:	ff 75 f4             	pushl  -0xc(%ebp)
80105e89:	e8 c1 bb ff ff       	call   80101a4f <iunlock>
80105e8e:	83 c4 10             	add    $0x10,%esp

  f->type = FD_INODE;
80105e91:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e94:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80105e9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e9d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105ea0:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80105ea3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ea6:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80105ead:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105eb0:	83 e0 01             	and    $0x1,%eax
80105eb3:	85 c0                	test   %eax,%eax
80105eb5:	0f 94 c0             	sete   %al
80105eb8:	89 c2                	mov    %eax,%edx
80105eba:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ebd:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105ec0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ec3:	83 e0 01             	and    $0x1,%eax
80105ec6:	85 c0                	test   %eax,%eax
80105ec8:	75 0a                	jne    80105ed4 <sys_open+0x170>
80105eca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ecd:	83 e0 02             	and    $0x2,%eax
80105ed0:	85 c0                	test   %eax,%eax
80105ed2:	74 07                	je     80105edb <sys_open+0x177>
80105ed4:	b8 01 00 00 00       	mov    $0x1,%eax
80105ed9:	eb 05                	jmp    80105ee0 <sys_open+0x17c>
80105edb:	b8 00 00 00 00       	mov    $0x0,%eax
80105ee0:	89 c2                	mov    %eax,%edx
80105ee2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ee5:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80105ee8:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80105eeb:	c9                   	leave  
80105eec:	c3                   	ret    

80105eed <sys_mkdir>:

int
sys_mkdir(void)
{
80105eed:	55                   	push   %ebp
80105eee:	89 e5                	mov    %esp,%ebp
80105ef0:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_trans();
80105ef3:	e8 0e d6 ff ff       	call   80103506 <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105ef8:	83 ec 08             	sub    $0x8,%esp
80105efb:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105efe:	50                   	push   %eax
80105eff:	6a 00                	push   $0x0
80105f01:	e8 67 f5 ff ff       	call   8010546d <argstr>
80105f06:	83 c4 10             	add    $0x10,%esp
80105f09:	85 c0                	test   %eax,%eax
80105f0b:	78 1b                	js     80105f28 <sys_mkdir+0x3b>
80105f0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f10:	6a 00                	push   $0x0
80105f12:	6a 00                	push   $0x0
80105f14:	6a 01                	push   $0x1
80105f16:	50                   	push   %eax
80105f17:	e8 76 fc ff ff       	call   80105b92 <create>
80105f1c:	83 c4 10             	add    $0x10,%esp
80105f1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f22:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f26:	75 0c                	jne    80105f34 <sys_mkdir+0x47>
    commit_trans();
80105f28:	e8 2c d6 ff ff       	call   80103559 <commit_trans>
    return -1;
80105f2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f32:	eb 18                	jmp    80105f4c <sys_mkdir+0x5f>
  }
  iunlockput(ip);
80105f34:	83 ec 0c             	sub    $0xc,%esp
80105f37:	ff 75 f4             	pushl  -0xc(%ebp)
80105f3a:	e8 72 bc ff ff       	call   80101bb1 <iunlockput>
80105f3f:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105f42:	e8 12 d6 ff ff       	call   80103559 <commit_trans>
  return 0;
80105f47:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105f4c:	c9                   	leave  
80105f4d:	c3                   	ret    

80105f4e <sys_mknod>:

int
sys_mknod(void)
{
80105f4e:	55                   	push   %ebp
80105f4f:	89 e5                	mov    %esp,%ebp
80105f51:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
80105f54:	e8 ad d5 ff ff       	call   80103506 <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
80105f59:	83 ec 08             	sub    $0x8,%esp
80105f5c:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105f5f:	50                   	push   %eax
80105f60:	6a 00                	push   $0x0
80105f62:	e8 06 f5 ff ff       	call   8010546d <argstr>
80105f67:	83 c4 10             	add    $0x10,%esp
80105f6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f6d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f71:	78 4f                	js     80105fc2 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
80105f73:	83 ec 08             	sub    $0x8,%esp
80105f76:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105f79:	50                   	push   %eax
80105f7a:	6a 01                	push   $0x1
80105f7c:	e8 67 f4 ff ff       	call   801053e8 <argint>
80105f81:	83 c4 10             	add    $0x10,%esp
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
80105f84:	85 c0                	test   %eax,%eax
80105f86:	78 3a                	js     80105fc2 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105f88:	83 ec 08             	sub    $0x8,%esp
80105f8b:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f8e:	50                   	push   %eax
80105f8f:	6a 02                	push   $0x2
80105f91:	e8 52 f4 ff ff       	call   801053e8 <argint>
80105f96:	83 c4 10             	add    $0x10,%esp
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105f99:	85 c0                	test   %eax,%eax
80105f9b:	78 25                	js     80105fc2 <sys_mknod+0x74>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80105f9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105fa0:	0f bf c8             	movswl %ax,%ecx
80105fa3:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105fa6:	0f bf d0             	movswl %ax,%edx
80105fa9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105fac:	51                   	push   %ecx
80105fad:	52                   	push   %edx
80105fae:	6a 03                	push   $0x3
80105fb0:	50                   	push   %eax
80105fb1:	e8 dc fb ff ff       	call   80105b92 <create>
80105fb6:	83 c4 10             	add    $0x10,%esp
80105fb9:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105fbc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105fc0:	75 0c                	jne    80105fce <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    commit_trans();
80105fc2:	e8 92 d5 ff ff       	call   80103559 <commit_trans>
    return -1;
80105fc7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fcc:	eb 18                	jmp    80105fe6 <sys_mknod+0x98>
  }
  iunlockput(ip);
80105fce:	83 ec 0c             	sub    $0xc,%esp
80105fd1:	ff 75 f0             	pushl  -0x10(%ebp)
80105fd4:	e8 d8 bb ff ff       	call   80101bb1 <iunlockput>
80105fd9:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105fdc:	e8 78 d5 ff ff       	call   80103559 <commit_trans>
  return 0;
80105fe1:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105fe6:	c9                   	leave  
80105fe7:	c3                   	ret    

80105fe8 <sys_chdir>:

int
sys_chdir(void)
{
80105fe8:	55                   	push   %ebp
80105fe9:	89 e5                	mov    %esp,%ebp
80105feb:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80105fee:	83 ec 08             	sub    $0x8,%esp
80105ff1:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ff4:	50                   	push   %eax
80105ff5:	6a 00                	push   $0x0
80105ff7:	e8 71 f4 ff ff       	call   8010546d <argstr>
80105ffc:	83 c4 10             	add    $0x10,%esp
80105fff:	85 c0                	test   %eax,%eax
80106001:	78 18                	js     8010601b <sys_chdir+0x33>
80106003:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106006:	83 ec 0c             	sub    $0xc,%esp
80106009:	50                   	push   %eax
8010600a:	e8 ef c5 ff ff       	call   801025fe <namei>
8010600f:	83 c4 10             	add    $0x10,%esp
80106012:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106015:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106019:	75 07                	jne    80106022 <sys_chdir+0x3a>
    return -1;
8010601b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106020:	eb 64                	jmp    80106086 <sys_chdir+0x9e>
  ilock(ip);
80106022:	83 ec 0c             	sub    $0xc,%esp
80106025:	ff 75 f4             	pushl  -0xc(%ebp)
80106028:	e8 ca b8 ff ff       	call   801018f7 <ilock>
8010602d:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
80106030:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106033:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106037:	66 83 f8 01          	cmp    $0x1,%ax
8010603b:	74 15                	je     80106052 <sys_chdir+0x6a>
    iunlockput(ip);
8010603d:	83 ec 0c             	sub    $0xc,%esp
80106040:	ff 75 f4             	pushl  -0xc(%ebp)
80106043:	e8 69 bb ff ff       	call   80101bb1 <iunlockput>
80106048:	83 c4 10             	add    $0x10,%esp
    return -1;
8010604b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106050:	eb 34                	jmp    80106086 <sys_chdir+0x9e>
  }
  iunlock(ip);
80106052:	83 ec 0c             	sub    $0xc,%esp
80106055:	ff 75 f4             	pushl  -0xc(%ebp)
80106058:	e8 f2 b9 ff ff       	call   80101a4f <iunlock>
8010605d:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
80106060:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106066:	8b 40 68             	mov    0x68(%eax),%eax
80106069:	83 ec 0c             	sub    $0xc,%esp
8010606c:	50                   	push   %eax
8010606d:	e8 4f ba ff ff       	call   80101ac1 <iput>
80106072:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
80106075:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010607b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010607e:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80106081:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106086:	c9                   	leave  
80106087:	c3                   	ret    

80106088 <sys_exec>:

int
sys_exec(void)
{
80106088:	55                   	push   %ebp
80106089:	89 e5                	mov    %esp,%ebp
8010608b:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106091:	83 ec 08             	sub    $0x8,%esp
80106094:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106097:	50                   	push   %eax
80106098:	6a 00                	push   $0x0
8010609a:	e8 ce f3 ff ff       	call   8010546d <argstr>
8010609f:	83 c4 10             	add    $0x10,%esp
801060a2:	85 c0                	test   %eax,%eax
801060a4:	78 18                	js     801060be <sys_exec+0x36>
801060a6:	83 ec 08             	sub    $0x8,%esp
801060a9:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
801060af:	50                   	push   %eax
801060b0:	6a 01                	push   $0x1
801060b2:	e8 31 f3 ff ff       	call   801053e8 <argint>
801060b7:	83 c4 10             	add    $0x10,%esp
801060ba:	85 c0                	test   %eax,%eax
801060bc:	79 0a                	jns    801060c8 <sys_exec+0x40>
    return -1;
801060be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060c3:	e9 c6 00 00 00       	jmp    8010618e <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
801060c8:	83 ec 04             	sub    $0x4,%esp
801060cb:	68 80 00 00 00       	push   $0x80
801060d0:	6a 00                	push   $0x0
801060d2:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801060d8:	50                   	push   %eax
801060d9:	e8 e5 ef ff ff       	call   801050c3 <memset>
801060de:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
801060e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
801060e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060eb:	83 f8 1f             	cmp    $0x1f,%eax
801060ee:	76 0a                	jbe    801060fa <sys_exec+0x72>
      return -1;
801060f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060f5:	e9 94 00 00 00       	jmp    8010618e <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801060fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060fd:	c1 e0 02             	shl    $0x2,%eax
80106100:	89 c2                	mov    %eax,%edx
80106102:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
80106108:	01 c2                	add    %eax,%edx
8010610a:	83 ec 08             	sub    $0x8,%esp
8010610d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106113:	50                   	push   %eax
80106114:	52                   	push   %edx
80106115:	e8 32 f2 ff ff       	call   8010534c <fetchint>
8010611a:	83 c4 10             	add    $0x10,%esp
8010611d:	85 c0                	test   %eax,%eax
8010611f:	79 07                	jns    80106128 <sys_exec+0xa0>
      return -1;
80106121:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106126:	eb 66                	jmp    8010618e <sys_exec+0x106>
    if(uarg == 0){
80106128:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010612e:	85 c0                	test   %eax,%eax
80106130:	75 27                	jne    80106159 <sys_exec+0xd1>
      argv[i] = 0;
80106132:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106135:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
8010613c:	00 00 00 00 
      break;
80106140:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106141:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106144:	83 ec 08             	sub    $0x8,%esp
80106147:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
8010614d:	52                   	push   %edx
8010614e:	50                   	push   %eax
8010614f:	e8 02 aa ff ff       	call   80100b56 <exec>
80106154:	83 c4 10             	add    $0x10,%esp
80106157:	eb 35                	jmp    8010618e <sys_exec+0x106>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106159:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010615f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106162:	c1 e2 02             	shl    $0x2,%edx
80106165:	01 c2                	add    %eax,%edx
80106167:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010616d:	83 ec 08             	sub    $0x8,%esp
80106170:	52                   	push   %edx
80106171:	50                   	push   %eax
80106172:	e8 0f f2 ff ff       	call   80105386 <fetchstr>
80106177:	83 c4 10             	add    $0x10,%esp
8010617a:	85 c0                	test   %eax,%eax
8010617c:	79 07                	jns    80106185 <sys_exec+0xfd>
      return -1;
8010617e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106183:	eb 09                	jmp    8010618e <sys_exec+0x106>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80106185:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
80106189:	e9 5a ff ff ff       	jmp    801060e8 <sys_exec+0x60>
  return exec(path, argv);
}
8010618e:	c9                   	leave  
8010618f:	c3                   	ret    

80106190 <sys_pipe>:

int
sys_pipe(void)
{
80106190:	55                   	push   %ebp
80106191:	89 e5                	mov    %esp,%ebp
80106193:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106196:	83 ec 04             	sub    $0x4,%esp
80106199:	6a 08                	push   $0x8
8010619b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010619e:	50                   	push   %eax
8010619f:	6a 00                	push   $0x0
801061a1:	e8 6a f2 ff ff       	call   80105410 <argptr>
801061a6:	83 c4 10             	add    $0x10,%esp
801061a9:	85 c0                	test   %eax,%eax
801061ab:	79 0a                	jns    801061b7 <sys_pipe+0x27>
    return -1;
801061ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061b2:	e9 af 00 00 00       	jmp    80106266 <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
801061b7:	83 ec 08             	sub    $0x8,%esp
801061ba:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801061bd:	50                   	push   %eax
801061be:	8d 45 e8             	lea    -0x18(%ebp),%eax
801061c1:	50                   	push   %eax
801061c2:	e8 1a dd ff ff       	call   80103ee1 <pipealloc>
801061c7:	83 c4 10             	add    $0x10,%esp
801061ca:	85 c0                	test   %eax,%eax
801061cc:	79 0a                	jns    801061d8 <sys_pipe+0x48>
    return -1;
801061ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061d3:	e9 8e 00 00 00       	jmp    80106266 <sys_pipe+0xd6>
  fd0 = -1;
801061d8:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801061df:	8b 45 e8             	mov    -0x18(%ebp),%eax
801061e2:	83 ec 0c             	sub    $0xc,%esp
801061e5:	50                   	push   %eax
801061e6:	e8 ae f3 ff ff       	call   80105599 <fdalloc>
801061eb:	83 c4 10             	add    $0x10,%esp
801061ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
801061f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061f5:	78 18                	js     8010620f <sys_pipe+0x7f>
801061f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801061fa:	83 ec 0c             	sub    $0xc,%esp
801061fd:	50                   	push   %eax
801061fe:	e8 96 f3 ff ff       	call   80105599 <fdalloc>
80106203:	83 c4 10             	add    $0x10,%esp
80106206:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106209:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010620d:	79 3f                	jns    8010624e <sys_pipe+0xbe>
    if(fd0 >= 0)
8010620f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106213:	78 14                	js     80106229 <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
80106215:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010621b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010621e:	83 c2 08             	add    $0x8,%edx
80106221:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80106228:	00 
    fileclose(rf);
80106229:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010622c:	83 ec 0c             	sub    $0xc,%esp
8010622f:	50                   	push   %eax
80106230:	e8 ed ad ff ff       	call   80101022 <fileclose>
80106235:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
80106238:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010623b:	83 ec 0c             	sub    $0xc,%esp
8010623e:	50                   	push   %eax
8010623f:	e8 de ad ff ff       	call   80101022 <fileclose>
80106244:	83 c4 10             	add    $0x10,%esp
    return -1;
80106247:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010624c:	eb 18                	jmp    80106266 <sys_pipe+0xd6>
  }
  fd[0] = fd0;
8010624e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106251:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106254:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80106256:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106259:	8d 50 04             	lea    0x4(%eax),%edx
8010625c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010625f:	89 02                	mov    %eax,(%edx)
  return 0;
80106261:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106266:	c9                   	leave  
80106267:	c3                   	ret    

80106268 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106268:	55                   	push   %ebp
80106269:	89 e5                	mov    %esp,%ebp
8010626b:	83 ec 08             	sub    $0x8,%esp
  return fork();
8010626e:	e8 64 e3 ff ff       	call   801045d7 <fork>
}
80106273:	c9                   	leave  
80106274:	c3                   	ret    

80106275 <sys_exit>:

int
sys_exit(void)
{
80106275:	55                   	push   %ebp
80106276:	89 e5                	mov    %esp,%ebp
80106278:	83 ec 08             	sub    $0x8,%esp
  exit();
8010627b:	e8 c8 e4 ff ff       	call   80104748 <exit>
  return 0;  // not reached
80106280:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106285:	c9                   	leave  
80106286:	c3                   	ret    

80106287 <sys_wait>:

int
sys_wait(void)
{
80106287:	55                   	push   %ebp
80106288:	89 e5                	mov    %esp,%ebp
8010628a:	83 ec 08             	sub    $0x8,%esp
  return wait();
8010628d:	e8 e4 e5 ff ff       	call   80104876 <wait>
}
80106292:	c9                   	leave  
80106293:	c3                   	ret    

80106294 <sys_kill>:

int
sys_kill(void)
{
80106294:	55                   	push   %ebp
80106295:	89 e5                	mov    %esp,%ebp
80106297:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
8010629a:	83 ec 08             	sub    $0x8,%esp
8010629d:	8d 45 f4             	lea    -0xc(%ebp),%eax
801062a0:	50                   	push   %eax
801062a1:	6a 00                	push   $0x0
801062a3:	e8 40 f1 ff ff       	call   801053e8 <argint>
801062a8:	83 c4 10             	add    $0x10,%esp
801062ab:	85 c0                	test   %eax,%eax
801062ad:	79 07                	jns    801062b6 <sys_kill+0x22>
    return -1;
801062af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062b4:	eb 0f                	jmp    801062c5 <sys_kill+0x31>
  return kill(pid);
801062b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062b9:	83 ec 0c             	sub    $0xc,%esp
801062bc:	50                   	push   %eax
801062bd:	e8 c7 e9 ff ff       	call   80104c89 <kill>
801062c2:	83 c4 10             	add    $0x10,%esp
}
801062c5:	c9                   	leave  
801062c6:	c3                   	ret    

801062c7 <sys_getpid>:

int
sys_getpid(void)
{
801062c7:	55                   	push   %ebp
801062c8:	89 e5                	mov    %esp,%ebp
  return proc->pid;
801062ca:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062d0:	8b 40 10             	mov    0x10(%eax),%eax
}
801062d3:	5d                   	pop    %ebp
801062d4:	c3                   	ret    

801062d5 <sys_sbrk>:

int
sys_sbrk(void)
{
801062d5:	55                   	push   %ebp
801062d6:	89 e5                	mov    %esp,%ebp
801062d8:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801062db:	83 ec 08             	sub    $0x8,%esp
801062de:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062e1:	50                   	push   %eax
801062e2:	6a 00                	push   $0x0
801062e4:	e8 ff f0 ff ff       	call   801053e8 <argint>
801062e9:	83 c4 10             	add    $0x10,%esp
801062ec:	85 c0                	test   %eax,%eax
801062ee:	79 07                	jns    801062f7 <sys_sbrk+0x22>
    return -1;
801062f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062f5:	eb 28                	jmp    8010631f <sys_sbrk+0x4a>
  addr = proc->sz;
801062f7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062fd:	8b 00                	mov    (%eax),%eax
801062ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80106302:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106305:	83 ec 0c             	sub    $0xc,%esp
80106308:	50                   	push   %eax
80106309:	e8 26 e2 ff ff       	call   80104534 <growproc>
8010630e:	83 c4 10             	add    $0x10,%esp
80106311:	85 c0                	test   %eax,%eax
80106313:	79 07                	jns    8010631c <sys_sbrk+0x47>
    return -1;
80106315:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010631a:	eb 03                	jmp    8010631f <sys_sbrk+0x4a>
  return addr;
8010631c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010631f:	c9                   	leave  
80106320:	c3                   	ret    

80106321 <sys_sleep>:

int
sys_sleep(void)
{
80106321:	55                   	push   %ebp
80106322:	89 e5                	mov    %esp,%ebp
80106324:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
80106327:	83 ec 08             	sub    $0x8,%esp
8010632a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010632d:	50                   	push   %eax
8010632e:	6a 00                	push   $0x0
80106330:	e8 b3 f0 ff ff       	call   801053e8 <argint>
80106335:	83 c4 10             	add    $0x10,%esp
80106338:	85 c0                	test   %eax,%eax
8010633a:	79 07                	jns    80106343 <sys_sleep+0x22>
    return -1;
8010633c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106341:	eb 77                	jmp    801063ba <sys_sleep+0x99>
  acquire(&tickslock);
80106343:	83 ec 0c             	sub    $0xc,%esp
80106346:	68 c0 4e 11 80       	push   $0x80114ec0
8010634b:	e8 10 eb ff ff       	call   80104e60 <acquire>
80106350:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80106353:	a1 00 57 11 80       	mov    0x80115700,%eax
80106358:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
8010635b:	eb 39                	jmp    80106396 <sys_sleep+0x75>
    if(proc->killed){
8010635d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106363:	8b 40 24             	mov    0x24(%eax),%eax
80106366:	85 c0                	test   %eax,%eax
80106368:	74 17                	je     80106381 <sys_sleep+0x60>
      release(&tickslock);
8010636a:	83 ec 0c             	sub    $0xc,%esp
8010636d:	68 c0 4e 11 80       	push   $0x80114ec0
80106372:	e8 50 eb ff ff       	call   80104ec7 <release>
80106377:	83 c4 10             	add    $0x10,%esp
      return -1;
8010637a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010637f:	eb 39                	jmp    801063ba <sys_sleep+0x99>
    }
    sleep(&ticks, &tickslock);
80106381:	83 ec 08             	sub    $0x8,%esp
80106384:	68 c0 4e 11 80       	push   $0x80114ec0
80106389:	68 00 57 11 80       	push   $0x80115700
8010638e:	e8 d4 e7 ff ff       	call   80104b67 <sleep>
80106393:	83 c4 10             	add    $0x10,%esp
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106396:	a1 00 57 11 80       	mov    0x80115700,%eax
8010639b:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010639e:	8b 55 f0             	mov    -0x10(%ebp),%edx
801063a1:	39 d0                	cmp    %edx,%eax
801063a3:	72 b8                	jb     8010635d <sys_sleep+0x3c>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801063a5:	83 ec 0c             	sub    $0xc,%esp
801063a8:	68 c0 4e 11 80       	push   $0x80114ec0
801063ad:	e8 15 eb ff ff       	call   80104ec7 <release>
801063b2:	83 c4 10             	add    $0x10,%esp
  return 0;
801063b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
801063ba:	c9                   	leave  
801063bb:	c3                   	ret    

801063bc <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801063bc:	55                   	push   %ebp
801063bd:	89 e5                	mov    %esp,%ebp
801063bf:	83 ec 18             	sub    $0x18,%esp
  uint xticks;
  
  acquire(&tickslock);
801063c2:	83 ec 0c             	sub    $0xc,%esp
801063c5:	68 c0 4e 11 80       	push   $0x80114ec0
801063ca:	e8 91 ea ff ff       	call   80104e60 <acquire>
801063cf:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
801063d2:	a1 00 57 11 80       	mov    0x80115700,%eax
801063d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
801063da:	83 ec 0c             	sub    $0xc,%esp
801063dd:	68 c0 4e 11 80       	push   $0x80114ec0
801063e2:	e8 e0 ea ff ff       	call   80104ec7 <release>
801063e7:	83 c4 10             	add    $0x10,%esp
  return xticks;
801063ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801063ed:	c9                   	leave  
801063ee:	c3                   	ret    

801063ef <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801063ef:	55                   	push   %ebp
801063f0:	89 e5                	mov    %esp,%ebp
801063f2:	83 ec 08             	sub    $0x8,%esp
801063f5:	8b 55 08             	mov    0x8(%ebp),%edx
801063f8:	8b 45 0c             	mov    0xc(%ebp),%eax
801063fb:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801063ff:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106402:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106406:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010640a:	ee                   	out    %al,(%dx)
}
8010640b:	90                   	nop
8010640c:	c9                   	leave  
8010640d:	c3                   	ret    

8010640e <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
8010640e:	55                   	push   %ebp
8010640f:	89 e5                	mov    %esp,%ebp
80106411:	83 ec 08             	sub    $0x8,%esp
  // Interrupt --- 100 ticks/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
80106414:	6a 34                	push   $0x34
80106416:	6a 43                	push   $0x43
80106418:	e8 d2 ff ff ff       	call   801063ef <outb>
8010641d:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
80106420:	68 9c 00 00 00       	push   $0x9c
80106425:	6a 40                	push   $0x40
80106427:	e8 c3 ff ff ff       	call   801063ef <outb>
8010642c:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
8010642f:	6a 2e                	push   $0x2e
80106431:	6a 40                	push   $0x40
80106433:	e8 b7 ff ff ff       	call   801063ef <outb>
80106438:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
8010643b:	83 ec 0c             	sub    $0xc,%esp
8010643e:	6a 00                	push   $0x0
80106440:	e8 86 d9 ff ff       	call   80103dcb <picenable>
80106445:	83 c4 10             	add    $0x10,%esp
}
80106448:	90                   	nop
80106449:	c9                   	leave  
8010644a:	c3                   	ret    

8010644b <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010644b:	1e                   	push   %ds
  pushl %es
8010644c:	06                   	push   %es
  pushl %fs
8010644d:	0f a0                	push   %fs
  pushl %gs
8010644f:	0f a8                	push   %gs
  pushal
80106451:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80106452:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106456:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106458:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
8010645a:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
8010645e:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80106460:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80106462:	54                   	push   %esp
  call trap
80106463:	e8 d7 01 00 00       	call   8010663f <trap>
  addl $4, %esp
80106468:	83 c4 04             	add    $0x4,%esp

8010646b <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010646b:	61                   	popa   
  popl %gs
8010646c:	0f a9                	pop    %gs
  popl %fs
8010646e:	0f a1                	pop    %fs
  popl %es
80106470:	07                   	pop    %es
  popl %ds
80106471:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106472:	83 c4 08             	add    $0x8,%esp
  iret
80106475:	cf                   	iret   

80106476 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
80106476:	55                   	push   %ebp
80106477:	89 e5                	mov    %esp,%ebp
80106479:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
8010647c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010647f:	83 e8 01             	sub    $0x1,%eax
80106482:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106486:	8b 45 08             	mov    0x8(%ebp),%eax
80106489:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010648d:	8b 45 08             	mov    0x8(%ebp),%eax
80106490:	c1 e8 10             	shr    $0x10,%eax
80106493:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106497:	8d 45 fa             	lea    -0x6(%ebp),%eax
8010649a:	0f 01 18             	lidtl  (%eax)
}
8010649d:	90                   	nop
8010649e:	c9                   	leave  
8010649f:	c3                   	ret    

801064a0 <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
801064a0:	55                   	push   %ebp
801064a1:	89 e5                	mov    %esp,%ebp
801064a3:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801064a6:	0f 20 d0             	mov    %cr2,%eax
801064a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
801064ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801064af:	c9                   	leave  
801064b0:	c3                   	ret    

801064b1 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801064b1:	55                   	push   %ebp
801064b2:	89 e5                	mov    %esp,%ebp
801064b4:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
801064b7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801064be:	e9 c3 00 00 00       	jmp    80106586 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801064c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064c6:	8b 04 85 ac e0 10 80 	mov    -0x7fef1f54(,%eax,4),%eax
801064cd:	89 c2                	mov    %eax,%edx
801064cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064d2:	66 89 14 c5 00 4f 11 	mov    %dx,-0x7feeb100(,%eax,8)
801064d9:	80 
801064da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064dd:	66 c7 04 c5 02 4f 11 	movw   $0x8,-0x7feeb0fe(,%eax,8)
801064e4:	80 08 00 
801064e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064ea:	0f b6 14 c5 04 4f 11 	movzbl -0x7feeb0fc(,%eax,8),%edx
801064f1:	80 
801064f2:	83 e2 e0             	and    $0xffffffe0,%edx
801064f5:	88 14 c5 04 4f 11 80 	mov    %dl,-0x7feeb0fc(,%eax,8)
801064fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064ff:	0f b6 14 c5 04 4f 11 	movzbl -0x7feeb0fc(,%eax,8),%edx
80106506:	80 
80106507:	83 e2 1f             	and    $0x1f,%edx
8010650a:	88 14 c5 04 4f 11 80 	mov    %dl,-0x7feeb0fc(,%eax,8)
80106511:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106514:	0f b6 14 c5 05 4f 11 	movzbl -0x7feeb0fb(,%eax,8),%edx
8010651b:	80 
8010651c:	83 e2 f0             	and    $0xfffffff0,%edx
8010651f:	83 ca 0e             	or     $0xe,%edx
80106522:	88 14 c5 05 4f 11 80 	mov    %dl,-0x7feeb0fb(,%eax,8)
80106529:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010652c:	0f b6 14 c5 05 4f 11 	movzbl -0x7feeb0fb(,%eax,8),%edx
80106533:	80 
80106534:	83 e2 ef             	and    $0xffffffef,%edx
80106537:	88 14 c5 05 4f 11 80 	mov    %dl,-0x7feeb0fb(,%eax,8)
8010653e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106541:	0f b6 14 c5 05 4f 11 	movzbl -0x7feeb0fb(,%eax,8),%edx
80106548:	80 
80106549:	83 e2 9f             	and    $0xffffff9f,%edx
8010654c:	88 14 c5 05 4f 11 80 	mov    %dl,-0x7feeb0fb(,%eax,8)
80106553:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106556:	0f b6 14 c5 05 4f 11 	movzbl -0x7feeb0fb(,%eax,8),%edx
8010655d:	80 
8010655e:	83 ca 80             	or     $0xffffff80,%edx
80106561:	88 14 c5 05 4f 11 80 	mov    %dl,-0x7feeb0fb(,%eax,8)
80106568:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010656b:	8b 04 85 ac e0 10 80 	mov    -0x7fef1f54(,%eax,4),%eax
80106572:	c1 e8 10             	shr    $0x10,%eax
80106575:	89 c2                	mov    %eax,%edx
80106577:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010657a:	66 89 14 c5 06 4f 11 	mov    %dx,-0x7feeb0fa(,%eax,8)
80106581:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106582:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106586:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
8010658d:	0f 8e 30 ff ff ff    	jle    801064c3 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106593:	a1 ac e1 10 80       	mov    0x8010e1ac,%eax
80106598:	66 a3 00 51 11 80    	mov    %ax,0x80115100
8010659e:	66 c7 05 02 51 11 80 	movw   $0x8,0x80115102
801065a5:	08 00 
801065a7:	0f b6 05 04 51 11 80 	movzbl 0x80115104,%eax
801065ae:	83 e0 e0             	and    $0xffffffe0,%eax
801065b1:	a2 04 51 11 80       	mov    %al,0x80115104
801065b6:	0f b6 05 04 51 11 80 	movzbl 0x80115104,%eax
801065bd:	83 e0 1f             	and    $0x1f,%eax
801065c0:	a2 04 51 11 80       	mov    %al,0x80115104
801065c5:	0f b6 05 05 51 11 80 	movzbl 0x80115105,%eax
801065cc:	83 c8 0f             	or     $0xf,%eax
801065cf:	a2 05 51 11 80       	mov    %al,0x80115105
801065d4:	0f b6 05 05 51 11 80 	movzbl 0x80115105,%eax
801065db:	83 e0 ef             	and    $0xffffffef,%eax
801065de:	a2 05 51 11 80       	mov    %al,0x80115105
801065e3:	0f b6 05 05 51 11 80 	movzbl 0x80115105,%eax
801065ea:	83 c8 60             	or     $0x60,%eax
801065ed:	a2 05 51 11 80       	mov    %al,0x80115105
801065f2:	0f b6 05 05 51 11 80 	movzbl 0x80115105,%eax
801065f9:	83 c8 80             	or     $0xffffff80,%eax
801065fc:	a2 05 51 11 80       	mov    %al,0x80115105
80106601:	a1 ac e1 10 80       	mov    0x8010e1ac,%eax
80106606:	c1 e8 10             	shr    $0x10,%eax
80106609:	66 a3 06 51 11 80    	mov    %ax,0x80115106
  
  initlock(&tickslock, "time");
8010660f:	83 ec 08             	sub    $0x8,%esp
80106612:	68 60 b8 10 80       	push   $0x8010b860
80106617:	68 c0 4e 11 80       	push   $0x80114ec0
8010661c:	e8 1d e8 ff ff       	call   80104e3e <initlock>
80106621:	83 c4 10             	add    $0x10,%esp
}
80106624:	90                   	nop
80106625:	c9                   	leave  
80106626:	c3                   	ret    

80106627 <idtinit>:

void
idtinit(void)
{
80106627:	55                   	push   %ebp
80106628:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
8010662a:	68 00 08 00 00       	push   $0x800
8010662f:	68 00 4f 11 80       	push   $0x80114f00
80106634:	e8 3d fe ff ff       	call   80106476 <lidt>
80106639:	83 c4 08             	add    $0x8,%esp
}
8010663c:	90                   	nop
8010663d:	c9                   	leave  
8010663e:	c3                   	ret    

8010663f <trap>:
extern void TimerCount();

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
8010663f:	55                   	push   %ebp
80106640:	89 e5                	mov    %esp,%ebp
80106642:	57                   	push   %edi
80106643:	56                   	push   %esi
80106644:	53                   	push   %ebx
80106645:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
80106648:	8b 45 08             	mov    0x8(%ebp),%eax
8010664b:	8b 40 30             	mov    0x30(%eax),%eax
8010664e:	83 f8 40             	cmp    $0x40,%eax
80106651:	75 3e                	jne    80106691 <trap+0x52>
    if(proc->killed)
80106653:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106659:	8b 40 24             	mov    0x24(%eax),%eax
8010665c:	85 c0                	test   %eax,%eax
8010665e:	74 05                	je     80106665 <trap+0x26>
      exit();
80106660:	e8 e3 e0 ff ff       	call   80104748 <exit>
    proc->tf = tf;
80106665:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010666b:	8b 55 08             	mov    0x8(%ebp),%edx
8010666e:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80106671:	e8 28 ee ff ff       	call   8010549e <syscall>
    if(proc->killed)
80106676:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010667c:	8b 40 24             	mov    0x24(%eax),%eax
8010667f:	85 c0                	test   %eax,%eax
80106681:	0f 84 20 02 00 00    	je     801068a7 <trap+0x268>
      exit();
80106687:	e8 bc e0 ff ff       	call   80104748 <exit>
    return;
8010668c:	e9 16 02 00 00       	jmp    801068a7 <trap+0x268>
  }

  switch(tf->trapno){
80106691:	8b 45 08             	mov    0x8(%ebp),%eax
80106694:	8b 40 30             	mov    0x30(%eax),%eax
80106697:	83 e8 20             	sub    $0x20,%eax
8010669a:	83 f8 1f             	cmp    $0x1f,%eax
8010669d:	0f 87 c5 00 00 00    	ja     80106768 <trap+0x129>
801066a3:	8b 04 85 08 b9 10 80 	mov    -0x7fef46f8(,%eax,4),%eax
801066aa:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
801066ac:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801066b2:	0f b6 00             	movzbl (%eax),%eax
801066b5:	84 c0                	test   %al,%al
801066b7:	75 3d                	jne    801066f6 <trap+0xb7>
      acquire(&tickslock);
801066b9:	83 ec 0c             	sub    $0xc,%esp
801066bc:	68 c0 4e 11 80       	push   $0x80114ec0
801066c1:	e8 9a e7 ff ff       	call   80104e60 <acquire>
801066c6:	83 c4 10             	add    $0x10,%esp
      ticks++;
801066c9:	a1 00 57 11 80       	mov    0x80115700,%eax
801066ce:	83 c0 01             	add    $0x1,%eax
801066d1:	a3 00 57 11 80       	mov    %eax,0x80115700
      wakeup(&ticks);
801066d6:	83 ec 0c             	sub    $0xc,%esp
801066d9:	68 00 57 11 80       	push   $0x80115700
801066de:	e8 6f e5 ff ff       	call   80104c52 <wakeup>
801066e3:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
801066e6:	83 ec 0c             	sub    $0xc,%esp
801066e9:	68 c0 4e 11 80       	push   $0x80114ec0
801066ee:	e8 d4 e7 ff ff       	call   80104ec7 <release>
801066f3:	83 c4 10             	add    $0x10,%esp
    }
	//DealHandleMessage(ticks);
    TimerCount();
801066f6:	e8 d1 46 00 00       	call   8010adcc <TimerCount>
    lapiceoi();
801066fb:	e8 de ca ff ff       	call   801031de <lapiceoi>
    break;
80106700:	e9 1c 01 00 00       	jmp    80106821 <trap+0x1e2>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106705:	e8 c8 c1 ff ff       	call   801028d2 <ideintr>
    lapiceoi();
8010670a:	e8 cf ca ff ff       	call   801031de <lapiceoi>
    break;
8010670f:	e9 0d 01 00 00       	jmp    80106821 <trap+0x1e2>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106714:	e8 ef c8 ff ff       	call   80103008 <kbdintr>
    lapiceoi();
80106719:	e8 c0 ca ff ff       	call   801031de <lapiceoi>
    break;
8010671e:	e9 fe 00 00 00       	jmp    80106821 <trap+0x1e2>

    //HandleInterupt();
    //lapiceoi();
  //  break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106723:	e8 60 03 00 00       	call   80106a88 <uartintr>
    lapiceoi();
80106728:	e8 b1 ca ff ff       	call   801031de <lapiceoi>
    break;
8010672d:	e9 ef 00 00 00       	jmp    80106821 <trap+0x1e2>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106732:	8b 45 08             	mov    0x8(%ebp),%eax
80106735:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80106738:	8b 45 08             	mov    0x8(%ebp),%eax
8010673b:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010673f:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
80106742:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106748:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010674b:	0f b6 c0             	movzbl %al,%eax
8010674e:	51                   	push   %ecx
8010674f:	52                   	push   %edx
80106750:	50                   	push   %eax
80106751:	68 68 b8 10 80       	push   $0x8010b868
80106756:	e8 6b 9c ff ff       	call   801003c6 <cprintf>
8010675b:	83 c4 10             	add    $0x10,%esp
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
8010675e:	e8 7b ca ff ff       	call   801031de <lapiceoi>
    break;
80106763:	e9 b9 00 00 00       	jmp    80106821 <trap+0x1e2>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106768:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010676e:	85 c0                	test   %eax,%eax
80106770:	74 11                	je     80106783 <trap+0x144>
80106772:	8b 45 08             	mov    0x8(%ebp),%eax
80106775:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106779:	0f b7 c0             	movzwl %ax,%eax
8010677c:	83 e0 03             	and    $0x3,%eax
8010677f:	85 c0                	test   %eax,%eax
80106781:	75 40                	jne    801067c3 <trap+0x184>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106783:	e8 18 fd ff ff       	call   801064a0 <rcr2>
80106788:	89 c3                	mov    %eax,%ebx
8010678a:	8b 45 08             	mov    0x8(%ebp),%eax
8010678d:	8b 48 38             	mov    0x38(%eax),%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
80106790:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106796:	0f b6 00             	movzbl (%eax),%eax
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106799:	0f b6 d0             	movzbl %al,%edx
8010679c:	8b 45 08             	mov    0x8(%ebp),%eax
8010679f:	8b 40 30             	mov    0x30(%eax),%eax
801067a2:	83 ec 0c             	sub    $0xc,%esp
801067a5:	53                   	push   %ebx
801067a6:	51                   	push   %ecx
801067a7:	52                   	push   %edx
801067a8:	50                   	push   %eax
801067a9:	68 8c b8 10 80       	push   $0x8010b88c
801067ae:	e8 13 9c ff ff       	call   801003c6 <cprintf>
801067b3:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
801067b6:	83 ec 0c             	sub    $0xc,%esp
801067b9:	68 be b8 10 80       	push   $0x8010b8be
801067be:	e8 a3 9d ff ff       	call   80100566 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801067c3:	e8 d8 fc ff ff       	call   801064a0 <rcr2>
801067c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801067cb:	8b 45 08             	mov    0x8(%ebp),%eax
801067ce:	8b 70 38             	mov    0x38(%eax),%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801067d1:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801067d7:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801067da:	0f b6 d8             	movzbl %al,%ebx
801067dd:	8b 45 08             	mov    0x8(%ebp),%eax
801067e0:	8b 48 34             	mov    0x34(%eax),%ecx
801067e3:	8b 45 08             	mov    0x8(%ebp),%eax
801067e6:	8b 50 30             	mov    0x30(%eax),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801067e9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801067ef:	8d 78 6c             	lea    0x6c(%eax),%edi
801067f2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801067f8:	8b 40 10             	mov    0x10(%eax),%eax
801067fb:	ff 75 e4             	pushl  -0x1c(%ebp)
801067fe:	56                   	push   %esi
801067ff:	53                   	push   %ebx
80106800:	51                   	push   %ecx
80106801:	52                   	push   %edx
80106802:	57                   	push   %edi
80106803:	50                   	push   %eax
80106804:	68 c4 b8 10 80       	push   $0x8010b8c4
80106809:	e8 b8 9b ff ff       	call   801003c6 <cprintf>
8010680e:	83 c4 20             	add    $0x20,%esp
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
80106811:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106817:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010681e:	eb 01                	jmp    80106821 <trap+0x1e2>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106820:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106821:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106827:	85 c0                	test   %eax,%eax
80106829:	74 24                	je     8010684f <trap+0x210>
8010682b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106831:	8b 40 24             	mov    0x24(%eax),%eax
80106834:	85 c0                	test   %eax,%eax
80106836:	74 17                	je     8010684f <trap+0x210>
80106838:	8b 45 08             	mov    0x8(%ebp),%eax
8010683b:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
8010683f:	0f b7 c0             	movzwl %ax,%eax
80106842:	83 e0 03             	and    $0x3,%eax
80106845:	83 f8 03             	cmp    $0x3,%eax
80106848:	75 05                	jne    8010684f <trap+0x210>
    exit();
8010684a:	e8 f9 de ff ff       	call   80104748 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
8010684f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106855:	85 c0                	test   %eax,%eax
80106857:	74 1e                	je     80106877 <trap+0x238>
80106859:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010685f:	8b 40 0c             	mov    0xc(%eax),%eax
80106862:	83 f8 04             	cmp    $0x4,%eax
80106865:	75 10                	jne    80106877 <trap+0x238>
80106867:	8b 45 08             	mov    0x8(%ebp),%eax
8010686a:	8b 40 30             	mov    0x30(%eax),%eax
8010686d:	83 f8 20             	cmp    $0x20,%eax
80106870:	75 05                	jne    80106877 <trap+0x238>
    yield();
80106872:	e8 84 e2 ff ff       	call   80104afb <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106877:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010687d:	85 c0                	test   %eax,%eax
8010687f:	74 27                	je     801068a8 <trap+0x269>
80106881:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106887:	8b 40 24             	mov    0x24(%eax),%eax
8010688a:	85 c0                	test   %eax,%eax
8010688c:	74 1a                	je     801068a8 <trap+0x269>
8010688e:	8b 45 08             	mov    0x8(%ebp),%eax
80106891:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106895:	0f b7 c0             	movzwl %ax,%eax
80106898:	83 e0 03             	and    $0x3,%eax
8010689b:	83 f8 03             	cmp    $0x3,%eax
8010689e:	75 08                	jne    801068a8 <trap+0x269>
    exit();
801068a0:	e8 a3 de ff ff       	call   80104748 <exit>
801068a5:	eb 01                	jmp    801068a8 <trap+0x269>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
801068a7:	90                   	nop
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
801068a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068ab:	5b                   	pop    %ebx
801068ac:	5e                   	pop    %esi
801068ad:	5f                   	pop    %edi
801068ae:	5d                   	pop    %ebp
801068af:	c3                   	ret    

801068b0 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801068b0:	55                   	push   %ebp
801068b1:	89 e5                	mov    %esp,%ebp
801068b3:	83 ec 14             	sub    $0x14,%esp
801068b6:	8b 45 08             	mov    0x8(%ebp),%eax
801068b9:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801068bd:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801068c1:	89 c2                	mov    %eax,%edx
801068c3:	ec                   	in     (%dx),%al
801068c4:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801068c7:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801068cb:	c9                   	leave  
801068cc:	c3                   	ret    

801068cd <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801068cd:	55                   	push   %ebp
801068ce:	89 e5                	mov    %esp,%ebp
801068d0:	83 ec 08             	sub    $0x8,%esp
801068d3:	8b 55 08             	mov    0x8(%ebp),%edx
801068d6:	8b 45 0c             	mov    0xc(%ebp),%eax
801068d9:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801068dd:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801068e0:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801068e4:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801068e8:	ee                   	out    %al,(%dx)
}
801068e9:	90                   	nop
801068ea:	c9                   	leave  
801068eb:	c3                   	ret    

801068ec <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
801068ec:	55                   	push   %ebp
801068ed:	89 e5                	mov    %esp,%ebp
801068ef:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
801068f2:	6a 00                	push   $0x0
801068f4:	68 fa 03 00 00       	push   $0x3fa
801068f9:	e8 cf ff ff ff       	call   801068cd <outb>
801068fe:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106901:	68 80 00 00 00       	push   $0x80
80106906:	68 fb 03 00 00       	push   $0x3fb
8010690b:	e8 bd ff ff ff       	call   801068cd <outb>
80106910:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80106913:	6a 0c                	push   $0xc
80106915:	68 f8 03 00 00       	push   $0x3f8
8010691a:	e8 ae ff ff ff       	call   801068cd <outb>
8010691f:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80106922:	6a 00                	push   $0x0
80106924:	68 f9 03 00 00       	push   $0x3f9
80106929:	e8 9f ff ff ff       	call   801068cd <outb>
8010692e:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106931:	6a 03                	push   $0x3
80106933:	68 fb 03 00 00       	push   $0x3fb
80106938:	e8 90 ff ff ff       	call   801068cd <outb>
8010693d:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106940:	6a 00                	push   $0x0
80106942:	68 fc 03 00 00       	push   $0x3fc
80106947:	e8 81 ff ff ff       	call   801068cd <outb>
8010694c:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
8010694f:	6a 01                	push   $0x1
80106951:	68 f9 03 00 00       	push   $0x3f9
80106956:	e8 72 ff ff ff       	call   801068cd <outb>
8010695b:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
8010695e:	68 fd 03 00 00       	push   $0x3fd
80106963:	e8 48 ff ff ff       	call   801068b0 <inb>
80106968:	83 c4 04             	add    $0x4,%esp
8010696b:	3c ff                	cmp    $0xff,%al
8010696d:	74 6e                	je     801069dd <uartinit+0xf1>
    return;
  uart = 1;
8010696f:	c7 05 90 e6 10 80 01 	movl   $0x1,0x8010e690
80106976:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106979:	68 fa 03 00 00       	push   $0x3fa
8010697e:	e8 2d ff ff ff       	call   801068b0 <inb>
80106983:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80106986:	68 f8 03 00 00       	push   $0x3f8
8010698b:	e8 20 ff ff ff       	call   801068b0 <inb>
80106990:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
80106993:	83 ec 0c             	sub    $0xc,%esp
80106996:	6a 04                	push   $0x4
80106998:	e8 2e d4 ff ff       	call   80103dcb <picenable>
8010699d:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
801069a0:	83 ec 08             	sub    $0x8,%esp
801069a3:	6a 00                	push   $0x0
801069a5:	6a 04                	push   $0x4
801069a7:	e8 c8 c1 ff ff       	call   80102b74 <ioapicenable>
801069ac:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801069af:	c7 45 f4 88 b9 10 80 	movl   $0x8010b988,-0xc(%ebp)
801069b6:	eb 19                	jmp    801069d1 <uartinit+0xe5>
    uartputc(*p);
801069b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069bb:	0f b6 00             	movzbl (%eax),%eax
801069be:	0f be c0             	movsbl %al,%eax
801069c1:	83 ec 0c             	sub    $0xc,%esp
801069c4:	50                   	push   %eax
801069c5:	e8 16 00 00 00       	call   801069e0 <uartputc>
801069ca:	83 c4 10             	add    $0x10,%esp
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801069cd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801069d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069d4:	0f b6 00             	movzbl (%eax),%eax
801069d7:	84 c0                	test   %al,%al
801069d9:	75 dd                	jne    801069b8 <uartinit+0xcc>
801069db:	eb 01                	jmp    801069de <uartinit+0xf2>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
801069dd:	90                   	nop
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
801069de:	c9                   	leave  
801069df:	c3                   	ret    

801069e0 <uartputc>:

void
uartputc(int c)
{
801069e0:	55                   	push   %ebp
801069e1:	89 e5                	mov    %esp,%ebp
801069e3:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
801069e6:	a1 90 e6 10 80       	mov    0x8010e690,%eax
801069eb:	85 c0                	test   %eax,%eax
801069ed:	74 53                	je     80106a42 <uartputc+0x62>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801069ef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801069f6:	eb 11                	jmp    80106a09 <uartputc+0x29>
    microdelay(10);
801069f8:	83 ec 0c             	sub    $0xc,%esp
801069fb:	6a 0a                	push   $0xa
801069fd:	e8 f7 c7 ff ff       	call   801031f9 <microdelay>
80106a02:	83 c4 10             	add    $0x10,%esp
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106a05:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106a09:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106a0d:	7f 1a                	jg     80106a29 <uartputc+0x49>
80106a0f:	83 ec 0c             	sub    $0xc,%esp
80106a12:	68 fd 03 00 00       	push   $0x3fd
80106a17:	e8 94 fe ff ff       	call   801068b0 <inb>
80106a1c:	83 c4 10             	add    $0x10,%esp
80106a1f:	0f b6 c0             	movzbl %al,%eax
80106a22:	83 e0 20             	and    $0x20,%eax
80106a25:	85 c0                	test   %eax,%eax
80106a27:	74 cf                	je     801069f8 <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
80106a29:	8b 45 08             	mov    0x8(%ebp),%eax
80106a2c:	0f b6 c0             	movzbl %al,%eax
80106a2f:	83 ec 08             	sub    $0x8,%esp
80106a32:	50                   	push   %eax
80106a33:	68 f8 03 00 00       	push   $0x3f8
80106a38:	e8 90 fe ff ff       	call   801068cd <outb>
80106a3d:	83 c4 10             	add    $0x10,%esp
80106a40:	eb 01                	jmp    80106a43 <uartputc+0x63>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
80106a42:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106a43:	c9                   	leave  
80106a44:	c3                   	ret    

80106a45 <uartgetc>:

static int
uartgetc(void)
{
80106a45:	55                   	push   %ebp
80106a46:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106a48:	a1 90 e6 10 80       	mov    0x8010e690,%eax
80106a4d:	85 c0                	test   %eax,%eax
80106a4f:	75 07                	jne    80106a58 <uartgetc+0x13>
    return -1;
80106a51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a56:	eb 2e                	jmp    80106a86 <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80106a58:	68 fd 03 00 00       	push   $0x3fd
80106a5d:	e8 4e fe ff ff       	call   801068b0 <inb>
80106a62:	83 c4 04             	add    $0x4,%esp
80106a65:	0f b6 c0             	movzbl %al,%eax
80106a68:	83 e0 01             	and    $0x1,%eax
80106a6b:	85 c0                	test   %eax,%eax
80106a6d:	75 07                	jne    80106a76 <uartgetc+0x31>
    return -1;
80106a6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a74:	eb 10                	jmp    80106a86 <uartgetc+0x41>
  return inb(COM1+0);
80106a76:	68 f8 03 00 00       	push   $0x3f8
80106a7b:	e8 30 fe ff ff       	call   801068b0 <inb>
80106a80:	83 c4 04             	add    $0x4,%esp
80106a83:	0f b6 c0             	movzbl %al,%eax
}
80106a86:	c9                   	leave  
80106a87:	c3                   	ret    

80106a88 <uartintr>:

void
uartintr(void)
{
80106a88:	55                   	push   %ebp
80106a89:	89 e5                	mov    %esp,%ebp
80106a8b:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80106a8e:	83 ec 0c             	sub    $0xc,%esp
80106a91:	68 45 6a 10 80       	push   $0x80106a45
80106a96:	e8 42 9d ff ff       	call   801007dd <consoleintr>
80106a9b:	83 c4 10             	add    $0x10,%esp
}
80106a9e:	90                   	nop
80106a9f:	c9                   	leave  
80106aa0:	c3                   	ret    

80106aa1 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106aa1:	6a 00                	push   $0x0
  pushl $0
80106aa3:	6a 00                	push   $0x0
  jmp alltraps
80106aa5:	e9 a1 f9 ff ff       	jmp    8010644b <alltraps>

80106aaa <vector1>:
.globl vector1
vector1:
  pushl $0
80106aaa:	6a 00                	push   $0x0
  pushl $1
80106aac:	6a 01                	push   $0x1
  jmp alltraps
80106aae:	e9 98 f9 ff ff       	jmp    8010644b <alltraps>

80106ab3 <vector2>:
.globl vector2
vector2:
  pushl $0
80106ab3:	6a 00                	push   $0x0
  pushl $2
80106ab5:	6a 02                	push   $0x2
  jmp alltraps
80106ab7:	e9 8f f9 ff ff       	jmp    8010644b <alltraps>

80106abc <vector3>:
.globl vector3
vector3:
  pushl $0
80106abc:	6a 00                	push   $0x0
  pushl $3
80106abe:	6a 03                	push   $0x3
  jmp alltraps
80106ac0:	e9 86 f9 ff ff       	jmp    8010644b <alltraps>

80106ac5 <vector4>:
.globl vector4
vector4:
  pushl $0
80106ac5:	6a 00                	push   $0x0
  pushl $4
80106ac7:	6a 04                	push   $0x4
  jmp alltraps
80106ac9:	e9 7d f9 ff ff       	jmp    8010644b <alltraps>

80106ace <vector5>:
.globl vector5
vector5:
  pushl $0
80106ace:	6a 00                	push   $0x0
  pushl $5
80106ad0:	6a 05                	push   $0x5
  jmp alltraps
80106ad2:	e9 74 f9 ff ff       	jmp    8010644b <alltraps>

80106ad7 <vector6>:
.globl vector6
vector6:
  pushl $0
80106ad7:	6a 00                	push   $0x0
  pushl $6
80106ad9:	6a 06                	push   $0x6
  jmp alltraps
80106adb:	e9 6b f9 ff ff       	jmp    8010644b <alltraps>

80106ae0 <vector7>:
.globl vector7
vector7:
  pushl $0
80106ae0:	6a 00                	push   $0x0
  pushl $7
80106ae2:	6a 07                	push   $0x7
  jmp alltraps
80106ae4:	e9 62 f9 ff ff       	jmp    8010644b <alltraps>

80106ae9 <vector8>:
.globl vector8
vector8:
  pushl $8
80106ae9:	6a 08                	push   $0x8
  jmp alltraps
80106aeb:	e9 5b f9 ff ff       	jmp    8010644b <alltraps>

80106af0 <vector9>:
.globl vector9
vector9:
  pushl $0
80106af0:	6a 00                	push   $0x0
  pushl $9
80106af2:	6a 09                	push   $0x9
  jmp alltraps
80106af4:	e9 52 f9 ff ff       	jmp    8010644b <alltraps>

80106af9 <vector10>:
.globl vector10
vector10:
  pushl $10
80106af9:	6a 0a                	push   $0xa
  jmp alltraps
80106afb:	e9 4b f9 ff ff       	jmp    8010644b <alltraps>

80106b00 <vector11>:
.globl vector11
vector11:
  pushl $11
80106b00:	6a 0b                	push   $0xb
  jmp alltraps
80106b02:	e9 44 f9 ff ff       	jmp    8010644b <alltraps>

80106b07 <vector12>:
.globl vector12
vector12:
  pushl $12
80106b07:	6a 0c                	push   $0xc
  jmp alltraps
80106b09:	e9 3d f9 ff ff       	jmp    8010644b <alltraps>

80106b0e <vector13>:
.globl vector13
vector13:
  pushl $13
80106b0e:	6a 0d                	push   $0xd
  jmp alltraps
80106b10:	e9 36 f9 ff ff       	jmp    8010644b <alltraps>

80106b15 <vector14>:
.globl vector14
vector14:
  pushl $14
80106b15:	6a 0e                	push   $0xe
  jmp alltraps
80106b17:	e9 2f f9 ff ff       	jmp    8010644b <alltraps>

80106b1c <vector15>:
.globl vector15
vector15:
  pushl $0
80106b1c:	6a 00                	push   $0x0
  pushl $15
80106b1e:	6a 0f                	push   $0xf
  jmp alltraps
80106b20:	e9 26 f9 ff ff       	jmp    8010644b <alltraps>

80106b25 <vector16>:
.globl vector16
vector16:
  pushl $0
80106b25:	6a 00                	push   $0x0
  pushl $16
80106b27:	6a 10                	push   $0x10
  jmp alltraps
80106b29:	e9 1d f9 ff ff       	jmp    8010644b <alltraps>

80106b2e <vector17>:
.globl vector17
vector17:
  pushl $17
80106b2e:	6a 11                	push   $0x11
  jmp alltraps
80106b30:	e9 16 f9 ff ff       	jmp    8010644b <alltraps>

80106b35 <vector18>:
.globl vector18
vector18:
  pushl $0
80106b35:	6a 00                	push   $0x0
  pushl $18
80106b37:	6a 12                	push   $0x12
  jmp alltraps
80106b39:	e9 0d f9 ff ff       	jmp    8010644b <alltraps>

80106b3e <vector19>:
.globl vector19
vector19:
  pushl $0
80106b3e:	6a 00                	push   $0x0
  pushl $19
80106b40:	6a 13                	push   $0x13
  jmp alltraps
80106b42:	e9 04 f9 ff ff       	jmp    8010644b <alltraps>

80106b47 <vector20>:
.globl vector20
vector20:
  pushl $0
80106b47:	6a 00                	push   $0x0
  pushl $20
80106b49:	6a 14                	push   $0x14
  jmp alltraps
80106b4b:	e9 fb f8 ff ff       	jmp    8010644b <alltraps>

80106b50 <vector21>:
.globl vector21
vector21:
  pushl $0
80106b50:	6a 00                	push   $0x0
  pushl $21
80106b52:	6a 15                	push   $0x15
  jmp alltraps
80106b54:	e9 f2 f8 ff ff       	jmp    8010644b <alltraps>

80106b59 <vector22>:
.globl vector22
vector22:
  pushl $0
80106b59:	6a 00                	push   $0x0
  pushl $22
80106b5b:	6a 16                	push   $0x16
  jmp alltraps
80106b5d:	e9 e9 f8 ff ff       	jmp    8010644b <alltraps>

80106b62 <vector23>:
.globl vector23
vector23:
  pushl $0
80106b62:	6a 00                	push   $0x0
  pushl $23
80106b64:	6a 17                	push   $0x17
  jmp alltraps
80106b66:	e9 e0 f8 ff ff       	jmp    8010644b <alltraps>

80106b6b <vector24>:
.globl vector24
vector24:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $24
80106b6d:	6a 18                	push   $0x18
  jmp alltraps
80106b6f:	e9 d7 f8 ff ff       	jmp    8010644b <alltraps>

80106b74 <vector25>:
.globl vector25
vector25:
  pushl $0
80106b74:	6a 00                	push   $0x0
  pushl $25
80106b76:	6a 19                	push   $0x19
  jmp alltraps
80106b78:	e9 ce f8 ff ff       	jmp    8010644b <alltraps>

80106b7d <vector26>:
.globl vector26
vector26:
  pushl $0
80106b7d:	6a 00                	push   $0x0
  pushl $26
80106b7f:	6a 1a                	push   $0x1a
  jmp alltraps
80106b81:	e9 c5 f8 ff ff       	jmp    8010644b <alltraps>

80106b86 <vector27>:
.globl vector27
vector27:
  pushl $0
80106b86:	6a 00                	push   $0x0
  pushl $27
80106b88:	6a 1b                	push   $0x1b
  jmp alltraps
80106b8a:	e9 bc f8 ff ff       	jmp    8010644b <alltraps>

80106b8f <vector28>:
.globl vector28
vector28:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $28
80106b91:	6a 1c                	push   $0x1c
  jmp alltraps
80106b93:	e9 b3 f8 ff ff       	jmp    8010644b <alltraps>

80106b98 <vector29>:
.globl vector29
vector29:
  pushl $0
80106b98:	6a 00                	push   $0x0
  pushl $29
80106b9a:	6a 1d                	push   $0x1d
  jmp alltraps
80106b9c:	e9 aa f8 ff ff       	jmp    8010644b <alltraps>

80106ba1 <vector30>:
.globl vector30
vector30:
  pushl $0
80106ba1:	6a 00                	push   $0x0
  pushl $30
80106ba3:	6a 1e                	push   $0x1e
  jmp alltraps
80106ba5:	e9 a1 f8 ff ff       	jmp    8010644b <alltraps>

80106baa <vector31>:
.globl vector31
vector31:
  pushl $0
80106baa:	6a 00                	push   $0x0
  pushl $31
80106bac:	6a 1f                	push   $0x1f
  jmp alltraps
80106bae:	e9 98 f8 ff ff       	jmp    8010644b <alltraps>

80106bb3 <vector32>:
.globl vector32
vector32:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $32
80106bb5:	6a 20                	push   $0x20
  jmp alltraps
80106bb7:	e9 8f f8 ff ff       	jmp    8010644b <alltraps>

80106bbc <vector33>:
.globl vector33
vector33:
  pushl $0
80106bbc:	6a 00                	push   $0x0
  pushl $33
80106bbe:	6a 21                	push   $0x21
  jmp alltraps
80106bc0:	e9 86 f8 ff ff       	jmp    8010644b <alltraps>

80106bc5 <vector34>:
.globl vector34
vector34:
  pushl $0
80106bc5:	6a 00                	push   $0x0
  pushl $34
80106bc7:	6a 22                	push   $0x22
  jmp alltraps
80106bc9:	e9 7d f8 ff ff       	jmp    8010644b <alltraps>

80106bce <vector35>:
.globl vector35
vector35:
  pushl $0
80106bce:	6a 00                	push   $0x0
  pushl $35
80106bd0:	6a 23                	push   $0x23
  jmp alltraps
80106bd2:	e9 74 f8 ff ff       	jmp    8010644b <alltraps>

80106bd7 <vector36>:
.globl vector36
vector36:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $36
80106bd9:	6a 24                	push   $0x24
  jmp alltraps
80106bdb:	e9 6b f8 ff ff       	jmp    8010644b <alltraps>

80106be0 <vector37>:
.globl vector37
vector37:
  pushl $0
80106be0:	6a 00                	push   $0x0
  pushl $37
80106be2:	6a 25                	push   $0x25
  jmp alltraps
80106be4:	e9 62 f8 ff ff       	jmp    8010644b <alltraps>

80106be9 <vector38>:
.globl vector38
vector38:
  pushl $0
80106be9:	6a 00                	push   $0x0
  pushl $38
80106beb:	6a 26                	push   $0x26
  jmp alltraps
80106bed:	e9 59 f8 ff ff       	jmp    8010644b <alltraps>

80106bf2 <vector39>:
.globl vector39
vector39:
  pushl $0
80106bf2:	6a 00                	push   $0x0
  pushl $39
80106bf4:	6a 27                	push   $0x27
  jmp alltraps
80106bf6:	e9 50 f8 ff ff       	jmp    8010644b <alltraps>

80106bfb <vector40>:
.globl vector40
vector40:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $40
80106bfd:	6a 28                	push   $0x28
  jmp alltraps
80106bff:	e9 47 f8 ff ff       	jmp    8010644b <alltraps>

80106c04 <vector41>:
.globl vector41
vector41:
  pushl $0
80106c04:	6a 00                	push   $0x0
  pushl $41
80106c06:	6a 29                	push   $0x29
  jmp alltraps
80106c08:	e9 3e f8 ff ff       	jmp    8010644b <alltraps>

80106c0d <vector42>:
.globl vector42
vector42:
  pushl $0
80106c0d:	6a 00                	push   $0x0
  pushl $42
80106c0f:	6a 2a                	push   $0x2a
  jmp alltraps
80106c11:	e9 35 f8 ff ff       	jmp    8010644b <alltraps>

80106c16 <vector43>:
.globl vector43
vector43:
  pushl $0
80106c16:	6a 00                	push   $0x0
  pushl $43
80106c18:	6a 2b                	push   $0x2b
  jmp alltraps
80106c1a:	e9 2c f8 ff ff       	jmp    8010644b <alltraps>

80106c1f <vector44>:
.globl vector44
vector44:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $44
80106c21:	6a 2c                	push   $0x2c
  jmp alltraps
80106c23:	e9 23 f8 ff ff       	jmp    8010644b <alltraps>

80106c28 <vector45>:
.globl vector45
vector45:
  pushl $0
80106c28:	6a 00                	push   $0x0
  pushl $45
80106c2a:	6a 2d                	push   $0x2d
  jmp alltraps
80106c2c:	e9 1a f8 ff ff       	jmp    8010644b <alltraps>

80106c31 <vector46>:
.globl vector46
vector46:
  pushl $0
80106c31:	6a 00                	push   $0x0
  pushl $46
80106c33:	6a 2e                	push   $0x2e
  jmp alltraps
80106c35:	e9 11 f8 ff ff       	jmp    8010644b <alltraps>

80106c3a <vector47>:
.globl vector47
vector47:
  pushl $0
80106c3a:	6a 00                	push   $0x0
  pushl $47
80106c3c:	6a 2f                	push   $0x2f
  jmp alltraps
80106c3e:	e9 08 f8 ff ff       	jmp    8010644b <alltraps>

80106c43 <vector48>:
.globl vector48
vector48:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $48
80106c45:	6a 30                	push   $0x30
  jmp alltraps
80106c47:	e9 ff f7 ff ff       	jmp    8010644b <alltraps>

80106c4c <vector49>:
.globl vector49
vector49:
  pushl $0
80106c4c:	6a 00                	push   $0x0
  pushl $49
80106c4e:	6a 31                	push   $0x31
  jmp alltraps
80106c50:	e9 f6 f7 ff ff       	jmp    8010644b <alltraps>

80106c55 <vector50>:
.globl vector50
vector50:
  pushl $0
80106c55:	6a 00                	push   $0x0
  pushl $50
80106c57:	6a 32                	push   $0x32
  jmp alltraps
80106c59:	e9 ed f7 ff ff       	jmp    8010644b <alltraps>

80106c5e <vector51>:
.globl vector51
vector51:
  pushl $0
80106c5e:	6a 00                	push   $0x0
  pushl $51
80106c60:	6a 33                	push   $0x33
  jmp alltraps
80106c62:	e9 e4 f7 ff ff       	jmp    8010644b <alltraps>

80106c67 <vector52>:
.globl vector52
vector52:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $52
80106c69:	6a 34                	push   $0x34
  jmp alltraps
80106c6b:	e9 db f7 ff ff       	jmp    8010644b <alltraps>

80106c70 <vector53>:
.globl vector53
vector53:
  pushl $0
80106c70:	6a 00                	push   $0x0
  pushl $53
80106c72:	6a 35                	push   $0x35
  jmp alltraps
80106c74:	e9 d2 f7 ff ff       	jmp    8010644b <alltraps>

80106c79 <vector54>:
.globl vector54
vector54:
  pushl $0
80106c79:	6a 00                	push   $0x0
  pushl $54
80106c7b:	6a 36                	push   $0x36
  jmp alltraps
80106c7d:	e9 c9 f7 ff ff       	jmp    8010644b <alltraps>

80106c82 <vector55>:
.globl vector55
vector55:
  pushl $0
80106c82:	6a 00                	push   $0x0
  pushl $55
80106c84:	6a 37                	push   $0x37
  jmp alltraps
80106c86:	e9 c0 f7 ff ff       	jmp    8010644b <alltraps>

80106c8b <vector56>:
.globl vector56
vector56:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $56
80106c8d:	6a 38                	push   $0x38
  jmp alltraps
80106c8f:	e9 b7 f7 ff ff       	jmp    8010644b <alltraps>

80106c94 <vector57>:
.globl vector57
vector57:
  pushl $0
80106c94:	6a 00                	push   $0x0
  pushl $57
80106c96:	6a 39                	push   $0x39
  jmp alltraps
80106c98:	e9 ae f7 ff ff       	jmp    8010644b <alltraps>

80106c9d <vector58>:
.globl vector58
vector58:
  pushl $0
80106c9d:	6a 00                	push   $0x0
  pushl $58
80106c9f:	6a 3a                	push   $0x3a
  jmp alltraps
80106ca1:	e9 a5 f7 ff ff       	jmp    8010644b <alltraps>

80106ca6 <vector59>:
.globl vector59
vector59:
  pushl $0
80106ca6:	6a 00                	push   $0x0
  pushl $59
80106ca8:	6a 3b                	push   $0x3b
  jmp alltraps
80106caa:	e9 9c f7 ff ff       	jmp    8010644b <alltraps>

80106caf <vector60>:
.globl vector60
vector60:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $60
80106cb1:	6a 3c                	push   $0x3c
  jmp alltraps
80106cb3:	e9 93 f7 ff ff       	jmp    8010644b <alltraps>

80106cb8 <vector61>:
.globl vector61
vector61:
  pushl $0
80106cb8:	6a 00                	push   $0x0
  pushl $61
80106cba:	6a 3d                	push   $0x3d
  jmp alltraps
80106cbc:	e9 8a f7 ff ff       	jmp    8010644b <alltraps>

80106cc1 <vector62>:
.globl vector62
vector62:
  pushl $0
80106cc1:	6a 00                	push   $0x0
  pushl $62
80106cc3:	6a 3e                	push   $0x3e
  jmp alltraps
80106cc5:	e9 81 f7 ff ff       	jmp    8010644b <alltraps>

80106cca <vector63>:
.globl vector63
vector63:
  pushl $0
80106cca:	6a 00                	push   $0x0
  pushl $63
80106ccc:	6a 3f                	push   $0x3f
  jmp alltraps
80106cce:	e9 78 f7 ff ff       	jmp    8010644b <alltraps>

80106cd3 <vector64>:
.globl vector64
vector64:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $64
80106cd5:	6a 40                	push   $0x40
  jmp alltraps
80106cd7:	e9 6f f7 ff ff       	jmp    8010644b <alltraps>

80106cdc <vector65>:
.globl vector65
vector65:
  pushl $0
80106cdc:	6a 00                	push   $0x0
  pushl $65
80106cde:	6a 41                	push   $0x41
  jmp alltraps
80106ce0:	e9 66 f7 ff ff       	jmp    8010644b <alltraps>

80106ce5 <vector66>:
.globl vector66
vector66:
  pushl $0
80106ce5:	6a 00                	push   $0x0
  pushl $66
80106ce7:	6a 42                	push   $0x42
  jmp alltraps
80106ce9:	e9 5d f7 ff ff       	jmp    8010644b <alltraps>

80106cee <vector67>:
.globl vector67
vector67:
  pushl $0
80106cee:	6a 00                	push   $0x0
  pushl $67
80106cf0:	6a 43                	push   $0x43
  jmp alltraps
80106cf2:	e9 54 f7 ff ff       	jmp    8010644b <alltraps>

80106cf7 <vector68>:
.globl vector68
vector68:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $68
80106cf9:	6a 44                	push   $0x44
  jmp alltraps
80106cfb:	e9 4b f7 ff ff       	jmp    8010644b <alltraps>

80106d00 <vector69>:
.globl vector69
vector69:
  pushl $0
80106d00:	6a 00                	push   $0x0
  pushl $69
80106d02:	6a 45                	push   $0x45
  jmp alltraps
80106d04:	e9 42 f7 ff ff       	jmp    8010644b <alltraps>

80106d09 <vector70>:
.globl vector70
vector70:
  pushl $0
80106d09:	6a 00                	push   $0x0
  pushl $70
80106d0b:	6a 46                	push   $0x46
  jmp alltraps
80106d0d:	e9 39 f7 ff ff       	jmp    8010644b <alltraps>

80106d12 <vector71>:
.globl vector71
vector71:
  pushl $0
80106d12:	6a 00                	push   $0x0
  pushl $71
80106d14:	6a 47                	push   $0x47
  jmp alltraps
80106d16:	e9 30 f7 ff ff       	jmp    8010644b <alltraps>

80106d1b <vector72>:
.globl vector72
vector72:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $72
80106d1d:	6a 48                	push   $0x48
  jmp alltraps
80106d1f:	e9 27 f7 ff ff       	jmp    8010644b <alltraps>

80106d24 <vector73>:
.globl vector73
vector73:
  pushl $0
80106d24:	6a 00                	push   $0x0
  pushl $73
80106d26:	6a 49                	push   $0x49
  jmp alltraps
80106d28:	e9 1e f7 ff ff       	jmp    8010644b <alltraps>

80106d2d <vector74>:
.globl vector74
vector74:
  pushl $0
80106d2d:	6a 00                	push   $0x0
  pushl $74
80106d2f:	6a 4a                	push   $0x4a
  jmp alltraps
80106d31:	e9 15 f7 ff ff       	jmp    8010644b <alltraps>

80106d36 <vector75>:
.globl vector75
vector75:
  pushl $0
80106d36:	6a 00                	push   $0x0
  pushl $75
80106d38:	6a 4b                	push   $0x4b
  jmp alltraps
80106d3a:	e9 0c f7 ff ff       	jmp    8010644b <alltraps>

80106d3f <vector76>:
.globl vector76
vector76:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $76
80106d41:	6a 4c                	push   $0x4c
  jmp alltraps
80106d43:	e9 03 f7 ff ff       	jmp    8010644b <alltraps>

80106d48 <vector77>:
.globl vector77
vector77:
  pushl $0
80106d48:	6a 00                	push   $0x0
  pushl $77
80106d4a:	6a 4d                	push   $0x4d
  jmp alltraps
80106d4c:	e9 fa f6 ff ff       	jmp    8010644b <alltraps>

80106d51 <vector78>:
.globl vector78
vector78:
  pushl $0
80106d51:	6a 00                	push   $0x0
  pushl $78
80106d53:	6a 4e                	push   $0x4e
  jmp alltraps
80106d55:	e9 f1 f6 ff ff       	jmp    8010644b <alltraps>

80106d5a <vector79>:
.globl vector79
vector79:
  pushl $0
80106d5a:	6a 00                	push   $0x0
  pushl $79
80106d5c:	6a 4f                	push   $0x4f
  jmp alltraps
80106d5e:	e9 e8 f6 ff ff       	jmp    8010644b <alltraps>

80106d63 <vector80>:
.globl vector80
vector80:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $80
80106d65:	6a 50                	push   $0x50
  jmp alltraps
80106d67:	e9 df f6 ff ff       	jmp    8010644b <alltraps>

80106d6c <vector81>:
.globl vector81
vector81:
  pushl $0
80106d6c:	6a 00                	push   $0x0
  pushl $81
80106d6e:	6a 51                	push   $0x51
  jmp alltraps
80106d70:	e9 d6 f6 ff ff       	jmp    8010644b <alltraps>

80106d75 <vector82>:
.globl vector82
vector82:
  pushl $0
80106d75:	6a 00                	push   $0x0
  pushl $82
80106d77:	6a 52                	push   $0x52
  jmp alltraps
80106d79:	e9 cd f6 ff ff       	jmp    8010644b <alltraps>

80106d7e <vector83>:
.globl vector83
vector83:
  pushl $0
80106d7e:	6a 00                	push   $0x0
  pushl $83
80106d80:	6a 53                	push   $0x53
  jmp alltraps
80106d82:	e9 c4 f6 ff ff       	jmp    8010644b <alltraps>

80106d87 <vector84>:
.globl vector84
vector84:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $84
80106d89:	6a 54                	push   $0x54
  jmp alltraps
80106d8b:	e9 bb f6 ff ff       	jmp    8010644b <alltraps>

80106d90 <vector85>:
.globl vector85
vector85:
  pushl $0
80106d90:	6a 00                	push   $0x0
  pushl $85
80106d92:	6a 55                	push   $0x55
  jmp alltraps
80106d94:	e9 b2 f6 ff ff       	jmp    8010644b <alltraps>

80106d99 <vector86>:
.globl vector86
vector86:
  pushl $0
80106d99:	6a 00                	push   $0x0
  pushl $86
80106d9b:	6a 56                	push   $0x56
  jmp alltraps
80106d9d:	e9 a9 f6 ff ff       	jmp    8010644b <alltraps>

80106da2 <vector87>:
.globl vector87
vector87:
  pushl $0
80106da2:	6a 00                	push   $0x0
  pushl $87
80106da4:	6a 57                	push   $0x57
  jmp alltraps
80106da6:	e9 a0 f6 ff ff       	jmp    8010644b <alltraps>

80106dab <vector88>:
.globl vector88
vector88:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $88
80106dad:	6a 58                	push   $0x58
  jmp alltraps
80106daf:	e9 97 f6 ff ff       	jmp    8010644b <alltraps>

80106db4 <vector89>:
.globl vector89
vector89:
  pushl $0
80106db4:	6a 00                	push   $0x0
  pushl $89
80106db6:	6a 59                	push   $0x59
  jmp alltraps
80106db8:	e9 8e f6 ff ff       	jmp    8010644b <alltraps>

80106dbd <vector90>:
.globl vector90
vector90:
  pushl $0
80106dbd:	6a 00                	push   $0x0
  pushl $90
80106dbf:	6a 5a                	push   $0x5a
  jmp alltraps
80106dc1:	e9 85 f6 ff ff       	jmp    8010644b <alltraps>

80106dc6 <vector91>:
.globl vector91
vector91:
  pushl $0
80106dc6:	6a 00                	push   $0x0
  pushl $91
80106dc8:	6a 5b                	push   $0x5b
  jmp alltraps
80106dca:	e9 7c f6 ff ff       	jmp    8010644b <alltraps>

80106dcf <vector92>:
.globl vector92
vector92:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $92
80106dd1:	6a 5c                	push   $0x5c
  jmp alltraps
80106dd3:	e9 73 f6 ff ff       	jmp    8010644b <alltraps>

80106dd8 <vector93>:
.globl vector93
vector93:
  pushl $0
80106dd8:	6a 00                	push   $0x0
  pushl $93
80106dda:	6a 5d                	push   $0x5d
  jmp alltraps
80106ddc:	e9 6a f6 ff ff       	jmp    8010644b <alltraps>

80106de1 <vector94>:
.globl vector94
vector94:
  pushl $0
80106de1:	6a 00                	push   $0x0
  pushl $94
80106de3:	6a 5e                	push   $0x5e
  jmp alltraps
80106de5:	e9 61 f6 ff ff       	jmp    8010644b <alltraps>

80106dea <vector95>:
.globl vector95
vector95:
  pushl $0
80106dea:	6a 00                	push   $0x0
  pushl $95
80106dec:	6a 5f                	push   $0x5f
  jmp alltraps
80106dee:	e9 58 f6 ff ff       	jmp    8010644b <alltraps>

80106df3 <vector96>:
.globl vector96
vector96:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $96
80106df5:	6a 60                	push   $0x60
  jmp alltraps
80106df7:	e9 4f f6 ff ff       	jmp    8010644b <alltraps>

80106dfc <vector97>:
.globl vector97
vector97:
  pushl $0
80106dfc:	6a 00                	push   $0x0
  pushl $97
80106dfe:	6a 61                	push   $0x61
  jmp alltraps
80106e00:	e9 46 f6 ff ff       	jmp    8010644b <alltraps>

80106e05 <vector98>:
.globl vector98
vector98:
  pushl $0
80106e05:	6a 00                	push   $0x0
  pushl $98
80106e07:	6a 62                	push   $0x62
  jmp alltraps
80106e09:	e9 3d f6 ff ff       	jmp    8010644b <alltraps>

80106e0e <vector99>:
.globl vector99
vector99:
  pushl $0
80106e0e:	6a 00                	push   $0x0
  pushl $99
80106e10:	6a 63                	push   $0x63
  jmp alltraps
80106e12:	e9 34 f6 ff ff       	jmp    8010644b <alltraps>

80106e17 <vector100>:
.globl vector100
vector100:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $100
80106e19:	6a 64                	push   $0x64
  jmp alltraps
80106e1b:	e9 2b f6 ff ff       	jmp    8010644b <alltraps>

80106e20 <vector101>:
.globl vector101
vector101:
  pushl $0
80106e20:	6a 00                	push   $0x0
  pushl $101
80106e22:	6a 65                	push   $0x65
  jmp alltraps
80106e24:	e9 22 f6 ff ff       	jmp    8010644b <alltraps>

80106e29 <vector102>:
.globl vector102
vector102:
  pushl $0
80106e29:	6a 00                	push   $0x0
  pushl $102
80106e2b:	6a 66                	push   $0x66
  jmp alltraps
80106e2d:	e9 19 f6 ff ff       	jmp    8010644b <alltraps>

80106e32 <vector103>:
.globl vector103
vector103:
  pushl $0
80106e32:	6a 00                	push   $0x0
  pushl $103
80106e34:	6a 67                	push   $0x67
  jmp alltraps
80106e36:	e9 10 f6 ff ff       	jmp    8010644b <alltraps>

80106e3b <vector104>:
.globl vector104
vector104:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $104
80106e3d:	6a 68                	push   $0x68
  jmp alltraps
80106e3f:	e9 07 f6 ff ff       	jmp    8010644b <alltraps>

80106e44 <vector105>:
.globl vector105
vector105:
  pushl $0
80106e44:	6a 00                	push   $0x0
  pushl $105
80106e46:	6a 69                	push   $0x69
  jmp alltraps
80106e48:	e9 fe f5 ff ff       	jmp    8010644b <alltraps>

80106e4d <vector106>:
.globl vector106
vector106:
  pushl $0
80106e4d:	6a 00                	push   $0x0
  pushl $106
80106e4f:	6a 6a                	push   $0x6a
  jmp alltraps
80106e51:	e9 f5 f5 ff ff       	jmp    8010644b <alltraps>

80106e56 <vector107>:
.globl vector107
vector107:
  pushl $0
80106e56:	6a 00                	push   $0x0
  pushl $107
80106e58:	6a 6b                	push   $0x6b
  jmp alltraps
80106e5a:	e9 ec f5 ff ff       	jmp    8010644b <alltraps>

80106e5f <vector108>:
.globl vector108
vector108:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $108
80106e61:	6a 6c                	push   $0x6c
  jmp alltraps
80106e63:	e9 e3 f5 ff ff       	jmp    8010644b <alltraps>

80106e68 <vector109>:
.globl vector109
vector109:
  pushl $0
80106e68:	6a 00                	push   $0x0
  pushl $109
80106e6a:	6a 6d                	push   $0x6d
  jmp alltraps
80106e6c:	e9 da f5 ff ff       	jmp    8010644b <alltraps>

80106e71 <vector110>:
.globl vector110
vector110:
  pushl $0
80106e71:	6a 00                	push   $0x0
  pushl $110
80106e73:	6a 6e                	push   $0x6e
  jmp alltraps
80106e75:	e9 d1 f5 ff ff       	jmp    8010644b <alltraps>

80106e7a <vector111>:
.globl vector111
vector111:
  pushl $0
80106e7a:	6a 00                	push   $0x0
  pushl $111
80106e7c:	6a 6f                	push   $0x6f
  jmp alltraps
80106e7e:	e9 c8 f5 ff ff       	jmp    8010644b <alltraps>

80106e83 <vector112>:
.globl vector112
vector112:
  pushl $0
80106e83:	6a 00                	push   $0x0
  pushl $112
80106e85:	6a 70                	push   $0x70
  jmp alltraps
80106e87:	e9 bf f5 ff ff       	jmp    8010644b <alltraps>

80106e8c <vector113>:
.globl vector113
vector113:
  pushl $0
80106e8c:	6a 00                	push   $0x0
  pushl $113
80106e8e:	6a 71                	push   $0x71
  jmp alltraps
80106e90:	e9 b6 f5 ff ff       	jmp    8010644b <alltraps>

80106e95 <vector114>:
.globl vector114
vector114:
  pushl $0
80106e95:	6a 00                	push   $0x0
  pushl $114
80106e97:	6a 72                	push   $0x72
  jmp alltraps
80106e99:	e9 ad f5 ff ff       	jmp    8010644b <alltraps>

80106e9e <vector115>:
.globl vector115
vector115:
  pushl $0
80106e9e:	6a 00                	push   $0x0
  pushl $115
80106ea0:	6a 73                	push   $0x73
  jmp alltraps
80106ea2:	e9 a4 f5 ff ff       	jmp    8010644b <alltraps>

80106ea7 <vector116>:
.globl vector116
vector116:
  pushl $0
80106ea7:	6a 00                	push   $0x0
  pushl $116
80106ea9:	6a 74                	push   $0x74
  jmp alltraps
80106eab:	e9 9b f5 ff ff       	jmp    8010644b <alltraps>

80106eb0 <vector117>:
.globl vector117
vector117:
  pushl $0
80106eb0:	6a 00                	push   $0x0
  pushl $117
80106eb2:	6a 75                	push   $0x75
  jmp alltraps
80106eb4:	e9 92 f5 ff ff       	jmp    8010644b <alltraps>

80106eb9 <vector118>:
.globl vector118
vector118:
  pushl $0
80106eb9:	6a 00                	push   $0x0
  pushl $118
80106ebb:	6a 76                	push   $0x76
  jmp alltraps
80106ebd:	e9 89 f5 ff ff       	jmp    8010644b <alltraps>

80106ec2 <vector119>:
.globl vector119
vector119:
  pushl $0
80106ec2:	6a 00                	push   $0x0
  pushl $119
80106ec4:	6a 77                	push   $0x77
  jmp alltraps
80106ec6:	e9 80 f5 ff ff       	jmp    8010644b <alltraps>

80106ecb <vector120>:
.globl vector120
vector120:
  pushl $0
80106ecb:	6a 00                	push   $0x0
  pushl $120
80106ecd:	6a 78                	push   $0x78
  jmp alltraps
80106ecf:	e9 77 f5 ff ff       	jmp    8010644b <alltraps>

80106ed4 <vector121>:
.globl vector121
vector121:
  pushl $0
80106ed4:	6a 00                	push   $0x0
  pushl $121
80106ed6:	6a 79                	push   $0x79
  jmp alltraps
80106ed8:	e9 6e f5 ff ff       	jmp    8010644b <alltraps>

80106edd <vector122>:
.globl vector122
vector122:
  pushl $0
80106edd:	6a 00                	push   $0x0
  pushl $122
80106edf:	6a 7a                	push   $0x7a
  jmp alltraps
80106ee1:	e9 65 f5 ff ff       	jmp    8010644b <alltraps>

80106ee6 <vector123>:
.globl vector123
vector123:
  pushl $0
80106ee6:	6a 00                	push   $0x0
  pushl $123
80106ee8:	6a 7b                	push   $0x7b
  jmp alltraps
80106eea:	e9 5c f5 ff ff       	jmp    8010644b <alltraps>

80106eef <vector124>:
.globl vector124
vector124:
  pushl $0
80106eef:	6a 00                	push   $0x0
  pushl $124
80106ef1:	6a 7c                	push   $0x7c
  jmp alltraps
80106ef3:	e9 53 f5 ff ff       	jmp    8010644b <alltraps>

80106ef8 <vector125>:
.globl vector125
vector125:
  pushl $0
80106ef8:	6a 00                	push   $0x0
  pushl $125
80106efa:	6a 7d                	push   $0x7d
  jmp alltraps
80106efc:	e9 4a f5 ff ff       	jmp    8010644b <alltraps>

80106f01 <vector126>:
.globl vector126
vector126:
  pushl $0
80106f01:	6a 00                	push   $0x0
  pushl $126
80106f03:	6a 7e                	push   $0x7e
  jmp alltraps
80106f05:	e9 41 f5 ff ff       	jmp    8010644b <alltraps>

80106f0a <vector127>:
.globl vector127
vector127:
  pushl $0
80106f0a:	6a 00                	push   $0x0
  pushl $127
80106f0c:	6a 7f                	push   $0x7f
  jmp alltraps
80106f0e:	e9 38 f5 ff ff       	jmp    8010644b <alltraps>

80106f13 <vector128>:
.globl vector128
vector128:
  pushl $0
80106f13:	6a 00                	push   $0x0
  pushl $128
80106f15:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106f1a:	e9 2c f5 ff ff       	jmp    8010644b <alltraps>

80106f1f <vector129>:
.globl vector129
vector129:
  pushl $0
80106f1f:	6a 00                	push   $0x0
  pushl $129
80106f21:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106f26:	e9 20 f5 ff ff       	jmp    8010644b <alltraps>

80106f2b <vector130>:
.globl vector130
vector130:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $130
80106f2d:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106f32:	e9 14 f5 ff ff       	jmp    8010644b <alltraps>

80106f37 <vector131>:
.globl vector131
vector131:
  pushl $0
80106f37:	6a 00                	push   $0x0
  pushl $131
80106f39:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106f3e:	e9 08 f5 ff ff       	jmp    8010644b <alltraps>

80106f43 <vector132>:
.globl vector132
vector132:
  pushl $0
80106f43:	6a 00                	push   $0x0
  pushl $132
80106f45:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106f4a:	e9 fc f4 ff ff       	jmp    8010644b <alltraps>

80106f4f <vector133>:
.globl vector133
vector133:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $133
80106f51:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106f56:	e9 f0 f4 ff ff       	jmp    8010644b <alltraps>

80106f5b <vector134>:
.globl vector134
vector134:
  pushl $0
80106f5b:	6a 00                	push   $0x0
  pushl $134
80106f5d:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106f62:	e9 e4 f4 ff ff       	jmp    8010644b <alltraps>

80106f67 <vector135>:
.globl vector135
vector135:
  pushl $0
80106f67:	6a 00                	push   $0x0
  pushl $135
80106f69:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106f6e:	e9 d8 f4 ff ff       	jmp    8010644b <alltraps>

80106f73 <vector136>:
.globl vector136
vector136:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $136
80106f75:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106f7a:	e9 cc f4 ff ff       	jmp    8010644b <alltraps>

80106f7f <vector137>:
.globl vector137
vector137:
  pushl $0
80106f7f:	6a 00                	push   $0x0
  pushl $137
80106f81:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106f86:	e9 c0 f4 ff ff       	jmp    8010644b <alltraps>

80106f8b <vector138>:
.globl vector138
vector138:
  pushl $0
80106f8b:	6a 00                	push   $0x0
  pushl $138
80106f8d:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106f92:	e9 b4 f4 ff ff       	jmp    8010644b <alltraps>

80106f97 <vector139>:
.globl vector139
vector139:
  pushl $0
80106f97:	6a 00                	push   $0x0
  pushl $139
80106f99:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106f9e:	e9 a8 f4 ff ff       	jmp    8010644b <alltraps>

80106fa3 <vector140>:
.globl vector140
vector140:
  pushl $0
80106fa3:	6a 00                	push   $0x0
  pushl $140
80106fa5:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106faa:	e9 9c f4 ff ff       	jmp    8010644b <alltraps>

80106faf <vector141>:
.globl vector141
vector141:
  pushl $0
80106faf:	6a 00                	push   $0x0
  pushl $141
80106fb1:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106fb6:	e9 90 f4 ff ff       	jmp    8010644b <alltraps>

80106fbb <vector142>:
.globl vector142
vector142:
  pushl $0
80106fbb:	6a 00                	push   $0x0
  pushl $142
80106fbd:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106fc2:	e9 84 f4 ff ff       	jmp    8010644b <alltraps>

80106fc7 <vector143>:
.globl vector143
vector143:
  pushl $0
80106fc7:	6a 00                	push   $0x0
  pushl $143
80106fc9:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106fce:	e9 78 f4 ff ff       	jmp    8010644b <alltraps>

80106fd3 <vector144>:
.globl vector144
vector144:
  pushl $0
80106fd3:	6a 00                	push   $0x0
  pushl $144
80106fd5:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106fda:	e9 6c f4 ff ff       	jmp    8010644b <alltraps>

80106fdf <vector145>:
.globl vector145
vector145:
  pushl $0
80106fdf:	6a 00                	push   $0x0
  pushl $145
80106fe1:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106fe6:	e9 60 f4 ff ff       	jmp    8010644b <alltraps>

80106feb <vector146>:
.globl vector146
vector146:
  pushl $0
80106feb:	6a 00                	push   $0x0
  pushl $146
80106fed:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106ff2:	e9 54 f4 ff ff       	jmp    8010644b <alltraps>

80106ff7 <vector147>:
.globl vector147
vector147:
  pushl $0
80106ff7:	6a 00                	push   $0x0
  pushl $147
80106ff9:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106ffe:	e9 48 f4 ff ff       	jmp    8010644b <alltraps>

80107003 <vector148>:
.globl vector148
vector148:
  pushl $0
80107003:	6a 00                	push   $0x0
  pushl $148
80107005:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010700a:	e9 3c f4 ff ff       	jmp    8010644b <alltraps>

8010700f <vector149>:
.globl vector149
vector149:
  pushl $0
8010700f:	6a 00                	push   $0x0
  pushl $149
80107011:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107016:	e9 30 f4 ff ff       	jmp    8010644b <alltraps>

8010701b <vector150>:
.globl vector150
vector150:
  pushl $0
8010701b:	6a 00                	push   $0x0
  pushl $150
8010701d:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107022:	e9 24 f4 ff ff       	jmp    8010644b <alltraps>

80107027 <vector151>:
.globl vector151
vector151:
  pushl $0
80107027:	6a 00                	push   $0x0
  pushl $151
80107029:	68 97 00 00 00       	push   $0x97
  jmp alltraps
8010702e:	e9 18 f4 ff ff       	jmp    8010644b <alltraps>

80107033 <vector152>:
.globl vector152
vector152:
  pushl $0
80107033:	6a 00                	push   $0x0
  pushl $152
80107035:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010703a:	e9 0c f4 ff ff       	jmp    8010644b <alltraps>

8010703f <vector153>:
.globl vector153
vector153:
  pushl $0
8010703f:	6a 00                	push   $0x0
  pushl $153
80107041:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80107046:	e9 00 f4 ff ff       	jmp    8010644b <alltraps>

8010704b <vector154>:
.globl vector154
vector154:
  pushl $0
8010704b:	6a 00                	push   $0x0
  pushl $154
8010704d:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107052:	e9 f4 f3 ff ff       	jmp    8010644b <alltraps>

80107057 <vector155>:
.globl vector155
vector155:
  pushl $0
80107057:	6a 00                	push   $0x0
  pushl $155
80107059:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
8010705e:	e9 e8 f3 ff ff       	jmp    8010644b <alltraps>

80107063 <vector156>:
.globl vector156
vector156:
  pushl $0
80107063:	6a 00                	push   $0x0
  pushl $156
80107065:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010706a:	e9 dc f3 ff ff       	jmp    8010644b <alltraps>

8010706f <vector157>:
.globl vector157
vector157:
  pushl $0
8010706f:	6a 00                	push   $0x0
  pushl $157
80107071:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107076:	e9 d0 f3 ff ff       	jmp    8010644b <alltraps>

8010707b <vector158>:
.globl vector158
vector158:
  pushl $0
8010707b:	6a 00                	push   $0x0
  pushl $158
8010707d:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107082:	e9 c4 f3 ff ff       	jmp    8010644b <alltraps>

80107087 <vector159>:
.globl vector159
vector159:
  pushl $0
80107087:	6a 00                	push   $0x0
  pushl $159
80107089:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
8010708e:	e9 b8 f3 ff ff       	jmp    8010644b <alltraps>

80107093 <vector160>:
.globl vector160
vector160:
  pushl $0
80107093:	6a 00                	push   $0x0
  pushl $160
80107095:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010709a:	e9 ac f3 ff ff       	jmp    8010644b <alltraps>

8010709f <vector161>:
.globl vector161
vector161:
  pushl $0
8010709f:	6a 00                	push   $0x0
  pushl $161
801070a1:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801070a6:	e9 a0 f3 ff ff       	jmp    8010644b <alltraps>

801070ab <vector162>:
.globl vector162
vector162:
  pushl $0
801070ab:	6a 00                	push   $0x0
  pushl $162
801070ad:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801070b2:	e9 94 f3 ff ff       	jmp    8010644b <alltraps>

801070b7 <vector163>:
.globl vector163
vector163:
  pushl $0
801070b7:	6a 00                	push   $0x0
  pushl $163
801070b9:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801070be:	e9 88 f3 ff ff       	jmp    8010644b <alltraps>

801070c3 <vector164>:
.globl vector164
vector164:
  pushl $0
801070c3:	6a 00                	push   $0x0
  pushl $164
801070c5:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801070ca:	e9 7c f3 ff ff       	jmp    8010644b <alltraps>

801070cf <vector165>:
.globl vector165
vector165:
  pushl $0
801070cf:	6a 00                	push   $0x0
  pushl $165
801070d1:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801070d6:	e9 70 f3 ff ff       	jmp    8010644b <alltraps>

801070db <vector166>:
.globl vector166
vector166:
  pushl $0
801070db:	6a 00                	push   $0x0
  pushl $166
801070dd:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801070e2:	e9 64 f3 ff ff       	jmp    8010644b <alltraps>

801070e7 <vector167>:
.globl vector167
vector167:
  pushl $0
801070e7:	6a 00                	push   $0x0
  pushl $167
801070e9:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801070ee:	e9 58 f3 ff ff       	jmp    8010644b <alltraps>

801070f3 <vector168>:
.globl vector168
vector168:
  pushl $0
801070f3:	6a 00                	push   $0x0
  pushl $168
801070f5:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801070fa:	e9 4c f3 ff ff       	jmp    8010644b <alltraps>

801070ff <vector169>:
.globl vector169
vector169:
  pushl $0
801070ff:	6a 00                	push   $0x0
  pushl $169
80107101:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107106:	e9 40 f3 ff ff       	jmp    8010644b <alltraps>

8010710b <vector170>:
.globl vector170
vector170:
  pushl $0
8010710b:	6a 00                	push   $0x0
  pushl $170
8010710d:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107112:	e9 34 f3 ff ff       	jmp    8010644b <alltraps>

80107117 <vector171>:
.globl vector171
vector171:
  pushl $0
80107117:	6a 00                	push   $0x0
  pushl $171
80107119:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
8010711e:	e9 28 f3 ff ff       	jmp    8010644b <alltraps>

80107123 <vector172>:
.globl vector172
vector172:
  pushl $0
80107123:	6a 00                	push   $0x0
  pushl $172
80107125:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010712a:	e9 1c f3 ff ff       	jmp    8010644b <alltraps>

8010712f <vector173>:
.globl vector173
vector173:
  pushl $0
8010712f:	6a 00                	push   $0x0
  pushl $173
80107131:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107136:	e9 10 f3 ff ff       	jmp    8010644b <alltraps>

8010713b <vector174>:
.globl vector174
vector174:
  pushl $0
8010713b:	6a 00                	push   $0x0
  pushl $174
8010713d:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107142:	e9 04 f3 ff ff       	jmp    8010644b <alltraps>

80107147 <vector175>:
.globl vector175
vector175:
  pushl $0
80107147:	6a 00                	push   $0x0
  pushl $175
80107149:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
8010714e:	e9 f8 f2 ff ff       	jmp    8010644b <alltraps>

80107153 <vector176>:
.globl vector176
vector176:
  pushl $0
80107153:	6a 00                	push   $0x0
  pushl $176
80107155:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010715a:	e9 ec f2 ff ff       	jmp    8010644b <alltraps>

8010715f <vector177>:
.globl vector177
vector177:
  pushl $0
8010715f:	6a 00                	push   $0x0
  pushl $177
80107161:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107166:	e9 e0 f2 ff ff       	jmp    8010644b <alltraps>

8010716b <vector178>:
.globl vector178
vector178:
  pushl $0
8010716b:	6a 00                	push   $0x0
  pushl $178
8010716d:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107172:	e9 d4 f2 ff ff       	jmp    8010644b <alltraps>

80107177 <vector179>:
.globl vector179
vector179:
  pushl $0
80107177:	6a 00                	push   $0x0
  pushl $179
80107179:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
8010717e:	e9 c8 f2 ff ff       	jmp    8010644b <alltraps>

80107183 <vector180>:
.globl vector180
vector180:
  pushl $0
80107183:	6a 00                	push   $0x0
  pushl $180
80107185:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010718a:	e9 bc f2 ff ff       	jmp    8010644b <alltraps>

8010718f <vector181>:
.globl vector181
vector181:
  pushl $0
8010718f:	6a 00                	push   $0x0
  pushl $181
80107191:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107196:	e9 b0 f2 ff ff       	jmp    8010644b <alltraps>

8010719b <vector182>:
.globl vector182
vector182:
  pushl $0
8010719b:	6a 00                	push   $0x0
  pushl $182
8010719d:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801071a2:	e9 a4 f2 ff ff       	jmp    8010644b <alltraps>

801071a7 <vector183>:
.globl vector183
vector183:
  pushl $0
801071a7:	6a 00                	push   $0x0
  pushl $183
801071a9:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801071ae:	e9 98 f2 ff ff       	jmp    8010644b <alltraps>

801071b3 <vector184>:
.globl vector184
vector184:
  pushl $0
801071b3:	6a 00                	push   $0x0
  pushl $184
801071b5:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801071ba:	e9 8c f2 ff ff       	jmp    8010644b <alltraps>

801071bf <vector185>:
.globl vector185
vector185:
  pushl $0
801071bf:	6a 00                	push   $0x0
  pushl $185
801071c1:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801071c6:	e9 80 f2 ff ff       	jmp    8010644b <alltraps>

801071cb <vector186>:
.globl vector186
vector186:
  pushl $0
801071cb:	6a 00                	push   $0x0
  pushl $186
801071cd:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801071d2:	e9 74 f2 ff ff       	jmp    8010644b <alltraps>

801071d7 <vector187>:
.globl vector187
vector187:
  pushl $0
801071d7:	6a 00                	push   $0x0
  pushl $187
801071d9:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801071de:	e9 68 f2 ff ff       	jmp    8010644b <alltraps>

801071e3 <vector188>:
.globl vector188
vector188:
  pushl $0
801071e3:	6a 00                	push   $0x0
  pushl $188
801071e5:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801071ea:	e9 5c f2 ff ff       	jmp    8010644b <alltraps>

801071ef <vector189>:
.globl vector189
vector189:
  pushl $0
801071ef:	6a 00                	push   $0x0
  pushl $189
801071f1:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801071f6:	e9 50 f2 ff ff       	jmp    8010644b <alltraps>

801071fb <vector190>:
.globl vector190
vector190:
  pushl $0
801071fb:	6a 00                	push   $0x0
  pushl $190
801071fd:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107202:	e9 44 f2 ff ff       	jmp    8010644b <alltraps>

80107207 <vector191>:
.globl vector191
vector191:
  pushl $0
80107207:	6a 00                	push   $0x0
  pushl $191
80107209:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
8010720e:	e9 38 f2 ff ff       	jmp    8010644b <alltraps>

80107213 <vector192>:
.globl vector192
vector192:
  pushl $0
80107213:	6a 00                	push   $0x0
  pushl $192
80107215:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010721a:	e9 2c f2 ff ff       	jmp    8010644b <alltraps>

8010721f <vector193>:
.globl vector193
vector193:
  pushl $0
8010721f:	6a 00                	push   $0x0
  pushl $193
80107221:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107226:	e9 20 f2 ff ff       	jmp    8010644b <alltraps>

8010722b <vector194>:
.globl vector194
vector194:
  pushl $0
8010722b:	6a 00                	push   $0x0
  pushl $194
8010722d:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107232:	e9 14 f2 ff ff       	jmp    8010644b <alltraps>

80107237 <vector195>:
.globl vector195
vector195:
  pushl $0
80107237:	6a 00                	push   $0x0
  pushl $195
80107239:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
8010723e:	e9 08 f2 ff ff       	jmp    8010644b <alltraps>

80107243 <vector196>:
.globl vector196
vector196:
  pushl $0
80107243:	6a 00                	push   $0x0
  pushl $196
80107245:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010724a:	e9 fc f1 ff ff       	jmp    8010644b <alltraps>

8010724f <vector197>:
.globl vector197
vector197:
  pushl $0
8010724f:	6a 00                	push   $0x0
  pushl $197
80107251:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107256:	e9 f0 f1 ff ff       	jmp    8010644b <alltraps>

8010725b <vector198>:
.globl vector198
vector198:
  pushl $0
8010725b:	6a 00                	push   $0x0
  pushl $198
8010725d:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107262:	e9 e4 f1 ff ff       	jmp    8010644b <alltraps>

80107267 <vector199>:
.globl vector199
vector199:
  pushl $0
80107267:	6a 00                	push   $0x0
  pushl $199
80107269:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
8010726e:	e9 d8 f1 ff ff       	jmp    8010644b <alltraps>

80107273 <vector200>:
.globl vector200
vector200:
  pushl $0
80107273:	6a 00                	push   $0x0
  pushl $200
80107275:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010727a:	e9 cc f1 ff ff       	jmp    8010644b <alltraps>

8010727f <vector201>:
.globl vector201
vector201:
  pushl $0
8010727f:	6a 00                	push   $0x0
  pushl $201
80107281:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107286:	e9 c0 f1 ff ff       	jmp    8010644b <alltraps>

8010728b <vector202>:
.globl vector202
vector202:
  pushl $0
8010728b:	6a 00                	push   $0x0
  pushl $202
8010728d:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107292:	e9 b4 f1 ff ff       	jmp    8010644b <alltraps>

80107297 <vector203>:
.globl vector203
vector203:
  pushl $0
80107297:	6a 00                	push   $0x0
  pushl $203
80107299:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
8010729e:	e9 a8 f1 ff ff       	jmp    8010644b <alltraps>

801072a3 <vector204>:
.globl vector204
vector204:
  pushl $0
801072a3:	6a 00                	push   $0x0
  pushl $204
801072a5:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801072aa:	e9 9c f1 ff ff       	jmp    8010644b <alltraps>

801072af <vector205>:
.globl vector205
vector205:
  pushl $0
801072af:	6a 00                	push   $0x0
  pushl $205
801072b1:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801072b6:	e9 90 f1 ff ff       	jmp    8010644b <alltraps>

801072bb <vector206>:
.globl vector206
vector206:
  pushl $0
801072bb:	6a 00                	push   $0x0
  pushl $206
801072bd:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801072c2:	e9 84 f1 ff ff       	jmp    8010644b <alltraps>

801072c7 <vector207>:
.globl vector207
vector207:
  pushl $0
801072c7:	6a 00                	push   $0x0
  pushl $207
801072c9:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801072ce:	e9 78 f1 ff ff       	jmp    8010644b <alltraps>

801072d3 <vector208>:
.globl vector208
vector208:
  pushl $0
801072d3:	6a 00                	push   $0x0
  pushl $208
801072d5:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801072da:	e9 6c f1 ff ff       	jmp    8010644b <alltraps>

801072df <vector209>:
.globl vector209
vector209:
  pushl $0
801072df:	6a 00                	push   $0x0
  pushl $209
801072e1:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801072e6:	e9 60 f1 ff ff       	jmp    8010644b <alltraps>

801072eb <vector210>:
.globl vector210
vector210:
  pushl $0
801072eb:	6a 00                	push   $0x0
  pushl $210
801072ed:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801072f2:	e9 54 f1 ff ff       	jmp    8010644b <alltraps>

801072f7 <vector211>:
.globl vector211
vector211:
  pushl $0
801072f7:	6a 00                	push   $0x0
  pushl $211
801072f9:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801072fe:	e9 48 f1 ff ff       	jmp    8010644b <alltraps>

80107303 <vector212>:
.globl vector212
vector212:
  pushl $0
80107303:	6a 00                	push   $0x0
  pushl $212
80107305:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010730a:	e9 3c f1 ff ff       	jmp    8010644b <alltraps>

8010730f <vector213>:
.globl vector213
vector213:
  pushl $0
8010730f:	6a 00                	push   $0x0
  pushl $213
80107311:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107316:	e9 30 f1 ff ff       	jmp    8010644b <alltraps>

8010731b <vector214>:
.globl vector214
vector214:
  pushl $0
8010731b:	6a 00                	push   $0x0
  pushl $214
8010731d:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107322:	e9 24 f1 ff ff       	jmp    8010644b <alltraps>

80107327 <vector215>:
.globl vector215
vector215:
  pushl $0
80107327:	6a 00                	push   $0x0
  pushl $215
80107329:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
8010732e:	e9 18 f1 ff ff       	jmp    8010644b <alltraps>

80107333 <vector216>:
.globl vector216
vector216:
  pushl $0
80107333:	6a 00                	push   $0x0
  pushl $216
80107335:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010733a:	e9 0c f1 ff ff       	jmp    8010644b <alltraps>

8010733f <vector217>:
.globl vector217
vector217:
  pushl $0
8010733f:	6a 00                	push   $0x0
  pushl $217
80107341:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107346:	e9 00 f1 ff ff       	jmp    8010644b <alltraps>

8010734b <vector218>:
.globl vector218
vector218:
  pushl $0
8010734b:	6a 00                	push   $0x0
  pushl $218
8010734d:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107352:	e9 f4 f0 ff ff       	jmp    8010644b <alltraps>

80107357 <vector219>:
.globl vector219
vector219:
  pushl $0
80107357:	6a 00                	push   $0x0
  pushl $219
80107359:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
8010735e:	e9 e8 f0 ff ff       	jmp    8010644b <alltraps>

80107363 <vector220>:
.globl vector220
vector220:
  pushl $0
80107363:	6a 00                	push   $0x0
  pushl $220
80107365:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010736a:	e9 dc f0 ff ff       	jmp    8010644b <alltraps>

8010736f <vector221>:
.globl vector221
vector221:
  pushl $0
8010736f:	6a 00                	push   $0x0
  pushl $221
80107371:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107376:	e9 d0 f0 ff ff       	jmp    8010644b <alltraps>

8010737b <vector222>:
.globl vector222
vector222:
  pushl $0
8010737b:	6a 00                	push   $0x0
  pushl $222
8010737d:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107382:	e9 c4 f0 ff ff       	jmp    8010644b <alltraps>

80107387 <vector223>:
.globl vector223
vector223:
  pushl $0
80107387:	6a 00                	push   $0x0
  pushl $223
80107389:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
8010738e:	e9 b8 f0 ff ff       	jmp    8010644b <alltraps>

80107393 <vector224>:
.globl vector224
vector224:
  pushl $0
80107393:	6a 00                	push   $0x0
  pushl $224
80107395:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010739a:	e9 ac f0 ff ff       	jmp    8010644b <alltraps>

8010739f <vector225>:
.globl vector225
vector225:
  pushl $0
8010739f:	6a 00                	push   $0x0
  pushl $225
801073a1:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801073a6:	e9 a0 f0 ff ff       	jmp    8010644b <alltraps>

801073ab <vector226>:
.globl vector226
vector226:
  pushl $0
801073ab:	6a 00                	push   $0x0
  pushl $226
801073ad:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801073b2:	e9 94 f0 ff ff       	jmp    8010644b <alltraps>

801073b7 <vector227>:
.globl vector227
vector227:
  pushl $0
801073b7:	6a 00                	push   $0x0
  pushl $227
801073b9:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801073be:	e9 88 f0 ff ff       	jmp    8010644b <alltraps>

801073c3 <vector228>:
.globl vector228
vector228:
  pushl $0
801073c3:	6a 00                	push   $0x0
  pushl $228
801073c5:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801073ca:	e9 7c f0 ff ff       	jmp    8010644b <alltraps>

801073cf <vector229>:
.globl vector229
vector229:
  pushl $0
801073cf:	6a 00                	push   $0x0
  pushl $229
801073d1:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801073d6:	e9 70 f0 ff ff       	jmp    8010644b <alltraps>

801073db <vector230>:
.globl vector230
vector230:
  pushl $0
801073db:	6a 00                	push   $0x0
  pushl $230
801073dd:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801073e2:	e9 64 f0 ff ff       	jmp    8010644b <alltraps>

801073e7 <vector231>:
.globl vector231
vector231:
  pushl $0
801073e7:	6a 00                	push   $0x0
  pushl $231
801073e9:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801073ee:	e9 58 f0 ff ff       	jmp    8010644b <alltraps>

801073f3 <vector232>:
.globl vector232
vector232:
  pushl $0
801073f3:	6a 00                	push   $0x0
  pushl $232
801073f5:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801073fa:	e9 4c f0 ff ff       	jmp    8010644b <alltraps>

801073ff <vector233>:
.globl vector233
vector233:
  pushl $0
801073ff:	6a 00                	push   $0x0
  pushl $233
80107401:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107406:	e9 40 f0 ff ff       	jmp    8010644b <alltraps>

8010740b <vector234>:
.globl vector234
vector234:
  pushl $0
8010740b:	6a 00                	push   $0x0
  pushl $234
8010740d:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107412:	e9 34 f0 ff ff       	jmp    8010644b <alltraps>

80107417 <vector235>:
.globl vector235
vector235:
  pushl $0
80107417:	6a 00                	push   $0x0
  pushl $235
80107419:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
8010741e:	e9 28 f0 ff ff       	jmp    8010644b <alltraps>

80107423 <vector236>:
.globl vector236
vector236:
  pushl $0
80107423:	6a 00                	push   $0x0
  pushl $236
80107425:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010742a:	e9 1c f0 ff ff       	jmp    8010644b <alltraps>

8010742f <vector237>:
.globl vector237
vector237:
  pushl $0
8010742f:	6a 00                	push   $0x0
  pushl $237
80107431:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107436:	e9 10 f0 ff ff       	jmp    8010644b <alltraps>

8010743b <vector238>:
.globl vector238
vector238:
  pushl $0
8010743b:	6a 00                	push   $0x0
  pushl $238
8010743d:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107442:	e9 04 f0 ff ff       	jmp    8010644b <alltraps>

80107447 <vector239>:
.globl vector239
vector239:
  pushl $0
80107447:	6a 00                	push   $0x0
  pushl $239
80107449:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
8010744e:	e9 f8 ef ff ff       	jmp    8010644b <alltraps>

80107453 <vector240>:
.globl vector240
vector240:
  pushl $0
80107453:	6a 00                	push   $0x0
  pushl $240
80107455:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010745a:	e9 ec ef ff ff       	jmp    8010644b <alltraps>

8010745f <vector241>:
.globl vector241
vector241:
  pushl $0
8010745f:	6a 00                	push   $0x0
  pushl $241
80107461:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107466:	e9 e0 ef ff ff       	jmp    8010644b <alltraps>

8010746b <vector242>:
.globl vector242
vector242:
  pushl $0
8010746b:	6a 00                	push   $0x0
  pushl $242
8010746d:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107472:	e9 d4 ef ff ff       	jmp    8010644b <alltraps>

80107477 <vector243>:
.globl vector243
vector243:
  pushl $0
80107477:	6a 00                	push   $0x0
  pushl $243
80107479:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
8010747e:	e9 c8 ef ff ff       	jmp    8010644b <alltraps>

80107483 <vector244>:
.globl vector244
vector244:
  pushl $0
80107483:	6a 00                	push   $0x0
  pushl $244
80107485:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010748a:	e9 bc ef ff ff       	jmp    8010644b <alltraps>

8010748f <vector245>:
.globl vector245
vector245:
  pushl $0
8010748f:	6a 00                	push   $0x0
  pushl $245
80107491:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107496:	e9 b0 ef ff ff       	jmp    8010644b <alltraps>

8010749b <vector246>:
.globl vector246
vector246:
  pushl $0
8010749b:	6a 00                	push   $0x0
  pushl $246
8010749d:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801074a2:	e9 a4 ef ff ff       	jmp    8010644b <alltraps>

801074a7 <vector247>:
.globl vector247
vector247:
  pushl $0
801074a7:	6a 00                	push   $0x0
  pushl $247
801074a9:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801074ae:	e9 98 ef ff ff       	jmp    8010644b <alltraps>

801074b3 <vector248>:
.globl vector248
vector248:
  pushl $0
801074b3:	6a 00                	push   $0x0
  pushl $248
801074b5:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801074ba:	e9 8c ef ff ff       	jmp    8010644b <alltraps>

801074bf <vector249>:
.globl vector249
vector249:
  pushl $0
801074bf:	6a 00                	push   $0x0
  pushl $249
801074c1:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801074c6:	e9 80 ef ff ff       	jmp    8010644b <alltraps>

801074cb <vector250>:
.globl vector250
vector250:
  pushl $0
801074cb:	6a 00                	push   $0x0
  pushl $250
801074cd:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801074d2:	e9 74 ef ff ff       	jmp    8010644b <alltraps>

801074d7 <vector251>:
.globl vector251
vector251:
  pushl $0
801074d7:	6a 00                	push   $0x0
  pushl $251
801074d9:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801074de:	e9 68 ef ff ff       	jmp    8010644b <alltraps>

801074e3 <vector252>:
.globl vector252
vector252:
  pushl $0
801074e3:	6a 00                	push   $0x0
  pushl $252
801074e5:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801074ea:	e9 5c ef ff ff       	jmp    8010644b <alltraps>

801074ef <vector253>:
.globl vector253
vector253:
  pushl $0
801074ef:	6a 00                	push   $0x0
  pushl $253
801074f1:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801074f6:	e9 50 ef ff ff       	jmp    8010644b <alltraps>

801074fb <vector254>:
.globl vector254
vector254:
  pushl $0
801074fb:	6a 00                	push   $0x0
  pushl $254
801074fd:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107502:	e9 44 ef ff ff       	jmp    8010644b <alltraps>

80107507 <vector255>:
.globl vector255
vector255:
  pushl $0
80107507:	6a 00                	push   $0x0
  pushl $255
80107509:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
8010750e:	e9 38 ef ff ff       	jmp    8010644b <alltraps>

80107513 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
80107513:	55                   	push   %ebp
80107514:	89 e5                	mov    %esp,%ebp
80107516:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80107519:	8b 45 0c             	mov    0xc(%ebp),%eax
8010751c:	83 e8 01             	sub    $0x1,%eax
8010751f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107523:	8b 45 08             	mov    0x8(%ebp),%eax
80107526:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010752a:	8b 45 08             	mov    0x8(%ebp),%eax
8010752d:	c1 e8 10             	shr    $0x10,%eax
80107530:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107534:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107537:	0f 01 10             	lgdtl  (%eax)
}
8010753a:	90                   	nop
8010753b:	c9                   	leave  
8010753c:	c3                   	ret    

8010753d <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
8010753d:	55                   	push   %ebp
8010753e:	89 e5                	mov    %esp,%ebp
80107540:	83 ec 04             	sub    $0x4,%esp
80107543:	8b 45 08             	mov    0x8(%ebp),%eax
80107546:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
8010754a:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010754e:	0f 00 d8             	ltr    %ax
}
80107551:	90                   	nop
80107552:	c9                   	leave  
80107553:	c3                   	ret    

80107554 <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
80107554:	55                   	push   %ebp
80107555:	89 e5                	mov    %esp,%ebp
80107557:	83 ec 04             	sub    $0x4,%esp
8010755a:	8b 45 08             	mov    0x8(%ebp),%eax
8010755d:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
80107561:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107565:	8e e8                	mov    %eax,%gs
}
80107567:	90                   	nop
80107568:	c9                   	leave  
80107569:	c3                   	ret    

8010756a <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
8010756a:	55                   	push   %ebp
8010756b:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010756d:	8b 45 08             	mov    0x8(%ebp),%eax
80107570:	0f 22 d8             	mov    %eax,%cr3
}
80107573:	90                   	nop
80107574:	5d                   	pop    %ebp
80107575:	c3                   	ret    

80107576 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80107576:	55                   	push   %ebp
80107577:	89 e5                	mov    %esp,%ebp
80107579:	8b 45 08             	mov    0x8(%ebp),%eax
8010757c:	05 00 00 00 80       	add    $0x80000000,%eax
80107581:	5d                   	pop    %ebp
80107582:	c3                   	ret    

80107583 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80107583:	55                   	push   %ebp
80107584:	89 e5                	mov    %esp,%ebp
80107586:	8b 45 08             	mov    0x8(%ebp),%eax
80107589:	05 00 00 00 80       	add    $0x80000000,%eax
8010758e:	5d                   	pop    %ebp
8010758f:	c3                   	ret    

80107590 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107590:	55                   	push   %ebp
80107591:	89 e5                	mov    %esp,%ebp
80107593:	53                   	push   %ebx
80107594:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107597:	e8 e9 bb ff ff       	call   80103185 <cpunum>
8010759c:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801075a2:	05 80 29 11 80       	add    $0x80112980,%eax
801075a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801075aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075ad:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801075b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075b6:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801075bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075bf:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801075c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075c6:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801075ca:	83 e2 f0             	and    $0xfffffff0,%edx
801075cd:	83 ca 0a             	or     $0xa,%edx
801075d0:	88 50 7d             	mov    %dl,0x7d(%eax)
801075d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075d6:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801075da:	83 ca 10             	or     $0x10,%edx
801075dd:	88 50 7d             	mov    %dl,0x7d(%eax)
801075e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075e3:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801075e7:	83 e2 9f             	and    $0xffffff9f,%edx
801075ea:	88 50 7d             	mov    %dl,0x7d(%eax)
801075ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075f0:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801075f4:	83 ca 80             	or     $0xffffff80,%edx
801075f7:	88 50 7d             	mov    %dl,0x7d(%eax)
801075fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075fd:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107601:	83 ca 0f             	or     $0xf,%edx
80107604:	88 50 7e             	mov    %dl,0x7e(%eax)
80107607:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010760a:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010760e:	83 e2 ef             	and    $0xffffffef,%edx
80107611:	88 50 7e             	mov    %dl,0x7e(%eax)
80107614:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107617:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010761b:	83 e2 df             	and    $0xffffffdf,%edx
8010761e:	88 50 7e             	mov    %dl,0x7e(%eax)
80107621:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107624:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107628:	83 ca 40             	or     $0x40,%edx
8010762b:	88 50 7e             	mov    %dl,0x7e(%eax)
8010762e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107631:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107635:	83 ca 80             	or     $0xffffff80,%edx
80107638:	88 50 7e             	mov    %dl,0x7e(%eax)
8010763b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010763e:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107642:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107645:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
8010764c:	ff ff 
8010764e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107651:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107658:	00 00 
8010765a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010765d:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107664:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107667:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010766e:	83 e2 f0             	and    $0xfffffff0,%edx
80107671:	83 ca 02             	or     $0x2,%edx
80107674:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010767a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010767d:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107684:	83 ca 10             	or     $0x10,%edx
80107687:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010768d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107690:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107697:	83 e2 9f             	and    $0xffffff9f,%edx
8010769a:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801076a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076a3:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801076aa:	83 ca 80             	or     $0xffffff80,%edx
801076ad:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801076b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076b6:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076bd:	83 ca 0f             	or     $0xf,%edx
801076c0:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801076c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076c9:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076d0:	83 e2 ef             	and    $0xffffffef,%edx
801076d3:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801076d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076dc:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076e3:	83 e2 df             	and    $0xffffffdf,%edx
801076e6:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801076ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076ef:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076f6:	83 ca 40             	or     $0x40,%edx
801076f9:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801076ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107702:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107709:	83 ca 80             	or     $0xffffff80,%edx
8010770c:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107712:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107715:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010771c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010771f:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107726:	ff ff 
80107728:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010772b:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107732:	00 00 
80107734:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107737:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
8010773e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107741:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107748:	83 e2 f0             	and    $0xfffffff0,%edx
8010774b:	83 ca 0a             	or     $0xa,%edx
8010774e:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107754:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107757:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
8010775e:	83 ca 10             	or     $0x10,%edx
80107761:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107767:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010776a:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107771:	83 ca 60             	or     $0x60,%edx
80107774:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010777a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010777d:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107784:	83 ca 80             	or     $0xffffff80,%edx
80107787:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010778d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107790:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107797:	83 ca 0f             	or     $0xf,%edx
8010779a:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077a3:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077aa:	83 e2 ef             	and    $0xffffffef,%edx
801077ad:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077b6:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077bd:	83 e2 df             	and    $0xffffffdf,%edx
801077c0:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077c9:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077d0:	83 ca 40             	or     $0x40,%edx
801077d3:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077dc:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077e3:	83 ca 80             	or     $0xffffff80,%edx
801077e6:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077ef:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801077f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077f9:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107800:	ff ff 
80107802:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107805:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
8010780c:	00 00 
8010780e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107811:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107818:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010781b:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107822:	83 e2 f0             	and    $0xfffffff0,%edx
80107825:	83 ca 02             	or     $0x2,%edx
80107828:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
8010782e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107831:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107838:	83 ca 10             	or     $0x10,%edx
8010783b:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107841:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107844:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010784b:	83 ca 60             	or     $0x60,%edx
8010784e:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107854:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107857:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010785e:	83 ca 80             	or     $0xffffff80,%edx
80107861:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107867:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010786a:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107871:	83 ca 0f             	or     $0xf,%edx
80107874:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010787a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010787d:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107884:	83 e2 ef             	and    $0xffffffef,%edx
80107887:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010788d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107890:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107897:	83 e2 df             	and    $0xffffffdf,%edx
8010789a:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078a3:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801078aa:	83 ca 40             	or     $0x40,%edx
801078ad:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078b6:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801078bd:	83 ca 80             	or     $0xffffff80,%edx
801078c0:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078c9:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801078d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078d3:	05 b4 00 00 00       	add    $0xb4,%eax
801078d8:	89 c3                	mov    %eax,%ebx
801078da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078dd:	05 b4 00 00 00       	add    $0xb4,%eax
801078e2:	c1 e8 10             	shr    $0x10,%eax
801078e5:	89 c2                	mov    %eax,%edx
801078e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078ea:	05 b4 00 00 00       	add    $0xb4,%eax
801078ef:	c1 e8 18             	shr    $0x18,%eax
801078f2:	89 c1                	mov    %eax,%ecx
801078f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078f7:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
801078fe:	00 00 
80107900:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107903:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
8010790a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010790d:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80107913:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107916:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010791d:	83 e2 f0             	and    $0xfffffff0,%edx
80107920:	83 ca 02             	or     $0x2,%edx
80107923:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107929:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010792c:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107933:	83 ca 10             	or     $0x10,%edx
80107936:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
8010793c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010793f:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107946:	83 e2 9f             	and    $0xffffff9f,%edx
80107949:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
8010794f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107952:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107959:	83 ca 80             	or     $0xffffff80,%edx
8010795c:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107962:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107965:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
8010796c:	83 e2 f0             	and    $0xfffffff0,%edx
8010796f:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107975:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107978:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
8010797f:	83 e2 ef             	and    $0xffffffef,%edx
80107982:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107988:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010798b:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107992:	83 e2 df             	and    $0xffffffdf,%edx
80107995:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
8010799b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010799e:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801079a5:	83 ca 40             	or     $0x40,%edx
801079a8:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801079ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079b1:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801079b8:	83 ca 80             	or     $0xffffff80,%edx
801079bb:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801079c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079c4:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
801079ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079cd:	83 c0 70             	add    $0x70,%eax
801079d0:	83 ec 08             	sub    $0x8,%esp
801079d3:	6a 38                	push   $0x38
801079d5:	50                   	push   %eax
801079d6:	e8 38 fb ff ff       	call   80107513 <lgdt>
801079db:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
801079de:	83 ec 0c             	sub    $0xc,%esp
801079e1:	6a 18                	push   $0x18
801079e3:	e8 6c fb ff ff       	call   80107554 <loadgs>
801079e8:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
801079eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ee:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
801079f4:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
801079fb:	00 00 00 00 
}
801079ff:	90                   	nop
80107a00:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107a03:	c9                   	leave  
80107a04:	c3                   	ret    

80107a05 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107a05:	55                   	push   %ebp
80107a06:	89 e5                	mov    %esp,%ebp
80107a08:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107a0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a0e:	c1 e8 16             	shr    $0x16,%eax
80107a11:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107a18:	8b 45 08             	mov    0x8(%ebp),%eax
80107a1b:	01 d0                	add    %edx,%eax
80107a1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107a20:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a23:	8b 00                	mov    (%eax),%eax
80107a25:	83 e0 01             	and    $0x1,%eax
80107a28:	85 c0                	test   %eax,%eax
80107a2a:	74 18                	je     80107a44 <walkpgdir+0x3f>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107a2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a2f:	8b 00                	mov    (%eax),%eax
80107a31:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107a36:	50                   	push   %eax
80107a37:	e8 47 fb ff ff       	call   80107583 <p2v>
80107a3c:	83 c4 04             	add    $0x4,%esp
80107a3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107a42:	eb 48                	jmp    80107a8c <walkpgdir+0x87>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107a44:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107a48:	74 0e                	je     80107a58 <walkpgdir+0x53>
80107a4a:	e8 b1 b2 ff ff       	call   80102d00 <kalloc>
80107a4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107a52:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107a56:	75 07                	jne    80107a5f <walkpgdir+0x5a>
      return 0;
80107a58:	b8 00 00 00 00       	mov    $0x0,%eax
80107a5d:	eb 44                	jmp    80107aa3 <walkpgdir+0x9e>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107a5f:	83 ec 04             	sub    $0x4,%esp
80107a62:	68 00 10 00 00       	push   $0x1000
80107a67:	6a 00                	push   $0x0
80107a69:	ff 75 f4             	pushl  -0xc(%ebp)
80107a6c:	e8 52 d6 ff ff       	call   801050c3 <memset>
80107a71:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107a74:	83 ec 0c             	sub    $0xc,%esp
80107a77:	ff 75 f4             	pushl  -0xc(%ebp)
80107a7a:	e8 f7 fa ff ff       	call   80107576 <v2p>
80107a7f:	83 c4 10             	add    $0x10,%esp
80107a82:	83 c8 07             	or     $0x7,%eax
80107a85:	89 c2                	mov    %eax,%edx
80107a87:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a8a:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107a8c:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a8f:	c1 e8 0c             	shr    $0xc,%eax
80107a92:	25 ff 03 00 00       	and    $0x3ff,%eax
80107a97:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107a9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aa1:	01 d0                	add    %edx,%eax
}
80107aa3:	c9                   	leave  
80107aa4:	c3                   	ret    

80107aa5 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107aa5:	55                   	push   %ebp
80107aa6:	89 e5                	mov    %esp,%ebp
80107aa8:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107aab:	8b 45 0c             	mov    0xc(%ebp),%eax
80107aae:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ab3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107ab6:	8b 55 0c             	mov    0xc(%ebp),%edx
80107ab9:	8b 45 10             	mov    0x10(%ebp),%eax
80107abc:	01 d0                	add    %edx,%eax
80107abe:	83 e8 01             	sub    $0x1,%eax
80107ac1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ac6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107ac9:	83 ec 04             	sub    $0x4,%esp
80107acc:	6a 01                	push   $0x1
80107ace:	ff 75 f4             	pushl  -0xc(%ebp)
80107ad1:	ff 75 08             	pushl  0x8(%ebp)
80107ad4:	e8 2c ff ff ff       	call   80107a05 <walkpgdir>
80107ad9:	83 c4 10             	add    $0x10,%esp
80107adc:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107adf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107ae3:	75 07                	jne    80107aec <mappages+0x47>
      return -1;
80107ae5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107aea:	eb 47                	jmp    80107b33 <mappages+0x8e>
    if(*pte & PTE_P)
80107aec:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107aef:	8b 00                	mov    (%eax),%eax
80107af1:	83 e0 01             	and    $0x1,%eax
80107af4:	85 c0                	test   %eax,%eax
80107af6:	74 0d                	je     80107b05 <mappages+0x60>
      panic("remap");
80107af8:	83 ec 0c             	sub    $0xc,%esp
80107afb:	68 90 b9 10 80       	push   $0x8010b990
80107b00:	e8 61 8a ff ff       	call   80100566 <panic>
    *pte = pa | perm | PTE_P;
80107b05:	8b 45 18             	mov    0x18(%ebp),%eax
80107b08:	0b 45 14             	or     0x14(%ebp),%eax
80107b0b:	83 c8 01             	or     $0x1,%eax
80107b0e:	89 c2                	mov    %eax,%edx
80107b10:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107b13:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107b15:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b18:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107b1b:	74 10                	je     80107b2d <mappages+0x88>
      break;
    a += PGSIZE;
80107b1d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107b24:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80107b2b:	eb 9c                	jmp    80107ac9 <mappages+0x24>
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
80107b2d:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107b2e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107b33:	c9                   	leave  
80107b34:	c3                   	ret    

80107b35 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107b35:	55                   	push   %ebp
80107b36:	89 e5                	mov    %esp,%ebp
80107b38:	53                   	push   %ebx
80107b39:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107b3c:	e8 bf b1 ff ff       	call   80102d00 <kalloc>
80107b41:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107b44:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107b48:	75 0a                	jne    80107b54 <setupkvm+0x1f>
    return 0;
80107b4a:	b8 00 00 00 00       	mov    $0x0,%eax
80107b4f:	e9 8e 00 00 00       	jmp    80107be2 <setupkvm+0xad>
  memset(pgdir, 0, PGSIZE);
80107b54:	83 ec 04             	sub    $0x4,%esp
80107b57:	68 00 10 00 00       	push   $0x1000
80107b5c:	6a 00                	push   $0x0
80107b5e:	ff 75 f0             	pushl  -0x10(%ebp)
80107b61:	e8 5d d5 ff ff       	call   801050c3 <memset>
80107b66:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107b69:	83 ec 0c             	sub    $0xc,%esp
80107b6c:	68 00 00 00 0e       	push   $0xe000000
80107b71:	e8 0d fa ff ff       	call   80107583 <p2v>
80107b76:	83 c4 10             	add    $0x10,%esp
80107b79:	3d 00 00 00 fc       	cmp    $0xfc000000,%eax
80107b7e:	76 0d                	jbe    80107b8d <setupkvm+0x58>
    panic("PHYSTOP too high");
80107b80:	83 ec 0c             	sub    $0xc,%esp
80107b83:	68 96 b9 10 80       	push   $0x8010b996
80107b88:	e8 d9 89 ff ff       	call   80100566 <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107b8d:	c7 45 f4 c0 e4 10 80 	movl   $0x8010e4c0,-0xc(%ebp)
80107b94:	eb 40                	jmp    80107bd6 <setupkvm+0xa1>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107b96:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b99:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
80107b9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b9f:	8b 50 04             	mov    0x4(%eax),%edx
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107ba2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ba5:	8b 58 08             	mov    0x8(%eax),%ebx
80107ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bab:	8b 40 04             	mov    0x4(%eax),%eax
80107bae:	29 c3                	sub    %eax,%ebx
80107bb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bb3:	8b 00                	mov    (%eax),%eax
80107bb5:	83 ec 0c             	sub    $0xc,%esp
80107bb8:	51                   	push   %ecx
80107bb9:	52                   	push   %edx
80107bba:	53                   	push   %ebx
80107bbb:	50                   	push   %eax
80107bbc:	ff 75 f0             	pushl  -0x10(%ebp)
80107bbf:	e8 e1 fe ff ff       	call   80107aa5 <mappages>
80107bc4:	83 c4 20             	add    $0x20,%esp
80107bc7:	85 c0                	test   %eax,%eax
80107bc9:	79 07                	jns    80107bd2 <setupkvm+0x9d>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80107bcb:	b8 00 00 00 00       	mov    $0x0,%eax
80107bd0:	eb 10                	jmp    80107be2 <setupkvm+0xad>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107bd2:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107bd6:	81 7d f4 00 e5 10 80 	cmpl   $0x8010e500,-0xc(%ebp)
80107bdd:	72 b7                	jb     80107b96 <setupkvm+0x61>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80107bdf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107be2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107be5:	c9                   	leave  
80107be6:	c3                   	ret    

80107be7 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107be7:	55                   	push   %ebp
80107be8:	89 e5                	mov    %esp,%ebp
80107bea:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107bed:	e8 43 ff ff ff       	call   80107b35 <setupkvm>
80107bf2:	a3 58 57 11 80       	mov    %eax,0x80115758
  switchkvm();
80107bf7:	e8 03 00 00 00       	call   80107bff <switchkvm>
}
80107bfc:	90                   	nop
80107bfd:	c9                   	leave  
80107bfe:	c3                   	ret    

80107bff <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107bff:	55                   	push   %ebp
80107c00:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107c02:	a1 58 57 11 80       	mov    0x80115758,%eax
80107c07:	50                   	push   %eax
80107c08:	e8 69 f9 ff ff       	call   80107576 <v2p>
80107c0d:	83 c4 04             	add    $0x4,%esp
80107c10:	50                   	push   %eax
80107c11:	e8 54 f9 ff ff       	call   8010756a <lcr3>
80107c16:	83 c4 04             	add    $0x4,%esp
}
80107c19:	90                   	nop
80107c1a:	c9                   	leave  
80107c1b:	c3                   	ret    

80107c1c <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107c1c:	55                   	push   %ebp
80107c1d:	89 e5                	mov    %esp,%ebp
80107c1f:	56                   	push   %esi
80107c20:	53                   	push   %ebx
  pushcli();
80107c21:	e8 97 d3 ff ff       	call   80104fbd <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107c26:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107c2c:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107c33:	83 c2 08             	add    $0x8,%edx
80107c36:	89 d6                	mov    %edx,%esi
80107c38:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107c3f:	83 c2 08             	add    $0x8,%edx
80107c42:	c1 ea 10             	shr    $0x10,%edx
80107c45:	89 d3                	mov    %edx,%ebx
80107c47:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107c4e:	83 c2 08             	add    $0x8,%edx
80107c51:	c1 ea 18             	shr    $0x18,%edx
80107c54:	89 d1                	mov    %edx,%ecx
80107c56:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107c5d:	67 00 
80107c5f:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
80107c66:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80107c6c:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107c73:	83 e2 f0             	and    $0xfffffff0,%edx
80107c76:	83 ca 09             	or     $0x9,%edx
80107c79:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107c7f:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107c86:	83 ca 10             	or     $0x10,%edx
80107c89:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107c8f:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107c96:	83 e2 9f             	and    $0xffffff9f,%edx
80107c99:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107c9f:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107ca6:	83 ca 80             	or     $0xffffff80,%edx
80107ca9:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107caf:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107cb6:	83 e2 f0             	and    $0xfffffff0,%edx
80107cb9:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107cbf:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107cc6:	83 e2 ef             	and    $0xffffffef,%edx
80107cc9:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107ccf:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107cd6:	83 e2 df             	and    $0xffffffdf,%edx
80107cd9:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107cdf:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107ce6:	83 ca 40             	or     $0x40,%edx
80107ce9:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107cef:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107cf6:	83 e2 7f             	and    $0x7f,%edx
80107cf9:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107cff:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107d05:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d0b:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107d12:	83 e2 ef             	and    $0xffffffef,%edx
80107d15:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107d1b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d21:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80107d27:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d2d:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107d34:	8b 52 08             	mov    0x8(%edx),%edx
80107d37:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107d3d:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80107d40:	83 ec 0c             	sub    $0xc,%esp
80107d43:	6a 30                	push   $0x30
80107d45:	e8 f3 f7 ff ff       	call   8010753d <ltr>
80107d4a:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80107d4d:	8b 45 08             	mov    0x8(%ebp),%eax
80107d50:	8b 40 04             	mov    0x4(%eax),%eax
80107d53:	85 c0                	test   %eax,%eax
80107d55:	75 0d                	jne    80107d64 <switchuvm+0x148>
    panic("switchuvm: no pgdir");
80107d57:	83 ec 0c             	sub    $0xc,%esp
80107d5a:	68 a7 b9 10 80       	push   $0x8010b9a7
80107d5f:	e8 02 88 ff ff       	call   80100566 <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80107d64:	8b 45 08             	mov    0x8(%ebp),%eax
80107d67:	8b 40 04             	mov    0x4(%eax),%eax
80107d6a:	83 ec 0c             	sub    $0xc,%esp
80107d6d:	50                   	push   %eax
80107d6e:	e8 03 f8 ff ff       	call   80107576 <v2p>
80107d73:	83 c4 10             	add    $0x10,%esp
80107d76:	83 ec 0c             	sub    $0xc,%esp
80107d79:	50                   	push   %eax
80107d7a:	e8 eb f7 ff ff       	call   8010756a <lcr3>
80107d7f:	83 c4 10             	add    $0x10,%esp
  popcli();
80107d82:	e8 7b d2 ff ff       	call   80105002 <popcli>
}
80107d87:	90                   	nop
80107d88:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107d8b:	5b                   	pop    %ebx
80107d8c:	5e                   	pop    %esi
80107d8d:	5d                   	pop    %ebp
80107d8e:	c3                   	ret    

80107d8f <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107d8f:	55                   	push   %ebp
80107d90:	89 e5                	mov    %esp,%ebp
80107d92:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
80107d95:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80107d9c:	76 0d                	jbe    80107dab <inituvm+0x1c>
    panic("inituvm: more than a page");
80107d9e:	83 ec 0c             	sub    $0xc,%esp
80107da1:	68 bb b9 10 80       	push   $0x8010b9bb
80107da6:	e8 bb 87 ff ff       	call   80100566 <panic>
  mem = kalloc();
80107dab:	e8 50 af ff ff       	call   80102d00 <kalloc>
80107db0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80107db3:	83 ec 04             	sub    $0x4,%esp
80107db6:	68 00 10 00 00       	push   $0x1000
80107dbb:	6a 00                	push   $0x0
80107dbd:	ff 75 f4             	pushl  -0xc(%ebp)
80107dc0:	e8 fe d2 ff ff       	call   801050c3 <memset>
80107dc5:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107dc8:	83 ec 0c             	sub    $0xc,%esp
80107dcb:	ff 75 f4             	pushl  -0xc(%ebp)
80107dce:	e8 a3 f7 ff ff       	call   80107576 <v2p>
80107dd3:	83 c4 10             	add    $0x10,%esp
80107dd6:	83 ec 0c             	sub    $0xc,%esp
80107dd9:	6a 06                	push   $0x6
80107ddb:	50                   	push   %eax
80107ddc:	68 00 10 00 00       	push   $0x1000
80107de1:	6a 00                	push   $0x0
80107de3:	ff 75 08             	pushl  0x8(%ebp)
80107de6:	e8 ba fc ff ff       	call   80107aa5 <mappages>
80107deb:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
80107dee:	83 ec 04             	sub    $0x4,%esp
80107df1:	ff 75 10             	pushl  0x10(%ebp)
80107df4:	ff 75 0c             	pushl  0xc(%ebp)
80107df7:	ff 75 f4             	pushl  -0xc(%ebp)
80107dfa:	e8 83 d3 ff ff       	call   80105182 <memmove>
80107dff:	83 c4 10             	add    $0x10,%esp
}
80107e02:	90                   	nop
80107e03:	c9                   	leave  
80107e04:	c3                   	ret    

80107e05 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107e05:	55                   	push   %ebp
80107e06:	89 e5                	mov    %esp,%ebp
80107e08:	53                   	push   %ebx
80107e09:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107e0c:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e0f:	25 ff 0f 00 00       	and    $0xfff,%eax
80107e14:	85 c0                	test   %eax,%eax
80107e16:	74 0d                	je     80107e25 <loaduvm+0x20>
    panic("loaduvm: addr must be page aligned");
80107e18:	83 ec 0c             	sub    $0xc,%esp
80107e1b:	68 d8 b9 10 80       	push   $0x8010b9d8
80107e20:	e8 41 87 ff ff       	call   80100566 <panic>
  for(i = 0; i < sz; i += PGSIZE){
80107e25:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107e2c:	e9 95 00 00 00       	jmp    80107ec6 <loaduvm+0xc1>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107e31:	8b 55 0c             	mov    0xc(%ebp),%edx
80107e34:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e37:	01 d0                	add    %edx,%eax
80107e39:	83 ec 04             	sub    $0x4,%esp
80107e3c:	6a 00                	push   $0x0
80107e3e:	50                   	push   %eax
80107e3f:	ff 75 08             	pushl  0x8(%ebp)
80107e42:	e8 be fb ff ff       	call   80107a05 <walkpgdir>
80107e47:	83 c4 10             	add    $0x10,%esp
80107e4a:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107e4d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107e51:	75 0d                	jne    80107e60 <loaduvm+0x5b>
      panic("loaduvm: address should exist");
80107e53:	83 ec 0c             	sub    $0xc,%esp
80107e56:	68 fb b9 10 80       	push   $0x8010b9fb
80107e5b:	e8 06 87 ff ff       	call   80100566 <panic>
    pa = PTE_ADDR(*pte);
80107e60:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107e63:	8b 00                	mov    (%eax),%eax
80107e65:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e6a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80107e6d:	8b 45 18             	mov    0x18(%ebp),%eax
80107e70:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107e73:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80107e78:	77 0b                	ja     80107e85 <loaduvm+0x80>
      n = sz - i;
80107e7a:	8b 45 18             	mov    0x18(%ebp),%eax
80107e7d:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107e80:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107e83:	eb 07                	jmp    80107e8c <loaduvm+0x87>
    else
      n = PGSIZE;
80107e85:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80107e8c:	8b 55 14             	mov    0x14(%ebp),%edx
80107e8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e92:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80107e95:	83 ec 0c             	sub    $0xc,%esp
80107e98:	ff 75 e8             	pushl  -0x18(%ebp)
80107e9b:	e8 e3 f6 ff ff       	call   80107583 <p2v>
80107ea0:	83 c4 10             	add    $0x10,%esp
80107ea3:	ff 75 f0             	pushl  -0x10(%ebp)
80107ea6:	53                   	push   %ebx
80107ea7:	50                   	push   %eax
80107ea8:	ff 75 10             	pushl  0x10(%ebp)
80107eab:	e8 fe a0 ff ff       	call   80101fae <readi>
80107eb0:	83 c4 10             	add    $0x10,%esp
80107eb3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107eb6:	74 07                	je     80107ebf <loaduvm+0xba>
      return -1;
80107eb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107ebd:	eb 18                	jmp    80107ed7 <loaduvm+0xd2>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107ebf:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107ec6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ec9:	3b 45 18             	cmp    0x18(%ebp),%eax
80107ecc:	0f 82 5f ff ff ff    	jb     80107e31 <loaduvm+0x2c>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80107ed2:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107ed7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107eda:	c9                   	leave  
80107edb:	c3                   	ret    

80107edc <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107edc:	55                   	push   %ebp
80107edd:	89 e5                	mov    %esp,%ebp
80107edf:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80107ee2:	8b 45 10             	mov    0x10(%ebp),%eax
80107ee5:	85 c0                	test   %eax,%eax
80107ee7:	79 0a                	jns    80107ef3 <allocuvm+0x17>
    return 0;
80107ee9:	b8 00 00 00 00       	mov    $0x0,%eax
80107eee:	e9 b0 00 00 00       	jmp    80107fa3 <allocuvm+0xc7>
  if(newsz < oldsz)
80107ef3:	8b 45 10             	mov    0x10(%ebp),%eax
80107ef6:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107ef9:	73 08                	jae    80107f03 <allocuvm+0x27>
    return oldsz;
80107efb:	8b 45 0c             	mov    0xc(%ebp),%eax
80107efe:	e9 a0 00 00 00       	jmp    80107fa3 <allocuvm+0xc7>

  a = PGROUNDUP(oldsz);
80107f03:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f06:	05 ff 0f 00 00       	add    $0xfff,%eax
80107f0b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f10:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
80107f13:	eb 7f                	jmp    80107f94 <allocuvm+0xb8>
    mem = kalloc();
80107f15:	e8 e6 ad ff ff       	call   80102d00 <kalloc>
80107f1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80107f1d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107f21:	75 2b                	jne    80107f4e <allocuvm+0x72>
      cprintf("allocuvm out of memory\n");
80107f23:	83 ec 0c             	sub    $0xc,%esp
80107f26:	68 19 ba 10 80       	push   $0x8010ba19
80107f2b:	e8 96 84 ff ff       	call   801003c6 <cprintf>
80107f30:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
80107f33:	83 ec 04             	sub    $0x4,%esp
80107f36:	ff 75 0c             	pushl  0xc(%ebp)
80107f39:	ff 75 10             	pushl  0x10(%ebp)
80107f3c:	ff 75 08             	pushl  0x8(%ebp)
80107f3f:	e8 61 00 00 00       	call   80107fa5 <deallocuvm>
80107f44:	83 c4 10             	add    $0x10,%esp
      return 0;
80107f47:	b8 00 00 00 00       	mov    $0x0,%eax
80107f4c:	eb 55                	jmp    80107fa3 <allocuvm+0xc7>
    }
    memset(mem, 0, PGSIZE);
80107f4e:	83 ec 04             	sub    $0x4,%esp
80107f51:	68 00 10 00 00       	push   $0x1000
80107f56:	6a 00                	push   $0x0
80107f58:	ff 75 f0             	pushl  -0x10(%ebp)
80107f5b:	e8 63 d1 ff ff       	call   801050c3 <memset>
80107f60:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107f63:	83 ec 0c             	sub    $0xc,%esp
80107f66:	ff 75 f0             	pushl  -0x10(%ebp)
80107f69:	e8 08 f6 ff ff       	call   80107576 <v2p>
80107f6e:	83 c4 10             	add    $0x10,%esp
80107f71:	89 c2                	mov    %eax,%edx
80107f73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f76:	83 ec 0c             	sub    $0xc,%esp
80107f79:	6a 06                	push   $0x6
80107f7b:	52                   	push   %edx
80107f7c:	68 00 10 00 00       	push   $0x1000
80107f81:	50                   	push   %eax
80107f82:	ff 75 08             	pushl  0x8(%ebp)
80107f85:	e8 1b fb ff ff       	call   80107aa5 <mappages>
80107f8a:	83 c4 20             	add    $0x20,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107f8d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107f94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f97:	3b 45 10             	cmp    0x10(%ebp),%eax
80107f9a:	0f 82 75 ff ff ff    	jb     80107f15 <allocuvm+0x39>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
80107fa0:	8b 45 10             	mov    0x10(%ebp),%eax
}
80107fa3:	c9                   	leave  
80107fa4:	c3                   	ret    

80107fa5 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107fa5:	55                   	push   %ebp
80107fa6:	89 e5                	mov    %esp,%ebp
80107fa8:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80107fab:	8b 45 10             	mov    0x10(%ebp),%eax
80107fae:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107fb1:	72 08                	jb     80107fbb <deallocuvm+0x16>
    return oldsz;
80107fb3:	8b 45 0c             	mov    0xc(%ebp),%eax
80107fb6:	e9 a5 00 00 00       	jmp    80108060 <deallocuvm+0xbb>

  a = PGROUNDUP(newsz);
80107fbb:	8b 45 10             	mov    0x10(%ebp),%eax
80107fbe:	05 ff 0f 00 00       	add    $0xfff,%eax
80107fc3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107fc8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107fcb:	e9 81 00 00 00       	jmp    80108051 <deallocuvm+0xac>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107fd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fd3:	83 ec 04             	sub    $0x4,%esp
80107fd6:	6a 00                	push   $0x0
80107fd8:	50                   	push   %eax
80107fd9:	ff 75 08             	pushl  0x8(%ebp)
80107fdc:	e8 24 fa ff ff       	call   80107a05 <walkpgdir>
80107fe1:	83 c4 10             	add    $0x10,%esp
80107fe4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80107fe7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107feb:	75 09                	jne    80107ff6 <deallocuvm+0x51>
      a += (NPTENTRIES - 1) * PGSIZE;
80107fed:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
80107ff4:	eb 54                	jmp    8010804a <deallocuvm+0xa5>
    else if((*pte & PTE_P) != 0){
80107ff6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ff9:	8b 00                	mov    (%eax),%eax
80107ffb:	83 e0 01             	and    $0x1,%eax
80107ffe:	85 c0                	test   %eax,%eax
80108000:	74 48                	je     8010804a <deallocuvm+0xa5>
      pa = PTE_ADDR(*pte);
80108002:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108005:	8b 00                	mov    (%eax),%eax
80108007:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010800c:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
8010800f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108013:	75 0d                	jne    80108022 <deallocuvm+0x7d>
        panic("kfree");
80108015:	83 ec 0c             	sub    $0xc,%esp
80108018:	68 31 ba 10 80       	push   $0x8010ba31
8010801d:	e8 44 85 ff ff       	call   80100566 <panic>
      char *v = p2v(pa);
80108022:	83 ec 0c             	sub    $0xc,%esp
80108025:	ff 75 ec             	pushl  -0x14(%ebp)
80108028:	e8 56 f5 ff ff       	call   80107583 <p2v>
8010802d:	83 c4 10             	add    $0x10,%esp
80108030:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
80108033:	83 ec 0c             	sub    $0xc,%esp
80108036:	ff 75 e8             	pushl  -0x18(%ebp)
80108039:	e8 25 ac ff ff       	call   80102c63 <kfree>
8010803e:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80108041:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108044:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010804a:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108051:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108054:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108057:	0f 82 73 ff ff ff    	jb     80107fd0 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
8010805d:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108060:	c9                   	leave  
80108061:	c3                   	ret    

80108062 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108062:	55                   	push   %ebp
80108063:	89 e5                	mov    %esp,%ebp
80108065:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
80108068:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010806c:	75 0d                	jne    8010807b <freevm+0x19>
    panic("freevm: no pgdir");
8010806e:	83 ec 0c             	sub    $0xc,%esp
80108071:	68 37 ba 10 80       	push   $0x8010ba37
80108076:	e8 eb 84 ff ff       	call   80100566 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
8010807b:	83 ec 04             	sub    $0x4,%esp
8010807e:	6a 00                	push   $0x0
80108080:	68 00 00 00 80       	push   $0x80000000
80108085:	ff 75 08             	pushl  0x8(%ebp)
80108088:	e8 18 ff ff ff       	call   80107fa5 <deallocuvm>
8010808d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108090:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108097:	eb 4f                	jmp    801080e8 <freevm+0x86>
    if(pgdir[i] & PTE_P){
80108099:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010809c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801080a3:	8b 45 08             	mov    0x8(%ebp),%eax
801080a6:	01 d0                	add    %edx,%eax
801080a8:	8b 00                	mov    (%eax),%eax
801080aa:	83 e0 01             	and    $0x1,%eax
801080ad:	85 c0                	test   %eax,%eax
801080af:	74 33                	je     801080e4 <freevm+0x82>
      char * v = p2v(PTE_ADDR(pgdir[i]));
801080b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080b4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801080bb:	8b 45 08             	mov    0x8(%ebp),%eax
801080be:	01 d0                	add    %edx,%eax
801080c0:	8b 00                	mov    (%eax),%eax
801080c2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080c7:	83 ec 0c             	sub    $0xc,%esp
801080ca:	50                   	push   %eax
801080cb:	e8 b3 f4 ff ff       	call   80107583 <p2v>
801080d0:	83 c4 10             	add    $0x10,%esp
801080d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
801080d6:	83 ec 0c             	sub    $0xc,%esp
801080d9:	ff 75 f0             	pushl  -0x10(%ebp)
801080dc:	e8 82 ab ff ff       	call   80102c63 <kfree>
801080e1:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801080e4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801080e8:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
801080ef:	76 a8                	jbe    80108099 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801080f1:	83 ec 0c             	sub    $0xc,%esp
801080f4:	ff 75 08             	pushl  0x8(%ebp)
801080f7:	e8 67 ab ff ff       	call   80102c63 <kfree>
801080fc:	83 c4 10             	add    $0x10,%esp
}
801080ff:	90                   	nop
80108100:	c9                   	leave  
80108101:	c3                   	ret    

80108102 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108102:	55                   	push   %ebp
80108103:	89 e5                	mov    %esp,%ebp
80108105:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108108:	83 ec 04             	sub    $0x4,%esp
8010810b:	6a 00                	push   $0x0
8010810d:	ff 75 0c             	pushl  0xc(%ebp)
80108110:	ff 75 08             	pushl  0x8(%ebp)
80108113:	e8 ed f8 ff ff       	call   80107a05 <walkpgdir>
80108118:	83 c4 10             	add    $0x10,%esp
8010811b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
8010811e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108122:	75 0d                	jne    80108131 <clearpteu+0x2f>
    panic("clearpteu");
80108124:	83 ec 0c             	sub    $0xc,%esp
80108127:	68 48 ba 10 80       	push   $0x8010ba48
8010812c:	e8 35 84 ff ff       	call   80100566 <panic>
  *pte &= ~PTE_U;
80108131:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108134:	8b 00                	mov    (%eax),%eax
80108136:	83 e0 fb             	and    $0xfffffffb,%eax
80108139:	89 c2                	mov    %eax,%edx
8010813b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010813e:	89 10                	mov    %edx,(%eax)
}
80108140:	90                   	nop
80108141:	c9                   	leave  
80108142:	c3                   	ret    

80108143 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108143:	55                   	push   %ebp
80108144:	89 e5                	mov    %esp,%ebp
80108146:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
80108149:	e8 e7 f9 ff ff       	call   80107b35 <setupkvm>
8010814e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108151:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108155:	75 0a                	jne    80108161 <copyuvm+0x1e>
    return 0;
80108157:	b8 00 00 00 00       	mov    $0x0,%eax
8010815c:	e9 e9 00 00 00       	jmp    8010824a <copyuvm+0x107>
  for(i = 0; i < sz; i += PGSIZE){
80108161:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108168:	e9 b5 00 00 00       	jmp    80108222 <copyuvm+0xdf>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
8010816d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108170:	83 ec 04             	sub    $0x4,%esp
80108173:	6a 00                	push   $0x0
80108175:	50                   	push   %eax
80108176:	ff 75 08             	pushl  0x8(%ebp)
80108179:	e8 87 f8 ff ff       	call   80107a05 <walkpgdir>
8010817e:	83 c4 10             	add    $0x10,%esp
80108181:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108184:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108188:	75 0d                	jne    80108197 <copyuvm+0x54>
      panic("copyuvm: pte should exist");
8010818a:	83 ec 0c             	sub    $0xc,%esp
8010818d:	68 52 ba 10 80       	push   $0x8010ba52
80108192:	e8 cf 83 ff ff       	call   80100566 <panic>
    if(!(*pte & PTE_P))
80108197:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010819a:	8b 00                	mov    (%eax),%eax
8010819c:	83 e0 01             	and    $0x1,%eax
8010819f:	85 c0                	test   %eax,%eax
801081a1:	75 0d                	jne    801081b0 <copyuvm+0x6d>
      panic("copyuvm: page not present");
801081a3:	83 ec 0c             	sub    $0xc,%esp
801081a6:	68 6c ba 10 80       	push   $0x8010ba6c
801081ab:	e8 b6 83 ff ff       	call   80100566 <panic>
    pa = PTE_ADDR(*pte);
801081b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801081b3:	8b 00                	mov    (%eax),%eax
801081b5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801081ba:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if((mem = kalloc()) == 0)
801081bd:	e8 3e ab ff ff       	call   80102d00 <kalloc>
801081c2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801081c5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
801081c9:	74 68                	je     80108233 <copyuvm+0xf0>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
801081cb:	83 ec 0c             	sub    $0xc,%esp
801081ce:	ff 75 e8             	pushl  -0x18(%ebp)
801081d1:	e8 ad f3 ff ff       	call   80107583 <p2v>
801081d6:	83 c4 10             	add    $0x10,%esp
801081d9:	83 ec 04             	sub    $0x4,%esp
801081dc:	68 00 10 00 00       	push   $0x1000
801081e1:	50                   	push   %eax
801081e2:	ff 75 e4             	pushl  -0x1c(%ebp)
801081e5:	e8 98 cf ff ff       	call   80105182 <memmove>
801081ea:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
801081ed:	83 ec 0c             	sub    $0xc,%esp
801081f0:	ff 75 e4             	pushl  -0x1c(%ebp)
801081f3:	e8 7e f3 ff ff       	call   80107576 <v2p>
801081f8:	83 c4 10             	add    $0x10,%esp
801081fb:	89 c2                	mov    %eax,%edx
801081fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108200:	83 ec 0c             	sub    $0xc,%esp
80108203:	6a 06                	push   $0x6
80108205:	52                   	push   %edx
80108206:	68 00 10 00 00       	push   $0x1000
8010820b:	50                   	push   %eax
8010820c:	ff 75 f0             	pushl  -0x10(%ebp)
8010820f:	e8 91 f8 ff ff       	call   80107aa5 <mappages>
80108214:	83 c4 20             	add    $0x20,%esp
80108217:	85 c0                	test   %eax,%eax
80108219:	78 1b                	js     80108236 <copyuvm+0xf3>
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010821b:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108222:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108225:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108228:	0f 82 3f ff ff ff    	jb     8010816d <copyuvm+0x2a>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
  }
  return d;
8010822e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108231:	eb 17                	jmp    8010824a <copyuvm+0x107>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
80108233:	90                   	nop
80108234:	eb 01                	jmp    80108237 <copyuvm+0xf4>
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
80108236:	90                   	nop
  }
  return d;

bad:
  freevm(d);
80108237:	83 ec 0c             	sub    $0xc,%esp
8010823a:	ff 75 f0             	pushl  -0x10(%ebp)
8010823d:	e8 20 fe ff ff       	call   80108062 <freevm>
80108242:	83 c4 10             	add    $0x10,%esp
  return 0;
80108245:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010824a:	c9                   	leave  
8010824b:	c3                   	ret    

8010824c <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
8010824c:	55                   	push   %ebp
8010824d:	89 e5                	mov    %esp,%ebp
8010824f:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108252:	83 ec 04             	sub    $0x4,%esp
80108255:	6a 00                	push   $0x0
80108257:	ff 75 0c             	pushl  0xc(%ebp)
8010825a:	ff 75 08             	pushl  0x8(%ebp)
8010825d:	e8 a3 f7 ff ff       	call   80107a05 <walkpgdir>
80108262:	83 c4 10             	add    $0x10,%esp
80108265:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
80108268:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010826b:	8b 00                	mov    (%eax),%eax
8010826d:	83 e0 01             	and    $0x1,%eax
80108270:	85 c0                	test   %eax,%eax
80108272:	75 07                	jne    8010827b <uva2ka+0x2f>
    return 0;
80108274:	b8 00 00 00 00       	mov    $0x0,%eax
80108279:	eb 29                	jmp    801082a4 <uva2ka+0x58>
  if((*pte & PTE_U) == 0)
8010827b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010827e:	8b 00                	mov    (%eax),%eax
80108280:	83 e0 04             	and    $0x4,%eax
80108283:	85 c0                	test   %eax,%eax
80108285:	75 07                	jne    8010828e <uva2ka+0x42>
    return 0;
80108287:	b8 00 00 00 00       	mov    $0x0,%eax
8010828c:	eb 16                	jmp    801082a4 <uva2ka+0x58>
  return (char*)p2v(PTE_ADDR(*pte));
8010828e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108291:	8b 00                	mov    (%eax),%eax
80108293:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108298:	83 ec 0c             	sub    $0xc,%esp
8010829b:	50                   	push   %eax
8010829c:	e8 e2 f2 ff ff       	call   80107583 <p2v>
801082a1:	83 c4 10             	add    $0x10,%esp
}
801082a4:	c9                   	leave  
801082a5:	c3                   	ret    

801082a6 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801082a6:	55                   	push   %ebp
801082a7:	89 e5                	mov    %esp,%ebp
801082a9:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
801082ac:	8b 45 10             	mov    0x10(%ebp),%eax
801082af:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
801082b2:	eb 7f                	jmp    80108333 <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
801082b4:	8b 45 0c             	mov    0xc(%ebp),%eax
801082b7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
801082bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
801082c2:	83 ec 08             	sub    $0x8,%esp
801082c5:	50                   	push   %eax
801082c6:	ff 75 08             	pushl  0x8(%ebp)
801082c9:	e8 7e ff ff ff       	call   8010824c <uva2ka>
801082ce:	83 c4 10             	add    $0x10,%esp
801082d1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
801082d4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801082d8:	75 07                	jne    801082e1 <copyout+0x3b>
      return -1;
801082da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801082df:	eb 61                	jmp    80108342 <copyout+0x9c>
    n = PGSIZE - (va - va0);
801082e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801082e4:	2b 45 0c             	sub    0xc(%ebp),%eax
801082e7:	05 00 10 00 00       	add    $0x1000,%eax
801082ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
801082ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
801082f2:	3b 45 14             	cmp    0x14(%ebp),%eax
801082f5:	76 06                	jbe    801082fd <copyout+0x57>
      n = len;
801082f7:	8b 45 14             	mov    0x14(%ebp),%eax
801082fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
801082fd:	8b 45 0c             	mov    0xc(%ebp),%eax
80108300:	2b 45 ec             	sub    -0x14(%ebp),%eax
80108303:	89 c2                	mov    %eax,%edx
80108305:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108308:	01 d0                	add    %edx,%eax
8010830a:	83 ec 04             	sub    $0x4,%esp
8010830d:	ff 75 f0             	pushl  -0x10(%ebp)
80108310:	ff 75 f4             	pushl  -0xc(%ebp)
80108313:	50                   	push   %eax
80108314:	e8 69 ce ff ff       	call   80105182 <memmove>
80108319:	83 c4 10             	add    $0x10,%esp
    len -= n;
8010831c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010831f:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
80108322:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108325:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
80108328:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010832b:	05 00 10 00 00       	add    $0x1000,%eax
80108330:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108333:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80108337:	0f 85 77 ff ff ff    	jne    801082b4 <copyout+0xe>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010833d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108342:	c9                   	leave  
80108343:	c3                   	ret    

80108344 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
80108344:	55                   	push   %ebp
80108345:	89 e5                	mov    %esp,%ebp
80108347:	83 ec 1c             	sub    $0x1c,%esp
8010834a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010834d:	8b 55 10             	mov    0x10(%ebp),%edx
80108350:	8b 45 14             	mov    0x14(%ebp),%eax
80108353:	88 4d ec             	mov    %cl,-0x14(%ebp)
80108356:	88 55 e8             	mov    %dl,-0x18(%ebp)
80108359:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
8010835c:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80108360:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
80108363:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
80108367:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
8010836a:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
8010836e:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
80108371:	8b 45 08             	mov    0x8(%ebp),%eax
80108374:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
80108378:	66 89 10             	mov    %dx,(%eax)
8010837b:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
8010837f:	88 50 02             	mov    %dl,0x2(%eax)
}
80108382:	8b 45 08             	mov    0x8(%ebp),%eax
80108385:	c9                   	leave  
80108386:	c2 04 00             	ret    $0x4

80108389 <APCharacterMove>:
int character_pre_x = 1, character_pre_y = 1;
int character_x = 1,character_y = 1;


void APCharacterMove(int direction)
{
80108389:	55                   	push   %ebp
8010838a:	89 e5                	mov    %esp,%ebp
{

}


}
8010838c:	90                   	nop
8010838d:	5d                   	pop    %ebp
8010838e:	c3                   	ret    

8010838f <APDrawCharacter>:

//character_move
void APDrawCharacter(int is_grid)
{
8010838f:	55                   	push   %ebp
80108390:	89 e5                	mov    %esp,%ebp
80108392:	56                   	push   %esi
80108393:	53                   	push   %ebx
80108394:	83 ec 20             	sub    $0x20,%esp
    acquire(&screenLock);
80108397:	83 ec 0c             	sub    $0xc,%esp
8010839a:	68 60 57 11 80       	push   $0x80115760
8010839f:	e8 bc ca ff ff       	call   80104e60 <acquire>
801083a4:	83 c4 10             	add    $0x10,%esp
    if (is_grid)
801083a7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801083ab:	0f 84 a0 01 00 00    	je     80108551 <APDrawCharacter+0x1c2>
    {
        int off = (character_pre_y * GRID_WIDTH + WND_TITLE_HEIGHT)* screenWidth + character_pre_x * GRID_WIDTH;
801083b1:	a1 04 e5 10 80       	mov    0x8010e504,%eax
801083b6:	83 c0 01             	add    $0x1,%eax
801083b9:	6b d0 32             	imul   $0x32,%eax,%edx
801083bc:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
801083c3:	0f b7 c0             	movzwl %ax,%eax
801083c6:	0f af d0             	imul   %eax,%edx
801083c9:	a1 00 e5 10 80       	mov    0x8010e500,%eax
801083ce:	6b c0 32             	imul   $0x32,%eax,%eax
801083d1:	01 d0                	add    %edx,%eax
801083d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
        int size = sizeof(AColor) * GRID_WIDTH;
801083d6:	c7 45 e4 96 00 00 00 	movl   $0x96,-0x1c(%ebp)
        for (int j = 0; j < GRID_WIDTH; j++)
801083dd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801083e4:	eb 77                	jmp    8010845d <APDrawCharacter+0xce>
        {
            memmove(screenBuf + off, screenContent + off,size);
801083e6:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801083e9:	8b 1d a8 e6 10 80    	mov    0x8010e6a8,%ebx
801083ef:	8b 55 f4             	mov    -0xc(%ebp),%edx
801083f2:	89 d0                	mov    %edx,%eax
801083f4:	01 c0                	add    %eax,%eax
801083f6:	01 d0                	add    %edx,%eax
801083f8:	01 c3                	add    %eax,%ebx
801083fa:	8b 35 a4 e6 10 80    	mov    0x8010e6a4,%esi
80108400:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108403:	89 d0                	mov    %edx,%eax
80108405:	01 c0                	add    %eax,%eax
80108407:	01 d0                	add    %edx,%eax
80108409:	01 f0                	add    %esi,%eax
8010840b:	83 ec 04             	sub    $0x4,%esp
8010840e:	51                   	push   %ecx
8010840f:	53                   	push   %ebx
80108410:	50                   	push   %eax
80108411:	e8 6c cd ff ff       	call   80105182 <memmove>
80108416:	83 c4 10             	add    $0x10,%esp
            memmove(screenAddr + off,screenContent + off,size);
80108419:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010841c:	8b 1d a8 e6 10 80    	mov    0x8010e6a8,%ebx
80108422:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108425:	89 d0                	mov    %edx,%eax
80108427:	01 c0                	add    %eax,%eax
80108429:	01 d0                	add    %edx,%eax
8010842b:	01 c3                	add    %eax,%ebx
8010842d:	8b 35 a0 e6 10 80    	mov    0x8010e6a0,%esi
80108433:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108436:	89 d0                	mov    %edx,%eax
80108438:	01 c0                	add    %eax,%eax
8010843a:	01 d0                	add    %edx,%eax
8010843c:	01 f0                	add    %esi,%eax
8010843e:	83 ec 04             	sub    $0x4,%esp
80108441:	51                   	push   %ecx
80108442:	53                   	push   %ebx
80108443:	50                   	push   %eax
80108444:	e8 39 cd ff ff       	call   80105182 <memmove>
80108449:	83 c4 10             	add    $0x10,%esp
            off += screenWidth;
8010844c:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80108453:	0f b7 c0             	movzwl %ax,%eax
80108456:	01 45 f4             	add    %eax,-0xc(%ebp)
    acquire(&screenLock);
    if (is_grid)
    {
        int off = (character_pre_y * GRID_WIDTH + WND_TITLE_HEIGHT)* screenWidth + character_pre_x * GRID_WIDTH;
        int size = sizeof(AColor) * GRID_WIDTH;
        for (int j = 0; j < GRID_WIDTH; j++)
80108459:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010845d:	83 7d f0 31          	cmpl   $0x31,-0x10(%ebp)
80108461:	7e 83                	jle    801083e6 <APDrawCharacter+0x57>
        {
            memmove(screenBuf + off, screenContent + off,size);
            memmove(screenAddr + off,screenContent + off,size);
            off += screenWidth;
        }
        off = character_y * GRID_WIDTH * screenWidth + character_x * GRID_WIDTH;
80108463:	a1 0c e5 10 80       	mov    0x8010e50c,%eax
80108468:	6b d0 32             	imul   $0x32,%eax,%edx
8010846b:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80108472:	0f b7 c0             	movzwl %ax,%eax
80108475:	0f af d0             	imul   %eax,%edx
80108478:	a1 08 e5 10 80       	mov    0x8010e508,%eax
8010847d:	6b c0 32             	imul   $0x32,%eax,%eax
80108480:	01 d0                	add    %edx,%eax
80108482:	89 45 f4             	mov    %eax,-0xc(%ebp)
        for (int j = 0; j < GRID_WIDTH; j++)
80108485:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
8010848c:	e9 b6 00 00 00       	jmp    80108547 <APDrawCharacter+0x1b8>
        {
            for (int i = 0; i < GRID_WIDTH; i++)
80108491:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
80108498:	e9 8f 00 00 00       	jmp    8010852c <APDrawCharacter+0x19d>
            {
                AColor c = character_img[i][j];
8010849d:	8b 55 ec             	mov    -0x14(%ebp),%edx
801084a0:	8b 4d e8             	mov    -0x18(%ebp),%ecx
801084a3:	89 d0                	mov    %edx,%eax
801084a5:	01 c0                	add    %eax,%eax
801084a7:	01 d0                	add    %edx,%eax
801084a9:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801084af:	01 d0                	add    %edx,%eax
801084b1:	05 c0 78 11 80       	add    $0x801178c0,%eax
801084b6:	0f b7 10             	movzwl (%eax),%edx
801084b9:	66 89 55 e1          	mov    %dx,-0x1f(%ebp)
801084bd:	0f b6 40 02          	movzbl 0x2(%eax),%eax
801084c1:	88 45 e3             	mov    %al,-0x1d(%ebp)
                if (c.r != COLOR_TRANSPARENT || c.g != COLOR_TRANSPARENT || c.b != COLOR_TRANSPARENT)
801084c4:	0f b6 45 e3          	movzbl -0x1d(%ebp),%eax
801084c8:	3c 0c                	cmp    $0xc,%al
801084ca:	75 10                	jne    801084dc <APDrawCharacter+0x14d>
801084cc:	0f b6 45 e2          	movzbl -0x1e(%ebp),%eax
801084d0:	3c 0c                	cmp    $0xc,%al
801084d2:	75 08                	jne    801084dc <APDrawCharacter+0x14d>
801084d4:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
801084d8:	3c 0c                	cmp    $0xc,%al
801084da:	74 4c                	je     80108528 <APDrawCharacter+0x199>
                {
                    screenBuf[off + i] = c;
801084dc:	8b 15 a4 e6 10 80    	mov    0x8010e6a4,%edx
801084e2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801084e5:	8b 45 e8             	mov    -0x18(%ebp),%eax
801084e8:	01 c8                	add    %ecx,%eax
801084ea:	89 c1                	mov    %eax,%ecx
801084ec:	89 c8                	mov    %ecx,%eax
801084ee:	01 c0                	add    %eax,%eax
801084f0:	01 c8                	add    %ecx,%eax
801084f2:	01 d0                	add    %edx,%eax
801084f4:	0f b7 55 e1          	movzwl -0x1f(%ebp),%edx
801084f8:	66 89 10             	mov    %dx,(%eax)
801084fb:	0f b6 55 e3          	movzbl -0x1d(%ebp),%edx
801084ff:	88 50 02             	mov    %dl,0x2(%eax)
                    screenAddr[off + i] = c;
80108502:	8b 15 a0 e6 10 80    	mov    0x8010e6a0,%edx
80108508:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010850b:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010850e:	01 c8                	add    %ecx,%eax
80108510:	89 c1                	mov    %eax,%ecx
80108512:	89 c8                	mov    %ecx,%eax
80108514:	01 c0                	add    %eax,%eax
80108516:	01 c8                	add    %ecx,%eax
80108518:	01 d0                	add    %edx,%eax
8010851a:	0f b7 55 e1          	movzwl -0x1f(%ebp),%edx
8010851e:	66 89 10             	mov    %dx,(%eax)
80108521:	0f b6 55 e3          	movzbl -0x1d(%ebp),%edx
80108525:	88 50 02             	mov    %dl,0x2(%eax)
            off += screenWidth;
        }
        off = character_y * GRID_WIDTH * screenWidth + character_x * GRID_WIDTH;
        for (int j = 0; j < GRID_WIDTH; j++)
        {
            for (int i = 0; i < GRID_WIDTH; i++)
80108528:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
8010852c:	83 7d e8 31          	cmpl   $0x31,-0x18(%ebp)
80108530:	0f 8e 67 ff ff ff    	jle    8010849d <APDrawCharacter+0x10e>
                {
                    screenBuf[off + i] = c;
                    screenAddr[off + i] = c;
                }
            }
            off += screenWidth;
80108536:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010853d:	0f b7 c0             	movzwl %ax,%eax
80108540:	01 45 f4             	add    %eax,-0xc(%ebp)
            memmove(screenBuf + off, screenContent + off,size);
            memmove(screenAddr + off,screenContent + off,size);
            off += screenWidth;
        }
        off = character_y * GRID_WIDTH * screenWidth + character_x * GRID_WIDTH;
        for (int j = 0; j < GRID_WIDTH; j++)
80108543:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80108547:	83 7d ec 31          	cmpl   $0x31,-0x14(%ebp)
8010854b:	0f 8e 40 ff ff ff    	jle    80108491 <APDrawCharacter+0x102>
                }
            }
            off += screenWidth;
        }
    }
    release(&screenLock);
80108551:	83 ec 0c             	sub    $0xc,%esp
80108554:	68 60 57 11 80       	push   $0x80115760
80108559:	e8 69 c9 ff ff       	call   80104ec7 <release>
8010855e:	83 c4 10             	add    $0x10,%esp
}
80108561:	90                   	nop
80108562:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108565:	5b                   	pop    %ebx
80108566:	5e                   	pop    %esi
80108567:	5d                   	pop    %ebp
80108568:	c3                   	ret    

80108569 <APCharacterInit>:
ATimerList timerList;

int timerListReady = 0;

void APCharacterInit(void)
{
80108569:	55                   	push   %ebp
8010856a:	89 e5                	mov    %esp,%ebp
8010856c:	53                   	push   %ebx
8010856d:	81 ec b4 00 00 00    	sub    $0xb4,%esp
    for (int j = 0; j < GRID_WIDTH; j++)
80108573:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010857a:	e9 a4 00 00 00       	jmp    80108623 <APCharacterInit+0xba>
        for (int i = 0; i < GRID_WIDTH; i++)
8010857f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80108586:	e9 8a 00 00 00       	jmp    80108615 <APCharacterInit+0xac>
        {
            character_img[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
8010858b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010858e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80108591:	89 d0                	mov    %edx,%eax
80108593:	01 c0                	add    %eax,%eax
80108595:	01 d0                	add    %edx,%eax
80108597:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010859d:	01 d0                	add    %edx,%eax
8010859f:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801085a5:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801085ab:	6a 0c                	push   $0xc
801085ad:	6a 0c                	push   $0xc
801085af:	6a 0c                	push   $0xc
801085b1:	50                   	push   %eax
801085b2:	e8 8d fd ff ff       	call   80108344 <RGB>
801085b7:	83 c4 0c             	add    $0xc,%esp
801085ba:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801085c1:	66 89 03             	mov    %ax,(%ebx)
801085c4:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801085cb:	88 43 02             	mov    %al,0x2(%ebx)
            character_img2[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
801085ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
801085d1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801085d4:	89 d0                	mov    %edx,%eax
801085d6:	01 c0                	add    %eax,%eax
801085d8:	01 d0                	add    %edx,%eax
801085da:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801085e0:	01 d0                	add    %edx,%eax
801085e2:	8d 98 20 96 11 80    	lea    -0x7fee69e0(%eax),%ebx
801085e8:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801085ee:	6a 0c                	push   $0xc
801085f0:	6a 0c                	push   $0xc
801085f2:	6a 0c                	push   $0xc
801085f4:	50                   	push   %eax
801085f5:	e8 4a fd ff ff       	call   80108344 <RGB>
801085fa:	83 c4 0c             	add    $0xc,%esp
801085fd:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108604:	66 89 03             	mov    %ax,(%ebx)
80108607:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010860e:	88 43 02             	mov    %al,0x2(%ebx)
int timerListReady = 0;

void APCharacterInit(void)
{
    for (int j = 0; j < GRID_WIDTH; j++)
        for (int i = 0; i < GRID_WIDTH; i++)
80108611:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80108615:	83 7d f0 31          	cmpl   $0x31,-0x10(%ebp)
80108619:	0f 8e 6c ff ff ff    	jle    8010858b <APCharacterInit+0x22>

int timerListReady = 0;

void APCharacterInit(void)
{
    for (int j = 0; j < GRID_WIDTH; j++)
8010861f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108623:	83 7d f4 31          	cmpl   $0x31,-0xc(%ebp)
80108627:	0f 8e 52 ff ff ff    	jle    8010857f <APCharacterInit+0x16>
            character_img[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
            character_img2[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
        }
    //

    int line=0;
8010862d:	c7 85 64 ff ff ff 00 	movl   $0x0,-0x9c(%ebp)
80108634:	00 00 00 
  
    for(int j=line;j<line+3;j++)
80108637:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010863d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108640:	eb 5d                	jmp    8010869f <APCharacterInit+0x136>
	for(int i=10;i<25;i++)
80108642:	c7 45 e8 0a 00 00 00 	movl   $0xa,-0x18(%ebp)
80108649:	eb 4a                	jmp    80108695 <APCharacterInit+0x12c>
		character_img[i][j] = RGB(0xff,0x00,0x00);
8010864b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010864e:	8b 4d e8             	mov    -0x18(%ebp),%ecx
80108651:	89 d0                	mov    %edx,%eax
80108653:	01 c0                	add    %eax,%eax
80108655:	01 d0                	add    %edx,%eax
80108657:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010865d:	01 d0                	add    %edx,%eax
8010865f:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108665:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010866b:	6a 00                	push   $0x0
8010866d:	6a 00                	push   $0x0
8010866f:	68 ff 00 00 00       	push   $0xff
80108674:	50                   	push   %eax
80108675:	e8 ca fc ff ff       	call   80108344 <RGB>
8010867a:	83 c4 0c             	add    $0xc,%esp
8010867d:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108684:	66 89 03             	mov    %ax,(%ebx)
80108687:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010868e:	88 43 02             	mov    %al,0x2(%ebx)
    //

    int line=0;
  
    for(int j=line;j<line+3;j++)
	for(int i=10;i<25;i++)
80108691:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
80108695:	83 7d e8 18          	cmpl   $0x18,-0x18(%ebp)
80108699:	7e b0                	jle    8010864b <APCharacterInit+0xe2>
        }
    //

    int line=0;
  
    for(int j=line;j<line+3;j++)
8010869b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
8010869f:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801086a5:	83 c0 03             	add    $0x3,%eax
801086a8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801086ab:	7f 95                	jg     80108642 <APCharacterInit+0xd9>
	for(int i=10;i<25;i++)
		character_img[i][j] = RGB(0xff,0x00,0x00);
    line=line+3;
801086ad:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
    for(int j=line;j<line+3;j++)
801086b4:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801086ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801086bd:	eb 5d                	jmp    8010871c <APCharacterInit+0x1b3>
        for(int i=5;i<40;i++)
801086bf:	c7 45 e0 05 00 00 00 	movl   $0x5,-0x20(%ebp)
801086c6:	eb 4a                	jmp    80108712 <APCharacterInit+0x1a9>
            character_img[i][j] = RGB(0xff,0x00,0x00);
801086c8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801086cb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801086ce:	89 d0                	mov    %edx,%eax
801086d0:	01 c0                	add    %eax,%eax
801086d2:	01 d0                	add    %edx,%eax
801086d4:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801086da:	01 d0                	add    %edx,%eax
801086dc:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801086e2:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801086e8:	6a 00                	push   $0x0
801086ea:	6a 00                	push   $0x0
801086ec:	68 ff 00 00 00       	push   $0xff
801086f1:	50                   	push   %eax
801086f2:	e8 4d fc ff ff       	call   80108344 <RGB>
801086f7:	83 c4 0c             	add    $0xc,%esp
801086fa:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108701:	66 89 03             	mov    %ax,(%ebx)
80108704:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010870b:	88 43 02             	mov    %al,0x2(%ebx)
    for(int j=line;j<line+3;j++)
	for(int i=10;i<25;i++)
		character_img[i][j] = RGB(0xff,0x00,0x00);
    line=line+3;
    for(int j=line;j<line+3;j++)
        for(int i=5;i<40;i++)
8010870e:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
80108712:	83 7d e0 27          	cmpl   $0x27,-0x20(%ebp)
80108716:	7e b0                	jle    801086c8 <APCharacterInit+0x15f>
  
    for(int j=line;j<line+3;j++)
	for(int i=10;i<25;i++)
		character_img[i][j] = RGB(0xff,0x00,0x00);
    line=line+3;
    for(int j=line;j<line+3;j++)
80108718:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010871c:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108722:	83 c0 03             	add    $0x3,%eax
80108725:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
80108728:	7f 95                	jg     801086bf <APCharacterInit+0x156>
        for(int i=5;i<40;i++)
            character_img[i][j] = RGB(0xff,0x00,0x00);

    line=line+3;
8010872a:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)

    for(int j=line;j<line+3;j++){
80108731:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108737:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010873a:	e9 78 01 00 00       	jmp    801088b7 <APCharacterInit+0x34e>
        for(int i=5;i<30;i++){
8010873f:	c7 45 d8 05 00 00 00 	movl   $0x5,-0x28(%ebp)
80108746:	e9 5e 01 00 00       	jmp    801088a9 <APCharacterInit+0x340>
               if(i<15)
8010874b:	83 7d d8 0e          	cmpl   $0xe,-0x28(%ebp)
8010874f:	7f 4b                	jg     8010879c <APCharacterInit+0x233>
			character_img[i][j] = RGB(128,64,0);
80108751:	8b 55 dc             	mov    -0x24(%ebp),%edx
80108754:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80108757:	89 d0                	mov    %edx,%eax
80108759:	01 c0                	add    %eax,%eax
8010875b:	01 d0                	add    %edx,%eax
8010875d:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108763:	01 d0                	add    %edx,%eax
80108765:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010876b:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108771:	6a 00                	push   $0x0
80108773:	6a 40                	push   $0x40
80108775:	68 80 00 00 00       	push   $0x80
8010877a:	50                   	push   %eax
8010877b:	e8 c4 fb ff ff       	call   80108344 <RGB>
80108780:	83 c4 0c             	add    $0xc,%esp
80108783:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010878a:	66 89 03             	mov    %ax,(%ebx)
8010878d:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108794:	88 43 02             	mov    %al,0x2(%ebx)
80108797:	e9 09 01 00 00       	jmp    801088a5 <APCharacterInit+0x33c>
		else if(i>=15&&i<22)
8010879c:	83 7d d8 0e          	cmpl   $0xe,-0x28(%ebp)
801087a0:	7e 57                	jle    801087f9 <APCharacterInit+0x290>
801087a2:	83 7d d8 15          	cmpl   $0x15,-0x28(%ebp)
801087a6:	7f 51                	jg     801087f9 <APCharacterInit+0x290>
			character_img[i][j] = RGB(249,236,236);
801087a8:	8b 55 dc             	mov    -0x24(%ebp),%edx
801087ab:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801087ae:	89 d0                	mov    %edx,%eax
801087b0:	01 c0                	add    %eax,%eax
801087b2:	01 d0                	add    %edx,%eax
801087b4:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801087ba:	01 d0                	add    %edx,%eax
801087bc:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801087c2:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801087c8:	68 ec 00 00 00       	push   $0xec
801087cd:	68 ec 00 00 00       	push   $0xec
801087d2:	68 f9 00 00 00       	push   $0xf9
801087d7:	50                   	push   %eax
801087d8:	e8 67 fb ff ff       	call   80108344 <RGB>
801087dd:	83 c4 0c             	add    $0xc,%esp
801087e0:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801087e7:	66 89 03             	mov    %ax,(%ebx)
801087ea:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801087f1:	88 43 02             	mov    %al,0x2(%ebx)
801087f4:	e9 ac 00 00 00       	jmp    801088a5 <APCharacterInit+0x33c>
		else if(i>=22&&i<26)
801087f9:	83 7d d8 15          	cmpl   $0x15,-0x28(%ebp)
801087fd:	7e 4e                	jle    8010884d <APCharacterInit+0x2e4>
801087ff:	83 7d d8 19          	cmpl   $0x19,-0x28(%ebp)
80108803:	7f 48                	jg     8010884d <APCharacterInit+0x2e4>
			character_img[i][j] = RGB(128,64,0);
80108805:	8b 55 dc             	mov    -0x24(%ebp),%edx
80108808:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010880b:	89 d0                	mov    %edx,%eax
8010880d:	01 c0                	add    %eax,%eax
8010880f:	01 d0                	add    %edx,%eax
80108811:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108817:	01 d0                	add    %edx,%eax
80108819:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010881f:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108825:	6a 00                	push   $0x0
80108827:	6a 40                	push   $0x40
80108829:	68 80 00 00 00       	push   $0x80
8010882e:	50                   	push   %eax
8010882f:	e8 10 fb ff ff       	call   80108344 <RGB>
80108834:	83 c4 0c             	add    $0xc,%esp
80108837:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010883e:	66 89 03             	mov    %ax,(%ebx)
80108841:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108848:	88 43 02             	mov    %al,0x2(%ebx)
8010884b:	eb 58                	jmp    801088a5 <APCharacterInit+0x33c>
		else if(i>=26&&i<30)
8010884d:	83 7d d8 19          	cmpl   $0x19,-0x28(%ebp)
80108851:	7e 52                	jle    801088a5 <APCharacterInit+0x33c>
80108853:	83 7d d8 1d          	cmpl   $0x1d,-0x28(%ebp)
80108857:	7f 4c                	jg     801088a5 <APCharacterInit+0x33c>
			character_img[i][j] = RGB(249,236,236);
80108859:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010885c:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010885f:	89 d0                	mov    %edx,%eax
80108861:	01 c0                	add    %eax,%eax
80108863:	01 d0                	add    %edx,%eax
80108865:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010886b:	01 d0                	add    %edx,%eax
8010886d:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108873:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108879:	68 ec 00 00 00       	push   $0xec
8010887e:	68 ec 00 00 00       	push   $0xec
80108883:	68 f9 00 00 00       	push   $0xf9
80108888:	50                   	push   %eax
80108889:	e8 b6 fa ff ff       	call   80108344 <RGB>
8010888e:	83 c4 0c             	add    $0xc,%esp
80108891:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108898:	66 89 03             	mov    %ax,(%ebx)
8010889b:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801088a2:	88 43 02             	mov    %al,0x2(%ebx)
            character_img[i][j] = RGB(0xff,0x00,0x00);

    line=line+3;

    for(int j=line;j<line+3;j++){
        for(int i=5;i<30;i++){
801088a5:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
801088a9:	83 7d d8 1d          	cmpl   $0x1d,-0x28(%ebp)
801088ad:	0f 8e 98 fe ff ff    	jle    8010874b <APCharacterInit+0x1e2>
        for(int i=5;i<40;i++)
            character_img[i][j] = RGB(0xff,0x00,0x00);

    line=line+3;

    for(int j=line;j<line+3;j++){
801088b3:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
801088b7:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801088bd:	83 c0 03             	add    $0x3,%eax
801088c0:	3b 45 dc             	cmp    -0x24(%ebp),%eax
801088c3:	0f 8f 76 fe ff ff    	jg     8010873f <APCharacterInit+0x1d6>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=26&&i<30)
			character_img[i][j] = RGB(249,236,236);

        }}
line=line+3;
801088c9:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
801088d0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801088d6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801088d9:	e9 2c 02 00 00       	jmp    80108b0a <APCharacterInit+0x5a1>
	for(int i=0;i<40;i++){
801088de:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
801088e5:	e9 12 02 00 00       	jmp    80108afc <APCharacterInit+0x593>
               if(i<5)
801088ea:	83 7d d0 04          	cmpl   $0x4,-0x30(%ebp)
801088ee:	7f 4b                	jg     8010893b <APCharacterInit+0x3d2>
			character_img[i][j] = RGB(128,64,0);
801088f0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801088f3:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801088f6:	89 d0                	mov    %edx,%eax
801088f8:	01 c0                	add    %eax,%eax
801088fa:	01 d0                	add    %edx,%eax
801088fc:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108902:	01 d0                	add    %edx,%eax
80108904:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010890a:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108910:	6a 00                	push   $0x0
80108912:	6a 40                	push   $0x40
80108914:	68 80 00 00 00       	push   $0x80
80108919:	50                   	push   %eax
8010891a:	e8 25 fa ff ff       	call   80108344 <RGB>
8010891f:	83 c4 0c             	add    $0xc,%esp
80108922:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108929:	66 89 03             	mov    %ax,(%ebx)
8010892c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108933:	88 43 02             	mov    %al,0x2(%ebx)
80108936:	e9 bd 01 00 00       	jmp    80108af8 <APCharacterInit+0x58f>
		else if(i>=5&&i<10)
8010893b:	83 7d d0 04          	cmpl   $0x4,-0x30(%ebp)
8010893f:	7e 57                	jle    80108998 <APCharacterInit+0x42f>
80108941:	83 7d d0 09          	cmpl   $0x9,-0x30(%ebp)
80108945:	7f 51                	jg     80108998 <APCharacterInit+0x42f>
			character_img[i][j] = RGB(249,236,236);
80108947:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010894a:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010894d:	89 d0                	mov    %edx,%eax
8010894f:	01 c0                	add    %eax,%eax
80108951:	01 d0                	add    %edx,%eax
80108953:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108959:	01 d0                	add    %edx,%eax
8010895b:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108961:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108967:	68 ec 00 00 00       	push   $0xec
8010896c:	68 ec 00 00 00       	push   $0xec
80108971:	68 f9 00 00 00       	push   $0xf9
80108976:	50                   	push   %eax
80108977:	e8 c8 f9 ff ff       	call   80108344 <RGB>
8010897c:	83 c4 0c             	add    $0xc,%esp
8010897f:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108986:	66 89 03             	mov    %ax,(%ebx)
80108989:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108990:	88 43 02             	mov    %al,0x2(%ebx)
80108993:	e9 60 01 00 00       	jmp    80108af8 <APCharacterInit+0x58f>
		else if(i>=10&&i<13)
80108998:	83 7d d0 09          	cmpl   $0x9,-0x30(%ebp)
8010899c:	7e 51                	jle    801089ef <APCharacterInit+0x486>
8010899e:	83 7d d0 0c          	cmpl   $0xc,-0x30(%ebp)
801089a2:	7f 4b                	jg     801089ef <APCharacterInit+0x486>
			character_img[i][j] = RGB(128,64,0);
801089a4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801089a7:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801089aa:	89 d0                	mov    %edx,%eax
801089ac:	01 c0                	add    %eax,%eax
801089ae:	01 d0                	add    %edx,%eax
801089b0:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801089b6:	01 d0                	add    %edx,%eax
801089b8:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801089be:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801089c4:	6a 00                	push   $0x0
801089c6:	6a 40                	push   $0x40
801089c8:	68 80 00 00 00       	push   $0x80
801089cd:	50                   	push   %eax
801089ce:	e8 71 f9 ff ff       	call   80108344 <RGB>
801089d3:	83 c4 0c             	add    $0xc,%esp
801089d6:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801089dd:	66 89 03             	mov    %ax,(%ebx)
801089e0:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801089e7:	88 43 02             	mov    %al,0x2(%ebx)
801089ea:	e9 09 01 00 00       	jmp    80108af8 <APCharacterInit+0x58f>
		else if(i>=13&&i<22)
801089ef:	83 7d d0 0c          	cmpl   $0xc,-0x30(%ebp)
801089f3:	7e 57                	jle    80108a4c <APCharacterInit+0x4e3>
801089f5:	83 7d d0 15          	cmpl   $0x15,-0x30(%ebp)
801089f9:	7f 51                	jg     80108a4c <APCharacterInit+0x4e3>
			character_img[i][j] = RGB(249,236,236);
801089fb:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801089fe:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80108a01:	89 d0                	mov    %edx,%eax
80108a03:	01 c0                	add    %eax,%eax
80108a05:	01 d0                	add    %edx,%eax
80108a07:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108a0d:	01 d0                	add    %edx,%eax
80108a0f:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108a15:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108a1b:	68 ec 00 00 00       	push   $0xec
80108a20:	68 ec 00 00 00       	push   $0xec
80108a25:	68 f9 00 00 00       	push   $0xf9
80108a2a:	50                   	push   %eax
80108a2b:	e8 14 f9 ff ff       	call   80108344 <RGB>
80108a30:	83 c4 0c             	add    $0xc,%esp
80108a33:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108a3a:	66 89 03             	mov    %ax,(%ebx)
80108a3d:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108a44:	88 43 02             	mov    %al,0x2(%ebx)
80108a47:	e9 ac 00 00 00       	jmp    80108af8 <APCharacterInit+0x58f>
		else if(i>=22&&i<26)
80108a4c:	83 7d d0 15          	cmpl   $0x15,-0x30(%ebp)
80108a50:	7e 4e                	jle    80108aa0 <APCharacterInit+0x537>
80108a52:	83 7d d0 19          	cmpl   $0x19,-0x30(%ebp)
80108a56:	7f 48                	jg     80108aa0 <APCharacterInit+0x537>
			character_img[i][j] = RGB(128,64,0);
80108a58:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80108a5b:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80108a5e:	89 d0                	mov    %edx,%eax
80108a60:	01 c0                	add    %eax,%eax
80108a62:	01 d0                	add    %edx,%eax
80108a64:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108a6a:	01 d0                	add    %edx,%eax
80108a6c:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108a72:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108a78:	6a 00                	push   $0x0
80108a7a:	6a 40                	push   $0x40
80108a7c:	68 80 00 00 00       	push   $0x80
80108a81:	50                   	push   %eax
80108a82:	e8 bd f8 ff ff       	call   80108344 <RGB>
80108a87:	83 c4 0c             	add    $0xc,%esp
80108a8a:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108a91:	66 89 03             	mov    %ax,(%ebx)
80108a94:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108a9b:	88 43 02             	mov    %al,0x2(%ebx)
80108a9e:	eb 58                	jmp    80108af8 <APCharacterInit+0x58f>
		else if(i>=26&&i<35)
80108aa0:	83 7d d0 19          	cmpl   $0x19,-0x30(%ebp)
80108aa4:	7e 52                	jle    80108af8 <APCharacterInit+0x58f>
80108aa6:	83 7d d0 22          	cmpl   $0x22,-0x30(%ebp)
80108aaa:	7f 4c                	jg     80108af8 <APCharacterInit+0x58f>
			character_img[i][j] = RGB(249,236,236);
80108aac:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80108aaf:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80108ab2:	89 d0                	mov    %edx,%eax
80108ab4:	01 c0                	add    %eax,%eax
80108ab6:	01 d0                	add    %edx,%eax
80108ab8:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108abe:	01 d0                	add    %edx,%eax
80108ac0:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108ac6:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108acc:	68 ec 00 00 00       	push   $0xec
80108ad1:	68 ec 00 00 00       	push   $0xec
80108ad6:	68 f9 00 00 00       	push   $0xf9
80108adb:	50                   	push   %eax
80108adc:	e8 63 f8 ff ff       	call   80108344 <RGB>
80108ae1:	83 c4 0c             	add    $0xc,%esp
80108ae4:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108aeb:	66 89 03             	mov    %ax,(%ebx)
80108aee:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108af5:	88 43 02             	mov    %al,0x2(%ebx)
			character_img[i][j] = RGB(249,236,236);

        }}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80108af8:	83 45 d0 01          	addl   $0x1,-0x30(%ebp)
80108afc:	83 7d d0 27          	cmpl   $0x27,-0x30(%ebp)
80108b00:	0f 8e e4 fd ff ff    	jle    801088ea <APCharacterInit+0x381>
		else if(i>=26&&i<30)
			character_img[i][j] = RGB(249,236,236);

        }}
line=line+3;
  for(int j=line;j<line+3;j++){
80108b06:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
80108b0a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108b10:	83 c0 03             	add    $0x3,%eax
80108b13:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
80108b16:	0f 8f c2 fd ff ff    	jg     801088de <APCharacterInit+0x375>
		else if(i>=22&&i<26)
			character_img[i][j] = RGB(128,64,0);
		else if(i>=26&&i<35)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
80108b1c:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108b23:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108b29:	89 45 cc             	mov    %eax,-0x34(%ebp)
80108b2c:	e9 2c 02 00 00       	jmp    80108d5d <APCharacterInit+0x7f4>
	for(int i=0;i<44;i++){
80108b31:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
80108b38:	e9 12 02 00 00       	jmp    80108d4f <APCharacterInit+0x7e6>
               if(i<5)
80108b3d:	83 7d c8 04          	cmpl   $0x4,-0x38(%ebp)
80108b41:	7f 4b                	jg     80108b8e <APCharacterInit+0x625>
			character_img[i][j] = RGB(128,64,0);
80108b43:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108b46:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108b49:	89 d0                	mov    %edx,%eax
80108b4b:	01 c0                	add    %eax,%eax
80108b4d:	01 d0                	add    %edx,%eax
80108b4f:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108b55:	01 d0                	add    %edx,%eax
80108b57:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108b5d:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108b63:	6a 00                	push   $0x0
80108b65:	6a 40                	push   $0x40
80108b67:	68 80 00 00 00       	push   $0x80
80108b6c:	50                   	push   %eax
80108b6d:	e8 d2 f7 ff ff       	call   80108344 <RGB>
80108b72:	83 c4 0c             	add    $0xc,%esp
80108b75:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108b7c:	66 89 03             	mov    %ax,(%ebx)
80108b7f:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108b86:	88 43 02             	mov    %al,0x2(%ebx)
80108b89:	e9 bd 01 00 00       	jmp    80108d4b <APCharacterInit+0x7e2>
		else if(i>=5&&i<10)
80108b8e:	83 7d c8 04          	cmpl   $0x4,-0x38(%ebp)
80108b92:	7e 57                	jle    80108beb <APCharacterInit+0x682>
80108b94:	83 7d c8 09          	cmpl   $0x9,-0x38(%ebp)
80108b98:	7f 51                	jg     80108beb <APCharacterInit+0x682>
			character_img[i][j] = RGB(249,236,236);
80108b9a:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108b9d:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108ba0:	89 d0                	mov    %edx,%eax
80108ba2:	01 c0                	add    %eax,%eax
80108ba4:	01 d0                	add    %edx,%eax
80108ba6:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108bac:	01 d0                	add    %edx,%eax
80108bae:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108bb4:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108bba:	68 ec 00 00 00       	push   $0xec
80108bbf:	68 ec 00 00 00       	push   $0xec
80108bc4:	68 f9 00 00 00       	push   $0xf9
80108bc9:	50                   	push   %eax
80108bca:	e8 75 f7 ff ff       	call   80108344 <RGB>
80108bcf:	83 c4 0c             	add    $0xc,%esp
80108bd2:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108bd9:	66 89 03             	mov    %ax,(%ebx)
80108bdc:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108be3:	88 43 02             	mov    %al,0x2(%ebx)
80108be6:	e9 60 01 00 00       	jmp    80108d4b <APCharacterInit+0x7e2>
		else if(i>=10&&i<16)
80108beb:	83 7d c8 09          	cmpl   $0x9,-0x38(%ebp)
80108bef:	7e 51                	jle    80108c42 <APCharacterInit+0x6d9>
80108bf1:	83 7d c8 0f          	cmpl   $0xf,-0x38(%ebp)
80108bf5:	7f 4b                	jg     80108c42 <APCharacterInit+0x6d9>
			character_img[i][j] = RGB(128,64,0);
80108bf7:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108bfa:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108bfd:	89 d0                	mov    %edx,%eax
80108bff:	01 c0                	add    %eax,%eax
80108c01:	01 d0                	add    %edx,%eax
80108c03:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108c09:	01 d0                	add    %edx,%eax
80108c0b:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108c11:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108c17:	6a 00                	push   $0x0
80108c19:	6a 40                	push   $0x40
80108c1b:	68 80 00 00 00       	push   $0x80
80108c20:	50                   	push   %eax
80108c21:	e8 1e f7 ff ff       	call   80108344 <RGB>
80108c26:	83 c4 0c             	add    $0xc,%esp
80108c29:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108c30:	66 89 03             	mov    %ax,(%ebx)
80108c33:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108c3a:	88 43 02             	mov    %al,0x2(%ebx)
80108c3d:	e9 09 01 00 00       	jmp    80108d4b <APCharacterInit+0x7e2>
		else if(i>=16&&i<26)
80108c42:	83 7d c8 0f          	cmpl   $0xf,-0x38(%ebp)
80108c46:	7e 57                	jle    80108c9f <APCharacterInit+0x736>
80108c48:	83 7d c8 19          	cmpl   $0x19,-0x38(%ebp)
80108c4c:	7f 51                	jg     80108c9f <APCharacterInit+0x736>
			character_img[i][j] = RGB(249,236,236);
80108c4e:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108c51:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108c54:	89 d0                	mov    %edx,%eax
80108c56:	01 c0                	add    %eax,%eax
80108c58:	01 d0                	add    %edx,%eax
80108c5a:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108c60:	01 d0                	add    %edx,%eax
80108c62:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108c68:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108c6e:	68 ec 00 00 00       	push   $0xec
80108c73:	68 ec 00 00 00       	push   $0xec
80108c78:	68 f9 00 00 00       	push   $0xf9
80108c7d:	50                   	push   %eax
80108c7e:	e8 c1 f6 ff ff       	call   80108344 <RGB>
80108c83:	83 c4 0c             	add    $0xc,%esp
80108c86:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108c8d:	66 89 03             	mov    %ax,(%ebx)
80108c90:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108c97:	88 43 02             	mov    %al,0x2(%ebx)
80108c9a:	e9 ac 00 00 00       	jmp    80108d4b <APCharacterInit+0x7e2>
		else if(i>=26&&i<30)
80108c9f:	83 7d c8 19          	cmpl   $0x19,-0x38(%ebp)
80108ca3:	7e 4e                	jle    80108cf3 <APCharacterInit+0x78a>
80108ca5:	83 7d c8 1d          	cmpl   $0x1d,-0x38(%ebp)
80108ca9:	7f 48                	jg     80108cf3 <APCharacterInit+0x78a>
			character_img[i][j] = RGB(128,64,0);
80108cab:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108cae:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108cb1:	89 d0                	mov    %edx,%eax
80108cb3:	01 c0                	add    %eax,%eax
80108cb5:	01 d0                	add    %edx,%eax
80108cb7:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108cbd:	01 d0                	add    %edx,%eax
80108cbf:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108cc5:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108ccb:	6a 00                	push   $0x0
80108ccd:	6a 40                	push   $0x40
80108ccf:	68 80 00 00 00       	push   $0x80
80108cd4:	50                   	push   %eax
80108cd5:	e8 6a f6 ff ff       	call   80108344 <RGB>
80108cda:	83 c4 0c             	add    $0xc,%esp
80108cdd:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108ce4:	66 89 03             	mov    %ax,(%ebx)
80108ce7:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108cee:	88 43 02             	mov    %al,0x2(%ebx)
80108cf1:	eb 58                	jmp    80108d4b <APCharacterInit+0x7e2>
		else if(i>=30&&i<40)
80108cf3:	83 7d c8 1d          	cmpl   $0x1d,-0x38(%ebp)
80108cf7:	7e 52                	jle    80108d4b <APCharacterInit+0x7e2>
80108cf9:	83 7d c8 27          	cmpl   $0x27,-0x38(%ebp)
80108cfd:	7f 4c                	jg     80108d4b <APCharacterInit+0x7e2>
			character_img[i][j] = RGB(249,236,236);
80108cff:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108d02:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108d05:	89 d0                	mov    %edx,%eax
80108d07:	01 c0                	add    %eax,%eax
80108d09:	01 d0                	add    %edx,%eax
80108d0b:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108d11:	01 d0                	add    %edx,%eax
80108d13:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108d19:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108d1f:	68 ec 00 00 00       	push   $0xec
80108d24:	68 ec 00 00 00       	push   $0xec
80108d29:	68 f9 00 00 00       	push   $0xf9
80108d2e:	50                   	push   %eax
80108d2f:	e8 10 f6 ff ff       	call   80108344 <RGB>
80108d34:	83 c4 0c             	add    $0xc,%esp
80108d37:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108d3e:	66 89 03             	mov    %ax,(%ebx)
80108d41:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108d48:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=26&&i<35)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<44;i++){
80108d4b:	83 45 c8 01          	addl   $0x1,-0x38(%ebp)
80108d4f:	83 7d c8 2b          	cmpl   $0x2b,-0x38(%ebp)
80108d53:	0f 8e e4 fd ff ff    	jle    80108b3d <APCharacterInit+0x5d4>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=26&&i<35)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
80108d59:	83 45 cc 01          	addl   $0x1,-0x34(%ebp)
80108d5d:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108d63:	83 c0 03             	add    $0x3,%eax
80108d66:	3b 45 cc             	cmp    -0x34(%ebp),%eax
80108d69:	0f 8f c2 fd ff ff    	jg     80108b31 <APCharacterInit+0x5c8>
		else if(i>=26&&i<30)
			character_img[i][j] = RGB(128,64,0);
		else if(i>=30&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
80108d6f:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108d76:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108d7c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80108d7f:	e9 1b 01 00 00       	jmp    80108e9f <APCharacterInit+0x936>
	for(int i=0;i<40;i++){
80108d84:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
80108d8b:	e9 01 01 00 00       	jmp    80108e91 <APCharacterInit+0x928>
               if(i<10)
80108d90:	83 7d c0 09          	cmpl   $0x9,-0x40(%ebp)
80108d94:	7f 4b                	jg     80108de1 <APCharacterInit+0x878>
			character_img[i][j] = RGB(128,64,0);
80108d96:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80108d99:	8b 4d c0             	mov    -0x40(%ebp),%ecx
80108d9c:	89 d0                	mov    %edx,%eax
80108d9e:	01 c0                	add    %eax,%eax
80108da0:	01 d0                	add    %edx,%eax
80108da2:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108da8:	01 d0                	add    %edx,%eax
80108daa:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108db0:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108db6:	6a 00                	push   $0x0
80108db8:	6a 40                	push   $0x40
80108dba:	68 80 00 00 00       	push   $0x80
80108dbf:	50                   	push   %eax
80108dc0:	e8 7f f5 ff ff       	call   80108344 <RGB>
80108dc5:	83 c4 0c             	add    $0xc,%esp
80108dc8:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108dcf:	66 89 03             	mov    %ax,(%ebx)
80108dd2:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108dd9:	88 43 02             	mov    %al,0x2(%ebx)
80108ddc:	e9 ac 00 00 00       	jmp    80108e8d <APCharacterInit+0x924>
		else if(i>=10&&i<22)
80108de1:	83 7d c0 09          	cmpl   $0x9,-0x40(%ebp)
80108de5:	7e 54                	jle    80108e3b <APCharacterInit+0x8d2>
80108de7:	83 7d c0 15          	cmpl   $0x15,-0x40(%ebp)
80108deb:	7f 4e                	jg     80108e3b <APCharacterInit+0x8d2>
			character_img[i][j] = RGB(249,236,236);
80108ded:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80108df0:	8b 4d c0             	mov    -0x40(%ebp),%ecx
80108df3:	89 d0                	mov    %edx,%eax
80108df5:	01 c0                	add    %eax,%eax
80108df7:	01 d0                	add    %edx,%eax
80108df9:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108dff:	01 d0                	add    %edx,%eax
80108e01:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108e07:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108e0d:	68 ec 00 00 00       	push   $0xec
80108e12:	68 ec 00 00 00       	push   $0xec
80108e17:	68 f9 00 00 00       	push   $0xf9
80108e1c:	50                   	push   %eax
80108e1d:	e8 22 f5 ff ff       	call   80108344 <RGB>
80108e22:	83 c4 0c             	add    $0xc,%esp
80108e25:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108e2c:	66 89 03             	mov    %ax,(%ebx)
80108e2f:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108e36:	88 43 02             	mov    %al,0x2(%ebx)
80108e39:	eb 52                	jmp    80108e8d <APCharacterInit+0x924>
		else if(i>=22&&i<35)
80108e3b:	83 7d c0 15          	cmpl   $0x15,-0x40(%ebp)
80108e3f:	7e 4c                	jle    80108e8d <APCharacterInit+0x924>
80108e41:	83 7d c0 22          	cmpl   $0x22,-0x40(%ebp)
80108e45:	7f 46                	jg     80108e8d <APCharacterInit+0x924>
			character_img[i][j] = RGB(128,64,0);
80108e47:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80108e4a:	8b 4d c0             	mov    -0x40(%ebp),%ecx
80108e4d:	89 d0                	mov    %edx,%eax
80108e4f:	01 c0                	add    %eax,%eax
80108e51:	01 d0                	add    %edx,%eax
80108e53:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108e59:	01 d0                	add    %edx,%eax
80108e5b:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108e61:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108e67:	6a 00                	push   $0x0
80108e69:	6a 40                	push   $0x40
80108e6b:	68 80 00 00 00       	push   $0x80
80108e70:	50                   	push   %eax
80108e71:	e8 ce f4 ff ff       	call   80108344 <RGB>
80108e76:	83 c4 0c             	add    $0xc,%esp
80108e79:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108e80:	66 89 03             	mov    %ax,(%ebx)
80108e83:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108e8a:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=30&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80108e8d:	83 45 c0 01          	addl   $0x1,-0x40(%ebp)
80108e91:	83 7d c0 27          	cmpl   $0x27,-0x40(%ebp)
80108e95:	0f 8e f5 fe ff ff    	jle    80108d90 <APCharacterInit+0x827>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=30&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
80108e9b:	83 45 c4 01          	addl   $0x1,-0x3c(%ebp)
80108e9f:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108ea5:	83 c0 03             	add    $0x3,%eax
80108ea8:	3b 45 c4             	cmp    -0x3c(%ebp),%eax
80108eab:	0f 8f d3 fe ff ff    	jg     80108d84 <APCharacterInit+0x81b>
			character_img[i][j] = RGB(249,236,236);
		else if(i>=22&&i<35)
			character_img[i][j] = RGB(128,64,0);
		
}}
line=line+3;
80108eb1:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108eb8:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108ebe:	89 45 bc             	mov    %eax,-0x44(%ebp)
80108ec1:	eb 69                	jmp    80108f2c <APCharacterInit+0x9c3>
	for(int i=10;i<40;i++){
80108ec3:	c7 45 b8 0a 00 00 00 	movl   $0xa,-0x48(%ebp)
80108eca:	eb 56                	jmp    80108f22 <APCharacterInit+0x9b9>
               if(i<30)
80108ecc:	83 7d b8 1d          	cmpl   $0x1d,-0x48(%ebp)
80108ed0:	7f 4c                	jg     80108f1e <APCharacterInit+0x9b5>
			character_img[i][j] = RGB(249,236,236);
80108ed2:	8b 55 bc             	mov    -0x44(%ebp),%edx
80108ed5:	8b 4d b8             	mov    -0x48(%ebp),%ecx
80108ed8:	89 d0                	mov    %edx,%eax
80108eda:	01 c0                	add    %eax,%eax
80108edc:	01 d0                	add    %edx,%eax
80108ede:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108ee4:	01 d0                	add    %edx,%eax
80108ee6:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108eec:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108ef2:	68 ec 00 00 00       	push   $0xec
80108ef7:	68 ec 00 00 00       	push   $0xec
80108efc:	68 f9 00 00 00       	push   $0xf9
80108f01:	50                   	push   %eax
80108f02:	e8 3d f4 ff ff       	call   80108344 <RGB>
80108f07:	83 c4 0c             	add    $0xc,%esp
80108f0a:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108f11:	66 89 03             	mov    %ax,(%ebx)
80108f14:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108f1b:	88 43 02             	mov    %al,0x2(%ebx)
			character_img[i][j] = RGB(128,64,0);
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=10;i<40;i++){
80108f1e:	83 45 b8 01          	addl   $0x1,-0x48(%ebp)
80108f22:	83 7d b8 27          	cmpl   $0x27,-0x48(%ebp)
80108f26:	7e a4                	jle    80108ecc <APCharacterInit+0x963>
		else if(i>=22&&i<35)
			character_img[i][j] = RGB(128,64,0);
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
80108f28:	83 45 bc 01          	addl   $0x1,-0x44(%ebp)
80108f2c:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108f32:	83 c0 03             	add    $0x3,%eax
80108f35:	3b 45 bc             	cmp    -0x44(%ebp),%eax
80108f38:	7f 89                	jg     80108ec3 <APCharacterInit+0x95a>
               if(i<30)
			character_img[i][j] = RGB(249,236,236);
		
		
}}
line=line+3;
80108f3a:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108f41:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108f47:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80108f4a:	e9 15 01 00 00       	jmp    80109064 <APCharacterInit+0xafb>
	for(int i=5;i<40;i++){
80108f4f:	c7 45 b0 05 00 00 00 	movl   $0x5,-0x50(%ebp)
80108f56:	e9 fb 00 00 00       	jmp    80109056 <APCharacterInit+0xaed>
               if(i<11)
80108f5b:	83 7d b0 0a          	cmpl   $0xa,-0x50(%ebp)
80108f5f:	7f 4b                	jg     80108fac <APCharacterInit+0xa43>
			character_img[i][j] = RGB(128,64,0);
80108f61:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80108f64:	8b 4d b0             	mov    -0x50(%ebp),%ecx
80108f67:	89 d0                	mov    %edx,%eax
80108f69:	01 c0                	add    %eax,%eax
80108f6b:	01 d0                	add    %edx,%eax
80108f6d:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108f73:	01 d0                	add    %edx,%eax
80108f75:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108f7b:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108f81:	6a 00                	push   $0x0
80108f83:	6a 40                	push   $0x40
80108f85:	68 80 00 00 00       	push   $0x80
80108f8a:	50                   	push   %eax
80108f8b:	e8 b4 f3 ff ff       	call   80108344 <RGB>
80108f90:	83 c4 0c             	add    $0xc,%esp
80108f93:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108f9a:	66 89 03             	mov    %ax,(%ebx)
80108f9d:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108fa4:	88 43 02             	mov    %al,0x2(%ebx)
80108fa7:	e9 a6 00 00 00       	jmp    80109052 <APCharacterInit+0xae9>
		else if(i>=11&&i<14)
80108fac:	83 7d b0 0a          	cmpl   $0xa,-0x50(%ebp)
80108fb0:	7e 4e                	jle    80109000 <APCharacterInit+0xa97>
80108fb2:	83 7d b0 0d          	cmpl   $0xd,-0x50(%ebp)
80108fb6:	7f 48                	jg     80109000 <APCharacterInit+0xa97>
			character_img[i][j] = RGB(255,0,0);	
80108fb8:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80108fbb:	8b 4d b0             	mov    -0x50(%ebp),%ecx
80108fbe:	89 d0                	mov    %edx,%eax
80108fc0:	01 c0                	add    %eax,%eax
80108fc2:	01 d0                	add    %edx,%eax
80108fc4:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108fca:	01 d0                	add    %edx,%eax
80108fcc:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108fd2:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108fd8:	6a 00                	push   $0x0
80108fda:	6a 00                	push   $0x0
80108fdc:	68 ff 00 00 00       	push   $0xff
80108fe1:	50                   	push   %eax
80108fe2:	e8 5d f3 ff ff       	call   80108344 <RGB>
80108fe7:	83 c4 0c             	add    $0xc,%esp
80108fea:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108ff1:	66 89 03             	mov    %ax,(%ebx)
80108ff4:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108ffb:	88 43 02             	mov    %al,0x2(%ebx)
80108ffe:	eb 52                	jmp    80109052 <APCharacterInit+0xae9>
		else if(i>=14&&i<25)
80109000:	83 7d b0 0d          	cmpl   $0xd,-0x50(%ebp)
80109004:	7e 4c                	jle    80109052 <APCharacterInit+0xae9>
80109006:	83 7d b0 18          	cmpl   $0x18,-0x50(%ebp)
8010900a:	7f 46                	jg     80109052 <APCharacterInit+0xae9>
			character_img[i][j] = RGB(128,64,0);
8010900c:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010900f:	8b 4d b0             	mov    -0x50(%ebp),%ecx
80109012:	89 d0                	mov    %edx,%eax
80109014:	01 c0                	add    %eax,%eax
80109016:	01 d0                	add    %edx,%eax
80109018:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010901e:	01 d0                	add    %edx,%eax
80109020:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109026:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010902c:	6a 00                	push   $0x0
8010902e:	6a 40                	push   $0x40
80109030:	68 80 00 00 00       	push   $0x80
80109035:	50                   	push   %eax
80109036:	e8 09 f3 ff ff       	call   80108344 <RGB>
8010903b:	83 c4 0c             	add    $0xc,%esp
8010903e:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109045:	66 89 03             	mov    %ax,(%ebx)
80109048:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010904f:	88 43 02             	mov    %al,0x2(%ebx)
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=5;i<40;i++){
80109052:	83 45 b0 01          	addl   $0x1,-0x50(%ebp)
80109056:	83 7d b0 27          	cmpl   $0x27,-0x50(%ebp)
8010905a:	0f 8e fb fe ff ff    	jle    80108f5b <APCharacterInit+0x9f2>
			character_img[i][j] = RGB(249,236,236);
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
80109060:	83 45 b4 01          	addl   $0x1,-0x4c(%ebp)
80109064:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010906a:	83 c0 03             	add    $0x3,%eax
8010906d:	3b 45 b4             	cmp    -0x4c(%ebp),%eax
80109070:	0f 8f d9 fe ff ff    	jg     80108f4f <APCharacterInit+0x9e6>
		else if(i>=14&&i<25)
			character_img[i][j] = RGB(128,64,0);
		
		
}}
line=line+3;
80109076:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
8010907d:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109083:	89 45 ac             	mov    %eax,-0x54(%ebp)
80109086:	e9 c3 01 00 00       	jmp    8010924e <APCharacterInit+0xce5>
	for(int i=3;i<40;i++){
8010908b:	c7 45 a8 03 00 00 00 	movl   $0x3,-0x58(%ebp)
80109092:	e9 a9 01 00 00       	jmp    80109240 <APCharacterInit+0xcd7>
               if(i<11)
80109097:	83 7d a8 0a          	cmpl   $0xa,-0x58(%ebp)
8010909b:	7f 4b                	jg     801090e8 <APCharacterInit+0xb7f>
			character_img[i][j] = RGB(128,64,0);
8010909d:	8b 55 ac             	mov    -0x54(%ebp),%edx
801090a0:	8b 4d a8             	mov    -0x58(%ebp),%ecx
801090a3:	89 d0                	mov    %edx,%eax
801090a5:	01 c0                	add    %eax,%eax
801090a7:	01 d0                	add    %edx,%eax
801090a9:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801090af:	01 d0                	add    %edx,%eax
801090b1:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801090b7:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801090bd:	6a 00                	push   $0x0
801090bf:	6a 40                	push   $0x40
801090c1:	68 80 00 00 00       	push   $0x80
801090c6:	50                   	push   %eax
801090c7:	e8 78 f2 ff ff       	call   80108344 <RGB>
801090cc:	83 c4 0c             	add    $0xc,%esp
801090cf:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801090d6:	66 89 03             	mov    %ax,(%ebx)
801090d9:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801090e0:	88 43 02             	mov    %al,0x2(%ebx)
801090e3:	e9 54 01 00 00       	jmp    8010923c <APCharacterInit+0xcd3>
		else if(i>=11&&i<14)
801090e8:	83 7d a8 0a          	cmpl   $0xa,-0x58(%ebp)
801090ec:	7e 51                	jle    8010913f <APCharacterInit+0xbd6>
801090ee:	83 7d a8 0d          	cmpl   $0xd,-0x58(%ebp)
801090f2:	7f 4b                	jg     8010913f <APCharacterInit+0xbd6>
			character_img[i][j] = RGB(255,0,0);
801090f4:	8b 55 ac             	mov    -0x54(%ebp),%edx
801090f7:	8b 4d a8             	mov    -0x58(%ebp),%ecx
801090fa:	89 d0                	mov    %edx,%eax
801090fc:	01 c0                	add    %eax,%eax
801090fe:	01 d0                	add    %edx,%eax
80109100:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109106:	01 d0                	add    %edx,%eax
80109108:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010910e:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109114:	6a 00                	push   $0x0
80109116:	6a 00                	push   $0x0
80109118:	68 ff 00 00 00       	push   $0xff
8010911d:	50                   	push   %eax
8010911e:	e8 21 f2 ff ff       	call   80108344 <RGB>
80109123:	83 c4 0c             	add    $0xc,%esp
80109126:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010912d:	66 89 03             	mov    %ax,(%ebx)
80109130:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109137:	88 43 02             	mov    %al,0x2(%ebx)
8010913a:	e9 fd 00 00 00       	jmp    8010923c <APCharacterInit+0xcd3>
		else if(i>=14&&i<22)
8010913f:	83 7d a8 0d          	cmpl   $0xd,-0x58(%ebp)
80109143:	7e 51                	jle    80109196 <APCharacterInit+0xc2d>
80109145:	83 7d a8 15          	cmpl   $0x15,-0x58(%ebp)
80109149:	7f 4b                	jg     80109196 <APCharacterInit+0xc2d>
			character_img[i][j] = RGB(128,64,0);
8010914b:	8b 55 ac             	mov    -0x54(%ebp),%edx
8010914e:	8b 4d a8             	mov    -0x58(%ebp),%ecx
80109151:	89 d0                	mov    %edx,%eax
80109153:	01 c0                	add    %eax,%eax
80109155:	01 d0                	add    %edx,%eax
80109157:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010915d:	01 d0                	add    %edx,%eax
8010915f:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109165:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010916b:	6a 00                	push   $0x0
8010916d:	6a 40                	push   $0x40
8010916f:	68 80 00 00 00       	push   $0x80
80109174:	50                   	push   %eax
80109175:	e8 ca f1 ff ff       	call   80108344 <RGB>
8010917a:	83 c4 0c             	add    $0xc,%esp
8010917d:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109184:	66 89 03             	mov    %ax,(%ebx)
80109187:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010918e:	88 43 02             	mov    %al,0x2(%ebx)
80109191:	e9 a6 00 00 00       	jmp    8010923c <APCharacterInit+0xcd3>
		else if(i>=22&&i<25)
80109196:	83 7d a8 15          	cmpl   $0x15,-0x58(%ebp)
8010919a:	7e 4e                	jle    801091ea <APCharacterInit+0xc81>
8010919c:	83 7d a8 18          	cmpl   $0x18,-0x58(%ebp)
801091a0:	7f 48                	jg     801091ea <APCharacterInit+0xc81>
			character_img[i][j] = RGB(255,0,0);
801091a2:	8b 55 ac             	mov    -0x54(%ebp),%edx
801091a5:	8b 4d a8             	mov    -0x58(%ebp),%ecx
801091a8:	89 d0                	mov    %edx,%eax
801091aa:	01 c0                	add    %eax,%eax
801091ac:	01 d0                	add    %edx,%eax
801091ae:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801091b4:	01 d0                	add    %edx,%eax
801091b6:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801091bc:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801091c2:	6a 00                	push   $0x0
801091c4:	6a 00                	push   $0x0
801091c6:	68 ff 00 00 00       	push   $0xff
801091cb:	50                   	push   %eax
801091cc:	e8 73 f1 ff ff       	call   80108344 <RGB>
801091d1:	83 c4 0c             	add    $0xc,%esp
801091d4:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801091db:	66 89 03             	mov    %ax,(%ebx)
801091de:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801091e5:	88 43 02             	mov    %al,0x2(%ebx)
801091e8:	eb 52                	jmp    8010923c <APCharacterInit+0xcd3>
		else if(i>=25&&i<35)
801091ea:	83 7d a8 18          	cmpl   $0x18,-0x58(%ebp)
801091ee:	7e 4c                	jle    8010923c <APCharacterInit+0xcd3>
801091f0:	83 7d a8 22          	cmpl   $0x22,-0x58(%ebp)
801091f4:	7f 46                	jg     8010923c <APCharacterInit+0xcd3>
			character_img[i][j] = RGB(128,64,0);
801091f6:	8b 55 ac             	mov    -0x54(%ebp),%edx
801091f9:	8b 4d a8             	mov    -0x58(%ebp),%ecx
801091fc:	89 d0                	mov    %edx,%eax
801091fe:	01 c0                	add    %eax,%eax
80109200:	01 d0                	add    %edx,%eax
80109202:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109208:	01 d0                	add    %edx,%eax
8010920a:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109210:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109216:	6a 00                	push   $0x0
80109218:	6a 40                	push   $0x40
8010921a:	68 80 00 00 00       	push   $0x80
8010921f:	50                   	push   %eax
80109220:	e8 1f f1 ff ff       	call   80108344 <RGB>
80109225:	83 c4 0c             	add    $0xc,%esp
80109228:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010922f:	66 89 03             	mov    %ax,(%ebx)
80109232:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109239:	88 43 02             	mov    %al,0x2(%ebx)
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=3;i<40;i++){
8010923c:	83 45 a8 01          	addl   $0x1,-0x58(%ebp)
80109240:	83 7d a8 27          	cmpl   $0x27,-0x58(%ebp)
80109244:	0f 8e 4d fe ff ff    	jle    80109097 <APCharacterInit+0xb2e>
			character_img[i][j] = RGB(128,64,0);
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
8010924a:	83 45 ac 01          	addl   $0x1,-0x54(%ebp)
8010924e:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109254:	83 c0 03             	add    $0x3,%eax
80109257:	3b 45 ac             	cmp    -0x54(%ebp),%eax
8010925a:	0f 8f 2b fe ff ff    	jg     8010908b <APCharacterInit+0xb22>
		else if(i>=22&&i<25)
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<35)
			character_img[i][j] = RGB(128,64,0);
        
    }}line=line+3;
80109260:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80109267:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010926d:	89 45 a4             	mov    %eax,-0x5c(%ebp)
80109270:	e9 15 01 00 00       	jmp    8010938a <APCharacterInit+0xe21>
	for(int i=0;i<40;i++){
80109275:	c7 45 a0 00 00 00 00 	movl   $0x0,-0x60(%ebp)
8010927c:	e9 fb 00 00 00       	jmp    8010937c <APCharacterInit+0xe13>
               if(i<11)
80109281:	83 7d a0 0a          	cmpl   $0xa,-0x60(%ebp)
80109285:	7f 4b                	jg     801092d2 <APCharacterInit+0xd69>
			character_img[i][j] = RGB(128,64,0);
80109287:	8b 55 a4             	mov    -0x5c(%ebp),%edx
8010928a:	8b 4d a0             	mov    -0x60(%ebp),%ecx
8010928d:	89 d0                	mov    %edx,%eax
8010928f:	01 c0                	add    %eax,%eax
80109291:	01 d0                	add    %edx,%eax
80109293:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109299:	01 d0                	add    %edx,%eax
8010929b:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801092a1:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801092a7:	6a 00                	push   $0x0
801092a9:	6a 40                	push   $0x40
801092ab:	68 80 00 00 00       	push   $0x80
801092b0:	50                   	push   %eax
801092b1:	e8 8e f0 ff ff       	call   80108344 <RGB>
801092b6:	83 c4 0c             	add    $0xc,%esp
801092b9:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801092c0:	66 89 03             	mov    %ax,(%ebx)
801092c3:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801092ca:	88 43 02             	mov    %al,0x2(%ebx)
801092cd:	e9 a6 00 00 00       	jmp    80109378 <APCharacterInit+0xe0f>
		else if(i>=11&&i<25)
801092d2:	83 7d a0 0a          	cmpl   $0xa,-0x60(%ebp)
801092d6:	7e 4e                	jle    80109326 <APCharacterInit+0xdbd>
801092d8:	83 7d a0 18          	cmpl   $0x18,-0x60(%ebp)
801092dc:	7f 48                	jg     80109326 <APCharacterInit+0xdbd>
			character_img[i][j] = RGB(255,0,0);
801092de:	8b 55 a4             	mov    -0x5c(%ebp),%edx
801092e1:	8b 4d a0             	mov    -0x60(%ebp),%ecx
801092e4:	89 d0                	mov    %edx,%eax
801092e6:	01 c0                	add    %eax,%eax
801092e8:	01 d0                	add    %edx,%eax
801092ea:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801092f0:	01 d0                	add    %edx,%eax
801092f2:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801092f8:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801092fe:	6a 00                	push   $0x0
80109300:	6a 00                	push   $0x0
80109302:	68 ff 00 00 00       	push   $0xff
80109307:	50                   	push   %eax
80109308:	e8 37 f0 ff ff       	call   80108344 <RGB>
8010930d:	83 c4 0c             	add    $0xc,%esp
80109310:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109317:	66 89 03             	mov    %ax,(%ebx)
8010931a:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109321:	88 43 02             	mov    %al,0x2(%ebx)
80109324:	eb 52                	jmp    80109378 <APCharacterInit+0xe0f>
		else if(i>=25&&i<40)
80109326:	83 7d a0 18          	cmpl   $0x18,-0x60(%ebp)
8010932a:	7e 4c                	jle    80109378 <APCharacterInit+0xe0f>
8010932c:	83 7d a0 27          	cmpl   $0x27,-0x60(%ebp)
80109330:	7f 46                	jg     80109378 <APCharacterInit+0xe0f>
			character_img[i][j] = RGB(128,64,0);
80109332:	8b 55 a4             	mov    -0x5c(%ebp),%edx
80109335:	8b 4d a0             	mov    -0x60(%ebp),%ecx
80109338:	89 d0                	mov    %edx,%eax
8010933a:	01 c0                	add    %eax,%eax
8010933c:	01 d0                	add    %edx,%eax
8010933e:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109344:	01 d0                	add    %edx,%eax
80109346:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010934c:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109352:	6a 00                	push   $0x0
80109354:	6a 40                	push   $0x40
80109356:	68 80 00 00 00       	push   $0x80
8010935b:	50                   	push   %eax
8010935c:	e8 e3 ef ff ff       	call   80108344 <RGB>
80109361:	83 c4 0c             	add    $0xc,%esp
80109364:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010936b:	66 89 03             	mov    %ax,(%ebx)
8010936e:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109375:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=25&&i<35)
			character_img[i][j] = RGB(128,64,0);
        
    }}line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109378:	83 45 a0 01          	addl   $0x1,-0x60(%ebp)
8010937c:	83 7d a0 27          	cmpl   $0x27,-0x60(%ebp)
80109380:	0f 8e fb fe ff ff    	jle    80109281 <APCharacterInit+0xd18>
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<35)
			character_img[i][j] = RGB(128,64,0);
        
    }}line=line+3;
  for(int j=line;j<line+3;j++){
80109386:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
8010938a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109390:	83 c0 03             	add    $0x3,%eax
80109393:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
80109396:	0f 8f d9 fe ff ff    	jg     80109275 <APCharacterInit+0xd0c>
		else if(i>=11&&i<25)
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<40)
			character_img[i][j] = RGB(128,64,0);
}}
line =line +3;
8010939c:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
801093a3:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801093a9:	89 45 9c             	mov    %eax,-0x64(%ebp)
801093ac:	e9 37 03 00 00       	jmp    801096e8 <APCharacterInit+0x117f>
	for(int i=0;i<40;i++){
801093b1:	c7 45 98 00 00 00 00 	movl   $0x0,-0x68(%ebp)
801093b8:	e9 1d 03 00 00       	jmp    801096da <APCharacterInit+0x1171>
               if(i<5)
801093bd:	83 7d 98 04          	cmpl   $0x4,-0x68(%ebp)
801093c1:	7f 51                	jg     80109414 <APCharacterInit+0xeab>
			character_img[i][j] = RGB(249,236,236);
801093c3:	8b 55 9c             	mov    -0x64(%ebp),%edx
801093c6:	8b 4d 98             	mov    -0x68(%ebp),%ecx
801093c9:	89 d0                	mov    %edx,%eax
801093cb:	01 c0                	add    %eax,%eax
801093cd:	01 d0                	add    %edx,%eax
801093cf:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801093d5:	01 d0                	add    %edx,%eax
801093d7:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801093dd:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801093e3:	68 ec 00 00 00       	push   $0xec
801093e8:	68 ec 00 00 00       	push   $0xec
801093ed:	68 f9 00 00 00       	push   $0xf9
801093f2:	50                   	push   %eax
801093f3:	e8 4c ef ff ff       	call   80108344 <RGB>
801093f8:	83 c4 0c             	add    $0xc,%esp
801093fb:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109402:	66 89 03             	mov    %ax,(%ebx)
80109405:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010940c:	88 43 02             	mov    %al,0x2(%ebx)
8010940f:	e9 c2 02 00 00       	jmp    801096d6 <APCharacterInit+0x116d>
		else if(i>=5&&i<8)
80109414:	83 7d 98 04          	cmpl   $0x4,-0x68(%ebp)
80109418:	7e 51                	jle    8010946b <APCharacterInit+0xf02>
8010941a:	83 7d 98 07          	cmpl   $0x7,-0x68(%ebp)
8010941e:	7f 4b                	jg     8010946b <APCharacterInit+0xf02>
			character_img[i][j] = RGB(128,64,0);
80109420:	8b 55 9c             	mov    -0x64(%ebp),%edx
80109423:	8b 4d 98             	mov    -0x68(%ebp),%ecx
80109426:	89 d0                	mov    %edx,%eax
80109428:	01 c0                	add    %eax,%eax
8010942a:	01 d0                	add    %edx,%eax
8010942c:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109432:	01 d0                	add    %edx,%eax
80109434:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010943a:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109440:	6a 00                	push   $0x0
80109442:	6a 40                	push   $0x40
80109444:	68 80 00 00 00       	push   $0x80
80109449:	50                   	push   %eax
8010944a:	e8 f5 ee ff ff       	call   80108344 <RGB>
8010944f:	83 c4 0c             	add    $0xc,%esp
80109452:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109459:	66 89 03             	mov    %ax,(%ebx)
8010945c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109463:	88 43 02             	mov    %al,0x2(%ebx)
80109466:	e9 6b 02 00 00       	jmp    801096d6 <APCharacterInit+0x116d>
		else if(i>=8&&i<11)
8010946b:	83 7d 98 07          	cmpl   $0x7,-0x68(%ebp)
8010946f:	7e 51                	jle    801094c2 <APCharacterInit+0xf59>
80109471:	83 7d 98 0a          	cmpl   $0xa,-0x68(%ebp)
80109475:	7f 4b                	jg     801094c2 <APCharacterInit+0xf59>
			character_img[i][j] = RGB(255,0,0);
80109477:	8b 55 9c             	mov    -0x64(%ebp),%edx
8010947a:	8b 4d 98             	mov    -0x68(%ebp),%ecx
8010947d:	89 d0                	mov    %edx,%eax
8010947f:	01 c0                	add    %eax,%eax
80109481:	01 d0                	add    %edx,%eax
80109483:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109489:	01 d0                	add    %edx,%eax
8010948b:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109491:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109497:	6a 00                	push   $0x0
80109499:	6a 00                	push   $0x0
8010949b:	68 ff 00 00 00       	push   $0xff
801094a0:	50                   	push   %eax
801094a1:	e8 9e ee ff ff       	call   80108344 <RGB>
801094a6:	83 c4 0c             	add    $0xc,%esp
801094a9:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801094b0:	66 89 03             	mov    %ax,(%ebx)
801094b3:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801094ba:	88 43 02             	mov    %al,0x2(%ebx)
801094bd:	e9 14 02 00 00       	jmp    801096d6 <APCharacterInit+0x116d>
		else if(i>=11&&i<14)
801094c2:	83 7d 98 0a          	cmpl   $0xa,-0x68(%ebp)
801094c6:	7e 57                	jle    8010951f <APCharacterInit+0xfb6>
801094c8:	83 7d 98 0d          	cmpl   $0xd,-0x68(%ebp)
801094cc:	7f 51                	jg     8010951f <APCharacterInit+0xfb6>
			character_img[i][j] = RGB(249,236,236);
801094ce:	8b 55 9c             	mov    -0x64(%ebp),%edx
801094d1:	8b 4d 98             	mov    -0x68(%ebp),%ecx
801094d4:	89 d0                	mov    %edx,%eax
801094d6:	01 c0                	add    %eax,%eax
801094d8:	01 d0                	add    %edx,%eax
801094da:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801094e0:	01 d0                	add    %edx,%eax
801094e2:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801094e8:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801094ee:	68 ec 00 00 00       	push   $0xec
801094f3:	68 ec 00 00 00       	push   $0xec
801094f8:	68 f9 00 00 00       	push   $0xf9
801094fd:	50                   	push   %eax
801094fe:	e8 41 ee ff ff       	call   80108344 <RGB>
80109503:	83 c4 0c             	add    $0xc,%esp
80109506:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010950d:	66 89 03             	mov    %ax,(%ebx)
80109510:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109517:	88 43 02             	mov    %al,0x2(%ebx)
8010951a:	e9 b7 01 00 00       	jmp    801096d6 <APCharacterInit+0x116d>
		else if(i>=14&&i<22)
8010951f:	83 7d 98 0d          	cmpl   $0xd,-0x68(%ebp)
80109523:	7e 51                	jle    80109576 <APCharacterInit+0x100d>
80109525:	83 7d 98 15          	cmpl   $0x15,-0x68(%ebp)
80109529:	7f 4b                	jg     80109576 <APCharacterInit+0x100d>
			character_img[i][j] = RGB(255,0,0);
8010952b:	8b 55 9c             	mov    -0x64(%ebp),%edx
8010952e:	8b 4d 98             	mov    -0x68(%ebp),%ecx
80109531:	89 d0                	mov    %edx,%eax
80109533:	01 c0                	add    %eax,%eax
80109535:	01 d0                	add    %edx,%eax
80109537:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010953d:	01 d0                	add    %edx,%eax
8010953f:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109545:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010954b:	6a 00                	push   $0x0
8010954d:	6a 00                	push   $0x0
8010954f:	68 ff 00 00 00       	push   $0xff
80109554:	50                   	push   %eax
80109555:	e8 ea ed ff ff       	call   80108344 <RGB>
8010955a:	83 c4 0c             	add    $0xc,%esp
8010955d:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109564:	66 89 03             	mov    %ax,(%ebx)
80109567:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010956e:	88 43 02             	mov    %al,0x2(%ebx)
80109571:	e9 60 01 00 00       	jmp    801096d6 <APCharacterInit+0x116d>
		else if(i>=22&&i<25)
80109576:	83 7d 98 15          	cmpl   $0x15,-0x68(%ebp)
8010957a:	7e 57                	jle    801095d3 <APCharacterInit+0x106a>
8010957c:	83 7d 98 18          	cmpl   $0x18,-0x68(%ebp)
80109580:	7f 51                	jg     801095d3 <APCharacterInit+0x106a>
			character_img[i][j] = RGB(249,236,236);
80109582:	8b 55 9c             	mov    -0x64(%ebp),%edx
80109585:	8b 4d 98             	mov    -0x68(%ebp),%ecx
80109588:	89 d0                	mov    %edx,%eax
8010958a:	01 c0                	add    %eax,%eax
8010958c:	01 d0                	add    %edx,%eax
8010958e:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109594:	01 d0                	add    %edx,%eax
80109596:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010959c:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801095a2:	68 ec 00 00 00       	push   $0xec
801095a7:	68 ec 00 00 00       	push   $0xec
801095ac:	68 f9 00 00 00       	push   $0xf9
801095b1:	50                   	push   %eax
801095b2:	e8 8d ed ff ff       	call   80108344 <RGB>
801095b7:	83 c4 0c             	add    $0xc,%esp
801095ba:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801095c1:	66 89 03             	mov    %ax,(%ebx)
801095c4:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801095cb:	88 43 02             	mov    %al,0x2(%ebx)
801095ce:	e9 03 01 00 00       	jmp    801096d6 <APCharacterInit+0x116d>
		else if(i>=25&&i<28)
801095d3:	83 7d 98 18          	cmpl   $0x18,-0x68(%ebp)
801095d7:	7e 51                	jle    8010962a <APCharacterInit+0x10c1>
801095d9:	83 7d 98 1b          	cmpl   $0x1b,-0x68(%ebp)
801095dd:	7f 4b                	jg     8010962a <APCharacterInit+0x10c1>
			character_img[i][j] = RGB(255,0,0);
801095df:	8b 55 9c             	mov    -0x64(%ebp),%edx
801095e2:	8b 4d 98             	mov    -0x68(%ebp),%ecx
801095e5:	89 d0                	mov    %edx,%eax
801095e7:	01 c0                	add    %eax,%eax
801095e9:	01 d0                	add    %edx,%eax
801095eb:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801095f1:	01 d0                	add    %edx,%eax
801095f3:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801095f9:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801095ff:	6a 00                	push   $0x0
80109601:	6a 00                	push   $0x0
80109603:	68 ff 00 00 00       	push   $0xff
80109608:	50                   	push   %eax
80109609:	e8 36 ed ff ff       	call   80108344 <RGB>
8010960e:	83 c4 0c             	add    $0xc,%esp
80109611:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109618:	66 89 03             	mov    %ax,(%ebx)
8010961b:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109622:	88 43 02             	mov    %al,0x2(%ebx)
80109625:	e9 ac 00 00 00       	jmp    801096d6 <APCharacterInit+0x116d>
		else if(i>=28&&i<32)
8010962a:	83 7d 98 1b          	cmpl   $0x1b,-0x68(%ebp)
8010962e:	7e 4e                	jle    8010967e <APCharacterInit+0x1115>
80109630:	83 7d 98 1f          	cmpl   $0x1f,-0x68(%ebp)
80109634:	7f 48                	jg     8010967e <APCharacterInit+0x1115>
			character_img[i][j] = RGB(128,64,0);
80109636:	8b 55 9c             	mov    -0x64(%ebp),%edx
80109639:	8b 4d 98             	mov    -0x68(%ebp),%ecx
8010963c:	89 d0                	mov    %edx,%eax
8010963e:	01 c0                	add    %eax,%eax
80109640:	01 d0                	add    %edx,%eax
80109642:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109648:	01 d0                	add    %edx,%eax
8010964a:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109650:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109656:	6a 00                	push   $0x0
80109658:	6a 40                	push   $0x40
8010965a:	68 80 00 00 00       	push   $0x80
8010965f:	50                   	push   %eax
80109660:	e8 df ec ff ff       	call   80108344 <RGB>
80109665:	83 c4 0c             	add    $0xc,%esp
80109668:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010966f:	66 89 03             	mov    %ax,(%ebx)
80109672:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109679:	88 43 02             	mov    %al,0x2(%ebx)
8010967c:	eb 58                	jmp    801096d6 <APCharacterInit+0x116d>
		else if(i>=32&&i<40)
8010967e:	83 7d 98 1f          	cmpl   $0x1f,-0x68(%ebp)
80109682:	7e 52                	jle    801096d6 <APCharacterInit+0x116d>
80109684:	83 7d 98 27          	cmpl   $0x27,-0x68(%ebp)
80109688:	7f 4c                	jg     801096d6 <APCharacterInit+0x116d>
			character_img[i][j] = RGB(249,236,236);
8010968a:	8b 55 9c             	mov    -0x64(%ebp),%edx
8010968d:	8b 4d 98             	mov    -0x68(%ebp),%ecx
80109690:	89 d0                	mov    %edx,%eax
80109692:	01 c0                	add    %eax,%eax
80109694:	01 d0                	add    %edx,%eax
80109696:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010969c:	01 d0                	add    %edx,%eax
8010969e:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801096a4:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801096aa:	68 ec 00 00 00       	push   $0xec
801096af:	68 ec 00 00 00       	push   $0xec
801096b4:	68 f9 00 00 00       	push   $0xf9
801096b9:	50                   	push   %eax
801096ba:	e8 85 ec ff ff       	call   80108344 <RGB>
801096bf:	83 c4 0c             	add    $0xc,%esp
801096c2:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801096c9:	66 89 03             	mov    %ax,(%ebx)
801096cc:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801096d3:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=25&&i<40)
			character_img[i][j] = RGB(128,64,0);
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
801096d6:	83 45 98 01          	addl   $0x1,-0x68(%ebp)
801096da:	83 7d 98 27          	cmpl   $0x27,-0x68(%ebp)
801096de:	0f 8e d9 fc ff ff    	jle    801093bd <APCharacterInit+0xe54>
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<40)
			character_img[i][j] = RGB(128,64,0);
}}
line =line +3;
for(int j=line;j<line+3;j++){
801096e4:	83 45 9c 01          	addl   $0x1,-0x64(%ebp)
801096e8:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801096ee:	83 c0 03             	add    $0x3,%eax
801096f1:	3b 45 9c             	cmp    -0x64(%ebp),%eax
801096f4:	0f 8f b7 fc ff ff    	jg     801093b1 <APCharacterInit+0xe48>
		else if(i>=28&&i<32)
			character_img[i][j] = RGB(128,64,0);
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line =line +3;
801096fa:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
80109701:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109707:	89 45 94             	mov    %eax,-0x6c(%ebp)
8010970a:	e9 21 01 00 00       	jmp    80109830 <APCharacterInit+0x12c7>
	for(int i=0;i<40;i++){
8010970f:	c7 45 90 00 00 00 00 	movl   $0x0,-0x70(%ebp)
80109716:	e9 07 01 00 00       	jmp    80109822 <APCharacterInit+0x12b9>
               if(i<8)
8010971b:	83 7d 90 07          	cmpl   $0x7,-0x70(%ebp)
8010971f:	7f 51                	jg     80109772 <APCharacterInit+0x1209>
			character_img[i][j] = RGB(249,236,236);
80109721:	8b 55 94             	mov    -0x6c(%ebp),%edx
80109724:	8b 4d 90             	mov    -0x70(%ebp),%ecx
80109727:	89 d0                	mov    %edx,%eax
80109729:	01 c0                	add    %eax,%eax
8010972b:	01 d0                	add    %edx,%eax
8010972d:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109733:	01 d0                	add    %edx,%eax
80109735:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010973b:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109741:	68 ec 00 00 00       	push   $0xec
80109746:	68 ec 00 00 00       	push   $0xec
8010974b:	68 f9 00 00 00       	push   $0xf9
80109750:	50                   	push   %eax
80109751:	e8 ee eb ff ff       	call   80108344 <RGB>
80109756:	83 c4 0c             	add    $0xc,%esp
80109759:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109760:	66 89 03             	mov    %ax,(%ebx)
80109763:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010976a:	88 43 02             	mov    %al,0x2(%ebx)
8010976d:	e9 ac 00 00 00       	jmp    8010981e <APCharacterInit+0x12b5>
		else if(i>=8&&i<28)
80109772:	83 7d 90 07          	cmpl   $0x7,-0x70(%ebp)
80109776:	7e 4e                	jle    801097c6 <APCharacterInit+0x125d>
80109778:	83 7d 90 1b          	cmpl   $0x1b,-0x70(%ebp)
8010977c:	7f 48                	jg     801097c6 <APCharacterInit+0x125d>
			character_img[i][j] = RGB(255,0,0);
8010977e:	8b 55 94             	mov    -0x6c(%ebp),%edx
80109781:	8b 4d 90             	mov    -0x70(%ebp),%ecx
80109784:	89 d0                	mov    %edx,%eax
80109786:	01 c0                	add    %eax,%eax
80109788:	01 d0                	add    %edx,%eax
8010978a:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109790:	01 d0                	add    %edx,%eax
80109792:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109798:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010979e:	6a 00                	push   $0x0
801097a0:	6a 00                	push   $0x0
801097a2:	68 ff 00 00 00       	push   $0xff
801097a7:	50                   	push   %eax
801097a8:	e8 97 eb ff ff       	call   80108344 <RGB>
801097ad:	83 c4 0c             	add    $0xc,%esp
801097b0:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801097b7:	66 89 03             	mov    %ax,(%ebx)
801097ba:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801097c1:	88 43 02             	mov    %al,0x2(%ebx)
801097c4:	eb 58                	jmp    8010981e <APCharacterInit+0x12b5>
		else if(i>=28&&i<40)
801097c6:	83 7d 90 1b          	cmpl   $0x1b,-0x70(%ebp)
801097ca:	7e 52                	jle    8010981e <APCharacterInit+0x12b5>
801097cc:	83 7d 90 27          	cmpl   $0x27,-0x70(%ebp)
801097d0:	7f 4c                	jg     8010981e <APCharacterInit+0x12b5>
			character_img[i][j] = RGB(249,236,236);
801097d2:	8b 55 94             	mov    -0x6c(%ebp),%edx
801097d5:	8b 4d 90             	mov    -0x70(%ebp),%ecx
801097d8:	89 d0                	mov    %edx,%eax
801097da:	01 c0                	add    %eax,%eax
801097dc:	01 d0                	add    %edx,%eax
801097de:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801097e4:	01 d0                	add    %edx,%eax
801097e6:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801097ec:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801097f2:	68 ec 00 00 00       	push   $0xec
801097f7:	68 ec 00 00 00       	push   $0xec
801097fc:	68 f9 00 00 00       	push   $0xf9
80109801:	50                   	push   %eax
80109802:	e8 3d eb ff ff       	call   80108344 <RGB>
80109807:	83 c4 0c             	add    $0xc,%esp
8010980a:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109811:	66 89 03             	mov    %ax,(%ebx)
80109814:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010981b:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
8010981e:	83 45 90 01          	addl   $0x1,-0x70(%ebp)
80109822:	83 7d 90 27          	cmpl   $0x27,-0x70(%ebp)
80109826:	0f 8e ef fe ff ff    	jle    8010971b <APCharacterInit+0x11b2>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line =line +3;
for(int j=line;j<line+3;j++){
8010982c:	83 45 94 01          	addl   $0x1,-0x6c(%ebp)
80109830:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109836:	83 c0 03             	add    $0x3,%eax
80109839:	3b 45 94             	cmp    -0x6c(%ebp),%eax
8010983c:	0f 8f cd fe ff ff    	jg     8010970f <APCharacterInit+0x11a6>
		else if(i>=28&&i<40)
			character_img[i][j] = RGB(249,236,236);

		
}}
line =line +3;
80109842:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
80109849:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010984f:	89 45 8c             	mov    %eax,-0x74(%ebp)
80109852:	e9 21 01 00 00       	jmp    80109978 <APCharacterInit+0x140f>
	for(int i=0;i<40;i++){
80109857:	c7 45 88 00 00 00 00 	movl   $0x0,-0x78(%ebp)
8010985e:	e9 07 01 00 00       	jmp    8010996a <APCharacterInit+0x1401>
               if(i<5)
80109863:	83 7d 88 04          	cmpl   $0x4,-0x78(%ebp)
80109867:	7f 51                	jg     801098ba <APCharacterInit+0x1351>
			character_img[i][j] = RGB(249,236,236);
80109869:	8b 55 8c             	mov    -0x74(%ebp),%edx
8010986c:	8b 4d 88             	mov    -0x78(%ebp),%ecx
8010986f:	89 d0                	mov    %edx,%eax
80109871:	01 c0                	add    %eax,%eax
80109873:	01 d0                	add    %edx,%eax
80109875:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010987b:	01 d0                	add    %edx,%eax
8010987d:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109883:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109889:	68 ec 00 00 00       	push   $0xec
8010988e:	68 ec 00 00 00       	push   $0xec
80109893:	68 f9 00 00 00       	push   $0xf9
80109898:	50                   	push   %eax
80109899:	e8 a6 ea ff ff       	call   80108344 <RGB>
8010989e:	83 c4 0c             	add    $0xc,%esp
801098a1:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801098a8:	66 89 03             	mov    %ax,(%ebx)
801098ab:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801098b2:	88 43 02             	mov    %al,0x2(%ebx)
801098b5:	e9 ac 00 00 00       	jmp    80109966 <APCharacterInit+0x13fd>
	
		else if(i>=5&&i<32)
801098ba:	83 7d 88 04          	cmpl   $0x4,-0x78(%ebp)
801098be:	7e 4e                	jle    8010990e <APCharacterInit+0x13a5>
801098c0:	83 7d 88 1f          	cmpl   $0x1f,-0x78(%ebp)
801098c4:	7f 48                	jg     8010990e <APCharacterInit+0x13a5>
			character_img[i][j] = RGB(255,0,0);
801098c6:	8b 55 8c             	mov    -0x74(%ebp),%edx
801098c9:	8b 4d 88             	mov    -0x78(%ebp),%ecx
801098cc:	89 d0                	mov    %edx,%eax
801098ce:	01 c0                	add    %eax,%eax
801098d0:	01 d0                	add    %edx,%eax
801098d2:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801098d8:	01 d0                	add    %edx,%eax
801098da:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801098e0:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801098e6:	6a 00                	push   $0x0
801098e8:	6a 00                	push   $0x0
801098ea:	68 ff 00 00 00       	push   $0xff
801098ef:	50                   	push   %eax
801098f0:	e8 4f ea ff ff       	call   80108344 <RGB>
801098f5:	83 c4 0c             	add    $0xc,%esp
801098f8:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801098ff:	66 89 03             	mov    %ax,(%ebx)
80109902:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109909:	88 43 02             	mov    %al,0x2(%ebx)
8010990c:	eb 58                	jmp    80109966 <APCharacterInit+0x13fd>
		
		else if(i>=32&&i<40)
8010990e:	83 7d 88 1f          	cmpl   $0x1f,-0x78(%ebp)
80109912:	7e 52                	jle    80109966 <APCharacterInit+0x13fd>
80109914:	83 7d 88 27          	cmpl   $0x27,-0x78(%ebp)
80109918:	7f 4c                	jg     80109966 <APCharacterInit+0x13fd>
			character_img[i][j] = RGB(249,236,236);
8010991a:	8b 55 8c             	mov    -0x74(%ebp),%edx
8010991d:	8b 4d 88             	mov    -0x78(%ebp),%ecx
80109920:	89 d0                	mov    %edx,%eax
80109922:	01 c0                	add    %eax,%eax
80109924:	01 d0                	add    %edx,%eax
80109926:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010992c:	01 d0                	add    %edx,%eax
8010992e:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109934:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010993a:	68 ec 00 00 00       	push   $0xec
8010993f:	68 ec 00 00 00       	push   $0xec
80109944:	68 f9 00 00 00       	push   $0xf9
80109949:	50                   	push   %eax
8010994a:	e8 f5 e9 ff ff       	call   80108344 <RGB>
8010994f:	83 c4 0c             	add    $0xc,%esp
80109952:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109959:	66 89 03             	mov    %ax,(%ebx)
8010995c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109963:	88 43 02             	mov    %al,0x2(%ebx)

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109966:	83 45 88 01          	addl   $0x1,-0x78(%ebp)
8010996a:	83 7d 88 27          	cmpl   $0x27,-0x78(%ebp)
8010996e:	0f 8e ef fe ff ff    	jle    80109863 <APCharacterInit+0x12fa>
			character_img[i][j] = RGB(249,236,236);

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
80109974:	83 45 8c 01          	addl   $0x1,-0x74(%ebp)
80109978:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010997e:	83 c0 03             	add    $0x3,%eax
80109981:	3b 45 8c             	cmp    -0x74(%ebp),%eax
80109984:	0f 8f cd fe ff ff    	jg     80109857 <APCharacterInit+0x12ee>
		
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);

		
}}line =line +3;
8010998a:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
80109991:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109997:	89 45 84             	mov    %eax,-0x7c(%ebp)
8010999a:	e9 c4 00 00 00       	jmp    80109a63 <APCharacterInit+0x14fa>
	for(int i=0;i<40;i++){
8010999f:	c7 45 80 00 00 00 00 	movl   $0x0,-0x80(%ebp)
801099a6:	e9 aa 00 00 00       	jmp    80109a55 <APCharacterInit+0x14ec>
               if(i>=5&&i<14)
801099ab:	83 7d 80 04          	cmpl   $0x4,-0x80(%ebp)
801099af:	7e 4e                	jle    801099ff <APCharacterInit+0x1496>
801099b1:	83 7d 80 0d          	cmpl   $0xd,-0x80(%ebp)
801099b5:	7f 48                	jg     801099ff <APCharacterInit+0x1496>
			character_img[i][j] = RGB(255,0,0);
801099b7:	8b 55 84             	mov    -0x7c(%ebp),%edx
801099ba:	8b 4d 80             	mov    -0x80(%ebp),%ecx
801099bd:	89 d0                	mov    %edx,%eax
801099bf:	01 c0                	add    %eax,%eax
801099c1:	01 d0                	add    %edx,%eax
801099c3:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801099c9:	01 d0                	add    %edx,%eax
801099cb:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801099d1:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801099d7:	6a 00                	push   $0x0
801099d9:	6a 00                	push   $0x0
801099db:	68 ff 00 00 00       	push   $0xff
801099e0:	50                   	push   %eax
801099e1:	e8 5e e9 ff ff       	call   80108344 <RGB>
801099e6:	83 c4 0c             	add    $0xc,%esp
801099e9:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801099f0:	66 89 03             	mov    %ax,(%ebx)
801099f3:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801099fa:	88 43 02             	mov    %al,0x2(%ebx)
801099fd:	eb 52                	jmp    80109a51 <APCharacterInit+0x14e8>
		
		else if(i>=22&&i<32)
801099ff:	83 7d 80 15          	cmpl   $0x15,-0x80(%ebp)
80109a03:	7e 4c                	jle    80109a51 <APCharacterInit+0x14e8>
80109a05:	83 7d 80 1f          	cmpl   $0x1f,-0x80(%ebp)
80109a09:	7f 46                	jg     80109a51 <APCharacterInit+0x14e8>
			character_img[i][j] = RGB(255,0,0);
80109a0b:	8b 55 84             	mov    -0x7c(%ebp),%edx
80109a0e:	8b 4d 80             	mov    -0x80(%ebp),%ecx
80109a11:	89 d0                	mov    %edx,%eax
80109a13:	01 c0                	add    %eax,%eax
80109a15:	01 d0                	add    %edx,%eax
80109a17:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109a1d:	01 d0                	add    %edx,%eax
80109a1f:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109a25:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109a2b:	6a 00                	push   $0x0
80109a2d:	6a 00                	push   $0x0
80109a2f:	68 ff 00 00 00       	push   $0xff
80109a34:	50                   	push   %eax
80109a35:	e8 0a e9 ff ff       	call   80108344 <RGB>
80109a3a:	83 c4 0c             	add    $0xc,%esp
80109a3d:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109a44:	66 89 03             	mov    %ax,(%ebx)
80109a47:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109a4e:	88 43 02             	mov    %al,0x2(%ebx)
			character_img[i][j] = RGB(249,236,236);

		
}}line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109a51:	83 45 80 01          	addl   $0x1,-0x80(%ebp)
80109a55:	83 7d 80 27          	cmpl   $0x27,-0x80(%ebp)
80109a59:	0f 8e 4c ff ff ff    	jle    801099ab <APCharacterInit+0x1442>
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);

		
}}line =line +3;
for(int j=line;j<line+3;j++){
80109a5f:	83 45 84 01          	addl   $0x1,-0x7c(%ebp)
80109a63:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109a69:	83 c0 03             	add    $0x3,%eax
80109a6c:	3b 45 84             	cmp    -0x7c(%ebp),%eax
80109a6f:	0f 8f 2a ff ff ff    	jg     8010999f <APCharacterInit+0x1436>
		else if(i>=22&&i<32)
			character_img[i][j] = RGB(255,0,0);

		
}}
 line =line +3;
80109a75:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
80109a7c:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109a82:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
80109a88:	e9 e8 00 00 00       	jmp    80109b75 <APCharacterInit+0x160c>
	for(int i=0;i<40;i++){
80109a8d:	c7 85 78 ff ff ff 00 	movl   $0x0,-0x88(%ebp)
80109a94:	00 00 00 
80109a97:	e9 c5 00 00 00       	jmp    80109b61 <APCharacterInit+0x15f8>
               if(i>=2&&i<11)
80109a9c:	83 bd 78 ff ff ff 01 	cmpl   $0x1,-0x88(%ebp)
80109aa3:	7e 57                	jle    80109afc <APCharacterInit+0x1593>
80109aa5:	83 bd 78 ff ff ff 0a 	cmpl   $0xa,-0x88(%ebp)
80109aac:	7f 4e                	jg     80109afc <APCharacterInit+0x1593>
			character_img[i][j] = RGB(128,64,0);
80109aae:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
80109ab4:	8b 8d 78 ff ff ff    	mov    -0x88(%ebp),%ecx
80109aba:	89 d0                	mov    %edx,%eax
80109abc:	01 c0                	add    %eax,%eax
80109abe:	01 d0                	add    %edx,%eax
80109ac0:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109ac6:	01 d0                	add    %edx,%eax
80109ac8:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109ace:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109ad4:	6a 00                	push   $0x0
80109ad6:	6a 40                	push   $0x40
80109ad8:	68 80 00 00 00       	push   $0x80
80109add:	50                   	push   %eax
80109ade:	e8 61 e8 ff ff       	call   80108344 <RGB>
80109ae3:	83 c4 0c             	add    $0xc,%esp
80109ae6:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109aed:	66 89 03             	mov    %ax,(%ebx)
80109af0:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109af7:	88 43 02             	mov    %al,0x2(%ebx)
80109afa:	eb 5e                	jmp    80109b5a <APCharacterInit+0x15f1>
		
		else if(i>=25&&i<34)
80109afc:	83 bd 78 ff ff ff 18 	cmpl   $0x18,-0x88(%ebp)
80109b03:	7e 55                	jle    80109b5a <APCharacterInit+0x15f1>
80109b05:	83 bd 78 ff ff ff 21 	cmpl   $0x21,-0x88(%ebp)
80109b0c:	7f 4c                	jg     80109b5a <APCharacterInit+0x15f1>
			character_img[i][j] = RGB(128,64,0);
80109b0e:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
80109b14:	8b 8d 78 ff ff ff    	mov    -0x88(%ebp),%ecx
80109b1a:	89 d0                	mov    %edx,%eax
80109b1c:	01 c0                	add    %eax,%eax
80109b1e:	01 d0                	add    %edx,%eax
80109b20:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109b26:	01 d0                	add    %edx,%eax
80109b28:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109b2e:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109b34:	6a 00                	push   $0x0
80109b36:	6a 40                	push   $0x40
80109b38:	68 80 00 00 00       	push   $0x80
80109b3d:	50                   	push   %eax
80109b3e:	e8 01 e8 ff ff       	call   80108344 <RGB>
80109b43:	83 c4 0c             	add    $0xc,%esp
80109b46:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109b4d:	66 89 03             	mov    %ax,(%ebx)
80109b50:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109b57:	88 43 02             	mov    %al,0x2(%ebx)

		
}}
 line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109b5a:	83 85 78 ff ff ff 01 	addl   $0x1,-0x88(%ebp)
80109b61:	83 bd 78 ff ff ff 27 	cmpl   $0x27,-0x88(%ebp)
80109b68:	0f 8e 2e ff ff ff    	jle    80109a9c <APCharacterInit+0x1533>
			character_img[i][j] = RGB(255,0,0);

		
}}
 line =line +3;
for(int j=line;j<line+3;j++){
80109b6e:	83 85 7c ff ff ff 01 	addl   $0x1,-0x84(%ebp)
80109b75:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109b7b:	83 c0 03             	add    $0x3,%eax
80109b7e:	3b 85 7c ff ff ff    	cmp    -0x84(%ebp),%eax
80109b84:	0f 8f 03 ff ff ff    	jg     80109a8d <APCharacterInit+0x1524>
		else if(i>=25&&i<34)
			character_img[i][j] = RGB(128,64,0);

		
}}
line =line +3;
80109b8a:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
80109b91:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109b97:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
80109b9d:	e9 df 00 00 00       	jmp    80109c81 <APCharacterInit+0x1718>
	for(int i=0;i<40;i++){
80109ba2:	c7 85 70 ff ff ff 00 	movl   $0x0,-0x90(%ebp)
80109ba9:	00 00 00 
80109bac:	e9 bc 00 00 00       	jmp    80109c6d <APCharacterInit+0x1704>
               if(i<11)
80109bb1:	83 bd 70 ff ff ff 0a 	cmpl   $0xa,-0x90(%ebp)
80109bb8:	7f 4e                	jg     80109c08 <APCharacterInit+0x169f>
			character_img[i][j] = RGB(128,64,0);
80109bba:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
80109bc0:	8b 8d 70 ff ff ff    	mov    -0x90(%ebp),%ecx
80109bc6:	89 d0                	mov    %edx,%eax
80109bc8:	01 c0                	add    %eax,%eax
80109bca:	01 d0                	add    %edx,%eax
80109bcc:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109bd2:	01 d0                	add    %edx,%eax
80109bd4:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109bda:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109be0:	6a 00                	push   $0x0
80109be2:	6a 40                	push   $0x40
80109be4:	68 80 00 00 00       	push   $0x80
80109be9:	50                   	push   %eax
80109bea:	e8 55 e7 ff ff       	call   80108344 <RGB>
80109bef:	83 c4 0c             	add    $0xc,%esp
80109bf2:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109bf9:	66 89 03             	mov    %ax,(%ebx)
80109bfc:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109c03:	88 43 02             	mov    %al,0x2(%ebx)
80109c06:	eb 5e                	jmp    80109c66 <APCharacterInit+0x16fd>
		
		else if(i>=25&&i<35)
80109c08:	83 bd 70 ff ff ff 18 	cmpl   $0x18,-0x90(%ebp)
80109c0f:	7e 55                	jle    80109c66 <APCharacterInit+0x16fd>
80109c11:	83 bd 70 ff ff ff 22 	cmpl   $0x22,-0x90(%ebp)
80109c18:	7f 4c                	jg     80109c66 <APCharacterInit+0x16fd>
			character_img[i][j] = RGB(128,64,0);
80109c1a:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
80109c20:	8b 8d 70 ff ff ff    	mov    -0x90(%ebp),%ecx
80109c26:	89 d0                	mov    %edx,%eax
80109c28:	01 c0                	add    %eax,%eax
80109c2a:	01 d0                	add    %edx,%eax
80109c2c:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109c32:	01 d0                	add    %edx,%eax
80109c34:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109c3a:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109c40:	6a 00                	push   $0x0
80109c42:	6a 40                	push   $0x40
80109c44:	68 80 00 00 00       	push   $0x80
80109c49:	50                   	push   %eax
80109c4a:	e8 f5 e6 ff ff       	call   80108344 <RGB>
80109c4f:	83 c4 0c             	add    $0xc,%esp
80109c52:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109c59:	66 89 03             	mov    %ax,(%ebx)
80109c5c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109c63:	88 43 02             	mov    %al,0x2(%ebx)

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109c66:	83 85 70 ff ff ff 01 	addl   $0x1,-0x90(%ebp)
80109c6d:	83 bd 70 ff ff ff 27 	cmpl   $0x27,-0x90(%ebp)
80109c74:	0f 8e 37 ff ff ff    	jle    80109bb1 <APCharacterInit+0x1648>
			character_img[i][j] = RGB(128,64,0);

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
80109c7a:	83 85 74 ff ff ff 01 	addl   $0x1,-0x8c(%ebp)
80109c81:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109c87:	83 c0 03             	add    $0x3,%eax
80109c8a:	3b 85 74 ff ff ff    	cmp    -0x8c(%ebp),%eax
80109c90:	0f 8f 0c ff ff ff    	jg     80109ba2 <APCharacterInit+0x1639>
			character_img[i][j] = RGB(128,64,0);

		
}}

   for(int j=0;j<GRID_WIDTH;j++)
80109c96:	c7 85 6c ff ff ff 00 	movl   $0x0,-0x94(%ebp)
80109c9d:	00 00 00 
80109ca0:	eb 76                	jmp    80109d18 <APCharacterInit+0x17af>
   	for(int i=0;i<GRID_WIDTH;i++)
80109ca2:	c7 85 68 ff ff ff 00 	movl   $0x0,-0x98(%ebp)
80109ca9:	00 00 00 
80109cac:	eb 5a                	jmp    80109d08 <APCharacterInit+0x179f>
      		character_img2[GRID_WIDTH-1-i][j] = character_img[i][j];
80109cae:	b8 31 00 00 00       	mov    $0x31,%eax
80109cb3:	2b 85 68 ff ff ff    	sub    -0x98(%ebp),%eax
80109cb9:	89 c1                	mov    %eax,%ecx
80109cbb:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
80109cc1:	89 d0                	mov    %edx,%eax
80109cc3:	01 c0                	add    %eax,%eax
80109cc5:	01 d0                	add    %edx,%eax
80109cc7:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109ccd:	01 d0                	add    %edx,%eax
80109ccf:	8d 90 20 96 11 80    	lea    -0x7fee69e0(%eax),%edx
80109cd5:	8b 8d 6c ff ff ff    	mov    -0x94(%ebp),%ecx
80109cdb:	8b 9d 68 ff ff ff    	mov    -0x98(%ebp),%ebx
80109ce1:	89 c8                	mov    %ecx,%eax
80109ce3:	01 c0                	add    %eax,%eax
80109ce5:	01 c8                	add    %ecx,%eax
80109ce7:	69 cb 96 00 00 00    	imul   $0x96,%ebx,%ecx
80109ced:	01 c8                	add    %ecx,%eax
80109cef:	05 c0 78 11 80       	add    $0x801178c0,%eax
80109cf4:	0f b7 08             	movzwl (%eax),%ecx
80109cf7:	66 89 0a             	mov    %cx,(%edx)
80109cfa:	0f b6 40 02          	movzbl 0x2(%eax),%eax
80109cfe:	88 42 02             	mov    %al,0x2(%edx)

		
}}

   for(int j=0;j<GRID_WIDTH;j++)
   	for(int i=0;i<GRID_WIDTH;i++)
80109d01:	83 85 68 ff ff ff 01 	addl   $0x1,-0x98(%ebp)
80109d08:	83 bd 68 ff ff ff 31 	cmpl   $0x31,-0x98(%ebp)
80109d0f:	7e 9d                	jle    80109cae <APCharacterInit+0x1745>
			character_img[i][j] = RGB(128,64,0);

		
}}

   for(int j=0;j<GRID_WIDTH;j++)
80109d11:	83 85 6c ff ff ff 01 	addl   $0x1,-0x94(%ebp)
80109d18:	83 bd 6c ff ff ff 31 	cmpl   $0x31,-0x94(%ebp)
80109d1f:	7e 81                	jle    80109ca2 <APCharacterInit+0x1739>
   	for(int i=0;i<GRID_WIDTH;i++)
      		character_img2[GRID_WIDTH-1-i][j] = character_img[i][j];
}
80109d21:	90                   	nop
80109d22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80109d25:	c9                   	leave  
80109d26:	c3                   	ret    

80109d27 <APGuiInit>:

void APGuiInit(void)
{
80109d27:	55                   	push   %ebp
80109d28:	89 e5                	mov    %esp,%ebp
80109d2a:	53                   	push   %ebx
80109d2b:	83 ec 04             	sub    $0x4,%esp
    screenAddr = (AColor *)(*((uint*)P2V(0x1028)));
80109d2e:	b8 28 10 00 80       	mov    $0x80001028,%eax
80109d33:	8b 00                	mov    (%eax),%eax
80109d35:	a3 a0 e6 10 80       	mov    %eax,0x8010e6a0
    screenWidth = *((ushort *)P2V(0x1012));
80109d3a:	b8 12 10 00 80       	mov    $0x80001012,%eax
80109d3f:	0f b7 00             	movzwl (%eax),%eax
80109d42:	66 a3 94 e6 10 80    	mov    %ax,0x8010e694
    screenHeight = *((ushort *)P2V(0x1014));
80109d48:	b8 14 10 00 80       	mov    $0x80001014,%eax
80109d4d:	0f b7 00             	movzwl (%eax),%eax
80109d50:	66 a3 96 e6 10 80    	mov    %ax,0x8010e696
    bitsPerPixel = *((uchar*)P2V(0x1019));
80109d56:	b8 19 10 00 80       	mov    $0x80001019,%eax
80109d5b:	0f b6 00             	movzbl (%eax),%eax
80109d5e:	a2 98 e6 10 80       	mov    %al,0x8010e698
    screenBuf = screenAddr + screenWidth * screenHeight;
80109d63:	8b 15 a0 e6 10 80    	mov    0x8010e6a0,%edx
80109d69:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109d70:	0f b7 c8             	movzwl %ax,%ecx
80109d73:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
80109d7a:	0f b7 c0             	movzwl %ax,%eax
80109d7d:	0f af c1             	imul   %ecx,%eax
80109d80:	89 c1                	mov    %eax,%ecx
80109d82:	89 c8                	mov    %ecx,%eax
80109d84:	01 c0                	add    %eax,%eax
80109d86:	01 c8                	add    %ecx,%eax
80109d88:	01 d0                	add    %edx,%eax
80109d8a:	a3 a4 e6 10 80       	mov    %eax,0x8010e6a4
    screenContent = screenBuf + screenWidth * screenHeight;
80109d8f:	8b 15 a4 e6 10 80    	mov    0x8010e6a4,%edx
80109d95:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109d9c:	0f b7 c8             	movzwl %ax,%ecx
80109d9f:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
80109da6:	0f b7 c0             	movzwl %ax,%eax
80109da9:	0f af c1             	imul   %ecx,%eax
80109dac:	89 c1                	mov    %eax,%ecx
80109dae:	89 c8                	mov    %ecx,%eax
80109db0:	01 c0                	add    %eax,%eax
80109db2:	01 c8                	add    %ecx,%eax
80109db4:	01 d0                	add    %edx,%eax
80109db6:	a3 a8 e6 10 80       	mov    %eax,0x8010e6a8
    
    
    cprintf("screen addr : %x, screen width : %d, screen height : %d, bitsPerPixel: %d \n",
80109dbb:	0f b6 05 98 e6 10 80 	movzbl 0x8010e698,%eax
80109dc2:	0f b6 d8             	movzbl %al,%ebx
80109dc5:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
80109dcc:	0f b7 c8             	movzwl %ax,%ecx
80109dcf:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109dd6:	0f b7 d0             	movzwl %ax,%edx
80109dd9:	a1 a0 e6 10 80       	mov    0x8010e6a0,%eax
80109dde:	83 ec 0c             	sub    $0xc,%esp
80109de1:	53                   	push   %ebx
80109de2:	51                   	push   %ecx
80109de3:	52                   	push   %edx
80109de4:	50                   	push   %eax
80109de5:	68 88 ba 10 80       	push   $0x8010ba88
80109dea:	e8 d7 65 ff ff       	call   801003c6 <cprintf>
80109def:	83 c4 20             	add    $0x20,%esp
            screenAddr, screenWidth,screenHeight,bitsPerPixel);
    
    initlock(&screenLock,"sreenLock");
80109df2:	83 ec 08             	sub    $0x8,%esp
80109df5:	68 d4 ba 10 80       	push   $0x8010bad4
80109dfa:	68 60 57 11 80       	push   $0x80115760
80109dff:	e8 3a b0 ff ff       	call   80104e3e <initlock>
80109e04:	83 c4 10             	add    $0x10,%esp
    APCharacterInit();
80109e07:	e8 5d e7 ff ff       	call   80108569 <APCharacterInit>
    
}
80109e0c:	90                   	nop
80109e0d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80109e10:	c9                   	leave  
80109e11:	c3                   	ret    

80109e12 <APBufPaint>:

//将左上角坐标为(x1,y1),右下角坐标为(x2,y2)的矩形区域从Buf绘制到屏幕上
void APBufPaint(int x1,int y1,int x2,int y2,int is_grid)
{
80109e12:	55                   	push   %ebp
80109e13:	89 e5                	mov    %esp,%ebp
80109e15:	56                   	push   %esi
80109e16:	53                   	push   %ebx
80109e17:	83 ec 20             	sub    $0x20,%esp
    acquire(&screenLock);
80109e1a:	83 ec 0c             	sub    $0xc,%esp
80109e1d:	68 60 57 11 80       	push   $0x80115760
80109e22:	e8 39 b0 ff ff       	call   80104e60 <acquire>
80109e27:	83 c4 10             	add    $0x10,%esp
    x2 -= x1;
80109e2a:	8b 45 08             	mov    0x8(%ebp),%eax
80109e2d:	29 45 10             	sub    %eax,0x10(%ebp)
    x2 *= sizeof(AColor);
80109e30:	8b 55 10             	mov    0x10(%ebp),%edx
80109e33:	89 d0                	mov    %edx,%eax
80109e35:	01 c0                	add    %eax,%eax
80109e37:	01 d0                	add    %edx,%eax
80109e39:	89 45 10             	mov    %eax,0x10(%ebp)
    int off = x1 + y1 * screenWidth;
80109e3c:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109e43:	0f b7 c0             	movzwl %ax,%eax
80109e46:	0f af 45 0c          	imul   0xc(%ebp),%eax
80109e4a:	89 c2                	mov    %eax,%edx
80109e4c:	8b 45 08             	mov    0x8(%ebp),%eax
80109e4f:	01 d0                	add    %edx,%eax
80109e51:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (int y = y1 ; y <= y2; y++)
80109e54:	8b 45 0c             	mov    0xc(%ebp),%eax
80109e57:	89 45 f0             	mov    %eax,-0x10(%ebp)
80109e5a:	eb 77                	jmp    80109ed3 <APBufPaint+0xc1>
    {
        memmove(screenBuf + off , screenContent + off, x2);
80109e5c:	8b 4d 10             	mov    0x10(%ebp),%ecx
80109e5f:	8b 1d a8 e6 10 80    	mov    0x8010e6a8,%ebx
80109e65:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109e68:	89 d0                	mov    %edx,%eax
80109e6a:	01 c0                	add    %eax,%eax
80109e6c:	01 d0                	add    %edx,%eax
80109e6e:	01 c3                	add    %eax,%ebx
80109e70:	8b 35 a4 e6 10 80    	mov    0x8010e6a4,%esi
80109e76:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109e79:	89 d0                	mov    %edx,%eax
80109e7b:	01 c0                	add    %eax,%eax
80109e7d:	01 d0                	add    %edx,%eax
80109e7f:	01 f0                	add    %esi,%eax
80109e81:	83 ec 04             	sub    $0x4,%esp
80109e84:	51                   	push   %ecx
80109e85:	53                   	push   %ebx
80109e86:	50                   	push   %eax
80109e87:	e8 f6 b2 ff ff       	call   80105182 <memmove>
80109e8c:	83 c4 10             	add    $0x10,%esp
        memmove(screenAddr + off, screenContent + off, x2);
80109e8f:	8b 4d 10             	mov    0x10(%ebp),%ecx
80109e92:	8b 1d a8 e6 10 80    	mov    0x8010e6a8,%ebx
80109e98:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109e9b:	89 d0                	mov    %edx,%eax
80109e9d:	01 c0                	add    %eax,%eax
80109e9f:	01 d0                	add    %edx,%eax
80109ea1:	01 c3                	add    %eax,%ebx
80109ea3:	8b 35 a0 e6 10 80    	mov    0x8010e6a0,%esi
80109ea9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109eac:	89 d0                	mov    %edx,%eax
80109eae:	01 c0                	add    %eax,%eax
80109eb0:	01 d0                	add    %edx,%eax
80109eb2:	01 f0                	add    %esi,%eax
80109eb4:	83 ec 04             	sub    $0x4,%esp
80109eb7:	51                   	push   %ecx
80109eb8:	53                   	push   %ebx
80109eb9:	50                   	push   %eax
80109eba:	e8 c3 b2 ff ff       	call   80105182 <memmove>
80109ebf:	83 c4 10             	add    $0x10,%esp
        off += screenWidth;
80109ec2:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109ec9:	0f b7 c0             	movzwl %ax,%eax
80109ecc:	01 45 f4             	add    %eax,-0xc(%ebp)
{
    acquire(&screenLock);
    x2 -= x1;
    x2 *= sizeof(AColor);
    int off = x1 + y1 * screenWidth;
    for (int y = y1 ; y <= y2; y++)
80109ecf:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80109ed3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109ed6:	3b 45 14             	cmp    0x14(%ebp),%eax
80109ed9:	7e 81                	jle    80109e5c <APBufPaint+0x4a>
        memmove(screenBuf + off , screenContent + off, x2);
        memmove(screenAddr + off, screenContent + off, x2);
        off += screenWidth;
    }
    
    if (is_grid)
80109edb:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
80109edf:	0f 84 9a 01 00 00    	je     8010a07f <APBufPaint+0x26d>
    {
        if (x1 <= character_x * GRID_WIDTH + GRID_WIDTH && x2 >= character_x * GRID_WIDTH
80109ee5:	a1 08 e5 10 80       	mov    0x8010e508,%eax
80109eea:	83 c0 01             	add    $0x1,%eax
80109eed:	6b c0 32             	imul   $0x32,%eax,%eax
80109ef0:	3b 45 08             	cmp    0x8(%ebp),%eax
80109ef3:	0f 8c 86 01 00 00    	jl     8010a07f <APBufPaint+0x26d>
80109ef9:	a1 08 e5 10 80       	mov    0x8010e508,%eax
80109efe:	6b c0 32             	imul   $0x32,%eax,%eax
80109f01:	3b 45 10             	cmp    0x10(%ebp),%eax
80109f04:	0f 8f 75 01 00 00    	jg     8010a07f <APBufPaint+0x26d>
            && y1 <= character_y * GRID_WIDTH + GRID_WIDTH + WND_TITLE_HEIGHT && y2 >= character_y * GRID_WIDTH + WND_TITLE_HEIGHT)
80109f0a:	a1 0c e5 10 80       	mov    0x8010e50c,%eax
80109f0f:	83 c0 02             	add    $0x2,%eax
80109f12:	6b c0 32             	imul   $0x32,%eax,%eax
80109f15:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109f18:	0f 8c 61 01 00 00    	jl     8010a07f <APBufPaint+0x26d>
80109f1e:	a1 0c e5 10 80       	mov    0x8010e50c,%eax
80109f23:	83 c0 01             	add    $0x1,%eax
80109f26:	6b c0 32             	imul   $0x32,%eax,%eax
80109f29:	3b 45 14             	cmp    0x14(%ebp),%eax
80109f2c:	0f 8f 4d 01 00 00    	jg     8010a07f <APBufPaint+0x26d>
        {
            for (int j = 0; j < GRID_WIDTH ; j++)
80109f32:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80109f39:	e9 34 01 00 00       	jmp    8010a072 <APBufPaint+0x260>
            {
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
80109f3e:	a1 0c e5 10 80       	mov    0x8010e50c,%eax
80109f43:	83 c0 01             	add    $0x1,%eax
80109f46:	6b d0 32             	imul   $0x32,%eax,%edx
80109f49:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109f4c:	01 c2                	add    %eax,%edx
80109f4e:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109f55:	0f b7 c0             	movzwl %ax,%eax
80109f58:	0f af d0             	imul   %eax,%edx
80109f5b:	a1 08 e5 10 80       	mov    0x8010e508,%eax
80109f60:	6b c0 32             	imul   $0x32,%eax,%eax
80109f63:	01 d0                	add    %edx,%eax
80109f65:	89 45 f4             	mov    %eax,-0xc(%ebp)
                if (character_y * GRID_WIDTH + j < y1)
80109f68:	a1 0c e5 10 80       	mov    0x8010e50c,%eax
80109f6d:	6b d0 32             	imul   $0x32,%eax,%edx
80109f70:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109f73:	01 d0                	add    %edx,%eax
80109f75:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109f78:	0f 8c ec 00 00 00    	jl     8010a06a <APBufPaint+0x258>
                    continue;
                if (character_y * GRID_WIDTH + j > y2)
80109f7e:	a1 0c e5 10 80       	mov    0x8010e50c,%eax
80109f83:	6b d0 32             	imul   $0x32,%eax,%edx
80109f86:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109f89:	01 d0                	add    %edx,%eax
80109f8b:	3b 45 14             	cmp    0x14(%ebp),%eax
80109f8e:	0f 8f ea 00 00 00    	jg     8010a07e <APBufPaint+0x26c>
                    break;
                for (int i = 0; i < GRID_WIDTH; i++)
80109f94:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
80109f9b:	e9 be 00 00 00       	jmp    8010a05e <APBufPaint+0x24c>
                {
                    if (character_x * GRID_WIDTH + i < x1)
80109fa0:	a1 08 e5 10 80       	mov    0x8010e508,%eax
80109fa5:	6b d0 32             	imul   $0x32,%eax,%edx
80109fa8:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109fab:	01 d0                	add    %edx,%eax
80109fad:	3b 45 08             	cmp    0x8(%ebp),%eax
80109fb0:	0f 8c a3 00 00 00    	jl     8010a059 <APBufPaint+0x247>
                        continue;
                    if (character_x * GRID_WIDTH + i > x2)
80109fb6:	a1 08 e5 10 80       	mov    0x8010e508,%eax
80109fbb:	6b d0 32             	imul   $0x32,%eax,%edx
80109fbe:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109fc1:	01 d0                	add    %edx,%eax
80109fc3:	3b 45 10             	cmp    0x10(%ebp),%eax
80109fc6:	0f 8f a1 00 00 00    	jg     8010a06d <APBufPaint+0x25b>
                        break;
                    AColor c = character_img[i][j];
80109fcc:	8b 55 ec             	mov    -0x14(%ebp),%edx
80109fcf:	8b 4d e8             	mov    -0x18(%ebp),%ecx
80109fd2:	89 d0                	mov    %edx,%eax
80109fd4:	01 c0                	add    %eax,%eax
80109fd6:	01 d0                	add    %edx,%eax
80109fd8:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109fde:	01 d0                	add    %edx,%eax
80109fe0:	05 c0 78 11 80       	add    $0x801178c0,%eax
80109fe5:	0f b7 10             	movzwl (%eax),%edx
80109fe8:	66 89 55 e5          	mov    %dx,-0x1b(%ebp)
80109fec:	0f b6 40 02          	movzbl 0x2(%eax),%eax
80109ff0:	88 45 e7             	mov    %al,-0x19(%ebp)
                    if (c.r != COLOR_TRANSPARENT || c.g!=COLOR_TRANSPARENT || c.b !=COLOR_TRANSPARENT)
80109ff3:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80109ff7:	3c 0c                	cmp    $0xc,%al
80109ff9:	75 10                	jne    8010a00b <APBufPaint+0x1f9>
80109ffb:	0f b6 45 e6          	movzbl -0x1a(%ebp),%eax
80109fff:	3c 0c                	cmp    $0xc,%al
8010a001:	75 08                	jne    8010a00b <APBufPaint+0x1f9>
8010a003:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
8010a007:	3c 0c                	cmp    $0xc,%al
8010a009:	74 4f                	je     8010a05a <APBufPaint+0x248>
                    {
                        screenBuf [off + i] = c;
8010a00b:	8b 15 a4 e6 10 80    	mov    0x8010e6a4,%edx
8010a011:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010a014:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a017:	01 c8                	add    %ecx,%eax
8010a019:	89 c1                	mov    %eax,%ecx
8010a01b:	89 c8                	mov    %ecx,%eax
8010a01d:	01 c0                	add    %eax,%eax
8010a01f:	01 c8                	add    %ecx,%eax
8010a021:	01 d0                	add    %edx,%eax
8010a023:	0f b7 55 e5          	movzwl -0x1b(%ebp),%edx
8010a027:	66 89 10             	mov    %dx,(%eax)
8010a02a:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
8010a02e:	88 50 02             	mov    %dl,0x2(%eax)
                        screenAddr[off + i] = c;
8010a031:	8b 15 a0 e6 10 80    	mov    0x8010e6a0,%edx
8010a037:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010a03a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a03d:	01 c8                	add    %ecx,%eax
8010a03f:	89 c1                	mov    %eax,%ecx
8010a041:	89 c8                	mov    %ecx,%eax
8010a043:	01 c0                	add    %eax,%eax
8010a045:	01 c8                	add    %ecx,%eax
8010a047:	01 d0                	add    %edx,%eax
8010a049:	0f b7 55 e5          	movzwl -0x1b(%ebp),%edx
8010a04d:	66 89 10             	mov    %dx,(%eax)
8010a050:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
8010a054:	88 50 02             	mov    %dl,0x2(%eax)
8010a057:	eb 01                	jmp    8010a05a <APBufPaint+0x248>
                if (character_y * GRID_WIDTH + j > y2)
                    break;
                for (int i = 0; i < GRID_WIDTH; i++)
                {
                    if (character_x * GRID_WIDTH + i < x1)
                        continue;
8010a059:	90                   	nop
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
                if (character_y * GRID_WIDTH + j < y1)
                    continue;
                if (character_y * GRID_WIDTH + j > y2)
                    break;
                for (int i = 0; i < GRID_WIDTH; i++)
8010a05a:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
8010a05e:	83 7d e8 31          	cmpl   $0x31,-0x18(%ebp)
8010a062:	0f 8e 38 ff ff ff    	jle    80109fa0 <APBufPaint+0x18e>
8010a068:	eb 04                	jmp    8010a06e <APBufPaint+0x25c>
        {
            for (int j = 0; j < GRID_WIDTH ; j++)
            {
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
                if (character_y * GRID_WIDTH + j < y1)
                    continue;
8010a06a:	90                   	nop
8010a06b:	eb 01                	jmp    8010a06e <APBufPaint+0x25c>
                for (int i = 0; i < GRID_WIDTH; i++)
                {
                    if (character_x * GRID_WIDTH + i < x1)
                        continue;
                    if (character_x * GRID_WIDTH + i > x2)
                        break;
8010a06d:	90                   	nop
    if (is_grid)
    {
        if (x1 <= character_x * GRID_WIDTH + GRID_WIDTH && x2 >= character_x * GRID_WIDTH
            && y1 <= character_y * GRID_WIDTH + GRID_WIDTH + WND_TITLE_HEIGHT && y2 >= character_y * GRID_WIDTH + WND_TITLE_HEIGHT)
        {
            for (int j = 0; j < GRID_WIDTH ; j++)
8010a06e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
8010a072:	83 7d ec 31          	cmpl   $0x31,-0x14(%ebp)
8010a076:	0f 8e c2 fe ff ff    	jle    80109f3e <APBufPaint+0x12c>
8010a07c:	eb 01                	jmp    8010a07f <APBufPaint+0x26d>
            {
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
                if (character_y * GRID_WIDTH + j < y1)
                    continue;
                if (character_y * GRID_WIDTH + j > y2)
                    break;
8010a07e:	90                   	nop
            }
        }
    }
    //cprintf("arbitrary set window color!\n");
    //memset(screenAddr, DEFAULT_WINDOW_COLOR, sizeof(AColor) * screenWidth * screenHeight);
    release(&screenLock);
8010a07f:	83 ec 0c             	sub    $0xc,%esp
8010a082:	68 60 57 11 80       	push   $0x80115760
8010a087:	e8 3b ae ff ff       	call   80104ec7 <release>
8010a08c:	83 c4 10             	add    $0x10,%esp
}
8010a08f:	90                   	nop
8010a090:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010a093:	5b                   	pop    %ebx
8010a094:	5e                   	pop    %esi
8010a095:	5d                   	pop    %ebp
8010a096:	c3                   	ret    

8010a097 <sys_paintWindow>:

//paintwindow: (hwnd,wx,wy,hdc,sx,sy,w,h,is_grid)
int sys_paintWindow(void)
{
8010a097:	55                   	push   %ebp
8010a098:	89 e5                	mov    %esp,%ebp
8010a09a:	56                   	push   %esi
8010a09b:	53                   	push   %ebx
8010a09c:	83 ec 40             	sub    $0x40,%esp
    //cprintf("in paintWindow function:---- 1  \n");
    AHwnd hwnd = 0;
8010a09f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    AHdc hdc = 0;
8010a0a6:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    int wx,wy,sx,sy,w,h,is_grid;
    //从控制台获取数据，并检验值是否合法
    if (argstr(0, (char **)&hwnd) < 0 || argint(1, &wx) < 0 || argint(2, &wy) < 0
8010a0ad:	83 ec 08             	sub    $0x8,%esp
8010a0b0:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010a0b3:	50                   	push   %eax
8010a0b4:	6a 00                	push   $0x0
8010a0b6:	e8 b2 b3 ff ff       	call   8010546d <argstr>
8010a0bb:	83 c4 10             	add    $0x10,%esp
8010a0be:	85 c0                	test   %eax,%eax
8010a0c0:	0f 88 ac 00 00 00    	js     8010a172 <sys_paintWindow+0xdb>
8010a0c6:	83 ec 08             	sub    $0x8,%esp
8010a0c9:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010a0cc:	50                   	push   %eax
8010a0cd:	6a 01                	push   $0x1
8010a0cf:	e8 14 b3 ff ff       	call   801053e8 <argint>
8010a0d4:	83 c4 10             	add    $0x10,%esp
8010a0d7:	85 c0                	test   %eax,%eax
8010a0d9:	0f 88 93 00 00 00    	js     8010a172 <sys_paintWindow+0xdb>
8010a0df:	83 ec 08             	sub    $0x8,%esp
8010a0e2:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010a0e5:	50                   	push   %eax
8010a0e6:	6a 02                	push   $0x2
8010a0e8:	e8 fb b2 ff ff       	call   801053e8 <argint>
8010a0ed:	83 c4 10             	add    $0x10,%esp
8010a0f0:	85 c0                	test   %eax,%eax
8010a0f2:	78 7e                	js     8010a172 <sys_paintWindow+0xdb>
        || argstr(3, (char **)&hdc) < 0 || argint(4, &sx) < 0
8010a0f4:	83 ec 08             	sub    $0x8,%esp
8010a0f7:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010a0fa:	50                   	push   %eax
8010a0fb:	6a 03                	push   $0x3
8010a0fd:	e8 6b b3 ff ff       	call   8010546d <argstr>
8010a102:	83 c4 10             	add    $0x10,%esp
8010a105:	85 c0                	test   %eax,%eax
8010a107:	78 69                	js     8010a172 <sys_paintWindow+0xdb>
8010a109:	83 ec 08             	sub    $0x8,%esp
8010a10c:	8d 45 d0             	lea    -0x30(%ebp),%eax
8010a10f:	50                   	push   %eax
8010a110:	6a 04                	push   $0x4
8010a112:	e8 d1 b2 ff ff       	call   801053e8 <argint>
8010a117:	83 c4 10             	add    $0x10,%esp
8010a11a:	85 c0                	test   %eax,%eax
8010a11c:	78 54                	js     8010a172 <sys_paintWindow+0xdb>
        || argint(5, &sy) < 0 || argint(6, &w) < 0 || argint(7, &h) < 0
8010a11e:	83 ec 08             	sub    $0x8,%esp
8010a121:	8d 45 cc             	lea    -0x34(%ebp),%eax
8010a124:	50                   	push   %eax
8010a125:	6a 05                	push   $0x5
8010a127:	e8 bc b2 ff ff       	call   801053e8 <argint>
8010a12c:	83 c4 10             	add    $0x10,%esp
8010a12f:	85 c0                	test   %eax,%eax
8010a131:	78 3f                	js     8010a172 <sys_paintWindow+0xdb>
8010a133:	83 ec 08             	sub    $0x8,%esp
8010a136:	8d 45 c8             	lea    -0x38(%ebp),%eax
8010a139:	50                   	push   %eax
8010a13a:	6a 06                	push   $0x6
8010a13c:	e8 a7 b2 ff ff       	call   801053e8 <argint>
8010a141:	83 c4 10             	add    $0x10,%esp
8010a144:	85 c0                	test   %eax,%eax
8010a146:	78 2a                	js     8010a172 <sys_paintWindow+0xdb>
8010a148:	83 ec 08             	sub    $0x8,%esp
8010a14b:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010a14e:	50                   	push   %eax
8010a14f:	6a 07                	push   $0x7
8010a151:	e8 92 b2 ff ff       	call   801053e8 <argint>
8010a156:	83 c4 10             	add    $0x10,%esp
8010a159:	85 c0                	test   %eax,%eax
8010a15b:	78 15                	js     8010a172 <sys_paintWindow+0xdb>
        || argint(8, &is_grid) < 0)
8010a15d:	83 ec 08             	sub    $0x8,%esp
8010a160:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010a163:	50                   	push   %eax
8010a164:	6a 08                	push   $0x8
8010a166:	e8 7d b2 ff ff       	call   801053e8 <argint>
8010a16b:	83 c4 10             	add    $0x10,%esp
8010a16e:	85 c0                	test   %eax,%eax
8010a170:	79 0a                	jns    8010a17c <sys_paintWindow+0xe5>
        return -1;
8010a172:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a177:	e9 67 02 00 00       	jmp    8010a3e3 <sys_paintWindow+0x34c>
    
    if (sx < 0 || sy < 0 || h <= 0 || w <= 0 || sx + w > hdc->size.cx || sy + h > hdc->size.cy)
8010a17c:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010a17f:	85 c0                	test   %eax,%eax
8010a181:	78 38                	js     8010a1bb <sys_paintWindow+0x124>
8010a183:	8b 45 cc             	mov    -0x34(%ebp),%eax
8010a186:	85 c0                	test   %eax,%eax
8010a188:	78 31                	js     8010a1bb <sys_paintWindow+0x124>
8010a18a:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a18d:	85 c0                	test   %eax,%eax
8010a18f:	7e 2a                	jle    8010a1bb <sys_paintWindow+0x124>
8010a191:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a194:	85 c0                	test   %eax,%eax
8010a196:	7e 23                	jle    8010a1bb <sys_paintWindow+0x124>
8010a198:	8b 55 d0             	mov    -0x30(%ebp),%edx
8010a19b:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a19e:	01 c2                	add    %eax,%edx
8010a1a0:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a1a3:	8b 00                	mov    (%eax),%eax
8010a1a5:	39 c2                	cmp    %eax,%edx
8010a1a7:	7f 12                	jg     8010a1bb <sys_paintWindow+0x124>
8010a1a9:	8b 55 cc             	mov    -0x34(%ebp),%edx
8010a1ac:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a1af:	01 c2                	add    %eax,%edx
8010a1b1:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a1b4:	8b 40 04             	mov    0x4(%eax),%eax
8010a1b7:	39 c2                	cmp    %eax,%edx
8010a1b9:	7e 0a                	jle    8010a1c5 <sys_paintWindow+0x12e>
        return 0;
8010a1bb:	b8 00 00 00 00       	mov    $0x0,%eax
8010a1c0:	e9 1e 02 00 00       	jmp    8010a3e3 <sys_paintWindow+0x34c>
    
    if (wx < 0 || wy < 0 || wx + w > screenWidth || wy + h > screenHeight)
8010a1c5:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a1c8:	85 c0                	test   %eax,%eax
8010a1ca:	78 33                	js     8010a1ff <sys_paintWindow+0x168>
8010a1cc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a1cf:	85 c0                	test   %eax,%eax
8010a1d1:	78 2c                	js     8010a1ff <sys_paintWindow+0x168>
8010a1d3:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010a1d6:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a1d9:	01 c2                	add    %eax,%edx
8010a1db:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010a1e2:	0f b7 c0             	movzwl %ax,%eax
8010a1e5:	39 c2                	cmp    %eax,%edx
8010a1e7:	7f 16                	jg     8010a1ff <sys_paintWindow+0x168>
8010a1e9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a1ec:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a1ef:	01 c2                	add    %eax,%edx
8010a1f1:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
8010a1f8:	0f b7 c0             	movzwl %ax,%eax
8010a1fb:	39 c2                	cmp    %eax,%edx
8010a1fd:	7e 0a                	jle    8010a209 <sys_paintWindow+0x172>
        return 0;
8010a1ff:	b8 00 00 00 00       	mov    $0x0,%eax
8010a204:	e9 da 01 00 00       	jmp    8010a3e3 <sys_paintWindow+0x34c>
    
    //wx,wy是window重绘左上角坐标
    
    //int id = hwnd ->id;
    //cprintf("in paintWindow function:-----2  \n");
    AColor *data = hdc->content;
8010a209:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a20c:	8b 40 18             	mov    0x18(%eax),%eax
8010a20f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    
    int j;
    for (int i = 0; i < h;i++)
8010a212:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010a219:	e9 18 01 00 00       	jmp    8010a336 <sys_paintWindow+0x29f>
    {
        if (wy + i < 0)
8010a21e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a221:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a224:	01 d0                	add    %edx,%eax
8010a226:	85 c0                	test   %eax,%eax
8010a228:	79 0d                	jns    8010a237 <sys_paintWindow+0x1a0>
        {
            i = -wy - 1;
8010a22a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a22d:	f7 d0                	not    %eax
8010a22f:	89 45 f0             	mov    %eax,-0x10(%ebp)
            continue;
8010a232:	e9 fb 00 00 00       	jmp    8010a332 <sys_paintWindow+0x29b>
        }
        else if (wy + i >= screenHeight)
8010a237:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a23a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a23d:	01 c2                	add    %eax,%edx
8010a23f:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
8010a246:	0f b7 c0             	movzwl %ax,%eax
8010a249:	39 c2                	cmp    %eax,%edx
8010a24b:	0f 8d f3 00 00 00    	jge    8010a344 <sys_paintWindow+0x2ad>
            break;
        int off_x = (sy + i) * hdc->size.cx + sx;
8010a251:	8b 55 cc             	mov    -0x34(%ebp),%edx
8010a254:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a257:	01 c2                	add    %eax,%edx
8010a259:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a25c:	8b 00                	mov    (%eax),%eax
8010a25e:	0f af d0             	imul   %eax,%edx
8010a261:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010a264:	01 d0                	add    %edx,%eax
8010a266:	89 45 e8             	mov    %eax,-0x18(%ebp)
        int screen_off_x = (wy + i) * screenWidth + wx;
8010a269:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a26c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a26f:	01 c2                	add    %eax,%edx
8010a271:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010a278:	0f b7 c0             	movzwl %ax,%eax
8010a27b:	0f af d0             	imul   %eax,%edx
8010a27e:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a281:	01 d0                	add    %edx,%eax
8010a283:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        for (j = 0; j < w; ++j)
8010a286:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010a28d:	e9 91 00 00 00       	jmp    8010a323 <sys_paintWindow+0x28c>
        {
            if (wx + j < 0)
8010a292:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010a295:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a298:	01 d0                	add    %edx,%eax
8010a29a:	85 c0                	test   %eax,%eax
8010a29c:	79 0a                	jns    8010a2a8 <sys_paintWindow+0x211>
            {
                j = -wx - 1;
8010a29e:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a2a1:	f7 d0                	not    %eax
8010a2a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010a2a6:	eb 77                	jmp    8010a31f <sys_paintWindow+0x288>
                continue;
            }
            else if (wx + j >= screenWidth)
8010a2a8:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010a2ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a2ae:	01 c2                	add    %eax,%edx
8010a2b0:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010a2b7:	0f b7 c0             	movzwl %ax,%eax
8010a2ba:	39 c2                	cmp    %eax,%edx
8010a2bc:	7d 73                	jge    8010a331 <sys_paintWindow+0x29a>
                break;
            
            AColor c = data[off_x + j];
8010a2be:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010a2c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a2c4:	01 d0                	add    %edx,%eax
8010a2c6:	89 c2                	mov    %eax,%edx
8010a2c8:	89 d0                	mov    %edx,%eax
8010a2ca:	01 c0                	add    %eax,%eax
8010a2cc:	01 c2                	add    %eax,%edx
8010a2ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a2d1:	01 d0                	add    %edx,%eax
8010a2d3:	0f b7 10             	movzwl (%eax),%edx
8010a2d6:	66 89 55 bd          	mov    %dx,-0x43(%ebp)
8010a2da:	0f b6 40 02          	movzbl 0x2(%eax),%eax
8010a2de:	88 45 bf             	mov    %al,-0x41(%ebp)
            if (c.r != COLOR_TRANSPARENT || c.g != COLOR_TRANSPARENT || c.b != COLOR_TRANSPARENT )
8010a2e1:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
8010a2e5:	3c 0c                	cmp    $0xc,%al
8010a2e7:	75 10                	jne    8010a2f9 <sys_paintWindow+0x262>
8010a2e9:	0f b6 45 be          	movzbl -0x42(%ebp),%eax
8010a2ed:	3c 0c                	cmp    $0xc,%al
8010a2ef:	75 08                	jne    8010a2f9 <sys_paintWindow+0x262>
8010a2f1:	0f b6 45 bd          	movzbl -0x43(%ebp),%eax
8010a2f5:	3c 0c                	cmp    $0xc,%al
8010a2f7:	74 26                	je     8010a31f <sys_paintWindow+0x288>
                screenContent[screen_off_x + j] = c;
8010a2f9:	8b 15 a8 e6 10 80    	mov    0x8010e6a8,%edx
8010a2ff:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010a302:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a305:	01 c8                	add    %ecx,%eax
8010a307:	89 c1                	mov    %eax,%ecx
8010a309:	89 c8                	mov    %ecx,%eax
8010a30b:	01 c0                	add    %eax,%eax
8010a30d:	01 c8                	add    %ecx,%eax
8010a30f:	01 d0                	add    %edx,%eax
8010a311:	0f b7 55 bd          	movzwl -0x43(%ebp),%edx
8010a315:	66 89 10             	mov    %dx,(%eax)
8010a318:	0f b6 55 bf          	movzbl -0x41(%ebp),%edx
8010a31c:	88 50 02             	mov    %dl,0x2(%eax)
        }
        else if (wy + i >= screenHeight)
            break;
        int off_x = (sy + i) * hdc->size.cx + sx;
        int screen_off_x = (wy + i) * screenWidth + wx;
        for (j = 0; j < w; ++j)
8010a31f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010a323:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a326:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010a329:	0f 8c 63 ff ff ff    	jl     8010a292 <sys_paintWindow+0x1fb>
8010a32f:	eb 01                	jmp    8010a332 <sys_paintWindow+0x29b>
            {
                j = -wx - 1;
                continue;
            }
            else if (wx + j >= screenWidth)
                break;
8010a331:	90                   	nop
    //int id = hwnd ->id;
    //cprintf("in paintWindow function:-----2  \n");
    AColor *data = hdc->content;
    
    int j;
    for (int i = 0; i < h;i++)
8010a332:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010a336:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a339:	39 45 f0             	cmp    %eax,-0x10(%ebp)
8010a33c:	0f 8c dc fe ff ff    	jl     8010a21e <sys_paintWindow+0x187>
8010a342:	eb 01                	jmp    8010a345 <sys_paintWindow+0x2ae>
        {
            i = -wy - 1;
            continue;
        }
        else if (wy + i >= screenHeight)
            break;
8010a344:	90                   	nop
            AColor c = data[off_x + j];
            if (c.r != COLOR_TRANSPARENT || c.g != COLOR_TRANSPARENT || c.b != COLOR_TRANSPARENT )
                screenContent[screen_off_x + j] = c;
        }
    }
    w += wx - 1;
8010a345:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a348:	8d 50 ff             	lea    -0x1(%eax),%edx
8010a34b:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a34e:	01 d0                	add    %edx,%eax
8010a350:	89 45 c8             	mov    %eax,-0x38(%ebp)
    h += wy - 1;
8010a353:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a356:	8d 50 ff             	lea    -0x1(%eax),%edx
8010a359:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a35c:	01 d0                	add    %edx,%eax
8010a35e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    if (wx < 0)
8010a361:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a364:	85 c0                	test   %eax,%eax
8010a366:	79 07                	jns    8010a36f <sys_paintWindow+0x2d8>
        wx = 0;
8010a368:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    if (wy < 0)
8010a36f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a372:	85 c0                	test   %eax,%eax
8010a374:	79 07                	jns    8010a37d <sys_paintWindow+0x2e6>
        wy = 0;
8010a376:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    if (h >= screenHeight)
8010a37d:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
8010a384:	0f b7 d0             	movzwl %ax,%edx
8010a387:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a38a:	39 c2                	cmp    %eax,%edx
8010a38c:	7f 10                	jg     8010a39e <sys_paintWindow+0x307>
        h = screenHeight - 1;
8010a38e:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
8010a395:	0f b7 c0             	movzwl %ax,%eax
8010a398:	83 e8 01             	sub    $0x1,%eax
8010a39b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    if (w >= screenWidth)
8010a39e:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010a3a5:	0f b7 d0             	movzwl %ax,%edx
8010a3a8:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a3ab:	39 c2                	cmp    %eax,%edx
8010a3ad:	7f 10                	jg     8010a3bf <sys_paintWindow+0x328>
        w = screenWidth - 1;
8010a3af:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010a3b6:	0f b7 c0             	movzwl %ax,%eax
8010a3b9:	83 e8 01             	sub    $0x1,%eax
8010a3bc:	89 45 c8             	mov    %eax,-0x38(%ebp)
    //release(&videoLock);
    APBufPaint(wx, wy, w, h,is_grid);
8010a3bf:	8b 75 c0             	mov    -0x40(%ebp),%esi
8010a3c2:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
8010a3c5:	8b 4d c8             	mov    -0x38(%ebp),%ecx
8010a3c8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a3cb:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a3ce:	83 ec 0c             	sub    $0xc,%esp
8010a3d1:	56                   	push   %esi
8010a3d2:	53                   	push   %ebx
8010a3d3:	51                   	push   %ecx
8010a3d4:	52                   	push   %edx
8010a3d5:	50                   	push   %eax
8010a3d6:	e8 37 fa ff ff       	call   80109e12 <APBufPaint>
8010a3db:	83 c4 20             	add    $0x20,%esp
    return 0;
8010a3de:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a3e3:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010a3e6:	5b                   	pop    %ebx
8010a3e7:	5e                   	pop    %esi
8010a3e8:	5d                   	pop    %ebp
8010a3e9:	c3                   	ret    

8010a3ea <sys_initStringFigure>:

char GBK2312[GBK2312_SIZE];
char ASCII[ASCII_SIZE];

int sys_initStringFigure(void)
{
8010a3ea:	55                   	push   %ebp
8010a3eb:	89 e5                	mov    %esp,%ebp
8010a3ed:	53                   	push   %ebx
8010a3ee:	83 ec 24             	sub    $0x24,%esp
    char * gbk2312 = 0;
8010a3f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    int n1;
    char * ascii = 0;
8010a3f8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    int n2;
    if (argstr(0, (char **)&gbk2312) < 0 || argint(1, &n1) < 0 || argstr(2, (char **)&ascii) < 0 || argint(3, &n2) < 0)
8010a3ff:	83 ec 08             	sub    $0x8,%esp
8010a402:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010a405:	50                   	push   %eax
8010a406:	6a 00                	push   $0x0
8010a408:	e8 60 b0 ff ff       	call   8010546d <argstr>
8010a40d:	83 c4 10             	add    $0x10,%esp
8010a410:	85 c0                	test   %eax,%eax
8010a412:	78 3f                	js     8010a453 <sys_initStringFigure+0x69>
8010a414:	83 ec 08             	sub    $0x8,%esp
8010a417:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010a41a:	50                   	push   %eax
8010a41b:	6a 01                	push   $0x1
8010a41d:	e8 c6 af ff ff       	call   801053e8 <argint>
8010a422:	83 c4 10             	add    $0x10,%esp
8010a425:	85 c0                	test   %eax,%eax
8010a427:	78 2a                	js     8010a453 <sys_initStringFigure+0x69>
8010a429:	83 ec 08             	sub    $0x8,%esp
8010a42c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010a42f:	50                   	push   %eax
8010a430:	6a 02                	push   $0x2
8010a432:	e8 36 b0 ff ff       	call   8010546d <argstr>
8010a437:	83 c4 10             	add    $0x10,%esp
8010a43a:	85 c0                	test   %eax,%eax
8010a43c:	78 15                	js     8010a453 <sys_initStringFigure+0x69>
8010a43e:	83 ec 08             	sub    $0x8,%esp
8010a441:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010a444:	50                   	push   %eax
8010a445:	6a 03                	push   $0x3
8010a447:	e8 9c af ff ff       	call   801053e8 <argint>
8010a44c:	83 c4 10             	add    $0x10,%esp
8010a44f:	85 c0                	test   %eax,%eax
8010a451:	79 0a                	jns    8010a45d <sys_initStringFigure+0x73>
        return -1;
8010a453:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a458:	e9 8f 00 00 00       	jmp    8010a4ec <sys_initStringFigure+0x102>
    for (int i = 0; i < n1; i += 32)
8010a45d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010a464:	eb 5f                	jmp    8010a4c5 <sys_initStringFigure+0xdb>
    {
        for (int j = 0; j < 16; ++j)
8010a466:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010a46d:	eb 4c                	jmp    8010a4bb <sys_initStringFigure+0xd1>
        {
            GBK2312[i + j] = gbk2312[i + 2 * j];
8010a46f:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a472:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a475:	01 c2                	add    %eax,%edx
8010a477:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a47a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010a47d:	8d 1c 09             	lea    (%ecx,%ecx,1),%ebx
8010a480:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010a483:	01 d9                	add    %ebx,%ecx
8010a485:	01 c8                	add    %ecx,%eax
8010a487:	0f b6 00             	movzbl (%eax),%eax
8010a48a:	88 82 a0 bc 11 80    	mov    %al,-0x7fee4360(%edx)
            GBK2312[i + 16 + j] = gbk2312[i + 2 * j + 1];
8010a490:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a493:	8d 50 10             	lea    0x10(%eax),%edx
8010a496:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a499:	01 c2                	add    %eax,%edx
8010a49b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a49e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010a4a1:	8d 1c 09             	lea    (%ecx,%ecx,1),%ebx
8010a4a4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010a4a7:	01 d9                	add    %ebx,%ecx
8010a4a9:	83 c1 01             	add    $0x1,%ecx
8010a4ac:	01 c8                	add    %ecx,%eax
8010a4ae:	0f b6 00             	movzbl (%eax),%eax
8010a4b1:	88 82 a0 bc 11 80    	mov    %al,-0x7fee4360(%edx)
    int n2;
    if (argstr(0, (char **)&gbk2312) < 0 || argint(1, &n1) < 0 || argstr(2, (char **)&ascii) < 0 || argint(3, &n2) < 0)
        return -1;
    for (int i = 0; i < n1; i += 32)
    {
        for (int j = 0; j < 16; ++j)
8010a4b7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010a4bb:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
8010a4bf:	7e ae                	jle    8010a46f <sys_initStringFigure+0x85>
    int n1;
    char * ascii = 0;
    int n2;
    if (argstr(0, (char **)&gbk2312) < 0 || argint(1, &n1) < 0 || argstr(2, (char **)&ascii) < 0 || argint(3, &n2) < 0)
        return -1;
    for (int i = 0; i < n1; i += 32)
8010a4c1:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
8010a4c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a4c8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010a4cb:	7c 99                	jl     8010a466 <sys_initStringFigure+0x7c>
        {
            GBK2312[i + j] = gbk2312[i + 2 * j];
            GBK2312[i + 16 + j] = gbk2312[i + 2 * j + 1];
        }
    }
    memmove(ASCII, ascii, sizeof(char) * n2);
8010a4cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010a4d0:	89 c2                	mov    %eax,%edx
8010a4d2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010a4d5:	83 ec 04             	sub    $0x4,%esp
8010a4d8:	52                   	push   %edx
8010a4d9:	50                   	push   %eax
8010a4da:	68 80 b3 11 80       	push   $0x8011b380
8010a4df:	e8 9e ac ff ff       	call   80105182 <memmove>
8010a4e4:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a4e7:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a4ec:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010a4ef:	c9                   	leave  
8010a4f0:	c3                   	ret    

8010a4f1 <sys_sendMessage>:

int sys_sendMessage(void)
{
8010a4f1:	55                   	push   %ebp
8010a4f2:	89 e5                	mov    %esp,%ebp
8010a4f4:	83 ec 18             	sub    $0x18,%esp
    int wndId = 0;
8010a4f7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    AMessage * msg = 0;
8010a4fe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    if (argint(0, &wndId) < 0 || argstr(1, (char**)&msg) < 0)
8010a505:	83 ec 08             	sub    $0x8,%esp
8010a508:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010a50b:	50                   	push   %eax
8010a50c:	6a 00                	push   $0x0
8010a50e:	e8 d5 ae ff ff       	call   801053e8 <argint>
8010a513:	83 c4 10             	add    $0x10,%esp
8010a516:	85 c0                	test   %eax,%eax
8010a518:	78 15                	js     8010a52f <sys_sendMessage+0x3e>
8010a51a:	83 ec 08             	sub    $0x8,%esp
8010a51d:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010a520:	50                   	push   %eax
8010a521:	6a 01                	push   $0x1
8010a523:	e8 45 af ff ff       	call   8010546d <argstr>
8010a528:	83 c4 10             	add    $0x10,%esp
8010a52b:	85 c0                	test   %eax,%eax
8010a52d:	79 07                	jns    8010a536 <sys_sendMessage+0x45>
        return -1;
8010a52f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a534:	eb 18                	jmp    8010a54e <sys_sendMessage+0x5d>
    sendMessage(wndId, msg);
8010a536:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010a539:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a53c:	83 ec 08             	sub    $0x8,%esp
8010a53f:	52                   	push   %edx
8010a540:	50                   	push   %eax
8010a541:	e8 69 01 00 00       	call   8010a6af <sendMessage>
8010a546:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a549:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a54e:	c9                   	leave  
8010a54f:	c3                   	ret    

8010a550 <sys_registWindow>:

int sys_registWindow(void)
{
8010a550:	55                   	push   %ebp
8010a551:	89 e5                	mov    %esp,%ebp
8010a553:	83 ec 18             	sub    $0x18,%esp
    AHwnd hwnd = 0;
8010a556:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (argstr(0, (char **)&hwnd) < 0)
8010a55d:	83 ec 08             	sub    $0x8,%esp
8010a560:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010a563:	50                   	push   %eax
8010a564:	6a 00                	push   $0x0
8010a566:	e8 02 af ff ff       	call   8010546d <argstr>
8010a56b:	83 c4 10             	add    $0x10,%esp
8010a56e:	85 c0                	test   %eax,%eax
8010a570:	79 07                	jns    8010a579 <sys_registWindow+0x29>
        return -1;
8010a572:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a577:	eb 19                	jmp    8010a592 <sys_registWindow+0x42>
    APWndListAddToHead(&wndList, hwnd);
8010a579:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a57c:	83 ec 08             	sub    $0x8,%esp
8010a57f:	50                   	push   %eax
8010a580:	68 a0 57 11 80       	push   $0x801157a0
8010a585:	e8 19 03 00 00       	call   8010a8a3 <APWndListAddToHead>
8010a58a:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a58d:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a592:	c9                   	leave  
8010a593:	c3                   	ret    

8010a594 <sys_getMessage>:

int sys_getMessage(void)
{
8010a594:	55                   	push   %ebp
8010a595:	89 e5                	mov    %esp,%ebp
8010a597:	53                   	push   %ebx
8010a598:	83 ec 24             	sub    $0x24,%esp

    AHwnd hwnd = 0;
8010a59b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (argstr(0, (char **)&hwnd) < 0)
8010a5a2:	83 ec 08             	sub    $0x8,%esp
8010a5a5:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010a5a8:	50                   	push   %eax
8010a5a9:	6a 00                	push   $0x0
8010a5ab:	e8 bd ae ff ff       	call   8010546d <argstr>
8010a5b0:	83 c4 10             	add    $0x10,%esp
8010a5b3:	85 c0                	test   %eax,%eax
8010a5b5:	79 0a                	jns    8010a5c1 <sys_getMessage+0x2d>
        return -1;
8010a5b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a5bc:	e9 e9 00 00 00       	jmp    8010a6aa <sys_getMessage+0x116>
    int wndId = hwnd->id;
8010a5c1:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a5c4:	8b 00                	mov    (%eax),%eax
8010a5c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int pid = hwnd->pid;
8010a5c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a5cc:	8b 40 04             	mov    0x4(%eax),%eax
8010a5cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    //cprintf("in function --- getMessage:WndId: %d\n",wndId);
    
    acquire(&wndList.data[wndId].lock);
8010a5d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a5d5:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a5db:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a5e0:	83 c0 08             	add    $0x8,%eax
8010a5e3:	83 ec 0c             	sub    $0xc,%esp
8010a5e6:	50                   	push   %eax
8010a5e7:	e8 74 a8 ff ff       	call   80104e60 <acquire>
8010a5ec:	83 c4 10             	add    $0x10,%esp
    AMsgQueue * queue = &wndList.data[wndId].msgQueue;
8010a5ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a5f2:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a5f8:	83 c0 30             	add    $0x30,%eax
8010a5fb:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a600:	83 c0 0c             	add    $0xc,%eax
8010a603:	89 45 ec             	mov    %eax,-0x14(%ebp)
    
    //cprintf("head:%d,tail:%d \n",queue->head,queue->tail);
    if (queue->head == queue->tail)
8010a606:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a609:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010a60f:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a612:	8b 80 04 03 00 00    	mov    0x304(%eax),%eax
8010a618:	39 c2                	cmp    %eax,%edx
8010a61a:	75 21                	jne    8010a63d <sys_getMessage+0xa9>
    {
       // cprintf("sleeping\n");
        sleep((void *)pid,&wndList.data[wndId].lock);
8010a61c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a61f:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a625:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a62a:	8d 50 08             	lea    0x8(%eax),%edx
8010a62d:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a630:	83 ec 08             	sub    $0x8,%esp
8010a633:	52                   	push   %edx
8010a634:	50                   	push   %eax
8010a635:	e8 2d a5 ff ff       	call   80104b67 <sleep>
8010a63a:	83 c4 10             	add    $0x10,%esp
    }
    if (wndList.data[wndId].hwnd->msg.type == MSG_NULL)
8010a63d:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a640:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a646:	05 e4 5a 11 80       	add    $0x80115ae4,%eax
8010a64b:	8b 00                	mov    (%eax),%eax
8010a64d:	8b 40 6c             	mov    0x6c(%eax),%eax
8010a650:	85 c0                	test   %eax,%eax
8010a652:	75 34                	jne    8010a688 <sys_getMessage+0xf4>
    {
      //  cprintf("poping msg!\n");
        wndList.data[wndId].hwnd->msg = APMsgQueueDeQueue(queue);
8010a654:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a657:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a65d:	05 e4 5a 11 80       	add    $0x80115ae4,%eax
8010a662:	8b 18                	mov    (%eax),%ebx
8010a664:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010a667:	83 ec 08             	sub    $0x8,%esp
8010a66a:	ff 75 ec             	pushl  -0x14(%ebp)
8010a66d:	50                   	push   %eax
8010a66e:	e8 ca 06 00 00       	call   8010ad3d <APMsgQueueDeQueue>
8010a673:	83 c4 0c             	add    $0xc,%esp
8010a676:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a679:	89 43 6c             	mov    %eax,0x6c(%ebx)
8010a67c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a67f:	89 43 70             	mov    %eax,0x70(%ebx)
8010a682:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010a685:	89 43 74             	mov    %eax,0x74(%ebx)
    }
    
    release(&wndList.data[wndId].lock);
8010a688:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a68b:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a691:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a696:	83 c0 08             	add    $0x8,%eax
8010a699:	83 ec 0c             	sub    $0xc,%esp
8010a69c:	50                   	push   %eax
8010a69d:	e8 25 a8 ff ff       	call   80104ec7 <release>
8010a6a2:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a6a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a6aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010a6ad:	c9                   	leave  
8010a6ae:	c3                   	ret    

8010a6af <sendMessage>:


void sendMessage(int wndId, AMessage *msg)
{
8010a6af:	55                   	push   %ebp
8010a6b0:	89 e5                	mov    %esp,%ebp
8010a6b2:	83 ec 18             	sub    $0x18,%esp
cprintf("sendMessage,Messgaetype:%d\n",msg->type);
8010a6b5:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a6b8:	8b 00                	mov    (%eax),%eax
8010a6ba:	83 ec 08             	sub    $0x8,%esp
8010a6bd:	50                   	push   %eax
8010a6be:	68 de ba 10 80       	push   $0x8010bade
8010a6c3:	e8 fe 5c ff ff       	call   801003c6 <cprintf>
8010a6c8:	83 c4 10             	add    $0x10,%esp
    if (wndId == -1 || wndList.data[wndId].hwnd == 0)
8010a6cb:	83 7d 08 ff          	cmpl   $0xffffffff,0x8(%ebp)
8010a6cf:	0f 84 ad 00 00 00    	je     8010a782 <sendMessage+0xd3>
8010a6d5:	8b 45 08             	mov    0x8(%ebp),%eax
8010a6d8:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a6de:	05 e4 5a 11 80       	add    $0x80115ae4,%eax
8010a6e3:	8b 00                	mov    (%eax),%eax
8010a6e5:	85 c0                	test   %eax,%eax
8010a6e7:	0f 84 95 00 00 00    	je     8010a782 <sendMessage+0xd3>
        return;
    //cprintf("send message: WndID:%d \n",wndId);
    switch (msg->type)
8010a6ed:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a6f0:	8b 00                	mov    (%eax),%eax
8010a6f2:	83 f8 06             	cmp    $0x6,%eax
8010a6f5:	74 2d                	je     8010a724 <sendMessage+0x75>
8010a6f7:	83 f8 06             	cmp    $0x6,%eax
8010a6fa:	77 07                	ja     8010a703 <sendMessage+0x54>
8010a6fc:	83 f8 05             	cmp    $0x5,%eax
8010a6ff:	74 0e                	je     8010a70f <sendMessage+0x60>
	case MSG_HANDLE_DOWN:
	    break;
	case MSG_HANDLE_UP:
	    break;
	default:
	    break;
8010a701:	eb 28                	jmp    8010a72b <sendMessage+0x7c>
{
cprintf("sendMessage,Messgaetype:%d\n",msg->type);
    if (wndId == -1 || wndList.data[wndId].hwnd == 0)
        return;
    //cprintf("send message: WndID:%d \n",wndId);
    switch (msg->type)
8010a703:	83 f8 07             	cmp    $0x7,%eax
8010a706:	74 1f                	je     8010a727 <sendMessage+0x78>
8010a708:	83 f8 08             	cmp    $0x8,%eax
8010a70b:	74 1d                	je     8010a72a <sendMessage+0x7b>
	case MSG_HANDLE_DOWN:
	    break;
	case MSG_HANDLE_UP:
	    break;
	default:
	    break;
8010a70d:	eb 1c                	jmp    8010a72b <sendMessage+0x7c>
    //cprintf("send message: WndID:%d \n",wndId);
    switch (msg->type)
    {
	case MSG_KEY_UP:
		
		cprintf("WndId:%d",wndId);	    
8010a70f:	83 ec 08             	sub    $0x8,%esp
8010a712:	ff 75 08             	pushl  0x8(%ebp)
8010a715:	68 fa ba 10 80       	push   $0x8010bafa
8010a71a:	e8 a7 5c ff ff       	call   801003c6 <cprintf>
8010a71f:	83 c4 10             	add    $0x10,%esp
//APCharacterMove(msg->param);
	    break;
8010a722:	eb 07                	jmp    8010a72b <sendMessage+0x7c>
	case MSG_KEY_DOWN:

	    break;
8010a724:	90                   	nop
8010a725:	eb 04                	jmp    8010a72b <sendMessage+0x7c>
	case MSG_HANDLE_DOWN:
	    break;
8010a727:	90                   	nop
8010a728:	eb 01                	jmp    8010a72b <sendMessage+0x7c>
	case MSG_HANDLE_UP:
	    break;
8010a72a:	90                   	nop
	    break;

    }


    AMsgQueue * queue = &wndList.data[wndId].msgQueue;
8010a72b:	8b 45 08             	mov    0x8(%ebp),%eax
8010a72e:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a734:	83 c0 30             	add    $0x30,%eax
8010a737:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a73c:	83 c0 0c             	add    $0xc,%eax
8010a73f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    msg->wndID = wndId;
8010a742:	8b 55 08             	mov    0x8(%ebp),%edx
8010a745:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a748:	89 50 08             	mov    %edx,0x8(%eax)
    APMsgQueueEnQueue(queue, *msg);
8010a74b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a74e:	ff 70 08             	pushl  0x8(%eax)
8010a751:	ff 70 04             	pushl  0x4(%eax)
8010a754:	ff 30                	pushl  (%eax)
8010a756:	ff 75 f4             	pushl  -0xc(%ebp)
8010a759:	e8 64 05 00 00       	call   8010acc2 <APMsgQueueEnQueue>
8010a75e:	83 c4 10             	add    $0x10,%esp
    wakeup((void *)wndList.data[wndId].hwnd->pid);
8010a761:	8b 45 08             	mov    0x8(%ebp),%eax
8010a764:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a76a:	05 e4 5a 11 80       	add    $0x80115ae4,%eax
8010a76f:	8b 00                	mov    (%eax),%eax
8010a771:	8b 40 04             	mov    0x4(%eax),%eax
8010a774:	83 ec 0c             	sub    $0xc,%esp
8010a777:	50                   	push   %eax
8010a778:	e8 d5 a4 ff ff       	call   80104c52 <wakeup>
8010a77d:	83 c4 10             	add    $0x10,%esp
8010a780:	eb 01                	jmp    8010a783 <sendMessage+0xd4>

void sendMessage(int wndId, AMessage *msg)
{
cprintf("sendMessage,Messgaetype:%d\n",msg->type);
    if (wndId == -1 || wndList.data[wndId].hwnd == 0)
        return;
8010a782:	90                   	nop

    AMsgQueue * queue = &wndList.data[wndId].msgQueue;
    msg->wndID = wndId;
    APMsgQueueEnQueue(queue, *msg);
    wakeup((void *)wndList.data[wndId].hwnd->pid);
}
8010a783:	c9                   	leave  
8010a784:	c3                   	ret    

8010a785 <APWndListInit>:
//------------------------------------------------------------------------------------
//WndList

//space--insert_position
void APWndListInit(AWndList * list)
{
8010a785:	55                   	push   %ebp
8010a786:	89 e5                	mov    %esp,%ebp
8010a788:	83 ec 18             	sub    $0x18,%esp
    int i = 0;
8010a78b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    for (i = 0; i < MAX_WND_NUM; ++i)
8010a792:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010a799:	e9 8c 00 00 00       	jmp    8010a82a <APWndListInit+0xa5>
    {
        list->data[i].hwnd = 0;
8010a79e:	8b 55 08             	mov    0x8(%ebp),%edx
8010a7a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a7a4:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a7aa:	01 d0                	add    %edx,%eax
8010a7ac:	05 44 03 00 00       	add    $0x344,%eax
8010a7b1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
        list->data[i].prev = -1;
8010a7b7:	8b 55 08             	mov    0x8(%ebp),%edx
8010a7ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a7bd:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a7c3:	01 d0                	add    %edx,%eax
8010a7c5:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
        list->data[i].next = i + 1;
8010a7cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a7ce:	8d 50 01             	lea    0x1(%eax),%edx
8010a7d1:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010a7d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a7d7:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a7dd:	01 c8                	add    %ecx,%eax
8010a7df:	83 c0 04             	add    $0x4,%eax
8010a7e2:	89 10                	mov    %edx,(%eax)
        APMsgQueueInit(&list->data[i].msgQueue);
8010a7e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a7e7:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a7ed:	8d 50 30             	lea    0x30(%eax),%edx
8010a7f0:	8b 45 08             	mov    0x8(%ebp),%eax
8010a7f3:	01 d0                	add    %edx,%eax
8010a7f5:	83 c0 0c             	add    $0xc,%eax
8010a7f8:	83 ec 0c             	sub    $0xc,%esp
8010a7fb:	50                   	push   %eax
8010a7fc:	e8 9c 04 00 00       	call   8010ac9d <APMsgQueueInit>
8010a801:	83 c4 10             	add    $0x10,%esp
        initlock(&list->data[i].lock, "msglock");
8010a804:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a807:	69 d0 48 03 00 00    	imul   $0x348,%eax,%edx
8010a80d:	8b 45 08             	mov    0x8(%ebp),%eax
8010a810:	01 d0                	add    %edx,%eax
8010a812:	83 c0 08             	add    $0x8,%eax
8010a815:	83 ec 08             	sub    $0x8,%esp
8010a818:	68 03 bb 10 80       	push   $0x8010bb03
8010a81d:	50                   	push   %eax
8010a81e:	e8 1b a6 ff ff       	call   80104e3e <initlock>
8010a823:	83 c4 10             	add    $0x10,%esp

//space--insert_position
void APWndListInit(AWndList * list)
{
    int i = 0;
    for (i = 0; i < MAX_WND_NUM; ++i)
8010a826:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010a82a:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010a82e:	0f 8e 6a ff ff ff    	jle    8010a79e <APWndListInit+0x19>
        list->data[i].prev = -1;
        list->data[i].next = i + 1;
        APMsgQueueInit(&list->data[i].msgQueue);
        initlock(&list->data[i].lock, "msglock");
    }
    list->data[i - 1].next = -1;
8010a834:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a837:	83 e8 01             	sub    $0x1,%eax
8010a83a:	8b 55 08             	mov    0x8(%ebp),%edx
8010a83d:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a843:	01 d0                	add    %edx,%eax
8010a845:	83 c0 04             	add    $0x4,%eax
8010a848:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    initlock(&list->lock, "wndListLock");
8010a84e:	8b 45 08             	mov    0x8(%ebp),%eax
8010a851:	05 e4 20 00 00       	add    $0x20e4,%eax
8010a856:	83 ec 08             	sub    $0x8,%esp
8010a859:	68 0b bb 10 80       	push   $0x8010bb0b
8010a85e:	50                   	push   %eax
8010a85f:	e8 da a5 ff ff       	call   80104e3e <initlock>
8010a864:	83 c4 10             	add    $0x10,%esp
    list->head = list->tail  = -1;
8010a867:	8b 45 08             	mov    0x8(%ebp),%eax
8010a86a:	c7 80 d4 20 00 00 ff 	movl   $0xffffffff,0x20d4(%eax)
8010a871:	ff ff ff 
8010a874:	8b 45 08             	mov    0x8(%ebp),%eax
8010a877:	8b 90 d4 20 00 00    	mov    0x20d4(%eax),%edx
8010a87d:	8b 45 08             	mov    0x8(%ebp),%eax
8010a880:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
    list->desktop = 0;
8010a886:	8b 45 08             	mov    0x8(%ebp),%eax
8010a889:	c7 80 dc 20 00 00 00 	movl   $0x0,0x20dc(%eax)
8010a890:	00 00 00 
    list->space = 0;
8010a893:	8b 45 08             	mov    0x8(%ebp),%eax
8010a896:	c7 80 d8 20 00 00 00 	movl   $0x0,0x20d8(%eax)
8010a89d:	00 00 00 
}
8010a8a0:	90                   	nop
8010a8a1:	c9                   	leave  
8010a8a2:	c3                   	ret    

8010a8a3 <APWndListAddToHead>:

void APWndListAddToHead(AWndList * list, AHwnd hwnd)
{
8010a8a3:	55                   	push   %ebp
8010a8a4:	89 e5                	mov    %esp,%ebp
8010a8a6:	83 ec 18             	sub    $0x18,%esp
    acquire(&list->lock);
8010a8a9:	8b 45 08             	mov    0x8(%ebp),%eax
8010a8ac:	05 e4 20 00 00       	add    $0x20e4,%eax
8010a8b1:	83 ec 0c             	sub    $0xc,%esp
8010a8b4:	50                   	push   %eax
8010a8b5:	e8 a6 a5 ff ff       	call   80104e60 <acquire>
8010a8ba:	83 c4 10             	add    $0x10,%esp
    int p = list->space;
8010a8bd:	8b 45 08             	mov    0x8(%ebp),%eax
8010a8c0:	8b 80 d8 20 00 00    	mov    0x20d8(%eax),%eax
8010a8c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == -1)
8010a8c9:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010a8cd:	75 15                	jne    8010a8e4 <APWndListAddToHead+0x41>
    {
        cprintf("too much window\n");
8010a8cf:	83 ec 0c             	sub    $0xc,%esp
8010a8d2:	68 17 bb 10 80       	push   $0x8010bb17
8010a8d7:	e8 ea 5a ff ff       	call   801003c6 <cprintf>
8010a8dc:	83 c4 10             	add    $0x10,%esp
        return;
8010a8df:	e9 c8 00 00 00       	jmp    8010a9ac <APWndListAddToHead+0x109>
    }
    list->space = list->data[list->space].next;
8010a8e4:	8b 45 08             	mov    0x8(%ebp),%eax
8010a8e7:	8b 80 d8 20 00 00    	mov    0x20d8(%eax),%eax
8010a8ed:	8b 55 08             	mov    0x8(%ebp),%edx
8010a8f0:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a8f6:	01 d0                	add    %edx,%eax
8010a8f8:	83 c0 04             	add    $0x4,%eax
8010a8fb:	8b 10                	mov    (%eax),%edx
8010a8fd:	8b 45 08             	mov    0x8(%ebp),%eax
8010a900:	89 90 d8 20 00 00    	mov    %edx,0x20d8(%eax)
    list->data[p].hwnd = hwnd;
8010a906:	8b 55 08             	mov    0x8(%ebp),%edx
8010a909:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a90c:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a912:	01 d0                	add    %edx,%eax
8010a914:	8d 90 44 03 00 00    	lea    0x344(%eax),%edx
8010a91a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a91d:	89 02                	mov    %eax,(%edx)
    
    hwnd->id = p;
8010a91f:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a922:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a925:	89 10                	mov    %edx,(%eax)
    
    //desktop ---- id = 0
    list->data[p].next = list->head;
8010a927:	8b 45 08             	mov    0x8(%ebp),%eax
8010a92a:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010a930:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010a933:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a936:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010a93c:	01 ca                	add    %ecx,%edx
8010a93e:	83 c2 04             	add    $0x4,%edx
8010a941:	89 02                	mov    %eax,(%edx)
    list->data[p].prev = -1;
8010a943:	8b 55 08             	mov    0x8(%ebp),%edx
8010a946:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a949:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a94f:	01 d0                	add    %edx,%eax
8010a951:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    if (list->head == -1)
8010a957:	8b 45 08             	mov    0x8(%ebp),%eax
8010a95a:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010a960:	83 f8 ff             	cmp    $0xffffffff,%eax
8010a963:	75 0e                	jne    8010a973 <APWndListAddToHead+0xd0>
        list->tail = p;
8010a965:	8b 45 08             	mov    0x8(%ebp),%eax
8010a968:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a96b:	89 90 d4 20 00 00    	mov    %edx,0x20d4(%eax)
8010a971:	eb 19                	jmp    8010a98c <APWndListAddToHead+0xe9>
    else
        list->data[list->head].prev = p;
8010a973:	8b 45 08             	mov    0x8(%ebp),%eax
8010a976:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010a97c:	8b 55 08             	mov    0x8(%ebp),%edx
8010a97f:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a985:	01 c2                	add    %eax,%edx
8010a987:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a98a:	89 02                	mov    %eax,(%edx)
    
    list->head = p;
8010a98c:	8b 45 08             	mov    0x8(%ebp),%eax
8010a98f:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a992:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
    release(&list->lock);
8010a998:	8b 45 08             	mov    0x8(%ebp),%eax
8010a99b:	05 e4 20 00 00       	add    $0x20e4,%eax
8010a9a0:	83 ec 0c             	sub    $0xc,%esp
8010a9a3:	50                   	push   %eax
8010a9a4:	e8 1e a5 ff ff       	call   80104ec7 <release>
8010a9a9:	83 c4 10             	add    $0x10,%esp
}
8010a9ac:	c9                   	leave  
8010a9ad:	c3                   	ret    

8010a9ae <APWndListMoveToHead>:

void APWndListMoveToHead(AWndList * list, int wndId)
{
8010a9ae:	55                   	push   %ebp
8010a9af:	89 e5                	mov    %esp,%ebp
8010a9b1:	83 ec 08             	sub    $0x8,%esp
    if (wndId < 0)
8010a9b4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010a9b8:	0f 88 27 01 00 00    	js     8010aae5 <APWndListMoveToHead+0x137>
        return;
    acquire(&list->lock);
8010a9be:	8b 45 08             	mov    0x8(%ebp),%eax
8010a9c1:	05 e4 20 00 00       	add    $0x20e4,%eax
8010a9c6:	83 ec 0c             	sub    $0xc,%esp
8010a9c9:	50                   	push   %eax
8010a9ca:	e8 91 a4 ff ff       	call   80104e60 <acquire>
8010a9cf:	83 c4 10             	add    $0x10,%esp
    if (wndId != list->head)
8010a9d2:	8b 45 08             	mov    0x8(%ebp),%eax
8010a9d5:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010a9db:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010a9de:	0f 84 eb 00 00 00    	je     8010aacf <APWndListMoveToHead+0x121>
    {
        list->data[list->data[wndId].prev].next = list->data[wndId].next;
8010a9e4:	8b 55 08             	mov    0x8(%ebp),%edx
8010a9e7:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a9ea:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a9f0:	01 d0                	add    %edx,%eax
8010a9f2:	8b 10                	mov    (%eax),%edx
8010a9f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010a9f7:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a9fa:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa00:	01 c8                	add    %ecx,%eax
8010aa02:	83 c0 04             	add    $0x4,%eax
8010aa05:	8b 00                	mov    (%eax),%eax
8010aa07:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aa0a:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010aa10:	01 ca                	add    %ecx,%edx
8010aa12:	83 c2 04             	add    $0x4,%edx
8010aa15:	89 02                	mov    %eax,(%edx)
        if (list->data[wndId].next == -1)
8010aa17:	8b 55 08             	mov    0x8(%ebp),%edx
8010aa1a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa1d:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa23:	01 d0                	add    %edx,%eax
8010aa25:	83 c0 04             	add    $0x4,%eax
8010aa28:	8b 00                	mov    (%eax),%eax
8010aa2a:	83 f8 ff             	cmp    $0xffffffff,%eax
8010aa2d:	75 1b                	jne    8010aa4a <APWndListMoveToHead+0x9c>
            list->tail = list->data[wndId].prev;
8010aa2f:	8b 55 08             	mov    0x8(%ebp),%edx
8010aa32:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa35:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa3b:	01 d0                	add    %edx,%eax
8010aa3d:	8b 10                	mov    (%eax),%edx
8010aa3f:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa42:	89 90 d4 20 00 00    	mov    %edx,0x20d4(%eax)
8010aa48:	eb 30                	jmp    8010aa7a <APWndListMoveToHead+0xcc>
        else
            list->data[list->data[wndId].next].prev = list->data[wndId].prev;
8010aa4a:	8b 55 08             	mov    0x8(%ebp),%edx
8010aa4d:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa50:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa56:	01 d0                	add    %edx,%eax
8010aa58:	83 c0 04             	add    $0x4,%eax
8010aa5b:	8b 10                	mov    (%eax),%edx
8010aa5d:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aa60:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa63:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa69:	01 c8                	add    %ecx,%eax
8010aa6b:	8b 00                	mov    (%eax),%eax
8010aa6d:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aa70:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010aa76:	01 ca                	add    %ecx,%edx
8010aa78:	89 02                	mov    %eax,(%edx)

        list->data[list->head].prev = wndId;
8010aa7a:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa7d:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010aa83:	8b 55 08             	mov    0x8(%ebp),%edx
8010aa86:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa8c:	01 c2                	add    %eax,%edx
8010aa8e:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa91:	89 02                	mov    %eax,(%edx)
        list->data[wndId].prev = -1;
8010aa93:	8b 55 08             	mov    0x8(%ebp),%edx
8010aa96:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa99:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa9f:	01 d0                	add    %edx,%eax
8010aaa1:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
        list->data[wndId].next = list->head;
8010aaa7:	8b 45 08             	mov    0x8(%ebp),%eax
8010aaaa:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010aab0:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aab3:	8b 55 0c             	mov    0xc(%ebp),%edx
8010aab6:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010aabc:	01 ca                	add    %ecx,%edx
8010aabe:	83 c2 04             	add    $0x4,%edx
8010aac1:	89 02                	mov    %eax,(%edx)
        list->head = wndId;
8010aac3:	8b 45 08             	mov    0x8(%ebp),%eax
8010aac6:	8b 55 0c             	mov    0xc(%ebp),%edx
8010aac9:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
    }
    release(&list->lock);
8010aacf:	8b 45 08             	mov    0x8(%ebp),%eax
8010aad2:	05 e4 20 00 00       	add    $0x20e4,%eax
8010aad7:	83 ec 0c             	sub    $0xc,%esp
8010aada:	50                   	push   %eax
8010aadb:	e8 e7 a3 ff ff       	call   80104ec7 <release>
8010aae0:	83 c4 10             	add    $0x10,%esp
8010aae3:	eb 01                	jmp    8010aae6 <APWndListMoveToHead+0x138>
}

void APWndListMoveToHead(AWndList * list, int wndId)
{
    if (wndId < 0)
        return;
8010aae5:	90                   	nop
        list->data[wndId].prev = -1;
        list->data[wndId].next = list->head;
        list->head = wndId;
    }
    release(&list->lock);
}
8010aae6:	c9                   	leave  
8010aae7:	c3                   	ret    

8010aae8 <APWndListRemove>:

void APWndListRemove(AWndList * list, int wndId)
{
8010aae8:	55                   	push   %ebp
8010aae9:	89 e5                	mov    %esp,%ebp
8010aaeb:	83 ec 08             	sub    $0x8,%esp
    if (wndId < 0)
8010aaee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010aaf2:	0f 88 71 01 00 00    	js     8010ac69 <APWndListRemove+0x181>
        return;
    acquire(&list->lock);
8010aaf8:	8b 45 08             	mov    0x8(%ebp),%eax
8010aafb:	05 e4 20 00 00       	add    $0x20e4,%eax
8010ab00:	83 ec 0c             	sub    $0xc,%esp
8010ab03:	50                   	push   %eax
8010ab04:	e8 57 a3 ff ff       	call   80104e60 <acquire>
8010ab09:	83 c4 10             	add    $0x10,%esp
    if (wndId == list->head)
8010ab0c:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab0f:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010ab15:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010ab18:	75 7a                	jne    8010ab94 <APWndListRemove+0xac>
    {
        if (list->data[wndId].next == -1)
8010ab1a:	8b 55 08             	mov    0x8(%ebp),%edx
8010ab1d:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ab20:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ab26:	01 d0                	add    %edx,%eax
8010ab28:	83 c0 04             	add    $0x4,%eax
8010ab2b:	8b 00                	mov    (%eax),%eax
8010ab2d:	83 f8 ff             	cmp    $0xffffffff,%eax
8010ab30:	75 24                	jne    8010ab56 <APWndListRemove+0x6e>
            list->head = list->tail = -1;
8010ab32:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab35:	c7 80 d4 20 00 00 ff 	movl   $0xffffffff,0x20d4(%eax)
8010ab3c:	ff ff ff 
8010ab3f:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab42:	8b 90 d4 20 00 00    	mov    0x20d4(%eax),%edx
8010ab48:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab4b:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
8010ab51:	e9 88 00 00 00       	jmp    8010abde <APWndListRemove+0xf6>
        else
        {
            list->head = list->data[list->head].next;
8010ab56:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab59:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010ab5f:	8b 55 08             	mov    0x8(%ebp),%edx
8010ab62:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ab68:	01 d0                	add    %edx,%eax
8010ab6a:	83 c0 04             	add    $0x4,%eax
8010ab6d:	8b 10                	mov    (%eax),%edx
8010ab6f:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab72:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
            list->data[list->head].prev = -1;
8010ab78:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab7b:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010ab81:	8b 55 08             	mov    0x8(%ebp),%edx
8010ab84:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ab8a:	01 d0                	add    %edx,%eax
8010ab8c:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
8010ab92:	eb 4a                	jmp    8010abde <APWndListRemove+0xf6>
        }
    }
    else if (wndId == list->tail)
8010ab94:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab97:	8b 80 d4 20 00 00    	mov    0x20d4(%eax),%eax
8010ab9d:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010aba0:	75 3c                	jne    8010abde <APWndListRemove+0xf6>
    {
        list->tail = list->data[list->tail].prev;
8010aba2:	8b 45 08             	mov    0x8(%ebp),%eax
8010aba5:	8b 80 d4 20 00 00    	mov    0x20d4(%eax),%eax
8010abab:	8b 55 08             	mov    0x8(%ebp),%edx
8010abae:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010abb4:	01 d0                	add    %edx,%eax
8010abb6:	8b 10                	mov    (%eax),%edx
8010abb8:	8b 45 08             	mov    0x8(%ebp),%eax
8010abbb:	89 90 d4 20 00 00    	mov    %edx,0x20d4(%eax)
        list->data[list->tail].next = -1;
8010abc1:	8b 45 08             	mov    0x8(%ebp),%eax
8010abc4:	8b 80 d4 20 00 00    	mov    0x20d4(%eax),%eax
8010abca:	8b 55 08             	mov    0x8(%ebp),%edx
8010abcd:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010abd3:	01 d0                	add    %edx,%eax
8010abd5:	83 c0 04             	add    $0x4,%eax
8010abd8:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    }
    list->data[wndId].prev = -1;
8010abde:	8b 55 08             	mov    0x8(%ebp),%edx
8010abe1:	8b 45 0c             	mov    0xc(%ebp),%eax
8010abe4:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010abea:	01 d0                	add    %edx,%eax
8010abec:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    list->data[wndId].next = list->space;
8010abf2:	8b 45 08             	mov    0x8(%ebp),%eax
8010abf5:	8b 80 d8 20 00 00    	mov    0x20d8(%eax),%eax
8010abfb:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010abfe:	8b 55 0c             	mov    0xc(%ebp),%edx
8010ac01:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010ac07:	01 ca                	add    %ecx,%edx
8010ac09:	83 c2 04             	add    $0x4,%edx
8010ac0c:	89 02                	mov    %eax,(%edx)
    list->data[wndId].hwnd = 0;
8010ac0e:	8b 55 08             	mov    0x8(%ebp),%edx
8010ac11:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ac14:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ac1a:	01 d0                	add    %edx,%eax
8010ac1c:	05 44 03 00 00       	add    $0x344,%eax
8010ac21:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    list->space = wndId;
8010ac27:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac2a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010ac2d:	89 90 d8 20 00 00    	mov    %edx,0x20d8(%eax)

    APMsgQueueInit(&list->data[wndId].msgQueue);
8010ac33:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ac36:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ac3c:	8d 50 30             	lea    0x30(%eax),%edx
8010ac3f:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac42:	01 d0                	add    %edx,%eax
8010ac44:	83 c0 0c             	add    $0xc,%eax
8010ac47:	83 ec 0c             	sub    $0xc,%esp
8010ac4a:	50                   	push   %eax
8010ac4b:	e8 4d 00 00 00       	call   8010ac9d <APMsgQueueInit>
8010ac50:	83 c4 10             	add    $0x10,%esp
    
    release(&list->lock);
8010ac53:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac56:	05 e4 20 00 00       	add    $0x20e4,%eax
8010ac5b:	83 ec 0c             	sub    $0xc,%esp
8010ac5e:	50                   	push   %eax
8010ac5f:	e8 63 a2 ff ff       	call   80104ec7 <release>
8010ac64:	83 c4 10             	add    $0x10,%esp
8010ac67:	eb 01                	jmp    8010ac6a <APWndListRemove+0x182>
}

void APWndListRemove(AWndList * list, int wndId)
{
    if (wndId < 0)
        return;
8010ac69:	90                   	nop
    list->space = wndId;

    APMsgQueueInit(&list->data[wndId].msgQueue);
    
    release(&list->lock);
}
8010ac6a:	c9                   	leave  
8010ac6b:	c3                   	ret    

8010ac6c <APWndListDestroy>:

void APWndListDestroy(AWndList * list)
{
8010ac6c:	55                   	push   %ebp
8010ac6d:	89 e5                	mov    %esp,%ebp
8010ac6f:	83 ec 08             	sub    $0x8,%esp
    acquire(&list->lock);
8010ac72:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac75:	05 e4 20 00 00       	add    $0x20e4,%eax
8010ac7a:	83 ec 0c             	sub    $0xc,%esp
8010ac7d:	50                   	push   %eax
8010ac7e:	e8 dd a1 ff ff       	call   80104e60 <acquire>
8010ac83:	83 c4 10             	add    $0x10,%esp
    release(&list->lock);
8010ac86:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac89:	05 e4 20 00 00       	add    $0x20e4,%eax
8010ac8e:	83 ec 0c             	sub    $0xc,%esp
8010ac91:	50                   	push   %eax
8010ac92:	e8 30 a2 ff ff       	call   80104ec7 <release>
8010ac97:	83 c4 10             	add    $0x10,%esp
}
8010ac9a:	90                   	nop
8010ac9b:	c9                   	leave  
8010ac9c:	c3                   	ret    

8010ac9d <APMsgQueueInit>:

//Msg Queue
//head = start, tail = end next

void APMsgQueueInit(AMsgQueue * queue)
{
8010ac9d:	55                   	push   %ebp
8010ac9e:	89 e5                	mov    %esp,%ebp
    // as an array
    queue->head = queue->tail = 0;
8010aca0:	8b 45 08             	mov    0x8(%ebp),%eax
8010aca3:	c7 80 04 03 00 00 00 	movl   $0x0,0x304(%eax)
8010acaa:	00 00 00 
8010acad:	8b 45 08             	mov    0x8(%ebp),%eax
8010acb0:	8b 90 04 03 00 00    	mov    0x304(%eax),%edx
8010acb6:	8b 45 08             	mov    0x8(%ebp),%eax
8010acb9:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
}
8010acbf:	90                   	nop
8010acc0:	5d                   	pop    %ebp
8010acc1:	c3                   	ret    

8010acc2 <APMsgQueueEnQueue>:

void APMsgQueueEnQueue(AMsgQueue * queue, AMessage msg)
{
8010acc2:	55                   	push   %ebp
8010acc3:	89 e5                	mov    %esp,%ebp
8010acc5:	83 ec 08             	sub    $0x8,%esp
    if ((queue->tail + 1) % MESSAGE_QUEUE_SIZE == queue->head)
8010acc8:	8b 45 08             	mov    0x8(%ebp),%eax
8010accb:	8b 80 04 03 00 00    	mov    0x304(%eax),%eax
8010acd1:	83 c0 01             	add    $0x1,%eax
8010acd4:	83 e0 3f             	and    $0x3f,%eax
8010acd7:	89 c2                	mov    %eax,%edx
8010acd9:	8b 45 08             	mov    0x8(%ebp),%eax
8010acdc:	8b 80 00 03 00 00    	mov    0x300(%eax),%eax
8010ace2:	39 c2                	cmp    %eax,%edx
8010ace4:	75 12                	jne    8010acf8 <APMsgQueueEnQueue+0x36>
    {
        cprintf("Error! Message Queue is full\n");
8010ace6:	83 ec 0c             	sub    $0xc,%esp
8010ace9:	68 28 bb 10 80       	push   $0x8010bb28
8010acee:	e8 d3 56 ff ff       	call   801003c6 <cprintf>
8010acf3:	83 c4 10             	add    $0x10,%esp
        return;
8010acf6:	eb 43                	jmp    8010ad3b <APMsgQueueEnQueue+0x79>
    }
    
    switch (msg.type)
    {
        default:
            break;
8010acf8:	90                   	nop
    }
    //cprintf("MsgQueue-En-Queue:tail %d \n",queue->tail);
    queue->data[queue->tail] = msg;
8010acf9:	8b 45 08             	mov    0x8(%ebp),%eax
8010acfc:	8b 90 04 03 00 00    	mov    0x304(%eax),%edx
8010ad02:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010ad05:	89 d0                	mov    %edx,%eax
8010ad07:	01 c0                	add    %eax,%eax
8010ad09:	01 d0                	add    %edx,%eax
8010ad0b:	c1 e0 02             	shl    $0x2,%eax
8010ad0e:	01 c8                	add    %ecx,%eax
8010ad10:	8b 55 0c             	mov    0xc(%ebp),%edx
8010ad13:	89 10                	mov    %edx,(%eax)
8010ad15:	8b 55 10             	mov    0x10(%ebp),%edx
8010ad18:	89 50 04             	mov    %edx,0x4(%eax)
8010ad1b:	8b 55 14             	mov    0x14(%ebp),%edx
8010ad1e:	89 50 08             	mov    %edx,0x8(%eax)
    queue->tail = (queue->tail + 1) % MESSAGE_QUEUE_SIZE;
8010ad21:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad24:	8b 80 04 03 00 00    	mov    0x304(%eax),%eax
8010ad2a:	83 c0 01             	add    $0x1,%eax
8010ad2d:	83 e0 3f             	and    $0x3f,%eax
8010ad30:	89 c2                	mov    %eax,%edx
8010ad32:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad35:	89 90 04 03 00 00    	mov    %edx,0x304(%eax)
    //cprintf("MsgQueue-En-Queue:after add tail %d \n",queue->tail);
}
8010ad3b:	c9                   	leave  
8010ad3c:	c3                   	ret    

8010ad3d <APMsgQueueDeQueue>:

//弹出消息队列顶端
AMessage APMsgQueueDeQueue(AMsgQueue * queue)
{
8010ad3d:	55                   	push   %ebp
8010ad3e:	89 e5                	mov    %esp,%ebp
8010ad40:	53                   	push   %ebx
8010ad41:	83 ec 10             	sub    $0x10,%esp
    if (queue->head == queue->tail)
8010ad44:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad47:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010ad4d:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad50:	8b 80 04 03 00 00    	mov    0x304(%eax),%eax
8010ad56:	39 c2                	cmp    %eax,%edx
8010ad58:	75 1d                	jne    8010ad77 <APMsgQueueDeQueue+0x3a>
    {
        AMessage msg;
        msg.type = MSG_NULL;
8010ad5a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        return msg;
8010ad61:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad64:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010ad67:	89 10                	mov    %edx,(%eax)
8010ad69:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010ad6c:	89 50 04             	mov    %edx,0x4(%eax)
8010ad6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ad72:	89 50 08             	mov    %edx,0x8(%eax)
8010ad75:	eb 4a                	jmp    8010adc1 <APMsgQueueDeQueue+0x84>
    }
    int p = queue->head;
8010ad77:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad7a:	8b 80 00 03 00 00    	mov    0x300(%eax),%eax
8010ad80:	89 45 f8             	mov    %eax,-0x8(%ebp)
    queue->head = (queue->head + 1) % MESSAGE_QUEUE_SIZE;
8010ad83:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad86:	8b 80 00 03 00 00    	mov    0x300(%eax),%eax
8010ad8c:	83 c0 01             	add    $0x1,%eax
8010ad8f:	83 e0 3f             	and    $0x3f,%eax
8010ad92:	89 c2                	mov    %eax,%edx
8010ad94:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad97:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
    return queue->data[p];
8010ad9d:	8b 55 08             	mov    0x8(%ebp),%edx
8010ada0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010ada3:	8b 4d f8             	mov    -0x8(%ebp),%ecx
8010ada6:	89 c8                	mov    %ecx,%eax
8010ada8:	01 c0                	add    %eax,%eax
8010adaa:	01 c8                	add    %ecx,%eax
8010adac:	c1 e0 02             	shl    $0x2,%eax
8010adaf:	01 d8                	add    %ebx,%eax
8010adb1:	8b 08                	mov    (%eax),%ecx
8010adb3:	89 0a                	mov    %ecx,(%edx)
8010adb5:	8b 48 04             	mov    0x4(%eax),%ecx
8010adb8:	89 4a 04             	mov    %ecx,0x4(%edx)
8010adbb:	8b 40 08             	mov    0x8(%eax),%eax
8010adbe:	89 42 08             	mov    %eax,0x8(%edx)
}
8010adc1:	8b 45 08             	mov    0x8(%ebp),%eax
8010adc4:	83 c4 10             	add    $0x10,%esp
8010adc7:	5b                   	pop    %ebx
8010adc8:	5d                   	pop    %ebp
8010adc9:	c2 04 00             	ret    $0x4

8010adcc <TimerCount>:

//-----------------------------------------------------------------------------
//Timer
void TimerCount()
{
8010adcc:	55                   	push   %ebp
8010adcd:	89 e5                	mov    %esp,%ebp
8010adcf:	83 ec 18             	sub    $0x18,%esp
    if (!timerListReady)
8010add2:	a1 9c e6 10 80       	mov    0x8010e69c,%eax
8010add7:	85 c0                	test   %eax,%eax
8010add9:	0f 84 ea 00 00 00    	je     8010aec9 <TimerCount+0xfd>
        return;
    acquire(&timerList.lock);
8010addf:	83 ec 0c             	sub    $0xc,%esp
8010ade2:	68 50 bc 11 80       	push   $0x8011bc50
8010ade7:	e8 74 a0 ff ff       	call   80104e60 <acquire>
8010adec:	83 c4 10             	add    $0x10,%esp
    int p = timerList.head;
8010adef:	a1 48 bc 11 80       	mov    0x8011bc48,%eax
8010adf4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while(p != -1)
8010adf7:	e9 b1 00 00 00       	jmp    8010aead <TimerCount+0xe1>
    {
        timerList.data[p].count ++;
8010adfc:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010adff:	89 d0                	mov    %edx,%eax
8010ae01:	c1 e0 02             	shl    $0x2,%eax
8010ae04:	01 d0                	add    %edx,%eax
8010ae06:	c1 e0 02             	shl    $0x2,%eax
8010ae09:	05 8c bb 11 80       	add    $0x8011bb8c,%eax
8010ae0e:	8b 00                	mov    (%eax),%eax
8010ae10:	8d 48 01             	lea    0x1(%eax),%ecx
8010ae13:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae16:	89 d0                	mov    %edx,%eax
8010ae18:	c1 e0 02             	shl    $0x2,%eax
8010ae1b:	01 d0                	add    %edx,%eax
8010ae1d:	c1 e0 02             	shl    $0x2,%eax
8010ae20:	05 8c bb 11 80       	add    $0x8011bb8c,%eax
8010ae25:	89 08                	mov    %ecx,(%eax)
        if (timerList.data[p].count >= timerList.data[p].interval)
8010ae27:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae2a:	89 d0                	mov    %edx,%eax
8010ae2c:	c1 e0 02             	shl    $0x2,%eax
8010ae2f:	01 d0                	add    %edx,%eax
8010ae31:	c1 e0 02             	shl    $0x2,%eax
8010ae34:	05 8c bb 11 80       	add    $0x8011bb8c,%eax
8010ae39:	8b 08                	mov    (%eax),%ecx
8010ae3b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae3e:	89 d0                	mov    %edx,%eax
8010ae40:	c1 e0 02             	shl    $0x2,%eax
8010ae43:	01 d0                	add    %edx,%eax
8010ae45:	c1 e0 02             	shl    $0x2,%eax
8010ae48:	05 88 bb 11 80       	add    $0x8011bb88,%eax
8010ae4d:	8b 00                	mov    (%eax),%eax
8010ae4f:	39 c1                	cmp    %eax,%ecx
8010ae51:	7c 43                	jl     8010ae96 <TimerCount+0xca>
        {
            timerList.data[p].count = 0;
8010ae53:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae56:	89 d0                	mov    %edx,%eax
8010ae58:	c1 e0 02             	shl    $0x2,%eax
8010ae5b:	01 d0                	add    %edx,%eax
8010ae5d:	c1 e0 02             	shl    $0x2,%eax
8010ae60:	05 8c bb 11 80       	add    $0x8011bb8c,%eax
8010ae65:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
            AMessage msg;
            msg.type = MSG_TIMEOUT;
8010ae6b:	c7 45 e8 04 00 00 00 	movl   $0x4,-0x18(%ebp)
            sendMessage(timerList.data[p].wndId,&msg);
8010ae72:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae75:	89 d0                	mov    %edx,%eax
8010ae77:	c1 e0 02             	shl    $0x2,%eax
8010ae7a:	01 d0                	add    %edx,%eax
8010ae7c:	c1 e0 02             	shl    $0x2,%eax
8010ae7f:	05 80 bb 11 80       	add    $0x8011bb80,%eax
8010ae84:	8b 00                	mov    (%eax),%eax
8010ae86:	83 ec 08             	sub    $0x8,%esp
8010ae89:	8d 55 e8             	lea    -0x18(%ebp),%edx
8010ae8c:	52                   	push   %edx
8010ae8d:	50                   	push   %eax
8010ae8e:	e8 1c f8 ff ff       	call   8010a6af <sendMessage>
8010ae93:	83 c4 10             	add    $0x10,%esp
        }
        p = timerList.data[p].next;
8010ae96:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae99:	89 d0                	mov    %edx,%eax
8010ae9b:	c1 e0 02             	shl    $0x2,%eax
8010ae9e:	01 d0                	add    %edx,%eax
8010aea0:	c1 e0 02             	shl    $0x2,%eax
8010aea3:	05 90 bb 11 80       	add    $0x8011bb90,%eax
8010aea8:	8b 00                	mov    (%eax),%eax
8010aeaa:	89 45 f4             	mov    %eax,-0xc(%ebp)
{
    if (!timerListReady)
        return;
    acquire(&timerList.lock);
    int p = timerList.head;
    while(p != -1)
8010aead:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010aeb1:	0f 85 45 ff ff ff    	jne    8010adfc <TimerCount+0x30>
            msg.type = MSG_TIMEOUT;
            sendMessage(timerList.data[p].wndId,&msg);
        }
        p = timerList.data[p].next;
    }
    release(&timerList.lock);
8010aeb7:	83 ec 0c             	sub    $0xc,%esp
8010aeba:	68 50 bc 11 80       	push   $0x8011bc50
8010aebf:	e8 03 a0 ff ff       	call   80104ec7 <release>
8010aec4:	83 c4 10             	add    $0x10,%esp
8010aec7:	eb 01                	jmp    8010aeca <TimerCount+0xfe>
//-----------------------------------------------------------------------------
//Timer
void TimerCount()
{
    if (!timerListReady)
        return;
8010aec9:	90                   	nop
            sendMessage(timerList.data[p].wndId,&msg);
        }
        p = timerList.data[p].next;
    }
    release(&timerList.lock);
}
8010aeca:	c9                   	leave  
8010aecb:	c3                   	ret    

8010aecc <APTimerListInit>:


void APTimerListInit(ATimerList * list)
{
8010aecc:	55                   	push   %ebp
8010aecd:	89 e5                	mov    %esp,%ebp
8010aecf:	53                   	push   %ebx
8010aed0:	83 ec 14             	sub    $0x14,%esp
    int i;
    for (i = 0; i < MAX_TIMER_NUM; i++)
8010aed3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010aeda:	eb 21                	jmp    8010aefd <APTimerListInit+0x31>
        list->data[i].next = i + 1;
8010aedc:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010aedf:	8d 48 01             	lea    0x1(%eax),%ecx
8010aee2:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010aee5:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010aee8:	89 d0                	mov    %edx,%eax
8010aeea:	c1 e0 02             	shl    $0x2,%eax
8010aeed:	01 d0                	add    %edx,%eax
8010aeef:	c1 e0 02             	shl    $0x2,%eax
8010aef2:	01 d8                	add    %ebx,%eax
8010aef4:	83 c0 10             	add    $0x10,%eax
8010aef7:	89 08                	mov    %ecx,(%eax)


void APTimerListInit(ATimerList * list)
{
    int i;
    for (i = 0; i < MAX_TIMER_NUM; i++)
8010aef9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010aefd:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010af01:	7e d9                	jle    8010aedc <APTimerListInit+0x10>
        list->data[i].next = i + 1;
    list->head = -1;
8010af03:	8b 45 08             	mov    0x8(%ebp),%eax
8010af06:	c7 80 c8 00 00 00 ff 	movl   $0xffffffff,0xc8(%eax)
8010af0d:	ff ff ff 
    list->space = 0;
8010af10:	8b 45 08             	mov    0x8(%ebp),%eax
8010af13:	c7 80 cc 00 00 00 00 	movl   $0x0,0xcc(%eax)
8010af1a:	00 00 00 
    list->data[i].next = -1;
8010af1d:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010af20:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010af23:	89 d0                	mov    %edx,%eax
8010af25:	c1 e0 02             	shl    $0x2,%eax
8010af28:	01 d0                	add    %edx,%eax
8010af2a:	c1 e0 02             	shl    $0x2,%eax
8010af2d:	01 c8                	add    %ecx,%eax
8010af2f:	83 c0 10             	add    $0x10,%eax
8010af32:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    initlock(&list->lock, "timerLock");
8010af38:	8b 45 08             	mov    0x8(%ebp),%eax
8010af3b:	05 d0 00 00 00       	add    $0xd0,%eax
8010af40:	83 ec 08             	sub    $0x8,%esp
8010af43:	68 46 bb 10 80       	push   $0x8010bb46
8010af48:	50                   	push   %eax
8010af49:	e8 f0 9e ff ff       	call   80104e3e <initlock>
8010af4e:	83 c4 10             	add    $0x10,%esp
    timerListReady = 1;
8010af51:	c7 05 9c e6 10 80 01 	movl   $0x1,0x8010e69c
8010af58:	00 00 00 
}
8010af5b:	90                   	nop
8010af5c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010af5f:	c9                   	leave  
8010af60:	c3                   	ret    

8010af61 <APTimerListAddToHead>:

void APTimerListAddToHead(ATimerList * list, int wndId, int id, int interval)
{
8010af61:	55                   	push   %ebp
8010af62:	89 e5                	mov    %esp,%ebp
8010af64:	53                   	push   %ebx
8010af65:	83 ec 14             	sub    $0x14,%esp
    acquire(&list->lock);
8010af68:	8b 45 08             	mov    0x8(%ebp),%eax
8010af6b:	05 d0 00 00 00       	add    $0xd0,%eax
8010af70:	83 ec 0c             	sub    $0xc,%esp
8010af73:	50                   	push   %eax
8010af74:	e8 e7 9e ff ff       	call   80104e60 <acquire>
8010af79:	83 c4 10             	add    $0x10,%esp
    int p = list->space;
8010af7c:	8b 45 08             	mov    0x8(%ebp),%eax
8010af7f:	8b 80 cc 00 00 00    	mov    0xcc(%eax),%eax
8010af85:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == -1)
8010af88:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010af8c:	75 15                	jne    8010afa3 <APTimerListAddToHead+0x42>
    {
        cprintf("Error! Too much Timer!\n");
8010af8e:	83 ec 0c             	sub    $0xc,%esp
8010af91:	68 50 bb 10 80       	push   $0x8010bb50
8010af96:	e8 2b 54 ff ff       	call   801003c6 <cprintf>
8010af9b:	83 c4 10             	add    $0x10,%esp
        return;
8010af9e:	e9 c7 00 00 00       	jmp    8010b06a <APTimerListAddToHead+0x109>
    }
    list->space = list->data[p].next;
8010afa3:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010afa6:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010afa9:	89 d0                	mov    %edx,%eax
8010afab:	c1 e0 02             	shl    $0x2,%eax
8010afae:	01 d0                	add    %edx,%eax
8010afb0:	c1 e0 02             	shl    $0x2,%eax
8010afb3:	01 c8                	add    %ecx,%eax
8010afb5:	83 c0 10             	add    $0x10,%eax
8010afb8:	8b 10                	mov    (%eax),%edx
8010afba:	8b 45 08             	mov    0x8(%ebp),%eax
8010afbd:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
    list->data[p].next = list->head;
8010afc3:	8b 45 08             	mov    0x8(%ebp),%eax
8010afc6:	8b 88 c8 00 00 00    	mov    0xc8(%eax),%ecx
8010afcc:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010afcf:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010afd2:	89 d0                	mov    %edx,%eax
8010afd4:	c1 e0 02             	shl    $0x2,%eax
8010afd7:	01 d0                	add    %edx,%eax
8010afd9:	c1 e0 02             	shl    $0x2,%eax
8010afdc:	01 d8                	add    %ebx,%eax
8010afde:	83 c0 10             	add    $0x10,%eax
8010afe1:	89 08                	mov    %ecx,(%eax)
    list->head = p;
8010afe3:	8b 45 08             	mov    0x8(%ebp),%eax
8010afe6:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010afe9:	89 90 c8 00 00 00    	mov    %edx,0xc8(%eax)
    list->data[p].wndId = wndId;
8010afef:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aff2:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010aff5:	89 d0                	mov    %edx,%eax
8010aff7:	c1 e0 02             	shl    $0x2,%eax
8010affa:	01 d0                	add    %edx,%eax
8010affc:	c1 e0 02             	shl    $0x2,%eax
8010afff:	8d 14 01             	lea    (%ecx,%eax,1),%edx
8010b002:	8b 45 0c             	mov    0xc(%ebp),%eax
8010b005:	89 02                	mov    %eax,(%edx)
    list->data[p].id = id;
8010b007:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b00a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b00d:	89 d0                	mov    %edx,%eax
8010b00f:	c1 e0 02             	shl    $0x2,%eax
8010b012:	01 d0                	add    %edx,%eax
8010b014:	c1 e0 02             	shl    $0x2,%eax
8010b017:	01 c8                	add    %ecx,%eax
8010b019:	8d 50 04             	lea    0x4(%eax),%edx
8010b01c:	8b 45 10             	mov    0x10(%ebp),%eax
8010b01f:	89 02                	mov    %eax,(%edx)
    list->data[p].interval = interval;
8010b021:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b024:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b027:	89 d0                	mov    %edx,%eax
8010b029:	c1 e0 02             	shl    $0x2,%eax
8010b02c:	01 d0                	add    %edx,%eax
8010b02e:	c1 e0 02             	shl    $0x2,%eax
8010b031:	01 c8                	add    %ecx,%eax
8010b033:	8d 50 08             	lea    0x8(%eax),%edx
8010b036:	8b 45 14             	mov    0x14(%ebp),%eax
8010b039:	89 02                	mov    %eax,(%edx)
    list->data[p].count = 0;
8010b03b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b03e:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b041:	89 d0                	mov    %edx,%eax
8010b043:	c1 e0 02             	shl    $0x2,%eax
8010b046:	01 d0                	add    %edx,%eax
8010b048:	c1 e0 02             	shl    $0x2,%eax
8010b04b:	01 c8                	add    %ecx,%eax
8010b04d:	83 c0 0c             	add    $0xc,%eax
8010b050:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    release(&list->lock);
8010b056:	8b 45 08             	mov    0x8(%ebp),%eax
8010b059:	05 d0 00 00 00       	add    $0xd0,%eax
8010b05e:	83 ec 0c             	sub    $0xc,%esp
8010b061:	50                   	push   %eax
8010b062:	e8 60 9e ff ff       	call   80104ec7 <release>
8010b067:	83 c4 10             	add    $0x10,%esp
    
}
8010b06a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010b06d:	c9                   	leave  
8010b06e:	c3                   	ret    

8010b06f <APTimerListRemoveWnd>:

void APTimerListRemoveWnd(ATimerList * list, int wndId)
{
8010b06f:	55                   	push   %ebp
8010b070:	89 e5                	mov    %esp,%ebp
8010b072:	53                   	push   %ebx
8010b073:	83 ec 14             	sub    $0x14,%esp
    acquire(&list->lock);
8010b076:	8b 45 08             	mov    0x8(%ebp),%eax
8010b079:	05 d0 00 00 00       	add    $0xd0,%eax
8010b07e:	83 ec 0c             	sub    $0xc,%esp
8010b081:	50                   	push   %eax
8010b082:	e8 d9 9d ff ff       	call   80104e60 <acquire>
8010b087:	83 c4 10             	add    $0x10,%esp
    int p = list->head;
8010b08a:	8b 45 08             	mov    0x8(%ebp),%eax
8010b08d:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b093:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int q = p;
8010b096:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b099:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (p != -1)
8010b09c:	e9 24 01 00 00       	jmp    8010b1c5 <APTimerListRemoveWnd+0x156>
    {
        if (list->data[p].wndId == wndId)
8010b0a1:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b0a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b0a7:	89 d0                	mov    %edx,%eax
8010b0a9:	c1 e0 02             	shl    $0x2,%eax
8010b0ac:	01 d0                	add    %edx,%eax
8010b0ae:	c1 e0 02             	shl    $0x2,%eax
8010b0b1:	01 c8                	add    %ecx,%eax
8010b0b3:	8b 00                	mov    (%eax),%eax
8010b0b5:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010b0b8:	0f 85 e7 00 00 00    	jne    8010b1a5 <APTimerListRemoveWnd+0x136>
        {
            if (p == list->head)
8010b0be:	8b 45 08             	mov    0x8(%ebp),%eax
8010b0c1:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b0c7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010b0ca:	75 63                	jne    8010b12f <APTimerListRemoveWnd+0xc0>
            {
                list->head = list->data[p].next;
8010b0cc:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b0cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b0d2:	89 d0                	mov    %edx,%eax
8010b0d4:	c1 e0 02             	shl    $0x2,%eax
8010b0d7:	01 d0                	add    %edx,%eax
8010b0d9:	c1 e0 02             	shl    $0x2,%eax
8010b0dc:	01 c8                	add    %ecx,%eax
8010b0de:	83 c0 10             	add    $0x10,%eax
8010b0e1:	8b 10                	mov    (%eax),%edx
8010b0e3:	8b 45 08             	mov    0x8(%ebp),%eax
8010b0e6:	89 90 c8 00 00 00    	mov    %edx,0xc8(%eax)
                list->data[p].next = list->space;
8010b0ec:	8b 45 08             	mov    0x8(%ebp),%eax
8010b0ef:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b0f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b0f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b0fb:	89 d0                	mov    %edx,%eax
8010b0fd:	c1 e0 02             	shl    $0x2,%eax
8010b100:	01 d0                	add    %edx,%eax
8010b102:	c1 e0 02             	shl    $0x2,%eax
8010b105:	01 d8                	add    %ebx,%eax
8010b107:	83 c0 10             	add    $0x10,%eax
8010b10a:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b10c:	8b 45 08             	mov    0x8(%ebp),%eax
8010b10f:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b112:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->head;
8010b118:	8b 45 08             	mov    0x8(%ebp),%eax
8010b11b:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b121:	89 45 f4             	mov    %eax,-0xc(%ebp)
                q = p;
8010b124:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b127:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010b12a:	e9 96 00 00 00       	jmp    8010b1c5 <APTimerListRemoveWnd+0x156>
            }
            else
            {
                list->data[q].next = list->data[p].next;
8010b12f:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b132:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b135:	89 d0                	mov    %edx,%eax
8010b137:	c1 e0 02             	shl    $0x2,%eax
8010b13a:	01 d0                	add    %edx,%eax
8010b13c:	c1 e0 02             	shl    $0x2,%eax
8010b13f:	01 c8                	add    %ecx,%eax
8010b141:	83 c0 10             	add    $0x10,%eax
8010b144:	8b 08                	mov    (%eax),%ecx
8010b146:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b149:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b14c:	89 d0                	mov    %edx,%eax
8010b14e:	c1 e0 02             	shl    $0x2,%eax
8010b151:	01 d0                	add    %edx,%eax
8010b153:	c1 e0 02             	shl    $0x2,%eax
8010b156:	01 d8                	add    %ebx,%eax
8010b158:	83 c0 10             	add    $0x10,%eax
8010b15b:	89 08                	mov    %ecx,(%eax)
                list->data[p].next = list->space;
8010b15d:	8b 45 08             	mov    0x8(%ebp),%eax
8010b160:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b166:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b169:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b16c:	89 d0                	mov    %edx,%eax
8010b16e:	c1 e0 02             	shl    $0x2,%eax
8010b171:	01 d0                	add    %edx,%eax
8010b173:	c1 e0 02             	shl    $0x2,%eax
8010b176:	01 d8                	add    %ebx,%eax
8010b178:	83 c0 10             	add    $0x10,%eax
8010b17b:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b17d:	8b 45 08             	mov    0x8(%ebp),%eax
8010b180:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b183:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->data[q].next;
8010b189:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b18c:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b18f:	89 d0                	mov    %edx,%eax
8010b191:	c1 e0 02             	shl    $0x2,%eax
8010b194:	01 d0                	add    %edx,%eax
8010b196:	c1 e0 02             	shl    $0x2,%eax
8010b199:	01 c8                	add    %ecx,%eax
8010b19b:	83 c0 10             	add    $0x10,%eax
8010b19e:	8b 00                	mov    (%eax),%eax
8010b1a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010b1a3:	eb 20                	jmp    8010b1c5 <APTimerListRemoveWnd+0x156>
            }
        }
        else
        {
            q = p;
8010b1a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b1a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
            p = list->data[p].next;
8010b1ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b1ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b1b1:	89 d0                	mov    %edx,%eax
8010b1b3:	c1 e0 02             	shl    $0x2,%eax
8010b1b6:	01 d0                	add    %edx,%eax
8010b1b8:	c1 e0 02             	shl    $0x2,%eax
8010b1bb:	01 c8                	add    %ecx,%eax
8010b1bd:	83 c0 10             	add    $0x10,%eax
8010b1c0:	8b 00                	mov    (%eax),%eax
8010b1c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
void APTimerListRemoveWnd(ATimerList * list, int wndId)
{
    acquire(&list->lock);
    int p = list->head;
    int q = p;
    while (p != -1)
8010b1c5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010b1c9:	0f 85 d2 fe ff ff    	jne    8010b0a1 <APTimerListRemoveWnd+0x32>
        {
            q = p;
            p = list->data[p].next;
        }
    }
    release(&list->lock);
8010b1cf:	8b 45 08             	mov    0x8(%ebp),%eax
8010b1d2:	05 d0 00 00 00       	add    $0xd0,%eax
8010b1d7:	83 ec 0c             	sub    $0xc,%esp
8010b1da:	50                   	push   %eax
8010b1db:	e8 e7 9c ff ff       	call   80104ec7 <release>
8010b1e0:	83 c4 10             	add    $0x10,%esp
}
8010b1e3:	90                   	nop
8010b1e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010b1e7:	c9                   	leave  
8010b1e8:	c3                   	ret    

8010b1e9 <APTimerListRemoveID>:

void APTimerListRemoveID(ATimerList * list, int wndId, int id)
{
8010b1e9:	55                   	push   %ebp
8010b1ea:	89 e5                	mov    %esp,%ebp
8010b1ec:	53                   	push   %ebx
8010b1ed:	83 ec 14             	sub    $0x14,%esp
    acquire(&list->lock);
8010b1f0:	8b 45 08             	mov    0x8(%ebp),%eax
8010b1f3:	05 d0 00 00 00       	add    $0xd0,%eax
8010b1f8:	83 ec 0c             	sub    $0xc,%esp
8010b1fb:	50                   	push   %eax
8010b1fc:	e8 5f 9c ff ff       	call   80104e60 <acquire>
8010b201:	83 c4 10             	add    $0x10,%esp
    int p = list->head;
8010b204:	8b 45 08             	mov    0x8(%ebp),%eax
8010b207:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b20d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int q = p;
8010b210:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b213:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (p != -1)
8010b216:	e9 44 01 00 00       	jmp    8010b35f <APTimerListRemoveID+0x176>
    {
        if (list->data[p].wndId == wndId && list->data[p].id == id)
8010b21b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b21e:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b221:	89 d0                	mov    %edx,%eax
8010b223:	c1 e0 02             	shl    $0x2,%eax
8010b226:	01 d0                	add    %edx,%eax
8010b228:	c1 e0 02             	shl    $0x2,%eax
8010b22b:	01 c8                	add    %ecx,%eax
8010b22d:	8b 00                	mov    (%eax),%eax
8010b22f:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010b232:	0f 85 07 01 00 00    	jne    8010b33f <APTimerListRemoveID+0x156>
8010b238:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b23b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b23e:	89 d0                	mov    %edx,%eax
8010b240:	c1 e0 02             	shl    $0x2,%eax
8010b243:	01 d0                	add    %edx,%eax
8010b245:	c1 e0 02             	shl    $0x2,%eax
8010b248:	01 c8                	add    %ecx,%eax
8010b24a:	83 c0 04             	add    $0x4,%eax
8010b24d:	8b 00                	mov    (%eax),%eax
8010b24f:	3b 45 10             	cmp    0x10(%ebp),%eax
8010b252:	0f 85 e7 00 00 00    	jne    8010b33f <APTimerListRemoveID+0x156>
        {
            if (p == list->head)
8010b258:	8b 45 08             	mov    0x8(%ebp),%eax
8010b25b:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b261:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010b264:	75 63                	jne    8010b2c9 <APTimerListRemoveID+0xe0>
            {
                list->head = list->data[p].next;
8010b266:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b269:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b26c:	89 d0                	mov    %edx,%eax
8010b26e:	c1 e0 02             	shl    $0x2,%eax
8010b271:	01 d0                	add    %edx,%eax
8010b273:	c1 e0 02             	shl    $0x2,%eax
8010b276:	01 c8                	add    %ecx,%eax
8010b278:	83 c0 10             	add    $0x10,%eax
8010b27b:	8b 10                	mov    (%eax),%edx
8010b27d:	8b 45 08             	mov    0x8(%ebp),%eax
8010b280:	89 90 c8 00 00 00    	mov    %edx,0xc8(%eax)
                list->data[p].next = list->space;
8010b286:	8b 45 08             	mov    0x8(%ebp),%eax
8010b289:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b28f:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b292:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b295:	89 d0                	mov    %edx,%eax
8010b297:	c1 e0 02             	shl    $0x2,%eax
8010b29a:	01 d0                	add    %edx,%eax
8010b29c:	c1 e0 02             	shl    $0x2,%eax
8010b29f:	01 d8                	add    %ebx,%eax
8010b2a1:	83 c0 10             	add    $0x10,%eax
8010b2a4:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b2a6:	8b 45 08             	mov    0x8(%ebp),%eax
8010b2a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b2ac:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->head;
8010b2b2:	8b 45 08             	mov    0x8(%ebp),%eax
8010b2b5:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b2bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
                q = p;
8010b2be:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b2c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010b2c4:	e9 96 00 00 00       	jmp    8010b35f <APTimerListRemoveID+0x176>
            }
            else
            {
                list->data[q].next = list->data[p].next;
8010b2c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b2cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b2cf:	89 d0                	mov    %edx,%eax
8010b2d1:	c1 e0 02             	shl    $0x2,%eax
8010b2d4:	01 d0                	add    %edx,%eax
8010b2d6:	c1 e0 02             	shl    $0x2,%eax
8010b2d9:	01 c8                	add    %ecx,%eax
8010b2db:	83 c0 10             	add    $0x10,%eax
8010b2de:	8b 08                	mov    (%eax),%ecx
8010b2e0:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b2e3:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b2e6:	89 d0                	mov    %edx,%eax
8010b2e8:	c1 e0 02             	shl    $0x2,%eax
8010b2eb:	01 d0                	add    %edx,%eax
8010b2ed:	c1 e0 02             	shl    $0x2,%eax
8010b2f0:	01 d8                	add    %ebx,%eax
8010b2f2:	83 c0 10             	add    $0x10,%eax
8010b2f5:	89 08                	mov    %ecx,(%eax)
                list->data[p].next = list->space;
8010b2f7:	8b 45 08             	mov    0x8(%ebp),%eax
8010b2fa:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b300:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b303:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b306:	89 d0                	mov    %edx,%eax
8010b308:	c1 e0 02             	shl    $0x2,%eax
8010b30b:	01 d0                	add    %edx,%eax
8010b30d:	c1 e0 02             	shl    $0x2,%eax
8010b310:	01 d8                	add    %ebx,%eax
8010b312:	83 c0 10             	add    $0x10,%eax
8010b315:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b317:	8b 45 08             	mov    0x8(%ebp),%eax
8010b31a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b31d:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->data[q].next;
8010b323:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b326:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b329:	89 d0                	mov    %edx,%eax
8010b32b:	c1 e0 02             	shl    $0x2,%eax
8010b32e:	01 d0                	add    %edx,%eax
8010b330:	c1 e0 02             	shl    $0x2,%eax
8010b333:	01 c8                	add    %ecx,%eax
8010b335:	83 c0 10             	add    $0x10,%eax
8010b338:	8b 00                	mov    (%eax),%eax
8010b33a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int q = p;
    while (p != -1)
    {
        if (list->data[p].wndId == wndId && list->data[p].id == id)
        {
            if (p == list->head)
8010b33d:	eb 20                	jmp    8010b35f <APTimerListRemoveID+0x176>
                p = list->data[q].next;
            }
        }
        else
        {
            q = p;
8010b33f:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b342:	89 45 f0             	mov    %eax,-0x10(%ebp)
            p = list->data[p].next;
8010b345:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b348:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b34b:	89 d0                	mov    %edx,%eax
8010b34d:	c1 e0 02             	shl    $0x2,%eax
8010b350:	01 d0                	add    %edx,%eax
8010b352:	c1 e0 02             	shl    $0x2,%eax
8010b355:	01 c8                	add    %ecx,%eax
8010b357:	83 c0 10             	add    $0x10,%eax
8010b35a:	8b 00                	mov    (%eax),%eax
8010b35c:	89 45 f4             	mov    %eax,-0xc(%ebp)
void APTimerListRemoveID(ATimerList * list, int wndId, int id)
{
    acquire(&list->lock);
    int p = list->head;
    int q = p;
    while (p != -1)
8010b35f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010b363:	0f 85 b2 fe ff ff    	jne    8010b21b <APTimerListRemoveID+0x32>
        {
            q = p;
            p = list->data[p].next;
        }
    }
    release(&list->lock);
8010b369:	8b 45 08             	mov    0x8(%ebp),%eax
8010b36c:	05 d0 00 00 00       	add    $0xd0,%eax
8010b371:	83 ec 0c             	sub    $0xc,%esp
8010b374:	50                   	push   %eax
8010b375:	e8 4d 9b ff ff       	call   80104ec7 <release>
8010b37a:	83 c4 10             	add    $0x10,%esp
}
8010b37d:	90                   	nop
8010b37e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010b381:	c9                   	leave  
8010b382:	c3                   	ret    

8010b383 <setuptimer>:

void setuptimer(AHwnd hwnd,int id, int interval)
{
8010b383:	55                   	push   %ebp
8010b384:	89 e5                	mov    %esp,%ebp
8010b386:	83 ec 08             	sub    $0x8,%esp
    APTimerListAddToHead(&timerList,hwnd->id,id,interval/10);
8010b389:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010b38c:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010b391:	89 c8                	mov    %ecx,%eax
8010b393:	f7 ea                	imul   %edx
8010b395:	c1 fa 02             	sar    $0x2,%edx
8010b398:	89 c8                	mov    %ecx,%eax
8010b39a:	c1 f8 1f             	sar    $0x1f,%eax
8010b39d:	29 c2                	sub    %eax,%edx
8010b39f:	8b 45 08             	mov    0x8(%ebp),%eax
8010b3a2:	8b 00                	mov    (%eax),%eax
8010b3a4:	52                   	push   %edx
8010b3a5:	ff 75 0c             	pushl  0xc(%ebp)
8010b3a8:	50                   	push   %eax
8010b3a9:	68 80 bb 11 80       	push   $0x8011bb80
8010b3ae:	e8 ae fb ff ff       	call   8010af61 <APTimerListAddToHead>
8010b3b3:	83 c4 10             	add    $0x10,%esp
}
8010b3b6:	90                   	nop
8010b3b7:	c9                   	leave  
8010b3b8:	c3                   	ret    

8010b3b9 <deletetimer>:
void deletetimer(AHwnd hwnd, int id)
{
8010b3b9:	55                   	push   %ebp
8010b3ba:	89 e5                	mov    %esp,%ebp
8010b3bc:	83 ec 08             	sub    $0x8,%esp
    APTimerListRemoveID(&timerList,hwnd->id,id);
8010b3bf:	8b 45 08             	mov    0x8(%ebp),%eax
8010b3c2:	8b 00                	mov    (%eax),%eax
8010b3c4:	83 ec 04             	sub    $0x4,%esp
8010b3c7:	ff 75 0c             	pushl  0xc(%ebp)
8010b3ca:	50                   	push   %eax
8010b3cb:	68 80 bb 11 80       	push   $0x8011bb80
8010b3d0:	e8 14 fe ff ff       	call   8010b1e9 <APTimerListRemoveID>
8010b3d5:	83 c4 10             	add    $0x10,%esp
}
8010b3d8:	90                   	nop
8010b3d9:	c9                   	leave  
8010b3da:	c3                   	ret    
