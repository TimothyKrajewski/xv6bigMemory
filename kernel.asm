
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

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
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
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
80100028:	bc 70 c6 10 80       	mov    $0x8010c670,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 38 34 10 80       	mov    $0x80103438,%eax
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
8010003d:	68 64 82 10 80       	push   $0x80108264
80100042:	68 80 c6 10 80       	push   $0x8010c680
80100047:	e8 fd 4a 00 00       	call   80104b49 <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 b0 db 10 80 a4 	movl   $0x8010dba4,0x8010dbb0
80100056:	db 10 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 b4 db 10 80 a4 	movl   $0x8010dba4,0x8010dbb4
80100060:	db 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100063:	c7 45 f4 b4 c6 10 80 	movl   $0x8010c6b4,-0xc(%ebp)
8010006a:	eb 3a                	jmp    801000a6 <binit+0x72>
    b->next = bcache.head.next;
8010006c:	8b 15 b4 db 10 80    	mov    0x8010dbb4,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 0c a4 db 10 80 	movl   $0x8010dba4,0xc(%eax)
    b->dev = -1;
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008c:	a1 b4 db 10 80       	mov    0x8010dbb4,%eax
80100091:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100094:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100097:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010009a:	a3 b4 db 10 80       	mov    %eax,0x8010dbb4

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009f:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a6:	81 7d f4 a4 db 10 80 	cmpl   $0x8010dba4,-0xc(%ebp)
801000ad:	72 bd                	jb     8010006c <binit+0x38>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000af:	c9                   	leave  
801000b0:	c3                   	ret    

801000b1 <bget>:
// Look through buffer cache for sector on device dev.
// If not found, allocate fresh block.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint sector)
{
801000b1:	55                   	push   %ebp
801000b2:	89 e5                	mov    %esp,%ebp
801000b4:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000b7:	83 ec 0c             	sub    $0xc,%esp
801000ba:	68 80 c6 10 80       	push   $0x8010c680
801000bf:	e8 a6 4a 00 00       	call   80104b6a <acquire>
801000c4:	83 c4 10             	add    $0x10,%esp

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c7:	a1 b4 db 10 80       	mov    0x8010dbb4,%eax
801000cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000cf:	eb 67                	jmp    80100138 <bget+0x87>
    if(b->dev == dev && b->sector == sector){
801000d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000d4:	8b 40 04             	mov    0x4(%eax),%eax
801000d7:	3b 45 08             	cmp    0x8(%ebp),%eax
801000da:	75 53                	jne    8010012f <bget+0x7e>
801000dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000df:	8b 40 08             	mov    0x8(%eax),%eax
801000e2:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e5:	75 48                	jne    8010012f <bget+0x7e>
      if(!(b->flags & B_BUSY)){
801000e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ea:	8b 00                	mov    (%eax),%eax
801000ec:	83 e0 01             	and    $0x1,%eax
801000ef:	85 c0                	test   %eax,%eax
801000f1:	75 27                	jne    8010011a <bget+0x69>
        b->flags |= B_BUSY;
801000f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f6:	8b 00                	mov    (%eax),%eax
801000f8:	83 c8 01             	or     $0x1,%eax
801000fb:	89 c2                	mov    %eax,%edx
801000fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100100:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
80100102:	83 ec 0c             	sub    $0xc,%esp
80100105:	68 80 c6 10 80       	push   $0x8010c680
8010010a:	e8 c1 4a 00 00       	call   80104bd0 <release>
8010010f:	83 c4 10             	add    $0x10,%esp
        return b;
80100112:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100115:	e9 98 00 00 00       	jmp    801001b2 <bget+0x101>
      }
      sleep(b, &bcache.lock);
8010011a:	83 ec 08             	sub    $0x8,%esp
8010011d:	68 80 c6 10 80       	push   $0x8010c680
80100122:	ff 75 f4             	pushl  -0xc(%ebp)
80100125:	e8 3e 47 00 00       	call   80104868 <sleep>
8010012a:	83 c4 10             	add    $0x10,%esp
      goto loop;
8010012d:	eb 98                	jmp    801000c7 <bget+0x16>

  acquire(&bcache.lock);

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
8010012f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100132:	8b 40 10             	mov    0x10(%eax),%eax
80100135:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100138:	81 7d f4 a4 db 10 80 	cmpl   $0x8010dba4,-0xc(%ebp)
8010013f:	75 90                	jne    801000d1 <bget+0x20>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100141:	a1 b0 db 10 80       	mov    0x8010dbb0,%eax
80100146:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100149:	eb 51                	jmp    8010019c <bget+0xeb>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
8010014b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010014e:	8b 00                	mov    (%eax),%eax
80100150:	83 e0 01             	and    $0x1,%eax
80100153:	85 c0                	test   %eax,%eax
80100155:	75 3c                	jne    80100193 <bget+0xe2>
80100157:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015a:	8b 00                	mov    (%eax),%eax
8010015c:	83 e0 04             	and    $0x4,%eax
8010015f:	85 c0                	test   %eax,%eax
80100161:	75 30                	jne    80100193 <bget+0xe2>
      b->dev = dev;
80100163:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100166:	8b 55 08             	mov    0x8(%ebp),%edx
80100169:	89 50 04             	mov    %edx,0x4(%eax)
      b->sector = sector;
8010016c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010016f:	8b 55 0c             	mov    0xc(%ebp),%edx
80100172:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
80100175:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100178:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
8010017e:	83 ec 0c             	sub    $0xc,%esp
80100181:	68 80 c6 10 80       	push   $0x8010c680
80100186:	e8 45 4a 00 00       	call   80104bd0 <release>
8010018b:	83 c4 10             	add    $0x10,%esp
      return b;
8010018e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100191:	eb 1f                	jmp    801001b2 <bget+0x101>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100193:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100196:	8b 40 0c             	mov    0xc(%eax),%eax
80100199:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010019c:	81 7d f4 a4 db 10 80 	cmpl   $0x8010dba4,-0xc(%ebp)
801001a3:	75 a6                	jne    8010014b <bget+0x9a>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
801001a5:	83 ec 0c             	sub    $0xc,%esp
801001a8:	68 6b 82 10 80       	push   $0x8010826b
801001ad:	e8 aa 03 00 00       	call   8010055c <panic>
}
801001b2:	c9                   	leave  
801001b3:	c3                   	ret    

801001b4 <bread>:

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
801001b4:	55                   	push   %ebp
801001b5:	89 e5                	mov    %esp,%ebp
801001b7:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, sector);
801001ba:	83 ec 08             	sub    $0x8,%esp
801001bd:	ff 75 0c             	pushl  0xc(%ebp)
801001c0:	ff 75 08             	pushl  0x8(%ebp)
801001c3:	e8 e9 fe ff ff       	call   801000b1 <bget>
801001c8:	83 c4 10             	add    $0x10,%esp
801001cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID))
801001ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d1:	8b 00                	mov    (%eax),%eax
801001d3:	83 e0 02             	and    $0x2,%eax
801001d6:	85 c0                	test   %eax,%eax
801001d8:	75 0e                	jne    801001e8 <bread+0x34>
    iderw(b);
801001da:	83 ec 0c             	sub    $0xc,%esp
801001dd:	ff 75 f4             	pushl  -0xc(%ebp)
801001e0:	e8 48 26 00 00       	call   8010282d <iderw>
801001e5:	83 c4 10             	add    $0x10,%esp
  return b;
801001e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001eb:	c9                   	leave  
801001ec:	c3                   	ret    

801001ed <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001ed:	55                   	push   %ebp
801001ee:	89 e5                	mov    %esp,%ebp
801001f0:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
801001f3:	8b 45 08             	mov    0x8(%ebp),%eax
801001f6:	8b 00                	mov    (%eax),%eax
801001f8:	83 e0 01             	and    $0x1,%eax
801001fb:	85 c0                	test   %eax,%eax
801001fd:	75 0d                	jne    8010020c <bwrite+0x1f>
    panic("bwrite");
801001ff:	83 ec 0c             	sub    $0xc,%esp
80100202:	68 7c 82 10 80       	push   $0x8010827c
80100207:	e8 50 03 00 00       	call   8010055c <panic>
  b->flags |= B_DIRTY;
8010020c:	8b 45 08             	mov    0x8(%ebp),%eax
8010020f:	8b 00                	mov    (%eax),%eax
80100211:	83 c8 04             	or     $0x4,%eax
80100214:	89 c2                	mov    %eax,%edx
80100216:	8b 45 08             	mov    0x8(%ebp),%eax
80100219:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010021b:	83 ec 0c             	sub    $0xc,%esp
8010021e:	ff 75 08             	pushl  0x8(%ebp)
80100221:	e8 07 26 00 00       	call   8010282d <iderw>
80100226:	83 c4 10             	add    $0x10,%esp
}
80100229:	c9                   	leave  
8010022a:	c3                   	ret    

8010022b <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
8010022b:	55                   	push   %ebp
8010022c:	89 e5                	mov    %esp,%ebp
8010022e:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
80100231:	8b 45 08             	mov    0x8(%ebp),%eax
80100234:	8b 00                	mov    (%eax),%eax
80100236:	83 e0 01             	and    $0x1,%eax
80100239:	85 c0                	test   %eax,%eax
8010023b:	75 0d                	jne    8010024a <brelse+0x1f>
    panic("brelse");
8010023d:	83 ec 0c             	sub    $0xc,%esp
80100240:	68 83 82 10 80       	push   $0x80108283
80100245:	e8 12 03 00 00       	call   8010055c <panic>

  acquire(&bcache.lock);
8010024a:	83 ec 0c             	sub    $0xc,%esp
8010024d:	68 80 c6 10 80       	push   $0x8010c680
80100252:	e8 13 49 00 00       	call   80104b6a <acquire>
80100257:	83 c4 10             	add    $0x10,%esp

  b->next->prev = b->prev;
8010025a:	8b 45 08             	mov    0x8(%ebp),%eax
8010025d:	8b 40 10             	mov    0x10(%eax),%eax
80100260:	8b 55 08             	mov    0x8(%ebp),%edx
80100263:	8b 52 0c             	mov    0xc(%edx),%edx
80100266:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
80100269:	8b 45 08             	mov    0x8(%ebp),%eax
8010026c:	8b 40 0c             	mov    0xc(%eax),%eax
8010026f:	8b 55 08             	mov    0x8(%ebp),%edx
80100272:	8b 52 10             	mov    0x10(%edx),%edx
80100275:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
80100278:	8b 15 b4 db 10 80    	mov    0x8010dbb4,%edx
8010027e:	8b 45 08             	mov    0x8(%ebp),%eax
80100281:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
80100284:	8b 45 08             	mov    0x8(%ebp),%eax
80100287:	c7 40 0c a4 db 10 80 	movl   $0x8010dba4,0xc(%eax)
  bcache.head.next->prev = b;
8010028e:	a1 b4 db 10 80       	mov    0x8010dbb4,%eax
80100293:	8b 55 08             	mov    0x8(%ebp),%edx
80100296:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
80100299:	8b 45 08             	mov    0x8(%ebp),%eax
8010029c:	a3 b4 db 10 80       	mov    %eax,0x8010dbb4

  b->flags &= ~B_BUSY;
801002a1:	8b 45 08             	mov    0x8(%ebp),%eax
801002a4:	8b 00                	mov    (%eax),%eax
801002a6:	83 e0 fe             	and    $0xfffffffe,%eax
801002a9:	89 c2                	mov    %eax,%edx
801002ab:	8b 45 08             	mov    0x8(%ebp),%eax
801002ae:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801002b0:	83 ec 0c             	sub    $0xc,%esp
801002b3:	ff 75 08             	pushl  0x8(%ebp)
801002b6:	e8 96 46 00 00       	call   80104951 <wakeup>
801002bb:	83 c4 10             	add    $0x10,%esp

  release(&bcache.lock);
801002be:	83 ec 0c             	sub    $0xc,%esp
801002c1:	68 80 c6 10 80       	push   $0x8010c680
801002c6:	e8 05 49 00 00       	call   80104bd0 <release>
801002cb:	83 c4 10             	add    $0x10,%esp
}
801002ce:	c9                   	leave  
801002cf:	c3                   	ret    

801002d0 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002d0:	55                   	push   %ebp
801002d1:	89 e5                	mov    %esp,%ebp
801002d3:	83 ec 14             	sub    $0x14,%esp
801002d6:	8b 45 08             	mov    0x8(%ebp),%eax
801002d9:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002dd:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801002e1:	89 c2                	mov    %eax,%edx
801002e3:	ec                   	in     (%dx),%al
801002e4:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801002e7:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801002eb:	c9                   	leave  
801002ec:	c3                   	ret    

801002ed <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002ed:	55                   	push   %ebp
801002ee:	89 e5                	mov    %esp,%ebp
801002f0:	83 ec 08             	sub    $0x8,%esp
801002f3:	8b 55 08             	mov    0x8(%ebp),%edx
801002f6:	8b 45 0c             	mov    0xc(%ebp),%eax
801002f9:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801002fd:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100300:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80100304:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80100308:	ee                   	out    %al,(%dx)
}
80100309:	c9                   	leave  
8010030a:	c3                   	ret    

8010030b <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
8010030b:	55                   	push   %ebp
8010030c:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
8010030e:	fa                   	cli    
}
8010030f:	5d                   	pop    %ebp
80100310:	c3                   	ret    

80100311 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100311:	55                   	push   %ebp
80100312:	89 e5                	mov    %esp,%ebp
80100314:	53                   	push   %ebx
80100315:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100318:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010031c:	74 1c                	je     8010033a <printint+0x29>
8010031e:	8b 45 08             	mov    0x8(%ebp),%eax
80100321:	c1 e8 1f             	shr    $0x1f,%eax
80100324:	0f b6 c0             	movzbl %al,%eax
80100327:	89 45 10             	mov    %eax,0x10(%ebp)
8010032a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010032e:	74 0a                	je     8010033a <printint+0x29>
    x = -xx;
80100330:	8b 45 08             	mov    0x8(%ebp),%eax
80100333:	f7 d8                	neg    %eax
80100335:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100338:	eb 06                	jmp    80100340 <printint+0x2f>
  else
    x = xx;
8010033a:	8b 45 08             	mov    0x8(%ebp),%eax
8010033d:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100340:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100347:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010034a:	8d 41 01             	lea    0x1(%ecx),%eax
8010034d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100350:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100353:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100356:	ba 00 00 00 00       	mov    $0x0,%edx
8010035b:	f7 f3                	div    %ebx
8010035d:	89 d0                	mov    %edx,%eax
8010035f:	0f b6 80 04 90 10 80 	movzbl -0x7fef6ffc(%eax),%eax
80100366:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
  }while((x /= base) != 0);
8010036a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010036d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100370:	ba 00 00 00 00       	mov    $0x0,%edx
80100375:	f7 f3                	div    %ebx
80100377:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010037a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010037e:	75 c7                	jne    80100347 <printint+0x36>

  if(sign)
80100380:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100384:	74 0e                	je     80100394 <printint+0x83>
    buf[i++] = '-';
80100386:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100389:	8d 50 01             	lea    0x1(%eax),%edx
8010038c:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010038f:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
80100394:	eb 1a                	jmp    801003b0 <printint+0x9f>
    consputc(buf[i]);
80100396:	8d 55 e0             	lea    -0x20(%ebp),%edx
80100399:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010039c:	01 d0                	add    %edx,%eax
8010039e:	0f b6 00             	movzbl (%eax),%eax
801003a1:	0f be c0             	movsbl %al,%eax
801003a4:	83 ec 0c             	sub    $0xc,%esp
801003a7:	50                   	push   %eax
801003a8:	e8 be 03 00 00       	call   8010076b <consputc>
801003ad:	83 c4 10             	add    $0x10,%esp
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801003b0:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003b8:	79 dc                	jns    80100396 <printint+0x85>
    consputc(buf[i]);
}
801003ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801003bd:	c9                   	leave  
801003be:	c3                   	ret    

801003bf <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003bf:	55                   	push   %ebp
801003c0:	89 e5                	mov    %esp,%ebp
801003c2:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003c5:	a1 14 b6 10 80       	mov    0x8010b614,%eax
801003ca:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003cd:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003d1:	74 10                	je     801003e3 <cprintf+0x24>
    acquire(&cons.lock);
801003d3:	83 ec 0c             	sub    $0xc,%esp
801003d6:	68 e0 b5 10 80       	push   $0x8010b5e0
801003db:	e8 8a 47 00 00       	call   80104b6a <acquire>
801003e0:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
801003e3:	8b 45 08             	mov    0x8(%ebp),%eax
801003e6:	85 c0                	test   %eax,%eax
801003e8:	75 0d                	jne    801003f7 <cprintf+0x38>
    panic("null fmt");
801003ea:	83 ec 0c             	sub    $0xc,%esp
801003ed:	68 8a 82 10 80       	push   $0x8010828a
801003f2:	e8 65 01 00 00       	call   8010055c <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003f7:	8d 45 0c             	lea    0xc(%ebp),%eax
801003fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801003fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100404:	e9 1b 01 00 00       	jmp    80100524 <cprintf+0x165>
    if(c != '%'){
80100409:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
8010040d:	74 13                	je     80100422 <cprintf+0x63>
      consputc(c);
8010040f:	83 ec 0c             	sub    $0xc,%esp
80100412:	ff 75 e4             	pushl  -0x1c(%ebp)
80100415:	e8 51 03 00 00       	call   8010076b <consputc>
8010041a:	83 c4 10             	add    $0x10,%esp
      continue;
8010041d:	e9 fe 00 00 00       	jmp    80100520 <cprintf+0x161>
    }
    c = fmt[++i] & 0xff;
80100422:	8b 55 08             	mov    0x8(%ebp),%edx
80100425:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100429:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010042c:	01 d0                	add    %edx,%eax
8010042e:	0f b6 00             	movzbl (%eax),%eax
80100431:	0f be c0             	movsbl %al,%eax
80100434:	25 ff 00 00 00       	and    $0xff,%eax
80100439:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
8010043c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100440:	75 05                	jne    80100447 <cprintf+0x88>
      break;
80100442:	e9 fd 00 00 00       	jmp    80100544 <cprintf+0x185>
    switch(c){
80100447:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010044a:	83 f8 70             	cmp    $0x70,%eax
8010044d:	74 47                	je     80100496 <cprintf+0xd7>
8010044f:	83 f8 70             	cmp    $0x70,%eax
80100452:	7f 13                	jg     80100467 <cprintf+0xa8>
80100454:	83 f8 25             	cmp    $0x25,%eax
80100457:	0f 84 98 00 00 00    	je     801004f5 <cprintf+0x136>
8010045d:	83 f8 64             	cmp    $0x64,%eax
80100460:	74 14                	je     80100476 <cprintf+0xb7>
80100462:	e9 9d 00 00 00       	jmp    80100504 <cprintf+0x145>
80100467:	83 f8 73             	cmp    $0x73,%eax
8010046a:	74 47                	je     801004b3 <cprintf+0xf4>
8010046c:	83 f8 78             	cmp    $0x78,%eax
8010046f:	74 25                	je     80100496 <cprintf+0xd7>
80100471:	e9 8e 00 00 00       	jmp    80100504 <cprintf+0x145>
    case 'd':
      printint(*argp++, 10, 1);
80100476:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100479:	8d 50 04             	lea    0x4(%eax),%edx
8010047c:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010047f:	8b 00                	mov    (%eax),%eax
80100481:	83 ec 04             	sub    $0x4,%esp
80100484:	6a 01                	push   $0x1
80100486:	6a 0a                	push   $0xa
80100488:	50                   	push   %eax
80100489:	e8 83 fe ff ff       	call   80100311 <printint>
8010048e:	83 c4 10             	add    $0x10,%esp
      break;
80100491:	e9 8a 00 00 00       	jmp    80100520 <cprintf+0x161>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100496:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100499:	8d 50 04             	lea    0x4(%eax),%edx
8010049c:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010049f:	8b 00                	mov    (%eax),%eax
801004a1:	83 ec 04             	sub    $0x4,%esp
801004a4:	6a 00                	push   $0x0
801004a6:	6a 10                	push   $0x10
801004a8:	50                   	push   %eax
801004a9:	e8 63 fe ff ff       	call   80100311 <printint>
801004ae:	83 c4 10             	add    $0x10,%esp
      break;
801004b1:	eb 6d                	jmp    80100520 <cprintf+0x161>
    case 's':
      if((s = (char*)*argp++) == 0)
801004b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004b6:	8d 50 04             	lea    0x4(%eax),%edx
801004b9:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004bc:	8b 00                	mov    (%eax),%eax
801004be:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004c1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004c5:	75 07                	jne    801004ce <cprintf+0x10f>
        s = "(null)";
801004c7:	c7 45 ec 93 82 10 80 	movl   $0x80108293,-0x14(%ebp)
      for(; *s; s++)
801004ce:	eb 19                	jmp    801004e9 <cprintf+0x12a>
        consputc(*s);
801004d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004d3:	0f b6 00             	movzbl (%eax),%eax
801004d6:	0f be c0             	movsbl %al,%eax
801004d9:	83 ec 0c             	sub    $0xc,%esp
801004dc:	50                   	push   %eax
801004dd:	e8 89 02 00 00       	call   8010076b <consputc>
801004e2:	83 c4 10             	add    $0x10,%esp
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004e5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801004e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004ec:	0f b6 00             	movzbl (%eax),%eax
801004ef:	84 c0                	test   %al,%al
801004f1:	75 dd                	jne    801004d0 <cprintf+0x111>
        consputc(*s);
      break;
801004f3:	eb 2b                	jmp    80100520 <cprintf+0x161>
    case '%':
      consputc('%');
801004f5:	83 ec 0c             	sub    $0xc,%esp
801004f8:	6a 25                	push   $0x25
801004fa:	e8 6c 02 00 00       	call   8010076b <consputc>
801004ff:	83 c4 10             	add    $0x10,%esp
      break;
80100502:	eb 1c                	jmp    80100520 <cprintf+0x161>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100504:	83 ec 0c             	sub    $0xc,%esp
80100507:	6a 25                	push   $0x25
80100509:	e8 5d 02 00 00       	call   8010076b <consputc>
8010050e:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100511:	83 ec 0c             	sub    $0xc,%esp
80100514:	ff 75 e4             	pushl  -0x1c(%ebp)
80100517:	e8 4f 02 00 00       	call   8010076b <consputc>
8010051c:	83 c4 10             	add    $0x10,%esp
      break;
8010051f:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100520:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100524:	8b 55 08             	mov    0x8(%ebp),%edx
80100527:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010052a:	01 d0                	add    %edx,%eax
8010052c:	0f b6 00             	movzbl (%eax),%eax
8010052f:	0f be c0             	movsbl %al,%eax
80100532:	25 ff 00 00 00       	and    $0xff,%eax
80100537:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010053a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010053e:	0f 85 c5 fe ff ff    	jne    80100409 <cprintf+0x4a>
      consputc(c);
      break;
    }
  }

  if(locking)
80100544:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100548:	74 10                	je     8010055a <cprintf+0x19b>
    release(&cons.lock);
8010054a:	83 ec 0c             	sub    $0xc,%esp
8010054d:	68 e0 b5 10 80       	push   $0x8010b5e0
80100552:	e8 79 46 00 00       	call   80104bd0 <release>
80100557:	83 c4 10             	add    $0x10,%esp
}
8010055a:	c9                   	leave  
8010055b:	c3                   	ret    

8010055c <panic>:

void
panic(char *s)
{
8010055c:	55                   	push   %ebp
8010055d:	89 e5                	mov    %esp,%ebp
8010055f:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];
  
  cli();
80100562:	e8 a4 fd ff ff       	call   8010030b <cli>
  cons.locking = 0;
80100567:	c7 05 14 b6 10 80 00 	movl   $0x0,0x8010b614
8010056e:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
80100571:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100577:	0f b6 00             	movzbl (%eax),%eax
8010057a:	0f b6 c0             	movzbl %al,%eax
8010057d:	83 ec 08             	sub    $0x8,%esp
80100580:	50                   	push   %eax
80100581:	68 9a 82 10 80       	push   $0x8010829a
80100586:	e8 34 fe ff ff       	call   801003bf <cprintf>
8010058b:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
8010058e:	8b 45 08             	mov    0x8(%ebp),%eax
80100591:	83 ec 0c             	sub    $0xc,%esp
80100594:	50                   	push   %eax
80100595:	e8 25 fe ff ff       	call   801003bf <cprintf>
8010059a:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
8010059d:	83 ec 0c             	sub    $0xc,%esp
801005a0:	68 a9 82 10 80       	push   $0x801082a9
801005a5:	e8 15 fe ff ff       	call   801003bf <cprintf>
801005aa:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005ad:	83 ec 08             	sub    $0x8,%esp
801005b0:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005b3:	50                   	push   %eax
801005b4:	8d 45 08             	lea    0x8(%ebp),%eax
801005b7:	50                   	push   %eax
801005b8:	e8 64 46 00 00       	call   80104c21 <getcallerpcs>
801005bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005c7:	eb 1c                	jmp    801005e5 <panic+0x89>
    cprintf(" %p", pcs[i]);
801005c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005cc:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005d0:	83 ec 08             	sub    $0x8,%esp
801005d3:	50                   	push   %eax
801005d4:	68 ab 82 10 80       	push   $0x801082ab
801005d9:	e8 e1 fd ff ff       	call   801003bf <cprintf>
801005de:	83 c4 10             	add    $0x10,%esp
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005e1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005e5:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005e9:	7e de                	jle    801005c9 <panic+0x6d>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005eb:	c7 05 c0 b5 10 80 01 	movl   $0x1,0x8010b5c0
801005f2:	00 00 00 
  for(;;)
    ;
801005f5:	eb fe                	jmp    801005f5 <panic+0x99>

801005f7 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
801005f7:	55                   	push   %ebp
801005f8:	89 e5                	mov    %esp,%ebp
801005fa:	83 ec 18             	sub    $0x18,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
801005fd:	6a 0e                	push   $0xe
801005ff:	68 d4 03 00 00       	push   $0x3d4
80100604:	e8 e4 fc ff ff       	call   801002ed <outb>
80100609:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
8010060c:	68 d5 03 00 00       	push   $0x3d5
80100611:	e8 ba fc ff ff       	call   801002d0 <inb>
80100616:	83 c4 04             	add    $0x4,%esp
80100619:	0f b6 c0             	movzbl %al,%eax
8010061c:	c1 e0 08             	shl    $0x8,%eax
8010061f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
80100622:	6a 0f                	push   $0xf
80100624:	68 d4 03 00 00       	push   $0x3d4
80100629:	e8 bf fc ff ff       	call   801002ed <outb>
8010062e:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
80100631:	68 d5 03 00 00       	push   $0x3d5
80100636:	e8 95 fc ff ff       	call   801002d0 <inb>
8010063b:	83 c4 04             	add    $0x4,%esp
8010063e:	0f b6 c0             	movzbl %al,%eax
80100641:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
80100644:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100648:	75 30                	jne    8010067a <cgaputc+0x83>
    pos += 80 - pos%80;
8010064a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010064d:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100652:	89 c8                	mov    %ecx,%eax
80100654:	f7 ea                	imul   %edx
80100656:	c1 fa 05             	sar    $0x5,%edx
80100659:	89 c8                	mov    %ecx,%eax
8010065b:	c1 f8 1f             	sar    $0x1f,%eax
8010065e:	29 c2                	sub    %eax,%edx
80100660:	89 d0                	mov    %edx,%eax
80100662:	c1 e0 02             	shl    $0x2,%eax
80100665:	01 d0                	add    %edx,%eax
80100667:	c1 e0 04             	shl    $0x4,%eax
8010066a:	29 c1                	sub    %eax,%ecx
8010066c:	89 ca                	mov    %ecx,%edx
8010066e:	b8 50 00 00 00       	mov    $0x50,%eax
80100673:	29 d0                	sub    %edx,%eax
80100675:	01 45 f4             	add    %eax,-0xc(%ebp)
80100678:	eb 34                	jmp    801006ae <cgaputc+0xb7>
  else if(c == BACKSPACE){
8010067a:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100681:	75 0c                	jne    8010068f <cgaputc+0x98>
    if(pos > 0) --pos;
80100683:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100687:	7e 25                	jle    801006ae <cgaputc+0xb7>
80100689:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
8010068d:	eb 1f                	jmp    801006ae <cgaputc+0xb7>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010068f:	8b 0d 00 90 10 80    	mov    0x80109000,%ecx
80100695:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100698:	8d 50 01             	lea    0x1(%eax),%edx
8010069b:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010069e:	01 c0                	add    %eax,%eax
801006a0:	01 c8                	add    %ecx,%eax
801006a2:	8b 55 08             	mov    0x8(%ebp),%edx
801006a5:	0f b6 d2             	movzbl %dl,%edx
801006a8:	80 ce 07             	or     $0x7,%dh
801006ab:	66 89 10             	mov    %dx,(%eax)
  
  if((pos/80) >= 24){  // Scroll up.
801006ae:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
801006b5:	7e 4c                	jle    80100703 <cgaputc+0x10c>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006b7:	a1 00 90 10 80       	mov    0x80109000,%eax
801006bc:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
801006c2:	a1 00 90 10 80       	mov    0x80109000,%eax
801006c7:	83 ec 04             	sub    $0x4,%esp
801006ca:	68 60 0e 00 00       	push   $0xe60
801006cf:	52                   	push   %edx
801006d0:	50                   	push   %eax
801006d1:	e8 af 47 00 00       	call   80104e85 <memmove>
801006d6:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
801006d9:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006dd:	b8 80 07 00 00       	mov    $0x780,%eax
801006e2:	2b 45 f4             	sub    -0xc(%ebp),%eax
801006e5:	8d 14 00             	lea    (%eax,%eax,1),%edx
801006e8:	a1 00 90 10 80       	mov    0x80109000,%eax
801006ed:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801006f0:	01 c9                	add    %ecx,%ecx
801006f2:	01 c8                	add    %ecx,%eax
801006f4:	83 ec 04             	sub    $0x4,%esp
801006f7:	52                   	push   %edx
801006f8:	6a 00                	push   $0x0
801006fa:	50                   	push   %eax
801006fb:	e8 c6 46 00 00       	call   80104dc6 <memset>
80100700:	83 c4 10             	add    $0x10,%esp
  }
  
  outb(CRTPORT, 14);
80100703:	83 ec 08             	sub    $0x8,%esp
80100706:	6a 0e                	push   $0xe
80100708:	68 d4 03 00 00       	push   $0x3d4
8010070d:	e8 db fb ff ff       	call   801002ed <outb>
80100712:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
80100715:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100718:	c1 f8 08             	sar    $0x8,%eax
8010071b:	0f b6 c0             	movzbl %al,%eax
8010071e:	83 ec 08             	sub    $0x8,%esp
80100721:	50                   	push   %eax
80100722:	68 d5 03 00 00       	push   $0x3d5
80100727:	e8 c1 fb ff ff       	call   801002ed <outb>
8010072c:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
8010072f:	83 ec 08             	sub    $0x8,%esp
80100732:	6a 0f                	push   $0xf
80100734:	68 d4 03 00 00       	push   $0x3d4
80100739:	e8 af fb ff ff       	call   801002ed <outb>
8010073e:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
80100741:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100744:	0f b6 c0             	movzbl %al,%eax
80100747:	83 ec 08             	sub    $0x8,%esp
8010074a:	50                   	push   %eax
8010074b:	68 d5 03 00 00       	push   $0x3d5
80100750:	e8 98 fb ff ff       	call   801002ed <outb>
80100755:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
80100758:	a1 00 90 10 80       	mov    0x80109000,%eax
8010075d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100760:	01 d2                	add    %edx,%edx
80100762:	01 d0                	add    %edx,%eax
80100764:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
80100769:	c9                   	leave  
8010076a:	c3                   	ret    

8010076b <consputc>:

void
consputc(int c)
{
8010076b:	55                   	push   %ebp
8010076c:	89 e5                	mov    %esp,%ebp
8010076e:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
80100771:	a1 c0 b5 10 80       	mov    0x8010b5c0,%eax
80100776:	85 c0                	test   %eax,%eax
80100778:	74 07                	je     80100781 <consputc+0x16>
    cli();
8010077a:	e8 8c fb ff ff       	call   8010030b <cli>
    for(;;)
      ;
8010077f:	eb fe                	jmp    8010077f <consputc+0x14>
  }

  if(c == BACKSPACE){
80100781:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100788:	75 29                	jne    801007b3 <consputc+0x48>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010078a:	83 ec 0c             	sub    $0xc,%esp
8010078d:	6a 08                	push   $0x8
8010078f:	e8 75 61 00 00       	call   80106909 <uartputc>
80100794:	83 c4 10             	add    $0x10,%esp
80100797:	83 ec 0c             	sub    $0xc,%esp
8010079a:	6a 20                	push   $0x20
8010079c:	e8 68 61 00 00       	call   80106909 <uartputc>
801007a1:	83 c4 10             	add    $0x10,%esp
801007a4:	83 ec 0c             	sub    $0xc,%esp
801007a7:	6a 08                	push   $0x8
801007a9:	e8 5b 61 00 00       	call   80106909 <uartputc>
801007ae:	83 c4 10             	add    $0x10,%esp
801007b1:	eb 0e                	jmp    801007c1 <consputc+0x56>
  } else
    uartputc(c);
801007b3:	83 ec 0c             	sub    $0xc,%esp
801007b6:	ff 75 08             	pushl  0x8(%ebp)
801007b9:	e8 4b 61 00 00       	call   80106909 <uartputc>
801007be:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
801007c1:	83 ec 0c             	sub    $0xc,%esp
801007c4:	ff 75 08             	pushl  0x8(%ebp)
801007c7:	e8 2b fe ff ff       	call   801005f7 <cgaputc>
801007cc:	83 c4 10             	add    $0x10,%esp
}
801007cf:	c9                   	leave  
801007d0:	c3                   	ret    

801007d1 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007d1:	55                   	push   %ebp
801007d2:	89 e5                	mov    %esp,%ebp
801007d4:	83 ec 18             	sub    $0x18,%esp
  int c;
  acquire(&input.lock);
801007d7:	83 ec 0c             	sub    $0xc,%esp
801007da:	68 c0 dd 10 80       	push   $0x8010ddc0
801007df:	e8 86 43 00 00       	call   80104b6a <acquire>
801007e4:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
801007e7:	e9 43 01 00 00       	jmp    8010092f <consoleintr+0x15e>
    switch(c){
801007ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007ef:	83 f8 10             	cmp    $0x10,%eax
801007f2:	74 1e                	je     80100812 <consoleintr+0x41>
801007f4:	83 f8 10             	cmp    $0x10,%eax
801007f7:	7f 0a                	jg     80100803 <consoleintr+0x32>
801007f9:	83 f8 08             	cmp    $0x8,%eax
801007fc:	74 67                	je     80100865 <consoleintr+0x94>
801007fe:	e9 93 00 00 00       	jmp    80100896 <consoleintr+0xc5>
80100803:	83 f8 15             	cmp    $0x15,%eax
80100806:	74 31                	je     80100839 <consoleintr+0x68>
80100808:	83 f8 7f             	cmp    $0x7f,%eax
8010080b:	74 58                	je     80100865 <consoleintr+0x94>
8010080d:	e9 84 00 00 00       	jmp    80100896 <consoleintr+0xc5>
    case C('P'):  // Process listing.
      procdump();
80100812:	e8 f4 41 00 00       	call   80104a0b <procdump>
      break;
80100817:	e9 13 01 00 00       	jmp    8010092f <consoleintr+0x15e>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
8010081c:	a1 7c de 10 80       	mov    0x8010de7c,%eax
80100821:	83 e8 01             	sub    $0x1,%eax
80100824:	a3 7c de 10 80       	mov    %eax,0x8010de7c
        consputc(BACKSPACE);
80100829:	83 ec 0c             	sub    $0xc,%esp
8010082c:	68 00 01 00 00       	push   $0x100
80100831:	e8 35 ff ff ff       	call   8010076b <consputc>
80100836:	83 c4 10             	add    $0x10,%esp
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100839:	8b 15 7c de 10 80    	mov    0x8010de7c,%edx
8010083f:	a1 78 de 10 80       	mov    0x8010de78,%eax
80100844:	39 c2                	cmp    %eax,%edx
80100846:	74 18                	je     80100860 <consoleintr+0x8f>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100848:	a1 7c de 10 80       	mov    0x8010de7c,%eax
8010084d:	83 e8 01             	sub    $0x1,%eax
80100850:	83 e0 7f             	and    $0x7f,%eax
80100853:	05 c0 dd 10 80       	add    $0x8010ddc0,%eax
80100858:	0f b6 40 34          	movzbl 0x34(%eax),%eax
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010085c:	3c 0a                	cmp    $0xa,%al
8010085e:	75 bc                	jne    8010081c <consoleintr+0x4b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
80100860:	e9 ca 00 00 00       	jmp    8010092f <consoleintr+0x15e>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100865:	8b 15 7c de 10 80    	mov    0x8010de7c,%edx
8010086b:	a1 78 de 10 80       	mov    0x8010de78,%eax
80100870:	39 c2                	cmp    %eax,%edx
80100872:	74 1d                	je     80100891 <consoleintr+0xc0>
        input.e--;
80100874:	a1 7c de 10 80       	mov    0x8010de7c,%eax
80100879:	83 e8 01             	sub    $0x1,%eax
8010087c:	a3 7c de 10 80       	mov    %eax,0x8010de7c
        consputc(BACKSPACE);
80100881:	83 ec 0c             	sub    $0xc,%esp
80100884:	68 00 01 00 00       	push   $0x100
80100889:	e8 dd fe ff ff       	call   8010076b <consputc>
8010088e:	83 c4 10             	add    $0x10,%esp
      }
      break;
80100891:	e9 99 00 00 00       	jmp    8010092f <consoleintr+0x15e>

    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100896:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010089a:	0f 84 8e 00 00 00    	je     8010092e <consoleintr+0x15d>
801008a0:	8b 15 7c de 10 80    	mov    0x8010de7c,%edx
801008a6:	a1 74 de 10 80       	mov    0x8010de74,%eax
801008ab:	29 c2                	sub    %eax,%edx
801008ad:	89 d0                	mov    %edx,%eax
801008af:	83 f8 7f             	cmp    $0x7f,%eax
801008b2:	77 7a                	ja     8010092e <consoleintr+0x15d>
        c = (c == '\r') ? '\n' : c;
801008b4:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
801008b8:	74 05                	je     801008bf <consoleintr+0xee>
801008ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801008bd:	eb 05                	jmp    801008c4 <consoleintr+0xf3>
801008bf:	b8 0a 00 00 00       	mov    $0xa,%eax
801008c4:	89 45 f4             	mov    %eax,-0xc(%ebp)

        input.buf[input.e++ % INPUT_BUF] = c;
801008c7:	a1 7c de 10 80       	mov    0x8010de7c,%eax
801008cc:	8d 50 01             	lea    0x1(%eax),%edx
801008cf:	89 15 7c de 10 80    	mov    %edx,0x8010de7c
801008d5:	83 e0 7f             	and    $0x7f,%eax
801008d8:	89 c2                	mov    %eax,%edx
801008da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801008dd:	89 c1                	mov    %eax,%ecx
801008df:	8d 82 c0 dd 10 80    	lea    -0x7fef2240(%edx),%eax
801008e5:	88 48 34             	mov    %cl,0x34(%eax)
        consputc(c);
801008e8:	83 ec 0c             	sub    $0xc,%esp
801008eb:	ff 75 f4             	pushl  -0xc(%ebp)
801008ee:	e8 78 fe ff ff       	call   8010076b <consputc>
801008f3:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008f6:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
801008fa:	74 18                	je     80100914 <consoleintr+0x143>
801008fc:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
80100900:	74 12                	je     80100914 <consoleintr+0x143>
80100902:	a1 7c de 10 80       	mov    0x8010de7c,%eax
80100907:	8b 15 74 de 10 80    	mov    0x8010de74,%edx
8010090d:	83 ea 80             	sub    $0xffffff80,%edx
80100910:	39 d0                	cmp    %edx,%eax
80100912:	75 1a                	jne    8010092e <consoleintr+0x15d>
          input.w = input.e;
80100914:	a1 7c de 10 80       	mov    0x8010de7c,%eax
80100919:	a3 78 de 10 80       	mov    %eax,0x8010de78
          wakeup(&input.r);
8010091e:	83 ec 0c             	sub    $0xc,%esp
80100921:	68 74 de 10 80       	push   $0x8010de74
80100926:	e8 26 40 00 00       	call   80104951 <wakeup>
8010092b:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
8010092e:	90                   	nop
void
consoleintr(int (*getc)(void))
{
  int c;
  acquire(&input.lock);
  while((c = getc()) >= 0){
8010092f:	8b 45 08             	mov    0x8(%ebp),%eax
80100932:	ff d0                	call   *%eax
80100934:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100937:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010093b:	0f 89 ab fe ff ff    	jns    801007ec <consoleintr+0x1b>
        }
      }
      break;
    }
  }
  release(&input.lock);
80100941:	83 ec 0c             	sub    $0xc,%esp
80100944:	68 c0 dd 10 80       	push   $0x8010ddc0
80100949:	e8 82 42 00 00       	call   80104bd0 <release>
8010094e:	83 c4 10             	add    $0x10,%esp
}
80100951:	c9                   	leave  
80100952:	c3                   	ret    

80100953 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
80100953:	55                   	push   %ebp
80100954:	89 e5                	mov    %esp,%ebp
80100956:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80100959:	83 ec 0c             	sub    $0xc,%esp
8010095c:	ff 75 08             	pushl  0x8(%ebp)
8010095f:	e8 b9 10 00 00       	call   80101a1d <iunlock>
80100964:	83 c4 10             	add    $0x10,%esp
  target = n;
80100967:	8b 45 10             	mov    0x10(%ebp),%eax
8010096a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&input.lock);
8010096d:	83 ec 0c             	sub    $0xc,%esp
80100970:	68 c0 dd 10 80       	push   $0x8010ddc0
80100975:	e8 f0 41 00 00       	call   80104b6a <acquire>
8010097a:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
8010097d:	e9 b4 00 00 00       	jmp    80100a36 <consoleread+0xe3>
    while(input.r == input.w){
80100982:	eb 4a                	jmp    801009ce <consoleread+0x7b>
      if(proc->killed){
80100984:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010098a:	8b 40 24             	mov    0x24(%eax),%eax
8010098d:	85 c0                	test   %eax,%eax
8010098f:	74 28                	je     801009b9 <consoleread+0x66>
        release(&input.lock);
80100991:	83 ec 0c             	sub    $0xc,%esp
80100994:	68 c0 dd 10 80       	push   $0x8010ddc0
80100999:	e8 32 42 00 00       	call   80104bd0 <release>
8010099e:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
801009a1:	83 ec 0c             	sub    $0xc,%esp
801009a4:	ff 75 08             	pushl  0x8(%ebp)
801009a7:	e8 1a 0f 00 00       	call   801018c6 <ilock>
801009ac:	83 c4 10             	add    $0x10,%esp
        return -1;
801009af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801009b4:	e9 af 00 00 00       	jmp    80100a68 <consoleread+0x115>
      }
      sleep(&input.r, &input.lock);
801009b9:	83 ec 08             	sub    $0x8,%esp
801009bc:	68 c0 dd 10 80       	push   $0x8010ddc0
801009c1:	68 74 de 10 80       	push   $0x8010de74
801009c6:	e8 9d 3e 00 00       	call   80104868 <sleep>
801009cb:	83 c4 10             	add    $0x10,%esp

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
801009ce:	8b 15 74 de 10 80    	mov    0x8010de74,%edx
801009d4:	a1 78 de 10 80       	mov    0x8010de78,%eax
801009d9:	39 c2                	cmp    %eax,%edx
801009db:	74 a7                	je     80100984 <consoleread+0x31>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801009dd:	a1 74 de 10 80       	mov    0x8010de74,%eax
801009e2:	8d 50 01             	lea    0x1(%eax),%edx
801009e5:	89 15 74 de 10 80    	mov    %edx,0x8010de74
801009eb:	83 e0 7f             	and    $0x7f,%eax
801009ee:	05 c0 dd 10 80       	add    $0x8010ddc0,%eax
801009f3:	0f b6 40 34          	movzbl 0x34(%eax),%eax
801009f7:	0f be c0             	movsbl %al,%eax
801009fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
801009fd:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100a01:	75 19                	jne    80100a1c <consoleread+0xc9>
      if(n < target){
80100a03:	8b 45 10             	mov    0x10(%ebp),%eax
80100a06:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100a09:	73 0f                	jae    80100a1a <consoleread+0xc7>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100a0b:	a1 74 de 10 80       	mov    0x8010de74,%eax
80100a10:	83 e8 01             	sub    $0x1,%eax
80100a13:	a3 74 de 10 80       	mov    %eax,0x8010de74
      }
      break;
80100a18:	eb 26                	jmp    80100a40 <consoleread+0xed>
80100a1a:	eb 24                	jmp    80100a40 <consoleread+0xed>
    }
    *dst++ = c;
80100a1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a1f:	8d 50 01             	lea    0x1(%eax),%edx
80100a22:	89 55 0c             	mov    %edx,0xc(%ebp)
80100a25:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a28:	88 10                	mov    %dl,(%eax)
    --n;
80100a2a:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100a2e:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a32:	75 02                	jne    80100a36 <consoleread+0xe3>
      break;
80100a34:	eb 0a                	jmp    80100a40 <consoleread+0xed>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
80100a36:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100a3a:	0f 8f 42 ff ff ff    	jg     80100982 <consoleread+0x2f>
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&input.lock);
80100a40:	83 ec 0c             	sub    $0xc,%esp
80100a43:	68 c0 dd 10 80       	push   $0x8010ddc0
80100a48:	e8 83 41 00 00       	call   80104bd0 <release>
80100a4d:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100a50:	83 ec 0c             	sub    $0xc,%esp
80100a53:	ff 75 08             	pushl  0x8(%ebp)
80100a56:	e8 6b 0e 00 00       	call   801018c6 <ilock>
80100a5b:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100a5e:	8b 45 10             	mov    0x10(%ebp),%eax
80100a61:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a64:	29 c2                	sub    %eax,%edx
80100a66:	89 d0                	mov    %edx,%eax
}
80100a68:	c9                   	leave  
80100a69:	c3                   	ret    

80100a6a <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100a6a:	55                   	push   %ebp
80100a6b:	89 e5                	mov    %esp,%ebp
80100a6d:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100a70:	83 ec 0c             	sub    $0xc,%esp
80100a73:	ff 75 08             	pushl  0x8(%ebp)
80100a76:	e8 a2 0f 00 00       	call   80101a1d <iunlock>
80100a7b:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100a7e:	83 ec 0c             	sub    $0xc,%esp
80100a81:	68 e0 b5 10 80       	push   $0x8010b5e0
80100a86:	e8 df 40 00 00       	call   80104b6a <acquire>
80100a8b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100a8e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a95:	eb 21                	jmp    80100ab8 <consolewrite+0x4e>
    consputc(buf[i] & 0xff);
80100a97:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a9a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a9d:	01 d0                	add    %edx,%eax
80100a9f:	0f b6 00             	movzbl (%eax),%eax
80100aa2:	0f be c0             	movsbl %al,%eax
80100aa5:	0f b6 c0             	movzbl %al,%eax
80100aa8:	83 ec 0c             	sub    $0xc,%esp
80100aab:	50                   	push   %eax
80100aac:	e8 ba fc ff ff       	call   8010076b <consputc>
80100ab1:	83 c4 10             	add    $0x10,%esp
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100ab4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100ab8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100abb:	3b 45 10             	cmp    0x10(%ebp),%eax
80100abe:	7c d7                	jl     80100a97 <consolewrite+0x2d>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100ac0:	83 ec 0c             	sub    $0xc,%esp
80100ac3:	68 e0 b5 10 80       	push   $0x8010b5e0
80100ac8:	e8 03 41 00 00       	call   80104bd0 <release>
80100acd:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100ad0:	83 ec 0c             	sub    $0xc,%esp
80100ad3:	ff 75 08             	pushl  0x8(%ebp)
80100ad6:	e8 eb 0d 00 00       	call   801018c6 <ilock>
80100adb:	83 c4 10             	add    $0x10,%esp

  return n;
80100ade:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100ae1:	c9                   	leave  
80100ae2:	c3                   	ret    

80100ae3 <consoleinit>:

void
consoleinit(void)
{
80100ae3:	55                   	push   %ebp
80100ae4:	89 e5                	mov    %esp,%ebp
80100ae6:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100ae9:	83 ec 08             	sub    $0x8,%esp
80100aec:	68 af 82 10 80       	push   $0x801082af
80100af1:	68 e0 b5 10 80       	push   $0x8010b5e0
80100af6:	e8 4e 40 00 00       	call   80104b49 <initlock>
80100afb:	83 c4 10             	add    $0x10,%esp
  initlock(&input.lock, "input");
80100afe:	83 ec 08             	sub    $0x8,%esp
80100b01:	68 b7 82 10 80       	push   $0x801082b7
80100b06:	68 c0 dd 10 80       	push   $0x8010ddc0
80100b0b:	e8 39 40 00 00       	call   80104b49 <initlock>
80100b10:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100b13:	c7 05 4c e8 10 80 6a 	movl   $0x80100a6a,0x8010e84c
80100b1a:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b1d:	c7 05 48 e8 10 80 53 	movl   $0x80100953,0x8010e848
80100b24:	09 10 80 
  cons.locking = 1;
80100b27:	c7 05 14 b6 10 80 01 	movl   $0x1,0x8010b614
80100b2e:	00 00 00 

  picenable(IRQ_KBD);
80100b31:	83 ec 0c             	sub    $0xc,%esp
80100b34:	6a 01                	push   $0x1
80100b36:	e8 97 2f 00 00       	call   80103ad2 <picenable>
80100b3b:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80100b3e:	83 ec 08             	sub    $0x8,%esp
80100b41:	6a 00                	push   $0x0
80100b43:	6a 01                	push   $0x1
80100b45:	e8 ac 1e 00 00       	call   801029f6 <ioapicenable>
80100b4a:	83 c4 10             	add    $0x10,%esp
}
80100b4d:	c9                   	leave  
80100b4e:	c3                   	ret    

80100b4f <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b4f:	55                   	push   %ebp
80100b50:	89 e5                	mov    %esp,%ebp
80100b52:	81 ec 18 01 00 00    	sub    $0x118,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  if((ip = namei(path)) == 0)
80100b58:	83 ec 0c             	sub    $0xc,%esp
80100b5b:	ff 75 08             	pushl  0x8(%ebp)
80100b5e:	e8 26 19 00 00       	call   80102489 <namei>
80100b63:	83 c4 10             	add    $0x10,%esp
80100b66:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b69:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b6d:	75 0a                	jne    80100b79 <exec+0x2a>
    return -1;
80100b6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b74:	e9 af 03 00 00       	jmp    80100f28 <exec+0x3d9>
  ilock(ip);
80100b79:	83 ec 0c             	sub    $0xc,%esp
80100b7c:	ff 75 d8             	pushl  -0x28(%ebp)
80100b7f:	e8 42 0d 00 00       	call   801018c6 <ilock>
80100b84:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100b87:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100b8e:	6a 34                	push   $0x34
80100b90:	6a 00                	push   $0x0
80100b92:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100b98:	50                   	push   %eax
80100b99:	ff 75 d8             	pushl  -0x28(%ebp)
80100b9c:	e8 87 12 00 00       	call   80101e28 <readi>
80100ba1:	83 c4 10             	add    $0x10,%esp
80100ba4:	83 f8 33             	cmp    $0x33,%eax
80100ba7:	77 05                	ja     80100bae <exec+0x5f>
    goto bad;
80100ba9:	e9 4d 03 00 00       	jmp    80100efb <exec+0x3ac>
  if(elf.magic != ELF_MAGIC)
80100bae:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bb4:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100bb9:	74 05                	je     80100bc0 <exec+0x71>
    goto bad;
80100bbb:	e9 3b 03 00 00       	jmp    80100efb <exec+0x3ac>

  if((pgdir = setupkvm()) == 0)
80100bc0:	e8 94 6e 00 00       	call   80107a59 <setupkvm>
80100bc5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100bc8:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100bcc:	75 05                	jne    80100bd3 <exec+0x84>
    goto bad;
80100bce:	e9 28 03 00 00       	jmp    80100efb <exec+0x3ac>

  // Load program into memory.
  sz = 0;
80100bd3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bda:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100be1:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100be7:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100bea:	e9 ae 00 00 00       	jmp    80100c9d <exec+0x14e>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bef:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100bf2:	6a 20                	push   $0x20
80100bf4:	50                   	push   %eax
80100bf5:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100bfb:	50                   	push   %eax
80100bfc:	ff 75 d8             	pushl  -0x28(%ebp)
80100bff:	e8 24 12 00 00       	call   80101e28 <readi>
80100c04:	83 c4 10             	add    $0x10,%esp
80100c07:	83 f8 20             	cmp    $0x20,%eax
80100c0a:	74 05                	je     80100c11 <exec+0xc2>
      goto bad;
80100c0c:	e9 ea 02 00 00       	jmp    80100efb <exec+0x3ac>
    if(ph.type != ELF_PROG_LOAD)
80100c11:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c17:	83 f8 01             	cmp    $0x1,%eax
80100c1a:	74 02                	je     80100c1e <exec+0xcf>
      continue;
80100c1c:	eb 72                	jmp    80100c90 <exec+0x141>
    if(ph.memsz < ph.filesz)
80100c1e:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100c24:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c2a:	39 c2                	cmp    %eax,%edx
80100c2c:	73 05                	jae    80100c33 <exec+0xe4>
      goto bad;
80100c2e:	e9 c8 02 00 00       	jmp    80100efb <exec+0x3ac>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c33:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c39:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c3f:	01 d0                	add    %edx,%eax
80100c41:	83 ec 04             	sub    $0x4,%esp
80100c44:	50                   	push   %eax
80100c45:	ff 75 e0             	pushl  -0x20(%ebp)
80100c48:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c4b:	e8 ac 71 00 00       	call   80107dfc <allocuvm>
80100c50:	83 c4 10             	add    $0x10,%esp
80100c53:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c56:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100c5a:	75 05                	jne    80100c61 <exec+0x112>
      goto bad;
80100c5c:	e9 9a 02 00 00       	jmp    80100efb <exec+0x3ac>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c61:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100c67:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c6d:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100c73:	83 ec 0c             	sub    $0xc,%esp
80100c76:	52                   	push   %edx
80100c77:	50                   	push   %eax
80100c78:	ff 75 d8             	pushl  -0x28(%ebp)
80100c7b:	51                   	push   %ecx
80100c7c:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c7f:	e8 a1 70 00 00       	call   80107d25 <loaduvm>
80100c84:	83 c4 20             	add    $0x20,%esp
80100c87:	85 c0                	test   %eax,%eax
80100c89:	79 05                	jns    80100c90 <exec+0x141>
      goto bad;
80100c8b:	e9 6b 02 00 00       	jmp    80100efb <exec+0x3ac>
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c90:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100c94:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c97:	83 c0 20             	add    $0x20,%eax
80100c9a:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100c9d:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100ca4:	0f b7 c0             	movzwl %ax,%eax
80100ca7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80100caa:	0f 8f 3f ff ff ff    	jg     80100bef <exec+0xa0>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100cb0:	83 ec 0c             	sub    $0xc,%esp
80100cb3:	ff 75 d8             	pushl  -0x28(%ebp)
80100cb6:	e8 c2 0e 00 00       	call   80101b7d <iunlockput>
80100cbb:	83 c4 10             	add    $0x10,%esp
  ip = 0;
80100cbe:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100cc5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cc8:	05 ff 0f 00 00       	add    $0xfff,%eax
80100ccd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100cd2:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100cd5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cd8:	05 00 20 00 00       	add    $0x2000,%eax
80100cdd:	83 ec 04             	sub    $0x4,%esp
80100ce0:	50                   	push   %eax
80100ce1:	ff 75 e0             	pushl  -0x20(%ebp)
80100ce4:	ff 75 d4             	pushl  -0x2c(%ebp)
80100ce7:	e8 10 71 00 00       	call   80107dfc <allocuvm>
80100cec:	83 c4 10             	add    $0x10,%esp
80100cef:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100cf2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100cf6:	75 05                	jne    80100cfd <exec+0x1ae>
    goto bad;
80100cf8:	e9 fe 01 00 00       	jmp    80100efb <exec+0x3ac>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cfd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d00:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d05:	83 ec 08             	sub    $0x8,%esp
80100d08:	50                   	push   %eax
80100d09:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d0c:	e8 10 73 00 00       	call   80108021 <clearpteu>
80100d11:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100d14:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d17:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d1a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100d21:	e9 98 00 00 00       	jmp    80100dbe <exec+0x26f>
    if(argc >= MAXARG)
80100d26:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100d2a:	76 05                	jbe    80100d31 <exec+0x1e2>
      goto bad;
80100d2c:	e9 ca 01 00 00       	jmp    80100efb <exec+0x3ac>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d34:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d3b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d3e:	01 d0                	add    %edx,%eax
80100d40:	8b 00                	mov    (%eax),%eax
80100d42:	83 ec 0c             	sub    $0xc,%esp
80100d45:	50                   	push   %eax
80100d46:	e8 ca 42 00 00       	call   80105015 <strlen>
80100d4b:	83 c4 10             	add    $0x10,%esp
80100d4e:	89 c2                	mov    %eax,%edx
80100d50:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d53:	29 d0                	sub    %edx,%eax
80100d55:	83 e8 01             	sub    $0x1,%eax
80100d58:	83 e0 fc             	and    $0xfffffffc,%eax
80100d5b:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d5e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d61:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d68:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d6b:	01 d0                	add    %edx,%eax
80100d6d:	8b 00                	mov    (%eax),%eax
80100d6f:	83 ec 0c             	sub    $0xc,%esp
80100d72:	50                   	push   %eax
80100d73:	e8 9d 42 00 00       	call   80105015 <strlen>
80100d78:	83 c4 10             	add    $0x10,%esp
80100d7b:	83 c0 01             	add    $0x1,%eax
80100d7e:	89 c1                	mov    %eax,%ecx
80100d80:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d83:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d8a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d8d:	01 d0                	add    %edx,%eax
80100d8f:	8b 00                	mov    (%eax),%eax
80100d91:	51                   	push   %ecx
80100d92:	50                   	push   %eax
80100d93:	ff 75 dc             	pushl  -0x24(%ebp)
80100d96:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d99:	e8 26 74 00 00       	call   801081c4 <copyout>
80100d9e:	83 c4 10             	add    $0x10,%esp
80100da1:	85 c0                	test   %eax,%eax
80100da3:	79 05                	jns    80100daa <exec+0x25b>
      goto bad;
80100da5:	e9 51 01 00 00       	jmp    80100efb <exec+0x3ac>
    ustack[3+argc] = sp;
80100daa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dad:	8d 50 03             	lea    0x3(%eax),%edx
80100db0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100db3:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100dba:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100dbe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dc1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dc8:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dcb:	01 d0                	add    %edx,%eax
80100dcd:	8b 00                	mov    (%eax),%eax
80100dcf:	85 c0                	test   %eax,%eax
80100dd1:	0f 85 4f ff ff ff    	jne    80100d26 <exec+0x1d7>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100dd7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dda:	83 c0 03             	add    $0x3,%eax
80100ddd:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100de4:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100de8:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100def:	ff ff ff 
  ustack[1] = argc;
80100df2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100df5:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100dfb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dfe:	83 c0 01             	add    $0x1,%eax
80100e01:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e08:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e0b:	29 d0                	sub    %edx,%eax
80100e0d:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100e13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e16:	83 c0 04             	add    $0x4,%eax
80100e19:	c1 e0 02             	shl    $0x2,%eax
80100e1c:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e1f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e22:	83 c0 04             	add    $0x4,%eax
80100e25:	c1 e0 02             	shl    $0x2,%eax
80100e28:	50                   	push   %eax
80100e29:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100e2f:	50                   	push   %eax
80100e30:	ff 75 dc             	pushl  -0x24(%ebp)
80100e33:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e36:	e8 89 73 00 00       	call   801081c4 <copyout>
80100e3b:	83 c4 10             	add    $0x10,%esp
80100e3e:	85 c0                	test   %eax,%eax
80100e40:	79 05                	jns    80100e47 <exec+0x2f8>
    goto bad;
80100e42:	e9 b4 00 00 00       	jmp    80100efb <exec+0x3ac>

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e47:	8b 45 08             	mov    0x8(%ebp),%eax
80100e4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100e4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e50:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100e53:	eb 17                	jmp    80100e6c <exec+0x31d>
    if(*s == '/')
80100e55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e58:	0f b6 00             	movzbl (%eax),%eax
80100e5b:	3c 2f                	cmp    $0x2f,%al
80100e5d:	75 09                	jne    80100e68 <exec+0x319>
      last = s+1;
80100e5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e62:	83 c0 01             	add    $0x1,%eax
80100e65:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e68:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100e6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e6f:	0f b6 00             	movzbl (%eax),%eax
80100e72:	84 c0                	test   %al,%al
80100e74:	75 df                	jne    80100e55 <exec+0x306>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100e76:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e7c:	83 c0 6c             	add    $0x6c,%eax
80100e7f:	83 ec 04             	sub    $0x4,%esp
80100e82:	6a 10                	push   $0x10
80100e84:	ff 75 f0             	pushl  -0x10(%ebp)
80100e87:	50                   	push   %eax
80100e88:	e8 3e 41 00 00       	call   80104fcb <safestrcpy>
80100e8d:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100e90:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e96:	8b 40 04             	mov    0x4(%eax),%eax
80100e99:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100e9c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ea2:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100ea5:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100ea8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eae:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100eb1:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100eb3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eb9:	8b 40 18             	mov    0x18(%eax),%eax
80100ebc:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100ec2:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100ec5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ecb:	8b 40 18             	mov    0x18(%eax),%eax
80100ece:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100ed1:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100ed4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eda:	83 ec 0c             	sub    $0xc,%esp
80100edd:	50                   	push   %eax
80100ede:	e8 5b 6c 00 00       	call   80107b3e <switchuvm>
80100ee3:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100ee6:	83 ec 0c             	sub    $0xc,%esp
80100ee9:	ff 75 d0             	pushl  -0x30(%ebp)
80100eec:	e8 91 70 00 00       	call   80107f82 <freevm>
80100ef1:	83 c4 10             	add    $0x10,%esp
  return 0;
80100ef4:	b8 00 00 00 00       	mov    $0x0,%eax
80100ef9:	eb 2d                	jmp    80100f28 <exec+0x3d9>

 bad:
  if(pgdir)
80100efb:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100eff:	74 0e                	je     80100f0f <exec+0x3c0>
    freevm(pgdir);
80100f01:	83 ec 0c             	sub    $0xc,%esp
80100f04:	ff 75 d4             	pushl  -0x2c(%ebp)
80100f07:	e8 76 70 00 00       	call   80107f82 <freevm>
80100f0c:	83 c4 10             	add    $0x10,%esp
  if(ip)
80100f0f:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100f13:	74 0e                	je     80100f23 <exec+0x3d4>
    iunlockput(ip);
80100f15:	83 ec 0c             	sub    $0xc,%esp
80100f18:	ff 75 d8             	pushl  -0x28(%ebp)
80100f1b:	e8 5d 0c 00 00       	call   80101b7d <iunlockput>
80100f20:	83 c4 10             	add    $0x10,%esp
  return -1;
80100f23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f28:	c9                   	leave  
80100f29:	c3                   	ret    

80100f2a <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f2a:	55                   	push   %ebp
80100f2b:	89 e5                	mov    %esp,%ebp
80100f2d:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
80100f30:	83 ec 08             	sub    $0x8,%esp
80100f33:	68 bd 82 10 80       	push   $0x801082bd
80100f38:	68 80 de 10 80       	push   $0x8010de80
80100f3d:	e8 07 3c 00 00       	call   80104b49 <initlock>
80100f42:	83 c4 10             	add    $0x10,%esp
}
80100f45:	c9                   	leave  
80100f46:	c3                   	ret    

80100f47 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f47:	55                   	push   %ebp
80100f48:	89 e5                	mov    %esp,%ebp
80100f4a:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
80100f4d:	83 ec 0c             	sub    $0xc,%esp
80100f50:	68 80 de 10 80       	push   $0x8010de80
80100f55:	e8 10 3c 00 00       	call   80104b6a <acquire>
80100f5a:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f5d:	c7 45 f4 b4 de 10 80 	movl   $0x8010deb4,-0xc(%ebp)
80100f64:	eb 2d                	jmp    80100f93 <filealloc+0x4c>
    if(f->ref == 0){
80100f66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f69:	8b 40 04             	mov    0x4(%eax),%eax
80100f6c:	85 c0                	test   %eax,%eax
80100f6e:	75 1f                	jne    80100f8f <filealloc+0x48>
      f->ref = 1;
80100f70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f73:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80100f7a:	83 ec 0c             	sub    $0xc,%esp
80100f7d:	68 80 de 10 80       	push   $0x8010de80
80100f82:	e8 49 3c 00 00       	call   80104bd0 <release>
80100f87:	83 c4 10             	add    $0x10,%esp
      return f;
80100f8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f8d:	eb 22                	jmp    80100fb1 <filealloc+0x6a>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f8f:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100f93:	81 7d f4 14 e8 10 80 	cmpl   $0x8010e814,-0xc(%ebp)
80100f9a:	72 ca                	jb     80100f66 <filealloc+0x1f>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100f9c:	83 ec 0c             	sub    $0xc,%esp
80100f9f:	68 80 de 10 80       	push   $0x8010de80
80100fa4:	e8 27 3c 00 00       	call   80104bd0 <release>
80100fa9:	83 c4 10             	add    $0x10,%esp
  return 0;
80100fac:	b8 00 00 00 00       	mov    $0x0,%eax
}
80100fb1:	c9                   	leave  
80100fb2:	c3                   	ret    

80100fb3 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100fb3:	55                   	push   %ebp
80100fb4:	89 e5                	mov    %esp,%ebp
80100fb6:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
80100fb9:	83 ec 0c             	sub    $0xc,%esp
80100fbc:	68 80 de 10 80       	push   $0x8010de80
80100fc1:	e8 a4 3b 00 00       	call   80104b6a <acquire>
80100fc6:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80100fc9:	8b 45 08             	mov    0x8(%ebp),%eax
80100fcc:	8b 40 04             	mov    0x4(%eax),%eax
80100fcf:	85 c0                	test   %eax,%eax
80100fd1:	7f 0d                	jg     80100fe0 <filedup+0x2d>
    panic("filedup");
80100fd3:	83 ec 0c             	sub    $0xc,%esp
80100fd6:	68 c4 82 10 80       	push   $0x801082c4
80100fdb:	e8 7c f5 ff ff       	call   8010055c <panic>
  f->ref++;
80100fe0:	8b 45 08             	mov    0x8(%ebp),%eax
80100fe3:	8b 40 04             	mov    0x4(%eax),%eax
80100fe6:	8d 50 01             	lea    0x1(%eax),%edx
80100fe9:	8b 45 08             	mov    0x8(%ebp),%eax
80100fec:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
80100fef:	83 ec 0c             	sub    $0xc,%esp
80100ff2:	68 80 de 10 80       	push   $0x8010de80
80100ff7:	e8 d4 3b 00 00       	call   80104bd0 <release>
80100ffc:	83 c4 10             	add    $0x10,%esp
  return f;
80100fff:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101002:	c9                   	leave  
80101003:	c3                   	ret    

80101004 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101004:	55                   	push   %ebp
80101005:	89 e5                	mov    %esp,%ebp
80101007:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  acquire(&ftable.lock);
8010100a:	83 ec 0c             	sub    $0xc,%esp
8010100d:	68 80 de 10 80       	push   $0x8010de80
80101012:	e8 53 3b 00 00       	call   80104b6a <acquire>
80101017:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
8010101a:	8b 45 08             	mov    0x8(%ebp),%eax
8010101d:	8b 40 04             	mov    0x4(%eax),%eax
80101020:	85 c0                	test   %eax,%eax
80101022:	7f 0d                	jg     80101031 <fileclose+0x2d>
    panic("fileclose");
80101024:	83 ec 0c             	sub    $0xc,%esp
80101027:	68 cc 82 10 80       	push   $0x801082cc
8010102c:	e8 2b f5 ff ff       	call   8010055c <panic>
  if(--f->ref > 0){
80101031:	8b 45 08             	mov    0x8(%ebp),%eax
80101034:	8b 40 04             	mov    0x4(%eax),%eax
80101037:	8d 50 ff             	lea    -0x1(%eax),%edx
8010103a:	8b 45 08             	mov    0x8(%ebp),%eax
8010103d:	89 50 04             	mov    %edx,0x4(%eax)
80101040:	8b 45 08             	mov    0x8(%ebp),%eax
80101043:	8b 40 04             	mov    0x4(%eax),%eax
80101046:	85 c0                	test   %eax,%eax
80101048:	7e 15                	jle    8010105f <fileclose+0x5b>
    release(&ftable.lock);
8010104a:	83 ec 0c             	sub    $0xc,%esp
8010104d:	68 80 de 10 80       	push   $0x8010de80
80101052:	e8 79 3b 00 00       	call   80104bd0 <release>
80101057:	83 c4 10             	add    $0x10,%esp
8010105a:	e9 8b 00 00 00       	jmp    801010ea <fileclose+0xe6>
    return;
  }
  ff = *f;
8010105f:	8b 45 08             	mov    0x8(%ebp),%eax
80101062:	8b 10                	mov    (%eax),%edx
80101064:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101067:	8b 50 04             	mov    0x4(%eax),%edx
8010106a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010106d:	8b 50 08             	mov    0x8(%eax),%edx
80101070:	89 55 e8             	mov    %edx,-0x18(%ebp)
80101073:	8b 50 0c             	mov    0xc(%eax),%edx
80101076:	89 55 ec             	mov    %edx,-0x14(%ebp)
80101079:	8b 50 10             	mov    0x10(%eax),%edx
8010107c:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010107f:	8b 40 14             	mov    0x14(%eax),%eax
80101082:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80101085:	8b 45 08             	mov    0x8(%ebp),%eax
80101088:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
8010108f:	8b 45 08             	mov    0x8(%ebp),%eax
80101092:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
80101098:	83 ec 0c             	sub    $0xc,%esp
8010109b:	68 80 de 10 80       	push   $0x8010de80
801010a0:	e8 2b 3b 00 00       	call   80104bd0 <release>
801010a5:	83 c4 10             	add    $0x10,%esp
  
  if(ff.type == FD_PIPE)
801010a8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010ab:	83 f8 01             	cmp    $0x1,%eax
801010ae:	75 19                	jne    801010c9 <fileclose+0xc5>
    pipeclose(ff.pipe, ff.writable);
801010b0:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
801010b4:	0f be d0             	movsbl %al,%edx
801010b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801010ba:	83 ec 08             	sub    $0x8,%esp
801010bd:	52                   	push   %edx
801010be:	50                   	push   %eax
801010bf:	e8 75 2c 00 00       	call   80103d39 <pipeclose>
801010c4:	83 c4 10             	add    $0x10,%esp
801010c7:	eb 21                	jmp    801010ea <fileclose+0xe6>
  else if(ff.type == FD_INODE){
801010c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010cc:	83 f8 02             	cmp    $0x2,%eax
801010cf:	75 19                	jne    801010ea <fileclose+0xe6>
    begin_trans();
801010d1:	e8 64 21 00 00       	call   8010323a <begin_trans>
    iput(ff.ip);
801010d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801010d9:	83 ec 0c             	sub    $0xc,%esp
801010dc:	50                   	push   %eax
801010dd:	e8 ac 09 00 00       	call   80101a8e <iput>
801010e2:	83 c4 10             	add    $0x10,%esp
    commit_trans();
801010e5:	e8 a2 21 00 00       	call   8010328c <commit_trans>
  }
}
801010ea:	c9                   	leave  
801010eb:	c3                   	ret    

801010ec <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801010ec:	55                   	push   %ebp
801010ed:	89 e5                	mov    %esp,%ebp
801010ef:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
801010f2:	8b 45 08             	mov    0x8(%ebp),%eax
801010f5:	8b 00                	mov    (%eax),%eax
801010f7:	83 f8 02             	cmp    $0x2,%eax
801010fa:	75 40                	jne    8010113c <filestat+0x50>
    ilock(f->ip);
801010fc:	8b 45 08             	mov    0x8(%ebp),%eax
801010ff:	8b 40 10             	mov    0x10(%eax),%eax
80101102:	83 ec 0c             	sub    $0xc,%esp
80101105:	50                   	push   %eax
80101106:	e8 bb 07 00 00       	call   801018c6 <ilock>
8010110b:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
8010110e:	8b 45 08             	mov    0x8(%ebp),%eax
80101111:	8b 40 10             	mov    0x10(%eax),%eax
80101114:	83 ec 08             	sub    $0x8,%esp
80101117:	ff 75 0c             	pushl  0xc(%ebp)
8010111a:	50                   	push   %eax
8010111b:	e8 c3 0c 00 00       	call   80101de3 <stati>
80101120:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
80101123:	8b 45 08             	mov    0x8(%ebp),%eax
80101126:	8b 40 10             	mov    0x10(%eax),%eax
80101129:	83 ec 0c             	sub    $0xc,%esp
8010112c:	50                   	push   %eax
8010112d:	e8 eb 08 00 00       	call   80101a1d <iunlock>
80101132:	83 c4 10             	add    $0x10,%esp
    return 0;
80101135:	b8 00 00 00 00       	mov    $0x0,%eax
8010113a:	eb 05                	jmp    80101141 <filestat+0x55>
  }
  return -1;
8010113c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101141:	c9                   	leave  
80101142:	c3                   	ret    

80101143 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101143:	55                   	push   %ebp
80101144:	89 e5                	mov    %esp,%ebp
80101146:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
80101149:	8b 45 08             	mov    0x8(%ebp),%eax
8010114c:	0f b6 40 08          	movzbl 0x8(%eax),%eax
80101150:	84 c0                	test   %al,%al
80101152:	75 0a                	jne    8010115e <fileread+0x1b>
    return -1;
80101154:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101159:	e9 9b 00 00 00       	jmp    801011f9 <fileread+0xb6>
  if(f->type == FD_PIPE)
8010115e:	8b 45 08             	mov    0x8(%ebp),%eax
80101161:	8b 00                	mov    (%eax),%eax
80101163:	83 f8 01             	cmp    $0x1,%eax
80101166:	75 1a                	jne    80101182 <fileread+0x3f>
    return piperead(f->pipe, addr, n);
80101168:	8b 45 08             	mov    0x8(%ebp),%eax
8010116b:	8b 40 0c             	mov    0xc(%eax),%eax
8010116e:	83 ec 04             	sub    $0x4,%esp
80101171:	ff 75 10             	pushl  0x10(%ebp)
80101174:	ff 75 0c             	pushl  0xc(%ebp)
80101177:	50                   	push   %eax
80101178:	e8 69 2d 00 00       	call   80103ee6 <piperead>
8010117d:	83 c4 10             	add    $0x10,%esp
80101180:	eb 77                	jmp    801011f9 <fileread+0xb6>
  if(f->type == FD_INODE){
80101182:	8b 45 08             	mov    0x8(%ebp),%eax
80101185:	8b 00                	mov    (%eax),%eax
80101187:	83 f8 02             	cmp    $0x2,%eax
8010118a:	75 60                	jne    801011ec <fileread+0xa9>
    ilock(f->ip);
8010118c:	8b 45 08             	mov    0x8(%ebp),%eax
8010118f:	8b 40 10             	mov    0x10(%eax),%eax
80101192:	83 ec 0c             	sub    $0xc,%esp
80101195:	50                   	push   %eax
80101196:	e8 2b 07 00 00       	call   801018c6 <ilock>
8010119b:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010119e:	8b 4d 10             	mov    0x10(%ebp),%ecx
801011a1:	8b 45 08             	mov    0x8(%ebp),%eax
801011a4:	8b 50 14             	mov    0x14(%eax),%edx
801011a7:	8b 45 08             	mov    0x8(%ebp),%eax
801011aa:	8b 40 10             	mov    0x10(%eax),%eax
801011ad:	51                   	push   %ecx
801011ae:	52                   	push   %edx
801011af:	ff 75 0c             	pushl  0xc(%ebp)
801011b2:	50                   	push   %eax
801011b3:	e8 70 0c 00 00       	call   80101e28 <readi>
801011b8:	83 c4 10             	add    $0x10,%esp
801011bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
801011be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801011c2:	7e 11                	jle    801011d5 <fileread+0x92>
      f->off += r;
801011c4:	8b 45 08             	mov    0x8(%ebp),%eax
801011c7:	8b 50 14             	mov    0x14(%eax),%edx
801011ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011cd:	01 c2                	add    %eax,%edx
801011cf:	8b 45 08             	mov    0x8(%ebp),%eax
801011d2:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
801011d5:	8b 45 08             	mov    0x8(%ebp),%eax
801011d8:	8b 40 10             	mov    0x10(%eax),%eax
801011db:	83 ec 0c             	sub    $0xc,%esp
801011de:	50                   	push   %eax
801011df:	e8 39 08 00 00       	call   80101a1d <iunlock>
801011e4:	83 c4 10             	add    $0x10,%esp
    return r;
801011e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011ea:	eb 0d                	jmp    801011f9 <fileread+0xb6>
  }
  panic("fileread");
801011ec:	83 ec 0c             	sub    $0xc,%esp
801011ef:	68 d6 82 10 80       	push   $0x801082d6
801011f4:	e8 63 f3 ff ff       	call   8010055c <panic>
}
801011f9:	c9                   	leave  
801011fa:	c3                   	ret    

801011fb <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011fb:	55                   	push   %ebp
801011fc:	89 e5                	mov    %esp,%ebp
801011fe:	53                   	push   %ebx
801011ff:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
80101202:	8b 45 08             	mov    0x8(%ebp),%eax
80101205:	0f b6 40 09          	movzbl 0x9(%eax),%eax
80101209:	84 c0                	test   %al,%al
8010120b:	75 0a                	jne    80101217 <filewrite+0x1c>
    return -1;
8010120d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101212:	e9 1a 01 00 00       	jmp    80101331 <filewrite+0x136>
  if(f->type == FD_PIPE)
80101217:	8b 45 08             	mov    0x8(%ebp),%eax
8010121a:	8b 00                	mov    (%eax),%eax
8010121c:	83 f8 01             	cmp    $0x1,%eax
8010121f:	75 1d                	jne    8010123e <filewrite+0x43>
    return pipewrite(f->pipe, addr, n);
80101221:	8b 45 08             	mov    0x8(%ebp),%eax
80101224:	8b 40 0c             	mov    0xc(%eax),%eax
80101227:	83 ec 04             	sub    $0x4,%esp
8010122a:	ff 75 10             	pushl  0x10(%ebp)
8010122d:	ff 75 0c             	pushl  0xc(%ebp)
80101230:	50                   	push   %eax
80101231:	e8 ac 2b 00 00       	call   80103de2 <pipewrite>
80101236:	83 c4 10             	add    $0x10,%esp
80101239:	e9 f3 00 00 00       	jmp    80101331 <filewrite+0x136>
  if(f->type == FD_INODE){
8010123e:	8b 45 08             	mov    0x8(%ebp),%eax
80101241:	8b 00                	mov    (%eax),%eax
80101243:	83 f8 02             	cmp    $0x2,%eax
80101246:	0f 85 d8 00 00 00    	jne    80101324 <filewrite+0x129>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
8010124c:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
80101253:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
8010125a:	e9 a5 00 00 00       	jmp    80101304 <filewrite+0x109>
      int n1 = n - i;
8010125f:	8b 45 10             	mov    0x10(%ebp),%eax
80101262:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101265:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
80101268:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010126b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010126e:	7e 06                	jle    80101276 <filewrite+0x7b>
        n1 = max;
80101270:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101273:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_trans();
80101276:	e8 bf 1f 00 00       	call   8010323a <begin_trans>
      ilock(f->ip);
8010127b:	8b 45 08             	mov    0x8(%ebp),%eax
8010127e:	8b 40 10             	mov    0x10(%eax),%eax
80101281:	83 ec 0c             	sub    $0xc,%esp
80101284:	50                   	push   %eax
80101285:	e8 3c 06 00 00       	call   801018c6 <ilock>
8010128a:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010128d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80101290:	8b 45 08             	mov    0x8(%ebp),%eax
80101293:	8b 50 14             	mov    0x14(%eax),%edx
80101296:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101299:	8b 45 0c             	mov    0xc(%ebp),%eax
8010129c:	01 c3                	add    %eax,%ebx
8010129e:	8b 45 08             	mov    0x8(%ebp),%eax
801012a1:	8b 40 10             	mov    0x10(%eax),%eax
801012a4:	51                   	push   %ecx
801012a5:	52                   	push   %edx
801012a6:	53                   	push   %ebx
801012a7:	50                   	push   %eax
801012a8:	e8 dc 0c 00 00       	call   80101f89 <writei>
801012ad:	83 c4 10             	add    $0x10,%esp
801012b0:	89 45 e8             	mov    %eax,-0x18(%ebp)
801012b3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801012b7:	7e 11                	jle    801012ca <filewrite+0xcf>
        f->off += r;
801012b9:	8b 45 08             	mov    0x8(%ebp),%eax
801012bc:	8b 50 14             	mov    0x14(%eax),%edx
801012bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012c2:	01 c2                	add    %eax,%edx
801012c4:	8b 45 08             	mov    0x8(%ebp),%eax
801012c7:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
801012ca:	8b 45 08             	mov    0x8(%ebp),%eax
801012cd:	8b 40 10             	mov    0x10(%eax),%eax
801012d0:	83 ec 0c             	sub    $0xc,%esp
801012d3:	50                   	push   %eax
801012d4:	e8 44 07 00 00       	call   80101a1d <iunlock>
801012d9:	83 c4 10             	add    $0x10,%esp
      commit_trans();
801012dc:	e8 ab 1f 00 00       	call   8010328c <commit_trans>

      if(r < 0)
801012e1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801012e5:	79 02                	jns    801012e9 <filewrite+0xee>
        break;
801012e7:	eb 27                	jmp    80101310 <filewrite+0x115>
      if(r != n1)
801012e9:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012ec:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801012ef:	74 0d                	je     801012fe <filewrite+0x103>
        panic("short filewrite");
801012f1:	83 ec 0c             	sub    $0xc,%esp
801012f4:	68 df 82 10 80       	push   $0x801082df
801012f9:	e8 5e f2 ff ff       	call   8010055c <panic>
      i += r;
801012fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101301:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101304:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101307:	3b 45 10             	cmp    0x10(%ebp),%eax
8010130a:	0f 8c 4f ff ff ff    	jl     8010125f <filewrite+0x64>
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101310:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101313:	3b 45 10             	cmp    0x10(%ebp),%eax
80101316:	75 05                	jne    8010131d <filewrite+0x122>
80101318:	8b 45 10             	mov    0x10(%ebp),%eax
8010131b:	eb 14                	jmp    80101331 <filewrite+0x136>
8010131d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101322:	eb 0d                	jmp    80101331 <filewrite+0x136>
  }
  panic("filewrite");
80101324:	83 ec 0c             	sub    $0xc,%esp
80101327:	68 ef 82 10 80       	push   $0x801082ef
8010132c:	e8 2b f2 ff ff       	call   8010055c <panic>
}
80101331:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101334:	c9                   	leave  
80101335:	c3                   	ret    

80101336 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101336:	55                   	push   %ebp
80101337:	89 e5                	mov    %esp,%ebp
80101339:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
8010133c:	8b 45 08             	mov    0x8(%ebp),%eax
8010133f:	83 ec 08             	sub    $0x8,%esp
80101342:	6a 01                	push   $0x1
80101344:	50                   	push   %eax
80101345:	e8 6a ee ff ff       	call   801001b4 <bread>
8010134a:	83 c4 10             	add    $0x10,%esp
8010134d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
80101350:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101353:	83 c0 18             	add    $0x18,%eax
80101356:	83 ec 04             	sub    $0x4,%esp
80101359:	6a 10                	push   $0x10
8010135b:	50                   	push   %eax
8010135c:	ff 75 0c             	pushl  0xc(%ebp)
8010135f:	e8 21 3b 00 00       	call   80104e85 <memmove>
80101364:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101367:	83 ec 0c             	sub    $0xc,%esp
8010136a:	ff 75 f4             	pushl  -0xc(%ebp)
8010136d:	e8 b9 ee ff ff       	call   8010022b <brelse>
80101372:	83 c4 10             	add    $0x10,%esp
}
80101375:	c9                   	leave  
80101376:	c3                   	ret    

80101377 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
80101377:	55                   	push   %ebp
80101378:	89 e5                	mov    %esp,%ebp
8010137a:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
8010137d:	8b 55 0c             	mov    0xc(%ebp),%edx
80101380:	8b 45 08             	mov    0x8(%ebp),%eax
80101383:	83 ec 08             	sub    $0x8,%esp
80101386:	52                   	push   %edx
80101387:	50                   	push   %eax
80101388:	e8 27 ee ff ff       	call   801001b4 <bread>
8010138d:	83 c4 10             	add    $0x10,%esp
80101390:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
80101393:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101396:	83 c0 18             	add    $0x18,%eax
80101399:	83 ec 04             	sub    $0x4,%esp
8010139c:	68 00 02 00 00       	push   $0x200
801013a1:	6a 00                	push   $0x0
801013a3:	50                   	push   %eax
801013a4:	e8 1d 3a 00 00       	call   80104dc6 <memset>
801013a9:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801013ac:	83 ec 0c             	sub    $0xc,%esp
801013af:	ff 75 f4             	pushl  -0xc(%ebp)
801013b2:	e8 39 1f 00 00       	call   801032f0 <log_write>
801013b7:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801013ba:	83 ec 0c             	sub    $0xc,%esp
801013bd:	ff 75 f4             	pushl  -0xc(%ebp)
801013c0:	e8 66 ee ff ff       	call   8010022b <brelse>
801013c5:	83 c4 10             	add    $0x10,%esp
}
801013c8:	c9                   	leave  
801013c9:	c3                   	ret    

801013ca <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801013ca:	55                   	push   %ebp
801013cb:	89 e5                	mov    %esp,%ebp
801013cd:	83 ec 28             	sub    $0x28,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
801013d0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  readsb(dev, &sb);
801013d7:	8b 45 08             	mov    0x8(%ebp),%eax
801013da:	83 ec 08             	sub    $0x8,%esp
801013dd:	8d 55 d8             	lea    -0x28(%ebp),%edx
801013e0:	52                   	push   %edx
801013e1:	50                   	push   %eax
801013e2:	e8 4f ff ff ff       	call   80101336 <readsb>
801013e7:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
801013ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801013f1:	e9 0c 01 00 00       	jmp    80101502 <balloc+0x138>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
801013f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013f9:	99                   	cltd   
801013fa:	c1 ea 14             	shr    $0x14,%edx
801013fd:	01 d0                	add    %edx,%eax
801013ff:	c1 f8 0c             	sar    $0xc,%eax
80101402:	89 c2                	mov    %eax,%edx
80101404:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101407:	c1 e8 03             	shr    $0x3,%eax
8010140a:	01 d0                	add    %edx,%eax
8010140c:	83 c0 03             	add    $0x3,%eax
8010140f:	83 ec 08             	sub    $0x8,%esp
80101412:	50                   	push   %eax
80101413:	ff 75 08             	pushl  0x8(%ebp)
80101416:	e8 99 ed ff ff       	call   801001b4 <bread>
8010141b:	83 c4 10             	add    $0x10,%esp
8010141e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101421:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101428:	e9 a2 00 00 00       	jmp    801014cf <balloc+0x105>
      m = 1 << (bi % 8);
8010142d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101430:	99                   	cltd   
80101431:	c1 ea 1d             	shr    $0x1d,%edx
80101434:	01 d0                	add    %edx,%eax
80101436:	83 e0 07             	and    $0x7,%eax
80101439:	29 d0                	sub    %edx,%eax
8010143b:	ba 01 00 00 00       	mov    $0x1,%edx
80101440:	89 c1                	mov    %eax,%ecx
80101442:	d3 e2                	shl    %cl,%edx
80101444:	89 d0                	mov    %edx,%eax
80101446:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101449:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010144c:	99                   	cltd   
8010144d:	c1 ea 1d             	shr    $0x1d,%edx
80101450:	01 d0                	add    %edx,%eax
80101452:	c1 f8 03             	sar    $0x3,%eax
80101455:	89 c2                	mov    %eax,%edx
80101457:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010145a:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
8010145f:	0f b6 c0             	movzbl %al,%eax
80101462:	23 45 e8             	and    -0x18(%ebp),%eax
80101465:	85 c0                	test   %eax,%eax
80101467:	75 62                	jne    801014cb <balloc+0x101>
        bp->data[bi/8] |= m;  // Mark block in use.
80101469:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010146c:	99                   	cltd   
8010146d:	c1 ea 1d             	shr    $0x1d,%edx
80101470:	01 d0                	add    %edx,%eax
80101472:	c1 f8 03             	sar    $0x3,%eax
80101475:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101478:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
8010147d:	89 d1                	mov    %edx,%ecx
8010147f:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101482:	09 ca                	or     %ecx,%edx
80101484:	89 d1                	mov    %edx,%ecx
80101486:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101489:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
8010148d:	83 ec 0c             	sub    $0xc,%esp
80101490:	ff 75 ec             	pushl  -0x14(%ebp)
80101493:	e8 58 1e 00 00       	call   801032f0 <log_write>
80101498:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
8010149b:	83 ec 0c             	sub    $0xc,%esp
8010149e:	ff 75 ec             	pushl  -0x14(%ebp)
801014a1:	e8 85 ed ff ff       	call   8010022b <brelse>
801014a6:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
801014a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014af:	01 c2                	add    %eax,%edx
801014b1:	8b 45 08             	mov    0x8(%ebp),%eax
801014b4:	83 ec 08             	sub    $0x8,%esp
801014b7:	52                   	push   %edx
801014b8:	50                   	push   %eax
801014b9:	e8 b9 fe ff ff       	call   80101377 <bzero>
801014be:	83 c4 10             	add    $0x10,%esp
        return b + bi;
801014c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014c7:	01 d0                	add    %edx,%eax
801014c9:	eb 52                	jmp    8010151d <balloc+0x153>

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014cb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801014cf:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
801014d6:	7f 15                	jg     801014ed <balloc+0x123>
801014d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014db:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014de:	01 d0                	add    %edx,%eax
801014e0:	89 c2                	mov    %eax,%edx
801014e2:	8b 45 d8             	mov    -0x28(%ebp),%eax
801014e5:	39 c2                	cmp    %eax,%edx
801014e7:	0f 82 40 ff ff ff    	jb     8010142d <balloc+0x63>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801014ed:	83 ec 0c             	sub    $0xc,%esp
801014f0:	ff 75 ec             	pushl  -0x14(%ebp)
801014f3:	e8 33 ed ff ff       	call   8010022b <brelse>
801014f8:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
801014fb:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80101502:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101505:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101508:	39 c2                	cmp    %eax,%edx
8010150a:	0f 82 e6 fe ff ff    	jb     801013f6 <balloc+0x2c>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101510:	83 ec 0c             	sub    $0xc,%esp
80101513:	68 f9 82 10 80       	push   $0x801082f9
80101518:	e8 3f f0 ff ff       	call   8010055c <panic>
}
8010151d:	c9                   	leave  
8010151e:	c3                   	ret    

8010151f <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
8010151f:	55                   	push   %ebp
80101520:	89 e5                	mov    %esp,%ebp
80101522:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  readsb(dev, &sb);
80101525:	83 ec 08             	sub    $0x8,%esp
80101528:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010152b:	50                   	push   %eax
8010152c:	ff 75 08             	pushl  0x8(%ebp)
8010152f:	e8 02 fe ff ff       	call   80101336 <readsb>
80101534:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb.ninodes));
80101537:	8b 45 0c             	mov    0xc(%ebp),%eax
8010153a:	c1 e8 0c             	shr    $0xc,%eax
8010153d:	89 c2                	mov    %eax,%edx
8010153f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101542:	c1 e8 03             	shr    $0x3,%eax
80101545:	01 d0                	add    %edx,%eax
80101547:	8d 50 03             	lea    0x3(%eax),%edx
8010154a:	8b 45 08             	mov    0x8(%ebp),%eax
8010154d:	83 ec 08             	sub    $0x8,%esp
80101550:	52                   	push   %edx
80101551:	50                   	push   %eax
80101552:	e8 5d ec ff ff       	call   801001b4 <bread>
80101557:	83 c4 10             	add    $0x10,%esp
8010155a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
8010155d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101560:	25 ff 0f 00 00       	and    $0xfff,%eax
80101565:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80101568:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010156b:	99                   	cltd   
8010156c:	c1 ea 1d             	shr    $0x1d,%edx
8010156f:	01 d0                	add    %edx,%eax
80101571:	83 e0 07             	and    $0x7,%eax
80101574:	29 d0                	sub    %edx,%eax
80101576:	ba 01 00 00 00       	mov    $0x1,%edx
8010157b:	89 c1                	mov    %eax,%ecx
8010157d:	d3 e2                	shl    %cl,%edx
8010157f:	89 d0                	mov    %edx,%eax
80101581:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
80101584:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101587:	99                   	cltd   
80101588:	c1 ea 1d             	shr    $0x1d,%edx
8010158b:	01 d0                	add    %edx,%eax
8010158d:	c1 f8 03             	sar    $0x3,%eax
80101590:	89 c2                	mov    %eax,%edx
80101592:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101595:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
8010159a:	0f b6 c0             	movzbl %al,%eax
8010159d:	23 45 ec             	and    -0x14(%ebp),%eax
801015a0:	85 c0                	test   %eax,%eax
801015a2:	75 0d                	jne    801015b1 <bfree+0x92>
    panic("freeing free block");
801015a4:	83 ec 0c             	sub    $0xc,%esp
801015a7:	68 0f 83 10 80       	push   $0x8010830f
801015ac:	e8 ab ef ff ff       	call   8010055c <panic>
  bp->data[bi/8] &= ~m;
801015b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015b4:	99                   	cltd   
801015b5:	c1 ea 1d             	shr    $0x1d,%edx
801015b8:	01 d0                	add    %edx,%eax
801015ba:	c1 f8 03             	sar    $0x3,%eax
801015bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015c0:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801015c5:	89 d1                	mov    %edx,%ecx
801015c7:	8b 55 ec             	mov    -0x14(%ebp),%edx
801015ca:	f7 d2                	not    %edx
801015cc:	21 ca                	and    %ecx,%edx
801015ce:	89 d1                	mov    %edx,%ecx
801015d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015d3:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
801015d7:	83 ec 0c             	sub    $0xc,%esp
801015da:	ff 75 f4             	pushl  -0xc(%ebp)
801015dd:	e8 0e 1d 00 00       	call   801032f0 <log_write>
801015e2:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801015e5:	83 ec 0c             	sub    $0xc,%esp
801015e8:	ff 75 f4             	pushl  -0xc(%ebp)
801015eb:	e8 3b ec ff ff       	call   8010022b <brelse>
801015f0:	83 c4 10             	add    $0x10,%esp
}
801015f3:	c9                   	leave  
801015f4:	c3                   	ret    

801015f5 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
801015f5:	55                   	push   %ebp
801015f6:	89 e5                	mov    %esp,%ebp
801015f8:	83 ec 08             	sub    $0x8,%esp
  initlock(&icache.lock, "icache");
801015fb:	83 ec 08             	sub    $0x8,%esp
801015fe:	68 22 83 10 80       	push   $0x80108322
80101603:	68 c0 e8 10 80       	push   $0x8010e8c0
80101608:	e8 3c 35 00 00       	call   80104b49 <initlock>
8010160d:	83 c4 10             	add    $0x10,%esp
}
80101610:	c9                   	leave  
80101611:	c3                   	ret    

80101612 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101612:	55                   	push   %ebp
80101613:	89 e5                	mov    %esp,%ebp
80101615:	83 ec 38             	sub    $0x38,%esp
80101618:	8b 45 0c             	mov    0xc(%ebp),%eax
8010161b:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
8010161f:	8b 45 08             	mov    0x8(%ebp),%eax
80101622:	83 ec 08             	sub    $0x8,%esp
80101625:	8d 55 dc             	lea    -0x24(%ebp),%edx
80101628:	52                   	push   %edx
80101629:	50                   	push   %eax
8010162a:	e8 07 fd ff ff       	call   80101336 <readsb>
8010162f:	83 c4 10             	add    $0x10,%esp

  for(inum = 1; inum < sb.ninodes; inum++){
80101632:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80101639:	e9 98 00 00 00       	jmp    801016d6 <ialloc+0xc4>
    bp = bread(dev, IBLOCK(inum));
8010163e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101641:	c1 e8 03             	shr    $0x3,%eax
80101644:	83 c0 02             	add    $0x2,%eax
80101647:	83 ec 08             	sub    $0x8,%esp
8010164a:	50                   	push   %eax
8010164b:	ff 75 08             	pushl  0x8(%ebp)
8010164e:	e8 61 eb ff ff       	call   801001b4 <bread>
80101653:	83 c4 10             	add    $0x10,%esp
80101656:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
80101659:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010165c:	8d 50 18             	lea    0x18(%eax),%edx
8010165f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101662:	83 e0 07             	and    $0x7,%eax
80101665:	c1 e0 06             	shl    $0x6,%eax
80101668:	01 d0                	add    %edx,%eax
8010166a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
8010166d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101670:	0f b7 00             	movzwl (%eax),%eax
80101673:	66 85 c0             	test   %ax,%ax
80101676:	75 4c                	jne    801016c4 <ialloc+0xb2>
      memset(dip, 0, sizeof(*dip));
80101678:	83 ec 04             	sub    $0x4,%esp
8010167b:	6a 40                	push   $0x40
8010167d:	6a 00                	push   $0x0
8010167f:	ff 75 ec             	pushl  -0x14(%ebp)
80101682:	e8 3f 37 00 00       	call   80104dc6 <memset>
80101687:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
8010168a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010168d:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
80101691:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
80101694:	83 ec 0c             	sub    $0xc,%esp
80101697:	ff 75 f0             	pushl  -0x10(%ebp)
8010169a:	e8 51 1c 00 00       	call   801032f0 <log_write>
8010169f:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
801016a2:	83 ec 0c             	sub    $0xc,%esp
801016a5:	ff 75 f0             	pushl  -0x10(%ebp)
801016a8:	e8 7e eb ff ff       	call   8010022b <brelse>
801016ad:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
801016b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016b3:	83 ec 08             	sub    $0x8,%esp
801016b6:	50                   	push   %eax
801016b7:	ff 75 08             	pushl  0x8(%ebp)
801016ba:	e8 ee 00 00 00       	call   801017ad <iget>
801016bf:	83 c4 10             	add    $0x10,%esp
801016c2:	eb 2d                	jmp    801016f1 <ialloc+0xdf>
    }
    brelse(bp);
801016c4:	83 ec 0c             	sub    $0xc,%esp
801016c7:	ff 75 f0             	pushl  -0x10(%ebp)
801016ca:	e8 5c eb ff ff       	call   8010022b <brelse>
801016cf:	83 c4 10             	add    $0x10,%esp
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
801016d2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801016d6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801016d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801016dc:	39 c2                	cmp    %eax,%edx
801016de:	0f 82 5a ff ff ff    	jb     8010163e <ialloc+0x2c>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801016e4:	83 ec 0c             	sub    $0xc,%esp
801016e7:	68 29 83 10 80       	push   $0x80108329
801016ec:	e8 6b ee ff ff       	call   8010055c <panic>
}
801016f1:	c9                   	leave  
801016f2:	c3                   	ret    

801016f3 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
801016f3:	55                   	push   %ebp
801016f4:	89 e5                	mov    %esp,%ebp
801016f6:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
801016f9:	8b 45 08             	mov    0x8(%ebp),%eax
801016fc:	8b 40 04             	mov    0x4(%eax),%eax
801016ff:	c1 e8 03             	shr    $0x3,%eax
80101702:	8d 50 02             	lea    0x2(%eax),%edx
80101705:	8b 45 08             	mov    0x8(%ebp),%eax
80101708:	8b 00                	mov    (%eax),%eax
8010170a:	83 ec 08             	sub    $0x8,%esp
8010170d:	52                   	push   %edx
8010170e:	50                   	push   %eax
8010170f:	e8 a0 ea ff ff       	call   801001b4 <bread>
80101714:	83 c4 10             	add    $0x10,%esp
80101717:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010171a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010171d:	8d 50 18             	lea    0x18(%eax),%edx
80101720:	8b 45 08             	mov    0x8(%ebp),%eax
80101723:	8b 40 04             	mov    0x4(%eax),%eax
80101726:	83 e0 07             	and    $0x7,%eax
80101729:	c1 e0 06             	shl    $0x6,%eax
8010172c:	01 d0                	add    %edx,%eax
8010172e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
80101731:	8b 45 08             	mov    0x8(%ebp),%eax
80101734:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101738:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010173b:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010173e:	8b 45 08             	mov    0x8(%ebp),%eax
80101741:	0f b7 50 12          	movzwl 0x12(%eax),%edx
80101745:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101748:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
8010174c:	8b 45 08             	mov    0x8(%ebp),%eax
8010174f:	0f b7 50 14          	movzwl 0x14(%eax),%edx
80101753:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101756:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
8010175a:	8b 45 08             	mov    0x8(%ebp),%eax
8010175d:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101761:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101764:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101768:	8b 45 08             	mov    0x8(%ebp),%eax
8010176b:	8b 50 18             	mov    0x18(%eax),%edx
8010176e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101771:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101774:	8b 45 08             	mov    0x8(%ebp),%eax
80101777:	8d 50 1c             	lea    0x1c(%eax),%edx
8010177a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010177d:	83 c0 0c             	add    $0xc,%eax
80101780:	83 ec 04             	sub    $0x4,%esp
80101783:	6a 34                	push   $0x34
80101785:	52                   	push   %edx
80101786:	50                   	push   %eax
80101787:	e8 f9 36 00 00       	call   80104e85 <memmove>
8010178c:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
8010178f:	83 ec 0c             	sub    $0xc,%esp
80101792:	ff 75 f4             	pushl  -0xc(%ebp)
80101795:	e8 56 1b 00 00       	call   801032f0 <log_write>
8010179a:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
8010179d:	83 ec 0c             	sub    $0xc,%esp
801017a0:	ff 75 f4             	pushl  -0xc(%ebp)
801017a3:	e8 83 ea ff ff       	call   8010022b <brelse>
801017a8:	83 c4 10             	add    $0x10,%esp
}
801017ab:	c9                   	leave  
801017ac:	c3                   	ret    

801017ad <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801017ad:	55                   	push   %ebp
801017ae:	89 e5                	mov    %esp,%ebp
801017b0:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
801017b3:	83 ec 0c             	sub    $0xc,%esp
801017b6:	68 c0 e8 10 80       	push   $0x8010e8c0
801017bb:	e8 aa 33 00 00       	call   80104b6a <acquire>
801017c0:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
801017c3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801017ca:	c7 45 f4 f4 e8 10 80 	movl   $0x8010e8f4,-0xc(%ebp)
801017d1:	eb 5d                	jmp    80101830 <iget+0x83>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801017d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017d6:	8b 40 08             	mov    0x8(%eax),%eax
801017d9:	85 c0                	test   %eax,%eax
801017db:	7e 39                	jle    80101816 <iget+0x69>
801017dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017e0:	8b 00                	mov    (%eax),%eax
801017e2:	3b 45 08             	cmp    0x8(%ebp),%eax
801017e5:	75 2f                	jne    80101816 <iget+0x69>
801017e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017ea:	8b 40 04             	mov    0x4(%eax),%eax
801017ed:	3b 45 0c             	cmp    0xc(%ebp),%eax
801017f0:	75 24                	jne    80101816 <iget+0x69>
      ip->ref++;
801017f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017f5:	8b 40 08             	mov    0x8(%eax),%eax
801017f8:	8d 50 01             	lea    0x1(%eax),%edx
801017fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017fe:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101801:	83 ec 0c             	sub    $0xc,%esp
80101804:	68 c0 e8 10 80       	push   $0x8010e8c0
80101809:	e8 c2 33 00 00       	call   80104bd0 <release>
8010180e:	83 c4 10             	add    $0x10,%esp
      return ip;
80101811:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101814:	eb 74                	jmp    8010188a <iget+0xdd>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101816:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010181a:	75 10                	jne    8010182c <iget+0x7f>
8010181c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010181f:	8b 40 08             	mov    0x8(%eax),%eax
80101822:	85 c0                	test   %eax,%eax
80101824:	75 06                	jne    8010182c <iget+0x7f>
      empty = ip;
80101826:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101829:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010182c:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
80101830:	81 7d f4 94 f8 10 80 	cmpl   $0x8010f894,-0xc(%ebp)
80101837:	72 9a                	jb     801017d3 <iget+0x26>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101839:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010183d:	75 0d                	jne    8010184c <iget+0x9f>
    panic("iget: no inodes");
8010183f:	83 ec 0c             	sub    $0xc,%esp
80101842:	68 3b 83 10 80       	push   $0x8010833b
80101847:	e8 10 ed ff ff       	call   8010055c <panic>

  ip = empty;
8010184c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010184f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
80101852:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101855:	8b 55 08             	mov    0x8(%ebp),%edx
80101858:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
8010185a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010185d:	8b 55 0c             	mov    0xc(%ebp),%edx
80101860:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
80101863:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101866:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
8010186d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101870:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
80101877:	83 ec 0c             	sub    $0xc,%esp
8010187a:	68 c0 e8 10 80       	push   $0x8010e8c0
8010187f:	e8 4c 33 00 00       	call   80104bd0 <release>
80101884:	83 c4 10             	add    $0x10,%esp

  return ip;
80101887:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010188a:	c9                   	leave  
8010188b:	c3                   	ret    

8010188c <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
8010188c:	55                   	push   %ebp
8010188d:	89 e5                	mov    %esp,%ebp
8010188f:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101892:	83 ec 0c             	sub    $0xc,%esp
80101895:	68 c0 e8 10 80       	push   $0x8010e8c0
8010189a:	e8 cb 32 00 00       	call   80104b6a <acquire>
8010189f:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
801018a2:	8b 45 08             	mov    0x8(%ebp),%eax
801018a5:	8b 40 08             	mov    0x8(%eax),%eax
801018a8:	8d 50 01             	lea    0x1(%eax),%edx
801018ab:	8b 45 08             	mov    0x8(%ebp),%eax
801018ae:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
801018b1:	83 ec 0c             	sub    $0xc,%esp
801018b4:	68 c0 e8 10 80       	push   $0x8010e8c0
801018b9:	e8 12 33 00 00       	call   80104bd0 <release>
801018be:	83 c4 10             	add    $0x10,%esp
  return ip;
801018c1:	8b 45 08             	mov    0x8(%ebp),%eax
}
801018c4:	c9                   	leave  
801018c5:	c3                   	ret    

801018c6 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
801018c6:	55                   	push   %ebp
801018c7:	89 e5                	mov    %esp,%ebp
801018c9:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
801018cc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801018d0:	74 0a                	je     801018dc <ilock+0x16>
801018d2:	8b 45 08             	mov    0x8(%ebp),%eax
801018d5:	8b 40 08             	mov    0x8(%eax),%eax
801018d8:	85 c0                	test   %eax,%eax
801018da:	7f 0d                	jg     801018e9 <ilock+0x23>
    panic("ilock");
801018dc:	83 ec 0c             	sub    $0xc,%esp
801018df:	68 4b 83 10 80       	push   $0x8010834b
801018e4:	e8 73 ec ff ff       	call   8010055c <panic>

  acquire(&icache.lock);
801018e9:	83 ec 0c             	sub    $0xc,%esp
801018ec:	68 c0 e8 10 80       	push   $0x8010e8c0
801018f1:	e8 74 32 00 00       	call   80104b6a <acquire>
801018f6:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
801018f9:	eb 13                	jmp    8010190e <ilock+0x48>
    sleep(ip, &icache.lock);
801018fb:	83 ec 08             	sub    $0x8,%esp
801018fe:	68 c0 e8 10 80       	push   $0x8010e8c0
80101903:	ff 75 08             	pushl  0x8(%ebp)
80101906:	e8 5d 2f 00 00       	call   80104868 <sleep>
8010190b:	83 c4 10             	add    $0x10,%esp

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
8010190e:	8b 45 08             	mov    0x8(%ebp),%eax
80101911:	8b 40 0c             	mov    0xc(%eax),%eax
80101914:	83 e0 01             	and    $0x1,%eax
80101917:	85 c0                	test   %eax,%eax
80101919:	75 e0                	jne    801018fb <ilock+0x35>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
8010191b:	8b 45 08             	mov    0x8(%ebp),%eax
8010191e:	8b 40 0c             	mov    0xc(%eax),%eax
80101921:	83 c8 01             	or     $0x1,%eax
80101924:	89 c2                	mov    %eax,%edx
80101926:	8b 45 08             	mov    0x8(%ebp),%eax
80101929:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
8010192c:	83 ec 0c             	sub    $0xc,%esp
8010192f:	68 c0 e8 10 80       	push   $0x8010e8c0
80101934:	e8 97 32 00 00       	call   80104bd0 <release>
80101939:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
8010193c:	8b 45 08             	mov    0x8(%ebp),%eax
8010193f:	8b 40 0c             	mov    0xc(%eax),%eax
80101942:	83 e0 02             	and    $0x2,%eax
80101945:	85 c0                	test   %eax,%eax
80101947:	0f 85 ce 00 00 00    	jne    80101a1b <ilock+0x155>
    bp = bread(ip->dev, IBLOCK(ip->inum));
8010194d:	8b 45 08             	mov    0x8(%ebp),%eax
80101950:	8b 40 04             	mov    0x4(%eax),%eax
80101953:	c1 e8 03             	shr    $0x3,%eax
80101956:	8d 50 02             	lea    0x2(%eax),%edx
80101959:	8b 45 08             	mov    0x8(%ebp),%eax
8010195c:	8b 00                	mov    (%eax),%eax
8010195e:	83 ec 08             	sub    $0x8,%esp
80101961:	52                   	push   %edx
80101962:	50                   	push   %eax
80101963:	e8 4c e8 ff ff       	call   801001b4 <bread>
80101968:	83 c4 10             	add    $0x10,%esp
8010196b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010196e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101971:	8d 50 18             	lea    0x18(%eax),%edx
80101974:	8b 45 08             	mov    0x8(%ebp),%eax
80101977:	8b 40 04             	mov    0x4(%eax),%eax
8010197a:	83 e0 07             	and    $0x7,%eax
8010197d:	c1 e0 06             	shl    $0x6,%eax
80101980:	01 d0                	add    %edx,%eax
80101982:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101985:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101988:	0f b7 10             	movzwl (%eax),%edx
8010198b:	8b 45 08             	mov    0x8(%ebp),%eax
8010198e:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
80101992:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101995:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101999:	8b 45 08             	mov    0x8(%ebp),%eax
8010199c:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
801019a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019a3:	0f b7 50 04          	movzwl 0x4(%eax),%edx
801019a7:	8b 45 08             	mov    0x8(%ebp),%eax
801019aa:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
801019ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019b1:	0f b7 50 06          	movzwl 0x6(%eax),%edx
801019b5:	8b 45 08             	mov    0x8(%ebp),%eax
801019b8:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
801019bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019bf:	8b 50 08             	mov    0x8(%eax),%edx
801019c2:	8b 45 08             	mov    0x8(%ebp),%eax
801019c5:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801019c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019cb:	8d 50 0c             	lea    0xc(%eax),%edx
801019ce:	8b 45 08             	mov    0x8(%ebp),%eax
801019d1:	83 c0 1c             	add    $0x1c,%eax
801019d4:	83 ec 04             	sub    $0x4,%esp
801019d7:	6a 34                	push   $0x34
801019d9:	52                   	push   %edx
801019da:	50                   	push   %eax
801019db:	e8 a5 34 00 00       	call   80104e85 <memmove>
801019e0:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801019e3:	83 ec 0c             	sub    $0xc,%esp
801019e6:	ff 75 f4             	pushl  -0xc(%ebp)
801019e9:	e8 3d e8 ff ff       	call   8010022b <brelse>
801019ee:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
801019f1:	8b 45 08             	mov    0x8(%ebp),%eax
801019f4:	8b 40 0c             	mov    0xc(%eax),%eax
801019f7:	83 c8 02             	or     $0x2,%eax
801019fa:	89 c2                	mov    %eax,%edx
801019fc:	8b 45 08             	mov    0x8(%ebp),%eax
801019ff:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80101a02:	8b 45 08             	mov    0x8(%ebp),%eax
80101a05:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101a09:	66 85 c0             	test   %ax,%ax
80101a0c:	75 0d                	jne    80101a1b <ilock+0x155>
      panic("ilock: no type");
80101a0e:	83 ec 0c             	sub    $0xc,%esp
80101a11:	68 51 83 10 80       	push   $0x80108351
80101a16:	e8 41 eb ff ff       	call   8010055c <panic>
  }
}
80101a1b:	c9                   	leave  
80101a1c:	c3                   	ret    

80101a1d <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101a1d:	55                   	push   %ebp
80101a1e:	89 e5                	mov    %esp,%ebp
80101a20:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80101a23:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101a27:	74 17                	je     80101a40 <iunlock+0x23>
80101a29:	8b 45 08             	mov    0x8(%ebp),%eax
80101a2c:	8b 40 0c             	mov    0xc(%eax),%eax
80101a2f:	83 e0 01             	and    $0x1,%eax
80101a32:	85 c0                	test   %eax,%eax
80101a34:	74 0a                	je     80101a40 <iunlock+0x23>
80101a36:	8b 45 08             	mov    0x8(%ebp),%eax
80101a39:	8b 40 08             	mov    0x8(%eax),%eax
80101a3c:	85 c0                	test   %eax,%eax
80101a3e:	7f 0d                	jg     80101a4d <iunlock+0x30>
    panic("iunlock");
80101a40:	83 ec 0c             	sub    $0xc,%esp
80101a43:	68 60 83 10 80       	push   $0x80108360
80101a48:	e8 0f eb ff ff       	call   8010055c <panic>

  acquire(&icache.lock);
80101a4d:	83 ec 0c             	sub    $0xc,%esp
80101a50:	68 c0 e8 10 80       	push   $0x8010e8c0
80101a55:	e8 10 31 00 00       	call   80104b6a <acquire>
80101a5a:	83 c4 10             	add    $0x10,%esp
  ip->flags &= ~I_BUSY;
80101a5d:	8b 45 08             	mov    0x8(%ebp),%eax
80101a60:	8b 40 0c             	mov    0xc(%eax),%eax
80101a63:	83 e0 fe             	and    $0xfffffffe,%eax
80101a66:	89 c2                	mov    %eax,%edx
80101a68:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6b:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101a6e:	83 ec 0c             	sub    $0xc,%esp
80101a71:	ff 75 08             	pushl  0x8(%ebp)
80101a74:	e8 d8 2e 00 00       	call   80104951 <wakeup>
80101a79:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80101a7c:	83 ec 0c             	sub    $0xc,%esp
80101a7f:	68 c0 e8 10 80       	push   $0x8010e8c0
80101a84:	e8 47 31 00 00       	call   80104bd0 <release>
80101a89:	83 c4 10             	add    $0x10,%esp
}
80101a8c:	c9                   	leave  
80101a8d:	c3                   	ret    

80101a8e <iput>:
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void
iput(struct inode *ip)
{
80101a8e:	55                   	push   %ebp
80101a8f:	89 e5                	mov    %esp,%ebp
80101a91:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101a94:	83 ec 0c             	sub    $0xc,%esp
80101a97:	68 c0 e8 10 80       	push   $0x8010e8c0
80101a9c:	e8 c9 30 00 00       	call   80104b6a <acquire>
80101aa1:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101aa4:	8b 45 08             	mov    0x8(%ebp),%eax
80101aa7:	8b 40 08             	mov    0x8(%eax),%eax
80101aaa:	83 f8 01             	cmp    $0x1,%eax
80101aad:	0f 85 a9 00 00 00    	jne    80101b5c <iput+0xce>
80101ab3:	8b 45 08             	mov    0x8(%ebp),%eax
80101ab6:	8b 40 0c             	mov    0xc(%eax),%eax
80101ab9:	83 e0 02             	and    $0x2,%eax
80101abc:	85 c0                	test   %eax,%eax
80101abe:	0f 84 98 00 00 00    	je     80101b5c <iput+0xce>
80101ac4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac7:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101acb:	66 85 c0             	test   %ax,%ax
80101ace:	0f 85 88 00 00 00    	jne    80101b5c <iput+0xce>
    // inode has no links: truncate and free inode.
    if(ip->flags & I_BUSY)
80101ad4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ad7:	8b 40 0c             	mov    0xc(%eax),%eax
80101ada:	83 e0 01             	and    $0x1,%eax
80101add:	85 c0                	test   %eax,%eax
80101adf:	74 0d                	je     80101aee <iput+0x60>
      panic("iput busy");
80101ae1:	83 ec 0c             	sub    $0xc,%esp
80101ae4:	68 68 83 10 80       	push   $0x80108368
80101ae9:	e8 6e ea ff ff       	call   8010055c <panic>
    ip->flags |= I_BUSY;
80101aee:	8b 45 08             	mov    0x8(%ebp),%eax
80101af1:	8b 40 0c             	mov    0xc(%eax),%eax
80101af4:	83 c8 01             	or     $0x1,%eax
80101af7:	89 c2                	mov    %eax,%edx
80101af9:	8b 45 08             	mov    0x8(%ebp),%eax
80101afc:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101aff:	83 ec 0c             	sub    $0xc,%esp
80101b02:	68 c0 e8 10 80       	push   $0x8010e8c0
80101b07:	e8 c4 30 00 00       	call   80104bd0 <release>
80101b0c:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
80101b0f:	83 ec 0c             	sub    $0xc,%esp
80101b12:	ff 75 08             	pushl  0x8(%ebp)
80101b15:	e8 a6 01 00 00       	call   80101cc0 <itrunc>
80101b1a:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
80101b1d:	8b 45 08             	mov    0x8(%ebp),%eax
80101b20:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101b26:	83 ec 0c             	sub    $0xc,%esp
80101b29:	ff 75 08             	pushl  0x8(%ebp)
80101b2c:	e8 c2 fb ff ff       	call   801016f3 <iupdate>
80101b31:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
80101b34:	83 ec 0c             	sub    $0xc,%esp
80101b37:	68 c0 e8 10 80       	push   $0x8010e8c0
80101b3c:	e8 29 30 00 00       	call   80104b6a <acquire>
80101b41:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101b44:	8b 45 08             	mov    0x8(%ebp),%eax
80101b47:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101b4e:	83 ec 0c             	sub    $0xc,%esp
80101b51:	ff 75 08             	pushl  0x8(%ebp)
80101b54:	e8 f8 2d 00 00       	call   80104951 <wakeup>
80101b59:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
80101b5c:	8b 45 08             	mov    0x8(%ebp),%eax
80101b5f:	8b 40 08             	mov    0x8(%eax),%eax
80101b62:	8d 50 ff             	lea    -0x1(%eax),%edx
80101b65:	8b 45 08             	mov    0x8(%ebp),%eax
80101b68:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101b6b:	83 ec 0c             	sub    $0xc,%esp
80101b6e:	68 c0 e8 10 80       	push   $0x8010e8c0
80101b73:	e8 58 30 00 00       	call   80104bd0 <release>
80101b78:	83 c4 10             	add    $0x10,%esp
}
80101b7b:	c9                   	leave  
80101b7c:	c3                   	ret    

80101b7d <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101b7d:	55                   	push   %ebp
80101b7e:	89 e5                	mov    %esp,%ebp
80101b80:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101b83:	83 ec 0c             	sub    $0xc,%esp
80101b86:	ff 75 08             	pushl  0x8(%ebp)
80101b89:	e8 8f fe ff ff       	call   80101a1d <iunlock>
80101b8e:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101b91:	83 ec 0c             	sub    $0xc,%esp
80101b94:	ff 75 08             	pushl  0x8(%ebp)
80101b97:	e8 f2 fe ff ff       	call   80101a8e <iput>
80101b9c:	83 c4 10             	add    $0x10,%esp
}
80101b9f:	c9                   	leave  
80101ba0:	c3                   	ret    

80101ba1 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101ba1:	55                   	push   %ebp
80101ba2:	89 e5                	mov    %esp,%ebp
80101ba4:	53                   	push   %ebx
80101ba5:	83 ec 14             	sub    $0x14,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101ba8:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101bac:	77 42                	ja     80101bf0 <bmap+0x4f>
    if((addr = ip->addrs[bn]) == 0)
80101bae:	8b 45 08             	mov    0x8(%ebp),%eax
80101bb1:	8b 55 0c             	mov    0xc(%ebp),%edx
80101bb4:	83 c2 04             	add    $0x4,%edx
80101bb7:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101bbb:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101bbe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101bc2:	75 24                	jne    80101be8 <bmap+0x47>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101bc4:	8b 45 08             	mov    0x8(%ebp),%eax
80101bc7:	8b 00                	mov    (%eax),%eax
80101bc9:	83 ec 0c             	sub    $0xc,%esp
80101bcc:	50                   	push   %eax
80101bcd:	e8 f8 f7 ff ff       	call   801013ca <balloc>
80101bd2:	83 c4 10             	add    $0x10,%esp
80101bd5:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101bd8:	8b 45 08             	mov    0x8(%ebp),%eax
80101bdb:	8b 55 0c             	mov    0xc(%ebp),%edx
80101bde:	8d 4a 04             	lea    0x4(%edx),%ecx
80101be1:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101be4:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101be8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101beb:	e9 cb 00 00 00       	jmp    80101cbb <bmap+0x11a>
  }
  bn -= NDIRECT;
80101bf0:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101bf4:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101bf8:	0f 87 b0 00 00 00    	ja     80101cae <bmap+0x10d>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101bfe:	8b 45 08             	mov    0x8(%ebp),%eax
80101c01:	8b 40 4c             	mov    0x4c(%eax),%eax
80101c04:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c07:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c0b:	75 1d                	jne    80101c2a <bmap+0x89>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101c0d:	8b 45 08             	mov    0x8(%ebp),%eax
80101c10:	8b 00                	mov    (%eax),%eax
80101c12:	83 ec 0c             	sub    $0xc,%esp
80101c15:	50                   	push   %eax
80101c16:	e8 af f7 ff ff       	call   801013ca <balloc>
80101c1b:	83 c4 10             	add    $0x10,%esp
80101c1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c21:	8b 45 08             	mov    0x8(%ebp),%eax
80101c24:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c27:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80101c2a:	8b 45 08             	mov    0x8(%ebp),%eax
80101c2d:	8b 00                	mov    (%eax),%eax
80101c2f:	83 ec 08             	sub    $0x8,%esp
80101c32:	ff 75 f4             	pushl  -0xc(%ebp)
80101c35:	50                   	push   %eax
80101c36:	e8 79 e5 ff ff       	call   801001b4 <bread>
80101c3b:	83 c4 10             	add    $0x10,%esp
80101c3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101c41:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c44:	83 c0 18             	add    $0x18,%eax
80101c47:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101c4a:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c4d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101c54:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c57:	01 d0                	add    %edx,%eax
80101c59:	8b 00                	mov    (%eax),%eax
80101c5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c5e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c62:	75 37                	jne    80101c9b <bmap+0xfa>
      a[bn] = addr = balloc(ip->dev);
80101c64:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c67:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101c6e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c71:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101c74:	8b 45 08             	mov    0x8(%ebp),%eax
80101c77:	8b 00                	mov    (%eax),%eax
80101c79:	83 ec 0c             	sub    $0xc,%esp
80101c7c:	50                   	push   %eax
80101c7d:	e8 48 f7 ff ff       	call   801013ca <balloc>
80101c82:	83 c4 10             	add    $0x10,%esp
80101c85:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c8b:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101c8d:	83 ec 0c             	sub    $0xc,%esp
80101c90:	ff 75 f0             	pushl  -0x10(%ebp)
80101c93:	e8 58 16 00 00       	call   801032f0 <log_write>
80101c98:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101c9b:	83 ec 0c             	sub    $0xc,%esp
80101c9e:	ff 75 f0             	pushl  -0x10(%ebp)
80101ca1:	e8 85 e5 ff ff       	call   8010022b <brelse>
80101ca6:	83 c4 10             	add    $0x10,%esp
    return addr;
80101ca9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cac:	eb 0d                	jmp    80101cbb <bmap+0x11a>
  }

  panic("bmap: out of range");
80101cae:	83 ec 0c             	sub    $0xc,%esp
80101cb1:	68 72 83 10 80       	push   $0x80108372
80101cb6:	e8 a1 e8 ff ff       	call   8010055c <panic>
}
80101cbb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101cbe:	c9                   	leave  
80101cbf:	c3                   	ret    

80101cc0 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101cc0:	55                   	push   %ebp
80101cc1:	89 e5                	mov    %esp,%ebp
80101cc3:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101cc6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101ccd:	eb 45                	jmp    80101d14 <itrunc+0x54>
    if(ip->addrs[i]){
80101ccf:	8b 45 08             	mov    0x8(%ebp),%eax
80101cd2:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101cd5:	83 c2 04             	add    $0x4,%edx
80101cd8:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101cdc:	85 c0                	test   %eax,%eax
80101cde:	74 30                	je     80101d10 <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
80101ce0:	8b 45 08             	mov    0x8(%ebp),%eax
80101ce3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101ce6:	83 c2 04             	add    $0x4,%edx
80101ce9:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101ced:	8b 55 08             	mov    0x8(%ebp),%edx
80101cf0:	8b 12                	mov    (%edx),%edx
80101cf2:	83 ec 08             	sub    $0x8,%esp
80101cf5:	50                   	push   %eax
80101cf6:	52                   	push   %edx
80101cf7:	e8 23 f8 ff ff       	call   8010151f <bfree>
80101cfc:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101cff:	8b 45 08             	mov    0x8(%ebp),%eax
80101d02:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d05:	83 c2 04             	add    $0x4,%edx
80101d08:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101d0f:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d10:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101d14:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101d18:	7e b5                	jle    80101ccf <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
80101d1a:	8b 45 08             	mov    0x8(%ebp),%eax
80101d1d:	8b 40 4c             	mov    0x4c(%eax),%eax
80101d20:	85 c0                	test   %eax,%eax
80101d22:	0f 84 a1 00 00 00    	je     80101dc9 <itrunc+0x109>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101d28:	8b 45 08             	mov    0x8(%ebp),%eax
80101d2b:	8b 50 4c             	mov    0x4c(%eax),%edx
80101d2e:	8b 45 08             	mov    0x8(%ebp),%eax
80101d31:	8b 00                	mov    (%eax),%eax
80101d33:	83 ec 08             	sub    $0x8,%esp
80101d36:	52                   	push   %edx
80101d37:	50                   	push   %eax
80101d38:	e8 77 e4 ff ff       	call   801001b4 <bread>
80101d3d:	83 c4 10             	add    $0x10,%esp
80101d40:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101d43:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d46:	83 c0 18             	add    $0x18,%eax
80101d49:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101d4c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101d53:	eb 3c                	jmp    80101d91 <itrunc+0xd1>
      if(a[j])
80101d55:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d58:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d5f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101d62:	01 d0                	add    %edx,%eax
80101d64:	8b 00                	mov    (%eax),%eax
80101d66:	85 c0                	test   %eax,%eax
80101d68:	74 23                	je     80101d8d <itrunc+0xcd>
        bfree(ip->dev, a[j]);
80101d6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d6d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d74:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101d77:	01 d0                	add    %edx,%eax
80101d79:	8b 00                	mov    (%eax),%eax
80101d7b:	8b 55 08             	mov    0x8(%ebp),%edx
80101d7e:	8b 12                	mov    (%edx),%edx
80101d80:	83 ec 08             	sub    $0x8,%esp
80101d83:	50                   	push   %eax
80101d84:	52                   	push   %edx
80101d85:	e8 95 f7 ff ff       	call   8010151f <bfree>
80101d8a:	83 c4 10             	add    $0x10,%esp
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101d8d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101d91:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d94:	83 f8 7f             	cmp    $0x7f,%eax
80101d97:	76 bc                	jbe    80101d55 <itrunc+0x95>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101d99:	83 ec 0c             	sub    $0xc,%esp
80101d9c:	ff 75 ec             	pushl  -0x14(%ebp)
80101d9f:	e8 87 e4 ff ff       	call   8010022b <brelse>
80101da4:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101da7:	8b 45 08             	mov    0x8(%ebp),%eax
80101daa:	8b 40 4c             	mov    0x4c(%eax),%eax
80101dad:	8b 55 08             	mov    0x8(%ebp),%edx
80101db0:	8b 12                	mov    (%edx),%edx
80101db2:	83 ec 08             	sub    $0x8,%esp
80101db5:	50                   	push   %eax
80101db6:	52                   	push   %edx
80101db7:	e8 63 f7 ff ff       	call   8010151f <bfree>
80101dbc:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80101dbf:	8b 45 08             	mov    0x8(%ebp),%eax
80101dc2:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80101dc9:	8b 45 08             	mov    0x8(%ebp),%eax
80101dcc:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80101dd3:	83 ec 0c             	sub    $0xc,%esp
80101dd6:	ff 75 08             	pushl  0x8(%ebp)
80101dd9:	e8 15 f9 ff ff       	call   801016f3 <iupdate>
80101dde:	83 c4 10             	add    $0x10,%esp
}
80101de1:	c9                   	leave  
80101de2:	c3                   	ret    

80101de3 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101de3:	55                   	push   %ebp
80101de4:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101de6:	8b 45 08             	mov    0x8(%ebp),%eax
80101de9:	8b 00                	mov    (%eax),%eax
80101deb:	89 c2                	mov    %eax,%edx
80101ded:	8b 45 0c             	mov    0xc(%ebp),%eax
80101df0:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101df3:	8b 45 08             	mov    0x8(%ebp),%eax
80101df6:	8b 50 04             	mov    0x4(%eax),%edx
80101df9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101dfc:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101dff:	8b 45 08             	mov    0x8(%ebp),%eax
80101e02:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101e06:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e09:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101e0c:	8b 45 08             	mov    0x8(%ebp),%eax
80101e0f:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101e13:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e16:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101e1a:	8b 45 08             	mov    0x8(%ebp),%eax
80101e1d:	8b 50 18             	mov    0x18(%eax),%edx
80101e20:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e23:	89 50 10             	mov    %edx,0x10(%eax)
}
80101e26:	5d                   	pop    %ebp
80101e27:	c3                   	ret    

80101e28 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101e28:	55                   	push   %ebp
80101e29:	89 e5                	mov    %esp,%ebp
80101e2b:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101e2e:	8b 45 08             	mov    0x8(%ebp),%eax
80101e31:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101e35:	66 83 f8 03          	cmp    $0x3,%ax
80101e39:	75 5c                	jne    80101e97 <readi+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101e3b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e3e:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e42:	66 85 c0             	test   %ax,%ax
80101e45:	78 20                	js     80101e67 <readi+0x3f>
80101e47:	8b 45 08             	mov    0x8(%ebp),%eax
80101e4a:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e4e:	66 83 f8 09          	cmp    $0x9,%ax
80101e52:	7f 13                	jg     80101e67 <readi+0x3f>
80101e54:	8b 45 08             	mov    0x8(%ebp),%eax
80101e57:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e5b:	98                   	cwtl   
80101e5c:	8b 04 c5 40 e8 10 80 	mov    -0x7fef17c0(,%eax,8),%eax
80101e63:	85 c0                	test   %eax,%eax
80101e65:	75 0a                	jne    80101e71 <readi+0x49>
      return -1;
80101e67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e6c:	e9 16 01 00 00       	jmp    80101f87 <readi+0x15f>
    return devsw[ip->major].read(ip, dst, n);
80101e71:	8b 45 08             	mov    0x8(%ebp),%eax
80101e74:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e78:	98                   	cwtl   
80101e79:	8b 04 c5 40 e8 10 80 	mov    -0x7fef17c0(,%eax,8),%eax
80101e80:	8b 55 14             	mov    0x14(%ebp),%edx
80101e83:	83 ec 04             	sub    $0x4,%esp
80101e86:	52                   	push   %edx
80101e87:	ff 75 0c             	pushl  0xc(%ebp)
80101e8a:	ff 75 08             	pushl  0x8(%ebp)
80101e8d:	ff d0                	call   *%eax
80101e8f:	83 c4 10             	add    $0x10,%esp
80101e92:	e9 f0 00 00 00       	jmp    80101f87 <readi+0x15f>
  }

  if(off > ip->size || off + n < off)
80101e97:	8b 45 08             	mov    0x8(%ebp),%eax
80101e9a:	8b 40 18             	mov    0x18(%eax),%eax
80101e9d:	3b 45 10             	cmp    0x10(%ebp),%eax
80101ea0:	72 0d                	jb     80101eaf <readi+0x87>
80101ea2:	8b 55 10             	mov    0x10(%ebp),%edx
80101ea5:	8b 45 14             	mov    0x14(%ebp),%eax
80101ea8:	01 d0                	add    %edx,%eax
80101eaa:	3b 45 10             	cmp    0x10(%ebp),%eax
80101ead:	73 0a                	jae    80101eb9 <readi+0x91>
    return -1;
80101eaf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101eb4:	e9 ce 00 00 00       	jmp    80101f87 <readi+0x15f>
  if(off + n > ip->size)
80101eb9:	8b 55 10             	mov    0x10(%ebp),%edx
80101ebc:	8b 45 14             	mov    0x14(%ebp),%eax
80101ebf:	01 c2                	add    %eax,%edx
80101ec1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ec4:	8b 40 18             	mov    0x18(%eax),%eax
80101ec7:	39 c2                	cmp    %eax,%edx
80101ec9:	76 0c                	jbe    80101ed7 <readi+0xaf>
    n = ip->size - off;
80101ecb:	8b 45 08             	mov    0x8(%ebp),%eax
80101ece:	8b 40 18             	mov    0x18(%eax),%eax
80101ed1:	2b 45 10             	sub    0x10(%ebp),%eax
80101ed4:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ed7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101ede:	e9 95 00 00 00       	jmp    80101f78 <readi+0x150>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ee3:	8b 45 10             	mov    0x10(%ebp),%eax
80101ee6:	c1 e8 09             	shr    $0x9,%eax
80101ee9:	83 ec 08             	sub    $0x8,%esp
80101eec:	50                   	push   %eax
80101eed:	ff 75 08             	pushl  0x8(%ebp)
80101ef0:	e8 ac fc ff ff       	call   80101ba1 <bmap>
80101ef5:	83 c4 10             	add    $0x10,%esp
80101ef8:	89 c2                	mov    %eax,%edx
80101efa:	8b 45 08             	mov    0x8(%ebp),%eax
80101efd:	8b 00                	mov    (%eax),%eax
80101eff:	83 ec 08             	sub    $0x8,%esp
80101f02:	52                   	push   %edx
80101f03:	50                   	push   %eax
80101f04:	e8 ab e2 ff ff       	call   801001b4 <bread>
80101f09:	83 c4 10             	add    $0x10,%esp
80101f0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101f0f:	8b 45 10             	mov    0x10(%ebp),%eax
80101f12:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f17:	ba 00 02 00 00       	mov    $0x200,%edx
80101f1c:	89 d1                	mov    %edx,%ecx
80101f1e:	29 c1                	sub    %eax,%ecx
80101f20:	8b 45 14             	mov    0x14(%ebp),%eax
80101f23:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101f26:	89 c2                	mov    %eax,%edx
80101f28:	89 c8                	mov    %ecx,%eax
80101f2a:	39 d0                	cmp    %edx,%eax
80101f2c:	76 02                	jbe    80101f30 <readi+0x108>
80101f2e:	89 d0                	mov    %edx,%eax
80101f30:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80101f33:	8b 45 10             	mov    0x10(%ebp),%eax
80101f36:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f3b:	8d 50 10             	lea    0x10(%eax),%edx
80101f3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f41:	01 d0                	add    %edx,%eax
80101f43:	83 c0 08             	add    $0x8,%eax
80101f46:	83 ec 04             	sub    $0x4,%esp
80101f49:	ff 75 ec             	pushl  -0x14(%ebp)
80101f4c:	50                   	push   %eax
80101f4d:	ff 75 0c             	pushl  0xc(%ebp)
80101f50:	e8 30 2f 00 00       	call   80104e85 <memmove>
80101f55:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101f58:	83 ec 0c             	sub    $0xc,%esp
80101f5b:	ff 75 f0             	pushl  -0x10(%ebp)
80101f5e:	e8 c8 e2 ff ff       	call   8010022b <brelse>
80101f63:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f66:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f69:	01 45 f4             	add    %eax,-0xc(%ebp)
80101f6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f6f:	01 45 10             	add    %eax,0x10(%ebp)
80101f72:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f75:	01 45 0c             	add    %eax,0xc(%ebp)
80101f78:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f7b:	3b 45 14             	cmp    0x14(%ebp),%eax
80101f7e:	0f 82 5f ff ff ff    	jb     80101ee3 <readi+0xbb>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101f84:	8b 45 14             	mov    0x14(%ebp),%eax
}
80101f87:	c9                   	leave  
80101f88:	c3                   	ret    

80101f89 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101f89:	55                   	push   %ebp
80101f8a:	89 e5                	mov    %esp,%ebp
80101f8c:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101f8f:	8b 45 08             	mov    0x8(%ebp),%eax
80101f92:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101f96:	66 83 f8 03          	cmp    $0x3,%ax
80101f9a:	75 5c                	jne    80101ff8 <writei+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101f9c:	8b 45 08             	mov    0x8(%ebp),%eax
80101f9f:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fa3:	66 85 c0             	test   %ax,%ax
80101fa6:	78 20                	js     80101fc8 <writei+0x3f>
80101fa8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fab:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101faf:	66 83 f8 09          	cmp    $0x9,%ax
80101fb3:	7f 13                	jg     80101fc8 <writei+0x3f>
80101fb5:	8b 45 08             	mov    0x8(%ebp),%eax
80101fb8:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fbc:	98                   	cwtl   
80101fbd:	8b 04 c5 44 e8 10 80 	mov    -0x7fef17bc(,%eax,8),%eax
80101fc4:	85 c0                	test   %eax,%eax
80101fc6:	75 0a                	jne    80101fd2 <writei+0x49>
      return -1;
80101fc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101fcd:	e9 47 01 00 00       	jmp    80102119 <writei+0x190>
    return devsw[ip->major].write(ip, src, n);
80101fd2:	8b 45 08             	mov    0x8(%ebp),%eax
80101fd5:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fd9:	98                   	cwtl   
80101fda:	8b 04 c5 44 e8 10 80 	mov    -0x7fef17bc(,%eax,8),%eax
80101fe1:	8b 55 14             	mov    0x14(%ebp),%edx
80101fe4:	83 ec 04             	sub    $0x4,%esp
80101fe7:	52                   	push   %edx
80101fe8:	ff 75 0c             	pushl  0xc(%ebp)
80101feb:	ff 75 08             	pushl  0x8(%ebp)
80101fee:	ff d0                	call   *%eax
80101ff0:	83 c4 10             	add    $0x10,%esp
80101ff3:	e9 21 01 00 00       	jmp    80102119 <writei+0x190>
  }

  if(off > ip->size || off + n < off)
80101ff8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ffb:	8b 40 18             	mov    0x18(%eax),%eax
80101ffe:	3b 45 10             	cmp    0x10(%ebp),%eax
80102001:	72 0d                	jb     80102010 <writei+0x87>
80102003:	8b 55 10             	mov    0x10(%ebp),%edx
80102006:	8b 45 14             	mov    0x14(%ebp),%eax
80102009:	01 d0                	add    %edx,%eax
8010200b:	3b 45 10             	cmp    0x10(%ebp),%eax
8010200e:	73 0a                	jae    8010201a <writei+0x91>
    return -1;
80102010:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102015:	e9 ff 00 00 00       	jmp    80102119 <writei+0x190>
  if(off + n > MAXFILE*BSIZE)
8010201a:	8b 55 10             	mov    0x10(%ebp),%edx
8010201d:	8b 45 14             	mov    0x14(%ebp),%eax
80102020:	01 d0                	add    %edx,%eax
80102022:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102027:	76 0a                	jbe    80102033 <writei+0xaa>
    return -1;
80102029:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010202e:	e9 e6 00 00 00       	jmp    80102119 <writei+0x190>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102033:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010203a:	e9 a3 00 00 00       	jmp    801020e2 <writei+0x159>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010203f:	8b 45 10             	mov    0x10(%ebp),%eax
80102042:	c1 e8 09             	shr    $0x9,%eax
80102045:	83 ec 08             	sub    $0x8,%esp
80102048:	50                   	push   %eax
80102049:	ff 75 08             	pushl  0x8(%ebp)
8010204c:	e8 50 fb ff ff       	call   80101ba1 <bmap>
80102051:	83 c4 10             	add    $0x10,%esp
80102054:	89 c2                	mov    %eax,%edx
80102056:	8b 45 08             	mov    0x8(%ebp),%eax
80102059:	8b 00                	mov    (%eax),%eax
8010205b:	83 ec 08             	sub    $0x8,%esp
8010205e:	52                   	push   %edx
8010205f:	50                   	push   %eax
80102060:	e8 4f e1 ff ff       	call   801001b4 <bread>
80102065:	83 c4 10             	add    $0x10,%esp
80102068:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
8010206b:	8b 45 10             	mov    0x10(%ebp),%eax
8010206e:	25 ff 01 00 00       	and    $0x1ff,%eax
80102073:	ba 00 02 00 00       	mov    $0x200,%edx
80102078:	89 d1                	mov    %edx,%ecx
8010207a:	29 c1                	sub    %eax,%ecx
8010207c:	8b 45 14             	mov    0x14(%ebp),%eax
8010207f:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102082:	89 c2                	mov    %eax,%edx
80102084:	89 c8                	mov    %ecx,%eax
80102086:	39 d0                	cmp    %edx,%eax
80102088:	76 02                	jbe    8010208c <writei+0x103>
8010208a:	89 d0                	mov    %edx,%eax
8010208c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
8010208f:	8b 45 10             	mov    0x10(%ebp),%eax
80102092:	25 ff 01 00 00       	and    $0x1ff,%eax
80102097:	8d 50 10             	lea    0x10(%eax),%edx
8010209a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010209d:	01 d0                	add    %edx,%eax
8010209f:	83 c0 08             	add    $0x8,%eax
801020a2:	83 ec 04             	sub    $0x4,%esp
801020a5:	ff 75 ec             	pushl  -0x14(%ebp)
801020a8:	ff 75 0c             	pushl  0xc(%ebp)
801020ab:	50                   	push   %eax
801020ac:	e8 d4 2d 00 00       	call   80104e85 <memmove>
801020b1:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
801020b4:	83 ec 0c             	sub    $0xc,%esp
801020b7:	ff 75 f0             	pushl  -0x10(%ebp)
801020ba:	e8 31 12 00 00       	call   801032f0 <log_write>
801020bf:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801020c2:	83 ec 0c             	sub    $0xc,%esp
801020c5:	ff 75 f0             	pushl  -0x10(%ebp)
801020c8:	e8 5e e1 ff ff       	call   8010022b <brelse>
801020cd:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020d3:	01 45 f4             	add    %eax,-0xc(%ebp)
801020d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020d9:	01 45 10             	add    %eax,0x10(%ebp)
801020dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020df:	01 45 0c             	add    %eax,0xc(%ebp)
801020e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801020e5:	3b 45 14             	cmp    0x14(%ebp),%eax
801020e8:	0f 82 51 ff ff ff    	jb     8010203f <writei+0xb6>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
801020ee:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801020f2:	74 22                	je     80102116 <writei+0x18d>
801020f4:	8b 45 08             	mov    0x8(%ebp),%eax
801020f7:	8b 40 18             	mov    0x18(%eax),%eax
801020fa:	3b 45 10             	cmp    0x10(%ebp),%eax
801020fd:	73 17                	jae    80102116 <writei+0x18d>
    ip->size = off;
801020ff:	8b 45 08             	mov    0x8(%ebp),%eax
80102102:	8b 55 10             	mov    0x10(%ebp),%edx
80102105:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
80102108:	83 ec 0c             	sub    $0xc,%esp
8010210b:	ff 75 08             	pushl  0x8(%ebp)
8010210e:	e8 e0 f5 ff ff       	call   801016f3 <iupdate>
80102113:	83 c4 10             	add    $0x10,%esp
  }
  return n;
80102116:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102119:	c9                   	leave  
8010211a:	c3                   	ret    

8010211b <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
8010211b:	55                   	push   %ebp
8010211c:	89 e5                	mov    %esp,%ebp
8010211e:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
80102121:	83 ec 04             	sub    $0x4,%esp
80102124:	6a 0e                	push   $0xe
80102126:	ff 75 0c             	pushl  0xc(%ebp)
80102129:	ff 75 08             	pushl  0x8(%ebp)
8010212c:	e8 ec 2d 00 00       	call   80104f1d <strncmp>
80102131:	83 c4 10             	add    $0x10,%esp
}
80102134:	c9                   	leave  
80102135:	c3                   	ret    

80102136 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102136:	55                   	push   %ebp
80102137:	89 e5                	mov    %esp,%ebp
80102139:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010213c:	8b 45 08             	mov    0x8(%ebp),%eax
8010213f:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102143:	66 83 f8 01          	cmp    $0x1,%ax
80102147:	74 0d                	je     80102156 <dirlookup+0x20>
    panic("dirlookup not DIR");
80102149:	83 ec 0c             	sub    $0xc,%esp
8010214c:	68 85 83 10 80       	push   $0x80108385
80102151:	e8 06 e4 ff ff       	call   8010055c <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
80102156:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010215d:	eb 7c                	jmp    801021db <dirlookup+0xa5>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010215f:	6a 10                	push   $0x10
80102161:	ff 75 f4             	pushl  -0xc(%ebp)
80102164:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102167:	50                   	push   %eax
80102168:	ff 75 08             	pushl  0x8(%ebp)
8010216b:	e8 b8 fc ff ff       	call   80101e28 <readi>
80102170:	83 c4 10             	add    $0x10,%esp
80102173:	83 f8 10             	cmp    $0x10,%eax
80102176:	74 0d                	je     80102185 <dirlookup+0x4f>
      panic("dirlink read");
80102178:	83 ec 0c             	sub    $0xc,%esp
8010217b:	68 97 83 10 80       	push   $0x80108397
80102180:	e8 d7 e3 ff ff       	call   8010055c <panic>
    if(de.inum == 0)
80102185:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102189:	66 85 c0             	test   %ax,%ax
8010218c:	75 02                	jne    80102190 <dirlookup+0x5a>
      continue;
8010218e:	eb 47                	jmp    801021d7 <dirlookup+0xa1>
    if(namecmp(name, de.name) == 0){
80102190:	83 ec 08             	sub    $0x8,%esp
80102193:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102196:	83 c0 02             	add    $0x2,%eax
80102199:	50                   	push   %eax
8010219a:	ff 75 0c             	pushl  0xc(%ebp)
8010219d:	e8 79 ff ff ff       	call   8010211b <namecmp>
801021a2:	83 c4 10             	add    $0x10,%esp
801021a5:	85 c0                	test   %eax,%eax
801021a7:	75 2e                	jne    801021d7 <dirlookup+0xa1>
      // entry matches path element
      if(poff)
801021a9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801021ad:	74 08                	je     801021b7 <dirlookup+0x81>
        *poff = off;
801021af:	8b 45 10             	mov    0x10(%ebp),%eax
801021b2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801021b5:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
801021b7:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021bb:	0f b7 c0             	movzwl %ax,%eax
801021be:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
801021c1:	8b 45 08             	mov    0x8(%ebp),%eax
801021c4:	8b 00                	mov    (%eax),%eax
801021c6:	83 ec 08             	sub    $0x8,%esp
801021c9:	ff 75 f0             	pushl  -0x10(%ebp)
801021cc:	50                   	push   %eax
801021cd:	e8 db f5 ff ff       	call   801017ad <iget>
801021d2:	83 c4 10             	add    $0x10,%esp
801021d5:	eb 18                	jmp    801021ef <dirlookup+0xb9>
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801021d7:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
801021db:	8b 45 08             	mov    0x8(%ebp),%eax
801021de:	8b 40 18             	mov    0x18(%eax),%eax
801021e1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801021e4:	0f 87 75 ff ff ff    	ja     8010215f <dirlookup+0x29>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
801021ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
801021ef:	c9                   	leave  
801021f0:	c3                   	ret    

801021f1 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
801021f1:	55                   	push   %ebp
801021f2:	89 e5                	mov    %esp,%ebp
801021f4:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
801021f7:	83 ec 04             	sub    $0x4,%esp
801021fa:	6a 00                	push   $0x0
801021fc:	ff 75 0c             	pushl  0xc(%ebp)
801021ff:	ff 75 08             	pushl  0x8(%ebp)
80102202:	e8 2f ff ff ff       	call   80102136 <dirlookup>
80102207:	83 c4 10             	add    $0x10,%esp
8010220a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010220d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102211:	74 18                	je     8010222b <dirlink+0x3a>
    iput(ip);
80102213:	83 ec 0c             	sub    $0xc,%esp
80102216:	ff 75 f0             	pushl  -0x10(%ebp)
80102219:	e8 70 f8 ff ff       	call   80101a8e <iput>
8010221e:	83 c4 10             	add    $0x10,%esp
    return -1;
80102221:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102226:	e9 9b 00 00 00       	jmp    801022c6 <dirlink+0xd5>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
8010222b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102232:	eb 3b                	jmp    8010226f <dirlink+0x7e>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102234:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102237:	6a 10                	push   $0x10
80102239:	50                   	push   %eax
8010223a:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010223d:	50                   	push   %eax
8010223e:	ff 75 08             	pushl  0x8(%ebp)
80102241:	e8 e2 fb ff ff       	call   80101e28 <readi>
80102246:	83 c4 10             	add    $0x10,%esp
80102249:	83 f8 10             	cmp    $0x10,%eax
8010224c:	74 0d                	je     8010225b <dirlink+0x6a>
      panic("dirlink read");
8010224e:	83 ec 0c             	sub    $0xc,%esp
80102251:	68 97 83 10 80       	push   $0x80108397
80102256:	e8 01 e3 ff ff       	call   8010055c <panic>
    if(de.inum == 0)
8010225b:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010225f:	66 85 c0             	test   %ax,%ax
80102262:	75 02                	jne    80102266 <dirlink+0x75>
      break;
80102264:	eb 16                	jmp    8010227c <dirlink+0x8b>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102266:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102269:	83 c0 10             	add    $0x10,%eax
8010226c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010226f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102272:	8b 45 08             	mov    0x8(%ebp),%eax
80102275:	8b 40 18             	mov    0x18(%eax),%eax
80102278:	39 c2                	cmp    %eax,%edx
8010227a:	72 b8                	jb     80102234 <dirlink+0x43>
      panic("dirlink read");
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
8010227c:	83 ec 04             	sub    $0x4,%esp
8010227f:	6a 0e                	push   $0xe
80102281:	ff 75 0c             	pushl  0xc(%ebp)
80102284:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102287:	83 c0 02             	add    $0x2,%eax
8010228a:	50                   	push   %eax
8010228b:	e8 e3 2c 00 00       	call   80104f73 <strncpy>
80102290:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
80102293:	8b 45 10             	mov    0x10(%ebp),%eax
80102296:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010229a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010229d:	6a 10                	push   $0x10
8010229f:	50                   	push   %eax
801022a0:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022a3:	50                   	push   %eax
801022a4:	ff 75 08             	pushl  0x8(%ebp)
801022a7:	e8 dd fc ff ff       	call   80101f89 <writei>
801022ac:	83 c4 10             	add    $0x10,%esp
801022af:	83 f8 10             	cmp    $0x10,%eax
801022b2:	74 0d                	je     801022c1 <dirlink+0xd0>
    panic("dirlink");
801022b4:	83 ec 0c             	sub    $0xc,%esp
801022b7:	68 a4 83 10 80       	push   $0x801083a4
801022bc:	e8 9b e2 ff ff       	call   8010055c <panic>
  
  return 0;
801022c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
801022c6:	c9                   	leave  
801022c7:	c3                   	ret    

801022c8 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
801022c8:	55                   	push   %ebp
801022c9:	89 e5                	mov    %esp,%ebp
801022cb:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
801022ce:	eb 04                	jmp    801022d4 <skipelem+0xc>
    path++;
801022d0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
801022d4:	8b 45 08             	mov    0x8(%ebp),%eax
801022d7:	0f b6 00             	movzbl (%eax),%eax
801022da:	3c 2f                	cmp    $0x2f,%al
801022dc:	74 f2                	je     801022d0 <skipelem+0x8>
    path++;
  if(*path == 0)
801022de:	8b 45 08             	mov    0x8(%ebp),%eax
801022e1:	0f b6 00             	movzbl (%eax),%eax
801022e4:	84 c0                	test   %al,%al
801022e6:	75 07                	jne    801022ef <skipelem+0x27>
    return 0;
801022e8:	b8 00 00 00 00       	mov    $0x0,%eax
801022ed:	eb 7b                	jmp    8010236a <skipelem+0xa2>
  s = path;
801022ef:	8b 45 08             	mov    0x8(%ebp),%eax
801022f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
801022f5:	eb 04                	jmp    801022fb <skipelem+0x33>
    path++;
801022f7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
801022fb:	8b 45 08             	mov    0x8(%ebp),%eax
801022fe:	0f b6 00             	movzbl (%eax),%eax
80102301:	3c 2f                	cmp    $0x2f,%al
80102303:	74 0a                	je     8010230f <skipelem+0x47>
80102305:	8b 45 08             	mov    0x8(%ebp),%eax
80102308:	0f b6 00             	movzbl (%eax),%eax
8010230b:	84 c0                	test   %al,%al
8010230d:	75 e8                	jne    801022f7 <skipelem+0x2f>
    path++;
  len = path - s;
8010230f:	8b 55 08             	mov    0x8(%ebp),%edx
80102312:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102315:	29 c2                	sub    %eax,%edx
80102317:	89 d0                	mov    %edx,%eax
80102319:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
8010231c:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80102320:	7e 15                	jle    80102337 <skipelem+0x6f>
    memmove(name, s, DIRSIZ);
80102322:	83 ec 04             	sub    $0x4,%esp
80102325:	6a 0e                	push   $0xe
80102327:	ff 75 f4             	pushl  -0xc(%ebp)
8010232a:	ff 75 0c             	pushl  0xc(%ebp)
8010232d:	e8 53 2b 00 00       	call   80104e85 <memmove>
80102332:	83 c4 10             	add    $0x10,%esp
80102335:	eb 20                	jmp    80102357 <skipelem+0x8f>
  else {
    memmove(name, s, len);
80102337:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010233a:	83 ec 04             	sub    $0x4,%esp
8010233d:	50                   	push   %eax
8010233e:	ff 75 f4             	pushl  -0xc(%ebp)
80102341:	ff 75 0c             	pushl  0xc(%ebp)
80102344:	e8 3c 2b 00 00       	call   80104e85 <memmove>
80102349:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
8010234c:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010234f:	8b 45 0c             	mov    0xc(%ebp),%eax
80102352:	01 d0                	add    %edx,%eax
80102354:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
80102357:	eb 04                	jmp    8010235d <skipelem+0x95>
    path++;
80102359:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
8010235d:	8b 45 08             	mov    0x8(%ebp),%eax
80102360:	0f b6 00             	movzbl (%eax),%eax
80102363:	3c 2f                	cmp    $0x2f,%al
80102365:	74 f2                	je     80102359 <skipelem+0x91>
    path++;
  return path;
80102367:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010236a:	c9                   	leave  
8010236b:	c3                   	ret    

8010236c <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
8010236c:	55                   	push   %ebp
8010236d:	89 e5                	mov    %esp,%ebp
8010236f:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102372:	8b 45 08             	mov    0x8(%ebp),%eax
80102375:	0f b6 00             	movzbl (%eax),%eax
80102378:	3c 2f                	cmp    $0x2f,%al
8010237a:	75 14                	jne    80102390 <namex+0x24>
    ip = iget(ROOTDEV, ROOTINO);
8010237c:	83 ec 08             	sub    $0x8,%esp
8010237f:	6a 01                	push   $0x1
80102381:	6a 01                	push   $0x1
80102383:	e8 25 f4 ff ff       	call   801017ad <iget>
80102388:	83 c4 10             	add    $0x10,%esp
8010238b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010238e:	eb 18                	jmp    801023a8 <namex+0x3c>
  else
    ip = idup(proc->cwd);
80102390:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80102396:	8b 40 68             	mov    0x68(%eax),%eax
80102399:	83 ec 0c             	sub    $0xc,%esp
8010239c:	50                   	push   %eax
8010239d:	e8 ea f4 ff ff       	call   8010188c <idup>
801023a2:	83 c4 10             	add    $0x10,%esp
801023a5:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
801023a8:	e9 9e 00 00 00       	jmp    8010244b <namex+0xdf>
    ilock(ip);
801023ad:	83 ec 0c             	sub    $0xc,%esp
801023b0:	ff 75 f4             	pushl  -0xc(%ebp)
801023b3:	e8 0e f5 ff ff       	call   801018c6 <ilock>
801023b8:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
801023bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023be:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801023c2:	66 83 f8 01          	cmp    $0x1,%ax
801023c6:	74 18                	je     801023e0 <namex+0x74>
      iunlockput(ip);
801023c8:	83 ec 0c             	sub    $0xc,%esp
801023cb:	ff 75 f4             	pushl  -0xc(%ebp)
801023ce:	e8 aa f7 ff ff       	call   80101b7d <iunlockput>
801023d3:	83 c4 10             	add    $0x10,%esp
      return 0;
801023d6:	b8 00 00 00 00       	mov    $0x0,%eax
801023db:	e9 a7 00 00 00       	jmp    80102487 <namex+0x11b>
    }
    if(nameiparent && *path == '\0'){
801023e0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801023e4:	74 20                	je     80102406 <namex+0x9a>
801023e6:	8b 45 08             	mov    0x8(%ebp),%eax
801023e9:	0f b6 00             	movzbl (%eax),%eax
801023ec:	84 c0                	test   %al,%al
801023ee:	75 16                	jne    80102406 <namex+0x9a>
      // Stop one level early.
      iunlock(ip);
801023f0:	83 ec 0c             	sub    $0xc,%esp
801023f3:	ff 75 f4             	pushl  -0xc(%ebp)
801023f6:	e8 22 f6 ff ff       	call   80101a1d <iunlock>
801023fb:	83 c4 10             	add    $0x10,%esp
      return ip;
801023fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102401:	e9 81 00 00 00       	jmp    80102487 <namex+0x11b>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102406:	83 ec 04             	sub    $0x4,%esp
80102409:	6a 00                	push   $0x0
8010240b:	ff 75 10             	pushl  0x10(%ebp)
8010240e:	ff 75 f4             	pushl  -0xc(%ebp)
80102411:	e8 20 fd ff ff       	call   80102136 <dirlookup>
80102416:	83 c4 10             	add    $0x10,%esp
80102419:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010241c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102420:	75 15                	jne    80102437 <namex+0xcb>
      iunlockput(ip);
80102422:	83 ec 0c             	sub    $0xc,%esp
80102425:	ff 75 f4             	pushl  -0xc(%ebp)
80102428:	e8 50 f7 ff ff       	call   80101b7d <iunlockput>
8010242d:	83 c4 10             	add    $0x10,%esp
      return 0;
80102430:	b8 00 00 00 00       	mov    $0x0,%eax
80102435:	eb 50                	jmp    80102487 <namex+0x11b>
    }
    iunlockput(ip);
80102437:	83 ec 0c             	sub    $0xc,%esp
8010243a:	ff 75 f4             	pushl  -0xc(%ebp)
8010243d:	e8 3b f7 ff ff       	call   80101b7d <iunlockput>
80102442:	83 c4 10             	add    $0x10,%esp
    ip = next;
80102445:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102448:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
8010244b:	83 ec 08             	sub    $0x8,%esp
8010244e:	ff 75 10             	pushl  0x10(%ebp)
80102451:	ff 75 08             	pushl  0x8(%ebp)
80102454:	e8 6f fe ff ff       	call   801022c8 <skipelem>
80102459:	83 c4 10             	add    $0x10,%esp
8010245c:	89 45 08             	mov    %eax,0x8(%ebp)
8010245f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102463:	0f 85 44 ff ff ff    	jne    801023ad <namex+0x41>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102469:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010246d:	74 15                	je     80102484 <namex+0x118>
    iput(ip);
8010246f:	83 ec 0c             	sub    $0xc,%esp
80102472:	ff 75 f4             	pushl  -0xc(%ebp)
80102475:	e8 14 f6 ff ff       	call   80101a8e <iput>
8010247a:	83 c4 10             	add    $0x10,%esp
    return 0;
8010247d:	b8 00 00 00 00       	mov    $0x0,%eax
80102482:	eb 03                	jmp    80102487 <namex+0x11b>
  }
  return ip;
80102484:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102487:	c9                   	leave  
80102488:	c3                   	ret    

80102489 <namei>:

struct inode*
namei(char *path)
{
80102489:	55                   	push   %ebp
8010248a:	89 e5                	mov    %esp,%ebp
8010248c:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
8010248f:	83 ec 04             	sub    $0x4,%esp
80102492:	8d 45 ea             	lea    -0x16(%ebp),%eax
80102495:	50                   	push   %eax
80102496:	6a 00                	push   $0x0
80102498:	ff 75 08             	pushl  0x8(%ebp)
8010249b:	e8 cc fe ff ff       	call   8010236c <namex>
801024a0:	83 c4 10             	add    $0x10,%esp
}
801024a3:	c9                   	leave  
801024a4:	c3                   	ret    

801024a5 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801024a5:	55                   	push   %ebp
801024a6:	89 e5                	mov    %esp,%ebp
801024a8:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
801024ab:	83 ec 04             	sub    $0x4,%esp
801024ae:	ff 75 0c             	pushl  0xc(%ebp)
801024b1:	6a 01                	push   $0x1
801024b3:	ff 75 08             	pushl  0x8(%ebp)
801024b6:	e8 b1 fe ff ff       	call   8010236c <namex>
801024bb:	83 c4 10             	add    $0x10,%esp
}
801024be:	c9                   	leave  
801024bf:	c3                   	ret    

801024c0 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801024c0:	55                   	push   %ebp
801024c1:	89 e5                	mov    %esp,%ebp
801024c3:	83 ec 14             	sub    $0x14,%esp
801024c6:	8b 45 08             	mov    0x8(%ebp),%eax
801024c9:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024cd:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801024d1:	89 c2                	mov    %eax,%edx
801024d3:	ec                   	in     (%dx),%al
801024d4:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801024d7:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801024db:	c9                   	leave  
801024dc:	c3                   	ret    

801024dd <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
801024dd:	55                   	push   %ebp
801024de:	89 e5                	mov    %esp,%ebp
801024e0:	57                   	push   %edi
801024e1:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
801024e2:	8b 55 08             	mov    0x8(%ebp),%edx
801024e5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801024e8:	8b 45 10             	mov    0x10(%ebp),%eax
801024eb:	89 cb                	mov    %ecx,%ebx
801024ed:	89 df                	mov    %ebx,%edi
801024ef:	89 c1                	mov    %eax,%ecx
801024f1:	fc                   	cld    
801024f2:	f3 6d                	rep insl (%dx),%es:(%edi)
801024f4:	89 c8                	mov    %ecx,%eax
801024f6:	89 fb                	mov    %edi,%ebx
801024f8:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801024fb:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
801024fe:	5b                   	pop    %ebx
801024ff:	5f                   	pop    %edi
80102500:	5d                   	pop    %ebp
80102501:	c3                   	ret    

80102502 <outb>:

static inline void
outb(ushort port, uchar data)
{
80102502:	55                   	push   %ebp
80102503:	89 e5                	mov    %esp,%ebp
80102505:	83 ec 08             	sub    $0x8,%esp
80102508:	8b 55 08             	mov    0x8(%ebp),%edx
8010250b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010250e:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102512:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102515:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102519:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010251d:	ee                   	out    %al,(%dx)
}
8010251e:	c9                   	leave  
8010251f:	c3                   	ret    

80102520 <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
80102520:	55                   	push   %ebp
80102521:	89 e5                	mov    %esp,%ebp
80102523:	56                   	push   %esi
80102524:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
80102525:	8b 55 08             	mov    0x8(%ebp),%edx
80102528:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010252b:	8b 45 10             	mov    0x10(%ebp),%eax
8010252e:	89 cb                	mov    %ecx,%ebx
80102530:	89 de                	mov    %ebx,%esi
80102532:	89 c1                	mov    %eax,%ecx
80102534:	fc                   	cld    
80102535:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102537:	89 c8                	mov    %ecx,%eax
80102539:	89 f3                	mov    %esi,%ebx
8010253b:	89 5d 0c             	mov    %ebx,0xc(%ebp)
8010253e:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
80102541:	5b                   	pop    %ebx
80102542:	5e                   	pop    %esi
80102543:	5d                   	pop    %ebp
80102544:	c3                   	ret    

80102545 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
80102545:	55                   	push   %ebp
80102546:	89 e5                	mov    %esp,%ebp
80102548:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
8010254b:	90                   	nop
8010254c:	68 f7 01 00 00       	push   $0x1f7
80102551:	e8 6a ff ff ff       	call   801024c0 <inb>
80102556:	83 c4 04             	add    $0x4,%esp
80102559:	0f b6 c0             	movzbl %al,%eax
8010255c:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010255f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102562:	25 c0 00 00 00       	and    $0xc0,%eax
80102567:	83 f8 40             	cmp    $0x40,%eax
8010256a:	75 e0                	jne    8010254c <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010256c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102570:	74 11                	je     80102583 <idewait+0x3e>
80102572:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102575:	83 e0 21             	and    $0x21,%eax
80102578:	85 c0                	test   %eax,%eax
8010257a:	74 07                	je     80102583 <idewait+0x3e>
    return -1;
8010257c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102581:	eb 05                	jmp    80102588 <idewait+0x43>
  return 0;
80102583:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102588:	c9                   	leave  
80102589:	c3                   	ret    

8010258a <ideinit>:

void
ideinit(void)
{
8010258a:	55                   	push   %ebp
8010258b:	89 e5                	mov    %esp,%ebp
8010258d:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
80102590:	83 ec 08             	sub    $0x8,%esp
80102593:	68 ac 83 10 80       	push   $0x801083ac
80102598:	68 20 b6 10 80       	push   $0x8010b620
8010259d:	e8 a7 25 00 00       	call   80104b49 <initlock>
801025a2:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
801025a5:	83 ec 0c             	sub    $0xc,%esp
801025a8:	6a 0e                	push   $0xe
801025aa:	e8 23 15 00 00       	call   80103ad2 <picenable>
801025af:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
801025b2:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801025b7:	83 e8 01             	sub    $0x1,%eax
801025ba:	83 ec 08             	sub    $0x8,%esp
801025bd:	50                   	push   %eax
801025be:	6a 0e                	push   $0xe
801025c0:	e8 31 04 00 00       	call   801029f6 <ioapicenable>
801025c5:	83 c4 10             	add    $0x10,%esp
  idewait(0);
801025c8:	83 ec 0c             	sub    $0xc,%esp
801025cb:	6a 00                	push   $0x0
801025cd:	e8 73 ff ff ff       	call   80102545 <idewait>
801025d2:	83 c4 10             	add    $0x10,%esp
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
801025d5:	83 ec 08             	sub    $0x8,%esp
801025d8:	68 f0 00 00 00       	push   $0xf0
801025dd:	68 f6 01 00 00       	push   $0x1f6
801025e2:	e8 1b ff ff ff       	call   80102502 <outb>
801025e7:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
801025ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801025f1:	eb 24                	jmp    80102617 <ideinit+0x8d>
    if(inb(0x1f7) != 0){
801025f3:	83 ec 0c             	sub    $0xc,%esp
801025f6:	68 f7 01 00 00       	push   $0x1f7
801025fb:	e8 c0 fe ff ff       	call   801024c0 <inb>
80102600:	83 c4 10             	add    $0x10,%esp
80102603:	84 c0                	test   %al,%al
80102605:	74 0c                	je     80102613 <ideinit+0x89>
      havedisk1 = 1;
80102607:	c7 05 58 b6 10 80 01 	movl   $0x1,0x8010b658
8010260e:	00 00 00 
      break;
80102611:	eb 0d                	jmp    80102620 <ideinit+0x96>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102613:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102617:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
8010261e:	7e d3                	jle    801025f3 <ideinit+0x69>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
80102620:	83 ec 08             	sub    $0x8,%esp
80102623:	68 e0 00 00 00       	push   $0xe0
80102628:	68 f6 01 00 00       	push   $0x1f6
8010262d:	e8 d0 fe ff ff       	call   80102502 <outb>
80102632:	83 c4 10             	add    $0x10,%esp
}
80102635:	c9                   	leave  
80102636:	c3                   	ret    

80102637 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102637:	55                   	push   %ebp
80102638:	89 e5                	mov    %esp,%ebp
8010263a:	83 ec 08             	sub    $0x8,%esp
  if(b == 0)
8010263d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102641:	75 0d                	jne    80102650 <idestart+0x19>
    panic("idestart");
80102643:	83 ec 0c             	sub    $0xc,%esp
80102646:	68 b0 83 10 80       	push   $0x801083b0
8010264b:	e8 0c df ff ff       	call   8010055c <panic>

  idewait(0);
80102650:	83 ec 0c             	sub    $0xc,%esp
80102653:	6a 00                	push   $0x0
80102655:	e8 eb fe ff ff       	call   80102545 <idewait>
8010265a:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
8010265d:	83 ec 08             	sub    $0x8,%esp
80102660:	6a 00                	push   $0x0
80102662:	68 f6 03 00 00       	push   $0x3f6
80102667:	e8 96 fe ff ff       	call   80102502 <outb>
8010266c:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, 1);  // number of sectors
8010266f:	83 ec 08             	sub    $0x8,%esp
80102672:	6a 01                	push   $0x1
80102674:	68 f2 01 00 00       	push   $0x1f2
80102679:	e8 84 fe ff ff       	call   80102502 <outb>
8010267e:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, b->sector & 0xff);
80102681:	8b 45 08             	mov    0x8(%ebp),%eax
80102684:	8b 40 08             	mov    0x8(%eax),%eax
80102687:	0f b6 c0             	movzbl %al,%eax
8010268a:	83 ec 08             	sub    $0x8,%esp
8010268d:	50                   	push   %eax
8010268e:	68 f3 01 00 00       	push   $0x1f3
80102693:	e8 6a fe ff ff       	call   80102502 <outb>
80102698:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (b->sector >> 8) & 0xff);
8010269b:	8b 45 08             	mov    0x8(%ebp),%eax
8010269e:	8b 40 08             	mov    0x8(%eax),%eax
801026a1:	c1 e8 08             	shr    $0x8,%eax
801026a4:	0f b6 c0             	movzbl %al,%eax
801026a7:	83 ec 08             	sub    $0x8,%esp
801026aa:	50                   	push   %eax
801026ab:	68 f4 01 00 00       	push   $0x1f4
801026b0:	e8 4d fe ff ff       	call   80102502 <outb>
801026b5:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (b->sector >> 16) & 0xff);
801026b8:	8b 45 08             	mov    0x8(%ebp),%eax
801026bb:	8b 40 08             	mov    0x8(%eax),%eax
801026be:	c1 e8 10             	shr    $0x10,%eax
801026c1:	0f b6 c0             	movzbl %al,%eax
801026c4:	83 ec 08             	sub    $0x8,%esp
801026c7:	50                   	push   %eax
801026c8:	68 f5 01 00 00       	push   $0x1f5
801026cd:	e8 30 fe ff ff       	call   80102502 <outb>
801026d2:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
801026d5:	8b 45 08             	mov    0x8(%ebp),%eax
801026d8:	8b 40 04             	mov    0x4(%eax),%eax
801026db:	83 e0 01             	and    $0x1,%eax
801026de:	c1 e0 04             	shl    $0x4,%eax
801026e1:	89 c2                	mov    %eax,%edx
801026e3:	8b 45 08             	mov    0x8(%ebp),%eax
801026e6:	8b 40 08             	mov    0x8(%eax),%eax
801026e9:	c1 e8 18             	shr    $0x18,%eax
801026ec:	83 e0 0f             	and    $0xf,%eax
801026ef:	09 d0                	or     %edx,%eax
801026f1:	83 c8 e0             	or     $0xffffffe0,%eax
801026f4:	0f b6 c0             	movzbl %al,%eax
801026f7:	83 ec 08             	sub    $0x8,%esp
801026fa:	50                   	push   %eax
801026fb:	68 f6 01 00 00       	push   $0x1f6
80102700:	e8 fd fd ff ff       	call   80102502 <outb>
80102705:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
80102708:	8b 45 08             	mov    0x8(%ebp),%eax
8010270b:	8b 00                	mov    (%eax),%eax
8010270d:	83 e0 04             	and    $0x4,%eax
80102710:	85 c0                	test   %eax,%eax
80102712:	74 30                	je     80102744 <idestart+0x10d>
    outb(0x1f7, IDE_CMD_WRITE);
80102714:	83 ec 08             	sub    $0x8,%esp
80102717:	6a 30                	push   $0x30
80102719:	68 f7 01 00 00       	push   $0x1f7
8010271e:	e8 df fd ff ff       	call   80102502 <outb>
80102723:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, 512/4);
80102726:	8b 45 08             	mov    0x8(%ebp),%eax
80102729:	83 c0 18             	add    $0x18,%eax
8010272c:	83 ec 04             	sub    $0x4,%esp
8010272f:	68 80 00 00 00       	push   $0x80
80102734:	50                   	push   %eax
80102735:	68 f0 01 00 00       	push   $0x1f0
8010273a:	e8 e1 fd ff ff       	call   80102520 <outsl>
8010273f:	83 c4 10             	add    $0x10,%esp
80102742:	eb 12                	jmp    80102756 <idestart+0x11f>
  } else {
    outb(0x1f7, IDE_CMD_READ);
80102744:	83 ec 08             	sub    $0x8,%esp
80102747:	6a 20                	push   $0x20
80102749:	68 f7 01 00 00       	push   $0x1f7
8010274e:	e8 af fd ff ff       	call   80102502 <outb>
80102753:	83 c4 10             	add    $0x10,%esp
  }
}
80102756:	c9                   	leave  
80102757:	c3                   	ret    

80102758 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102758:	55                   	push   %ebp
80102759:	89 e5                	mov    %esp,%ebp
8010275b:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
8010275e:	83 ec 0c             	sub    $0xc,%esp
80102761:	68 20 b6 10 80       	push   $0x8010b620
80102766:	e8 ff 23 00 00       	call   80104b6a <acquire>
8010276b:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
8010276e:	a1 54 b6 10 80       	mov    0x8010b654,%eax
80102773:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102776:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010277a:	75 15                	jne    80102791 <ideintr+0x39>
    release(&idelock);
8010277c:	83 ec 0c             	sub    $0xc,%esp
8010277f:	68 20 b6 10 80       	push   $0x8010b620
80102784:	e8 47 24 00 00       	call   80104bd0 <release>
80102789:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
8010278c:	e9 9a 00 00 00       	jmp    8010282b <ideintr+0xd3>
  }
  idequeue = b->qnext;
80102791:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102794:	8b 40 14             	mov    0x14(%eax),%eax
80102797:	a3 54 b6 10 80       	mov    %eax,0x8010b654

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
8010279c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010279f:	8b 00                	mov    (%eax),%eax
801027a1:	83 e0 04             	and    $0x4,%eax
801027a4:	85 c0                	test   %eax,%eax
801027a6:	75 2d                	jne    801027d5 <ideintr+0x7d>
801027a8:	83 ec 0c             	sub    $0xc,%esp
801027ab:	6a 01                	push   $0x1
801027ad:	e8 93 fd ff ff       	call   80102545 <idewait>
801027b2:	83 c4 10             	add    $0x10,%esp
801027b5:	85 c0                	test   %eax,%eax
801027b7:	78 1c                	js     801027d5 <ideintr+0x7d>
    insl(0x1f0, b->data, 512/4);
801027b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027bc:	83 c0 18             	add    $0x18,%eax
801027bf:	83 ec 04             	sub    $0x4,%esp
801027c2:	68 80 00 00 00       	push   $0x80
801027c7:	50                   	push   %eax
801027c8:	68 f0 01 00 00       	push   $0x1f0
801027cd:	e8 0b fd ff ff       	call   801024dd <insl>
801027d2:	83 c4 10             	add    $0x10,%esp
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801027d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027d8:	8b 00                	mov    (%eax),%eax
801027da:	83 c8 02             	or     $0x2,%eax
801027dd:	89 c2                	mov    %eax,%edx
801027df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027e2:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
801027e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027e7:	8b 00                	mov    (%eax),%eax
801027e9:	83 e0 fb             	and    $0xfffffffb,%eax
801027ec:	89 c2                	mov    %eax,%edx
801027ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027f1:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801027f3:	83 ec 0c             	sub    $0xc,%esp
801027f6:	ff 75 f4             	pushl  -0xc(%ebp)
801027f9:	e8 53 21 00 00       	call   80104951 <wakeup>
801027fe:	83 c4 10             	add    $0x10,%esp
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
80102801:	a1 54 b6 10 80       	mov    0x8010b654,%eax
80102806:	85 c0                	test   %eax,%eax
80102808:	74 11                	je     8010281b <ideintr+0xc3>
    idestart(idequeue);
8010280a:	a1 54 b6 10 80       	mov    0x8010b654,%eax
8010280f:	83 ec 0c             	sub    $0xc,%esp
80102812:	50                   	push   %eax
80102813:	e8 1f fe ff ff       	call   80102637 <idestart>
80102818:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
8010281b:	83 ec 0c             	sub    $0xc,%esp
8010281e:	68 20 b6 10 80       	push   $0x8010b620
80102823:	e8 a8 23 00 00       	call   80104bd0 <release>
80102828:	83 c4 10             	add    $0x10,%esp
}
8010282b:	c9                   	leave  
8010282c:	c3                   	ret    

8010282d <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
8010282d:	55                   	push   %ebp
8010282e:	89 e5                	mov    %esp,%ebp
80102830:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
80102833:	8b 45 08             	mov    0x8(%ebp),%eax
80102836:	8b 00                	mov    (%eax),%eax
80102838:	83 e0 01             	and    $0x1,%eax
8010283b:	85 c0                	test   %eax,%eax
8010283d:	75 0d                	jne    8010284c <iderw+0x1f>
    panic("iderw: buf not busy");
8010283f:	83 ec 0c             	sub    $0xc,%esp
80102842:	68 b9 83 10 80       	push   $0x801083b9
80102847:	e8 10 dd ff ff       	call   8010055c <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010284c:	8b 45 08             	mov    0x8(%ebp),%eax
8010284f:	8b 00                	mov    (%eax),%eax
80102851:	83 e0 06             	and    $0x6,%eax
80102854:	83 f8 02             	cmp    $0x2,%eax
80102857:	75 0d                	jne    80102866 <iderw+0x39>
    panic("iderw: nothing to do");
80102859:	83 ec 0c             	sub    $0xc,%esp
8010285c:	68 cd 83 10 80       	push   $0x801083cd
80102861:	e8 f6 dc ff ff       	call   8010055c <panic>
  if(b->dev != 0 && !havedisk1)
80102866:	8b 45 08             	mov    0x8(%ebp),%eax
80102869:	8b 40 04             	mov    0x4(%eax),%eax
8010286c:	85 c0                	test   %eax,%eax
8010286e:	74 16                	je     80102886 <iderw+0x59>
80102870:	a1 58 b6 10 80       	mov    0x8010b658,%eax
80102875:	85 c0                	test   %eax,%eax
80102877:	75 0d                	jne    80102886 <iderw+0x59>
    panic("iderw: ide disk 1 not present");
80102879:	83 ec 0c             	sub    $0xc,%esp
8010287c:	68 e2 83 10 80       	push   $0x801083e2
80102881:	e8 d6 dc ff ff       	call   8010055c <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102886:	83 ec 0c             	sub    $0xc,%esp
80102889:	68 20 b6 10 80       	push   $0x8010b620
8010288e:	e8 d7 22 00 00       	call   80104b6a <acquire>
80102893:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
80102896:	8b 45 08             	mov    0x8(%ebp),%eax
80102899:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801028a0:	c7 45 f4 54 b6 10 80 	movl   $0x8010b654,-0xc(%ebp)
801028a7:	eb 0b                	jmp    801028b4 <iderw+0x87>
801028a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028ac:	8b 00                	mov    (%eax),%eax
801028ae:	83 c0 14             	add    $0x14,%eax
801028b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028b7:	8b 00                	mov    (%eax),%eax
801028b9:	85 c0                	test   %eax,%eax
801028bb:	75 ec                	jne    801028a9 <iderw+0x7c>
    ;
  *pp = b;
801028bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028c0:	8b 55 08             	mov    0x8(%ebp),%edx
801028c3:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
801028c5:	a1 54 b6 10 80       	mov    0x8010b654,%eax
801028ca:	3b 45 08             	cmp    0x8(%ebp),%eax
801028cd:	75 0e                	jne    801028dd <iderw+0xb0>
    idestart(b);
801028cf:	83 ec 0c             	sub    $0xc,%esp
801028d2:	ff 75 08             	pushl  0x8(%ebp)
801028d5:	e8 5d fd ff ff       	call   80102637 <idestart>
801028da:	83 c4 10             	add    $0x10,%esp
  
  //acquire(&idelock);  //DOC:acquire-lock
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801028dd:	eb 13                	jmp    801028f2 <iderw+0xc5>
  //  acquire(&idelock);  //DOC:acquire-lock
   
    sleep(b, &idelock);
801028df:	83 ec 08             	sub    $0x8,%esp
801028e2:	68 20 b6 10 80       	push   $0x8010b620
801028e7:	ff 75 08             	pushl  0x8(%ebp)
801028ea:	e8 79 1f 00 00       	call   80104868 <sleep>
801028ef:	83 c4 10             	add    $0x10,%esp
  if(idequeue == b)
    idestart(b);
  
  //acquire(&idelock);  //DOC:acquire-lock
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801028f2:	8b 45 08             	mov    0x8(%ebp),%eax
801028f5:	8b 00                	mov    (%eax),%eax
801028f7:	83 e0 06             	and    $0x6,%eax
801028fa:	83 f8 02             	cmp    $0x2,%eax
801028fd:	75 e0                	jne    801028df <iderw+0xb2>
  //  acquire(&idelock);  //DOC:acquire-lock
   
    sleep(b, &idelock);
  }

  release(&idelock);
801028ff:	83 ec 0c             	sub    $0xc,%esp
80102902:	68 20 b6 10 80       	push   $0x8010b620
80102907:	e8 c4 22 00 00       	call   80104bd0 <release>
8010290c:	83 c4 10             	add    $0x10,%esp
}
8010290f:	c9                   	leave  
80102910:	c3                   	ret    

80102911 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102911:	55                   	push   %ebp
80102912:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102914:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102919:	8b 55 08             	mov    0x8(%ebp),%edx
8010291c:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
8010291e:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102923:	8b 40 10             	mov    0x10(%eax),%eax
}
80102926:	5d                   	pop    %ebp
80102927:	c3                   	ret    

80102928 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102928:	55                   	push   %ebp
80102929:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
8010292b:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102930:	8b 55 08             	mov    0x8(%ebp),%edx
80102933:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102935:	a1 94 f8 10 80       	mov    0x8010f894,%eax
8010293a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010293d:	89 50 10             	mov    %edx,0x10(%eax)
}
80102940:	5d                   	pop    %ebp
80102941:	c3                   	ret    

80102942 <ioapicinit>:

void
ioapicinit(void)
{
80102942:	55                   	push   %ebp
80102943:	89 e5                	mov    %esp,%ebp
80102945:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  if(!ismp)
80102948:	a1 84 f9 10 80       	mov    0x8010f984,%eax
8010294d:	85 c0                	test   %eax,%eax
8010294f:	75 05                	jne    80102956 <ioapicinit+0x14>
    return;
80102951:	e9 9e 00 00 00       	jmp    801029f4 <ioapicinit+0xb2>

  ioapic = (volatile struct ioapic*)IOAPIC;
80102956:	c7 05 94 f8 10 80 00 	movl   $0xfec00000,0x8010f894
8010295d:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102960:	6a 01                	push   $0x1
80102962:	e8 aa ff ff ff       	call   80102911 <ioapicread>
80102967:	83 c4 04             	add    $0x4,%esp
8010296a:	c1 e8 10             	shr    $0x10,%eax
8010296d:	25 ff 00 00 00       	and    $0xff,%eax
80102972:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80102975:	6a 00                	push   $0x0
80102977:	e8 95 ff ff ff       	call   80102911 <ioapicread>
8010297c:	83 c4 04             	add    $0x4,%esp
8010297f:	c1 e8 18             	shr    $0x18,%eax
80102982:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102985:	0f b6 05 80 f9 10 80 	movzbl 0x8010f980,%eax
8010298c:	0f b6 c0             	movzbl %al,%eax
8010298f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80102992:	74 10                	je     801029a4 <ioapicinit+0x62>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102994:	83 ec 0c             	sub    $0xc,%esp
80102997:	68 00 84 10 80       	push   $0x80108400
8010299c:	e8 1e da ff ff       	call   801003bf <cprintf>
801029a1:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801029a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801029ab:	eb 3f                	jmp    801029ec <ioapicinit+0xaa>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801029ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029b0:	83 c0 20             	add    $0x20,%eax
801029b3:	0d 00 00 01 00       	or     $0x10000,%eax
801029b8:	89 c2                	mov    %eax,%edx
801029ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029bd:	83 c0 08             	add    $0x8,%eax
801029c0:	01 c0                	add    %eax,%eax
801029c2:	83 ec 08             	sub    $0x8,%esp
801029c5:	52                   	push   %edx
801029c6:	50                   	push   %eax
801029c7:	e8 5c ff ff ff       	call   80102928 <ioapicwrite>
801029cc:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
801029cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029d2:	83 c0 08             	add    $0x8,%eax
801029d5:	01 c0                	add    %eax,%eax
801029d7:	83 c0 01             	add    $0x1,%eax
801029da:	83 ec 08             	sub    $0x8,%esp
801029dd:	6a 00                	push   $0x0
801029df:	50                   	push   %eax
801029e0:	e8 43 ff ff ff       	call   80102928 <ioapicwrite>
801029e5:	83 c4 10             	add    $0x10,%esp
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801029e8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801029ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029ef:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801029f2:	7e b9                	jle    801029ad <ioapicinit+0x6b>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801029f4:	c9                   	leave  
801029f5:	c3                   	ret    

801029f6 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801029f6:	55                   	push   %ebp
801029f7:	89 e5                	mov    %esp,%ebp
  if(!ismp)
801029f9:	a1 84 f9 10 80       	mov    0x8010f984,%eax
801029fe:	85 c0                	test   %eax,%eax
80102a00:	75 02                	jne    80102a04 <ioapicenable+0xe>
    return;
80102a02:	eb 37                	jmp    80102a3b <ioapicenable+0x45>

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102a04:	8b 45 08             	mov    0x8(%ebp),%eax
80102a07:	83 c0 20             	add    $0x20,%eax
80102a0a:	89 c2                	mov    %eax,%edx
80102a0c:	8b 45 08             	mov    0x8(%ebp),%eax
80102a0f:	83 c0 08             	add    $0x8,%eax
80102a12:	01 c0                	add    %eax,%eax
80102a14:	52                   	push   %edx
80102a15:	50                   	push   %eax
80102a16:	e8 0d ff ff ff       	call   80102928 <ioapicwrite>
80102a1b:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102a1e:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a21:	c1 e0 18             	shl    $0x18,%eax
80102a24:	89 c2                	mov    %eax,%edx
80102a26:	8b 45 08             	mov    0x8(%ebp),%eax
80102a29:	83 c0 08             	add    $0x8,%eax
80102a2c:	01 c0                	add    %eax,%eax
80102a2e:	83 c0 01             	add    $0x1,%eax
80102a31:	52                   	push   %edx
80102a32:	50                   	push   %eax
80102a33:	e8 f0 fe ff ff       	call   80102928 <ioapicwrite>
80102a38:	83 c4 08             	add    $0x8,%esp
}
80102a3b:	c9                   	leave  
80102a3c:	c3                   	ret    

80102a3d <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80102a3d:	55                   	push   %ebp
80102a3e:	89 e5                	mov    %esp,%ebp
80102a40:	8b 45 08             	mov    0x8(%ebp),%eax
80102a43:	05 00 00 00 80       	add    $0x80000000,%eax
80102a48:	5d                   	pop    %ebp
80102a49:	c3                   	ret    

80102a4a <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102a4a:	55                   	push   %ebp
80102a4b:	89 e5                	mov    %esp,%ebp
80102a4d:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102a50:	83 ec 08             	sub    $0x8,%esp
80102a53:	68 32 84 10 80       	push   $0x80108432
80102a58:	68 a0 f8 10 80       	push   $0x8010f8a0
80102a5d:	e8 e7 20 00 00       	call   80104b49 <initlock>
80102a62:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102a65:	c7 05 d4 f8 10 80 00 	movl   $0x0,0x8010f8d4
80102a6c:	00 00 00 
  freerange(vstart, vend);
80102a6f:	83 ec 08             	sub    $0x8,%esp
80102a72:	ff 75 0c             	pushl  0xc(%ebp)
80102a75:	ff 75 08             	pushl  0x8(%ebp)
80102a78:	e8 28 00 00 00       	call   80102aa5 <freerange>
80102a7d:	83 c4 10             	add    $0x10,%esp
}
80102a80:	c9                   	leave  
80102a81:	c3                   	ret    

80102a82 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102a82:	55                   	push   %ebp
80102a83:	89 e5                	mov    %esp,%ebp
80102a85:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
80102a88:	83 ec 08             	sub    $0x8,%esp
80102a8b:	ff 75 0c             	pushl  0xc(%ebp)
80102a8e:	ff 75 08             	pushl  0x8(%ebp)
80102a91:	e8 0f 00 00 00       	call   80102aa5 <freerange>
80102a96:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
80102a99:	c7 05 d4 f8 10 80 01 	movl   $0x1,0x8010f8d4
80102aa0:	00 00 00 
}
80102aa3:	c9                   	leave  
80102aa4:	c3                   	ret    

80102aa5 <freerange>:

void
freerange(void *vstart, void *vend)
{
80102aa5:	55                   	push   %ebp
80102aa6:	89 e5                	mov    %esp,%ebp
80102aa8:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102aab:	8b 45 08             	mov    0x8(%ebp),%eax
80102aae:	05 ff 0f 00 00       	add    $0xfff,%eax
80102ab3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102ab8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102abb:	eb 15                	jmp    80102ad2 <freerange+0x2d>
    kfree(p);
80102abd:	83 ec 0c             	sub    $0xc,%esp
80102ac0:	ff 75 f4             	pushl  -0xc(%ebp)
80102ac3:	e8 19 00 00 00       	call   80102ae1 <kfree>
80102ac8:	83 c4 10             	add    $0x10,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102acb:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102ad2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ad5:	05 00 10 00 00       	add    $0x1000,%eax
80102ada:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102add:	76 de                	jbe    80102abd <freerange+0x18>
    kfree(p);
}
80102adf:	c9                   	leave  
80102ae0:	c3                   	ret    

80102ae1 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102ae1:	55                   	push   %ebp
80102ae2:	89 e5                	mov    %esp,%ebp
80102ae4:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102ae7:	8b 45 08             	mov    0x8(%ebp),%eax
80102aea:	25 ff 0f 00 00       	and    $0xfff,%eax
80102aef:	85 c0                	test   %eax,%eax
80102af1:	75 1b                	jne    80102b0e <kfree+0x2d>
80102af3:	81 7d 08 9c 27 11 80 	cmpl   $0x8011279c,0x8(%ebp)
80102afa:	72 12                	jb     80102b0e <kfree+0x2d>
80102afc:	ff 75 08             	pushl  0x8(%ebp)
80102aff:	e8 39 ff ff ff       	call   80102a3d <v2p>
80102b04:	83 c4 04             	add    $0x4,%esp
80102b07:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102b0c:	76 0d                	jbe    80102b1b <kfree+0x3a>
    panic("kfree");
80102b0e:	83 ec 0c             	sub    $0xc,%esp
80102b11:	68 37 84 10 80       	push   $0x80108437
80102b16:	e8 41 da ff ff       	call   8010055c <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102b1b:	83 ec 04             	sub    $0x4,%esp
80102b1e:	68 00 10 00 00       	push   $0x1000
80102b23:	6a 01                	push   $0x1
80102b25:	ff 75 08             	pushl  0x8(%ebp)
80102b28:	e8 99 22 00 00       	call   80104dc6 <memset>
80102b2d:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102b30:	a1 d4 f8 10 80       	mov    0x8010f8d4,%eax
80102b35:	85 c0                	test   %eax,%eax
80102b37:	74 10                	je     80102b49 <kfree+0x68>
    acquire(&kmem.lock);
80102b39:	83 ec 0c             	sub    $0xc,%esp
80102b3c:	68 a0 f8 10 80       	push   $0x8010f8a0
80102b41:	e8 24 20 00 00       	call   80104b6a <acquire>
80102b46:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102b49:	8b 45 08             	mov    0x8(%ebp),%eax
80102b4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102b4f:	8b 15 d8 f8 10 80    	mov    0x8010f8d8,%edx
80102b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b58:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102b5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b5d:	a3 d8 f8 10 80       	mov    %eax,0x8010f8d8
  if(kmem.use_lock)
80102b62:	a1 d4 f8 10 80       	mov    0x8010f8d4,%eax
80102b67:	85 c0                	test   %eax,%eax
80102b69:	74 10                	je     80102b7b <kfree+0x9a>
    release(&kmem.lock);
80102b6b:	83 ec 0c             	sub    $0xc,%esp
80102b6e:	68 a0 f8 10 80       	push   $0x8010f8a0
80102b73:	e8 58 20 00 00       	call   80104bd0 <release>
80102b78:	83 c4 10             	add    $0x10,%esp
}
80102b7b:	c9                   	leave  
80102b7c:	c3                   	ret    

80102b7d <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102b7d:	55                   	push   %ebp
80102b7e:	89 e5                	mov    %esp,%ebp
80102b80:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102b83:	a1 d4 f8 10 80       	mov    0x8010f8d4,%eax
80102b88:	85 c0                	test   %eax,%eax
80102b8a:	74 10                	je     80102b9c <kalloc+0x1f>
    acquire(&kmem.lock);
80102b8c:	83 ec 0c             	sub    $0xc,%esp
80102b8f:	68 a0 f8 10 80       	push   $0x8010f8a0
80102b94:	e8 d1 1f 00 00       	call   80104b6a <acquire>
80102b99:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102b9c:	a1 d8 f8 10 80       	mov    0x8010f8d8,%eax
80102ba1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102ba4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102ba8:	74 0a                	je     80102bb4 <kalloc+0x37>
    kmem.freelist = r->next;
80102baa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bad:	8b 00                	mov    (%eax),%eax
80102baf:	a3 d8 f8 10 80       	mov    %eax,0x8010f8d8
  if(kmem.use_lock)
80102bb4:	a1 d4 f8 10 80       	mov    0x8010f8d4,%eax
80102bb9:	85 c0                	test   %eax,%eax
80102bbb:	74 10                	je     80102bcd <kalloc+0x50>
    release(&kmem.lock);
80102bbd:	83 ec 0c             	sub    $0xc,%esp
80102bc0:	68 a0 f8 10 80       	push   $0x8010f8a0
80102bc5:	e8 06 20 00 00       	call   80104bd0 <release>
80102bca:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80102bcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102bd0:	c9                   	leave  
80102bd1:	c3                   	ret    

80102bd2 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102bd2:	55                   	push   %ebp
80102bd3:	89 e5                	mov    %esp,%ebp
80102bd5:	83 ec 14             	sub    $0x14,%esp
80102bd8:	8b 45 08             	mov    0x8(%ebp),%eax
80102bdb:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bdf:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102be3:	89 c2                	mov    %eax,%edx
80102be5:	ec                   	in     (%dx),%al
80102be6:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102be9:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102bed:	c9                   	leave  
80102bee:	c3                   	ret    

80102bef <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102bef:	55                   	push   %ebp
80102bf0:	89 e5                	mov    %esp,%ebp
80102bf2:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102bf5:	6a 64                	push   $0x64
80102bf7:	e8 d6 ff ff ff       	call   80102bd2 <inb>
80102bfc:	83 c4 04             	add    $0x4,%esp
80102bff:	0f b6 c0             	movzbl %al,%eax
80102c02:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102c05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c08:	83 e0 01             	and    $0x1,%eax
80102c0b:	85 c0                	test   %eax,%eax
80102c0d:	75 0a                	jne    80102c19 <kbdgetc+0x2a>
    return -1;
80102c0f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c14:	e9 23 01 00 00       	jmp    80102d3c <kbdgetc+0x14d>
  data = inb(KBDATAP);
80102c19:	6a 60                	push   $0x60
80102c1b:	e8 b2 ff ff ff       	call   80102bd2 <inb>
80102c20:	83 c4 04             	add    $0x4,%esp
80102c23:	0f b6 c0             	movzbl %al,%eax
80102c26:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102c29:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102c30:	75 17                	jne    80102c49 <kbdgetc+0x5a>
    shift |= E0ESC;
80102c32:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c37:	83 c8 40             	or     $0x40,%eax
80102c3a:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
    return 0;
80102c3f:	b8 00 00 00 00       	mov    $0x0,%eax
80102c44:	e9 f3 00 00 00       	jmp    80102d3c <kbdgetc+0x14d>
  } else if(data & 0x80){
80102c49:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c4c:	25 80 00 00 00       	and    $0x80,%eax
80102c51:	85 c0                	test   %eax,%eax
80102c53:	74 45                	je     80102c9a <kbdgetc+0xab>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102c55:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c5a:	83 e0 40             	and    $0x40,%eax
80102c5d:	85 c0                	test   %eax,%eax
80102c5f:	75 08                	jne    80102c69 <kbdgetc+0x7a>
80102c61:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c64:	83 e0 7f             	and    $0x7f,%eax
80102c67:	eb 03                	jmp    80102c6c <kbdgetc+0x7d>
80102c69:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c6c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102c6f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c72:	05 40 90 10 80       	add    $0x80109040,%eax
80102c77:	0f b6 00             	movzbl (%eax),%eax
80102c7a:	83 c8 40             	or     $0x40,%eax
80102c7d:	0f b6 c0             	movzbl %al,%eax
80102c80:	f7 d0                	not    %eax
80102c82:	89 c2                	mov    %eax,%edx
80102c84:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c89:	21 d0                	and    %edx,%eax
80102c8b:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
    return 0;
80102c90:	b8 00 00 00 00       	mov    $0x0,%eax
80102c95:	e9 a2 00 00 00       	jmp    80102d3c <kbdgetc+0x14d>
  } else if(shift & E0ESC){
80102c9a:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c9f:	83 e0 40             	and    $0x40,%eax
80102ca2:	85 c0                	test   %eax,%eax
80102ca4:	74 14                	je     80102cba <kbdgetc+0xcb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102ca6:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102cad:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102cb2:	83 e0 bf             	and    $0xffffffbf,%eax
80102cb5:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  }

  shift |= shiftcode[data];
80102cba:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102cbd:	05 40 90 10 80       	add    $0x80109040,%eax
80102cc2:	0f b6 00             	movzbl (%eax),%eax
80102cc5:	0f b6 d0             	movzbl %al,%edx
80102cc8:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102ccd:	09 d0                	or     %edx,%eax
80102ccf:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  shift ^= togglecode[data];
80102cd4:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102cd7:	05 40 91 10 80       	add    $0x80109140,%eax
80102cdc:	0f b6 00             	movzbl (%eax),%eax
80102cdf:	0f b6 d0             	movzbl %al,%edx
80102ce2:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102ce7:	31 d0                	xor    %edx,%eax
80102ce9:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  c = charcode[shift & (CTL | SHIFT)][data];
80102cee:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102cf3:	83 e0 03             	and    $0x3,%eax
80102cf6:	8b 14 85 40 95 10 80 	mov    -0x7fef6ac0(,%eax,4),%edx
80102cfd:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d00:	01 d0                	add    %edx,%eax
80102d02:	0f b6 00             	movzbl (%eax),%eax
80102d05:	0f b6 c0             	movzbl %al,%eax
80102d08:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102d0b:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102d10:	83 e0 08             	and    $0x8,%eax
80102d13:	85 c0                	test   %eax,%eax
80102d15:	74 22                	je     80102d39 <kbdgetc+0x14a>
    if('a' <= c && c <= 'z')
80102d17:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102d1b:	76 0c                	jbe    80102d29 <kbdgetc+0x13a>
80102d1d:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102d21:	77 06                	ja     80102d29 <kbdgetc+0x13a>
      c += 'A' - 'a';
80102d23:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102d27:	eb 10                	jmp    80102d39 <kbdgetc+0x14a>
    else if('A' <= c && c <= 'Z')
80102d29:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102d2d:	76 0a                	jbe    80102d39 <kbdgetc+0x14a>
80102d2f:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102d33:	77 04                	ja     80102d39 <kbdgetc+0x14a>
      c += 'a' - 'A';
80102d35:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80102d39:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102d3c:	c9                   	leave  
80102d3d:	c3                   	ret    

80102d3e <kbdintr>:

void
kbdintr(void)
{
80102d3e:	55                   	push   %ebp
80102d3f:	89 e5                	mov    %esp,%ebp
80102d41:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
80102d44:	83 ec 0c             	sub    $0xc,%esp
80102d47:	68 ef 2b 10 80       	push   $0x80102bef
80102d4c:	e8 80 da ff ff       	call   801007d1 <consoleintr>
80102d51:	83 c4 10             	add    $0x10,%esp
}
80102d54:	c9                   	leave  
80102d55:	c3                   	ret    

80102d56 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80102d56:	55                   	push   %ebp
80102d57:	89 e5                	mov    %esp,%ebp
80102d59:	83 ec 08             	sub    $0x8,%esp
80102d5c:	8b 55 08             	mov    0x8(%ebp),%edx
80102d5f:	8b 45 0c             	mov    0xc(%ebp),%eax
80102d62:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102d66:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d69:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102d6d:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102d71:	ee                   	out    %al,(%dx)
}
80102d72:	c9                   	leave  
80102d73:	c3                   	ret    

80102d74 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80102d74:	55                   	push   %ebp
80102d75:	89 e5                	mov    %esp,%ebp
80102d77:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102d7a:	9c                   	pushf  
80102d7b:	58                   	pop    %eax
80102d7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80102d7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102d82:	c9                   	leave  
80102d83:	c3                   	ret    

80102d84 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102d84:	55                   	push   %ebp
80102d85:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102d87:	a1 dc f8 10 80       	mov    0x8010f8dc,%eax
80102d8c:	8b 55 08             	mov    0x8(%ebp),%edx
80102d8f:	c1 e2 02             	shl    $0x2,%edx
80102d92:	01 c2                	add    %eax,%edx
80102d94:	8b 45 0c             	mov    0xc(%ebp),%eax
80102d97:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102d99:	a1 dc f8 10 80       	mov    0x8010f8dc,%eax
80102d9e:	83 c0 20             	add    $0x20,%eax
80102da1:	8b 00                	mov    (%eax),%eax
}
80102da3:	5d                   	pop    %ebp
80102da4:	c3                   	ret    

80102da5 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80102da5:	55                   	push   %ebp
80102da6:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
80102da8:	a1 dc f8 10 80       	mov    0x8010f8dc,%eax
80102dad:	85 c0                	test   %eax,%eax
80102daf:	75 05                	jne    80102db6 <lapicinit+0x11>
    return;
80102db1:	e9 09 01 00 00       	jmp    80102ebf <lapicinit+0x11a>

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102db6:	68 3f 01 00 00       	push   $0x13f
80102dbb:	6a 3c                	push   $0x3c
80102dbd:	e8 c2 ff ff ff       	call   80102d84 <lapicw>
80102dc2:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102dc5:	6a 0b                	push   $0xb
80102dc7:	68 f8 00 00 00       	push   $0xf8
80102dcc:	e8 b3 ff ff ff       	call   80102d84 <lapicw>
80102dd1:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102dd4:	68 20 00 02 00       	push   $0x20020
80102dd9:	68 c8 00 00 00       	push   $0xc8
80102dde:	e8 a1 ff ff ff       	call   80102d84 <lapicw>
80102de3:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000); 
80102de6:	68 80 96 98 00       	push   $0x989680
80102deb:	68 e0 00 00 00       	push   $0xe0
80102df0:	e8 8f ff ff ff       	call   80102d84 <lapicw>
80102df5:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102df8:	68 00 00 01 00       	push   $0x10000
80102dfd:	68 d4 00 00 00       	push   $0xd4
80102e02:	e8 7d ff ff ff       	call   80102d84 <lapicw>
80102e07:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
80102e0a:	68 00 00 01 00       	push   $0x10000
80102e0f:	68 d8 00 00 00       	push   $0xd8
80102e14:	e8 6b ff ff ff       	call   80102d84 <lapicw>
80102e19:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102e1c:	a1 dc f8 10 80       	mov    0x8010f8dc,%eax
80102e21:	83 c0 30             	add    $0x30,%eax
80102e24:	8b 00                	mov    (%eax),%eax
80102e26:	c1 e8 10             	shr    $0x10,%eax
80102e29:	0f b6 c0             	movzbl %al,%eax
80102e2c:	83 f8 03             	cmp    $0x3,%eax
80102e2f:	76 12                	jbe    80102e43 <lapicinit+0x9e>
    lapicw(PCINT, MASKED);
80102e31:	68 00 00 01 00       	push   $0x10000
80102e36:	68 d0 00 00 00       	push   $0xd0
80102e3b:	e8 44 ff ff ff       	call   80102d84 <lapicw>
80102e40:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102e43:	6a 33                	push   $0x33
80102e45:	68 dc 00 00 00       	push   $0xdc
80102e4a:	e8 35 ff ff ff       	call   80102d84 <lapicw>
80102e4f:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102e52:	6a 00                	push   $0x0
80102e54:	68 a0 00 00 00       	push   $0xa0
80102e59:	e8 26 ff ff ff       	call   80102d84 <lapicw>
80102e5e:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80102e61:	6a 00                	push   $0x0
80102e63:	68 a0 00 00 00       	push   $0xa0
80102e68:	e8 17 ff ff ff       	call   80102d84 <lapicw>
80102e6d:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102e70:	6a 00                	push   $0x0
80102e72:	6a 2c                	push   $0x2c
80102e74:	e8 0b ff ff ff       	call   80102d84 <lapicw>
80102e79:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102e7c:	6a 00                	push   $0x0
80102e7e:	68 c4 00 00 00       	push   $0xc4
80102e83:	e8 fc fe ff ff       	call   80102d84 <lapicw>
80102e88:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102e8b:	68 00 85 08 00       	push   $0x88500
80102e90:	68 c0 00 00 00       	push   $0xc0
80102e95:	e8 ea fe ff ff       	call   80102d84 <lapicw>
80102e9a:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80102e9d:	90                   	nop
80102e9e:	a1 dc f8 10 80       	mov    0x8010f8dc,%eax
80102ea3:	05 00 03 00 00       	add    $0x300,%eax
80102ea8:	8b 00                	mov    (%eax),%eax
80102eaa:	25 00 10 00 00       	and    $0x1000,%eax
80102eaf:	85 c0                	test   %eax,%eax
80102eb1:	75 eb                	jne    80102e9e <lapicinit+0xf9>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80102eb3:	6a 00                	push   $0x0
80102eb5:	6a 20                	push   $0x20
80102eb7:	e8 c8 fe ff ff       	call   80102d84 <lapicw>
80102ebc:	83 c4 08             	add    $0x8,%esp
}
80102ebf:	c9                   	leave  
80102ec0:	c3                   	ret    

80102ec1 <cpunum>:

int
cpunum(void)
{
80102ec1:	55                   	push   %ebp
80102ec2:	89 e5                	mov    %esp,%ebp
80102ec4:	83 ec 08             	sub    $0x8,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102ec7:	e8 a8 fe ff ff       	call   80102d74 <readeflags>
80102ecc:	25 00 02 00 00       	and    $0x200,%eax
80102ed1:	85 c0                	test   %eax,%eax
80102ed3:	74 26                	je     80102efb <cpunum+0x3a>
    static int n;
    if(n++ == 0)
80102ed5:	a1 60 b6 10 80       	mov    0x8010b660,%eax
80102eda:	8d 50 01             	lea    0x1(%eax),%edx
80102edd:	89 15 60 b6 10 80    	mov    %edx,0x8010b660
80102ee3:	85 c0                	test   %eax,%eax
80102ee5:	75 14                	jne    80102efb <cpunum+0x3a>
      cprintf("cpu called from %x with interrupts enabled\n",
80102ee7:	8b 45 04             	mov    0x4(%ebp),%eax
80102eea:	83 ec 08             	sub    $0x8,%esp
80102eed:	50                   	push   %eax
80102eee:	68 40 84 10 80       	push   $0x80108440
80102ef3:	e8 c7 d4 ff ff       	call   801003bf <cprintf>
80102ef8:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
80102efb:	a1 dc f8 10 80       	mov    0x8010f8dc,%eax
80102f00:	85 c0                	test   %eax,%eax
80102f02:	74 0f                	je     80102f13 <cpunum+0x52>
    return lapic[ID]>>24;
80102f04:	a1 dc f8 10 80       	mov    0x8010f8dc,%eax
80102f09:	83 c0 20             	add    $0x20,%eax
80102f0c:	8b 00                	mov    (%eax),%eax
80102f0e:	c1 e8 18             	shr    $0x18,%eax
80102f11:	eb 05                	jmp    80102f18 <cpunum+0x57>
  return 0;
80102f13:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102f18:	c9                   	leave  
80102f19:	c3                   	ret    

80102f1a <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102f1a:	55                   	push   %ebp
80102f1b:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102f1d:	a1 dc f8 10 80       	mov    0x8010f8dc,%eax
80102f22:	85 c0                	test   %eax,%eax
80102f24:	74 0c                	je     80102f32 <lapiceoi+0x18>
    lapicw(EOI, 0);
80102f26:	6a 00                	push   $0x0
80102f28:	6a 2c                	push   $0x2c
80102f2a:	e8 55 fe ff ff       	call   80102d84 <lapicw>
80102f2f:	83 c4 08             	add    $0x8,%esp
}
80102f32:	c9                   	leave  
80102f33:	c3                   	ret    

80102f34 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102f34:	55                   	push   %ebp
80102f35:	89 e5                	mov    %esp,%ebp
}
80102f37:	5d                   	pop    %ebp
80102f38:	c3                   	ret    

80102f39 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102f39:	55                   	push   %ebp
80102f3a:	89 e5                	mov    %esp,%ebp
80102f3c:	83 ec 14             	sub    $0x14,%esp
80102f3f:	8b 45 08             	mov    0x8(%ebp),%eax
80102f42:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
80102f45:	6a 0f                	push   $0xf
80102f47:	6a 70                	push   $0x70
80102f49:	e8 08 fe ff ff       	call   80102d56 <outb>
80102f4e:	83 c4 08             	add    $0x8,%esp
  outb(IO_RTC+1, 0x0A);
80102f51:	6a 0a                	push   $0xa
80102f53:	6a 71                	push   $0x71
80102f55:	e8 fc fd ff ff       	call   80102d56 <outb>
80102f5a:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80102f5d:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80102f64:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102f67:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80102f6c:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102f6f:	83 c0 02             	add    $0x2,%eax
80102f72:	8b 55 0c             	mov    0xc(%ebp),%edx
80102f75:	c1 ea 04             	shr    $0x4,%edx
80102f78:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102f7b:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80102f7f:	c1 e0 18             	shl    $0x18,%eax
80102f82:	50                   	push   %eax
80102f83:	68 c4 00 00 00       	push   $0xc4
80102f88:	e8 f7 fd ff ff       	call   80102d84 <lapicw>
80102f8d:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80102f90:	68 00 c5 00 00       	push   $0xc500
80102f95:	68 c0 00 00 00       	push   $0xc0
80102f9a:	e8 e5 fd ff ff       	call   80102d84 <lapicw>
80102f9f:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80102fa2:	68 c8 00 00 00       	push   $0xc8
80102fa7:	e8 88 ff ff ff       	call   80102f34 <microdelay>
80102fac:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
80102faf:	68 00 85 00 00       	push   $0x8500
80102fb4:	68 c0 00 00 00       	push   $0xc0
80102fb9:	e8 c6 fd ff ff       	call   80102d84 <lapicw>
80102fbe:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80102fc1:	6a 64                	push   $0x64
80102fc3:	e8 6c ff ff ff       	call   80102f34 <microdelay>
80102fc8:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80102fcb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80102fd2:	eb 3d                	jmp    80103011 <lapicstartap+0xd8>
    lapicw(ICRHI, apicid<<24);
80102fd4:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80102fd8:	c1 e0 18             	shl    $0x18,%eax
80102fdb:	50                   	push   %eax
80102fdc:	68 c4 00 00 00       	push   $0xc4
80102fe1:	e8 9e fd ff ff       	call   80102d84 <lapicw>
80102fe6:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
80102fe9:	8b 45 0c             	mov    0xc(%ebp),%eax
80102fec:	c1 e8 0c             	shr    $0xc,%eax
80102fef:	80 cc 06             	or     $0x6,%ah
80102ff2:	50                   	push   %eax
80102ff3:	68 c0 00 00 00       	push   $0xc0
80102ff8:	e8 87 fd ff ff       	call   80102d84 <lapicw>
80102ffd:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
80103000:	68 c8 00 00 00       	push   $0xc8
80103005:	e8 2a ff ff ff       	call   80102f34 <microdelay>
8010300a:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
8010300d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103011:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
80103015:	7e bd                	jle    80102fd4 <lapicstartap+0x9b>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80103017:	c9                   	leave  
80103018:	c3                   	ret    

80103019 <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
80103019:	55                   	push   %ebp
8010301a:	89 e5                	mov    %esp,%ebp
8010301c:	83 ec 18             	sub    $0x18,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
8010301f:	83 ec 08             	sub    $0x8,%esp
80103022:	68 6c 84 10 80       	push   $0x8010846c
80103027:	68 00 f9 10 80       	push   $0x8010f900
8010302c:	e8 18 1b 00 00       	call   80104b49 <initlock>
80103031:	83 c4 10             	add    $0x10,%esp
  readsb(ROOTDEV, &sb);
80103034:	83 ec 08             	sub    $0x8,%esp
80103037:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010303a:	50                   	push   %eax
8010303b:	6a 01                	push   $0x1
8010303d:	e8 f4 e2 ff ff       	call   80101336 <readsb>
80103042:	83 c4 10             	add    $0x10,%esp
  log.start = sb.size - sb.nlog;
80103045:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103048:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010304b:	29 c2                	sub    %eax,%edx
8010304d:	89 d0                	mov    %edx,%eax
8010304f:	a3 34 f9 10 80       	mov    %eax,0x8010f934
  log.size = sb.nlog;
80103054:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103057:	a3 38 f9 10 80       	mov    %eax,0x8010f938
  log.dev = ROOTDEV;
8010305c:	c7 05 40 f9 10 80 01 	movl   $0x1,0x8010f940
80103063:	00 00 00 
  recover_from_log();
80103066:	e8 ae 01 00 00       	call   80103219 <recover_from_log>
}
8010306b:	c9                   	leave  
8010306c:	c3                   	ret    

8010306d <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
8010306d:	55                   	push   %ebp
8010306e:	89 e5                	mov    %esp,%ebp
80103070:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103073:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010307a:	e9 95 00 00 00       	jmp    80103114 <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
8010307f:	8b 15 34 f9 10 80    	mov    0x8010f934,%edx
80103085:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103088:	01 d0                	add    %edx,%eax
8010308a:	83 c0 01             	add    $0x1,%eax
8010308d:	89 c2                	mov    %eax,%edx
8010308f:	a1 40 f9 10 80       	mov    0x8010f940,%eax
80103094:	83 ec 08             	sub    $0x8,%esp
80103097:	52                   	push   %edx
80103098:	50                   	push   %eax
80103099:	e8 16 d1 ff ff       	call   801001b4 <bread>
8010309e:	83 c4 10             	add    $0x10,%esp
801030a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
801030a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030a7:	83 c0 10             	add    $0x10,%eax
801030aa:	8b 04 85 08 f9 10 80 	mov    -0x7fef06f8(,%eax,4),%eax
801030b1:	89 c2                	mov    %eax,%edx
801030b3:	a1 40 f9 10 80       	mov    0x8010f940,%eax
801030b8:	83 ec 08             	sub    $0x8,%esp
801030bb:	52                   	push   %edx
801030bc:	50                   	push   %eax
801030bd:	e8 f2 d0 ff ff       	call   801001b4 <bread>
801030c2:	83 c4 10             	add    $0x10,%esp
801030c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801030c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801030cb:	8d 50 18             	lea    0x18(%eax),%edx
801030ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
801030d1:	83 c0 18             	add    $0x18,%eax
801030d4:	83 ec 04             	sub    $0x4,%esp
801030d7:	68 00 02 00 00       	push   $0x200
801030dc:	52                   	push   %edx
801030dd:	50                   	push   %eax
801030de:	e8 a2 1d 00 00       	call   80104e85 <memmove>
801030e3:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
801030e6:	83 ec 0c             	sub    $0xc,%esp
801030e9:	ff 75 ec             	pushl  -0x14(%ebp)
801030ec:	e8 fc d0 ff ff       	call   801001ed <bwrite>
801030f1:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf); 
801030f4:	83 ec 0c             	sub    $0xc,%esp
801030f7:	ff 75 f0             	pushl  -0x10(%ebp)
801030fa:	e8 2c d1 ff ff       	call   8010022b <brelse>
801030ff:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
80103102:	83 ec 0c             	sub    $0xc,%esp
80103105:	ff 75 ec             	pushl  -0x14(%ebp)
80103108:	e8 1e d1 ff ff       	call   8010022b <brelse>
8010310d:	83 c4 10             	add    $0x10,%esp
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103110:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103114:	a1 44 f9 10 80       	mov    0x8010f944,%eax
80103119:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010311c:	0f 8f 5d ff ff ff    	jg     8010307f <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
80103122:	c9                   	leave  
80103123:	c3                   	ret    

80103124 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
80103124:	55                   	push   %ebp
80103125:	89 e5                	mov    %esp,%ebp
80103127:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
8010312a:	a1 34 f9 10 80       	mov    0x8010f934,%eax
8010312f:	89 c2                	mov    %eax,%edx
80103131:	a1 40 f9 10 80       	mov    0x8010f940,%eax
80103136:	83 ec 08             	sub    $0x8,%esp
80103139:	52                   	push   %edx
8010313a:	50                   	push   %eax
8010313b:	e8 74 d0 ff ff       	call   801001b4 <bread>
80103140:	83 c4 10             	add    $0x10,%esp
80103143:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
80103146:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103149:	83 c0 18             	add    $0x18,%eax
8010314c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
8010314f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103152:	8b 00                	mov    (%eax),%eax
80103154:	a3 44 f9 10 80       	mov    %eax,0x8010f944
  for (i = 0; i < log.lh.n; i++) {
80103159:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103160:	eb 1b                	jmp    8010317d <read_head+0x59>
    log.lh.sector[i] = lh->sector[i];
80103162:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103165:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103168:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
8010316c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010316f:	83 c2 10             	add    $0x10,%edx
80103172:	89 04 95 08 f9 10 80 	mov    %eax,-0x7fef06f8(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80103179:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010317d:	a1 44 f9 10 80       	mov    0x8010f944,%eax
80103182:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103185:	7f db                	jg     80103162 <read_head+0x3e>
    log.lh.sector[i] = lh->sector[i];
  }
  brelse(buf);
80103187:	83 ec 0c             	sub    $0xc,%esp
8010318a:	ff 75 f0             	pushl  -0x10(%ebp)
8010318d:	e8 99 d0 ff ff       	call   8010022b <brelse>
80103192:	83 c4 10             	add    $0x10,%esp
}
80103195:	c9                   	leave  
80103196:	c3                   	ret    

80103197 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103197:	55                   	push   %ebp
80103198:	89 e5                	mov    %esp,%ebp
8010319a:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
8010319d:	a1 34 f9 10 80       	mov    0x8010f934,%eax
801031a2:	89 c2                	mov    %eax,%edx
801031a4:	a1 40 f9 10 80       	mov    0x8010f940,%eax
801031a9:	83 ec 08             	sub    $0x8,%esp
801031ac:	52                   	push   %edx
801031ad:	50                   	push   %eax
801031ae:	e8 01 d0 ff ff       	call   801001b4 <bread>
801031b3:	83 c4 10             	add    $0x10,%esp
801031b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
801031b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801031bc:	83 c0 18             	add    $0x18,%eax
801031bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
801031c2:	8b 15 44 f9 10 80    	mov    0x8010f944,%edx
801031c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801031cb:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
801031cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801031d4:	eb 1b                	jmp    801031f1 <write_head+0x5a>
    hb->sector[i] = log.lh.sector[i];
801031d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801031d9:	83 c0 10             	add    $0x10,%eax
801031dc:	8b 0c 85 08 f9 10 80 	mov    -0x7fef06f8(,%eax,4),%ecx
801031e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801031e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801031e9:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801031ed:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801031f1:	a1 44 f9 10 80       	mov    0x8010f944,%eax
801031f6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801031f9:	7f db                	jg     801031d6 <write_head+0x3f>
    hb->sector[i] = log.lh.sector[i];
  }
  bwrite(buf);
801031fb:	83 ec 0c             	sub    $0xc,%esp
801031fe:	ff 75 f0             	pushl  -0x10(%ebp)
80103201:	e8 e7 cf ff ff       	call   801001ed <bwrite>
80103206:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
80103209:	83 ec 0c             	sub    $0xc,%esp
8010320c:	ff 75 f0             	pushl  -0x10(%ebp)
8010320f:	e8 17 d0 ff ff       	call   8010022b <brelse>
80103214:	83 c4 10             	add    $0x10,%esp
}
80103217:	c9                   	leave  
80103218:	c3                   	ret    

80103219 <recover_from_log>:

static void
recover_from_log(void)
{
80103219:	55                   	push   %ebp
8010321a:	89 e5                	mov    %esp,%ebp
8010321c:	83 ec 08             	sub    $0x8,%esp
  read_head();      
8010321f:	e8 00 ff ff ff       	call   80103124 <read_head>
  install_trans(); // if committed, copy from log to disk
80103224:	e8 44 fe ff ff       	call   8010306d <install_trans>
  log.lh.n = 0;
80103229:	c7 05 44 f9 10 80 00 	movl   $0x0,0x8010f944
80103230:	00 00 00 
  write_head(); // clear the log
80103233:	e8 5f ff ff ff       	call   80103197 <write_head>
}
80103238:	c9                   	leave  
80103239:	c3                   	ret    

8010323a <begin_trans>:

void
begin_trans(void)
{
8010323a:	55                   	push   %ebp
8010323b:	89 e5                	mov    %esp,%ebp
8010323d:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
80103240:	83 ec 0c             	sub    $0xc,%esp
80103243:	68 00 f9 10 80       	push   $0x8010f900
80103248:	e8 1d 19 00 00       	call   80104b6a <acquire>
8010324d:	83 c4 10             	add    $0x10,%esp
  while (log.busy) {
80103250:	eb 15                	jmp    80103267 <begin_trans+0x2d>
    sleep(&log, &log.lock);
80103252:	83 ec 08             	sub    $0x8,%esp
80103255:	68 00 f9 10 80       	push   $0x8010f900
8010325a:	68 00 f9 10 80       	push   $0x8010f900
8010325f:	e8 04 16 00 00       	call   80104868 <sleep>
80103264:	83 c4 10             	add    $0x10,%esp

void
begin_trans(void)
{
  acquire(&log.lock);
  while (log.busy) {
80103267:	a1 3c f9 10 80       	mov    0x8010f93c,%eax
8010326c:	85 c0                	test   %eax,%eax
8010326e:	75 e2                	jne    80103252 <begin_trans+0x18>
    sleep(&log, &log.lock);
  }
  log.busy = 1;
80103270:	c7 05 3c f9 10 80 01 	movl   $0x1,0x8010f93c
80103277:	00 00 00 
  release(&log.lock);
8010327a:	83 ec 0c             	sub    $0xc,%esp
8010327d:	68 00 f9 10 80       	push   $0x8010f900
80103282:	e8 49 19 00 00       	call   80104bd0 <release>
80103287:	83 c4 10             	add    $0x10,%esp
}
8010328a:	c9                   	leave  
8010328b:	c3                   	ret    

8010328c <commit_trans>:

void
commit_trans(void)
{
8010328c:	55                   	push   %ebp
8010328d:	89 e5                	mov    %esp,%ebp
8010328f:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
80103292:	a1 44 f9 10 80       	mov    0x8010f944,%eax
80103297:	85 c0                	test   %eax,%eax
80103299:	7e 19                	jle    801032b4 <commit_trans+0x28>
    write_head();    // Write header to disk -- the real commit
8010329b:	e8 f7 fe ff ff       	call   80103197 <write_head>
    install_trans(); // Now install writes to home locations
801032a0:	e8 c8 fd ff ff       	call   8010306d <install_trans>
    log.lh.n = 0; 
801032a5:	c7 05 44 f9 10 80 00 	movl   $0x0,0x8010f944
801032ac:	00 00 00 
    write_head();    // Erase the transaction from the log
801032af:	e8 e3 fe ff ff       	call   80103197 <write_head>
  }
  
  acquire(&log.lock);
801032b4:	83 ec 0c             	sub    $0xc,%esp
801032b7:	68 00 f9 10 80       	push   $0x8010f900
801032bc:	e8 a9 18 00 00       	call   80104b6a <acquire>
801032c1:	83 c4 10             	add    $0x10,%esp
  log.busy = 0;
801032c4:	c7 05 3c f9 10 80 00 	movl   $0x0,0x8010f93c
801032cb:	00 00 00 
  wakeup(&log);
801032ce:	83 ec 0c             	sub    $0xc,%esp
801032d1:	68 00 f9 10 80       	push   $0x8010f900
801032d6:	e8 76 16 00 00       	call   80104951 <wakeup>
801032db:	83 c4 10             	add    $0x10,%esp
  release(&log.lock);
801032de:	83 ec 0c             	sub    $0xc,%esp
801032e1:	68 00 f9 10 80       	push   $0x8010f900
801032e6:	e8 e5 18 00 00       	call   80104bd0 <release>
801032eb:	83 c4 10             	add    $0x10,%esp
}
801032ee:	c9                   	leave  
801032ef:	c3                   	ret    

801032f0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801032f0:	55                   	push   %ebp
801032f1:	89 e5                	mov    %esp,%ebp
801032f3:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801032f6:	a1 44 f9 10 80       	mov    0x8010f944,%eax
801032fb:	83 f8 09             	cmp    $0x9,%eax
801032fe:	7f 12                	jg     80103312 <log_write+0x22>
80103300:	a1 44 f9 10 80       	mov    0x8010f944,%eax
80103305:	8b 15 38 f9 10 80    	mov    0x8010f938,%edx
8010330b:	83 ea 01             	sub    $0x1,%edx
8010330e:	39 d0                	cmp    %edx,%eax
80103310:	7c 0d                	jl     8010331f <log_write+0x2f>
    panic("too big a transaction");
80103312:	83 ec 0c             	sub    $0xc,%esp
80103315:	68 70 84 10 80       	push   $0x80108470
8010331a:	e8 3d d2 ff ff       	call   8010055c <panic>
  if (!log.busy)
8010331f:	a1 3c f9 10 80       	mov    0x8010f93c,%eax
80103324:	85 c0                	test   %eax,%eax
80103326:	75 0d                	jne    80103335 <log_write+0x45>
    panic("write outside of trans");
80103328:	83 ec 0c             	sub    $0xc,%esp
8010332b:	68 86 84 10 80       	push   $0x80108486
80103330:	e8 27 d2 ff ff       	call   8010055c <panic>

  for (i = 0; i < log.lh.n; i++) {
80103335:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010333c:	eb 1f                	jmp    8010335d <log_write+0x6d>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
8010333e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103341:	83 c0 10             	add    $0x10,%eax
80103344:	8b 04 85 08 f9 10 80 	mov    -0x7fef06f8(,%eax,4),%eax
8010334b:	89 c2                	mov    %eax,%edx
8010334d:	8b 45 08             	mov    0x8(%ebp),%eax
80103350:	8b 40 08             	mov    0x8(%eax),%eax
80103353:	39 c2                	cmp    %eax,%edx
80103355:	75 02                	jne    80103359 <log_write+0x69>
      break;
80103357:	eb 0e                	jmp    80103367 <log_write+0x77>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
  if (!log.busy)
    panic("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
80103359:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010335d:	a1 44 f9 10 80       	mov    0x8010f944,%eax
80103362:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103365:	7f d7                	jg     8010333e <log_write+0x4e>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
      break;
  }
  log.lh.sector[i] = b->sector;
80103367:	8b 45 08             	mov    0x8(%ebp),%eax
8010336a:	8b 40 08             	mov    0x8(%eax),%eax
8010336d:	89 c2                	mov    %eax,%edx
8010336f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103372:	83 c0 10             	add    $0x10,%eax
80103375:	89 14 85 08 f9 10 80 	mov    %edx,-0x7fef06f8(,%eax,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
8010337c:	8b 15 34 f9 10 80    	mov    0x8010f934,%edx
80103382:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103385:	01 d0                	add    %edx,%eax
80103387:	83 c0 01             	add    $0x1,%eax
8010338a:	89 c2                	mov    %eax,%edx
8010338c:	8b 45 08             	mov    0x8(%ebp),%eax
8010338f:	8b 40 04             	mov    0x4(%eax),%eax
80103392:	83 ec 08             	sub    $0x8,%esp
80103395:	52                   	push   %edx
80103396:	50                   	push   %eax
80103397:	e8 18 ce ff ff       	call   801001b4 <bread>
8010339c:	83 c4 10             	add    $0x10,%esp
8010339f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(lbuf->data, b->data, BSIZE);
801033a2:	8b 45 08             	mov    0x8(%ebp),%eax
801033a5:	8d 50 18             	lea    0x18(%eax),%edx
801033a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033ab:	83 c0 18             	add    $0x18,%eax
801033ae:	83 ec 04             	sub    $0x4,%esp
801033b1:	68 00 02 00 00       	push   $0x200
801033b6:	52                   	push   %edx
801033b7:	50                   	push   %eax
801033b8:	e8 c8 1a 00 00       	call   80104e85 <memmove>
801033bd:	83 c4 10             	add    $0x10,%esp
  bwrite(lbuf);
801033c0:	83 ec 0c             	sub    $0xc,%esp
801033c3:	ff 75 f0             	pushl  -0x10(%ebp)
801033c6:	e8 22 ce ff ff       	call   801001ed <bwrite>
801033cb:	83 c4 10             	add    $0x10,%esp
  brelse(lbuf);
801033ce:	83 ec 0c             	sub    $0xc,%esp
801033d1:	ff 75 f0             	pushl  -0x10(%ebp)
801033d4:	e8 52 ce ff ff       	call   8010022b <brelse>
801033d9:	83 c4 10             	add    $0x10,%esp
  if (i == log.lh.n)
801033dc:	a1 44 f9 10 80       	mov    0x8010f944,%eax
801033e1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801033e4:	75 0d                	jne    801033f3 <log_write+0x103>
    log.lh.n++;
801033e6:	a1 44 f9 10 80       	mov    0x8010f944,%eax
801033eb:	83 c0 01             	add    $0x1,%eax
801033ee:	a3 44 f9 10 80       	mov    %eax,0x8010f944
  b->flags |= B_DIRTY; // XXX prevent eviction
801033f3:	8b 45 08             	mov    0x8(%ebp),%eax
801033f6:	8b 00                	mov    (%eax),%eax
801033f8:	83 c8 04             	or     $0x4,%eax
801033fb:	89 c2                	mov    %eax,%edx
801033fd:	8b 45 08             	mov    0x8(%ebp),%eax
80103400:	89 10                	mov    %edx,(%eax)
}
80103402:	c9                   	leave  
80103403:	c3                   	ret    

80103404 <v2p>:
80103404:	55                   	push   %ebp
80103405:	89 e5                	mov    %esp,%ebp
80103407:	8b 45 08             	mov    0x8(%ebp),%eax
8010340a:	05 00 00 00 80       	add    $0x80000000,%eax
8010340f:	5d                   	pop    %ebp
80103410:	c3                   	ret    

80103411 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80103411:	55                   	push   %ebp
80103412:	89 e5                	mov    %esp,%ebp
80103414:	8b 45 08             	mov    0x8(%ebp),%eax
80103417:	05 00 00 00 80       	add    $0x80000000,%eax
8010341c:	5d                   	pop    %ebp
8010341d:	c3                   	ret    

8010341e <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
8010341e:	55                   	push   %ebp
8010341f:	89 e5                	mov    %esp,%ebp
80103421:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103424:	8b 55 08             	mov    0x8(%ebp),%edx
80103427:	8b 45 0c             	mov    0xc(%ebp),%eax
8010342a:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010342d:	f0 87 02             	lock xchg %eax,(%edx)
80103430:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80103433:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103436:	c9                   	leave  
80103437:	c3                   	ret    

80103438 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103438:	8d 4c 24 04          	lea    0x4(%esp),%ecx
8010343c:	83 e4 f0             	and    $0xfffffff0,%esp
8010343f:	ff 71 fc             	pushl  -0x4(%ecx)
80103442:	55                   	push   %ebp
80103443:	89 e5                	mov    %esp,%ebp
80103445:	51                   	push   %ecx
80103446:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103449:	83 ec 08             	sub    $0x8,%esp
8010344c:	68 00 00 40 80       	push   $0x80400000
80103451:	68 9c 27 11 80       	push   $0x8011279c
80103456:	e8 ef f5 ff ff       	call   80102a4a <kinit1>
8010345b:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
8010345e:	e8 a8 46 00 00       	call   80107b0b <kvmalloc>
  mpinit();        // collect info about this machine
80103463:	e8 45 04 00 00       	call   801038ad <mpinit>
  lapicinit();
80103468:	e8 38 f9 ff ff       	call   80102da5 <lapicinit>
  seginit();       // set up segments
8010346d:	e8 41 40 00 00       	call   801074b3 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
80103472:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103478:	0f b6 00             	movzbl (%eax),%eax
8010347b:	0f b6 c0             	movzbl %al,%eax
8010347e:	83 ec 08             	sub    $0x8,%esp
80103481:	50                   	push   %eax
80103482:	68 9d 84 10 80       	push   $0x8010849d
80103487:	e8 33 cf ff ff       	call   801003bf <cprintf>
8010348c:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
8010348f:	e8 6a 06 00 00       	call   80103afe <picinit>
  ioapicinit();    // another interrupt controller
80103494:	e8 a9 f4 ff ff       	call   80102942 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
80103499:	e8 45 d6 ff ff       	call   80100ae3 <consoleinit>
  uartinit();      // serial port
8010349e:	e8 73 33 00 00       	call   80106816 <uartinit>
  pinit();         // process table
801034a3:	e8 55 0b 00 00       	call   80103ffd <pinit>
  tvinit();        // trap vectors
801034a8:	e8 38 2f 00 00       	call   801063e5 <tvinit>
  binit();         // buffer cache
801034ad:	e8 82 cb ff ff       	call   80100034 <binit>
  fileinit();      // file table
801034b2:	e8 73 da ff ff       	call   80100f2a <fileinit>
  iinit();         // inode cache
801034b7:	e8 39 e1 ff ff       	call   801015f5 <iinit>
  ideinit();       // disk
801034bc:	e8 c9 f0 ff ff       	call   8010258a <ideinit>
  if(!ismp)
801034c1:	a1 84 f9 10 80       	mov    0x8010f984,%eax
801034c6:	85 c0                	test   %eax,%eax
801034c8:	75 05                	jne    801034cf <main+0x97>
    timerinit();   // uniprocessor timer
801034ca:	e8 75 2e 00 00       	call   80106344 <timerinit>
  startothers();   // start other processors
801034cf:	e8 7f 00 00 00       	call   80103553 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801034d4:	83 ec 08             	sub    $0x8,%esp
801034d7:	68 00 00 00 8e       	push   $0x8e000000
801034dc:	68 00 00 40 80       	push   $0x80400000
801034e1:	e8 9c f5 ff ff       	call   80102a82 <kinit2>
801034e6:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
801034e9:	e8 31 0c 00 00       	call   8010411f <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
801034ee:	e8 1a 00 00 00       	call   8010350d <mpmain>

801034f3 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801034f3:	55                   	push   %ebp
801034f4:	89 e5                	mov    %esp,%ebp
801034f6:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
801034f9:	e8 24 46 00 00       	call   80107b22 <switchkvm>
  seginit();
801034fe:	e8 b0 3f 00 00       	call   801074b3 <seginit>
  lapicinit();
80103503:	e8 9d f8 ff ff       	call   80102da5 <lapicinit>
  mpmain();
80103508:	e8 00 00 00 00       	call   8010350d <mpmain>

8010350d <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
8010350d:	55                   	push   %ebp
8010350e:	89 e5                	mov    %esp,%ebp
80103510:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
80103513:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103519:	0f b6 00             	movzbl (%eax),%eax
8010351c:	0f b6 c0             	movzbl %al,%eax
8010351f:	83 ec 08             	sub    $0x8,%esp
80103522:	50                   	push   %eax
80103523:	68 b4 84 10 80       	push   $0x801084b4
80103528:	e8 92 ce ff ff       	call   801003bf <cprintf>
8010352d:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
80103530:	e8 25 30 00 00       	call   8010655a <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103535:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010353b:	05 a8 00 00 00       	add    $0xa8,%eax
80103540:	83 ec 08             	sub    $0x8,%esp
80103543:	6a 01                	push   $0x1
80103545:	50                   	push   %eax
80103546:	e8 d3 fe ff ff       	call   8010341e <xchg>
8010354b:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
8010354e:	e8 4c 11 00 00       	call   8010469f <scheduler>

80103553 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103553:	55                   	push   %ebp
80103554:	89 e5                	mov    %esp,%ebp
80103556:	53                   	push   %ebx
80103557:	83 ec 14             	sub    $0x14,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
8010355a:	68 00 70 00 00       	push   $0x7000
8010355f:	e8 ad fe ff ff       	call   80103411 <p2v>
80103564:	83 c4 04             	add    $0x4,%esp
80103567:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
8010356a:	b8 8a 00 00 00       	mov    $0x8a,%eax
8010356f:	83 ec 04             	sub    $0x4,%esp
80103572:	50                   	push   %eax
80103573:	68 2c b5 10 80       	push   $0x8010b52c
80103578:	ff 75 f0             	pushl  -0x10(%ebp)
8010357b:	e8 05 19 00 00       	call   80104e85 <memmove>
80103580:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80103583:	c7 45 f4 c0 f9 10 80 	movl   $0x8010f9c0,-0xc(%ebp)
8010358a:	e9 8f 00 00 00       	jmp    8010361e <startothers+0xcb>
    if(c == cpus+cpunum())  // We've started already.
8010358f:	e8 2d f9 ff ff       	call   80102ec1 <cpunum>
80103594:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010359a:	05 c0 f9 10 80       	add    $0x8010f9c0,%eax
8010359f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801035a2:	75 02                	jne    801035a6 <startothers+0x53>
      continue;
801035a4:	eb 71                	jmp    80103617 <startothers+0xc4>

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801035a6:	e8 d2 f5 ff ff       	call   80102b7d <kalloc>
801035ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
801035ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
801035b1:	83 e8 04             	sub    $0x4,%eax
801035b4:	8b 55 ec             	mov    -0x14(%ebp),%edx
801035b7:	81 c2 00 10 00 00    	add    $0x1000,%edx
801035bd:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
801035bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
801035c2:	83 e8 08             	sub    $0x8,%eax
801035c5:	c7 00 f3 34 10 80    	movl   $0x801034f3,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
801035cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801035ce:	8d 58 f4             	lea    -0xc(%eax),%ebx
801035d1:	83 ec 0c             	sub    $0xc,%esp
801035d4:	68 00 a0 10 80       	push   $0x8010a000
801035d9:	e8 26 fe ff ff       	call   80103404 <v2p>
801035de:	83 c4 10             	add    $0x10,%esp
801035e1:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
801035e3:	83 ec 0c             	sub    $0xc,%esp
801035e6:	ff 75 f0             	pushl  -0x10(%ebp)
801035e9:	e8 16 fe ff ff       	call   80103404 <v2p>
801035ee:	83 c4 10             	add    $0x10,%esp
801035f1:	89 c2                	mov    %eax,%edx
801035f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801035f6:	0f b6 00             	movzbl (%eax),%eax
801035f9:	0f b6 c0             	movzbl %al,%eax
801035fc:	83 ec 08             	sub    $0x8,%esp
801035ff:	52                   	push   %edx
80103600:	50                   	push   %eax
80103601:	e8 33 f9 ff ff       	call   80102f39 <lapicstartap>
80103606:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103609:	90                   	nop
8010360a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010360d:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103613:	85 c0                	test   %eax,%eax
80103615:	74 f3                	je     8010360a <startothers+0xb7>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103617:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
8010361e:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
80103623:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103629:	05 c0 f9 10 80       	add    $0x8010f9c0,%eax
8010362e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103631:	0f 87 58 ff ff ff    	ja     8010358f <startothers+0x3c>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
80103637:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010363a:	c9                   	leave  
8010363b:	c3                   	ret    

8010363c <p2v>:
8010363c:	55                   	push   %ebp
8010363d:	89 e5                	mov    %esp,%ebp
8010363f:	8b 45 08             	mov    0x8(%ebp),%eax
80103642:	05 00 00 00 80       	add    $0x80000000,%eax
80103647:	5d                   	pop    %ebp
80103648:	c3                   	ret    

80103649 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80103649:	55                   	push   %ebp
8010364a:	89 e5                	mov    %esp,%ebp
8010364c:	83 ec 14             	sub    $0x14,%esp
8010364f:	8b 45 08             	mov    0x8(%ebp),%eax
80103652:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103656:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
8010365a:	89 c2                	mov    %eax,%edx
8010365c:	ec                   	in     (%dx),%al
8010365d:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103660:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103664:	c9                   	leave  
80103665:	c3                   	ret    

80103666 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103666:	55                   	push   %ebp
80103667:	89 e5                	mov    %esp,%ebp
80103669:	83 ec 08             	sub    $0x8,%esp
8010366c:	8b 55 08             	mov    0x8(%ebp),%edx
8010366f:	8b 45 0c             	mov    0xc(%ebp),%eax
80103672:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103676:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103679:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010367d:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103681:	ee                   	out    %al,(%dx)
}
80103682:	c9                   	leave  
80103683:	c3                   	ret    

80103684 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103684:	55                   	push   %ebp
80103685:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103687:	a1 64 b6 10 80       	mov    0x8010b664,%eax
8010368c:	89 c2                	mov    %eax,%edx
8010368e:	b8 c0 f9 10 80       	mov    $0x8010f9c0,%eax
80103693:	29 c2                	sub    %eax,%edx
80103695:	89 d0                	mov    %edx,%eax
80103697:	c1 f8 02             	sar    $0x2,%eax
8010369a:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
801036a0:	5d                   	pop    %ebp
801036a1:	c3                   	ret    

801036a2 <sum>:

static uchar
sum(uchar *addr, int len)
{
801036a2:	55                   	push   %ebp
801036a3:	89 e5                	mov    %esp,%ebp
801036a5:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
801036a8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
801036af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801036b6:	eb 15                	jmp    801036cd <sum+0x2b>
    sum += addr[i];
801036b8:	8b 55 fc             	mov    -0x4(%ebp),%edx
801036bb:	8b 45 08             	mov    0x8(%ebp),%eax
801036be:	01 d0                	add    %edx,%eax
801036c0:	0f b6 00             	movzbl (%eax),%eax
801036c3:	0f b6 c0             	movzbl %al,%eax
801036c6:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
801036c9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801036cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
801036d0:	3b 45 0c             	cmp    0xc(%ebp),%eax
801036d3:	7c e3                	jl     801036b8 <sum+0x16>
    sum += addr[i];
  return sum;
801036d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
801036d8:	c9                   	leave  
801036d9:	c3                   	ret    

801036da <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801036da:	55                   	push   %ebp
801036db:	89 e5                	mov    %esp,%ebp
801036dd:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
801036e0:	ff 75 08             	pushl  0x8(%ebp)
801036e3:	e8 54 ff ff ff       	call   8010363c <p2v>
801036e8:	83 c4 04             	add    $0x4,%esp
801036eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
801036ee:	8b 55 0c             	mov    0xc(%ebp),%edx
801036f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036f4:	01 d0                	add    %edx,%eax
801036f6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
801036f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
801036ff:	eb 36                	jmp    80103737 <mpsearch1+0x5d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103701:	83 ec 04             	sub    $0x4,%esp
80103704:	6a 04                	push   $0x4
80103706:	68 c8 84 10 80       	push   $0x801084c8
8010370b:	ff 75 f4             	pushl  -0xc(%ebp)
8010370e:	e8 1a 17 00 00       	call   80104e2d <memcmp>
80103713:	83 c4 10             	add    $0x10,%esp
80103716:	85 c0                	test   %eax,%eax
80103718:	75 19                	jne    80103733 <mpsearch1+0x59>
8010371a:	83 ec 08             	sub    $0x8,%esp
8010371d:	6a 10                	push   $0x10
8010371f:	ff 75 f4             	pushl  -0xc(%ebp)
80103722:	e8 7b ff ff ff       	call   801036a2 <sum>
80103727:	83 c4 10             	add    $0x10,%esp
8010372a:	84 c0                	test   %al,%al
8010372c:	75 05                	jne    80103733 <mpsearch1+0x59>
      return (struct mp*)p;
8010372e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103731:	eb 11                	jmp    80103744 <mpsearch1+0x6a>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103733:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103737:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010373a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010373d:	72 c2                	jb     80103701 <mpsearch1+0x27>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
8010373f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103744:	c9                   	leave  
80103745:	c3                   	ret    

80103746 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103746:	55                   	push   %ebp
80103747:	89 e5                	mov    %esp,%ebp
80103749:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
8010374c:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103753:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103756:	83 c0 0f             	add    $0xf,%eax
80103759:	0f b6 00             	movzbl (%eax),%eax
8010375c:	0f b6 c0             	movzbl %al,%eax
8010375f:	c1 e0 08             	shl    $0x8,%eax
80103762:	89 c2                	mov    %eax,%edx
80103764:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103767:	83 c0 0e             	add    $0xe,%eax
8010376a:	0f b6 00             	movzbl (%eax),%eax
8010376d:	0f b6 c0             	movzbl %al,%eax
80103770:	09 d0                	or     %edx,%eax
80103772:	c1 e0 04             	shl    $0x4,%eax
80103775:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103778:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010377c:	74 21                	je     8010379f <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
8010377e:	83 ec 08             	sub    $0x8,%esp
80103781:	68 00 04 00 00       	push   $0x400
80103786:	ff 75 f0             	pushl  -0x10(%ebp)
80103789:	e8 4c ff ff ff       	call   801036da <mpsearch1>
8010378e:	83 c4 10             	add    $0x10,%esp
80103791:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103794:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103798:	74 51                	je     801037eb <mpsearch+0xa5>
      return mp;
8010379a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010379d:	eb 61                	jmp    80103800 <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
8010379f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037a2:	83 c0 14             	add    $0x14,%eax
801037a5:	0f b6 00             	movzbl (%eax),%eax
801037a8:	0f b6 c0             	movzbl %al,%eax
801037ab:	c1 e0 08             	shl    $0x8,%eax
801037ae:	89 c2                	mov    %eax,%edx
801037b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037b3:	83 c0 13             	add    $0x13,%eax
801037b6:	0f b6 00             	movzbl (%eax),%eax
801037b9:	0f b6 c0             	movzbl %al,%eax
801037bc:	09 d0                	or     %edx,%eax
801037be:	c1 e0 0a             	shl    $0xa,%eax
801037c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
801037c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801037c7:	2d 00 04 00 00       	sub    $0x400,%eax
801037cc:	83 ec 08             	sub    $0x8,%esp
801037cf:	68 00 04 00 00       	push   $0x400
801037d4:	50                   	push   %eax
801037d5:	e8 00 ff ff ff       	call   801036da <mpsearch1>
801037da:	83 c4 10             	add    $0x10,%esp
801037dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
801037e0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801037e4:	74 05                	je     801037eb <mpsearch+0xa5>
      return mp;
801037e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801037e9:	eb 15                	jmp    80103800 <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
801037eb:	83 ec 08             	sub    $0x8,%esp
801037ee:	68 00 00 01 00       	push   $0x10000
801037f3:	68 00 00 0f 00       	push   $0xf0000
801037f8:	e8 dd fe ff ff       	call   801036da <mpsearch1>
801037fd:	83 c4 10             	add    $0x10,%esp
}
80103800:	c9                   	leave  
80103801:	c3                   	ret    

80103802 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103802:	55                   	push   %ebp
80103803:	89 e5                	mov    %esp,%ebp
80103805:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103808:	e8 39 ff ff ff       	call   80103746 <mpsearch>
8010380d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103810:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103814:	74 0a                	je     80103820 <mpconfig+0x1e>
80103816:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103819:	8b 40 04             	mov    0x4(%eax),%eax
8010381c:	85 c0                	test   %eax,%eax
8010381e:	75 0a                	jne    8010382a <mpconfig+0x28>
    return 0;
80103820:	b8 00 00 00 00       	mov    $0x0,%eax
80103825:	e9 81 00 00 00       	jmp    801038ab <mpconfig+0xa9>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
8010382a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010382d:	8b 40 04             	mov    0x4(%eax),%eax
80103830:	83 ec 0c             	sub    $0xc,%esp
80103833:	50                   	push   %eax
80103834:	e8 03 fe ff ff       	call   8010363c <p2v>
80103839:	83 c4 10             	add    $0x10,%esp
8010383c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010383f:	83 ec 04             	sub    $0x4,%esp
80103842:	6a 04                	push   $0x4
80103844:	68 cd 84 10 80       	push   $0x801084cd
80103849:	ff 75 f0             	pushl  -0x10(%ebp)
8010384c:	e8 dc 15 00 00       	call   80104e2d <memcmp>
80103851:	83 c4 10             	add    $0x10,%esp
80103854:	85 c0                	test   %eax,%eax
80103856:	74 07                	je     8010385f <mpconfig+0x5d>
    return 0;
80103858:	b8 00 00 00 00       	mov    $0x0,%eax
8010385d:	eb 4c                	jmp    801038ab <mpconfig+0xa9>
  if(conf->version != 1 && conf->version != 4)
8010385f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103862:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103866:	3c 01                	cmp    $0x1,%al
80103868:	74 12                	je     8010387c <mpconfig+0x7a>
8010386a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010386d:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103871:	3c 04                	cmp    $0x4,%al
80103873:	74 07                	je     8010387c <mpconfig+0x7a>
    return 0;
80103875:	b8 00 00 00 00       	mov    $0x0,%eax
8010387a:	eb 2f                	jmp    801038ab <mpconfig+0xa9>
  if(sum((uchar*)conf, conf->length) != 0)
8010387c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010387f:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103883:	0f b7 c0             	movzwl %ax,%eax
80103886:	83 ec 08             	sub    $0x8,%esp
80103889:	50                   	push   %eax
8010388a:	ff 75 f0             	pushl  -0x10(%ebp)
8010388d:	e8 10 fe ff ff       	call   801036a2 <sum>
80103892:	83 c4 10             	add    $0x10,%esp
80103895:	84 c0                	test   %al,%al
80103897:	74 07                	je     801038a0 <mpconfig+0x9e>
    return 0;
80103899:	b8 00 00 00 00       	mov    $0x0,%eax
8010389e:	eb 0b                	jmp    801038ab <mpconfig+0xa9>
  *pmp = mp;
801038a0:	8b 45 08             	mov    0x8(%ebp),%eax
801038a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801038a6:	89 10                	mov    %edx,(%eax)
  return conf;
801038a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
801038ab:	c9                   	leave  
801038ac:	c3                   	ret    

801038ad <mpinit>:

void
mpinit(void)
{
801038ad:	55                   	push   %ebp
801038ae:	89 e5                	mov    %esp,%ebp
801038b0:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
801038b3:	c7 05 64 b6 10 80 c0 	movl   $0x8010f9c0,0x8010b664
801038ba:	f9 10 80 
  if((conf = mpconfig(&mp)) == 0)
801038bd:	83 ec 0c             	sub    $0xc,%esp
801038c0:	8d 45 e0             	lea    -0x20(%ebp),%eax
801038c3:	50                   	push   %eax
801038c4:	e8 39 ff ff ff       	call   80103802 <mpconfig>
801038c9:	83 c4 10             	add    $0x10,%esp
801038cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
801038cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801038d3:	75 05                	jne    801038da <mpinit+0x2d>
    return;
801038d5:	e9 94 01 00 00       	jmp    80103a6e <mpinit+0x1c1>
  ismp = 1;
801038da:	c7 05 84 f9 10 80 01 	movl   $0x1,0x8010f984
801038e1:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
801038e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038e7:	8b 40 24             	mov    0x24(%eax),%eax
801038ea:	a3 dc f8 10 80       	mov    %eax,0x8010f8dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801038ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038f2:	83 c0 2c             	add    $0x2c,%eax
801038f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801038f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038fb:	0f b7 40 04          	movzwl 0x4(%eax),%eax
801038ff:	0f b7 d0             	movzwl %ax,%edx
80103902:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103905:	01 d0                	add    %edx,%eax
80103907:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010390a:	e9 f2 00 00 00       	jmp    80103a01 <mpinit+0x154>
    switch(*p){
8010390f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103912:	0f b6 00             	movzbl (%eax),%eax
80103915:	0f b6 c0             	movzbl %al,%eax
80103918:	83 f8 04             	cmp    $0x4,%eax
8010391b:	0f 87 bc 00 00 00    	ja     801039dd <mpinit+0x130>
80103921:	8b 04 85 10 85 10 80 	mov    -0x7fef7af0(,%eax,4),%eax
80103928:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
8010392a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010392d:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103930:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103933:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103937:	0f b6 d0             	movzbl %al,%edx
8010393a:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
8010393f:	39 c2                	cmp    %eax,%edx
80103941:	74 2b                	je     8010396e <mpinit+0xc1>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103943:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103946:	0f b6 40 01          	movzbl 0x1(%eax),%eax
8010394a:	0f b6 d0             	movzbl %al,%edx
8010394d:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
80103952:	83 ec 04             	sub    $0x4,%esp
80103955:	52                   	push   %edx
80103956:	50                   	push   %eax
80103957:	68 d2 84 10 80       	push   $0x801084d2
8010395c:	e8 5e ca ff ff       	call   801003bf <cprintf>
80103961:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
80103964:	c7 05 84 f9 10 80 00 	movl   $0x0,0x8010f984
8010396b:	00 00 00 
      }
      if(proc->flags & MPBOOT)
8010396e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103971:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103975:	0f b6 c0             	movzbl %al,%eax
80103978:	83 e0 02             	and    $0x2,%eax
8010397b:	85 c0                	test   %eax,%eax
8010397d:	74 15                	je     80103994 <mpinit+0xe7>
        bcpu = &cpus[ncpu];
8010397f:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
80103984:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010398a:	05 c0 f9 10 80       	add    $0x8010f9c0,%eax
8010398f:	a3 64 b6 10 80       	mov    %eax,0x8010b664
      cpus[ncpu].id = ncpu;
80103994:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
80103999:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
8010399f:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801039a5:	05 c0 f9 10 80       	add    $0x8010f9c0,%eax
801039aa:	88 10                	mov    %dl,(%eax)
      ncpu++;
801039ac:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801039b1:	83 c0 01             	add    $0x1,%eax
801039b4:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
      p += sizeof(struct mpproc);
801039b9:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
801039bd:	eb 42                	jmp    80103a01 <mpinit+0x154>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
801039bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801039c2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
801039c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801039c8:	0f b6 40 01          	movzbl 0x1(%eax),%eax
801039cc:	a2 80 f9 10 80       	mov    %al,0x8010f980
      p += sizeof(struct mpioapic);
801039d1:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
801039d5:	eb 2a                	jmp    80103a01 <mpinit+0x154>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801039d7:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
801039db:	eb 24                	jmp    80103a01 <mpinit+0x154>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
801039dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801039e0:	0f b6 00             	movzbl (%eax),%eax
801039e3:	0f b6 c0             	movzbl %al,%eax
801039e6:	83 ec 08             	sub    $0x8,%esp
801039e9:	50                   	push   %eax
801039ea:	68 f0 84 10 80       	push   $0x801084f0
801039ef:	e8 cb c9 ff ff       	call   801003bf <cprintf>
801039f4:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
801039f7:	c7 05 84 f9 10 80 00 	movl   $0x0,0x8010f984
801039fe:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103a01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a04:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103a07:	0f 82 02 ff ff ff    	jb     8010390f <mpinit+0x62>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103a0d:	a1 84 f9 10 80       	mov    0x8010f984,%eax
80103a12:	85 c0                	test   %eax,%eax
80103a14:	75 1d                	jne    80103a33 <mpinit+0x186>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103a16:	c7 05 a0 ff 10 80 01 	movl   $0x1,0x8010ffa0
80103a1d:	00 00 00 
    lapic = 0;
80103a20:	c7 05 dc f8 10 80 00 	movl   $0x0,0x8010f8dc
80103a27:	00 00 00 
    ioapicid = 0;
80103a2a:	c6 05 80 f9 10 80 00 	movb   $0x0,0x8010f980
    return;
80103a31:	eb 3b                	jmp    80103a6e <mpinit+0x1c1>
  }

  if(mp->imcrp){
80103a33:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103a36:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103a3a:	84 c0                	test   %al,%al
80103a3c:	74 30                	je     80103a6e <mpinit+0x1c1>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103a3e:	83 ec 08             	sub    $0x8,%esp
80103a41:	6a 70                	push   $0x70
80103a43:	6a 22                	push   $0x22
80103a45:	e8 1c fc ff ff       	call   80103666 <outb>
80103a4a:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103a4d:	83 ec 0c             	sub    $0xc,%esp
80103a50:	6a 23                	push   $0x23
80103a52:	e8 f2 fb ff ff       	call   80103649 <inb>
80103a57:	83 c4 10             	add    $0x10,%esp
80103a5a:	83 c8 01             	or     $0x1,%eax
80103a5d:	0f b6 c0             	movzbl %al,%eax
80103a60:	83 ec 08             	sub    $0x8,%esp
80103a63:	50                   	push   %eax
80103a64:	6a 23                	push   $0x23
80103a66:	e8 fb fb ff ff       	call   80103666 <outb>
80103a6b:	83 c4 10             	add    $0x10,%esp
  }
}
80103a6e:	c9                   	leave  
80103a6f:	c3                   	ret    

80103a70 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103a70:	55                   	push   %ebp
80103a71:	89 e5                	mov    %esp,%ebp
80103a73:	83 ec 08             	sub    $0x8,%esp
80103a76:	8b 55 08             	mov    0x8(%ebp),%edx
80103a79:	8b 45 0c             	mov    0xc(%ebp),%eax
80103a7c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103a80:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103a83:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103a87:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103a8b:	ee                   	out    %al,(%dx)
}
80103a8c:	c9                   	leave  
80103a8d:	c3                   	ret    

80103a8e <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103a8e:	55                   	push   %ebp
80103a8f:	89 e5                	mov    %esp,%ebp
80103a91:	83 ec 04             	sub    $0x4,%esp
80103a94:	8b 45 08             	mov    0x8(%ebp),%eax
80103a97:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103a9b:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103a9f:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
  outb(IO_PIC1+1, mask);
80103aa5:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103aa9:	0f b6 c0             	movzbl %al,%eax
80103aac:	50                   	push   %eax
80103aad:	6a 21                	push   $0x21
80103aaf:	e8 bc ff ff ff       	call   80103a70 <outb>
80103ab4:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80103ab7:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103abb:	66 c1 e8 08          	shr    $0x8,%ax
80103abf:	0f b6 c0             	movzbl %al,%eax
80103ac2:	50                   	push   %eax
80103ac3:	68 a1 00 00 00       	push   $0xa1
80103ac8:	e8 a3 ff ff ff       	call   80103a70 <outb>
80103acd:	83 c4 08             	add    $0x8,%esp
}
80103ad0:	c9                   	leave  
80103ad1:	c3                   	ret    

80103ad2 <picenable>:

void
picenable(int irq)
{
80103ad2:	55                   	push   %ebp
80103ad3:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80103ad5:	8b 45 08             	mov    0x8(%ebp),%eax
80103ad8:	ba 01 00 00 00       	mov    $0x1,%edx
80103add:	89 c1                	mov    %eax,%ecx
80103adf:	d3 e2                	shl    %cl,%edx
80103ae1:	89 d0                	mov    %edx,%eax
80103ae3:	f7 d0                	not    %eax
80103ae5:	89 c2                	mov    %eax,%edx
80103ae7:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103aee:	21 d0                	and    %edx,%eax
80103af0:	0f b7 c0             	movzwl %ax,%eax
80103af3:	50                   	push   %eax
80103af4:	e8 95 ff ff ff       	call   80103a8e <picsetmask>
80103af9:	83 c4 04             	add    $0x4,%esp
}
80103afc:	c9                   	leave  
80103afd:	c3                   	ret    

80103afe <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103afe:	55                   	push   %ebp
80103aff:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103b01:	68 ff 00 00 00       	push   $0xff
80103b06:	6a 21                	push   $0x21
80103b08:	e8 63 ff ff ff       	call   80103a70 <outb>
80103b0d:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80103b10:	68 ff 00 00 00       	push   $0xff
80103b15:	68 a1 00 00 00       	push   $0xa1
80103b1a:	e8 51 ff ff ff       	call   80103a70 <outb>
80103b1f:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103b22:	6a 11                	push   $0x11
80103b24:	6a 20                	push   $0x20
80103b26:	e8 45 ff ff ff       	call   80103a70 <outb>
80103b2b:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103b2e:	6a 20                	push   $0x20
80103b30:	6a 21                	push   $0x21
80103b32:	e8 39 ff ff ff       	call   80103a70 <outb>
80103b37:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103b3a:	6a 04                	push   $0x4
80103b3c:	6a 21                	push   $0x21
80103b3e:	e8 2d ff ff ff       	call   80103a70 <outb>
80103b43:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103b46:	6a 03                	push   $0x3
80103b48:	6a 21                	push   $0x21
80103b4a:	e8 21 ff ff ff       	call   80103a70 <outb>
80103b4f:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103b52:	6a 11                	push   $0x11
80103b54:	68 a0 00 00 00       	push   $0xa0
80103b59:	e8 12 ff ff ff       	call   80103a70 <outb>
80103b5e:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103b61:	6a 28                	push   $0x28
80103b63:	68 a1 00 00 00       	push   $0xa1
80103b68:	e8 03 ff ff ff       	call   80103a70 <outb>
80103b6d:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103b70:	6a 02                	push   $0x2
80103b72:	68 a1 00 00 00       	push   $0xa1
80103b77:	e8 f4 fe ff ff       	call   80103a70 <outb>
80103b7c:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103b7f:	6a 03                	push   $0x3
80103b81:	68 a1 00 00 00       	push   $0xa1
80103b86:	e8 e5 fe ff ff       	call   80103a70 <outb>
80103b8b:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103b8e:	6a 68                	push   $0x68
80103b90:	6a 20                	push   $0x20
80103b92:	e8 d9 fe ff ff       	call   80103a70 <outb>
80103b97:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103b9a:	6a 0a                	push   $0xa
80103b9c:	6a 20                	push   $0x20
80103b9e:	e8 cd fe ff ff       	call   80103a70 <outb>
80103ba3:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
80103ba6:	6a 68                	push   $0x68
80103ba8:	68 a0 00 00 00       	push   $0xa0
80103bad:	e8 be fe ff ff       	call   80103a70 <outb>
80103bb2:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
80103bb5:	6a 0a                	push   $0xa
80103bb7:	68 a0 00 00 00       	push   $0xa0
80103bbc:	e8 af fe ff ff       	call   80103a70 <outb>
80103bc1:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
80103bc4:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103bcb:	66 83 f8 ff          	cmp    $0xffff,%ax
80103bcf:	74 13                	je     80103be4 <picinit+0xe6>
    picsetmask(irqmask);
80103bd1:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103bd8:	0f b7 c0             	movzwl %ax,%eax
80103bdb:	50                   	push   %eax
80103bdc:	e8 ad fe ff ff       	call   80103a8e <picsetmask>
80103be1:	83 c4 04             	add    $0x4,%esp
}
80103be4:	c9                   	leave  
80103be5:	c3                   	ret    

80103be6 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103be6:	55                   	push   %ebp
80103be7:	89 e5                	mov    %esp,%ebp
80103be9:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80103bec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103bf3:	8b 45 0c             	mov    0xc(%ebp),%eax
80103bf6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103bfc:	8b 45 0c             	mov    0xc(%ebp),%eax
80103bff:	8b 10                	mov    (%eax),%edx
80103c01:	8b 45 08             	mov    0x8(%ebp),%eax
80103c04:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103c06:	e8 3c d3 ff ff       	call   80100f47 <filealloc>
80103c0b:	89 c2                	mov    %eax,%edx
80103c0d:	8b 45 08             	mov    0x8(%ebp),%eax
80103c10:	89 10                	mov    %edx,(%eax)
80103c12:	8b 45 08             	mov    0x8(%ebp),%eax
80103c15:	8b 00                	mov    (%eax),%eax
80103c17:	85 c0                	test   %eax,%eax
80103c19:	0f 84 cb 00 00 00    	je     80103cea <pipealloc+0x104>
80103c1f:	e8 23 d3 ff ff       	call   80100f47 <filealloc>
80103c24:	89 c2                	mov    %eax,%edx
80103c26:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c29:	89 10                	mov    %edx,(%eax)
80103c2b:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c2e:	8b 00                	mov    (%eax),%eax
80103c30:	85 c0                	test   %eax,%eax
80103c32:	0f 84 b2 00 00 00    	je     80103cea <pipealloc+0x104>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103c38:	e8 40 ef ff ff       	call   80102b7d <kalloc>
80103c3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c40:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103c44:	75 05                	jne    80103c4b <pipealloc+0x65>
    goto bad;
80103c46:	e9 9f 00 00 00       	jmp    80103cea <pipealloc+0x104>
  p->readopen = 1;
80103c4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c4e:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103c55:	00 00 00 
  p->writeopen = 1;
80103c58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c5b:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103c62:	00 00 00 
  p->nwrite = 0;
80103c65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c68:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103c6f:	00 00 00 
  p->nread = 0;
80103c72:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c75:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103c7c:	00 00 00 
  initlock(&p->lock, "pipe");
80103c7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c82:	83 ec 08             	sub    $0x8,%esp
80103c85:	68 24 85 10 80       	push   $0x80108524
80103c8a:	50                   	push   %eax
80103c8b:	e8 b9 0e 00 00       	call   80104b49 <initlock>
80103c90:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103c93:	8b 45 08             	mov    0x8(%ebp),%eax
80103c96:	8b 00                	mov    (%eax),%eax
80103c98:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103c9e:	8b 45 08             	mov    0x8(%ebp),%eax
80103ca1:	8b 00                	mov    (%eax),%eax
80103ca3:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103ca7:	8b 45 08             	mov    0x8(%ebp),%eax
80103caa:	8b 00                	mov    (%eax),%eax
80103cac:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103cb0:	8b 45 08             	mov    0x8(%ebp),%eax
80103cb3:	8b 00                	mov    (%eax),%eax
80103cb5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103cb8:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103cbb:	8b 45 0c             	mov    0xc(%ebp),%eax
80103cbe:	8b 00                	mov    (%eax),%eax
80103cc0:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103cc6:	8b 45 0c             	mov    0xc(%ebp),%eax
80103cc9:	8b 00                	mov    (%eax),%eax
80103ccb:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103ccf:	8b 45 0c             	mov    0xc(%ebp),%eax
80103cd2:	8b 00                	mov    (%eax),%eax
80103cd4:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103cd8:	8b 45 0c             	mov    0xc(%ebp),%eax
80103cdb:	8b 00                	mov    (%eax),%eax
80103cdd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103ce0:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80103ce3:	b8 00 00 00 00       	mov    $0x0,%eax
80103ce8:	eb 4d                	jmp    80103d37 <pipealloc+0x151>

//PAGEBREAK: 20
 bad:
  if(p)
80103cea:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103cee:	74 0e                	je     80103cfe <pipealloc+0x118>
    kfree((char*)p);
80103cf0:	83 ec 0c             	sub    $0xc,%esp
80103cf3:	ff 75 f4             	pushl  -0xc(%ebp)
80103cf6:	e8 e6 ed ff ff       	call   80102ae1 <kfree>
80103cfb:	83 c4 10             	add    $0x10,%esp
  if(*f0)
80103cfe:	8b 45 08             	mov    0x8(%ebp),%eax
80103d01:	8b 00                	mov    (%eax),%eax
80103d03:	85 c0                	test   %eax,%eax
80103d05:	74 11                	je     80103d18 <pipealloc+0x132>
    fileclose(*f0);
80103d07:	8b 45 08             	mov    0x8(%ebp),%eax
80103d0a:	8b 00                	mov    (%eax),%eax
80103d0c:	83 ec 0c             	sub    $0xc,%esp
80103d0f:	50                   	push   %eax
80103d10:	e8 ef d2 ff ff       	call   80101004 <fileclose>
80103d15:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103d18:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d1b:	8b 00                	mov    (%eax),%eax
80103d1d:	85 c0                	test   %eax,%eax
80103d1f:	74 11                	je     80103d32 <pipealloc+0x14c>
    fileclose(*f1);
80103d21:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d24:	8b 00                	mov    (%eax),%eax
80103d26:	83 ec 0c             	sub    $0xc,%esp
80103d29:	50                   	push   %eax
80103d2a:	e8 d5 d2 ff ff       	call   80101004 <fileclose>
80103d2f:	83 c4 10             	add    $0x10,%esp
  return -1;
80103d32:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103d37:	c9                   	leave  
80103d38:	c3                   	ret    

80103d39 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103d39:	55                   	push   %ebp
80103d3a:	89 e5                	mov    %esp,%ebp
80103d3c:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
80103d3f:	8b 45 08             	mov    0x8(%ebp),%eax
80103d42:	83 ec 0c             	sub    $0xc,%esp
80103d45:	50                   	push   %eax
80103d46:	e8 1f 0e 00 00       	call   80104b6a <acquire>
80103d4b:	83 c4 10             	add    $0x10,%esp
  if(writable){
80103d4e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80103d52:	74 23                	je     80103d77 <pipeclose+0x3e>
    p->writeopen = 0;
80103d54:	8b 45 08             	mov    0x8(%ebp),%eax
80103d57:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80103d5e:	00 00 00 
    wakeup(&p->nread);
80103d61:	8b 45 08             	mov    0x8(%ebp),%eax
80103d64:	05 34 02 00 00       	add    $0x234,%eax
80103d69:	83 ec 0c             	sub    $0xc,%esp
80103d6c:	50                   	push   %eax
80103d6d:	e8 df 0b 00 00       	call   80104951 <wakeup>
80103d72:	83 c4 10             	add    $0x10,%esp
80103d75:	eb 21                	jmp    80103d98 <pipeclose+0x5f>
  } else {
    p->readopen = 0;
80103d77:	8b 45 08             	mov    0x8(%ebp),%eax
80103d7a:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80103d81:	00 00 00 
    wakeup(&p->nwrite);
80103d84:	8b 45 08             	mov    0x8(%ebp),%eax
80103d87:	05 38 02 00 00       	add    $0x238,%eax
80103d8c:	83 ec 0c             	sub    $0xc,%esp
80103d8f:	50                   	push   %eax
80103d90:	e8 bc 0b 00 00       	call   80104951 <wakeup>
80103d95:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103d98:	8b 45 08             	mov    0x8(%ebp),%eax
80103d9b:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80103da1:	85 c0                	test   %eax,%eax
80103da3:	75 2c                	jne    80103dd1 <pipeclose+0x98>
80103da5:	8b 45 08             	mov    0x8(%ebp),%eax
80103da8:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80103dae:	85 c0                	test   %eax,%eax
80103db0:	75 1f                	jne    80103dd1 <pipeclose+0x98>
    release(&p->lock);
80103db2:	8b 45 08             	mov    0x8(%ebp),%eax
80103db5:	83 ec 0c             	sub    $0xc,%esp
80103db8:	50                   	push   %eax
80103db9:	e8 12 0e 00 00       	call   80104bd0 <release>
80103dbe:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
80103dc1:	83 ec 0c             	sub    $0xc,%esp
80103dc4:	ff 75 08             	pushl  0x8(%ebp)
80103dc7:	e8 15 ed ff ff       	call   80102ae1 <kfree>
80103dcc:	83 c4 10             	add    $0x10,%esp
80103dcf:	eb 0f                	jmp    80103de0 <pipeclose+0xa7>
  } else
    release(&p->lock);
80103dd1:	8b 45 08             	mov    0x8(%ebp),%eax
80103dd4:	83 ec 0c             	sub    $0xc,%esp
80103dd7:	50                   	push   %eax
80103dd8:	e8 f3 0d 00 00       	call   80104bd0 <release>
80103ddd:	83 c4 10             	add    $0x10,%esp
}
80103de0:	c9                   	leave  
80103de1:	c3                   	ret    

80103de2 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103de2:	55                   	push   %ebp
80103de3:	89 e5                	mov    %esp,%ebp
80103de5:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
80103de8:	8b 45 08             	mov    0x8(%ebp),%eax
80103deb:	83 ec 0c             	sub    $0xc,%esp
80103dee:	50                   	push   %eax
80103def:	e8 76 0d 00 00       	call   80104b6a <acquire>
80103df4:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
80103df7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103dfe:	e9 af 00 00 00       	jmp    80103eb2 <pipewrite+0xd0>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103e03:	eb 60                	jmp    80103e65 <pipewrite+0x83>
      if(p->readopen == 0 || proc->killed){
80103e05:	8b 45 08             	mov    0x8(%ebp),%eax
80103e08:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80103e0e:	85 c0                	test   %eax,%eax
80103e10:	74 0d                	je     80103e1f <pipewrite+0x3d>
80103e12:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e18:	8b 40 24             	mov    0x24(%eax),%eax
80103e1b:	85 c0                	test   %eax,%eax
80103e1d:	74 19                	je     80103e38 <pipewrite+0x56>
        release(&p->lock);
80103e1f:	8b 45 08             	mov    0x8(%ebp),%eax
80103e22:	83 ec 0c             	sub    $0xc,%esp
80103e25:	50                   	push   %eax
80103e26:	e8 a5 0d 00 00       	call   80104bd0 <release>
80103e2b:	83 c4 10             	add    $0x10,%esp
        return -1;
80103e2e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e33:	e9 ac 00 00 00       	jmp    80103ee4 <pipewrite+0x102>
      }
      wakeup(&p->nread);
80103e38:	8b 45 08             	mov    0x8(%ebp),%eax
80103e3b:	05 34 02 00 00       	add    $0x234,%eax
80103e40:	83 ec 0c             	sub    $0xc,%esp
80103e43:	50                   	push   %eax
80103e44:	e8 08 0b 00 00       	call   80104951 <wakeup>
80103e49:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103e4c:	8b 45 08             	mov    0x8(%ebp),%eax
80103e4f:	8b 55 08             	mov    0x8(%ebp),%edx
80103e52:	81 c2 38 02 00 00    	add    $0x238,%edx
80103e58:	83 ec 08             	sub    $0x8,%esp
80103e5b:	50                   	push   %eax
80103e5c:	52                   	push   %edx
80103e5d:	e8 06 0a 00 00       	call   80104868 <sleep>
80103e62:	83 c4 10             	add    $0x10,%esp
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103e65:	8b 45 08             	mov    0x8(%ebp),%eax
80103e68:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80103e6e:	8b 45 08             	mov    0x8(%ebp),%eax
80103e71:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80103e77:	05 00 02 00 00       	add    $0x200,%eax
80103e7c:	39 c2                	cmp    %eax,%edx
80103e7e:	74 85                	je     80103e05 <pipewrite+0x23>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103e80:	8b 45 08             	mov    0x8(%ebp),%eax
80103e83:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103e89:	8d 48 01             	lea    0x1(%eax),%ecx
80103e8c:	8b 55 08             	mov    0x8(%ebp),%edx
80103e8f:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
80103e95:	25 ff 01 00 00       	and    $0x1ff,%eax
80103e9a:	89 c1                	mov    %eax,%ecx
80103e9c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103e9f:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ea2:	01 d0                	add    %edx,%eax
80103ea4:	0f b6 10             	movzbl (%eax),%edx
80103ea7:	8b 45 08             	mov    0x8(%ebp),%eax
80103eaa:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103eae:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103eb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103eb5:	3b 45 10             	cmp    0x10(%ebp),%eax
80103eb8:	0f 8c 45 ff ff ff    	jl     80103e03 <pipewrite+0x21>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103ebe:	8b 45 08             	mov    0x8(%ebp),%eax
80103ec1:	05 34 02 00 00       	add    $0x234,%eax
80103ec6:	83 ec 0c             	sub    $0xc,%esp
80103ec9:	50                   	push   %eax
80103eca:	e8 82 0a 00 00       	call   80104951 <wakeup>
80103ecf:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80103ed2:	8b 45 08             	mov    0x8(%ebp),%eax
80103ed5:	83 ec 0c             	sub    $0xc,%esp
80103ed8:	50                   	push   %eax
80103ed9:	e8 f2 0c 00 00       	call   80104bd0 <release>
80103ede:	83 c4 10             	add    $0x10,%esp
  return n;
80103ee1:	8b 45 10             	mov    0x10(%ebp),%eax
}
80103ee4:	c9                   	leave  
80103ee5:	c3                   	ret    

80103ee6 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103ee6:	55                   	push   %ebp
80103ee7:	89 e5                	mov    %esp,%ebp
80103ee9:	53                   	push   %ebx
80103eea:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
80103eed:	8b 45 08             	mov    0x8(%ebp),%eax
80103ef0:	83 ec 0c             	sub    $0xc,%esp
80103ef3:	50                   	push   %eax
80103ef4:	e8 71 0c 00 00       	call   80104b6a <acquire>
80103ef9:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103efc:	eb 3f                	jmp    80103f3d <piperead+0x57>
    if(proc->killed){
80103efe:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103f04:	8b 40 24             	mov    0x24(%eax),%eax
80103f07:	85 c0                	test   %eax,%eax
80103f09:	74 19                	je     80103f24 <piperead+0x3e>
      release(&p->lock);
80103f0b:	8b 45 08             	mov    0x8(%ebp),%eax
80103f0e:	83 ec 0c             	sub    $0xc,%esp
80103f11:	50                   	push   %eax
80103f12:	e8 b9 0c 00 00       	call   80104bd0 <release>
80103f17:	83 c4 10             	add    $0x10,%esp
      return -1;
80103f1a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103f1f:	e9 be 00 00 00       	jmp    80103fe2 <piperead+0xfc>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103f24:	8b 45 08             	mov    0x8(%ebp),%eax
80103f27:	8b 55 08             	mov    0x8(%ebp),%edx
80103f2a:	81 c2 34 02 00 00    	add    $0x234,%edx
80103f30:	83 ec 08             	sub    $0x8,%esp
80103f33:	50                   	push   %eax
80103f34:	52                   	push   %edx
80103f35:	e8 2e 09 00 00       	call   80104868 <sleep>
80103f3a:	83 c4 10             	add    $0x10,%esp
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103f3d:	8b 45 08             	mov    0x8(%ebp),%eax
80103f40:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80103f46:	8b 45 08             	mov    0x8(%ebp),%eax
80103f49:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103f4f:	39 c2                	cmp    %eax,%edx
80103f51:	75 0d                	jne    80103f60 <piperead+0x7a>
80103f53:	8b 45 08             	mov    0x8(%ebp),%eax
80103f56:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80103f5c:	85 c0                	test   %eax,%eax
80103f5e:	75 9e                	jne    80103efe <piperead+0x18>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103f60:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103f67:	eb 4b                	jmp    80103fb4 <piperead+0xce>
    if(p->nread == p->nwrite)
80103f69:	8b 45 08             	mov    0x8(%ebp),%eax
80103f6c:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80103f72:	8b 45 08             	mov    0x8(%ebp),%eax
80103f75:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103f7b:	39 c2                	cmp    %eax,%edx
80103f7d:	75 02                	jne    80103f81 <piperead+0x9b>
      break;
80103f7f:	eb 3b                	jmp    80103fbc <piperead+0xd6>
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103f81:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103f84:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f87:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80103f8a:	8b 45 08             	mov    0x8(%ebp),%eax
80103f8d:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80103f93:	8d 48 01             	lea    0x1(%eax),%ecx
80103f96:	8b 55 08             	mov    0x8(%ebp),%edx
80103f99:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
80103f9f:	25 ff 01 00 00       	and    $0x1ff,%eax
80103fa4:	89 c2                	mov    %eax,%edx
80103fa6:	8b 45 08             	mov    0x8(%ebp),%eax
80103fa9:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
80103fae:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103fb0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103fb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fb7:	3b 45 10             	cmp    0x10(%ebp),%eax
80103fba:	7c ad                	jl     80103f69 <piperead+0x83>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103fbc:	8b 45 08             	mov    0x8(%ebp),%eax
80103fbf:	05 38 02 00 00       	add    $0x238,%eax
80103fc4:	83 ec 0c             	sub    $0xc,%esp
80103fc7:	50                   	push   %eax
80103fc8:	e8 84 09 00 00       	call   80104951 <wakeup>
80103fcd:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80103fd0:	8b 45 08             	mov    0x8(%ebp),%eax
80103fd3:	83 ec 0c             	sub    $0xc,%esp
80103fd6:	50                   	push   %eax
80103fd7:	e8 f4 0b 00 00       	call   80104bd0 <release>
80103fdc:	83 c4 10             	add    $0x10,%esp
  return i;
80103fdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80103fe2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fe5:	c9                   	leave  
80103fe6:	c3                   	ret    

80103fe7 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80103fe7:	55                   	push   %ebp
80103fe8:	89 e5                	mov    %esp,%ebp
80103fea:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103fed:	9c                   	pushf  
80103fee:	58                   	pop    %eax
80103fef:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80103ff2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103ff5:	c9                   	leave  
80103ff6:	c3                   	ret    

80103ff7 <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
80103ff7:	55                   	push   %ebp
80103ff8:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80103ffa:	fb                   	sti    
}
80103ffb:	5d                   	pop    %ebp
80103ffc:	c3                   	ret    

80103ffd <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103ffd:	55                   	push   %ebp
80103ffe:	89 e5                	mov    %esp,%ebp
80104000:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
80104003:	83 ec 08             	sub    $0x8,%esp
80104006:	68 29 85 10 80       	push   $0x80108529
8010400b:	68 c0 ff 10 80       	push   $0x8010ffc0
80104010:	e8 34 0b 00 00       	call   80104b49 <initlock>
80104015:	83 c4 10             	add    $0x10,%esp
}
80104018:	c9                   	leave  
80104019:	c3                   	ret    

8010401a <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
8010401a:	55                   	push   %ebp
8010401b:	89 e5                	mov    %esp,%ebp
8010401d:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80104020:	83 ec 0c             	sub    $0xc,%esp
80104023:	68 c0 ff 10 80       	push   $0x8010ffc0
80104028:	e8 3d 0b 00 00       	call   80104b6a <acquire>
8010402d:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104030:	c7 45 f4 f4 ff 10 80 	movl   $0x8010fff4,-0xc(%ebp)
80104037:	eb 56                	jmp    8010408f <allocproc+0x75>
    if(p->state == UNUSED)
80104039:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010403c:	8b 40 0c             	mov    0xc(%eax),%eax
8010403f:	85 c0                	test   %eax,%eax
80104041:	75 48                	jne    8010408b <allocproc+0x71>
      goto found;
80104043:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80104044:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104047:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
8010404e:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80104053:	8d 50 01             	lea    0x1(%eax),%edx
80104056:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
8010405c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010405f:	89 42 10             	mov    %eax,0x10(%edx)
  release(&ptable.lock);
80104062:	83 ec 0c             	sub    $0xc,%esp
80104065:	68 c0 ff 10 80       	push   $0x8010ffc0
8010406a:	e8 61 0b 00 00       	call   80104bd0 <release>
8010406f:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104072:	e8 06 eb ff ff       	call   80102b7d <kalloc>
80104077:	89 c2                	mov    %eax,%edx
80104079:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010407c:	89 50 08             	mov    %edx,0x8(%eax)
8010407f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104082:	8b 40 08             	mov    0x8(%eax),%eax
80104085:	85 c0                	test   %eax,%eax
80104087:	75 37                	jne    801040c0 <allocproc+0xa6>
80104089:	eb 24                	jmp    801040af <allocproc+0x95>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010408b:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
8010408f:	81 7d f4 f4 1e 11 80 	cmpl   $0x80111ef4,-0xc(%ebp)
80104096:	72 a1                	jb     80104039 <allocproc+0x1f>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
80104098:	83 ec 0c             	sub    $0xc,%esp
8010409b:	68 c0 ff 10 80       	push   $0x8010ffc0
801040a0:	e8 2b 0b 00 00       	call   80104bd0 <release>
801040a5:	83 c4 10             	add    $0x10,%esp
  return 0;
801040a8:	b8 00 00 00 00       	mov    $0x0,%eax
801040ad:	eb 6e                	jmp    8010411d <allocproc+0x103>
  p->pid = nextpid++;
  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
801040af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040b2:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
801040b9:	b8 00 00 00 00       	mov    $0x0,%eax
801040be:	eb 5d                	jmp    8010411d <allocproc+0x103>
  }
  sp = p->kstack + KSTACKSIZE;
801040c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040c3:	8b 40 08             	mov    0x8(%eax),%eax
801040c6:	05 00 10 00 00       	add    $0x1000,%eax
801040cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801040ce:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
801040d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040d5:	8b 55 f0             	mov    -0x10(%ebp),%edx
801040d8:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
801040db:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
801040df:	ba a0 63 10 80       	mov    $0x801063a0,%edx
801040e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801040e7:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
801040e9:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
801040ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040f0:	8b 55 f0             	mov    -0x10(%ebp),%edx
801040f3:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
801040f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040f9:	8b 40 1c             	mov    0x1c(%eax),%eax
801040fc:	83 ec 04             	sub    $0x4,%esp
801040ff:	6a 14                	push   $0x14
80104101:	6a 00                	push   $0x0
80104103:	50                   	push   %eax
80104104:	e8 bd 0c 00 00       	call   80104dc6 <memset>
80104109:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
8010410c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010410f:	8b 40 1c             	mov    0x1c(%eax),%eax
80104112:	ba 38 48 10 80       	mov    $0x80104838,%edx
80104117:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
8010411a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010411d:	c9                   	leave  
8010411e:	c3                   	ret    

8010411f <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
8010411f:	55                   	push   %ebp
80104120:	89 e5                	mov    %esp,%ebp
80104122:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
80104125:	e8 f0 fe ff ff       	call   8010401a <allocproc>
8010412a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
8010412d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104130:	a3 68 b6 10 80       	mov    %eax,0x8010b668
  if((p->pgdir = setupkvm()) == 0)
80104135:	e8 1f 39 00 00       	call   80107a59 <setupkvm>
8010413a:	89 c2                	mov    %eax,%edx
8010413c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010413f:	89 50 04             	mov    %edx,0x4(%eax)
80104142:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104145:	8b 40 04             	mov    0x4(%eax),%eax
80104148:	85 c0                	test   %eax,%eax
8010414a:	75 0d                	jne    80104159 <userinit+0x3a>
    panic("userinit: out of memory?");
8010414c:	83 ec 0c             	sub    $0xc,%esp
8010414f:	68 30 85 10 80       	push   $0x80108530
80104154:	e8 03 c4 ff ff       	call   8010055c <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104159:	ba 2c 00 00 00       	mov    $0x2c,%edx
8010415e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104161:	8b 40 04             	mov    0x4(%eax),%eax
80104164:	83 ec 04             	sub    $0x4,%esp
80104167:	52                   	push   %edx
80104168:	68 00 b5 10 80       	push   $0x8010b500
8010416d:	50                   	push   %eax
8010416e:	e8 3d 3b 00 00       	call   80107cb0 <inituvm>
80104173:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
80104176:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104179:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
8010417f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104182:	8b 40 18             	mov    0x18(%eax),%eax
80104185:	83 ec 04             	sub    $0x4,%esp
80104188:	6a 4c                	push   $0x4c
8010418a:	6a 00                	push   $0x0
8010418c:	50                   	push   %eax
8010418d:	e8 34 0c 00 00       	call   80104dc6 <memset>
80104192:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104195:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104198:	8b 40 18             	mov    0x18(%eax),%eax
8010419b:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801041a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041a4:	8b 40 18             	mov    0x18(%eax),%eax
801041a7:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
801041ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041b0:	8b 40 18             	mov    0x18(%eax),%eax
801041b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801041b6:	8b 52 18             	mov    0x18(%edx),%edx
801041b9:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801041bd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801041c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041c4:	8b 40 18             	mov    0x18(%eax),%eax
801041c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801041ca:	8b 52 18             	mov    0x18(%edx),%edx
801041cd:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801041d1:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801041d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041d8:	8b 40 18             	mov    0x18(%eax),%eax
801041db:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801041e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041e5:	8b 40 18             	mov    0x18(%eax),%eax
801041e8:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801041ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041f2:	8b 40 18             	mov    0x18(%eax),%eax
801041f5:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
801041fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041ff:	83 c0 6c             	add    $0x6c,%eax
80104202:	83 ec 04             	sub    $0x4,%esp
80104205:	6a 10                	push   $0x10
80104207:	68 49 85 10 80       	push   $0x80108549
8010420c:	50                   	push   %eax
8010420d:	e8 b9 0d 00 00       	call   80104fcb <safestrcpy>
80104212:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
80104215:	83 ec 0c             	sub    $0xc,%esp
80104218:	68 52 85 10 80       	push   $0x80108552
8010421d:	e8 67 e2 ff ff       	call   80102489 <namei>
80104222:	83 c4 10             	add    $0x10,%esp
80104225:	89 c2                	mov    %eax,%edx
80104227:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010422a:	89 50 68             	mov    %edx,0x68(%eax)

  p->state = RUNNABLE;
8010422d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104230:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
80104237:	c9                   	leave  
80104238:	c3                   	ret    

80104239 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104239:	55                   	push   %ebp
8010423a:	89 e5                	mov    %esp,%ebp
8010423c:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  
  sz = proc->sz;
8010423f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104245:	8b 00                	mov    (%eax),%eax
80104247:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
8010424a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010424e:	7e 31                	jle    80104281 <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80104250:	8b 55 08             	mov    0x8(%ebp),%edx
80104253:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104256:	01 c2                	add    %eax,%edx
80104258:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010425e:	8b 40 04             	mov    0x4(%eax),%eax
80104261:	83 ec 04             	sub    $0x4,%esp
80104264:	52                   	push   %edx
80104265:	ff 75 f4             	pushl  -0xc(%ebp)
80104268:	50                   	push   %eax
80104269:	e8 8e 3b 00 00       	call   80107dfc <allocuvm>
8010426e:	83 c4 10             	add    $0x10,%esp
80104271:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104274:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104278:	75 3e                	jne    801042b8 <growproc+0x7f>
      return -1;
8010427a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010427f:	eb 59                	jmp    801042da <growproc+0xa1>
  } else if(n < 0){
80104281:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104285:	79 31                	jns    801042b8 <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80104287:	8b 55 08             	mov    0x8(%ebp),%edx
8010428a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010428d:	01 c2                	add    %eax,%edx
8010428f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104295:	8b 40 04             	mov    0x4(%eax),%eax
80104298:	83 ec 04             	sub    $0x4,%esp
8010429b:	52                   	push   %edx
8010429c:	ff 75 f4             	pushl  -0xc(%ebp)
8010429f:	50                   	push   %eax
801042a0:	e8 20 3c 00 00       	call   80107ec5 <deallocuvm>
801042a5:	83 c4 10             	add    $0x10,%esp
801042a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801042ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801042af:	75 07                	jne    801042b8 <growproc+0x7f>
      return -1;
801042b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042b6:	eb 22                	jmp    801042da <growproc+0xa1>
  }
  proc->sz = sz;
801042b8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042be:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042c1:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
801042c3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042c9:	83 ec 0c             	sub    $0xc,%esp
801042cc:	50                   	push   %eax
801042cd:	e8 6c 38 00 00       	call   80107b3e <switchuvm>
801042d2:	83 c4 10             	add    $0x10,%esp
  return 0;
801042d5:	b8 00 00 00 00       	mov    $0x0,%eax
}
801042da:	c9                   	leave  
801042db:	c3                   	ret    

801042dc <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801042dc:	55                   	push   %ebp
801042dd:	89 e5                	mov    %esp,%ebp
801042df:	57                   	push   %edi
801042e0:	56                   	push   %esi
801042e1:	53                   	push   %ebx
801042e2:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
801042e5:	e8 30 fd ff ff       	call   8010401a <allocproc>
801042ea:	89 45 e0             	mov    %eax,-0x20(%ebp)
801042ed:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801042f1:	75 0a                	jne    801042fd <fork+0x21>
    return -1;
801042f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042f8:	e9 48 01 00 00       	jmp    80104445 <fork+0x169>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
801042fd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104303:	8b 10                	mov    (%eax),%edx
80104305:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010430b:	8b 40 04             	mov    0x4(%eax),%eax
8010430e:	83 ec 08             	sub    $0x8,%esp
80104311:	52                   	push   %edx
80104312:	50                   	push   %eax
80104313:	e8 49 3d 00 00       	call   80108061 <copyuvm>
80104318:	83 c4 10             	add    $0x10,%esp
8010431b:	89 c2                	mov    %eax,%edx
8010431d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104320:	89 50 04             	mov    %edx,0x4(%eax)
80104323:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104326:	8b 40 04             	mov    0x4(%eax),%eax
80104329:	85 c0                	test   %eax,%eax
8010432b:	75 30                	jne    8010435d <fork+0x81>
    kfree(np->kstack);
8010432d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104330:	8b 40 08             	mov    0x8(%eax),%eax
80104333:	83 ec 0c             	sub    $0xc,%esp
80104336:	50                   	push   %eax
80104337:	e8 a5 e7 ff ff       	call   80102ae1 <kfree>
8010433c:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
8010433f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104342:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80104349:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010434c:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
80104353:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104358:	e9 e8 00 00 00       	jmp    80104445 <fork+0x169>
  }
  np->sz = proc->sz;
8010435d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104363:	8b 10                	mov    (%eax),%edx
80104365:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104368:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
8010436a:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104371:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104374:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
80104377:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010437a:	8b 50 18             	mov    0x18(%eax),%edx
8010437d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104383:	8b 40 18             	mov    0x18(%eax),%eax
80104386:	89 c3                	mov    %eax,%ebx
80104388:	b8 13 00 00 00       	mov    $0x13,%eax
8010438d:	89 d7                	mov    %edx,%edi
8010438f:	89 de                	mov    %ebx,%esi
80104391:	89 c1                	mov    %eax,%ecx
80104393:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104395:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104398:	8b 40 18             	mov    0x18(%eax),%eax
8010439b:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
801043a2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801043a9:	eb 43                	jmp    801043ee <fork+0x112>
    if(proc->ofile[i])
801043ab:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043b1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801043b4:	83 c2 08             	add    $0x8,%edx
801043b7:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801043bb:	85 c0                	test   %eax,%eax
801043bd:	74 2b                	je     801043ea <fork+0x10e>
      np->ofile[i] = filedup(proc->ofile[i]);
801043bf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043c5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801043c8:	83 c2 08             	add    $0x8,%edx
801043cb:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801043cf:	83 ec 0c             	sub    $0xc,%esp
801043d2:	50                   	push   %eax
801043d3:	e8 db cb ff ff       	call   80100fb3 <filedup>
801043d8:	83 c4 10             	add    $0x10,%esp
801043db:	89 c1                	mov    %eax,%ecx
801043dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
801043e0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801043e3:	83 c2 08             	add    $0x8,%edx
801043e6:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801043ea:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801043ee:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
801043f2:	7e b7                	jle    801043ab <fork+0xcf>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
801043f4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043fa:	8b 40 68             	mov    0x68(%eax),%eax
801043fd:	83 ec 0c             	sub    $0xc,%esp
80104400:	50                   	push   %eax
80104401:	e8 86 d4 ff ff       	call   8010188c <idup>
80104406:	83 c4 10             	add    $0x10,%esp
80104409:	89 c2                	mov    %eax,%edx
8010440b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010440e:	89 50 68             	mov    %edx,0x68(%eax)
 
  pid = np->pid;
80104411:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104414:	8b 40 10             	mov    0x10(%eax),%eax
80104417:	89 45 dc             	mov    %eax,-0x24(%ebp)
  np->state = RUNNABLE;
8010441a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010441d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80104424:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010442a:	8d 50 6c             	lea    0x6c(%eax),%edx
8010442d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104430:	83 c0 6c             	add    $0x6c,%eax
80104433:	83 ec 04             	sub    $0x4,%esp
80104436:	6a 10                	push   $0x10
80104438:	52                   	push   %edx
80104439:	50                   	push   %eax
8010443a:	e8 8c 0b 00 00       	call   80104fcb <safestrcpy>
8010443f:	83 c4 10             	add    $0x10,%esp
  return pid;
80104442:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80104445:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104448:	5b                   	pop    %ebx
80104449:	5e                   	pop    %esi
8010444a:	5f                   	pop    %edi
8010444b:	5d                   	pop    %ebp
8010444c:	c3                   	ret    

8010444d <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
8010444d:	55                   	push   %ebp
8010444e:	89 e5                	mov    %esp,%ebp
80104450:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80104453:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010445a:	a1 68 b6 10 80       	mov    0x8010b668,%eax
8010445f:	39 c2                	cmp    %eax,%edx
80104461:	75 0d                	jne    80104470 <exit+0x23>
    panic("init exiting");
80104463:	83 ec 0c             	sub    $0xc,%esp
80104466:	68 54 85 10 80       	push   $0x80108554
8010446b:	e8 ec c0 ff ff       	call   8010055c <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104470:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104477:	eb 48                	jmp    801044c1 <exit+0x74>
    if(proc->ofile[fd]){
80104479:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010447f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104482:	83 c2 08             	add    $0x8,%edx
80104485:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104489:	85 c0                	test   %eax,%eax
8010448b:	74 30                	je     801044bd <exit+0x70>
      fileclose(proc->ofile[fd]);
8010448d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104493:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104496:	83 c2 08             	add    $0x8,%edx
80104499:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010449d:	83 ec 0c             	sub    $0xc,%esp
801044a0:	50                   	push   %eax
801044a1:	e8 5e cb ff ff       	call   80101004 <fileclose>
801044a6:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
801044a9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044af:	8b 55 f0             	mov    -0x10(%ebp),%edx
801044b2:	83 c2 08             	add    $0x8,%edx
801044b5:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801044bc:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801044bd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801044c1:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
801044c5:	7e b2                	jle    80104479 <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
801044c7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044cd:	8b 40 68             	mov    0x68(%eax),%eax
801044d0:	83 ec 0c             	sub    $0xc,%esp
801044d3:	50                   	push   %eax
801044d4:	e8 b5 d5 ff ff       	call   80101a8e <iput>
801044d9:	83 c4 10             	add    $0x10,%esp
  proc->cwd = 0;
801044dc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044e2:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
801044e9:	83 ec 0c             	sub    $0xc,%esp
801044ec:	68 c0 ff 10 80       	push   $0x8010ffc0
801044f1:	e8 74 06 00 00       	call   80104b6a <acquire>
801044f6:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
801044f9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044ff:	8b 40 14             	mov    0x14(%eax),%eax
80104502:	83 ec 0c             	sub    $0xc,%esp
80104505:	50                   	push   %eax
80104506:	e8 08 04 00 00       	call   80104913 <wakeup1>
8010450b:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010450e:	c7 45 f4 f4 ff 10 80 	movl   $0x8010fff4,-0xc(%ebp)
80104515:	eb 3c                	jmp    80104553 <exit+0x106>
    if(p->parent == proc){
80104517:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010451a:	8b 50 14             	mov    0x14(%eax),%edx
8010451d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104523:	39 c2                	cmp    %eax,%edx
80104525:	75 28                	jne    8010454f <exit+0x102>
      p->parent = initproc;
80104527:	8b 15 68 b6 10 80    	mov    0x8010b668,%edx
8010452d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104530:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
80104533:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104536:	8b 40 0c             	mov    0xc(%eax),%eax
80104539:	83 f8 05             	cmp    $0x5,%eax
8010453c:	75 11                	jne    8010454f <exit+0x102>
        wakeup1(initproc);
8010453e:	a1 68 b6 10 80       	mov    0x8010b668,%eax
80104543:	83 ec 0c             	sub    $0xc,%esp
80104546:	50                   	push   %eax
80104547:	e8 c7 03 00 00       	call   80104913 <wakeup1>
8010454c:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010454f:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104553:	81 7d f4 f4 1e 11 80 	cmpl   $0x80111ef4,-0xc(%ebp)
8010455a:	72 bb                	jb     80104517 <exit+0xca>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
8010455c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104562:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
80104569:	e8 d5 01 00 00       	call   80104743 <sched>
  panic("zombie exit");
8010456e:	83 ec 0c             	sub    $0xc,%esp
80104571:	68 61 85 10 80       	push   $0x80108561
80104576:	e8 e1 bf ff ff       	call   8010055c <panic>

8010457b <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
8010457b:	55                   	push   %ebp
8010457c:	89 e5                	mov    %esp,%ebp
8010457e:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80104581:	83 ec 0c             	sub    $0xc,%esp
80104584:	68 c0 ff 10 80       	push   $0x8010ffc0
80104589:	e8 dc 05 00 00       	call   80104b6a <acquire>
8010458e:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80104591:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104598:	c7 45 f4 f4 ff 10 80 	movl   $0x8010fff4,-0xc(%ebp)
8010459f:	e9 a6 00 00 00       	jmp    8010464a <wait+0xcf>
      if(p->parent != proc)
801045a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045a7:	8b 50 14             	mov    0x14(%eax),%edx
801045aa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045b0:	39 c2                	cmp    %eax,%edx
801045b2:	74 05                	je     801045b9 <wait+0x3e>
        continue;
801045b4:	e9 8d 00 00 00       	jmp    80104646 <wait+0xcb>
      havekids = 1;
801045b9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
801045c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045c3:	8b 40 0c             	mov    0xc(%eax),%eax
801045c6:	83 f8 05             	cmp    $0x5,%eax
801045c9:	75 7b                	jne    80104646 <wait+0xcb>
        // Found one.
        pid = p->pid;
801045cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045ce:	8b 40 10             	mov    0x10(%eax),%eax
801045d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
801045d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045d7:	8b 40 08             	mov    0x8(%eax),%eax
801045da:	83 ec 0c             	sub    $0xc,%esp
801045dd:	50                   	push   %eax
801045de:	e8 fe e4 ff ff       	call   80102ae1 <kfree>
801045e3:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
801045e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045e9:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
801045f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045f3:	8b 40 04             	mov    0x4(%eax),%eax
801045f6:	83 ec 0c             	sub    $0xc,%esp
801045f9:	50                   	push   %eax
801045fa:	e8 83 39 00 00       	call   80107f82 <freevm>
801045ff:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
80104602:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104605:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
8010460c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010460f:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104616:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104619:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104620:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104623:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104627:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010462a:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
80104631:	83 ec 0c             	sub    $0xc,%esp
80104634:	68 c0 ff 10 80       	push   $0x8010ffc0
80104639:	e8 92 05 00 00       	call   80104bd0 <release>
8010463e:	83 c4 10             	add    $0x10,%esp
        return pid;
80104641:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104644:	eb 57                	jmp    8010469d <wait+0x122>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104646:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
8010464a:	81 7d f4 f4 1e 11 80 	cmpl   $0x80111ef4,-0xc(%ebp)
80104651:	0f 82 4d ff ff ff    	jb     801045a4 <wait+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104657:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010465b:	74 0d                	je     8010466a <wait+0xef>
8010465d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104663:	8b 40 24             	mov    0x24(%eax),%eax
80104666:	85 c0                	test   %eax,%eax
80104668:	74 17                	je     80104681 <wait+0x106>
      release(&ptable.lock);
8010466a:	83 ec 0c             	sub    $0xc,%esp
8010466d:	68 c0 ff 10 80       	push   $0x8010ffc0
80104672:	e8 59 05 00 00       	call   80104bd0 <release>
80104677:	83 c4 10             	add    $0x10,%esp
      return -1;
8010467a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010467f:	eb 1c                	jmp    8010469d <wait+0x122>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104681:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104687:	83 ec 08             	sub    $0x8,%esp
8010468a:	68 c0 ff 10 80       	push   $0x8010ffc0
8010468f:	50                   	push   %eax
80104690:	e8 d3 01 00 00       	call   80104868 <sleep>
80104695:	83 c4 10             	add    $0x10,%esp
  }
80104698:	e9 f4 fe ff ff       	jmp    80104591 <wait+0x16>
}
8010469d:	c9                   	leave  
8010469e:	c3                   	ret    

8010469f <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
8010469f:	55                   	push   %ebp
801046a0:	89 e5                	mov    %esp,%ebp
801046a2:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
801046a5:	e8 4d f9 ff ff       	call   80103ff7 <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
801046aa:	83 ec 0c             	sub    $0xc,%esp
801046ad:	68 c0 ff 10 80       	push   $0x8010ffc0
801046b2:	e8 b3 04 00 00       	call   80104b6a <acquire>
801046b7:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046ba:	c7 45 f4 f4 ff 10 80 	movl   $0x8010fff4,-0xc(%ebp)
801046c1:	eb 62                	jmp    80104725 <scheduler+0x86>
      if(p->state != RUNNABLE)
801046c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046c6:	8b 40 0c             	mov    0xc(%eax),%eax
801046c9:	83 f8 03             	cmp    $0x3,%eax
801046cc:	74 02                	je     801046d0 <scheduler+0x31>
        continue;
801046ce:	eb 51                	jmp    80104721 <scheduler+0x82>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
801046d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046d3:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
801046d9:	83 ec 0c             	sub    $0xc,%esp
801046dc:	ff 75 f4             	pushl  -0xc(%ebp)
801046df:	e8 5a 34 00 00       	call   80107b3e <switchuvm>
801046e4:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
801046e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046ea:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
801046f1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046f7:	8b 40 1c             	mov    0x1c(%eax),%eax
801046fa:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104701:	83 c2 04             	add    $0x4,%edx
80104704:	83 ec 08             	sub    $0x8,%esp
80104707:	50                   	push   %eax
80104708:	52                   	push   %edx
80104709:	e8 2e 09 00 00       	call   8010503c <swtch>
8010470e:	83 c4 10             	add    $0x10,%esp
      switchkvm();
80104711:	e8 0c 34 00 00       	call   80107b22 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80104716:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
8010471d:	00 00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104721:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104725:	81 7d f4 f4 1e 11 80 	cmpl   $0x80111ef4,-0xc(%ebp)
8010472c:	72 95                	jb     801046c3 <scheduler+0x24>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
8010472e:	83 ec 0c             	sub    $0xc,%esp
80104731:	68 c0 ff 10 80       	push   $0x8010ffc0
80104736:	e8 95 04 00 00       	call   80104bd0 <release>
8010473b:	83 c4 10             	add    $0x10,%esp

  }
8010473e:	e9 62 ff ff ff       	jmp    801046a5 <scheduler+0x6>

80104743 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104743:	55                   	push   %ebp
80104744:	89 e5                	mov    %esp,%ebp
80104746:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104749:	83 ec 0c             	sub    $0xc,%esp
8010474c:	68 c0 ff 10 80       	push   $0x8010ffc0
80104751:	e8 44 05 00 00       	call   80104c9a <holding>
80104756:	83 c4 10             	add    $0x10,%esp
80104759:	85 c0                	test   %eax,%eax
8010475b:	75 0d                	jne    8010476a <sched+0x27>
    panic("sched ptable.lock");
8010475d:	83 ec 0c             	sub    $0xc,%esp
80104760:	68 6d 85 10 80       	push   $0x8010856d
80104765:	e8 f2 bd ff ff       	call   8010055c <panic>
  if(cpu->ncli != 1)
8010476a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104770:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104776:	83 f8 01             	cmp    $0x1,%eax
80104779:	74 0d                	je     80104788 <sched+0x45>
    panic("sched locks");
8010477b:	83 ec 0c             	sub    $0xc,%esp
8010477e:	68 7f 85 10 80       	push   $0x8010857f
80104783:	e8 d4 bd ff ff       	call   8010055c <panic>
  if(proc->state == RUNNING)
80104788:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010478e:	8b 40 0c             	mov    0xc(%eax),%eax
80104791:	83 f8 04             	cmp    $0x4,%eax
80104794:	75 0d                	jne    801047a3 <sched+0x60>
    panic("sched running");
80104796:	83 ec 0c             	sub    $0xc,%esp
80104799:	68 8b 85 10 80       	push   $0x8010858b
8010479e:	e8 b9 bd ff ff       	call   8010055c <panic>
  if(readeflags()&FL_IF)
801047a3:	e8 3f f8 ff ff       	call   80103fe7 <readeflags>
801047a8:	25 00 02 00 00       	and    $0x200,%eax
801047ad:	85 c0                	test   %eax,%eax
801047af:	74 0d                	je     801047be <sched+0x7b>
    panic("sched interruptible");
801047b1:	83 ec 0c             	sub    $0xc,%esp
801047b4:	68 99 85 10 80       	push   $0x80108599
801047b9:	e8 9e bd ff ff       	call   8010055c <panic>
  intena = cpu->intena;
801047be:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801047c4:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
801047ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
801047cd:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801047d3:	8b 40 04             	mov    0x4(%eax),%eax
801047d6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801047dd:	83 c2 1c             	add    $0x1c,%edx
801047e0:	83 ec 08             	sub    $0x8,%esp
801047e3:	50                   	push   %eax
801047e4:	52                   	push   %edx
801047e5:	e8 52 08 00 00       	call   8010503c <swtch>
801047ea:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
801047ed:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801047f3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801047f6:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
801047fc:	c9                   	leave  
801047fd:	c3                   	ret    

801047fe <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
801047fe:	55                   	push   %ebp
801047ff:	89 e5                	mov    %esp,%ebp
80104801:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104804:	83 ec 0c             	sub    $0xc,%esp
80104807:	68 c0 ff 10 80       	push   $0x8010ffc0
8010480c:	e8 59 03 00 00       	call   80104b6a <acquire>
80104811:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104814:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010481a:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104821:	e8 1d ff ff ff       	call   80104743 <sched>
  release(&ptable.lock);
80104826:	83 ec 0c             	sub    $0xc,%esp
80104829:	68 c0 ff 10 80       	push   $0x8010ffc0
8010482e:	e8 9d 03 00 00       	call   80104bd0 <release>
80104833:	83 c4 10             	add    $0x10,%esp
}
80104836:	c9                   	leave  
80104837:	c3                   	ret    

80104838 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104838:	55                   	push   %ebp
80104839:	89 e5                	mov    %esp,%ebp
8010483b:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
8010483e:	83 ec 0c             	sub    $0xc,%esp
80104841:	68 c0 ff 10 80       	push   $0x8010ffc0
80104846:	e8 85 03 00 00       	call   80104bd0 <release>
8010484b:	83 c4 10             	add    $0x10,%esp

  if (first) {
8010484e:	a1 08 b0 10 80       	mov    0x8010b008,%eax
80104853:	85 c0                	test   %eax,%eax
80104855:	74 0f                	je     80104866 <forkret+0x2e>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104857:	c7 05 08 b0 10 80 00 	movl   $0x0,0x8010b008
8010485e:	00 00 00 
    initlog();
80104861:	e8 b3 e7 ff ff       	call   80103019 <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80104866:	c9                   	leave  
80104867:	c3                   	ret    

80104868 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104868:	55                   	push   %ebp
80104869:	89 e5                	mov    %esp,%ebp
8010486b:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
8010486e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104874:	85 c0                	test   %eax,%eax
80104876:	75 0d                	jne    80104885 <sleep+0x1d>
    panic("sleep");
80104878:	83 ec 0c             	sub    $0xc,%esp
8010487b:	68 ad 85 10 80       	push   $0x801085ad
80104880:	e8 d7 bc ff ff       	call   8010055c <panic>

  if(lk == 0)
80104885:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104889:	75 0d                	jne    80104898 <sleep+0x30>
    panic("sleep without lk");
8010488b:	83 ec 0c             	sub    $0xc,%esp
8010488e:	68 b3 85 10 80       	push   $0x801085b3
80104893:	e8 c4 bc ff ff       	call   8010055c <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104898:	81 7d 0c c0 ff 10 80 	cmpl   $0x8010ffc0,0xc(%ebp)
8010489f:	74 1e                	je     801048bf <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
801048a1:	83 ec 0c             	sub    $0xc,%esp
801048a4:	68 c0 ff 10 80       	push   $0x8010ffc0
801048a9:	e8 bc 02 00 00       	call   80104b6a <acquire>
801048ae:	83 c4 10             	add    $0x10,%esp
    release(lk);
801048b1:	83 ec 0c             	sub    $0xc,%esp
801048b4:	ff 75 0c             	pushl  0xc(%ebp)
801048b7:	e8 14 03 00 00       	call   80104bd0 <release>
801048bc:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
801048bf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048c5:	8b 55 08             	mov    0x8(%ebp),%edx
801048c8:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
801048cb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048d1:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
801048d8:	e8 66 fe ff ff       	call   80104743 <sched>

  // Tidy up.
  proc->chan = 0;
801048dd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048e3:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
801048ea:	81 7d 0c c0 ff 10 80 	cmpl   $0x8010ffc0,0xc(%ebp)
801048f1:	74 1e                	je     80104911 <sleep+0xa9>
    release(&ptable.lock);
801048f3:	83 ec 0c             	sub    $0xc,%esp
801048f6:	68 c0 ff 10 80       	push   $0x8010ffc0
801048fb:	e8 d0 02 00 00       	call   80104bd0 <release>
80104900:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104903:	83 ec 0c             	sub    $0xc,%esp
80104906:	ff 75 0c             	pushl  0xc(%ebp)
80104909:	e8 5c 02 00 00       	call   80104b6a <acquire>
8010490e:	83 c4 10             	add    $0x10,%esp
  }
}
80104911:	c9                   	leave  
80104912:	c3                   	ret    

80104913 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104913:	55                   	push   %ebp
80104914:	89 e5                	mov    %esp,%ebp
80104916:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104919:	c7 45 fc f4 ff 10 80 	movl   $0x8010fff4,-0x4(%ebp)
80104920:	eb 24                	jmp    80104946 <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104922:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104925:	8b 40 0c             	mov    0xc(%eax),%eax
80104928:	83 f8 02             	cmp    $0x2,%eax
8010492b:	75 15                	jne    80104942 <wakeup1+0x2f>
8010492d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104930:	8b 40 20             	mov    0x20(%eax),%eax
80104933:	3b 45 08             	cmp    0x8(%ebp),%eax
80104936:	75 0a                	jne    80104942 <wakeup1+0x2f>
      p->state = RUNNABLE;
80104938:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010493b:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104942:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
80104946:	81 7d fc f4 1e 11 80 	cmpl   $0x80111ef4,-0x4(%ebp)
8010494d:	72 d3                	jb     80104922 <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
8010494f:	c9                   	leave  
80104950:	c3                   	ret    

80104951 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104951:	55                   	push   %ebp
80104952:	89 e5                	mov    %esp,%ebp
80104954:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104957:	83 ec 0c             	sub    $0xc,%esp
8010495a:	68 c0 ff 10 80       	push   $0x8010ffc0
8010495f:	e8 06 02 00 00       	call   80104b6a <acquire>
80104964:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104967:	83 ec 0c             	sub    $0xc,%esp
8010496a:	ff 75 08             	pushl  0x8(%ebp)
8010496d:	e8 a1 ff ff ff       	call   80104913 <wakeup1>
80104972:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104975:	83 ec 0c             	sub    $0xc,%esp
80104978:	68 c0 ff 10 80       	push   $0x8010ffc0
8010497d:	e8 4e 02 00 00       	call   80104bd0 <release>
80104982:	83 c4 10             	add    $0x10,%esp
}
80104985:	c9                   	leave  
80104986:	c3                   	ret    

80104987 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104987:	55                   	push   %ebp
80104988:	89 e5                	mov    %esp,%ebp
8010498a:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
8010498d:	83 ec 0c             	sub    $0xc,%esp
80104990:	68 c0 ff 10 80       	push   $0x8010ffc0
80104995:	e8 d0 01 00 00       	call   80104b6a <acquire>
8010499a:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010499d:	c7 45 f4 f4 ff 10 80 	movl   $0x8010fff4,-0xc(%ebp)
801049a4:	eb 45                	jmp    801049eb <kill+0x64>
    if(p->pid == pid){
801049a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049a9:	8b 40 10             	mov    0x10(%eax),%eax
801049ac:	3b 45 08             	cmp    0x8(%ebp),%eax
801049af:	75 36                	jne    801049e7 <kill+0x60>
      p->killed = 1;
801049b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049b4:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801049bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049be:	8b 40 0c             	mov    0xc(%eax),%eax
801049c1:	83 f8 02             	cmp    $0x2,%eax
801049c4:	75 0a                	jne    801049d0 <kill+0x49>
        p->state = RUNNABLE;
801049c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049c9:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801049d0:	83 ec 0c             	sub    $0xc,%esp
801049d3:	68 c0 ff 10 80       	push   $0x8010ffc0
801049d8:	e8 f3 01 00 00       	call   80104bd0 <release>
801049dd:	83 c4 10             	add    $0x10,%esp
      return 0;
801049e0:	b8 00 00 00 00       	mov    $0x0,%eax
801049e5:	eb 22                	jmp    80104a09 <kill+0x82>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049e7:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
801049eb:	81 7d f4 f4 1e 11 80 	cmpl   $0x80111ef4,-0xc(%ebp)
801049f2:	72 b2                	jb     801049a6 <kill+0x1f>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
801049f4:	83 ec 0c             	sub    $0xc,%esp
801049f7:	68 c0 ff 10 80       	push   $0x8010ffc0
801049fc:	e8 cf 01 00 00       	call   80104bd0 <release>
80104a01:	83 c4 10             	add    $0x10,%esp
  return -1;
80104a04:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a09:	c9                   	leave  
80104a0a:	c3                   	ret    

80104a0b <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104a0b:	55                   	push   %ebp
80104a0c:	89 e5                	mov    %esp,%ebp
80104a0e:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a11:	c7 45 f0 f4 ff 10 80 	movl   $0x8010fff4,-0x10(%ebp)
80104a18:	e9 d5 00 00 00       	jmp    80104af2 <procdump+0xe7>
    if(p->state == UNUSED)
80104a1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a20:	8b 40 0c             	mov    0xc(%eax),%eax
80104a23:	85 c0                	test   %eax,%eax
80104a25:	75 05                	jne    80104a2c <procdump+0x21>
      continue;
80104a27:	e9 c2 00 00 00       	jmp    80104aee <procdump+0xe3>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104a2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a2f:	8b 40 0c             	mov    0xc(%eax),%eax
80104a32:	83 f8 05             	cmp    $0x5,%eax
80104a35:	77 23                	ja     80104a5a <procdump+0x4f>
80104a37:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a3a:	8b 40 0c             	mov    0xc(%eax),%eax
80104a3d:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104a44:	85 c0                	test   %eax,%eax
80104a46:	74 12                	je     80104a5a <procdump+0x4f>
      state = states[p->state];
80104a48:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a4b:	8b 40 0c             	mov    0xc(%eax),%eax
80104a4e:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104a55:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104a58:	eb 07                	jmp    80104a61 <procdump+0x56>
    else
      state = "???";
80104a5a:	c7 45 ec c4 85 10 80 	movl   $0x801085c4,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104a61:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a64:	8d 50 6c             	lea    0x6c(%eax),%edx
80104a67:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a6a:	8b 40 10             	mov    0x10(%eax),%eax
80104a6d:	52                   	push   %edx
80104a6e:	ff 75 ec             	pushl  -0x14(%ebp)
80104a71:	50                   	push   %eax
80104a72:	68 c8 85 10 80       	push   $0x801085c8
80104a77:	e8 43 b9 ff ff       	call   801003bf <cprintf>
80104a7c:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80104a7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a82:	8b 40 0c             	mov    0xc(%eax),%eax
80104a85:	83 f8 02             	cmp    $0x2,%eax
80104a88:	75 54                	jne    80104ade <procdump+0xd3>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104a8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a8d:	8b 40 1c             	mov    0x1c(%eax),%eax
80104a90:	8b 40 0c             	mov    0xc(%eax),%eax
80104a93:	83 c0 08             	add    $0x8,%eax
80104a96:	89 c2                	mov    %eax,%edx
80104a98:	83 ec 08             	sub    $0x8,%esp
80104a9b:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104a9e:	50                   	push   %eax
80104a9f:	52                   	push   %edx
80104aa0:	e8 7c 01 00 00       	call   80104c21 <getcallerpcs>
80104aa5:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104aa8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104aaf:	eb 1c                	jmp    80104acd <procdump+0xc2>
        cprintf(" %p", pc[i]);
80104ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ab4:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104ab8:	83 ec 08             	sub    $0x8,%esp
80104abb:	50                   	push   %eax
80104abc:	68 d1 85 10 80       	push   $0x801085d1
80104ac1:	e8 f9 b8 ff ff       	call   801003bf <cprintf>
80104ac6:	83 c4 10             	add    $0x10,%esp
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104ac9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104acd:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104ad1:	7f 0b                	jg     80104ade <procdump+0xd3>
80104ad3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ad6:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104ada:	85 c0                	test   %eax,%eax
80104adc:	75 d3                	jne    80104ab1 <procdump+0xa6>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104ade:	83 ec 0c             	sub    $0xc,%esp
80104ae1:	68 d5 85 10 80       	push   $0x801085d5
80104ae6:	e8 d4 b8 ff ff       	call   801003bf <cprintf>
80104aeb:	83 c4 10             	add    $0x10,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104aee:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104af2:	81 7d f0 f4 1e 11 80 	cmpl   $0x80111ef4,-0x10(%ebp)
80104af9:	0f 82 1e ff ff ff    	jb     80104a1d <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104aff:	c9                   	leave  
80104b00:	c3                   	ret    

80104b01 <ps>:

int ps(void)
{
80104b01:	55                   	push   %ebp
80104b02:	89 e5                	mov    %esp,%ebp
80104b04:	83 ec 08             	sub    $0x8,%esp
	procdump();
80104b07:	e8 ff fe ff ff       	call   80104a0b <procdump>
	return 0;
80104b0c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104b11:	c9                   	leave  
80104b12:	c3                   	ret    

80104b13 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104b13:	55                   	push   %ebp
80104b14:	89 e5                	mov    %esp,%ebp
80104b16:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104b19:	9c                   	pushf  
80104b1a:	58                   	pop    %eax
80104b1b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104b1e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104b21:	c9                   	leave  
80104b22:	c3                   	ret    

80104b23 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80104b23:	55                   	push   %ebp
80104b24:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104b26:	fa                   	cli    
}
80104b27:	5d                   	pop    %ebp
80104b28:	c3                   	ret    

80104b29 <sti>:

static inline void
sti(void)
{
80104b29:	55                   	push   %ebp
80104b2a:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104b2c:	fb                   	sti    
}
80104b2d:	5d                   	pop    %ebp
80104b2e:	c3                   	ret    

80104b2f <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80104b2f:	55                   	push   %ebp
80104b30:	89 e5                	mov    %esp,%ebp
80104b32:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104b35:	8b 55 08             	mov    0x8(%ebp),%edx
80104b38:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b3b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b3e:	f0 87 02             	lock xchg %eax,(%edx)
80104b41:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104b44:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104b47:	c9                   	leave  
80104b48:	c3                   	ret    

80104b49 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104b49:	55                   	push   %ebp
80104b4a:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104b4c:	8b 45 08             	mov    0x8(%ebp),%eax
80104b4f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104b52:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104b55:	8b 45 08             	mov    0x8(%ebp),%eax
80104b58:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104b5e:	8b 45 08             	mov    0x8(%ebp),%eax
80104b61:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104b68:	5d                   	pop    %ebp
80104b69:	c3                   	ret    

80104b6a <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104b6a:	55                   	push   %ebp
80104b6b:	89 e5                	mov    %esp,%ebp
80104b6d:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104b70:	e8 4f 01 00 00       	call   80104cc4 <pushcli>
  if(holding(lk))
80104b75:	8b 45 08             	mov    0x8(%ebp),%eax
80104b78:	83 ec 0c             	sub    $0xc,%esp
80104b7b:	50                   	push   %eax
80104b7c:	e8 19 01 00 00       	call   80104c9a <holding>
80104b81:	83 c4 10             	add    $0x10,%esp
80104b84:	85 c0                	test   %eax,%eax
80104b86:	74 0d                	je     80104b95 <acquire+0x2b>
    panic("acquire");
80104b88:	83 ec 0c             	sub    $0xc,%esp
80104b8b:	68 01 86 10 80       	push   $0x80108601
80104b90:	e8 c7 b9 ff ff       	call   8010055c <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80104b95:	90                   	nop
80104b96:	8b 45 08             	mov    0x8(%ebp),%eax
80104b99:	83 ec 08             	sub    $0x8,%esp
80104b9c:	6a 01                	push   $0x1
80104b9e:	50                   	push   %eax
80104b9f:	e8 8b ff ff ff       	call   80104b2f <xchg>
80104ba4:	83 c4 10             	add    $0x10,%esp
80104ba7:	85 c0                	test   %eax,%eax
80104ba9:	75 eb                	jne    80104b96 <acquire+0x2c>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104bab:	8b 45 08             	mov    0x8(%ebp),%eax
80104bae:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104bb5:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104bb8:	8b 45 08             	mov    0x8(%ebp),%eax
80104bbb:	83 c0 0c             	add    $0xc,%eax
80104bbe:	83 ec 08             	sub    $0x8,%esp
80104bc1:	50                   	push   %eax
80104bc2:	8d 45 08             	lea    0x8(%ebp),%eax
80104bc5:	50                   	push   %eax
80104bc6:	e8 56 00 00 00       	call   80104c21 <getcallerpcs>
80104bcb:	83 c4 10             	add    $0x10,%esp
}
80104bce:	c9                   	leave  
80104bcf:	c3                   	ret    

80104bd0 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
80104bd6:	83 ec 0c             	sub    $0xc,%esp
80104bd9:	ff 75 08             	pushl  0x8(%ebp)
80104bdc:	e8 b9 00 00 00       	call   80104c9a <holding>
80104be1:	83 c4 10             	add    $0x10,%esp
80104be4:	85 c0                	test   %eax,%eax
80104be6:	75 0d                	jne    80104bf5 <release+0x25>
    panic("release");
80104be8:	83 ec 0c             	sub    $0xc,%esp
80104beb:	68 09 86 10 80       	push   $0x80108609
80104bf0:	e8 67 b9 ff ff       	call   8010055c <panic>

  lk->pcs[0] = 0;
80104bf5:	8b 45 08             	mov    0x8(%ebp),%eax
80104bf8:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104bff:	8b 45 08             	mov    0x8(%ebp),%eax
80104c02:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80104c09:	8b 45 08             	mov    0x8(%ebp),%eax
80104c0c:	83 ec 08             	sub    $0x8,%esp
80104c0f:	6a 00                	push   $0x0
80104c11:	50                   	push   %eax
80104c12:	e8 18 ff ff ff       	call   80104b2f <xchg>
80104c17:	83 c4 10             	add    $0x10,%esp

  popcli();
80104c1a:	e8 e9 00 00 00       	call   80104d08 <popcli>
}
80104c1f:	c9                   	leave  
80104c20:	c3                   	ret    

80104c21 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104c21:	55                   	push   %ebp
80104c22:	89 e5                	mov    %esp,%ebp
80104c24:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80104c27:	8b 45 08             	mov    0x8(%ebp),%eax
80104c2a:	83 e8 08             	sub    $0x8,%eax
80104c2d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80104c30:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80104c37:	eb 38                	jmp    80104c71 <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104c39:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80104c3d:	74 38                	je     80104c77 <getcallerpcs+0x56>
80104c3f:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80104c46:	76 2f                	jbe    80104c77 <getcallerpcs+0x56>
80104c48:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80104c4c:	74 29                	je     80104c77 <getcallerpcs+0x56>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104c4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104c51:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104c58:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c5b:	01 c2                	add    %eax,%edx
80104c5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c60:	8b 40 04             	mov    0x4(%eax),%eax
80104c63:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80104c65:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c68:	8b 00                	mov    (%eax),%eax
80104c6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104c6d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104c71:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104c75:	7e c2                	jle    80104c39 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104c77:	eb 19                	jmp    80104c92 <getcallerpcs+0x71>
    pcs[i] = 0;
80104c79:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104c7c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104c83:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c86:	01 d0                	add    %edx,%eax
80104c88:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104c8e:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104c92:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104c96:	7e e1                	jle    80104c79 <getcallerpcs+0x58>
    pcs[i] = 0;
}
80104c98:	c9                   	leave  
80104c99:	c3                   	ret    

80104c9a <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104c9a:	55                   	push   %ebp
80104c9b:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80104c9d:	8b 45 08             	mov    0x8(%ebp),%eax
80104ca0:	8b 00                	mov    (%eax),%eax
80104ca2:	85 c0                	test   %eax,%eax
80104ca4:	74 17                	je     80104cbd <holding+0x23>
80104ca6:	8b 45 08             	mov    0x8(%ebp),%eax
80104ca9:	8b 50 08             	mov    0x8(%eax),%edx
80104cac:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104cb2:	39 c2                	cmp    %eax,%edx
80104cb4:	75 07                	jne    80104cbd <holding+0x23>
80104cb6:	b8 01 00 00 00       	mov    $0x1,%eax
80104cbb:	eb 05                	jmp    80104cc2 <holding+0x28>
80104cbd:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104cc2:	5d                   	pop    %ebp
80104cc3:	c3                   	ret    

80104cc4 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104cc4:	55                   	push   %ebp
80104cc5:	89 e5                	mov    %esp,%ebp
80104cc7:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80104cca:	e8 44 fe ff ff       	call   80104b13 <readeflags>
80104ccf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80104cd2:	e8 4c fe ff ff       	call   80104b23 <cli>
  if(cpu->ncli++ == 0)
80104cd7:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104cde:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80104ce4:	8d 48 01             	lea    0x1(%eax),%ecx
80104ce7:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
80104ced:	85 c0                	test   %eax,%eax
80104cef:	75 15                	jne    80104d06 <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
80104cf1:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104cf7:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104cfa:	81 e2 00 02 00 00    	and    $0x200,%edx
80104d00:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104d06:	c9                   	leave  
80104d07:	c3                   	ret    

80104d08 <popcli>:

void
popcli(void)
{
80104d08:	55                   	push   %ebp
80104d09:	89 e5                	mov    %esp,%ebp
80104d0b:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
80104d0e:	e8 00 fe ff ff       	call   80104b13 <readeflags>
80104d13:	25 00 02 00 00       	and    $0x200,%eax
80104d18:	85 c0                	test   %eax,%eax
80104d1a:	74 0d                	je     80104d29 <popcli+0x21>
    panic("popcli - interruptible");
80104d1c:	83 ec 0c             	sub    $0xc,%esp
80104d1f:	68 11 86 10 80       	push   $0x80108611
80104d24:	e8 33 b8 ff ff       	call   8010055c <panic>
  if(--cpu->ncli < 0)
80104d29:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104d2f:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104d35:	83 ea 01             	sub    $0x1,%edx
80104d38:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80104d3e:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104d44:	85 c0                	test   %eax,%eax
80104d46:	79 0d                	jns    80104d55 <popcli+0x4d>
    panic("popcli");
80104d48:	83 ec 0c             	sub    $0xc,%esp
80104d4b:	68 28 86 10 80       	push   $0x80108628
80104d50:	e8 07 b8 ff ff       	call   8010055c <panic>
  if(cpu->ncli == 0 && cpu->intena)
80104d55:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104d5b:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104d61:	85 c0                	test   %eax,%eax
80104d63:	75 15                	jne    80104d7a <popcli+0x72>
80104d65:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104d6b:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104d71:	85 c0                	test   %eax,%eax
80104d73:	74 05                	je     80104d7a <popcli+0x72>
    sti();
80104d75:	e8 af fd ff ff       	call   80104b29 <sti>
}
80104d7a:	c9                   	leave  
80104d7b:	c3                   	ret    

80104d7c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
80104d7c:	55                   	push   %ebp
80104d7d:	89 e5                	mov    %esp,%ebp
80104d7f:	57                   	push   %edi
80104d80:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80104d81:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104d84:	8b 55 10             	mov    0x10(%ebp),%edx
80104d87:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d8a:	89 cb                	mov    %ecx,%ebx
80104d8c:	89 df                	mov    %ebx,%edi
80104d8e:	89 d1                	mov    %edx,%ecx
80104d90:	fc                   	cld    
80104d91:	f3 aa                	rep stos %al,%es:(%edi)
80104d93:	89 ca                	mov    %ecx,%edx
80104d95:	89 fb                	mov    %edi,%ebx
80104d97:	89 5d 08             	mov    %ebx,0x8(%ebp)
80104d9a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80104d9d:	5b                   	pop    %ebx
80104d9e:	5f                   	pop    %edi
80104d9f:	5d                   	pop    %ebp
80104da0:	c3                   	ret    

80104da1 <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
80104da1:	55                   	push   %ebp
80104da2:	89 e5                	mov    %esp,%ebp
80104da4:	57                   	push   %edi
80104da5:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80104da6:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104da9:	8b 55 10             	mov    0x10(%ebp),%edx
80104dac:	8b 45 0c             	mov    0xc(%ebp),%eax
80104daf:	89 cb                	mov    %ecx,%ebx
80104db1:	89 df                	mov    %ebx,%edi
80104db3:	89 d1                	mov    %edx,%ecx
80104db5:	fc                   	cld    
80104db6:	f3 ab                	rep stos %eax,%es:(%edi)
80104db8:	89 ca                	mov    %ecx,%edx
80104dba:	89 fb                	mov    %edi,%ebx
80104dbc:	89 5d 08             	mov    %ebx,0x8(%ebp)
80104dbf:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80104dc2:	5b                   	pop    %ebx
80104dc3:	5f                   	pop    %edi
80104dc4:	5d                   	pop    %ebp
80104dc5:	c3                   	ret    

80104dc6 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104dc6:	55                   	push   %ebp
80104dc7:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
80104dc9:	8b 45 08             	mov    0x8(%ebp),%eax
80104dcc:	83 e0 03             	and    $0x3,%eax
80104dcf:	85 c0                	test   %eax,%eax
80104dd1:	75 43                	jne    80104e16 <memset+0x50>
80104dd3:	8b 45 10             	mov    0x10(%ebp),%eax
80104dd6:	83 e0 03             	and    $0x3,%eax
80104dd9:	85 c0                	test   %eax,%eax
80104ddb:	75 39                	jne    80104e16 <memset+0x50>
    c &= 0xFF;
80104ddd:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104de4:	8b 45 10             	mov    0x10(%ebp),%eax
80104de7:	c1 e8 02             	shr    $0x2,%eax
80104dea:	89 c1                	mov    %eax,%ecx
80104dec:	8b 45 0c             	mov    0xc(%ebp),%eax
80104def:	c1 e0 18             	shl    $0x18,%eax
80104df2:	89 c2                	mov    %eax,%edx
80104df4:	8b 45 0c             	mov    0xc(%ebp),%eax
80104df7:	c1 e0 10             	shl    $0x10,%eax
80104dfa:	09 c2                	or     %eax,%edx
80104dfc:	8b 45 0c             	mov    0xc(%ebp),%eax
80104dff:	c1 e0 08             	shl    $0x8,%eax
80104e02:	09 d0                	or     %edx,%eax
80104e04:	0b 45 0c             	or     0xc(%ebp),%eax
80104e07:	51                   	push   %ecx
80104e08:	50                   	push   %eax
80104e09:	ff 75 08             	pushl  0x8(%ebp)
80104e0c:	e8 90 ff ff ff       	call   80104da1 <stosl>
80104e11:	83 c4 0c             	add    $0xc,%esp
80104e14:	eb 12                	jmp    80104e28 <memset+0x62>
  } else
    stosb(dst, c, n);
80104e16:	8b 45 10             	mov    0x10(%ebp),%eax
80104e19:	50                   	push   %eax
80104e1a:	ff 75 0c             	pushl  0xc(%ebp)
80104e1d:	ff 75 08             	pushl  0x8(%ebp)
80104e20:	e8 57 ff ff ff       	call   80104d7c <stosb>
80104e25:	83 c4 0c             	add    $0xc,%esp
  return dst;
80104e28:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104e2b:	c9                   	leave  
80104e2c:	c3                   	ret    

80104e2d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104e2d:	55                   	push   %ebp
80104e2e:	89 e5                	mov    %esp,%ebp
80104e30:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
80104e33:	8b 45 08             	mov    0x8(%ebp),%eax
80104e36:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
80104e39:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e3c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
80104e3f:	eb 30                	jmp    80104e71 <memcmp+0x44>
    if(*s1 != *s2)
80104e41:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104e44:	0f b6 10             	movzbl (%eax),%edx
80104e47:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104e4a:	0f b6 00             	movzbl (%eax),%eax
80104e4d:	38 c2                	cmp    %al,%dl
80104e4f:	74 18                	je     80104e69 <memcmp+0x3c>
      return *s1 - *s2;
80104e51:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104e54:	0f b6 00             	movzbl (%eax),%eax
80104e57:	0f b6 d0             	movzbl %al,%edx
80104e5a:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104e5d:	0f b6 00             	movzbl (%eax),%eax
80104e60:	0f b6 c0             	movzbl %al,%eax
80104e63:	29 c2                	sub    %eax,%edx
80104e65:	89 d0                	mov    %edx,%eax
80104e67:	eb 1a                	jmp    80104e83 <memcmp+0x56>
    s1++, s2++;
80104e69:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80104e6d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104e71:	8b 45 10             	mov    0x10(%ebp),%eax
80104e74:	8d 50 ff             	lea    -0x1(%eax),%edx
80104e77:	89 55 10             	mov    %edx,0x10(%ebp)
80104e7a:	85 c0                	test   %eax,%eax
80104e7c:	75 c3                	jne    80104e41 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80104e7e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104e83:	c9                   	leave  
80104e84:	c3                   	ret    

80104e85 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104e85:	55                   	push   %ebp
80104e86:	89 e5                	mov    %esp,%ebp
80104e88:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
80104e8b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e8e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80104e91:	8b 45 08             	mov    0x8(%ebp),%eax
80104e94:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80104e97:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104e9a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80104e9d:	73 3d                	jae    80104edc <memmove+0x57>
80104e9f:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104ea2:	8b 45 10             	mov    0x10(%ebp),%eax
80104ea5:	01 d0                	add    %edx,%eax
80104ea7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80104eaa:	76 30                	jbe    80104edc <memmove+0x57>
    s += n;
80104eac:	8b 45 10             	mov    0x10(%ebp),%eax
80104eaf:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80104eb2:	8b 45 10             	mov    0x10(%ebp),%eax
80104eb5:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
80104eb8:	eb 13                	jmp    80104ecd <memmove+0x48>
      *--d = *--s;
80104eba:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80104ebe:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80104ec2:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104ec5:	0f b6 10             	movzbl (%eax),%edx
80104ec8:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104ecb:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80104ecd:	8b 45 10             	mov    0x10(%ebp),%eax
80104ed0:	8d 50 ff             	lea    -0x1(%eax),%edx
80104ed3:	89 55 10             	mov    %edx,0x10(%ebp)
80104ed6:	85 c0                	test   %eax,%eax
80104ed8:	75 e0                	jne    80104eba <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104eda:	eb 26                	jmp    80104f02 <memmove+0x7d>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104edc:	eb 17                	jmp    80104ef5 <memmove+0x70>
      *d++ = *s++;
80104ede:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104ee1:	8d 50 01             	lea    0x1(%eax),%edx
80104ee4:	89 55 f8             	mov    %edx,-0x8(%ebp)
80104ee7:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104eea:	8d 4a 01             	lea    0x1(%edx),%ecx
80104eed:	89 4d fc             	mov    %ecx,-0x4(%ebp)
80104ef0:	0f b6 12             	movzbl (%edx),%edx
80104ef3:	88 10                	mov    %dl,(%eax)
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104ef5:	8b 45 10             	mov    0x10(%ebp),%eax
80104ef8:	8d 50 ff             	lea    -0x1(%eax),%edx
80104efb:	89 55 10             	mov    %edx,0x10(%ebp)
80104efe:	85 c0                	test   %eax,%eax
80104f00:	75 dc                	jne    80104ede <memmove+0x59>
      *d++ = *s++;

  return dst;
80104f02:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104f05:	c9                   	leave  
80104f06:	c3                   	ret    

80104f07 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104f07:	55                   	push   %ebp
80104f08:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
80104f0a:	ff 75 10             	pushl  0x10(%ebp)
80104f0d:	ff 75 0c             	pushl  0xc(%ebp)
80104f10:	ff 75 08             	pushl  0x8(%ebp)
80104f13:	e8 6d ff ff ff       	call   80104e85 <memmove>
80104f18:	83 c4 0c             	add    $0xc,%esp
}
80104f1b:	c9                   	leave  
80104f1c:	c3                   	ret    

80104f1d <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104f1d:	55                   	push   %ebp
80104f1e:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
80104f20:	eb 0c                	jmp    80104f2e <strncmp+0x11>
    n--, p++, q++;
80104f22:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80104f26:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80104f2a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104f2e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104f32:	74 1a                	je     80104f4e <strncmp+0x31>
80104f34:	8b 45 08             	mov    0x8(%ebp),%eax
80104f37:	0f b6 00             	movzbl (%eax),%eax
80104f3a:	84 c0                	test   %al,%al
80104f3c:	74 10                	je     80104f4e <strncmp+0x31>
80104f3e:	8b 45 08             	mov    0x8(%ebp),%eax
80104f41:	0f b6 10             	movzbl (%eax),%edx
80104f44:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f47:	0f b6 00             	movzbl (%eax),%eax
80104f4a:	38 c2                	cmp    %al,%dl
80104f4c:	74 d4                	je     80104f22 <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
80104f4e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104f52:	75 07                	jne    80104f5b <strncmp+0x3e>
    return 0;
80104f54:	b8 00 00 00 00       	mov    $0x0,%eax
80104f59:	eb 16                	jmp    80104f71 <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
80104f5b:	8b 45 08             	mov    0x8(%ebp),%eax
80104f5e:	0f b6 00             	movzbl (%eax),%eax
80104f61:	0f b6 d0             	movzbl %al,%edx
80104f64:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f67:	0f b6 00             	movzbl (%eax),%eax
80104f6a:	0f b6 c0             	movzbl %al,%eax
80104f6d:	29 c2                	sub    %eax,%edx
80104f6f:	89 d0                	mov    %edx,%eax
}
80104f71:	5d                   	pop    %ebp
80104f72:	c3                   	ret    

80104f73 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104f73:	55                   	push   %ebp
80104f74:	89 e5                	mov    %esp,%ebp
80104f76:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80104f79:	8b 45 08             	mov    0x8(%ebp),%eax
80104f7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
80104f7f:	90                   	nop
80104f80:	8b 45 10             	mov    0x10(%ebp),%eax
80104f83:	8d 50 ff             	lea    -0x1(%eax),%edx
80104f86:	89 55 10             	mov    %edx,0x10(%ebp)
80104f89:	85 c0                	test   %eax,%eax
80104f8b:	7e 1e                	jle    80104fab <strncpy+0x38>
80104f8d:	8b 45 08             	mov    0x8(%ebp),%eax
80104f90:	8d 50 01             	lea    0x1(%eax),%edx
80104f93:	89 55 08             	mov    %edx,0x8(%ebp)
80104f96:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f99:	8d 4a 01             	lea    0x1(%edx),%ecx
80104f9c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80104f9f:	0f b6 12             	movzbl (%edx),%edx
80104fa2:	88 10                	mov    %dl,(%eax)
80104fa4:	0f b6 00             	movzbl (%eax),%eax
80104fa7:	84 c0                	test   %al,%al
80104fa9:	75 d5                	jne    80104f80 <strncpy+0xd>
    ;
  while(n-- > 0)
80104fab:	eb 0c                	jmp    80104fb9 <strncpy+0x46>
    *s++ = 0;
80104fad:	8b 45 08             	mov    0x8(%ebp),%eax
80104fb0:	8d 50 01             	lea    0x1(%eax),%edx
80104fb3:	89 55 08             	mov    %edx,0x8(%ebp)
80104fb6:	c6 00 00             	movb   $0x0,(%eax)
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80104fb9:	8b 45 10             	mov    0x10(%ebp),%eax
80104fbc:	8d 50 ff             	lea    -0x1(%eax),%edx
80104fbf:	89 55 10             	mov    %edx,0x10(%ebp)
80104fc2:	85 c0                	test   %eax,%eax
80104fc4:	7f e7                	jg     80104fad <strncpy+0x3a>
    *s++ = 0;
  return os;
80104fc6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104fc9:	c9                   	leave  
80104fca:	c3                   	ret    

80104fcb <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104fcb:	55                   	push   %ebp
80104fcc:	89 e5                	mov    %esp,%ebp
80104fce:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80104fd1:	8b 45 08             	mov    0x8(%ebp),%eax
80104fd4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80104fd7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104fdb:	7f 05                	jg     80104fe2 <safestrcpy+0x17>
    return os;
80104fdd:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104fe0:	eb 31                	jmp    80105013 <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
80104fe2:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80104fe6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104fea:	7e 1e                	jle    8010500a <safestrcpy+0x3f>
80104fec:	8b 45 08             	mov    0x8(%ebp),%eax
80104fef:	8d 50 01             	lea    0x1(%eax),%edx
80104ff2:	89 55 08             	mov    %edx,0x8(%ebp)
80104ff5:	8b 55 0c             	mov    0xc(%ebp),%edx
80104ff8:	8d 4a 01             	lea    0x1(%edx),%ecx
80104ffb:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80104ffe:	0f b6 12             	movzbl (%edx),%edx
80105001:	88 10                	mov    %dl,(%eax)
80105003:	0f b6 00             	movzbl (%eax),%eax
80105006:	84 c0                	test   %al,%al
80105008:	75 d8                	jne    80104fe2 <safestrcpy+0x17>
    ;
  *s = 0;
8010500a:	8b 45 08             	mov    0x8(%ebp),%eax
8010500d:	c6 00 00             	movb   $0x0,(%eax)
  return os;
80105010:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105013:	c9                   	leave  
80105014:	c3                   	ret    

80105015 <strlen>:

int
strlen(const char *s)
{
80105015:	55                   	push   %ebp
80105016:	89 e5                	mov    %esp,%ebp
80105018:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
8010501b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105022:	eb 04                	jmp    80105028 <strlen+0x13>
80105024:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105028:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010502b:	8b 45 08             	mov    0x8(%ebp),%eax
8010502e:	01 d0                	add    %edx,%eax
80105030:	0f b6 00             	movzbl (%eax),%eax
80105033:	84 c0                	test   %al,%al
80105035:	75 ed                	jne    80105024 <strlen+0xf>
    ;
  return n;
80105037:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010503a:	c9                   	leave  
8010503b:	c3                   	ret    

8010503c <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010503c:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105040:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80105044:	55                   	push   %ebp
  pushl %ebx
80105045:	53                   	push   %ebx
  pushl %esi
80105046:	56                   	push   %esi
  pushl %edi
80105047:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105048:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
8010504a:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010504c:	5f                   	pop    %edi
  popl %esi
8010504d:	5e                   	pop    %esi
  popl %ebx
8010504e:	5b                   	pop    %ebx
  popl %ebp
8010504f:	5d                   	pop    %ebp
  ret
80105050:	c3                   	ret    

80105051 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105051:	55                   	push   %ebp
80105052:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80105054:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010505a:	8b 00                	mov    (%eax),%eax
8010505c:	3b 45 08             	cmp    0x8(%ebp),%eax
8010505f:	76 12                	jbe    80105073 <fetchint+0x22>
80105061:	8b 45 08             	mov    0x8(%ebp),%eax
80105064:	8d 50 04             	lea    0x4(%eax),%edx
80105067:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010506d:	8b 00                	mov    (%eax),%eax
8010506f:	39 c2                	cmp    %eax,%edx
80105071:	76 07                	jbe    8010507a <fetchint+0x29>
    return -1;
80105073:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105078:	eb 0f                	jmp    80105089 <fetchint+0x38>
  *ip = *(int*)(addr);
8010507a:	8b 45 08             	mov    0x8(%ebp),%eax
8010507d:	8b 10                	mov    (%eax),%edx
8010507f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105082:	89 10                	mov    %edx,(%eax)
  return 0;
80105084:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105089:	5d                   	pop    %ebp
8010508a:	c3                   	ret    

8010508b <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
8010508b:	55                   	push   %ebp
8010508c:	89 e5                	mov    %esp,%ebp
8010508e:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
80105091:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105097:	8b 00                	mov    (%eax),%eax
80105099:	3b 45 08             	cmp    0x8(%ebp),%eax
8010509c:	77 07                	ja     801050a5 <fetchstr+0x1a>
    return -1;
8010509e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050a3:	eb 46                	jmp    801050eb <fetchstr+0x60>
  *pp = (char*)addr;
801050a5:	8b 55 08             	mov    0x8(%ebp),%edx
801050a8:	8b 45 0c             	mov    0xc(%ebp),%eax
801050ab:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
801050ad:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801050b3:	8b 00                	mov    (%eax),%eax
801050b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
801050b8:	8b 45 0c             	mov    0xc(%ebp),%eax
801050bb:	8b 00                	mov    (%eax),%eax
801050bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
801050c0:	eb 1c                	jmp    801050de <fetchstr+0x53>
    if(*s == 0)
801050c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
801050c5:	0f b6 00             	movzbl (%eax),%eax
801050c8:	84 c0                	test   %al,%al
801050ca:	75 0e                	jne    801050da <fetchstr+0x4f>
      return s - *pp;
801050cc:	8b 55 fc             	mov    -0x4(%ebp),%edx
801050cf:	8b 45 0c             	mov    0xc(%ebp),%eax
801050d2:	8b 00                	mov    (%eax),%eax
801050d4:	29 c2                	sub    %eax,%edx
801050d6:	89 d0                	mov    %edx,%eax
801050d8:	eb 11                	jmp    801050eb <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801050da:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801050de:	8b 45 fc             	mov    -0x4(%ebp),%eax
801050e1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801050e4:	72 dc                	jb     801050c2 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
801050e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050eb:	c9                   	leave  
801050ec:	c3                   	ret    

801050ed <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801050ed:	55                   	push   %ebp
801050ee:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801050f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801050f6:	8b 40 18             	mov    0x18(%eax),%eax
801050f9:	8b 40 44             	mov    0x44(%eax),%eax
801050fc:	8b 55 08             	mov    0x8(%ebp),%edx
801050ff:	c1 e2 02             	shl    $0x2,%edx
80105102:	01 d0                	add    %edx,%eax
80105104:	83 c0 04             	add    $0x4,%eax
80105107:	ff 75 0c             	pushl  0xc(%ebp)
8010510a:	50                   	push   %eax
8010510b:	e8 41 ff ff ff       	call   80105051 <fetchint>
80105110:	83 c4 08             	add    $0x8,%esp
}
80105113:	c9                   	leave  
80105114:	c3                   	ret    

80105115 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105115:	55                   	push   %ebp
80105116:	89 e5                	mov    %esp,%ebp
80105118:	83 ec 10             	sub    $0x10,%esp
  int i;
  
  if(argint(n, &i) < 0)
8010511b:	8d 45 fc             	lea    -0x4(%ebp),%eax
8010511e:	50                   	push   %eax
8010511f:	ff 75 08             	pushl  0x8(%ebp)
80105122:	e8 c6 ff ff ff       	call   801050ed <argint>
80105127:	83 c4 08             	add    $0x8,%esp
8010512a:	85 c0                	test   %eax,%eax
8010512c:	79 07                	jns    80105135 <argptr+0x20>
    return -1;
8010512e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105133:	eb 3d                	jmp    80105172 <argptr+0x5d>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80105135:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105138:	89 c2                	mov    %eax,%edx
8010513a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105140:	8b 00                	mov    (%eax),%eax
80105142:	39 c2                	cmp    %eax,%edx
80105144:	73 16                	jae    8010515c <argptr+0x47>
80105146:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105149:	89 c2                	mov    %eax,%edx
8010514b:	8b 45 10             	mov    0x10(%ebp),%eax
8010514e:	01 c2                	add    %eax,%edx
80105150:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105156:	8b 00                	mov    (%eax),%eax
80105158:	39 c2                	cmp    %eax,%edx
8010515a:	76 07                	jbe    80105163 <argptr+0x4e>
    return -1;
8010515c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105161:	eb 0f                	jmp    80105172 <argptr+0x5d>
  *pp = (char*)i;
80105163:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105166:	89 c2                	mov    %eax,%edx
80105168:	8b 45 0c             	mov    0xc(%ebp),%eax
8010516b:	89 10                	mov    %edx,(%eax)
  return 0;
8010516d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105172:	c9                   	leave  
80105173:	c3                   	ret    

80105174 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105174:	55                   	push   %ebp
80105175:	89 e5                	mov    %esp,%ebp
80105177:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
8010517a:	8d 45 fc             	lea    -0x4(%ebp),%eax
8010517d:	50                   	push   %eax
8010517e:	ff 75 08             	pushl  0x8(%ebp)
80105181:	e8 67 ff ff ff       	call   801050ed <argint>
80105186:	83 c4 08             	add    $0x8,%esp
80105189:	85 c0                	test   %eax,%eax
8010518b:	79 07                	jns    80105194 <argstr+0x20>
    return -1;
8010518d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105192:	eb 0f                	jmp    801051a3 <argstr+0x2f>
  return fetchstr(addr, pp);
80105194:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105197:	ff 75 0c             	pushl  0xc(%ebp)
8010519a:	50                   	push   %eax
8010519b:	e8 eb fe ff ff       	call   8010508b <fetchstr>
801051a0:	83 c4 08             	add    $0x8,%esp
}
801051a3:	c9                   	leave  
801051a4:	c3                   	ret    

801051a5 <syscall>:
[SYS_ps]	sys_ps,
};

void
syscall(void)
{
801051a5:	55                   	push   %ebp
801051a6:	89 e5                	mov    %esp,%ebp
801051a8:	53                   	push   %ebx
801051a9:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
801051ac:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801051b2:	8b 40 18             	mov    0x18(%eax),%eax
801051b5:	8b 40 1c             	mov    0x1c(%eax),%eax
801051b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801051bb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801051bf:	7e 30                	jle    801051f1 <syscall+0x4c>
801051c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051c4:	83 f8 17             	cmp    $0x17,%eax
801051c7:	77 28                	ja     801051f1 <syscall+0x4c>
801051c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051cc:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
801051d3:	85 c0                	test   %eax,%eax
801051d5:	74 1a                	je     801051f1 <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
801051d7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801051dd:	8b 58 18             	mov    0x18(%eax),%ebx
801051e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051e3:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
801051ea:	ff d0                	call   *%eax
801051ec:	89 43 1c             	mov    %eax,0x1c(%ebx)
801051ef:	eb 34                	jmp    80105225 <syscall+0x80>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
801051f1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801051f7:	8d 50 6c             	lea    0x6c(%eax),%edx
801051fa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105200:	8b 40 10             	mov    0x10(%eax),%eax
80105203:	ff 75 f4             	pushl  -0xc(%ebp)
80105206:	52                   	push   %edx
80105207:	50                   	push   %eax
80105208:	68 2f 86 10 80       	push   $0x8010862f
8010520d:	e8 ad b1 ff ff       	call   801003bf <cprintf>
80105212:	83 c4 10             	add    $0x10,%esp
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
80105215:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010521b:	8b 40 18             	mov    0x18(%eax),%eax
8010521e:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80105225:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105228:	c9                   	leave  
80105229:	c3                   	ret    

8010522a <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
8010522a:	55                   	push   %ebp
8010522b:	89 e5                	mov    %esp,%ebp
8010522d:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80105230:	83 ec 08             	sub    $0x8,%esp
80105233:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105236:	50                   	push   %eax
80105237:	ff 75 08             	pushl  0x8(%ebp)
8010523a:	e8 ae fe ff ff       	call   801050ed <argint>
8010523f:	83 c4 10             	add    $0x10,%esp
80105242:	85 c0                	test   %eax,%eax
80105244:	79 07                	jns    8010524d <argfd+0x23>
    return -1;
80105246:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010524b:	eb 50                	jmp    8010529d <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
8010524d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105250:	85 c0                	test   %eax,%eax
80105252:	78 21                	js     80105275 <argfd+0x4b>
80105254:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105257:	83 f8 0f             	cmp    $0xf,%eax
8010525a:	7f 19                	jg     80105275 <argfd+0x4b>
8010525c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105262:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105265:	83 c2 08             	add    $0x8,%edx
80105268:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010526c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010526f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105273:	75 07                	jne    8010527c <argfd+0x52>
    return -1;
80105275:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010527a:	eb 21                	jmp    8010529d <argfd+0x73>
  if(pfd)
8010527c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105280:	74 08                	je     8010528a <argfd+0x60>
    *pfd = fd;
80105282:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105285:	8b 45 0c             	mov    0xc(%ebp),%eax
80105288:	89 10                	mov    %edx,(%eax)
  if(pf)
8010528a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010528e:	74 08                	je     80105298 <argfd+0x6e>
    *pf = f;
80105290:	8b 45 10             	mov    0x10(%ebp),%eax
80105293:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105296:	89 10                	mov    %edx,(%eax)
  return 0;
80105298:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010529d:	c9                   	leave  
8010529e:	c3                   	ret    

8010529f <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
8010529f:	55                   	push   %ebp
801052a0:	89 e5                	mov    %esp,%ebp
801052a2:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801052a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801052ac:	eb 30                	jmp    801052de <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
801052ae:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801052b4:	8b 55 fc             	mov    -0x4(%ebp),%edx
801052b7:	83 c2 08             	add    $0x8,%edx
801052ba:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801052be:	85 c0                	test   %eax,%eax
801052c0:	75 18                	jne    801052da <fdalloc+0x3b>
      proc->ofile[fd] = f;
801052c2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801052c8:	8b 55 fc             	mov    -0x4(%ebp),%edx
801052cb:	8d 4a 08             	lea    0x8(%edx),%ecx
801052ce:	8b 55 08             	mov    0x8(%ebp),%edx
801052d1:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
801052d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052d8:	eb 0f                	jmp    801052e9 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801052da:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801052de:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
801052e2:	7e ca                	jle    801052ae <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
801052e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052e9:	c9                   	leave  
801052ea:	c3                   	ret    

801052eb <sys_dup>:

int
sys_dup(void)
{
801052eb:	55                   	push   %ebp
801052ec:	89 e5                	mov    %esp,%ebp
801052ee:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
801052f1:	83 ec 04             	sub    $0x4,%esp
801052f4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801052f7:	50                   	push   %eax
801052f8:	6a 00                	push   $0x0
801052fa:	6a 00                	push   $0x0
801052fc:	e8 29 ff ff ff       	call   8010522a <argfd>
80105301:	83 c4 10             	add    $0x10,%esp
80105304:	85 c0                	test   %eax,%eax
80105306:	79 07                	jns    8010530f <sys_dup+0x24>
    return -1;
80105308:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010530d:	eb 31                	jmp    80105340 <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
8010530f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105312:	83 ec 0c             	sub    $0xc,%esp
80105315:	50                   	push   %eax
80105316:	e8 84 ff ff ff       	call   8010529f <fdalloc>
8010531b:	83 c4 10             	add    $0x10,%esp
8010531e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105321:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105325:	79 07                	jns    8010532e <sys_dup+0x43>
    return -1;
80105327:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010532c:	eb 12                	jmp    80105340 <sys_dup+0x55>
  filedup(f);
8010532e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105331:	83 ec 0c             	sub    $0xc,%esp
80105334:	50                   	push   %eax
80105335:	e8 79 bc ff ff       	call   80100fb3 <filedup>
8010533a:	83 c4 10             	add    $0x10,%esp
  return fd;
8010533d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105340:	c9                   	leave  
80105341:	c3                   	ret    

80105342 <sys_read>:

int
sys_read(void)
{
80105342:	55                   	push   %ebp
80105343:	89 e5                	mov    %esp,%ebp
80105345:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105348:	83 ec 04             	sub    $0x4,%esp
8010534b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010534e:	50                   	push   %eax
8010534f:	6a 00                	push   $0x0
80105351:	6a 00                	push   $0x0
80105353:	e8 d2 fe ff ff       	call   8010522a <argfd>
80105358:	83 c4 10             	add    $0x10,%esp
8010535b:	85 c0                	test   %eax,%eax
8010535d:	78 2e                	js     8010538d <sys_read+0x4b>
8010535f:	83 ec 08             	sub    $0x8,%esp
80105362:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105365:	50                   	push   %eax
80105366:	6a 02                	push   $0x2
80105368:	e8 80 fd ff ff       	call   801050ed <argint>
8010536d:	83 c4 10             	add    $0x10,%esp
80105370:	85 c0                	test   %eax,%eax
80105372:	78 19                	js     8010538d <sys_read+0x4b>
80105374:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105377:	83 ec 04             	sub    $0x4,%esp
8010537a:	50                   	push   %eax
8010537b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010537e:	50                   	push   %eax
8010537f:	6a 01                	push   $0x1
80105381:	e8 8f fd ff ff       	call   80105115 <argptr>
80105386:	83 c4 10             	add    $0x10,%esp
80105389:	85 c0                	test   %eax,%eax
8010538b:	79 07                	jns    80105394 <sys_read+0x52>
    return -1;
8010538d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105392:	eb 17                	jmp    801053ab <sys_read+0x69>
  return fileread(f, p, n);
80105394:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105397:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010539a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010539d:	83 ec 04             	sub    $0x4,%esp
801053a0:	51                   	push   %ecx
801053a1:	52                   	push   %edx
801053a2:	50                   	push   %eax
801053a3:	e8 9b bd ff ff       	call   80101143 <fileread>
801053a8:	83 c4 10             	add    $0x10,%esp
}
801053ab:	c9                   	leave  
801053ac:	c3                   	ret    

801053ad <sys_write>:

int
sys_write(void)
{
801053ad:	55                   	push   %ebp
801053ae:	89 e5                	mov    %esp,%ebp
801053b0:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053b3:	83 ec 04             	sub    $0x4,%esp
801053b6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053b9:	50                   	push   %eax
801053ba:	6a 00                	push   $0x0
801053bc:	6a 00                	push   $0x0
801053be:	e8 67 fe ff ff       	call   8010522a <argfd>
801053c3:	83 c4 10             	add    $0x10,%esp
801053c6:	85 c0                	test   %eax,%eax
801053c8:	78 2e                	js     801053f8 <sys_write+0x4b>
801053ca:	83 ec 08             	sub    $0x8,%esp
801053cd:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053d0:	50                   	push   %eax
801053d1:	6a 02                	push   $0x2
801053d3:	e8 15 fd ff ff       	call   801050ed <argint>
801053d8:	83 c4 10             	add    $0x10,%esp
801053db:	85 c0                	test   %eax,%eax
801053dd:	78 19                	js     801053f8 <sys_write+0x4b>
801053df:	8b 45 f0             	mov    -0x10(%ebp),%eax
801053e2:	83 ec 04             	sub    $0x4,%esp
801053e5:	50                   	push   %eax
801053e6:	8d 45 ec             	lea    -0x14(%ebp),%eax
801053e9:	50                   	push   %eax
801053ea:	6a 01                	push   $0x1
801053ec:	e8 24 fd ff ff       	call   80105115 <argptr>
801053f1:	83 c4 10             	add    $0x10,%esp
801053f4:	85 c0                	test   %eax,%eax
801053f6:	79 07                	jns    801053ff <sys_write+0x52>
    return -1;
801053f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053fd:	eb 17                	jmp    80105416 <sys_write+0x69>
  return filewrite(f, p, n);
801053ff:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105402:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105405:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105408:	83 ec 04             	sub    $0x4,%esp
8010540b:	51                   	push   %ecx
8010540c:	52                   	push   %edx
8010540d:	50                   	push   %eax
8010540e:	e8 e8 bd ff ff       	call   801011fb <filewrite>
80105413:	83 c4 10             	add    $0x10,%esp
}
80105416:	c9                   	leave  
80105417:	c3                   	ret    

80105418 <sys_close>:

int
sys_close(void)
{
80105418:	55                   	push   %ebp
80105419:	89 e5                	mov    %esp,%ebp
8010541b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
8010541e:	83 ec 04             	sub    $0x4,%esp
80105421:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105424:	50                   	push   %eax
80105425:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105428:	50                   	push   %eax
80105429:	6a 00                	push   $0x0
8010542b:	e8 fa fd ff ff       	call   8010522a <argfd>
80105430:	83 c4 10             	add    $0x10,%esp
80105433:	85 c0                	test   %eax,%eax
80105435:	79 07                	jns    8010543e <sys_close+0x26>
    return -1;
80105437:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010543c:	eb 28                	jmp    80105466 <sys_close+0x4e>
  proc->ofile[fd] = 0;
8010543e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105444:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105447:	83 c2 08             	add    $0x8,%edx
8010544a:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105451:	00 
  fileclose(f);
80105452:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105455:	83 ec 0c             	sub    $0xc,%esp
80105458:	50                   	push   %eax
80105459:	e8 a6 bb ff ff       	call   80101004 <fileclose>
8010545e:	83 c4 10             	add    $0x10,%esp
  return 0;
80105461:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105466:	c9                   	leave  
80105467:	c3                   	ret    

80105468 <sys_fstat>:

int
sys_fstat(void)
{
80105468:	55                   	push   %ebp
80105469:	89 e5                	mov    %esp,%ebp
8010546b:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
8010546e:	83 ec 04             	sub    $0x4,%esp
80105471:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105474:	50                   	push   %eax
80105475:	6a 00                	push   $0x0
80105477:	6a 00                	push   $0x0
80105479:	e8 ac fd ff ff       	call   8010522a <argfd>
8010547e:	83 c4 10             	add    $0x10,%esp
80105481:	85 c0                	test   %eax,%eax
80105483:	78 17                	js     8010549c <sys_fstat+0x34>
80105485:	83 ec 04             	sub    $0x4,%esp
80105488:	6a 14                	push   $0x14
8010548a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010548d:	50                   	push   %eax
8010548e:	6a 01                	push   $0x1
80105490:	e8 80 fc ff ff       	call   80105115 <argptr>
80105495:	83 c4 10             	add    $0x10,%esp
80105498:	85 c0                	test   %eax,%eax
8010549a:	79 07                	jns    801054a3 <sys_fstat+0x3b>
    return -1;
8010549c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054a1:	eb 13                	jmp    801054b6 <sys_fstat+0x4e>
  return filestat(f, st);
801054a3:	8b 55 f0             	mov    -0x10(%ebp),%edx
801054a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054a9:	83 ec 08             	sub    $0x8,%esp
801054ac:	52                   	push   %edx
801054ad:	50                   	push   %eax
801054ae:	e8 39 bc ff ff       	call   801010ec <filestat>
801054b3:	83 c4 10             	add    $0x10,%esp
}
801054b6:	c9                   	leave  
801054b7:	c3                   	ret    

801054b8 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
801054b8:	55                   	push   %ebp
801054b9:	89 e5                	mov    %esp,%ebp
801054bb:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801054be:	83 ec 08             	sub    $0x8,%esp
801054c1:	8d 45 d8             	lea    -0x28(%ebp),%eax
801054c4:	50                   	push   %eax
801054c5:	6a 00                	push   $0x0
801054c7:	e8 a8 fc ff ff       	call   80105174 <argstr>
801054cc:	83 c4 10             	add    $0x10,%esp
801054cf:	85 c0                	test   %eax,%eax
801054d1:	78 15                	js     801054e8 <sys_link+0x30>
801054d3:	83 ec 08             	sub    $0x8,%esp
801054d6:	8d 45 dc             	lea    -0x24(%ebp),%eax
801054d9:	50                   	push   %eax
801054da:	6a 01                	push   $0x1
801054dc:	e8 93 fc ff ff       	call   80105174 <argstr>
801054e1:	83 c4 10             	add    $0x10,%esp
801054e4:	85 c0                	test   %eax,%eax
801054e6:	79 0a                	jns    801054f2 <sys_link+0x3a>
    return -1;
801054e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054ed:	e9 64 01 00 00       	jmp    80105656 <sys_link+0x19e>
  if((ip = namei(old)) == 0)
801054f2:	8b 45 d8             	mov    -0x28(%ebp),%eax
801054f5:	83 ec 0c             	sub    $0xc,%esp
801054f8:	50                   	push   %eax
801054f9:	e8 8b cf ff ff       	call   80102489 <namei>
801054fe:	83 c4 10             	add    $0x10,%esp
80105501:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105504:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105508:	75 0a                	jne    80105514 <sys_link+0x5c>
    return -1;
8010550a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010550f:	e9 42 01 00 00       	jmp    80105656 <sys_link+0x19e>

  begin_trans();
80105514:	e8 21 dd ff ff       	call   8010323a <begin_trans>

  ilock(ip);
80105519:	83 ec 0c             	sub    $0xc,%esp
8010551c:	ff 75 f4             	pushl  -0xc(%ebp)
8010551f:	e8 a2 c3 ff ff       	call   801018c6 <ilock>
80105524:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
80105527:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010552a:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010552e:	66 83 f8 01          	cmp    $0x1,%ax
80105532:	75 1d                	jne    80105551 <sys_link+0x99>
    iunlockput(ip);
80105534:	83 ec 0c             	sub    $0xc,%esp
80105537:	ff 75 f4             	pushl  -0xc(%ebp)
8010553a:	e8 3e c6 ff ff       	call   80101b7d <iunlockput>
8010553f:	83 c4 10             	add    $0x10,%esp
    commit_trans();
80105542:	e8 45 dd ff ff       	call   8010328c <commit_trans>
    return -1;
80105547:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010554c:	e9 05 01 00 00       	jmp    80105656 <sys_link+0x19e>
  }

  ip->nlink++;
80105551:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105554:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105558:	83 c0 01             	add    $0x1,%eax
8010555b:	89 c2                	mov    %eax,%edx
8010555d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105560:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105564:	83 ec 0c             	sub    $0xc,%esp
80105567:	ff 75 f4             	pushl  -0xc(%ebp)
8010556a:	e8 84 c1 ff ff       	call   801016f3 <iupdate>
8010556f:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80105572:	83 ec 0c             	sub    $0xc,%esp
80105575:	ff 75 f4             	pushl  -0xc(%ebp)
80105578:	e8 a0 c4 ff ff       	call   80101a1d <iunlock>
8010557d:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
80105580:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105583:	83 ec 08             	sub    $0x8,%esp
80105586:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105589:	52                   	push   %edx
8010558a:	50                   	push   %eax
8010558b:	e8 15 cf ff ff       	call   801024a5 <nameiparent>
80105590:	83 c4 10             	add    $0x10,%esp
80105593:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105596:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010559a:	75 02                	jne    8010559e <sys_link+0xe6>
    goto bad;
8010559c:	eb 71                	jmp    8010560f <sys_link+0x157>
  ilock(dp);
8010559e:	83 ec 0c             	sub    $0xc,%esp
801055a1:	ff 75 f0             	pushl  -0x10(%ebp)
801055a4:	e8 1d c3 ff ff       	call   801018c6 <ilock>
801055a9:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801055ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801055af:	8b 10                	mov    (%eax),%edx
801055b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055b4:	8b 00                	mov    (%eax),%eax
801055b6:	39 c2                	cmp    %eax,%edx
801055b8:	75 1d                	jne    801055d7 <sys_link+0x11f>
801055ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055bd:	8b 40 04             	mov    0x4(%eax),%eax
801055c0:	83 ec 04             	sub    $0x4,%esp
801055c3:	50                   	push   %eax
801055c4:	8d 45 e2             	lea    -0x1e(%ebp),%eax
801055c7:	50                   	push   %eax
801055c8:	ff 75 f0             	pushl  -0x10(%ebp)
801055cb:	e8 21 cc ff ff       	call   801021f1 <dirlink>
801055d0:	83 c4 10             	add    $0x10,%esp
801055d3:	85 c0                	test   %eax,%eax
801055d5:	79 10                	jns    801055e7 <sys_link+0x12f>
    iunlockput(dp);
801055d7:	83 ec 0c             	sub    $0xc,%esp
801055da:	ff 75 f0             	pushl  -0x10(%ebp)
801055dd:	e8 9b c5 ff ff       	call   80101b7d <iunlockput>
801055e2:	83 c4 10             	add    $0x10,%esp
    goto bad;
801055e5:	eb 28                	jmp    8010560f <sys_link+0x157>
  }
  iunlockput(dp);
801055e7:	83 ec 0c             	sub    $0xc,%esp
801055ea:	ff 75 f0             	pushl  -0x10(%ebp)
801055ed:	e8 8b c5 ff ff       	call   80101b7d <iunlockput>
801055f2:	83 c4 10             	add    $0x10,%esp
  iput(ip);
801055f5:	83 ec 0c             	sub    $0xc,%esp
801055f8:	ff 75 f4             	pushl  -0xc(%ebp)
801055fb:	e8 8e c4 ff ff       	call   80101a8e <iput>
80105600:	83 c4 10             	add    $0x10,%esp

  commit_trans();
80105603:	e8 84 dc ff ff       	call   8010328c <commit_trans>

  return 0;
80105608:	b8 00 00 00 00       	mov    $0x0,%eax
8010560d:	eb 47                	jmp    80105656 <sys_link+0x19e>

bad:
  ilock(ip);
8010560f:	83 ec 0c             	sub    $0xc,%esp
80105612:	ff 75 f4             	pushl  -0xc(%ebp)
80105615:	e8 ac c2 ff ff       	call   801018c6 <ilock>
8010561a:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
8010561d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105620:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105624:	83 e8 01             	sub    $0x1,%eax
80105627:	89 c2                	mov    %eax,%edx
80105629:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010562c:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105630:	83 ec 0c             	sub    $0xc,%esp
80105633:	ff 75 f4             	pushl  -0xc(%ebp)
80105636:	e8 b8 c0 ff ff       	call   801016f3 <iupdate>
8010563b:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
8010563e:	83 ec 0c             	sub    $0xc,%esp
80105641:	ff 75 f4             	pushl  -0xc(%ebp)
80105644:	e8 34 c5 ff ff       	call   80101b7d <iunlockput>
80105649:	83 c4 10             	add    $0x10,%esp
  commit_trans();
8010564c:	e8 3b dc ff ff       	call   8010328c <commit_trans>
  return -1;
80105651:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105656:	c9                   	leave  
80105657:	c3                   	ret    

80105658 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105658:	55                   	push   %ebp
80105659:	89 e5                	mov    %esp,%ebp
8010565b:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
8010565e:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105665:	eb 40                	jmp    801056a7 <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105667:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010566a:	6a 10                	push   $0x10
8010566c:	50                   	push   %eax
8010566d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105670:	50                   	push   %eax
80105671:	ff 75 08             	pushl  0x8(%ebp)
80105674:	e8 af c7 ff ff       	call   80101e28 <readi>
80105679:	83 c4 10             	add    $0x10,%esp
8010567c:	83 f8 10             	cmp    $0x10,%eax
8010567f:	74 0d                	je     8010568e <isdirempty+0x36>
      panic("isdirempty: readi");
80105681:	83 ec 0c             	sub    $0xc,%esp
80105684:	68 4c 86 10 80       	push   $0x8010864c
80105689:	e8 ce ae ff ff       	call   8010055c <panic>
    if(de.inum != 0)
8010568e:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105692:	66 85 c0             	test   %ax,%ax
80105695:	74 07                	je     8010569e <isdirempty+0x46>
      return 0;
80105697:	b8 00 00 00 00       	mov    $0x0,%eax
8010569c:	eb 1b                	jmp    801056b9 <isdirempty+0x61>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
8010569e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056a1:	83 c0 10             	add    $0x10,%eax
801056a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801056a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801056aa:	8b 45 08             	mov    0x8(%ebp),%eax
801056ad:	8b 40 18             	mov    0x18(%eax),%eax
801056b0:	39 c2                	cmp    %eax,%edx
801056b2:	72 b3                	jb     80105667 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
801056b4:	b8 01 00 00 00       	mov    $0x1,%eax
}
801056b9:	c9                   	leave  
801056ba:	c3                   	ret    

801056bb <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
801056bb:	55                   	push   %ebp
801056bc:	89 e5                	mov    %esp,%ebp
801056be:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801056c1:	83 ec 08             	sub    $0x8,%esp
801056c4:	8d 45 cc             	lea    -0x34(%ebp),%eax
801056c7:	50                   	push   %eax
801056c8:	6a 00                	push   $0x0
801056ca:	e8 a5 fa ff ff       	call   80105174 <argstr>
801056cf:	83 c4 10             	add    $0x10,%esp
801056d2:	85 c0                	test   %eax,%eax
801056d4:	79 0a                	jns    801056e0 <sys_unlink+0x25>
    return -1;
801056d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056db:	e9 b7 01 00 00       	jmp    80105897 <sys_unlink+0x1dc>
  if((dp = nameiparent(path, name)) == 0)
801056e0:	8b 45 cc             	mov    -0x34(%ebp),%eax
801056e3:	83 ec 08             	sub    $0x8,%esp
801056e6:	8d 55 d2             	lea    -0x2e(%ebp),%edx
801056e9:	52                   	push   %edx
801056ea:	50                   	push   %eax
801056eb:	e8 b5 cd ff ff       	call   801024a5 <nameiparent>
801056f0:	83 c4 10             	add    $0x10,%esp
801056f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801056f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801056fa:	75 0a                	jne    80105706 <sys_unlink+0x4b>
    return -1;
801056fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105701:	e9 91 01 00 00       	jmp    80105897 <sys_unlink+0x1dc>

  begin_trans();
80105706:	e8 2f db ff ff       	call   8010323a <begin_trans>

  ilock(dp);
8010570b:	83 ec 0c             	sub    $0xc,%esp
8010570e:	ff 75 f4             	pushl  -0xc(%ebp)
80105711:	e8 b0 c1 ff ff       	call   801018c6 <ilock>
80105716:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105719:	83 ec 08             	sub    $0x8,%esp
8010571c:	68 5e 86 10 80       	push   $0x8010865e
80105721:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105724:	50                   	push   %eax
80105725:	e8 f1 c9 ff ff       	call   8010211b <namecmp>
8010572a:	83 c4 10             	add    $0x10,%esp
8010572d:	85 c0                	test   %eax,%eax
8010572f:	0f 84 4a 01 00 00    	je     8010587f <sys_unlink+0x1c4>
80105735:	83 ec 08             	sub    $0x8,%esp
80105738:	68 60 86 10 80       	push   $0x80108660
8010573d:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105740:	50                   	push   %eax
80105741:	e8 d5 c9 ff ff       	call   8010211b <namecmp>
80105746:	83 c4 10             	add    $0x10,%esp
80105749:	85 c0                	test   %eax,%eax
8010574b:	0f 84 2e 01 00 00    	je     8010587f <sys_unlink+0x1c4>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105751:	83 ec 04             	sub    $0x4,%esp
80105754:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105757:	50                   	push   %eax
80105758:	8d 45 d2             	lea    -0x2e(%ebp),%eax
8010575b:	50                   	push   %eax
8010575c:	ff 75 f4             	pushl  -0xc(%ebp)
8010575f:	e8 d2 c9 ff ff       	call   80102136 <dirlookup>
80105764:	83 c4 10             	add    $0x10,%esp
80105767:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010576a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010576e:	75 05                	jne    80105775 <sys_unlink+0xba>
    goto bad;
80105770:	e9 0a 01 00 00       	jmp    8010587f <sys_unlink+0x1c4>
  ilock(ip);
80105775:	83 ec 0c             	sub    $0xc,%esp
80105778:	ff 75 f0             	pushl  -0x10(%ebp)
8010577b:	e8 46 c1 ff ff       	call   801018c6 <ilock>
80105780:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105783:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105786:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010578a:	66 85 c0             	test   %ax,%ax
8010578d:	7f 0d                	jg     8010579c <sys_unlink+0xe1>
    panic("unlink: nlink < 1");
8010578f:	83 ec 0c             	sub    $0xc,%esp
80105792:	68 63 86 10 80       	push   $0x80108663
80105797:	e8 c0 ad ff ff       	call   8010055c <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010579c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010579f:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801057a3:	66 83 f8 01          	cmp    $0x1,%ax
801057a7:	75 25                	jne    801057ce <sys_unlink+0x113>
801057a9:	83 ec 0c             	sub    $0xc,%esp
801057ac:	ff 75 f0             	pushl  -0x10(%ebp)
801057af:	e8 a4 fe ff ff       	call   80105658 <isdirempty>
801057b4:	83 c4 10             	add    $0x10,%esp
801057b7:	85 c0                	test   %eax,%eax
801057b9:	75 13                	jne    801057ce <sys_unlink+0x113>
    iunlockput(ip);
801057bb:	83 ec 0c             	sub    $0xc,%esp
801057be:	ff 75 f0             	pushl  -0x10(%ebp)
801057c1:	e8 b7 c3 ff ff       	call   80101b7d <iunlockput>
801057c6:	83 c4 10             	add    $0x10,%esp
    goto bad;
801057c9:	e9 b1 00 00 00       	jmp    8010587f <sys_unlink+0x1c4>
  }

  memset(&de, 0, sizeof(de));
801057ce:	83 ec 04             	sub    $0x4,%esp
801057d1:	6a 10                	push   $0x10
801057d3:	6a 00                	push   $0x0
801057d5:	8d 45 e0             	lea    -0x20(%ebp),%eax
801057d8:	50                   	push   %eax
801057d9:	e8 e8 f5 ff ff       	call   80104dc6 <memset>
801057de:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801057e1:	8b 45 c8             	mov    -0x38(%ebp),%eax
801057e4:	6a 10                	push   $0x10
801057e6:	50                   	push   %eax
801057e7:	8d 45 e0             	lea    -0x20(%ebp),%eax
801057ea:	50                   	push   %eax
801057eb:	ff 75 f4             	pushl  -0xc(%ebp)
801057ee:	e8 96 c7 ff ff       	call   80101f89 <writei>
801057f3:	83 c4 10             	add    $0x10,%esp
801057f6:	83 f8 10             	cmp    $0x10,%eax
801057f9:	74 0d                	je     80105808 <sys_unlink+0x14d>
    panic("unlink: writei");
801057fb:	83 ec 0c             	sub    $0xc,%esp
801057fe:	68 75 86 10 80       	push   $0x80108675
80105803:	e8 54 ad ff ff       	call   8010055c <panic>
  if(ip->type == T_DIR){
80105808:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010580b:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010580f:	66 83 f8 01          	cmp    $0x1,%ax
80105813:	75 21                	jne    80105836 <sys_unlink+0x17b>
    dp->nlink--;
80105815:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105818:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010581c:	83 e8 01             	sub    $0x1,%eax
8010581f:	89 c2                	mov    %eax,%edx
80105821:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105824:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105828:	83 ec 0c             	sub    $0xc,%esp
8010582b:	ff 75 f4             	pushl  -0xc(%ebp)
8010582e:	e8 c0 be ff ff       	call   801016f3 <iupdate>
80105833:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80105836:	83 ec 0c             	sub    $0xc,%esp
80105839:	ff 75 f4             	pushl  -0xc(%ebp)
8010583c:	e8 3c c3 ff ff       	call   80101b7d <iunlockput>
80105841:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80105844:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105847:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010584b:	83 e8 01             	sub    $0x1,%eax
8010584e:	89 c2                	mov    %eax,%edx
80105850:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105853:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105857:	83 ec 0c             	sub    $0xc,%esp
8010585a:	ff 75 f0             	pushl  -0x10(%ebp)
8010585d:	e8 91 be ff ff       	call   801016f3 <iupdate>
80105862:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105865:	83 ec 0c             	sub    $0xc,%esp
80105868:	ff 75 f0             	pushl  -0x10(%ebp)
8010586b:	e8 0d c3 ff ff       	call   80101b7d <iunlockput>
80105870:	83 c4 10             	add    $0x10,%esp

  commit_trans();
80105873:	e8 14 da ff ff       	call   8010328c <commit_trans>

  return 0;
80105878:	b8 00 00 00 00       	mov    $0x0,%eax
8010587d:	eb 18                	jmp    80105897 <sys_unlink+0x1dc>

bad:
  iunlockput(dp);
8010587f:	83 ec 0c             	sub    $0xc,%esp
80105882:	ff 75 f4             	pushl  -0xc(%ebp)
80105885:	e8 f3 c2 ff ff       	call   80101b7d <iunlockput>
8010588a:	83 c4 10             	add    $0x10,%esp
  commit_trans();
8010588d:	e8 fa d9 ff ff       	call   8010328c <commit_trans>
  return -1;
80105892:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105897:	c9                   	leave  
80105898:	c3                   	ret    

80105899 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105899:	55                   	push   %ebp
8010589a:	89 e5                	mov    %esp,%ebp
8010589c:	83 ec 38             	sub    $0x38,%esp
8010589f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801058a2:	8b 55 10             	mov    0x10(%ebp),%edx
801058a5:	8b 45 14             	mov    0x14(%ebp),%eax
801058a8:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
801058ac:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
801058b0:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801058b4:	83 ec 08             	sub    $0x8,%esp
801058b7:	8d 45 de             	lea    -0x22(%ebp),%eax
801058ba:	50                   	push   %eax
801058bb:	ff 75 08             	pushl  0x8(%ebp)
801058be:	e8 e2 cb ff ff       	call   801024a5 <nameiparent>
801058c3:	83 c4 10             	add    $0x10,%esp
801058c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801058c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801058cd:	75 0a                	jne    801058d9 <create+0x40>
    return 0;
801058cf:	b8 00 00 00 00       	mov    $0x0,%eax
801058d4:	e9 90 01 00 00       	jmp    80105a69 <create+0x1d0>
  ilock(dp);
801058d9:	83 ec 0c             	sub    $0xc,%esp
801058dc:	ff 75 f4             	pushl  -0xc(%ebp)
801058df:	e8 e2 bf ff ff       	call   801018c6 <ilock>
801058e4:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
801058e7:	83 ec 04             	sub    $0x4,%esp
801058ea:	8d 45 ec             	lea    -0x14(%ebp),%eax
801058ed:	50                   	push   %eax
801058ee:	8d 45 de             	lea    -0x22(%ebp),%eax
801058f1:	50                   	push   %eax
801058f2:	ff 75 f4             	pushl  -0xc(%ebp)
801058f5:	e8 3c c8 ff ff       	call   80102136 <dirlookup>
801058fa:	83 c4 10             	add    $0x10,%esp
801058fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105900:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105904:	74 50                	je     80105956 <create+0xbd>
    iunlockput(dp);
80105906:	83 ec 0c             	sub    $0xc,%esp
80105909:	ff 75 f4             	pushl  -0xc(%ebp)
8010590c:	e8 6c c2 ff ff       	call   80101b7d <iunlockput>
80105911:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80105914:	83 ec 0c             	sub    $0xc,%esp
80105917:	ff 75 f0             	pushl  -0x10(%ebp)
8010591a:	e8 a7 bf ff ff       	call   801018c6 <ilock>
8010591f:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80105922:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105927:	75 15                	jne    8010593e <create+0xa5>
80105929:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010592c:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105930:	66 83 f8 02          	cmp    $0x2,%ax
80105934:	75 08                	jne    8010593e <create+0xa5>
      return ip;
80105936:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105939:	e9 2b 01 00 00       	jmp    80105a69 <create+0x1d0>
    iunlockput(ip);
8010593e:	83 ec 0c             	sub    $0xc,%esp
80105941:	ff 75 f0             	pushl  -0x10(%ebp)
80105944:	e8 34 c2 ff ff       	call   80101b7d <iunlockput>
80105949:	83 c4 10             	add    $0x10,%esp
    return 0;
8010594c:	b8 00 00 00 00       	mov    $0x0,%eax
80105951:	e9 13 01 00 00       	jmp    80105a69 <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105956:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
8010595a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010595d:	8b 00                	mov    (%eax),%eax
8010595f:	83 ec 08             	sub    $0x8,%esp
80105962:	52                   	push   %edx
80105963:	50                   	push   %eax
80105964:	e8 a9 bc ff ff       	call   80101612 <ialloc>
80105969:	83 c4 10             	add    $0x10,%esp
8010596c:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010596f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105973:	75 0d                	jne    80105982 <create+0xe9>
    panic("create: ialloc");
80105975:	83 ec 0c             	sub    $0xc,%esp
80105978:	68 84 86 10 80       	push   $0x80108684
8010597d:	e8 da ab ff ff       	call   8010055c <panic>

  ilock(ip);
80105982:	83 ec 0c             	sub    $0xc,%esp
80105985:	ff 75 f0             	pushl  -0x10(%ebp)
80105988:	e8 39 bf ff ff       	call   801018c6 <ilock>
8010598d:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80105990:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105993:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105997:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
8010599b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010599e:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
801059a2:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
801059a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059a9:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
801059af:	83 ec 0c             	sub    $0xc,%esp
801059b2:	ff 75 f0             	pushl  -0x10(%ebp)
801059b5:	e8 39 bd ff ff       	call   801016f3 <iupdate>
801059ba:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
801059bd:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801059c2:	75 6a                	jne    80105a2e <create+0x195>
    dp->nlink++;  // for ".."
801059c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059c7:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801059cb:	83 c0 01             	add    $0x1,%eax
801059ce:	89 c2                	mov    %eax,%edx
801059d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059d3:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
801059d7:	83 ec 0c             	sub    $0xc,%esp
801059da:	ff 75 f4             	pushl  -0xc(%ebp)
801059dd:	e8 11 bd ff ff       	call   801016f3 <iupdate>
801059e2:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801059e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059e8:	8b 40 04             	mov    0x4(%eax),%eax
801059eb:	83 ec 04             	sub    $0x4,%esp
801059ee:	50                   	push   %eax
801059ef:	68 5e 86 10 80       	push   $0x8010865e
801059f4:	ff 75 f0             	pushl  -0x10(%ebp)
801059f7:	e8 f5 c7 ff ff       	call   801021f1 <dirlink>
801059fc:	83 c4 10             	add    $0x10,%esp
801059ff:	85 c0                	test   %eax,%eax
80105a01:	78 1e                	js     80105a21 <create+0x188>
80105a03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a06:	8b 40 04             	mov    0x4(%eax),%eax
80105a09:	83 ec 04             	sub    $0x4,%esp
80105a0c:	50                   	push   %eax
80105a0d:	68 60 86 10 80       	push   $0x80108660
80105a12:	ff 75 f0             	pushl  -0x10(%ebp)
80105a15:	e8 d7 c7 ff ff       	call   801021f1 <dirlink>
80105a1a:	83 c4 10             	add    $0x10,%esp
80105a1d:	85 c0                	test   %eax,%eax
80105a1f:	79 0d                	jns    80105a2e <create+0x195>
      panic("create dots");
80105a21:	83 ec 0c             	sub    $0xc,%esp
80105a24:	68 93 86 10 80       	push   $0x80108693
80105a29:	e8 2e ab ff ff       	call   8010055c <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105a2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a31:	8b 40 04             	mov    0x4(%eax),%eax
80105a34:	83 ec 04             	sub    $0x4,%esp
80105a37:	50                   	push   %eax
80105a38:	8d 45 de             	lea    -0x22(%ebp),%eax
80105a3b:	50                   	push   %eax
80105a3c:	ff 75 f4             	pushl  -0xc(%ebp)
80105a3f:	e8 ad c7 ff ff       	call   801021f1 <dirlink>
80105a44:	83 c4 10             	add    $0x10,%esp
80105a47:	85 c0                	test   %eax,%eax
80105a49:	79 0d                	jns    80105a58 <create+0x1bf>
    panic("create: dirlink");
80105a4b:	83 ec 0c             	sub    $0xc,%esp
80105a4e:	68 9f 86 10 80       	push   $0x8010869f
80105a53:	e8 04 ab ff ff       	call   8010055c <panic>

  iunlockput(dp);
80105a58:	83 ec 0c             	sub    $0xc,%esp
80105a5b:	ff 75 f4             	pushl  -0xc(%ebp)
80105a5e:	e8 1a c1 ff ff       	call   80101b7d <iunlockput>
80105a63:	83 c4 10             	add    $0x10,%esp

  return ip;
80105a66:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105a69:	c9                   	leave  
80105a6a:	c3                   	ret    

80105a6b <sys_open>:

int
sys_open(void)
{
80105a6b:	55                   	push   %ebp
80105a6c:	89 e5                	mov    %esp,%ebp
80105a6e:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105a71:	83 ec 08             	sub    $0x8,%esp
80105a74:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105a77:	50                   	push   %eax
80105a78:	6a 00                	push   $0x0
80105a7a:	e8 f5 f6 ff ff       	call   80105174 <argstr>
80105a7f:	83 c4 10             	add    $0x10,%esp
80105a82:	85 c0                	test   %eax,%eax
80105a84:	78 15                	js     80105a9b <sys_open+0x30>
80105a86:	83 ec 08             	sub    $0x8,%esp
80105a89:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105a8c:	50                   	push   %eax
80105a8d:	6a 01                	push   $0x1
80105a8f:	e8 59 f6 ff ff       	call   801050ed <argint>
80105a94:	83 c4 10             	add    $0x10,%esp
80105a97:	85 c0                	test   %eax,%eax
80105a99:	79 0a                	jns    80105aa5 <sys_open+0x3a>
    return -1;
80105a9b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105aa0:	e9 4d 01 00 00       	jmp    80105bf2 <sys_open+0x187>
  if(omode & O_CREATE){
80105aa5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105aa8:	25 00 02 00 00       	and    $0x200,%eax
80105aad:	85 c0                	test   %eax,%eax
80105aaf:	74 2f                	je     80105ae0 <sys_open+0x75>
    begin_trans();
80105ab1:	e8 84 d7 ff ff       	call   8010323a <begin_trans>
    ip = create(path, T_FILE, 0, 0);
80105ab6:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105ab9:	6a 00                	push   $0x0
80105abb:	6a 00                	push   $0x0
80105abd:	6a 02                	push   $0x2
80105abf:	50                   	push   %eax
80105ac0:	e8 d4 fd ff ff       	call   80105899 <create>
80105ac5:	83 c4 10             	add    $0x10,%esp
80105ac8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    commit_trans();
80105acb:	e8 bc d7 ff ff       	call   8010328c <commit_trans>
    if(ip == 0)
80105ad0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105ad4:	75 66                	jne    80105b3c <sys_open+0xd1>
      return -1;
80105ad6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105adb:	e9 12 01 00 00       	jmp    80105bf2 <sys_open+0x187>
  } else {
    if((ip = namei(path)) == 0)
80105ae0:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105ae3:	83 ec 0c             	sub    $0xc,%esp
80105ae6:	50                   	push   %eax
80105ae7:	e8 9d c9 ff ff       	call   80102489 <namei>
80105aec:	83 c4 10             	add    $0x10,%esp
80105aef:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105af2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105af6:	75 0a                	jne    80105b02 <sys_open+0x97>
      return -1;
80105af8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105afd:	e9 f0 00 00 00       	jmp    80105bf2 <sys_open+0x187>
    ilock(ip);
80105b02:	83 ec 0c             	sub    $0xc,%esp
80105b05:	ff 75 f4             	pushl  -0xc(%ebp)
80105b08:	e8 b9 bd ff ff       	call   801018c6 <ilock>
80105b0d:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80105b10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b13:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105b17:	66 83 f8 01          	cmp    $0x1,%ax
80105b1b:	75 1f                	jne    80105b3c <sys_open+0xd1>
80105b1d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105b20:	85 c0                	test   %eax,%eax
80105b22:	74 18                	je     80105b3c <sys_open+0xd1>
      iunlockput(ip);
80105b24:	83 ec 0c             	sub    $0xc,%esp
80105b27:	ff 75 f4             	pushl  -0xc(%ebp)
80105b2a:	e8 4e c0 ff ff       	call   80101b7d <iunlockput>
80105b2f:	83 c4 10             	add    $0x10,%esp
      return -1;
80105b32:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b37:	e9 b6 00 00 00       	jmp    80105bf2 <sys_open+0x187>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105b3c:	e8 06 b4 ff ff       	call   80100f47 <filealloc>
80105b41:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105b44:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105b48:	74 17                	je     80105b61 <sys_open+0xf6>
80105b4a:	83 ec 0c             	sub    $0xc,%esp
80105b4d:	ff 75 f0             	pushl  -0x10(%ebp)
80105b50:	e8 4a f7 ff ff       	call   8010529f <fdalloc>
80105b55:	83 c4 10             	add    $0x10,%esp
80105b58:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105b5b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105b5f:	79 29                	jns    80105b8a <sys_open+0x11f>
    if(f)
80105b61:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105b65:	74 0e                	je     80105b75 <sys_open+0x10a>
      fileclose(f);
80105b67:	83 ec 0c             	sub    $0xc,%esp
80105b6a:	ff 75 f0             	pushl  -0x10(%ebp)
80105b6d:	e8 92 b4 ff ff       	call   80101004 <fileclose>
80105b72:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105b75:	83 ec 0c             	sub    $0xc,%esp
80105b78:	ff 75 f4             	pushl  -0xc(%ebp)
80105b7b:	e8 fd bf ff ff       	call   80101b7d <iunlockput>
80105b80:	83 c4 10             	add    $0x10,%esp
    return -1;
80105b83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b88:	eb 68                	jmp    80105bf2 <sys_open+0x187>
  }
  iunlock(ip);
80105b8a:	83 ec 0c             	sub    $0xc,%esp
80105b8d:	ff 75 f4             	pushl  -0xc(%ebp)
80105b90:	e8 88 be ff ff       	call   80101a1d <iunlock>
80105b95:	83 c4 10             	add    $0x10,%esp

  f->type = FD_INODE;
80105b98:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b9b:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80105ba1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ba4:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105ba7:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80105baa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bad:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80105bb4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105bb7:	83 e0 01             	and    $0x1,%eax
80105bba:	85 c0                	test   %eax,%eax
80105bbc:	0f 94 c0             	sete   %al
80105bbf:	89 c2                	mov    %eax,%edx
80105bc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bc4:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105bc7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105bca:	83 e0 01             	and    $0x1,%eax
80105bcd:	85 c0                	test   %eax,%eax
80105bcf:	75 0a                	jne    80105bdb <sys_open+0x170>
80105bd1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105bd4:	83 e0 02             	and    $0x2,%eax
80105bd7:	85 c0                	test   %eax,%eax
80105bd9:	74 07                	je     80105be2 <sys_open+0x177>
80105bdb:	b8 01 00 00 00       	mov    $0x1,%eax
80105be0:	eb 05                	jmp    80105be7 <sys_open+0x17c>
80105be2:	b8 00 00 00 00       	mov    $0x0,%eax
80105be7:	89 c2                	mov    %eax,%edx
80105be9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bec:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80105bef:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80105bf2:	c9                   	leave  
80105bf3:	c3                   	ret    

80105bf4 <sys_mkdir>:

int
sys_mkdir(void)
{
80105bf4:	55                   	push   %ebp
80105bf5:	89 e5                	mov    %esp,%ebp
80105bf7:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_trans();
80105bfa:	e8 3b d6 ff ff       	call   8010323a <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105bff:	83 ec 08             	sub    $0x8,%esp
80105c02:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105c05:	50                   	push   %eax
80105c06:	6a 00                	push   $0x0
80105c08:	e8 67 f5 ff ff       	call   80105174 <argstr>
80105c0d:	83 c4 10             	add    $0x10,%esp
80105c10:	85 c0                	test   %eax,%eax
80105c12:	78 1b                	js     80105c2f <sys_mkdir+0x3b>
80105c14:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c17:	6a 00                	push   $0x0
80105c19:	6a 00                	push   $0x0
80105c1b:	6a 01                	push   $0x1
80105c1d:	50                   	push   %eax
80105c1e:	e8 76 fc ff ff       	call   80105899 <create>
80105c23:	83 c4 10             	add    $0x10,%esp
80105c26:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c29:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105c2d:	75 0c                	jne    80105c3b <sys_mkdir+0x47>
    commit_trans();
80105c2f:	e8 58 d6 ff ff       	call   8010328c <commit_trans>
    return -1;
80105c34:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c39:	eb 18                	jmp    80105c53 <sys_mkdir+0x5f>
  }
  iunlockput(ip);
80105c3b:	83 ec 0c             	sub    $0xc,%esp
80105c3e:	ff 75 f4             	pushl  -0xc(%ebp)
80105c41:	e8 37 bf ff ff       	call   80101b7d <iunlockput>
80105c46:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105c49:	e8 3e d6 ff ff       	call   8010328c <commit_trans>
  return 0;
80105c4e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105c53:	c9                   	leave  
80105c54:	c3                   	ret    

80105c55 <sys_mknod>:

int
sys_mknod(void)
{
80105c55:	55                   	push   %ebp
80105c56:	89 e5                	mov    %esp,%ebp
80105c58:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
80105c5b:	e8 da d5 ff ff       	call   8010323a <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
80105c60:	83 ec 08             	sub    $0x8,%esp
80105c63:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105c66:	50                   	push   %eax
80105c67:	6a 00                	push   $0x0
80105c69:	e8 06 f5 ff ff       	call   80105174 <argstr>
80105c6e:	83 c4 10             	add    $0x10,%esp
80105c71:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c74:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105c78:	78 4f                	js     80105cc9 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
80105c7a:	83 ec 08             	sub    $0x8,%esp
80105c7d:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105c80:	50                   	push   %eax
80105c81:	6a 01                	push   $0x1
80105c83:	e8 65 f4 ff ff       	call   801050ed <argint>
80105c88:	83 c4 10             	add    $0x10,%esp
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
80105c8b:	85 c0                	test   %eax,%eax
80105c8d:	78 3a                	js     80105cc9 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105c8f:	83 ec 08             	sub    $0x8,%esp
80105c92:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105c95:	50                   	push   %eax
80105c96:	6a 02                	push   $0x2
80105c98:	e8 50 f4 ff ff       	call   801050ed <argint>
80105c9d:	83 c4 10             	add    $0x10,%esp
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105ca0:	85 c0                	test   %eax,%eax
80105ca2:	78 25                	js     80105cc9 <sys_mknod+0x74>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80105ca4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ca7:	0f bf c8             	movswl %ax,%ecx
80105caa:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105cad:	0f bf d0             	movswl %ax,%edx
80105cb0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105cb3:	51                   	push   %ecx
80105cb4:	52                   	push   %edx
80105cb5:	6a 03                	push   $0x3
80105cb7:	50                   	push   %eax
80105cb8:	e8 dc fb ff ff       	call   80105899 <create>
80105cbd:	83 c4 10             	add    $0x10,%esp
80105cc0:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105cc3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105cc7:	75 0c                	jne    80105cd5 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    commit_trans();
80105cc9:	e8 be d5 ff ff       	call   8010328c <commit_trans>
    return -1;
80105cce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cd3:	eb 18                	jmp    80105ced <sys_mknod+0x98>
  }
  iunlockput(ip);
80105cd5:	83 ec 0c             	sub    $0xc,%esp
80105cd8:	ff 75 f0             	pushl  -0x10(%ebp)
80105cdb:	e8 9d be ff ff       	call   80101b7d <iunlockput>
80105ce0:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105ce3:	e8 a4 d5 ff ff       	call   8010328c <commit_trans>
  return 0;
80105ce8:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105ced:	c9                   	leave  
80105cee:	c3                   	ret    

80105cef <sys_chdir>:

int
sys_chdir(void)
{
80105cef:	55                   	push   %ebp
80105cf0:	89 e5                	mov    %esp,%ebp
80105cf2:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80105cf5:	83 ec 08             	sub    $0x8,%esp
80105cf8:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105cfb:	50                   	push   %eax
80105cfc:	6a 00                	push   $0x0
80105cfe:	e8 71 f4 ff ff       	call   80105174 <argstr>
80105d03:	83 c4 10             	add    $0x10,%esp
80105d06:	85 c0                	test   %eax,%eax
80105d08:	78 18                	js     80105d22 <sys_chdir+0x33>
80105d0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d0d:	83 ec 0c             	sub    $0xc,%esp
80105d10:	50                   	push   %eax
80105d11:	e8 73 c7 ff ff       	call   80102489 <namei>
80105d16:	83 c4 10             	add    $0x10,%esp
80105d19:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105d1c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d20:	75 07                	jne    80105d29 <sys_chdir+0x3a>
    return -1;
80105d22:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d27:	eb 64                	jmp    80105d8d <sys_chdir+0x9e>
  ilock(ip);
80105d29:	83 ec 0c             	sub    $0xc,%esp
80105d2c:	ff 75 f4             	pushl  -0xc(%ebp)
80105d2f:	e8 92 bb ff ff       	call   801018c6 <ilock>
80105d34:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
80105d37:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d3a:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105d3e:	66 83 f8 01          	cmp    $0x1,%ax
80105d42:	74 15                	je     80105d59 <sys_chdir+0x6a>
    iunlockput(ip);
80105d44:	83 ec 0c             	sub    $0xc,%esp
80105d47:	ff 75 f4             	pushl  -0xc(%ebp)
80105d4a:	e8 2e be ff ff       	call   80101b7d <iunlockput>
80105d4f:	83 c4 10             	add    $0x10,%esp
    return -1;
80105d52:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d57:	eb 34                	jmp    80105d8d <sys_chdir+0x9e>
  }
  iunlock(ip);
80105d59:	83 ec 0c             	sub    $0xc,%esp
80105d5c:	ff 75 f4             	pushl  -0xc(%ebp)
80105d5f:	e8 b9 bc ff ff       	call   80101a1d <iunlock>
80105d64:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
80105d67:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d6d:	8b 40 68             	mov    0x68(%eax),%eax
80105d70:	83 ec 0c             	sub    $0xc,%esp
80105d73:	50                   	push   %eax
80105d74:	e8 15 bd ff ff       	call   80101a8e <iput>
80105d79:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
80105d7c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d82:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105d85:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80105d88:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105d8d:	c9                   	leave  
80105d8e:	c3                   	ret    

80105d8f <sys_exec>:

int
sys_exec(void)
{
80105d8f:	55                   	push   %ebp
80105d90:	89 e5                	mov    %esp,%ebp
80105d92:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105d98:	83 ec 08             	sub    $0x8,%esp
80105d9b:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105d9e:	50                   	push   %eax
80105d9f:	6a 00                	push   $0x0
80105da1:	e8 ce f3 ff ff       	call   80105174 <argstr>
80105da6:	83 c4 10             	add    $0x10,%esp
80105da9:	85 c0                	test   %eax,%eax
80105dab:	78 18                	js     80105dc5 <sys_exec+0x36>
80105dad:	83 ec 08             	sub    $0x8,%esp
80105db0:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80105db6:	50                   	push   %eax
80105db7:	6a 01                	push   $0x1
80105db9:	e8 2f f3 ff ff       	call   801050ed <argint>
80105dbe:	83 c4 10             	add    $0x10,%esp
80105dc1:	85 c0                	test   %eax,%eax
80105dc3:	79 0a                	jns    80105dcf <sys_exec+0x40>
    return -1;
80105dc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dca:	e9 c6 00 00 00       	jmp    80105e95 <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
80105dcf:	83 ec 04             	sub    $0x4,%esp
80105dd2:	68 80 00 00 00       	push   $0x80
80105dd7:	6a 00                	push   $0x0
80105dd9:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80105ddf:	50                   	push   %eax
80105de0:	e8 e1 ef ff ff       	call   80104dc6 <memset>
80105de5:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
80105de8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
80105def:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105df2:	83 f8 1f             	cmp    $0x1f,%eax
80105df5:	76 0a                	jbe    80105e01 <sys_exec+0x72>
      return -1;
80105df7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dfc:	e9 94 00 00 00       	jmp    80105e95 <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105e01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e04:	c1 e0 02             	shl    $0x2,%eax
80105e07:	89 c2                	mov    %eax,%edx
80105e09:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
80105e0f:	01 c2                	add    %eax,%edx
80105e11:	83 ec 08             	sub    $0x8,%esp
80105e14:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105e1a:	50                   	push   %eax
80105e1b:	52                   	push   %edx
80105e1c:	e8 30 f2 ff ff       	call   80105051 <fetchint>
80105e21:	83 c4 10             	add    $0x10,%esp
80105e24:	85 c0                	test   %eax,%eax
80105e26:	79 07                	jns    80105e2f <sys_exec+0xa0>
      return -1;
80105e28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e2d:	eb 66                	jmp    80105e95 <sys_exec+0x106>
    if(uarg == 0){
80105e2f:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80105e35:	85 c0                	test   %eax,%eax
80105e37:	75 27                	jne    80105e60 <sys_exec+0xd1>
      argv[i] = 0;
80105e39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e3c:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80105e43:	00 00 00 00 
      break;
80105e47:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105e48:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e4b:	83 ec 08             	sub    $0x8,%esp
80105e4e:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80105e54:	52                   	push   %edx
80105e55:	50                   	push   %eax
80105e56:	e8 f4 ac ff ff       	call   80100b4f <exec>
80105e5b:	83 c4 10             	add    $0x10,%esp
80105e5e:	eb 35                	jmp    80105e95 <sys_exec+0x106>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105e60:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80105e66:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105e69:	c1 e2 02             	shl    $0x2,%edx
80105e6c:	01 c2                	add    %eax,%edx
80105e6e:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80105e74:	83 ec 08             	sub    $0x8,%esp
80105e77:	52                   	push   %edx
80105e78:	50                   	push   %eax
80105e79:	e8 0d f2 ff ff       	call   8010508b <fetchstr>
80105e7e:	83 c4 10             	add    $0x10,%esp
80105e81:	85 c0                	test   %eax,%eax
80105e83:	79 07                	jns    80105e8c <sys_exec+0xfd>
      return -1;
80105e85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e8a:	eb 09                	jmp    80105e95 <sys_exec+0x106>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105e8c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
80105e90:	e9 5a ff ff ff       	jmp    80105def <sys_exec+0x60>
  return exec(path, argv);
}
80105e95:	c9                   	leave  
80105e96:	c3                   	ret    

80105e97 <sys_pipe>:

int
sys_pipe(void)
{
80105e97:	55                   	push   %ebp
80105e98:	89 e5                	mov    %esp,%ebp
80105e9a:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105e9d:	83 ec 04             	sub    $0x4,%esp
80105ea0:	6a 08                	push   $0x8
80105ea2:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105ea5:	50                   	push   %eax
80105ea6:	6a 00                	push   $0x0
80105ea8:	e8 68 f2 ff ff       	call   80105115 <argptr>
80105ead:	83 c4 10             	add    $0x10,%esp
80105eb0:	85 c0                	test   %eax,%eax
80105eb2:	79 0a                	jns    80105ebe <sys_pipe+0x27>
    return -1;
80105eb4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105eb9:	e9 af 00 00 00       	jmp    80105f6d <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
80105ebe:	83 ec 08             	sub    $0x8,%esp
80105ec1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105ec4:	50                   	push   %eax
80105ec5:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105ec8:	50                   	push   %eax
80105ec9:	e8 18 dd ff ff       	call   80103be6 <pipealloc>
80105ece:	83 c4 10             	add    $0x10,%esp
80105ed1:	85 c0                	test   %eax,%eax
80105ed3:	79 0a                	jns    80105edf <sys_pipe+0x48>
    return -1;
80105ed5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105eda:	e9 8e 00 00 00       	jmp    80105f6d <sys_pipe+0xd6>
  fd0 = -1;
80105edf:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105ee6:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105ee9:	83 ec 0c             	sub    $0xc,%esp
80105eec:	50                   	push   %eax
80105eed:	e8 ad f3 ff ff       	call   8010529f <fdalloc>
80105ef2:	83 c4 10             	add    $0x10,%esp
80105ef5:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ef8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105efc:	78 18                	js     80105f16 <sys_pipe+0x7f>
80105efe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f01:	83 ec 0c             	sub    $0xc,%esp
80105f04:	50                   	push   %eax
80105f05:	e8 95 f3 ff ff       	call   8010529f <fdalloc>
80105f0a:	83 c4 10             	add    $0x10,%esp
80105f0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105f10:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f14:	79 3f                	jns    80105f55 <sys_pipe+0xbe>
    if(fd0 >= 0)
80105f16:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f1a:	78 14                	js     80105f30 <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
80105f1c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105f22:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105f25:	83 c2 08             	add    $0x8,%edx
80105f28:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105f2f:	00 
    fileclose(rf);
80105f30:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105f33:	83 ec 0c             	sub    $0xc,%esp
80105f36:	50                   	push   %eax
80105f37:	e8 c8 b0 ff ff       	call   80101004 <fileclose>
80105f3c:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
80105f3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f42:	83 ec 0c             	sub    $0xc,%esp
80105f45:	50                   	push   %eax
80105f46:	e8 b9 b0 ff ff       	call   80101004 <fileclose>
80105f4b:	83 c4 10             	add    $0x10,%esp
    return -1;
80105f4e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f53:	eb 18                	jmp    80105f6d <sys_pipe+0xd6>
  }
  fd[0] = fd0;
80105f55:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105f58:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105f5b:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80105f5d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105f60:	8d 50 04             	lea    0x4(%eax),%edx
80105f63:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f66:	89 02                	mov    %eax,(%edx)
  return 0;
80105f68:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105f6d:	c9                   	leave  
80105f6e:	c3                   	ret    

80105f6f <iNodeName>:

int iNodeName(struct inode *ip, struct inode *parent, char buf[DIRSIZ])
{
80105f6f:	55                   	push   %ebp
80105f70:	89 e5                	mov    %esp,%ebp
80105f72:	83 ec 28             	sub    $0x28,%esp
	uint off; //uint needs to be used instead of int?
	struct dirent de; //dirent  = inode directory with name
for(off = 0; off < parent->size; off += sizeof(de))
80105f75:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80105f7c:	eb 59                	jmp    80105fd7 <iNodeName+0x68>
{
	if(readi(parent, (char*)&de, off, sizeof(de)) != sizeof(de))
80105f7e:	6a 10                	push   $0x10
80105f80:	ff 75 f4             	pushl  -0xc(%ebp)
80105f83:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f86:	50                   	push   %eax
80105f87:	ff 75 0c             	pushl  0xc(%ebp)
80105f8a:	e8 99 be ff ff       	call   80101e28 <readi>
80105f8f:	83 c4 10             	add    $0x10,%esp
80105f92:	83 f8 10             	cmp    $0x10,%eax
80105f95:	74 0d                	je     80105fa4 <iNodeName+0x35>
	panic("couldnt read directory entry");
80105f97:	83 ec 0c             	sub    $0xc,%esp
80105f9a:	68 af 86 10 80       	push   $0x801086af
80105f9f:	e8 b8 a5 ff ff       	call   8010055c <panic>
	if(de.inum == ip->inum)
80105fa4:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105fa8:	0f b7 d0             	movzwl %ax,%edx
80105fab:	8b 45 08             	mov    0x8(%ebp),%eax
80105fae:	8b 40 04             	mov    0x4(%eax),%eax
80105fb1:	39 c2                	cmp    %eax,%edx
80105fb3:	75 1e                	jne    80105fd3 <iNodeName+0x64>
	{
	safestrcpy(buf, de.name, DIRSIZ);
80105fb5:	83 ec 04             	sub    $0x4,%esp
80105fb8:	6a 0e                	push   $0xe
80105fba:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105fbd:	83 c0 02             	add    $0x2,%eax
80105fc0:	50                   	push   %eax
80105fc1:	ff 75 10             	pushl  0x10(%ebp)
80105fc4:	e8 02 f0 ff ff       	call   80104fcb <safestrcpy>
80105fc9:	83 c4 10             	add    $0x10,%esp
	return 0;
80105fcc:	b8 00 00 00 00       	mov    $0x0,%eax
80105fd1:	eb 14                	jmp    80105fe7 <iNodeName+0x78>

int iNodeName(struct inode *ip, struct inode *parent, char buf[DIRSIZ])
{
	uint off; //uint needs to be used instead of int?
	struct dirent de; //dirent  = inode directory with name
for(off = 0; off < parent->size; off += sizeof(de))
80105fd3:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80105fd7:	8b 45 0c             	mov    0xc(%ebp),%eax
80105fda:	8b 40 18             	mov    0x18(%eax),%eax
80105fdd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105fe0:	77 9c                	ja     80105f7e <iNodeName+0xf>
	{
	safestrcpy(buf, de.name, DIRSIZ);
	return 0;
	}
}
	return -1; //failed, R.I.P file system
80105fe2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105fe7:	c9                   	leave  
80105fe8:	c3                   	ret    

80105fe9 <namediNode>:


int namediNode(char* buf, int n, struct inode *ip)
{
80105fe9:	55                   	push   %ebp
80105fea:	89 e5                	mov    %esp,%ebp
80105fec:	53                   	push   %ebx
80105fed:	83 ec 24             	sub    $0x24,%esp
	int off_set;
	struct inode *parent;
	char node_name[DIRSIZ];
	if(ip-> inum == namei("/")->inum)
80105ff0:	8b 45 10             	mov    0x10(%ebp),%eax
80105ff3:	8b 58 04             	mov    0x4(%eax),%ebx
80105ff6:	83 ec 0c             	sub    $0xc,%esp
80105ff9:	68 cc 86 10 80       	push   $0x801086cc
80105ffe:	e8 86 c4 ff ff       	call   80102489 <namei>
80106003:	83 c4 10             	add    $0x10,%esp
80106006:	8b 40 04             	mov    0x4(%eax),%eax
80106009:	39 c3                	cmp    %eax,%ebx
8010600b:	75 10                	jne    8010601d <namediNode+0x34>
	{
		buf[0] = '/';
8010600d:	8b 45 08             	mov    0x8(%ebp),%eax
80106010:	c6 00 2f             	movb   $0x2f,(%eax)
		return 1;
80106013:	b8 01 00 00 00       	mov    $0x1,%eax
80106018:	e9 16 01 00 00       	jmp    80106133 <namediNode+0x14a>
	}
else if(ip->type == T_DIR)
8010601d:	8b 45 10             	mov    0x10(%ebp),%eax
80106020:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106024:	66 83 f8 01          	cmp    $0x1,%ax
80106028:	0f 85 d1 00 00 00    	jne    801060ff <namediNode+0x116>
{
	parent = dirlookup(ip, "..", 0);
8010602e:	83 ec 04             	sub    $0x4,%esp
80106031:	6a 00                	push   $0x0
80106033:	68 60 86 10 80       	push   $0x80108660
80106038:	ff 75 10             	pushl  0x10(%ebp)
8010603b:	e8 f6 c0 ff ff       	call   80102136 <dirlookup>
80106040:	83 c4 10             	add    $0x10,%esp
80106043:	89 45 f4             	mov    %eax,-0xc(%ebp)
	ilock(parent);
80106046:	83 ec 0c             	sub    $0xc,%esp
80106049:	ff 75 f4             	pushl  -0xc(%ebp)
8010604c:	e8 75 b8 ff ff       	call   801018c6 <ilock>
80106051:	83 c4 10             	add    $0x10,%esp
	if(iNodeName(ip, parent, node_name)) // if the parent file doesn't have a name
80106054:	83 ec 04             	sub    $0x4,%esp
80106057:	8d 45 e2             	lea    -0x1e(%ebp),%eax
8010605a:	50                   	push   %eax
8010605b:	ff 75 f4             	pushl  -0xc(%ebp)
8010605e:	ff 75 10             	pushl  0x10(%ebp)
80106061:	e8 09 ff ff ff       	call   80105f6f <iNodeName>
80106066:	83 c4 10             	add    $0x10,%esp
80106069:	85 c0                	test   %eax,%eax
8010606b:	74 0d                	je     8010607a <namediNode+0x91>
		panic("could not find parent's inode name");
8010606d:	83 ec 0c             	sub    $0xc,%esp
80106070:	68 d0 86 10 80       	push   $0x801086d0
80106075:	e8 e2 a4 ff ff       	call   8010055c <panic>
	off_set = namediNode(buf, n, parent);
8010607a:	83 ec 04             	sub    $0x4,%esp
8010607d:	ff 75 f4             	pushl  -0xc(%ebp)
80106080:	ff 75 0c             	pushl  0xc(%ebp)
80106083:	ff 75 08             	pushl  0x8(%ebp)
80106086:	e8 5e ff ff ff       	call   80105fe9 <namediNode>
8010608b:	83 c4 10             	add    $0x10,%esp
8010608e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	safestrcpy(buf + off_set, node_name, off_set);
80106091:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106094:	8b 45 08             	mov    0x8(%ebp),%eax
80106097:	01 c2                	add    %eax,%edx
80106099:	83 ec 04             	sub    $0x4,%esp
8010609c:	ff 75 f0             	pushl  -0x10(%ebp)
8010609f:	8d 45 e2             	lea    -0x1e(%ebp),%eax
801060a2:	50                   	push   %eax
801060a3:	52                   	push   %edx
801060a4:	e8 22 ef ff ff       	call   80104fcb <safestrcpy>
801060a9:	83 c4 10             	add    $0x10,%esp
	off_set += strlen(node_name);
801060ac:	83 ec 0c             	sub    $0xc,%esp
801060af:	8d 45 e2             	lea    -0x1e(%ebp),%eax
801060b2:	50                   	push   %eax
801060b3:	e8 5d ef ff ff       	call   80105015 <strlen>
801060b8:	83 c4 10             	add    $0x10,%esp
801060bb:	01 45 f0             	add    %eax,-0x10(%ebp)

	if(off_set == n - 1)
801060be:	8b 45 0c             	mov    0xc(%ebp),%eax
801060c1:	83 e8 01             	sub    $0x1,%eax
801060c4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801060c7:	75 10                	jne    801060d9 <namediNode+0xf0>
	{
		buf[off_set] = '\0';
801060c9:	8b 55 f0             	mov    -0x10(%ebp),%edx
801060cc:	8b 45 08             	mov    0x8(%ebp),%eax
801060cf:	01 d0                	add    %edx,%eax
801060d1:	c6 00 00             	movb   $0x0,(%eax)
		return n;
801060d4:	8b 45 0c             	mov    0xc(%ebp),%eax
801060d7:	eb 5a                	jmp    80106133 <namediNode+0x14a>
	}
else
	buf[off_set++] = '/'; //divides the directory names
801060d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060dc:	8d 50 01             	lea    0x1(%eax),%edx
801060df:	89 55 f0             	mov    %edx,-0x10(%ebp)
801060e2:	89 c2                	mov    %eax,%edx
801060e4:	8b 45 08             	mov    0x8(%ebp),%eax
801060e7:	01 d0                	add    %edx,%eax
801060e9:	c6 00 2f             	movb   $0x2f,(%eax)
iput(parent);
801060ec:	83 ec 0c             	sub    $0xc,%esp
801060ef:	ff 75 f4             	pushl  -0xc(%ebp)
801060f2:	e8 97 b9 ff ff       	call   80101a8e <iput>
801060f7:	83 c4 10             	add    $0x10,%esp
return off_set;
801060fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060fd:	eb 34                	jmp    80106133 <namediNode+0x14a>
}
else if(ip->type == T_DEV || ip->type == T_FILE) //triggers errors if I don't have these
801060ff:	8b 45 10             	mov    0x10(%ebp),%eax
80106102:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106106:	66 83 f8 03          	cmp    $0x3,%ax
8010610a:	74 0d                	je     80106119 <namediNode+0x130>
8010610c:	8b 45 10             	mov    0x10(%ebp),%eax
8010610f:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106113:	66 83 f8 02          	cmp    $0x2,%ax
80106117:	75 0d                	jne    80106126 <namediNode+0x13d>
	panic("process cwd is a device node");
80106119:	83 ec 0c             	sub    $0xc,%esp
8010611c:	68 f3 86 10 80       	push   $0x801086f3
80106121:	e8 36 a4 ff ff       	call   8010055c <panic>
else
panic("unknown inode type");
80106126:	83 ec 0c             	sub    $0xc,%esp
80106129:	68 10 87 10 80       	push   $0x80108710
8010612e:	e8 29 a4 ff ff       	call   8010055c <panic>
}
80106133:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106136:	c9                   	leave  
80106137:	c3                   	ret    

80106138 <sys_getcwd>:



int sys_getcwd(void)
{
80106138:	55                   	push   %ebp
80106139:	89 e5                	mov    %esp,%ebp
8010613b:	83 ec 18             	sub    $0x18,%esp
	char *p;
	int n;
	if(argint(1, &n) < 0 || argptr(0, &p, n) < 0)
8010613e:	83 ec 08             	sub    $0x8,%esp
80106141:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106144:	50                   	push   %eax
80106145:	6a 01                	push   $0x1
80106147:	e8 a1 ef ff ff       	call   801050ed <argint>
8010614c:	83 c4 10             	add    $0x10,%esp
8010614f:	85 c0                	test   %eax,%eax
80106151:	78 19                	js     8010616c <sys_getcwd+0x34>
80106153:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106156:	83 ec 04             	sub    $0x4,%esp
80106159:	50                   	push   %eax
8010615a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010615d:	50                   	push   %eax
8010615e:	6a 00                	push   $0x0
80106160:	e8 b0 ef ff ff       	call   80105115 <argptr>
80106165:	83 c4 10             	add    $0x10,%esp
80106168:	85 c0                	test   %eax,%eax
8010616a:	79 07                	jns    80106173 <sys_getcwd+0x3b>
	return 1;
8010616c:	b8 01 00 00 00       	mov    $0x1,%eax
80106171:	eb 1d                	jmp    80106190 <sys_getcwd+0x58>

return namediNode(p, n, proc->cwd);
80106173:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106179:	8b 48 68             	mov    0x68(%eax),%ecx
8010617c:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010617f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106182:	83 ec 04             	sub    $0x4,%esp
80106185:	51                   	push   %ecx
80106186:	52                   	push   %edx
80106187:	50                   	push   %eax
80106188:	e8 5c fe ff ff       	call   80105fe9 <namediNode>
8010618d:	83 c4 10             	add    $0x10,%esp
}
80106190:	c9                   	leave  
80106191:	c3                   	ret    

80106192 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106192:	55                   	push   %ebp
80106193:	89 e5                	mov    %esp,%ebp
80106195:	83 ec 08             	sub    $0x8,%esp
  return fork();
80106198:	e8 3f e1 ff ff       	call   801042dc <fork>
}
8010619d:	c9                   	leave  
8010619e:	c3                   	ret    

8010619f <sys_exit>:

int
sys_exit(void)
{
8010619f:	55                   	push   %ebp
801061a0:	89 e5                	mov    %esp,%ebp
801061a2:	83 ec 08             	sub    $0x8,%esp
  exit();
801061a5:	e8 a3 e2 ff ff       	call   8010444d <exit>
  return 0;  // not reached
801061aa:	b8 00 00 00 00       	mov    $0x0,%eax
}
801061af:	c9                   	leave  
801061b0:	c3                   	ret    

801061b1 <sys_wait>:

int
sys_wait(void)
{
801061b1:	55                   	push   %ebp
801061b2:	89 e5                	mov    %esp,%ebp
801061b4:	83 ec 08             	sub    $0x8,%esp
  return wait();
801061b7:	e8 bf e3 ff ff       	call   8010457b <wait>
}
801061bc:	c9                   	leave  
801061bd:	c3                   	ret    

801061be <sys_kill>:

int
sys_kill(void)
{
801061be:	55                   	push   %ebp
801061bf:	89 e5                	mov    %esp,%ebp
801061c1:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
801061c4:	83 ec 08             	sub    $0x8,%esp
801061c7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061ca:	50                   	push   %eax
801061cb:	6a 00                	push   $0x0
801061cd:	e8 1b ef ff ff       	call   801050ed <argint>
801061d2:	83 c4 10             	add    $0x10,%esp
801061d5:	85 c0                	test   %eax,%eax
801061d7:	79 07                	jns    801061e0 <sys_kill+0x22>
    return -1;
801061d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061de:	eb 0f                	jmp    801061ef <sys_kill+0x31>
  return kill(pid);
801061e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061e3:	83 ec 0c             	sub    $0xc,%esp
801061e6:	50                   	push   %eax
801061e7:	e8 9b e7 ff ff       	call   80104987 <kill>
801061ec:	83 c4 10             	add    $0x10,%esp
}
801061ef:	c9                   	leave  
801061f0:	c3                   	ret    

801061f1 <sys_getpid>:

int
sys_getpid(void)
{
801061f1:	55                   	push   %ebp
801061f2:	89 e5                	mov    %esp,%ebp
  return proc->pid;
801061f4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801061fa:	8b 40 10             	mov    0x10(%eax),%eax
}
801061fd:	5d                   	pop    %ebp
801061fe:	c3                   	ret    

801061ff <sys_sbrk>:

int
sys_sbrk(void)
{
801061ff:	55                   	push   %ebp
80106200:	89 e5                	mov    %esp,%ebp
80106202:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106205:	83 ec 08             	sub    $0x8,%esp
80106208:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010620b:	50                   	push   %eax
8010620c:	6a 00                	push   $0x0
8010620e:	e8 da ee ff ff       	call   801050ed <argint>
80106213:	83 c4 10             	add    $0x10,%esp
80106216:	85 c0                	test   %eax,%eax
80106218:	79 07                	jns    80106221 <sys_sbrk+0x22>
    return -1;
8010621a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010621f:	eb 28                	jmp    80106249 <sys_sbrk+0x4a>
  addr = proc->sz;
80106221:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106227:	8b 00                	mov    (%eax),%eax
80106229:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
8010622c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010622f:	83 ec 0c             	sub    $0xc,%esp
80106232:	50                   	push   %eax
80106233:	e8 01 e0 ff ff       	call   80104239 <growproc>
80106238:	83 c4 10             	add    $0x10,%esp
8010623b:	85 c0                	test   %eax,%eax
8010623d:	79 07                	jns    80106246 <sys_sbrk+0x47>
    return -1;
8010623f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106244:	eb 03                	jmp    80106249 <sys_sbrk+0x4a>
  return addr;
80106246:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106249:	c9                   	leave  
8010624a:	c3                   	ret    

8010624b <sys_sleep>:

int
sys_sleep(void)
{
8010624b:	55                   	push   %ebp
8010624c:	89 e5                	mov    %esp,%ebp
8010624e:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
80106251:	83 ec 08             	sub    $0x8,%esp
80106254:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106257:	50                   	push   %eax
80106258:	6a 00                	push   $0x0
8010625a:	e8 8e ee ff ff       	call   801050ed <argint>
8010625f:	83 c4 10             	add    $0x10,%esp
80106262:	85 c0                	test   %eax,%eax
80106264:	79 07                	jns    8010626d <sys_sleep+0x22>
    return -1;
80106266:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010626b:	eb 77                	jmp    801062e4 <sys_sleep+0x99>
  acquire(&tickslock);
8010626d:	83 ec 0c             	sub    $0xc,%esp
80106270:	68 00 1f 11 80       	push   $0x80111f00
80106275:	e8 f0 e8 ff ff       	call   80104b6a <acquire>
8010627a:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
8010627d:	a1 40 27 11 80       	mov    0x80112740,%eax
80106282:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80106285:	eb 39                	jmp    801062c0 <sys_sleep+0x75>
    if(proc->killed){
80106287:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010628d:	8b 40 24             	mov    0x24(%eax),%eax
80106290:	85 c0                	test   %eax,%eax
80106292:	74 17                	je     801062ab <sys_sleep+0x60>
      release(&tickslock);
80106294:	83 ec 0c             	sub    $0xc,%esp
80106297:	68 00 1f 11 80       	push   $0x80111f00
8010629c:	e8 2f e9 ff ff       	call   80104bd0 <release>
801062a1:	83 c4 10             	add    $0x10,%esp
      return -1;
801062a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062a9:	eb 39                	jmp    801062e4 <sys_sleep+0x99>
    }
    sleep(&ticks, &tickslock);
801062ab:	83 ec 08             	sub    $0x8,%esp
801062ae:	68 00 1f 11 80       	push   $0x80111f00
801062b3:	68 40 27 11 80       	push   $0x80112740
801062b8:	e8 ab e5 ff ff       	call   80104868 <sleep>
801062bd:	83 c4 10             	add    $0x10,%esp
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801062c0:	a1 40 27 11 80       	mov    0x80112740,%eax
801062c5:	2b 45 f4             	sub    -0xc(%ebp),%eax
801062c8:	8b 55 f0             	mov    -0x10(%ebp),%edx
801062cb:	39 d0                	cmp    %edx,%eax
801062cd:	72 b8                	jb     80106287 <sys_sleep+0x3c>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801062cf:	83 ec 0c             	sub    $0xc,%esp
801062d2:	68 00 1f 11 80       	push   $0x80111f00
801062d7:	e8 f4 e8 ff ff       	call   80104bd0 <release>
801062dc:	83 c4 10             	add    $0x10,%esp
  return 0;
801062df:	b8 00 00 00 00       	mov    $0x0,%eax
}
801062e4:	c9                   	leave  
801062e5:	c3                   	ret    

801062e6 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801062e6:	55                   	push   %ebp
801062e7:	89 e5                	mov    %esp,%ebp
801062e9:	83 ec 18             	sub    $0x18,%esp
  uint xticks;
  
  acquire(&tickslock);
801062ec:	83 ec 0c             	sub    $0xc,%esp
801062ef:	68 00 1f 11 80       	push   $0x80111f00
801062f4:	e8 71 e8 ff ff       	call   80104b6a <acquire>
801062f9:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
801062fc:	a1 40 27 11 80       	mov    0x80112740,%eax
80106301:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
80106304:	83 ec 0c             	sub    $0xc,%esp
80106307:	68 00 1f 11 80       	push   $0x80111f00
8010630c:	e8 bf e8 ff ff       	call   80104bd0 <release>
80106311:	83 c4 10             	add    $0x10,%esp
  return xticks;
80106314:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106317:	c9                   	leave  
80106318:	c3                   	ret    

80106319 <sys_ps>:

int sys_ps(void)
{
80106319:	55                   	push   %ebp
8010631a:	89 e5                	mov    %esp,%ebp
8010631c:	83 ec 08             	sub    $0x8,%esp
	return ps();
8010631f:	e8 dd e7 ff ff       	call   80104b01 <ps>
}
80106324:	c9                   	leave  
80106325:	c3                   	ret    

80106326 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106326:	55                   	push   %ebp
80106327:	89 e5                	mov    %esp,%ebp
80106329:	83 ec 08             	sub    $0x8,%esp
8010632c:	8b 55 08             	mov    0x8(%ebp),%edx
8010632f:	8b 45 0c             	mov    0xc(%ebp),%eax
80106332:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106336:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106339:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010633d:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106341:	ee                   	out    %al,(%dx)
}
80106342:	c9                   	leave  
80106343:	c3                   	ret    

80106344 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80106344:	55                   	push   %ebp
80106345:	89 e5                	mov    %esp,%ebp
80106347:	83 ec 08             	sub    $0x8,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
8010634a:	6a 34                	push   $0x34
8010634c:	6a 43                	push   $0x43
8010634e:	e8 d3 ff ff ff       	call   80106326 <outb>
80106353:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
80106356:	68 9c 00 00 00       	push   $0x9c
8010635b:	6a 40                	push   $0x40
8010635d:	e8 c4 ff ff ff       	call   80106326 <outb>
80106362:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
80106365:	6a 2e                	push   $0x2e
80106367:	6a 40                	push   $0x40
80106369:	e8 b8 ff ff ff       	call   80106326 <outb>
8010636e:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
80106371:	83 ec 0c             	sub    $0xc,%esp
80106374:	6a 00                	push   $0x0
80106376:	e8 57 d7 ff ff       	call   80103ad2 <picenable>
8010637b:	83 c4 10             	add    $0x10,%esp
}
8010637e:	c9                   	leave  
8010637f:	c3                   	ret    

80106380 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106380:	1e                   	push   %ds
  pushl %es
80106381:	06                   	push   %es
  pushl %fs
80106382:	0f a0                	push   %fs
  pushl %gs
80106384:	0f a8                	push   %gs
  pushal
80106386:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80106387:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
8010638b:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010638d:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
8010638f:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80106393:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80106395:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80106397:	54                   	push   %esp
  call trap
80106398:	e8 d4 01 00 00       	call   80106571 <trap>
  addl $4, %esp
8010639d:	83 c4 04             	add    $0x4,%esp

801063a0 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801063a0:	61                   	popa   
  popl %gs
801063a1:	0f a9                	pop    %gs
  popl %fs
801063a3:	0f a1                	pop    %fs
  popl %es
801063a5:	07                   	pop    %es
  popl %ds
801063a6:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801063a7:	83 c4 08             	add    $0x8,%esp
  iret
801063aa:	cf                   	iret   

801063ab <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
801063ab:	55                   	push   %ebp
801063ac:	89 e5                	mov    %esp,%ebp
801063ae:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
801063b1:	8b 45 0c             	mov    0xc(%ebp),%eax
801063b4:	83 e8 01             	sub    $0x1,%eax
801063b7:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801063bb:	8b 45 08             	mov    0x8(%ebp),%eax
801063be:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801063c2:	8b 45 08             	mov    0x8(%ebp),%eax
801063c5:	c1 e8 10             	shr    $0x10,%eax
801063c8:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801063cc:	8d 45 fa             	lea    -0x6(%ebp),%eax
801063cf:	0f 01 18             	lidtl  (%eax)
}
801063d2:	c9                   	leave  
801063d3:	c3                   	ret    

801063d4 <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
801063d4:	55                   	push   %ebp
801063d5:	89 e5                	mov    %esp,%ebp
801063d7:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801063da:	0f 20 d0             	mov    %cr2,%eax
801063dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
801063e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801063e3:	c9                   	leave  
801063e4:	c3                   	ret    

801063e5 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801063e5:	55                   	push   %ebp
801063e6:	89 e5                	mov    %esp,%ebp
801063e8:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
801063eb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801063f2:	e9 c3 00 00 00       	jmp    801064ba <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801063f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063fa:	8b 04 85 a0 b0 10 80 	mov    -0x7fef4f60(,%eax,4),%eax
80106401:	89 c2                	mov    %eax,%edx
80106403:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106406:	66 89 14 c5 40 1f 11 	mov    %dx,-0x7feee0c0(,%eax,8)
8010640d:	80 
8010640e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106411:	66 c7 04 c5 42 1f 11 	movw   $0x8,-0x7feee0be(,%eax,8)
80106418:	80 08 00 
8010641b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010641e:	0f b6 14 c5 44 1f 11 	movzbl -0x7feee0bc(,%eax,8),%edx
80106425:	80 
80106426:	83 e2 e0             	and    $0xffffffe0,%edx
80106429:	88 14 c5 44 1f 11 80 	mov    %dl,-0x7feee0bc(,%eax,8)
80106430:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106433:	0f b6 14 c5 44 1f 11 	movzbl -0x7feee0bc(,%eax,8),%edx
8010643a:	80 
8010643b:	83 e2 1f             	and    $0x1f,%edx
8010643e:	88 14 c5 44 1f 11 80 	mov    %dl,-0x7feee0bc(,%eax,8)
80106445:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106448:	0f b6 14 c5 45 1f 11 	movzbl -0x7feee0bb(,%eax,8),%edx
8010644f:	80 
80106450:	83 e2 f0             	and    $0xfffffff0,%edx
80106453:	83 ca 0e             	or     $0xe,%edx
80106456:	88 14 c5 45 1f 11 80 	mov    %dl,-0x7feee0bb(,%eax,8)
8010645d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106460:	0f b6 14 c5 45 1f 11 	movzbl -0x7feee0bb(,%eax,8),%edx
80106467:	80 
80106468:	83 e2 ef             	and    $0xffffffef,%edx
8010646b:	88 14 c5 45 1f 11 80 	mov    %dl,-0x7feee0bb(,%eax,8)
80106472:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106475:	0f b6 14 c5 45 1f 11 	movzbl -0x7feee0bb(,%eax,8),%edx
8010647c:	80 
8010647d:	83 e2 9f             	and    $0xffffff9f,%edx
80106480:	88 14 c5 45 1f 11 80 	mov    %dl,-0x7feee0bb(,%eax,8)
80106487:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010648a:	0f b6 14 c5 45 1f 11 	movzbl -0x7feee0bb(,%eax,8),%edx
80106491:	80 
80106492:	83 ca 80             	or     $0xffffff80,%edx
80106495:	88 14 c5 45 1f 11 80 	mov    %dl,-0x7feee0bb(,%eax,8)
8010649c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010649f:	8b 04 85 a0 b0 10 80 	mov    -0x7fef4f60(,%eax,4),%eax
801064a6:	c1 e8 10             	shr    $0x10,%eax
801064a9:	89 c2                	mov    %eax,%edx
801064ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064ae:	66 89 14 c5 46 1f 11 	mov    %dx,-0x7feee0ba(,%eax,8)
801064b5:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801064b6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801064ba:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
801064c1:	0f 8e 30 ff ff ff    	jle    801063f7 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801064c7:	a1 a0 b1 10 80       	mov    0x8010b1a0,%eax
801064cc:	66 a3 40 21 11 80    	mov    %ax,0x80112140
801064d2:	66 c7 05 42 21 11 80 	movw   $0x8,0x80112142
801064d9:	08 00 
801064db:	0f b6 05 44 21 11 80 	movzbl 0x80112144,%eax
801064e2:	83 e0 e0             	and    $0xffffffe0,%eax
801064e5:	a2 44 21 11 80       	mov    %al,0x80112144
801064ea:	0f b6 05 44 21 11 80 	movzbl 0x80112144,%eax
801064f1:	83 e0 1f             	and    $0x1f,%eax
801064f4:	a2 44 21 11 80       	mov    %al,0x80112144
801064f9:	0f b6 05 45 21 11 80 	movzbl 0x80112145,%eax
80106500:	83 c8 0f             	or     $0xf,%eax
80106503:	a2 45 21 11 80       	mov    %al,0x80112145
80106508:	0f b6 05 45 21 11 80 	movzbl 0x80112145,%eax
8010650f:	83 e0 ef             	and    $0xffffffef,%eax
80106512:	a2 45 21 11 80       	mov    %al,0x80112145
80106517:	0f b6 05 45 21 11 80 	movzbl 0x80112145,%eax
8010651e:	83 c8 60             	or     $0x60,%eax
80106521:	a2 45 21 11 80       	mov    %al,0x80112145
80106526:	0f b6 05 45 21 11 80 	movzbl 0x80112145,%eax
8010652d:	83 c8 80             	or     $0xffffff80,%eax
80106530:	a2 45 21 11 80       	mov    %al,0x80112145
80106535:	a1 a0 b1 10 80       	mov    0x8010b1a0,%eax
8010653a:	c1 e8 10             	shr    $0x10,%eax
8010653d:	66 a3 46 21 11 80    	mov    %ax,0x80112146
  
  initlock(&tickslock, "time");
80106543:	83 ec 08             	sub    $0x8,%esp
80106546:	68 24 87 10 80       	push   $0x80108724
8010654b:	68 00 1f 11 80       	push   $0x80111f00
80106550:	e8 f4 e5 ff ff       	call   80104b49 <initlock>
80106555:	83 c4 10             	add    $0x10,%esp
}
80106558:	c9                   	leave  
80106559:	c3                   	ret    

8010655a <idtinit>:

void
idtinit(void)
{
8010655a:	55                   	push   %ebp
8010655b:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
8010655d:	68 00 08 00 00       	push   $0x800
80106562:	68 40 1f 11 80       	push   $0x80111f40
80106567:	e8 3f fe ff ff       	call   801063ab <lidt>
8010656c:	83 c4 08             	add    $0x8,%esp
}
8010656f:	c9                   	leave  
80106570:	c3                   	ret    

80106571 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106571:	55                   	push   %ebp
80106572:	89 e5                	mov    %esp,%ebp
80106574:	57                   	push   %edi
80106575:	56                   	push   %esi
80106576:	53                   	push   %ebx
80106577:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
8010657a:	8b 45 08             	mov    0x8(%ebp),%eax
8010657d:	8b 40 30             	mov    0x30(%eax),%eax
80106580:	83 f8 40             	cmp    $0x40,%eax
80106583:	75 3f                	jne    801065c4 <trap+0x53>
    if(proc->killed)
80106585:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010658b:	8b 40 24             	mov    0x24(%eax),%eax
8010658e:	85 c0                	test   %eax,%eax
80106590:	74 05                	je     80106597 <trap+0x26>
      exit();
80106592:	e8 b6 de ff ff       	call   8010444d <exit>
    proc->tf = tf;
80106597:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010659d:	8b 55 08             	mov    0x8(%ebp),%edx
801065a0:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
801065a3:	e8 fd eb ff ff       	call   801051a5 <syscall>
    if(proc->killed)
801065a8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065ae:	8b 40 24             	mov    0x24(%eax),%eax
801065b1:	85 c0                	test   %eax,%eax
801065b3:	74 0a                	je     801065bf <trap+0x4e>
      exit();
801065b5:	e8 93 de ff ff       	call   8010444d <exit>
    return;
801065ba:	e9 14 02 00 00       	jmp    801067d3 <trap+0x262>
801065bf:	e9 0f 02 00 00       	jmp    801067d3 <trap+0x262>
  }

  switch(tf->trapno){
801065c4:	8b 45 08             	mov    0x8(%ebp),%eax
801065c7:	8b 40 30             	mov    0x30(%eax),%eax
801065ca:	83 e8 20             	sub    $0x20,%eax
801065cd:	83 f8 1f             	cmp    $0x1f,%eax
801065d0:	0f 87 c0 00 00 00    	ja     80106696 <trap+0x125>
801065d6:	8b 04 85 cc 87 10 80 	mov    -0x7fef7834(,%eax,4),%eax
801065dd:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
801065df:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801065e5:	0f b6 00             	movzbl (%eax),%eax
801065e8:	84 c0                	test   %al,%al
801065ea:	75 3d                	jne    80106629 <trap+0xb8>
      acquire(&tickslock);
801065ec:	83 ec 0c             	sub    $0xc,%esp
801065ef:	68 00 1f 11 80       	push   $0x80111f00
801065f4:	e8 71 e5 ff ff       	call   80104b6a <acquire>
801065f9:	83 c4 10             	add    $0x10,%esp
      ticks++;
801065fc:	a1 40 27 11 80       	mov    0x80112740,%eax
80106601:	83 c0 01             	add    $0x1,%eax
80106604:	a3 40 27 11 80       	mov    %eax,0x80112740
      wakeup(&ticks);
80106609:	83 ec 0c             	sub    $0xc,%esp
8010660c:	68 40 27 11 80       	push   $0x80112740
80106611:	e8 3b e3 ff ff       	call   80104951 <wakeup>
80106616:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
80106619:	83 ec 0c             	sub    $0xc,%esp
8010661c:	68 00 1f 11 80       	push   $0x80111f00
80106621:	e8 aa e5 ff ff       	call   80104bd0 <release>
80106626:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
80106629:	e8 ec c8 ff ff       	call   80102f1a <lapiceoi>
    break;
8010662e:	e9 1c 01 00 00       	jmp    8010674f <trap+0x1de>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106633:	e8 20 c1 ff ff       	call   80102758 <ideintr>
    lapiceoi();
80106638:	e8 dd c8 ff ff       	call   80102f1a <lapiceoi>
    break;
8010663d:	e9 0d 01 00 00       	jmp    8010674f <trap+0x1de>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106642:	e8 f7 c6 ff ff       	call   80102d3e <kbdintr>
    lapiceoi();
80106647:	e8 ce c8 ff ff       	call   80102f1a <lapiceoi>
    break;
8010664c:	e9 fe 00 00 00       	jmp    8010674f <trap+0x1de>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106651:	e8 5a 03 00 00       	call   801069b0 <uartintr>
    lapiceoi();
80106656:	e8 bf c8 ff ff       	call   80102f1a <lapiceoi>
    break;
8010665b:	e9 ef 00 00 00       	jmp    8010674f <trap+0x1de>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106660:	8b 45 08             	mov    0x8(%ebp),%eax
80106663:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80106666:	8b 45 08             	mov    0x8(%ebp),%eax
80106669:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010666d:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
80106670:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106676:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106679:	0f b6 c0             	movzbl %al,%eax
8010667c:	51                   	push   %ecx
8010667d:	52                   	push   %edx
8010667e:	50                   	push   %eax
8010667f:	68 2c 87 10 80       	push   $0x8010872c
80106684:	e8 36 9d ff ff       	call   801003bf <cprintf>
80106689:	83 c4 10             	add    $0x10,%esp
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
8010668c:	e8 89 c8 ff ff       	call   80102f1a <lapiceoi>
    break;
80106691:	e9 b9 00 00 00       	jmp    8010674f <trap+0x1de>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106696:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010669c:	85 c0                	test   %eax,%eax
8010669e:	74 11                	je     801066b1 <trap+0x140>
801066a0:	8b 45 08             	mov    0x8(%ebp),%eax
801066a3:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801066a7:	0f b7 c0             	movzwl %ax,%eax
801066aa:	83 e0 03             	and    $0x3,%eax
801066ad:	85 c0                	test   %eax,%eax
801066af:	75 40                	jne    801066f1 <trap+0x180>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801066b1:	e8 1e fd ff ff       	call   801063d4 <rcr2>
801066b6:	89 c3                	mov    %eax,%ebx
801066b8:	8b 45 08             	mov    0x8(%ebp),%eax
801066bb:	8b 48 38             	mov    0x38(%eax),%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
801066be:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801066c4:	0f b6 00             	movzbl (%eax),%eax
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801066c7:	0f b6 d0             	movzbl %al,%edx
801066ca:	8b 45 08             	mov    0x8(%ebp),%eax
801066cd:	8b 40 30             	mov    0x30(%eax),%eax
801066d0:	83 ec 0c             	sub    $0xc,%esp
801066d3:	53                   	push   %ebx
801066d4:	51                   	push   %ecx
801066d5:	52                   	push   %edx
801066d6:	50                   	push   %eax
801066d7:	68 50 87 10 80       	push   $0x80108750
801066dc:	e8 de 9c ff ff       	call   801003bf <cprintf>
801066e1:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
801066e4:	83 ec 0c             	sub    $0xc,%esp
801066e7:	68 82 87 10 80       	push   $0x80108782
801066ec:	e8 6b 9e ff ff       	call   8010055c <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801066f1:	e8 de fc ff ff       	call   801063d4 <rcr2>
801066f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801066f9:	8b 45 08             	mov    0x8(%ebp),%eax
801066fc:	8b 70 38             	mov    0x38(%eax),%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801066ff:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106705:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106708:	0f b6 d8             	movzbl %al,%ebx
8010670b:	8b 45 08             	mov    0x8(%ebp),%eax
8010670e:	8b 48 34             	mov    0x34(%eax),%ecx
80106711:	8b 45 08             	mov    0x8(%ebp),%eax
80106714:	8b 50 30             	mov    0x30(%eax),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106717:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010671d:	8d 78 6c             	lea    0x6c(%eax),%edi
80106720:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106726:	8b 40 10             	mov    0x10(%eax),%eax
80106729:	ff 75 e4             	pushl  -0x1c(%ebp)
8010672c:	56                   	push   %esi
8010672d:	53                   	push   %ebx
8010672e:	51                   	push   %ecx
8010672f:	52                   	push   %edx
80106730:	57                   	push   %edi
80106731:	50                   	push   %eax
80106732:	68 88 87 10 80       	push   $0x80108788
80106737:	e8 83 9c ff ff       	call   801003bf <cprintf>
8010673c:	83 c4 20             	add    $0x20,%esp
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
8010673f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106745:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010674c:	eb 01                	jmp    8010674f <trap+0x1de>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
8010674e:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
8010674f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106755:	85 c0                	test   %eax,%eax
80106757:	74 24                	je     8010677d <trap+0x20c>
80106759:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010675f:	8b 40 24             	mov    0x24(%eax),%eax
80106762:	85 c0                	test   %eax,%eax
80106764:	74 17                	je     8010677d <trap+0x20c>
80106766:	8b 45 08             	mov    0x8(%ebp),%eax
80106769:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
8010676d:	0f b7 c0             	movzwl %ax,%eax
80106770:	83 e0 03             	and    $0x3,%eax
80106773:	83 f8 03             	cmp    $0x3,%eax
80106776:	75 05                	jne    8010677d <trap+0x20c>
    exit();
80106778:	e8 d0 dc ff ff       	call   8010444d <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
8010677d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106783:	85 c0                	test   %eax,%eax
80106785:	74 1e                	je     801067a5 <trap+0x234>
80106787:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010678d:	8b 40 0c             	mov    0xc(%eax),%eax
80106790:	83 f8 04             	cmp    $0x4,%eax
80106793:	75 10                	jne    801067a5 <trap+0x234>
80106795:	8b 45 08             	mov    0x8(%ebp),%eax
80106798:	8b 40 30             	mov    0x30(%eax),%eax
8010679b:	83 f8 20             	cmp    $0x20,%eax
8010679e:	75 05                	jne    801067a5 <trap+0x234>
    yield();
801067a0:	e8 59 e0 ff ff       	call   801047fe <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
801067a5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801067ab:	85 c0                	test   %eax,%eax
801067ad:	74 24                	je     801067d3 <trap+0x262>
801067af:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801067b5:	8b 40 24             	mov    0x24(%eax),%eax
801067b8:	85 c0                	test   %eax,%eax
801067ba:	74 17                	je     801067d3 <trap+0x262>
801067bc:	8b 45 08             	mov    0x8(%ebp),%eax
801067bf:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801067c3:	0f b7 c0             	movzwl %ax,%eax
801067c6:	83 e0 03             	and    $0x3,%eax
801067c9:	83 f8 03             	cmp    $0x3,%eax
801067cc:	75 05                	jne    801067d3 <trap+0x262>
    exit();
801067ce:	e8 7a dc ff ff       	call   8010444d <exit>
}
801067d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067d6:	5b                   	pop    %ebx
801067d7:	5e                   	pop    %esi
801067d8:	5f                   	pop    %edi
801067d9:	5d                   	pop    %ebp
801067da:	c3                   	ret    

801067db <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801067db:	55                   	push   %ebp
801067dc:	89 e5                	mov    %esp,%ebp
801067de:	83 ec 14             	sub    $0x14,%esp
801067e1:	8b 45 08             	mov    0x8(%ebp),%eax
801067e4:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801067e8:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801067ec:	89 c2                	mov    %eax,%edx
801067ee:	ec                   	in     (%dx),%al
801067ef:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801067f2:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801067f6:	c9                   	leave  
801067f7:	c3                   	ret    

801067f8 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801067f8:	55                   	push   %ebp
801067f9:	89 e5                	mov    %esp,%ebp
801067fb:	83 ec 08             	sub    $0x8,%esp
801067fe:	8b 55 08             	mov    0x8(%ebp),%edx
80106801:	8b 45 0c             	mov    0xc(%ebp),%eax
80106804:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106808:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010680b:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010680f:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106813:	ee                   	out    %al,(%dx)
}
80106814:	c9                   	leave  
80106815:	c3                   	ret    

80106816 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106816:	55                   	push   %ebp
80106817:	89 e5                	mov    %esp,%ebp
80106819:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
8010681c:	6a 00                	push   $0x0
8010681e:	68 fa 03 00 00       	push   $0x3fa
80106823:	e8 d0 ff ff ff       	call   801067f8 <outb>
80106828:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
8010682b:	68 80 00 00 00       	push   $0x80
80106830:	68 fb 03 00 00       	push   $0x3fb
80106835:	e8 be ff ff ff       	call   801067f8 <outb>
8010683a:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
8010683d:	6a 0c                	push   $0xc
8010683f:	68 f8 03 00 00       	push   $0x3f8
80106844:	e8 af ff ff ff       	call   801067f8 <outb>
80106849:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
8010684c:	6a 00                	push   $0x0
8010684e:	68 f9 03 00 00       	push   $0x3f9
80106853:	e8 a0 ff ff ff       	call   801067f8 <outb>
80106858:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
8010685b:	6a 03                	push   $0x3
8010685d:	68 fb 03 00 00       	push   $0x3fb
80106862:	e8 91 ff ff ff       	call   801067f8 <outb>
80106867:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
8010686a:	6a 00                	push   $0x0
8010686c:	68 fc 03 00 00       	push   $0x3fc
80106871:	e8 82 ff ff ff       	call   801067f8 <outb>
80106876:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106879:	6a 01                	push   $0x1
8010687b:	68 f9 03 00 00       	push   $0x3f9
80106880:	e8 73 ff ff ff       	call   801067f8 <outb>
80106885:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106888:	68 fd 03 00 00       	push   $0x3fd
8010688d:	e8 49 ff ff ff       	call   801067db <inb>
80106892:	83 c4 04             	add    $0x4,%esp
80106895:	3c ff                	cmp    $0xff,%al
80106897:	75 02                	jne    8010689b <uartinit+0x85>
    return;
80106899:	eb 6c                	jmp    80106907 <uartinit+0xf1>
  uart = 1;
8010689b:	c7 05 6c b6 10 80 01 	movl   $0x1,0x8010b66c
801068a2:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
801068a5:	68 fa 03 00 00       	push   $0x3fa
801068aa:	e8 2c ff ff ff       	call   801067db <inb>
801068af:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
801068b2:	68 f8 03 00 00       	push   $0x3f8
801068b7:	e8 1f ff ff ff       	call   801067db <inb>
801068bc:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
801068bf:	83 ec 0c             	sub    $0xc,%esp
801068c2:	6a 04                	push   $0x4
801068c4:	e8 09 d2 ff ff       	call   80103ad2 <picenable>
801068c9:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
801068cc:	83 ec 08             	sub    $0x8,%esp
801068cf:	6a 00                	push   $0x0
801068d1:	6a 04                	push   $0x4
801068d3:	e8 1e c1 ff ff       	call   801029f6 <ioapicenable>
801068d8:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801068db:	c7 45 f4 4c 88 10 80 	movl   $0x8010884c,-0xc(%ebp)
801068e2:	eb 19                	jmp    801068fd <uartinit+0xe7>
    uartputc(*p);
801068e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068e7:	0f b6 00             	movzbl (%eax),%eax
801068ea:	0f be c0             	movsbl %al,%eax
801068ed:	83 ec 0c             	sub    $0xc,%esp
801068f0:	50                   	push   %eax
801068f1:	e8 13 00 00 00       	call   80106909 <uartputc>
801068f6:	83 c4 10             	add    $0x10,%esp
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801068f9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801068fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106900:	0f b6 00             	movzbl (%eax),%eax
80106903:	84 c0                	test   %al,%al
80106905:	75 dd                	jne    801068e4 <uartinit+0xce>
    uartputc(*p);
}
80106907:	c9                   	leave  
80106908:	c3                   	ret    

80106909 <uartputc>:

void
uartputc(int c)
{
80106909:	55                   	push   %ebp
8010690a:	89 e5                	mov    %esp,%ebp
8010690c:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
8010690f:	a1 6c b6 10 80       	mov    0x8010b66c,%eax
80106914:	85 c0                	test   %eax,%eax
80106916:	75 02                	jne    8010691a <uartputc+0x11>
    return;
80106918:	eb 51                	jmp    8010696b <uartputc+0x62>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010691a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106921:	eb 11                	jmp    80106934 <uartputc+0x2b>
    microdelay(10);
80106923:	83 ec 0c             	sub    $0xc,%esp
80106926:	6a 0a                	push   $0xa
80106928:	e8 07 c6 ff ff       	call   80102f34 <microdelay>
8010692d:	83 c4 10             	add    $0x10,%esp
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106930:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106934:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106938:	7f 1a                	jg     80106954 <uartputc+0x4b>
8010693a:	83 ec 0c             	sub    $0xc,%esp
8010693d:	68 fd 03 00 00       	push   $0x3fd
80106942:	e8 94 fe ff ff       	call   801067db <inb>
80106947:	83 c4 10             	add    $0x10,%esp
8010694a:	0f b6 c0             	movzbl %al,%eax
8010694d:	83 e0 20             	and    $0x20,%eax
80106950:	85 c0                	test   %eax,%eax
80106952:	74 cf                	je     80106923 <uartputc+0x1a>
    microdelay(10);
  outb(COM1+0, c);
80106954:	8b 45 08             	mov    0x8(%ebp),%eax
80106957:	0f b6 c0             	movzbl %al,%eax
8010695a:	83 ec 08             	sub    $0x8,%esp
8010695d:	50                   	push   %eax
8010695e:	68 f8 03 00 00       	push   $0x3f8
80106963:	e8 90 fe ff ff       	call   801067f8 <outb>
80106968:	83 c4 10             	add    $0x10,%esp
}
8010696b:	c9                   	leave  
8010696c:	c3                   	ret    

8010696d <uartgetc>:

static int
uartgetc(void)
{
8010696d:	55                   	push   %ebp
8010696e:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106970:	a1 6c b6 10 80       	mov    0x8010b66c,%eax
80106975:	85 c0                	test   %eax,%eax
80106977:	75 07                	jne    80106980 <uartgetc+0x13>
    return -1;
80106979:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010697e:	eb 2e                	jmp    801069ae <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80106980:	68 fd 03 00 00       	push   $0x3fd
80106985:	e8 51 fe ff ff       	call   801067db <inb>
8010698a:	83 c4 04             	add    $0x4,%esp
8010698d:	0f b6 c0             	movzbl %al,%eax
80106990:	83 e0 01             	and    $0x1,%eax
80106993:	85 c0                	test   %eax,%eax
80106995:	75 07                	jne    8010699e <uartgetc+0x31>
    return -1;
80106997:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010699c:	eb 10                	jmp    801069ae <uartgetc+0x41>
  return inb(COM1+0);
8010699e:	68 f8 03 00 00       	push   $0x3f8
801069a3:	e8 33 fe ff ff       	call   801067db <inb>
801069a8:	83 c4 04             	add    $0x4,%esp
801069ab:	0f b6 c0             	movzbl %al,%eax
}
801069ae:	c9                   	leave  
801069af:	c3                   	ret    

801069b0 <uartintr>:

void
uartintr(void)
{
801069b0:	55                   	push   %ebp
801069b1:	89 e5                	mov    %esp,%ebp
801069b3:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
801069b6:	83 ec 0c             	sub    $0xc,%esp
801069b9:	68 6d 69 10 80       	push   $0x8010696d
801069be:	e8 0e 9e ff ff       	call   801007d1 <consoleintr>
801069c3:	83 c4 10             	add    $0x10,%esp
}
801069c6:	c9                   	leave  
801069c7:	c3                   	ret    

801069c8 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801069c8:	6a 00                	push   $0x0
  pushl $0
801069ca:	6a 00                	push   $0x0
  jmp alltraps
801069cc:	e9 af f9 ff ff       	jmp    80106380 <alltraps>

801069d1 <vector1>:
.globl vector1
vector1:
  pushl $0
801069d1:	6a 00                	push   $0x0
  pushl $1
801069d3:	6a 01                	push   $0x1
  jmp alltraps
801069d5:	e9 a6 f9 ff ff       	jmp    80106380 <alltraps>

801069da <vector2>:
.globl vector2
vector2:
  pushl $0
801069da:	6a 00                	push   $0x0
  pushl $2
801069dc:	6a 02                	push   $0x2
  jmp alltraps
801069de:	e9 9d f9 ff ff       	jmp    80106380 <alltraps>

801069e3 <vector3>:
.globl vector3
vector3:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $3
801069e5:	6a 03                	push   $0x3
  jmp alltraps
801069e7:	e9 94 f9 ff ff       	jmp    80106380 <alltraps>

801069ec <vector4>:
.globl vector4
vector4:
  pushl $0
801069ec:	6a 00                	push   $0x0
  pushl $4
801069ee:	6a 04                	push   $0x4
  jmp alltraps
801069f0:	e9 8b f9 ff ff       	jmp    80106380 <alltraps>

801069f5 <vector5>:
.globl vector5
vector5:
  pushl $0
801069f5:	6a 00                	push   $0x0
  pushl $5
801069f7:	6a 05                	push   $0x5
  jmp alltraps
801069f9:	e9 82 f9 ff ff       	jmp    80106380 <alltraps>

801069fe <vector6>:
.globl vector6
vector6:
  pushl $0
801069fe:	6a 00                	push   $0x0
  pushl $6
80106a00:	6a 06                	push   $0x6
  jmp alltraps
80106a02:	e9 79 f9 ff ff       	jmp    80106380 <alltraps>

80106a07 <vector7>:
.globl vector7
vector7:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $7
80106a09:	6a 07                	push   $0x7
  jmp alltraps
80106a0b:	e9 70 f9 ff ff       	jmp    80106380 <alltraps>

80106a10 <vector8>:
.globl vector8
vector8:
  pushl $8
80106a10:	6a 08                	push   $0x8
  jmp alltraps
80106a12:	e9 69 f9 ff ff       	jmp    80106380 <alltraps>

80106a17 <vector9>:
.globl vector9
vector9:
  pushl $0
80106a17:	6a 00                	push   $0x0
  pushl $9
80106a19:	6a 09                	push   $0x9
  jmp alltraps
80106a1b:	e9 60 f9 ff ff       	jmp    80106380 <alltraps>

80106a20 <vector10>:
.globl vector10
vector10:
  pushl $10
80106a20:	6a 0a                	push   $0xa
  jmp alltraps
80106a22:	e9 59 f9 ff ff       	jmp    80106380 <alltraps>

80106a27 <vector11>:
.globl vector11
vector11:
  pushl $11
80106a27:	6a 0b                	push   $0xb
  jmp alltraps
80106a29:	e9 52 f9 ff ff       	jmp    80106380 <alltraps>

80106a2e <vector12>:
.globl vector12
vector12:
  pushl $12
80106a2e:	6a 0c                	push   $0xc
  jmp alltraps
80106a30:	e9 4b f9 ff ff       	jmp    80106380 <alltraps>

80106a35 <vector13>:
.globl vector13
vector13:
  pushl $13
80106a35:	6a 0d                	push   $0xd
  jmp alltraps
80106a37:	e9 44 f9 ff ff       	jmp    80106380 <alltraps>

80106a3c <vector14>:
.globl vector14
vector14:
  pushl $14
80106a3c:	6a 0e                	push   $0xe
  jmp alltraps
80106a3e:	e9 3d f9 ff ff       	jmp    80106380 <alltraps>

80106a43 <vector15>:
.globl vector15
vector15:
  pushl $0
80106a43:	6a 00                	push   $0x0
  pushl $15
80106a45:	6a 0f                	push   $0xf
  jmp alltraps
80106a47:	e9 34 f9 ff ff       	jmp    80106380 <alltraps>

80106a4c <vector16>:
.globl vector16
vector16:
  pushl $0
80106a4c:	6a 00                	push   $0x0
  pushl $16
80106a4e:	6a 10                	push   $0x10
  jmp alltraps
80106a50:	e9 2b f9 ff ff       	jmp    80106380 <alltraps>

80106a55 <vector17>:
.globl vector17
vector17:
  pushl $17
80106a55:	6a 11                	push   $0x11
  jmp alltraps
80106a57:	e9 24 f9 ff ff       	jmp    80106380 <alltraps>

80106a5c <vector18>:
.globl vector18
vector18:
  pushl $0
80106a5c:	6a 00                	push   $0x0
  pushl $18
80106a5e:	6a 12                	push   $0x12
  jmp alltraps
80106a60:	e9 1b f9 ff ff       	jmp    80106380 <alltraps>

80106a65 <vector19>:
.globl vector19
vector19:
  pushl $0
80106a65:	6a 00                	push   $0x0
  pushl $19
80106a67:	6a 13                	push   $0x13
  jmp alltraps
80106a69:	e9 12 f9 ff ff       	jmp    80106380 <alltraps>

80106a6e <vector20>:
.globl vector20
vector20:
  pushl $0
80106a6e:	6a 00                	push   $0x0
  pushl $20
80106a70:	6a 14                	push   $0x14
  jmp alltraps
80106a72:	e9 09 f9 ff ff       	jmp    80106380 <alltraps>

80106a77 <vector21>:
.globl vector21
vector21:
  pushl $0
80106a77:	6a 00                	push   $0x0
  pushl $21
80106a79:	6a 15                	push   $0x15
  jmp alltraps
80106a7b:	e9 00 f9 ff ff       	jmp    80106380 <alltraps>

80106a80 <vector22>:
.globl vector22
vector22:
  pushl $0
80106a80:	6a 00                	push   $0x0
  pushl $22
80106a82:	6a 16                	push   $0x16
  jmp alltraps
80106a84:	e9 f7 f8 ff ff       	jmp    80106380 <alltraps>

80106a89 <vector23>:
.globl vector23
vector23:
  pushl $0
80106a89:	6a 00                	push   $0x0
  pushl $23
80106a8b:	6a 17                	push   $0x17
  jmp alltraps
80106a8d:	e9 ee f8 ff ff       	jmp    80106380 <alltraps>

80106a92 <vector24>:
.globl vector24
vector24:
  pushl $0
80106a92:	6a 00                	push   $0x0
  pushl $24
80106a94:	6a 18                	push   $0x18
  jmp alltraps
80106a96:	e9 e5 f8 ff ff       	jmp    80106380 <alltraps>

80106a9b <vector25>:
.globl vector25
vector25:
  pushl $0
80106a9b:	6a 00                	push   $0x0
  pushl $25
80106a9d:	6a 19                	push   $0x19
  jmp alltraps
80106a9f:	e9 dc f8 ff ff       	jmp    80106380 <alltraps>

80106aa4 <vector26>:
.globl vector26
vector26:
  pushl $0
80106aa4:	6a 00                	push   $0x0
  pushl $26
80106aa6:	6a 1a                	push   $0x1a
  jmp alltraps
80106aa8:	e9 d3 f8 ff ff       	jmp    80106380 <alltraps>

80106aad <vector27>:
.globl vector27
vector27:
  pushl $0
80106aad:	6a 00                	push   $0x0
  pushl $27
80106aaf:	6a 1b                	push   $0x1b
  jmp alltraps
80106ab1:	e9 ca f8 ff ff       	jmp    80106380 <alltraps>

80106ab6 <vector28>:
.globl vector28
vector28:
  pushl $0
80106ab6:	6a 00                	push   $0x0
  pushl $28
80106ab8:	6a 1c                	push   $0x1c
  jmp alltraps
80106aba:	e9 c1 f8 ff ff       	jmp    80106380 <alltraps>

80106abf <vector29>:
.globl vector29
vector29:
  pushl $0
80106abf:	6a 00                	push   $0x0
  pushl $29
80106ac1:	6a 1d                	push   $0x1d
  jmp alltraps
80106ac3:	e9 b8 f8 ff ff       	jmp    80106380 <alltraps>

80106ac8 <vector30>:
.globl vector30
vector30:
  pushl $0
80106ac8:	6a 00                	push   $0x0
  pushl $30
80106aca:	6a 1e                	push   $0x1e
  jmp alltraps
80106acc:	e9 af f8 ff ff       	jmp    80106380 <alltraps>

80106ad1 <vector31>:
.globl vector31
vector31:
  pushl $0
80106ad1:	6a 00                	push   $0x0
  pushl $31
80106ad3:	6a 1f                	push   $0x1f
  jmp alltraps
80106ad5:	e9 a6 f8 ff ff       	jmp    80106380 <alltraps>

80106ada <vector32>:
.globl vector32
vector32:
  pushl $0
80106ada:	6a 00                	push   $0x0
  pushl $32
80106adc:	6a 20                	push   $0x20
  jmp alltraps
80106ade:	e9 9d f8 ff ff       	jmp    80106380 <alltraps>

80106ae3 <vector33>:
.globl vector33
vector33:
  pushl $0
80106ae3:	6a 00                	push   $0x0
  pushl $33
80106ae5:	6a 21                	push   $0x21
  jmp alltraps
80106ae7:	e9 94 f8 ff ff       	jmp    80106380 <alltraps>

80106aec <vector34>:
.globl vector34
vector34:
  pushl $0
80106aec:	6a 00                	push   $0x0
  pushl $34
80106aee:	6a 22                	push   $0x22
  jmp alltraps
80106af0:	e9 8b f8 ff ff       	jmp    80106380 <alltraps>

80106af5 <vector35>:
.globl vector35
vector35:
  pushl $0
80106af5:	6a 00                	push   $0x0
  pushl $35
80106af7:	6a 23                	push   $0x23
  jmp alltraps
80106af9:	e9 82 f8 ff ff       	jmp    80106380 <alltraps>

80106afe <vector36>:
.globl vector36
vector36:
  pushl $0
80106afe:	6a 00                	push   $0x0
  pushl $36
80106b00:	6a 24                	push   $0x24
  jmp alltraps
80106b02:	e9 79 f8 ff ff       	jmp    80106380 <alltraps>

80106b07 <vector37>:
.globl vector37
vector37:
  pushl $0
80106b07:	6a 00                	push   $0x0
  pushl $37
80106b09:	6a 25                	push   $0x25
  jmp alltraps
80106b0b:	e9 70 f8 ff ff       	jmp    80106380 <alltraps>

80106b10 <vector38>:
.globl vector38
vector38:
  pushl $0
80106b10:	6a 00                	push   $0x0
  pushl $38
80106b12:	6a 26                	push   $0x26
  jmp alltraps
80106b14:	e9 67 f8 ff ff       	jmp    80106380 <alltraps>

80106b19 <vector39>:
.globl vector39
vector39:
  pushl $0
80106b19:	6a 00                	push   $0x0
  pushl $39
80106b1b:	6a 27                	push   $0x27
  jmp alltraps
80106b1d:	e9 5e f8 ff ff       	jmp    80106380 <alltraps>

80106b22 <vector40>:
.globl vector40
vector40:
  pushl $0
80106b22:	6a 00                	push   $0x0
  pushl $40
80106b24:	6a 28                	push   $0x28
  jmp alltraps
80106b26:	e9 55 f8 ff ff       	jmp    80106380 <alltraps>

80106b2b <vector41>:
.globl vector41
vector41:
  pushl $0
80106b2b:	6a 00                	push   $0x0
  pushl $41
80106b2d:	6a 29                	push   $0x29
  jmp alltraps
80106b2f:	e9 4c f8 ff ff       	jmp    80106380 <alltraps>

80106b34 <vector42>:
.globl vector42
vector42:
  pushl $0
80106b34:	6a 00                	push   $0x0
  pushl $42
80106b36:	6a 2a                	push   $0x2a
  jmp alltraps
80106b38:	e9 43 f8 ff ff       	jmp    80106380 <alltraps>

80106b3d <vector43>:
.globl vector43
vector43:
  pushl $0
80106b3d:	6a 00                	push   $0x0
  pushl $43
80106b3f:	6a 2b                	push   $0x2b
  jmp alltraps
80106b41:	e9 3a f8 ff ff       	jmp    80106380 <alltraps>

80106b46 <vector44>:
.globl vector44
vector44:
  pushl $0
80106b46:	6a 00                	push   $0x0
  pushl $44
80106b48:	6a 2c                	push   $0x2c
  jmp alltraps
80106b4a:	e9 31 f8 ff ff       	jmp    80106380 <alltraps>

80106b4f <vector45>:
.globl vector45
vector45:
  pushl $0
80106b4f:	6a 00                	push   $0x0
  pushl $45
80106b51:	6a 2d                	push   $0x2d
  jmp alltraps
80106b53:	e9 28 f8 ff ff       	jmp    80106380 <alltraps>

80106b58 <vector46>:
.globl vector46
vector46:
  pushl $0
80106b58:	6a 00                	push   $0x0
  pushl $46
80106b5a:	6a 2e                	push   $0x2e
  jmp alltraps
80106b5c:	e9 1f f8 ff ff       	jmp    80106380 <alltraps>

80106b61 <vector47>:
.globl vector47
vector47:
  pushl $0
80106b61:	6a 00                	push   $0x0
  pushl $47
80106b63:	6a 2f                	push   $0x2f
  jmp alltraps
80106b65:	e9 16 f8 ff ff       	jmp    80106380 <alltraps>

80106b6a <vector48>:
.globl vector48
vector48:
  pushl $0
80106b6a:	6a 00                	push   $0x0
  pushl $48
80106b6c:	6a 30                	push   $0x30
  jmp alltraps
80106b6e:	e9 0d f8 ff ff       	jmp    80106380 <alltraps>

80106b73 <vector49>:
.globl vector49
vector49:
  pushl $0
80106b73:	6a 00                	push   $0x0
  pushl $49
80106b75:	6a 31                	push   $0x31
  jmp alltraps
80106b77:	e9 04 f8 ff ff       	jmp    80106380 <alltraps>

80106b7c <vector50>:
.globl vector50
vector50:
  pushl $0
80106b7c:	6a 00                	push   $0x0
  pushl $50
80106b7e:	6a 32                	push   $0x32
  jmp alltraps
80106b80:	e9 fb f7 ff ff       	jmp    80106380 <alltraps>

80106b85 <vector51>:
.globl vector51
vector51:
  pushl $0
80106b85:	6a 00                	push   $0x0
  pushl $51
80106b87:	6a 33                	push   $0x33
  jmp alltraps
80106b89:	e9 f2 f7 ff ff       	jmp    80106380 <alltraps>

80106b8e <vector52>:
.globl vector52
vector52:
  pushl $0
80106b8e:	6a 00                	push   $0x0
  pushl $52
80106b90:	6a 34                	push   $0x34
  jmp alltraps
80106b92:	e9 e9 f7 ff ff       	jmp    80106380 <alltraps>

80106b97 <vector53>:
.globl vector53
vector53:
  pushl $0
80106b97:	6a 00                	push   $0x0
  pushl $53
80106b99:	6a 35                	push   $0x35
  jmp alltraps
80106b9b:	e9 e0 f7 ff ff       	jmp    80106380 <alltraps>

80106ba0 <vector54>:
.globl vector54
vector54:
  pushl $0
80106ba0:	6a 00                	push   $0x0
  pushl $54
80106ba2:	6a 36                	push   $0x36
  jmp alltraps
80106ba4:	e9 d7 f7 ff ff       	jmp    80106380 <alltraps>

80106ba9 <vector55>:
.globl vector55
vector55:
  pushl $0
80106ba9:	6a 00                	push   $0x0
  pushl $55
80106bab:	6a 37                	push   $0x37
  jmp alltraps
80106bad:	e9 ce f7 ff ff       	jmp    80106380 <alltraps>

80106bb2 <vector56>:
.globl vector56
vector56:
  pushl $0
80106bb2:	6a 00                	push   $0x0
  pushl $56
80106bb4:	6a 38                	push   $0x38
  jmp alltraps
80106bb6:	e9 c5 f7 ff ff       	jmp    80106380 <alltraps>

80106bbb <vector57>:
.globl vector57
vector57:
  pushl $0
80106bbb:	6a 00                	push   $0x0
  pushl $57
80106bbd:	6a 39                	push   $0x39
  jmp alltraps
80106bbf:	e9 bc f7 ff ff       	jmp    80106380 <alltraps>

80106bc4 <vector58>:
.globl vector58
vector58:
  pushl $0
80106bc4:	6a 00                	push   $0x0
  pushl $58
80106bc6:	6a 3a                	push   $0x3a
  jmp alltraps
80106bc8:	e9 b3 f7 ff ff       	jmp    80106380 <alltraps>

80106bcd <vector59>:
.globl vector59
vector59:
  pushl $0
80106bcd:	6a 00                	push   $0x0
  pushl $59
80106bcf:	6a 3b                	push   $0x3b
  jmp alltraps
80106bd1:	e9 aa f7 ff ff       	jmp    80106380 <alltraps>

80106bd6 <vector60>:
.globl vector60
vector60:
  pushl $0
80106bd6:	6a 00                	push   $0x0
  pushl $60
80106bd8:	6a 3c                	push   $0x3c
  jmp alltraps
80106bda:	e9 a1 f7 ff ff       	jmp    80106380 <alltraps>

80106bdf <vector61>:
.globl vector61
vector61:
  pushl $0
80106bdf:	6a 00                	push   $0x0
  pushl $61
80106be1:	6a 3d                	push   $0x3d
  jmp alltraps
80106be3:	e9 98 f7 ff ff       	jmp    80106380 <alltraps>

80106be8 <vector62>:
.globl vector62
vector62:
  pushl $0
80106be8:	6a 00                	push   $0x0
  pushl $62
80106bea:	6a 3e                	push   $0x3e
  jmp alltraps
80106bec:	e9 8f f7 ff ff       	jmp    80106380 <alltraps>

80106bf1 <vector63>:
.globl vector63
vector63:
  pushl $0
80106bf1:	6a 00                	push   $0x0
  pushl $63
80106bf3:	6a 3f                	push   $0x3f
  jmp alltraps
80106bf5:	e9 86 f7 ff ff       	jmp    80106380 <alltraps>

80106bfa <vector64>:
.globl vector64
vector64:
  pushl $0
80106bfa:	6a 00                	push   $0x0
  pushl $64
80106bfc:	6a 40                	push   $0x40
  jmp alltraps
80106bfe:	e9 7d f7 ff ff       	jmp    80106380 <alltraps>

80106c03 <vector65>:
.globl vector65
vector65:
  pushl $0
80106c03:	6a 00                	push   $0x0
  pushl $65
80106c05:	6a 41                	push   $0x41
  jmp alltraps
80106c07:	e9 74 f7 ff ff       	jmp    80106380 <alltraps>

80106c0c <vector66>:
.globl vector66
vector66:
  pushl $0
80106c0c:	6a 00                	push   $0x0
  pushl $66
80106c0e:	6a 42                	push   $0x42
  jmp alltraps
80106c10:	e9 6b f7 ff ff       	jmp    80106380 <alltraps>

80106c15 <vector67>:
.globl vector67
vector67:
  pushl $0
80106c15:	6a 00                	push   $0x0
  pushl $67
80106c17:	6a 43                	push   $0x43
  jmp alltraps
80106c19:	e9 62 f7 ff ff       	jmp    80106380 <alltraps>

80106c1e <vector68>:
.globl vector68
vector68:
  pushl $0
80106c1e:	6a 00                	push   $0x0
  pushl $68
80106c20:	6a 44                	push   $0x44
  jmp alltraps
80106c22:	e9 59 f7 ff ff       	jmp    80106380 <alltraps>

80106c27 <vector69>:
.globl vector69
vector69:
  pushl $0
80106c27:	6a 00                	push   $0x0
  pushl $69
80106c29:	6a 45                	push   $0x45
  jmp alltraps
80106c2b:	e9 50 f7 ff ff       	jmp    80106380 <alltraps>

80106c30 <vector70>:
.globl vector70
vector70:
  pushl $0
80106c30:	6a 00                	push   $0x0
  pushl $70
80106c32:	6a 46                	push   $0x46
  jmp alltraps
80106c34:	e9 47 f7 ff ff       	jmp    80106380 <alltraps>

80106c39 <vector71>:
.globl vector71
vector71:
  pushl $0
80106c39:	6a 00                	push   $0x0
  pushl $71
80106c3b:	6a 47                	push   $0x47
  jmp alltraps
80106c3d:	e9 3e f7 ff ff       	jmp    80106380 <alltraps>

80106c42 <vector72>:
.globl vector72
vector72:
  pushl $0
80106c42:	6a 00                	push   $0x0
  pushl $72
80106c44:	6a 48                	push   $0x48
  jmp alltraps
80106c46:	e9 35 f7 ff ff       	jmp    80106380 <alltraps>

80106c4b <vector73>:
.globl vector73
vector73:
  pushl $0
80106c4b:	6a 00                	push   $0x0
  pushl $73
80106c4d:	6a 49                	push   $0x49
  jmp alltraps
80106c4f:	e9 2c f7 ff ff       	jmp    80106380 <alltraps>

80106c54 <vector74>:
.globl vector74
vector74:
  pushl $0
80106c54:	6a 00                	push   $0x0
  pushl $74
80106c56:	6a 4a                	push   $0x4a
  jmp alltraps
80106c58:	e9 23 f7 ff ff       	jmp    80106380 <alltraps>

80106c5d <vector75>:
.globl vector75
vector75:
  pushl $0
80106c5d:	6a 00                	push   $0x0
  pushl $75
80106c5f:	6a 4b                	push   $0x4b
  jmp alltraps
80106c61:	e9 1a f7 ff ff       	jmp    80106380 <alltraps>

80106c66 <vector76>:
.globl vector76
vector76:
  pushl $0
80106c66:	6a 00                	push   $0x0
  pushl $76
80106c68:	6a 4c                	push   $0x4c
  jmp alltraps
80106c6a:	e9 11 f7 ff ff       	jmp    80106380 <alltraps>

80106c6f <vector77>:
.globl vector77
vector77:
  pushl $0
80106c6f:	6a 00                	push   $0x0
  pushl $77
80106c71:	6a 4d                	push   $0x4d
  jmp alltraps
80106c73:	e9 08 f7 ff ff       	jmp    80106380 <alltraps>

80106c78 <vector78>:
.globl vector78
vector78:
  pushl $0
80106c78:	6a 00                	push   $0x0
  pushl $78
80106c7a:	6a 4e                	push   $0x4e
  jmp alltraps
80106c7c:	e9 ff f6 ff ff       	jmp    80106380 <alltraps>

80106c81 <vector79>:
.globl vector79
vector79:
  pushl $0
80106c81:	6a 00                	push   $0x0
  pushl $79
80106c83:	6a 4f                	push   $0x4f
  jmp alltraps
80106c85:	e9 f6 f6 ff ff       	jmp    80106380 <alltraps>

80106c8a <vector80>:
.globl vector80
vector80:
  pushl $0
80106c8a:	6a 00                	push   $0x0
  pushl $80
80106c8c:	6a 50                	push   $0x50
  jmp alltraps
80106c8e:	e9 ed f6 ff ff       	jmp    80106380 <alltraps>

80106c93 <vector81>:
.globl vector81
vector81:
  pushl $0
80106c93:	6a 00                	push   $0x0
  pushl $81
80106c95:	6a 51                	push   $0x51
  jmp alltraps
80106c97:	e9 e4 f6 ff ff       	jmp    80106380 <alltraps>

80106c9c <vector82>:
.globl vector82
vector82:
  pushl $0
80106c9c:	6a 00                	push   $0x0
  pushl $82
80106c9e:	6a 52                	push   $0x52
  jmp alltraps
80106ca0:	e9 db f6 ff ff       	jmp    80106380 <alltraps>

80106ca5 <vector83>:
.globl vector83
vector83:
  pushl $0
80106ca5:	6a 00                	push   $0x0
  pushl $83
80106ca7:	6a 53                	push   $0x53
  jmp alltraps
80106ca9:	e9 d2 f6 ff ff       	jmp    80106380 <alltraps>

80106cae <vector84>:
.globl vector84
vector84:
  pushl $0
80106cae:	6a 00                	push   $0x0
  pushl $84
80106cb0:	6a 54                	push   $0x54
  jmp alltraps
80106cb2:	e9 c9 f6 ff ff       	jmp    80106380 <alltraps>

80106cb7 <vector85>:
.globl vector85
vector85:
  pushl $0
80106cb7:	6a 00                	push   $0x0
  pushl $85
80106cb9:	6a 55                	push   $0x55
  jmp alltraps
80106cbb:	e9 c0 f6 ff ff       	jmp    80106380 <alltraps>

80106cc0 <vector86>:
.globl vector86
vector86:
  pushl $0
80106cc0:	6a 00                	push   $0x0
  pushl $86
80106cc2:	6a 56                	push   $0x56
  jmp alltraps
80106cc4:	e9 b7 f6 ff ff       	jmp    80106380 <alltraps>

80106cc9 <vector87>:
.globl vector87
vector87:
  pushl $0
80106cc9:	6a 00                	push   $0x0
  pushl $87
80106ccb:	6a 57                	push   $0x57
  jmp alltraps
80106ccd:	e9 ae f6 ff ff       	jmp    80106380 <alltraps>

80106cd2 <vector88>:
.globl vector88
vector88:
  pushl $0
80106cd2:	6a 00                	push   $0x0
  pushl $88
80106cd4:	6a 58                	push   $0x58
  jmp alltraps
80106cd6:	e9 a5 f6 ff ff       	jmp    80106380 <alltraps>

80106cdb <vector89>:
.globl vector89
vector89:
  pushl $0
80106cdb:	6a 00                	push   $0x0
  pushl $89
80106cdd:	6a 59                	push   $0x59
  jmp alltraps
80106cdf:	e9 9c f6 ff ff       	jmp    80106380 <alltraps>

80106ce4 <vector90>:
.globl vector90
vector90:
  pushl $0
80106ce4:	6a 00                	push   $0x0
  pushl $90
80106ce6:	6a 5a                	push   $0x5a
  jmp alltraps
80106ce8:	e9 93 f6 ff ff       	jmp    80106380 <alltraps>

80106ced <vector91>:
.globl vector91
vector91:
  pushl $0
80106ced:	6a 00                	push   $0x0
  pushl $91
80106cef:	6a 5b                	push   $0x5b
  jmp alltraps
80106cf1:	e9 8a f6 ff ff       	jmp    80106380 <alltraps>

80106cf6 <vector92>:
.globl vector92
vector92:
  pushl $0
80106cf6:	6a 00                	push   $0x0
  pushl $92
80106cf8:	6a 5c                	push   $0x5c
  jmp alltraps
80106cfa:	e9 81 f6 ff ff       	jmp    80106380 <alltraps>

80106cff <vector93>:
.globl vector93
vector93:
  pushl $0
80106cff:	6a 00                	push   $0x0
  pushl $93
80106d01:	6a 5d                	push   $0x5d
  jmp alltraps
80106d03:	e9 78 f6 ff ff       	jmp    80106380 <alltraps>

80106d08 <vector94>:
.globl vector94
vector94:
  pushl $0
80106d08:	6a 00                	push   $0x0
  pushl $94
80106d0a:	6a 5e                	push   $0x5e
  jmp alltraps
80106d0c:	e9 6f f6 ff ff       	jmp    80106380 <alltraps>

80106d11 <vector95>:
.globl vector95
vector95:
  pushl $0
80106d11:	6a 00                	push   $0x0
  pushl $95
80106d13:	6a 5f                	push   $0x5f
  jmp alltraps
80106d15:	e9 66 f6 ff ff       	jmp    80106380 <alltraps>

80106d1a <vector96>:
.globl vector96
vector96:
  pushl $0
80106d1a:	6a 00                	push   $0x0
  pushl $96
80106d1c:	6a 60                	push   $0x60
  jmp alltraps
80106d1e:	e9 5d f6 ff ff       	jmp    80106380 <alltraps>

80106d23 <vector97>:
.globl vector97
vector97:
  pushl $0
80106d23:	6a 00                	push   $0x0
  pushl $97
80106d25:	6a 61                	push   $0x61
  jmp alltraps
80106d27:	e9 54 f6 ff ff       	jmp    80106380 <alltraps>

80106d2c <vector98>:
.globl vector98
vector98:
  pushl $0
80106d2c:	6a 00                	push   $0x0
  pushl $98
80106d2e:	6a 62                	push   $0x62
  jmp alltraps
80106d30:	e9 4b f6 ff ff       	jmp    80106380 <alltraps>

80106d35 <vector99>:
.globl vector99
vector99:
  pushl $0
80106d35:	6a 00                	push   $0x0
  pushl $99
80106d37:	6a 63                	push   $0x63
  jmp alltraps
80106d39:	e9 42 f6 ff ff       	jmp    80106380 <alltraps>

80106d3e <vector100>:
.globl vector100
vector100:
  pushl $0
80106d3e:	6a 00                	push   $0x0
  pushl $100
80106d40:	6a 64                	push   $0x64
  jmp alltraps
80106d42:	e9 39 f6 ff ff       	jmp    80106380 <alltraps>

80106d47 <vector101>:
.globl vector101
vector101:
  pushl $0
80106d47:	6a 00                	push   $0x0
  pushl $101
80106d49:	6a 65                	push   $0x65
  jmp alltraps
80106d4b:	e9 30 f6 ff ff       	jmp    80106380 <alltraps>

80106d50 <vector102>:
.globl vector102
vector102:
  pushl $0
80106d50:	6a 00                	push   $0x0
  pushl $102
80106d52:	6a 66                	push   $0x66
  jmp alltraps
80106d54:	e9 27 f6 ff ff       	jmp    80106380 <alltraps>

80106d59 <vector103>:
.globl vector103
vector103:
  pushl $0
80106d59:	6a 00                	push   $0x0
  pushl $103
80106d5b:	6a 67                	push   $0x67
  jmp alltraps
80106d5d:	e9 1e f6 ff ff       	jmp    80106380 <alltraps>

80106d62 <vector104>:
.globl vector104
vector104:
  pushl $0
80106d62:	6a 00                	push   $0x0
  pushl $104
80106d64:	6a 68                	push   $0x68
  jmp alltraps
80106d66:	e9 15 f6 ff ff       	jmp    80106380 <alltraps>

80106d6b <vector105>:
.globl vector105
vector105:
  pushl $0
80106d6b:	6a 00                	push   $0x0
  pushl $105
80106d6d:	6a 69                	push   $0x69
  jmp alltraps
80106d6f:	e9 0c f6 ff ff       	jmp    80106380 <alltraps>

80106d74 <vector106>:
.globl vector106
vector106:
  pushl $0
80106d74:	6a 00                	push   $0x0
  pushl $106
80106d76:	6a 6a                	push   $0x6a
  jmp alltraps
80106d78:	e9 03 f6 ff ff       	jmp    80106380 <alltraps>

80106d7d <vector107>:
.globl vector107
vector107:
  pushl $0
80106d7d:	6a 00                	push   $0x0
  pushl $107
80106d7f:	6a 6b                	push   $0x6b
  jmp alltraps
80106d81:	e9 fa f5 ff ff       	jmp    80106380 <alltraps>

80106d86 <vector108>:
.globl vector108
vector108:
  pushl $0
80106d86:	6a 00                	push   $0x0
  pushl $108
80106d88:	6a 6c                	push   $0x6c
  jmp alltraps
80106d8a:	e9 f1 f5 ff ff       	jmp    80106380 <alltraps>

80106d8f <vector109>:
.globl vector109
vector109:
  pushl $0
80106d8f:	6a 00                	push   $0x0
  pushl $109
80106d91:	6a 6d                	push   $0x6d
  jmp alltraps
80106d93:	e9 e8 f5 ff ff       	jmp    80106380 <alltraps>

80106d98 <vector110>:
.globl vector110
vector110:
  pushl $0
80106d98:	6a 00                	push   $0x0
  pushl $110
80106d9a:	6a 6e                	push   $0x6e
  jmp alltraps
80106d9c:	e9 df f5 ff ff       	jmp    80106380 <alltraps>

80106da1 <vector111>:
.globl vector111
vector111:
  pushl $0
80106da1:	6a 00                	push   $0x0
  pushl $111
80106da3:	6a 6f                	push   $0x6f
  jmp alltraps
80106da5:	e9 d6 f5 ff ff       	jmp    80106380 <alltraps>

80106daa <vector112>:
.globl vector112
vector112:
  pushl $0
80106daa:	6a 00                	push   $0x0
  pushl $112
80106dac:	6a 70                	push   $0x70
  jmp alltraps
80106dae:	e9 cd f5 ff ff       	jmp    80106380 <alltraps>

80106db3 <vector113>:
.globl vector113
vector113:
  pushl $0
80106db3:	6a 00                	push   $0x0
  pushl $113
80106db5:	6a 71                	push   $0x71
  jmp alltraps
80106db7:	e9 c4 f5 ff ff       	jmp    80106380 <alltraps>

80106dbc <vector114>:
.globl vector114
vector114:
  pushl $0
80106dbc:	6a 00                	push   $0x0
  pushl $114
80106dbe:	6a 72                	push   $0x72
  jmp alltraps
80106dc0:	e9 bb f5 ff ff       	jmp    80106380 <alltraps>

80106dc5 <vector115>:
.globl vector115
vector115:
  pushl $0
80106dc5:	6a 00                	push   $0x0
  pushl $115
80106dc7:	6a 73                	push   $0x73
  jmp alltraps
80106dc9:	e9 b2 f5 ff ff       	jmp    80106380 <alltraps>

80106dce <vector116>:
.globl vector116
vector116:
  pushl $0
80106dce:	6a 00                	push   $0x0
  pushl $116
80106dd0:	6a 74                	push   $0x74
  jmp alltraps
80106dd2:	e9 a9 f5 ff ff       	jmp    80106380 <alltraps>

80106dd7 <vector117>:
.globl vector117
vector117:
  pushl $0
80106dd7:	6a 00                	push   $0x0
  pushl $117
80106dd9:	6a 75                	push   $0x75
  jmp alltraps
80106ddb:	e9 a0 f5 ff ff       	jmp    80106380 <alltraps>

80106de0 <vector118>:
.globl vector118
vector118:
  pushl $0
80106de0:	6a 00                	push   $0x0
  pushl $118
80106de2:	6a 76                	push   $0x76
  jmp alltraps
80106de4:	e9 97 f5 ff ff       	jmp    80106380 <alltraps>

80106de9 <vector119>:
.globl vector119
vector119:
  pushl $0
80106de9:	6a 00                	push   $0x0
  pushl $119
80106deb:	6a 77                	push   $0x77
  jmp alltraps
80106ded:	e9 8e f5 ff ff       	jmp    80106380 <alltraps>

80106df2 <vector120>:
.globl vector120
vector120:
  pushl $0
80106df2:	6a 00                	push   $0x0
  pushl $120
80106df4:	6a 78                	push   $0x78
  jmp alltraps
80106df6:	e9 85 f5 ff ff       	jmp    80106380 <alltraps>

80106dfb <vector121>:
.globl vector121
vector121:
  pushl $0
80106dfb:	6a 00                	push   $0x0
  pushl $121
80106dfd:	6a 79                	push   $0x79
  jmp alltraps
80106dff:	e9 7c f5 ff ff       	jmp    80106380 <alltraps>

80106e04 <vector122>:
.globl vector122
vector122:
  pushl $0
80106e04:	6a 00                	push   $0x0
  pushl $122
80106e06:	6a 7a                	push   $0x7a
  jmp alltraps
80106e08:	e9 73 f5 ff ff       	jmp    80106380 <alltraps>

80106e0d <vector123>:
.globl vector123
vector123:
  pushl $0
80106e0d:	6a 00                	push   $0x0
  pushl $123
80106e0f:	6a 7b                	push   $0x7b
  jmp alltraps
80106e11:	e9 6a f5 ff ff       	jmp    80106380 <alltraps>

80106e16 <vector124>:
.globl vector124
vector124:
  pushl $0
80106e16:	6a 00                	push   $0x0
  pushl $124
80106e18:	6a 7c                	push   $0x7c
  jmp alltraps
80106e1a:	e9 61 f5 ff ff       	jmp    80106380 <alltraps>

80106e1f <vector125>:
.globl vector125
vector125:
  pushl $0
80106e1f:	6a 00                	push   $0x0
  pushl $125
80106e21:	6a 7d                	push   $0x7d
  jmp alltraps
80106e23:	e9 58 f5 ff ff       	jmp    80106380 <alltraps>

80106e28 <vector126>:
.globl vector126
vector126:
  pushl $0
80106e28:	6a 00                	push   $0x0
  pushl $126
80106e2a:	6a 7e                	push   $0x7e
  jmp alltraps
80106e2c:	e9 4f f5 ff ff       	jmp    80106380 <alltraps>

80106e31 <vector127>:
.globl vector127
vector127:
  pushl $0
80106e31:	6a 00                	push   $0x0
  pushl $127
80106e33:	6a 7f                	push   $0x7f
  jmp alltraps
80106e35:	e9 46 f5 ff ff       	jmp    80106380 <alltraps>

80106e3a <vector128>:
.globl vector128
vector128:
  pushl $0
80106e3a:	6a 00                	push   $0x0
  pushl $128
80106e3c:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106e41:	e9 3a f5 ff ff       	jmp    80106380 <alltraps>

80106e46 <vector129>:
.globl vector129
vector129:
  pushl $0
80106e46:	6a 00                	push   $0x0
  pushl $129
80106e48:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106e4d:	e9 2e f5 ff ff       	jmp    80106380 <alltraps>

80106e52 <vector130>:
.globl vector130
vector130:
  pushl $0
80106e52:	6a 00                	push   $0x0
  pushl $130
80106e54:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106e59:	e9 22 f5 ff ff       	jmp    80106380 <alltraps>

80106e5e <vector131>:
.globl vector131
vector131:
  pushl $0
80106e5e:	6a 00                	push   $0x0
  pushl $131
80106e60:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106e65:	e9 16 f5 ff ff       	jmp    80106380 <alltraps>

80106e6a <vector132>:
.globl vector132
vector132:
  pushl $0
80106e6a:	6a 00                	push   $0x0
  pushl $132
80106e6c:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106e71:	e9 0a f5 ff ff       	jmp    80106380 <alltraps>

80106e76 <vector133>:
.globl vector133
vector133:
  pushl $0
80106e76:	6a 00                	push   $0x0
  pushl $133
80106e78:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106e7d:	e9 fe f4 ff ff       	jmp    80106380 <alltraps>

80106e82 <vector134>:
.globl vector134
vector134:
  pushl $0
80106e82:	6a 00                	push   $0x0
  pushl $134
80106e84:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106e89:	e9 f2 f4 ff ff       	jmp    80106380 <alltraps>

80106e8e <vector135>:
.globl vector135
vector135:
  pushl $0
80106e8e:	6a 00                	push   $0x0
  pushl $135
80106e90:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106e95:	e9 e6 f4 ff ff       	jmp    80106380 <alltraps>

80106e9a <vector136>:
.globl vector136
vector136:
  pushl $0
80106e9a:	6a 00                	push   $0x0
  pushl $136
80106e9c:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106ea1:	e9 da f4 ff ff       	jmp    80106380 <alltraps>

80106ea6 <vector137>:
.globl vector137
vector137:
  pushl $0
80106ea6:	6a 00                	push   $0x0
  pushl $137
80106ea8:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106ead:	e9 ce f4 ff ff       	jmp    80106380 <alltraps>

80106eb2 <vector138>:
.globl vector138
vector138:
  pushl $0
80106eb2:	6a 00                	push   $0x0
  pushl $138
80106eb4:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106eb9:	e9 c2 f4 ff ff       	jmp    80106380 <alltraps>

80106ebe <vector139>:
.globl vector139
vector139:
  pushl $0
80106ebe:	6a 00                	push   $0x0
  pushl $139
80106ec0:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106ec5:	e9 b6 f4 ff ff       	jmp    80106380 <alltraps>

80106eca <vector140>:
.globl vector140
vector140:
  pushl $0
80106eca:	6a 00                	push   $0x0
  pushl $140
80106ecc:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106ed1:	e9 aa f4 ff ff       	jmp    80106380 <alltraps>

80106ed6 <vector141>:
.globl vector141
vector141:
  pushl $0
80106ed6:	6a 00                	push   $0x0
  pushl $141
80106ed8:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106edd:	e9 9e f4 ff ff       	jmp    80106380 <alltraps>

80106ee2 <vector142>:
.globl vector142
vector142:
  pushl $0
80106ee2:	6a 00                	push   $0x0
  pushl $142
80106ee4:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106ee9:	e9 92 f4 ff ff       	jmp    80106380 <alltraps>

80106eee <vector143>:
.globl vector143
vector143:
  pushl $0
80106eee:	6a 00                	push   $0x0
  pushl $143
80106ef0:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106ef5:	e9 86 f4 ff ff       	jmp    80106380 <alltraps>

80106efa <vector144>:
.globl vector144
vector144:
  pushl $0
80106efa:	6a 00                	push   $0x0
  pushl $144
80106efc:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106f01:	e9 7a f4 ff ff       	jmp    80106380 <alltraps>

80106f06 <vector145>:
.globl vector145
vector145:
  pushl $0
80106f06:	6a 00                	push   $0x0
  pushl $145
80106f08:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106f0d:	e9 6e f4 ff ff       	jmp    80106380 <alltraps>

80106f12 <vector146>:
.globl vector146
vector146:
  pushl $0
80106f12:	6a 00                	push   $0x0
  pushl $146
80106f14:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106f19:	e9 62 f4 ff ff       	jmp    80106380 <alltraps>

80106f1e <vector147>:
.globl vector147
vector147:
  pushl $0
80106f1e:	6a 00                	push   $0x0
  pushl $147
80106f20:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106f25:	e9 56 f4 ff ff       	jmp    80106380 <alltraps>

80106f2a <vector148>:
.globl vector148
vector148:
  pushl $0
80106f2a:	6a 00                	push   $0x0
  pushl $148
80106f2c:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106f31:	e9 4a f4 ff ff       	jmp    80106380 <alltraps>

80106f36 <vector149>:
.globl vector149
vector149:
  pushl $0
80106f36:	6a 00                	push   $0x0
  pushl $149
80106f38:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106f3d:	e9 3e f4 ff ff       	jmp    80106380 <alltraps>

80106f42 <vector150>:
.globl vector150
vector150:
  pushl $0
80106f42:	6a 00                	push   $0x0
  pushl $150
80106f44:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106f49:	e9 32 f4 ff ff       	jmp    80106380 <alltraps>

80106f4e <vector151>:
.globl vector151
vector151:
  pushl $0
80106f4e:	6a 00                	push   $0x0
  pushl $151
80106f50:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106f55:	e9 26 f4 ff ff       	jmp    80106380 <alltraps>

80106f5a <vector152>:
.globl vector152
vector152:
  pushl $0
80106f5a:	6a 00                	push   $0x0
  pushl $152
80106f5c:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106f61:	e9 1a f4 ff ff       	jmp    80106380 <alltraps>

80106f66 <vector153>:
.globl vector153
vector153:
  pushl $0
80106f66:	6a 00                	push   $0x0
  pushl $153
80106f68:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106f6d:	e9 0e f4 ff ff       	jmp    80106380 <alltraps>

80106f72 <vector154>:
.globl vector154
vector154:
  pushl $0
80106f72:	6a 00                	push   $0x0
  pushl $154
80106f74:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106f79:	e9 02 f4 ff ff       	jmp    80106380 <alltraps>

80106f7e <vector155>:
.globl vector155
vector155:
  pushl $0
80106f7e:	6a 00                	push   $0x0
  pushl $155
80106f80:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106f85:	e9 f6 f3 ff ff       	jmp    80106380 <alltraps>

80106f8a <vector156>:
.globl vector156
vector156:
  pushl $0
80106f8a:	6a 00                	push   $0x0
  pushl $156
80106f8c:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106f91:	e9 ea f3 ff ff       	jmp    80106380 <alltraps>

80106f96 <vector157>:
.globl vector157
vector157:
  pushl $0
80106f96:	6a 00                	push   $0x0
  pushl $157
80106f98:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106f9d:	e9 de f3 ff ff       	jmp    80106380 <alltraps>

80106fa2 <vector158>:
.globl vector158
vector158:
  pushl $0
80106fa2:	6a 00                	push   $0x0
  pushl $158
80106fa4:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106fa9:	e9 d2 f3 ff ff       	jmp    80106380 <alltraps>

80106fae <vector159>:
.globl vector159
vector159:
  pushl $0
80106fae:	6a 00                	push   $0x0
  pushl $159
80106fb0:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106fb5:	e9 c6 f3 ff ff       	jmp    80106380 <alltraps>

80106fba <vector160>:
.globl vector160
vector160:
  pushl $0
80106fba:	6a 00                	push   $0x0
  pushl $160
80106fbc:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106fc1:	e9 ba f3 ff ff       	jmp    80106380 <alltraps>

80106fc6 <vector161>:
.globl vector161
vector161:
  pushl $0
80106fc6:	6a 00                	push   $0x0
  pushl $161
80106fc8:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106fcd:	e9 ae f3 ff ff       	jmp    80106380 <alltraps>

80106fd2 <vector162>:
.globl vector162
vector162:
  pushl $0
80106fd2:	6a 00                	push   $0x0
  pushl $162
80106fd4:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106fd9:	e9 a2 f3 ff ff       	jmp    80106380 <alltraps>

80106fde <vector163>:
.globl vector163
vector163:
  pushl $0
80106fde:	6a 00                	push   $0x0
  pushl $163
80106fe0:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106fe5:	e9 96 f3 ff ff       	jmp    80106380 <alltraps>

80106fea <vector164>:
.globl vector164
vector164:
  pushl $0
80106fea:	6a 00                	push   $0x0
  pushl $164
80106fec:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106ff1:	e9 8a f3 ff ff       	jmp    80106380 <alltraps>

80106ff6 <vector165>:
.globl vector165
vector165:
  pushl $0
80106ff6:	6a 00                	push   $0x0
  pushl $165
80106ff8:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106ffd:	e9 7e f3 ff ff       	jmp    80106380 <alltraps>

80107002 <vector166>:
.globl vector166
vector166:
  pushl $0
80107002:	6a 00                	push   $0x0
  pushl $166
80107004:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107009:	e9 72 f3 ff ff       	jmp    80106380 <alltraps>

8010700e <vector167>:
.globl vector167
vector167:
  pushl $0
8010700e:	6a 00                	push   $0x0
  pushl $167
80107010:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107015:	e9 66 f3 ff ff       	jmp    80106380 <alltraps>

8010701a <vector168>:
.globl vector168
vector168:
  pushl $0
8010701a:	6a 00                	push   $0x0
  pushl $168
8010701c:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107021:	e9 5a f3 ff ff       	jmp    80106380 <alltraps>

80107026 <vector169>:
.globl vector169
vector169:
  pushl $0
80107026:	6a 00                	push   $0x0
  pushl $169
80107028:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010702d:	e9 4e f3 ff ff       	jmp    80106380 <alltraps>

80107032 <vector170>:
.globl vector170
vector170:
  pushl $0
80107032:	6a 00                	push   $0x0
  pushl $170
80107034:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107039:	e9 42 f3 ff ff       	jmp    80106380 <alltraps>

8010703e <vector171>:
.globl vector171
vector171:
  pushl $0
8010703e:	6a 00                	push   $0x0
  pushl $171
80107040:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107045:	e9 36 f3 ff ff       	jmp    80106380 <alltraps>

8010704a <vector172>:
.globl vector172
vector172:
  pushl $0
8010704a:	6a 00                	push   $0x0
  pushl $172
8010704c:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107051:	e9 2a f3 ff ff       	jmp    80106380 <alltraps>

80107056 <vector173>:
.globl vector173
vector173:
  pushl $0
80107056:	6a 00                	push   $0x0
  pushl $173
80107058:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010705d:	e9 1e f3 ff ff       	jmp    80106380 <alltraps>

80107062 <vector174>:
.globl vector174
vector174:
  pushl $0
80107062:	6a 00                	push   $0x0
  pushl $174
80107064:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107069:	e9 12 f3 ff ff       	jmp    80106380 <alltraps>

8010706e <vector175>:
.globl vector175
vector175:
  pushl $0
8010706e:	6a 00                	push   $0x0
  pushl $175
80107070:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107075:	e9 06 f3 ff ff       	jmp    80106380 <alltraps>

8010707a <vector176>:
.globl vector176
vector176:
  pushl $0
8010707a:	6a 00                	push   $0x0
  pushl $176
8010707c:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107081:	e9 fa f2 ff ff       	jmp    80106380 <alltraps>

80107086 <vector177>:
.globl vector177
vector177:
  pushl $0
80107086:	6a 00                	push   $0x0
  pushl $177
80107088:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010708d:	e9 ee f2 ff ff       	jmp    80106380 <alltraps>

80107092 <vector178>:
.globl vector178
vector178:
  pushl $0
80107092:	6a 00                	push   $0x0
  pushl $178
80107094:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107099:	e9 e2 f2 ff ff       	jmp    80106380 <alltraps>

8010709e <vector179>:
.globl vector179
vector179:
  pushl $0
8010709e:	6a 00                	push   $0x0
  pushl $179
801070a0:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801070a5:	e9 d6 f2 ff ff       	jmp    80106380 <alltraps>

801070aa <vector180>:
.globl vector180
vector180:
  pushl $0
801070aa:	6a 00                	push   $0x0
  pushl $180
801070ac:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801070b1:	e9 ca f2 ff ff       	jmp    80106380 <alltraps>

801070b6 <vector181>:
.globl vector181
vector181:
  pushl $0
801070b6:	6a 00                	push   $0x0
  pushl $181
801070b8:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801070bd:	e9 be f2 ff ff       	jmp    80106380 <alltraps>

801070c2 <vector182>:
.globl vector182
vector182:
  pushl $0
801070c2:	6a 00                	push   $0x0
  pushl $182
801070c4:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801070c9:	e9 b2 f2 ff ff       	jmp    80106380 <alltraps>

801070ce <vector183>:
.globl vector183
vector183:
  pushl $0
801070ce:	6a 00                	push   $0x0
  pushl $183
801070d0:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801070d5:	e9 a6 f2 ff ff       	jmp    80106380 <alltraps>

801070da <vector184>:
.globl vector184
vector184:
  pushl $0
801070da:	6a 00                	push   $0x0
  pushl $184
801070dc:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801070e1:	e9 9a f2 ff ff       	jmp    80106380 <alltraps>

801070e6 <vector185>:
.globl vector185
vector185:
  pushl $0
801070e6:	6a 00                	push   $0x0
  pushl $185
801070e8:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801070ed:	e9 8e f2 ff ff       	jmp    80106380 <alltraps>

801070f2 <vector186>:
.globl vector186
vector186:
  pushl $0
801070f2:	6a 00                	push   $0x0
  pushl $186
801070f4:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801070f9:	e9 82 f2 ff ff       	jmp    80106380 <alltraps>

801070fe <vector187>:
.globl vector187
vector187:
  pushl $0
801070fe:	6a 00                	push   $0x0
  pushl $187
80107100:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107105:	e9 76 f2 ff ff       	jmp    80106380 <alltraps>

8010710a <vector188>:
.globl vector188
vector188:
  pushl $0
8010710a:	6a 00                	push   $0x0
  pushl $188
8010710c:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107111:	e9 6a f2 ff ff       	jmp    80106380 <alltraps>

80107116 <vector189>:
.globl vector189
vector189:
  pushl $0
80107116:	6a 00                	push   $0x0
  pushl $189
80107118:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010711d:	e9 5e f2 ff ff       	jmp    80106380 <alltraps>

80107122 <vector190>:
.globl vector190
vector190:
  pushl $0
80107122:	6a 00                	push   $0x0
  pushl $190
80107124:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107129:	e9 52 f2 ff ff       	jmp    80106380 <alltraps>

8010712e <vector191>:
.globl vector191
vector191:
  pushl $0
8010712e:	6a 00                	push   $0x0
  pushl $191
80107130:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107135:	e9 46 f2 ff ff       	jmp    80106380 <alltraps>

8010713a <vector192>:
.globl vector192
vector192:
  pushl $0
8010713a:	6a 00                	push   $0x0
  pushl $192
8010713c:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107141:	e9 3a f2 ff ff       	jmp    80106380 <alltraps>

80107146 <vector193>:
.globl vector193
vector193:
  pushl $0
80107146:	6a 00                	push   $0x0
  pushl $193
80107148:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010714d:	e9 2e f2 ff ff       	jmp    80106380 <alltraps>

80107152 <vector194>:
.globl vector194
vector194:
  pushl $0
80107152:	6a 00                	push   $0x0
  pushl $194
80107154:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107159:	e9 22 f2 ff ff       	jmp    80106380 <alltraps>

8010715e <vector195>:
.globl vector195
vector195:
  pushl $0
8010715e:	6a 00                	push   $0x0
  pushl $195
80107160:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107165:	e9 16 f2 ff ff       	jmp    80106380 <alltraps>

8010716a <vector196>:
.globl vector196
vector196:
  pushl $0
8010716a:	6a 00                	push   $0x0
  pushl $196
8010716c:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107171:	e9 0a f2 ff ff       	jmp    80106380 <alltraps>

80107176 <vector197>:
.globl vector197
vector197:
  pushl $0
80107176:	6a 00                	push   $0x0
  pushl $197
80107178:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010717d:	e9 fe f1 ff ff       	jmp    80106380 <alltraps>

80107182 <vector198>:
.globl vector198
vector198:
  pushl $0
80107182:	6a 00                	push   $0x0
  pushl $198
80107184:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107189:	e9 f2 f1 ff ff       	jmp    80106380 <alltraps>

8010718e <vector199>:
.globl vector199
vector199:
  pushl $0
8010718e:	6a 00                	push   $0x0
  pushl $199
80107190:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107195:	e9 e6 f1 ff ff       	jmp    80106380 <alltraps>

8010719a <vector200>:
.globl vector200
vector200:
  pushl $0
8010719a:	6a 00                	push   $0x0
  pushl $200
8010719c:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801071a1:	e9 da f1 ff ff       	jmp    80106380 <alltraps>

801071a6 <vector201>:
.globl vector201
vector201:
  pushl $0
801071a6:	6a 00                	push   $0x0
  pushl $201
801071a8:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801071ad:	e9 ce f1 ff ff       	jmp    80106380 <alltraps>

801071b2 <vector202>:
.globl vector202
vector202:
  pushl $0
801071b2:	6a 00                	push   $0x0
  pushl $202
801071b4:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801071b9:	e9 c2 f1 ff ff       	jmp    80106380 <alltraps>

801071be <vector203>:
.globl vector203
vector203:
  pushl $0
801071be:	6a 00                	push   $0x0
  pushl $203
801071c0:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801071c5:	e9 b6 f1 ff ff       	jmp    80106380 <alltraps>

801071ca <vector204>:
.globl vector204
vector204:
  pushl $0
801071ca:	6a 00                	push   $0x0
  pushl $204
801071cc:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801071d1:	e9 aa f1 ff ff       	jmp    80106380 <alltraps>

801071d6 <vector205>:
.globl vector205
vector205:
  pushl $0
801071d6:	6a 00                	push   $0x0
  pushl $205
801071d8:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801071dd:	e9 9e f1 ff ff       	jmp    80106380 <alltraps>

801071e2 <vector206>:
.globl vector206
vector206:
  pushl $0
801071e2:	6a 00                	push   $0x0
  pushl $206
801071e4:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801071e9:	e9 92 f1 ff ff       	jmp    80106380 <alltraps>

801071ee <vector207>:
.globl vector207
vector207:
  pushl $0
801071ee:	6a 00                	push   $0x0
  pushl $207
801071f0:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801071f5:	e9 86 f1 ff ff       	jmp    80106380 <alltraps>

801071fa <vector208>:
.globl vector208
vector208:
  pushl $0
801071fa:	6a 00                	push   $0x0
  pushl $208
801071fc:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107201:	e9 7a f1 ff ff       	jmp    80106380 <alltraps>

80107206 <vector209>:
.globl vector209
vector209:
  pushl $0
80107206:	6a 00                	push   $0x0
  pushl $209
80107208:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010720d:	e9 6e f1 ff ff       	jmp    80106380 <alltraps>

80107212 <vector210>:
.globl vector210
vector210:
  pushl $0
80107212:	6a 00                	push   $0x0
  pushl $210
80107214:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107219:	e9 62 f1 ff ff       	jmp    80106380 <alltraps>

8010721e <vector211>:
.globl vector211
vector211:
  pushl $0
8010721e:	6a 00                	push   $0x0
  pushl $211
80107220:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107225:	e9 56 f1 ff ff       	jmp    80106380 <alltraps>

8010722a <vector212>:
.globl vector212
vector212:
  pushl $0
8010722a:	6a 00                	push   $0x0
  pushl $212
8010722c:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107231:	e9 4a f1 ff ff       	jmp    80106380 <alltraps>

80107236 <vector213>:
.globl vector213
vector213:
  pushl $0
80107236:	6a 00                	push   $0x0
  pushl $213
80107238:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010723d:	e9 3e f1 ff ff       	jmp    80106380 <alltraps>

80107242 <vector214>:
.globl vector214
vector214:
  pushl $0
80107242:	6a 00                	push   $0x0
  pushl $214
80107244:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107249:	e9 32 f1 ff ff       	jmp    80106380 <alltraps>

8010724e <vector215>:
.globl vector215
vector215:
  pushl $0
8010724e:	6a 00                	push   $0x0
  pushl $215
80107250:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107255:	e9 26 f1 ff ff       	jmp    80106380 <alltraps>

8010725a <vector216>:
.globl vector216
vector216:
  pushl $0
8010725a:	6a 00                	push   $0x0
  pushl $216
8010725c:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107261:	e9 1a f1 ff ff       	jmp    80106380 <alltraps>

80107266 <vector217>:
.globl vector217
vector217:
  pushl $0
80107266:	6a 00                	push   $0x0
  pushl $217
80107268:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010726d:	e9 0e f1 ff ff       	jmp    80106380 <alltraps>

80107272 <vector218>:
.globl vector218
vector218:
  pushl $0
80107272:	6a 00                	push   $0x0
  pushl $218
80107274:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107279:	e9 02 f1 ff ff       	jmp    80106380 <alltraps>

8010727e <vector219>:
.globl vector219
vector219:
  pushl $0
8010727e:	6a 00                	push   $0x0
  pushl $219
80107280:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107285:	e9 f6 f0 ff ff       	jmp    80106380 <alltraps>

8010728a <vector220>:
.globl vector220
vector220:
  pushl $0
8010728a:	6a 00                	push   $0x0
  pushl $220
8010728c:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107291:	e9 ea f0 ff ff       	jmp    80106380 <alltraps>

80107296 <vector221>:
.globl vector221
vector221:
  pushl $0
80107296:	6a 00                	push   $0x0
  pushl $221
80107298:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010729d:	e9 de f0 ff ff       	jmp    80106380 <alltraps>

801072a2 <vector222>:
.globl vector222
vector222:
  pushl $0
801072a2:	6a 00                	push   $0x0
  pushl $222
801072a4:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801072a9:	e9 d2 f0 ff ff       	jmp    80106380 <alltraps>

801072ae <vector223>:
.globl vector223
vector223:
  pushl $0
801072ae:	6a 00                	push   $0x0
  pushl $223
801072b0:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801072b5:	e9 c6 f0 ff ff       	jmp    80106380 <alltraps>

801072ba <vector224>:
.globl vector224
vector224:
  pushl $0
801072ba:	6a 00                	push   $0x0
  pushl $224
801072bc:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801072c1:	e9 ba f0 ff ff       	jmp    80106380 <alltraps>

801072c6 <vector225>:
.globl vector225
vector225:
  pushl $0
801072c6:	6a 00                	push   $0x0
  pushl $225
801072c8:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801072cd:	e9 ae f0 ff ff       	jmp    80106380 <alltraps>

801072d2 <vector226>:
.globl vector226
vector226:
  pushl $0
801072d2:	6a 00                	push   $0x0
  pushl $226
801072d4:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801072d9:	e9 a2 f0 ff ff       	jmp    80106380 <alltraps>

801072de <vector227>:
.globl vector227
vector227:
  pushl $0
801072de:	6a 00                	push   $0x0
  pushl $227
801072e0:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801072e5:	e9 96 f0 ff ff       	jmp    80106380 <alltraps>

801072ea <vector228>:
.globl vector228
vector228:
  pushl $0
801072ea:	6a 00                	push   $0x0
  pushl $228
801072ec:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801072f1:	e9 8a f0 ff ff       	jmp    80106380 <alltraps>

801072f6 <vector229>:
.globl vector229
vector229:
  pushl $0
801072f6:	6a 00                	push   $0x0
  pushl $229
801072f8:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801072fd:	e9 7e f0 ff ff       	jmp    80106380 <alltraps>

80107302 <vector230>:
.globl vector230
vector230:
  pushl $0
80107302:	6a 00                	push   $0x0
  pushl $230
80107304:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107309:	e9 72 f0 ff ff       	jmp    80106380 <alltraps>

8010730e <vector231>:
.globl vector231
vector231:
  pushl $0
8010730e:	6a 00                	push   $0x0
  pushl $231
80107310:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107315:	e9 66 f0 ff ff       	jmp    80106380 <alltraps>

8010731a <vector232>:
.globl vector232
vector232:
  pushl $0
8010731a:	6a 00                	push   $0x0
  pushl $232
8010731c:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107321:	e9 5a f0 ff ff       	jmp    80106380 <alltraps>

80107326 <vector233>:
.globl vector233
vector233:
  pushl $0
80107326:	6a 00                	push   $0x0
  pushl $233
80107328:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010732d:	e9 4e f0 ff ff       	jmp    80106380 <alltraps>

80107332 <vector234>:
.globl vector234
vector234:
  pushl $0
80107332:	6a 00                	push   $0x0
  pushl $234
80107334:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107339:	e9 42 f0 ff ff       	jmp    80106380 <alltraps>

8010733e <vector235>:
.globl vector235
vector235:
  pushl $0
8010733e:	6a 00                	push   $0x0
  pushl $235
80107340:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107345:	e9 36 f0 ff ff       	jmp    80106380 <alltraps>

8010734a <vector236>:
.globl vector236
vector236:
  pushl $0
8010734a:	6a 00                	push   $0x0
  pushl $236
8010734c:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107351:	e9 2a f0 ff ff       	jmp    80106380 <alltraps>

80107356 <vector237>:
.globl vector237
vector237:
  pushl $0
80107356:	6a 00                	push   $0x0
  pushl $237
80107358:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010735d:	e9 1e f0 ff ff       	jmp    80106380 <alltraps>

80107362 <vector238>:
.globl vector238
vector238:
  pushl $0
80107362:	6a 00                	push   $0x0
  pushl $238
80107364:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107369:	e9 12 f0 ff ff       	jmp    80106380 <alltraps>

8010736e <vector239>:
.globl vector239
vector239:
  pushl $0
8010736e:	6a 00                	push   $0x0
  pushl $239
80107370:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107375:	e9 06 f0 ff ff       	jmp    80106380 <alltraps>

8010737a <vector240>:
.globl vector240
vector240:
  pushl $0
8010737a:	6a 00                	push   $0x0
  pushl $240
8010737c:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107381:	e9 fa ef ff ff       	jmp    80106380 <alltraps>

80107386 <vector241>:
.globl vector241
vector241:
  pushl $0
80107386:	6a 00                	push   $0x0
  pushl $241
80107388:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010738d:	e9 ee ef ff ff       	jmp    80106380 <alltraps>

80107392 <vector242>:
.globl vector242
vector242:
  pushl $0
80107392:	6a 00                	push   $0x0
  pushl $242
80107394:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107399:	e9 e2 ef ff ff       	jmp    80106380 <alltraps>

8010739e <vector243>:
.globl vector243
vector243:
  pushl $0
8010739e:	6a 00                	push   $0x0
  pushl $243
801073a0:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801073a5:	e9 d6 ef ff ff       	jmp    80106380 <alltraps>

801073aa <vector244>:
.globl vector244
vector244:
  pushl $0
801073aa:	6a 00                	push   $0x0
  pushl $244
801073ac:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801073b1:	e9 ca ef ff ff       	jmp    80106380 <alltraps>

801073b6 <vector245>:
.globl vector245
vector245:
  pushl $0
801073b6:	6a 00                	push   $0x0
  pushl $245
801073b8:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801073bd:	e9 be ef ff ff       	jmp    80106380 <alltraps>

801073c2 <vector246>:
.globl vector246
vector246:
  pushl $0
801073c2:	6a 00                	push   $0x0
  pushl $246
801073c4:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801073c9:	e9 b2 ef ff ff       	jmp    80106380 <alltraps>

801073ce <vector247>:
.globl vector247
vector247:
  pushl $0
801073ce:	6a 00                	push   $0x0
  pushl $247
801073d0:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801073d5:	e9 a6 ef ff ff       	jmp    80106380 <alltraps>

801073da <vector248>:
.globl vector248
vector248:
  pushl $0
801073da:	6a 00                	push   $0x0
  pushl $248
801073dc:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801073e1:	e9 9a ef ff ff       	jmp    80106380 <alltraps>

801073e6 <vector249>:
.globl vector249
vector249:
  pushl $0
801073e6:	6a 00                	push   $0x0
  pushl $249
801073e8:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801073ed:	e9 8e ef ff ff       	jmp    80106380 <alltraps>

801073f2 <vector250>:
.globl vector250
vector250:
  pushl $0
801073f2:	6a 00                	push   $0x0
  pushl $250
801073f4:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801073f9:	e9 82 ef ff ff       	jmp    80106380 <alltraps>

801073fe <vector251>:
.globl vector251
vector251:
  pushl $0
801073fe:	6a 00                	push   $0x0
  pushl $251
80107400:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107405:	e9 76 ef ff ff       	jmp    80106380 <alltraps>

8010740a <vector252>:
.globl vector252
vector252:
  pushl $0
8010740a:	6a 00                	push   $0x0
  pushl $252
8010740c:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107411:	e9 6a ef ff ff       	jmp    80106380 <alltraps>

80107416 <vector253>:
.globl vector253
vector253:
  pushl $0
80107416:	6a 00                	push   $0x0
  pushl $253
80107418:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010741d:	e9 5e ef ff ff       	jmp    80106380 <alltraps>

80107422 <vector254>:
.globl vector254
vector254:
  pushl $0
80107422:	6a 00                	push   $0x0
  pushl $254
80107424:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107429:	e9 52 ef ff ff       	jmp    80106380 <alltraps>

8010742e <vector255>:
.globl vector255
vector255:
  pushl $0
8010742e:	6a 00                	push   $0x0
  pushl $255
80107430:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107435:	e9 46 ef ff ff       	jmp    80106380 <alltraps>

8010743a <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
8010743a:	55                   	push   %ebp
8010743b:	89 e5                	mov    %esp,%ebp
8010743d:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80107440:	8b 45 0c             	mov    0xc(%ebp),%eax
80107443:	83 e8 01             	sub    $0x1,%eax
80107446:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010744a:	8b 45 08             	mov    0x8(%ebp),%eax
8010744d:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80107451:	8b 45 08             	mov    0x8(%ebp),%eax
80107454:	c1 e8 10             	shr    $0x10,%eax
80107457:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
8010745b:	8d 45 fa             	lea    -0x6(%ebp),%eax
8010745e:	0f 01 10             	lgdtl  (%eax)
}
80107461:	c9                   	leave  
80107462:	c3                   	ret    

80107463 <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
80107463:	55                   	push   %ebp
80107464:	89 e5                	mov    %esp,%ebp
80107466:	83 ec 04             	sub    $0x4,%esp
80107469:	8b 45 08             	mov    0x8(%ebp),%eax
8010746c:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
80107470:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107474:	0f 00 d8             	ltr    %ax
}
80107477:	c9                   	leave  
80107478:	c3                   	ret    

80107479 <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
80107479:	55                   	push   %ebp
8010747a:	89 e5                	mov    %esp,%ebp
8010747c:	83 ec 04             	sub    $0x4,%esp
8010747f:	8b 45 08             	mov    0x8(%ebp),%eax
80107482:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
80107486:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010748a:	8e e8                	mov    %eax,%gs
}
8010748c:	c9                   	leave  
8010748d:	c3                   	ret    

8010748e <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
8010748e:	55                   	push   %ebp
8010748f:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107491:	8b 45 08             	mov    0x8(%ebp),%eax
80107494:	0f 22 d8             	mov    %eax,%cr3
}
80107497:	5d                   	pop    %ebp
80107498:	c3                   	ret    

80107499 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80107499:	55                   	push   %ebp
8010749a:	89 e5                	mov    %esp,%ebp
8010749c:	8b 45 08             	mov    0x8(%ebp),%eax
8010749f:	05 00 00 00 80       	add    $0x80000000,%eax
801074a4:	5d                   	pop    %ebp
801074a5:	c3                   	ret    

801074a6 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801074a6:	55                   	push   %ebp
801074a7:	89 e5                	mov    %esp,%ebp
801074a9:	8b 45 08             	mov    0x8(%ebp),%eax
801074ac:	05 00 00 00 80       	add    $0x80000000,%eax
801074b1:	5d                   	pop    %ebp
801074b2:	c3                   	ret    

801074b3 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801074b3:	55                   	push   %ebp
801074b4:	89 e5                	mov    %esp,%ebp
801074b6:	53                   	push   %ebx
801074b7:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
801074ba:	e8 02 ba ff ff       	call   80102ec1 <cpunum>
801074bf:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801074c5:	05 c0 f9 10 80       	add    $0x8010f9c0,%eax
801074ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801074cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074d0:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801074d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074d9:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801074df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074e2:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801074e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074e9:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801074ed:	83 e2 f0             	and    $0xfffffff0,%edx
801074f0:	83 ca 0a             	or     $0xa,%edx
801074f3:	88 50 7d             	mov    %dl,0x7d(%eax)
801074f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074f9:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801074fd:	83 ca 10             	or     $0x10,%edx
80107500:	88 50 7d             	mov    %dl,0x7d(%eax)
80107503:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107506:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010750a:	83 e2 9f             	and    $0xffffff9f,%edx
8010750d:	88 50 7d             	mov    %dl,0x7d(%eax)
80107510:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107513:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107517:	83 ca 80             	or     $0xffffff80,%edx
8010751a:	88 50 7d             	mov    %dl,0x7d(%eax)
8010751d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107520:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107524:	83 ca 0f             	or     $0xf,%edx
80107527:	88 50 7e             	mov    %dl,0x7e(%eax)
8010752a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010752d:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107531:	83 e2 ef             	and    $0xffffffef,%edx
80107534:	88 50 7e             	mov    %dl,0x7e(%eax)
80107537:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010753a:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010753e:	83 e2 df             	and    $0xffffffdf,%edx
80107541:	88 50 7e             	mov    %dl,0x7e(%eax)
80107544:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107547:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010754b:	83 ca 40             	or     $0x40,%edx
8010754e:	88 50 7e             	mov    %dl,0x7e(%eax)
80107551:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107554:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107558:	83 ca 80             	or     $0xffffff80,%edx
8010755b:	88 50 7e             	mov    %dl,0x7e(%eax)
8010755e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107561:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107565:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107568:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
8010756f:	ff ff 
80107571:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107574:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
8010757b:	00 00 
8010757d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107580:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107587:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010758a:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107591:	83 e2 f0             	and    $0xfffffff0,%edx
80107594:	83 ca 02             	or     $0x2,%edx
80107597:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010759d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075a0:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801075a7:	83 ca 10             	or     $0x10,%edx
801075aa:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801075b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075b3:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801075ba:	83 e2 9f             	and    $0xffffff9f,%edx
801075bd:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801075c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075c6:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801075cd:	83 ca 80             	or     $0xffffff80,%edx
801075d0:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801075d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075d9:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801075e0:	83 ca 0f             	or     $0xf,%edx
801075e3:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801075e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075ec:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801075f3:	83 e2 ef             	and    $0xffffffef,%edx
801075f6:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801075fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075ff:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107606:	83 e2 df             	and    $0xffffffdf,%edx
80107609:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010760f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107612:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107619:	83 ca 40             	or     $0x40,%edx
8010761c:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107622:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107625:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010762c:	83 ca 80             	or     $0xffffff80,%edx
8010762f:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107635:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107638:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010763f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107642:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107649:	ff ff 
8010764b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010764e:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107655:	00 00 
80107657:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010765a:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107661:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107664:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
8010766b:	83 e2 f0             	and    $0xfffffff0,%edx
8010766e:	83 ca 0a             	or     $0xa,%edx
80107671:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107677:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010767a:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107681:	83 ca 10             	or     $0x10,%edx
80107684:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010768a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010768d:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107694:	83 ca 60             	or     $0x60,%edx
80107697:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010769d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076a0:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801076a7:	83 ca 80             	or     $0xffffff80,%edx
801076aa:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801076b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076b3:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801076ba:	83 ca 0f             	or     $0xf,%edx
801076bd:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801076c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076c6:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801076cd:	83 e2 ef             	and    $0xffffffef,%edx
801076d0:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801076d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076d9:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801076e0:	83 e2 df             	and    $0xffffffdf,%edx
801076e3:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801076e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076ec:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801076f3:	83 ca 40             	or     $0x40,%edx
801076f6:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801076fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076ff:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107706:	83 ca 80             	or     $0xffffff80,%edx
80107709:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
8010770f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107712:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107719:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010771c:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107723:	ff ff 
80107725:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107728:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
8010772f:	00 00 
80107731:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107734:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
8010773b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010773e:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107745:	83 e2 f0             	and    $0xfffffff0,%edx
80107748:	83 ca 02             	or     $0x2,%edx
8010774b:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107751:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107754:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010775b:	83 ca 10             	or     $0x10,%edx
8010775e:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107764:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107767:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010776e:	83 ca 60             	or     $0x60,%edx
80107771:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107777:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010777a:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107781:	83 ca 80             	or     $0xffffff80,%edx
80107784:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
8010778a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010778d:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107794:	83 ca 0f             	or     $0xf,%edx
80107797:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010779d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077a0:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801077a7:	83 e2 ef             	and    $0xffffffef,%edx
801077aa:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801077b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077b3:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801077ba:	83 e2 df             	and    $0xffffffdf,%edx
801077bd:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801077c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077c6:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801077cd:	83 ca 40             	or     $0x40,%edx
801077d0:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801077d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077d9:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801077e0:	83 ca 80             	or     $0xffffff80,%edx
801077e3:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801077e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077ec:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801077f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077f6:	05 b4 00 00 00       	add    $0xb4,%eax
801077fb:	89 c3                	mov    %eax,%ebx
801077fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107800:	05 b4 00 00 00       	add    $0xb4,%eax
80107805:	c1 e8 10             	shr    $0x10,%eax
80107808:	89 c2                	mov    %eax,%edx
8010780a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010780d:	05 b4 00 00 00       	add    $0xb4,%eax
80107812:	c1 e8 18             	shr    $0x18,%eax
80107815:	89 c1                	mov    %eax,%ecx
80107817:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010781a:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107821:	00 00 
80107823:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107826:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
8010782d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107830:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80107836:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107839:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107840:	83 e2 f0             	and    $0xfffffff0,%edx
80107843:	83 ca 02             	or     $0x2,%edx
80107846:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
8010784c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010784f:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107856:	83 ca 10             	or     $0x10,%edx
80107859:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
8010785f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107862:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107869:	83 e2 9f             	and    $0xffffff9f,%edx
8010786c:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107872:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107875:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010787c:	83 ca 80             	or     $0xffffff80,%edx
8010787f:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107885:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107888:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
8010788f:	83 e2 f0             	and    $0xfffffff0,%edx
80107892:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107898:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010789b:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801078a2:	83 e2 ef             	and    $0xffffffef,%edx
801078a5:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801078ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078ae:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801078b5:	83 e2 df             	and    $0xffffffdf,%edx
801078b8:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801078be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078c1:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801078c8:	83 ca 40             	or     $0x40,%edx
801078cb:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801078d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078d4:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801078db:	83 ca 80             	or     $0xffffff80,%edx
801078de:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801078e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078e7:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
801078ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078f0:	83 c0 70             	add    $0x70,%eax
801078f3:	83 ec 08             	sub    $0x8,%esp
801078f6:	6a 38                	push   $0x38
801078f8:	50                   	push   %eax
801078f9:	e8 3c fb ff ff       	call   8010743a <lgdt>
801078fe:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
80107901:	83 ec 0c             	sub    $0xc,%esp
80107904:	6a 18                	push   $0x18
80107906:	e8 6e fb ff ff       	call   80107479 <loadgs>
8010790b:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
8010790e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107911:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80107917:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
8010791e:	00 00 00 00 
}
80107922:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107925:	c9                   	leave  
80107926:	c3                   	ret    

80107927 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107927:	55                   	push   %ebp
80107928:	89 e5                	mov    %esp,%ebp
8010792a:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
8010792d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107930:	c1 e8 16             	shr    $0x16,%eax
80107933:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010793a:	8b 45 08             	mov    0x8(%ebp),%eax
8010793d:	01 d0                	add    %edx,%eax
8010793f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107942:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107945:	8b 00                	mov    (%eax),%eax
80107947:	83 e0 01             	and    $0x1,%eax
8010794a:	85 c0                	test   %eax,%eax
8010794c:	74 18                	je     80107966 <walkpgdir+0x3f>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
8010794e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107951:	8b 00                	mov    (%eax),%eax
80107953:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107958:	50                   	push   %eax
80107959:	e8 48 fb ff ff       	call   801074a6 <p2v>
8010795e:	83 c4 04             	add    $0x4,%esp
80107961:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107964:	eb 48                	jmp    801079ae <walkpgdir+0x87>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107966:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010796a:	74 0e                	je     8010797a <walkpgdir+0x53>
8010796c:	e8 0c b2 ff ff       	call   80102b7d <kalloc>
80107971:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107974:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107978:	75 07                	jne    80107981 <walkpgdir+0x5a>
      return 0;
8010797a:	b8 00 00 00 00       	mov    $0x0,%eax
8010797f:	eb 44                	jmp    801079c5 <walkpgdir+0x9e>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107981:	83 ec 04             	sub    $0x4,%esp
80107984:	68 00 10 00 00       	push   $0x1000
80107989:	6a 00                	push   $0x0
8010798b:	ff 75 f4             	pushl  -0xc(%ebp)
8010798e:	e8 33 d4 ff ff       	call   80104dc6 <memset>
80107993:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107996:	83 ec 0c             	sub    $0xc,%esp
80107999:	ff 75 f4             	pushl  -0xc(%ebp)
8010799c:	e8 f8 fa ff ff       	call   80107499 <v2p>
801079a1:	83 c4 10             	add    $0x10,%esp
801079a4:	83 c8 07             	or     $0x7,%eax
801079a7:	89 c2                	mov    %eax,%edx
801079a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801079ac:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
801079ae:	8b 45 0c             	mov    0xc(%ebp),%eax
801079b1:	c1 e8 0c             	shr    $0xc,%eax
801079b4:	25 ff 03 00 00       	and    $0x3ff,%eax
801079b9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801079c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079c3:	01 d0                	add    %edx,%eax
}
801079c5:	c9                   	leave  
801079c6:	c3                   	ret    

801079c7 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801079c7:	55                   	push   %ebp
801079c8:	89 e5                	mov    %esp,%ebp
801079ca:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
801079cd:	8b 45 0c             	mov    0xc(%ebp),%eax
801079d0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801079d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801079d8:	8b 55 0c             	mov    0xc(%ebp),%edx
801079db:	8b 45 10             	mov    0x10(%ebp),%eax
801079de:	01 d0                	add    %edx,%eax
801079e0:	83 e8 01             	sub    $0x1,%eax
801079e3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801079e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801079eb:	83 ec 04             	sub    $0x4,%esp
801079ee:	6a 01                	push   $0x1
801079f0:	ff 75 f4             	pushl  -0xc(%ebp)
801079f3:	ff 75 08             	pushl  0x8(%ebp)
801079f6:	e8 2c ff ff ff       	call   80107927 <walkpgdir>
801079fb:	83 c4 10             	add    $0x10,%esp
801079fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107a01:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107a05:	75 07                	jne    80107a0e <mappages+0x47>
      return -1;
80107a07:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107a0c:	eb 49                	jmp    80107a57 <mappages+0x90>
    if(*pte & PTE_P)
80107a0e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107a11:	8b 00                	mov    (%eax),%eax
80107a13:	83 e0 01             	and    $0x1,%eax
80107a16:	85 c0                	test   %eax,%eax
80107a18:	74 0d                	je     80107a27 <mappages+0x60>
      panic("remap");
80107a1a:	83 ec 0c             	sub    $0xc,%esp
80107a1d:	68 54 88 10 80       	push   $0x80108854
80107a22:	e8 35 8b ff ff       	call   8010055c <panic>
    *pte = pa | perm | PTE_P;
80107a27:	8b 45 18             	mov    0x18(%ebp),%eax
80107a2a:	0b 45 14             	or     0x14(%ebp),%eax
80107a2d:	83 c8 01             	or     $0x1,%eax
80107a30:	89 c2                	mov    %eax,%edx
80107a32:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107a35:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107a37:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a3a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107a3d:	75 08                	jne    80107a47 <mappages+0x80>
      break;
80107a3f:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107a40:	b8 00 00 00 00       	mov    $0x0,%eax
80107a45:	eb 10                	jmp    80107a57 <mappages+0x90>
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
80107a47:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107a4e:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80107a55:	eb 94                	jmp    801079eb <mappages+0x24>
  return 0;
}
80107a57:	c9                   	leave  
80107a58:	c3                   	ret    

80107a59 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107a59:	55                   	push   %ebp
80107a5a:	89 e5                	mov    %esp,%ebp
80107a5c:	53                   	push   %ebx
80107a5d:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107a60:	e8 18 b1 ff ff       	call   80102b7d <kalloc>
80107a65:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107a68:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107a6c:	75 0a                	jne    80107a78 <setupkvm+0x1f>
    return 0;
80107a6e:	b8 00 00 00 00       	mov    $0x0,%eax
80107a73:	e9 8e 00 00 00       	jmp    80107b06 <setupkvm+0xad>
  memset(pgdir, 0, PGSIZE);
80107a78:	83 ec 04             	sub    $0x4,%esp
80107a7b:	68 00 10 00 00       	push   $0x1000
80107a80:	6a 00                	push   $0x0
80107a82:	ff 75 f0             	pushl  -0x10(%ebp)
80107a85:	e8 3c d3 ff ff       	call   80104dc6 <memset>
80107a8a:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107a8d:	83 ec 0c             	sub    $0xc,%esp
80107a90:	68 00 00 00 0e       	push   $0xe000000
80107a95:	e8 0c fa ff ff       	call   801074a6 <p2v>
80107a9a:	83 c4 10             	add    $0x10,%esp
80107a9d:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80107aa2:	76 0d                	jbe    80107ab1 <setupkvm+0x58>
    panic("PHYSTOP too high");
80107aa4:	83 ec 0c             	sub    $0xc,%esp
80107aa7:	68 5a 88 10 80       	push   $0x8010885a
80107aac:	e8 ab 8a ff ff       	call   8010055c <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107ab1:	c7 45 f4 c0 b4 10 80 	movl   $0x8010b4c0,-0xc(%ebp)
80107ab8:	eb 40                	jmp    80107afa <setupkvm+0xa1>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107aba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107abd:	8b 48 0c             	mov    0xc(%eax),%ecx
80107ac0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ac3:	8b 50 04             	mov    0x4(%eax),%edx
80107ac6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ac9:	8b 58 08             	mov    0x8(%eax),%ebx
80107acc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107acf:	8b 40 04             	mov    0x4(%eax),%eax
80107ad2:	29 c3                	sub    %eax,%ebx
80107ad4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ad7:	8b 00                	mov    (%eax),%eax
80107ad9:	83 ec 0c             	sub    $0xc,%esp
80107adc:	51                   	push   %ecx
80107add:	52                   	push   %edx
80107ade:	53                   	push   %ebx
80107adf:	50                   	push   %eax
80107ae0:	ff 75 f0             	pushl  -0x10(%ebp)
80107ae3:	e8 df fe ff ff       	call   801079c7 <mappages>
80107ae8:	83 c4 20             	add    $0x20,%esp
80107aeb:	85 c0                	test   %eax,%eax
80107aed:	79 07                	jns    80107af6 <setupkvm+0x9d>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80107aef:	b8 00 00 00 00       	mov    $0x0,%eax
80107af4:	eb 10                	jmp    80107b06 <setupkvm+0xad>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107af6:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107afa:	81 7d f4 00 b5 10 80 	cmpl   $0x8010b500,-0xc(%ebp)
80107b01:	72 b7                	jb     80107aba <setupkvm+0x61>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80107b03:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107b06:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107b09:	c9                   	leave  
80107b0a:	c3                   	ret    

80107b0b <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107b0b:	55                   	push   %ebp
80107b0c:	89 e5                	mov    %esp,%ebp
80107b0e:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107b11:	e8 43 ff ff ff       	call   80107a59 <setupkvm>
80107b16:	a3 98 27 11 80       	mov    %eax,0x80112798
  switchkvm();
80107b1b:	e8 02 00 00 00       	call   80107b22 <switchkvm>
}
80107b20:	c9                   	leave  
80107b21:	c3                   	ret    

80107b22 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107b22:	55                   	push   %ebp
80107b23:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107b25:	a1 98 27 11 80       	mov    0x80112798,%eax
80107b2a:	50                   	push   %eax
80107b2b:	e8 69 f9 ff ff       	call   80107499 <v2p>
80107b30:	83 c4 04             	add    $0x4,%esp
80107b33:	50                   	push   %eax
80107b34:	e8 55 f9 ff ff       	call   8010748e <lcr3>
80107b39:	83 c4 04             	add    $0x4,%esp
}
80107b3c:	c9                   	leave  
80107b3d:	c3                   	ret    

80107b3e <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107b3e:	55                   	push   %ebp
80107b3f:	89 e5                	mov    %esp,%ebp
80107b41:	56                   	push   %esi
80107b42:	53                   	push   %ebx
  pushcli();
80107b43:	e8 7c d1 ff ff       	call   80104cc4 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107b48:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107b4e:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107b55:	83 c2 08             	add    $0x8,%edx
80107b58:	89 d6                	mov    %edx,%esi
80107b5a:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107b61:	83 c2 08             	add    $0x8,%edx
80107b64:	c1 ea 10             	shr    $0x10,%edx
80107b67:	89 d3                	mov    %edx,%ebx
80107b69:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107b70:	83 c2 08             	add    $0x8,%edx
80107b73:	c1 ea 18             	shr    $0x18,%edx
80107b76:	89 d1                	mov    %edx,%ecx
80107b78:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107b7f:	67 00 
80107b81:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
80107b88:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80107b8e:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107b95:	83 e2 f0             	and    $0xfffffff0,%edx
80107b98:	83 ca 09             	or     $0x9,%edx
80107b9b:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107ba1:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107ba8:	83 ca 10             	or     $0x10,%edx
80107bab:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107bb1:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107bb8:	83 e2 9f             	and    $0xffffff9f,%edx
80107bbb:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107bc1:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107bc8:	83 ca 80             	or     $0xffffff80,%edx
80107bcb:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107bd1:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107bd8:	83 e2 f0             	and    $0xfffffff0,%edx
80107bdb:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107be1:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107be8:	83 e2 ef             	and    $0xffffffef,%edx
80107beb:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107bf1:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107bf8:	83 e2 df             	and    $0xffffffdf,%edx
80107bfb:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107c01:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107c08:	83 ca 40             	or     $0x40,%edx
80107c0b:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107c11:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107c18:	83 e2 7f             	and    $0x7f,%edx
80107c1b:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107c21:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107c27:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107c2d:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107c34:	83 e2 ef             	and    $0xffffffef,%edx
80107c37:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107c3d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107c43:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80107c49:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107c4f:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107c56:	8b 52 08             	mov    0x8(%edx),%edx
80107c59:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107c5f:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80107c62:	83 ec 0c             	sub    $0xc,%esp
80107c65:	6a 30                	push   $0x30
80107c67:	e8 f7 f7 ff ff       	call   80107463 <ltr>
80107c6c:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80107c6f:	8b 45 08             	mov    0x8(%ebp),%eax
80107c72:	8b 40 04             	mov    0x4(%eax),%eax
80107c75:	85 c0                	test   %eax,%eax
80107c77:	75 0d                	jne    80107c86 <switchuvm+0x148>
    panic("switchuvm: no pgdir");
80107c79:	83 ec 0c             	sub    $0xc,%esp
80107c7c:	68 6b 88 10 80       	push   $0x8010886b
80107c81:	e8 d6 88 ff ff       	call   8010055c <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80107c86:	8b 45 08             	mov    0x8(%ebp),%eax
80107c89:	8b 40 04             	mov    0x4(%eax),%eax
80107c8c:	83 ec 0c             	sub    $0xc,%esp
80107c8f:	50                   	push   %eax
80107c90:	e8 04 f8 ff ff       	call   80107499 <v2p>
80107c95:	83 c4 10             	add    $0x10,%esp
80107c98:	83 ec 0c             	sub    $0xc,%esp
80107c9b:	50                   	push   %eax
80107c9c:	e8 ed f7 ff ff       	call   8010748e <lcr3>
80107ca1:	83 c4 10             	add    $0x10,%esp
  popcli();
80107ca4:	e8 5f d0 ff ff       	call   80104d08 <popcli>
}
80107ca9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107cac:	5b                   	pop    %ebx
80107cad:	5e                   	pop    %esi
80107cae:	5d                   	pop    %ebp
80107caf:	c3                   	ret    

80107cb0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107cb0:	55                   	push   %ebp
80107cb1:	89 e5                	mov    %esp,%ebp
80107cb3:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
80107cb6:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80107cbd:	76 0d                	jbe    80107ccc <inituvm+0x1c>
    panic("inituvm: more than a page");
80107cbf:	83 ec 0c             	sub    $0xc,%esp
80107cc2:	68 7f 88 10 80       	push   $0x8010887f
80107cc7:	e8 90 88 ff ff       	call   8010055c <panic>
  mem = kalloc();
80107ccc:	e8 ac ae ff ff       	call   80102b7d <kalloc>
80107cd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80107cd4:	83 ec 04             	sub    $0x4,%esp
80107cd7:	68 00 10 00 00       	push   $0x1000
80107cdc:	6a 00                	push   $0x0
80107cde:	ff 75 f4             	pushl  -0xc(%ebp)
80107ce1:	e8 e0 d0 ff ff       	call   80104dc6 <memset>
80107ce6:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107ce9:	83 ec 0c             	sub    $0xc,%esp
80107cec:	ff 75 f4             	pushl  -0xc(%ebp)
80107cef:	e8 a5 f7 ff ff       	call   80107499 <v2p>
80107cf4:	83 c4 10             	add    $0x10,%esp
80107cf7:	83 ec 0c             	sub    $0xc,%esp
80107cfa:	6a 06                	push   $0x6
80107cfc:	50                   	push   %eax
80107cfd:	68 00 10 00 00       	push   $0x1000
80107d02:	6a 00                	push   $0x0
80107d04:	ff 75 08             	pushl  0x8(%ebp)
80107d07:	e8 bb fc ff ff       	call   801079c7 <mappages>
80107d0c:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
80107d0f:	83 ec 04             	sub    $0x4,%esp
80107d12:	ff 75 10             	pushl  0x10(%ebp)
80107d15:	ff 75 0c             	pushl  0xc(%ebp)
80107d18:	ff 75 f4             	pushl  -0xc(%ebp)
80107d1b:	e8 65 d1 ff ff       	call   80104e85 <memmove>
80107d20:	83 c4 10             	add    $0x10,%esp
}
80107d23:	c9                   	leave  
80107d24:	c3                   	ret    

80107d25 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107d25:	55                   	push   %ebp
80107d26:	89 e5                	mov    %esp,%ebp
80107d28:	53                   	push   %ebx
80107d29:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107d2c:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d2f:	25 ff 0f 00 00       	and    $0xfff,%eax
80107d34:	85 c0                	test   %eax,%eax
80107d36:	74 0d                	je     80107d45 <loaduvm+0x20>
    panic("loaduvm: addr must be page aligned");
80107d38:	83 ec 0c             	sub    $0xc,%esp
80107d3b:	68 9c 88 10 80       	push   $0x8010889c
80107d40:	e8 17 88 ff ff       	call   8010055c <panic>
  for(i = 0; i < sz; i += PGSIZE){
80107d45:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107d4c:	e9 95 00 00 00       	jmp    80107de6 <loaduvm+0xc1>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107d51:	8b 55 0c             	mov    0xc(%ebp),%edx
80107d54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d57:	01 d0                	add    %edx,%eax
80107d59:	83 ec 04             	sub    $0x4,%esp
80107d5c:	6a 00                	push   $0x0
80107d5e:	50                   	push   %eax
80107d5f:	ff 75 08             	pushl  0x8(%ebp)
80107d62:	e8 c0 fb ff ff       	call   80107927 <walkpgdir>
80107d67:	83 c4 10             	add    $0x10,%esp
80107d6a:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107d6d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107d71:	75 0d                	jne    80107d80 <loaduvm+0x5b>
      panic("loaduvm: address should exist");
80107d73:	83 ec 0c             	sub    $0xc,%esp
80107d76:	68 bf 88 10 80       	push   $0x801088bf
80107d7b:	e8 dc 87 ff ff       	call   8010055c <panic>
    pa = PTE_ADDR(*pte);
80107d80:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107d83:	8b 00                	mov    (%eax),%eax
80107d85:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d8a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80107d8d:	8b 45 18             	mov    0x18(%ebp),%eax
80107d90:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107d93:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80107d98:	77 0b                	ja     80107da5 <loaduvm+0x80>
      n = sz - i;
80107d9a:	8b 45 18             	mov    0x18(%ebp),%eax
80107d9d:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107da0:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107da3:	eb 07                	jmp    80107dac <loaduvm+0x87>
    else
      n = PGSIZE;
80107da5:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80107dac:	8b 55 14             	mov    0x14(%ebp),%edx
80107daf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107db2:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80107db5:	83 ec 0c             	sub    $0xc,%esp
80107db8:	ff 75 e8             	pushl  -0x18(%ebp)
80107dbb:	e8 e6 f6 ff ff       	call   801074a6 <p2v>
80107dc0:	83 c4 10             	add    $0x10,%esp
80107dc3:	ff 75 f0             	pushl  -0x10(%ebp)
80107dc6:	53                   	push   %ebx
80107dc7:	50                   	push   %eax
80107dc8:	ff 75 10             	pushl  0x10(%ebp)
80107dcb:	e8 58 a0 ff ff       	call   80101e28 <readi>
80107dd0:	83 c4 10             	add    $0x10,%esp
80107dd3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107dd6:	74 07                	je     80107ddf <loaduvm+0xba>
      return -1;
80107dd8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107ddd:	eb 18                	jmp    80107df7 <loaduvm+0xd2>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107ddf:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107de6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107de9:	3b 45 18             	cmp    0x18(%ebp),%eax
80107dec:	0f 82 5f ff ff ff    	jb     80107d51 <loaduvm+0x2c>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80107df2:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107df7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107dfa:	c9                   	leave  
80107dfb:	c3                   	ret    

80107dfc <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107dfc:	55                   	push   %ebp
80107dfd:	89 e5                	mov    %esp,%ebp
80107dff:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80107e02:	8b 45 10             	mov    0x10(%ebp),%eax
80107e05:	85 c0                	test   %eax,%eax
80107e07:	79 0a                	jns    80107e13 <allocuvm+0x17>
    return 0;
80107e09:	b8 00 00 00 00       	mov    $0x0,%eax
80107e0e:	e9 b0 00 00 00       	jmp    80107ec3 <allocuvm+0xc7>
  if(newsz < oldsz)
80107e13:	8b 45 10             	mov    0x10(%ebp),%eax
80107e16:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107e19:	73 08                	jae    80107e23 <allocuvm+0x27>
    return oldsz;
80107e1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e1e:	e9 a0 00 00 00       	jmp    80107ec3 <allocuvm+0xc7>

  a = PGROUNDUP(oldsz);
80107e23:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e26:	05 ff 0f 00 00       	add    $0xfff,%eax
80107e2b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e30:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
80107e33:	eb 7f                	jmp    80107eb4 <allocuvm+0xb8>
    mem = kalloc();
80107e35:	e8 43 ad ff ff       	call   80102b7d <kalloc>
80107e3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80107e3d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107e41:	75 2b                	jne    80107e6e <allocuvm+0x72>
      cprintf("allocuvm out of memory\n");
80107e43:	83 ec 0c             	sub    $0xc,%esp
80107e46:	68 dd 88 10 80       	push   $0x801088dd
80107e4b:	e8 6f 85 ff ff       	call   801003bf <cprintf>
80107e50:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
80107e53:	83 ec 04             	sub    $0x4,%esp
80107e56:	ff 75 0c             	pushl  0xc(%ebp)
80107e59:	ff 75 10             	pushl  0x10(%ebp)
80107e5c:	ff 75 08             	pushl  0x8(%ebp)
80107e5f:	e8 61 00 00 00       	call   80107ec5 <deallocuvm>
80107e64:	83 c4 10             	add    $0x10,%esp
      return 0;
80107e67:	b8 00 00 00 00       	mov    $0x0,%eax
80107e6c:	eb 55                	jmp    80107ec3 <allocuvm+0xc7>
    }
    memset(mem, 0, PGSIZE);
80107e6e:	83 ec 04             	sub    $0x4,%esp
80107e71:	68 00 10 00 00       	push   $0x1000
80107e76:	6a 00                	push   $0x0
80107e78:	ff 75 f0             	pushl  -0x10(%ebp)
80107e7b:	e8 46 cf ff ff       	call   80104dc6 <memset>
80107e80:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107e83:	83 ec 0c             	sub    $0xc,%esp
80107e86:	ff 75 f0             	pushl  -0x10(%ebp)
80107e89:	e8 0b f6 ff ff       	call   80107499 <v2p>
80107e8e:	83 c4 10             	add    $0x10,%esp
80107e91:	89 c2                	mov    %eax,%edx
80107e93:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e96:	83 ec 0c             	sub    $0xc,%esp
80107e99:	6a 06                	push   $0x6
80107e9b:	52                   	push   %edx
80107e9c:	68 00 10 00 00       	push   $0x1000
80107ea1:	50                   	push   %eax
80107ea2:	ff 75 08             	pushl  0x8(%ebp)
80107ea5:	e8 1d fb ff ff       	call   801079c7 <mappages>
80107eaa:	83 c4 20             	add    $0x20,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107ead:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107eb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107eb7:	3b 45 10             	cmp    0x10(%ebp),%eax
80107eba:	0f 82 75 ff ff ff    	jb     80107e35 <allocuvm+0x39>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
80107ec0:	8b 45 10             	mov    0x10(%ebp),%eax
}
80107ec3:	c9                   	leave  
80107ec4:	c3                   	ret    

80107ec5 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107ec5:	55                   	push   %ebp
80107ec6:	89 e5                	mov    %esp,%ebp
80107ec8:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80107ecb:	8b 45 10             	mov    0x10(%ebp),%eax
80107ece:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107ed1:	72 08                	jb     80107edb <deallocuvm+0x16>
    return oldsz;
80107ed3:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ed6:	e9 a5 00 00 00       	jmp    80107f80 <deallocuvm+0xbb>

  a = PGROUNDUP(newsz);
80107edb:	8b 45 10             	mov    0x10(%ebp),%eax
80107ede:	05 ff 0f 00 00       	add    $0xfff,%eax
80107ee3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ee8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107eeb:	e9 81 00 00 00       	jmp    80107f71 <deallocuvm+0xac>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107ef0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ef3:	83 ec 04             	sub    $0x4,%esp
80107ef6:	6a 00                	push   $0x0
80107ef8:	50                   	push   %eax
80107ef9:	ff 75 08             	pushl  0x8(%ebp)
80107efc:	e8 26 fa ff ff       	call   80107927 <walkpgdir>
80107f01:	83 c4 10             	add    $0x10,%esp
80107f04:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80107f07:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107f0b:	75 09                	jne    80107f16 <deallocuvm+0x51>
      a += (NPTENTRIES - 1) * PGSIZE;
80107f0d:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
80107f14:	eb 54                	jmp    80107f6a <deallocuvm+0xa5>
    else if((*pte & PTE_P) != 0){
80107f16:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107f19:	8b 00                	mov    (%eax),%eax
80107f1b:	83 e0 01             	and    $0x1,%eax
80107f1e:	85 c0                	test   %eax,%eax
80107f20:	74 48                	je     80107f6a <deallocuvm+0xa5>
      pa = PTE_ADDR(*pte);
80107f22:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107f25:	8b 00                	mov    (%eax),%eax
80107f27:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f2c:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
80107f2f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107f33:	75 0d                	jne    80107f42 <deallocuvm+0x7d>
        panic("kfree");
80107f35:	83 ec 0c             	sub    $0xc,%esp
80107f38:	68 f5 88 10 80       	push   $0x801088f5
80107f3d:	e8 1a 86 ff ff       	call   8010055c <panic>
      char *v = p2v(pa);
80107f42:	83 ec 0c             	sub    $0xc,%esp
80107f45:	ff 75 ec             	pushl  -0x14(%ebp)
80107f48:	e8 59 f5 ff ff       	call   801074a6 <p2v>
80107f4d:	83 c4 10             	add    $0x10,%esp
80107f50:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
80107f53:	83 ec 0c             	sub    $0xc,%esp
80107f56:	ff 75 e8             	pushl  -0x18(%ebp)
80107f59:	e8 83 ab ff ff       	call   80102ae1 <kfree>
80107f5e:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80107f61:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107f64:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80107f6a:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107f71:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f74:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107f77:	0f 82 73 ff ff ff    	jb     80107ef0 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
80107f7d:	8b 45 10             	mov    0x10(%ebp),%eax
}
80107f80:	c9                   	leave  
80107f81:	c3                   	ret    

80107f82 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107f82:	55                   	push   %ebp
80107f83:	89 e5                	mov    %esp,%ebp
80107f85:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
80107f88:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80107f8c:	75 0d                	jne    80107f9b <freevm+0x19>
    panic("freevm: no pgdir");
80107f8e:	83 ec 0c             	sub    $0xc,%esp
80107f91:	68 fb 88 10 80       	push   $0x801088fb
80107f96:	e8 c1 85 ff ff       	call   8010055c <panic>
  deallocuvm(pgdir, KERNBASE, 0);
80107f9b:	83 ec 04             	sub    $0x4,%esp
80107f9e:	6a 00                	push   $0x0
80107fa0:	68 00 00 00 80       	push   $0x80000000
80107fa5:	ff 75 08             	pushl  0x8(%ebp)
80107fa8:	e8 18 ff ff ff       	call   80107ec5 <deallocuvm>
80107fad:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107fb0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107fb7:	eb 4f                	jmp    80108008 <freevm+0x86>
    if(pgdir[i] & PTE_P){
80107fb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fbc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107fc3:	8b 45 08             	mov    0x8(%ebp),%eax
80107fc6:	01 d0                	add    %edx,%eax
80107fc8:	8b 00                	mov    (%eax),%eax
80107fca:	83 e0 01             	and    $0x1,%eax
80107fcd:	85 c0                	test   %eax,%eax
80107fcf:	74 33                	je     80108004 <freevm+0x82>
      char * v = p2v(PTE_ADDR(pgdir[i]));
80107fd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fd4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107fdb:	8b 45 08             	mov    0x8(%ebp),%eax
80107fde:	01 d0                	add    %edx,%eax
80107fe0:	8b 00                	mov    (%eax),%eax
80107fe2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107fe7:	83 ec 0c             	sub    $0xc,%esp
80107fea:	50                   	push   %eax
80107feb:	e8 b6 f4 ff ff       	call   801074a6 <p2v>
80107ff0:	83 c4 10             	add    $0x10,%esp
80107ff3:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
80107ff6:	83 ec 0c             	sub    $0xc,%esp
80107ff9:	ff 75 f0             	pushl  -0x10(%ebp)
80107ffc:	e8 e0 aa ff ff       	call   80102ae1 <kfree>
80108001:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108004:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108008:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
8010800f:	76 a8                	jbe    80107fb9 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80108011:	83 ec 0c             	sub    $0xc,%esp
80108014:	ff 75 08             	pushl  0x8(%ebp)
80108017:	e8 c5 aa ff ff       	call   80102ae1 <kfree>
8010801c:	83 c4 10             	add    $0x10,%esp
}
8010801f:	c9                   	leave  
80108020:	c3                   	ret    

80108021 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108021:	55                   	push   %ebp
80108022:	89 e5                	mov    %esp,%ebp
80108024:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108027:	83 ec 04             	sub    $0x4,%esp
8010802a:	6a 00                	push   $0x0
8010802c:	ff 75 0c             	pushl  0xc(%ebp)
8010802f:	ff 75 08             	pushl  0x8(%ebp)
80108032:	e8 f0 f8 ff ff       	call   80107927 <walkpgdir>
80108037:	83 c4 10             	add    $0x10,%esp
8010803a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
8010803d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108041:	75 0d                	jne    80108050 <clearpteu+0x2f>
    panic("clearpteu");
80108043:	83 ec 0c             	sub    $0xc,%esp
80108046:	68 0c 89 10 80       	push   $0x8010890c
8010804b:	e8 0c 85 ff ff       	call   8010055c <panic>
  *pte &= ~PTE_U;
80108050:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108053:	8b 00                	mov    (%eax),%eax
80108055:	83 e0 fb             	and    $0xfffffffb,%eax
80108058:	89 c2                	mov    %eax,%edx
8010805a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010805d:	89 10                	mov    %edx,(%eax)
}
8010805f:	c9                   	leave  
80108060:	c3                   	ret    

80108061 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108061:	55                   	push   %ebp
80108062:	89 e5                	mov    %esp,%ebp
80108064:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
80108067:	e8 ed f9 ff ff       	call   80107a59 <setupkvm>
8010806c:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010806f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108073:	75 0a                	jne    8010807f <copyuvm+0x1e>
    return 0;
80108075:	b8 00 00 00 00       	mov    $0x0,%eax
8010807a:	e9 e9 00 00 00       	jmp    80108168 <copyuvm+0x107>
  for(i = 0; i < sz; i += PGSIZE){
8010807f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108086:	e9 b9 00 00 00       	jmp    80108144 <copyuvm+0xe3>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
8010808b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010808e:	83 ec 04             	sub    $0x4,%esp
80108091:	6a 00                	push   $0x0
80108093:	50                   	push   %eax
80108094:	ff 75 08             	pushl  0x8(%ebp)
80108097:	e8 8b f8 ff ff       	call   80107927 <walkpgdir>
8010809c:	83 c4 10             	add    $0x10,%esp
8010809f:	89 45 ec             	mov    %eax,-0x14(%ebp)
801080a2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801080a6:	75 0d                	jne    801080b5 <copyuvm+0x54>
      panic("copyuvm: pte should exist");
801080a8:	83 ec 0c             	sub    $0xc,%esp
801080ab:	68 16 89 10 80       	push   $0x80108916
801080b0:	e8 a7 84 ff ff       	call   8010055c <panic>
    if(!(*pte & PTE_P))
801080b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801080b8:	8b 00                	mov    (%eax),%eax
801080ba:	83 e0 01             	and    $0x1,%eax
801080bd:	85 c0                	test   %eax,%eax
801080bf:	75 0d                	jne    801080ce <copyuvm+0x6d>
      panic("copyuvm: page not present");
801080c1:	83 ec 0c             	sub    $0xc,%esp
801080c4:	68 30 89 10 80       	push   $0x80108930
801080c9:	e8 8e 84 ff ff       	call   8010055c <panic>
    pa = PTE_ADDR(*pte);
801080ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
801080d1:	8b 00                	mov    (%eax),%eax
801080d3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080d8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if((mem = kalloc()) == 0)
801080db:	e8 9d aa ff ff       	call   80102b7d <kalloc>
801080e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801080e3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
801080e7:	75 02                	jne    801080eb <copyuvm+0x8a>
      goto bad;
801080e9:	eb 6a                	jmp    80108155 <copyuvm+0xf4>
    memmove(mem, (char*)p2v(pa), PGSIZE);
801080eb:	83 ec 0c             	sub    $0xc,%esp
801080ee:	ff 75 e8             	pushl  -0x18(%ebp)
801080f1:	e8 b0 f3 ff ff       	call   801074a6 <p2v>
801080f6:	83 c4 10             	add    $0x10,%esp
801080f9:	83 ec 04             	sub    $0x4,%esp
801080fc:	68 00 10 00 00       	push   $0x1000
80108101:	50                   	push   %eax
80108102:	ff 75 e4             	pushl  -0x1c(%ebp)
80108105:	e8 7b cd ff ff       	call   80104e85 <memmove>
8010810a:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
8010810d:	83 ec 0c             	sub    $0xc,%esp
80108110:	ff 75 e4             	pushl  -0x1c(%ebp)
80108113:	e8 81 f3 ff ff       	call   80107499 <v2p>
80108118:	83 c4 10             	add    $0x10,%esp
8010811b:	89 c2                	mov    %eax,%edx
8010811d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108120:	83 ec 0c             	sub    $0xc,%esp
80108123:	6a 06                	push   $0x6
80108125:	52                   	push   %edx
80108126:	68 00 10 00 00       	push   $0x1000
8010812b:	50                   	push   %eax
8010812c:	ff 75 f0             	pushl  -0x10(%ebp)
8010812f:	e8 93 f8 ff ff       	call   801079c7 <mappages>
80108134:	83 c4 20             	add    $0x20,%esp
80108137:	85 c0                	test   %eax,%eax
80108139:	79 02                	jns    8010813d <copyuvm+0xdc>
      goto bad;
8010813b:	eb 18                	jmp    80108155 <copyuvm+0xf4>
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010813d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108144:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108147:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010814a:	0f 82 3b ff ff ff    	jb     8010808b <copyuvm+0x2a>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
  }
  return d;
80108150:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108153:	eb 13                	jmp    80108168 <copyuvm+0x107>

bad:
  freevm(d);
80108155:	83 ec 0c             	sub    $0xc,%esp
80108158:	ff 75 f0             	pushl  -0x10(%ebp)
8010815b:	e8 22 fe ff ff       	call   80107f82 <freevm>
80108160:	83 c4 10             	add    $0x10,%esp
  return 0;
80108163:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108168:	c9                   	leave  
80108169:	c3                   	ret    

8010816a <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
8010816a:	55                   	push   %ebp
8010816b:	89 e5                	mov    %esp,%ebp
8010816d:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108170:	83 ec 04             	sub    $0x4,%esp
80108173:	6a 00                	push   $0x0
80108175:	ff 75 0c             	pushl  0xc(%ebp)
80108178:	ff 75 08             	pushl  0x8(%ebp)
8010817b:	e8 a7 f7 ff ff       	call   80107927 <walkpgdir>
80108180:	83 c4 10             	add    $0x10,%esp
80108183:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
80108186:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108189:	8b 00                	mov    (%eax),%eax
8010818b:	83 e0 01             	and    $0x1,%eax
8010818e:	85 c0                	test   %eax,%eax
80108190:	75 07                	jne    80108199 <uva2ka+0x2f>
    return 0;
80108192:	b8 00 00 00 00       	mov    $0x0,%eax
80108197:	eb 29                	jmp    801081c2 <uva2ka+0x58>
  if((*pte & PTE_U) == 0)
80108199:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010819c:	8b 00                	mov    (%eax),%eax
8010819e:	83 e0 04             	and    $0x4,%eax
801081a1:	85 c0                	test   %eax,%eax
801081a3:	75 07                	jne    801081ac <uva2ka+0x42>
    return 0;
801081a5:	b8 00 00 00 00       	mov    $0x0,%eax
801081aa:	eb 16                	jmp    801081c2 <uva2ka+0x58>
  return (char*)p2v(PTE_ADDR(*pte));
801081ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081af:	8b 00                	mov    (%eax),%eax
801081b1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801081b6:	83 ec 0c             	sub    $0xc,%esp
801081b9:	50                   	push   %eax
801081ba:	e8 e7 f2 ff ff       	call   801074a6 <p2v>
801081bf:	83 c4 10             	add    $0x10,%esp
}
801081c2:	c9                   	leave  
801081c3:	c3                   	ret    

801081c4 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801081c4:	55                   	push   %ebp
801081c5:	89 e5                	mov    %esp,%ebp
801081c7:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
801081ca:	8b 45 10             	mov    0x10(%ebp),%eax
801081cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
801081d0:	eb 7f                	jmp    80108251 <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
801081d2:	8b 45 0c             	mov    0xc(%ebp),%eax
801081d5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801081da:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
801081dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801081e0:	83 ec 08             	sub    $0x8,%esp
801081e3:	50                   	push   %eax
801081e4:	ff 75 08             	pushl  0x8(%ebp)
801081e7:	e8 7e ff ff ff       	call   8010816a <uva2ka>
801081ec:	83 c4 10             	add    $0x10,%esp
801081ef:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
801081f2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801081f6:	75 07                	jne    801081ff <copyout+0x3b>
      return -1;
801081f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801081fd:	eb 61                	jmp    80108260 <copyout+0x9c>
    n = PGSIZE - (va - va0);
801081ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108202:	2b 45 0c             	sub    0xc(%ebp),%eax
80108205:	05 00 10 00 00       	add    $0x1000,%eax
8010820a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
8010820d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108210:	3b 45 14             	cmp    0x14(%ebp),%eax
80108213:	76 06                	jbe    8010821b <copyout+0x57>
      n = len;
80108215:	8b 45 14             	mov    0x14(%ebp),%eax
80108218:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
8010821b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010821e:	2b 45 ec             	sub    -0x14(%ebp),%eax
80108221:	89 c2                	mov    %eax,%edx
80108223:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108226:	01 d0                	add    %edx,%eax
80108228:	83 ec 04             	sub    $0x4,%esp
8010822b:	ff 75 f0             	pushl  -0x10(%ebp)
8010822e:	ff 75 f4             	pushl  -0xc(%ebp)
80108231:	50                   	push   %eax
80108232:	e8 4e cc ff ff       	call   80104e85 <memmove>
80108237:	83 c4 10             	add    $0x10,%esp
    len -= n;
8010823a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010823d:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
80108240:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108243:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
80108246:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108249:	05 00 10 00 00       	add    $0x1000,%eax
8010824e:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108251:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80108255:	0f 85 77 ff ff ff    	jne    801081d2 <copyout+0xe>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010825b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108260:	c9                   	leave  
80108261:	c3                   	ret    
