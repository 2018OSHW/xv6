
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
8010002d:	b8 39 37 10 80       	mov    $0x80103739,%eax
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
8010003d:	68 68 b4 10 80       	push   $0x8010b468
80100042:	68 c0 f6 10 80       	push   $0x8010f6c0
80100047:	e8 06 4e 00 00       	call   80104e52 <initlock>
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
801000c1:	e8 ae 4d 00 00       	call   80104e74 <acquire>
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
8010010c:	e8 ca 4d 00 00       	call   80104edb <release>
80100111:	83 c4 10             	add    $0x10,%esp
        return b;
80100114:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100117:	e9 98 00 00 00       	jmp    801001b4 <bget+0x101>
      }
      sleep(b, &bcache.lock);
8010011c:	83 ec 08             	sub    $0x8,%esp
8010011f:	68 c0 f6 10 80       	push   $0x8010f6c0
80100124:	ff 75 f4             	pushl  -0xc(%ebp)
80100127:	e8 4f 4a 00 00       	call   80104b7b <sleep>
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
80100188:	e8 4e 4d 00 00       	call   80104edb <release>
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
801001aa:	68 6f b4 10 80       	push   $0x8010b46f
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
80100204:	68 80 b4 10 80       	push   $0x8010b480
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
80100243:	68 87 b4 10 80       	push   $0x8010b487
80100248:	e8 19 03 00 00       	call   80100566 <panic>

  acquire(&bcache.lock);
8010024d:	83 ec 0c             	sub    $0xc,%esp
80100250:	68 c0 f6 10 80       	push   $0x8010f6c0
80100255:	e8 1a 4c 00 00       	call   80104e74 <acquire>
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
801002b9:	e8 a8 49 00 00       	call   80104c66 <wakeup>
801002be:	83 c4 10             	add    $0x10,%esp

  release(&bcache.lock);
801002c1:	83 ec 0c             	sub    $0xc,%esp
801002c4:	68 c0 f6 10 80       	push   $0x8010f6c0
801002c9:	e8 0d 4c 00 00       	call   80104edb <release>
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
801003e2:	e8 8d 4a 00 00       	call   80104e74 <acquire>
801003e7:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
801003ea:	8b 45 08             	mov    0x8(%ebp),%eax
801003ed:	85 c0                	test   %eax,%eax
801003ef:	75 0d                	jne    801003fe <cprintf+0x38>
    panic("null fmt");
801003f1:	83 ec 0c             	sub    $0xc,%esp
801003f4:	68 8e b4 10 80       	push   $0x8010b48e
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
801004cd:	c7 45 ec 97 b4 10 80 	movl   $0x8010b497,-0x14(%ebp)
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
8010055b:	e8 7b 49 00 00       	call   80104edb <release>
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
8010058b:	68 9e b4 10 80       	push   $0x8010b49e
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
801005aa:	68 ad b4 10 80       	push   $0x8010b4ad
801005af:	e8 12 fe ff ff       	call   801003c6 <cprintf>
801005b4:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005b7:	83 ec 08             	sub    $0x8,%esp
801005ba:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005bd:	50                   	push   %eax
801005be:	8d 45 08             	lea    0x8(%ebp),%eax
801005c1:	50                   	push   %eax
801005c2:	e8 66 49 00 00       	call   80104f2d <getcallerpcs>
801005c7:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005d1:	eb 1c                	jmp    801005ef <panic+0x89>
    cprintf(" %p", pcs[i]);
801005d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005d6:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005da:	83 ec 08             	sub    $0x8,%esp
801005dd:	50                   	push   %eax
801005de:	68 af b4 10 80       	push   $0x8010b4af
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
801006db:	e8 b6 4a 00 00       	call   80105196 <memmove>
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
80100705:	e8 cd 49 00 00       	call   801050d7 <memset>
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
8010079a:	e8 6a 62 00 00       	call   80106a09 <uartputc>
8010079f:	83 c4 10             	add    $0x10,%esp
801007a2:	83 ec 0c             	sub    $0xc,%esp
801007a5:	6a 20                	push   $0x20
801007a7:	e8 5d 62 00 00       	call   80106a09 <uartputc>
801007ac:	83 c4 10             	add    $0x10,%esp
801007af:	83 ec 0c             	sub    $0xc,%esp
801007b2:	6a 08                	push   $0x8
801007b4:	e8 50 62 00 00       	call   80106a09 <uartputc>
801007b9:	83 c4 10             	add    $0x10,%esp
801007bc:	eb 0e                	jmp    801007cc <consputc+0x56>
  } else
    uartputc(c);
801007be:	83 ec 0c             	sub    $0xc,%esp
801007c1:	ff 75 08             	pushl  0x8(%ebp)
801007c4:	e8 40 62 00 00       	call   80106a09 <uartputc>
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
801007eb:	e8 84 46 00 00       	call   80104e74 <acquire>
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
8010081e:	e8 fe 44 00 00       	call   80104d21 <procdump>
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
80100931:	e8 30 43 00 00       	call   80104c66 <wakeup>
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
80100954:	e8 82 45 00 00       	call   80104edb <release>
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
80100981:	e8 ee 44 00 00       	call   80104e74 <acquire>
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
801009a3:	e8 33 45 00 00       	call   80104edb <release>
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
801009d0:	e8 a6 41 00 00       	call   80104b7b <sleep>
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
80100a4e:	e8 88 44 00 00       	call   80104edb <release>
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
80100a8c:	e8 e3 43 00 00       	call   80104e74 <acquire>
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
80100ace:	e8 08 44 00 00       	call   80104edb <release>
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
80100af2:	68 b3 b4 10 80       	push   $0x8010b4b3
80100af7:	68 00 e6 10 80       	push   $0x8010e600
80100afc:	e8 51 43 00 00       	call   80104e52 <initlock>
80100b01:	83 c4 10             	add    $0x10,%esp
  initlock(&input.lock, "input");
80100b04:	83 ec 08             	sub    $0x8,%esp
80100b07:	68 bb b4 10 80       	push   $0x8010b4bb
80100b0c:	68 00 0e 11 80       	push   $0x80110e00
80100b11:	e8 3c 43 00 00       	call   80104e52 <initlock>
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
80100b3c:	e8 9e 32 00 00       	call   80103ddf <picenable>
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
80100bc5:	e8 94 6f 00 00       	call   80107b5e <setupkvm>
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
80100c4b:	e8 b5 72 00 00       	call   80107f05 <allocuvm>
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
80100c7e:	e8 ab 71 00 00       	call   80107e2e <loaduvm>
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
80100ce8:	e8 18 72 00 00       	call   80107f05 <allocuvm>
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
80100d0c:	e8 1a 74 00 00       	call   8010812b <clearpteu>
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
80100d45:	e8 da 45 00 00       	call   80105324 <strlen>
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
80100d72:	e8 ad 45 00 00       	call   80105324 <strlen>
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
80100d98:	e8 32 75 00 00       	call   801082cf <copyout>
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
80100e34:	e8 96 74 00 00       	call   801082cf <copyout>
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
80100e85:	e8 50 44 00 00       	call   801052da <safestrcpy>
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
80100edb:	e8 65 6d 00 00       	call   80107c45 <switchuvm>
80100ee0:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100ee3:	83 ec 0c             	sub    $0xc,%esp
80100ee6:	ff 75 d0             	pushl  -0x30(%ebp)
80100ee9:	e8 9d 71 00 00       	call   8010808b <freevm>
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
80100f23:	e8 63 71 00 00       	call   8010808b <freevm>
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
80100f4f:	68 c1 b4 10 80       	push   $0x8010b4c1
80100f54:	68 c0 0e 11 80       	push   $0x80110ec0
80100f59:	e8 f4 3e 00 00       	call   80104e52 <initlock>
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
80100f72:	e8 fd 3e 00 00       	call   80104e74 <acquire>
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
80100f9f:	e8 37 3f 00 00       	call   80104edb <release>
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
80100fc2:	e8 14 3f 00 00       	call   80104edb <release>
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
80100fdf:	e8 90 3e 00 00       	call   80104e74 <acquire>
80100fe4:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80100fe7:	8b 45 08             	mov    0x8(%ebp),%eax
80100fea:	8b 40 04             	mov    0x4(%eax),%eax
80100fed:	85 c0                	test   %eax,%eax
80100fef:	7f 0d                	jg     80100ffe <filedup+0x2d>
    panic("filedup");
80100ff1:	83 ec 0c             	sub    $0xc,%esp
80100ff4:	68 c8 b4 10 80       	push   $0x8010b4c8
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
80101015:	e8 c1 3e 00 00       	call   80104edb <release>
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
80101030:	e8 3f 3e 00 00       	call   80104e74 <acquire>
80101035:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101038:	8b 45 08             	mov    0x8(%ebp),%eax
8010103b:	8b 40 04             	mov    0x4(%eax),%eax
8010103e:	85 c0                	test   %eax,%eax
80101040:	7f 0d                	jg     8010104f <fileclose+0x2d>
    panic("fileclose");
80101042:	83 ec 0c             	sub    $0xc,%esp
80101045:	68 d0 b4 10 80       	push   $0x8010b4d0
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
80101070:	e8 66 3e 00 00       	call   80104edb <release>
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
801010be:	e8 18 3e 00 00       	call   80104edb <release>
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
801010dd:	e8 66 2f 00 00       	call   80104048 <pipeclose>
801010e2:	83 c4 10             	add    $0x10,%esp
801010e5:	eb 21                	jmp    80101108 <fileclose+0xe6>
  else if(ff.type == FD_INODE){
801010e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010ea:	83 f8 02             	cmp    $0x2,%eax
801010ed:	75 19                	jne    80101108 <fileclose+0xe6>
    begin_trans();
801010ef:	e8 26 24 00 00       	call   8010351a <begin_trans>
    iput(ff.ip);
801010f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801010f7:	83 ec 0c             	sub    $0xc,%esp
801010fa:	50                   	push   %eax
801010fb:	e8 c1 09 00 00       	call   80101ac1 <iput>
80101100:	83 c4 10             	add    $0x10,%esp
    commit_trans();
80101103:	e8 65 24 00 00       	call   8010356d <commit_trans>
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
80101196:	e8 55 30 00 00       	call   801041f0 <piperead>
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
8010120d:	68 da b4 10 80       	push   $0x8010b4da
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
8010124f:	e8 9e 2e 00 00       	call   801040f2 <pipewrite>
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
80101294:	e8 81 22 00 00       	call   8010351a <begin_trans>
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
801012fa:	e8 6e 22 00 00       	call   8010356d <commit_trans>

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
80101310:	68 e3 b4 10 80       	push   $0x8010b4e3
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
80101346:	68 f3 b4 10 80       	push   $0x8010b4f3
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
8010137e:	e8 13 3e 00 00       	call   80105196 <memmove>
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
801013c4:	e8 0e 3d 00 00       	call   801050d7 <memset>
801013c9:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801013cc:	83 ec 0c             	sub    $0xc,%esp
801013cf:	ff 75 f4             	pushl  -0xc(%ebp)
801013d2:	e8 fb 21 00 00       	call   801035d2 <log_write>
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
801014bd:	e8 10 21 00 00       	call   801035d2 <log_write>
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
8010153d:	68 fd b4 10 80       	push   $0x8010b4fd
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
801015d3:	68 13 b5 10 80       	push   $0x8010b513
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
8010160b:	e8 c2 1f 00 00       	call   801035d2 <log_write>
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
8010162d:	68 26 b5 10 80       	push   $0x8010b526
80101632:	68 c0 18 11 80       	push   $0x801118c0
80101637:	e8 16 38 00 00       	call   80104e52 <initlock>
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
801016b2:	e8 20 3a 00 00       	call   801050d7 <memset>
801016b7:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
801016ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016bd:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
801016c1:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
801016c4:	83 ec 0c             	sub    $0xc,%esp
801016c7:	ff 75 f0             	pushl  -0x10(%ebp)
801016ca:	e8 03 1f 00 00       	call   801035d2 <log_write>
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
80101717:	68 2d b5 10 80       	push   $0x8010b52d
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
801017b7:	e8 da 39 00 00       	call   80105196 <memmove>
801017bc:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801017bf:	83 ec 0c             	sub    $0xc,%esp
801017c2:	ff 75 f4             	pushl  -0xc(%ebp)
801017c5:	e8 08 1e 00 00       	call   801035d2 <log_write>
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
801017ec:	e8 83 36 00 00       	call   80104e74 <acquire>
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
8010183a:	e8 9c 36 00 00       	call   80104edb <release>
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
80101873:	68 3f b5 10 80       	push   $0x8010b53f
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
801018b0:	e8 26 36 00 00       	call   80104edb <release>
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
801018cb:	e8 a4 35 00 00       	call   80104e74 <acquire>
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
801018ea:	e8 ec 35 00 00       	call   80104edb <release>
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
80101910:	68 4f b5 10 80       	push   $0x8010b54f
80101915:	e8 4c ec ff ff       	call   80100566 <panic>

  acquire(&icache.lock);
8010191a:	83 ec 0c             	sub    $0xc,%esp
8010191d:	68 c0 18 11 80       	push   $0x801118c0
80101922:	e8 4d 35 00 00       	call   80104e74 <acquire>
80101927:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
8010192a:	eb 13                	jmp    8010193f <ilock+0x48>
    sleep(ip, &icache.lock);
8010192c:	83 ec 08             	sub    $0x8,%esp
8010192f:	68 c0 18 11 80       	push   $0x801118c0
80101934:	ff 75 08             	pushl  0x8(%ebp)
80101937:	e8 3f 32 00 00       	call   80104b7b <sleep>
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
80101965:	e8 71 35 00 00       	call   80104edb <release>
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
80101a0c:	e8 85 37 00 00       	call   80105196 <memmove>
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
80101a42:	68 55 b5 10 80       	push   $0x8010b555
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
80101a75:	68 64 b5 10 80       	push   $0x8010b564
80101a7a:	e8 e7 ea ff ff       	call   80100566 <panic>

  acquire(&icache.lock);
80101a7f:	83 ec 0c             	sub    $0xc,%esp
80101a82:	68 c0 18 11 80       	push   $0x801118c0
80101a87:	e8 e8 33 00 00       	call   80104e74 <acquire>
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
80101aa6:	e8 bb 31 00 00       	call   80104c66 <wakeup>
80101aab:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80101aae:	83 ec 0c             	sub    $0xc,%esp
80101ab1:	68 c0 18 11 80       	push   $0x801118c0
80101ab6:	e8 20 34 00 00       	call   80104edb <release>
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
80101acf:	e8 a0 33 00 00       	call   80104e74 <acquire>
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
80101b17:	68 6c b5 10 80       	push   $0x8010b56c
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
80101b3a:	e8 9c 33 00 00       	call   80104edb <release>
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
80101b6f:	e8 00 33 00 00       	call   80104e74 <acquire>
80101b74:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101b77:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7a:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101b81:	83 ec 0c             	sub    $0xc,%esp
80101b84:	ff 75 08             	pushl  0x8(%ebp)
80101b87:	e8 da 30 00 00       	call   80104c66 <wakeup>
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
80101ba6:	e8 30 33 00 00       	call   80104edb <release>
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
80101cc8:	e8 05 19 00 00       	call   801035d2 <log_write>
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
80101d92:	e8 3b 18 00 00       	call   801035d2 <log_write>
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
80101e17:	e8 b6 17 00 00       	call   801035d2 <log_write>
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
80101e35:	68 76 b5 10 80       	push   $0x8010b576
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
801020cc:	e8 c5 30 00 00       	call   80105196 <memmove>
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
8010221e:	e8 73 2f 00 00       	call   80105196 <memmove>
80102223:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
80102226:	83 ec 0c             	sub    $0xc,%esp
80102229:	ff 75 f0             	pushl  -0x10(%ebp)
8010222c:	e8 a1 13 00 00       	call   801035d2 <log_write>
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
8010229e:	e8 89 2f 00 00       	call   8010522c <strncmp>
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
801022be:	68 89 b5 10 80       	push   $0x8010b589
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
801022ed:	68 9b b5 10 80       	push   $0x8010b59b
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
801023c2:	68 9b b5 10 80       	push   $0x8010b59b
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
801023fd:	e8 80 2e 00 00       	call   80105282 <strncpy>
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
80102429:	68 a8 b5 10 80       	push   $0x8010b5a8
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
8010249f:	e8 f2 2c 00 00       	call   80105196 <memmove>
801024a4:	83 c4 10             	add    $0x10,%esp
801024a7:	eb 26                	jmp    801024cf <skipelem+0x95>
  else {
    memmove(name, s, len);
801024a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801024ac:	83 ec 04             	sub    $0x4,%esp
801024af:	50                   	push   %eax
801024b0:	ff 75 f4             	pushl  -0xc(%ebp)
801024b3:	ff 75 0c             	pushl  0xc(%ebp)
801024b6:	e8 db 2c 00 00       	call   80105196 <memmove>
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
8010270b:	68 b0 b5 10 80       	push   $0x8010b5b0
80102710:	68 40 e6 10 80       	push   $0x8010e640
80102715:	e8 38 27 00 00       	call   80104e52 <initlock>
8010271a:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
8010271d:	83 ec 0c             	sub    $0xc,%esp
80102720:	6a 0e                	push   $0xe
80102722:	e8 b8 16 00 00       	call   80103ddf <picenable>
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
801027bf:	68 b4 b5 10 80       	push   $0x8010b5b4
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
801028e0:	e8 8f 25 00 00       	call   80104e74 <acquire>
801028e5:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
801028e8:	a1 74 e6 10 80       	mov    0x8010e674,%eax
801028ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028f0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801028f4:	75 15                	jne    8010290b <ideintr+0x39>
    release(&idelock);
801028f6:	83 ec 0c             	sub    $0xc,%esp
801028f9:	68 40 e6 10 80       	push   $0x8010e640
801028fe:	e8 d8 25 00 00       	call   80104edb <release>
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
80102973:	e8 ee 22 00 00       	call   80104c66 <wakeup>
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
8010299d:	e8 39 25 00 00       	call   80104edb <release>
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
801029bc:	68 bd b5 10 80       	push   $0x8010b5bd
801029c1:	e8 a0 db ff ff       	call   80100566 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801029c6:	8b 45 08             	mov    0x8(%ebp),%eax
801029c9:	8b 00                	mov    (%eax),%eax
801029cb:	83 e0 06             	and    $0x6,%eax
801029ce:	83 f8 02             	cmp    $0x2,%eax
801029d1:	75 0d                	jne    801029e0 <iderw+0x39>
    panic("iderw: nothing to do");
801029d3:	83 ec 0c             	sub    $0xc,%esp
801029d6:	68 d1 b5 10 80       	push   $0x8010b5d1
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
801029f6:	68 e6 b5 10 80       	push   $0x8010b5e6
801029fb:	e8 66 db ff ff       	call   80100566 <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102a00:	83 ec 0c             	sub    $0xc,%esp
80102a03:	68 40 e6 10 80       	push   $0x8010e640
80102a08:	e8 67 24 00 00       	call   80104e74 <acquire>
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
80102a64:	e8 12 21 00 00       	call   80104b7b <sleep>
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
80102a81:	e8 55 24 00 00       	call   80104edb <release>
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
80102b12:	68 04 b6 10 80       	push   $0x8010b604
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
80102bd2:	68 36 b6 10 80       	push   $0x8010b636
80102bd7:	68 a0 28 11 80       	push   $0x801128a0
80102bdc:	e8 71 22 00 00       	call   80104e52 <initlock>
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
80102c93:	68 3b b6 10 80       	push   $0x8010b63b
80102c98:	e8 c9 d8 ff ff       	call   80100566 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102c9d:	83 ec 04             	sub    $0x4,%esp
80102ca0:	68 00 10 00 00       	push   $0x1000
80102ca5:	6a 01                	push   $0x1
80102ca7:	ff 75 08             	pushl  0x8(%ebp)
80102caa:	e8 28 24 00 00       	call   801050d7 <memset>
80102caf:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102cb2:	a1 d4 28 11 80       	mov    0x801128d4,%eax
80102cb7:	85 c0                	test   %eax,%eax
80102cb9:	74 10                	je     80102ccb <kfree+0x68>
    acquire(&kmem.lock);
80102cbb:	83 ec 0c             	sub    $0xc,%esp
80102cbe:	68 a0 28 11 80       	push   $0x801128a0
80102cc3:	e8 ac 21 00 00       	call   80104e74 <acquire>
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
80102cf5:	e8 e1 21 00 00       	call   80104edb <release>
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
80102d17:	e8 58 21 00 00       	call   80104e74 <acquire>
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
80102d48:	e8 8e 21 00 00       	call   80104edb <release>
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
	cprintf("data  : %d\n", data);
80102d98:	83 ec 08             	sub    $0x8,%esp
80102d9b:	ff 75 f0             	pushl  -0x10(%ebp)
80102d9e:	68 41 b6 10 80       	push   $0x8010b641
80102da3:	e8 1e d6 ff ff       	call   801003c6 <cprintf>
80102da8:	83 c4 10             	add    $0x10,%esp
	if ((st & KBS_DIB) == 0 || (st & 0x20) != 0)
80102dab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102dae:	83 e0 01             	and    $0x1,%eax
80102db1:	85 c0                	test   %eax,%eax
80102db3:	0f 84 f1 00 00 00    	je     80102eaa <kbdInterupt+0x138>
80102db9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102dbc:	83 e0 20             	and    $0x20,%eax
80102dbf:	85 c0                	test   %eax,%eax
80102dc1:	0f 85 e3 00 00 00    	jne    80102eaa <kbdInterupt+0x138>
	{
		//cprintf("kbdInterupt return : %d\n", st);
		return;
	}

	if (data == 0xE0) {
80102dc7:	81 7d f0 e0 00 00 00 	cmpl   $0xe0,-0x10(%ebp)
80102dce:	75 0f                	jne    80102ddf <kbdInterupt+0x6d>
		//cprintf("kbd error data 0xE0\n");
		shift = 1;
80102dd0:	c7 05 7c e6 10 80 01 	movl   $0x1,0x8010e67c
80102dd7:	00 00 00 
		return;
80102dda:	e9 cc 00 00 00       	jmp    80102eab <kbdInterupt+0x139>
	}
	else if (data & 0x80) {
80102ddf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102de2:	25 80 00 00 00       	and    $0x80,%eax
80102de7:	85 c0                	test   %eax,%eax
80102de9:	74 60                	je     80102e4b <kbdInterupt+0xd9>
		cprintf("test2");
80102deb:	83 ec 0c             	sub    $0xc,%esp
80102dee:	68 4d b6 10 80       	push   $0x8010b64d
80102df3:	e8 ce d5 ff ff       	call   801003c6 <cprintf>
80102df8:	83 c4 10             	add    $0x10,%esp
		// Key released
        //cprintf("key released!\n");
		data &= 0x7F;
80102dfb:	83 65 f0 7f          	andl   $0x7f,-0x10(%ebp)
		AMessage msg;
		msg.type = MSG_KEY_UP;
80102dff:	c7 45 d8 05 00 00 00 	movl   $0x5,-0x28(%ebp)
		msg.param = charcode[shift][data];
80102e06:	a1 7c e6 10 80       	mov    0x8010e67c,%eax
80102e0b:	8b 14 85 20 c7 10 80 	mov    -0x7fef38e0(,%eax,4),%edx
80102e12:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102e15:	01 d0                	add    %edx,%eax
80102e17:	0f b6 00             	movzbl (%eax),%eax
80102e1a:	0f b6 c0             	movzbl %al,%eax
80102e1d:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if (shift)
80102e20:	a1 7c e6 10 80       	mov    0x8010e67c,%eax
80102e25:	85 c0                	test   %eax,%eax
80102e27:	74 0a                	je     80102e33 <kbdInterupt+0xc1>
			shift = 0;
80102e29:	c7 05 7c e6 10 80 00 	movl   $0x0,0x8010e67c
80102e30:	00 00 00 

        //cprintf("sending message!\n");
		sendMessage(wndList.head, &msg);
80102e33:	a1 70 78 11 80       	mov    0x80117870,%eax
80102e38:	83 ec 08             	sub    $0x8,%esp
80102e3b:	8d 55 d8             	lea    -0x28(%ebp),%edx
80102e3e:	52                   	push   %edx
80102e3f:	50                   	push   %eax
80102e40:	e8 ad 78 00 00       	call   8010a6f2 <sendMessage>
80102e45:	83 c4 10             	add    $0x10,%esp
        //cprintf("kdb message sent!\n");
		return;
80102e48:	90                   	nop
80102e49:	eb 60                	jmp    80102eab <kbdInterupt+0x139>
	}
	AMessage msg;
	msg.type = MSG_KEY_DOWN;
80102e4b:	c7 45 e4 06 00 00 00 	movl   $0x6,-0x1c(%ebp)
	msg.param = charcode[shift][data];
80102e52:	a1 7c e6 10 80       	mov    0x8010e67c,%eax
80102e57:	8b 14 85 20 c7 10 80 	mov    -0x7fef38e0(,%eax,4),%edx
80102e5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102e61:	01 d0                	add    %edx,%eax
80102e63:	0f b6 00             	movzbl (%eax),%eax
80102e66:	0f b6 c0             	movzbl %al,%eax
80102e69:	89 45 e8             	mov    %eax,-0x18(%ebp)
	cprintf("msg.param send:%d\n",msg.param);
80102e6c:	8b 45 e8             	mov    -0x18(%ebp),%eax
80102e6f:	83 ec 08             	sub    $0x8,%esp
80102e72:	50                   	push   %eax
80102e73:	68 53 b6 10 80       	push   $0x8010b653
80102e78:	e8 49 d5 ff ff       	call   801003c6 <cprintf>
80102e7d:	83 c4 10             	add    $0x10,%esp
	if (shift)
80102e80:	a1 7c e6 10 80       	mov    0x8010e67c,%eax
80102e85:	85 c0                	test   %eax,%eax
80102e87:	74 0a                	je     80102e93 <kbdInterupt+0x121>
		shift = 0;
80102e89:	c7 05 7c e6 10 80 00 	movl   $0x0,0x8010e67c
80102e90:	00 00 00 
    //cprintf("sending message!\n");
	sendMessage(wndList.head, &msg);
80102e93:	a1 70 78 11 80       	mov    0x80117870,%eax
80102e98:	83 ec 08             	sub    $0x8,%esp
80102e9b:	8d 55 e4             	lea    -0x1c(%ebp),%edx
80102e9e:	52                   	push   %edx
80102e9f:	50                   	push   %eax
80102ea0:	e8 4d 78 00 00       	call   8010a6f2 <sendMessage>
80102ea5:	83 c4 10             	add    $0x10,%esp
80102ea8:	eb 01                	jmp    80102eab <kbdInterupt+0x139>
	//cprintf("state : %d\n", st);
	cprintf("data  : %d\n", data);
	if ((st & KBS_DIB) == 0 || (st & 0x20) != 0)
	{
		//cprintf("kbdInterupt return : %d\n", st);
		return;
80102eaa:	90                   	nop
		shift = 0;
    //cprintf("sending message!\n");
	sendMessage(wndList.head, &msg);
    //cprintf("kdb message sent!\n");

}
80102eab:	c9                   	leave  
80102eac:	c3                   	ret    

80102ead <kbdgetc>:

int
kbdgetc(void)
{
80102ead:	55                   	push   %ebp
80102eae:	89 e5                	mov    %esp,%ebp
80102eb0:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102eb3:	6a 64                	push   $0x64
80102eb5:	e8 9b fe ff ff       	call   80102d55 <inb>
80102eba:	83 c4 04             	add    $0x4,%esp
80102ebd:	0f b6 c0             	movzbl %al,%eax
80102ec0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  data = inb(KBDATAP);
80102ec3:	6a 60                	push   $0x60
80102ec5:	e8 8b fe ff ff       	call   80102d55 <inb>
80102eca:	83 c4 04             	add    $0x4,%esp
80102ecd:	0f b6 c0             	movzbl %al,%eax
80102ed0:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if((st & KBS_DIB) == 0 || (st & 0x20) != 0)
80102ed3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ed6:	83 e0 01             	and    $0x1,%eax
80102ed9:	85 c0                	test   %eax,%eax
80102edb:	74 0a                	je     80102ee7 <kbdgetc+0x3a>
80102edd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ee0:	83 e0 20             	and    $0x20,%eax
80102ee3:	85 c0                	test   %eax,%eax
80102ee5:	74 0a                	je     80102ef1 <kbdgetc+0x44>
    return -1;
80102ee7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102eec:	e9 29 01 00 00       	jmp    8010301a <kbdgetc+0x16d>

  if (st & 0xc0)
80102ef1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ef4:	25 c0 00 00 00       	and    $0xc0,%eax
80102ef9:	85 c0                	test   %eax,%eax
80102efb:	74 0a                	je     80102f07 <kbdgetc+0x5a>
  {
    return -1;
80102efd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102f02:	e9 13 01 00 00       	jmp    8010301a <kbdgetc+0x16d>
  }
    
  if(data == 0xE0){
80102f07:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102f0e:	75 17                	jne    80102f27 <kbdgetc+0x7a>
    shift |= E0ESC;
80102f10:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f15:	83 c8 40             	or     $0x40,%eax
80102f18:	a3 80 e6 10 80       	mov    %eax,0x8010e680
    return 0;
80102f1d:	b8 00 00 00 00       	mov    $0x0,%eax
80102f22:	e9 f3 00 00 00       	jmp    8010301a <kbdgetc+0x16d>
  } else if(data & 0x80){
80102f27:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f2a:	25 80 00 00 00       	and    $0x80,%eax
80102f2f:	85 c0                	test   %eax,%eax
80102f31:	74 45                	je     80102f78 <kbdgetc+0xcb>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102f33:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f38:	83 e0 40             	and    $0x40,%eax
80102f3b:	85 c0                	test   %eax,%eax
80102f3d:	75 08                	jne    80102f47 <kbdgetc+0x9a>
80102f3f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f42:	83 e0 7f             	and    $0x7f,%eax
80102f45:	eb 03                	jmp    80102f4a <kbdgetc+0x9d>
80102f47:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f4a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102f4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f50:	05 20 c0 10 80       	add    $0x8010c020,%eax
80102f55:	0f b6 00             	movzbl (%eax),%eax
80102f58:	83 c8 40             	or     $0x40,%eax
80102f5b:	0f b6 c0             	movzbl %al,%eax
80102f5e:	f7 d0                	not    %eax
80102f60:	89 c2                	mov    %eax,%edx
80102f62:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f67:	21 d0                	and    %edx,%eax
80102f69:	a3 80 e6 10 80       	mov    %eax,0x8010e680
    return 0;
80102f6e:	b8 00 00 00 00       	mov    $0x0,%eax
80102f73:	e9 a2 00 00 00       	jmp    8010301a <kbdgetc+0x16d>
  } else if(shift & E0ESC){
80102f78:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f7d:	83 e0 40             	and    $0x40,%eax
80102f80:	85 c0                	test   %eax,%eax
80102f82:	74 14                	je     80102f98 <kbdgetc+0xeb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102f84:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102f8b:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102f90:	83 e0 bf             	and    $0xffffffbf,%eax
80102f93:	a3 80 e6 10 80       	mov    %eax,0x8010e680
  }

  shift |= shiftcode[data];
80102f98:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f9b:	05 20 c0 10 80       	add    $0x8010c020,%eax
80102fa0:	0f b6 00             	movzbl (%eax),%eax
80102fa3:	0f b6 d0             	movzbl %al,%edx
80102fa6:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102fab:	09 d0                	or     %edx,%eax
80102fad:	a3 80 e6 10 80       	mov    %eax,0x8010e680
  shift ^= togglecode[data];
80102fb2:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102fb5:	05 20 c1 10 80       	add    $0x8010c120,%eax
80102fba:	0f b6 00             	movzbl (%eax),%eax
80102fbd:	0f b6 d0             	movzbl %al,%edx
80102fc0:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102fc5:	31 d0                	xor    %edx,%eax
80102fc7:	a3 80 e6 10 80       	mov    %eax,0x8010e680
  c = charcode[shift & (CTL | SHIFT)][data];
80102fcc:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102fd1:	83 e0 03             	and    $0x3,%eax
80102fd4:	8b 14 85 28 c7 10 80 	mov    -0x7fef38d8(,%eax,4),%edx
80102fdb:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102fde:	01 d0                	add    %edx,%eax
80102fe0:	0f b6 00             	movzbl (%eax),%eax
80102fe3:	0f b6 c0             	movzbl %al,%eax
80102fe6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102fe9:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80102fee:	83 e0 08             	and    $0x8,%eax
80102ff1:	85 c0                	test   %eax,%eax
80102ff3:	74 22                	je     80103017 <kbdgetc+0x16a>
    if('a' <= c && c <= 'z')
80102ff5:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102ff9:	76 0c                	jbe    80103007 <kbdgetc+0x15a>
80102ffb:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102fff:	77 06                	ja     80103007 <kbdgetc+0x15a>
      c += 'A' - 'a';
80103001:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80103005:	eb 10                	jmp    80103017 <kbdgetc+0x16a>
    else if('A' <= c && c <= 'Z')
80103007:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
8010300b:	76 0a                	jbe    80103017 <kbdgetc+0x16a>
8010300d:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80103011:	77 04                	ja     80103017 <kbdgetc+0x16a>
      c += 'a' - 'A';
80103013:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  
  return c;
80103017:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
8010301a:	c9                   	leave  
8010301b:	c3                   	ret    

8010301c <kbdintr>:

void
kbdintr(void)
{
8010301c:	55                   	push   %ebp
8010301d:	89 e5                	mov    %esp,%ebp
8010301f:	83 ec 08             	sub    $0x8,%esp
  //consoleintr(kbdgetc);
	kbdInterupt();
80103022:	e8 4b fd ff ff       	call   80102d72 <kbdInterupt>
}
80103027:	90                   	nop
80103028:	c9                   	leave  
80103029:	c3                   	ret    

8010302a <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
8010302a:	55                   	push   %ebp
8010302b:	89 e5                	mov    %esp,%ebp
8010302d:	83 ec 08             	sub    $0x8,%esp
80103030:	8b 55 08             	mov    0x8(%ebp),%edx
80103033:	8b 45 0c             	mov    0xc(%ebp),%eax
80103036:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010303a:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010303d:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103041:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103045:	ee                   	out    %al,(%dx)
}
80103046:	90                   	nop
80103047:	c9                   	leave  
80103048:	c3                   	ret    

80103049 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80103049:	55                   	push   %ebp
8010304a:	89 e5                	mov    %esp,%ebp
8010304c:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010304f:	9c                   	pushf  
80103050:	58                   	pop    %eax
80103051:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80103054:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103057:	c9                   	leave  
80103058:	c3                   	ret    

80103059 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80103059:	55                   	push   %ebp
8010305a:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
8010305c:	a1 dc 28 11 80       	mov    0x801128dc,%eax
80103061:	8b 55 08             	mov    0x8(%ebp),%edx
80103064:	c1 e2 02             	shl    $0x2,%edx
80103067:	01 c2                	add    %eax,%edx
80103069:	8b 45 0c             	mov    0xc(%ebp),%eax
8010306c:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
8010306e:	a1 dc 28 11 80       	mov    0x801128dc,%eax
80103073:	83 c0 20             	add    $0x20,%eax
80103076:	8b 00                	mov    (%eax),%eax
}
80103078:	90                   	nop
80103079:	5d                   	pop    %ebp
8010307a:	c3                   	ret    

8010307b <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
8010307b:	55                   	push   %ebp
8010307c:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
8010307e:	a1 dc 28 11 80       	mov    0x801128dc,%eax
80103083:	85 c0                	test   %eax,%eax
80103085:	0f 84 0b 01 00 00    	je     80103196 <lapicinit+0x11b>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
8010308b:	68 3f 01 00 00       	push   $0x13f
80103090:	6a 3c                	push   $0x3c
80103092:	e8 c2 ff ff ff       	call   80103059 <lapicw>
80103097:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
8010309a:	6a 0b                	push   $0xb
8010309c:	68 f8 00 00 00       	push   $0xf8
801030a1:	e8 b3 ff ff ff       	call   80103059 <lapicw>
801030a6:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
801030a9:	68 20 00 02 00       	push   $0x20020
801030ae:	68 c8 00 00 00       	push   $0xc8
801030b3:	e8 a1 ff ff ff       	call   80103059 <lapicw>
801030b8:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000); 
801030bb:	68 80 96 98 00       	push   $0x989680
801030c0:	68 e0 00 00 00       	push   $0xe0
801030c5:	e8 8f ff ff ff       	call   80103059 <lapicw>
801030ca:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
801030cd:	68 00 00 01 00       	push   $0x10000
801030d2:	68 d4 00 00 00       	push   $0xd4
801030d7:	e8 7d ff ff ff       	call   80103059 <lapicw>
801030dc:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
801030df:	68 00 00 01 00       	push   $0x10000
801030e4:	68 d8 00 00 00       	push   $0xd8
801030e9:	e8 6b ff ff ff       	call   80103059 <lapicw>
801030ee:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801030f1:	a1 dc 28 11 80       	mov    0x801128dc,%eax
801030f6:	83 c0 30             	add    $0x30,%eax
801030f9:	8b 00                	mov    (%eax),%eax
801030fb:	c1 e8 10             	shr    $0x10,%eax
801030fe:	0f b6 c0             	movzbl %al,%eax
80103101:	83 f8 03             	cmp    $0x3,%eax
80103104:	76 12                	jbe    80103118 <lapicinit+0x9d>
    lapicw(PCINT, MASKED);
80103106:	68 00 00 01 00       	push   $0x10000
8010310b:	68 d0 00 00 00       	push   $0xd0
80103110:	e8 44 ff ff ff       	call   80103059 <lapicw>
80103115:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80103118:	6a 33                	push   $0x33
8010311a:	68 dc 00 00 00       	push   $0xdc
8010311f:	e8 35 ff ff ff       	call   80103059 <lapicw>
80103124:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80103127:	6a 00                	push   $0x0
80103129:	68 a0 00 00 00       	push   $0xa0
8010312e:	e8 26 ff ff ff       	call   80103059 <lapicw>
80103133:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80103136:	6a 00                	push   $0x0
80103138:	68 a0 00 00 00       	push   $0xa0
8010313d:	e8 17 ff ff ff       	call   80103059 <lapicw>
80103142:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80103145:	6a 00                	push   $0x0
80103147:	6a 2c                	push   $0x2c
80103149:	e8 0b ff ff ff       	call   80103059 <lapicw>
8010314e:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80103151:	6a 00                	push   $0x0
80103153:	68 c4 00 00 00       	push   $0xc4
80103158:	e8 fc fe ff ff       	call   80103059 <lapicw>
8010315d:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80103160:	68 00 85 08 00       	push   $0x88500
80103165:	68 c0 00 00 00       	push   $0xc0
8010316a:	e8 ea fe ff ff       	call   80103059 <lapicw>
8010316f:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80103172:	90                   	nop
80103173:	a1 dc 28 11 80       	mov    0x801128dc,%eax
80103178:	05 00 03 00 00       	add    $0x300,%eax
8010317d:	8b 00                	mov    (%eax),%eax
8010317f:	25 00 10 00 00       	and    $0x1000,%eax
80103184:	85 c0                	test   %eax,%eax
80103186:	75 eb                	jne    80103173 <lapicinit+0xf8>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80103188:	6a 00                	push   $0x0
8010318a:	6a 20                	push   $0x20
8010318c:	e8 c8 fe ff ff       	call   80103059 <lapicw>
80103191:	83 c4 08             	add    $0x8,%esp
80103194:	eb 01                	jmp    80103197 <lapicinit+0x11c>

void
lapicinit(void)
{
  if(!lapic) 
    return;
80103196:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80103197:	c9                   	leave  
80103198:	c3                   	ret    

80103199 <cpunum>:

int
cpunum(void)
{
80103199:	55                   	push   %ebp
8010319a:	89 e5                	mov    %esp,%ebp
8010319c:	83 ec 08             	sub    $0x8,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
8010319f:	e8 a5 fe ff ff       	call   80103049 <readeflags>
801031a4:	25 00 02 00 00       	and    $0x200,%eax
801031a9:	85 c0                	test   %eax,%eax
801031ab:	74 26                	je     801031d3 <cpunum+0x3a>
    static int n;
    if(n++ == 0)
801031ad:	a1 84 e6 10 80       	mov    0x8010e684,%eax
801031b2:	8d 50 01             	lea    0x1(%eax),%edx
801031b5:	89 15 84 e6 10 80    	mov    %edx,0x8010e684
801031bb:	85 c0                	test   %eax,%eax
801031bd:	75 14                	jne    801031d3 <cpunum+0x3a>
      cprintf("cpu called from %x with interrupts enabled\n",
801031bf:	8b 45 04             	mov    0x4(%ebp),%eax
801031c2:	83 ec 08             	sub    $0x8,%esp
801031c5:	50                   	push   %eax
801031c6:	68 68 b6 10 80       	push   $0x8010b668
801031cb:	e8 f6 d1 ff ff       	call   801003c6 <cprintf>
801031d0:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
801031d3:	a1 dc 28 11 80       	mov    0x801128dc,%eax
801031d8:	85 c0                	test   %eax,%eax
801031da:	74 0f                	je     801031eb <cpunum+0x52>
    return lapic[ID]>>24;
801031dc:	a1 dc 28 11 80       	mov    0x801128dc,%eax
801031e1:	83 c0 20             	add    $0x20,%eax
801031e4:	8b 00                	mov    (%eax),%eax
801031e6:	c1 e8 18             	shr    $0x18,%eax
801031e9:	eb 05                	jmp    801031f0 <cpunum+0x57>
  return 0;
801031eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
801031f0:	c9                   	leave  
801031f1:	c3                   	ret    

801031f2 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
801031f2:	55                   	push   %ebp
801031f3:	89 e5                	mov    %esp,%ebp
  if(lapic)
801031f5:	a1 dc 28 11 80       	mov    0x801128dc,%eax
801031fa:	85 c0                	test   %eax,%eax
801031fc:	74 0c                	je     8010320a <lapiceoi+0x18>
    lapicw(EOI, 0);
801031fe:	6a 00                	push   $0x0
80103200:	6a 2c                	push   $0x2c
80103202:	e8 52 fe ff ff       	call   80103059 <lapicw>
80103207:	83 c4 08             	add    $0x8,%esp
}
8010320a:	90                   	nop
8010320b:	c9                   	leave  
8010320c:	c3                   	ret    

8010320d <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
8010320d:	55                   	push   %ebp
8010320e:	89 e5                	mov    %esp,%ebp
}
80103210:	90                   	nop
80103211:	5d                   	pop    %ebp
80103212:	c3                   	ret    

80103213 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103213:	55                   	push   %ebp
80103214:	89 e5                	mov    %esp,%ebp
80103216:	83 ec 14             	sub    $0x14,%esp
80103219:	8b 45 08             	mov    0x8(%ebp),%eax
8010321c:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
8010321f:	6a 0f                	push   $0xf
80103221:	6a 70                	push   $0x70
80103223:	e8 02 fe ff ff       	call   8010302a <outb>
80103228:	83 c4 08             	add    $0x8,%esp
  outb(IO_RTC+1, 0x0A);
8010322b:	6a 0a                	push   $0xa
8010322d:	6a 71                	push   $0x71
8010322f:	e8 f6 fd ff ff       	call   8010302a <outb>
80103234:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80103237:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
8010323e:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103241:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80103246:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103249:	83 c0 02             	add    $0x2,%eax
8010324c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010324f:	c1 ea 04             	shr    $0x4,%edx
80103252:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103255:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103259:	c1 e0 18             	shl    $0x18,%eax
8010325c:	50                   	push   %eax
8010325d:	68 c4 00 00 00       	push   $0xc4
80103262:	e8 f2 fd ff ff       	call   80103059 <lapicw>
80103267:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
8010326a:	68 00 c5 00 00       	push   $0xc500
8010326f:	68 c0 00 00 00       	push   $0xc0
80103274:	e8 e0 fd ff ff       	call   80103059 <lapicw>
80103279:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
8010327c:	68 c8 00 00 00       	push   $0xc8
80103281:	e8 87 ff ff ff       	call   8010320d <microdelay>
80103286:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
80103289:	68 00 85 00 00       	push   $0x8500
8010328e:	68 c0 00 00 00       	push   $0xc0
80103293:	e8 c1 fd ff ff       	call   80103059 <lapicw>
80103298:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
8010329b:	6a 64                	push   $0x64
8010329d:	e8 6b ff ff ff       	call   8010320d <microdelay>
801032a2:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801032a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801032ac:	eb 3d                	jmp    801032eb <lapicstartap+0xd8>
    lapicw(ICRHI, apicid<<24);
801032ae:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
801032b2:	c1 e0 18             	shl    $0x18,%eax
801032b5:	50                   	push   %eax
801032b6:	68 c4 00 00 00       	push   $0xc4
801032bb:	e8 99 fd ff ff       	call   80103059 <lapicw>
801032c0:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
801032c3:	8b 45 0c             	mov    0xc(%ebp),%eax
801032c6:	c1 e8 0c             	shr    $0xc,%eax
801032c9:	80 cc 06             	or     $0x6,%ah
801032cc:	50                   	push   %eax
801032cd:	68 c0 00 00 00       	push   $0xc0
801032d2:	e8 82 fd ff ff       	call   80103059 <lapicw>
801032d7:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
801032da:	68 c8 00 00 00       	push   $0xc8
801032df:	e8 29 ff ff ff       	call   8010320d <microdelay>
801032e4:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801032e7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801032eb:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
801032ef:	7e bd                	jle    801032ae <lapicstartap+0x9b>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801032f1:	90                   	nop
801032f2:	c9                   	leave  
801032f3:	c3                   	ret    

801032f4 <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
801032f4:	55                   	push   %ebp
801032f5:	89 e5                	mov    %esp,%ebp
801032f7:	83 ec 18             	sub    $0x18,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
801032fa:	83 ec 08             	sub    $0x8,%esp
801032fd:	68 94 b6 10 80       	push   $0x8010b694
80103302:	68 e0 28 11 80       	push   $0x801128e0
80103307:	e8 46 1b 00 00       	call   80104e52 <initlock>
8010330c:	83 c4 10             	add    $0x10,%esp
  readsb(ROOTDEV, &sb);
8010330f:	83 ec 08             	sub    $0x8,%esp
80103312:	8d 45 e8             	lea    -0x18(%ebp),%eax
80103315:	50                   	push   %eax
80103316:	6a 01                	push   $0x1
80103318:	e8 38 e0 ff ff       	call   80101355 <readsb>
8010331d:	83 c4 10             	add    $0x10,%esp
  log.start = sb.size - sb.nlog;
80103320:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103323:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103326:	29 c2                	sub    %eax,%edx
80103328:	89 d0                	mov    %edx,%eax
8010332a:	a3 14 29 11 80       	mov    %eax,0x80112914
  log.size = sb.nlog;
8010332f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103332:	a3 18 29 11 80       	mov    %eax,0x80112918
  log.dev = ROOTDEV;
80103337:	c7 05 20 29 11 80 01 	movl   $0x1,0x80112920
8010333e:	00 00 00 
  recover_from_log();
80103341:	e8 b2 01 00 00       	call   801034f8 <recover_from_log>
}
80103346:	90                   	nop
80103347:	c9                   	leave  
80103348:	c3                   	ret    

80103349 <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
80103349:	55                   	push   %ebp
8010334a:	89 e5                	mov    %esp,%ebp
8010334c:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010334f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103356:	e9 95 00 00 00       	jmp    801033f0 <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
8010335b:	8b 15 14 29 11 80    	mov    0x80112914,%edx
80103361:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103364:	01 d0                	add    %edx,%eax
80103366:	83 c0 01             	add    $0x1,%eax
80103369:	89 c2                	mov    %eax,%edx
8010336b:	a1 20 29 11 80       	mov    0x80112920,%eax
80103370:	83 ec 08             	sub    $0x8,%esp
80103373:	52                   	push   %edx
80103374:	50                   	push   %eax
80103375:	e8 3c ce ff ff       	call   801001b6 <bread>
8010337a:	83 c4 10             	add    $0x10,%esp
8010337d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
80103380:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103383:	83 c0 10             	add    $0x10,%eax
80103386:	8b 04 85 e8 28 11 80 	mov    -0x7feed718(,%eax,4),%eax
8010338d:	89 c2                	mov    %eax,%edx
8010338f:	a1 20 29 11 80       	mov    0x80112920,%eax
80103394:	83 ec 08             	sub    $0x8,%esp
80103397:	52                   	push   %edx
80103398:	50                   	push   %eax
80103399:	e8 18 ce ff ff       	call   801001b6 <bread>
8010339e:	83 c4 10             	add    $0x10,%esp
801033a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801033a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033a7:	8d 50 18             	lea    0x18(%eax),%edx
801033aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033ad:	83 c0 18             	add    $0x18,%eax
801033b0:	83 ec 04             	sub    $0x4,%esp
801033b3:	68 00 02 00 00       	push   $0x200
801033b8:	52                   	push   %edx
801033b9:	50                   	push   %eax
801033ba:	e8 d7 1d 00 00       	call   80105196 <memmove>
801033bf:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
801033c2:	83 ec 0c             	sub    $0xc,%esp
801033c5:	ff 75 ec             	pushl  -0x14(%ebp)
801033c8:	e8 22 ce ff ff       	call   801001ef <bwrite>
801033cd:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf); 
801033d0:	83 ec 0c             	sub    $0xc,%esp
801033d3:	ff 75 f0             	pushl  -0x10(%ebp)
801033d6:	e8 53 ce ff ff       	call   8010022e <brelse>
801033db:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
801033de:	83 ec 0c             	sub    $0xc,%esp
801033e1:	ff 75 ec             	pushl  -0x14(%ebp)
801033e4:	e8 45 ce ff ff       	call   8010022e <brelse>
801033e9:	83 c4 10             	add    $0x10,%esp
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801033ec:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801033f0:	a1 24 29 11 80       	mov    0x80112924,%eax
801033f5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801033f8:	0f 8f 5d ff ff ff    	jg     8010335b <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
801033fe:	90                   	nop
801033ff:	c9                   	leave  
80103400:	c3                   	ret    

80103401 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
80103401:	55                   	push   %ebp
80103402:	89 e5                	mov    %esp,%ebp
80103404:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103407:	a1 14 29 11 80       	mov    0x80112914,%eax
8010340c:	89 c2                	mov    %eax,%edx
8010340e:	a1 20 29 11 80       	mov    0x80112920,%eax
80103413:	83 ec 08             	sub    $0x8,%esp
80103416:	52                   	push   %edx
80103417:	50                   	push   %eax
80103418:	e8 99 cd ff ff       	call   801001b6 <bread>
8010341d:	83 c4 10             	add    $0x10,%esp
80103420:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
80103423:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103426:	83 c0 18             	add    $0x18,%eax
80103429:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
8010342c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010342f:	8b 00                	mov    (%eax),%eax
80103431:	a3 24 29 11 80       	mov    %eax,0x80112924
  for (i = 0; i < log.lh.n; i++) {
80103436:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010343d:	eb 1b                	jmp    8010345a <read_head+0x59>
    log.lh.sector[i] = lh->sector[i];
8010343f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103442:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103445:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103449:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010344c:	83 c2 10             	add    $0x10,%edx
8010344f:	89 04 95 e8 28 11 80 	mov    %eax,-0x7feed718(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80103456:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010345a:	a1 24 29 11 80       	mov    0x80112924,%eax
8010345f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103462:	7f db                	jg     8010343f <read_head+0x3e>
    log.lh.sector[i] = lh->sector[i];
  }
  brelse(buf);
80103464:	83 ec 0c             	sub    $0xc,%esp
80103467:	ff 75 f0             	pushl  -0x10(%ebp)
8010346a:	e8 bf cd ff ff       	call   8010022e <brelse>
8010346f:	83 c4 10             	add    $0x10,%esp
}
80103472:	90                   	nop
80103473:	c9                   	leave  
80103474:	c3                   	ret    

80103475 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103475:	55                   	push   %ebp
80103476:	89 e5                	mov    %esp,%ebp
80103478:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
8010347b:	a1 14 29 11 80       	mov    0x80112914,%eax
80103480:	89 c2                	mov    %eax,%edx
80103482:	a1 20 29 11 80       	mov    0x80112920,%eax
80103487:	83 ec 08             	sub    $0x8,%esp
8010348a:	52                   	push   %edx
8010348b:	50                   	push   %eax
8010348c:	e8 25 cd ff ff       	call   801001b6 <bread>
80103491:	83 c4 10             	add    $0x10,%esp
80103494:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
80103497:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010349a:	83 c0 18             	add    $0x18,%eax
8010349d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
801034a0:	8b 15 24 29 11 80    	mov    0x80112924,%edx
801034a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034a9:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
801034ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801034b2:	eb 1b                	jmp    801034cf <write_head+0x5a>
    hb->sector[i] = log.lh.sector[i];
801034b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801034b7:	83 c0 10             	add    $0x10,%eax
801034ba:	8b 0c 85 e8 28 11 80 	mov    -0x7feed718(,%eax,4),%ecx
801034c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801034c7:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801034cb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801034cf:	a1 24 29 11 80       	mov    0x80112924,%eax
801034d4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801034d7:	7f db                	jg     801034b4 <write_head+0x3f>
    hb->sector[i] = log.lh.sector[i];
  }
  bwrite(buf);
801034d9:	83 ec 0c             	sub    $0xc,%esp
801034dc:	ff 75 f0             	pushl  -0x10(%ebp)
801034df:	e8 0b cd ff ff       	call   801001ef <bwrite>
801034e4:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
801034e7:	83 ec 0c             	sub    $0xc,%esp
801034ea:	ff 75 f0             	pushl  -0x10(%ebp)
801034ed:	e8 3c cd ff ff       	call   8010022e <brelse>
801034f2:	83 c4 10             	add    $0x10,%esp
}
801034f5:	90                   	nop
801034f6:	c9                   	leave  
801034f7:	c3                   	ret    

801034f8 <recover_from_log>:

static void
recover_from_log(void)
{
801034f8:	55                   	push   %ebp
801034f9:	89 e5                	mov    %esp,%ebp
801034fb:	83 ec 08             	sub    $0x8,%esp
  read_head();      
801034fe:	e8 fe fe ff ff       	call   80103401 <read_head>
  install_trans(); // if committed, copy from log to disk
80103503:	e8 41 fe ff ff       	call   80103349 <install_trans>
  log.lh.n = 0;
80103508:	c7 05 24 29 11 80 00 	movl   $0x0,0x80112924
8010350f:	00 00 00 
  write_head(); // clear the log
80103512:	e8 5e ff ff ff       	call   80103475 <write_head>
}
80103517:	90                   	nop
80103518:	c9                   	leave  
80103519:	c3                   	ret    

8010351a <begin_trans>:

void
begin_trans(void)
{
8010351a:	55                   	push   %ebp
8010351b:	89 e5                	mov    %esp,%ebp
8010351d:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
80103520:	83 ec 0c             	sub    $0xc,%esp
80103523:	68 e0 28 11 80       	push   $0x801128e0
80103528:	e8 47 19 00 00       	call   80104e74 <acquire>
8010352d:	83 c4 10             	add    $0x10,%esp
  while (log.busy) {
80103530:	eb 15                	jmp    80103547 <begin_trans+0x2d>
    sleep(&log, &log.lock);
80103532:	83 ec 08             	sub    $0x8,%esp
80103535:	68 e0 28 11 80       	push   $0x801128e0
8010353a:	68 e0 28 11 80       	push   $0x801128e0
8010353f:	e8 37 16 00 00       	call   80104b7b <sleep>
80103544:	83 c4 10             	add    $0x10,%esp

void
begin_trans(void)
{
  acquire(&log.lock);
  while (log.busy) {
80103547:	a1 1c 29 11 80       	mov    0x8011291c,%eax
8010354c:	85 c0                	test   %eax,%eax
8010354e:	75 e2                	jne    80103532 <begin_trans+0x18>
    sleep(&log, &log.lock);
  }
  log.busy = 1;
80103550:	c7 05 1c 29 11 80 01 	movl   $0x1,0x8011291c
80103557:	00 00 00 
  release(&log.lock);
8010355a:	83 ec 0c             	sub    $0xc,%esp
8010355d:	68 e0 28 11 80       	push   $0x801128e0
80103562:	e8 74 19 00 00       	call   80104edb <release>
80103567:	83 c4 10             	add    $0x10,%esp
}
8010356a:	90                   	nop
8010356b:	c9                   	leave  
8010356c:	c3                   	ret    

8010356d <commit_trans>:

void
commit_trans(void)
{
8010356d:	55                   	push   %ebp
8010356e:	89 e5                	mov    %esp,%ebp
80103570:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
80103573:	a1 24 29 11 80       	mov    0x80112924,%eax
80103578:	85 c0                	test   %eax,%eax
8010357a:	7e 19                	jle    80103595 <commit_trans+0x28>
    write_head();    // Write header to disk -- the real commit
8010357c:	e8 f4 fe ff ff       	call   80103475 <write_head>
    install_trans(); // Now install writes to home locations
80103581:	e8 c3 fd ff ff       	call   80103349 <install_trans>
    log.lh.n = 0; 
80103586:	c7 05 24 29 11 80 00 	movl   $0x0,0x80112924
8010358d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103590:	e8 e0 fe ff ff       	call   80103475 <write_head>
  }
  
  acquire(&log.lock);
80103595:	83 ec 0c             	sub    $0xc,%esp
80103598:	68 e0 28 11 80       	push   $0x801128e0
8010359d:	e8 d2 18 00 00       	call   80104e74 <acquire>
801035a2:	83 c4 10             	add    $0x10,%esp
  log.busy = 0;
801035a5:	c7 05 1c 29 11 80 00 	movl   $0x0,0x8011291c
801035ac:	00 00 00 
  wakeup(&log);
801035af:	83 ec 0c             	sub    $0xc,%esp
801035b2:	68 e0 28 11 80       	push   $0x801128e0
801035b7:	e8 aa 16 00 00       	call   80104c66 <wakeup>
801035bc:	83 c4 10             	add    $0x10,%esp
  release(&log.lock);
801035bf:	83 ec 0c             	sub    $0xc,%esp
801035c2:	68 e0 28 11 80       	push   $0x801128e0
801035c7:	e8 0f 19 00 00       	call   80104edb <release>
801035cc:	83 c4 10             	add    $0x10,%esp
}
801035cf:	90                   	nop
801035d0:	c9                   	leave  
801035d1:	c3                   	ret    

801035d2 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801035d2:	55                   	push   %ebp
801035d3:	89 e5                	mov    %esp,%ebp
801035d5:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801035d8:	a1 24 29 11 80       	mov    0x80112924,%eax
801035dd:	83 f8 09             	cmp    $0x9,%eax
801035e0:	7f 12                	jg     801035f4 <log_write+0x22>
801035e2:	a1 24 29 11 80       	mov    0x80112924,%eax
801035e7:	8b 15 18 29 11 80    	mov    0x80112918,%edx
801035ed:	83 ea 01             	sub    $0x1,%edx
801035f0:	39 d0                	cmp    %edx,%eax
801035f2:	7c 2a                	jl     8010361e <log_write+0x4c>
  {
      cprintf("%d %d\n", log.lh.n, log.size);
801035f4:	8b 15 18 29 11 80    	mov    0x80112918,%edx
801035fa:	a1 24 29 11 80       	mov    0x80112924,%eax
801035ff:	83 ec 04             	sub    $0x4,%esp
80103602:	52                   	push   %edx
80103603:	50                   	push   %eax
80103604:	68 98 b6 10 80       	push   $0x8010b698
80103609:	e8 b8 cd ff ff       	call   801003c6 <cprintf>
8010360e:	83 c4 10             	add    $0x10,%esp
      panic("too big a transaction");
80103611:	83 ec 0c             	sub    $0xc,%esp
80103614:	68 9f b6 10 80       	push   $0x8010b69f
80103619:	e8 48 cf ff ff       	call   80100566 <panic>
  }
  if (!log.busy)
8010361e:	a1 1c 29 11 80       	mov    0x8011291c,%eax
80103623:	85 c0                	test   %eax,%eax
80103625:	75 0d                	jne    80103634 <log_write+0x62>
    panic("write outside of trans");
80103627:	83 ec 0c             	sub    $0xc,%esp
8010362a:	68 b5 b6 10 80       	push   $0x8010b6b5
8010362f:	e8 32 cf ff ff       	call   80100566 <panic>

  for (i = 0; i < log.lh.n; i++) {
80103634:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010363b:	eb 1d                	jmp    8010365a <log_write+0x88>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
8010363d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103640:	83 c0 10             	add    $0x10,%eax
80103643:	8b 04 85 e8 28 11 80 	mov    -0x7feed718(,%eax,4),%eax
8010364a:	89 c2                	mov    %eax,%edx
8010364c:	8b 45 08             	mov    0x8(%ebp),%eax
8010364f:	8b 40 08             	mov    0x8(%eax),%eax
80103652:	39 c2                	cmp    %eax,%edx
80103654:	74 10                	je     80103666 <log_write+0x94>
      panic("too big a transaction");
  }
  if (!log.busy)
    panic("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
80103656:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010365a:	a1 24 29 11 80       	mov    0x80112924,%eax
8010365f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103662:	7f d9                	jg     8010363d <log_write+0x6b>
80103664:	eb 01                	jmp    80103667 <log_write+0x95>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
      break;
80103666:	90                   	nop
  }
  log.lh.sector[i] = b->sector;
80103667:	8b 45 08             	mov    0x8(%ebp),%eax
8010366a:	8b 40 08             	mov    0x8(%eax),%eax
8010366d:	89 c2                	mov    %eax,%edx
8010366f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103672:	83 c0 10             	add    $0x10,%eax
80103675:	89 14 85 e8 28 11 80 	mov    %edx,-0x7feed718(,%eax,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
8010367c:	8b 15 14 29 11 80    	mov    0x80112914,%edx
80103682:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103685:	01 d0                	add    %edx,%eax
80103687:	83 c0 01             	add    $0x1,%eax
8010368a:	89 c2                	mov    %eax,%edx
8010368c:	8b 45 08             	mov    0x8(%ebp),%eax
8010368f:	8b 40 04             	mov    0x4(%eax),%eax
80103692:	83 ec 08             	sub    $0x8,%esp
80103695:	52                   	push   %edx
80103696:	50                   	push   %eax
80103697:	e8 1a cb ff ff       	call   801001b6 <bread>
8010369c:	83 c4 10             	add    $0x10,%esp
8010369f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(lbuf->data, b->data, BSIZE);
801036a2:	8b 45 08             	mov    0x8(%ebp),%eax
801036a5:	8d 50 18             	lea    0x18(%eax),%edx
801036a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036ab:	83 c0 18             	add    $0x18,%eax
801036ae:	83 ec 04             	sub    $0x4,%esp
801036b1:	68 00 02 00 00       	push   $0x200
801036b6:	52                   	push   %edx
801036b7:	50                   	push   %eax
801036b8:	e8 d9 1a 00 00       	call   80105196 <memmove>
801036bd:	83 c4 10             	add    $0x10,%esp
  bwrite(lbuf);
801036c0:	83 ec 0c             	sub    $0xc,%esp
801036c3:	ff 75 f0             	pushl  -0x10(%ebp)
801036c6:	e8 24 cb ff ff       	call   801001ef <bwrite>
801036cb:	83 c4 10             	add    $0x10,%esp
  brelse(lbuf);
801036ce:	83 ec 0c             	sub    $0xc,%esp
801036d1:	ff 75 f0             	pushl  -0x10(%ebp)
801036d4:	e8 55 cb ff ff       	call   8010022e <brelse>
801036d9:	83 c4 10             	add    $0x10,%esp
  if (i == log.lh.n)
801036dc:	a1 24 29 11 80       	mov    0x80112924,%eax
801036e1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801036e4:	75 0d                	jne    801036f3 <log_write+0x121>
    log.lh.n++;
801036e6:	a1 24 29 11 80       	mov    0x80112924,%eax
801036eb:	83 c0 01             	add    $0x1,%eax
801036ee:	a3 24 29 11 80       	mov    %eax,0x80112924
  b->flags |= B_DIRTY; // XXX prevent eviction
801036f3:	8b 45 08             	mov    0x8(%ebp),%eax
801036f6:	8b 00                	mov    (%eax),%eax
801036f8:	83 c8 04             	or     $0x4,%eax
801036fb:	89 c2                	mov    %eax,%edx
801036fd:	8b 45 08             	mov    0x8(%ebp),%eax
80103700:	89 10                	mov    %edx,(%eax)
}
80103702:	90                   	nop
80103703:	c9                   	leave  
80103704:	c3                   	ret    

80103705 <v2p>:
80103705:	55                   	push   %ebp
80103706:	89 e5                	mov    %esp,%ebp
80103708:	8b 45 08             	mov    0x8(%ebp),%eax
8010370b:	05 00 00 00 80       	add    $0x80000000,%eax
80103710:	5d                   	pop    %ebp
80103711:	c3                   	ret    

80103712 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80103712:	55                   	push   %ebp
80103713:	89 e5                	mov    %esp,%ebp
80103715:	8b 45 08             	mov    0x8(%ebp),%eax
80103718:	05 00 00 00 80       	add    $0x80000000,%eax
8010371d:	5d                   	pop    %ebp
8010371e:	c3                   	ret    

8010371f <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
8010371f:	55                   	push   %ebp
80103720:	89 e5                	mov    %esp,%ebp
80103722:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103725:	8b 55 08             	mov    0x8(%ebp),%edx
80103728:	8b 45 0c             	mov    0xc(%ebp),%eax
8010372b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010372e:	f0 87 02             	lock xchg %eax,(%edx)
80103731:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80103734:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103737:	c9                   	leave  
80103738:	c3                   	ret    

80103739 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103739:	8d 4c 24 04          	lea    0x4(%esp),%ecx
8010373d:	83 e4 f0             	and    $0xfffffff0,%esp
80103740:	ff 71 fc             	pushl  -0x4(%ecx)
80103743:	55                   	push   %ebp
80103744:	89 e5                	mov    %esp,%ebp
80103746:	51                   	push   %ecx
80103747:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010374a:	83 ec 08             	sub    $0x8,%esp
8010374d:	68 00 00 40 80       	push   $0x80400000
80103752:	68 84 b4 11 80       	push   $0x8011b484
80103757:	e8 6d f4 ff ff       	call   80102bc9 <kinit1>
8010375c:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
8010375f:	e8 ac 44 00 00       	call   80107c10 <kvmalloc>
  mpinit();        // collect info about this machine
80103764:	e8 4d 04 00 00       	call   80103bb6 <mpinit>
  lapicinit();
80103769:	e8 0d f9 ff ff       	call   8010307b <lapicinit>
  seginit();       // set up segments
8010376e:	e8 46 3e 00 00       	call   801075b9 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
80103773:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103779:	0f b6 00             	movzbl (%eax),%eax
8010377c:	0f b6 c0             	movzbl %al,%eax
8010377f:	83 ec 08             	sub    $0x8,%esp
80103782:	50                   	push   %eax
80103783:	68 cc b6 10 80       	push   $0x8010b6cc
80103788:	e8 39 cc ff ff       	call   801003c6 <cprintf>
8010378d:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
80103790:	e8 77 06 00 00       	call   80103e0c <picinit>
  ioapicinit();    // another interrupt controller
80103795:	e8 24 f3 ff ff       	call   80102abe <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
8010379a:	e8 4a d3 ff ff       	call   80100ae9 <consoleinit>
  uartinit();      // serial port
8010379f:	e8 71 31 00 00       	call   80106915 <uartinit>
  pinit();         // process table
801037a4:	e8 60 0b 00 00       	call   80104309 <pinit>
  tvinit();        // trap vectors
801037a9:	e8 17 2d 00 00       	call   801064c5 <tvinit>
  binit();         // buffer cache
801037ae:	e8 81 c8 ff ff       	call   80100034 <binit>
  fileinit();      // file table
801037b3:	e8 8e d7 ff ff       	call   80100f46 <fileinit>
  iinit();         // inode cache
801037b8:	e8 67 de ff ff       	call   80101624 <iinit>
  ideinit();       // disk
801037bd:	e8 40 ef ff ff       	call   80102702 <ideinit>
  if(!ismp)
801037c2:	a1 64 29 11 80       	mov    0x80112964,%eax
801037c7:	85 c0                	test   %eax,%eax
801037c9:	75 05                	jne    801037d0 <main+0x97>
    timerinit();   // uniprocessor timer
801037cb:	e8 52 2c 00 00       	call   80106422 <timerinit>
  startothers();   // start other processors
801037d0:	e8 84 00 00 00       	call   80103859 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801037d5:	83 ec 08             	sub    $0x8,%esp
801037d8:	68 00 00 00 8e       	push   $0x8e000000
801037dd:	68 00 00 40 80       	push   $0x80400000
801037e2:	e8 1b f4 ff ff       	call   80102c02 <kinit2>
801037e7:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
801037ea:	e8 3e 0c 00 00       	call   8010442d <userinit>
    
  //InitHandle();
  APGuiInit();
801037ef:	e8 9b 65 00 00       	call   80109d8f <APGuiInit>
    
  // Finish setting up this processor in mpmain.
  mpmain();
801037f4:	e8 1a 00 00 00       	call   80103813 <mpmain>

801037f9 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801037f9:	55                   	push   %ebp
801037fa:	89 e5                	mov    %esp,%ebp
801037fc:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
801037ff:	e8 24 44 00 00       	call   80107c28 <switchkvm>
  seginit();
80103804:	e8 b0 3d 00 00       	call   801075b9 <seginit>
  lapicinit();
80103809:	e8 6d f8 ff ff       	call   8010307b <lapicinit>
  mpmain();
8010380e:	e8 00 00 00 00       	call   80103813 <mpmain>

80103813 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103813:	55                   	push   %ebp
80103814:	89 e5                	mov    %esp,%ebp
80103816:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
80103819:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010381f:	0f b6 00             	movzbl (%eax),%eax
80103822:	0f b6 c0             	movzbl %al,%eax
80103825:	83 ec 08             	sub    $0x8,%esp
80103828:	50                   	push   %eax
80103829:	68 e3 b6 10 80       	push   $0x8010b6e3
8010382e:	e8 93 cb ff ff       	call   801003c6 <cprintf>
80103833:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
80103836:	e8 00 2e 00 00       	call   8010663b <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
8010383b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103841:	05 a8 00 00 00       	add    $0xa8,%eax
80103846:	83 ec 08             	sub    $0x8,%esp
80103849:	6a 01                	push   $0x1
8010384b:	50                   	push   %eax
8010384c:	e8 ce fe ff ff       	call   8010371f <xchg>
80103851:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
80103854:	e8 55 11 00 00       	call   801049ae <scheduler>

80103859 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103859:	55                   	push   %ebp
8010385a:	89 e5                	mov    %esp,%ebp
8010385c:	53                   	push   %ebx
8010385d:	83 ec 14             	sub    $0x14,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
80103860:	68 00 70 00 00       	push   $0x7000
80103865:	e8 a8 fe ff ff       	call   80103712 <p2v>
8010386a:	83 c4 04             	add    $0x4,%esp
8010386d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103870:	b8 8a 00 00 00       	mov    $0x8a,%eax
80103875:	83 ec 04             	sub    $0x4,%esp
80103878:	50                   	push   %eax
80103879:	68 38 e5 10 80       	push   $0x8010e538
8010387e:	ff 75 f0             	pushl  -0x10(%ebp)
80103881:	e8 10 19 00 00       	call   80105196 <memmove>
80103886:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80103889:	c7 45 f4 80 29 11 80 	movl   $0x80112980,-0xc(%ebp)
80103890:	e9 90 00 00 00       	jmp    80103925 <startothers+0xcc>
    if(c == cpus+cpunum())  // We've started already.
80103895:	e8 ff f8 ff ff       	call   80103199 <cpunum>
8010389a:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801038a0:	05 80 29 11 80       	add    $0x80112980,%eax
801038a5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801038a8:	74 73                	je     8010391d <startothers+0xc4>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801038aa:	e8 51 f4 ff ff       	call   80102d00 <kalloc>
801038af:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
801038b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038b5:	83 e8 04             	sub    $0x4,%eax
801038b8:	8b 55 ec             	mov    -0x14(%ebp),%edx
801038bb:	81 c2 00 10 00 00    	add    $0x1000,%edx
801038c1:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
801038c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038c6:	83 e8 08             	sub    $0x8,%eax
801038c9:	c7 00 f9 37 10 80    	movl   $0x801037f9,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
801038cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038d2:	8d 58 f4             	lea    -0xc(%eax),%ebx
801038d5:	83 ec 0c             	sub    $0xc,%esp
801038d8:	68 00 d0 10 80       	push   $0x8010d000
801038dd:	e8 23 fe ff ff       	call   80103705 <v2p>
801038e2:	83 c4 10             	add    $0x10,%esp
801038e5:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
801038e7:	83 ec 0c             	sub    $0xc,%esp
801038ea:	ff 75 f0             	pushl  -0x10(%ebp)
801038ed:	e8 13 fe ff ff       	call   80103705 <v2p>
801038f2:	83 c4 10             	add    $0x10,%esp
801038f5:	89 c2                	mov    %eax,%edx
801038f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038fa:	0f b6 00             	movzbl (%eax),%eax
801038fd:	0f b6 c0             	movzbl %al,%eax
80103900:	83 ec 08             	sub    $0x8,%esp
80103903:	52                   	push   %edx
80103904:	50                   	push   %eax
80103905:	e8 09 f9 ff ff       	call   80103213 <lapicstartap>
8010390a:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
8010390d:	90                   	nop
8010390e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103911:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103917:	85 c0                	test   %eax,%eax
80103919:	74 f3                	je     8010390e <startothers+0xb5>
8010391b:	eb 01                	jmp    8010391e <startothers+0xc5>
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
8010391d:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010391e:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103925:	a1 60 2f 11 80       	mov    0x80112f60,%eax
8010392a:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103930:	05 80 29 11 80       	add    $0x80112980,%eax
80103935:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103938:	0f 87 57 ff ff ff    	ja     80103895 <startothers+0x3c>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
8010393e:	90                   	nop
8010393f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103942:	c9                   	leave  
80103943:	c3                   	ret    

80103944 <p2v>:
80103944:	55                   	push   %ebp
80103945:	89 e5                	mov    %esp,%ebp
80103947:	8b 45 08             	mov    0x8(%ebp),%eax
8010394a:	05 00 00 00 80       	add    $0x80000000,%eax
8010394f:	5d                   	pop    %ebp
80103950:	c3                   	ret    

80103951 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80103951:	55                   	push   %ebp
80103952:	89 e5                	mov    %esp,%ebp
80103954:	83 ec 14             	sub    $0x14,%esp
80103957:	8b 45 08             	mov    0x8(%ebp),%eax
8010395a:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010395e:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103962:	89 c2                	mov    %eax,%edx
80103964:	ec                   	in     (%dx),%al
80103965:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103968:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
8010396c:	c9                   	leave  
8010396d:	c3                   	ret    

8010396e <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
8010396e:	55                   	push   %ebp
8010396f:	89 e5                	mov    %esp,%ebp
80103971:	83 ec 08             	sub    $0x8,%esp
80103974:	8b 55 08             	mov    0x8(%ebp),%edx
80103977:	8b 45 0c             	mov    0xc(%ebp),%eax
8010397a:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010397e:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103981:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103985:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103989:	ee                   	out    %al,(%dx)
}
8010398a:	90                   	nop
8010398b:	c9                   	leave  
8010398c:	c3                   	ret    

8010398d <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
8010398d:	55                   	push   %ebp
8010398e:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103990:	a1 88 e6 10 80       	mov    0x8010e688,%eax
80103995:	89 c2                	mov    %eax,%edx
80103997:	b8 80 29 11 80       	mov    $0x80112980,%eax
8010399c:	29 c2                	sub    %eax,%edx
8010399e:	89 d0                	mov    %edx,%eax
801039a0:	c1 f8 02             	sar    $0x2,%eax
801039a3:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
801039a9:	5d                   	pop    %ebp
801039aa:	c3                   	ret    

801039ab <sum>:

static uchar
sum(uchar *addr, int len)
{
801039ab:	55                   	push   %ebp
801039ac:	89 e5                	mov    %esp,%ebp
801039ae:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
801039b1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
801039b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801039bf:	eb 15                	jmp    801039d6 <sum+0x2b>
    sum += addr[i];
801039c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
801039c4:	8b 45 08             	mov    0x8(%ebp),%eax
801039c7:	01 d0                	add    %edx,%eax
801039c9:	0f b6 00             	movzbl (%eax),%eax
801039cc:	0f b6 c0             	movzbl %al,%eax
801039cf:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
801039d2:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801039d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
801039d9:	3b 45 0c             	cmp    0xc(%ebp),%eax
801039dc:	7c e3                	jl     801039c1 <sum+0x16>
    sum += addr[i];
  return sum;
801039de:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
801039e1:	c9                   	leave  
801039e2:	c3                   	ret    

801039e3 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801039e3:	55                   	push   %ebp
801039e4:	89 e5                	mov    %esp,%ebp
801039e6:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
801039e9:	ff 75 08             	pushl  0x8(%ebp)
801039ec:	e8 53 ff ff ff       	call   80103944 <p2v>
801039f1:	83 c4 04             	add    $0x4,%esp
801039f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
801039f7:	8b 55 0c             	mov    0xc(%ebp),%edx
801039fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039fd:	01 d0                	add    %edx,%eax
801039ff:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103a02:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a05:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103a08:	eb 36                	jmp    80103a40 <mpsearch1+0x5d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103a0a:	83 ec 04             	sub    $0x4,%esp
80103a0d:	6a 04                	push   $0x4
80103a0f:	68 f4 b6 10 80       	push   $0x8010b6f4
80103a14:	ff 75 f4             	pushl  -0xc(%ebp)
80103a17:	e8 22 17 00 00       	call   8010513e <memcmp>
80103a1c:	83 c4 10             	add    $0x10,%esp
80103a1f:	85 c0                	test   %eax,%eax
80103a21:	75 19                	jne    80103a3c <mpsearch1+0x59>
80103a23:	83 ec 08             	sub    $0x8,%esp
80103a26:	6a 10                	push   $0x10
80103a28:	ff 75 f4             	pushl  -0xc(%ebp)
80103a2b:	e8 7b ff ff ff       	call   801039ab <sum>
80103a30:	83 c4 10             	add    $0x10,%esp
80103a33:	84 c0                	test   %al,%al
80103a35:	75 05                	jne    80103a3c <mpsearch1+0x59>
      return (struct mp*)p;
80103a37:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a3a:	eb 11                	jmp    80103a4d <mpsearch1+0x6a>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103a3c:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103a40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a43:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103a46:	72 c2                	jb     80103a0a <mpsearch1+0x27>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103a48:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103a4d:	c9                   	leave  
80103a4e:	c3                   	ret    

80103a4f <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103a4f:	55                   	push   %ebp
80103a50:	89 e5                	mov    %esp,%ebp
80103a52:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103a55:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103a5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a5f:	83 c0 0f             	add    $0xf,%eax
80103a62:	0f b6 00             	movzbl (%eax),%eax
80103a65:	0f b6 c0             	movzbl %al,%eax
80103a68:	c1 e0 08             	shl    $0x8,%eax
80103a6b:	89 c2                	mov    %eax,%edx
80103a6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a70:	83 c0 0e             	add    $0xe,%eax
80103a73:	0f b6 00             	movzbl (%eax),%eax
80103a76:	0f b6 c0             	movzbl %al,%eax
80103a79:	09 d0                	or     %edx,%eax
80103a7b:	c1 e0 04             	shl    $0x4,%eax
80103a7e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103a81:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103a85:	74 21                	je     80103aa8 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103a87:	83 ec 08             	sub    $0x8,%esp
80103a8a:	68 00 04 00 00       	push   $0x400
80103a8f:	ff 75 f0             	pushl  -0x10(%ebp)
80103a92:	e8 4c ff ff ff       	call   801039e3 <mpsearch1>
80103a97:	83 c4 10             	add    $0x10,%esp
80103a9a:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103a9d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103aa1:	74 51                	je     80103af4 <mpsearch+0xa5>
      return mp;
80103aa3:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103aa6:	eb 61                	jmp    80103b09 <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103aa8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103aab:	83 c0 14             	add    $0x14,%eax
80103aae:	0f b6 00             	movzbl (%eax),%eax
80103ab1:	0f b6 c0             	movzbl %al,%eax
80103ab4:	c1 e0 08             	shl    $0x8,%eax
80103ab7:	89 c2                	mov    %eax,%edx
80103ab9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103abc:	83 c0 13             	add    $0x13,%eax
80103abf:	0f b6 00             	movzbl (%eax),%eax
80103ac2:	0f b6 c0             	movzbl %al,%eax
80103ac5:	09 d0                	or     %edx,%eax
80103ac7:	c1 e0 0a             	shl    $0xa,%eax
80103aca:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103acd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ad0:	2d 00 04 00 00       	sub    $0x400,%eax
80103ad5:	83 ec 08             	sub    $0x8,%esp
80103ad8:	68 00 04 00 00       	push   $0x400
80103add:	50                   	push   %eax
80103ade:	e8 00 ff ff ff       	call   801039e3 <mpsearch1>
80103ae3:	83 c4 10             	add    $0x10,%esp
80103ae6:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103ae9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103aed:	74 05                	je     80103af4 <mpsearch+0xa5>
      return mp;
80103aef:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103af2:	eb 15                	jmp    80103b09 <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80103af4:	83 ec 08             	sub    $0x8,%esp
80103af7:	68 00 00 01 00       	push   $0x10000
80103afc:	68 00 00 0f 00       	push   $0xf0000
80103b01:	e8 dd fe ff ff       	call   801039e3 <mpsearch1>
80103b06:	83 c4 10             	add    $0x10,%esp
}
80103b09:	c9                   	leave  
80103b0a:	c3                   	ret    

80103b0b <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103b0b:	55                   	push   %ebp
80103b0c:	89 e5                	mov    %esp,%ebp
80103b0e:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103b11:	e8 39 ff ff ff       	call   80103a4f <mpsearch>
80103b16:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103b19:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103b1d:	74 0a                	je     80103b29 <mpconfig+0x1e>
80103b1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b22:	8b 40 04             	mov    0x4(%eax),%eax
80103b25:	85 c0                	test   %eax,%eax
80103b27:	75 0a                	jne    80103b33 <mpconfig+0x28>
    return 0;
80103b29:	b8 00 00 00 00       	mov    $0x0,%eax
80103b2e:	e9 81 00 00 00       	jmp    80103bb4 <mpconfig+0xa9>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103b33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b36:	8b 40 04             	mov    0x4(%eax),%eax
80103b39:	83 ec 0c             	sub    $0xc,%esp
80103b3c:	50                   	push   %eax
80103b3d:	e8 02 fe ff ff       	call   80103944 <p2v>
80103b42:	83 c4 10             	add    $0x10,%esp
80103b45:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103b48:	83 ec 04             	sub    $0x4,%esp
80103b4b:	6a 04                	push   $0x4
80103b4d:	68 f9 b6 10 80       	push   $0x8010b6f9
80103b52:	ff 75 f0             	pushl  -0x10(%ebp)
80103b55:	e8 e4 15 00 00       	call   8010513e <memcmp>
80103b5a:	83 c4 10             	add    $0x10,%esp
80103b5d:	85 c0                	test   %eax,%eax
80103b5f:	74 07                	je     80103b68 <mpconfig+0x5d>
    return 0;
80103b61:	b8 00 00 00 00       	mov    $0x0,%eax
80103b66:	eb 4c                	jmp    80103bb4 <mpconfig+0xa9>
  if(conf->version != 1 && conf->version != 4)
80103b68:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b6b:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103b6f:	3c 01                	cmp    $0x1,%al
80103b71:	74 12                	je     80103b85 <mpconfig+0x7a>
80103b73:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b76:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103b7a:	3c 04                	cmp    $0x4,%al
80103b7c:	74 07                	je     80103b85 <mpconfig+0x7a>
    return 0;
80103b7e:	b8 00 00 00 00       	mov    $0x0,%eax
80103b83:	eb 2f                	jmp    80103bb4 <mpconfig+0xa9>
  if(sum((uchar*)conf, conf->length) != 0)
80103b85:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b88:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103b8c:	0f b7 c0             	movzwl %ax,%eax
80103b8f:	83 ec 08             	sub    $0x8,%esp
80103b92:	50                   	push   %eax
80103b93:	ff 75 f0             	pushl  -0x10(%ebp)
80103b96:	e8 10 fe ff ff       	call   801039ab <sum>
80103b9b:	83 c4 10             	add    $0x10,%esp
80103b9e:	84 c0                	test   %al,%al
80103ba0:	74 07                	je     80103ba9 <mpconfig+0x9e>
    return 0;
80103ba2:	b8 00 00 00 00       	mov    $0x0,%eax
80103ba7:	eb 0b                	jmp    80103bb4 <mpconfig+0xa9>
  *pmp = mp;
80103ba9:	8b 45 08             	mov    0x8(%ebp),%eax
80103bac:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103baf:	89 10                	mov    %edx,(%eax)
  return conf;
80103bb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103bb4:	c9                   	leave  
80103bb5:	c3                   	ret    

80103bb6 <mpinit>:

void
mpinit(void)
{
80103bb6:	55                   	push   %ebp
80103bb7:	89 e5                	mov    %esp,%ebp
80103bb9:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103bbc:	c7 05 88 e6 10 80 80 	movl   $0x80112980,0x8010e688
80103bc3:	29 11 80 
  if((conf = mpconfig(&mp)) == 0)
80103bc6:	83 ec 0c             	sub    $0xc,%esp
80103bc9:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103bcc:	50                   	push   %eax
80103bcd:	e8 39 ff ff ff       	call   80103b0b <mpconfig>
80103bd2:	83 c4 10             	add    $0x10,%esp
80103bd5:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103bd8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103bdc:	0f 84 96 01 00 00    	je     80103d78 <mpinit+0x1c2>
    return;
  ismp = 1;
80103be2:	c7 05 64 29 11 80 01 	movl   $0x1,0x80112964
80103be9:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103bec:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bef:	8b 40 24             	mov    0x24(%eax),%eax
80103bf2:	a3 dc 28 11 80       	mov    %eax,0x801128dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103bf7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bfa:	83 c0 2c             	add    $0x2c,%eax
80103bfd:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c00:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c03:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103c07:	0f b7 d0             	movzwl %ax,%edx
80103c0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c0d:	01 d0                	add    %edx,%eax
80103c0f:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c12:	e9 f2 00 00 00       	jmp    80103d09 <mpinit+0x153>
    switch(*p){
80103c17:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c1a:	0f b6 00             	movzbl (%eax),%eax
80103c1d:	0f b6 c0             	movzbl %al,%eax
80103c20:	83 f8 04             	cmp    $0x4,%eax
80103c23:	0f 87 bc 00 00 00    	ja     80103ce5 <mpinit+0x12f>
80103c29:	8b 04 85 3c b7 10 80 	mov    -0x7fef48c4(,%eax,4),%eax
80103c30:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103c32:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c35:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103c38:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103c3b:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103c3f:	0f b6 d0             	movzbl %al,%edx
80103c42:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103c47:	39 c2                	cmp    %eax,%edx
80103c49:	74 2b                	je     80103c76 <mpinit+0xc0>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103c4b:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103c4e:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103c52:	0f b6 d0             	movzbl %al,%edx
80103c55:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103c5a:	83 ec 04             	sub    $0x4,%esp
80103c5d:	52                   	push   %edx
80103c5e:	50                   	push   %eax
80103c5f:	68 fe b6 10 80       	push   $0x8010b6fe
80103c64:	e8 5d c7 ff ff       	call   801003c6 <cprintf>
80103c69:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
80103c6c:	c7 05 64 29 11 80 00 	movl   $0x0,0x80112964
80103c73:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103c76:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103c79:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103c7d:	0f b6 c0             	movzbl %al,%eax
80103c80:	83 e0 02             	and    $0x2,%eax
80103c83:	85 c0                	test   %eax,%eax
80103c85:	74 15                	je     80103c9c <mpinit+0xe6>
        bcpu = &cpus[ncpu];
80103c87:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103c8c:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103c92:	05 80 29 11 80       	add    $0x80112980,%eax
80103c97:	a3 88 e6 10 80       	mov    %eax,0x8010e688
      cpus[ncpu].id = ncpu;
80103c9c:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103ca1:	8b 15 60 2f 11 80    	mov    0x80112f60,%edx
80103ca7:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103cad:	05 80 29 11 80       	add    $0x80112980,%eax
80103cb2:	88 10                	mov    %dl,(%eax)
      ncpu++;
80103cb4:	a1 60 2f 11 80       	mov    0x80112f60,%eax
80103cb9:	83 c0 01             	add    $0x1,%eax
80103cbc:	a3 60 2f 11 80       	mov    %eax,0x80112f60
      p += sizeof(struct mpproc);
80103cc1:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103cc5:	eb 42                	jmp    80103d09 <mpinit+0x153>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103cc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103ccd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103cd0:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103cd4:	a2 60 29 11 80       	mov    %al,0x80112960
      p += sizeof(struct mpioapic);
80103cd9:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103cdd:	eb 2a                	jmp    80103d09 <mpinit+0x153>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103cdf:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103ce3:	eb 24                	jmp    80103d09 <mpinit+0x153>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103ce5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ce8:	0f b6 00             	movzbl (%eax),%eax
80103ceb:	0f b6 c0             	movzbl %al,%eax
80103cee:	83 ec 08             	sub    $0x8,%esp
80103cf1:	50                   	push   %eax
80103cf2:	68 1c b7 10 80       	push   $0x8010b71c
80103cf7:	e8 ca c6 ff ff       	call   801003c6 <cprintf>
80103cfc:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
80103cff:	c7 05 64 29 11 80 00 	movl   $0x0,0x80112964
80103d06:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103d09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d0c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103d0f:	0f 82 02 ff ff ff    	jb     80103c17 <mpinit+0x61>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103d15:	a1 64 29 11 80       	mov    0x80112964,%eax
80103d1a:	85 c0                	test   %eax,%eax
80103d1c:	75 1d                	jne    80103d3b <mpinit+0x185>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103d1e:	c7 05 60 2f 11 80 01 	movl   $0x1,0x80112f60
80103d25:	00 00 00 
    lapic = 0;
80103d28:	c7 05 dc 28 11 80 00 	movl   $0x0,0x801128dc
80103d2f:	00 00 00 
    ioapicid = 0;
80103d32:	c6 05 60 29 11 80 00 	movb   $0x0,0x80112960
    return;
80103d39:	eb 3e                	jmp    80103d79 <mpinit+0x1c3>
  }

  if(mp->imcrp){
80103d3b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103d3e:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103d42:	84 c0                	test   %al,%al
80103d44:	74 33                	je     80103d79 <mpinit+0x1c3>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103d46:	83 ec 08             	sub    $0x8,%esp
80103d49:	6a 70                	push   $0x70
80103d4b:	6a 22                	push   $0x22
80103d4d:	e8 1c fc ff ff       	call   8010396e <outb>
80103d52:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103d55:	83 ec 0c             	sub    $0xc,%esp
80103d58:	6a 23                	push   $0x23
80103d5a:	e8 f2 fb ff ff       	call   80103951 <inb>
80103d5f:	83 c4 10             	add    $0x10,%esp
80103d62:	83 c8 01             	or     $0x1,%eax
80103d65:	0f b6 c0             	movzbl %al,%eax
80103d68:	83 ec 08             	sub    $0x8,%esp
80103d6b:	50                   	push   %eax
80103d6c:	6a 23                	push   $0x23
80103d6e:	e8 fb fb ff ff       	call   8010396e <outb>
80103d73:	83 c4 10             	add    $0x10,%esp
80103d76:	eb 01                	jmp    80103d79 <mpinit+0x1c3>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
80103d78:	90                   	nop
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103d79:	c9                   	leave  
80103d7a:	c3                   	ret    

80103d7b <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103d7b:	55                   	push   %ebp
80103d7c:	89 e5                	mov    %esp,%ebp
80103d7e:	83 ec 08             	sub    $0x8,%esp
80103d81:	8b 55 08             	mov    0x8(%ebp),%edx
80103d84:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d87:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103d8b:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103d8e:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103d92:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103d96:	ee                   	out    %al,(%dx)
}
80103d97:	90                   	nop
80103d98:	c9                   	leave  
80103d99:	c3                   	ret    

80103d9a <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103d9a:	55                   	push   %ebp
80103d9b:	89 e5                	mov    %esp,%ebp
80103d9d:	83 ec 04             	sub    $0x4,%esp
80103da0:	8b 45 08             	mov    0x8(%ebp),%eax
80103da3:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103da7:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103dab:	66 a3 00 e0 10 80    	mov    %ax,0x8010e000
  outb(IO_PIC1+1, mask);
80103db1:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103db5:	0f b6 c0             	movzbl %al,%eax
80103db8:	50                   	push   %eax
80103db9:	6a 21                	push   $0x21
80103dbb:	e8 bb ff ff ff       	call   80103d7b <outb>
80103dc0:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80103dc3:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103dc7:	66 c1 e8 08          	shr    $0x8,%ax
80103dcb:	0f b6 c0             	movzbl %al,%eax
80103dce:	50                   	push   %eax
80103dcf:	68 a1 00 00 00       	push   $0xa1
80103dd4:	e8 a2 ff ff ff       	call   80103d7b <outb>
80103dd9:	83 c4 08             	add    $0x8,%esp
}
80103ddc:	90                   	nop
80103ddd:	c9                   	leave  
80103dde:	c3                   	ret    

80103ddf <picenable>:

void
picenable(int irq)
{
80103ddf:	55                   	push   %ebp
80103de0:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80103de2:	8b 45 08             	mov    0x8(%ebp),%eax
80103de5:	ba 01 00 00 00       	mov    $0x1,%edx
80103dea:	89 c1                	mov    %eax,%ecx
80103dec:	d3 e2                	shl    %cl,%edx
80103dee:	89 d0                	mov    %edx,%eax
80103df0:	f7 d0                	not    %eax
80103df2:	89 c2                	mov    %eax,%edx
80103df4:	0f b7 05 00 e0 10 80 	movzwl 0x8010e000,%eax
80103dfb:	21 d0                	and    %edx,%eax
80103dfd:	0f b7 c0             	movzwl %ax,%eax
80103e00:	50                   	push   %eax
80103e01:	e8 94 ff ff ff       	call   80103d9a <picsetmask>
80103e06:	83 c4 04             	add    $0x4,%esp
}
80103e09:	90                   	nop
80103e0a:	c9                   	leave  
80103e0b:	c3                   	ret    

80103e0c <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103e0c:	55                   	push   %ebp
80103e0d:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103e0f:	68 ff 00 00 00       	push   $0xff
80103e14:	6a 21                	push   $0x21
80103e16:	e8 60 ff ff ff       	call   80103d7b <outb>
80103e1b:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80103e1e:	68 ff 00 00 00       	push   $0xff
80103e23:	68 a1 00 00 00       	push   $0xa1
80103e28:	e8 4e ff ff ff       	call   80103d7b <outb>
80103e2d:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103e30:	6a 11                	push   $0x11
80103e32:	6a 20                	push   $0x20
80103e34:	e8 42 ff ff ff       	call   80103d7b <outb>
80103e39:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103e3c:	6a 20                	push   $0x20
80103e3e:	6a 21                	push   $0x21
80103e40:	e8 36 ff ff ff       	call   80103d7b <outb>
80103e45:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103e48:	6a 04                	push   $0x4
80103e4a:	6a 21                	push   $0x21
80103e4c:	e8 2a ff ff ff       	call   80103d7b <outb>
80103e51:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103e54:	6a 03                	push   $0x3
80103e56:	6a 21                	push   $0x21
80103e58:	e8 1e ff ff ff       	call   80103d7b <outb>
80103e5d:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103e60:	6a 11                	push   $0x11
80103e62:	68 a0 00 00 00       	push   $0xa0
80103e67:	e8 0f ff ff ff       	call   80103d7b <outb>
80103e6c:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103e6f:	6a 28                	push   $0x28
80103e71:	68 a1 00 00 00       	push   $0xa1
80103e76:	e8 00 ff ff ff       	call   80103d7b <outb>
80103e7b:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103e7e:	6a 02                	push   $0x2
80103e80:	68 a1 00 00 00       	push   $0xa1
80103e85:	e8 f1 fe ff ff       	call   80103d7b <outb>
80103e8a:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103e8d:	6a 03                	push   $0x3
80103e8f:	68 a1 00 00 00       	push   $0xa1
80103e94:	e8 e2 fe ff ff       	call   80103d7b <outb>
80103e99:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103e9c:	6a 68                	push   $0x68
80103e9e:	6a 20                	push   $0x20
80103ea0:	e8 d6 fe ff ff       	call   80103d7b <outb>
80103ea5:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103ea8:	6a 0a                	push   $0xa
80103eaa:	6a 20                	push   $0x20
80103eac:	e8 ca fe ff ff       	call   80103d7b <outb>
80103eb1:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
80103eb4:	6a 68                	push   $0x68
80103eb6:	68 a0 00 00 00       	push   $0xa0
80103ebb:	e8 bb fe ff ff       	call   80103d7b <outb>
80103ec0:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
80103ec3:	6a 0a                	push   $0xa
80103ec5:	68 a0 00 00 00       	push   $0xa0
80103eca:	e8 ac fe ff ff       	call   80103d7b <outb>
80103ecf:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
80103ed2:	0f b7 05 00 e0 10 80 	movzwl 0x8010e000,%eax
80103ed9:	66 83 f8 ff          	cmp    $0xffff,%ax
80103edd:	74 13                	je     80103ef2 <picinit+0xe6>
    picsetmask(irqmask);
80103edf:	0f b7 05 00 e0 10 80 	movzwl 0x8010e000,%eax
80103ee6:	0f b7 c0             	movzwl %ax,%eax
80103ee9:	50                   	push   %eax
80103eea:	e8 ab fe ff ff       	call   80103d9a <picsetmask>
80103eef:	83 c4 04             	add    $0x4,%esp
}
80103ef2:	90                   	nop
80103ef3:	c9                   	leave  
80103ef4:	c3                   	ret    

80103ef5 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103ef5:	55                   	push   %ebp
80103ef6:	89 e5                	mov    %esp,%ebp
80103ef8:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80103efb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103f02:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f05:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103f0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f0e:	8b 10                	mov    (%eax),%edx
80103f10:	8b 45 08             	mov    0x8(%ebp),%eax
80103f13:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103f15:	e8 4a d0 ff ff       	call   80100f64 <filealloc>
80103f1a:	89 c2                	mov    %eax,%edx
80103f1c:	8b 45 08             	mov    0x8(%ebp),%eax
80103f1f:	89 10                	mov    %edx,(%eax)
80103f21:	8b 45 08             	mov    0x8(%ebp),%eax
80103f24:	8b 00                	mov    (%eax),%eax
80103f26:	85 c0                	test   %eax,%eax
80103f28:	0f 84 cb 00 00 00    	je     80103ff9 <pipealloc+0x104>
80103f2e:	e8 31 d0 ff ff       	call   80100f64 <filealloc>
80103f33:	89 c2                	mov    %eax,%edx
80103f35:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f38:	89 10                	mov    %edx,(%eax)
80103f3a:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f3d:	8b 00                	mov    (%eax),%eax
80103f3f:	85 c0                	test   %eax,%eax
80103f41:	0f 84 b2 00 00 00    	je     80103ff9 <pipealloc+0x104>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103f47:	e8 b4 ed ff ff       	call   80102d00 <kalloc>
80103f4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103f4f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103f53:	0f 84 9f 00 00 00    	je     80103ff8 <pipealloc+0x103>
    goto bad;
  p->readopen = 1;
80103f59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f5c:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103f63:	00 00 00 
  p->writeopen = 1;
80103f66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f69:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103f70:	00 00 00 
  p->nwrite = 0;
80103f73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f76:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103f7d:	00 00 00 
  p->nread = 0;
80103f80:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f83:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103f8a:	00 00 00 
  initlock(&p->lock, "pipe");
80103f8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f90:	83 ec 08             	sub    $0x8,%esp
80103f93:	68 50 b7 10 80       	push   $0x8010b750
80103f98:	50                   	push   %eax
80103f99:	e8 b4 0e 00 00       	call   80104e52 <initlock>
80103f9e:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103fa1:	8b 45 08             	mov    0x8(%ebp),%eax
80103fa4:	8b 00                	mov    (%eax),%eax
80103fa6:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103fac:	8b 45 08             	mov    0x8(%ebp),%eax
80103faf:	8b 00                	mov    (%eax),%eax
80103fb1:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103fb5:	8b 45 08             	mov    0x8(%ebp),%eax
80103fb8:	8b 00                	mov    (%eax),%eax
80103fba:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103fbe:	8b 45 08             	mov    0x8(%ebp),%eax
80103fc1:	8b 00                	mov    (%eax),%eax
80103fc3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103fc6:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103fc9:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fcc:	8b 00                	mov    (%eax),%eax
80103fce:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103fd4:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fd7:	8b 00                	mov    (%eax),%eax
80103fd9:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103fdd:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fe0:	8b 00                	mov    (%eax),%eax
80103fe2:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103fe6:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fe9:	8b 00                	mov    (%eax),%eax
80103feb:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103fee:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80103ff1:	b8 00 00 00 00       	mov    $0x0,%eax
80103ff6:	eb 4e                	jmp    80104046 <pipealloc+0x151>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
80103ff8:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
80103ff9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103ffd:	74 0e                	je     8010400d <pipealloc+0x118>
    kfree((char*)p);
80103fff:	83 ec 0c             	sub    $0xc,%esp
80104002:	ff 75 f4             	pushl  -0xc(%ebp)
80104005:	e8 59 ec ff ff       	call   80102c63 <kfree>
8010400a:	83 c4 10             	add    $0x10,%esp
  if(*f0)
8010400d:	8b 45 08             	mov    0x8(%ebp),%eax
80104010:	8b 00                	mov    (%eax),%eax
80104012:	85 c0                	test   %eax,%eax
80104014:	74 11                	je     80104027 <pipealloc+0x132>
    fileclose(*f0);
80104016:	8b 45 08             	mov    0x8(%ebp),%eax
80104019:	8b 00                	mov    (%eax),%eax
8010401b:	83 ec 0c             	sub    $0xc,%esp
8010401e:	50                   	push   %eax
8010401f:	e8 fe cf ff ff       	call   80101022 <fileclose>
80104024:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80104027:	8b 45 0c             	mov    0xc(%ebp),%eax
8010402a:	8b 00                	mov    (%eax),%eax
8010402c:	85 c0                	test   %eax,%eax
8010402e:	74 11                	je     80104041 <pipealloc+0x14c>
    fileclose(*f1);
80104030:	8b 45 0c             	mov    0xc(%ebp),%eax
80104033:	8b 00                	mov    (%eax),%eax
80104035:	83 ec 0c             	sub    $0xc,%esp
80104038:	50                   	push   %eax
80104039:	e8 e4 cf ff ff       	call   80101022 <fileclose>
8010403e:	83 c4 10             	add    $0x10,%esp
  return -1;
80104041:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104046:	c9                   	leave  
80104047:	c3                   	ret    

80104048 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104048:	55                   	push   %ebp
80104049:	89 e5                	mov    %esp,%ebp
8010404b:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
8010404e:	8b 45 08             	mov    0x8(%ebp),%eax
80104051:	83 ec 0c             	sub    $0xc,%esp
80104054:	50                   	push   %eax
80104055:	e8 1a 0e 00 00       	call   80104e74 <acquire>
8010405a:	83 c4 10             	add    $0x10,%esp
  if(writable){
8010405d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104061:	74 23                	je     80104086 <pipeclose+0x3e>
    p->writeopen = 0;
80104063:	8b 45 08             	mov    0x8(%ebp),%eax
80104066:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
8010406d:	00 00 00 
    wakeup(&p->nread);
80104070:	8b 45 08             	mov    0x8(%ebp),%eax
80104073:	05 34 02 00 00       	add    $0x234,%eax
80104078:	83 ec 0c             	sub    $0xc,%esp
8010407b:	50                   	push   %eax
8010407c:	e8 e5 0b 00 00       	call   80104c66 <wakeup>
80104081:	83 c4 10             	add    $0x10,%esp
80104084:	eb 21                	jmp    801040a7 <pipeclose+0x5f>
  } else {
    p->readopen = 0;
80104086:	8b 45 08             	mov    0x8(%ebp),%eax
80104089:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80104090:	00 00 00 
    wakeup(&p->nwrite);
80104093:	8b 45 08             	mov    0x8(%ebp),%eax
80104096:	05 38 02 00 00       	add    $0x238,%eax
8010409b:	83 ec 0c             	sub    $0xc,%esp
8010409e:	50                   	push   %eax
8010409f:	e8 c2 0b 00 00       	call   80104c66 <wakeup>
801040a4:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
801040a7:	8b 45 08             	mov    0x8(%ebp),%eax
801040aa:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
801040b0:	85 c0                	test   %eax,%eax
801040b2:	75 2c                	jne    801040e0 <pipeclose+0x98>
801040b4:	8b 45 08             	mov    0x8(%ebp),%eax
801040b7:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801040bd:	85 c0                	test   %eax,%eax
801040bf:	75 1f                	jne    801040e0 <pipeclose+0x98>
    release(&p->lock);
801040c1:	8b 45 08             	mov    0x8(%ebp),%eax
801040c4:	83 ec 0c             	sub    $0xc,%esp
801040c7:	50                   	push   %eax
801040c8:	e8 0e 0e 00 00       	call   80104edb <release>
801040cd:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
801040d0:	83 ec 0c             	sub    $0xc,%esp
801040d3:	ff 75 08             	pushl  0x8(%ebp)
801040d6:	e8 88 eb ff ff       	call   80102c63 <kfree>
801040db:	83 c4 10             	add    $0x10,%esp
801040de:	eb 0f                	jmp    801040ef <pipeclose+0xa7>
  } else
    release(&p->lock);
801040e0:	8b 45 08             	mov    0x8(%ebp),%eax
801040e3:	83 ec 0c             	sub    $0xc,%esp
801040e6:	50                   	push   %eax
801040e7:	e8 ef 0d 00 00       	call   80104edb <release>
801040ec:	83 c4 10             	add    $0x10,%esp
}
801040ef:	90                   	nop
801040f0:	c9                   	leave  
801040f1:	c3                   	ret    

801040f2 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801040f2:	55                   	push   %ebp
801040f3:	89 e5                	mov    %esp,%ebp
801040f5:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
801040f8:	8b 45 08             	mov    0x8(%ebp),%eax
801040fb:	83 ec 0c             	sub    $0xc,%esp
801040fe:	50                   	push   %eax
801040ff:	e8 70 0d 00 00       	call   80104e74 <acquire>
80104104:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
80104107:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010410e:	e9 ad 00 00 00       	jmp    801041c0 <pipewrite+0xce>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
80104113:	8b 45 08             	mov    0x8(%ebp),%eax
80104116:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
8010411c:	85 c0                	test   %eax,%eax
8010411e:	74 0d                	je     8010412d <pipewrite+0x3b>
80104120:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104126:	8b 40 24             	mov    0x24(%eax),%eax
80104129:	85 c0                	test   %eax,%eax
8010412b:	74 19                	je     80104146 <pipewrite+0x54>
        release(&p->lock);
8010412d:	8b 45 08             	mov    0x8(%ebp),%eax
80104130:	83 ec 0c             	sub    $0xc,%esp
80104133:	50                   	push   %eax
80104134:	e8 a2 0d 00 00       	call   80104edb <release>
80104139:	83 c4 10             	add    $0x10,%esp
        return -1;
8010413c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104141:	e9 a8 00 00 00       	jmp    801041ee <pipewrite+0xfc>
      }
      wakeup(&p->nread);
80104146:	8b 45 08             	mov    0x8(%ebp),%eax
80104149:	05 34 02 00 00       	add    $0x234,%eax
8010414e:	83 ec 0c             	sub    $0xc,%esp
80104151:	50                   	push   %eax
80104152:	e8 0f 0b 00 00       	call   80104c66 <wakeup>
80104157:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010415a:	8b 45 08             	mov    0x8(%ebp),%eax
8010415d:	8b 55 08             	mov    0x8(%ebp),%edx
80104160:	81 c2 38 02 00 00    	add    $0x238,%edx
80104166:	83 ec 08             	sub    $0x8,%esp
80104169:	50                   	push   %eax
8010416a:	52                   	push   %edx
8010416b:	e8 0b 0a 00 00       	call   80104b7b <sleep>
80104170:	83 c4 10             	add    $0x10,%esp
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104173:	8b 45 08             	mov    0x8(%ebp),%eax
80104176:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
8010417c:	8b 45 08             	mov    0x8(%ebp),%eax
8010417f:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104185:	05 00 02 00 00       	add    $0x200,%eax
8010418a:	39 c2                	cmp    %eax,%edx
8010418c:	74 85                	je     80104113 <pipewrite+0x21>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010418e:	8b 45 08             	mov    0x8(%ebp),%eax
80104191:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104197:	8d 48 01             	lea    0x1(%eax),%ecx
8010419a:	8b 55 08             	mov    0x8(%ebp),%edx
8010419d:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
801041a3:	25 ff 01 00 00       	and    $0x1ff,%eax
801041a8:	89 c1                	mov    %eax,%ecx
801041aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801041ad:	8b 45 0c             	mov    0xc(%ebp),%eax
801041b0:	01 d0                	add    %edx,%eax
801041b2:	0f b6 10             	movzbl (%eax),%edx
801041b5:	8b 45 08             	mov    0x8(%ebp),%eax
801041b8:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
801041bc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801041c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041c3:	3b 45 10             	cmp    0x10(%ebp),%eax
801041c6:	7c ab                	jl     80104173 <pipewrite+0x81>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801041c8:	8b 45 08             	mov    0x8(%ebp),%eax
801041cb:	05 34 02 00 00       	add    $0x234,%eax
801041d0:	83 ec 0c             	sub    $0xc,%esp
801041d3:	50                   	push   %eax
801041d4:	e8 8d 0a 00 00       	call   80104c66 <wakeup>
801041d9:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801041dc:	8b 45 08             	mov    0x8(%ebp),%eax
801041df:	83 ec 0c             	sub    $0xc,%esp
801041e2:	50                   	push   %eax
801041e3:	e8 f3 0c 00 00       	call   80104edb <release>
801041e8:	83 c4 10             	add    $0x10,%esp
  return n;
801041eb:	8b 45 10             	mov    0x10(%ebp),%eax
}
801041ee:	c9                   	leave  
801041ef:	c3                   	ret    

801041f0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
801041f3:	53                   	push   %ebx
801041f4:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
801041f7:	8b 45 08             	mov    0x8(%ebp),%eax
801041fa:	83 ec 0c             	sub    $0xc,%esp
801041fd:	50                   	push   %eax
801041fe:	e8 71 0c 00 00       	call   80104e74 <acquire>
80104203:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104206:	eb 3f                	jmp    80104247 <piperead+0x57>
    if(proc->killed){
80104208:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010420e:	8b 40 24             	mov    0x24(%eax),%eax
80104211:	85 c0                	test   %eax,%eax
80104213:	74 19                	je     8010422e <piperead+0x3e>
      release(&p->lock);
80104215:	8b 45 08             	mov    0x8(%ebp),%eax
80104218:	83 ec 0c             	sub    $0xc,%esp
8010421b:	50                   	push   %eax
8010421c:	e8 ba 0c 00 00       	call   80104edb <release>
80104221:	83 c4 10             	add    $0x10,%esp
      return -1;
80104224:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104229:	e9 bf 00 00 00       	jmp    801042ed <piperead+0xfd>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010422e:	8b 45 08             	mov    0x8(%ebp),%eax
80104231:	8b 55 08             	mov    0x8(%ebp),%edx
80104234:	81 c2 34 02 00 00    	add    $0x234,%edx
8010423a:	83 ec 08             	sub    $0x8,%esp
8010423d:	50                   	push   %eax
8010423e:	52                   	push   %edx
8010423f:	e8 37 09 00 00       	call   80104b7b <sleep>
80104244:	83 c4 10             	add    $0x10,%esp
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104247:	8b 45 08             	mov    0x8(%ebp),%eax
8010424a:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104250:	8b 45 08             	mov    0x8(%ebp),%eax
80104253:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104259:	39 c2                	cmp    %eax,%edx
8010425b:	75 0d                	jne    8010426a <piperead+0x7a>
8010425d:	8b 45 08             	mov    0x8(%ebp),%eax
80104260:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104266:	85 c0                	test   %eax,%eax
80104268:	75 9e                	jne    80104208 <piperead+0x18>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010426a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104271:	eb 49                	jmp    801042bc <piperead+0xcc>
    if(p->nread == p->nwrite)
80104273:	8b 45 08             	mov    0x8(%ebp),%eax
80104276:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
8010427c:	8b 45 08             	mov    0x8(%ebp),%eax
8010427f:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104285:	39 c2                	cmp    %eax,%edx
80104287:	74 3d                	je     801042c6 <piperead+0xd6>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104289:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010428c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010428f:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80104292:	8b 45 08             	mov    0x8(%ebp),%eax
80104295:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
8010429b:	8d 48 01             	lea    0x1(%eax),%ecx
8010429e:	8b 55 08             	mov    0x8(%ebp),%edx
801042a1:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
801042a7:	25 ff 01 00 00       	and    $0x1ff,%eax
801042ac:	89 c2                	mov    %eax,%edx
801042ae:	8b 45 08             	mov    0x8(%ebp),%eax
801042b1:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
801042b6:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801042b8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801042bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042bf:	3b 45 10             	cmp    0x10(%ebp),%eax
801042c2:	7c af                	jl     80104273 <piperead+0x83>
801042c4:	eb 01                	jmp    801042c7 <piperead+0xd7>
    if(p->nread == p->nwrite)
      break;
801042c6:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801042c7:	8b 45 08             	mov    0x8(%ebp),%eax
801042ca:	05 38 02 00 00       	add    $0x238,%eax
801042cf:	83 ec 0c             	sub    $0xc,%esp
801042d2:	50                   	push   %eax
801042d3:	e8 8e 09 00 00       	call   80104c66 <wakeup>
801042d8:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801042db:	8b 45 08             	mov    0x8(%ebp),%eax
801042de:	83 ec 0c             	sub    $0xc,%esp
801042e1:	50                   	push   %eax
801042e2:	e8 f4 0b 00 00       	call   80104edb <release>
801042e7:	83 c4 10             	add    $0x10,%esp
  return i;
801042ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801042ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042f0:	c9                   	leave  
801042f1:	c3                   	ret    

801042f2 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
801042f2:	55                   	push   %ebp
801042f3:	89 e5                	mov    %esp,%ebp
801042f5:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801042f8:	9c                   	pushf  
801042f9:	58                   	pop    %eax
801042fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801042fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104300:	c9                   	leave  
80104301:	c3                   	ret    

80104302 <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
80104302:	55                   	push   %ebp
80104303:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104305:	fb                   	sti    
}
80104306:	90                   	nop
80104307:	5d                   	pop    %ebp
80104308:	c3                   	ret    

80104309 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80104309:	55                   	push   %ebp
8010430a:	89 e5                	mov    %esp,%ebp
8010430c:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
8010430f:	83 ec 08             	sub    $0x8,%esp
80104312:	68 55 b7 10 80       	push   $0x8010b755
80104317:	68 80 2f 11 80       	push   $0x80112f80
8010431c:	e8 31 0b 00 00       	call   80104e52 <initlock>
80104321:	83 c4 10             	add    $0x10,%esp
}
80104324:	90                   	nop
80104325:	c9                   	leave  
80104326:	c3                   	ret    

80104327 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104327:	55                   	push   %ebp
80104328:	89 e5                	mov    %esp,%ebp
8010432a:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010432d:	83 ec 0c             	sub    $0xc,%esp
80104330:	68 80 2f 11 80       	push   $0x80112f80
80104335:	e8 3a 0b 00 00       	call   80104e74 <acquire>
8010433a:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010433d:	c7 45 f4 b4 2f 11 80 	movl   $0x80112fb4,-0xc(%ebp)
80104344:	eb 0e                	jmp    80104354 <allocproc+0x2d>
    if(p->state == UNUSED)
80104346:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104349:	8b 40 0c             	mov    0xc(%eax),%eax
8010434c:	85 c0                	test   %eax,%eax
8010434e:	74 27                	je     80104377 <allocproc+0x50>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104350:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104354:	81 7d f4 b4 4e 11 80 	cmpl   $0x80114eb4,-0xc(%ebp)
8010435b:	72 e9                	jb     80104346 <allocproc+0x1f>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
8010435d:	83 ec 0c             	sub    $0xc,%esp
80104360:	68 80 2f 11 80       	push   $0x80112f80
80104365:	e8 71 0b 00 00       	call   80104edb <release>
8010436a:	83 c4 10             	add    $0x10,%esp
  return 0;
8010436d:	b8 00 00 00 00       	mov    $0x0,%eax
80104372:	e9 b4 00 00 00       	jmp    8010442b <allocproc+0x104>
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
80104377:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80104378:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010437b:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
80104382:	a1 04 e0 10 80       	mov    0x8010e004,%eax
80104387:	8d 50 01             	lea    0x1(%eax),%edx
8010438a:	89 15 04 e0 10 80    	mov    %edx,0x8010e004
80104390:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104393:	89 42 10             	mov    %eax,0x10(%edx)
  release(&ptable.lock);
80104396:	83 ec 0c             	sub    $0xc,%esp
80104399:	68 80 2f 11 80       	push   $0x80112f80
8010439e:	e8 38 0b 00 00       	call   80104edb <release>
801043a3:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801043a6:	e8 55 e9 ff ff       	call   80102d00 <kalloc>
801043ab:	89 c2                	mov    %eax,%edx
801043ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043b0:	89 50 08             	mov    %edx,0x8(%eax)
801043b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043b6:	8b 40 08             	mov    0x8(%eax),%eax
801043b9:	85 c0                	test   %eax,%eax
801043bb:	75 11                	jne    801043ce <allocproc+0xa7>
    p->state = UNUSED;
801043bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043c0:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
801043c7:	b8 00 00 00 00       	mov    $0x0,%eax
801043cc:	eb 5d                	jmp    8010442b <allocproc+0x104>
  }
  sp = p->kstack + KSTACKSIZE;
801043ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043d1:	8b 40 08             	mov    0x8(%eax),%eax
801043d4:	05 00 10 00 00       	add    $0x1000,%eax
801043d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801043dc:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
801043e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043e3:	8b 55 f0             	mov    -0x10(%ebp),%edx
801043e6:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
801043e9:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
801043ed:	ba 7f 64 10 80       	mov    $0x8010647f,%edx
801043f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801043f5:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
801043f7:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
801043fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043fe:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104401:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
80104404:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104407:	8b 40 1c             	mov    0x1c(%eax),%eax
8010440a:	83 ec 04             	sub    $0x4,%esp
8010440d:	6a 14                	push   $0x14
8010440f:	6a 00                	push   $0x0
80104411:	50                   	push   %eax
80104412:	e8 c0 0c 00 00       	call   801050d7 <memset>
80104417:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
8010441a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010441d:	8b 40 1c             	mov    0x1c(%eax),%eax
80104420:	ba 4a 4b 10 80       	mov    $0x80104b4a,%edx
80104425:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
80104428:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010442b:	c9                   	leave  
8010442c:	c3                   	ret    

8010442d <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
8010442d:	55                   	push   %ebp
8010442e:	89 e5                	mov    %esp,%ebp
80104430:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
80104433:	e8 ef fe ff ff       	call   80104327 <allocproc>
80104438:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
8010443b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010443e:	a3 8c e6 10 80       	mov    %eax,0x8010e68c
  if((p->pgdir = setupkvm()) == 0)
80104443:	e8 16 37 00 00       	call   80107b5e <setupkvm>
80104448:	89 c2                	mov    %eax,%edx
8010444a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010444d:	89 50 04             	mov    %edx,0x4(%eax)
80104450:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104453:	8b 40 04             	mov    0x4(%eax),%eax
80104456:	85 c0                	test   %eax,%eax
80104458:	75 0d                	jne    80104467 <userinit+0x3a>
    panic("userinit: out of memory?");
8010445a:	83 ec 0c             	sub    $0xc,%esp
8010445d:	68 5c b7 10 80       	push   $0x8010b75c
80104462:	e8 ff c0 ff ff       	call   80100566 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104467:	ba 2c 00 00 00       	mov    $0x2c,%edx
8010446c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010446f:	8b 40 04             	mov    0x4(%eax),%eax
80104472:	83 ec 04             	sub    $0x4,%esp
80104475:	52                   	push   %edx
80104476:	68 0c e5 10 80       	push   $0x8010e50c
8010447b:	50                   	push   %eax
8010447c:	e8 37 39 00 00       	call   80107db8 <inituvm>
80104481:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
80104484:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104487:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
8010448d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104490:	8b 40 18             	mov    0x18(%eax),%eax
80104493:	83 ec 04             	sub    $0x4,%esp
80104496:	6a 4c                	push   $0x4c
80104498:	6a 00                	push   $0x0
8010449a:	50                   	push   %eax
8010449b:	e8 37 0c 00 00       	call   801050d7 <memset>
801044a0:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801044a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044a6:	8b 40 18             	mov    0x18(%eax),%eax
801044a9:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801044af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044b2:	8b 40 18             	mov    0x18(%eax),%eax
801044b5:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
801044bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044be:	8b 40 18             	mov    0x18(%eax),%eax
801044c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044c4:	8b 52 18             	mov    0x18(%edx),%edx
801044c7:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801044cb:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801044cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044d2:	8b 40 18             	mov    0x18(%eax),%eax
801044d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044d8:	8b 52 18             	mov    0x18(%edx),%edx
801044db:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801044df:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801044e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044e6:	8b 40 18             	mov    0x18(%eax),%eax
801044e9:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801044f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044f3:	8b 40 18             	mov    0x18(%eax),%eax
801044f6:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801044fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104500:	8b 40 18             	mov    0x18(%eax),%eax
80104503:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010450a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010450d:	83 c0 6c             	add    $0x6c,%eax
80104510:	83 ec 04             	sub    $0x4,%esp
80104513:	6a 10                	push   $0x10
80104515:	68 75 b7 10 80       	push   $0x8010b775
8010451a:	50                   	push   %eax
8010451b:	e8 ba 0d 00 00       	call   801052da <safestrcpy>
80104520:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
80104523:	83 ec 0c             	sub    $0xc,%esp
80104526:	68 7e b7 10 80       	push   $0x8010b77e
8010452b:	e8 ce e0 ff ff       	call   801025fe <namei>
80104530:	83 c4 10             	add    $0x10,%esp
80104533:	89 c2                	mov    %eax,%edx
80104535:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104538:	89 50 68             	mov    %edx,0x68(%eax)

  p->state = RUNNABLE;
8010453b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010453e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
80104545:	90                   	nop
80104546:	c9                   	leave  
80104547:	c3                   	ret    

80104548 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104548:	55                   	push   %ebp
80104549:	89 e5                	mov    %esp,%ebp
8010454b:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  
  sz = proc->sz;
8010454e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104554:	8b 00                	mov    (%eax),%eax
80104556:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80104559:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010455d:	7e 31                	jle    80104590 <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
8010455f:	8b 55 08             	mov    0x8(%ebp),%edx
80104562:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104565:	01 c2                	add    %eax,%edx
80104567:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010456d:	8b 40 04             	mov    0x4(%eax),%eax
80104570:	83 ec 04             	sub    $0x4,%esp
80104573:	52                   	push   %edx
80104574:	ff 75 f4             	pushl  -0xc(%ebp)
80104577:	50                   	push   %eax
80104578:	e8 88 39 00 00       	call   80107f05 <allocuvm>
8010457d:	83 c4 10             	add    $0x10,%esp
80104580:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104583:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104587:	75 3e                	jne    801045c7 <growproc+0x7f>
      return -1;
80104589:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010458e:	eb 59                	jmp    801045e9 <growproc+0xa1>
  } else if(n < 0){
80104590:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104594:	79 31                	jns    801045c7 <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80104596:	8b 55 08             	mov    0x8(%ebp),%edx
80104599:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010459c:	01 c2                	add    %eax,%edx
8010459e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045a4:	8b 40 04             	mov    0x4(%eax),%eax
801045a7:	83 ec 04             	sub    $0x4,%esp
801045aa:	52                   	push   %edx
801045ab:	ff 75 f4             	pushl  -0xc(%ebp)
801045ae:	50                   	push   %eax
801045af:	e8 1a 3a 00 00       	call   80107fce <deallocuvm>
801045b4:	83 c4 10             	add    $0x10,%esp
801045b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801045ba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801045be:	75 07                	jne    801045c7 <growproc+0x7f>
      return -1;
801045c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045c5:	eb 22                	jmp    801045e9 <growproc+0xa1>
  }
  proc->sz = sz;
801045c7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045d0:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
801045d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045d8:	83 ec 0c             	sub    $0xc,%esp
801045db:	50                   	push   %eax
801045dc:	e8 64 36 00 00       	call   80107c45 <switchuvm>
801045e1:	83 c4 10             	add    $0x10,%esp
  return 0;
801045e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801045e9:	c9                   	leave  
801045ea:	c3                   	ret    

801045eb <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801045eb:	55                   	push   %ebp
801045ec:	89 e5                	mov    %esp,%ebp
801045ee:	57                   	push   %edi
801045ef:	56                   	push   %esi
801045f0:	53                   	push   %ebx
801045f1:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
801045f4:	e8 2e fd ff ff       	call   80104327 <allocproc>
801045f9:	89 45 e0             	mov    %eax,-0x20(%ebp)
801045fc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80104600:	75 0a                	jne    8010460c <fork+0x21>
    return -1;
80104602:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104607:	e9 48 01 00 00       	jmp    80104754 <fork+0x169>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
8010460c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104612:	8b 10                	mov    (%eax),%edx
80104614:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010461a:	8b 40 04             	mov    0x4(%eax),%eax
8010461d:	83 ec 08             	sub    $0x8,%esp
80104620:	52                   	push   %edx
80104621:	50                   	push   %eax
80104622:	e8 45 3b 00 00       	call   8010816c <copyuvm>
80104627:	83 c4 10             	add    $0x10,%esp
8010462a:	89 c2                	mov    %eax,%edx
8010462c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010462f:	89 50 04             	mov    %edx,0x4(%eax)
80104632:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104635:	8b 40 04             	mov    0x4(%eax),%eax
80104638:	85 c0                	test   %eax,%eax
8010463a:	75 30                	jne    8010466c <fork+0x81>
    kfree(np->kstack);
8010463c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010463f:	8b 40 08             	mov    0x8(%eax),%eax
80104642:	83 ec 0c             	sub    $0xc,%esp
80104645:	50                   	push   %eax
80104646:	e8 18 e6 ff ff       	call   80102c63 <kfree>
8010464b:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
8010464e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104651:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80104658:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010465b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
80104662:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104667:	e9 e8 00 00 00       	jmp    80104754 <fork+0x169>
  }
  np->sz = proc->sz;
8010466c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104672:	8b 10                	mov    (%eax),%edx
80104674:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104677:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
80104679:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104680:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104683:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
80104686:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104689:	8b 50 18             	mov    0x18(%eax),%edx
8010468c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104692:	8b 40 18             	mov    0x18(%eax),%eax
80104695:	89 c3                	mov    %eax,%ebx
80104697:	b8 13 00 00 00       	mov    $0x13,%eax
8010469c:	89 d7                	mov    %edx,%edi
8010469e:	89 de                	mov    %ebx,%esi
801046a0:	89 c1                	mov    %eax,%ecx
801046a2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
801046a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046a7:	8b 40 18             	mov    0x18(%eax),%eax
801046aa:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
801046b1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801046b8:	eb 43                	jmp    801046fd <fork+0x112>
    if(proc->ofile[i])
801046ba:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046c0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801046c3:	83 c2 08             	add    $0x8,%edx
801046c6:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801046ca:	85 c0                	test   %eax,%eax
801046cc:	74 2b                	je     801046f9 <fork+0x10e>
      np->ofile[i] = filedup(proc->ofile[i]);
801046ce:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046d4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801046d7:	83 c2 08             	add    $0x8,%edx
801046da:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801046de:	83 ec 0c             	sub    $0xc,%esp
801046e1:	50                   	push   %eax
801046e2:	e8 ea c8 ff ff       	call   80100fd1 <filedup>
801046e7:	83 c4 10             	add    $0x10,%esp
801046ea:	89 c1                	mov    %eax,%ecx
801046ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046ef:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801046f2:	83 c2 08             	add    $0x8,%edx
801046f5:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801046f9:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801046fd:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104701:	7e b7                	jle    801046ba <fork+0xcf>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80104703:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104709:	8b 40 68             	mov    0x68(%eax),%eax
8010470c:	83 ec 0c             	sub    $0xc,%esp
8010470f:	50                   	push   %eax
80104710:	e8 a8 d1 ff ff       	call   801018bd <idup>
80104715:	83 c4 10             	add    $0x10,%esp
80104718:	89 c2                	mov    %eax,%edx
8010471a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010471d:	89 50 68             	mov    %edx,0x68(%eax)
 
  pid = np->pid;
80104720:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104723:	8b 40 10             	mov    0x10(%eax),%eax
80104726:	89 45 dc             	mov    %eax,-0x24(%ebp)
  np->state = RUNNABLE;
80104729:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010472c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80104733:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104739:	8d 50 6c             	lea    0x6c(%eax),%edx
8010473c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010473f:	83 c0 6c             	add    $0x6c,%eax
80104742:	83 ec 04             	sub    $0x4,%esp
80104745:	6a 10                	push   $0x10
80104747:	52                   	push   %edx
80104748:	50                   	push   %eax
80104749:	e8 8c 0b 00 00       	call   801052da <safestrcpy>
8010474e:	83 c4 10             	add    $0x10,%esp
  return pid;
80104751:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80104754:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104757:	5b                   	pop    %ebx
80104758:	5e                   	pop    %esi
80104759:	5f                   	pop    %edi
8010475a:	5d                   	pop    %ebp
8010475b:	c3                   	ret    

8010475c <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
8010475c:	55                   	push   %ebp
8010475d:	89 e5                	mov    %esp,%ebp
8010475f:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80104762:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104769:	a1 8c e6 10 80       	mov    0x8010e68c,%eax
8010476e:	39 c2                	cmp    %eax,%edx
80104770:	75 0d                	jne    8010477f <exit+0x23>
    panic("init exiting");
80104772:	83 ec 0c             	sub    $0xc,%esp
80104775:	68 80 b7 10 80       	push   $0x8010b780
8010477a:	e8 e7 bd ff ff       	call   80100566 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
8010477f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104786:	eb 48                	jmp    801047d0 <exit+0x74>
    if(proc->ofile[fd]){
80104788:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010478e:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104791:	83 c2 08             	add    $0x8,%edx
80104794:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104798:	85 c0                	test   %eax,%eax
8010479a:	74 30                	je     801047cc <exit+0x70>
      fileclose(proc->ofile[fd]);
8010479c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047a2:	8b 55 f0             	mov    -0x10(%ebp),%edx
801047a5:	83 c2 08             	add    $0x8,%edx
801047a8:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801047ac:	83 ec 0c             	sub    $0xc,%esp
801047af:	50                   	push   %eax
801047b0:	e8 6d c8 ff ff       	call   80101022 <fileclose>
801047b5:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
801047b8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047be:	8b 55 f0             	mov    -0x10(%ebp),%edx
801047c1:	83 c2 08             	add    $0x8,%edx
801047c4:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801047cb:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801047cc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801047d0:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
801047d4:	7e b2                	jle    80104788 <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
801047d6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047dc:	8b 40 68             	mov    0x68(%eax),%eax
801047df:	83 ec 0c             	sub    $0xc,%esp
801047e2:	50                   	push   %eax
801047e3:	e8 d9 d2 ff ff       	call   80101ac1 <iput>
801047e8:	83 c4 10             	add    $0x10,%esp
  proc->cwd = 0;
801047eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047f1:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
801047f8:	83 ec 0c             	sub    $0xc,%esp
801047fb:	68 80 2f 11 80       	push   $0x80112f80
80104800:	e8 6f 06 00 00       	call   80104e74 <acquire>
80104805:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80104808:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010480e:	8b 40 14             	mov    0x14(%eax),%eax
80104811:	83 ec 0c             	sub    $0xc,%esp
80104814:	50                   	push   %eax
80104815:	e8 0d 04 00 00       	call   80104c27 <wakeup1>
8010481a:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010481d:	c7 45 f4 b4 2f 11 80 	movl   $0x80112fb4,-0xc(%ebp)
80104824:	eb 3c                	jmp    80104862 <exit+0x106>
    if(p->parent == proc){
80104826:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104829:	8b 50 14             	mov    0x14(%eax),%edx
8010482c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104832:	39 c2                	cmp    %eax,%edx
80104834:	75 28                	jne    8010485e <exit+0x102>
      p->parent = initproc;
80104836:	8b 15 8c e6 10 80    	mov    0x8010e68c,%edx
8010483c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010483f:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
80104842:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104845:	8b 40 0c             	mov    0xc(%eax),%eax
80104848:	83 f8 05             	cmp    $0x5,%eax
8010484b:	75 11                	jne    8010485e <exit+0x102>
        wakeup1(initproc);
8010484d:	a1 8c e6 10 80       	mov    0x8010e68c,%eax
80104852:	83 ec 0c             	sub    $0xc,%esp
80104855:	50                   	push   %eax
80104856:	e8 cc 03 00 00       	call   80104c27 <wakeup1>
8010485b:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010485e:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104862:	81 7d f4 b4 4e 11 80 	cmpl   $0x80114eb4,-0xc(%ebp)
80104869:	72 bb                	jb     80104826 <exit+0xca>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
8010486b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104871:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
80104878:	e8 d6 01 00 00       	call   80104a53 <sched>
  panic("zombie exit");
8010487d:	83 ec 0c             	sub    $0xc,%esp
80104880:	68 8d b7 10 80       	push   $0x8010b78d
80104885:	e8 dc bc ff ff       	call   80100566 <panic>

8010488a <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
8010488a:	55                   	push   %ebp
8010488b:	89 e5                	mov    %esp,%ebp
8010488d:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80104890:	83 ec 0c             	sub    $0xc,%esp
80104893:	68 80 2f 11 80       	push   $0x80112f80
80104898:	e8 d7 05 00 00       	call   80104e74 <acquire>
8010489d:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
801048a0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048a7:	c7 45 f4 b4 2f 11 80 	movl   $0x80112fb4,-0xc(%ebp)
801048ae:	e9 a6 00 00 00       	jmp    80104959 <wait+0xcf>
      if(p->parent != proc)
801048b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048b6:	8b 50 14             	mov    0x14(%eax),%edx
801048b9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048bf:	39 c2                	cmp    %eax,%edx
801048c1:	0f 85 8d 00 00 00    	jne    80104954 <wait+0xca>
        continue;
      havekids = 1;
801048c7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
801048ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048d1:	8b 40 0c             	mov    0xc(%eax),%eax
801048d4:	83 f8 05             	cmp    $0x5,%eax
801048d7:	75 7c                	jne    80104955 <wait+0xcb>
        // Found one.
        pid = p->pid;
801048d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048dc:	8b 40 10             	mov    0x10(%eax),%eax
801048df:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
801048e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048e5:	8b 40 08             	mov    0x8(%eax),%eax
801048e8:	83 ec 0c             	sub    $0xc,%esp
801048eb:	50                   	push   %eax
801048ec:	e8 72 e3 ff ff       	call   80102c63 <kfree>
801048f1:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
801048f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048f7:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
801048fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104901:	8b 40 04             	mov    0x4(%eax),%eax
80104904:	83 ec 0c             	sub    $0xc,%esp
80104907:	50                   	push   %eax
80104908:	e8 7e 37 00 00       	call   8010808b <freevm>
8010490d:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
80104910:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104913:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
8010491a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010491d:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104924:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104927:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
8010492e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104931:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104935:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104938:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
8010493f:	83 ec 0c             	sub    $0xc,%esp
80104942:	68 80 2f 11 80       	push   $0x80112f80
80104947:	e8 8f 05 00 00       	call   80104edb <release>
8010494c:	83 c4 10             	add    $0x10,%esp
        return pid;
8010494f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104952:	eb 58                	jmp    801049ac <wait+0x122>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
80104954:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104955:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104959:	81 7d f4 b4 4e 11 80 	cmpl   $0x80114eb4,-0xc(%ebp)
80104960:	0f 82 4d ff ff ff    	jb     801048b3 <wait+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104966:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010496a:	74 0d                	je     80104979 <wait+0xef>
8010496c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104972:	8b 40 24             	mov    0x24(%eax),%eax
80104975:	85 c0                	test   %eax,%eax
80104977:	74 17                	je     80104990 <wait+0x106>
      release(&ptable.lock);
80104979:	83 ec 0c             	sub    $0xc,%esp
8010497c:	68 80 2f 11 80       	push   $0x80112f80
80104981:	e8 55 05 00 00       	call   80104edb <release>
80104986:	83 c4 10             	add    $0x10,%esp
      return -1;
80104989:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010498e:	eb 1c                	jmp    801049ac <wait+0x122>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104990:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104996:	83 ec 08             	sub    $0x8,%esp
80104999:	68 80 2f 11 80       	push   $0x80112f80
8010499e:	50                   	push   %eax
8010499f:	e8 d7 01 00 00       	call   80104b7b <sleep>
801049a4:	83 c4 10             	add    $0x10,%esp
  }
801049a7:	e9 f4 fe ff ff       	jmp    801048a0 <wait+0x16>
}
801049ac:	c9                   	leave  
801049ad:	c3                   	ret    

801049ae <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
801049ae:	55                   	push   %ebp
801049af:	89 e5                	mov    %esp,%ebp
801049b1:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
801049b4:	e8 49 f9 ff ff       	call   80104302 <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
801049b9:	83 ec 0c             	sub    $0xc,%esp
801049bc:	68 80 2f 11 80       	push   $0x80112f80
801049c1:	e8 ae 04 00 00       	call   80104e74 <acquire>
801049c6:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049c9:	c7 45 f4 b4 2f 11 80 	movl   $0x80112fb4,-0xc(%ebp)
801049d0:	eb 63                	jmp    80104a35 <scheduler+0x87>
      if(p->state != RUNNABLE)
801049d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049d5:	8b 40 0c             	mov    0xc(%eax),%eax
801049d8:	83 f8 03             	cmp    $0x3,%eax
801049db:	75 53                	jne    80104a30 <scheduler+0x82>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
801049dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049e0:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
801049e6:	83 ec 0c             	sub    $0xc,%esp
801049e9:	ff 75 f4             	pushl  -0xc(%ebp)
801049ec:	e8 54 32 00 00       	call   80107c45 <switchuvm>
801049f1:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
801049f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f7:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
801049fe:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a04:	8b 40 1c             	mov    0x1c(%eax),%eax
80104a07:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104a0e:	83 c2 04             	add    $0x4,%edx
80104a11:	83 ec 08             	sub    $0x8,%esp
80104a14:	50                   	push   %eax
80104a15:	52                   	push   %edx
80104a16:	e8 30 09 00 00       	call   8010534b <swtch>
80104a1b:	83 c4 10             	add    $0x10,%esp
      switchkvm();
80104a1e:	e8 05 32 00 00       	call   80107c28 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80104a23:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104a2a:	00 00 00 00 
80104a2e:	eb 01                	jmp    80104a31 <scheduler+0x83>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;
80104a30:	90                   	nop
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a31:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104a35:	81 7d f4 b4 4e 11 80 	cmpl   $0x80114eb4,-0xc(%ebp)
80104a3c:	72 94                	jb     801049d2 <scheduler+0x24>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80104a3e:	83 ec 0c             	sub    $0xc,%esp
80104a41:	68 80 2f 11 80       	push   $0x80112f80
80104a46:	e8 90 04 00 00       	call   80104edb <release>
80104a4b:	83 c4 10             	add    $0x10,%esp

  }
80104a4e:	e9 61 ff ff ff       	jmp    801049b4 <scheduler+0x6>

80104a53 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104a53:	55                   	push   %ebp
80104a54:	89 e5                	mov    %esp,%ebp
80104a56:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104a59:	83 ec 0c             	sub    $0xc,%esp
80104a5c:	68 80 2f 11 80       	push   $0x80112f80
80104a61:	e8 41 05 00 00       	call   80104fa7 <holding>
80104a66:	83 c4 10             	add    $0x10,%esp
80104a69:	85 c0                	test   %eax,%eax
80104a6b:	75 0d                	jne    80104a7a <sched+0x27>
    panic("sched ptable.lock");
80104a6d:	83 ec 0c             	sub    $0xc,%esp
80104a70:	68 99 b7 10 80       	push   $0x8010b799
80104a75:	e8 ec ba ff ff       	call   80100566 <panic>
  if(cpu->ncli != 1)
80104a7a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104a80:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104a86:	83 f8 01             	cmp    $0x1,%eax
80104a89:	74 0d                	je     80104a98 <sched+0x45>
    panic("sched locks");
80104a8b:	83 ec 0c             	sub    $0xc,%esp
80104a8e:	68 ab b7 10 80       	push   $0x8010b7ab
80104a93:	e8 ce ba ff ff       	call   80100566 <panic>
  if(proc->state == RUNNING)
80104a98:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a9e:	8b 40 0c             	mov    0xc(%eax),%eax
80104aa1:	83 f8 04             	cmp    $0x4,%eax
80104aa4:	75 0d                	jne    80104ab3 <sched+0x60>
    panic("sched running");
80104aa6:	83 ec 0c             	sub    $0xc,%esp
80104aa9:	68 b7 b7 10 80       	push   $0x8010b7b7
80104aae:	e8 b3 ba ff ff       	call   80100566 <panic>
  if(readeflags()&FL_IF)
80104ab3:	e8 3a f8 ff ff       	call   801042f2 <readeflags>
80104ab8:	25 00 02 00 00       	and    $0x200,%eax
80104abd:	85 c0                	test   %eax,%eax
80104abf:	74 0d                	je     80104ace <sched+0x7b>
    panic("sched interruptible");
80104ac1:	83 ec 0c             	sub    $0xc,%esp
80104ac4:	68 c5 b7 10 80       	push   $0x8010b7c5
80104ac9:	e8 98 ba ff ff       	call   80100566 <panic>
  intena = cpu->intena;
80104ace:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104ad4:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104ada:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104add:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104ae3:	8b 40 04             	mov    0x4(%eax),%eax
80104ae6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104aed:	83 c2 1c             	add    $0x1c,%edx
80104af0:	83 ec 08             	sub    $0x8,%esp
80104af3:	50                   	push   %eax
80104af4:	52                   	push   %edx
80104af5:	e8 51 08 00 00       	call   8010534b <swtch>
80104afa:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80104afd:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b03:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b06:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104b0c:	90                   	nop
80104b0d:	c9                   	leave  
80104b0e:	c3                   	ret    

80104b0f <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104b0f:	55                   	push   %ebp
80104b10:	89 e5                	mov    %esp,%ebp
80104b12:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104b15:	83 ec 0c             	sub    $0xc,%esp
80104b18:	68 80 2f 11 80       	push   $0x80112f80
80104b1d:	e8 52 03 00 00       	call   80104e74 <acquire>
80104b22:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104b25:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b2b:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104b32:	e8 1c ff ff ff       	call   80104a53 <sched>
  release(&ptable.lock);
80104b37:	83 ec 0c             	sub    $0xc,%esp
80104b3a:	68 80 2f 11 80       	push   $0x80112f80
80104b3f:	e8 97 03 00 00       	call   80104edb <release>
80104b44:	83 c4 10             	add    $0x10,%esp
}
80104b47:	90                   	nop
80104b48:	c9                   	leave  
80104b49:	c3                   	ret    

80104b4a <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104b4a:	55                   	push   %ebp
80104b4b:	89 e5                	mov    %esp,%ebp
80104b4d:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104b50:	83 ec 0c             	sub    $0xc,%esp
80104b53:	68 80 2f 11 80       	push   $0x80112f80
80104b58:	e8 7e 03 00 00       	call   80104edb <release>
80104b5d:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104b60:	a1 08 e0 10 80       	mov    0x8010e008,%eax
80104b65:	85 c0                	test   %eax,%eax
80104b67:	74 0f                	je     80104b78 <forkret+0x2e>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104b69:	c7 05 08 e0 10 80 00 	movl   $0x0,0x8010e008
80104b70:	00 00 00 
    initlog();
80104b73:	e8 7c e7 ff ff       	call   801032f4 <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80104b78:	90                   	nop
80104b79:	c9                   	leave  
80104b7a:	c3                   	ret    

80104b7b <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104b7b:	55                   	push   %ebp
80104b7c:	89 e5                	mov    %esp,%ebp
80104b7e:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
80104b81:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b87:	85 c0                	test   %eax,%eax
80104b89:	75 0d                	jne    80104b98 <sleep+0x1d>
    panic("sleep");
80104b8b:	83 ec 0c             	sub    $0xc,%esp
80104b8e:	68 d9 b7 10 80       	push   $0x8010b7d9
80104b93:	e8 ce b9 ff ff       	call   80100566 <panic>

  if(lk == 0)
80104b98:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104b9c:	75 0d                	jne    80104bab <sleep+0x30>
    panic("sleep without lk");
80104b9e:	83 ec 0c             	sub    $0xc,%esp
80104ba1:	68 df b7 10 80       	push   $0x8010b7df
80104ba6:	e8 bb b9 ff ff       	call   80100566 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104bab:	81 7d 0c 80 2f 11 80 	cmpl   $0x80112f80,0xc(%ebp)
80104bb2:	74 1e                	je     80104bd2 <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104bb4:	83 ec 0c             	sub    $0xc,%esp
80104bb7:	68 80 2f 11 80       	push   $0x80112f80
80104bbc:	e8 b3 02 00 00       	call   80104e74 <acquire>
80104bc1:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104bc4:	83 ec 0c             	sub    $0xc,%esp
80104bc7:	ff 75 0c             	pushl  0xc(%ebp)
80104bca:	e8 0c 03 00 00       	call   80104edb <release>
80104bcf:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80104bd2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bd8:	8b 55 08             	mov    0x8(%ebp),%edx
80104bdb:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104bde:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104be4:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104beb:	e8 63 fe ff ff       	call   80104a53 <sched>

  // Tidy up.
  proc->chan = 0;
80104bf0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bf6:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104bfd:	81 7d 0c 80 2f 11 80 	cmpl   $0x80112f80,0xc(%ebp)
80104c04:	74 1e                	je     80104c24 <sleep+0xa9>
    release(&ptable.lock);
80104c06:	83 ec 0c             	sub    $0xc,%esp
80104c09:	68 80 2f 11 80       	push   $0x80112f80
80104c0e:	e8 c8 02 00 00       	call   80104edb <release>
80104c13:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104c16:	83 ec 0c             	sub    $0xc,%esp
80104c19:	ff 75 0c             	pushl  0xc(%ebp)
80104c1c:	e8 53 02 00 00       	call   80104e74 <acquire>
80104c21:	83 c4 10             	add    $0x10,%esp
  }
}
80104c24:	90                   	nop
80104c25:	c9                   	leave  
80104c26:	c3                   	ret    

80104c27 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104c27:	55                   	push   %ebp
80104c28:	89 e5                	mov    %esp,%ebp
80104c2a:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c2d:	c7 45 fc b4 2f 11 80 	movl   $0x80112fb4,-0x4(%ebp)
80104c34:	eb 24                	jmp    80104c5a <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104c36:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c39:	8b 40 0c             	mov    0xc(%eax),%eax
80104c3c:	83 f8 02             	cmp    $0x2,%eax
80104c3f:	75 15                	jne    80104c56 <wakeup1+0x2f>
80104c41:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c44:	8b 40 20             	mov    0x20(%eax),%eax
80104c47:	3b 45 08             	cmp    0x8(%ebp),%eax
80104c4a:	75 0a                	jne    80104c56 <wakeup1+0x2f>
      p->state = RUNNABLE;
80104c4c:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c4f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c56:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
80104c5a:	81 7d fc b4 4e 11 80 	cmpl   $0x80114eb4,-0x4(%ebp)
80104c61:	72 d3                	jb     80104c36 <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
80104c63:	90                   	nop
80104c64:	c9                   	leave  
80104c65:	c3                   	ret    

80104c66 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104c66:	55                   	push   %ebp
80104c67:	89 e5                	mov    %esp,%ebp
80104c69:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104c6c:	83 ec 0c             	sub    $0xc,%esp
80104c6f:	68 80 2f 11 80       	push   $0x80112f80
80104c74:	e8 fb 01 00 00       	call   80104e74 <acquire>
80104c79:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104c7c:	83 ec 0c             	sub    $0xc,%esp
80104c7f:	ff 75 08             	pushl  0x8(%ebp)
80104c82:	e8 a0 ff ff ff       	call   80104c27 <wakeup1>
80104c87:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104c8a:	83 ec 0c             	sub    $0xc,%esp
80104c8d:	68 80 2f 11 80       	push   $0x80112f80
80104c92:	e8 44 02 00 00       	call   80104edb <release>
80104c97:	83 c4 10             	add    $0x10,%esp
}
80104c9a:	90                   	nop
80104c9b:	c9                   	leave  
80104c9c:	c3                   	ret    

80104c9d <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104c9d:	55                   	push   %ebp
80104c9e:	89 e5                	mov    %esp,%ebp
80104ca0:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104ca3:	83 ec 0c             	sub    $0xc,%esp
80104ca6:	68 80 2f 11 80       	push   $0x80112f80
80104cab:	e8 c4 01 00 00       	call   80104e74 <acquire>
80104cb0:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cb3:	c7 45 f4 b4 2f 11 80 	movl   $0x80112fb4,-0xc(%ebp)
80104cba:	eb 45                	jmp    80104d01 <kill+0x64>
    if(p->pid == pid){
80104cbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cbf:	8b 40 10             	mov    0x10(%eax),%eax
80104cc2:	3b 45 08             	cmp    0x8(%ebp),%eax
80104cc5:	75 36                	jne    80104cfd <kill+0x60>
      p->killed = 1;
80104cc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cca:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104cd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cd4:	8b 40 0c             	mov    0xc(%eax),%eax
80104cd7:	83 f8 02             	cmp    $0x2,%eax
80104cda:	75 0a                	jne    80104ce6 <kill+0x49>
        p->state = RUNNABLE;
80104cdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cdf:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104ce6:	83 ec 0c             	sub    $0xc,%esp
80104ce9:	68 80 2f 11 80       	push   $0x80112f80
80104cee:	e8 e8 01 00 00       	call   80104edb <release>
80104cf3:	83 c4 10             	add    $0x10,%esp
      return 0;
80104cf6:	b8 00 00 00 00       	mov    $0x0,%eax
80104cfb:	eb 22                	jmp    80104d1f <kill+0x82>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cfd:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104d01:	81 7d f4 b4 4e 11 80 	cmpl   $0x80114eb4,-0xc(%ebp)
80104d08:	72 b2                	jb     80104cbc <kill+0x1f>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104d0a:	83 ec 0c             	sub    $0xc,%esp
80104d0d:	68 80 2f 11 80       	push   $0x80112f80
80104d12:	e8 c4 01 00 00       	call   80104edb <release>
80104d17:	83 c4 10             	add    $0x10,%esp
  return -1;
80104d1a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d1f:	c9                   	leave  
80104d20:	c3                   	ret    

80104d21 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104d21:	55                   	push   %ebp
80104d22:	89 e5                	mov    %esp,%ebp
80104d24:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d27:	c7 45 f0 b4 2f 11 80 	movl   $0x80112fb4,-0x10(%ebp)
80104d2e:	e9 d7 00 00 00       	jmp    80104e0a <procdump+0xe9>
    if(p->state == UNUSED)
80104d33:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d36:	8b 40 0c             	mov    0xc(%eax),%eax
80104d39:	85 c0                	test   %eax,%eax
80104d3b:	0f 84 c4 00 00 00    	je     80104e05 <procdump+0xe4>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104d41:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d44:	8b 40 0c             	mov    0xc(%eax),%eax
80104d47:	83 f8 05             	cmp    $0x5,%eax
80104d4a:	77 23                	ja     80104d6f <procdump+0x4e>
80104d4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d4f:	8b 40 0c             	mov    0xc(%eax),%eax
80104d52:	8b 04 85 0c e0 10 80 	mov    -0x7fef1ff4(,%eax,4),%eax
80104d59:	85 c0                	test   %eax,%eax
80104d5b:	74 12                	je     80104d6f <procdump+0x4e>
      state = states[p->state];
80104d5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d60:	8b 40 0c             	mov    0xc(%eax),%eax
80104d63:	8b 04 85 0c e0 10 80 	mov    -0x7fef1ff4(,%eax,4),%eax
80104d6a:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104d6d:	eb 07                	jmp    80104d76 <procdump+0x55>
    else
      state = "???";
80104d6f:	c7 45 ec f0 b7 10 80 	movl   $0x8010b7f0,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104d76:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d79:	8d 50 6c             	lea    0x6c(%eax),%edx
80104d7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d7f:	8b 40 10             	mov    0x10(%eax),%eax
80104d82:	52                   	push   %edx
80104d83:	ff 75 ec             	pushl  -0x14(%ebp)
80104d86:	50                   	push   %eax
80104d87:	68 f4 b7 10 80       	push   $0x8010b7f4
80104d8c:	e8 35 b6 ff ff       	call   801003c6 <cprintf>
80104d91:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80104d94:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d97:	8b 40 0c             	mov    0xc(%eax),%eax
80104d9a:	83 f8 02             	cmp    $0x2,%eax
80104d9d:	75 54                	jne    80104df3 <procdump+0xd2>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104d9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104da2:	8b 40 1c             	mov    0x1c(%eax),%eax
80104da5:	8b 40 0c             	mov    0xc(%eax),%eax
80104da8:	83 c0 08             	add    $0x8,%eax
80104dab:	89 c2                	mov    %eax,%edx
80104dad:	83 ec 08             	sub    $0x8,%esp
80104db0:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104db3:	50                   	push   %eax
80104db4:	52                   	push   %edx
80104db5:	e8 73 01 00 00       	call   80104f2d <getcallerpcs>
80104dba:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104dbd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104dc4:	eb 1c                	jmp    80104de2 <procdump+0xc1>
        cprintf(" %p", pc[i]);
80104dc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104dc9:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104dcd:	83 ec 08             	sub    $0x8,%esp
80104dd0:	50                   	push   %eax
80104dd1:	68 fd b7 10 80       	push   $0x8010b7fd
80104dd6:	e8 eb b5 ff ff       	call   801003c6 <cprintf>
80104ddb:	83 c4 10             	add    $0x10,%esp
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104dde:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104de2:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104de6:	7f 0b                	jg     80104df3 <procdump+0xd2>
80104de8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104deb:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104def:	85 c0                	test   %eax,%eax
80104df1:	75 d3                	jne    80104dc6 <procdump+0xa5>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104df3:	83 ec 0c             	sub    $0xc,%esp
80104df6:	68 01 b8 10 80       	push   $0x8010b801
80104dfb:	e8 c6 b5 ff ff       	call   801003c6 <cprintf>
80104e00:	83 c4 10             	add    $0x10,%esp
80104e03:	eb 01                	jmp    80104e06 <procdump+0xe5>
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
80104e05:	90                   	nop
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e06:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104e0a:	81 7d f0 b4 4e 11 80 	cmpl   $0x80114eb4,-0x10(%ebp)
80104e11:	0f 82 1c ff ff ff    	jb     80104d33 <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104e17:	90                   	nop
80104e18:	c9                   	leave  
80104e19:	c3                   	ret    

80104e1a <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104e1a:	55                   	push   %ebp
80104e1b:	89 e5                	mov    %esp,%ebp
80104e1d:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104e20:	9c                   	pushf  
80104e21:	58                   	pop    %eax
80104e22:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104e25:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104e28:	c9                   	leave  
80104e29:	c3                   	ret    

80104e2a <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80104e2a:	55                   	push   %ebp
80104e2b:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104e2d:	fa                   	cli    
}
80104e2e:	90                   	nop
80104e2f:	5d                   	pop    %ebp
80104e30:	c3                   	ret    

80104e31 <sti>:

static inline void
sti(void)
{
80104e31:	55                   	push   %ebp
80104e32:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104e34:	fb                   	sti    
}
80104e35:	90                   	nop
80104e36:	5d                   	pop    %ebp
80104e37:	c3                   	ret    

80104e38 <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80104e38:	55                   	push   %ebp
80104e39:	89 e5                	mov    %esp,%ebp
80104e3b:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104e3e:	8b 55 08             	mov    0x8(%ebp),%edx
80104e41:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e44:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e47:	f0 87 02             	lock xchg %eax,(%edx)
80104e4a:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104e4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104e50:	c9                   	leave  
80104e51:	c3                   	ret    

80104e52 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104e52:	55                   	push   %ebp
80104e53:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104e55:	8b 45 08             	mov    0x8(%ebp),%eax
80104e58:	8b 55 0c             	mov    0xc(%ebp),%edx
80104e5b:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104e5e:	8b 45 08             	mov    0x8(%ebp),%eax
80104e61:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104e67:	8b 45 08             	mov    0x8(%ebp),%eax
80104e6a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104e71:	90                   	nop
80104e72:	5d                   	pop    %ebp
80104e73:	c3                   	ret    

80104e74 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104e74:	55                   	push   %ebp
80104e75:	89 e5                	mov    %esp,%ebp
80104e77:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104e7a:	e8 52 01 00 00       	call   80104fd1 <pushcli>
  if(holding(lk))
80104e7f:	8b 45 08             	mov    0x8(%ebp),%eax
80104e82:	83 ec 0c             	sub    $0xc,%esp
80104e85:	50                   	push   %eax
80104e86:	e8 1c 01 00 00       	call   80104fa7 <holding>
80104e8b:	83 c4 10             	add    $0x10,%esp
80104e8e:	85 c0                	test   %eax,%eax
80104e90:	74 0d                	je     80104e9f <acquire+0x2b>
    panic("acquire");
80104e92:	83 ec 0c             	sub    $0xc,%esp
80104e95:	68 2d b8 10 80       	push   $0x8010b82d
80104e9a:	e8 c7 b6 ff ff       	call   80100566 <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80104e9f:	90                   	nop
80104ea0:	8b 45 08             	mov    0x8(%ebp),%eax
80104ea3:	83 ec 08             	sub    $0x8,%esp
80104ea6:	6a 01                	push   $0x1
80104ea8:	50                   	push   %eax
80104ea9:	e8 8a ff ff ff       	call   80104e38 <xchg>
80104eae:	83 c4 10             	add    $0x10,%esp
80104eb1:	85 c0                	test   %eax,%eax
80104eb3:	75 eb                	jne    80104ea0 <acquire+0x2c>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104eb5:	8b 45 08             	mov    0x8(%ebp),%eax
80104eb8:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104ebf:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104ec2:	8b 45 08             	mov    0x8(%ebp),%eax
80104ec5:	83 c0 0c             	add    $0xc,%eax
80104ec8:	83 ec 08             	sub    $0x8,%esp
80104ecb:	50                   	push   %eax
80104ecc:	8d 45 08             	lea    0x8(%ebp),%eax
80104ecf:	50                   	push   %eax
80104ed0:	e8 58 00 00 00       	call   80104f2d <getcallerpcs>
80104ed5:	83 c4 10             	add    $0x10,%esp
}
80104ed8:	90                   	nop
80104ed9:	c9                   	leave  
80104eda:	c3                   	ret    

80104edb <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80104edb:	55                   	push   %ebp
80104edc:	89 e5                	mov    %esp,%ebp
80104ede:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
80104ee1:	83 ec 0c             	sub    $0xc,%esp
80104ee4:	ff 75 08             	pushl  0x8(%ebp)
80104ee7:	e8 bb 00 00 00       	call   80104fa7 <holding>
80104eec:	83 c4 10             	add    $0x10,%esp
80104eef:	85 c0                	test   %eax,%eax
80104ef1:	75 0d                	jne    80104f00 <release+0x25>
    panic("release");
80104ef3:	83 ec 0c             	sub    $0xc,%esp
80104ef6:	68 35 b8 10 80       	push   $0x8010b835
80104efb:	e8 66 b6 ff ff       	call   80100566 <panic>

  lk->pcs[0] = 0;
80104f00:	8b 45 08             	mov    0x8(%ebp),%eax
80104f03:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104f0a:	8b 45 08             	mov    0x8(%ebp),%eax
80104f0d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80104f14:	8b 45 08             	mov    0x8(%ebp),%eax
80104f17:	83 ec 08             	sub    $0x8,%esp
80104f1a:	6a 00                	push   $0x0
80104f1c:	50                   	push   %eax
80104f1d:	e8 16 ff ff ff       	call   80104e38 <xchg>
80104f22:	83 c4 10             	add    $0x10,%esp

  popcli();
80104f25:	e8 ec 00 00 00       	call   80105016 <popcli>
}
80104f2a:	90                   	nop
80104f2b:	c9                   	leave  
80104f2c:	c3                   	ret    

80104f2d <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104f2d:	55                   	push   %ebp
80104f2e:	89 e5                	mov    %esp,%ebp
80104f30:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80104f33:	8b 45 08             	mov    0x8(%ebp),%eax
80104f36:	83 e8 08             	sub    $0x8,%eax
80104f39:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80104f3c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80104f43:	eb 38                	jmp    80104f7d <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f45:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80104f49:	74 53                	je     80104f9e <getcallerpcs+0x71>
80104f4b:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80104f52:	76 4a                	jbe    80104f9e <getcallerpcs+0x71>
80104f54:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80104f58:	74 44                	je     80104f9e <getcallerpcs+0x71>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104f5a:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104f5d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104f64:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f67:	01 c2                	add    %eax,%edx
80104f69:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f6c:	8b 40 04             	mov    0x4(%eax),%eax
80104f6f:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80104f71:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f74:	8b 00                	mov    (%eax),%eax
80104f76:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104f79:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104f7d:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104f81:	7e c2                	jle    80104f45 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104f83:	eb 19                	jmp    80104f9e <getcallerpcs+0x71>
    pcs[i] = 0;
80104f85:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104f88:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104f8f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f92:	01 d0                	add    %edx,%eax
80104f94:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104f9a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104f9e:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104fa2:	7e e1                	jle    80104f85 <getcallerpcs+0x58>
    pcs[i] = 0;
}
80104fa4:	90                   	nop
80104fa5:	c9                   	leave  
80104fa6:	c3                   	ret    

80104fa7 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104fa7:	55                   	push   %ebp
80104fa8:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80104faa:	8b 45 08             	mov    0x8(%ebp),%eax
80104fad:	8b 00                	mov    (%eax),%eax
80104faf:	85 c0                	test   %eax,%eax
80104fb1:	74 17                	je     80104fca <holding+0x23>
80104fb3:	8b 45 08             	mov    0x8(%ebp),%eax
80104fb6:	8b 50 08             	mov    0x8(%eax),%edx
80104fb9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104fbf:	39 c2                	cmp    %eax,%edx
80104fc1:	75 07                	jne    80104fca <holding+0x23>
80104fc3:	b8 01 00 00 00       	mov    $0x1,%eax
80104fc8:	eb 05                	jmp    80104fcf <holding+0x28>
80104fca:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104fcf:	5d                   	pop    %ebp
80104fd0:	c3                   	ret    

80104fd1 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104fd1:	55                   	push   %ebp
80104fd2:	89 e5                	mov    %esp,%ebp
80104fd4:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80104fd7:	e8 3e fe ff ff       	call   80104e1a <readeflags>
80104fdc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80104fdf:	e8 46 fe ff ff       	call   80104e2a <cli>
  if(cpu->ncli++ == 0)
80104fe4:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104feb:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80104ff1:	8d 48 01             	lea    0x1(%eax),%ecx
80104ff4:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
80104ffa:	85 c0                	test   %eax,%eax
80104ffc:	75 15                	jne    80105013 <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
80104ffe:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105004:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105007:	81 e2 00 02 00 00    	and    $0x200,%edx
8010500d:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80105013:	90                   	nop
80105014:	c9                   	leave  
80105015:	c3                   	ret    

80105016 <popcli>:

void
popcli(void)
{
80105016:	55                   	push   %ebp
80105017:	89 e5                	mov    %esp,%ebp
80105019:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
8010501c:	e8 f9 fd ff ff       	call   80104e1a <readeflags>
80105021:	25 00 02 00 00       	and    $0x200,%eax
80105026:	85 c0                	test   %eax,%eax
80105028:	74 0d                	je     80105037 <popcli+0x21>
    panic("popcli - interruptible");
8010502a:	83 ec 0c             	sub    $0xc,%esp
8010502d:	68 3d b8 10 80       	push   $0x8010b83d
80105032:	e8 2f b5 ff ff       	call   80100566 <panic>
  if(--cpu->ncli < 0)
80105037:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010503d:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80105043:	83 ea 01             	sub    $0x1,%edx
80105046:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
8010504c:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105052:	85 c0                	test   %eax,%eax
80105054:	79 0d                	jns    80105063 <popcli+0x4d>
    panic("popcli");
80105056:	83 ec 0c             	sub    $0xc,%esp
80105059:	68 54 b8 10 80       	push   $0x8010b854
8010505e:	e8 03 b5 ff ff       	call   80100566 <panic>
  if(cpu->ncli == 0 && cpu->intena)
80105063:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105069:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010506f:	85 c0                	test   %eax,%eax
80105071:	75 15                	jne    80105088 <popcli+0x72>
80105073:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105079:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
8010507f:	85 c0                	test   %eax,%eax
80105081:	74 05                	je     80105088 <popcli+0x72>
    sti();
80105083:	e8 a9 fd ff ff       	call   80104e31 <sti>
}
80105088:	90                   	nop
80105089:	c9                   	leave  
8010508a:	c3                   	ret    

8010508b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
8010508b:	55                   	push   %ebp
8010508c:	89 e5                	mov    %esp,%ebp
8010508e:	57                   	push   %edi
8010508f:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80105090:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105093:	8b 55 10             	mov    0x10(%ebp),%edx
80105096:	8b 45 0c             	mov    0xc(%ebp),%eax
80105099:	89 cb                	mov    %ecx,%ebx
8010509b:	89 df                	mov    %ebx,%edi
8010509d:	89 d1                	mov    %edx,%ecx
8010509f:	fc                   	cld    
801050a0:	f3 aa                	rep stos %al,%es:(%edi)
801050a2:	89 ca                	mov    %ecx,%edx
801050a4:	89 fb                	mov    %edi,%ebx
801050a6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801050a9:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
801050ac:	90                   	nop
801050ad:	5b                   	pop    %ebx
801050ae:	5f                   	pop    %edi
801050af:	5d                   	pop    %ebp
801050b0:	c3                   	ret    

801050b1 <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
801050b1:	55                   	push   %ebp
801050b2:	89 e5                	mov    %esp,%ebp
801050b4:	57                   	push   %edi
801050b5:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
801050b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801050b9:	8b 55 10             	mov    0x10(%ebp),%edx
801050bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801050bf:	89 cb                	mov    %ecx,%ebx
801050c1:	89 df                	mov    %ebx,%edi
801050c3:	89 d1                	mov    %edx,%ecx
801050c5:	fc                   	cld    
801050c6:	f3 ab                	rep stos %eax,%es:(%edi)
801050c8:	89 ca                	mov    %ecx,%edx
801050ca:	89 fb                	mov    %edi,%ebx
801050cc:	89 5d 08             	mov    %ebx,0x8(%ebp)
801050cf:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
801050d2:	90                   	nop
801050d3:	5b                   	pop    %ebx
801050d4:	5f                   	pop    %edi
801050d5:	5d                   	pop    %ebp
801050d6:	c3                   	ret    

801050d7 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801050d7:	55                   	push   %ebp
801050d8:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
801050da:	8b 45 08             	mov    0x8(%ebp),%eax
801050dd:	83 e0 03             	and    $0x3,%eax
801050e0:	85 c0                	test   %eax,%eax
801050e2:	75 43                	jne    80105127 <memset+0x50>
801050e4:	8b 45 10             	mov    0x10(%ebp),%eax
801050e7:	83 e0 03             	and    $0x3,%eax
801050ea:	85 c0                	test   %eax,%eax
801050ec:	75 39                	jne    80105127 <memset+0x50>
    c &= 0xFF;
801050ee:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801050f5:	8b 45 10             	mov    0x10(%ebp),%eax
801050f8:	c1 e8 02             	shr    $0x2,%eax
801050fb:	89 c1                	mov    %eax,%ecx
801050fd:	8b 45 0c             	mov    0xc(%ebp),%eax
80105100:	c1 e0 18             	shl    $0x18,%eax
80105103:	89 c2                	mov    %eax,%edx
80105105:	8b 45 0c             	mov    0xc(%ebp),%eax
80105108:	c1 e0 10             	shl    $0x10,%eax
8010510b:	09 c2                	or     %eax,%edx
8010510d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105110:	c1 e0 08             	shl    $0x8,%eax
80105113:	09 d0                	or     %edx,%eax
80105115:	0b 45 0c             	or     0xc(%ebp),%eax
80105118:	51                   	push   %ecx
80105119:	50                   	push   %eax
8010511a:	ff 75 08             	pushl  0x8(%ebp)
8010511d:	e8 8f ff ff ff       	call   801050b1 <stosl>
80105122:	83 c4 0c             	add    $0xc,%esp
80105125:	eb 12                	jmp    80105139 <memset+0x62>
  } else
    stosb(dst, c, n);
80105127:	8b 45 10             	mov    0x10(%ebp),%eax
8010512a:	50                   	push   %eax
8010512b:	ff 75 0c             	pushl  0xc(%ebp)
8010512e:	ff 75 08             	pushl  0x8(%ebp)
80105131:	e8 55 ff ff ff       	call   8010508b <stosb>
80105136:	83 c4 0c             	add    $0xc,%esp
  return dst;
80105139:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010513c:	c9                   	leave  
8010513d:	c3                   	ret    

8010513e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
8010513e:	55                   	push   %ebp
8010513f:	89 e5                	mov    %esp,%ebp
80105141:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
80105144:	8b 45 08             	mov    0x8(%ebp),%eax
80105147:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
8010514a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010514d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
80105150:	eb 30                	jmp    80105182 <memcmp+0x44>
    if(*s1 != *s2)
80105152:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105155:	0f b6 10             	movzbl (%eax),%edx
80105158:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010515b:	0f b6 00             	movzbl (%eax),%eax
8010515e:	38 c2                	cmp    %al,%dl
80105160:	74 18                	je     8010517a <memcmp+0x3c>
      return *s1 - *s2;
80105162:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105165:	0f b6 00             	movzbl (%eax),%eax
80105168:	0f b6 d0             	movzbl %al,%edx
8010516b:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010516e:	0f b6 00             	movzbl (%eax),%eax
80105171:	0f b6 c0             	movzbl %al,%eax
80105174:	29 c2                	sub    %eax,%edx
80105176:	89 d0                	mov    %edx,%eax
80105178:	eb 1a                	jmp    80105194 <memcmp+0x56>
    s1++, s2++;
8010517a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010517e:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105182:	8b 45 10             	mov    0x10(%ebp),%eax
80105185:	8d 50 ff             	lea    -0x1(%eax),%edx
80105188:	89 55 10             	mov    %edx,0x10(%ebp)
8010518b:	85 c0                	test   %eax,%eax
8010518d:	75 c3                	jne    80105152 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010518f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105194:	c9                   	leave  
80105195:	c3                   	ret    

80105196 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105196:	55                   	push   %ebp
80105197:	89 e5                	mov    %esp,%ebp
80105199:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
8010519c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010519f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
801051a2:	8b 45 08             	mov    0x8(%ebp),%eax
801051a5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
801051a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051ab:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801051ae:	73 54                	jae    80105204 <memmove+0x6e>
801051b0:	8b 55 fc             	mov    -0x4(%ebp),%edx
801051b3:	8b 45 10             	mov    0x10(%ebp),%eax
801051b6:	01 d0                	add    %edx,%eax
801051b8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801051bb:	76 47                	jbe    80105204 <memmove+0x6e>
    s += n;
801051bd:	8b 45 10             	mov    0x10(%ebp),%eax
801051c0:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
801051c3:	8b 45 10             	mov    0x10(%ebp),%eax
801051c6:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
801051c9:	eb 13                	jmp    801051de <memmove+0x48>
      *--d = *--s;
801051cb:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
801051cf:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
801051d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051d6:	0f b6 10             	movzbl (%eax),%edx
801051d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051dc:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801051de:	8b 45 10             	mov    0x10(%ebp),%eax
801051e1:	8d 50 ff             	lea    -0x1(%eax),%edx
801051e4:	89 55 10             	mov    %edx,0x10(%ebp)
801051e7:	85 c0                	test   %eax,%eax
801051e9:	75 e0                	jne    801051cb <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801051eb:	eb 24                	jmp    80105211 <memmove+0x7b>
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;
801051ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051f0:	8d 50 01             	lea    0x1(%eax),%edx
801051f3:	89 55 f8             	mov    %edx,-0x8(%ebp)
801051f6:	8b 55 fc             	mov    -0x4(%ebp),%edx
801051f9:	8d 4a 01             	lea    0x1(%edx),%ecx
801051fc:	89 4d fc             	mov    %ecx,-0x4(%ebp)
801051ff:	0f b6 12             	movzbl (%edx),%edx
80105202:	88 10                	mov    %dl,(%eax)
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105204:	8b 45 10             	mov    0x10(%ebp),%eax
80105207:	8d 50 ff             	lea    -0x1(%eax),%edx
8010520a:	89 55 10             	mov    %edx,0x10(%ebp)
8010520d:	85 c0                	test   %eax,%eax
8010520f:	75 dc                	jne    801051ed <memmove+0x57>
      *d++ = *s++;

  return dst;
80105211:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105214:	c9                   	leave  
80105215:	c3                   	ret    

80105216 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105216:	55                   	push   %ebp
80105217:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
80105219:	ff 75 10             	pushl  0x10(%ebp)
8010521c:	ff 75 0c             	pushl  0xc(%ebp)
8010521f:	ff 75 08             	pushl  0x8(%ebp)
80105222:	e8 6f ff ff ff       	call   80105196 <memmove>
80105227:	83 c4 0c             	add    $0xc,%esp
}
8010522a:	c9                   	leave  
8010522b:	c3                   	ret    

8010522c <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
8010522c:	55                   	push   %ebp
8010522d:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
8010522f:	eb 0c                	jmp    8010523d <strncmp+0x11>
    n--, p++, q++;
80105231:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105235:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105239:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
8010523d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105241:	74 1a                	je     8010525d <strncmp+0x31>
80105243:	8b 45 08             	mov    0x8(%ebp),%eax
80105246:	0f b6 00             	movzbl (%eax),%eax
80105249:	84 c0                	test   %al,%al
8010524b:	74 10                	je     8010525d <strncmp+0x31>
8010524d:	8b 45 08             	mov    0x8(%ebp),%eax
80105250:	0f b6 10             	movzbl (%eax),%edx
80105253:	8b 45 0c             	mov    0xc(%ebp),%eax
80105256:	0f b6 00             	movzbl (%eax),%eax
80105259:	38 c2                	cmp    %al,%dl
8010525b:	74 d4                	je     80105231 <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
8010525d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105261:	75 07                	jne    8010526a <strncmp+0x3e>
    return 0;
80105263:	b8 00 00 00 00       	mov    $0x0,%eax
80105268:	eb 16                	jmp    80105280 <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
8010526a:	8b 45 08             	mov    0x8(%ebp),%eax
8010526d:	0f b6 00             	movzbl (%eax),%eax
80105270:	0f b6 d0             	movzbl %al,%edx
80105273:	8b 45 0c             	mov    0xc(%ebp),%eax
80105276:	0f b6 00             	movzbl (%eax),%eax
80105279:	0f b6 c0             	movzbl %al,%eax
8010527c:	29 c2                	sub    %eax,%edx
8010527e:	89 d0                	mov    %edx,%eax
}
80105280:	5d                   	pop    %ebp
80105281:	c3                   	ret    

80105282 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105282:	55                   	push   %ebp
80105283:	89 e5                	mov    %esp,%ebp
80105285:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105288:	8b 45 08             	mov    0x8(%ebp),%eax
8010528b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
8010528e:	90                   	nop
8010528f:	8b 45 10             	mov    0x10(%ebp),%eax
80105292:	8d 50 ff             	lea    -0x1(%eax),%edx
80105295:	89 55 10             	mov    %edx,0x10(%ebp)
80105298:	85 c0                	test   %eax,%eax
8010529a:	7e 2c                	jle    801052c8 <strncpy+0x46>
8010529c:	8b 45 08             	mov    0x8(%ebp),%eax
8010529f:	8d 50 01             	lea    0x1(%eax),%edx
801052a2:	89 55 08             	mov    %edx,0x8(%ebp)
801052a5:	8b 55 0c             	mov    0xc(%ebp),%edx
801052a8:	8d 4a 01             	lea    0x1(%edx),%ecx
801052ab:	89 4d 0c             	mov    %ecx,0xc(%ebp)
801052ae:	0f b6 12             	movzbl (%edx),%edx
801052b1:	88 10                	mov    %dl,(%eax)
801052b3:	0f b6 00             	movzbl (%eax),%eax
801052b6:	84 c0                	test   %al,%al
801052b8:	75 d5                	jne    8010528f <strncpy+0xd>
    ;
  while(n-- > 0)
801052ba:	eb 0c                	jmp    801052c8 <strncpy+0x46>
    *s++ = 0;
801052bc:	8b 45 08             	mov    0x8(%ebp),%eax
801052bf:	8d 50 01             	lea    0x1(%eax),%edx
801052c2:	89 55 08             	mov    %edx,0x8(%ebp)
801052c5:	c6 00 00             	movb   $0x0,(%eax)
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801052c8:	8b 45 10             	mov    0x10(%ebp),%eax
801052cb:	8d 50 ff             	lea    -0x1(%eax),%edx
801052ce:	89 55 10             	mov    %edx,0x10(%ebp)
801052d1:	85 c0                	test   %eax,%eax
801052d3:	7f e7                	jg     801052bc <strncpy+0x3a>
    *s++ = 0;
  return os;
801052d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801052d8:	c9                   	leave  
801052d9:	c3                   	ret    

801052da <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801052da:	55                   	push   %ebp
801052db:	89 e5                	mov    %esp,%ebp
801052dd:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
801052e0:	8b 45 08             	mov    0x8(%ebp),%eax
801052e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
801052e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801052ea:	7f 05                	jg     801052f1 <safestrcpy+0x17>
    return os;
801052ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052ef:	eb 31                	jmp    80105322 <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
801052f1:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801052f5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801052f9:	7e 1e                	jle    80105319 <safestrcpy+0x3f>
801052fb:	8b 45 08             	mov    0x8(%ebp),%eax
801052fe:	8d 50 01             	lea    0x1(%eax),%edx
80105301:	89 55 08             	mov    %edx,0x8(%ebp)
80105304:	8b 55 0c             	mov    0xc(%ebp),%edx
80105307:	8d 4a 01             	lea    0x1(%edx),%ecx
8010530a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
8010530d:	0f b6 12             	movzbl (%edx),%edx
80105310:	88 10                	mov    %dl,(%eax)
80105312:	0f b6 00             	movzbl (%eax),%eax
80105315:	84 c0                	test   %al,%al
80105317:	75 d8                	jne    801052f1 <safestrcpy+0x17>
    ;
  *s = 0;
80105319:	8b 45 08             	mov    0x8(%ebp),%eax
8010531c:	c6 00 00             	movb   $0x0,(%eax)
  return os;
8010531f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105322:	c9                   	leave  
80105323:	c3                   	ret    

80105324 <strlen>:

int
strlen(const char *s)
{
80105324:	55                   	push   %ebp
80105325:	89 e5                	mov    %esp,%ebp
80105327:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
8010532a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105331:	eb 04                	jmp    80105337 <strlen+0x13>
80105333:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105337:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010533a:	8b 45 08             	mov    0x8(%ebp),%eax
8010533d:	01 d0                	add    %edx,%eax
8010533f:	0f b6 00             	movzbl (%eax),%eax
80105342:	84 c0                	test   %al,%al
80105344:	75 ed                	jne    80105333 <strlen+0xf>
    ;
  return n;
80105346:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105349:	c9                   	leave  
8010534a:	c3                   	ret    

8010534b <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010534b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010534f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80105353:	55                   	push   %ebp
  pushl %ebx
80105354:	53                   	push   %ebx
  pushl %esi
80105355:	56                   	push   %esi
  pushl %edi
80105356:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105357:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105359:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010535b:	5f                   	pop    %edi
  popl %esi
8010535c:	5e                   	pop    %esi
  popl %ebx
8010535d:	5b                   	pop    %ebx
  popl %ebp
8010535e:	5d                   	pop    %ebp
  ret
8010535f:	c3                   	ret    

80105360 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105360:	55                   	push   %ebp
80105361:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80105363:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105369:	8b 00                	mov    (%eax),%eax
8010536b:	3b 45 08             	cmp    0x8(%ebp),%eax
8010536e:	76 12                	jbe    80105382 <fetchint+0x22>
80105370:	8b 45 08             	mov    0x8(%ebp),%eax
80105373:	8d 50 04             	lea    0x4(%eax),%edx
80105376:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010537c:	8b 00                	mov    (%eax),%eax
8010537e:	39 c2                	cmp    %eax,%edx
80105380:	76 07                	jbe    80105389 <fetchint+0x29>
    return -1;
80105382:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105387:	eb 0f                	jmp    80105398 <fetchint+0x38>
  *ip = *(int*)(addr);
80105389:	8b 45 08             	mov    0x8(%ebp),%eax
8010538c:	8b 10                	mov    (%eax),%edx
8010538e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105391:	89 10                	mov    %edx,(%eax)
  return 0;
80105393:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105398:	5d                   	pop    %ebp
80105399:	c3                   	ret    

8010539a <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
8010539a:	55                   	push   %ebp
8010539b:	89 e5                	mov    %esp,%ebp
8010539d:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
801053a0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053a6:	8b 00                	mov    (%eax),%eax
801053a8:	3b 45 08             	cmp    0x8(%ebp),%eax
801053ab:	77 07                	ja     801053b4 <fetchstr+0x1a>
    return -1;
801053ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053b2:	eb 46                	jmp    801053fa <fetchstr+0x60>
  *pp = (char*)addr;
801053b4:	8b 55 08             	mov    0x8(%ebp),%edx
801053b7:	8b 45 0c             	mov    0xc(%ebp),%eax
801053ba:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
801053bc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053c2:	8b 00                	mov    (%eax),%eax
801053c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
801053c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801053ca:	8b 00                	mov    (%eax),%eax
801053cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
801053cf:	eb 1c                	jmp    801053ed <fetchstr+0x53>
    if(*s == 0)
801053d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053d4:	0f b6 00             	movzbl (%eax),%eax
801053d7:	84 c0                	test   %al,%al
801053d9:	75 0e                	jne    801053e9 <fetchstr+0x4f>
      return s - *pp;
801053db:	8b 55 fc             	mov    -0x4(%ebp),%edx
801053de:	8b 45 0c             	mov    0xc(%ebp),%eax
801053e1:	8b 00                	mov    (%eax),%eax
801053e3:	29 c2                	sub    %eax,%edx
801053e5:	89 d0                	mov    %edx,%eax
801053e7:	eb 11                	jmp    801053fa <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801053e9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801053ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053f0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801053f3:	72 dc                	jb     801053d1 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
801053f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053fa:	c9                   	leave  
801053fb:	c3                   	ret    

801053fc <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801053fc:	55                   	push   %ebp
801053fd:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801053ff:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105405:	8b 40 18             	mov    0x18(%eax),%eax
80105408:	8b 40 44             	mov    0x44(%eax),%eax
8010540b:	8b 55 08             	mov    0x8(%ebp),%edx
8010540e:	c1 e2 02             	shl    $0x2,%edx
80105411:	01 d0                	add    %edx,%eax
80105413:	83 c0 04             	add    $0x4,%eax
80105416:	ff 75 0c             	pushl  0xc(%ebp)
80105419:	50                   	push   %eax
8010541a:	e8 41 ff ff ff       	call   80105360 <fetchint>
8010541f:	83 c4 08             	add    $0x8,%esp
}
80105422:	c9                   	leave  
80105423:	c3                   	ret    

80105424 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105424:	55                   	push   %ebp
80105425:	89 e5                	mov    %esp,%ebp
80105427:	83 ec 10             	sub    $0x10,%esp
  int i;
  
  if(argint(n, &i) < 0)
8010542a:	8d 45 fc             	lea    -0x4(%ebp),%eax
8010542d:	50                   	push   %eax
8010542e:	ff 75 08             	pushl  0x8(%ebp)
80105431:	e8 c6 ff ff ff       	call   801053fc <argint>
80105436:	83 c4 08             	add    $0x8,%esp
80105439:	85 c0                	test   %eax,%eax
8010543b:	79 07                	jns    80105444 <argptr+0x20>
    return -1;
8010543d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105442:	eb 3b                	jmp    8010547f <argptr+0x5b>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80105444:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010544a:	8b 00                	mov    (%eax),%eax
8010544c:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010544f:	39 d0                	cmp    %edx,%eax
80105451:	76 16                	jbe    80105469 <argptr+0x45>
80105453:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105456:	89 c2                	mov    %eax,%edx
80105458:	8b 45 10             	mov    0x10(%ebp),%eax
8010545b:	01 c2                	add    %eax,%edx
8010545d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105463:	8b 00                	mov    (%eax),%eax
80105465:	39 c2                	cmp    %eax,%edx
80105467:	76 07                	jbe    80105470 <argptr+0x4c>
    return -1;
80105469:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010546e:	eb 0f                	jmp    8010547f <argptr+0x5b>
  *pp = (char*)i;
80105470:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105473:	89 c2                	mov    %eax,%edx
80105475:	8b 45 0c             	mov    0xc(%ebp),%eax
80105478:	89 10                	mov    %edx,(%eax)
  return 0;
8010547a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010547f:	c9                   	leave  
80105480:	c3                   	ret    

80105481 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105481:	55                   	push   %ebp
80105482:	89 e5                	mov    %esp,%ebp
80105484:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105487:	8d 45 fc             	lea    -0x4(%ebp),%eax
8010548a:	50                   	push   %eax
8010548b:	ff 75 08             	pushl  0x8(%ebp)
8010548e:	e8 69 ff ff ff       	call   801053fc <argint>
80105493:	83 c4 08             	add    $0x8,%esp
80105496:	85 c0                	test   %eax,%eax
80105498:	79 07                	jns    801054a1 <argstr+0x20>
    return -1;
8010549a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010549f:	eb 0f                	jmp    801054b0 <argstr+0x2f>
  return fetchstr(addr, pp);
801054a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
801054a4:	ff 75 0c             	pushl  0xc(%ebp)
801054a7:	50                   	push   %eax
801054a8:	e8 ed fe ff ff       	call   8010539a <fetchstr>
801054ad:	83 c4 08             	add    $0x8,%esp
}
801054b0:	c9                   	leave  
801054b1:	c3                   	ret    

801054b2 <syscall>:
    
};

void
syscall(void)
{
801054b2:	55                   	push   %ebp
801054b3:	89 e5                	mov    %esp,%ebp
801054b5:	53                   	push   %ebx
801054b6:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
801054b9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054bf:	8b 40 18             	mov    0x18(%eax),%eax
801054c2:	8b 40 1c             	mov    0x1c(%eax),%eax
801054c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801054c8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801054cc:	7e 30                	jle    801054fe <syscall+0x4c>
801054ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054d1:	83 f8 1c             	cmp    $0x1c,%eax
801054d4:	77 28                	ja     801054fe <syscall+0x4c>
801054d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054d9:	8b 04 85 40 e0 10 80 	mov    -0x7fef1fc0(,%eax,4),%eax
801054e0:	85 c0                	test   %eax,%eax
801054e2:	74 1a                	je     801054fe <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
801054e4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054ea:	8b 58 18             	mov    0x18(%eax),%ebx
801054ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054f0:	8b 04 85 40 e0 10 80 	mov    -0x7fef1fc0(,%eax,4),%eax
801054f7:	ff d0                	call   *%eax
801054f9:	89 43 1c             	mov    %eax,0x1c(%ebx)
801054fc:	eb 34                	jmp    80105532 <syscall+0x80>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
801054fe:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105504:	8d 50 6c             	lea    0x6c(%eax),%edx
80105507:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
8010550d:	8b 40 10             	mov    0x10(%eax),%eax
80105510:	ff 75 f4             	pushl  -0xc(%ebp)
80105513:	52                   	push   %edx
80105514:	50                   	push   %eax
80105515:	68 5b b8 10 80       	push   $0x8010b85b
8010551a:	e8 a7 ae ff ff       	call   801003c6 <cprintf>
8010551f:	83 c4 10             	add    $0x10,%esp
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
80105522:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105528:	8b 40 18             	mov    0x18(%eax),%eax
8010552b:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80105532:	90                   	nop
80105533:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105536:	c9                   	leave  
80105537:	c3                   	ret    

80105538 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80105538:	55                   	push   %ebp
80105539:	89 e5                	mov    %esp,%ebp
8010553b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010553e:	83 ec 08             	sub    $0x8,%esp
80105541:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105544:	50                   	push   %eax
80105545:	ff 75 08             	pushl  0x8(%ebp)
80105548:	e8 af fe ff ff       	call   801053fc <argint>
8010554d:	83 c4 10             	add    $0x10,%esp
80105550:	85 c0                	test   %eax,%eax
80105552:	79 07                	jns    8010555b <argfd+0x23>
    return -1;
80105554:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105559:	eb 50                	jmp    801055ab <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
8010555b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010555e:	85 c0                	test   %eax,%eax
80105560:	78 21                	js     80105583 <argfd+0x4b>
80105562:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105565:	83 f8 0f             	cmp    $0xf,%eax
80105568:	7f 19                	jg     80105583 <argfd+0x4b>
8010556a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105570:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105573:	83 c2 08             	add    $0x8,%edx
80105576:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010557a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010557d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105581:	75 07                	jne    8010558a <argfd+0x52>
    return -1;
80105583:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105588:	eb 21                	jmp    801055ab <argfd+0x73>
  if(pfd)
8010558a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010558e:	74 08                	je     80105598 <argfd+0x60>
    *pfd = fd;
80105590:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105593:	8b 45 0c             	mov    0xc(%ebp),%eax
80105596:	89 10                	mov    %edx,(%eax)
  if(pf)
80105598:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010559c:	74 08                	je     801055a6 <argfd+0x6e>
    *pf = f;
8010559e:	8b 45 10             	mov    0x10(%ebp),%eax
801055a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801055a4:	89 10                	mov    %edx,(%eax)
  return 0;
801055a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
801055ab:	c9                   	leave  
801055ac:	c3                   	ret    

801055ad <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
801055ad:	55                   	push   %ebp
801055ae:	89 e5                	mov    %esp,%ebp
801055b0:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801055b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801055ba:	eb 30                	jmp    801055ec <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
801055bc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
801055c5:	83 c2 08             	add    $0x8,%edx
801055c8:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801055cc:	85 c0                	test   %eax,%eax
801055ce:	75 18                	jne    801055e8 <fdalloc+0x3b>
      proc->ofile[fd] = f;
801055d0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055d6:	8b 55 fc             	mov    -0x4(%ebp),%edx
801055d9:	8d 4a 08             	lea    0x8(%edx),%ecx
801055dc:	8b 55 08             	mov    0x8(%ebp),%edx
801055df:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
801055e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055e6:	eb 0f                	jmp    801055f7 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801055e8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801055ec:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
801055f0:	7e ca                	jle    801055bc <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
801055f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055f7:	c9                   	leave  
801055f8:	c3                   	ret    

801055f9 <sys_dup>:

int
sys_dup(void)
{
801055f9:	55                   	push   %ebp
801055fa:	89 e5                	mov    %esp,%ebp
801055fc:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
801055ff:	83 ec 04             	sub    $0x4,%esp
80105602:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105605:	50                   	push   %eax
80105606:	6a 00                	push   $0x0
80105608:	6a 00                	push   $0x0
8010560a:	e8 29 ff ff ff       	call   80105538 <argfd>
8010560f:	83 c4 10             	add    $0x10,%esp
80105612:	85 c0                	test   %eax,%eax
80105614:	79 07                	jns    8010561d <sys_dup+0x24>
    return -1;
80105616:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010561b:	eb 31                	jmp    8010564e <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
8010561d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105620:	83 ec 0c             	sub    $0xc,%esp
80105623:	50                   	push   %eax
80105624:	e8 84 ff ff ff       	call   801055ad <fdalloc>
80105629:	83 c4 10             	add    $0x10,%esp
8010562c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010562f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105633:	79 07                	jns    8010563c <sys_dup+0x43>
    return -1;
80105635:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010563a:	eb 12                	jmp    8010564e <sys_dup+0x55>
  filedup(f);
8010563c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010563f:	83 ec 0c             	sub    $0xc,%esp
80105642:	50                   	push   %eax
80105643:	e8 89 b9 ff ff       	call   80100fd1 <filedup>
80105648:	83 c4 10             	add    $0x10,%esp
  return fd;
8010564b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010564e:	c9                   	leave  
8010564f:	c3                   	ret    

80105650 <sys_read>:

int
sys_read(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105656:	83 ec 04             	sub    $0x4,%esp
80105659:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010565c:	50                   	push   %eax
8010565d:	6a 00                	push   $0x0
8010565f:	6a 00                	push   $0x0
80105661:	e8 d2 fe ff ff       	call   80105538 <argfd>
80105666:	83 c4 10             	add    $0x10,%esp
80105669:	85 c0                	test   %eax,%eax
8010566b:	78 2e                	js     8010569b <sys_read+0x4b>
8010566d:	83 ec 08             	sub    $0x8,%esp
80105670:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105673:	50                   	push   %eax
80105674:	6a 02                	push   $0x2
80105676:	e8 81 fd ff ff       	call   801053fc <argint>
8010567b:	83 c4 10             	add    $0x10,%esp
8010567e:	85 c0                	test   %eax,%eax
80105680:	78 19                	js     8010569b <sys_read+0x4b>
80105682:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105685:	83 ec 04             	sub    $0x4,%esp
80105688:	50                   	push   %eax
80105689:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010568c:	50                   	push   %eax
8010568d:	6a 01                	push   $0x1
8010568f:	e8 90 fd ff ff       	call   80105424 <argptr>
80105694:	83 c4 10             	add    $0x10,%esp
80105697:	85 c0                	test   %eax,%eax
80105699:	79 07                	jns    801056a2 <sys_read+0x52>
    return -1;
8010569b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056a0:	eb 17                	jmp    801056b9 <sys_read+0x69>
  return fileread(f, p, n);
801056a2:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801056a5:	8b 55 ec             	mov    -0x14(%ebp),%edx
801056a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056ab:	83 ec 04             	sub    $0x4,%esp
801056ae:	51                   	push   %ecx
801056af:	52                   	push   %edx
801056b0:	50                   	push   %eax
801056b1:	e8 ab ba ff ff       	call   80101161 <fileread>
801056b6:	83 c4 10             	add    $0x10,%esp
}
801056b9:	c9                   	leave  
801056ba:	c3                   	ret    

801056bb <sys_write>:

int
sys_write(void)
{
801056bb:	55                   	push   %ebp
801056bc:	89 e5                	mov    %esp,%ebp
801056be:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801056c1:	83 ec 04             	sub    $0x4,%esp
801056c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056c7:	50                   	push   %eax
801056c8:	6a 00                	push   $0x0
801056ca:	6a 00                	push   $0x0
801056cc:	e8 67 fe ff ff       	call   80105538 <argfd>
801056d1:	83 c4 10             	add    $0x10,%esp
801056d4:	85 c0                	test   %eax,%eax
801056d6:	78 2e                	js     80105706 <sys_write+0x4b>
801056d8:	83 ec 08             	sub    $0x8,%esp
801056db:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056de:	50                   	push   %eax
801056df:	6a 02                	push   $0x2
801056e1:	e8 16 fd ff ff       	call   801053fc <argint>
801056e6:	83 c4 10             	add    $0x10,%esp
801056e9:	85 c0                	test   %eax,%eax
801056eb:	78 19                	js     80105706 <sys_write+0x4b>
801056ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
801056f0:	83 ec 04             	sub    $0x4,%esp
801056f3:	50                   	push   %eax
801056f4:	8d 45 ec             	lea    -0x14(%ebp),%eax
801056f7:	50                   	push   %eax
801056f8:	6a 01                	push   $0x1
801056fa:	e8 25 fd ff ff       	call   80105424 <argptr>
801056ff:	83 c4 10             	add    $0x10,%esp
80105702:	85 c0                	test   %eax,%eax
80105704:	79 07                	jns    8010570d <sys_write+0x52>
    return -1;
80105706:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010570b:	eb 17                	jmp    80105724 <sys_write+0x69>
  return filewrite(f, p, n);
8010570d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105710:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105713:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105716:	83 ec 04             	sub    $0x4,%esp
80105719:	51                   	push   %ecx
8010571a:	52                   	push   %edx
8010571b:	50                   	push   %eax
8010571c:	e8 f8 ba ff ff       	call   80101219 <filewrite>
80105721:	83 c4 10             	add    $0x10,%esp
}
80105724:	c9                   	leave  
80105725:	c3                   	ret    

80105726 <sys_close>:

int
sys_close(void)
{
80105726:	55                   	push   %ebp
80105727:	89 e5                	mov    %esp,%ebp
80105729:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
8010572c:	83 ec 04             	sub    $0x4,%esp
8010572f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105732:	50                   	push   %eax
80105733:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105736:	50                   	push   %eax
80105737:	6a 00                	push   $0x0
80105739:	e8 fa fd ff ff       	call   80105538 <argfd>
8010573e:	83 c4 10             	add    $0x10,%esp
80105741:	85 c0                	test   %eax,%eax
80105743:	79 07                	jns    8010574c <sys_close+0x26>
    return -1;
80105745:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010574a:	eb 28                	jmp    80105774 <sys_close+0x4e>
  proc->ofile[fd] = 0;
8010574c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105752:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105755:	83 c2 08             	add    $0x8,%edx
80105758:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010575f:	00 
  fileclose(f);
80105760:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105763:	83 ec 0c             	sub    $0xc,%esp
80105766:	50                   	push   %eax
80105767:	e8 b6 b8 ff ff       	call   80101022 <fileclose>
8010576c:	83 c4 10             	add    $0x10,%esp
  return 0;
8010576f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105774:	c9                   	leave  
80105775:	c3                   	ret    

80105776 <sys_fstat>:

int
sys_fstat(void)
{
80105776:	55                   	push   %ebp
80105777:	89 e5                	mov    %esp,%ebp
80105779:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
8010577c:	83 ec 04             	sub    $0x4,%esp
8010577f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105782:	50                   	push   %eax
80105783:	6a 00                	push   $0x0
80105785:	6a 00                	push   $0x0
80105787:	e8 ac fd ff ff       	call   80105538 <argfd>
8010578c:	83 c4 10             	add    $0x10,%esp
8010578f:	85 c0                	test   %eax,%eax
80105791:	78 17                	js     801057aa <sys_fstat+0x34>
80105793:	83 ec 04             	sub    $0x4,%esp
80105796:	6a 14                	push   $0x14
80105798:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010579b:	50                   	push   %eax
8010579c:	6a 01                	push   $0x1
8010579e:	e8 81 fc ff ff       	call   80105424 <argptr>
801057a3:	83 c4 10             	add    $0x10,%esp
801057a6:	85 c0                	test   %eax,%eax
801057a8:	79 07                	jns    801057b1 <sys_fstat+0x3b>
    return -1;
801057aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057af:	eb 13                	jmp    801057c4 <sys_fstat+0x4e>
  return filestat(f, st);
801057b1:	8b 55 f0             	mov    -0x10(%ebp),%edx
801057b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057b7:	83 ec 08             	sub    $0x8,%esp
801057ba:	52                   	push   %edx
801057bb:	50                   	push   %eax
801057bc:	e8 49 b9 ff ff       	call   8010110a <filestat>
801057c1:	83 c4 10             	add    $0x10,%esp
}
801057c4:	c9                   	leave  
801057c5:	c3                   	ret    

801057c6 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
801057c6:	55                   	push   %ebp
801057c7:	89 e5                	mov    %esp,%ebp
801057c9:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801057cc:	83 ec 08             	sub    $0x8,%esp
801057cf:	8d 45 d8             	lea    -0x28(%ebp),%eax
801057d2:	50                   	push   %eax
801057d3:	6a 00                	push   $0x0
801057d5:	e8 a7 fc ff ff       	call   80105481 <argstr>
801057da:	83 c4 10             	add    $0x10,%esp
801057dd:	85 c0                	test   %eax,%eax
801057df:	78 15                	js     801057f6 <sys_link+0x30>
801057e1:	83 ec 08             	sub    $0x8,%esp
801057e4:	8d 45 dc             	lea    -0x24(%ebp),%eax
801057e7:	50                   	push   %eax
801057e8:	6a 01                	push   $0x1
801057ea:	e8 92 fc ff ff       	call   80105481 <argstr>
801057ef:	83 c4 10             	add    $0x10,%esp
801057f2:	85 c0                	test   %eax,%eax
801057f4:	79 0a                	jns    80105800 <sys_link+0x3a>
    return -1;
801057f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057fb:	e9 63 01 00 00       	jmp    80105963 <sys_link+0x19d>
  if((ip = namei(old)) == 0)
80105800:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105803:	83 ec 0c             	sub    $0xc,%esp
80105806:	50                   	push   %eax
80105807:	e8 f2 cd ff ff       	call   801025fe <namei>
8010580c:	83 c4 10             	add    $0x10,%esp
8010580f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105812:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105816:	75 0a                	jne    80105822 <sys_link+0x5c>
    return -1;
80105818:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010581d:	e9 41 01 00 00       	jmp    80105963 <sys_link+0x19d>

  begin_trans();
80105822:	e8 f3 dc ff ff       	call   8010351a <begin_trans>

  ilock(ip);
80105827:	83 ec 0c             	sub    $0xc,%esp
8010582a:	ff 75 f4             	pushl  -0xc(%ebp)
8010582d:	e8 c5 c0 ff ff       	call   801018f7 <ilock>
80105832:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
80105835:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105838:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010583c:	66 83 f8 01          	cmp    $0x1,%ax
80105840:	75 1d                	jne    8010585f <sys_link+0x99>
    iunlockput(ip);
80105842:	83 ec 0c             	sub    $0xc,%esp
80105845:	ff 75 f4             	pushl  -0xc(%ebp)
80105848:	e8 64 c3 ff ff       	call   80101bb1 <iunlockput>
8010584d:	83 c4 10             	add    $0x10,%esp
    commit_trans();
80105850:	e8 18 dd ff ff       	call   8010356d <commit_trans>
    return -1;
80105855:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010585a:	e9 04 01 00 00       	jmp    80105963 <sys_link+0x19d>
  }

  ip->nlink++;
8010585f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105862:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105866:	83 c0 01             	add    $0x1,%eax
80105869:	89 c2                	mov    %eax,%edx
8010586b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010586e:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105872:	83 ec 0c             	sub    $0xc,%esp
80105875:	ff 75 f4             	pushl  -0xc(%ebp)
80105878:	e8 a6 be ff ff       	call   80101723 <iupdate>
8010587d:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80105880:	83 ec 0c             	sub    $0xc,%esp
80105883:	ff 75 f4             	pushl  -0xc(%ebp)
80105886:	e8 c4 c1 ff ff       	call   80101a4f <iunlock>
8010588b:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
8010588e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105891:	83 ec 08             	sub    $0x8,%esp
80105894:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105897:	52                   	push   %edx
80105898:	50                   	push   %eax
80105899:	e8 7c cd ff ff       	call   8010261a <nameiparent>
8010589e:	83 c4 10             	add    $0x10,%esp
801058a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
801058a4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801058a8:	74 71                	je     8010591b <sys_link+0x155>
    goto bad;
  ilock(dp);
801058aa:	83 ec 0c             	sub    $0xc,%esp
801058ad:	ff 75 f0             	pushl  -0x10(%ebp)
801058b0:	e8 42 c0 ff ff       	call   801018f7 <ilock>
801058b5:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801058b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058bb:	8b 10                	mov    (%eax),%edx
801058bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058c0:	8b 00                	mov    (%eax),%eax
801058c2:	39 c2                	cmp    %eax,%edx
801058c4:	75 1d                	jne    801058e3 <sys_link+0x11d>
801058c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058c9:	8b 40 04             	mov    0x4(%eax),%eax
801058cc:	83 ec 04             	sub    $0x4,%esp
801058cf:	50                   	push   %eax
801058d0:	8d 45 e2             	lea    -0x1e(%ebp),%eax
801058d3:	50                   	push   %eax
801058d4:	ff 75 f0             	pushl  -0x10(%ebp)
801058d7:	e8 86 ca ff ff       	call   80102362 <dirlink>
801058dc:	83 c4 10             	add    $0x10,%esp
801058df:	85 c0                	test   %eax,%eax
801058e1:	79 10                	jns    801058f3 <sys_link+0x12d>
    iunlockput(dp);
801058e3:	83 ec 0c             	sub    $0xc,%esp
801058e6:	ff 75 f0             	pushl  -0x10(%ebp)
801058e9:	e8 c3 c2 ff ff       	call   80101bb1 <iunlockput>
801058ee:	83 c4 10             	add    $0x10,%esp
    goto bad;
801058f1:	eb 29                	jmp    8010591c <sys_link+0x156>
  }
  iunlockput(dp);
801058f3:	83 ec 0c             	sub    $0xc,%esp
801058f6:	ff 75 f0             	pushl  -0x10(%ebp)
801058f9:	e8 b3 c2 ff ff       	call   80101bb1 <iunlockput>
801058fe:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80105901:	83 ec 0c             	sub    $0xc,%esp
80105904:	ff 75 f4             	pushl  -0xc(%ebp)
80105907:	e8 b5 c1 ff ff       	call   80101ac1 <iput>
8010590c:	83 c4 10             	add    $0x10,%esp

  commit_trans();
8010590f:	e8 59 dc ff ff       	call   8010356d <commit_trans>

  return 0;
80105914:	b8 00 00 00 00       	mov    $0x0,%eax
80105919:	eb 48                	jmp    80105963 <sys_link+0x19d>
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
8010591b:	90                   	nop
  commit_trans();

  return 0;

bad:
  ilock(ip);
8010591c:	83 ec 0c             	sub    $0xc,%esp
8010591f:	ff 75 f4             	pushl  -0xc(%ebp)
80105922:	e8 d0 bf ff ff       	call   801018f7 <ilock>
80105927:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
8010592a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010592d:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105931:	83 e8 01             	sub    $0x1,%eax
80105934:	89 c2                	mov    %eax,%edx
80105936:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105939:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
8010593d:	83 ec 0c             	sub    $0xc,%esp
80105940:	ff 75 f4             	pushl  -0xc(%ebp)
80105943:	e8 db bd ff ff       	call   80101723 <iupdate>
80105948:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
8010594b:	83 ec 0c             	sub    $0xc,%esp
8010594e:	ff 75 f4             	pushl  -0xc(%ebp)
80105951:	e8 5b c2 ff ff       	call   80101bb1 <iunlockput>
80105956:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105959:	e8 0f dc ff ff       	call   8010356d <commit_trans>
  return -1;
8010595e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105963:	c9                   	leave  
80105964:	c3                   	ret    

80105965 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105965:	55                   	push   %ebp
80105966:	89 e5                	mov    %esp,%ebp
80105968:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
8010596b:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105972:	eb 40                	jmp    801059b4 <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105974:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105977:	6a 10                	push   $0x10
80105979:	50                   	push   %eax
8010597a:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010597d:	50                   	push   %eax
8010597e:	ff 75 08             	pushl  0x8(%ebp)
80105981:	e8 28 c6 ff ff       	call   80101fae <readi>
80105986:	83 c4 10             	add    $0x10,%esp
80105989:	83 f8 10             	cmp    $0x10,%eax
8010598c:	74 0d                	je     8010599b <isdirempty+0x36>
      panic("isdirempty: readi");
8010598e:	83 ec 0c             	sub    $0xc,%esp
80105991:	68 77 b8 10 80       	push   $0x8010b877
80105996:	e8 cb ab ff ff       	call   80100566 <panic>
    if(de.inum != 0)
8010599b:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
8010599f:	66 85 c0             	test   %ax,%ax
801059a2:	74 07                	je     801059ab <isdirempty+0x46>
      return 0;
801059a4:	b8 00 00 00 00       	mov    $0x0,%eax
801059a9:	eb 1b                	jmp    801059c6 <isdirempty+0x61>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801059ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059ae:	83 c0 10             	add    $0x10,%eax
801059b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
801059b4:	8b 45 08             	mov    0x8(%ebp),%eax
801059b7:	8b 50 18             	mov    0x18(%eax),%edx
801059ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059bd:	39 c2                	cmp    %eax,%edx
801059bf:	77 b3                	ja     80105974 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
801059c1:	b8 01 00 00 00       	mov    $0x1,%eax
}
801059c6:	c9                   	leave  
801059c7:	c3                   	ret    

801059c8 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
801059c8:	55                   	push   %ebp
801059c9:	89 e5                	mov    %esp,%ebp
801059cb:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801059ce:	83 ec 08             	sub    $0x8,%esp
801059d1:	8d 45 cc             	lea    -0x34(%ebp),%eax
801059d4:	50                   	push   %eax
801059d5:	6a 00                	push   $0x0
801059d7:	e8 a5 fa ff ff       	call   80105481 <argstr>
801059dc:	83 c4 10             	add    $0x10,%esp
801059df:	85 c0                	test   %eax,%eax
801059e1:	79 0a                	jns    801059ed <sys_unlink+0x25>
    return -1;
801059e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059e8:	e9 b7 01 00 00       	jmp    80105ba4 <sys_unlink+0x1dc>
  if((dp = nameiparent(path, name)) == 0)
801059ed:	8b 45 cc             	mov    -0x34(%ebp),%eax
801059f0:	83 ec 08             	sub    $0x8,%esp
801059f3:	8d 55 d2             	lea    -0x2e(%ebp),%edx
801059f6:	52                   	push   %edx
801059f7:	50                   	push   %eax
801059f8:	e8 1d cc ff ff       	call   8010261a <nameiparent>
801059fd:	83 c4 10             	add    $0x10,%esp
80105a00:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105a03:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105a07:	75 0a                	jne    80105a13 <sys_unlink+0x4b>
    return -1;
80105a09:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a0e:	e9 91 01 00 00       	jmp    80105ba4 <sys_unlink+0x1dc>

  begin_trans();
80105a13:	e8 02 db ff ff       	call   8010351a <begin_trans>

  ilock(dp);
80105a18:	83 ec 0c             	sub    $0xc,%esp
80105a1b:	ff 75 f4             	pushl  -0xc(%ebp)
80105a1e:	e8 d4 be ff ff       	call   801018f7 <ilock>
80105a23:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105a26:	83 ec 08             	sub    $0x8,%esp
80105a29:	68 89 b8 10 80       	push   $0x8010b889
80105a2e:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105a31:	50                   	push   %eax
80105a32:	e8 56 c8 ff ff       	call   8010228d <namecmp>
80105a37:	83 c4 10             	add    $0x10,%esp
80105a3a:	85 c0                	test   %eax,%eax
80105a3c:	0f 84 4a 01 00 00    	je     80105b8c <sys_unlink+0x1c4>
80105a42:	83 ec 08             	sub    $0x8,%esp
80105a45:	68 8b b8 10 80       	push   $0x8010b88b
80105a4a:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105a4d:	50                   	push   %eax
80105a4e:	e8 3a c8 ff ff       	call   8010228d <namecmp>
80105a53:	83 c4 10             	add    $0x10,%esp
80105a56:	85 c0                	test   %eax,%eax
80105a58:	0f 84 2e 01 00 00    	je     80105b8c <sys_unlink+0x1c4>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105a5e:	83 ec 04             	sub    $0x4,%esp
80105a61:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105a64:	50                   	push   %eax
80105a65:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105a68:	50                   	push   %eax
80105a69:	ff 75 f4             	pushl  -0xc(%ebp)
80105a6c:	e8 37 c8 ff ff       	call   801022a8 <dirlookup>
80105a71:	83 c4 10             	add    $0x10,%esp
80105a74:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105a77:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105a7b:	0f 84 0a 01 00 00    	je     80105b8b <sys_unlink+0x1c3>
    goto bad;
  ilock(ip);
80105a81:	83 ec 0c             	sub    $0xc,%esp
80105a84:	ff 75 f0             	pushl  -0x10(%ebp)
80105a87:	e8 6b be ff ff       	call   801018f7 <ilock>
80105a8c:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105a8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a92:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105a96:	66 85 c0             	test   %ax,%ax
80105a99:	7f 0d                	jg     80105aa8 <sys_unlink+0xe0>
    panic("unlink: nlink < 1");
80105a9b:	83 ec 0c             	sub    $0xc,%esp
80105a9e:	68 8e b8 10 80       	push   $0x8010b88e
80105aa3:	e8 be aa ff ff       	call   80100566 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105aa8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105aab:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105aaf:	66 83 f8 01          	cmp    $0x1,%ax
80105ab3:	75 25                	jne    80105ada <sys_unlink+0x112>
80105ab5:	83 ec 0c             	sub    $0xc,%esp
80105ab8:	ff 75 f0             	pushl  -0x10(%ebp)
80105abb:	e8 a5 fe ff ff       	call   80105965 <isdirempty>
80105ac0:	83 c4 10             	add    $0x10,%esp
80105ac3:	85 c0                	test   %eax,%eax
80105ac5:	75 13                	jne    80105ada <sys_unlink+0x112>
    iunlockput(ip);
80105ac7:	83 ec 0c             	sub    $0xc,%esp
80105aca:	ff 75 f0             	pushl  -0x10(%ebp)
80105acd:	e8 df c0 ff ff       	call   80101bb1 <iunlockput>
80105ad2:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105ad5:	e9 b2 00 00 00       	jmp    80105b8c <sys_unlink+0x1c4>
  }

  memset(&de, 0, sizeof(de));
80105ada:	83 ec 04             	sub    $0x4,%esp
80105add:	6a 10                	push   $0x10
80105adf:	6a 00                	push   $0x0
80105ae1:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105ae4:	50                   	push   %eax
80105ae5:	e8 ed f5 ff ff       	call   801050d7 <memset>
80105aea:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105aed:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105af0:	6a 10                	push   $0x10
80105af2:	50                   	push   %eax
80105af3:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105af6:	50                   	push   %eax
80105af7:	ff 75 f4             	pushl  -0xc(%ebp)
80105afa:	e8 06 c6 ff ff       	call   80102105 <writei>
80105aff:	83 c4 10             	add    $0x10,%esp
80105b02:	83 f8 10             	cmp    $0x10,%eax
80105b05:	74 0d                	je     80105b14 <sys_unlink+0x14c>
    panic("unlink: writei");
80105b07:	83 ec 0c             	sub    $0xc,%esp
80105b0a:	68 a0 b8 10 80       	push   $0x8010b8a0
80105b0f:	e8 52 aa ff ff       	call   80100566 <panic>
  if(ip->type == T_DIR){
80105b14:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b17:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105b1b:	66 83 f8 01          	cmp    $0x1,%ax
80105b1f:	75 21                	jne    80105b42 <sys_unlink+0x17a>
    dp->nlink--;
80105b21:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b24:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105b28:	83 e8 01             	sub    $0x1,%eax
80105b2b:	89 c2                	mov    %eax,%edx
80105b2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b30:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105b34:	83 ec 0c             	sub    $0xc,%esp
80105b37:	ff 75 f4             	pushl  -0xc(%ebp)
80105b3a:	e8 e4 bb ff ff       	call   80101723 <iupdate>
80105b3f:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80105b42:	83 ec 0c             	sub    $0xc,%esp
80105b45:	ff 75 f4             	pushl  -0xc(%ebp)
80105b48:	e8 64 c0 ff ff       	call   80101bb1 <iunlockput>
80105b4d:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80105b50:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b53:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105b57:	83 e8 01             	sub    $0x1,%eax
80105b5a:	89 c2                	mov    %eax,%edx
80105b5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b5f:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105b63:	83 ec 0c             	sub    $0xc,%esp
80105b66:	ff 75 f0             	pushl  -0x10(%ebp)
80105b69:	e8 b5 bb ff ff       	call   80101723 <iupdate>
80105b6e:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105b71:	83 ec 0c             	sub    $0xc,%esp
80105b74:	ff 75 f0             	pushl  -0x10(%ebp)
80105b77:	e8 35 c0 ff ff       	call   80101bb1 <iunlockput>
80105b7c:	83 c4 10             	add    $0x10,%esp

  commit_trans();
80105b7f:	e8 e9 d9 ff ff       	call   8010356d <commit_trans>

  return 0;
80105b84:	b8 00 00 00 00       	mov    $0x0,%eax
80105b89:	eb 19                	jmp    80105ba4 <sys_unlink+0x1dc>
  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
80105b8b:	90                   	nop
  commit_trans();

  return 0;

bad:
  iunlockput(dp);
80105b8c:	83 ec 0c             	sub    $0xc,%esp
80105b8f:	ff 75 f4             	pushl  -0xc(%ebp)
80105b92:	e8 1a c0 ff ff       	call   80101bb1 <iunlockput>
80105b97:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105b9a:	e8 ce d9 ff ff       	call   8010356d <commit_trans>
  return -1;
80105b9f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ba4:	c9                   	leave  
80105ba5:	c3                   	ret    

80105ba6 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105ba6:	55                   	push   %ebp
80105ba7:	89 e5                	mov    %esp,%ebp
80105ba9:	83 ec 38             	sub    $0x38,%esp
80105bac:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105baf:	8b 55 10             	mov    0x10(%ebp),%edx
80105bb2:	8b 45 14             	mov    0x14(%ebp),%eax
80105bb5:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105bb9:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105bbd:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105bc1:	83 ec 08             	sub    $0x8,%esp
80105bc4:	8d 45 de             	lea    -0x22(%ebp),%eax
80105bc7:	50                   	push   %eax
80105bc8:	ff 75 08             	pushl  0x8(%ebp)
80105bcb:	e8 4a ca ff ff       	call   8010261a <nameiparent>
80105bd0:	83 c4 10             	add    $0x10,%esp
80105bd3:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105bd6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105bda:	75 0a                	jne    80105be6 <create+0x40>
    return 0;
80105bdc:	b8 00 00 00 00       	mov    $0x0,%eax
80105be1:	e9 90 01 00 00       	jmp    80105d76 <create+0x1d0>
  ilock(dp);
80105be6:	83 ec 0c             	sub    $0xc,%esp
80105be9:	ff 75 f4             	pushl  -0xc(%ebp)
80105bec:	e8 06 bd ff ff       	call   801018f7 <ilock>
80105bf1:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
80105bf4:	83 ec 04             	sub    $0x4,%esp
80105bf7:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105bfa:	50                   	push   %eax
80105bfb:	8d 45 de             	lea    -0x22(%ebp),%eax
80105bfe:	50                   	push   %eax
80105bff:	ff 75 f4             	pushl  -0xc(%ebp)
80105c02:	e8 a1 c6 ff ff       	call   801022a8 <dirlookup>
80105c07:	83 c4 10             	add    $0x10,%esp
80105c0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105c0d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105c11:	74 50                	je     80105c63 <create+0xbd>
    iunlockput(dp);
80105c13:	83 ec 0c             	sub    $0xc,%esp
80105c16:	ff 75 f4             	pushl  -0xc(%ebp)
80105c19:	e8 93 bf ff ff       	call   80101bb1 <iunlockput>
80105c1e:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80105c21:	83 ec 0c             	sub    $0xc,%esp
80105c24:	ff 75 f0             	pushl  -0x10(%ebp)
80105c27:	e8 cb bc ff ff       	call   801018f7 <ilock>
80105c2c:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80105c2f:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105c34:	75 15                	jne    80105c4b <create+0xa5>
80105c36:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c39:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105c3d:	66 83 f8 02          	cmp    $0x2,%ax
80105c41:	75 08                	jne    80105c4b <create+0xa5>
      return ip;
80105c43:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c46:	e9 2b 01 00 00       	jmp    80105d76 <create+0x1d0>
    iunlockput(ip);
80105c4b:	83 ec 0c             	sub    $0xc,%esp
80105c4e:	ff 75 f0             	pushl  -0x10(%ebp)
80105c51:	e8 5b bf ff ff       	call   80101bb1 <iunlockput>
80105c56:	83 c4 10             	add    $0x10,%esp
    return 0;
80105c59:	b8 00 00 00 00       	mov    $0x0,%eax
80105c5e:	e9 13 01 00 00       	jmp    80105d76 <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105c63:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105c67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c6a:	8b 00                	mov    (%eax),%eax
80105c6c:	83 ec 08             	sub    $0x8,%esp
80105c6f:	52                   	push   %edx
80105c70:	50                   	push   %eax
80105c71:	e8 cc b9 ff ff       	call   80101642 <ialloc>
80105c76:	83 c4 10             	add    $0x10,%esp
80105c79:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105c7c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105c80:	75 0d                	jne    80105c8f <create+0xe9>
    panic("create: ialloc");
80105c82:	83 ec 0c             	sub    $0xc,%esp
80105c85:	68 af b8 10 80       	push   $0x8010b8af
80105c8a:	e8 d7 a8 ff ff       	call   80100566 <panic>

  ilock(ip);
80105c8f:	83 ec 0c             	sub    $0xc,%esp
80105c92:	ff 75 f0             	pushl  -0x10(%ebp)
80105c95:	e8 5d bc ff ff       	call   801018f7 <ilock>
80105c9a:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80105c9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ca0:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105ca4:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80105ca8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cab:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105caf:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80105cb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cb6:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105cbc:	83 ec 0c             	sub    $0xc,%esp
80105cbf:	ff 75 f0             	pushl  -0x10(%ebp)
80105cc2:	e8 5c ba ff ff       	call   80101723 <iupdate>
80105cc7:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
80105cca:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105ccf:	75 6a                	jne    80105d3b <create+0x195>
    dp->nlink++;  // for ".."
80105cd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cd4:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105cd8:	83 c0 01             	add    $0x1,%eax
80105cdb:	89 c2                	mov    %eax,%edx
80105cdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ce0:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105ce4:	83 ec 0c             	sub    $0xc,%esp
80105ce7:	ff 75 f4             	pushl  -0xc(%ebp)
80105cea:	e8 34 ba ff ff       	call   80101723 <iupdate>
80105cef:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105cf2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cf5:	8b 40 04             	mov    0x4(%eax),%eax
80105cf8:	83 ec 04             	sub    $0x4,%esp
80105cfb:	50                   	push   %eax
80105cfc:	68 89 b8 10 80       	push   $0x8010b889
80105d01:	ff 75 f0             	pushl  -0x10(%ebp)
80105d04:	e8 59 c6 ff ff       	call   80102362 <dirlink>
80105d09:	83 c4 10             	add    $0x10,%esp
80105d0c:	85 c0                	test   %eax,%eax
80105d0e:	78 1e                	js     80105d2e <create+0x188>
80105d10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d13:	8b 40 04             	mov    0x4(%eax),%eax
80105d16:	83 ec 04             	sub    $0x4,%esp
80105d19:	50                   	push   %eax
80105d1a:	68 8b b8 10 80       	push   $0x8010b88b
80105d1f:	ff 75 f0             	pushl  -0x10(%ebp)
80105d22:	e8 3b c6 ff ff       	call   80102362 <dirlink>
80105d27:	83 c4 10             	add    $0x10,%esp
80105d2a:	85 c0                	test   %eax,%eax
80105d2c:	79 0d                	jns    80105d3b <create+0x195>
      panic("create dots");
80105d2e:	83 ec 0c             	sub    $0xc,%esp
80105d31:	68 be b8 10 80       	push   $0x8010b8be
80105d36:	e8 2b a8 ff ff       	call   80100566 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105d3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d3e:	8b 40 04             	mov    0x4(%eax),%eax
80105d41:	83 ec 04             	sub    $0x4,%esp
80105d44:	50                   	push   %eax
80105d45:	8d 45 de             	lea    -0x22(%ebp),%eax
80105d48:	50                   	push   %eax
80105d49:	ff 75 f4             	pushl  -0xc(%ebp)
80105d4c:	e8 11 c6 ff ff       	call   80102362 <dirlink>
80105d51:	83 c4 10             	add    $0x10,%esp
80105d54:	85 c0                	test   %eax,%eax
80105d56:	79 0d                	jns    80105d65 <create+0x1bf>
    panic("create: dirlink");
80105d58:	83 ec 0c             	sub    $0xc,%esp
80105d5b:	68 ca b8 10 80       	push   $0x8010b8ca
80105d60:	e8 01 a8 ff ff       	call   80100566 <panic>

  iunlockput(dp);
80105d65:	83 ec 0c             	sub    $0xc,%esp
80105d68:	ff 75 f4             	pushl  -0xc(%ebp)
80105d6b:	e8 41 be ff ff       	call   80101bb1 <iunlockput>
80105d70:	83 c4 10             	add    $0x10,%esp

  return ip;
80105d73:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105d76:	c9                   	leave  
80105d77:	c3                   	ret    

80105d78 <sys_open>:

int
sys_open(void)
{
80105d78:	55                   	push   %ebp
80105d79:	89 e5                	mov    %esp,%ebp
80105d7b:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105d7e:	83 ec 08             	sub    $0x8,%esp
80105d81:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105d84:	50                   	push   %eax
80105d85:	6a 00                	push   $0x0
80105d87:	e8 f5 f6 ff ff       	call   80105481 <argstr>
80105d8c:	83 c4 10             	add    $0x10,%esp
80105d8f:	85 c0                	test   %eax,%eax
80105d91:	78 15                	js     80105da8 <sys_open+0x30>
80105d93:	83 ec 08             	sub    $0x8,%esp
80105d96:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d99:	50                   	push   %eax
80105d9a:	6a 01                	push   $0x1
80105d9c:	e8 5b f6 ff ff       	call   801053fc <argint>
80105da1:	83 c4 10             	add    $0x10,%esp
80105da4:	85 c0                	test   %eax,%eax
80105da6:	79 0a                	jns    80105db2 <sys_open+0x3a>
    return -1;
80105da8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dad:	e9 4d 01 00 00       	jmp    80105eff <sys_open+0x187>
  if(omode & O_CREATE){
80105db2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105db5:	25 00 02 00 00       	and    $0x200,%eax
80105dba:	85 c0                	test   %eax,%eax
80105dbc:	74 2f                	je     80105ded <sys_open+0x75>
    begin_trans();
80105dbe:	e8 57 d7 ff ff       	call   8010351a <begin_trans>
    ip = create(path, T_FILE, 0, 0);
80105dc3:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105dc6:	6a 00                	push   $0x0
80105dc8:	6a 00                	push   $0x0
80105dca:	6a 02                	push   $0x2
80105dcc:	50                   	push   %eax
80105dcd:	e8 d4 fd ff ff       	call   80105ba6 <create>
80105dd2:	83 c4 10             	add    $0x10,%esp
80105dd5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    commit_trans();
80105dd8:	e8 90 d7 ff ff       	call   8010356d <commit_trans>
    if(ip == 0)
80105ddd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105de1:	75 66                	jne    80105e49 <sys_open+0xd1>
      return -1;
80105de3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105de8:	e9 12 01 00 00       	jmp    80105eff <sys_open+0x187>
  } else {
    if((ip = namei(path)) == 0)
80105ded:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105df0:	83 ec 0c             	sub    $0xc,%esp
80105df3:	50                   	push   %eax
80105df4:	e8 05 c8 ff ff       	call   801025fe <namei>
80105df9:	83 c4 10             	add    $0x10,%esp
80105dfc:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105dff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105e03:	75 0a                	jne    80105e0f <sys_open+0x97>
      return -1;
80105e05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e0a:	e9 f0 00 00 00       	jmp    80105eff <sys_open+0x187>
    ilock(ip);
80105e0f:	83 ec 0c             	sub    $0xc,%esp
80105e12:	ff 75 f4             	pushl  -0xc(%ebp)
80105e15:	e8 dd ba ff ff       	call   801018f7 <ilock>
80105e1a:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e20:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105e24:	66 83 f8 01          	cmp    $0x1,%ax
80105e28:	75 1f                	jne    80105e49 <sys_open+0xd1>
80105e2a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105e2d:	85 c0                	test   %eax,%eax
80105e2f:	74 18                	je     80105e49 <sys_open+0xd1>
      iunlockput(ip);
80105e31:	83 ec 0c             	sub    $0xc,%esp
80105e34:	ff 75 f4             	pushl  -0xc(%ebp)
80105e37:	e8 75 bd ff ff       	call   80101bb1 <iunlockput>
80105e3c:	83 c4 10             	add    $0x10,%esp
      return -1;
80105e3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e44:	e9 b6 00 00 00       	jmp    80105eff <sys_open+0x187>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105e49:	e8 16 b1 ff ff       	call   80100f64 <filealloc>
80105e4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105e51:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e55:	74 17                	je     80105e6e <sys_open+0xf6>
80105e57:	83 ec 0c             	sub    $0xc,%esp
80105e5a:	ff 75 f0             	pushl  -0x10(%ebp)
80105e5d:	e8 4b f7 ff ff       	call   801055ad <fdalloc>
80105e62:	83 c4 10             	add    $0x10,%esp
80105e65:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105e68:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105e6c:	79 29                	jns    80105e97 <sys_open+0x11f>
    if(f)
80105e6e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e72:	74 0e                	je     80105e82 <sys_open+0x10a>
      fileclose(f);
80105e74:	83 ec 0c             	sub    $0xc,%esp
80105e77:	ff 75 f0             	pushl  -0x10(%ebp)
80105e7a:	e8 a3 b1 ff ff       	call   80101022 <fileclose>
80105e7f:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105e82:	83 ec 0c             	sub    $0xc,%esp
80105e85:	ff 75 f4             	pushl  -0xc(%ebp)
80105e88:	e8 24 bd ff ff       	call   80101bb1 <iunlockput>
80105e8d:	83 c4 10             	add    $0x10,%esp
    return -1;
80105e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e95:	eb 68                	jmp    80105eff <sys_open+0x187>
  }
  iunlock(ip);
80105e97:	83 ec 0c             	sub    $0xc,%esp
80105e9a:	ff 75 f4             	pushl  -0xc(%ebp)
80105e9d:	e8 ad bb ff ff       	call   80101a4f <iunlock>
80105ea2:	83 c4 10             	add    $0x10,%esp

  f->type = FD_INODE;
80105ea5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ea8:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80105eae:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105eb1:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105eb4:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80105eb7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105eba:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80105ec1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ec4:	83 e0 01             	and    $0x1,%eax
80105ec7:	85 c0                	test   %eax,%eax
80105ec9:	0f 94 c0             	sete   %al
80105ecc:	89 c2                	mov    %eax,%edx
80105ece:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ed1:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105ed4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ed7:	83 e0 01             	and    $0x1,%eax
80105eda:	85 c0                	test   %eax,%eax
80105edc:	75 0a                	jne    80105ee8 <sys_open+0x170>
80105ede:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ee1:	83 e0 02             	and    $0x2,%eax
80105ee4:	85 c0                	test   %eax,%eax
80105ee6:	74 07                	je     80105eef <sys_open+0x177>
80105ee8:	b8 01 00 00 00       	mov    $0x1,%eax
80105eed:	eb 05                	jmp    80105ef4 <sys_open+0x17c>
80105eef:	b8 00 00 00 00       	mov    $0x0,%eax
80105ef4:	89 c2                	mov    %eax,%edx
80105ef6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ef9:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80105efc:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80105eff:	c9                   	leave  
80105f00:	c3                   	ret    

80105f01 <sys_mkdir>:

int
sys_mkdir(void)
{
80105f01:	55                   	push   %ebp
80105f02:	89 e5                	mov    %esp,%ebp
80105f04:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_trans();
80105f07:	e8 0e d6 ff ff       	call   8010351a <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105f0c:	83 ec 08             	sub    $0x8,%esp
80105f0f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f12:	50                   	push   %eax
80105f13:	6a 00                	push   $0x0
80105f15:	e8 67 f5 ff ff       	call   80105481 <argstr>
80105f1a:	83 c4 10             	add    $0x10,%esp
80105f1d:	85 c0                	test   %eax,%eax
80105f1f:	78 1b                	js     80105f3c <sys_mkdir+0x3b>
80105f21:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f24:	6a 00                	push   $0x0
80105f26:	6a 00                	push   $0x0
80105f28:	6a 01                	push   $0x1
80105f2a:	50                   	push   %eax
80105f2b:	e8 76 fc ff ff       	call   80105ba6 <create>
80105f30:	83 c4 10             	add    $0x10,%esp
80105f33:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f36:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f3a:	75 0c                	jne    80105f48 <sys_mkdir+0x47>
    commit_trans();
80105f3c:	e8 2c d6 ff ff       	call   8010356d <commit_trans>
    return -1;
80105f41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f46:	eb 18                	jmp    80105f60 <sys_mkdir+0x5f>
  }
  iunlockput(ip);
80105f48:	83 ec 0c             	sub    $0xc,%esp
80105f4b:	ff 75 f4             	pushl  -0xc(%ebp)
80105f4e:	e8 5e bc ff ff       	call   80101bb1 <iunlockput>
80105f53:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105f56:	e8 12 d6 ff ff       	call   8010356d <commit_trans>
  return 0;
80105f5b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105f60:	c9                   	leave  
80105f61:	c3                   	ret    

80105f62 <sys_mknod>:

int
sys_mknod(void)
{
80105f62:	55                   	push   %ebp
80105f63:	89 e5                	mov    %esp,%ebp
80105f65:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
80105f68:	e8 ad d5 ff ff       	call   8010351a <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
80105f6d:	83 ec 08             	sub    $0x8,%esp
80105f70:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105f73:	50                   	push   %eax
80105f74:	6a 00                	push   $0x0
80105f76:	e8 06 f5 ff ff       	call   80105481 <argstr>
80105f7b:	83 c4 10             	add    $0x10,%esp
80105f7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f85:	78 4f                	js     80105fd6 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
80105f87:	83 ec 08             	sub    $0x8,%esp
80105f8a:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105f8d:	50                   	push   %eax
80105f8e:	6a 01                	push   $0x1
80105f90:	e8 67 f4 ff ff       	call   801053fc <argint>
80105f95:	83 c4 10             	add    $0x10,%esp
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
80105f98:	85 c0                	test   %eax,%eax
80105f9a:	78 3a                	js     80105fd6 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105f9c:	83 ec 08             	sub    $0x8,%esp
80105f9f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105fa2:	50                   	push   %eax
80105fa3:	6a 02                	push   $0x2
80105fa5:	e8 52 f4 ff ff       	call   801053fc <argint>
80105faa:	83 c4 10             	add    $0x10,%esp
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105fad:	85 c0                	test   %eax,%eax
80105faf:	78 25                	js     80105fd6 <sys_mknod+0x74>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80105fb1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105fb4:	0f bf c8             	movswl %ax,%ecx
80105fb7:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105fba:	0f bf d0             	movswl %ax,%edx
80105fbd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105fc0:	51                   	push   %ecx
80105fc1:	52                   	push   %edx
80105fc2:	6a 03                	push   $0x3
80105fc4:	50                   	push   %eax
80105fc5:	e8 dc fb ff ff       	call   80105ba6 <create>
80105fca:	83 c4 10             	add    $0x10,%esp
80105fcd:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105fd0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105fd4:	75 0c                	jne    80105fe2 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    commit_trans();
80105fd6:	e8 92 d5 ff ff       	call   8010356d <commit_trans>
    return -1;
80105fdb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fe0:	eb 18                	jmp    80105ffa <sys_mknod+0x98>
  }
  iunlockput(ip);
80105fe2:	83 ec 0c             	sub    $0xc,%esp
80105fe5:	ff 75 f0             	pushl  -0x10(%ebp)
80105fe8:	e8 c4 bb ff ff       	call   80101bb1 <iunlockput>
80105fed:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105ff0:	e8 78 d5 ff ff       	call   8010356d <commit_trans>
  return 0;
80105ff5:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105ffa:	c9                   	leave  
80105ffb:	c3                   	ret    

80105ffc <sys_chdir>:

int
sys_chdir(void)
{
80105ffc:	55                   	push   %ebp
80105ffd:	89 e5                	mov    %esp,%ebp
80105fff:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80106002:	83 ec 08             	sub    $0x8,%esp
80106005:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106008:	50                   	push   %eax
80106009:	6a 00                	push   $0x0
8010600b:	e8 71 f4 ff ff       	call   80105481 <argstr>
80106010:	83 c4 10             	add    $0x10,%esp
80106013:	85 c0                	test   %eax,%eax
80106015:	78 18                	js     8010602f <sys_chdir+0x33>
80106017:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010601a:	83 ec 0c             	sub    $0xc,%esp
8010601d:	50                   	push   %eax
8010601e:	e8 db c5 ff ff       	call   801025fe <namei>
80106023:	83 c4 10             	add    $0x10,%esp
80106026:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106029:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010602d:	75 07                	jne    80106036 <sys_chdir+0x3a>
    return -1;
8010602f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106034:	eb 64                	jmp    8010609a <sys_chdir+0x9e>
  ilock(ip);
80106036:	83 ec 0c             	sub    $0xc,%esp
80106039:	ff 75 f4             	pushl  -0xc(%ebp)
8010603c:	e8 b6 b8 ff ff       	call   801018f7 <ilock>
80106041:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
80106044:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106047:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010604b:	66 83 f8 01          	cmp    $0x1,%ax
8010604f:	74 15                	je     80106066 <sys_chdir+0x6a>
    iunlockput(ip);
80106051:	83 ec 0c             	sub    $0xc,%esp
80106054:	ff 75 f4             	pushl  -0xc(%ebp)
80106057:	e8 55 bb ff ff       	call   80101bb1 <iunlockput>
8010605c:	83 c4 10             	add    $0x10,%esp
    return -1;
8010605f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106064:	eb 34                	jmp    8010609a <sys_chdir+0x9e>
  }
  iunlock(ip);
80106066:	83 ec 0c             	sub    $0xc,%esp
80106069:	ff 75 f4             	pushl  -0xc(%ebp)
8010606c:	e8 de b9 ff ff       	call   80101a4f <iunlock>
80106071:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
80106074:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010607a:	8b 40 68             	mov    0x68(%eax),%eax
8010607d:	83 ec 0c             	sub    $0xc,%esp
80106080:	50                   	push   %eax
80106081:	e8 3b ba ff ff       	call   80101ac1 <iput>
80106086:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
80106089:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010608f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106092:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80106095:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010609a:	c9                   	leave  
8010609b:	c3                   	ret    

8010609c <sys_exec>:

int
sys_exec(void)
{
8010609c:	55                   	push   %ebp
8010609d:	89 e5                	mov    %esp,%ebp
8010609f:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801060a5:	83 ec 08             	sub    $0x8,%esp
801060a8:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060ab:	50                   	push   %eax
801060ac:	6a 00                	push   $0x0
801060ae:	e8 ce f3 ff ff       	call   80105481 <argstr>
801060b3:	83 c4 10             	add    $0x10,%esp
801060b6:	85 c0                	test   %eax,%eax
801060b8:	78 18                	js     801060d2 <sys_exec+0x36>
801060ba:	83 ec 08             	sub    $0x8,%esp
801060bd:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
801060c3:	50                   	push   %eax
801060c4:	6a 01                	push   $0x1
801060c6:	e8 31 f3 ff ff       	call   801053fc <argint>
801060cb:	83 c4 10             	add    $0x10,%esp
801060ce:	85 c0                	test   %eax,%eax
801060d0:	79 0a                	jns    801060dc <sys_exec+0x40>
    return -1;
801060d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060d7:	e9 c6 00 00 00       	jmp    801061a2 <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
801060dc:	83 ec 04             	sub    $0x4,%esp
801060df:	68 80 00 00 00       	push   $0x80
801060e4:	6a 00                	push   $0x0
801060e6:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801060ec:	50                   	push   %eax
801060ed:	e8 e5 ef ff ff       	call   801050d7 <memset>
801060f2:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
801060f5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
801060fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060ff:	83 f8 1f             	cmp    $0x1f,%eax
80106102:	76 0a                	jbe    8010610e <sys_exec+0x72>
      return -1;
80106104:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106109:	e9 94 00 00 00       	jmp    801061a2 <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010610e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106111:	c1 e0 02             	shl    $0x2,%eax
80106114:	89 c2                	mov    %eax,%edx
80106116:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
8010611c:	01 c2                	add    %eax,%edx
8010611e:	83 ec 08             	sub    $0x8,%esp
80106121:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106127:	50                   	push   %eax
80106128:	52                   	push   %edx
80106129:	e8 32 f2 ff ff       	call   80105360 <fetchint>
8010612e:	83 c4 10             	add    $0x10,%esp
80106131:	85 c0                	test   %eax,%eax
80106133:	79 07                	jns    8010613c <sys_exec+0xa0>
      return -1;
80106135:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010613a:	eb 66                	jmp    801061a2 <sys_exec+0x106>
    if(uarg == 0){
8010613c:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106142:	85 c0                	test   %eax,%eax
80106144:	75 27                	jne    8010616d <sys_exec+0xd1>
      argv[i] = 0;
80106146:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106149:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80106150:	00 00 00 00 
      break;
80106154:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106155:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106158:	83 ec 08             	sub    $0x8,%esp
8010615b:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80106161:	52                   	push   %edx
80106162:	50                   	push   %eax
80106163:	e8 ee a9 ff ff       	call   80100b56 <exec>
80106168:	83 c4 10             	add    $0x10,%esp
8010616b:	eb 35                	jmp    801061a2 <sys_exec+0x106>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010616d:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106173:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106176:	c1 e2 02             	shl    $0x2,%edx
80106179:	01 c2                	add    %eax,%edx
8010617b:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106181:	83 ec 08             	sub    $0x8,%esp
80106184:	52                   	push   %edx
80106185:	50                   	push   %eax
80106186:	e8 0f f2 ff ff       	call   8010539a <fetchstr>
8010618b:	83 c4 10             	add    $0x10,%esp
8010618e:	85 c0                	test   %eax,%eax
80106190:	79 07                	jns    80106199 <sys_exec+0xfd>
      return -1;
80106192:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106197:	eb 09                	jmp    801061a2 <sys_exec+0x106>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80106199:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
8010619d:	e9 5a ff ff ff       	jmp    801060fc <sys_exec+0x60>
  return exec(path, argv);
}
801061a2:	c9                   	leave  
801061a3:	c3                   	ret    

801061a4 <sys_pipe>:

int
sys_pipe(void)
{
801061a4:	55                   	push   %ebp
801061a5:	89 e5                	mov    %esp,%ebp
801061a7:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801061aa:	83 ec 04             	sub    $0x4,%esp
801061ad:	6a 08                	push   $0x8
801061af:	8d 45 ec             	lea    -0x14(%ebp),%eax
801061b2:	50                   	push   %eax
801061b3:	6a 00                	push   $0x0
801061b5:	e8 6a f2 ff ff       	call   80105424 <argptr>
801061ba:	83 c4 10             	add    $0x10,%esp
801061bd:	85 c0                	test   %eax,%eax
801061bf:	79 0a                	jns    801061cb <sys_pipe+0x27>
    return -1;
801061c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061c6:	e9 af 00 00 00       	jmp    8010627a <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
801061cb:	83 ec 08             	sub    $0x8,%esp
801061ce:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801061d1:	50                   	push   %eax
801061d2:	8d 45 e8             	lea    -0x18(%ebp),%eax
801061d5:	50                   	push   %eax
801061d6:	e8 1a dd ff ff       	call   80103ef5 <pipealloc>
801061db:	83 c4 10             	add    $0x10,%esp
801061de:	85 c0                	test   %eax,%eax
801061e0:	79 0a                	jns    801061ec <sys_pipe+0x48>
    return -1;
801061e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061e7:	e9 8e 00 00 00       	jmp    8010627a <sys_pipe+0xd6>
  fd0 = -1;
801061ec:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801061f3:	8b 45 e8             	mov    -0x18(%ebp),%eax
801061f6:	83 ec 0c             	sub    $0xc,%esp
801061f9:	50                   	push   %eax
801061fa:	e8 ae f3 ff ff       	call   801055ad <fdalloc>
801061ff:	83 c4 10             	add    $0x10,%esp
80106202:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106205:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106209:	78 18                	js     80106223 <sys_pipe+0x7f>
8010620b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010620e:	83 ec 0c             	sub    $0xc,%esp
80106211:	50                   	push   %eax
80106212:	e8 96 f3 ff ff       	call   801055ad <fdalloc>
80106217:	83 c4 10             	add    $0x10,%esp
8010621a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010621d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106221:	79 3f                	jns    80106262 <sys_pipe+0xbe>
    if(fd0 >= 0)
80106223:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106227:	78 14                	js     8010623d <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
80106229:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010622f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106232:	83 c2 08             	add    $0x8,%edx
80106235:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010623c:	00 
    fileclose(rf);
8010623d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106240:	83 ec 0c             	sub    $0xc,%esp
80106243:	50                   	push   %eax
80106244:	e8 d9 ad ff ff       	call   80101022 <fileclose>
80106249:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
8010624c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010624f:	83 ec 0c             	sub    $0xc,%esp
80106252:	50                   	push   %eax
80106253:	e8 ca ad ff ff       	call   80101022 <fileclose>
80106258:	83 c4 10             	add    $0x10,%esp
    return -1;
8010625b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106260:	eb 18                	jmp    8010627a <sys_pipe+0xd6>
  }
  fd[0] = fd0;
80106262:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106265:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106268:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
8010626a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010626d:	8d 50 04             	lea    0x4(%eax),%edx
80106270:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106273:	89 02                	mov    %eax,(%edx)
  return 0;
80106275:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010627a:	c9                   	leave  
8010627b:	c3                   	ret    

8010627c <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
8010627c:	55                   	push   %ebp
8010627d:	89 e5                	mov    %esp,%ebp
8010627f:	83 ec 08             	sub    $0x8,%esp
  return fork();
80106282:	e8 64 e3 ff ff       	call   801045eb <fork>
}
80106287:	c9                   	leave  
80106288:	c3                   	ret    

80106289 <sys_exit>:

int
sys_exit(void)
{
80106289:	55                   	push   %ebp
8010628a:	89 e5                	mov    %esp,%ebp
8010628c:	83 ec 08             	sub    $0x8,%esp
  exit();
8010628f:	e8 c8 e4 ff ff       	call   8010475c <exit>
  return 0;  // not reached
80106294:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106299:	c9                   	leave  
8010629a:	c3                   	ret    

8010629b <sys_wait>:

int
sys_wait(void)
{
8010629b:	55                   	push   %ebp
8010629c:	89 e5                	mov    %esp,%ebp
8010629e:	83 ec 08             	sub    $0x8,%esp
  return wait();
801062a1:	e8 e4 e5 ff ff       	call   8010488a <wait>
}
801062a6:	c9                   	leave  
801062a7:	c3                   	ret    

801062a8 <sys_kill>:

int
sys_kill(void)
{
801062a8:	55                   	push   %ebp
801062a9:	89 e5                	mov    %esp,%ebp
801062ab:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
801062ae:	83 ec 08             	sub    $0x8,%esp
801062b1:	8d 45 f4             	lea    -0xc(%ebp),%eax
801062b4:	50                   	push   %eax
801062b5:	6a 00                	push   $0x0
801062b7:	e8 40 f1 ff ff       	call   801053fc <argint>
801062bc:	83 c4 10             	add    $0x10,%esp
801062bf:	85 c0                	test   %eax,%eax
801062c1:	79 07                	jns    801062ca <sys_kill+0x22>
    return -1;
801062c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062c8:	eb 0f                	jmp    801062d9 <sys_kill+0x31>
  return kill(pid);
801062ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062cd:	83 ec 0c             	sub    $0xc,%esp
801062d0:	50                   	push   %eax
801062d1:	e8 c7 e9 ff ff       	call   80104c9d <kill>
801062d6:	83 c4 10             	add    $0x10,%esp
}
801062d9:	c9                   	leave  
801062da:	c3                   	ret    

801062db <sys_getpid>:

int
sys_getpid(void)
{
801062db:	55                   	push   %ebp
801062dc:	89 e5                	mov    %esp,%ebp
  return proc->pid;
801062de:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062e4:	8b 40 10             	mov    0x10(%eax),%eax
}
801062e7:	5d                   	pop    %ebp
801062e8:	c3                   	ret    

801062e9 <sys_sbrk>:

int
sys_sbrk(void)
{
801062e9:	55                   	push   %ebp
801062ea:	89 e5                	mov    %esp,%ebp
801062ec:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801062ef:	83 ec 08             	sub    $0x8,%esp
801062f2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062f5:	50                   	push   %eax
801062f6:	6a 00                	push   $0x0
801062f8:	e8 ff f0 ff ff       	call   801053fc <argint>
801062fd:	83 c4 10             	add    $0x10,%esp
80106300:	85 c0                	test   %eax,%eax
80106302:	79 07                	jns    8010630b <sys_sbrk+0x22>
    return -1;
80106304:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106309:	eb 28                	jmp    80106333 <sys_sbrk+0x4a>
  addr = proc->sz;
8010630b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106311:	8b 00                	mov    (%eax),%eax
80106313:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80106316:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106319:	83 ec 0c             	sub    $0xc,%esp
8010631c:	50                   	push   %eax
8010631d:	e8 26 e2 ff ff       	call   80104548 <growproc>
80106322:	83 c4 10             	add    $0x10,%esp
80106325:	85 c0                	test   %eax,%eax
80106327:	79 07                	jns    80106330 <sys_sbrk+0x47>
    return -1;
80106329:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010632e:	eb 03                	jmp    80106333 <sys_sbrk+0x4a>
  return addr;
80106330:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106333:	c9                   	leave  
80106334:	c3                   	ret    

80106335 <sys_sleep>:

int
sys_sleep(void)
{
80106335:	55                   	push   %ebp
80106336:	89 e5                	mov    %esp,%ebp
80106338:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
8010633b:	83 ec 08             	sub    $0x8,%esp
8010633e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106341:	50                   	push   %eax
80106342:	6a 00                	push   $0x0
80106344:	e8 b3 f0 ff ff       	call   801053fc <argint>
80106349:	83 c4 10             	add    $0x10,%esp
8010634c:	85 c0                	test   %eax,%eax
8010634e:	79 07                	jns    80106357 <sys_sleep+0x22>
    return -1;
80106350:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106355:	eb 77                	jmp    801063ce <sys_sleep+0x99>
  acquire(&tickslock);
80106357:	83 ec 0c             	sub    $0xc,%esp
8010635a:	68 c0 4e 11 80       	push   $0x80114ec0
8010635f:	e8 10 eb ff ff       	call   80104e74 <acquire>
80106364:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80106367:	a1 00 57 11 80       	mov    0x80115700,%eax
8010636c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
8010636f:	eb 39                	jmp    801063aa <sys_sleep+0x75>
    if(proc->killed){
80106371:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106377:	8b 40 24             	mov    0x24(%eax),%eax
8010637a:	85 c0                	test   %eax,%eax
8010637c:	74 17                	je     80106395 <sys_sleep+0x60>
      release(&tickslock);
8010637e:	83 ec 0c             	sub    $0xc,%esp
80106381:	68 c0 4e 11 80       	push   $0x80114ec0
80106386:	e8 50 eb ff ff       	call   80104edb <release>
8010638b:	83 c4 10             	add    $0x10,%esp
      return -1;
8010638e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106393:	eb 39                	jmp    801063ce <sys_sleep+0x99>
    }
    sleep(&ticks, &tickslock);
80106395:	83 ec 08             	sub    $0x8,%esp
80106398:	68 c0 4e 11 80       	push   $0x80114ec0
8010639d:	68 00 57 11 80       	push   $0x80115700
801063a2:	e8 d4 e7 ff ff       	call   80104b7b <sleep>
801063a7:	83 c4 10             	add    $0x10,%esp
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801063aa:	a1 00 57 11 80       	mov    0x80115700,%eax
801063af:	2b 45 f4             	sub    -0xc(%ebp),%eax
801063b2:	8b 55 f0             	mov    -0x10(%ebp),%edx
801063b5:	39 d0                	cmp    %edx,%eax
801063b7:	72 b8                	jb     80106371 <sys_sleep+0x3c>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801063b9:	83 ec 0c             	sub    $0xc,%esp
801063bc:	68 c0 4e 11 80       	push   $0x80114ec0
801063c1:	e8 15 eb ff ff       	call   80104edb <release>
801063c6:	83 c4 10             	add    $0x10,%esp
  return 0;
801063c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
801063ce:	c9                   	leave  
801063cf:	c3                   	ret    

801063d0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801063d0:	55                   	push   %ebp
801063d1:	89 e5                	mov    %esp,%ebp
801063d3:	83 ec 18             	sub    $0x18,%esp
  uint xticks;
  
  acquire(&tickslock);
801063d6:	83 ec 0c             	sub    $0xc,%esp
801063d9:	68 c0 4e 11 80       	push   $0x80114ec0
801063de:	e8 91 ea ff ff       	call   80104e74 <acquire>
801063e3:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
801063e6:	a1 00 57 11 80       	mov    0x80115700,%eax
801063eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
801063ee:	83 ec 0c             	sub    $0xc,%esp
801063f1:	68 c0 4e 11 80       	push   $0x80114ec0
801063f6:	e8 e0 ea ff ff       	call   80104edb <release>
801063fb:	83 c4 10             	add    $0x10,%esp
  return xticks;
801063fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106401:	c9                   	leave  
80106402:	c3                   	ret    

80106403 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106403:	55                   	push   %ebp
80106404:	89 e5                	mov    %esp,%ebp
80106406:	83 ec 08             	sub    $0x8,%esp
80106409:	8b 55 08             	mov    0x8(%ebp),%edx
8010640c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010640f:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106413:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106416:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010641a:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010641e:	ee                   	out    %al,(%dx)
}
8010641f:	90                   	nop
80106420:	c9                   	leave  
80106421:	c3                   	ret    

80106422 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80106422:	55                   	push   %ebp
80106423:	89 e5                	mov    %esp,%ebp
80106425:	83 ec 08             	sub    $0x8,%esp
  // Interrupt --- 100 ticks/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
80106428:	6a 34                	push   $0x34
8010642a:	6a 43                	push   $0x43
8010642c:	e8 d2 ff ff ff       	call   80106403 <outb>
80106431:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
80106434:	68 9c 00 00 00       	push   $0x9c
80106439:	6a 40                	push   $0x40
8010643b:	e8 c3 ff ff ff       	call   80106403 <outb>
80106440:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
80106443:	6a 2e                	push   $0x2e
80106445:	6a 40                	push   $0x40
80106447:	e8 b7 ff ff ff       	call   80106403 <outb>
8010644c:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
8010644f:	83 ec 0c             	sub    $0xc,%esp
80106452:	6a 00                	push   $0x0
80106454:	e8 86 d9 ff ff       	call   80103ddf <picenable>
80106459:	83 c4 10             	add    $0x10,%esp
}
8010645c:	90                   	nop
8010645d:	c9                   	leave  
8010645e:	c3                   	ret    

8010645f <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010645f:	1e                   	push   %ds
  pushl %es
80106460:	06                   	push   %es
  pushl %fs
80106461:	0f a0                	push   %fs
  pushl %gs
80106463:	0f a8                	push   %gs
  pushal
80106465:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80106466:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
8010646a:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010646c:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
8010646e:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80106472:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80106474:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80106476:	54                   	push   %esp
  call trap
80106477:	e8 d7 01 00 00       	call   80106653 <trap>
  addl $4, %esp
8010647c:	83 c4 04             	add    $0x4,%esp

8010647f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010647f:	61                   	popa   
  popl %gs
80106480:	0f a9                	pop    %gs
  popl %fs
80106482:	0f a1                	pop    %fs
  popl %es
80106484:	07                   	pop    %es
  popl %ds
80106485:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106486:	83 c4 08             	add    $0x8,%esp
  iret
80106489:	cf                   	iret   

8010648a <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
8010648a:	55                   	push   %ebp
8010648b:	89 e5                	mov    %esp,%ebp
8010648d:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80106490:	8b 45 0c             	mov    0xc(%ebp),%eax
80106493:	83 e8 01             	sub    $0x1,%eax
80106496:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010649a:	8b 45 08             	mov    0x8(%ebp),%eax
8010649d:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801064a1:	8b 45 08             	mov    0x8(%ebp),%eax
801064a4:	c1 e8 10             	shr    $0x10,%eax
801064a7:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801064ab:	8d 45 fa             	lea    -0x6(%ebp),%eax
801064ae:	0f 01 18             	lidtl  (%eax)
}
801064b1:	90                   	nop
801064b2:	c9                   	leave  
801064b3:	c3                   	ret    

801064b4 <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
801064b4:	55                   	push   %ebp
801064b5:	89 e5                	mov    %esp,%ebp
801064b7:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801064ba:	0f 20 d0             	mov    %cr2,%eax
801064bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
801064c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801064c3:	c9                   	leave  
801064c4:	c3                   	ret    

801064c5 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801064c5:	55                   	push   %ebp
801064c6:	89 e5                	mov    %esp,%ebp
801064c8:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
801064cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801064d2:	e9 c3 00 00 00       	jmp    8010659a <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801064d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064da:	8b 04 85 b4 e0 10 80 	mov    -0x7fef1f4c(,%eax,4),%eax
801064e1:	89 c2                	mov    %eax,%edx
801064e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064e6:	66 89 14 c5 00 4f 11 	mov    %dx,-0x7feeb100(,%eax,8)
801064ed:	80 
801064ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064f1:	66 c7 04 c5 02 4f 11 	movw   $0x8,-0x7feeb0fe(,%eax,8)
801064f8:	80 08 00 
801064fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064fe:	0f b6 14 c5 04 4f 11 	movzbl -0x7feeb0fc(,%eax,8),%edx
80106505:	80 
80106506:	83 e2 e0             	and    $0xffffffe0,%edx
80106509:	88 14 c5 04 4f 11 80 	mov    %dl,-0x7feeb0fc(,%eax,8)
80106510:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106513:	0f b6 14 c5 04 4f 11 	movzbl -0x7feeb0fc(,%eax,8),%edx
8010651a:	80 
8010651b:	83 e2 1f             	and    $0x1f,%edx
8010651e:	88 14 c5 04 4f 11 80 	mov    %dl,-0x7feeb0fc(,%eax,8)
80106525:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106528:	0f b6 14 c5 05 4f 11 	movzbl -0x7feeb0fb(,%eax,8),%edx
8010652f:	80 
80106530:	83 e2 f0             	and    $0xfffffff0,%edx
80106533:	83 ca 0e             	or     $0xe,%edx
80106536:	88 14 c5 05 4f 11 80 	mov    %dl,-0x7feeb0fb(,%eax,8)
8010653d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106540:	0f b6 14 c5 05 4f 11 	movzbl -0x7feeb0fb(,%eax,8),%edx
80106547:	80 
80106548:	83 e2 ef             	and    $0xffffffef,%edx
8010654b:	88 14 c5 05 4f 11 80 	mov    %dl,-0x7feeb0fb(,%eax,8)
80106552:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106555:	0f b6 14 c5 05 4f 11 	movzbl -0x7feeb0fb(,%eax,8),%edx
8010655c:	80 
8010655d:	83 e2 9f             	and    $0xffffff9f,%edx
80106560:	88 14 c5 05 4f 11 80 	mov    %dl,-0x7feeb0fb(,%eax,8)
80106567:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010656a:	0f b6 14 c5 05 4f 11 	movzbl -0x7feeb0fb(,%eax,8),%edx
80106571:	80 
80106572:	83 ca 80             	or     $0xffffff80,%edx
80106575:	88 14 c5 05 4f 11 80 	mov    %dl,-0x7feeb0fb(,%eax,8)
8010657c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010657f:	8b 04 85 b4 e0 10 80 	mov    -0x7fef1f4c(,%eax,4),%eax
80106586:	c1 e8 10             	shr    $0x10,%eax
80106589:	89 c2                	mov    %eax,%edx
8010658b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010658e:	66 89 14 c5 06 4f 11 	mov    %dx,-0x7feeb0fa(,%eax,8)
80106595:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106596:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010659a:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
801065a1:	0f 8e 30 ff ff ff    	jle    801064d7 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801065a7:	a1 b4 e1 10 80       	mov    0x8010e1b4,%eax
801065ac:	66 a3 00 51 11 80    	mov    %ax,0x80115100
801065b2:	66 c7 05 02 51 11 80 	movw   $0x8,0x80115102
801065b9:	08 00 
801065bb:	0f b6 05 04 51 11 80 	movzbl 0x80115104,%eax
801065c2:	83 e0 e0             	and    $0xffffffe0,%eax
801065c5:	a2 04 51 11 80       	mov    %al,0x80115104
801065ca:	0f b6 05 04 51 11 80 	movzbl 0x80115104,%eax
801065d1:	83 e0 1f             	and    $0x1f,%eax
801065d4:	a2 04 51 11 80       	mov    %al,0x80115104
801065d9:	0f b6 05 05 51 11 80 	movzbl 0x80115105,%eax
801065e0:	83 c8 0f             	or     $0xf,%eax
801065e3:	a2 05 51 11 80       	mov    %al,0x80115105
801065e8:	0f b6 05 05 51 11 80 	movzbl 0x80115105,%eax
801065ef:	83 e0 ef             	and    $0xffffffef,%eax
801065f2:	a2 05 51 11 80       	mov    %al,0x80115105
801065f7:	0f b6 05 05 51 11 80 	movzbl 0x80115105,%eax
801065fe:	83 c8 60             	or     $0x60,%eax
80106601:	a2 05 51 11 80       	mov    %al,0x80115105
80106606:	0f b6 05 05 51 11 80 	movzbl 0x80115105,%eax
8010660d:	83 c8 80             	or     $0xffffff80,%eax
80106610:	a2 05 51 11 80       	mov    %al,0x80115105
80106615:	a1 b4 e1 10 80       	mov    0x8010e1b4,%eax
8010661a:	c1 e8 10             	shr    $0x10,%eax
8010661d:	66 a3 06 51 11 80    	mov    %ax,0x80115106
  
  initlock(&tickslock, "time");
80106623:	83 ec 08             	sub    $0x8,%esp
80106626:	68 dc b8 10 80       	push   $0x8010b8dc
8010662b:	68 c0 4e 11 80       	push   $0x80114ec0
80106630:	e8 1d e8 ff ff       	call   80104e52 <initlock>
80106635:	83 c4 10             	add    $0x10,%esp
}
80106638:	90                   	nop
80106639:	c9                   	leave  
8010663a:	c3                   	ret    

8010663b <idtinit>:

void
idtinit(void)
{
8010663b:	55                   	push   %ebp
8010663c:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
8010663e:	68 00 08 00 00       	push   $0x800
80106643:	68 00 4f 11 80       	push   $0x80114f00
80106648:	e8 3d fe ff ff       	call   8010648a <lidt>
8010664d:	83 c4 08             	add    $0x8,%esp
}
80106650:	90                   	nop
80106651:	c9                   	leave  
80106652:	c3                   	ret    

80106653 <trap>:
extern void TimerCount();

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106653:	55                   	push   %ebp
80106654:	89 e5                	mov    %esp,%ebp
80106656:	57                   	push   %edi
80106657:	56                   	push   %esi
80106658:	53                   	push   %ebx
80106659:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
8010665c:	8b 45 08             	mov    0x8(%ebp),%eax
8010665f:	8b 40 30             	mov    0x30(%eax),%eax
80106662:	83 f8 40             	cmp    $0x40,%eax
80106665:	75 3e                	jne    801066a5 <trap+0x52>
    if(proc->killed)
80106667:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010666d:	8b 40 24             	mov    0x24(%eax),%eax
80106670:	85 c0                	test   %eax,%eax
80106672:	74 05                	je     80106679 <trap+0x26>
      exit();
80106674:	e8 e3 e0 ff ff       	call   8010475c <exit>
    proc->tf = tf;
80106679:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010667f:	8b 55 08             	mov    0x8(%ebp),%edx
80106682:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80106685:	e8 28 ee ff ff       	call   801054b2 <syscall>
    if(proc->killed)
8010668a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106690:	8b 40 24             	mov    0x24(%eax),%eax
80106693:	85 c0                	test   %eax,%eax
80106695:	0f 84 35 02 00 00    	je     801068d0 <trap+0x27d>
      exit();
8010669b:	e8 bc e0 ff ff       	call   8010475c <exit>
    return;
801066a0:	e9 2b 02 00 00       	jmp    801068d0 <trap+0x27d>
  }

  switch(tf->trapno){
801066a5:	8b 45 08             	mov    0x8(%ebp),%eax
801066a8:	8b 40 30             	mov    0x30(%eax),%eax
801066ab:	83 e8 20             	sub    $0x20,%eax
801066ae:	83 f8 1f             	cmp    $0x1f,%eax
801066b1:	0f 87 da 00 00 00    	ja     80106791 <trap+0x13e>
801066b7:	8b 04 85 94 b9 10 80 	mov    -0x7fef466c(,%eax,4),%eax
801066be:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
801066c0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801066c6:	0f b6 00             	movzbl (%eax),%eax
801066c9:	84 c0                	test   %al,%al
801066cb:	75 3d                	jne    8010670a <trap+0xb7>
      acquire(&tickslock);
801066cd:	83 ec 0c             	sub    $0xc,%esp
801066d0:	68 c0 4e 11 80       	push   $0x80114ec0
801066d5:	e8 9a e7 ff ff       	call   80104e74 <acquire>
801066da:	83 c4 10             	add    $0x10,%esp
      ticks++;
801066dd:	a1 00 57 11 80       	mov    0x80115700,%eax
801066e2:	83 c0 01             	add    $0x1,%eax
801066e5:	a3 00 57 11 80       	mov    %eax,0x80115700
      wakeup(&ticks);
801066ea:	83 ec 0c             	sub    $0xc,%esp
801066ed:	68 00 57 11 80       	push   $0x80115700
801066f2:	e8 6f e5 ff ff       	call   80104c66 <wakeup>
801066f7:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
801066fa:	83 ec 0c             	sub    $0xc,%esp
801066fd:	68 c0 4e 11 80       	push   $0x80114ec0
80106702:	e8 d4 e7 ff ff       	call   80104edb <release>
80106707:	83 c4 10             	add    $0x10,%esp
    }
	//DealHandleMessage(ticks);
    TimerCount();
8010670a:	e8 d9 46 00 00       	call   8010ade8 <TimerCount>
    lapiceoi();
8010670f:	e8 de ca ff ff       	call   801031f2 <lapiceoi>
    break;
80106714:	e9 31 01 00 00       	jmp    8010684a <trap+0x1f7>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106719:	e8 b4 c1 ff ff       	call   801028d2 <ideintr>
    lapiceoi();
8010671e:	e8 cf ca ff ff       	call   801031f2 <lapiceoi>
    break;
80106723:	e9 22 01 00 00       	jmp    8010684a <trap+0x1f7>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    //cprintf("kbd pressed!\n");
    kbdintr();
80106728:	e8 ef c8 ff ff       	call   8010301c <kbdintr>
    lapiceoi();
8010672d:	e8 c0 ca ff ff       	call   801031f2 <lapiceoi>
    break;
80106732:	e9 13 01 00 00       	jmp    8010684a <trap+0x1f7>
  //  break;

  case T_IRQ0 + IRQ_MOUSE:
    //HandleInterupt();
    //lapiceoi();
     cprintf("mouse clicked!\n");
80106737:	83 ec 0c             	sub    $0xc,%esp
8010673a:	68 e1 b8 10 80       	push   $0x8010b8e1
8010673f:	e8 82 9c ff ff       	call   801003c6 <cprintf>
80106744:	83 c4 10             	add    $0x10,%esp
     break;
80106747:	e9 fe 00 00 00       	jmp    8010684a <trap+0x1f7>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
8010674c:	e8 60 03 00 00       	call   80106ab1 <uartintr>
    lapiceoi();
80106751:	e8 9c ca ff ff       	call   801031f2 <lapiceoi>
    break;
80106756:	e9 ef 00 00 00       	jmp    8010684a <trap+0x1f7>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010675b:	8b 45 08             	mov    0x8(%ebp),%eax
8010675e:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80106761:	8b 45 08             	mov    0x8(%ebp),%eax
80106764:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106768:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
8010676b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106771:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106774:	0f b6 c0             	movzbl %al,%eax
80106777:	51                   	push   %ecx
80106778:	52                   	push   %edx
80106779:	50                   	push   %eax
8010677a:	68 f4 b8 10 80       	push   $0x8010b8f4
8010677f:	e8 42 9c ff ff       	call   801003c6 <cprintf>
80106784:	83 c4 10             	add    $0x10,%esp
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
80106787:	e8 66 ca ff ff       	call   801031f2 <lapiceoi>
    break;
8010678c:	e9 b9 00 00 00       	jmp    8010684a <trap+0x1f7>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106791:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106797:	85 c0                	test   %eax,%eax
80106799:	74 11                	je     801067ac <trap+0x159>
8010679b:	8b 45 08             	mov    0x8(%ebp),%eax
8010679e:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801067a2:	0f b7 c0             	movzwl %ax,%eax
801067a5:	83 e0 03             	and    $0x3,%eax
801067a8:	85 c0                	test   %eax,%eax
801067aa:	75 40                	jne    801067ec <trap+0x199>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801067ac:	e8 03 fd ff ff       	call   801064b4 <rcr2>
801067b1:	89 c3                	mov    %eax,%ebx
801067b3:	8b 45 08             	mov    0x8(%ebp),%eax
801067b6:	8b 48 38             	mov    0x38(%eax),%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
801067b9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801067bf:	0f b6 00             	movzbl (%eax),%eax
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801067c2:	0f b6 d0             	movzbl %al,%edx
801067c5:	8b 45 08             	mov    0x8(%ebp),%eax
801067c8:	8b 40 30             	mov    0x30(%eax),%eax
801067cb:	83 ec 0c             	sub    $0xc,%esp
801067ce:	53                   	push   %ebx
801067cf:	51                   	push   %ecx
801067d0:	52                   	push   %edx
801067d1:	50                   	push   %eax
801067d2:	68 18 b9 10 80       	push   $0x8010b918
801067d7:	e8 ea 9b ff ff       	call   801003c6 <cprintf>
801067dc:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
801067df:	83 ec 0c             	sub    $0xc,%esp
801067e2:	68 4a b9 10 80       	push   $0x8010b94a
801067e7:	e8 7a 9d ff ff       	call   80100566 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801067ec:	e8 c3 fc ff ff       	call   801064b4 <rcr2>
801067f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801067f4:	8b 45 08             	mov    0x8(%ebp),%eax
801067f7:	8b 70 38             	mov    0x38(%eax),%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801067fa:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106800:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106803:	0f b6 d8             	movzbl %al,%ebx
80106806:	8b 45 08             	mov    0x8(%ebp),%eax
80106809:	8b 48 34             	mov    0x34(%eax),%ecx
8010680c:	8b 45 08             	mov    0x8(%ebp),%eax
8010680f:	8b 50 30             	mov    0x30(%eax),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106812:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106818:	8d 78 6c             	lea    0x6c(%eax),%edi
8010681b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106821:	8b 40 10             	mov    0x10(%eax),%eax
80106824:	ff 75 e4             	pushl  -0x1c(%ebp)
80106827:	56                   	push   %esi
80106828:	53                   	push   %ebx
80106829:	51                   	push   %ecx
8010682a:	52                   	push   %edx
8010682b:	57                   	push   %edi
8010682c:	50                   	push   %eax
8010682d:	68 50 b9 10 80       	push   $0x8010b950
80106832:	e8 8f 9b ff ff       	call   801003c6 <cprintf>
80106837:	83 c4 20             	add    $0x20,%esp
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
8010683a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106840:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106847:	eb 01                	jmp    8010684a <trap+0x1f7>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106849:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
8010684a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106850:	85 c0                	test   %eax,%eax
80106852:	74 24                	je     80106878 <trap+0x225>
80106854:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010685a:	8b 40 24             	mov    0x24(%eax),%eax
8010685d:	85 c0                	test   %eax,%eax
8010685f:	74 17                	je     80106878 <trap+0x225>
80106861:	8b 45 08             	mov    0x8(%ebp),%eax
80106864:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106868:	0f b7 c0             	movzwl %ax,%eax
8010686b:	83 e0 03             	and    $0x3,%eax
8010686e:	83 f8 03             	cmp    $0x3,%eax
80106871:	75 05                	jne    80106878 <trap+0x225>
    exit();
80106873:	e8 e4 de ff ff       	call   8010475c <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106878:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010687e:	85 c0                	test   %eax,%eax
80106880:	74 1e                	je     801068a0 <trap+0x24d>
80106882:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106888:	8b 40 0c             	mov    0xc(%eax),%eax
8010688b:	83 f8 04             	cmp    $0x4,%eax
8010688e:	75 10                	jne    801068a0 <trap+0x24d>
80106890:	8b 45 08             	mov    0x8(%ebp),%eax
80106893:	8b 40 30             	mov    0x30(%eax),%eax
80106896:	83 f8 20             	cmp    $0x20,%eax
80106899:	75 05                	jne    801068a0 <trap+0x24d>
    yield();
8010689b:	e8 6f e2 ff ff       	call   80104b0f <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
801068a0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068a6:	85 c0                	test   %eax,%eax
801068a8:	74 27                	je     801068d1 <trap+0x27e>
801068aa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068b0:	8b 40 24             	mov    0x24(%eax),%eax
801068b3:	85 c0                	test   %eax,%eax
801068b5:	74 1a                	je     801068d1 <trap+0x27e>
801068b7:	8b 45 08             	mov    0x8(%ebp),%eax
801068ba:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801068be:	0f b7 c0             	movzwl %ax,%eax
801068c1:	83 e0 03             	and    $0x3,%eax
801068c4:	83 f8 03             	cmp    $0x3,%eax
801068c7:	75 08                	jne    801068d1 <trap+0x27e>
    exit();
801068c9:	e8 8e de ff ff       	call   8010475c <exit>
801068ce:	eb 01                	jmp    801068d1 <trap+0x27e>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
801068d0:	90                   	nop
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
801068d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068d4:	5b                   	pop    %ebx
801068d5:	5e                   	pop    %esi
801068d6:	5f                   	pop    %edi
801068d7:	5d                   	pop    %ebp
801068d8:	c3                   	ret    

801068d9 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801068d9:	55                   	push   %ebp
801068da:	89 e5                	mov    %esp,%ebp
801068dc:	83 ec 14             	sub    $0x14,%esp
801068df:	8b 45 08             	mov    0x8(%ebp),%eax
801068e2:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801068e6:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801068ea:	89 c2                	mov    %eax,%edx
801068ec:	ec                   	in     (%dx),%al
801068ed:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801068f0:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801068f4:	c9                   	leave  
801068f5:	c3                   	ret    

801068f6 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801068f6:	55                   	push   %ebp
801068f7:	89 e5                	mov    %esp,%ebp
801068f9:	83 ec 08             	sub    $0x8,%esp
801068fc:	8b 55 08             	mov    0x8(%ebp),%edx
801068ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80106902:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106906:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106909:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010690d:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106911:	ee                   	out    %al,(%dx)
}
80106912:	90                   	nop
80106913:	c9                   	leave  
80106914:	c3                   	ret    

80106915 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106915:	55                   	push   %ebp
80106916:	89 e5                	mov    %esp,%ebp
80106918:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
8010691b:	6a 00                	push   $0x0
8010691d:	68 fa 03 00 00       	push   $0x3fa
80106922:	e8 cf ff ff ff       	call   801068f6 <outb>
80106927:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
8010692a:	68 80 00 00 00       	push   $0x80
8010692f:	68 fb 03 00 00       	push   $0x3fb
80106934:	e8 bd ff ff ff       	call   801068f6 <outb>
80106939:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
8010693c:	6a 0c                	push   $0xc
8010693e:	68 f8 03 00 00       	push   $0x3f8
80106943:	e8 ae ff ff ff       	call   801068f6 <outb>
80106948:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
8010694b:	6a 00                	push   $0x0
8010694d:	68 f9 03 00 00       	push   $0x3f9
80106952:	e8 9f ff ff ff       	call   801068f6 <outb>
80106957:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
8010695a:	6a 03                	push   $0x3
8010695c:	68 fb 03 00 00       	push   $0x3fb
80106961:	e8 90 ff ff ff       	call   801068f6 <outb>
80106966:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106969:	6a 00                	push   $0x0
8010696b:	68 fc 03 00 00       	push   $0x3fc
80106970:	e8 81 ff ff ff       	call   801068f6 <outb>
80106975:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106978:	6a 01                	push   $0x1
8010697a:	68 f9 03 00 00       	push   $0x3f9
8010697f:	e8 72 ff ff ff       	call   801068f6 <outb>
80106984:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106987:	68 fd 03 00 00       	push   $0x3fd
8010698c:	e8 48 ff ff ff       	call   801068d9 <inb>
80106991:	83 c4 04             	add    $0x4,%esp
80106994:	3c ff                	cmp    $0xff,%al
80106996:	74 6e                	je     80106a06 <uartinit+0xf1>
    return;
  uart = 1;
80106998:	c7 05 90 e6 10 80 01 	movl   $0x1,0x8010e690
8010699f:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
801069a2:	68 fa 03 00 00       	push   $0x3fa
801069a7:	e8 2d ff ff ff       	call   801068d9 <inb>
801069ac:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
801069af:	68 f8 03 00 00       	push   $0x3f8
801069b4:	e8 20 ff ff ff       	call   801068d9 <inb>
801069b9:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
801069bc:	83 ec 0c             	sub    $0xc,%esp
801069bf:	6a 04                	push   $0x4
801069c1:	e8 19 d4 ff ff       	call   80103ddf <picenable>
801069c6:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
801069c9:	83 ec 08             	sub    $0x8,%esp
801069cc:	6a 00                	push   $0x0
801069ce:	6a 04                	push   $0x4
801069d0:	e8 9f c1 ff ff       	call   80102b74 <ioapicenable>
801069d5:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801069d8:	c7 45 f4 14 ba 10 80 	movl   $0x8010ba14,-0xc(%ebp)
801069df:	eb 19                	jmp    801069fa <uartinit+0xe5>
    uartputc(*p);
801069e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069e4:	0f b6 00             	movzbl (%eax),%eax
801069e7:	0f be c0             	movsbl %al,%eax
801069ea:	83 ec 0c             	sub    $0xc,%esp
801069ed:	50                   	push   %eax
801069ee:	e8 16 00 00 00       	call   80106a09 <uartputc>
801069f3:	83 c4 10             	add    $0x10,%esp
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801069f6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801069fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069fd:	0f b6 00             	movzbl (%eax),%eax
80106a00:	84 c0                	test   %al,%al
80106a02:	75 dd                	jne    801069e1 <uartinit+0xcc>
80106a04:	eb 01                	jmp    80106a07 <uartinit+0xf2>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
80106a06:	90                   	nop
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
80106a07:	c9                   	leave  
80106a08:	c3                   	ret    

80106a09 <uartputc>:

void
uartputc(int c)
{
80106a09:	55                   	push   %ebp
80106a0a:	89 e5                	mov    %esp,%ebp
80106a0c:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
80106a0f:	a1 90 e6 10 80       	mov    0x8010e690,%eax
80106a14:	85 c0                	test   %eax,%eax
80106a16:	74 53                	je     80106a6b <uartputc+0x62>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106a18:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106a1f:	eb 11                	jmp    80106a32 <uartputc+0x29>
    microdelay(10);
80106a21:	83 ec 0c             	sub    $0xc,%esp
80106a24:	6a 0a                	push   $0xa
80106a26:	e8 e2 c7 ff ff       	call   8010320d <microdelay>
80106a2b:	83 c4 10             	add    $0x10,%esp
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106a2e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106a32:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106a36:	7f 1a                	jg     80106a52 <uartputc+0x49>
80106a38:	83 ec 0c             	sub    $0xc,%esp
80106a3b:	68 fd 03 00 00       	push   $0x3fd
80106a40:	e8 94 fe ff ff       	call   801068d9 <inb>
80106a45:	83 c4 10             	add    $0x10,%esp
80106a48:	0f b6 c0             	movzbl %al,%eax
80106a4b:	83 e0 20             	and    $0x20,%eax
80106a4e:	85 c0                	test   %eax,%eax
80106a50:	74 cf                	je     80106a21 <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
80106a52:	8b 45 08             	mov    0x8(%ebp),%eax
80106a55:	0f b6 c0             	movzbl %al,%eax
80106a58:	83 ec 08             	sub    $0x8,%esp
80106a5b:	50                   	push   %eax
80106a5c:	68 f8 03 00 00       	push   $0x3f8
80106a61:	e8 90 fe ff ff       	call   801068f6 <outb>
80106a66:	83 c4 10             	add    $0x10,%esp
80106a69:	eb 01                	jmp    80106a6c <uartputc+0x63>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
80106a6b:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106a6c:	c9                   	leave  
80106a6d:	c3                   	ret    

80106a6e <uartgetc>:

static int
uartgetc(void)
{
80106a6e:	55                   	push   %ebp
80106a6f:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106a71:	a1 90 e6 10 80       	mov    0x8010e690,%eax
80106a76:	85 c0                	test   %eax,%eax
80106a78:	75 07                	jne    80106a81 <uartgetc+0x13>
    return -1;
80106a7a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a7f:	eb 2e                	jmp    80106aaf <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80106a81:	68 fd 03 00 00       	push   $0x3fd
80106a86:	e8 4e fe ff ff       	call   801068d9 <inb>
80106a8b:	83 c4 04             	add    $0x4,%esp
80106a8e:	0f b6 c0             	movzbl %al,%eax
80106a91:	83 e0 01             	and    $0x1,%eax
80106a94:	85 c0                	test   %eax,%eax
80106a96:	75 07                	jne    80106a9f <uartgetc+0x31>
    return -1;
80106a98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a9d:	eb 10                	jmp    80106aaf <uartgetc+0x41>
  return inb(COM1+0);
80106a9f:	68 f8 03 00 00       	push   $0x3f8
80106aa4:	e8 30 fe ff ff       	call   801068d9 <inb>
80106aa9:	83 c4 04             	add    $0x4,%esp
80106aac:	0f b6 c0             	movzbl %al,%eax
}
80106aaf:	c9                   	leave  
80106ab0:	c3                   	ret    

80106ab1 <uartintr>:

void
uartintr(void)
{
80106ab1:	55                   	push   %ebp
80106ab2:	89 e5                	mov    %esp,%ebp
80106ab4:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80106ab7:	83 ec 0c             	sub    $0xc,%esp
80106aba:	68 6e 6a 10 80       	push   $0x80106a6e
80106abf:	e8 19 9d ff ff       	call   801007dd <consoleintr>
80106ac4:	83 c4 10             	add    $0x10,%esp
}
80106ac7:	90                   	nop
80106ac8:	c9                   	leave  
80106ac9:	c3                   	ret    

80106aca <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106aca:	6a 00                	push   $0x0
  pushl $0
80106acc:	6a 00                	push   $0x0
  jmp alltraps
80106ace:	e9 8c f9 ff ff       	jmp    8010645f <alltraps>

80106ad3 <vector1>:
.globl vector1
vector1:
  pushl $0
80106ad3:	6a 00                	push   $0x0
  pushl $1
80106ad5:	6a 01                	push   $0x1
  jmp alltraps
80106ad7:	e9 83 f9 ff ff       	jmp    8010645f <alltraps>

80106adc <vector2>:
.globl vector2
vector2:
  pushl $0
80106adc:	6a 00                	push   $0x0
  pushl $2
80106ade:	6a 02                	push   $0x2
  jmp alltraps
80106ae0:	e9 7a f9 ff ff       	jmp    8010645f <alltraps>

80106ae5 <vector3>:
.globl vector3
vector3:
  pushl $0
80106ae5:	6a 00                	push   $0x0
  pushl $3
80106ae7:	6a 03                	push   $0x3
  jmp alltraps
80106ae9:	e9 71 f9 ff ff       	jmp    8010645f <alltraps>

80106aee <vector4>:
.globl vector4
vector4:
  pushl $0
80106aee:	6a 00                	push   $0x0
  pushl $4
80106af0:	6a 04                	push   $0x4
  jmp alltraps
80106af2:	e9 68 f9 ff ff       	jmp    8010645f <alltraps>

80106af7 <vector5>:
.globl vector5
vector5:
  pushl $0
80106af7:	6a 00                	push   $0x0
  pushl $5
80106af9:	6a 05                	push   $0x5
  jmp alltraps
80106afb:	e9 5f f9 ff ff       	jmp    8010645f <alltraps>

80106b00 <vector6>:
.globl vector6
vector6:
  pushl $0
80106b00:	6a 00                	push   $0x0
  pushl $6
80106b02:	6a 06                	push   $0x6
  jmp alltraps
80106b04:	e9 56 f9 ff ff       	jmp    8010645f <alltraps>

80106b09 <vector7>:
.globl vector7
vector7:
  pushl $0
80106b09:	6a 00                	push   $0x0
  pushl $7
80106b0b:	6a 07                	push   $0x7
  jmp alltraps
80106b0d:	e9 4d f9 ff ff       	jmp    8010645f <alltraps>

80106b12 <vector8>:
.globl vector8
vector8:
  pushl $8
80106b12:	6a 08                	push   $0x8
  jmp alltraps
80106b14:	e9 46 f9 ff ff       	jmp    8010645f <alltraps>

80106b19 <vector9>:
.globl vector9
vector9:
  pushl $0
80106b19:	6a 00                	push   $0x0
  pushl $9
80106b1b:	6a 09                	push   $0x9
  jmp alltraps
80106b1d:	e9 3d f9 ff ff       	jmp    8010645f <alltraps>

80106b22 <vector10>:
.globl vector10
vector10:
  pushl $10
80106b22:	6a 0a                	push   $0xa
  jmp alltraps
80106b24:	e9 36 f9 ff ff       	jmp    8010645f <alltraps>

80106b29 <vector11>:
.globl vector11
vector11:
  pushl $11
80106b29:	6a 0b                	push   $0xb
  jmp alltraps
80106b2b:	e9 2f f9 ff ff       	jmp    8010645f <alltraps>

80106b30 <vector12>:
.globl vector12
vector12:
  pushl $12
80106b30:	6a 0c                	push   $0xc
  jmp alltraps
80106b32:	e9 28 f9 ff ff       	jmp    8010645f <alltraps>

80106b37 <vector13>:
.globl vector13
vector13:
  pushl $13
80106b37:	6a 0d                	push   $0xd
  jmp alltraps
80106b39:	e9 21 f9 ff ff       	jmp    8010645f <alltraps>

80106b3e <vector14>:
.globl vector14
vector14:
  pushl $14
80106b3e:	6a 0e                	push   $0xe
  jmp alltraps
80106b40:	e9 1a f9 ff ff       	jmp    8010645f <alltraps>

80106b45 <vector15>:
.globl vector15
vector15:
  pushl $0
80106b45:	6a 00                	push   $0x0
  pushl $15
80106b47:	6a 0f                	push   $0xf
  jmp alltraps
80106b49:	e9 11 f9 ff ff       	jmp    8010645f <alltraps>

80106b4e <vector16>:
.globl vector16
vector16:
  pushl $0
80106b4e:	6a 00                	push   $0x0
  pushl $16
80106b50:	6a 10                	push   $0x10
  jmp alltraps
80106b52:	e9 08 f9 ff ff       	jmp    8010645f <alltraps>

80106b57 <vector17>:
.globl vector17
vector17:
  pushl $17
80106b57:	6a 11                	push   $0x11
  jmp alltraps
80106b59:	e9 01 f9 ff ff       	jmp    8010645f <alltraps>

80106b5e <vector18>:
.globl vector18
vector18:
  pushl $0
80106b5e:	6a 00                	push   $0x0
  pushl $18
80106b60:	6a 12                	push   $0x12
  jmp alltraps
80106b62:	e9 f8 f8 ff ff       	jmp    8010645f <alltraps>

80106b67 <vector19>:
.globl vector19
vector19:
  pushl $0
80106b67:	6a 00                	push   $0x0
  pushl $19
80106b69:	6a 13                	push   $0x13
  jmp alltraps
80106b6b:	e9 ef f8 ff ff       	jmp    8010645f <alltraps>

80106b70 <vector20>:
.globl vector20
vector20:
  pushl $0
80106b70:	6a 00                	push   $0x0
  pushl $20
80106b72:	6a 14                	push   $0x14
  jmp alltraps
80106b74:	e9 e6 f8 ff ff       	jmp    8010645f <alltraps>

80106b79 <vector21>:
.globl vector21
vector21:
  pushl $0
80106b79:	6a 00                	push   $0x0
  pushl $21
80106b7b:	6a 15                	push   $0x15
  jmp alltraps
80106b7d:	e9 dd f8 ff ff       	jmp    8010645f <alltraps>

80106b82 <vector22>:
.globl vector22
vector22:
  pushl $0
80106b82:	6a 00                	push   $0x0
  pushl $22
80106b84:	6a 16                	push   $0x16
  jmp alltraps
80106b86:	e9 d4 f8 ff ff       	jmp    8010645f <alltraps>

80106b8b <vector23>:
.globl vector23
vector23:
  pushl $0
80106b8b:	6a 00                	push   $0x0
  pushl $23
80106b8d:	6a 17                	push   $0x17
  jmp alltraps
80106b8f:	e9 cb f8 ff ff       	jmp    8010645f <alltraps>

80106b94 <vector24>:
.globl vector24
vector24:
  pushl $0
80106b94:	6a 00                	push   $0x0
  pushl $24
80106b96:	6a 18                	push   $0x18
  jmp alltraps
80106b98:	e9 c2 f8 ff ff       	jmp    8010645f <alltraps>

80106b9d <vector25>:
.globl vector25
vector25:
  pushl $0
80106b9d:	6a 00                	push   $0x0
  pushl $25
80106b9f:	6a 19                	push   $0x19
  jmp alltraps
80106ba1:	e9 b9 f8 ff ff       	jmp    8010645f <alltraps>

80106ba6 <vector26>:
.globl vector26
vector26:
  pushl $0
80106ba6:	6a 00                	push   $0x0
  pushl $26
80106ba8:	6a 1a                	push   $0x1a
  jmp alltraps
80106baa:	e9 b0 f8 ff ff       	jmp    8010645f <alltraps>

80106baf <vector27>:
.globl vector27
vector27:
  pushl $0
80106baf:	6a 00                	push   $0x0
  pushl $27
80106bb1:	6a 1b                	push   $0x1b
  jmp alltraps
80106bb3:	e9 a7 f8 ff ff       	jmp    8010645f <alltraps>

80106bb8 <vector28>:
.globl vector28
vector28:
  pushl $0
80106bb8:	6a 00                	push   $0x0
  pushl $28
80106bba:	6a 1c                	push   $0x1c
  jmp alltraps
80106bbc:	e9 9e f8 ff ff       	jmp    8010645f <alltraps>

80106bc1 <vector29>:
.globl vector29
vector29:
  pushl $0
80106bc1:	6a 00                	push   $0x0
  pushl $29
80106bc3:	6a 1d                	push   $0x1d
  jmp alltraps
80106bc5:	e9 95 f8 ff ff       	jmp    8010645f <alltraps>

80106bca <vector30>:
.globl vector30
vector30:
  pushl $0
80106bca:	6a 00                	push   $0x0
  pushl $30
80106bcc:	6a 1e                	push   $0x1e
  jmp alltraps
80106bce:	e9 8c f8 ff ff       	jmp    8010645f <alltraps>

80106bd3 <vector31>:
.globl vector31
vector31:
  pushl $0
80106bd3:	6a 00                	push   $0x0
  pushl $31
80106bd5:	6a 1f                	push   $0x1f
  jmp alltraps
80106bd7:	e9 83 f8 ff ff       	jmp    8010645f <alltraps>

80106bdc <vector32>:
.globl vector32
vector32:
  pushl $0
80106bdc:	6a 00                	push   $0x0
  pushl $32
80106bde:	6a 20                	push   $0x20
  jmp alltraps
80106be0:	e9 7a f8 ff ff       	jmp    8010645f <alltraps>

80106be5 <vector33>:
.globl vector33
vector33:
  pushl $0
80106be5:	6a 00                	push   $0x0
  pushl $33
80106be7:	6a 21                	push   $0x21
  jmp alltraps
80106be9:	e9 71 f8 ff ff       	jmp    8010645f <alltraps>

80106bee <vector34>:
.globl vector34
vector34:
  pushl $0
80106bee:	6a 00                	push   $0x0
  pushl $34
80106bf0:	6a 22                	push   $0x22
  jmp alltraps
80106bf2:	e9 68 f8 ff ff       	jmp    8010645f <alltraps>

80106bf7 <vector35>:
.globl vector35
vector35:
  pushl $0
80106bf7:	6a 00                	push   $0x0
  pushl $35
80106bf9:	6a 23                	push   $0x23
  jmp alltraps
80106bfb:	e9 5f f8 ff ff       	jmp    8010645f <alltraps>

80106c00 <vector36>:
.globl vector36
vector36:
  pushl $0
80106c00:	6a 00                	push   $0x0
  pushl $36
80106c02:	6a 24                	push   $0x24
  jmp alltraps
80106c04:	e9 56 f8 ff ff       	jmp    8010645f <alltraps>

80106c09 <vector37>:
.globl vector37
vector37:
  pushl $0
80106c09:	6a 00                	push   $0x0
  pushl $37
80106c0b:	6a 25                	push   $0x25
  jmp alltraps
80106c0d:	e9 4d f8 ff ff       	jmp    8010645f <alltraps>

80106c12 <vector38>:
.globl vector38
vector38:
  pushl $0
80106c12:	6a 00                	push   $0x0
  pushl $38
80106c14:	6a 26                	push   $0x26
  jmp alltraps
80106c16:	e9 44 f8 ff ff       	jmp    8010645f <alltraps>

80106c1b <vector39>:
.globl vector39
vector39:
  pushl $0
80106c1b:	6a 00                	push   $0x0
  pushl $39
80106c1d:	6a 27                	push   $0x27
  jmp alltraps
80106c1f:	e9 3b f8 ff ff       	jmp    8010645f <alltraps>

80106c24 <vector40>:
.globl vector40
vector40:
  pushl $0
80106c24:	6a 00                	push   $0x0
  pushl $40
80106c26:	6a 28                	push   $0x28
  jmp alltraps
80106c28:	e9 32 f8 ff ff       	jmp    8010645f <alltraps>

80106c2d <vector41>:
.globl vector41
vector41:
  pushl $0
80106c2d:	6a 00                	push   $0x0
  pushl $41
80106c2f:	6a 29                	push   $0x29
  jmp alltraps
80106c31:	e9 29 f8 ff ff       	jmp    8010645f <alltraps>

80106c36 <vector42>:
.globl vector42
vector42:
  pushl $0
80106c36:	6a 00                	push   $0x0
  pushl $42
80106c38:	6a 2a                	push   $0x2a
  jmp alltraps
80106c3a:	e9 20 f8 ff ff       	jmp    8010645f <alltraps>

80106c3f <vector43>:
.globl vector43
vector43:
  pushl $0
80106c3f:	6a 00                	push   $0x0
  pushl $43
80106c41:	6a 2b                	push   $0x2b
  jmp alltraps
80106c43:	e9 17 f8 ff ff       	jmp    8010645f <alltraps>

80106c48 <vector44>:
.globl vector44
vector44:
  pushl $0
80106c48:	6a 00                	push   $0x0
  pushl $44
80106c4a:	6a 2c                	push   $0x2c
  jmp alltraps
80106c4c:	e9 0e f8 ff ff       	jmp    8010645f <alltraps>

80106c51 <vector45>:
.globl vector45
vector45:
  pushl $0
80106c51:	6a 00                	push   $0x0
  pushl $45
80106c53:	6a 2d                	push   $0x2d
  jmp alltraps
80106c55:	e9 05 f8 ff ff       	jmp    8010645f <alltraps>

80106c5a <vector46>:
.globl vector46
vector46:
  pushl $0
80106c5a:	6a 00                	push   $0x0
  pushl $46
80106c5c:	6a 2e                	push   $0x2e
  jmp alltraps
80106c5e:	e9 fc f7 ff ff       	jmp    8010645f <alltraps>

80106c63 <vector47>:
.globl vector47
vector47:
  pushl $0
80106c63:	6a 00                	push   $0x0
  pushl $47
80106c65:	6a 2f                	push   $0x2f
  jmp alltraps
80106c67:	e9 f3 f7 ff ff       	jmp    8010645f <alltraps>

80106c6c <vector48>:
.globl vector48
vector48:
  pushl $0
80106c6c:	6a 00                	push   $0x0
  pushl $48
80106c6e:	6a 30                	push   $0x30
  jmp alltraps
80106c70:	e9 ea f7 ff ff       	jmp    8010645f <alltraps>

80106c75 <vector49>:
.globl vector49
vector49:
  pushl $0
80106c75:	6a 00                	push   $0x0
  pushl $49
80106c77:	6a 31                	push   $0x31
  jmp alltraps
80106c79:	e9 e1 f7 ff ff       	jmp    8010645f <alltraps>

80106c7e <vector50>:
.globl vector50
vector50:
  pushl $0
80106c7e:	6a 00                	push   $0x0
  pushl $50
80106c80:	6a 32                	push   $0x32
  jmp alltraps
80106c82:	e9 d8 f7 ff ff       	jmp    8010645f <alltraps>

80106c87 <vector51>:
.globl vector51
vector51:
  pushl $0
80106c87:	6a 00                	push   $0x0
  pushl $51
80106c89:	6a 33                	push   $0x33
  jmp alltraps
80106c8b:	e9 cf f7 ff ff       	jmp    8010645f <alltraps>

80106c90 <vector52>:
.globl vector52
vector52:
  pushl $0
80106c90:	6a 00                	push   $0x0
  pushl $52
80106c92:	6a 34                	push   $0x34
  jmp alltraps
80106c94:	e9 c6 f7 ff ff       	jmp    8010645f <alltraps>

80106c99 <vector53>:
.globl vector53
vector53:
  pushl $0
80106c99:	6a 00                	push   $0x0
  pushl $53
80106c9b:	6a 35                	push   $0x35
  jmp alltraps
80106c9d:	e9 bd f7 ff ff       	jmp    8010645f <alltraps>

80106ca2 <vector54>:
.globl vector54
vector54:
  pushl $0
80106ca2:	6a 00                	push   $0x0
  pushl $54
80106ca4:	6a 36                	push   $0x36
  jmp alltraps
80106ca6:	e9 b4 f7 ff ff       	jmp    8010645f <alltraps>

80106cab <vector55>:
.globl vector55
vector55:
  pushl $0
80106cab:	6a 00                	push   $0x0
  pushl $55
80106cad:	6a 37                	push   $0x37
  jmp alltraps
80106caf:	e9 ab f7 ff ff       	jmp    8010645f <alltraps>

80106cb4 <vector56>:
.globl vector56
vector56:
  pushl $0
80106cb4:	6a 00                	push   $0x0
  pushl $56
80106cb6:	6a 38                	push   $0x38
  jmp alltraps
80106cb8:	e9 a2 f7 ff ff       	jmp    8010645f <alltraps>

80106cbd <vector57>:
.globl vector57
vector57:
  pushl $0
80106cbd:	6a 00                	push   $0x0
  pushl $57
80106cbf:	6a 39                	push   $0x39
  jmp alltraps
80106cc1:	e9 99 f7 ff ff       	jmp    8010645f <alltraps>

80106cc6 <vector58>:
.globl vector58
vector58:
  pushl $0
80106cc6:	6a 00                	push   $0x0
  pushl $58
80106cc8:	6a 3a                	push   $0x3a
  jmp alltraps
80106cca:	e9 90 f7 ff ff       	jmp    8010645f <alltraps>

80106ccf <vector59>:
.globl vector59
vector59:
  pushl $0
80106ccf:	6a 00                	push   $0x0
  pushl $59
80106cd1:	6a 3b                	push   $0x3b
  jmp alltraps
80106cd3:	e9 87 f7 ff ff       	jmp    8010645f <alltraps>

80106cd8 <vector60>:
.globl vector60
vector60:
  pushl $0
80106cd8:	6a 00                	push   $0x0
  pushl $60
80106cda:	6a 3c                	push   $0x3c
  jmp alltraps
80106cdc:	e9 7e f7 ff ff       	jmp    8010645f <alltraps>

80106ce1 <vector61>:
.globl vector61
vector61:
  pushl $0
80106ce1:	6a 00                	push   $0x0
  pushl $61
80106ce3:	6a 3d                	push   $0x3d
  jmp alltraps
80106ce5:	e9 75 f7 ff ff       	jmp    8010645f <alltraps>

80106cea <vector62>:
.globl vector62
vector62:
  pushl $0
80106cea:	6a 00                	push   $0x0
  pushl $62
80106cec:	6a 3e                	push   $0x3e
  jmp alltraps
80106cee:	e9 6c f7 ff ff       	jmp    8010645f <alltraps>

80106cf3 <vector63>:
.globl vector63
vector63:
  pushl $0
80106cf3:	6a 00                	push   $0x0
  pushl $63
80106cf5:	6a 3f                	push   $0x3f
  jmp alltraps
80106cf7:	e9 63 f7 ff ff       	jmp    8010645f <alltraps>

80106cfc <vector64>:
.globl vector64
vector64:
  pushl $0
80106cfc:	6a 00                	push   $0x0
  pushl $64
80106cfe:	6a 40                	push   $0x40
  jmp alltraps
80106d00:	e9 5a f7 ff ff       	jmp    8010645f <alltraps>

80106d05 <vector65>:
.globl vector65
vector65:
  pushl $0
80106d05:	6a 00                	push   $0x0
  pushl $65
80106d07:	6a 41                	push   $0x41
  jmp alltraps
80106d09:	e9 51 f7 ff ff       	jmp    8010645f <alltraps>

80106d0e <vector66>:
.globl vector66
vector66:
  pushl $0
80106d0e:	6a 00                	push   $0x0
  pushl $66
80106d10:	6a 42                	push   $0x42
  jmp alltraps
80106d12:	e9 48 f7 ff ff       	jmp    8010645f <alltraps>

80106d17 <vector67>:
.globl vector67
vector67:
  pushl $0
80106d17:	6a 00                	push   $0x0
  pushl $67
80106d19:	6a 43                	push   $0x43
  jmp alltraps
80106d1b:	e9 3f f7 ff ff       	jmp    8010645f <alltraps>

80106d20 <vector68>:
.globl vector68
vector68:
  pushl $0
80106d20:	6a 00                	push   $0x0
  pushl $68
80106d22:	6a 44                	push   $0x44
  jmp alltraps
80106d24:	e9 36 f7 ff ff       	jmp    8010645f <alltraps>

80106d29 <vector69>:
.globl vector69
vector69:
  pushl $0
80106d29:	6a 00                	push   $0x0
  pushl $69
80106d2b:	6a 45                	push   $0x45
  jmp alltraps
80106d2d:	e9 2d f7 ff ff       	jmp    8010645f <alltraps>

80106d32 <vector70>:
.globl vector70
vector70:
  pushl $0
80106d32:	6a 00                	push   $0x0
  pushl $70
80106d34:	6a 46                	push   $0x46
  jmp alltraps
80106d36:	e9 24 f7 ff ff       	jmp    8010645f <alltraps>

80106d3b <vector71>:
.globl vector71
vector71:
  pushl $0
80106d3b:	6a 00                	push   $0x0
  pushl $71
80106d3d:	6a 47                	push   $0x47
  jmp alltraps
80106d3f:	e9 1b f7 ff ff       	jmp    8010645f <alltraps>

80106d44 <vector72>:
.globl vector72
vector72:
  pushl $0
80106d44:	6a 00                	push   $0x0
  pushl $72
80106d46:	6a 48                	push   $0x48
  jmp alltraps
80106d48:	e9 12 f7 ff ff       	jmp    8010645f <alltraps>

80106d4d <vector73>:
.globl vector73
vector73:
  pushl $0
80106d4d:	6a 00                	push   $0x0
  pushl $73
80106d4f:	6a 49                	push   $0x49
  jmp alltraps
80106d51:	e9 09 f7 ff ff       	jmp    8010645f <alltraps>

80106d56 <vector74>:
.globl vector74
vector74:
  pushl $0
80106d56:	6a 00                	push   $0x0
  pushl $74
80106d58:	6a 4a                	push   $0x4a
  jmp alltraps
80106d5a:	e9 00 f7 ff ff       	jmp    8010645f <alltraps>

80106d5f <vector75>:
.globl vector75
vector75:
  pushl $0
80106d5f:	6a 00                	push   $0x0
  pushl $75
80106d61:	6a 4b                	push   $0x4b
  jmp alltraps
80106d63:	e9 f7 f6 ff ff       	jmp    8010645f <alltraps>

80106d68 <vector76>:
.globl vector76
vector76:
  pushl $0
80106d68:	6a 00                	push   $0x0
  pushl $76
80106d6a:	6a 4c                	push   $0x4c
  jmp alltraps
80106d6c:	e9 ee f6 ff ff       	jmp    8010645f <alltraps>

80106d71 <vector77>:
.globl vector77
vector77:
  pushl $0
80106d71:	6a 00                	push   $0x0
  pushl $77
80106d73:	6a 4d                	push   $0x4d
  jmp alltraps
80106d75:	e9 e5 f6 ff ff       	jmp    8010645f <alltraps>

80106d7a <vector78>:
.globl vector78
vector78:
  pushl $0
80106d7a:	6a 00                	push   $0x0
  pushl $78
80106d7c:	6a 4e                	push   $0x4e
  jmp alltraps
80106d7e:	e9 dc f6 ff ff       	jmp    8010645f <alltraps>

80106d83 <vector79>:
.globl vector79
vector79:
  pushl $0
80106d83:	6a 00                	push   $0x0
  pushl $79
80106d85:	6a 4f                	push   $0x4f
  jmp alltraps
80106d87:	e9 d3 f6 ff ff       	jmp    8010645f <alltraps>

80106d8c <vector80>:
.globl vector80
vector80:
  pushl $0
80106d8c:	6a 00                	push   $0x0
  pushl $80
80106d8e:	6a 50                	push   $0x50
  jmp alltraps
80106d90:	e9 ca f6 ff ff       	jmp    8010645f <alltraps>

80106d95 <vector81>:
.globl vector81
vector81:
  pushl $0
80106d95:	6a 00                	push   $0x0
  pushl $81
80106d97:	6a 51                	push   $0x51
  jmp alltraps
80106d99:	e9 c1 f6 ff ff       	jmp    8010645f <alltraps>

80106d9e <vector82>:
.globl vector82
vector82:
  pushl $0
80106d9e:	6a 00                	push   $0x0
  pushl $82
80106da0:	6a 52                	push   $0x52
  jmp alltraps
80106da2:	e9 b8 f6 ff ff       	jmp    8010645f <alltraps>

80106da7 <vector83>:
.globl vector83
vector83:
  pushl $0
80106da7:	6a 00                	push   $0x0
  pushl $83
80106da9:	6a 53                	push   $0x53
  jmp alltraps
80106dab:	e9 af f6 ff ff       	jmp    8010645f <alltraps>

80106db0 <vector84>:
.globl vector84
vector84:
  pushl $0
80106db0:	6a 00                	push   $0x0
  pushl $84
80106db2:	6a 54                	push   $0x54
  jmp alltraps
80106db4:	e9 a6 f6 ff ff       	jmp    8010645f <alltraps>

80106db9 <vector85>:
.globl vector85
vector85:
  pushl $0
80106db9:	6a 00                	push   $0x0
  pushl $85
80106dbb:	6a 55                	push   $0x55
  jmp alltraps
80106dbd:	e9 9d f6 ff ff       	jmp    8010645f <alltraps>

80106dc2 <vector86>:
.globl vector86
vector86:
  pushl $0
80106dc2:	6a 00                	push   $0x0
  pushl $86
80106dc4:	6a 56                	push   $0x56
  jmp alltraps
80106dc6:	e9 94 f6 ff ff       	jmp    8010645f <alltraps>

80106dcb <vector87>:
.globl vector87
vector87:
  pushl $0
80106dcb:	6a 00                	push   $0x0
  pushl $87
80106dcd:	6a 57                	push   $0x57
  jmp alltraps
80106dcf:	e9 8b f6 ff ff       	jmp    8010645f <alltraps>

80106dd4 <vector88>:
.globl vector88
vector88:
  pushl $0
80106dd4:	6a 00                	push   $0x0
  pushl $88
80106dd6:	6a 58                	push   $0x58
  jmp alltraps
80106dd8:	e9 82 f6 ff ff       	jmp    8010645f <alltraps>

80106ddd <vector89>:
.globl vector89
vector89:
  pushl $0
80106ddd:	6a 00                	push   $0x0
  pushl $89
80106ddf:	6a 59                	push   $0x59
  jmp alltraps
80106de1:	e9 79 f6 ff ff       	jmp    8010645f <alltraps>

80106de6 <vector90>:
.globl vector90
vector90:
  pushl $0
80106de6:	6a 00                	push   $0x0
  pushl $90
80106de8:	6a 5a                	push   $0x5a
  jmp alltraps
80106dea:	e9 70 f6 ff ff       	jmp    8010645f <alltraps>

80106def <vector91>:
.globl vector91
vector91:
  pushl $0
80106def:	6a 00                	push   $0x0
  pushl $91
80106df1:	6a 5b                	push   $0x5b
  jmp alltraps
80106df3:	e9 67 f6 ff ff       	jmp    8010645f <alltraps>

80106df8 <vector92>:
.globl vector92
vector92:
  pushl $0
80106df8:	6a 00                	push   $0x0
  pushl $92
80106dfa:	6a 5c                	push   $0x5c
  jmp alltraps
80106dfc:	e9 5e f6 ff ff       	jmp    8010645f <alltraps>

80106e01 <vector93>:
.globl vector93
vector93:
  pushl $0
80106e01:	6a 00                	push   $0x0
  pushl $93
80106e03:	6a 5d                	push   $0x5d
  jmp alltraps
80106e05:	e9 55 f6 ff ff       	jmp    8010645f <alltraps>

80106e0a <vector94>:
.globl vector94
vector94:
  pushl $0
80106e0a:	6a 00                	push   $0x0
  pushl $94
80106e0c:	6a 5e                	push   $0x5e
  jmp alltraps
80106e0e:	e9 4c f6 ff ff       	jmp    8010645f <alltraps>

80106e13 <vector95>:
.globl vector95
vector95:
  pushl $0
80106e13:	6a 00                	push   $0x0
  pushl $95
80106e15:	6a 5f                	push   $0x5f
  jmp alltraps
80106e17:	e9 43 f6 ff ff       	jmp    8010645f <alltraps>

80106e1c <vector96>:
.globl vector96
vector96:
  pushl $0
80106e1c:	6a 00                	push   $0x0
  pushl $96
80106e1e:	6a 60                	push   $0x60
  jmp alltraps
80106e20:	e9 3a f6 ff ff       	jmp    8010645f <alltraps>

80106e25 <vector97>:
.globl vector97
vector97:
  pushl $0
80106e25:	6a 00                	push   $0x0
  pushl $97
80106e27:	6a 61                	push   $0x61
  jmp alltraps
80106e29:	e9 31 f6 ff ff       	jmp    8010645f <alltraps>

80106e2e <vector98>:
.globl vector98
vector98:
  pushl $0
80106e2e:	6a 00                	push   $0x0
  pushl $98
80106e30:	6a 62                	push   $0x62
  jmp alltraps
80106e32:	e9 28 f6 ff ff       	jmp    8010645f <alltraps>

80106e37 <vector99>:
.globl vector99
vector99:
  pushl $0
80106e37:	6a 00                	push   $0x0
  pushl $99
80106e39:	6a 63                	push   $0x63
  jmp alltraps
80106e3b:	e9 1f f6 ff ff       	jmp    8010645f <alltraps>

80106e40 <vector100>:
.globl vector100
vector100:
  pushl $0
80106e40:	6a 00                	push   $0x0
  pushl $100
80106e42:	6a 64                	push   $0x64
  jmp alltraps
80106e44:	e9 16 f6 ff ff       	jmp    8010645f <alltraps>

80106e49 <vector101>:
.globl vector101
vector101:
  pushl $0
80106e49:	6a 00                	push   $0x0
  pushl $101
80106e4b:	6a 65                	push   $0x65
  jmp alltraps
80106e4d:	e9 0d f6 ff ff       	jmp    8010645f <alltraps>

80106e52 <vector102>:
.globl vector102
vector102:
  pushl $0
80106e52:	6a 00                	push   $0x0
  pushl $102
80106e54:	6a 66                	push   $0x66
  jmp alltraps
80106e56:	e9 04 f6 ff ff       	jmp    8010645f <alltraps>

80106e5b <vector103>:
.globl vector103
vector103:
  pushl $0
80106e5b:	6a 00                	push   $0x0
  pushl $103
80106e5d:	6a 67                	push   $0x67
  jmp alltraps
80106e5f:	e9 fb f5 ff ff       	jmp    8010645f <alltraps>

80106e64 <vector104>:
.globl vector104
vector104:
  pushl $0
80106e64:	6a 00                	push   $0x0
  pushl $104
80106e66:	6a 68                	push   $0x68
  jmp alltraps
80106e68:	e9 f2 f5 ff ff       	jmp    8010645f <alltraps>

80106e6d <vector105>:
.globl vector105
vector105:
  pushl $0
80106e6d:	6a 00                	push   $0x0
  pushl $105
80106e6f:	6a 69                	push   $0x69
  jmp alltraps
80106e71:	e9 e9 f5 ff ff       	jmp    8010645f <alltraps>

80106e76 <vector106>:
.globl vector106
vector106:
  pushl $0
80106e76:	6a 00                	push   $0x0
  pushl $106
80106e78:	6a 6a                	push   $0x6a
  jmp alltraps
80106e7a:	e9 e0 f5 ff ff       	jmp    8010645f <alltraps>

80106e7f <vector107>:
.globl vector107
vector107:
  pushl $0
80106e7f:	6a 00                	push   $0x0
  pushl $107
80106e81:	6a 6b                	push   $0x6b
  jmp alltraps
80106e83:	e9 d7 f5 ff ff       	jmp    8010645f <alltraps>

80106e88 <vector108>:
.globl vector108
vector108:
  pushl $0
80106e88:	6a 00                	push   $0x0
  pushl $108
80106e8a:	6a 6c                	push   $0x6c
  jmp alltraps
80106e8c:	e9 ce f5 ff ff       	jmp    8010645f <alltraps>

80106e91 <vector109>:
.globl vector109
vector109:
  pushl $0
80106e91:	6a 00                	push   $0x0
  pushl $109
80106e93:	6a 6d                	push   $0x6d
  jmp alltraps
80106e95:	e9 c5 f5 ff ff       	jmp    8010645f <alltraps>

80106e9a <vector110>:
.globl vector110
vector110:
  pushl $0
80106e9a:	6a 00                	push   $0x0
  pushl $110
80106e9c:	6a 6e                	push   $0x6e
  jmp alltraps
80106e9e:	e9 bc f5 ff ff       	jmp    8010645f <alltraps>

80106ea3 <vector111>:
.globl vector111
vector111:
  pushl $0
80106ea3:	6a 00                	push   $0x0
  pushl $111
80106ea5:	6a 6f                	push   $0x6f
  jmp alltraps
80106ea7:	e9 b3 f5 ff ff       	jmp    8010645f <alltraps>

80106eac <vector112>:
.globl vector112
vector112:
  pushl $0
80106eac:	6a 00                	push   $0x0
  pushl $112
80106eae:	6a 70                	push   $0x70
  jmp alltraps
80106eb0:	e9 aa f5 ff ff       	jmp    8010645f <alltraps>

80106eb5 <vector113>:
.globl vector113
vector113:
  pushl $0
80106eb5:	6a 00                	push   $0x0
  pushl $113
80106eb7:	6a 71                	push   $0x71
  jmp alltraps
80106eb9:	e9 a1 f5 ff ff       	jmp    8010645f <alltraps>

80106ebe <vector114>:
.globl vector114
vector114:
  pushl $0
80106ebe:	6a 00                	push   $0x0
  pushl $114
80106ec0:	6a 72                	push   $0x72
  jmp alltraps
80106ec2:	e9 98 f5 ff ff       	jmp    8010645f <alltraps>

80106ec7 <vector115>:
.globl vector115
vector115:
  pushl $0
80106ec7:	6a 00                	push   $0x0
  pushl $115
80106ec9:	6a 73                	push   $0x73
  jmp alltraps
80106ecb:	e9 8f f5 ff ff       	jmp    8010645f <alltraps>

80106ed0 <vector116>:
.globl vector116
vector116:
  pushl $0
80106ed0:	6a 00                	push   $0x0
  pushl $116
80106ed2:	6a 74                	push   $0x74
  jmp alltraps
80106ed4:	e9 86 f5 ff ff       	jmp    8010645f <alltraps>

80106ed9 <vector117>:
.globl vector117
vector117:
  pushl $0
80106ed9:	6a 00                	push   $0x0
  pushl $117
80106edb:	6a 75                	push   $0x75
  jmp alltraps
80106edd:	e9 7d f5 ff ff       	jmp    8010645f <alltraps>

80106ee2 <vector118>:
.globl vector118
vector118:
  pushl $0
80106ee2:	6a 00                	push   $0x0
  pushl $118
80106ee4:	6a 76                	push   $0x76
  jmp alltraps
80106ee6:	e9 74 f5 ff ff       	jmp    8010645f <alltraps>

80106eeb <vector119>:
.globl vector119
vector119:
  pushl $0
80106eeb:	6a 00                	push   $0x0
  pushl $119
80106eed:	6a 77                	push   $0x77
  jmp alltraps
80106eef:	e9 6b f5 ff ff       	jmp    8010645f <alltraps>

80106ef4 <vector120>:
.globl vector120
vector120:
  pushl $0
80106ef4:	6a 00                	push   $0x0
  pushl $120
80106ef6:	6a 78                	push   $0x78
  jmp alltraps
80106ef8:	e9 62 f5 ff ff       	jmp    8010645f <alltraps>

80106efd <vector121>:
.globl vector121
vector121:
  pushl $0
80106efd:	6a 00                	push   $0x0
  pushl $121
80106eff:	6a 79                	push   $0x79
  jmp alltraps
80106f01:	e9 59 f5 ff ff       	jmp    8010645f <alltraps>

80106f06 <vector122>:
.globl vector122
vector122:
  pushl $0
80106f06:	6a 00                	push   $0x0
  pushl $122
80106f08:	6a 7a                	push   $0x7a
  jmp alltraps
80106f0a:	e9 50 f5 ff ff       	jmp    8010645f <alltraps>

80106f0f <vector123>:
.globl vector123
vector123:
  pushl $0
80106f0f:	6a 00                	push   $0x0
  pushl $123
80106f11:	6a 7b                	push   $0x7b
  jmp alltraps
80106f13:	e9 47 f5 ff ff       	jmp    8010645f <alltraps>

80106f18 <vector124>:
.globl vector124
vector124:
  pushl $0
80106f18:	6a 00                	push   $0x0
  pushl $124
80106f1a:	6a 7c                	push   $0x7c
  jmp alltraps
80106f1c:	e9 3e f5 ff ff       	jmp    8010645f <alltraps>

80106f21 <vector125>:
.globl vector125
vector125:
  pushl $0
80106f21:	6a 00                	push   $0x0
  pushl $125
80106f23:	6a 7d                	push   $0x7d
  jmp alltraps
80106f25:	e9 35 f5 ff ff       	jmp    8010645f <alltraps>

80106f2a <vector126>:
.globl vector126
vector126:
  pushl $0
80106f2a:	6a 00                	push   $0x0
  pushl $126
80106f2c:	6a 7e                	push   $0x7e
  jmp alltraps
80106f2e:	e9 2c f5 ff ff       	jmp    8010645f <alltraps>

80106f33 <vector127>:
.globl vector127
vector127:
  pushl $0
80106f33:	6a 00                	push   $0x0
  pushl $127
80106f35:	6a 7f                	push   $0x7f
  jmp alltraps
80106f37:	e9 23 f5 ff ff       	jmp    8010645f <alltraps>

80106f3c <vector128>:
.globl vector128
vector128:
  pushl $0
80106f3c:	6a 00                	push   $0x0
  pushl $128
80106f3e:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106f43:	e9 17 f5 ff ff       	jmp    8010645f <alltraps>

80106f48 <vector129>:
.globl vector129
vector129:
  pushl $0
80106f48:	6a 00                	push   $0x0
  pushl $129
80106f4a:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106f4f:	e9 0b f5 ff ff       	jmp    8010645f <alltraps>

80106f54 <vector130>:
.globl vector130
vector130:
  pushl $0
80106f54:	6a 00                	push   $0x0
  pushl $130
80106f56:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106f5b:	e9 ff f4 ff ff       	jmp    8010645f <alltraps>

80106f60 <vector131>:
.globl vector131
vector131:
  pushl $0
80106f60:	6a 00                	push   $0x0
  pushl $131
80106f62:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106f67:	e9 f3 f4 ff ff       	jmp    8010645f <alltraps>

80106f6c <vector132>:
.globl vector132
vector132:
  pushl $0
80106f6c:	6a 00                	push   $0x0
  pushl $132
80106f6e:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106f73:	e9 e7 f4 ff ff       	jmp    8010645f <alltraps>

80106f78 <vector133>:
.globl vector133
vector133:
  pushl $0
80106f78:	6a 00                	push   $0x0
  pushl $133
80106f7a:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106f7f:	e9 db f4 ff ff       	jmp    8010645f <alltraps>

80106f84 <vector134>:
.globl vector134
vector134:
  pushl $0
80106f84:	6a 00                	push   $0x0
  pushl $134
80106f86:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106f8b:	e9 cf f4 ff ff       	jmp    8010645f <alltraps>

80106f90 <vector135>:
.globl vector135
vector135:
  pushl $0
80106f90:	6a 00                	push   $0x0
  pushl $135
80106f92:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106f97:	e9 c3 f4 ff ff       	jmp    8010645f <alltraps>

80106f9c <vector136>:
.globl vector136
vector136:
  pushl $0
80106f9c:	6a 00                	push   $0x0
  pushl $136
80106f9e:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106fa3:	e9 b7 f4 ff ff       	jmp    8010645f <alltraps>

80106fa8 <vector137>:
.globl vector137
vector137:
  pushl $0
80106fa8:	6a 00                	push   $0x0
  pushl $137
80106faa:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106faf:	e9 ab f4 ff ff       	jmp    8010645f <alltraps>

80106fb4 <vector138>:
.globl vector138
vector138:
  pushl $0
80106fb4:	6a 00                	push   $0x0
  pushl $138
80106fb6:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106fbb:	e9 9f f4 ff ff       	jmp    8010645f <alltraps>

80106fc0 <vector139>:
.globl vector139
vector139:
  pushl $0
80106fc0:	6a 00                	push   $0x0
  pushl $139
80106fc2:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106fc7:	e9 93 f4 ff ff       	jmp    8010645f <alltraps>

80106fcc <vector140>:
.globl vector140
vector140:
  pushl $0
80106fcc:	6a 00                	push   $0x0
  pushl $140
80106fce:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106fd3:	e9 87 f4 ff ff       	jmp    8010645f <alltraps>

80106fd8 <vector141>:
.globl vector141
vector141:
  pushl $0
80106fd8:	6a 00                	push   $0x0
  pushl $141
80106fda:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106fdf:	e9 7b f4 ff ff       	jmp    8010645f <alltraps>

80106fe4 <vector142>:
.globl vector142
vector142:
  pushl $0
80106fe4:	6a 00                	push   $0x0
  pushl $142
80106fe6:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106feb:	e9 6f f4 ff ff       	jmp    8010645f <alltraps>

80106ff0 <vector143>:
.globl vector143
vector143:
  pushl $0
80106ff0:	6a 00                	push   $0x0
  pushl $143
80106ff2:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106ff7:	e9 63 f4 ff ff       	jmp    8010645f <alltraps>

80106ffc <vector144>:
.globl vector144
vector144:
  pushl $0
80106ffc:	6a 00                	push   $0x0
  pushl $144
80106ffe:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80107003:	e9 57 f4 ff ff       	jmp    8010645f <alltraps>

80107008 <vector145>:
.globl vector145
vector145:
  pushl $0
80107008:	6a 00                	push   $0x0
  pushl $145
8010700a:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010700f:	e9 4b f4 ff ff       	jmp    8010645f <alltraps>

80107014 <vector146>:
.globl vector146
vector146:
  pushl $0
80107014:	6a 00                	push   $0x0
  pushl $146
80107016:	68 92 00 00 00       	push   $0x92
  jmp alltraps
8010701b:	e9 3f f4 ff ff       	jmp    8010645f <alltraps>

80107020 <vector147>:
.globl vector147
vector147:
  pushl $0
80107020:	6a 00                	push   $0x0
  pushl $147
80107022:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107027:	e9 33 f4 ff ff       	jmp    8010645f <alltraps>

8010702c <vector148>:
.globl vector148
vector148:
  pushl $0
8010702c:	6a 00                	push   $0x0
  pushl $148
8010702e:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80107033:	e9 27 f4 ff ff       	jmp    8010645f <alltraps>

80107038 <vector149>:
.globl vector149
vector149:
  pushl $0
80107038:	6a 00                	push   $0x0
  pushl $149
8010703a:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010703f:	e9 1b f4 ff ff       	jmp    8010645f <alltraps>

80107044 <vector150>:
.globl vector150
vector150:
  pushl $0
80107044:	6a 00                	push   $0x0
  pushl $150
80107046:	68 96 00 00 00       	push   $0x96
  jmp alltraps
8010704b:	e9 0f f4 ff ff       	jmp    8010645f <alltraps>

80107050 <vector151>:
.globl vector151
vector151:
  pushl $0
80107050:	6a 00                	push   $0x0
  pushl $151
80107052:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107057:	e9 03 f4 ff ff       	jmp    8010645f <alltraps>

8010705c <vector152>:
.globl vector152
vector152:
  pushl $0
8010705c:	6a 00                	push   $0x0
  pushl $152
8010705e:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80107063:	e9 f7 f3 ff ff       	jmp    8010645f <alltraps>

80107068 <vector153>:
.globl vector153
vector153:
  pushl $0
80107068:	6a 00                	push   $0x0
  pushl $153
8010706a:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010706f:	e9 eb f3 ff ff       	jmp    8010645f <alltraps>

80107074 <vector154>:
.globl vector154
vector154:
  pushl $0
80107074:	6a 00                	push   $0x0
  pushl $154
80107076:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
8010707b:	e9 df f3 ff ff       	jmp    8010645f <alltraps>

80107080 <vector155>:
.globl vector155
vector155:
  pushl $0
80107080:	6a 00                	push   $0x0
  pushl $155
80107082:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107087:	e9 d3 f3 ff ff       	jmp    8010645f <alltraps>

8010708c <vector156>:
.globl vector156
vector156:
  pushl $0
8010708c:	6a 00                	push   $0x0
  pushl $156
8010708e:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80107093:	e9 c7 f3 ff ff       	jmp    8010645f <alltraps>

80107098 <vector157>:
.globl vector157
vector157:
  pushl $0
80107098:	6a 00                	push   $0x0
  pushl $157
8010709a:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010709f:	e9 bb f3 ff ff       	jmp    8010645f <alltraps>

801070a4 <vector158>:
.globl vector158
vector158:
  pushl $0
801070a4:	6a 00                	push   $0x0
  pushl $158
801070a6:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801070ab:	e9 af f3 ff ff       	jmp    8010645f <alltraps>

801070b0 <vector159>:
.globl vector159
vector159:
  pushl $0
801070b0:	6a 00                	push   $0x0
  pushl $159
801070b2:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801070b7:	e9 a3 f3 ff ff       	jmp    8010645f <alltraps>

801070bc <vector160>:
.globl vector160
vector160:
  pushl $0
801070bc:	6a 00                	push   $0x0
  pushl $160
801070be:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801070c3:	e9 97 f3 ff ff       	jmp    8010645f <alltraps>

801070c8 <vector161>:
.globl vector161
vector161:
  pushl $0
801070c8:	6a 00                	push   $0x0
  pushl $161
801070ca:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801070cf:	e9 8b f3 ff ff       	jmp    8010645f <alltraps>

801070d4 <vector162>:
.globl vector162
vector162:
  pushl $0
801070d4:	6a 00                	push   $0x0
  pushl $162
801070d6:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801070db:	e9 7f f3 ff ff       	jmp    8010645f <alltraps>

801070e0 <vector163>:
.globl vector163
vector163:
  pushl $0
801070e0:	6a 00                	push   $0x0
  pushl $163
801070e2:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801070e7:	e9 73 f3 ff ff       	jmp    8010645f <alltraps>

801070ec <vector164>:
.globl vector164
vector164:
  pushl $0
801070ec:	6a 00                	push   $0x0
  pushl $164
801070ee:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801070f3:	e9 67 f3 ff ff       	jmp    8010645f <alltraps>

801070f8 <vector165>:
.globl vector165
vector165:
  pushl $0
801070f8:	6a 00                	push   $0x0
  pushl $165
801070fa:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801070ff:	e9 5b f3 ff ff       	jmp    8010645f <alltraps>

80107104 <vector166>:
.globl vector166
vector166:
  pushl $0
80107104:	6a 00                	push   $0x0
  pushl $166
80107106:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
8010710b:	e9 4f f3 ff ff       	jmp    8010645f <alltraps>

80107110 <vector167>:
.globl vector167
vector167:
  pushl $0
80107110:	6a 00                	push   $0x0
  pushl $167
80107112:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107117:	e9 43 f3 ff ff       	jmp    8010645f <alltraps>

8010711c <vector168>:
.globl vector168
vector168:
  pushl $0
8010711c:	6a 00                	push   $0x0
  pushl $168
8010711e:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107123:	e9 37 f3 ff ff       	jmp    8010645f <alltraps>

80107128 <vector169>:
.globl vector169
vector169:
  pushl $0
80107128:	6a 00                	push   $0x0
  pushl $169
8010712a:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010712f:	e9 2b f3 ff ff       	jmp    8010645f <alltraps>

80107134 <vector170>:
.globl vector170
vector170:
  pushl $0
80107134:	6a 00                	push   $0x0
  pushl $170
80107136:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
8010713b:	e9 1f f3 ff ff       	jmp    8010645f <alltraps>

80107140 <vector171>:
.globl vector171
vector171:
  pushl $0
80107140:	6a 00                	push   $0x0
  pushl $171
80107142:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107147:	e9 13 f3 ff ff       	jmp    8010645f <alltraps>

8010714c <vector172>:
.globl vector172
vector172:
  pushl $0
8010714c:	6a 00                	push   $0x0
  pushl $172
8010714e:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107153:	e9 07 f3 ff ff       	jmp    8010645f <alltraps>

80107158 <vector173>:
.globl vector173
vector173:
  pushl $0
80107158:	6a 00                	push   $0x0
  pushl $173
8010715a:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010715f:	e9 fb f2 ff ff       	jmp    8010645f <alltraps>

80107164 <vector174>:
.globl vector174
vector174:
  pushl $0
80107164:	6a 00                	push   $0x0
  pushl $174
80107166:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
8010716b:	e9 ef f2 ff ff       	jmp    8010645f <alltraps>

80107170 <vector175>:
.globl vector175
vector175:
  pushl $0
80107170:	6a 00                	push   $0x0
  pushl $175
80107172:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107177:	e9 e3 f2 ff ff       	jmp    8010645f <alltraps>

8010717c <vector176>:
.globl vector176
vector176:
  pushl $0
8010717c:	6a 00                	push   $0x0
  pushl $176
8010717e:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107183:	e9 d7 f2 ff ff       	jmp    8010645f <alltraps>

80107188 <vector177>:
.globl vector177
vector177:
  pushl $0
80107188:	6a 00                	push   $0x0
  pushl $177
8010718a:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010718f:	e9 cb f2 ff ff       	jmp    8010645f <alltraps>

80107194 <vector178>:
.globl vector178
vector178:
  pushl $0
80107194:	6a 00                	push   $0x0
  pushl $178
80107196:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
8010719b:	e9 bf f2 ff ff       	jmp    8010645f <alltraps>

801071a0 <vector179>:
.globl vector179
vector179:
  pushl $0
801071a0:	6a 00                	push   $0x0
  pushl $179
801071a2:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801071a7:	e9 b3 f2 ff ff       	jmp    8010645f <alltraps>

801071ac <vector180>:
.globl vector180
vector180:
  pushl $0
801071ac:	6a 00                	push   $0x0
  pushl $180
801071ae:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801071b3:	e9 a7 f2 ff ff       	jmp    8010645f <alltraps>

801071b8 <vector181>:
.globl vector181
vector181:
  pushl $0
801071b8:	6a 00                	push   $0x0
  pushl $181
801071ba:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801071bf:	e9 9b f2 ff ff       	jmp    8010645f <alltraps>

801071c4 <vector182>:
.globl vector182
vector182:
  pushl $0
801071c4:	6a 00                	push   $0x0
  pushl $182
801071c6:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801071cb:	e9 8f f2 ff ff       	jmp    8010645f <alltraps>

801071d0 <vector183>:
.globl vector183
vector183:
  pushl $0
801071d0:	6a 00                	push   $0x0
  pushl $183
801071d2:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801071d7:	e9 83 f2 ff ff       	jmp    8010645f <alltraps>

801071dc <vector184>:
.globl vector184
vector184:
  pushl $0
801071dc:	6a 00                	push   $0x0
  pushl $184
801071de:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801071e3:	e9 77 f2 ff ff       	jmp    8010645f <alltraps>

801071e8 <vector185>:
.globl vector185
vector185:
  pushl $0
801071e8:	6a 00                	push   $0x0
  pushl $185
801071ea:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801071ef:	e9 6b f2 ff ff       	jmp    8010645f <alltraps>

801071f4 <vector186>:
.globl vector186
vector186:
  pushl $0
801071f4:	6a 00                	push   $0x0
  pushl $186
801071f6:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801071fb:	e9 5f f2 ff ff       	jmp    8010645f <alltraps>

80107200 <vector187>:
.globl vector187
vector187:
  pushl $0
80107200:	6a 00                	push   $0x0
  pushl $187
80107202:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107207:	e9 53 f2 ff ff       	jmp    8010645f <alltraps>

8010720c <vector188>:
.globl vector188
vector188:
  pushl $0
8010720c:	6a 00                	push   $0x0
  pushl $188
8010720e:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107213:	e9 47 f2 ff ff       	jmp    8010645f <alltraps>

80107218 <vector189>:
.globl vector189
vector189:
  pushl $0
80107218:	6a 00                	push   $0x0
  pushl $189
8010721a:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010721f:	e9 3b f2 ff ff       	jmp    8010645f <alltraps>

80107224 <vector190>:
.globl vector190
vector190:
  pushl $0
80107224:	6a 00                	push   $0x0
  pushl $190
80107226:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
8010722b:	e9 2f f2 ff ff       	jmp    8010645f <alltraps>

80107230 <vector191>:
.globl vector191
vector191:
  pushl $0
80107230:	6a 00                	push   $0x0
  pushl $191
80107232:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107237:	e9 23 f2 ff ff       	jmp    8010645f <alltraps>

8010723c <vector192>:
.globl vector192
vector192:
  pushl $0
8010723c:	6a 00                	push   $0x0
  pushl $192
8010723e:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107243:	e9 17 f2 ff ff       	jmp    8010645f <alltraps>

80107248 <vector193>:
.globl vector193
vector193:
  pushl $0
80107248:	6a 00                	push   $0x0
  pushl $193
8010724a:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010724f:	e9 0b f2 ff ff       	jmp    8010645f <alltraps>

80107254 <vector194>:
.globl vector194
vector194:
  pushl $0
80107254:	6a 00                	push   $0x0
  pushl $194
80107256:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
8010725b:	e9 ff f1 ff ff       	jmp    8010645f <alltraps>

80107260 <vector195>:
.globl vector195
vector195:
  pushl $0
80107260:	6a 00                	push   $0x0
  pushl $195
80107262:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107267:	e9 f3 f1 ff ff       	jmp    8010645f <alltraps>

8010726c <vector196>:
.globl vector196
vector196:
  pushl $0
8010726c:	6a 00                	push   $0x0
  pushl $196
8010726e:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107273:	e9 e7 f1 ff ff       	jmp    8010645f <alltraps>

80107278 <vector197>:
.globl vector197
vector197:
  pushl $0
80107278:	6a 00                	push   $0x0
  pushl $197
8010727a:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010727f:	e9 db f1 ff ff       	jmp    8010645f <alltraps>

80107284 <vector198>:
.globl vector198
vector198:
  pushl $0
80107284:	6a 00                	push   $0x0
  pushl $198
80107286:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
8010728b:	e9 cf f1 ff ff       	jmp    8010645f <alltraps>

80107290 <vector199>:
.globl vector199
vector199:
  pushl $0
80107290:	6a 00                	push   $0x0
  pushl $199
80107292:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107297:	e9 c3 f1 ff ff       	jmp    8010645f <alltraps>

8010729c <vector200>:
.globl vector200
vector200:
  pushl $0
8010729c:	6a 00                	push   $0x0
  pushl $200
8010729e:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801072a3:	e9 b7 f1 ff ff       	jmp    8010645f <alltraps>

801072a8 <vector201>:
.globl vector201
vector201:
  pushl $0
801072a8:	6a 00                	push   $0x0
  pushl $201
801072aa:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801072af:	e9 ab f1 ff ff       	jmp    8010645f <alltraps>

801072b4 <vector202>:
.globl vector202
vector202:
  pushl $0
801072b4:	6a 00                	push   $0x0
  pushl $202
801072b6:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801072bb:	e9 9f f1 ff ff       	jmp    8010645f <alltraps>

801072c0 <vector203>:
.globl vector203
vector203:
  pushl $0
801072c0:	6a 00                	push   $0x0
  pushl $203
801072c2:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801072c7:	e9 93 f1 ff ff       	jmp    8010645f <alltraps>

801072cc <vector204>:
.globl vector204
vector204:
  pushl $0
801072cc:	6a 00                	push   $0x0
  pushl $204
801072ce:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801072d3:	e9 87 f1 ff ff       	jmp    8010645f <alltraps>

801072d8 <vector205>:
.globl vector205
vector205:
  pushl $0
801072d8:	6a 00                	push   $0x0
  pushl $205
801072da:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801072df:	e9 7b f1 ff ff       	jmp    8010645f <alltraps>

801072e4 <vector206>:
.globl vector206
vector206:
  pushl $0
801072e4:	6a 00                	push   $0x0
  pushl $206
801072e6:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801072eb:	e9 6f f1 ff ff       	jmp    8010645f <alltraps>

801072f0 <vector207>:
.globl vector207
vector207:
  pushl $0
801072f0:	6a 00                	push   $0x0
  pushl $207
801072f2:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801072f7:	e9 63 f1 ff ff       	jmp    8010645f <alltraps>

801072fc <vector208>:
.globl vector208
vector208:
  pushl $0
801072fc:	6a 00                	push   $0x0
  pushl $208
801072fe:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107303:	e9 57 f1 ff ff       	jmp    8010645f <alltraps>

80107308 <vector209>:
.globl vector209
vector209:
  pushl $0
80107308:	6a 00                	push   $0x0
  pushl $209
8010730a:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010730f:	e9 4b f1 ff ff       	jmp    8010645f <alltraps>

80107314 <vector210>:
.globl vector210
vector210:
  pushl $0
80107314:	6a 00                	push   $0x0
  pushl $210
80107316:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
8010731b:	e9 3f f1 ff ff       	jmp    8010645f <alltraps>

80107320 <vector211>:
.globl vector211
vector211:
  pushl $0
80107320:	6a 00                	push   $0x0
  pushl $211
80107322:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107327:	e9 33 f1 ff ff       	jmp    8010645f <alltraps>

8010732c <vector212>:
.globl vector212
vector212:
  pushl $0
8010732c:	6a 00                	push   $0x0
  pushl $212
8010732e:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107333:	e9 27 f1 ff ff       	jmp    8010645f <alltraps>

80107338 <vector213>:
.globl vector213
vector213:
  pushl $0
80107338:	6a 00                	push   $0x0
  pushl $213
8010733a:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010733f:	e9 1b f1 ff ff       	jmp    8010645f <alltraps>

80107344 <vector214>:
.globl vector214
vector214:
  pushl $0
80107344:	6a 00                	push   $0x0
  pushl $214
80107346:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
8010734b:	e9 0f f1 ff ff       	jmp    8010645f <alltraps>

80107350 <vector215>:
.globl vector215
vector215:
  pushl $0
80107350:	6a 00                	push   $0x0
  pushl $215
80107352:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107357:	e9 03 f1 ff ff       	jmp    8010645f <alltraps>

8010735c <vector216>:
.globl vector216
vector216:
  pushl $0
8010735c:	6a 00                	push   $0x0
  pushl $216
8010735e:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107363:	e9 f7 f0 ff ff       	jmp    8010645f <alltraps>

80107368 <vector217>:
.globl vector217
vector217:
  pushl $0
80107368:	6a 00                	push   $0x0
  pushl $217
8010736a:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010736f:	e9 eb f0 ff ff       	jmp    8010645f <alltraps>

80107374 <vector218>:
.globl vector218
vector218:
  pushl $0
80107374:	6a 00                	push   $0x0
  pushl $218
80107376:	68 da 00 00 00       	push   $0xda
  jmp alltraps
8010737b:	e9 df f0 ff ff       	jmp    8010645f <alltraps>

80107380 <vector219>:
.globl vector219
vector219:
  pushl $0
80107380:	6a 00                	push   $0x0
  pushl $219
80107382:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107387:	e9 d3 f0 ff ff       	jmp    8010645f <alltraps>

8010738c <vector220>:
.globl vector220
vector220:
  pushl $0
8010738c:	6a 00                	push   $0x0
  pushl $220
8010738e:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107393:	e9 c7 f0 ff ff       	jmp    8010645f <alltraps>

80107398 <vector221>:
.globl vector221
vector221:
  pushl $0
80107398:	6a 00                	push   $0x0
  pushl $221
8010739a:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010739f:	e9 bb f0 ff ff       	jmp    8010645f <alltraps>

801073a4 <vector222>:
.globl vector222
vector222:
  pushl $0
801073a4:	6a 00                	push   $0x0
  pushl $222
801073a6:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801073ab:	e9 af f0 ff ff       	jmp    8010645f <alltraps>

801073b0 <vector223>:
.globl vector223
vector223:
  pushl $0
801073b0:	6a 00                	push   $0x0
  pushl $223
801073b2:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801073b7:	e9 a3 f0 ff ff       	jmp    8010645f <alltraps>

801073bc <vector224>:
.globl vector224
vector224:
  pushl $0
801073bc:	6a 00                	push   $0x0
  pushl $224
801073be:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801073c3:	e9 97 f0 ff ff       	jmp    8010645f <alltraps>

801073c8 <vector225>:
.globl vector225
vector225:
  pushl $0
801073c8:	6a 00                	push   $0x0
  pushl $225
801073ca:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801073cf:	e9 8b f0 ff ff       	jmp    8010645f <alltraps>

801073d4 <vector226>:
.globl vector226
vector226:
  pushl $0
801073d4:	6a 00                	push   $0x0
  pushl $226
801073d6:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801073db:	e9 7f f0 ff ff       	jmp    8010645f <alltraps>

801073e0 <vector227>:
.globl vector227
vector227:
  pushl $0
801073e0:	6a 00                	push   $0x0
  pushl $227
801073e2:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801073e7:	e9 73 f0 ff ff       	jmp    8010645f <alltraps>

801073ec <vector228>:
.globl vector228
vector228:
  pushl $0
801073ec:	6a 00                	push   $0x0
  pushl $228
801073ee:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801073f3:	e9 67 f0 ff ff       	jmp    8010645f <alltraps>

801073f8 <vector229>:
.globl vector229
vector229:
  pushl $0
801073f8:	6a 00                	push   $0x0
  pushl $229
801073fa:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801073ff:	e9 5b f0 ff ff       	jmp    8010645f <alltraps>

80107404 <vector230>:
.globl vector230
vector230:
  pushl $0
80107404:	6a 00                	push   $0x0
  pushl $230
80107406:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
8010740b:	e9 4f f0 ff ff       	jmp    8010645f <alltraps>

80107410 <vector231>:
.globl vector231
vector231:
  pushl $0
80107410:	6a 00                	push   $0x0
  pushl $231
80107412:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107417:	e9 43 f0 ff ff       	jmp    8010645f <alltraps>

8010741c <vector232>:
.globl vector232
vector232:
  pushl $0
8010741c:	6a 00                	push   $0x0
  pushl $232
8010741e:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107423:	e9 37 f0 ff ff       	jmp    8010645f <alltraps>

80107428 <vector233>:
.globl vector233
vector233:
  pushl $0
80107428:	6a 00                	push   $0x0
  pushl $233
8010742a:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010742f:	e9 2b f0 ff ff       	jmp    8010645f <alltraps>

80107434 <vector234>:
.globl vector234
vector234:
  pushl $0
80107434:	6a 00                	push   $0x0
  pushl $234
80107436:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
8010743b:	e9 1f f0 ff ff       	jmp    8010645f <alltraps>

80107440 <vector235>:
.globl vector235
vector235:
  pushl $0
80107440:	6a 00                	push   $0x0
  pushl $235
80107442:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107447:	e9 13 f0 ff ff       	jmp    8010645f <alltraps>

8010744c <vector236>:
.globl vector236
vector236:
  pushl $0
8010744c:	6a 00                	push   $0x0
  pushl $236
8010744e:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107453:	e9 07 f0 ff ff       	jmp    8010645f <alltraps>

80107458 <vector237>:
.globl vector237
vector237:
  pushl $0
80107458:	6a 00                	push   $0x0
  pushl $237
8010745a:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010745f:	e9 fb ef ff ff       	jmp    8010645f <alltraps>

80107464 <vector238>:
.globl vector238
vector238:
  pushl $0
80107464:	6a 00                	push   $0x0
  pushl $238
80107466:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
8010746b:	e9 ef ef ff ff       	jmp    8010645f <alltraps>

80107470 <vector239>:
.globl vector239
vector239:
  pushl $0
80107470:	6a 00                	push   $0x0
  pushl $239
80107472:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107477:	e9 e3 ef ff ff       	jmp    8010645f <alltraps>

8010747c <vector240>:
.globl vector240
vector240:
  pushl $0
8010747c:	6a 00                	push   $0x0
  pushl $240
8010747e:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107483:	e9 d7 ef ff ff       	jmp    8010645f <alltraps>

80107488 <vector241>:
.globl vector241
vector241:
  pushl $0
80107488:	6a 00                	push   $0x0
  pushl $241
8010748a:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010748f:	e9 cb ef ff ff       	jmp    8010645f <alltraps>

80107494 <vector242>:
.globl vector242
vector242:
  pushl $0
80107494:	6a 00                	push   $0x0
  pushl $242
80107496:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
8010749b:	e9 bf ef ff ff       	jmp    8010645f <alltraps>

801074a0 <vector243>:
.globl vector243
vector243:
  pushl $0
801074a0:	6a 00                	push   $0x0
  pushl $243
801074a2:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801074a7:	e9 b3 ef ff ff       	jmp    8010645f <alltraps>

801074ac <vector244>:
.globl vector244
vector244:
  pushl $0
801074ac:	6a 00                	push   $0x0
  pushl $244
801074ae:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801074b3:	e9 a7 ef ff ff       	jmp    8010645f <alltraps>

801074b8 <vector245>:
.globl vector245
vector245:
  pushl $0
801074b8:	6a 00                	push   $0x0
  pushl $245
801074ba:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801074bf:	e9 9b ef ff ff       	jmp    8010645f <alltraps>

801074c4 <vector246>:
.globl vector246
vector246:
  pushl $0
801074c4:	6a 00                	push   $0x0
  pushl $246
801074c6:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801074cb:	e9 8f ef ff ff       	jmp    8010645f <alltraps>

801074d0 <vector247>:
.globl vector247
vector247:
  pushl $0
801074d0:	6a 00                	push   $0x0
  pushl $247
801074d2:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801074d7:	e9 83 ef ff ff       	jmp    8010645f <alltraps>

801074dc <vector248>:
.globl vector248
vector248:
  pushl $0
801074dc:	6a 00                	push   $0x0
  pushl $248
801074de:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801074e3:	e9 77 ef ff ff       	jmp    8010645f <alltraps>

801074e8 <vector249>:
.globl vector249
vector249:
  pushl $0
801074e8:	6a 00                	push   $0x0
  pushl $249
801074ea:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801074ef:	e9 6b ef ff ff       	jmp    8010645f <alltraps>

801074f4 <vector250>:
.globl vector250
vector250:
  pushl $0
801074f4:	6a 00                	push   $0x0
  pushl $250
801074f6:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801074fb:	e9 5f ef ff ff       	jmp    8010645f <alltraps>

80107500 <vector251>:
.globl vector251
vector251:
  pushl $0
80107500:	6a 00                	push   $0x0
  pushl $251
80107502:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107507:	e9 53 ef ff ff       	jmp    8010645f <alltraps>

8010750c <vector252>:
.globl vector252
vector252:
  pushl $0
8010750c:	6a 00                	push   $0x0
  pushl $252
8010750e:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107513:	e9 47 ef ff ff       	jmp    8010645f <alltraps>

80107518 <vector253>:
.globl vector253
vector253:
  pushl $0
80107518:	6a 00                	push   $0x0
  pushl $253
8010751a:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010751f:	e9 3b ef ff ff       	jmp    8010645f <alltraps>

80107524 <vector254>:
.globl vector254
vector254:
  pushl $0
80107524:	6a 00                	push   $0x0
  pushl $254
80107526:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
8010752b:	e9 2f ef ff ff       	jmp    8010645f <alltraps>

80107530 <vector255>:
.globl vector255
vector255:
  pushl $0
80107530:	6a 00                	push   $0x0
  pushl $255
80107532:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107537:	e9 23 ef ff ff       	jmp    8010645f <alltraps>

8010753c <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
8010753c:	55                   	push   %ebp
8010753d:	89 e5                	mov    %esp,%ebp
8010753f:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80107542:	8b 45 0c             	mov    0xc(%ebp),%eax
80107545:	83 e8 01             	sub    $0x1,%eax
80107548:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010754c:	8b 45 08             	mov    0x8(%ebp),%eax
8010754f:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80107553:	8b 45 08             	mov    0x8(%ebp),%eax
80107556:	c1 e8 10             	shr    $0x10,%eax
80107559:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
8010755d:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107560:	0f 01 10             	lgdtl  (%eax)
}
80107563:	90                   	nop
80107564:	c9                   	leave  
80107565:	c3                   	ret    

80107566 <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
80107566:	55                   	push   %ebp
80107567:	89 e5                	mov    %esp,%ebp
80107569:	83 ec 04             	sub    $0x4,%esp
8010756c:	8b 45 08             	mov    0x8(%ebp),%eax
8010756f:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
80107573:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107577:	0f 00 d8             	ltr    %ax
}
8010757a:	90                   	nop
8010757b:	c9                   	leave  
8010757c:	c3                   	ret    

8010757d <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
8010757d:	55                   	push   %ebp
8010757e:	89 e5                	mov    %esp,%ebp
80107580:	83 ec 04             	sub    $0x4,%esp
80107583:	8b 45 08             	mov    0x8(%ebp),%eax
80107586:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
8010758a:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010758e:	8e e8                	mov    %eax,%gs
}
80107590:	90                   	nop
80107591:	c9                   	leave  
80107592:	c3                   	ret    

80107593 <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
80107593:	55                   	push   %ebp
80107594:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107596:	8b 45 08             	mov    0x8(%ebp),%eax
80107599:	0f 22 d8             	mov    %eax,%cr3
}
8010759c:	90                   	nop
8010759d:	5d                   	pop    %ebp
8010759e:	c3                   	ret    

8010759f <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
8010759f:	55                   	push   %ebp
801075a0:	89 e5                	mov    %esp,%ebp
801075a2:	8b 45 08             	mov    0x8(%ebp),%eax
801075a5:	05 00 00 00 80       	add    $0x80000000,%eax
801075aa:	5d                   	pop    %ebp
801075ab:	c3                   	ret    

801075ac <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801075ac:	55                   	push   %ebp
801075ad:	89 e5                	mov    %esp,%ebp
801075af:	8b 45 08             	mov    0x8(%ebp),%eax
801075b2:	05 00 00 00 80       	add    $0x80000000,%eax
801075b7:	5d                   	pop    %ebp
801075b8:	c3                   	ret    

801075b9 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801075b9:	55                   	push   %ebp
801075ba:	89 e5                	mov    %esp,%ebp
801075bc:	53                   	push   %ebx
801075bd:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
801075c0:	e8 d4 bb ff ff       	call   80103199 <cpunum>
801075c5:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801075cb:	05 80 29 11 80       	add    $0x80112980,%eax
801075d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801075d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075d6:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801075dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075df:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801075e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075e8:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801075ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075ef:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801075f3:	83 e2 f0             	and    $0xfffffff0,%edx
801075f6:	83 ca 0a             	or     $0xa,%edx
801075f9:	88 50 7d             	mov    %dl,0x7d(%eax)
801075fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075ff:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107603:	83 ca 10             	or     $0x10,%edx
80107606:	88 50 7d             	mov    %dl,0x7d(%eax)
80107609:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010760c:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107610:	83 e2 9f             	and    $0xffffff9f,%edx
80107613:	88 50 7d             	mov    %dl,0x7d(%eax)
80107616:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107619:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010761d:	83 ca 80             	or     $0xffffff80,%edx
80107620:	88 50 7d             	mov    %dl,0x7d(%eax)
80107623:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107626:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010762a:	83 ca 0f             	or     $0xf,%edx
8010762d:	88 50 7e             	mov    %dl,0x7e(%eax)
80107630:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107633:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107637:	83 e2 ef             	and    $0xffffffef,%edx
8010763a:	88 50 7e             	mov    %dl,0x7e(%eax)
8010763d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107640:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107644:	83 e2 df             	and    $0xffffffdf,%edx
80107647:	88 50 7e             	mov    %dl,0x7e(%eax)
8010764a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010764d:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107651:	83 ca 40             	or     $0x40,%edx
80107654:	88 50 7e             	mov    %dl,0x7e(%eax)
80107657:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010765a:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010765e:	83 ca 80             	or     $0xffffff80,%edx
80107661:	88 50 7e             	mov    %dl,0x7e(%eax)
80107664:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107667:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010766b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010766e:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80107675:	ff ff 
80107677:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010767a:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107681:	00 00 
80107683:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107686:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
8010768d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107690:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107697:	83 e2 f0             	and    $0xfffffff0,%edx
8010769a:	83 ca 02             	or     $0x2,%edx
8010769d:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801076a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076a6:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801076ad:	83 ca 10             	or     $0x10,%edx
801076b0:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801076b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076b9:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801076c0:	83 e2 9f             	and    $0xffffff9f,%edx
801076c3:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801076c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076cc:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801076d3:	83 ca 80             	or     $0xffffff80,%edx
801076d6:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801076dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076df:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076e6:	83 ca 0f             	or     $0xf,%edx
801076e9:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801076ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076f2:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076f9:	83 e2 ef             	and    $0xffffffef,%edx
801076fc:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107702:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107705:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010770c:	83 e2 df             	and    $0xffffffdf,%edx
8010770f:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107715:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107718:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010771f:	83 ca 40             	or     $0x40,%edx
80107722:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107728:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010772b:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107732:	83 ca 80             	or     $0xffffff80,%edx
80107735:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010773b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010773e:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107745:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107748:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
8010774f:	ff ff 
80107751:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107754:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
8010775b:	00 00 
8010775d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107760:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107767:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010776a:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107771:	83 e2 f0             	and    $0xfffffff0,%edx
80107774:	83 ca 0a             	or     $0xa,%edx
80107777:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010777d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107780:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107787:	83 ca 10             	or     $0x10,%edx
8010778a:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107790:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107793:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
8010779a:	83 ca 60             	or     $0x60,%edx
8010779d:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801077a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077a6:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801077ad:	83 ca 80             	or     $0xffffff80,%edx
801077b0:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801077b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077b9:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077c0:	83 ca 0f             	or     $0xf,%edx
801077c3:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077cc:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077d3:	83 e2 ef             	and    $0xffffffef,%edx
801077d6:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077df:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077e6:	83 e2 df             	and    $0xffffffdf,%edx
801077e9:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077f2:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077f9:	83 ca 40             	or     $0x40,%edx
801077fc:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107802:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107805:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
8010780c:	83 ca 80             	or     $0xffffff80,%edx
8010780f:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107815:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107818:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010781f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107822:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107829:	ff ff 
8010782b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010782e:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107835:	00 00 
80107837:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010783a:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107841:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107844:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010784b:	83 e2 f0             	and    $0xfffffff0,%edx
8010784e:	83 ca 02             	or     $0x2,%edx
80107851:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107857:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010785a:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107861:	83 ca 10             	or     $0x10,%edx
80107864:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
8010786a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010786d:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107874:	83 ca 60             	or     $0x60,%edx
80107877:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
8010787d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107880:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107887:	83 ca 80             	or     $0xffffff80,%edx
8010788a:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107890:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107893:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
8010789a:	83 ca 0f             	or     $0xf,%edx
8010789d:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078a6:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801078ad:	83 e2 ef             	and    $0xffffffef,%edx
801078b0:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078b9:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801078c0:	83 e2 df             	and    $0xffffffdf,%edx
801078c3:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078cc:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801078d3:	83 ca 40             	or     $0x40,%edx
801078d6:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078df:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801078e6:	83 ca 80             	or     $0xffffff80,%edx
801078e9:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078f2:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801078f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078fc:	05 b4 00 00 00       	add    $0xb4,%eax
80107901:	89 c3                	mov    %eax,%ebx
80107903:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107906:	05 b4 00 00 00       	add    $0xb4,%eax
8010790b:	c1 e8 10             	shr    $0x10,%eax
8010790e:	89 c2                	mov    %eax,%edx
80107910:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107913:	05 b4 00 00 00       	add    $0xb4,%eax
80107918:	c1 e8 18             	shr    $0x18,%eax
8010791b:	89 c1                	mov    %eax,%ecx
8010791d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107920:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107927:	00 00 
80107929:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010792c:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107933:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107936:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
8010793c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010793f:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107946:	83 e2 f0             	and    $0xfffffff0,%edx
80107949:	83 ca 02             	or     $0x2,%edx
8010794c:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107952:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107955:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010795c:	83 ca 10             	or     $0x10,%edx
8010795f:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107965:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107968:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010796f:	83 e2 9f             	and    $0xffffff9f,%edx
80107972:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107978:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010797b:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107982:	83 ca 80             	or     $0xffffff80,%edx
80107985:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
8010798b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010798e:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107995:	83 e2 f0             	and    $0xfffffff0,%edx
80107998:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
8010799e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079a1:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801079a8:	83 e2 ef             	and    $0xffffffef,%edx
801079ab:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801079b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079b4:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801079bb:	83 e2 df             	and    $0xffffffdf,%edx
801079be:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801079c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079c7:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801079ce:	83 ca 40             	or     $0x40,%edx
801079d1:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801079d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079da:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801079e1:	83 ca 80             	or     $0xffffff80,%edx
801079e4:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801079ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ed:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
801079f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079f6:	83 c0 70             	add    $0x70,%eax
801079f9:	83 ec 08             	sub    $0x8,%esp
801079fc:	6a 38                	push   $0x38
801079fe:	50                   	push   %eax
801079ff:	e8 38 fb ff ff       	call   8010753c <lgdt>
80107a04:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
80107a07:	83 ec 0c             	sub    $0xc,%esp
80107a0a:	6a 18                	push   $0x18
80107a0c:	e8 6c fb ff ff       	call   8010757d <loadgs>
80107a11:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
80107a14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a17:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80107a1d:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107a24:	00 00 00 00 
}
80107a28:	90                   	nop
80107a29:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107a2c:	c9                   	leave  
80107a2d:	c3                   	ret    

80107a2e <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107a2e:	55                   	push   %ebp
80107a2f:	89 e5                	mov    %esp,%ebp
80107a31:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107a34:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a37:	c1 e8 16             	shr    $0x16,%eax
80107a3a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107a41:	8b 45 08             	mov    0x8(%ebp),%eax
80107a44:	01 d0                	add    %edx,%eax
80107a46:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107a49:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a4c:	8b 00                	mov    (%eax),%eax
80107a4e:	83 e0 01             	and    $0x1,%eax
80107a51:	85 c0                	test   %eax,%eax
80107a53:	74 18                	je     80107a6d <walkpgdir+0x3f>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107a55:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a58:	8b 00                	mov    (%eax),%eax
80107a5a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107a5f:	50                   	push   %eax
80107a60:	e8 47 fb ff ff       	call   801075ac <p2v>
80107a65:	83 c4 04             	add    $0x4,%esp
80107a68:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107a6b:	eb 48                	jmp    80107ab5 <walkpgdir+0x87>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107a6d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107a71:	74 0e                	je     80107a81 <walkpgdir+0x53>
80107a73:	e8 88 b2 ff ff       	call   80102d00 <kalloc>
80107a78:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107a7b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107a7f:	75 07                	jne    80107a88 <walkpgdir+0x5a>
      return 0;
80107a81:	b8 00 00 00 00       	mov    $0x0,%eax
80107a86:	eb 44                	jmp    80107acc <walkpgdir+0x9e>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107a88:	83 ec 04             	sub    $0x4,%esp
80107a8b:	68 00 10 00 00       	push   $0x1000
80107a90:	6a 00                	push   $0x0
80107a92:	ff 75 f4             	pushl  -0xc(%ebp)
80107a95:	e8 3d d6 ff ff       	call   801050d7 <memset>
80107a9a:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107a9d:	83 ec 0c             	sub    $0xc,%esp
80107aa0:	ff 75 f4             	pushl  -0xc(%ebp)
80107aa3:	e8 f7 fa ff ff       	call   8010759f <v2p>
80107aa8:	83 c4 10             	add    $0x10,%esp
80107aab:	83 c8 07             	or     $0x7,%eax
80107aae:	89 c2                	mov    %eax,%edx
80107ab0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ab3:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107ab5:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ab8:	c1 e8 0c             	shr    $0xc,%eax
80107abb:	25 ff 03 00 00       	and    $0x3ff,%eax
80107ac0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107ac7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aca:	01 d0                	add    %edx,%eax
}
80107acc:	c9                   	leave  
80107acd:	c3                   	ret    

80107ace <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107ace:	55                   	push   %ebp
80107acf:	89 e5                	mov    %esp,%ebp
80107ad1:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107ad4:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ad7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107adc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107adf:	8b 55 0c             	mov    0xc(%ebp),%edx
80107ae2:	8b 45 10             	mov    0x10(%ebp),%eax
80107ae5:	01 d0                	add    %edx,%eax
80107ae7:	83 e8 01             	sub    $0x1,%eax
80107aea:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107aef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107af2:	83 ec 04             	sub    $0x4,%esp
80107af5:	6a 01                	push   $0x1
80107af7:	ff 75 f4             	pushl  -0xc(%ebp)
80107afa:	ff 75 08             	pushl  0x8(%ebp)
80107afd:	e8 2c ff ff ff       	call   80107a2e <walkpgdir>
80107b02:	83 c4 10             	add    $0x10,%esp
80107b05:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107b08:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107b0c:	75 07                	jne    80107b15 <mappages+0x47>
      return -1;
80107b0e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107b13:	eb 47                	jmp    80107b5c <mappages+0x8e>
    if(*pte & PTE_P)
80107b15:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107b18:	8b 00                	mov    (%eax),%eax
80107b1a:	83 e0 01             	and    $0x1,%eax
80107b1d:	85 c0                	test   %eax,%eax
80107b1f:	74 0d                	je     80107b2e <mappages+0x60>
      panic("remap");
80107b21:	83 ec 0c             	sub    $0xc,%esp
80107b24:	68 1c ba 10 80       	push   $0x8010ba1c
80107b29:	e8 38 8a ff ff       	call   80100566 <panic>
    *pte = pa | perm | PTE_P;
80107b2e:	8b 45 18             	mov    0x18(%ebp),%eax
80107b31:	0b 45 14             	or     0x14(%ebp),%eax
80107b34:	83 c8 01             	or     $0x1,%eax
80107b37:	89 c2                	mov    %eax,%edx
80107b39:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107b3c:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107b3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b41:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107b44:	74 10                	je     80107b56 <mappages+0x88>
      break;
    a += PGSIZE;
80107b46:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107b4d:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80107b54:	eb 9c                	jmp    80107af2 <mappages+0x24>
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
80107b56:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107b57:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107b5c:	c9                   	leave  
80107b5d:	c3                   	ret    

80107b5e <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107b5e:	55                   	push   %ebp
80107b5f:	89 e5                	mov    %esp,%ebp
80107b61:	53                   	push   %ebx
80107b62:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107b65:	e8 96 b1 ff ff       	call   80102d00 <kalloc>
80107b6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107b6d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107b71:	75 0a                	jne    80107b7d <setupkvm+0x1f>
    return 0;
80107b73:	b8 00 00 00 00       	mov    $0x0,%eax
80107b78:	e9 8e 00 00 00       	jmp    80107c0b <setupkvm+0xad>
  memset(pgdir, 0, PGSIZE);
80107b7d:	83 ec 04             	sub    $0x4,%esp
80107b80:	68 00 10 00 00       	push   $0x1000
80107b85:	6a 00                	push   $0x0
80107b87:	ff 75 f0             	pushl  -0x10(%ebp)
80107b8a:	e8 48 d5 ff ff       	call   801050d7 <memset>
80107b8f:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107b92:	83 ec 0c             	sub    $0xc,%esp
80107b95:	68 00 00 00 0e       	push   $0xe000000
80107b9a:	e8 0d fa ff ff       	call   801075ac <p2v>
80107b9f:	83 c4 10             	add    $0x10,%esp
80107ba2:	3d 00 00 00 fc       	cmp    $0xfc000000,%eax
80107ba7:	76 0d                	jbe    80107bb6 <setupkvm+0x58>
    panic("PHYSTOP too high");
80107ba9:	83 ec 0c             	sub    $0xc,%esp
80107bac:	68 22 ba 10 80       	push   $0x8010ba22
80107bb1:	e8 b0 89 ff ff       	call   80100566 <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107bb6:	c7 45 f4 c0 e4 10 80 	movl   $0x8010e4c0,-0xc(%ebp)
80107bbd:	eb 40                	jmp    80107bff <setupkvm+0xa1>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107bbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bc2:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
80107bc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bc8:	8b 50 04             	mov    0x4(%eax),%edx
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107bcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bce:	8b 58 08             	mov    0x8(%eax),%ebx
80107bd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd4:	8b 40 04             	mov    0x4(%eax),%eax
80107bd7:	29 c3                	sub    %eax,%ebx
80107bd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bdc:	8b 00                	mov    (%eax),%eax
80107bde:	83 ec 0c             	sub    $0xc,%esp
80107be1:	51                   	push   %ecx
80107be2:	52                   	push   %edx
80107be3:	53                   	push   %ebx
80107be4:	50                   	push   %eax
80107be5:	ff 75 f0             	pushl  -0x10(%ebp)
80107be8:	e8 e1 fe ff ff       	call   80107ace <mappages>
80107bed:	83 c4 20             	add    $0x20,%esp
80107bf0:	85 c0                	test   %eax,%eax
80107bf2:	79 07                	jns    80107bfb <setupkvm+0x9d>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80107bf4:	b8 00 00 00 00       	mov    $0x0,%eax
80107bf9:	eb 10                	jmp    80107c0b <setupkvm+0xad>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107bfb:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107bff:	81 7d f4 00 e5 10 80 	cmpl   $0x8010e500,-0xc(%ebp)
80107c06:	72 b7                	jb     80107bbf <setupkvm+0x61>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80107c08:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107c0b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107c0e:	c9                   	leave  
80107c0f:	c3                   	ret    

80107c10 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107c10:	55                   	push   %ebp
80107c11:	89 e5                	mov    %esp,%ebp
80107c13:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107c16:	e8 43 ff ff ff       	call   80107b5e <setupkvm>
80107c1b:	a3 58 57 11 80       	mov    %eax,0x80115758
  switchkvm();
80107c20:	e8 03 00 00 00       	call   80107c28 <switchkvm>
}
80107c25:	90                   	nop
80107c26:	c9                   	leave  
80107c27:	c3                   	ret    

80107c28 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107c28:	55                   	push   %ebp
80107c29:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107c2b:	a1 58 57 11 80       	mov    0x80115758,%eax
80107c30:	50                   	push   %eax
80107c31:	e8 69 f9 ff ff       	call   8010759f <v2p>
80107c36:	83 c4 04             	add    $0x4,%esp
80107c39:	50                   	push   %eax
80107c3a:	e8 54 f9 ff ff       	call   80107593 <lcr3>
80107c3f:	83 c4 04             	add    $0x4,%esp
}
80107c42:	90                   	nop
80107c43:	c9                   	leave  
80107c44:	c3                   	ret    

80107c45 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107c45:	55                   	push   %ebp
80107c46:	89 e5                	mov    %esp,%ebp
80107c48:	56                   	push   %esi
80107c49:	53                   	push   %ebx
  pushcli();
80107c4a:	e8 82 d3 ff ff       	call   80104fd1 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107c4f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107c55:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107c5c:	83 c2 08             	add    $0x8,%edx
80107c5f:	89 d6                	mov    %edx,%esi
80107c61:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107c68:	83 c2 08             	add    $0x8,%edx
80107c6b:	c1 ea 10             	shr    $0x10,%edx
80107c6e:	89 d3                	mov    %edx,%ebx
80107c70:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107c77:	83 c2 08             	add    $0x8,%edx
80107c7a:	c1 ea 18             	shr    $0x18,%edx
80107c7d:	89 d1                	mov    %edx,%ecx
80107c7f:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107c86:	67 00 
80107c88:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
80107c8f:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80107c95:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107c9c:	83 e2 f0             	and    $0xfffffff0,%edx
80107c9f:	83 ca 09             	or     $0x9,%edx
80107ca2:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107ca8:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107caf:	83 ca 10             	or     $0x10,%edx
80107cb2:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107cb8:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107cbf:	83 e2 9f             	and    $0xffffff9f,%edx
80107cc2:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107cc8:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107ccf:	83 ca 80             	or     $0xffffff80,%edx
80107cd2:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107cd8:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107cdf:	83 e2 f0             	and    $0xfffffff0,%edx
80107ce2:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107ce8:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107cef:	83 e2 ef             	and    $0xffffffef,%edx
80107cf2:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107cf8:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107cff:	83 e2 df             	and    $0xffffffdf,%edx
80107d02:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107d08:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107d0f:	83 ca 40             	or     $0x40,%edx
80107d12:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107d18:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107d1f:	83 e2 7f             	and    $0x7f,%edx
80107d22:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107d28:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107d2e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d34:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107d3b:	83 e2 ef             	and    $0xffffffef,%edx
80107d3e:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107d44:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d4a:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80107d50:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d56:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107d5d:	8b 52 08             	mov    0x8(%edx),%edx
80107d60:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107d66:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80107d69:	83 ec 0c             	sub    $0xc,%esp
80107d6c:	6a 30                	push   $0x30
80107d6e:	e8 f3 f7 ff ff       	call   80107566 <ltr>
80107d73:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80107d76:	8b 45 08             	mov    0x8(%ebp),%eax
80107d79:	8b 40 04             	mov    0x4(%eax),%eax
80107d7c:	85 c0                	test   %eax,%eax
80107d7e:	75 0d                	jne    80107d8d <switchuvm+0x148>
    panic("switchuvm: no pgdir");
80107d80:	83 ec 0c             	sub    $0xc,%esp
80107d83:	68 33 ba 10 80       	push   $0x8010ba33
80107d88:	e8 d9 87 ff ff       	call   80100566 <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80107d8d:	8b 45 08             	mov    0x8(%ebp),%eax
80107d90:	8b 40 04             	mov    0x4(%eax),%eax
80107d93:	83 ec 0c             	sub    $0xc,%esp
80107d96:	50                   	push   %eax
80107d97:	e8 03 f8 ff ff       	call   8010759f <v2p>
80107d9c:	83 c4 10             	add    $0x10,%esp
80107d9f:	83 ec 0c             	sub    $0xc,%esp
80107da2:	50                   	push   %eax
80107da3:	e8 eb f7 ff ff       	call   80107593 <lcr3>
80107da8:	83 c4 10             	add    $0x10,%esp
  popcli();
80107dab:	e8 66 d2 ff ff       	call   80105016 <popcli>
}
80107db0:	90                   	nop
80107db1:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107db4:	5b                   	pop    %ebx
80107db5:	5e                   	pop    %esi
80107db6:	5d                   	pop    %ebp
80107db7:	c3                   	ret    

80107db8 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107db8:	55                   	push   %ebp
80107db9:	89 e5                	mov    %esp,%ebp
80107dbb:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
80107dbe:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80107dc5:	76 0d                	jbe    80107dd4 <inituvm+0x1c>
    panic("inituvm: more than a page");
80107dc7:	83 ec 0c             	sub    $0xc,%esp
80107dca:	68 47 ba 10 80       	push   $0x8010ba47
80107dcf:	e8 92 87 ff ff       	call   80100566 <panic>
  mem = kalloc();
80107dd4:	e8 27 af ff ff       	call   80102d00 <kalloc>
80107dd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80107ddc:	83 ec 04             	sub    $0x4,%esp
80107ddf:	68 00 10 00 00       	push   $0x1000
80107de4:	6a 00                	push   $0x0
80107de6:	ff 75 f4             	pushl  -0xc(%ebp)
80107de9:	e8 e9 d2 ff ff       	call   801050d7 <memset>
80107dee:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107df1:	83 ec 0c             	sub    $0xc,%esp
80107df4:	ff 75 f4             	pushl  -0xc(%ebp)
80107df7:	e8 a3 f7 ff ff       	call   8010759f <v2p>
80107dfc:	83 c4 10             	add    $0x10,%esp
80107dff:	83 ec 0c             	sub    $0xc,%esp
80107e02:	6a 06                	push   $0x6
80107e04:	50                   	push   %eax
80107e05:	68 00 10 00 00       	push   $0x1000
80107e0a:	6a 00                	push   $0x0
80107e0c:	ff 75 08             	pushl  0x8(%ebp)
80107e0f:	e8 ba fc ff ff       	call   80107ace <mappages>
80107e14:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
80107e17:	83 ec 04             	sub    $0x4,%esp
80107e1a:	ff 75 10             	pushl  0x10(%ebp)
80107e1d:	ff 75 0c             	pushl  0xc(%ebp)
80107e20:	ff 75 f4             	pushl  -0xc(%ebp)
80107e23:	e8 6e d3 ff ff       	call   80105196 <memmove>
80107e28:	83 c4 10             	add    $0x10,%esp
}
80107e2b:	90                   	nop
80107e2c:	c9                   	leave  
80107e2d:	c3                   	ret    

80107e2e <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107e2e:	55                   	push   %ebp
80107e2f:	89 e5                	mov    %esp,%ebp
80107e31:	53                   	push   %ebx
80107e32:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107e35:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e38:	25 ff 0f 00 00       	and    $0xfff,%eax
80107e3d:	85 c0                	test   %eax,%eax
80107e3f:	74 0d                	je     80107e4e <loaduvm+0x20>
    panic("loaduvm: addr must be page aligned");
80107e41:	83 ec 0c             	sub    $0xc,%esp
80107e44:	68 64 ba 10 80       	push   $0x8010ba64
80107e49:	e8 18 87 ff ff       	call   80100566 <panic>
  for(i = 0; i < sz; i += PGSIZE){
80107e4e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107e55:	e9 95 00 00 00       	jmp    80107eef <loaduvm+0xc1>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107e5a:	8b 55 0c             	mov    0xc(%ebp),%edx
80107e5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e60:	01 d0                	add    %edx,%eax
80107e62:	83 ec 04             	sub    $0x4,%esp
80107e65:	6a 00                	push   $0x0
80107e67:	50                   	push   %eax
80107e68:	ff 75 08             	pushl  0x8(%ebp)
80107e6b:	e8 be fb ff ff       	call   80107a2e <walkpgdir>
80107e70:	83 c4 10             	add    $0x10,%esp
80107e73:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107e76:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107e7a:	75 0d                	jne    80107e89 <loaduvm+0x5b>
      panic("loaduvm: address should exist");
80107e7c:	83 ec 0c             	sub    $0xc,%esp
80107e7f:	68 87 ba 10 80       	push   $0x8010ba87
80107e84:	e8 dd 86 ff ff       	call   80100566 <panic>
    pa = PTE_ADDR(*pte);
80107e89:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107e8c:	8b 00                	mov    (%eax),%eax
80107e8e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e93:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80107e96:	8b 45 18             	mov    0x18(%ebp),%eax
80107e99:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107e9c:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80107ea1:	77 0b                	ja     80107eae <loaduvm+0x80>
      n = sz - i;
80107ea3:	8b 45 18             	mov    0x18(%ebp),%eax
80107ea6:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107ea9:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107eac:	eb 07                	jmp    80107eb5 <loaduvm+0x87>
    else
      n = PGSIZE;
80107eae:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80107eb5:	8b 55 14             	mov    0x14(%ebp),%edx
80107eb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ebb:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80107ebe:	83 ec 0c             	sub    $0xc,%esp
80107ec1:	ff 75 e8             	pushl  -0x18(%ebp)
80107ec4:	e8 e3 f6 ff ff       	call   801075ac <p2v>
80107ec9:	83 c4 10             	add    $0x10,%esp
80107ecc:	ff 75 f0             	pushl  -0x10(%ebp)
80107ecf:	53                   	push   %ebx
80107ed0:	50                   	push   %eax
80107ed1:	ff 75 10             	pushl  0x10(%ebp)
80107ed4:	e8 d5 a0 ff ff       	call   80101fae <readi>
80107ed9:	83 c4 10             	add    $0x10,%esp
80107edc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107edf:	74 07                	je     80107ee8 <loaduvm+0xba>
      return -1;
80107ee1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107ee6:	eb 18                	jmp    80107f00 <loaduvm+0xd2>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107ee8:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107eef:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ef2:	3b 45 18             	cmp    0x18(%ebp),%eax
80107ef5:	0f 82 5f ff ff ff    	jb     80107e5a <loaduvm+0x2c>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80107efb:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107f00:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107f03:	c9                   	leave  
80107f04:	c3                   	ret    

80107f05 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107f05:	55                   	push   %ebp
80107f06:	89 e5                	mov    %esp,%ebp
80107f08:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80107f0b:	8b 45 10             	mov    0x10(%ebp),%eax
80107f0e:	85 c0                	test   %eax,%eax
80107f10:	79 0a                	jns    80107f1c <allocuvm+0x17>
    return 0;
80107f12:	b8 00 00 00 00       	mov    $0x0,%eax
80107f17:	e9 b0 00 00 00       	jmp    80107fcc <allocuvm+0xc7>
  if(newsz < oldsz)
80107f1c:	8b 45 10             	mov    0x10(%ebp),%eax
80107f1f:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107f22:	73 08                	jae    80107f2c <allocuvm+0x27>
    return oldsz;
80107f24:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f27:	e9 a0 00 00 00       	jmp    80107fcc <allocuvm+0xc7>

  a = PGROUNDUP(oldsz);
80107f2c:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f2f:	05 ff 0f 00 00       	add    $0xfff,%eax
80107f34:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f39:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
80107f3c:	eb 7f                	jmp    80107fbd <allocuvm+0xb8>
    mem = kalloc();
80107f3e:	e8 bd ad ff ff       	call   80102d00 <kalloc>
80107f43:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80107f46:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107f4a:	75 2b                	jne    80107f77 <allocuvm+0x72>
      cprintf("allocuvm out of memory\n");
80107f4c:	83 ec 0c             	sub    $0xc,%esp
80107f4f:	68 a5 ba 10 80       	push   $0x8010baa5
80107f54:	e8 6d 84 ff ff       	call   801003c6 <cprintf>
80107f59:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
80107f5c:	83 ec 04             	sub    $0x4,%esp
80107f5f:	ff 75 0c             	pushl  0xc(%ebp)
80107f62:	ff 75 10             	pushl  0x10(%ebp)
80107f65:	ff 75 08             	pushl  0x8(%ebp)
80107f68:	e8 61 00 00 00       	call   80107fce <deallocuvm>
80107f6d:	83 c4 10             	add    $0x10,%esp
      return 0;
80107f70:	b8 00 00 00 00       	mov    $0x0,%eax
80107f75:	eb 55                	jmp    80107fcc <allocuvm+0xc7>
    }
    memset(mem, 0, PGSIZE);
80107f77:	83 ec 04             	sub    $0x4,%esp
80107f7a:	68 00 10 00 00       	push   $0x1000
80107f7f:	6a 00                	push   $0x0
80107f81:	ff 75 f0             	pushl  -0x10(%ebp)
80107f84:	e8 4e d1 ff ff       	call   801050d7 <memset>
80107f89:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107f8c:	83 ec 0c             	sub    $0xc,%esp
80107f8f:	ff 75 f0             	pushl  -0x10(%ebp)
80107f92:	e8 08 f6 ff ff       	call   8010759f <v2p>
80107f97:	83 c4 10             	add    $0x10,%esp
80107f9a:	89 c2                	mov    %eax,%edx
80107f9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f9f:	83 ec 0c             	sub    $0xc,%esp
80107fa2:	6a 06                	push   $0x6
80107fa4:	52                   	push   %edx
80107fa5:	68 00 10 00 00       	push   $0x1000
80107faa:	50                   	push   %eax
80107fab:	ff 75 08             	pushl  0x8(%ebp)
80107fae:	e8 1b fb ff ff       	call   80107ace <mappages>
80107fb3:	83 c4 20             	add    $0x20,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107fb6:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107fbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fc0:	3b 45 10             	cmp    0x10(%ebp),%eax
80107fc3:	0f 82 75 ff ff ff    	jb     80107f3e <allocuvm+0x39>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
80107fc9:	8b 45 10             	mov    0x10(%ebp),%eax
}
80107fcc:	c9                   	leave  
80107fcd:	c3                   	ret    

80107fce <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107fce:	55                   	push   %ebp
80107fcf:	89 e5                	mov    %esp,%ebp
80107fd1:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80107fd4:	8b 45 10             	mov    0x10(%ebp),%eax
80107fd7:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107fda:	72 08                	jb     80107fe4 <deallocuvm+0x16>
    return oldsz;
80107fdc:	8b 45 0c             	mov    0xc(%ebp),%eax
80107fdf:	e9 a5 00 00 00       	jmp    80108089 <deallocuvm+0xbb>

  a = PGROUNDUP(newsz);
80107fe4:	8b 45 10             	mov    0x10(%ebp),%eax
80107fe7:	05 ff 0f 00 00       	add    $0xfff,%eax
80107fec:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ff1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107ff4:	e9 81 00 00 00       	jmp    8010807a <deallocuvm+0xac>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107ff9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ffc:	83 ec 04             	sub    $0x4,%esp
80107fff:	6a 00                	push   $0x0
80108001:	50                   	push   %eax
80108002:	ff 75 08             	pushl  0x8(%ebp)
80108005:	e8 24 fa ff ff       	call   80107a2e <walkpgdir>
8010800a:	83 c4 10             	add    $0x10,%esp
8010800d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80108010:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108014:	75 09                	jne    8010801f <deallocuvm+0x51>
      a += (NPTENTRIES - 1) * PGSIZE;
80108016:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
8010801d:	eb 54                	jmp    80108073 <deallocuvm+0xa5>
    else if((*pte & PTE_P) != 0){
8010801f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108022:	8b 00                	mov    (%eax),%eax
80108024:	83 e0 01             	and    $0x1,%eax
80108027:	85 c0                	test   %eax,%eax
80108029:	74 48                	je     80108073 <deallocuvm+0xa5>
      pa = PTE_ADDR(*pte);
8010802b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010802e:	8b 00                	mov    (%eax),%eax
80108030:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108035:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
80108038:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010803c:	75 0d                	jne    8010804b <deallocuvm+0x7d>
        panic("kfree");
8010803e:	83 ec 0c             	sub    $0xc,%esp
80108041:	68 bd ba 10 80       	push   $0x8010babd
80108046:	e8 1b 85 ff ff       	call   80100566 <panic>
      char *v = p2v(pa);
8010804b:	83 ec 0c             	sub    $0xc,%esp
8010804e:	ff 75 ec             	pushl  -0x14(%ebp)
80108051:	e8 56 f5 ff ff       	call   801075ac <p2v>
80108056:	83 c4 10             	add    $0x10,%esp
80108059:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
8010805c:	83 ec 0c             	sub    $0xc,%esp
8010805f:	ff 75 e8             	pushl  -0x18(%ebp)
80108062:	e8 fc ab ff ff       	call   80102c63 <kfree>
80108067:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
8010806a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010806d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80108073:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010807a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010807d:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108080:	0f 82 73 ff ff ff    	jb     80107ff9 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
80108086:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108089:	c9                   	leave  
8010808a:	c3                   	ret    

8010808b <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
8010808b:	55                   	push   %ebp
8010808c:	89 e5                	mov    %esp,%ebp
8010808e:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
80108091:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80108095:	75 0d                	jne    801080a4 <freevm+0x19>
    panic("freevm: no pgdir");
80108097:	83 ec 0c             	sub    $0xc,%esp
8010809a:	68 c3 ba 10 80       	push   $0x8010bac3
8010809f:	e8 c2 84 ff ff       	call   80100566 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
801080a4:	83 ec 04             	sub    $0x4,%esp
801080a7:	6a 00                	push   $0x0
801080a9:	68 00 00 00 80       	push   $0x80000000
801080ae:	ff 75 08             	pushl  0x8(%ebp)
801080b1:	e8 18 ff ff ff       	call   80107fce <deallocuvm>
801080b6:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801080b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801080c0:	eb 4f                	jmp    80108111 <freevm+0x86>
    if(pgdir[i] & PTE_P){
801080c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080c5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801080cc:	8b 45 08             	mov    0x8(%ebp),%eax
801080cf:	01 d0                	add    %edx,%eax
801080d1:	8b 00                	mov    (%eax),%eax
801080d3:	83 e0 01             	and    $0x1,%eax
801080d6:	85 c0                	test   %eax,%eax
801080d8:	74 33                	je     8010810d <freevm+0x82>
      char * v = p2v(PTE_ADDR(pgdir[i]));
801080da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801080e4:	8b 45 08             	mov    0x8(%ebp),%eax
801080e7:	01 d0                	add    %edx,%eax
801080e9:	8b 00                	mov    (%eax),%eax
801080eb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080f0:	83 ec 0c             	sub    $0xc,%esp
801080f3:	50                   	push   %eax
801080f4:	e8 b3 f4 ff ff       	call   801075ac <p2v>
801080f9:	83 c4 10             	add    $0x10,%esp
801080fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
801080ff:	83 ec 0c             	sub    $0xc,%esp
80108102:	ff 75 f0             	pushl  -0x10(%ebp)
80108105:	e8 59 ab ff ff       	call   80102c63 <kfree>
8010810a:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
8010810d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108111:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80108118:	76 a8                	jbe    801080c2 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
8010811a:	83 ec 0c             	sub    $0xc,%esp
8010811d:	ff 75 08             	pushl  0x8(%ebp)
80108120:	e8 3e ab ff ff       	call   80102c63 <kfree>
80108125:	83 c4 10             	add    $0x10,%esp
}
80108128:	90                   	nop
80108129:	c9                   	leave  
8010812a:	c3                   	ret    

8010812b <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
8010812b:	55                   	push   %ebp
8010812c:	89 e5                	mov    %esp,%ebp
8010812e:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108131:	83 ec 04             	sub    $0x4,%esp
80108134:	6a 00                	push   $0x0
80108136:	ff 75 0c             	pushl  0xc(%ebp)
80108139:	ff 75 08             	pushl  0x8(%ebp)
8010813c:	e8 ed f8 ff ff       	call   80107a2e <walkpgdir>
80108141:	83 c4 10             	add    $0x10,%esp
80108144:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
80108147:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010814b:	75 0d                	jne    8010815a <clearpteu+0x2f>
    panic("clearpteu");
8010814d:	83 ec 0c             	sub    $0xc,%esp
80108150:	68 d4 ba 10 80       	push   $0x8010bad4
80108155:	e8 0c 84 ff ff       	call   80100566 <panic>
  *pte &= ~PTE_U;
8010815a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010815d:	8b 00                	mov    (%eax),%eax
8010815f:	83 e0 fb             	and    $0xfffffffb,%eax
80108162:	89 c2                	mov    %eax,%edx
80108164:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108167:	89 10                	mov    %edx,(%eax)
}
80108169:	90                   	nop
8010816a:	c9                   	leave  
8010816b:	c3                   	ret    

8010816c <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
8010816c:	55                   	push   %ebp
8010816d:	89 e5                	mov    %esp,%ebp
8010816f:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
80108172:	e8 e7 f9 ff ff       	call   80107b5e <setupkvm>
80108177:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010817a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010817e:	75 0a                	jne    8010818a <copyuvm+0x1e>
    return 0;
80108180:	b8 00 00 00 00       	mov    $0x0,%eax
80108185:	e9 e9 00 00 00       	jmp    80108273 <copyuvm+0x107>
  for(i = 0; i < sz; i += PGSIZE){
8010818a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108191:	e9 b5 00 00 00       	jmp    8010824b <copyuvm+0xdf>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108196:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108199:	83 ec 04             	sub    $0x4,%esp
8010819c:	6a 00                	push   $0x0
8010819e:	50                   	push   %eax
8010819f:	ff 75 08             	pushl  0x8(%ebp)
801081a2:	e8 87 f8 ff ff       	call   80107a2e <walkpgdir>
801081a7:	83 c4 10             	add    $0x10,%esp
801081aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
801081ad:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801081b1:	75 0d                	jne    801081c0 <copyuvm+0x54>
      panic("copyuvm: pte should exist");
801081b3:	83 ec 0c             	sub    $0xc,%esp
801081b6:	68 de ba 10 80       	push   $0x8010bade
801081bb:	e8 a6 83 ff ff       	call   80100566 <panic>
    if(!(*pte & PTE_P))
801081c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801081c3:	8b 00                	mov    (%eax),%eax
801081c5:	83 e0 01             	and    $0x1,%eax
801081c8:	85 c0                	test   %eax,%eax
801081ca:	75 0d                	jne    801081d9 <copyuvm+0x6d>
      panic("copyuvm: page not present");
801081cc:	83 ec 0c             	sub    $0xc,%esp
801081cf:	68 f8 ba 10 80       	push   $0x8010baf8
801081d4:	e8 8d 83 ff ff       	call   80100566 <panic>
    pa = PTE_ADDR(*pte);
801081d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801081dc:	8b 00                	mov    (%eax),%eax
801081de:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801081e3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if((mem = kalloc()) == 0)
801081e6:	e8 15 ab ff ff       	call   80102d00 <kalloc>
801081eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801081ee:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
801081f2:	74 68                	je     8010825c <copyuvm+0xf0>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
801081f4:	83 ec 0c             	sub    $0xc,%esp
801081f7:	ff 75 e8             	pushl  -0x18(%ebp)
801081fa:	e8 ad f3 ff ff       	call   801075ac <p2v>
801081ff:	83 c4 10             	add    $0x10,%esp
80108202:	83 ec 04             	sub    $0x4,%esp
80108205:	68 00 10 00 00       	push   $0x1000
8010820a:	50                   	push   %eax
8010820b:	ff 75 e4             	pushl  -0x1c(%ebp)
8010820e:	e8 83 cf ff ff       	call   80105196 <memmove>
80108213:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
80108216:	83 ec 0c             	sub    $0xc,%esp
80108219:	ff 75 e4             	pushl  -0x1c(%ebp)
8010821c:	e8 7e f3 ff ff       	call   8010759f <v2p>
80108221:	83 c4 10             	add    $0x10,%esp
80108224:	89 c2                	mov    %eax,%edx
80108226:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108229:	83 ec 0c             	sub    $0xc,%esp
8010822c:	6a 06                	push   $0x6
8010822e:	52                   	push   %edx
8010822f:	68 00 10 00 00       	push   $0x1000
80108234:	50                   	push   %eax
80108235:	ff 75 f0             	pushl  -0x10(%ebp)
80108238:	e8 91 f8 ff ff       	call   80107ace <mappages>
8010823d:	83 c4 20             	add    $0x20,%esp
80108240:	85 c0                	test   %eax,%eax
80108242:	78 1b                	js     8010825f <copyuvm+0xf3>
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108244:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010824b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010824e:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108251:	0f 82 3f ff ff ff    	jb     80108196 <copyuvm+0x2a>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
  }
  return d;
80108257:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010825a:	eb 17                	jmp    80108273 <copyuvm+0x107>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
8010825c:	90                   	nop
8010825d:	eb 01                	jmp    80108260 <copyuvm+0xf4>
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
8010825f:	90                   	nop
  }
  return d;

bad:
  freevm(d);
80108260:	83 ec 0c             	sub    $0xc,%esp
80108263:	ff 75 f0             	pushl  -0x10(%ebp)
80108266:	e8 20 fe ff ff       	call   8010808b <freevm>
8010826b:	83 c4 10             	add    $0x10,%esp
  return 0;
8010826e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108273:	c9                   	leave  
80108274:	c3                   	ret    

80108275 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108275:	55                   	push   %ebp
80108276:	89 e5                	mov    %esp,%ebp
80108278:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
8010827b:	83 ec 04             	sub    $0x4,%esp
8010827e:	6a 00                	push   $0x0
80108280:	ff 75 0c             	pushl  0xc(%ebp)
80108283:	ff 75 08             	pushl  0x8(%ebp)
80108286:	e8 a3 f7 ff ff       	call   80107a2e <walkpgdir>
8010828b:	83 c4 10             	add    $0x10,%esp
8010828e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
80108291:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108294:	8b 00                	mov    (%eax),%eax
80108296:	83 e0 01             	and    $0x1,%eax
80108299:	85 c0                	test   %eax,%eax
8010829b:	75 07                	jne    801082a4 <uva2ka+0x2f>
    return 0;
8010829d:	b8 00 00 00 00       	mov    $0x0,%eax
801082a2:	eb 29                	jmp    801082cd <uva2ka+0x58>
  if((*pte & PTE_U) == 0)
801082a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082a7:	8b 00                	mov    (%eax),%eax
801082a9:	83 e0 04             	and    $0x4,%eax
801082ac:	85 c0                	test   %eax,%eax
801082ae:	75 07                	jne    801082b7 <uva2ka+0x42>
    return 0;
801082b0:	b8 00 00 00 00       	mov    $0x0,%eax
801082b5:	eb 16                	jmp    801082cd <uva2ka+0x58>
  return (char*)p2v(PTE_ADDR(*pte));
801082b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082ba:	8b 00                	mov    (%eax),%eax
801082bc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082c1:	83 ec 0c             	sub    $0xc,%esp
801082c4:	50                   	push   %eax
801082c5:	e8 e2 f2 ff ff       	call   801075ac <p2v>
801082ca:	83 c4 10             	add    $0x10,%esp
}
801082cd:	c9                   	leave  
801082ce:	c3                   	ret    

801082cf <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801082cf:	55                   	push   %ebp
801082d0:	89 e5                	mov    %esp,%ebp
801082d2:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
801082d5:	8b 45 10             	mov    0x10(%ebp),%eax
801082d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
801082db:	eb 7f                	jmp    8010835c <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
801082dd:	8b 45 0c             	mov    0xc(%ebp),%eax
801082e0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
801082e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801082eb:	83 ec 08             	sub    $0x8,%esp
801082ee:	50                   	push   %eax
801082ef:	ff 75 08             	pushl  0x8(%ebp)
801082f2:	e8 7e ff ff ff       	call   80108275 <uva2ka>
801082f7:	83 c4 10             	add    $0x10,%esp
801082fa:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
801082fd:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80108301:	75 07                	jne    8010830a <copyout+0x3b>
      return -1;
80108303:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108308:	eb 61                	jmp    8010836b <copyout+0x9c>
    n = PGSIZE - (va - va0);
8010830a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010830d:	2b 45 0c             	sub    0xc(%ebp),%eax
80108310:	05 00 10 00 00       	add    $0x1000,%eax
80108315:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
80108318:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010831b:	3b 45 14             	cmp    0x14(%ebp),%eax
8010831e:	76 06                	jbe    80108326 <copyout+0x57>
      n = len;
80108320:	8b 45 14             	mov    0x14(%ebp),%eax
80108323:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
80108326:	8b 45 0c             	mov    0xc(%ebp),%eax
80108329:	2b 45 ec             	sub    -0x14(%ebp),%eax
8010832c:	89 c2                	mov    %eax,%edx
8010832e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108331:	01 d0                	add    %edx,%eax
80108333:	83 ec 04             	sub    $0x4,%esp
80108336:	ff 75 f0             	pushl  -0x10(%ebp)
80108339:	ff 75 f4             	pushl  -0xc(%ebp)
8010833c:	50                   	push   %eax
8010833d:	e8 54 ce ff ff       	call   80105196 <memmove>
80108342:	83 c4 10             	add    $0x10,%esp
    len -= n;
80108345:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108348:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
8010834b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010834e:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
80108351:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108354:	05 00 10 00 00       	add    $0x1000,%eax
80108359:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010835c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80108360:	0f 85 77 ff ff ff    	jne    801082dd <copyout+0xe>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80108366:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010836b:	c9                   	leave  
8010836c:	c3                   	ret    

8010836d <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
8010836d:	55                   	push   %ebp
8010836e:	89 e5                	mov    %esp,%ebp
80108370:	83 ec 1c             	sub    $0x1c,%esp
80108373:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80108376:	8b 55 10             	mov    0x10(%ebp),%edx
80108379:	8b 45 14             	mov    0x14(%ebp),%eax
8010837c:	88 4d ec             	mov    %cl,-0x14(%ebp)
8010837f:	88 55 e8             	mov    %dl,-0x18(%ebp)
80108382:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
80108385:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80108389:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
8010838c:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
80108390:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
80108393:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
80108397:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
8010839a:	8b 45 08             	mov    0x8(%ebp),%eax
8010839d:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
801083a1:	66 89 10             	mov    %dx,(%eax)
801083a4:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
801083a8:	88 50 02             	mov    %dl,0x2(%eax)
}
801083ab:	8b 45 08             	mov    0x8(%ebp),%eax
801083ae:	c9                   	leave  
801083af:	c2 04 00             	ret    $0x4

801083b2 <APCharacterMove>:
//0 -- left 1--right
int direction = 1;


void APCharacterMove(int direction)
{
801083b2:	55                   	push   %ebp
801083b3:	89 e5                	mov    %esp,%ebp
{

}


}
801083b5:	90                   	nop
801083b6:	5d                   	pop    %ebp
801083b7:	c3                   	ret    

801083b8 <APDrawCharacter>:

//character_move
void APDrawCharacter(int is_grid)
{
801083b8:	55                   	push   %ebp
801083b9:	89 e5                	mov    %esp,%ebp
801083bb:	56                   	push   %esi
801083bc:	53                   	push   %ebx
801083bd:	83 ec 20             	sub    $0x20,%esp
    //cprintf("in drawCharacter!\n");
    acquire(&screenLock);
801083c0:	83 ec 0c             	sub    $0xc,%esp
801083c3:	68 60 57 11 80       	push   $0x80115760
801083c8:	e8 a7 ca ff ff       	call   80104e74 <acquire>
801083cd:	83 c4 10             	add    $0x10,%esp
    if (is_grid)
801083d0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801083d4:	0f 84 df 01 00 00    	je     801085b9 <APDrawCharacter+0x201>
    {
        int off = (character_pre_y * GRID_WIDTH + WND_TITLE_HEIGHT)* screenWidth + character_pre_x * GRID_WIDTH;
801083da:	a1 a0 e6 10 80       	mov    0x8010e6a0,%eax
801083df:	83 c0 01             	add    $0x1,%eax
801083e2:	6b d0 32             	imul   $0x32,%eax,%edx
801083e5:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
801083ec:	0f b7 c0             	movzwl %ax,%eax
801083ef:	0f af d0             	imul   %eax,%edx
801083f2:	a1 9c e6 10 80       	mov    0x8010e69c,%eax
801083f7:	6b c0 32             	imul   $0x32,%eax,%eax
801083fa:	01 d0                	add    %edx,%eax
801083fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
        int size = sizeof(AColor) * GRID_WIDTH;
801083ff:	c7 45 e4 96 00 00 00 	movl   $0x96,-0x1c(%ebp)
        for (int j = 0; j < GRID_WIDTH; j++)
80108406:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010840d:	eb 77                	jmp    80108486 <APDrawCharacter+0xce>
        {
            memmove(screenBuf + off, screenContent + off,size);
8010840f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80108412:	8b 1d b0 e6 10 80    	mov    0x8010e6b0,%ebx
80108418:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010841b:	89 d0                	mov    %edx,%eax
8010841d:	01 c0                	add    %eax,%eax
8010841f:	01 d0                	add    %edx,%eax
80108421:	01 c3                	add    %eax,%ebx
80108423:	8b 35 ac e6 10 80    	mov    0x8010e6ac,%esi
80108429:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010842c:	89 d0                	mov    %edx,%eax
8010842e:	01 c0                	add    %eax,%eax
80108430:	01 d0                	add    %edx,%eax
80108432:	01 f0                	add    %esi,%eax
80108434:	83 ec 04             	sub    $0x4,%esp
80108437:	51                   	push   %ecx
80108438:	53                   	push   %ebx
80108439:	50                   	push   %eax
8010843a:	e8 57 cd ff ff       	call   80105196 <memmove>
8010843f:	83 c4 10             	add    $0x10,%esp
            memmove(screenAddr + off,screenContent + off,size);
80108442:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80108445:	8b 1d b0 e6 10 80    	mov    0x8010e6b0,%ebx
8010844b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010844e:	89 d0                	mov    %edx,%eax
80108450:	01 c0                	add    %eax,%eax
80108452:	01 d0                	add    %edx,%eax
80108454:	01 c3                	add    %eax,%ebx
80108456:	8b 35 a8 e6 10 80    	mov    0x8010e6a8,%esi
8010845c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010845f:	89 d0                	mov    %edx,%eax
80108461:	01 c0                	add    %eax,%eax
80108463:	01 d0                	add    %edx,%eax
80108465:	01 f0                	add    %esi,%eax
80108467:	83 ec 04             	sub    $0x4,%esp
8010846a:	51                   	push   %ecx
8010846b:	53                   	push   %ebx
8010846c:	50                   	push   %eax
8010846d:	e8 24 cd ff ff       	call   80105196 <memmove>
80108472:	83 c4 10             	add    $0x10,%esp
            off += screenWidth;
80108475:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010847c:	0f b7 c0             	movzwl %ax,%eax
8010847f:	01 45 f4             	add    %eax,-0xc(%ebp)
    acquire(&screenLock);
    if (is_grid)
    {
        int off = (character_pre_y * GRID_WIDTH + WND_TITLE_HEIGHT)* screenWidth + character_pre_x * GRID_WIDTH;
        int size = sizeof(AColor) * GRID_WIDTH;
        for (int j = 0; j < GRID_WIDTH; j++)
80108482:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80108486:	83 7d f0 31          	cmpl   $0x31,-0x10(%ebp)
8010848a:	7e 83                	jle    8010840f <APDrawCharacter+0x57>
        {
            memmove(screenBuf + off, screenContent + off,size);
            memmove(screenAddr + off,screenContent + off,size);
            off += screenWidth;
        }
        off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT) * screenWidth + character_x * GRID_WIDTH;
8010848c:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80108491:	83 c0 01             	add    $0x1,%eax
80108494:	6b d0 32             	imul   $0x32,%eax,%edx
80108497:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010849e:	0f b7 c0             	movzwl %ax,%eax
801084a1:	0f af d0             	imul   %eax,%edx
801084a4:	a1 00 e5 10 80       	mov    0x8010e500,%eax
801084a9:	6b c0 32             	imul   $0x32,%eax,%eax
801084ac:	01 d0                	add    %edx,%eax
801084ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
        
            
        for (int j = 0; j < GRID_WIDTH; j++)
801084b1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
801084b8:	e9 f2 00 00 00       	jmp    801085af <APDrawCharacter+0x1f7>
        {
            for (int i = 0; i < GRID_WIDTH; i++)
801084bd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
801084c4:	e9 cb 00 00 00       	jmp    80108594 <APDrawCharacter+0x1dc>
            {
                AColor c;
                if (direction == 1) c = character_img[i][j];
801084c9:	a1 08 e5 10 80       	mov    0x8010e508,%eax
801084ce:	83 f8 01             	cmp    $0x1,%eax
801084d1:	75 29                	jne    801084fc <APDrawCharacter+0x144>
801084d3:	8b 55 ec             	mov    -0x14(%ebp),%edx
801084d6:	8b 4d e8             	mov    -0x18(%ebp),%ecx
801084d9:	89 d0                	mov    %edx,%eax
801084db:	01 c0                	add    %eax,%eax
801084dd:	01 d0                	add    %edx,%eax
801084df:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801084e5:	01 d0                	add    %edx,%eax
801084e7:	05 c0 78 11 80       	add    $0x801178c0,%eax
801084ec:	0f b7 10             	movzwl (%eax),%edx
801084ef:	66 89 55 e1          	mov    %dx,-0x1f(%ebp)
801084f3:	0f b6 40 02          	movzbl 0x2(%eax),%eax
801084f7:	88 45 e3             	mov    %al,-0x1d(%ebp)
801084fa:	eb 30                	jmp    8010852c <APDrawCharacter+0x174>
                else if (direction == 0)  c = character_img2[i][j];
801084fc:	a1 08 e5 10 80       	mov    0x8010e508,%eax
80108501:	85 c0                	test   %eax,%eax
80108503:	75 27                	jne    8010852c <APDrawCharacter+0x174>
80108505:	8b 55 ec             	mov    -0x14(%ebp),%edx
80108508:	8b 4d e8             	mov    -0x18(%ebp),%ecx
8010850b:	89 d0                	mov    %edx,%eax
8010850d:	01 c0                	add    %eax,%eax
8010850f:	01 d0                	add    %edx,%eax
80108511:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108517:	01 d0                	add    %edx,%eax
80108519:	05 20 96 11 80       	add    $0x80119620,%eax
8010851e:	0f b7 10             	movzwl (%eax),%edx
80108521:	66 89 55 e1          	mov    %dx,-0x1f(%ebp)
80108525:	0f b6 40 02          	movzbl 0x2(%eax),%eax
80108529:	88 45 e3             	mov    %al,-0x1d(%ebp)
                
                if (c.r != COLOR_TRANSPARENT || c.g != COLOR_TRANSPARENT || c.b != COLOR_TRANSPARENT)
8010852c:	0f b6 45 e3          	movzbl -0x1d(%ebp),%eax
80108530:	3c 0c                	cmp    $0xc,%al
80108532:	75 10                	jne    80108544 <APDrawCharacter+0x18c>
80108534:	0f b6 45 e2          	movzbl -0x1e(%ebp),%eax
80108538:	3c 0c                	cmp    $0xc,%al
8010853a:	75 08                	jne    80108544 <APDrawCharacter+0x18c>
8010853c:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
80108540:	3c 0c                	cmp    $0xc,%al
80108542:	74 4c                	je     80108590 <APDrawCharacter+0x1d8>
                {
                    screenBuf[off + i] = c;
80108544:	8b 15 ac e6 10 80    	mov    0x8010e6ac,%edx
8010854a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010854d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108550:	01 c8                	add    %ecx,%eax
80108552:	89 c1                	mov    %eax,%ecx
80108554:	89 c8                	mov    %ecx,%eax
80108556:	01 c0                	add    %eax,%eax
80108558:	01 c8                	add    %ecx,%eax
8010855a:	01 d0                	add    %edx,%eax
8010855c:	0f b7 55 e1          	movzwl -0x1f(%ebp),%edx
80108560:	66 89 10             	mov    %dx,(%eax)
80108563:	0f b6 55 e3          	movzbl -0x1d(%ebp),%edx
80108567:	88 50 02             	mov    %dl,0x2(%eax)
                    screenAddr[off + i] = c;
8010856a:	8b 15 a8 e6 10 80    	mov    0x8010e6a8,%edx
80108570:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80108573:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108576:	01 c8                	add    %ecx,%eax
80108578:	89 c1                	mov    %eax,%ecx
8010857a:	89 c8                	mov    %ecx,%eax
8010857c:	01 c0                	add    %eax,%eax
8010857e:	01 c8                	add    %ecx,%eax
80108580:	01 d0                	add    %edx,%eax
80108582:	0f b7 55 e1          	movzwl -0x1f(%ebp),%edx
80108586:	66 89 10             	mov    %dx,(%eax)
80108589:	0f b6 55 e3          	movzbl -0x1d(%ebp),%edx
8010858d:	88 50 02             	mov    %dl,0x2(%eax)
        off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT) * screenWidth + character_x * GRID_WIDTH;
        
            
        for (int j = 0; j < GRID_WIDTH; j++)
        {
            for (int i = 0; i < GRID_WIDTH; i++)
80108590:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
80108594:	83 7d e8 31          	cmpl   $0x31,-0x18(%ebp)
80108598:	0f 8e 2b ff ff ff    	jle    801084c9 <APDrawCharacter+0x111>
                {
                    screenBuf[off + i] = c;
                    screenAddr[off + i] = c;
                }
            }
            off += screenWidth;
8010859e:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
801085a5:	0f b7 c0             	movzwl %ax,%eax
801085a8:	01 45 f4             	add    %eax,-0xc(%ebp)
            off += screenWidth;
        }
        off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT) * screenWidth + character_x * GRID_WIDTH;
        
            
        for (int j = 0; j < GRID_WIDTH; j++)
801085ab:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801085af:	83 7d ec 31          	cmpl   $0x31,-0x14(%ebp)
801085b3:	0f 8e 04 ff ff ff    	jle    801084bd <APDrawCharacter+0x105>
                }
            }
            off += screenWidth;
        }
    }
    release(&screenLock);
801085b9:	83 ec 0c             	sub    $0xc,%esp
801085bc:	68 60 57 11 80       	push   $0x80115760
801085c1:	e8 15 c9 ff ff       	call   80104edb <release>
801085c6:	83 c4 10             	add    $0x10,%esp
}
801085c9:	90                   	nop
801085ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
801085cd:	5b                   	pop    %ebx
801085ce:	5e                   	pop    %esi
801085cf:	5d                   	pop    %ebp
801085d0:	c3                   	ret    

801085d1 <APCharacterInit>:
ATimerList timerList;

int timerListReady = 0;

void APCharacterInit(void)
{
801085d1:	55                   	push   %ebp
801085d2:	89 e5                	mov    %esp,%ebp
801085d4:	53                   	push   %ebx
801085d5:	81 ec b4 00 00 00    	sub    $0xb4,%esp
    for (int j = 0; j < GRID_WIDTH; j++)
801085db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801085e2:	e9 a4 00 00 00       	jmp    8010868b <APCharacterInit+0xba>
        for (int i = 0; i < GRID_WIDTH; i++)
801085e7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801085ee:	e9 8a 00 00 00       	jmp    8010867d <APCharacterInit+0xac>
        {
            character_img[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
801085f3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801085f6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801085f9:	89 d0                	mov    %edx,%eax
801085fb:	01 c0                	add    %eax,%eax
801085fd:	01 d0                	add    %edx,%eax
801085ff:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108605:	01 d0                	add    %edx,%eax
80108607:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010860d:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108613:	6a 0c                	push   $0xc
80108615:	6a 0c                	push   $0xc
80108617:	6a 0c                	push   $0xc
80108619:	50                   	push   %eax
8010861a:	e8 4e fd ff ff       	call   8010836d <RGB>
8010861f:	83 c4 0c             	add    $0xc,%esp
80108622:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108629:	66 89 03             	mov    %ax,(%ebx)
8010862c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108633:	88 43 02             	mov    %al,0x2(%ebx)
            character_img2[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
80108636:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108639:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010863c:	89 d0                	mov    %edx,%eax
8010863e:	01 c0                	add    %eax,%eax
80108640:	01 d0                	add    %edx,%eax
80108642:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108648:	01 d0                	add    %edx,%eax
8010864a:	8d 98 20 96 11 80    	lea    -0x7fee69e0(%eax),%ebx
80108650:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108656:	6a 0c                	push   $0xc
80108658:	6a 0c                	push   $0xc
8010865a:	6a 0c                	push   $0xc
8010865c:	50                   	push   %eax
8010865d:	e8 0b fd ff ff       	call   8010836d <RGB>
80108662:	83 c4 0c             	add    $0xc,%esp
80108665:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010866c:	66 89 03             	mov    %ax,(%ebx)
8010866f:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108676:	88 43 02             	mov    %al,0x2(%ebx)
int timerListReady = 0;

void APCharacterInit(void)
{
    for (int j = 0; j < GRID_WIDTH; j++)
        for (int i = 0; i < GRID_WIDTH; i++)
80108679:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010867d:	83 7d f0 31          	cmpl   $0x31,-0x10(%ebp)
80108681:	0f 8e 6c ff ff ff    	jle    801085f3 <APCharacterInit+0x22>

int timerListReady = 0;

void APCharacterInit(void)
{
    for (int j = 0; j < GRID_WIDTH; j++)
80108687:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010868b:	83 7d f4 31          	cmpl   $0x31,-0xc(%ebp)
8010868f:	0f 8e 52 ff ff ff    	jle    801085e7 <APCharacterInit+0x16>
            character_img[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
            character_img2[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
        }
    //

    int line=0;
80108695:	c7 85 64 ff ff ff 00 	movl   $0x0,-0x9c(%ebp)
8010869c:	00 00 00 
  
    for(int j=line;j<line+3;j++)
8010869f:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801086a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
801086a8:	eb 5d                	jmp    80108707 <APCharacterInit+0x136>
	for(int i=10;i<25;i++)
801086aa:	c7 45 e8 0a 00 00 00 	movl   $0xa,-0x18(%ebp)
801086b1:	eb 4a                	jmp    801086fd <APCharacterInit+0x12c>
		character_img[i][j] = RGB(0xff,0x00,0x00);
801086b3:	8b 55 ec             	mov    -0x14(%ebp),%edx
801086b6:	8b 4d e8             	mov    -0x18(%ebp),%ecx
801086b9:	89 d0                	mov    %edx,%eax
801086bb:	01 c0                	add    %eax,%eax
801086bd:	01 d0                	add    %edx,%eax
801086bf:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801086c5:	01 d0                	add    %edx,%eax
801086c7:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801086cd:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801086d3:	6a 00                	push   $0x0
801086d5:	6a 00                	push   $0x0
801086d7:	68 ff 00 00 00       	push   $0xff
801086dc:	50                   	push   %eax
801086dd:	e8 8b fc ff ff       	call   8010836d <RGB>
801086e2:	83 c4 0c             	add    $0xc,%esp
801086e5:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801086ec:	66 89 03             	mov    %ax,(%ebx)
801086ef:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801086f6:	88 43 02             	mov    %al,0x2(%ebx)
    //

    int line=0;
  
    for(int j=line;j<line+3;j++)
	for(int i=10;i<25;i++)
801086f9:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
801086fd:	83 7d e8 18          	cmpl   $0x18,-0x18(%ebp)
80108701:	7e b0                	jle    801086b3 <APCharacterInit+0xe2>
        }
    //

    int line=0;
  
    for(int j=line;j<line+3;j++)
80108703:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80108707:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010870d:	83 c0 03             	add    $0x3,%eax
80108710:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80108713:	7f 95                	jg     801086aa <APCharacterInit+0xd9>
	for(int i=10;i<25;i++)
		character_img[i][j] = RGB(0xff,0x00,0x00);
    line=line+3;
80108715:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
    for(int j=line;j<line+3;j++)
8010871c:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108722:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108725:	eb 5d                	jmp    80108784 <APCharacterInit+0x1b3>
        for(int i=5;i<40;i++)
80108727:	c7 45 e0 05 00 00 00 	movl   $0x5,-0x20(%ebp)
8010872e:	eb 4a                	jmp    8010877a <APCharacterInit+0x1a9>
            character_img[i][j] = RGB(0xff,0x00,0x00);
80108730:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108733:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80108736:	89 d0                	mov    %edx,%eax
80108738:	01 c0                	add    %eax,%eax
8010873a:	01 d0                	add    %edx,%eax
8010873c:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108742:	01 d0                	add    %edx,%eax
80108744:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010874a:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108750:	6a 00                	push   $0x0
80108752:	6a 00                	push   $0x0
80108754:	68 ff 00 00 00       	push   $0xff
80108759:	50                   	push   %eax
8010875a:	e8 0e fc ff ff       	call   8010836d <RGB>
8010875f:	83 c4 0c             	add    $0xc,%esp
80108762:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108769:	66 89 03             	mov    %ax,(%ebx)
8010876c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108773:	88 43 02             	mov    %al,0x2(%ebx)
    for(int j=line;j<line+3;j++)
	for(int i=10;i<25;i++)
		character_img[i][j] = RGB(0xff,0x00,0x00);
    line=line+3;
    for(int j=line;j<line+3;j++)
        for(int i=5;i<40;i++)
80108776:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
8010877a:	83 7d e0 27          	cmpl   $0x27,-0x20(%ebp)
8010877e:	7e b0                	jle    80108730 <APCharacterInit+0x15f>
  
    for(int j=line;j<line+3;j++)
	for(int i=10;i<25;i++)
		character_img[i][j] = RGB(0xff,0x00,0x00);
    line=line+3;
    for(int j=line;j<line+3;j++)
80108780:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80108784:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010878a:	83 c0 03             	add    $0x3,%eax
8010878d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
80108790:	7f 95                	jg     80108727 <APCharacterInit+0x156>
        for(int i=5;i<40;i++)
            character_img[i][j] = RGB(0xff,0x00,0x00);

    line=line+3;
80108792:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)

    for(int j=line;j<line+3;j++){
80108799:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010879f:	89 45 dc             	mov    %eax,-0x24(%ebp)
801087a2:	e9 78 01 00 00       	jmp    8010891f <APCharacterInit+0x34e>
        for(int i=5;i<30;i++){
801087a7:	c7 45 d8 05 00 00 00 	movl   $0x5,-0x28(%ebp)
801087ae:	e9 5e 01 00 00       	jmp    80108911 <APCharacterInit+0x340>
               if(i<15)
801087b3:	83 7d d8 0e          	cmpl   $0xe,-0x28(%ebp)
801087b7:	7f 4b                	jg     80108804 <APCharacterInit+0x233>
			character_img[i][j] = RGB(128,64,0);
801087b9:	8b 55 dc             	mov    -0x24(%ebp),%edx
801087bc:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801087bf:	89 d0                	mov    %edx,%eax
801087c1:	01 c0                	add    %eax,%eax
801087c3:	01 d0                	add    %edx,%eax
801087c5:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801087cb:	01 d0                	add    %edx,%eax
801087cd:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801087d3:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801087d9:	6a 00                	push   $0x0
801087db:	6a 40                	push   $0x40
801087dd:	68 80 00 00 00       	push   $0x80
801087e2:	50                   	push   %eax
801087e3:	e8 85 fb ff ff       	call   8010836d <RGB>
801087e8:	83 c4 0c             	add    $0xc,%esp
801087eb:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801087f2:	66 89 03             	mov    %ax,(%ebx)
801087f5:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801087fc:	88 43 02             	mov    %al,0x2(%ebx)
801087ff:	e9 09 01 00 00       	jmp    8010890d <APCharacterInit+0x33c>
		else if(i>=15&&i<22)
80108804:	83 7d d8 0e          	cmpl   $0xe,-0x28(%ebp)
80108808:	7e 57                	jle    80108861 <APCharacterInit+0x290>
8010880a:	83 7d d8 15          	cmpl   $0x15,-0x28(%ebp)
8010880e:	7f 51                	jg     80108861 <APCharacterInit+0x290>
			character_img[i][j] = RGB(249,236,236);
80108810:	8b 55 dc             	mov    -0x24(%ebp),%edx
80108813:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80108816:	89 d0                	mov    %edx,%eax
80108818:	01 c0                	add    %eax,%eax
8010881a:	01 d0                	add    %edx,%eax
8010881c:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108822:	01 d0                	add    %edx,%eax
80108824:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010882a:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108830:	68 ec 00 00 00       	push   $0xec
80108835:	68 ec 00 00 00       	push   $0xec
8010883a:	68 f9 00 00 00       	push   $0xf9
8010883f:	50                   	push   %eax
80108840:	e8 28 fb ff ff       	call   8010836d <RGB>
80108845:	83 c4 0c             	add    $0xc,%esp
80108848:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010884f:	66 89 03             	mov    %ax,(%ebx)
80108852:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108859:	88 43 02             	mov    %al,0x2(%ebx)
8010885c:	e9 ac 00 00 00       	jmp    8010890d <APCharacterInit+0x33c>
		else if(i>=22&&i<26)
80108861:	83 7d d8 15          	cmpl   $0x15,-0x28(%ebp)
80108865:	7e 4e                	jle    801088b5 <APCharacterInit+0x2e4>
80108867:	83 7d d8 19          	cmpl   $0x19,-0x28(%ebp)
8010886b:	7f 48                	jg     801088b5 <APCharacterInit+0x2e4>
			character_img[i][j] = RGB(128,64,0);
8010886d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80108870:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80108873:	89 d0                	mov    %edx,%eax
80108875:	01 c0                	add    %eax,%eax
80108877:	01 d0                	add    %edx,%eax
80108879:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010887f:	01 d0                	add    %edx,%eax
80108881:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108887:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010888d:	6a 00                	push   $0x0
8010888f:	6a 40                	push   $0x40
80108891:	68 80 00 00 00       	push   $0x80
80108896:	50                   	push   %eax
80108897:	e8 d1 fa ff ff       	call   8010836d <RGB>
8010889c:	83 c4 0c             	add    $0xc,%esp
8010889f:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801088a6:	66 89 03             	mov    %ax,(%ebx)
801088a9:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801088b0:	88 43 02             	mov    %al,0x2(%ebx)
801088b3:	eb 58                	jmp    8010890d <APCharacterInit+0x33c>
		else if(i>=26&&i<30)
801088b5:	83 7d d8 19          	cmpl   $0x19,-0x28(%ebp)
801088b9:	7e 52                	jle    8010890d <APCharacterInit+0x33c>
801088bb:	83 7d d8 1d          	cmpl   $0x1d,-0x28(%ebp)
801088bf:	7f 4c                	jg     8010890d <APCharacterInit+0x33c>
			character_img[i][j] = RGB(249,236,236);
801088c1:	8b 55 dc             	mov    -0x24(%ebp),%edx
801088c4:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801088c7:	89 d0                	mov    %edx,%eax
801088c9:	01 c0                	add    %eax,%eax
801088cb:	01 d0                	add    %edx,%eax
801088cd:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801088d3:	01 d0                	add    %edx,%eax
801088d5:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801088db:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801088e1:	68 ec 00 00 00       	push   $0xec
801088e6:	68 ec 00 00 00       	push   $0xec
801088eb:	68 f9 00 00 00       	push   $0xf9
801088f0:	50                   	push   %eax
801088f1:	e8 77 fa ff ff       	call   8010836d <RGB>
801088f6:	83 c4 0c             	add    $0xc,%esp
801088f9:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108900:	66 89 03             	mov    %ax,(%ebx)
80108903:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010890a:	88 43 02             	mov    %al,0x2(%ebx)
            character_img[i][j] = RGB(0xff,0x00,0x00);

    line=line+3;

    for(int j=line;j<line+3;j++){
        for(int i=5;i<30;i++){
8010890d:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
80108911:	83 7d d8 1d          	cmpl   $0x1d,-0x28(%ebp)
80108915:	0f 8e 98 fe ff ff    	jle    801087b3 <APCharacterInit+0x1e2>
        for(int i=5;i<40;i++)
            character_img[i][j] = RGB(0xff,0x00,0x00);

    line=line+3;

    for(int j=line;j<line+3;j++){
8010891b:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
8010891f:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108925:	83 c0 03             	add    $0x3,%eax
80108928:	3b 45 dc             	cmp    -0x24(%ebp),%eax
8010892b:	0f 8f 76 fe ff ff    	jg     801087a7 <APCharacterInit+0x1d6>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=26&&i<30)
			character_img[i][j] = RGB(249,236,236);

        }}
line=line+3;
80108931:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108938:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010893e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80108941:	e9 2c 02 00 00       	jmp    80108b72 <APCharacterInit+0x5a1>
	for(int i=0;i<40;i++){
80108946:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010894d:	e9 12 02 00 00       	jmp    80108b64 <APCharacterInit+0x593>
               if(i<5)
80108952:	83 7d d0 04          	cmpl   $0x4,-0x30(%ebp)
80108956:	7f 4b                	jg     801089a3 <APCharacterInit+0x3d2>
			character_img[i][j] = RGB(128,64,0);
80108958:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010895b:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010895e:	89 d0                	mov    %edx,%eax
80108960:	01 c0                	add    %eax,%eax
80108962:	01 d0                	add    %edx,%eax
80108964:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010896a:	01 d0                	add    %edx,%eax
8010896c:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108972:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108978:	6a 00                	push   $0x0
8010897a:	6a 40                	push   $0x40
8010897c:	68 80 00 00 00       	push   $0x80
80108981:	50                   	push   %eax
80108982:	e8 e6 f9 ff ff       	call   8010836d <RGB>
80108987:	83 c4 0c             	add    $0xc,%esp
8010898a:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108991:	66 89 03             	mov    %ax,(%ebx)
80108994:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010899b:	88 43 02             	mov    %al,0x2(%ebx)
8010899e:	e9 bd 01 00 00       	jmp    80108b60 <APCharacterInit+0x58f>
		else if(i>=5&&i<10)
801089a3:	83 7d d0 04          	cmpl   $0x4,-0x30(%ebp)
801089a7:	7e 57                	jle    80108a00 <APCharacterInit+0x42f>
801089a9:	83 7d d0 09          	cmpl   $0x9,-0x30(%ebp)
801089ad:	7f 51                	jg     80108a00 <APCharacterInit+0x42f>
			character_img[i][j] = RGB(249,236,236);
801089af:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801089b2:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801089b5:	89 d0                	mov    %edx,%eax
801089b7:	01 c0                	add    %eax,%eax
801089b9:	01 d0                	add    %edx,%eax
801089bb:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801089c1:	01 d0                	add    %edx,%eax
801089c3:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801089c9:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801089cf:	68 ec 00 00 00       	push   $0xec
801089d4:	68 ec 00 00 00       	push   $0xec
801089d9:	68 f9 00 00 00       	push   $0xf9
801089de:	50                   	push   %eax
801089df:	e8 89 f9 ff ff       	call   8010836d <RGB>
801089e4:	83 c4 0c             	add    $0xc,%esp
801089e7:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801089ee:	66 89 03             	mov    %ax,(%ebx)
801089f1:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801089f8:	88 43 02             	mov    %al,0x2(%ebx)
801089fb:	e9 60 01 00 00       	jmp    80108b60 <APCharacterInit+0x58f>
		else if(i>=10&&i<13)
80108a00:	83 7d d0 09          	cmpl   $0x9,-0x30(%ebp)
80108a04:	7e 51                	jle    80108a57 <APCharacterInit+0x486>
80108a06:	83 7d d0 0c          	cmpl   $0xc,-0x30(%ebp)
80108a0a:	7f 4b                	jg     80108a57 <APCharacterInit+0x486>
			character_img[i][j] = RGB(128,64,0);
80108a0c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80108a0f:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80108a12:	89 d0                	mov    %edx,%eax
80108a14:	01 c0                	add    %eax,%eax
80108a16:	01 d0                	add    %edx,%eax
80108a18:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108a1e:	01 d0                	add    %edx,%eax
80108a20:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108a26:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108a2c:	6a 00                	push   $0x0
80108a2e:	6a 40                	push   $0x40
80108a30:	68 80 00 00 00       	push   $0x80
80108a35:	50                   	push   %eax
80108a36:	e8 32 f9 ff ff       	call   8010836d <RGB>
80108a3b:	83 c4 0c             	add    $0xc,%esp
80108a3e:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108a45:	66 89 03             	mov    %ax,(%ebx)
80108a48:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108a4f:	88 43 02             	mov    %al,0x2(%ebx)
80108a52:	e9 09 01 00 00       	jmp    80108b60 <APCharacterInit+0x58f>
		else if(i>=13&&i<22)
80108a57:	83 7d d0 0c          	cmpl   $0xc,-0x30(%ebp)
80108a5b:	7e 57                	jle    80108ab4 <APCharacterInit+0x4e3>
80108a5d:	83 7d d0 15          	cmpl   $0x15,-0x30(%ebp)
80108a61:	7f 51                	jg     80108ab4 <APCharacterInit+0x4e3>
			character_img[i][j] = RGB(249,236,236);
80108a63:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80108a66:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80108a69:	89 d0                	mov    %edx,%eax
80108a6b:	01 c0                	add    %eax,%eax
80108a6d:	01 d0                	add    %edx,%eax
80108a6f:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108a75:	01 d0                	add    %edx,%eax
80108a77:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108a7d:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108a83:	68 ec 00 00 00       	push   $0xec
80108a88:	68 ec 00 00 00       	push   $0xec
80108a8d:	68 f9 00 00 00       	push   $0xf9
80108a92:	50                   	push   %eax
80108a93:	e8 d5 f8 ff ff       	call   8010836d <RGB>
80108a98:	83 c4 0c             	add    $0xc,%esp
80108a9b:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108aa2:	66 89 03             	mov    %ax,(%ebx)
80108aa5:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108aac:	88 43 02             	mov    %al,0x2(%ebx)
80108aaf:	e9 ac 00 00 00       	jmp    80108b60 <APCharacterInit+0x58f>
		else if(i>=22&&i<26)
80108ab4:	83 7d d0 15          	cmpl   $0x15,-0x30(%ebp)
80108ab8:	7e 4e                	jle    80108b08 <APCharacterInit+0x537>
80108aba:	83 7d d0 19          	cmpl   $0x19,-0x30(%ebp)
80108abe:	7f 48                	jg     80108b08 <APCharacterInit+0x537>
			character_img[i][j] = RGB(128,64,0);
80108ac0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80108ac3:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80108ac6:	89 d0                	mov    %edx,%eax
80108ac8:	01 c0                	add    %eax,%eax
80108aca:	01 d0                	add    %edx,%eax
80108acc:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108ad2:	01 d0                	add    %edx,%eax
80108ad4:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108ada:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108ae0:	6a 00                	push   $0x0
80108ae2:	6a 40                	push   $0x40
80108ae4:	68 80 00 00 00       	push   $0x80
80108ae9:	50                   	push   %eax
80108aea:	e8 7e f8 ff ff       	call   8010836d <RGB>
80108aef:	83 c4 0c             	add    $0xc,%esp
80108af2:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108af9:	66 89 03             	mov    %ax,(%ebx)
80108afc:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108b03:	88 43 02             	mov    %al,0x2(%ebx)
80108b06:	eb 58                	jmp    80108b60 <APCharacterInit+0x58f>
		else if(i>=26&&i<35)
80108b08:	83 7d d0 19          	cmpl   $0x19,-0x30(%ebp)
80108b0c:	7e 52                	jle    80108b60 <APCharacterInit+0x58f>
80108b0e:	83 7d d0 22          	cmpl   $0x22,-0x30(%ebp)
80108b12:	7f 4c                	jg     80108b60 <APCharacterInit+0x58f>
			character_img[i][j] = RGB(249,236,236);
80108b14:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80108b17:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80108b1a:	89 d0                	mov    %edx,%eax
80108b1c:	01 c0                	add    %eax,%eax
80108b1e:	01 d0                	add    %edx,%eax
80108b20:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108b26:	01 d0                	add    %edx,%eax
80108b28:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108b2e:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108b34:	68 ec 00 00 00       	push   $0xec
80108b39:	68 ec 00 00 00       	push   $0xec
80108b3e:	68 f9 00 00 00       	push   $0xf9
80108b43:	50                   	push   %eax
80108b44:	e8 24 f8 ff ff       	call   8010836d <RGB>
80108b49:	83 c4 0c             	add    $0xc,%esp
80108b4c:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108b53:	66 89 03             	mov    %ax,(%ebx)
80108b56:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108b5d:	88 43 02             	mov    %al,0x2(%ebx)
			character_img[i][j] = RGB(249,236,236);

        }}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80108b60:	83 45 d0 01          	addl   $0x1,-0x30(%ebp)
80108b64:	83 7d d0 27          	cmpl   $0x27,-0x30(%ebp)
80108b68:	0f 8e e4 fd ff ff    	jle    80108952 <APCharacterInit+0x381>
		else if(i>=26&&i<30)
			character_img[i][j] = RGB(249,236,236);

        }}
line=line+3;
  for(int j=line;j<line+3;j++){
80108b6e:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
80108b72:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108b78:	83 c0 03             	add    $0x3,%eax
80108b7b:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
80108b7e:	0f 8f c2 fd ff ff    	jg     80108946 <APCharacterInit+0x375>
		else if(i>=22&&i<26)
			character_img[i][j] = RGB(128,64,0);
		else if(i>=26&&i<35)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
80108b84:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108b8b:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108b91:	89 45 cc             	mov    %eax,-0x34(%ebp)
80108b94:	e9 2c 02 00 00       	jmp    80108dc5 <APCharacterInit+0x7f4>
	for(int i=0;i<44;i++){
80108b99:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
80108ba0:	e9 12 02 00 00       	jmp    80108db7 <APCharacterInit+0x7e6>
               if(i<5)
80108ba5:	83 7d c8 04          	cmpl   $0x4,-0x38(%ebp)
80108ba9:	7f 4b                	jg     80108bf6 <APCharacterInit+0x625>
			character_img[i][j] = RGB(128,64,0);
80108bab:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108bae:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108bb1:	89 d0                	mov    %edx,%eax
80108bb3:	01 c0                	add    %eax,%eax
80108bb5:	01 d0                	add    %edx,%eax
80108bb7:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108bbd:	01 d0                	add    %edx,%eax
80108bbf:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108bc5:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108bcb:	6a 00                	push   $0x0
80108bcd:	6a 40                	push   $0x40
80108bcf:	68 80 00 00 00       	push   $0x80
80108bd4:	50                   	push   %eax
80108bd5:	e8 93 f7 ff ff       	call   8010836d <RGB>
80108bda:	83 c4 0c             	add    $0xc,%esp
80108bdd:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108be4:	66 89 03             	mov    %ax,(%ebx)
80108be7:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108bee:	88 43 02             	mov    %al,0x2(%ebx)
80108bf1:	e9 bd 01 00 00       	jmp    80108db3 <APCharacterInit+0x7e2>
		else if(i>=5&&i<10)
80108bf6:	83 7d c8 04          	cmpl   $0x4,-0x38(%ebp)
80108bfa:	7e 57                	jle    80108c53 <APCharacterInit+0x682>
80108bfc:	83 7d c8 09          	cmpl   $0x9,-0x38(%ebp)
80108c00:	7f 51                	jg     80108c53 <APCharacterInit+0x682>
			character_img[i][j] = RGB(249,236,236);
80108c02:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108c05:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108c08:	89 d0                	mov    %edx,%eax
80108c0a:	01 c0                	add    %eax,%eax
80108c0c:	01 d0                	add    %edx,%eax
80108c0e:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108c14:	01 d0                	add    %edx,%eax
80108c16:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108c1c:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108c22:	68 ec 00 00 00       	push   $0xec
80108c27:	68 ec 00 00 00       	push   $0xec
80108c2c:	68 f9 00 00 00       	push   $0xf9
80108c31:	50                   	push   %eax
80108c32:	e8 36 f7 ff ff       	call   8010836d <RGB>
80108c37:	83 c4 0c             	add    $0xc,%esp
80108c3a:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108c41:	66 89 03             	mov    %ax,(%ebx)
80108c44:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108c4b:	88 43 02             	mov    %al,0x2(%ebx)
80108c4e:	e9 60 01 00 00       	jmp    80108db3 <APCharacterInit+0x7e2>
		else if(i>=10&&i<16)
80108c53:	83 7d c8 09          	cmpl   $0x9,-0x38(%ebp)
80108c57:	7e 51                	jle    80108caa <APCharacterInit+0x6d9>
80108c59:	83 7d c8 0f          	cmpl   $0xf,-0x38(%ebp)
80108c5d:	7f 4b                	jg     80108caa <APCharacterInit+0x6d9>
			character_img[i][j] = RGB(128,64,0);
80108c5f:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108c62:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108c65:	89 d0                	mov    %edx,%eax
80108c67:	01 c0                	add    %eax,%eax
80108c69:	01 d0                	add    %edx,%eax
80108c6b:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108c71:	01 d0                	add    %edx,%eax
80108c73:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108c79:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108c7f:	6a 00                	push   $0x0
80108c81:	6a 40                	push   $0x40
80108c83:	68 80 00 00 00       	push   $0x80
80108c88:	50                   	push   %eax
80108c89:	e8 df f6 ff ff       	call   8010836d <RGB>
80108c8e:	83 c4 0c             	add    $0xc,%esp
80108c91:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108c98:	66 89 03             	mov    %ax,(%ebx)
80108c9b:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108ca2:	88 43 02             	mov    %al,0x2(%ebx)
80108ca5:	e9 09 01 00 00       	jmp    80108db3 <APCharacterInit+0x7e2>
		else if(i>=16&&i<26)
80108caa:	83 7d c8 0f          	cmpl   $0xf,-0x38(%ebp)
80108cae:	7e 57                	jle    80108d07 <APCharacterInit+0x736>
80108cb0:	83 7d c8 19          	cmpl   $0x19,-0x38(%ebp)
80108cb4:	7f 51                	jg     80108d07 <APCharacterInit+0x736>
			character_img[i][j] = RGB(249,236,236);
80108cb6:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108cb9:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108cbc:	89 d0                	mov    %edx,%eax
80108cbe:	01 c0                	add    %eax,%eax
80108cc0:	01 d0                	add    %edx,%eax
80108cc2:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108cc8:	01 d0                	add    %edx,%eax
80108cca:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108cd0:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108cd6:	68 ec 00 00 00       	push   $0xec
80108cdb:	68 ec 00 00 00       	push   $0xec
80108ce0:	68 f9 00 00 00       	push   $0xf9
80108ce5:	50                   	push   %eax
80108ce6:	e8 82 f6 ff ff       	call   8010836d <RGB>
80108ceb:	83 c4 0c             	add    $0xc,%esp
80108cee:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108cf5:	66 89 03             	mov    %ax,(%ebx)
80108cf8:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108cff:	88 43 02             	mov    %al,0x2(%ebx)
80108d02:	e9 ac 00 00 00       	jmp    80108db3 <APCharacterInit+0x7e2>
		else if(i>=26&&i<30)
80108d07:	83 7d c8 19          	cmpl   $0x19,-0x38(%ebp)
80108d0b:	7e 4e                	jle    80108d5b <APCharacterInit+0x78a>
80108d0d:	83 7d c8 1d          	cmpl   $0x1d,-0x38(%ebp)
80108d11:	7f 48                	jg     80108d5b <APCharacterInit+0x78a>
			character_img[i][j] = RGB(128,64,0);
80108d13:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108d16:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108d19:	89 d0                	mov    %edx,%eax
80108d1b:	01 c0                	add    %eax,%eax
80108d1d:	01 d0                	add    %edx,%eax
80108d1f:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108d25:	01 d0                	add    %edx,%eax
80108d27:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108d2d:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108d33:	6a 00                	push   $0x0
80108d35:	6a 40                	push   $0x40
80108d37:	68 80 00 00 00       	push   $0x80
80108d3c:	50                   	push   %eax
80108d3d:	e8 2b f6 ff ff       	call   8010836d <RGB>
80108d42:	83 c4 0c             	add    $0xc,%esp
80108d45:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108d4c:	66 89 03             	mov    %ax,(%ebx)
80108d4f:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108d56:	88 43 02             	mov    %al,0x2(%ebx)
80108d59:	eb 58                	jmp    80108db3 <APCharacterInit+0x7e2>
		else if(i>=30&&i<40)
80108d5b:	83 7d c8 1d          	cmpl   $0x1d,-0x38(%ebp)
80108d5f:	7e 52                	jle    80108db3 <APCharacterInit+0x7e2>
80108d61:	83 7d c8 27          	cmpl   $0x27,-0x38(%ebp)
80108d65:	7f 4c                	jg     80108db3 <APCharacterInit+0x7e2>
			character_img[i][j] = RGB(249,236,236);
80108d67:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108d6a:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108d6d:	89 d0                	mov    %edx,%eax
80108d6f:	01 c0                	add    %eax,%eax
80108d71:	01 d0                	add    %edx,%eax
80108d73:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108d79:	01 d0                	add    %edx,%eax
80108d7b:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108d81:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108d87:	68 ec 00 00 00       	push   $0xec
80108d8c:	68 ec 00 00 00       	push   $0xec
80108d91:	68 f9 00 00 00       	push   $0xf9
80108d96:	50                   	push   %eax
80108d97:	e8 d1 f5 ff ff       	call   8010836d <RGB>
80108d9c:	83 c4 0c             	add    $0xc,%esp
80108d9f:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108da6:	66 89 03             	mov    %ax,(%ebx)
80108da9:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108db0:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=26&&i<35)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<44;i++){
80108db3:	83 45 c8 01          	addl   $0x1,-0x38(%ebp)
80108db7:	83 7d c8 2b          	cmpl   $0x2b,-0x38(%ebp)
80108dbb:	0f 8e e4 fd ff ff    	jle    80108ba5 <APCharacterInit+0x5d4>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=26&&i<35)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
80108dc1:	83 45 cc 01          	addl   $0x1,-0x34(%ebp)
80108dc5:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108dcb:	83 c0 03             	add    $0x3,%eax
80108dce:	3b 45 cc             	cmp    -0x34(%ebp),%eax
80108dd1:	0f 8f c2 fd ff ff    	jg     80108b99 <APCharacterInit+0x5c8>
		else if(i>=26&&i<30)
			character_img[i][j] = RGB(128,64,0);
		else if(i>=30&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
80108dd7:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108dde:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108de4:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80108de7:	e9 1b 01 00 00       	jmp    80108f07 <APCharacterInit+0x936>
	for(int i=0;i<40;i++){
80108dec:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
80108df3:	e9 01 01 00 00       	jmp    80108ef9 <APCharacterInit+0x928>
               if(i<10)
80108df8:	83 7d c0 09          	cmpl   $0x9,-0x40(%ebp)
80108dfc:	7f 4b                	jg     80108e49 <APCharacterInit+0x878>
			character_img[i][j] = RGB(128,64,0);
80108dfe:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80108e01:	8b 4d c0             	mov    -0x40(%ebp),%ecx
80108e04:	89 d0                	mov    %edx,%eax
80108e06:	01 c0                	add    %eax,%eax
80108e08:	01 d0                	add    %edx,%eax
80108e0a:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108e10:	01 d0                	add    %edx,%eax
80108e12:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108e18:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108e1e:	6a 00                	push   $0x0
80108e20:	6a 40                	push   $0x40
80108e22:	68 80 00 00 00       	push   $0x80
80108e27:	50                   	push   %eax
80108e28:	e8 40 f5 ff ff       	call   8010836d <RGB>
80108e2d:	83 c4 0c             	add    $0xc,%esp
80108e30:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108e37:	66 89 03             	mov    %ax,(%ebx)
80108e3a:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108e41:	88 43 02             	mov    %al,0x2(%ebx)
80108e44:	e9 ac 00 00 00       	jmp    80108ef5 <APCharacterInit+0x924>
		else if(i>=10&&i<22)
80108e49:	83 7d c0 09          	cmpl   $0x9,-0x40(%ebp)
80108e4d:	7e 54                	jle    80108ea3 <APCharacterInit+0x8d2>
80108e4f:	83 7d c0 15          	cmpl   $0x15,-0x40(%ebp)
80108e53:	7f 4e                	jg     80108ea3 <APCharacterInit+0x8d2>
			character_img[i][j] = RGB(249,236,236);
80108e55:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80108e58:	8b 4d c0             	mov    -0x40(%ebp),%ecx
80108e5b:	89 d0                	mov    %edx,%eax
80108e5d:	01 c0                	add    %eax,%eax
80108e5f:	01 d0                	add    %edx,%eax
80108e61:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108e67:	01 d0                	add    %edx,%eax
80108e69:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108e6f:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108e75:	68 ec 00 00 00       	push   $0xec
80108e7a:	68 ec 00 00 00       	push   $0xec
80108e7f:	68 f9 00 00 00       	push   $0xf9
80108e84:	50                   	push   %eax
80108e85:	e8 e3 f4 ff ff       	call   8010836d <RGB>
80108e8a:	83 c4 0c             	add    $0xc,%esp
80108e8d:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108e94:	66 89 03             	mov    %ax,(%ebx)
80108e97:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108e9e:	88 43 02             	mov    %al,0x2(%ebx)
80108ea1:	eb 52                	jmp    80108ef5 <APCharacterInit+0x924>
		else if(i>=22&&i<35)
80108ea3:	83 7d c0 15          	cmpl   $0x15,-0x40(%ebp)
80108ea7:	7e 4c                	jle    80108ef5 <APCharacterInit+0x924>
80108ea9:	83 7d c0 22          	cmpl   $0x22,-0x40(%ebp)
80108ead:	7f 46                	jg     80108ef5 <APCharacterInit+0x924>
			character_img[i][j] = RGB(128,64,0);
80108eaf:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80108eb2:	8b 4d c0             	mov    -0x40(%ebp),%ecx
80108eb5:	89 d0                	mov    %edx,%eax
80108eb7:	01 c0                	add    %eax,%eax
80108eb9:	01 d0                	add    %edx,%eax
80108ebb:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108ec1:	01 d0                	add    %edx,%eax
80108ec3:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108ec9:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108ecf:	6a 00                	push   $0x0
80108ed1:	6a 40                	push   $0x40
80108ed3:	68 80 00 00 00       	push   $0x80
80108ed8:	50                   	push   %eax
80108ed9:	e8 8f f4 ff ff       	call   8010836d <RGB>
80108ede:	83 c4 0c             	add    $0xc,%esp
80108ee1:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108ee8:	66 89 03             	mov    %ax,(%ebx)
80108eeb:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108ef2:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=30&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80108ef5:	83 45 c0 01          	addl   $0x1,-0x40(%ebp)
80108ef9:	83 7d c0 27          	cmpl   $0x27,-0x40(%ebp)
80108efd:	0f 8e f5 fe ff ff    	jle    80108df8 <APCharacterInit+0x827>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=30&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
80108f03:	83 45 c4 01          	addl   $0x1,-0x3c(%ebp)
80108f07:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108f0d:	83 c0 03             	add    $0x3,%eax
80108f10:	3b 45 c4             	cmp    -0x3c(%ebp),%eax
80108f13:	0f 8f d3 fe ff ff    	jg     80108dec <APCharacterInit+0x81b>
			character_img[i][j] = RGB(249,236,236);
		else if(i>=22&&i<35)
			character_img[i][j] = RGB(128,64,0);
		
}}
line=line+3;
80108f19:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108f20:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108f26:	89 45 bc             	mov    %eax,-0x44(%ebp)
80108f29:	eb 69                	jmp    80108f94 <APCharacterInit+0x9c3>
	for(int i=10;i<40;i++){
80108f2b:	c7 45 b8 0a 00 00 00 	movl   $0xa,-0x48(%ebp)
80108f32:	eb 56                	jmp    80108f8a <APCharacterInit+0x9b9>
               if(i<30)
80108f34:	83 7d b8 1d          	cmpl   $0x1d,-0x48(%ebp)
80108f38:	7f 4c                	jg     80108f86 <APCharacterInit+0x9b5>
			character_img[i][j] = RGB(249,236,236);
80108f3a:	8b 55 bc             	mov    -0x44(%ebp),%edx
80108f3d:	8b 4d b8             	mov    -0x48(%ebp),%ecx
80108f40:	89 d0                	mov    %edx,%eax
80108f42:	01 c0                	add    %eax,%eax
80108f44:	01 d0                	add    %edx,%eax
80108f46:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108f4c:	01 d0                	add    %edx,%eax
80108f4e:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108f54:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108f5a:	68 ec 00 00 00       	push   $0xec
80108f5f:	68 ec 00 00 00       	push   $0xec
80108f64:	68 f9 00 00 00       	push   $0xf9
80108f69:	50                   	push   %eax
80108f6a:	e8 fe f3 ff ff       	call   8010836d <RGB>
80108f6f:	83 c4 0c             	add    $0xc,%esp
80108f72:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108f79:	66 89 03             	mov    %ax,(%ebx)
80108f7c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108f83:	88 43 02             	mov    %al,0x2(%ebx)
			character_img[i][j] = RGB(128,64,0);
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=10;i<40;i++){
80108f86:	83 45 b8 01          	addl   $0x1,-0x48(%ebp)
80108f8a:	83 7d b8 27          	cmpl   $0x27,-0x48(%ebp)
80108f8e:	7e a4                	jle    80108f34 <APCharacterInit+0x963>
		else if(i>=22&&i<35)
			character_img[i][j] = RGB(128,64,0);
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
80108f90:	83 45 bc 01          	addl   $0x1,-0x44(%ebp)
80108f94:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108f9a:	83 c0 03             	add    $0x3,%eax
80108f9d:	3b 45 bc             	cmp    -0x44(%ebp),%eax
80108fa0:	7f 89                	jg     80108f2b <APCharacterInit+0x95a>
               if(i<30)
			character_img[i][j] = RGB(249,236,236);
		
		
}}
line=line+3;
80108fa2:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108fa9:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108faf:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80108fb2:	e9 15 01 00 00       	jmp    801090cc <APCharacterInit+0xafb>
	for(int i=5;i<40;i++){
80108fb7:	c7 45 b0 05 00 00 00 	movl   $0x5,-0x50(%ebp)
80108fbe:	e9 fb 00 00 00       	jmp    801090be <APCharacterInit+0xaed>
               if(i<11)
80108fc3:	83 7d b0 0a          	cmpl   $0xa,-0x50(%ebp)
80108fc7:	7f 4b                	jg     80109014 <APCharacterInit+0xa43>
			character_img[i][j] = RGB(128,64,0);
80108fc9:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80108fcc:	8b 4d b0             	mov    -0x50(%ebp),%ecx
80108fcf:	89 d0                	mov    %edx,%eax
80108fd1:	01 c0                	add    %eax,%eax
80108fd3:	01 d0                	add    %edx,%eax
80108fd5:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108fdb:	01 d0                	add    %edx,%eax
80108fdd:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80108fe3:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108fe9:	6a 00                	push   $0x0
80108feb:	6a 40                	push   $0x40
80108fed:	68 80 00 00 00       	push   $0x80
80108ff2:	50                   	push   %eax
80108ff3:	e8 75 f3 ff ff       	call   8010836d <RGB>
80108ff8:	83 c4 0c             	add    $0xc,%esp
80108ffb:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109002:	66 89 03             	mov    %ax,(%ebx)
80109005:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010900c:	88 43 02             	mov    %al,0x2(%ebx)
8010900f:	e9 a6 00 00 00       	jmp    801090ba <APCharacterInit+0xae9>
		else if(i>=11&&i<14)
80109014:	83 7d b0 0a          	cmpl   $0xa,-0x50(%ebp)
80109018:	7e 4e                	jle    80109068 <APCharacterInit+0xa97>
8010901a:	83 7d b0 0d          	cmpl   $0xd,-0x50(%ebp)
8010901e:	7f 48                	jg     80109068 <APCharacterInit+0xa97>
			character_img[i][j] = RGB(255,0,0);	
80109020:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80109023:	8b 4d b0             	mov    -0x50(%ebp),%ecx
80109026:	89 d0                	mov    %edx,%eax
80109028:	01 c0                	add    %eax,%eax
8010902a:	01 d0                	add    %edx,%eax
8010902c:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109032:	01 d0                	add    %edx,%eax
80109034:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010903a:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109040:	6a 00                	push   $0x0
80109042:	6a 00                	push   $0x0
80109044:	68 ff 00 00 00       	push   $0xff
80109049:	50                   	push   %eax
8010904a:	e8 1e f3 ff ff       	call   8010836d <RGB>
8010904f:	83 c4 0c             	add    $0xc,%esp
80109052:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109059:	66 89 03             	mov    %ax,(%ebx)
8010905c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109063:	88 43 02             	mov    %al,0x2(%ebx)
80109066:	eb 52                	jmp    801090ba <APCharacterInit+0xae9>
		else if(i>=14&&i<25)
80109068:	83 7d b0 0d          	cmpl   $0xd,-0x50(%ebp)
8010906c:	7e 4c                	jle    801090ba <APCharacterInit+0xae9>
8010906e:	83 7d b0 18          	cmpl   $0x18,-0x50(%ebp)
80109072:	7f 46                	jg     801090ba <APCharacterInit+0xae9>
			character_img[i][j] = RGB(128,64,0);
80109074:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80109077:	8b 4d b0             	mov    -0x50(%ebp),%ecx
8010907a:	89 d0                	mov    %edx,%eax
8010907c:	01 c0                	add    %eax,%eax
8010907e:	01 d0                	add    %edx,%eax
80109080:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109086:	01 d0                	add    %edx,%eax
80109088:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010908e:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109094:	6a 00                	push   $0x0
80109096:	6a 40                	push   $0x40
80109098:	68 80 00 00 00       	push   $0x80
8010909d:	50                   	push   %eax
8010909e:	e8 ca f2 ff ff       	call   8010836d <RGB>
801090a3:	83 c4 0c             	add    $0xc,%esp
801090a6:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801090ad:	66 89 03             	mov    %ax,(%ebx)
801090b0:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801090b7:	88 43 02             	mov    %al,0x2(%ebx)
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=5;i<40;i++){
801090ba:	83 45 b0 01          	addl   $0x1,-0x50(%ebp)
801090be:	83 7d b0 27          	cmpl   $0x27,-0x50(%ebp)
801090c2:	0f 8e fb fe ff ff    	jle    80108fc3 <APCharacterInit+0x9f2>
			character_img[i][j] = RGB(249,236,236);
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
801090c8:	83 45 b4 01          	addl   $0x1,-0x4c(%ebp)
801090cc:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801090d2:	83 c0 03             	add    $0x3,%eax
801090d5:	3b 45 b4             	cmp    -0x4c(%ebp),%eax
801090d8:	0f 8f d9 fe ff ff    	jg     80108fb7 <APCharacterInit+0x9e6>
		else if(i>=14&&i<25)
			character_img[i][j] = RGB(128,64,0);
		
		
}}
line=line+3;
801090de:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
801090e5:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801090eb:	89 45 ac             	mov    %eax,-0x54(%ebp)
801090ee:	e9 c3 01 00 00       	jmp    801092b6 <APCharacterInit+0xce5>
	for(int i=3;i<40;i++){
801090f3:	c7 45 a8 03 00 00 00 	movl   $0x3,-0x58(%ebp)
801090fa:	e9 a9 01 00 00       	jmp    801092a8 <APCharacterInit+0xcd7>
               if(i<11)
801090ff:	83 7d a8 0a          	cmpl   $0xa,-0x58(%ebp)
80109103:	7f 4b                	jg     80109150 <APCharacterInit+0xb7f>
			character_img[i][j] = RGB(128,64,0);
80109105:	8b 55 ac             	mov    -0x54(%ebp),%edx
80109108:	8b 4d a8             	mov    -0x58(%ebp),%ecx
8010910b:	89 d0                	mov    %edx,%eax
8010910d:	01 c0                	add    %eax,%eax
8010910f:	01 d0                	add    %edx,%eax
80109111:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109117:	01 d0                	add    %edx,%eax
80109119:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010911f:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109125:	6a 00                	push   $0x0
80109127:	6a 40                	push   $0x40
80109129:	68 80 00 00 00       	push   $0x80
8010912e:	50                   	push   %eax
8010912f:	e8 39 f2 ff ff       	call   8010836d <RGB>
80109134:	83 c4 0c             	add    $0xc,%esp
80109137:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010913e:	66 89 03             	mov    %ax,(%ebx)
80109141:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109148:	88 43 02             	mov    %al,0x2(%ebx)
8010914b:	e9 54 01 00 00       	jmp    801092a4 <APCharacterInit+0xcd3>
		else if(i>=11&&i<14)
80109150:	83 7d a8 0a          	cmpl   $0xa,-0x58(%ebp)
80109154:	7e 51                	jle    801091a7 <APCharacterInit+0xbd6>
80109156:	83 7d a8 0d          	cmpl   $0xd,-0x58(%ebp)
8010915a:	7f 4b                	jg     801091a7 <APCharacterInit+0xbd6>
			character_img[i][j] = RGB(255,0,0);
8010915c:	8b 55 ac             	mov    -0x54(%ebp),%edx
8010915f:	8b 4d a8             	mov    -0x58(%ebp),%ecx
80109162:	89 d0                	mov    %edx,%eax
80109164:	01 c0                	add    %eax,%eax
80109166:	01 d0                	add    %edx,%eax
80109168:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010916e:	01 d0                	add    %edx,%eax
80109170:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109176:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010917c:	6a 00                	push   $0x0
8010917e:	6a 00                	push   $0x0
80109180:	68 ff 00 00 00       	push   $0xff
80109185:	50                   	push   %eax
80109186:	e8 e2 f1 ff ff       	call   8010836d <RGB>
8010918b:	83 c4 0c             	add    $0xc,%esp
8010918e:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109195:	66 89 03             	mov    %ax,(%ebx)
80109198:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010919f:	88 43 02             	mov    %al,0x2(%ebx)
801091a2:	e9 fd 00 00 00       	jmp    801092a4 <APCharacterInit+0xcd3>
		else if(i>=14&&i<22)
801091a7:	83 7d a8 0d          	cmpl   $0xd,-0x58(%ebp)
801091ab:	7e 51                	jle    801091fe <APCharacterInit+0xc2d>
801091ad:	83 7d a8 15          	cmpl   $0x15,-0x58(%ebp)
801091b1:	7f 4b                	jg     801091fe <APCharacterInit+0xc2d>
			character_img[i][j] = RGB(128,64,0);
801091b3:	8b 55 ac             	mov    -0x54(%ebp),%edx
801091b6:	8b 4d a8             	mov    -0x58(%ebp),%ecx
801091b9:	89 d0                	mov    %edx,%eax
801091bb:	01 c0                	add    %eax,%eax
801091bd:	01 d0                	add    %edx,%eax
801091bf:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801091c5:	01 d0                	add    %edx,%eax
801091c7:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801091cd:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801091d3:	6a 00                	push   $0x0
801091d5:	6a 40                	push   $0x40
801091d7:	68 80 00 00 00       	push   $0x80
801091dc:	50                   	push   %eax
801091dd:	e8 8b f1 ff ff       	call   8010836d <RGB>
801091e2:	83 c4 0c             	add    $0xc,%esp
801091e5:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801091ec:	66 89 03             	mov    %ax,(%ebx)
801091ef:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801091f6:	88 43 02             	mov    %al,0x2(%ebx)
801091f9:	e9 a6 00 00 00       	jmp    801092a4 <APCharacterInit+0xcd3>
		else if(i>=22&&i<25)
801091fe:	83 7d a8 15          	cmpl   $0x15,-0x58(%ebp)
80109202:	7e 4e                	jle    80109252 <APCharacterInit+0xc81>
80109204:	83 7d a8 18          	cmpl   $0x18,-0x58(%ebp)
80109208:	7f 48                	jg     80109252 <APCharacterInit+0xc81>
			character_img[i][j] = RGB(255,0,0);
8010920a:	8b 55 ac             	mov    -0x54(%ebp),%edx
8010920d:	8b 4d a8             	mov    -0x58(%ebp),%ecx
80109210:	89 d0                	mov    %edx,%eax
80109212:	01 c0                	add    %eax,%eax
80109214:	01 d0                	add    %edx,%eax
80109216:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010921c:	01 d0                	add    %edx,%eax
8010921e:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109224:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010922a:	6a 00                	push   $0x0
8010922c:	6a 00                	push   $0x0
8010922e:	68 ff 00 00 00       	push   $0xff
80109233:	50                   	push   %eax
80109234:	e8 34 f1 ff ff       	call   8010836d <RGB>
80109239:	83 c4 0c             	add    $0xc,%esp
8010923c:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109243:	66 89 03             	mov    %ax,(%ebx)
80109246:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010924d:	88 43 02             	mov    %al,0x2(%ebx)
80109250:	eb 52                	jmp    801092a4 <APCharacterInit+0xcd3>
		else if(i>=25&&i<35)
80109252:	83 7d a8 18          	cmpl   $0x18,-0x58(%ebp)
80109256:	7e 4c                	jle    801092a4 <APCharacterInit+0xcd3>
80109258:	83 7d a8 22          	cmpl   $0x22,-0x58(%ebp)
8010925c:	7f 46                	jg     801092a4 <APCharacterInit+0xcd3>
			character_img[i][j] = RGB(128,64,0);
8010925e:	8b 55 ac             	mov    -0x54(%ebp),%edx
80109261:	8b 4d a8             	mov    -0x58(%ebp),%ecx
80109264:	89 d0                	mov    %edx,%eax
80109266:	01 c0                	add    %eax,%eax
80109268:	01 d0                	add    %edx,%eax
8010926a:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109270:	01 d0                	add    %edx,%eax
80109272:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109278:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010927e:	6a 00                	push   $0x0
80109280:	6a 40                	push   $0x40
80109282:	68 80 00 00 00       	push   $0x80
80109287:	50                   	push   %eax
80109288:	e8 e0 f0 ff ff       	call   8010836d <RGB>
8010928d:	83 c4 0c             	add    $0xc,%esp
80109290:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109297:	66 89 03             	mov    %ax,(%ebx)
8010929a:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801092a1:	88 43 02             	mov    %al,0x2(%ebx)
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=3;i<40;i++){
801092a4:	83 45 a8 01          	addl   $0x1,-0x58(%ebp)
801092a8:	83 7d a8 27          	cmpl   $0x27,-0x58(%ebp)
801092ac:	0f 8e 4d fe ff ff    	jle    801090ff <APCharacterInit+0xb2e>
			character_img[i][j] = RGB(128,64,0);
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
801092b2:	83 45 ac 01          	addl   $0x1,-0x54(%ebp)
801092b6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801092bc:	83 c0 03             	add    $0x3,%eax
801092bf:	3b 45 ac             	cmp    -0x54(%ebp),%eax
801092c2:	0f 8f 2b fe ff ff    	jg     801090f3 <APCharacterInit+0xb22>
		else if(i>=22&&i<25)
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<35)
			character_img[i][j] = RGB(128,64,0);
        
    }}line=line+3;
801092c8:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
801092cf:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801092d5:	89 45 a4             	mov    %eax,-0x5c(%ebp)
801092d8:	e9 15 01 00 00       	jmp    801093f2 <APCharacterInit+0xe21>
	for(int i=0;i<40;i++){
801092dd:	c7 45 a0 00 00 00 00 	movl   $0x0,-0x60(%ebp)
801092e4:	e9 fb 00 00 00       	jmp    801093e4 <APCharacterInit+0xe13>
               if(i<11)
801092e9:	83 7d a0 0a          	cmpl   $0xa,-0x60(%ebp)
801092ed:	7f 4b                	jg     8010933a <APCharacterInit+0xd69>
			character_img[i][j] = RGB(128,64,0);
801092ef:	8b 55 a4             	mov    -0x5c(%ebp),%edx
801092f2:	8b 4d a0             	mov    -0x60(%ebp),%ecx
801092f5:	89 d0                	mov    %edx,%eax
801092f7:	01 c0                	add    %eax,%eax
801092f9:	01 d0                	add    %edx,%eax
801092fb:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109301:	01 d0                	add    %edx,%eax
80109303:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109309:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010930f:	6a 00                	push   $0x0
80109311:	6a 40                	push   $0x40
80109313:	68 80 00 00 00       	push   $0x80
80109318:	50                   	push   %eax
80109319:	e8 4f f0 ff ff       	call   8010836d <RGB>
8010931e:	83 c4 0c             	add    $0xc,%esp
80109321:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109328:	66 89 03             	mov    %ax,(%ebx)
8010932b:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109332:	88 43 02             	mov    %al,0x2(%ebx)
80109335:	e9 a6 00 00 00       	jmp    801093e0 <APCharacterInit+0xe0f>
		else if(i>=11&&i<25)
8010933a:	83 7d a0 0a          	cmpl   $0xa,-0x60(%ebp)
8010933e:	7e 4e                	jle    8010938e <APCharacterInit+0xdbd>
80109340:	83 7d a0 18          	cmpl   $0x18,-0x60(%ebp)
80109344:	7f 48                	jg     8010938e <APCharacterInit+0xdbd>
			character_img[i][j] = RGB(255,0,0);
80109346:	8b 55 a4             	mov    -0x5c(%ebp),%edx
80109349:	8b 4d a0             	mov    -0x60(%ebp),%ecx
8010934c:	89 d0                	mov    %edx,%eax
8010934e:	01 c0                	add    %eax,%eax
80109350:	01 d0                	add    %edx,%eax
80109352:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109358:	01 d0                	add    %edx,%eax
8010935a:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109360:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109366:	6a 00                	push   $0x0
80109368:	6a 00                	push   $0x0
8010936a:	68 ff 00 00 00       	push   $0xff
8010936f:	50                   	push   %eax
80109370:	e8 f8 ef ff ff       	call   8010836d <RGB>
80109375:	83 c4 0c             	add    $0xc,%esp
80109378:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010937f:	66 89 03             	mov    %ax,(%ebx)
80109382:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109389:	88 43 02             	mov    %al,0x2(%ebx)
8010938c:	eb 52                	jmp    801093e0 <APCharacterInit+0xe0f>
		else if(i>=25&&i<40)
8010938e:	83 7d a0 18          	cmpl   $0x18,-0x60(%ebp)
80109392:	7e 4c                	jle    801093e0 <APCharacterInit+0xe0f>
80109394:	83 7d a0 27          	cmpl   $0x27,-0x60(%ebp)
80109398:	7f 46                	jg     801093e0 <APCharacterInit+0xe0f>
			character_img[i][j] = RGB(128,64,0);
8010939a:	8b 55 a4             	mov    -0x5c(%ebp),%edx
8010939d:	8b 4d a0             	mov    -0x60(%ebp),%ecx
801093a0:	89 d0                	mov    %edx,%eax
801093a2:	01 c0                	add    %eax,%eax
801093a4:	01 d0                	add    %edx,%eax
801093a6:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801093ac:	01 d0                	add    %edx,%eax
801093ae:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801093b4:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801093ba:	6a 00                	push   $0x0
801093bc:	6a 40                	push   $0x40
801093be:	68 80 00 00 00       	push   $0x80
801093c3:	50                   	push   %eax
801093c4:	e8 a4 ef ff ff       	call   8010836d <RGB>
801093c9:	83 c4 0c             	add    $0xc,%esp
801093cc:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801093d3:	66 89 03             	mov    %ax,(%ebx)
801093d6:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801093dd:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=25&&i<35)
			character_img[i][j] = RGB(128,64,0);
        
    }}line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
801093e0:	83 45 a0 01          	addl   $0x1,-0x60(%ebp)
801093e4:	83 7d a0 27          	cmpl   $0x27,-0x60(%ebp)
801093e8:	0f 8e fb fe ff ff    	jle    801092e9 <APCharacterInit+0xd18>
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<35)
			character_img[i][j] = RGB(128,64,0);
        
    }}line=line+3;
  for(int j=line;j<line+3;j++){
801093ee:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
801093f2:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801093f8:	83 c0 03             	add    $0x3,%eax
801093fb:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
801093fe:	0f 8f d9 fe ff ff    	jg     801092dd <APCharacterInit+0xd0c>
		else if(i>=11&&i<25)
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<40)
			character_img[i][j] = RGB(128,64,0);
}}
line =line +3;
80109404:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
8010940b:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109411:	89 45 9c             	mov    %eax,-0x64(%ebp)
80109414:	e9 37 03 00 00       	jmp    80109750 <APCharacterInit+0x117f>
	for(int i=0;i<40;i++){
80109419:	c7 45 98 00 00 00 00 	movl   $0x0,-0x68(%ebp)
80109420:	e9 1d 03 00 00       	jmp    80109742 <APCharacterInit+0x1171>
               if(i<5)
80109425:	83 7d 98 04          	cmpl   $0x4,-0x68(%ebp)
80109429:	7f 51                	jg     8010947c <APCharacterInit+0xeab>
			character_img[i][j] = RGB(249,236,236);
8010942b:	8b 55 9c             	mov    -0x64(%ebp),%edx
8010942e:	8b 4d 98             	mov    -0x68(%ebp),%ecx
80109431:	89 d0                	mov    %edx,%eax
80109433:	01 c0                	add    %eax,%eax
80109435:	01 d0                	add    %edx,%eax
80109437:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010943d:	01 d0                	add    %edx,%eax
8010943f:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109445:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010944b:	68 ec 00 00 00       	push   $0xec
80109450:	68 ec 00 00 00       	push   $0xec
80109455:	68 f9 00 00 00       	push   $0xf9
8010945a:	50                   	push   %eax
8010945b:	e8 0d ef ff ff       	call   8010836d <RGB>
80109460:	83 c4 0c             	add    $0xc,%esp
80109463:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010946a:	66 89 03             	mov    %ax,(%ebx)
8010946d:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109474:	88 43 02             	mov    %al,0x2(%ebx)
80109477:	e9 c2 02 00 00       	jmp    8010973e <APCharacterInit+0x116d>
		else if(i>=5&&i<8)
8010947c:	83 7d 98 04          	cmpl   $0x4,-0x68(%ebp)
80109480:	7e 51                	jle    801094d3 <APCharacterInit+0xf02>
80109482:	83 7d 98 07          	cmpl   $0x7,-0x68(%ebp)
80109486:	7f 4b                	jg     801094d3 <APCharacterInit+0xf02>
			character_img[i][j] = RGB(128,64,0);
80109488:	8b 55 9c             	mov    -0x64(%ebp),%edx
8010948b:	8b 4d 98             	mov    -0x68(%ebp),%ecx
8010948e:	89 d0                	mov    %edx,%eax
80109490:	01 c0                	add    %eax,%eax
80109492:	01 d0                	add    %edx,%eax
80109494:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010949a:	01 d0                	add    %edx,%eax
8010949c:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801094a2:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801094a8:	6a 00                	push   $0x0
801094aa:	6a 40                	push   $0x40
801094ac:	68 80 00 00 00       	push   $0x80
801094b1:	50                   	push   %eax
801094b2:	e8 b6 ee ff ff       	call   8010836d <RGB>
801094b7:	83 c4 0c             	add    $0xc,%esp
801094ba:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801094c1:	66 89 03             	mov    %ax,(%ebx)
801094c4:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801094cb:	88 43 02             	mov    %al,0x2(%ebx)
801094ce:	e9 6b 02 00 00       	jmp    8010973e <APCharacterInit+0x116d>
		else if(i>=8&&i<11)
801094d3:	83 7d 98 07          	cmpl   $0x7,-0x68(%ebp)
801094d7:	7e 51                	jle    8010952a <APCharacterInit+0xf59>
801094d9:	83 7d 98 0a          	cmpl   $0xa,-0x68(%ebp)
801094dd:	7f 4b                	jg     8010952a <APCharacterInit+0xf59>
			character_img[i][j] = RGB(255,0,0);
801094df:	8b 55 9c             	mov    -0x64(%ebp),%edx
801094e2:	8b 4d 98             	mov    -0x68(%ebp),%ecx
801094e5:	89 d0                	mov    %edx,%eax
801094e7:	01 c0                	add    %eax,%eax
801094e9:	01 d0                	add    %edx,%eax
801094eb:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801094f1:	01 d0                	add    %edx,%eax
801094f3:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801094f9:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801094ff:	6a 00                	push   $0x0
80109501:	6a 00                	push   $0x0
80109503:	68 ff 00 00 00       	push   $0xff
80109508:	50                   	push   %eax
80109509:	e8 5f ee ff ff       	call   8010836d <RGB>
8010950e:	83 c4 0c             	add    $0xc,%esp
80109511:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109518:	66 89 03             	mov    %ax,(%ebx)
8010951b:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109522:	88 43 02             	mov    %al,0x2(%ebx)
80109525:	e9 14 02 00 00       	jmp    8010973e <APCharacterInit+0x116d>
		else if(i>=11&&i<14)
8010952a:	83 7d 98 0a          	cmpl   $0xa,-0x68(%ebp)
8010952e:	7e 57                	jle    80109587 <APCharacterInit+0xfb6>
80109530:	83 7d 98 0d          	cmpl   $0xd,-0x68(%ebp)
80109534:	7f 51                	jg     80109587 <APCharacterInit+0xfb6>
			character_img[i][j] = RGB(249,236,236);
80109536:	8b 55 9c             	mov    -0x64(%ebp),%edx
80109539:	8b 4d 98             	mov    -0x68(%ebp),%ecx
8010953c:	89 d0                	mov    %edx,%eax
8010953e:	01 c0                	add    %eax,%eax
80109540:	01 d0                	add    %edx,%eax
80109542:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109548:	01 d0                	add    %edx,%eax
8010954a:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109550:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109556:	68 ec 00 00 00       	push   $0xec
8010955b:	68 ec 00 00 00       	push   $0xec
80109560:	68 f9 00 00 00       	push   $0xf9
80109565:	50                   	push   %eax
80109566:	e8 02 ee ff ff       	call   8010836d <RGB>
8010956b:	83 c4 0c             	add    $0xc,%esp
8010956e:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109575:	66 89 03             	mov    %ax,(%ebx)
80109578:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010957f:	88 43 02             	mov    %al,0x2(%ebx)
80109582:	e9 b7 01 00 00       	jmp    8010973e <APCharacterInit+0x116d>
		else if(i>=14&&i<22)
80109587:	83 7d 98 0d          	cmpl   $0xd,-0x68(%ebp)
8010958b:	7e 51                	jle    801095de <APCharacterInit+0x100d>
8010958d:	83 7d 98 15          	cmpl   $0x15,-0x68(%ebp)
80109591:	7f 4b                	jg     801095de <APCharacterInit+0x100d>
			character_img[i][j] = RGB(255,0,0);
80109593:	8b 55 9c             	mov    -0x64(%ebp),%edx
80109596:	8b 4d 98             	mov    -0x68(%ebp),%ecx
80109599:	89 d0                	mov    %edx,%eax
8010959b:	01 c0                	add    %eax,%eax
8010959d:	01 d0                	add    %edx,%eax
8010959f:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801095a5:	01 d0                	add    %edx,%eax
801095a7:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801095ad:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801095b3:	6a 00                	push   $0x0
801095b5:	6a 00                	push   $0x0
801095b7:	68 ff 00 00 00       	push   $0xff
801095bc:	50                   	push   %eax
801095bd:	e8 ab ed ff ff       	call   8010836d <RGB>
801095c2:	83 c4 0c             	add    $0xc,%esp
801095c5:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801095cc:	66 89 03             	mov    %ax,(%ebx)
801095cf:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801095d6:	88 43 02             	mov    %al,0x2(%ebx)
801095d9:	e9 60 01 00 00       	jmp    8010973e <APCharacterInit+0x116d>
		else if(i>=22&&i<25)
801095de:	83 7d 98 15          	cmpl   $0x15,-0x68(%ebp)
801095e2:	7e 57                	jle    8010963b <APCharacterInit+0x106a>
801095e4:	83 7d 98 18          	cmpl   $0x18,-0x68(%ebp)
801095e8:	7f 51                	jg     8010963b <APCharacterInit+0x106a>
			character_img[i][j] = RGB(249,236,236);
801095ea:	8b 55 9c             	mov    -0x64(%ebp),%edx
801095ed:	8b 4d 98             	mov    -0x68(%ebp),%ecx
801095f0:	89 d0                	mov    %edx,%eax
801095f2:	01 c0                	add    %eax,%eax
801095f4:	01 d0                	add    %edx,%eax
801095f6:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801095fc:	01 d0                	add    %edx,%eax
801095fe:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109604:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010960a:	68 ec 00 00 00       	push   $0xec
8010960f:	68 ec 00 00 00       	push   $0xec
80109614:	68 f9 00 00 00       	push   $0xf9
80109619:	50                   	push   %eax
8010961a:	e8 4e ed ff ff       	call   8010836d <RGB>
8010961f:	83 c4 0c             	add    $0xc,%esp
80109622:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109629:	66 89 03             	mov    %ax,(%ebx)
8010962c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109633:	88 43 02             	mov    %al,0x2(%ebx)
80109636:	e9 03 01 00 00       	jmp    8010973e <APCharacterInit+0x116d>
		else if(i>=25&&i<28)
8010963b:	83 7d 98 18          	cmpl   $0x18,-0x68(%ebp)
8010963f:	7e 51                	jle    80109692 <APCharacterInit+0x10c1>
80109641:	83 7d 98 1b          	cmpl   $0x1b,-0x68(%ebp)
80109645:	7f 4b                	jg     80109692 <APCharacterInit+0x10c1>
			character_img[i][j] = RGB(255,0,0);
80109647:	8b 55 9c             	mov    -0x64(%ebp),%edx
8010964a:	8b 4d 98             	mov    -0x68(%ebp),%ecx
8010964d:	89 d0                	mov    %edx,%eax
8010964f:	01 c0                	add    %eax,%eax
80109651:	01 d0                	add    %edx,%eax
80109653:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109659:	01 d0                	add    %edx,%eax
8010965b:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109661:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109667:	6a 00                	push   $0x0
80109669:	6a 00                	push   $0x0
8010966b:	68 ff 00 00 00       	push   $0xff
80109670:	50                   	push   %eax
80109671:	e8 f7 ec ff ff       	call   8010836d <RGB>
80109676:	83 c4 0c             	add    $0xc,%esp
80109679:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109680:	66 89 03             	mov    %ax,(%ebx)
80109683:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010968a:	88 43 02             	mov    %al,0x2(%ebx)
8010968d:	e9 ac 00 00 00       	jmp    8010973e <APCharacterInit+0x116d>
		else if(i>=28&&i<32)
80109692:	83 7d 98 1b          	cmpl   $0x1b,-0x68(%ebp)
80109696:	7e 4e                	jle    801096e6 <APCharacterInit+0x1115>
80109698:	83 7d 98 1f          	cmpl   $0x1f,-0x68(%ebp)
8010969c:	7f 48                	jg     801096e6 <APCharacterInit+0x1115>
			character_img[i][j] = RGB(128,64,0);
8010969e:	8b 55 9c             	mov    -0x64(%ebp),%edx
801096a1:	8b 4d 98             	mov    -0x68(%ebp),%ecx
801096a4:	89 d0                	mov    %edx,%eax
801096a6:	01 c0                	add    %eax,%eax
801096a8:	01 d0                	add    %edx,%eax
801096aa:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801096b0:	01 d0                	add    %edx,%eax
801096b2:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801096b8:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801096be:	6a 00                	push   $0x0
801096c0:	6a 40                	push   $0x40
801096c2:	68 80 00 00 00       	push   $0x80
801096c7:	50                   	push   %eax
801096c8:	e8 a0 ec ff ff       	call   8010836d <RGB>
801096cd:	83 c4 0c             	add    $0xc,%esp
801096d0:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801096d7:	66 89 03             	mov    %ax,(%ebx)
801096da:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801096e1:	88 43 02             	mov    %al,0x2(%ebx)
801096e4:	eb 58                	jmp    8010973e <APCharacterInit+0x116d>
		else if(i>=32&&i<40)
801096e6:	83 7d 98 1f          	cmpl   $0x1f,-0x68(%ebp)
801096ea:	7e 52                	jle    8010973e <APCharacterInit+0x116d>
801096ec:	83 7d 98 27          	cmpl   $0x27,-0x68(%ebp)
801096f0:	7f 4c                	jg     8010973e <APCharacterInit+0x116d>
			character_img[i][j] = RGB(249,236,236);
801096f2:	8b 55 9c             	mov    -0x64(%ebp),%edx
801096f5:	8b 4d 98             	mov    -0x68(%ebp),%ecx
801096f8:	89 d0                	mov    %edx,%eax
801096fa:	01 c0                	add    %eax,%eax
801096fc:	01 d0                	add    %edx,%eax
801096fe:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109704:	01 d0                	add    %edx,%eax
80109706:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010970c:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109712:	68 ec 00 00 00       	push   $0xec
80109717:	68 ec 00 00 00       	push   $0xec
8010971c:	68 f9 00 00 00       	push   $0xf9
80109721:	50                   	push   %eax
80109722:	e8 46 ec ff ff       	call   8010836d <RGB>
80109727:	83 c4 0c             	add    $0xc,%esp
8010972a:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109731:	66 89 03             	mov    %ax,(%ebx)
80109734:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010973b:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=25&&i<40)
			character_img[i][j] = RGB(128,64,0);
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
8010973e:	83 45 98 01          	addl   $0x1,-0x68(%ebp)
80109742:	83 7d 98 27          	cmpl   $0x27,-0x68(%ebp)
80109746:	0f 8e d9 fc ff ff    	jle    80109425 <APCharacterInit+0xe54>
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<40)
			character_img[i][j] = RGB(128,64,0);
}}
line =line +3;
for(int j=line;j<line+3;j++){
8010974c:	83 45 9c 01          	addl   $0x1,-0x64(%ebp)
80109750:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109756:	83 c0 03             	add    $0x3,%eax
80109759:	3b 45 9c             	cmp    -0x64(%ebp),%eax
8010975c:	0f 8f b7 fc ff ff    	jg     80109419 <APCharacterInit+0xe48>
		else if(i>=28&&i<32)
			character_img[i][j] = RGB(128,64,0);
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line =line +3;
80109762:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
80109769:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010976f:	89 45 94             	mov    %eax,-0x6c(%ebp)
80109772:	e9 21 01 00 00       	jmp    80109898 <APCharacterInit+0x12c7>
	for(int i=0;i<40;i++){
80109777:	c7 45 90 00 00 00 00 	movl   $0x0,-0x70(%ebp)
8010977e:	e9 07 01 00 00       	jmp    8010988a <APCharacterInit+0x12b9>
               if(i<8)
80109783:	83 7d 90 07          	cmpl   $0x7,-0x70(%ebp)
80109787:	7f 51                	jg     801097da <APCharacterInit+0x1209>
			character_img[i][j] = RGB(249,236,236);
80109789:	8b 55 94             	mov    -0x6c(%ebp),%edx
8010978c:	8b 4d 90             	mov    -0x70(%ebp),%ecx
8010978f:	89 d0                	mov    %edx,%eax
80109791:	01 c0                	add    %eax,%eax
80109793:	01 d0                	add    %edx,%eax
80109795:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010979b:	01 d0                	add    %edx,%eax
8010979d:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801097a3:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801097a9:	68 ec 00 00 00       	push   $0xec
801097ae:	68 ec 00 00 00       	push   $0xec
801097b3:	68 f9 00 00 00       	push   $0xf9
801097b8:	50                   	push   %eax
801097b9:	e8 af eb ff ff       	call   8010836d <RGB>
801097be:	83 c4 0c             	add    $0xc,%esp
801097c1:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801097c8:	66 89 03             	mov    %ax,(%ebx)
801097cb:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801097d2:	88 43 02             	mov    %al,0x2(%ebx)
801097d5:	e9 ac 00 00 00       	jmp    80109886 <APCharacterInit+0x12b5>
		else if(i>=8&&i<28)
801097da:	83 7d 90 07          	cmpl   $0x7,-0x70(%ebp)
801097de:	7e 4e                	jle    8010982e <APCharacterInit+0x125d>
801097e0:	83 7d 90 1b          	cmpl   $0x1b,-0x70(%ebp)
801097e4:	7f 48                	jg     8010982e <APCharacterInit+0x125d>
			character_img[i][j] = RGB(255,0,0);
801097e6:	8b 55 94             	mov    -0x6c(%ebp),%edx
801097e9:	8b 4d 90             	mov    -0x70(%ebp),%ecx
801097ec:	89 d0                	mov    %edx,%eax
801097ee:	01 c0                	add    %eax,%eax
801097f0:	01 d0                	add    %edx,%eax
801097f2:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801097f8:	01 d0                	add    %edx,%eax
801097fa:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109800:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109806:	6a 00                	push   $0x0
80109808:	6a 00                	push   $0x0
8010980a:	68 ff 00 00 00       	push   $0xff
8010980f:	50                   	push   %eax
80109810:	e8 58 eb ff ff       	call   8010836d <RGB>
80109815:	83 c4 0c             	add    $0xc,%esp
80109818:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010981f:	66 89 03             	mov    %ax,(%ebx)
80109822:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109829:	88 43 02             	mov    %al,0x2(%ebx)
8010982c:	eb 58                	jmp    80109886 <APCharacterInit+0x12b5>
		else if(i>=28&&i<40)
8010982e:	83 7d 90 1b          	cmpl   $0x1b,-0x70(%ebp)
80109832:	7e 52                	jle    80109886 <APCharacterInit+0x12b5>
80109834:	83 7d 90 27          	cmpl   $0x27,-0x70(%ebp)
80109838:	7f 4c                	jg     80109886 <APCharacterInit+0x12b5>
			character_img[i][j] = RGB(249,236,236);
8010983a:	8b 55 94             	mov    -0x6c(%ebp),%edx
8010983d:	8b 4d 90             	mov    -0x70(%ebp),%ecx
80109840:	89 d0                	mov    %edx,%eax
80109842:	01 c0                	add    %eax,%eax
80109844:	01 d0                	add    %edx,%eax
80109846:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010984c:	01 d0                	add    %edx,%eax
8010984e:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109854:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010985a:	68 ec 00 00 00       	push   $0xec
8010985f:	68 ec 00 00 00       	push   $0xec
80109864:	68 f9 00 00 00       	push   $0xf9
80109869:	50                   	push   %eax
8010986a:	e8 fe ea ff ff       	call   8010836d <RGB>
8010986f:	83 c4 0c             	add    $0xc,%esp
80109872:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109879:	66 89 03             	mov    %ax,(%ebx)
8010987c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109883:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109886:	83 45 90 01          	addl   $0x1,-0x70(%ebp)
8010988a:	83 7d 90 27          	cmpl   $0x27,-0x70(%ebp)
8010988e:	0f 8e ef fe ff ff    	jle    80109783 <APCharacterInit+0x11b2>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line =line +3;
for(int j=line;j<line+3;j++){
80109894:	83 45 94 01          	addl   $0x1,-0x6c(%ebp)
80109898:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010989e:	83 c0 03             	add    $0x3,%eax
801098a1:	3b 45 94             	cmp    -0x6c(%ebp),%eax
801098a4:	0f 8f cd fe ff ff    	jg     80109777 <APCharacterInit+0x11a6>
		else if(i>=28&&i<40)
			character_img[i][j] = RGB(249,236,236);

		
}}
line =line +3;
801098aa:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
801098b1:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801098b7:	89 45 8c             	mov    %eax,-0x74(%ebp)
801098ba:	e9 21 01 00 00       	jmp    801099e0 <APCharacterInit+0x140f>
	for(int i=0;i<40;i++){
801098bf:	c7 45 88 00 00 00 00 	movl   $0x0,-0x78(%ebp)
801098c6:	e9 07 01 00 00       	jmp    801099d2 <APCharacterInit+0x1401>
               if(i<5)
801098cb:	83 7d 88 04          	cmpl   $0x4,-0x78(%ebp)
801098cf:	7f 51                	jg     80109922 <APCharacterInit+0x1351>
			character_img[i][j] = RGB(249,236,236);
801098d1:	8b 55 8c             	mov    -0x74(%ebp),%edx
801098d4:	8b 4d 88             	mov    -0x78(%ebp),%ecx
801098d7:	89 d0                	mov    %edx,%eax
801098d9:	01 c0                	add    %eax,%eax
801098db:	01 d0                	add    %edx,%eax
801098dd:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801098e3:	01 d0                	add    %edx,%eax
801098e5:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
801098eb:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801098f1:	68 ec 00 00 00       	push   $0xec
801098f6:	68 ec 00 00 00       	push   $0xec
801098fb:	68 f9 00 00 00       	push   $0xf9
80109900:	50                   	push   %eax
80109901:	e8 67 ea ff ff       	call   8010836d <RGB>
80109906:	83 c4 0c             	add    $0xc,%esp
80109909:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109910:	66 89 03             	mov    %ax,(%ebx)
80109913:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010991a:	88 43 02             	mov    %al,0x2(%ebx)
8010991d:	e9 ac 00 00 00       	jmp    801099ce <APCharacterInit+0x13fd>
	
		else if(i>=5&&i<32)
80109922:	83 7d 88 04          	cmpl   $0x4,-0x78(%ebp)
80109926:	7e 4e                	jle    80109976 <APCharacterInit+0x13a5>
80109928:	83 7d 88 1f          	cmpl   $0x1f,-0x78(%ebp)
8010992c:	7f 48                	jg     80109976 <APCharacterInit+0x13a5>
			character_img[i][j] = RGB(255,0,0);
8010992e:	8b 55 8c             	mov    -0x74(%ebp),%edx
80109931:	8b 4d 88             	mov    -0x78(%ebp),%ecx
80109934:	89 d0                	mov    %edx,%eax
80109936:	01 c0                	add    %eax,%eax
80109938:	01 d0                	add    %edx,%eax
8010993a:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109940:	01 d0                	add    %edx,%eax
80109942:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109948:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010994e:	6a 00                	push   $0x0
80109950:	6a 00                	push   $0x0
80109952:	68 ff 00 00 00       	push   $0xff
80109957:	50                   	push   %eax
80109958:	e8 10 ea ff ff       	call   8010836d <RGB>
8010995d:	83 c4 0c             	add    $0xc,%esp
80109960:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109967:	66 89 03             	mov    %ax,(%ebx)
8010996a:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109971:	88 43 02             	mov    %al,0x2(%ebx)
80109974:	eb 58                	jmp    801099ce <APCharacterInit+0x13fd>
		
		else if(i>=32&&i<40)
80109976:	83 7d 88 1f          	cmpl   $0x1f,-0x78(%ebp)
8010997a:	7e 52                	jle    801099ce <APCharacterInit+0x13fd>
8010997c:	83 7d 88 27          	cmpl   $0x27,-0x78(%ebp)
80109980:	7f 4c                	jg     801099ce <APCharacterInit+0x13fd>
			character_img[i][j] = RGB(249,236,236);
80109982:	8b 55 8c             	mov    -0x74(%ebp),%edx
80109985:	8b 4d 88             	mov    -0x78(%ebp),%ecx
80109988:	89 d0                	mov    %edx,%eax
8010998a:	01 c0                	add    %eax,%eax
8010998c:	01 d0                	add    %edx,%eax
8010998e:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109994:	01 d0                	add    %edx,%eax
80109996:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
8010999c:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801099a2:	68 ec 00 00 00       	push   $0xec
801099a7:	68 ec 00 00 00       	push   $0xec
801099ac:	68 f9 00 00 00       	push   $0xf9
801099b1:	50                   	push   %eax
801099b2:	e8 b6 e9 ff ff       	call   8010836d <RGB>
801099b7:	83 c4 0c             	add    $0xc,%esp
801099ba:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801099c1:	66 89 03             	mov    %ax,(%ebx)
801099c4:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801099cb:	88 43 02             	mov    %al,0x2(%ebx)

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
801099ce:	83 45 88 01          	addl   $0x1,-0x78(%ebp)
801099d2:	83 7d 88 27          	cmpl   $0x27,-0x78(%ebp)
801099d6:	0f 8e ef fe ff ff    	jle    801098cb <APCharacterInit+0x12fa>
			character_img[i][j] = RGB(249,236,236);

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
801099dc:	83 45 8c 01          	addl   $0x1,-0x74(%ebp)
801099e0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801099e6:	83 c0 03             	add    $0x3,%eax
801099e9:	3b 45 8c             	cmp    -0x74(%ebp),%eax
801099ec:	0f 8f cd fe ff ff    	jg     801098bf <APCharacterInit+0x12ee>
		
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);

		
}}line =line +3;
801099f2:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
801099f9:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801099ff:	89 45 84             	mov    %eax,-0x7c(%ebp)
80109a02:	e9 c4 00 00 00       	jmp    80109acb <APCharacterInit+0x14fa>
	for(int i=0;i<40;i++){
80109a07:	c7 45 80 00 00 00 00 	movl   $0x0,-0x80(%ebp)
80109a0e:	e9 aa 00 00 00       	jmp    80109abd <APCharacterInit+0x14ec>
               if(i>=5&&i<14)
80109a13:	83 7d 80 04          	cmpl   $0x4,-0x80(%ebp)
80109a17:	7e 4e                	jle    80109a67 <APCharacterInit+0x1496>
80109a19:	83 7d 80 0d          	cmpl   $0xd,-0x80(%ebp)
80109a1d:	7f 48                	jg     80109a67 <APCharacterInit+0x1496>
			character_img[i][j] = RGB(255,0,0);
80109a1f:	8b 55 84             	mov    -0x7c(%ebp),%edx
80109a22:	8b 4d 80             	mov    -0x80(%ebp),%ecx
80109a25:	89 d0                	mov    %edx,%eax
80109a27:	01 c0                	add    %eax,%eax
80109a29:	01 d0                	add    %edx,%eax
80109a2b:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109a31:	01 d0                	add    %edx,%eax
80109a33:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109a39:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109a3f:	6a 00                	push   $0x0
80109a41:	6a 00                	push   $0x0
80109a43:	68 ff 00 00 00       	push   $0xff
80109a48:	50                   	push   %eax
80109a49:	e8 1f e9 ff ff       	call   8010836d <RGB>
80109a4e:	83 c4 0c             	add    $0xc,%esp
80109a51:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109a58:	66 89 03             	mov    %ax,(%ebx)
80109a5b:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109a62:	88 43 02             	mov    %al,0x2(%ebx)
80109a65:	eb 52                	jmp    80109ab9 <APCharacterInit+0x14e8>
		
		else if(i>=22&&i<32)
80109a67:	83 7d 80 15          	cmpl   $0x15,-0x80(%ebp)
80109a6b:	7e 4c                	jle    80109ab9 <APCharacterInit+0x14e8>
80109a6d:	83 7d 80 1f          	cmpl   $0x1f,-0x80(%ebp)
80109a71:	7f 46                	jg     80109ab9 <APCharacterInit+0x14e8>
			character_img[i][j] = RGB(255,0,0);
80109a73:	8b 55 84             	mov    -0x7c(%ebp),%edx
80109a76:	8b 4d 80             	mov    -0x80(%ebp),%ecx
80109a79:	89 d0                	mov    %edx,%eax
80109a7b:	01 c0                	add    %eax,%eax
80109a7d:	01 d0                	add    %edx,%eax
80109a7f:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109a85:	01 d0                	add    %edx,%eax
80109a87:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109a8d:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109a93:	6a 00                	push   $0x0
80109a95:	6a 00                	push   $0x0
80109a97:	68 ff 00 00 00       	push   $0xff
80109a9c:	50                   	push   %eax
80109a9d:	e8 cb e8 ff ff       	call   8010836d <RGB>
80109aa2:	83 c4 0c             	add    $0xc,%esp
80109aa5:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109aac:	66 89 03             	mov    %ax,(%ebx)
80109aaf:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109ab6:	88 43 02             	mov    %al,0x2(%ebx)
			character_img[i][j] = RGB(249,236,236);

		
}}line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109ab9:	83 45 80 01          	addl   $0x1,-0x80(%ebp)
80109abd:	83 7d 80 27          	cmpl   $0x27,-0x80(%ebp)
80109ac1:	0f 8e 4c ff ff ff    	jle    80109a13 <APCharacterInit+0x1442>
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);

		
}}line =line +3;
for(int j=line;j<line+3;j++){
80109ac7:	83 45 84 01          	addl   $0x1,-0x7c(%ebp)
80109acb:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109ad1:	83 c0 03             	add    $0x3,%eax
80109ad4:	3b 45 84             	cmp    -0x7c(%ebp),%eax
80109ad7:	0f 8f 2a ff ff ff    	jg     80109a07 <APCharacterInit+0x1436>
		else if(i>=22&&i<32)
			character_img[i][j] = RGB(255,0,0);

		
}}
 line =line +3;
80109add:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
80109ae4:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109aea:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
80109af0:	e9 e8 00 00 00       	jmp    80109bdd <APCharacterInit+0x160c>
	for(int i=0;i<40;i++){
80109af5:	c7 85 78 ff ff ff 00 	movl   $0x0,-0x88(%ebp)
80109afc:	00 00 00 
80109aff:	e9 c5 00 00 00       	jmp    80109bc9 <APCharacterInit+0x15f8>
               if(i>=2&&i<11)
80109b04:	83 bd 78 ff ff ff 01 	cmpl   $0x1,-0x88(%ebp)
80109b0b:	7e 57                	jle    80109b64 <APCharacterInit+0x1593>
80109b0d:	83 bd 78 ff ff ff 0a 	cmpl   $0xa,-0x88(%ebp)
80109b14:	7f 4e                	jg     80109b64 <APCharacterInit+0x1593>
			character_img[i][j] = RGB(128,64,0);
80109b16:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
80109b1c:	8b 8d 78 ff ff ff    	mov    -0x88(%ebp),%ecx
80109b22:	89 d0                	mov    %edx,%eax
80109b24:	01 c0                	add    %eax,%eax
80109b26:	01 d0                	add    %edx,%eax
80109b28:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109b2e:	01 d0                	add    %edx,%eax
80109b30:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109b36:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109b3c:	6a 00                	push   $0x0
80109b3e:	6a 40                	push   $0x40
80109b40:	68 80 00 00 00       	push   $0x80
80109b45:	50                   	push   %eax
80109b46:	e8 22 e8 ff ff       	call   8010836d <RGB>
80109b4b:	83 c4 0c             	add    $0xc,%esp
80109b4e:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109b55:	66 89 03             	mov    %ax,(%ebx)
80109b58:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109b5f:	88 43 02             	mov    %al,0x2(%ebx)
80109b62:	eb 5e                	jmp    80109bc2 <APCharacterInit+0x15f1>
		
		else if(i>=25&&i<34)
80109b64:	83 bd 78 ff ff ff 18 	cmpl   $0x18,-0x88(%ebp)
80109b6b:	7e 55                	jle    80109bc2 <APCharacterInit+0x15f1>
80109b6d:	83 bd 78 ff ff ff 21 	cmpl   $0x21,-0x88(%ebp)
80109b74:	7f 4c                	jg     80109bc2 <APCharacterInit+0x15f1>
			character_img[i][j] = RGB(128,64,0);
80109b76:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
80109b7c:	8b 8d 78 ff ff ff    	mov    -0x88(%ebp),%ecx
80109b82:	89 d0                	mov    %edx,%eax
80109b84:	01 c0                	add    %eax,%eax
80109b86:	01 d0                	add    %edx,%eax
80109b88:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109b8e:	01 d0                	add    %edx,%eax
80109b90:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109b96:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109b9c:	6a 00                	push   $0x0
80109b9e:	6a 40                	push   $0x40
80109ba0:	68 80 00 00 00       	push   $0x80
80109ba5:	50                   	push   %eax
80109ba6:	e8 c2 e7 ff ff       	call   8010836d <RGB>
80109bab:	83 c4 0c             	add    $0xc,%esp
80109bae:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109bb5:	66 89 03             	mov    %ax,(%ebx)
80109bb8:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109bbf:	88 43 02             	mov    %al,0x2(%ebx)

		
}}
 line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109bc2:	83 85 78 ff ff ff 01 	addl   $0x1,-0x88(%ebp)
80109bc9:	83 bd 78 ff ff ff 27 	cmpl   $0x27,-0x88(%ebp)
80109bd0:	0f 8e 2e ff ff ff    	jle    80109b04 <APCharacterInit+0x1533>
			character_img[i][j] = RGB(255,0,0);

		
}}
 line =line +3;
for(int j=line;j<line+3;j++){
80109bd6:	83 85 7c ff ff ff 01 	addl   $0x1,-0x84(%ebp)
80109bdd:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109be3:	83 c0 03             	add    $0x3,%eax
80109be6:	3b 85 7c ff ff ff    	cmp    -0x84(%ebp),%eax
80109bec:	0f 8f 03 ff ff ff    	jg     80109af5 <APCharacterInit+0x1524>
		else if(i>=25&&i<34)
			character_img[i][j] = RGB(128,64,0);

		
}}
line =line +3;
80109bf2:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
80109bf9:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109bff:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
80109c05:	e9 df 00 00 00       	jmp    80109ce9 <APCharacterInit+0x1718>
	for(int i=0;i<40;i++){
80109c0a:	c7 85 70 ff ff ff 00 	movl   $0x0,-0x90(%ebp)
80109c11:	00 00 00 
80109c14:	e9 bc 00 00 00       	jmp    80109cd5 <APCharacterInit+0x1704>
               if(i<11)
80109c19:	83 bd 70 ff ff ff 0a 	cmpl   $0xa,-0x90(%ebp)
80109c20:	7f 4e                	jg     80109c70 <APCharacterInit+0x169f>
			character_img[i][j] = RGB(128,64,0);
80109c22:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
80109c28:	8b 8d 70 ff ff ff    	mov    -0x90(%ebp),%ecx
80109c2e:	89 d0                	mov    %edx,%eax
80109c30:	01 c0                	add    %eax,%eax
80109c32:	01 d0                	add    %edx,%eax
80109c34:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109c3a:	01 d0                	add    %edx,%eax
80109c3c:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109c42:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109c48:	6a 00                	push   $0x0
80109c4a:	6a 40                	push   $0x40
80109c4c:	68 80 00 00 00       	push   $0x80
80109c51:	50                   	push   %eax
80109c52:	e8 16 e7 ff ff       	call   8010836d <RGB>
80109c57:	83 c4 0c             	add    $0xc,%esp
80109c5a:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109c61:	66 89 03             	mov    %ax,(%ebx)
80109c64:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109c6b:	88 43 02             	mov    %al,0x2(%ebx)
80109c6e:	eb 5e                	jmp    80109cce <APCharacterInit+0x16fd>
		
		else if(i>=25&&i<35)
80109c70:	83 bd 70 ff ff ff 18 	cmpl   $0x18,-0x90(%ebp)
80109c77:	7e 55                	jle    80109cce <APCharacterInit+0x16fd>
80109c79:	83 bd 70 ff ff ff 22 	cmpl   $0x22,-0x90(%ebp)
80109c80:	7f 4c                	jg     80109cce <APCharacterInit+0x16fd>
			character_img[i][j] = RGB(128,64,0);
80109c82:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
80109c88:	8b 8d 70 ff ff ff    	mov    -0x90(%ebp),%ecx
80109c8e:	89 d0                	mov    %edx,%eax
80109c90:	01 c0                	add    %eax,%eax
80109c92:	01 d0                	add    %edx,%eax
80109c94:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109c9a:	01 d0                	add    %edx,%eax
80109c9c:	8d 98 c0 78 11 80    	lea    -0x7fee8740(%eax),%ebx
80109ca2:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109ca8:	6a 00                	push   $0x0
80109caa:	6a 40                	push   $0x40
80109cac:	68 80 00 00 00       	push   $0x80
80109cb1:	50                   	push   %eax
80109cb2:	e8 b6 e6 ff ff       	call   8010836d <RGB>
80109cb7:	83 c4 0c             	add    $0xc,%esp
80109cba:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109cc1:	66 89 03             	mov    %ax,(%ebx)
80109cc4:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109ccb:	88 43 02             	mov    %al,0x2(%ebx)

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109cce:	83 85 70 ff ff ff 01 	addl   $0x1,-0x90(%ebp)
80109cd5:	83 bd 70 ff ff ff 27 	cmpl   $0x27,-0x90(%ebp)
80109cdc:	0f 8e 37 ff ff ff    	jle    80109c19 <APCharacterInit+0x1648>
			character_img[i][j] = RGB(128,64,0);

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
80109ce2:	83 85 74 ff ff ff 01 	addl   $0x1,-0x8c(%ebp)
80109ce9:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109cef:	83 c0 03             	add    $0x3,%eax
80109cf2:	3b 85 74 ff ff ff    	cmp    -0x8c(%ebp),%eax
80109cf8:	0f 8f 0c ff ff ff    	jg     80109c0a <APCharacterInit+0x1639>
			character_img[i][j] = RGB(128,64,0);

		
}}

   for(int j=0;j<GRID_WIDTH;j++)
80109cfe:	c7 85 6c ff ff ff 00 	movl   $0x0,-0x94(%ebp)
80109d05:	00 00 00 
80109d08:	eb 76                	jmp    80109d80 <APCharacterInit+0x17af>
   	for(int i=0;i<GRID_WIDTH;i++)
80109d0a:	c7 85 68 ff ff ff 00 	movl   $0x0,-0x98(%ebp)
80109d11:	00 00 00 
80109d14:	eb 5a                	jmp    80109d70 <APCharacterInit+0x179f>
      		character_img2[GRID_WIDTH-1-i][j] = character_img[i][j];
80109d16:	b8 31 00 00 00       	mov    $0x31,%eax
80109d1b:	2b 85 68 ff ff ff    	sub    -0x98(%ebp),%eax
80109d21:	89 c1                	mov    %eax,%ecx
80109d23:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
80109d29:	89 d0                	mov    %edx,%eax
80109d2b:	01 c0                	add    %eax,%eax
80109d2d:	01 d0                	add    %edx,%eax
80109d2f:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109d35:	01 d0                	add    %edx,%eax
80109d37:	8d 90 20 96 11 80    	lea    -0x7fee69e0(%eax),%edx
80109d3d:	8b 8d 6c ff ff ff    	mov    -0x94(%ebp),%ecx
80109d43:	8b 9d 68 ff ff ff    	mov    -0x98(%ebp),%ebx
80109d49:	89 c8                	mov    %ecx,%eax
80109d4b:	01 c0                	add    %eax,%eax
80109d4d:	01 c8                	add    %ecx,%eax
80109d4f:	69 cb 96 00 00 00    	imul   $0x96,%ebx,%ecx
80109d55:	01 c8                	add    %ecx,%eax
80109d57:	05 c0 78 11 80       	add    $0x801178c0,%eax
80109d5c:	0f b7 08             	movzwl (%eax),%ecx
80109d5f:	66 89 0a             	mov    %cx,(%edx)
80109d62:	0f b6 40 02          	movzbl 0x2(%eax),%eax
80109d66:	88 42 02             	mov    %al,0x2(%edx)

		
}}

   for(int j=0;j<GRID_WIDTH;j++)
   	for(int i=0;i<GRID_WIDTH;i++)
80109d69:	83 85 68 ff ff ff 01 	addl   $0x1,-0x98(%ebp)
80109d70:	83 bd 68 ff ff ff 31 	cmpl   $0x31,-0x98(%ebp)
80109d77:	7e 9d                	jle    80109d16 <APCharacterInit+0x1745>
			character_img[i][j] = RGB(128,64,0);

		
}}

   for(int j=0;j<GRID_WIDTH;j++)
80109d79:	83 85 6c ff ff ff 01 	addl   $0x1,-0x94(%ebp)
80109d80:	83 bd 6c ff ff ff 31 	cmpl   $0x31,-0x94(%ebp)
80109d87:	7e 81                	jle    80109d0a <APCharacterInit+0x1739>
   	for(int i=0;i<GRID_WIDTH;i++)
      		character_img2[GRID_WIDTH-1-i][j] = character_img[i][j];
}
80109d89:	90                   	nop
80109d8a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80109d8d:	c9                   	leave  
80109d8e:	c3                   	ret    

80109d8f <APGuiInit>:

void APGuiInit(void)
{
80109d8f:	55                   	push   %ebp
80109d90:	89 e5                	mov    %esp,%ebp
80109d92:	53                   	push   %ebx
80109d93:	83 ec 04             	sub    $0x4,%esp
    screenAddr = (AColor *)(*((uint*)P2V(0x1028)));
80109d96:	b8 28 10 00 80       	mov    $0x80001028,%eax
80109d9b:	8b 00                	mov    (%eax),%eax
80109d9d:	a3 a8 e6 10 80       	mov    %eax,0x8010e6a8
    screenWidth = *((ushort *)P2V(0x1012));
80109da2:	b8 12 10 00 80       	mov    $0x80001012,%eax
80109da7:	0f b7 00             	movzwl (%eax),%eax
80109daa:	66 a3 94 e6 10 80    	mov    %ax,0x8010e694
    screenHeight = *((ushort *)P2V(0x1014));
80109db0:	b8 14 10 00 80       	mov    $0x80001014,%eax
80109db5:	0f b7 00             	movzwl (%eax),%eax
80109db8:	66 a3 96 e6 10 80    	mov    %ax,0x8010e696
    bitsPerPixel = *((uchar*)P2V(0x1019));
80109dbe:	b8 19 10 00 80       	mov    $0x80001019,%eax
80109dc3:	0f b6 00             	movzbl (%eax),%eax
80109dc6:	a2 98 e6 10 80       	mov    %al,0x8010e698
    screenBuf = screenAddr + screenWidth * screenHeight;
80109dcb:	8b 15 a8 e6 10 80    	mov    0x8010e6a8,%edx
80109dd1:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109dd8:	0f b7 c8             	movzwl %ax,%ecx
80109ddb:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
80109de2:	0f b7 c0             	movzwl %ax,%eax
80109de5:	0f af c1             	imul   %ecx,%eax
80109de8:	89 c1                	mov    %eax,%ecx
80109dea:	89 c8                	mov    %ecx,%eax
80109dec:	01 c0                	add    %eax,%eax
80109dee:	01 c8                	add    %ecx,%eax
80109df0:	01 d0                	add    %edx,%eax
80109df2:	a3 ac e6 10 80       	mov    %eax,0x8010e6ac
    screenContent = screenBuf + screenWidth * screenHeight;
80109df7:	8b 15 ac e6 10 80    	mov    0x8010e6ac,%edx
80109dfd:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109e04:	0f b7 c8             	movzwl %ax,%ecx
80109e07:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
80109e0e:	0f b7 c0             	movzwl %ax,%eax
80109e11:	0f af c1             	imul   %ecx,%eax
80109e14:	89 c1                	mov    %eax,%ecx
80109e16:	89 c8                	mov    %ecx,%eax
80109e18:	01 c0                	add    %eax,%eax
80109e1a:	01 c8                	add    %ecx,%eax
80109e1c:	01 d0                	add    %edx,%eax
80109e1e:	a3 b0 e6 10 80       	mov    %eax,0x8010e6b0
    
    cprintf("screen addr : %x, screen width : %d, screen height : %d, bitsPerPixel: %d \n",
80109e23:	0f b6 05 98 e6 10 80 	movzbl 0x8010e698,%eax
80109e2a:	0f b6 d8             	movzbl %al,%ebx
80109e2d:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
80109e34:	0f b7 c8             	movzwl %ax,%ecx
80109e37:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109e3e:	0f b7 d0             	movzwl %ax,%edx
80109e41:	a1 a8 e6 10 80       	mov    0x8010e6a8,%eax
80109e46:	83 ec 0c             	sub    $0xc,%esp
80109e49:	53                   	push   %ebx
80109e4a:	51                   	push   %ecx
80109e4b:	52                   	push   %edx
80109e4c:	50                   	push   %eax
80109e4d:	68 14 bb 10 80       	push   $0x8010bb14
80109e52:	e8 6f 65 ff ff       	call   801003c6 <cprintf>
80109e57:	83 c4 20             	add    $0x20,%esp
            screenAddr, screenWidth,screenHeight,bitsPerPixel);
    
    initlock(&screenLock,"sreenLock");
80109e5a:	83 ec 08             	sub    $0x8,%esp
80109e5d:	68 60 bb 10 80       	push   $0x8010bb60
80109e62:	68 60 57 11 80       	push   $0x80115760
80109e67:	e8 e6 af ff ff       	call   80104e52 <initlock>
80109e6c:	83 c4 10             	add    $0x10,%esp
    APCharacterInit();
80109e6f:	e8 5d e7 ff ff       	call   801085d1 <APCharacterInit>
    APTimerListInit(&timerList);
80109e74:	83 ec 0c             	sub    $0xc,%esp
80109e77:	68 80 b3 11 80       	push   $0x8011b380
80109e7c:	e8 67 10 00 00       	call   8010aee8 <APTimerListInit>
80109e81:	83 c4 10             	add    $0x10,%esp
}
80109e84:	90                   	nop
80109e85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80109e88:	c9                   	leave  
80109e89:	c3                   	ret    

80109e8a <APBufPaint>:

//将左上角坐标为(x1,y1),右下角坐标为(x2,y2)的矩形区域从Buf绘制到屏幕上
void APBufPaint(int x1,int y1,int x2,int y2,int is_grid)
{
80109e8a:	55                   	push   %ebp
80109e8b:	89 e5                	mov    %esp,%ebp
80109e8d:	56                   	push   %esi
80109e8e:	53                   	push   %ebx
80109e8f:	83 ec 20             	sub    $0x20,%esp
    acquire(&screenLock);
80109e92:	83 ec 0c             	sub    $0xc,%esp
80109e95:	68 60 57 11 80       	push   $0x80115760
80109e9a:	e8 d5 af ff ff       	call   80104e74 <acquire>
80109e9f:	83 c4 10             	add    $0x10,%esp
    x2 -= x1;
80109ea2:	8b 45 08             	mov    0x8(%ebp),%eax
80109ea5:	29 45 10             	sub    %eax,0x10(%ebp)
    x2 *= sizeof(AColor);
80109ea8:	8b 55 10             	mov    0x10(%ebp),%edx
80109eab:	89 d0                	mov    %edx,%eax
80109ead:	01 c0                	add    %eax,%eax
80109eaf:	01 d0                	add    %edx,%eax
80109eb1:	89 45 10             	mov    %eax,0x10(%ebp)
    int off = x1 + y1 * screenWidth;
80109eb4:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109ebb:	0f b7 c0             	movzwl %ax,%eax
80109ebe:	0f af 45 0c          	imul   0xc(%ebp),%eax
80109ec2:	89 c2                	mov    %eax,%edx
80109ec4:	8b 45 08             	mov    0x8(%ebp),%eax
80109ec7:	01 d0                	add    %edx,%eax
80109ec9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (int y = y1 ; y <= y2; y++)
80109ecc:	8b 45 0c             	mov    0xc(%ebp),%eax
80109ecf:	89 45 f0             	mov    %eax,-0x10(%ebp)
80109ed2:	eb 77                	jmp    80109f4b <APBufPaint+0xc1>
    {
        memmove(screenBuf + off , screenContent + off, x2);
80109ed4:	8b 4d 10             	mov    0x10(%ebp),%ecx
80109ed7:	8b 1d b0 e6 10 80    	mov    0x8010e6b0,%ebx
80109edd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109ee0:	89 d0                	mov    %edx,%eax
80109ee2:	01 c0                	add    %eax,%eax
80109ee4:	01 d0                	add    %edx,%eax
80109ee6:	01 c3                	add    %eax,%ebx
80109ee8:	8b 35 ac e6 10 80    	mov    0x8010e6ac,%esi
80109eee:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109ef1:	89 d0                	mov    %edx,%eax
80109ef3:	01 c0                	add    %eax,%eax
80109ef5:	01 d0                	add    %edx,%eax
80109ef7:	01 f0                	add    %esi,%eax
80109ef9:	83 ec 04             	sub    $0x4,%esp
80109efc:	51                   	push   %ecx
80109efd:	53                   	push   %ebx
80109efe:	50                   	push   %eax
80109eff:	e8 92 b2 ff ff       	call   80105196 <memmove>
80109f04:	83 c4 10             	add    $0x10,%esp
        memmove(screenAddr + off, screenContent + off, x2);
80109f07:	8b 4d 10             	mov    0x10(%ebp),%ecx
80109f0a:	8b 1d b0 e6 10 80    	mov    0x8010e6b0,%ebx
80109f10:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109f13:	89 d0                	mov    %edx,%eax
80109f15:	01 c0                	add    %eax,%eax
80109f17:	01 d0                	add    %edx,%eax
80109f19:	01 c3                	add    %eax,%ebx
80109f1b:	8b 35 a8 e6 10 80    	mov    0x8010e6a8,%esi
80109f21:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109f24:	89 d0                	mov    %edx,%eax
80109f26:	01 c0                	add    %eax,%eax
80109f28:	01 d0                	add    %edx,%eax
80109f2a:	01 f0                	add    %esi,%eax
80109f2c:	83 ec 04             	sub    $0x4,%esp
80109f2f:	51                   	push   %ecx
80109f30:	53                   	push   %ebx
80109f31:	50                   	push   %eax
80109f32:	e8 5f b2 ff ff       	call   80105196 <memmove>
80109f37:	83 c4 10             	add    $0x10,%esp
        off += screenWidth;
80109f3a:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109f41:	0f b7 c0             	movzwl %ax,%eax
80109f44:	01 45 f4             	add    %eax,-0xc(%ebp)
{
    acquire(&screenLock);
    x2 -= x1;
    x2 *= sizeof(AColor);
    int off = x1 + y1 * screenWidth;
    for (int y = y1 ; y <= y2; y++)
80109f47:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80109f4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109f4e:	3b 45 14             	cmp    0x14(%ebp),%eax
80109f51:	7e 81                	jle    80109ed4 <APBufPaint+0x4a>
        memmove(screenBuf + off , screenContent + off, x2);
        memmove(screenAddr + off, screenContent + off, x2);
        off += screenWidth;
    }
    
    if (is_grid)
80109f53:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
80109f57:	0f 84 d6 01 00 00    	je     8010a133 <APBufPaint+0x2a9>
    {
        
        if (x1 <= character_x * GRID_WIDTH + GRID_WIDTH && x2 >= character_x * GRID_WIDTH
80109f5d:	a1 00 e5 10 80       	mov    0x8010e500,%eax
80109f62:	83 c0 01             	add    $0x1,%eax
80109f65:	6b c0 32             	imul   $0x32,%eax,%eax
80109f68:	3b 45 08             	cmp    0x8(%ebp),%eax
80109f6b:	0f 8c c2 01 00 00    	jl     8010a133 <APBufPaint+0x2a9>
80109f71:	a1 00 e5 10 80       	mov    0x8010e500,%eax
80109f76:	6b c0 32             	imul   $0x32,%eax,%eax
80109f79:	3b 45 10             	cmp    0x10(%ebp),%eax
80109f7c:	0f 8f b1 01 00 00    	jg     8010a133 <APBufPaint+0x2a9>
            && y1 <= character_y * GRID_WIDTH + GRID_WIDTH + WND_TITLE_HEIGHT && y2 >= character_y * GRID_WIDTH + WND_TITLE_HEIGHT)
80109f82:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80109f87:	83 c0 02             	add    $0x2,%eax
80109f8a:	6b c0 32             	imul   $0x32,%eax,%eax
80109f8d:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109f90:	0f 8c 9d 01 00 00    	jl     8010a133 <APBufPaint+0x2a9>
80109f96:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80109f9b:	83 c0 01             	add    $0x1,%eax
80109f9e:	6b c0 32             	imul   $0x32,%eax,%eax
80109fa1:	3b 45 14             	cmp    0x14(%ebp),%eax
80109fa4:	0f 8f 89 01 00 00    	jg     8010a133 <APBufPaint+0x2a9>
        {
            for (int j = 0; j < GRID_WIDTH ; j++)
80109faa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80109fb1:	e9 70 01 00 00       	jmp    8010a126 <APBufPaint+0x29c>
            {
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
80109fb6:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80109fbb:	83 c0 01             	add    $0x1,%eax
80109fbe:	6b d0 32             	imul   $0x32,%eax,%edx
80109fc1:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109fc4:	01 c2                	add    %eax,%edx
80109fc6:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
80109fcd:	0f b7 c0             	movzwl %ax,%eax
80109fd0:	0f af d0             	imul   %eax,%edx
80109fd3:	a1 00 e5 10 80       	mov    0x8010e500,%eax
80109fd8:	6b c0 32             	imul   $0x32,%eax,%eax
80109fdb:	01 d0                	add    %edx,%eax
80109fdd:	89 45 f4             	mov    %eax,-0xc(%ebp)
                if (character_y * GRID_WIDTH + j < y1)
80109fe0:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80109fe5:	6b d0 32             	imul   $0x32,%eax,%edx
80109fe8:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109feb:	01 d0                	add    %edx,%eax
80109fed:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109ff0:	0f 8c 28 01 00 00    	jl     8010a11e <APBufPaint+0x294>
                    continue;
                if (character_y * GRID_WIDTH + j > y2)
80109ff6:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80109ffb:	6b d0 32             	imul   $0x32,%eax,%edx
80109ffe:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a001:	01 d0                	add    %edx,%eax
8010a003:	3b 45 14             	cmp    0x14(%ebp),%eax
8010a006:	0f 8f 26 01 00 00    	jg     8010a132 <APBufPaint+0x2a8>
                    break;
                for (int i = 0; i < GRID_WIDTH; i++)
8010a00c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
8010a013:	e9 fa 00 00 00       	jmp    8010a112 <APBufPaint+0x288>
                {
                    if (character_x * GRID_WIDTH + i < x1)
8010a018:	a1 00 e5 10 80       	mov    0x8010e500,%eax
8010a01d:	6b d0 32             	imul   $0x32,%eax,%edx
8010a020:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a023:	01 d0                	add    %edx,%eax
8010a025:	3b 45 08             	cmp    0x8(%ebp),%eax
8010a028:	0f 8c df 00 00 00    	jl     8010a10d <APBufPaint+0x283>
                        continue;
                    if (character_x * GRID_WIDTH + i > x2)
8010a02e:	a1 00 e5 10 80       	mov    0x8010e500,%eax
8010a033:	6b d0 32             	imul   $0x32,%eax,%edx
8010a036:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a039:	01 d0                	add    %edx,%eax
8010a03b:	3b 45 10             	cmp    0x10(%ebp),%eax
8010a03e:	0f 8f dd 00 00 00    	jg     8010a121 <APBufPaint+0x297>
                        break;
                    
                    AColor c;
                    if (direction == 1) c = character_img[i][j];
8010a044:	a1 08 e5 10 80       	mov    0x8010e508,%eax
8010a049:	83 f8 01             	cmp    $0x1,%eax
8010a04c:	75 29                	jne    8010a077 <APBufPaint+0x1ed>
8010a04e:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010a051:	8b 4d e8             	mov    -0x18(%ebp),%ecx
8010a054:	89 d0                	mov    %edx,%eax
8010a056:	01 c0                	add    %eax,%eax
8010a058:	01 d0                	add    %edx,%eax
8010a05a:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010a060:	01 d0                	add    %edx,%eax
8010a062:	05 c0 78 11 80       	add    $0x801178c0,%eax
8010a067:	0f b7 10             	movzwl (%eax),%edx
8010a06a:	66 89 55 e5          	mov    %dx,-0x1b(%ebp)
8010a06e:	0f b6 40 02          	movzbl 0x2(%eax),%eax
8010a072:	88 45 e7             	mov    %al,-0x19(%ebp)
8010a075:	eb 30                	jmp    8010a0a7 <APBufPaint+0x21d>
                    else if (direction == 0)  c = character_img2[i][j];
8010a077:	a1 08 e5 10 80       	mov    0x8010e508,%eax
8010a07c:	85 c0                	test   %eax,%eax
8010a07e:	75 27                	jne    8010a0a7 <APBufPaint+0x21d>
8010a080:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010a083:	8b 4d e8             	mov    -0x18(%ebp),%ecx
8010a086:	89 d0                	mov    %edx,%eax
8010a088:	01 c0                	add    %eax,%eax
8010a08a:	01 d0                	add    %edx,%eax
8010a08c:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010a092:	01 d0                	add    %edx,%eax
8010a094:	05 20 96 11 80       	add    $0x80119620,%eax
8010a099:	0f b7 10             	movzwl (%eax),%edx
8010a09c:	66 89 55 e5          	mov    %dx,-0x1b(%ebp)
8010a0a0:	0f b6 40 02          	movzbl 0x2(%eax),%eax
8010a0a4:	88 45 e7             	mov    %al,-0x19(%ebp)
                    
                    if (c.r != COLOR_TRANSPARENT || c.g!=COLOR_TRANSPARENT || c.b !=COLOR_TRANSPARENT)
8010a0a7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010a0ab:	3c 0c                	cmp    $0xc,%al
8010a0ad:	75 10                	jne    8010a0bf <APBufPaint+0x235>
8010a0af:	0f b6 45 e6          	movzbl -0x1a(%ebp),%eax
8010a0b3:	3c 0c                	cmp    $0xc,%al
8010a0b5:	75 08                	jne    8010a0bf <APBufPaint+0x235>
8010a0b7:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
8010a0bb:	3c 0c                	cmp    $0xc,%al
8010a0bd:	74 4f                	je     8010a10e <APBufPaint+0x284>
                    {
                        screenBuf [off + i] = c;
8010a0bf:	8b 15 ac e6 10 80    	mov    0x8010e6ac,%edx
8010a0c5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010a0c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a0cb:	01 c8                	add    %ecx,%eax
8010a0cd:	89 c1                	mov    %eax,%ecx
8010a0cf:	89 c8                	mov    %ecx,%eax
8010a0d1:	01 c0                	add    %eax,%eax
8010a0d3:	01 c8                	add    %ecx,%eax
8010a0d5:	01 d0                	add    %edx,%eax
8010a0d7:	0f b7 55 e5          	movzwl -0x1b(%ebp),%edx
8010a0db:	66 89 10             	mov    %dx,(%eax)
8010a0de:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
8010a0e2:	88 50 02             	mov    %dl,0x2(%eax)
                        screenAddr[off + i] = c;
8010a0e5:	8b 15 a8 e6 10 80    	mov    0x8010e6a8,%edx
8010a0eb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010a0ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a0f1:	01 c8                	add    %ecx,%eax
8010a0f3:	89 c1                	mov    %eax,%ecx
8010a0f5:	89 c8                	mov    %ecx,%eax
8010a0f7:	01 c0                	add    %eax,%eax
8010a0f9:	01 c8                	add    %ecx,%eax
8010a0fb:	01 d0                	add    %edx,%eax
8010a0fd:	0f b7 55 e5          	movzwl -0x1b(%ebp),%edx
8010a101:	66 89 10             	mov    %dx,(%eax)
8010a104:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
8010a108:	88 50 02             	mov    %dl,0x2(%eax)
8010a10b:	eb 01                	jmp    8010a10e <APBufPaint+0x284>
                if (character_y * GRID_WIDTH + j > y2)
                    break;
                for (int i = 0; i < GRID_WIDTH; i++)
                {
                    if (character_x * GRID_WIDTH + i < x1)
                        continue;
8010a10d:	90                   	nop
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
                if (character_y * GRID_WIDTH + j < y1)
                    continue;
                if (character_y * GRID_WIDTH + j > y2)
                    break;
                for (int i = 0; i < GRID_WIDTH; i++)
8010a10e:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
8010a112:	83 7d e8 31          	cmpl   $0x31,-0x18(%ebp)
8010a116:	0f 8e fc fe ff ff    	jle    8010a018 <APBufPaint+0x18e>
8010a11c:	eb 04                	jmp    8010a122 <APBufPaint+0x298>
        {
            for (int j = 0; j < GRID_WIDTH ; j++)
            {
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
                if (character_y * GRID_WIDTH + j < y1)
                    continue;
8010a11e:	90                   	nop
8010a11f:	eb 01                	jmp    8010a122 <APBufPaint+0x298>
                for (int i = 0; i < GRID_WIDTH; i++)
                {
                    if (character_x * GRID_WIDTH + i < x1)
                        continue;
                    if (character_x * GRID_WIDTH + i > x2)
                        break;
8010a121:	90                   	nop
    {
        
        if (x1 <= character_x * GRID_WIDTH + GRID_WIDTH && x2 >= character_x * GRID_WIDTH
            && y1 <= character_y * GRID_WIDTH + GRID_WIDTH + WND_TITLE_HEIGHT && y2 >= character_y * GRID_WIDTH + WND_TITLE_HEIGHT)
        {
            for (int j = 0; j < GRID_WIDTH ; j++)
8010a122:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
8010a126:	83 7d ec 31          	cmpl   $0x31,-0x14(%ebp)
8010a12a:	0f 8e 86 fe ff ff    	jle    80109fb6 <APBufPaint+0x12c>
8010a130:	eb 01                	jmp    8010a133 <APBufPaint+0x2a9>
            {
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
                if (character_y * GRID_WIDTH + j < y1)
                    continue;
                if (character_y * GRID_WIDTH + j > y2)
                    break;
8010a132:	90                   	nop
            }
        }
    }
    //cprintf("arbitrary set window color!\n");
    //memset(screenAddr, DEFAULT_WINDOW_COLOR, sizeof(AColor) * screenWidth * screenHeight);
    release(&screenLock);
8010a133:	83 ec 0c             	sub    $0xc,%esp
8010a136:	68 60 57 11 80       	push   $0x80115760
8010a13b:	e8 9b ad ff ff       	call   80104edb <release>
8010a140:	83 c4 10             	add    $0x10,%esp
}
8010a143:	90                   	nop
8010a144:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010a147:	5b                   	pop    %ebx
8010a148:	5e                   	pop    %esi
8010a149:	5d                   	pop    %ebp
8010a14a:	c3                   	ret    

8010a14b <sys_paintWindow>:

//paintwindow: (hwnd,wx,wy,hdc,sx,sy,w,h,is_grid,pos_x,pos_y)
int sys_paintWindow(void)
{
8010a14b:	55                   	push   %ebp
8010a14c:	89 e5                	mov    %esp,%ebp
8010a14e:	56                   	push   %esi
8010a14f:	53                   	push   %ebx
8010a150:	83 ec 50             	sub    $0x50,%esp
    //cprintf("in paintWindow function:---- 1  \n");
    AHwnd hwnd = 0;
8010a153:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    AHdc hdc = 0;
8010a15a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    int wx,wy,sx,sy,w,h,is_grid,pos_x,pos_y;
    //从控制台获取数据，并检验值是否合法
    if (argstr(0, (char **)&hwnd) < 0 || argint(1, &wx) < 0 || argint(2, &wy) < 0
8010a161:	83 ec 08             	sub    $0x8,%esp
8010a164:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010a167:	50                   	push   %eax
8010a168:	6a 00                	push   $0x0
8010a16a:	e8 12 b3 ff ff       	call   80105481 <argstr>
8010a16f:	83 c4 10             	add    $0x10,%esp
8010a172:	85 c0                	test   %eax,%eax
8010a174:	0f 88 de 00 00 00    	js     8010a258 <sys_paintWindow+0x10d>
8010a17a:	83 ec 08             	sub    $0x8,%esp
8010a17d:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010a180:	50                   	push   %eax
8010a181:	6a 01                	push   $0x1
8010a183:	e8 74 b2 ff ff       	call   801053fc <argint>
8010a188:	83 c4 10             	add    $0x10,%esp
8010a18b:	85 c0                	test   %eax,%eax
8010a18d:	0f 88 c5 00 00 00    	js     8010a258 <sys_paintWindow+0x10d>
8010a193:	83 ec 08             	sub    $0x8,%esp
8010a196:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010a199:	50                   	push   %eax
8010a19a:	6a 02                	push   $0x2
8010a19c:	e8 5b b2 ff ff       	call   801053fc <argint>
8010a1a1:	83 c4 10             	add    $0x10,%esp
8010a1a4:	85 c0                	test   %eax,%eax
8010a1a6:	0f 88 ac 00 00 00    	js     8010a258 <sys_paintWindow+0x10d>
        || argstr(3, (char **)&hdc) < 0 || argint(4, &sx) < 0
8010a1ac:	83 ec 08             	sub    $0x8,%esp
8010a1af:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010a1b2:	50                   	push   %eax
8010a1b3:	6a 03                	push   $0x3
8010a1b5:	e8 c7 b2 ff ff       	call   80105481 <argstr>
8010a1ba:	83 c4 10             	add    $0x10,%esp
8010a1bd:	85 c0                	test   %eax,%eax
8010a1bf:	0f 88 93 00 00 00    	js     8010a258 <sys_paintWindow+0x10d>
8010a1c5:	83 ec 08             	sub    $0x8,%esp
8010a1c8:	8d 45 d0             	lea    -0x30(%ebp),%eax
8010a1cb:	50                   	push   %eax
8010a1cc:	6a 04                	push   $0x4
8010a1ce:	e8 29 b2 ff ff       	call   801053fc <argint>
8010a1d3:	83 c4 10             	add    $0x10,%esp
8010a1d6:	85 c0                	test   %eax,%eax
8010a1d8:	78 7e                	js     8010a258 <sys_paintWindow+0x10d>
        || argint(5, &sy) < 0 || argint(6, &w) < 0 || argint(7, &h) < 0
8010a1da:	83 ec 08             	sub    $0x8,%esp
8010a1dd:	8d 45 cc             	lea    -0x34(%ebp),%eax
8010a1e0:	50                   	push   %eax
8010a1e1:	6a 05                	push   $0x5
8010a1e3:	e8 14 b2 ff ff       	call   801053fc <argint>
8010a1e8:	83 c4 10             	add    $0x10,%esp
8010a1eb:	85 c0                	test   %eax,%eax
8010a1ed:	78 69                	js     8010a258 <sys_paintWindow+0x10d>
8010a1ef:	83 ec 08             	sub    $0x8,%esp
8010a1f2:	8d 45 c8             	lea    -0x38(%ebp),%eax
8010a1f5:	50                   	push   %eax
8010a1f6:	6a 06                	push   $0x6
8010a1f8:	e8 ff b1 ff ff       	call   801053fc <argint>
8010a1fd:	83 c4 10             	add    $0x10,%esp
8010a200:	85 c0                	test   %eax,%eax
8010a202:	78 54                	js     8010a258 <sys_paintWindow+0x10d>
8010a204:	83 ec 08             	sub    $0x8,%esp
8010a207:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010a20a:	50                   	push   %eax
8010a20b:	6a 07                	push   $0x7
8010a20d:	e8 ea b1 ff ff       	call   801053fc <argint>
8010a212:	83 c4 10             	add    $0x10,%esp
8010a215:	85 c0                	test   %eax,%eax
8010a217:	78 3f                	js     8010a258 <sys_paintWindow+0x10d>
        || argint(8, &is_grid) < 0 ||argint(9, &pos_x) < 0 || argint(10, &pos_y) < 0)
8010a219:	83 ec 08             	sub    $0x8,%esp
8010a21c:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010a21f:	50                   	push   %eax
8010a220:	6a 08                	push   $0x8
8010a222:	e8 d5 b1 ff ff       	call   801053fc <argint>
8010a227:	83 c4 10             	add    $0x10,%esp
8010a22a:	85 c0                	test   %eax,%eax
8010a22c:	78 2a                	js     8010a258 <sys_paintWindow+0x10d>
8010a22e:	83 ec 08             	sub    $0x8,%esp
8010a231:	8d 45 bc             	lea    -0x44(%ebp),%eax
8010a234:	50                   	push   %eax
8010a235:	6a 09                	push   $0x9
8010a237:	e8 c0 b1 ff ff       	call   801053fc <argint>
8010a23c:	83 c4 10             	add    $0x10,%esp
8010a23f:	85 c0                	test   %eax,%eax
8010a241:	78 15                	js     8010a258 <sys_paintWindow+0x10d>
8010a243:	83 ec 08             	sub    $0x8,%esp
8010a246:	8d 45 b8             	lea    -0x48(%ebp),%eax
8010a249:	50                   	push   %eax
8010a24a:	6a 0a                	push   $0xa
8010a24c:	e8 ab b1 ff ff       	call   801053fc <argint>
8010a251:	83 c4 10             	add    $0x10,%esp
8010a254:	85 c0                	test   %eax,%eax
8010a256:	79 0a                	jns    8010a262 <sys_paintWindow+0x117>
        return -1;
8010a258:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a25d:	e9 77 02 00 00       	jmp    8010a4d9 <sys_paintWindow+0x38e>
    
    if (sx < 0 || sy < 0 || h <= 0 || w <= 0 || sx + w > hdc->size.cx || sy + h > hdc->size.cy)
8010a262:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010a265:	85 c0                	test   %eax,%eax
8010a267:	78 38                	js     8010a2a1 <sys_paintWindow+0x156>
8010a269:	8b 45 cc             	mov    -0x34(%ebp),%eax
8010a26c:	85 c0                	test   %eax,%eax
8010a26e:	78 31                	js     8010a2a1 <sys_paintWindow+0x156>
8010a270:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a273:	85 c0                	test   %eax,%eax
8010a275:	7e 2a                	jle    8010a2a1 <sys_paintWindow+0x156>
8010a277:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a27a:	85 c0                	test   %eax,%eax
8010a27c:	7e 23                	jle    8010a2a1 <sys_paintWindow+0x156>
8010a27e:	8b 55 d0             	mov    -0x30(%ebp),%edx
8010a281:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a284:	01 c2                	add    %eax,%edx
8010a286:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a289:	8b 00                	mov    (%eax),%eax
8010a28b:	39 c2                	cmp    %eax,%edx
8010a28d:	7f 12                	jg     8010a2a1 <sys_paintWindow+0x156>
8010a28f:	8b 55 cc             	mov    -0x34(%ebp),%edx
8010a292:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a295:	01 c2                	add    %eax,%edx
8010a297:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a29a:	8b 40 04             	mov    0x4(%eax),%eax
8010a29d:	39 c2                	cmp    %eax,%edx
8010a29f:	7e 0a                	jle    8010a2ab <sys_paintWindow+0x160>
        return 0;
8010a2a1:	b8 00 00 00 00       	mov    $0x0,%eax
8010a2a6:	e9 2e 02 00 00       	jmp    8010a4d9 <sys_paintWindow+0x38e>
    
    if (wx < 0 || wy < 0 || wx + w > screenWidth || wy + h > screenHeight)
8010a2ab:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a2ae:	85 c0                	test   %eax,%eax
8010a2b0:	78 33                	js     8010a2e5 <sys_paintWindow+0x19a>
8010a2b2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a2b5:	85 c0                	test   %eax,%eax
8010a2b7:	78 2c                	js     8010a2e5 <sys_paintWindow+0x19a>
8010a2b9:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010a2bc:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a2bf:	01 c2                	add    %eax,%edx
8010a2c1:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010a2c8:	0f b7 c0             	movzwl %ax,%eax
8010a2cb:	39 c2                	cmp    %eax,%edx
8010a2cd:	7f 16                	jg     8010a2e5 <sys_paintWindow+0x19a>
8010a2cf:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a2d2:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a2d5:	01 c2                	add    %eax,%edx
8010a2d7:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
8010a2de:	0f b7 c0             	movzwl %ax,%eax
8010a2e1:	39 c2                	cmp    %eax,%edx
8010a2e3:	7e 0a                	jle    8010a2ef <sys_paintWindow+0x1a4>
        return 0;
8010a2e5:	b8 00 00 00 00       	mov    $0x0,%eax
8010a2ea:	e9 ea 01 00 00       	jmp    8010a4d9 <sys_paintWindow+0x38e>
    
    character_x = pos_x;
8010a2ef:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010a2f2:	a3 00 e5 10 80       	mov    %eax,0x8010e500
    character_y = pos_y;
8010a2f7:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010a2fa:	a3 04 e5 10 80       	mov    %eax,0x8010e504
    //wx,wy是window重绘左上角坐标
    //int id = hwnd ->id;
    //cprintf("in paintWindow function:-----2  \n");
    AColor *data = hdc->content;
8010a2ff:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a302:	8b 40 18             	mov    0x18(%eax),%eax
8010a305:	89 45 ec             	mov    %eax,-0x14(%ebp)
    
    int j;
    for (int i = 0; i < h;i++)
8010a308:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010a30f:	e9 18 01 00 00       	jmp    8010a42c <sys_paintWindow+0x2e1>
    {
        if (wy + i < 0)
8010a314:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a317:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a31a:	01 d0                	add    %edx,%eax
8010a31c:	85 c0                	test   %eax,%eax
8010a31e:	79 0d                	jns    8010a32d <sys_paintWindow+0x1e2>
        {
            i = -wy - 1;
8010a320:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a323:	f7 d0                	not    %eax
8010a325:	89 45 f0             	mov    %eax,-0x10(%ebp)
            continue;
8010a328:	e9 fb 00 00 00       	jmp    8010a428 <sys_paintWindow+0x2dd>
        }
        else if (wy + i >= screenHeight)
8010a32d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a330:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a333:	01 c2                	add    %eax,%edx
8010a335:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
8010a33c:	0f b7 c0             	movzwl %ax,%eax
8010a33f:	39 c2                	cmp    %eax,%edx
8010a341:	0f 8d f3 00 00 00    	jge    8010a43a <sys_paintWindow+0x2ef>
            break;
        int off_x = (sy + i) * hdc->size.cx + sx;
8010a347:	8b 55 cc             	mov    -0x34(%ebp),%edx
8010a34a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a34d:	01 c2                	add    %eax,%edx
8010a34f:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a352:	8b 00                	mov    (%eax),%eax
8010a354:	0f af d0             	imul   %eax,%edx
8010a357:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010a35a:	01 d0                	add    %edx,%eax
8010a35c:	89 45 e8             	mov    %eax,-0x18(%ebp)
        int screen_off_x = (wy + i) * screenWidth + wx;
8010a35f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a362:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a365:	01 c2                	add    %eax,%edx
8010a367:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010a36e:	0f b7 c0             	movzwl %ax,%eax
8010a371:	0f af d0             	imul   %eax,%edx
8010a374:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a377:	01 d0                	add    %edx,%eax
8010a379:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        for (j = 0; j < w; ++j)
8010a37c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010a383:	e9 91 00 00 00       	jmp    8010a419 <sys_paintWindow+0x2ce>
        {
            if (wx + j < 0)
8010a388:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010a38b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a38e:	01 d0                	add    %edx,%eax
8010a390:	85 c0                	test   %eax,%eax
8010a392:	79 0a                	jns    8010a39e <sys_paintWindow+0x253>
            {
                j = -wx - 1;
8010a394:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a397:	f7 d0                	not    %eax
8010a399:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010a39c:	eb 77                	jmp    8010a415 <sys_paintWindow+0x2ca>
                continue;
            }
            else if (wx + j >= screenWidth)
8010a39e:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010a3a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a3a4:	01 c2                	add    %eax,%edx
8010a3a6:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010a3ad:	0f b7 c0             	movzwl %ax,%eax
8010a3b0:	39 c2                	cmp    %eax,%edx
8010a3b2:	7d 73                	jge    8010a427 <sys_paintWindow+0x2dc>
                break;
            
            AColor c = data[off_x + j];
8010a3b4:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010a3b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a3ba:	01 d0                	add    %edx,%eax
8010a3bc:	89 c2                	mov    %eax,%edx
8010a3be:	89 d0                	mov    %edx,%eax
8010a3c0:	01 c0                	add    %eax,%eax
8010a3c2:	01 c2                	add    %eax,%edx
8010a3c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a3c7:	01 d0                	add    %edx,%eax
8010a3c9:	0f b7 10             	movzwl (%eax),%edx
8010a3cc:	66 89 55 b5          	mov    %dx,-0x4b(%ebp)
8010a3d0:	0f b6 40 02          	movzbl 0x2(%eax),%eax
8010a3d4:	88 45 b7             	mov    %al,-0x49(%ebp)
            if (c.r != COLOR_TRANSPARENT || c.g != COLOR_TRANSPARENT || c.b != COLOR_TRANSPARENT )
8010a3d7:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010a3db:	3c 0c                	cmp    $0xc,%al
8010a3dd:	75 10                	jne    8010a3ef <sys_paintWindow+0x2a4>
8010a3df:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
8010a3e3:	3c 0c                	cmp    $0xc,%al
8010a3e5:	75 08                	jne    8010a3ef <sys_paintWindow+0x2a4>
8010a3e7:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010a3eb:	3c 0c                	cmp    $0xc,%al
8010a3ed:	74 26                	je     8010a415 <sys_paintWindow+0x2ca>
                screenContent[screen_off_x + j] = c;
8010a3ef:	8b 15 b0 e6 10 80    	mov    0x8010e6b0,%edx
8010a3f5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010a3f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a3fb:	01 c8                	add    %ecx,%eax
8010a3fd:	89 c1                	mov    %eax,%ecx
8010a3ff:	89 c8                	mov    %ecx,%eax
8010a401:	01 c0                	add    %eax,%eax
8010a403:	01 c8                	add    %ecx,%eax
8010a405:	01 d0                	add    %edx,%eax
8010a407:	0f b7 55 b5          	movzwl -0x4b(%ebp),%edx
8010a40b:	66 89 10             	mov    %dx,(%eax)
8010a40e:	0f b6 55 b7          	movzbl -0x49(%ebp),%edx
8010a412:	88 50 02             	mov    %dl,0x2(%eax)
        }
        else if (wy + i >= screenHeight)
            break;
        int off_x = (sy + i) * hdc->size.cx + sx;
        int screen_off_x = (wy + i) * screenWidth + wx;
        for (j = 0; j < w; ++j)
8010a415:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010a419:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a41c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010a41f:	0f 8c 63 ff ff ff    	jl     8010a388 <sys_paintWindow+0x23d>
8010a425:	eb 01                	jmp    8010a428 <sys_paintWindow+0x2dd>
            {
                j = -wx - 1;
                continue;
            }
            else if (wx + j >= screenWidth)
                break;
8010a427:	90                   	nop
    //int id = hwnd ->id;
    //cprintf("in paintWindow function:-----2  \n");
    AColor *data = hdc->content;
    
    int j;
    for (int i = 0; i < h;i++)
8010a428:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010a42c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a42f:	39 45 f0             	cmp    %eax,-0x10(%ebp)
8010a432:	0f 8c dc fe ff ff    	jl     8010a314 <sys_paintWindow+0x1c9>
8010a438:	eb 01                	jmp    8010a43b <sys_paintWindow+0x2f0>
        {
            i = -wy - 1;
            continue;
        }
        else if (wy + i >= screenHeight)
            break;
8010a43a:	90                   	nop
            AColor c = data[off_x + j];
            if (c.r != COLOR_TRANSPARENT || c.g != COLOR_TRANSPARENT || c.b != COLOR_TRANSPARENT )
                screenContent[screen_off_x + j] = c;
        }
    }
    w += wx - 1;
8010a43b:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a43e:	8d 50 ff             	lea    -0x1(%eax),%edx
8010a441:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a444:	01 d0                	add    %edx,%eax
8010a446:	89 45 c8             	mov    %eax,-0x38(%ebp)
    h += wy - 1;
8010a449:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a44c:	8d 50 ff             	lea    -0x1(%eax),%edx
8010a44f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a452:	01 d0                	add    %edx,%eax
8010a454:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    if (wx < 0)
8010a457:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a45a:	85 c0                	test   %eax,%eax
8010a45c:	79 07                	jns    8010a465 <sys_paintWindow+0x31a>
        wx = 0;
8010a45e:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    if (wy < 0)
8010a465:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a468:	85 c0                	test   %eax,%eax
8010a46a:	79 07                	jns    8010a473 <sys_paintWindow+0x328>
        wy = 0;
8010a46c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    if (h >= screenHeight)
8010a473:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
8010a47a:	0f b7 d0             	movzwl %ax,%edx
8010a47d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a480:	39 c2                	cmp    %eax,%edx
8010a482:	7f 10                	jg     8010a494 <sys_paintWindow+0x349>
        h = screenHeight - 1;
8010a484:	0f b7 05 96 e6 10 80 	movzwl 0x8010e696,%eax
8010a48b:	0f b7 c0             	movzwl %ax,%eax
8010a48e:	83 e8 01             	sub    $0x1,%eax
8010a491:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    if (w >= screenWidth)
8010a494:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010a49b:	0f b7 d0             	movzwl %ax,%edx
8010a49e:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a4a1:	39 c2                	cmp    %eax,%edx
8010a4a3:	7f 10                	jg     8010a4b5 <sys_paintWindow+0x36a>
        w = screenWidth - 1;
8010a4a5:	0f b7 05 94 e6 10 80 	movzwl 0x8010e694,%eax
8010a4ac:	0f b7 c0             	movzwl %ax,%eax
8010a4af:	83 e8 01             	sub    $0x1,%eax
8010a4b2:	89 45 c8             	mov    %eax,-0x38(%ebp)
    //release(&videoLock);
    APBufPaint(wx, wy, w, h,is_grid);
8010a4b5:	8b 75 c0             	mov    -0x40(%ebp),%esi
8010a4b8:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
8010a4bb:	8b 4d c8             	mov    -0x38(%ebp),%ecx
8010a4be:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a4c1:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a4c4:	83 ec 0c             	sub    $0xc,%esp
8010a4c7:	56                   	push   %esi
8010a4c8:	53                   	push   %ebx
8010a4c9:	51                   	push   %ecx
8010a4ca:	52                   	push   %edx
8010a4cb:	50                   	push   %eax
8010a4cc:	e8 b9 f9 ff ff       	call   80109e8a <APBufPaint>
8010a4d1:	83 c4 20             	add    $0x20,%esp
    return 0;
8010a4d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a4d9:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010a4dc:	5b                   	pop    %ebx
8010a4dd:	5e                   	pop    %esi
8010a4de:	5d                   	pop    %ebp
8010a4df:	c3                   	ret    

8010a4e0 <sys_changePosition>:

int sys_changePosition(void)
{
8010a4e0:	55                   	push   %ebp
8010a4e1:	89 e5                	mov    %esp,%ebp
8010a4e3:	83 ec 18             	sub    $0x18,%esp
    int x,y,d;
    if (argint(0, &x) < 0 || argint(1, &y) < 0 || argint(2, &d) < 0)
8010a4e6:	83 ec 08             	sub    $0x8,%esp
8010a4e9:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010a4ec:	50                   	push   %eax
8010a4ed:	6a 00                	push   $0x0
8010a4ef:	e8 08 af ff ff       	call   801053fc <argint>
8010a4f4:	83 c4 10             	add    $0x10,%esp
8010a4f7:	85 c0                	test   %eax,%eax
8010a4f9:	78 2a                	js     8010a525 <sys_changePosition+0x45>
8010a4fb:	83 ec 08             	sub    $0x8,%esp
8010a4fe:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010a501:	50                   	push   %eax
8010a502:	6a 01                	push   $0x1
8010a504:	e8 f3 ae ff ff       	call   801053fc <argint>
8010a509:	83 c4 10             	add    $0x10,%esp
8010a50c:	85 c0                	test   %eax,%eax
8010a50e:	78 15                	js     8010a525 <sys_changePosition+0x45>
8010a510:	83 ec 08             	sub    $0x8,%esp
8010a513:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010a516:	50                   	push   %eax
8010a517:	6a 02                	push   $0x2
8010a519:	e8 de ae ff ff       	call   801053fc <argint>
8010a51e:	83 c4 10             	add    $0x10,%esp
8010a521:	85 c0                	test   %eax,%eax
8010a523:	79 07                	jns    8010a52c <sys_changePosition+0x4c>
        return -1;
8010a525:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a52a:	eb 46                	jmp    8010a572 <sys_changePosition+0x92>
    
    //cprintf("in changePosition\n");
    character_pre_y = character_y;
8010a52c:	a1 04 e5 10 80       	mov    0x8010e504,%eax
8010a531:	a3 a0 e6 10 80       	mov    %eax,0x8010e6a0
    character_pre_x = character_x;
8010a536:	a1 00 e5 10 80       	mov    0x8010e500,%eax
8010a53b:	a3 9c e6 10 80       	mov    %eax,0x8010e69c
    character_x = x;
8010a540:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a543:	a3 00 e5 10 80       	mov    %eax,0x8010e500
    character_y = y;
8010a548:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a54b:	a3 04 e5 10 80       	mov    %eax,0x8010e504
    if (d != 2)
8010a550:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a553:	83 f8 02             	cmp    $0x2,%eax
8010a556:	74 08                	je     8010a560 <sys_changePosition+0x80>
        direction = d;
8010a558:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a55b:	a3 08 e5 10 80       	mov    %eax,0x8010e508
    APDrawCharacter(True);
8010a560:	83 ec 0c             	sub    $0xc,%esp
8010a563:	6a 01                	push   $0x1
8010a565:	e8 4e de ff ff       	call   801083b8 <APDrawCharacter>
8010a56a:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a56d:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a572:	c9                   	leave  
8010a573:	c3                   	ret    

8010a574 <sys_sendMessage>:

int sys_sendMessage(void)
{
8010a574:	55                   	push   %ebp
8010a575:	89 e5                	mov    %esp,%ebp
8010a577:	83 ec 18             	sub    $0x18,%esp
    int wndId = 0;
8010a57a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    AMessage * msg = 0;
8010a581:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    if (argint(0, &wndId) < 0 || argstr(1, (char**)&msg) < 0)
8010a588:	83 ec 08             	sub    $0x8,%esp
8010a58b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010a58e:	50                   	push   %eax
8010a58f:	6a 00                	push   $0x0
8010a591:	e8 66 ae ff ff       	call   801053fc <argint>
8010a596:	83 c4 10             	add    $0x10,%esp
8010a599:	85 c0                	test   %eax,%eax
8010a59b:	78 15                	js     8010a5b2 <sys_sendMessage+0x3e>
8010a59d:	83 ec 08             	sub    $0x8,%esp
8010a5a0:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010a5a3:	50                   	push   %eax
8010a5a4:	6a 01                	push   $0x1
8010a5a6:	e8 d6 ae ff ff       	call   80105481 <argstr>
8010a5ab:	83 c4 10             	add    $0x10,%esp
8010a5ae:	85 c0                	test   %eax,%eax
8010a5b0:	79 07                	jns    8010a5b9 <sys_sendMessage+0x45>
        return -1;
8010a5b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a5b7:	eb 18                	jmp    8010a5d1 <sys_sendMessage+0x5d>
    
    //cprintf("in sys_sendMessage\n");
    
    sendMessage(wndId, msg);
8010a5b9:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010a5bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a5bf:	83 ec 08             	sub    $0x8,%esp
8010a5c2:	52                   	push   %edx
8010a5c3:	50                   	push   %eax
8010a5c4:	e8 29 01 00 00       	call   8010a6f2 <sendMessage>
8010a5c9:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a5cc:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a5d1:	c9                   	leave  
8010a5d2:	c3                   	ret    

8010a5d3 <sys_registWindow>:

int sys_registWindow(void)
{
8010a5d3:	55                   	push   %ebp
8010a5d4:	89 e5                	mov    %esp,%ebp
8010a5d6:	83 ec 18             	sub    $0x18,%esp
    AHwnd hwnd = 0;
8010a5d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (argstr(0, (char **)&hwnd) < 0)
8010a5e0:	83 ec 08             	sub    $0x8,%esp
8010a5e3:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010a5e6:	50                   	push   %eax
8010a5e7:	6a 00                	push   $0x0
8010a5e9:	e8 93 ae ff ff       	call   80105481 <argstr>
8010a5ee:	83 c4 10             	add    $0x10,%esp
8010a5f1:	85 c0                	test   %eax,%eax
8010a5f3:	79 07                	jns    8010a5fc <sys_registWindow+0x29>
        return -1;
8010a5f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a5fa:	eb 19                	jmp    8010a615 <sys_registWindow+0x42>
    APWndListAddToHead(&wndList, hwnd);
8010a5fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a5ff:	83 ec 08             	sub    $0x8,%esp
8010a602:	50                   	push   %eax
8010a603:	68 a0 57 11 80       	push   $0x801157a0
8010a608:	e8 b2 02 00 00       	call   8010a8bf <APWndListAddToHead>
8010a60d:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a610:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a615:	c9                   	leave  
8010a616:	c3                   	ret    

8010a617 <sys_getMessage>:

int sys_getMessage(void)
{
8010a617:	55                   	push   %ebp
8010a618:	89 e5                	mov    %esp,%ebp
8010a61a:	53                   	push   %ebx
8010a61b:	83 ec 24             	sub    $0x24,%esp

    AHwnd hwnd = 0;
8010a61e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (argstr(0, (char **)&hwnd) < 0)
8010a625:	83 ec 08             	sub    $0x8,%esp
8010a628:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010a62b:	50                   	push   %eax
8010a62c:	6a 00                	push   $0x0
8010a62e:	e8 4e ae ff ff       	call   80105481 <argstr>
8010a633:	83 c4 10             	add    $0x10,%esp
8010a636:	85 c0                	test   %eax,%eax
8010a638:	79 0a                	jns    8010a644 <sys_getMessage+0x2d>
        return -1;
8010a63a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a63f:	e9 a9 00 00 00       	jmp    8010a6ed <sys_getMessage+0xd6>
    int wndId = hwnd->id;
8010a644:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a647:	8b 00                	mov    (%eax),%eax
8010a649:	89 45 f4             	mov    %eax,-0xc(%ebp)
    //int pid = hwnd->pid;
    
    //cprintf("in function --- getMessage:WndId: %d\n",wndId);
    
    acquire(&wndList.data[wndId].lock);
8010a64c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a64f:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a655:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a65a:	83 c0 08             	add    $0x8,%eax
8010a65d:	83 ec 0c             	sub    $0xc,%esp
8010a660:	50                   	push   %eax
8010a661:	e8 0e a8 ff ff       	call   80104e74 <acquire>
8010a666:	83 c4 10             	add    $0x10,%esp
    AMsgQueue * queue = &wndList.data[wndId].msgQueue;
8010a669:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a66c:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a672:	83 c0 30             	add    $0x30,%eax
8010a675:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a67a:	83 c0 0c             	add    $0xc,%eax
8010a67d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (queue->head == queue->tail)
    {
        //cprintf("WND: %d is sleeping\n",wndId);
        //sleep((void *)pid,&wndList.data[wndId].lock);
    }
    if (wndList.data[wndId].hwnd->msg.type == MSG_NULL)
8010a680:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a683:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a689:	05 e4 5a 11 80       	add    $0x80115ae4,%eax
8010a68e:	8b 00                	mov    (%eax),%eax
8010a690:	8b 40 74             	mov    0x74(%eax),%eax
8010a693:	85 c0                	test   %eax,%eax
8010a695:	75 34                	jne    8010a6cb <sys_getMessage+0xb4>
    {
      //  cprintf("poping msg!\n");
        wndList.data[wndId].hwnd->msg = APMsgQueueDeQueue(queue);
8010a697:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a69a:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a6a0:	05 e4 5a 11 80       	add    $0x80115ae4,%eax
8010a6a5:	8b 18                	mov    (%eax),%ebx
8010a6a7:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010a6aa:	83 ec 08             	sub    $0x8,%esp
8010a6ad:	ff 75 f0             	pushl  -0x10(%ebp)
8010a6b0:	50                   	push   %eax
8010a6b1:	e8 a3 06 00 00       	call   8010ad59 <APMsgQueueDeQueue>
8010a6b6:	83 c4 0c             	add    $0xc,%esp
8010a6b9:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a6bc:	89 43 74             	mov    %eax,0x74(%ebx)
8010a6bf:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a6c2:	89 43 78             	mov    %eax,0x78(%ebx)
8010a6c5:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010a6c8:	89 43 7c             	mov    %eax,0x7c(%ebx)
    }
    
    release(&wndList.data[wndId].lock);
8010a6cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a6ce:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a6d4:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a6d9:	83 c0 08             	add    $0x8,%eax
8010a6dc:	83 ec 0c             	sub    $0xc,%esp
8010a6df:	50                   	push   %eax
8010a6e0:	e8 f6 a7 ff ff       	call   80104edb <release>
8010a6e5:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a6e8:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a6ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010a6f0:	c9                   	leave  
8010a6f1:	c3                   	ret    

8010a6f2 <sendMessage>:


void sendMessage(int wndId, AMessage *msg)
{
8010a6f2:	55                   	push   %ebp
8010a6f3:	89 e5                	mov    %esp,%ebp
8010a6f5:	83 ec 18             	sub    $0x18,%esp
    cprintf("sendMessage,Messgaetype:%d\n",msg->type);
8010a6f8:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a6fb:	8b 00                	mov    (%eax),%eax
8010a6fd:	83 ec 08             	sub    $0x8,%esp
8010a700:	50                   	push   %eax
8010a701:	68 6a bb 10 80       	push   $0x8010bb6a
8010a706:	e8 bb 5c ff ff       	call   801003c6 <cprintf>
8010a70b:	83 c4 10             	add    $0x10,%esp
    if (wndId == -1 || wndList.data[wndId].hwnd == 0)
8010a70e:	83 7d 08 ff          	cmpl   $0xffffffff,0x8(%ebp)
8010a712:	0f 84 86 00 00 00    	je     8010a79e <sendMessage+0xac>
8010a718:	8b 45 08             	mov    0x8(%ebp),%eax
8010a71b:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a721:	05 e4 5a 11 80       	add    $0x80115ae4,%eax
8010a726:	8b 00                	mov    (%eax),%eax
8010a728:	85 c0                	test   %eax,%eax
8010a72a:	74 72                	je     8010a79e <sendMessage+0xac>
        return;
    //cprintf("in send Message\n");
    //cprintf("send message: WndID:%d \n",wndId);
    AMsgQueue * queue = &wndList.data[wndId].msgQueue;
8010a72c:	8b 45 08             	mov    0x8(%ebp),%eax
8010a72f:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a735:	83 c0 30             	add    $0x30,%eax
8010a738:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a73d:	83 c0 0c             	add    $0xc,%eax
8010a740:	89 45 f4             	mov    %eax,-0xc(%ebp)
    msg->wndID = wndId;
8010a743:	8b 55 08             	mov    0x8(%ebp),%edx
8010a746:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a749:	89 50 08             	mov    %edx,0x8(%eax)
    APMsgQueueEnQueue(queue, *msg);
8010a74c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a74f:	ff 70 08             	pushl  0x8(%eax)
8010a752:	ff 70 04             	pushl  0x4(%eax)
8010a755:	ff 30                	pushl  (%eax)
8010a757:	ff 75 f4             	pushl  -0xc(%ebp)
8010a75a:	e8 7f 05 00 00       	call   8010acde <APMsgQueueEnQueue>
8010a75f:	83 c4 10             	add    $0x10,%esp
    //cprintf("message has entered the queue\n",wndId);
    acquire(&wndList.data[wndId].lock);
8010a762:	8b 45 08             	mov    0x8(%ebp),%eax
8010a765:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a76b:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a770:	83 c0 08             	add    $0x8,%eax
8010a773:	83 ec 0c             	sub    $0xc,%esp
8010a776:	50                   	push   %eax
8010a777:	e8 f8 a6 ff ff       	call   80104e74 <acquire>
8010a77c:	83 c4 10             	add    $0x10,%esp
    //cprintf("lock has acquired!\n");
    //wakeup((void *)wndList.data[wndId].hwnd->pid);
    release(&wndList.data[wndId].lock);
8010a77f:	8b 45 08             	mov    0x8(%ebp),%eax
8010a782:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a788:	05 a0 57 11 80       	add    $0x801157a0,%eax
8010a78d:	83 c0 08             	add    $0x8,%eax
8010a790:	83 ec 0c             	sub    $0xc,%esp
8010a793:	50                   	push   %eax
8010a794:	e8 42 a7 ff ff       	call   80104edb <release>
8010a799:	83 c4 10             	add    $0x10,%esp
8010a79c:	eb 01                	jmp    8010a79f <sendMessage+0xad>

void sendMessage(int wndId, AMessage *msg)
{
    cprintf("sendMessage,Messgaetype:%d\n",msg->type);
    if (wndId == -1 || wndList.data[wndId].hwnd == 0)
        return;
8010a79e:	90                   	nop
    acquire(&wndList.data[wndId].lock);
    //cprintf("lock has acquired!\n");
    //wakeup((void *)wndList.data[wndId].hwnd->pid);
    release(&wndList.data[wndId].lock);
    //cprintf("Wnd %d has waken up!\n",wndId);
}
8010a79f:	c9                   	leave  
8010a7a0:	c3                   	ret    

8010a7a1 <APWndListInit>:
//------------------------------------------------------------------------------------
//WndList

//space--insert_position
void APWndListInit(AWndList * list)
{
8010a7a1:	55                   	push   %ebp
8010a7a2:	89 e5                	mov    %esp,%ebp
8010a7a4:	83 ec 18             	sub    $0x18,%esp
    int i = 0;
8010a7a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    for (i = 0; i < MAX_WND_NUM; ++i)
8010a7ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010a7b5:	e9 8c 00 00 00       	jmp    8010a846 <APWndListInit+0xa5>
    {
        list->data[i].hwnd = 0;
8010a7ba:	8b 55 08             	mov    0x8(%ebp),%edx
8010a7bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a7c0:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a7c6:	01 d0                	add    %edx,%eax
8010a7c8:	05 44 03 00 00       	add    $0x344,%eax
8010a7cd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
        list->data[i].prev = -1;
8010a7d3:	8b 55 08             	mov    0x8(%ebp),%edx
8010a7d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a7d9:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a7df:	01 d0                	add    %edx,%eax
8010a7e1:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
        list->data[i].next = i + 1;
8010a7e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a7ea:	8d 50 01             	lea    0x1(%eax),%edx
8010a7ed:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010a7f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a7f3:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a7f9:	01 c8                	add    %ecx,%eax
8010a7fb:	83 c0 04             	add    $0x4,%eax
8010a7fe:	89 10                	mov    %edx,(%eax)
        APMsgQueueInit(&list->data[i].msgQueue);
8010a800:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a803:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a809:	8d 50 30             	lea    0x30(%eax),%edx
8010a80c:	8b 45 08             	mov    0x8(%ebp),%eax
8010a80f:	01 d0                	add    %edx,%eax
8010a811:	83 c0 0c             	add    $0xc,%eax
8010a814:	83 ec 0c             	sub    $0xc,%esp
8010a817:	50                   	push   %eax
8010a818:	e8 9c 04 00 00       	call   8010acb9 <APMsgQueueInit>
8010a81d:	83 c4 10             	add    $0x10,%esp
        initlock(&list->data[i].lock, "msglock");
8010a820:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a823:	69 d0 48 03 00 00    	imul   $0x348,%eax,%edx
8010a829:	8b 45 08             	mov    0x8(%ebp),%eax
8010a82c:	01 d0                	add    %edx,%eax
8010a82e:	83 c0 08             	add    $0x8,%eax
8010a831:	83 ec 08             	sub    $0x8,%esp
8010a834:	68 86 bb 10 80       	push   $0x8010bb86
8010a839:	50                   	push   %eax
8010a83a:	e8 13 a6 ff ff       	call   80104e52 <initlock>
8010a83f:	83 c4 10             	add    $0x10,%esp

//space--insert_position
void APWndListInit(AWndList * list)
{
    int i = 0;
    for (i = 0; i < MAX_WND_NUM; ++i)
8010a842:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010a846:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010a84a:	0f 8e 6a ff ff ff    	jle    8010a7ba <APWndListInit+0x19>
        list->data[i].prev = -1;
        list->data[i].next = i + 1;
        APMsgQueueInit(&list->data[i].msgQueue);
        initlock(&list->data[i].lock, "msglock");
    }
    list->data[i - 1].next = -1;
8010a850:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a853:	83 e8 01             	sub    $0x1,%eax
8010a856:	8b 55 08             	mov    0x8(%ebp),%edx
8010a859:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a85f:	01 d0                	add    %edx,%eax
8010a861:	83 c0 04             	add    $0x4,%eax
8010a864:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    initlock(&list->lock, "wndListLock");
8010a86a:	8b 45 08             	mov    0x8(%ebp),%eax
8010a86d:	05 e0 20 00 00       	add    $0x20e0,%eax
8010a872:	83 ec 08             	sub    $0x8,%esp
8010a875:	68 8e bb 10 80       	push   $0x8010bb8e
8010a87a:	50                   	push   %eax
8010a87b:	e8 d2 a5 ff ff       	call   80104e52 <initlock>
8010a880:	83 c4 10             	add    $0x10,%esp
    list->head = list->tail  = -1;
8010a883:	8b 45 08             	mov    0x8(%ebp),%eax
8010a886:	c7 80 d4 20 00 00 ff 	movl   $0xffffffff,0x20d4(%eax)
8010a88d:	ff ff ff 
8010a890:	8b 45 08             	mov    0x8(%ebp),%eax
8010a893:	8b 90 d4 20 00 00    	mov    0x20d4(%eax),%edx
8010a899:	8b 45 08             	mov    0x8(%ebp),%eax
8010a89c:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
    list->desktop = 0;
8010a8a2:	8b 45 08             	mov    0x8(%ebp),%eax
8010a8a5:	c7 80 dc 20 00 00 00 	movl   $0x0,0x20dc(%eax)
8010a8ac:	00 00 00 
    list->space = 0;
8010a8af:	8b 45 08             	mov    0x8(%ebp),%eax
8010a8b2:	c7 80 d8 20 00 00 00 	movl   $0x0,0x20d8(%eax)
8010a8b9:	00 00 00 
}
8010a8bc:	90                   	nop
8010a8bd:	c9                   	leave  
8010a8be:	c3                   	ret    

8010a8bf <APWndListAddToHead>:

void APWndListAddToHead(AWndList * list, AHwnd hwnd)
{
8010a8bf:	55                   	push   %ebp
8010a8c0:	89 e5                	mov    %esp,%ebp
8010a8c2:	83 ec 18             	sub    $0x18,%esp
    acquire(&list->lock);
8010a8c5:	8b 45 08             	mov    0x8(%ebp),%eax
8010a8c8:	05 e0 20 00 00       	add    $0x20e0,%eax
8010a8cd:	83 ec 0c             	sub    $0xc,%esp
8010a8d0:	50                   	push   %eax
8010a8d1:	e8 9e a5 ff ff       	call   80104e74 <acquire>
8010a8d6:	83 c4 10             	add    $0x10,%esp
    int p = list->space;
8010a8d9:	8b 45 08             	mov    0x8(%ebp),%eax
8010a8dc:	8b 80 d8 20 00 00    	mov    0x20d8(%eax),%eax
8010a8e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == -1)
8010a8e5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010a8e9:	75 15                	jne    8010a900 <APWndListAddToHead+0x41>
    {
        cprintf("too much window\n");
8010a8eb:	83 ec 0c             	sub    $0xc,%esp
8010a8ee:	68 9a bb 10 80       	push   $0x8010bb9a
8010a8f3:	e8 ce 5a ff ff       	call   801003c6 <cprintf>
8010a8f8:	83 c4 10             	add    $0x10,%esp
        return;
8010a8fb:	e9 c8 00 00 00       	jmp    8010a9c8 <APWndListAddToHead+0x109>
    }
    list->space = list->data[list->space].next;
8010a900:	8b 45 08             	mov    0x8(%ebp),%eax
8010a903:	8b 80 d8 20 00 00    	mov    0x20d8(%eax),%eax
8010a909:	8b 55 08             	mov    0x8(%ebp),%edx
8010a90c:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a912:	01 d0                	add    %edx,%eax
8010a914:	83 c0 04             	add    $0x4,%eax
8010a917:	8b 10                	mov    (%eax),%edx
8010a919:	8b 45 08             	mov    0x8(%ebp),%eax
8010a91c:	89 90 d8 20 00 00    	mov    %edx,0x20d8(%eax)
    list->data[p].hwnd = hwnd;
8010a922:	8b 55 08             	mov    0x8(%ebp),%edx
8010a925:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a928:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a92e:	01 d0                	add    %edx,%eax
8010a930:	8d 90 44 03 00 00    	lea    0x344(%eax),%edx
8010a936:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a939:	89 02                	mov    %eax,(%edx)
    
    hwnd->id = p;
8010a93b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a93e:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a941:	89 10                	mov    %edx,(%eax)
    
    //desktop ---- id = 0
    list->data[p].next = list->head;
8010a943:	8b 45 08             	mov    0x8(%ebp),%eax
8010a946:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010a94c:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010a94f:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a952:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010a958:	01 ca                	add    %ecx,%edx
8010a95a:	83 c2 04             	add    $0x4,%edx
8010a95d:	89 02                	mov    %eax,(%edx)
    list->data[p].prev = -1;
8010a95f:	8b 55 08             	mov    0x8(%ebp),%edx
8010a962:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a965:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a96b:	01 d0                	add    %edx,%eax
8010a96d:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    if (list->head == -1)
8010a973:	8b 45 08             	mov    0x8(%ebp),%eax
8010a976:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010a97c:	83 f8 ff             	cmp    $0xffffffff,%eax
8010a97f:	75 0e                	jne    8010a98f <APWndListAddToHead+0xd0>
        list->tail = p;
8010a981:	8b 45 08             	mov    0x8(%ebp),%eax
8010a984:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a987:	89 90 d4 20 00 00    	mov    %edx,0x20d4(%eax)
8010a98d:	eb 19                	jmp    8010a9a8 <APWndListAddToHead+0xe9>
    else
        list->data[list->head].prev = p;
8010a98f:	8b 45 08             	mov    0x8(%ebp),%eax
8010a992:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010a998:	8b 55 08             	mov    0x8(%ebp),%edx
8010a99b:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a9a1:	01 c2                	add    %eax,%edx
8010a9a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a9a6:	89 02                	mov    %eax,(%edx)
    
    list->head = p;
8010a9a8:	8b 45 08             	mov    0x8(%ebp),%eax
8010a9ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a9ae:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
    //cprintf("the wndlist head is %d\n",p);
    release(&list->lock);
8010a9b4:	8b 45 08             	mov    0x8(%ebp),%eax
8010a9b7:	05 e0 20 00 00       	add    $0x20e0,%eax
8010a9bc:	83 ec 0c             	sub    $0xc,%esp
8010a9bf:	50                   	push   %eax
8010a9c0:	e8 16 a5 ff ff       	call   80104edb <release>
8010a9c5:	83 c4 10             	add    $0x10,%esp
}
8010a9c8:	c9                   	leave  
8010a9c9:	c3                   	ret    

8010a9ca <APWndListMoveToHead>:

void APWndListMoveToHead(AWndList * list, int wndId)
{
8010a9ca:	55                   	push   %ebp
8010a9cb:	89 e5                	mov    %esp,%ebp
8010a9cd:	83 ec 08             	sub    $0x8,%esp
    if (wndId < 0)
8010a9d0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010a9d4:	0f 88 27 01 00 00    	js     8010ab01 <APWndListMoveToHead+0x137>
        return;
    acquire(&list->lock);
8010a9da:	8b 45 08             	mov    0x8(%ebp),%eax
8010a9dd:	05 e0 20 00 00       	add    $0x20e0,%eax
8010a9e2:	83 ec 0c             	sub    $0xc,%esp
8010a9e5:	50                   	push   %eax
8010a9e6:	e8 89 a4 ff ff       	call   80104e74 <acquire>
8010a9eb:	83 c4 10             	add    $0x10,%esp
    if (wndId != list->head)
8010a9ee:	8b 45 08             	mov    0x8(%ebp),%eax
8010a9f1:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010a9f7:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010a9fa:	0f 84 eb 00 00 00    	je     8010aaeb <APWndListMoveToHead+0x121>
    {
        list->data[list->data[wndId].prev].next = list->data[wndId].next;
8010aa00:	8b 55 08             	mov    0x8(%ebp),%edx
8010aa03:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa06:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa0c:	01 d0                	add    %edx,%eax
8010aa0e:	8b 10                	mov    (%eax),%edx
8010aa10:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aa13:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa16:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa1c:	01 c8                	add    %ecx,%eax
8010aa1e:	83 c0 04             	add    $0x4,%eax
8010aa21:	8b 00                	mov    (%eax),%eax
8010aa23:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aa26:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010aa2c:	01 ca                	add    %ecx,%edx
8010aa2e:	83 c2 04             	add    $0x4,%edx
8010aa31:	89 02                	mov    %eax,(%edx)
        if (list->data[wndId].next == -1)
8010aa33:	8b 55 08             	mov    0x8(%ebp),%edx
8010aa36:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa39:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa3f:	01 d0                	add    %edx,%eax
8010aa41:	83 c0 04             	add    $0x4,%eax
8010aa44:	8b 00                	mov    (%eax),%eax
8010aa46:	83 f8 ff             	cmp    $0xffffffff,%eax
8010aa49:	75 1b                	jne    8010aa66 <APWndListMoveToHead+0x9c>
            list->tail = list->data[wndId].prev;
8010aa4b:	8b 55 08             	mov    0x8(%ebp),%edx
8010aa4e:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa51:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa57:	01 d0                	add    %edx,%eax
8010aa59:	8b 10                	mov    (%eax),%edx
8010aa5b:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa5e:	89 90 d4 20 00 00    	mov    %edx,0x20d4(%eax)
8010aa64:	eb 30                	jmp    8010aa96 <APWndListMoveToHead+0xcc>
        else
            list->data[list->data[wndId].next].prev = list->data[wndId].prev;
8010aa66:	8b 55 08             	mov    0x8(%ebp),%edx
8010aa69:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa6c:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa72:	01 d0                	add    %edx,%eax
8010aa74:	83 c0 04             	add    $0x4,%eax
8010aa77:	8b 10                	mov    (%eax),%edx
8010aa79:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aa7c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa7f:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa85:	01 c8                	add    %ecx,%eax
8010aa87:	8b 00                	mov    (%eax),%eax
8010aa89:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aa8c:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010aa92:	01 ca                	add    %ecx,%edx
8010aa94:	89 02                	mov    %eax,(%edx)

        list->data[list->head].prev = wndId;
8010aa96:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa99:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010aa9f:	8b 55 08             	mov    0x8(%ebp),%edx
8010aaa2:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aaa8:	01 c2                	add    %eax,%edx
8010aaaa:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aaad:	89 02                	mov    %eax,(%edx)
        list->data[wndId].prev = -1;
8010aaaf:	8b 55 08             	mov    0x8(%ebp),%edx
8010aab2:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aab5:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aabb:	01 d0                	add    %edx,%eax
8010aabd:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
        list->data[wndId].next = list->head;
8010aac3:	8b 45 08             	mov    0x8(%ebp),%eax
8010aac6:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010aacc:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aacf:	8b 55 0c             	mov    0xc(%ebp),%edx
8010aad2:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010aad8:	01 ca                	add    %ecx,%edx
8010aada:	83 c2 04             	add    $0x4,%edx
8010aadd:	89 02                	mov    %eax,(%edx)
        list->head = wndId;
8010aadf:	8b 45 08             	mov    0x8(%ebp),%eax
8010aae2:	8b 55 0c             	mov    0xc(%ebp),%edx
8010aae5:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
    }
    release(&list->lock);
8010aaeb:	8b 45 08             	mov    0x8(%ebp),%eax
8010aaee:	05 e0 20 00 00       	add    $0x20e0,%eax
8010aaf3:	83 ec 0c             	sub    $0xc,%esp
8010aaf6:	50                   	push   %eax
8010aaf7:	e8 df a3 ff ff       	call   80104edb <release>
8010aafc:	83 c4 10             	add    $0x10,%esp
8010aaff:	eb 01                	jmp    8010ab02 <APWndListMoveToHead+0x138>
}

void APWndListMoveToHead(AWndList * list, int wndId)
{
    if (wndId < 0)
        return;
8010ab01:	90                   	nop
        list->data[wndId].prev = -1;
        list->data[wndId].next = list->head;
        list->head = wndId;
    }
    release(&list->lock);
}
8010ab02:	c9                   	leave  
8010ab03:	c3                   	ret    

8010ab04 <APWndListRemove>:

void APWndListRemove(AWndList * list, int wndId)
{
8010ab04:	55                   	push   %ebp
8010ab05:	89 e5                	mov    %esp,%ebp
8010ab07:	83 ec 08             	sub    $0x8,%esp
    if (wndId < 0)
8010ab0a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010ab0e:	0f 88 71 01 00 00    	js     8010ac85 <APWndListRemove+0x181>
        return;
    acquire(&list->lock);
8010ab14:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab17:	05 e0 20 00 00       	add    $0x20e0,%eax
8010ab1c:	83 ec 0c             	sub    $0xc,%esp
8010ab1f:	50                   	push   %eax
8010ab20:	e8 4f a3 ff ff       	call   80104e74 <acquire>
8010ab25:	83 c4 10             	add    $0x10,%esp
    if (wndId == list->head)
8010ab28:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab2b:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010ab31:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010ab34:	75 7a                	jne    8010abb0 <APWndListRemove+0xac>
    {
        if (list->data[wndId].next == -1)
8010ab36:	8b 55 08             	mov    0x8(%ebp),%edx
8010ab39:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ab3c:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ab42:	01 d0                	add    %edx,%eax
8010ab44:	83 c0 04             	add    $0x4,%eax
8010ab47:	8b 00                	mov    (%eax),%eax
8010ab49:	83 f8 ff             	cmp    $0xffffffff,%eax
8010ab4c:	75 24                	jne    8010ab72 <APWndListRemove+0x6e>
            list->head = list->tail = -1;
8010ab4e:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab51:	c7 80 d4 20 00 00 ff 	movl   $0xffffffff,0x20d4(%eax)
8010ab58:	ff ff ff 
8010ab5b:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab5e:	8b 90 d4 20 00 00    	mov    0x20d4(%eax),%edx
8010ab64:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab67:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
8010ab6d:	e9 88 00 00 00       	jmp    8010abfa <APWndListRemove+0xf6>
        else
        {
            list->head = list->data[list->head].next;
8010ab72:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab75:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010ab7b:	8b 55 08             	mov    0x8(%ebp),%edx
8010ab7e:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ab84:	01 d0                	add    %edx,%eax
8010ab86:	83 c0 04             	add    $0x4,%eax
8010ab89:	8b 10                	mov    (%eax),%edx
8010ab8b:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab8e:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
            list->data[list->head].prev = -1;
8010ab94:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab97:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010ab9d:	8b 55 08             	mov    0x8(%ebp),%edx
8010aba0:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aba6:	01 d0                	add    %edx,%eax
8010aba8:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
8010abae:	eb 4a                	jmp    8010abfa <APWndListRemove+0xf6>
        }
    }
    else if (wndId == list->tail)
8010abb0:	8b 45 08             	mov    0x8(%ebp),%eax
8010abb3:	8b 80 d4 20 00 00    	mov    0x20d4(%eax),%eax
8010abb9:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010abbc:	75 3c                	jne    8010abfa <APWndListRemove+0xf6>
    {
        list->tail = list->data[list->tail].prev;
8010abbe:	8b 45 08             	mov    0x8(%ebp),%eax
8010abc1:	8b 80 d4 20 00 00    	mov    0x20d4(%eax),%eax
8010abc7:	8b 55 08             	mov    0x8(%ebp),%edx
8010abca:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010abd0:	01 d0                	add    %edx,%eax
8010abd2:	8b 10                	mov    (%eax),%edx
8010abd4:	8b 45 08             	mov    0x8(%ebp),%eax
8010abd7:	89 90 d4 20 00 00    	mov    %edx,0x20d4(%eax)
        list->data[list->tail].next = -1;
8010abdd:	8b 45 08             	mov    0x8(%ebp),%eax
8010abe0:	8b 80 d4 20 00 00    	mov    0x20d4(%eax),%eax
8010abe6:	8b 55 08             	mov    0x8(%ebp),%edx
8010abe9:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010abef:	01 d0                	add    %edx,%eax
8010abf1:	83 c0 04             	add    $0x4,%eax
8010abf4:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    }
    list->data[wndId].prev = -1;
8010abfa:	8b 55 08             	mov    0x8(%ebp),%edx
8010abfd:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ac00:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ac06:	01 d0                	add    %edx,%eax
8010ac08:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    list->data[wndId].next = list->space;
8010ac0e:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac11:	8b 80 d8 20 00 00    	mov    0x20d8(%eax),%eax
8010ac17:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010ac1a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010ac1d:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010ac23:	01 ca                	add    %ecx,%edx
8010ac25:	83 c2 04             	add    $0x4,%edx
8010ac28:	89 02                	mov    %eax,(%edx)
    list->data[wndId].hwnd = 0;
8010ac2a:	8b 55 08             	mov    0x8(%ebp),%edx
8010ac2d:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ac30:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ac36:	01 d0                	add    %edx,%eax
8010ac38:	05 44 03 00 00       	add    $0x344,%eax
8010ac3d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    list->space = wndId;
8010ac43:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac46:	8b 55 0c             	mov    0xc(%ebp),%edx
8010ac49:	89 90 d8 20 00 00    	mov    %edx,0x20d8(%eax)

    APMsgQueueInit(&list->data[wndId].msgQueue);
8010ac4f:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ac52:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ac58:	8d 50 30             	lea    0x30(%eax),%edx
8010ac5b:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac5e:	01 d0                	add    %edx,%eax
8010ac60:	83 c0 0c             	add    $0xc,%eax
8010ac63:	83 ec 0c             	sub    $0xc,%esp
8010ac66:	50                   	push   %eax
8010ac67:	e8 4d 00 00 00       	call   8010acb9 <APMsgQueueInit>
8010ac6c:	83 c4 10             	add    $0x10,%esp
    
    release(&list->lock);
8010ac6f:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac72:	05 e0 20 00 00       	add    $0x20e0,%eax
8010ac77:	83 ec 0c             	sub    $0xc,%esp
8010ac7a:	50                   	push   %eax
8010ac7b:	e8 5b a2 ff ff       	call   80104edb <release>
8010ac80:	83 c4 10             	add    $0x10,%esp
8010ac83:	eb 01                	jmp    8010ac86 <APWndListRemove+0x182>
}

void APWndListRemove(AWndList * list, int wndId)
{
    if (wndId < 0)
        return;
8010ac85:	90                   	nop
    list->space = wndId;

    APMsgQueueInit(&list->data[wndId].msgQueue);
    
    release(&list->lock);
}
8010ac86:	c9                   	leave  
8010ac87:	c3                   	ret    

8010ac88 <APWndListDestroy>:

void APWndListDestroy(AWndList * list)
{
8010ac88:	55                   	push   %ebp
8010ac89:	89 e5                	mov    %esp,%ebp
8010ac8b:	83 ec 08             	sub    $0x8,%esp
    acquire(&list->lock);
8010ac8e:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac91:	05 e0 20 00 00       	add    $0x20e0,%eax
8010ac96:	83 ec 0c             	sub    $0xc,%esp
8010ac99:	50                   	push   %eax
8010ac9a:	e8 d5 a1 ff ff       	call   80104e74 <acquire>
8010ac9f:	83 c4 10             	add    $0x10,%esp
    release(&list->lock);
8010aca2:	8b 45 08             	mov    0x8(%ebp),%eax
8010aca5:	05 e0 20 00 00       	add    $0x20e0,%eax
8010acaa:	83 ec 0c             	sub    $0xc,%esp
8010acad:	50                   	push   %eax
8010acae:	e8 28 a2 ff ff       	call   80104edb <release>
8010acb3:	83 c4 10             	add    $0x10,%esp
}
8010acb6:	90                   	nop
8010acb7:	c9                   	leave  
8010acb8:	c3                   	ret    

8010acb9 <APMsgQueueInit>:

//Msg Queue
//head = start, tail = end next

void APMsgQueueInit(AMsgQueue * queue)
{
8010acb9:	55                   	push   %ebp
8010acba:	89 e5                	mov    %esp,%ebp
    // as an array
    queue->head = queue->tail = 0;
8010acbc:	8b 45 08             	mov    0x8(%ebp),%eax
8010acbf:	c7 80 04 03 00 00 00 	movl   $0x0,0x304(%eax)
8010acc6:	00 00 00 
8010acc9:	8b 45 08             	mov    0x8(%ebp),%eax
8010accc:	8b 90 04 03 00 00    	mov    0x304(%eax),%edx
8010acd2:	8b 45 08             	mov    0x8(%ebp),%eax
8010acd5:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
}
8010acdb:	90                   	nop
8010acdc:	5d                   	pop    %ebp
8010acdd:	c3                   	ret    

8010acde <APMsgQueueEnQueue>:

void APMsgQueueEnQueue(AMsgQueue * queue, AMessage msg)
{
8010acde:	55                   	push   %ebp
8010acdf:	89 e5                	mov    %esp,%ebp
8010ace1:	83 ec 08             	sub    $0x8,%esp
    if ((queue->tail + 1) % MESSAGE_QUEUE_SIZE == queue->head)
8010ace4:	8b 45 08             	mov    0x8(%ebp),%eax
8010ace7:	8b 80 04 03 00 00    	mov    0x304(%eax),%eax
8010aced:	83 c0 01             	add    $0x1,%eax
8010acf0:	83 e0 3f             	and    $0x3f,%eax
8010acf3:	89 c2                	mov    %eax,%edx
8010acf5:	8b 45 08             	mov    0x8(%ebp),%eax
8010acf8:	8b 80 00 03 00 00    	mov    0x300(%eax),%eax
8010acfe:	39 c2                	cmp    %eax,%edx
8010ad00:	75 12                	jne    8010ad14 <APMsgQueueEnQueue+0x36>
    {
        cprintf("Error! Message Queue is full\n");
8010ad02:	83 ec 0c             	sub    $0xc,%esp
8010ad05:	68 ab bb 10 80       	push   $0x8010bbab
8010ad0a:	e8 b7 56 ff ff       	call   801003c6 <cprintf>
8010ad0f:	83 c4 10             	add    $0x10,%esp
        return;
8010ad12:	eb 43                	jmp    8010ad57 <APMsgQueueEnQueue+0x79>
    }
    
    switch (msg.type)
    {
        default:
            break;
8010ad14:	90                   	nop
    }
    //cprintf("MsgQueue-En-Queue:tail %d \n",queue->tail);
    queue->data[queue->tail] = msg;
8010ad15:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad18:	8b 90 04 03 00 00    	mov    0x304(%eax),%edx
8010ad1e:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010ad21:	89 d0                	mov    %edx,%eax
8010ad23:	01 c0                	add    %eax,%eax
8010ad25:	01 d0                	add    %edx,%eax
8010ad27:	c1 e0 02             	shl    $0x2,%eax
8010ad2a:	01 c8                	add    %ecx,%eax
8010ad2c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010ad2f:	89 10                	mov    %edx,(%eax)
8010ad31:	8b 55 10             	mov    0x10(%ebp),%edx
8010ad34:	89 50 04             	mov    %edx,0x4(%eax)
8010ad37:	8b 55 14             	mov    0x14(%ebp),%edx
8010ad3a:	89 50 08             	mov    %edx,0x8(%eax)
    queue->tail = (queue->tail + 1) % MESSAGE_QUEUE_SIZE;
8010ad3d:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad40:	8b 80 04 03 00 00    	mov    0x304(%eax),%eax
8010ad46:	83 c0 01             	add    $0x1,%eax
8010ad49:	83 e0 3f             	and    $0x3f,%eax
8010ad4c:	89 c2                	mov    %eax,%edx
8010ad4e:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad51:	89 90 04 03 00 00    	mov    %edx,0x304(%eax)
    //cprintf("MsgQueue-En-Queue:after add tail %d \n",queue->tail);
}
8010ad57:	c9                   	leave  
8010ad58:	c3                   	ret    

8010ad59 <APMsgQueueDeQueue>:

//弹出消息队列顶端
AMessage APMsgQueueDeQueue(AMsgQueue * queue)
{
8010ad59:	55                   	push   %ebp
8010ad5a:	89 e5                	mov    %esp,%ebp
8010ad5c:	53                   	push   %ebx
8010ad5d:	83 ec 10             	sub    $0x10,%esp
    if (queue->head == queue->tail)
8010ad60:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad63:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010ad69:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad6c:	8b 80 04 03 00 00    	mov    0x304(%eax),%eax
8010ad72:	39 c2                	cmp    %eax,%edx
8010ad74:	75 1d                	jne    8010ad93 <APMsgQueueDeQueue+0x3a>
    {
        AMessage msg;
        msg.type = MSG_NULL;
8010ad76:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        return msg;
8010ad7d:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad80:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010ad83:	89 10                	mov    %edx,(%eax)
8010ad85:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010ad88:	89 50 04             	mov    %edx,0x4(%eax)
8010ad8b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ad8e:	89 50 08             	mov    %edx,0x8(%eax)
8010ad91:	eb 4a                	jmp    8010addd <APMsgQueueDeQueue+0x84>
    }
    int p = queue->head;
8010ad93:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad96:	8b 80 00 03 00 00    	mov    0x300(%eax),%eax
8010ad9c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    queue->head = (queue->head + 1) % MESSAGE_QUEUE_SIZE;
8010ad9f:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ada2:	8b 80 00 03 00 00    	mov    0x300(%eax),%eax
8010ada8:	83 c0 01             	add    $0x1,%eax
8010adab:	83 e0 3f             	and    $0x3f,%eax
8010adae:	89 c2                	mov    %eax,%edx
8010adb0:	8b 45 0c             	mov    0xc(%ebp),%eax
8010adb3:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
    return queue->data[p];
8010adb9:	8b 55 08             	mov    0x8(%ebp),%edx
8010adbc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010adbf:	8b 4d f8             	mov    -0x8(%ebp),%ecx
8010adc2:	89 c8                	mov    %ecx,%eax
8010adc4:	01 c0                	add    %eax,%eax
8010adc6:	01 c8                	add    %ecx,%eax
8010adc8:	c1 e0 02             	shl    $0x2,%eax
8010adcb:	01 d8                	add    %ebx,%eax
8010adcd:	8b 08                	mov    (%eax),%ecx
8010adcf:	89 0a                	mov    %ecx,(%edx)
8010add1:	8b 48 04             	mov    0x4(%eax),%ecx
8010add4:	89 4a 04             	mov    %ecx,0x4(%edx)
8010add7:	8b 40 08             	mov    0x8(%eax),%eax
8010adda:	89 42 08             	mov    %eax,0x8(%edx)
}
8010addd:	8b 45 08             	mov    0x8(%ebp),%eax
8010ade0:	83 c4 10             	add    $0x10,%esp
8010ade3:	5b                   	pop    %ebx
8010ade4:	5d                   	pop    %ebp
8010ade5:	c2 04 00             	ret    $0x4

8010ade8 <TimerCount>:

//-----------------------------------------------------------------------------
//Timer
void TimerCount()
{
8010ade8:	55                   	push   %ebp
8010ade9:	89 e5                	mov    %esp,%ebp
8010adeb:	83 ec 18             	sub    $0x18,%esp
    if (!timerListReady)
8010adee:	a1 a4 e6 10 80       	mov    0x8010e6a4,%eax
8010adf3:	85 c0                	test   %eax,%eax
8010adf5:	0f 84 ea 00 00 00    	je     8010aee5 <TimerCount+0xfd>
        return;
    acquire(&timerList.lock);
8010adfb:	83 ec 0c             	sub    $0xc,%esp
8010adfe:	68 50 b4 11 80       	push   $0x8011b450
8010ae03:	e8 6c a0 ff ff       	call   80104e74 <acquire>
8010ae08:	83 c4 10             	add    $0x10,%esp
    int p = timerList.head;
8010ae0b:	a1 48 b4 11 80       	mov    0x8011b448,%eax
8010ae10:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while(p != -1)
8010ae13:	e9 b1 00 00 00       	jmp    8010aec9 <TimerCount+0xe1>
    {
        timerList.data[p].count ++;
8010ae18:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae1b:	89 d0                	mov    %edx,%eax
8010ae1d:	c1 e0 02             	shl    $0x2,%eax
8010ae20:	01 d0                	add    %edx,%eax
8010ae22:	c1 e0 02             	shl    $0x2,%eax
8010ae25:	05 8c b3 11 80       	add    $0x8011b38c,%eax
8010ae2a:	8b 00                	mov    (%eax),%eax
8010ae2c:	8d 48 01             	lea    0x1(%eax),%ecx
8010ae2f:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae32:	89 d0                	mov    %edx,%eax
8010ae34:	c1 e0 02             	shl    $0x2,%eax
8010ae37:	01 d0                	add    %edx,%eax
8010ae39:	c1 e0 02             	shl    $0x2,%eax
8010ae3c:	05 8c b3 11 80       	add    $0x8011b38c,%eax
8010ae41:	89 08                	mov    %ecx,(%eax)
        if (timerList.data[p].count >= timerList.data[p].interval)
8010ae43:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae46:	89 d0                	mov    %edx,%eax
8010ae48:	c1 e0 02             	shl    $0x2,%eax
8010ae4b:	01 d0                	add    %edx,%eax
8010ae4d:	c1 e0 02             	shl    $0x2,%eax
8010ae50:	05 8c b3 11 80       	add    $0x8011b38c,%eax
8010ae55:	8b 08                	mov    (%eax),%ecx
8010ae57:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae5a:	89 d0                	mov    %edx,%eax
8010ae5c:	c1 e0 02             	shl    $0x2,%eax
8010ae5f:	01 d0                	add    %edx,%eax
8010ae61:	c1 e0 02             	shl    $0x2,%eax
8010ae64:	05 88 b3 11 80       	add    $0x8011b388,%eax
8010ae69:	8b 00                	mov    (%eax),%eax
8010ae6b:	39 c1                	cmp    %eax,%ecx
8010ae6d:	7c 43                	jl     8010aeb2 <TimerCount+0xca>
        {
            timerList.data[p].count = 0;
8010ae6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae72:	89 d0                	mov    %edx,%eax
8010ae74:	c1 e0 02             	shl    $0x2,%eax
8010ae77:	01 d0                	add    %edx,%eax
8010ae79:	c1 e0 02             	shl    $0x2,%eax
8010ae7c:	05 8c b3 11 80       	add    $0x8011b38c,%eax
8010ae81:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
            AMessage msg;
            msg.type = MSG_TIMEOUT;
8010ae87:	c7 45 e8 04 00 00 00 	movl   $0x4,-0x18(%ebp)
            sendMessage(timerList.data[p].wndId,&msg);
8010ae8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae91:	89 d0                	mov    %edx,%eax
8010ae93:	c1 e0 02             	shl    $0x2,%eax
8010ae96:	01 d0                	add    %edx,%eax
8010ae98:	c1 e0 02             	shl    $0x2,%eax
8010ae9b:	05 80 b3 11 80       	add    $0x8011b380,%eax
8010aea0:	8b 00                	mov    (%eax),%eax
8010aea2:	83 ec 08             	sub    $0x8,%esp
8010aea5:	8d 55 e8             	lea    -0x18(%ebp),%edx
8010aea8:	52                   	push   %edx
8010aea9:	50                   	push   %eax
8010aeaa:	e8 43 f8 ff ff       	call   8010a6f2 <sendMessage>
8010aeaf:	83 c4 10             	add    $0x10,%esp
        }
        p = timerList.data[p].next;
8010aeb2:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010aeb5:	89 d0                	mov    %edx,%eax
8010aeb7:	c1 e0 02             	shl    $0x2,%eax
8010aeba:	01 d0                	add    %edx,%eax
8010aebc:	c1 e0 02             	shl    $0x2,%eax
8010aebf:	05 90 b3 11 80       	add    $0x8011b390,%eax
8010aec4:	8b 00                	mov    (%eax),%eax
8010aec6:	89 45 f4             	mov    %eax,-0xc(%ebp)
{
    if (!timerListReady)
        return;
    acquire(&timerList.lock);
    int p = timerList.head;
    while(p != -1)
8010aec9:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010aecd:	0f 85 45 ff ff ff    	jne    8010ae18 <TimerCount+0x30>
            msg.type = MSG_TIMEOUT;
            sendMessage(timerList.data[p].wndId,&msg);
        }
        p = timerList.data[p].next;
    }
    release(&timerList.lock);
8010aed3:	83 ec 0c             	sub    $0xc,%esp
8010aed6:	68 50 b4 11 80       	push   $0x8011b450
8010aedb:	e8 fb 9f ff ff       	call   80104edb <release>
8010aee0:	83 c4 10             	add    $0x10,%esp
8010aee3:	eb 01                	jmp    8010aee6 <TimerCount+0xfe>
//-----------------------------------------------------------------------------
//Timer
void TimerCount()
{
    if (!timerListReady)
        return;
8010aee5:	90                   	nop
            sendMessage(timerList.data[p].wndId,&msg);
        }
        p = timerList.data[p].next;
    }
    release(&timerList.lock);
}
8010aee6:	c9                   	leave  
8010aee7:	c3                   	ret    

8010aee8 <APTimerListInit>:


void APTimerListInit(ATimerList * list)
{
8010aee8:	55                   	push   %ebp
8010aee9:	89 e5                	mov    %esp,%ebp
8010aeeb:	53                   	push   %ebx
8010aeec:	83 ec 14             	sub    $0x14,%esp
    int i;
    for (i = 0; i < MAX_TIMER_NUM; i++)
8010aeef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010aef6:	eb 21                	jmp    8010af19 <APTimerListInit+0x31>
        list->data[i].next = i + 1;
8010aef8:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010aefb:	8d 48 01             	lea    0x1(%eax),%ecx
8010aefe:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010af01:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010af04:	89 d0                	mov    %edx,%eax
8010af06:	c1 e0 02             	shl    $0x2,%eax
8010af09:	01 d0                	add    %edx,%eax
8010af0b:	c1 e0 02             	shl    $0x2,%eax
8010af0e:	01 d8                	add    %ebx,%eax
8010af10:	83 c0 10             	add    $0x10,%eax
8010af13:	89 08                	mov    %ecx,(%eax)


void APTimerListInit(ATimerList * list)
{
    int i;
    for (i = 0; i < MAX_TIMER_NUM; i++)
8010af15:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010af19:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010af1d:	7e d9                	jle    8010aef8 <APTimerListInit+0x10>
        list->data[i].next = i + 1;
    list->head = -1;
8010af1f:	8b 45 08             	mov    0x8(%ebp),%eax
8010af22:	c7 80 c8 00 00 00 ff 	movl   $0xffffffff,0xc8(%eax)
8010af29:	ff ff ff 
    list->space = 0;
8010af2c:	8b 45 08             	mov    0x8(%ebp),%eax
8010af2f:	c7 80 cc 00 00 00 00 	movl   $0x0,0xcc(%eax)
8010af36:	00 00 00 
    list->data[i].next = -1;
8010af39:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010af3c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010af3f:	89 d0                	mov    %edx,%eax
8010af41:	c1 e0 02             	shl    $0x2,%eax
8010af44:	01 d0                	add    %edx,%eax
8010af46:	c1 e0 02             	shl    $0x2,%eax
8010af49:	01 c8                	add    %ecx,%eax
8010af4b:	83 c0 10             	add    $0x10,%eax
8010af4e:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    initlock(&list->lock, "timerLock");
8010af54:	8b 45 08             	mov    0x8(%ebp),%eax
8010af57:	05 d0 00 00 00       	add    $0xd0,%eax
8010af5c:	83 ec 08             	sub    $0x8,%esp
8010af5f:	68 c9 bb 10 80       	push   $0x8010bbc9
8010af64:	50                   	push   %eax
8010af65:	e8 e8 9e ff ff       	call   80104e52 <initlock>
8010af6a:	83 c4 10             	add    $0x10,%esp
    timerListReady = 1;
8010af6d:	c7 05 a4 e6 10 80 01 	movl   $0x1,0x8010e6a4
8010af74:	00 00 00 
}
8010af77:	90                   	nop
8010af78:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010af7b:	c9                   	leave  
8010af7c:	c3                   	ret    

8010af7d <APTimerListAddToHead>:

void APTimerListAddToHead(ATimerList * list, int wndId, int id, int interval)
{
8010af7d:	55                   	push   %ebp
8010af7e:	89 e5                	mov    %esp,%ebp
8010af80:	53                   	push   %ebx
8010af81:	83 ec 14             	sub    $0x14,%esp
    acquire(&list->lock);
8010af84:	8b 45 08             	mov    0x8(%ebp),%eax
8010af87:	05 d0 00 00 00       	add    $0xd0,%eax
8010af8c:	83 ec 0c             	sub    $0xc,%esp
8010af8f:	50                   	push   %eax
8010af90:	e8 df 9e ff ff       	call   80104e74 <acquire>
8010af95:	83 c4 10             	add    $0x10,%esp
    int p = list->space;
8010af98:	8b 45 08             	mov    0x8(%ebp),%eax
8010af9b:	8b 80 cc 00 00 00    	mov    0xcc(%eax),%eax
8010afa1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == -1)
8010afa4:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010afa8:	75 15                	jne    8010afbf <APTimerListAddToHead+0x42>
    {
        cprintf("Error! Too much Timer!\n");
8010afaa:	83 ec 0c             	sub    $0xc,%esp
8010afad:	68 d3 bb 10 80       	push   $0x8010bbd3
8010afb2:	e8 0f 54 ff ff       	call   801003c6 <cprintf>
8010afb7:	83 c4 10             	add    $0x10,%esp
        return;
8010afba:	e9 c7 00 00 00       	jmp    8010b086 <APTimerListAddToHead+0x109>
    }
    list->space = list->data[p].next;
8010afbf:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010afc2:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010afc5:	89 d0                	mov    %edx,%eax
8010afc7:	c1 e0 02             	shl    $0x2,%eax
8010afca:	01 d0                	add    %edx,%eax
8010afcc:	c1 e0 02             	shl    $0x2,%eax
8010afcf:	01 c8                	add    %ecx,%eax
8010afd1:	83 c0 10             	add    $0x10,%eax
8010afd4:	8b 10                	mov    (%eax),%edx
8010afd6:	8b 45 08             	mov    0x8(%ebp),%eax
8010afd9:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
    list->data[p].next = list->head;
8010afdf:	8b 45 08             	mov    0x8(%ebp),%eax
8010afe2:	8b 88 c8 00 00 00    	mov    0xc8(%eax),%ecx
8010afe8:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010afeb:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010afee:	89 d0                	mov    %edx,%eax
8010aff0:	c1 e0 02             	shl    $0x2,%eax
8010aff3:	01 d0                	add    %edx,%eax
8010aff5:	c1 e0 02             	shl    $0x2,%eax
8010aff8:	01 d8                	add    %ebx,%eax
8010affa:	83 c0 10             	add    $0x10,%eax
8010affd:	89 08                	mov    %ecx,(%eax)
    list->head = p;
8010afff:	8b 45 08             	mov    0x8(%ebp),%eax
8010b002:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b005:	89 90 c8 00 00 00    	mov    %edx,0xc8(%eax)
    list->data[p].wndId = wndId;
8010b00b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b00e:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b011:	89 d0                	mov    %edx,%eax
8010b013:	c1 e0 02             	shl    $0x2,%eax
8010b016:	01 d0                	add    %edx,%eax
8010b018:	c1 e0 02             	shl    $0x2,%eax
8010b01b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
8010b01e:	8b 45 0c             	mov    0xc(%ebp),%eax
8010b021:	89 02                	mov    %eax,(%edx)
    list->data[p].id = id;
8010b023:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b026:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b029:	89 d0                	mov    %edx,%eax
8010b02b:	c1 e0 02             	shl    $0x2,%eax
8010b02e:	01 d0                	add    %edx,%eax
8010b030:	c1 e0 02             	shl    $0x2,%eax
8010b033:	01 c8                	add    %ecx,%eax
8010b035:	8d 50 04             	lea    0x4(%eax),%edx
8010b038:	8b 45 10             	mov    0x10(%ebp),%eax
8010b03b:	89 02                	mov    %eax,(%edx)
    list->data[p].interval = interval;
8010b03d:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b040:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b043:	89 d0                	mov    %edx,%eax
8010b045:	c1 e0 02             	shl    $0x2,%eax
8010b048:	01 d0                	add    %edx,%eax
8010b04a:	c1 e0 02             	shl    $0x2,%eax
8010b04d:	01 c8                	add    %ecx,%eax
8010b04f:	8d 50 08             	lea    0x8(%eax),%edx
8010b052:	8b 45 14             	mov    0x14(%ebp),%eax
8010b055:	89 02                	mov    %eax,(%edx)
    list->data[p].count = 0;
8010b057:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b05a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b05d:	89 d0                	mov    %edx,%eax
8010b05f:	c1 e0 02             	shl    $0x2,%eax
8010b062:	01 d0                	add    %edx,%eax
8010b064:	c1 e0 02             	shl    $0x2,%eax
8010b067:	01 c8                	add    %ecx,%eax
8010b069:	83 c0 0c             	add    $0xc,%eax
8010b06c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    release(&list->lock);
8010b072:	8b 45 08             	mov    0x8(%ebp),%eax
8010b075:	05 d0 00 00 00       	add    $0xd0,%eax
8010b07a:	83 ec 0c             	sub    $0xc,%esp
8010b07d:	50                   	push   %eax
8010b07e:	e8 58 9e ff ff       	call   80104edb <release>
8010b083:	83 c4 10             	add    $0x10,%esp
    
}
8010b086:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010b089:	c9                   	leave  
8010b08a:	c3                   	ret    

8010b08b <APTimerListRemoveWnd>:

void APTimerListRemoveWnd(ATimerList * list, int wndId)
{
8010b08b:	55                   	push   %ebp
8010b08c:	89 e5                	mov    %esp,%ebp
8010b08e:	53                   	push   %ebx
8010b08f:	83 ec 14             	sub    $0x14,%esp
    acquire(&list->lock);
8010b092:	8b 45 08             	mov    0x8(%ebp),%eax
8010b095:	05 d0 00 00 00       	add    $0xd0,%eax
8010b09a:	83 ec 0c             	sub    $0xc,%esp
8010b09d:	50                   	push   %eax
8010b09e:	e8 d1 9d ff ff       	call   80104e74 <acquire>
8010b0a3:	83 c4 10             	add    $0x10,%esp
    int p = list->head;
8010b0a6:	8b 45 08             	mov    0x8(%ebp),%eax
8010b0a9:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b0af:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int q = p;
8010b0b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b0b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (p != -1)
8010b0b8:	e9 24 01 00 00       	jmp    8010b1e1 <APTimerListRemoveWnd+0x156>
    {
        if (list->data[p].wndId == wndId)
8010b0bd:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b0c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b0c3:	89 d0                	mov    %edx,%eax
8010b0c5:	c1 e0 02             	shl    $0x2,%eax
8010b0c8:	01 d0                	add    %edx,%eax
8010b0ca:	c1 e0 02             	shl    $0x2,%eax
8010b0cd:	01 c8                	add    %ecx,%eax
8010b0cf:	8b 00                	mov    (%eax),%eax
8010b0d1:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010b0d4:	0f 85 e7 00 00 00    	jne    8010b1c1 <APTimerListRemoveWnd+0x136>
        {
            if (p == list->head)
8010b0da:	8b 45 08             	mov    0x8(%ebp),%eax
8010b0dd:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b0e3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010b0e6:	75 63                	jne    8010b14b <APTimerListRemoveWnd+0xc0>
            {
                list->head = list->data[p].next;
8010b0e8:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b0eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b0ee:	89 d0                	mov    %edx,%eax
8010b0f0:	c1 e0 02             	shl    $0x2,%eax
8010b0f3:	01 d0                	add    %edx,%eax
8010b0f5:	c1 e0 02             	shl    $0x2,%eax
8010b0f8:	01 c8                	add    %ecx,%eax
8010b0fa:	83 c0 10             	add    $0x10,%eax
8010b0fd:	8b 10                	mov    (%eax),%edx
8010b0ff:	8b 45 08             	mov    0x8(%ebp),%eax
8010b102:	89 90 c8 00 00 00    	mov    %edx,0xc8(%eax)
                list->data[p].next = list->space;
8010b108:	8b 45 08             	mov    0x8(%ebp),%eax
8010b10b:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b111:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b114:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b117:	89 d0                	mov    %edx,%eax
8010b119:	c1 e0 02             	shl    $0x2,%eax
8010b11c:	01 d0                	add    %edx,%eax
8010b11e:	c1 e0 02             	shl    $0x2,%eax
8010b121:	01 d8                	add    %ebx,%eax
8010b123:	83 c0 10             	add    $0x10,%eax
8010b126:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b128:	8b 45 08             	mov    0x8(%ebp),%eax
8010b12b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b12e:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->head;
8010b134:	8b 45 08             	mov    0x8(%ebp),%eax
8010b137:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b13d:	89 45 f4             	mov    %eax,-0xc(%ebp)
                q = p;
8010b140:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b143:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010b146:	e9 96 00 00 00       	jmp    8010b1e1 <APTimerListRemoveWnd+0x156>
            }
            else
            {
                list->data[q].next = list->data[p].next;
8010b14b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b14e:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b151:	89 d0                	mov    %edx,%eax
8010b153:	c1 e0 02             	shl    $0x2,%eax
8010b156:	01 d0                	add    %edx,%eax
8010b158:	c1 e0 02             	shl    $0x2,%eax
8010b15b:	01 c8                	add    %ecx,%eax
8010b15d:	83 c0 10             	add    $0x10,%eax
8010b160:	8b 08                	mov    (%eax),%ecx
8010b162:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b165:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b168:	89 d0                	mov    %edx,%eax
8010b16a:	c1 e0 02             	shl    $0x2,%eax
8010b16d:	01 d0                	add    %edx,%eax
8010b16f:	c1 e0 02             	shl    $0x2,%eax
8010b172:	01 d8                	add    %ebx,%eax
8010b174:	83 c0 10             	add    $0x10,%eax
8010b177:	89 08                	mov    %ecx,(%eax)
                list->data[p].next = list->space;
8010b179:	8b 45 08             	mov    0x8(%ebp),%eax
8010b17c:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b182:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b185:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b188:	89 d0                	mov    %edx,%eax
8010b18a:	c1 e0 02             	shl    $0x2,%eax
8010b18d:	01 d0                	add    %edx,%eax
8010b18f:	c1 e0 02             	shl    $0x2,%eax
8010b192:	01 d8                	add    %ebx,%eax
8010b194:	83 c0 10             	add    $0x10,%eax
8010b197:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b199:	8b 45 08             	mov    0x8(%ebp),%eax
8010b19c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b19f:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->data[q].next;
8010b1a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b1a8:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b1ab:	89 d0                	mov    %edx,%eax
8010b1ad:	c1 e0 02             	shl    $0x2,%eax
8010b1b0:	01 d0                	add    %edx,%eax
8010b1b2:	c1 e0 02             	shl    $0x2,%eax
8010b1b5:	01 c8                	add    %ecx,%eax
8010b1b7:	83 c0 10             	add    $0x10,%eax
8010b1ba:	8b 00                	mov    (%eax),%eax
8010b1bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010b1bf:	eb 20                	jmp    8010b1e1 <APTimerListRemoveWnd+0x156>
            }
        }
        else
        {
            q = p;
8010b1c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b1c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
            p = list->data[p].next;
8010b1c7:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b1ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b1cd:	89 d0                	mov    %edx,%eax
8010b1cf:	c1 e0 02             	shl    $0x2,%eax
8010b1d2:	01 d0                	add    %edx,%eax
8010b1d4:	c1 e0 02             	shl    $0x2,%eax
8010b1d7:	01 c8                	add    %ecx,%eax
8010b1d9:	83 c0 10             	add    $0x10,%eax
8010b1dc:	8b 00                	mov    (%eax),%eax
8010b1de:	89 45 f4             	mov    %eax,-0xc(%ebp)
void APTimerListRemoveWnd(ATimerList * list, int wndId)
{
    acquire(&list->lock);
    int p = list->head;
    int q = p;
    while (p != -1)
8010b1e1:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010b1e5:	0f 85 d2 fe ff ff    	jne    8010b0bd <APTimerListRemoveWnd+0x32>
        {
            q = p;
            p = list->data[p].next;
        }
    }
    release(&list->lock);
8010b1eb:	8b 45 08             	mov    0x8(%ebp),%eax
8010b1ee:	05 d0 00 00 00       	add    $0xd0,%eax
8010b1f3:	83 ec 0c             	sub    $0xc,%esp
8010b1f6:	50                   	push   %eax
8010b1f7:	e8 df 9c ff ff       	call   80104edb <release>
8010b1fc:	83 c4 10             	add    $0x10,%esp
}
8010b1ff:	90                   	nop
8010b200:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010b203:	c9                   	leave  
8010b204:	c3                   	ret    

8010b205 <APTimerListRemoveID>:

void APTimerListRemoveID(ATimerList * list, int wndId, int id)
{
8010b205:	55                   	push   %ebp
8010b206:	89 e5                	mov    %esp,%ebp
8010b208:	53                   	push   %ebx
8010b209:	83 ec 14             	sub    $0x14,%esp
    acquire(&list->lock);
8010b20c:	8b 45 08             	mov    0x8(%ebp),%eax
8010b20f:	05 d0 00 00 00       	add    $0xd0,%eax
8010b214:	83 ec 0c             	sub    $0xc,%esp
8010b217:	50                   	push   %eax
8010b218:	e8 57 9c ff ff       	call   80104e74 <acquire>
8010b21d:	83 c4 10             	add    $0x10,%esp
    int p = list->head;
8010b220:	8b 45 08             	mov    0x8(%ebp),%eax
8010b223:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b229:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int q = p;
8010b22c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b22f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (p != -1)
8010b232:	e9 44 01 00 00       	jmp    8010b37b <APTimerListRemoveID+0x176>
    {
        if (list->data[p].wndId == wndId && list->data[p].id == id)
8010b237:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b23a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b23d:	89 d0                	mov    %edx,%eax
8010b23f:	c1 e0 02             	shl    $0x2,%eax
8010b242:	01 d0                	add    %edx,%eax
8010b244:	c1 e0 02             	shl    $0x2,%eax
8010b247:	01 c8                	add    %ecx,%eax
8010b249:	8b 00                	mov    (%eax),%eax
8010b24b:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010b24e:	0f 85 07 01 00 00    	jne    8010b35b <APTimerListRemoveID+0x156>
8010b254:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b257:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b25a:	89 d0                	mov    %edx,%eax
8010b25c:	c1 e0 02             	shl    $0x2,%eax
8010b25f:	01 d0                	add    %edx,%eax
8010b261:	c1 e0 02             	shl    $0x2,%eax
8010b264:	01 c8                	add    %ecx,%eax
8010b266:	83 c0 04             	add    $0x4,%eax
8010b269:	8b 00                	mov    (%eax),%eax
8010b26b:	3b 45 10             	cmp    0x10(%ebp),%eax
8010b26e:	0f 85 e7 00 00 00    	jne    8010b35b <APTimerListRemoveID+0x156>
        {
            if (p == list->head)
8010b274:	8b 45 08             	mov    0x8(%ebp),%eax
8010b277:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b27d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010b280:	75 63                	jne    8010b2e5 <APTimerListRemoveID+0xe0>
            {
                list->head = list->data[p].next;
8010b282:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b285:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b288:	89 d0                	mov    %edx,%eax
8010b28a:	c1 e0 02             	shl    $0x2,%eax
8010b28d:	01 d0                	add    %edx,%eax
8010b28f:	c1 e0 02             	shl    $0x2,%eax
8010b292:	01 c8                	add    %ecx,%eax
8010b294:	83 c0 10             	add    $0x10,%eax
8010b297:	8b 10                	mov    (%eax),%edx
8010b299:	8b 45 08             	mov    0x8(%ebp),%eax
8010b29c:	89 90 c8 00 00 00    	mov    %edx,0xc8(%eax)
                list->data[p].next = list->space;
8010b2a2:	8b 45 08             	mov    0x8(%ebp),%eax
8010b2a5:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b2ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b2ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b2b1:	89 d0                	mov    %edx,%eax
8010b2b3:	c1 e0 02             	shl    $0x2,%eax
8010b2b6:	01 d0                	add    %edx,%eax
8010b2b8:	c1 e0 02             	shl    $0x2,%eax
8010b2bb:	01 d8                	add    %ebx,%eax
8010b2bd:	83 c0 10             	add    $0x10,%eax
8010b2c0:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b2c2:	8b 45 08             	mov    0x8(%ebp),%eax
8010b2c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b2c8:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->head;
8010b2ce:	8b 45 08             	mov    0x8(%ebp),%eax
8010b2d1:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b2d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
                q = p;
8010b2da:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b2dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010b2e0:	e9 96 00 00 00       	jmp    8010b37b <APTimerListRemoveID+0x176>
            }
            else
            {
                list->data[q].next = list->data[p].next;
8010b2e5:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b2e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b2eb:	89 d0                	mov    %edx,%eax
8010b2ed:	c1 e0 02             	shl    $0x2,%eax
8010b2f0:	01 d0                	add    %edx,%eax
8010b2f2:	c1 e0 02             	shl    $0x2,%eax
8010b2f5:	01 c8                	add    %ecx,%eax
8010b2f7:	83 c0 10             	add    $0x10,%eax
8010b2fa:	8b 08                	mov    (%eax),%ecx
8010b2fc:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b2ff:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b302:	89 d0                	mov    %edx,%eax
8010b304:	c1 e0 02             	shl    $0x2,%eax
8010b307:	01 d0                	add    %edx,%eax
8010b309:	c1 e0 02             	shl    $0x2,%eax
8010b30c:	01 d8                	add    %ebx,%eax
8010b30e:	83 c0 10             	add    $0x10,%eax
8010b311:	89 08                	mov    %ecx,(%eax)
                list->data[p].next = list->space;
8010b313:	8b 45 08             	mov    0x8(%ebp),%eax
8010b316:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b31c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b31f:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b322:	89 d0                	mov    %edx,%eax
8010b324:	c1 e0 02             	shl    $0x2,%eax
8010b327:	01 d0                	add    %edx,%eax
8010b329:	c1 e0 02             	shl    $0x2,%eax
8010b32c:	01 d8                	add    %ebx,%eax
8010b32e:	83 c0 10             	add    $0x10,%eax
8010b331:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b333:	8b 45 08             	mov    0x8(%ebp),%eax
8010b336:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b339:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->data[q].next;
8010b33f:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b342:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b345:	89 d0                	mov    %edx,%eax
8010b347:	c1 e0 02             	shl    $0x2,%eax
8010b34a:	01 d0                	add    %edx,%eax
8010b34c:	c1 e0 02             	shl    $0x2,%eax
8010b34f:	01 c8                	add    %ecx,%eax
8010b351:	83 c0 10             	add    $0x10,%eax
8010b354:	8b 00                	mov    (%eax),%eax
8010b356:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int q = p;
    while (p != -1)
    {
        if (list->data[p].wndId == wndId && list->data[p].id == id)
        {
            if (p == list->head)
8010b359:	eb 20                	jmp    8010b37b <APTimerListRemoveID+0x176>
                p = list->data[q].next;
            }
        }
        else
        {
            q = p;
8010b35b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b35e:	89 45 f0             	mov    %eax,-0x10(%ebp)
            p = list->data[p].next;
8010b361:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b364:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b367:	89 d0                	mov    %edx,%eax
8010b369:	c1 e0 02             	shl    $0x2,%eax
8010b36c:	01 d0                	add    %edx,%eax
8010b36e:	c1 e0 02             	shl    $0x2,%eax
8010b371:	01 c8                	add    %ecx,%eax
8010b373:	83 c0 10             	add    $0x10,%eax
8010b376:	8b 00                	mov    (%eax),%eax
8010b378:	89 45 f4             	mov    %eax,-0xc(%ebp)
void APTimerListRemoveID(ATimerList * list, int wndId, int id)
{
    acquire(&list->lock);
    int p = list->head;
    int q = p;
    while (p != -1)
8010b37b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010b37f:	0f 85 b2 fe ff ff    	jne    8010b237 <APTimerListRemoveID+0x32>
        {
            q = p;
            p = list->data[p].next;
        }
    }
    release(&list->lock);
8010b385:	8b 45 08             	mov    0x8(%ebp),%eax
8010b388:	05 d0 00 00 00       	add    $0xd0,%eax
8010b38d:	83 ec 0c             	sub    $0xc,%esp
8010b390:	50                   	push   %eax
8010b391:	e8 45 9b ff ff       	call   80104edb <release>
8010b396:	83 c4 10             	add    $0x10,%esp
}
8010b399:	90                   	nop
8010b39a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010b39d:	c9                   	leave  
8010b39e:	c3                   	ret    

8010b39f <sys_setupTimer>:

void sys_setupTimer(void)
{
8010b39f:	55                   	push   %ebp
8010b3a0:	89 e5                	mov    %esp,%ebp
8010b3a2:	83 ec 18             	sub    $0x18,%esp
    AHwnd hwnd;
    int id,interval;
    if (argstr(0, (char **)&hwnd) < 0 || argint(1, &id) < 0 || argint(2, &interval) < 0)
8010b3a5:	83 ec 08             	sub    $0x8,%esp
8010b3a8:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010b3ab:	50                   	push   %eax
8010b3ac:	6a 00                	push   $0x0
8010b3ae:	e8 ce a0 ff ff       	call   80105481 <argstr>
8010b3b3:	83 c4 10             	add    $0x10,%esp
8010b3b6:	85 c0                	test   %eax,%eax
8010b3b8:	78 5c                	js     8010b416 <sys_setupTimer+0x77>
8010b3ba:	83 ec 08             	sub    $0x8,%esp
8010b3bd:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010b3c0:	50                   	push   %eax
8010b3c1:	6a 01                	push   $0x1
8010b3c3:	e8 34 a0 ff ff       	call   801053fc <argint>
8010b3c8:	83 c4 10             	add    $0x10,%esp
8010b3cb:	85 c0                	test   %eax,%eax
8010b3cd:	78 47                	js     8010b416 <sys_setupTimer+0x77>
8010b3cf:	83 ec 08             	sub    $0x8,%esp
8010b3d2:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010b3d5:	50                   	push   %eax
8010b3d6:	6a 02                	push   $0x2
8010b3d8:	e8 1f a0 ff ff       	call   801053fc <argint>
8010b3dd:	83 c4 10             	add    $0x10,%esp
8010b3e0:	85 c0                	test   %eax,%eax
8010b3e2:	78 32                	js     8010b416 <sys_setupTimer+0x77>
        return ;
    APTimerListAddToHead(&timerList,hwnd->id,id,interval/10);
8010b3e4:	8b 4d ec             	mov    -0x14(%ebp),%ecx
8010b3e7:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010b3ec:	89 c8                	mov    %ecx,%eax
8010b3ee:	f7 ea                	imul   %edx
8010b3f0:	c1 fa 02             	sar    $0x2,%edx
8010b3f3:	89 c8                	mov    %ecx,%eax
8010b3f5:	c1 f8 1f             	sar    $0x1f,%eax
8010b3f8:	89 d1                	mov    %edx,%ecx
8010b3fa:	29 c1                	sub    %eax,%ecx
8010b3fc:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b3ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b402:	8b 00                	mov    (%eax),%eax
8010b404:	51                   	push   %ecx
8010b405:	52                   	push   %edx
8010b406:	50                   	push   %eax
8010b407:	68 80 b3 11 80       	push   $0x8011b380
8010b40c:	e8 6c fb ff ff       	call   8010af7d <APTimerListAddToHead>
8010b411:	83 c4 10             	add    $0x10,%esp
8010b414:	eb 01                	jmp    8010b417 <sys_setupTimer+0x78>
void sys_setupTimer(void)
{
    AHwnd hwnd;
    int id,interval;
    if (argstr(0, (char **)&hwnd) < 0 || argint(1, &id) < 0 || argint(2, &interval) < 0)
        return ;
8010b416:	90                   	nop
    APTimerListAddToHead(&timerList,hwnd->id,id,interval/10);
}
8010b417:	c9                   	leave  
8010b418:	c3                   	ret    

8010b419 <sys_deleteTimer>:
void sys_deleteTimer(void)
{
8010b419:	55                   	push   %ebp
8010b41a:	89 e5                	mov    %esp,%ebp
8010b41c:	83 ec 18             	sub    $0x18,%esp
    AHwnd hwnd;
    int id;
    if (argstr(0, (char **)&hwnd) < 0 || argint(1, &id) < 0)
8010b41f:	83 ec 08             	sub    $0x8,%esp
8010b422:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010b425:	50                   	push   %eax
8010b426:	6a 00                	push   $0x0
8010b428:	e8 54 a0 ff ff       	call   80105481 <argstr>
8010b42d:	83 c4 10             	add    $0x10,%esp
8010b430:	85 c0                	test   %eax,%eax
8010b432:	78 31                	js     8010b465 <sys_deleteTimer+0x4c>
8010b434:	83 ec 08             	sub    $0x8,%esp
8010b437:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010b43a:	50                   	push   %eax
8010b43b:	6a 01                	push   $0x1
8010b43d:	e8 ba 9f ff ff       	call   801053fc <argint>
8010b442:	83 c4 10             	add    $0x10,%esp
8010b445:	85 c0                	test   %eax,%eax
8010b447:	78 1c                	js     8010b465 <sys_deleteTimer+0x4c>
        return ;
    APTimerListRemoveID(&timerList,hwnd->id,id);
8010b449:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b44c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b44f:	8b 00                	mov    (%eax),%eax
8010b451:	83 ec 04             	sub    $0x4,%esp
8010b454:	52                   	push   %edx
8010b455:	50                   	push   %eax
8010b456:	68 80 b3 11 80       	push   $0x8011b380
8010b45b:	e8 a5 fd ff ff       	call   8010b205 <APTimerListRemoveID>
8010b460:	83 c4 10             	add    $0x10,%esp
8010b463:	eb 01                	jmp    8010b466 <sys_deleteTimer+0x4d>
void sys_deleteTimer(void)
{
    AHwnd hwnd;
    int id;
    if (argstr(0, (char **)&hwnd) < 0 || argint(1, &id) < 0)
        return ;
8010b465:	90                   	nop
    APTimerListRemoveID(&timerList,hwnd->id,id);
}
8010b466:	c9                   	leave  
8010b467:	c3                   	ret    
