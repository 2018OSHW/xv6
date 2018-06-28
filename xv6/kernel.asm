
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
80100028:	bc 90 f6 10 80       	mov    $0x8010f690,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 35 37 10 80       	mov    $0x80103735,%eax
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
8010003d:	68 98 b4 10 80       	push   $0x8010b498
80100042:	68 a0 f6 10 80       	push   $0x8010f6a0
80100047:	e8 02 4e 00 00       	call   80104e4e <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 d0 0b 11 80 c4 	movl   $0x80110bc4,0x80110bd0
80100056:	0b 11 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 d4 0b 11 80 c4 	movl   $0x80110bc4,0x80110bd4
80100060:	0b 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100063:	c7 45 f4 d4 f6 10 80 	movl   $0x8010f6d4,-0xc(%ebp)
8010006a:	eb 3a                	jmp    801000a6 <binit+0x72>
    b->next = bcache.head.next;
8010006c:	8b 15 d4 0b 11 80    	mov    0x80110bd4,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 0c c4 0b 11 80 	movl   $0x80110bc4,0xc(%eax)
    b->dev = -1;
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008c:	a1 d4 0b 11 80       	mov    0x80110bd4,%eax
80100091:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100094:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100097:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010009a:	a3 d4 0b 11 80       	mov    %eax,0x80110bd4

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009f:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a6:	b8 c4 0b 11 80       	mov    $0x80110bc4,%eax
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
801000bc:	68 a0 f6 10 80       	push   $0x8010f6a0
801000c1:	e8 aa 4d 00 00       	call   80104e70 <acquire>
801000c6:	83 c4 10             	add    $0x10,%esp

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c9:	a1 d4 0b 11 80       	mov    0x80110bd4,%eax
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
80100107:	68 a0 f6 10 80       	push   $0x8010f6a0
8010010c:	e8 c6 4d 00 00       	call   80104ed7 <release>
80100111:	83 c4 10             	add    $0x10,%esp
        return b;
80100114:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100117:	e9 98 00 00 00       	jmp    801001b4 <bget+0x101>
      }
      sleep(b, &bcache.lock);
8010011c:	83 ec 08             	sub    $0x8,%esp
8010011f:	68 a0 f6 10 80       	push   $0x8010f6a0
80100124:	ff 75 f4             	pushl  -0xc(%ebp)
80100127:	e8 4b 4a 00 00       	call   80104b77 <sleep>
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
8010013a:	81 7d f4 c4 0b 11 80 	cmpl   $0x80110bc4,-0xc(%ebp)
80100141:	75 90                	jne    801000d3 <bget+0x20>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100143:	a1 d0 0b 11 80       	mov    0x80110bd0,%eax
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
80100183:	68 a0 f6 10 80       	push   $0x8010f6a0
80100188:	e8 4a 4d 00 00       	call   80104ed7 <release>
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
8010019e:	81 7d f4 c4 0b 11 80 	cmpl   $0x80110bc4,-0xc(%ebp)
801001a5:	75 a6                	jne    8010014d <bget+0x9a>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
801001a7:	83 ec 0c             	sub    $0xc,%esp
801001aa:	68 9f b4 10 80       	push   $0x8010b49f
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
80100204:	68 b0 b4 10 80       	push   $0x8010b4b0
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
80100243:	68 b7 b4 10 80       	push   $0x8010b4b7
80100248:	e8 19 03 00 00       	call   80100566 <panic>

  acquire(&bcache.lock);
8010024d:	83 ec 0c             	sub    $0xc,%esp
80100250:	68 a0 f6 10 80       	push   $0x8010f6a0
80100255:	e8 16 4c 00 00       	call   80104e70 <acquire>
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
8010027b:	8b 15 d4 0b 11 80    	mov    0x80110bd4,%edx
80100281:	8b 45 08             	mov    0x8(%ebp),%eax
80100284:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
80100287:	8b 45 08             	mov    0x8(%ebp),%eax
8010028a:	c7 40 0c c4 0b 11 80 	movl   $0x80110bc4,0xc(%eax)
  bcache.head.next->prev = b;
80100291:	a1 d4 0b 11 80       	mov    0x80110bd4,%eax
80100296:	8b 55 08             	mov    0x8(%ebp),%edx
80100299:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
8010029c:	8b 45 08             	mov    0x8(%ebp),%eax
8010029f:	a3 d4 0b 11 80       	mov    %eax,0x80110bd4

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
801002b9:	e8 a4 49 00 00       	call   80104c62 <wakeup>
801002be:	83 c4 10             	add    $0x10,%esp

  release(&bcache.lock);
801002c1:	83 ec 0c             	sub    $0xc,%esp
801002c4:	68 a0 f6 10 80       	push   $0x8010f6a0
801002c9:	e8 09 4c 00 00       	call   80104ed7 <release>
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
801003cc:	a1 14 e6 10 80       	mov    0x8010e614,%eax
801003d1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003d4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003d8:	74 10                	je     801003ea <cprintf+0x24>
    acquire(&cons.lock);
801003da:	83 ec 0c             	sub    $0xc,%esp
801003dd:	68 e0 e5 10 80       	push   $0x8010e5e0
801003e2:	e8 89 4a 00 00       	call   80104e70 <acquire>
801003e7:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
801003ea:	8b 45 08             	mov    0x8(%ebp),%eax
801003ed:	85 c0                	test   %eax,%eax
801003ef:	75 0d                	jne    801003fe <cprintf+0x38>
    panic("null fmt");
801003f1:	83 ec 0c             	sub    $0xc,%esp
801003f4:	68 be b4 10 80       	push   $0x8010b4be
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
801004cd:	c7 45 ec c7 b4 10 80 	movl   $0x8010b4c7,-0x14(%ebp)
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
80100556:	68 e0 e5 10 80       	push   $0x8010e5e0
8010055b:	e8 77 49 00 00       	call   80104ed7 <release>
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
80100571:	c7 05 14 e6 10 80 00 	movl   $0x0,0x8010e614
80100578:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
8010057b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100581:	0f b6 00             	movzbl (%eax),%eax
80100584:	0f b6 c0             	movzbl %al,%eax
80100587:	83 ec 08             	sub    $0x8,%esp
8010058a:	50                   	push   %eax
8010058b:	68 ce b4 10 80       	push   $0x8010b4ce
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
801005aa:	68 dd b4 10 80       	push   $0x8010b4dd
801005af:	e8 12 fe ff ff       	call   801003c6 <cprintf>
801005b4:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005b7:	83 ec 08             	sub    $0x8,%esp
801005ba:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005bd:	50                   	push   %eax
801005be:	8d 45 08             	lea    0x8(%ebp),%eax
801005c1:	50                   	push   %eax
801005c2:	e8 62 49 00 00       	call   80104f29 <getcallerpcs>
801005c7:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005d1:	eb 1c                	jmp    801005ef <panic+0x89>
    cprintf(" %p", pcs[i]);
801005d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005d6:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005da:	83 ec 08             	sub    $0x8,%esp
801005dd:	50                   	push   %eax
801005de:	68 df b4 10 80       	push   $0x8010b4df
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
801005f5:	c7 05 c0 e5 10 80 01 	movl   $0x1,0x8010e5c0
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
801006db:	e8 b2 4a 00 00       	call   80105192 <memmove>
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
80100705:	e8 c9 49 00 00       	call   801050d3 <memset>
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
8010077c:	a1 c0 e5 10 80       	mov    0x8010e5c0,%eax
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
8010079a:	e8 51 62 00 00       	call   801069f0 <uartputc>
8010079f:	83 c4 10             	add    $0x10,%esp
801007a2:	83 ec 0c             	sub    $0xc,%esp
801007a5:	6a 20                	push   $0x20
801007a7:	e8 44 62 00 00       	call   801069f0 <uartputc>
801007ac:	83 c4 10             	add    $0x10,%esp
801007af:	83 ec 0c             	sub    $0xc,%esp
801007b2:	6a 08                	push   $0x8
801007b4:	e8 37 62 00 00       	call   801069f0 <uartputc>
801007b9:	83 c4 10             	add    $0x10,%esp
801007bc:	eb 0e                	jmp    801007cc <consputc+0x56>
  } else
    uartputc(c);
801007be:	83 ec 0c             	sub    $0xc,%esp
801007c1:	ff 75 08             	pushl  0x8(%ebp)
801007c4:	e8 27 62 00 00       	call   801069f0 <uartputc>
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
801007e6:	68 e0 0d 11 80       	push   $0x80110de0
801007eb:	e8 80 46 00 00       	call   80104e70 <acquire>
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
8010081e:	e8 fa 44 00 00       	call   80104d1d <procdump>
      break;
80100823:	e9 12 01 00 00       	jmp    8010093a <consoleintr+0x15d>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100828:	a1 9c 0e 11 80       	mov    0x80110e9c,%eax
8010082d:	83 e8 01             	sub    $0x1,%eax
80100830:	a3 9c 0e 11 80       	mov    %eax,0x80110e9c
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
80100845:	8b 15 9c 0e 11 80    	mov    0x80110e9c,%edx
8010084b:	a1 98 0e 11 80       	mov    0x80110e98,%eax
80100850:	39 c2                	cmp    %eax,%edx
80100852:	0f 84 e2 00 00 00    	je     8010093a <consoleintr+0x15d>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100858:	a1 9c 0e 11 80       	mov    0x80110e9c,%eax
8010085d:	83 e8 01             	sub    $0x1,%eax
80100860:	83 e0 7f             	and    $0x7f,%eax
80100863:	0f b6 80 14 0e 11 80 	movzbl -0x7feef1ec(%eax),%eax
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
80100873:	8b 15 9c 0e 11 80    	mov    0x80110e9c,%edx
80100879:	a1 98 0e 11 80       	mov    0x80110e98,%eax
8010087e:	39 c2                	cmp    %eax,%edx
80100880:	0f 84 b4 00 00 00    	je     8010093a <consoleintr+0x15d>
        input.e--;
80100886:	a1 9c 0e 11 80       	mov    0x80110e9c,%eax
8010088b:	83 e8 01             	sub    $0x1,%eax
8010088e:	a3 9c 0e 11 80       	mov    %eax,0x80110e9c
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
801008b2:	8b 15 9c 0e 11 80    	mov    0x80110e9c,%edx
801008b8:	a1 94 0e 11 80       	mov    0x80110e94,%eax
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
801008d9:	a1 9c 0e 11 80       	mov    0x80110e9c,%eax
801008de:	8d 50 01             	lea    0x1(%eax),%edx
801008e1:	89 15 9c 0e 11 80    	mov    %edx,0x80110e9c
801008e7:	83 e0 7f             	and    $0x7f,%eax
801008ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
801008ed:	88 90 14 0e 11 80    	mov    %dl,-0x7feef1ec(%eax)
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
8010090d:	a1 9c 0e 11 80       	mov    0x80110e9c,%eax
80100912:	8b 15 94 0e 11 80    	mov    0x80110e94,%edx
80100918:	83 ea 80             	sub    $0xffffff80,%edx
8010091b:	39 d0                	cmp    %edx,%eax
8010091d:	75 1a                	jne    80100939 <consoleintr+0x15c>
          input.w = input.e;
8010091f:	a1 9c 0e 11 80       	mov    0x80110e9c,%eax
80100924:	a3 98 0e 11 80       	mov    %eax,0x80110e98
          wakeup(&input.r);
80100929:	83 ec 0c             	sub    $0xc,%esp
8010092c:	68 94 0e 11 80       	push   $0x80110e94
80100931:	e8 2c 43 00 00       	call   80104c62 <wakeup>
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
8010094f:	68 e0 0d 11 80       	push   $0x80110de0
80100954:	e8 7e 45 00 00       	call   80104ed7 <release>
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
8010097c:	68 e0 0d 11 80       	push   $0x80110de0
80100981:	e8 ea 44 00 00       	call   80104e70 <acquire>
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
8010099e:	68 e0 0d 11 80       	push   $0x80110de0
801009a3:	e8 2f 45 00 00       	call   80104ed7 <release>
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
801009c6:	68 e0 0d 11 80       	push   $0x80110de0
801009cb:	68 94 0e 11 80       	push   $0x80110e94
801009d0:	e8 a2 41 00 00       	call   80104b77 <sleep>
801009d5:	83 c4 10             	add    $0x10,%esp

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
801009d8:	8b 15 94 0e 11 80    	mov    0x80110e94,%edx
801009de:	a1 98 0e 11 80       	mov    0x80110e98,%eax
801009e3:	39 c2                	cmp    %eax,%edx
801009e5:	74 a7                	je     8010098e <consoleread+0x2f>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801009e7:	a1 94 0e 11 80       	mov    0x80110e94,%eax
801009ec:	8d 50 01             	lea    0x1(%eax),%edx
801009ef:	89 15 94 0e 11 80    	mov    %edx,0x80110e94
801009f5:	83 e0 7f             	and    $0x7f,%eax
801009f8:	0f b6 80 14 0e 11 80 	movzbl -0x7feef1ec(%eax),%eax
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
80100a13:	a1 94 0e 11 80       	mov    0x80110e94,%eax
80100a18:	83 e8 01             	sub    $0x1,%eax
80100a1b:	a3 94 0e 11 80       	mov    %eax,0x80110e94
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
80100a49:	68 e0 0d 11 80       	push   $0x80110de0
80100a4e:	e8 84 44 00 00       	call   80104ed7 <release>
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
80100a87:	68 e0 e5 10 80       	push   $0x8010e5e0
80100a8c:	e8 df 43 00 00       	call   80104e70 <acquire>
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
80100ac9:	68 e0 e5 10 80       	push   $0x8010e5e0
80100ace:	e8 04 44 00 00       	call   80104ed7 <release>
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
80100af2:	68 e3 b4 10 80       	push   $0x8010b4e3
80100af7:	68 e0 e5 10 80       	push   $0x8010e5e0
80100afc:	e8 4d 43 00 00       	call   80104e4e <initlock>
80100b01:	83 c4 10             	add    $0x10,%esp
  initlock(&input.lock, "input");
80100b04:	83 ec 08             	sub    $0x8,%esp
80100b07:	68 eb b4 10 80       	push   $0x8010b4eb
80100b0c:	68 e0 0d 11 80       	push   $0x80110de0
80100b11:	e8 38 43 00 00       	call   80104e4e <initlock>
80100b16:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100b19:	c7 05 4c 18 11 80 70 	movl   $0x80100a70,0x8011184c
80100b20:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b23:	c7 05 48 18 11 80 5f 	movl   $0x8010095f,0x80111848
80100b2a:	09 10 80 
  cons.locking = 1;
80100b2d:	c7 05 14 e6 10 80 01 	movl   $0x1,0x8010e614
80100b34:	00 00 00 

  picenable(IRQ_KBD);
80100b37:	83 ec 0c             	sub    $0xc,%esp
80100b3a:	6a 01                	push   $0x1
80100b3c:	e8 9a 32 00 00       	call   80103ddb <picenable>
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
80100bc5:	e8 7b 6f 00 00       	call   80107b45 <setupkvm>
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
80100c4b:	e8 9c 72 00 00       	call   80107eec <allocuvm>
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
80100c7e:	e8 92 71 00 00       	call   80107e15 <loaduvm>
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
80100ce8:	e8 ff 71 00 00       	call   80107eec <allocuvm>
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
80100d0c:	e8 01 74 00 00       	call   80108112 <clearpteu>
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
80100d45:	e8 d6 45 00 00       	call   80105320 <strlen>
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
80100d72:	e8 a9 45 00 00       	call   80105320 <strlen>
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
80100d98:	e8 19 75 00 00       	call   801082b6 <copyout>
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
80100e34:	e8 7d 74 00 00       	call   801082b6 <copyout>
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
80100e85:	e8 4c 44 00 00       	call   801052d6 <safestrcpy>
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
80100edb:	e8 4c 6d 00 00       	call   80107c2c <switchuvm>
80100ee0:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100ee3:	83 ec 0c             	sub    $0xc,%esp
80100ee6:	ff 75 d0             	pushl  -0x30(%ebp)
80100ee9:	e8 84 71 00 00       	call   80108072 <freevm>
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
80100f23:	e8 4a 71 00 00       	call   80108072 <freevm>
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
80100f4f:	68 f1 b4 10 80       	push   $0x8010b4f1
80100f54:	68 a0 0e 11 80       	push   $0x80110ea0
80100f59:	e8 f0 3e 00 00       	call   80104e4e <initlock>
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
80100f6d:	68 a0 0e 11 80       	push   $0x80110ea0
80100f72:	e8 f9 3e 00 00       	call   80104e70 <acquire>
80100f77:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f7a:	c7 45 f4 d4 0e 11 80 	movl   $0x80110ed4,-0xc(%ebp)
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
80100f9a:	68 a0 0e 11 80       	push   $0x80110ea0
80100f9f:	e8 33 3f 00 00       	call   80104ed7 <release>
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
80100fb0:	b8 34 18 11 80       	mov    $0x80111834,%eax
80100fb5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100fb8:	72 c9                	jb     80100f83 <filealloc+0x1f>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100fba:	83 ec 0c             	sub    $0xc,%esp
80100fbd:	68 a0 0e 11 80       	push   $0x80110ea0
80100fc2:	e8 10 3f 00 00       	call   80104ed7 <release>
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
80100fda:	68 a0 0e 11 80       	push   $0x80110ea0
80100fdf:	e8 8c 3e 00 00       	call   80104e70 <acquire>
80100fe4:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80100fe7:	8b 45 08             	mov    0x8(%ebp),%eax
80100fea:	8b 40 04             	mov    0x4(%eax),%eax
80100fed:	85 c0                	test   %eax,%eax
80100fef:	7f 0d                	jg     80100ffe <filedup+0x2d>
    panic("filedup");
80100ff1:	83 ec 0c             	sub    $0xc,%esp
80100ff4:	68 f8 b4 10 80       	push   $0x8010b4f8
80100ff9:	e8 68 f5 ff ff       	call   80100566 <panic>
  f->ref++;
80100ffe:	8b 45 08             	mov    0x8(%ebp),%eax
80101001:	8b 40 04             	mov    0x4(%eax),%eax
80101004:	8d 50 01             	lea    0x1(%eax),%edx
80101007:	8b 45 08             	mov    0x8(%ebp),%eax
8010100a:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
8010100d:	83 ec 0c             	sub    $0xc,%esp
80101010:	68 a0 0e 11 80       	push   $0x80110ea0
80101015:	e8 bd 3e 00 00       	call   80104ed7 <release>
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
8010102b:	68 a0 0e 11 80       	push   $0x80110ea0
80101030:	e8 3b 3e 00 00       	call   80104e70 <acquire>
80101035:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101038:	8b 45 08             	mov    0x8(%ebp),%eax
8010103b:	8b 40 04             	mov    0x4(%eax),%eax
8010103e:	85 c0                	test   %eax,%eax
80101040:	7f 0d                	jg     8010104f <fileclose+0x2d>
    panic("fileclose");
80101042:	83 ec 0c             	sub    $0xc,%esp
80101045:	68 00 b5 10 80       	push   $0x8010b500
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
8010106b:	68 a0 0e 11 80       	push   $0x80110ea0
80101070:	e8 62 3e 00 00       	call   80104ed7 <release>
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
801010b9:	68 a0 0e 11 80       	push   $0x80110ea0
801010be:	e8 14 3e 00 00       	call   80104ed7 <release>
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
801010dd:	e8 62 2f 00 00       	call   80104044 <pipeclose>
801010e2:	83 c4 10             	add    $0x10,%esp
801010e5:	eb 21                	jmp    80101108 <fileclose+0xe6>
  else if(ff.type == FD_INODE){
801010e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010ea:	83 f8 02             	cmp    $0x2,%eax
801010ed:	75 19                	jne    80101108 <fileclose+0xe6>
    begin_trans();
801010ef:	e8 22 24 00 00       	call   80103516 <begin_trans>
    iput(ff.ip);
801010f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801010f7:	83 ec 0c             	sub    $0xc,%esp
801010fa:	50                   	push   %eax
801010fb:	e8 c1 09 00 00       	call   80101ac1 <iput>
80101100:	83 c4 10             	add    $0x10,%esp
    commit_trans();
80101103:	e8 61 24 00 00       	call   80103569 <commit_trans>
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
80101196:	e8 51 30 00 00       	call   801041ec <piperead>
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
8010120d:	68 0a b5 10 80       	push   $0x8010b50a
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
8010124f:	e8 9a 2e 00 00       	call   801040ee <pipewrite>
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
80101294:	e8 7d 22 00 00       	call   80103516 <begin_trans>
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
801012fa:	e8 6a 22 00 00       	call   80103569 <commit_trans>

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
80101310:	68 13 b5 10 80       	push   $0x8010b513
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
80101346:	68 23 b5 10 80       	push   $0x8010b523
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
8010137e:	e8 0f 3e 00 00       	call   80105192 <memmove>
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
801013c4:	e8 0a 3d 00 00       	call   801050d3 <memset>
801013c9:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801013cc:	83 ec 0c             	sub    $0xc,%esp
801013cf:	ff 75 f4             	pushl  -0xc(%ebp)
801013d2:	e8 f7 21 00 00       	call   801035ce <log_write>
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
801014bd:	e8 0c 21 00 00       	call   801035ce <log_write>
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
8010153d:	68 2d b5 10 80       	push   $0x8010b52d
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
801015d3:	68 43 b5 10 80       	push   $0x8010b543
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
8010160b:	e8 be 1f 00 00       	call   801035ce <log_write>
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
8010162d:	68 56 b5 10 80       	push   $0x8010b556
80101632:	68 a0 18 11 80       	push   $0x801118a0
80101637:	e8 12 38 00 00       	call   80104e4e <initlock>
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
801016b2:	e8 1c 3a 00 00       	call   801050d3 <memset>
801016b7:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
801016ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016bd:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
801016c1:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
801016c4:	83 ec 0c             	sub    $0xc,%esp
801016c7:	ff 75 f0             	pushl  -0x10(%ebp)
801016ca:	e8 ff 1e 00 00       	call   801035ce <log_write>
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
80101717:	68 5d b5 10 80       	push   $0x8010b55d
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
801017b7:	e8 d6 39 00 00       	call   80105192 <memmove>
801017bc:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801017bf:	83 ec 0c             	sub    $0xc,%esp
801017c2:	ff 75 f4             	pushl  -0xc(%ebp)
801017c5:	e8 04 1e 00 00       	call   801035ce <log_write>
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
801017e7:	68 a0 18 11 80       	push   $0x801118a0
801017ec:	e8 7f 36 00 00       	call   80104e70 <acquire>
801017f1:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
801017f4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801017fb:	c7 45 f4 d4 18 11 80 	movl   $0x801118d4,-0xc(%ebp)
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
80101835:	68 a0 18 11 80       	push   $0x801118a0
8010183a:	e8 98 36 00 00       	call   80104ed7 <release>
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
80101861:	81 7d f4 74 28 11 80 	cmpl   $0x80112874,-0xc(%ebp)
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
80101873:	68 6f b5 10 80       	push   $0x8010b56f
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
801018ab:	68 a0 18 11 80       	push   $0x801118a0
801018b0:	e8 22 36 00 00       	call   80104ed7 <release>
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
801018c6:	68 a0 18 11 80       	push   $0x801118a0
801018cb:	e8 a0 35 00 00       	call   80104e70 <acquire>
801018d0:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
801018d3:	8b 45 08             	mov    0x8(%ebp),%eax
801018d6:	8b 40 08             	mov    0x8(%eax),%eax
801018d9:	8d 50 01             	lea    0x1(%eax),%edx
801018dc:	8b 45 08             	mov    0x8(%ebp),%eax
801018df:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
801018e2:	83 ec 0c             	sub    $0xc,%esp
801018e5:	68 a0 18 11 80       	push   $0x801118a0
801018ea:	e8 e8 35 00 00       	call   80104ed7 <release>
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
80101910:	68 7f b5 10 80       	push   $0x8010b57f
80101915:	e8 4c ec ff ff       	call   80100566 <panic>

  acquire(&icache.lock);
8010191a:	83 ec 0c             	sub    $0xc,%esp
8010191d:	68 a0 18 11 80       	push   $0x801118a0
80101922:	e8 49 35 00 00       	call   80104e70 <acquire>
80101927:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
8010192a:	eb 13                	jmp    8010193f <ilock+0x48>
    sleep(ip, &icache.lock);
8010192c:	83 ec 08             	sub    $0x8,%esp
8010192f:	68 a0 18 11 80       	push   $0x801118a0
80101934:	ff 75 08             	pushl  0x8(%ebp)
80101937:	e8 3b 32 00 00       	call   80104b77 <sleep>
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
80101960:	68 a0 18 11 80       	push   $0x801118a0
80101965:	e8 6d 35 00 00       	call   80104ed7 <release>
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
80101a0c:	e8 81 37 00 00       	call   80105192 <memmove>
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
80101a42:	68 85 b5 10 80       	push   $0x8010b585
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
80101a75:	68 94 b5 10 80       	push   $0x8010b594
80101a7a:	e8 e7 ea ff ff       	call   80100566 <panic>

  acquire(&icache.lock);
80101a7f:	83 ec 0c             	sub    $0xc,%esp
80101a82:	68 a0 18 11 80       	push   $0x801118a0
80101a87:	e8 e4 33 00 00       	call   80104e70 <acquire>
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
80101aa6:	e8 b7 31 00 00       	call   80104c62 <wakeup>
80101aab:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80101aae:	83 ec 0c             	sub    $0xc,%esp
80101ab1:	68 a0 18 11 80       	push   $0x801118a0
80101ab6:	e8 1c 34 00 00       	call   80104ed7 <release>
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
80101aca:	68 a0 18 11 80       	push   $0x801118a0
80101acf:	e8 9c 33 00 00       	call   80104e70 <acquire>
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
80101b17:	68 9c b5 10 80       	push   $0x8010b59c
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
80101b35:	68 a0 18 11 80       	push   $0x801118a0
80101b3a:	e8 98 33 00 00       	call   80104ed7 <release>
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
80101b6a:	68 a0 18 11 80       	push   $0x801118a0
80101b6f:	e8 fc 32 00 00       	call   80104e70 <acquire>
80101b74:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101b77:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7a:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101b81:	83 ec 0c             	sub    $0xc,%esp
80101b84:	ff 75 08             	pushl  0x8(%ebp)
80101b87:	e8 d6 30 00 00       	call   80104c62 <wakeup>
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
80101ba1:	68 a0 18 11 80       	push   $0x801118a0
80101ba6:	e8 2c 33 00 00       	call   80104ed7 <release>
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
80101cc8:	e8 01 19 00 00       	call   801035ce <log_write>
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
80101d92:	e8 37 18 00 00       	call   801035ce <log_write>
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
80101e17:	e8 b2 17 00 00       	call   801035ce <log_write>
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
80101e35:	68 a6 b5 10 80       	push   $0x8010b5a6
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
80101fe2:	8b 04 c5 40 18 11 80 	mov    -0x7feee7c0(,%eax,8),%eax
80101fe9:	85 c0                	test   %eax,%eax
80101feb:	75 0a                	jne    80101ff7 <readi+0x49>
      return -1;
80101fed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ff2:	e9 0c 01 00 00       	jmp    80102103 <readi+0x155>
    return devsw[ip->major].read(ip, dst, n);
80101ff7:	8b 45 08             	mov    0x8(%ebp),%eax
80101ffa:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101ffe:	98                   	cwtl   
80101fff:	8b 04 c5 40 18 11 80 	mov    -0x7feee7c0(,%eax,8),%eax
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
801020cc:	e8 c1 30 00 00       	call   80105192 <memmove>
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
80102139:	8b 04 c5 44 18 11 80 	mov    -0x7feee7bc(,%eax,8),%eax
80102140:	85 c0                	test   %eax,%eax
80102142:	75 0a                	jne    8010214e <writei+0x49>
      return -1;
80102144:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102149:	e9 3d 01 00 00       	jmp    8010228b <writei+0x186>
    return devsw[ip->major].write(ip, src, n);
8010214e:	8b 45 08             	mov    0x8(%ebp),%eax
80102151:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102155:	98                   	cwtl   
80102156:	8b 04 c5 44 18 11 80 	mov    -0x7feee7bc(,%eax,8),%eax
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
8010221e:	e8 6f 2f 00 00       	call   80105192 <memmove>
80102223:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
80102226:	83 ec 0c             	sub    $0xc,%esp
80102229:	ff 75 f0             	pushl  -0x10(%ebp)
8010222c:	e8 9d 13 00 00       	call   801035ce <log_write>
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
8010229e:	e8 85 2f 00 00       	call   80105228 <strncmp>
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
801022be:	68 b9 b5 10 80       	push   $0x8010b5b9
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
801022ed:	68 cb b5 10 80       	push   $0x8010b5cb
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
801023c2:	68 cb b5 10 80       	push   $0x8010b5cb
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
801023fd:	e8 7c 2e 00 00       	call   8010527e <strncpy>
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
80102429:	68 d8 b5 10 80       	push   $0x8010b5d8
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
8010249f:	e8 ee 2c 00 00       	call   80105192 <memmove>
801024a4:	83 c4 10             	add    $0x10,%esp
801024a7:	eb 26                	jmp    801024cf <skipelem+0x95>
  else {
    memmove(name, s, len);
801024a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801024ac:	83 ec 04             	sub    $0x4,%esp
801024af:	50                   	push   %eax
801024b0:	ff 75 f4             	pushl  -0xc(%ebp)
801024b3:	ff 75 0c             	pushl  0xc(%ebp)
801024b6:	e8 d7 2c 00 00       	call   80105192 <memmove>
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
8010270b:	68 e0 b5 10 80       	push   $0x8010b5e0
80102710:	68 20 e6 10 80       	push   $0x8010e620
80102715:	e8 34 27 00 00       	call   80104e4e <initlock>
8010271a:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
8010271d:	83 ec 0c             	sub    $0xc,%esp
80102720:	6a 0e                	push   $0xe
80102722:	e8 b4 16 00 00       	call   80103ddb <picenable>
80102727:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
8010272a:	a1 40 2f 11 80       	mov    0x80112f40,%eax
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
8010277f:	c7 05 58 e6 10 80 01 	movl   $0x1,0x8010e658
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
801027bf:	68 e4 b5 10 80       	push   $0x8010b5e4
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
801028db:	68 20 e6 10 80       	push   $0x8010e620
801028e0:	e8 8b 25 00 00       	call   80104e70 <acquire>
801028e5:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
801028e8:	a1 54 e6 10 80       	mov    0x8010e654,%eax
801028ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028f0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801028f4:	75 15                	jne    8010290b <ideintr+0x39>
    release(&idelock);
801028f6:	83 ec 0c             	sub    $0xc,%esp
801028f9:	68 20 e6 10 80       	push   $0x8010e620
801028fe:	e8 d4 25 00 00       	call   80104ed7 <release>
80102903:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
80102906:	e9 9a 00 00 00       	jmp    801029a5 <ideintr+0xd3>
  }
  idequeue = b->qnext;
8010290b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010290e:	8b 40 14             	mov    0x14(%eax),%eax
80102911:	a3 54 e6 10 80       	mov    %eax,0x8010e654

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
80102973:	e8 ea 22 00 00       	call   80104c62 <wakeup>
80102978:	83 c4 10             	add    $0x10,%esp
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
8010297b:	a1 54 e6 10 80       	mov    0x8010e654,%eax
80102980:	85 c0                	test   %eax,%eax
80102982:	74 11                	je     80102995 <ideintr+0xc3>
    idestart(idequeue);
80102984:	a1 54 e6 10 80       	mov    0x8010e654,%eax
80102989:	83 ec 0c             	sub    $0xc,%esp
8010298c:	50                   	push   %eax
8010298d:	e8 1e fe ff ff       	call   801027b0 <idestart>
80102992:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
80102995:	83 ec 0c             	sub    $0xc,%esp
80102998:	68 20 e6 10 80       	push   $0x8010e620
8010299d:	e8 35 25 00 00       	call   80104ed7 <release>
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
801029bc:	68 ed b5 10 80       	push   $0x8010b5ed
801029c1:	e8 a0 db ff ff       	call   80100566 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801029c6:	8b 45 08             	mov    0x8(%ebp),%eax
801029c9:	8b 00                	mov    (%eax),%eax
801029cb:	83 e0 06             	and    $0x6,%eax
801029ce:	83 f8 02             	cmp    $0x2,%eax
801029d1:	75 0d                	jne    801029e0 <iderw+0x39>
    panic("iderw: nothing to do");
801029d3:	83 ec 0c             	sub    $0xc,%esp
801029d6:	68 01 b6 10 80       	push   $0x8010b601
801029db:	e8 86 db ff ff       	call   80100566 <panic>
  if(b->dev != 0 && !havedisk1)
801029e0:	8b 45 08             	mov    0x8(%ebp),%eax
801029e3:	8b 40 04             	mov    0x4(%eax),%eax
801029e6:	85 c0                	test   %eax,%eax
801029e8:	74 16                	je     80102a00 <iderw+0x59>
801029ea:	a1 58 e6 10 80       	mov    0x8010e658,%eax
801029ef:	85 c0                	test   %eax,%eax
801029f1:	75 0d                	jne    80102a00 <iderw+0x59>
    panic("iderw: ide disk 1 not present");
801029f3:	83 ec 0c             	sub    $0xc,%esp
801029f6:	68 16 b6 10 80       	push   $0x8010b616
801029fb:	e8 66 db ff ff       	call   80100566 <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102a00:	83 ec 0c             	sub    $0xc,%esp
80102a03:	68 20 e6 10 80       	push   $0x8010e620
80102a08:	e8 63 24 00 00       	call   80104e70 <acquire>
80102a0d:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
80102a10:	8b 45 08             	mov    0x8(%ebp),%eax
80102a13:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102a1a:	c7 45 f4 54 e6 10 80 	movl   $0x8010e654,-0xc(%ebp)
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
80102a3f:	a1 54 e6 10 80       	mov    0x8010e654,%eax
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
80102a5c:	68 20 e6 10 80       	push   $0x8010e620
80102a61:	ff 75 08             	pushl  0x8(%ebp)
80102a64:	e8 0e 21 00 00       	call   80104b77 <sleep>
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
80102a7c:	68 20 e6 10 80       	push   $0x8010e620
80102a81:	e8 51 24 00 00       	call   80104ed7 <release>
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
80102a8f:	a1 74 28 11 80       	mov    0x80112874,%eax
80102a94:	8b 55 08             	mov    0x8(%ebp),%edx
80102a97:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102a99:	a1 74 28 11 80       	mov    0x80112874,%eax
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
80102aa6:	a1 74 28 11 80       	mov    0x80112874,%eax
80102aab:	8b 55 08             	mov    0x8(%ebp),%edx
80102aae:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102ab0:	a1 74 28 11 80       	mov    0x80112874,%eax
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
80102ac4:	a1 44 29 11 80       	mov    0x80112944,%eax
80102ac9:	85 c0                	test   %eax,%eax
80102acb:	0f 84 a0 00 00 00    	je     80102b71 <ioapicinit+0xb3>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102ad1:	c7 05 74 28 11 80 00 	movl   $0xfec00000,0x80112874
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
80102b00:	0f b6 05 40 29 11 80 	movzbl 0x80112940,%eax
80102b07:	0f b6 c0             	movzbl %al,%eax
80102b0a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80102b0d:	74 10                	je     80102b1f <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102b0f:	83 ec 0c             	sub    $0xc,%esp
80102b12:	68 34 b6 10 80       	push   $0x8010b634
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
80102b77:	a1 44 29 11 80       	mov    0x80112944,%eax
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
80102bd2:	68 66 b6 10 80       	push   $0x8010b666
80102bd7:	68 80 28 11 80       	push   $0x80112880
80102bdc:	e8 6d 22 00 00       	call   80104e4e <initlock>
80102be1:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102be4:	c7 05 b4 28 11 80 00 	movl   $0x0,0x801128b4
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
80102c19:	c7 05 b4 28 11 80 01 	movl   $0x1,0x801128b4
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
80102c93:	68 6b b6 10 80       	push   $0x8010b66b
80102c98:	e8 c9 d8 ff ff       	call   80100566 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102c9d:	83 ec 04             	sub    $0x4,%esp
80102ca0:	68 00 10 00 00       	push   $0x1000
80102ca5:	6a 01                	push   $0x1
80102ca7:	ff 75 08             	pushl  0x8(%ebp)
80102caa:	e8 24 24 00 00       	call   801050d3 <memset>
80102caf:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102cb2:	a1 b4 28 11 80       	mov    0x801128b4,%eax
80102cb7:	85 c0                	test   %eax,%eax
80102cb9:	74 10                	je     80102ccb <kfree+0x68>
    acquire(&kmem.lock);
80102cbb:	83 ec 0c             	sub    $0xc,%esp
80102cbe:	68 80 28 11 80       	push   $0x80112880
80102cc3:	e8 a8 21 00 00       	call   80104e70 <acquire>
80102cc8:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102ccb:	8b 45 08             	mov    0x8(%ebp),%eax
80102cce:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102cd1:	8b 15 b8 28 11 80    	mov    0x801128b8,%edx
80102cd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cda:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102cdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cdf:	a3 b8 28 11 80       	mov    %eax,0x801128b8
  if(kmem.use_lock)
80102ce4:	a1 b4 28 11 80       	mov    0x801128b4,%eax
80102ce9:	85 c0                	test   %eax,%eax
80102ceb:	74 10                	je     80102cfd <kfree+0x9a>
    release(&kmem.lock);
80102ced:	83 ec 0c             	sub    $0xc,%esp
80102cf0:	68 80 28 11 80       	push   $0x80112880
80102cf5:	e8 dd 21 00 00       	call   80104ed7 <release>
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
80102d06:	a1 b4 28 11 80       	mov    0x801128b4,%eax
80102d0b:	85 c0                	test   %eax,%eax
80102d0d:	74 10                	je     80102d1f <kalloc+0x1f>
    acquire(&kmem.lock);
80102d0f:	83 ec 0c             	sub    $0xc,%esp
80102d12:	68 80 28 11 80       	push   $0x80112880
80102d17:	e8 54 21 00 00       	call   80104e70 <acquire>
80102d1c:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102d1f:	a1 b8 28 11 80       	mov    0x801128b8,%eax
80102d24:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102d27:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102d2b:	74 0a                	je     80102d37 <kalloc+0x37>
    kmem.freelist = r->next;
80102d2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d30:	8b 00                	mov    (%eax),%eax
80102d32:	a3 b8 28 11 80       	mov    %eax,0x801128b8
  if(kmem.use_lock)
80102d37:	a1 b4 28 11 80       	mov    0x801128b4,%eax
80102d3c:	85 c0                	test   %eax,%eax
80102d3e:	74 10                	je     80102d50 <kalloc+0x50>
    release(&kmem.lock);
80102d40:	83 ec 0c             	sub    $0xc,%esp
80102d43:	68 80 28 11 80       	push   $0x80112880
80102d48:	e8 8a 21 00 00       	call   80104ed7 <release>
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
80102d9e:	68 71 b6 10 80       	push   $0x8010b671
80102da3:	e8 1e d6 ff ff       	call   801003c6 <cprintf>
80102da8:	83 c4 10             	add    $0x10,%esp
	cprintf("data  : %d\n", data);
80102dab:	83 ec 08             	sub    $0x8,%esp
80102dae:	ff 75 f0             	pushl  -0x10(%ebp)
80102db1:	68 7d b6 10 80       	push   $0x8010b67d
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
80102dd8:	68 89 b6 10 80       	push   $0x8010b689
80102ddd:	e8 e4 d5 ff ff       	call   801003c6 <cprintf>
80102de2:	83 c4 10             	add    $0x10,%esp
		return;
80102de5:	e9 dd 00 00 00       	jmp    80102ec7 <kbdInterupt+0x155>
	}

	if (data == 0xE0) {
80102dea:	81 7d f0 e0 00 00 00 	cmpl   $0xe0,-0x10(%ebp)
80102df1:	75 0f                	jne    80102e02 <kbdInterupt+0x90>
		shift = 1;
80102df3:	c7 05 5c e6 10 80 01 	movl   $0x1,0x8010e65c
80102dfa:	00 00 00 
		return;
80102dfd:	e9 c5 00 00 00       	jmp    80102ec7 <kbdInterupt+0x155>
	}
	else if (data & 0x80) {
80102e02:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102e05:	25 80 00 00 00       	and    $0x80,%eax
80102e0a:	85 c0                	test   %eax,%eax
80102e0c:	74 60                	je     80102e6e <kbdInterupt+0xfc>
		cprintf("test2");
80102e0e:	83 ec 0c             	sub    $0xc,%esp
80102e11:	68 a2 b6 10 80       	push   $0x8010b6a2
80102e16:	e8 ab d5 ff ff       	call   801003c6 <cprintf>
80102e1b:	83 c4 10             	add    $0x10,%esp
		// Key released
		data &= 0x7F;
80102e1e:	83 65 f0 7f          	andl   $0x7f,-0x10(%ebp)
		AMessage msg;
		msg.type = MSG_KEY_UP;
80102e22:	c7 45 d8 05 00 00 00 	movl   $0x5,-0x28(%ebp)
		msg.param = charcode[shift][data];
80102e29:	a1 5c e6 10 80       	mov    0x8010e65c,%eax
80102e2e:	8b 14 85 20 c7 10 80 	mov    -0x7fef38e0(,%eax,4),%edx
80102e35:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102e38:	01 d0                	add    %edx,%eax
80102e3a:	0f b6 00             	movzbl (%eax),%eax
80102e3d:	0f b6 c0             	movzbl %al,%eax
80102e40:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if (shift)
80102e43:	a1 5c e6 10 80       	mov    0x8010e65c,%eax
80102e48:	85 c0                	test   %eax,%eax
80102e4a:	74 0a                	je     80102e56 <kbdInterupt+0xe4>
			shift = 0;
80102e4c:	c7 05 5c e6 10 80 00 	movl   $0x0,0x8010e65c
80102e53:	00 00 00 

		sendMessage(wndList.head, &msg);
80102e56:	a1 50 78 11 80       	mov    0x80117850,%eax
80102e5b:	83 ec 08             	sub    $0x8,%esp
80102e5e:	8d 55 d8             	lea    -0x28(%ebp),%edx
80102e61:	52                   	push   %edx
80102e62:	50                   	push   %eax
80102e63:	e8 03 79 00 00       	call   8010a76b <sendMessage>
80102e68:	83 c4 10             	add    $0x10,%esp
		return;
80102e6b:	90                   	nop
80102e6c:	eb 59                	jmp    80102ec7 <kbdInterupt+0x155>
	}
	AMessage msg;
	msg.type = MSG_KEY_DOWN;
80102e6e:	c7 45 e4 06 00 00 00 	movl   $0x6,-0x1c(%ebp)
	msg.param = charcode[shift][data];
80102e75:	a1 5c e6 10 80       	mov    0x8010e65c,%eax
80102e7a:	8b 14 85 20 c7 10 80 	mov    -0x7fef38e0(,%eax,4),%edx
80102e81:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102e84:	01 d0                	add    %edx,%eax
80102e86:	0f b6 00             	movzbl (%eax),%eax
80102e89:	0f b6 c0             	movzbl %al,%eax
80102e8c:	89 45 e8             	mov    %eax,-0x18(%ebp)
	if (shift)
80102e8f:	a1 5c e6 10 80       	mov    0x8010e65c,%eax
80102e94:	85 c0                	test   %eax,%eax
80102e96:	74 0a                	je     80102ea2 <kbdInterupt+0x130>
		shift = 0;
80102e98:	c7 05 5c e6 10 80 00 	movl   $0x0,0x8010e65c
80102e9f:	00 00 00 
	sendMessage(wndList.head, &msg);
80102ea2:	a1 50 78 11 80       	mov    0x80117850,%eax
80102ea7:	83 ec 08             	sub    $0x8,%esp
80102eaa:	8d 55 e4             	lea    -0x1c(%ebp),%edx
80102ead:	52                   	push   %edx
80102eae:	50                   	push   %eax
80102eaf:	e8 b7 78 00 00       	call   8010a76b <sendMessage>
80102eb4:	83 c4 10             	add    $0x10,%esp
    cprintf("kdb message sent!\n");
80102eb7:	83 ec 0c             	sub    $0xc,%esp
80102eba:	68 a8 b6 10 80       	push   $0x8010b6a8
80102ebf:	e8 02 d5 ff ff       	call   801003c6 <cprintf>
80102ec4:	83 c4 10             	add    $0x10,%esp

}
80102ec7:	c9                   	leave  
80102ec8:	c3                   	ret    

80102ec9 <kbdgetc>:

int
kbdgetc(void)
{
80102ec9:	55                   	push   %ebp
80102eca:	89 e5                	mov    %esp,%ebp
80102ecc:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102ecf:	6a 64                	push   $0x64
80102ed1:	e8 7f fe ff ff       	call   80102d55 <inb>
80102ed6:	83 c4 04             	add    $0x4,%esp
80102ed9:	0f b6 c0             	movzbl %al,%eax
80102edc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102edf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ee2:	83 e0 01             	and    $0x1,%eax
80102ee5:	85 c0                	test   %eax,%eax
80102ee7:	75 0a                	jne    80102ef3 <kbdgetc+0x2a>
    return -1;
80102ee9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102eee:	e9 23 01 00 00       	jmp    80103016 <kbdgetc+0x14d>
  data = inb(KBDATAP);
80102ef3:	6a 60                	push   $0x60
80102ef5:	e8 5b fe ff ff       	call   80102d55 <inb>
80102efa:	83 c4 04             	add    $0x4,%esp
80102efd:	0f b6 c0             	movzbl %al,%eax
80102f00:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102f03:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102f0a:	75 17                	jne    80102f23 <kbdgetc+0x5a>
    shift |= E0ESC;
80102f0c:	a1 60 e6 10 80       	mov    0x8010e660,%eax
80102f11:	83 c8 40             	or     $0x40,%eax
80102f14:	a3 60 e6 10 80       	mov    %eax,0x8010e660
    return 0;
80102f19:	b8 00 00 00 00       	mov    $0x0,%eax
80102f1e:	e9 f3 00 00 00       	jmp    80103016 <kbdgetc+0x14d>
  } else if(data & 0x80){
80102f23:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f26:	25 80 00 00 00       	and    $0x80,%eax
80102f2b:	85 c0                	test   %eax,%eax
80102f2d:	74 45                	je     80102f74 <kbdgetc+0xab>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102f2f:	a1 60 e6 10 80       	mov    0x8010e660,%eax
80102f34:	83 e0 40             	and    $0x40,%eax
80102f37:	85 c0                	test   %eax,%eax
80102f39:	75 08                	jne    80102f43 <kbdgetc+0x7a>
80102f3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f3e:	83 e0 7f             	and    $0x7f,%eax
80102f41:	eb 03                	jmp    80102f46 <kbdgetc+0x7d>
80102f43:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f46:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102f49:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f4c:	05 20 c0 10 80       	add    $0x8010c020,%eax
80102f51:	0f b6 00             	movzbl (%eax),%eax
80102f54:	83 c8 40             	or     $0x40,%eax
80102f57:	0f b6 c0             	movzbl %al,%eax
80102f5a:	f7 d0                	not    %eax
80102f5c:	89 c2                	mov    %eax,%edx
80102f5e:	a1 60 e6 10 80       	mov    0x8010e660,%eax
80102f63:	21 d0                	and    %edx,%eax
80102f65:	a3 60 e6 10 80       	mov    %eax,0x8010e660
    return 0;
80102f6a:	b8 00 00 00 00       	mov    $0x0,%eax
80102f6f:	e9 a2 00 00 00       	jmp    80103016 <kbdgetc+0x14d>
  } else if(shift & E0ESC){
80102f74:	a1 60 e6 10 80       	mov    0x8010e660,%eax
80102f79:	83 e0 40             	and    $0x40,%eax
80102f7c:	85 c0                	test   %eax,%eax
80102f7e:	74 14                	je     80102f94 <kbdgetc+0xcb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102f80:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102f87:	a1 60 e6 10 80       	mov    0x8010e660,%eax
80102f8c:	83 e0 bf             	and    $0xffffffbf,%eax
80102f8f:	a3 60 e6 10 80       	mov    %eax,0x8010e660
  }

  shift |= shiftcode[data];
80102f94:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f97:	05 20 c0 10 80       	add    $0x8010c020,%eax
80102f9c:	0f b6 00             	movzbl (%eax),%eax
80102f9f:	0f b6 d0             	movzbl %al,%edx
80102fa2:	a1 60 e6 10 80       	mov    0x8010e660,%eax
80102fa7:	09 d0                	or     %edx,%eax
80102fa9:	a3 60 e6 10 80       	mov    %eax,0x8010e660
  shift ^= togglecode[data];
80102fae:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102fb1:	05 20 c1 10 80       	add    $0x8010c120,%eax
80102fb6:	0f b6 00             	movzbl (%eax),%eax
80102fb9:	0f b6 d0             	movzbl %al,%edx
80102fbc:	a1 60 e6 10 80       	mov    0x8010e660,%eax
80102fc1:	31 d0                	xor    %edx,%eax
80102fc3:	a3 60 e6 10 80       	mov    %eax,0x8010e660
  c = charcode[shift & (CTL | SHIFT)][data];
80102fc8:	a1 60 e6 10 80       	mov    0x8010e660,%eax
80102fcd:	83 e0 03             	and    $0x3,%eax
80102fd0:	8b 14 85 28 c7 10 80 	mov    -0x7fef38d8(,%eax,4),%edx
80102fd7:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102fda:	01 d0                	add    %edx,%eax
80102fdc:	0f b6 00             	movzbl (%eax),%eax
80102fdf:	0f b6 c0             	movzbl %al,%eax
80102fe2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102fe5:	a1 60 e6 10 80       	mov    0x8010e660,%eax
80102fea:	83 e0 08             	and    $0x8,%eax
80102fed:	85 c0                	test   %eax,%eax
80102fef:	74 22                	je     80103013 <kbdgetc+0x14a>
    if('a' <= c && c <= 'z')
80102ff1:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102ff5:	76 0c                	jbe    80103003 <kbdgetc+0x13a>
80102ff7:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102ffb:	77 06                	ja     80103003 <kbdgetc+0x13a>
      c += 'A' - 'a';
80102ffd:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80103001:	eb 10                	jmp    80103013 <kbdgetc+0x14a>
    else if('A' <= c && c <= 'Z')
80103003:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80103007:	76 0a                	jbe    80103013 <kbdgetc+0x14a>
80103009:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
8010300d:	77 04                	ja     80103013 <kbdgetc+0x14a>
      c += 'a' - 'A';
8010300f:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  
  return c;
80103013:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103016:	c9                   	leave  
80103017:	c3                   	ret    

80103018 <kbdintr>:

void
kbdintr(void)
{
80103018:	55                   	push   %ebp
80103019:	89 e5                	mov    %esp,%ebp
8010301b:	83 ec 08             	sub    $0x8,%esp
  //consoleintr(kbdgetc);
	kbdInterupt();
8010301e:	e8 4f fd ff ff       	call   80102d72 <kbdInterupt>
}
80103023:	90                   	nop
80103024:	c9                   	leave  
80103025:	c3                   	ret    

80103026 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103026:	55                   	push   %ebp
80103027:	89 e5                	mov    %esp,%ebp
80103029:	83 ec 08             	sub    $0x8,%esp
8010302c:	8b 55 08             	mov    0x8(%ebp),%edx
8010302f:	8b 45 0c             	mov    0xc(%ebp),%eax
80103032:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103036:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103039:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010303d:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103041:	ee                   	out    %al,(%dx)
}
80103042:	90                   	nop
80103043:	c9                   	leave  
80103044:	c3                   	ret    

80103045 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80103045:	55                   	push   %ebp
80103046:	89 e5                	mov    %esp,%ebp
80103048:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010304b:	9c                   	pushf  
8010304c:	58                   	pop    %eax
8010304d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80103050:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103053:	c9                   	leave  
80103054:	c3                   	ret    

80103055 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80103055:	55                   	push   %ebp
80103056:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80103058:	a1 bc 28 11 80       	mov    0x801128bc,%eax
8010305d:	8b 55 08             	mov    0x8(%ebp),%edx
80103060:	c1 e2 02             	shl    $0x2,%edx
80103063:	01 c2                	add    %eax,%edx
80103065:	8b 45 0c             	mov    0xc(%ebp),%eax
80103068:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
8010306a:	a1 bc 28 11 80       	mov    0x801128bc,%eax
8010306f:	83 c0 20             	add    $0x20,%eax
80103072:	8b 00                	mov    (%eax),%eax
}
80103074:	90                   	nop
80103075:	5d                   	pop    %ebp
80103076:	c3                   	ret    

80103077 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80103077:	55                   	push   %ebp
80103078:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
8010307a:	a1 bc 28 11 80       	mov    0x801128bc,%eax
8010307f:	85 c0                	test   %eax,%eax
80103081:	0f 84 0b 01 00 00    	je     80103192 <lapicinit+0x11b>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80103087:	68 3f 01 00 00       	push   $0x13f
8010308c:	6a 3c                	push   $0x3c
8010308e:	e8 c2 ff ff ff       	call   80103055 <lapicw>
80103093:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80103096:	6a 0b                	push   $0xb
80103098:	68 f8 00 00 00       	push   $0xf8
8010309d:	e8 b3 ff ff ff       	call   80103055 <lapicw>
801030a2:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
801030a5:	68 20 00 02 00       	push   $0x20020
801030aa:	68 c8 00 00 00       	push   $0xc8
801030af:	e8 a1 ff ff ff       	call   80103055 <lapicw>
801030b4:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000); 
801030b7:	68 80 96 98 00       	push   $0x989680
801030bc:	68 e0 00 00 00       	push   $0xe0
801030c1:	e8 8f ff ff ff       	call   80103055 <lapicw>
801030c6:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
801030c9:	68 00 00 01 00       	push   $0x10000
801030ce:	68 d4 00 00 00       	push   $0xd4
801030d3:	e8 7d ff ff ff       	call   80103055 <lapicw>
801030d8:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
801030db:	68 00 00 01 00       	push   $0x10000
801030e0:	68 d8 00 00 00       	push   $0xd8
801030e5:	e8 6b ff ff ff       	call   80103055 <lapicw>
801030ea:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801030ed:	a1 bc 28 11 80       	mov    0x801128bc,%eax
801030f2:	83 c0 30             	add    $0x30,%eax
801030f5:	8b 00                	mov    (%eax),%eax
801030f7:	c1 e8 10             	shr    $0x10,%eax
801030fa:	0f b6 c0             	movzbl %al,%eax
801030fd:	83 f8 03             	cmp    $0x3,%eax
80103100:	76 12                	jbe    80103114 <lapicinit+0x9d>
    lapicw(PCINT, MASKED);
80103102:	68 00 00 01 00       	push   $0x10000
80103107:	68 d0 00 00 00       	push   $0xd0
8010310c:	e8 44 ff ff ff       	call   80103055 <lapicw>
80103111:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80103114:	6a 33                	push   $0x33
80103116:	68 dc 00 00 00       	push   $0xdc
8010311b:	e8 35 ff ff ff       	call   80103055 <lapicw>
80103120:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80103123:	6a 00                	push   $0x0
80103125:	68 a0 00 00 00       	push   $0xa0
8010312a:	e8 26 ff ff ff       	call   80103055 <lapicw>
8010312f:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80103132:	6a 00                	push   $0x0
80103134:	68 a0 00 00 00       	push   $0xa0
80103139:	e8 17 ff ff ff       	call   80103055 <lapicw>
8010313e:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80103141:	6a 00                	push   $0x0
80103143:	6a 2c                	push   $0x2c
80103145:	e8 0b ff ff ff       	call   80103055 <lapicw>
8010314a:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
8010314d:	6a 00                	push   $0x0
8010314f:	68 c4 00 00 00       	push   $0xc4
80103154:	e8 fc fe ff ff       	call   80103055 <lapicw>
80103159:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
8010315c:	68 00 85 08 00       	push   $0x88500
80103161:	68 c0 00 00 00       	push   $0xc0
80103166:	e8 ea fe ff ff       	call   80103055 <lapicw>
8010316b:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
8010316e:	90                   	nop
8010316f:	a1 bc 28 11 80       	mov    0x801128bc,%eax
80103174:	05 00 03 00 00       	add    $0x300,%eax
80103179:	8b 00                	mov    (%eax),%eax
8010317b:	25 00 10 00 00       	and    $0x1000,%eax
80103180:	85 c0                	test   %eax,%eax
80103182:	75 eb                	jne    8010316f <lapicinit+0xf8>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80103184:	6a 00                	push   $0x0
80103186:	6a 20                	push   $0x20
80103188:	e8 c8 fe ff ff       	call   80103055 <lapicw>
8010318d:	83 c4 08             	add    $0x8,%esp
80103190:	eb 01                	jmp    80103193 <lapicinit+0x11c>

void
lapicinit(void)
{
  if(!lapic) 
    return;
80103192:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80103193:	c9                   	leave  
80103194:	c3                   	ret    

80103195 <cpunum>:

int
cpunum(void)
{
80103195:	55                   	push   %ebp
80103196:	89 e5                	mov    %esp,%ebp
80103198:	83 ec 08             	sub    $0x8,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
8010319b:	e8 a5 fe ff ff       	call   80103045 <readeflags>
801031a0:	25 00 02 00 00       	and    $0x200,%eax
801031a5:	85 c0                	test   %eax,%eax
801031a7:	74 26                	je     801031cf <cpunum+0x3a>
    static int n;
    if(n++ == 0)
801031a9:	a1 64 e6 10 80       	mov    0x8010e664,%eax
801031ae:	8d 50 01             	lea    0x1(%eax),%edx
801031b1:	89 15 64 e6 10 80    	mov    %edx,0x8010e664
801031b7:	85 c0                	test   %eax,%eax
801031b9:	75 14                	jne    801031cf <cpunum+0x3a>
      cprintf("cpu called from %x with interrupts enabled\n",
801031bb:	8b 45 04             	mov    0x4(%ebp),%eax
801031be:	83 ec 08             	sub    $0x8,%esp
801031c1:	50                   	push   %eax
801031c2:	68 bc b6 10 80       	push   $0x8010b6bc
801031c7:	e8 fa d1 ff ff       	call   801003c6 <cprintf>
801031cc:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
801031cf:	a1 bc 28 11 80       	mov    0x801128bc,%eax
801031d4:	85 c0                	test   %eax,%eax
801031d6:	74 0f                	je     801031e7 <cpunum+0x52>
    return lapic[ID]>>24;
801031d8:	a1 bc 28 11 80       	mov    0x801128bc,%eax
801031dd:	83 c0 20             	add    $0x20,%eax
801031e0:	8b 00                	mov    (%eax),%eax
801031e2:	c1 e8 18             	shr    $0x18,%eax
801031e5:	eb 05                	jmp    801031ec <cpunum+0x57>
  return 0;
801031e7:	b8 00 00 00 00       	mov    $0x0,%eax
}
801031ec:	c9                   	leave  
801031ed:	c3                   	ret    

801031ee <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
801031ee:	55                   	push   %ebp
801031ef:	89 e5                	mov    %esp,%ebp
  if(lapic)
801031f1:	a1 bc 28 11 80       	mov    0x801128bc,%eax
801031f6:	85 c0                	test   %eax,%eax
801031f8:	74 0c                	je     80103206 <lapiceoi+0x18>
    lapicw(EOI, 0);
801031fa:	6a 00                	push   $0x0
801031fc:	6a 2c                	push   $0x2c
801031fe:	e8 52 fe ff ff       	call   80103055 <lapicw>
80103203:	83 c4 08             	add    $0x8,%esp
}
80103206:	90                   	nop
80103207:	c9                   	leave  
80103208:	c3                   	ret    

80103209 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80103209:	55                   	push   %ebp
8010320a:	89 e5                	mov    %esp,%ebp
}
8010320c:	90                   	nop
8010320d:	5d                   	pop    %ebp
8010320e:	c3                   	ret    

8010320f <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
8010320f:	55                   	push   %ebp
80103210:	89 e5                	mov    %esp,%ebp
80103212:	83 ec 14             	sub    $0x14,%esp
80103215:	8b 45 08             	mov    0x8(%ebp),%eax
80103218:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
8010321b:	6a 0f                	push   $0xf
8010321d:	6a 70                	push   $0x70
8010321f:	e8 02 fe ff ff       	call   80103026 <outb>
80103224:	83 c4 08             	add    $0x8,%esp
  outb(IO_RTC+1, 0x0A);
80103227:	6a 0a                	push   $0xa
80103229:	6a 71                	push   $0x71
8010322b:	e8 f6 fd ff ff       	call   80103026 <outb>
80103230:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80103233:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
8010323a:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010323d:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80103242:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103245:	83 c0 02             	add    $0x2,%eax
80103248:	8b 55 0c             	mov    0xc(%ebp),%edx
8010324b:	c1 ea 04             	shr    $0x4,%edx
8010324e:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103251:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103255:	c1 e0 18             	shl    $0x18,%eax
80103258:	50                   	push   %eax
80103259:	68 c4 00 00 00       	push   $0xc4
8010325e:	e8 f2 fd ff ff       	call   80103055 <lapicw>
80103263:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80103266:	68 00 c5 00 00       	push   $0xc500
8010326b:	68 c0 00 00 00       	push   $0xc0
80103270:	e8 e0 fd ff ff       	call   80103055 <lapicw>
80103275:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80103278:	68 c8 00 00 00       	push   $0xc8
8010327d:	e8 87 ff ff ff       	call   80103209 <microdelay>
80103282:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
80103285:	68 00 85 00 00       	push   $0x8500
8010328a:	68 c0 00 00 00       	push   $0xc0
8010328f:	e8 c1 fd ff ff       	call   80103055 <lapicw>
80103294:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80103297:	6a 64                	push   $0x64
80103299:	e8 6b ff ff ff       	call   80103209 <microdelay>
8010329e:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801032a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801032a8:	eb 3d                	jmp    801032e7 <lapicstartap+0xd8>
    lapicw(ICRHI, apicid<<24);
801032aa:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
801032ae:	c1 e0 18             	shl    $0x18,%eax
801032b1:	50                   	push   %eax
801032b2:	68 c4 00 00 00       	push   $0xc4
801032b7:	e8 99 fd ff ff       	call   80103055 <lapicw>
801032bc:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
801032bf:	8b 45 0c             	mov    0xc(%ebp),%eax
801032c2:	c1 e8 0c             	shr    $0xc,%eax
801032c5:	80 cc 06             	or     $0x6,%ah
801032c8:	50                   	push   %eax
801032c9:	68 c0 00 00 00       	push   $0xc0
801032ce:	e8 82 fd ff ff       	call   80103055 <lapicw>
801032d3:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
801032d6:	68 c8 00 00 00       	push   $0xc8
801032db:	e8 29 ff ff ff       	call   80103209 <microdelay>
801032e0:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801032e3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801032e7:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
801032eb:	7e bd                	jle    801032aa <lapicstartap+0x9b>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801032ed:	90                   	nop
801032ee:	c9                   	leave  
801032ef:	c3                   	ret    

801032f0 <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
801032f0:	55                   	push   %ebp
801032f1:	89 e5                	mov    %esp,%ebp
801032f3:	83 ec 18             	sub    $0x18,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
801032f6:	83 ec 08             	sub    $0x8,%esp
801032f9:	68 e8 b6 10 80       	push   $0x8010b6e8
801032fe:	68 c0 28 11 80       	push   $0x801128c0
80103303:	e8 46 1b 00 00       	call   80104e4e <initlock>
80103308:	83 c4 10             	add    $0x10,%esp
  readsb(ROOTDEV, &sb);
8010330b:	83 ec 08             	sub    $0x8,%esp
8010330e:	8d 45 e8             	lea    -0x18(%ebp),%eax
80103311:	50                   	push   %eax
80103312:	6a 01                	push   $0x1
80103314:	e8 3c e0 ff ff       	call   80101355 <readsb>
80103319:	83 c4 10             	add    $0x10,%esp
  log.start = sb.size - sb.nlog;
8010331c:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010331f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103322:	29 c2                	sub    %eax,%edx
80103324:	89 d0                	mov    %edx,%eax
80103326:	a3 f4 28 11 80       	mov    %eax,0x801128f4
  log.size = sb.nlog;
8010332b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010332e:	a3 f8 28 11 80       	mov    %eax,0x801128f8
  log.dev = ROOTDEV;
80103333:	c7 05 00 29 11 80 01 	movl   $0x1,0x80112900
8010333a:	00 00 00 
  recover_from_log();
8010333d:	e8 b2 01 00 00       	call   801034f4 <recover_from_log>
}
80103342:	90                   	nop
80103343:	c9                   	leave  
80103344:	c3                   	ret    

80103345 <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
80103345:	55                   	push   %ebp
80103346:	89 e5                	mov    %esp,%ebp
80103348:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010334b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103352:	e9 95 00 00 00       	jmp    801033ec <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103357:	8b 15 f4 28 11 80    	mov    0x801128f4,%edx
8010335d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103360:	01 d0                	add    %edx,%eax
80103362:	83 c0 01             	add    $0x1,%eax
80103365:	89 c2                	mov    %eax,%edx
80103367:	a1 00 29 11 80       	mov    0x80112900,%eax
8010336c:	83 ec 08             	sub    $0x8,%esp
8010336f:	52                   	push   %edx
80103370:	50                   	push   %eax
80103371:	e8 40 ce ff ff       	call   801001b6 <bread>
80103376:	83 c4 10             	add    $0x10,%esp
80103379:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
8010337c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010337f:	83 c0 10             	add    $0x10,%eax
80103382:	8b 04 85 c8 28 11 80 	mov    -0x7feed738(,%eax,4),%eax
80103389:	89 c2                	mov    %eax,%edx
8010338b:	a1 00 29 11 80       	mov    0x80112900,%eax
80103390:	83 ec 08             	sub    $0x8,%esp
80103393:	52                   	push   %edx
80103394:	50                   	push   %eax
80103395:	e8 1c ce ff ff       	call   801001b6 <bread>
8010339a:	83 c4 10             	add    $0x10,%esp
8010339d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801033a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033a3:	8d 50 18             	lea    0x18(%eax),%edx
801033a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033a9:	83 c0 18             	add    $0x18,%eax
801033ac:	83 ec 04             	sub    $0x4,%esp
801033af:	68 00 02 00 00       	push   $0x200
801033b4:	52                   	push   %edx
801033b5:	50                   	push   %eax
801033b6:	e8 d7 1d 00 00       	call   80105192 <memmove>
801033bb:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
801033be:	83 ec 0c             	sub    $0xc,%esp
801033c1:	ff 75 ec             	pushl  -0x14(%ebp)
801033c4:	e8 26 ce ff ff       	call   801001ef <bwrite>
801033c9:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf); 
801033cc:	83 ec 0c             	sub    $0xc,%esp
801033cf:	ff 75 f0             	pushl  -0x10(%ebp)
801033d2:	e8 57 ce ff ff       	call   8010022e <brelse>
801033d7:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
801033da:	83 ec 0c             	sub    $0xc,%esp
801033dd:	ff 75 ec             	pushl  -0x14(%ebp)
801033e0:	e8 49 ce ff ff       	call   8010022e <brelse>
801033e5:	83 c4 10             	add    $0x10,%esp
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801033e8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801033ec:	a1 04 29 11 80       	mov    0x80112904,%eax
801033f1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801033f4:	0f 8f 5d ff ff ff    	jg     80103357 <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
801033fa:	90                   	nop
801033fb:	c9                   	leave  
801033fc:	c3                   	ret    

801033fd <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
801033fd:	55                   	push   %ebp
801033fe:	89 e5                	mov    %esp,%ebp
80103400:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103403:	a1 f4 28 11 80       	mov    0x801128f4,%eax
80103408:	89 c2                	mov    %eax,%edx
8010340a:	a1 00 29 11 80       	mov    0x80112900,%eax
8010340f:	83 ec 08             	sub    $0x8,%esp
80103412:	52                   	push   %edx
80103413:	50                   	push   %eax
80103414:	e8 9d cd ff ff       	call   801001b6 <bread>
80103419:	83 c4 10             	add    $0x10,%esp
8010341c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
8010341f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103422:	83 c0 18             	add    $0x18,%eax
80103425:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
80103428:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010342b:	8b 00                	mov    (%eax),%eax
8010342d:	a3 04 29 11 80       	mov    %eax,0x80112904
  for (i = 0; i < log.lh.n; i++) {
80103432:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103439:	eb 1b                	jmp    80103456 <read_head+0x59>
    log.lh.sector[i] = lh->sector[i];
8010343b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010343e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103441:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103445:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103448:	83 c2 10             	add    $0x10,%edx
8010344b:	89 04 95 c8 28 11 80 	mov    %eax,-0x7feed738(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80103452:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103456:	a1 04 29 11 80       	mov    0x80112904,%eax
8010345b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010345e:	7f db                	jg     8010343b <read_head+0x3e>
    log.lh.sector[i] = lh->sector[i];
  }
  brelse(buf);
80103460:	83 ec 0c             	sub    $0xc,%esp
80103463:	ff 75 f0             	pushl  -0x10(%ebp)
80103466:	e8 c3 cd ff ff       	call   8010022e <brelse>
8010346b:	83 c4 10             	add    $0x10,%esp
}
8010346e:	90                   	nop
8010346f:	c9                   	leave  
80103470:	c3                   	ret    

80103471 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103471:	55                   	push   %ebp
80103472:	89 e5                	mov    %esp,%ebp
80103474:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103477:	a1 f4 28 11 80       	mov    0x801128f4,%eax
8010347c:	89 c2                	mov    %eax,%edx
8010347e:	a1 00 29 11 80       	mov    0x80112900,%eax
80103483:	83 ec 08             	sub    $0x8,%esp
80103486:	52                   	push   %edx
80103487:	50                   	push   %eax
80103488:	e8 29 cd ff ff       	call   801001b6 <bread>
8010348d:	83 c4 10             	add    $0x10,%esp
80103490:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
80103493:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103496:	83 c0 18             	add    $0x18,%eax
80103499:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
8010349c:	8b 15 04 29 11 80    	mov    0x80112904,%edx
801034a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034a5:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
801034a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801034ae:	eb 1b                	jmp    801034cb <write_head+0x5a>
    hb->sector[i] = log.lh.sector[i];
801034b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801034b3:	83 c0 10             	add    $0x10,%eax
801034b6:	8b 0c 85 c8 28 11 80 	mov    -0x7feed738(,%eax,4),%ecx
801034bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801034c3:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801034c7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801034cb:	a1 04 29 11 80       	mov    0x80112904,%eax
801034d0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801034d3:	7f db                	jg     801034b0 <write_head+0x3f>
    hb->sector[i] = log.lh.sector[i];
  }
  bwrite(buf);
801034d5:	83 ec 0c             	sub    $0xc,%esp
801034d8:	ff 75 f0             	pushl  -0x10(%ebp)
801034db:	e8 0f cd ff ff       	call   801001ef <bwrite>
801034e0:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
801034e3:	83 ec 0c             	sub    $0xc,%esp
801034e6:	ff 75 f0             	pushl  -0x10(%ebp)
801034e9:	e8 40 cd ff ff       	call   8010022e <brelse>
801034ee:	83 c4 10             	add    $0x10,%esp
}
801034f1:	90                   	nop
801034f2:	c9                   	leave  
801034f3:	c3                   	ret    

801034f4 <recover_from_log>:

static void
recover_from_log(void)
{
801034f4:	55                   	push   %ebp
801034f5:	89 e5                	mov    %esp,%ebp
801034f7:	83 ec 08             	sub    $0x8,%esp
  read_head();      
801034fa:	e8 fe fe ff ff       	call   801033fd <read_head>
  install_trans(); // if committed, copy from log to disk
801034ff:	e8 41 fe ff ff       	call   80103345 <install_trans>
  log.lh.n = 0;
80103504:	c7 05 04 29 11 80 00 	movl   $0x0,0x80112904
8010350b:	00 00 00 
  write_head(); // clear the log
8010350e:	e8 5e ff ff ff       	call   80103471 <write_head>
}
80103513:	90                   	nop
80103514:	c9                   	leave  
80103515:	c3                   	ret    

80103516 <begin_trans>:

void
begin_trans(void)
{
80103516:	55                   	push   %ebp
80103517:	89 e5                	mov    %esp,%ebp
80103519:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
8010351c:	83 ec 0c             	sub    $0xc,%esp
8010351f:	68 c0 28 11 80       	push   $0x801128c0
80103524:	e8 47 19 00 00       	call   80104e70 <acquire>
80103529:	83 c4 10             	add    $0x10,%esp
  while (log.busy) {
8010352c:	eb 15                	jmp    80103543 <begin_trans+0x2d>
    sleep(&log, &log.lock);
8010352e:	83 ec 08             	sub    $0x8,%esp
80103531:	68 c0 28 11 80       	push   $0x801128c0
80103536:	68 c0 28 11 80       	push   $0x801128c0
8010353b:	e8 37 16 00 00       	call   80104b77 <sleep>
80103540:	83 c4 10             	add    $0x10,%esp

void
begin_trans(void)
{
  acquire(&log.lock);
  while (log.busy) {
80103543:	a1 fc 28 11 80       	mov    0x801128fc,%eax
80103548:	85 c0                	test   %eax,%eax
8010354a:	75 e2                	jne    8010352e <begin_trans+0x18>
    sleep(&log, &log.lock);
  }
  log.busy = 1;
8010354c:	c7 05 fc 28 11 80 01 	movl   $0x1,0x801128fc
80103553:	00 00 00 
  release(&log.lock);
80103556:	83 ec 0c             	sub    $0xc,%esp
80103559:	68 c0 28 11 80       	push   $0x801128c0
8010355e:	e8 74 19 00 00       	call   80104ed7 <release>
80103563:	83 c4 10             	add    $0x10,%esp
}
80103566:	90                   	nop
80103567:	c9                   	leave  
80103568:	c3                   	ret    

80103569 <commit_trans>:

void
commit_trans(void)
{
80103569:	55                   	push   %ebp
8010356a:	89 e5                	mov    %esp,%ebp
8010356c:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
8010356f:	a1 04 29 11 80       	mov    0x80112904,%eax
80103574:	85 c0                	test   %eax,%eax
80103576:	7e 19                	jle    80103591 <commit_trans+0x28>
    write_head();    // Write header to disk -- the real commit
80103578:	e8 f4 fe ff ff       	call   80103471 <write_head>
    install_trans(); // Now install writes to home locations
8010357d:	e8 c3 fd ff ff       	call   80103345 <install_trans>
    log.lh.n = 0; 
80103582:	c7 05 04 29 11 80 00 	movl   $0x0,0x80112904
80103589:	00 00 00 
    write_head();    // Erase the transaction from the log
8010358c:	e8 e0 fe ff ff       	call   80103471 <write_head>
  }
  
  acquire(&log.lock);
80103591:	83 ec 0c             	sub    $0xc,%esp
80103594:	68 c0 28 11 80       	push   $0x801128c0
80103599:	e8 d2 18 00 00       	call   80104e70 <acquire>
8010359e:	83 c4 10             	add    $0x10,%esp
  log.busy = 0;
801035a1:	c7 05 fc 28 11 80 00 	movl   $0x0,0x801128fc
801035a8:	00 00 00 
  wakeup(&log);
801035ab:	83 ec 0c             	sub    $0xc,%esp
801035ae:	68 c0 28 11 80       	push   $0x801128c0
801035b3:	e8 aa 16 00 00       	call   80104c62 <wakeup>
801035b8:	83 c4 10             	add    $0x10,%esp
  release(&log.lock);
801035bb:	83 ec 0c             	sub    $0xc,%esp
801035be:	68 c0 28 11 80       	push   $0x801128c0
801035c3:	e8 0f 19 00 00       	call   80104ed7 <release>
801035c8:	83 c4 10             	add    $0x10,%esp
}
801035cb:	90                   	nop
801035cc:	c9                   	leave  
801035cd:	c3                   	ret    

801035ce <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801035ce:	55                   	push   %ebp
801035cf:	89 e5                	mov    %esp,%ebp
801035d1:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801035d4:	a1 04 29 11 80       	mov    0x80112904,%eax
801035d9:	83 f8 09             	cmp    $0x9,%eax
801035dc:	7f 12                	jg     801035f0 <log_write+0x22>
801035de:	a1 04 29 11 80       	mov    0x80112904,%eax
801035e3:	8b 15 f8 28 11 80    	mov    0x801128f8,%edx
801035e9:	83 ea 01             	sub    $0x1,%edx
801035ec:	39 d0                	cmp    %edx,%eax
801035ee:	7c 2a                	jl     8010361a <log_write+0x4c>
  {
      cprintf("%d %d\n", log.lh.n, log.size);
801035f0:	8b 15 f8 28 11 80    	mov    0x801128f8,%edx
801035f6:	a1 04 29 11 80       	mov    0x80112904,%eax
801035fb:	83 ec 04             	sub    $0x4,%esp
801035fe:	52                   	push   %edx
801035ff:	50                   	push   %eax
80103600:	68 ec b6 10 80       	push   $0x8010b6ec
80103605:	e8 bc cd ff ff       	call   801003c6 <cprintf>
8010360a:	83 c4 10             	add    $0x10,%esp
      panic("too big a transaction");
8010360d:	83 ec 0c             	sub    $0xc,%esp
80103610:	68 f3 b6 10 80       	push   $0x8010b6f3
80103615:	e8 4c cf ff ff       	call   80100566 <panic>
  }
  if (!log.busy)
8010361a:	a1 fc 28 11 80       	mov    0x801128fc,%eax
8010361f:	85 c0                	test   %eax,%eax
80103621:	75 0d                	jne    80103630 <log_write+0x62>
    panic("write outside of trans");
80103623:	83 ec 0c             	sub    $0xc,%esp
80103626:	68 09 b7 10 80       	push   $0x8010b709
8010362b:	e8 36 cf ff ff       	call   80100566 <panic>

  for (i = 0; i < log.lh.n; i++) {
80103630:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103637:	eb 1d                	jmp    80103656 <log_write+0x88>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
80103639:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010363c:	83 c0 10             	add    $0x10,%eax
8010363f:	8b 04 85 c8 28 11 80 	mov    -0x7feed738(,%eax,4),%eax
80103646:	89 c2                	mov    %eax,%edx
80103648:	8b 45 08             	mov    0x8(%ebp),%eax
8010364b:	8b 40 08             	mov    0x8(%eax),%eax
8010364e:	39 c2                	cmp    %eax,%edx
80103650:	74 10                	je     80103662 <log_write+0x94>
      panic("too big a transaction");
  }
  if (!log.busy)
    panic("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
80103652:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103656:	a1 04 29 11 80       	mov    0x80112904,%eax
8010365b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010365e:	7f d9                	jg     80103639 <log_write+0x6b>
80103660:	eb 01                	jmp    80103663 <log_write+0x95>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
      break;
80103662:	90                   	nop
  }
  log.lh.sector[i] = b->sector;
80103663:	8b 45 08             	mov    0x8(%ebp),%eax
80103666:	8b 40 08             	mov    0x8(%eax),%eax
80103669:	89 c2                	mov    %eax,%edx
8010366b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010366e:	83 c0 10             	add    $0x10,%eax
80103671:	89 14 85 c8 28 11 80 	mov    %edx,-0x7feed738(,%eax,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
80103678:	8b 15 f4 28 11 80    	mov    0x801128f4,%edx
8010367e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103681:	01 d0                	add    %edx,%eax
80103683:	83 c0 01             	add    $0x1,%eax
80103686:	89 c2                	mov    %eax,%edx
80103688:	8b 45 08             	mov    0x8(%ebp),%eax
8010368b:	8b 40 04             	mov    0x4(%eax),%eax
8010368e:	83 ec 08             	sub    $0x8,%esp
80103691:	52                   	push   %edx
80103692:	50                   	push   %eax
80103693:	e8 1e cb ff ff       	call   801001b6 <bread>
80103698:	83 c4 10             	add    $0x10,%esp
8010369b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(lbuf->data, b->data, BSIZE);
8010369e:	8b 45 08             	mov    0x8(%ebp),%eax
801036a1:	8d 50 18             	lea    0x18(%eax),%edx
801036a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036a7:	83 c0 18             	add    $0x18,%eax
801036aa:	83 ec 04             	sub    $0x4,%esp
801036ad:	68 00 02 00 00       	push   $0x200
801036b2:	52                   	push   %edx
801036b3:	50                   	push   %eax
801036b4:	e8 d9 1a 00 00       	call   80105192 <memmove>
801036b9:	83 c4 10             	add    $0x10,%esp
  bwrite(lbuf);
801036bc:	83 ec 0c             	sub    $0xc,%esp
801036bf:	ff 75 f0             	pushl  -0x10(%ebp)
801036c2:	e8 28 cb ff ff       	call   801001ef <bwrite>
801036c7:	83 c4 10             	add    $0x10,%esp
  brelse(lbuf);
801036ca:	83 ec 0c             	sub    $0xc,%esp
801036cd:	ff 75 f0             	pushl  -0x10(%ebp)
801036d0:	e8 59 cb ff ff       	call   8010022e <brelse>
801036d5:	83 c4 10             	add    $0x10,%esp
  if (i == log.lh.n)
801036d8:	a1 04 29 11 80       	mov    0x80112904,%eax
801036dd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801036e0:	75 0d                	jne    801036ef <log_write+0x121>
    log.lh.n++;
801036e2:	a1 04 29 11 80       	mov    0x80112904,%eax
801036e7:	83 c0 01             	add    $0x1,%eax
801036ea:	a3 04 29 11 80       	mov    %eax,0x80112904
  b->flags |= B_DIRTY; // XXX prevent eviction
801036ef:	8b 45 08             	mov    0x8(%ebp),%eax
801036f2:	8b 00                	mov    (%eax),%eax
801036f4:	83 c8 04             	or     $0x4,%eax
801036f7:	89 c2                	mov    %eax,%edx
801036f9:	8b 45 08             	mov    0x8(%ebp),%eax
801036fc:	89 10                	mov    %edx,(%eax)
}
801036fe:	90                   	nop
801036ff:	c9                   	leave  
80103700:	c3                   	ret    

80103701 <v2p>:
80103701:	55                   	push   %ebp
80103702:	89 e5                	mov    %esp,%ebp
80103704:	8b 45 08             	mov    0x8(%ebp),%eax
80103707:	05 00 00 00 80       	add    $0x80000000,%eax
8010370c:	5d                   	pop    %ebp
8010370d:	c3                   	ret    

8010370e <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
8010370e:	55                   	push   %ebp
8010370f:	89 e5                	mov    %esp,%ebp
80103711:	8b 45 08             	mov    0x8(%ebp),%eax
80103714:	05 00 00 00 80       	add    $0x80000000,%eax
80103719:	5d                   	pop    %ebp
8010371a:	c3                   	ret    

8010371b <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
8010371b:	55                   	push   %ebp
8010371c:	89 e5                	mov    %esp,%ebp
8010371e:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103721:	8b 55 08             	mov    0x8(%ebp),%edx
80103724:	8b 45 0c             	mov    0xc(%ebp),%eax
80103727:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010372a:	f0 87 02             	lock xchg %eax,(%edx)
8010372d:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80103730:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103733:	c9                   	leave  
80103734:	c3                   	ret    

80103735 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103735:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103739:	83 e4 f0             	and    $0xfffffff0,%esp
8010373c:	ff 71 fc             	pushl  -0x4(%ecx)
8010373f:	55                   	push   %ebp
80103740:	89 e5                	mov    %esp,%ebp
80103742:	51                   	push   %ecx
80103743:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103746:	83 ec 08             	sub    $0x8,%esp
80103749:	68 00 00 40 80       	push   $0x80400000
8010374e:	68 e0 ba 15 80       	push   $0x8015bae0
80103753:	e8 71 f4 ff ff       	call   80102bc9 <kinit1>
80103758:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
8010375b:	e8 97 44 00 00       	call   80107bf7 <kvmalloc>
  mpinit();        // collect info about this machine
80103760:	e8 4d 04 00 00       	call   80103bb2 <mpinit>
  lapicinit();
80103765:	e8 0d f9 ff ff       	call   80103077 <lapicinit>
  seginit();       // set up segments
8010376a:	e8 31 3e 00 00       	call   801075a0 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
8010376f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103775:	0f b6 00             	movzbl (%eax),%eax
80103778:	0f b6 c0             	movzbl %al,%eax
8010377b:	83 ec 08             	sub    $0x8,%esp
8010377e:	50                   	push   %eax
8010377f:	68 20 b7 10 80       	push   $0x8010b720
80103784:	e8 3d cc ff ff       	call   801003c6 <cprintf>
80103789:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
8010378c:	e8 77 06 00 00       	call   80103e08 <picinit>
  ioapicinit();    // another interrupt controller
80103791:	e8 28 f3 ff ff       	call   80102abe <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
80103796:	e8 4e d3 ff ff       	call   80100ae9 <consoleinit>
  uartinit();      // serial port
8010379b:	e8 5c 31 00 00       	call   801068fc <uartinit>
  pinit();         // process table
801037a0:	e8 60 0b 00 00       	call   80104305 <pinit>
  tvinit();        // trap vectors
801037a5:	e8 17 2d 00 00       	call   801064c1 <tvinit>
  binit();         // buffer cache
801037aa:	e8 85 c8 ff ff       	call   80100034 <binit>
  fileinit();      // file table
801037af:	e8 92 d7 ff ff       	call   80100f46 <fileinit>
  iinit();         // inode cache
801037b4:	e8 6b de ff ff       	call   80101624 <iinit>
  ideinit();       // disk
801037b9:	e8 44 ef ff ff       	call   80102702 <ideinit>
  if(!ismp)
801037be:	a1 44 29 11 80       	mov    0x80112944,%eax
801037c3:	85 c0                	test   %eax,%eax
801037c5:	75 05                	jne    801037cc <main+0x97>
    timerinit();   // uniprocessor timer
801037c7:	e8 52 2c 00 00       	call   8010641e <timerinit>
  startothers();   // start other processors
801037cc:	e8 84 00 00 00       	call   80103855 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801037d1:	83 ec 08             	sub    $0x8,%esp
801037d4:	68 00 00 00 8e       	push   $0x8e000000
801037d9:	68 00 00 40 80       	push   $0x80400000
801037de:	e8 1f f4 ff ff       	call   80102c02 <kinit2>
801037e3:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
801037e6:	e8 3e 0c 00 00       	call   80104429 <userinit>
    
  //InitHandle();
  APGuiInit();
801037eb:	e8 47 65 00 00       	call   80109d37 <APGuiInit>
    
  // Finish setting up this processor in mpmain.
  mpmain();
801037f0:	e8 1a 00 00 00       	call   8010380f <mpmain>

801037f5 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801037f5:	55                   	push   %ebp
801037f6:	89 e5                	mov    %esp,%ebp
801037f8:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
801037fb:	e8 0f 44 00 00       	call   80107c0f <switchkvm>
  seginit();
80103800:	e8 9b 3d 00 00       	call   801075a0 <seginit>
  lapicinit();
80103805:	e8 6d f8 ff ff       	call   80103077 <lapicinit>
  mpmain();
8010380a:	e8 00 00 00 00       	call   8010380f <mpmain>

8010380f <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
8010380f:	55                   	push   %ebp
80103810:	89 e5                	mov    %esp,%ebp
80103812:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
80103815:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010381b:	0f b6 00             	movzbl (%eax),%eax
8010381e:	0f b6 c0             	movzbl %al,%eax
80103821:	83 ec 08             	sub    $0x8,%esp
80103824:	50                   	push   %eax
80103825:	68 37 b7 10 80       	push   $0x8010b737
8010382a:	e8 97 cb ff ff       	call   801003c6 <cprintf>
8010382f:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
80103832:	e8 00 2e 00 00       	call   80106637 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103837:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010383d:	05 a8 00 00 00       	add    $0xa8,%eax
80103842:	83 ec 08             	sub    $0x8,%esp
80103845:	6a 01                	push   $0x1
80103847:	50                   	push   %eax
80103848:	e8 ce fe ff ff       	call   8010371b <xchg>
8010384d:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
80103850:	e8 55 11 00 00       	call   801049aa <scheduler>

80103855 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103855:	55                   	push   %ebp
80103856:	89 e5                	mov    %esp,%ebp
80103858:	53                   	push   %ebx
80103859:	83 ec 14             	sub    $0x14,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
8010385c:	68 00 70 00 00       	push   $0x7000
80103861:	e8 a8 fe ff ff       	call   8010370e <p2v>
80103866:	83 c4 04             	add    $0x4,%esp
80103869:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
8010386c:	b8 8a 00 00 00       	mov    $0x8a,%eax
80103871:	83 ec 04             	sub    $0x4,%esp
80103874:	50                   	push   %eax
80103875:	68 34 e5 10 80       	push   $0x8010e534
8010387a:	ff 75 f0             	pushl  -0x10(%ebp)
8010387d:	e8 10 19 00 00       	call   80105192 <memmove>
80103882:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80103885:	c7 45 f4 60 29 11 80 	movl   $0x80112960,-0xc(%ebp)
8010388c:	e9 90 00 00 00       	jmp    80103921 <startothers+0xcc>
    if(c == cpus+cpunum())  // We've started already.
80103891:	e8 ff f8 ff ff       	call   80103195 <cpunum>
80103896:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010389c:	05 60 29 11 80       	add    $0x80112960,%eax
801038a1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801038a4:	74 73                	je     80103919 <startothers+0xc4>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801038a6:	e8 55 f4 ff ff       	call   80102d00 <kalloc>
801038ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
801038ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038b1:	83 e8 04             	sub    $0x4,%eax
801038b4:	8b 55 ec             	mov    -0x14(%ebp),%edx
801038b7:	81 c2 00 10 00 00    	add    $0x1000,%edx
801038bd:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
801038bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038c2:	83 e8 08             	sub    $0x8,%eax
801038c5:	c7 00 f5 37 10 80    	movl   $0x801037f5,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
801038cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038ce:	8d 58 f4             	lea    -0xc(%eax),%ebx
801038d1:	83 ec 0c             	sub    $0xc,%esp
801038d4:	68 00 d0 10 80       	push   $0x8010d000
801038d9:	e8 23 fe ff ff       	call   80103701 <v2p>
801038de:	83 c4 10             	add    $0x10,%esp
801038e1:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
801038e3:	83 ec 0c             	sub    $0xc,%esp
801038e6:	ff 75 f0             	pushl  -0x10(%ebp)
801038e9:	e8 13 fe ff ff       	call   80103701 <v2p>
801038ee:	83 c4 10             	add    $0x10,%esp
801038f1:	89 c2                	mov    %eax,%edx
801038f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038f6:	0f b6 00             	movzbl (%eax),%eax
801038f9:	0f b6 c0             	movzbl %al,%eax
801038fc:	83 ec 08             	sub    $0x8,%esp
801038ff:	52                   	push   %edx
80103900:	50                   	push   %eax
80103901:	e8 09 f9 ff ff       	call   8010320f <lapicstartap>
80103906:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103909:	90                   	nop
8010390a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010390d:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103913:	85 c0                	test   %eax,%eax
80103915:	74 f3                	je     8010390a <startothers+0xb5>
80103917:	eb 01                	jmp    8010391a <startothers+0xc5>
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
80103919:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010391a:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103921:	a1 40 2f 11 80       	mov    0x80112f40,%eax
80103926:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010392c:	05 60 29 11 80       	add    $0x80112960,%eax
80103931:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103934:	0f 87 57 ff ff ff    	ja     80103891 <startothers+0x3c>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
8010393a:	90                   	nop
8010393b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010393e:	c9                   	leave  
8010393f:	c3                   	ret    

80103940 <p2v>:
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	8b 45 08             	mov    0x8(%ebp),%eax
80103946:	05 00 00 00 80       	add    $0x80000000,%eax
8010394b:	5d                   	pop    %ebp
8010394c:	c3                   	ret    

8010394d <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
8010394d:	55                   	push   %ebp
8010394e:	89 e5                	mov    %esp,%ebp
80103950:	83 ec 14             	sub    $0x14,%esp
80103953:	8b 45 08             	mov    0x8(%ebp),%eax
80103956:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010395a:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
8010395e:	89 c2                	mov    %eax,%edx
80103960:	ec                   	in     (%dx),%al
80103961:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103964:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103968:	c9                   	leave  
80103969:	c3                   	ret    

8010396a <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
8010396a:	55                   	push   %ebp
8010396b:	89 e5                	mov    %esp,%ebp
8010396d:	83 ec 08             	sub    $0x8,%esp
80103970:	8b 55 08             	mov    0x8(%ebp),%edx
80103973:	8b 45 0c             	mov    0xc(%ebp),%eax
80103976:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010397a:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010397d:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103981:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103985:	ee                   	out    %al,(%dx)
}
80103986:	90                   	nop
80103987:	c9                   	leave  
80103988:	c3                   	ret    

80103989 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103989:	55                   	push   %ebp
8010398a:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
8010398c:	a1 68 e6 10 80       	mov    0x8010e668,%eax
80103991:	89 c2                	mov    %eax,%edx
80103993:	b8 60 29 11 80       	mov    $0x80112960,%eax
80103998:	29 c2                	sub    %eax,%edx
8010399a:	89 d0                	mov    %edx,%eax
8010399c:	c1 f8 02             	sar    $0x2,%eax
8010399f:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
801039a5:	5d                   	pop    %ebp
801039a6:	c3                   	ret    

801039a7 <sum>:

static uchar
sum(uchar *addr, int len)
{
801039a7:	55                   	push   %ebp
801039a8:	89 e5                	mov    %esp,%ebp
801039aa:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
801039ad:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
801039b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801039bb:	eb 15                	jmp    801039d2 <sum+0x2b>
    sum += addr[i];
801039bd:	8b 55 fc             	mov    -0x4(%ebp),%edx
801039c0:	8b 45 08             	mov    0x8(%ebp),%eax
801039c3:	01 d0                	add    %edx,%eax
801039c5:	0f b6 00             	movzbl (%eax),%eax
801039c8:	0f b6 c0             	movzbl %al,%eax
801039cb:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
801039ce:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801039d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
801039d5:	3b 45 0c             	cmp    0xc(%ebp),%eax
801039d8:	7c e3                	jl     801039bd <sum+0x16>
    sum += addr[i];
  return sum;
801039da:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
801039dd:	c9                   	leave  
801039de:	c3                   	ret    

801039df <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801039df:	55                   	push   %ebp
801039e0:	89 e5                	mov    %esp,%ebp
801039e2:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
801039e5:	ff 75 08             	pushl  0x8(%ebp)
801039e8:	e8 53 ff ff ff       	call   80103940 <p2v>
801039ed:	83 c4 04             	add    $0x4,%esp
801039f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
801039f3:	8b 55 0c             	mov    0xc(%ebp),%edx
801039f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039f9:	01 d0                	add    %edx,%eax
801039fb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
801039fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a01:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103a04:	eb 36                	jmp    80103a3c <mpsearch1+0x5d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103a06:	83 ec 04             	sub    $0x4,%esp
80103a09:	6a 04                	push   $0x4
80103a0b:	68 48 b7 10 80       	push   $0x8010b748
80103a10:	ff 75 f4             	pushl  -0xc(%ebp)
80103a13:	e8 22 17 00 00       	call   8010513a <memcmp>
80103a18:	83 c4 10             	add    $0x10,%esp
80103a1b:	85 c0                	test   %eax,%eax
80103a1d:	75 19                	jne    80103a38 <mpsearch1+0x59>
80103a1f:	83 ec 08             	sub    $0x8,%esp
80103a22:	6a 10                	push   $0x10
80103a24:	ff 75 f4             	pushl  -0xc(%ebp)
80103a27:	e8 7b ff ff ff       	call   801039a7 <sum>
80103a2c:	83 c4 10             	add    $0x10,%esp
80103a2f:	84 c0                	test   %al,%al
80103a31:	75 05                	jne    80103a38 <mpsearch1+0x59>
      return (struct mp*)p;
80103a33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a36:	eb 11                	jmp    80103a49 <mpsearch1+0x6a>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103a38:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103a3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a3f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103a42:	72 c2                	jb     80103a06 <mpsearch1+0x27>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103a44:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103a49:	c9                   	leave  
80103a4a:	c3                   	ret    

80103a4b <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103a4b:	55                   	push   %ebp
80103a4c:	89 e5                	mov    %esp,%ebp
80103a4e:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103a51:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103a58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a5b:	83 c0 0f             	add    $0xf,%eax
80103a5e:	0f b6 00             	movzbl (%eax),%eax
80103a61:	0f b6 c0             	movzbl %al,%eax
80103a64:	c1 e0 08             	shl    $0x8,%eax
80103a67:	89 c2                	mov    %eax,%edx
80103a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a6c:	83 c0 0e             	add    $0xe,%eax
80103a6f:	0f b6 00             	movzbl (%eax),%eax
80103a72:	0f b6 c0             	movzbl %al,%eax
80103a75:	09 d0                	or     %edx,%eax
80103a77:	c1 e0 04             	shl    $0x4,%eax
80103a7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103a7d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103a81:	74 21                	je     80103aa4 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103a83:	83 ec 08             	sub    $0x8,%esp
80103a86:	68 00 04 00 00       	push   $0x400
80103a8b:	ff 75 f0             	pushl  -0x10(%ebp)
80103a8e:	e8 4c ff ff ff       	call   801039df <mpsearch1>
80103a93:	83 c4 10             	add    $0x10,%esp
80103a96:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103a99:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103a9d:	74 51                	je     80103af0 <mpsearch+0xa5>
      return mp;
80103a9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103aa2:	eb 61                	jmp    80103b05 <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103aa4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103aa7:	83 c0 14             	add    $0x14,%eax
80103aaa:	0f b6 00             	movzbl (%eax),%eax
80103aad:	0f b6 c0             	movzbl %al,%eax
80103ab0:	c1 e0 08             	shl    $0x8,%eax
80103ab3:	89 c2                	mov    %eax,%edx
80103ab5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ab8:	83 c0 13             	add    $0x13,%eax
80103abb:	0f b6 00             	movzbl (%eax),%eax
80103abe:	0f b6 c0             	movzbl %al,%eax
80103ac1:	09 d0                	or     %edx,%eax
80103ac3:	c1 e0 0a             	shl    $0xa,%eax
80103ac6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103ac9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103acc:	2d 00 04 00 00       	sub    $0x400,%eax
80103ad1:	83 ec 08             	sub    $0x8,%esp
80103ad4:	68 00 04 00 00       	push   $0x400
80103ad9:	50                   	push   %eax
80103ada:	e8 00 ff ff ff       	call   801039df <mpsearch1>
80103adf:	83 c4 10             	add    $0x10,%esp
80103ae2:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103ae5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103ae9:	74 05                	je     80103af0 <mpsearch+0xa5>
      return mp;
80103aeb:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103aee:	eb 15                	jmp    80103b05 <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80103af0:	83 ec 08             	sub    $0x8,%esp
80103af3:	68 00 00 01 00       	push   $0x10000
80103af8:	68 00 00 0f 00       	push   $0xf0000
80103afd:	e8 dd fe ff ff       	call   801039df <mpsearch1>
80103b02:	83 c4 10             	add    $0x10,%esp
}
80103b05:	c9                   	leave  
80103b06:	c3                   	ret    

80103b07 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103b07:	55                   	push   %ebp
80103b08:	89 e5                	mov    %esp,%ebp
80103b0a:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103b0d:	e8 39 ff ff ff       	call   80103a4b <mpsearch>
80103b12:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103b15:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103b19:	74 0a                	je     80103b25 <mpconfig+0x1e>
80103b1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b1e:	8b 40 04             	mov    0x4(%eax),%eax
80103b21:	85 c0                	test   %eax,%eax
80103b23:	75 0a                	jne    80103b2f <mpconfig+0x28>
    return 0;
80103b25:	b8 00 00 00 00       	mov    $0x0,%eax
80103b2a:	e9 81 00 00 00       	jmp    80103bb0 <mpconfig+0xa9>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103b2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b32:	8b 40 04             	mov    0x4(%eax),%eax
80103b35:	83 ec 0c             	sub    $0xc,%esp
80103b38:	50                   	push   %eax
80103b39:	e8 02 fe ff ff       	call   80103940 <p2v>
80103b3e:	83 c4 10             	add    $0x10,%esp
80103b41:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103b44:	83 ec 04             	sub    $0x4,%esp
80103b47:	6a 04                	push   $0x4
80103b49:	68 4d b7 10 80       	push   $0x8010b74d
80103b4e:	ff 75 f0             	pushl  -0x10(%ebp)
80103b51:	e8 e4 15 00 00       	call   8010513a <memcmp>
80103b56:	83 c4 10             	add    $0x10,%esp
80103b59:	85 c0                	test   %eax,%eax
80103b5b:	74 07                	je     80103b64 <mpconfig+0x5d>
    return 0;
80103b5d:	b8 00 00 00 00       	mov    $0x0,%eax
80103b62:	eb 4c                	jmp    80103bb0 <mpconfig+0xa9>
  if(conf->version != 1 && conf->version != 4)
80103b64:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b67:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103b6b:	3c 01                	cmp    $0x1,%al
80103b6d:	74 12                	je     80103b81 <mpconfig+0x7a>
80103b6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b72:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103b76:	3c 04                	cmp    $0x4,%al
80103b78:	74 07                	je     80103b81 <mpconfig+0x7a>
    return 0;
80103b7a:	b8 00 00 00 00       	mov    $0x0,%eax
80103b7f:	eb 2f                	jmp    80103bb0 <mpconfig+0xa9>
  if(sum((uchar*)conf, conf->length) != 0)
80103b81:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b84:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103b88:	0f b7 c0             	movzwl %ax,%eax
80103b8b:	83 ec 08             	sub    $0x8,%esp
80103b8e:	50                   	push   %eax
80103b8f:	ff 75 f0             	pushl  -0x10(%ebp)
80103b92:	e8 10 fe ff ff       	call   801039a7 <sum>
80103b97:	83 c4 10             	add    $0x10,%esp
80103b9a:	84 c0                	test   %al,%al
80103b9c:	74 07                	je     80103ba5 <mpconfig+0x9e>
    return 0;
80103b9e:	b8 00 00 00 00       	mov    $0x0,%eax
80103ba3:	eb 0b                	jmp    80103bb0 <mpconfig+0xa9>
  *pmp = mp;
80103ba5:	8b 45 08             	mov    0x8(%ebp),%eax
80103ba8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103bab:	89 10                	mov    %edx,(%eax)
  return conf;
80103bad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103bb0:	c9                   	leave  
80103bb1:	c3                   	ret    

80103bb2 <mpinit>:

void
mpinit(void)
{
80103bb2:	55                   	push   %ebp
80103bb3:	89 e5                	mov    %esp,%ebp
80103bb5:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103bb8:	c7 05 68 e6 10 80 60 	movl   $0x80112960,0x8010e668
80103bbf:	29 11 80 
  if((conf = mpconfig(&mp)) == 0)
80103bc2:	83 ec 0c             	sub    $0xc,%esp
80103bc5:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103bc8:	50                   	push   %eax
80103bc9:	e8 39 ff ff ff       	call   80103b07 <mpconfig>
80103bce:	83 c4 10             	add    $0x10,%esp
80103bd1:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103bd4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103bd8:	0f 84 96 01 00 00    	je     80103d74 <mpinit+0x1c2>
    return;
  ismp = 1;
80103bde:	c7 05 44 29 11 80 01 	movl   $0x1,0x80112944
80103be5:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103be8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103beb:	8b 40 24             	mov    0x24(%eax),%eax
80103bee:	a3 bc 28 11 80       	mov    %eax,0x801128bc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103bf3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bf6:	83 c0 2c             	add    $0x2c,%eax
80103bf9:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103bfc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bff:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103c03:	0f b7 d0             	movzwl %ax,%edx
80103c06:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c09:	01 d0                	add    %edx,%eax
80103c0b:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c0e:	e9 f2 00 00 00       	jmp    80103d05 <mpinit+0x153>
    switch(*p){
80103c13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c16:	0f b6 00             	movzbl (%eax),%eax
80103c19:	0f b6 c0             	movzbl %al,%eax
80103c1c:	83 f8 04             	cmp    $0x4,%eax
80103c1f:	0f 87 bc 00 00 00    	ja     80103ce1 <mpinit+0x12f>
80103c25:	8b 04 85 90 b7 10 80 	mov    -0x7fef4870(,%eax,4),%eax
80103c2c:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103c2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c31:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103c34:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103c37:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103c3b:	0f b6 d0             	movzbl %al,%edx
80103c3e:	a1 40 2f 11 80       	mov    0x80112f40,%eax
80103c43:	39 c2                	cmp    %eax,%edx
80103c45:	74 2b                	je     80103c72 <mpinit+0xc0>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103c47:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103c4a:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103c4e:	0f b6 d0             	movzbl %al,%edx
80103c51:	a1 40 2f 11 80       	mov    0x80112f40,%eax
80103c56:	83 ec 04             	sub    $0x4,%esp
80103c59:	52                   	push   %edx
80103c5a:	50                   	push   %eax
80103c5b:	68 52 b7 10 80       	push   $0x8010b752
80103c60:	e8 61 c7 ff ff       	call   801003c6 <cprintf>
80103c65:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
80103c68:	c7 05 44 29 11 80 00 	movl   $0x0,0x80112944
80103c6f:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103c72:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103c75:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103c79:	0f b6 c0             	movzbl %al,%eax
80103c7c:	83 e0 02             	and    $0x2,%eax
80103c7f:	85 c0                	test   %eax,%eax
80103c81:	74 15                	je     80103c98 <mpinit+0xe6>
        bcpu = &cpus[ncpu];
80103c83:	a1 40 2f 11 80       	mov    0x80112f40,%eax
80103c88:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103c8e:	05 60 29 11 80       	add    $0x80112960,%eax
80103c93:	a3 68 e6 10 80       	mov    %eax,0x8010e668
      cpus[ncpu].id = ncpu;
80103c98:	a1 40 2f 11 80       	mov    0x80112f40,%eax
80103c9d:	8b 15 40 2f 11 80    	mov    0x80112f40,%edx
80103ca3:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103ca9:	05 60 29 11 80       	add    $0x80112960,%eax
80103cae:	88 10                	mov    %dl,(%eax)
      ncpu++;
80103cb0:	a1 40 2f 11 80       	mov    0x80112f40,%eax
80103cb5:	83 c0 01             	add    $0x1,%eax
80103cb8:	a3 40 2f 11 80       	mov    %eax,0x80112f40
      p += sizeof(struct mpproc);
80103cbd:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103cc1:	eb 42                	jmp    80103d05 <mpinit+0x153>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103cc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cc6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103cc9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103ccc:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103cd0:	a2 40 29 11 80       	mov    %al,0x80112940
      p += sizeof(struct mpioapic);
80103cd5:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103cd9:	eb 2a                	jmp    80103d05 <mpinit+0x153>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103cdb:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103cdf:	eb 24                	jmp    80103d05 <mpinit+0x153>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103ce1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ce4:	0f b6 00             	movzbl (%eax),%eax
80103ce7:	0f b6 c0             	movzbl %al,%eax
80103cea:	83 ec 08             	sub    $0x8,%esp
80103ced:	50                   	push   %eax
80103cee:	68 70 b7 10 80       	push   $0x8010b770
80103cf3:	e8 ce c6 ff ff       	call   801003c6 <cprintf>
80103cf8:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
80103cfb:	c7 05 44 29 11 80 00 	movl   $0x0,0x80112944
80103d02:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103d05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d08:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103d0b:	0f 82 02 ff ff ff    	jb     80103c13 <mpinit+0x61>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103d11:	a1 44 29 11 80       	mov    0x80112944,%eax
80103d16:	85 c0                	test   %eax,%eax
80103d18:	75 1d                	jne    80103d37 <mpinit+0x185>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103d1a:	c7 05 40 2f 11 80 01 	movl   $0x1,0x80112f40
80103d21:	00 00 00 
    lapic = 0;
80103d24:	c7 05 bc 28 11 80 00 	movl   $0x0,0x801128bc
80103d2b:	00 00 00 
    ioapicid = 0;
80103d2e:	c6 05 40 29 11 80 00 	movb   $0x0,0x80112940
    return;
80103d35:	eb 3e                	jmp    80103d75 <mpinit+0x1c3>
  }

  if(mp->imcrp){
80103d37:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103d3a:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103d3e:	84 c0                	test   %al,%al
80103d40:	74 33                	je     80103d75 <mpinit+0x1c3>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103d42:	83 ec 08             	sub    $0x8,%esp
80103d45:	6a 70                	push   $0x70
80103d47:	6a 22                	push   $0x22
80103d49:	e8 1c fc ff ff       	call   8010396a <outb>
80103d4e:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103d51:	83 ec 0c             	sub    $0xc,%esp
80103d54:	6a 23                	push   $0x23
80103d56:	e8 f2 fb ff ff       	call   8010394d <inb>
80103d5b:	83 c4 10             	add    $0x10,%esp
80103d5e:	83 c8 01             	or     $0x1,%eax
80103d61:	0f b6 c0             	movzbl %al,%eax
80103d64:	83 ec 08             	sub    $0x8,%esp
80103d67:	50                   	push   %eax
80103d68:	6a 23                	push   $0x23
80103d6a:	e8 fb fb ff ff       	call   8010396a <outb>
80103d6f:	83 c4 10             	add    $0x10,%esp
80103d72:	eb 01                	jmp    80103d75 <mpinit+0x1c3>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
80103d74:	90                   	nop
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103d75:	c9                   	leave  
80103d76:	c3                   	ret    

80103d77 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103d77:	55                   	push   %ebp
80103d78:	89 e5                	mov    %esp,%ebp
80103d7a:	83 ec 08             	sub    $0x8,%esp
80103d7d:	8b 55 08             	mov    0x8(%ebp),%edx
80103d80:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d83:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103d87:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103d8a:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103d8e:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103d92:	ee                   	out    %al,(%dx)
}
80103d93:	90                   	nop
80103d94:	c9                   	leave  
80103d95:	c3                   	ret    

80103d96 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103d96:	55                   	push   %ebp
80103d97:	89 e5                	mov    %esp,%ebp
80103d99:	83 ec 04             	sub    $0x4,%esp
80103d9c:	8b 45 08             	mov    0x8(%ebp),%eax
80103d9f:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103da3:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103da7:	66 a3 00 e0 10 80    	mov    %ax,0x8010e000
  outb(IO_PIC1+1, mask);
80103dad:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103db1:	0f b6 c0             	movzbl %al,%eax
80103db4:	50                   	push   %eax
80103db5:	6a 21                	push   $0x21
80103db7:	e8 bb ff ff ff       	call   80103d77 <outb>
80103dbc:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80103dbf:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103dc3:	66 c1 e8 08          	shr    $0x8,%ax
80103dc7:	0f b6 c0             	movzbl %al,%eax
80103dca:	50                   	push   %eax
80103dcb:	68 a1 00 00 00       	push   $0xa1
80103dd0:	e8 a2 ff ff ff       	call   80103d77 <outb>
80103dd5:	83 c4 08             	add    $0x8,%esp
}
80103dd8:	90                   	nop
80103dd9:	c9                   	leave  
80103dda:	c3                   	ret    

80103ddb <picenable>:

void
picenable(int irq)
{
80103ddb:	55                   	push   %ebp
80103ddc:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80103dde:	8b 45 08             	mov    0x8(%ebp),%eax
80103de1:	ba 01 00 00 00       	mov    $0x1,%edx
80103de6:	89 c1                	mov    %eax,%ecx
80103de8:	d3 e2                	shl    %cl,%edx
80103dea:	89 d0                	mov    %edx,%eax
80103dec:	f7 d0                	not    %eax
80103dee:	89 c2                	mov    %eax,%edx
80103df0:	0f b7 05 00 e0 10 80 	movzwl 0x8010e000,%eax
80103df7:	21 d0                	and    %edx,%eax
80103df9:	0f b7 c0             	movzwl %ax,%eax
80103dfc:	50                   	push   %eax
80103dfd:	e8 94 ff ff ff       	call   80103d96 <picsetmask>
80103e02:	83 c4 04             	add    $0x4,%esp
}
80103e05:	90                   	nop
80103e06:	c9                   	leave  
80103e07:	c3                   	ret    

80103e08 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103e08:	55                   	push   %ebp
80103e09:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103e0b:	68 ff 00 00 00       	push   $0xff
80103e10:	6a 21                	push   $0x21
80103e12:	e8 60 ff ff ff       	call   80103d77 <outb>
80103e17:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80103e1a:	68 ff 00 00 00       	push   $0xff
80103e1f:	68 a1 00 00 00       	push   $0xa1
80103e24:	e8 4e ff ff ff       	call   80103d77 <outb>
80103e29:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103e2c:	6a 11                	push   $0x11
80103e2e:	6a 20                	push   $0x20
80103e30:	e8 42 ff ff ff       	call   80103d77 <outb>
80103e35:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103e38:	6a 20                	push   $0x20
80103e3a:	6a 21                	push   $0x21
80103e3c:	e8 36 ff ff ff       	call   80103d77 <outb>
80103e41:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103e44:	6a 04                	push   $0x4
80103e46:	6a 21                	push   $0x21
80103e48:	e8 2a ff ff ff       	call   80103d77 <outb>
80103e4d:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103e50:	6a 03                	push   $0x3
80103e52:	6a 21                	push   $0x21
80103e54:	e8 1e ff ff ff       	call   80103d77 <outb>
80103e59:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103e5c:	6a 11                	push   $0x11
80103e5e:	68 a0 00 00 00       	push   $0xa0
80103e63:	e8 0f ff ff ff       	call   80103d77 <outb>
80103e68:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103e6b:	6a 28                	push   $0x28
80103e6d:	68 a1 00 00 00       	push   $0xa1
80103e72:	e8 00 ff ff ff       	call   80103d77 <outb>
80103e77:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103e7a:	6a 02                	push   $0x2
80103e7c:	68 a1 00 00 00       	push   $0xa1
80103e81:	e8 f1 fe ff ff       	call   80103d77 <outb>
80103e86:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103e89:	6a 03                	push   $0x3
80103e8b:	68 a1 00 00 00       	push   $0xa1
80103e90:	e8 e2 fe ff ff       	call   80103d77 <outb>
80103e95:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103e98:	6a 68                	push   $0x68
80103e9a:	6a 20                	push   $0x20
80103e9c:	e8 d6 fe ff ff       	call   80103d77 <outb>
80103ea1:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103ea4:	6a 0a                	push   $0xa
80103ea6:	6a 20                	push   $0x20
80103ea8:	e8 ca fe ff ff       	call   80103d77 <outb>
80103ead:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
80103eb0:	6a 68                	push   $0x68
80103eb2:	68 a0 00 00 00       	push   $0xa0
80103eb7:	e8 bb fe ff ff       	call   80103d77 <outb>
80103ebc:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
80103ebf:	6a 0a                	push   $0xa
80103ec1:	68 a0 00 00 00       	push   $0xa0
80103ec6:	e8 ac fe ff ff       	call   80103d77 <outb>
80103ecb:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
80103ece:	0f b7 05 00 e0 10 80 	movzwl 0x8010e000,%eax
80103ed5:	66 83 f8 ff          	cmp    $0xffff,%ax
80103ed9:	74 13                	je     80103eee <picinit+0xe6>
    picsetmask(irqmask);
80103edb:	0f b7 05 00 e0 10 80 	movzwl 0x8010e000,%eax
80103ee2:	0f b7 c0             	movzwl %ax,%eax
80103ee5:	50                   	push   %eax
80103ee6:	e8 ab fe ff ff       	call   80103d96 <picsetmask>
80103eeb:	83 c4 04             	add    $0x4,%esp
}
80103eee:	90                   	nop
80103eef:	c9                   	leave  
80103ef0:	c3                   	ret    

80103ef1 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103ef1:	55                   	push   %ebp
80103ef2:	89 e5                	mov    %esp,%ebp
80103ef4:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80103ef7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103efe:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f01:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103f07:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f0a:	8b 10                	mov    (%eax),%edx
80103f0c:	8b 45 08             	mov    0x8(%ebp),%eax
80103f0f:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103f11:	e8 4e d0 ff ff       	call   80100f64 <filealloc>
80103f16:	89 c2                	mov    %eax,%edx
80103f18:	8b 45 08             	mov    0x8(%ebp),%eax
80103f1b:	89 10                	mov    %edx,(%eax)
80103f1d:	8b 45 08             	mov    0x8(%ebp),%eax
80103f20:	8b 00                	mov    (%eax),%eax
80103f22:	85 c0                	test   %eax,%eax
80103f24:	0f 84 cb 00 00 00    	je     80103ff5 <pipealloc+0x104>
80103f2a:	e8 35 d0 ff ff       	call   80100f64 <filealloc>
80103f2f:	89 c2                	mov    %eax,%edx
80103f31:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f34:	89 10                	mov    %edx,(%eax)
80103f36:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f39:	8b 00                	mov    (%eax),%eax
80103f3b:	85 c0                	test   %eax,%eax
80103f3d:	0f 84 b2 00 00 00    	je     80103ff5 <pipealloc+0x104>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103f43:	e8 b8 ed ff ff       	call   80102d00 <kalloc>
80103f48:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103f4b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103f4f:	0f 84 9f 00 00 00    	je     80103ff4 <pipealloc+0x103>
    goto bad;
  p->readopen = 1;
80103f55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f58:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103f5f:	00 00 00 
  p->writeopen = 1;
80103f62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f65:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103f6c:	00 00 00 
  p->nwrite = 0;
80103f6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f72:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103f79:	00 00 00 
  p->nread = 0;
80103f7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f7f:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103f86:	00 00 00 
  initlock(&p->lock, "pipe");
80103f89:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f8c:	83 ec 08             	sub    $0x8,%esp
80103f8f:	68 a4 b7 10 80       	push   $0x8010b7a4
80103f94:	50                   	push   %eax
80103f95:	e8 b4 0e 00 00       	call   80104e4e <initlock>
80103f9a:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103f9d:	8b 45 08             	mov    0x8(%ebp),%eax
80103fa0:	8b 00                	mov    (%eax),%eax
80103fa2:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103fa8:	8b 45 08             	mov    0x8(%ebp),%eax
80103fab:	8b 00                	mov    (%eax),%eax
80103fad:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103fb1:	8b 45 08             	mov    0x8(%ebp),%eax
80103fb4:	8b 00                	mov    (%eax),%eax
80103fb6:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103fba:	8b 45 08             	mov    0x8(%ebp),%eax
80103fbd:	8b 00                	mov    (%eax),%eax
80103fbf:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103fc2:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103fc5:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fc8:	8b 00                	mov    (%eax),%eax
80103fca:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103fd0:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fd3:	8b 00                	mov    (%eax),%eax
80103fd5:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103fd9:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fdc:	8b 00                	mov    (%eax),%eax
80103fde:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103fe2:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fe5:	8b 00                	mov    (%eax),%eax
80103fe7:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103fea:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80103fed:	b8 00 00 00 00       	mov    $0x0,%eax
80103ff2:	eb 4e                	jmp    80104042 <pipealloc+0x151>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
80103ff4:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
80103ff5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103ff9:	74 0e                	je     80104009 <pipealloc+0x118>
    kfree((char*)p);
80103ffb:	83 ec 0c             	sub    $0xc,%esp
80103ffe:	ff 75 f4             	pushl  -0xc(%ebp)
80104001:	e8 5d ec ff ff       	call   80102c63 <kfree>
80104006:	83 c4 10             	add    $0x10,%esp
  if(*f0)
80104009:	8b 45 08             	mov    0x8(%ebp),%eax
8010400c:	8b 00                	mov    (%eax),%eax
8010400e:	85 c0                	test   %eax,%eax
80104010:	74 11                	je     80104023 <pipealloc+0x132>
    fileclose(*f0);
80104012:	8b 45 08             	mov    0x8(%ebp),%eax
80104015:	8b 00                	mov    (%eax),%eax
80104017:	83 ec 0c             	sub    $0xc,%esp
8010401a:	50                   	push   %eax
8010401b:	e8 02 d0 ff ff       	call   80101022 <fileclose>
80104020:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80104023:	8b 45 0c             	mov    0xc(%ebp),%eax
80104026:	8b 00                	mov    (%eax),%eax
80104028:	85 c0                	test   %eax,%eax
8010402a:	74 11                	je     8010403d <pipealloc+0x14c>
    fileclose(*f1);
8010402c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010402f:	8b 00                	mov    (%eax),%eax
80104031:	83 ec 0c             	sub    $0xc,%esp
80104034:	50                   	push   %eax
80104035:	e8 e8 cf ff ff       	call   80101022 <fileclose>
8010403a:	83 c4 10             	add    $0x10,%esp
  return -1;
8010403d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104042:	c9                   	leave  
80104043:	c3                   	ret    

80104044 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104044:	55                   	push   %ebp
80104045:	89 e5                	mov    %esp,%ebp
80104047:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
8010404a:	8b 45 08             	mov    0x8(%ebp),%eax
8010404d:	83 ec 0c             	sub    $0xc,%esp
80104050:	50                   	push   %eax
80104051:	e8 1a 0e 00 00       	call   80104e70 <acquire>
80104056:	83 c4 10             	add    $0x10,%esp
  if(writable){
80104059:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010405d:	74 23                	je     80104082 <pipeclose+0x3e>
    p->writeopen = 0;
8010405f:	8b 45 08             	mov    0x8(%ebp),%eax
80104062:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80104069:	00 00 00 
    wakeup(&p->nread);
8010406c:	8b 45 08             	mov    0x8(%ebp),%eax
8010406f:	05 34 02 00 00       	add    $0x234,%eax
80104074:	83 ec 0c             	sub    $0xc,%esp
80104077:	50                   	push   %eax
80104078:	e8 e5 0b 00 00       	call   80104c62 <wakeup>
8010407d:	83 c4 10             	add    $0x10,%esp
80104080:	eb 21                	jmp    801040a3 <pipeclose+0x5f>
  } else {
    p->readopen = 0;
80104082:	8b 45 08             	mov    0x8(%ebp),%eax
80104085:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
8010408c:	00 00 00 
    wakeup(&p->nwrite);
8010408f:	8b 45 08             	mov    0x8(%ebp),%eax
80104092:	05 38 02 00 00       	add    $0x238,%eax
80104097:	83 ec 0c             	sub    $0xc,%esp
8010409a:	50                   	push   %eax
8010409b:	e8 c2 0b 00 00       	call   80104c62 <wakeup>
801040a0:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
801040a3:	8b 45 08             	mov    0x8(%ebp),%eax
801040a6:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
801040ac:	85 c0                	test   %eax,%eax
801040ae:	75 2c                	jne    801040dc <pipeclose+0x98>
801040b0:	8b 45 08             	mov    0x8(%ebp),%eax
801040b3:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801040b9:	85 c0                	test   %eax,%eax
801040bb:	75 1f                	jne    801040dc <pipeclose+0x98>
    release(&p->lock);
801040bd:	8b 45 08             	mov    0x8(%ebp),%eax
801040c0:	83 ec 0c             	sub    $0xc,%esp
801040c3:	50                   	push   %eax
801040c4:	e8 0e 0e 00 00       	call   80104ed7 <release>
801040c9:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
801040cc:	83 ec 0c             	sub    $0xc,%esp
801040cf:	ff 75 08             	pushl  0x8(%ebp)
801040d2:	e8 8c eb ff ff       	call   80102c63 <kfree>
801040d7:	83 c4 10             	add    $0x10,%esp
801040da:	eb 0f                	jmp    801040eb <pipeclose+0xa7>
  } else
    release(&p->lock);
801040dc:	8b 45 08             	mov    0x8(%ebp),%eax
801040df:	83 ec 0c             	sub    $0xc,%esp
801040e2:	50                   	push   %eax
801040e3:	e8 ef 0d 00 00       	call   80104ed7 <release>
801040e8:	83 c4 10             	add    $0x10,%esp
}
801040eb:	90                   	nop
801040ec:	c9                   	leave  
801040ed:	c3                   	ret    

801040ee <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801040ee:	55                   	push   %ebp
801040ef:	89 e5                	mov    %esp,%ebp
801040f1:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
801040f4:	8b 45 08             	mov    0x8(%ebp),%eax
801040f7:	83 ec 0c             	sub    $0xc,%esp
801040fa:	50                   	push   %eax
801040fb:	e8 70 0d 00 00       	call   80104e70 <acquire>
80104100:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
80104103:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010410a:	e9 ad 00 00 00       	jmp    801041bc <pipewrite+0xce>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
8010410f:	8b 45 08             	mov    0x8(%ebp),%eax
80104112:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104118:	85 c0                	test   %eax,%eax
8010411a:	74 0d                	je     80104129 <pipewrite+0x3b>
8010411c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104122:	8b 40 24             	mov    0x24(%eax),%eax
80104125:	85 c0                	test   %eax,%eax
80104127:	74 19                	je     80104142 <pipewrite+0x54>
        release(&p->lock);
80104129:	8b 45 08             	mov    0x8(%ebp),%eax
8010412c:	83 ec 0c             	sub    $0xc,%esp
8010412f:	50                   	push   %eax
80104130:	e8 a2 0d 00 00       	call   80104ed7 <release>
80104135:	83 c4 10             	add    $0x10,%esp
        return -1;
80104138:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010413d:	e9 a8 00 00 00       	jmp    801041ea <pipewrite+0xfc>
      }
      wakeup(&p->nread);
80104142:	8b 45 08             	mov    0x8(%ebp),%eax
80104145:	05 34 02 00 00       	add    $0x234,%eax
8010414a:	83 ec 0c             	sub    $0xc,%esp
8010414d:	50                   	push   %eax
8010414e:	e8 0f 0b 00 00       	call   80104c62 <wakeup>
80104153:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104156:	8b 45 08             	mov    0x8(%ebp),%eax
80104159:	8b 55 08             	mov    0x8(%ebp),%edx
8010415c:	81 c2 38 02 00 00    	add    $0x238,%edx
80104162:	83 ec 08             	sub    $0x8,%esp
80104165:	50                   	push   %eax
80104166:	52                   	push   %edx
80104167:	e8 0b 0a 00 00       	call   80104b77 <sleep>
8010416c:	83 c4 10             	add    $0x10,%esp
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010416f:	8b 45 08             	mov    0x8(%ebp),%eax
80104172:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80104178:	8b 45 08             	mov    0x8(%ebp),%eax
8010417b:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104181:	05 00 02 00 00       	add    $0x200,%eax
80104186:	39 c2                	cmp    %eax,%edx
80104188:	74 85                	je     8010410f <pipewrite+0x21>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010418a:	8b 45 08             	mov    0x8(%ebp),%eax
8010418d:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104193:	8d 48 01             	lea    0x1(%eax),%ecx
80104196:	8b 55 08             	mov    0x8(%ebp),%edx
80104199:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
8010419f:	25 ff 01 00 00       	and    $0x1ff,%eax
801041a4:	89 c1                	mov    %eax,%ecx
801041a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801041a9:	8b 45 0c             	mov    0xc(%ebp),%eax
801041ac:	01 d0                	add    %edx,%eax
801041ae:	0f b6 10             	movzbl (%eax),%edx
801041b1:	8b 45 08             	mov    0x8(%ebp),%eax
801041b4:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
801041b8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801041bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041bf:	3b 45 10             	cmp    0x10(%ebp),%eax
801041c2:	7c ab                	jl     8010416f <pipewrite+0x81>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801041c4:	8b 45 08             	mov    0x8(%ebp),%eax
801041c7:	05 34 02 00 00       	add    $0x234,%eax
801041cc:	83 ec 0c             	sub    $0xc,%esp
801041cf:	50                   	push   %eax
801041d0:	e8 8d 0a 00 00       	call   80104c62 <wakeup>
801041d5:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801041d8:	8b 45 08             	mov    0x8(%ebp),%eax
801041db:	83 ec 0c             	sub    $0xc,%esp
801041de:	50                   	push   %eax
801041df:	e8 f3 0c 00 00       	call   80104ed7 <release>
801041e4:	83 c4 10             	add    $0x10,%esp
  return n;
801041e7:	8b 45 10             	mov    0x10(%ebp),%eax
}
801041ea:	c9                   	leave  
801041eb:	c3                   	ret    

801041ec <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801041ec:	55                   	push   %ebp
801041ed:	89 e5                	mov    %esp,%ebp
801041ef:	53                   	push   %ebx
801041f0:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
801041f3:	8b 45 08             	mov    0x8(%ebp),%eax
801041f6:	83 ec 0c             	sub    $0xc,%esp
801041f9:	50                   	push   %eax
801041fa:	e8 71 0c 00 00       	call   80104e70 <acquire>
801041ff:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104202:	eb 3f                	jmp    80104243 <piperead+0x57>
    if(proc->killed){
80104204:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010420a:	8b 40 24             	mov    0x24(%eax),%eax
8010420d:	85 c0                	test   %eax,%eax
8010420f:	74 19                	je     8010422a <piperead+0x3e>
      release(&p->lock);
80104211:	8b 45 08             	mov    0x8(%ebp),%eax
80104214:	83 ec 0c             	sub    $0xc,%esp
80104217:	50                   	push   %eax
80104218:	e8 ba 0c 00 00       	call   80104ed7 <release>
8010421d:	83 c4 10             	add    $0x10,%esp
      return -1;
80104220:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104225:	e9 bf 00 00 00       	jmp    801042e9 <piperead+0xfd>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010422a:	8b 45 08             	mov    0x8(%ebp),%eax
8010422d:	8b 55 08             	mov    0x8(%ebp),%edx
80104230:	81 c2 34 02 00 00    	add    $0x234,%edx
80104236:	83 ec 08             	sub    $0x8,%esp
80104239:	50                   	push   %eax
8010423a:	52                   	push   %edx
8010423b:	e8 37 09 00 00       	call   80104b77 <sleep>
80104240:	83 c4 10             	add    $0x10,%esp
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104243:	8b 45 08             	mov    0x8(%ebp),%eax
80104246:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
8010424c:	8b 45 08             	mov    0x8(%ebp),%eax
8010424f:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104255:	39 c2                	cmp    %eax,%edx
80104257:	75 0d                	jne    80104266 <piperead+0x7a>
80104259:	8b 45 08             	mov    0x8(%ebp),%eax
8010425c:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104262:	85 c0                	test   %eax,%eax
80104264:	75 9e                	jne    80104204 <piperead+0x18>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104266:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010426d:	eb 49                	jmp    801042b8 <piperead+0xcc>
    if(p->nread == p->nwrite)
8010426f:	8b 45 08             	mov    0x8(%ebp),%eax
80104272:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104278:	8b 45 08             	mov    0x8(%ebp),%eax
8010427b:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104281:	39 c2                	cmp    %eax,%edx
80104283:	74 3d                	je     801042c2 <piperead+0xd6>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104285:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104288:	8b 45 0c             	mov    0xc(%ebp),%eax
8010428b:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010428e:	8b 45 08             	mov    0x8(%ebp),%eax
80104291:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104297:	8d 48 01             	lea    0x1(%eax),%ecx
8010429a:	8b 55 08             	mov    0x8(%ebp),%edx
8010429d:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
801042a3:	25 ff 01 00 00       	and    $0x1ff,%eax
801042a8:	89 c2                	mov    %eax,%edx
801042aa:	8b 45 08             	mov    0x8(%ebp),%eax
801042ad:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
801042b2:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801042b4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801042b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042bb:	3b 45 10             	cmp    0x10(%ebp),%eax
801042be:	7c af                	jl     8010426f <piperead+0x83>
801042c0:	eb 01                	jmp    801042c3 <piperead+0xd7>
    if(p->nread == p->nwrite)
      break;
801042c2:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801042c3:	8b 45 08             	mov    0x8(%ebp),%eax
801042c6:	05 38 02 00 00       	add    $0x238,%eax
801042cb:	83 ec 0c             	sub    $0xc,%esp
801042ce:	50                   	push   %eax
801042cf:	e8 8e 09 00 00       	call   80104c62 <wakeup>
801042d4:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801042d7:	8b 45 08             	mov    0x8(%ebp),%eax
801042da:	83 ec 0c             	sub    $0xc,%esp
801042dd:	50                   	push   %eax
801042de:	e8 f4 0b 00 00       	call   80104ed7 <release>
801042e3:	83 c4 10             	add    $0x10,%esp
  return i;
801042e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801042e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042ec:	c9                   	leave  
801042ed:	c3                   	ret    

801042ee <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
801042ee:	55                   	push   %ebp
801042ef:	89 e5                	mov    %esp,%ebp
801042f1:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801042f4:	9c                   	pushf  
801042f5:	58                   	pop    %eax
801042f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801042f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801042fc:	c9                   	leave  
801042fd:	c3                   	ret    

801042fe <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
801042fe:	55                   	push   %ebp
801042ff:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104301:	fb                   	sti    
}
80104302:	90                   	nop
80104303:	5d                   	pop    %ebp
80104304:	c3                   	ret    

80104305 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80104305:	55                   	push   %ebp
80104306:	89 e5                	mov    %esp,%ebp
80104308:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
8010430b:	83 ec 08             	sub    $0x8,%esp
8010430e:	68 a9 b7 10 80       	push   $0x8010b7a9
80104313:	68 60 2f 11 80       	push   $0x80112f60
80104318:	e8 31 0b 00 00       	call   80104e4e <initlock>
8010431d:	83 c4 10             	add    $0x10,%esp
}
80104320:	90                   	nop
80104321:	c9                   	leave  
80104322:	c3                   	ret    

80104323 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104323:	55                   	push   %ebp
80104324:	89 e5                	mov    %esp,%ebp
80104326:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80104329:	83 ec 0c             	sub    $0xc,%esp
8010432c:	68 60 2f 11 80       	push   $0x80112f60
80104331:	e8 3a 0b 00 00       	call   80104e70 <acquire>
80104336:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104339:	c7 45 f4 94 2f 11 80 	movl   $0x80112f94,-0xc(%ebp)
80104340:	eb 0e                	jmp    80104350 <allocproc+0x2d>
    if(p->state == UNUSED)
80104342:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104345:	8b 40 0c             	mov    0xc(%eax),%eax
80104348:	85 c0                	test   %eax,%eax
8010434a:	74 27                	je     80104373 <allocproc+0x50>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010434c:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104350:	81 7d f4 94 4e 11 80 	cmpl   $0x80114e94,-0xc(%ebp)
80104357:	72 e9                	jb     80104342 <allocproc+0x1f>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
80104359:	83 ec 0c             	sub    $0xc,%esp
8010435c:	68 60 2f 11 80       	push   $0x80112f60
80104361:	e8 71 0b 00 00       	call   80104ed7 <release>
80104366:	83 c4 10             	add    $0x10,%esp
  return 0;
80104369:	b8 00 00 00 00       	mov    $0x0,%eax
8010436e:	e9 b4 00 00 00       	jmp    80104427 <allocproc+0x104>
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
80104373:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80104374:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104377:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
8010437e:	a1 04 e0 10 80       	mov    0x8010e004,%eax
80104383:	8d 50 01             	lea    0x1(%eax),%edx
80104386:	89 15 04 e0 10 80    	mov    %edx,0x8010e004
8010438c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010438f:	89 42 10             	mov    %eax,0x10(%edx)
  release(&ptable.lock);
80104392:	83 ec 0c             	sub    $0xc,%esp
80104395:	68 60 2f 11 80       	push   $0x80112f60
8010439a:	e8 38 0b 00 00       	call   80104ed7 <release>
8010439f:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801043a2:	e8 59 e9 ff ff       	call   80102d00 <kalloc>
801043a7:	89 c2                	mov    %eax,%edx
801043a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043ac:	89 50 08             	mov    %edx,0x8(%eax)
801043af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043b2:	8b 40 08             	mov    0x8(%eax),%eax
801043b5:	85 c0                	test   %eax,%eax
801043b7:	75 11                	jne    801043ca <allocproc+0xa7>
    p->state = UNUSED;
801043b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043bc:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
801043c3:	b8 00 00 00 00       	mov    $0x0,%eax
801043c8:	eb 5d                	jmp    80104427 <allocproc+0x104>
  }
  sp = p->kstack + KSTACKSIZE;
801043ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043cd:	8b 40 08             	mov    0x8(%eax),%eax
801043d0:	05 00 10 00 00       	add    $0x1000,%eax
801043d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801043d8:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
801043dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043df:	8b 55 f0             	mov    -0x10(%ebp),%edx
801043e2:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
801043e5:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
801043e9:	ba 7b 64 10 80       	mov    $0x8010647b,%edx
801043ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
801043f1:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
801043f3:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
801043f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043fa:	8b 55 f0             	mov    -0x10(%ebp),%edx
801043fd:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
80104400:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104403:	8b 40 1c             	mov    0x1c(%eax),%eax
80104406:	83 ec 04             	sub    $0x4,%esp
80104409:	6a 14                	push   $0x14
8010440b:	6a 00                	push   $0x0
8010440d:	50                   	push   %eax
8010440e:	e8 c0 0c 00 00       	call   801050d3 <memset>
80104413:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104416:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104419:	8b 40 1c             	mov    0x1c(%eax),%eax
8010441c:	ba 46 4b 10 80       	mov    $0x80104b46,%edx
80104421:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
80104424:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104427:	c9                   	leave  
80104428:	c3                   	ret    

80104429 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80104429:	55                   	push   %ebp
8010442a:	89 e5                	mov    %esp,%ebp
8010442c:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
8010442f:	e8 ef fe ff ff       	call   80104323 <allocproc>
80104434:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
80104437:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010443a:	a3 6c e6 10 80       	mov    %eax,0x8010e66c
  if((p->pgdir = setupkvm()) == 0)
8010443f:	e8 01 37 00 00       	call   80107b45 <setupkvm>
80104444:	89 c2                	mov    %eax,%edx
80104446:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104449:	89 50 04             	mov    %edx,0x4(%eax)
8010444c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010444f:	8b 40 04             	mov    0x4(%eax),%eax
80104452:	85 c0                	test   %eax,%eax
80104454:	75 0d                	jne    80104463 <userinit+0x3a>
    panic("userinit: out of memory?");
80104456:	83 ec 0c             	sub    $0xc,%esp
80104459:	68 b0 b7 10 80       	push   $0x8010b7b0
8010445e:	e8 03 c1 ff ff       	call   80100566 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104463:	ba 2c 00 00 00       	mov    $0x2c,%edx
80104468:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010446b:	8b 40 04             	mov    0x4(%eax),%eax
8010446e:	83 ec 04             	sub    $0x4,%esp
80104471:	52                   	push   %edx
80104472:	68 08 e5 10 80       	push   $0x8010e508
80104477:	50                   	push   %eax
80104478:	e8 22 39 00 00       	call   80107d9f <inituvm>
8010447d:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
80104480:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104483:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
80104489:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010448c:	8b 40 18             	mov    0x18(%eax),%eax
8010448f:	83 ec 04             	sub    $0x4,%esp
80104492:	6a 4c                	push   $0x4c
80104494:	6a 00                	push   $0x0
80104496:	50                   	push   %eax
80104497:	e8 37 0c 00 00       	call   801050d3 <memset>
8010449c:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010449f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044a2:	8b 40 18             	mov    0x18(%eax),%eax
801044a5:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801044ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044ae:	8b 40 18             	mov    0x18(%eax),%eax
801044b1:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
801044b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044ba:	8b 40 18             	mov    0x18(%eax),%eax
801044bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044c0:	8b 52 18             	mov    0x18(%edx),%edx
801044c3:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801044c7:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801044cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044ce:	8b 40 18             	mov    0x18(%eax),%eax
801044d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044d4:	8b 52 18             	mov    0x18(%edx),%edx
801044d7:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801044db:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801044df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044e2:	8b 40 18             	mov    0x18(%eax),%eax
801044e5:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801044ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044ef:	8b 40 18             	mov    0x18(%eax),%eax
801044f2:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801044f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044fc:	8b 40 18             	mov    0x18(%eax),%eax
801044ff:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104506:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104509:	83 c0 6c             	add    $0x6c,%eax
8010450c:	83 ec 04             	sub    $0x4,%esp
8010450f:	6a 10                	push   $0x10
80104511:	68 c9 b7 10 80       	push   $0x8010b7c9
80104516:	50                   	push   %eax
80104517:	e8 ba 0d 00 00       	call   801052d6 <safestrcpy>
8010451c:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
8010451f:	83 ec 0c             	sub    $0xc,%esp
80104522:	68 d2 b7 10 80       	push   $0x8010b7d2
80104527:	e8 d2 e0 ff ff       	call   801025fe <namei>
8010452c:	83 c4 10             	add    $0x10,%esp
8010452f:	89 c2                	mov    %eax,%edx
80104531:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104534:	89 50 68             	mov    %edx,0x68(%eax)

  p->state = RUNNABLE;
80104537:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010453a:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
80104541:	90                   	nop
80104542:	c9                   	leave  
80104543:	c3                   	ret    

80104544 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104544:	55                   	push   %ebp
80104545:	89 e5                	mov    %esp,%ebp
80104547:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  
  sz = proc->sz;
8010454a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104550:	8b 00                	mov    (%eax),%eax
80104552:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80104555:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104559:	7e 31                	jle    8010458c <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
8010455b:	8b 55 08             	mov    0x8(%ebp),%edx
8010455e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104561:	01 c2                	add    %eax,%edx
80104563:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104569:	8b 40 04             	mov    0x4(%eax),%eax
8010456c:	83 ec 04             	sub    $0x4,%esp
8010456f:	52                   	push   %edx
80104570:	ff 75 f4             	pushl  -0xc(%ebp)
80104573:	50                   	push   %eax
80104574:	e8 73 39 00 00       	call   80107eec <allocuvm>
80104579:	83 c4 10             	add    $0x10,%esp
8010457c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010457f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104583:	75 3e                	jne    801045c3 <growproc+0x7f>
      return -1;
80104585:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010458a:	eb 59                	jmp    801045e5 <growproc+0xa1>
  } else if(n < 0){
8010458c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104590:	79 31                	jns    801045c3 <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80104592:	8b 55 08             	mov    0x8(%ebp),%edx
80104595:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104598:	01 c2                	add    %eax,%edx
8010459a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045a0:	8b 40 04             	mov    0x4(%eax),%eax
801045a3:	83 ec 04             	sub    $0x4,%esp
801045a6:	52                   	push   %edx
801045a7:	ff 75 f4             	pushl  -0xc(%ebp)
801045aa:	50                   	push   %eax
801045ab:	e8 05 3a 00 00       	call   80107fb5 <deallocuvm>
801045b0:	83 c4 10             	add    $0x10,%esp
801045b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801045b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801045ba:	75 07                	jne    801045c3 <growproc+0x7f>
      return -1;
801045bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045c1:	eb 22                	jmp    801045e5 <growproc+0xa1>
  }
  proc->sz = sz;
801045c3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045cc:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
801045ce:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045d4:	83 ec 0c             	sub    $0xc,%esp
801045d7:	50                   	push   %eax
801045d8:	e8 4f 36 00 00       	call   80107c2c <switchuvm>
801045dd:	83 c4 10             	add    $0x10,%esp
  return 0;
801045e0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801045e5:	c9                   	leave  
801045e6:	c3                   	ret    

801045e7 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801045e7:	55                   	push   %ebp
801045e8:	89 e5                	mov    %esp,%ebp
801045ea:	57                   	push   %edi
801045eb:	56                   	push   %esi
801045ec:	53                   	push   %ebx
801045ed:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
801045f0:	e8 2e fd ff ff       	call   80104323 <allocproc>
801045f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801045f8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801045fc:	75 0a                	jne    80104608 <fork+0x21>
    return -1;
801045fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104603:	e9 48 01 00 00       	jmp    80104750 <fork+0x169>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80104608:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010460e:	8b 10                	mov    (%eax),%edx
80104610:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104616:	8b 40 04             	mov    0x4(%eax),%eax
80104619:	83 ec 08             	sub    $0x8,%esp
8010461c:	52                   	push   %edx
8010461d:	50                   	push   %eax
8010461e:	e8 30 3b 00 00       	call   80108153 <copyuvm>
80104623:	83 c4 10             	add    $0x10,%esp
80104626:	89 c2                	mov    %eax,%edx
80104628:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010462b:	89 50 04             	mov    %edx,0x4(%eax)
8010462e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104631:	8b 40 04             	mov    0x4(%eax),%eax
80104634:	85 c0                	test   %eax,%eax
80104636:	75 30                	jne    80104668 <fork+0x81>
    kfree(np->kstack);
80104638:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010463b:	8b 40 08             	mov    0x8(%eax),%eax
8010463e:	83 ec 0c             	sub    $0xc,%esp
80104641:	50                   	push   %eax
80104642:	e8 1c e6 ff ff       	call   80102c63 <kfree>
80104647:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
8010464a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010464d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80104654:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104657:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
8010465e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104663:	e9 e8 00 00 00       	jmp    80104750 <fork+0x169>
  }
  np->sz = proc->sz;
80104668:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010466e:	8b 10                	mov    (%eax),%edx
80104670:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104673:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
80104675:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010467c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010467f:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
80104682:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104685:	8b 50 18             	mov    0x18(%eax),%edx
80104688:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010468e:	8b 40 18             	mov    0x18(%eax),%eax
80104691:	89 c3                	mov    %eax,%ebx
80104693:	b8 13 00 00 00       	mov    $0x13,%eax
80104698:	89 d7                	mov    %edx,%edi
8010469a:	89 de                	mov    %ebx,%esi
8010469c:	89 c1                	mov    %eax,%ecx
8010469e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
801046a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046a3:	8b 40 18             	mov    0x18(%eax),%eax
801046a6:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
801046ad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801046b4:	eb 43                	jmp    801046f9 <fork+0x112>
    if(proc->ofile[i])
801046b6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046bc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801046bf:	83 c2 08             	add    $0x8,%edx
801046c2:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801046c6:	85 c0                	test   %eax,%eax
801046c8:	74 2b                	je     801046f5 <fork+0x10e>
      np->ofile[i] = filedup(proc->ofile[i]);
801046ca:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801046d3:	83 c2 08             	add    $0x8,%edx
801046d6:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801046da:	83 ec 0c             	sub    $0xc,%esp
801046dd:	50                   	push   %eax
801046de:	e8 ee c8 ff ff       	call   80100fd1 <filedup>
801046e3:	83 c4 10             	add    $0x10,%esp
801046e6:	89 c1                	mov    %eax,%ecx
801046e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046eb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801046ee:	83 c2 08             	add    $0x8,%edx
801046f1:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801046f5:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801046f9:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
801046fd:	7e b7                	jle    801046b6 <fork+0xcf>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
801046ff:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104705:	8b 40 68             	mov    0x68(%eax),%eax
80104708:	83 ec 0c             	sub    $0xc,%esp
8010470b:	50                   	push   %eax
8010470c:	e8 ac d1 ff ff       	call   801018bd <idup>
80104711:	83 c4 10             	add    $0x10,%esp
80104714:	89 c2                	mov    %eax,%edx
80104716:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104719:	89 50 68             	mov    %edx,0x68(%eax)
 
  pid = np->pid;
8010471c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010471f:	8b 40 10             	mov    0x10(%eax),%eax
80104722:	89 45 dc             	mov    %eax,-0x24(%ebp)
  np->state = RUNNABLE;
80104725:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104728:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
8010472f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104735:	8d 50 6c             	lea    0x6c(%eax),%edx
80104738:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010473b:	83 c0 6c             	add    $0x6c,%eax
8010473e:	83 ec 04             	sub    $0x4,%esp
80104741:	6a 10                	push   $0x10
80104743:	52                   	push   %edx
80104744:	50                   	push   %eax
80104745:	e8 8c 0b 00 00       	call   801052d6 <safestrcpy>
8010474a:	83 c4 10             	add    $0x10,%esp
  return pid;
8010474d:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80104750:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104753:	5b                   	pop    %ebx
80104754:	5e                   	pop    %esi
80104755:	5f                   	pop    %edi
80104756:	5d                   	pop    %ebp
80104757:	c3                   	ret    

80104758 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80104758:	55                   	push   %ebp
80104759:	89 e5                	mov    %esp,%ebp
8010475b:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
8010475e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104765:	a1 6c e6 10 80       	mov    0x8010e66c,%eax
8010476a:	39 c2                	cmp    %eax,%edx
8010476c:	75 0d                	jne    8010477b <exit+0x23>
    panic("init exiting");
8010476e:	83 ec 0c             	sub    $0xc,%esp
80104771:	68 d4 b7 10 80       	push   $0x8010b7d4
80104776:	e8 eb bd ff ff       	call   80100566 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
8010477b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104782:	eb 48                	jmp    801047cc <exit+0x74>
    if(proc->ofile[fd]){
80104784:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010478a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010478d:	83 c2 08             	add    $0x8,%edx
80104790:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104794:	85 c0                	test   %eax,%eax
80104796:	74 30                	je     801047c8 <exit+0x70>
      fileclose(proc->ofile[fd]);
80104798:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010479e:	8b 55 f0             	mov    -0x10(%ebp),%edx
801047a1:	83 c2 08             	add    $0x8,%edx
801047a4:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801047a8:	83 ec 0c             	sub    $0xc,%esp
801047ab:	50                   	push   %eax
801047ac:	e8 71 c8 ff ff       	call   80101022 <fileclose>
801047b1:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
801047b4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047ba:	8b 55 f0             	mov    -0x10(%ebp),%edx
801047bd:	83 c2 08             	add    $0x8,%edx
801047c0:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801047c7:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801047c8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801047cc:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
801047d0:	7e b2                	jle    80104784 <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
801047d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047d8:	8b 40 68             	mov    0x68(%eax),%eax
801047db:	83 ec 0c             	sub    $0xc,%esp
801047de:	50                   	push   %eax
801047df:	e8 dd d2 ff ff       	call   80101ac1 <iput>
801047e4:	83 c4 10             	add    $0x10,%esp
  proc->cwd = 0;
801047e7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047ed:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
801047f4:	83 ec 0c             	sub    $0xc,%esp
801047f7:	68 60 2f 11 80       	push   $0x80112f60
801047fc:	e8 6f 06 00 00       	call   80104e70 <acquire>
80104801:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80104804:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010480a:	8b 40 14             	mov    0x14(%eax),%eax
8010480d:	83 ec 0c             	sub    $0xc,%esp
80104810:	50                   	push   %eax
80104811:	e8 0d 04 00 00       	call   80104c23 <wakeup1>
80104816:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104819:	c7 45 f4 94 2f 11 80 	movl   $0x80112f94,-0xc(%ebp)
80104820:	eb 3c                	jmp    8010485e <exit+0x106>
    if(p->parent == proc){
80104822:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104825:	8b 50 14             	mov    0x14(%eax),%edx
80104828:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010482e:	39 c2                	cmp    %eax,%edx
80104830:	75 28                	jne    8010485a <exit+0x102>
      p->parent = initproc;
80104832:	8b 15 6c e6 10 80    	mov    0x8010e66c,%edx
80104838:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010483b:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
8010483e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104841:	8b 40 0c             	mov    0xc(%eax),%eax
80104844:	83 f8 05             	cmp    $0x5,%eax
80104847:	75 11                	jne    8010485a <exit+0x102>
        wakeup1(initproc);
80104849:	a1 6c e6 10 80       	mov    0x8010e66c,%eax
8010484e:	83 ec 0c             	sub    $0xc,%esp
80104851:	50                   	push   %eax
80104852:	e8 cc 03 00 00       	call   80104c23 <wakeup1>
80104857:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010485a:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
8010485e:	81 7d f4 94 4e 11 80 	cmpl   $0x80114e94,-0xc(%ebp)
80104865:	72 bb                	jb     80104822 <exit+0xca>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80104867:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010486d:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
80104874:	e8 d6 01 00 00       	call   80104a4f <sched>
  panic("zombie exit");
80104879:	83 ec 0c             	sub    $0xc,%esp
8010487c:	68 e1 b7 10 80       	push   $0x8010b7e1
80104881:	e8 e0 bc ff ff       	call   80100566 <panic>

80104886 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104886:	55                   	push   %ebp
80104887:	89 e5                	mov    %esp,%ebp
80104889:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
8010488c:	83 ec 0c             	sub    $0xc,%esp
8010488f:	68 60 2f 11 80       	push   $0x80112f60
80104894:	e8 d7 05 00 00       	call   80104e70 <acquire>
80104899:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
8010489c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048a3:	c7 45 f4 94 2f 11 80 	movl   $0x80112f94,-0xc(%ebp)
801048aa:	e9 a6 00 00 00       	jmp    80104955 <wait+0xcf>
      if(p->parent != proc)
801048af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048b2:	8b 50 14             	mov    0x14(%eax),%edx
801048b5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048bb:	39 c2                	cmp    %eax,%edx
801048bd:	0f 85 8d 00 00 00    	jne    80104950 <wait+0xca>
        continue;
      havekids = 1;
801048c3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
801048ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048cd:	8b 40 0c             	mov    0xc(%eax),%eax
801048d0:	83 f8 05             	cmp    $0x5,%eax
801048d3:	75 7c                	jne    80104951 <wait+0xcb>
        // Found one.
        pid = p->pid;
801048d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048d8:	8b 40 10             	mov    0x10(%eax),%eax
801048db:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
801048de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048e1:	8b 40 08             	mov    0x8(%eax),%eax
801048e4:	83 ec 0c             	sub    $0xc,%esp
801048e7:	50                   	push   %eax
801048e8:	e8 76 e3 ff ff       	call   80102c63 <kfree>
801048ed:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
801048f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048f3:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
801048fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048fd:	8b 40 04             	mov    0x4(%eax),%eax
80104900:	83 ec 0c             	sub    $0xc,%esp
80104903:	50                   	push   %eax
80104904:	e8 69 37 00 00       	call   80108072 <freevm>
80104909:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
8010490c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010490f:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
80104916:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104919:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104920:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104923:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
8010492a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010492d:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104931:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104934:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
8010493b:	83 ec 0c             	sub    $0xc,%esp
8010493e:	68 60 2f 11 80       	push   $0x80112f60
80104943:	e8 8f 05 00 00       	call   80104ed7 <release>
80104948:	83 c4 10             	add    $0x10,%esp
        return pid;
8010494b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010494e:	eb 58                	jmp    801049a8 <wait+0x122>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
80104950:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104951:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104955:	81 7d f4 94 4e 11 80 	cmpl   $0x80114e94,-0xc(%ebp)
8010495c:	0f 82 4d ff ff ff    	jb     801048af <wait+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104962:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104966:	74 0d                	je     80104975 <wait+0xef>
80104968:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010496e:	8b 40 24             	mov    0x24(%eax),%eax
80104971:	85 c0                	test   %eax,%eax
80104973:	74 17                	je     8010498c <wait+0x106>
      release(&ptable.lock);
80104975:	83 ec 0c             	sub    $0xc,%esp
80104978:	68 60 2f 11 80       	push   $0x80112f60
8010497d:	e8 55 05 00 00       	call   80104ed7 <release>
80104982:	83 c4 10             	add    $0x10,%esp
      return -1;
80104985:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010498a:	eb 1c                	jmp    801049a8 <wait+0x122>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
8010498c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104992:	83 ec 08             	sub    $0x8,%esp
80104995:	68 60 2f 11 80       	push   $0x80112f60
8010499a:	50                   	push   %eax
8010499b:	e8 d7 01 00 00       	call   80104b77 <sleep>
801049a0:	83 c4 10             	add    $0x10,%esp
  }
801049a3:	e9 f4 fe ff ff       	jmp    8010489c <wait+0x16>
}
801049a8:	c9                   	leave  
801049a9:	c3                   	ret    

801049aa <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
801049aa:	55                   	push   %ebp
801049ab:	89 e5                	mov    %esp,%ebp
801049ad:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
801049b0:	e8 49 f9 ff ff       	call   801042fe <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
801049b5:	83 ec 0c             	sub    $0xc,%esp
801049b8:	68 60 2f 11 80       	push   $0x80112f60
801049bd:	e8 ae 04 00 00       	call   80104e70 <acquire>
801049c2:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049c5:	c7 45 f4 94 2f 11 80 	movl   $0x80112f94,-0xc(%ebp)
801049cc:	eb 63                	jmp    80104a31 <scheduler+0x87>
      if(p->state != RUNNABLE)
801049ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049d1:	8b 40 0c             	mov    0xc(%eax),%eax
801049d4:	83 f8 03             	cmp    $0x3,%eax
801049d7:	75 53                	jne    80104a2c <scheduler+0x82>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
801049d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049dc:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
801049e2:	83 ec 0c             	sub    $0xc,%esp
801049e5:	ff 75 f4             	pushl  -0xc(%ebp)
801049e8:	e8 3f 32 00 00       	call   80107c2c <switchuvm>
801049ed:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
801049f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f3:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
801049fa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a00:	8b 40 1c             	mov    0x1c(%eax),%eax
80104a03:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104a0a:	83 c2 04             	add    $0x4,%edx
80104a0d:	83 ec 08             	sub    $0x8,%esp
80104a10:	50                   	push   %eax
80104a11:	52                   	push   %edx
80104a12:	e8 30 09 00 00       	call   80105347 <swtch>
80104a17:	83 c4 10             	add    $0x10,%esp
      switchkvm();
80104a1a:	e8 f0 31 00 00       	call   80107c0f <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80104a1f:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104a26:	00 00 00 00 
80104a2a:	eb 01                	jmp    80104a2d <scheduler+0x83>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;
80104a2c:	90                   	nop
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a2d:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104a31:	81 7d f4 94 4e 11 80 	cmpl   $0x80114e94,-0xc(%ebp)
80104a38:	72 94                	jb     801049ce <scheduler+0x24>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80104a3a:	83 ec 0c             	sub    $0xc,%esp
80104a3d:	68 60 2f 11 80       	push   $0x80112f60
80104a42:	e8 90 04 00 00       	call   80104ed7 <release>
80104a47:	83 c4 10             	add    $0x10,%esp

  }
80104a4a:	e9 61 ff ff ff       	jmp    801049b0 <scheduler+0x6>

80104a4f <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104a4f:	55                   	push   %ebp
80104a50:	89 e5                	mov    %esp,%ebp
80104a52:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104a55:	83 ec 0c             	sub    $0xc,%esp
80104a58:	68 60 2f 11 80       	push   $0x80112f60
80104a5d:	e8 41 05 00 00       	call   80104fa3 <holding>
80104a62:	83 c4 10             	add    $0x10,%esp
80104a65:	85 c0                	test   %eax,%eax
80104a67:	75 0d                	jne    80104a76 <sched+0x27>
    panic("sched ptable.lock");
80104a69:	83 ec 0c             	sub    $0xc,%esp
80104a6c:	68 ed b7 10 80       	push   $0x8010b7ed
80104a71:	e8 f0 ba ff ff       	call   80100566 <panic>
  if(cpu->ncli != 1)
80104a76:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104a7c:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104a82:	83 f8 01             	cmp    $0x1,%eax
80104a85:	74 0d                	je     80104a94 <sched+0x45>
    panic("sched locks");
80104a87:	83 ec 0c             	sub    $0xc,%esp
80104a8a:	68 ff b7 10 80       	push   $0x8010b7ff
80104a8f:	e8 d2 ba ff ff       	call   80100566 <panic>
  if(proc->state == RUNNING)
80104a94:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a9a:	8b 40 0c             	mov    0xc(%eax),%eax
80104a9d:	83 f8 04             	cmp    $0x4,%eax
80104aa0:	75 0d                	jne    80104aaf <sched+0x60>
    panic("sched running");
80104aa2:	83 ec 0c             	sub    $0xc,%esp
80104aa5:	68 0b b8 10 80       	push   $0x8010b80b
80104aaa:	e8 b7 ba ff ff       	call   80100566 <panic>
  if(readeflags()&FL_IF)
80104aaf:	e8 3a f8 ff ff       	call   801042ee <readeflags>
80104ab4:	25 00 02 00 00       	and    $0x200,%eax
80104ab9:	85 c0                	test   %eax,%eax
80104abb:	74 0d                	je     80104aca <sched+0x7b>
    panic("sched interruptible");
80104abd:	83 ec 0c             	sub    $0xc,%esp
80104ac0:	68 19 b8 10 80       	push   $0x8010b819
80104ac5:	e8 9c ba ff ff       	call   80100566 <panic>
  intena = cpu->intena;
80104aca:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104ad0:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104ad6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104ad9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104adf:	8b 40 04             	mov    0x4(%eax),%eax
80104ae2:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104ae9:	83 c2 1c             	add    $0x1c,%edx
80104aec:	83 ec 08             	sub    $0x8,%esp
80104aef:	50                   	push   %eax
80104af0:	52                   	push   %edx
80104af1:	e8 51 08 00 00       	call   80105347 <swtch>
80104af6:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80104af9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104aff:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b02:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104b08:	90                   	nop
80104b09:	c9                   	leave  
80104b0a:	c3                   	ret    

80104b0b <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104b0b:	55                   	push   %ebp
80104b0c:	89 e5                	mov    %esp,%ebp
80104b0e:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104b11:	83 ec 0c             	sub    $0xc,%esp
80104b14:	68 60 2f 11 80       	push   $0x80112f60
80104b19:	e8 52 03 00 00       	call   80104e70 <acquire>
80104b1e:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104b21:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b27:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104b2e:	e8 1c ff ff ff       	call   80104a4f <sched>
  release(&ptable.lock);
80104b33:	83 ec 0c             	sub    $0xc,%esp
80104b36:	68 60 2f 11 80       	push   $0x80112f60
80104b3b:	e8 97 03 00 00       	call   80104ed7 <release>
80104b40:	83 c4 10             	add    $0x10,%esp
}
80104b43:	90                   	nop
80104b44:	c9                   	leave  
80104b45:	c3                   	ret    

80104b46 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104b46:	55                   	push   %ebp
80104b47:	89 e5                	mov    %esp,%ebp
80104b49:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104b4c:	83 ec 0c             	sub    $0xc,%esp
80104b4f:	68 60 2f 11 80       	push   $0x80112f60
80104b54:	e8 7e 03 00 00       	call   80104ed7 <release>
80104b59:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104b5c:	a1 08 e0 10 80       	mov    0x8010e008,%eax
80104b61:	85 c0                	test   %eax,%eax
80104b63:	74 0f                	je     80104b74 <forkret+0x2e>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104b65:	c7 05 08 e0 10 80 00 	movl   $0x0,0x8010e008
80104b6c:	00 00 00 
    initlog();
80104b6f:	e8 7c e7 ff ff       	call   801032f0 <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80104b74:	90                   	nop
80104b75:	c9                   	leave  
80104b76:	c3                   	ret    

80104b77 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104b77:	55                   	push   %ebp
80104b78:	89 e5                	mov    %esp,%ebp
80104b7a:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
80104b7d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b83:	85 c0                	test   %eax,%eax
80104b85:	75 0d                	jne    80104b94 <sleep+0x1d>
    panic("sleep");
80104b87:	83 ec 0c             	sub    $0xc,%esp
80104b8a:	68 2d b8 10 80       	push   $0x8010b82d
80104b8f:	e8 d2 b9 ff ff       	call   80100566 <panic>

  if(lk == 0)
80104b94:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104b98:	75 0d                	jne    80104ba7 <sleep+0x30>
    panic("sleep without lk");
80104b9a:	83 ec 0c             	sub    $0xc,%esp
80104b9d:	68 33 b8 10 80       	push   $0x8010b833
80104ba2:	e8 bf b9 ff ff       	call   80100566 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104ba7:	81 7d 0c 60 2f 11 80 	cmpl   $0x80112f60,0xc(%ebp)
80104bae:	74 1e                	je     80104bce <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104bb0:	83 ec 0c             	sub    $0xc,%esp
80104bb3:	68 60 2f 11 80       	push   $0x80112f60
80104bb8:	e8 b3 02 00 00       	call   80104e70 <acquire>
80104bbd:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104bc0:	83 ec 0c             	sub    $0xc,%esp
80104bc3:	ff 75 0c             	pushl  0xc(%ebp)
80104bc6:	e8 0c 03 00 00       	call   80104ed7 <release>
80104bcb:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80104bce:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bd4:	8b 55 08             	mov    0x8(%ebp),%edx
80104bd7:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104bda:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104be0:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104be7:	e8 63 fe ff ff       	call   80104a4f <sched>

  // Tidy up.
  proc->chan = 0;
80104bec:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bf2:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104bf9:	81 7d 0c 60 2f 11 80 	cmpl   $0x80112f60,0xc(%ebp)
80104c00:	74 1e                	je     80104c20 <sleep+0xa9>
    release(&ptable.lock);
80104c02:	83 ec 0c             	sub    $0xc,%esp
80104c05:	68 60 2f 11 80       	push   $0x80112f60
80104c0a:	e8 c8 02 00 00       	call   80104ed7 <release>
80104c0f:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104c12:	83 ec 0c             	sub    $0xc,%esp
80104c15:	ff 75 0c             	pushl  0xc(%ebp)
80104c18:	e8 53 02 00 00       	call   80104e70 <acquire>
80104c1d:	83 c4 10             	add    $0x10,%esp
  }
}
80104c20:	90                   	nop
80104c21:	c9                   	leave  
80104c22:	c3                   	ret    

80104c23 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104c23:	55                   	push   %ebp
80104c24:	89 e5                	mov    %esp,%ebp
80104c26:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c29:	c7 45 fc 94 2f 11 80 	movl   $0x80112f94,-0x4(%ebp)
80104c30:	eb 24                	jmp    80104c56 <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104c32:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c35:	8b 40 0c             	mov    0xc(%eax),%eax
80104c38:	83 f8 02             	cmp    $0x2,%eax
80104c3b:	75 15                	jne    80104c52 <wakeup1+0x2f>
80104c3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c40:	8b 40 20             	mov    0x20(%eax),%eax
80104c43:	3b 45 08             	cmp    0x8(%ebp),%eax
80104c46:	75 0a                	jne    80104c52 <wakeup1+0x2f>
      p->state = RUNNABLE;
80104c48:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c4b:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c52:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
80104c56:	81 7d fc 94 4e 11 80 	cmpl   $0x80114e94,-0x4(%ebp)
80104c5d:	72 d3                	jb     80104c32 <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
80104c5f:	90                   	nop
80104c60:	c9                   	leave  
80104c61:	c3                   	ret    

80104c62 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104c62:	55                   	push   %ebp
80104c63:	89 e5                	mov    %esp,%ebp
80104c65:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104c68:	83 ec 0c             	sub    $0xc,%esp
80104c6b:	68 60 2f 11 80       	push   $0x80112f60
80104c70:	e8 fb 01 00 00       	call   80104e70 <acquire>
80104c75:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104c78:	83 ec 0c             	sub    $0xc,%esp
80104c7b:	ff 75 08             	pushl  0x8(%ebp)
80104c7e:	e8 a0 ff ff ff       	call   80104c23 <wakeup1>
80104c83:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104c86:	83 ec 0c             	sub    $0xc,%esp
80104c89:	68 60 2f 11 80       	push   $0x80112f60
80104c8e:	e8 44 02 00 00       	call   80104ed7 <release>
80104c93:	83 c4 10             	add    $0x10,%esp
}
80104c96:	90                   	nop
80104c97:	c9                   	leave  
80104c98:	c3                   	ret    

80104c99 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104c99:	55                   	push   %ebp
80104c9a:	89 e5                	mov    %esp,%ebp
80104c9c:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104c9f:	83 ec 0c             	sub    $0xc,%esp
80104ca2:	68 60 2f 11 80       	push   $0x80112f60
80104ca7:	e8 c4 01 00 00       	call   80104e70 <acquire>
80104cac:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104caf:	c7 45 f4 94 2f 11 80 	movl   $0x80112f94,-0xc(%ebp)
80104cb6:	eb 45                	jmp    80104cfd <kill+0x64>
    if(p->pid == pid){
80104cb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cbb:	8b 40 10             	mov    0x10(%eax),%eax
80104cbe:	3b 45 08             	cmp    0x8(%ebp),%eax
80104cc1:	75 36                	jne    80104cf9 <kill+0x60>
      p->killed = 1;
80104cc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cc6:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104ccd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cd0:	8b 40 0c             	mov    0xc(%eax),%eax
80104cd3:	83 f8 02             	cmp    $0x2,%eax
80104cd6:	75 0a                	jne    80104ce2 <kill+0x49>
        p->state = RUNNABLE;
80104cd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cdb:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104ce2:	83 ec 0c             	sub    $0xc,%esp
80104ce5:	68 60 2f 11 80       	push   $0x80112f60
80104cea:	e8 e8 01 00 00       	call   80104ed7 <release>
80104cef:	83 c4 10             	add    $0x10,%esp
      return 0;
80104cf2:	b8 00 00 00 00       	mov    $0x0,%eax
80104cf7:	eb 22                	jmp    80104d1b <kill+0x82>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cf9:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104cfd:	81 7d f4 94 4e 11 80 	cmpl   $0x80114e94,-0xc(%ebp)
80104d04:	72 b2                	jb     80104cb8 <kill+0x1f>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104d06:	83 ec 0c             	sub    $0xc,%esp
80104d09:	68 60 2f 11 80       	push   $0x80112f60
80104d0e:	e8 c4 01 00 00       	call   80104ed7 <release>
80104d13:	83 c4 10             	add    $0x10,%esp
  return -1;
80104d16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d1b:	c9                   	leave  
80104d1c:	c3                   	ret    

80104d1d <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104d1d:	55                   	push   %ebp
80104d1e:	89 e5                	mov    %esp,%ebp
80104d20:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d23:	c7 45 f0 94 2f 11 80 	movl   $0x80112f94,-0x10(%ebp)
80104d2a:	e9 d7 00 00 00       	jmp    80104e06 <procdump+0xe9>
    if(p->state == UNUSED)
80104d2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d32:	8b 40 0c             	mov    0xc(%eax),%eax
80104d35:	85 c0                	test   %eax,%eax
80104d37:	0f 84 c4 00 00 00    	je     80104e01 <procdump+0xe4>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104d3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d40:	8b 40 0c             	mov    0xc(%eax),%eax
80104d43:	83 f8 05             	cmp    $0x5,%eax
80104d46:	77 23                	ja     80104d6b <procdump+0x4e>
80104d48:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d4b:	8b 40 0c             	mov    0xc(%eax),%eax
80104d4e:	8b 04 85 0c e0 10 80 	mov    -0x7fef1ff4(,%eax,4),%eax
80104d55:	85 c0                	test   %eax,%eax
80104d57:	74 12                	je     80104d6b <procdump+0x4e>
      state = states[p->state];
80104d59:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d5c:	8b 40 0c             	mov    0xc(%eax),%eax
80104d5f:	8b 04 85 0c e0 10 80 	mov    -0x7fef1ff4(,%eax,4),%eax
80104d66:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104d69:	eb 07                	jmp    80104d72 <procdump+0x55>
    else
      state = "???";
80104d6b:	c7 45 ec 44 b8 10 80 	movl   $0x8010b844,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104d72:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d75:	8d 50 6c             	lea    0x6c(%eax),%edx
80104d78:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d7b:	8b 40 10             	mov    0x10(%eax),%eax
80104d7e:	52                   	push   %edx
80104d7f:	ff 75 ec             	pushl  -0x14(%ebp)
80104d82:	50                   	push   %eax
80104d83:	68 48 b8 10 80       	push   $0x8010b848
80104d88:	e8 39 b6 ff ff       	call   801003c6 <cprintf>
80104d8d:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80104d90:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d93:	8b 40 0c             	mov    0xc(%eax),%eax
80104d96:	83 f8 02             	cmp    $0x2,%eax
80104d99:	75 54                	jne    80104def <procdump+0xd2>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104d9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d9e:	8b 40 1c             	mov    0x1c(%eax),%eax
80104da1:	8b 40 0c             	mov    0xc(%eax),%eax
80104da4:	83 c0 08             	add    $0x8,%eax
80104da7:	89 c2                	mov    %eax,%edx
80104da9:	83 ec 08             	sub    $0x8,%esp
80104dac:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104daf:	50                   	push   %eax
80104db0:	52                   	push   %edx
80104db1:	e8 73 01 00 00       	call   80104f29 <getcallerpcs>
80104db6:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104db9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104dc0:	eb 1c                	jmp    80104dde <procdump+0xc1>
        cprintf(" %p", pc[i]);
80104dc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104dc5:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104dc9:	83 ec 08             	sub    $0x8,%esp
80104dcc:	50                   	push   %eax
80104dcd:	68 51 b8 10 80       	push   $0x8010b851
80104dd2:	e8 ef b5 ff ff       	call   801003c6 <cprintf>
80104dd7:	83 c4 10             	add    $0x10,%esp
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104dda:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104dde:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104de2:	7f 0b                	jg     80104def <procdump+0xd2>
80104de4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104de7:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104deb:	85 c0                	test   %eax,%eax
80104ded:	75 d3                	jne    80104dc2 <procdump+0xa5>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104def:	83 ec 0c             	sub    $0xc,%esp
80104df2:	68 55 b8 10 80       	push   $0x8010b855
80104df7:	e8 ca b5 ff ff       	call   801003c6 <cprintf>
80104dfc:	83 c4 10             	add    $0x10,%esp
80104dff:	eb 01                	jmp    80104e02 <procdump+0xe5>
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
80104e01:	90                   	nop
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e02:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104e06:	81 7d f0 94 4e 11 80 	cmpl   $0x80114e94,-0x10(%ebp)
80104e0d:	0f 82 1c ff ff ff    	jb     80104d2f <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104e13:	90                   	nop
80104e14:	c9                   	leave  
80104e15:	c3                   	ret    

80104e16 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104e16:	55                   	push   %ebp
80104e17:	89 e5                	mov    %esp,%ebp
80104e19:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104e1c:	9c                   	pushf  
80104e1d:	58                   	pop    %eax
80104e1e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104e21:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104e24:	c9                   	leave  
80104e25:	c3                   	ret    

80104e26 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80104e26:	55                   	push   %ebp
80104e27:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104e29:	fa                   	cli    
}
80104e2a:	90                   	nop
80104e2b:	5d                   	pop    %ebp
80104e2c:	c3                   	ret    

80104e2d <sti>:

static inline void
sti(void)
{
80104e2d:	55                   	push   %ebp
80104e2e:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104e30:	fb                   	sti    
}
80104e31:	90                   	nop
80104e32:	5d                   	pop    %ebp
80104e33:	c3                   	ret    

80104e34 <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80104e34:	55                   	push   %ebp
80104e35:	89 e5                	mov    %esp,%ebp
80104e37:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104e3a:	8b 55 08             	mov    0x8(%ebp),%edx
80104e3d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e40:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e43:	f0 87 02             	lock xchg %eax,(%edx)
80104e46:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104e49:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104e4c:	c9                   	leave  
80104e4d:	c3                   	ret    

80104e4e <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104e4e:	55                   	push   %ebp
80104e4f:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104e51:	8b 45 08             	mov    0x8(%ebp),%eax
80104e54:	8b 55 0c             	mov    0xc(%ebp),%edx
80104e57:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104e5a:	8b 45 08             	mov    0x8(%ebp),%eax
80104e5d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104e63:	8b 45 08             	mov    0x8(%ebp),%eax
80104e66:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104e6d:	90                   	nop
80104e6e:	5d                   	pop    %ebp
80104e6f:	c3                   	ret    

80104e70 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
80104e73:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104e76:	e8 52 01 00 00       	call   80104fcd <pushcli>
  if(holding(lk))
80104e7b:	8b 45 08             	mov    0x8(%ebp),%eax
80104e7e:	83 ec 0c             	sub    $0xc,%esp
80104e81:	50                   	push   %eax
80104e82:	e8 1c 01 00 00       	call   80104fa3 <holding>
80104e87:	83 c4 10             	add    $0x10,%esp
80104e8a:	85 c0                	test   %eax,%eax
80104e8c:	74 0d                	je     80104e9b <acquire+0x2b>
    panic("acquire");
80104e8e:	83 ec 0c             	sub    $0xc,%esp
80104e91:	68 81 b8 10 80       	push   $0x8010b881
80104e96:	e8 cb b6 ff ff       	call   80100566 <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80104e9b:	90                   	nop
80104e9c:	8b 45 08             	mov    0x8(%ebp),%eax
80104e9f:	83 ec 08             	sub    $0x8,%esp
80104ea2:	6a 01                	push   $0x1
80104ea4:	50                   	push   %eax
80104ea5:	e8 8a ff ff ff       	call   80104e34 <xchg>
80104eaa:	83 c4 10             	add    $0x10,%esp
80104ead:	85 c0                	test   %eax,%eax
80104eaf:	75 eb                	jne    80104e9c <acquire+0x2c>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104eb1:	8b 45 08             	mov    0x8(%ebp),%eax
80104eb4:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104ebb:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104ebe:	8b 45 08             	mov    0x8(%ebp),%eax
80104ec1:	83 c0 0c             	add    $0xc,%eax
80104ec4:	83 ec 08             	sub    $0x8,%esp
80104ec7:	50                   	push   %eax
80104ec8:	8d 45 08             	lea    0x8(%ebp),%eax
80104ecb:	50                   	push   %eax
80104ecc:	e8 58 00 00 00       	call   80104f29 <getcallerpcs>
80104ed1:	83 c4 10             	add    $0x10,%esp
}
80104ed4:	90                   	nop
80104ed5:	c9                   	leave  
80104ed6:	c3                   	ret    

80104ed7 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80104ed7:	55                   	push   %ebp
80104ed8:	89 e5                	mov    %esp,%ebp
80104eda:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
80104edd:	83 ec 0c             	sub    $0xc,%esp
80104ee0:	ff 75 08             	pushl  0x8(%ebp)
80104ee3:	e8 bb 00 00 00       	call   80104fa3 <holding>
80104ee8:	83 c4 10             	add    $0x10,%esp
80104eeb:	85 c0                	test   %eax,%eax
80104eed:	75 0d                	jne    80104efc <release+0x25>
    panic("release");
80104eef:	83 ec 0c             	sub    $0xc,%esp
80104ef2:	68 89 b8 10 80       	push   $0x8010b889
80104ef7:	e8 6a b6 ff ff       	call   80100566 <panic>

  lk->pcs[0] = 0;
80104efc:	8b 45 08             	mov    0x8(%ebp),%eax
80104eff:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104f06:	8b 45 08             	mov    0x8(%ebp),%eax
80104f09:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80104f10:	8b 45 08             	mov    0x8(%ebp),%eax
80104f13:	83 ec 08             	sub    $0x8,%esp
80104f16:	6a 00                	push   $0x0
80104f18:	50                   	push   %eax
80104f19:	e8 16 ff ff ff       	call   80104e34 <xchg>
80104f1e:	83 c4 10             	add    $0x10,%esp

  popcli();
80104f21:	e8 ec 00 00 00       	call   80105012 <popcli>
}
80104f26:	90                   	nop
80104f27:	c9                   	leave  
80104f28:	c3                   	ret    

80104f29 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104f29:	55                   	push   %ebp
80104f2a:	89 e5                	mov    %esp,%ebp
80104f2c:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80104f2f:	8b 45 08             	mov    0x8(%ebp),%eax
80104f32:	83 e8 08             	sub    $0x8,%eax
80104f35:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80104f38:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80104f3f:	eb 38                	jmp    80104f79 <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f41:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80104f45:	74 53                	je     80104f9a <getcallerpcs+0x71>
80104f47:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80104f4e:	76 4a                	jbe    80104f9a <getcallerpcs+0x71>
80104f50:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80104f54:	74 44                	je     80104f9a <getcallerpcs+0x71>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104f56:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104f59:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104f60:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f63:	01 c2                	add    %eax,%edx
80104f65:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f68:	8b 40 04             	mov    0x4(%eax),%eax
80104f6b:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80104f6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f70:	8b 00                	mov    (%eax),%eax
80104f72:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104f75:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104f79:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104f7d:	7e c2                	jle    80104f41 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104f7f:	eb 19                	jmp    80104f9a <getcallerpcs+0x71>
    pcs[i] = 0;
80104f81:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104f84:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104f8b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f8e:	01 d0                	add    %edx,%eax
80104f90:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104f96:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104f9a:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104f9e:	7e e1                	jle    80104f81 <getcallerpcs+0x58>
    pcs[i] = 0;
}
80104fa0:	90                   	nop
80104fa1:	c9                   	leave  
80104fa2:	c3                   	ret    

80104fa3 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104fa3:	55                   	push   %ebp
80104fa4:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80104fa6:	8b 45 08             	mov    0x8(%ebp),%eax
80104fa9:	8b 00                	mov    (%eax),%eax
80104fab:	85 c0                	test   %eax,%eax
80104fad:	74 17                	je     80104fc6 <holding+0x23>
80104faf:	8b 45 08             	mov    0x8(%ebp),%eax
80104fb2:	8b 50 08             	mov    0x8(%eax),%edx
80104fb5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104fbb:	39 c2                	cmp    %eax,%edx
80104fbd:	75 07                	jne    80104fc6 <holding+0x23>
80104fbf:	b8 01 00 00 00       	mov    $0x1,%eax
80104fc4:	eb 05                	jmp    80104fcb <holding+0x28>
80104fc6:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104fcb:	5d                   	pop    %ebp
80104fcc:	c3                   	ret    

80104fcd <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104fcd:	55                   	push   %ebp
80104fce:	89 e5                	mov    %esp,%ebp
80104fd0:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80104fd3:	e8 3e fe ff ff       	call   80104e16 <readeflags>
80104fd8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80104fdb:	e8 46 fe ff ff       	call   80104e26 <cli>
  if(cpu->ncli++ == 0)
80104fe0:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104fe7:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80104fed:	8d 48 01             	lea    0x1(%eax),%ecx
80104ff0:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
80104ff6:	85 c0                	test   %eax,%eax
80104ff8:	75 15                	jne    8010500f <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
80104ffa:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105000:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105003:	81 e2 00 02 00 00    	and    $0x200,%edx
80105009:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
8010500f:	90                   	nop
80105010:	c9                   	leave  
80105011:	c3                   	ret    

80105012 <popcli>:

void
popcli(void)
{
80105012:	55                   	push   %ebp
80105013:	89 e5                	mov    %esp,%ebp
80105015:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
80105018:	e8 f9 fd ff ff       	call   80104e16 <readeflags>
8010501d:	25 00 02 00 00       	and    $0x200,%eax
80105022:	85 c0                	test   %eax,%eax
80105024:	74 0d                	je     80105033 <popcli+0x21>
    panic("popcli - interruptible");
80105026:	83 ec 0c             	sub    $0xc,%esp
80105029:	68 91 b8 10 80       	push   $0x8010b891
8010502e:	e8 33 b5 ff ff       	call   80100566 <panic>
  if(--cpu->ncli < 0)
80105033:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105039:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
8010503f:	83 ea 01             	sub    $0x1,%edx
80105042:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80105048:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010504e:	85 c0                	test   %eax,%eax
80105050:	79 0d                	jns    8010505f <popcli+0x4d>
    panic("popcli");
80105052:	83 ec 0c             	sub    $0xc,%esp
80105055:	68 a8 b8 10 80       	push   $0x8010b8a8
8010505a:	e8 07 b5 ff ff       	call   80100566 <panic>
  if(cpu->ncli == 0 && cpu->intena)
8010505f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105065:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010506b:	85 c0                	test   %eax,%eax
8010506d:	75 15                	jne    80105084 <popcli+0x72>
8010506f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105075:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
8010507b:	85 c0                	test   %eax,%eax
8010507d:	74 05                	je     80105084 <popcli+0x72>
    sti();
8010507f:	e8 a9 fd ff ff       	call   80104e2d <sti>
}
80105084:	90                   	nop
80105085:	c9                   	leave  
80105086:	c3                   	ret    

80105087 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
80105087:	55                   	push   %ebp
80105088:	89 e5                	mov    %esp,%ebp
8010508a:	57                   	push   %edi
8010508b:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
8010508c:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010508f:	8b 55 10             	mov    0x10(%ebp),%edx
80105092:	8b 45 0c             	mov    0xc(%ebp),%eax
80105095:	89 cb                	mov    %ecx,%ebx
80105097:	89 df                	mov    %ebx,%edi
80105099:	89 d1                	mov    %edx,%ecx
8010509b:	fc                   	cld    
8010509c:	f3 aa                	rep stos %al,%es:(%edi)
8010509e:	89 ca                	mov    %ecx,%edx
801050a0:	89 fb                	mov    %edi,%ebx
801050a2:	89 5d 08             	mov    %ebx,0x8(%ebp)
801050a5:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
801050a8:	90                   	nop
801050a9:	5b                   	pop    %ebx
801050aa:	5f                   	pop    %edi
801050ab:	5d                   	pop    %ebp
801050ac:	c3                   	ret    

801050ad <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
801050ad:	55                   	push   %ebp
801050ae:	89 e5                	mov    %esp,%ebp
801050b0:	57                   	push   %edi
801050b1:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
801050b2:	8b 4d 08             	mov    0x8(%ebp),%ecx
801050b5:	8b 55 10             	mov    0x10(%ebp),%edx
801050b8:	8b 45 0c             	mov    0xc(%ebp),%eax
801050bb:	89 cb                	mov    %ecx,%ebx
801050bd:	89 df                	mov    %ebx,%edi
801050bf:	89 d1                	mov    %edx,%ecx
801050c1:	fc                   	cld    
801050c2:	f3 ab                	rep stos %eax,%es:(%edi)
801050c4:	89 ca                	mov    %ecx,%edx
801050c6:	89 fb                	mov    %edi,%ebx
801050c8:	89 5d 08             	mov    %ebx,0x8(%ebp)
801050cb:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
801050ce:	90                   	nop
801050cf:	5b                   	pop    %ebx
801050d0:	5f                   	pop    %edi
801050d1:	5d                   	pop    %ebp
801050d2:	c3                   	ret    

801050d3 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801050d3:	55                   	push   %ebp
801050d4:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
801050d6:	8b 45 08             	mov    0x8(%ebp),%eax
801050d9:	83 e0 03             	and    $0x3,%eax
801050dc:	85 c0                	test   %eax,%eax
801050de:	75 43                	jne    80105123 <memset+0x50>
801050e0:	8b 45 10             	mov    0x10(%ebp),%eax
801050e3:	83 e0 03             	and    $0x3,%eax
801050e6:	85 c0                	test   %eax,%eax
801050e8:	75 39                	jne    80105123 <memset+0x50>
    c &= 0xFF;
801050ea:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801050f1:	8b 45 10             	mov    0x10(%ebp),%eax
801050f4:	c1 e8 02             	shr    $0x2,%eax
801050f7:	89 c1                	mov    %eax,%ecx
801050f9:	8b 45 0c             	mov    0xc(%ebp),%eax
801050fc:	c1 e0 18             	shl    $0x18,%eax
801050ff:	89 c2                	mov    %eax,%edx
80105101:	8b 45 0c             	mov    0xc(%ebp),%eax
80105104:	c1 e0 10             	shl    $0x10,%eax
80105107:	09 c2                	or     %eax,%edx
80105109:	8b 45 0c             	mov    0xc(%ebp),%eax
8010510c:	c1 e0 08             	shl    $0x8,%eax
8010510f:	09 d0                	or     %edx,%eax
80105111:	0b 45 0c             	or     0xc(%ebp),%eax
80105114:	51                   	push   %ecx
80105115:	50                   	push   %eax
80105116:	ff 75 08             	pushl  0x8(%ebp)
80105119:	e8 8f ff ff ff       	call   801050ad <stosl>
8010511e:	83 c4 0c             	add    $0xc,%esp
80105121:	eb 12                	jmp    80105135 <memset+0x62>
  } else
    stosb(dst, c, n);
80105123:	8b 45 10             	mov    0x10(%ebp),%eax
80105126:	50                   	push   %eax
80105127:	ff 75 0c             	pushl  0xc(%ebp)
8010512a:	ff 75 08             	pushl  0x8(%ebp)
8010512d:	e8 55 ff ff ff       	call   80105087 <stosb>
80105132:	83 c4 0c             	add    $0xc,%esp
  return dst;
80105135:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105138:	c9                   	leave  
80105139:	c3                   	ret    

8010513a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
8010513a:	55                   	push   %ebp
8010513b:	89 e5                	mov    %esp,%ebp
8010513d:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
80105140:	8b 45 08             	mov    0x8(%ebp),%eax
80105143:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
80105146:	8b 45 0c             	mov    0xc(%ebp),%eax
80105149:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
8010514c:	eb 30                	jmp    8010517e <memcmp+0x44>
    if(*s1 != *s2)
8010514e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105151:	0f b6 10             	movzbl (%eax),%edx
80105154:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105157:	0f b6 00             	movzbl (%eax),%eax
8010515a:	38 c2                	cmp    %al,%dl
8010515c:	74 18                	je     80105176 <memcmp+0x3c>
      return *s1 - *s2;
8010515e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105161:	0f b6 00             	movzbl (%eax),%eax
80105164:	0f b6 d0             	movzbl %al,%edx
80105167:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010516a:	0f b6 00             	movzbl (%eax),%eax
8010516d:	0f b6 c0             	movzbl %al,%eax
80105170:	29 c2                	sub    %eax,%edx
80105172:	89 d0                	mov    %edx,%eax
80105174:	eb 1a                	jmp    80105190 <memcmp+0x56>
    s1++, s2++;
80105176:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010517a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010517e:	8b 45 10             	mov    0x10(%ebp),%eax
80105181:	8d 50 ff             	lea    -0x1(%eax),%edx
80105184:	89 55 10             	mov    %edx,0x10(%ebp)
80105187:	85 c0                	test   %eax,%eax
80105189:	75 c3                	jne    8010514e <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010518b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105190:	c9                   	leave  
80105191:	c3                   	ret    

80105192 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105192:	55                   	push   %ebp
80105193:	89 e5                	mov    %esp,%ebp
80105195:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
80105198:	8b 45 0c             	mov    0xc(%ebp),%eax
8010519b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
8010519e:	8b 45 08             	mov    0x8(%ebp),%eax
801051a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
801051a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051a7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801051aa:	73 54                	jae    80105200 <memmove+0x6e>
801051ac:	8b 55 fc             	mov    -0x4(%ebp),%edx
801051af:	8b 45 10             	mov    0x10(%ebp),%eax
801051b2:	01 d0                	add    %edx,%eax
801051b4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801051b7:	76 47                	jbe    80105200 <memmove+0x6e>
    s += n;
801051b9:	8b 45 10             	mov    0x10(%ebp),%eax
801051bc:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
801051bf:	8b 45 10             	mov    0x10(%ebp),%eax
801051c2:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
801051c5:	eb 13                	jmp    801051da <memmove+0x48>
      *--d = *--s;
801051c7:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
801051cb:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
801051cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051d2:	0f b6 10             	movzbl (%eax),%edx
801051d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051d8:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801051da:	8b 45 10             	mov    0x10(%ebp),%eax
801051dd:	8d 50 ff             	lea    -0x1(%eax),%edx
801051e0:	89 55 10             	mov    %edx,0x10(%ebp)
801051e3:	85 c0                	test   %eax,%eax
801051e5:	75 e0                	jne    801051c7 <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801051e7:	eb 24                	jmp    8010520d <memmove+0x7b>
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;
801051e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051ec:	8d 50 01             	lea    0x1(%eax),%edx
801051ef:	89 55 f8             	mov    %edx,-0x8(%ebp)
801051f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
801051f5:	8d 4a 01             	lea    0x1(%edx),%ecx
801051f8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
801051fb:	0f b6 12             	movzbl (%edx),%edx
801051fe:	88 10                	mov    %dl,(%eax)
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105200:	8b 45 10             	mov    0x10(%ebp),%eax
80105203:	8d 50 ff             	lea    -0x1(%eax),%edx
80105206:	89 55 10             	mov    %edx,0x10(%ebp)
80105209:	85 c0                	test   %eax,%eax
8010520b:	75 dc                	jne    801051e9 <memmove+0x57>
      *d++ = *s++;

  return dst;
8010520d:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105210:	c9                   	leave  
80105211:	c3                   	ret    

80105212 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105212:	55                   	push   %ebp
80105213:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
80105215:	ff 75 10             	pushl  0x10(%ebp)
80105218:	ff 75 0c             	pushl  0xc(%ebp)
8010521b:	ff 75 08             	pushl  0x8(%ebp)
8010521e:	e8 6f ff ff ff       	call   80105192 <memmove>
80105223:	83 c4 0c             	add    $0xc,%esp
}
80105226:	c9                   	leave  
80105227:	c3                   	ret    

80105228 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105228:	55                   	push   %ebp
80105229:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
8010522b:	eb 0c                	jmp    80105239 <strncmp+0x11>
    n--, p++, q++;
8010522d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105231:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105235:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80105239:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010523d:	74 1a                	je     80105259 <strncmp+0x31>
8010523f:	8b 45 08             	mov    0x8(%ebp),%eax
80105242:	0f b6 00             	movzbl (%eax),%eax
80105245:	84 c0                	test   %al,%al
80105247:	74 10                	je     80105259 <strncmp+0x31>
80105249:	8b 45 08             	mov    0x8(%ebp),%eax
8010524c:	0f b6 10             	movzbl (%eax),%edx
8010524f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105252:	0f b6 00             	movzbl (%eax),%eax
80105255:	38 c2                	cmp    %al,%dl
80105257:	74 d4                	je     8010522d <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
80105259:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010525d:	75 07                	jne    80105266 <strncmp+0x3e>
    return 0;
8010525f:	b8 00 00 00 00       	mov    $0x0,%eax
80105264:	eb 16                	jmp    8010527c <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
80105266:	8b 45 08             	mov    0x8(%ebp),%eax
80105269:	0f b6 00             	movzbl (%eax),%eax
8010526c:	0f b6 d0             	movzbl %al,%edx
8010526f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105272:	0f b6 00             	movzbl (%eax),%eax
80105275:	0f b6 c0             	movzbl %al,%eax
80105278:	29 c2                	sub    %eax,%edx
8010527a:	89 d0                	mov    %edx,%eax
}
8010527c:	5d                   	pop    %ebp
8010527d:	c3                   	ret    

8010527e <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
8010527e:	55                   	push   %ebp
8010527f:	89 e5                	mov    %esp,%ebp
80105281:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105284:	8b 45 08             	mov    0x8(%ebp),%eax
80105287:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
8010528a:	90                   	nop
8010528b:	8b 45 10             	mov    0x10(%ebp),%eax
8010528e:	8d 50 ff             	lea    -0x1(%eax),%edx
80105291:	89 55 10             	mov    %edx,0x10(%ebp)
80105294:	85 c0                	test   %eax,%eax
80105296:	7e 2c                	jle    801052c4 <strncpy+0x46>
80105298:	8b 45 08             	mov    0x8(%ebp),%eax
8010529b:	8d 50 01             	lea    0x1(%eax),%edx
8010529e:	89 55 08             	mov    %edx,0x8(%ebp)
801052a1:	8b 55 0c             	mov    0xc(%ebp),%edx
801052a4:	8d 4a 01             	lea    0x1(%edx),%ecx
801052a7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
801052aa:	0f b6 12             	movzbl (%edx),%edx
801052ad:	88 10                	mov    %dl,(%eax)
801052af:	0f b6 00             	movzbl (%eax),%eax
801052b2:	84 c0                	test   %al,%al
801052b4:	75 d5                	jne    8010528b <strncpy+0xd>
    ;
  while(n-- > 0)
801052b6:	eb 0c                	jmp    801052c4 <strncpy+0x46>
    *s++ = 0;
801052b8:	8b 45 08             	mov    0x8(%ebp),%eax
801052bb:	8d 50 01             	lea    0x1(%eax),%edx
801052be:	89 55 08             	mov    %edx,0x8(%ebp)
801052c1:	c6 00 00             	movb   $0x0,(%eax)
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801052c4:	8b 45 10             	mov    0x10(%ebp),%eax
801052c7:	8d 50 ff             	lea    -0x1(%eax),%edx
801052ca:	89 55 10             	mov    %edx,0x10(%ebp)
801052cd:	85 c0                	test   %eax,%eax
801052cf:	7f e7                	jg     801052b8 <strncpy+0x3a>
    *s++ = 0;
  return os;
801052d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801052d4:	c9                   	leave  
801052d5:	c3                   	ret    

801052d6 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801052d6:	55                   	push   %ebp
801052d7:	89 e5                	mov    %esp,%ebp
801052d9:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
801052dc:	8b 45 08             	mov    0x8(%ebp),%eax
801052df:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
801052e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801052e6:	7f 05                	jg     801052ed <safestrcpy+0x17>
    return os;
801052e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052eb:	eb 31                	jmp    8010531e <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
801052ed:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801052f1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801052f5:	7e 1e                	jle    80105315 <safestrcpy+0x3f>
801052f7:	8b 45 08             	mov    0x8(%ebp),%eax
801052fa:	8d 50 01             	lea    0x1(%eax),%edx
801052fd:	89 55 08             	mov    %edx,0x8(%ebp)
80105300:	8b 55 0c             	mov    0xc(%ebp),%edx
80105303:	8d 4a 01             	lea    0x1(%edx),%ecx
80105306:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80105309:	0f b6 12             	movzbl (%edx),%edx
8010530c:	88 10                	mov    %dl,(%eax)
8010530e:	0f b6 00             	movzbl (%eax),%eax
80105311:	84 c0                	test   %al,%al
80105313:	75 d8                	jne    801052ed <safestrcpy+0x17>
    ;
  *s = 0;
80105315:	8b 45 08             	mov    0x8(%ebp),%eax
80105318:	c6 00 00             	movb   $0x0,(%eax)
  return os;
8010531b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010531e:	c9                   	leave  
8010531f:	c3                   	ret    

80105320 <strlen>:

int
strlen(const char *s)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
80105326:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010532d:	eb 04                	jmp    80105333 <strlen+0x13>
8010532f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105333:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105336:	8b 45 08             	mov    0x8(%ebp),%eax
80105339:	01 d0                	add    %edx,%eax
8010533b:	0f b6 00             	movzbl (%eax),%eax
8010533e:	84 c0                	test   %al,%al
80105340:	75 ed                	jne    8010532f <strlen+0xf>
    ;
  return n;
80105342:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105345:	c9                   	leave  
80105346:	c3                   	ret    

80105347 <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105347:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010534b:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
8010534f:	55                   	push   %ebp
  pushl %ebx
80105350:	53                   	push   %ebx
  pushl %esi
80105351:	56                   	push   %esi
  pushl %edi
80105352:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105353:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105355:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80105357:	5f                   	pop    %edi
  popl %esi
80105358:	5e                   	pop    %esi
  popl %ebx
80105359:	5b                   	pop    %ebx
  popl %ebp
8010535a:	5d                   	pop    %ebp
  ret
8010535b:	c3                   	ret    

8010535c <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
8010535c:	55                   	push   %ebp
8010535d:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
8010535f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105365:	8b 00                	mov    (%eax),%eax
80105367:	3b 45 08             	cmp    0x8(%ebp),%eax
8010536a:	76 12                	jbe    8010537e <fetchint+0x22>
8010536c:	8b 45 08             	mov    0x8(%ebp),%eax
8010536f:	8d 50 04             	lea    0x4(%eax),%edx
80105372:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105378:	8b 00                	mov    (%eax),%eax
8010537a:	39 c2                	cmp    %eax,%edx
8010537c:	76 07                	jbe    80105385 <fetchint+0x29>
    return -1;
8010537e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105383:	eb 0f                	jmp    80105394 <fetchint+0x38>
  *ip = *(int*)(addr);
80105385:	8b 45 08             	mov    0x8(%ebp),%eax
80105388:	8b 10                	mov    (%eax),%edx
8010538a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010538d:	89 10                	mov    %edx,(%eax)
  return 0;
8010538f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105394:	5d                   	pop    %ebp
80105395:	c3                   	ret    

80105396 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105396:	55                   	push   %ebp
80105397:	89 e5                	mov    %esp,%ebp
80105399:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
8010539c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053a2:	8b 00                	mov    (%eax),%eax
801053a4:	3b 45 08             	cmp    0x8(%ebp),%eax
801053a7:	77 07                	ja     801053b0 <fetchstr+0x1a>
    return -1;
801053a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053ae:	eb 46                	jmp    801053f6 <fetchstr+0x60>
  *pp = (char*)addr;
801053b0:	8b 55 08             	mov    0x8(%ebp),%edx
801053b3:	8b 45 0c             	mov    0xc(%ebp),%eax
801053b6:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
801053b8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053be:	8b 00                	mov    (%eax),%eax
801053c0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
801053c3:	8b 45 0c             	mov    0xc(%ebp),%eax
801053c6:	8b 00                	mov    (%eax),%eax
801053c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
801053cb:	eb 1c                	jmp    801053e9 <fetchstr+0x53>
    if(*s == 0)
801053cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053d0:	0f b6 00             	movzbl (%eax),%eax
801053d3:	84 c0                	test   %al,%al
801053d5:	75 0e                	jne    801053e5 <fetchstr+0x4f>
      return s - *pp;
801053d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
801053da:	8b 45 0c             	mov    0xc(%ebp),%eax
801053dd:	8b 00                	mov    (%eax),%eax
801053df:	29 c2                	sub    %eax,%edx
801053e1:	89 d0                	mov    %edx,%eax
801053e3:	eb 11                	jmp    801053f6 <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801053e5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801053e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801053ef:	72 dc                	jb     801053cd <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
801053f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053f6:	c9                   	leave  
801053f7:	c3                   	ret    

801053f8 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801053f8:	55                   	push   %ebp
801053f9:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801053fb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105401:	8b 40 18             	mov    0x18(%eax),%eax
80105404:	8b 40 44             	mov    0x44(%eax),%eax
80105407:	8b 55 08             	mov    0x8(%ebp),%edx
8010540a:	c1 e2 02             	shl    $0x2,%edx
8010540d:	01 d0                	add    %edx,%eax
8010540f:	83 c0 04             	add    $0x4,%eax
80105412:	ff 75 0c             	pushl  0xc(%ebp)
80105415:	50                   	push   %eax
80105416:	e8 41 ff ff ff       	call   8010535c <fetchint>
8010541b:	83 c4 08             	add    $0x8,%esp
}
8010541e:	c9                   	leave  
8010541f:	c3                   	ret    

80105420 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	83 ec 10             	sub    $0x10,%esp
  int i;
  
  if(argint(n, &i) < 0)
80105426:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105429:	50                   	push   %eax
8010542a:	ff 75 08             	pushl  0x8(%ebp)
8010542d:	e8 c6 ff ff ff       	call   801053f8 <argint>
80105432:	83 c4 08             	add    $0x8,%esp
80105435:	85 c0                	test   %eax,%eax
80105437:	79 07                	jns    80105440 <argptr+0x20>
    return -1;
80105439:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010543e:	eb 3b                	jmp    8010547b <argptr+0x5b>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80105440:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105446:	8b 00                	mov    (%eax),%eax
80105448:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010544b:	39 d0                	cmp    %edx,%eax
8010544d:	76 16                	jbe    80105465 <argptr+0x45>
8010544f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105452:	89 c2                	mov    %eax,%edx
80105454:	8b 45 10             	mov    0x10(%ebp),%eax
80105457:	01 c2                	add    %eax,%edx
80105459:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010545f:	8b 00                	mov    (%eax),%eax
80105461:	39 c2                	cmp    %eax,%edx
80105463:	76 07                	jbe    8010546c <argptr+0x4c>
    return -1;
80105465:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010546a:	eb 0f                	jmp    8010547b <argptr+0x5b>
  *pp = (char*)i;
8010546c:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010546f:	89 c2                	mov    %eax,%edx
80105471:	8b 45 0c             	mov    0xc(%ebp),%eax
80105474:	89 10                	mov    %edx,(%eax)
  return 0;
80105476:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010547b:	c9                   	leave  
8010547c:	c3                   	ret    

8010547d <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
8010547d:	55                   	push   %ebp
8010547e:	89 e5                	mov    %esp,%ebp
80105480:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105483:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105486:	50                   	push   %eax
80105487:	ff 75 08             	pushl  0x8(%ebp)
8010548a:	e8 69 ff ff ff       	call   801053f8 <argint>
8010548f:	83 c4 08             	add    $0x8,%esp
80105492:	85 c0                	test   %eax,%eax
80105494:	79 07                	jns    8010549d <argstr+0x20>
    return -1;
80105496:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010549b:	eb 0f                	jmp    801054ac <argstr+0x2f>
  return fetchstr(addr, pp);
8010549d:	8b 45 fc             	mov    -0x4(%ebp),%eax
801054a0:	ff 75 0c             	pushl  0xc(%ebp)
801054a3:	50                   	push   %eax
801054a4:	e8 ed fe ff ff       	call   80105396 <fetchstr>
801054a9:	83 c4 08             	add    $0x8,%esp
}
801054ac:	c9                   	leave  
801054ad:	c3                   	ret    

801054ae <syscall>:
    
};

void
syscall(void)
{
801054ae:	55                   	push   %ebp
801054af:	89 e5                	mov    %esp,%ebp
801054b1:	53                   	push   %ebx
801054b2:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
801054b5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054bb:	8b 40 18             	mov    0x18(%eax),%eax
801054be:	8b 40 1c             	mov    0x1c(%eax),%eax
801054c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801054c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801054c8:	7e 30                	jle    801054fa <syscall+0x4c>
801054ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054cd:	83 f8 1b             	cmp    $0x1b,%eax
801054d0:	77 28                	ja     801054fa <syscall+0x4c>
801054d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054d5:	8b 04 85 40 e0 10 80 	mov    -0x7fef1fc0(,%eax,4),%eax
801054dc:	85 c0                	test   %eax,%eax
801054de:	74 1a                	je     801054fa <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
801054e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054e6:	8b 58 18             	mov    0x18(%eax),%ebx
801054e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054ec:	8b 04 85 40 e0 10 80 	mov    -0x7fef1fc0(,%eax,4),%eax
801054f3:	ff d0                	call   *%eax
801054f5:	89 43 1c             	mov    %eax,0x1c(%ebx)
801054f8:	eb 34                	jmp    8010552e <syscall+0x80>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
801054fa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105500:	8d 50 6c             	lea    0x6c(%eax),%edx
80105503:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105509:	8b 40 10             	mov    0x10(%eax),%eax
8010550c:	ff 75 f4             	pushl  -0xc(%ebp)
8010550f:	52                   	push   %edx
80105510:	50                   	push   %eax
80105511:	68 af b8 10 80       	push   $0x8010b8af
80105516:	e8 ab ae ff ff       	call   801003c6 <cprintf>
8010551b:	83 c4 10             	add    $0x10,%esp
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
8010551e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105524:	8b 40 18             	mov    0x18(%eax),%eax
80105527:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
8010552e:	90                   	nop
8010552f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105532:	c9                   	leave  
80105533:	c3                   	ret    

80105534 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80105534:	55                   	push   %ebp
80105535:	89 e5                	mov    %esp,%ebp
80105537:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010553a:	83 ec 08             	sub    $0x8,%esp
8010553d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105540:	50                   	push   %eax
80105541:	ff 75 08             	pushl  0x8(%ebp)
80105544:	e8 af fe ff ff       	call   801053f8 <argint>
80105549:	83 c4 10             	add    $0x10,%esp
8010554c:	85 c0                	test   %eax,%eax
8010554e:	79 07                	jns    80105557 <argfd+0x23>
    return -1;
80105550:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105555:	eb 50                	jmp    801055a7 <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80105557:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010555a:	85 c0                	test   %eax,%eax
8010555c:	78 21                	js     8010557f <argfd+0x4b>
8010555e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105561:	83 f8 0f             	cmp    $0xf,%eax
80105564:	7f 19                	jg     8010557f <argfd+0x4b>
80105566:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010556c:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010556f:	83 c2 08             	add    $0x8,%edx
80105572:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105576:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105579:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010557d:	75 07                	jne    80105586 <argfd+0x52>
    return -1;
8010557f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105584:	eb 21                	jmp    801055a7 <argfd+0x73>
  if(pfd)
80105586:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010558a:	74 08                	je     80105594 <argfd+0x60>
    *pfd = fd;
8010558c:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010558f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105592:	89 10                	mov    %edx,(%eax)
  if(pf)
80105594:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105598:	74 08                	je     801055a2 <argfd+0x6e>
    *pf = f;
8010559a:	8b 45 10             	mov    0x10(%ebp),%eax
8010559d:	8b 55 f4             	mov    -0xc(%ebp),%edx
801055a0:	89 10                	mov    %edx,(%eax)
  return 0;
801055a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801055a7:	c9                   	leave  
801055a8:	c3                   	ret    

801055a9 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
801055a9:	55                   	push   %ebp
801055aa:	89 e5                	mov    %esp,%ebp
801055ac:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801055af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801055b6:	eb 30                	jmp    801055e8 <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
801055b8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055be:	8b 55 fc             	mov    -0x4(%ebp),%edx
801055c1:	83 c2 08             	add    $0x8,%edx
801055c4:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801055c8:	85 c0                	test   %eax,%eax
801055ca:	75 18                	jne    801055e4 <fdalloc+0x3b>
      proc->ofile[fd] = f;
801055cc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055d2:	8b 55 fc             	mov    -0x4(%ebp),%edx
801055d5:	8d 4a 08             	lea    0x8(%edx),%ecx
801055d8:	8b 55 08             	mov    0x8(%ebp),%edx
801055db:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
801055df:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055e2:	eb 0f                	jmp    801055f3 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801055e4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801055e8:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
801055ec:	7e ca                	jle    801055b8 <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
801055ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055f3:	c9                   	leave  
801055f4:	c3                   	ret    

801055f5 <sys_dup>:

int
sys_dup(void)
{
801055f5:	55                   	push   %ebp
801055f6:	89 e5                	mov    %esp,%ebp
801055f8:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
801055fb:	83 ec 04             	sub    $0x4,%esp
801055fe:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105601:	50                   	push   %eax
80105602:	6a 00                	push   $0x0
80105604:	6a 00                	push   $0x0
80105606:	e8 29 ff ff ff       	call   80105534 <argfd>
8010560b:	83 c4 10             	add    $0x10,%esp
8010560e:	85 c0                	test   %eax,%eax
80105610:	79 07                	jns    80105619 <sys_dup+0x24>
    return -1;
80105612:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105617:	eb 31                	jmp    8010564a <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
80105619:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010561c:	83 ec 0c             	sub    $0xc,%esp
8010561f:	50                   	push   %eax
80105620:	e8 84 ff ff ff       	call   801055a9 <fdalloc>
80105625:	83 c4 10             	add    $0x10,%esp
80105628:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010562b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010562f:	79 07                	jns    80105638 <sys_dup+0x43>
    return -1;
80105631:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105636:	eb 12                	jmp    8010564a <sys_dup+0x55>
  filedup(f);
80105638:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010563b:	83 ec 0c             	sub    $0xc,%esp
8010563e:	50                   	push   %eax
8010563f:	e8 8d b9 ff ff       	call   80100fd1 <filedup>
80105644:	83 c4 10             	add    $0x10,%esp
  return fd;
80105647:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010564a:	c9                   	leave  
8010564b:	c3                   	ret    

8010564c <sys_read>:

int
sys_read(void)
{
8010564c:	55                   	push   %ebp
8010564d:	89 e5                	mov    %esp,%ebp
8010564f:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105652:	83 ec 04             	sub    $0x4,%esp
80105655:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105658:	50                   	push   %eax
80105659:	6a 00                	push   $0x0
8010565b:	6a 00                	push   $0x0
8010565d:	e8 d2 fe ff ff       	call   80105534 <argfd>
80105662:	83 c4 10             	add    $0x10,%esp
80105665:	85 c0                	test   %eax,%eax
80105667:	78 2e                	js     80105697 <sys_read+0x4b>
80105669:	83 ec 08             	sub    $0x8,%esp
8010566c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010566f:	50                   	push   %eax
80105670:	6a 02                	push   $0x2
80105672:	e8 81 fd ff ff       	call   801053f8 <argint>
80105677:	83 c4 10             	add    $0x10,%esp
8010567a:	85 c0                	test   %eax,%eax
8010567c:	78 19                	js     80105697 <sys_read+0x4b>
8010567e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105681:	83 ec 04             	sub    $0x4,%esp
80105684:	50                   	push   %eax
80105685:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105688:	50                   	push   %eax
80105689:	6a 01                	push   $0x1
8010568b:	e8 90 fd ff ff       	call   80105420 <argptr>
80105690:	83 c4 10             	add    $0x10,%esp
80105693:	85 c0                	test   %eax,%eax
80105695:	79 07                	jns    8010569e <sys_read+0x52>
    return -1;
80105697:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010569c:	eb 17                	jmp    801056b5 <sys_read+0x69>
  return fileread(f, p, n);
8010569e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801056a1:	8b 55 ec             	mov    -0x14(%ebp),%edx
801056a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056a7:	83 ec 04             	sub    $0x4,%esp
801056aa:	51                   	push   %ecx
801056ab:	52                   	push   %edx
801056ac:	50                   	push   %eax
801056ad:	e8 af ba ff ff       	call   80101161 <fileread>
801056b2:	83 c4 10             	add    $0x10,%esp
}
801056b5:	c9                   	leave  
801056b6:	c3                   	ret    

801056b7 <sys_write>:

int
sys_write(void)
{
801056b7:	55                   	push   %ebp
801056b8:	89 e5                	mov    %esp,%ebp
801056ba:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801056bd:	83 ec 04             	sub    $0x4,%esp
801056c0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056c3:	50                   	push   %eax
801056c4:	6a 00                	push   $0x0
801056c6:	6a 00                	push   $0x0
801056c8:	e8 67 fe ff ff       	call   80105534 <argfd>
801056cd:	83 c4 10             	add    $0x10,%esp
801056d0:	85 c0                	test   %eax,%eax
801056d2:	78 2e                	js     80105702 <sys_write+0x4b>
801056d4:	83 ec 08             	sub    $0x8,%esp
801056d7:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056da:	50                   	push   %eax
801056db:	6a 02                	push   $0x2
801056dd:	e8 16 fd ff ff       	call   801053f8 <argint>
801056e2:	83 c4 10             	add    $0x10,%esp
801056e5:	85 c0                	test   %eax,%eax
801056e7:	78 19                	js     80105702 <sys_write+0x4b>
801056e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801056ec:	83 ec 04             	sub    $0x4,%esp
801056ef:	50                   	push   %eax
801056f0:	8d 45 ec             	lea    -0x14(%ebp),%eax
801056f3:	50                   	push   %eax
801056f4:	6a 01                	push   $0x1
801056f6:	e8 25 fd ff ff       	call   80105420 <argptr>
801056fb:	83 c4 10             	add    $0x10,%esp
801056fe:	85 c0                	test   %eax,%eax
80105700:	79 07                	jns    80105709 <sys_write+0x52>
    return -1;
80105702:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105707:	eb 17                	jmp    80105720 <sys_write+0x69>
  return filewrite(f, p, n);
80105709:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010570c:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010570f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105712:	83 ec 04             	sub    $0x4,%esp
80105715:	51                   	push   %ecx
80105716:	52                   	push   %edx
80105717:	50                   	push   %eax
80105718:	e8 fc ba ff ff       	call   80101219 <filewrite>
8010571d:	83 c4 10             	add    $0x10,%esp
}
80105720:	c9                   	leave  
80105721:	c3                   	ret    

80105722 <sys_close>:

int
sys_close(void)
{
80105722:	55                   	push   %ebp
80105723:	89 e5                	mov    %esp,%ebp
80105725:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
80105728:	83 ec 04             	sub    $0x4,%esp
8010572b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010572e:	50                   	push   %eax
8010572f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105732:	50                   	push   %eax
80105733:	6a 00                	push   $0x0
80105735:	e8 fa fd ff ff       	call   80105534 <argfd>
8010573a:	83 c4 10             	add    $0x10,%esp
8010573d:	85 c0                	test   %eax,%eax
8010573f:	79 07                	jns    80105748 <sys_close+0x26>
    return -1;
80105741:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105746:	eb 28                	jmp    80105770 <sys_close+0x4e>
  proc->ofile[fd] = 0;
80105748:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010574e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105751:	83 c2 08             	add    $0x8,%edx
80105754:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010575b:	00 
  fileclose(f);
8010575c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010575f:	83 ec 0c             	sub    $0xc,%esp
80105762:	50                   	push   %eax
80105763:	e8 ba b8 ff ff       	call   80101022 <fileclose>
80105768:	83 c4 10             	add    $0x10,%esp
  return 0;
8010576b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105770:	c9                   	leave  
80105771:	c3                   	ret    

80105772 <sys_fstat>:

int
sys_fstat(void)
{
80105772:	55                   	push   %ebp
80105773:	89 e5                	mov    %esp,%ebp
80105775:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105778:	83 ec 04             	sub    $0x4,%esp
8010577b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010577e:	50                   	push   %eax
8010577f:	6a 00                	push   $0x0
80105781:	6a 00                	push   $0x0
80105783:	e8 ac fd ff ff       	call   80105534 <argfd>
80105788:	83 c4 10             	add    $0x10,%esp
8010578b:	85 c0                	test   %eax,%eax
8010578d:	78 17                	js     801057a6 <sys_fstat+0x34>
8010578f:	83 ec 04             	sub    $0x4,%esp
80105792:	6a 14                	push   $0x14
80105794:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105797:	50                   	push   %eax
80105798:	6a 01                	push   $0x1
8010579a:	e8 81 fc ff ff       	call   80105420 <argptr>
8010579f:	83 c4 10             	add    $0x10,%esp
801057a2:	85 c0                	test   %eax,%eax
801057a4:	79 07                	jns    801057ad <sys_fstat+0x3b>
    return -1;
801057a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057ab:	eb 13                	jmp    801057c0 <sys_fstat+0x4e>
  return filestat(f, st);
801057ad:	8b 55 f0             	mov    -0x10(%ebp),%edx
801057b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057b3:	83 ec 08             	sub    $0x8,%esp
801057b6:	52                   	push   %edx
801057b7:	50                   	push   %eax
801057b8:	e8 4d b9 ff ff       	call   8010110a <filestat>
801057bd:	83 c4 10             	add    $0x10,%esp
}
801057c0:	c9                   	leave  
801057c1:	c3                   	ret    

801057c2 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
801057c2:	55                   	push   %ebp
801057c3:	89 e5                	mov    %esp,%ebp
801057c5:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801057c8:	83 ec 08             	sub    $0x8,%esp
801057cb:	8d 45 d8             	lea    -0x28(%ebp),%eax
801057ce:	50                   	push   %eax
801057cf:	6a 00                	push   $0x0
801057d1:	e8 a7 fc ff ff       	call   8010547d <argstr>
801057d6:	83 c4 10             	add    $0x10,%esp
801057d9:	85 c0                	test   %eax,%eax
801057db:	78 15                	js     801057f2 <sys_link+0x30>
801057dd:	83 ec 08             	sub    $0x8,%esp
801057e0:	8d 45 dc             	lea    -0x24(%ebp),%eax
801057e3:	50                   	push   %eax
801057e4:	6a 01                	push   $0x1
801057e6:	e8 92 fc ff ff       	call   8010547d <argstr>
801057eb:	83 c4 10             	add    $0x10,%esp
801057ee:	85 c0                	test   %eax,%eax
801057f0:	79 0a                	jns    801057fc <sys_link+0x3a>
    return -1;
801057f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057f7:	e9 63 01 00 00       	jmp    8010595f <sys_link+0x19d>
  if((ip = namei(old)) == 0)
801057fc:	8b 45 d8             	mov    -0x28(%ebp),%eax
801057ff:	83 ec 0c             	sub    $0xc,%esp
80105802:	50                   	push   %eax
80105803:	e8 f6 cd ff ff       	call   801025fe <namei>
80105808:	83 c4 10             	add    $0x10,%esp
8010580b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010580e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105812:	75 0a                	jne    8010581e <sys_link+0x5c>
    return -1;
80105814:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105819:	e9 41 01 00 00       	jmp    8010595f <sys_link+0x19d>

  begin_trans();
8010581e:	e8 f3 dc ff ff       	call   80103516 <begin_trans>

  ilock(ip);
80105823:	83 ec 0c             	sub    $0xc,%esp
80105826:	ff 75 f4             	pushl  -0xc(%ebp)
80105829:	e8 c9 c0 ff ff       	call   801018f7 <ilock>
8010582e:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
80105831:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105834:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105838:	66 83 f8 01          	cmp    $0x1,%ax
8010583c:	75 1d                	jne    8010585b <sys_link+0x99>
    iunlockput(ip);
8010583e:	83 ec 0c             	sub    $0xc,%esp
80105841:	ff 75 f4             	pushl  -0xc(%ebp)
80105844:	e8 68 c3 ff ff       	call   80101bb1 <iunlockput>
80105849:	83 c4 10             	add    $0x10,%esp
    commit_trans();
8010584c:	e8 18 dd ff ff       	call   80103569 <commit_trans>
    return -1;
80105851:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105856:	e9 04 01 00 00       	jmp    8010595f <sys_link+0x19d>
  }

  ip->nlink++;
8010585b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010585e:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105862:	83 c0 01             	add    $0x1,%eax
80105865:	89 c2                	mov    %eax,%edx
80105867:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010586a:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
8010586e:	83 ec 0c             	sub    $0xc,%esp
80105871:	ff 75 f4             	pushl  -0xc(%ebp)
80105874:	e8 aa be ff ff       	call   80101723 <iupdate>
80105879:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
8010587c:	83 ec 0c             	sub    $0xc,%esp
8010587f:	ff 75 f4             	pushl  -0xc(%ebp)
80105882:	e8 c8 c1 ff ff       	call   80101a4f <iunlock>
80105887:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
8010588a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010588d:	83 ec 08             	sub    $0x8,%esp
80105890:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105893:	52                   	push   %edx
80105894:	50                   	push   %eax
80105895:	e8 80 cd ff ff       	call   8010261a <nameiparent>
8010589a:	83 c4 10             	add    $0x10,%esp
8010589d:	89 45 f0             	mov    %eax,-0x10(%ebp)
801058a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801058a4:	74 71                	je     80105917 <sys_link+0x155>
    goto bad;
  ilock(dp);
801058a6:	83 ec 0c             	sub    $0xc,%esp
801058a9:	ff 75 f0             	pushl  -0x10(%ebp)
801058ac:	e8 46 c0 ff ff       	call   801018f7 <ilock>
801058b1:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801058b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058b7:	8b 10                	mov    (%eax),%edx
801058b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058bc:	8b 00                	mov    (%eax),%eax
801058be:	39 c2                	cmp    %eax,%edx
801058c0:	75 1d                	jne    801058df <sys_link+0x11d>
801058c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058c5:	8b 40 04             	mov    0x4(%eax),%eax
801058c8:	83 ec 04             	sub    $0x4,%esp
801058cb:	50                   	push   %eax
801058cc:	8d 45 e2             	lea    -0x1e(%ebp),%eax
801058cf:	50                   	push   %eax
801058d0:	ff 75 f0             	pushl  -0x10(%ebp)
801058d3:	e8 8a ca ff ff       	call   80102362 <dirlink>
801058d8:	83 c4 10             	add    $0x10,%esp
801058db:	85 c0                	test   %eax,%eax
801058dd:	79 10                	jns    801058ef <sys_link+0x12d>
    iunlockput(dp);
801058df:	83 ec 0c             	sub    $0xc,%esp
801058e2:	ff 75 f0             	pushl  -0x10(%ebp)
801058e5:	e8 c7 c2 ff ff       	call   80101bb1 <iunlockput>
801058ea:	83 c4 10             	add    $0x10,%esp
    goto bad;
801058ed:	eb 29                	jmp    80105918 <sys_link+0x156>
  }
  iunlockput(dp);
801058ef:	83 ec 0c             	sub    $0xc,%esp
801058f2:	ff 75 f0             	pushl  -0x10(%ebp)
801058f5:	e8 b7 c2 ff ff       	call   80101bb1 <iunlockput>
801058fa:	83 c4 10             	add    $0x10,%esp
  iput(ip);
801058fd:	83 ec 0c             	sub    $0xc,%esp
80105900:	ff 75 f4             	pushl  -0xc(%ebp)
80105903:	e8 b9 c1 ff ff       	call   80101ac1 <iput>
80105908:	83 c4 10             	add    $0x10,%esp

  commit_trans();
8010590b:	e8 59 dc ff ff       	call   80103569 <commit_trans>

  return 0;
80105910:	b8 00 00 00 00       	mov    $0x0,%eax
80105915:	eb 48                	jmp    8010595f <sys_link+0x19d>
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
80105917:	90                   	nop
  commit_trans();

  return 0;

bad:
  ilock(ip);
80105918:	83 ec 0c             	sub    $0xc,%esp
8010591b:	ff 75 f4             	pushl  -0xc(%ebp)
8010591e:	e8 d4 bf ff ff       	call   801018f7 <ilock>
80105923:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
80105926:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105929:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010592d:	83 e8 01             	sub    $0x1,%eax
80105930:	89 c2                	mov    %eax,%edx
80105932:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105935:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105939:	83 ec 0c             	sub    $0xc,%esp
8010593c:	ff 75 f4             	pushl  -0xc(%ebp)
8010593f:	e8 df bd ff ff       	call   80101723 <iupdate>
80105944:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105947:	83 ec 0c             	sub    $0xc,%esp
8010594a:	ff 75 f4             	pushl  -0xc(%ebp)
8010594d:	e8 5f c2 ff ff       	call   80101bb1 <iunlockput>
80105952:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105955:	e8 0f dc ff ff       	call   80103569 <commit_trans>
  return -1;
8010595a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010595f:	c9                   	leave  
80105960:	c3                   	ret    

80105961 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105961:	55                   	push   %ebp
80105962:	89 e5                	mov    %esp,%ebp
80105964:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105967:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
8010596e:	eb 40                	jmp    801059b0 <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105970:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105973:	6a 10                	push   $0x10
80105975:	50                   	push   %eax
80105976:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105979:	50                   	push   %eax
8010597a:	ff 75 08             	pushl  0x8(%ebp)
8010597d:	e8 2c c6 ff ff       	call   80101fae <readi>
80105982:	83 c4 10             	add    $0x10,%esp
80105985:	83 f8 10             	cmp    $0x10,%eax
80105988:	74 0d                	je     80105997 <isdirempty+0x36>
      panic("isdirempty: readi");
8010598a:	83 ec 0c             	sub    $0xc,%esp
8010598d:	68 cb b8 10 80       	push   $0x8010b8cb
80105992:	e8 cf ab ff ff       	call   80100566 <panic>
    if(de.inum != 0)
80105997:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
8010599b:	66 85 c0             	test   %ax,%ax
8010599e:	74 07                	je     801059a7 <isdirempty+0x46>
      return 0;
801059a0:	b8 00 00 00 00       	mov    $0x0,%eax
801059a5:	eb 1b                	jmp    801059c2 <isdirempty+0x61>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801059a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059aa:	83 c0 10             	add    $0x10,%eax
801059ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
801059b0:	8b 45 08             	mov    0x8(%ebp),%eax
801059b3:	8b 50 18             	mov    0x18(%eax),%edx
801059b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059b9:	39 c2                	cmp    %eax,%edx
801059bb:	77 b3                	ja     80105970 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
801059bd:	b8 01 00 00 00       	mov    $0x1,%eax
}
801059c2:	c9                   	leave  
801059c3:	c3                   	ret    

801059c4 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
801059c4:	55                   	push   %ebp
801059c5:	89 e5                	mov    %esp,%ebp
801059c7:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801059ca:	83 ec 08             	sub    $0x8,%esp
801059cd:	8d 45 cc             	lea    -0x34(%ebp),%eax
801059d0:	50                   	push   %eax
801059d1:	6a 00                	push   $0x0
801059d3:	e8 a5 fa ff ff       	call   8010547d <argstr>
801059d8:	83 c4 10             	add    $0x10,%esp
801059db:	85 c0                	test   %eax,%eax
801059dd:	79 0a                	jns    801059e9 <sys_unlink+0x25>
    return -1;
801059df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059e4:	e9 b7 01 00 00       	jmp    80105ba0 <sys_unlink+0x1dc>
  if((dp = nameiparent(path, name)) == 0)
801059e9:	8b 45 cc             	mov    -0x34(%ebp),%eax
801059ec:	83 ec 08             	sub    $0x8,%esp
801059ef:	8d 55 d2             	lea    -0x2e(%ebp),%edx
801059f2:	52                   	push   %edx
801059f3:	50                   	push   %eax
801059f4:	e8 21 cc ff ff       	call   8010261a <nameiparent>
801059f9:	83 c4 10             	add    $0x10,%esp
801059fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
801059ff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105a03:	75 0a                	jne    80105a0f <sys_unlink+0x4b>
    return -1;
80105a05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a0a:	e9 91 01 00 00       	jmp    80105ba0 <sys_unlink+0x1dc>

  begin_trans();
80105a0f:	e8 02 db ff ff       	call   80103516 <begin_trans>

  ilock(dp);
80105a14:	83 ec 0c             	sub    $0xc,%esp
80105a17:	ff 75 f4             	pushl  -0xc(%ebp)
80105a1a:	e8 d8 be ff ff       	call   801018f7 <ilock>
80105a1f:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105a22:	83 ec 08             	sub    $0x8,%esp
80105a25:	68 dd b8 10 80       	push   $0x8010b8dd
80105a2a:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105a2d:	50                   	push   %eax
80105a2e:	e8 5a c8 ff ff       	call   8010228d <namecmp>
80105a33:	83 c4 10             	add    $0x10,%esp
80105a36:	85 c0                	test   %eax,%eax
80105a38:	0f 84 4a 01 00 00    	je     80105b88 <sys_unlink+0x1c4>
80105a3e:	83 ec 08             	sub    $0x8,%esp
80105a41:	68 df b8 10 80       	push   $0x8010b8df
80105a46:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105a49:	50                   	push   %eax
80105a4a:	e8 3e c8 ff ff       	call   8010228d <namecmp>
80105a4f:	83 c4 10             	add    $0x10,%esp
80105a52:	85 c0                	test   %eax,%eax
80105a54:	0f 84 2e 01 00 00    	je     80105b88 <sys_unlink+0x1c4>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105a5a:	83 ec 04             	sub    $0x4,%esp
80105a5d:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105a60:	50                   	push   %eax
80105a61:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105a64:	50                   	push   %eax
80105a65:	ff 75 f4             	pushl  -0xc(%ebp)
80105a68:	e8 3b c8 ff ff       	call   801022a8 <dirlookup>
80105a6d:	83 c4 10             	add    $0x10,%esp
80105a70:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105a73:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105a77:	0f 84 0a 01 00 00    	je     80105b87 <sys_unlink+0x1c3>
    goto bad;
  ilock(ip);
80105a7d:	83 ec 0c             	sub    $0xc,%esp
80105a80:	ff 75 f0             	pushl  -0x10(%ebp)
80105a83:	e8 6f be ff ff       	call   801018f7 <ilock>
80105a88:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105a8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a8e:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105a92:	66 85 c0             	test   %ax,%ax
80105a95:	7f 0d                	jg     80105aa4 <sys_unlink+0xe0>
    panic("unlink: nlink < 1");
80105a97:	83 ec 0c             	sub    $0xc,%esp
80105a9a:	68 e2 b8 10 80       	push   $0x8010b8e2
80105a9f:	e8 c2 aa ff ff       	call   80100566 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105aa4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105aa7:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105aab:	66 83 f8 01          	cmp    $0x1,%ax
80105aaf:	75 25                	jne    80105ad6 <sys_unlink+0x112>
80105ab1:	83 ec 0c             	sub    $0xc,%esp
80105ab4:	ff 75 f0             	pushl  -0x10(%ebp)
80105ab7:	e8 a5 fe ff ff       	call   80105961 <isdirempty>
80105abc:	83 c4 10             	add    $0x10,%esp
80105abf:	85 c0                	test   %eax,%eax
80105ac1:	75 13                	jne    80105ad6 <sys_unlink+0x112>
    iunlockput(ip);
80105ac3:	83 ec 0c             	sub    $0xc,%esp
80105ac6:	ff 75 f0             	pushl  -0x10(%ebp)
80105ac9:	e8 e3 c0 ff ff       	call   80101bb1 <iunlockput>
80105ace:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105ad1:	e9 b2 00 00 00       	jmp    80105b88 <sys_unlink+0x1c4>
  }

  memset(&de, 0, sizeof(de));
80105ad6:	83 ec 04             	sub    $0x4,%esp
80105ad9:	6a 10                	push   $0x10
80105adb:	6a 00                	push   $0x0
80105add:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105ae0:	50                   	push   %eax
80105ae1:	e8 ed f5 ff ff       	call   801050d3 <memset>
80105ae6:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105ae9:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105aec:	6a 10                	push   $0x10
80105aee:	50                   	push   %eax
80105aef:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105af2:	50                   	push   %eax
80105af3:	ff 75 f4             	pushl  -0xc(%ebp)
80105af6:	e8 0a c6 ff ff       	call   80102105 <writei>
80105afb:	83 c4 10             	add    $0x10,%esp
80105afe:	83 f8 10             	cmp    $0x10,%eax
80105b01:	74 0d                	je     80105b10 <sys_unlink+0x14c>
    panic("unlink: writei");
80105b03:	83 ec 0c             	sub    $0xc,%esp
80105b06:	68 f4 b8 10 80       	push   $0x8010b8f4
80105b0b:	e8 56 aa ff ff       	call   80100566 <panic>
  if(ip->type == T_DIR){
80105b10:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b13:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105b17:	66 83 f8 01          	cmp    $0x1,%ax
80105b1b:	75 21                	jne    80105b3e <sys_unlink+0x17a>
    dp->nlink--;
80105b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b20:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105b24:	83 e8 01             	sub    $0x1,%eax
80105b27:	89 c2                	mov    %eax,%edx
80105b29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b2c:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105b30:	83 ec 0c             	sub    $0xc,%esp
80105b33:	ff 75 f4             	pushl  -0xc(%ebp)
80105b36:	e8 e8 bb ff ff       	call   80101723 <iupdate>
80105b3b:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80105b3e:	83 ec 0c             	sub    $0xc,%esp
80105b41:	ff 75 f4             	pushl  -0xc(%ebp)
80105b44:	e8 68 c0 ff ff       	call   80101bb1 <iunlockput>
80105b49:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80105b4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b4f:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105b53:	83 e8 01             	sub    $0x1,%eax
80105b56:	89 c2                	mov    %eax,%edx
80105b58:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b5b:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105b5f:	83 ec 0c             	sub    $0xc,%esp
80105b62:	ff 75 f0             	pushl  -0x10(%ebp)
80105b65:	e8 b9 bb ff ff       	call   80101723 <iupdate>
80105b6a:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105b6d:	83 ec 0c             	sub    $0xc,%esp
80105b70:	ff 75 f0             	pushl  -0x10(%ebp)
80105b73:	e8 39 c0 ff ff       	call   80101bb1 <iunlockput>
80105b78:	83 c4 10             	add    $0x10,%esp

  commit_trans();
80105b7b:	e8 e9 d9 ff ff       	call   80103569 <commit_trans>

  return 0;
80105b80:	b8 00 00 00 00       	mov    $0x0,%eax
80105b85:	eb 19                	jmp    80105ba0 <sys_unlink+0x1dc>
  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
80105b87:	90                   	nop
  commit_trans();

  return 0;

bad:
  iunlockput(dp);
80105b88:	83 ec 0c             	sub    $0xc,%esp
80105b8b:	ff 75 f4             	pushl  -0xc(%ebp)
80105b8e:	e8 1e c0 ff ff       	call   80101bb1 <iunlockput>
80105b93:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105b96:	e8 ce d9 ff ff       	call   80103569 <commit_trans>
  return -1;
80105b9b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ba0:	c9                   	leave  
80105ba1:	c3                   	ret    

80105ba2 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105ba2:	55                   	push   %ebp
80105ba3:	89 e5                	mov    %esp,%ebp
80105ba5:	83 ec 38             	sub    $0x38,%esp
80105ba8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105bab:	8b 55 10             	mov    0x10(%ebp),%edx
80105bae:	8b 45 14             	mov    0x14(%ebp),%eax
80105bb1:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105bb5:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105bb9:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105bbd:	83 ec 08             	sub    $0x8,%esp
80105bc0:	8d 45 de             	lea    -0x22(%ebp),%eax
80105bc3:	50                   	push   %eax
80105bc4:	ff 75 08             	pushl  0x8(%ebp)
80105bc7:	e8 4e ca ff ff       	call   8010261a <nameiparent>
80105bcc:	83 c4 10             	add    $0x10,%esp
80105bcf:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105bd2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105bd6:	75 0a                	jne    80105be2 <create+0x40>
    return 0;
80105bd8:	b8 00 00 00 00       	mov    $0x0,%eax
80105bdd:	e9 90 01 00 00       	jmp    80105d72 <create+0x1d0>
  ilock(dp);
80105be2:	83 ec 0c             	sub    $0xc,%esp
80105be5:	ff 75 f4             	pushl  -0xc(%ebp)
80105be8:	e8 0a bd ff ff       	call   801018f7 <ilock>
80105bed:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
80105bf0:	83 ec 04             	sub    $0x4,%esp
80105bf3:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105bf6:	50                   	push   %eax
80105bf7:	8d 45 de             	lea    -0x22(%ebp),%eax
80105bfa:	50                   	push   %eax
80105bfb:	ff 75 f4             	pushl  -0xc(%ebp)
80105bfe:	e8 a5 c6 ff ff       	call   801022a8 <dirlookup>
80105c03:	83 c4 10             	add    $0x10,%esp
80105c06:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105c09:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105c0d:	74 50                	je     80105c5f <create+0xbd>
    iunlockput(dp);
80105c0f:	83 ec 0c             	sub    $0xc,%esp
80105c12:	ff 75 f4             	pushl  -0xc(%ebp)
80105c15:	e8 97 bf ff ff       	call   80101bb1 <iunlockput>
80105c1a:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80105c1d:	83 ec 0c             	sub    $0xc,%esp
80105c20:	ff 75 f0             	pushl  -0x10(%ebp)
80105c23:	e8 cf bc ff ff       	call   801018f7 <ilock>
80105c28:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80105c2b:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105c30:	75 15                	jne    80105c47 <create+0xa5>
80105c32:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c35:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105c39:	66 83 f8 02          	cmp    $0x2,%ax
80105c3d:	75 08                	jne    80105c47 <create+0xa5>
      return ip;
80105c3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c42:	e9 2b 01 00 00       	jmp    80105d72 <create+0x1d0>
    iunlockput(ip);
80105c47:	83 ec 0c             	sub    $0xc,%esp
80105c4a:	ff 75 f0             	pushl  -0x10(%ebp)
80105c4d:	e8 5f bf ff ff       	call   80101bb1 <iunlockput>
80105c52:	83 c4 10             	add    $0x10,%esp
    return 0;
80105c55:	b8 00 00 00 00       	mov    $0x0,%eax
80105c5a:	e9 13 01 00 00       	jmp    80105d72 <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105c5f:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105c63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c66:	8b 00                	mov    (%eax),%eax
80105c68:	83 ec 08             	sub    $0x8,%esp
80105c6b:	52                   	push   %edx
80105c6c:	50                   	push   %eax
80105c6d:	e8 d0 b9 ff ff       	call   80101642 <ialloc>
80105c72:	83 c4 10             	add    $0x10,%esp
80105c75:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105c78:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105c7c:	75 0d                	jne    80105c8b <create+0xe9>
    panic("create: ialloc");
80105c7e:	83 ec 0c             	sub    $0xc,%esp
80105c81:	68 03 b9 10 80       	push   $0x8010b903
80105c86:	e8 db a8 ff ff       	call   80100566 <panic>

  ilock(ip);
80105c8b:	83 ec 0c             	sub    $0xc,%esp
80105c8e:	ff 75 f0             	pushl  -0x10(%ebp)
80105c91:	e8 61 bc ff ff       	call   801018f7 <ilock>
80105c96:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80105c99:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c9c:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105ca0:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80105ca4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ca7:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105cab:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80105caf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cb2:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105cb8:	83 ec 0c             	sub    $0xc,%esp
80105cbb:	ff 75 f0             	pushl  -0x10(%ebp)
80105cbe:	e8 60 ba ff ff       	call   80101723 <iupdate>
80105cc3:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
80105cc6:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105ccb:	75 6a                	jne    80105d37 <create+0x195>
    dp->nlink++;  // for ".."
80105ccd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cd0:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105cd4:	83 c0 01             	add    $0x1,%eax
80105cd7:	89 c2                	mov    %eax,%edx
80105cd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cdc:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105ce0:	83 ec 0c             	sub    $0xc,%esp
80105ce3:	ff 75 f4             	pushl  -0xc(%ebp)
80105ce6:	e8 38 ba ff ff       	call   80101723 <iupdate>
80105ceb:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105cee:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cf1:	8b 40 04             	mov    0x4(%eax),%eax
80105cf4:	83 ec 04             	sub    $0x4,%esp
80105cf7:	50                   	push   %eax
80105cf8:	68 dd b8 10 80       	push   $0x8010b8dd
80105cfd:	ff 75 f0             	pushl  -0x10(%ebp)
80105d00:	e8 5d c6 ff ff       	call   80102362 <dirlink>
80105d05:	83 c4 10             	add    $0x10,%esp
80105d08:	85 c0                	test   %eax,%eax
80105d0a:	78 1e                	js     80105d2a <create+0x188>
80105d0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d0f:	8b 40 04             	mov    0x4(%eax),%eax
80105d12:	83 ec 04             	sub    $0x4,%esp
80105d15:	50                   	push   %eax
80105d16:	68 df b8 10 80       	push   $0x8010b8df
80105d1b:	ff 75 f0             	pushl  -0x10(%ebp)
80105d1e:	e8 3f c6 ff ff       	call   80102362 <dirlink>
80105d23:	83 c4 10             	add    $0x10,%esp
80105d26:	85 c0                	test   %eax,%eax
80105d28:	79 0d                	jns    80105d37 <create+0x195>
      panic("create dots");
80105d2a:	83 ec 0c             	sub    $0xc,%esp
80105d2d:	68 12 b9 10 80       	push   $0x8010b912
80105d32:	e8 2f a8 ff ff       	call   80100566 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105d37:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d3a:	8b 40 04             	mov    0x4(%eax),%eax
80105d3d:	83 ec 04             	sub    $0x4,%esp
80105d40:	50                   	push   %eax
80105d41:	8d 45 de             	lea    -0x22(%ebp),%eax
80105d44:	50                   	push   %eax
80105d45:	ff 75 f4             	pushl  -0xc(%ebp)
80105d48:	e8 15 c6 ff ff       	call   80102362 <dirlink>
80105d4d:	83 c4 10             	add    $0x10,%esp
80105d50:	85 c0                	test   %eax,%eax
80105d52:	79 0d                	jns    80105d61 <create+0x1bf>
    panic("create: dirlink");
80105d54:	83 ec 0c             	sub    $0xc,%esp
80105d57:	68 1e b9 10 80       	push   $0x8010b91e
80105d5c:	e8 05 a8 ff ff       	call   80100566 <panic>

  iunlockput(dp);
80105d61:	83 ec 0c             	sub    $0xc,%esp
80105d64:	ff 75 f4             	pushl  -0xc(%ebp)
80105d67:	e8 45 be ff ff       	call   80101bb1 <iunlockput>
80105d6c:	83 c4 10             	add    $0x10,%esp

  return ip;
80105d6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105d72:	c9                   	leave  
80105d73:	c3                   	ret    

80105d74 <sys_open>:

int
sys_open(void)
{
80105d74:	55                   	push   %ebp
80105d75:	89 e5                	mov    %esp,%ebp
80105d77:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105d7a:	83 ec 08             	sub    $0x8,%esp
80105d7d:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105d80:	50                   	push   %eax
80105d81:	6a 00                	push   $0x0
80105d83:	e8 f5 f6 ff ff       	call   8010547d <argstr>
80105d88:	83 c4 10             	add    $0x10,%esp
80105d8b:	85 c0                	test   %eax,%eax
80105d8d:	78 15                	js     80105da4 <sys_open+0x30>
80105d8f:	83 ec 08             	sub    $0x8,%esp
80105d92:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d95:	50                   	push   %eax
80105d96:	6a 01                	push   $0x1
80105d98:	e8 5b f6 ff ff       	call   801053f8 <argint>
80105d9d:	83 c4 10             	add    $0x10,%esp
80105da0:	85 c0                	test   %eax,%eax
80105da2:	79 0a                	jns    80105dae <sys_open+0x3a>
    return -1;
80105da4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105da9:	e9 4d 01 00 00       	jmp    80105efb <sys_open+0x187>
  if(omode & O_CREATE){
80105dae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105db1:	25 00 02 00 00       	and    $0x200,%eax
80105db6:	85 c0                	test   %eax,%eax
80105db8:	74 2f                	je     80105de9 <sys_open+0x75>
    begin_trans();
80105dba:	e8 57 d7 ff ff       	call   80103516 <begin_trans>
    ip = create(path, T_FILE, 0, 0);
80105dbf:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105dc2:	6a 00                	push   $0x0
80105dc4:	6a 00                	push   $0x0
80105dc6:	6a 02                	push   $0x2
80105dc8:	50                   	push   %eax
80105dc9:	e8 d4 fd ff ff       	call   80105ba2 <create>
80105dce:	83 c4 10             	add    $0x10,%esp
80105dd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    commit_trans();
80105dd4:	e8 90 d7 ff ff       	call   80103569 <commit_trans>
    if(ip == 0)
80105dd9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105ddd:	75 66                	jne    80105e45 <sys_open+0xd1>
      return -1;
80105ddf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105de4:	e9 12 01 00 00       	jmp    80105efb <sys_open+0x187>
  } else {
    if((ip = namei(path)) == 0)
80105de9:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105dec:	83 ec 0c             	sub    $0xc,%esp
80105def:	50                   	push   %eax
80105df0:	e8 09 c8 ff ff       	call   801025fe <namei>
80105df5:	83 c4 10             	add    $0x10,%esp
80105df8:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105dfb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105dff:	75 0a                	jne    80105e0b <sys_open+0x97>
      return -1;
80105e01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e06:	e9 f0 00 00 00       	jmp    80105efb <sys_open+0x187>
    ilock(ip);
80105e0b:	83 ec 0c             	sub    $0xc,%esp
80105e0e:	ff 75 f4             	pushl  -0xc(%ebp)
80105e11:	e8 e1 ba ff ff       	call   801018f7 <ilock>
80105e16:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e19:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e1c:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105e20:	66 83 f8 01          	cmp    $0x1,%ax
80105e24:	75 1f                	jne    80105e45 <sys_open+0xd1>
80105e26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105e29:	85 c0                	test   %eax,%eax
80105e2b:	74 18                	je     80105e45 <sys_open+0xd1>
      iunlockput(ip);
80105e2d:	83 ec 0c             	sub    $0xc,%esp
80105e30:	ff 75 f4             	pushl  -0xc(%ebp)
80105e33:	e8 79 bd ff ff       	call   80101bb1 <iunlockput>
80105e38:	83 c4 10             	add    $0x10,%esp
      return -1;
80105e3b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e40:	e9 b6 00 00 00       	jmp    80105efb <sys_open+0x187>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105e45:	e8 1a b1 ff ff       	call   80100f64 <filealloc>
80105e4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105e4d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e51:	74 17                	je     80105e6a <sys_open+0xf6>
80105e53:	83 ec 0c             	sub    $0xc,%esp
80105e56:	ff 75 f0             	pushl  -0x10(%ebp)
80105e59:	e8 4b f7 ff ff       	call   801055a9 <fdalloc>
80105e5e:	83 c4 10             	add    $0x10,%esp
80105e61:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105e64:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105e68:	79 29                	jns    80105e93 <sys_open+0x11f>
    if(f)
80105e6a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e6e:	74 0e                	je     80105e7e <sys_open+0x10a>
      fileclose(f);
80105e70:	83 ec 0c             	sub    $0xc,%esp
80105e73:	ff 75 f0             	pushl  -0x10(%ebp)
80105e76:	e8 a7 b1 ff ff       	call   80101022 <fileclose>
80105e7b:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105e7e:	83 ec 0c             	sub    $0xc,%esp
80105e81:	ff 75 f4             	pushl  -0xc(%ebp)
80105e84:	e8 28 bd ff ff       	call   80101bb1 <iunlockput>
80105e89:	83 c4 10             	add    $0x10,%esp
    return -1;
80105e8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e91:	eb 68                	jmp    80105efb <sys_open+0x187>
  }
  iunlock(ip);
80105e93:	83 ec 0c             	sub    $0xc,%esp
80105e96:	ff 75 f4             	pushl  -0xc(%ebp)
80105e99:	e8 b1 bb ff ff       	call   80101a4f <iunlock>
80105e9e:	83 c4 10             	add    $0x10,%esp

  f->type = FD_INODE;
80105ea1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ea4:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80105eaa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ead:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105eb0:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80105eb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105eb6:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80105ebd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ec0:	83 e0 01             	and    $0x1,%eax
80105ec3:	85 c0                	test   %eax,%eax
80105ec5:	0f 94 c0             	sete   %al
80105ec8:	89 c2                	mov    %eax,%edx
80105eca:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ecd:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105ed0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ed3:	83 e0 01             	and    $0x1,%eax
80105ed6:	85 c0                	test   %eax,%eax
80105ed8:	75 0a                	jne    80105ee4 <sys_open+0x170>
80105eda:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105edd:	83 e0 02             	and    $0x2,%eax
80105ee0:	85 c0                	test   %eax,%eax
80105ee2:	74 07                	je     80105eeb <sys_open+0x177>
80105ee4:	b8 01 00 00 00       	mov    $0x1,%eax
80105ee9:	eb 05                	jmp    80105ef0 <sys_open+0x17c>
80105eeb:	b8 00 00 00 00       	mov    $0x0,%eax
80105ef0:	89 c2                	mov    %eax,%edx
80105ef2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ef5:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80105ef8:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80105efb:	c9                   	leave  
80105efc:	c3                   	ret    

80105efd <sys_mkdir>:

int
sys_mkdir(void)
{
80105efd:	55                   	push   %ebp
80105efe:	89 e5                	mov    %esp,%ebp
80105f00:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_trans();
80105f03:	e8 0e d6 ff ff       	call   80103516 <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105f08:	83 ec 08             	sub    $0x8,%esp
80105f0b:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f0e:	50                   	push   %eax
80105f0f:	6a 00                	push   $0x0
80105f11:	e8 67 f5 ff ff       	call   8010547d <argstr>
80105f16:	83 c4 10             	add    $0x10,%esp
80105f19:	85 c0                	test   %eax,%eax
80105f1b:	78 1b                	js     80105f38 <sys_mkdir+0x3b>
80105f1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f20:	6a 00                	push   $0x0
80105f22:	6a 00                	push   $0x0
80105f24:	6a 01                	push   $0x1
80105f26:	50                   	push   %eax
80105f27:	e8 76 fc ff ff       	call   80105ba2 <create>
80105f2c:	83 c4 10             	add    $0x10,%esp
80105f2f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f32:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f36:	75 0c                	jne    80105f44 <sys_mkdir+0x47>
    commit_trans();
80105f38:	e8 2c d6 ff ff       	call   80103569 <commit_trans>
    return -1;
80105f3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f42:	eb 18                	jmp    80105f5c <sys_mkdir+0x5f>
  }
  iunlockput(ip);
80105f44:	83 ec 0c             	sub    $0xc,%esp
80105f47:	ff 75 f4             	pushl  -0xc(%ebp)
80105f4a:	e8 62 bc ff ff       	call   80101bb1 <iunlockput>
80105f4f:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105f52:	e8 12 d6 ff ff       	call   80103569 <commit_trans>
  return 0;
80105f57:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105f5c:	c9                   	leave  
80105f5d:	c3                   	ret    

80105f5e <sys_mknod>:

int
sys_mknod(void)
{
80105f5e:	55                   	push   %ebp
80105f5f:	89 e5                	mov    %esp,%ebp
80105f61:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
80105f64:	e8 ad d5 ff ff       	call   80103516 <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
80105f69:	83 ec 08             	sub    $0x8,%esp
80105f6c:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105f6f:	50                   	push   %eax
80105f70:	6a 00                	push   $0x0
80105f72:	e8 06 f5 ff ff       	call   8010547d <argstr>
80105f77:	83 c4 10             	add    $0x10,%esp
80105f7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f7d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f81:	78 4f                	js     80105fd2 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
80105f83:	83 ec 08             	sub    $0x8,%esp
80105f86:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105f89:	50                   	push   %eax
80105f8a:	6a 01                	push   $0x1
80105f8c:	e8 67 f4 ff ff       	call   801053f8 <argint>
80105f91:	83 c4 10             	add    $0x10,%esp
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
80105f94:	85 c0                	test   %eax,%eax
80105f96:	78 3a                	js     80105fd2 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105f98:	83 ec 08             	sub    $0x8,%esp
80105f9b:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f9e:	50                   	push   %eax
80105f9f:	6a 02                	push   $0x2
80105fa1:	e8 52 f4 ff ff       	call   801053f8 <argint>
80105fa6:	83 c4 10             	add    $0x10,%esp
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105fa9:	85 c0                	test   %eax,%eax
80105fab:	78 25                	js     80105fd2 <sys_mknod+0x74>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80105fad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105fb0:	0f bf c8             	movswl %ax,%ecx
80105fb3:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105fb6:	0f bf d0             	movswl %ax,%edx
80105fb9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105fbc:	51                   	push   %ecx
80105fbd:	52                   	push   %edx
80105fbe:	6a 03                	push   $0x3
80105fc0:	50                   	push   %eax
80105fc1:	e8 dc fb ff ff       	call   80105ba2 <create>
80105fc6:	83 c4 10             	add    $0x10,%esp
80105fc9:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105fcc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105fd0:	75 0c                	jne    80105fde <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    commit_trans();
80105fd2:	e8 92 d5 ff ff       	call   80103569 <commit_trans>
    return -1;
80105fd7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fdc:	eb 18                	jmp    80105ff6 <sys_mknod+0x98>
  }
  iunlockput(ip);
80105fde:	83 ec 0c             	sub    $0xc,%esp
80105fe1:	ff 75 f0             	pushl  -0x10(%ebp)
80105fe4:	e8 c8 bb ff ff       	call   80101bb1 <iunlockput>
80105fe9:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105fec:	e8 78 d5 ff ff       	call   80103569 <commit_trans>
  return 0;
80105ff1:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105ff6:	c9                   	leave  
80105ff7:	c3                   	ret    

80105ff8 <sys_chdir>:

int
sys_chdir(void)
{
80105ff8:	55                   	push   %ebp
80105ff9:	89 e5                	mov    %esp,%ebp
80105ffb:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80105ffe:	83 ec 08             	sub    $0x8,%esp
80106001:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106004:	50                   	push   %eax
80106005:	6a 00                	push   $0x0
80106007:	e8 71 f4 ff ff       	call   8010547d <argstr>
8010600c:	83 c4 10             	add    $0x10,%esp
8010600f:	85 c0                	test   %eax,%eax
80106011:	78 18                	js     8010602b <sys_chdir+0x33>
80106013:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106016:	83 ec 0c             	sub    $0xc,%esp
80106019:	50                   	push   %eax
8010601a:	e8 df c5 ff ff       	call   801025fe <namei>
8010601f:	83 c4 10             	add    $0x10,%esp
80106022:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106025:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106029:	75 07                	jne    80106032 <sys_chdir+0x3a>
    return -1;
8010602b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106030:	eb 64                	jmp    80106096 <sys_chdir+0x9e>
  ilock(ip);
80106032:	83 ec 0c             	sub    $0xc,%esp
80106035:	ff 75 f4             	pushl  -0xc(%ebp)
80106038:	e8 ba b8 ff ff       	call   801018f7 <ilock>
8010603d:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
80106040:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106043:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106047:	66 83 f8 01          	cmp    $0x1,%ax
8010604b:	74 15                	je     80106062 <sys_chdir+0x6a>
    iunlockput(ip);
8010604d:	83 ec 0c             	sub    $0xc,%esp
80106050:	ff 75 f4             	pushl  -0xc(%ebp)
80106053:	e8 59 bb ff ff       	call   80101bb1 <iunlockput>
80106058:	83 c4 10             	add    $0x10,%esp
    return -1;
8010605b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106060:	eb 34                	jmp    80106096 <sys_chdir+0x9e>
  }
  iunlock(ip);
80106062:	83 ec 0c             	sub    $0xc,%esp
80106065:	ff 75 f4             	pushl  -0xc(%ebp)
80106068:	e8 e2 b9 ff ff       	call   80101a4f <iunlock>
8010606d:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
80106070:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106076:	8b 40 68             	mov    0x68(%eax),%eax
80106079:	83 ec 0c             	sub    $0xc,%esp
8010607c:	50                   	push   %eax
8010607d:	e8 3f ba ff ff       	call   80101ac1 <iput>
80106082:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
80106085:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010608b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010608e:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80106091:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106096:	c9                   	leave  
80106097:	c3                   	ret    

80106098 <sys_exec>:

int
sys_exec(void)
{
80106098:	55                   	push   %ebp
80106099:	89 e5                	mov    %esp,%ebp
8010609b:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801060a1:	83 ec 08             	sub    $0x8,%esp
801060a4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060a7:	50                   	push   %eax
801060a8:	6a 00                	push   $0x0
801060aa:	e8 ce f3 ff ff       	call   8010547d <argstr>
801060af:	83 c4 10             	add    $0x10,%esp
801060b2:	85 c0                	test   %eax,%eax
801060b4:	78 18                	js     801060ce <sys_exec+0x36>
801060b6:	83 ec 08             	sub    $0x8,%esp
801060b9:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
801060bf:	50                   	push   %eax
801060c0:	6a 01                	push   $0x1
801060c2:	e8 31 f3 ff ff       	call   801053f8 <argint>
801060c7:	83 c4 10             	add    $0x10,%esp
801060ca:	85 c0                	test   %eax,%eax
801060cc:	79 0a                	jns    801060d8 <sys_exec+0x40>
    return -1;
801060ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060d3:	e9 c6 00 00 00       	jmp    8010619e <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
801060d8:	83 ec 04             	sub    $0x4,%esp
801060db:	68 80 00 00 00       	push   $0x80
801060e0:	6a 00                	push   $0x0
801060e2:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801060e8:	50                   	push   %eax
801060e9:	e8 e5 ef ff ff       	call   801050d3 <memset>
801060ee:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
801060f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
801060f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060fb:	83 f8 1f             	cmp    $0x1f,%eax
801060fe:	76 0a                	jbe    8010610a <sys_exec+0x72>
      return -1;
80106100:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106105:	e9 94 00 00 00       	jmp    8010619e <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010610a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010610d:	c1 e0 02             	shl    $0x2,%eax
80106110:	89 c2                	mov    %eax,%edx
80106112:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
80106118:	01 c2                	add    %eax,%edx
8010611a:	83 ec 08             	sub    $0x8,%esp
8010611d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106123:	50                   	push   %eax
80106124:	52                   	push   %edx
80106125:	e8 32 f2 ff ff       	call   8010535c <fetchint>
8010612a:	83 c4 10             	add    $0x10,%esp
8010612d:	85 c0                	test   %eax,%eax
8010612f:	79 07                	jns    80106138 <sys_exec+0xa0>
      return -1;
80106131:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106136:	eb 66                	jmp    8010619e <sys_exec+0x106>
    if(uarg == 0){
80106138:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010613e:	85 c0                	test   %eax,%eax
80106140:	75 27                	jne    80106169 <sys_exec+0xd1>
      argv[i] = 0;
80106142:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106145:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
8010614c:	00 00 00 00 
      break;
80106150:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106151:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106154:	83 ec 08             	sub    $0x8,%esp
80106157:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
8010615d:	52                   	push   %edx
8010615e:	50                   	push   %eax
8010615f:	e8 f2 a9 ff ff       	call   80100b56 <exec>
80106164:	83 c4 10             	add    $0x10,%esp
80106167:	eb 35                	jmp    8010619e <sys_exec+0x106>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106169:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010616f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106172:	c1 e2 02             	shl    $0x2,%edx
80106175:	01 c2                	add    %eax,%edx
80106177:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010617d:	83 ec 08             	sub    $0x8,%esp
80106180:	52                   	push   %edx
80106181:	50                   	push   %eax
80106182:	e8 0f f2 ff ff       	call   80105396 <fetchstr>
80106187:	83 c4 10             	add    $0x10,%esp
8010618a:	85 c0                	test   %eax,%eax
8010618c:	79 07                	jns    80106195 <sys_exec+0xfd>
      return -1;
8010618e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106193:	eb 09                	jmp    8010619e <sys_exec+0x106>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80106195:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
80106199:	e9 5a ff ff ff       	jmp    801060f8 <sys_exec+0x60>
  return exec(path, argv);
}
8010619e:	c9                   	leave  
8010619f:	c3                   	ret    

801061a0 <sys_pipe>:

int
sys_pipe(void)
{
801061a0:	55                   	push   %ebp
801061a1:	89 e5                	mov    %esp,%ebp
801061a3:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801061a6:	83 ec 04             	sub    $0x4,%esp
801061a9:	6a 08                	push   $0x8
801061ab:	8d 45 ec             	lea    -0x14(%ebp),%eax
801061ae:	50                   	push   %eax
801061af:	6a 00                	push   $0x0
801061b1:	e8 6a f2 ff ff       	call   80105420 <argptr>
801061b6:	83 c4 10             	add    $0x10,%esp
801061b9:	85 c0                	test   %eax,%eax
801061bb:	79 0a                	jns    801061c7 <sys_pipe+0x27>
    return -1;
801061bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061c2:	e9 af 00 00 00       	jmp    80106276 <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
801061c7:	83 ec 08             	sub    $0x8,%esp
801061ca:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801061cd:	50                   	push   %eax
801061ce:	8d 45 e8             	lea    -0x18(%ebp),%eax
801061d1:	50                   	push   %eax
801061d2:	e8 1a dd ff ff       	call   80103ef1 <pipealloc>
801061d7:	83 c4 10             	add    $0x10,%esp
801061da:	85 c0                	test   %eax,%eax
801061dc:	79 0a                	jns    801061e8 <sys_pipe+0x48>
    return -1;
801061de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061e3:	e9 8e 00 00 00       	jmp    80106276 <sys_pipe+0xd6>
  fd0 = -1;
801061e8:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801061ef:	8b 45 e8             	mov    -0x18(%ebp),%eax
801061f2:	83 ec 0c             	sub    $0xc,%esp
801061f5:	50                   	push   %eax
801061f6:	e8 ae f3 ff ff       	call   801055a9 <fdalloc>
801061fb:	83 c4 10             	add    $0x10,%esp
801061fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106201:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106205:	78 18                	js     8010621f <sys_pipe+0x7f>
80106207:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010620a:	83 ec 0c             	sub    $0xc,%esp
8010620d:	50                   	push   %eax
8010620e:	e8 96 f3 ff ff       	call   801055a9 <fdalloc>
80106213:	83 c4 10             	add    $0x10,%esp
80106216:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106219:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010621d:	79 3f                	jns    8010625e <sys_pipe+0xbe>
    if(fd0 >= 0)
8010621f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106223:	78 14                	js     80106239 <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
80106225:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010622b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010622e:	83 c2 08             	add    $0x8,%edx
80106231:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80106238:	00 
    fileclose(rf);
80106239:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010623c:	83 ec 0c             	sub    $0xc,%esp
8010623f:	50                   	push   %eax
80106240:	e8 dd ad ff ff       	call   80101022 <fileclose>
80106245:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
80106248:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010624b:	83 ec 0c             	sub    $0xc,%esp
8010624e:	50                   	push   %eax
8010624f:	e8 ce ad ff ff       	call   80101022 <fileclose>
80106254:	83 c4 10             	add    $0x10,%esp
    return -1;
80106257:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010625c:	eb 18                	jmp    80106276 <sys_pipe+0xd6>
  }
  fd[0] = fd0;
8010625e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106261:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106264:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80106266:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106269:	8d 50 04             	lea    0x4(%eax),%edx
8010626c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010626f:	89 02                	mov    %eax,(%edx)
  return 0;
80106271:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106276:	c9                   	leave  
80106277:	c3                   	ret    

80106278 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106278:	55                   	push   %ebp
80106279:	89 e5                	mov    %esp,%ebp
8010627b:	83 ec 08             	sub    $0x8,%esp
  return fork();
8010627e:	e8 64 e3 ff ff       	call   801045e7 <fork>
}
80106283:	c9                   	leave  
80106284:	c3                   	ret    

80106285 <sys_exit>:

int
sys_exit(void)
{
80106285:	55                   	push   %ebp
80106286:	89 e5                	mov    %esp,%ebp
80106288:	83 ec 08             	sub    $0x8,%esp
  exit();
8010628b:	e8 c8 e4 ff ff       	call   80104758 <exit>
  return 0;  // not reached
80106290:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106295:	c9                   	leave  
80106296:	c3                   	ret    

80106297 <sys_wait>:

int
sys_wait(void)
{
80106297:	55                   	push   %ebp
80106298:	89 e5                	mov    %esp,%ebp
8010629a:	83 ec 08             	sub    $0x8,%esp
  return wait();
8010629d:	e8 e4 e5 ff ff       	call   80104886 <wait>
}
801062a2:	c9                   	leave  
801062a3:	c3                   	ret    

801062a4 <sys_kill>:

int
sys_kill(void)
{
801062a4:	55                   	push   %ebp
801062a5:	89 e5                	mov    %esp,%ebp
801062a7:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
801062aa:	83 ec 08             	sub    $0x8,%esp
801062ad:	8d 45 f4             	lea    -0xc(%ebp),%eax
801062b0:	50                   	push   %eax
801062b1:	6a 00                	push   $0x0
801062b3:	e8 40 f1 ff ff       	call   801053f8 <argint>
801062b8:	83 c4 10             	add    $0x10,%esp
801062bb:	85 c0                	test   %eax,%eax
801062bd:	79 07                	jns    801062c6 <sys_kill+0x22>
    return -1;
801062bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062c4:	eb 0f                	jmp    801062d5 <sys_kill+0x31>
  return kill(pid);
801062c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062c9:	83 ec 0c             	sub    $0xc,%esp
801062cc:	50                   	push   %eax
801062cd:	e8 c7 e9 ff ff       	call   80104c99 <kill>
801062d2:	83 c4 10             	add    $0x10,%esp
}
801062d5:	c9                   	leave  
801062d6:	c3                   	ret    

801062d7 <sys_getpid>:

int
sys_getpid(void)
{
801062d7:	55                   	push   %ebp
801062d8:	89 e5                	mov    %esp,%ebp
  return proc->pid;
801062da:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062e0:	8b 40 10             	mov    0x10(%eax),%eax
}
801062e3:	5d                   	pop    %ebp
801062e4:	c3                   	ret    

801062e5 <sys_sbrk>:

int
sys_sbrk(void)
{
801062e5:	55                   	push   %ebp
801062e6:	89 e5                	mov    %esp,%ebp
801062e8:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801062eb:	83 ec 08             	sub    $0x8,%esp
801062ee:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062f1:	50                   	push   %eax
801062f2:	6a 00                	push   $0x0
801062f4:	e8 ff f0 ff ff       	call   801053f8 <argint>
801062f9:	83 c4 10             	add    $0x10,%esp
801062fc:	85 c0                	test   %eax,%eax
801062fe:	79 07                	jns    80106307 <sys_sbrk+0x22>
    return -1;
80106300:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106305:	eb 28                	jmp    8010632f <sys_sbrk+0x4a>
  addr = proc->sz;
80106307:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010630d:	8b 00                	mov    (%eax),%eax
8010630f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80106312:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106315:	83 ec 0c             	sub    $0xc,%esp
80106318:	50                   	push   %eax
80106319:	e8 26 e2 ff ff       	call   80104544 <growproc>
8010631e:	83 c4 10             	add    $0x10,%esp
80106321:	85 c0                	test   %eax,%eax
80106323:	79 07                	jns    8010632c <sys_sbrk+0x47>
    return -1;
80106325:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010632a:	eb 03                	jmp    8010632f <sys_sbrk+0x4a>
  return addr;
8010632c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010632f:	c9                   	leave  
80106330:	c3                   	ret    

80106331 <sys_sleep>:

int
sys_sleep(void)
{
80106331:	55                   	push   %ebp
80106332:	89 e5                	mov    %esp,%ebp
80106334:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
80106337:	83 ec 08             	sub    $0x8,%esp
8010633a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010633d:	50                   	push   %eax
8010633e:	6a 00                	push   $0x0
80106340:	e8 b3 f0 ff ff       	call   801053f8 <argint>
80106345:	83 c4 10             	add    $0x10,%esp
80106348:	85 c0                	test   %eax,%eax
8010634a:	79 07                	jns    80106353 <sys_sleep+0x22>
    return -1;
8010634c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106351:	eb 77                	jmp    801063ca <sys_sleep+0x99>
  acquire(&tickslock);
80106353:	83 ec 0c             	sub    $0xc,%esp
80106356:	68 a0 4e 11 80       	push   $0x80114ea0
8010635b:	e8 10 eb ff ff       	call   80104e70 <acquire>
80106360:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80106363:	a1 e0 56 11 80       	mov    0x801156e0,%eax
80106368:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
8010636b:	eb 39                	jmp    801063a6 <sys_sleep+0x75>
    if(proc->killed){
8010636d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106373:	8b 40 24             	mov    0x24(%eax),%eax
80106376:	85 c0                	test   %eax,%eax
80106378:	74 17                	je     80106391 <sys_sleep+0x60>
      release(&tickslock);
8010637a:	83 ec 0c             	sub    $0xc,%esp
8010637d:	68 a0 4e 11 80       	push   $0x80114ea0
80106382:	e8 50 eb ff ff       	call   80104ed7 <release>
80106387:	83 c4 10             	add    $0x10,%esp
      return -1;
8010638a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010638f:	eb 39                	jmp    801063ca <sys_sleep+0x99>
    }
    sleep(&ticks, &tickslock);
80106391:	83 ec 08             	sub    $0x8,%esp
80106394:	68 a0 4e 11 80       	push   $0x80114ea0
80106399:	68 e0 56 11 80       	push   $0x801156e0
8010639e:	e8 d4 e7 ff ff       	call   80104b77 <sleep>
801063a3:	83 c4 10             	add    $0x10,%esp
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801063a6:	a1 e0 56 11 80       	mov    0x801156e0,%eax
801063ab:	2b 45 f4             	sub    -0xc(%ebp),%eax
801063ae:	8b 55 f0             	mov    -0x10(%ebp),%edx
801063b1:	39 d0                	cmp    %edx,%eax
801063b3:	72 b8                	jb     8010636d <sys_sleep+0x3c>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801063b5:	83 ec 0c             	sub    $0xc,%esp
801063b8:	68 a0 4e 11 80       	push   $0x80114ea0
801063bd:	e8 15 eb ff ff       	call   80104ed7 <release>
801063c2:	83 c4 10             	add    $0x10,%esp
  return 0;
801063c5:	b8 00 00 00 00       	mov    $0x0,%eax
}
801063ca:	c9                   	leave  
801063cb:	c3                   	ret    

801063cc <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801063cc:	55                   	push   %ebp
801063cd:	89 e5                	mov    %esp,%ebp
801063cf:	83 ec 18             	sub    $0x18,%esp
  uint xticks;
  
  acquire(&tickslock);
801063d2:	83 ec 0c             	sub    $0xc,%esp
801063d5:	68 a0 4e 11 80       	push   $0x80114ea0
801063da:	e8 91 ea ff ff       	call   80104e70 <acquire>
801063df:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
801063e2:	a1 e0 56 11 80       	mov    0x801156e0,%eax
801063e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
801063ea:	83 ec 0c             	sub    $0xc,%esp
801063ed:	68 a0 4e 11 80       	push   $0x80114ea0
801063f2:	e8 e0 ea ff ff       	call   80104ed7 <release>
801063f7:	83 c4 10             	add    $0x10,%esp
  return xticks;
801063fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801063fd:	c9                   	leave  
801063fe:	c3                   	ret    

801063ff <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801063ff:	55                   	push   %ebp
80106400:	89 e5                	mov    %esp,%ebp
80106402:	83 ec 08             	sub    $0x8,%esp
80106405:	8b 55 08             	mov    0x8(%ebp),%edx
80106408:	8b 45 0c             	mov    0xc(%ebp),%eax
8010640b:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010640f:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106412:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106416:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010641a:	ee                   	out    %al,(%dx)
}
8010641b:	90                   	nop
8010641c:	c9                   	leave  
8010641d:	c3                   	ret    

8010641e <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
8010641e:	55                   	push   %ebp
8010641f:	89 e5                	mov    %esp,%ebp
80106421:	83 ec 08             	sub    $0x8,%esp
  // Interrupt --- 100 ticks/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
80106424:	6a 34                	push   $0x34
80106426:	6a 43                	push   $0x43
80106428:	e8 d2 ff ff ff       	call   801063ff <outb>
8010642d:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
80106430:	68 9c 00 00 00       	push   $0x9c
80106435:	6a 40                	push   $0x40
80106437:	e8 c3 ff ff ff       	call   801063ff <outb>
8010643c:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
8010643f:	6a 2e                	push   $0x2e
80106441:	6a 40                	push   $0x40
80106443:	e8 b7 ff ff ff       	call   801063ff <outb>
80106448:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
8010644b:	83 ec 0c             	sub    $0xc,%esp
8010644e:	6a 00                	push   $0x0
80106450:	e8 86 d9 ff ff       	call   80103ddb <picenable>
80106455:	83 c4 10             	add    $0x10,%esp
}
80106458:	90                   	nop
80106459:	c9                   	leave  
8010645a:	c3                   	ret    

8010645b <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010645b:	1e                   	push   %ds
  pushl %es
8010645c:	06                   	push   %es
  pushl %fs
8010645d:	0f a0                	push   %fs
  pushl %gs
8010645f:	0f a8                	push   %gs
  pushal
80106461:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80106462:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106466:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106468:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
8010646a:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
8010646e:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80106470:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80106472:	54                   	push   %esp
  call trap
80106473:	e8 d7 01 00 00       	call   8010664f <trap>
  addl $4, %esp
80106478:	83 c4 04             	add    $0x4,%esp

8010647b <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010647b:	61                   	popa   
  popl %gs
8010647c:	0f a9                	pop    %gs
  popl %fs
8010647e:	0f a1                	pop    %fs
  popl %es
80106480:	07                   	pop    %es
  popl %ds
80106481:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106482:	83 c4 08             	add    $0x8,%esp
  iret
80106485:	cf                   	iret   

80106486 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
80106486:	55                   	push   %ebp
80106487:	89 e5                	mov    %esp,%ebp
80106489:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
8010648c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010648f:	83 e8 01             	sub    $0x1,%eax
80106492:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106496:	8b 45 08             	mov    0x8(%ebp),%eax
80106499:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010649d:	8b 45 08             	mov    0x8(%ebp),%eax
801064a0:	c1 e8 10             	shr    $0x10,%eax
801064a3:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801064a7:	8d 45 fa             	lea    -0x6(%ebp),%eax
801064aa:	0f 01 18             	lidtl  (%eax)
}
801064ad:	90                   	nop
801064ae:	c9                   	leave  
801064af:	c3                   	ret    

801064b0 <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
801064b0:	55                   	push   %ebp
801064b1:	89 e5                	mov    %esp,%ebp
801064b3:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801064b6:	0f 20 d0             	mov    %cr2,%eax
801064b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
801064bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801064bf:	c9                   	leave  
801064c0:	c3                   	ret    

801064c1 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801064c1:	55                   	push   %ebp
801064c2:	89 e5                	mov    %esp,%ebp
801064c4:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
801064c7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801064ce:	e9 c3 00 00 00       	jmp    80106596 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801064d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064d6:	8b 04 85 b0 e0 10 80 	mov    -0x7fef1f50(,%eax,4),%eax
801064dd:	89 c2                	mov    %eax,%edx
801064df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064e2:	66 89 14 c5 e0 4e 11 	mov    %dx,-0x7feeb120(,%eax,8)
801064e9:	80 
801064ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064ed:	66 c7 04 c5 e2 4e 11 	movw   $0x8,-0x7feeb11e(,%eax,8)
801064f4:	80 08 00 
801064f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064fa:	0f b6 14 c5 e4 4e 11 	movzbl -0x7feeb11c(,%eax,8),%edx
80106501:	80 
80106502:	83 e2 e0             	and    $0xffffffe0,%edx
80106505:	88 14 c5 e4 4e 11 80 	mov    %dl,-0x7feeb11c(,%eax,8)
8010650c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010650f:	0f b6 14 c5 e4 4e 11 	movzbl -0x7feeb11c(,%eax,8),%edx
80106516:	80 
80106517:	83 e2 1f             	and    $0x1f,%edx
8010651a:	88 14 c5 e4 4e 11 80 	mov    %dl,-0x7feeb11c(,%eax,8)
80106521:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106524:	0f b6 14 c5 e5 4e 11 	movzbl -0x7feeb11b(,%eax,8),%edx
8010652b:	80 
8010652c:	83 e2 f0             	and    $0xfffffff0,%edx
8010652f:	83 ca 0e             	or     $0xe,%edx
80106532:	88 14 c5 e5 4e 11 80 	mov    %dl,-0x7feeb11b(,%eax,8)
80106539:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010653c:	0f b6 14 c5 e5 4e 11 	movzbl -0x7feeb11b(,%eax,8),%edx
80106543:	80 
80106544:	83 e2 ef             	and    $0xffffffef,%edx
80106547:	88 14 c5 e5 4e 11 80 	mov    %dl,-0x7feeb11b(,%eax,8)
8010654e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106551:	0f b6 14 c5 e5 4e 11 	movzbl -0x7feeb11b(,%eax,8),%edx
80106558:	80 
80106559:	83 e2 9f             	and    $0xffffff9f,%edx
8010655c:	88 14 c5 e5 4e 11 80 	mov    %dl,-0x7feeb11b(,%eax,8)
80106563:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106566:	0f b6 14 c5 e5 4e 11 	movzbl -0x7feeb11b(,%eax,8),%edx
8010656d:	80 
8010656e:	83 ca 80             	or     $0xffffff80,%edx
80106571:	88 14 c5 e5 4e 11 80 	mov    %dl,-0x7feeb11b(,%eax,8)
80106578:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010657b:	8b 04 85 b0 e0 10 80 	mov    -0x7fef1f50(,%eax,4),%eax
80106582:	c1 e8 10             	shr    $0x10,%eax
80106585:	89 c2                	mov    %eax,%edx
80106587:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010658a:	66 89 14 c5 e6 4e 11 	mov    %dx,-0x7feeb11a(,%eax,8)
80106591:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106592:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106596:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
8010659d:	0f 8e 30 ff ff ff    	jle    801064d3 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801065a3:	a1 b0 e1 10 80       	mov    0x8010e1b0,%eax
801065a8:	66 a3 e0 50 11 80    	mov    %ax,0x801150e0
801065ae:	66 c7 05 e2 50 11 80 	movw   $0x8,0x801150e2
801065b5:	08 00 
801065b7:	0f b6 05 e4 50 11 80 	movzbl 0x801150e4,%eax
801065be:	83 e0 e0             	and    $0xffffffe0,%eax
801065c1:	a2 e4 50 11 80       	mov    %al,0x801150e4
801065c6:	0f b6 05 e4 50 11 80 	movzbl 0x801150e4,%eax
801065cd:	83 e0 1f             	and    $0x1f,%eax
801065d0:	a2 e4 50 11 80       	mov    %al,0x801150e4
801065d5:	0f b6 05 e5 50 11 80 	movzbl 0x801150e5,%eax
801065dc:	83 c8 0f             	or     $0xf,%eax
801065df:	a2 e5 50 11 80       	mov    %al,0x801150e5
801065e4:	0f b6 05 e5 50 11 80 	movzbl 0x801150e5,%eax
801065eb:	83 e0 ef             	and    $0xffffffef,%eax
801065ee:	a2 e5 50 11 80       	mov    %al,0x801150e5
801065f3:	0f b6 05 e5 50 11 80 	movzbl 0x801150e5,%eax
801065fa:	83 c8 60             	or     $0x60,%eax
801065fd:	a2 e5 50 11 80       	mov    %al,0x801150e5
80106602:	0f b6 05 e5 50 11 80 	movzbl 0x801150e5,%eax
80106609:	83 c8 80             	or     $0xffffff80,%eax
8010660c:	a2 e5 50 11 80       	mov    %al,0x801150e5
80106611:	a1 b0 e1 10 80       	mov    0x8010e1b0,%eax
80106616:	c1 e8 10             	shr    $0x10,%eax
80106619:	66 a3 e6 50 11 80    	mov    %ax,0x801150e6
  
  initlock(&tickslock, "time");
8010661f:	83 ec 08             	sub    $0x8,%esp
80106622:	68 30 b9 10 80       	push   $0x8010b930
80106627:	68 a0 4e 11 80       	push   $0x80114ea0
8010662c:	e8 1d e8 ff ff       	call   80104e4e <initlock>
80106631:	83 c4 10             	add    $0x10,%esp
}
80106634:	90                   	nop
80106635:	c9                   	leave  
80106636:	c3                   	ret    

80106637 <idtinit>:

void
idtinit(void)
{
80106637:	55                   	push   %ebp
80106638:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
8010663a:	68 00 08 00 00       	push   $0x800
8010663f:	68 e0 4e 11 80       	push   $0x80114ee0
80106644:	e8 3d fe ff ff       	call   80106486 <lidt>
80106649:	83 c4 08             	add    $0x8,%esp
}
8010664c:	90                   	nop
8010664d:	c9                   	leave  
8010664e:	c3                   	ret    

8010664f <trap>:
extern void TimerCount();

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
8010664f:	55                   	push   %ebp
80106650:	89 e5                	mov    %esp,%ebp
80106652:	57                   	push   %edi
80106653:	56                   	push   %esi
80106654:	53                   	push   %ebx
80106655:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
80106658:	8b 45 08             	mov    0x8(%ebp),%eax
8010665b:	8b 40 30             	mov    0x30(%eax),%eax
8010665e:	83 f8 40             	cmp    $0x40,%eax
80106661:	75 3e                	jne    801066a1 <trap+0x52>
    if(proc->killed)
80106663:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106669:	8b 40 24             	mov    0x24(%eax),%eax
8010666c:	85 c0                	test   %eax,%eax
8010666e:	74 05                	je     80106675 <trap+0x26>
      exit();
80106670:	e8 e3 e0 ff ff       	call   80104758 <exit>
    proc->tf = tf;
80106675:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010667b:	8b 55 08             	mov    0x8(%ebp),%edx
8010667e:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80106681:	e8 28 ee ff ff       	call   801054ae <syscall>
    if(proc->killed)
80106686:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010668c:	8b 40 24             	mov    0x24(%eax),%eax
8010668f:	85 c0                	test   %eax,%eax
80106691:	0f 84 20 02 00 00    	je     801068b7 <trap+0x268>
      exit();
80106697:	e8 bc e0 ff ff       	call   80104758 <exit>
    return;
8010669c:	e9 16 02 00 00       	jmp    801068b7 <trap+0x268>
  }

  switch(tf->trapno){
801066a1:	8b 45 08             	mov    0x8(%ebp),%eax
801066a4:	8b 40 30             	mov    0x30(%eax),%eax
801066a7:	83 e8 20             	sub    $0x20,%eax
801066aa:	83 f8 1f             	cmp    $0x1f,%eax
801066ad:	0f 87 c5 00 00 00    	ja     80106778 <trap+0x129>
801066b3:	8b 04 85 d8 b9 10 80 	mov    -0x7fef4628(,%eax,4),%eax
801066ba:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
801066bc:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801066c2:	0f b6 00             	movzbl (%eax),%eax
801066c5:	84 c0                	test   %al,%al
801066c7:	75 3d                	jne    80106706 <trap+0xb7>
      acquire(&tickslock);
801066c9:	83 ec 0c             	sub    $0xc,%esp
801066cc:	68 a0 4e 11 80       	push   $0x80114ea0
801066d1:	e8 9a e7 ff ff       	call   80104e70 <acquire>
801066d6:	83 c4 10             	add    $0x10,%esp
      ticks++;
801066d9:	a1 e0 56 11 80       	mov    0x801156e0,%eax
801066de:	83 c0 01             	add    $0x1,%eax
801066e1:	a3 e0 56 11 80       	mov    %eax,0x801156e0
      wakeup(&ticks);
801066e6:	83 ec 0c             	sub    $0xc,%esp
801066e9:	68 e0 56 11 80       	push   $0x801156e0
801066ee:	e8 6f e5 ff ff       	call   80104c62 <wakeup>
801066f3:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
801066f6:	83 ec 0c             	sub    $0xc,%esp
801066f9:	68 a0 4e 11 80       	push   $0x80114ea0
801066fe:	e8 d4 e7 ff ff       	call   80104ed7 <release>
80106703:	83 c4 10             	add    $0x10,%esp
    }
	//DealHandleMessage(ticks);
    TimerCount();
80106706:	e8 7d 47 00 00       	call   8010ae88 <TimerCount>
    lapiceoi();
8010670b:	e8 de ca ff ff       	call   801031ee <lapiceoi>
    break;
80106710:	e9 1c 01 00 00       	jmp    80106831 <trap+0x1e2>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106715:	e8 b8 c1 ff ff       	call   801028d2 <ideintr>
    lapiceoi();
8010671a:	e8 cf ca ff ff       	call   801031ee <lapiceoi>
    break;
8010671f:	e9 0d 01 00 00       	jmp    80106831 <trap+0x1e2>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106724:	e8 ef c8 ff ff       	call   80103018 <kbdintr>
    lapiceoi();
80106729:	e8 c0 ca ff ff       	call   801031ee <lapiceoi>
    break;
8010672e:	e9 fe 00 00 00       	jmp    80106831 <trap+0x1e2>

    //HandleInterupt();
    //lapiceoi();
  //  break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106733:	e8 60 03 00 00       	call   80106a98 <uartintr>
    lapiceoi();
80106738:	e8 b1 ca ff ff       	call   801031ee <lapiceoi>
    break;
8010673d:	e9 ef 00 00 00       	jmp    80106831 <trap+0x1e2>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106742:	8b 45 08             	mov    0x8(%ebp),%eax
80106745:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80106748:	8b 45 08             	mov    0x8(%ebp),%eax
8010674b:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010674f:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
80106752:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106758:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010675b:	0f b6 c0             	movzbl %al,%eax
8010675e:	51                   	push   %ecx
8010675f:	52                   	push   %edx
80106760:	50                   	push   %eax
80106761:	68 38 b9 10 80       	push   $0x8010b938
80106766:	e8 5b 9c ff ff       	call   801003c6 <cprintf>
8010676b:	83 c4 10             	add    $0x10,%esp
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
8010676e:	e8 7b ca ff ff       	call   801031ee <lapiceoi>
    break;
80106773:	e9 b9 00 00 00       	jmp    80106831 <trap+0x1e2>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106778:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010677e:	85 c0                	test   %eax,%eax
80106780:	74 11                	je     80106793 <trap+0x144>
80106782:	8b 45 08             	mov    0x8(%ebp),%eax
80106785:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106789:	0f b7 c0             	movzwl %ax,%eax
8010678c:	83 e0 03             	and    $0x3,%eax
8010678f:	85 c0                	test   %eax,%eax
80106791:	75 40                	jne    801067d3 <trap+0x184>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106793:	e8 18 fd ff ff       	call   801064b0 <rcr2>
80106798:	89 c3                	mov    %eax,%ebx
8010679a:	8b 45 08             	mov    0x8(%ebp),%eax
8010679d:	8b 48 38             	mov    0x38(%eax),%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
801067a0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801067a6:	0f b6 00             	movzbl (%eax),%eax
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801067a9:	0f b6 d0             	movzbl %al,%edx
801067ac:	8b 45 08             	mov    0x8(%ebp),%eax
801067af:	8b 40 30             	mov    0x30(%eax),%eax
801067b2:	83 ec 0c             	sub    $0xc,%esp
801067b5:	53                   	push   %ebx
801067b6:	51                   	push   %ecx
801067b7:	52                   	push   %edx
801067b8:	50                   	push   %eax
801067b9:	68 5c b9 10 80       	push   $0x8010b95c
801067be:	e8 03 9c ff ff       	call   801003c6 <cprintf>
801067c3:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
801067c6:	83 ec 0c             	sub    $0xc,%esp
801067c9:	68 8e b9 10 80       	push   $0x8010b98e
801067ce:	e8 93 9d ff ff       	call   80100566 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801067d3:	e8 d8 fc ff ff       	call   801064b0 <rcr2>
801067d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801067db:	8b 45 08             	mov    0x8(%ebp),%eax
801067de:	8b 70 38             	mov    0x38(%eax),%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801067e1:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801067e7:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801067ea:	0f b6 d8             	movzbl %al,%ebx
801067ed:	8b 45 08             	mov    0x8(%ebp),%eax
801067f0:	8b 48 34             	mov    0x34(%eax),%ecx
801067f3:	8b 45 08             	mov    0x8(%ebp),%eax
801067f6:	8b 50 30             	mov    0x30(%eax),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801067f9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801067ff:	8d 78 6c             	lea    0x6c(%eax),%edi
80106802:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106808:	8b 40 10             	mov    0x10(%eax),%eax
8010680b:	ff 75 e4             	pushl  -0x1c(%ebp)
8010680e:	56                   	push   %esi
8010680f:	53                   	push   %ebx
80106810:	51                   	push   %ecx
80106811:	52                   	push   %edx
80106812:	57                   	push   %edi
80106813:	50                   	push   %eax
80106814:	68 94 b9 10 80       	push   $0x8010b994
80106819:	e8 a8 9b ff ff       	call   801003c6 <cprintf>
8010681e:	83 c4 20             	add    $0x20,%esp
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
80106821:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106827:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010682e:	eb 01                	jmp    80106831 <trap+0x1e2>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106830:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106831:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106837:	85 c0                	test   %eax,%eax
80106839:	74 24                	je     8010685f <trap+0x210>
8010683b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106841:	8b 40 24             	mov    0x24(%eax),%eax
80106844:	85 c0                	test   %eax,%eax
80106846:	74 17                	je     8010685f <trap+0x210>
80106848:	8b 45 08             	mov    0x8(%ebp),%eax
8010684b:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
8010684f:	0f b7 c0             	movzwl %ax,%eax
80106852:	83 e0 03             	and    $0x3,%eax
80106855:	83 f8 03             	cmp    $0x3,%eax
80106858:	75 05                	jne    8010685f <trap+0x210>
    exit();
8010685a:	e8 f9 de ff ff       	call   80104758 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
8010685f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106865:	85 c0                	test   %eax,%eax
80106867:	74 1e                	je     80106887 <trap+0x238>
80106869:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010686f:	8b 40 0c             	mov    0xc(%eax),%eax
80106872:	83 f8 04             	cmp    $0x4,%eax
80106875:	75 10                	jne    80106887 <trap+0x238>
80106877:	8b 45 08             	mov    0x8(%ebp),%eax
8010687a:	8b 40 30             	mov    0x30(%eax),%eax
8010687d:	83 f8 20             	cmp    $0x20,%eax
80106880:	75 05                	jne    80106887 <trap+0x238>
    yield();
80106882:	e8 84 e2 ff ff       	call   80104b0b <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106887:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010688d:	85 c0                	test   %eax,%eax
8010688f:	74 27                	je     801068b8 <trap+0x269>
80106891:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106897:	8b 40 24             	mov    0x24(%eax),%eax
8010689a:	85 c0                	test   %eax,%eax
8010689c:	74 1a                	je     801068b8 <trap+0x269>
8010689e:	8b 45 08             	mov    0x8(%ebp),%eax
801068a1:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801068a5:	0f b7 c0             	movzwl %ax,%eax
801068a8:	83 e0 03             	and    $0x3,%eax
801068ab:	83 f8 03             	cmp    $0x3,%eax
801068ae:	75 08                	jne    801068b8 <trap+0x269>
    exit();
801068b0:	e8 a3 de ff ff       	call   80104758 <exit>
801068b5:	eb 01                	jmp    801068b8 <trap+0x269>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
801068b7:	90                   	nop
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
801068b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068bb:	5b                   	pop    %ebx
801068bc:	5e                   	pop    %esi
801068bd:	5f                   	pop    %edi
801068be:	5d                   	pop    %ebp
801068bf:	c3                   	ret    

801068c0 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	83 ec 14             	sub    $0x14,%esp
801068c6:	8b 45 08             	mov    0x8(%ebp),%eax
801068c9:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801068cd:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801068d1:	89 c2                	mov    %eax,%edx
801068d3:	ec                   	in     (%dx),%al
801068d4:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801068d7:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801068db:	c9                   	leave  
801068dc:	c3                   	ret    

801068dd <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801068dd:	55                   	push   %ebp
801068de:	89 e5                	mov    %esp,%ebp
801068e0:	83 ec 08             	sub    $0x8,%esp
801068e3:	8b 55 08             	mov    0x8(%ebp),%edx
801068e6:	8b 45 0c             	mov    0xc(%ebp),%eax
801068e9:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801068ed:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801068f0:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801068f4:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801068f8:	ee                   	out    %al,(%dx)
}
801068f9:	90                   	nop
801068fa:	c9                   	leave  
801068fb:	c3                   	ret    

801068fc <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
801068fc:	55                   	push   %ebp
801068fd:	89 e5                	mov    %esp,%ebp
801068ff:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106902:	6a 00                	push   $0x0
80106904:	68 fa 03 00 00       	push   $0x3fa
80106909:	e8 cf ff ff ff       	call   801068dd <outb>
8010690e:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106911:	68 80 00 00 00       	push   $0x80
80106916:	68 fb 03 00 00       	push   $0x3fb
8010691b:	e8 bd ff ff ff       	call   801068dd <outb>
80106920:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80106923:	6a 0c                	push   $0xc
80106925:	68 f8 03 00 00       	push   $0x3f8
8010692a:	e8 ae ff ff ff       	call   801068dd <outb>
8010692f:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80106932:	6a 00                	push   $0x0
80106934:	68 f9 03 00 00       	push   $0x3f9
80106939:	e8 9f ff ff ff       	call   801068dd <outb>
8010693e:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106941:	6a 03                	push   $0x3
80106943:	68 fb 03 00 00       	push   $0x3fb
80106948:	e8 90 ff ff ff       	call   801068dd <outb>
8010694d:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106950:	6a 00                	push   $0x0
80106952:	68 fc 03 00 00       	push   $0x3fc
80106957:	e8 81 ff ff ff       	call   801068dd <outb>
8010695c:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
8010695f:	6a 01                	push   $0x1
80106961:	68 f9 03 00 00       	push   $0x3f9
80106966:	e8 72 ff ff ff       	call   801068dd <outb>
8010696b:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
8010696e:	68 fd 03 00 00       	push   $0x3fd
80106973:	e8 48 ff ff ff       	call   801068c0 <inb>
80106978:	83 c4 04             	add    $0x4,%esp
8010697b:	3c ff                	cmp    $0xff,%al
8010697d:	74 6e                	je     801069ed <uartinit+0xf1>
    return;
  uart = 1;
8010697f:	c7 05 70 e6 10 80 01 	movl   $0x1,0x8010e670
80106986:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106989:	68 fa 03 00 00       	push   $0x3fa
8010698e:	e8 2d ff ff ff       	call   801068c0 <inb>
80106993:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80106996:	68 f8 03 00 00       	push   $0x3f8
8010699b:	e8 20 ff ff ff       	call   801068c0 <inb>
801069a0:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
801069a3:	83 ec 0c             	sub    $0xc,%esp
801069a6:	6a 04                	push   $0x4
801069a8:	e8 2e d4 ff ff       	call   80103ddb <picenable>
801069ad:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
801069b0:	83 ec 08             	sub    $0x8,%esp
801069b3:	6a 00                	push   $0x0
801069b5:	6a 04                	push   $0x4
801069b7:	e8 b8 c1 ff ff       	call   80102b74 <ioapicenable>
801069bc:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801069bf:	c7 45 f4 58 ba 10 80 	movl   $0x8010ba58,-0xc(%ebp)
801069c6:	eb 19                	jmp    801069e1 <uartinit+0xe5>
    uartputc(*p);
801069c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069cb:	0f b6 00             	movzbl (%eax),%eax
801069ce:	0f be c0             	movsbl %al,%eax
801069d1:	83 ec 0c             	sub    $0xc,%esp
801069d4:	50                   	push   %eax
801069d5:	e8 16 00 00 00       	call   801069f0 <uartputc>
801069da:	83 c4 10             	add    $0x10,%esp
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801069dd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801069e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069e4:	0f b6 00             	movzbl (%eax),%eax
801069e7:	84 c0                	test   %al,%al
801069e9:	75 dd                	jne    801069c8 <uartinit+0xcc>
801069eb:	eb 01                	jmp    801069ee <uartinit+0xf2>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
801069ed:	90                   	nop
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
801069ee:	c9                   	leave  
801069ef:	c3                   	ret    

801069f0 <uartputc>:

void
uartputc(int c)
{
801069f0:	55                   	push   %ebp
801069f1:	89 e5                	mov    %esp,%ebp
801069f3:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
801069f6:	a1 70 e6 10 80       	mov    0x8010e670,%eax
801069fb:	85 c0                	test   %eax,%eax
801069fd:	74 53                	je     80106a52 <uartputc+0x62>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801069ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106a06:	eb 11                	jmp    80106a19 <uartputc+0x29>
    microdelay(10);
80106a08:	83 ec 0c             	sub    $0xc,%esp
80106a0b:	6a 0a                	push   $0xa
80106a0d:	e8 f7 c7 ff ff       	call   80103209 <microdelay>
80106a12:	83 c4 10             	add    $0x10,%esp
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106a15:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106a19:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106a1d:	7f 1a                	jg     80106a39 <uartputc+0x49>
80106a1f:	83 ec 0c             	sub    $0xc,%esp
80106a22:	68 fd 03 00 00       	push   $0x3fd
80106a27:	e8 94 fe ff ff       	call   801068c0 <inb>
80106a2c:	83 c4 10             	add    $0x10,%esp
80106a2f:	0f b6 c0             	movzbl %al,%eax
80106a32:	83 e0 20             	and    $0x20,%eax
80106a35:	85 c0                	test   %eax,%eax
80106a37:	74 cf                	je     80106a08 <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
80106a39:	8b 45 08             	mov    0x8(%ebp),%eax
80106a3c:	0f b6 c0             	movzbl %al,%eax
80106a3f:	83 ec 08             	sub    $0x8,%esp
80106a42:	50                   	push   %eax
80106a43:	68 f8 03 00 00       	push   $0x3f8
80106a48:	e8 90 fe ff ff       	call   801068dd <outb>
80106a4d:	83 c4 10             	add    $0x10,%esp
80106a50:	eb 01                	jmp    80106a53 <uartputc+0x63>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
80106a52:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106a53:	c9                   	leave  
80106a54:	c3                   	ret    

80106a55 <uartgetc>:

static int
uartgetc(void)
{
80106a55:	55                   	push   %ebp
80106a56:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106a58:	a1 70 e6 10 80       	mov    0x8010e670,%eax
80106a5d:	85 c0                	test   %eax,%eax
80106a5f:	75 07                	jne    80106a68 <uartgetc+0x13>
    return -1;
80106a61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a66:	eb 2e                	jmp    80106a96 <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80106a68:	68 fd 03 00 00       	push   $0x3fd
80106a6d:	e8 4e fe ff ff       	call   801068c0 <inb>
80106a72:	83 c4 04             	add    $0x4,%esp
80106a75:	0f b6 c0             	movzbl %al,%eax
80106a78:	83 e0 01             	and    $0x1,%eax
80106a7b:	85 c0                	test   %eax,%eax
80106a7d:	75 07                	jne    80106a86 <uartgetc+0x31>
    return -1;
80106a7f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a84:	eb 10                	jmp    80106a96 <uartgetc+0x41>
  return inb(COM1+0);
80106a86:	68 f8 03 00 00       	push   $0x3f8
80106a8b:	e8 30 fe ff ff       	call   801068c0 <inb>
80106a90:	83 c4 04             	add    $0x4,%esp
80106a93:	0f b6 c0             	movzbl %al,%eax
}
80106a96:	c9                   	leave  
80106a97:	c3                   	ret    

80106a98 <uartintr>:

void
uartintr(void)
{
80106a98:	55                   	push   %ebp
80106a99:	89 e5                	mov    %esp,%ebp
80106a9b:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80106a9e:	83 ec 0c             	sub    $0xc,%esp
80106aa1:	68 55 6a 10 80       	push   $0x80106a55
80106aa6:	e8 32 9d ff ff       	call   801007dd <consoleintr>
80106aab:	83 c4 10             	add    $0x10,%esp
}
80106aae:	90                   	nop
80106aaf:	c9                   	leave  
80106ab0:	c3                   	ret    

80106ab1 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106ab1:	6a 00                	push   $0x0
  pushl $0
80106ab3:	6a 00                	push   $0x0
  jmp alltraps
80106ab5:	e9 a1 f9 ff ff       	jmp    8010645b <alltraps>

80106aba <vector1>:
.globl vector1
vector1:
  pushl $0
80106aba:	6a 00                	push   $0x0
  pushl $1
80106abc:	6a 01                	push   $0x1
  jmp alltraps
80106abe:	e9 98 f9 ff ff       	jmp    8010645b <alltraps>

80106ac3 <vector2>:
.globl vector2
vector2:
  pushl $0
80106ac3:	6a 00                	push   $0x0
  pushl $2
80106ac5:	6a 02                	push   $0x2
  jmp alltraps
80106ac7:	e9 8f f9 ff ff       	jmp    8010645b <alltraps>

80106acc <vector3>:
.globl vector3
vector3:
  pushl $0
80106acc:	6a 00                	push   $0x0
  pushl $3
80106ace:	6a 03                	push   $0x3
  jmp alltraps
80106ad0:	e9 86 f9 ff ff       	jmp    8010645b <alltraps>

80106ad5 <vector4>:
.globl vector4
vector4:
  pushl $0
80106ad5:	6a 00                	push   $0x0
  pushl $4
80106ad7:	6a 04                	push   $0x4
  jmp alltraps
80106ad9:	e9 7d f9 ff ff       	jmp    8010645b <alltraps>

80106ade <vector5>:
.globl vector5
vector5:
  pushl $0
80106ade:	6a 00                	push   $0x0
  pushl $5
80106ae0:	6a 05                	push   $0x5
  jmp alltraps
80106ae2:	e9 74 f9 ff ff       	jmp    8010645b <alltraps>

80106ae7 <vector6>:
.globl vector6
vector6:
  pushl $0
80106ae7:	6a 00                	push   $0x0
  pushl $6
80106ae9:	6a 06                	push   $0x6
  jmp alltraps
80106aeb:	e9 6b f9 ff ff       	jmp    8010645b <alltraps>

80106af0 <vector7>:
.globl vector7
vector7:
  pushl $0
80106af0:	6a 00                	push   $0x0
  pushl $7
80106af2:	6a 07                	push   $0x7
  jmp alltraps
80106af4:	e9 62 f9 ff ff       	jmp    8010645b <alltraps>

80106af9 <vector8>:
.globl vector8
vector8:
  pushl $8
80106af9:	6a 08                	push   $0x8
  jmp alltraps
80106afb:	e9 5b f9 ff ff       	jmp    8010645b <alltraps>

80106b00 <vector9>:
.globl vector9
vector9:
  pushl $0
80106b00:	6a 00                	push   $0x0
  pushl $9
80106b02:	6a 09                	push   $0x9
  jmp alltraps
80106b04:	e9 52 f9 ff ff       	jmp    8010645b <alltraps>

80106b09 <vector10>:
.globl vector10
vector10:
  pushl $10
80106b09:	6a 0a                	push   $0xa
  jmp alltraps
80106b0b:	e9 4b f9 ff ff       	jmp    8010645b <alltraps>

80106b10 <vector11>:
.globl vector11
vector11:
  pushl $11
80106b10:	6a 0b                	push   $0xb
  jmp alltraps
80106b12:	e9 44 f9 ff ff       	jmp    8010645b <alltraps>

80106b17 <vector12>:
.globl vector12
vector12:
  pushl $12
80106b17:	6a 0c                	push   $0xc
  jmp alltraps
80106b19:	e9 3d f9 ff ff       	jmp    8010645b <alltraps>

80106b1e <vector13>:
.globl vector13
vector13:
  pushl $13
80106b1e:	6a 0d                	push   $0xd
  jmp alltraps
80106b20:	e9 36 f9 ff ff       	jmp    8010645b <alltraps>

80106b25 <vector14>:
.globl vector14
vector14:
  pushl $14
80106b25:	6a 0e                	push   $0xe
  jmp alltraps
80106b27:	e9 2f f9 ff ff       	jmp    8010645b <alltraps>

80106b2c <vector15>:
.globl vector15
vector15:
  pushl $0
80106b2c:	6a 00                	push   $0x0
  pushl $15
80106b2e:	6a 0f                	push   $0xf
  jmp alltraps
80106b30:	e9 26 f9 ff ff       	jmp    8010645b <alltraps>

80106b35 <vector16>:
.globl vector16
vector16:
  pushl $0
80106b35:	6a 00                	push   $0x0
  pushl $16
80106b37:	6a 10                	push   $0x10
  jmp alltraps
80106b39:	e9 1d f9 ff ff       	jmp    8010645b <alltraps>

80106b3e <vector17>:
.globl vector17
vector17:
  pushl $17
80106b3e:	6a 11                	push   $0x11
  jmp alltraps
80106b40:	e9 16 f9 ff ff       	jmp    8010645b <alltraps>

80106b45 <vector18>:
.globl vector18
vector18:
  pushl $0
80106b45:	6a 00                	push   $0x0
  pushl $18
80106b47:	6a 12                	push   $0x12
  jmp alltraps
80106b49:	e9 0d f9 ff ff       	jmp    8010645b <alltraps>

80106b4e <vector19>:
.globl vector19
vector19:
  pushl $0
80106b4e:	6a 00                	push   $0x0
  pushl $19
80106b50:	6a 13                	push   $0x13
  jmp alltraps
80106b52:	e9 04 f9 ff ff       	jmp    8010645b <alltraps>

80106b57 <vector20>:
.globl vector20
vector20:
  pushl $0
80106b57:	6a 00                	push   $0x0
  pushl $20
80106b59:	6a 14                	push   $0x14
  jmp alltraps
80106b5b:	e9 fb f8 ff ff       	jmp    8010645b <alltraps>

80106b60 <vector21>:
.globl vector21
vector21:
  pushl $0
80106b60:	6a 00                	push   $0x0
  pushl $21
80106b62:	6a 15                	push   $0x15
  jmp alltraps
80106b64:	e9 f2 f8 ff ff       	jmp    8010645b <alltraps>

80106b69 <vector22>:
.globl vector22
vector22:
  pushl $0
80106b69:	6a 00                	push   $0x0
  pushl $22
80106b6b:	6a 16                	push   $0x16
  jmp alltraps
80106b6d:	e9 e9 f8 ff ff       	jmp    8010645b <alltraps>

80106b72 <vector23>:
.globl vector23
vector23:
  pushl $0
80106b72:	6a 00                	push   $0x0
  pushl $23
80106b74:	6a 17                	push   $0x17
  jmp alltraps
80106b76:	e9 e0 f8 ff ff       	jmp    8010645b <alltraps>

80106b7b <vector24>:
.globl vector24
vector24:
  pushl $0
80106b7b:	6a 00                	push   $0x0
  pushl $24
80106b7d:	6a 18                	push   $0x18
  jmp alltraps
80106b7f:	e9 d7 f8 ff ff       	jmp    8010645b <alltraps>

80106b84 <vector25>:
.globl vector25
vector25:
  pushl $0
80106b84:	6a 00                	push   $0x0
  pushl $25
80106b86:	6a 19                	push   $0x19
  jmp alltraps
80106b88:	e9 ce f8 ff ff       	jmp    8010645b <alltraps>

80106b8d <vector26>:
.globl vector26
vector26:
  pushl $0
80106b8d:	6a 00                	push   $0x0
  pushl $26
80106b8f:	6a 1a                	push   $0x1a
  jmp alltraps
80106b91:	e9 c5 f8 ff ff       	jmp    8010645b <alltraps>

80106b96 <vector27>:
.globl vector27
vector27:
  pushl $0
80106b96:	6a 00                	push   $0x0
  pushl $27
80106b98:	6a 1b                	push   $0x1b
  jmp alltraps
80106b9a:	e9 bc f8 ff ff       	jmp    8010645b <alltraps>

80106b9f <vector28>:
.globl vector28
vector28:
  pushl $0
80106b9f:	6a 00                	push   $0x0
  pushl $28
80106ba1:	6a 1c                	push   $0x1c
  jmp alltraps
80106ba3:	e9 b3 f8 ff ff       	jmp    8010645b <alltraps>

80106ba8 <vector29>:
.globl vector29
vector29:
  pushl $0
80106ba8:	6a 00                	push   $0x0
  pushl $29
80106baa:	6a 1d                	push   $0x1d
  jmp alltraps
80106bac:	e9 aa f8 ff ff       	jmp    8010645b <alltraps>

80106bb1 <vector30>:
.globl vector30
vector30:
  pushl $0
80106bb1:	6a 00                	push   $0x0
  pushl $30
80106bb3:	6a 1e                	push   $0x1e
  jmp alltraps
80106bb5:	e9 a1 f8 ff ff       	jmp    8010645b <alltraps>

80106bba <vector31>:
.globl vector31
vector31:
  pushl $0
80106bba:	6a 00                	push   $0x0
  pushl $31
80106bbc:	6a 1f                	push   $0x1f
  jmp alltraps
80106bbe:	e9 98 f8 ff ff       	jmp    8010645b <alltraps>

80106bc3 <vector32>:
.globl vector32
vector32:
  pushl $0
80106bc3:	6a 00                	push   $0x0
  pushl $32
80106bc5:	6a 20                	push   $0x20
  jmp alltraps
80106bc7:	e9 8f f8 ff ff       	jmp    8010645b <alltraps>

80106bcc <vector33>:
.globl vector33
vector33:
  pushl $0
80106bcc:	6a 00                	push   $0x0
  pushl $33
80106bce:	6a 21                	push   $0x21
  jmp alltraps
80106bd0:	e9 86 f8 ff ff       	jmp    8010645b <alltraps>

80106bd5 <vector34>:
.globl vector34
vector34:
  pushl $0
80106bd5:	6a 00                	push   $0x0
  pushl $34
80106bd7:	6a 22                	push   $0x22
  jmp alltraps
80106bd9:	e9 7d f8 ff ff       	jmp    8010645b <alltraps>

80106bde <vector35>:
.globl vector35
vector35:
  pushl $0
80106bde:	6a 00                	push   $0x0
  pushl $35
80106be0:	6a 23                	push   $0x23
  jmp alltraps
80106be2:	e9 74 f8 ff ff       	jmp    8010645b <alltraps>

80106be7 <vector36>:
.globl vector36
vector36:
  pushl $0
80106be7:	6a 00                	push   $0x0
  pushl $36
80106be9:	6a 24                	push   $0x24
  jmp alltraps
80106beb:	e9 6b f8 ff ff       	jmp    8010645b <alltraps>

80106bf0 <vector37>:
.globl vector37
vector37:
  pushl $0
80106bf0:	6a 00                	push   $0x0
  pushl $37
80106bf2:	6a 25                	push   $0x25
  jmp alltraps
80106bf4:	e9 62 f8 ff ff       	jmp    8010645b <alltraps>

80106bf9 <vector38>:
.globl vector38
vector38:
  pushl $0
80106bf9:	6a 00                	push   $0x0
  pushl $38
80106bfb:	6a 26                	push   $0x26
  jmp alltraps
80106bfd:	e9 59 f8 ff ff       	jmp    8010645b <alltraps>

80106c02 <vector39>:
.globl vector39
vector39:
  pushl $0
80106c02:	6a 00                	push   $0x0
  pushl $39
80106c04:	6a 27                	push   $0x27
  jmp alltraps
80106c06:	e9 50 f8 ff ff       	jmp    8010645b <alltraps>

80106c0b <vector40>:
.globl vector40
vector40:
  pushl $0
80106c0b:	6a 00                	push   $0x0
  pushl $40
80106c0d:	6a 28                	push   $0x28
  jmp alltraps
80106c0f:	e9 47 f8 ff ff       	jmp    8010645b <alltraps>

80106c14 <vector41>:
.globl vector41
vector41:
  pushl $0
80106c14:	6a 00                	push   $0x0
  pushl $41
80106c16:	6a 29                	push   $0x29
  jmp alltraps
80106c18:	e9 3e f8 ff ff       	jmp    8010645b <alltraps>

80106c1d <vector42>:
.globl vector42
vector42:
  pushl $0
80106c1d:	6a 00                	push   $0x0
  pushl $42
80106c1f:	6a 2a                	push   $0x2a
  jmp alltraps
80106c21:	e9 35 f8 ff ff       	jmp    8010645b <alltraps>

80106c26 <vector43>:
.globl vector43
vector43:
  pushl $0
80106c26:	6a 00                	push   $0x0
  pushl $43
80106c28:	6a 2b                	push   $0x2b
  jmp alltraps
80106c2a:	e9 2c f8 ff ff       	jmp    8010645b <alltraps>

80106c2f <vector44>:
.globl vector44
vector44:
  pushl $0
80106c2f:	6a 00                	push   $0x0
  pushl $44
80106c31:	6a 2c                	push   $0x2c
  jmp alltraps
80106c33:	e9 23 f8 ff ff       	jmp    8010645b <alltraps>

80106c38 <vector45>:
.globl vector45
vector45:
  pushl $0
80106c38:	6a 00                	push   $0x0
  pushl $45
80106c3a:	6a 2d                	push   $0x2d
  jmp alltraps
80106c3c:	e9 1a f8 ff ff       	jmp    8010645b <alltraps>

80106c41 <vector46>:
.globl vector46
vector46:
  pushl $0
80106c41:	6a 00                	push   $0x0
  pushl $46
80106c43:	6a 2e                	push   $0x2e
  jmp alltraps
80106c45:	e9 11 f8 ff ff       	jmp    8010645b <alltraps>

80106c4a <vector47>:
.globl vector47
vector47:
  pushl $0
80106c4a:	6a 00                	push   $0x0
  pushl $47
80106c4c:	6a 2f                	push   $0x2f
  jmp alltraps
80106c4e:	e9 08 f8 ff ff       	jmp    8010645b <alltraps>

80106c53 <vector48>:
.globl vector48
vector48:
  pushl $0
80106c53:	6a 00                	push   $0x0
  pushl $48
80106c55:	6a 30                	push   $0x30
  jmp alltraps
80106c57:	e9 ff f7 ff ff       	jmp    8010645b <alltraps>

80106c5c <vector49>:
.globl vector49
vector49:
  pushl $0
80106c5c:	6a 00                	push   $0x0
  pushl $49
80106c5e:	6a 31                	push   $0x31
  jmp alltraps
80106c60:	e9 f6 f7 ff ff       	jmp    8010645b <alltraps>

80106c65 <vector50>:
.globl vector50
vector50:
  pushl $0
80106c65:	6a 00                	push   $0x0
  pushl $50
80106c67:	6a 32                	push   $0x32
  jmp alltraps
80106c69:	e9 ed f7 ff ff       	jmp    8010645b <alltraps>

80106c6e <vector51>:
.globl vector51
vector51:
  pushl $0
80106c6e:	6a 00                	push   $0x0
  pushl $51
80106c70:	6a 33                	push   $0x33
  jmp alltraps
80106c72:	e9 e4 f7 ff ff       	jmp    8010645b <alltraps>

80106c77 <vector52>:
.globl vector52
vector52:
  pushl $0
80106c77:	6a 00                	push   $0x0
  pushl $52
80106c79:	6a 34                	push   $0x34
  jmp alltraps
80106c7b:	e9 db f7 ff ff       	jmp    8010645b <alltraps>

80106c80 <vector53>:
.globl vector53
vector53:
  pushl $0
80106c80:	6a 00                	push   $0x0
  pushl $53
80106c82:	6a 35                	push   $0x35
  jmp alltraps
80106c84:	e9 d2 f7 ff ff       	jmp    8010645b <alltraps>

80106c89 <vector54>:
.globl vector54
vector54:
  pushl $0
80106c89:	6a 00                	push   $0x0
  pushl $54
80106c8b:	6a 36                	push   $0x36
  jmp alltraps
80106c8d:	e9 c9 f7 ff ff       	jmp    8010645b <alltraps>

80106c92 <vector55>:
.globl vector55
vector55:
  pushl $0
80106c92:	6a 00                	push   $0x0
  pushl $55
80106c94:	6a 37                	push   $0x37
  jmp alltraps
80106c96:	e9 c0 f7 ff ff       	jmp    8010645b <alltraps>

80106c9b <vector56>:
.globl vector56
vector56:
  pushl $0
80106c9b:	6a 00                	push   $0x0
  pushl $56
80106c9d:	6a 38                	push   $0x38
  jmp alltraps
80106c9f:	e9 b7 f7 ff ff       	jmp    8010645b <alltraps>

80106ca4 <vector57>:
.globl vector57
vector57:
  pushl $0
80106ca4:	6a 00                	push   $0x0
  pushl $57
80106ca6:	6a 39                	push   $0x39
  jmp alltraps
80106ca8:	e9 ae f7 ff ff       	jmp    8010645b <alltraps>

80106cad <vector58>:
.globl vector58
vector58:
  pushl $0
80106cad:	6a 00                	push   $0x0
  pushl $58
80106caf:	6a 3a                	push   $0x3a
  jmp alltraps
80106cb1:	e9 a5 f7 ff ff       	jmp    8010645b <alltraps>

80106cb6 <vector59>:
.globl vector59
vector59:
  pushl $0
80106cb6:	6a 00                	push   $0x0
  pushl $59
80106cb8:	6a 3b                	push   $0x3b
  jmp alltraps
80106cba:	e9 9c f7 ff ff       	jmp    8010645b <alltraps>

80106cbf <vector60>:
.globl vector60
vector60:
  pushl $0
80106cbf:	6a 00                	push   $0x0
  pushl $60
80106cc1:	6a 3c                	push   $0x3c
  jmp alltraps
80106cc3:	e9 93 f7 ff ff       	jmp    8010645b <alltraps>

80106cc8 <vector61>:
.globl vector61
vector61:
  pushl $0
80106cc8:	6a 00                	push   $0x0
  pushl $61
80106cca:	6a 3d                	push   $0x3d
  jmp alltraps
80106ccc:	e9 8a f7 ff ff       	jmp    8010645b <alltraps>

80106cd1 <vector62>:
.globl vector62
vector62:
  pushl $0
80106cd1:	6a 00                	push   $0x0
  pushl $62
80106cd3:	6a 3e                	push   $0x3e
  jmp alltraps
80106cd5:	e9 81 f7 ff ff       	jmp    8010645b <alltraps>

80106cda <vector63>:
.globl vector63
vector63:
  pushl $0
80106cda:	6a 00                	push   $0x0
  pushl $63
80106cdc:	6a 3f                	push   $0x3f
  jmp alltraps
80106cde:	e9 78 f7 ff ff       	jmp    8010645b <alltraps>

80106ce3 <vector64>:
.globl vector64
vector64:
  pushl $0
80106ce3:	6a 00                	push   $0x0
  pushl $64
80106ce5:	6a 40                	push   $0x40
  jmp alltraps
80106ce7:	e9 6f f7 ff ff       	jmp    8010645b <alltraps>

80106cec <vector65>:
.globl vector65
vector65:
  pushl $0
80106cec:	6a 00                	push   $0x0
  pushl $65
80106cee:	6a 41                	push   $0x41
  jmp alltraps
80106cf0:	e9 66 f7 ff ff       	jmp    8010645b <alltraps>

80106cf5 <vector66>:
.globl vector66
vector66:
  pushl $0
80106cf5:	6a 00                	push   $0x0
  pushl $66
80106cf7:	6a 42                	push   $0x42
  jmp alltraps
80106cf9:	e9 5d f7 ff ff       	jmp    8010645b <alltraps>

80106cfe <vector67>:
.globl vector67
vector67:
  pushl $0
80106cfe:	6a 00                	push   $0x0
  pushl $67
80106d00:	6a 43                	push   $0x43
  jmp alltraps
80106d02:	e9 54 f7 ff ff       	jmp    8010645b <alltraps>

80106d07 <vector68>:
.globl vector68
vector68:
  pushl $0
80106d07:	6a 00                	push   $0x0
  pushl $68
80106d09:	6a 44                	push   $0x44
  jmp alltraps
80106d0b:	e9 4b f7 ff ff       	jmp    8010645b <alltraps>

80106d10 <vector69>:
.globl vector69
vector69:
  pushl $0
80106d10:	6a 00                	push   $0x0
  pushl $69
80106d12:	6a 45                	push   $0x45
  jmp alltraps
80106d14:	e9 42 f7 ff ff       	jmp    8010645b <alltraps>

80106d19 <vector70>:
.globl vector70
vector70:
  pushl $0
80106d19:	6a 00                	push   $0x0
  pushl $70
80106d1b:	6a 46                	push   $0x46
  jmp alltraps
80106d1d:	e9 39 f7 ff ff       	jmp    8010645b <alltraps>

80106d22 <vector71>:
.globl vector71
vector71:
  pushl $0
80106d22:	6a 00                	push   $0x0
  pushl $71
80106d24:	6a 47                	push   $0x47
  jmp alltraps
80106d26:	e9 30 f7 ff ff       	jmp    8010645b <alltraps>

80106d2b <vector72>:
.globl vector72
vector72:
  pushl $0
80106d2b:	6a 00                	push   $0x0
  pushl $72
80106d2d:	6a 48                	push   $0x48
  jmp alltraps
80106d2f:	e9 27 f7 ff ff       	jmp    8010645b <alltraps>

80106d34 <vector73>:
.globl vector73
vector73:
  pushl $0
80106d34:	6a 00                	push   $0x0
  pushl $73
80106d36:	6a 49                	push   $0x49
  jmp alltraps
80106d38:	e9 1e f7 ff ff       	jmp    8010645b <alltraps>

80106d3d <vector74>:
.globl vector74
vector74:
  pushl $0
80106d3d:	6a 00                	push   $0x0
  pushl $74
80106d3f:	6a 4a                	push   $0x4a
  jmp alltraps
80106d41:	e9 15 f7 ff ff       	jmp    8010645b <alltraps>

80106d46 <vector75>:
.globl vector75
vector75:
  pushl $0
80106d46:	6a 00                	push   $0x0
  pushl $75
80106d48:	6a 4b                	push   $0x4b
  jmp alltraps
80106d4a:	e9 0c f7 ff ff       	jmp    8010645b <alltraps>

80106d4f <vector76>:
.globl vector76
vector76:
  pushl $0
80106d4f:	6a 00                	push   $0x0
  pushl $76
80106d51:	6a 4c                	push   $0x4c
  jmp alltraps
80106d53:	e9 03 f7 ff ff       	jmp    8010645b <alltraps>

80106d58 <vector77>:
.globl vector77
vector77:
  pushl $0
80106d58:	6a 00                	push   $0x0
  pushl $77
80106d5a:	6a 4d                	push   $0x4d
  jmp alltraps
80106d5c:	e9 fa f6 ff ff       	jmp    8010645b <alltraps>

80106d61 <vector78>:
.globl vector78
vector78:
  pushl $0
80106d61:	6a 00                	push   $0x0
  pushl $78
80106d63:	6a 4e                	push   $0x4e
  jmp alltraps
80106d65:	e9 f1 f6 ff ff       	jmp    8010645b <alltraps>

80106d6a <vector79>:
.globl vector79
vector79:
  pushl $0
80106d6a:	6a 00                	push   $0x0
  pushl $79
80106d6c:	6a 4f                	push   $0x4f
  jmp alltraps
80106d6e:	e9 e8 f6 ff ff       	jmp    8010645b <alltraps>

80106d73 <vector80>:
.globl vector80
vector80:
  pushl $0
80106d73:	6a 00                	push   $0x0
  pushl $80
80106d75:	6a 50                	push   $0x50
  jmp alltraps
80106d77:	e9 df f6 ff ff       	jmp    8010645b <alltraps>

80106d7c <vector81>:
.globl vector81
vector81:
  pushl $0
80106d7c:	6a 00                	push   $0x0
  pushl $81
80106d7e:	6a 51                	push   $0x51
  jmp alltraps
80106d80:	e9 d6 f6 ff ff       	jmp    8010645b <alltraps>

80106d85 <vector82>:
.globl vector82
vector82:
  pushl $0
80106d85:	6a 00                	push   $0x0
  pushl $82
80106d87:	6a 52                	push   $0x52
  jmp alltraps
80106d89:	e9 cd f6 ff ff       	jmp    8010645b <alltraps>

80106d8e <vector83>:
.globl vector83
vector83:
  pushl $0
80106d8e:	6a 00                	push   $0x0
  pushl $83
80106d90:	6a 53                	push   $0x53
  jmp alltraps
80106d92:	e9 c4 f6 ff ff       	jmp    8010645b <alltraps>

80106d97 <vector84>:
.globl vector84
vector84:
  pushl $0
80106d97:	6a 00                	push   $0x0
  pushl $84
80106d99:	6a 54                	push   $0x54
  jmp alltraps
80106d9b:	e9 bb f6 ff ff       	jmp    8010645b <alltraps>

80106da0 <vector85>:
.globl vector85
vector85:
  pushl $0
80106da0:	6a 00                	push   $0x0
  pushl $85
80106da2:	6a 55                	push   $0x55
  jmp alltraps
80106da4:	e9 b2 f6 ff ff       	jmp    8010645b <alltraps>

80106da9 <vector86>:
.globl vector86
vector86:
  pushl $0
80106da9:	6a 00                	push   $0x0
  pushl $86
80106dab:	6a 56                	push   $0x56
  jmp alltraps
80106dad:	e9 a9 f6 ff ff       	jmp    8010645b <alltraps>

80106db2 <vector87>:
.globl vector87
vector87:
  pushl $0
80106db2:	6a 00                	push   $0x0
  pushl $87
80106db4:	6a 57                	push   $0x57
  jmp alltraps
80106db6:	e9 a0 f6 ff ff       	jmp    8010645b <alltraps>

80106dbb <vector88>:
.globl vector88
vector88:
  pushl $0
80106dbb:	6a 00                	push   $0x0
  pushl $88
80106dbd:	6a 58                	push   $0x58
  jmp alltraps
80106dbf:	e9 97 f6 ff ff       	jmp    8010645b <alltraps>

80106dc4 <vector89>:
.globl vector89
vector89:
  pushl $0
80106dc4:	6a 00                	push   $0x0
  pushl $89
80106dc6:	6a 59                	push   $0x59
  jmp alltraps
80106dc8:	e9 8e f6 ff ff       	jmp    8010645b <alltraps>

80106dcd <vector90>:
.globl vector90
vector90:
  pushl $0
80106dcd:	6a 00                	push   $0x0
  pushl $90
80106dcf:	6a 5a                	push   $0x5a
  jmp alltraps
80106dd1:	e9 85 f6 ff ff       	jmp    8010645b <alltraps>

80106dd6 <vector91>:
.globl vector91
vector91:
  pushl $0
80106dd6:	6a 00                	push   $0x0
  pushl $91
80106dd8:	6a 5b                	push   $0x5b
  jmp alltraps
80106dda:	e9 7c f6 ff ff       	jmp    8010645b <alltraps>

80106ddf <vector92>:
.globl vector92
vector92:
  pushl $0
80106ddf:	6a 00                	push   $0x0
  pushl $92
80106de1:	6a 5c                	push   $0x5c
  jmp alltraps
80106de3:	e9 73 f6 ff ff       	jmp    8010645b <alltraps>

80106de8 <vector93>:
.globl vector93
vector93:
  pushl $0
80106de8:	6a 00                	push   $0x0
  pushl $93
80106dea:	6a 5d                	push   $0x5d
  jmp alltraps
80106dec:	e9 6a f6 ff ff       	jmp    8010645b <alltraps>

80106df1 <vector94>:
.globl vector94
vector94:
  pushl $0
80106df1:	6a 00                	push   $0x0
  pushl $94
80106df3:	6a 5e                	push   $0x5e
  jmp alltraps
80106df5:	e9 61 f6 ff ff       	jmp    8010645b <alltraps>

80106dfa <vector95>:
.globl vector95
vector95:
  pushl $0
80106dfa:	6a 00                	push   $0x0
  pushl $95
80106dfc:	6a 5f                	push   $0x5f
  jmp alltraps
80106dfe:	e9 58 f6 ff ff       	jmp    8010645b <alltraps>

80106e03 <vector96>:
.globl vector96
vector96:
  pushl $0
80106e03:	6a 00                	push   $0x0
  pushl $96
80106e05:	6a 60                	push   $0x60
  jmp alltraps
80106e07:	e9 4f f6 ff ff       	jmp    8010645b <alltraps>

80106e0c <vector97>:
.globl vector97
vector97:
  pushl $0
80106e0c:	6a 00                	push   $0x0
  pushl $97
80106e0e:	6a 61                	push   $0x61
  jmp alltraps
80106e10:	e9 46 f6 ff ff       	jmp    8010645b <alltraps>

80106e15 <vector98>:
.globl vector98
vector98:
  pushl $0
80106e15:	6a 00                	push   $0x0
  pushl $98
80106e17:	6a 62                	push   $0x62
  jmp alltraps
80106e19:	e9 3d f6 ff ff       	jmp    8010645b <alltraps>

80106e1e <vector99>:
.globl vector99
vector99:
  pushl $0
80106e1e:	6a 00                	push   $0x0
  pushl $99
80106e20:	6a 63                	push   $0x63
  jmp alltraps
80106e22:	e9 34 f6 ff ff       	jmp    8010645b <alltraps>

80106e27 <vector100>:
.globl vector100
vector100:
  pushl $0
80106e27:	6a 00                	push   $0x0
  pushl $100
80106e29:	6a 64                	push   $0x64
  jmp alltraps
80106e2b:	e9 2b f6 ff ff       	jmp    8010645b <alltraps>

80106e30 <vector101>:
.globl vector101
vector101:
  pushl $0
80106e30:	6a 00                	push   $0x0
  pushl $101
80106e32:	6a 65                	push   $0x65
  jmp alltraps
80106e34:	e9 22 f6 ff ff       	jmp    8010645b <alltraps>

80106e39 <vector102>:
.globl vector102
vector102:
  pushl $0
80106e39:	6a 00                	push   $0x0
  pushl $102
80106e3b:	6a 66                	push   $0x66
  jmp alltraps
80106e3d:	e9 19 f6 ff ff       	jmp    8010645b <alltraps>

80106e42 <vector103>:
.globl vector103
vector103:
  pushl $0
80106e42:	6a 00                	push   $0x0
  pushl $103
80106e44:	6a 67                	push   $0x67
  jmp alltraps
80106e46:	e9 10 f6 ff ff       	jmp    8010645b <alltraps>

80106e4b <vector104>:
.globl vector104
vector104:
  pushl $0
80106e4b:	6a 00                	push   $0x0
  pushl $104
80106e4d:	6a 68                	push   $0x68
  jmp alltraps
80106e4f:	e9 07 f6 ff ff       	jmp    8010645b <alltraps>

80106e54 <vector105>:
.globl vector105
vector105:
  pushl $0
80106e54:	6a 00                	push   $0x0
  pushl $105
80106e56:	6a 69                	push   $0x69
  jmp alltraps
80106e58:	e9 fe f5 ff ff       	jmp    8010645b <alltraps>

80106e5d <vector106>:
.globl vector106
vector106:
  pushl $0
80106e5d:	6a 00                	push   $0x0
  pushl $106
80106e5f:	6a 6a                	push   $0x6a
  jmp alltraps
80106e61:	e9 f5 f5 ff ff       	jmp    8010645b <alltraps>

80106e66 <vector107>:
.globl vector107
vector107:
  pushl $0
80106e66:	6a 00                	push   $0x0
  pushl $107
80106e68:	6a 6b                	push   $0x6b
  jmp alltraps
80106e6a:	e9 ec f5 ff ff       	jmp    8010645b <alltraps>

80106e6f <vector108>:
.globl vector108
vector108:
  pushl $0
80106e6f:	6a 00                	push   $0x0
  pushl $108
80106e71:	6a 6c                	push   $0x6c
  jmp alltraps
80106e73:	e9 e3 f5 ff ff       	jmp    8010645b <alltraps>

80106e78 <vector109>:
.globl vector109
vector109:
  pushl $0
80106e78:	6a 00                	push   $0x0
  pushl $109
80106e7a:	6a 6d                	push   $0x6d
  jmp alltraps
80106e7c:	e9 da f5 ff ff       	jmp    8010645b <alltraps>

80106e81 <vector110>:
.globl vector110
vector110:
  pushl $0
80106e81:	6a 00                	push   $0x0
  pushl $110
80106e83:	6a 6e                	push   $0x6e
  jmp alltraps
80106e85:	e9 d1 f5 ff ff       	jmp    8010645b <alltraps>

80106e8a <vector111>:
.globl vector111
vector111:
  pushl $0
80106e8a:	6a 00                	push   $0x0
  pushl $111
80106e8c:	6a 6f                	push   $0x6f
  jmp alltraps
80106e8e:	e9 c8 f5 ff ff       	jmp    8010645b <alltraps>

80106e93 <vector112>:
.globl vector112
vector112:
  pushl $0
80106e93:	6a 00                	push   $0x0
  pushl $112
80106e95:	6a 70                	push   $0x70
  jmp alltraps
80106e97:	e9 bf f5 ff ff       	jmp    8010645b <alltraps>

80106e9c <vector113>:
.globl vector113
vector113:
  pushl $0
80106e9c:	6a 00                	push   $0x0
  pushl $113
80106e9e:	6a 71                	push   $0x71
  jmp alltraps
80106ea0:	e9 b6 f5 ff ff       	jmp    8010645b <alltraps>

80106ea5 <vector114>:
.globl vector114
vector114:
  pushl $0
80106ea5:	6a 00                	push   $0x0
  pushl $114
80106ea7:	6a 72                	push   $0x72
  jmp alltraps
80106ea9:	e9 ad f5 ff ff       	jmp    8010645b <alltraps>

80106eae <vector115>:
.globl vector115
vector115:
  pushl $0
80106eae:	6a 00                	push   $0x0
  pushl $115
80106eb0:	6a 73                	push   $0x73
  jmp alltraps
80106eb2:	e9 a4 f5 ff ff       	jmp    8010645b <alltraps>

80106eb7 <vector116>:
.globl vector116
vector116:
  pushl $0
80106eb7:	6a 00                	push   $0x0
  pushl $116
80106eb9:	6a 74                	push   $0x74
  jmp alltraps
80106ebb:	e9 9b f5 ff ff       	jmp    8010645b <alltraps>

80106ec0 <vector117>:
.globl vector117
vector117:
  pushl $0
80106ec0:	6a 00                	push   $0x0
  pushl $117
80106ec2:	6a 75                	push   $0x75
  jmp alltraps
80106ec4:	e9 92 f5 ff ff       	jmp    8010645b <alltraps>

80106ec9 <vector118>:
.globl vector118
vector118:
  pushl $0
80106ec9:	6a 00                	push   $0x0
  pushl $118
80106ecb:	6a 76                	push   $0x76
  jmp alltraps
80106ecd:	e9 89 f5 ff ff       	jmp    8010645b <alltraps>

80106ed2 <vector119>:
.globl vector119
vector119:
  pushl $0
80106ed2:	6a 00                	push   $0x0
  pushl $119
80106ed4:	6a 77                	push   $0x77
  jmp alltraps
80106ed6:	e9 80 f5 ff ff       	jmp    8010645b <alltraps>

80106edb <vector120>:
.globl vector120
vector120:
  pushl $0
80106edb:	6a 00                	push   $0x0
  pushl $120
80106edd:	6a 78                	push   $0x78
  jmp alltraps
80106edf:	e9 77 f5 ff ff       	jmp    8010645b <alltraps>

80106ee4 <vector121>:
.globl vector121
vector121:
  pushl $0
80106ee4:	6a 00                	push   $0x0
  pushl $121
80106ee6:	6a 79                	push   $0x79
  jmp alltraps
80106ee8:	e9 6e f5 ff ff       	jmp    8010645b <alltraps>

80106eed <vector122>:
.globl vector122
vector122:
  pushl $0
80106eed:	6a 00                	push   $0x0
  pushl $122
80106eef:	6a 7a                	push   $0x7a
  jmp alltraps
80106ef1:	e9 65 f5 ff ff       	jmp    8010645b <alltraps>

80106ef6 <vector123>:
.globl vector123
vector123:
  pushl $0
80106ef6:	6a 00                	push   $0x0
  pushl $123
80106ef8:	6a 7b                	push   $0x7b
  jmp alltraps
80106efa:	e9 5c f5 ff ff       	jmp    8010645b <alltraps>

80106eff <vector124>:
.globl vector124
vector124:
  pushl $0
80106eff:	6a 00                	push   $0x0
  pushl $124
80106f01:	6a 7c                	push   $0x7c
  jmp alltraps
80106f03:	e9 53 f5 ff ff       	jmp    8010645b <alltraps>

80106f08 <vector125>:
.globl vector125
vector125:
  pushl $0
80106f08:	6a 00                	push   $0x0
  pushl $125
80106f0a:	6a 7d                	push   $0x7d
  jmp alltraps
80106f0c:	e9 4a f5 ff ff       	jmp    8010645b <alltraps>

80106f11 <vector126>:
.globl vector126
vector126:
  pushl $0
80106f11:	6a 00                	push   $0x0
  pushl $126
80106f13:	6a 7e                	push   $0x7e
  jmp alltraps
80106f15:	e9 41 f5 ff ff       	jmp    8010645b <alltraps>

80106f1a <vector127>:
.globl vector127
vector127:
  pushl $0
80106f1a:	6a 00                	push   $0x0
  pushl $127
80106f1c:	6a 7f                	push   $0x7f
  jmp alltraps
80106f1e:	e9 38 f5 ff ff       	jmp    8010645b <alltraps>

80106f23 <vector128>:
.globl vector128
vector128:
  pushl $0
80106f23:	6a 00                	push   $0x0
  pushl $128
80106f25:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106f2a:	e9 2c f5 ff ff       	jmp    8010645b <alltraps>

80106f2f <vector129>:
.globl vector129
vector129:
  pushl $0
80106f2f:	6a 00                	push   $0x0
  pushl $129
80106f31:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106f36:	e9 20 f5 ff ff       	jmp    8010645b <alltraps>

80106f3b <vector130>:
.globl vector130
vector130:
  pushl $0
80106f3b:	6a 00                	push   $0x0
  pushl $130
80106f3d:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106f42:	e9 14 f5 ff ff       	jmp    8010645b <alltraps>

80106f47 <vector131>:
.globl vector131
vector131:
  pushl $0
80106f47:	6a 00                	push   $0x0
  pushl $131
80106f49:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106f4e:	e9 08 f5 ff ff       	jmp    8010645b <alltraps>

80106f53 <vector132>:
.globl vector132
vector132:
  pushl $0
80106f53:	6a 00                	push   $0x0
  pushl $132
80106f55:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106f5a:	e9 fc f4 ff ff       	jmp    8010645b <alltraps>

80106f5f <vector133>:
.globl vector133
vector133:
  pushl $0
80106f5f:	6a 00                	push   $0x0
  pushl $133
80106f61:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106f66:	e9 f0 f4 ff ff       	jmp    8010645b <alltraps>

80106f6b <vector134>:
.globl vector134
vector134:
  pushl $0
80106f6b:	6a 00                	push   $0x0
  pushl $134
80106f6d:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106f72:	e9 e4 f4 ff ff       	jmp    8010645b <alltraps>

80106f77 <vector135>:
.globl vector135
vector135:
  pushl $0
80106f77:	6a 00                	push   $0x0
  pushl $135
80106f79:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106f7e:	e9 d8 f4 ff ff       	jmp    8010645b <alltraps>

80106f83 <vector136>:
.globl vector136
vector136:
  pushl $0
80106f83:	6a 00                	push   $0x0
  pushl $136
80106f85:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106f8a:	e9 cc f4 ff ff       	jmp    8010645b <alltraps>

80106f8f <vector137>:
.globl vector137
vector137:
  pushl $0
80106f8f:	6a 00                	push   $0x0
  pushl $137
80106f91:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106f96:	e9 c0 f4 ff ff       	jmp    8010645b <alltraps>

80106f9b <vector138>:
.globl vector138
vector138:
  pushl $0
80106f9b:	6a 00                	push   $0x0
  pushl $138
80106f9d:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106fa2:	e9 b4 f4 ff ff       	jmp    8010645b <alltraps>

80106fa7 <vector139>:
.globl vector139
vector139:
  pushl $0
80106fa7:	6a 00                	push   $0x0
  pushl $139
80106fa9:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106fae:	e9 a8 f4 ff ff       	jmp    8010645b <alltraps>

80106fb3 <vector140>:
.globl vector140
vector140:
  pushl $0
80106fb3:	6a 00                	push   $0x0
  pushl $140
80106fb5:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106fba:	e9 9c f4 ff ff       	jmp    8010645b <alltraps>

80106fbf <vector141>:
.globl vector141
vector141:
  pushl $0
80106fbf:	6a 00                	push   $0x0
  pushl $141
80106fc1:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106fc6:	e9 90 f4 ff ff       	jmp    8010645b <alltraps>

80106fcb <vector142>:
.globl vector142
vector142:
  pushl $0
80106fcb:	6a 00                	push   $0x0
  pushl $142
80106fcd:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106fd2:	e9 84 f4 ff ff       	jmp    8010645b <alltraps>

80106fd7 <vector143>:
.globl vector143
vector143:
  pushl $0
80106fd7:	6a 00                	push   $0x0
  pushl $143
80106fd9:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106fde:	e9 78 f4 ff ff       	jmp    8010645b <alltraps>

80106fe3 <vector144>:
.globl vector144
vector144:
  pushl $0
80106fe3:	6a 00                	push   $0x0
  pushl $144
80106fe5:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106fea:	e9 6c f4 ff ff       	jmp    8010645b <alltraps>

80106fef <vector145>:
.globl vector145
vector145:
  pushl $0
80106fef:	6a 00                	push   $0x0
  pushl $145
80106ff1:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106ff6:	e9 60 f4 ff ff       	jmp    8010645b <alltraps>

80106ffb <vector146>:
.globl vector146
vector146:
  pushl $0
80106ffb:	6a 00                	push   $0x0
  pushl $146
80106ffd:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107002:	e9 54 f4 ff ff       	jmp    8010645b <alltraps>

80107007 <vector147>:
.globl vector147
vector147:
  pushl $0
80107007:	6a 00                	push   $0x0
  pushl $147
80107009:	68 93 00 00 00       	push   $0x93
  jmp alltraps
8010700e:	e9 48 f4 ff ff       	jmp    8010645b <alltraps>

80107013 <vector148>:
.globl vector148
vector148:
  pushl $0
80107013:	6a 00                	push   $0x0
  pushl $148
80107015:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010701a:	e9 3c f4 ff ff       	jmp    8010645b <alltraps>

8010701f <vector149>:
.globl vector149
vector149:
  pushl $0
8010701f:	6a 00                	push   $0x0
  pushl $149
80107021:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107026:	e9 30 f4 ff ff       	jmp    8010645b <alltraps>

8010702b <vector150>:
.globl vector150
vector150:
  pushl $0
8010702b:	6a 00                	push   $0x0
  pushl $150
8010702d:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107032:	e9 24 f4 ff ff       	jmp    8010645b <alltraps>

80107037 <vector151>:
.globl vector151
vector151:
  pushl $0
80107037:	6a 00                	push   $0x0
  pushl $151
80107039:	68 97 00 00 00       	push   $0x97
  jmp alltraps
8010703e:	e9 18 f4 ff ff       	jmp    8010645b <alltraps>

80107043 <vector152>:
.globl vector152
vector152:
  pushl $0
80107043:	6a 00                	push   $0x0
  pushl $152
80107045:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010704a:	e9 0c f4 ff ff       	jmp    8010645b <alltraps>

8010704f <vector153>:
.globl vector153
vector153:
  pushl $0
8010704f:	6a 00                	push   $0x0
  pushl $153
80107051:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80107056:	e9 00 f4 ff ff       	jmp    8010645b <alltraps>

8010705b <vector154>:
.globl vector154
vector154:
  pushl $0
8010705b:	6a 00                	push   $0x0
  pushl $154
8010705d:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107062:	e9 f4 f3 ff ff       	jmp    8010645b <alltraps>

80107067 <vector155>:
.globl vector155
vector155:
  pushl $0
80107067:	6a 00                	push   $0x0
  pushl $155
80107069:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
8010706e:	e9 e8 f3 ff ff       	jmp    8010645b <alltraps>

80107073 <vector156>:
.globl vector156
vector156:
  pushl $0
80107073:	6a 00                	push   $0x0
  pushl $156
80107075:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010707a:	e9 dc f3 ff ff       	jmp    8010645b <alltraps>

8010707f <vector157>:
.globl vector157
vector157:
  pushl $0
8010707f:	6a 00                	push   $0x0
  pushl $157
80107081:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107086:	e9 d0 f3 ff ff       	jmp    8010645b <alltraps>

8010708b <vector158>:
.globl vector158
vector158:
  pushl $0
8010708b:	6a 00                	push   $0x0
  pushl $158
8010708d:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107092:	e9 c4 f3 ff ff       	jmp    8010645b <alltraps>

80107097 <vector159>:
.globl vector159
vector159:
  pushl $0
80107097:	6a 00                	push   $0x0
  pushl $159
80107099:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
8010709e:	e9 b8 f3 ff ff       	jmp    8010645b <alltraps>

801070a3 <vector160>:
.globl vector160
vector160:
  pushl $0
801070a3:	6a 00                	push   $0x0
  pushl $160
801070a5:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801070aa:	e9 ac f3 ff ff       	jmp    8010645b <alltraps>

801070af <vector161>:
.globl vector161
vector161:
  pushl $0
801070af:	6a 00                	push   $0x0
  pushl $161
801070b1:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801070b6:	e9 a0 f3 ff ff       	jmp    8010645b <alltraps>

801070bb <vector162>:
.globl vector162
vector162:
  pushl $0
801070bb:	6a 00                	push   $0x0
  pushl $162
801070bd:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801070c2:	e9 94 f3 ff ff       	jmp    8010645b <alltraps>

801070c7 <vector163>:
.globl vector163
vector163:
  pushl $0
801070c7:	6a 00                	push   $0x0
  pushl $163
801070c9:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801070ce:	e9 88 f3 ff ff       	jmp    8010645b <alltraps>

801070d3 <vector164>:
.globl vector164
vector164:
  pushl $0
801070d3:	6a 00                	push   $0x0
  pushl $164
801070d5:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801070da:	e9 7c f3 ff ff       	jmp    8010645b <alltraps>

801070df <vector165>:
.globl vector165
vector165:
  pushl $0
801070df:	6a 00                	push   $0x0
  pushl $165
801070e1:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801070e6:	e9 70 f3 ff ff       	jmp    8010645b <alltraps>

801070eb <vector166>:
.globl vector166
vector166:
  pushl $0
801070eb:	6a 00                	push   $0x0
  pushl $166
801070ed:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801070f2:	e9 64 f3 ff ff       	jmp    8010645b <alltraps>

801070f7 <vector167>:
.globl vector167
vector167:
  pushl $0
801070f7:	6a 00                	push   $0x0
  pushl $167
801070f9:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801070fe:	e9 58 f3 ff ff       	jmp    8010645b <alltraps>

80107103 <vector168>:
.globl vector168
vector168:
  pushl $0
80107103:	6a 00                	push   $0x0
  pushl $168
80107105:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010710a:	e9 4c f3 ff ff       	jmp    8010645b <alltraps>

8010710f <vector169>:
.globl vector169
vector169:
  pushl $0
8010710f:	6a 00                	push   $0x0
  pushl $169
80107111:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107116:	e9 40 f3 ff ff       	jmp    8010645b <alltraps>

8010711b <vector170>:
.globl vector170
vector170:
  pushl $0
8010711b:	6a 00                	push   $0x0
  pushl $170
8010711d:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107122:	e9 34 f3 ff ff       	jmp    8010645b <alltraps>

80107127 <vector171>:
.globl vector171
vector171:
  pushl $0
80107127:	6a 00                	push   $0x0
  pushl $171
80107129:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
8010712e:	e9 28 f3 ff ff       	jmp    8010645b <alltraps>

80107133 <vector172>:
.globl vector172
vector172:
  pushl $0
80107133:	6a 00                	push   $0x0
  pushl $172
80107135:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010713a:	e9 1c f3 ff ff       	jmp    8010645b <alltraps>

8010713f <vector173>:
.globl vector173
vector173:
  pushl $0
8010713f:	6a 00                	push   $0x0
  pushl $173
80107141:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107146:	e9 10 f3 ff ff       	jmp    8010645b <alltraps>

8010714b <vector174>:
.globl vector174
vector174:
  pushl $0
8010714b:	6a 00                	push   $0x0
  pushl $174
8010714d:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107152:	e9 04 f3 ff ff       	jmp    8010645b <alltraps>

80107157 <vector175>:
.globl vector175
vector175:
  pushl $0
80107157:	6a 00                	push   $0x0
  pushl $175
80107159:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
8010715e:	e9 f8 f2 ff ff       	jmp    8010645b <alltraps>

80107163 <vector176>:
.globl vector176
vector176:
  pushl $0
80107163:	6a 00                	push   $0x0
  pushl $176
80107165:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010716a:	e9 ec f2 ff ff       	jmp    8010645b <alltraps>

8010716f <vector177>:
.globl vector177
vector177:
  pushl $0
8010716f:	6a 00                	push   $0x0
  pushl $177
80107171:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107176:	e9 e0 f2 ff ff       	jmp    8010645b <alltraps>

8010717b <vector178>:
.globl vector178
vector178:
  pushl $0
8010717b:	6a 00                	push   $0x0
  pushl $178
8010717d:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107182:	e9 d4 f2 ff ff       	jmp    8010645b <alltraps>

80107187 <vector179>:
.globl vector179
vector179:
  pushl $0
80107187:	6a 00                	push   $0x0
  pushl $179
80107189:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
8010718e:	e9 c8 f2 ff ff       	jmp    8010645b <alltraps>

80107193 <vector180>:
.globl vector180
vector180:
  pushl $0
80107193:	6a 00                	push   $0x0
  pushl $180
80107195:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010719a:	e9 bc f2 ff ff       	jmp    8010645b <alltraps>

8010719f <vector181>:
.globl vector181
vector181:
  pushl $0
8010719f:	6a 00                	push   $0x0
  pushl $181
801071a1:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801071a6:	e9 b0 f2 ff ff       	jmp    8010645b <alltraps>

801071ab <vector182>:
.globl vector182
vector182:
  pushl $0
801071ab:	6a 00                	push   $0x0
  pushl $182
801071ad:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801071b2:	e9 a4 f2 ff ff       	jmp    8010645b <alltraps>

801071b7 <vector183>:
.globl vector183
vector183:
  pushl $0
801071b7:	6a 00                	push   $0x0
  pushl $183
801071b9:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801071be:	e9 98 f2 ff ff       	jmp    8010645b <alltraps>

801071c3 <vector184>:
.globl vector184
vector184:
  pushl $0
801071c3:	6a 00                	push   $0x0
  pushl $184
801071c5:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801071ca:	e9 8c f2 ff ff       	jmp    8010645b <alltraps>

801071cf <vector185>:
.globl vector185
vector185:
  pushl $0
801071cf:	6a 00                	push   $0x0
  pushl $185
801071d1:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801071d6:	e9 80 f2 ff ff       	jmp    8010645b <alltraps>

801071db <vector186>:
.globl vector186
vector186:
  pushl $0
801071db:	6a 00                	push   $0x0
  pushl $186
801071dd:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801071e2:	e9 74 f2 ff ff       	jmp    8010645b <alltraps>

801071e7 <vector187>:
.globl vector187
vector187:
  pushl $0
801071e7:	6a 00                	push   $0x0
  pushl $187
801071e9:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801071ee:	e9 68 f2 ff ff       	jmp    8010645b <alltraps>

801071f3 <vector188>:
.globl vector188
vector188:
  pushl $0
801071f3:	6a 00                	push   $0x0
  pushl $188
801071f5:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801071fa:	e9 5c f2 ff ff       	jmp    8010645b <alltraps>

801071ff <vector189>:
.globl vector189
vector189:
  pushl $0
801071ff:	6a 00                	push   $0x0
  pushl $189
80107201:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107206:	e9 50 f2 ff ff       	jmp    8010645b <alltraps>

8010720b <vector190>:
.globl vector190
vector190:
  pushl $0
8010720b:	6a 00                	push   $0x0
  pushl $190
8010720d:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107212:	e9 44 f2 ff ff       	jmp    8010645b <alltraps>

80107217 <vector191>:
.globl vector191
vector191:
  pushl $0
80107217:	6a 00                	push   $0x0
  pushl $191
80107219:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
8010721e:	e9 38 f2 ff ff       	jmp    8010645b <alltraps>

80107223 <vector192>:
.globl vector192
vector192:
  pushl $0
80107223:	6a 00                	push   $0x0
  pushl $192
80107225:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010722a:	e9 2c f2 ff ff       	jmp    8010645b <alltraps>

8010722f <vector193>:
.globl vector193
vector193:
  pushl $0
8010722f:	6a 00                	push   $0x0
  pushl $193
80107231:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107236:	e9 20 f2 ff ff       	jmp    8010645b <alltraps>

8010723b <vector194>:
.globl vector194
vector194:
  pushl $0
8010723b:	6a 00                	push   $0x0
  pushl $194
8010723d:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107242:	e9 14 f2 ff ff       	jmp    8010645b <alltraps>

80107247 <vector195>:
.globl vector195
vector195:
  pushl $0
80107247:	6a 00                	push   $0x0
  pushl $195
80107249:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
8010724e:	e9 08 f2 ff ff       	jmp    8010645b <alltraps>

80107253 <vector196>:
.globl vector196
vector196:
  pushl $0
80107253:	6a 00                	push   $0x0
  pushl $196
80107255:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010725a:	e9 fc f1 ff ff       	jmp    8010645b <alltraps>

8010725f <vector197>:
.globl vector197
vector197:
  pushl $0
8010725f:	6a 00                	push   $0x0
  pushl $197
80107261:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107266:	e9 f0 f1 ff ff       	jmp    8010645b <alltraps>

8010726b <vector198>:
.globl vector198
vector198:
  pushl $0
8010726b:	6a 00                	push   $0x0
  pushl $198
8010726d:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107272:	e9 e4 f1 ff ff       	jmp    8010645b <alltraps>

80107277 <vector199>:
.globl vector199
vector199:
  pushl $0
80107277:	6a 00                	push   $0x0
  pushl $199
80107279:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
8010727e:	e9 d8 f1 ff ff       	jmp    8010645b <alltraps>

80107283 <vector200>:
.globl vector200
vector200:
  pushl $0
80107283:	6a 00                	push   $0x0
  pushl $200
80107285:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010728a:	e9 cc f1 ff ff       	jmp    8010645b <alltraps>

8010728f <vector201>:
.globl vector201
vector201:
  pushl $0
8010728f:	6a 00                	push   $0x0
  pushl $201
80107291:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107296:	e9 c0 f1 ff ff       	jmp    8010645b <alltraps>

8010729b <vector202>:
.globl vector202
vector202:
  pushl $0
8010729b:	6a 00                	push   $0x0
  pushl $202
8010729d:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801072a2:	e9 b4 f1 ff ff       	jmp    8010645b <alltraps>

801072a7 <vector203>:
.globl vector203
vector203:
  pushl $0
801072a7:	6a 00                	push   $0x0
  pushl $203
801072a9:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801072ae:	e9 a8 f1 ff ff       	jmp    8010645b <alltraps>

801072b3 <vector204>:
.globl vector204
vector204:
  pushl $0
801072b3:	6a 00                	push   $0x0
  pushl $204
801072b5:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801072ba:	e9 9c f1 ff ff       	jmp    8010645b <alltraps>

801072bf <vector205>:
.globl vector205
vector205:
  pushl $0
801072bf:	6a 00                	push   $0x0
  pushl $205
801072c1:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801072c6:	e9 90 f1 ff ff       	jmp    8010645b <alltraps>

801072cb <vector206>:
.globl vector206
vector206:
  pushl $0
801072cb:	6a 00                	push   $0x0
  pushl $206
801072cd:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801072d2:	e9 84 f1 ff ff       	jmp    8010645b <alltraps>

801072d7 <vector207>:
.globl vector207
vector207:
  pushl $0
801072d7:	6a 00                	push   $0x0
  pushl $207
801072d9:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801072de:	e9 78 f1 ff ff       	jmp    8010645b <alltraps>

801072e3 <vector208>:
.globl vector208
vector208:
  pushl $0
801072e3:	6a 00                	push   $0x0
  pushl $208
801072e5:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801072ea:	e9 6c f1 ff ff       	jmp    8010645b <alltraps>

801072ef <vector209>:
.globl vector209
vector209:
  pushl $0
801072ef:	6a 00                	push   $0x0
  pushl $209
801072f1:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801072f6:	e9 60 f1 ff ff       	jmp    8010645b <alltraps>

801072fb <vector210>:
.globl vector210
vector210:
  pushl $0
801072fb:	6a 00                	push   $0x0
  pushl $210
801072fd:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107302:	e9 54 f1 ff ff       	jmp    8010645b <alltraps>

80107307 <vector211>:
.globl vector211
vector211:
  pushl $0
80107307:	6a 00                	push   $0x0
  pushl $211
80107309:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
8010730e:	e9 48 f1 ff ff       	jmp    8010645b <alltraps>

80107313 <vector212>:
.globl vector212
vector212:
  pushl $0
80107313:	6a 00                	push   $0x0
  pushl $212
80107315:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010731a:	e9 3c f1 ff ff       	jmp    8010645b <alltraps>

8010731f <vector213>:
.globl vector213
vector213:
  pushl $0
8010731f:	6a 00                	push   $0x0
  pushl $213
80107321:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107326:	e9 30 f1 ff ff       	jmp    8010645b <alltraps>

8010732b <vector214>:
.globl vector214
vector214:
  pushl $0
8010732b:	6a 00                	push   $0x0
  pushl $214
8010732d:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107332:	e9 24 f1 ff ff       	jmp    8010645b <alltraps>

80107337 <vector215>:
.globl vector215
vector215:
  pushl $0
80107337:	6a 00                	push   $0x0
  pushl $215
80107339:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
8010733e:	e9 18 f1 ff ff       	jmp    8010645b <alltraps>

80107343 <vector216>:
.globl vector216
vector216:
  pushl $0
80107343:	6a 00                	push   $0x0
  pushl $216
80107345:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010734a:	e9 0c f1 ff ff       	jmp    8010645b <alltraps>

8010734f <vector217>:
.globl vector217
vector217:
  pushl $0
8010734f:	6a 00                	push   $0x0
  pushl $217
80107351:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107356:	e9 00 f1 ff ff       	jmp    8010645b <alltraps>

8010735b <vector218>:
.globl vector218
vector218:
  pushl $0
8010735b:	6a 00                	push   $0x0
  pushl $218
8010735d:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107362:	e9 f4 f0 ff ff       	jmp    8010645b <alltraps>

80107367 <vector219>:
.globl vector219
vector219:
  pushl $0
80107367:	6a 00                	push   $0x0
  pushl $219
80107369:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
8010736e:	e9 e8 f0 ff ff       	jmp    8010645b <alltraps>

80107373 <vector220>:
.globl vector220
vector220:
  pushl $0
80107373:	6a 00                	push   $0x0
  pushl $220
80107375:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010737a:	e9 dc f0 ff ff       	jmp    8010645b <alltraps>

8010737f <vector221>:
.globl vector221
vector221:
  pushl $0
8010737f:	6a 00                	push   $0x0
  pushl $221
80107381:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107386:	e9 d0 f0 ff ff       	jmp    8010645b <alltraps>

8010738b <vector222>:
.globl vector222
vector222:
  pushl $0
8010738b:	6a 00                	push   $0x0
  pushl $222
8010738d:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107392:	e9 c4 f0 ff ff       	jmp    8010645b <alltraps>

80107397 <vector223>:
.globl vector223
vector223:
  pushl $0
80107397:	6a 00                	push   $0x0
  pushl $223
80107399:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
8010739e:	e9 b8 f0 ff ff       	jmp    8010645b <alltraps>

801073a3 <vector224>:
.globl vector224
vector224:
  pushl $0
801073a3:	6a 00                	push   $0x0
  pushl $224
801073a5:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801073aa:	e9 ac f0 ff ff       	jmp    8010645b <alltraps>

801073af <vector225>:
.globl vector225
vector225:
  pushl $0
801073af:	6a 00                	push   $0x0
  pushl $225
801073b1:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801073b6:	e9 a0 f0 ff ff       	jmp    8010645b <alltraps>

801073bb <vector226>:
.globl vector226
vector226:
  pushl $0
801073bb:	6a 00                	push   $0x0
  pushl $226
801073bd:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801073c2:	e9 94 f0 ff ff       	jmp    8010645b <alltraps>

801073c7 <vector227>:
.globl vector227
vector227:
  pushl $0
801073c7:	6a 00                	push   $0x0
  pushl $227
801073c9:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801073ce:	e9 88 f0 ff ff       	jmp    8010645b <alltraps>

801073d3 <vector228>:
.globl vector228
vector228:
  pushl $0
801073d3:	6a 00                	push   $0x0
  pushl $228
801073d5:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801073da:	e9 7c f0 ff ff       	jmp    8010645b <alltraps>

801073df <vector229>:
.globl vector229
vector229:
  pushl $0
801073df:	6a 00                	push   $0x0
  pushl $229
801073e1:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801073e6:	e9 70 f0 ff ff       	jmp    8010645b <alltraps>

801073eb <vector230>:
.globl vector230
vector230:
  pushl $0
801073eb:	6a 00                	push   $0x0
  pushl $230
801073ed:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801073f2:	e9 64 f0 ff ff       	jmp    8010645b <alltraps>

801073f7 <vector231>:
.globl vector231
vector231:
  pushl $0
801073f7:	6a 00                	push   $0x0
  pushl $231
801073f9:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801073fe:	e9 58 f0 ff ff       	jmp    8010645b <alltraps>

80107403 <vector232>:
.globl vector232
vector232:
  pushl $0
80107403:	6a 00                	push   $0x0
  pushl $232
80107405:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010740a:	e9 4c f0 ff ff       	jmp    8010645b <alltraps>

8010740f <vector233>:
.globl vector233
vector233:
  pushl $0
8010740f:	6a 00                	push   $0x0
  pushl $233
80107411:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107416:	e9 40 f0 ff ff       	jmp    8010645b <alltraps>

8010741b <vector234>:
.globl vector234
vector234:
  pushl $0
8010741b:	6a 00                	push   $0x0
  pushl $234
8010741d:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107422:	e9 34 f0 ff ff       	jmp    8010645b <alltraps>

80107427 <vector235>:
.globl vector235
vector235:
  pushl $0
80107427:	6a 00                	push   $0x0
  pushl $235
80107429:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
8010742e:	e9 28 f0 ff ff       	jmp    8010645b <alltraps>

80107433 <vector236>:
.globl vector236
vector236:
  pushl $0
80107433:	6a 00                	push   $0x0
  pushl $236
80107435:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010743a:	e9 1c f0 ff ff       	jmp    8010645b <alltraps>

8010743f <vector237>:
.globl vector237
vector237:
  pushl $0
8010743f:	6a 00                	push   $0x0
  pushl $237
80107441:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107446:	e9 10 f0 ff ff       	jmp    8010645b <alltraps>

8010744b <vector238>:
.globl vector238
vector238:
  pushl $0
8010744b:	6a 00                	push   $0x0
  pushl $238
8010744d:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107452:	e9 04 f0 ff ff       	jmp    8010645b <alltraps>

80107457 <vector239>:
.globl vector239
vector239:
  pushl $0
80107457:	6a 00                	push   $0x0
  pushl $239
80107459:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
8010745e:	e9 f8 ef ff ff       	jmp    8010645b <alltraps>

80107463 <vector240>:
.globl vector240
vector240:
  pushl $0
80107463:	6a 00                	push   $0x0
  pushl $240
80107465:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010746a:	e9 ec ef ff ff       	jmp    8010645b <alltraps>

8010746f <vector241>:
.globl vector241
vector241:
  pushl $0
8010746f:	6a 00                	push   $0x0
  pushl $241
80107471:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107476:	e9 e0 ef ff ff       	jmp    8010645b <alltraps>

8010747b <vector242>:
.globl vector242
vector242:
  pushl $0
8010747b:	6a 00                	push   $0x0
  pushl $242
8010747d:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107482:	e9 d4 ef ff ff       	jmp    8010645b <alltraps>

80107487 <vector243>:
.globl vector243
vector243:
  pushl $0
80107487:	6a 00                	push   $0x0
  pushl $243
80107489:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
8010748e:	e9 c8 ef ff ff       	jmp    8010645b <alltraps>

80107493 <vector244>:
.globl vector244
vector244:
  pushl $0
80107493:	6a 00                	push   $0x0
  pushl $244
80107495:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010749a:	e9 bc ef ff ff       	jmp    8010645b <alltraps>

8010749f <vector245>:
.globl vector245
vector245:
  pushl $0
8010749f:	6a 00                	push   $0x0
  pushl $245
801074a1:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801074a6:	e9 b0 ef ff ff       	jmp    8010645b <alltraps>

801074ab <vector246>:
.globl vector246
vector246:
  pushl $0
801074ab:	6a 00                	push   $0x0
  pushl $246
801074ad:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801074b2:	e9 a4 ef ff ff       	jmp    8010645b <alltraps>

801074b7 <vector247>:
.globl vector247
vector247:
  pushl $0
801074b7:	6a 00                	push   $0x0
  pushl $247
801074b9:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801074be:	e9 98 ef ff ff       	jmp    8010645b <alltraps>

801074c3 <vector248>:
.globl vector248
vector248:
  pushl $0
801074c3:	6a 00                	push   $0x0
  pushl $248
801074c5:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801074ca:	e9 8c ef ff ff       	jmp    8010645b <alltraps>

801074cf <vector249>:
.globl vector249
vector249:
  pushl $0
801074cf:	6a 00                	push   $0x0
  pushl $249
801074d1:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801074d6:	e9 80 ef ff ff       	jmp    8010645b <alltraps>

801074db <vector250>:
.globl vector250
vector250:
  pushl $0
801074db:	6a 00                	push   $0x0
  pushl $250
801074dd:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801074e2:	e9 74 ef ff ff       	jmp    8010645b <alltraps>

801074e7 <vector251>:
.globl vector251
vector251:
  pushl $0
801074e7:	6a 00                	push   $0x0
  pushl $251
801074e9:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801074ee:	e9 68 ef ff ff       	jmp    8010645b <alltraps>

801074f3 <vector252>:
.globl vector252
vector252:
  pushl $0
801074f3:	6a 00                	push   $0x0
  pushl $252
801074f5:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801074fa:	e9 5c ef ff ff       	jmp    8010645b <alltraps>

801074ff <vector253>:
.globl vector253
vector253:
  pushl $0
801074ff:	6a 00                	push   $0x0
  pushl $253
80107501:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107506:	e9 50 ef ff ff       	jmp    8010645b <alltraps>

8010750b <vector254>:
.globl vector254
vector254:
  pushl $0
8010750b:	6a 00                	push   $0x0
  pushl $254
8010750d:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107512:	e9 44 ef ff ff       	jmp    8010645b <alltraps>

80107517 <vector255>:
.globl vector255
vector255:
  pushl $0
80107517:	6a 00                	push   $0x0
  pushl $255
80107519:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
8010751e:	e9 38 ef ff ff       	jmp    8010645b <alltraps>

80107523 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
80107523:	55                   	push   %ebp
80107524:	89 e5                	mov    %esp,%ebp
80107526:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80107529:	8b 45 0c             	mov    0xc(%ebp),%eax
8010752c:	83 e8 01             	sub    $0x1,%eax
8010752f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107533:	8b 45 08             	mov    0x8(%ebp),%eax
80107536:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010753a:	8b 45 08             	mov    0x8(%ebp),%eax
8010753d:	c1 e8 10             	shr    $0x10,%eax
80107540:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107544:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107547:	0f 01 10             	lgdtl  (%eax)
}
8010754a:	90                   	nop
8010754b:	c9                   	leave  
8010754c:	c3                   	ret    

8010754d <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
8010754d:	55                   	push   %ebp
8010754e:	89 e5                	mov    %esp,%ebp
80107550:	83 ec 04             	sub    $0x4,%esp
80107553:	8b 45 08             	mov    0x8(%ebp),%eax
80107556:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
8010755a:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010755e:	0f 00 d8             	ltr    %ax
}
80107561:	90                   	nop
80107562:	c9                   	leave  
80107563:	c3                   	ret    

80107564 <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
80107564:	55                   	push   %ebp
80107565:	89 e5                	mov    %esp,%ebp
80107567:	83 ec 04             	sub    $0x4,%esp
8010756a:	8b 45 08             	mov    0x8(%ebp),%eax
8010756d:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
80107571:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107575:	8e e8                	mov    %eax,%gs
}
80107577:	90                   	nop
80107578:	c9                   	leave  
80107579:	c3                   	ret    

8010757a <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
8010757a:	55                   	push   %ebp
8010757b:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010757d:	8b 45 08             	mov    0x8(%ebp),%eax
80107580:	0f 22 d8             	mov    %eax,%cr3
}
80107583:	90                   	nop
80107584:	5d                   	pop    %ebp
80107585:	c3                   	ret    

80107586 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80107586:	55                   	push   %ebp
80107587:	89 e5                	mov    %esp,%ebp
80107589:	8b 45 08             	mov    0x8(%ebp),%eax
8010758c:	05 00 00 00 80       	add    $0x80000000,%eax
80107591:	5d                   	pop    %ebp
80107592:	c3                   	ret    

80107593 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80107593:	55                   	push   %ebp
80107594:	89 e5                	mov    %esp,%ebp
80107596:	8b 45 08             	mov    0x8(%ebp),%eax
80107599:	05 00 00 00 80       	add    $0x80000000,%eax
8010759e:	5d                   	pop    %ebp
8010759f:	c3                   	ret    

801075a0 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801075a0:	55                   	push   %ebp
801075a1:	89 e5                	mov    %esp,%ebp
801075a3:	53                   	push   %ebx
801075a4:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
801075a7:	e8 e9 bb ff ff       	call   80103195 <cpunum>
801075ac:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801075b2:	05 60 29 11 80       	add    $0x80112960,%eax
801075b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801075ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075bd:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801075c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075c6:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801075cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075cf:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801075d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075d6:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801075da:	83 e2 f0             	and    $0xfffffff0,%edx
801075dd:	83 ca 0a             	or     $0xa,%edx
801075e0:	88 50 7d             	mov    %dl,0x7d(%eax)
801075e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075e6:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801075ea:	83 ca 10             	or     $0x10,%edx
801075ed:	88 50 7d             	mov    %dl,0x7d(%eax)
801075f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075f3:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801075f7:	83 e2 9f             	and    $0xffffff9f,%edx
801075fa:	88 50 7d             	mov    %dl,0x7d(%eax)
801075fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107600:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107604:	83 ca 80             	or     $0xffffff80,%edx
80107607:	88 50 7d             	mov    %dl,0x7d(%eax)
8010760a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010760d:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107611:	83 ca 0f             	or     $0xf,%edx
80107614:	88 50 7e             	mov    %dl,0x7e(%eax)
80107617:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010761a:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010761e:	83 e2 ef             	and    $0xffffffef,%edx
80107621:	88 50 7e             	mov    %dl,0x7e(%eax)
80107624:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107627:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010762b:	83 e2 df             	and    $0xffffffdf,%edx
8010762e:	88 50 7e             	mov    %dl,0x7e(%eax)
80107631:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107634:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107638:	83 ca 40             	or     $0x40,%edx
8010763b:	88 50 7e             	mov    %dl,0x7e(%eax)
8010763e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107641:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107645:	83 ca 80             	or     $0xffffff80,%edx
80107648:	88 50 7e             	mov    %dl,0x7e(%eax)
8010764b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010764e:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107652:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107655:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
8010765c:	ff ff 
8010765e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107661:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107668:	00 00 
8010766a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010766d:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107674:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107677:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010767e:	83 e2 f0             	and    $0xfffffff0,%edx
80107681:	83 ca 02             	or     $0x2,%edx
80107684:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010768a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010768d:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107694:	83 ca 10             	or     $0x10,%edx
80107697:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010769d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076a0:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801076a7:	83 e2 9f             	and    $0xffffff9f,%edx
801076aa:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801076b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076b3:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801076ba:	83 ca 80             	or     $0xffffff80,%edx
801076bd:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801076c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076c6:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076cd:	83 ca 0f             	or     $0xf,%edx
801076d0:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801076d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076d9:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076e0:	83 e2 ef             	and    $0xffffffef,%edx
801076e3:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801076e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076ec:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076f3:	83 e2 df             	and    $0xffffffdf,%edx
801076f6:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801076fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076ff:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107706:	83 ca 40             	or     $0x40,%edx
80107709:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010770f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107712:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107719:	83 ca 80             	or     $0xffffff80,%edx
8010771c:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107722:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107725:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010772c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010772f:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107736:	ff ff 
80107738:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010773b:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107742:	00 00 
80107744:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107747:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
8010774e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107751:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107758:	83 e2 f0             	and    $0xfffffff0,%edx
8010775b:	83 ca 0a             	or     $0xa,%edx
8010775e:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107764:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107767:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
8010776e:	83 ca 10             	or     $0x10,%edx
80107771:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107777:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010777a:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107781:	83 ca 60             	or     $0x60,%edx
80107784:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010778a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010778d:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107794:	83 ca 80             	or     $0xffffff80,%edx
80107797:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010779d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077a0:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077a7:	83 ca 0f             	or     $0xf,%edx
801077aa:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077b3:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077ba:	83 e2 ef             	and    $0xffffffef,%edx
801077bd:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077c6:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077cd:	83 e2 df             	and    $0xffffffdf,%edx
801077d0:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077d9:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077e0:	83 ca 40             	or     $0x40,%edx
801077e3:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077ec:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077f3:	83 ca 80             	or     $0xffffff80,%edx
801077f6:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077ff:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107806:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107809:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107810:	ff ff 
80107812:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107815:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
8010781c:	00 00 
8010781e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107821:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107828:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010782b:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107832:	83 e2 f0             	and    $0xfffffff0,%edx
80107835:	83 ca 02             	or     $0x2,%edx
80107838:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
8010783e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107841:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107848:	83 ca 10             	or     $0x10,%edx
8010784b:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107851:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107854:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010785b:	83 ca 60             	or     $0x60,%edx
8010785e:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107864:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107867:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010786e:	83 ca 80             	or     $0xffffff80,%edx
80107871:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107877:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010787a:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107881:	83 ca 0f             	or     $0xf,%edx
80107884:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010788a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010788d:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107894:	83 e2 ef             	and    $0xffffffef,%edx
80107897:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010789d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078a0:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801078a7:	83 e2 df             	and    $0xffffffdf,%edx
801078aa:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078b3:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801078ba:	83 ca 40             	or     $0x40,%edx
801078bd:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078c6:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801078cd:	83 ca 80             	or     $0xffffff80,%edx
801078d0:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078d9:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801078e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078e3:	05 b4 00 00 00       	add    $0xb4,%eax
801078e8:	89 c3                	mov    %eax,%ebx
801078ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078ed:	05 b4 00 00 00       	add    $0xb4,%eax
801078f2:	c1 e8 10             	shr    $0x10,%eax
801078f5:	89 c2                	mov    %eax,%edx
801078f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078fa:	05 b4 00 00 00       	add    $0xb4,%eax
801078ff:	c1 e8 18             	shr    $0x18,%eax
80107902:	89 c1                	mov    %eax,%ecx
80107904:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107907:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
8010790e:	00 00 
80107910:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107913:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
8010791a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010791d:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80107923:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107926:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010792d:	83 e2 f0             	and    $0xfffffff0,%edx
80107930:	83 ca 02             	or     $0x2,%edx
80107933:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107939:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010793c:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107943:	83 ca 10             	or     $0x10,%edx
80107946:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
8010794c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010794f:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107956:	83 e2 9f             	and    $0xffffff9f,%edx
80107959:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
8010795f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107962:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107969:	83 ca 80             	or     $0xffffff80,%edx
8010796c:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107972:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107975:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
8010797c:	83 e2 f0             	and    $0xfffffff0,%edx
8010797f:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107985:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107988:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
8010798f:	83 e2 ef             	and    $0xffffffef,%edx
80107992:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107998:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010799b:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801079a2:	83 e2 df             	and    $0xffffffdf,%edx
801079a5:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801079ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ae:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801079b5:	83 ca 40             	or     $0x40,%edx
801079b8:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801079be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079c1:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801079c8:	83 ca 80             	or     $0xffffff80,%edx
801079cb:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801079d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079d4:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
801079da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079dd:	83 c0 70             	add    $0x70,%eax
801079e0:	83 ec 08             	sub    $0x8,%esp
801079e3:	6a 38                	push   $0x38
801079e5:	50                   	push   %eax
801079e6:	e8 38 fb ff ff       	call   80107523 <lgdt>
801079eb:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
801079ee:	83 ec 0c             	sub    $0xc,%esp
801079f1:	6a 18                	push   $0x18
801079f3:	e8 6c fb ff ff       	call   80107564 <loadgs>
801079f8:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
801079fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079fe:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80107a04:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107a0b:	00 00 00 00 
}
80107a0f:	90                   	nop
80107a10:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107a13:	c9                   	leave  
80107a14:	c3                   	ret    

80107a15 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107a15:	55                   	push   %ebp
80107a16:	89 e5                	mov    %esp,%ebp
80107a18:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107a1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a1e:	c1 e8 16             	shr    $0x16,%eax
80107a21:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107a28:	8b 45 08             	mov    0x8(%ebp),%eax
80107a2b:	01 d0                	add    %edx,%eax
80107a2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107a30:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a33:	8b 00                	mov    (%eax),%eax
80107a35:	83 e0 01             	and    $0x1,%eax
80107a38:	85 c0                	test   %eax,%eax
80107a3a:	74 18                	je     80107a54 <walkpgdir+0x3f>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107a3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a3f:	8b 00                	mov    (%eax),%eax
80107a41:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107a46:	50                   	push   %eax
80107a47:	e8 47 fb ff ff       	call   80107593 <p2v>
80107a4c:	83 c4 04             	add    $0x4,%esp
80107a4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107a52:	eb 48                	jmp    80107a9c <walkpgdir+0x87>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107a54:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107a58:	74 0e                	je     80107a68 <walkpgdir+0x53>
80107a5a:	e8 a1 b2 ff ff       	call   80102d00 <kalloc>
80107a5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107a62:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107a66:	75 07                	jne    80107a6f <walkpgdir+0x5a>
      return 0;
80107a68:	b8 00 00 00 00       	mov    $0x0,%eax
80107a6d:	eb 44                	jmp    80107ab3 <walkpgdir+0x9e>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107a6f:	83 ec 04             	sub    $0x4,%esp
80107a72:	68 00 10 00 00       	push   $0x1000
80107a77:	6a 00                	push   $0x0
80107a79:	ff 75 f4             	pushl  -0xc(%ebp)
80107a7c:	e8 52 d6 ff ff       	call   801050d3 <memset>
80107a81:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107a84:	83 ec 0c             	sub    $0xc,%esp
80107a87:	ff 75 f4             	pushl  -0xc(%ebp)
80107a8a:	e8 f7 fa ff ff       	call   80107586 <v2p>
80107a8f:	83 c4 10             	add    $0x10,%esp
80107a92:	83 c8 07             	or     $0x7,%eax
80107a95:	89 c2                	mov    %eax,%edx
80107a97:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a9a:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107a9c:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a9f:	c1 e8 0c             	shr    $0xc,%eax
80107aa2:	25 ff 03 00 00       	and    $0x3ff,%eax
80107aa7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107aae:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ab1:	01 d0                	add    %edx,%eax
}
80107ab3:	c9                   	leave  
80107ab4:	c3                   	ret    

80107ab5 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107ab5:	55                   	push   %ebp
80107ab6:	89 e5                	mov    %esp,%ebp
80107ab8:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107abb:	8b 45 0c             	mov    0xc(%ebp),%eax
80107abe:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ac3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107ac6:	8b 55 0c             	mov    0xc(%ebp),%edx
80107ac9:	8b 45 10             	mov    0x10(%ebp),%eax
80107acc:	01 d0                	add    %edx,%eax
80107ace:	83 e8 01             	sub    $0x1,%eax
80107ad1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ad6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107ad9:	83 ec 04             	sub    $0x4,%esp
80107adc:	6a 01                	push   $0x1
80107ade:	ff 75 f4             	pushl  -0xc(%ebp)
80107ae1:	ff 75 08             	pushl  0x8(%ebp)
80107ae4:	e8 2c ff ff ff       	call   80107a15 <walkpgdir>
80107ae9:	83 c4 10             	add    $0x10,%esp
80107aec:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107aef:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107af3:	75 07                	jne    80107afc <mappages+0x47>
      return -1;
80107af5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107afa:	eb 47                	jmp    80107b43 <mappages+0x8e>
    if(*pte & PTE_P)
80107afc:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107aff:	8b 00                	mov    (%eax),%eax
80107b01:	83 e0 01             	and    $0x1,%eax
80107b04:	85 c0                	test   %eax,%eax
80107b06:	74 0d                	je     80107b15 <mappages+0x60>
      panic("remap");
80107b08:	83 ec 0c             	sub    $0xc,%esp
80107b0b:	68 60 ba 10 80       	push   $0x8010ba60
80107b10:	e8 51 8a ff ff       	call   80100566 <panic>
    *pte = pa | perm | PTE_P;
80107b15:	8b 45 18             	mov    0x18(%ebp),%eax
80107b18:	0b 45 14             	or     0x14(%ebp),%eax
80107b1b:	83 c8 01             	or     $0x1,%eax
80107b1e:	89 c2                	mov    %eax,%edx
80107b20:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107b23:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107b25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b28:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107b2b:	74 10                	je     80107b3d <mappages+0x88>
      break;
    a += PGSIZE;
80107b2d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107b34:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80107b3b:	eb 9c                	jmp    80107ad9 <mappages+0x24>
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
80107b3d:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107b3e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107b43:	c9                   	leave  
80107b44:	c3                   	ret    

80107b45 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107b45:	55                   	push   %ebp
80107b46:	89 e5                	mov    %esp,%ebp
80107b48:	53                   	push   %ebx
80107b49:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107b4c:	e8 af b1 ff ff       	call   80102d00 <kalloc>
80107b51:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107b54:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107b58:	75 0a                	jne    80107b64 <setupkvm+0x1f>
    return 0;
80107b5a:	b8 00 00 00 00       	mov    $0x0,%eax
80107b5f:	e9 8e 00 00 00       	jmp    80107bf2 <setupkvm+0xad>
  memset(pgdir, 0, PGSIZE);
80107b64:	83 ec 04             	sub    $0x4,%esp
80107b67:	68 00 10 00 00       	push   $0x1000
80107b6c:	6a 00                	push   $0x0
80107b6e:	ff 75 f0             	pushl  -0x10(%ebp)
80107b71:	e8 5d d5 ff ff       	call   801050d3 <memset>
80107b76:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107b79:	83 ec 0c             	sub    $0xc,%esp
80107b7c:	68 00 00 00 0e       	push   $0xe000000
80107b81:	e8 0d fa ff ff       	call   80107593 <p2v>
80107b86:	83 c4 10             	add    $0x10,%esp
80107b89:	3d 00 00 00 fc       	cmp    $0xfc000000,%eax
80107b8e:	76 0d                	jbe    80107b9d <setupkvm+0x58>
    panic("PHYSTOP too high");
80107b90:	83 ec 0c             	sub    $0xc,%esp
80107b93:	68 66 ba 10 80       	push   $0x8010ba66
80107b98:	e8 c9 89 ff ff       	call   80100566 <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107b9d:	c7 45 f4 c0 e4 10 80 	movl   $0x8010e4c0,-0xc(%ebp)
80107ba4:	eb 40                	jmp    80107be6 <setupkvm+0xa1>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107ba6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ba9:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
80107bac:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107baf:	8b 50 04             	mov    0x4(%eax),%edx
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107bb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bb5:	8b 58 08             	mov    0x8(%eax),%ebx
80107bb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bbb:	8b 40 04             	mov    0x4(%eax),%eax
80107bbe:	29 c3                	sub    %eax,%ebx
80107bc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bc3:	8b 00                	mov    (%eax),%eax
80107bc5:	83 ec 0c             	sub    $0xc,%esp
80107bc8:	51                   	push   %ecx
80107bc9:	52                   	push   %edx
80107bca:	53                   	push   %ebx
80107bcb:	50                   	push   %eax
80107bcc:	ff 75 f0             	pushl  -0x10(%ebp)
80107bcf:	e8 e1 fe ff ff       	call   80107ab5 <mappages>
80107bd4:	83 c4 20             	add    $0x20,%esp
80107bd7:	85 c0                	test   %eax,%eax
80107bd9:	79 07                	jns    80107be2 <setupkvm+0x9d>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80107bdb:	b8 00 00 00 00       	mov    $0x0,%eax
80107be0:	eb 10                	jmp    80107bf2 <setupkvm+0xad>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107be2:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107be6:	81 7d f4 00 e5 10 80 	cmpl   $0x8010e500,-0xc(%ebp)
80107bed:	72 b7                	jb     80107ba6 <setupkvm+0x61>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80107bef:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107bf2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107bf5:	c9                   	leave  
80107bf6:	c3                   	ret    

80107bf7 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107bf7:	55                   	push   %ebp
80107bf8:	89 e5                	mov    %esp,%ebp
80107bfa:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107bfd:	e8 43 ff ff ff       	call   80107b45 <setupkvm>
80107c02:	a3 38 57 11 80       	mov    %eax,0x80115738
  switchkvm();
80107c07:	e8 03 00 00 00       	call   80107c0f <switchkvm>
}
80107c0c:	90                   	nop
80107c0d:	c9                   	leave  
80107c0e:	c3                   	ret    

80107c0f <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107c0f:	55                   	push   %ebp
80107c10:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107c12:	a1 38 57 11 80       	mov    0x80115738,%eax
80107c17:	50                   	push   %eax
80107c18:	e8 69 f9 ff ff       	call   80107586 <v2p>
80107c1d:	83 c4 04             	add    $0x4,%esp
80107c20:	50                   	push   %eax
80107c21:	e8 54 f9 ff ff       	call   8010757a <lcr3>
80107c26:	83 c4 04             	add    $0x4,%esp
}
80107c29:	90                   	nop
80107c2a:	c9                   	leave  
80107c2b:	c3                   	ret    

80107c2c <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107c2c:	55                   	push   %ebp
80107c2d:	89 e5                	mov    %esp,%ebp
80107c2f:	56                   	push   %esi
80107c30:	53                   	push   %ebx
  pushcli();
80107c31:	e8 97 d3 ff ff       	call   80104fcd <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107c36:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107c3c:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107c43:	83 c2 08             	add    $0x8,%edx
80107c46:	89 d6                	mov    %edx,%esi
80107c48:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107c4f:	83 c2 08             	add    $0x8,%edx
80107c52:	c1 ea 10             	shr    $0x10,%edx
80107c55:	89 d3                	mov    %edx,%ebx
80107c57:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107c5e:	83 c2 08             	add    $0x8,%edx
80107c61:	c1 ea 18             	shr    $0x18,%edx
80107c64:	89 d1                	mov    %edx,%ecx
80107c66:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107c6d:	67 00 
80107c6f:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
80107c76:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80107c7c:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107c83:	83 e2 f0             	and    $0xfffffff0,%edx
80107c86:	83 ca 09             	or     $0x9,%edx
80107c89:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107c8f:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107c96:	83 ca 10             	or     $0x10,%edx
80107c99:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107c9f:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107ca6:	83 e2 9f             	and    $0xffffff9f,%edx
80107ca9:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107caf:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107cb6:	83 ca 80             	or     $0xffffff80,%edx
80107cb9:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107cbf:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107cc6:	83 e2 f0             	and    $0xfffffff0,%edx
80107cc9:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107ccf:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107cd6:	83 e2 ef             	and    $0xffffffef,%edx
80107cd9:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107cdf:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107ce6:	83 e2 df             	and    $0xffffffdf,%edx
80107ce9:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107cef:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107cf6:	83 ca 40             	or     $0x40,%edx
80107cf9:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107cff:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107d06:	83 e2 7f             	and    $0x7f,%edx
80107d09:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107d0f:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107d15:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d1b:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107d22:	83 e2 ef             	and    $0xffffffef,%edx
80107d25:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107d2b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d31:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80107d37:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d3d:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107d44:	8b 52 08             	mov    0x8(%edx),%edx
80107d47:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107d4d:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80107d50:	83 ec 0c             	sub    $0xc,%esp
80107d53:	6a 30                	push   $0x30
80107d55:	e8 f3 f7 ff ff       	call   8010754d <ltr>
80107d5a:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80107d5d:	8b 45 08             	mov    0x8(%ebp),%eax
80107d60:	8b 40 04             	mov    0x4(%eax),%eax
80107d63:	85 c0                	test   %eax,%eax
80107d65:	75 0d                	jne    80107d74 <switchuvm+0x148>
    panic("switchuvm: no pgdir");
80107d67:	83 ec 0c             	sub    $0xc,%esp
80107d6a:	68 77 ba 10 80       	push   $0x8010ba77
80107d6f:	e8 f2 87 ff ff       	call   80100566 <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80107d74:	8b 45 08             	mov    0x8(%ebp),%eax
80107d77:	8b 40 04             	mov    0x4(%eax),%eax
80107d7a:	83 ec 0c             	sub    $0xc,%esp
80107d7d:	50                   	push   %eax
80107d7e:	e8 03 f8 ff ff       	call   80107586 <v2p>
80107d83:	83 c4 10             	add    $0x10,%esp
80107d86:	83 ec 0c             	sub    $0xc,%esp
80107d89:	50                   	push   %eax
80107d8a:	e8 eb f7 ff ff       	call   8010757a <lcr3>
80107d8f:	83 c4 10             	add    $0x10,%esp
  popcli();
80107d92:	e8 7b d2 ff ff       	call   80105012 <popcli>
}
80107d97:	90                   	nop
80107d98:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107d9b:	5b                   	pop    %ebx
80107d9c:	5e                   	pop    %esi
80107d9d:	5d                   	pop    %ebp
80107d9e:	c3                   	ret    

80107d9f <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107d9f:	55                   	push   %ebp
80107da0:	89 e5                	mov    %esp,%ebp
80107da2:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
80107da5:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80107dac:	76 0d                	jbe    80107dbb <inituvm+0x1c>
    panic("inituvm: more than a page");
80107dae:	83 ec 0c             	sub    $0xc,%esp
80107db1:	68 8b ba 10 80       	push   $0x8010ba8b
80107db6:	e8 ab 87 ff ff       	call   80100566 <panic>
  mem = kalloc();
80107dbb:	e8 40 af ff ff       	call   80102d00 <kalloc>
80107dc0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80107dc3:	83 ec 04             	sub    $0x4,%esp
80107dc6:	68 00 10 00 00       	push   $0x1000
80107dcb:	6a 00                	push   $0x0
80107dcd:	ff 75 f4             	pushl  -0xc(%ebp)
80107dd0:	e8 fe d2 ff ff       	call   801050d3 <memset>
80107dd5:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107dd8:	83 ec 0c             	sub    $0xc,%esp
80107ddb:	ff 75 f4             	pushl  -0xc(%ebp)
80107dde:	e8 a3 f7 ff ff       	call   80107586 <v2p>
80107de3:	83 c4 10             	add    $0x10,%esp
80107de6:	83 ec 0c             	sub    $0xc,%esp
80107de9:	6a 06                	push   $0x6
80107deb:	50                   	push   %eax
80107dec:	68 00 10 00 00       	push   $0x1000
80107df1:	6a 00                	push   $0x0
80107df3:	ff 75 08             	pushl  0x8(%ebp)
80107df6:	e8 ba fc ff ff       	call   80107ab5 <mappages>
80107dfb:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
80107dfe:	83 ec 04             	sub    $0x4,%esp
80107e01:	ff 75 10             	pushl  0x10(%ebp)
80107e04:	ff 75 0c             	pushl  0xc(%ebp)
80107e07:	ff 75 f4             	pushl  -0xc(%ebp)
80107e0a:	e8 83 d3 ff ff       	call   80105192 <memmove>
80107e0f:	83 c4 10             	add    $0x10,%esp
}
80107e12:	90                   	nop
80107e13:	c9                   	leave  
80107e14:	c3                   	ret    

80107e15 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107e15:	55                   	push   %ebp
80107e16:	89 e5                	mov    %esp,%ebp
80107e18:	53                   	push   %ebx
80107e19:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107e1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e1f:	25 ff 0f 00 00       	and    $0xfff,%eax
80107e24:	85 c0                	test   %eax,%eax
80107e26:	74 0d                	je     80107e35 <loaduvm+0x20>
    panic("loaduvm: addr must be page aligned");
80107e28:	83 ec 0c             	sub    $0xc,%esp
80107e2b:	68 a8 ba 10 80       	push   $0x8010baa8
80107e30:	e8 31 87 ff ff       	call   80100566 <panic>
  for(i = 0; i < sz; i += PGSIZE){
80107e35:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107e3c:	e9 95 00 00 00       	jmp    80107ed6 <loaduvm+0xc1>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107e41:	8b 55 0c             	mov    0xc(%ebp),%edx
80107e44:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e47:	01 d0                	add    %edx,%eax
80107e49:	83 ec 04             	sub    $0x4,%esp
80107e4c:	6a 00                	push   $0x0
80107e4e:	50                   	push   %eax
80107e4f:	ff 75 08             	pushl  0x8(%ebp)
80107e52:	e8 be fb ff ff       	call   80107a15 <walkpgdir>
80107e57:	83 c4 10             	add    $0x10,%esp
80107e5a:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107e5d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107e61:	75 0d                	jne    80107e70 <loaduvm+0x5b>
      panic("loaduvm: address should exist");
80107e63:	83 ec 0c             	sub    $0xc,%esp
80107e66:	68 cb ba 10 80       	push   $0x8010bacb
80107e6b:	e8 f6 86 ff ff       	call   80100566 <panic>
    pa = PTE_ADDR(*pte);
80107e70:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107e73:	8b 00                	mov    (%eax),%eax
80107e75:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e7a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80107e7d:	8b 45 18             	mov    0x18(%ebp),%eax
80107e80:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107e83:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80107e88:	77 0b                	ja     80107e95 <loaduvm+0x80>
      n = sz - i;
80107e8a:	8b 45 18             	mov    0x18(%ebp),%eax
80107e8d:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107e90:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107e93:	eb 07                	jmp    80107e9c <loaduvm+0x87>
    else
      n = PGSIZE;
80107e95:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80107e9c:	8b 55 14             	mov    0x14(%ebp),%edx
80107e9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ea2:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80107ea5:	83 ec 0c             	sub    $0xc,%esp
80107ea8:	ff 75 e8             	pushl  -0x18(%ebp)
80107eab:	e8 e3 f6 ff ff       	call   80107593 <p2v>
80107eb0:	83 c4 10             	add    $0x10,%esp
80107eb3:	ff 75 f0             	pushl  -0x10(%ebp)
80107eb6:	53                   	push   %ebx
80107eb7:	50                   	push   %eax
80107eb8:	ff 75 10             	pushl  0x10(%ebp)
80107ebb:	e8 ee a0 ff ff       	call   80101fae <readi>
80107ec0:	83 c4 10             	add    $0x10,%esp
80107ec3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107ec6:	74 07                	je     80107ecf <loaduvm+0xba>
      return -1;
80107ec8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107ecd:	eb 18                	jmp    80107ee7 <loaduvm+0xd2>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107ecf:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107ed6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ed9:	3b 45 18             	cmp    0x18(%ebp),%eax
80107edc:	0f 82 5f ff ff ff    	jb     80107e41 <loaduvm+0x2c>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80107ee2:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107ee7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107eea:	c9                   	leave  
80107eeb:	c3                   	ret    

80107eec <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107eec:	55                   	push   %ebp
80107eed:	89 e5                	mov    %esp,%ebp
80107eef:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80107ef2:	8b 45 10             	mov    0x10(%ebp),%eax
80107ef5:	85 c0                	test   %eax,%eax
80107ef7:	79 0a                	jns    80107f03 <allocuvm+0x17>
    return 0;
80107ef9:	b8 00 00 00 00       	mov    $0x0,%eax
80107efe:	e9 b0 00 00 00       	jmp    80107fb3 <allocuvm+0xc7>
  if(newsz < oldsz)
80107f03:	8b 45 10             	mov    0x10(%ebp),%eax
80107f06:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107f09:	73 08                	jae    80107f13 <allocuvm+0x27>
    return oldsz;
80107f0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f0e:	e9 a0 00 00 00       	jmp    80107fb3 <allocuvm+0xc7>

  a = PGROUNDUP(oldsz);
80107f13:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f16:	05 ff 0f 00 00       	add    $0xfff,%eax
80107f1b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f20:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
80107f23:	eb 7f                	jmp    80107fa4 <allocuvm+0xb8>
    mem = kalloc();
80107f25:	e8 d6 ad ff ff       	call   80102d00 <kalloc>
80107f2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80107f2d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107f31:	75 2b                	jne    80107f5e <allocuvm+0x72>
      cprintf("allocuvm out of memory\n");
80107f33:	83 ec 0c             	sub    $0xc,%esp
80107f36:	68 e9 ba 10 80       	push   $0x8010bae9
80107f3b:	e8 86 84 ff ff       	call   801003c6 <cprintf>
80107f40:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
80107f43:	83 ec 04             	sub    $0x4,%esp
80107f46:	ff 75 0c             	pushl  0xc(%ebp)
80107f49:	ff 75 10             	pushl  0x10(%ebp)
80107f4c:	ff 75 08             	pushl  0x8(%ebp)
80107f4f:	e8 61 00 00 00       	call   80107fb5 <deallocuvm>
80107f54:	83 c4 10             	add    $0x10,%esp
      return 0;
80107f57:	b8 00 00 00 00       	mov    $0x0,%eax
80107f5c:	eb 55                	jmp    80107fb3 <allocuvm+0xc7>
    }
    memset(mem, 0, PGSIZE);
80107f5e:	83 ec 04             	sub    $0x4,%esp
80107f61:	68 00 10 00 00       	push   $0x1000
80107f66:	6a 00                	push   $0x0
80107f68:	ff 75 f0             	pushl  -0x10(%ebp)
80107f6b:	e8 63 d1 ff ff       	call   801050d3 <memset>
80107f70:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107f73:	83 ec 0c             	sub    $0xc,%esp
80107f76:	ff 75 f0             	pushl  -0x10(%ebp)
80107f79:	e8 08 f6 ff ff       	call   80107586 <v2p>
80107f7e:	83 c4 10             	add    $0x10,%esp
80107f81:	89 c2                	mov    %eax,%edx
80107f83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f86:	83 ec 0c             	sub    $0xc,%esp
80107f89:	6a 06                	push   $0x6
80107f8b:	52                   	push   %edx
80107f8c:	68 00 10 00 00       	push   $0x1000
80107f91:	50                   	push   %eax
80107f92:	ff 75 08             	pushl  0x8(%ebp)
80107f95:	e8 1b fb ff ff       	call   80107ab5 <mappages>
80107f9a:	83 c4 20             	add    $0x20,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107f9d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107fa4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fa7:	3b 45 10             	cmp    0x10(%ebp),%eax
80107faa:	0f 82 75 ff ff ff    	jb     80107f25 <allocuvm+0x39>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
80107fb0:	8b 45 10             	mov    0x10(%ebp),%eax
}
80107fb3:	c9                   	leave  
80107fb4:	c3                   	ret    

80107fb5 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107fb5:	55                   	push   %ebp
80107fb6:	89 e5                	mov    %esp,%ebp
80107fb8:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80107fbb:	8b 45 10             	mov    0x10(%ebp),%eax
80107fbe:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107fc1:	72 08                	jb     80107fcb <deallocuvm+0x16>
    return oldsz;
80107fc3:	8b 45 0c             	mov    0xc(%ebp),%eax
80107fc6:	e9 a5 00 00 00       	jmp    80108070 <deallocuvm+0xbb>

  a = PGROUNDUP(newsz);
80107fcb:	8b 45 10             	mov    0x10(%ebp),%eax
80107fce:	05 ff 0f 00 00       	add    $0xfff,%eax
80107fd3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107fd8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107fdb:	e9 81 00 00 00       	jmp    80108061 <deallocuvm+0xac>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107fe0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fe3:	83 ec 04             	sub    $0x4,%esp
80107fe6:	6a 00                	push   $0x0
80107fe8:	50                   	push   %eax
80107fe9:	ff 75 08             	pushl  0x8(%ebp)
80107fec:	e8 24 fa ff ff       	call   80107a15 <walkpgdir>
80107ff1:	83 c4 10             	add    $0x10,%esp
80107ff4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80107ff7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107ffb:	75 09                	jne    80108006 <deallocuvm+0x51>
      a += (NPTENTRIES - 1) * PGSIZE;
80107ffd:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
80108004:	eb 54                	jmp    8010805a <deallocuvm+0xa5>
    else if((*pte & PTE_P) != 0){
80108006:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108009:	8b 00                	mov    (%eax),%eax
8010800b:	83 e0 01             	and    $0x1,%eax
8010800e:	85 c0                	test   %eax,%eax
80108010:	74 48                	je     8010805a <deallocuvm+0xa5>
      pa = PTE_ADDR(*pte);
80108012:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108015:	8b 00                	mov    (%eax),%eax
80108017:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010801c:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
8010801f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108023:	75 0d                	jne    80108032 <deallocuvm+0x7d>
        panic("kfree");
80108025:	83 ec 0c             	sub    $0xc,%esp
80108028:	68 01 bb 10 80       	push   $0x8010bb01
8010802d:	e8 34 85 ff ff       	call   80100566 <panic>
      char *v = p2v(pa);
80108032:	83 ec 0c             	sub    $0xc,%esp
80108035:	ff 75 ec             	pushl  -0x14(%ebp)
80108038:	e8 56 f5 ff ff       	call   80107593 <p2v>
8010803d:	83 c4 10             	add    $0x10,%esp
80108040:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
80108043:	83 ec 0c             	sub    $0xc,%esp
80108046:	ff 75 e8             	pushl  -0x18(%ebp)
80108049:	e8 15 ac ff ff       	call   80102c63 <kfree>
8010804e:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80108051:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108054:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010805a:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108061:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108064:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108067:	0f 82 73 ff ff ff    	jb     80107fe0 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
8010806d:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108070:	c9                   	leave  
80108071:	c3                   	ret    

80108072 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108072:	55                   	push   %ebp
80108073:	89 e5                	mov    %esp,%ebp
80108075:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
80108078:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010807c:	75 0d                	jne    8010808b <freevm+0x19>
    panic("freevm: no pgdir");
8010807e:	83 ec 0c             	sub    $0xc,%esp
80108081:	68 07 bb 10 80       	push   $0x8010bb07
80108086:	e8 db 84 ff ff       	call   80100566 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
8010808b:	83 ec 04             	sub    $0x4,%esp
8010808e:	6a 00                	push   $0x0
80108090:	68 00 00 00 80       	push   $0x80000000
80108095:	ff 75 08             	pushl  0x8(%ebp)
80108098:	e8 18 ff ff ff       	call   80107fb5 <deallocuvm>
8010809d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801080a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801080a7:	eb 4f                	jmp    801080f8 <freevm+0x86>
    if(pgdir[i] & PTE_P){
801080a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080ac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801080b3:	8b 45 08             	mov    0x8(%ebp),%eax
801080b6:	01 d0                	add    %edx,%eax
801080b8:	8b 00                	mov    (%eax),%eax
801080ba:	83 e0 01             	and    $0x1,%eax
801080bd:	85 c0                	test   %eax,%eax
801080bf:	74 33                	je     801080f4 <freevm+0x82>
      char * v = p2v(PTE_ADDR(pgdir[i]));
801080c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801080cb:	8b 45 08             	mov    0x8(%ebp),%eax
801080ce:	01 d0                	add    %edx,%eax
801080d0:	8b 00                	mov    (%eax),%eax
801080d2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080d7:	83 ec 0c             	sub    $0xc,%esp
801080da:	50                   	push   %eax
801080db:	e8 b3 f4 ff ff       	call   80107593 <p2v>
801080e0:	83 c4 10             	add    $0x10,%esp
801080e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
801080e6:	83 ec 0c             	sub    $0xc,%esp
801080e9:	ff 75 f0             	pushl  -0x10(%ebp)
801080ec:	e8 72 ab ff ff       	call   80102c63 <kfree>
801080f1:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801080f4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801080f8:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
801080ff:	76 a8                	jbe    801080a9 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80108101:	83 ec 0c             	sub    $0xc,%esp
80108104:	ff 75 08             	pushl  0x8(%ebp)
80108107:	e8 57 ab ff ff       	call   80102c63 <kfree>
8010810c:	83 c4 10             	add    $0x10,%esp
}
8010810f:	90                   	nop
80108110:	c9                   	leave  
80108111:	c3                   	ret    

80108112 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108112:	55                   	push   %ebp
80108113:	89 e5                	mov    %esp,%ebp
80108115:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108118:	83 ec 04             	sub    $0x4,%esp
8010811b:	6a 00                	push   $0x0
8010811d:	ff 75 0c             	pushl  0xc(%ebp)
80108120:	ff 75 08             	pushl  0x8(%ebp)
80108123:	e8 ed f8 ff ff       	call   80107a15 <walkpgdir>
80108128:	83 c4 10             	add    $0x10,%esp
8010812b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
8010812e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108132:	75 0d                	jne    80108141 <clearpteu+0x2f>
    panic("clearpteu");
80108134:	83 ec 0c             	sub    $0xc,%esp
80108137:	68 18 bb 10 80       	push   $0x8010bb18
8010813c:	e8 25 84 ff ff       	call   80100566 <panic>
  *pte &= ~PTE_U;
80108141:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108144:	8b 00                	mov    (%eax),%eax
80108146:	83 e0 fb             	and    $0xfffffffb,%eax
80108149:	89 c2                	mov    %eax,%edx
8010814b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010814e:	89 10                	mov    %edx,(%eax)
}
80108150:	90                   	nop
80108151:	c9                   	leave  
80108152:	c3                   	ret    

80108153 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108153:	55                   	push   %ebp
80108154:	89 e5                	mov    %esp,%ebp
80108156:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
80108159:	e8 e7 f9 ff ff       	call   80107b45 <setupkvm>
8010815e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108161:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108165:	75 0a                	jne    80108171 <copyuvm+0x1e>
    return 0;
80108167:	b8 00 00 00 00       	mov    $0x0,%eax
8010816c:	e9 e9 00 00 00       	jmp    8010825a <copyuvm+0x107>
  for(i = 0; i < sz; i += PGSIZE){
80108171:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108178:	e9 b5 00 00 00       	jmp    80108232 <copyuvm+0xdf>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
8010817d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108180:	83 ec 04             	sub    $0x4,%esp
80108183:	6a 00                	push   $0x0
80108185:	50                   	push   %eax
80108186:	ff 75 08             	pushl  0x8(%ebp)
80108189:	e8 87 f8 ff ff       	call   80107a15 <walkpgdir>
8010818e:	83 c4 10             	add    $0x10,%esp
80108191:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108194:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108198:	75 0d                	jne    801081a7 <copyuvm+0x54>
      panic("copyuvm: pte should exist");
8010819a:	83 ec 0c             	sub    $0xc,%esp
8010819d:	68 22 bb 10 80       	push   $0x8010bb22
801081a2:	e8 bf 83 ff ff       	call   80100566 <panic>
    if(!(*pte & PTE_P))
801081a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801081aa:	8b 00                	mov    (%eax),%eax
801081ac:	83 e0 01             	and    $0x1,%eax
801081af:	85 c0                	test   %eax,%eax
801081b1:	75 0d                	jne    801081c0 <copyuvm+0x6d>
      panic("copyuvm: page not present");
801081b3:	83 ec 0c             	sub    $0xc,%esp
801081b6:	68 3c bb 10 80       	push   $0x8010bb3c
801081bb:	e8 a6 83 ff ff       	call   80100566 <panic>
    pa = PTE_ADDR(*pte);
801081c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801081c3:	8b 00                	mov    (%eax),%eax
801081c5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801081ca:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if((mem = kalloc()) == 0)
801081cd:	e8 2e ab ff ff       	call   80102d00 <kalloc>
801081d2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801081d5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
801081d9:	74 68                	je     80108243 <copyuvm+0xf0>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
801081db:	83 ec 0c             	sub    $0xc,%esp
801081de:	ff 75 e8             	pushl  -0x18(%ebp)
801081e1:	e8 ad f3 ff ff       	call   80107593 <p2v>
801081e6:	83 c4 10             	add    $0x10,%esp
801081e9:	83 ec 04             	sub    $0x4,%esp
801081ec:	68 00 10 00 00       	push   $0x1000
801081f1:	50                   	push   %eax
801081f2:	ff 75 e4             	pushl  -0x1c(%ebp)
801081f5:	e8 98 cf ff ff       	call   80105192 <memmove>
801081fa:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
801081fd:	83 ec 0c             	sub    $0xc,%esp
80108200:	ff 75 e4             	pushl  -0x1c(%ebp)
80108203:	e8 7e f3 ff ff       	call   80107586 <v2p>
80108208:	83 c4 10             	add    $0x10,%esp
8010820b:	89 c2                	mov    %eax,%edx
8010820d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108210:	83 ec 0c             	sub    $0xc,%esp
80108213:	6a 06                	push   $0x6
80108215:	52                   	push   %edx
80108216:	68 00 10 00 00       	push   $0x1000
8010821b:	50                   	push   %eax
8010821c:	ff 75 f0             	pushl  -0x10(%ebp)
8010821f:	e8 91 f8 ff ff       	call   80107ab5 <mappages>
80108224:	83 c4 20             	add    $0x20,%esp
80108227:	85 c0                	test   %eax,%eax
80108229:	78 1b                	js     80108246 <copyuvm+0xf3>
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010822b:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108232:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108235:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108238:	0f 82 3f ff ff ff    	jb     8010817d <copyuvm+0x2a>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
  }
  return d;
8010823e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108241:	eb 17                	jmp    8010825a <copyuvm+0x107>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
80108243:	90                   	nop
80108244:	eb 01                	jmp    80108247 <copyuvm+0xf4>
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
80108246:	90                   	nop
  }
  return d;

bad:
  freevm(d);
80108247:	83 ec 0c             	sub    $0xc,%esp
8010824a:	ff 75 f0             	pushl  -0x10(%ebp)
8010824d:	e8 20 fe ff ff       	call   80108072 <freevm>
80108252:	83 c4 10             	add    $0x10,%esp
  return 0;
80108255:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010825a:	c9                   	leave  
8010825b:	c3                   	ret    

8010825c <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
8010825c:	55                   	push   %ebp
8010825d:	89 e5                	mov    %esp,%ebp
8010825f:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108262:	83 ec 04             	sub    $0x4,%esp
80108265:	6a 00                	push   $0x0
80108267:	ff 75 0c             	pushl  0xc(%ebp)
8010826a:	ff 75 08             	pushl  0x8(%ebp)
8010826d:	e8 a3 f7 ff ff       	call   80107a15 <walkpgdir>
80108272:	83 c4 10             	add    $0x10,%esp
80108275:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
80108278:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010827b:	8b 00                	mov    (%eax),%eax
8010827d:	83 e0 01             	and    $0x1,%eax
80108280:	85 c0                	test   %eax,%eax
80108282:	75 07                	jne    8010828b <uva2ka+0x2f>
    return 0;
80108284:	b8 00 00 00 00       	mov    $0x0,%eax
80108289:	eb 29                	jmp    801082b4 <uva2ka+0x58>
  if((*pte & PTE_U) == 0)
8010828b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010828e:	8b 00                	mov    (%eax),%eax
80108290:	83 e0 04             	and    $0x4,%eax
80108293:	85 c0                	test   %eax,%eax
80108295:	75 07                	jne    8010829e <uva2ka+0x42>
    return 0;
80108297:	b8 00 00 00 00       	mov    $0x0,%eax
8010829c:	eb 16                	jmp    801082b4 <uva2ka+0x58>
  return (char*)p2v(PTE_ADDR(*pte));
8010829e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082a1:	8b 00                	mov    (%eax),%eax
801082a3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082a8:	83 ec 0c             	sub    $0xc,%esp
801082ab:	50                   	push   %eax
801082ac:	e8 e2 f2 ff ff       	call   80107593 <p2v>
801082b1:	83 c4 10             	add    $0x10,%esp
}
801082b4:	c9                   	leave  
801082b5:	c3                   	ret    

801082b6 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801082b6:	55                   	push   %ebp
801082b7:	89 e5                	mov    %esp,%ebp
801082b9:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
801082bc:	8b 45 10             	mov    0x10(%ebp),%eax
801082bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
801082c2:	eb 7f                	jmp    80108343 <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
801082c4:	8b 45 0c             	mov    0xc(%ebp),%eax
801082c7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
801082cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
801082d2:	83 ec 08             	sub    $0x8,%esp
801082d5:	50                   	push   %eax
801082d6:	ff 75 08             	pushl  0x8(%ebp)
801082d9:	e8 7e ff ff ff       	call   8010825c <uva2ka>
801082de:	83 c4 10             	add    $0x10,%esp
801082e1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
801082e4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801082e8:	75 07                	jne    801082f1 <copyout+0x3b>
      return -1;
801082ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801082ef:	eb 61                	jmp    80108352 <copyout+0x9c>
    n = PGSIZE - (va - va0);
801082f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801082f4:	2b 45 0c             	sub    0xc(%ebp),%eax
801082f7:	05 00 10 00 00       	add    $0x1000,%eax
801082fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
801082ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108302:	3b 45 14             	cmp    0x14(%ebp),%eax
80108305:	76 06                	jbe    8010830d <copyout+0x57>
      n = len;
80108307:	8b 45 14             	mov    0x14(%ebp),%eax
8010830a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
8010830d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108310:	2b 45 ec             	sub    -0x14(%ebp),%eax
80108313:	89 c2                	mov    %eax,%edx
80108315:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108318:	01 d0                	add    %edx,%eax
8010831a:	83 ec 04             	sub    $0x4,%esp
8010831d:	ff 75 f0             	pushl  -0x10(%ebp)
80108320:	ff 75 f4             	pushl  -0xc(%ebp)
80108323:	50                   	push   %eax
80108324:	e8 69 ce ff ff       	call   80105192 <memmove>
80108329:	83 c4 10             	add    $0x10,%esp
    len -= n;
8010832c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010832f:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
80108332:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108335:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
80108338:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010833b:	05 00 10 00 00       	add    $0x1000,%eax
80108340:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108343:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80108347:	0f 85 77 ff ff ff    	jne    801082c4 <copyout+0xe>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010834d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108352:	c9                   	leave  
80108353:	c3                   	ret    

80108354 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
80108354:	55                   	push   %ebp
80108355:	89 e5                	mov    %esp,%ebp
80108357:	83 ec 1c             	sub    $0x1c,%esp
8010835a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010835d:	8b 55 10             	mov    0x10(%ebp),%edx
80108360:	8b 45 14             	mov    0x14(%ebp),%eax
80108363:	88 4d ec             	mov    %cl,-0x14(%ebp)
80108366:	88 55 e8             	mov    %dl,-0x18(%ebp)
80108369:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
8010836c:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80108370:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
80108373:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
80108377:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
8010837a:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
8010837e:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
80108381:	8b 45 08             	mov    0x8(%ebp),%eax
80108384:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
80108388:	66 89 10             	mov    %dx,(%eax)
8010838b:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
8010838f:	88 50 02             	mov    %dl,0x2(%eax)
}
80108392:	8b 45 08             	mov    0x8(%ebp),%eax
80108395:	c9                   	leave  
80108396:	c2 04 00             	ret    $0x4

80108399 <APCharacterMove>:
int character_pre_x, character_pre_y = 1;
int character_x,character_y = 1;


void APCharacterMove(int direction)
{
80108399:	55                   	push   %ebp
8010839a:	89 e5                	mov    %esp,%ebp
{

}


}
8010839c:	90                   	nop
8010839d:	5d                   	pop    %ebp
8010839e:	c3                   	ret    

8010839f <APDrawCharacter>:

//character_move
void APDrawCharacter(int is_grid)
{
8010839f:	55                   	push   %ebp
801083a0:	89 e5                	mov    %esp,%ebp
801083a2:	56                   	push   %esi
801083a3:	53                   	push   %ebx
801083a4:	83 ec 20             	sub    $0x20,%esp
    acquire(&screenLock);
801083a7:	83 ec 0c             	sub    $0xc,%esp
801083aa:	68 40 57 11 80       	push   $0x80115740
801083af:	e8 bc ca ff ff       	call   80104e70 <acquire>
801083b4:	83 c4 10             	add    $0x10,%esp
    if (is_grid)
801083b7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801083bb:	0f 84 a0 01 00 00    	je     80108561 <APDrawCharacter+0x1c2>
    {
        int off = (character_pre_y * GRID_WIDTH + WND_TITLE_HEIGHT)* screenWidth + character_pre_x * GRID_WIDTH;
801083c1:	a1 00 e5 10 80       	mov    0x8010e500,%eax
801083c6:	83 c0 01             	add    $0x1,%eax
801083c9:	6b d0 32             	imul   $0x32,%eax,%edx
801083cc:	0f b7 05 74 e6 10 80 	movzwl 0x8010e674,%eax
801083d3:	0f b7 c0             	movzwl %ax,%eax
801083d6:	0f af d0             	imul   %eax,%edx
801083d9:	a1 94 78 11 80       	mov    0x80117894,%eax
801083de:	6b c0 32             	imul   $0x32,%eax,%eax
801083e1:	01 d0                	add    %edx,%eax
801083e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
        int size = sizeof(AColor) * GRID_WIDTH;
801083e6:	c7 45 e4 96 00 00 00 	movl   $0x96,-0x1c(%ebp)
        for (int j = 0; j < GRID_WIDTH; j++)
801083ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801083f4:	eb 77                	jmp    8010846d <APDrawCharacter+0xce>
        {
            memmove(screenBuf + off, screenContent + off,size);
801083f6:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801083f9:	8b 1d 88 e6 10 80    	mov    0x8010e688,%ebx
801083ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108402:	89 d0                	mov    %edx,%eax
80108404:	01 c0                	add    %eax,%eax
80108406:	01 d0                	add    %edx,%eax
80108408:	01 c3                	add    %eax,%ebx
8010840a:	8b 35 84 e6 10 80    	mov    0x8010e684,%esi
80108410:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108413:	89 d0                	mov    %edx,%eax
80108415:	01 c0                	add    %eax,%eax
80108417:	01 d0                	add    %edx,%eax
80108419:	01 f0                	add    %esi,%eax
8010841b:	83 ec 04             	sub    $0x4,%esp
8010841e:	51                   	push   %ecx
8010841f:	53                   	push   %ebx
80108420:	50                   	push   %eax
80108421:	e8 6c cd ff ff       	call   80105192 <memmove>
80108426:	83 c4 10             	add    $0x10,%esp
            memmove(screenAddr + off,screenContent + off,size);
80108429:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010842c:	8b 1d 88 e6 10 80    	mov    0x8010e688,%ebx
80108432:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108435:	89 d0                	mov    %edx,%eax
80108437:	01 c0                	add    %eax,%eax
80108439:	01 d0                	add    %edx,%eax
8010843b:	01 c3                	add    %eax,%ebx
8010843d:	8b 35 80 e6 10 80    	mov    0x8010e680,%esi
80108443:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108446:	89 d0                	mov    %edx,%eax
80108448:	01 c0                	add    %eax,%eax
8010844a:	01 d0                	add    %edx,%eax
8010844c:	01 f0                	add    %esi,%eax
8010844e:	83 ec 04             	sub    $0x4,%esp
80108451:	51                   	push   %ecx
80108452:	53                   	push   %ebx
80108453:	50                   	push   %eax
80108454:	e8 39 cd ff ff       	call   80105192 <memmove>
80108459:	83 c4 10             	add    $0x10,%esp
            off += screenWidth;
8010845c:	0f b7 05 74 e6 10 80 	movzwl 0x8010e674,%eax
80108463:	0f b7 c0             	movzwl %ax,%eax
80108466:	01 45 f4             	add    %eax,-0xc(%ebp)
    acquire(&screenLock);
    if (is_grid)
    {
        int off = (character_pre_y * GRID_WIDTH + WND_TITLE_HEIGHT)* screenWidth + character_pre_x * GRID_WIDTH;
        int size = sizeof(AColor) * GRID_WIDTH;
        for (int j = 0; j < GRID_WIDTH; j++)
80108469:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010846d:	83 7d f0 31          	cmpl   $0x31,-0x10(%ebp)
80108471:	7e 83                	jle    801083f6 <APDrawCharacter+0x57>
        {
            memmove(screenBuf + off, screenContent + off,size);
            memmove(screenAddr + off,screenContent + off,size);
            off += screenWidth;
        }
        off = character_y * GRID_WIDTH * screenWidth + character_x * GRID_WIDTH;
80108473:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80108478:	6b d0 32             	imul   $0x32,%eax,%edx
8010847b:	0f b7 05 74 e6 10 80 	movzwl 0x8010e674,%eax
80108482:	0f b7 c0             	movzwl %ax,%eax
80108485:	0f af d0             	imul   %eax,%edx
80108488:	a1 60 bb 11 80       	mov    0x8011bb60,%eax
8010848d:	6b c0 32             	imul   $0x32,%eax,%eax
80108490:	01 d0                	add    %edx,%eax
80108492:	89 45 f4             	mov    %eax,-0xc(%ebp)
        for (int j = 0; j < GRID_WIDTH; j++)
80108495:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
8010849c:	e9 b6 00 00 00       	jmp    80108557 <APDrawCharacter+0x1b8>
        {
            for (int i = 0; i < GRID_WIDTH; i++)
801084a1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
801084a8:	e9 8f 00 00 00       	jmp    8010853c <APDrawCharacter+0x19d>
            {
                AColor c = character_img[i][j];
801084ad:	8b 55 ec             	mov    -0x14(%ebp),%edx
801084b0:	8b 4d e8             	mov    -0x18(%ebp),%ecx
801084b3:	89 d0                	mov    %edx,%eax
801084b5:	01 c0                	add    %eax,%eax
801084b7:	01 d0                	add    %edx,%eax
801084b9:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801084bf:	01 d0                	add    %edx,%eax
801084c1:	05 a0 78 11 80       	add    $0x801178a0,%eax
801084c6:	0f b7 10             	movzwl (%eax),%edx
801084c9:	66 89 55 e1          	mov    %dx,-0x1f(%ebp)
801084cd:	0f b6 40 02          	movzbl 0x2(%eax),%eax
801084d1:	88 45 e3             	mov    %al,-0x1d(%ebp)
                if (c.r != COLOR_TRANSPARENT || c.g != COLOR_TRANSPARENT || c.b != COLOR_TRANSPARENT)
801084d4:	0f b6 45 e3          	movzbl -0x1d(%ebp),%eax
801084d8:	3c 0c                	cmp    $0xc,%al
801084da:	75 10                	jne    801084ec <APDrawCharacter+0x14d>
801084dc:	0f b6 45 e2          	movzbl -0x1e(%ebp),%eax
801084e0:	3c 0c                	cmp    $0xc,%al
801084e2:	75 08                	jne    801084ec <APDrawCharacter+0x14d>
801084e4:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
801084e8:	3c 0c                	cmp    $0xc,%al
801084ea:	74 4c                	je     80108538 <APDrawCharacter+0x199>
                {
                    screenBuf[off + i] = c;
801084ec:	8b 15 84 e6 10 80    	mov    0x8010e684,%edx
801084f2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801084f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
801084f8:	01 c8                	add    %ecx,%eax
801084fa:	89 c1                	mov    %eax,%ecx
801084fc:	89 c8                	mov    %ecx,%eax
801084fe:	01 c0                	add    %eax,%eax
80108500:	01 c8                	add    %ecx,%eax
80108502:	01 d0                	add    %edx,%eax
80108504:	0f b7 55 e1          	movzwl -0x1f(%ebp),%edx
80108508:	66 89 10             	mov    %dx,(%eax)
8010850b:	0f b6 55 e3          	movzbl -0x1d(%ebp),%edx
8010850f:	88 50 02             	mov    %dl,0x2(%eax)
                    screenAddr[off + i] = c;
80108512:	8b 15 80 e6 10 80    	mov    0x8010e680,%edx
80108518:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010851b:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010851e:	01 c8                	add    %ecx,%eax
80108520:	89 c1                	mov    %eax,%ecx
80108522:	89 c8                	mov    %ecx,%eax
80108524:	01 c0                	add    %eax,%eax
80108526:	01 c8                	add    %ecx,%eax
80108528:	01 d0                	add    %edx,%eax
8010852a:	0f b7 55 e1          	movzwl -0x1f(%ebp),%edx
8010852e:	66 89 10             	mov    %dx,(%eax)
80108531:	0f b6 55 e3          	movzbl -0x1d(%ebp),%edx
80108535:	88 50 02             	mov    %dl,0x2(%eax)
            off += screenWidth;
        }
        off = character_y * GRID_WIDTH * screenWidth + character_x * GRID_WIDTH;
        for (int j = 0; j < GRID_WIDTH; j++)
        {
            for (int i = 0; i < GRID_WIDTH; i++)
80108538:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
8010853c:	83 7d e8 31          	cmpl   $0x31,-0x18(%ebp)
80108540:	0f 8e 67 ff ff ff    	jle    801084ad <APDrawCharacter+0x10e>
                {
                    screenBuf[off + i] = c;
                    screenAddr[off + i] = c;
                }
            }
            off += screenWidth;
80108546:	0f b7 05 74 e6 10 80 	movzwl 0x8010e674,%eax
8010854d:	0f b7 c0             	movzwl %ax,%eax
80108550:	01 45 f4             	add    %eax,-0xc(%ebp)
            memmove(screenBuf + off, screenContent + off,size);
            memmove(screenAddr + off,screenContent + off,size);
            off += screenWidth;
        }
        off = character_y * GRID_WIDTH * screenWidth + character_x * GRID_WIDTH;
        for (int j = 0; j < GRID_WIDTH; j++)
80108553:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80108557:	83 7d ec 31          	cmpl   $0x31,-0x14(%ebp)
8010855b:	0f 8e 40 ff ff ff    	jle    801084a1 <APDrawCharacter+0x102>
                }
            }
            off += screenWidth;
        }
    }
    release(&screenLock);
80108561:	83 ec 0c             	sub    $0xc,%esp
80108564:	68 40 57 11 80       	push   $0x80115740
80108569:	e8 69 c9 ff ff       	call   80104ed7 <release>
8010856e:	83 c4 10             	add    $0x10,%esp
}
80108571:	90                   	nop
80108572:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108575:	5b                   	pop    %ebx
80108576:	5e                   	pop    %esi
80108577:	5d                   	pop    %ebp
80108578:	c3                   	ret    

80108579 <APCharacterInit>:
ATimerList timerList;

int timerListReady = 0;

void APCharacterInit(void)
{
80108579:	55                   	push   %ebp
8010857a:	89 e5                	mov    %esp,%ebp
8010857c:	53                   	push   %ebx
8010857d:	81 ec b4 00 00 00    	sub    $0xb4,%esp
    for (int j = 0; j < GRID_WIDTH; j++)
80108583:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010858a:	e9 a4 00 00 00       	jmp    80108633 <APCharacterInit+0xba>
        for (int i = 0; i < GRID_WIDTH; i++)
8010858f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80108596:	e9 8a 00 00 00       	jmp    80108625 <APCharacterInit+0xac>
        {
            character_img[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
8010859b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010859e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801085a1:	89 d0                	mov    %edx,%eax
801085a3:	01 c0                	add    %eax,%eax
801085a5:	01 d0                	add    %edx,%eax
801085a7:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801085ad:	01 d0                	add    %edx,%eax
801085af:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801085b5:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801085bb:	6a 0c                	push   $0xc
801085bd:	6a 0c                	push   $0xc
801085bf:	6a 0c                	push   $0xc
801085c1:	50                   	push   %eax
801085c2:	e8 8d fd ff ff       	call   80108354 <RGB>
801085c7:	83 c4 0c             	add    $0xc,%esp
801085ca:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801085d1:	66 89 03             	mov    %ax,(%ebx)
801085d4:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801085db:	88 43 02             	mov    %al,0x2(%ebx)
            character_img2[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
801085de:	8b 55 f4             	mov    -0xc(%ebp),%edx
801085e1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801085e4:	89 d0                	mov    %edx,%eax
801085e6:	01 c0                	add    %eax,%eax
801085e8:	01 d0                	add    %edx,%eax
801085ea:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801085f0:	01 d0                	add    %edx,%eax
801085f2:	8d 98 00 96 11 80    	lea    -0x7fee6a00(%eax),%ebx
801085f8:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801085fe:	6a 0c                	push   $0xc
80108600:	6a 0c                	push   $0xc
80108602:	6a 0c                	push   $0xc
80108604:	50                   	push   %eax
80108605:	e8 4a fd ff ff       	call   80108354 <RGB>
8010860a:	83 c4 0c             	add    $0xc,%esp
8010860d:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108614:	66 89 03             	mov    %ax,(%ebx)
80108617:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010861e:	88 43 02             	mov    %al,0x2(%ebx)
int timerListReady = 0;

void APCharacterInit(void)
{
    for (int j = 0; j < GRID_WIDTH; j++)
        for (int i = 0; i < GRID_WIDTH; i++)
80108621:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80108625:	83 7d f0 31          	cmpl   $0x31,-0x10(%ebp)
80108629:	0f 8e 6c ff ff ff    	jle    8010859b <APCharacterInit+0x22>

int timerListReady = 0;

void APCharacterInit(void)
{
    for (int j = 0; j < GRID_WIDTH; j++)
8010862f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108633:	83 7d f4 31          	cmpl   $0x31,-0xc(%ebp)
80108637:	0f 8e 52 ff ff ff    	jle    8010858f <APCharacterInit+0x16>
            character_img[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
            character_img2[i][j] = RGB(COLOR_TRANSPARENT,COLOR_TRANSPARENT,COLOR_TRANSPARENT);
        }
    //

    int line=0;
8010863d:	c7 85 64 ff ff ff 00 	movl   $0x0,-0x9c(%ebp)
80108644:	00 00 00 
  
    for(int j=line;j<line+3;j++)
80108647:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010864d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108650:	eb 5d                	jmp    801086af <APCharacterInit+0x136>
	for(int i=10;i<25;i++)
80108652:	c7 45 e8 0a 00 00 00 	movl   $0xa,-0x18(%ebp)
80108659:	eb 4a                	jmp    801086a5 <APCharacterInit+0x12c>
		character_img[i][j] = RGB(0xff,0x00,0x00);
8010865b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010865e:	8b 4d e8             	mov    -0x18(%ebp),%ecx
80108661:	89 d0                	mov    %edx,%eax
80108663:	01 c0                	add    %eax,%eax
80108665:	01 d0                	add    %edx,%eax
80108667:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010866d:	01 d0                	add    %edx,%eax
8010866f:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108675:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010867b:	6a 00                	push   $0x0
8010867d:	6a 00                	push   $0x0
8010867f:	68 ff 00 00 00       	push   $0xff
80108684:	50                   	push   %eax
80108685:	e8 ca fc ff ff       	call   80108354 <RGB>
8010868a:	83 c4 0c             	add    $0xc,%esp
8010868d:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108694:	66 89 03             	mov    %ax,(%ebx)
80108697:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010869e:	88 43 02             	mov    %al,0x2(%ebx)
    //

    int line=0;
  
    for(int j=line;j<line+3;j++)
	for(int i=10;i<25;i++)
801086a1:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
801086a5:	83 7d e8 18          	cmpl   $0x18,-0x18(%ebp)
801086a9:	7e b0                	jle    8010865b <APCharacterInit+0xe2>
        }
    //

    int line=0;
  
    for(int j=line;j<line+3;j++)
801086ab:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801086af:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801086b5:	83 c0 03             	add    $0x3,%eax
801086b8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801086bb:	7f 95                	jg     80108652 <APCharacterInit+0xd9>
	for(int i=10;i<25;i++)
		character_img[i][j] = RGB(0xff,0x00,0x00);
    line=line+3;
801086bd:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
    for(int j=line;j<line+3;j++)
801086c4:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801086ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801086cd:	eb 5d                	jmp    8010872c <APCharacterInit+0x1b3>
        for(int i=5;i<40;i++)
801086cf:	c7 45 e0 05 00 00 00 	movl   $0x5,-0x20(%ebp)
801086d6:	eb 4a                	jmp    80108722 <APCharacterInit+0x1a9>
            character_img[i][j] = RGB(0xff,0x00,0x00);
801086d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801086db:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801086de:	89 d0                	mov    %edx,%eax
801086e0:	01 c0                	add    %eax,%eax
801086e2:	01 d0                	add    %edx,%eax
801086e4:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801086ea:	01 d0                	add    %edx,%eax
801086ec:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801086f2:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801086f8:	6a 00                	push   $0x0
801086fa:	6a 00                	push   $0x0
801086fc:	68 ff 00 00 00       	push   $0xff
80108701:	50                   	push   %eax
80108702:	e8 4d fc ff ff       	call   80108354 <RGB>
80108707:	83 c4 0c             	add    $0xc,%esp
8010870a:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108711:	66 89 03             	mov    %ax,(%ebx)
80108714:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010871b:	88 43 02             	mov    %al,0x2(%ebx)
    for(int j=line;j<line+3;j++)
	for(int i=10;i<25;i++)
		character_img[i][j] = RGB(0xff,0x00,0x00);
    line=line+3;
    for(int j=line;j<line+3;j++)
        for(int i=5;i<40;i++)
8010871e:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
80108722:	83 7d e0 27          	cmpl   $0x27,-0x20(%ebp)
80108726:	7e b0                	jle    801086d8 <APCharacterInit+0x15f>
  
    for(int j=line;j<line+3;j++)
	for(int i=10;i<25;i++)
		character_img[i][j] = RGB(0xff,0x00,0x00);
    line=line+3;
    for(int j=line;j<line+3;j++)
80108728:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010872c:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108732:	83 c0 03             	add    $0x3,%eax
80108735:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
80108738:	7f 95                	jg     801086cf <APCharacterInit+0x156>
        for(int i=5;i<40;i++)
            character_img[i][j] = RGB(0xff,0x00,0x00);

    line=line+3;
8010873a:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)

    for(int j=line;j<line+3;j++){
80108741:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108747:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010874a:	e9 78 01 00 00       	jmp    801088c7 <APCharacterInit+0x34e>
        for(int i=5;i<30;i++){
8010874f:	c7 45 d8 05 00 00 00 	movl   $0x5,-0x28(%ebp)
80108756:	e9 5e 01 00 00       	jmp    801088b9 <APCharacterInit+0x340>
               if(i<15)
8010875b:	83 7d d8 0e          	cmpl   $0xe,-0x28(%ebp)
8010875f:	7f 4b                	jg     801087ac <APCharacterInit+0x233>
			character_img[i][j] = RGB(128,64,0);
80108761:	8b 55 dc             	mov    -0x24(%ebp),%edx
80108764:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80108767:	89 d0                	mov    %edx,%eax
80108769:	01 c0                	add    %eax,%eax
8010876b:	01 d0                	add    %edx,%eax
8010876d:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108773:	01 d0                	add    %edx,%eax
80108775:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
8010877b:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108781:	6a 00                	push   $0x0
80108783:	6a 40                	push   $0x40
80108785:	68 80 00 00 00       	push   $0x80
8010878a:	50                   	push   %eax
8010878b:	e8 c4 fb ff ff       	call   80108354 <RGB>
80108790:	83 c4 0c             	add    $0xc,%esp
80108793:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010879a:	66 89 03             	mov    %ax,(%ebx)
8010879d:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801087a4:	88 43 02             	mov    %al,0x2(%ebx)
801087a7:	e9 09 01 00 00       	jmp    801088b5 <APCharacterInit+0x33c>
		else if(i>=15&&i<22)
801087ac:	83 7d d8 0e          	cmpl   $0xe,-0x28(%ebp)
801087b0:	7e 57                	jle    80108809 <APCharacterInit+0x290>
801087b2:	83 7d d8 15          	cmpl   $0x15,-0x28(%ebp)
801087b6:	7f 51                	jg     80108809 <APCharacterInit+0x290>
			character_img[i][j] = RGB(249,236,236);
801087b8:	8b 55 dc             	mov    -0x24(%ebp),%edx
801087bb:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801087be:	89 d0                	mov    %edx,%eax
801087c0:	01 c0                	add    %eax,%eax
801087c2:	01 d0                	add    %edx,%eax
801087c4:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801087ca:	01 d0                	add    %edx,%eax
801087cc:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801087d2:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801087d8:	68 ec 00 00 00       	push   $0xec
801087dd:	68 ec 00 00 00       	push   $0xec
801087e2:	68 f9 00 00 00       	push   $0xf9
801087e7:	50                   	push   %eax
801087e8:	e8 67 fb ff ff       	call   80108354 <RGB>
801087ed:	83 c4 0c             	add    $0xc,%esp
801087f0:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801087f7:	66 89 03             	mov    %ax,(%ebx)
801087fa:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108801:	88 43 02             	mov    %al,0x2(%ebx)
80108804:	e9 ac 00 00 00       	jmp    801088b5 <APCharacterInit+0x33c>
		else if(i>=22&&i<26)
80108809:	83 7d d8 15          	cmpl   $0x15,-0x28(%ebp)
8010880d:	7e 4e                	jle    8010885d <APCharacterInit+0x2e4>
8010880f:	83 7d d8 19          	cmpl   $0x19,-0x28(%ebp)
80108813:	7f 48                	jg     8010885d <APCharacterInit+0x2e4>
			character_img[i][j] = RGB(128,64,0);
80108815:	8b 55 dc             	mov    -0x24(%ebp),%edx
80108818:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010881b:	89 d0                	mov    %edx,%eax
8010881d:	01 c0                	add    %eax,%eax
8010881f:	01 d0                	add    %edx,%eax
80108821:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108827:	01 d0                	add    %edx,%eax
80108829:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
8010882f:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108835:	6a 00                	push   $0x0
80108837:	6a 40                	push   $0x40
80108839:	68 80 00 00 00       	push   $0x80
8010883e:	50                   	push   %eax
8010883f:	e8 10 fb ff ff       	call   80108354 <RGB>
80108844:	83 c4 0c             	add    $0xc,%esp
80108847:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010884e:	66 89 03             	mov    %ax,(%ebx)
80108851:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108858:	88 43 02             	mov    %al,0x2(%ebx)
8010885b:	eb 58                	jmp    801088b5 <APCharacterInit+0x33c>
		else if(i>=26&&i<30)
8010885d:	83 7d d8 19          	cmpl   $0x19,-0x28(%ebp)
80108861:	7e 52                	jle    801088b5 <APCharacterInit+0x33c>
80108863:	83 7d d8 1d          	cmpl   $0x1d,-0x28(%ebp)
80108867:	7f 4c                	jg     801088b5 <APCharacterInit+0x33c>
			character_img[i][j] = RGB(249,236,236);
80108869:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010886c:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010886f:	89 d0                	mov    %edx,%eax
80108871:	01 c0                	add    %eax,%eax
80108873:	01 d0                	add    %edx,%eax
80108875:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010887b:	01 d0                	add    %edx,%eax
8010887d:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108883:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108889:	68 ec 00 00 00       	push   $0xec
8010888e:	68 ec 00 00 00       	push   $0xec
80108893:	68 f9 00 00 00       	push   $0xf9
80108898:	50                   	push   %eax
80108899:	e8 b6 fa ff ff       	call   80108354 <RGB>
8010889e:	83 c4 0c             	add    $0xc,%esp
801088a1:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801088a8:	66 89 03             	mov    %ax,(%ebx)
801088ab:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801088b2:	88 43 02             	mov    %al,0x2(%ebx)
            character_img[i][j] = RGB(0xff,0x00,0x00);

    line=line+3;

    for(int j=line;j<line+3;j++){
        for(int i=5;i<30;i++){
801088b5:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
801088b9:	83 7d d8 1d          	cmpl   $0x1d,-0x28(%ebp)
801088bd:	0f 8e 98 fe ff ff    	jle    8010875b <APCharacterInit+0x1e2>
        for(int i=5;i<40;i++)
            character_img[i][j] = RGB(0xff,0x00,0x00);

    line=line+3;

    for(int j=line;j<line+3;j++){
801088c3:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
801088c7:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801088cd:	83 c0 03             	add    $0x3,%eax
801088d0:	3b 45 dc             	cmp    -0x24(%ebp),%eax
801088d3:	0f 8f 76 fe ff ff    	jg     8010874f <APCharacterInit+0x1d6>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=26&&i<30)
			character_img[i][j] = RGB(249,236,236);

        }}
line=line+3;
801088d9:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
801088e0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801088e6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801088e9:	e9 2c 02 00 00       	jmp    80108b1a <APCharacterInit+0x5a1>
	for(int i=0;i<40;i++){
801088ee:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
801088f5:	e9 12 02 00 00       	jmp    80108b0c <APCharacterInit+0x593>
               if(i<5)
801088fa:	83 7d d0 04          	cmpl   $0x4,-0x30(%ebp)
801088fe:	7f 4b                	jg     8010894b <APCharacterInit+0x3d2>
			character_img[i][j] = RGB(128,64,0);
80108900:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80108903:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80108906:	89 d0                	mov    %edx,%eax
80108908:	01 c0                	add    %eax,%eax
8010890a:	01 d0                	add    %edx,%eax
8010890c:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108912:	01 d0                	add    %edx,%eax
80108914:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
8010891a:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108920:	6a 00                	push   $0x0
80108922:	6a 40                	push   $0x40
80108924:	68 80 00 00 00       	push   $0x80
80108929:	50                   	push   %eax
8010892a:	e8 25 fa ff ff       	call   80108354 <RGB>
8010892f:	83 c4 0c             	add    $0xc,%esp
80108932:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108939:	66 89 03             	mov    %ax,(%ebx)
8010893c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108943:	88 43 02             	mov    %al,0x2(%ebx)
80108946:	e9 bd 01 00 00       	jmp    80108b08 <APCharacterInit+0x58f>
		else if(i>=5&&i<10)
8010894b:	83 7d d0 04          	cmpl   $0x4,-0x30(%ebp)
8010894f:	7e 57                	jle    801089a8 <APCharacterInit+0x42f>
80108951:	83 7d d0 09          	cmpl   $0x9,-0x30(%ebp)
80108955:	7f 51                	jg     801089a8 <APCharacterInit+0x42f>
			character_img[i][j] = RGB(249,236,236);
80108957:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010895a:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010895d:	89 d0                	mov    %edx,%eax
8010895f:	01 c0                	add    %eax,%eax
80108961:	01 d0                	add    %edx,%eax
80108963:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108969:	01 d0                	add    %edx,%eax
8010896b:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108971:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108977:	68 ec 00 00 00       	push   $0xec
8010897c:	68 ec 00 00 00       	push   $0xec
80108981:	68 f9 00 00 00       	push   $0xf9
80108986:	50                   	push   %eax
80108987:	e8 c8 f9 ff ff       	call   80108354 <RGB>
8010898c:	83 c4 0c             	add    $0xc,%esp
8010898f:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108996:	66 89 03             	mov    %ax,(%ebx)
80108999:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801089a0:	88 43 02             	mov    %al,0x2(%ebx)
801089a3:	e9 60 01 00 00       	jmp    80108b08 <APCharacterInit+0x58f>
		else if(i>=10&&i<13)
801089a8:	83 7d d0 09          	cmpl   $0x9,-0x30(%ebp)
801089ac:	7e 51                	jle    801089ff <APCharacterInit+0x486>
801089ae:	83 7d d0 0c          	cmpl   $0xc,-0x30(%ebp)
801089b2:	7f 4b                	jg     801089ff <APCharacterInit+0x486>
			character_img[i][j] = RGB(128,64,0);
801089b4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801089b7:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801089ba:	89 d0                	mov    %edx,%eax
801089bc:	01 c0                	add    %eax,%eax
801089be:	01 d0                	add    %edx,%eax
801089c0:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801089c6:	01 d0                	add    %edx,%eax
801089c8:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801089ce:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801089d4:	6a 00                	push   $0x0
801089d6:	6a 40                	push   $0x40
801089d8:	68 80 00 00 00       	push   $0x80
801089dd:	50                   	push   %eax
801089de:	e8 71 f9 ff ff       	call   80108354 <RGB>
801089e3:	83 c4 0c             	add    $0xc,%esp
801089e6:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801089ed:	66 89 03             	mov    %ax,(%ebx)
801089f0:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801089f7:	88 43 02             	mov    %al,0x2(%ebx)
801089fa:	e9 09 01 00 00       	jmp    80108b08 <APCharacterInit+0x58f>
		else if(i>=13&&i<22)
801089ff:	83 7d d0 0c          	cmpl   $0xc,-0x30(%ebp)
80108a03:	7e 57                	jle    80108a5c <APCharacterInit+0x4e3>
80108a05:	83 7d d0 15          	cmpl   $0x15,-0x30(%ebp)
80108a09:	7f 51                	jg     80108a5c <APCharacterInit+0x4e3>
			character_img[i][j] = RGB(249,236,236);
80108a0b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80108a0e:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80108a11:	89 d0                	mov    %edx,%eax
80108a13:	01 c0                	add    %eax,%eax
80108a15:	01 d0                	add    %edx,%eax
80108a17:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108a1d:	01 d0                	add    %edx,%eax
80108a1f:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108a25:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108a2b:	68 ec 00 00 00       	push   $0xec
80108a30:	68 ec 00 00 00       	push   $0xec
80108a35:	68 f9 00 00 00       	push   $0xf9
80108a3a:	50                   	push   %eax
80108a3b:	e8 14 f9 ff ff       	call   80108354 <RGB>
80108a40:	83 c4 0c             	add    $0xc,%esp
80108a43:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108a4a:	66 89 03             	mov    %ax,(%ebx)
80108a4d:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108a54:	88 43 02             	mov    %al,0x2(%ebx)
80108a57:	e9 ac 00 00 00       	jmp    80108b08 <APCharacterInit+0x58f>
		else if(i>=22&&i<26)
80108a5c:	83 7d d0 15          	cmpl   $0x15,-0x30(%ebp)
80108a60:	7e 4e                	jle    80108ab0 <APCharacterInit+0x537>
80108a62:	83 7d d0 19          	cmpl   $0x19,-0x30(%ebp)
80108a66:	7f 48                	jg     80108ab0 <APCharacterInit+0x537>
			character_img[i][j] = RGB(128,64,0);
80108a68:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80108a6b:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80108a6e:	89 d0                	mov    %edx,%eax
80108a70:	01 c0                	add    %eax,%eax
80108a72:	01 d0                	add    %edx,%eax
80108a74:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108a7a:	01 d0                	add    %edx,%eax
80108a7c:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108a82:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108a88:	6a 00                	push   $0x0
80108a8a:	6a 40                	push   $0x40
80108a8c:	68 80 00 00 00       	push   $0x80
80108a91:	50                   	push   %eax
80108a92:	e8 bd f8 ff ff       	call   80108354 <RGB>
80108a97:	83 c4 0c             	add    $0xc,%esp
80108a9a:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108aa1:	66 89 03             	mov    %ax,(%ebx)
80108aa4:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108aab:	88 43 02             	mov    %al,0x2(%ebx)
80108aae:	eb 58                	jmp    80108b08 <APCharacterInit+0x58f>
		else if(i>=26&&i<35)
80108ab0:	83 7d d0 19          	cmpl   $0x19,-0x30(%ebp)
80108ab4:	7e 52                	jle    80108b08 <APCharacterInit+0x58f>
80108ab6:	83 7d d0 22          	cmpl   $0x22,-0x30(%ebp)
80108aba:	7f 4c                	jg     80108b08 <APCharacterInit+0x58f>
			character_img[i][j] = RGB(249,236,236);
80108abc:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80108abf:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80108ac2:	89 d0                	mov    %edx,%eax
80108ac4:	01 c0                	add    %eax,%eax
80108ac6:	01 d0                	add    %edx,%eax
80108ac8:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108ace:	01 d0                	add    %edx,%eax
80108ad0:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108ad6:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108adc:	68 ec 00 00 00       	push   $0xec
80108ae1:	68 ec 00 00 00       	push   $0xec
80108ae6:	68 f9 00 00 00       	push   $0xf9
80108aeb:	50                   	push   %eax
80108aec:	e8 63 f8 ff ff       	call   80108354 <RGB>
80108af1:	83 c4 0c             	add    $0xc,%esp
80108af4:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108afb:	66 89 03             	mov    %ax,(%ebx)
80108afe:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108b05:	88 43 02             	mov    %al,0x2(%ebx)
			character_img[i][j] = RGB(249,236,236);

        }}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80108b08:	83 45 d0 01          	addl   $0x1,-0x30(%ebp)
80108b0c:	83 7d d0 27          	cmpl   $0x27,-0x30(%ebp)
80108b10:	0f 8e e4 fd ff ff    	jle    801088fa <APCharacterInit+0x381>
		else if(i>=26&&i<30)
			character_img[i][j] = RGB(249,236,236);

        }}
line=line+3;
  for(int j=line;j<line+3;j++){
80108b16:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
80108b1a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108b20:	83 c0 03             	add    $0x3,%eax
80108b23:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
80108b26:	0f 8f c2 fd ff ff    	jg     801088ee <APCharacterInit+0x375>
		else if(i>=22&&i<26)
			character_img[i][j] = RGB(128,64,0);
		else if(i>=26&&i<35)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
80108b2c:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108b33:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108b39:	89 45 cc             	mov    %eax,-0x34(%ebp)
80108b3c:	e9 2c 02 00 00       	jmp    80108d6d <APCharacterInit+0x7f4>
	for(int i=0;i<44;i++){
80108b41:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
80108b48:	e9 12 02 00 00       	jmp    80108d5f <APCharacterInit+0x7e6>
               if(i<5)
80108b4d:	83 7d c8 04          	cmpl   $0x4,-0x38(%ebp)
80108b51:	7f 4b                	jg     80108b9e <APCharacterInit+0x625>
			character_img[i][j] = RGB(128,64,0);
80108b53:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108b56:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108b59:	89 d0                	mov    %edx,%eax
80108b5b:	01 c0                	add    %eax,%eax
80108b5d:	01 d0                	add    %edx,%eax
80108b5f:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108b65:	01 d0                	add    %edx,%eax
80108b67:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108b6d:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108b73:	6a 00                	push   $0x0
80108b75:	6a 40                	push   $0x40
80108b77:	68 80 00 00 00       	push   $0x80
80108b7c:	50                   	push   %eax
80108b7d:	e8 d2 f7 ff ff       	call   80108354 <RGB>
80108b82:	83 c4 0c             	add    $0xc,%esp
80108b85:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108b8c:	66 89 03             	mov    %ax,(%ebx)
80108b8f:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108b96:	88 43 02             	mov    %al,0x2(%ebx)
80108b99:	e9 bd 01 00 00       	jmp    80108d5b <APCharacterInit+0x7e2>
		else if(i>=5&&i<10)
80108b9e:	83 7d c8 04          	cmpl   $0x4,-0x38(%ebp)
80108ba2:	7e 57                	jle    80108bfb <APCharacterInit+0x682>
80108ba4:	83 7d c8 09          	cmpl   $0x9,-0x38(%ebp)
80108ba8:	7f 51                	jg     80108bfb <APCharacterInit+0x682>
			character_img[i][j] = RGB(249,236,236);
80108baa:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108bad:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108bb0:	89 d0                	mov    %edx,%eax
80108bb2:	01 c0                	add    %eax,%eax
80108bb4:	01 d0                	add    %edx,%eax
80108bb6:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108bbc:	01 d0                	add    %edx,%eax
80108bbe:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108bc4:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108bca:	68 ec 00 00 00       	push   $0xec
80108bcf:	68 ec 00 00 00       	push   $0xec
80108bd4:	68 f9 00 00 00       	push   $0xf9
80108bd9:	50                   	push   %eax
80108bda:	e8 75 f7 ff ff       	call   80108354 <RGB>
80108bdf:	83 c4 0c             	add    $0xc,%esp
80108be2:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108be9:	66 89 03             	mov    %ax,(%ebx)
80108bec:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108bf3:	88 43 02             	mov    %al,0x2(%ebx)
80108bf6:	e9 60 01 00 00       	jmp    80108d5b <APCharacterInit+0x7e2>
		else if(i>=10&&i<16)
80108bfb:	83 7d c8 09          	cmpl   $0x9,-0x38(%ebp)
80108bff:	7e 51                	jle    80108c52 <APCharacterInit+0x6d9>
80108c01:	83 7d c8 0f          	cmpl   $0xf,-0x38(%ebp)
80108c05:	7f 4b                	jg     80108c52 <APCharacterInit+0x6d9>
			character_img[i][j] = RGB(128,64,0);
80108c07:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108c0a:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108c0d:	89 d0                	mov    %edx,%eax
80108c0f:	01 c0                	add    %eax,%eax
80108c11:	01 d0                	add    %edx,%eax
80108c13:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108c19:	01 d0                	add    %edx,%eax
80108c1b:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108c21:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108c27:	6a 00                	push   $0x0
80108c29:	6a 40                	push   $0x40
80108c2b:	68 80 00 00 00       	push   $0x80
80108c30:	50                   	push   %eax
80108c31:	e8 1e f7 ff ff       	call   80108354 <RGB>
80108c36:	83 c4 0c             	add    $0xc,%esp
80108c39:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108c40:	66 89 03             	mov    %ax,(%ebx)
80108c43:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108c4a:	88 43 02             	mov    %al,0x2(%ebx)
80108c4d:	e9 09 01 00 00       	jmp    80108d5b <APCharacterInit+0x7e2>
		else if(i>=16&&i<26)
80108c52:	83 7d c8 0f          	cmpl   $0xf,-0x38(%ebp)
80108c56:	7e 57                	jle    80108caf <APCharacterInit+0x736>
80108c58:	83 7d c8 19          	cmpl   $0x19,-0x38(%ebp)
80108c5c:	7f 51                	jg     80108caf <APCharacterInit+0x736>
			character_img[i][j] = RGB(249,236,236);
80108c5e:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108c61:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108c64:	89 d0                	mov    %edx,%eax
80108c66:	01 c0                	add    %eax,%eax
80108c68:	01 d0                	add    %edx,%eax
80108c6a:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108c70:	01 d0                	add    %edx,%eax
80108c72:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108c78:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108c7e:	68 ec 00 00 00       	push   $0xec
80108c83:	68 ec 00 00 00       	push   $0xec
80108c88:	68 f9 00 00 00       	push   $0xf9
80108c8d:	50                   	push   %eax
80108c8e:	e8 c1 f6 ff ff       	call   80108354 <RGB>
80108c93:	83 c4 0c             	add    $0xc,%esp
80108c96:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108c9d:	66 89 03             	mov    %ax,(%ebx)
80108ca0:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108ca7:	88 43 02             	mov    %al,0x2(%ebx)
80108caa:	e9 ac 00 00 00       	jmp    80108d5b <APCharacterInit+0x7e2>
		else if(i>=26&&i<30)
80108caf:	83 7d c8 19          	cmpl   $0x19,-0x38(%ebp)
80108cb3:	7e 4e                	jle    80108d03 <APCharacterInit+0x78a>
80108cb5:	83 7d c8 1d          	cmpl   $0x1d,-0x38(%ebp)
80108cb9:	7f 48                	jg     80108d03 <APCharacterInit+0x78a>
			character_img[i][j] = RGB(128,64,0);
80108cbb:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108cbe:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108cc1:	89 d0                	mov    %edx,%eax
80108cc3:	01 c0                	add    %eax,%eax
80108cc5:	01 d0                	add    %edx,%eax
80108cc7:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108ccd:	01 d0                	add    %edx,%eax
80108ccf:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108cd5:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108cdb:	6a 00                	push   $0x0
80108cdd:	6a 40                	push   $0x40
80108cdf:	68 80 00 00 00       	push   $0x80
80108ce4:	50                   	push   %eax
80108ce5:	e8 6a f6 ff ff       	call   80108354 <RGB>
80108cea:	83 c4 0c             	add    $0xc,%esp
80108ced:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108cf4:	66 89 03             	mov    %ax,(%ebx)
80108cf7:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108cfe:	88 43 02             	mov    %al,0x2(%ebx)
80108d01:	eb 58                	jmp    80108d5b <APCharacterInit+0x7e2>
		else if(i>=30&&i<40)
80108d03:	83 7d c8 1d          	cmpl   $0x1d,-0x38(%ebp)
80108d07:	7e 52                	jle    80108d5b <APCharacterInit+0x7e2>
80108d09:	83 7d c8 27          	cmpl   $0x27,-0x38(%ebp)
80108d0d:	7f 4c                	jg     80108d5b <APCharacterInit+0x7e2>
			character_img[i][j] = RGB(249,236,236);
80108d0f:	8b 55 cc             	mov    -0x34(%ebp),%edx
80108d12:	8b 4d c8             	mov    -0x38(%ebp),%ecx
80108d15:	89 d0                	mov    %edx,%eax
80108d17:	01 c0                	add    %eax,%eax
80108d19:	01 d0                	add    %edx,%eax
80108d1b:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108d21:	01 d0                	add    %edx,%eax
80108d23:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108d29:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108d2f:	68 ec 00 00 00       	push   $0xec
80108d34:	68 ec 00 00 00       	push   $0xec
80108d39:	68 f9 00 00 00       	push   $0xf9
80108d3e:	50                   	push   %eax
80108d3f:	e8 10 f6 ff ff       	call   80108354 <RGB>
80108d44:	83 c4 0c             	add    $0xc,%esp
80108d47:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108d4e:	66 89 03             	mov    %ax,(%ebx)
80108d51:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108d58:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=26&&i<35)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<44;i++){
80108d5b:	83 45 c8 01          	addl   $0x1,-0x38(%ebp)
80108d5f:	83 7d c8 2b          	cmpl   $0x2b,-0x38(%ebp)
80108d63:	0f 8e e4 fd ff ff    	jle    80108b4d <APCharacterInit+0x5d4>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=26&&i<35)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
80108d69:	83 45 cc 01          	addl   $0x1,-0x34(%ebp)
80108d6d:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108d73:	83 c0 03             	add    $0x3,%eax
80108d76:	3b 45 cc             	cmp    -0x34(%ebp),%eax
80108d79:	0f 8f c2 fd ff ff    	jg     80108b41 <APCharacterInit+0x5c8>
		else if(i>=26&&i<30)
			character_img[i][j] = RGB(128,64,0);
		else if(i>=30&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
80108d7f:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108d86:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108d8c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80108d8f:	e9 1b 01 00 00       	jmp    80108eaf <APCharacterInit+0x936>
	for(int i=0;i<40;i++){
80108d94:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
80108d9b:	e9 01 01 00 00       	jmp    80108ea1 <APCharacterInit+0x928>
               if(i<10)
80108da0:	83 7d c0 09          	cmpl   $0x9,-0x40(%ebp)
80108da4:	7f 4b                	jg     80108df1 <APCharacterInit+0x878>
			character_img[i][j] = RGB(128,64,0);
80108da6:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80108da9:	8b 4d c0             	mov    -0x40(%ebp),%ecx
80108dac:	89 d0                	mov    %edx,%eax
80108dae:	01 c0                	add    %eax,%eax
80108db0:	01 d0                	add    %edx,%eax
80108db2:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108db8:	01 d0                	add    %edx,%eax
80108dba:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108dc0:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108dc6:	6a 00                	push   $0x0
80108dc8:	6a 40                	push   $0x40
80108dca:	68 80 00 00 00       	push   $0x80
80108dcf:	50                   	push   %eax
80108dd0:	e8 7f f5 ff ff       	call   80108354 <RGB>
80108dd5:	83 c4 0c             	add    $0xc,%esp
80108dd8:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108ddf:	66 89 03             	mov    %ax,(%ebx)
80108de2:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108de9:	88 43 02             	mov    %al,0x2(%ebx)
80108dec:	e9 ac 00 00 00       	jmp    80108e9d <APCharacterInit+0x924>
		else if(i>=10&&i<22)
80108df1:	83 7d c0 09          	cmpl   $0x9,-0x40(%ebp)
80108df5:	7e 54                	jle    80108e4b <APCharacterInit+0x8d2>
80108df7:	83 7d c0 15          	cmpl   $0x15,-0x40(%ebp)
80108dfb:	7f 4e                	jg     80108e4b <APCharacterInit+0x8d2>
			character_img[i][j] = RGB(249,236,236);
80108dfd:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80108e00:	8b 4d c0             	mov    -0x40(%ebp),%ecx
80108e03:	89 d0                	mov    %edx,%eax
80108e05:	01 c0                	add    %eax,%eax
80108e07:	01 d0                	add    %edx,%eax
80108e09:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108e0f:	01 d0                	add    %edx,%eax
80108e11:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108e17:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108e1d:	68 ec 00 00 00       	push   $0xec
80108e22:	68 ec 00 00 00       	push   $0xec
80108e27:	68 f9 00 00 00       	push   $0xf9
80108e2c:	50                   	push   %eax
80108e2d:	e8 22 f5 ff ff       	call   80108354 <RGB>
80108e32:	83 c4 0c             	add    $0xc,%esp
80108e35:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108e3c:	66 89 03             	mov    %ax,(%ebx)
80108e3f:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108e46:	88 43 02             	mov    %al,0x2(%ebx)
80108e49:	eb 52                	jmp    80108e9d <APCharacterInit+0x924>
		else if(i>=22&&i<35)
80108e4b:	83 7d c0 15          	cmpl   $0x15,-0x40(%ebp)
80108e4f:	7e 4c                	jle    80108e9d <APCharacterInit+0x924>
80108e51:	83 7d c0 22          	cmpl   $0x22,-0x40(%ebp)
80108e55:	7f 46                	jg     80108e9d <APCharacterInit+0x924>
			character_img[i][j] = RGB(128,64,0);
80108e57:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80108e5a:	8b 4d c0             	mov    -0x40(%ebp),%ecx
80108e5d:	89 d0                	mov    %edx,%eax
80108e5f:	01 c0                	add    %eax,%eax
80108e61:	01 d0                	add    %edx,%eax
80108e63:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108e69:	01 d0                	add    %edx,%eax
80108e6b:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108e71:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108e77:	6a 00                	push   $0x0
80108e79:	6a 40                	push   $0x40
80108e7b:	68 80 00 00 00       	push   $0x80
80108e80:	50                   	push   %eax
80108e81:	e8 ce f4 ff ff       	call   80108354 <RGB>
80108e86:	83 c4 0c             	add    $0xc,%esp
80108e89:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108e90:	66 89 03             	mov    %ax,(%ebx)
80108e93:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108e9a:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=30&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80108e9d:	83 45 c0 01          	addl   $0x1,-0x40(%ebp)
80108ea1:	83 7d c0 27          	cmpl   $0x27,-0x40(%ebp)
80108ea5:	0f 8e f5 fe ff ff    	jle    80108da0 <APCharacterInit+0x827>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=30&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line=line+3;
  for(int j=line;j<line+3;j++){
80108eab:	83 45 c4 01          	addl   $0x1,-0x3c(%ebp)
80108eaf:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108eb5:	83 c0 03             	add    $0x3,%eax
80108eb8:	3b 45 c4             	cmp    -0x3c(%ebp),%eax
80108ebb:	0f 8f d3 fe ff ff    	jg     80108d94 <APCharacterInit+0x81b>
			character_img[i][j] = RGB(249,236,236);
		else if(i>=22&&i<35)
			character_img[i][j] = RGB(128,64,0);
		
}}
line=line+3;
80108ec1:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108ec8:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108ece:	89 45 bc             	mov    %eax,-0x44(%ebp)
80108ed1:	eb 69                	jmp    80108f3c <APCharacterInit+0x9c3>
	for(int i=10;i<40;i++){
80108ed3:	c7 45 b8 0a 00 00 00 	movl   $0xa,-0x48(%ebp)
80108eda:	eb 56                	jmp    80108f32 <APCharacterInit+0x9b9>
               if(i<30)
80108edc:	83 7d b8 1d          	cmpl   $0x1d,-0x48(%ebp)
80108ee0:	7f 4c                	jg     80108f2e <APCharacterInit+0x9b5>
			character_img[i][j] = RGB(249,236,236);
80108ee2:	8b 55 bc             	mov    -0x44(%ebp),%edx
80108ee5:	8b 4d b8             	mov    -0x48(%ebp),%ecx
80108ee8:	89 d0                	mov    %edx,%eax
80108eea:	01 c0                	add    %eax,%eax
80108eec:	01 d0                	add    %edx,%eax
80108eee:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108ef4:	01 d0                	add    %edx,%eax
80108ef6:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108efc:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108f02:	68 ec 00 00 00       	push   $0xec
80108f07:	68 ec 00 00 00       	push   $0xec
80108f0c:	68 f9 00 00 00       	push   $0xf9
80108f11:	50                   	push   %eax
80108f12:	e8 3d f4 ff ff       	call   80108354 <RGB>
80108f17:	83 c4 0c             	add    $0xc,%esp
80108f1a:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108f21:	66 89 03             	mov    %ax,(%ebx)
80108f24:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108f2b:	88 43 02             	mov    %al,0x2(%ebx)
			character_img[i][j] = RGB(128,64,0);
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=10;i<40;i++){
80108f2e:	83 45 b8 01          	addl   $0x1,-0x48(%ebp)
80108f32:	83 7d b8 27          	cmpl   $0x27,-0x48(%ebp)
80108f36:	7e a4                	jle    80108edc <APCharacterInit+0x963>
		else if(i>=22&&i<35)
			character_img[i][j] = RGB(128,64,0);
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
80108f38:	83 45 bc 01          	addl   $0x1,-0x44(%ebp)
80108f3c:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108f42:	83 c0 03             	add    $0x3,%eax
80108f45:	3b 45 bc             	cmp    -0x44(%ebp),%eax
80108f48:	7f 89                	jg     80108ed3 <APCharacterInit+0x95a>
               if(i<30)
			character_img[i][j] = RGB(249,236,236);
		
		
}}
line=line+3;
80108f4a:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80108f51:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80108f57:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80108f5a:	e9 15 01 00 00       	jmp    80109074 <APCharacterInit+0xafb>
	for(int i=5;i<40;i++){
80108f5f:	c7 45 b0 05 00 00 00 	movl   $0x5,-0x50(%ebp)
80108f66:	e9 fb 00 00 00       	jmp    80109066 <APCharacterInit+0xaed>
               if(i<11)
80108f6b:	83 7d b0 0a          	cmpl   $0xa,-0x50(%ebp)
80108f6f:	7f 4b                	jg     80108fbc <APCharacterInit+0xa43>
			character_img[i][j] = RGB(128,64,0);
80108f71:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80108f74:	8b 4d b0             	mov    -0x50(%ebp),%ecx
80108f77:	89 d0                	mov    %edx,%eax
80108f79:	01 c0                	add    %eax,%eax
80108f7b:	01 d0                	add    %edx,%eax
80108f7d:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108f83:	01 d0                	add    %edx,%eax
80108f85:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108f8b:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108f91:	6a 00                	push   $0x0
80108f93:	6a 40                	push   $0x40
80108f95:	68 80 00 00 00       	push   $0x80
80108f9a:	50                   	push   %eax
80108f9b:	e8 b4 f3 ff ff       	call   80108354 <RGB>
80108fa0:	83 c4 0c             	add    $0xc,%esp
80108fa3:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80108faa:	66 89 03             	mov    %ax,(%ebx)
80108fad:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80108fb4:	88 43 02             	mov    %al,0x2(%ebx)
80108fb7:	e9 a6 00 00 00       	jmp    80109062 <APCharacterInit+0xae9>
		else if(i>=11&&i<14)
80108fbc:	83 7d b0 0a          	cmpl   $0xa,-0x50(%ebp)
80108fc0:	7e 4e                	jle    80109010 <APCharacterInit+0xa97>
80108fc2:	83 7d b0 0d          	cmpl   $0xd,-0x50(%ebp)
80108fc6:	7f 48                	jg     80109010 <APCharacterInit+0xa97>
			character_img[i][j] = RGB(255,0,0);	
80108fc8:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80108fcb:	8b 4d b0             	mov    -0x50(%ebp),%ecx
80108fce:	89 d0                	mov    %edx,%eax
80108fd0:	01 c0                	add    %eax,%eax
80108fd2:	01 d0                	add    %edx,%eax
80108fd4:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80108fda:	01 d0                	add    %edx,%eax
80108fdc:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80108fe2:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80108fe8:	6a 00                	push   $0x0
80108fea:	6a 00                	push   $0x0
80108fec:	68 ff 00 00 00       	push   $0xff
80108ff1:	50                   	push   %eax
80108ff2:	e8 5d f3 ff ff       	call   80108354 <RGB>
80108ff7:	83 c4 0c             	add    $0xc,%esp
80108ffa:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109001:	66 89 03             	mov    %ax,(%ebx)
80109004:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010900b:	88 43 02             	mov    %al,0x2(%ebx)
8010900e:	eb 52                	jmp    80109062 <APCharacterInit+0xae9>
		else if(i>=14&&i<25)
80109010:	83 7d b0 0d          	cmpl   $0xd,-0x50(%ebp)
80109014:	7e 4c                	jle    80109062 <APCharacterInit+0xae9>
80109016:	83 7d b0 18          	cmpl   $0x18,-0x50(%ebp)
8010901a:	7f 46                	jg     80109062 <APCharacterInit+0xae9>
			character_img[i][j] = RGB(128,64,0);
8010901c:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010901f:	8b 4d b0             	mov    -0x50(%ebp),%ecx
80109022:	89 d0                	mov    %edx,%eax
80109024:	01 c0                	add    %eax,%eax
80109026:	01 d0                	add    %edx,%eax
80109028:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010902e:	01 d0                	add    %edx,%eax
80109030:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80109036:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010903c:	6a 00                	push   $0x0
8010903e:	6a 40                	push   $0x40
80109040:	68 80 00 00 00       	push   $0x80
80109045:	50                   	push   %eax
80109046:	e8 09 f3 ff ff       	call   80108354 <RGB>
8010904b:	83 c4 0c             	add    $0xc,%esp
8010904e:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109055:	66 89 03             	mov    %ax,(%ebx)
80109058:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010905f:	88 43 02             	mov    %al,0x2(%ebx)
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=5;i<40;i++){
80109062:	83 45 b0 01          	addl   $0x1,-0x50(%ebp)
80109066:	83 7d b0 27          	cmpl   $0x27,-0x50(%ebp)
8010906a:	0f 8e fb fe ff ff    	jle    80108f6b <APCharacterInit+0x9f2>
			character_img[i][j] = RGB(249,236,236);
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
80109070:	83 45 b4 01          	addl   $0x1,-0x4c(%ebp)
80109074:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010907a:	83 c0 03             	add    $0x3,%eax
8010907d:	3b 45 b4             	cmp    -0x4c(%ebp),%eax
80109080:	0f 8f d9 fe ff ff    	jg     80108f5f <APCharacterInit+0x9e6>
		else if(i>=14&&i<25)
			character_img[i][j] = RGB(128,64,0);
		
		
}}
line=line+3;
80109086:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
8010908d:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109093:	89 45 ac             	mov    %eax,-0x54(%ebp)
80109096:	e9 c3 01 00 00       	jmp    8010925e <APCharacterInit+0xce5>
	for(int i=3;i<40;i++){
8010909b:	c7 45 a8 03 00 00 00 	movl   $0x3,-0x58(%ebp)
801090a2:	e9 a9 01 00 00       	jmp    80109250 <APCharacterInit+0xcd7>
               if(i<11)
801090a7:	83 7d a8 0a          	cmpl   $0xa,-0x58(%ebp)
801090ab:	7f 4b                	jg     801090f8 <APCharacterInit+0xb7f>
			character_img[i][j] = RGB(128,64,0);
801090ad:	8b 55 ac             	mov    -0x54(%ebp),%edx
801090b0:	8b 4d a8             	mov    -0x58(%ebp),%ecx
801090b3:	89 d0                	mov    %edx,%eax
801090b5:	01 c0                	add    %eax,%eax
801090b7:	01 d0                	add    %edx,%eax
801090b9:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801090bf:	01 d0                	add    %edx,%eax
801090c1:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801090c7:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801090cd:	6a 00                	push   $0x0
801090cf:	6a 40                	push   $0x40
801090d1:	68 80 00 00 00       	push   $0x80
801090d6:	50                   	push   %eax
801090d7:	e8 78 f2 ff ff       	call   80108354 <RGB>
801090dc:	83 c4 0c             	add    $0xc,%esp
801090df:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801090e6:	66 89 03             	mov    %ax,(%ebx)
801090e9:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801090f0:	88 43 02             	mov    %al,0x2(%ebx)
801090f3:	e9 54 01 00 00       	jmp    8010924c <APCharacterInit+0xcd3>
		else if(i>=11&&i<14)
801090f8:	83 7d a8 0a          	cmpl   $0xa,-0x58(%ebp)
801090fc:	7e 51                	jle    8010914f <APCharacterInit+0xbd6>
801090fe:	83 7d a8 0d          	cmpl   $0xd,-0x58(%ebp)
80109102:	7f 4b                	jg     8010914f <APCharacterInit+0xbd6>
			character_img[i][j] = RGB(255,0,0);
80109104:	8b 55 ac             	mov    -0x54(%ebp),%edx
80109107:	8b 4d a8             	mov    -0x58(%ebp),%ecx
8010910a:	89 d0                	mov    %edx,%eax
8010910c:	01 c0                	add    %eax,%eax
8010910e:	01 d0                	add    %edx,%eax
80109110:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109116:	01 d0                	add    %edx,%eax
80109118:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
8010911e:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109124:	6a 00                	push   $0x0
80109126:	6a 00                	push   $0x0
80109128:	68 ff 00 00 00       	push   $0xff
8010912d:	50                   	push   %eax
8010912e:	e8 21 f2 ff ff       	call   80108354 <RGB>
80109133:	83 c4 0c             	add    $0xc,%esp
80109136:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010913d:	66 89 03             	mov    %ax,(%ebx)
80109140:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109147:	88 43 02             	mov    %al,0x2(%ebx)
8010914a:	e9 fd 00 00 00       	jmp    8010924c <APCharacterInit+0xcd3>
		else if(i>=14&&i<22)
8010914f:	83 7d a8 0d          	cmpl   $0xd,-0x58(%ebp)
80109153:	7e 51                	jle    801091a6 <APCharacterInit+0xc2d>
80109155:	83 7d a8 15          	cmpl   $0x15,-0x58(%ebp)
80109159:	7f 4b                	jg     801091a6 <APCharacterInit+0xc2d>
			character_img[i][j] = RGB(128,64,0);
8010915b:	8b 55 ac             	mov    -0x54(%ebp),%edx
8010915e:	8b 4d a8             	mov    -0x58(%ebp),%ecx
80109161:	89 d0                	mov    %edx,%eax
80109163:	01 c0                	add    %eax,%eax
80109165:	01 d0                	add    %edx,%eax
80109167:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010916d:	01 d0                	add    %edx,%eax
8010916f:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80109175:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010917b:	6a 00                	push   $0x0
8010917d:	6a 40                	push   $0x40
8010917f:	68 80 00 00 00       	push   $0x80
80109184:	50                   	push   %eax
80109185:	e8 ca f1 ff ff       	call   80108354 <RGB>
8010918a:	83 c4 0c             	add    $0xc,%esp
8010918d:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109194:	66 89 03             	mov    %ax,(%ebx)
80109197:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010919e:	88 43 02             	mov    %al,0x2(%ebx)
801091a1:	e9 a6 00 00 00       	jmp    8010924c <APCharacterInit+0xcd3>
		else if(i>=22&&i<25)
801091a6:	83 7d a8 15          	cmpl   $0x15,-0x58(%ebp)
801091aa:	7e 4e                	jle    801091fa <APCharacterInit+0xc81>
801091ac:	83 7d a8 18          	cmpl   $0x18,-0x58(%ebp)
801091b0:	7f 48                	jg     801091fa <APCharacterInit+0xc81>
			character_img[i][j] = RGB(255,0,0);
801091b2:	8b 55 ac             	mov    -0x54(%ebp),%edx
801091b5:	8b 4d a8             	mov    -0x58(%ebp),%ecx
801091b8:	89 d0                	mov    %edx,%eax
801091ba:	01 c0                	add    %eax,%eax
801091bc:	01 d0                	add    %edx,%eax
801091be:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801091c4:	01 d0                	add    %edx,%eax
801091c6:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801091cc:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801091d2:	6a 00                	push   $0x0
801091d4:	6a 00                	push   $0x0
801091d6:	68 ff 00 00 00       	push   $0xff
801091db:	50                   	push   %eax
801091dc:	e8 73 f1 ff ff       	call   80108354 <RGB>
801091e1:	83 c4 0c             	add    $0xc,%esp
801091e4:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801091eb:	66 89 03             	mov    %ax,(%ebx)
801091ee:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801091f5:	88 43 02             	mov    %al,0x2(%ebx)
801091f8:	eb 52                	jmp    8010924c <APCharacterInit+0xcd3>
		else if(i>=25&&i<35)
801091fa:	83 7d a8 18          	cmpl   $0x18,-0x58(%ebp)
801091fe:	7e 4c                	jle    8010924c <APCharacterInit+0xcd3>
80109200:	83 7d a8 22          	cmpl   $0x22,-0x58(%ebp)
80109204:	7f 46                	jg     8010924c <APCharacterInit+0xcd3>
			character_img[i][j] = RGB(128,64,0);
80109206:	8b 55 ac             	mov    -0x54(%ebp),%edx
80109209:	8b 4d a8             	mov    -0x58(%ebp),%ecx
8010920c:	89 d0                	mov    %edx,%eax
8010920e:	01 c0                	add    %eax,%eax
80109210:	01 d0                	add    %edx,%eax
80109212:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109218:	01 d0                	add    %edx,%eax
8010921a:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80109220:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109226:	6a 00                	push   $0x0
80109228:	6a 40                	push   $0x40
8010922a:	68 80 00 00 00       	push   $0x80
8010922f:	50                   	push   %eax
80109230:	e8 1f f1 ff ff       	call   80108354 <RGB>
80109235:	83 c4 0c             	add    $0xc,%esp
80109238:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010923f:	66 89 03             	mov    %ax,(%ebx)
80109242:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109249:	88 43 02             	mov    %al,0x2(%ebx)
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=3;i<40;i++){
8010924c:	83 45 a8 01          	addl   $0x1,-0x58(%ebp)
80109250:	83 7d a8 27          	cmpl   $0x27,-0x58(%ebp)
80109254:	0f 8e 4d fe ff ff    	jle    801090a7 <APCharacterInit+0xb2e>
			character_img[i][j] = RGB(128,64,0);
		
		
}}
line=line+3;
  for(int j=line;j<line+3;j++){
8010925a:	83 45 ac 01          	addl   $0x1,-0x54(%ebp)
8010925e:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109264:	83 c0 03             	add    $0x3,%eax
80109267:	3b 45 ac             	cmp    -0x54(%ebp),%eax
8010926a:	0f 8f 2b fe ff ff    	jg     8010909b <APCharacterInit+0xb22>
		else if(i>=22&&i<25)
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<35)
			character_img[i][j] = RGB(128,64,0);
        
    }}line=line+3;
80109270:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
  for(int j=line;j<line+3;j++){
80109277:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010927d:	89 45 a4             	mov    %eax,-0x5c(%ebp)
80109280:	e9 15 01 00 00       	jmp    8010939a <APCharacterInit+0xe21>
	for(int i=0;i<40;i++){
80109285:	c7 45 a0 00 00 00 00 	movl   $0x0,-0x60(%ebp)
8010928c:	e9 fb 00 00 00       	jmp    8010938c <APCharacterInit+0xe13>
               if(i<11)
80109291:	83 7d a0 0a          	cmpl   $0xa,-0x60(%ebp)
80109295:	7f 4b                	jg     801092e2 <APCharacterInit+0xd69>
			character_img[i][j] = RGB(128,64,0);
80109297:	8b 55 a4             	mov    -0x5c(%ebp),%edx
8010929a:	8b 4d a0             	mov    -0x60(%ebp),%ecx
8010929d:	89 d0                	mov    %edx,%eax
8010929f:	01 c0                	add    %eax,%eax
801092a1:	01 d0                	add    %edx,%eax
801092a3:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801092a9:	01 d0                	add    %edx,%eax
801092ab:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801092b1:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801092b7:	6a 00                	push   $0x0
801092b9:	6a 40                	push   $0x40
801092bb:	68 80 00 00 00       	push   $0x80
801092c0:	50                   	push   %eax
801092c1:	e8 8e f0 ff ff       	call   80108354 <RGB>
801092c6:	83 c4 0c             	add    $0xc,%esp
801092c9:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801092d0:	66 89 03             	mov    %ax,(%ebx)
801092d3:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801092da:	88 43 02             	mov    %al,0x2(%ebx)
801092dd:	e9 a6 00 00 00       	jmp    80109388 <APCharacterInit+0xe0f>
		else if(i>=11&&i<25)
801092e2:	83 7d a0 0a          	cmpl   $0xa,-0x60(%ebp)
801092e6:	7e 4e                	jle    80109336 <APCharacterInit+0xdbd>
801092e8:	83 7d a0 18          	cmpl   $0x18,-0x60(%ebp)
801092ec:	7f 48                	jg     80109336 <APCharacterInit+0xdbd>
			character_img[i][j] = RGB(255,0,0);
801092ee:	8b 55 a4             	mov    -0x5c(%ebp),%edx
801092f1:	8b 4d a0             	mov    -0x60(%ebp),%ecx
801092f4:	89 d0                	mov    %edx,%eax
801092f6:	01 c0                	add    %eax,%eax
801092f8:	01 d0                	add    %edx,%eax
801092fa:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109300:	01 d0                	add    %edx,%eax
80109302:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80109308:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010930e:	6a 00                	push   $0x0
80109310:	6a 00                	push   $0x0
80109312:	68 ff 00 00 00       	push   $0xff
80109317:	50                   	push   %eax
80109318:	e8 37 f0 ff ff       	call   80108354 <RGB>
8010931d:	83 c4 0c             	add    $0xc,%esp
80109320:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109327:	66 89 03             	mov    %ax,(%ebx)
8010932a:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109331:	88 43 02             	mov    %al,0x2(%ebx)
80109334:	eb 52                	jmp    80109388 <APCharacterInit+0xe0f>
		else if(i>=25&&i<40)
80109336:	83 7d a0 18          	cmpl   $0x18,-0x60(%ebp)
8010933a:	7e 4c                	jle    80109388 <APCharacterInit+0xe0f>
8010933c:	83 7d a0 27          	cmpl   $0x27,-0x60(%ebp)
80109340:	7f 46                	jg     80109388 <APCharacterInit+0xe0f>
			character_img[i][j] = RGB(128,64,0);
80109342:	8b 55 a4             	mov    -0x5c(%ebp),%edx
80109345:	8b 4d a0             	mov    -0x60(%ebp),%ecx
80109348:	89 d0                	mov    %edx,%eax
8010934a:	01 c0                	add    %eax,%eax
8010934c:	01 d0                	add    %edx,%eax
8010934e:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109354:	01 d0                	add    %edx,%eax
80109356:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
8010935c:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109362:	6a 00                	push   $0x0
80109364:	6a 40                	push   $0x40
80109366:	68 80 00 00 00       	push   $0x80
8010936b:	50                   	push   %eax
8010936c:	e8 e3 ef ff ff       	call   80108354 <RGB>
80109371:	83 c4 0c             	add    $0xc,%esp
80109374:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010937b:	66 89 03             	mov    %ax,(%ebx)
8010937e:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109385:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=25&&i<35)
			character_img[i][j] = RGB(128,64,0);
        
    }}line=line+3;
  for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109388:	83 45 a0 01          	addl   $0x1,-0x60(%ebp)
8010938c:	83 7d a0 27          	cmpl   $0x27,-0x60(%ebp)
80109390:	0f 8e fb fe ff ff    	jle    80109291 <APCharacterInit+0xd18>
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<35)
			character_img[i][j] = RGB(128,64,0);
        
    }}line=line+3;
  for(int j=line;j<line+3;j++){
80109396:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
8010939a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801093a0:	83 c0 03             	add    $0x3,%eax
801093a3:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
801093a6:	0f 8f d9 fe ff ff    	jg     80109285 <APCharacterInit+0xd0c>
		else if(i>=11&&i<25)
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<40)
			character_img[i][j] = RGB(128,64,0);
}}
line =line +3;
801093ac:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
801093b3:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801093b9:	89 45 9c             	mov    %eax,-0x64(%ebp)
801093bc:	e9 37 03 00 00       	jmp    801096f8 <APCharacterInit+0x117f>
	for(int i=0;i<40;i++){
801093c1:	c7 45 98 00 00 00 00 	movl   $0x0,-0x68(%ebp)
801093c8:	e9 1d 03 00 00       	jmp    801096ea <APCharacterInit+0x1171>
               if(i<5)
801093cd:	83 7d 98 04          	cmpl   $0x4,-0x68(%ebp)
801093d1:	7f 51                	jg     80109424 <APCharacterInit+0xeab>
			character_img[i][j] = RGB(249,236,236);
801093d3:	8b 55 9c             	mov    -0x64(%ebp),%edx
801093d6:	8b 4d 98             	mov    -0x68(%ebp),%ecx
801093d9:	89 d0                	mov    %edx,%eax
801093db:	01 c0                	add    %eax,%eax
801093dd:	01 d0                	add    %edx,%eax
801093df:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801093e5:	01 d0                	add    %edx,%eax
801093e7:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801093ed:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801093f3:	68 ec 00 00 00       	push   $0xec
801093f8:	68 ec 00 00 00       	push   $0xec
801093fd:	68 f9 00 00 00       	push   $0xf9
80109402:	50                   	push   %eax
80109403:	e8 4c ef ff ff       	call   80108354 <RGB>
80109408:	83 c4 0c             	add    $0xc,%esp
8010940b:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109412:	66 89 03             	mov    %ax,(%ebx)
80109415:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010941c:	88 43 02             	mov    %al,0x2(%ebx)
8010941f:	e9 c2 02 00 00       	jmp    801096e6 <APCharacterInit+0x116d>
		else if(i>=5&&i<8)
80109424:	83 7d 98 04          	cmpl   $0x4,-0x68(%ebp)
80109428:	7e 51                	jle    8010947b <APCharacterInit+0xf02>
8010942a:	83 7d 98 07          	cmpl   $0x7,-0x68(%ebp)
8010942e:	7f 4b                	jg     8010947b <APCharacterInit+0xf02>
			character_img[i][j] = RGB(128,64,0);
80109430:	8b 55 9c             	mov    -0x64(%ebp),%edx
80109433:	8b 4d 98             	mov    -0x68(%ebp),%ecx
80109436:	89 d0                	mov    %edx,%eax
80109438:	01 c0                	add    %eax,%eax
8010943a:	01 d0                	add    %edx,%eax
8010943c:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109442:	01 d0                	add    %edx,%eax
80109444:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
8010944a:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109450:	6a 00                	push   $0x0
80109452:	6a 40                	push   $0x40
80109454:	68 80 00 00 00       	push   $0x80
80109459:	50                   	push   %eax
8010945a:	e8 f5 ee ff ff       	call   80108354 <RGB>
8010945f:	83 c4 0c             	add    $0xc,%esp
80109462:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109469:	66 89 03             	mov    %ax,(%ebx)
8010946c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109473:	88 43 02             	mov    %al,0x2(%ebx)
80109476:	e9 6b 02 00 00       	jmp    801096e6 <APCharacterInit+0x116d>
		else if(i>=8&&i<11)
8010947b:	83 7d 98 07          	cmpl   $0x7,-0x68(%ebp)
8010947f:	7e 51                	jle    801094d2 <APCharacterInit+0xf59>
80109481:	83 7d 98 0a          	cmpl   $0xa,-0x68(%ebp)
80109485:	7f 4b                	jg     801094d2 <APCharacterInit+0xf59>
			character_img[i][j] = RGB(255,0,0);
80109487:	8b 55 9c             	mov    -0x64(%ebp),%edx
8010948a:	8b 4d 98             	mov    -0x68(%ebp),%ecx
8010948d:	89 d0                	mov    %edx,%eax
8010948f:	01 c0                	add    %eax,%eax
80109491:	01 d0                	add    %edx,%eax
80109493:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109499:	01 d0                	add    %edx,%eax
8010949b:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801094a1:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801094a7:	6a 00                	push   $0x0
801094a9:	6a 00                	push   $0x0
801094ab:	68 ff 00 00 00       	push   $0xff
801094b0:	50                   	push   %eax
801094b1:	e8 9e ee ff ff       	call   80108354 <RGB>
801094b6:	83 c4 0c             	add    $0xc,%esp
801094b9:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801094c0:	66 89 03             	mov    %ax,(%ebx)
801094c3:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801094ca:	88 43 02             	mov    %al,0x2(%ebx)
801094cd:	e9 14 02 00 00       	jmp    801096e6 <APCharacterInit+0x116d>
		else if(i>=11&&i<14)
801094d2:	83 7d 98 0a          	cmpl   $0xa,-0x68(%ebp)
801094d6:	7e 57                	jle    8010952f <APCharacterInit+0xfb6>
801094d8:	83 7d 98 0d          	cmpl   $0xd,-0x68(%ebp)
801094dc:	7f 51                	jg     8010952f <APCharacterInit+0xfb6>
			character_img[i][j] = RGB(249,236,236);
801094de:	8b 55 9c             	mov    -0x64(%ebp),%edx
801094e1:	8b 4d 98             	mov    -0x68(%ebp),%ecx
801094e4:	89 d0                	mov    %edx,%eax
801094e6:	01 c0                	add    %eax,%eax
801094e8:	01 d0                	add    %edx,%eax
801094ea:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801094f0:	01 d0                	add    %edx,%eax
801094f2:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801094f8:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801094fe:	68 ec 00 00 00       	push   $0xec
80109503:	68 ec 00 00 00       	push   $0xec
80109508:	68 f9 00 00 00       	push   $0xf9
8010950d:	50                   	push   %eax
8010950e:	e8 41 ee ff ff       	call   80108354 <RGB>
80109513:	83 c4 0c             	add    $0xc,%esp
80109516:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010951d:	66 89 03             	mov    %ax,(%ebx)
80109520:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109527:	88 43 02             	mov    %al,0x2(%ebx)
8010952a:	e9 b7 01 00 00       	jmp    801096e6 <APCharacterInit+0x116d>
		else if(i>=14&&i<22)
8010952f:	83 7d 98 0d          	cmpl   $0xd,-0x68(%ebp)
80109533:	7e 51                	jle    80109586 <APCharacterInit+0x100d>
80109535:	83 7d 98 15          	cmpl   $0x15,-0x68(%ebp)
80109539:	7f 4b                	jg     80109586 <APCharacterInit+0x100d>
			character_img[i][j] = RGB(255,0,0);
8010953b:	8b 55 9c             	mov    -0x64(%ebp),%edx
8010953e:	8b 4d 98             	mov    -0x68(%ebp),%ecx
80109541:	89 d0                	mov    %edx,%eax
80109543:	01 c0                	add    %eax,%eax
80109545:	01 d0                	add    %edx,%eax
80109547:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010954d:	01 d0                	add    %edx,%eax
8010954f:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80109555:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010955b:	6a 00                	push   $0x0
8010955d:	6a 00                	push   $0x0
8010955f:	68 ff 00 00 00       	push   $0xff
80109564:	50                   	push   %eax
80109565:	e8 ea ed ff ff       	call   80108354 <RGB>
8010956a:	83 c4 0c             	add    $0xc,%esp
8010956d:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109574:	66 89 03             	mov    %ax,(%ebx)
80109577:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010957e:	88 43 02             	mov    %al,0x2(%ebx)
80109581:	e9 60 01 00 00       	jmp    801096e6 <APCharacterInit+0x116d>
		else if(i>=22&&i<25)
80109586:	83 7d 98 15          	cmpl   $0x15,-0x68(%ebp)
8010958a:	7e 57                	jle    801095e3 <APCharacterInit+0x106a>
8010958c:	83 7d 98 18          	cmpl   $0x18,-0x68(%ebp)
80109590:	7f 51                	jg     801095e3 <APCharacterInit+0x106a>
			character_img[i][j] = RGB(249,236,236);
80109592:	8b 55 9c             	mov    -0x64(%ebp),%edx
80109595:	8b 4d 98             	mov    -0x68(%ebp),%ecx
80109598:	89 d0                	mov    %edx,%eax
8010959a:	01 c0                	add    %eax,%eax
8010959c:	01 d0                	add    %edx,%eax
8010959e:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801095a4:	01 d0                	add    %edx,%eax
801095a6:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801095ac:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801095b2:	68 ec 00 00 00       	push   $0xec
801095b7:	68 ec 00 00 00       	push   $0xec
801095bc:	68 f9 00 00 00       	push   $0xf9
801095c1:	50                   	push   %eax
801095c2:	e8 8d ed ff ff       	call   80108354 <RGB>
801095c7:	83 c4 0c             	add    $0xc,%esp
801095ca:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801095d1:	66 89 03             	mov    %ax,(%ebx)
801095d4:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801095db:	88 43 02             	mov    %al,0x2(%ebx)
801095de:	e9 03 01 00 00       	jmp    801096e6 <APCharacterInit+0x116d>
		else if(i>=25&&i<28)
801095e3:	83 7d 98 18          	cmpl   $0x18,-0x68(%ebp)
801095e7:	7e 51                	jle    8010963a <APCharacterInit+0x10c1>
801095e9:	83 7d 98 1b          	cmpl   $0x1b,-0x68(%ebp)
801095ed:	7f 4b                	jg     8010963a <APCharacterInit+0x10c1>
			character_img[i][j] = RGB(255,0,0);
801095ef:	8b 55 9c             	mov    -0x64(%ebp),%edx
801095f2:	8b 4d 98             	mov    -0x68(%ebp),%ecx
801095f5:	89 d0                	mov    %edx,%eax
801095f7:	01 c0                	add    %eax,%eax
801095f9:	01 d0                	add    %edx,%eax
801095fb:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109601:	01 d0                	add    %edx,%eax
80109603:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80109609:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010960f:	6a 00                	push   $0x0
80109611:	6a 00                	push   $0x0
80109613:	68 ff 00 00 00       	push   $0xff
80109618:	50                   	push   %eax
80109619:	e8 36 ed ff ff       	call   80108354 <RGB>
8010961e:	83 c4 0c             	add    $0xc,%esp
80109621:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109628:	66 89 03             	mov    %ax,(%ebx)
8010962b:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109632:	88 43 02             	mov    %al,0x2(%ebx)
80109635:	e9 ac 00 00 00       	jmp    801096e6 <APCharacterInit+0x116d>
		else if(i>=28&&i<32)
8010963a:	83 7d 98 1b          	cmpl   $0x1b,-0x68(%ebp)
8010963e:	7e 4e                	jle    8010968e <APCharacterInit+0x1115>
80109640:	83 7d 98 1f          	cmpl   $0x1f,-0x68(%ebp)
80109644:	7f 48                	jg     8010968e <APCharacterInit+0x1115>
			character_img[i][j] = RGB(128,64,0);
80109646:	8b 55 9c             	mov    -0x64(%ebp),%edx
80109649:	8b 4d 98             	mov    -0x68(%ebp),%ecx
8010964c:	89 d0                	mov    %edx,%eax
8010964e:	01 c0                	add    %eax,%eax
80109650:	01 d0                	add    %edx,%eax
80109652:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109658:	01 d0                	add    %edx,%eax
8010965a:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80109660:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109666:	6a 00                	push   $0x0
80109668:	6a 40                	push   $0x40
8010966a:	68 80 00 00 00       	push   $0x80
8010966f:	50                   	push   %eax
80109670:	e8 df ec ff ff       	call   80108354 <RGB>
80109675:	83 c4 0c             	add    $0xc,%esp
80109678:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010967f:	66 89 03             	mov    %ax,(%ebx)
80109682:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109689:	88 43 02             	mov    %al,0x2(%ebx)
8010968c:	eb 58                	jmp    801096e6 <APCharacterInit+0x116d>
		else if(i>=32&&i<40)
8010968e:	83 7d 98 1f          	cmpl   $0x1f,-0x68(%ebp)
80109692:	7e 52                	jle    801096e6 <APCharacterInit+0x116d>
80109694:	83 7d 98 27          	cmpl   $0x27,-0x68(%ebp)
80109698:	7f 4c                	jg     801096e6 <APCharacterInit+0x116d>
			character_img[i][j] = RGB(249,236,236);
8010969a:	8b 55 9c             	mov    -0x64(%ebp),%edx
8010969d:	8b 4d 98             	mov    -0x68(%ebp),%ecx
801096a0:	89 d0                	mov    %edx,%eax
801096a2:	01 c0                	add    %eax,%eax
801096a4:	01 d0                	add    %edx,%eax
801096a6:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801096ac:	01 d0                	add    %edx,%eax
801096ae:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801096b4:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801096ba:	68 ec 00 00 00       	push   $0xec
801096bf:	68 ec 00 00 00       	push   $0xec
801096c4:	68 f9 00 00 00       	push   $0xf9
801096c9:	50                   	push   %eax
801096ca:	e8 85 ec ff ff       	call   80108354 <RGB>
801096cf:	83 c4 0c             	add    $0xc,%esp
801096d2:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801096d9:	66 89 03             	mov    %ax,(%ebx)
801096dc:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801096e3:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=25&&i<40)
			character_img[i][j] = RGB(128,64,0);
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
801096e6:	83 45 98 01          	addl   $0x1,-0x68(%ebp)
801096ea:	83 7d 98 27          	cmpl   $0x27,-0x68(%ebp)
801096ee:	0f 8e d9 fc ff ff    	jle    801093cd <APCharacterInit+0xe54>
			character_img[i][j] = RGB(255,0,0);
		else if(i>=25&&i<40)
			character_img[i][j] = RGB(128,64,0);
}}
line =line +3;
for(int j=line;j<line+3;j++){
801096f4:	83 45 9c 01          	addl   $0x1,-0x64(%ebp)
801096f8:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801096fe:	83 c0 03             	add    $0x3,%eax
80109701:	3b 45 9c             	cmp    -0x64(%ebp),%eax
80109704:	0f 8f b7 fc ff ff    	jg     801093c1 <APCharacterInit+0xe48>
		else if(i>=28&&i<32)
			character_img[i][j] = RGB(128,64,0);
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line =line +3;
8010970a:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
80109711:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109717:	89 45 94             	mov    %eax,-0x6c(%ebp)
8010971a:	e9 21 01 00 00       	jmp    80109840 <APCharacterInit+0x12c7>
	for(int i=0;i<40;i++){
8010971f:	c7 45 90 00 00 00 00 	movl   $0x0,-0x70(%ebp)
80109726:	e9 07 01 00 00       	jmp    80109832 <APCharacterInit+0x12b9>
               if(i<8)
8010972b:	83 7d 90 07          	cmpl   $0x7,-0x70(%ebp)
8010972f:	7f 51                	jg     80109782 <APCharacterInit+0x1209>
			character_img[i][j] = RGB(249,236,236);
80109731:	8b 55 94             	mov    -0x6c(%ebp),%edx
80109734:	8b 4d 90             	mov    -0x70(%ebp),%ecx
80109737:	89 d0                	mov    %edx,%eax
80109739:	01 c0                	add    %eax,%eax
8010973b:	01 d0                	add    %edx,%eax
8010973d:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109743:	01 d0                	add    %edx,%eax
80109745:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
8010974b:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109751:	68 ec 00 00 00       	push   $0xec
80109756:	68 ec 00 00 00       	push   $0xec
8010975b:	68 f9 00 00 00       	push   $0xf9
80109760:	50                   	push   %eax
80109761:	e8 ee eb ff ff       	call   80108354 <RGB>
80109766:	83 c4 0c             	add    $0xc,%esp
80109769:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109770:	66 89 03             	mov    %ax,(%ebx)
80109773:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010977a:	88 43 02             	mov    %al,0x2(%ebx)
8010977d:	e9 ac 00 00 00       	jmp    8010982e <APCharacterInit+0x12b5>
		else if(i>=8&&i<28)
80109782:	83 7d 90 07          	cmpl   $0x7,-0x70(%ebp)
80109786:	7e 4e                	jle    801097d6 <APCharacterInit+0x125d>
80109788:	83 7d 90 1b          	cmpl   $0x1b,-0x70(%ebp)
8010978c:	7f 48                	jg     801097d6 <APCharacterInit+0x125d>
			character_img[i][j] = RGB(255,0,0);
8010978e:	8b 55 94             	mov    -0x6c(%ebp),%edx
80109791:	8b 4d 90             	mov    -0x70(%ebp),%ecx
80109794:	89 d0                	mov    %edx,%eax
80109796:	01 c0                	add    %eax,%eax
80109798:	01 d0                	add    %edx,%eax
8010979a:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801097a0:	01 d0                	add    %edx,%eax
801097a2:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801097a8:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801097ae:	6a 00                	push   $0x0
801097b0:	6a 00                	push   $0x0
801097b2:	68 ff 00 00 00       	push   $0xff
801097b7:	50                   	push   %eax
801097b8:	e8 97 eb ff ff       	call   80108354 <RGB>
801097bd:	83 c4 0c             	add    $0xc,%esp
801097c0:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801097c7:	66 89 03             	mov    %ax,(%ebx)
801097ca:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801097d1:	88 43 02             	mov    %al,0x2(%ebx)
801097d4:	eb 58                	jmp    8010982e <APCharacterInit+0x12b5>
		else if(i>=28&&i<40)
801097d6:	83 7d 90 1b          	cmpl   $0x1b,-0x70(%ebp)
801097da:	7e 52                	jle    8010982e <APCharacterInit+0x12b5>
801097dc:	83 7d 90 27          	cmpl   $0x27,-0x70(%ebp)
801097e0:	7f 4c                	jg     8010982e <APCharacterInit+0x12b5>
			character_img[i][j] = RGB(249,236,236);
801097e2:	8b 55 94             	mov    -0x6c(%ebp),%edx
801097e5:	8b 4d 90             	mov    -0x70(%ebp),%ecx
801097e8:	89 d0                	mov    %edx,%eax
801097ea:	01 c0                	add    %eax,%eax
801097ec:	01 d0                	add    %edx,%eax
801097ee:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801097f4:	01 d0                	add    %edx,%eax
801097f6:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801097fc:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109802:	68 ec 00 00 00       	push   $0xec
80109807:	68 ec 00 00 00       	push   $0xec
8010980c:	68 f9 00 00 00       	push   $0xf9
80109811:	50                   	push   %eax
80109812:	e8 3d eb ff ff       	call   80108354 <RGB>
80109817:	83 c4 0c             	add    $0xc,%esp
8010981a:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109821:	66 89 03             	mov    %ax,(%ebx)
80109824:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
8010982b:	88 43 02             	mov    %al,0x2(%ebx)
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
8010982e:	83 45 90 01          	addl   $0x1,-0x70(%ebp)
80109832:	83 7d 90 27          	cmpl   $0x27,-0x70(%ebp)
80109836:	0f 8e ef fe ff ff    	jle    8010972b <APCharacterInit+0x11b2>
			character_img[i][j] = RGB(128,64,0);
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);
}}
line =line +3;
for(int j=line;j<line+3;j++){
8010983c:	83 45 94 01          	addl   $0x1,-0x6c(%ebp)
80109840:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109846:	83 c0 03             	add    $0x3,%eax
80109849:	3b 45 94             	cmp    -0x6c(%ebp),%eax
8010984c:	0f 8f cd fe ff ff    	jg     8010971f <APCharacterInit+0x11a6>
		else if(i>=28&&i<40)
			character_img[i][j] = RGB(249,236,236);

		
}}
line =line +3;
80109852:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
80109859:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010985f:	89 45 8c             	mov    %eax,-0x74(%ebp)
80109862:	e9 21 01 00 00       	jmp    80109988 <APCharacterInit+0x140f>
	for(int i=0;i<40;i++){
80109867:	c7 45 88 00 00 00 00 	movl   $0x0,-0x78(%ebp)
8010986e:	e9 07 01 00 00       	jmp    8010997a <APCharacterInit+0x1401>
               if(i<5)
80109873:	83 7d 88 04          	cmpl   $0x4,-0x78(%ebp)
80109877:	7f 51                	jg     801098ca <APCharacterInit+0x1351>
			character_img[i][j] = RGB(249,236,236);
80109879:	8b 55 8c             	mov    -0x74(%ebp),%edx
8010987c:	8b 4d 88             	mov    -0x78(%ebp),%ecx
8010987f:	89 d0                	mov    %edx,%eax
80109881:	01 c0                	add    %eax,%eax
80109883:	01 d0                	add    %edx,%eax
80109885:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010988b:	01 d0                	add    %edx,%eax
8010988d:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80109893:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109899:	68 ec 00 00 00       	push   $0xec
8010989e:	68 ec 00 00 00       	push   $0xec
801098a3:	68 f9 00 00 00       	push   $0xf9
801098a8:	50                   	push   %eax
801098a9:	e8 a6 ea ff ff       	call   80108354 <RGB>
801098ae:	83 c4 0c             	add    $0xc,%esp
801098b1:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
801098b8:	66 89 03             	mov    %ax,(%ebx)
801098bb:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
801098c2:	88 43 02             	mov    %al,0x2(%ebx)
801098c5:	e9 ac 00 00 00       	jmp    80109976 <APCharacterInit+0x13fd>
	
		else if(i>=5&&i<32)
801098ca:	83 7d 88 04          	cmpl   $0x4,-0x78(%ebp)
801098ce:	7e 4e                	jle    8010991e <APCharacterInit+0x13a5>
801098d0:	83 7d 88 1f          	cmpl   $0x1f,-0x78(%ebp)
801098d4:	7f 48                	jg     8010991e <APCharacterInit+0x13a5>
			character_img[i][j] = RGB(255,0,0);
801098d6:	8b 55 8c             	mov    -0x74(%ebp),%edx
801098d9:	8b 4d 88             	mov    -0x78(%ebp),%ecx
801098dc:	89 d0                	mov    %edx,%eax
801098de:	01 c0                	add    %eax,%eax
801098e0:	01 d0                	add    %edx,%eax
801098e2:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801098e8:	01 d0                	add    %edx,%eax
801098ea:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801098f0:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801098f6:	6a 00                	push   $0x0
801098f8:	6a 00                	push   $0x0
801098fa:	68 ff 00 00 00       	push   $0xff
801098ff:	50                   	push   %eax
80109900:	e8 4f ea ff ff       	call   80108354 <RGB>
80109905:	83 c4 0c             	add    $0xc,%esp
80109908:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
8010990f:	66 89 03             	mov    %ax,(%ebx)
80109912:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109919:	88 43 02             	mov    %al,0x2(%ebx)
8010991c:	eb 58                	jmp    80109976 <APCharacterInit+0x13fd>
		
		else if(i>=32&&i<40)
8010991e:	83 7d 88 1f          	cmpl   $0x1f,-0x78(%ebp)
80109922:	7e 52                	jle    80109976 <APCharacterInit+0x13fd>
80109924:	83 7d 88 27          	cmpl   $0x27,-0x78(%ebp)
80109928:	7f 4c                	jg     80109976 <APCharacterInit+0x13fd>
			character_img[i][j] = RGB(249,236,236);
8010992a:	8b 55 8c             	mov    -0x74(%ebp),%edx
8010992d:	8b 4d 88             	mov    -0x78(%ebp),%ecx
80109930:	89 d0                	mov    %edx,%eax
80109932:	01 c0                	add    %eax,%eax
80109934:	01 d0                	add    %edx,%eax
80109936:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
8010993c:	01 d0                	add    %edx,%eax
8010993e:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80109944:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
8010994a:	68 ec 00 00 00       	push   $0xec
8010994f:	68 ec 00 00 00       	push   $0xec
80109954:	68 f9 00 00 00       	push   $0xf9
80109959:	50                   	push   %eax
8010995a:	e8 f5 e9 ff ff       	call   80108354 <RGB>
8010995f:	83 c4 0c             	add    $0xc,%esp
80109962:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109969:	66 89 03             	mov    %ax,(%ebx)
8010996c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109973:	88 43 02             	mov    %al,0x2(%ebx)

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109976:	83 45 88 01          	addl   $0x1,-0x78(%ebp)
8010997a:	83 7d 88 27          	cmpl   $0x27,-0x78(%ebp)
8010997e:	0f 8e ef fe ff ff    	jle    80109873 <APCharacterInit+0x12fa>
			character_img[i][j] = RGB(249,236,236);

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
80109984:	83 45 8c 01          	addl   $0x1,-0x74(%ebp)
80109988:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010998e:	83 c0 03             	add    $0x3,%eax
80109991:	3b 45 8c             	cmp    -0x74(%ebp),%eax
80109994:	0f 8f cd fe ff ff    	jg     80109867 <APCharacterInit+0x12ee>
		
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);

		
}}line =line +3;
8010999a:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
801099a1:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801099a7:	89 45 84             	mov    %eax,-0x7c(%ebp)
801099aa:	e9 c4 00 00 00       	jmp    80109a73 <APCharacterInit+0x14fa>
	for(int i=0;i<40;i++){
801099af:	c7 45 80 00 00 00 00 	movl   $0x0,-0x80(%ebp)
801099b6:	e9 aa 00 00 00       	jmp    80109a65 <APCharacterInit+0x14ec>
               if(i>=5&&i<14)
801099bb:	83 7d 80 04          	cmpl   $0x4,-0x80(%ebp)
801099bf:	7e 4e                	jle    80109a0f <APCharacterInit+0x1496>
801099c1:	83 7d 80 0d          	cmpl   $0xd,-0x80(%ebp)
801099c5:	7f 48                	jg     80109a0f <APCharacterInit+0x1496>
			character_img[i][j] = RGB(255,0,0);
801099c7:	8b 55 84             	mov    -0x7c(%ebp),%edx
801099ca:	8b 4d 80             	mov    -0x80(%ebp),%ecx
801099cd:	89 d0                	mov    %edx,%eax
801099cf:	01 c0                	add    %eax,%eax
801099d1:	01 d0                	add    %edx,%eax
801099d3:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
801099d9:	01 d0                	add    %edx,%eax
801099db:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
801099e1:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
801099e7:	6a 00                	push   $0x0
801099e9:	6a 00                	push   $0x0
801099eb:	68 ff 00 00 00       	push   $0xff
801099f0:	50                   	push   %eax
801099f1:	e8 5e e9 ff ff       	call   80108354 <RGB>
801099f6:	83 c4 0c             	add    $0xc,%esp
801099f9:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109a00:	66 89 03             	mov    %ax,(%ebx)
80109a03:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109a0a:	88 43 02             	mov    %al,0x2(%ebx)
80109a0d:	eb 52                	jmp    80109a61 <APCharacterInit+0x14e8>
		
		else if(i>=22&&i<32)
80109a0f:	83 7d 80 15          	cmpl   $0x15,-0x80(%ebp)
80109a13:	7e 4c                	jle    80109a61 <APCharacterInit+0x14e8>
80109a15:	83 7d 80 1f          	cmpl   $0x1f,-0x80(%ebp)
80109a19:	7f 46                	jg     80109a61 <APCharacterInit+0x14e8>
			character_img[i][j] = RGB(255,0,0);
80109a1b:	8b 55 84             	mov    -0x7c(%ebp),%edx
80109a1e:	8b 4d 80             	mov    -0x80(%ebp),%ecx
80109a21:	89 d0                	mov    %edx,%eax
80109a23:	01 c0                	add    %eax,%eax
80109a25:	01 d0                	add    %edx,%eax
80109a27:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109a2d:	01 d0                	add    %edx,%eax
80109a2f:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80109a35:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109a3b:	6a 00                	push   $0x0
80109a3d:	6a 00                	push   $0x0
80109a3f:	68 ff 00 00 00       	push   $0xff
80109a44:	50                   	push   %eax
80109a45:	e8 0a e9 ff ff       	call   80108354 <RGB>
80109a4a:	83 c4 0c             	add    $0xc,%esp
80109a4d:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109a54:	66 89 03             	mov    %ax,(%ebx)
80109a57:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109a5e:	88 43 02             	mov    %al,0x2(%ebx)
			character_img[i][j] = RGB(249,236,236);

		
}}line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109a61:	83 45 80 01          	addl   $0x1,-0x80(%ebp)
80109a65:	83 7d 80 27          	cmpl   $0x27,-0x80(%ebp)
80109a69:	0f 8e 4c ff ff ff    	jle    801099bb <APCharacterInit+0x1442>
		else if(i>=32&&i<40)
			character_img[i][j] = RGB(249,236,236);

		
}}line =line +3;
for(int j=line;j<line+3;j++){
80109a6f:	83 45 84 01          	addl   $0x1,-0x7c(%ebp)
80109a73:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109a79:	83 c0 03             	add    $0x3,%eax
80109a7c:	3b 45 84             	cmp    -0x7c(%ebp),%eax
80109a7f:	0f 8f 2a ff ff ff    	jg     801099af <APCharacterInit+0x1436>
		else if(i>=22&&i<32)
			character_img[i][j] = RGB(255,0,0);

		
}}
 line =line +3;
80109a85:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
80109a8c:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109a92:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
80109a98:	e9 e8 00 00 00       	jmp    80109b85 <APCharacterInit+0x160c>
	for(int i=0;i<40;i++){
80109a9d:	c7 85 78 ff ff ff 00 	movl   $0x0,-0x88(%ebp)
80109aa4:	00 00 00 
80109aa7:	e9 c5 00 00 00       	jmp    80109b71 <APCharacterInit+0x15f8>
               if(i>=2&&i<11)
80109aac:	83 bd 78 ff ff ff 01 	cmpl   $0x1,-0x88(%ebp)
80109ab3:	7e 57                	jle    80109b0c <APCharacterInit+0x1593>
80109ab5:	83 bd 78 ff ff ff 0a 	cmpl   $0xa,-0x88(%ebp)
80109abc:	7f 4e                	jg     80109b0c <APCharacterInit+0x1593>
			character_img[i][j] = RGB(128,64,0);
80109abe:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
80109ac4:	8b 8d 78 ff ff ff    	mov    -0x88(%ebp),%ecx
80109aca:	89 d0                	mov    %edx,%eax
80109acc:	01 c0                	add    %eax,%eax
80109ace:	01 d0                	add    %edx,%eax
80109ad0:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109ad6:	01 d0                	add    %edx,%eax
80109ad8:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80109ade:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109ae4:	6a 00                	push   $0x0
80109ae6:	6a 40                	push   $0x40
80109ae8:	68 80 00 00 00       	push   $0x80
80109aed:	50                   	push   %eax
80109aee:	e8 61 e8 ff ff       	call   80108354 <RGB>
80109af3:	83 c4 0c             	add    $0xc,%esp
80109af6:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109afd:	66 89 03             	mov    %ax,(%ebx)
80109b00:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109b07:	88 43 02             	mov    %al,0x2(%ebx)
80109b0a:	eb 5e                	jmp    80109b6a <APCharacterInit+0x15f1>
		
		else if(i>=25&&i<34)
80109b0c:	83 bd 78 ff ff ff 18 	cmpl   $0x18,-0x88(%ebp)
80109b13:	7e 55                	jle    80109b6a <APCharacterInit+0x15f1>
80109b15:	83 bd 78 ff ff ff 21 	cmpl   $0x21,-0x88(%ebp)
80109b1c:	7f 4c                	jg     80109b6a <APCharacterInit+0x15f1>
			character_img[i][j] = RGB(128,64,0);
80109b1e:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
80109b24:	8b 8d 78 ff ff ff    	mov    -0x88(%ebp),%ecx
80109b2a:	89 d0                	mov    %edx,%eax
80109b2c:	01 c0                	add    %eax,%eax
80109b2e:	01 d0                	add    %edx,%eax
80109b30:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109b36:	01 d0                	add    %edx,%eax
80109b38:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80109b3e:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109b44:	6a 00                	push   $0x0
80109b46:	6a 40                	push   $0x40
80109b48:	68 80 00 00 00       	push   $0x80
80109b4d:	50                   	push   %eax
80109b4e:	e8 01 e8 ff ff       	call   80108354 <RGB>
80109b53:	83 c4 0c             	add    $0xc,%esp
80109b56:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109b5d:	66 89 03             	mov    %ax,(%ebx)
80109b60:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109b67:	88 43 02             	mov    %al,0x2(%ebx)

		
}}
 line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109b6a:	83 85 78 ff ff ff 01 	addl   $0x1,-0x88(%ebp)
80109b71:	83 bd 78 ff ff ff 27 	cmpl   $0x27,-0x88(%ebp)
80109b78:	0f 8e 2e ff ff ff    	jle    80109aac <APCharacterInit+0x1533>
			character_img[i][j] = RGB(255,0,0);

		
}}
 line =line +3;
for(int j=line;j<line+3;j++){
80109b7e:	83 85 7c ff ff ff 01 	addl   $0x1,-0x84(%ebp)
80109b85:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109b8b:	83 c0 03             	add    $0x3,%eax
80109b8e:	3b 85 7c ff ff ff    	cmp    -0x84(%ebp),%eax
80109b94:	0f 8f 03 ff ff ff    	jg     80109a9d <APCharacterInit+0x1524>
		else if(i>=25&&i<34)
			character_img[i][j] = RGB(128,64,0);

		
}}
line =line +3;
80109b9a:	83 85 64 ff ff ff 03 	addl   $0x3,-0x9c(%ebp)
for(int j=line;j<line+3;j++){
80109ba1:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109ba7:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
80109bad:	e9 df 00 00 00       	jmp    80109c91 <APCharacterInit+0x1718>
	for(int i=0;i<40;i++){
80109bb2:	c7 85 70 ff ff ff 00 	movl   $0x0,-0x90(%ebp)
80109bb9:	00 00 00 
80109bbc:	e9 bc 00 00 00       	jmp    80109c7d <APCharacterInit+0x1704>
               if(i<11)
80109bc1:	83 bd 70 ff ff ff 0a 	cmpl   $0xa,-0x90(%ebp)
80109bc8:	7f 4e                	jg     80109c18 <APCharacterInit+0x169f>
			character_img[i][j] = RGB(128,64,0);
80109bca:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
80109bd0:	8b 8d 70 ff ff ff    	mov    -0x90(%ebp),%ecx
80109bd6:	89 d0                	mov    %edx,%eax
80109bd8:	01 c0                	add    %eax,%eax
80109bda:	01 d0                	add    %edx,%eax
80109bdc:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109be2:	01 d0                	add    %edx,%eax
80109be4:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80109bea:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109bf0:	6a 00                	push   $0x0
80109bf2:	6a 40                	push   $0x40
80109bf4:	68 80 00 00 00       	push   $0x80
80109bf9:	50                   	push   %eax
80109bfa:	e8 55 e7 ff ff       	call   80108354 <RGB>
80109bff:	83 c4 0c             	add    $0xc,%esp
80109c02:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109c09:	66 89 03             	mov    %ax,(%ebx)
80109c0c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109c13:	88 43 02             	mov    %al,0x2(%ebx)
80109c16:	eb 5e                	jmp    80109c76 <APCharacterInit+0x16fd>
		
		else if(i>=25&&i<35)
80109c18:	83 bd 70 ff ff ff 18 	cmpl   $0x18,-0x90(%ebp)
80109c1f:	7e 55                	jle    80109c76 <APCharacterInit+0x16fd>
80109c21:	83 bd 70 ff ff ff 22 	cmpl   $0x22,-0x90(%ebp)
80109c28:	7f 4c                	jg     80109c76 <APCharacterInit+0x16fd>
			character_img[i][j] = RGB(128,64,0);
80109c2a:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
80109c30:	8b 8d 70 ff ff ff    	mov    -0x90(%ebp),%ecx
80109c36:	89 d0                	mov    %edx,%eax
80109c38:	01 c0                	add    %eax,%eax
80109c3a:	01 d0                	add    %edx,%eax
80109c3c:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109c42:	01 d0                	add    %edx,%eax
80109c44:	8d 98 a0 78 11 80    	lea    -0x7fee8760(%eax),%ebx
80109c4a:	8d 85 48 ff ff ff    	lea    -0xb8(%ebp),%eax
80109c50:	6a 00                	push   $0x0
80109c52:	6a 40                	push   $0x40
80109c54:	68 80 00 00 00       	push   $0x80
80109c59:	50                   	push   %eax
80109c5a:	e8 f5 e6 ff ff       	call   80108354 <RGB>
80109c5f:	83 c4 0c             	add    $0xc,%esp
80109c62:	0f b7 85 48 ff ff ff 	movzwl -0xb8(%ebp),%eax
80109c69:	66 89 03             	mov    %ax,(%ebx)
80109c6c:	0f b6 85 4a ff ff ff 	movzbl -0xb6(%ebp),%eax
80109c73:	88 43 02             	mov    %al,0x2(%ebx)

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
	for(int i=0;i<40;i++){
80109c76:	83 85 70 ff ff ff 01 	addl   $0x1,-0x90(%ebp)
80109c7d:	83 bd 70 ff ff ff 27 	cmpl   $0x27,-0x90(%ebp)
80109c84:	0f 8e 37 ff ff ff    	jle    80109bc1 <APCharacterInit+0x1648>
			character_img[i][j] = RGB(128,64,0);

		
}}
line =line +3;
for(int j=line;j<line+3;j++){
80109c8a:	83 85 74 ff ff ff 01 	addl   $0x1,-0x8c(%ebp)
80109c91:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80109c97:	83 c0 03             	add    $0x3,%eax
80109c9a:	3b 85 74 ff ff ff    	cmp    -0x8c(%ebp),%eax
80109ca0:	0f 8f 0c ff ff ff    	jg     80109bb2 <APCharacterInit+0x1639>
			character_img[i][j] = RGB(128,64,0);

		
}}

   for(int j=0;j<GRID_WIDTH;j++)
80109ca6:	c7 85 6c ff ff ff 00 	movl   $0x0,-0x94(%ebp)
80109cad:	00 00 00 
80109cb0:	eb 76                	jmp    80109d28 <APCharacterInit+0x17af>
   	for(int i=0;i<GRID_WIDTH;i++)
80109cb2:	c7 85 68 ff ff ff 00 	movl   $0x0,-0x98(%ebp)
80109cb9:	00 00 00 
80109cbc:	eb 5a                	jmp    80109d18 <APCharacterInit+0x179f>
      		character_img2[GRID_WIDTH-1-i][j] = character_img[i][j];
80109cbe:	b8 31 00 00 00       	mov    $0x31,%eax
80109cc3:	2b 85 68 ff ff ff    	sub    -0x98(%ebp),%eax
80109cc9:	89 c1                	mov    %eax,%ecx
80109ccb:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
80109cd1:	89 d0                	mov    %edx,%eax
80109cd3:	01 c0                	add    %eax,%eax
80109cd5:	01 d0                	add    %edx,%eax
80109cd7:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109cdd:	01 d0                	add    %edx,%eax
80109cdf:	8d 90 00 96 11 80    	lea    -0x7fee6a00(%eax),%edx
80109ce5:	8b 8d 6c ff ff ff    	mov    -0x94(%ebp),%ecx
80109ceb:	8b 9d 68 ff ff ff    	mov    -0x98(%ebp),%ebx
80109cf1:	89 c8                	mov    %ecx,%eax
80109cf3:	01 c0                	add    %eax,%eax
80109cf5:	01 c8                	add    %ecx,%eax
80109cf7:	69 cb 96 00 00 00    	imul   $0x96,%ebx,%ecx
80109cfd:	01 c8                	add    %ecx,%eax
80109cff:	05 a0 78 11 80       	add    $0x801178a0,%eax
80109d04:	0f b7 08             	movzwl (%eax),%ecx
80109d07:	66 89 0a             	mov    %cx,(%edx)
80109d0a:	0f b6 40 02          	movzbl 0x2(%eax),%eax
80109d0e:	88 42 02             	mov    %al,0x2(%edx)

		
}}

   for(int j=0;j<GRID_WIDTH;j++)
   	for(int i=0;i<GRID_WIDTH;i++)
80109d11:	83 85 68 ff ff ff 01 	addl   $0x1,-0x98(%ebp)
80109d18:	83 bd 68 ff ff ff 31 	cmpl   $0x31,-0x98(%ebp)
80109d1f:	7e 9d                	jle    80109cbe <APCharacterInit+0x1745>
			character_img[i][j] = RGB(128,64,0);

		
}}

   for(int j=0;j<GRID_WIDTH;j++)
80109d21:	83 85 6c ff ff ff 01 	addl   $0x1,-0x94(%ebp)
80109d28:	83 bd 6c ff ff ff 31 	cmpl   $0x31,-0x94(%ebp)
80109d2f:	7e 81                	jle    80109cb2 <APCharacterInit+0x1739>
   	for(int i=0;i<GRID_WIDTH;i++)
      		character_img2[GRID_WIDTH-1-i][j] = character_img[i][j];
}
80109d31:	90                   	nop
80109d32:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80109d35:	c9                   	leave  
80109d36:	c3                   	ret    

80109d37 <APGuiInit>:

void APGuiInit(void)
{
80109d37:	55                   	push   %ebp
80109d38:	89 e5                	mov    %esp,%ebp
80109d3a:	53                   	push   %ebx
80109d3b:	83 ec 04             	sub    $0x4,%esp
    screenAddr = (AColor *)(*((uint*)P2V(0x1028)));
80109d3e:	b8 28 10 00 80       	mov    $0x80001028,%eax
80109d43:	8b 00                	mov    (%eax),%eax
80109d45:	a3 80 e6 10 80       	mov    %eax,0x8010e680
    screenWidth = *((ushort *)P2V(0x1012));
80109d4a:	b8 12 10 00 80       	mov    $0x80001012,%eax
80109d4f:	0f b7 00             	movzwl (%eax),%eax
80109d52:	66 a3 74 e6 10 80    	mov    %ax,0x8010e674
    screenHeight = *((ushort *)P2V(0x1014));
80109d58:	b8 14 10 00 80       	mov    $0x80001014,%eax
80109d5d:	0f b7 00             	movzwl (%eax),%eax
80109d60:	66 a3 76 e6 10 80    	mov    %ax,0x8010e676
    bitsPerPixel = *((uchar*)P2V(0x1019));
80109d66:	b8 19 10 00 80       	mov    $0x80001019,%eax
80109d6b:	0f b6 00             	movzbl (%eax),%eax
80109d6e:	a2 78 e6 10 80       	mov    %al,0x8010e678
    screenBuf = screenAddr + screenWidth * screenHeight;
80109d73:	8b 15 80 e6 10 80    	mov    0x8010e680,%edx
80109d79:	0f b7 05 74 e6 10 80 	movzwl 0x8010e674,%eax
80109d80:	0f b7 c8             	movzwl %ax,%ecx
80109d83:	0f b7 05 76 e6 10 80 	movzwl 0x8010e676,%eax
80109d8a:	0f b7 c0             	movzwl %ax,%eax
80109d8d:	0f af c1             	imul   %ecx,%eax
80109d90:	89 c1                	mov    %eax,%ecx
80109d92:	89 c8                	mov    %ecx,%eax
80109d94:	01 c0                	add    %eax,%eax
80109d96:	01 c8                	add    %ecx,%eax
80109d98:	01 d0                	add    %edx,%eax
80109d9a:	a3 84 e6 10 80       	mov    %eax,0x8010e684
    screenContent = screenBuf + screenWidth * screenHeight;
80109d9f:	8b 15 84 e6 10 80    	mov    0x8010e684,%edx
80109da5:	0f b7 05 74 e6 10 80 	movzwl 0x8010e674,%eax
80109dac:	0f b7 c8             	movzwl %ax,%ecx
80109daf:	0f b7 05 76 e6 10 80 	movzwl 0x8010e676,%eax
80109db6:	0f b7 c0             	movzwl %ax,%eax
80109db9:	0f af c1             	imul   %ecx,%eax
80109dbc:	89 c1                	mov    %eax,%ecx
80109dbe:	89 c8                	mov    %ecx,%eax
80109dc0:	01 c0                	add    %eax,%eax
80109dc2:	01 c8                	add    %ecx,%eax
80109dc4:	01 d0                	add    %edx,%eax
80109dc6:	a3 88 e6 10 80       	mov    %eax,0x8010e688
    
    
    cprintf("screen addr : %x, screen width : %d, screen height : %d, bitsPerPixel: %d \n",
80109dcb:	0f b6 05 78 e6 10 80 	movzbl 0x8010e678,%eax
80109dd2:	0f b6 d8             	movzbl %al,%ebx
80109dd5:	0f b7 05 76 e6 10 80 	movzwl 0x8010e676,%eax
80109ddc:	0f b7 c8             	movzwl %ax,%ecx
80109ddf:	0f b7 05 74 e6 10 80 	movzwl 0x8010e674,%eax
80109de6:	0f b7 d0             	movzwl %ax,%edx
80109de9:	a1 80 e6 10 80       	mov    0x8010e680,%eax
80109dee:	83 ec 0c             	sub    $0xc,%esp
80109df1:	53                   	push   %ebx
80109df2:	51                   	push   %ecx
80109df3:	52                   	push   %edx
80109df4:	50                   	push   %eax
80109df5:	68 58 bb 10 80       	push   $0x8010bb58
80109dfa:	e8 c7 65 ff ff       	call   801003c6 <cprintf>
80109dff:	83 c4 20             	add    $0x20,%esp
            screenAddr, screenWidth,screenHeight,bitsPerPixel);
    
    initlock(&screenLock,"sreenLock");
80109e02:	83 ec 08             	sub    $0x8,%esp
80109e05:	68 a4 bb 10 80       	push   $0x8010bba4
80109e0a:	68 40 57 11 80       	push   $0x80115740
80109e0f:	e8 3a b0 ff ff       	call   80104e4e <initlock>
80109e14:	83 c4 10             	add    $0x10,%esp
    APCharacterInit();
80109e17:	e8 5d e7 ff ff       	call   80108579 <APCharacterInit>
    
}
80109e1c:	90                   	nop
80109e1d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80109e20:	c9                   	leave  
80109e21:	c3                   	ret    

80109e22 <APBufPaint>:

//将左上角坐标为(x1,y1),右下角坐标为(x2,y2)的矩形区域从Buf绘制到屏幕上
void APBufPaint(int x1,int y1,int x2,int y2,int is_grid)
{
80109e22:	55                   	push   %ebp
80109e23:	89 e5                	mov    %esp,%ebp
80109e25:	56                   	push   %esi
80109e26:	53                   	push   %ebx
80109e27:	83 ec 20             	sub    $0x20,%esp
    acquire(&screenLock);
80109e2a:	83 ec 0c             	sub    $0xc,%esp
80109e2d:	68 40 57 11 80       	push   $0x80115740
80109e32:	e8 39 b0 ff ff       	call   80104e70 <acquire>
80109e37:	83 c4 10             	add    $0x10,%esp
    x2 -= x1;
80109e3a:	8b 45 08             	mov    0x8(%ebp),%eax
80109e3d:	29 45 10             	sub    %eax,0x10(%ebp)
    x2 *= sizeof(AColor);
80109e40:	8b 55 10             	mov    0x10(%ebp),%edx
80109e43:	89 d0                	mov    %edx,%eax
80109e45:	01 c0                	add    %eax,%eax
80109e47:	01 d0                	add    %edx,%eax
80109e49:	89 45 10             	mov    %eax,0x10(%ebp)
    int off = x1 + y1 * screenWidth;
80109e4c:	0f b7 05 74 e6 10 80 	movzwl 0x8010e674,%eax
80109e53:	0f b7 c0             	movzwl %ax,%eax
80109e56:	0f af 45 0c          	imul   0xc(%ebp),%eax
80109e5a:	89 c2                	mov    %eax,%edx
80109e5c:	8b 45 08             	mov    0x8(%ebp),%eax
80109e5f:	01 d0                	add    %edx,%eax
80109e61:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (int y = y1 ; y <= y2; y++)
80109e64:	8b 45 0c             	mov    0xc(%ebp),%eax
80109e67:	89 45 f0             	mov    %eax,-0x10(%ebp)
80109e6a:	eb 77                	jmp    80109ee3 <APBufPaint+0xc1>
    {
        memmove(screenBuf + off , screenContent + off, x2);
80109e6c:	8b 4d 10             	mov    0x10(%ebp),%ecx
80109e6f:	8b 1d 88 e6 10 80    	mov    0x8010e688,%ebx
80109e75:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109e78:	89 d0                	mov    %edx,%eax
80109e7a:	01 c0                	add    %eax,%eax
80109e7c:	01 d0                	add    %edx,%eax
80109e7e:	01 c3                	add    %eax,%ebx
80109e80:	8b 35 84 e6 10 80    	mov    0x8010e684,%esi
80109e86:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109e89:	89 d0                	mov    %edx,%eax
80109e8b:	01 c0                	add    %eax,%eax
80109e8d:	01 d0                	add    %edx,%eax
80109e8f:	01 f0                	add    %esi,%eax
80109e91:	83 ec 04             	sub    $0x4,%esp
80109e94:	51                   	push   %ecx
80109e95:	53                   	push   %ebx
80109e96:	50                   	push   %eax
80109e97:	e8 f6 b2 ff ff       	call   80105192 <memmove>
80109e9c:	83 c4 10             	add    $0x10,%esp
        memmove(screenAddr + off, screenContent + off, x2);
80109e9f:	8b 4d 10             	mov    0x10(%ebp),%ecx
80109ea2:	8b 1d 88 e6 10 80    	mov    0x8010e688,%ebx
80109ea8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109eab:	89 d0                	mov    %edx,%eax
80109ead:	01 c0                	add    %eax,%eax
80109eaf:	01 d0                	add    %edx,%eax
80109eb1:	01 c3                	add    %eax,%ebx
80109eb3:	8b 35 80 e6 10 80    	mov    0x8010e680,%esi
80109eb9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109ebc:	89 d0                	mov    %edx,%eax
80109ebe:	01 c0                	add    %eax,%eax
80109ec0:	01 d0                	add    %edx,%eax
80109ec2:	01 f0                	add    %esi,%eax
80109ec4:	83 ec 04             	sub    $0x4,%esp
80109ec7:	51                   	push   %ecx
80109ec8:	53                   	push   %ebx
80109ec9:	50                   	push   %eax
80109eca:	e8 c3 b2 ff ff       	call   80105192 <memmove>
80109ecf:	83 c4 10             	add    $0x10,%esp
        off += screenWidth;
80109ed2:	0f b7 05 74 e6 10 80 	movzwl 0x8010e674,%eax
80109ed9:	0f b7 c0             	movzwl %ax,%eax
80109edc:	01 45 f4             	add    %eax,-0xc(%ebp)
{
    acquire(&screenLock);
    x2 -= x1;
    x2 *= sizeof(AColor);
    int off = x1 + y1 * screenWidth;
    for (int y = y1 ; y <= y2; y++)
80109edf:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80109ee3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109ee6:	3b 45 14             	cmp    0x14(%ebp),%eax
80109ee9:	7e 81                	jle    80109e6c <APBufPaint+0x4a>
        memmove(screenBuf + off , screenContent + off, x2);
        memmove(screenAddr + off, screenContent + off, x2);
        off += screenWidth;
    }
    
    if (is_grid)
80109eeb:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
80109eef:	0f 84 9a 01 00 00    	je     8010a08f <APBufPaint+0x26d>
    {
        if (x1 <= character_x * GRID_WIDTH + GRID_WIDTH && x2 >= character_x * GRID_WIDTH
80109ef5:	a1 60 bb 11 80       	mov    0x8011bb60,%eax
80109efa:	83 c0 01             	add    $0x1,%eax
80109efd:	6b c0 32             	imul   $0x32,%eax,%eax
80109f00:	3b 45 08             	cmp    0x8(%ebp),%eax
80109f03:	0f 8c 86 01 00 00    	jl     8010a08f <APBufPaint+0x26d>
80109f09:	a1 60 bb 11 80       	mov    0x8011bb60,%eax
80109f0e:	6b c0 32             	imul   $0x32,%eax,%eax
80109f11:	3b 45 10             	cmp    0x10(%ebp),%eax
80109f14:	0f 8f 75 01 00 00    	jg     8010a08f <APBufPaint+0x26d>
            && y1 <= character_y * GRID_WIDTH + GRID_WIDTH + WND_TITLE_HEIGHT && y2 >= character_y * GRID_WIDTH + WND_TITLE_HEIGHT)
80109f1a:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80109f1f:	83 c0 02             	add    $0x2,%eax
80109f22:	6b c0 32             	imul   $0x32,%eax,%eax
80109f25:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109f28:	0f 8c 61 01 00 00    	jl     8010a08f <APBufPaint+0x26d>
80109f2e:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80109f33:	83 c0 01             	add    $0x1,%eax
80109f36:	6b c0 32             	imul   $0x32,%eax,%eax
80109f39:	3b 45 14             	cmp    0x14(%ebp),%eax
80109f3c:	0f 8f 4d 01 00 00    	jg     8010a08f <APBufPaint+0x26d>
        {
            for (int j = 0; j < GRID_WIDTH ; j++)
80109f42:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80109f49:	e9 34 01 00 00       	jmp    8010a082 <APBufPaint+0x260>
            {
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
80109f4e:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80109f53:	83 c0 01             	add    $0x1,%eax
80109f56:	6b d0 32             	imul   $0x32,%eax,%edx
80109f59:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109f5c:	01 c2                	add    %eax,%edx
80109f5e:	0f b7 05 74 e6 10 80 	movzwl 0x8010e674,%eax
80109f65:	0f b7 c0             	movzwl %ax,%eax
80109f68:	0f af d0             	imul   %eax,%edx
80109f6b:	a1 60 bb 11 80       	mov    0x8011bb60,%eax
80109f70:	6b c0 32             	imul   $0x32,%eax,%eax
80109f73:	01 d0                	add    %edx,%eax
80109f75:	89 45 f4             	mov    %eax,-0xc(%ebp)
                if (character_y * GRID_WIDTH + j < y1)
80109f78:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80109f7d:	6b d0 32             	imul   $0x32,%eax,%edx
80109f80:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109f83:	01 d0                	add    %edx,%eax
80109f85:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109f88:	0f 8c ec 00 00 00    	jl     8010a07a <APBufPaint+0x258>
                    continue;
                if (character_y * GRID_WIDTH + j > y2)
80109f8e:	a1 04 e5 10 80       	mov    0x8010e504,%eax
80109f93:	6b d0 32             	imul   $0x32,%eax,%edx
80109f96:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109f99:	01 d0                	add    %edx,%eax
80109f9b:	3b 45 14             	cmp    0x14(%ebp),%eax
80109f9e:	0f 8f ea 00 00 00    	jg     8010a08e <APBufPaint+0x26c>
                    break;
                for (int i = 0; i < GRID_WIDTH; i++)
80109fa4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
80109fab:	e9 be 00 00 00       	jmp    8010a06e <APBufPaint+0x24c>
                {
                    if (character_x * GRID_WIDTH + i < x1)
80109fb0:	a1 60 bb 11 80       	mov    0x8011bb60,%eax
80109fb5:	6b d0 32             	imul   $0x32,%eax,%edx
80109fb8:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109fbb:	01 d0                	add    %edx,%eax
80109fbd:	3b 45 08             	cmp    0x8(%ebp),%eax
80109fc0:	0f 8c a3 00 00 00    	jl     8010a069 <APBufPaint+0x247>
                        continue;
                    if (character_x * GRID_WIDTH + i > x2)
80109fc6:	a1 60 bb 11 80       	mov    0x8011bb60,%eax
80109fcb:	6b d0 32             	imul   $0x32,%eax,%edx
80109fce:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109fd1:	01 d0                	add    %edx,%eax
80109fd3:	3b 45 10             	cmp    0x10(%ebp),%eax
80109fd6:	0f 8f a1 00 00 00    	jg     8010a07d <APBufPaint+0x25b>
                        break;
                    AColor c = character_img[i][j];
80109fdc:	8b 55 ec             	mov    -0x14(%ebp),%edx
80109fdf:	8b 4d e8             	mov    -0x18(%ebp),%ecx
80109fe2:	89 d0                	mov    %edx,%eax
80109fe4:	01 c0                	add    %eax,%eax
80109fe6:	01 d0                	add    %edx,%eax
80109fe8:	69 d1 96 00 00 00    	imul   $0x96,%ecx,%edx
80109fee:	01 d0                	add    %edx,%eax
80109ff0:	05 a0 78 11 80       	add    $0x801178a0,%eax
80109ff5:	0f b7 10             	movzwl (%eax),%edx
80109ff8:	66 89 55 e5          	mov    %dx,-0x1b(%ebp)
80109ffc:	0f b6 40 02          	movzbl 0x2(%eax),%eax
8010a000:	88 45 e7             	mov    %al,-0x19(%ebp)
                    if (c.r != COLOR_TRANSPARENT || c.g!=COLOR_TRANSPARENT || c.b !=COLOR_TRANSPARENT)
8010a003:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010a007:	3c 0c                	cmp    $0xc,%al
8010a009:	75 10                	jne    8010a01b <APBufPaint+0x1f9>
8010a00b:	0f b6 45 e6          	movzbl -0x1a(%ebp),%eax
8010a00f:	3c 0c                	cmp    $0xc,%al
8010a011:	75 08                	jne    8010a01b <APBufPaint+0x1f9>
8010a013:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
8010a017:	3c 0c                	cmp    $0xc,%al
8010a019:	74 4f                	je     8010a06a <APBufPaint+0x248>
                    {
                        screenBuf [off + i] = c;
8010a01b:	8b 15 84 e6 10 80    	mov    0x8010e684,%edx
8010a021:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010a024:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a027:	01 c8                	add    %ecx,%eax
8010a029:	89 c1                	mov    %eax,%ecx
8010a02b:	89 c8                	mov    %ecx,%eax
8010a02d:	01 c0                	add    %eax,%eax
8010a02f:	01 c8                	add    %ecx,%eax
8010a031:	01 d0                	add    %edx,%eax
8010a033:	0f b7 55 e5          	movzwl -0x1b(%ebp),%edx
8010a037:	66 89 10             	mov    %dx,(%eax)
8010a03a:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
8010a03e:	88 50 02             	mov    %dl,0x2(%eax)
                        screenAddr[off + i] = c;
8010a041:	8b 15 80 e6 10 80    	mov    0x8010e680,%edx
8010a047:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010a04a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a04d:	01 c8                	add    %ecx,%eax
8010a04f:	89 c1                	mov    %eax,%ecx
8010a051:	89 c8                	mov    %ecx,%eax
8010a053:	01 c0                	add    %eax,%eax
8010a055:	01 c8                	add    %ecx,%eax
8010a057:	01 d0                	add    %edx,%eax
8010a059:	0f b7 55 e5          	movzwl -0x1b(%ebp),%edx
8010a05d:	66 89 10             	mov    %dx,(%eax)
8010a060:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
8010a064:	88 50 02             	mov    %dl,0x2(%eax)
8010a067:	eb 01                	jmp    8010a06a <APBufPaint+0x248>
                if (character_y * GRID_WIDTH + j > y2)
                    break;
                for (int i = 0; i < GRID_WIDTH; i++)
                {
                    if (character_x * GRID_WIDTH + i < x1)
                        continue;
8010a069:	90                   	nop
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
                if (character_y * GRID_WIDTH + j < y1)
                    continue;
                if (character_y * GRID_WIDTH + j > y2)
                    break;
                for (int i = 0; i < GRID_WIDTH; i++)
8010a06a:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
8010a06e:	83 7d e8 31          	cmpl   $0x31,-0x18(%ebp)
8010a072:	0f 8e 38 ff ff ff    	jle    80109fb0 <APBufPaint+0x18e>
8010a078:	eb 04                	jmp    8010a07e <APBufPaint+0x25c>
        {
            for (int j = 0; j < GRID_WIDTH ; j++)
            {
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
                if (character_y * GRID_WIDTH + j < y1)
                    continue;
8010a07a:	90                   	nop
8010a07b:	eb 01                	jmp    8010a07e <APBufPaint+0x25c>
                for (int i = 0; i < GRID_WIDTH; i++)
                {
                    if (character_x * GRID_WIDTH + i < x1)
                        continue;
                    if (character_x * GRID_WIDTH + i > x2)
                        break;
8010a07d:	90                   	nop
    if (is_grid)
    {
        if (x1 <= character_x * GRID_WIDTH + GRID_WIDTH && x2 >= character_x * GRID_WIDTH
            && y1 <= character_y * GRID_WIDTH + GRID_WIDTH + WND_TITLE_HEIGHT && y2 >= character_y * GRID_WIDTH + WND_TITLE_HEIGHT)
        {
            for (int j = 0; j < GRID_WIDTH ; j++)
8010a07e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
8010a082:	83 7d ec 31          	cmpl   $0x31,-0x14(%ebp)
8010a086:	0f 8e c2 fe ff ff    	jle    80109f4e <APBufPaint+0x12c>
8010a08c:	eb 01                	jmp    8010a08f <APBufPaint+0x26d>
            {
                off = (character_y * GRID_WIDTH + WND_TITLE_HEIGHT + j) * screenWidth + character_x * GRID_WIDTH;
                if (character_y * GRID_WIDTH + j < y1)
                    continue;
                if (character_y * GRID_WIDTH + j > y2)
                    break;
8010a08e:	90                   	nop
            }
        }
    }
    //cprintf("arbitrary set window color!\n");
    //memset(screenAddr, DEFAULT_WINDOW_COLOR, sizeof(AColor) * screenWidth * screenHeight);
    release(&screenLock);
8010a08f:	83 ec 0c             	sub    $0xc,%esp
8010a092:	68 40 57 11 80       	push   $0x80115740
8010a097:	e8 3b ae ff ff       	call   80104ed7 <release>
8010a09c:	83 c4 10             	add    $0x10,%esp
}
8010a09f:	90                   	nop
8010a0a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010a0a3:	5b                   	pop    %ebx
8010a0a4:	5e                   	pop    %esi
8010a0a5:	5d                   	pop    %ebp
8010a0a6:	c3                   	ret    

8010a0a7 <sys_paintWindow>:

//paintwindow: (hwnd,wx,wy,hdc,sx,sy,w,h,is_grid)
int sys_paintWindow(void)
{
8010a0a7:	55                   	push   %ebp
8010a0a8:	89 e5                	mov    %esp,%ebp
8010a0aa:	56                   	push   %esi
8010a0ab:	53                   	push   %ebx
8010a0ac:	83 ec 40             	sub    $0x40,%esp
    //cprintf("in paintWindow function:---- 1  \n");
    AHwnd hwnd = 0;
8010a0af:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    AHdc hdc = 0;
8010a0b6:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    int wx,wy,sx,sy,w,h,is_grid;
    //从控制台获取数据，并检验值是否合法
    if (argstr(0, (char **)&hwnd) < 0 || argint(1, &wx) < 0 || argint(2, &wy) < 0
8010a0bd:	83 ec 08             	sub    $0x8,%esp
8010a0c0:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010a0c3:	50                   	push   %eax
8010a0c4:	6a 00                	push   $0x0
8010a0c6:	e8 b2 b3 ff ff       	call   8010547d <argstr>
8010a0cb:	83 c4 10             	add    $0x10,%esp
8010a0ce:	85 c0                	test   %eax,%eax
8010a0d0:	0f 88 ac 00 00 00    	js     8010a182 <sys_paintWindow+0xdb>
8010a0d6:	83 ec 08             	sub    $0x8,%esp
8010a0d9:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010a0dc:	50                   	push   %eax
8010a0dd:	6a 01                	push   $0x1
8010a0df:	e8 14 b3 ff ff       	call   801053f8 <argint>
8010a0e4:	83 c4 10             	add    $0x10,%esp
8010a0e7:	85 c0                	test   %eax,%eax
8010a0e9:	0f 88 93 00 00 00    	js     8010a182 <sys_paintWindow+0xdb>
8010a0ef:	83 ec 08             	sub    $0x8,%esp
8010a0f2:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010a0f5:	50                   	push   %eax
8010a0f6:	6a 02                	push   $0x2
8010a0f8:	e8 fb b2 ff ff       	call   801053f8 <argint>
8010a0fd:	83 c4 10             	add    $0x10,%esp
8010a100:	85 c0                	test   %eax,%eax
8010a102:	78 7e                	js     8010a182 <sys_paintWindow+0xdb>
        || argstr(3, (char **)&hdc) < 0 || argint(4, &sx) < 0
8010a104:	83 ec 08             	sub    $0x8,%esp
8010a107:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010a10a:	50                   	push   %eax
8010a10b:	6a 03                	push   $0x3
8010a10d:	e8 6b b3 ff ff       	call   8010547d <argstr>
8010a112:	83 c4 10             	add    $0x10,%esp
8010a115:	85 c0                	test   %eax,%eax
8010a117:	78 69                	js     8010a182 <sys_paintWindow+0xdb>
8010a119:	83 ec 08             	sub    $0x8,%esp
8010a11c:	8d 45 d0             	lea    -0x30(%ebp),%eax
8010a11f:	50                   	push   %eax
8010a120:	6a 04                	push   $0x4
8010a122:	e8 d1 b2 ff ff       	call   801053f8 <argint>
8010a127:	83 c4 10             	add    $0x10,%esp
8010a12a:	85 c0                	test   %eax,%eax
8010a12c:	78 54                	js     8010a182 <sys_paintWindow+0xdb>
        || argint(5, &sy) < 0 || argint(6, &w) < 0 || argint(7, &h) < 0
8010a12e:	83 ec 08             	sub    $0x8,%esp
8010a131:	8d 45 cc             	lea    -0x34(%ebp),%eax
8010a134:	50                   	push   %eax
8010a135:	6a 05                	push   $0x5
8010a137:	e8 bc b2 ff ff       	call   801053f8 <argint>
8010a13c:	83 c4 10             	add    $0x10,%esp
8010a13f:	85 c0                	test   %eax,%eax
8010a141:	78 3f                	js     8010a182 <sys_paintWindow+0xdb>
8010a143:	83 ec 08             	sub    $0x8,%esp
8010a146:	8d 45 c8             	lea    -0x38(%ebp),%eax
8010a149:	50                   	push   %eax
8010a14a:	6a 06                	push   $0x6
8010a14c:	e8 a7 b2 ff ff       	call   801053f8 <argint>
8010a151:	83 c4 10             	add    $0x10,%esp
8010a154:	85 c0                	test   %eax,%eax
8010a156:	78 2a                	js     8010a182 <sys_paintWindow+0xdb>
8010a158:	83 ec 08             	sub    $0x8,%esp
8010a15b:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010a15e:	50                   	push   %eax
8010a15f:	6a 07                	push   $0x7
8010a161:	e8 92 b2 ff ff       	call   801053f8 <argint>
8010a166:	83 c4 10             	add    $0x10,%esp
8010a169:	85 c0                	test   %eax,%eax
8010a16b:	78 15                	js     8010a182 <sys_paintWindow+0xdb>
        || argint(8, &is_grid) < 0)
8010a16d:	83 ec 08             	sub    $0x8,%esp
8010a170:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010a173:	50                   	push   %eax
8010a174:	6a 08                	push   $0x8
8010a176:	e8 7d b2 ff ff       	call   801053f8 <argint>
8010a17b:	83 c4 10             	add    $0x10,%esp
8010a17e:	85 c0                	test   %eax,%eax
8010a180:	79 0a                	jns    8010a18c <sys_paintWindow+0xe5>
        return -1;
8010a182:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a187:	e9 67 02 00 00       	jmp    8010a3f3 <sys_paintWindow+0x34c>
    
    if (sx < 0 || sy < 0 || h <= 0 || w <= 0 || sx + w > hdc->size.cx || sy + h > hdc->size.cy)
8010a18c:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010a18f:	85 c0                	test   %eax,%eax
8010a191:	78 38                	js     8010a1cb <sys_paintWindow+0x124>
8010a193:	8b 45 cc             	mov    -0x34(%ebp),%eax
8010a196:	85 c0                	test   %eax,%eax
8010a198:	78 31                	js     8010a1cb <sys_paintWindow+0x124>
8010a19a:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a19d:	85 c0                	test   %eax,%eax
8010a19f:	7e 2a                	jle    8010a1cb <sys_paintWindow+0x124>
8010a1a1:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a1a4:	85 c0                	test   %eax,%eax
8010a1a6:	7e 23                	jle    8010a1cb <sys_paintWindow+0x124>
8010a1a8:	8b 55 d0             	mov    -0x30(%ebp),%edx
8010a1ab:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a1ae:	01 c2                	add    %eax,%edx
8010a1b0:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a1b3:	8b 00                	mov    (%eax),%eax
8010a1b5:	39 c2                	cmp    %eax,%edx
8010a1b7:	7f 12                	jg     8010a1cb <sys_paintWindow+0x124>
8010a1b9:	8b 55 cc             	mov    -0x34(%ebp),%edx
8010a1bc:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a1bf:	01 c2                	add    %eax,%edx
8010a1c1:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a1c4:	8b 40 04             	mov    0x4(%eax),%eax
8010a1c7:	39 c2                	cmp    %eax,%edx
8010a1c9:	7e 0a                	jle    8010a1d5 <sys_paintWindow+0x12e>
        return 0;
8010a1cb:	b8 00 00 00 00       	mov    $0x0,%eax
8010a1d0:	e9 1e 02 00 00       	jmp    8010a3f3 <sys_paintWindow+0x34c>
    
    if (wx < 0 || wy < 0 || wx + w > screenWidth || wy + h > screenHeight)
8010a1d5:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a1d8:	85 c0                	test   %eax,%eax
8010a1da:	78 33                	js     8010a20f <sys_paintWindow+0x168>
8010a1dc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a1df:	85 c0                	test   %eax,%eax
8010a1e1:	78 2c                	js     8010a20f <sys_paintWindow+0x168>
8010a1e3:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010a1e6:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a1e9:	01 c2                	add    %eax,%edx
8010a1eb:	0f b7 05 74 e6 10 80 	movzwl 0x8010e674,%eax
8010a1f2:	0f b7 c0             	movzwl %ax,%eax
8010a1f5:	39 c2                	cmp    %eax,%edx
8010a1f7:	7f 16                	jg     8010a20f <sys_paintWindow+0x168>
8010a1f9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a1fc:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a1ff:	01 c2                	add    %eax,%edx
8010a201:	0f b7 05 76 e6 10 80 	movzwl 0x8010e676,%eax
8010a208:	0f b7 c0             	movzwl %ax,%eax
8010a20b:	39 c2                	cmp    %eax,%edx
8010a20d:	7e 0a                	jle    8010a219 <sys_paintWindow+0x172>
        return 0;
8010a20f:	b8 00 00 00 00       	mov    $0x0,%eax
8010a214:	e9 da 01 00 00       	jmp    8010a3f3 <sys_paintWindow+0x34c>
    
    //wx,wy是window重绘左上角坐标
    
    //int id = hwnd ->id;
    //cprintf("in paintWindow function:-----2  \n");
    AColor *data = hdc->content;
8010a219:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a21c:	8b 40 18             	mov    0x18(%eax),%eax
8010a21f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    
    int j;
    for (int i = 0; i < h;i++)
8010a222:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010a229:	e9 18 01 00 00       	jmp    8010a346 <sys_paintWindow+0x29f>
    {
        if (wy + i < 0)
8010a22e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a231:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a234:	01 d0                	add    %edx,%eax
8010a236:	85 c0                	test   %eax,%eax
8010a238:	79 0d                	jns    8010a247 <sys_paintWindow+0x1a0>
        {
            i = -wy - 1;
8010a23a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a23d:	f7 d0                	not    %eax
8010a23f:	89 45 f0             	mov    %eax,-0x10(%ebp)
            continue;
8010a242:	e9 fb 00 00 00       	jmp    8010a342 <sys_paintWindow+0x29b>
        }
        else if (wy + i >= screenHeight)
8010a247:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a24a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a24d:	01 c2                	add    %eax,%edx
8010a24f:	0f b7 05 76 e6 10 80 	movzwl 0x8010e676,%eax
8010a256:	0f b7 c0             	movzwl %ax,%eax
8010a259:	39 c2                	cmp    %eax,%edx
8010a25b:	0f 8d f3 00 00 00    	jge    8010a354 <sys_paintWindow+0x2ad>
            break;
        int off_x = (sy + i) * hdc->size.cx + sx;
8010a261:	8b 55 cc             	mov    -0x34(%ebp),%edx
8010a264:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a267:	01 c2                	add    %eax,%edx
8010a269:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a26c:	8b 00                	mov    (%eax),%eax
8010a26e:	0f af d0             	imul   %eax,%edx
8010a271:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010a274:	01 d0                	add    %edx,%eax
8010a276:	89 45 e8             	mov    %eax,-0x18(%ebp)
        int screen_off_x = (wy + i) * screenWidth + wx;
8010a279:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a27c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a27f:	01 c2                	add    %eax,%edx
8010a281:	0f b7 05 74 e6 10 80 	movzwl 0x8010e674,%eax
8010a288:	0f b7 c0             	movzwl %ax,%eax
8010a28b:	0f af d0             	imul   %eax,%edx
8010a28e:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a291:	01 d0                	add    %edx,%eax
8010a293:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        for (j = 0; j < w; ++j)
8010a296:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010a29d:	e9 91 00 00 00       	jmp    8010a333 <sys_paintWindow+0x28c>
        {
            if (wx + j < 0)
8010a2a2:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010a2a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a2a8:	01 d0                	add    %edx,%eax
8010a2aa:	85 c0                	test   %eax,%eax
8010a2ac:	79 0a                	jns    8010a2b8 <sys_paintWindow+0x211>
            {
                j = -wx - 1;
8010a2ae:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a2b1:	f7 d0                	not    %eax
8010a2b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010a2b6:	eb 77                	jmp    8010a32f <sys_paintWindow+0x288>
                continue;
            }
            else if (wx + j >= screenWidth)
8010a2b8:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010a2bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a2be:	01 c2                	add    %eax,%edx
8010a2c0:	0f b7 05 74 e6 10 80 	movzwl 0x8010e674,%eax
8010a2c7:	0f b7 c0             	movzwl %ax,%eax
8010a2ca:	39 c2                	cmp    %eax,%edx
8010a2cc:	7d 73                	jge    8010a341 <sys_paintWindow+0x29a>
                break;
            
            AColor c = data[off_x + j];
8010a2ce:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010a2d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a2d4:	01 d0                	add    %edx,%eax
8010a2d6:	89 c2                	mov    %eax,%edx
8010a2d8:	89 d0                	mov    %edx,%eax
8010a2da:	01 c0                	add    %eax,%eax
8010a2dc:	01 c2                	add    %eax,%edx
8010a2de:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a2e1:	01 d0                	add    %edx,%eax
8010a2e3:	0f b7 10             	movzwl (%eax),%edx
8010a2e6:	66 89 55 bd          	mov    %dx,-0x43(%ebp)
8010a2ea:	0f b6 40 02          	movzbl 0x2(%eax),%eax
8010a2ee:	88 45 bf             	mov    %al,-0x41(%ebp)
            if (c.r != COLOR_TRANSPARENT || c.g != COLOR_TRANSPARENT || c.b != COLOR_TRANSPARENT )
8010a2f1:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
8010a2f5:	3c 0c                	cmp    $0xc,%al
8010a2f7:	75 10                	jne    8010a309 <sys_paintWindow+0x262>
8010a2f9:	0f b6 45 be          	movzbl -0x42(%ebp),%eax
8010a2fd:	3c 0c                	cmp    $0xc,%al
8010a2ff:	75 08                	jne    8010a309 <sys_paintWindow+0x262>
8010a301:	0f b6 45 bd          	movzbl -0x43(%ebp),%eax
8010a305:	3c 0c                	cmp    $0xc,%al
8010a307:	74 26                	je     8010a32f <sys_paintWindow+0x288>
                screenContent[screen_off_x + j] = c;
8010a309:	8b 15 88 e6 10 80    	mov    0x8010e688,%edx
8010a30f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010a312:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a315:	01 c8                	add    %ecx,%eax
8010a317:	89 c1                	mov    %eax,%ecx
8010a319:	89 c8                	mov    %ecx,%eax
8010a31b:	01 c0                	add    %eax,%eax
8010a31d:	01 c8                	add    %ecx,%eax
8010a31f:	01 d0                	add    %edx,%eax
8010a321:	0f b7 55 bd          	movzwl -0x43(%ebp),%edx
8010a325:	66 89 10             	mov    %dx,(%eax)
8010a328:	0f b6 55 bf          	movzbl -0x41(%ebp),%edx
8010a32c:	88 50 02             	mov    %dl,0x2(%eax)
        }
        else if (wy + i >= screenHeight)
            break;
        int off_x = (sy + i) * hdc->size.cx + sx;
        int screen_off_x = (wy + i) * screenWidth + wx;
        for (j = 0; j < w; ++j)
8010a32f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010a333:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a336:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010a339:	0f 8c 63 ff ff ff    	jl     8010a2a2 <sys_paintWindow+0x1fb>
8010a33f:	eb 01                	jmp    8010a342 <sys_paintWindow+0x29b>
            {
                j = -wx - 1;
                continue;
            }
            else if (wx + j >= screenWidth)
                break;
8010a341:	90                   	nop
    //int id = hwnd ->id;
    //cprintf("in paintWindow function:-----2  \n");
    AColor *data = hdc->content;
    
    int j;
    for (int i = 0; i < h;i++)
8010a342:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010a346:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a349:	39 45 f0             	cmp    %eax,-0x10(%ebp)
8010a34c:	0f 8c dc fe ff ff    	jl     8010a22e <sys_paintWindow+0x187>
8010a352:	eb 01                	jmp    8010a355 <sys_paintWindow+0x2ae>
        {
            i = -wy - 1;
            continue;
        }
        else if (wy + i >= screenHeight)
            break;
8010a354:	90                   	nop
            AColor c = data[off_x + j];
            if (c.r != COLOR_TRANSPARENT || c.g != COLOR_TRANSPARENT || c.b != COLOR_TRANSPARENT )
                screenContent[screen_off_x + j] = c;
        }
    }
    w += wx - 1;
8010a355:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a358:	8d 50 ff             	lea    -0x1(%eax),%edx
8010a35b:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a35e:	01 d0                	add    %edx,%eax
8010a360:	89 45 c8             	mov    %eax,-0x38(%ebp)
    h += wy - 1;
8010a363:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a366:	8d 50 ff             	lea    -0x1(%eax),%edx
8010a369:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a36c:	01 d0                	add    %edx,%eax
8010a36e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    if (wx < 0)
8010a371:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a374:	85 c0                	test   %eax,%eax
8010a376:	79 07                	jns    8010a37f <sys_paintWindow+0x2d8>
        wx = 0;
8010a378:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    if (wy < 0)
8010a37f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010a382:	85 c0                	test   %eax,%eax
8010a384:	79 07                	jns    8010a38d <sys_paintWindow+0x2e6>
        wy = 0;
8010a386:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    if (h >= screenHeight)
8010a38d:	0f b7 05 76 e6 10 80 	movzwl 0x8010e676,%eax
8010a394:	0f b7 d0             	movzwl %ax,%edx
8010a397:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010a39a:	39 c2                	cmp    %eax,%edx
8010a39c:	7f 10                	jg     8010a3ae <sys_paintWindow+0x307>
        h = screenHeight - 1;
8010a39e:	0f b7 05 76 e6 10 80 	movzwl 0x8010e676,%eax
8010a3a5:	0f b7 c0             	movzwl %ax,%eax
8010a3a8:	83 e8 01             	sub    $0x1,%eax
8010a3ab:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    if (w >= screenWidth)
8010a3ae:	0f b7 05 74 e6 10 80 	movzwl 0x8010e674,%eax
8010a3b5:	0f b7 d0             	movzwl %ax,%edx
8010a3b8:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010a3bb:	39 c2                	cmp    %eax,%edx
8010a3bd:	7f 10                	jg     8010a3cf <sys_paintWindow+0x328>
        w = screenWidth - 1;
8010a3bf:	0f b7 05 74 e6 10 80 	movzwl 0x8010e674,%eax
8010a3c6:	0f b7 c0             	movzwl %ax,%eax
8010a3c9:	83 e8 01             	sub    $0x1,%eax
8010a3cc:	89 45 c8             	mov    %eax,-0x38(%ebp)
    //release(&videoLock);
    APBufPaint(wx, wy, w, h,is_grid);
8010a3cf:	8b 75 c0             	mov    -0x40(%ebp),%esi
8010a3d2:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
8010a3d5:	8b 4d c8             	mov    -0x38(%ebp),%ecx
8010a3d8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010a3db:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a3de:	83 ec 0c             	sub    $0xc,%esp
8010a3e1:	56                   	push   %esi
8010a3e2:	53                   	push   %ebx
8010a3e3:	51                   	push   %ecx
8010a3e4:	52                   	push   %edx
8010a3e5:	50                   	push   %eax
8010a3e6:	e8 37 fa ff ff       	call   80109e22 <APBufPaint>
8010a3eb:	83 c4 20             	add    $0x20,%esp
    return 0;
8010a3ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a3f3:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010a3f6:	5b                   	pop    %ebx
8010a3f7:	5e                   	pop    %esi
8010a3f8:	5d                   	pop    %ebp
8010a3f9:	c3                   	ret    

8010a3fa <sys_changePosition>:

int sys_changePosition(void)
{
8010a3fa:	55                   	push   %ebp
8010a3fb:	89 e5                	mov    %esp,%ebp
8010a3fd:	83 ec 18             	sub    $0x18,%esp
    int x,y;
    if (argint(0, &x) < 0 || argint(1, &y) < 0)
8010a400:	83 ec 08             	sub    $0x8,%esp
8010a403:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010a406:	50                   	push   %eax
8010a407:	6a 00                	push   $0x0
8010a409:	e8 ea af ff ff       	call   801053f8 <argint>
8010a40e:	83 c4 10             	add    $0x10,%esp
8010a411:	85 c0                	test   %eax,%eax
8010a413:	78 15                	js     8010a42a <sys_changePosition+0x30>
8010a415:	83 ec 08             	sub    $0x8,%esp
8010a418:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010a41b:	50                   	push   %eax
8010a41c:	6a 01                	push   $0x1
8010a41e:	e8 d5 af ff ff       	call   801053f8 <argint>
8010a423:	83 c4 10             	add    $0x10,%esp
8010a426:	85 c0                	test   %eax,%eax
8010a428:	79 07                	jns    8010a431 <sys_changePosition+0x37>
        return -1;
8010a42a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a42f:	eb 73                	jmp    8010a4a4 <sys_changePosition+0xaa>
    
    if (x != 0)
8010a431:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a434:	85 c0                	test   %eax,%eax
8010a436:	74 30                	je     8010a468 <sys_changePosition+0x6e>
    {
        character_pre_x = character_x;
8010a438:	a1 60 bb 11 80       	mov    0x8011bb60,%eax
8010a43d:	a3 94 78 11 80       	mov    %eax,0x80117894
        if (x == VK_RIGHT)
8010a442:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a445:	3d e4 00 00 00       	cmp    $0xe4,%eax
8010a44a:	75 0f                	jne    8010a45b <sys_changePosition+0x61>
            character_x++;
8010a44c:	a1 60 bb 11 80       	mov    0x8011bb60,%eax
8010a451:	83 c0 01             	add    $0x1,%eax
8010a454:	a3 60 bb 11 80       	mov    %eax,0x8011bb60
8010a459:	eb 0d                	jmp    8010a468 <sys_changePosition+0x6e>
        else
            character_x--;
8010a45b:	a1 60 bb 11 80       	mov    0x8011bb60,%eax
8010a460:	83 e8 01             	sub    $0x1,%eax
8010a463:	a3 60 bb 11 80       	mov    %eax,0x8011bb60
    }
    if (y!=0)
8010a468:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a46b:	85 c0                	test   %eax,%eax
8010a46d:	74 30                	je     8010a49f <sys_changePosition+0xa5>
    {
        character_pre_y = character_y;
8010a46f:	a1 04 e5 10 80       	mov    0x8010e504,%eax
8010a474:	a3 00 e5 10 80       	mov    %eax,0x8010e500
        if (y == VK_UP)
8010a479:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a47c:	3d e1 00 00 00       	cmp    $0xe1,%eax
8010a481:	75 0f                	jne    8010a492 <sys_changePosition+0x98>
            character_y--;
8010a483:	a1 04 e5 10 80       	mov    0x8010e504,%eax
8010a488:	83 e8 01             	sub    $0x1,%eax
8010a48b:	a3 04 e5 10 80       	mov    %eax,0x8010e504
8010a490:	eb 0d                	jmp    8010a49f <sys_changePosition+0xa5>
        else
            character_y++;
8010a492:	a1 04 e5 10 80       	mov    0x8010e504,%eax
8010a497:	83 c0 01             	add    $0x1,%eax
8010a49a:	a3 04 e5 10 80       	mov    %eax,0x8010e504
    }
    return 0;
8010a49f:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a4a4:	c9                   	leave  
8010a4a5:	c3                   	ret    

8010a4a6 <sys_initStringFigure>:

char GBK2312[GBK2312_SIZE];
char ASCII[ASCII_SIZE];

int sys_initStringFigure(void)
{
8010a4a6:	55                   	push   %ebp
8010a4a7:	89 e5                	mov    %esp,%ebp
8010a4a9:	53                   	push   %ebx
8010a4aa:	83 ec 24             	sub    $0x24,%esp
    char * gbk2312 = 0;
8010a4ad:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    int n1;
    char * ascii = 0;
8010a4b4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    int n2;
    if (argstr(0, (char **)&gbk2312) < 0 || argint(1, &n1) < 0 || argstr(2, (char **)&ascii) < 0 || argint(3, &n2) < 0)
8010a4bb:	83 ec 08             	sub    $0x8,%esp
8010a4be:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010a4c1:	50                   	push   %eax
8010a4c2:	6a 00                	push   $0x0
8010a4c4:	e8 b4 af ff ff       	call   8010547d <argstr>
8010a4c9:	83 c4 10             	add    $0x10,%esp
8010a4cc:	85 c0                	test   %eax,%eax
8010a4ce:	78 3f                	js     8010a50f <sys_initStringFigure+0x69>
8010a4d0:	83 ec 08             	sub    $0x8,%esp
8010a4d3:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010a4d6:	50                   	push   %eax
8010a4d7:	6a 01                	push   $0x1
8010a4d9:	e8 1a af ff ff       	call   801053f8 <argint>
8010a4de:	83 c4 10             	add    $0x10,%esp
8010a4e1:	85 c0                	test   %eax,%eax
8010a4e3:	78 2a                	js     8010a50f <sys_initStringFigure+0x69>
8010a4e5:	83 ec 08             	sub    $0x8,%esp
8010a4e8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010a4eb:	50                   	push   %eax
8010a4ec:	6a 02                	push   $0x2
8010a4ee:	e8 8a af ff ff       	call   8010547d <argstr>
8010a4f3:	83 c4 10             	add    $0x10,%esp
8010a4f6:	85 c0                	test   %eax,%eax
8010a4f8:	78 15                	js     8010a50f <sys_initStringFigure+0x69>
8010a4fa:	83 ec 08             	sub    $0x8,%esp
8010a4fd:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010a500:	50                   	push   %eax
8010a501:	6a 03                	push   $0x3
8010a503:	e8 f0 ae ff ff       	call   801053f8 <argint>
8010a508:	83 c4 10             	add    $0x10,%esp
8010a50b:	85 c0                	test   %eax,%eax
8010a50d:	79 0a                	jns    8010a519 <sys_initStringFigure+0x73>
        return -1;
8010a50f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a514:	e9 8f 00 00 00       	jmp    8010a5a8 <sys_initStringFigure+0x102>
    for (int i = 0; i < n1; i += 32)
8010a519:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010a520:	eb 5f                	jmp    8010a581 <sys_initStringFigure+0xdb>
    {
        for (int j = 0; j < 16; ++j)
8010a522:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010a529:	eb 4c                	jmp    8010a577 <sys_initStringFigure+0xd1>
        {
            GBK2312[i + j] = gbk2312[i + 2 * j];
8010a52b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a52e:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a531:	01 c2                	add    %eax,%edx
8010a533:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a536:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010a539:	8d 1c 09             	lea    (%ecx,%ecx,1),%ebx
8010a53c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010a53f:	01 d9                	add    %ebx,%ecx
8010a541:	01 c8                	add    %ecx,%eax
8010a543:	0f b6 00             	movzbl (%eax),%eax
8010a546:	88 82 a0 bc 11 80    	mov    %al,-0x7fee4360(%edx)
            GBK2312[i + 16 + j] = gbk2312[i + 2 * j + 1];
8010a54c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a54f:	8d 50 10             	lea    0x10(%eax),%edx
8010a552:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a555:	01 c2                	add    %eax,%edx
8010a557:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a55a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010a55d:	8d 1c 09             	lea    (%ecx,%ecx,1),%ebx
8010a560:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010a563:	01 d9                	add    %ebx,%ecx
8010a565:	83 c1 01             	add    $0x1,%ecx
8010a568:	01 c8                	add    %ecx,%eax
8010a56a:	0f b6 00             	movzbl (%eax),%eax
8010a56d:	88 82 a0 bc 11 80    	mov    %al,-0x7fee4360(%edx)
    int n2;
    if (argstr(0, (char **)&gbk2312) < 0 || argint(1, &n1) < 0 || argstr(2, (char **)&ascii) < 0 || argint(3, &n2) < 0)
        return -1;
    for (int i = 0; i < n1; i += 32)
    {
        for (int j = 0; j < 16; ++j)
8010a573:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010a577:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
8010a57b:	7e ae                	jle    8010a52b <sys_initStringFigure+0x85>
    int n1;
    char * ascii = 0;
    int n2;
    if (argstr(0, (char **)&gbk2312) < 0 || argint(1, &n1) < 0 || argstr(2, (char **)&ascii) < 0 || argint(3, &n2) < 0)
        return -1;
    for (int i = 0; i < n1; i += 32)
8010a57d:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
8010a581:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a584:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010a587:	7c 99                	jl     8010a522 <sys_initStringFigure+0x7c>
        {
            GBK2312[i + j] = gbk2312[i + 2 * j];
            GBK2312[i + 16 + j] = gbk2312[i + 2 * j + 1];
        }
    }
    memmove(ASCII, ascii, sizeof(char) * n2);
8010a589:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010a58c:	89 c2                	mov    %eax,%edx
8010a58e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010a591:	83 ec 04             	sub    $0x4,%esp
8010a594:	52                   	push   %edx
8010a595:	50                   	push   %eax
8010a596:	68 60 b3 11 80       	push   $0x8011b360
8010a59b:	e8 f2 ab ff ff       	call   80105192 <memmove>
8010a5a0:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a5a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a5a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010a5ab:	c9                   	leave  
8010a5ac:	c3                   	ret    

8010a5ad <sys_sendMessage>:

int sys_sendMessage(void)
{
8010a5ad:	55                   	push   %ebp
8010a5ae:	89 e5                	mov    %esp,%ebp
8010a5b0:	83 ec 18             	sub    $0x18,%esp
    int wndId = 0;
8010a5b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    AMessage * msg = 0;
8010a5ba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    if (argint(0, &wndId) < 0 || argstr(1, (char**)&msg) < 0)
8010a5c1:	83 ec 08             	sub    $0x8,%esp
8010a5c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010a5c7:	50                   	push   %eax
8010a5c8:	6a 00                	push   $0x0
8010a5ca:	e8 29 ae ff ff       	call   801053f8 <argint>
8010a5cf:	83 c4 10             	add    $0x10,%esp
8010a5d2:	85 c0                	test   %eax,%eax
8010a5d4:	78 15                	js     8010a5eb <sys_sendMessage+0x3e>
8010a5d6:	83 ec 08             	sub    $0x8,%esp
8010a5d9:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010a5dc:	50                   	push   %eax
8010a5dd:	6a 01                	push   $0x1
8010a5df:	e8 99 ae ff ff       	call   8010547d <argstr>
8010a5e4:	83 c4 10             	add    $0x10,%esp
8010a5e7:	85 c0                	test   %eax,%eax
8010a5e9:	79 07                	jns    8010a5f2 <sys_sendMessage+0x45>
        return -1;
8010a5eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a5f0:	eb 18                	jmp    8010a60a <sys_sendMessage+0x5d>
    sendMessage(wndId, msg);
8010a5f2:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010a5f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a5f8:	83 ec 08             	sub    $0x8,%esp
8010a5fb:	52                   	push   %edx
8010a5fc:	50                   	push   %eax
8010a5fd:	e8 69 01 00 00       	call   8010a76b <sendMessage>
8010a602:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a605:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a60a:	c9                   	leave  
8010a60b:	c3                   	ret    

8010a60c <sys_registWindow>:

int sys_registWindow(void)
{
8010a60c:	55                   	push   %ebp
8010a60d:	89 e5                	mov    %esp,%ebp
8010a60f:	83 ec 18             	sub    $0x18,%esp
    AHwnd hwnd = 0;
8010a612:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (argstr(0, (char **)&hwnd) < 0)
8010a619:	83 ec 08             	sub    $0x8,%esp
8010a61c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010a61f:	50                   	push   %eax
8010a620:	6a 00                	push   $0x0
8010a622:	e8 56 ae ff ff       	call   8010547d <argstr>
8010a627:	83 c4 10             	add    $0x10,%esp
8010a62a:	85 c0                	test   %eax,%eax
8010a62c:	79 07                	jns    8010a635 <sys_registWindow+0x29>
        return -1;
8010a62e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a633:	eb 19                	jmp    8010a64e <sys_registWindow+0x42>
    APWndListAddToHead(&wndList, hwnd);
8010a635:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a638:	83 ec 08             	sub    $0x8,%esp
8010a63b:	50                   	push   %eax
8010a63c:	68 80 57 11 80       	push   $0x80115780
8010a641:	e8 19 03 00 00       	call   8010a95f <APWndListAddToHead>
8010a646:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a649:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a64e:	c9                   	leave  
8010a64f:	c3                   	ret    

8010a650 <sys_getMessage>:

int sys_getMessage(void)
{
8010a650:	55                   	push   %ebp
8010a651:	89 e5                	mov    %esp,%ebp
8010a653:	53                   	push   %ebx
8010a654:	83 ec 24             	sub    $0x24,%esp

    AHwnd hwnd = 0;
8010a657:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (argstr(0, (char **)&hwnd) < 0)
8010a65e:	83 ec 08             	sub    $0x8,%esp
8010a661:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010a664:	50                   	push   %eax
8010a665:	6a 00                	push   $0x0
8010a667:	e8 11 ae ff ff       	call   8010547d <argstr>
8010a66c:	83 c4 10             	add    $0x10,%esp
8010a66f:	85 c0                	test   %eax,%eax
8010a671:	79 0a                	jns    8010a67d <sys_getMessage+0x2d>
        return -1;
8010a673:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a678:	e9 e9 00 00 00       	jmp    8010a766 <sys_getMessage+0x116>
    int wndId = hwnd->id;
8010a67d:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a680:	8b 00                	mov    (%eax),%eax
8010a682:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int pid = hwnd->pid;
8010a685:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a688:	8b 40 04             	mov    0x4(%eax),%eax
8010a68b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    //cprintf("in function --- getMessage:WndId: %d\n",wndId);
    
    acquire(&wndList.data[wndId].lock);
8010a68e:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a691:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a697:	05 80 57 11 80       	add    $0x80115780,%eax
8010a69c:	83 c0 08             	add    $0x8,%eax
8010a69f:	83 ec 0c             	sub    $0xc,%esp
8010a6a2:	50                   	push   %eax
8010a6a3:	e8 c8 a7 ff ff       	call   80104e70 <acquire>
8010a6a8:	83 c4 10             	add    $0x10,%esp
    AMsgQueue * queue = &wndList.data[wndId].msgQueue;
8010a6ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a6ae:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a6b4:	83 c0 30             	add    $0x30,%eax
8010a6b7:	05 80 57 11 80       	add    $0x80115780,%eax
8010a6bc:	83 c0 0c             	add    $0xc,%eax
8010a6bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
    
    //cprintf("head:%d,tail:%d \n",queue->head,queue->tail);
    if (queue->head == queue->tail)
8010a6c2:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a6c5:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010a6cb:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a6ce:	8b 80 04 03 00 00    	mov    0x304(%eax),%eax
8010a6d4:	39 c2                	cmp    %eax,%edx
8010a6d6:	75 21                	jne    8010a6f9 <sys_getMessage+0xa9>
    {
       // cprintf("sleeping\n");
        sleep((void *)pid,&wndList.data[wndId].lock);
8010a6d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a6db:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a6e1:	05 80 57 11 80       	add    $0x80115780,%eax
8010a6e6:	8d 50 08             	lea    0x8(%eax),%edx
8010a6e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a6ec:	83 ec 08             	sub    $0x8,%esp
8010a6ef:	52                   	push   %edx
8010a6f0:	50                   	push   %eax
8010a6f1:	e8 81 a4 ff ff       	call   80104b77 <sleep>
8010a6f6:	83 c4 10             	add    $0x10,%esp
    }
    if (wndList.data[wndId].hwnd->msg.type == MSG_NULL)
8010a6f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a6fc:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a702:	05 c4 5a 11 80       	add    $0x80115ac4,%eax
8010a707:	8b 00                	mov    (%eax),%eax
8010a709:	8b 40 6c             	mov    0x6c(%eax),%eax
8010a70c:	85 c0                	test   %eax,%eax
8010a70e:	75 34                	jne    8010a744 <sys_getMessage+0xf4>
    {
      //  cprintf("poping msg!\n");
        wndList.data[wndId].hwnd->msg = APMsgQueueDeQueue(queue);
8010a710:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a713:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a719:	05 c4 5a 11 80       	add    $0x80115ac4,%eax
8010a71e:	8b 18                	mov    (%eax),%ebx
8010a720:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010a723:	83 ec 08             	sub    $0x8,%esp
8010a726:	ff 75 ec             	pushl  -0x14(%ebp)
8010a729:	50                   	push   %eax
8010a72a:	e8 ca 06 00 00       	call   8010adf9 <APMsgQueueDeQueue>
8010a72f:	83 c4 0c             	add    $0xc,%esp
8010a732:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010a735:	89 43 6c             	mov    %eax,0x6c(%ebx)
8010a738:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010a73b:	89 43 70             	mov    %eax,0x70(%ebx)
8010a73e:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010a741:	89 43 74             	mov    %eax,0x74(%ebx)
    }
    
    release(&wndList.data[wndId].lock);
8010a744:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a747:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a74d:	05 80 57 11 80       	add    $0x80115780,%eax
8010a752:	83 c0 08             	add    $0x8,%eax
8010a755:	83 ec 0c             	sub    $0xc,%esp
8010a758:	50                   	push   %eax
8010a759:	e8 79 a7 ff ff       	call   80104ed7 <release>
8010a75e:	83 c4 10             	add    $0x10,%esp
    return 0;
8010a761:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a766:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010a769:	c9                   	leave  
8010a76a:	c3                   	ret    

8010a76b <sendMessage>:


void sendMessage(int wndId, AMessage *msg)
{
8010a76b:	55                   	push   %ebp
8010a76c:	89 e5                	mov    %esp,%ebp
8010a76e:	83 ec 18             	sub    $0x18,%esp
cprintf("sendMessage,Messgaetype:%d\n",msg->type);
8010a771:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a774:	8b 00                	mov    (%eax),%eax
8010a776:	83 ec 08             	sub    $0x8,%esp
8010a779:	50                   	push   %eax
8010a77a:	68 ae bb 10 80       	push   $0x8010bbae
8010a77f:	e8 42 5c ff ff       	call   801003c6 <cprintf>
8010a784:	83 c4 10             	add    $0x10,%esp
    if (wndId == -1 || wndList.data[wndId].hwnd == 0)
8010a787:	83 7d 08 ff          	cmpl   $0xffffffff,0x8(%ebp)
8010a78b:	0f 84 ad 00 00 00    	je     8010a83e <sendMessage+0xd3>
8010a791:	8b 45 08             	mov    0x8(%ebp),%eax
8010a794:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a79a:	05 c4 5a 11 80       	add    $0x80115ac4,%eax
8010a79f:	8b 00                	mov    (%eax),%eax
8010a7a1:	85 c0                	test   %eax,%eax
8010a7a3:	0f 84 95 00 00 00    	je     8010a83e <sendMessage+0xd3>
        return;
    //cprintf("send message: WndID:%d \n",wndId);
    switch (msg->type)
8010a7a9:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a7ac:	8b 00                	mov    (%eax),%eax
8010a7ae:	83 f8 06             	cmp    $0x6,%eax
8010a7b1:	74 2d                	je     8010a7e0 <sendMessage+0x75>
8010a7b3:	83 f8 06             	cmp    $0x6,%eax
8010a7b6:	77 07                	ja     8010a7bf <sendMessage+0x54>
8010a7b8:	83 f8 05             	cmp    $0x5,%eax
8010a7bb:	74 0e                	je     8010a7cb <sendMessage+0x60>
	case MSG_HANDLE_DOWN:
	    break;
	case MSG_HANDLE_UP:
	    break;
	default:
	    break;
8010a7bd:	eb 28                	jmp    8010a7e7 <sendMessage+0x7c>
{
cprintf("sendMessage,Messgaetype:%d\n",msg->type);
    if (wndId == -1 || wndList.data[wndId].hwnd == 0)
        return;
    //cprintf("send message: WndID:%d \n",wndId);
    switch (msg->type)
8010a7bf:	83 f8 07             	cmp    $0x7,%eax
8010a7c2:	74 1f                	je     8010a7e3 <sendMessage+0x78>
8010a7c4:	83 f8 08             	cmp    $0x8,%eax
8010a7c7:	74 1d                	je     8010a7e6 <sendMessage+0x7b>
	case MSG_HANDLE_DOWN:
	    break;
	case MSG_HANDLE_UP:
	    break;
	default:
	    break;
8010a7c9:	eb 1c                	jmp    8010a7e7 <sendMessage+0x7c>
    //cprintf("send message: WndID:%d \n",wndId);
    switch (msg->type)
    {
	case MSG_KEY_UP:
		
		cprintf("WndId:%d",wndId);	    
8010a7cb:	83 ec 08             	sub    $0x8,%esp
8010a7ce:	ff 75 08             	pushl  0x8(%ebp)
8010a7d1:	68 ca bb 10 80       	push   $0x8010bbca
8010a7d6:	e8 eb 5b ff ff       	call   801003c6 <cprintf>
8010a7db:	83 c4 10             	add    $0x10,%esp
//APCharacterMove(msg->param);
	    break;
8010a7de:	eb 07                	jmp    8010a7e7 <sendMessage+0x7c>
	case MSG_KEY_DOWN:

	    break;
8010a7e0:	90                   	nop
8010a7e1:	eb 04                	jmp    8010a7e7 <sendMessage+0x7c>
	case MSG_HANDLE_DOWN:
	    break;
8010a7e3:	90                   	nop
8010a7e4:	eb 01                	jmp    8010a7e7 <sendMessage+0x7c>
	case MSG_HANDLE_UP:
	    break;
8010a7e6:	90                   	nop
	    break;

    }


    AMsgQueue * queue = &wndList.data[wndId].msgQueue;
8010a7e7:	8b 45 08             	mov    0x8(%ebp),%eax
8010a7ea:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a7f0:	83 c0 30             	add    $0x30,%eax
8010a7f3:	05 80 57 11 80       	add    $0x80115780,%eax
8010a7f8:	83 c0 0c             	add    $0xc,%eax
8010a7fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    msg->wndID = wndId;
8010a7fe:	8b 55 08             	mov    0x8(%ebp),%edx
8010a801:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a804:	89 50 08             	mov    %edx,0x8(%eax)
    APMsgQueueEnQueue(queue, *msg);
8010a807:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a80a:	ff 70 08             	pushl  0x8(%eax)
8010a80d:	ff 70 04             	pushl  0x4(%eax)
8010a810:	ff 30                	pushl  (%eax)
8010a812:	ff 75 f4             	pushl  -0xc(%ebp)
8010a815:	e8 64 05 00 00       	call   8010ad7e <APMsgQueueEnQueue>
8010a81a:	83 c4 10             	add    $0x10,%esp
    wakeup((void *)wndList.data[wndId].hwnd->pid);
8010a81d:	8b 45 08             	mov    0x8(%ebp),%eax
8010a820:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a826:	05 c4 5a 11 80       	add    $0x80115ac4,%eax
8010a82b:	8b 00                	mov    (%eax),%eax
8010a82d:	8b 40 04             	mov    0x4(%eax),%eax
8010a830:	83 ec 0c             	sub    $0xc,%esp
8010a833:	50                   	push   %eax
8010a834:	e8 29 a4 ff ff       	call   80104c62 <wakeup>
8010a839:	83 c4 10             	add    $0x10,%esp
8010a83c:	eb 01                	jmp    8010a83f <sendMessage+0xd4>

void sendMessage(int wndId, AMessage *msg)
{
cprintf("sendMessage,Messgaetype:%d\n",msg->type);
    if (wndId == -1 || wndList.data[wndId].hwnd == 0)
        return;
8010a83e:	90                   	nop

    AMsgQueue * queue = &wndList.data[wndId].msgQueue;
    msg->wndID = wndId;
    APMsgQueueEnQueue(queue, *msg);
    wakeup((void *)wndList.data[wndId].hwnd->pid);
}
8010a83f:	c9                   	leave  
8010a840:	c3                   	ret    

8010a841 <APWndListInit>:
//------------------------------------------------------------------------------------
//WndList

//space--insert_position
void APWndListInit(AWndList * list)
{
8010a841:	55                   	push   %ebp
8010a842:	89 e5                	mov    %esp,%ebp
8010a844:	83 ec 18             	sub    $0x18,%esp
    int i = 0;
8010a847:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    for (i = 0; i < MAX_WND_NUM; ++i)
8010a84e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010a855:	e9 8c 00 00 00       	jmp    8010a8e6 <APWndListInit+0xa5>
    {
        list->data[i].hwnd = 0;
8010a85a:	8b 55 08             	mov    0x8(%ebp),%edx
8010a85d:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a860:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a866:	01 d0                	add    %edx,%eax
8010a868:	05 44 03 00 00       	add    $0x344,%eax
8010a86d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
        list->data[i].prev = -1;
8010a873:	8b 55 08             	mov    0x8(%ebp),%edx
8010a876:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a879:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a87f:	01 d0                	add    %edx,%eax
8010a881:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
        list->data[i].next = i + 1;
8010a887:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a88a:	8d 50 01             	lea    0x1(%eax),%edx
8010a88d:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010a890:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a893:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a899:	01 c8                	add    %ecx,%eax
8010a89b:	83 c0 04             	add    $0x4,%eax
8010a89e:	89 10                	mov    %edx,(%eax)
        APMsgQueueInit(&list->data[i].msgQueue);
8010a8a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a8a3:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a8a9:	8d 50 30             	lea    0x30(%eax),%edx
8010a8ac:	8b 45 08             	mov    0x8(%ebp),%eax
8010a8af:	01 d0                	add    %edx,%eax
8010a8b1:	83 c0 0c             	add    $0xc,%eax
8010a8b4:	83 ec 0c             	sub    $0xc,%esp
8010a8b7:	50                   	push   %eax
8010a8b8:	e8 9c 04 00 00       	call   8010ad59 <APMsgQueueInit>
8010a8bd:	83 c4 10             	add    $0x10,%esp
        initlock(&list->data[i].lock, "msglock");
8010a8c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a8c3:	69 d0 48 03 00 00    	imul   $0x348,%eax,%edx
8010a8c9:	8b 45 08             	mov    0x8(%ebp),%eax
8010a8cc:	01 d0                	add    %edx,%eax
8010a8ce:	83 c0 08             	add    $0x8,%eax
8010a8d1:	83 ec 08             	sub    $0x8,%esp
8010a8d4:	68 d3 bb 10 80       	push   $0x8010bbd3
8010a8d9:	50                   	push   %eax
8010a8da:	e8 6f a5 ff ff       	call   80104e4e <initlock>
8010a8df:	83 c4 10             	add    $0x10,%esp

//space--insert_position
void APWndListInit(AWndList * list)
{
    int i = 0;
    for (i = 0; i < MAX_WND_NUM; ++i)
8010a8e2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010a8e6:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010a8ea:	0f 8e 6a ff ff ff    	jle    8010a85a <APWndListInit+0x19>
        list->data[i].prev = -1;
        list->data[i].next = i + 1;
        APMsgQueueInit(&list->data[i].msgQueue);
        initlock(&list->data[i].lock, "msglock");
    }
    list->data[i - 1].next = -1;
8010a8f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a8f3:	83 e8 01             	sub    $0x1,%eax
8010a8f6:	8b 55 08             	mov    0x8(%ebp),%edx
8010a8f9:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a8ff:	01 d0                	add    %edx,%eax
8010a901:	83 c0 04             	add    $0x4,%eax
8010a904:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    initlock(&list->lock, "wndListLock");
8010a90a:	8b 45 08             	mov    0x8(%ebp),%eax
8010a90d:	05 e0 20 00 00       	add    $0x20e0,%eax
8010a912:	83 ec 08             	sub    $0x8,%esp
8010a915:	68 db bb 10 80       	push   $0x8010bbdb
8010a91a:	50                   	push   %eax
8010a91b:	e8 2e a5 ff ff       	call   80104e4e <initlock>
8010a920:	83 c4 10             	add    $0x10,%esp
    list->head = list->tail  = -1;
8010a923:	8b 45 08             	mov    0x8(%ebp),%eax
8010a926:	c7 80 d4 20 00 00 ff 	movl   $0xffffffff,0x20d4(%eax)
8010a92d:	ff ff ff 
8010a930:	8b 45 08             	mov    0x8(%ebp),%eax
8010a933:	8b 90 d4 20 00 00    	mov    0x20d4(%eax),%edx
8010a939:	8b 45 08             	mov    0x8(%ebp),%eax
8010a93c:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
    list->desktop = 0;
8010a942:	8b 45 08             	mov    0x8(%ebp),%eax
8010a945:	c7 80 dc 20 00 00 00 	movl   $0x0,0x20dc(%eax)
8010a94c:	00 00 00 
    list->space = 0;
8010a94f:	8b 45 08             	mov    0x8(%ebp),%eax
8010a952:	c7 80 d8 20 00 00 00 	movl   $0x0,0x20d8(%eax)
8010a959:	00 00 00 
}
8010a95c:	90                   	nop
8010a95d:	c9                   	leave  
8010a95e:	c3                   	ret    

8010a95f <APWndListAddToHead>:

void APWndListAddToHead(AWndList * list, AHwnd hwnd)
{
8010a95f:	55                   	push   %ebp
8010a960:	89 e5                	mov    %esp,%ebp
8010a962:	83 ec 18             	sub    $0x18,%esp
    acquire(&list->lock);
8010a965:	8b 45 08             	mov    0x8(%ebp),%eax
8010a968:	05 e0 20 00 00       	add    $0x20e0,%eax
8010a96d:	83 ec 0c             	sub    $0xc,%esp
8010a970:	50                   	push   %eax
8010a971:	e8 fa a4 ff ff       	call   80104e70 <acquire>
8010a976:	83 c4 10             	add    $0x10,%esp
    int p = list->space;
8010a979:	8b 45 08             	mov    0x8(%ebp),%eax
8010a97c:	8b 80 d8 20 00 00    	mov    0x20d8(%eax),%eax
8010a982:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == -1)
8010a985:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010a989:	75 15                	jne    8010a9a0 <APWndListAddToHead+0x41>
    {
        cprintf("too much window\n");
8010a98b:	83 ec 0c             	sub    $0xc,%esp
8010a98e:	68 e7 bb 10 80       	push   $0x8010bbe7
8010a993:	e8 2e 5a ff ff       	call   801003c6 <cprintf>
8010a998:	83 c4 10             	add    $0x10,%esp
        return;
8010a99b:	e9 c8 00 00 00       	jmp    8010aa68 <APWndListAddToHead+0x109>
    }
    list->space = list->data[list->space].next;
8010a9a0:	8b 45 08             	mov    0x8(%ebp),%eax
8010a9a3:	8b 80 d8 20 00 00    	mov    0x20d8(%eax),%eax
8010a9a9:	8b 55 08             	mov    0x8(%ebp),%edx
8010a9ac:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a9b2:	01 d0                	add    %edx,%eax
8010a9b4:	83 c0 04             	add    $0x4,%eax
8010a9b7:	8b 10                	mov    (%eax),%edx
8010a9b9:	8b 45 08             	mov    0x8(%ebp),%eax
8010a9bc:	89 90 d8 20 00 00    	mov    %edx,0x20d8(%eax)
    list->data[p].hwnd = hwnd;
8010a9c2:	8b 55 08             	mov    0x8(%ebp),%edx
8010a9c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a9c8:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010a9ce:	01 d0                	add    %edx,%eax
8010a9d0:	8d 90 44 03 00 00    	lea    0x344(%eax),%edx
8010a9d6:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a9d9:	89 02                	mov    %eax,(%edx)
    
    hwnd->id = p;
8010a9db:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a9de:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a9e1:	89 10                	mov    %edx,(%eax)
    
    //desktop ---- id = 0
    list->data[p].next = list->head;
8010a9e3:	8b 45 08             	mov    0x8(%ebp),%eax
8010a9e6:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010a9ec:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010a9ef:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a9f2:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010a9f8:	01 ca                	add    %ecx,%edx
8010a9fa:	83 c2 04             	add    $0x4,%edx
8010a9fd:	89 02                	mov    %eax,(%edx)
    list->data[p].prev = -1;
8010a9ff:	8b 55 08             	mov    0x8(%ebp),%edx
8010aa02:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010aa05:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa0b:	01 d0                	add    %edx,%eax
8010aa0d:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    if (list->head == -1)
8010aa13:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa16:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010aa1c:	83 f8 ff             	cmp    $0xffffffff,%eax
8010aa1f:	75 0e                	jne    8010aa2f <APWndListAddToHead+0xd0>
        list->tail = p;
8010aa21:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa24:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010aa27:	89 90 d4 20 00 00    	mov    %edx,0x20d4(%eax)
8010aa2d:	eb 19                	jmp    8010aa48 <APWndListAddToHead+0xe9>
    else
        list->data[list->head].prev = p;
8010aa2f:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa32:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010aa38:	8b 55 08             	mov    0x8(%ebp),%edx
8010aa3b:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aa41:	01 c2                	add    %eax,%edx
8010aa43:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010aa46:	89 02                	mov    %eax,(%edx)
    
    list->head = p;
8010aa48:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa4b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010aa4e:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
    release(&list->lock);
8010aa54:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa57:	05 e0 20 00 00       	add    $0x20e0,%eax
8010aa5c:	83 ec 0c             	sub    $0xc,%esp
8010aa5f:	50                   	push   %eax
8010aa60:	e8 72 a4 ff ff       	call   80104ed7 <release>
8010aa65:	83 c4 10             	add    $0x10,%esp
}
8010aa68:	c9                   	leave  
8010aa69:	c3                   	ret    

8010aa6a <APWndListMoveToHead>:

void APWndListMoveToHead(AWndList * list, int wndId)
{
8010aa6a:	55                   	push   %ebp
8010aa6b:	89 e5                	mov    %esp,%ebp
8010aa6d:	83 ec 08             	sub    $0x8,%esp
    if (wndId < 0)
8010aa70:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010aa74:	0f 88 27 01 00 00    	js     8010aba1 <APWndListMoveToHead+0x137>
        return;
    acquire(&list->lock);
8010aa7a:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa7d:	05 e0 20 00 00       	add    $0x20e0,%eax
8010aa82:	83 ec 0c             	sub    $0xc,%esp
8010aa85:	50                   	push   %eax
8010aa86:	e8 e5 a3 ff ff       	call   80104e70 <acquire>
8010aa8b:	83 c4 10             	add    $0x10,%esp
    if (wndId != list->head)
8010aa8e:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa91:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010aa97:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010aa9a:	0f 84 eb 00 00 00    	je     8010ab8b <APWndListMoveToHead+0x121>
    {
        list->data[list->data[wndId].prev].next = list->data[wndId].next;
8010aaa0:	8b 55 08             	mov    0x8(%ebp),%edx
8010aaa3:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aaa6:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aaac:	01 d0                	add    %edx,%eax
8010aaae:	8b 10                	mov    (%eax),%edx
8010aab0:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aab3:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aab6:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aabc:	01 c8                	add    %ecx,%eax
8010aabe:	83 c0 04             	add    $0x4,%eax
8010aac1:	8b 00                	mov    (%eax),%eax
8010aac3:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010aac6:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010aacc:	01 ca                	add    %ecx,%edx
8010aace:	83 c2 04             	add    $0x4,%edx
8010aad1:	89 02                	mov    %eax,(%edx)
        if (list->data[wndId].next == -1)
8010aad3:	8b 55 08             	mov    0x8(%ebp),%edx
8010aad6:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aad9:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aadf:	01 d0                	add    %edx,%eax
8010aae1:	83 c0 04             	add    $0x4,%eax
8010aae4:	8b 00                	mov    (%eax),%eax
8010aae6:	83 f8 ff             	cmp    $0xffffffff,%eax
8010aae9:	75 1b                	jne    8010ab06 <APWndListMoveToHead+0x9c>
            list->tail = list->data[wndId].prev;
8010aaeb:	8b 55 08             	mov    0x8(%ebp),%edx
8010aaee:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aaf1:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aaf7:	01 d0                	add    %edx,%eax
8010aaf9:	8b 10                	mov    (%eax),%edx
8010aafb:	8b 45 08             	mov    0x8(%ebp),%eax
8010aafe:	89 90 d4 20 00 00    	mov    %edx,0x20d4(%eax)
8010ab04:	eb 30                	jmp    8010ab36 <APWndListMoveToHead+0xcc>
        else
            list->data[list->data[wndId].next].prev = list->data[wndId].prev;
8010ab06:	8b 55 08             	mov    0x8(%ebp),%edx
8010ab09:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ab0c:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ab12:	01 d0                	add    %edx,%eax
8010ab14:	83 c0 04             	add    $0x4,%eax
8010ab17:	8b 10                	mov    (%eax),%edx
8010ab19:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010ab1c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ab1f:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ab25:	01 c8                	add    %ecx,%eax
8010ab27:	8b 00                	mov    (%eax),%eax
8010ab29:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010ab2c:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010ab32:	01 ca                	add    %ecx,%edx
8010ab34:	89 02                	mov    %eax,(%edx)

        list->data[list->head].prev = wndId;
8010ab36:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab39:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010ab3f:	8b 55 08             	mov    0x8(%ebp),%edx
8010ab42:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ab48:	01 c2                	add    %eax,%edx
8010ab4a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ab4d:	89 02                	mov    %eax,(%edx)
        list->data[wndId].prev = -1;
8010ab4f:	8b 55 08             	mov    0x8(%ebp),%edx
8010ab52:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ab55:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ab5b:	01 d0                	add    %edx,%eax
8010ab5d:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
        list->data[wndId].next = list->head;
8010ab63:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab66:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010ab6c:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010ab6f:	8b 55 0c             	mov    0xc(%ebp),%edx
8010ab72:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010ab78:	01 ca                	add    %ecx,%edx
8010ab7a:	83 c2 04             	add    $0x4,%edx
8010ab7d:	89 02                	mov    %eax,(%edx)
        list->head = wndId;
8010ab7f:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab82:	8b 55 0c             	mov    0xc(%ebp),%edx
8010ab85:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
    }
    release(&list->lock);
8010ab8b:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab8e:	05 e0 20 00 00       	add    $0x20e0,%eax
8010ab93:	83 ec 0c             	sub    $0xc,%esp
8010ab96:	50                   	push   %eax
8010ab97:	e8 3b a3 ff ff       	call   80104ed7 <release>
8010ab9c:	83 c4 10             	add    $0x10,%esp
8010ab9f:	eb 01                	jmp    8010aba2 <APWndListMoveToHead+0x138>
}

void APWndListMoveToHead(AWndList * list, int wndId)
{
    if (wndId < 0)
        return;
8010aba1:	90                   	nop
        list->data[wndId].prev = -1;
        list->data[wndId].next = list->head;
        list->head = wndId;
    }
    release(&list->lock);
}
8010aba2:	c9                   	leave  
8010aba3:	c3                   	ret    

8010aba4 <APWndListRemove>:

void APWndListRemove(AWndList * list, int wndId)
{
8010aba4:	55                   	push   %ebp
8010aba5:	89 e5                	mov    %esp,%ebp
8010aba7:	83 ec 08             	sub    $0x8,%esp
    if (wndId < 0)
8010abaa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010abae:	0f 88 71 01 00 00    	js     8010ad25 <APWndListRemove+0x181>
        return;
    acquire(&list->lock);
8010abb4:	8b 45 08             	mov    0x8(%ebp),%eax
8010abb7:	05 e0 20 00 00       	add    $0x20e0,%eax
8010abbc:	83 ec 0c             	sub    $0xc,%esp
8010abbf:	50                   	push   %eax
8010abc0:	e8 ab a2 ff ff       	call   80104e70 <acquire>
8010abc5:	83 c4 10             	add    $0x10,%esp
    if (wndId == list->head)
8010abc8:	8b 45 08             	mov    0x8(%ebp),%eax
8010abcb:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010abd1:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010abd4:	75 7a                	jne    8010ac50 <APWndListRemove+0xac>
    {
        if (list->data[wndId].next == -1)
8010abd6:	8b 55 08             	mov    0x8(%ebp),%edx
8010abd9:	8b 45 0c             	mov    0xc(%ebp),%eax
8010abdc:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010abe2:	01 d0                	add    %edx,%eax
8010abe4:	83 c0 04             	add    $0x4,%eax
8010abe7:	8b 00                	mov    (%eax),%eax
8010abe9:	83 f8 ff             	cmp    $0xffffffff,%eax
8010abec:	75 24                	jne    8010ac12 <APWndListRemove+0x6e>
            list->head = list->tail = -1;
8010abee:	8b 45 08             	mov    0x8(%ebp),%eax
8010abf1:	c7 80 d4 20 00 00 ff 	movl   $0xffffffff,0x20d4(%eax)
8010abf8:	ff ff ff 
8010abfb:	8b 45 08             	mov    0x8(%ebp),%eax
8010abfe:	8b 90 d4 20 00 00    	mov    0x20d4(%eax),%edx
8010ac04:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac07:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
8010ac0d:	e9 88 00 00 00       	jmp    8010ac9a <APWndListRemove+0xf6>
        else
        {
            list->head = list->data[list->head].next;
8010ac12:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac15:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010ac1b:	8b 55 08             	mov    0x8(%ebp),%edx
8010ac1e:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ac24:	01 d0                	add    %edx,%eax
8010ac26:	83 c0 04             	add    $0x4,%eax
8010ac29:	8b 10                	mov    (%eax),%edx
8010ac2b:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac2e:	89 90 d0 20 00 00    	mov    %edx,0x20d0(%eax)
            list->data[list->head].prev = -1;
8010ac34:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac37:	8b 80 d0 20 00 00    	mov    0x20d0(%eax),%eax
8010ac3d:	8b 55 08             	mov    0x8(%ebp),%edx
8010ac40:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ac46:	01 d0                	add    %edx,%eax
8010ac48:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
8010ac4e:	eb 4a                	jmp    8010ac9a <APWndListRemove+0xf6>
        }
    }
    else if (wndId == list->tail)
8010ac50:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac53:	8b 80 d4 20 00 00    	mov    0x20d4(%eax),%eax
8010ac59:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010ac5c:	75 3c                	jne    8010ac9a <APWndListRemove+0xf6>
    {
        list->tail = list->data[list->tail].prev;
8010ac5e:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac61:	8b 80 d4 20 00 00    	mov    0x20d4(%eax),%eax
8010ac67:	8b 55 08             	mov    0x8(%ebp),%edx
8010ac6a:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ac70:	01 d0                	add    %edx,%eax
8010ac72:	8b 10                	mov    (%eax),%edx
8010ac74:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac77:	89 90 d4 20 00 00    	mov    %edx,0x20d4(%eax)
        list->data[list->tail].next = -1;
8010ac7d:	8b 45 08             	mov    0x8(%ebp),%eax
8010ac80:	8b 80 d4 20 00 00    	mov    0x20d4(%eax),%eax
8010ac86:	8b 55 08             	mov    0x8(%ebp),%edx
8010ac89:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010ac8f:	01 d0                	add    %edx,%eax
8010ac91:	83 c0 04             	add    $0x4,%eax
8010ac94:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    }
    list->data[wndId].prev = -1;
8010ac9a:	8b 55 08             	mov    0x8(%ebp),%edx
8010ac9d:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aca0:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010aca6:	01 d0                	add    %edx,%eax
8010aca8:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    list->data[wndId].next = list->space;
8010acae:	8b 45 08             	mov    0x8(%ebp),%eax
8010acb1:	8b 80 d8 20 00 00    	mov    0x20d8(%eax),%eax
8010acb7:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010acba:	8b 55 0c             	mov    0xc(%ebp),%edx
8010acbd:	69 d2 48 03 00 00    	imul   $0x348,%edx,%edx
8010acc3:	01 ca                	add    %ecx,%edx
8010acc5:	83 c2 04             	add    $0x4,%edx
8010acc8:	89 02                	mov    %eax,(%edx)
    list->data[wndId].hwnd = 0;
8010acca:	8b 55 08             	mov    0x8(%ebp),%edx
8010accd:	8b 45 0c             	mov    0xc(%ebp),%eax
8010acd0:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010acd6:	01 d0                	add    %edx,%eax
8010acd8:	05 44 03 00 00       	add    $0x344,%eax
8010acdd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    list->space = wndId;
8010ace3:	8b 45 08             	mov    0x8(%ebp),%eax
8010ace6:	8b 55 0c             	mov    0xc(%ebp),%edx
8010ace9:	89 90 d8 20 00 00    	mov    %edx,0x20d8(%eax)

    APMsgQueueInit(&list->data[wndId].msgQueue);
8010acef:	8b 45 0c             	mov    0xc(%ebp),%eax
8010acf2:	69 c0 48 03 00 00    	imul   $0x348,%eax,%eax
8010acf8:	8d 50 30             	lea    0x30(%eax),%edx
8010acfb:	8b 45 08             	mov    0x8(%ebp),%eax
8010acfe:	01 d0                	add    %edx,%eax
8010ad00:	83 c0 0c             	add    $0xc,%eax
8010ad03:	83 ec 0c             	sub    $0xc,%esp
8010ad06:	50                   	push   %eax
8010ad07:	e8 4d 00 00 00       	call   8010ad59 <APMsgQueueInit>
8010ad0c:	83 c4 10             	add    $0x10,%esp
    
    release(&list->lock);
8010ad0f:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad12:	05 e0 20 00 00       	add    $0x20e0,%eax
8010ad17:	83 ec 0c             	sub    $0xc,%esp
8010ad1a:	50                   	push   %eax
8010ad1b:	e8 b7 a1 ff ff       	call   80104ed7 <release>
8010ad20:	83 c4 10             	add    $0x10,%esp
8010ad23:	eb 01                	jmp    8010ad26 <APWndListRemove+0x182>
}

void APWndListRemove(AWndList * list, int wndId)
{
    if (wndId < 0)
        return;
8010ad25:	90                   	nop
    list->space = wndId;

    APMsgQueueInit(&list->data[wndId].msgQueue);
    
    release(&list->lock);
}
8010ad26:	c9                   	leave  
8010ad27:	c3                   	ret    

8010ad28 <APWndListDestroy>:

void APWndListDestroy(AWndList * list)
{
8010ad28:	55                   	push   %ebp
8010ad29:	89 e5                	mov    %esp,%ebp
8010ad2b:	83 ec 08             	sub    $0x8,%esp
    acquire(&list->lock);
8010ad2e:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad31:	05 e0 20 00 00       	add    $0x20e0,%eax
8010ad36:	83 ec 0c             	sub    $0xc,%esp
8010ad39:	50                   	push   %eax
8010ad3a:	e8 31 a1 ff ff       	call   80104e70 <acquire>
8010ad3f:	83 c4 10             	add    $0x10,%esp
    release(&list->lock);
8010ad42:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad45:	05 e0 20 00 00       	add    $0x20e0,%eax
8010ad4a:	83 ec 0c             	sub    $0xc,%esp
8010ad4d:	50                   	push   %eax
8010ad4e:	e8 84 a1 ff ff       	call   80104ed7 <release>
8010ad53:	83 c4 10             	add    $0x10,%esp
}
8010ad56:	90                   	nop
8010ad57:	c9                   	leave  
8010ad58:	c3                   	ret    

8010ad59 <APMsgQueueInit>:

//Msg Queue
//head = start, tail = end next

void APMsgQueueInit(AMsgQueue * queue)
{
8010ad59:	55                   	push   %ebp
8010ad5a:	89 e5                	mov    %esp,%ebp
    // as an array
    queue->head = queue->tail = 0;
8010ad5c:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad5f:	c7 80 04 03 00 00 00 	movl   $0x0,0x304(%eax)
8010ad66:	00 00 00 
8010ad69:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad6c:	8b 90 04 03 00 00    	mov    0x304(%eax),%edx
8010ad72:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad75:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
}
8010ad7b:	90                   	nop
8010ad7c:	5d                   	pop    %ebp
8010ad7d:	c3                   	ret    

8010ad7e <APMsgQueueEnQueue>:

void APMsgQueueEnQueue(AMsgQueue * queue, AMessage msg)
{
8010ad7e:	55                   	push   %ebp
8010ad7f:	89 e5                	mov    %esp,%ebp
8010ad81:	83 ec 08             	sub    $0x8,%esp
    if ((queue->tail + 1) % MESSAGE_QUEUE_SIZE == queue->head)
8010ad84:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad87:	8b 80 04 03 00 00    	mov    0x304(%eax),%eax
8010ad8d:	83 c0 01             	add    $0x1,%eax
8010ad90:	83 e0 3f             	and    $0x3f,%eax
8010ad93:	89 c2                	mov    %eax,%edx
8010ad95:	8b 45 08             	mov    0x8(%ebp),%eax
8010ad98:	8b 80 00 03 00 00    	mov    0x300(%eax),%eax
8010ad9e:	39 c2                	cmp    %eax,%edx
8010ada0:	75 12                	jne    8010adb4 <APMsgQueueEnQueue+0x36>
    {
        cprintf("Error! Message Queue is full\n");
8010ada2:	83 ec 0c             	sub    $0xc,%esp
8010ada5:	68 f8 bb 10 80       	push   $0x8010bbf8
8010adaa:	e8 17 56 ff ff       	call   801003c6 <cprintf>
8010adaf:	83 c4 10             	add    $0x10,%esp
        return;
8010adb2:	eb 43                	jmp    8010adf7 <APMsgQueueEnQueue+0x79>
    }
    
    switch (msg.type)
    {
        default:
            break;
8010adb4:	90                   	nop
    }
    //cprintf("MsgQueue-En-Queue:tail %d \n",queue->tail);
    queue->data[queue->tail] = msg;
8010adb5:	8b 45 08             	mov    0x8(%ebp),%eax
8010adb8:	8b 90 04 03 00 00    	mov    0x304(%eax),%edx
8010adbe:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010adc1:	89 d0                	mov    %edx,%eax
8010adc3:	01 c0                	add    %eax,%eax
8010adc5:	01 d0                	add    %edx,%eax
8010adc7:	c1 e0 02             	shl    $0x2,%eax
8010adca:	01 c8                	add    %ecx,%eax
8010adcc:	8b 55 0c             	mov    0xc(%ebp),%edx
8010adcf:	89 10                	mov    %edx,(%eax)
8010add1:	8b 55 10             	mov    0x10(%ebp),%edx
8010add4:	89 50 04             	mov    %edx,0x4(%eax)
8010add7:	8b 55 14             	mov    0x14(%ebp),%edx
8010adda:	89 50 08             	mov    %edx,0x8(%eax)
    queue->tail = (queue->tail + 1) % MESSAGE_QUEUE_SIZE;
8010addd:	8b 45 08             	mov    0x8(%ebp),%eax
8010ade0:	8b 80 04 03 00 00    	mov    0x304(%eax),%eax
8010ade6:	83 c0 01             	add    $0x1,%eax
8010ade9:	83 e0 3f             	and    $0x3f,%eax
8010adec:	89 c2                	mov    %eax,%edx
8010adee:	8b 45 08             	mov    0x8(%ebp),%eax
8010adf1:	89 90 04 03 00 00    	mov    %edx,0x304(%eax)
    //cprintf("MsgQueue-En-Queue:after add tail %d \n",queue->tail);
}
8010adf7:	c9                   	leave  
8010adf8:	c3                   	ret    

8010adf9 <APMsgQueueDeQueue>:

//弹出消息队列顶端
AMessage APMsgQueueDeQueue(AMsgQueue * queue)
{
8010adf9:	55                   	push   %ebp
8010adfa:	89 e5                	mov    %esp,%ebp
8010adfc:	53                   	push   %ebx
8010adfd:	83 ec 10             	sub    $0x10,%esp
    if (queue->head == queue->tail)
8010ae00:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ae03:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010ae09:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ae0c:	8b 80 04 03 00 00    	mov    0x304(%eax),%eax
8010ae12:	39 c2                	cmp    %eax,%edx
8010ae14:	75 1d                	jne    8010ae33 <APMsgQueueDeQueue+0x3a>
    {
        AMessage msg;
        msg.type = MSG_NULL;
8010ae16:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        return msg;
8010ae1d:	8b 45 08             	mov    0x8(%ebp),%eax
8010ae20:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010ae23:	89 10                	mov    %edx,(%eax)
8010ae25:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010ae28:	89 50 04             	mov    %edx,0x4(%eax)
8010ae2b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ae2e:	89 50 08             	mov    %edx,0x8(%eax)
8010ae31:	eb 4a                	jmp    8010ae7d <APMsgQueueDeQueue+0x84>
    }
    int p = queue->head;
8010ae33:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ae36:	8b 80 00 03 00 00    	mov    0x300(%eax),%eax
8010ae3c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    queue->head = (queue->head + 1) % MESSAGE_QUEUE_SIZE;
8010ae3f:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ae42:	8b 80 00 03 00 00    	mov    0x300(%eax),%eax
8010ae48:	83 c0 01             	add    $0x1,%eax
8010ae4b:	83 e0 3f             	and    $0x3f,%eax
8010ae4e:	89 c2                	mov    %eax,%edx
8010ae50:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ae53:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
    return queue->data[p];
8010ae59:	8b 55 08             	mov    0x8(%ebp),%edx
8010ae5c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010ae5f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
8010ae62:	89 c8                	mov    %ecx,%eax
8010ae64:	01 c0                	add    %eax,%eax
8010ae66:	01 c8                	add    %ecx,%eax
8010ae68:	c1 e0 02             	shl    $0x2,%eax
8010ae6b:	01 d8                	add    %ebx,%eax
8010ae6d:	8b 08                	mov    (%eax),%ecx
8010ae6f:	89 0a                	mov    %ecx,(%edx)
8010ae71:	8b 48 04             	mov    0x4(%eax),%ecx
8010ae74:	89 4a 04             	mov    %ecx,0x4(%edx)
8010ae77:	8b 40 08             	mov    0x8(%eax),%eax
8010ae7a:	89 42 08             	mov    %eax,0x8(%edx)
}
8010ae7d:	8b 45 08             	mov    0x8(%ebp),%eax
8010ae80:	83 c4 10             	add    $0x10,%esp
8010ae83:	5b                   	pop    %ebx
8010ae84:	5d                   	pop    %ebp
8010ae85:	c2 04 00             	ret    $0x4

8010ae88 <TimerCount>:

//-----------------------------------------------------------------------------
//Timer
void TimerCount()
{
8010ae88:	55                   	push   %ebp
8010ae89:	89 e5                	mov    %esp,%ebp
8010ae8b:	83 ec 18             	sub    $0x18,%esp
    if (!timerListReady)
8010ae8e:	a1 7c e6 10 80       	mov    0x8010e67c,%eax
8010ae93:	85 c0                	test   %eax,%eax
8010ae95:	0f 84 ea 00 00 00    	je     8010af85 <TimerCount+0xfd>
        return;
    acquire(&timerList.lock);
8010ae9b:	83 ec 0c             	sub    $0xc,%esp
8010ae9e:	68 50 bc 11 80       	push   $0x8011bc50
8010aea3:	e8 c8 9f ff ff       	call   80104e70 <acquire>
8010aea8:	83 c4 10             	add    $0x10,%esp
    int p = timerList.head;
8010aeab:	a1 48 bc 11 80       	mov    0x8011bc48,%eax
8010aeb0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while(p != -1)
8010aeb3:	e9 b1 00 00 00       	jmp    8010af69 <TimerCount+0xe1>
    {
        timerList.data[p].count ++;
8010aeb8:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010aebb:	89 d0                	mov    %edx,%eax
8010aebd:	c1 e0 02             	shl    $0x2,%eax
8010aec0:	01 d0                	add    %edx,%eax
8010aec2:	c1 e0 02             	shl    $0x2,%eax
8010aec5:	05 8c bb 11 80       	add    $0x8011bb8c,%eax
8010aeca:	8b 00                	mov    (%eax),%eax
8010aecc:	8d 48 01             	lea    0x1(%eax),%ecx
8010aecf:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010aed2:	89 d0                	mov    %edx,%eax
8010aed4:	c1 e0 02             	shl    $0x2,%eax
8010aed7:	01 d0                	add    %edx,%eax
8010aed9:	c1 e0 02             	shl    $0x2,%eax
8010aedc:	05 8c bb 11 80       	add    $0x8011bb8c,%eax
8010aee1:	89 08                	mov    %ecx,(%eax)
        if (timerList.data[p].count >= timerList.data[p].interval)
8010aee3:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010aee6:	89 d0                	mov    %edx,%eax
8010aee8:	c1 e0 02             	shl    $0x2,%eax
8010aeeb:	01 d0                	add    %edx,%eax
8010aeed:	c1 e0 02             	shl    $0x2,%eax
8010aef0:	05 8c bb 11 80       	add    $0x8011bb8c,%eax
8010aef5:	8b 08                	mov    (%eax),%ecx
8010aef7:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010aefa:	89 d0                	mov    %edx,%eax
8010aefc:	c1 e0 02             	shl    $0x2,%eax
8010aeff:	01 d0                	add    %edx,%eax
8010af01:	c1 e0 02             	shl    $0x2,%eax
8010af04:	05 88 bb 11 80       	add    $0x8011bb88,%eax
8010af09:	8b 00                	mov    (%eax),%eax
8010af0b:	39 c1                	cmp    %eax,%ecx
8010af0d:	7c 43                	jl     8010af52 <TimerCount+0xca>
        {
            timerList.data[p].count = 0;
8010af0f:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010af12:	89 d0                	mov    %edx,%eax
8010af14:	c1 e0 02             	shl    $0x2,%eax
8010af17:	01 d0                	add    %edx,%eax
8010af19:	c1 e0 02             	shl    $0x2,%eax
8010af1c:	05 8c bb 11 80       	add    $0x8011bb8c,%eax
8010af21:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
            AMessage msg;
            msg.type = MSG_TIMEOUT;
8010af27:	c7 45 e8 04 00 00 00 	movl   $0x4,-0x18(%ebp)
            sendMessage(timerList.data[p].wndId,&msg);
8010af2e:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010af31:	89 d0                	mov    %edx,%eax
8010af33:	c1 e0 02             	shl    $0x2,%eax
8010af36:	01 d0                	add    %edx,%eax
8010af38:	c1 e0 02             	shl    $0x2,%eax
8010af3b:	05 80 bb 11 80       	add    $0x8011bb80,%eax
8010af40:	8b 00                	mov    (%eax),%eax
8010af42:	83 ec 08             	sub    $0x8,%esp
8010af45:	8d 55 e8             	lea    -0x18(%ebp),%edx
8010af48:	52                   	push   %edx
8010af49:	50                   	push   %eax
8010af4a:	e8 1c f8 ff ff       	call   8010a76b <sendMessage>
8010af4f:	83 c4 10             	add    $0x10,%esp
        }
        p = timerList.data[p].next;
8010af52:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010af55:	89 d0                	mov    %edx,%eax
8010af57:	c1 e0 02             	shl    $0x2,%eax
8010af5a:	01 d0                	add    %edx,%eax
8010af5c:	c1 e0 02             	shl    $0x2,%eax
8010af5f:	05 90 bb 11 80       	add    $0x8011bb90,%eax
8010af64:	8b 00                	mov    (%eax),%eax
8010af66:	89 45 f4             	mov    %eax,-0xc(%ebp)
{
    if (!timerListReady)
        return;
    acquire(&timerList.lock);
    int p = timerList.head;
    while(p != -1)
8010af69:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010af6d:	0f 85 45 ff ff ff    	jne    8010aeb8 <TimerCount+0x30>
            msg.type = MSG_TIMEOUT;
            sendMessage(timerList.data[p].wndId,&msg);
        }
        p = timerList.data[p].next;
    }
    release(&timerList.lock);
8010af73:	83 ec 0c             	sub    $0xc,%esp
8010af76:	68 50 bc 11 80       	push   $0x8011bc50
8010af7b:	e8 57 9f ff ff       	call   80104ed7 <release>
8010af80:	83 c4 10             	add    $0x10,%esp
8010af83:	eb 01                	jmp    8010af86 <TimerCount+0xfe>
//-----------------------------------------------------------------------------
//Timer
void TimerCount()
{
    if (!timerListReady)
        return;
8010af85:	90                   	nop
            sendMessage(timerList.data[p].wndId,&msg);
        }
        p = timerList.data[p].next;
    }
    release(&timerList.lock);
}
8010af86:	c9                   	leave  
8010af87:	c3                   	ret    

8010af88 <APTimerListInit>:


void APTimerListInit(ATimerList * list)
{
8010af88:	55                   	push   %ebp
8010af89:	89 e5                	mov    %esp,%ebp
8010af8b:	53                   	push   %ebx
8010af8c:	83 ec 14             	sub    $0x14,%esp
    int i;
    for (i = 0; i < MAX_TIMER_NUM; i++)
8010af8f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010af96:	eb 21                	jmp    8010afb9 <APTimerListInit+0x31>
        list->data[i].next = i + 1;
8010af98:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010af9b:	8d 48 01             	lea    0x1(%eax),%ecx
8010af9e:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010afa1:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010afa4:	89 d0                	mov    %edx,%eax
8010afa6:	c1 e0 02             	shl    $0x2,%eax
8010afa9:	01 d0                	add    %edx,%eax
8010afab:	c1 e0 02             	shl    $0x2,%eax
8010afae:	01 d8                	add    %ebx,%eax
8010afb0:	83 c0 10             	add    $0x10,%eax
8010afb3:	89 08                	mov    %ecx,(%eax)


void APTimerListInit(ATimerList * list)
{
    int i;
    for (i = 0; i < MAX_TIMER_NUM; i++)
8010afb5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010afb9:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010afbd:	7e d9                	jle    8010af98 <APTimerListInit+0x10>
        list->data[i].next = i + 1;
    list->head = -1;
8010afbf:	8b 45 08             	mov    0x8(%ebp),%eax
8010afc2:	c7 80 c8 00 00 00 ff 	movl   $0xffffffff,0xc8(%eax)
8010afc9:	ff ff ff 
    list->space = 0;
8010afcc:	8b 45 08             	mov    0x8(%ebp),%eax
8010afcf:	c7 80 cc 00 00 00 00 	movl   $0x0,0xcc(%eax)
8010afd6:	00 00 00 
    list->data[i].next = -1;
8010afd9:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010afdc:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010afdf:	89 d0                	mov    %edx,%eax
8010afe1:	c1 e0 02             	shl    $0x2,%eax
8010afe4:	01 d0                	add    %edx,%eax
8010afe6:	c1 e0 02             	shl    $0x2,%eax
8010afe9:	01 c8                	add    %ecx,%eax
8010afeb:	83 c0 10             	add    $0x10,%eax
8010afee:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    initlock(&list->lock, "timerLock");
8010aff4:	8b 45 08             	mov    0x8(%ebp),%eax
8010aff7:	05 d0 00 00 00       	add    $0xd0,%eax
8010affc:	83 ec 08             	sub    $0x8,%esp
8010afff:	68 16 bc 10 80       	push   $0x8010bc16
8010b004:	50                   	push   %eax
8010b005:	e8 44 9e ff ff       	call   80104e4e <initlock>
8010b00a:	83 c4 10             	add    $0x10,%esp
    timerListReady = 1;
8010b00d:	c7 05 7c e6 10 80 01 	movl   $0x1,0x8010e67c
8010b014:	00 00 00 
}
8010b017:	90                   	nop
8010b018:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010b01b:	c9                   	leave  
8010b01c:	c3                   	ret    

8010b01d <APTimerListAddToHead>:

void APTimerListAddToHead(ATimerList * list, int wndId, int id, int interval)
{
8010b01d:	55                   	push   %ebp
8010b01e:	89 e5                	mov    %esp,%ebp
8010b020:	53                   	push   %ebx
8010b021:	83 ec 14             	sub    $0x14,%esp
    acquire(&list->lock);
8010b024:	8b 45 08             	mov    0x8(%ebp),%eax
8010b027:	05 d0 00 00 00       	add    $0xd0,%eax
8010b02c:	83 ec 0c             	sub    $0xc,%esp
8010b02f:	50                   	push   %eax
8010b030:	e8 3b 9e ff ff       	call   80104e70 <acquire>
8010b035:	83 c4 10             	add    $0x10,%esp
    int p = list->space;
8010b038:	8b 45 08             	mov    0x8(%ebp),%eax
8010b03b:	8b 80 cc 00 00 00    	mov    0xcc(%eax),%eax
8010b041:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == -1)
8010b044:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010b048:	75 15                	jne    8010b05f <APTimerListAddToHead+0x42>
    {
        cprintf("Error! Too much Timer!\n");
8010b04a:	83 ec 0c             	sub    $0xc,%esp
8010b04d:	68 20 bc 10 80       	push   $0x8010bc20
8010b052:	e8 6f 53 ff ff       	call   801003c6 <cprintf>
8010b057:	83 c4 10             	add    $0x10,%esp
        return;
8010b05a:	e9 c7 00 00 00       	jmp    8010b126 <APTimerListAddToHead+0x109>
    }
    list->space = list->data[p].next;
8010b05f:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b062:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b065:	89 d0                	mov    %edx,%eax
8010b067:	c1 e0 02             	shl    $0x2,%eax
8010b06a:	01 d0                	add    %edx,%eax
8010b06c:	c1 e0 02             	shl    $0x2,%eax
8010b06f:	01 c8                	add    %ecx,%eax
8010b071:	83 c0 10             	add    $0x10,%eax
8010b074:	8b 10                	mov    (%eax),%edx
8010b076:	8b 45 08             	mov    0x8(%ebp),%eax
8010b079:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
    list->data[p].next = list->head;
8010b07f:	8b 45 08             	mov    0x8(%ebp),%eax
8010b082:	8b 88 c8 00 00 00    	mov    0xc8(%eax),%ecx
8010b088:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b08b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b08e:	89 d0                	mov    %edx,%eax
8010b090:	c1 e0 02             	shl    $0x2,%eax
8010b093:	01 d0                	add    %edx,%eax
8010b095:	c1 e0 02             	shl    $0x2,%eax
8010b098:	01 d8                	add    %ebx,%eax
8010b09a:	83 c0 10             	add    $0x10,%eax
8010b09d:	89 08                	mov    %ecx,(%eax)
    list->head = p;
8010b09f:	8b 45 08             	mov    0x8(%ebp),%eax
8010b0a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b0a5:	89 90 c8 00 00 00    	mov    %edx,0xc8(%eax)
    list->data[p].wndId = wndId;
8010b0ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b0ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b0b1:	89 d0                	mov    %edx,%eax
8010b0b3:	c1 e0 02             	shl    $0x2,%eax
8010b0b6:	01 d0                	add    %edx,%eax
8010b0b8:	c1 e0 02             	shl    $0x2,%eax
8010b0bb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
8010b0be:	8b 45 0c             	mov    0xc(%ebp),%eax
8010b0c1:	89 02                	mov    %eax,(%edx)
    list->data[p].id = id;
8010b0c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b0c6:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b0c9:	89 d0                	mov    %edx,%eax
8010b0cb:	c1 e0 02             	shl    $0x2,%eax
8010b0ce:	01 d0                	add    %edx,%eax
8010b0d0:	c1 e0 02             	shl    $0x2,%eax
8010b0d3:	01 c8                	add    %ecx,%eax
8010b0d5:	8d 50 04             	lea    0x4(%eax),%edx
8010b0d8:	8b 45 10             	mov    0x10(%ebp),%eax
8010b0db:	89 02                	mov    %eax,(%edx)
    list->data[p].interval = interval;
8010b0dd:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b0e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b0e3:	89 d0                	mov    %edx,%eax
8010b0e5:	c1 e0 02             	shl    $0x2,%eax
8010b0e8:	01 d0                	add    %edx,%eax
8010b0ea:	c1 e0 02             	shl    $0x2,%eax
8010b0ed:	01 c8                	add    %ecx,%eax
8010b0ef:	8d 50 08             	lea    0x8(%eax),%edx
8010b0f2:	8b 45 14             	mov    0x14(%ebp),%eax
8010b0f5:	89 02                	mov    %eax,(%edx)
    list->data[p].count = 0;
8010b0f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b0fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b0fd:	89 d0                	mov    %edx,%eax
8010b0ff:	c1 e0 02             	shl    $0x2,%eax
8010b102:	01 d0                	add    %edx,%eax
8010b104:	c1 e0 02             	shl    $0x2,%eax
8010b107:	01 c8                	add    %ecx,%eax
8010b109:	83 c0 0c             	add    $0xc,%eax
8010b10c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    release(&list->lock);
8010b112:	8b 45 08             	mov    0x8(%ebp),%eax
8010b115:	05 d0 00 00 00       	add    $0xd0,%eax
8010b11a:	83 ec 0c             	sub    $0xc,%esp
8010b11d:	50                   	push   %eax
8010b11e:	e8 b4 9d ff ff       	call   80104ed7 <release>
8010b123:	83 c4 10             	add    $0x10,%esp
    
}
8010b126:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010b129:	c9                   	leave  
8010b12a:	c3                   	ret    

8010b12b <APTimerListRemoveWnd>:

void APTimerListRemoveWnd(ATimerList * list, int wndId)
{
8010b12b:	55                   	push   %ebp
8010b12c:	89 e5                	mov    %esp,%ebp
8010b12e:	53                   	push   %ebx
8010b12f:	83 ec 14             	sub    $0x14,%esp
    acquire(&list->lock);
8010b132:	8b 45 08             	mov    0x8(%ebp),%eax
8010b135:	05 d0 00 00 00       	add    $0xd0,%eax
8010b13a:	83 ec 0c             	sub    $0xc,%esp
8010b13d:	50                   	push   %eax
8010b13e:	e8 2d 9d ff ff       	call   80104e70 <acquire>
8010b143:	83 c4 10             	add    $0x10,%esp
    int p = list->head;
8010b146:	8b 45 08             	mov    0x8(%ebp),%eax
8010b149:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b14f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int q = p;
8010b152:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b155:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (p != -1)
8010b158:	e9 24 01 00 00       	jmp    8010b281 <APTimerListRemoveWnd+0x156>
    {
        if (list->data[p].wndId == wndId)
8010b15d:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b160:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b163:	89 d0                	mov    %edx,%eax
8010b165:	c1 e0 02             	shl    $0x2,%eax
8010b168:	01 d0                	add    %edx,%eax
8010b16a:	c1 e0 02             	shl    $0x2,%eax
8010b16d:	01 c8                	add    %ecx,%eax
8010b16f:	8b 00                	mov    (%eax),%eax
8010b171:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010b174:	0f 85 e7 00 00 00    	jne    8010b261 <APTimerListRemoveWnd+0x136>
        {
            if (p == list->head)
8010b17a:	8b 45 08             	mov    0x8(%ebp),%eax
8010b17d:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b183:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010b186:	75 63                	jne    8010b1eb <APTimerListRemoveWnd+0xc0>
            {
                list->head = list->data[p].next;
8010b188:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b18b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b18e:	89 d0                	mov    %edx,%eax
8010b190:	c1 e0 02             	shl    $0x2,%eax
8010b193:	01 d0                	add    %edx,%eax
8010b195:	c1 e0 02             	shl    $0x2,%eax
8010b198:	01 c8                	add    %ecx,%eax
8010b19a:	83 c0 10             	add    $0x10,%eax
8010b19d:	8b 10                	mov    (%eax),%edx
8010b19f:	8b 45 08             	mov    0x8(%ebp),%eax
8010b1a2:	89 90 c8 00 00 00    	mov    %edx,0xc8(%eax)
                list->data[p].next = list->space;
8010b1a8:	8b 45 08             	mov    0x8(%ebp),%eax
8010b1ab:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b1b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b1b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b1b7:	89 d0                	mov    %edx,%eax
8010b1b9:	c1 e0 02             	shl    $0x2,%eax
8010b1bc:	01 d0                	add    %edx,%eax
8010b1be:	c1 e0 02             	shl    $0x2,%eax
8010b1c1:	01 d8                	add    %ebx,%eax
8010b1c3:	83 c0 10             	add    $0x10,%eax
8010b1c6:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b1c8:	8b 45 08             	mov    0x8(%ebp),%eax
8010b1cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b1ce:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->head;
8010b1d4:	8b 45 08             	mov    0x8(%ebp),%eax
8010b1d7:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b1dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
                q = p;
8010b1e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b1e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010b1e6:	e9 96 00 00 00       	jmp    8010b281 <APTimerListRemoveWnd+0x156>
            }
            else
            {
                list->data[q].next = list->data[p].next;
8010b1eb:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b1ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b1f1:	89 d0                	mov    %edx,%eax
8010b1f3:	c1 e0 02             	shl    $0x2,%eax
8010b1f6:	01 d0                	add    %edx,%eax
8010b1f8:	c1 e0 02             	shl    $0x2,%eax
8010b1fb:	01 c8                	add    %ecx,%eax
8010b1fd:	83 c0 10             	add    $0x10,%eax
8010b200:	8b 08                	mov    (%eax),%ecx
8010b202:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b205:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b208:	89 d0                	mov    %edx,%eax
8010b20a:	c1 e0 02             	shl    $0x2,%eax
8010b20d:	01 d0                	add    %edx,%eax
8010b20f:	c1 e0 02             	shl    $0x2,%eax
8010b212:	01 d8                	add    %ebx,%eax
8010b214:	83 c0 10             	add    $0x10,%eax
8010b217:	89 08                	mov    %ecx,(%eax)
                list->data[p].next = list->space;
8010b219:	8b 45 08             	mov    0x8(%ebp),%eax
8010b21c:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b222:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b225:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b228:	89 d0                	mov    %edx,%eax
8010b22a:	c1 e0 02             	shl    $0x2,%eax
8010b22d:	01 d0                	add    %edx,%eax
8010b22f:	c1 e0 02             	shl    $0x2,%eax
8010b232:	01 d8                	add    %ebx,%eax
8010b234:	83 c0 10             	add    $0x10,%eax
8010b237:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b239:	8b 45 08             	mov    0x8(%ebp),%eax
8010b23c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b23f:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->data[q].next;
8010b245:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b248:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b24b:	89 d0                	mov    %edx,%eax
8010b24d:	c1 e0 02             	shl    $0x2,%eax
8010b250:	01 d0                	add    %edx,%eax
8010b252:	c1 e0 02             	shl    $0x2,%eax
8010b255:	01 c8                	add    %ecx,%eax
8010b257:	83 c0 10             	add    $0x10,%eax
8010b25a:	8b 00                	mov    (%eax),%eax
8010b25c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010b25f:	eb 20                	jmp    8010b281 <APTimerListRemoveWnd+0x156>
            }
        }
        else
        {
            q = p;
8010b261:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b264:	89 45 f0             	mov    %eax,-0x10(%ebp)
            p = list->data[p].next;
8010b267:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b26a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b26d:	89 d0                	mov    %edx,%eax
8010b26f:	c1 e0 02             	shl    $0x2,%eax
8010b272:	01 d0                	add    %edx,%eax
8010b274:	c1 e0 02             	shl    $0x2,%eax
8010b277:	01 c8                	add    %ecx,%eax
8010b279:	83 c0 10             	add    $0x10,%eax
8010b27c:	8b 00                	mov    (%eax),%eax
8010b27e:	89 45 f4             	mov    %eax,-0xc(%ebp)
void APTimerListRemoveWnd(ATimerList * list, int wndId)
{
    acquire(&list->lock);
    int p = list->head;
    int q = p;
    while (p != -1)
8010b281:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010b285:	0f 85 d2 fe ff ff    	jne    8010b15d <APTimerListRemoveWnd+0x32>
        {
            q = p;
            p = list->data[p].next;
        }
    }
    release(&list->lock);
8010b28b:	8b 45 08             	mov    0x8(%ebp),%eax
8010b28e:	05 d0 00 00 00       	add    $0xd0,%eax
8010b293:	83 ec 0c             	sub    $0xc,%esp
8010b296:	50                   	push   %eax
8010b297:	e8 3b 9c ff ff       	call   80104ed7 <release>
8010b29c:	83 c4 10             	add    $0x10,%esp
}
8010b29f:	90                   	nop
8010b2a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010b2a3:	c9                   	leave  
8010b2a4:	c3                   	ret    

8010b2a5 <APTimerListRemoveID>:

void APTimerListRemoveID(ATimerList * list, int wndId, int id)
{
8010b2a5:	55                   	push   %ebp
8010b2a6:	89 e5                	mov    %esp,%ebp
8010b2a8:	53                   	push   %ebx
8010b2a9:	83 ec 14             	sub    $0x14,%esp
    acquire(&list->lock);
8010b2ac:	8b 45 08             	mov    0x8(%ebp),%eax
8010b2af:	05 d0 00 00 00       	add    $0xd0,%eax
8010b2b4:	83 ec 0c             	sub    $0xc,%esp
8010b2b7:	50                   	push   %eax
8010b2b8:	e8 b3 9b ff ff       	call   80104e70 <acquire>
8010b2bd:	83 c4 10             	add    $0x10,%esp
    int p = list->head;
8010b2c0:	8b 45 08             	mov    0x8(%ebp),%eax
8010b2c3:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b2c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int q = p;
8010b2cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b2cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (p != -1)
8010b2d2:	e9 44 01 00 00       	jmp    8010b41b <APTimerListRemoveID+0x176>
    {
        if (list->data[p].wndId == wndId && list->data[p].id == id)
8010b2d7:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b2da:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b2dd:	89 d0                	mov    %edx,%eax
8010b2df:	c1 e0 02             	shl    $0x2,%eax
8010b2e2:	01 d0                	add    %edx,%eax
8010b2e4:	c1 e0 02             	shl    $0x2,%eax
8010b2e7:	01 c8                	add    %ecx,%eax
8010b2e9:	8b 00                	mov    (%eax),%eax
8010b2eb:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010b2ee:	0f 85 07 01 00 00    	jne    8010b3fb <APTimerListRemoveID+0x156>
8010b2f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b2f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b2fa:	89 d0                	mov    %edx,%eax
8010b2fc:	c1 e0 02             	shl    $0x2,%eax
8010b2ff:	01 d0                	add    %edx,%eax
8010b301:	c1 e0 02             	shl    $0x2,%eax
8010b304:	01 c8                	add    %ecx,%eax
8010b306:	83 c0 04             	add    $0x4,%eax
8010b309:	8b 00                	mov    (%eax),%eax
8010b30b:	3b 45 10             	cmp    0x10(%ebp),%eax
8010b30e:	0f 85 e7 00 00 00    	jne    8010b3fb <APTimerListRemoveID+0x156>
        {
            if (p == list->head)
8010b314:	8b 45 08             	mov    0x8(%ebp),%eax
8010b317:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b31d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010b320:	75 63                	jne    8010b385 <APTimerListRemoveID+0xe0>
            {
                list->head = list->data[p].next;
8010b322:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b325:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b328:	89 d0                	mov    %edx,%eax
8010b32a:	c1 e0 02             	shl    $0x2,%eax
8010b32d:	01 d0                	add    %edx,%eax
8010b32f:	c1 e0 02             	shl    $0x2,%eax
8010b332:	01 c8                	add    %ecx,%eax
8010b334:	83 c0 10             	add    $0x10,%eax
8010b337:	8b 10                	mov    (%eax),%edx
8010b339:	8b 45 08             	mov    0x8(%ebp),%eax
8010b33c:	89 90 c8 00 00 00    	mov    %edx,0xc8(%eax)
                list->data[p].next = list->space;
8010b342:	8b 45 08             	mov    0x8(%ebp),%eax
8010b345:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b34b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b34e:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b351:	89 d0                	mov    %edx,%eax
8010b353:	c1 e0 02             	shl    $0x2,%eax
8010b356:	01 d0                	add    %edx,%eax
8010b358:	c1 e0 02             	shl    $0x2,%eax
8010b35b:	01 d8                	add    %ebx,%eax
8010b35d:	83 c0 10             	add    $0x10,%eax
8010b360:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b362:	8b 45 08             	mov    0x8(%ebp),%eax
8010b365:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b368:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->head;
8010b36e:	8b 45 08             	mov    0x8(%ebp),%eax
8010b371:	8b 80 c8 00 00 00    	mov    0xc8(%eax),%eax
8010b377:	89 45 f4             	mov    %eax,-0xc(%ebp)
                q = p;
8010b37a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b37d:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010b380:	e9 96 00 00 00       	jmp    8010b41b <APTimerListRemoveID+0x176>
            }
            else
            {
                list->data[q].next = list->data[p].next;
8010b385:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b388:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b38b:	89 d0                	mov    %edx,%eax
8010b38d:	c1 e0 02             	shl    $0x2,%eax
8010b390:	01 d0                	add    %edx,%eax
8010b392:	c1 e0 02             	shl    $0x2,%eax
8010b395:	01 c8                	add    %ecx,%eax
8010b397:	83 c0 10             	add    $0x10,%eax
8010b39a:	8b 08                	mov    (%eax),%ecx
8010b39c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b39f:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b3a2:	89 d0                	mov    %edx,%eax
8010b3a4:	c1 e0 02             	shl    $0x2,%eax
8010b3a7:	01 d0                	add    %edx,%eax
8010b3a9:	c1 e0 02             	shl    $0x2,%eax
8010b3ac:	01 d8                	add    %ebx,%eax
8010b3ae:	83 c0 10             	add    $0x10,%eax
8010b3b1:	89 08                	mov    %ecx,(%eax)
                list->data[p].next = list->space;
8010b3b3:	8b 45 08             	mov    0x8(%ebp),%eax
8010b3b6:	8b 88 cc 00 00 00    	mov    0xcc(%eax),%ecx
8010b3bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010b3bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b3c2:	89 d0                	mov    %edx,%eax
8010b3c4:	c1 e0 02             	shl    $0x2,%eax
8010b3c7:	01 d0                	add    %edx,%eax
8010b3c9:	c1 e0 02             	shl    $0x2,%eax
8010b3cc:	01 d8                	add    %ebx,%eax
8010b3ce:	83 c0 10             	add    $0x10,%eax
8010b3d1:	89 08                	mov    %ecx,(%eax)
                list->space = p;
8010b3d3:	8b 45 08             	mov    0x8(%ebp),%eax
8010b3d6:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b3d9:	89 90 cc 00 00 00    	mov    %edx,0xcc(%eax)
                p = list->data[q].next;
8010b3df:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b3e2:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010b3e5:	89 d0                	mov    %edx,%eax
8010b3e7:	c1 e0 02             	shl    $0x2,%eax
8010b3ea:	01 d0                	add    %edx,%eax
8010b3ec:	c1 e0 02             	shl    $0x2,%eax
8010b3ef:	01 c8                	add    %ecx,%eax
8010b3f1:	83 c0 10             	add    $0x10,%eax
8010b3f4:	8b 00                	mov    (%eax),%eax
8010b3f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int q = p;
    while (p != -1)
    {
        if (list->data[p].wndId == wndId && list->data[p].id == id)
        {
            if (p == list->head)
8010b3f9:	eb 20                	jmp    8010b41b <APTimerListRemoveID+0x176>
                p = list->data[q].next;
            }
        }
        else
        {
            q = p;
8010b3fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010b3fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
            p = list->data[p].next;
8010b401:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010b404:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010b407:	89 d0                	mov    %edx,%eax
8010b409:	c1 e0 02             	shl    $0x2,%eax
8010b40c:	01 d0                	add    %edx,%eax
8010b40e:	c1 e0 02             	shl    $0x2,%eax
8010b411:	01 c8                	add    %ecx,%eax
8010b413:	83 c0 10             	add    $0x10,%eax
8010b416:	8b 00                	mov    (%eax),%eax
8010b418:	89 45 f4             	mov    %eax,-0xc(%ebp)
void APTimerListRemoveID(ATimerList * list, int wndId, int id)
{
    acquire(&list->lock);
    int p = list->head;
    int q = p;
    while (p != -1)
8010b41b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
8010b41f:	0f 85 b2 fe ff ff    	jne    8010b2d7 <APTimerListRemoveID+0x32>
        {
            q = p;
            p = list->data[p].next;
        }
    }
    release(&list->lock);
8010b425:	8b 45 08             	mov    0x8(%ebp),%eax
8010b428:	05 d0 00 00 00       	add    $0xd0,%eax
8010b42d:	83 ec 0c             	sub    $0xc,%esp
8010b430:	50                   	push   %eax
8010b431:	e8 a1 9a ff ff       	call   80104ed7 <release>
8010b436:	83 c4 10             	add    $0x10,%esp
}
8010b439:	90                   	nop
8010b43a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010b43d:	c9                   	leave  
8010b43e:	c3                   	ret    

8010b43f <setuptimer>:

void setuptimer(AHwnd hwnd,int id, int interval)
{
8010b43f:	55                   	push   %ebp
8010b440:	89 e5                	mov    %esp,%ebp
8010b442:	83 ec 08             	sub    $0x8,%esp
    APTimerListAddToHead(&timerList,hwnd->id,id,interval/10);
8010b445:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010b448:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010b44d:	89 c8                	mov    %ecx,%eax
8010b44f:	f7 ea                	imul   %edx
8010b451:	c1 fa 02             	sar    $0x2,%edx
8010b454:	89 c8                	mov    %ecx,%eax
8010b456:	c1 f8 1f             	sar    $0x1f,%eax
8010b459:	29 c2                	sub    %eax,%edx
8010b45b:	8b 45 08             	mov    0x8(%ebp),%eax
8010b45e:	8b 00                	mov    (%eax),%eax
8010b460:	52                   	push   %edx
8010b461:	ff 75 0c             	pushl  0xc(%ebp)
8010b464:	50                   	push   %eax
8010b465:	68 80 bb 11 80       	push   $0x8011bb80
8010b46a:	e8 ae fb ff ff       	call   8010b01d <APTimerListAddToHead>
8010b46f:	83 c4 10             	add    $0x10,%esp
}
8010b472:	90                   	nop
8010b473:	c9                   	leave  
8010b474:	c3                   	ret    

8010b475 <deletetimer>:
void deletetimer(AHwnd hwnd, int id)
{
8010b475:	55                   	push   %ebp
8010b476:	89 e5                	mov    %esp,%ebp
8010b478:	83 ec 08             	sub    $0x8,%esp
    APTimerListRemoveID(&timerList,hwnd->id,id);
8010b47b:	8b 45 08             	mov    0x8(%ebp),%eax
8010b47e:	8b 00                	mov    (%eax),%eax
8010b480:	83 ec 04             	sub    $0x4,%esp
8010b483:	ff 75 0c             	pushl  0xc(%ebp)
8010b486:	50                   	push   %eax
8010b487:	68 80 bb 11 80       	push   $0x8011bb80
8010b48c:	e8 14 fe ff ff       	call   8010b2a5 <APTimerListRemoveID>
8010b491:	83 c4 10             	add    $0x10,%esp
}
8010b494:	90                   	nop
8010b495:	c9                   	leave  
8010b496:	c3                   	ret    
