
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc b0 cb 10 80       	mov    $0x8010cbb0,%esp
8010002d:	b8 94 37 10 80       	mov    $0x80103794,%eax
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
8010003d:	68 c0 85 10 80       	push   $0x801085c0
80100042:	68 c0 cb 10 80       	push   $0x8010cbc0
80100047:	e8 59 4e 00 00       	call   80104ea5 <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 f0 e0 10 80 e4 	movl   $0x8010e0e4,0x8010e0f0
80100056:	e0 10 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 f4 e0 10 80 e4 	movl   $0x8010e0e4,0x8010e0f4
80100060:	e0 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100063:	c7 45 f4 f4 cb 10 80 	movl   $0x8010cbf4,-0xc(%ebp)
8010006a:	eb 3a                	jmp    801000a6 <binit+0x72>
    b->next = bcache.head.next;
8010006c:	8b 15 f4 e0 10 80    	mov    0x8010e0f4,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 0c e4 e0 10 80 	movl   $0x8010e0e4,0xc(%eax)
    b->dev = -1;
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008c:	a1 f4 e0 10 80       	mov    0x8010e0f4,%eax
80100091:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100094:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100097:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010009a:	a3 f4 e0 10 80       	mov    %eax,0x8010e0f4

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009f:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a6:	81 7d f4 e4 e0 10 80 	cmpl   $0x8010e0e4,-0xc(%ebp)
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
801000ba:	68 c0 cb 10 80       	push   $0x8010cbc0
801000bf:	e8 02 4e 00 00       	call   80104ec6 <acquire>
801000c4:	83 c4 10             	add    $0x10,%esp

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c7:	a1 f4 e0 10 80       	mov    0x8010e0f4,%eax
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
80100105:	68 c0 cb 10 80       	push   $0x8010cbc0
8010010a:	e8 1d 4e 00 00       	call   80104f2c <release>
8010010f:	83 c4 10             	add    $0x10,%esp
        return b;
80100112:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100115:	e9 98 00 00 00       	jmp    801001b2 <bget+0x101>
      }
      sleep(b, &bcache.lock);
8010011a:	83 ec 08             	sub    $0x8,%esp
8010011d:	68 c0 cb 10 80       	push   $0x8010cbc0
80100122:	ff 75 f4             	pushl  -0xc(%ebp)
80100125:	e8 9a 4a 00 00       	call   80104bc4 <sleep>
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
80100138:	81 7d f4 e4 e0 10 80 	cmpl   $0x8010e0e4,-0xc(%ebp)
8010013f:	75 90                	jne    801000d1 <bget+0x20>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100141:	a1 f0 e0 10 80       	mov    0x8010e0f0,%eax
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
80100181:	68 c0 cb 10 80       	push   $0x8010cbc0
80100186:	e8 a1 4d 00 00       	call   80104f2c <release>
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
8010019c:	81 7d f4 e4 e0 10 80 	cmpl   $0x8010e0e4,-0xc(%ebp)
801001a3:	75 a6                	jne    8010014b <bget+0x9a>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
801001a5:	83 ec 0c             	sub    $0xc,%esp
801001a8:	68 c7 85 10 80       	push   $0x801085c7
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
801001e0:	e8 a4 29 00 00       	call   80102b89 <iderw>
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
80100202:	68 d8 85 10 80       	push   $0x801085d8
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
80100221:	e8 63 29 00 00       	call   80102b89 <iderw>
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
80100240:	68 df 85 10 80       	push   $0x801085df
80100245:	e8 12 03 00 00       	call   8010055c <panic>

  acquire(&bcache.lock);
8010024a:	83 ec 0c             	sub    $0xc,%esp
8010024d:	68 c0 cb 10 80       	push   $0x8010cbc0
80100252:	e8 6f 4c 00 00       	call   80104ec6 <acquire>
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
80100278:	8b 15 f4 e0 10 80    	mov    0x8010e0f4,%edx
8010027e:	8b 45 08             	mov    0x8(%ebp),%eax
80100281:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
80100284:	8b 45 08             	mov    0x8(%ebp),%eax
80100287:	c7 40 0c e4 e0 10 80 	movl   $0x8010e0e4,0xc(%eax)
  bcache.head.next->prev = b;
8010028e:	a1 f4 e0 10 80       	mov    0x8010e0f4,%eax
80100293:	8b 55 08             	mov    0x8(%ebp),%edx
80100296:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
80100299:	8b 45 08             	mov    0x8(%ebp),%eax
8010029c:	a3 f4 e0 10 80       	mov    %eax,0x8010e0f4

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
801002b6:	e8 f2 49 00 00       	call   80104cad <wakeup>
801002bb:	83 c4 10             	add    $0x10,%esp

  release(&bcache.lock);
801002be:	83 ec 0c             	sub    $0xc,%esp
801002c1:	68 c0 cb 10 80       	push   $0x8010cbc0
801002c6:	e8 61 4c 00 00       	call   80104f2c <release>
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
801003db:	e8 e6 4a 00 00       	call   80104ec6 <acquire>
801003e0:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
801003e3:	8b 45 08             	mov    0x8(%ebp),%eax
801003e6:	85 c0                	test   %eax,%eax
801003e8:	75 0d                	jne    801003f7 <cprintf+0x38>
    panic("null fmt");
801003ea:	83 ec 0c             	sub    $0xc,%esp
801003ed:	68 e6 85 10 80       	push   $0x801085e6
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
801004c7:	c7 45 ec ef 85 10 80 	movl   $0x801085ef,-0x14(%ebp)
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
80100552:	e8 d5 49 00 00       	call   80104f2c <release>
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
80100581:	68 f6 85 10 80       	push   $0x801085f6
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
801005a0:	68 05 86 10 80       	push   $0x80108605
801005a5:	e8 15 fe ff ff       	call   801003bf <cprintf>
801005aa:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005ad:	83 ec 08             	sub    $0x8,%esp
801005b0:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005b3:	50                   	push   %eax
801005b4:	8d 45 08             	lea    0x8(%ebp),%eax
801005b7:	50                   	push   %eax
801005b8:	e8 c0 49 00 00       	call   80104f7d <getcallerpcs>
801005bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005c7:	eb 1c                	jmp    801005e5 <panic+0x89>
    cprintf(" %p", pcs[i]);
801005c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005cc:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005d0:	83 ec 08             	sub    $0x8,%esp
801005d3:	50                   	push   %eax
801005d4:	68 07 86 10 80       	push   $0x80108607
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
801006d1:	e8 0b 4b 00 00       	call   801051e1 <memmove>
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
801006fb:	e8 22 4a 00 00       	call   80105122 <memset>
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
8010078f:	e8 d1 64 00 00       	call   80106c65 <uartputc>
80100794:	83 c4 10             	add    $0x10,%esp
80100797:	83 ec 0c             	sub    $0xc,%esp
8010079a:	6a 20                	push   $0x20
8010079c:	e8 c4 64 00 00       	call   80106c65 <uartputc>
801007a1:	83 c4 10             	add    $0x10,%esp
801007a4:	83 ec 0c             	sub    $0xc,%esp
801007a7:	6a 08                	push   $0x8
801007a9:	e8 b7 64 00 00       	call   80106c65 <uartputc>
801007ae:	83 c4 10             	add    $0x10,%esp
801007b1:	eb 0e                	jmp    801007c1 <consputc+0x56>
  } else
    uartputc(c);
801007b3:	83 ec 0c             	sub    $0xc,%esp
801007b6:	ff 75 08             	pushl  0x8(%ebp)
801007b9:	e8 a7 64 00 00       	call   80106c65 <uartputc>
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
static int cmdCount = 0;
static int upCount = 0;
static int prevCount = 0;
void
consoleintr(int (*getc)(void))
{
801007d1:	55                   	push   %ebp
801007d2:	89 e5                	mov    %esp,%ebp
801007d4:	83 ec 18             	sub    $0x18,%esp
  int c;
  int p;
  acquire(&input.lock);
801007d7:	83 ec 0c             	sub    $0xc,%esp
801007da:	68 00 e3 10 80       	push   $0x8010e300
801007df:	e8 e2 46 00 00       	call   80104ec6 <acquire>
801007e4:	83 c4 10             	add    $0x10,%esp
while((c = getc()) >= 0){
801007e7:	e9 9f 04 00 00       	jmp    80100c8b <consoleintr+0x4ba>
    switch(c){
801007ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
801007ef:	83 f8 15             	cmp    $0x15,%eax
801007f2:	74 5b                	je     8010084f <consoleintr+0x7e>
801007f4:	83 f8 15             	cmp    $0x15,%eax
801007f7:	7f 0f                	jg     80100808 <consoleintr+0x37>
801007f9:	83 f8 08             	cmp    $0x8,%eax
801007fc:	74 7d                	je     8010087b <consoleintr+0xaa>
801007fe:	83 f8 10             	cmp    $0x10,%eax
80100801:	74 25                	je     80100828 <consoleintr+0x57>
80100803:	e9 33 03 00 00       	jmp    80100b3b <consoleintr+0x36a>
80100808:	3d e2 00 00 00       	cmp    $0xe2,%eax
8010080d:	0f 84 99 00 00 00    	je     801008ac <consoleintr+0xdb>
80100813:	3d e3 00 00 00       	cmp    $0xe3,%eax
80100818:	0f 84 e1 01 00 00    	je     801009ff <consoleintr+0x22e>
8010081e:	83 f8 7f             	cmp    $0x7f,%eax
80100821:	74 58                	je     8010087b <consoleintr+0xaa>
80100823:	e9 13 03 00 00       	jmp    80100b3b <consoleintr+0x36a>
    case C('P'):  // Process listing.
      procdump();
80100828:	e8 3a 45 00 00       	call   80104d67 <procdump>
      break;
8010082d:	e9 59 04 00 00       	jmp    80100c8b <consoleintr+0x4ba>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100832:	a1 bc e3 10 80       	mov    0x8010e3bc,%eax
80100837:	83 e8 01             	sub    $0x1,%eax
8010083a:	a3 bc e3 10 80       	mov    %eax,0x8010e3bc
        consputc(BACKSPACE);
8010083f:	83 ec 0c             	sub    $0xc,%esp
80100842:	68 00 01 00 00       	push   $0x100
80100847:	e8 1f ff ff ff       	call   8010076b <consputc>
8010084c:	83 c4 10             	add    $0x10,%esp
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010084f:	8b 15 bc e3 10 80    	mov    0x8010e3bc,%edx
80100855:	a1 b8 e3 10 80       	mov    0x8010e3b8,%eax
8010085a:	39 c2                	cmp    %eax,%edx
8010085c:	74 18                	je     80100876 <consoleintr+0xa5>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
8010085e:	a1 bc e3 10 80       	mov    0x8010e3bc,%eax
80100863:	83 e8 01             	sub    $0x1,%eax
80100866:	83 e0 7f             	and    $0x7f,%eax
80100869:	05 00 e3 10 80       	add    $0x8010e300,%eax
8010086e:	0f b6 40 34          	movzbl 0x34(%eax),%eax
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100872:	3c 0a                	cmp    $0xa,%al
80100874:	75 bc                	jne    80100832 <consoleintr+0x61>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
80100876:	e9 10 04 00 00       	jmp    80100c8b <consoleintr+0x4ba>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
8010087b:	8b 15 bc e3 10 80    	mov    0x8010e3bc,%edx
80100881:	a1 b8 e3 10 80       	mov    0x8010e3b8,%eax
80100886:	39 c2                	cmp    %eax,%edx
80100888:	74 1d                	je     801008a7 <consoleintr+0xd6>
        input.e--;
8010088a:	a1 bc e3 10 80       	mov    0x8010e3bc,%eax
8010088f:	83 e8 01             	sub    $0x1,%eax
80100892:	a3 bc e3 10 80       	mov    %eax,0x8010e3bc
        consputc(BACKSPACE);
80100897:	83 ec 0c             	sub    $0xc,%esp
8010089a:	68 00 01 00 00       	push   $0x100
8010089f:	e8 c7 fe ff ff       	call   8010076b <consputc>
801008a4:	83 c4 10             	add    $0x10,%esp
      }
      break;
801008a7:	e9 df 03 00 00       	jmp    80100c8b <consoleintr+0x4ba>
    case KEY_UP:
      upCount--;
801008ac:	a1 48 bb 10 80       	mov    0x8010bb48,%eax
801008b1:	83 e8 01             	sub    $0x1,%eax
801008b4:	a3 48 bb 10 80       	mov    %eax,0x8010bb48
        if(upCount < 0){
801008b9:	a1 48 bb 10 80       	mov    0x8010bb48,%eax
801008be:	85 c0                	test   %eax,%eax
801008c0:	79 1b                	jns    801008dd <consoleintr+0x10c>
            if(cmdCount>9)
801008c2:	a1 44 bb 10 80       	mov    0x8010bb44,%eax
801008c7:	83 f8 09             	cmp    $0x9,%eax
801008ca:	7e 0c                	jle    801008d8 <consoleintr+0x107>
                upCount = 9;
801008cc:	c7 05 48 bb 10 80 09 	movl   $0x9,0x8010bb48
801008d3:	00 00 00 
801008d6:	eb 05                	jmp    801008dd <consoleintr+0x10c>
            else
              break;
801008d8:	e9 ae 03 00 00       	jmp    80100c8b <consoleintr+0x4ba>
        }
      if(upCount == historyIndex)
801008dd:	8b 15 48 bb 10 80    	mov    0x8010bb48,%edx
801008e3:	a1 40 bb 10 80       	mov    0x8010bb40,%eax
801008e8:	39 c2                	cmp    %eax,%edx
801008ea:	75 05                	jne    801008f1 <consoleintr+0x120>
          break;
801008ec:	e9 9a 03 00 00       	jmp    80100c8b <consoleintr+0x4ba>
      int i = 0;
801008f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      for ( i = 0; i<prevCount; i++){
801008f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801008ff:	eb 21                	jmp    80100922 <consoleintr+0x151>
        input.e--;
80100901:	a1 bc e3 10 80       	mov    0x8010e3bc,%eax
80100906:	83 e8 01             	sub    $0x1,%eax
80100909:	a3 bc e3 10 80       	mov    %eax,0x8010e3bc
        consputc(BACKSPACE);
8010090e:	83 ec 0c             	sub    $0xc,%esp
80100911:	68 00 01 00 00       	push   $0x100
80100916:	e8 50 fe ff ff       	call   8010076b <consputc>
8010091b:	83 c4 10             	add    $0x10,%esp
              break;
        }
      if(upCount == historyIndex)
          break;
      int i = 0;
      for ( i = 0; i<prevCount; i++){
8010091e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100922:	a1 4c bb 10 80       	mov    0x8010bb4c,%eax
80100927:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010092a:	7c d5                	jl     80100901 <consoleintr+0x130>
        input.e--;
        consputc(BACKSPACE);
      }
      prevCount = strlen(history[upCount]);
8010092c:	a1 48 bb 10 80       	mov    0x8010bb48,%eax
80100931:	c1 e0 07             	shl    $0x7,%eax
80100934:	05 40 b6 10 80       	add    $0x8010b640,%eax
80100939:	83 ec 0c             	sub    $0xc,%esp
8010093c:	50                   	push   %eax
8010093d:	e8 2f 4a 00 00       	call   80105371 <strlen>
80100942:	83 c4 10             	add    $0x10,%esp
80100945:	a3 4c bb 10 80       	mov    %eax,0x8010bb4c
      for(i = 0; i < strlen(history[upCount]); i++){
8010094a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100951:	e9 82 00 00 00       	jmp    801009d8 <consoleintr+0x207>
          p = (int) history[upCount][i];
80100956:	a1 48 bb 10 80       	mov    0x8010bb48,%eax
8010095b:	c1 e0 07             	shl    $0x7,%eax
8010095e:	89 c2                	mov    %eax,%edx
80100960:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100963:	01 d0                	add    %edx,%eax
80100965:	05 40 b6 10 80       	add    $0x8010b640,%eax
8010096a:	0f b6 00             	movzbl (%eax),%eax
8010096d:	0f be c0             	movsbl %al,%eax
80100970:	89 45 e8             	mov    %eax,-0x18(%ebp)
          if(p != 0 && input.e-input.r < INPUT_BUF)
80100973:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100977:	74 35                	je     801009ae <consoleintr+0x1dd>
80100979:	8b 15 bc e3 10 80    	mov    0x8010e3bc,%edx
8010097f:	a1 b4 e3 10 80       	mov    0x8010e3b4,%eax
80100984:	29 c2                	sub    %eax,%edx
80100986:	89 d0                	mov    %edx,%eax
80100988:	83 f8 7f             	cmp    $0x7f,%eax
8010098b:	77 21                	ja     801009ae <consoleintr+0x1dd>
            input.buf[input.e++ % INPUT_BUF] = p;
8010098d:	a1 bc e3 10 80       	mov    0x8010e3bc,%eax
80100992:	8d 50 01             	lea    0x1(%eax),%edx
80100995:	89 15 bc e3 10 80    	mov    %edx,0x8010e3bc
8010099b:	83 e0 7f             	and    $0x7f,%eax
8010099e:	89 c2                	mov    %eax,%edx
801009a0:	8b 45 e8             	mov    -0x18(%ebp),%eax
801009a3:	89 c1                	mov    %eax,%ecx
801009a5:	8d 82 00 e3 10 80    	lea    -0x7fef1d00(%edx),%eax
801009ab:	88 48 34             	mov    %cl,0x34(%eax)

          consputc(history[upCount][i]);
801009ae:	a1 48 bb 10 80       	mov    0x8010bb48,%eax
801009b3:	c1 e0 07             	shl    $0x7,%eax
801009b6:	89 c2                	mov    %eax,%edx
801009b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801009bb:	01 d0                	add    %edx,%eax
801009bd:	05 40 b6 10 80       	add    $0x8010b640,%eax
801009c2:	0f b6 00             	movzbl (%eax),%eax
801009c5:	0f be c0             	movsbl %al,%eax
801009c8:	83 ec 0c             	sub    $0xc,%esp
801009cb:	50                   	push   %eax
801009cc:	e8 9a fd ff ff       	call   8010076b <consputc>
801009d1:	83 c4 10             	add    $0x10,%esp
      for ( i = 0; i<prevCount; i++){
        input.e--;
        consputc(BACKSPACE);
      }
      prevCount = strlen(history[upCount]);
      for(i = 0; i < strlen(history[upCount]); i++){
801009d4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801009d8:	a1 48 bb 10 80       	mov    0x8010bb48,%eax
801009dd:	c1 e0 07             	shl    $0x7,%eax
801009e0:	05 40 b6 10 80       	add    $0x8010b640,%eax
801009e5:	83 ec 0c             	sub    $0xc,%esp
801009e8:	50                   	push   %eax
801009e9:	e8 83 49 00 00       	call   80105371 <strlen>
801009ee:	83 c4 10             	add    $0x10,%esp
801009f1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801009f4:	0f 8f 5c ff ff ff    	jg     80100956 <consoleintr+0x185>
          if(p != 0 && input.e-input.r < INPUT_BUF)
            input.buf[input.e++ % INPUT_BUF] = p;

          consputc(history[upCount][i]);
      }
      break;
801009fa:	e9 8c 02 00 00       	jmp    80100c8b <consoleintr+0x4ba>
    case KEY_DN:
      upCount++;
801009ff:	a1 48 bb 10 80       	mov    0x8010bb48,%eax
80100a04:	83 c0 01             	add    $0x1,%eax
80100a07:	a3 48 bb 10 80       	mov    %eax,0x8010bb48
      if(upCount > 9)
80100a0c:	a1 48 bb 10 80       	mov    0x8010bb48,%eax
80100a11:	83 f8 09             	cmp    $0x9,%eax
80100a14:	7e 0a                	jle    80100a20 <consoleintr+0x24f>
          upCount = 0;
80100a16:	c7 05 48 bb 10 80 00 	movl   $0x0,0x8010bb48
80100a1d:	00 00 00 
      if(upCount == historyIndex)
80100a20:	8b 15 48 bb 10 80    	mov    0x8010bb48,%edx
80100a26:	a1 40 bb 10 80       	mov    0x8010bb40,%eax
80100a2b:	39 c2                	cmp    %eax,%edx
80100a2d:	75 05                	jne    80100a34 <consoleintr+0x263>
          break;
80100a2f:	e9 57 02 00 00       	jmp    80100c8b <consoleintr+0x4ba>
      for(i = 0; i<prevCount; i++){
80100a34:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a3b:	eb 21                	jmp    80100a5e <consoleintr+0x28d>
          input.e--;
80100a3d:	a1 bc e3 10 80       	mov    0x8010e3bc,%eax
80100a42:	83 e8 01             	sub    $0x1,%eax
80100a45:	a3 bc e3 10 80       	mov    %eax,0x8010e3bc
          consputc(BACKSPACE);
80100a4a:	83 ec 0c             	sub    $0xc,%esp
80100a4d:	68 00 01 00 00       	push   $0x100
80100a52:	e8 14 fd ff ff       	call   8010076b <consputc>
80100a57:	83 c4 10             	add    $0x10,%esp
      upCount++;
      if(upCount > 9)
          upCount = 0;
      if(upCount == historyIndex)
          break;
      for(i = 0; i<prevCount; i++){
80100a5a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100a5e:	a1 4c bb 10 80       	mov    0x8010bb4c,%eax
80100a63:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100a66:	7c d5                	jl     80100a3d <consoleintr+0x26c>
          input.e--;
          consputc(BACKSPACE);
      }
      prevCount = strlen(history[upCount]);
80100a68:	a1 48 bb 10 80       	mov    0x8010bb48,%eax
80100a6d:	c1 e0 07             	shl    $0x7,%eax
80100a70:	05 40 b6 10 80       	add    $0x8010b640,%eax
80100a75:	83 ec 0c             	sub    $0xc,%esp
80100a78:	50                   	push   %eax
80100a79:	e8 f3 48 00 00       	call   80105371 <strlen>
80100a7e:	83 c4 10             	add    $0x10,%esp
80100a81:	a3 4c bb 10 80       	mov    %eax,0x8010bb4c
      for(i = 0; i < strlen(history[upCount]); i++){
80100a86:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a8d:	e9 82 00 00 00       	jmp    80100b14 <consoleintr+0x343>
          p = (int) history[upCount][i];
80100a92:	a1 48 bb 10 80       	mov    0x8010bb48,%eax
80100a97:	c1 e0 07             	shl    $0x7,%eax
80100a9a:	89 c2                	mov    %eax,%edx
80100a9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100a9f:	01 d0                	add    %edx,%eax
80100aa1:	05 40 b6 10 80       	add    $0x8010b640,%eax
80100aa6:	0f b6 00             	movzbl (%eax),%eax
80100aa9:	0f be c0             	movsbl %al,%eax
80100aac:	89 45 e8             	mov    %eax,-0x18(%ebp)
          if(p != 0 && input.e-input.r < INPUT_BUF)
80100aaf:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100ab3:	74 35                	je     80100aea <consoleintr+0x319>
80100ab5:	8b 15 bc e3 10 80    	mov    0x8010e3bc,%edx
80100abb:	a1 b4 e3 10 80       	mov    0x8010e3b4,%eax
80100ac0:	29 c2                	sub    %eax,%edx
80100ac2:	89 d0                	mov    %edx,%eax
80100ac4:	83 f8 7f             	cmp    $0x7f,%eax
80100ac7:	77 21                	ja     80100aea <consoleintr+0x319>
              input.buf[input.e++ % INPUT_BUF] = p;
80100ac9:	a1 bc e3 10 80       	mov    0x8010e3bc,%eax
80100ace:	8d 50 01             	lea    0x1(%eax),%edx
80100ad1:	89 15 bc e3 10 80    	mov    %edx,0x8010e3bc
80100ad7:	83 e0 7f             	and    $0x7f,%eax
80100ada:	89 c2                	mov    %eax,%edx
80100adc:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100adf:	89 c1                	mov    %eax,%ecx
80100ae1:	8d 82 00 e3 10 80    	lea    -0x7fef1d00(%edx),%eax
80100ae7:	88 48 34             	mov    %cl,0x34(%eax)

          consputc(history[upCount][i]);
80100aea:	a1 48 bb 10 80       	mov    0x8010bb48,%eax
80100aef:	c1 e0 07             	shl    $0x7,%eax
80100af2:	89 c2                	mov    %eax,%edx
80100af4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100af7:	01 d0                	add    %edx,%eax
80100af9:	05 40 b6 10 80       	add    $0x8010b640,%eax
80100afe:	0f b6 00             	movzbl (%eax),%eax
80100b01:	0f be c0             	movsbl %al,%eax
80100b04:	83 ec 0c             	sub    $0xc,%esp
80100b07:	50                   	push   %eax
80100b08:	e8 5e fc ff ff       	call   8010076b <consputc>
80100b0d:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i<prevCount; i++){
          input.e--;
          consputc(BACKSPACE);
      }
      prevCount = strlen(history[upCount]);
      for(i = 0; i < strlen(history[upCount]); i++){
80100b10:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100b14:	a1 48 bb 10 80       	mov    0x8010bb48,%eax
80100b19:	c1 e0 07             	shl    $0x7,%eax
80100b1c:	05 40 b6 10 80       	add    $0x8010b640,%eax
80100b21:	83 ec 0c             	sub    $0xc,%esp
80100b24:	50                   	push   %eax
80100b25:	e8 47 48 00 00       	call   80105371 <strlen>
80100b2a:	83 c4 10             	add    $0x10,%esp
80100b2d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100b30:	0f 8f 5c ff ff ff    	jg     80100a92 <consoleintr+0x2c1>
              input.buf[input.e++ % INPUT_BUF] = p;

          consputc(history[upCount][i]);
      }

      break;
80100b36:	e9 50 01 00 00       	jmp    80100c8b <consoleintr+0x4ba>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100b3b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80100b3f:	0f 84 45 01 00 00    	je     80100c8a <consoleintr+0x4b9>
80100b45:	8b 15 bc e3 10 80    	mov    0x8010e3bc,%edx
80100b4b:	a1 b4 e3 10 80       	mov    0x8010e3b4,%eax
80100b50:	29 c2                	sub    %eax,%edx
80100b52:	89 d0                	mov    %edx,%eax
80100b54:	83 f8 7f             	cmp    $0x7f,%eax
80100b57:	0f 87 2d 01 00 00    	ja     80100c8a <consoleintr+0x4b9>
        c = (c == '\r') ? '\n' : c;
80100b5d:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
80100b61:	74 05                	je     80100b68 <consoleintr+0x397>
80100b63:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100b66:	eb 05                	jmp    80100b6d <consoleintr+0x39c>
80100b68:	b8 0a 00 00 00       	mov    $0xa,%eax
80100b6d:	89 45 ec             	mov    %eax,-0x14(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
80100b70:	a1 bc e3 10 80       	mov    0x8010e3bc,%eax
80100b75:	8d 50 01             	lea    0x1(%eax),%edx
80100b78:	89 15 bc e3 10 80    	mov    %edx,0x8010e3bc
80100b7e:	83 e0 7f             	and    $0x7f,%eax
80100b81:	89 c2                	mov    %eax,%edx
80100b83:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100b86:	89 c1                	mov    %eax,%ecx
80100b88:	8d 82 00 e3 10 80    	lea    -0x7fef1d00(%edx),%eax
80100b8e:	88 48 34             	mov    %cl,0x34(%eax)
        consputc(c);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	ff 75 ec             	pushl  -0x14(%ebp)
80100b97:	e8 cf fb ff ff       	call   8010076b <consputc>
80100b9c:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100b9f:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
80100ba3:	74 1c                	je     80100bc1 <consoleintr+0x3f0>
80100ba5:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
80100ba9:	74 16                	je     80100bc1 <consoleintr+0x3f0>
80100bab:	a1 bc e3 10 80       	mov    0x8010e3bc,%eax
80100bb0:	8b 15 b4 e3 10 80    	mov    0x8010e3b4,%edx
80100bb6:	83 ea 80             	sub    $0xffffff80,%edx
80100bb9:	39 d0                	cmp    %edx,%eax
80100bbb:	0f 85 c9 00 00 00    	jne    80100c8a <consoleintr+0x4b9>
          cmdCount++;
80100bc1:	a1 44 bb 10 80       	mov    0x8010bb44,%eax
80100bc6:	83 c0 01             	add    $0x1,%eax
80100bc9:	a3 44 bb 10 80       	mov    %eax,0x8010bb44
          prevCount = 0;
80100bce:	c7 05 4c bb 10 80 00 	movl   $0x0,0x8010bb4c
80100bd5:	00 00 00 
           if(input.e != input.w){
80100bd8:	8b 15 bc e3 10 80    	mov    0x8010e3bc,%edx
80100bde:	a1 b8 e3 10 80       	mov    0x8010e3b8,%eax
80100be3:	39 c2                	cmp    %eax,%edx
80100be5:	0f 84 85 00 00 00    	je     80100c70 <consoleintr+0x49f>
              int i;
              for(i = 0; i < (input.e + 128 - input.w) % 128; i++){
80100beb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80100bf2:	eb 33                	jmp    80100c27 <consoleintr+0x456>
                  history[historyIndex][i] = input.buf[(input.w +i) % 128];
80100bf4:	8b 15 40 bb 10 80    	mov    0x8010bb40,%edx
80100bfa:	8b 0d b8 e3 10 80    	mov    0x8010e3b8,%ecx
80100c00:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100c03:	01 c8                	add    %ecx,%eax
80100c05:	83 e0 7f             	and    $0x7f,%eax
80100c08:	05 00 e3 10 80       	add    $0x8010e300,%eax
80100c0d:	0f b6 40 34          	movzbl 0x34(%eax),%eax
80100c11:	89 d1                	mov    %edx,%ecx
80100c13:	c1 e1 07             	shl    $0x7,%ecx
80100c16:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100c19:	01 ca                	add    %ecx,%edx
80100c1b:	81 c2 40 b6 10 80    	add    $0x8010b640,%edx
80100c21:	88 02                	mov    %al,(%edx)
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          cmdCount++;
          prevCount = 0;
           if(input.e != input.w){
              int i;
              for(i = 0; i < (input.e + 128 - input.w) % 128; i++){
80100c23:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80100c27:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100c2a:	8b 0d bc e3 10 80    	mov    0x8010e3bc,%ecx
80100c30:	8b 15 b8 e3 10 80    	mov    0x8010e3b8,%edx
80100c36:	29 d1                	sub    %edx,%ecx
80100c38:	89 ca                	mov    %ecx,%edx
80100c3a:	83 e2 7f             	and    $0x7f,%edx
80100c3d:	39 d0                	cmp    %edx,%eax
80100c3f:	72 b3                	jb     80100bf4 <consoleintr+0x423>
                  history[historyIndex][i] = input.buf[(input.w +i) % 128];
              }
              history[historyIndex][i-1] = '\0';
80100c41:	a1 40 bb 10 80       	mov    0x8010bb40,%eax
80100c46:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100c49:	83 ea 01             	sub    $0x1,%edx
80100c4c:	c1 e0 07             	shl    $0x7,%eax
80100c4f:	01 d0                	add    %edx,%eax
80100c51:	05 40 b6 10 80       	add    $0x8010b640,%eax
80100c56:	c6 00 00             	movb   $0x0,(%eax)
              historyIndex++;
80100c59:	a1 40 bb 10 80       	mov    0x8010bb40,%eax
80100c5e:	83 c0 01             	add    $0x1,%eax
80100c61:	a3 40 bb 10 80       	mov    %eax,0x8010bb40
              upCount = historyIndex;
80100c66:	a1 40 bb 10 80       	mov    0x8010bb40,%eax
80100c6b:	a3 48 bb 10 80       	mov    %eax,0x8010bb48
          }
         
          input.w = input.e;
80100c70:	a1 bc e3 10 80       	mov    0x8010e3bc,%eax
80100c75:	a3 b8 e3 10 80       	mov    %eax,0x8010e3b8
          wakeup(&input.r);
80100c7a:	83 ec 0c             	sub    $0xc,%esp
80100c7d:	68 b4 e3 10 80       	push   $0x8010e3b4
80100c82:	e8 26 40 00 00       	call   80104cad <wakeup>
80100c87:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
80100c8a:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c;
  int p;
  acquire(&input.lock);
while((c = getc()) >= 0){
80100c8b:	8b 45 08             	mov    0x8(%ebp),%eax
80100c8e:	ff d0                	call   *%eax
80100c90:	89 45 ec             	mov    %eax,-0x14(%ebp)
80100c93:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80100c97:	0f 89 4f fb ff ff    	jns    801007ec <consoleintr+0x1b>
        }
      }
      break;
    }
  }
  release(&input.lock);
80100c9d:	83 ec 0c             	sub    $0xc,%esp
80100ca0:	68 00 e3 10 80       	push   $0x8010e300
80100ca5:	e8 82 42 00 00       	call   80104f2c <release>
80100caa:	83 c4 10             	add    $0x10,%esp
}
80100cad:	c9                   	leave  
80100cae:	c3                   	ret    

80100caf <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
80100caf:	55                   	push   %ebp
80100cb0:	89 e5                	mov    %esp,%ebp
80100cb2:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80100cb5:	83 ec 0c             	sub    $0xc,%esp
80100cb8:	ff 75 08             	pushl  0x8(%ebp)
80100cbb:	e8 b9 10 00 00       	call   80101d79 <iunlock>
80100cc0:	83 c4 10             	add    $0x10,%esp
  target = n;
80100cc3:	8b 45 10             	mov    0x10(%ebp),%eax
80100cc6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&input.lock);
80100cc9:	83 ec 0c             	sub    $0xc,%esp
80100ccc:	68 00 e3 10 80       	push   $0x8010e300
80100cd1:	e8 f0 41 00 00       	call   80104ec6 <acquire>
80100cd6:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
80100cd9:	e9 b4 00 00 00       	jmp    80100d92 <consoleread+0xe3>
    while(input.r == input.w){
80100cde:	eb 4a                	jmp    80100d2a <consoleread+0x7b>
      if(proc->killed){
80100ce0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ce6:	8b 40 24             	mov    0x24(%eax),%eax
80100ce9:	85 c0                	test   %eax,%eax
80100ceb:	74 28                	je     80100d15 <consoleread+0x66>
        release(&input.lock);
80100ced:	83 ec 0c             	sub    $0xc,%esp
80100cf0:	68 00 e3 10 80       	push   $0x8010e300
80100cf5:	e8 32 42 00 00       	call   80104f2c <release>
80100cfa:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
80100cfd:	83 ec 0c             	sub    $0xc,%esp
80100d00:	ff 75 08             	pushl  0x8(%ebp)
80100d03:	e8 1a 0f 00 00       	call   80101c22 <ilock>
80100d08:	83 c4 10             	add    $0x10,%esp
        return -1;
80100d0b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d10:	e9 af 00 00 00       	jmp    80100dc4 <consoleread+0x115>
      }
      sleep(&input.r, &input.lock);
80100d15:	83 ec 08             	sub    $0x8,%esp
80100d18:	68 00 e3 10 80       	push   $0x8010e300
80100d1d:	68 b4 e3 10 80       	push   $0x8010e3b4
80100d22:	e8 9d 3e 00 00       	call   80104bc4 <sleep>
80100d27:	83 c4 10             	add    $0x10,%esp

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
80100d2a:	8b 15 b4 e3 10 80    	mov    0x8010e3b4,%edx
80100d30:	a1 b8 e3 10 80       	mov    0x8010e3b8,%eax
80100d35:	39 c2                	cmp    %eax,%edx
80100d37:	74 a7                	je     80100ce0 <consoleread+0x31>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100d39:	a1 b4 e3 10 80       	mov    0x8010e3b4,%eax
80100d3e:	8d 50 01             	lea    0x1(%eax),%edx
80100d41:	89 15 b4 e3 10 80    	mov    %edx,0x8010e3b4
80100d47:	83 e0 7f             	and    $0x7f,%eax
80100d4a:	05 00 e3 10 80       	add    $0x8010e300,%eax
80100d4f:	0f b6 40 34          	movzbl 0x34(%eax),%eax
80100d53:	0f be c0             	movsbl %al,%eax
80100d56:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
80100d59:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100d5d:	75 19                	jne    80100d78 <consoleread+0xc9>
      if(n < target){
80100d5f:	8b 45 10             	mov    0x10(%ebp),%eax
80100d62:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100d65:	73 0f                	jae    80100d76 <consoleread+0xc7>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100d67:	a1 b4 e3 10 80       	mov    0x8010e3b4,%eax
80100d6c:	83 e8 01             	sub    $0x1,%eax
80100d6f:	a3 b4 e3 10 80       	mov    %eax,0x8010e3b4
      }
      break;
80100d74:	eb 26                	jmp    80100d9c <consoleread+0xed>
80100d76:	eb 24                	jmp    80100d9c <consoleread+0xed>
    }
    *dst++ = c;
80100d78:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d7b:	8d 50 01             	lea    0x1(%eax),%edx
80100d7e:	89 55 0c             	mov    %edx,0xc(%ebp)
80100d81:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100d84:	88 10                	mov    %dl,(%eax)
    --n;
80100d86:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100d8a:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100d8e:	75 02                	jne    80100d92 <consoleread+0xe3>
      break;
80100d90:	eb 0a                	jmp    80100d9c <consoleread+0xed>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
80100d92:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100d96:	0f 8f 42 ff ff ff    	jg     80100cde <consoleread+0x2f>
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&input.lock);
80100d9c:	83 ec 0c             	sub    $0xc,%esp
80100d9f:	68 00 e3 10 80       	push   $0x8010e300
80100da4:	e8 83 41 00 00       	call   80104f2c <release>
80100da9:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100dac:	83 ec 0c             	sub    $0xc,%esp
80100daf:	ff 75 08             	pushl  0x8(%ebp)
80100db2:	e8 6b 0e 00 00       	call   80101c22 <ilock>
80100db7:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100dba:	8b 45 10             	mov    0x10(%ebp),%eax
80100dbd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100dc0:	29 c2                	sub    %eax,%edx
80100dc2:	89 d0                	mov    %edx,%eax
}
80100dc4:	c9                   	leave  
80100dc5:	c3                   	ret    

80100dc6 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100dc6:	55                   	push   %ebp
80100dc7:	89 e5                	mov    %esp,%ebp
80100dc9:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100dcc:	83 ec 0c             	sub    $0xc,%esp
80100dcf:	ff 75 08             	pushl  0x8(%ebp)
80100dd2:	e8 a2 0f 00 00       	call   80101d79 <iunlock>
80100dd7:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100dda:	83 ec 0c             	sub    $0xc,%esp
80100ddd:	68 e0 b5 10 80       	push   $0x8010b5e0
80100de2:	e8 df 40 00 00       	call   80104ec6 <acquire>
80100de7:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100dea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100df1:	eb 21                	jmp    80100e14 <consolewrite+0x4e>
    consputc(buf[i] & 0xff);
80100df3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100df6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100df9:	01 d0                	add    %edx,%eax
80100dfb:	0f b6 00             	movzbl (%eax),%eax
80100dfe:	0f be c0             	movsbl %al,%eax
80100e01:	0f b6 c0             	movzbl %al,%eax
80100e04:	83 ec 0c             	sub    $0xc,%esp
80100e07:	50                   	push   %eax
80100e08:	e8 5e f9 ff ff       	call   8010076b <consputc>
80100e0d:	83 c4 10             	add    $0x10,%esp
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100e10:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100e14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e17:	3b 45 10             	cmp    0x10(%ebp),%eax
80100e1a:	7c d7                	jl     80100df3 <consolewrite+0x2d>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100e1c:	83 ec 0c             	sub    $0xc,%esp
80100e1f:	68 e0 b5 10 80       	push   $0x8010b5e0
80100e24:	e8 03 41 00 00       	call   80104f2c <release>
80100e29:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100e2c:	83 ec 0c             	sub    $0xc,%esp
80100e2f:	ff 75 08             	pushl  0x8(%ebp)
80100e32:	e8 eb 0d 00 00       	call   80101c22 <ilock>
80100e37:	83 c4 10             	add    $0x10,%esp

  return n;
80100e3a:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100e3d:	c9                   	leave  
80100e3e:	c3                   	ret    

80100e3f <consoleinit>:

void
consoleinit(void)
{
80100e3f:	55                   	push   %ebp
80100e40:	89 e5                	mov    %esp,%ebp
80100e42:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100e45:	83 ec 08             	sub    $0x8,%esp
80100e48:	68 0b 86 10 80       	push   $0x8010860b
80100e4d:	68 e0 b5 10 80       	push   $0x8010b5e0
80100e52:	e8 4e 40 00 00       	call   80104ea5 <initlock>
80100e57:	83 c4 10             	add    $0x10,%esp
  initlock(&input.lock, "input");
80100e5a:	83 ec 08             	sub    $0x8,%esp
80100e5d:	68 13 86 10 80       	push   $0x80108613
80100e62:	68 00 e3 10 80       	push   $0x8010e300
80100e67:	e8 39 40 00 00       	call   80104ea5 <initlock>
80100e6c:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100e6f:	c7 05 8c ed 10 80 c6 	movl   $0x80100dc6,0x8010ed8c
80100e76:	0d 10 80 
  devsw[CONSOLE].read = consoleread;
80100e79:	c7 05 88 ed 10 80 af 	movl   $0x80100caf,0x8010ed88
80100e80:	0c 10 80 
  cons.locking = 1;
80100e83:	c7 05 14 b6 10 80 01 	movl   $0x1,0x8010b614
80100e8a:	00 00 00 

  picenable(IRQ_KBD);
80100e8d:	83 ec 0c             	sub    $0xc,%esp
80100e90:	6a 01                	push   $0x1
80100e92:	e8 97 2f 00 00       	call   80103e2e <picenable>
80100e97:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80100e9a:	83 ec 08             	sub    $0x8,%esp
80100e9d:	6a 00                	push   $0x0
80100e9f:	6a 01                	push   $0x1
80100ea1:	e8 ac 1e 00 00       	call   80102d52 <ioapicenable>
80100ea6:	83 c4 10             	add    $0x10,%esp
}
80100ea9:	c9                   	leave  
80100eaa:	c3                   	ret    

80100eab <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100eab:	55                   	push   %ebp
80100eac:	89 e5                	mov    %esp,%ebp
80100eae:	81 ec 18 01 00 00    	sub    $0x118,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  if((ip = namei(path)) == 0)
80100eb4:	83 ec 0c             	sub    $0xc,%esp
80100eb7:	ff 75 08             	pushl  0x8(%ebp)
80100eba:	e8 26 19 00 00       	call   801027e5 <namei>
80100ebf:	83 c4 10             	add    $0x10,%esp
80100ec2:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100ec5:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100ec9:	75 0a                	jne    80100ed5 <exec+0x2a>
    return -1;
80100ecb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ed0:	e9 af 03 00 00       	jmp    80101284 <exec+0x3d9>
  ilock(ip);
80100ed5:	83 ec 0c             	sub    $0xc,%esp
80100ed8:	ff 75 d8             	pushl  -0x28(%ebp)
80100edb:	e8 42 0d 00 00       	call   80101c22 <ilock>
80100ee0:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100ee3:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100eea:	6a 34                	push   $0x34
80100eec:	6a 00                	push   $0x0
80100eee:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100ef4:	50                   	push   %eax
80100ef5:	ff 75 d8             	pushl  -0x28(%ebp)
80100ef8:	e8 87 12 00 00       	call   80102184 <readi>
80100efd:	83 c4 10             	add    $0x10,%esp
80100f00:	83 f8 33             	cmp    $0x33,%eax
80100f03:	77 05                	ja     80100f0a <exec+0x5f>
    goto bad;
80100f05:	e9 4d 03 00 00       	jmp    80101257 <exec+0x3ac>
  if(elf.magic != ELF_MAGIC)
80100f0a:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100f10:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100f15:	74 05                	je     80100f1c <exec+0x71>
    goto bad;
80100f17:	e9 3b 03 00 00       	jmp    80101257 <exec+0x3ac>

  if((pgdir = setupkvm()) == 0)
80100f1c:	e8 94 6e 00 00       	call   80107db5 <setupkvm>
80100f21:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100f24:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100f28:	75 05                	jne    80100f2f <exec+0x84>
    goto bad;
80100f2a:	e9 28 03 00 00       	jmp    80101257 <exec+0x3ac>

  // Load program into memory.
  sz = 0;
80100f2f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100f36:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100f3d:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100f43:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100f46:	e9 ae 00 00 00       	jmp    80100ff9 <exec+0x14e>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100f4b:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100f4e:	6a 20                	push   $0x20
80100f50:	50                   	push   %eax
80100f51:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100f57:	50                   	push   %eax
80100f58:	ff 75 d8             	pushl  -0x28(%ebp)
80100f5b:	e8 24 12 00 00       	call   80102184 <readi>
80100f60:	83 c4 10             	add    $0x10,%esp
80100f63:	83 f8 20             	cmp    $0x20,%eax
80100f66:	74 05                	je     80100f6d <exec+0xc2>
      goto bad;
80100f68:	e9 ea 02 00 00       	jmp    80101257 <exec+0x3ac>
    if(ph.type != ELF_PROG_LOAD)
80100f6d:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100f73:	83 f8 01             	cmp    $0x1,%eax
80100f76:	74 02                	je     80100f7a <exec+0xcf>
      continue;
80100f78:	eb 72                	jmp    80100fec <exec+0x141>
    if(ph.memsz < ph.filesz)
80100f7a:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100f80:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100f86:	39 c2                	cmp    %eax,%edx
80100f88:	73 05                	jae    80100f8f <exec+0xe4>
      goto bad;
80100f8a:	e9 c8 02 00 00       	jmp    80101257 <exec+0x3ac>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100f8f:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100f95:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100f9b:	01 d0                	add    %edx,%eax
80100f9d:	83 ec 04             	sub    $0x4,%esp
80100fa0:	50                   	push   %eax
80100fa1:	ff 75 e0             	pushl  -0x20(%ebp)
80100fa4:	ff 75 d4             	pushl  -0x2c(%ebp)
80100fa7:	e8 ac 71 00 00       	call   80108158 <allocuvm>
80100fac:	83 c4 10             	add    $0x10,%esp
80100faf:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100fb2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100fb6:	75 05                	jne    80100fbd <exec+0x112>
      goto bad;
80100fb8:	e9 9a 02 00 00       	jmp    80101257 <exec+0x3ac>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100fbd:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100fc3:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100fc9:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100fcf:	83 ec 0c             	sub    $0xc,%esp
80100fd2:	52                   	push   %edx
80100fd3:	50                   	push   %eax
80100fd4:	ff 75 d8             	pushl  -0x28(%ebp)
80100fd7:	51                   	push   %ecx
80100fd8:	ff 75 d4             	pushl  -0x2c(%ebp)
80100fdb:	e8 a1 70 00 00       	call   80108081 <loaduvm>
80100fe0:	83 c4 20             	add    $0x20,%esp
80100fe3:	85 c0                	test   %eax,%eax
80100fe5:	79 05                	jns    80100fec <exec+0x141>
      goto bad;
80100fe7:	e9 6b 02 00 00       	jmp    80101257 <exec+0x3ac>
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100fec:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100ff0:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100ff3:	83 c0 20             	add    $0x20,%eax
80100ff6:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100ff9:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80101000:	0f b7 c0             	movzwl %ax,%eax
80101003:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80101006:	0f 8f 3f ff ff ff    	jg     80100f4b <exec+0xa0>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
8010100c:	83 ec 0c             	sub    $0xc,%esp
8010100f:	ff 75 d8             	pushl  -0x28(%ebp)
80101012:	e8 c2 0e 00 00       	call   80101ed9 <iunlockput>
80101017:	83 c4 10             	add    $0x10,%esp
  ip = 0;
8010101a:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80101021:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101024:	05 ff 0f 00 00       	add    $0xfff,%eax
80101029:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010102e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101031:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101034:	05 00 20 00 00       	add    $0x2000,%eax
80101039:	83 ec 04             	sub    $0x4,%esp
8010103c:	50                   	push   %eax
8010103d:	ff 75 e0             	pushl  -0x20(%ebp)
80101040:	ff 75 d4             	pushl  -0x2c(%ebp)
80101043:	e8 10 71 00 00       	call   80108158 <allocuvm>
80101048:	83 c4 10             	add    $0x10,%esp
8010104b:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010104e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80101052:	75 05                	jne    80101059 <exec+0x1ae>
    goto bad;
80101054:	e9 fe 01 00 00       	jmp    80101257 <exec+0x3ac>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101059:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010105c:	2d 00 20 00 00       	sub    $0x2000,%eax
80101061:	83 ec 08             	sub    $0x8,%esp
80101064:	50                   	push   %eax
80101065:	ff 75 d4             	pushl  -0x2c(%ebp)
80101068:	e8 10 73 00 00       	call   8010837d <clearpteu>
8010106d:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80101070:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101073:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80101076:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010107d:	e9 98 00 00 00       	jmp    8010111a <exec+0x26f>
    if(argc >= MAXARG)
80101082:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80101086:	76 05                	jbe    8010108d <exec+0x1e2>
      goto bad;
80101088:	e9 ca 01 00 00       	jmp    80101257 <exec+0x3ac>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
8010108d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101090:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101097:	8b 45 0c             	mov    0xc(%ebp),%eax
8010109a:	01 d0                	add    %edx,%eax
8010109c:	8b 00                	mov    (%eax),%eax
8010109e:	83 ec 0c             	sub    $0xc,%esp
801010a1:	50                   	push   %eax
801010a2:	e8 ca 42 00 00       	call   80105371 <strlen>
801010a7:	83 c4 10             	add    $0x10,%esp
801010aa:	89 c2                	mov    %eax,%edx
801010ac:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010af:	29 d0                	sub    %edx,%eax
801010b1:	83 e8 01             	sub    $0x1,%eax
801010b4:	83 e0 fc             	and    $0xfffffffc,%eax
801010b7:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801010ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010bd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801010c4:	8b 45 0c             	mov    0xc(%ebp),%eax
801010c7:	01 d0                	add    %edx,%eax
801010c9:	8b 00                	mov    (%eax),%eax
801010cb:	83 ec 0c             	sub    $0xc,%esp
801010ce:	50                   	push   %eax
801010cf:	e8 9d 42 00 00       	call   80105371 <strlen>
801010d4:	83 c4 10             	add    $0x10,%esp
801010d7:	83 c0 01             	add    $0x1,%eax
801010da:	89 c1                	mov    %eax,%ecx
801010dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010df:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801010e6:	8b 45 0c             	mov    0xc(%ebp),%eax
801010e9:	01 d0                	add    %edx,%eax
801010eb:	8b 00                	mov    (%eax),%eax
801010ed:	51                   	push   %ecx
801010ee:	50                   	push   %eax
801010ef:	ff 75 dc             	pushl  -0x24(%ebp)
801010f2:	ff 75 d4             	pushl  -0x2c(%ebp)
801010f5:	e8 26 74 00 00       	call   80108520 <copyout>
801010fa:	83 c4 10             	add    $0x10,%esp
801010fd:	85 c0                	test   %eax,%eax
801010ff:	79 05                	jns    80101106 <exec+0x25b>
      goto bad;
80101101:	e9 51 01 00 00       	jmp    80101257 <exec+0x3ac>
    ustack[3+argc] = sp;
80101106:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101109:	8d 50 03             	lea    0x3(%eax),%edx
8010110c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010110f:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80101116:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010111a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010111d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101124:	8b 45 0c             	mov    0xc(%ebp),%eax
80101127:	01 d0                	add    %edx,%eax
80101129:	8b 00                	mov    (%eax),%eax
8010112b:	85 c0                	test   %eax,%eax
8010112d:	0f 85 4f ff ff ff    	jne    80101082 <exec+0x1d7>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80101133:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101136:	83 c0 03             	add    $0x3,%eax
80101139:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80101140:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80101144:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
8010114b:	ff ff ff 
  ustack[1] = argc;
8010114e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101151:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101157:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010115a:	83 c0 01             	add    $0x1,%eax
8010115d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101164:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101167:	29 d0                	sub    %edx,%eax
80101169:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
8010116f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101172:	83 c0 04             	add    $0x4,%eax
80101175:	c1 e0 02             	shl    $0x2,%eax
80101178:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
8010117b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010117e:	83 c0 04             	add    $0x4,%eax
80101181:	c1 e0 02             	shl    $0x2,%eax
80101184:	50                   	push   %eax
80101185:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
8010118b:	50                   	push   %eax
8010118c:	ff 75 dc             	pushl  -0x24(%ebp)
8010118f:	ff 75 d4             	pushl  -0x2c(%ebp)
80101192:	e8 89 73 00 00       	call   80108520 <copyout>
80101197:	83 c4 10             	add    $0x10,%esp
8010119a:	85 c0                	test   %eax,%eax
8010119c:	79 05                	jns    801011a3 <exec+0x2f8>
    goto bad;
8010119e:	e9 b4 00 00 00       	jmp    80101257 <exec+0x3ac>

  // Save program name for debugging.
  for(last=s=path; *s; s++)
801011a3:	8b 45 08             	mov    0x8(%ebp),%eax
801011a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801011a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
801011af:	eb 17                	jmp    801011c8 <exec+0x31d>
    if(*s == '/')
801011b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011b4:	0f b6 00             	movzbl (%eax),%eax
801011b7:	3c 2f                	cmp    $0x2f,%al
801011b9:	75 09                	jne    801011c4 <exec+0x319>
      last = s+1;
801011bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011be:	83 c0 01             	add    $0x1,%eax
801011c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
801011c4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801011c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011cb:	0f b6 00             	movzbl (%eax),%eax
801011ce:	84 c0                	test   %al,%al
801011d0:	75 df                	jne    801011b1 <exec+0x306>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
801011d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801011d8:	83 c0 6c             	add    $0x6c,%eax
801011db:	83 ec 04             	sub    $0x4,%esp
801011de:	6a 10                	push   $0x10
801011e0:	ff 75 f0             	pushl  -0x10(%ebp)
801011e3:	50                   	push   %eax
801011e4:	e8 3e 41 00 00       	call   80105327 <safestrcpy>
801011e9:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = proc->pgdir;
801011ec:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801011f2:	8b 40 04             	mov    0x4(%eax),%eax
801011f5:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
801011f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801011fe:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80101201:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80101204:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010120a:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010120d:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
8010120f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101215:	8b 40 18             	mov    0x18(%eax),%eax
80101218:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
8010121e:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80101221:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101227:	8b 40 18             	mov    0x18(%eax),%eax
8010122a:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010122d:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80101230:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101236:	83 ec 0c             	sub    $0xc,%esp
80101239:	50                   	push   %eax
8010123a:	e8 5b 6c 00 00       	call   80107e9a <switchuvm>
8010123f:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80101242:	83 ec 0c             	sub    $0xc,%esp
80101245:	ff 75 d0             	pushl  -0x30(%ebp)
80101248:	e8 91 70 00 00       	call   801082de <freevm>
8010124d:	83 c4 10             	add    $0x10,%esp
  return 0;
80101250:	b8 00 00 00 00       	mov    $0x0,%eax
80101255:	eb 2d                	jmp    80101284 <exec+0x3d9>

 bad:
  if(pgdir)
80101257:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
8010125b:	74 0e                	je     8010126b <exec+0x3c0>
    freevm(pgdir);
8010125d:	83 ec 0c             	sub    $0xc,%esp
80101260:	ff 75 d4             	pushl  -0x2c(%ebp)
80101263:	e8 76 70 00 00       	call   801082de <freevm>
80101268:	83 c4 10             	add    $0x10,%esp
  if(ip)
8010126b:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
8010126f:	74 0e                	je     8010127f <exec+0x3d4>
    iunlockput(ip);
80101271:	83 ec 0c             	sub    $0xc,%esp
80101274:	ff 75 d8             	pushl  -0x28(%ebp)
80101277:	e8 5d 0c 00 00       	call   80101ed9 <iunlockput>
8010127c:	83 c4 10             	add    $0x10,%esp
  return -1;
8010127f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101284:	c9                   	leave  
80101285:	c3                   	ret    

80101286 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101286:	55                   	push   %ebp
80101287:	89 e5                	mov    %esp,%ebp
80101289:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
8010128c:	83 ec 08             	sub    $0x8,%esp
8010128f:	68 19 86 10 80       	push   $0x80108619
80101294:	68 c0 e3 10 80       	push   $0x8010e3c0
80101299:	e8 07 3c 00 00       	call   80104ea5 <initlock>
8010129e:	83 c4 10             	add    $0x10,%esp
}
801012a1:	c9                   	leave  
801012a2:	c3                   	ret    

801012a3 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801012a3:	55                   	push   %ebp
801012a4:	89 e5                	mov    %esp,%ebp
801012a6:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
801012a9:	83 ec 0c             	sub    $0xc,%esp
801012ac:	68 c0 e3 10 80       	push   $0x8010e3c0
801012b1:	e8 10 3c 00 00       	call   80104ec6 <acquire>
801012b6:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801012b9:	c7 45 f4 f4 e3 10 80 	movl   $0x8010e3f4,-0xc(%ebp)
801012c0:	eb 2d                	jmp    801012ef <filealloc+0x4c>
    if(f->ref == 0){
801012c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012c5:	8b 40 04             	mov    0x4(%eax),%eax
801012c8:	85 c0                	test   %eax,%eax
801012ca:	75 1f                	jne    801012eb <filealloc+0x48>
      f->ref = 1;
801012cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012cf:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
801012d6:	83 ec 0c             	sub    $0xc,%esp
801012d9:	68 c0 e3 10 80       	push   $0x8010e3c0
801012de:	e8 49 3c 00 00       	call   80104f2c <release>
801012e3:	83 c4 10             	add    $0x10,%esp
      return f;
801012e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012e9:	eb 22                	jmp    8010130d <filealloc+0x6a>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801012eb:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
801012ef:	81 7d f4 54 ed 10 80 	cmpl   $0x8010ed54,-0xc(%ebp)
801012f6:	72 ca                	jb     801012c2 <filealloc+0x1f>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
801012f8:	83 ec 0c             	sub    $0xc,%esp
801012fb:	68 c0 e3 10 80       	push   $0x8010e3c0
80101300:	e8 27 3c 00 00       	call   80104f2c <release>
80101305:	83 c4 10             	add    $0x10,%esp
  return 0;
80101308:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010130d:	c9                   	leave  
8010130e:	c3                   	ret    

8010130f <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
8010130f:	55                   	push   %ebp
80101310:	89 e5                	mov    %esp,%ebp
80101312:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
80101315:	83 ec 0c             	sub    $0xc,%esp
80101318:	68 c0 e3 10 80       	push   $0x8010e3c0
8010131d:	e8 a4 3b 00 00       	call   80104ec6 <acquire>
80101322:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101325:	8b 45 08             	mov    0x8(%ebp),%eax
80101328:	8b 40 04             	mov    0x4(%eax),%eax
8010132b:	85 c0                	test   %eax,%eax
8010132d:	7f 0d                	jg     8010133c <filedup+0x2d>
    panic("filedup");
8010132f:	83 ec 0c             	sub    $0xc,%esp
80101332:	68 20 86 10 80       	push   $0x80108620
80101337:	e8 20 f2 ff ff       	call   8010055c <panic>
  f->ref++;
8010133c:	8b 45 08             	mov    0x8(%ebp),%eax
8010133f:	8b 40 04             	mov    0x4(%eax),%eax
80101342:	8d 50 01             	lea    0x1(%eax),%edx
80101345:	8b 45 08             	mov    0x8(%ebp),%eax
80101348:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
8010134b:	83 ec 0c             	sub    $0xc,%esp
8010134e:	68 c0 e3 10 80       	push   $0x8010e3c0
80101353:	e8 d4 3b 00 00       	call   80104f2c <release>
80101358:	83 c4 10             	add    $0x10,%esp
  return f;
8010135b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010135e:	c9                   	leave  
8010135f:	c3                   	ret    

80101360 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101360:	55                   	push   %ebp
80101361:	89 e5                	mov    %esp,%ebp
80101363:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  acquire(&ftable.lock);
80101366:	83 ec 0c             	sub    $0xc,%esp
80101369:	68 c0 e3 10 80       	push   $0x8010e3c0
8010136e:	e8 53 3b 00 00       	call   80104ec6 <acquire>
80101373:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101376:	8b 45 08             	mov    0x8(%ebp),%eax
80101379:	8b 40 04             	mov    0x4(%eax),%eax
8010137c:	85 c0                	test   %eax,%eax
8010137e:	7f 0d                	jg     8010138d <fileclose+0x2d>
    panic("fileclose");
80101380:	83 ec 0c             	sub    $0xc,%esp
80101383:	68 28 86 10 80       	push   $0x80108628
80101388:	e8 cf f1 ff ff       	call   8010055c <panic>
  if(--f->ref > 0){
8010138d:	8b 45 08             	mov    0x8(%ebp),%eax
80101390:	8b 40 04             	mov    0x4(%eax),%eax
80101393:	8d 50 ff             	lea    -0x1(%eax),%edx
80101396:	8b 45 08             	mov    0x8(%ebp),%eax
80101399:	89 50 04             	mov    %edx,0x4(%eax)
8010139c:	8b 45 08             	mov    0x8(%ebp),%eax
8010139f:	8b 40 04             	mov    0x4(%eax),%eax
801013a2:	85 c0                	test   %eax,%eax
801013a4:	7e 15                	jle    801013bb <fileclose+0x5b>
    release(&ftable.lock);
801013a6:	83 ec 0c             	sub    $0xc,%esp
801013a9:	68 c0 e3 10 80       	push   $0x8010e3c0
801013ae:	e8 79 3b 00 00       	call   80104f2c <release>
801013b3:	83 c4 10             	add    $0x10,%esp
801013b6:	e9 8b 00 00 00       	jmp    80101446 <fileclose+0xe6>
    return;
  }
  ff = *f;
801013bb:	8b 45 08             	mov    0x8(%ebp),%eax
801013be:	8b 10                	mov    (%eax),%edx
801013c0:	89 55 e0             	mov    %edx,-0x20(%ebp)
801013c3:	8b 50 04             	mov    0x4(%eax),%edx
801013c6:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013c9:	8b 50 08             	mov    0x8(%eax),%edx
801013cc:	89 55 e8             	mov    %edx,-0x18(%ebp)
801013cf:	8b 50 0c             	mov    0xc(%eax),%edx
801013d2:	89 55 ec             	mov    %edx,-0x14(%ebp)
801013d5:	8b 50 10             	mov    0x10(%eax),%edx
801013d8:	89 55 f0             	mov    %edx,-0x10(%ebp)
801013db:	8b 40 14             	mov    0x14(%eax),%eax
801013de:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
801013e1:	8b 45 08             	mov    0x8(%ebp),%eax
801013e4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
801013eb:	8b 45 08             	mov    0x8(%ebp),%eax
801013ee:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
801013f4:	83 ec 0c             	sub    $0xc,%esp
801013f7:	68 c0 e3 10 80       	push   $0x8010e3c0
801013fc:	e8 2b 3b 00 00       	call   80104f2c <release>
80101401:	83 c4 10             	add    $0x10,%esp
  
  if(ff.type == FD_PIPE)
80101404:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101407:	83 f8 01             	cmp    $0x1,%eax
8010140a:	75 19                	jne    80101425 <fileclose+0xc5>
    pipeclose(ff.pipe, ff.writable);
8010140c:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
80101410:	0f be d0             	movsbl %al,%edx
80101413:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101416:	83 ec 08             	sub    $0x8,%esp
80101419:	52                   	push   %edx
8010141a:	50                   	push   %eax
8010141b:	e8 75 2c 00 00       	call   80104095 <pipeclose>
80101420:	83 c4 10             	add    $0x10,%esp
80101423:	eb 21                	jmp    80101446 <fileclose+0xe6>
  else if(ff.type == FD_INODE){
80101425:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101428:	83 f8 02             	cmp    $0x2,%eax
8010142b:	75 19                	jne    80101446 <fileclose+0xe6>
    begin_trans();
8010142d:	e8 64 21 00 00       	call   80103596 <begin_trans>
    iput(ff.ip);
80101432:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101435:	83 ec 0c             	sub    $0xc,%esp
80101438:	50                   	push   %eax
80101439:	e8 ac 09 00 00       	call   80101dea <iput>
8010143e:	83 c4 10             	add    $0x10,%esp
    commit_trans();
80101441:	e8 a2 21 00 00       	call   801035e8 <commit_trans>
  }
}
80101446:	c9                   	leave  
80101447:	c3                   	ret    

80101448 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101448:	55                   	push   %ebp
80101449:	89 e5                	mov    %esp,%ebp
8010144b:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
8010144e:	8b 45 08             	mov    0x8(%ebp),%eax
80101451:	8b 00                	mov    (%eax),%eax
80101453:	83 f8 02             	cmp    $0x2,%eax
80101456:	75 40                	jne    80101498 <filestat+0x50>
    ilock(f->ip);
80101458:	8b 45 08             	mov    0x8(%ebp),%eax
8010145b:	8b 40 10             	mov    0x10(%eax),%eax
8010145e:	83 ec 0c             	sub    $0xc,%esp
80101461:	50                   	push   %eax
80101462:	e8 bb 07 00 00       	call   80101c22 <ilock>
80101467:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
8010146a:	8b 45 08             	mov    0x8(%ebp),%eax
8010146d:	8b 40 10             	mov    0x10(%eax),%eax
80101470:	83 ec 08             	sub    $0x8,%esp
80101473:	ff 75 0c             	pushl  0xc(%ebp)
80101476:	50                   	push   %eax
80101477:	e8 c3 0c 00 00       	call   8010213f <stati>
8010147c:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
8010147f:	8b 45 08             	mov    0x8(%ebp),%eax
80101482:	8b 40 10             	mov    0x10(%eax),%eax
80101485:	83 ec 0c             	sub    $0xc,%esp
80101488:	50                   	push   %eax
80101489:	e8 eb 08 00 00       	call   80101d79 <iunlock>
8010148e:	83 c4 10             	add    $0x10,%esp
    return 0;
80101491:	b8 00 00 00 00       	mov    $0x0,%eax
80101496:	eb 05                	jmp    8010149d <filestat+0x55>
  }
  return -1;
80101498:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010149d:	c9                   	leave  
8010149e:	c3                   	ret    

8010149f <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
8010149f:	55                   	push   %ebp
801014a0:	89 e5                	mov    %esp,%ebp
801014a2:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
801014a5:	8b 45 08             	mov    0x8(%ebp),%eax
801014a8:	0f b6 40 08          	movzbl 0x8(%eax),%eax
801014ac:	84 c0                	test   %al,%al
801014ae:	75 0a                	jne    801014ba <fileread+0x1b>
    return -1;
801014b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801014b5:	e9 9b 00 00 00       	jmp    80101555 <fileread+0xb6>
  if(f->type == FD_PIPE)
801014ba:	8b 45 08             	mov    0x8(%ebp),%eax
801014bd:	8b 00                	mov    (%eax),%eax
801014bf:	83 f8 01             	cmp    $0x1,%eax
801014c2:	75 1a                	jne    801014de <fileread+0x3f>
    return piperead(f->pipe, addr, n);
801014c4:	8b 45 08             	mov    0x8(%ebp),%eax
801014c7:	8b 40 0c             	mov    0xc(%eax),%eax
801014ca:	83 ec 04             	sub    $0x4,%esp
801014cd:	ff 75 10             	pushl  0x10(%ebp)
801014d0:	ff 75 0c             	pushl  0xc(%ebp)
801014d3:	50                   	push   %eax
801014d4:	e8 69 2d 00 00       	call   80104242 <piperead>
801014d9:	83 c4 10             	add    $0x10,%esp
801014dc:	eb 77                	jmp    80101555 <fileread+0xb6>
  if(f->type == FD_INODE){
801014de:	8b 45 08             	mov    0x8(%ebp),%eax
801014e1:	8b 00                	mov    (%eax),%eax
801014e3:	83 f8 02             	cmp    $0x2,%eax
801014e6:	75 60                	jne    80101548 <fileread+0xa9>
    ilock(f->ip);
801014e8:	8b 45 08             	mov    0x8(%ebp),%eax
801014eb:	8b 40 10             	mov    0x10(%eax),%eax
801014ee:	83 ec 0c             	sub    $0xc,%esp
801014f1:	50                   	push   %eax
801014f2:	e8 2b 07 00 00       	call   80101c22 <ilock>
801014f7:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801014fa:	8b 4d 10             	mov    0x10(%ebp),%ecx
801014fd:	8b 45 08             	mov    0x8(%ebp),%eax
80101500:	8b 50 14             	mov    0x14(%eax),%edx
80101503:	8b 45 08             	mov    0x8(%ebp),%eax
80101506:	8b 40 10             	mov    0x10(%eax),%eax
80101509:	51                   	push   %ecx
8010150a:	52                   	push   %edx
8010150b:	ff 75 0c             	pushl  0xc(%ebp)
8010150e:	50                   	push   %eax
8010150f:	e8 70 0c 00 00       	call   80102184 <readi>
80101514:	83 c4 10             	add    $0x10,%esp
80101517:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010151a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010151e:	7e 11                	jle    80101531 <fileread+0x92>
      f->off += r;
80101520:	8b 45 08             	mov    0x8(%ebp),%eax
80101523:	8b 50 14             	mov    0x14(%eax),%edx
80101526:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101529:	01 c2                	add    %eax,%edx
8010152b:	8b 45 08             	mov    0x8(%ebp),%eax
8010152e:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
80101531:	8b 45 08             	mov    0x8(%ebp),%eax
80101534:	8b 40 10             	mov    0x10(%eax),%eax
80101537:	83 ec 0c             	sub    $0xc,%esp
8010153a:	50                   	push   %eax
8010153b:	e8 39 08 00 00       	call   80101d79 <iunlock>
80101540:	83 c4 10             	add    $0x10,%esp
    return r;
80101543:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101546:	eb 0d                	jmp    80101555 <fileread+0xb6>
  }
  panic("fileread");
80101548:	83 ec 0c             	sub    $0xc,%esp
8010154b:	68 32 86 10 80       	push   $0x80108632
80101550:	e8 07 f0 ff ff       	call   8010055c <panic>
}
80101555:	c9                   	leave  
80101556:	c3                   	ret    

80101557 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101557:	55                   	push   %ebp
80101558:	89 e5                	mov    %esp,%ebp
8010155a:	53                   	push   %ebx
8010155b:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
8010155e:	8b 45 08             	mov    0x8(%ebp),%eax
80101561:	0f b6 40 09          	movzbl 0x9(%eax),%eax
80101565:	84 c0                	test   %al,%al
80101567:	75 0a                	jne    80101573 <filewrite+0x1c>
    return -1;
80101569:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010156e:	e9 1a 01 00 00       	jmp    8010168d <filewrite+0x136>
  if(f->type == FD_PIPE)
80101573:	8b 45 08             	mov    0x8(%ebp),%eax
80101576:	8b 00                	mov    (%eax),%eax
80101578:	83 f8 01             	cmp    $0x1,%eax
8010157b:	75 1d                	jne    8010159a <filewrite+0x43>
    return pipewrite(f->pipe, addr, n);
8010157d:	8b 45 08             	mov    0x8(%ebp),%eax
80101580:	8b 40 0c             	mov    0xc(%eax),%eax
80101583:	83 ec 04             	sub    $0x4,%esp
80101586:	ff 75 10             	pushl  0x10(%ebp)
80101589:	ff 75 0c             	pushl  0xc(%ebp)
8010158c:	50                   	push   %eax
8010158d:	e8 ac 2b 00 00       	call   8010413e <pipewrite>
80101592:	83 c4 10             	add    $0x10,%esp
80101595:	e9 f3 00 00 00       	jmp    8010168d <filewrite+0x136>
  if(f->type == FD_INODE){
8010159a:	8b 45 08             	mov    0x8(%ebp),%eax
8010159d:	8b 00                	mov    (%eax),%eax
8010159f:	83 f8 02             	cmp    $0x2,%eax
801015a2:	0f 85 d8 00 00 00    	jne    80101680 <filewrite+0x129>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
801015a8:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
801015af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
801015b6:	e9 a5 00 00 00       	jmp    80101660 <filewrite+0x109>
      int n1 = n - i;
801015bb:	8b 45 10             	mov    0x10(%ebp),%eax
801015be:	2b 45 f4             	sub    -0xc(%ebp),%eax
801015c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
801015c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015c7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801015ca:	7e 06                	jle    801015d2 <filewrite+0x7b>
        n1 = max;
801015cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
801015cf:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_trans();
801015d2:	e8 bf 1f 00 00       	call   80103596 <begin_trans>
      ilock(f->ip);
801015d7:	8b 45 08             	mov    0x8(%ebp),%eax
801015da:	8b 40 10             	mov    0x10(%eax),%eax
801015dd:	83 ec 0c             	sub    $0xc,%esp
801015e0:	50                   	push   %eax
801015e1:	e8 3c 06 00 00       	call   80101c22 <ilock>
801015e6:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801015e9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801015ec:	8b 45 08             	mov    0x8(%ebp),%eax
801015ef:	8b 50 14             	mov    0x14(%eax),%edx
801015f2:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801015f5:	8b 45 0c             	mov    0xc(%ebp),%eax
801015f8:	01 c3                	add    %eax,%ebx
801015fa:	8b 45 08             	mov    0x8(%ebp),%eax
801015fd:	8b 40 10             	mov    0x10(%eax),%eax
80101600:	51                   	push   %ecx
80101601:	52                   	push   %edx
80101602:	53                   	push   %ebx
80101603:	50                   	push   %eax
80101604:	e8 dc 0c 00 00       	call   801022e5 <writei>
80101609:	83 c4 10             	add    $0x10,%esp
8010160c:	89 45 e8             	mov    %eax,-0x18(%ebp)
8010160f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101613:	7e 11                	jle    80101626 <filewrite+0xcf>
        f->off += r;
80101615:	8b 45 08             	mov    0x8(%ebp),%eax
80101618:	8b 50 14             	mov    0x14(%eax),%edx
8010161b:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010161e:	01 c2                	add    %eax,%edx
80101620:	8b 45 08             	mov    0x8(%ebp),%eax
80101623:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
80101626:	8b 45 08             	mov    0x8(%ebp),%eax
80101629:	8b 40 10             	mov    0x10(%eax),%eax
8010162c:	83 ec 0c             	sub    $0xc,%esp
8010162f:	50                   	push   %eax
80101630:	e8 44 07 00 00       	call   80101d79 <iunlock>
80101635:	83 c4 10             	add    $0x10,%esp
      commit_trans();
80101638:	e8 ab 1f 00 00       	call   801035e8 <commit_trans>

      if(r < 0)
8010163d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101641:	79 02                	jns    80101645 <filewrite+0xee>
        break;
80101643:	eb 27                	jmp    8010166c <filewrite+0x115>
      if(r != n1)
80101645:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101648:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010164b:	74 0d                	je     8010165a <filewrite+0x103>
        panic("short filewrite");
8010164d:	83 ec 0c             	sub    $0xc,%esp
80101650:	68 3b 86 10 80       	push   $0x8010863b
80101655:	e8 02 ef ff ff       	call   8010055c <panic>
      i += r;
8010165a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010165d:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101660:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101663:	3b 45 10             	cmp    0x10(%ebp),%eax
80101666:	0f 8c 4f ff ff ff    	jl     801015bb <filewrite+0x64>
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
8010166c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010166f:	3b 45 10             	cmp    0x10(%ebp),%eax
80101672:	75 05                	jne    80101679 <filewrite+0x122>
80101674:	8b 45 10             	mov    0x10(%ebp),%eax
80101677:	eb 14                	jmp    8010168d <filewrite+0x136>
80101679:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010167e:	eb 0d                	jmp    8010168d <filewrite+0x136>
  }
  panic("filewrite");
80101680:	83 ec 0c             	sub    $0xc,%esp
80101683:	68 4b 86 10 80       	push   $0x8010864b
80101688:	e8 cf ee ff ff       	call   8010055c <panic>
}
8010168d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101690:	c9                   	leave  
80101691:	c3                   	ret    

80101692 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101692:	55                   	push   %ebp
80101693:	89 e5                	mov    %esp,%ebp
80101695:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
80101698:	8b 45 08             	mov    0x8(%ebp),%eax
8010169b:	83 ec 08             	sub    $0x8,%esp
8010169e:	6a 01                	push   $0x1
801016a0:	50                   	push   %eax
801016a1:	e8 0e eb ff ff       	call   801001b4 <bread>
801016a6:	83 c4 10             	add    $0x10,%esp
801016a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
801016ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016af:	83 c0 18             	add    $0x18,%eax
801016b2:	83 ec 04             	sub    $0x4,%esp
801016b5:	6a 10                	push   $0x10
801016b7:	50                   	push   %eax
801016b8:	ff 75 0c             	pushl  0xc(%ebp)
801016bb:	e8 21 3b 00 00       	call   801051e1 <memmove>
801016c0:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801016c3:	83 ec 0c             	sub    $0xc,%esp
801016c6:	ff 75 f4             	pushl  -0xc(%ebp)
801016c9:	e8 5d eb ff ff       	call   8010022b <brelse>
801016ce:	83 c4 10             	add    $0x10,%esp
}
801016d1:	c9                   	leave  
801016d2:	c3                   	ret    

801016d3 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
801016d3:	55                   	push   %ebp
801016d4:	89 e5                	mov    %esp,%ebp
801016d6:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
801016d9:	8b 55 0c             	mov    0xc(%ebp),%edx
801016dc:	8b 45 08             	mov    0x8(%ebp),%eax
801016df:	83 ec 08             	sub    $0x8,%esp
801016e2:	52                   	push   %edx
801016e3:	50                   	push   %eax
801016e4:	e8 cb ea ff ff       	call   801001b4 <bread>
801016e9:	83 c4 10             	add    $0x10,%esp
801016ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
801016ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016f2:	83 c0 18             	add    $0x18,%eax
801016f5:	83 ec 04             	sub    $0x4,%esp
801016f8:	68 00 02 00 00       	push   $0x200
801016fd:	6a 00                	push   $0x0
801016ff:	50                   	push   %eax
80101700:	e8 1d 3a 00 00       	call   80105122 <memset>
80101705:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
80101708:	83 ec 0c             	sub    $0xc,%esp
8010170b:	ff 75 f4             	pushl  -0xc(%ebp)
8010170e:	e8 39 1f 00 00       	call   8010364c <log_write>
80101713:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101716:	83 ec 0c             	sub    $0xc,%esp
80101719:	ff 75 f4             	pushl  -0xc(%ebp)
8010171c:	e8 0a eb ff ff       	call   8010022b <brelse>
80101721:	83 c4 10             	add    $0x10,%esp
}
80101724:	c9                   	leave  
80101725:	c3                   	ret    

80101726 <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101726:	55                   	push   %ebp
80101727:	89 e5                	mov    %esp,%ebp
80101729:	83 ec 28             	sub    $0x28,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
8010172c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  readsb(dev, &sb);
80101733:	8b 45 08             	mov    0x8(%ebp),%eax
80101736:	83 ec 08             	sub    $0x8,%esp
80101739:	8d 55 d8             	lea    -0x28(%ebp),%edx
8010173c:	52                   	push   %edx
8010173d:	50                   	push   %eax
8010173e:	e8 4f ff ff ff       	call   80101692 <readsb>
80101743:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
80101746:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010174d:	e9 0c 01 00 00       	jmp    8010185e <balloc+0x138>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
80101752:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101755:	99                   	cltd   
80101756:	c1 ea 14             	shr    $0x14,%edx
80101759:	01 d0                	add    %edx,%eax
8010175b:	c1 f8 0c             	sar    $0xc,%eax
8010175e:	89 c2                	mov    %eax,%edx
80101760:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101763:	c1 e8 03             	shr    $0x3,%eax
80101766:	01 d0                	add    %edx,%eax
80101768:	83 c0 03             	add    $0x3,%eax
8010176b:	83 ec 08             	sub    $0x8,%esp
8010176e:	50                   	push   %eax
8010176f:	ff 75 08             	pushl  0x8(%ebp)
80101772:	e8 3d ea ff ff       	call   801001b4 <bread>
80101777:	83 c4 10             	add    $0x10,%esp
8010177a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010177d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101784:	e9 a2 00 00 00       	jmp    8010182b <balloc+0x105>
      m = 1 << (bi % 8);
80101789:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010178c:	99                   	cltd   
8010178d:	c1 ea 1d             	shr    $0x1d,%edx
80101790:	01 d0                	add    %edx,%eax
80101792:	83 e0 07             	and    $0x7,%eax
80101795:	29 d0                	sub    %edx,%eax
80101797:	ba 01 00 00 00       	mov    $0x1,%edx
8010179c:	89 c1                	mov    %eax,%ecx
8010179e:	d3 e2                	shl    %cl,%edx
801017a0:	89 d0                	mov    %edx,%eax
801017a2:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801017a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017a8:	99                   	cltd   
801017a9:	c1 ea 1d             	shr    $0x1d,%edx
801017ac:	01 d0                	add    %edx,%eax
801017ae:	c1 f8 03             	sar    $0x3,%eax
801017b1:	89 c2                	mov    %eax,%edx
801017b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801017b6:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
801017bb:	0f b6 c0             	movzbl %al,%eax
801017be:	23 45 e8             	and    -0x18(%ebp),%eax
801017c1:	85 c0                	test   %eax,%eax
801017c3:	75 62                	jne    80101827 <balloc+0x101>
        bp->data[bi/8] |= m;  // Mark block in use.
801017c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017c8:	99                   	cltd   
801017c9:	c1 ea 1d             	shr    $0x1d,%edx
801017cc:	01 d0                	add    %edx,%eax
801017ce:	c1 f8 03             	sar    $0x3,%eax
801017d1:	8b 55 ec             	mov    -0x14(%ebp),%edx
801017d4:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801017d9:	89 d1                	mov    %edx,%ecx
801017db:	8b 55 e8             	mov    -0x18(%ebp),%edx
801017de:	09 ca                	or     %ecx,%edx
801017e0:	89 d1                	mov    %edx,%ecx
801017e2:	8b 55 ec             	mov    -0x14(%ebp),%edx
801017e5:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
801017e9:	83 ec 0c             	sub    $0xc,%esp
801017ec:	ff 75 ec             	pushl  -0x14(%ebp)
801017ef:	e8 58 1e 00 00       	call   8010364c <log_write>
801017f4:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
801017f7:	83 ec 0c             	sub    $0xc,%esp
801017fa:	ff 75 ec             	pushl  -0x14(%ebp)
801017fd:	e8 29 ea ff ff       	call   8010022b <brelse>
80101802:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
80101805:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101808:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010180b:	01 c2                	add    %eax,%edx
8010180d:	8b 45 08             	mov    0x8(%ebp),%eax
80101810:	83 ec 08             	sub    $0x8,%esp
80101813:	52                   	push   %edx
80101814:	50                   	push   %eax
80101815:	e8 b9 fe ff ff       	call   801016d3 <bzero>
8010181a:	83 c4 10             	add    $0x10,%esp
        return b + bi;
8010181d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101820:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101823:	01 d0                	add    %edx,%eax
80101825:	eb 52                	jmp    80101879 <balloc+0x153>

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101827:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010182b:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
80101832:	7f 15                	jg     80101849 <balloc+0x123>
80101834:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101837:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010183a:	01 d0                	add    %edx,%eax
8010183c:	89 c2                	mov    %eax,%edx
8010183e:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101841:	39 c2                	cmp    %eax,%edx
80101843:	0f 82 40 ff ff ff    	jb     80101789 <balloc+0x63>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101849:	83 ec 0c             	sub    $0xc,%esp
8010184c:	ff 75 ec             	pushl  -0x14(%ebp)
8010184f:	e8 d7 e9 ff ff       	call   8010022b <brelse>
80101854:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
80101857:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010185e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101861:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101864:	39 c2                	cmp    %eax,%edx
80101866:	0f 82 e6 fe ff ff    	jb     80101752 <balloc+0x2c>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010186c:	83 ec 0c             	sub    $0xc,%esp
8010186f:	68 55 86 10 80       	push   $0x80108655
80101874:	e8 e3 ec ff ff       	call   8010055c <panic>
}
80101879:	c9                   	leave  
8010187a:	c3                   	ret    

8010187b <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
8010187b:	55                   	push   %ebp
8010187c:	89 e5                	mov    %esp,%ebp
8010187e:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  readsb(dev, &sb);
80101881:	83 ec 08             	sub    $0x8,%esp
80101884:	8d 45 dc             	lea    -0x24(%ebp),%eax
80101887:	50                   	push   %eax
80101888:	ff 75 08             	pushl  0x8(%ebp)
8010188b:	e8 02 fe ff ff       	call   80101692 <readsb>
80101890:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb.ninodes));
80101893:	8b 45 0c             	mov    0xc(%ebp),%eax
80101896:	c1 e8 0c             	shr    $0xc,%eax
80101899:	89 c2                	mov    %eax,%edx
8010189b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010189e:	c1 e8 03             	shr    $0x3,%eax
801018a1:	01 d0                	add    %edx,%eax
801018a3:	8d 50 03             	lea    0x3(%eax),%edx
801018a6:	8b 45 08             	mov    0x8(%ebp),%eax
801018a9:	83 ec 08             	sub    $0x8,%esp
801018ac:	52                   	push   %edx
801018ad:	50                   	push   %eax
801018ae:	e8 01 e9 ff ff       	call   801001b4 <bread>
801018b3:	83 c4 10             	add    $0x10,%esp
801018b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
801018b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801018bc:	25 ff 0f 00 00       	and    $0xfff,%eax
801018c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
801018c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018c7:	99                   	cltd   
801018c8:	c1 ea 1d             	shr    $0x1d,%edx
801018cb:	01 d0                	add    %edx,%eax
801018cd:	83 e0 07             	and    $0x7,%eax
801018d0:	29 d0                	sub    %edx,%eax
801018d2:	ba 01 00 00 00       	mov    $0x1,%edx
801018d7:	89 c1                	mov    %eax,%ecx
801018d9:	d3 e2                	shl    %cl,%edx
801018db:	89 d0                	mov    %edx,%eax
801018dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
801018e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018e3:	99                   	cltd   
801018e4:	c1 ea 1d             	shr    $0x1d,%edx
801018e7:	01 d0                	add    %edx,%eax
801018e9:	c1 f8 03             	sar    $0x3,%eax
801018ec:	89 c2                	mov    %eax,%edx
801018ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018f1:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
801018f6:	0f b6 c0             	movzbl %al,%eax
801018f9:	23 45 ec             	and    -0x14(%ebp),%eax
801018fc:	85 c0                	test   %eax,%eax
801018fe:	75 0d                	jne    8010190d <bfree+0x92>
    panic("freeing free block");
80101900:	83 ec 0c             	sub    $0xc,%esp
80101903:	68 6b 86 10 80       	push   $0x8010866b
80101908:	e8 4f ec ff ff       	call   8010055c <panic>
  bp->data[bi/8] &= ~m;
8010190d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101910:	99                   	cltd   
80101911:	c1 ea 1d             	shr    $0x1d,%edx
80101914:	01 d0                	add    %edx,%eax
80101916:	c1 f8 03             	sar    $0x3,%eax
80101919:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010191c:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101921:	89 d1                	mov    %edx,%ecx
80101923:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101926:	f7 d2                	not    %edx
80101928:	21 ca                	and    %ecx,%edx
8010192a:	89 d1                	mov    %edx,%ecx
8010192c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010192f:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
80101933:	83 ec 0c             	sub    $0xc,%esp
80101936:	ff 75 f4             	pushl  -0xc(%ebp)
80101939:	e8 0e 1d 00 00       	call   8010364c <log_write>
8010193e:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101941:	83 ec 0c             	sub    $0xc,%esp
80101944:	ff 75 f4             	pushl  -0xc(%ebp)
80101947:	e8 df e8 ff ff       	call   8010022b <brelse>
8010194c:	83 c4 10             	add    $0x10,%esp
}
8010194f:	c9                   	leave  
80101950:	c3                   	ret    

80101951 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
80101951:	55                   	push   %ebp
80101952:	89 e5                	mov    %esp,%ebp
80101954:	83 ec 08             	sub    $0x8,%esp
  initlock(&icache.lock, "icache");
80101957:	83 ec 08             	sub    $0x8,%esp
8010195a:	68 7e 86 10 80       	push   $0x8010867e
8010195f:	68 00 ee 10 80       	push   $0x8010ee00
80101964:	e8 3c 35 00 00       	call   80104ea5 <initlock>
80101969:	83 c4 10             	add    $0x10,%esp
}
8010196c:	c9                   	leave  
8010196d:	c3                   	ret    

8010196e <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
8010196e:	55                   	push   %ebp
8010196f:	89 e5                	mov    %esp,%ebp
80101971:	83 ec 38             	sub    $0x38,%esp
80101974:	8b 45 0c             	mov    0xc(%ebp),%eax
80101977:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
8010197b:	8b 45 08             	mov    0x8(%ebp),%eax
8010197e:	83 ec 08             	sub    $0x8,%esp
80101981:	8d 55 dc             	lea    -0x24(%ebp),%edx
80101984:	52                   	push   %edx
80101985:	50                   	push   %eax
80101986:	e8 07 fd ff ff       	call   80101692 <readsb>
8010198b:	83 c4 10             	add    $0x10,%esp

  for(inum = 1; inum < sb.ninodes; inum++){
8010198e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80101995:	e9 98 00 00 00       	jmp    80101a32 <ialloc+0xc4>
    bp = bread(dev, IBLOCK(inum));
8010199a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010199d:	c1 e8 03             	shr    $0x3,%eax
801019a0:	83 c0 02             	add    $0x2,%eax
801019a3:	83 ec 08             	sub    $0x8,%esp
801019a6:	50                   	push   %eax
801019a7:	ff 75 08             	pushl  0x8(%ebp)
801019aa:	e8 05 e8 ff ff       	call   801001b4 <bread>
801019af:	83 c4 10             	add    $0x10,%esp
801019b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
801019b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019b8:	8d 50 18             	lea    0x18(%eax),%edx
801019bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019be:	83 e0 07             	and    $0x7,%eax
801019c1:	c1 e0 06             	shl    $0x6,%eax
801019c4:	01 d0                	add    %edx,%eax
801019c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
801019c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801019cc:	0f b7 00             	movzwl (%eax),%eax
801019cf:	66 85 c0             	test   %ax,%ax
801019d2:	75 4c                	jne    80101a20 <ialloc+0xb2>
      memset(dip, 0, sizeof(*dip));
801019d4:	83 ec 04             	sub    $0x4,%esp
801019d7:	6a 40                	push   $0x40
801019d9:	6a 00                	push   $0x0
801019db:	ff 75 ec             	pushl  -0x14(%ebp)
801019de:	e8 3f 37 00 00       	call   80105122 <memset>
801019e3:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
801019e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801019e9:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
801019ed:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
801019f0:	83 ec 0c             	sub    $0xc,%esp
801019f3:	ff 75 f0             	pushl  -0x10(%ebp)
801019f6:	e8 51 1c 00 00       	call   8010364c <log_write>
801019fb:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
801019fe:	83 ec 0c             	sub    $0xc,%esp
80101a01:	ff 75 f0             	pushl  -0x10(%ebp)
80101a04:	e8 22 e8 ff ff       	call   8010022b <brelse>
80101a09:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
80101a0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a0f:	83 ec 08             	sub    $0x8,%esp
80101a12:	50                   	push   %eax
80101a13:	ff 75 08             	pushl  0x8(%ebp)
80101a16:	e8 ee 00 00 00       	call   80101b09 <iget>
80101a1b:	83 c4 10             	add    $0x10,%esp
80101a1e:	eb 2d                	jmp    80101a4d <ialloc+0xdf>
    }
    brelse(bp);
80101a20:	83 ec 0c             	sub    $0xc,%esp
80101a23:	ff 75 f0             	pushl  -0x10(%ebp)
80101a26:	e8 00 e8 ff ff       	call   8010022b <brelse>
80101a2b:	83 c4 10             	add    $0x10,%esp
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
80101a2e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101a32:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101a35:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101a38:	39 c2                	cmp    %eax,%edx
80101a3a:	0f 82 5a ff ff ff    	jb     8010199a <ialloc+0x2c>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101a40:	83 ec 0c             	sub    $0xc,%esp
80101a43:	68 85 86 10 80       	push   $0x80108685
80101a48:	e8 0f eb ff ff       	call   8010055c <panic>
}
80101a4d:	c9                   	leave  
80101a4e:	c3                   	ret    

80101a4f <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80101a4f:	55                   	push   %ebp
80101a50:	89 e5                	mov    %esp,%ebp
80101a52:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
80101a55:	8b 45 08             	mov    0x8(%ebp),%eax
80101a58:	8b 40 04             	mov    0x4(%eax),%eax
80101a5b:	c1 e8 03             	shr    $0x3,%eax
80101a5e:	8d 50 02             	lea    0x2(%eax),%edx
80101a61:	8b 45 08             	mov    0x8(%ebp),%eax
80101a64:	8b 00                	mov    (%eax),%eax
80101a66:	83 ec 08             	sub    $0x8,%esp
80101a69:	52                   	push   %edx
80101a6a:	50                   	push   %eax
80101a6b:	e8 44 e7 ff ff       	call   801001b4 <bread>
80101a70:	83 c4 10             	add    $0x10,%esp
80101a73:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a79:	8d 50 18             	lea    0x18(%eax),%edx
80101a7c:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7f:	8b 40 04             	mov    0x4(%eax),%eax
80101a82:	83 e0 07             	and    $0x7,%eax
80101a85:	c1 e0 06             	shl    $0x6,%eax
80101a88:	01 d0                	add    %edx,%eax
80101a8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
80101a8d:	8b 45 08             	mov    0x8(%ebp),%eax
80101a90:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101a94:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a97:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101a9a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9d:	0f b7 50 12          	movzwl 0x12(%eax),%edx
80101aa1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101aa4:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
80101aa8:	8b 45 08             	mov    0x8(%ebp),%eax
80101aab:	0f b7 50 14          	movzwl 0x14(%eax),%edx
80101aaf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ab2:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101ab6:	8b 45 08             	mov    0x8(%ebp),%eax
80101ab9:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101abd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ac0:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101ac4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac7:	8b 50 18             	mov    0x18(%eax),%edx
80101aca:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101acd:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101ad0:	8b 45 08             	mov    0x8(%ebp),%eax
80101ad3:	8d 50 1c             	lea    0x1c(%eax),%edx
80101ad6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ad9:	83 c0 0c             	add    $0xc,%eax
80101adc:	83 ec 04             	sub    $0x4,%esp
80101adf:	6a 34                	push   $0x34
80101ae1:	52                   	push   %edx
80101ae2:	50                   	push   %eax
80101ae3:	e8 f9 36 00 00       	call   801051e1 <memmove>
80101ae8:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
80101aeb:	83 ec 0c             	sub    $0xc,%esp
80101aee:	ff 75 f4             	pushl  -0xc(%ebp)
80101af1:	e8 56 1b 00 00       	call   8010364c <log_write>
80101af6:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101af9:	83 ec 0c             	sub    $0xc,%esp
80101afc:	ff 75 f4             	pushl  -0xc(%ebp)
80101aff:	e8 27 e7 ff ff       	call   8010022b <brelse>
80101b04:	83 c4 10             	add    $0x10,%esp
}
80101b07:	c9                   	leave  
80101b08:	c3                   	ret    

80101b09 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101b09:	55                   	push   %ebp
80101b0a:	89 e5                	mov    %esp,%ebp
80101b0c:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101b0f:	83 ec 0c             	sub    $0xc,%esp
80101b12:	68 00 ee 10 80       	push   $0x8010ee00
80101b17:	e8 aa 33 00 00       	call   80104ec6 <acquire>
80101b1c:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
80101b1f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101b26:	c7 45 f4 34 ee 10 80 	movl   $0x8010ee34,-0xc(%ebp)
80101b2d:	eb 5d                	jmp    80101b8c <iget+0x83>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101b2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b32:	8b 40 08             	mov    0x8(%eax),%eax
80101b35:	85 c0                	test   %eax,%eax
80101b37:	7e 39                	jle    80101b72 <iget+0x69>
80101b39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b3c:	8b 00                	mov    (%eax),%eax
80101b3e:	3b 45 08             	cmp    0x8(%ebp),%eax
80101b41:	75 2f                	jne    80101b72 <iget+0x69>
80101b43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b46:	8b 40 04             	mov    0x4(%eax),%eax
80101b49:	3b 45 0c             	cmp    0xc(%ebp),%eax
80101b4c:	75 24                	jne    80101b72 <iget+0x69>
      ip->ref++;
80101b4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b51:	8b 40 08             	mov    0x8(%eax),%eax
80101b54:	8d 50 01             	lea    0x1(%eax),%edx
80101b57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b5a:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101b5d:	83 ec 0c             	sub    $0xc,%esp
80101b60:	68 00 ee 10 80       	push   $0x8010ee00
80101b65:	e8 c2 33 00 00       	call   80104f2c <release>
80101b6a:	83 c4 10             	add    $0x10,%esp
      return ip;
80101b6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b70:	eb 74                	jmp    80101be6 <iget+0xdd>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101b72:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101b76:	75 10                	jne    80101b88 <iget+0x7f>
80101b78:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b7b:	8b 40 08             	mov    0x8(%eax),%eax
80101b7e:	85 c0                	test   %eax,%eax
80101b80:	75 06                	jne    80101b88 <iget+0x7f>
      empty = ip;
80101b82:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b85:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101b88:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
80101b8c:	81 7d f4 d4 fd 10 80 	cmpl   $0x8010fdd4,-0xc(%ebp)
80101b93:	72 9a                	jb     80101b2f <iget+0x26>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101b95:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101b99:	75 0d                	jne    80101ba8 <iget+0x9f>
    panic("iget: no inodes");
80101b9b:	83 ec 0c             	sub    $0xc,%esp
80101b9e:	68 97 86 10 80       	push   $0x80108697
80101ba3:	e8 b4 e9 ff ff       	call   8010055c <panic>

  ip = empty;
80101ba8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101bab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
80101bae:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101bb1:	8b 55 08             	mov    0x8(%ebp),%edx
80101bb4:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
80101bb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101bb9:	8b 55 0c             	mov    0xc(%ebp),%edx
80101bbc:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
80101bbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101bc2:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
80101bc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101bcc:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
80101bd3:	83 ec 0c             	sub    $0xc,%esp
80101bd6:	68 00 ee 10 80       	push   $0x8010ee00
80101bdb:	e8 4c 33 00 00       	call   80104f2c <release>
80101be0:	83 c4 10             	add    $0x10,%esp

  return ip;
80101be3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80101be6:	c9                   	leave  
80101be7:	c3                   	ret    

80101be8 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101be8:	55                   	push   %ebp
80101be9:	89 e5                	mov    %esp,%ebp
80101beb:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101bee:	83 ec 0c             	sub    $0xc,%esp
80101bf1:	68 00 ee 10 80       	push   $0x8010ee00
80101bf6:	e8 cb 32 00 00       	call   80104ec6 <acquire>
80101bfb:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
80101bfe:	8b 45 08             	mov    0x8(%ebp),%eax
80101c01:	8b 40 08             	mov    0x8(%eax),%eax
80101c04:	8d 50 01             	lea    0x1(%eax),%edx
80101c07:	8b 45 08             	mov    0x8(%ebp),%eax
80101c0a:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101c0d:	83 ec 0c             	sub    $0xc,%esp
80101c10:	68 00 ee 10 80       	push   $0x8010ee00
80101c15:	e8 12 33 00 00       	call   80104f2c <release>
80101c1a:	83 c4 10             	add    $0x10,%esp
  return ip;
80101c1d:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101c20:	c9                   	leave  
80101c21:	c3                   	ret    

80101c22 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101c22:	55                   	push   %ebp
80101c23:	89 e5                	mov    %esp,%ebp
80101c25:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101c28:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101c2c:	74 0a                	je     80101c38 <ilock+0x16>
80101c2e:	8b 45 08             	mov    0x8(%ebp),%eax
80101c31:	8b 40 08             	mov    0x8(%eax),%eax
80101c34:	85 c0                	test   %eax,%eax
80101c36:	7f 0d                	jg     80101c45 <ilock+0x23>
    panic("ilock");
80101c38:	83 ec 0c             	sub    $0xc,%esp
80101c3b:	68 a7 86 10 80       	push   $0x801086a7
80101c40:	e8 17 e9 ff ff       	call   8010055c <panic>

  acquire(&icache.lock);
80101c45:	83 ec 0c             	sub    $0xc,%esp
80101c48:	68 00 ee 10 80       	push   $0x8010ee00
80101c4d:	e8 74 32 00 00       	call   80104ec6 <acquire>
80101c52:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
80101c55:	eb 13                	jmp    80101c6a <ilock+0x48>
    sleep(ip, &icache.lock);
80101c57:	83 ec 08             	sub    $0x8,%esp
80101c5a:	68 00 ee 10 80       	push   $0x8010ee00
80101c5f:	ff 75 08             	pushl  0x8(%ebp)
80101c62:	e8 5d 2f 00 00       	call   80104bc4 <sleep>
80101c67:	83 c4 10             	add    $0x10,%esp

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
80101c6a:	8b 45 08             	mov    0x8(%ebp),%eax
80101c6d:	8b 40 0c             	mov    0xc(%eax),%eax
80101c70:	83 e0 01             	and    $0x1,%eax
80101c73:	85 c0                	test   %eax,%eax
80101c75:	75 e0                	jne    80101c57 <ilock+0x35>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
80101c77:	8b 45 08             	mov    0x8(%ebp),%eax
80101c7a:	8b 40 0c             	mov    0xc(%eax),%eax
80101c7d:	83 c8 01             	or     $0x1,%eax
80101c80:	89 c2                	mov    %eax,%edx
80101c82:	8b 45 08             	mov    0x8(%ebp),%eax
80101c85:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
80101c88:	83 ec 0c             	sub    $0xc,%esp
80101c8b:	68 00 ee 10 80       	push   $0x8010ee00
80101c90:	e8 97 32 00 00       	call   80104f2c <release>
80101c95:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
80101c98:	8b 45 08             	mov    0x8(%ebp),%eax
80101c9b:	8b 40 0c             	mov    0xc(%eax),%eax
80101c9e:	83 e0 02             	and    $0x2,%eax
80101ca1:	85 c0                	test   %eax,%eax
80101ca3:	0f 85 ce 00 00 00    	jne    80101d77 <ilock+0x155>
    bp = bread(ip->dev, IBLOCK(ip->inum));
80101ca9:	8b 45 08             	mov    0x8(%ebp),%eax
80101cac:	8b 40 04             	mov    0x4(%eax),%eax
80101caf:	c1 e8 03             	shr    $0x3,%eax
80101cb2:	8d 50 02             	lea    0x2(%eax),%edx
80101cb5:	8b 45 08             	mov    0x8(%ebp),%eax
80101cb8:	8b 00                	mov    (%eax),%eax
80101cba:	83 ec 08             	sub    $0x8,%esp
80101cbd:	52                   	push   %edx
80101cbe:	50                   	push   %eax
80101cbf:	e8 f0 e4 ff ff       	call   801001b4 <bread>
80101cc4:	83 c4 10             	add    $0x10,%esp
80101cc7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101cca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ccd:	8d 50 18             	lea    0x18(%eax),%edx
80101cd0:	8b 45 08             	mov    0x8(%ebp),%eax
80101cd3:	8b 40 04             	mov    0x4(%eax),%eax
80101cd6:	83 e0 07             	and    $0x7,%eax
80101cd9:	c1 e0 06             	shl    $0x6,%eax
80101cdc:	01 d0                	add    %edx,%eax
80101cde:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101ce1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ce4:	0f b7 10             	movzwl (%eax),%edx
80101ce7:	8b 45 08             	mov    0x8(%ebp),%eax
80101cea:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
80101cee:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cf1:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101cf5:	8b 45 08             	mov    0x8(%ebp),%eax
80101cf8:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
80101cfc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cff:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101d03:	8b 45 08             	mov    0x8(%ebp),%eax
80101d06:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
80101d0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d0d:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101d11:	8b 45 08             	mov    0x8(%ebp),%eax
80101d14:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
80101d18:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d1b:	8b 50 08             	mov    0x8(%eax),%edx
80101d1e:	8b 45 08             	mov    0x8(%ebp),%eax
80101d21:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101d24:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d27:	8d 50 0c             	lea    0xc(%eax),%edx
80101d2a:	8b 45 08             	mov    0x8(%ebp),%eax
80101d2d:	83 c0 1c             	add    $0x1c,%eax
80101d30:	83 ec 04             	sub    $0x4,%esp
80101d33:	6a 34                	push   $0x34
80101d35:	52                   	push   %edx
80101d36:	50                   	push   %eax
80101d37:	e8 a5 34 00 00       	call   801051e1 <memmove>
80101d3c:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101d3f:	83 ec 0c             	sub    $0xc,%esp
80101d42:	ff 75 f4             	pushl  -0xc(%ebp)
80101d45:	e8 e1 e4 ff ff       	call   8010022b <brelse>
80101d4a:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
80101d4d:	8b 45 08             	mov    0x8(%ebp),%eax
80101d50:	8b 40 0c             	mov    0xc(%eax),%eax
80101d53:	83 c8 02             	or     $0x2,%eax
80101d56:	89 c2                	mov    %eax,%edx
80101d58:	8b 45 08             	mov    0x8(%ebp),%eax
80101d5b:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80101d5e:	8b 45 08             	mov    0x8(%ebp),%eax
80101d61:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101d65:	66 85 c0             	test   %ax,%ax
80101d68:	75 0d                	jne    80101d77 <ilock+0x155>
      panic("ilock: no type");
80101d6a:	83 ec 0c             	sub    $0xc,%esp
80101d6d:	68 ad 86 10 80       	push   $0x801086ad
80101d72:	e8 e5 e7 ff ff       	call   8010055c <panic>
  }
}
80101d77:	c9                   	leave  
80101d78:	c3                   	ret    

80101d79 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101d79:	55                   	push   %ebp
80101d7a:	89 e5                	mov    %esp,%ebp
80101d7c:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80101d7f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101d83:	74 17                	je     80101d9c <iunlock+0x23>
80101d85:	8b 45 08             	mov    0x8(%ebp),%eax
80101d88:	8b 40 0c             	mov    0xc(%eax),%eax
80101d8b:	83 e0 01             	and    $0x1,%eax
80101d8e:	85 c0                	test   %eax,%eax
80101d90:	74 0a                	je     80101d9c <iunlock+0x23>
80101d92:	8b 45 08             	mov    0x8(%ebp),%eax
80101d95:	8b 40 08             	mov    0x8(%eax),%eax
80101d98:	85 c0                	test   %eax,%eax
80101d9a:	7f 0d                	jg     80101da9 <iunlock+0x30>
    panic("iunlock");
80101d9c:	83 ec 0c             	sub    $0xc,%esp
80101d9f:	68 bc 86 10 80       	push   $0x801086bc
80101da4:	e8 b3 e7 ff ff       	call   8010055c <panic>

  acquire(&icache.lock);
80101da9:	83 ec 0c             	sub    $0xc,%esp
80101dac:	68 00 ee 10 80       	push   $0x8010ee00
80101db1:	e8 10 31 00 00       	call   80104ec6 <acquire>
80101db6:	83 c4 10             	add    $0x10,%esp
  ip->flags &= ~I_BUSY;
80101db9:	8b 45 08             	mov    0x8(%ebp),%eax
80101dbc:	8b 40 0c             	mov    0xc(%eax),%eax
80101dbf:	83 e0 fe             	and    $0xfffffffe,%eax
80101dc2:	89 c2                	mov    %eax,%edx
80101dc4:	8b 45 08             	mov    0x8(%ebp),%eax
80101dc7:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101dca:	83 ec 0c             	sub    $0xc,%esp
80101dcd:	ff 75 08             	pushl  0x8(%ebp)
80101dd0:	e8 d8 2e 00 00       	call   80104cad <wakeup>
80101dd5:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80101dd8:	83 ec 0c             	sub    $0xc,%esp
80101ddb:	68 00 ee 10 80       	push   $0x8010ee00
80101de0:	e8 47 31 00 00       	call   80104f2c <release>
80101de5:	83 c4 10             	add    $0x10,%esp
}
80101de8:	c9                   	leave  
80101de9:	c3                   	ret    

80101dea <iput>:
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void
iput(struct inode *ip)
{
80101dea:	55                   	push   %ebp
80101deb:	89 e5                	mov    %esp,%ebp
80101ded:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101df0:	83 ec 0c             	sub    $0xc,%esp
80101df3:	68 00 ee 10 80       	push   $0x8010ee00
80101df8:	e8 c9 30 00 00       	call   80104ec6 <acquire>
80101dfd:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101e00:	8b 45 08             	mov    0x8(%ebp),%eax
80101e03:	8b 40 08             	mov    0x8(%eax),%eax
80101e06:	83 f8 01             	cmp    $0x1,%eax
80101e09:	0f 85 a9 00 00 00    	jne    80101eb8 <iput+0xce>
80101e0f:	8b 45 08             	mov    0x8(%ebp),%eax
80101e12:	8b 40 0c             	mov    0xc(%eax),%eax
80101e15:	83 e0 02             	and    $0x2,%eax
80101e18:	85 c0                	test   %eax,%eax
80101e1a:	0f 84 98 00 00 00    	je     80101eb8 <iput+0xce>
80101e20:	8b 45 08             	mov    0x8(%ebp),%eax
80101e23:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101e27:	66 85 c0             	test   %ax,%ax
80101e2a:	0f 85 88 00 00 00    	jne    80101eb8 <iput+0xce>
    // inode has no links: truncate and free inode.
    if(ip->flags & I_BUSY)
80101e30:	8b 45 08             	mov    0x8(%ebp),%eax
80101e33:	8b 40 0c             	mov    0xc(%eax),%eax
80101e36:	83 e0 01             	and    $0x1,%eax
80101e39:	85 c0                	test   %eax,%eax
80101e3b:	74 0d                	je     80101e4a <iput+0x60>
      panic("iput busy");
80101e3d:	83 ec 0c             	sub    $0xc,%esp
80101e40:	68 c4 86 10 80       	push   $0x801086c4
80101e45:	e8 12 e7 ff ff       	call   8010055c <panic>
    ip->flags |= I_BUSY;
80101e4a:	8b 45 08             	mov    0x8(%ebp),%eax
80101e4d:	8b 40 0c             	mov    0xc(%eax),%eax
80101e50:	83 c8 01             	or     $0x1,%eax
80101e53:	89 c2                	mov    %eax,%edx
80101e55:	8b 45 08             	mov    0x8(%ebp),%eax
80101e58:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101e5b:	83 ec 0c             	sub    $0xc,%esp
80101e5e:	68 00 ee 10 80       	push   $0x8010ee00
80101e63:	e8 c4 30 00 00       	call   80104f2c <release>
80101e68:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
80101e6b:	83 ec 0c             	sub    $0xc,%esp
80101e6e:	ff 75 08             	pushl  0x8(%ebp)
80101e71:	e8 a6 01 00 00       	call   8010201c <itrunc>
80101e76:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
80101e79:	8b 45 08             	mov    0x8(%ebp),%eax
80101e7c:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101e82:	83 ec 0c             	sub    $0xc,%esp
80101e85:	ff 75 08             	pushl  0x8(%ebp)
80101e88:	e8 c2 fb ff ff       	call   80101a4f <iupdate>
80101e8d:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
80101e90:	83 ec 0c             	sub    $0xc,%esp
80101e93:	68 00 ee 10 80       	push   $0x8010ee00
80101e98:	e8 29 30 00 00       	call   80104ec6 <acquire>
80101e9d:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101ea0:	8b 45 08             	mov    0x8(%ebp),%eax
80101ea3:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101eaa:	83 ec 0c             	sub    $0xc,%esp
80101ead:	ff 75 08             	pushl  0x8(%ebp)
80101eb0:	e8 f8 2d 00 00       	call   80104cad <wakeup>
80101eb5:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
80101eb8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ebb:	8b 40 08             	mov    0x8(%eax),%eax
80101ebe:	8d 50 ff             	lea    -0x1(%eax),%edx
80101ec1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ec4:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101ec7:	83 ec 0c             	sub    $0xc,%esp
80101eca:	68 00 ee 10 80       	push   $0x8010ee00
80101ecf:	e8 58 30 00 00       	call   80104f2c <release>
80101ed4:	83 c4 10             	add    $0x10,%esp
}
80101ed7:	c9                   	leave  
80101ed8:	c3                   	ret    

80101ed9 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101ed9:	55                   	push   %ebp
80101eda:	89 e5                	mov    %esp,%ebp
80101edc:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101edf:	83 ec 0c             	sub    $0xc,%esp
80101ee2:	ff 75 08             	pushl  0x8(%ebp)
80101ee5:	e8 8f fe ff ff       	call   80101d79 <iunlock>
80101eea:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101eed:	83 ec 0c             	sub    $0xc,%esp
80101ef0:	ff 75 08             	pushl  0x8(%ebp)
80101ef3:	e8 f2 fe ff ff       	call   80101dea <iput>
80101ef8:	83 c4 10             	add    $0x10,%esp
}
80101efb:	c9                   	leave  
80101efc:	c3                   	ret    

80101efd <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101efd:	55                   	push   %ebp
80101efe:	89 e5                	mov    %esp,%ebp
80101f00:	53                   	push   %ebx
80101f01:	83 ec 14             	sub    $0x14,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101f04:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101f08:	77 42                	ja     80101f4c <bmap+0x4f>
    if((addr = ip->addrs[bn]) == 0)
80101f0a:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0d:	8b 55 0c             	mov    0xc(%ebp),%edx
80101f10:	83 c2 04             	add    $0x4,%edx
80101f13:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101f17:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101f1a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101f1e:	75 24                	jne    80101f44 <bmap+0x47>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101f20:	8b 45 08             	mov    0x8(%ebp),%eax
80101f23:	8b 00                	mov    (%eax),%eax
80101f25:	83 ec 0c             	sub    $0xc,%esp
80101f28:	50                   	push   %eax
80101f29:	e8 f8 f7 ff ff       	call   80101726 <balloc>
80101f2e:	83 c4 10             	add    $0x10,%esp
80101f31:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101f34:	8b 45 08             	mov    0x8(%ebp),%eax
80101f37:	8b 55 0c             	mov    0xc(%ebp),%edx
80101f3a:	8d 4a 04             	lea    0x4(%edx),%ecx
80101f3d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101f40:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101f44:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f47:	e9 cb 00 00 00       	jmp    80102017 <bmap+0x11a>
  }
  bn -= NDIRECT;
80101f4c:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101f50:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101f54:	0f 87 b0 00 00 00    	ja     8010200a <bmap+0x10d>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101f5a:	8b 45 08             	mov    0x8(%ebp),%eax
80101f5d:	8b 40 4c             	mov    0x4c(%eax),%eax
80101f60:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101f63:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101f67:	75 1d                	jne    80101f86 <bmap+0x89>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101f69:	8b 45 08             	mov    0x8(%ebp),%eax
80101f6c:	8b 00                	mov    (%eax),%eax
80101f6e:	83 ec 0c             	sub    $0xc,%esp
80101f71:	50                   	push   %eax
80101f72:	e8 af f7 ff ff       	call   80101726 <balloc>
80101f77:	83 c4 10             	add    $0x10,%esp
80101f7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101f7d:	8b 45 08             	mov    0x8(%ebp),%eax
80101f80:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101f83:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80101f86:	8b 45 08             	mov    0x8(%ebp),%eax
80101f89:	8b 00                	mov    (%eax),%eax
80101f8b:	83 ec 08             	sub    $0x8,%esp
80101f8e:	ff 75 f4             	pushl  -0xc(%ebp)
80101f91:	50                   	push   %eax
80101f92:	e8 1d e2 ff ff       	call   801001b4 <bread>
80101f97:	83 c4 10             	add    $0x10,%esp
80101f9a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101f9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101fa0:	83 c0 18             	add    $0x18,%eax
80101fa3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101fa6:	8b 45 0c             	mov    0xc(%ebp),%eax
80101fa9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101fb0:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fb3:	01 d0                	add    %edx,%eax
80101fb5:	8b 00                	mov    (%eax),%eax
80101fb7:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101fba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101fbe:	75 37                	jne    80101ff7 <bmap+0xfa>
      a[bn] = addr = balloc(ip->dev);
80101fc0:	8b 45 0c             	mov    0xc(%ebp),%eax
80101fc3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101fca:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fcd:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101fd0:	8b 45 08             	mov    0x8(%ebp),%eax
80101fd3:	8b 00                	mov    (%eax),%eax
80101fd5:	83 ec 0c             	sub    $0xc,%esp
80101fd8:	50                   	push   %eax
80101fd9:	e8 48 f7 ff ff       	call   80101726 <balloc>
80101fde:	83 c4 10             	add    $0x10,%esp
80101fe1:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101fe4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101fe7:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101fe9:	83 ec 0c             	sub    $0xc,%esp
80101fec:	ff 75 f0             	pushl  -0x10(%ebp)
80101fef:	e8 58 16 00 00       	call   8010364c <log_write>
80101ff4:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101ff7:	83 ec 0c             	sub    $0xc,%esp
80101ffa:	ff 75 f0             	pushl  -0x10(%ebp)
80101ffd:	e8 29 e2 ff ff       	call   8010022b <brelse>
80102002:	83 c4 10             	add    $0x10,%esp
    return addr;
80102005:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102008:	eb 0d                	jmp    80102017 <bmap+0x11a>
  }

  panic("bmap: out of range");
8010200a:	83 ec 0c             	sub    $0xc,%esp
8010200d:	68 ce 86 10 80       	push   $0x801086ce
80102012:	e8 45 e5 ff ff       	call   8010055c <panic>
}
80102017:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010201a:	c9                   	leave  
8010201b:	c3                   	ret    

8010201c <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
8010201c:	55                   	push   %ebp
8010201d:	89 e5                	mov    %esp,%ebp
8010201f:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102022:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102029:	eb 45                	jmp    80102070 <itrunc+0x54>
    if(ip->addrs[i]){
8010202b:	8b 45 08             	mov    0x8(%ebp),%eax
8010202e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102031:	83 c2 04             	add    $0x4,%edx
80102034:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80102038:	85 c0                	test   %eax,%eax
8010203a:	74 30                	je     8010206c <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
8010203c:	8b 45 08             	mov    0x8(%ebp),%eax
8010203f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102042:	83 c2 04             	add    $0x4,%edx
80102045:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80102049:	8b 55 08             	mov    0x8(%ebp),%edx
8010204c:	8b 12                	mov    (%edx),%edx
8010204e:	83 ec 08             	sub    $0x8,%esp
80102051:	50                   	push   %eax
80102052:	52                   	push   %edx
80102053:	e8 23 f8 ff ff       	call   8010187b <bfree>
80102058:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
8010205b:	8b 45 08             	mov    0x8(%ebp),%eax
8010205e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102061:	83 c2 04             	add    $0x4,%edx
80102064:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
8010206b:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
8010206c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102070:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80102074:	7e b5                	jle    8010202b <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
80102076:	8b 45 08             	mov    0x8(%ebp),%eax
80102079:	8b 40 4c             	mov    0x4c(%eax),%eax
8010207c:	85 c0                	test   %eax,%eax
8010207e:	0f 84 a1 00 00 00    	je     80102125 <itrunc+0x109>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80102084:	8b 45 08             	mov    0x8(%ebp),%eax
80102087:	8b 50 4c             	mov    0x4c(%eax),%edx
8010208a:	8b 45 08             	mov    0x8(%ebp),%eax
8010208d:	8b 00                	mov    (%eax),%eax
8010208f:	83 ec 08             	sub    $0x8,%esp
80102092:	52                   	push   %edx
80102093:	50                   	push   %eax
80102094:	e8 1b e1 ff ff       	call   801001b4 <bread>
80102099:	83 c4 10             	add    $0x10,%esp
8010209c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
8010209f:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020a2:	83 c0 18             	add    $0x18,%eax
801020a5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801020a8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801020af:	eb 3c                	jmp    801020ed <itrunc+0xd1>
      if(a[j])
801020b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020b4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801020bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
801020be:	01 d0                	add    %edx,%eax
801020c0:	8b 00                	mov    (%eax),%eax
801020c2:	85 c0                	test   %eax,%eax
801020c4:	74 23                	je     801020e9 <itrunc+0xcd>
        bfree(ip->dev, a[j]);
801020c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020c9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801020d0:	8b 45 e8             	mov    -0x18(%ebp),%eax
801020d3:	01 d0                	add    %edx,%eax
801020d5:	8b 00                	mov    (%eax),%eax
801020d7:	8b 55 08             	mov    0x8(%ebp),%edx
801020da:	8b 12                	mov    (%edx),%edx
801020dc:	83 ec 08             	sub    $0x8,%esp
801020df:	50                   	push   %eax
801020e0:	52                   	push   %edx
801020e1:	e8 95 f7 ff ff       	call   8010187b <bfree>
801020e6:	83 c4 10             	add    $0x10,%esp
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
801020e9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801020ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020f0:	83 f8 7f             	cmp    $0x7f,%eax
801020f3:	76 bc                	jbe    801020b1 <itrunc+0x95>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
801020f5:	83 ec 0c             	sub    $0xc,%esp
801020f8:	ff 75 ec             	pushl  -0x14(%ebp)
801020fb:	e8 2b e1 ff ff       	call   8010022b <brelse>
80102100:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80102103:	8b 45 08             	mov    0x8(%ebp),%eax
80102106:	8b 40 4c             	mov    0x4c(%eax),%eax
80102109:	8b 55 08             	mov    0x8(%ebp),%edx
8010210c:	8b 12                	mov    (%edx),%edx
8010210e:	83 ec 08             	sub    $0x8,%esp
80102111:	50                   	push   %eax
80102112:	52                   	push   %edx
80102113:	e8 63 f7 ff ff       	call   8010187b <bfree>
80102118:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
8010211b:	8b 45 08             	mov    0x8(%ebp),%eax
8010211e:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80102125:	8b 45 08             	mov    0x8(%ebp),%eax
80102128:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
8010212f:	83 ec 0c             	sub    $0xc,%esp
80102132:	ff 75 08             	pushl  0x8(%ebp)
80102135:	e8 15 f9 ff ff       	call   80101a4f <iupdate>
8010213a:	83 c4 10             	add    $0x10,%esp
}
8010213d:	c9                   	leave  
8010213e:	c3                   	ret    

8010213f <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
8010213f:	55                   	push   %ebp
80102140:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80102142:	8b 45 08             	mov    0x8(%ebp),%eax
80102145:	8b 00                	mov    (%eax),%eax
80102147:	89 c2                	mov    %eax,%edx
80102149:	8b 45 0c             	mov    0xc(%ebp),%eax
8010214c:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
8010214f:	8b 45 08             	mov    0x8(%ebp),%eax
80102152:	8b 50 04             	mov    0x4(%eax),%edx
80102155:	8b 45 0c             	mov    0xc(%ebp),%eax
80102158:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
8010215b:	8b 45 08             	mov    0x8(%ebp),%eax
8010215e:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80102162:	8b 45 0c             	mov    0xc(%ebp),%eax
80102165:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80102168:	8b 45 08             	mov    0x8(%ebp),%eax
8010216b:	0f b7 50 16          	movzwl 0x16(%eax),%edx
8010216f:	8b 45 0c             	mov    0xc(%ebp),%eax
80102172:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80102176:	8b 45 08             	mov    0x8(%ebp),%eax
80102179:	8b 50 18             	mov    0x18(%eax),%edx
8010217c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010217f:	89 50 10             	mov    %edx,0x10(%eax)
}
80102182:	5d                   	pop    %ebp
80102183:	c3                   	ret    

80102184 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80102184:	55                   	push   %ebp
80102185:	89 e5                	mov    %esp,%ebp
80102187:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
8010218a:	8b 45 08             	mov    0x8(%ebp),%eax
8010218d:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102191:	66 83 f8 03          	cmp    $0x3,%ax
80102195:	75 5c                	jne    801021f3 <readi+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102197:	8b 45 08             	mov    0x8(%ebp),%eax
8010219a:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010219e:	66 85 c0             	test   %ax,%ax
801021a1:	78 20                	js     801021c3 <readi+0x3f>
801021a3:	8b 45 08             	mov    0x8(%ebp),%eax
801021a6:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801021aa:	66 83 f8 09          	cmp    $0x9,%ax
801021ae:	7f 13                	jg     801021c3 <readi+0x3f>
801021b0:	8b 45 08             	mov    0x8(%ebp),%eax
801021b3:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801021b7:	98                   	cwtl   
801021b8:	8b 04 c5 80 ed 10 80 	mov    -0x7fef1280(,%eax,8),%eax
801021bf:	85 c0                	test   %eax,%eax
801021c1:	75 0a                	jne    801021cd <readi+0x49>
      return -1;
801021c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021c8:	e9 16 01 00 00       	jmp    801022e3 <readi+0x15f>
    return devsw[ip->major].read(ip, dst, n);
801021cd:	8b 45 08             	mov    0x8(%ebp),%eax
801021d0:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801021d4:	98                   	cwtl   
801021d5:	8b 04 c5 80 ed 10 80 	mov    -0x7fef1280(,%eax,8),%eax
801021dc:	8b 55 14             	mov    0x14(%ebp),%edx
801021df:	83 ec 04             	sub    $0x4,%esp
801021e2:	52                   	push   %edx
801021e3:	ff 75 0c             	pushl  0xc(%ebp)
801021e6:	ff 75 08             	pushl  0x8(%ebp)
801021e9:	ff d0                	call   *%eax
801021eb:	83 c4 10             	add    $0x10,%esp
801021ee:	e9 f0 00 00 00       	jmp    801022e3 <readi+0x15f>
  }

  if(off > ip->size || off + n < off)
801021f3:	8b 45 08             	mov    0x8(%ebp),%eax
801021f6:	8b 40 18             	mov    0x18(%eax),%eax
801021f9:	3b 45 10             	cmp    0x10(%ebp),%eax
801021fc:	72 0d                	jb     8010220b <readi+0x87>
801021fe:	8b 55 10             	mov    0x10(%ebp),%edx
80102201:	8b 45 14             	mov    0x14(%ebp),%eax
80102204:	01 d0                	add    %edx,%eax
80102206:	3b 45 10             	cmp    0x10(%ebp),%eax
80102209:	73 0a                	jae    80102215 <readi+0x91>
    return -1;
8010220b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102210:	e9 ce 00 00 00       	jmp    801022e3 <readi+0x15f>
  if(off + n > ip->size)
80102215:	8b 55 10             	mov    0x10(%ebp),%edx
80102218:	8b 45 14             	mov    0x14(%ebp),%eax
8010221b:	01 c2                	add    %eax,%edx
8010221d:	8b 45 08             	mov    0x8(%ebp),%eax
80102220:	8b 40 18             	mov    0x18(%eax),%eax
80102223:	39 c2                	cmp    %eax,%edx
80102225:	76 0c                	jbe    80102233 <readi+0xaf>
    n = ip->size - off;
80102227:	8b 45 08             	mov    0x8(%ebp),%eax
8010222a:	8b 40 18             	mov    0x18(%eax),%eax
8010222d:	2b 45 10             	sub    0x10(%ebp),%eax
80102230:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102233:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010223a:	e9 95 00 00 00       	jmp    801022d4 <readi+0x150>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010223f:	8b 45 10             	mov    0x10(%ebp),%eax
80102242:	c1 e8 09             	shr    $0x9,%eax
80102245:	83 ec 08             	sub    $0x8,%esp
80102248:	50                   	push   %eax
80102249:	ff 75 08             	pushl  0x8(%ebp)
8010224c:	e8 ac fc ff ff       	call   80101efd <bmap>
80102251:	83 c4 10             	add    $0x10,%esp
80102254:	89 c2                	mov    %eax,%edx
80102256:	8b 45 08             	mov    0x8(%ebp),%eax
80102259:	8b 00                	mov    (%eax),%eax
8010225b:	83 ec 08             	sub    $0x8,%esp
8010225e:	52                   	push   %edx
8010225f:	50                   	push   %eax
80102260:	e8 4f df ff ff       	call   801001b4 <bread>
80102265:	83 c4 10             	add    $0x10,%esp
80102268:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
8010226b:	8b 45 10             	mov    0x10(%ebp),%eax
8010226e:	25 ff 01 00 00       	and    $0x1ff,%eax
80102273:	ba 00 02 00 00       	mov    $0x200,%edx
80102278:	89 d1                	mov    %edx,%ecx
8010227a:	29 c1                	sub    %eax,%ecx
8010227c:	8b 45 14             	mov    0x14(%ebp),%eax
8010227f:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102282:	89 c2                	mov    %eax,%edx
80102284:	89 c8                	mov    %ecx,%eax
80102286:	39 d0                	cmp    %edx,%eax
80102288:	76 02                	jbe    8010228c <readi+0x108>
8010228a:	89 d0                	mov    %edx,%eax
8010228c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
8010228f:	8b 45 10             	mov    0x10(%ebp),%eax
80102292:	25 ff 01 00 00       	and    $0x1ff,%eax
80102297:	8d 50 10             	lea    0x10(%eax),%edx
8010229a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010229d:	01 d0                	add    %edx,%eax
8010229f:	83 c0 08             	add    $0x8,%eax
801022a2:	83 ec 04             	sub    $0x4,%esp
801022a5:	ff 75 ec             	pushl  -0x14(%ebp)
801022a8:	50                   	push   %eax
801022a9:	ff 75 0c             	pushl  0xc(%ebp)
801022ac:	e8 30 2f 00 00       	call   801051e1 <memmove>
801022b1:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801022b4:	83 ec 0c             	sub    $0xc,%esp
801022b7:	ff 75 f0             	pushl  -0x10(%ebp)
801022ba:	e8 6c df ff ff       	call   8010022b <brelse>
801022bf:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801022c2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801022c5:	01 45 f4             	add    %eax,-0xc(%ebp)
801022c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801022cb:	01 45 10             	add    %eax,0x10(%ebp)
801022ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
801022d1:	01 45 0c             	add    %eax,0xc(%ebp)
801022d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022d7:	3b 45 14             	cmp    0x14(%ebp),%eax
801022da:	0f 82 5f ff ff ff    	jb     8010223f <readi+0xbb>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
801022e0:	8b 45 14             	mov    0x14(%ebp),%eax
}
801022e3:	c9                   	leave  
801022e4:	c3                   	ret    

801022e5 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801022e5:	55                   	push   %ebp
801022e6:	89 e5                	mov    %esp,%ebp
801022e8:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801022eb:	8b 45 08             	mov    0x8(%ebp),%eax
801022ee:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801022f2:	66 83 f8 03          	cmp    $0x3,%ax
801022f6:	75 5c                	jne    80102354 <writei+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
801022f8:	8b 45 08             	mov    0x8(%ebp),%eax
801022fb:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801022ff:	66 85 c0             	test   %ax,%ax
80102302:	78 20                	js     80102324 <writei+0x3f>
80102304:	8b 45 08             	mov    0x8(%ebp),%eax
80102307:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010230b:	66 83 f8 09          	cmp    $0x9,%ax
8010230f:	7f 13                	jg     80102324 <writei+0x3f>
80102311:	8b 45 08             	mov    0x8(%ebp),%eax
80102314:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102318:	98                   	cwtl   
80102319:	8b 04 c5 84 ed 10 80 	mov    -0x7fef127c(,%eax,8),%eax
80102320:	85 c0                	test   %eax,%eax
80102322:	75 0a                	jne    8010232e <writei+0x49>
      return -1;
80102324:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102329:	e9 47 01 00 00       	jmp    80102475 <writei+0x190>
    return devsw[ip->major].write(ip, src, n);
8010232e:	8b 45 08             	mov    0x8(%ebp),%eax
80102331:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102335:	98                   	cwtl   
80102336:	8b 04 c5 84 ed 10 80 	mov    -0x7fef127c(,%eax,8),%eax
8010233d:	8b 55 14             	mov    0x14(%ebp),%edx
80102340:	83 ec 04             	sub    $0x4,%esp
80102343:	52                   	push   %edx
80102344:	ff 75 0c             	pushl  0xc(%ebp)
80102347:	ff 75 08             	pushl  0x8(%ebp)
8010234a:	ff d0                	call   *%eax
8010234c:	83 c4 10             	add    $0x10,%esp
8010234f:	e9 21 01 00 00       	jmp    80102475 <writei+0x190>
  }

  if(off > ip->size || off + n < off)
80102354:	8b 45 08             	mov    0x8(%ebp),%eax
80102357:	8b 40 18             	mov    0x18(%eax),%eax
8010235a:	3b 45 10             	cmp    0x10(%ebp),%eax
8010235d:	72 0d                	jb     8010236c <writei+0x87>
8010235f:	8b 55 10             	mov    0x10(%ebp),%edx
80102362:	8b 45 14             	mov    0x14(%ebp),%eax
80102365:	01 d0                	add    %edx,%eax
80102367:	3b 45 10             	cmp    0x10(%ebp),%eax
8010236a:	73 0a                	jae    80102376 <writei+0x91>
    return -1;
8010236c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102371:	e9 ff 00 00 00       	jmp    80102475 <writei+0x190>
  if(off + n > MAXFILE*BSIZE)
80102376:	8b 55 10             	mov    0x10(%ebp),%edx
80102379:	8b 45 14             	mov    0x14(%ebp),%eax
8010237c:	01 d0                	add    %edx,%eax
8010237e:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102383:	76 0a                	jbe    8010238f <writei+0xaa>
    return -1;
80102385:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010238a:	e9 e6 00 00 00       	jmp    80102475 <writei+0x190>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010238f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102396:	e9 a3 00 00 00       	jmp    8010243e <writei+0x159>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010239b:	8b 45 10             	mov    0x10(%ebp),%eax
8010239e:	c1 e8 09             	shr    $0x9,%eax
801023a1:	83 ec 08             	sub    $0x8,%esp
801023a4:	50                   	push   %eax
801023a5:	ff 75 08             	pushl  0x8(%ebp)
801023a8:	e8 50 fb ff ff       	call   80101efd <bmap>
801023ad:	83 c4 10             	add    $0x10,%esp
801023b0:	89 c2                	mov    %eax,%edx
801023b2:	8b 45 08             	mov    0x8(%ebp),%eax
801023b5:	8b 00                	mov    (%eax),%eax
801023b7:	83 ec 08             	sub    $0x8,%esp
801023ba:	52                   	push   %edx
801023bb:	50                   	push   %eax
801023bc:	e8 f3 dd ff ff       	call   801001b4 <bread>
801023c1:	83 c4 10             	add    $0x10,%esp
801023c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801023c7:	8b 45 10             	mov    0x10(%ebp),%eax
801023ca:	25 ff 01 00 00       	and    $0x1ff,%eax
801023cf:	ba 00 02 00 00       	mov    $0x200,%edx
801023d4:	89 d1                	mov    %edx,%ecx
801023d6:	29 c1                	sub    %eax,%ecx
801023d8:	8b 45 14             	mov    0x14(%ebp),%eax
801023db:	2b 45 f4             	sub    -0xc(%ebp),%eax
801023de:	89 c2                	mov    %eax,%edx
801023e0:	89 c8                	mov    %ecx,%eax
801023e2:	39 d0                	cmp    %edx,%eax
801023e4:	76 02                	jbe    801023e8 <writei+0x103>
801023e6:	89 d0                	mov    %edx,%eax
801023e8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
801023eb:	8b 45 10             	mov    0x10(%ebp),%eax
801023ee:	25 ff 01 00 00       	and    $0x1ff,%eax
801023f3:	8d 50 10             	lea    0x10(%eax),%edx
801023f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023f9:	01 d0                	add    %edx,%eax
801023fb:	83 c0 08             	add    $0x8,%eax
801023fe:	83 ec 04             	sub    $0x4,%esp
80102401:	ff 75 ec             	pushl  -0x14(%ebp)
80102404:	ff 75 0c             	pushl  0xc(%ebp)
80102407:	50                   	push   %eax
80102408:	e8 d4 2d 00 00       	call   801051e1 <memmove>
8010240d:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
80102410:	83 ec 0c             	sub    $0xc,%esp
80102413:	ff 75 f0             	pushl  -0x10(%ebp)
80102416:	e8 31 12 00 00       	call   8010364c <log_write>
8010241b:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
8010241e:	83 ec 0c             	sub    $0xc,%esp
80102421:	ff 75 f0             	pushl  -0x10(%ebp)
80102424:	e8 02 de ff ff       	call   8010022b <brelse>
80102429:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010242c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010242f:	01 45 f4             	add    %eax,-0xc(%ebp)
80102432:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102435:	01 45 10             	add    %eax,0x10(%ebp)
80102438:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010243b:	01 45 0c             	add    %eax,0xc(%ebp)
8010243e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102441:	3b 45 14             	cmp    0x14(%ebp),%eax
80102444:	0f 82 51 ff ff ff    	jb     8010239b <writei+0xb6>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
8010244a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010244e:	74 22                	je     80102472 <writei+0x18d>
80102450:	8b 45 08             	mov    0x8(%ebp),%eax
80102453:	8b 40 18             	mov    0x18(%eax),%eax
80102456:	3b 45 10             	cmp    0x10(%ebp),%eax
80102459:	73 17                	jae    80102472 <writei+0x18d>
    ip->size = off;
8010245b:	8b 45 08             	mov    0x8(%ebp),%eax
8010245e:	8b 55 10             	mov    0x10(%ebp),%edx
80102461:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
80102464:	83 ec 0c             	sub    $0xc,%esp
80102467:	ff 75 08             	pushl  0x8(%ebp)
8010246a:	e8 e0 f5 ff ff       	call   80101a4f <iupdate>
8010246f:	83 c4 10             	add    $0x10,%esp
  }
  return n;
80102472:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102475:	c9                   	leave  
80102476:	c3                   	ret    

80102477 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102477:	55                   	push   %ebp
80102478:	89 e5                	mov    %esp,%ebp
8010247a:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
8010247d:	83 ec 04             	sub    $0x4,%esp
80102480:	6a 0e                	push   $0xe
80102482:	ff 75 0c             	pushl  0xc(%ebp)
80102485:	ff 75 08             	pushl  0x8(%ebp)
80102488:	e8 ec 2d 00 00       	call   80105279 <strncmp>
8010248d:	83 c4 10             	add    $0x10,%esp
}
80102490:	c9                   	leave  
80102491:	c3                   	ret    

80102492 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102492:	55                   	push   %ebp
80102493:	89 e5                	mov    %esp,%ebp
80102495:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102498:	8b 45 08             	mov    0x8(%ebp),%eax
8010249b:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010249f:	66 83 f8 01          	cmp    $0x1,%ax
801024a3:	74 0d                	je     801024b2 <dirlookup+0x20>
    panic("dirlookup not DIR");
801024a5:	83 ec 0c             	sub    $0xc,%esp
801024a8:	68 e1 86 10 80       	push   $0x801086e1
801024ad:	e8 aa e0 ff ff       	call   8010055c <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
801024b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801024b9:	eb 7c                	jmp    80102537 <dirlookup+0xa5>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801024bb:	6a 10                	push   $0x10
801024bd:	ff 75 f4             	pushl  -0xc(%ebp)
801024c0:	8d 45 e0             	lea    -0x20(%ebp),%eax
801024c3:	50                   	push   %eax
801024c4:	ff 75 08             	pushl  0x8(%ebp)
801024c7:	e8 b8 fc ff ff       	call   80102184 <readi>
801024cc:	83 c4 10             	add    $0x10,%esp
801024cf:	83 f8 10             	cmp    $0x10,%eax
801024d2:	74 0d                	je     801024e1 <dirlookup+0x4f>
      panic("dirlink read");
801024d4:	83 ec 0c             	sub    $0xc,%esp
801024d7:	68 f3 86 10 80       	push   $0x801086f3
801024dc:	e8 7b e0 ff ff       	call   8010055c <panic>
    if(de.inum == 0)
801024e1:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801024e5:	66 85 c0             	test   %ax,%ax
801024e8:	75 02                	jne    801024ec <dirlookup+0x5a>
      continue;
801024ea:	eb 47                	jmp    80102533 <dirlookup+0xa1>
    if(namecmp(name, de.name) == 0){
801024ec:	83 ec 08             	sub    $0x8,%esp
801024ef:	8d 45 e0             	lea    -0x20(%ebp),%eax
801024f2:	83 c0 02             	add    $0x2,%eax
801024f5:	50                   	push   %eax
801024f6:	ff 75 0c             	pushl  0xc(%ebp)
801024f9:	e8 79 ff ff ff       	call   80102477 <namecmp>
801024fe:	83 c4 10             	add    $0x10,%esp
80102501:	85 c0                	test   %eax,%eax
80102503:	75 2e                	jne    80102533 <dirlookup+0xa1>
      // entry matches path element
      if(poff)
80102505:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80102509:	74 08                	je     80102513 <dirlookup+0x81>
        *poff = off;
8010250b:	8b 45 10             	mov    0x10(%ebp),%eax
8010250e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102511:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
80102513:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102517:	0f b7 c0             	movzwl %ax,%eax
8010251a:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
8010251d:	8b 45 08             	mov    0x8(%ebp),%eax
80102520:	8b 00                	mov    (%eax),%eax
80102522:	83 ec 08             	sub    $0x8,%esp
80102525:	ff 75 f0             	pushl  -0x10(%ebp)
80102528:	50                   	push   %eax
80102529:	e8 db f5 ff ff       	call   80101b09 <iget>
8010252e:	83 c4 10             	add    $0x10,%esp
80102531:	eb 18                	jmp    8010254b <dirlookup+0xb9>
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102533:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80102537:	8b 45 08             	mov    0x8(%ebp),%eax
8010253a:	8b 40 18             	mov    0x18(%eax),%eax
8010253d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80102540:	0f 87 75 ff ff ff    	ja     801024bb <dirlookup+0x29>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80102546:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010254b:	c9                   	leave  
8010254c:	c3                   	ret    

8010254d <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
8010254d:	55                   	push   %ebp
8010254e:	89 e5                	mov    %esp,%ebp
80102550:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102553:	83 ec 04             	sub    $0x4,%esp
80102556:	6a 00                	push   $0x0
80102558:	ff 75 0c             	pushl  0xc(%ebp)
8010255b:	ff 75 08             	pushl  0x8(%ebp)
8010255e:	e8 2f ff ff ff       	call   80102492 <dirlookup>
80102563:	83 c4 10             	add    $0x10,%esp
80102566:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102569:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010256d:	74 18                	je     80102587 <dirlink+0x3a>
    iput(ip);
8010256f:	83 ec 0c             	sub    $0xc,%esp
80102572:	ff 75 f0             	pushl  -0x10(%ebp)
80102575:	e8 70 f8 ff ff       	call   80101dea <iput>
8010257a:	83 c4 10             	add    $0x10,%esp
    return -1;
8010257d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102582:	e9 9b 00 00 00       	jmp    80102622 <dirlink+0xd5>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102587:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010258e:	eb 3b                	jmp    801025cb <dirlink+0x7e>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102590:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102593:	6a 10                	push   $0x10
80102595:	50                   	push   %eax
80102596:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102599:	50                   	push   %eax
8010259a:	ff 75 08             	pushl  0x8(%ebp)
8010259d:	e8 e2 fb ff ff       	call   80102184 <readi>
801025a2:	83 c4 10             	add    $0x10,%esp
801025a5:	83 f8 10             	cmp    $0x10,%eax
801025a8:	74 0d                	je     801025b7 <dirlink+0x6a>
      panic("dirlink read");
801025aa:	83 ec 0c             	sub    $0xc,%esp
801025ad:	68 f3 86 10 80       	push   $0x801086f3
801025b2:	e8 a5 df ff ff       	call   8010055c <panic>
    if(de.inum == 0)
801025b7:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801025bb:	66 85 c0             	test   %ax,%ax
801025be:	75 02                	jne    801025c2 <dirlink+0x75>
      break;
801025c0:	eb 16                	jmp    801025d8 <dirlink+0x8b>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801025c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801025c5:	83 c0 10             	add    $0x10,%eax
801025c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801025cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801025ce:	8b 45 08             	mov    0x8(%ebp),%eax
801025d1:	8b 40 18             	mov    0x18(%eax),%eax
801025d4:	39 c2                	cmp    %eax,%edx
801025d6:	72 b8                	jb     80102590 <dirlink+0x43>
      panic("dirlink read");
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
801025d8:	83 ec 04             	sub    $0x4,%esp
801025db:	6a 0e                	push   $0xe
801025dd:	ff 75 0c             	pushl  0xc(%ebp)
801025e0:	8d 45 e0             	lea    -0x20(%ebp),%eax
801025e3:	83 c0 02             	add    $0x2,%eax
801025e6:	50                   	push   %eax
801025e7:	e8 e3 2c 00 00       	call   801052cf <strncpy>
801025ec:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
801025ef:	8b 45 10             	mov    0x10(%ebp),%eax
801025f2:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801025f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801025f9:	6a 10                	push   $0x10
801025fb:	50                   	push   %eax
801025fc:	8d 45 e0             	lea    -0x20(%ebp),%eax
801025ff:	50                   	push   %eax
80102600:	ff 75 08             	pushl  0x8(%ebp)
80102603:	e8 dd fc ff ff       	call   801022e5 <writei>
80102608:	83 c4 10             	add    $0x10,%esp
8010260b:	83 f8 10             	cmp    $0x10,%eax
8010260e:	74 0d                	je     8010261d <dirlink+0xd0>
    panic("dirlink");
80102610:	83 ec 0c             	sub    $0xc,%esp
80102613:	68 00 87 10 80       	push   $0x80108700
80102618:	e8 3f df ff ff       	call   8010055c <panic>
  
  return 0;
8010261d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102622:	c9                   	leave  
80102623:	c3                   	ret    

80102624 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80102624:	55                   	push   %ebp
80102625:	89 e5                	mov    %esp,%ebp
80102627:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
8010262a:	eb 04                	jmp    80102630 <skipelem+0xc>
    path++;
8010262c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80102630:	8b 45 08             	mov    0x8(%ebp),%eax
80102633:	0f b6 00             	movzbl (%eax),%eax
80102636:	3c 2f                	cmp    $0x2f,%al
80102638:	74 f2                	je     8010262c <skipelem+0x8>
    path++;
  if(*path == 0)
8010263a:	8b 45 08             	mov    0x8(%ebp),%eax
8010263d:	0f b6 00             	movzbl (%eax),%eax
80102640:	84 c0                	test   %al,%al
80102642:	75 07                	jne    8010264b <skipelem+0x27>
    return 0;
80102644:	b8 00 00 00 00       	mov    $0x0,%eax
80102649:	eb 7b                	jmp    801026c6 <skipelem+0xa2>
  s = path;
8010264b:	8b 45 08             	mov    0x8(%ebp),%eax
8010264e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
80102651:	eb 04                	jmp    80102657 <skipelem+0x33>
    path++;
80102653:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102657:	8b 45 08             	mov    0x8(%ebp),%eax
8010265a:	0f b6 00             	movzbl (%eax),%eax
8010265d:	3c 2f                	cmp    $0x2f,%al
8010265f:	74 0a                	je     8010266b <skipelem+0x47>
80102661:	8b 45 08             	mov    0x8(%ebp),%eax
80102664:	0f b6 00             	movzbl (%eax),%eax
80102667:	84 c0                	test   %al,%al
80102669:	75 e8                	jne    80102653 <skipelem+0x2f>
    path++;
  len = path - s;
8010266b:	8b 55 08             	mov    0x8(%ebp),%edx
8010266e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102671:	29 c2                	sub    %eax,%edx
80102673:	89 d0                	mov    %edx,%eax
80102675:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
80102678:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
8010267c:	7e 15                	jle    80102693 <skipelem+0x6f>
    memmove(name, s, DIRSIZ);
8010267e:	83 ec 04             	sub    $0x4,%esp
80102681:	6a 0e                	push   $0xe
80102683:	ff 75 f4             	pushl  -0xc(%ebp)
80102686:	ff 75 0c             	pushl  0xc(%ebp)
80102689:	e8 53 2b 00 00       	call   801051e1 <memmove>
8010268e:	83 c4 10             	add    $0x10,%esp
80102691:	eb 20                	jmp    801026b3 <skipelem+0x8f>
  else {
    memmove(name, s, len);
80102693:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102696:	83 ec 04             	sub    $0x4,%esp
80102699:	50                   	push   %eax
8010269a:	ff 75 f4             	pushl  -0xc(%ebp)
8010269d:	ff 75 0c             	pushl  0xc(%ebp)
801026a0:	e8 3c 2b 00 00       	call   801051e1 <memmove>
801026a5:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
801026a8:	8b 55 f0             	mov    -0x10(%ebp),%edx
801026ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801026ae:	01 d0                	add    %edx,%eax
801026b0:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801026b3:	eb 04                	jmp    801026b9 <skipelem+0x95>
    path++;
801026b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801026b9:	8b 45 08             	mov    0x8(%ebp),%eax
801026bc:	0f b6 00             	movzbl (%eax),%eax
801026bf:	3c 2f                	cmp    $0x2f,%al
801026c1:	74 f2                	je     801026b5 <skipelem+0x91>
    path++;
  return path;
801026c3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801026c6:	c9                   	leave  
801026c7:	c3                   	ret    

801026c8 <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801026c8:	55                   	push   %ebp
801026c9:	89 e5                	mov    %esp,%ebp
801026cb:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
801026ce:	8b 45 08             	mov    0x8(%ebp),%eax
801026d1:	0f b6 00             	movzbl (%eax),%eax
801026d4:	3c 2f                	cmp    $0x2f,%al
801026d6:	75 14                	jne    801026ec <namex+0x24>
    ip = iget(ROOTDEV, ROOTINO);
801026d8:	83 ec 08             	sub    $0x8,%esp
801026db:	6a 01                	push   $0x1
801026dd:	6a 01                	push   $0x1
801026df:	e8 25 f4 ff ff       	call   80101b09 <iget>
801026e4:	83 c4 10             	add    $0x10,%esp
801026e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801026ea:	eb 18                	jmp    80102704 <namex+0x3c>
  else
    ip = idup(proc->cwd);
801026ec:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801026f2:	8b 40 68             	mov    0x68(%eax),%eax
801026f5:	83 ec 0c             	sub    $0xc,%esp
801026f8:	50                   	push   %eax
801026f9:	e8 ea f4 ff ff       	call   80101be8 <idup>
801026fe:	83 c4 10             	add    $0x10,%esp
80102701:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
80102704:	e9 9e 00 00 00       	jmp    801027a7 <namex+0xdf>
    ilock(ip);
80102709:	83 ec 0c             	sub    $0xc,%esp
8010270c:	ff 75 f4             	pushl  -0xc(%ebp)
8010270f:	e8 0e f5 ff ff       	call   80101c22 <ilock>
80102714:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
80102717:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010271a:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010271e:	66 83 f8 01          	cmp    $0x1,%ax
80102722:	74 18                	je     8010273c <namex+0x74>
      iunlockput(ip);
80102724:	83 ec 0c             	sub    $0xc,%esp
80102727:	ff 75 f4             	pushl  -0xc(%ebp)
8010272a:	e8 aa f7 ff ff       	call   80101ed9 <iunlockput>
8010272f:	83 c4 10             	add    $0x10,%esp
      return 0;
80102732:	b8 00 00 00 00       	mov    $0x0,%eax
80102737:	e9 a7 00 00 00       	jmp    801027e3 <namex+0x11b>
    }
    if(nameiparent && *path == '\0'){
8010273c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102740:	74 20                	je     80102762 <namex+0x9a>
80102742:	8b 45 08             	mov    0x8(%ebp),%eax
80102745:	0f b6 00             	movzbl (%eax),%eax
80102748:	84 c0                	test   %al,%al
8010274a:	75 16                	jne    80102762 <namex+0x9a>
      // Stop one level early.
      iunlock(ip);
8010274c:	83 ec 0c             	sub    $0xc,%esp
8010274f:	ff 75 f4             	pushl  -0xc(%ebp)
80102752:	e8 22 f6 ff ff       	call   80101d79 <iunlock>
80102757:	83 c4 10             	add    $0x10,%esp
      return ip;
8010275a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010275d:	e9 81 00 00 00       	jmp    801027e3 <namex+0x11b>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102762:	83 ec 04             	sub    $0x4,%esp
80102765:	6a 00                	push   $0x0
80102767:	ff 75 10             	pushl  0x10(%ebp)
8010276a:	ff 75 f4             	pushl  -0xc(%ebp)
8010276d:	e8 20 fd ff ff       	call   80102492 <dirlookup>
80102772:	83 c4 10             	add    $0x10,%esp
80102775:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102778:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010277c:	75 15                	jne    80102793 <namex+0xcb>
      iunlockput(ip);
8010277e:	83 ec 0c             	sub    $0xc,%esp
80102781:	ff 75 f4             	pushl  -0xc(%ebp)
80102784:	e8 50 f7 ff ff       	call   80101ed9 <iunlockput>
80102789:	83 c4 10             	add    $0x10,%esp
      return 0;
8010278c:	b8 00 00 00 00       	mov    $0x0,%eax
80102791:	eb 50                	jmp    801027e3 <namex+0x11b>
    }
    iunlockput(ip);
80102793:	83 ec 0c             	sub    $0xc,%esp
80102796:	ff 75 f4             	pushl  -0xc(%ebp)
80102799:	e8 3b f7 ff ff       	call   80101ed9 <iunlockput>
8010279e:	83 c4 10             	add    $0x10,%esp
    ip = next;
801027a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
801027a7:	83 ec 08             	sub    $0x8,%esp
801027aa:	ff 75 10             	pushl  0x10(%ebp)
801027ad:	ff 75 08             	pushl  0x8(%ebp)
801027b0:	e8 6f fe ff ff       	call   80102624 <skipelem>
801027b5:	83 c4 10             	add    $0x10,%esp
801027b8:	89 45 08             	mov    %eax,0x8(%ebp)
801027bb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801027bf:	0f 85 44 ff ff ff    	jne    80102709 <namex+0x41>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801027c5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801027c9:	74 15                	je     801027e0 <namex+0x118>
    iput(ip);
801027cb:	83 ec 0c             	sub    $0xc,%esp
801027ce:	ff 75 f4             	pushl  -0xc(%ebp)
801027d1:	e8 14 f6 ff ff       	call   80101dea <iput>
801027d6:	83 c4 10             	add    $0x10,%esp
    return 0;
801027d9:	b8 00 00 00 00       	mov    $0x0,%eax
801027de:	eb 03                	jmp    801027e3 <namex+0x11b>
  }
  return ip;
801027e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801027e3:	c9                   	leave  
801027e4:	c3                   	ret    

801027e5 <namei>:

struct inode*
namei(char *path)
{
801027e5:	55                   	push   %ebp
801027e6:	89 e5                	mov    %esp,%ebp
801027e8:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
801027eb:	83 ec 04             	sub    $0x4,%esp
801027ee:	8d 45 ea             	lea    -0x16(%ebp),%eax
801027f1:	50                   	push   %eax
801027f2:	6a 00                	push   $0x0
801027f4:	ff 75 08             	pushl  0x8(%ebp)
801027f7:	e8 cc fe ff ff       	call   801026c8 <namex>
801027fc:	83 c4 10             	add    $0x10,%esp
}
801027ff:	c9                   	leave  
80102800:	c3                   	ret    

80102801 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102801:	55                   	push   %ebp
80102802:	89 e5                	mov    %esp,%ebp
80102804:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
80102807:	83 ec 04             	sub    $0x4,%esp
8010280a:	ff 75 0c             	pushl  0xc(%ebp)
8010280d:	6a 01                	push   $0x1
8010280f:	ff 75 08             	pushl  0x8(%ebp)
80102812:	e8 b1 fe ff ff       	call   801026c8 <namex>
80102817:	83 c4 10             	add    $0x10,%esp
}
8010281a:	c9                   	leave  
8010281b:	c3                   	ret    

8010281c <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
8010281c:	55                   	push   %ebp
8010281d:	89 e5                	mov    %esp,%ebp
8010281f:	83 ec 14             	sub    $0x14,%esp
80102822:	8b 45 08             	mov    0x8(%ebp),%eax
80102825:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102829:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
8010282d:	89 c2                	mov    %eax,%edx
8010282f:	ec                   	in     (%dx),%al
80102830:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102833:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102837:	c9                   	leave  
80102838:	c3                   	ret    

80102839 <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
80102839:	55                   	push   %ebp
8010283a:	89 e5                	mov    %esp,%ebp
8010283c:	57                   	push   %edi
8010283d:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
8010283e:	8b 55 08             	mov    0x8(%ebp),%edx
80102841:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102844:	8b 45 10             	mov    0x10(%ebp),%eax
80102847:	89 cb                	mov    %ecx,%ebx
80102849:	89 df                	mov    %ebx,%edi
8010284b:	89 c1                	mov    %eax,%ecx
8010284d:	fc                   	cld    
8010284e:	f3 6d                	rep insl (%dx),%es:(%edi)
80102850:	89 c8                	mov    %ecx,%eax
80102852:	89 fb                	mov    %edi,%ebx
80102854:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102857:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
8010285a:	5b                   	pop    %ebx
8010285b:	5f                   	pop    %edi
8010285c:	5d                   	pop    %ebp
8010285d:	c3                   	ret    

8010285e <outb>:

static inline void
outb(ushort port, uchar data)
{
8010285e:	55                   	push   %ebp
8010285f:	89 e5                	mov    %esp,%ebp
80102861:	83 ec 08             	sub    $0x8,%esp
80102864:	8b 55 08             	mov    0x8(%ebp),%edx
80102867:	8b 45 0c             	mov    0xc(%ebp),%eax
8010286a:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010286e:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102871:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102875:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102879:	ee                   	out    %al,(%dx)
}
8010287a:	c9                   	leave  
8010287b:	c3                   	ret    

8010287c <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
8010287c:	55                   	push   %ebp
8010287d:	89 e5                	mov    %esp,%ebp
8010287f:	56                   	push   %esi
80102880:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
80102881:	8b 55 08             	mov    0x8(%ebp),%edx
80102884:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102887:	8b 45 10             	mov    0x10(%ebp),%eax
8010288a:	89 cb                	mov    %ecx,%ebx
8010288c:	89 de                	mov    %ebx,%esi
8010288e:	89 c1                	mov    %eax,%ecx
80102890:	fc                   	cld    
80102891:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102893:	89 c8                	mov    %ecx,%eax
80102895:	89 f3                	mov    %esi,%ebx
80102897:	89 5d 0c             	mov    %ebx,0xc(%ebp)
8010289a:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
8010289d:	5b                   	pop    %ebx
8010289e:	5e                   	pop    %esi
8010289f:	5d                   	pop    %ebp
801028a0:	c3                   	ret    

801028a1 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
801028a1:	55                   	push   %ebp
801028a2:	89 e5                	mov    %esp,%ebp
801028a4:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
801028a7:	90                   	nop
801028a8:	68 f7 01 00 00       	push   $0x1f7
801028ad:	e8 6a ff ff ff       	call   8010281c <inb>
801028b2:	83 c4 04             	add    $0x4,%esp
801028b5:	0f b6 c0             	movzbl %al,%eax
801028b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
801028bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
801028be:	25 c0 00 00 00       	and    $0xc0,%eax
801028c3:	83 f8 40             	cmp    $0x40,%eax
801028c6:	75 e0                	jne    801028a8 <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801028c8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801028cc:	74 11                	je     801028df <idewait+0x3e>
801028ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
801028d1:	83 e0 21             	and    $0x21,%eax
801028d4:	85 c0                	test   %eax,%eax
801028d6:	74 07                	je     801028df <idewait+0x3e>
    return -1;
801028d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801028dd:	eb 05                	jmp    801028e4 <idewait+0x43>
  return 0;
801028df:	b8 00 00 00 00       	mov    $0x0,%eax
}
801028e4:	c9                   	leave  
801028e5:	c3                   	ret    

801028e6 <ideinit>:

void
ideinit(void)
{
801028e6:	55                   	push   %ebp
801028e7:	89 e5                	mov    %esp,%ebp
801028e9:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
801028ec:	83 ec 08             	sub    $0x8,%esp
801028ef:	68 08 87 10 80       	push   $0x80108708
801028f4:	68 60 bb 10 80       	push   $0x8010bb60
801028f9:	e8 a7 25 00 00       	call   80104ea5 <initlock>
801028fe:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
80102901:	83 ec 0c             	sub    $0xc,%esp
80102904:	6a 0e                	push   $0xe
80102906:	e8 23 15 00 00       	call   80103e2e <picenable>
8010290b:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
8010290e:	a1 e0 04 11 80       	mov    0x801104e0,%eax
80102913:	83 e8 01             	sub    $0x1,%eax
80102916:	83 ec 08             	sub    $0x8,%esp
80102919:	50                   	push   %eax
8010291a:	6a 0e                	push   $0xe
8010291c:	e8 31 04 00 00       	call   80102d52 <ioapicenable>
80102921:	83 c4 10             	add    $0x10,%esp
  idewait(0);
80102924:	83 ec 0c             	sub    $0xc,%esp
80102927:	6a 00                	push   $0x0
80102929:	e8 73 ff ff ff       	call   801028a1 <idewait>
8010292e:	83 c4 10             	add    $0x10,%esp
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80102931:	83 ec 08             	sub    $0x8,%esp
80102934:	68 f0 00 00 00       	push   $0xf0
80102939:	68 f6 01 00 00       	push   $0x1f6
8010293e:	e8 1b ff ff ff       	call   8010285e <outb>
80102943:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
80102946:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010294d:	eb 24                	jmp    80102973 <ideinit+0x8d>
    if(inb(0x1f7) != 0){
8010294f:	83 ec 0c             	sub    $0xc,%esp
80102952:	68 f7 01 00 00       	push   $0x1f7
80102957:	e8 c0 fe ff ff       	call   8010281c <inb>
8010295c:	83 c4 10             	add    $0x10,%esp
8010295f:	84 c0                	test   %al,%al
80102961:	74 0c                	je     8010296f <ideinit+0x89>
      havedisk1 = 1;
80102963:	c7 05 98 bb 10 80 01 	movl   $0x1,0x8010bb98
8010296a:	00 00 00 
      break;
8010296d:	eb 0d                	jmp    8010297c <ideinit+0x96>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
8010296f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102973:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
8010297a:	7e d3                	jle    8010294f <ideinit+0x69>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
8010297c:	83 ec 08             	sub    $0x8,%esp
8010297f:	68 e0 00 00 00       	push   $0xe0
80102984:	68 f6 01 00 00       	push   $0x1f6
80102989:	e8 d0 fe ff ff       	call   8010285e <outb>
8010298e:	83 c4 10             	add    $0x10,%esp
}
80102991:	c9                   	leave  
80102992:	c3                   	ret    

80102993 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102993:	55                   	push   %ebp
80102994:	89 e5                	mov    %esp,%ebp
80102996:	83 ec 08             	sub    $0x8,%esp
  if(b == 0)
80102999:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010299d:	75 0d                	jne    801029ac <idestart+0x19>
    panic("idestart");
8010299f:	83 ec 0c             	sub    $0xc,%esp
801029a2:	68 0c 87 10 80       	push   $0x8010870c
801029a7:	e8 b0 db ff ff       	call   8010055c <panic>

  idewait(0);
801029ac:	83 ec 0c             	sub    $0xc,%esp
801029af:	6a 00                	push   $0x0
801029b1:	e8 eb fe ff ff       	call   801028a1 <idewait>
801029b6:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
801029b9:	83 ec 08             	sub    $0x8,%esp
801029bc:	6a 00                	push   $0x0
801029be:	68 f6 03 00 00       	push   $0x3f6
801029c3:	e8 96 fe ff ff       	call   8010285e <outb>
801029c8:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, 1);  // number of sectors
801029cb:	83 ec 08             	sub    $0x8,%esp
801029ce:	6a 01                	push   $0x1
801029d0:	68 f2 01 00 00       	push   $0x1f2
801029d5:	e8 84 fe ff ff       	call   8010285e <outb>
801029da:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, b->sector & 0xff);
801029dd:	8b 45 08             	mov    0x8(%ebp),%eax
801029e0:	8b 40 08             	mov    0x8(%eax),%eax
801029e3:	0f b6 c0             	movzbl %al,%eax
801029e6:	83 ec 08             	sub    $0x8,%esp
801029e9:	50                   	push   %eax
801029ea:	68 f3 01 00 00       	push   $0x1f3
801029ef:	e8 6a fe ff ff       	call   8010285e <outb>
801029f4:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (b->sector >> 8) & 0xff);
801029f7:	8b 45 08             	mov    0x8(%ebp),%eax
801029fa:	8b 40 08             	mov    0x8(%eax),%eax
801029fd:	c1 e8 08             	shr    $0x8,%eax
80102a00:	0f b6 c0             	movzbl %al,%eax
80102a03:	83 ec 08             	sub    $0x8,%esp
80102a06:	50                   	push   %eax
80102a07:	68 f4 01 00 00       	push   $0x1f4
80102a0c:	e8 4d fe ff ff       	call   8010285e <outb>
80102a11:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (b->sector >> 16) & 0xff);
80102a14:	8b 45 08             	mov    0x8(%ebp),%eax
80102a17:	8b 40 08             	mov    0x8(%eax),%eax
80102a1a:	c1 e8 10             	shr    $0x10,%eax
80102a1d:	0f b6 c0             	movzbl %al,%eax
80102a20:	83 ec 08             	sub    $0x8,%esp
80102a23:	50                   	push   %eax
80102a24:	68 f5 01 00 00       	push   $0x1f5
80102a29:	e8 30 fe ff ff       	call   8010285e <outb>
80102a2e:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
80102a31:	8b 45 08             	mov    0x8(%ebp),%eax
80102a34:	8b 40 04             	mov    0x4(%eax),%eax
80102a37:	83 e0 01             	and    $0x1,%eax
80102a3a:	c1 e0 04             	shl    $0x4,%eax
80102a3d:	89 c2                	mov    %eax,%edx
80102a3f:	8b 45 08             	mov    0x8(%ebp),%eax
80102a42:	8b 40 08             	mov    0x8(%eax),%eax
80102a45:	c1 e8 18             	shr    $0x18,%eax
80102a48:	83 e0 0f             	and    $0xf,%eax
80102a4b:	09 d0                	or     %edx,%eax
80102a4d:	83 c8 e0             	or     $0xffffffe0,%eax
80102a50:	0f b6 c0             	movzbl %al,%eax
80102a53:	83 ec 08             	sub    $0x8,%esp
80102a56:	50                   	push   %eax
80102a57:	68 f6 01 00 00       	push   $0x1f6
80102a5c:	e8 fd fd ff ff       	call   8010285e <outb>
80102a61:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
80102a64:	8b 45 08             	mov    0x8(%ebp),%eax
80102a67:	8b 00                	mov    (%eax),%eax
80102a69:	83 e0 04             	and    $0x4,%eax
80102a6c:	85 c0                	test   %eax,%eax
80102a6e:	74 30                	je     80102aa0 <idestart+0x10d>
    outb(0x1f7, IDE_CMD_WRITE);
80102a70:	83 ec 08             	sub    $0x8,%esp
80102a73:	6a 30                	push   $0x30
80102a75:	68 f7 01 00 00       	push   $0x1f7
80102a7a:	e8 df fd ff ff       	call   8010285e <outb>
80102a7f:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, 512/4);
80102a82:	8b 45 08             	mov    0x8(%ebp),%eax
80102a85:	83 c0 18             	add    $0x18,%eax
80102a88:	83 ec 04             	sub    $0x4,%esp
80102a8b:	68 80 00 00 00       	push   $0x80
80102a90:	50                   	push   %eax
80102a91:	68 f0 01 00 00       	push   $0x1f0
80102a96:	e8 e1 fd ff ff       	call   8010287c <outsl>
80102a9b:	83 c4 10             	add    $0x10,%esp
80102a9e:	eb 12                	jmp    80102ab2 <idestart+0x11f>
  } else {
    outb(0x1f7, IDE_CMD_READ);
80102aa0:	83 ec 08             	sub    $0x8,%esp
80102aa3:	6a 20                	push   $0x20
80102aa5:	68 f7 01 00 00       	push   $0x1f7
80102aaa:	e8 af fd ff ff       	call   8010285e <outb>
80102aaf:	83 c4 10             	add    $0x10,%esp
  }
}
80102ab2:	c9                   	leave  
80102ab3:	c3                   	ret    

80102ab4 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102ab4:	55                   	push   %ebp
80102ab5:	89 e5                	mov    %esp,%ebp
80102ab7:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102aba:	83 ec 0c             	sub    $0xc,%esp
80102abd:	68 60 bb 10 80       	push   $0x8010bb60
80102ac2:	e8 ff 23 00 00       	call   80104ec6 <acquire>
80102ac7:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
80102aca:	a1 94 bb 10 80       	mov    0x8010bb94,%eax
80102acf:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102ad2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102ad6:	75 15                	jne    80102aed <ideintr+0x39>
    release(&idelock);
80102ad8:	83 ec 0c             	sub    $0xc,%esp
80102adb:	68 60 bb 10 80       	push   $0x8010bb60
80102ae0:	e8 47 24 00 00       	call   80104f2c <release>
80102ae5:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
80102ae8:	e9 9a 00 00 00       	jmp    80102b87 <ideintr+0xd3>
  }
  idequeue = b->qnext;
80102aed:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102af0:	8b 40 14             	mov    0x14(%eax),%eax
80102af3:	a3 94 bb 10 80       	mov    %eax,0x8010bb94

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102af8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102afb:	8b 00                	mov    (%eax),%eax
80102afd:	83 e0 04             	and    $0x4,%eax
80102b00:	85 c0                	test   %eax,%eax
80102b02:	75 2d                	jne    80102b31 <ideintr+0x7d>
80102b04:	83 ec 0c             	sub    $0xc,%esp
80102b07:	6a 01                	push   $0x1
80102b09:	e8 93 fd ff ff       	call   801028a1 <idewait>
80102b0e:	83 c4 10             	add    $0x10,%esp
80102b11:	85 c0                	test   %eax,%eax
80102b13:	78 1c                	js     80102b31 <ideintr+0x7d>
    insl(0x1f0, b->data, 512/4);
80102b15:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b18:	83 c0 18             	add    $0x18,%eax
80102b1b:	83 ec 04             	sub    $0x4,%esp
80102b1e:	68 80 00 00 00       	push   $0x80
80102b23:	50                   	push   %eax
80102b24:	68 f0 01 00 00       	push   $0x1f0
80102b29:	e8 0b fd ff ff       	call   80102839 <insl>
80102b2e:	83 c4 10             	add    $0x10,%esp
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102b31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b34:	8b 00                	mov    (%eax),%eax
80102b36:	83 c8 02             	or     $0x2,%eax
80102b39:	89 c2                	mov    %eax,%edx
80102b3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b3e:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
80102b40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b43:	8b 00                	mov    (%eax),%eax
80102b45:	83 e0 fb             	and    $0xfffffffb,%eax
80102b48:	89 c2                	mov    %eax,%edx
80102b4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b4d:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80102b4f:	83 ec 0c             	sub    $0xc,%esp
80102b52:	ff 75 f4             	pushl  -0xc(%ebp)
80102b55:	e8 53 21 00 00       	call   80104cad <wakeup>
80102b5a:	83 c4 10             	add    $0x10,%esp
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
80102b5d:	a1 94 bb 10 80       	mov    0x8010bb94,%eax
80102b62:	85 c0                	test   %eax,%eax
80102b64:	74 11                	je     80102b77 <ideintr+0xc3>
    idestart(idequeue);
80102b66:	a1 94 bb 10 80       	mov    0x8010bb94,%eax
80102b6b:	83 ec 0c             	sub    $0xc,%esp
80102b6e:	50                   	push   %eax
80102b6f:	e8 1f fe ff ff       	call   80102993 <idestart>
80102b74:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
80102b77:	83 ec 0c             	sub    $0xc,%esp
80102b7a:	68 60 bb 10 80       	push   $0x8010bb60
80102b7f:	e8 a8 23 00 00       	call   80104f2c <release>
80102b84:	83 c4 10             	add    $0x10,%esp
}
80102b87:	c9                   	leave  
80102b88:	c3                   	ret    

80102b89 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102b89:	55                   	push   %ebp
80102b8a:	89 e5                	mov    %esp,%ebp
80102b8c:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
80102b8f:	8b 45 08             	mov    0x8(%ebp),%eax
80102b92:	8b 00                	mov    (%eax),%eax
80102b94:	83 e0 01             	and    $0x1,%eax
80102b97:	85 c0                	test   %eax,%eax
80102b99:	75 0d                	jne    80102ba8 <iderw+0x1f>
    panic("iderw: buf not busy");
80102b9b:	83 ec 0c             	sub    $0xc,%esp
80102b9e:	68 15 87 10 80       	push   $0x80108715
80102ba3:	e8 b4 d9 ff ff       	call   8010055c <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102ba8:	8b 45 08             	mov    0x8(%ebp),%eax
80102bab:	8b 00                	mov    (%eax),%eax
80102bad:	83 e0 06             	and    $0x6,%eax
80102bb0:	83 f8 02             	cmp    $0x2,%eax
80102bb3:	75 0d                	jne    80102bc2 <iderw+0x39>
    panic("iderw: nothing to do");
80102bb5:	83 ec 0c             	sub    $0xc,%esp
80102bb8:	68 29 87 10 80       	push   $0x80108729
80102bbd:	e8 9a d9 ff ff       	call   8010055c <panic>
  if(b->dev != 0 && !havedisk1)
80102bc2:	8b 45 08             	mov    0x8(%ebp),%eax
80102bc5:	8b 40 04             	mov    0x4(%eax),%eax
80102bc8:	85 c0                	test   %eax,%eax
80102bca:	74 16                	je     80102be2 <iderw+0x59>
80102bcc:	a1 98 bb 10 80       	mov    0x8010bb98,%eax
80102bd1:	85 c0                	test   %eax,%eax
80102bd3:	75 0d                	jne    80102be2 <iderw+0x59>
    panic("iderw: ide disk 1 not present");
80102bd5:	83 ec 0c             	sub    $0xc,%esp
80102bd8:	68 3e 87 10 80       	push   $0x8010873e
80102bdd:	e8 7a d9 ff ff       	call   8010055c <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102be2:	83 ec 0c             	sub    $0xc,%esp
80102be5:	68 60 bb 10 80       	push   $0x8010bb60
80102bea:	e8 d7 22 00 00       	call   80104ec6 <acquire>
80102bef:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
80102bf2:	8b 45 08             	mov    0x8(%ebp),%eax
80102bf5:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102bfc:	c7 45 f4 94 bb 10 80 	movl   $0x8010bb94,-0xc(%ebp)
80102c03:	eb 0b                	jmp    80102c10 <iderw+0x87>
80102c05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c08:	8b 00                	mov    (%eax),%eax
80102c0a:	83 c0 14             	add    $0x14,%eax
80102c0d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102c10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c13:	8b 00                	mov    (%eax),%eax
80102c15:	85 c0                	test   %eax,%eax
80102c17:	75 ec                	jne    80102c05 <iderw+0x7c>
    ;
  *pp = b;
80102c19:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c1c:	8b 55 08             	mov    0x8(%ebp),%edx
80102c1f:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
80102c21:	a1 94 bb 10 80       	mov    0x8010bb94,%eax
80102c26:	3b 45 08             	cmp    0x8(%ebp),%eax
80102c29:	75 0e                	jne    80102c39 <iderw+0xb0>
    idestart(b);
80102c2b:	83 ec 0c             	sub    $0xc,%esp
80102c2e:	ff 75 08             	pushl  0x8(%ebp)
80102c31:	e8 5d fd ff ff       	call   80102993 <idestart>
80102c36:	83 c4 10             	add    $0x10,%esp
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102c39:	eb 13                	jmp    80102c4e <iderw+0xc5>
    sleep(b, &idelock);
80102c3b:	83 ec 08             	sub    $0x8,%esp
80102c3e:	68 60 bb 10 80       	push   $0x8010bb60
80102c43:	ff 75 08             	pushl  0x8(%ebp)
80102c46:	e8 79 1f 00 00       	call   80104bc4 <sleep>
80102c4b:	83 c4 10             	add    $0x10,%esp
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102c4e:	8b 45 08             	mov    0x8(%ebp),%eax
80102c51:	8b 00                	mov    (%eax),%eax
80102c53:	83 e0 06             	and    $0x6,%eax
80102c56:	83 f8 02             	cmp    $0x2,%eax
80102c59:	75 e0                	jne    80102c3b <iderw+0xb2>
    sleep(b, &idelock);
  }

  release(&idelock);
80102c5b:	83 ec 0c             	sub    $0xc,%esp
80102c5e:	68 60 bb 10 80       	push   $0x8010bb60
80102c63:	e8 c4 22 00 00       	call   80104f2c <release>
80102c68:	83 c4 10             	add    $0x10,%esp
}
80102c6b:	c9                   	leave  
80102c6c:	c3                   	ret    

80102c6d <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102c6d:	55                   	push   %ebp
80102c6e:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102c70:	a1 d4 fd 10 80       	mov    0x8010fdd4,%eax
80102c75:	8b 55 08             	mov    0x8(%ebp),%edx
80102c78:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102c7a:	a1 d4 fd 10 80       	mov    0x8010fdd4,%eax
80102c7f:	8b 40 10             	mov    0x10(%eax),%eax
}
80102c82:	5d                   	pop    %ebp
80102c83:	c3                   	ret    

80102c84 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102c84:	55                   	push   %ebp
80102c85:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102c87:	a1 d4 fd 10 80       	mov    0x8010fdd4,%eax
80102c8c:	8b 55 08             	mov    0x8(%ebp),%edx
80102c8f:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102c91:	a1 d4 fd 10 80       	mov    0x8010fdd4,%eax
80102c96:	8b 55 0c             	mov    0xc(%ebp),%edx
80102c99:	89 50 10             	mov    %edx,0x10(%eax)
}
80102c9c:	5d                   	pop    %ebp
80102c9d:	c3                   	ret    

80102c9e <ioapicinit>:

void
ioapicinit(void)
{
80102c9e:	55                   	push   %ebp
80102c9f:	89 e5                	mov    %esp,%ebp
80102ca1:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  if(!ismp)
80102ca4:	a1 c4 fe 10 80       	mov    0x8010fec4,%eax
80102ca9:	85 c0                	test   %eax,%eax
80102cab:	75 05                	jne    80102cb2 <ioapicinit+0x14>
    return;
80102cad:	e9 9e 00 00 00       	jmp    80102d50 <ioapicinit+0xb2>

  ioapic = (volatile struct ioapic*)IOAPIC;
80102cb2:	c7 05 d4 fd 10 80 00 	movl   $0xfec00000,0x8010fdd4
80102cb9:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102cbc:	6a 01                	push   $0x1
80102cbe:	e8 aa ff ff ff       	call   80102c6d <ioapicread>
80102cc3:	83 c4 04             	add    $0x4,%esp
80102cc6:	c1 e8 10             	shr    $0x10,%eax
80102cc9:	25 ff 00 00 00       	and    $0xff,%eax
80102cce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80102cd1:	6a 00                	push   $0x0
80102cd3:	e8 95 ff ff ff       	call   80102c6d <ioapicread>
80102cd8:	83 c4 04             	add    $0x4,%esp
80102cdb:	c1 e8 18             	shr    $0x18,%eax
80102cde:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102ce1:	0f b6 05 c0 fe 10 80 	movzbl 0x8010fec0,%eax
80102ce8:	0f b6 c0             	movzbl %al,%eax
80102ceb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80102cee:	74 10                	je     80102d00 <ioapicinit+0x62>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102cf0:	83 ec 0c             	sub    $0xc,%esp
80102cf3:	68 5c 87 10 80       	push   $0x8010875c
80102cf8:	e8 c2 d6 ff ff       	call   801003bf <cprintf>
80102cfd:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102d00:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102d07:	eb 3f                	jmp    80102d48 <ioapicinit+0xaa>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102d09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d0c:	83 c0 20             	add    $0x20,%eax
80102d0f:	0d 00 00 01 00       	or     $0x10000,%eax
80102d14:	89 c2                	mov    %eax,%edx
80102d16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d19:	83 c0 08             	add    $0x8,%eax
80102d1c:	01 c0                	add    %eax,%eax
80102d1e:	83 ec 08             	sub    $0x8,%esp
80102d21:	52                   	push   %edx
80102d22:	50                   	push   %eax
80102d23:	e8 5c ff ff ff       	call   80102c84 <ioapicwrite>
80102d28:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102d2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d2e:	83 c0 08             	add    $0x8,%eax
80102d31:	01 c0                	add    %eax,%eax
80102d33:	83 c0 01             	add    $0x1,%eax
80102d36:	83 ec 08             	sub    $0x8,%esp
80102d39:	6a 00                	push   $0x0
80102d3b:	50                   	push   %eax
80102d3c:	e8 43 ff ff ff       	call   80102c84 <ioapicwrite>
80102d41:	83 c4 10             	add    $0x10,%esp
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102d44:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102d48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d4b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102d4e:	7e b9                	jle    80102d09 <ioapicinit+0x6b>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102d50:	c9                   	leave  
80102d51:	c3                   	ret    

80102d52 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102d52:	55                   	push   %ebp
80102d53:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102d55:	a1 c4 fe 10 80       	mov    0x8010fec4,%eax
80102d5a:	85 c0                	test   %eax,%eax
80102d5c:	75 02                	jne    80102d60 <ioapicenable+0xe>
    return;
80102d5e:	eb 37                	jmp    80102d97 <ioapicenable+0x45>

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102d60:	8b 45 08             	mov    0x8(%ebp),%eax
80102d63:	83 c0 20             	add    $0x20,%eax
80102d66:	89 c2                	mov    %eax,%edx
80102d68:	8b 45 08             	mov    0x8(%ebp),%eax
80102d6b:	83 c0 08             	add    $0x8,%eax
80102d6e:	01 c0                	add    %eax,%eax
80102d70:	52                   	push   %edx
80102d71:	50                   	push   %eax
80102d72:	e8 0d ff ff ff       	call   80102c84 <ioapicwrite>
80102d77:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102d7a:	8b 45 0c             	mov    0xc(%ebp),%eax
80102d7d:	c1 e0 18             	shl    $0x18,%eax
80102d80:	89 c2                	mov    %eax,%edx
80102d82:	8b 45 08             	mov    0x8(%ebp),%eax
80102d85:	83 c0 08             	add    $0x8,%eax
80102d88:	01 c0                	add    %eax,%eax
80102d8a:	83 c0 01             	add    $0x1,%eax
80102d8d:	52                   	push   %edx
80102d8e:	50                   	push   %eax
80102d8f:	e8 f0 fe ff ff       	call   80102c84 <ioapicwrite>
80102d94:	83 c4 08             	add    $0x8,%esp
}
80102d97:	c9                   	leave  
80102d98:	c3                   	ret    

80102d99 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80102d99:	55                   	push   %ebp
80102d9a:	89 e5                	mov    %esp,%ebp
80102d9c:	8b 45 08             	mov    0x8(%ebp),%eax
80102d9f:	05 00 00 00 80       	add    $0x80000000,%eax
80102da4:	5d                   	pop    %ebp
80102da5:	c3                   	ret    

80102da6 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102da6:	55                   	push   %ebp
80102da7:	89 e5                	mov    %esp,%ebp
80102da9:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102dac:	83 ec 08             	sub    $0x8,%esp
80102daf:	68 8e 87 10 80       	push   $0x8010878e
80102db4:	68 e0 fd 10 80       	push   $0x8010fde0
80102db9:	e8 e7 20 00 00       	call   80104ea5 <initlock>
80102dbe:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102dc1:	c7 05 14 fe 10 80 00 	movl   $0x0,0x8010fe14
80102dc8:	00 00 00 
  freerange(vstart, vend);
80102dcb:	83 ec 08             	sub    $0x8,%esp
80102dce:	ff 75 0c             	pushl  0xc(%ebp)
80102dd1:	ff 75 08             	pushl  0x8(%ebp)
80102dd4:	e8 28 00 00 00       	call   80102e01 <freerange>
80102dd9:	83 c4 10             	add    $0x10,%esp
}
80102ddc:	c9                   	leave  
80102ddd:	c3                   	ret    

80102dde <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102dde:	55                   	push   %ebp
80102ddf:	89 e5                	mov    %esp,%ebp
80102de1:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
80102de4:	83 ec 08             	sub    $0x8,%esp
80102de7:	ff 75 0c             	pushl  0xc(%ebp)
80102dea:	ff 75 08             	pushl  0x8(%ebp)
80102ded:	e8 0f 00 00 00       	call   80102e01 <freerange>
80102df2:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
80102df5:	c7 05 14 fe 10 80 01 	movl   $0x1,0x8010fe14
80102dfc:	00 00 00 
}
80102dff:	c9                   	leave  
80102e00:	c3                   	ret    

80102e01 <freerange>:

void
freerange(void *vstart, void *vend)
{
80102e01:	55                   	push   %ebp
80102e02:	89 e5                	mov    %esp,%ebp
80102e04:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102e07:	8b 45 08             	mov    0x8(%ebp),%eax
80102e0a:	05 ff 0f 00 00       	add    $0xfff,%eax
80102e0f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102e14:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102e17:	eb 15                	jmp    80102e2e <freerange+0x2d>
    kfree(p);
80102e19:	83 ec 0c             	sub    $0xc,%esp
80102e1c:	ff 75 f4             	pushl  -0xc(%ebp)
80102e1f:	e8 19 00 00 00       	call   80102e3d <kfree>
80102e24:	83 c4 10             	add    $0x10,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102e27:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102e2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e31:	05 00 10 00 00       	add    $0x1000,%eax
80102e36:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102e39:	76 de                	jbe    80102e19 <freerange+0x18>
    kfree(p);
}
80102e3b:	c9                   	leave  
80102e3c:	c3                   	ret    

80102e3d <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102e3d:	55                   	push   %ebp
80102e3e:	89 e5                	mov    %esp,%ebp
80102e40:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102e43:	8b 45 08             	mov    0x8(%ebp),%eax
80102e46:	25 ff 0f 00 00       	and    $0xfff,%eax
80102e4b:	85 c0                	test   %eax,%eax
80102e4d:	75 1b                	jne    80102e6a <kfree+0x2d>
80102e4f:	81 7d 08 dc 2c 11 80 	cmpl   $0x80112cdc,0x8(%ebp)
80102e56:	72 12                	jb     80102e6a <kfree+0x2d>
80102e58:	ff 75 08             	pushl  0x8(%ebp)
80102e5b:	e8 39 ff ff ff       	call   80102d99 <v2p>
80102e60:	83 c4 04             	add    $0x4,%esp
80102e63:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102e68:	76 0d                	jbe    80102e77 <kfree+0x3a>
    panic("kfree");
80102e6a:	83 ec 0c             	sub    $0xc,%esp
80102e6d:	68 93 87 10 80       	push   $0x80108793
80102e72:	e8 e5 d6 ff ff       	call   8010055c <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102e77:	83 ec 04             	sub    $0x4,%esp
80102e7a:	68 00 10 00 00       	push   $0x1000
80102e7f:	6a 01                	push   $0x1
80102e81:	ff 75 08             	pushl  0x8(%ebp)
80102e84:	e8 99 22 00 00       	call   80105122 <memset>
80102e89:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102e8c:	a1 14 fe 10 80       	mov    0x8010fe14,%eax
80102e91:	85 c0                	test   %eax,%eax
80102e93:	74 10                	je     80102ea5 <kfree+0x68>
    acquire(&kmem.lock);
80102e95:	83 ec 0c             	sub    $0xc,%esp
80102e98:	68 e0 fd 10 80       	push   $0x8010fde0
80102e9d:	e8 24 20 00 00       	call   80104ec6 <acquire>
80102ea2:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102ea5:	8b 45 08             	mov    0x8(%ebp),%eax
80102ea8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102eab:	8b 15 18 fe 10 80    	mov    0x8010fe18,%edx
80102eb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102eb4:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102eb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102eb9:	a3 18 fe 10 80       	mov    %eax,0x8010fe18
  if(kmem.use_lock)
80102ebe:	a1 14 fe 10 80       	mov    0x8010fe14,%eax
80102ec3:	85 c0                	test   %eax,%eax
80102ec5:	74 10                	je     80102ed7 <kfree+0x9a>
    release(&kmem.lock);
80102ec7:	83 ec 0c             	sub    $0xc,%esp
80102eca:	68 e0 fd 10 80       	push   $0x8010fde0
80102ecf:	e8 58 20 00 00       	call   80104f2c <release>
80102ed4:	83 c4 10             	add    $0x10,%esp
}
80102ed7:	c9                   	leave  
80102ed8:	c3                   	ret    

80102ed9 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102ed9:	55                   	push   %ebp
80102eda:	89 e5                	mov    %esp,%ebp
80102edc:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102edf:	a1 14 fe 10 80       	mov    0x8010fe14,%eax
80102ee4:	85 c0                	test   %eax,%eax
80102ee6:	74 10                	je     80102ef8 <kalloc+0x1f>
    acquire(&kmem.lock);
80102ee8:	83 ec 0c             	sub    $0xc,%esp
80102eeb:	68 e0 fd 10 80       	push   $0x8010fde0
80102ef0:	e8 d1 1f 00 00       	call   80104ec6 <acquire>
80102ef5:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102ef8:	a1 18 fe 10 80       	mov    0x8010fe18,%eax
80102efd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102f00:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102f04:	74 0a                	je     80102f10 <kalloc+0x37>
    kmem.freelist = r->next;
80102f06:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f09:	8b 00                	mov    (%eax),%eax
80102f0b:	a3 18 fe 10 80       	mov    %eax,0x8010fe18
  if(kmem.use_lock)
80102f10:	a1 14 fe 10 80       	mov    0x8010fe14,%eax
80102f15:	85 c0                	test   %eax,%eax
80102f17:	74 10                	je     80102f29 <kalloc+0x50>
    release(&kmem.lock);
80102f19:	83 ec 0c             	sub    $0xc,%esp
80102f1c:	68 e0 fd 10 80       	push   $0x8010fde0
80102f21:	e8 06 20 00 00       	call   80104f2c <release>
80102f26:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80102f29:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102f2c:	c9                   	leave  
80102f2d:	c3                   	ret    

80102f2e <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102f2e:	55                   	push   %ebp
80102f2f:	89 e5                	mov    %esp,%ebp
80102f31:	83 ec 14             	sub    $0x14,%esp
80102f34:	8b 45 08             	mov    0x8(%ebp),%eax
80102f37:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f3b:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102f3f:	89 c2                	mov    %eax,%edx
80102f41:	ec                   	in     (%dx),%al
80102f42:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102f45:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102f49:	c9                   	leave  
80102f4a:	c3                   	ret    

80102f4b <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102f4b:	55                   	push   %ebp
80102f4c:	89 e5                	mov    %esp,%ebp
80102f4e:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102f51:	6a 64                	push   $0x64
80102f53:	e8 d6 ff ff ff       	call   80102f2e <inb>
80102f58:	83 c4 04             	add    $0x4,%esp
80102f5b:	0f b6 c0             	movzbl %al,%eax
80102f5e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102f61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f64:	83 e0 01             	and    $0x1,%eax
80102f67:	85 c0                	test   %eax,%eax
80102f69:	75 0a                	jne    80102f75 <kbdgetc+0x2a>
    return -1;
80102f6b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102f70:	e9 23 01 00 00       	jmp    80103098 <kbdgetc+0x14d>
  data = inb(KBDATAP);
80102f75:	6a 60                	push   $0x60
80102f77:	e8 b2 ff ff ff       	call   80102f2e <inb>
80102f7c:	83 c4 04             	add    $0x4,%esp
80102f7f:	0f b6 c0             	movzbl %al,%eax
80102f82:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102f85:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102f8c:	75 17                	jne    80102fa5 <kbdgetc+0x5a>
    shift |= E0ESC;
80102f8e:	a1 9c bb 10 80       	mov    0x8010bb9c,%eax
80102f93:	83 c8 40             	or     $0x40,%eax
80102f96:	a3 9c bb 10 80       	mov    %eax,0x8010bb9c
    return 0;
80102f9b:	b8 00 00 00 00       	mov    $0x0,%eax
80102fa0:	e9 f3 00 00 00       	jmp    80103098 <kbdgetc+0x14d>
  } else if(data & 0x80){
80102fa5:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102fa8:	25 80 00 00 00       	and    $0x80,%eax
80102fad:	85 c0                	test   %eax,%eax
80102faf:	74 45                	je     80102ff6 <kbdgetc+0xab>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102fb1:	a1 9c bb 10 80       	mov    0x8010bb9c,%eax
80102fb6:	83 e0 40             	and    $0x40,%eax
80102fb9:	85 c0                	test   %eax,%eax
80102fbb:	75 08                	jne    80102fc5 <kbdgetc+0x7a>
80102fbd:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102fc0:	83 e0 7f             	and    $0x7f,%eax
80102fc3:	eb 03                	jmp    80102fc8 <kbdgetc+0x7d>
80102fc5:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102fc8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102fcb:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102fce:	05 40 90 10 80       	add    $0x80109040,%eax
80102fd3:	0f b6 00             	movzbl (%eax),%eax
80102fd6:	83 c8 40             	or     $0x40,%eax
80102fd9:	0f b6 c0             	movzbl %al,%eax
80102fdc:	f7 d0                	not    %eax
80102fde:	89 c2                	mov    %eax,%edx
80102fe0:	a1 9c bb 10 80       	mov    0x8010bb9c,%eax
80102fe5:	21 d0                	and    %edx,%eax
80102fe7:	a3 9c bb 10 80       	mov    %eax,0x8010bb9c
    return 0;
80102fec:	b8 00 00 00 00       	mov    $0x0,%eax
80102ff1:	e9 a2 00 00 00       	jmp    80103098 <kbdgetc+0x14d>
  } else if(shift & E0ESC){
80102ff6:	a1 9c bb 10 80       	mov    0x8010bb9c,%eax
80102ffb:	83 e0 40             	and    $0x40,%eax
80102ffe:	85 c0                	test   %eax,%eax
80103000:	74 14                	je     80103016 <kbdgetc+0xcb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80103002:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80103009:	a1 9c bb 10 80       	mov    0x8010bb9c,%eax
8010300e:	83 e0 bf             	and    $0xffffffbf,%eax
80103011:	a3 9c bb 10 80       	mov    %eax,0x8010bb9c
  }

  shift |= shiftcode[data];
80103016:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103019:	05 40 90 10 80       	add    $0x80109040,%eax
8010301e:	0f b6 00             	movzbl (%eax),%eax
80103021:	0f b6 d0             	movzbl %al,%edx
80103024:	a1 9c bb 10 80       	mov    0x8010bb9c,%eax
80103029:	09 d0                	or     %edx,%eax
8010302b:	a3 9c bb 10 80       	mov    %eax,0x8010bb9c
  shift ^= togglecode[data];
80103030:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103033:	05 40 91 10 80       	add    $0x80109140,%eax
80103038:	0f b6 00             	movzbl (%eax),%eax
8010303b:	0f b6 d0             	movzbl %al,%edx
8010303e:	a1 9c bb 10 80       	mov    0x8010bb9c,%eax
80103043:	31 d0                	xor    %edx,%eax
80103045:	a3 9c bb 10 80       	mov    %eax,0x8010bb9c
  c = charcode[shift & (CTL | SHIFT)][data];
8010304a:	a1 9c bb 10 80       	mov    0x8010bb9c,%eax
8010304f:	83 e0 03             	and    $0x3,%eax
80103052:	8b 14 85 40 95 10 80 	mov    -0x7fef6ac0(,%eax,4),%edx
80103059:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010305c:	01 d0                	add    %edx,%eax
8010305e:	0f b6 00             	movzbl (%eax),%eax
80103061:	0f b6 c0             	movzbl %al,%eax
80103064:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80103067:	a1 9c bb 10 80       	mov    0x8010bb9c,%eax
8010306c:	83 e0 08             	and    $0x8,%eax
8010306f:	85 c0                	test   %eax,%eax
80103071:	74 22                	je     80103095 <kbdgetc+0x14a>
    if('a' <= c && c <= 'z')
80103073:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80103077:	76 0c                	jbe    80103085 <kbdgetc+0x13a>
80103079:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
8010307d:	77 06                	ja     80103085 <kbdgetc+0x13a>
      c += 'A' - 'a';
8010307f:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80103083:	eb 10                	jmp    80103095 <kbdgetc+0x14a>
    else if('A' <= c && c <= 'Z')
80103085:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80103089:	76 0a                	jbe    80103095 <kbdgetc+0x14a>
8010308b:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
8010308f:	77 04                	ja     80103095 <kbdgetc+0x14a>
      c += 'a' - 'A';
80103091:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80103095:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103098:	c9                   	leave  
80103099:	c3                   	ret    

8010309a <kbdintr>:

void
kbdintr(void)
{
8010309a:	55                   	push   %ebp
8010309b:	89 e5                	mov    %esp,%ebp
8010309d:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
801030a0:	83 ec 0c             	sub    $0xc,%esp
801030a3:	68 4b 2f 10 80       	push   $0x80102f4b
801030a8:	e8 24 d7 ff ff       	call   801007d1 <consoleintr>
801030ad:	83 c4 10             	add    $0x10,%esp
}
801030b0:	c9                   	leave  
801030b1:	c3                   	ret    

801030b2 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801030b2:	55                   	push   %ebp
801030b3:	89 e5                	mov    %esp,%ebp
801030b5:	83 ec 08             	sub    $0x8,%esp
801030b8:	8b 55 08             	mov    0x8(%ebp),%edx
801030bb:	8b 45 0c             	mov    0xc(%ebp),%eax
801030be:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801030c2:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030c5:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801030c9:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801030cd:	ee                   	out    %al,(%dx)
}
801030ce:	c9                   	leave  
801030cf:	c3                   	ret    

801030d0 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
801030d0:	55                   	push   %ebp
801030d1:	89 e5                	mov    %esp,%ebp
801030d3:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801030d6:	9c                   	pushf  
801030d7:	58                   	pop    %eax
801030d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801030db:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801030de:	c9                   	leave  
801030df:	c3                   	ret    

801030e0 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
801030e0:	55                   	push   %ebp
801030e1:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
801030e3:	a1 1c fe 10 80       	mov    0x8010fe1c,%eax
801030e8:	8b 55 08             	mov    0x8(%ebp),%edx
801030eb:	c1 e2 02             	shl    $0x2,%edx
801030ee:	01 c2                	add    %eax,%edx
801030f0:	8b 45 0c             	mov    0xc(%ebp),%eax
801030f3:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
801030f5:	a1 1c fe 10 80       	mov    0x8010fe1c,%eax
801030fa:	83 c0 20             	add    $0x20,%eax
801030fd:	8b 00                	mov    (%eax),%eax
}
801030ff:	5d                   	pop    %ebp
80103100:	c3                   	ret    

80103101 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80103101:	55                   	push   %ebp
80103102:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
80103104:	a1 1c fe 10 80       	mov    0x8010fe1c,%eax
80103109:	85 c0                	test   %eax,%eax
8010310b:	75 05                	jne    80103112 <lapicinit+0x11>
    return;
8010310d:	e9 09 01 00 00       	jmp    8010321b <lapicinit+0x11a>

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80103112:	68 3f 01 00 00       	push   $0x13f
80103117:	6a 3c                	push   $0x3c
80103119:	e8 c2 ff ff ff       	call   801030e0 <lapicw>
8010311e:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80103121:	6a 0b                	push   $0xb
80103123:	68 f8 00 00 00       	push   $0xf8
80103128:	e8 b3 ff ff ff       	call   801030e0 <lapicw>
8010312d:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80103130:	68 20 00 02 00       	push   $0x20020
80103135:	68 c8 00 00 00       	push   $0xc8
8010313a:	e8 a1 ff ff ff       	call   801030e0 <lapicw>
8010313f:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000); 
80103142:	68 80 96 98 00       	push   $0x989680
80103147:	68 e0 00 00 00       	push   $0xe0
8010314c:	e8 8f ff ff ff       	call   801030e0 <lapicw>
80103151:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80103154:	68 00 00 01 00       	push   $0x10000
80103159:	68 d4 00 00 00       	push   $0xd4
8010315e:	e8 7d ff ff ff       	call   801030e0 <lapicw>
80103163:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
80103166:	68 00 00 01 00       	push   $0x10000
8010316b:	68 d8 00 00 00       	push   $0xd8
80103170:	e8 6b ff ff ff       	call   801030e0 <lapicw>
80103175:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80103178:	a1 1c fe 10 80       	mov    0x8010fe1c,%eax
8010317d:	83 c0 30             	add    $0x30,%eax
80103180:	8b 00                	mov    (%eax),%eax
80103182:	c1 e8 10             	shr    $0x10,%eax
80103185:	0f b6 c0             	movzbl %al,%eax
80103188:	83 f8 03             	cmp    $0x3,%eax
8010318b:	76 12                	jbe    8010319f <lapicinit+0x9e>
    lapicw(PCINT, MASKED);
8010318d:	68 00 00 01 00       	push   $0x10000
80103192:	68 d0 00 00 00       	push   $0xd0
80103197:	e8 44 ff ff ff       	call   801030e0 <lapicw>
8010319c:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
8010319f:	6a 33                	push   $0x33
801031a1:	68 dc 00 00 00       	push   $0xdc
801031a6:	e8 35 ff ff ff       	call   801030e0 <lapicw>
801031ab:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
801031ae:	6a 00                	push   $0x0
801031b0:	68 a0 00 00 00       	push   $0xa0
801031b5:	e8 26 ff ff ff       	call   801030e0 <lapicw>
801031ba:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
801031bd:	6a 00                	push   $0x0
801031bf:	68 a0 00 00 00       	push   $0xa0
801031c4:	e8 17 ff ff ff       	call   801030e0 <lapicw>
801031c9:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
801031cc:	6a 00                	push   $0x0
801031ce:	6a 2c                	push   $0x2c
801031d0:	e8 0b ff ff ff       	call   801030e0 <lapicw>
801031d5:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
801031d8:	6a 00                	push   $0x0
801031da:	68 c4 00 00 00       	push   $0xc4
801031df:	e8 fc fe ff ff       	call   801030e0 <lapicw>
801031e4:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
801031e7:	68 00 85 08 00       	push   $0x88500
801031ec:	68 c0 00 00 00       	push   $0xc0
801031f1:	e8 ea fe ff ff       	call   801030e0 <lapicw>
801031f6:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
801031f9:	90                   	nop
801031fa:	a1 1c fe 10 80       	mov    0x8010fe1c,%eax
801031ff:	05 00 03 00 00       	add    $0x300,%eax
80103204:	8b 00                	mov    (%eax),%eax
80103206:	25 00 10 00 00       	and    $0x1000,%eax
8010320b:	85 c0                	test   %eax,%eax
8010320d:	75 eb                	jne    801031fa <lapicinit+0xf9>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
8010320f:	6a 00                	push   $0x0
80103211:	6a 20                	push   $0x20
80103213:	e8 c8 fe ff ff       	call   801030e0 <lapicw>
80103218:	83 c4 08             	add    $0x8,%esp
}
8010321b:	c9                   	leave  
8010321c:	c3                   	ret    

8010321d <cpunum>:

int
cpunum(void)
{
8010321d:	55                   	push   %ebp
8010321e:	89 e5                	mov    %esp,%ebp
80103220:	83 ec 08             	sub    $0x8,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80103223:	e8 a8 fe ff ff       	call   801030d0 <readeflags>
80103228:	25 00 02 00 00       	and    $0x200,%eax
8010322d:	85 c0                	test   %eax,%eax
8010322f:	74 26                	je     80103257 <cpunum+0x3a>
    static int n;
    if(n++ == 0)
80103231:	a1 a0 bb 10 80       	mov    0x8010bba0,%eax
80103236:	8d 50 01             	lea    0x1(%eax),%edx
80103239:	89 15 a0 bb 10 80    	mov    %edx,0x8010bba0
8010323f:	85 c0                	test   %eax,%eax
80103241:	75 14                	jne    80103257 <cpunum+0x3a>
      cprintf("cpu called from %x with interrupts enabled\n",
80103243:	8b 45 04             	mov    0x4(%ebp),%eax
80103246:	83 ec 08             	sub    $0x8,%esp
80103249:	50                   	push   %eax
8010324a:	68 9c 87 10 80       	push   $0x8010879c
8010324f:	e8 6b d1 ff ff       	call   801003bf <cprintf>
80103254:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
80103257:	a1 1c fe 10 80       	mov    0x8010fe1c,%eax
8010325c:	85 c0                	test   %eax,%eax
8010325e:	74 0f                	je     8010326f <cpunum+0x52>
    return lapic[ID]>>24;
80103260:	a1 1c fe 10 80       	mov    0x8010fe1c,%eax
80103265:	83 c0 20             	add    $0x20,%eax
80103268:	8b 00                	mov    (%eax),%eax
8010326a:	c1 e8 18             	shr    $0x18,%eax
8010326d:	eb 05                	jmp    80103274 <cpunum+0x57>
  return 0;
8010326f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103274:	c9                   	leave  
80103275:	c3                   	ret    

80103276 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80103276:	55                   	push   %ebp
80103277:	89 e5                	mov    %esp,%ebp
  if(lapic)
80103279:	a1 1c fe 10 80       	mov    0x8010fe1c,%eax
8010327e:	85 c0                	test   %eax,%eax
80103280:	74 0c                	je     8010328e <lapiceoi+0x18>
    lapicw(EOI, 0);
80103282:	6a 00                	push   $0x0
80103284:	6a 2c                	push   $0x2c
80103286:	e8 55 fe ff ff       	call   801030e0 <lapicw>
8010328b:	83 c4 08             	add    $0x8,%esp
}
8010328e:	c9                   	leave  
8010328f:	c3                   	ret    

80103290 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80103290:	55                   	push   %ebp
80103291:	89 e5                	mov    %esp,%ebp
}
80103293:	5d                   	pop    %ebp
80103294:	c3                   	ret    

80103295 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103295:	55                   	push   %ebp
80103296:	89 e5                	mov    %esp,%ebp
80103298:	83 ec 14             	sub    $0x14,%esp
8010329b:	8b 45 08             	mov    0x8(%ebp),%eax
8010329e:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
801032a1:	6a 0f                	push   $0xf
801032a3:	6a 70                	push   $0x70
801032a5:	e8 08 fe ff ff       	call   801030b2 <outb>
801032aa:	83 c4 08             	add    $0x8,%esp
  outb(IO_RTC+1, 0x0A);
801032ad:	6a 0a                	push   $0xa
801032af:	6a 71                	push   $0x71
801032b1:	e8 fc fd ff ff       	call   801030b2 <outb>
801032b6:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
801032b9:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
801032c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
801032c3:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
801032c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
801032cb:	83 c0 02             	add    $0x2,%eax
801032ce:	8b 55 0c             	mov    0xc(%ebp),%edx
801032d1:	c1 ea 04             	shr    $0x4,%edx
801032d4:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801032d7:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
801032db:	c1 e0 18             	shl    $0x18,%eax
801032de:	50                   	push   %eax
801032df:	68 c4 00 00 00       	push   $0xc4
801032e4:	e8 f7 fd ff ff       	call   801030e0 <lapicw>
801032e9:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
801032ec:	68 00 c5 00 00       	push   $0xc500
801032f1:	68 c0 00 00 00       	push   $0xc0
801032f6:	e8 e5 fd ff ff       	call   801030e0 <lapicw>
801032fb:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
801032fe:	68 c8 00 00 00       	push   $0xc8
80103303:	e8 88 ff ff ff       	call   80103290 <microdelay>
80103308:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
8010330b:	68 00 85 00 00       	push   $0x8500
80103310:	68 c0 00 00 00       	push   $0xc0
80103315:	e8 c6 fd ff ff       	call   801030e0 <lapicw>
8010331a:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
8010331d:	6a 64                	push   $0x64
8010331f:	e8 6c ff ff ff       	call   80103290 <microdelay>
80103324:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80103327:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010332e:	eb 3d                	jmp    8010336d <lapicstartap+0xd8>
    lapicw(ICRHI, apicid<<24);
80103330:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103334:	c1 e0 18             	shl    $0x18,%eax
80103337:	50                   	push   %eax
80103338:	68 c4 00 00 00       	push   $0xc4
8010333d:	e8 9e fd ff ff       	call   801030e0 <lapicw>
80103342:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
80103345:	8b 45 0c             	mov    0xc(%ebp),%eax
80103348:	c1 e8 0c             	shr    $0xc,%eax
8010334b:	80 cc 06             	or     $0x6,%ah
8010334e:	50                   	push   %eax
8010334f:	68 c0 00 00 00       	push   $0xc0
80103354:	e8 87 fd ff ff       	call   801030e0 <lapicw>
80103359:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
8010335c:	68 c8 00 00 00       	push   $0xc8
80103361:	e8 2a ff ff ff       	call   80103290 <microdelay>
80103366:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80103369:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010336d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
80103371:	7e bd                	jle    80103330 <lapicstartap+0x9b>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80103373:	c9                   	leave  
80103374:	c3                   	ret    

80103375 <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
80103375:	55                   	push   %ebp
80103376:	89 e5                	mov    %esp,%ebp
80103378:	83 ec 18             	sub    $0x18,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
8010337b:	83 ec 08             	sub    $0x8,%esp
8010337e:	68 c8 87 10 80       	push   $0x801087c8
80103383:	68 40 fe 10 80       	push   $0x8010fe40
80103388:	e8 18 1b 00 00       	call   80104ea5 <initlock>
8010338d:	83 c4 10             	add    $0x10,%esp
  readsb(ROOTDEV, &sb);
80103390:	83 ec 08             	sub    $0x8,%esp
80103393:	8d 45 e8             	lea    -0x18(%ebp),%eax
80103396:	50                   	push   %eax
80103397:	6a 01                	push   $0x1
80103399:	e8 f4 e2 ff ff       	call   80101692 <readsb>
8010339e:	83 c4 10             	add    $0x10,%esp
  log.start = sb.size - sb.nlog;
801033a1:	8b 55 e8             	mov    -0x18(%ebp),%edx
801033a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801033a7:	29 c2                	sub    %eax,%edx
801033a9:	89 d0                	mov    %edx,%eax
801033ab:	a3 74 fe 10 80       	mov    %eax,0x8010fe74
  log.size = sb.nlog;
801033b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801033b3:	a3 78 fe 10 80       	mov    %eax,0x8010fe78
  log.dev = ROOTDEV;
801033b8:	c7 05 80 fe 10 80 01 	movl   $0x1,0x8010fe80
801033bf:	00 00 00 
  recover_from_log();
801033c2:	e8 ae 01 00 00       	call   80103575 <recover_from_log>
}
801033c7:	c9                   	leave  
801033c8:	c3                   	ret    

801033c9 <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
801033c9:	55                   	push   %ebp
801033ca:	89 e5                	mov    %esp,%ebp
801033cc:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801033cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801033d6:	e9 95 00 00 00       	jmp    80103470 <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801033db:	8b 15 74 fe 10 80    	mov    0x8010fe74,%edx
801033e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801033e4:	01 d0                	add    %edx,%eax
801033e6:	83 c0 01             	add    $0x1,%eax
801033e9:	89 c2                	mov    %eax,%edx
801033eb:	a1 80 fe 10 80       	mov    0x8010fe80,%eax
801033f0:	83 ec 08             	sub    $0x8,%esp
801033f3:	52                   	push   %edx
801033f4:	50                   	push   %eax
801033f5:	e8 ba cd ff ff       	call   801001b4 <bread>
801033fa:	83 c4 10             	add    $0x10,%esp
801033fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
80103400:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103403:	83 c0 10             	add    $0x10,%eax
80103406:	8b 04 85 48 fe 10 80 	mov    -0x7fef01b8(,%eax,4),%eax
8010340d:	89 c2                	mov    %eax,%edx
8010340f:	a1 80 fe 10 80       	mov    0x8010fe80,%eax
80103414:	83 ec 08             	sub    $0x8,%esp
80103417:	52                   	push   %edx
80103418:	50                   	push   %eax
80103419:	e8 96 cd ff ff       	call   801001b4 <bread>
8010341e:	83 c4 10             	add    $0x10,%esp
80103421:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103424:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103427:	8d 50 18             	lea    0x18(%eax),%edx
8010342a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010342d:	83 c0 18             	add    $0x18,%eax
80103430:	83 ec 04             	sub    $0x4,%esp
80103433:	68 00 02 00 00       	push   $0x200
80103438:	52                   	push   %edx
80103439:	50                   	push   %eax
8010343a:	e8 a2 1d 00 00       	call   801051e1 <memmove>
8010343f:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
80103442:	83 ec 0c             	sub    $0xc,%esp
80103445:	ff 75 ec             	pushl  -0x14(%ebp)
80103448:	e8 a0 cd ff ff       	call   801001ed <bwrite>
8010344d:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf); 
80103450:	83 ec 0c             	sub    $0xc,%esp
80103453:	ff 75 f0             	pushl  -0x10(%ebp)
80103456:	e8 d0 cd ff ff       	call   8010022b <brelse>
8010345b:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
8010345e:	83 ec 0c             	sub    $0xc,%esp
80103461:	ff 75 ec             	pushl  -0x14(%ebp)
80103464:	e8 c2 cd ff ff       	call   8010022b <brelse>
80103469:	83 c4 10             	add    $0x10,%esp
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010346c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103470:	a1 84 fe 10 80       	mov    0x8010fe84,%eax
80103475:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103478:	0f 8f 5d ff ff ff    	jg     801033db <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
8010347e:	c9                   	leave  
8010347f:	c3                   	ret    

80103480 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
80103480:	55                   	push   %ebp
80103481:	89 e5                	mov    %esp,%ebp
80103483:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103486:	a1 74 fe 10 80       	mov    0x8010fe74,%eax
8010348b:	89 c2                	mov    %eax,%edx
8010348d:	a1 80 fe 10 80       	mov    0x8010fe80,%eax
80103492:	83 ec 08             	sub    $0x8,%esp
80103495:	52                   	push   %edx
80103496:	50                   	push   %eax
80103497:	e8 18 cd ff ff       	call   801001b4 <bread>
8010349c:	83 c4 10             	add    $0x10,%esp
8010349f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
801034a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801034a5:	83 c0 18             	add    $0x18,%eax
801034a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
801034ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034ae:	8b 00                	mov    (%eax),%eax
801034b0:	a3 84 fe 10 80       	mov    %eax,0x8010fe84
  for (i = 0; i < log.lh.n; i++) {
801034b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801034bc:	eb 1b                	jmp    801034d9 <read_head+0x59>
    log.lh.sector[i] = lh->sector[i];
801034be:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801034c4:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
801034c8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801034cb:	83 c2 10             	add    $0x10,%edx
801034ce:	89 04 95 48 fe 10 80 	mov    %eax,-0x7fef01b8(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
801034d5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801034d9:	a1 84 fe 10 80       	mov    0x8010fe84,%eax
801034de:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801034e1:	7f db                	jg     801034be <read_head+0x3e>
    log.lh.sector[i] = lh->sector[i];
  }
  brelse(buf);
801034e3:	83 ec 0c             	sub    $0xc,%esp
801034e6:	ff 75 f0             	pushl  -0x10(%ebp)
801034e9:	e8 3d cd ff ff       	call   8010022b <brelse>
801034ee:	83 c4 10             	add    $0x10,%esp
}
801034f1:	c9                   	leave  
801034f2:	c3                   	ret    

801034f3 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
801034f3:	55                   	push   %ebp
801034f4:	89 e5                	mov    %esp,%ebp
801034f6:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
801034f9:	a1 74 fe 10 80       	mov    0x8010fe74,%eax
801034fe:	89 c2                	mov    %eax,%edx
80103500:	a1 80 fe 10 80       	mov    0x8010fe80,%eax
80103505:	83 ec 08             	sub    $0x8,%esp
80103508:	52                   	push   %edx
80103509:	50                   	push   %eax
8010350a:	e8 a5 cc ff ff       	call   801001b4 <bread>
8010350f:	83 c4 10             	add    $0x10,%esp
80103512:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
80103515:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103518:	83 c0 18             	add    $0x18,%eax
8010351b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
8010351e:	8b 15 84 fe 10 80    	mov    0x8010fe84,%edx
80103524:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103527:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103529:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103530:	eb 1b                	jmp    8010354d <write_head+0x5a>
    hb->sector[i] = log.lh.sector[i];
80103532:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103535:	83 c0 10             	add    $0x10,%eax
80103538:	8b 0c 85 48 fe 10 80 	mov    -0x7fef01b8(,%eax,4),%ecx
8010353f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103542:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103545:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103549:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010354d:	a1 84 fe 10 80       	mov    0x8010fe84,%eax
80103552:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103555:	7f db                	jg     80103532 <write_head+0x3f>
    hb->sector[i] = log.lh.sector[i];
  }
  bwrite(buf);
80103557:	83 ec 0c             	sub    $0xc,%esp
8010355a:	ff 75 f0             	pushl  -0x10(%ebp)
8010355d:	e8 8b cc ff ff       	call   801001ed <bwrite>
80103562:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
80103565:	83 ec 0c             	sub    $0xc,%esp
80103568:	ff 75 f0             	pushl  -0x10(%ebp)
8010356b:	e8 bb cc ff ff       	call   8010022b <brelse>
80103570:	83 c4 10             	add    $0x10,%esp
}
80103573:	c9                   	leave  
80103574:	c3                   	ret    

80103575 <recover_from_log>:

static void
recover_from_log(void)
{
80103575:	55                   	push   %ebp
80103576:	89 e5                	mov    %esp,%ebp
80103578:	83 ec 08             	sub    $0x8,%esp
  read_head();      
8010357b:	e8 00 ff ff ff       	call   80103480 <read_head>
  install_trans(); // if committed, copy from log to disk
80103580:	e8 44 fe ff ff       	call   801033c9 <install_trans>
  log.lh.n = 0;
80103585:	c7 05 84 fe 10 80 00 	movl   $0x0,0x8010fe84
8010358c:	00 00 00 
  write_head(); // clear the log
8010358f:	e8 5f ff ff ff       	call   801034f3 <write_head>
}
80103594:	c9                   	leave  
80103595:	c3                   	ret    

80103596 <begin_trans>:

void
begin_trans(void)
{
80103596:	55                   	push   %ebp
80103597:	89 e5                	mov    %esp,%ebp
80103599:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
8010359c:	83 ec 0c             	sub    $0xc,%esp
8010359f:	68 40 fe 10 80       	push   $0x8010fe40
801035a4:	e8 1d 19 00 00       	call   80104ec6 <acquire>
801035a9:	83 c4 10             	add    $0x10,%esp
  while (log.busy) {
801035ac:	eb 15                	jmp    801035c3 <begin_trans+0x2d>
    sleep(&log, &log.lock);
801035ae:	83 ec 08             	sub    $0x8,%esp
801035b1:	68 40 fe 10 80       	push   $0x8010fe40
801035b6:	68 40 fe 10 80       	push   $0x8010fe40
801035bb:	e8 04 16 00 00       	call   80104bc4 <sleep>
801035c0:	83 c4 10             	add    $0x10,%esp

void
begin_trans(void)
{
  acquire(&log.lock);
  while (log.busy) {
801035c3:	a1 7c fe 10 80       	mov    0x8010fe7c,%eax
801035c8:	85 c0                	test   %eax,%eax
801035ca:	75 e2                	jne    801035ae <begin_trans+0x18>
    sleep(&log, &log.lock);
  }
  log.busy = 1;
801035cc:	c7 05 7c fe 10 80 01 	movl   $0x1,0x8010fe7c
801035d3:	00 00 00 
  release(&log.lock);
801035d6:	83 ec 0c             	sub    $0xc,%esp
801035d9:	68 40 fe 10 80       	push   $0x8010fe40
801035de:	e8 49 19 00 00       	call   80104f2c <release>
801035e3:	83 c4 10             	add    $0x10,%esp
}
801035e6:	c9                   	leave  
801035e7:	c3                   	ret    

801035e8 <commit_trans>:

void
commit_trans(void)
{
801035e8:	55                   	push   %ebp
801035e9:	89 e5                	mov    %esp,%ebp
801035eb:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
801035ee:	a1 84 fe 10 80       	mov    0x8010fe84,%eax
801035f3:	85 c0                	test   %eax,%eax
801035f5:	7e 19                	jle    80103610 <commit_trans+0x28>
    write_head();    // Write header to disk -- the real commit
801035f7:	e8 f7 fe ff ff       	call   801034f3 <write_head>
    install_trans(); // Now install writes to home locations
801035fc:	e8 c8 fd ff ff       	call   801033c9 <install_trans>
    log.lh.n = 0; 
80103601:	c7 05 84 fe 10 80 00 	movl   $0x0,0x8010fe84
80103608:	00 00 00 
    write_head();    // Erase the transaction from the log
8010360b:	e8 e3 fe ff ff       	call   801034f3 <write_head>
  }
  
  acquire(&log.lock);
80103610:	83 ec 0c             	sub    $0xc,%esp
80103613:	68 40 fe 10 80       	push   $0x8010fe40
80103618:	e8 a9 18 00 00       	call   80104ec6 <acquire>
8010361d:	83 c4 10             	add    $0x10,%esp
  log.busy = 0;
80103620:	c7 05 7c fe 10 80 00 	movl   $0x0,0x8010fe7c
80103627:	00 00 00 
  wakeup(&log);
8010362a:	83 ec 0c             	sub    $0xc,%esp
8010362d:	68 40 fe 10 80       	push   $0x8010fe40
80103632:	e8 76 16 00 00       	call   80104cad <wakeup>
80103637:	83 c4 10             	add    $0x10,%esp
  release(&log.lock);
8010363a:	83 ec 0c             	sub    $0xc,%esp
8010363d:	68 40 fe 10 80       	push   $0x8010fe40
80103642:	e8 e5 18 00 00       	call   80104f2c <release>
80103647:	83 c4 10             	add    $0x10,%esp
}
8010364a:	c9                   	leave  
8010364b:	c3                   	ret    

8010364c <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
8010364c:	55                   	push   %ebp
8010364d:	89 e5                	mov    %esp,%ebp
8010364f:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103652:	a1 84 fe 10 80       	mov    0x8010fe84,%eax
80103657:	83 f8 09             	cmp    $0x9,%eax
8010365a:	7f 12                	jg     8010366e <log_write+0x22>
8010365c:	a1 84 fe 10 80       	mov    0x8010fe84,%eax
80103661:	8b 15 78 fe 10 80    	mov    0x8010fe78,%edx
80103667:	83 ea 01             	sub    $0x1,%edx
8010366a:	39 d0                	cmp    %edx,%eax
8010366c:	7c 0d                	jl     8010367b <log_write+0x2f>
    panic("too big a transaction");
8010366e:	83 ec 0c             	sub    $0xc,%esp
80103671:	68 cc 87 10 80       	push   $0x801087cc
80103676:	e8 e1 ce ff ff       	call   8010055c <panic>
  if (!log.busy)
8010367b:	a1 7c fe 10 80       	mov    0x8010fe7c,%eax
80103680:	85 c0                	test   %eax,%eax
80103682:	75 0d                	jne    80103691 <log_write+0x45>
    panic("write outside of trans");
80103684:	83 ec 0c             	sub    $0xc,%esp
80103687:	68 e2 87 10 80       	push   $0x801087e2
8010368c:	e8 cb ce ff ff       	call   8010055c <panic>

  for (i = 0; i < log.lh.n; i++) {
80103691:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103698:	eb 1f                	jmp    801036b9 <log_write+0x6d>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
8010369a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010369d:	83 c0 10             	add    $0x10,%eax
801036a0:	8b 04 85 48 fe 10 80 	mov    -0x7fef01b8(,%eax,4),%eax
801036a7:	89 c2                	mov    %eax,%edx
801036a9:	8b 45 08             	mov    0x8(%ebp),%eax
801036ac:	8b 40 08             	mov    0x8(%eax),%eax
801036af:	39 c2                	cmp    %eax,%edx
801036b1:	75 02                	jne    801036b5 <log_write+0x69>
      break;
801036b3:	eb 0e                	jmp    801036c3 <log_write+0x77>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
  if (!log.busy)
    panic("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
801036b5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801036b9:	a1 84 fe 10 80       	mov    0x8010fe84,%eax
801036be:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801036c1:	7f d7                	jg     8010369a <log_write+0x4e>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
      break;
  }
  log.lh.sector[i] = b->sector;
801036c3:	8b 45 08             	mov    0x8(%ebp),%eax
801036c6:	8b 40 08             	mov    0x8(%eax),%eax
801036c9:	89 c2                	mov    %eax,%edx
801036cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036ce:	83 c0 10             	add    $0x10,%eax
801036d1:	89 14 85 48 fe 10 80 	mov    %edx,-0x7fef01b8(,%eax,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
801036d8:	8b 15 74 fe 10 80    	mov    0x8010fe74,%edx
801036de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036e1:	01 d0                	add    %edx,%eax
801036e3:	83 c0 01             	add    $0x1,%eax
801036e6:	89 c2                	mov    %eax,%edx
801036e8:	8b 45 08             	mov    0x8(%ebp),%eax
801036eb:	8b 40 04             	mov    0x4(%eax),%eax
801036ee:	83 ec 08             	sub    $0x8,%esp
801036f1:	52                   	push   %edx
801036f2:	50                   	push   %eax
801036f3:	e8 bc ca ff ff       	call   801001b4 <bread>
801036f8:	83 c4 10             	add    $0x10,%esp
801036fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(lbuf->data, b->data, BSIZE);
801036fe:	8b 45 08             	mov    0x8(%ebp),%eax
80103701:	8d 50 18             	lea    0x18(%eax),%edx
80103704:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103707:	83 c0 18             	add    $0x18,%eax
8010370a:	83 ec 04             	sub    $0x4,%esp
8010370d:	68 00 02 00 00       	push   $0x200
80103712:	52                   	push   %edx
80103713:	50                   	push   %eax
80103714:	e8 c8 1a 00 00       	call   801051e1 <memmove>
80103719:	83 c4 10             	add    $0x10,%esp
  bwrite(lbuf);
8010371c:	83 ec 0c             	sub    $0xc,%esp
8010371f:	ff 75 f0             	pushl  -0x10(%ebp)
80103722:	e8 c6 ca ff ff       	call   801001ed <bwrite>
80103727:	83 c4 10             	add    $0x10,%esp
  brelse(lbuf);
8010372a:	83 ec 0c             	sub    $0xc,%esp
8010372d:	ff 75 f0             	pushl  -0x10(%ebp)
80103730:	e8 f6 ca ff ff       	call   8010022b <brelse>
80103735:	83 c4 10             	add    $0x10,%esp
  if (i == log.lh.n)
80103738:	a1 84 fe 10 80       	mov    0x8010fe84,%eax
8010373d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103740:	75 0d                	jne    8010374f <log_write+0x103>
    log.lh.n++;
80103742:	a1 84 fe 10 80       	mov    0x8010fe84,%eax
80103747:	83 c0 01             	add    $0x1,%eax
8010374a:	a3 84 fe 10 80       	mov    %eax,0x8010fe84
  b->flags |= B_DIRTY; // XXX prevent eviction
8010374f:	8b 45 08             	mov    0x8(%ebp),%eax
80103752:	8b 00                	mov    (%eax),%eax
80103754:	83 c8 04             	or     $0x4,%eax
80103757:	89 c2                	mov    %eax,%edx
80103759:	8b 45 08             	mov    0x8(%ebp),%eax
8010375c:	89 10                	mov    %edx,(%eax)
}
8010375e:	c9                   	leave  
8010375f:	c3                   	ret    

80103760 <v2p>:
80103760:	55                   	push   %ebp
80103761:	89 e5                	mov    %esp,%ebp
80103763:	8b 45 08             	mov    0x8(%ebp),%eax
80103766:	05 00 00 00 80       	add    $0x80000000,%eax
8010376b:	5d                   	pop    %ebp
8010376c:	c3                   	ret    

8010376d <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
8010376d:	55                   	push   %ebp
8010376e:	89 e5                	mov    %esp,%ebp
80103770:	8b 45 08             	mov    0x8(%ebp),%eax
80103773:	05 00 00 00 80       	add    $0x80000000,%eax
80103778:	5d                   	pop    %ebp
80103779:	c3                   	ret    

8010377a <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
8010377a:	55                   	push   %ebp
8010377b:	89 e5                	mov    %esp,%ebp
8010377d:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103780:	8b 55 08             	mov    0x8(%ebp),%edx
80103783:	8b 45 0c             	mov    0xc(%ebp),%eax
80103786:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103789:	f0 87 02             	lock xchg %eax,(%edx)
8010378c:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
8010378f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103792:	c9                   	leave  
80103793:	c3                   	ret    

80103794 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103794:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103798:	83 e4 f0             	and    $0xfffffff0,%esp
8010379b:	ff 71 fc             	pushl  -0x4(%ecx)
8010379e:	55                   	push   %ebp
8010379f:	89 e5                	mov    %esp,%ebp
801037a1:	51                   	push   %ecx
801037a2:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801037a5:	83 ec 08             	sub    $0x8,%esp
801037a8:	68 00 00 40 80       	push   $0x80400000
801037ad:	68 dc 2c 11 80       	push   $0x80112cdc
801037b2:	e8 ef f5 ff ff       	call   80102da6 <kinit1>
801037b7:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
801037ba:	e8 a8 46 00 00       	call   80107e67 <kvmalloc>
  mpinit();        // collect info about this machine
801037bf:	e8 45 04 00 00       	call   80103c09 <mpinit>
  lapicinit();
801037c4:	e8 38 f9 ff ff       	call   80103101 <lapicinit>
  seginit();       // set up segments
801037c9:	e8 41 40 00 00       	call   8010780f <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
801037ce:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801037d4:	0f b6 00             	movzbl (%eax),%eax
801037d7:	0f b6 c0             	movzbl %al,%eax
801037da:	83 ec 08             	sub    $0x8,%esp
801037dd:	50                   	push   %eax
801037de:	68 f9 87 10 80       	push   $0x801087f9
801037e3:	e8 d7 cb ff ff       	call   801003bf <cprintf>
801037e8:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
801037eb:	e8 6a 06 00 00       	call   80103e5a <picinit>
  ioapicinit();    // another interrupt controller
801037f0:	e8 a9 f4 ff ff       	call   80102c9e <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
801037f5:	e8 45 d6 ff ff       	call   80100e3f <consoleinit>
  uartinit();      // serial port
801037fa:	e8 73 33 00 00       	call   80106b72 <uartinit>
  pinit();         // process table
801037ff:	e8 55 0b 00 00       	call   80104359 <pinit>
  tvinit();        // trap vectors
80103804:	e8 38 2f 00 00       	call   80106741 <tvinit>
  binit();         // buffer cache
80103809:	e8 26 c8 ff ff       	call   80100034 <binit>
  fileinit();      // file table
8010380e:	e8 73 da ff ff       	call   80101286 <fileinit>
  iinit();         // inode cache
80103813:	e8 39 e1 ff ff       	call   80101951 <iinit>
  ideinit();       // disk
80103818:	e8 c9 f0 ff ff       	call   801028e6 <ideinit>
  if(!ismp)
8010381d:	a1 c4 fe 10 80       	mov    0x8010fec4,%eax
80103822:	85 c0                	test   %eax,%eax
80103824:	75 05                	jne    8010382b <main+0x97>
    timerinit();   // uniprocessor timer
80103826:	e8 75 2e 00 00       	call   801066a0 <timerinit>
  startothers();   // start other processors
8010382b:	e8 7f 00 00 00       	call   801038af <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103830:	83 ec 08             	sub    $0x8,%esp
80103833:	68 00 00 00 8e       	push   $0x8e000000
80103838:	68 00 00 40 80       	push   $0x80400000
8010383d:	e8 9c f5 ff ff       	call   80102dde <kinit2>
80103842:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
80103845:	e8 31 0c 00 00       	call   8010447b <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
8010384a:	e8 1a 00 00 00       	call   80103869 <mpmain>

8010384f <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
8010384f:	55                   	push   %ebp
80103850:	89 e5                	mov    %esp,%ebp
80103852:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
80103855:	e8 24 46 00 00       	call   80107e7e <switchkvm>
  seginit();
8010385a:	e8 b0 3f 00 00       	call   8010780f <seginit>
  lapicinit();
8010385f:	e8 9d f8 ff ff       	call   80103101 <lapicinit>
  mpmain();
80103864:	e8 00 00 00 00       	call   80103869 <mpmain>

80103869 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103869:	55                   	push   %ebp
8010386a:	89 e5                	mov    %esp,%ebp
8010386c:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
8010386f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103875:	0f b6 00             	movzbl (%eax),%eax
80103878:	0f b6 c0             	movzbl %al,%eax
8010387b:	83 ec 08             	sub    $0x8,%esp
8010387e:	50                   	push   %eax
8010387f:	68 10 88 10 80       	push   $0x80108810
80103884:	e8 36 cb ff ff       	call   801003bf <cprintf>
80103889:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
8010388c:	e8 25 30 00 00       	call   801068b6 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103891:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103897:	05 a8 00 00 00       	add    $0xa8,%eax
8010389c:	83 ec 08             	sub    $0x8,%esp
8010389f:	6a 01                	push   $0x1
801038a1:	50                   	push   %eax
801038a2:	e8 d3 fe ff ff       	call   8010377a <xchg>
801038a7:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
801038aa:	e8 4c 11 00 00       	call   801049fb <scheduler>

801038af <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
801038af:	55                   	push   %ebp
801038b0:	89 e5                	mov    %esp,%ebp
801038b2:	53                   	push   %ebx
801038b3:	83 ec 14             	sub    $0x14,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
801038b6:	68 00 70 00 00       	push   $0x7000
801038bb:	e8 ad fe ff ff       	call   8010376d <p2v>
801038c0:	83 c4 04             	add    $0x4,%esp
801038c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801038c6:	b8 8a 00 00 00       	mov    $0x8a,%eax
801038cb:	83 ec 04             	sub    $0x4,%esp
801038ce:	50                   	push   %eax
801038cf:	68 2c b5 10 80       	push   $0x8010b52c
801038d4:	ff 75 f0             	pushl  -0x10(%ebp)
801038d7:	e8 05 19 00 00       	call   801051e1 <memmove>
801038dc:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
801038df:	c7 45 f4 00 ff 10 80 	movl   $0x8010ff00,-0xc(%ebp)
801038e6:	e9 8f 00 00 00       	jmp    8010397a <startothers+0xcb>
    if(c == cpus+cpunum())  // We've started already.
801038eb:	e8 2d f9 ff ff       	call   8010321d <cpunum>
801038f0:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801038f6:	05 00 ff 10 80       	add    $0x8010ff00,%eax
801038fb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801038fe:	75 02                	jne    80103902 <startothers+0x53>
      continue;
80103900:	eb 71                	jmp    80103973 <startothers+0xc4>

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103902:	e8 d2 f5 ff ff       	call   80102ed9 <kalloc>
80103907:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
8010390a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010390d:	83 e8 04             	sub    $0x4,%eax
80103910:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103913:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103919:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
8010391b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010391e:	83 e8 08             	sub    $0x8,%eax
80103921:	c7 00 4f 38 10 80    	movl   $0x8010384f,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
80103927:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010392a:	8d 58 f4             	lea    -0xc(%eax),%ebx
8010392d:	83 ec 0c             	sub    $0xc,%esp
80103930:	68 00 a0 10 80       	push   $0x8010a000
80103935:	e8 26 fe ff ff       	call   80103760 <v2p>
8010393a:	83 c4 10             	add    $0x10,%esp
8010393d:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
8010393f:	83 ec 0c             	sub    $0xc,%esp
80103942:	ff 75 f0             	pushl  -0x10(%ebp)
80103945:	e8 16 fe ff ff       	call   80103760 <v2p>
8010394a:	83 c4 10             	add    $0x10,%esp
8010394d:	89 c2                	mov    %eax,%edx
8010394f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103952:	0f b6 00             	movzbl (%eax),%eax
80103955:	0f b6 c0             	movzbl %al,%eax
80103958:	83 ec 08             	sub    $0x8,%esp
8010395b:	52                   	push   %edx
8010395c:	50                   	push   %eax
8010395d:	e8 33 f9 ff ff       	call   80103295 <lapicstartap>
80103962:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103965:	90                   	nop
80103966:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103969:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010396f:	85 c0                	test   %eax,%eax
80103971:	74 f3                	je     80103966 <startothers+0xb7>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103973:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
8010397a:	a1 e0 04 11 80       	mov    0x801104e0,%eax
8010397f:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103985:	05 00 ff 10 80       	add    $0x8010ff00,%eax
8010398a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010398d:	0f 87 58 ff ff ff    	ja     801038eb <startothers+0x3c>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
80103993:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103996:	c9                   	leave  
80103997:	c3                   	ret    

80103998 <p2v>:
80103998:	55                   	push   %ebp
80103999:	89 e5                	mov    %esp,%ebp
8010399b:	8b 45 08             	mov    0x8(%ebp),%eax
8010399e:	05 00 00 00 80       	add    $0x80000000,%eax
801039a3:	5d                   	pop    %ebp
801039a4:	c3                   	ret    

801039a5 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801039a5:	55                   	push   %ebp
801039a6:	89 e5                	mov    %esp,%ebp
801039a8:	83 ec 14             	sub    $0x14,%esp
801039ab:	8b 45 08             	mov    0x8(%ebp),%eax
801039ae:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801039b2:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801039b6:	89 c2                	mov    %eax,%edx
801039b8:	ec                   	in     (%dx),%al
801039b9:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801039bc:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801039c0:	c9                   	leave  
801039c1:	c3                   	ret    

801039c2 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801039c2:	55                   	push   %ebp
801039c3:	89 e5                	mov    %esp,%ebp
801039c5:	83 ec 08             	sub    $0x8,%esp
801039c8:	8b 55 08             	mov    0x8(%ebp),%edx
801039cb:	8b 45 0c             	mov    0xc(%ebp),%eax
801039ce:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801039d2:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801039d5:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801039d9:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801039dd:	ee                   	out    %al,(%dx)
}
801039de:	c9                   	leave  
801039df:	c3                   	ret    

801039e0 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
801039e3:	a1 a4 bb 10 80       	mov    0x8010bba4,%eax
801039e8:	89 c2                	mov    %eax,%edx
801039ea:	b8 00 ff 10 80       	mov    $0x8010ff00,%eax
801039ef:	29 c2                	sub    %eax,%edx
801039f1:	89 d0                	mov    %edx,%eax
801039f3:	c1 f8 02             	sar    $0x2,%eax
801039f6:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
801039fc:	5d                   	pop    %ebp
801039fd:	c3                   	ret    

801039fe <sum>:

static uchar
sum(uchar *addr, int len)
{
801039fe:	55                   	push   %ebp
801039ff:	89 e5                	mov    %esp,%ebp
80103a01:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
80103a04:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103a0b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103a12:	eb 15                	jmp    80103a29 <sum+0x2b>
    sum += addr[i];
80103a14:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103a17:	8b 45 08             	mov    0x8(%ebp),%eax
80103a1a:	01 d0                	add    %edx,%eax
80103a1c:	0f b6 00             	movzbl (%eax),%eax
80103a1f:	0f b6 c0             	movzbl %al,%eax
80103a22:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
80103a25:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103a29:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103a2c:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103a2f:	7c e3                	jl     80103a14 <sum+0x16>
    sum += addr[i];
  return sum;
80103a31:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103a34:	c9                   	leave  
80103a35:	c3                   	ret    

80103a36 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103a36:	55                   	push   %ebp
80103a37:	89 e5                	mov    %esp,%ebp
80103a39:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103a3c:	ff 75 08             	pushl  0x8(%ebp)
80103a3f:	e8 54 ff ff ff       	call   80103998 <p2v>
80103a44:	83 c4 04             	add    $0x4,%esp
80103a47:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103a4a:	8b 55 0c             	mov    0xc(%ebp),%edx
80103a4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a50:	01 d0                	add    %edx,%eax
80103a52:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103a55:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a58:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103a5b:	eb 36                	jmp    80103a93 <mpsearch1+0x5d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103a5d:	83 ec 04             	sub    $0x4,%esp
80103a60:	6a 04                	push   $0x4
80103a62:	68 24 88 10 80       	push   $0x80108824
80103a67:	ff 75 f4             	pushl  -0xc(%ebp)
80103a6a:	e8 1a 17 00 00       	call   80105189 <memcmp>
80103a6f:	83 c4 10             	add    $0x10,%esp
80103a72:	85 c0                	test   %eax,%eax
80103a74:	75 19                	jne    80103a8f <mpsearch1+0x59>
80103a76:	83 ec 08             	sub    $0x8,%esp
80103a79:	6a 10                	push   $0x10
80103a7b:	ff 75 f4             	pushl  -0xc(%ebp)
80103a7e:	e8 7b ff ff ff       	call   801039fe <sum>
80103a83:	83 c4 10             	add    $0x10,%esp
80103a86:	84 c0                	test   %al,%al
80103a88:	75 05                	jne    80103a8f <mpsearch1+0x59>
      return (struct mp*)p;
80103a8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a8d:	eb 11                	jmp    80103aa0 <mpsearch1+0x6a>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103a8f:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103a93:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a96:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103a99:	72 c2                	jb     80103a5d <mpsearch1+0x27>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103a9b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103aa0:	c9                   	leave  
80103aa1:	c3                   	ret    

80103aa2 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103aa2:	55                   	push   %ebp
80103aa3:	89 e5                	mov    %esp,%ebp
80103aa5:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103aa8:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103aaf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ab2:	83 c0 0f             	add    $0xf,%eax
80103ab5:	0f b6 00             	movzbl (%eax),%eax
80103ab8:	0f b6 c0             	movzbl %al,%eax
80103abb:	c1 e0 08             	shl    $0x8,%eax
80103abe:	89 c2                	mov    %eax,%edx
80103ac0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ac3:	83 c0 0e             	add    $0xe,%eax
80103ac6:	0f b6 00             	movzbl (%eax),%eax
80103ac9:	0f b6 c0             	movzbl %al,%eax
80103acc:	09 d0                	or     %edx,%eax
80103ace:	c1 e0 04             	shl    $0x4,%eax
80103ad1:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103ad4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103ad8:	74 21                	je     80103afb <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103ada:	83 ec 08             	sub    $0x8,%esp
80103add:	68 00 04 00 00       	push   $0x400
80103ae2:	ff 75 f0             	pushl  -0x10(%ebp)
80103ae5:	e8 4c ff ff ff       	call   80103a36 <mpsearch1>
80103aea:	83 c4 10             	add    $0x10,%esp
80103aed:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103af0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103af4:	74 51                	je     80103b47 <mpsearch+0xa5>
      return mp;
80103af6:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103af9:	eb 61                	jmp    80103b5c <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103afb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103afe:	83 c0 14             	add    $0x14,%eax
80103b01:	0f b6 00             	movzbl (%eax),%eax
80103b04:	0f b6 c0             	movzbl %al,%eax
80103b07:	c1 e0 08             	shl    $0x8,%eax
80103b0a:	89 c2                	mov    %eax,%edx
80103b0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b0f:	83 c0 13             	add    $0x13,%eax
80103b12:	0f b6 00             	movzbl (%eax),%eax
80103b15:	0f b6 c0             	movzbl %al,%eax
80103b18:	09 d0                	or     %edx,%eax
80103b1a:	c1 e0 0a             	shl    $0xa,%eax
80103b1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103b20:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b23:	2d 00 04 00 00       	sub    $0x400,%eax
80103b28:	83 ec 08             	sub    $0x8,%esp
80103b2b:	68 00 04 00 00       	push   $0x400
80103b30:	50                   	push   %eax
80103b31:	e8 00 ff ff ff       	call   80103a36 <mpsearch1>
80103b36:	83 c4 10             	add    $0x10,%esp
80103b39:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103b3c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103b40:	74 05                	je     80103b47 <mpsearch+0xa5>
      return mp;
80103b42:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103b45:	eb 15                	jmp    80103b5c <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80103b47:	83 ec 08             	sub    $0x8,%esp
80103b4a:	68 00 00 01 00       	push   $0x10000
80103b4f:	68 00 00 0f 00       	push   $0xf0000
80103b54:	e8 dd fe ff ff       	call   80103a36 <mpsearch1>
80103b59:	83 c4 10             	add    $0x10,%esp
}
80103b5c:	c9                   	leave  
80103b5d:	c3                   	ret    

80103b5e <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103b5e:	55                   	push   %ebp
80103b5f:	89 e5                	mov    %esp,%ebp
80103b61:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103b64:	e8 39 ff ff ff       	call   80103aa2 <mpsearch>
80103b69:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103b6c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103b70:	74 0a                	je     80103b7c <mpconfig+0x1e>
80103b72:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b75:	8b 40 04             	mov    0x4(%eax),%eax
80103b78:	85 c0                	test   %eax,%eax
80103b7a:	75 0a                	jne    80103b86 <mpconfig+0x28>
    return 0;
80103b7c:	b8 00 00 00 00       	mov    $0x0,%eax
80103b81:	e9 81 00 00 00       	jmp    80103c07 <mpconfig+0xa9>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b89:	8b 40 04             	mov    0x4(%eax),%eax
80103b8c:	83 ec 0c             	sub    $0xc,%esp
80103b8f:	50                   	push   %eax
80103b90:	e8 03 fe ff ff       	call   80103998 <p2v>
80103b95:	83 c4 10             	add    $0x10,%esp
80103b98:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103b9b:	83 ec 04             	sub    $0x4,%esp
80103b9e:	6a 04                	push   $0x4
80103ba0:	68 29 88 10 80       	push   $0x80108829
80103ba5:	ff 75 f0             	pushl  -0x10(%ebp)
80103ba8:	e8 dc 15 00 00       	call   80105189 <memcmp>
80103bad:	83 c4 10             	add    $0x10,%esp
80103bb0:	85 c0                	test   %eax,%eax
80103bb2:	74 07                	je     80103bbb <mpconfig+0x5d>
    return 0;
80103bb4:	b8 00 00 00 00       	mov    $0x0,%eax
80103bb9:	eb 4c                	jmp    80103c07 <mpconfig+0xa9>
  if(conf->version != 1 && conf->version != 4)
80103bbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bbe:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103bc2:	3c 01                	cmp    $0x1,%al
80103bc4:	74 12                	je     80103bd8 <mpconfig+0x7a>
80103bc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bc9:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103bcd:	3c 04                	cmp    $0x4,%al
80103bcf:	74 07                	je     80103bd8 <mpconfig+0x7a>
    return 0;
80103bd1:	b8 00 00 00 00       	mov    $0x0,%eax
80103bd6:	eb 2f                	jmp    80103c07 <mpconfig+0xa9>
  if(sum((uchar*)conf, conf->length) != 0)
80103bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bdb:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103bdf:	0f b7 c0             	movzwl %ax,%eax
80103be2:	83 ec 08             	sub    $0x8,%esp
80103be5:	50                   	push   %eax
80103be6:	ff 75 f0             	pushl  -0x10(%ebp)
80103be9:	e8 10 fe ff ff       	call   801039fe <sum>
80103bee:	83 c4 10             	add    $0x10,%esp
80103bf1:	84 c0                	test   %al,%al
80103bf3:	74 07                	je     80103bfc <mpconfig+0x9e>
    return 0;
80103bf5:	b8 00 00 00 00       	mov    $0x0,%eax
80103bfa:	eb 0b                	jmp    80103c07 <mpconfig+0xa9>
  *pmp = mp;
80103bfc:	8b 45 08             	mov    0x8(%ebp),%eax
80103bff:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103c02:	89 10                	mov    %edx,(%eax)
  return conf;
80103c04:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103c07:	c9                   	leave  
80103c08:	c3                   	ret    

80103c09 <mpinit>:

void
mpinit(void)
{
80103c09:	55                   	push   %ebp
80103c0a:	89 e5                	mov    %esp,%ebp
80103c0c:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103c0f:	c7 05 a4 bb 10 80 00 	movl   $0x8010ff00,0x8010bba4
80103c16:	ff 10 80 
  if((conf = mpconfig(&mp)) == 0)
80103c19:	83 ec 0c             	sub    $0xc,%esp
80103c1c:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103c1f:	50                   	push   %eax
80103c20:	e8 39 ff ff ff       	call   80103b5e <mpconfig>
80103c25:	83 c4 10             	add    $0x10,%esp
80103c28:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103c2b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103c2f:	75 05                	jne    80103c36 <mpinit+0x2d>
    return;
80103c31:	e9 94 01 00 00       	jmp    80103dca <mpinit+0x1c1>
  ismp = 1;
80103c36:	c7 05 c4 fe 10 80 01 	movl   $0x1,0x8010fec4
80103c3d:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103c40:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c43:	8b 40 24             	mov    0x24(%eax),%eax
80103c46:	a3 1c fe 10 80       	mov    %eax,0x8010fe1c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103c4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c4e:	83 c0 2c             	add    $0x2c,%eax
80103c51:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c54:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c57:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103c5b:	0f b7 d0             	movzwl %ax,%edx
80103c5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c61:	01 d0                	add    %edx,%eax
80103c63:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c66:	e9 f2 00 00 00       	jmp    80103d5d <mpinit+0x154>
    switch(*p){
80103c6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c6e:	0f b6 00             	movzbl (%eax),%eax
80103c71:	0f b6 c0             	movzbl %al,%eax
80103c74:	83 f8 04             	cmp    $0x4,%eax
80103c77:	0f 87 bc 00 00 00    	ja     80103d39 <mpinit+0x130>
80103c7d:	8b 04 85 6c 88 10 80 	mov    -0x7fef7794(,%eax,4),%eax
80103c84:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103c86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c89:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103c8c:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103c8f:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103c93:	0f b6 d0             	movzbl %al,%edx
80103c96:	a1 e0 04 11 80       	mov    0x801104e0,%eax
80103c9b:	39 c2                	cmp    %eax,%edx
80103c9d:	74 2b                	je     80103cca <mpinit+0xc1>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103c9f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103ca2:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103ca6:	0f b6 d0             	movzbl %al,%edx
80103ca9:	a1 e0 04 11 80       	mov    0x801104e0,%eax
80103cae:	83 ec 04             	sub    $0x4,%esp
80103cb1:	52                   	push   %edx
80103cb2:	50                   	push   %eax
80103cb3:	68 2e 88 10 80       	push   $0x8010882e
80103cb8:	e8 02 c7 ff ff       	call   801003bf <cprintf>
80103cbd:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
80103cc0:	c7 05 c4 fe 10 80 00 	movl   $0x0,0x8010fec4
80103cc7:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103cca:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103ccd:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103cd1:	0f b6 c0             	movzbl %al,%eax
80103cd4:	83 e0 02             	and    $0x2,%eax
80103cd7:	85 c0                	test   %eax,%eax
80103cd9:	74 15                	je     80103cf0 <mpinit+0xe7>
        bcpu = &cpus[ncpu];
80103cdb:	a1 e0 04 11 80       	mov    0x801104e0,%eax
80103ce0:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103ce6:	05 00 ff 10 80       	add    $0x8010ff00,%eax
80103ceb:	a3 a4 bb 10 80       	mov    %eax,0x8010bba4
      cpus[ncpu].id = ncpu;
80103cf0:	a1 e0 04 11 80       	mov    0x801104e0,%eax
80103cf5:	8b 15 e0 04 11 80    	mov    0x801104e0,%edx
80103cfb:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103d01:	05 00 ff 10 80       	add    $0x8010ff00,%eax
80103d06:	88 10                	mov    %dl,(%eax)
      ncpu++;
80103d08:	a1 e0 04 11 80       	mov    0x801104e0,%eax
80103d0d:	83 c0 01             	add    $0x1,%eax
80103d10:	a3 e0 04 11 80       	mov    %eax,0x801104e0
      p += sizeof(struct mpproc);
80103d15:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103d19:	eb 42                	jmp    80103d5d <mpinit+0x154>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103d1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103d21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103d24:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103d28:	a2 c0 fe 10 80       	mov    %al,0x8010fec0
      p += sizeof(struct mpioapic);
80103d2d:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103d31:	eb 2a                	jmp    80103d5d <mpinit+0x154>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103d33:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103d37:	eb 24                	jmp    80103d5d <mpinit+0x154>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103d39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d3c:	0f b6 00             	movzbl (%eax),%eax
80103d3f:	0f b6 c0             	movzbl %al,%eax
80103d42:	83 ec 08             	sub    $0x8,%esp
80103d45:	50                   	push   %eax
80103d46:	68 4c 88 10 80       	push   $0x8010884c
80103d4b:	e8 6f c6 ff ff       	call   801003bf <cprintf>
80103d50:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
80103d53:	c7 05 c4 fe 10 80 00 	movl   $0x0,0x8010fec4
80103d5a:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103d5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d60:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103d63:	0f 82 02 ff ff ff    	jb     80103c6b <mpinit+0x62>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103d69:	a1 c4 fe 10 80       	mov    0x8010fec4,%eax
80103d6e:	85 c0                	test   %eax,%eax
80103d70:	75 1d                	jne    80103d8f <mpinit+0x186>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103d72:	c7 05 e0 04 11 80 01 	movl   $0x1,0x801104e0
80103d79:	00 00 00 
    lapic = 0;
80103d7c:	c7 05 1c fe 10 80 00 	movl   $0x0,0x8010fe1c
80103d83:	00 00 00 
    ioapicid = 0;
80103d86:	c6 05 c0 fe 10 80 00 	movb   $0x0,0x8010fec0
    return;
80103d8d:	eb 3b                	jmp    80103dca <mpinit+0x1c1>
  }

  if(mp->imcrp){
80103d8f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103d92:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103d96:	84 c0                	test   %al,%al
80103d98:	74 30                	je     80103dca <mpinit+0x1c1>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103d9a:	83 ec 08             	sub    $0x8,%esp
80103d9d:	6a 70                	push   $0x70
80103d9f:	6a 22                	push   $0x22
80103da1:	e8 1c fc ff ff       	call   801039c2 <outb>
80103da6:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103da9:	83 ec 0c             	sub    $0xc,%esp
80103dac:	6a 23                	push   $0x23
80103dae:	e8 f2 fb ff ff       	call   801039a5 <inb>
80103db3:	83 c4 10             	add    $0x10,%esp
80103db6:	83 c8 01             	or     $0x1,%eax
80103db9:	0f b6 c0             	movzbl %al,%eax
80103dbc:	83 ec 08             	sub    $0x8,%esp
80103dbf:	50                   	push   %eax
80103dc0:	6a 23                	push   $0x23
80103dc2:	e8 fb fb ff ff       	call   801039c2 <outb>
80103dc7:	83 c4 10             	add    $0x10,%esp
  }
}
80103dca:	c9                   	leave  
80103dcb:	c3                   	ret    

80103dcc <outb>:
80103dcc:	55                   	push   %ebp
80103dcd:	89 e5                	mov    %esp,%ebp
80103dcf:	83 ec 08             	sub    $0x8,%esp
80103dd2:	8b 55 08             	mov    0x8(%ebp),%edx
80103dd5:	8b 45 0c             	mov    0xc(%ebp),%eax
80103dd8:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103ddc:	88 45 f8             	mov    %al,-0x8(%ebp)
80103ddf:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103de3:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103de7:	ee                   	out    %al,(%dx)
80103de8:	c9                   	leave  
80103de9:	c3                   	ret    

80103dea <picsetmask>:
80103dea:	55                   	push   %ebp
80103deb:	89 e5                	mov    %esp,%ebp
80103ded:	83 ec 04             	sub    $0x4,%esp
80103df0:	8b 45 08             	mov    0x8(%ebp),%eax
80103df3:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103df7:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103dfb:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
80103e01:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103e05:	0f b6 c0             	movzbl %al,%eax
80103e08:	50                   	push   %eax
80103e09:	6a 21                	push   $0x21
80103e0b:	e8 bc ff ff ff       	call   80103dcc <outb>
80103e10:	83 c4 08             	add    $0x8,%esp
80103e13:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103e17:	66 c1 e8 08          	shr    $0x8,%ax
80103e1b:	0f b6 c0             	movzbl %al,%eax
80103e1e:	50                   	push   %eax
80103e1f:	68 a1 00 00 00       	push   $0xa1
80103e24:	e8 a3 ff ff ff       	call   80103dcc <outb>
80103e29:	83 c4 08             	add    $0x8,%esp
80103e2c:	c9                   	leave  
80103e2d:	c3                   	ret    

80103e2e <picenable>:
80103e2e:	55                   	push   %ebp
80103e2f:	89 e5                	mov    %esp,%ebp
80103e31:	8b 45 08             	mov    0x8(%ebp),%eax
80103e34:	ba 01 00 00 00       	mov    $0x1,%edx
80103e39:	89 c1                	mov    %eax,%ecx
80103e3b:	d3 e2                	shl    %cl,%edx
80103e3d:	89 d0                	mov    %edx,%eax
80103e3f:	f7 d0                	not    %eax
80103e41:	89 c2                	mov    %eax,%edx
80103e43:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103e4a:	21 d0                	and    %edx,%eax
80103e4c:	0f b7 c0             	movzwl %ax,%eax
80103e4f:	50                   	push   %eax
80103e50:	e8 95 ff ff ff       	call   80103dea <picsetmask>
80103e55:	83 c4 04             	add    $0x4,%esp
80103e58:	c9                   	leave  
80103e59:	c3                   	ret    

80103e5a <picinit>:
80103e5a:	55                   	push   %ebp
80103e5b:	89 e5                	mov    %esp,%ebp
80103e5d:	68 ff 00 00 00       	push   $0xff
80103e62:	6a 21                	push   $0x21
80103e64:	e8 63 ff ff ff       	call   80103dcc <outb>
80103e69:	83 c4 08             	add    $0x8,%esp
80103e6c:	68 ff 00 00 00       	push   $0xff
80103e71:	68 a1 00 00 00       	push   $0xa1
80103e76:	e8 51 ff ff ff       	call   80103dcc <outb>
80103e7b:	83 c4 08             	add    $0x8,%esp
80103e7e:	6a 11                	push   $0x11
80103e80:	6a 20                	push   $0x20
80103e82:	e8 45 ff ff ff       	call   80103dcc <outb>
80103e87:	83 c4 08             	add    $0x8,%esp
80103e8a:	6a 20                	push   $0x20
80103e8c:	6a 21                	push   $0x21
80103e8e:	e8 39 ff ff ff       	call   80103dcc <outb>
80103e93:	83 c4 08             	add    $0x8,%esp
80103e96:	6a 04                	push   $0x4
80103e98:	6a 21                	push   $0x21
80103e9a:	e8 2d ff ff ff       	call   80103dcc <outb>
80103e9f:	83 c4 08             	add    $0x8,%esp
80103ea2:	6a 03                	push   $0x3
80103ea4:	6a 21                	push   $0x21
80103ea6:	e8 21 ff ff ff       	call   80103dcc <outb>
80103eab:	83 c4 08             	add    $0x8,%esp
80103eae:	6a 11                	push   $0x11
80103eb0:	68 a0 00 00 00       	push   $0xa0
80103eb5:	e8 12 ff ff ff       	call   80103dcc <outb>
80103eba:	83 c4 08             	add    $0x8,%esp
80103ebd:	6a 28                	push   $0x28
80103ebf:	68 a1 00 00 00       	push   $0xa1
80103ec4:	e8 03 ff ff ff       	call   80103dcc <outb>
80103ec9:	83 c4 08             	add    $0x8,%esp
80103ecc:	6a 02                	push   $0x2
80103ece:	68 a1 00 00 00       	push   $0xa1
80103ed3:	e8 f4 fe ff ff       	call   80103dcc <outb>
80103ed8:	83 c4 08             	add    $0x8,%esp
80103edb:	6a 03                	push   $0x3
80103edd:	68 a1 00 00 00       	push   $0xa1
80103ee2:	e8 e5 fe ff ff       	call   80103dcc <outb>
80103ee7:	83 c4 08             	add    $0x8,%esp
80103eea:	6a 68                	push   $0x68
80103eec:	6a 20                	push   $0x20
80103eee:	e8 d9 fe ff ff       	call   80103dcc <outb>
80103ef3:	83 c4 08             	add    $0x8,%esp
80103ef6:	6a 0a                	push   $0xa
80103ef8:	6a 20                	push   $0x20
80103efa:	e8 cd fe ff ff       	call   80103dcc <outb>
80103eff:	83 c4 08             	add    $0x8,%esp
80103f02:	6a 68                	push   $0x68
80103f04:	68 a0 00 00 00       	push   $0xa0
80103f09:	e8 be fe ff ff       	call   80103dcc <outb>
80103f0e:	83 c4 08             	add    $0x8,%esp
80103f11:	6a 0a                	push   $0xa
80103f13:	68 a0 00 00 00       	push   $0xa0
80103f18:	e8 af fe ff ff       	call   80103dcc <outb>
80103f1d:	83 c4 08             	add    $0x8,%esp
80103f20:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103f27:	66 83 f8 ff          	cmp    $0xffff,%ax
80103f2b:	74 13                	je     80103f40 <picinit+0xe6>
80103f2d:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103f34:	0f b7 c0             	movzwl %ax,%eax
80103f37:	50                   	push   %eax
80103f38:	e8 ad fe ff ff       	call   80103dea <picsetmask>
80103f3d:	83 c4 04             	add    $0x4,%esp
80103f40:	c9                   	leave  
80103f41:	c3                   	ret    

80103f42 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103f42:	55                   	push   %ebp
80103f43:	89 e5                	mov    %esp,%ebp
80103f45:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80103f48:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103f4f:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f52:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103f58:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f5b:	8b 10                	mov    (%eax),%edx
80103f5d:	8b 45 08             	mov    0x8(%ebp),%eax
80103f60:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103f62:	e8 3c d3 ff ff       	call   801012a3 <filealloc>
80103f67:	89 c2                	mov    %eax,%edx
80103f69:	8b 45 08             	mov    0x8(%ebp),%eax
80103f6c:	89 10                	mov    %edx,(%eax)
80103f6e:	8b 45 08             	mov    0x8(%ebp),%eax
80103f71:	8b 00                	mov    (%eax),%eax
80103f73:	85 c0                	test   %eax,%eax
80103f75:	0f 84 cb 00 00 00    	je     80104046 <pipealloc+0x104>
80103f7b:	e8 23 d3 ff ff       	call   801012a3 <filealloc>
80103f80:	89 c2                	mov    %eax,%edx
80103f82:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f85:	89 10                	mov    %edx,(%eax)
80103f87:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f8a:	8b 00                	mov    (%eax),%eax
80103f8c:	85 c0                	test   %eax,%eax
80103f8e:	0f 84 b2 00 00 00    	je     80104046 <pipealloc+0x104>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103f94:	e8 40 ef ff ff       	call   80102ed9 <kalloc>
80103f99:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103f9c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103fa0:	75 05                	jne    80103fa7 <pipealloc+0x65>
    goto bad;
80103fa2:	e9 9f 00 00 00       	jmp    80104046 <pipealloc+0x104>
  p->readopen = 1;
80103fa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103faa:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103fb1:	00 00 00 
  p->writeopen = 1;
80103fb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fb7:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103fbe:	00 00 00 
  p->nwrite = 0;
80103fc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fc4:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103fcb:	00 00 00 
  p->nread = 0;
80103fce:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fd1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103fd8:	00 00 00 
  initlock(&p->lock, "pipe");
80103fdb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fde:	83 ec 08             	sub    $0x8,%esp
80103fe1:	68 80 88 10 80       	push   $0x80108880
80103fe6:	50                   	push   %eax
80103fe7:	e8 b9 0e 00 00       	call   80104ea5 <initlock>
80103fec:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103fef:	8b 45 08             	mov    0x8(%ebp),%eax
80103ff2:	8b 00                	mov    (%eax),%eax
80103ff4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103ffa:	8b 45 08             	mov    0x8(%ebp),%eax
80103ffd:	8b 00                	mov    (%eax),%eax
80103fff:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80104003:	8b 45 08             	mov    0x8(%ebp),%eax
80104006:	8b 00                	mov    (%eax),%eax
80104008:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010400c:	8b 45 08             	mov    0x8(%ebp),%eax
8010400f:	8b 00                	mov    (%eax),%eax
80104011:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104014:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80104017:	8b 45 0c             	mov    0xc(%ebp),%eax
8010401a:	8b 00                	mov    (%eax),%eax
8010401c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104022:	8b 45 0c             	mov    0xc(%ebp),%eax
80104025:	8b 00                	mov    (%eax),%eax
80104027:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
8010402b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010402e:	8b 00                	mov    (%eax),%eax
80104030:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80104034:	8b 45 0c             	mov    0xc(%ebp),%eax
80104037:	8b 00                	mov    (%eax),%eax
80104039:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010403c:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
8010403f:	b8 00 00 00 00       	mov    $0x0,%eax
80104044:	eb 4d                	jmp    80104093 <pipealloc+0x151>

//PAGEBREAK: 20
 bad:
  if(p)
80104046:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010404a:	74 0e                	je     8010405a <pipealloc+0x118>
    kfree((char*)p);
8010404c:	83 ec 0c             	sub    $0xc,%esp
8010404f:	ff 75 f4             	pushl  -0xc(%ebp)
80104052:	e8 e6 ed ff ff       	call   80102e3d <kfree>
80104057:	83 c4 10             	add    $0x10,%esp
  if(*f0)
8010405a:	8b 45 08             	mov    0x8(%ebp),%eax
8010405d:	8b 00                	mov    (%eax),%eax
8010405f:	85 c0                	test   %eax,%eax
80104061:	74 11                	je     80104074 <pipealloc+0x132>
    fileclose(*f0);
80104063:	8b 45 08             	mov    0x8(%ebp),%eax
80104066:	8b 00                	mov    (%eax),%eax
80104068:	83 ec 0c             	sub    $0xc,%esp
8010406b:	50                   	push   %eax
8010406c:	e8 ef d2 ff ff       	call   80101360 <fileclose>
80104071:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80104074:	8b 45 0c             	mov    0xc(%ebp),%eax
80104077:	8b 00                	mov    (%eax),%eax
80104079:	85 c0                	test   %eax,%eax
8010407b:	74 11                	je     8010408e <pipealloc+0x14c>
    fileclose(*f1);
8010407d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104080:	8b 00                	mov    (%eax),%eax
80104082:	83 ec 0c             	sub    $0xc,%esp
80104085:	50                   	push   %eax
80104086:	e8 d5 d2 ff ff       	call   80101360 <fileclose>
8010408b:	83 c4 10             	add    $0x10,%esp
  return -1;
8010408e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104093:	c9                   	leave  
80104094:	c3                   	ret    

80104095 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104095:	55                   	push   %ebp
80104096:	89 e5                	mov    %esp,%ebp
80104098:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
8010409b:	8b 45 08             	mov    0x8(%ebp),%eax
8010409e:	83 ec 0c             	sub    $0xc,%esp
801040a1:	50                   	push   %eax
801040a2:	e8 1f 0e 00 00       	call   80104ec6 <acquire>
801040a7:	83 c4 10             	add    $0x10,%esp
  if(writable){
801040aa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801040ae:	74 23                	je     801040d3 <pipeclose+0x3e>
    p->writeopen = 0;
801040b0:	8b 45 08             	mov    0x8(%ebp),%eax
801040b3:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
801040ba:	00 00 00 
    wakeup(&p->nread);
801040bd:	8b 45 08             	mov    0x8(%ebp),%eax
801040c0:	05 34 02 00 00       	add    $0x234,%eax
801040c5:	83 ec 0c             	sub    $0xc,%esp
801040c8:	50                   	push   %eax
801040c9:	e8 df 0b 00 00       	call   80104cad <wakeup>
801040ce:	83 c4 10             	add    $0x10,%esp
801040d1:	eb 21                	jmp    801040f4 <pipeclose+0x5f>
  } else {
    p->readopen = 0;
801040d3:	8b 45 08             	mov    0x8(%ebp),%eax
801040d6:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
801040dd:	00 00 00 
    wakeup(&p->nwrite);
801040e0:	8b 45 08             	mov    0x8(%ebp),%eax
801040e3:	05 38 02 00 00       	add    $0x238,%eax
801040e8:	83 ec 0c             	sub    $0xc,%esp
801040eb:	50                   	push   %eax
801040ec:	e8 bc 0b 00 00       	call   80104cad <wakeup>
801040f1:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
801040f4:	8b 45 08             	mov    0x8(%ebp),%eax
801040f7:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
801040fd:	85 c0                	test   %eax,%eax
801040ff:	75 2c                	jne    8010412d <pipeclose+0x98>
80104101:	8b 45 08             	mov    0x8(%ebp),%eax
80104104:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
8010410a:	85 c0                	test   %eax,%eax
8010410c:	75 1f                	jne    8010412d <pipeclose+0x98>
    release(&p->lock);
8010410e:	8b 45 08             	mov    0x8(%ebp),%eax
80104111:	83 ec 0c             	sub    $0xc,%esp
80104114:	50                   	push   %eax
80104115:	e8 12 0e 00 00       	call   80104f2c <release>
8010411a:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
8010411d:	83 ec 0c             	sub    $0xc,%esp
80104120:	ff 75 08             	pushl  0x8(%ebp)
80104123:	e8 15 ed ff ff       	call   80102e3d <kfree>
80104128:	83 c4 10             	add    $0x10,%esp
8010412b:	eb 0f                	jmp    8010413c <pipeclose+0xa7>
  } else
    release(&p->lock);
8010412d:	8b 45 08             	mov    0x8(%ebp),%eax
80104130:	83 ec 0c             	sub    $0xc,%esp
80104133:	50                   	push   %eax
80104134:	e8 f3 0d 00 00       	call   80104f2c <release>
80104139:	83 c4 10             	add    $0x10,%esp
}
8010413c:	c9                   	leave  
8010413d:	c3                   	ret    

8010413e <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
8010413e:	55                   	push   %ebp
8010413f:	89 e5                	mov    %esp,%ebp
80104141:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
80104144:	8b 45 08             	mov    0x8(%ebp),%eax
80104147:	83 ec 0c             	sub    $0xc,%esp
8010414a:	50                   	push   %eax
8010414b:	e8 76 0d 00 00       	call   80104ec6 <acquire>
80104150:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
80104153:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010415a:	e9 af 00 00 00       	jmp    8010420e <pipewrite+0xd0>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010415f:	eb 60                	jmp    801041c1 <pipewrite+0x83>
      if(p->readopen == 0 || proc->killed){
80104161:	8b 45 08             	mov    0x8(%ebp),%eax
80104164:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
8010416a:	85 c0                	test   %eax,%eax
8010416c:	74 0d                	je     8010417b <pipewrite+0x3d>
8010416e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104174:	8b 40 24             	mov    0x24(%eax),%eax
80104177:	85 c0                	test   %eax,%eax
80104179:	74 19                	je     80104194 <pipewrite+0x56>
        release(&p->lock);
8010417b:	8b 45 08             	mov    0x8(%ebp),%eax
8010417e:	83 ec 0c             	sub    $0xc,%esp
80104181:	50                   	push   %eax
80104182:	e8 a5 0d 00 00       	call   80104f2c <release>
80104187:	83 c4 10             	add    $0x10,%esp
        return -1;
8010418a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010418f:	e9 ac 00 00 00       	jmp    80104240 <pipewrite+0x102>
      }
      wakeup(&p->nread);
80104194:	8b 45 08             	mov    0x8(%ebp),%eax
80104197:	05 34 02 00 00       	add    $0x234,%eax
8010419c:	83 ec 0c             	sub    $0xc,%esp
8010419f:	50                   	push   %eax
801041a0:	e8 08 0b 00 00       	call   80104cad <wakeup>
801041a5:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801041a8:	8b 45 08             	mov    0x8(%ebp),%eax
801041ab:	8b 55 08             	mov    0x8(%ebp),%edx
801041ae:	81 c2 38 02 00 00    	add    $0x238,%edx
801041b4:	83 ec 08             	sub    $0x8,%esp
801041b7:	50                   	push   %eax
801041b8:	52                   	push   %edx
801041b9:	e8 06 0a 00 00       	call   80104bc4 <sleep>
801041be:	83 c4 10             	add    $0x10,%esp
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041c1:	8b 45 08             	mov    0x8(%ebp),%eax
801041c4:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
801041ca:	8b 45 08             	mov    0x8(%ebp),%eax
801041cd:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801041d3:	05 00 02 00 00       	add    $0x200,%eax
801041d8:	39 c2                	cmp    %eax,%edx
801041da:	74 85                	je     80104161 <pipewrite+0x23>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801041dc:	8b 45 08             	mov    0x8(%ebp),%eax
801041df:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801041e5:	8d 48 01             	lea    0x1(%eax),%ecx
801041e8:	8b 55 08             	mov    0x8(%ebp),%edx
801041eb:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
801041f1:	25 ff 01 00 00       	and    $0x1ff,%eax
801041f6:	89 c1                	mov    %eax,%ecx
801041f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801041fb:	8b 45 0c             	mov    0xc(%ebp),%eax
801041fe:	01 d0                	add    %edx,%eax
80104200:	0f b6 10             	movzbl (%eax),%edx
80104203:	8b 45 08             	mov    0x8(%ebp),%eax
80104206:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
8010420a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010420e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104211:	3b 45 10             	cmp    0x10(%ebp),%eax
80104214:	0f 8c 45 ff ff ff    	jl     8010415f <pipewrite+0x21>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010421a:	8b 45 08             	mov    0x8(%ebp),%eax
8010421d:	05 34 02 00 00       	add    $0x234,%eax
80104222:	83 ec 0c             	sub    $0xc,%esp
80104225:	50                   	push   %eax
80104226:	e8 82 0a 00 00       	call   80104cad <wakeup>
8010422b:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
8010422e:	8b 45 08             	mov    0x8(%ebp),%eax
80104231:	83 ec 0c             	sub    $0xc,%esp
80104234:	50                   	push   %eax
80104235:	e8 f2 0c 00 00       	call   80104f2c <release>
8010423a:	83 c4 10             	add    $0x10,%esp
  return n;
8010423d:	8b 45 10             	mov    0x10(%ebp),%eax
}
80104240:	c9                   	leave  
80104241:	c3                   	ret    

80104242 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80104242:	55                   	push   %ebp
80104243:	89 e5                	mov    %esp,%ebp
80104245:	53                   	push   %ebx
80104246:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
80104249:	8b 45 08             	mov    0x8(%ebp),%eax
8010424c:	83 ec 0c             	sub    $0xc,%esp
8010424f:	50                   	push   %eax
80104250:	e8 71 0c 00 00       	call   80104ec6 <acquire>
80104255:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104258:	eb 3f                	jmp    80104299 <piperead+0x57>
    if(proc->killed){
8010425a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104260:	8b 40 24             	mov    0x24(%eax),%eax
80104263:	85 c0                	test   %eax,%eax
80104265:	74 19                	je     80104280 <piperead+0x3e>
      release(&p->lock);
80104267:	8b 45 08             	mov    0x8(%ebp),%eax
8010426a:	83 ec 0c             	sub    $0xc,%esp
8010426d:	50                   	push   %eax
8010426e:	e8 b9 0c 00 00       	call   80104f2c <release>
80104273:	83 c4 10             	add    $0x10,%esp
      return -1;
80104276:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010427b:	e9 be 00 00 00       	jmp    8010433e <piperead+0xfc>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104280:	8b 45 08             	mov    0x8(%ebp),%eax
80104283:	8b 55 08             	mov    0x8(%ebp),%edx
80104286:	81 c2 34 02 00 00    	add    $0x234,%edx
8010428c:	83 ec 08             	sub    $0x8,%esp
8010428f:	50                   	push   %eax
80104290:	52                   	push   %edx
80104291:	e8 2e 09 00 00       	call   80104bc4 <sleep>
80104296:	83 c4 10             	add    $0x10,%esp
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104299:	8b 45 08             	mov    0x8(%ebp),%eax
8010429c:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801042a2:	8b 45 08             	mov    0x8(%ebp),%eax
801042a5:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801042ab:	39 c2                	cmp    %eax,%edx
801042ad:	75 0d                	jne    801042bc <piperead+0x7a>
801042af:	8b 45 08             	mov    0x8(%ebp),%eax
801042b2:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801042b8:	85 c0                	test   %eax,%eax
801042ba:	75 9e                	jne    8010425a <piperead+0x18>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801042bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801042c3:	eb 4b                	jmp    80104310 <piperead+0xce>
    if(p->nread == p->nwrite)
801042c5:	8b 45 08             	mov    0x8(%ebp),%eax
801042c8:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801042ce:	8b 45 08             	mov    0x8(%ebp),%eax
801042d1:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801042d7:	39 c2                	cmp    %eax,%edx
801042d9:	75 02                	jne    801042dd <piperead+0x9b>
      break;
801042db:	eb 3b                	jmp    80104318 <piperead+0xd6>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801042dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042e0:	8b 45 0c             	mov    0xc(%ebp),%eax
801042e3:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
801042e6:	8b 45 08             	mov    0x8(%ebp),%eax
801042e9:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801042ef:	8d 48 01             	lea    0x1(%eax),%ecx
801042f2:	8b 55 08             	mov    0x8(%ebp),%edx
801042f5:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
801042fb:	25 ff 01 00 00       	and    $0x1ff,%eax
80104300:	89 c2                	mov    %eax,%edx
80104302:	8b 45 08             	mov    0x8(%ebp),%eax
80104305:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
8010430a:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010430c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104310:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104313:	3b 45 10             	cmp    0x10(%ebp),%eax
80104316:	7c ad                	jl     801042c5 <piperead+0x83>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80104318:	8b 45 08             	mov    0x8(%ebp),%eax
8010431b:	05 38 02 00 00       	add    $0x238,%eax
80104320:	83 ec 0c             	sub    $0xc,%esp
80104323:	50                   	push   %eax
80104324:	e8 84 09 00 00       	call   80104cad <wakeup>
80104329:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
8010432c:	8b 45 08             	mov    0x8(%ebp),%eax
8010432f:	83 ec 0c             	sub    $0xc,%esp
80104332:	50                   	push   %eax
80104333:	e8 f4 0b 00 00       	call   80104f2c <release>
80104338:	83 c4 10             	add    $0x10,%esp
  return i;
8010433b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010433e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104341:	c9                   	leave  
80104342:	c3                   	ret    

80104343 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104343:	55                   	push   %ebp
80104344:	89 e5                	mov    %esp,%ebp
80104346:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104349:	9c                   	pushf  
8010434a:	58                   	pop    %eax
8010434b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
8010434e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104351:	c9                   	leave  
80104352:	c3                   	ret    

80104353 <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
80104353:	55                   	push   %ebp
80104354:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104356:	fb                   	sti    
}
80104357:	5d                   	pop    %ebp
80104358:	c3                   	ret    

80104359 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80104359:	55                   	push   %ebp
8010435a:	89 e5                	mov    %esp,%ebp
8010435c:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
8010435f:	83 ec 08             	sub    $0x8,%esp
80104362:	68 85 88 10 80       	push   $0x80108885
80104367:	68 00 05 11 80       	push   $0x80110500
8010436c:	e8 34 0b 00 00       	call   80104ea5 <initlock>
80104371:	83 c4 10             	add    $0x10,%esp
}
80104374:	c9                   	leave  
80104375:	c3                   	ret    

80104376 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104376:	55                   	push   %ebp
80104377:	89 e5                	mov    %esp,%ebp
80104379:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010437c:	83 ec 0c             	sub    $0xc,%esp
8010437f:	68 00 05 11 80       	push   $0x80110500
80104384:	e8 3d 0b 00 00       	call   80104ec6 <acquire>
80104389:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010438c:	c7 45 f4 34 05 11 80 	movl   $0x80110534,-0xc(%ebp)
80104393:	eb 56                	jmp    801043eb <allocproc+0x75>
    if(p->state == UNUSED)
80104395:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104398:	8b 40 0c             	mov    0xc(%eax),%eax
8010439b:	85 c0                	test   %eax,%eax
8010439d:	75 48                	jne    801043e7 <allocproc+0x71>
      goto found;
8010439f:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801043a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043a3:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
801043aa:	a1 04 b0 10 80       	mov    0x8010b004,%eax
801043af:	8d 50 01             	lea    0x1(%eax),%edx
801043b2:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
801043b8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801043bb:	89 42 10             	mov    %eax,0x10(%edx)
  release(&ptable.lock);
801043be:	83 ec 0c             	sub    $0xc,%esp
801043c1:	68 00 05 11 80       	push   $0x80110500
801043c6:	e8 61 0b 00 00       	call   80104f2c <release>
801043cb:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801043ce:	e8 06 eb ff ff       	call   80102ed9 <kalloc>
801043d3:	89 c2                	mov    %eax,%edx
801043d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043d8:	89 50 08             	mov    %edx,0x8(%eax)
801043db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043de:	8b 40 08             	mov    0x8(%eax),%eax
801043e1:	85 c0                	test   %eax,%eax
801043e3:	75 37                	jne    8010441c <allocproc+0xa6>
801043e5:	eb 24                	jmp    8010440b <allocproc+0x95>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043e7:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
801043eb:	81 7d f4 34 24 11 80 	cmpl   $0x80112434,-0xc(%ebp)
801043f2:	72 a1                	jb     80104395 <allocproc+0x1f>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
801043f4:	83 ec 0c             	sub    $0xc,%esp
801043f7:	68 00 05 11 80       	push   $0x80110500
801043fc:	e8 2b 0b 00 00       	call   80104f2c <release>
80104401:	83 c4 10             	add    $0x10,%esp
  return 0;
80104404:	b8 00 00 00 00       	mov    $0x0,%eax
80104409:	eb 6e                	jmp    80104479 <allocproc+0x103>
  p->pid = nextpid++;
  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
8010440b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010440e:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
80104415:	b8 00 00 00 00       	mov    $0x0,%eax
8010441a:	eb 5d                	jmp    80104479 <allocproc+0x103>
  }
  sp = p->kstack + KSTACKSIZE;
8010441c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010441f:	8b 40 08             	mov    0x8(%eax),%eax
80104422:	05 00 10 00 00       	add    $0x1000,%eax
80104427:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010442a:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
8010442e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104431:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104434:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
80104437:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
8010443b:	ba fc 66 10 80       	mov    $0x801066fc,%edx
80104440:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104443:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
80104445:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
80104449:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010444c:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010444f:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
80104452:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104455:	8b 40 1c             	mov    0x1c(%eax),%eax
80104458:	83 ec 04             	sub    $0x4,%esp
8010445b:	6a 14                	push   $0x14
8010445d:	6a 00                	push   $0x0
8010445f:	50                   	push   %eax
80104460:	e8 bd 0c 00 00       	call   80105122 <memset>
80104465:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104468:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010446b:	8b 40 1c             	mov    0x1c(%eax),%eax
8010446e:	ba 94 4b 10 80       	mov    $0x80104b94,%edx
80104473:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
80104476:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104479:	c9                   	leave  
8010447a:	c3                   	ret    

8010447b <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
8010447b:	55                   	push   %ebp
8010447c:	89 e5                	mov    %esp,%ebp
8010447e:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
80104481:	e8 f0 fe ff ff       	call   80104376 <allocproc>
80104486:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
80104489:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010448c:	a3 a8 bb 10 80       	mov    %eax,0x8010bba8
  if((p->pgdir = setupkvm()) == 0)
80104491:	e8 1f 39 00 00       	call   80107db5 <setupkvm>
80104496:	89 c2                	mov    %eax,%edx
80104498:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010449b:	89 50 04             	mov    %edx,0x4(%eax)
8010449e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044a1:	8b 40 04             	mov    0x4(%eax),%eax
801044a4:	85 c0                	test   %eax,%eax
801044a6:	75 0d                	jne    801044b5 <userinit+0x3a>
    panic("userinit: out of memory?");
801044a8:	83 ec 0c             	sub    $0xc,%esp
801044ab:	68 8c 88 10 80       	push   $0x8010888c
801044b0:	e8 a7 c0 ff ff       	call   8010055c <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801044b5:	ba 2c 00 00 00       	mov    $0x2c,%edx
801044ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044bd:	8b 40 04             	mov    0x4(%eax),%eax
801044c0:	83 ec 04             	sub    $0x4,%esp
801044c3:	52                   	push   %edx
801044c4:	68 00 b5 10 80       	push   $0x8010b500
801044c9:	50                   	push   %eax
801044ca:	e8 3d 3b 00 00       	call   8010800c <inituvm>
801044cf:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
801044d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044d5:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
801044db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044de:	8b 40 18             	mov    0x18(%eax),%eax
801044e1:	83 ec 04             	sub    $0x4,%esp
801044e4:	6a 4c                	push   $0x4c
801044e6:	6a 00                	push   $0x0
801044e8:	50                   	push   %eax
801044e9:	e8 34 0c 00 00       	call   80105122 <memset>
801044ee:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801044f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044f4:	8b 40 18             	mov    0x18(%eax),%eax
801044f7:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801044fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104500:	8b 40 18             	mov    0x18(%eax),%eax
80104503:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104509:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010450c:	8b 40 18             	mov    0x18(%eax),%eax
8010450f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104512:	8b 52 18             	mov    0x18(%edx),%edx
80104515:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104519:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
8010451d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104520:	8b 40 18             	mov    0x18(%eax),%eax
80104523:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104526:	8b 52 18             	mov    0x18(%edx),%edx
80104529:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
8010452d:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104531:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104534:	8b 40 18             	mov    0x18(%eax),%eax
80104537:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
8010453e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104541:	8b 40 18             	mov    0x18(%eax),%eax
80104544:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
8010454b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010454e:	8b 40 18             	mov    0x18(%eax),%eax
80104551:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104558:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010455b:	83 c0 6c             	add    $0x6c,%eax
8010455e:	83 ec 04             	sub    $0x4,%esp
80104561:	6a 10                	push   $0x10
80104563:	68 a5 88 10 80       	push   $0x801088a5
80104568:	50                   	push   %eax
80104569:	e8 b9 0d 00 00       	call   80105327 <safestrcpy>
8010456e:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
80104571:	83 ec 0c             	sub    $0xc,%esp
80104574:	68 ae 88 10 80       	push   $0x801088ae
80104579:	e8 67 e2 ff ff       	call   801027e5 <namei>
8010457e:	83 c4 10             	add    $0x10,%esp
80104581:	89 c2                	mov    %eax,%edx
80104583:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104586:	89 50 68             	mov    %edx,0x68(%eax)

  p->state = RUNNABLE;
80104589:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010458c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
80104593:	c9                   	leave  
80104594:	c3                   	ret    

80104595 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104595:	55                   	push   %ebp
80104596:	89 e5                	mov    %esp,%ebp
80104598:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  
  sz = proc->sz;
8010459b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045a1:	8b 00                	mov    (%eax),%eax
801045a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
801045a6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801045aa:	7e 31                	jle    801045dd <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
801045ac:	8b 55 08             	mov    0x8(%ebp),%edx
801045af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045b2:	01 c2                	add    %eax,%edx
801045b4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045ba:	8b 40 04             	mov    0x4(%eax),%eax
801045bd:	83 ec 04             	sub    $0x4,%esp
801045c0:	52                   	push   %edx
801045c1:	ff 75 f4             	pushl  -0xc(%ebp)
801045c4:	50                   	push   %eax
801045c5:	e8 8e 3b 00 00       	call   80108158 <allocuvm>
801045ca:	83 c4 10             	add    $0x10,%esp
801045cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
801045d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801045d4:	75 3e                	jne    80104614 <growproc+0x7f>
      return -1;
801045d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045db:	eb 59                	jmp    80104636 <growproc+0xa1>
  } else if(n < 0){
801045dd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801045e1:	79 31                	jns    80104614 <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
801045e3:	8b 55 08             	mov    0x8(%ebp),%edx
801045e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045e9:	01 c2                	add    %eax,%edx
801045eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045f1:	8b 40 04             	mov    0x4(%eax),%eax
801045f4:	83 ec 04             	sub    $0x4,%esp
801045f7:	52                   	push   %edx
801045f8:	ff 75 f4             	pushl  -0xc(%ebp)
801045fb:	50                   	push   %eax
801045fc:	e8 20 3c 00 00       	call   80108221 <deallocuvm>
80104601:	83 c4 10             	add    $0x10,%esp
80104604:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104607:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010460b:	75 07                	jne    80104614 <growproc+0x7f>
      return -1;
8010460d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104612:	eb 22                	jmp    80104636 <growproc+0xa1>
  }
  proc->sz = sz;
80104614:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010461a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010461d:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
8010461f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104625:	83 ec 0c             	sub    $0xc,%esp
80104628:	50                   	push   %eax
80104629:	e8 6c 38 00 00       	call   80107e9a <switchuvm>
8010462e:	83 c4 10             	add    $0x10,%esp
  return 0;
80104631:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104636:	c9                   	leave  
80104637:	c3                   	ret    

80104638 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80104638:	55                   	push   %ebp
80104639:	89 e5                	mov    %esp,%ebp
8010463b:	57                   	push   %edi
8010463c:	56                   	push   %esi
8010463d:	53                   	push   %ebx
8010463e:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
80104641:	e8 30 fd ff ff       	call   80104376 <allocproc>
80104646:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104649:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010464d:	75 0a                	jne    80104659 <fork+0x21>
    return -1;
8010464f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104654:	e9 48 01 00 00       	jmp    801047a1 <fork+0x169>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80104659:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010465f:	8b 10                	mov    (%eax),%edx
80104661:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104667:	8b 40 04             	mov    0x4(%eax),%eax
8010466a:	83 ec 08             	sub    $0x8,%esp
8010466d:	52                   	push   %edx
8010466e:	50                   	push   %eax
8010466f:	e8 49 3d 00 00       	call   801083bd <copyuvm>
80104674:	83 c4 10             	add    $0x10,%esp
80104677:	89 c2                	mov    %eax,%edx
80104679:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010467c:	89 50 04             	mov    %edx,0x4(%eax)
8010467f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104682:	8b 40 04             	mov    0x4(%eax),%eax
80104685:	85 c0                	test   %eax,%eax
80104687:	75 30                	jne    801046b9 <fork+0x81>
    kfree(np->kstack);
80104689:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010468c:	8b 40 08             	mov    0x8(%eax),%eax
8010468f:	83 ec 0c             	sub    $0xc,%esp
80104692:	50                   	push   %eax
80104693:	e8 a5 e7 ff ff       	call   80102e3d <kfree>
80104698:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
8010469b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010469e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
801046a5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046a8:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
801046af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046b4:	e9 e8 00 00 00       	jmp    801047a1 <fork+0x169>
  }
  np->sz = proc->sz;
801046b9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046bf:	8b 10                	mov    (%eax),%edx
801046c1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046c4:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
801046c6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801046cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046d0:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
801046d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046d6:	8b 50 18             	mov    0x18(%eax),%edx
801046d9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046df:	8b 40 18             	mov    0x18(%eax),%eax
801046e2:	89 c3                	mov    %eax,%ebx
801046e4:	b8 13 00 00 00       	mov    $0x13,%eax
801046e9:	89 d7                	mov    %edx,%edi
801046eb:	89 de                	mov    %ebx,%esi
801046ed:	89 c1                	mov    %eax,%ecx
801046ef:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
801046f1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046f4:	8b 40 18             	mov    0x18(%eax),%eax
801046f7:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
801046fe:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104705:	eb 43                	jmp    8010474a <fork+0x112>
    if(proc->ofile[i])
80104707:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010470d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104710:	83 c2 08             	add    $0x8,%edx
80104713:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104717:	85 c0                	test   %eax,%eax
80104719:	74 2b                	je     80104746 <fork+0x10e>
      np->ofile[i] = filedup(proc->ofile[i]);
8010471b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104721:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104724:	83 c2 08             	add    $0x8,%edx
80104727:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010472b:	83 ec 0c             	sub    $0xc,%esp
8010472e:	50                   	push   %eax
8010472f:	e8 db cb ff ff       	call   8010130f <filedup>
80104734:	83 c4 10             	add    $0x10,%esp
80104737:	89 c1                	mov    %eax,%ecx
80104739:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010473c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010473f:	83 c2 08             	add    $0x8,%edx
80104742:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80104746:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010474a:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
8010474e:	7e b7                	jle    80104707 <fork+0xcf>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80104750:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104756:	8b 40 68             	mov    0x68(%eax),%eax
80104759:	83 ec 0c             	sub    $0xc,%esp
8010475c:	50                   	push   %eax
8010475d:	e8 86 d4 ff ff       	call   80101be8 <idup>
80104762:	83 c4 10             	add    $0x10,%esp
80104765:	89 c2                	mov    %eax,%edx
80104767:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010476a:	89 50 68             	mov    %edx,0x68(%eax)
 
  pid = np->pid;
8010476d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104770:	8b 40 10             	mov    0x10(%eax),%eax
80104773:	89 45 dc             	mov    %eax,-0x24(%ebp)
  np->state = RUNNABLE;
80104776:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104779:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80104780:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104786:	8d 50 6c             	lea    0x6c(%eax),%edx
80104789:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010478c:	83 c0 6c             	add    $0x6c,%eax
8010478f:	83 ec 04             	sub    $0x4,%esp
80104792:	6a 10                	push   $0x10
80104794:	52                   	push   %edx
80104795:	50                   	push   %eax
80104796:	e8 8c 0b 00 00       	call   80105327 <safestrcpy>
8010479b:	83 c4 10             	add    $0x10,%esp
  return pid;
8010479e:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
801047a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801047a4:	5b                   	pop    %ebx
801047a5:	5e                   	pop    %esi
801047a6:	5f                   	pop    %edi
801047a7:	5d                   	pop    %ebp
801047a8:	c3                   	ret    

801047a9 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
801047a9:	55                   	push   %ebp
801047aa:	89 e5                	mov    %esp,%ebp
801047ac:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
801047af:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801047b6:	a1 a8 bb 10 80       	mov    0x8010bba8,%eax
801047bb:	39 c2                	cmp    %eax,%edx
801047bd:	75 0d                	jne    801047cc <exit+0x23>
    panic("init exiting");
801047bf:	83 ec 0c             	sub    $0xc,%esp
801047c2:	68 b0 88 10 80       	push   $0x801088b0
801047c7:	e8 90 bd ff ff       	call   8010055c <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801047cc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801047d3:	eb 48                	jmp    8010481d <exit+0x74>
    if(proc->ofile[fd]){
801047d5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047db:	8b 55 f0             	mov    -0x10(%ebp),%edx
801047de:	83 c2 08             	add    $0x8,%edx
801047e1:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801047e5:	85 c0                	test   %eax,%eax
801047e7:	74 30                	je     80104819 <exit+0x70>
      fileclose(proc->ofile[fd]);
801047e9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047ef:	8b 55 f0             	mov    -0x10(%ebp),%edx
801047f2:	83 c2 08             	add    $0x8,%edx
801047f5:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801047f9:	83 ec 0c             	sub    $0xc,%esp
801047fc:	50                   	push   %eax
801047fd:	e8 5e cb ff ff       	call   80101360 <fileclose>
80104802:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
80104805:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010480b:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010480e:	83 c2 08             	add    $0x8,%edx
80104811:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104818:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104819:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010481d:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104821:	7e b2                	jle    801047d5 <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
80104823:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104829:	8b 40 68             	mov    0x68(%eax),%eax
8010482c:	83 ec 0c             	sub    $0xc,%esp
8010482f:	50                   	push   %eax
80104830:	e8 b5 d5 ff ff       	call   80101dea <iput>
80104835:	83 c4 10             	add    $0x10,%esp
  proc->cwd = 0;
80104838:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010483e:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80104845:	83 ec 0c             	sub    $0xc,%esp
80104848:	68 00 05 11 80       	push   $0x80110500
8010484d:	e8 74 06 00 00       	call   80104ec6 <acquire>
80104852:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80104855:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010485b:	8b 40 14             	mov    0x14(%eax),%eax
8010485e:	83 ec 0c             	sub    $0xc,%esp
80104861:	50                   	push   %eax
80104862:	e8 08 04 00 00       	call   80104c6f <wakeup1>
80104867:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010486a:	c7 45 f4 34 05 11 80 	movl   $0x80110534,-0xc(%ebp)
80104871:	eb 3c                	jmp    801048af <exit+0x106>
    if(p->parent == proc){
80104873:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104876:	8b 50 14             	mov    0x14(%eax),%edx
80104879:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010487f:	39 c2                	cmp    %eax,%edx
80104881:	75 28                	jne    801048ab <exit+0x102>
      p->parent = initproc;
80104883:	8b 15 a8 bb 10 80    	mov    0x8010bba8,%edx
80104889:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010488c:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
8010488f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104892:	8b 40 0c             	mov    0xc(%eax),%eax
80104895:	83 f8 05             	cmp    $0x5,%eax
80104898:	75 11                	jne    801048ab <exit+0x102>
        wakeup1(initproc);
8010489a:	a1 a8 bb 10 80       	mov    0x8010bba8,%eax
8010489f:	83 ec 0c             	sub    $0xc,%esp
801048a2:	50                   	push   %eax
801048a3:	e8 c7 03 00 00       	call   80104c6f <wakeup1>
801048a8:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048ab:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
801048af:	81 7d f4 34 24 11 80 	cmpl   $0x80112434,-0xc(%ebp)
801048b6:	72 bb                	jb     80104873 <exit+0xca>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
801048b8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048be:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
801048c5:	e8 d5 01 00 00       	call   80104a9f <sched>
  panic("zombie exit");
801048ca:	83 ec 0c             	sub    $0xc,%esp
801048cd:	68 bd 88 10 80       	push   $0x801088bd
801048d2:	e8 85 bc ff ff       	call   8010055c <panic>

801048d7 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
801048d7:	55                   	push   %ebp
801048d8:	89 e5                	mov    %esp,%ebp
801048da:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
801048dd:	83 ec 0c             	sub    $0xc,%esp
801048e0:	68 00 05 11 80       	push   $0x80110500
801048e5:	e8 dc 05 00 00       	call   80104ec6 <acquire>
801048ea:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
801048ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048f4:	c7 45 f4 34 05 11 80 	movl   $0x80110534,-0xc(%ebp)
801048fb:	e9 a6 00 00 00       	jmp    801049a6 <wait+0xcf>
      if(p->parent != proc)
80104900:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104903:	8b 50 14             	mov    0x14(%eax),%edx
80104906:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010490c:	39 c2                	cmp    %eax,%edx
8010490e:	74 05                	je     80104915 <wait+0x3e>
        continue;
80104910:	e9 8d 00 00 00       	jmp    801049a2 <wait+0xcb>
      havekids = 1;
80104915:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
8010491c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010491f:	8b 40 0c             	mov    0xc(%eax),%eax
80104922:	83 f8 05             	cmp    $0x5,%eax
80104925:	75 7b                	jne    801049a2 <wait+0xcb>
        // Found one.
        pid = p->pid;
80104927:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010492a:	8b 40 10             	mov    0x10(%eax),%eax
8010492d:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
80104930:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104933:	8b 40 08             	mov    0x8(%eax),%eax
80104936:	83 ec 0c             	sub    $0xc,%esp
80104939:	50                   	push   %eax
8010493a:	e8 fe e4 ff ff       	call   80102e3d <kfree>
8010493f:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
80104942:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104945:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
8010494c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010494f:	8b 40 04             	mov    0x4(%eax),%eax
80104952:	83 ec 0c             	sub    $0xc,%esp
80104955:	50                   	push   %eax
80104956:	e8 83 39 00 00       	call   801082de <freevm>
8010495b:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
8010495e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104961:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
80104968:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010496b:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104972:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104975:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
8010497c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010497f:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104983:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104986:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
8010498d:	83 ec 0c             	sub    $0xc,%esp
80104990:	68 00 05 11 80       	push   $0x80110500
80104995:	e8 92 05 00 00       	call   80104f2c <release>
8010499a:	83 c4 10             	add    $0x10,%esp
        return pid;
8010499d:	8b 45 ec             	mov    -0x14(%ebp),%eax
801049a0:	eb 57                	jmp    801049f9 <wait+0x122>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049a2:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
801049a6:	81 7d f4 34 24 11 80 	cmpl   $0x80112434,-0xc(%ebp)
801049ad:	0f 82 4d ff ff ff    	jb     80104900 <wait+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
801049b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801049b7:	74 0d                	je     801049c6 <wait+0xef>
801049b9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049bf:	8b 40 24             	mov    0x24(%eax),%eax
801049c2:	85 c0                	test   %eax,%eax
801049c4:	74 17                	je     801049dd <wait+0x106>
      release(&ptable.lock);
801049c6:	83 ec 0c             	sub    $0xc,%esp
801049c9:	68 00 05 11 80       	push   $0x80110500
801049ce:	e8 59 05 00 00       	call   80104f2c <release>
801049d3:	83 c4 10             	add    $0x10,%esp
      return -1;
801049d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049db:	eb 1c                	jmp    801049f9 <wait+0x122>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
801049dd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049e3:	83 ec 08             	sub    $0x8,%esp
801049e6:	68 00 05 11 80       	push   $0x80110500
801049eb:	50                   	push   %eax
801049ec:	e8 d3 01 00 00       	call   80104bc4 <sleep>
801049f1:	83 c4 10             	add    $0x10,%esp
  }
801049f4:	e9 f4 fe ff ff       	jmp    801048ed <wait+0x16>
}
801049f9:	c9                   	leave  
801049fa:	c3                   	ret    

801049fb <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
801049fb:	55                   	push   %ebp
801049fc:	89 e5                	mov    %esp,%ebp
801049fe:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
80104a01:	e8 4d f9 ff ff       	call   80104353 <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104a06:	83 ec 0c             	sub    $0xc,%esp
80104a09:	68 00 05 11 80       	push   $0x80110500
80104a0e:	e8 b3 04 00 00       	call   80104ec6 <acquire>
80104a13:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a16:	c7 45 f4 34 05 11 80 	movl   $0x80110534,-0xc(%ebp)
80104a1d:	eb 62                	jmp    80104a81 <scheduler+0x86>
      if(p->state != RUNNABLE)
80104a1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a22:	8b 40 0c             	mov    0xc(%eax),%eax
80104a25:	83 f8 03             	cmp    $0x3,%eax
80104a28:	74 02                	je     80104a2c <scheduler+0x31>
        continue;
80104a2a:	eb 51                	jmp    80104a7d <scheduler+0x82>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
80104a2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a2f:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
80104a35:	83 ec 0c             	sub    $0xc,%esp
80104a38:	ff 75 f4             	pushl  -0xc(%ebp)
80104a3b:	e8 5a 34 00 00       	call   80107e9a <switchuvm>
80104a40:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
80104a43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a46:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
80104a4d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a53:	8b 40 1c             	mov    0x1c(%eax),%eax
80104a56:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104a5d:	83 c2 04             	add    $0x4,%edx
80104a60:	83 ec 08             	sub    $0x8,%esp
80104a63:	50                   	push   %eax
80104a64:	52                   	push   %edx
80104a65:	e8 2e 09 00 00       	call   80105398 <swtch>
80104a6a:	83 c4 10             	add    $0x10,%esp
      switchkvm();
80104a6d:	e8 0c 34 00 00       	call   80107e7e <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80104a72:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104a79:	00 00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a7d:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104a81:	81 7d f4 34 24 11 80 	cmpl   $0x80112434,-0xc(%ebp)
80104a88:	72 95                	jb     80104a1f <scheduler+0x24>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80104a8a:	83 ec 0c             	sub    $0xc,%esp
80104a8d:	68 00 05 11 80       	push   $0x80110500
80104a92:	e8 95 04 00 00       	call   80104f2c <release>
80104a97:	83 c4 10             	add    $0x10,%esp

  }
80104a9a:	e9 62 ff ff ff       	jmp    80104a01 <scheduler+0x6>

80104a9f <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104a9f:	55                   	push   %ebp
80104aa0:	89 e5                	mov    %esp,%ebp
80104aa2:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104aa5:	83 ec 0c             	sub    $0xc,%esp
80104aa8:	68 00 05 11 80       	push   $0x80110500
80104aad:	e8 44 05 00 00       	call   80104ff6 <holding>
80104ab2:	83 c4 10             	add    $0x10,%esp
80104ab5:	85 c0                	test   %eax,%eax
80104ab7:	75 0d                	jne    80104ac6 <sched+0x27>
    panic("sched ptable.lock");
80104ab9:	83 ec 0c             	sub    $0xc,%esp
80104abc:	68 c9 88 10 80       	push   $0x801088c9
80104ac1:	e8 96 ba ff ff       	call   8010055c <panic>
  if(cpu->ncli != 1)
80104ac6:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104acc:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104ad2:	83 f8 01             	cmp    $0x1,%eax
80104ad5:	74 0d                	je     80104ae4 <sched+0x45>
    panic("sched locks");
80104ad7:	83 ec 0c             	sub    $0xc,%esp
80104ada:	68 db 88 10 80       	push   $0x801088db
80104adf:	e8 78 ba ff ff       	call   8010055c <panic>
  if(proc->state == RUNNING)
80104ae4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104aea:	8b 40 0c             	mov    0xc(%eax),%eax
80104aed:	83 f8 04             	cmp    $0x4,%eax
80104af0:	75 0d                	jne    80104aff <sched+0x60>
    panic("sched running");
80104af2:	83 ec 0c             	sub    $0xc,%esp
80104af5:	68 e7 88 10 80       	push   $0x801088e7
80104afa:	e8 5d ba ff ff       	call   8010055c <panic>
  if(readeflags()&FL_IF)
80104aff:	e8 3f f8 ff ff       	call   80104343 <readeflags>
80104b04:	25 00 02 00 00       	and    $0x200,%eax
80104b09:	85 c0                	test   %eax,%eax
80104b0b:	74 0d                	je     80104b1a <sched+0x7b>
    panic("sched interruptible");
80104b0d:	83 ec 0c             	sub    $0xc,%esp
80104b10:	68 f5 88 10 80       	push   $0x801088f5
80104b15:	e8 42 ba ff ff       	call   8010055c <panic>
  intena = cpu->intena;
80104b1a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b20:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104b26:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104b29:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b2f:	8b 40 04             	mov    0x4(%eax),%eax
80104b32:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104b39:	83 c2 1c             	add    $0x1c,%edx
80104b3c:	83 ec 08             	sub    $0x8,%esp
80104b3f:	50                   	push   %eax
80104b40:	52                   	push   %edx
80104b41:	e8 52 08 00 00       	call   80105398 <swtch>
80104b46:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80104b49:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b4f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b52:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104b58:	c9                   	leave  
80104b59:	c3                   	ret    

80104b5a <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104b5a:	55                   	push   %ebp
80104b5b:	89 e5                	mov    %esp,%ebp
80104b5d:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104b60:	83 ec 0c             	sub    $0xc,%esp
80104b63:	68 00 05 11 80       	push   $0x80110500
80104b68:	e8 59 03 00 00       	call   80104ec6 <acquire>
80104b6d:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104b70:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b76:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104b7d:	e8 1d ff ff ff       	call   80104a9f <sched>
  release(&ptable.lock);
80104b82:	83 ec 0c             	sub    $0xc,%esp
80104b85:	68 00 05 11 80       	push   $0x80110500
80104b8a:	e8 9d 03 00 00       	call   80104f2c <release>
80104b8f:	83 c4 10             	add    $0x10,%esp
}
80104b92:	c9                   	leave  
80104b93:	c3                   	ret    

80104b94 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104b94:	55                   	push   %ebp
80104b95:	89 e5                	mov    %esp,%ebp
80104b97:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104b9a:	83 ec 0c             	sub    $0xc,%esp
80104b9d:	68 00 05 11 80       	push   $0x80110500
80104ba2:	e8 85 03 00 00       	call   80104f2c <release>
80104ba7:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104baa:	a1 08 b0 10 80       	mov    0x8010b008,%eax
80104baf:	85 c0                	test   %eax,%eax
80104bb1:	74 0f                	je     80104bc2 <forkret+0x2e>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104bb3:	c7 05 08 b0 10 80 00 	movl   $0x0,0x8010b008
80104bba:	00 00 00 
    initlog();
80104bbd:	e8 b3 e7 ff ff       	call   80103375 <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80104bc2:	c9                   	leave  
80104bc3:	c3                   	ret    

80104bc4 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104bc4:	55                   	push   %ebp
80104bc5:	89 e5                	mov    %esp,%ebp
80104bc7:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
80104bca:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bd0:	85 c0                	test   %eax,%eax
80104bd2:	75 0d                	jne    80104be1 <sleep+0x1d>
    panic("sleep");
80104bd4:	83 ec 0c             	sub    $0xc,%esp
80104bd7:	68 09 89 10 80       	push   $0x80108909
80104bdc:	e8 7b b9 ff ff       	call   8010055c <panic>

  if(lk == 0)
80104be1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104be5:	75 0d                	jne    80104bf4 <sleep+0x30>
    panic("sleep without lk");
80104be7:	83 ec 0c             	sub    $0xc,%esp
80104bea:	68 0f 89 10 80       	push   $0x8010890f
80104bef:	e8 68 b9 ff ff       	call   8010055c <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104bf4:	81 7d 0c 00 05 11 80 	cmpl   $0x80110500,0xc(%ebp)
80104bfb:	74 1e                	je     80104c1b <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104bfd:	83 ec 0c             	sub    $0xc,%esp
80104c00:	68 00 05 11 80       	push   $0x80110500
80104c05:	e8 bc 02 00 00       	call   80104ec6 <acquire>
80104c0a:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104c0d:	83 ec 0c             	sub    $0xc,%esp
80104c10:	ff 75 0c             	pushl  0xc(%ebp)
80104c13:	e8 14 03 00 00       	call   80104f2c <release>
80104c18:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80104c1b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c21:	8b 55 08             	mov    0x8(%ebp),%edx
80104c24:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104c27:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c2d:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104c34:	e8 66 fe ff ff       	call   80104a9f <sched>

  // Tidy up.
  proc->chan = 0;
80104c39:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c3f:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104c46:	81 7d 0c 00 05 11 80 	cmpl   $0x80110500,0xc(%ebp)
80104c4d:	74 1e                	je     80104c6d <sleep+0xa9>
    release(&ptable.lock);
80104c4f:	83 ec 0c             	sub    $0xc,%esp
80104c52:	68 00 05 11 80       	push   $0x80110500
80104c57:	e8 d0 02 00 00       	call   80104f2c <release>
80104c5c:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104c5f:	83 ec 0c             	sub    $0xc,%esp
80104c62:	ff 75 0c             	pushl  0xc(%ebp)
80104c65:	e8 5c 02 00 00       	call   80104ec6 <acquire>
80104c6a:	83 c4 10             	add    $0x10,%esp
  }
}
80104c6d:	c9                   	leave  
80104c6e:	c3                   	ret    

80104c6f <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104c6f:	55                   	push   %ebp
80104c70:	89 e5                	mov    %esp,%ebp
80104c72:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c75:	c7 45 fc 34 05 11 80 	movl   $0x80110534,-0x4(%ebp)
80104c7c:	eb 24                	jmp    80104ca2 <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104c7e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c81:	8b 40 0c             	mov    0xc(%eax),%eax
80104c84:	83 f8 02             	cmp    $0x2,%eax
80104c87:	75 15                	jne    80104c9e <wakeup1+0x2f>
80104c89:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c8c:	8b 40 20             	mov    0x20(%eax),%eax
80104c8f:	3b 45 08             	cmp    0x8(%ebp),%eax
80104c92:	75 0a                	jne    80104c9e <wakeup1+0x2f>
      p->state = RUNNABLE;
80104c94:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c97:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c9e:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
80104ca2:	81 7d fc 34 24 11 80 	cmpl   $0x80112434,-0x4(%ebp)
80104ca9:	72 d3                	jb     80104c7e <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
80104cab:	c9                   	leave  
80104cac:	c3                   	ret    

80104cad <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104cad:	55                   	push   %ebp
80104cae:	89 e5                	mov    %esp,%ebp
80104cb0:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104cb3:	83 ec 0c             	sub    $0xc,%esp
80104cb6:	68 00 05 11 80       	push   $0x80110500
80104cbb:	e8 06 02 00 00       	call   80104ec6 <acquire>
80104cc0:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104cc3:	83 ec 0c             	sub    $0xc,%esp
80104cc6:	ff 75 08             	pushl  0x8(%ebp)
80104cc9:	e8 a1 ff ff ff       	call   80104c6f <wakeup1>
80104cce:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104cd1:	83 ec 0c             	sub    $0xc,%esp
80104cd4:	68 00 05 11 80       	push   $0x80110500
80104cd9:	e8 4e 02 00 00       	call   80104f2c <release>
80104cde:	83 c4 10             	add    $0x10,%esp
}
80104ce1:	c9                   	leave  
80104ce2:	c3                   	ret    

80104ce3 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104ce3:	55                   	push   %ebp
80104ce4:	89 e5                	mov    %esp,%ebp
80104ce6:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104ce9:	83 ec 0c             	sub    $0xc,%esp
80104cec:	68 00 05 11 80       	push   $0x80110500
80104cf1:	e8 d0 01 00 00       	call   80104ec6 <acquire>
80104cf6:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cf9:	c7 45 f4 34 05 11 80 	movl   $0x80110534,-0xc(%ebp)
80104d00:	eb 45                	jmp    80104d47 <kill+0x64>
    if(p->pid == pid){
80104d02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d05:	8b 40 10             	mov    0x10(%eax),%eax
80104d08:	3b 45 08             	cmp    0x8(%ebp),%eax
80104d0b:	75 36                	jne    80104d43 <kill+0x60>
      p->killed = 1;
80104d0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d10:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104d17:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d1a:	8b 40 0c             	mov    0xc(%eax),%eax
80104d1d:	83 f8 02             	cmp    $0x2,%eax
80104d20:	75 0a                	jne    80104d2c <kill+0x49>
        p->state = RUNNABLE;
80104d22:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d25:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104d2c:	83 ec 0c             	sub    $0xc,%esp
80104d2f:	68 00 05 11 80       	push   $0x80110500
80104d34:	e8 f3 01 00 00       	call   80104f2c <release>
80104d39:	83 c4 10             	add    $0x10,%esp
      return 0;
80104d3c:	b8 00 00 00 00       	mov    $0x0,%eax
80104d41:	eb 22                	jmp    80104d65 <kill+0x82>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d43:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104d47:	81 7d f4 34 24 11 80 	cmpl   $0x80112434,-0xc(%ebp)
80104d4e:	72 b2                	jb     80104d02 <kill+0x1f>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104d50:	83 ec 0c             	sub    $0xc,%esp
80104d53:	68 00 05 11 80       	push   $0x80110500
80104d58:	e8 cf 01 00 00       	call   80104f2c <release>
80104d5d:	83 c4 10             	add    $0x10,%esp
  return -1;
80104d60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d65:	c9                   	leave  
80104d66:	c3                   	ret    

80104d67 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104d67:	55                   	push   %ebp
80104d68:	89 e5                	mov    %esp,%ebp
80104d6a:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d6d:	c7 45 f0 34 05 11 80 	movl   $0x80110534,-0x10(%ebp)
80104d74:	e9 d5 00 00 00       	jmp    80104e4e <procdump+0xe7>
    if(p->state == UNUSED)
80104d79:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d7c:	8b 40 0c             	mov    0xc(%eax),%eax
80104d7f:	85 c0                	test   %eax,%eax
80104d81:	75 05                	jne    80104d88 <procdump+0x21>
      continue;
80104d83:	e9 c2 00 00 00       	jmp    80104e4a <procdump+0xe3>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104d88:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d8b:	8b 40 0c             	mov    0xc(%eax),%eax
80104d8e:	83 f8 05             	cmp    $0x5,%eax
80104d91:	77 23                	ja     80104db6 <procdump+0x4f>
80104d93:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d96:	8b 40 0c             	mov    0xc(%eax),%eax
80104d99:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104da0:	85 c0                	test   %eax,%eax
80104da2:	74 12                	je     80104db6 <procdump+0x4f>
      state = states[p->state];
80104da4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104da7:	8b 40 0c             	mov    0xc(%eax),%eax
80104daa:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104db1:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104db4:	eb 07                	jmp    80104dbd <procdump+0x56>
    else
      state = "???";
80104db6:	c7 45 ec 20 89 10 80 	movl   $0x80108920,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104dbd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104dc0:	8d 50 6c             	lea    0x6c(%eax),%edx
80104dc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104dc6:	8b 40 10             	mov    0x10(%eax),%eax
80104dc9:	52                   	push   %edx
80104dca:	ff 75 ec             	pushl  -0x14(%ebp)
80104dcd:	50                   	push   %eax
80104dce:	68 24 89 10 80       	push   $0x80108924
80104dd3:	e8 e7 b5 ff ff       	call   801003bf <cprintf>
80104dd8:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80104ddb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104dde:	8b 40 0c             	mov    0xc(%eax),%eax
80104de1:	83 f8 02             	cmp    $0x2,%eax
80104de4:	75 54                	jne    80104e3a <procdump+0xd3>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104de6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104de9:	8b 40 1c             	mov    0x1c(%eax),%eax
80104dec:	8b 40 0c             	mov    0xc(%eax),%eax
80104def:	83 c0 08             	add    $0x8,%eax
80104df2:	89 c2                	mov    %eax,%edx
80104df4:	83 ec 08             	sub    $0x8,%esp
80104df7:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104dfa:	50                   	push   %eax
80104dfb:	52                   	push   %edx
80104dfc:	e8 7c 01 00 00       	call   80104f7d <getcallerpcs>
80104e01:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104e04:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104e0b:	eb 1c                	jmp    80104e29 <procdump+0xc2>
        cprintf(" %p", pc[i]);
80104e0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e10:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104e14:	83 ec 08             	sub    $0x8,%esp
80104e17:	50                   	push   %eax
80104e18:	68 2d 89 10 80       	push   $0x8010892d
80104e1d:	e8 9d b5 ff ff       	call   801003bf <cprintf>
80104e22:	83 c4 10             	add    $0x10,%esp
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104e25:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104e29:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104e2d:	7f 0b                	jg     80104e3a <procdump+0xd3>
80104e2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e32:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104e36:	85 c0                	test   %eax,%eax
80104e38:	75 d3                	jne    80104e0d <procdump+0xa6>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104e3a:	83 ec 0c             	sub    $0xc,%esp
80104e3d:	68 31 89 10 80       	push   $0x80108931
80104e42:	e8 78 b5 ff ff       	call   801003bf <cprintf>
80104e47:	83 c4 10             	add    $0x10,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e4a:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104e4e:	81 7d f0 34 24 11 80 	cmpl   $0x80112434,-0x10(%ebp)
80104e55:	0f 82 1e ff ff ff    	jb     80104d79 <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104e5b:	c9                   	leave  
80104e5c:	c3                   	ret    

80104e5d <ps>:

int ps(void)
{
80104e5d:	55                   	push   %ebp
80104e5e:	89 e5                	mov    %esp,%ebp
80104e60:	83 ec 08             	sub    $0x8,%esp
	procdump();
80104e63:	e8 ff fe ff ff       	call   80104d67 <procdump>
	return 0;
80104e68:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104e6d:	c9                   	leave  
80104e6e:	c3                   	ret    

80104e6f <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104e6f:	55                   	push   %ebp
80104e70:	89 e5                	mov    %esp,%ebp
80104e72:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104e75:	9c                   	pushf  
80104e76:	58                   	pop    %eax
80104e77:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104e7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104e7d:	c9                   	leave  
80104e7e:	c3                   	ret    

80104e7f <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80104e7f:	55                   	push   %ebp
80104e80:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104e82:	fa                   	cli    
}
80104e83:	5d                   	pop    %ebp
80104e84:	c3                   	ret    

80104e85 <sti>:

static inline void
sti(void)
{
80104e85:	55                   	push   %ebp
80104e86:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104e88:	fb                   	sti    
}
80104e89:	5d                   	pop    %ebp
80104e8a:	c3                   	ret    

80104e8b <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80104e8b:	55                   	push   %ebp
80104e8c:	89 e5                	mov    %esp,%ebp
80104e8e:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104e91:	8b 55 08             	mov    0x8(%ebp),%edx
80104e94:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e97:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e9a:	f0 87 02             	lock xchg %eax,(%edx)
80104e9d:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104ea0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104ea3:	c9                   	leave  
80104ea4:	c3                   	ret    

80104ea5 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104ea5:	55                   	push   %ebp
80104ea6:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104ea8:	8b 45 08             	mov    0x8(%ebp),%eax
80104eab:	8b 55 0c             	mov    0xc(%ebp),%edx
80104eae:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104eb1:	8b 45 08             	mov    0x8(%ebp),%eax
80104eb4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104eba:	8b 45 08             	mov    0x8(%ebp),%eax
80104ebd:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104ec4:	5d                   	pop    %ebp
80104ec5:	c3                   	ret    

80104ec6 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104ec6:	55                   	push   %ebp
80104ec7:	89 e5                	mov    %esp,%ebp
80104ec9:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104ecc:	e8 4f 01 00 00       	call   80105020 <pushcli>
  if(holding(lk))
80104ed1:	8b 45 08             	mov    0x8(%ebp),%eax
80104ed4:	83 ec 0c             	sub    $0xc,%esp
80104ed7:	50                   	push   %eax
80104ed8:	e8 19 01 00 00       	call   80104ff6 <holding>
80104edd:	83 c4 10             	add    $0x10,%esp
80104ee0:	85 c0                	test   %eax,%eax
80104ee2:	74 0d                	je     80104ef1 <acquire+0x2b>
    panic("acquire");
80104ee4:	83 ec 0c             	sub    $0xc,%esp
80104ee7:	68 5d 89 10 80       	push   $0x8010895d
80104eec:	e8 6b b6 ff ff       	call   8010055c <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80104ef1:	90                   	nop
80104ef2:	8b 45 08             	mov    0x8(%ebp),%eax
80104ef5:	83 ec 08             	sub    $0x8,%esp
80104ef8:	6a 01                	push   $0x1
80104efa:	50                   	push   %eax
80104efb:	e8 8b ff ff ff       	call   80104e8b <xchg>
80104f00:	83 c4 10             	add    $0x10,%esp
80104f03:	85 c0                	test   %eax,%eax
80104f05:	75 eb                	jne    80104ef2 <acquire+0x2c>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104f07:	8b 45 08             	mov    0x8(%ebp),%eax
80104f0a:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104f11:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104f14:	8b 45 08             	mov    0x8(%ebp),%eax
80104f17:	83 c0 0c             	add    $0xc,%eax
80104f1a:	83 ec 08             	sub    $0x8,%esp
80104f1d:	50                   	push   %eax
80104f1e:	8d 45 08             	lea    0x8(%ebp),%eax
80104f21:	50                   	push   %eax
80104f22:	e8 56 00 00 00       	call   80104f7d <getcallerpcs>
80104f27:	83 c4 10             	add    $0x10,%esp
}
80104f2a:	c9                   	leave  
80104f2b:	c3                   	ret    

80104f2c <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80104f2c:	55                   	push   %ebp
80104f2d:	89 e5                	mov    %esp,%ebp
80104f2f:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
80104f32:	83 ec 0c             	sub    $0xc,%esp
80104f35:	ff 75 08             	pushl  0x8(%ebp)
80104f38:	e8 b9 00 00 00       	call   80104ff6 <holding>
80104f3d:	83 c4 10             	add    $0x10,%esp
80104f40:	85 c0                	test   %eax,%eax
80104f42:	75 0d                	jne    80104f51 <release+0x25>
    panic("release");
80104f44:	83 ec 0c             	sub    $0xc,%esp
80104f47:	68 65 89 10 80       	push   $0x80108965
80104f4c:	e8 0b b6 ff ff       	call   8010055c <panic>

  lk->pcs[0] = 0;
80104f51:	8b 45 08             	mov    0x8(%ebp),%eax
80104f54:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104f5b:	8b 45 08             	mov    0x8(%ebp),%eax
80104f5e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80104f65:	8b 45 08             	mov    0x8(%ebp),%eax
80104f68:	83 ec 08             	sub    $0x8,%esp
80104f6b:	6a 00                	push   $0x0
80104f6d:	50                   	push   %eax
80104f6e:	e8 18 ff ff ff       	call   80104e8b <xchg>
80104f73:	83 c4 10             	add    $0x10,%esp

  popcli();
80104f76:	e8 e9 00 00 00       	call   80105064 <popcli>
}
80104f7b:	c9                   	leave  
80104f7c:	c3                   	ret    

80104f7d <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104f7d:	55                   	push   %ebp
80104f7e:	89 e5                	mov    %esp,%ebp
80104f80:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80104f83:	8b 45 08             	mov    0x8(%ebp),%eax
80104f86:	83 e8 08             	sub    $0x8,%eax
80104f89:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80104f8c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80104f93:	eb 38                	jmp    80104fcd <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f95:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80104f99:	74 38                	je     80104fd3 <getcallerpcs+0x56>
80104f9b:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80104fa2:	76 2f                	jbe    80104fd3 <getcallerpcs+0x56>
80104fa4:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80104fa8:	74 29                	je     80104fd3 <getcallerpcs+0x56>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104faa:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104fad:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104fb4:	8b 45 0c             	mov    0xc(%ebp),%eax
80104fb7:	01 c2                	add    %eax,%edx
80104fb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104fbc:	8b 40 04             	mov    0x4(%eax),%eax
80104fbf:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80104fc1:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104fc4:	8b 00                	mov    (%eax),%eax
80104fc6:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104fc9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104fcd:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104fd1:	7e c2                	jle    80104f95 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104fd3:	eb 19                	jmp    80104fee <getcallerpcs+0x71>
    pcs[i] = 0;
80104fd5:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104fd8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104fdf:	8b 45 0c             	mov    0xc(%ebp),%eax
80104fe2:	01 d0                	add    %edx,%eax
80104fe4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104fea:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104fee:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104ff2:	7e e1                	jle    80104fd5 <getcallerpcs+0x58>
    pcs[i] = 0;
}
80104ff4:	c9                   	leave  
80104ff5:	c3                   	ret    

80104ff6 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104ff6:	55                   	push   %ebp
80104ff7:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80104ff9:	8b 45 08             	mov    0x8(%ebp),%eax
80104ffc:	8b 00                	mov    (%eax),%eax
80104ffe:	85 c0                	test   %eax,%eax
80105000:	74 17                	je     80105019 <holding+0x23>
80105002:	8b 45 08             	mov    0x8(%ebp),%eax
80105005:	8b 50 08             	mov    0x8(%eax),%edx
80105008:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010500e:	39 c2                	cmp    %eax,%edx
80105010:	75 07                	jne    80105019 <holding+0x23>
80105012:	b8 01 00 00 00       	mov    $0x1,%eax
80105017:	eb 05                	jmp    8010501e <holding+0x28>
80105019:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010501e:	5d                   	pop    %ebp
8010501f:	c3                   	ret    

80105020 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80105026:	e8 44 fe ff ff       	call   80104e6f <readeflags>
8010502b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
8010502e:	e8 4c fe ff ff       	call   80104e7f <cli>
  if(cpu->ncli++ == 0)
80105033:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010503a:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80105040:	8d 48 01             	lea    0x1(%eax),%ecx
80105043:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
80105049:	85 c0                	test   %eax,%eax
8010504b:	75 15                	jne    80105062 <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
8010504d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105053:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105056:	81 e2 00 02 00 00    	and    $0x200,%edx
8010505c:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80105062:	c9                   	leave  
80105063:	c3                   	ret    

80105064 <popcli>:

void
popcli(void)
{
80105064:	55                   	push   %ebp
80105065:	89 e5                	mov    %esp,%ebp
80105067:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
8010506a:	e8 00 fe ff ff       	call   80104e6f <readeflags>
8010506f:	25 00 02 00 00       	and    $0x200,%eax
80105074:	85 c0                	test   %eax,%eax
80105076:	74 0d                	je     80105085 <popcli+0x21>
    panic("popcli - interruptible");
80105078:	83 ec 0c             	sub    $0xc,%esp
8010507b:	68 6d 89 10 80       	push   $0x8010896d
80105080:	e8 d7 b4 ff ff       	call   8010055c <panic>
  if(--cpu->ncli < 0)
80105085:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010508b:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80105091:	83 ea 01             	sub    $0x1,%edx
80105094:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
8010509a:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801050a0:	85 c0                	test   %eax,%eax
801050a2:	79 0d                	jns    801050b1 <popcli+0x4d>
    panic("popcli");
801050a4:	83 ec 0c             	sub    $0xc,%esp
801050a7:	68 84 89 10 80       	push   $0x80108984
801050ac:	e8 ab b4 ff ff       	call   8010055c <panic>
  if(cpu->ncli == 0 && cpu->intena)
801050b1:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801050b7:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801050bd:	85 c0                	test   %eax,%eax
801050bf:	75 15                	jne    801050d6 <popcli+0x72>
801050c1:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801050c7:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
801050cd:	85 c0                	test   %eax,%eax
801050cf:	74 05                	je     801050d6 <popcli+0x72>
    sti();
801050d1:	e8 af fd ff ff       	call   80104e85 <sti>
}
801050d6:	c9                   	leave  
801050d7:	c3                   	ret    

801050d8 <stosb>:
801050d8:	55                   	push   %ebp
801050d9:	89 e5                	mov    %esp,%ebp
801050db:	57                   	push   %edi
801050dc:	53                   	push   %ebx
801050dd:	8b 4d 08             	mov    0x8(%ebp),%ecx
801050e0:	8b 55 10             	mov    0x10(%ebp),%edx
801050e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801050e6:	89 cb                	mov    %ecx,%ebx
801050e8:	89 df                	mov    %ebx,%edi
801050ea:	89 d1                	mov    %edx,%ecx
801050ec:	fc                   	cld    
801050ed:	f3 aa                	rep stos %al,%es:(%edi)
801050ef:	89 ca                	mov    %ecx,%edx
801050f1:	89 fb                	mov    %edi,%ebx
801050f3:	89 5d 08             	mov    %ebx,0x8(%ebp)
801050f6:	89 55 10             	mov    %edx,0x10(%ebp)
801050f9:	5b                   	pop    %ebx
801050fa:	5f                   	pop    %edi
801050fb:	5d                   	pop    %ebp
801050fc:	c3                   	ret    

801050fd <stosl>:
801050fd:	55                   	push   %ebp
801050fe:	89 e5                	mov    %esp,%ebp
80105100:	57                   	push   %edi
80105101:	53                   	push   %ebx
80105102:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105105:	8b 55 10             	mov    0x10(%ebp),%edx
80105108:	8b 45 0c             	mov    0xc(%ebp),%eax
8010510b:	89 cb                	mov    %ecx,%ebx
8010510d:	89 df                	mov    %ebx,%edi
8010510f:	89 d1                	mov    %edx,%ecx
80105111:	fc                   	cld    
80105112:	f3 ab                	rep stos %eax,%es:(%edi)
80105114:	89 ca                	mov    %ecx,%edx
80105116:	89 fb                	mov    %edi,%ebx
80105118:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010511b:	89 55 10             	mov    %edx,0x10(%ebp)
8010511e:	5b                   	pop    %ebx
8010511f:	5f                   	pop    %edi
80105120:	5d                   	pop    %ebp
80105121:	c3                   	ret    

80105122 <memset>:
80105122:	55                   	push   %ebp
80105123:	89 e5                	mov    %esp,%ebp
80105125:	8b 45 08             	mov    0x8(%ebp),%eax
80105128:	83 e0 03             	and    $0x3,%eax
8010512b:	85 c0                	test   %eax,%eax
8010512d:	75 43                	jne    80105172 <memset+0x50>
8010512f:	8b 45 10             	mov    0x10(%ebp),%eax
80105132:	83 e0 03             	and    $0x3,%eax
80105135:	85 c0                	test   %eax,%eax
80105137:	75 39                	jne    80105172 <memset+0x50>
80105139:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
80105140:	8b 45 10             	mov    0x10(%ebp),%eax
80105143:	c1 e8 02             	shr    $0x2,%eax
80105146:	89 c1                	mov    %eax,%ecx
80105148:	8b 45 0c             	mov    0xc(%ebp),%eax
8010514b:	c1 e0 18             	shl    $0x18,%eax
8010514e:	89 c2                	mov    %eax,%edx
80105150:	8b 45 0c             	mov    0xc(%ebp),%eax
80105153:	c1 e0 10             	shl    $0x10,%eax
80105156:	09 c2                	or     %eax,%edx
80105158:	8b 45 0c             	mov    0xc(%ebp),%eax
8010515b:	c1 e0 08             	shl    $0x8,%eax
8010515e:	09 d0                	or     %edx,%eax
80105160:	0b 45 0c             	or     0xc(%ebp),%eax
80105163:	51                   	push   %ecx
80105164:	50                   	push   %eax
80105165:	ff 75 08             	pushl  0x8(%ebp)
80105168:	e8 90 ff ff ff       	call   801050fd <stosl>
8010516d:	83 c4 0c             	add    $0xc,%esp
80105170:	eb 12                	jmp    80105184 <memset+0x62>
80105172:	8b 45 10             	mov    0x10(%ebp),%eax
80105175:	50                   	push   %eax
80105176:	ff 75 0c             	pushl  0xc(%ebp)
80105179:	ff 75 08             	pushl  0x8(%ebp)
8010517c:	e8 57 ff ff ff       	call   801050d8 <stosb>
80105181:	83 c4 0c             	add    $0xc,%esp
80105184:	8b 45 08             	mov    0x8(%ebp),%eax
80105187:	c9                   	leave  
80105188:	c3                   	ret    

80105189 <memcmp>:
80105189:	55                   	push   %ebp
8010518a:	89 e5                	mov    %esp,%ebp
8010518c:	83 ec 10             	sub    $0x10,%esp
8010518f:	8b 45 08             	mov    0x8(%ebp),%eax
80105192:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105195:	8b 45 0c             	mov    0xc(%ebp),%eax
80105198:	89 45 f8             	mov    %eax,-0x8(%ebp)
8010519b:	eb 30                	jmp    801051cd <memcmp+0x44>
8010519d:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051a0:	0f b6 10             	movzbl (%eax),%edx
801051a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051a6:	0f b6 00             	movzbl (%eax),%eax
801051a9:	38 c2                	cmp    %al,%dl
801051ab:	74 18                	je     801051c5 <memcmp+0x3c>
801051ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051b0:	0f b6 00             	movzbl (%eax),%eax
801051b3:	0f b6 d0             	movzbl %al,%edx
801051b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051b9:	0f b6 00             	movzbl (%eax),%eax
801051bc:	0f b6 c0             	movzbl %al,%eax
801051bf:	29 c2                	sub    %eax,%edx
801051c1:	89 d0                	mov    %edx,%eax
801051c3:	eb 1a                	jmp    801051df <memcmp+0x56>
801051c5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801051c9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801051cd:	8b 45 10             	mov    0x10(%ebp),%eax
801051d0:	8d 50 ff             	lea    -0x1(%eax),%edx
801051d3:	89 55 10             	mov    %edx,0x10(%ebp)
801051d6:	85 c0                	test   %eax,%eax
801051d8:	75 c3                	jne    8010519d <memcmp+0x14>
801051da:	b8 00 00 00 00       	mov    $0x0,%eax
801051df:	c9                   	leave  
801051e0:	c3                   	ret    

801051e1 <memmove>:
801051e1:	55                   	push   %ebp
801051e2:	89 e5                	mov    %esp,%ebp
801051e4:	83 ec 10             	sub    $0x10,%esp
801051e7:	8b 45 0c             	mov    0xc(%ebp),%eax
801051ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
801051ed:	8b 45 08             	mov    0x8(%ebp),%eax
801051f0:	89 45 f8             	mov    %eax,-0x8(%ebp)
801051f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051f6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801051f9:	73 3d                	jae    80105238 <memmove+0x57>
801051fb:	8b 55 fc             	mov    -0x4(%ebp),%edx
801051fe:	8b 45 10             	mov    0x10(%ebp),%eax
80105201:	01 d0                	add    %edx,%eax
80105203:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105206:	76 30                	jbe    80105238 <memmove+0x57>
80105208:	8b 45 10             	mov    0x10(%ebp),%eax
8010520b:	01 45 fc             	add    %eax,-0x4(%ebp)
8010520e:	8b 45 10             	mov    0x10(%ebp),%eax
80105211:	01 45 f8             	add    %eax,-0x8(%ebp)
80105214:	eb 13                	jmp    80105229 <memmove+0x48>
80105216:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
8010521a:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
8010521e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105221:	0f b6 10             	movzbl (%eax),%edx
80105224:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105227:	88 10                	mov    %dl,(%eax)
80105229:	8b 45 10             	mov    0x10(%ebp),%eax
8010522c:	8d 50 ff             	lea    -0x1(%eax),%edx
8010522f:	89 55 10             	mov    %edx,0x10(%ebp)
80105232:	85 c0                	test   %eax,%eax
80105234:	75 e0                	jne    80105216 <memmove+0x35>
80105236:	eb 26                	jmp    8010525e <memmove+0x7d>
80105238:	eb 17                	jmp    80105251 <memmove+0x70>
8010523a:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010523d:	8d 50 01             	lea    0x1(%eax),%edx
80105240:	89 55 f8             	mov    %edx,-0x8(%ebp)
80105243:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105246:	8d 4a 01             	lea    0x1(%edx),%ecx
80105249:	89 4d fc             	mov    %ecx,-0x4(%ebp)
8010524c:	0f b6 12             	movzbl (%edx),%edx
8010524f:	88 10                	mov    %dl,(%eax)
80105251:	8b 45 10             	mov    0x10(%ebp),%eax
80105254:	8d 50 ff             	lea    -0x1(%eax),%edx
80105257:	89 55 10             	mov    %edx,0x10(%ebp)
8010525a:	85 c0                	test   %eax,%eax
8010525c:	75 dc                	jne    8010523a <memmove+0x59>
8010525e:	8b 45 08             	mov    0x8(%ebp),%eax
80105261:	c9                   	leave  
80105262:	c3                   	ret    

80105263 <memcpy>:
80105263:	55                   	push   %ebp
80105264:	89 e5                	mov    %esp,%ebp
80105266:	ff 75 10             	pushl  0x10(%ebp)
80105269:	ff 75 0c             	pushl  0xc(%ebp)
8010526c:	ff 75 08             	pushl  0x8(%ebp)
8010526f:	e8 6d ff ff ff       	call   801051e1 <memmove>
80105274:	83 c4 0c             	add    $0xc,%esp
80105277:	c9                   	leave  
80105278:	c3                   	ret    

80105279 <strncmp>:
80105279:	55                   	push   %ebp
8010527a:	89 e5                	mov    %esp,%ebp
8010527c:	eb 0c                	jmp    8010528a <strncmp+0x11>
8010527e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105282:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105286:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
8010528a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010528e:	74 1a                	je     801052aa <strncmp+0x31>
80105290:	8b 45 08             	mov    0x8(%ebp),%eax
80105293:	0f b6 00             	movzbl (%eax),%eax
80105296:	84 c0                	test   %al,%al
80105298:	74 10                	je     801052aa <strncmp+0x31>
8010529a:	8b 45 08             	mov    0x8(%ebp),%eax
8010529d:	0f b6 10             	movzbl (%eax),%edx
801052a0:	8b 45 0c             	mov    0xc(%ebp),%eax
801052a3:	0f b6 00             	movzbl (%eax),%eax
801052a6:	38 c2                	cmp    %al,%dl
801052a8:	74 d4                	je     8010527e <strncmp+0x5>
801052aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801052ae:	75 07                	jne    801052b7 <strncmp+0x3e>
801052b0:	b8 00 00 00 00       	mov    $0x0,%eax
801052b5:	eb 16                	jmp    801052cd <strncmp+0x54>
801052b7:	8b 45 08             	mov    0x8(%ebp),%eax
801052ba:	0f b6 00             	movzbl (%eax),%eax
801052bd:	0f b6 d0             	movzbl %al,%edx
801052c0:	8b 45 0c             	mov    0xc(%ebp),%eax
801052c3:	0f b6 00             	movzbl (%eax),%eax
801052c6:	0f b6 c0             	movzbl %al,%eax
801052c9:	29 c2                	sub    %eax,%edx
801052cb:	89 d0                	mov    %edx,%eax
801052cd:	5d                   	pop    %ebp
801052ce:	c3                   	ret    

801052cf <strncpy>:
801052cf:	55                   	push   %ebp
801052d0:	89 e5                	mov    %esp,%ebp
801052d2:	83 ec 10             	sub    $0x10,%esp
801052d5:	8b 45 08             	mov    0x8(%ebp),%eax
801052d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
801052db:	90                   	nop
801052dc:	8b 45 10             	mov    0x10(%ebp),%eax
801052df:	8d 50 ff             	lea    -0x1(%eax),%edx
801052e2:	89 55 10             	mov    %edx,0x10(%ebp)
801052e5:	85 c0                	test   %eax,%eax
801052e7:	7e 1e                	jle    80105307 <strncpy+0x38>
801052e9:	8b 45 08             	mov    0x8(%ebp),%eax
801052ec:	8d 50 01             	lea    0x1(%eax),%edx
801052ef:	89 55 08             	mov    %edx,0x8(%ebp)
801052f2:	8b 55 0c             	mov    0xc(%ebp),%edx
801052f5:	8d 4a 01             	lea    0x1(%edx),%ecx
801052f8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
801052fb:	0f b6 12             	movzbl (%edx),%edx
801052fe:	88 10                	mov    %dl,(%eax)
80105300:	0f b6 00             	movzbl (%eax),%eax
80105303:	84 c0                	test   %al,%al
80105305:	75 d5                	jne    801052dc <strncpy+0xd>
80105307:	eb 0c                	jmp    80105315 <strncpy+0x46>
80105309:	8b 45 08             	mov    0x8(%ebp),%eax
8010530c:	8d 50 01             	lea    0x1(%eax),%edx
8010530f:	89 55 08             	mov    %edx,0x8(%ebp)
80105312:	c6 00 00             	movb   $0x0,(%eax)
80105315:	8b 45 10             	mov    0x10(%ebp),%eax
80105318:	8d 50 ff             	lea    -0x1(%eax),%edx
8010531b:	89 55 10             	mov    %edx,0x10(%ebp)
8010531e:	85 c0                	test   %eax,%eax
80105320:	7f e7                	jg     80105309 <strncpy+0x3a>
80105322:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105325:	c9                   	leave  
80105326:	c3                   	ret    

80105327 <safestrcpy>:
80105327:	55                   	push   %ebp
80105328:	89 e5                	mov    %esp,%ebp
8010532a:	83 ec 10             	sub    $0x10,%esp
8010532d:	8b 45 08             	mov    0x8(%ebp),%eax
80105330:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105333:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105337:	7f 05                	jg     8010533e <safestrcpy+0x17>
80105339:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010533c:	eb 31                	jmp    8010536f <safestrcpy+0x48>
8010533e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105342:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105346:	7e 1e                	jle    80105366 <safestrcpy+0x3f>
80105348:	8b 45 08             	mov    0x8(%ebp),%eax
8010534b:	8d 50 01             	lea    0x1(%eax),%edx
8010534e:	89 55 08             	mov    %edx,0x8(%ebp)
80105351:	8b 55 0c             	mov    0xc(%ebp),%edx
80105354:	8d 4a 01             	lea    0x1(%edx),%ecx
80105357:	89 4d 0c             	mov    %ecx,0xc(%ebp)
8010535a:	0f b6 12             	movzbl (%edx),%edx
8010535d:	88 10                	mov    %dl,(%eax)
8010535f:	0f b6 00             	movzbl (%eax),%eax
80105362:	84 c0                	test   %al,%al
80105364:	75 d8                	jne    8010533e <safestrcpy+0x17>
80105366:	8b 45 08             	mov    0x8(%ebp),%eax
80105369:	c6 00 00             	movb   $0x0,(%eax)
8010536c:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010536f:	c9                   	leave  
80105370:	c3                   	ret    

80105371 <strlen>:
80105371:	55                   	push   %ebp
80105372:	89 e5                	mov    %esp,%ebp
80105374:	83 ec 10             	sub    $0x10,%esp
80105377:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010537e:	eb 04                	jmp    80105384 <strlen+0x13>
80105380:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105384:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105387:	8b 45 08             	mov    0x8(%ebp),%eax
8010538a:	01 d0                	add    %edx,%eax
8010538c:	0f b6 00             	movzbl (%eax),%eax
8010538f:	84 c0                	test   %al,%al
80105391:	75 ed                	jne    80105380 <strlen+0xf>
80105393:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105396:	c9                   	leave  
80105397:	c3                   	ret    

80105398 <swtch>:
80105398:	8b 44 24 04          	mov    0x4(%esp),%eax
8010539c:	8b 54 24 08          	mov    0x8(%esp),%edx
801053a0:	55                   	push   %ebp
801053a1:	53                   	push   %ebx
801053a2:	56                   	push   %esi
801053a3:	57                   	push   %edi
801053a4:	89 20                	mov    %esp,(%eax)
801053a6:	89 d4                	mov    %edx,%esp
801053a8:	5f                   	pop    %edi
801053a9:	5e                   	pop    %esi
801053aa:	5b                   	pop    %ebx
801053ab:	5d                   	pop    %ebp
801053ac:	c3                   	ret    

801053ad <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801053ad:	55                   	push   %ebp
801053ae:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
801053b0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053b6:	8b 00                	mov    (%eax),%eax
801053b8:	3b 45 08             	cmp    0x8(%ebp),%eax
801053bb:	76 12                	jbe    801053cf <fetchint+0x22>
801053bd:	8b 45 08             	mov    0x8(%ebp),%eax
801053c0:	8d 50 04             	lea    0x4(%eax),%edx
801053c3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053c9:	8b 00                	mov    (%eax),%eax
801053cb:	39 c2                	cmp    %eax,%edx
801053cd:	76 07                	jbe    801053d6 <fetchint+0x29>
    return -1;
801053cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053d4:	eb 0f                	jmp    801053e5 <fetchint+0x38>
  *ip = *(int*)(addr);
801053d6:	8b 45 08             	mov    0x8(%ebp),%eax
801053d9:	8b 10                	mov    (%eax),%edx
801053db:	8b 45 0c             	mov    0xc(%ebp),%eax
801053de:	89 10                	mov    %edx,(%eax)
  return 0;
801053e0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801053e5:	5d                   	pop    %ebp
801053e6:	c3                   	ret    

801053e7 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801053e7:	55                   	push   %ebp
801053e8:	89 e5                	mov    %esp,%ebp
801053ea:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
801053ed:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053f3:	8b 00                	mov    (%eax),%eax
801053f5:	3b 45 08             	cmp    0x8(%ebp),%eax
801053f8:	77 07                	ja     80105401 <fetchstr+0x1a>
    return -1;
801053fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053ff:	eb 46                	jmp    80105447 <fetchstr+0x60>
  *pp = (char*)addr;
80105401:	8b 55 08             	mov    0x8(%ebp),%edx
80105404:	8b 45 0c             	mov    0xc(%ebp),%eax
80105407:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
80105409:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010540f:	8b 00                	mov    (%eax),%eax
80105411:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
80105414:	8b 45 0c             	mov    0xc(%ebp),%eax
80105417:	8b 00                	mov    (%eax),%eax
80105419:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010541c:	eb 1c                	jmp    8010543a <fetchstr+0x53>
    if(*s == 0)
8010541e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105421:	0f b6 00             	movzbl (%eax),%eax
80105424:	84 c0                	test   %al,%al
80105426:	75 0e                	jne    80105436 <fetchstr+0x4f>
      return s - *pp;
80105428:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010542b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010542e:	8b 00                	mov    (%eax),%eax
80105430:	29 c2                	sub    %eax,%edx
80105432:	89 d0                	mov    %edx,%eax
80105434:	eb 11                	jmp    80105447 <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
80105436:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010543a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010543d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105440:	72 dc                	jb     8010541e <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
80105442:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105447:	c9                   	leave  
80105448:	c3                   	ret    

80105449 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105449:	55                   	push   %ebp
8010544a:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010544c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105452:	8b 40 18             	mov    0x18(%eax),%eax
80105455:	8b 40 44             	mov    0x44(%eax),%eax
80105458:	8b 55 08             	mov    0x8(%ebp),%edx
8010545b:	c1 e2 02             	shl    $0x2,%edx
8010545e:	01 d0                	add    %edx,%eax
80105460:	83 c0 04             	add    $0x4,%eax
80105463:	ff 75 0c             	pushl  0xc(%ebp)
80105466:	50                   	push   %eax
80105467:	e8 41 ff ff ff       	call   801053ad <fetchint>
8010546c:	83 c4 08             	add    $0x8,%esp
}
8010546f:	c9                   	leave  
80105470:	c3                   	ret    

80105471 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105471:	55                   	push   %ebp
80105472:	89 e5                	mov    %esp,%ebp
80105474:	83 ec 10             	sub    $0x10,%esp
  int i;
  
  if(argint(n, &i) < 0)
80105477:	8d 45 fc             	lea    -0x4(%ebp),%eax
8010547a:	50                   	push   %eax
8010547b:	ff 75 08             	pushl  0x8(%ebp)
8010547e:	e8 c6 ff ff ff       	call   80105449 <argint>
80105483:	83 c4 08             	add    $0x8,%esp
80105486:	85 c0                	test   %eax,%eax
80105488:	79 07                	jns    80105491 <argptr+0x20>
    return -1;
8010548a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010548f:	eb 3d                	jmp    801054ce <argptr+0x5d>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80105491:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105494:	89 c2                	mov    %eax,%edx
80105496:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010549c:	8b 00                	mov    (%eax),%eax
8010549e:	39 c2                	cmp    %eax,%edx
801054a0:	73 16                	jae    801054b8 <argptr+0x47>
801054a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
801054a5:	89 c2                	mov    %eax,%edx
801054a7:	8b 45 10             	mov    0x10(%ebp),%eax
801054aa:	01 c2                	add    %eax,%edx
801054ac:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054b2:	8b 00                	mov    (%eax),%eax
801054b4:	39 c2                	cmp    %eax,%edx
801054b6:	76 07                	jbe    801054bf <argptr+0x4e>
    return -1;
801054b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054bd:	eb 0f                	jmp    801054ce <argptr+0x5d>
  *pp = (char*)i;
801054bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
801054c2:	89 c2                	mov    %eax,%edx
801054c4:	8b 45 0c             	mov    0xc(%ebp),%eax
801054c7:	89 10                	mov    %edx,(%eax)
  return 0;
801054c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
801054ce:	c9                   	leave  
801054cf:	c3                   	ret    

801054d0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
801054d3:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
801054d6:	8d 45 fc             	lea    -0x4(%ebp),%eax
801054d9:	50                   	push   %eax
801054da:	ff 75 08             	pushl  0x8(%ebp)
801054dd:	e8 67 ff ff ff       	call   80105449 <argint>
801054e2:	83 c4 08             	add    $0x8,%esp
801054e5:	85 c0                	test   %eax,%eax
801054e7:	79 07                	jns    801054f0 <argstr+0x20>
    return -1;
801054e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054ee:	eb 0f                	jmp    801054ff <argstr+0x2f>
  return fetchstr(addr, pp);
801054f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
801054f3:	ff 75 0c             	pushl  0xc(%ebp)
801054f6:	50                   	push   %eax
801054f7:	e8 eb fe ff ff       	call   801053e7 <fetchstr>
801054fc:	83 c4 08             	add    $0x8,%esp
}
801054ff:	c9                   	leave  
80105500:	c3                   	ret    

80105501 <syscall>:
[SYS_ps]	sys_ps,
};

void
syscall(void)
{
80105501:	55                   	push   %ebp
80105502:	89 e5                	mov    %esp,%ebp
80105504:	53                   	push   %ebx
80105505:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
80105508:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010550e:	8b 40 18             	mov    0x18(%eax),%eax
80105511:	8b 40 1c             	mov    0x1c(%eax),%eax
80105514:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105517:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010551b:	7e 30                	jle    8010554d <syscall+0x4c>
8010551d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105520:	83 f8 17             	cmp    $0x17,%eax
80105523:	77 28                	ja     8010554d <syscall+0x4c>
80105525:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105528:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
8010552f:	85 c0                	test   %eax,%eax
80105531:	74 1a                	je     8010554d <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
80105533:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105539:	8b 58 18             	mov    0x18(%eax),%ebx
8010553c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010553f:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105546:	ff d0                	call   *%eax
80105548:	89 43 1c             	mov    %eax,0x1c(%ebx)
8010554b:	eb 34                	jmp    80105581 <syscall+0x80>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
8010554d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105553:	8d 50 6c             	lea    0x6c(%eax),%edx
80105556:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
8010555c:	8b 40 10             	mov    0x10(%eax),%eax
8010555f:	ff 75 f4             	pushl  -0xc(%ebp)
80105562:	52                   	push   %edx
80105563:	50                   	push   %eax
80105564:	68 8b 89 10 80       	push   $0x8010898b
80105569:	e8 51 ae ff ff       	call   801003bf <cprintf>
8010556e:	83 c4 10             	add    $0x10,%esp
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
80105571:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105577:	8b 40 18             	mov    0x18(%eax),%eax
8010557a:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80105581:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105584:	c9                   	leave  
80105585:	c3                   	ret    

80105586 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80105586:	55                   	push   %ebp
80105587:	89 e5                	mov    %esp,%ebp
80105589:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010558c:	83 ec 08             	sub    $0x8,%esp
8010558f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105592:	50                   	push   %eax
80105593:	ff 75 08             	pushl  0x8(%ebp)
80105596:	e8 ae fe ff ff       	call   80105449 <argint>
8010559b:	83 c4 10             	add    $0x10,%esp
8010559e:	85 c0                	test   %eax,%eax
801055a0:	79 07                	jns    801055a9 <argfd+0x23>
    return -1;
801055a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055a7:	eb 50                	jmp    801055f9 <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
801055a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801055ac:	85 c0                	test   %eax,%eax
801055ae:	78 21                	js     801055d1 <argfd+0x4b>
801055b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801055b3:	83 f8 0f             	cmp    $0xf,%eax
801055b6:	7f 19                	jg     801055d1 <argfd+0x4b>
801055b8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055be:	8b 55 f0             	mov    -0x10(%ebp),%edx
801055c1:	83 c2 08             	add    $0x8,%edx
801055c4:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801055c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801055cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801055cf:	75 07                	jne    801055d8 <argfd+0x52>
    return -1;
801055d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055d6:	eb 21                	jmp    801055f9 <argfd+0x73>
  if(pfd)
801055d8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801055dc:	74 08                	je     801055e6 <argfd+0x60>
    *pfd = fd;
801055de:	8b 55 f0             	mov    -0x10(%ebp),%edx
801055e1:	8b 45 0c             	mov    0xc(%ebp),%eax
801055e4:	89 10                	mov    %edx,(%eax)
  if(pf)
801055e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801055ea:	74 08                	je     801055f4 <argfd+0x6e>
    *pf = f;
801055ec:	8b 45 10             	mov    0x10(%ebp),%eax
801055ef:	8b 55 f4             	mov    -0xc(%ebp),%edx
801055f2:	89 10                	mov    %edx,(%eax)
  return 0;
801055f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801055f9:	c9                   	leave  
801055fa:	c3                   	ret    

801055fb <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
801055fb:	55                   	push   %ebp
801055fc:	89 e5                	mov    %esp,%ebp
801055fe:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105601:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105608:	eb 30                	jmp    8010563a <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
8010560a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105610:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105613:	83 c2 08             	add    $0x8,%edx
80105616:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010561a:	85 c0                	test   %eax,%eax
8010561c:	75 18                	jne    80105636 <fdalloc+0x3b>
      proc->ofile[fd] = f;
8010561e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105624:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105627:	8d 4a 08             	lea    0x8(%edx),%ecx
8010562a:	8b 55 08             	mov    0x8(%ebp),%edx
8010562d:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
80105631:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105634:	eb 0f                	jmp    80105645 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105636:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010563a:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
8010563e:	7e ca                	jle    8010560a <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
80105640:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105645:	c9                   	leave  
80105646:	c3                   	ret    

80105647 <sys_dup>:

int
sys_dup(void)
{
80105647:	55                   	push   %ebp
80105648:	89 e5                	mov    %esp,%ebp
8010564a:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
8010564d:	83 ec 04             	sub    $0x4,%esp
80105650:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105653:	50                   	push   %eax
80105654:	6a 00                	push   $0x0
80105656:	6a 00                	push   $0x0
80105658:	e8 29 ff ff ff       	call   80105586 <argfd>
8010565d:	83 c4 10             	add    $0x10,%esp
80105660:	85 c0                	test   %eax,%eax
80105662:	79 07                	jns    8010566b <sys_dup+0x24>
    return -1;
80105664:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105669:	eb 31                	jmp    8010569c <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
8010566b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010566e:	83 ec 0c             	sub    $0xc,%esp
80105671:	50                   	push   %eax
80105672:	e8 84 ff ff ff       	call   801055fb <fdalloc>
80105677:	83 c4 10             	add    $0x10,%esp
8010567a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010567d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105681:	79 07                	jns    8010568a <sys_dup+0x43>
    return -1;
80105683:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105688:	eb 12                	jmp    8010569c <sys_dup+0x55>
  filedup(f);
8010568a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010568d:	83 ec 0c             	sub    $0xc,%esp
80105690:	50                   	push   %eax
80105691:	e8 79 bc ff ff       	call   8010130f <filedup>
80105696:	83 c4 10             	add    $0x10,%esp
  return fd;
80105699:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010569c:	c9                   	leave  
8010569d:	c3                   	ret    

8010569e <sys_read>:

int
sys_read(void)
{
8010569e:	55                   	push   %ebp
8010569f:	89 e5                	mov    %esp,%ebp
801056a1:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801056a4:	83 ec 04             	sub    $0x4,%esp
801056a7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056aa:	50                   	push   %eax
801056ab:	6a 00                	push   $0x0
801056ad:	6a 00                	push   $0x0
801056af:	e8 d2 fe ff ff       	call   80105586 <argfd>
801056b4:	83 c4 10             	add    $0x10,%esp
801056b7:	85 c0                	test   %eax,%eax
801056b9:	78 2e                	js     801056e9 <sys_read+0x4b>
801056bb:	83 ec 08             	sub    $0x8,%esp
801056be:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056c1:	50                   	push   %eax
801056c2:	6a 02                	push   $0x2
801056c4:	e8 80 fd ff ff       	call   80105449 <argint>
801056c9:	83 c4 10             	add    $0x10,%esp
801056cc:	85 c0                	test   %eax,%eax
801056ce:	78 19                	js     801056e9 <sys_read+0x4b>
801056d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801056d3:	83 ec 04             	sub    $0x4,%esp
801056d6:	50                   	push   %eax
801056d7:	8d 45 ec             	lea    -0x14(%ebp),%eax
801056da:	50                   	push   %eax
801056db:	6a 01                	push   $0x1
801056dd:	e8 8f fd ff ff       	call   80105471 <argptr>
801056e2:	83 c4 10             	add    $0x10,%esp
801056e5:	85 c0                	test   %eax,%eax
801056e7:	79 07                	jns    801056f0 <sys_read+0x52>
    return -1;
801056e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056ee:	eb 17                	jmp    80105707 <sys_read+0x69>
  return fileread(f, p, n);
801056f0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801056f3:	8b 55 ec             	mov    -0x14(%ebp),%edx
801056f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056f9:	83 ec 04             	sub    $0x4,%esp
801056fc:	51                   	push   %ecx
801056fd:	52                   	push   %edx
801056fe:	50                   	push   %eax
801056ff:	e8 9b bd ff ff       	call   8010149f <fileread>
80105704:	83 c4 10             	add    $0x10,%esp
}
80105707:	c9                   	leave  
80105708:	c3                   	ret    

80105709 <sys_write>:

int
sys_write(void)
{
80105709:	55                   	push   %ebp
8010570a:	89 e5                	mov    %esp,%ebp
8010570c:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010570f:	83 ec 04             	sub    $0x4,%esp
80105712:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105715:	50                   	push   %eax
80105716:	6a 00                	push   $0x0
80105718:	6a 00                	push   $0x0
8010571a:	e8 67 fe ff ff       	call   80105586 <argfd>
8010571f:	83 c4 10             	add    $0x10,%esp
80105722:	85 c0                	test   %eax,%eax
80105724:	78 2e                	js     80105754 <sys_write+0x4b>
80105726:	83 ec 08             	sub    $0x8,%esp
80105729:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010572c:	50                   	push   %eax
8010572d:	6a 02                	push   $0x2
8010572f:	e8 15 fd ff ff       	call   80105449 <argint>
80105734:	83 c4 10             	add    $0x10,%esp
80105737:	85 c0                	test   %eax,%eax
80105739:	78 19                	js     80105754 <sys_write+0x4b>
8010573b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010573e:	83 ec 04             	sub    $0x4,%esp
80105741:	50                   	push   %eax
80105742:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105745:	50                   	push   %eax
80105746:	6a 01                	push   $0x1
80105748:	e8 24 fd ff ff       	call   80105471 <argptr>
8010574d:	83 c4 10             	add    $0x10,%esp
80105750:	85 c0                	test   %eax,%eax
80105752:	79 07                	jns    8010575b <sys_write+0x52>
    return -1;
80105754:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105759:	eb 17                	jmp    80105772 <sys_write+0x69>
  return filewrite(f, p, n);
8010575b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010575e:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105761:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105764:	83 ec 04             	sub    $0x4,%esp
80105767:	51                   	push   %ecx
80105768:	52                   	push   %edx
80105769:	50                   	push   %eax
8010576a:	e8 e8 bd ff ff       	call   80101557 <filewrite>
8010576f:	83 c4 10             	add    $0x10,%esp
}
80105772:	c9                   	leave  
80105773:	c3                   	ret    

80105774 <sys_close>:

int
sys_close(void)
{
80105774:	55                   	push   %ebp
80105775:	89 e5                	mov    %esp,%ebp
80105777:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
8010577a:	83 ec 04             	sub    $0x4,%esp
8010577d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105780:	50                   	push   %eax
80105781:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105784:	50                   	push   %eax
80105785:	6a 00                	push   $0x0
80105787:	e8 fa fd ff ff       	call   80105586 <argfd>
8010578c:	83 c4 10             	add    $0x10,%esp
8010578f:	85 c0                	test   %eax,%eax
80105791:	79 07                	jns    8010579a <sys_close+0x26>
    return -1;
80105793:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105798:	eb 28                	jmp    801057c2 <sys_close+0x4e>
  proc->ofile[fd] = 0;
8010579a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801057a3:	83 c2 08             	add    $0x8,%edx
801057a6:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801057ad:	00 
  fileclose(f);
801057ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057b1:	83 ec 0c             	sub    $0xc,%esp
801057b4:	50                   	push   %eax
801057b5:	e8 a6 bb ff ff       	call   80101360 <fileclose>
801057ba:	83 c4 10             	add    $0x10,%esp
  return 0;
801057bd:	b8 00 00 00 00       	mov    $0x0,%eax
}
801057c2:	c9                   	leave  
801057c3:	c3                   	ret    

801057c4 <sys_fstat>:

int
sys_fstat(void)
{
801057c4:	55                   	push   %ebp
801057c5:	89 e5                	mov    %esp,%ebp
801057c7:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801057ca:	83 ec 04             	sub    $0x4,%esp
801057cd:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057d0:	50                   	push   %eax
801057d1:	6a 00                	push   $0x0
801057d3:	6a 00                	push   $0x0
801057d5:	e8 ac fd ff ff       	call   80105586 <argfd>
801057da:	83 c4 10             	add    $0x10,%esp
801057dd:	85 c0                	test   %eax,%eax
801057df:	78 17                	js     801057f8 <sys_fstat+0x34>
801057e1:	83 ec 04             	sub    $0x4,%esp
801057e4:	6a 14                	push   $0x14
801057e6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057e9:	50                   	push   %eax
801057ea:	6a 01                	push   $0x1
801057ec:	e8 80 fc ff ff       	call   80105471 <argptr>
801057f1:	83 c4 10             	add    $0x10,%esp
801057f4:	85 c0                	test   %eax,%eax
801057f6:	79 07                	jns    801057ff <sys_fstat+0x3b>
    return -1;
801057f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057fd:	eb 13                	jmp    80105812 <sys_fstat+0x4e>
  return filestat(f, st);
801057ff:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105802:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105805:	83 ec 08             	sub    $0x8,%esp
80105808:	52                   	push   %edx
80105809:	50                   	push   %eax
8010580a:	e8 39 bc ff ff       	call   80101448 <filestat>
8010580f:	83 c4 10             	add    $0x10,%esp
}
80105812:	c9                   	leave  
80105813:	c3                   	ret    

80105814 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105814:	55                   	push   %ebp
80105815:	89 e5                	mov    %esp,%ebp
80105817:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010581a:	83 ec 08             	sub    $0x8,%esp
8010581d:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105820:	50                   	push   %eax
80105821:	6a 00                	push   $0x0
80105823:	e8 a8 fc ff ff       	call   801054d0 <argstr>
80105828:	83 c4 10             	add    $0x10,%esp
8010582b:	85 c0                	test   %eax,%eax
8010582d:	78 15                	js     80105844 <sys_link+0x30>
8010582f:	83 ec 08             	sub    $0x8,%esp
80105832:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105835:	50                   	push   %eax
80105836:	6a 01                	push   $0x1
80105838:	e8 93 fc ff ff       	call   801054d0 <argstr>
8010583d:	83 c4 10             	add    $0x10,%esp
80105840:	85 c0                	test   %eax,%eax
80105842:	79 0a                	jns    8010584e <sys_link+0x3a>
    return -1;
80105844:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105849:	e9 64 01 00 00       	jmp    801059b2 <sys_link+0x19e>
  if((ip = namei(old)) == 0)
8010584e:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105851:	83 ec 0c             	sub    $0xc,%esp
80105854:	50                   	push   %eax
80105855:	e8 8b cf ff ff       	call   801027e5 <namei>
8010585a:	83 c4 10             	add    $0x10,%esp
8010585d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105860:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105864:	75 0a                	jne    80105870 <sys_link+0x5c>
    return -1;
80105866:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010586b:	e9 42 01 00 00       	jmp    801059b2 <sys_link+0x19e>

  begin_trans();
80105870:	e8 21 dd ff ff       	call   80103596 <begin_trans>

  ilock(ip);
80105875:	83 ec 0c             	sub    $0xc,%esp
80105878:	ff 75 f4             	pushl  -0xc(%ebp)
8010587b:	e8 a2 c3 ff ff       	call   80101c22 <ilock>
80105880:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
80105883:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105886:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010588a:	66 83 f8 01          	cmp    $0x1,%ax
8010588e:	75 1d                	jne    801058ad <sys_link+0x99>
    iunlockput(ip);
80105890:	83 ec 0c             	sub    $0xc,%esp
80105893:	ff 75 f4             	pushl  -0xc(%ebp)
80105896:	e8 3e c6 ff ff       	call   80101ed9 <iunlockput>
8010589b:	83 c4 10             	add    $0x10,%esp
    commit_trans();
8010589e:	e8 45 dd ff ff       	call   801035e8 <commit_trans>
    return -1;
801058a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058a8:	e9 05 01 00 00       	jmp    801059b2 <sys_link+0x19e>
  }

  ip->nlink++;
801058ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058b0:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801058b4:	83 c0 01             	add    $0x1,%eax
801058b7:	89 c2                	mov    %eax,%edx
801058b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058bc:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
801058c0:	83 ec 0c             	sub    $0xc,%esp
801058c3:	ff 75 f4             	pushl  -0xc(%ebp)
801058c6:	e8 84 c1 ff ff       	call   80101a4f <iupdate>
801058cb:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
801058ce:	83 ec 0c             	sub    $0xc,%esp
801058d1:	ff 75 f4             	pushl  -0xc(%ebp)
801058d4:	e8 a0 c4 ff ff       	call   80101d79 <iunlock>
801058d9:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
801058dc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801058df:	83 ec 08             	sub    $0x8,%esp
801058e2:	8d 55 e2             	lea    -0x1e(%ebp),%edx
801058e5:	52                   	push   %edx
801058e6:	50                   	push   %eax
801058e7:	e8 15 cf ff ff       	call   80102801 <nameiparent>
801058ec:	83 c4 10             	add    $0x10,%esp
801058ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
801058f2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801058f6:	75 02                	jne    801058fa <sys_link+0xe6>
    goto bad;
801058f8:	eb 71                	jmp    8010596b <sys_link+0x157>
  ilock(dp);
801058fa:	83 ec 0c             	sub    $0xc,%esp
801058fd:	ff 75 f0             	pushl  -0x10(%ebp)
80105900:	e8 1d c3 ff ff       	call   80101c22 <ilock>
80105905:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105908:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010590b:	8b 10                	mov    (%eax),%edx
8010590d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105910:	8b 00                	mov    (%eax),%eax
80105912:	39 c2                	cmp    %eax,%edx
80105914:	75 1d                	jne    80105933 <sys_link+0x11f>
80105916:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105919:	8b 40 04             	mov    0x4(%eax),%eax
8010591c:	83 ec 04             	sub    $0x4,%esp
8010591f:	50                   	push   %eax
80105920:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105923:	50                   	push   %eax
80105924:	ff 75 f0             	pushl  -0x10(%ebp)
80105927:	e8 21 cc ff ff       	call   8010254d <dirlink>
8010592c:	83 c4 10             	add    $0x10,%esp
8010592f:	85 c0                	test   %eax,%eax
80105931:	79 10                	jns    80105943 <sys_link+0x12f>
    iunlockput(dp);
80105933:	83 ec 0c             	sub    $0xc,%esp
80105936:	ff 75 f0             	pushl  -0x10(%ebp)
80105939:	e8 9b c5 ff ff       	call   80101ed9 <iunlockput>
8010593e:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105941:	eb 28                	jmp    8010596b <sys_link+0x157>
  }
  iunlockput(dp);
80105943:	83 ec 0c             	sub    $0xc,%esp
80105946:	ff 75 f0             	pushl  -0x10(%ebp)
80105949:	e8 8b c5 ff ff       	call   80101ed9 <iunlockput>
8010594e:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80105951:	83 ec 0c             	sub    $0xc,%esp
80105954:	ff 75 f4             	pushl  -0xc(%ebp)
80105957:	e8 8e c4 ff ff       	call   80101dea <iput>
8010595c:	83 c4 10             	add    $0x10,%esp

  commit_trans();
8010595f:	e8 84 dc ff ff       	call   801035e8 <commit_trans>

  return 0;
80105964:	b8 00 00 00 00       	mov    $0x0,%eax
80105969:	eb 47                	jmp    801059b2 <sys_link+0x19e>

bad:
  ilock(ip);
8010596b:	83 ec 0c             	sub    $0xc,%esp
8010596e:	ff 75 f4             	pushl  -0xc(%ebp)
80105971:	e8 ac c2 ff ff       	call   80101c22 <ilock>
80105976:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
80105979:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010597c:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105980:	83 e8 01             	sub    $0x1,%eax
80105983:	89 c2                	mov    %eax,%edx
80105985:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105988:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
8010598c:	83 ec 0c             	sub    $0xc,%esp
8010598f:	ff 75 f4             	pushl  -0xc(%ebp)
80105992:	e8 b8 c0 ff ff       	call   80101a4f <iupdate>
80105997:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
8010599a:	83 ec 0c             	sub    $0xc,%esp
8010599d:	ff 75 f4             	pushl  -0xc(%ebp)
801059a0:	e8 34 c5 ff ff       	call   80101ed9 <iunlockput>
801059a5:	83 c4 10             	add    $0x10,%esp
  commit_trans();
801059a8:	e8 3b dc ff ff       	call   801035e8 <commit_trans>
  return -1;
801059ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059b2:	c9                   	leave  
801059b3:	c3                   	ret    

801059b4 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
801059b4:	55                   	push   %ebp
801059b5:	89 e5                	mov    %esp,%ebp
801059b7:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801059ba:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
801059c1:	eb 40                	jmp    80105a03 <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801059c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059c6:	6a 10                	push   $0x10
801059c8:	50                   	push   %eax
801059c9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801059cc:	50                   	push   %eax
801059cd:	ff 75 08             	pushl  0x8(%ebp)
801059d0:	e8 af c7 ff ff       	call   80102184 <readi>
801059d5:	83 c4 10             	add    $0x10,%esp
801059d8:	83 f8 10             	cmp    $0x10,%eax
801059db:	74 0d                	je     801059ea <isdirempty+0x36>
      panic("isdirempty: readi");
801059dd:	83 ec 0c             	sub    $0xc,%esp
801059e0:	68 a8 89 10 80       	push   $0x801089a8
801059e5:	e8 72 ab ff ff       	call   8010055c <panic>
    if(de.inum != 0)
801059ea:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801059ee:	66 85 c0             	test   %ax,%ax
801059f1:	74 07                	je     801059fa <isdirempty+0x46>
      return 0;
801059f3:	b8 00 00 00 00       	mov    $0x0,%eax
801059f8:	eb 1b                	jmp    80105a15 <isdirempty+0x61>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801059fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059fd:	83 c0 10             	add    $0x10,%eax
80105a00:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105a03:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a06:	8b 45 08             	mov    0x8(%ebp),%eax
80105a09:	8b 40 18             	mov    0x18(%eax),%eax
80105a0c:	39 c2                	cmp    %eax,%edx
80105a0e:	72 b3                	jb     801059c3 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
80105a10:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105a15:	c9                   	leave  
80105a16:	c3                   	ret    

80105a17 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105a17:	55                   	push   %ebp
80105a18:	89 e5                	mov    %esp,%ebp
80105a1a:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105a1d:	83 ec 08             	sub    $0x8,%esp
80105a20:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105a23:	50                   	push   %eax
80105a24:	6a 00                	push   $0x0
80105a26:	e8 a5 fa ff ff       	call   801054d0 <argstr>
80105a2b:	83 c4 10             	add    $0x10,%esp
80105a2e:	85 c0                	test   %eax,%eax
80105a30:	79 0a                	jns    80105a3c <sys_unlink+0x25>
    return -1;
80105a32:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a37:	e9 b7 01 00 00       	jmp    80105bf3 <sys_unlink+0x1dc>
  if((dp = nameiparent(path, name)) == 0)
80105a3c:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105a3f:	83 ec 08             	sub    $0x8,%esp
80105a42:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105a45:	52                   	push   %edx
80105a46:	50                   	push   %eax
80105a47:	e8 b5 cd ff ff       	call   80102801 <nameiparent>
80105a4c:	83 c4 10             	add    $0x10,%esp
80105a4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105a52:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105a56:	75 0a                	jne    80105a62 <sys_unlink+0x4b>
    return -1;
80105a58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a5d:	e9 91 01 00 00       	jmp    80105bf3 <sys_unlink+0x1dc>

  begin_trans();
80105a62:	e8 2f db ff ff       	call   80103596 <begin_trans>

  ilock(dp);
80105a67:	83 ec 0c             	sub    $0xc,%esp
80105a6a:	ff 75 f4             	pushl  -0xc(%ebp)
80105a6d:	e8 b0 c1 ff ff       	call   80101c22 <ilock>
80105a72:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105a75:	83 ec 08             	sub    $0x8,%esp
80105a78:	68 ba 89 10 80       	push   $0x801089ba
80105a7d:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105a80:	50                   	push   %eax
80105a81:	e8 f1 c9 ff ff       	call   80102477 <namecmp>
80105a86:	83 c4 10             	add    $0x10,%esp
80105a89:	85 c0                	test   %eax,%eax
80105a8b:	0f 84 4a 01 00 00    	je     80105bdb <sys_unlink+0x1c4>
80105a91:	83 ec 08             	sub    $0x8,%esp
80105a94:	68 bc 89 10 80       	push   $0x801089bc
80105a99:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105a9c:	50                   	push   %eax
80105a9d:	e8 d5 c9 ff ff       	call   80102477 <namecmp>
80105aa2:	83 c4 10             	add    $0x10,%esp
80105aa5:	85 c0                	test   %eax,%eax
80105aa7:	0f 84 2e 01 00 00    	je     80105bdb <sys_unlink+0x1c4>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105aad:	83 ec 04             	sub    $0x4,%esp
80105ab0:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105ab3:	50                   	push   %eax
80105ab4:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105ab7:	50                   	push   %eax
80105ab8:	ff 75 f4             	pushl  -0xc(%ebp)
80105abb:	e8 d2 c9 ff ff       	call   80102492 <dirlookup>
80105ac0:	83 c4 10             	add    $0x10,%esp
80105ac3:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105ac6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105aca:	75 05                	jne    80105ad1 <sys_unlink+0xba>
    goto bad;
80105acc:	e9 0a 01 00 00       	jmp    80105bdb <sys_unlink+0x1c4>
  ilock(ip);
80105ad1:	83 ec 0c             	sub    $0xc,%esp
80105ad4:	ff 75 f0             	pushl  -0x10(%ebp)
80105ad7:	e8 46 c1 ff ff       	call   80101c22 <ilock>
80105adc:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105adf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ae2:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105ae6:	66 85 c0             	test   %ax,%ax
80105ae9:	7f 0d                	jg     80105af8 <sys_unlink+0xe1>
    panic("unlink: nlink < 1");
80105aeb:	83 ec 0c             	sub    $0xc,%esp
80105aee:	68 bf 89 10 80       	push   $0x801089bf
80105af3:	e8 64 aa ff ff       	call   8010055c <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105af8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105afb:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105aff:	66 83 f8 01          	cmp    $0x1,%ax
80105b03:	75 25                	jne    80105b2a <sys_unlink+0x113>
80105b05:	83 ec 0c             	sub    $0xc,%esp
80105b08:	ff 75 f0             	pushl  -0x10(%ebp)
80105b0b:	e8 a4 fe ff ff       	call   801059b4 <isdirempty>
80105b10:	83 c4 10             	add    $0x10,%esp
80105b13:	85 c0                	test   %eax,%eax
80105b15:	75 13                	jne    80105b2a <sys_unlink+0x113>
    iunlockput(ip);
80105b17:	83 ec 0c             	sub    $0xc,%esp
80105b1a:	ff 75 f0             	pushl  -0x10(%ebp)
80105b1d:	e8 b7 c3 ff ff       	call   80101ed9 <iunlockput>
80105b22:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105b25:	e9 b1 00 00 00       	jmp    80105bdb <sys_unlink+0x1c4>
  }

  memset(&de, 0, sizeof(de));
80105b2a:	83 ec 04             	sub    $0x4,%esp
80105b2d:	6a 10                	push   $0x10
80105b2f:	6a 00                	push   $0x0
80105b31:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105b34:	50                   	push   %eax
80105b35:	e8 e8 f5 ff ff       	call   80105122 <memset>
80105b3a:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105b3d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105b40:	6a 10                	push   $0x10
80105b42:	50                   	push   %eax
80105b43:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105b46:	50                   	push   %eax
80105b47:	ff 75 f4             	pushl  -0xc(%ebp)
80105b4a:	e8 96 c7 ff ff       	call   801022e5 <writei>
80105b4f:	83 c4 10             	add    $0x10,%esp
80105b52:	83 f8 10             	cmp    $0x10,%eax
80105b55:	74 0d                	je     80105b64 <sys_unlink+0x14d>
    panic("unlink: writei");
80105b57:	83 ec 0c             	sub    $0xc,%esp
80105b5a:	68 d1 89 10 80       	push   $0x801089d1
80105b5f:	e8 f8 a9 ff ff       	call   8010055c <panic>
  if(ip->type == T_DIR){
80105b64:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b67:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105b6b:	66 83 f8 01          	cmp    $0x1,%ax
80105b6f:	75 21                	jne    80105b92 <sys_unlink+0x17b>
    dp->nlink--;
80105b71:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b74:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105b78:	83 e8 01             	sub    $0x1,%eax
80105b7b:	89 c2                	mov    %eax,%edx
80105b7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b80:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105b84:	83 ec 0c             	sub    $0xc,%esp
80105b87:	ff 75 f4             	pushl  -0xc(%ebp)
80105b8a:	e8 c0 be ff ff       	call   80101a4f <iupdate>
80105b8f:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80105b92:	83 ec 0c             	sub    $0xc,%esp
80105b95:	ff 75 f4             	pushl  -0xc(%ebp)
80105b98:	e8 3c c3 ff ff       	call   80101ed9 <iunlockput>
80105b9d:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80105ba0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ba3:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105ba7:	83 e8 01             	sub    $0x1,%eax
80105baa:	89 c2                	mov    %eax,%edx
80105bac:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105baf:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105bb3:	83 ec 0c             	sub    $0xc,%esp
80105bb6:	ff 75 f0             	pushl  -0x10(%ebp)
80105bb9:	e8 91 be ff ff       	call   80101a4f <iupdate>
80105bbe:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105bc1:	83 ec 0c             	sub    $0xc,%esp
80105bc4:	ff 75 f0             	pushl  -0x10(%ebp)
80105bc7:	e8 0d c3 ff ff       	call   80101ed9 <iunlockput>
80105bcc:	83 c4 10             	add    $0x10,%esp

  commit_trans();
80105bcf:	e8 14 da ff ff       	call   801035e8 <commit_trans>

  return 0;
80105bd4:	b8 00 00 00 00       	mov    $0x0,%eax
80105bd9:	eb 18                	jmp    80105bf3 <sys_unlink+0x1dc>

bad:
  iunlockput(dp);
80105bdb:	83 ec 0c             	sub    $0xc,%esp
80105bde:	ff 75 f4             	pushl  -0xc(%ebp)
80105be1:	e8 f3 c2 ff ff       	call   80101ed9 <iunlockput>
80105be6:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105be9:	e8 fa d9 ff ff       	call   801035e8 <commit_trans>
  return -1;
80105bee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bf3:	c9                   	leave  
80105bf4:	c3                   	ret    

80105bf5 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105bf5:	55                   	push   %ebp
80105bf6:	89 e5                	mov    %esp,%ebp
80105bf8:	83 ec 38             	sub    $0x38,%esp
80105bfb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105bfe:	8b 55 10             	mov    0x10(%ebp),%edx
80105c01:	8b 45 14             	mov    0x14(%ebp),%eax
80105c04:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105c08:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105c0c:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105c10:	83 ec 08             	sub    $0x8,%esp
80105c13:	8d 45 de             	lea    -0x22(%ebp),%eax
80105c16:	50                   	push   %eax
80105c17:	ff 75 08             	pushl  0x8(%ebp)
80105c1a:	e8 e2 cb ff ff       	call   80102801 <nameiparent>
80105c1f:	83 c4 10             	add    $0x10,%esp
80105c22:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c25:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105c29:	75 0a                	jne    80105c35 <create+0x40>
    return 0;
80105c2b:	b8 00 00 00 00       	mov    $0x0,%eax
80105c30:	e9 90 01 00 00       	jmp    80105dc5 <create+0x1d0>
  ilock(dp);
80105c35:	83 ec 0c             	sub    $0xc,%esp
80105c38:	ff 75 f4             	pushl  -0xc(%ebp)
80105c3b:	e8 e2 bf ff ff       	call   80101c22 <ilock>
80105c40:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
80105c43:	83 ec 04             	sub    $0x4,%esp
80105c46:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105c49:	50                   	push   %eax
80105c4a:	8d 45 de             	lea    -0x22(%ebp),%eax
80105c4d:	50                   	push   %eax
80105c4e:	ff 75 f4             	pushl  -0xc(%ebp)
80105c51:	e8 3c c8 ff ff       	call   80102492 <dirlookup>
80105c56:	83 c4 10             	add    $0x10,%esp
80105c59:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105c5c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105c60:	74 50                	je     80105cb2 <create+0xbd>
    iunlockput(dp);
80105c62:	83 ec 0c             	sub    $0xc,%esp
80105c65:	ff 75 f4             	pushl  -0xc(%ebp)
80105c68:	e8 6c c2 ff ff       	call   80101ed9 <iunlockput>
80105c6d:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80105c70:	83 ec 0c             	sub    $0xc,%esp
80105c73:	ff 75 f0             	pushl  -0x10(%ebp)
80105c76:	e8 a7 bf ff ff       	call   80101c22 <ilock>
80105c7b:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80105c7e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105c83:	75 15                	jne    80105c9a <create+0xa5>
80105c85:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c88:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105c8c:	66 83 f8 02          	cmp    $0x2,%ax
80105c90:	75 08                	jne    80105c9a <create+0xa5>
      return ip;
80105c92:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c95:	e9 2b 01 00 00       	jmp    80105dc5 <create+0x1d0>
    iunlockput(ip);
80105c9a:	83 ec 0c             	sub    $0xc,%esp
80105c9d:	ff 75 f0             	pushl  -0x10(%ebp)
80105ca0:	e8 34 c2 ff ff       	call   80101ed9 <iunlockput>
80105ca5:	83 c4 10             	add    $0x10,%esp
    return 0;
80105ca8:	b8 00 00 00 00       	mov    $0x0,%eax
80105cad:	e9 13 01 00 00       	jmp    80105dc5 <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105cb2:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105cb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cb9:	8b 00                	mov    (%eax),%eax
80105cbb:	83 ec 08             	sub    $0x8,%esp
80105cbe:	52                   	push   %edx
80105cbf:	50                   	push   %eax
80105cc0:	e8 a9 bc ff ff       	call   8010196e <ialloc>
80105cc5:	83 c4 10             	add    $0x10,%esp
80105cc8:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105ccb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105ccf:	75 0d                	jne    80105cde <create+0xe9>
    panic("create: ialloc");
80105cd1:	83 ec 0c             	sub    $0xc,%esp
80105cd4:	68 e0 89 10 80       	push   $0x801089e0
80105cd9:	e8 7e a8 ff ff       	call   8010055c <panic>

  ilock(ip);
80105cde:	83 ec 0c             	sub    $0xc,%esp
80105ce1:	ff 75 f0             	pushl  -0x10(%ebp)
80105ce4:	e8 39 bf ff ff       	call   80101c22 <ilock>
80105ce9:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80105cec:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cef:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105cf3:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80105cf7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cfa:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105cfe:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80105d02:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d05:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105d0b:	83 ec 0c             	sub    $0xc,%esp
80105d0e:	ff 75 f0             	pushl  -0x10(%ebp)
80105d11:	e8 39 bd ff ff       	call   80101a4f <iupdate>
80105d16:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
80105d19:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105d1e:	75 6a                	jne    80105d8a <create+0x195>
    dp->nlink++;  // for ".."
80105d20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d23:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105d27:	83 c0 01             	add    $0x1,%eax
80105d2a:	89 c2                	mov    %eax,%edx
80105d2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d2f:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105d33:	83 ec 0c             	sub    $0xc,%esp
80105d36:	ff 75 f4             	pushl  -0xc(%ebp)
80105d39:	e8 11 bd ff ff       	call   80101a4f <iupdate>
80105d3e:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105d41:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d44:	8b 40 04             	mov    0x4(%eax),%eax
80105d47:	83 ec 04             	sub    $0x4,%esp
80105d4a:	50                   	push   %eax
80105d4b:	68 ba 89 10 80       	push   $0x801089ba
80105d50:	ff 75 f0             	pushl  -0x10(%ebp)
80105d53:	e8 f5 c7 ff ff       	call   8010254d <dirlink>
80105d58:	83 c4 10             	add    $0x10,%esp
80105d5b:	85 c0                	test   %eax,%eax
80105d5d:	78 1e                	js     80105d7d <create+0x188>
80105d5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d62:	8b 40 04             	mov    0x4(%eax),%eax
80105d65:	83 ec 04             	sub    $0x4,%esp
80105d68:	50                   	push   %eax
80105d69:	68 bc 89 10 80       	push   $0x801089bc
80105d6e:	ff 75 f0             	pushl  -0x10(%ebp)
80105d71:	e8 d7 c7 ff ff       	call   8010254d <dirlink>
80105d76:	83 c4 10             	add    $0x10,%esp
80105d79:	85 c0                	test   %eax,%eax
80105d7b:	79 0d                	jns    80105d8a <create+0x195>
      panic("create dots");
80105d7d:	83 ec 0c             	sub    $0xc,%esp
80105d80:	68 ef 89 10 80       	push   $0x801089ef
80105d85:	e8 d2 a7 ff ff       	call   8010055c <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105d8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d8d:	8b 40 04             	mov    0x4(%eax),%eax
80105d90:	83 ec 04             	sub    $0x4,%esp
80105d93:	50                   	push   %eax
80105d94:	8d 45 de             	lea    -0x22(%ebp),%eax
80105d97:	50                   	push   %eax
80105d98:	ff 75 f4             	pushl  -0xc(%ebp)
80105d9b:	e8 ad c7 ff ff       	call   8010254d <dirlink>
80105da0:	83 c4 10             	add    $0x10,%esp
80105da3:	85 c0                	test   %eax,%eax
80105da5:	79 0d                	jns    80105db4 <create+0x1bf>
    panic("create: dirlink");
80105da7:	83 ec 0c             	sub    $0xc,%esp
80105daa:	68 fb 89 10 80       	push   $0x801089fb
80105daf:	e8 a8 a7 ff ff       	call   8010055c <panic>

  iunlockput(dp);
80105db4:	83 ec 0c             	sub    $0xc,%esp
80105db7:	ff 75 f4             	pushl  -0xc(%ebp)
80105dba:	e8 1a c1 ff ff       	call   80101ed9 <iunlockput>
80105dbf:	83 c4 10             	add    $0x10,%esp

  return ip;
80105dc2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105dc5:	c9                   	leave  
80105dc6:	c3                   	ret    

80105dc7 <sys_open>:

int
sys_open(void)
{
80105dc7:	55                   	push   %ebp
80105dc8:	89 e5                	mov    %esp,%ebp
80105dca:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105dcd:	83 ec 08             	sub    $0x8,%esp
80105dd0:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105dd3:	50                   	push   %eax
80105dd4:	6a 00                	push   $0x0
80105dd6:	e8 f5 f6 ff ff       	call   801054d0 <argstr>
80105ddb:	83 c4 10             	add    $0x10,%esp
80105dde:	85 c0                	test   %eax,%eax
80105de0:	78 15                	js     80105df7 <sys_open+0x30>
80105de2:	83 ec 08             	sub    $0x8,%esp
80105de5:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105de8:	50                   	push   %eax
80105de9:	6a 01                	push   $0x1
80105deb:	e8 59 f6 ff ff       	call   80105449 <argint>
80105df0:	83 c4 10             	add    $0x10,%esp
80105df3:	85 c0                	test   %eax,%eax
80105df5:	79 0a                	jns    80105e01 <sys_open+0x3a>
    return -1;
80105df7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dfc:	e9 4d 01 00 00       	jmp    80105f4e <sys_open+0x187>
  if(omode & O_CREATE){
80105e01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105e04:	25 00 02 00 00       	and    $0x200,%eax
80105e09:	85 c0                	test   %eax,%eax
80105e0b:	74 2f                	je     80105e3c <sys_open+0x75>
    begin_trans();
80105e0d:	e8 84 d7 ff ff       	call   80103596 <begin_trans>
    ip = create(path, T_FILE, 0, 0);
80105e12:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105e15:	6a 00                	push   $0x0
80105e17:	6a 00                	push   $0x0
80105e19:	6a 02                	push   $0x2
80105e1b:	50                   	push   %eax
80105e1c:	e8 d4 fd ff ff       	call   80105bf5 <create>
80105e21:	83 c4 10             	add    $0x10,%esp
80105e24:	89 45 f4             	mov    %eax,-0xc(%ebp)
    commit_trans();
80105e27:	e8 bc d7 ff ff       	call   801035e8 <commit_trans>
    if(ip == 0)
80105e2c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105e30:	75 66                	jne    80105e98 <sys_open+0xd1>
      return -1;
80105e32:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e37:	e9 12 01 00 00       	jmp    80105f4e <sys_open+0x187>
  } else {
    if((ip = namei(path)) == 0)
80105e3c:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105e3f:	83 ec 0c             	sub    $0xc,%esp
80105e42:	50                   	push   %eax
80105e43:	e8 9d c9 ff ff       	call   801027e5 <namei>
80105e48:	83 c4 10             	add    $0x10,%esp
80105e4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105e4e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105e52:	75 0a                	jne    80105e5e <sys_open+0x97>
      return -1;
80105e54:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e59:	e9 f0 00 00 00       	jmp    80105f4e <sys_open+0x187>
    ilock(ip);
80105e5e:	83 ec 0c             	sub    $0xc,%esp
80105e61:	ff 75 f4             	pushl  -0xc(%ebp)
80105e64:	e8 b9 bd ff ff       	call   80101c22 <ilock>
80105e69:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e6f:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105e73:	66 83 f8 01          	cmp    $0x1,%ax
80105e77:	75 1f                	jne    80105e98 <sys_open+0xd1>
80105e79:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105e7c:	85 c0                	test   %eax,%eax
80105e7e:	74 18                	je     80105e98 <sys_open+0xd1>
      iunlockput(ip);
80105e80:	83 ec 0c             	sub    $0xc,%esp
80105e83:	ff 75 f4             	pushl  -0xc(%ebp)
80105e86:	e8 4e c0 ff ff       	call   80101ed9 <iunlockput>
80105e8b:	83 c4 10             	add    $0x10,%esp
      return -1;
80105e8e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e93:	e9 b6 00 00 00       	jmp    80105f4e <sys_open+0x187>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105e98:	e8 06 b4 ff ff       	call   801012a3 <filealloc>
80105e9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105ea0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105ea4:	74 17                	je     80105ebd <sys_open+0xf6>
80105ea6:	83 ec 0c             	sub    $0xc,%esp
80105ea9:	ff 75 f0             	pushl  -0x10(%ebp)
80105eac:	e8 4a f7 ff ff       	call   801055fb <fdalloc>
80105eb1:	83 c4 10             	add    $0x10,%esp
80105eb4:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105eb7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105ebb:	79 29                	jns    80105ee6 <sys_open+0x11f>
    if(f)
80105ebd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105ec1:	74 0e                	je     80105ed1 <sys_open+0x10a>
      fileclose(f);
80105ec3:	83 ec 0c             	sub    $0xc,%esp
80105ec6:	ff 75 f0             	pushl  -0x10(%ebp)
80105ec9:	e8 92 b4 ff ff       	call   80101360 <fileclose>
80105ece:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105ed1:	83 ec 0c             	sub    $0xc,%esp
80105ed4:	ff 75 f4             	pushl  -0xc(%ebp)
80105ed7:	e8 fd bf ff ff       	call   80101ed9 <iunlockput>
80105edc:	83 c4 10             	add    $0x10,%esp
    return -1;
80105edf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ee4:	eb 68                	jmp    80105f4e <sys_open+0x187>
  }
  iunlock(ip);
80105ee6:	83 ec 0c             	sub    $0xc,%esp
80105ee9:	ff 75 f4             	pushl  -0xc(%ebp)
80105eec:	e8 88 be ff ff       	call   80101d79 <iunlock>
80105ef1:	83 c4 10             	add    $0x10,%esp

  f->type = FD_INODE;
80105ef4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ef7:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80105efd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f00:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105f03:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80105f06:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f09:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80105f10:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f13:	83 e0 01             	and    $0x1,%eax
80105f16:	85 c0                	test   %eax,%eax
80105f18:	0f 94 c0             	sete   %al
80105f1b:	89 c2                	mov    %eax,%edx
80105f1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f20:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105f23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f26:	83 e0 01             	and    $0x1,%eax
80105f29:	85 c0                	test   %eax,%eax
80105f2b:	75 0a                	jne    80105f37 <sys_open+0x170>
80105f2d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f30:	83 e0 02             	and    $0x2,%eax
80105f33:	85 c0                	test   %eax,%eax
80105f35:	74 07                	je     80105f3e <sys_open+0x177>
80105f37:	b8 01 00 00 00       	mov    $0x1,%eax
80105f3c:	eb 05                	jmp    80105f43 <sys_open+0x17c>
80105f3e:	b8 00 00 00 00       	mov    $0x0,%eax
80105f43:	89 c2                	mov    %eax,%edx
80105f45:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f48:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80105f4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80105f4e:	c9                   	leave  
80105f4f:	c3                   	ret    

80105f50 <sys_mkdir>:

int
sys_mkdir(void)
{
80105f50:	55                   	push   %ebp
80105f51:	89 e5                	mov    %esp,%ebp
80105f53:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_trans();
80105f56:	e8 3b d6 ff ff       	call   80103596 <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105f5b:	83 ec 08             	sub    $0x8,%esp
80105f5e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f61:	50                   	push   %eax
80105f62:	6a 00                	push   $0x0
80105f64:	e8 67 f5 ff ff       	call   801054d0 <argstr>
80105f69:	83 c4 10             	add    $0x10,%esp
80105f6c:	85 c0                	test   %eax,%eax
80105f6e:	78 1b                	js     80105f8b <sys_mkdir+0x3b>
80105f70:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f73:	6a 00                	push   $0x0
80105f75:	6a 00                	push   $0x0
80105f77:	6a 01                	push   $0x1
80105f79:	50                   	push   %eax
80105f7a:	e8 76 fc ff ff       	call   80105bf5 <create>
80105f7f:	83 c4 10             	add    $0x10,%esp
80105f82:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f85:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f89:	75 0c                	jne    80105f97 <sys_mkdir+0x47>
    commit_trans();
80105f8b:	e8 58 d6 ff ff       	call   801035e8 <commit_trans>
    return -1;
80105f90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f95:	eb 18                	jmp    80105faf <sys_mkdir+0x5f>
  }
  iunlockput(ip);
80105f97:	83 ec 0c             	sub    $0xc,%esp
80105f9a:	ff 75 f4             	pushl  -0xc(%ebp)
80105f9d:	e8 37 bf ff ff       	call   80101ed9 <iunlockput>
80105fa2:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105fa5:	e8 3e d6 ff ff       	call   801035e8 <commit_trans>
  return 0;
80105faa:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105faf:	c9                   	leave  
80105fb0:	c3                   	ret    

80105fb1 <sys_mknod>:

int
sys_mknod(void)
{
80105fb1:	55                   	push   %ebp
80105fb2:	89 e5                	mov    %esp,%ebp
80105fb4:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
80105fb7:	e8 da d5 ff ff       	call   80103596 <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
80105fbc:	83 ec 08             	sub    $0x8,%esp
80105fbf:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105fc2:	50                   	push   %eax
80105fc3:	6a 00                	push   $0x0
80105fc5:	e8 06 f5 ff ff       	call   801054d0 <argstr>
80105fca:	83 c4 10             	add    $0x10,%esp
80105fcd:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105fd0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105fd4:	78 4f                	js     80106025 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
80105fd6:	83 ec 08             	sub    $0x8,%esp
80105fd9:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105fdc:	50                   	push   %eax
80105fdd:	6a 01                	push   $0x1
80105fdf:	e8 65 f4 ff ff       	call   80105449 <argint>
80105fe4:	83 c4 10             	add    $0x10,%esp
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
80105fe7:	85 c0                	test   %eax,%eax
80105fe9:	78 3a                	js     80106025 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105feb:	83 ec 08             	sub    $0x8,%esp
80105fee:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105ff1:	50                   	push   %eax
80105ff2:	6a 02                	push   $0x2
80105ff4:	e8 50 f4 ff ff       	call   80105449 <argint>
80105ff9:	83 c4 10             	add    $0x10,%esp
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105ffc:	85 c0                	test   %eax,%eax
80105ffe:	78 25                	js     80106025 <sys_mknod+0x74>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80106000:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106003:	0f bf c8             	movswl %ax,%ecx
80106006:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106009:	0f bf d0             	movswl %ax,%edx
8010600c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
8010600f:	51                   	push   %ecx
80106010:	52                   	push   %edx
80106011:	6a 03                	push   $0x3
80106013:	50                   	push   %eax
80106014:	e8 dc fb ff ff       	call   80105bf5 <create>
80106019:	83 c4 10             	add    $0x10,%esp
8010601c:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010601f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106023:	75 0c                	jne    80106031 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    commit_trans();
80106025:	e8 be d5 ff ff       	call   801035e8 <commit_trans>
    return -1;
8010602a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010602f:	eb 18                	jmp    80106049 <sys_mknod+0x98>
  }
  iunlockput(ip);
80106031:	83 ec 0c             	sub    $0xc,%esp
80106034:	ff 75 f0             	pushl  -0x10(%ebp)
80106037:	e8 9d be ff ff       	call   80101ed9 <iunlockput>
8010603c:	83 c4 10             	add    $0x10,%esp
  commit_trans();
8010603f:	e8 a4 d5 ff ff       	call   801035e8 <commit_trans>
  return 0;
80106044:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106049:	c9                   	leave  
8010604a:	c3                   	ret    

8010604b <sys_chdir>:

int
sys_chdir(void)
{
8010604b:	55                   	push   %ebp
8010604c:	89 e5                	mov    %esp,%ebp
8010604e:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80106051:	83 ec 08             	sub    $0x8,%esp
80106054:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106057:	50                   	push   %eax
80106058:	6a 00                	push   $0x0
8010605a:	e8 71 f4 ff ff       	call   801054d0 <argstr>
8010605f:	83 c4 10             	add    $0x10,%esp
80106062:	85 c0                	test   %eax,%eax
80106064:	78 18                	js     8010607e <sys_chdir+0x33>
80106066:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106069:	83 ec 0c             	sub    $0xc,%esp
8010606c:	50                   	push   %eax
8010606d:	e8 73 c7 ff ff       	call   801027e5 <namei>
80106072:	83 c4 10             	add    $0x10,%esp
80106075:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106078:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010607c:	75 07                	jne    80106085 <sys_chdir+0x3a>
    return -1;
8010607e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106083:	eb 64                	jmp    801060e9 <sys_chdir+0x9e>
  ilock(ip);
80106085:	83 ec 0c             	sub    $0xc,%esp
80106088:	ff 75 f4             	pushl  -0xc(%ebp)
8010608b:	e8 92 bb ff ff       	call   80101c22 <ilock>
80106090:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
80106093:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106096:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010609a:	66 83 f8 01          	cmp    $0x1,%ax
8010609e:	74 15                	je     801060b5 <sys_chdir+0x6a>
    iunlockput(ip);
801060a0:	83 ec 0c             	sub    $0xc,%esp
801060a3:	ff 75 f4             	pushl  -0xc(%ebp)
801060a6:	e8 2e be ff ff       	call   80101ed9 <iunlockput>
801060ab:	83 c4 10             	add    $0x10,%esp
    return -1;
801060ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060b3:	eb 34                	jmp    801060e9 <sys_chdir+0x9e>
  }
  iunlock(ip);
801060b5:	83 ec 0c             	sub    $0xc,%esp
801060b8:	ff 75 f4             	pushl  -0xc(%ebp)
801060bb:	e8 b9 bc ff ff       	call   80101d79 <iunlock>
801060c0:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
801060c3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801060c9:	8b 40 68             	mov    0x68(%eax),%eax
801060cc:	83 ec 0c             	sub    $0xc,%esp
801060cf:	50                   	push   %eax
801060d0:	e8 15 bd ff ff       	call   80101dea <iput>
801060d5:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
801060d8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801060de:	8b 55 f4             	mov    -0xc(%ebp),%edx
801060e1:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
801060e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801060e9:	c9                   	leave  
801060ea:	c3                   	ret    

801060eb <sys_exec>:

int
sys_exec(void)
{
801060eb:	55                   	push   %ebp
801060ec:	89 e5                	mov    %esp,%ebp
801060ee:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801060f4:	83 ec 08             	sub    $0x8,%esp
801060f7:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060fa:	50                   	push   %eax
801060fb:	6a 00                	push   $0x0
801060fd:	e8 ce f3 ff ff       	call   801054d0 <argstr>
80106102:	83 c4 10             	add    $0x10,%esp
80106105:	85 c0                	test   %eax,%eax
80106107:	78 18                	js     80106121 <sys_exec+0x36>
80106109:	83 ec 08             	sub    $0x8,%esp
8010610c:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80106112:	50                   	push   %eax
80106113:	6a 01                	push   $0x1
80106115:	e8 2f f3 ff ff       	call   80105449 <argint>
8010611a:	83 c4 10             	add    $0x10,%esp
8010611d:	85 c0                	test   %eax,%eax
8010611f:	79 0a                	jns    8010612b <sys_exec+0x40>
    return -1;
80106121:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106126:	e9 c6 00 00 00       	jmp    801061f1 <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
8010612b:	83 ec 04             	sub    $0x4,%esp
8010612e:	68 80 00 00 00       	push   $0x80
80106133:	6a 00                	push   $0x0
80106135:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010613b:	50                   	push   %eax
8010613c:	e8 e1 ef ff ff       	call   80105122 <memset>
80106141:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
80106144:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
8010614b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010614e:	83 f8 1f             	cmp    $0x1f,%eax
80106151:	76 0a                	jbe    8010615d <sys_exec+0x72>
      return -1;
80106153:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106158:	e9 94 00 00 00       	jmp    801061f1 <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010615d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106160:	c1 e0 02             	shl    $0x2,%eax
80106163:	89 c2                	mov    %eax,%edx
80106165:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
8010616b:	01 c2                	add    %eax,%edx
8010616d:	83 ec 08             	sub    $0x8,%esp
80106170:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106176:	50                   	push   %eax
80106177:	52                   	push   %edx
80106178:	e8 30 f2 ff ff       	call   801053ad <fetchint>
8010617d:	83 c4 10             	add    $0x10,%esp
80106180:	85 c0                	test   %eax,%eax
80106182:	79 07                	jns    8010618b <sys_exec+0xa0>
      return -1;
80106184:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106189:	eb 66                	jmp    801061f1 <sys_exec+0x106>
    if(uarg == 0){
8010618b:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106191:	85 c0                	test   %eax,%eax
80106193:	75 27                	jne    801061bc <sys_exec+0xd1>
      argv[i] = 0;
80106195:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106198:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
8010619f:	00 00 00 00 
      break;
801061a3:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801061a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061a7:	83 ec 08             	sub    $0x8,%esp
801061aa:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
801061b0:	52                   	push   %edx
801061b1:	50                   	push   %eax
801061b2:	e8 f4 ac ff ff       	call   80100eab <exec>
801061b7:	83 c4 10             	add    $0x10,%esp
801061ba:	eb 35                	jmp    801061f1 <sys_exec+0x106>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801061bc:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801061c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801061c5:	c1 e2 02             	shl    $0x2,%edx
801061c8:	01 c2                	add    %eax,%edx
801061ca:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
801061d0:	83 ec 08             	sub    $0x8,%esp
801061d3:	52                   	push   %edx
801061d4:	50                   	push   %eax
801061d5:	e8 0d f2 ff ff       	call   801053e7 <fetchstr>
801061da:	83 c4 10             	add    $0x10,%esp
801061dd:	85 c0                	test   %eax,%eax
801061df:	79 07                	jns    801061e8 <sys_exec+0xfd>
      return -1;
801061e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061e6:	eb 09                	jmp    801061f1 <sys_exec+0x106>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
801061e8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
801061ec:	e9 5a ff ff ff       	jmp    8010614b <sys_exec+0x60>
  return exec(path, argv);
}
801061f1:	c9                   	leave  
801061f2:	c3                   	ret    

801061f3 <sys_pipe>:

int
sys_pipe(void)
{
801061f3:	55                   	push   %ebp
801061f4:	89 e5                	mov    %esp,%ebp
801061f6:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801061f9:	83 ec 04             	sub    $0x4,%esp
801061fc:	6a 08                	push   $0x8
801061fe:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106201:	50                   	push   %eax
80106202:	6a 00                	push   $0x0
80106204:	e8 68 f2 ff ff       	call   80105471 <argptr>
80106209:	83 c4 10             	add    $0x10,%esp
8010620c:	85 c0                	test   %eax,%eax
8010620e:	79 0a                	jns    8010621a <sys_pipe+0x27>
    return -1;
80106210:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106215:	e9 af 00 00 00       	jmp    801062c9 <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
8010621a:	83 ec 08             	sub    $0x8,%esp
8010621d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106220:	50                   	push   %eax
80106221:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106224:	50                   	push   %eax
80106225:	e8 18 dd ff ff       	call   80103f42 <pipealloc>
8010622a:	83 c4 10             	add    $0x10,%esp
8010622d:	85 c0                	test   %eax,%eax
8010622f:	79 0a                	jns    8010623b <sys_pipe+0x48>
    return -1;
80106231:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106236:	e9 8e 00 00 00       	jmp    801062c9 <sys_pipe+0xd6>
  fd0 = -1;
8010623b:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106242:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106245:	83 ec 0c             	sub    $0xc,%esp
80106248:	50                   	push   %eax
80106249:	e8 ad f3 ff ff       	call   801055fb <fdalloc>
8010624e:	83 c4 10             	add    $0x10,%esp
80106251:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106254:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106258:	78 18                	js     80106272 <sys_pipe+0x7f>
8010625a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010625d:	83 ec 0c             	sub    $0xc,%esp
80106260:	50                   	push   %eax
80106261:	e8 95 f3 ff ff       	call   801055fb <fdalloc>
80106266:	83 c4 10             	add    $0x10,%esp
80106269:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010626c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106270:	79 3f                	jns    801062b1 <sys_pipe+0xbe>
    if(fd0 >= 0)
80106272:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106276:	78 14                	js     8010628c <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
80106278:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010627e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106281:	83 c2 08             	add    $0x8,%edx
80106284:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010628b:	00 
    fileclose(rf);
8010628c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010628f:	83 ec 0c             	sub    $0xc,%esp
80106292:	50                   	push   %eax
80106293:	e8 c8 b0 ff ff       	call   80101360 <fileclose>
80106298:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
8010629b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010629e:	83 ec 0c             	sub    $0xc,%esp
801062a1:	50                   	push   %eax
801062a2:	e8 b9 b0 ff ff       	call   80101360 <fileclose>
801062a7:	83 c4 10             	add    $0x10,%esp
    return -1;
801062aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062af:	eb 18                	jmp    801062c9 <sys_pipe+0xd6>
  }
  fd[0] = fd0;
801062b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801062b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801062b7:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
801062b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801062bc:	8d 50 04             	lea    0x4(%eax),%edx
801062bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062c2:	89 02                	mov    %eax,(%edx)
  return 0;
801062c4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801062c9:	c9                   	leave  
801062ca:	c3                   	ret    

801062cb <iNodeName>:

int iNodeName(struct inode *ip, struct inode *parent, char buf[DIRSIZ])
{
801062cb:	55                   	push   %ebp
801062cc:	89 e5                	mov    %esp,%ebp
801062ce:	83 ec 28             	sub    $0x28,%esp
	uint off; //uint needs to be used instead of int?
	struct dirent de; //dirent  = inode directory with name
for(off = 0; off < parent->size; off += sizeof(de))
801062d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801062d8:	eb 59                	jmp    80106333 <iNodeName+0x68>
{
	if(readi(parent, (char*)&de, off, sizeof(de)) != sizeof(de))
801062da:	6a 10                	push   $0x10
801062dc:	ff 75 f4             	pushl  -0xc(%ebp)
801062df:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801062e2:	50                   	push   %eax
801062e3:	ff 75 0c             	pushl  0xc(%ebp)
801062e6:	e8 99 be ff ff       	call   80102184 <readi>
801062eb:	83 c4 10             	add    $0x10,%esp
801062ee:	83 f8 10             	cmp    $0x10,%eax
801062f1:	74 0d                	je     80106300 <iNodeName+0x35>
	panic("couldnt read directory entry");
801062f3:	83 ec 0c             	sub    $0xc,%esp
801062f6:	68 0b 8a 10 80       	push   $0x80108a0b
801062fb:	e8 5c a2 ff ff       	call   8010055c <panic>
	if(de.inum == ip->inum)
80106300:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80106304:	0f b7 d0             	movzwl %ax,%edx
80106307:	8b 45 08             	mov    0x8(%ebp),%eax
8010630a:	8b 40 04             	mov    0x4(%eax),%eax
8010630d:	39 c2                	cmp    %eax,%edx
8010630f:	75 1e                	jne    8010632f <iNodeName+0x64>
	{
	safestrcpy(buf, de.name, DIRSIZ);
80106311:	83 ec 04             	sub    $0x4,%esp
80106314:	6a 0e                	push   $0xe
80106316:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106319:	83 c0 02             	add    $0x2,%eax
8010631c:	50                   	push   %eax
8010631d:	ff 75 10             	pushl  0x10(%ebp)
80106320:	e8 02 f0 ff ff       	call   80105327 <safestrcpy>
80106325:	83 c4 10             	add    $0x10,%esp
	return 0;
80106328:	b8 00 00 00 00       	mov    $0x0,%eax
8010632d:	eb 14                	jmp    80106343 <iNodeName+0x78>

int iNodeName(struct inode *ip, struct inode *parent, char buf[DIRSIZ])
{
	uint off; //uint needs to be used instead of int?
	struct dirent de; //dirent  = inode directory with name
for(off = 0; off < parent->size; off += sizeof(de))
8010632f:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80106333:	8b 45 0c             	mov    0xc(%ebp),%eax
80106336:	8b 40 18             	mov    0x18(%eax),%eax
80106339:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010633c:	77 9c                	ja     801062da <iNodeName+0xf>
	{
	safestrcpy(buf, de.name, DIRSIZ);
	return 0;
	}
}
	return -1; //failed, R.I.P file system
8010633e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106343:	c9                   	leave  
80106344:	c3                   	ret    

80106345 <namediNode>:


int namediNode(char* buf, int n, struct inode *ip)
{
80106345:	55                   	push   %ebp
80106346:	89 e5                	mov    %esp,%ebp
80106348:	53                   	push   %ebx
80106349:	83 ec 24             	sub    $0x24,%esp
	int off_set;
	struct inode *parent;
	char node_name[DIRSIZ];
	if(ip-> inum == namei("/")->inum)
8010634c:	8b 45 10             	mov    0x10(%ebp),%eax
8010634f:	8b 58 04             	mov    0x4(%eax),%ebx
80106352:	83 ec 0c             	sub    $0xc,%esp
80106355:	68 28 8a 10 80       	push   $0x80108a28
8010635a:	e8 86 c4 ff ff       	call   801027e5 <namei>
8010635f:	83 c4 10             	add    $0x10,%esp
80106362:	8b 40 04             	mov    0x4(%eax),%eax
80106365:	39 c3                	cmp    %eax,%ebx
80106367:	75 10                	jne    80106379 <namediNode+0x34>
	{
		buf[0] = '/';
80106369:	8b 45 08             	mov    0x8(%ebp),%eax
8010636c:	c6 00 2f             	movb   $0x2f,(%eax)
		return 1;
8010636f:	b8 01 00 00 00       	mov    $0x1,%eax
80106374:	e9 16 01 00 00       	jmp    8010648f <namediNode+0x14a>
	}
else if(ip->type == T_DIR)
80106379:	8b 45 10             	mov    0x10(%ebp),%eax
8010637c:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106380:	66 83 f8 01          	cmp    $0x1,%ax
80106384:	0f 85 d1 00 00 00    	jne    8010645b <namediNode+0x116>
{
	parent = dirlookup(ip, "..", 0);
8010638a:	83 ec 04             	sub    $0x4,%esp
8010638d:	6a 00                	push   $0x0
8010638f:	68 bc 89 10 80       	push   $0x801089bc
80106394:	ff 75 10             	pushl  0x10(%ebp)
80106397:	e8 f6 c0 ff ff       	call   80102492 <dirlookup>
8010639c:	83 c4 10             	add    $0x10,%esp
8010639f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	ilock(parent);
801063a2:	83 ec 0c             	sub    $0xc,%esp
801063a5:	ff 75 f4             	pushl  -0xc(%ebp)
801063a8:	e8 75 b8 ff ff       	call   80101c22 <ilock>
801063ad:	83 c4 10             	add    $0x10,%esp
	if(iNodeName(ip, parent, node_name)) // if the parent file doesn't have a name
801063b0:	83 ec 04             	sub    $0x4,%esp
801063b3:	8d 45 e2             	lea    -0x1e(%ebp),%eax
801063b6:	50                   	push   %eax
801063b7:	ff 75 f4             	pushl  -0xc(%ebp)
801063ba:	ff 75 10             	pushl  0x10(%ebp)
801063bd:	e8 09 ff ff ff       	call   801062cb <iNodeName>
801063c2:	83 c4 10             	add    $0x10,%esp
801063c5:	85 c0                	test   %eax,%eax
801063c7:	74 0d                	je     801063d6 <namediNode+0x91>
		panic("could not find parent's inode name");
801063c9:	83 ec 0c             	sub    $0xc,%esp
801063cc:	68 2c 8a 10 80       	push   $0x80108a2c
801063d1:	e8 86 a1 ff ff       	call   8010055c <panic>
	off_set = namediNode(buf, n, parent);
801063d6:	83 ec 04             	sub    $0x4,%esp
801063d9:	ff 75 f4             	pushl  -0xc(%ebp)
801063dc:	ff 75 0c             	pushl  0xc(%ebp)
801063df:	ff 75 08             	pushl  0x8(%ebp)
801063e2:	e8 5e ff ff ff       	call   80106345 <namediNode>
801063e7:	83 c4 10             	add    $0x10,%esp
801063ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
	safestrcpy(buf + off_set, node_name, off_set);
801063ed:	8b 55 f0             	mov    -0x10(%ebp),%edx
801063f0:	8b 45 08             	mov    0x8(%ebp),%eax
801063f3:	01 c2                	add    %eax,%edx
801063f5:	83 ec 04             	sub    $0x4,%esp
801063f8:	ff 75 f0             	pushl  -0x10(%ebp)
801063fb:	8d 45 e2             	lea    -0x1e(%ebp),%eax
801063fe:	50                   	push   %eax
801063ff:	52                   	push   %edx
80106400:	e8 22 ef ff ff       	call   80105327 <safestrcpy>
80106405:	83 c4 10             	add    $0x10,%esp
	off_set += strlen(node_name);
80106408:	83 ec 0c             	sub    $0xc,%esp
8010640b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
8010640e:	50                   	push   %eax
8010640f:	e8 5d ef ff ff       	call   80105371 <strlen>
80106414:	83 c4 10             	add    $0x10,%esp
80106417:	01 45 f0             	add    %eax,-0x10(%ebp)

	if(off_set == n - 1)
8010641a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010641d:	83 e8 01             	sub    $0x1,%eax
80106420:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80106423:	75 10                	jne    80106435 <namediNode+0xf0>
	{
		buf[off_set] = '\0';
80106425:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106428:	8b 45 08             	mov    0x8(%ebp),%eax
8010642b:	01 d0                	add    %edx,%eax
8010642d:	c6 00 00             	movb   $0x0,(%eax)
		return n;
80106430:	8b 45 0c             	mov    0xc(%ebp),%eax
80106433:	eb 5a                	jmp    8010648f <namediNode+0x14a>
	}
else
	buf[off_set++] = '/'; //divides the directory names
80106435:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106438:	8d 50 01             	lea    0x1(%eax),%edx
8010643b:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010643e:	89 c2                	mov    %eax,%edx
80106440:	8b 45 08             	mov    0x8(%ebp),%eax
80106443:	01 d0                	add    %edx,%eax
80106445:	c6 00 2f             	movb   $0x2f,(%eax)
iput(parent);
80106448:	83 ec 0c             	sub    $0xc,%esp
8010644b:	ff 75 f4             	pushl  -0xc(%ebp)
8010644e:	e8 97 b9 ff ff       	call   80101dea <iput>
80106453:	83 c4 10             	add    $0x10,%esp
return off_set;
80106456:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106459:	eb 34                	jmp    8010648f <namediNode+0x14a>
}
else if(ip->type == T_DEV || ip->type == T_FILE) //triggers errors if I don't have these
8010645b:	8b 45 10             	mov    0x10(%ebp),%eax
8010645e:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106462:	66 83 f8 03          	cmp    $0x3,%ax
80106466:	74 0d                	je     80106475 <namediNode+0x130>
80106468:	8b 45 10             	mov    0x10(%ebp),%eax
8010646b:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010646f:	66 83 f8 02          	cmp    $0x2,%ax
80106473:	75 0d                	jne    80106482 <namediNode+0x13d>
	panic("process cwd is a device node");
80106475:	83 ec 0c             	sub    $0xc,%esp
80106478:	68 4f 8a 10 80       	push   $0x80108a4f
8010647d:	e8 da a0 ff ff       	call   8010055c <panic>
else
panic("unknown inode type");
80106482:	83 ec 0c             	sub    $0xc,%esp
80106485:	68 6c 8a 10 80       	push   $0x80108a6c
8010648a:	e8 cd a0 ff ff       	call   8010055c <panic>
}
8010648f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106492:	c9                   	leave  
80106493:	c3                   	ret    

80106494 <sys_getcwd>:



int sys_getcwd(void)
{
80106494:	55                   	push   %ebp
80106495:	89 e5                	mov    %esp,%ebp
80106497:	83 ec 18             	sub    $0x18,%esp
	char *p;
	int n;
	if(argint(1, &n) < 0 || argptr(0, &p, n) < 0)
8010649a:	83 ec 08             	sub    $0x8,%esp
8010649d:	8d 45 f0             	lea    -0x10(%ebp),%eax
801064a0:	50                   	push   %eax
801064a1:	6a 01                	push   $0x1
801064a3:	e8 a1 ef ff ff       	call   80105449 <argint>
801064a8:	83 c4 10             	add    $0x10,%esp
801064ab:	85 c0                	test   %eax,%eax
801064ad:	78 19                	js     801064c8 <sys_getcwd+0x34>
801064af:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064b2:	83 ec 04             	sub    $0x4,%esp
801064b5:	50                   	push   %eax
801064b6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064b9:	50                   	push   %eax
801064ba:	6a 00                	push   $0x0
801064bc:	e8 b0 ef ff ff       	call   80105471 <argptr>
801064c1:	83 c4 10             	add    $0x10,%esp
801064c4:	85 c0                	test   %eax,%eax
801064c6:	79 07                	jns    801064cf <sys_getcwd+0x3b>
	return 1;
801064c8:	b8 01 00 00 00       	mov    $0x1,%eax
801064cd:	eb 1d                	jmp    801064ec <sys_getcwd+0x58>

return namediNode(p, n, proc->cwd);
801064cf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801064d5:	8b 48 68             	mov    0x68(%eax),%ecx
801064d8:	8b 55 f0             	mov    -0x10(%ebp),%edx
801064db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064de:	83 ec 04             	sub    $0x4,%esp
801064e1:	51                   	push   %ecx
801064e2:	52                   	push   %edx
801064e3:	50                   	push   %eax
801064e4:	e8 5c fe ff ff       	call   80106345 <namediNode>
801064e9:	83 c4 10             	add    $0x10,%esp
}
801064ec:	c9                   	leave  
801064ed:	c3                   	ret    

801064ee <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801064ee:	55                   	push   %ebp
801064ef:	89 e5                	mov    %esp,%ebp
801064f1:	83 ec 08             	sub    $0x8,%esp
  return fork();
801064f4:	e8 3f e1 ff ff       	call   80104638 <fork>
}
801064f9:	c9                   	leave  
801064fa:	c3                   	ret    

801064fb <sys_exit>:

int
sys_exit(void)
{
801064fb:	55                   	push   %ebp
801064fc:	89 e5                	mov    %esp,%ebp
801064fe:	83 ec 08             	sub    $0x8,%esp
  exit();
80106501:	e8 a3 e2 ff ff       	call   801047a9 <exit>
  return 0;  // not reached
80106506:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010650b:	c9                   	leave  
8010650c:	c3                   	ret    

8010650d <sys_wait>:

int
sys_wait(void)
{
8010650d:	55                   	push   %ebp
8010650e:	89 e5                	mov    %esp,%ebp
80106510:	83 ec 08             	sub    $0x8,%esp
  return wait();
80106513:	e8 bf e3 ff ff       	call   801048d7 <wait>
}
80106518:	c9                   	leave  
80106519:	c3                   	ret    

8010651a <sys_kill>:

int
sys_kill(void)
{
8010651a:	55                   	push   %ebp
8010651b:	89 e5                	mov    %esp,%ebp
8010651d:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106520:	83 ec 08             	sub    $0x8,%esp
80106523:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106526:	50                   	push   %eax
80106527:	6a 00                	push   $0x0
80106529:	e8 1b ef ff ff       	call   80105449 <argint>
8010652e:	83 c4 10             	add    $0x10,%esp
80106531:	85 c0                	test   %eax,%eax
80106533:	79 07                	jns    8010653c <sys_kill+0x22>
    return -1;
80106535:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010653a:	eb 0f                	jmp    8010654b <sys_kill+0x31>
  return kill(pid);
8010653c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010653f:	83 ec 0c             	sub    $0xc,%esp
80106542:	50                   	push   %eax
80106543:	e8 9b e7 ff ff       	call   80104ce3 <kill>
80106548:	83 c4 10             	add    $0x10,%esp
}
8010654b:	c9                   	leave  
8010654c:	c3                   	ret    

8010654d <sys_getpid>:

int
sys_getpid(void)
{
8010654d:	55                   	push   %ebp
8010654e:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80106550:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106556:	8b 40 10             	mov    0x10(%eax),%eax
}
80106559:	5d                   	pop    %ebp
8010655a:	c3                   	ret    

8010655b <sys_sbrk>:

int
sys_sbrk(void)
{
8010655b:	55                   	push   %ebp
8010655c:	89 e5                	mov    %esp,%ebp
8010655e:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106561:	83 ec 08             	sub    $0x8,%esp
80106564:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106567:	50                   	push   %eax
80106568:	6a 00                	push   $0x0
8010656a:	e8 da ee ff ff       	call   80105449 <argint>
8010656f:	83 c4 10             	add    $0x10,%esp
80106572:	85 c0                	test   %eax,%eax
80106574:	79 07                	jns    8010657d <sys_sbrk+0x22>
    return -1;
80106576:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010657b:	eb 28                	jmp    801065a5 <sys_sbrk+0x4a>
  addr = proc->sz;
8010657d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106583:	8b 00                	mov    (%eax),%eax
80106585:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80106588:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010658b:	83 ec 0c             	sub    $0xc,%esp
8010658e:	50                   	push   %eax
8010658f:	e8 01 e0 ff ff       	call   80104595 <growproc>
80106594:	83 c4 10             	add    $0x10,%esp
80106597:	85 c0                	test   %eax,%eax
80106599:	79 07                	jns    801065a2 <sys_sbrk+0x47>
    return -1;
8010659b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065a0:	eb 03                	jmp    801065a5 <sys_sbrk+0x4a>
  return addr;
801065a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801065a5:	c9                   	leave  
801065a6:	c3                   	ret    

801065a7 <sys_sleep>:

int
sys_sleep(void)
{
801065a7:	55                   	push   %ebp
801065a8:	89 e5                	mov    %esp,%ebp
801065aa:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
801065ad:	83 ec 08             	sub    $0x8,%esp
801065b0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801065b3:	50                   	push   %eax
801065b4:	6a 00                	push   $0x0
801065b6:	e8 8e ee ff ff       	call   80105449 <argint>
801065bb:	83 c4 10             	add    $0x10,%esp
801065be:	85 c0                	test   %eax,%eax
801065c0:	79 07                	jns    801065c9 <sys_sleep+0x22>
    return -1;
801065c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065c7:	eb 77                	jmp    80106640 <sys_sleep+0x99>
  acquire(&tickslock);
801065c9:	83 ec 0c             	sub    $0xc,%esp
801065cc:	68 40 24 11 80       	push   $0x80112440
801065d1:	e8 f0 e8 ff ff       	call   80104ec6 <acquire>
801065d6:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801065d9:	a1 80 2c 11 80       	mov    0x80112c80,%eax
801065de:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
801065e1:	eb 39                	jmp    8010661c <sys_sleep+0x75>
    if(proc->killed){
801065e3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065e9:	8b 40 24             	mov    0x24(%eax),%eax
801065ec:	85 c0                	test   %eax,%eax
801065ee:	74 17                	je     80106607 <sys_sleep+0x60>
      release(&tickslock);
801065f0:	83 ec 0c             	sub    $0xc,%esp
801065f3:	68 40 24 11 80       	push   $0x80112440
801065f8:	e8 2f e9 ff ff       	call   80104f2c <release>
801065fd:	83 c4 10             	add    $0x10,%esp
      return -1;
80106600:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106605:	eb 39                	jmp    80106640 <sys_sleep+0x99>
    }
    sleep(&ticks, &tickslock);
80106607:	83 ec 08             	sub    $0x8,%esp
8010660a:	68 40 24 11 80       	push   $0x80112440
8010660f:	68 80 2c 11 80       	push   $0x80112c80
80106614:	e8 ab e5 ff ff       	call   80104bc4 <sleep>
80106619:	83 c4 10             	add    $0x10,%esp
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010661c:	a1 80 2c 11 80       	mov    0x80112c80,%eax
80106621:	2b 45 f4             	sub    -0xc(%ebp),%eax
80106624:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106627:	39 d0                	cmp    %edx,%eax
80106629:	72 b8                	jb     801065e3 <sys_sleep+0x3c>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
8010662b:	83 ec 0c             	sub    $0xc,%esp
8010662e:	68 40 24 11 80       	push   $0x80112440
80106633:	e8 f4 e8 ff ff       	call   80104f2c <release>
80106638:	83 c4 10             	add    $0x10,%esp
  return 0;
8010663b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106640:	c9                   	leave  
80106641:	c3                   	ret    

80106642 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106642:	55                   	push   %ebp
80106643:	89 e5                	mov    %esp,%ebp
80106645:	83 ec 18             	sub    $0x18,%esp
  uint xticks;
  
  acquire(&tickslock);
80106648:	83 ec 0c             	sub    $0xc,%esp
8010664b:	68 40 24 11 80       	push   $0x80112440
80106650:	e8 71 e8 ff ff       	call   80104ec6 <acquire>
80106655:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
80106658:	a1 80 2c 11 80       	mov    0x80112c80,%eax
8010665d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
80106660:	83 ec 0c             	sub    $0xc,%esp
80106663:	68 40 24 11 80       	push   $0x80112440
80106668:	e8 bf e8 ff ff       	call   80104f2c <release>
8010666d:	83 c4 10             	add    $0x10,%esp
  return xticks;
80106670:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106673:	c9                   	leave  
80106674:	c3                   	ret    

80106675 <sys_ps>:

int sys_ps(void)
{
80106675:	55                   	push   %ebp
80106676:	89 e5                	mov    %esp,%ebp
80106678:	83 ec 08             	sub    $0x8,%esp
	return ps();
8010667b:	e8 dd e7 ff ff       	call   80104e5d <ps>
}
80106680:	c9                   	leave  
80106681:	c3                   	ret    

80106682 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106682:	55                   	push   %ebp
80106683:	89 e5                	mov    %esp,%ebp
80106685:	83 ec 08             	sub    $0x8,%esp
80106688:	8b 55 08             	mov    0x8(%ebp),%edx
8010668b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010668e:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106692:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106695:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106699:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010669d:	ee                   	out    %al,(%dx)
}
8010669e:	c9                   	leave  
8010669f:	c3                   	ret    

801066a0 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
801066a0:	55                   	push   %ebp
801066a1:	89 e5                	mov    %esp,%ebp
801066a3:	83 ec 08             	sub    $0x8,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
801066a6:	6a 34                	push   $0x34
801066a8:	6a 43                	push   $0x43
801066aa:	e8 d3 ff ff ff       	call   80106682 <outb>
801066af:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
801066b2:	68 9c 00 00 00       	push   $0x9c
801066b7:	6a 40                	push   $0x40
801066b9:	e8 c4 ff ff ff       	call   80106682 <outb>
801066be:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
801066c1:	6a 2e                	push   $0x2e
801066c3:	6a 40                	push   $0x40
801066c5:	e8 b8 ff ff ff       	call   80106682 <outb>
801066ca:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
801066cd:	83 ec 0c             	sub    $0xc,%esp
801066d0:	6a 00                	push   $0x0
801066d2:	e8 57 d7 ff ff       	call   80103e2e <picenable>
801066d7:	83 c4 10             	add    $0x10,%esp
}
801066da:	c9                   	leave  
801066db:	c3                   	ret    

801066dc <alltraps>:
801066dc:	1e                   	push   %ds
801066dd:	06                   	push   %es
801066de:	0f a0                	push   %fs
801066e0:	0f a8                	push   %gs
801066e2:	60                   	pusha  
801066e3:	66 b8 10 00          	mov    $0x10,%ax
801066e7:	8e d8                	mov    %eax,%ds
801066e9:	8e c0                	mov    %eax,%es
801066eb:	66 b8 18 00          	mov    $0x18,%ax
801066ef:	8e e0                	mov    %eax,%fs
801066f1:	8e e8                	mov    %eax,%gs
801066f3:	54                   	push   %esp
801066f4:	e8 d4 01 00 00       	call   801068cd <trap>
801066f9:	83 c4 04             	add    $0x4,%esp

801066fc <trapret>:
801066fc:	61                   	popa   
801066fd:	0f a9                	pop    %gs
801066ff:	0f a1                	pop    %fs
80106701:	07                   	pop    %es
80106702:	1f                   	pop    %ds
80106703:	83 c4 08             	add    $0x8,%esp
80106706:	cf                   	iret   

80106707 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
80106707:	55                   	push   %ebp
80106708:	89 e5                	mov    %esp,%ebp
8010670a:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
8010670d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106710:	83 e8 01             	sub    $0x1,%eax
80106713:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106717:	8b 45 08             	mov    0x8(%ebp),%eax
8010671a:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010671e:	8b 45 08             	mov    0x8(%ebp),%eax
80106721:	c1 e8 10             	shr    $0x10,%eax
80106724:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106728:	8d 45 fa             	lea    -0x6(%ebp),%eax
8010672b:	0f 01 18             	lidtl  (%eax)
}
8010672e:	c9                   	leave  
8010672f:	c3                   	ret    

80106730 <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
80106730:	55                   	push   %ebp
80106731:	89 e5                	mov    %esp,%ebp
80106733:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106736:	0f 20 d0             	mov    %cr2,%eax
80106739:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
8010673c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010673f:	c9                   	leave  
80106740:	c3                   	ret    

80106741 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106741:	55                   	push   %ebp
80106742:	89 e5                	mov    %esp,%ebp
80106744:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
80106747:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010674e:	e9 c3 00 00 00       	jmp    80106816 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106753:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106756:	8b 04 85 a0 b0 10 80 	mov    -0x7fef4f60(,%eax,4),%eax
8010675d:	89 c2                	mov    %eax,%edx
8010675f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106762:	66 89 14 c5 80 24 11 	mov    %dx,-0x7feedb80(,%eax,8)
80106769:	80 
8010676a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010676d:	66 c7 04 c5 82 24 11 	movw   $0x8,-0x7feedb7e(,%eax,8)
80106774:	80 08 00 
80106777:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010677a:	0f b6 14 c5 84 24 11 	movzbl -0x7feedb7c(,%eax,8),%edx
80106781:	80 
80106782:	83 e2 e0             	and    $0xffffffe0,%edx
80106785:	88 14 c5 84 24 11 80 	mov    %dl,-0x7feedb7c(,%eax,8)
8010678c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010678f:	0f b6 14 c5 84 24 11 	movzbl -0x7feedb7c(,%eax,8),%edx
80106796:	80 
80106797:	83 e2 1f             	and    $0x1f,%edx
8010679a:	88 14 c5 84 24 11 80 	mov    %dl,-0x7feedb7c(,%eax,8)
801067a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067a4:	0f b6 14 c5 85 24 11 	movzbl -0x7feedb7b(,%eax,8),%edx
801067ab:	80 
801067ac:	83 e2 f0             	and    $0xfffffff0,%edx
801067af:	83 ca 0e             	or     $0xe,%edx
801067b2:	88 14 c5 85 24 11 80 	mov    %dl,-0x7feedb7b(,%eax,8)
801067b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067bc:	0f b6 14 c5 85 24 11 	movzbl -0x7feedb7b(,%eax,8),%edx
801067c3:	80 
801067c4:	83 e2 ef             	and    $0xffffffef,%edx
801067c7:	88 14 c5 85 24 11 80 	mov    %dl,-0x7feedb7b(,%eax,8)
801067ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067d1:	0f b6 14 c5 85 24 11 	movzbl -0x7feedb7b(,%eax,8),%edx
801067d8:	80 
801067d9:	83 e2 9f             	and    $0xffffff9f,%edx
801067dc:	88 14 c5 85 24 11 80 	mov    %dl,-0x7feedb7b(,%eax,8)
801067e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067e6:	0f b6 14 c5 85 24 11 	movzbl -0x7feedb7b(,%eax,8),%edx
801067ed:	80 
801067ee:	83 ca 80             	or     $0xffffff80,%edx
801067f1:	88 14 c5 85 24 11 80 	mov    %dl,-0x7feedb7b(,%eax,8)
801067f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067fb:	8b 04 85 a0 b0 10 80 	mov    -0x7fef4f60(,%eax,4),%eax
80106802:	c1 e8 10             	shr    $0x10,%eax
80106805:	89 c2                	mov    %eax,%edx
80106807:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010680a:	66 89 14 c5 86 24 11 	mov    %dx,-0x7feedb7a(,%eax,8)
80106811:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106812:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106816:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
8010681d:	0f 8e 30 ff ff ff    	jle    80106753 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106823:	a1 a0 b1 10 80       	mov    0x8010b1a0,%eax
80106828:	66 a3 80 26 11 80    	mov    %ax,0x80112680
8010682e:	66 c7 05 82 26 11 80 	movw   $0x8,0x80112682
80106835:	08 00 
80106837:	0f b6 05 84 26 11 80 	movzbl 0x80112684,%eax
8010683e:	83 e0 e0             	and    $0xffffffe0,%eax
80106841:	a2 84 26 11 80       	mov    %al,0x80112684
80106846:	0f b6 05 84 26 11 80 	movzbl 0x80112684,%eax
8010684d:	83 e0 1f             	and    $0x1f,%eax
80106850:	a2 84 26 11 80       	mov    %al,0x80112684
80106855:	0f b6 05 85 26 11 80 	movzbl 0x80112685,%eax
8010685c:	83 c8 0f             	or     $0xf,%eax
8010685f:	a2 85 26 11 80       	mov    %al,0x80112685
80106864:	0f b6 05 85 26 11 80 	movzbl 0x80112685,%eax
8010686b:	83 e0 ef             	and    $0xffffffef,%eax
8010686e:	a2 85 26 11 80       	mov    %al,0x80112685
80106873:	0f b6 05 85 26 11 80 	movzbl 0x80112685,%eax
8010687a:	83 c8 60             	or     $0x60,%eax
8010687d:	a2 85 26 11 80       	mov    %al,0x80112685
80106882:	0f b6 05 85 26 11 80 	movzbl 0x80112685,%eax
80106889:	83 c8 80             	or     $0xffffff80,%eax
8010688c:	a2 85 26 11 80       	mov    %al,0x80112685
80106891:	a1 a0 b1 10 80       	mov    0x8010b1a0,%eax
80106896:	c1 e8 10             	shr    $0x10,%eax
80106899:	66 a3 86 26 11 80    	mov    %ax,0x80112686
  
  initlock(&tickslock, "time");
8010689f:	83 ec 08             	sub    $0x8,%esp
801068a2:	68 80 8a 10 80       	push   $0x80108a80
801068a7:	68 40 24 11 80       	push   $0x80112440
801068ac:	e8 f4 e5 ff ff       	call   80104ea5 <initlock>
801068b1:	83 c4 10             	add    $0x10,%esp
}
801068b4:	c9                   	leave  
801068b5:	c3                   	ret    

801068b6 <idtinit>:

void
idtinit(void)
{
801068b6:	55                   	push   %ebp
801068b7:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
801068b9:	68 00 08 00 00       	push   $0x800
801068be:	68 80 24 11 80       	push   $0x80112480
801068c3:	e8 3f fe ff ff       	call   80106707 <lidt>
801068c8:	83 c4 08             	add    $0x8,%esp
}
801068cb:	c9                   	leave  
801068cc:	c3                   	ret    

801068cd <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801068cd:	55                   	push   %ebp
801068ce:	89 e5                	mov    %esp,%ebp
801068d0:	57                   	push   %edi
801068d1:	56                   	push   %esi
801068d2:	53                   	push   %ebx
801068d3:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
801068d6:	8b 45 08             	mov    0x8(%ebp),%eax
801068d9:	8b 40 30             	mov    0x30(%eax),%eax
801068dc:	83 f8 40             	cmp    $0x40,%eax
801068df:	75 3f                	jne    80106920 <trap+0x53>
    if(proc->killed)
801068e1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068e7:	8b 40 24             	mov    0x24(%eax),%eax
801068ea:	85 c0                	test   %eax,%eax
801068ec:	74 05                	je     801068f3 <trap+0x26>
      exit();
801068ee:	e8 b6 de ff ff       	call   801047a9 <exit>
    proc->tf = tf;
801068f3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068f9:	8b 55 08             	mov    0x8(%ebp),%edx
801068fc:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
801068ff:	e8 fd eb ff ff       	call   80105501 <syscall>
    if(proc->killed)
80106904:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010690a:	8b 40 24             	mov    0x24(%eax),%eax
8010690d:	85 c0                	test   %eax,%eax
8010690f:	74 0a                	je     8010691b <trap+0x4e>
      exit();
80106911:	e8 93 de ff ff       	call   801047a9 <exit>
    return;
80106916:	e9 14 02 00 00       	jmp    80106b2f <trap+0x262>
8010691b:	e9 0f 02 00 00       	jmp    80106b2f <trap+0x262>
  }

  switch(tf->trapno){
80106920:	8b 45 08             	mov    0x8(%ebp),%eax
80106923:	8b 40 30             	mov    0x30(%eax),%eax
80106926:	83 e8 20             	sub    $0x20,%eax
80106929:	83 f8 1f             	cmp    $0x1f,%eax
8010692c:	0f 87 c0 00 00 00    	ja     801069f2 <trap+0x125>
80106932:	8b 04 85 28 8b 10 80 	mov    -0x7fef74d8(,%eax,4),%eax
80106939:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
8010693b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106941:	0f b6 00             	movzbl (%eax),%eax
80106944:	84 c0                	test   %al,%al
80106946:	75 3d                	jne    80106985 <trap+0xb8>
      acquire(&tickslock);
80106948:	83 ec 0c             	sub    $0xc,%esp
8010694b:	68 40 24 11 80       	push   $0x80112440
80106950:	e8 71 e5 ff ff       	call   80104ec6 <acquire>
80106955:	83 c4 10             	add    $0x10,%esp
      ticks++;
80106958:	a1 80 2c 11 80       	mov    0x80112c80,%eax
8010695d:	83 c0 01             	add    $0x1,%eax
80106960:	a3 80 2c 11 80       	mov    %eax,0x80112c80
      wakeup(&ticks);
80106965:	83 ec 0c             	sub    $0xc,%esp
80106968:	68 80 2c 11 80       	push   $0x80112c80
8010696d:	e8 3b e3 ff ff       	call   80104cad <wakeup>
80106972:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
80106975:	83 ec 0c             	sub    $0xc,%esp
80106978:	68 40 24 11 80       	push   $0x80112440
8010697d:	e8 aa e5 ff ff       	call   80104f2c <release>
80106982:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
80106985:	e8 ec c8 ff ff       	call   80103276 <lapiceoi>
    break;
8010698a:	e9 1c 01 00 00       	jmp    80106aab <trap+0x1de>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
8010698f:	e8 20 c1 ff ff       	call   80102ab4 <ideintr>
    lapiceoi();
80106994:	e8 dd c8 ff ff       	call   80103276 <lapiceoi>
    break;
80106999:	e9 0d 01 00 00       	jmp    80106aab <trap+0x1de>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
8010699e:	e8 f7 c6 ff ff       	call   8010309a <kbdintr>
    lapiceoi();
801069a3:	e8 ce c8 ff ff       	call   80103276 <lapiceoi>
    break;
801069a8:	e9 fe 00 00 00       	jmp    80106aab <trap+0x1de>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
801069ad:	e8 5a 03 00 00       	call   80106d0c <uartintr>
    lapiceoi();
801069b2:	e8 bf c8 ff ff       	call   80103276 <lapiceoi>
    break;
801069b7:	e9 ef 00 00 00       	jmp    80106aab <trap+0x1de>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801069bc:	8b 45 08             	mov    0x8(%ebp),%eax
801069bf:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
801069c2:	8b 45 08             	mov    0x8(%ebp),%eax
801069c5:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801069c9:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
801069cc:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801069d2:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801069d5:	0f b6 c0             	movzbl %al,%eax
801069d8:	51                   	push   %ecx
801069d9:	52                   	push   %edx
801069da:	50                   	push   %eax
801069db:	68 88 8a 10 80       	push   $0x80108a88
801069e0:	e8 da 99 ff ff       	call   801003bf <cprintf>
801069e5:	83 c4 10             	add    $0x10,%esp
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
801069e8:	e8 89 c8 ff ff       	call   80103276 <lapiceoi>
    break;
801069ed:	e9 b9 00 00 00       	jmp    80106aab <trap+0x1de>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
801069f2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801069f8:	85 c0                	test   %eax,%eax
801069fa:	74 11                	je     80106a0d <trap+0x140>
801069fc:	8b 45 08             	mov    0x8(%ebp),%eax
801069ff:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106a03:	0f b7 c0             	movzwl %ax,%eax
80106a06:	83 e0 03             	and    $0x3,%eax
80106a09:	85 c0                	test   %eax,%eax
80106a0b:	75 40                	jne    80106a4d <trap+0x180>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106a0d:	e8 1e fd ff ff       	call   80106730 <rcr2>
80106a12:	89 c3                	mov    %eax,%ebx
80106a14:	8b 45 08             	mov    0x8(%ebp),%eax
80106a17:	8b 48 38             	mov    0x38(%eax),%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
80106a1a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106a20:	0f b6 00             	movzbl (%eax),%eax
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106a23:	0f b6 d0             	movzbl %al,%edx
80106a26:	8b 45 08             	mov    0x8(%ebp),%eax
80106a29:	8b 40 30             	mov    0x30(%eax),%eax
80106a2c:	83 ec 0c             	sub    $0xc,%esp
80106a2f:	53                   	push   %ebx
80106a30:	51                   	push   %ecx
80106a31:	52                   	push   %edx
80106a32:	50                   	push   %eax
80106a33:	68 ac 8a 10 80       	push   $0x80108aac
80106a38:	e8 82 99 ff ff       	call   801003bf <cprintf>
80106a3d:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
80106a40:	83 ec 0c             	sub    $0xc,%esp
80106a43:	68 de 8a 10 80       	push   $0x80108ade
80106a48:	e8 0f 9b ff ff       	call   8010055c <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106a4d:	e8 de fc ff ff       	call   80106730 <rcr2>
80106a52:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a55:	8b 45 08             	mov    0x8(%ebp),%eax
80106a58:	8b 70 38             	mov    0x38(%eax),%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106a5b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106a61:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106a64:	0f b6 d8             	movzbl %al,%ebx
80106a67:	8b 45 08             	mov    0x8(%ebp),%eax
80106a6a:	8b 48 34             	mov    0x34(%eax),%ecx
80106a6d:	8b 45 08             	mov    0x8(%ebp),%eax
80106a70:	8b 50 30             	mov    0x30(%eax),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106a73:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a79:	8d 78 6c             	lea    0x6c(%eax),%edi
80106a7c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106a82:	8b 40 10             	mov    0x10(%eax),%eax
80106a85:	ff 75 e4             	pushl  -0x1c(%ebp)
80106a88:	56                   	push   %esi
80106a89:	53                   	push   %ebx
80106a8a:	51                   	push   %ecx
80106a8b:	52                   	push   %edx
80106a8c:	57                   	push   %edi
80106a8d:	50                   	push   %eax
80106a8e:	68 e4 8a 10 80       	push   $0x80108ae4
80106a93:	e8 27 99 ff ff       	call   801003bf <cprintf>
80106a98:	83 c4 20             	add    $0x20,%esp
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
80106a9b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106aa1:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106aa8:	eb 01                	jmp    80106aab <trap+0x1de>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106aaa:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106aab:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ab1:	85 c0                	test   %eax,%eax
80106ab3:	74 24                	je     80106ad9 <trap+0x20c>
80106ab5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106abb:	8b 40 24             	mov    0x24(%eax),%eax
80106abe:	85 c0                	test   %eax,%eax
80106ac0:	74 17                	je     80106ad9 <trap+0x20c>
80106ac2:	8b 45 08             	mov    0x8(%ebp),%eax
80106ac5:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106ac9:	0f b7 c0             	movzwl %ax,%eax
80106acc:	83 e0 03             	and    $0x3,%eax
80106acf:	83 f8 03             	cmp    $0x3,%eax
80106ad2:	75 05                	jne    80106ad9 <trap+0x20c>
    exit();
80106ad4:	e8 d0 dc ff ff       	call   801047a9 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106ad9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106adf:	85 c0                	test   %eax,%eax
80106ae1:	74 1e                	je     80106b01 <trap+0x234>
80106ae3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ae9:	8b 40 0c             	mov    0xc(%eax),%eax
80106aec:	83 f8 04             	cmp    $0x4,%eax
80106aef:	75 10                	jne    80106b01 <trap+0x234>
80106af1:	8b 45 08             	mov    0x8(%ebp),%eax
80106af4:	8b 40 30             	mov    0x30(%eax),%eax
80106af7:	83 f8 20             	cmp    $0x20,%eax
80106afa:	75 05                	jne    80106b01 <trap+0x234>
    yield();
80106afc:	e8 59 e0 ff ff       	call   80104b5a <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106b01:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b07:	85 c0                	test   %eax,%eax
80106b09:	74 24                	je     80106b2f <trap+0x262>
80106b0b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b11:	8b 40 24             	mov    0x24(%eax),%eax
80106b14:	85 c0                	test   %eax,%eax
80106b16:	74 17                	je     80106b2f <trap+0x262>
80106b18:	8b 45 08             	mov    0x8(%ebp),%eax
80106b1b:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106b1f:	0f b7 c0             	movzwl %ax,%eax
80106b22:	83 e0 03             	and    $0x3,%eax
80106b25:	83 f8 03             	cmp    $0x3,%eax
80106b28:	75 05                	jne    80106b2f <trap+0x262>
    exit();
80106b2a:	e8 7a dc ff ff       	call   801047a9 <exit>
}
80106b2f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b32:	5b                   	pop    %ebx
80106b33:	5e                   	pop    %esi
80106b34:	5f                   	pop    %edi
80106b35:	5d                   	pop    %ebp
80106b36:	c3                   	ret    

80106b37 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80106b37:	55                   	push   %ebp
80106b38:	89 e5                	mov    %esp,%ebp
80106b3a:	83 ec 14             	sub    $0x14,%esp
80106b3d:	8b 45 08             	mov    0x8(%ebp),%eax
80106b40:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106b44:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80106b48:	89 c2                	mov    %eax,%edx
80106b4a:	ec                   	in     (%dx),%al
80106b4b:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106b4e:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80106b52:	c9                   	leave  
80106b53:	c3                   	ret    

80106b54 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106b54:	55                   	push   %ebp
80106b55:	89 e5                	mov    %esp,%ebp
80106b57:	83 ec 08             	sub    $0x8,%esp
80106b5a:	8b 55 08             	mov    0x8(%ebp),%edx
80106b5d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b60:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106b64:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106b67:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106b6b:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106b6f:	ee                   	out    %al,(%dx)
}
80106b70:	c9                   	leave  
80106b71:	c3                   	ret    

80106b72 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106b72:	55                   	push   %ebp
80106b73:	89 e5                	mov    %esp,%ebp
80106b75:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106b78:	6a 00                	push   $0x0
80106b7a:	68 fa 03 00 00       	push   $0x3fa
80106b7f:	e8 d0 ff ff ff       	call   80106b54 <outb>
80106b84:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106b87:	68 80 00 00 00       	push   $0x80
80106b8c:	68 fb 03 00 00       	push   $0x3fb
80106b91:	e8 be ff ff ff       	call   80106b54 <outb>
80106b96:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80106b99:	6a 0c                	push   $0xc
80106b9b:	68 f8 03 00 00       	push   $0x3f8
80106ba0:	e8 af ff ff ff       	call   80106b54 <outb>
80106ba5:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80106ba8:	6a 00                	push   $0x0
80106baa:	68 f9 03 00 00       	push   $0x3f9
80106baf:	e8 a0 ff ff ff       	call   80106b54 <outb>
80106bb4:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106bb7:	6a 03                	push   $0x3
80106bb9:	68 fb 03 00 00       	push   $0x3fb
80106bbe:	e8 91 ff ff ff       	call   80106b54 <outb>
80106bc3:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106bc6:	6a 00                	push   $0x0
80106bc8:	68 fc 03 00 00       	push   $0x3fc
80106bcd:	e8 82 ff ff ff       	call   80106b54 <outb>
80106bd2:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106bd5:	6a 01                	push   $0x1
80106bd7:	68 f9 03 00 00       	push   $0x3f9
80106bdc:	e8 73 ff ff ff       	call   80106b54 <outb>
80106be1:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106be4:	68 fd 03 00 00       	push   $0x3fd
80106be9:	e8 49 ff ff ff       	call   80106b37 <inb>
80106bee:	83 c4 04             	add    $0x4,%esp
80106bf1:	3c ff                	cmp    $0xff,%al
80106bf3:	75 02                	jne    80106bf7 <uartinit+0x85>
    return;
80106bf5:	eb 6c                	jmp    80106c63 <uartinit+0xf1>
  uart = 1;
80106bf7:	c7 05 ac bb 10 80 01 	movl   $0x1,0x8010bbac
80106bfe:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106c01:	68 fa 03 00 00       	push   $0x3fa
80106c06:	e8 2c ff ff ff       	call   80106b37 <inb>
80106c0b:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80106c0e:	68 f8 03 00 00       	push   $0x3f8
80106c13:	e8 1f ff ff ff       	call   80106b37 <inb>
80106c18:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
80106c1b:	83 ec 0c             	sub    $0xc,%esp
80106c1e:	6a 04                	push   $0x4
80106c20:	e8 09 d2 ff ff       	call   80103e2e <picenable>
80106c25:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
80106c28:	83 ec 08             	sub    $0x8,%esp
80106c2b:	6a 00                	push   $0x0
80106c2d:	6a 04                	push   $0x4
80106c2f:	e8 1e c1 ff ff       	call   80102d52 <ioapicenable>
80106c34:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106c37:	c7 45 f4 a8 8b 10 80 	movl   $0x80108ba8,-0xc(%ebp)
80106c3e:	eb 19                	jmp    80106c59 <uartinit+0xe7>
    uartputc(*p);
80106c40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c43:	0f b6 00             	movzbl (%eax),%eax
80106c46:	0f be c0             	movsbl %al,%eax
80106c49:	83 ec 0c             	sub    $0xc,%esp
80106c4c:	50                   	push   %eax
80106c4d:	e8 13 00 00 00       	call   80106c65 <uartputc>
80106c52:	83 c4 10             	add    $0x10,%esp
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106c55:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106c59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c5c:	0f b6 00             	movzbl (%eax),%eax
80106c5f:	84 c0                	test   %al,%al
80106c61:	75 dd                	jne    80106c40 <uartinit+0xce>
    uartputc(*p);
}
80106c63:	c9                   	leave  
80106c64:	c3                   	ret    

80106c65 <uartputc>:

void
uartputc(int c)
{
80106c65:	55                   	push   %ebp
80106c66:	89 e5                	mov    %esp,%ebp
80106c68:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
80106c6b:	a1 ac bb 10 80       	mov    0x8010bbac,%eax
80106c70:	85 c0                	test   %eax,%eax
80106c72:	75 02                	jne    80106c76 <uartputc+0x11>
    return;
80106c74:	eb 51                	jmp    80106cc7 <uartputc+0x62>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106c76:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106c7d:	eb 11                	jmp    80106c90 <uartputc+0x2b>
    microdelay(10);
80106c7f:	83 ec 0c             	sub    $0xc,%esp
80106c82:	6a 0a                	push   $0xa
80106c84:	e8 07 c6 ff ff       	call   80103290 <microdelay>
80106c89:	83 c4 10             	add    $0x10,%esp
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106c8c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106c90:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106c94:	7f 1a                	jg     80106cb0 <uartputc+0x4b>
80106c96:	83 ec 0c             	sub    $0xc,%esp
80106c99:	68 fd 03 00 00       	push   $0x3fd
80106c9e:	e8 94 fe ff ff       	call   80106b37 <inb>
80106ca3:	83 c4 10             	add    $0x10,%esp
80106ca6:	0f b6 c0             	movzbl %al,%eax
80106ca9:	83 e0 20             	and    $0x20,%eax
80106cac:	85 c0                	test   %eax,%eax
80106cae:	74 cf                	je     80106c7f <uartputc+0x1a>
    microdelay(10);
  outb(COM1+0, c);
80106cb0:	8b 45 08             	mov    0x8(%ebp),%eax
80106cb3:	0f b6 c0             	movzbl %al,%eax
80106cb6:	83 ec 08             	sub    $0x8,%esp
80106cb9:	50                   	push   %eax
80106cba:	68 f8 03 00 00       	push   $0x3f8
80106cbf:	e8 90 fe ff ff       	call   80106b54 <outb>
80106cc4:	83 c4 10             	add    $0x10,%esp
}
80106cc7:	c9                   	leave  
80106cc8:	c3                   	ret    

80106cc9 <uartgetc>:

static int
uartgetc(void)
{
80106cc9:	55                   	push   %ebp
80106cca:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106ccc:	a1 ac bb 10 80       	mov    0x8010bbac,%eax
80106cd1:	85 c0                	test   %eax,%eax
80106cd3:	75 07                	jne    80106cdc <uartgetc+0x13>
    return -1;
80106cd5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cda:	eb 2e                	jmp    80106d0a <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80106cdc:	68 fd 03 00 00       	push   $0x3fd
80106ce1:	e8 51 fe ff ff       	call   80106b37 <inb>
80106ce6:	83 c4 04             	add    $0x4,%esp
80106ce9:	0f b6 c0             	movzbl %al,%eax
80106cec:	83 e0 01             	and    $0x1,%eax
80106cef:	85 c0                	test   %eax,%eax
80106cf1:	75 07                	jne    80106cfa <uartgetc+0x31>
    return -1;
80106cf3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cf8:	eb 10                	jmp    80106d0a <uartgetc+0x41>
  return inb(COM1+0);
80106cfa:	68 f8 03 00 00       	push   $0x3f8
80106cff:	e8 33 fe ff ff       	call   80106b37 <inb>
80106d04:	83 c4 04             	add    $0x4,%esp
80106d07:	0f b6 c0             	movzbl %al,%eax
}
80106d0a:	c9                   	leave  
80106d0b:	c3                   	ret    

80106d0c <uartintr>:

void
uartintr(void)
{
80106d0c:	55                   	push   %ebp
80106d0d:	89 e5                	mov    %esp,%ebp
80106d0f:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80106d12:	83 ec 0c             	sub    $0xc,%esp
80106d15:	68 c9 6c 10 80       	push   $0x80106cc9
80106d1a:	e8 b2 9a ff ff       	call   801007d1 <consoleintr>
80106d1f:	83 c4 10             	add    $0x10,%esp
}
80106d22:	c9                   	leave  
80106d23:	c3                   	ret    

80106d24 <vector0>:
80106d24:	6a 00                	push   $0x0
80106d26:	6a 00                	push   $0x0
80106d28:	e9 af f9 ff ff       	jmp    801066dc <alltraps>

80106d2d <vector1>:
80106d2d:	6a 00                	push   $0x0
80106d2f:	6a 01                	push   $0x1
80106d31:	e9 a6 f9 ff ff       	jmp    801066dc <alltraps>

80106d36 <vector2>:
80106d36:	6a 00                	push   $0x0
80106d38:	6a 02                	push   $0x2
80106d3a:	e9 9d f9 ff ff       	jmp    801066dc <alltraps>

80106d3f <vector3>:
80106d3f:	6a 00                	push   $0x0
80106d41:	6a 03                	push   $0x3
80106d43:	e9 94 f9 ff ff       	jmp    801066dc <alltraps>

80106d48 <vector4>:
80106d48:	6a 00                	push   $0x0
80106d4a:	6a 04                	push   $0x4
80106d4c:	e9 8b f9 ff ff       	jmp    801066dc <alltraps>

80106d51 <vector5>:
80106d51:	6a 00                	push   $0x0
80106d53:	6a 05                	push   $0x5
80106d55:	e9 82 f9 ff ff       	jmp    801066dc <alltraps>

80106d5a <vector6>:
80106d5a:	6a 00                	push   $0x0
80106d5c:	6a 06                	push   $0x6
80106d5e:	e9 79 f9 ff ff       	jmp    801066dc <alltraps>

80106d63 <vector7>:
80106d63:	6a 00                	push   $0x0
80106d65:	6a 07                	push   $0x7
80106d67:	e9 70 f9 ff ff       	jmp    801066dc <alltraps>

80106d6c <vector8>:
80106d6c:	6a 08                	push   $0x8
80106d6e:	e9 69 f9 ff ff       	jmp    801066dc <alltraps>

80106d73 <vector9>:
80106d73:	6a 00                	push   $0x0
80106d75:	6a 09                	push   $0x9
80106d77:	e9 60 f9 ff ff       	jmp    801066dc <alltraps>

80106d7c <vector10>:
80106d7c:	6a 0a                	push   $0xa
80106d7e:	e9 59 f9 ff ff       	jmp    801066dc <alltraps>

80106d83 <vector11>:
80106d83:	6a 0b                	push   $0xb
80106d85:	e9 52 f9 ff ff       	jmp    801066dc <alltraps>

80106d8a <vector12>:
80106d8a:	6a 0c                	push   $0xc
80106d8c:	e9 4b f9 ff ff       	jmp    801066dc <alltraps>

80106d91 <vector13>:
80106d91:	6a 0d                	push   $0xd
80106d93:	e9 44 f9 ff ff       	jmp    801066dc <alltraps>

80106d98 <vector14>:
80106d98:	6a 0e                	push   $0xe
80106d9a:	e9 3d f9 ff ff       	jmp    801066dc <alltraps>

80106d9f <vector15>:
80106d9f:	6a 00                	push   $0x0
80106da1:	6a 0f                	push   $0xf
80106da3:	e9 34 f9 ff ff       	jmp    801066dc <alltraps>

80106da8 <vector16>:
80106da8:	6a 00                	push   $0x0
80106daa:	6a 10                	push   $0x10
80106dac:	e9 2b f9 ff ff       	jmp    801066dc <alltraps>

80106db1 <vector17>:
80106db1:	6a 11                	push   $0x11
80106db3:	e9 24 f9 ff ff       	jmp    801066dc <alltraps>

80106db8 <vector18>:
80106db8:	6a 00                	push   $0x0
80106dba:	6a 12                	push   $0x12
80106dbc:	e9 1b f9 ff ff       	jmp    801066dc <alltraps>

80106dc1 <vector19>:
80106dc1:	6a 00                	push   $0x0
80106dc3:	6a 13                	push   $0x13
80106dc5:	e9 12 f9 ff ff       	jmp    801066dc <alltraps>

80106dca <vector20>:
80106dca:	6a 00                	push   $0x0
80106dcc:	6a 14                	push   $0x14
80106dce:	e9 09 f9 ff ff       	jmp    801066dc <alltraps>

80106dd3 <vector21>:
80106dd3:	6a 00                	push   $0x0
80106dd5:	6a 15                	push   $0x15
80106dd7:	e9 00 f9 ff ff       	jmp    801066dc <alltraps>

80106ddc <vector22>:
80106ddc:	6a 00                	push   $0x0
80106dde:	6a 16                	push   $0x16
80106de0:	e9 f7 f8 ff ff       	jmp    801066dc <alltraps>

80106de5 <vector23>:
80106de5:	6a 00                	push   $0x0
80106de7:	6a 17                	push   $0x17
80106de9:	e9 ee f8 ff ff       	jmp    801066dc <alltraps>

80106dee <vector24>:
80106dee:	6a 00                	push   $0x0
80106df0:	6a 18                	push   $0x18
80106df2:	e9 e5 f8 ff ff       	jmp    801066dc <alltraps>

80106df7 <vector25>:
80106df7:	6a 00                	push   $0x0
80106df9:	6a 19                	push   $0x19
80106dfb:	e9 dc f8 ff ff       	jmp    801066dc <alltraps>

80106e00 <vector26>:
80106e00:	6a 00                	push   $0x0
80106e02:	6a 1a                	push   $0x1a
80106e04:	e9 d3 f8 ff ff       	jmp    801066dc <alltraps>

80106e09 <vector27>:
80106e09:	6a 00                	push   $0x0
80106e0b:	6a 1b                	push   $0x1b
80106e0d:	e9 ca f8 ff ff       	jmp    801066dc <alltraps>

80106e12 <vector28>:
80106e12:	6a 00                	push   $0x0
80106e14:	6a 1c                	push   $0x1c
80106e16:	e9 c1 f8 ff ff       	jmp    801066dc <alltraps>

80106e1b <vector29>:
80106e1b:	6a 00                	push   $0x0
80106e1d:	6a 1d                	push   $0x1d
80106e1f:	e9 b8 f8 ff ff       	jmp    801066dc <alltraps>

80106e24 <vector30>:
80106e24:	6a 00                	push   $0x0
80106e26:	6a 1e                	push   $0x1e
80106e28:	e9 af f8 ff ff       	jmp    801066dc <alltraps>

80106e2d <vector31>:
80106e2d:	6a 00                	push   $0x0
80106e2f:	6a 1f                	push   $0x1f
80106e31:	e9 a6 f8 ff ff       	jmp    801066dc <alltraps>

80106e36 <vector32>:
80106e36:	6a 00                	push   $0x0
80106e38:	6a 20                	push   $0x20
80106e3a:	e9 9d f8 ff ff       	jmp    801066dc <alltraps>

80106e3f <vector33>:
80106e3f:	6a 00                	push   $0x0
80106e41:	6a 21                	push   $0x21
80106e43:	e9 94 f8 ff ff       	jmp    801066dc <alltraps>

80106e48 <vector34>:
80106e48:	6a 00                	push   $0x0
80106e4a:	6a 22                	push   $0x22
80106e4c:	e9 8b f8 ff ff       	jmp    801066dc <alltraps>

80106e51 <vector35>:
80106e51:	6a 00                	push   $0x0
80106e53:	6a 23                	push   $0x23
80106e55:	e9 82 f8 ff ff       	jmp    801066dc <alltraps>

80106e5a <vector36>:
80106e5a:	6a 00                	push   $0x0
80106e5c:	6a 24                	push   $0x24
80106e5e:	e9 79 f8 ff ff       	jmp    801066dc <alltraps>

80106e63 <vector37>:
80106e63:	6a 00                	push   $0x0
80106e65:	6a 25                	push   $0x25
80106e67:	e9 70 f8 ff ff       	jmp    801066dc <alltraps>

80106e6c <vector38>:
80106e6c:	6a 00                	push   $0x0
80106e6e:	6a 26                	push   $0x26
80106e70:	e9 67 f8 ff ff       	jmp    801066dc <alltraps>

80106e75 <vector39>:
80106e75:	6a 00                	push   $0x0
80106e77:	6a 27                	push   $0x27
80106e79:	e9 5e f8 ff ff       	jmp    801066dc <alltraps>

80106e7e <vector40>:
80106e7e:	6a 00                	push   $0x0
80106e80:	6a 28                	push   $0x28
80106e82:	e9 55 f8 ff ff       	jmp    801066dc <alltraps>

80106e87 <vector41>:
80106e87:	6a 00                	push   $0x0
80106e89:	6a 29                	push   $0x29
80106e8b:	e9 4c f8 ff ff       	jmp    801066dc <alltraps>

80106e90 <vector42>:
80106e90:	6a 00                	push   $0x0
80106e92:	6a 2a                	push   $0x2a
80106e94:	e9 43 f8 ff ff       	jmp    801066dc <alltraps>

80106e99 <vector43>:
80106e99:	6a 00                	push   $0x0
80106e9b:	6a 2b                	push   $0x2b
80106e9d:	e9 3a f8 ff ff       	jmp    801066dc <alltraps>

80106ea2 <vector44>:
80106ea2:	6a 00                	push   $0x0
80106ea4:	6a 2c                	push   $0x2c
80106ea6:	e9 31 f8 ff ff       	jmp    801066dc <alltraps>

80106eab <vector45>:
80106eab:	6a 00                	push   $0x0
80106ead:	6a 2d                	push   $0x2d
80106eaf:	e9 28 f8 ff ff       	jmp    801066dc <alltraps>

80106eb4 <vector46>:
80106eb4:	6a 00                	push   $0x0
80106eb6:	6a 2e                	push   $0x2e
80106eb8:	e9 1f f8 ff ff       	jmp    801066dc <alltraps>

80106ebd <vector47>:
80106ebd:	6a 00                	push   $0x0
80106ebf:	6a 2f                	push   $0x2f
80106ec1:	e9 16 f8 ff ff       	jmp    801066dc <alltraps>

80106ec6 <vector48>:
80106ec6:	6a 00                	push   $0x0
80106ec8:	6a 30                	push   $0x30
80106eca:	e9 0d f8 ff ff       	jmp    801066dc <alltraps>

80106ecf <vector49>:
80106ecf:	6a 00                	push   $0x0
80106ed1:	6a 31                	push   $0x31
80106ed3:	e9 04 f8 ff ff       	jmp    801066dc <alltraps>

80106ed8 <vector50>:
80106ed8:	6a 00                	push   $0x0
80106eda:	6a 32                	push   $0x32
80106edc:	e9 fb f7 ff ff       	jmp    801066dc <alltraps>

80106ee1 <vector51>:
80106ee1:	6a 00                	push   $0x0
80106ee3:	6a 33                	push   $0x33
80106ee5:	e9 f2 f7 ff ff       	jmp    801066dc <alltraps>

80106eea <vector52>:
80106eea:	6a 00                	push   $0x0
80106eec:	6a 34                	push   $0x34
80106eee:	e9 e9 f7 ff ff       	jmp    801066dc <alltraps>

80106ef3 <vector53>:
80106ef3:	6a 00                	push   $0x0
80106ef5:	6a 35                	push   $0x35
80106ef7:	e9 e0 f7 ff ff       	jmp    801066dc <alltraps>

80106efc <vector54>:
80106efc:	6a 00                	push   $0x0
80106efe:	6a 36                	push   $0x36
80106f00:	e9 d7 f7 ff ff       	jmp    801066dc <alltraps>

80106f05 <vector55>:
80106f05:	6a 00                	push   $0x0
80106f07:	6a 37                	push   $0x37
80106f09:	e9 ce f7 ff ff       	jmp    801066dc <alltraps>

80106f0e <vector56>:
80106f0e:	6a 00                	push   $0x0
80106f10:	6a 38                	push   $0x38
80106f12:	e9 c5 f7 ff ff       	jmp    801066dc <alltraps>

80106f17 <vector57>:
80106f17:	6a 00                	push   $0x0
80106f19:	6a 39                	push   $0x39
80106f1b:	e9 bc f7 ff ff       	jmp    801066dc <alltraps>

80106f20 <vector58>:
80106f20:	6a 00                	push   $0x0
80106f22:	6a 3a                	push   $0x3a
80106f24:	e9 b3 f7 ff ff       	jmp    801066dc <alltraps>

80106f29 <vector59>:
80106f29:	6a 00                	push   $0x0
80106f2b:	6a 3b                	push   $0x3b
80106f2d:	e9 aa f7 ff ff       	jmp    801066dc <alltraps>

80106f32 <vector60>:
80106f32:	6a 00                	push   $0x0
80106f34:	6a 3c                	push   $0x3c
80106f36:	e9 a1 f7 ff ff       	jmp    801066dc <alltraps>

80106f3b <vector61>:
80106f3b:	6a 00                	push   $0x0
80106f3d:	6a 3d                	push   $0x3d
80106f3f:	e9 98 f7 ff ff       	jmp    801066dc <alltraps>

80106f44 <vector62>:
80106f44:	6a 00                	push   $0x0
80106f46:	6a 3e                	push   $0x3e
80106f48:	e9 8f f7 ff ff       	jmp    801066dc <alltraps>

80106f4d <vector63>:
80106f4d:	6a 00                	push   $0x0
80106f4f:	6a 3f                	push   $0x3f
80106f51:	e9 86 f7 ff ff       	jmp    801066dc <alltraps>

80106f56 <vector64>:
80106f56:	6a 00                	push   $0x0
80106f58:	6a 40                	push   $0x40
80106f5a:	e9 7d f7 ff ff       	jmp    801066dc <alltraps>

80106f5f <vector65>:
80106f5f:	6a 00                	push   $0x0
80106f61:	6a 41                	push   $0x41
80106f63:	e9 74 f7 ff ff       	jmp    801066dc <alltraps>

80106f68 <vector66>:
80106f68:	6a 00                	push   $0x0
80106f6a:	6a 42                	push   $0x42
80106f6c:	e9 6b f7 ff ff       	jmp    801066dc <alltraps>

80106f71 <vector67>:
80106f71:	6a 00                	push   $0x0
80106f73:	6a 43                	push   $0x43
80106f75:	e9 62 f7 ff ff       	jmp    801066dc <alltraps>

80106f7a <vector68>:
80106f7a:	6a 00                	push   $0x0
80106f7c:	6a 44                	push   $0x44
80106f7e:	e9 59 f7 ff ff       	jmp    801066dc <alltraps>

80106f83 <vector69>:
80106f83:	6a 00                	push   $0x0
80106f85:	6a 45                	push   $0x45
80106f87:	e9 50 f7 ff ff       	jmp    801066dc <alltraps>

80106f8c <vector70>:
80106f8c:	6a 00                	push   $0x0
80106f8e:	6a 46                	push   $0x46
80106f90:	e9 47 f7 ff ff       	jmp    801066dc <alltraps>

80106f95 <vector71>:
80106f95:	6a 00                	push   $0x0
80106f97:	6a 47                	push   $0x47
80106f99:	e9 3e f7 ff ff       	jmp    801066dc <alltraps>

80106f9e <vector72>:
80106f9e:	6a 00                	push   $0x0
80106fa0:	6a 48                	push   $0x48
80106fa2:	e9 35 f7 ff ff       	jmp    801066dc <alltraps>

80106fa7 <vector73>:
80106fa7:	6a 00                	push   $0x0
80106fa9:	6a 49                	push   $0x49
80106fab:	e9 2c f7 ff ff       	jmp    801066dc <alltraps>

80106fb0 <vector74>:
80106fb0:	6a 00                	push   $0x0
80106fb2:	6a 4a                	push   $0x4a
80106fb4:	e9 23 f7 ff ff       	jmp    801066dc <alltraps>

80106fb9 <vector75>:
80106fb9:	6a 00                	push   $0x0
80106fbb:	6a 4b                	push   $0x4b
80106fbd:	e9 1a f7 ff ff       	jmp    801066dc <alltraps>

80106fc2 <vector76>:
80106fc2:	6a 00                	push   $0x0
80106fc4:	6a 4c                	push   $0x4c
80106fc6:	e9 11 f7 ff ff       	jmp    801066dc <alltraps>

80106fcb <vector77>:
80106fcb:	6a 00                	push   $0x0
80106fcd:	6a 4d                	push   $0x4d
80106fcf:	e9 08 f7 ff ff       	jmp    801066dc <alltraps>

80106fd4 <vector78>:
80106fd4:	6a 00                	push   $0x0
80106fd6:	6a 4e                	push   $0x4e
80106fd8:	e9 ff f6 ff ff       	jmp    801066dc <alltraps>

80106fdd <vector79>:
80106fdd:	6a 00                	push   $0x0
80106fdf:	6a 4f                	push   $0x4f
80106fe1:	e9 f6 f6 ff ff       	jmp    801066dc <alltraps>

80106fe6 <vector80>:
80106fe6:	6a 00                	push   $0x0
80106fe8:	6a 50                	push   $0x50
80106fea:	e9 ed f6 ff ff       	jmp    801066dc <alltraps>

80106fef <vector81>:
80106fef:	6a 00                	push   $0x0
80106ff1:	6a 51                	push   $0x51
80106ff3:	e9 e4 f6 ff ff       	jmp    801066dc <alltraps>

80106ff8 <vector82>:
80106ff8:	6a 00                	push   $0x0
80106ffa:	6a 52                	push   $0x52
80106ffc:	e9 db f6 ff ff       	jmp    801066dc <alltraps>

80107001 <vector83>:
80107001:	6a 00                	push   $0x0
80107003:	6a 53                	push   $0x53
80107005:	e9 d2 f6 ff ff       	jmp    801066dc <alltraps>

8010700a <vector84>:
8010700a:	6a 00                	push   $0x0
8010700c:	6a 54                	push   $0x54
8010700e:	e9 c9 f6 ff ff       	jmp    801066dc <alltraps>

80107013 <vector85>:
80107013:	6a 00                	push   $0x0
80107015:	6a 55                	push   $0x55
80107017:	e9 c0 f6 ff ff       	jmp    801066dc <alltraps>

8010701c <vector86>:
8010701c:	6a 00                	push   $0x0
8010701e:	6a 56                	push   $0x56
80107020:	e9 b7 f6 ff ff       	jmp    801066dc <alltraps>

80107025 <vector87>:
80107025:	6a 00                	push   $0x0
80107027:	6a 57                	push   $0x57
80107029:	e9 ae f6 ff ff       	jmp    801066dc <alltraps>

8010702e <vector88>:
8010702e:	6a 00                	push   $0x0
80107030:	6a 58                	push   $0x58
80107032:	e9 a5 f6 ff ff       	jmp    801066dc <alltraps>

80107037 <vector89>:
80107037:	6a 00                	push   $0x0
80107039:	6a 59                	push   $0x59
8010703b:	e9 9c f6 ff ff       	jmp    801066dc <alltraps>

80107040 <vector90>:
80107040:	6a 00                	push   $0x0
80107042:	6a 5a                	push   $0x5a
80107044:	e9 93 f6 ff ff       	jmp    801066dc <alltraps>

80107049 <vector91>:
80107049:	6a 00                	push   $0x0
8010704b:	6a 5b                	push   $0x5b
8010704d:	e9 8a f6 ff ff       	jmp    801066dc <alltraps>

80107052 <vector92>:
80107052:	6a 00                	push   $0x0
80107054:	6a 5c                	push   $0x5c
80107056:	e9 81 f6 ff ff       	jmp    801066dc <alltraps>

8010705b <vector93>:
8010705b:	6a 00                	push   $0x0
8010705d:	6a 5d                	push   $0x5d
8010705f:	e9 78 f6 ff ff       	jmp    801066dc <alltraps>

80107064 <vector94>:
80107064:	6a 00                	push   $0x0
80107066:	6a 5e                	push   $0x5e
80107068:	e9 6f f6 ff ff       	jmp    801066dc <alltraps>

8010706d <vector95>:
8010706d:	6a 00                	push   $0x0
8010706f:	6a 5f                	push   $0x5f
80107071:	e9 66 f6 ff ff       	jmp    801066dc <alltraps>

80107076 <vector96>:
80107076:	6a 00                	push   $0x0
80107078:	6a 60                	push   $0x60
8010707a:	e9 5d f6 ff ff       	jmp    801066dc <alltraps>

8010707f <vector97>:
8010707f:	6a 00                	push   $0x0
80107081:	6a 61                	push   $0x61
80107083:	e9 54 f6 ff ff       	jmp    801066dc <alltraps>

80107088 <vector98>:
80107088:	6a 00                	push   $0x0
8010708a:	6a 62                	push   $0x62
8010708c:	e9 4b f6 ff ff       	jmp    801066dc <alltraps>

80107091 <vector99>:
80107091:	6a 00                	push   $0x0
80107093:	6a 63                	push   $0x63
80107095:	e9 42 f6 ff ff       	jmp    801066dc <alltraps>

8010709a <vector100>:
8010709a:	6a 00                	push   $0x0
8010709c:	6a 64                	push   $0x64
8010709e:	e9 39 f6 ff ff       	jmp    801066dc <alltraps>

801070a3 <vector101>:
801070a3:	6a 00                	push   $0x0
801070a5:	6a 65                	push   $0x65
801070a7:	e9 30 f6 ff ff       	jmp    801066dc <alltraps>

801070ac <vector102>:
801070ac:	6a 00                	push   $0x0
801070ae:	6a 66                	push   $0x66
801070b0:	e9 27 f6 ff ff       	jmp    801066dc <alltraps>

801070b5 <vector103>:
801070b5:	6a 00                	push   $0x0
801070b7:	6a 67                	push   $0x67
801070b9:	e9 1e f6 ff ff       	jmp    801066dc <alltraps>

801070be <vector104>:
801070be:	6a 00                	push   $0x0
801070c0:	6a 68                	push   $0x68
801070c2:	e9 15 f6 ff ff       	jmp    801066dc <alltraps>

801070c7 <vector105>:
801070c7:	6a 00                	push   $0x0
801070c9:	6a 69                	push   $0x69
801070cb:	e9 0c f6 ff ff       	jmp    801066dc <alltraps>

801070d0 <vector106>:
801070d0:	6a 00                	push   $0x0
801070d2:	6a 6a                	push   $0x6a
801070d4:	e9 03 f6 ff ff       	jmp    801066dc <alltraps>

801070d9 <vector107>:
801070d9:	6a 00                	push   $0x0
801070db:	6a 6b                	push   $0x6b
801070dd:	e9 fa f5 ff ff       	jmp    801066dc <alltraps>

801070e2 <vector108>:
801070e2:	6a 00                	push   $0x0
801070e4:	6a 6c                	push   $0x6c
801070e6:	e9 f1 f5 ff ff       	jmp    801066dc <alltraps>

801070eb <vector109>:
801070eb:	6a 00                	push   $0x0
801070ed:	6a 6d                	push   $0x6d
801070ef:	e9 e8 f5 ff ff       	jmp    801066dc <alltraps>

801070f4 <vector110>:
801070f4:	6a 00                	push   $0x0
801070f6:	6a 6e                	push   $0x6e
801070f8:	e9 df f5 ff ff       	jmp    801066dc <alltraps>

801070fd <vector111>:
801070fd:	6a 00                	push   $0x0
801070ff:	6a 6f                	push   $0x6f
80107101:	e9 d6 f5 ff ff       	jmp    801066dc <alltraps>

80107106 <vector112>:
80107106:	6a 00                	push   $0x0
80107108:	6a 70                	push   $0x70
8010710a:	e9 cd f5 ff ff       	jmp    801066dc <alltraps>

8010710f <vector113>:
8010710f:	6a 00                	push   $0x0
80107111:	6a 71                	push   $0x71
80107113:	e9 c4 f5 ff ff       	jmp    801066dc <alltraps>

80107118 <vector114>:
80107118:	6a 00                	push   $0x0
8010711a:	6a 72                	push   $0x72
8010711c:	e9 bb f5 ff ff       	jmp    801066dc <alltraps>

80107121 <vector115>:
80107121:	6a 00                	push   $0x0
80107123:	6a 73                	push   $0x73
80107125:	e9 b2 f5 ff ff       	jmp    801066dc <alltraps>

8010712a <vector116>:
8010712a:	6a 00                	push   $0x0
8010712c:	6a 74                	push   $0x74
8010712e:	e9 a9 f5 ff ff       	jmp    801066dc <alltraps>

80107133 <vector117>:
80107133:	6a 00                	push   $0x0
80107135:	6a 75                	push   $0x75
80107137:	e9 a0 f5 ff ff       	jmp    801066dc <alltraps>

8010713c <vector118>:
8010713c:	6a 00                	push   $0x0
8010713e:	6a 76                	push   $0x76
80107140:	e9 97 f5 ff ff       	jmp    801066dc <alltraps>

80107145 <vector119>:
80107145:	6a 00                	push   $0x0
80107147:	6a 77                	push   $0x77
80107149:	e9 8e f5 ff ff       	jmp    801066dc <alltraps>

8010714e <vector120>:
8010714e:	6a 00                	push   $0x0
80107150:	6a 78                	push   $0x78
80107152:	e9 85 f5 ff ff       	jmp    801066dc <alltraps>

80107157 <vector121>:
80107157:	6a 00                	push   $0x0
80107159:	6a 79                	push   $0x79
8010715b:	e9 7c f5 ff ff       	jmp    801066dc <alltraps>

80107160 <vector122>:
80107160:	6a 00                	push   $0x0
80107162:	6a 7a                	push   $0x7a
80107164:	e9 73 f5 ff ff       	jmp    801066dc <alltraps>

80107169 <vector123>:
80107169:	6a 00                	push   $0x0
8010716b:	6a 7b                	push   $0x7b
8010716d:	e9 6a f5 ff ff       	jmp    801066dc <alltraps>

80107172 <vector124>:
80107172:	6a 00                	push   $0x0
80107174:	6a 7c                	push   $0x7c
80107176:	e9 61 f5 ff ff       	jmp    801066dc <alltraps>

8010717b <vector125>:
8010717b:	6a 00                	push   $0x0
8010717d:	6a 7d                	push   $0x7d
8010717f:	e9 58 f5 ff ff       	jmp    801066dc <alltraps>

80107184 <vector126>:
80107184:	6a 00                	push   $0x0
80107186:	6a 7e                	push   $0x7e
80107188:	e9 4f f5 ff ff       	jmp    801066dc <alltraps>

8010718d <vector127>:
8010718d:	6a 00                	push   $0x0
8010718f:	6a 7f                	push   $0x7f
80107191:	e9 46 f5 ff ff       	jmp    801066dc <alltraps>

80107196 <vector128>:
80107196:	6a 00                	push   $0x0
80107198:	68 80 00 00 00       	push   $0x80
8010719d:	e9 3a f5 ff ff       	jmp    801066dc <alltraps>

801071a2 <vector129>:
801071a2:	6a 00                	push   $0x0
801071a4:	68 81 00 00 00       	push   $0x81
801071a9:	e9 2e f5 ff ff       	jmp    801066dc <alltraps>

801071ae <vector130>:
801071ae:	6a 00                	push   $0x0
801071b0:	68 82 00 00 00       	push   $0x82
801071b5:	e9 22 f5 ff ff       	jmp    801066dc <alltraps>

801071ba <vector131>:
801071ba:	6a 00                	push   $0x0
801071bc:	68 83 00 00 00       	push   $0x83
801071c1:	e9 16 f5 ff ff       	jmp    801066dc <alltraps>

801071c6 <vector132>:
801071c6:	6a 00                	push   $0x0
801071c8:	68 84 00 00 00       	push   $0x84
801071cd:	e9 0a f5 ff ff       	jmp    801066dc <alltraps>

801071d2 <vector133>:
801071d2:	6a 00                	push   $0x0
801071d4:	68 85 00 00 00       	push   $0x85
801071d9:	e9 fe f4 ff ff       	jmp    801066dc <alltraps>

801071de <vector134>:
801071de:	6a 00                	push   $0x0
801071e0:	68 86 00 00 00       	push   $0x86
801071e5:	e9 f2 f4 ff ff       	jmp    801066dc <alltraps>

801071ea <vector135>:
801071ea:	6a 00                	push   $0x0
801071ec:	68 87 00 00 00       	push   $0x87
801071f1:	e9 e6 f4 ff ff       	jmp    801066dc <alltraps>

801071f6 <vector136>:
801071f6:	6a 00                	push   $0x0
801071f8:	68 88 00 00 00       	push   $0x88
801071fd:	e9 da f4 ff ff       	jmp    801066dc <alltraps>

80107202 <vector137>:
80107202:	6a 00                	push   $0x0
80107204:	68 89 00 00 00       	push   $0x89
80107209:	e9 ce f4 ff ff       	jmp    801066dc <alltraps>

8010720e <vector138>:
8010720e:	6a 00                	push   $0x0
80107210:	68 8a 00 00 00       	push   $0x8a
80107215:	e9 c2 f4 ff ff       	jmp    801066dc <alltraps>

8010721a <vector139>:
8010721a:	6a 00                	push   $0x0
8010721c:	68 8b 00 00 00       	push   $0x8b
80107221:	e9 b6 f4 ff ff       	jmp    801066dc <alltraps>

80107226 <vector140>:
80107226:	6a 00                	push   $0x0
80107228:	68 8c 00 00 00       	push   $0x8c
8010722d:	e9 aa f4 ff ff       	jmp    801066dc <alltraps>

80107232 <vector141>:
80107232:	6a 00                	push   $0x0
80107234:	68 8d 00 00 00       	push   $0x8d
80107239:	e9 9e f4 ff ff       	jmp    801066dc <alltraps>

8010723e <vector142>:
8010723e:	6a 00                	push   $0x0
80107240:	68 8e 00 00 00       	push   $0x8e
80107245:	e9 92 f4 ff ff       	jmp    801066dc <alltraps>

8010724a <vector143>:
8010724a:	6a 00                	push   $0x0
8010724c:	68 8f 00 00 00       	push   $0x8f
80107251:	e9 86 f4 ff ff       	jmp    801066dc <alltraps>

80107256 <vector144>:
80107256:	6a 00                	push   $0x0
80107258:	68 90 00 00 00       	push   $0x90
8010725d:	e9 7a f4 ff ff       	jmp    801066dc <alltraps>

80107262 <vector145>:
80107262:	6a 00                	push   $0x0
80107264:	68 91 00 00 00       	push   $0x91
80107269:	e9 6e f4 ff ff       	jmp    801066dc <alltraps>

8010726e <vector146>:
8010726e:	6a 00                	push   $0x0
80107270:	68 92 00 00 00       	push   $0x92
80107275:	e9 62 f4 ff ff       	jmp    801066dc <alltraps>

8010727a <vector147>:
8010727a:	6a 00                	push   $0x0
8010727c:	68 93 00 00 00       	push   $0x93
80107281:	e9 56 f4 ff ff       	jmp    801066dc <alltraps>

80107286 <vector148>:
80107286:	6a 00                	push   $0x0
80107288:	68 94 00 00 00       	push   $0x94
8010728d:	e9 4a f4 ff ff       	jmp    801066dc <alltraps>

80107292 <vector149>:
80107292:	6a 00                	push   $0x0
80107294:	68 95 00 00 00       	push   $0x95
80107299:	e9 3e f4 ff ff       	jmp    801066dc <alltraps>

8010729e <vector150>:
8010729e:	6a 00                	push   $0x0
801072a0:	68 96 00 00 00       	push   $0x96
801072a5:	e9 32 f4 ff ff       	jmp    801066dc <alltraps>

801072aa <vector151>:
801072aa:	6a 00                	push   $0x0
801072ac:	68 97 00 00 00       	push   $0x97
801072b1:	e9 26 f4 ff ff       	jmp    801066dc <alltraps>

801072b6 <vector152>:
801072b6:	6a 00                	push   $0x0
801072b8:	68 98 00 00 00       	push   $0x98
801072bd:	e9 1a f4 ff ff       	jmp    801066dc <alltraps>

801072c2 <vector153>:
801072c2:	6a 00                	push   $0x0
801072c4:	68 99 00 00 00       	push   $0x99
801072c9:	e9 0e f4 ff ff       	jmp    801066dc <alltraps>

801072ce <vector154>:
801072ce:	6a 00                	push   $0x0
801072d0:	68 9a 00 00 00       	push   $0x9a
801072d5:	e9 02 f4 ff ff       	jmp    801066dc <alltraps>

801072da <vector155>:
801072da:	6a 00                	push   $0x0
801072dc:	68 9b 00 00 00       	push   $0x9b
801072e1:	e9 f6 f3 ff ff       	jmp    801066dc <alltraps>

801072e6 <vector156>:
801072e6:	6a 00                	push   $0x0
801072e8:	68 9c 00 00 00       	push   $0x9c
801072ed:	e9 ea f3 ff ff       	jmp    801066dc <alltraps>

801072f2 <vector157>:
801072f2:	6a 00                	push   $0x0
801072f4:	68 9d 00 00 00       	push   $0x9d
801072f9:	e9 de f3 ff ff       	jmp    801066dc <alltraps>

801072fe <vector158>:
801072fe:	6a 00                	push   $0x0
80107300:	68 9e 00 00 00       	push   $0x9e
80107305:	e9 d2 f3 ff ff       	jmp    801066dc <alltraps>

8010730a <vector159>:
8010730a:	6a 00                	push   $0x0
8010730c:	68 9f 00 00 00       	push   $0x9f
80107311:	e9 c6 f3 ff ff       	jmp    801066dc <alltraps>

80107316 <vector160>:
80107316:	6a 00                	push   $0x0
80107318:	68 a0 00 00 00       	push   $0xa0
8010731d:	e9 ba f3 ff ff       	jmp    801066dc <alltraps>

80107322 <vector161>:
80107322:	6a 00                	push   $0x0
80107324:	68 a1 00 00 00       	push   $0xa1
80107329:	e9 ae f3 ff ff       	jmp    801066dc <alltraps>

8010732e <vector162>:
8010732e:	6a 00                	push   $0x0
80107330:	68 a2 00 00 00       	push   $0xa2
80107335:	e9 a2 f3 ff ff       	jmp    801066dc <alltraps>

8010733a <vector163>:
8010733a:	6a 00                	push   $0x0
8010733c:	68 a3 00 00 00       	push   $0xa3
80107341:	e9 96 f3 ff ff       	jmp    801066dc <alltraps>

80107346 <vector164>:
80107346:	6a 00                	push   $0x0
80107348:	68 a4 00 00 00       	push   $0xa4
8010734d:	e9 8a f3 ff ff       	jmp    801066dc <alltraps>

80107352 <vector165>:
80107352:	6a 00                	push   $0x0
80107354:	68 a5 00 00 00       	push   $0xa5
80107359:	e9 7e f3 ff ff       	jmp    801066dc <alltraps>

8010735e <vector166>:
8010735e:	6a 00                	push   $0x0
80107360:	68 a6 00 00 00       	push   $0xa6
80107365:	e9 72 f3 ff ff       	jmp    801066dc <alltraps>

8010736a <vector167>:
8010736a:	6a 00                	push   $0x0
8010736c:	68 a7 00 00 00       	push   $0xa7
80107371:	e9 66 f3 ff ff       	jmp    801066dc <alltraps>

80107376 <vector168>:
80107376:	6a 00                	push   $0x0
80107378:	68 a8 00 00 00       	push   $0xa8
8010737d:	e9 5a f3 ff ff       	jmp    801066dc <alltraps>

80107382 <vector169>:
80107382:	6a 00                	push   $0x0
80107384:	68 a9 00 00 00       	push   $0xa9
80107389:	e9 4e f3 ff ff       	jmp    801066dc <alltraps>

8010738e <vector170>:
8010738e:	6a 00                	push   $0x0
80107390:	68 aa 00 00 00       	push   $0xaa
80107395:	e9 42 f3 ff ff       	jmp    801066dc <alltraps>

8010739a <vector171>:
8010739a:	6a 00                	push   $0x0
8010739c:	68 ab 00 00 00       	push   $0xab
801073a1:	e9 36 f3 ff ff       	jmp    801066dc <alltraps>

801073a6 <vector172>:
801073a6:	6a 00                	push   $0x0
801073a8:	68 ac 00 00 00       	push   $0xac
801073ad:	e9 2a f3 ff ff       	jmp    801066dc <alltraps>

801073b2 <vector173>:
801073b2:	6a 00                	push   $0x0
801073b4:	68 ad 00 00 00       	push   $0xad
801073b9:	e9 1e f3 ff ff       	jmp    801066dc <alltraps>

801073be <vector174>:
801073be:	6a 00                	push   $0x0
801073c0:	68 ae 00 00 00       	push   $0xae
801073c5:	e9 12 f3 ff ff       	jmp    801066dc <alltraps>

801073ca <vector175>:
801073ca:	6a 00                	push   $0x0
801073cc:	68 af 00 00 00       	push   $0xaf
801073d1:	e9 06 f3 ff ff       	jmp    801066dc <alltraps>

801073d6 <vector176>:
801073d6:	6a 00                	push   $0x0
801073d8:	68 b0 00 00 00       	push   $0xb0
801073dd:	e9 fa f2 ff ff       	jmp    801066dc <alltraps>

801073e2 <vector177>:
801073e2:	6a 00                	push   $0x0
801073e4:	68 b1 00 00 00       	push   $0xb1
801073e9:	e9 ee f2 ff ff       	jmp    801066dc <alltraps>

801073ee <vector178>:
801073ee:	6a 00                	push   $0x0
801073f0:	68 b2 00 00 00       	push   $0xb2
801073f5:	e9 e2 f2 ff ff       	jmp    801066dc <alltraps>

801073fa <vector179>:
801073fa:	6a 00                	push   $0x0
801073fc:	68 b3 00 00 00       	push   $0xb3
80107401:	e9 d6 f2 ff ff       	jmp    801066dc <alltraps>

80107406 <vector180>:
80107406:	6a 00                	push   $0x0
80107408:	68 b4 00 00 00       	push   $0xb4
8010740d:	e9 ca f2 ff ff       	jmp    801066dc <alltraps>

80107412 <vector181>:
80107412:	6a 00                	push   $0x0
80107414:	68 b5 00 00 00       	push   $0xb5
80107419:	e9 be f2 ff ff       	jmp    801066dc <alltraps>

8010741e <vector182>:
8010741e:	6a 00                	push   $0x0
80107420:	68 b6 00 00 00       	push   $0xb6
80107425:	e9 b2 f2 ff ff       	jmp    801066dc <alltraps>

8010742a <vector183>:
8010742a:	6a 00                	push   $0x0
8010742c:	68 b7 00 00 00       	push   $0xb7
80107431:	e9 a6 f2 ff ff       	jmp    801066dc <alltraps>

80107436 <vector184>:
80107436:	6a 00                	push   $0x0
80107438:	68 b8 00 00 00       	push   $0xb8
8010743d:	e9 9a f2 ff ff       	jmp    801066dc <alltraps>

80107442 <vector185>:
80107442:	6a 00                	push   $0x0
80107444:	68 b9 00 00 00       	push   $0xb9
80107449:	e9 8e f2 ff ff       	jmp    801066dc <alltraps>

8010744e <vector186>:
8010744e:	6a 00                	push   $0x0
80107450:	68 ba 00 00 00       	push   $0xba
80107455:	e9 82 f2 ff ff       	jmp    801066dc <alltraps>

8010745a <vector187>:
8010745a:	6a 00                	push   $0x0
8010745c:	68 bb 00 00 00       	push   $0xbb
80107461:	e9 76 f2 ff ff       	jmp    801066dc <alltraps>

80107466 <vector188>:
80107466:	6a 00                	push   $0x0
80107468:	68 bc 00 00 00       	push   $0xbc
8010746d:	e9 6a f2 ff ff       	jmp    801066dc <alltraps>

80107472 <vector189>:
80107472:	6a 00                	push   $0x0
80107474:	68 bd 00 00 00       	push   $0xbd
80107479:	e9 5e f2 ff ff       	jmp    801066dc <alltraps>

8010747e <vector190>:
8010747e:	6a 00                	push   $0x0
80107480:	68 be 00 00 00       	push   $0xbe
80107485:	e9 52 f2 ff ff       	jmp    801066dc <alltraps>

8010748a <vector191>:
8010748a:	6a 00                	push   $0x0
8010748c:	68 bf 00 00 00       	push   $0xbf
80107491:	e9 46 f2 ff ff       	jmp    801066dc <alltraps>

80107496 <vector192>:
80107496:	6a 00                	push   $0x0
80107498:	68 c0 00 00 00       	push   $0xc0
8010749d:	e9 3a f2 ff ff       	jmp    801066dc <alltraps>

801074a2 <vector193>:
801074a2:	6a 00                	push   $0x0
801074a4:	68 c1 00 00 00       	push   $0xc1
801074a9:	e9 2e f2 ff ff       	jmp    801066dc <alltraps>

801074ae <vector194>:
801074ae:	6a 00                	push   $0x0
801074b0:	68 c2 00 00 00       	push   $0xc2
801074b5:	e9 22 f2 ff ff       	jmp    801066dc <alltraps>

801074ba <vector195>:
801074ba:	6a 00                	push   $0x0
801074bc:	68 c3 00 00 00       	push   $0xc3
801074c1:	e9 16 f2 ff ff       	jmp    801066dc <alltraps>

801074c6 <vector196>:
801074c6:	6a 00                	push   $0x0
801074c8:	68 c4 00 00 00       	push   $0xc4
801074cd:	e9 0a f2 ff ff       	jmp    801066dc <alltraps>

801074d2 <vector197>:
801074d2:	6a 00                	push   $0x0
801074d4:	68 c5 00 00 00       	push   $0xc5
801074d9:	e9 fe f1 ff ff       	jmp    801066dc <alltraps>

801074de <vector198>:
801074de:	6a 00                	push   $0x0
801074e0:	68 c6 00 00 00       	push   $0xc6
801074e5:	e9 f2 f1 ff ff       	jmp    801066dc <alltraps>

801074ea <vector199>:
801074ea:	6a 00                	push   $0x0
801074ec:	68 c7 00 00 00       	push   $0xc7
801074f1:	e9 e6 f1 ff ff       	jmp    801066dc <alltraps>

801074f6 <vector200>:
801074f6:	6a 00                	push   $0x0
801074f8:	68 c8 00 00 00       	push   $0xc8
801074fd:	e9 da f1 ff ff       	jmp    801066dc <alltraps>

80107502 <vector201>:
80107502:	6a 00                	push   $0x0
80107504:	68 c9 00 00 00       	push   $0xc9
80107509:	e9 ce f1 ff ff       	jmp    801066dc <alltraps>

8010750e <vector202>:
8010750e:	6a 00                	push   $0x0
80107510:	68 ca 00 00 00       	push   $0xca
80107515:	e9 c2 f1 ff ff       	jmp    801066dc <alltraps>

8010751a <vector203>:
8010751a:	6a 00                	push   $0x0
8010751c:	68 cb 00 00 00       	push   $0xcb
80107521:	e9 b6 f1 ff ff       	jmp    801066dc <alltraps>

80107526 <vector204>:
80107526:	6a 00                	push   $0x0
80107528:	68 cc 00 00 00       	push   $0xcc
8010752d:	e9 aa f1 ff ff       	jmp    801066dc <alltraps>

80107532 <vector205>:
80107532:	6a 00                	push   $0x0
80107534:	68 cd 00 00 00       	push   $0xcd
80107539:	e9 9e f1 ff ff       	jmp    801066dc <alltraps>

8010753e <vector206>:
8010753e:	6a 00                	push   $0x0
80107540:	68 ce 00 00 00       	push   $0xce
80107545:	e9 92 f1 ff ff       	jmp    801066dc <alltraps>

8010754a <vector207>:
8010754a:	6a 00                	push   $0x0
8010754c:	68 cf 00 00 00       	push   $0xcf
80107551:	e9 86 f1 ff ff       	jmp    801066dc <alltraps>

80107556 <vector208>:
80107556:	6a 00                	push   $0x0
80107558:	68 d0 00 00 00       	push   $0xd0
8010755d:	e9 7a f1 ff ff       	jmp    801066dc <alltraps>

80107562 <vector209>:
80107562:	6a 00                	push   $0x0
80107564:	68 d1 00 00 00       	push   $0xd1
80107569:	e9 6e f1 ff ff       	jmp    801066dc <alltraps>

8010756e <vector210>:
8010756e:	6a 00                	push   $0x0
80107570:	68 d2 00 00 00       	push   $0xd2
80107575:	e9 62 f1 ff ff       	jmp    801066dc <alltraps>

8010757a <vector211>:
8010757a:	6a 00                	push   $0x0
8010757c:	68 d3 00 00 00       	push   $0xd3
80107581:	e9 56 f1 ff ff       	jmp    801066dc <alltraps>

80107586 <vector212>:
80107586:	6a 00                	push   $0x0
80107588:	68 d4 00 00 00       	push   $0xd4
8010758d:	e9 4a f1 ff ff       	jmp    801066dc <alltraps>

80107592 <vector213>:
80107592:	6a 00                	push   $0x0
80107594:	68 d5 00 00 00       	push   $0xd5
80107599:	e9 3e f1 ff ff       	jmp    801066dc <alltraps>

8010759e <vector214>:
8010759e:	6a 00                	push   $0x0
801075a0:	68 d6 00 00 00       	push   $0xd6
801075a5:	e9 32 f1 ff ff       	jmp    801066dc <alltraps>

801075aa <vector215>:
801075aa:	6a 00                	push   $0x0
801075ac:	68 d7 00 00 00       	push   $0xd7
801075b1:	e9 26 f1 ff ff       	jmp    801066dc <alltraps>

801075b6 <vector216>:
801075b6:	6a 00                	push   $0x0
801075b8:	68 d8 00 00 00       	push   $0xd8
801075bd:	e9 1a f1 ff ff       	jmp    801066dc <alltraps>

801075c2 <vector217>:
801075c2:	6a 00                	push   $0x0
801075c4:	68 d9 00 00 00       	push   $0xd9
801075c9:	e9 0e f1 ff ff       	jmp    801066dc <alltraps>

801075ce <vector218>:
801075ce:	6a 00                	push   $0x0
801075d0:	68 da 00 00 00       	push   $0xda
801075d5:	e9 02 f1 ff ff       	jmp    801066dc <alltraps>

801075da <vector219>:
801075da:	6a 00                	push   $0x0
801075dc:	68 db 00 00 00       	push   $0xdb
801075e1:	e9 f6 f0 ff ff       	jmp    801066dc <alltraps>

801075e6 <vector220>:
801075e6:	6a 00                	push   $0x0
801075e8:	68 dc 00 00 00       	push   $0xdc
801075ed:	e9 ea f0 ff ff       	jmp    801066dc <alltraps>

801075f2 <vector221>:
801075f2:	6a 00                	push   $0x0
801075f4:	68 dd 00 00 00       	push   $0xdd
801075f9:	e9 de f0 ff ff       	jmp    801066dc <alltraps>

801075fe <vector222>:
801075fe:	6a 00                	push   $0x0
80107600:	68 de 00 00 00       	push   $0xde
80107605:	e9 d2 f0 ff ff       	jmp    801066dc <alltraps>

8010760a <vector223>:
8010760a:	6a 00                	push   $0x0
8010760c:	68 df 00 00 00       	push   $0xdf
80107611:	e9 c6 f0 ff ff       	jmp    801066dc <alltraps>

80107616 <vector224>:
80107616:	6a 00                	push   $0x0
80107618:	68 e0 00 00 00       	push   $0xe0
8010761d:	e9 ba f0 ff ff       	jmp    801066dc <alltraps>

80107622 <vector225>:
80107622:	6a 00                	push   $0x0
80107624:	68 e1 00 00 00       	push   $0xe1
80107629:	e9 ae f0 ff ff       	jmp    801066dc <alltraps>

8010762e <vector226>:
8010762e:	6a 00                	push   $0x0
80107630:	68 e2 00 00 00       	push   $0xe2
80107635:	e9 a2 f0 ff ff       	jmp    801066dc <alltraps>

8010763a <vector227>:
8010763a:	6a 00                	push   $0x0
8010763c:	68 e3 00 00 00       	push   $0xe3
80107641:	e9 96 f0 ff ff       	jmp    801066dc <alltraps>

80107646 <vector228>:
80107646:	6a 00                	push   $0x0
80107648:	68 e4 00 00 00       	push   $0xe4
8010764d:	e9 8a f0 ff ff       	jmp    801066dc <alltraps>

80107652 <vector229>:
80107652:	6a 00                	push   $0x0
80107654:	68 e5 00 00 00       	push   $0xe5
80107659:	e9 7e f0 ff ff       	jmp    801066dc <alltraps>

8010765e <vector230>:
8010765e:	6a 00                	push   $0x0
80107660:	68 e6 00 00 00       	push   $0xe6
80107665:	e9 72 f0 ff ff       	jmp    801066dc <alltraps>

8010766a <vector231>:
8010766a:	6a 00                	push   $0x0
8010766c:	68 e7 00 00 00       	push   $0xe7
80107671:	e9 66 f0 ff ff       	jmp    801066dc <alltraps>

80107676 <vector232>:
80107676:	6a 00                	push   $0x0
80107678:	68 e8 00 00 00       	push   $0xe8
8010767d:	e9 5a f0 ff ff       	jmp    801066dc <alltraps>

80107682 <vector233>:
80107682:	6a 00                	push   $0x0
80107684:	68 e9 00 00 00       	push   $0xe9
80107689:	e9 4e f0 ff ff       	jmp    801066dc <alltraps>

8010768e <vector234>:
8010768e:	6a 00                	push   $0x0
80107690:	68 ea 00 00 00       	push   $0xea
80107695:	e9 42 f0 ff ff       	jmp    801066dc <alltraps>

8010769a <vector235>:
8010769a:	6a 00                	push   $0x0
8010769c:	68 eb 00 00 00       	push   $0xeb
801076a1:	e9 36 f0 ff ff       	jmp    801066dc <alltraps>

801076a6 <vector236>:
801076a6:	6a 00                	push   $0x0
801076a8:	68 ec 00 00 00       	push   $0xec
801076ad:	e9 2a f0 ff ff       	jmp    801066dc <alltraps>

801076b2 <vector237>:
801076b2:	6a 00                	push   $0x0
801076b4:	68 ed 00 00 00       	push   $0xed
801076b9:	e9 1e f0 ff ff       	jmp    801066dc <alltraps>

801076be <vector238>:
801076be:	6a 00                	push   $0x0
801076c0:	68 ee 00 00 00       	push   $0xee
801076c5:	e9 12 f0 ff ff       	jmp    801066dc <alltraps>

801076ca <vector239>:
801076ca:	6a 00                	push   $0x0
801076cc:	68 ef 00 00 00       	push   $0xef
801076d1:	e9 06 f0 ff ff       	jmp    801066dc <alltraps>

801076d6 <vector240>:
801076d6:	6a 00                	push   $0x0
801076d8:	68 f0 00 00 00       	push   $0xf0
801076dd:	e9 fa ef ff ff       	jmp    801066dc <alltraps>

801076e2 <vector241>:
801076e2:	6a 00                	push   $0x0
801076e4:	68 f1 00 00 00       	push   $0xf1
801076e9:	e9 ee ef ff ff       	jmp    801066dc <alltraps>

801076ee <vector242>:
801076ee:	6a 00                	push   $0x0
801076f0:	68 f2 00 00 00       	push   $0xf2
801076f5:	e9 e2 ef ff ff       	jmp    801066dc <alltraps>

801076fa <vector243>:
801076fa:	6a 00                	push   $0x0
801076fc:	68 f3 00 00 00       	push   $0xf3
80107701:	e9 d6 ef ff ff       	jmp    801066dc <alltraps>

80107706 <vector244>:
80107706:	6a 00                	push   $0x0
80107708:	68 f4 00 00 00       	push   $0xf4
8010770d:	e9 ca ef ff ff       	jmp    801066dc <alltraps>

80107712 <vector245>:
80107712:	6a 00                	push   $0x0
80107714:	68 f5 00 00 00       	push   $0xf5
80107719:	e9 be ef ff ff       	jmp    801066dc <alltraps>

8010771e <vector246>:
8010771e:	6a 00                	push   $0x0
80107720:	68 f6 00 00 00       	push   $0xf6
80107725:	e9 b2 ef ff ff       	jmp    801066dc <alltraps>

8010772a <vector247>:
8010772a:	6a 00                	push   $0x0
8010772c:	68 f7 00 00 00       	push   $0xf7
80107731:	e9 a6 ef ff ff       	jmp    801066dc <alltraps>

80107736 <vector248>:
80107736:	6a 00                	push   $0x0
80107738:	68 f8 00 00 00       	push   $0xf8
8010773d:	e9 9a ef ff ff       	jmp    801066dc <alltraps>

80107742 <vector249>:
80107742:	6a 00                	push   $0x0
80107744:	68 f9 00 00 00       	push   $0xf9
80107749:	e9 8e ef ff ff       	jmp    801066dc <alltraps>

8010774e <vector250>:
8010774e:	6a 00                	push   $0x0
80107750:	68 fa 00 00 00       	push   $0xfa
80107755:	e9 82 ef ff ff       	jmp    801066dc <alltraps>

8010775a <vector251>:
8010775a:	6a 00                	push   $0x0
8010775c:	68 fb 00 00 00       	push   $0xfb
80107761:	e9 76 ef ff ff       	jmp    801066dc <alltraps>

80107766 <vector252>:
80107766:	6a 00                	push   $0x0
80107768:	68 fc 00 00 00       	push   $0xfc
8010776d:	e9 6a ef ff ff       	jmp    801066dc <alltraps>

80107772 <vector253>:
80107772:	6a 00                	push   $0x0
80107774:	68 fd 00 00 00       	push   $0xfd
80107779:	e9 5e ef ff ff       	jmp    801066dc <alltraps>

8010777e <vector254>:
8010777e:	6a 00                	push   $0x0
80107780:	68 fe 00 00 00       	push   $0xfe
80107785:	e9 52 ef ff ff       	jmp    801066dc <alltraps>

8010778a <vector255>:
8010778a:	6a 00                	push   $0x0
8010778c:	68 ff 00 00 00       	push   $0xff
80107791:	e9 46 ef ff ff       	jmp    801066dc <alltraps>

80107796 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
80107796:	55                   	push   %ebp
80107797:	89 e5                	mov    %esp,%ebp
80107799:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
8010779c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010779f:	83 e8 01             	sub    $0x1,%eax
801077a2:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801077a6:	8b 45 08             	mov    0x8(%ebp),%eax
801077a9:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801077ad:	8b 45 08             	mov    0x8(%ebp),%eax
801077b0:	c1 e8 10             	shr    $0x10,%eax
801077b3:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
801077b7:	8d 45 fa             	lea    -0x6(%ebp),%eax
801077ba:	0f 01 10             	lgdtl  (%eax)
}
801077bd:	c9                   	leave  
801077be:	c3                   	ret    

801077bf <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
801077bf:	55                   	push   %ebp
801077c0:	89 e5                	mov    %esp,%ebp
801077c2:	83 ec 04             	sub    $0x4,%esp
801077c5:	8b 45 08             	mov    0x8(%ebp),%eax
801077c8:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
801077cc:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801077d0:	0f 00 d8             	ltr    %ax
}
801077d3:	c9                   	leave  
801077d4:	c3                   	ret    

801077d5 <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
801077d5:	55                   	push   %ebp
801077d6:	89 e5                	mov    %esp,%ebp
801077d8:	83 ec 04             	sub    $0x4,%esp
801077db:	8b 45 08             	mov    0x8(%ebp),%eax
801077de:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
801077e2:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801077e6:	8e e8                	mov    %eax,%gs
}
801077e8:	c9                   	leave  
801077e9:	c3                   	ret    

801077ea <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
801077ea:	55                   	push   %ebp
801077eb:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
801077ed:	8b 45 08             	mov    0x8(%ebp),%eax
801077f0:	0f 22 d8             	mov    %eax,%cr3
}
801077f3:	5d                   	pop    %ebp
801077f4:	c3                   	ret    

801077f5 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
801077f5:	55                   	push   %ebp
801077f6:	89 e5                	mov    %esp,%ebp
801077f8:	8b 45 08             	mov    0x8(%ebp),%eax
801077fb:	05 00 00 00 80       	add    $0x80000000,%eax
80107800:	5d                   	pop    %ebp
80107801:	c3                   	ret    

80107802 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80107802:	55                   	push   %ebp
80107803:	89 e5                	mov    %esp,%ebp
80107805:	8b 45 08             	mov    0x8(%ebp),%eax
80107808:	05 00 00 00 80       	add    $0x80000000,%eax
8010780d:	5d                   	pop    %ebp
8010780e:	c3                   	ret    

8010780f <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
8010780f:	55                   	push   %ebp
80107810:	89 e5                	mov    %esp,%ebp
80107812:	53                   	push   %ebx
80107813:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107816:	e8 02 ba ff ff       	call   8010321d <cpunum>
8010781b:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80107821:	05 00 ff 10 80       	add    $0x8010ff00,%eax
80107826:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107829:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010782c:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80107832:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107835:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
8010783b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010783e:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80107842:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107845:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107849:	83 e2 f0             	and    $0xfffffff0,%edx
8010784c:	83 ca 0a             	or     $0xa,%edx
8010784f:	88 50 7d             	mov    %dl,0x7d(%eax)
80107852:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107855:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107859:	83 ca 10             	or     $0x10,%edx
8010785c:	88 50 7d             	mov    %dl,0x7d(%eax)
8010785f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107862:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107866:	83 e2 9f             	and    $0xffffff9f,%edx
80107869:	88 50 7d             	mov    %dl,0x7d(%eax)
8010786c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010786f:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107873:	83 ca 80             	or     $0xffffff80,%edx
80107876:	88 50 7d             	mov    %dl,0x7d(%eax)
80107879:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010787c:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107880:	83 ca 0f             	or     $0xf,%edx
80107883:	88 50 7e             	mov    %dl,0x7e(%eax)
80107886:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107889:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010788d:	83 e2 ef             	and    $0xffffffef,%edx
80107890:	88 50 7e             	mov    %dl,0x7e(%eax)
80107893:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107896:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010789a:	83 e2 df             	and    $0xffffffdf,%edx
8010789d:	88 50 7e             	mov    %dl,0x7e(%eax)
801078a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078a3:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801078a7:	83 ca 40             	or     $0x40,%edx
801078aa:	88 50 7e             	mov    %dl,0x7e(%eax)
801078ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078b0:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801078b4:	83 ca 80             	or     $0xffffff80,%edx
801078b7:	88 50 7e             	mov    %dl,0x7e(%eax)
801078ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078bd:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801078c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078c4:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
801078cb:	ff ff 
801078cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078d0:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
801078d7:	00 00 
801078d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078dc:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
801078e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078e6:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801078ed:	83 e2 f0             	and    $0xfffffff0,%edx
801078f0:	83 ca 02             	or     $0x2,%edx
801078f3:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801078f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078fc:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107903:	83 ca 10             	or     $0x10,%edx
80107906:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010790c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010790f:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107916:	83 e2 9f             	and    $0xffffff9f,%edx
80107919:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010791f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107922:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107929:	83 ca 80             	or     $0xffffff80,%edx
8010792c:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107932:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107935:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010793c:	83 ca 0f             	or     $0xf,%edx
8010793f:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107945:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107948:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010794f:	83 e2 ef             	and    $0xffffffef,%edx
80107952:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107958:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010795b:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107962:	83 e2 df             	and    $0xffffffdf,%edx
80107965:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010796b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010796e:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107975:	83 ca 40             	or     $0x40,%edx
80107978:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010797e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107981:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107988:	83 ca 80             	or     $0xffffff80,%edx
8010798b:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107991:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107994:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010799b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010799e:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
801079a5:	ff ff 
801079a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079aa:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
801079b1:	00 00 
801079b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079b6:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
801079bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079c0:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801079c7:	83 e2 f0             	and    $0xfffffff0,%edx
801079ca:	83 ca 0a             	or     $0xa,%edx
801079cd:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801079d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079d6:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801079dd:	83 ca 10             	or     $0x10,%edx
801079e0:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801079e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079e9:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801079f0:	83 ca 60             	or     $0x60,%edx
801079f3:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801079f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079fc:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107a03:	83 ca 80             	or     $0xffffff80,%edx
80107a06:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107a0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a0f:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a16:	83 ca 0f             	or     $0xf,%edx
80107a19:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a22:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a29:	83 e2 ef             	and    $0xffffffef,%edx
80107a2c:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a32:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a35:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a3c:	83 e2 df             	and    $0xffffffdf,%edx
80107a3f:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a48:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a4f:	83 ca 40             	or     $0x40,%edx
80107a52:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a5b:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a62:	83 ca 80             	or     $0xffffff80,%edx
80107a65:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a6e:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107a75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a78:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107a7f:	ff ff 
80107a81:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a84:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107a8b:	00 00 
80107a8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a90:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107a97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a9a:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107aa1:	83 e2 f0             	and    $0xfffffff0,%edx
80107aa4:	83 ca 02             	or     $0x2,%edx
80107aa7:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ab0:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107ab7:	83 ca 10             	or     $0x10,%edx
80107aba:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107ac0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ac3:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107aca:	83 ca 60             	or     $0x60,%edx
80107acd:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107ad3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ad6:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107add:	83 ca 80             	or     $0xffffff80,%edx
80107ae0:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107ae6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ae9:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107af0:	83 ca 0f             	or     $0xf,%edx
80107af3:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107af9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107afc:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b03:	83 e2 ef             	and    $0xffffffef,%edx
80107b06:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b0f:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b16:	83 e2 df             	and    $0xffffffdf,%edx
80107b19:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b22:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b29:	83 ca 40             	or     $0x40,%edx
80107b2c:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b32:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b35:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b3c:	83 ca 80             	or     $0xffffff80,%edx
80107b3f:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b48:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80107b4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b52:	05 b4 00 00 00       	add    $0xb4,%eax
80107b57:	89 c3                	mov    %eax,%ebx
80107b59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b5c:	05 b4 00 00 00       	add    $0xb4,%eax
80107b61:	c1 e8 10             	shr    $0x10,%eax
80107b64:	89 c2                	mov    %eax,%edx
80107b66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b69:	05 b4 00 00 00       	add    $0xb4,%eax
80107b6e:	c1 e8 18             	shr    $0x18,%eax
80107b71:	89 c1                	mov    %eax,%ecx
80107b73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b76:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107b7d:	00 00 
80107b7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b82:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107b89:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b8c:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80107b92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b95:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107b9c:	83 e2 f0             	and    $0xfffffff0,%edx
80107b9f:	83 ca 02             	or     $0x2,%edx
80107ba2:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bab:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107bb2:	83 ca 10             	or     $0x10,%edx
80107bb5:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107bbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bbe:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107bc5:	83 e2 9f             	and    $0xffffff9f,%edx
80107bc8:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107bce:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd1:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107bd8:	83 ca 80             	or     $0xffffff80,%edx
80107bdb:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107be1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107be4:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107beb:	83 e2 f0             	and    $0xfffffff0,%edx
80107bee:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107bf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bf7:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107bfe:	83 e2 ef             	and    $0xffffffef,%edx
80107c01:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c07:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c0a:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107c11:	83 e2 df             	and    $0xffffffdf,%edx
80107c14:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c1d:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107c24:	83 ca 40             	or     $0x40,%edx
80107c27:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c30:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107c37:	83 ca 80             	or     $0xffffff80,%edx
80107c3a:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c43:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80107c49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c4c:	83 c0 70             	add    $0x70,%eax
80107c4f:	83 ec 08             	sub    $0x8,%esp
80107c52:	6a 38                	push   $0x38
80107c54:	50                   	push   %eax
80107c55:	e8 3c fb ff ff       	call   80107796 <lgdt>
80107c5a:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
80107c5d:	83 ec 0c             	sub    $0xc,%esp
80107c60:	6a 18                	push   $0x18
80107c62:	e8 6e fb ff ff       	call   801077d5 <loadgs>
80107c67:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
80107c6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c6d:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80107c73:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107c7a:	00 00 00 00 
}
80107c7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107c81:	c9                   	leave  
80107c82:	c3                   	ret    

80107c83 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107c83:	55                   	push   %ebp
80107c84:	89 e5                	mov    %esp,%ebp
80107c86:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107c89:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c8c:	c1 e8 16             	shr    $0x16,%eax
80107c8f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107c96:	8b 45 08             	mov    0x8(%ebp),%eax
80107c99:	01 d0                	add    %edx,%eax
80107c9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107c9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ca1:	8b 00                	mov    (%eax),%eax
80107ca3:	83 e0 01             	and    $0x1,%eax
80107ca6:	85 c0                	test   %eax,%eax
80107ca8:	74 18                	je     80107cc2 <walkpgdir+0x3f>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107caa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107cad:	8b 00                	mov    (%eax),%eax
80107caf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107cb4:	50                   	push   %eax
80107cb5:	e8 48 fb ff ff       	call   80107802 <p2v>
80107cba:	83 c4 04             	add    $0x4,%esp
80107cbd:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107cc0:	eb 48                	jmp    80107d0a <walkpgdir+0x87>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107cc2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107cc6:	74 0e                	je     80107cd6 <walkpgdir+0x53>
80107cc8:	e8 0c b2 ff ff       	call   80102ed9 <kalloc>
80107ccd:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107cd0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107cd4:	75 07                	jne    80107cdd <walkpgdir+0x5a>
      return 0;
80107cd6:	b8 00 00 00 00       	mov    $0x0,%eax
80107cdb:	eb 44                	jmp    80107d21 <walkpgdir+0x9e>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107cdd:	83 ec 04             	sub    $0x4,%esp
80107ce0:	68 00 10 00 00       	push   $0x1000
80107ce5:	6a 00                	push   $0x0
80107ce7:	ff 75 f4             	pushl  -0xc(%ebp)
80107cea:	e8 33 d4 ff ff       	call   80105122 <memset>
80107cef:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107cf2:	83 ec 0c             	sub    $0xc,%esp
80107cf5:	ff 75 f4             	pushl  -0xc(%ebp)
80107cf8:	e8 f8 fa ff ff       	call   801077f5 <v2p>
80107cfd:	83 c4 10             	add    $0x10,%esp
80107d00:	83 c8 07             	or     $0x7,%eax
80107d03:	89 c2                	mov    %eax,%edx
80107d05:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107d08:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107d0a:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d0d:	c1 e8 0c             	shr    $0xc,%eax
80107d10:	25 ff 03 00 00       	and    $0x3ff,%eax
80107d15:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107d1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d1f:	01 d0                	add    %edx,%eax
}
80107d21:	c9                   	leave  
80107d22:	c3                   	ret    

80107d23 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107d23:	55                   	push   %ebp
80107d24:	89 e5                	mov    %esp,%ebp
80107d26:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107d29:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d2c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d31:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107d34:	8b 55 0c             	mov    0xc(%ebp),%edx
80107d37:	8b 45 10             	mov    0x10(%ebp),%eax
80107d3a:	01 d0                	add    %edx,%eax
80107d3c:	83 e8 01             	sub    $0x1,%eax
80107d3f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d44:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107d47:	83 ec 04             	sub    $0x4,%esp
80107d4a:	6a 01                	push   $0x1
80107d4c:	ff 75 f4             	pushl  -0xc(%ebp)
80107d4f:	ff 75 08             	pushl  0x8(%ebp)
80107d52:	e8 2c ff ff ff       	call   80107c83 <walkpgdir>
80107d57:	83 c4 10             	add    $0x10,%esp
80107d5a:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107d5d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107d61:	75 07                	jne    80107d6a <mappages+0x47>
      return -1;
80107d63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107d68:	eb 49                	jmp    80107db3 <mappages+0x90>
    if(*pte & PTE_P)
80107d6a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107d6d:	8b 00                	mov    (%eax),%eax
80107d6f:	83 e0 01             	and    $0x1,%eax
80107d72:	85 c0                	test   %eax,%eax
80107d74:	74 0d                	je     80107d83 <mappages+0x60>
      panic("remap");
80107d76:	83 ec 0c             	sub    $0xc,%esp
80107d79:	68 b0 8b 10 80       	push   $0x80108bb0
80107d7e:	e8 d9 87 ff ff       	call   8010055c <panic>
    *pte = pa | perm | PTE_P;
80107d83:	8b 45 18             	mov    0x18(%ebp),%eax
80107d86:	0b 45 14             	or     0x14(%ebp),%eax
80107d89:	83 c8 01             	or     $0x1,%eax
80107d8c:	89 c2                	mov    %eax,%edx
80107d8e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107d91:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107d93:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d96:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107d99:	75 08                	jne    80107da3 <mappages+0x80>
      break;
80107d9b:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107d9c:	b8 00 00 00 00       	mov    $0x0,%eax
80107da1:	eb 10                	jmp    80107db3 <mappages+0x90>
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
80107da3:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107daa:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80107db1:	eb 94                	jmp    80107d47 <mappages+0x24>
  return 0;
}
80107db3:	c9                   	leave  
80107db4:	c3                   	ret    

80107db5 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107db5:	55                   	push   %ebp
80107db6:	89 e5                	mov    %esp,%ebp
80107db8:	53                   	push   %ebx
80107db9:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107dbc:	e8 18 b1 ff ff       	call   80102ed9 <kalloc>
80107dc1:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107dc4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107dc8:	75 0a                	jne    80107dd4 <setupkvm+0x1f>
    return 0;
80107dca:	b8 00 00 00 00       	mov    $0x0,%eax
80107dcf:	e9 8e 00 00 00       	jmp    80107e62 <setupkvm+0xad>
  memset(pgdir, 0, PGSIZE);
80107dd4:	83 ec 04             	sub    $0x4,%esp
80107dd7:	68 00 10 00 00       	push   $0x1000
80107ddc:	6a 00                	push   $0x0
80107dde:	ff 75 f0             	pushl  -0x10(%ebp)
80107de1:	e8 3c d3 ff ff       	call   80105122 <memset>
80107de6:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107de9:	83 ec 0c             	sub    $0xc,%esp
80107dec:	68 00 00 00 0e       	push   $0xe000000
80107df1:	e8 0c fa ff ff       	call   80107802 <p2v>
80107df6:	83 c4 10             	add    $0x10,%esp
80107df9:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80107dfe:	76 0d                	jbe    80107e0d <setupkvm+0x58>
    panic("PHYSTOP too high");
80107e00:	83 ec 0c             	sub    $0xc,%esp
80107e03:	68 b6 8b 10 80       	push   $0x80108bb6
80107e08:	e8 4f 87 ff ff       	call   8010055c <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107e0d:	c7 45 f4 c0 b4 10 80 	movl   $0x8010b4c0,-0xc(%ebp)
80107e14:	eb 40                	jmp    80107e56 <setupkvm+0xa1>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107e16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e19:	8b 48 0c             	mov    0xc(%eax),%ecx
80107e1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e1f:	8b 50 04             	mov    0x4(%eax),%edx
80107e22:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e25:	8b 58 08             	mov    0x8(%eax),%ebx
80107e28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e2b:	8b 40 04             	mov    0x4(%eax),%eax
80107e2e:	29 c3                	sub    %eax,%ebx
80107e30:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e33:	8b 00                	mov    (%eax),%eax
80107e35:	83 ec 0c             	sub    $0xc,%esp
80107e38:	51                   	push   %ecx
80107e39:	52                   	push   %edx
80107e3a:	53                   	push   %ebx
80107e3b:	50                   	push   %eax
80107e3c:	ff 75 f0             	pushl  -0x10(%ebp)
80107e3f:	e8 df fe ff ff       	call   80107d23 <mappages>
80107e44:	83 c4 20             	add    $0x20,%esp
80107e47:	85 c0                	test   %eax,%eax
80107e49:	79 07                	jns    80107e52 <setupkvm+0x9d>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80107e4b:	b8 00 00 00 00       	mov    $0x0,%eax
80107e50:	eb 10                	jmp    80107e62 <setupkvm+0xad>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107e52:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107e56:	81 7d f4 00 b5 10 80 	cmpl   $0x8010b500,-0xc(%ebp)
80107e5d:	72 b7                	jb     80107e16 <setupkvm+0x61>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80107e5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107e62:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107e65:	c9                   	leave  
80107e66:	c3                   	ret    

80107e67 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107e67:	55                   	push   %ebp
80107e68:	89 e5                	mov    %esp,%ebp
80107e6a:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107e6d:	e8 43 ff ff ff       	call   80107db5 <setupkvm>
80107e72:	a3 d8 2c 11 80       	mov    %eax,0x80112cd8
  switchkvm();
80107e77:	e8 02 00 00 00       	call   80107e7e <switchkvm>
}
80107e7c:	c9                   	leave  
80107e7d:	c3                   	ret    

80107e7e <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107e7e:	55                   	push   %ebp
80107e7f:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107e81:	a1 d8 2c 11 80       	mov    0x80112cd8,%eax
80107e86:	50                   	push   %eax
80107e87:	e8 69 f9 ff ff       	call   801077f5 <v2p>
80107e8c:	83 c4 04             	add    $0x4,%esp
80107e8f:	50                   	push   %eax
80107e90:	e8 55 f9 ff ff       	call   801077ea <lcr3>
80107e95:	83 c4 04             	add    $0x4,%esp
}
80107e98:	c9                   	leave  
80107e99:	c3                   	ret    

80107e9a <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107e9a:	55                   	push   %ebp
80107e9b:	89 e5                	mov    %esp,%ebp
80107e9d:	56                   	push   %esi
80107e9e:	53                   	push   %ebx
  pushcli();
80107e9f:	e8 7c d1 ff ff       	call   80105020 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107ea4:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107eaa:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107eb1:	83 c2 08             	add    $0x8,%edx
80107eb4:	89 d6                	mov    %edx,%esi
80107eb6:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107ebd:	83 c2 08             	add    $0x8,%edx
80107ec0:	c1 ea 10             	shr    $0x10,%edx
80107ec3:	89 d3                	mov    %edx,%ebx
80107ec5:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107ecc:	83 c2 08             	add    $0x8,%edx
80107ecf:	c1 ea 18             	shr    $0x18,%edx
80107ed2:	89 d1                	mov    %edx,%ecx
80107ed4:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107edb:	67 00 
80107edd:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
80107ee4:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80107eea:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107ef1:	83 e2 f0             	and    $0xfffffff0,%edx
80107ef4:	83 ca 09             	or     $0x9,%edx
80107ef7:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107efd:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107f04:	83 ca 10             	or     $0x10,%edx
80107f07:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107f0d:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107f14:	83 e2 9f             	and    $0xffffff9f,%edx
80107f17:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107f1d:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107f24:	83 ca 80             	or     $0xffffff80,%edx
80107f27:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107f2d:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f34:	83 e2 f0             	and    $0xfffffff0,%edx
80107f37:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f3d:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f44:	83 e2 ef             	and    $0xffffffef,%edx
80107f47:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f4d:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f54:	83 e2 df             	and    $0xffffffdf,%edx
80107f57:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f5d:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f64:	83 ca 40             	or     $0x40,%edx
80107f67:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f6d:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f74:	83 e2 7f             	and    $0x7f,%edx
80107f77:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f7d:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107f83:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107f89:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107f90:	83 e2 ef             	and    $0xffffffef,%edx
80107f93:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107f99:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107f9f:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80107fa5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107fab:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107fb2:	8b 52 08             	mov    0x8(%edx),%edx
80107fb5:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107fbb:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80107fbe:	83 ec 0c             	sub    $0xc,%esp
80107fc1:	6a 30                	push   $0x30
80107fc3:	e8 f7 f7 ff ff       	call   801077bf <ltr>
80107fc8:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80107fcb:	8b 45 08             	mov    0x8(%ebp),%eax
80107fce:	8b 40 04             	mov    0x4(%eax),%eax
80107fd1:	85 c0                	test   %eax,%eax
80107fd3:	75 0d                	jne    80107fe2 <switchuvm+0x148>
    panic("switchuvm: no pgdir");
80107fd5:	83 ec 0c             	sub    $0xc,%esp
80107fd8:	68 c7 8b 10 80       	push   $0x80108bc7
80107fdd:	e8 7a 85 ff ff       	call   8010055c <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80107fe2:	8b 45 08             	mov    0x8(%ebp),%eax
80107fe5:	8b 40 04             	mov    0x4(%eax),%eax
80107fe8:	83 ec 0c             	sub    $0xc,%esp
80107feb:	50                   	push   %eax
80107fec:	e8 04 f8 ff ff       	call   801077f5 <v2p>
80107ff1:	83 c4 10             	add    $0x10,%esp
80107ff4:	83 ec 0c             	sub    $0xc,%esp
80107ff7:	50                   	push   %eax
80107ff8:	e8 ed f7 ff ff       	call   801077ea <lcr3>
80107ffd:	83 c4 10             	add    $0x10,%esp
  popcli();
80108000:	e8 5f d0 ff ff       	call   80105064 <popcli>
}
80108005:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108008:	5b                   	pop    %ebx
80108009:	5e                   	pop    %esi
8010800a:	5d                   	pop    %ebp
8010800b:	c3                   	ret    

8010800c <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
8010800c:	55                   	push   %ebp
8010800d:	89 e5                	mov    %esp,%ebp
8010800f:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
80108012:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80108019:	76 0d                	jbe    80108028 <inituvm+0x1c>
    panic("inituvm: more than a page");
8010801b:	83 ec 0c             	sub    $0xc,%esp
8010801e:	68 db 8b 10 80       	push   $0x80108bdb
80108023:	e8 34 85 ff ff       	call   8010055c <panic>
  mem = kalloc();
80108028:	e8 ac ae ff ff       	call   80102ed9 <kalloc>
8010802d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80108030:	83 ec 04             	sub    $0x4,%esp
80108033:	68 00 10 00 00       	push   $0x1000
80108038:	6a 00                	push   $0x0
8010803a:	ff 75 f4             	pushl  -0xc(%ebp)
8010803d:	e8 e0 d0 ff ff       	call   80105122 <memset>
80108042:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80108045:	83 ec 0c             	sub    $0xc,%esp
80108048:	ff 75 f4             	pushl  -0xc(%ebp)
8010804b:	e8 a5 f7 ff ff       	call   801077f5 <v2p>
80108050:	83 c4 10             	add    $0x10,%esp
80108053:	83 ec 0c             	sub    $0xc,%esp
80108056:	6a 06                	push   $0x6
80108058:	50                   	push   %eax
80108059:	68 00 10 00 00       	push   $0x1000
8010805e:	6a 00                	push   $0x0
80108060:	ff 75 08             	pushl  0x8(%ebp)
80108063:	e8 bb fc ff ff       	call   80107d23 <mappages>
80108068:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
8010806b:	83 ec 04             	sub    $0x4,%esp
8010806e:	ff 75 10             	pushl  0x10(%ebp)
80108071:	ff 75 0c             	pushl  0xc(%ebp)
80108074:	ff 75 f4             	pushl  -0xc(%ebp)
80108077:	e8 65 d1 ff ff       	call   801051e1 <memmove>
8010807c:	83 c4 10             	add    $0x10,%esp
}
8010807f:	c9                   	leave  
80108080:	c3                   	ret    

80108081 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80108081:	55                   	push   %ebp
80108082:	89 e5                	mov    %esp,%ebp
80108084:	53                   	push   %ebx
80108085:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80108088:	8b 45 0c             	mov    0xc(%ebp),%eax
8010808b:	25 ff 0f 00 00       	and    $0xfff,%eax
80108090:	85 c0                	test   %eax,%eax
80108092:	74 0d                	je     801080a1 <loaduvm+0x20>
    panic("loaduvm: addr must be page aligned");
80108094:	83 ec 0c             	sub    $0xc,%esp
80108097:	68 f8 8b 10 80       	push   $0x80108bf8
8010809c:	e8 bb 84 ff ff       	call   8010055c <panic>
  for(i = 0; i < sz; i += PGSIZE){
801080a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801080a8:	e9 95 00 00 00       	jmp    80108142 <loaduvm+0xc1>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801080ad:	8b 55 0c             	mov    0xc(%ebp),%edx
801080b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080b3:	01 d0                	add    %edx,%eax
801080b5:	83 ec 04             	sub    $0x4,%esp
801080b8:	6a 00                	push   $0x0
801080ba:	50                   	push   %eax
801080bb:	ff 75 08             	pushl  0x8(%ebp)
801080be:	e8 c0 fb ff ff       	call   80107c83 <walkpgdir>
801080c3:	83 c4 10             	add    $0x10,%esp
801080c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
801080c9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801080cd:	75 0d                	jne    801080dc <loaduvm+0x5b>
      panic("loaduvm: address should exist");
801080cf:	83 ec 0c             	sub    $0xc,%esp
801080d2:	68 1b 8c 10 80       	push   $0x80108c1b
801080d7:	e8 80 84 ff ff       	call   8010055c <panic>
    pa = PTE_ADDR(*pte);
801080dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
801080df:	8b 00                	mov    (%eax),%eax
801080e1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080e6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
801080e9:	8b 45 18             	mov    0x18(%ebp),%eax
801080ec:	2b 45 f4             	sub    -0xc(%ebp),%eax
801080ef:	3d ff 0f 00 00       	cmp    $0xfff,%eax
801080f4:	77 0b                	ja     80108101 <loaduvm+0x80>
      n = sz - i;
801080f6:	8b 45 18             	mov    0x18(%ebp),%eax
801080f9:	2b 45 f4             	sub    -0xc(%ebp),%eax
801080fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
801080ff:	eb 07                	jmp    80108108 <loaduvm+0x87>
    else
      n = PGSIZE;
80108101:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80108108:	8b 55 14             	mov    0x14(%ebp),%edx
8010810b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010810e:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80108111:	83 ec 0c             	sub    $0xc,%esp
80108114:	ff 75 e8             	pushl  -0x18(%ebp)
80108117:	e8 e6 f6 ff ff       	call   80107802 <p2v>
8010811c:	83 c4 10             	add    $0x10,%esp
8010811f:	ff 75 f0             	pushl  -0x10(%ebp)
80108122:	53                   	push   %ebx
80108123:	50                   	push   %eax
80108124:	ff 75 10             	pushl  0x10(%ebp)
80108127:	e8 58 a0 ff ff       	call   80102184 <readi>
8010812c:	83 c4 10             	add    $0x10,%esp
8010812f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80108132:	74 07                	je     8010813b <loaduvm+0xba>
      return -1;
80108134:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108139:	eb 18                	jmp    80108153 <loaduvm+0xd2>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
8010813b:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108142:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108145:	3b 45 18             	cmp    0x18(%ebp),%eax
80108148:	0f 82 5f ff ff ff    	jb     801080ad <loaduvm+0x2c>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
8010814e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108153:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108156:	c9                   	leave  
80108157:	c3                   	ret    

80108158 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108158:	55                   	push   %ebp
80108159:	89 e5                	mov    %esp,%ebp
8010815b:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010815e:	8b 45 10             	mov    0x10(%ebp),%eax
80108161:	85 c0                	test   %eax,%eax
80108163:	79 0a                	jns    8010816f <allocuvm+0x17>
    return 0;
80108165:	b8 00 00 00 00       	mov    $0x0,%eax
8010816a:	e9 b0 00 00 00       	jmp    8010821f <allocuvm+0xc7>
  if(newsz < oldsz)
8010816f:	8b 45 10             	mov    0x10(%ebp),%eax
80108172:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108175:	73 08                	jae    8010817f <allocuvm+0x27>
    return oldsz;
80108177:	8b 45 0c             	mov    0xc(%ebp),%eax
8010817a:	e9 a0 00 00 00       	jmp    8010821f <allocuvm+0xc7>

  a = PGROUNDUP(oldsz);
8010817f:	8b 45 0c             	mov    0xc(%ebp),%eax
80108182:	05 ff 0f 00 00       	add    $0xfff,%eax
80108187:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010818c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
8010818f:	eb 7f                	jmp    80108210 <allocuvm+0xb8>
    mem = kalloc();
80108191:	e8 43 ad ff ff       	call   80102ed9 <kalloc>
80108196:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80108199:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010819d:	75 2b                	jne    801081ca <allocuvm+0x72>
      cprintf("allocuvm out of memory\n");
8010819f:	83 ec 0c             	sub    $0xc,%esp
801081a2:	68 39 8c 10 80       	push   $0x80108c39
801081a7:	e8 13 82 ff ff       	call   801003bf <cprintf>
801081ac:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
801081af:	83 ec 04             	sub    $0x4,%esp
801081b2:	ff 75 0c             	pushl  0xc(%ebp)
801081b5:	ff 75 10             	pushl  0x10(%ebp)
801081b8:	ff 75 08             	pushl  0x8(%ebp)
801081bb:	e8 61 00 00 00       	call   80108221 <deallocuvm>
801081c0:	83 c4 10             	add    $0x10,%esp
      return 0;
801081c3:	b8 00 00 00 00       	mov    $0x0,%eax
801081c8:	eb 55                	jmp    8010821f <allocuvm+0xc7>
    }
    memset(mem, 0, PGSIZE);
801081ca:	83 ec 04             	sub    $0x4,%esp
801081cd:	68 00 10 00 00       	push   $0x1000
801081d2:	6a 00                	push   $0x0
801081d4:	ff 75 f0             	pushl  -0x10(%ebp)
801081d7:	e8 46 cf ff ff       	call   80105122 <memset>
801081dc:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
801081df:	83 ec 0c             	sub    $0xc,%esp
801081e2:	ff 75 f0             	pushl  -0x10(%ebp)
801081e5:	e8 0b f6 ff ff       	call   801077f5 <v2p>
801081ea:	83 c4 10             	add    $0x10,%esp
801081ed:	89 c2                	mov    %eax,%edx
801081ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081f2:	83 ec 0c             	sub    $0xc,%esp
801081f5:	6a 06                	push   $0x6
801081f7:	52                   	push   %edx
801081f8:	68 00 10 00 00       	push   $0x1000
801081fd:	50                   	push   %eax
801081fe:	ff 75 08             	pushl  0x8(%ebp)
80108201:	e8 1d fb ff ff       	call   80107d23 <mappages>
80108206:	83 c4 20             	add    $0x20,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80108209:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108210:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108213:	3b 45 10             	cmp    0x10(%ebp),%eax
80108216:	0f 82 75 ff ff ff    	jb     80108191 <allocuvm+0x39>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
8010821c:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010821f:	c9                   	leave  
80108220:	c3                   	ret    

80108221 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108221:	55                   	push   %ebp
80108222:	89 e5                	mov    %esp,%ebp
80108224:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80108227:	8b 45 10             	mov    0x10(%ebp),%eax
8010822a:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010822d:	72 08                	jb     80108237 <deallocuvm+0x16>
    return oldsz;
8010822f:	8b 45 0c             	mov    0xc(%ebp),%eax
80108232:	e9 a5 00 00 00       	jmp    801082dc <deallocuvm+0xbb>

  a = PGROUNDUP(newsz);
80108237:	8b 45 10             	mov    0x10(%ebp),%eax
8010823a:	05 ff 0f 00 00       	add    $0xfff,%eax
8010823f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108244:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108247:	e9 81 00 00 00       	jmp    801082cd <deallocuvm+0xac>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010824c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010824f:	83 ec 04             	sub    $0x4,%esp
80108252:	6a 00                	push   $0x0
80108254:	50                   	push   %eax
80108255:	ff 75 08             	pushl  0x8(%ebp)
80108258:	e8 26 fa ff ff       	call   80107c83 <walkpgdir>
8010825d:	83 c4 10             	add    $0x10,%esp
80108260:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80108263:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108267:	75 09                	jne    80108272 <deallocuvm+0x51>
      a += (NPTENTRIES - 1) * PGSIZE;
80108269:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
80108270:	eb 54                	jmp    801082c6 <deallocuvm+0xa5>
    else if((*pte & PTE_P) != 0){
80108272:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108275:	8b 00                	mov    (%eax),%eax
80108277:	83 e0 01             	and    $0x1,%eax
8010827a:	85 c0                	test   %eax,%eax
8010827c:	74 48                	je     801082c6 <deallocuvm+0xa5>
      pa = PTE_ADDR(*pte);
8010827e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108281:	8b 00                	mov    (%eax),%eax
80108283:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108288:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
8010828b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010828f:	75 0d                	jne    8010829e <deallocuvm+0x7d>
        panic("kfree");
80108291:	83 ec 0c             	sub    $0xc,%esp
80108294:	68 51 8c 10 80       	push   $0x80108c51
80108299:	e8 be 82 ff ff       	call   8010055c <panic>
      char *v = p2v(pa);
8010829e:	83 ec 0c             	sub    $0xc,%esp
801082a1:	ff 75 ec             	pushl  -0x14(%ebp)
801082a4:	e8 59 f5 ff ff       	call   80107802 <p2v>
801082a9:	83 c4 10             	add    $0x10,%esp
801082ac:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
801082af:	83 ec 0c             	sub    $0xc,%esp
801082b2:	ff 75 e8             	pushl  -0x18(%ebp)
801082b5:	e8 83 ab ff ff       	call   80102e3d <kfree>
801082ba:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
801082bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801082c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801082c6:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801082cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082d0:	3b 45 0c             	cmp    0xc(%ebp),%eax
801082d3:	0f 82 73 ff ff ff    	jb     8010824c <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
801082d9:	8b 45 10             	mov    0x10(%ebp),%eax
}
801082dc:	c9                   	leave  
801082dd:	c3                   	ret    

801082de <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801082de:	55                   	push   %ebp
801082df:	89 e5                	mov    %esp,%ebp
801082e1:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
801082e4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801082e8:	75 0d                	jne    801082f7 <freevm+0x19>
    panic("freevm: no pgdir");
801082ea:	83 ec 0c             	sub    $0xc,%esp
801082ed:	68 57 8c 10 80       	push   $0x80108c57
801082f2:	e8 65 82 ff ff       	call   8010055c <panic>
  deallocuvm(pgdir, KERNBASE, 0);
801082f7:	83 ec 04             	sub    $0x4,%esp
801082fa:	6a 00                	push   $0x0
801082fc:	68 00 00 00 80       	push   $0x80000000
80108301:	ff 75 08             	pushl  0x8(%ebp)
80108304:	e8 18 ff ff ff       	call   80108221 <deallocuvm>
80108309:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
8010830c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108313:	eb 4f                	jmp    80108364 <freevm+0x86>
    if(pgdir[i] & PTE_P){
80108315:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108318:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010831f:	8b 45 08             	mov    0x8(%ebp),%eax
80108322:	01 d0                	add    %edx,%eax
80108324:	8b 00                	mov    (%eax),%eax
80108326:	83 e0 01             	and    $0x1,%eax
80108329:	85 c0                	test   %eax,%eax
8010832b:	74 33                	je     80108360 <freevm+0x82>
      char * v = p2v(PTE_ADDR(pgdir[i]));
8010832d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108330:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108337:	8b 45 08             	mov    0x8(%ebp),%eax
8010833a:	01 d0                	add    %edx,%eax
8010833c:	8b 00                	mov    (%eax),%eax
8010833e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108343:	83 ec 0c             	sub    $0xc,%esp
80108346:	50                   	push   %eax
80108347:	e8 b6 f4 ff ff       	call   80107802 <p2v>
8010834c:	83 c4 10             	add    $0x10,%esp
8010834f:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
80108352:	83 ec 0c             	sub    $0xc,%esp
80108355:	ff 75 f0             	pushl  -0x10(%ebp)
80108358:	e8 e0 aa ff ff       	call   80102e3d <kfree>
8010835d:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108360:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108364:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
8010836b:	76 a8                	jbe    80108315 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
8010836d:	83 ec 0c             	sub    $0xc,%esp
80108370:	ff 75 08             	pushl  0x8(%ebp)
80108373:	e8 c5 aa ff ff       	call   80102e3d <kfree>
80108378:	83 c4 10             	add    $0x10,%esp
}
8010837b:	c9                   	leave  
8010837c:	c3                   	ret    

8010837d <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
8010837d:	55                   	push   %ebp
8010837e:	89 e5                	mov    %esp,%ebp
80108380:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108383:	83 ec 04             	sub    $0x4,%esp
80108386:	6a 00                	push   $0x0
80108388:	ff 75 0c             	pushl  0xc(%ebp)
8010838b:	ff 75 08             	pushl  0x8(%ebp)
8010838e:	e8 f0 f8 ff ff       	call   80107c83 <walkpgdir>
80108393:	83 c4 10             	add    $0x10,%esp
80108396:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
80108399:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010839d:	75 0d                	jne    801083ac <clearpteu+0x2f>
    panic("clearpteu");
8010839f:	83 ec 0c             	sub    $0xc,%esp
801083a2:	68 68 8c 10 80       	push   $0x80108c68
801083a7:	e8 b0 81 ff ff       	call   8010055c <panic>
  *pte &= ~PTE_U;
801083ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083af:	8b 00                	mov    (%eax),%eax
801083b1:	83 e0 fb             	and    $0xfffffffb,%eax
801083b4:	89 c2                	mov    %eax,%edx
801083b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083b9:	89 10                	mov    %edx,(%eax)
}
801083bb:	c9                   	leave  
801083bc:	c3                   	ret    

801083bd <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801083bd:	55                   	push   %ebp
801083be:	89 e5                	mov    %esp,%ebp
801083c0:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
801083c3:	e8 ed f9 ff ff       	call   80107db5 <setupkvm>
801083c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
801083cb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801083cf:	75 0a                	jne    801083db <copyuvm+0x1e>
    return 0;
801083d1:	b8 00 00 00 00       	mov    $0x0,%eax
801083d6:	e9 e9 00 00 00       	jmp    801084c4 <copyuvm+0x107>
  for(i = 0; i < sz; i += PGSIZE){
801083db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801083e2:	e9 b9 00 00 00       	jmp    801084a0 <copyuvm+0xe3>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801083e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083ea:	83 ec 04             	sub    $0x4,%esp
801083ed:	6a 00                	push   $0x0
801083ef:	50                   	push   %eax
801083f0:	ff 75 08             	pushl  0x8(%ebp)
801083f3:	e8 8b f8 ff ff       	call   80107c83 <walkpgdir>
801083f8:	83 c4 10             	add    $0x10,%esp
801083fb:	89 45 ec             	mov    %eax,-0x14(%ebp)
801083fe:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108402:	75 0d                	jne    80108411 <copyuvm+0x54>
      panic("copyuvm: pte should exist");
80108404:	83 ec 0c             	sub    $0xc,%esp
80108407:	68 72 8c 10 80       	push   $0x80108c72
8010840c:	e8 4b 81 ff ff       	call   8010055c <panic>
    if(!(*pte & PTE_P))
80108411:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108414:	8b 00                	mov    (%eax),%eax
80108416:	83 e0 01             	and    $0x1,%eax
80108419:	85 c0                	test   %eax,%eax
8010841b:	75 0d                	jne    8010842a <copyuvm+0x6d>
      panic("copyuvm: page not present");
8010841d:	83 ec 0c             	sub    $0xc,%esp
80108420:	68 8c 8c 10 80       	push   $0x80108c8c
80108425:	e8 32 81 ff ff       	call   8010055c <panic>
    pa = PTE_ADDR(*pte);
8010842a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010842d:	8b 00                	mov    (%eax),%eax
8010842f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108434:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if((mem = kalloc()) == 0)
80108437:	e8 9d aa ff ff       	call   80102ed9 <kalloc>
8010843c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010843f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80108443:	75 02                	jne    80108447 <copyuvm+0x8a>
      goto bad;
80108445:	eb 6a                	jmp    801084b1 <copyuvm+0xf4>
    memmove(mem, (char*)p2v(pa), PGSIZE);
80108447:	83 ec 0c             	sub    $0xc,%esp
8010844a:	ff 75 e8             	pushl  -0x18(%ebp)
8010844d:	e8 b0 f3 ff ff       	call   80107802 <p2v>
80108452:	83 c4 10             	add    $0x10,%esp
80108455:	83 ec 04             	sub    $0x4,%esp
80108458:	68 00 10 00 00       	push   $0x1000
8010845d:	50                   	push   %eax
8010845e:	ff 75 e4             	pushl  -0x1c(%ebp)
80108461:	e8 7b cd ff ff       	call   801051e1 <memmove>
80108466:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
80108469:	83 ec 0c             	sub    $0xc,%esp
8010846c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010846f:	e8 81 f3 ff ff       	call   801077f5 <v2p>
80108474:	83 c4 10             	add    $0x10,%esp
80108477:	89 c2                	mov    %eax,%edx
80108479:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010847c:	83 ec 0c             	sub    $0xc,%esp
8010847f:	6a 06                	push   $0x6
80108481:	52                   	push   %edx
80108482:	68 00 10 00 00       	push   $0x1000
80108487:	50                   	push   %eax
80108488:	ff 75 f0             	pushl  -0x10(%ebp)
8010848b:	e8 93 f8 ff ff       	call   80107d23 <mappages>
80108490:	83 c4 20             	add    $0x20,%esp
80108493:	85 c0                	test   %eax,%eax
80108495:	79 02                	jns    80108499 <copyuvm+0xdc>
      goto bad;
80108497:	eb 18                	jmp    801084b1 <copyuvm+0xf4>
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108499:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801084a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084a3:	3b 45 0c             	cmp    0xc(%ebp),%eax
801084a6:	0f 82 3b ff ff ff    	jb     801083e7 <copyuvm+0x2a>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
  }
  return d;
801084ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801084af:	eb 13                	jmp    801084c4 <copyuvm+0x107>

bad:
  freevm(d);
801084b1:	83 ec 0c             	sub    $0xc,%esp
801084b4:	ff 75 f0             	pushl  -0x10(%ebp)
801084b7:	e8 22 fe ff ff       	call   801082de <freevm>
801084bc:	83 c4 10             	add    $0x10,%esp
  return 0;
801084bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
801084c4:	c9                   	leave  
801084c5:	c3                   	ret    

801084c6 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801084c6:	55                   	push   %ebp
801084c7:	89 e5                	mov    %esp,%ebp
801084c9:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801084cc:	83 ec 04             	sub    $0x4,%esp
801084cf:	6a 00                	push   $0x0
801084d1:	ff 75 0c             	pushl  0xc(%ebp)
801084d4:	ff 75 08             	pushl  0x8(%ebp)
801084d7:	e8 a7 f7 ff ff       	call   80107c83 <walkpgdir>
801084dc:	83 c4 10             	add    $0x10,%esp
801084df:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
801084e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084e5:	8b 00                	mov    (%eax),%eax
801084e7:	83 e0 01             	and    $0x1,%eax
801084ea:	85 c0                	test   %eax,%eax
801084ec:	75 07                	jne    801084f5 <uva2ka+0x2f>
    return 0;
801084ee:	b8 00 00 00 00       	mov    $0x0,%eax
801084f3:	eb 29                	jmp    8010851e <uva2ka+0x58>
  if((*pte & PTE_U) == 0)
801084f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084f8:	8b 00                	mov    (%eax),%eax
801084fa:	83 e0 04             	and    $0x4,%eax
801084fd:	85 c0                	test   %eax,%eax
801084ff:	75 07                	jne    80108508 <uva2ka+0x42>
    return 0;
80108501:	b8 00 00 00 00       	mov    $0x0,%eax
80108506:	eb 16                	jmp    8010851e <uva2ka+0x58>
  return (char*)p2v(PTE_ADDR(*pte));
80108508:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010850b:	8b 00                	mov    (%eax),%eax
8010850d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108512:	83 ec 0c             	sub    $0xc,%esp
80108515:	50                   	push   %eax
80108516:	e8 e7 f2 ff ff       	call   80107802 <p2v>
8010851b:	83 c4 10             	add    $0x10,%esp
}
8010851e:	c9                   	leave  
8010851f:	c3                   	ret    

80108520 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108520:	55                   	push   %ebp
80108521:	89 e5                	mov    %esp,%ebp
80108523:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
80108526:	8b 45 10             	mov    0x10(%ebp),%eax
80108529:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
8010852c:	eb 7f                	jmp    801085ad <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
8010852e:	8b 45 0c             	mov    0xc(%ebp),%eax
80108531:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108536:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108539:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010853c:	83 ec 08             	sub    $0x8,%esp
8010853f:	50                   	push   %eax
80108540:	ff 75 08             	pushl  0x8(%ebp)
80108543:	e8 7e ff ff ff       	call   801084c6 <uva2ka>
80108548:	83 c4 10             	add    $0x10,%esp
8010854b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
8010854e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80108552:	75 07                	jne    8010855b <copyout+0x3b>
      return -1;
80108554:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108559:	eb 61                	jmp    801085bc <copyout+0x9c>
    n = PGSIZE - (va - va0);
8010855b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010855e:	2b 45 0c             	sub    0xc(%ebp),%eax
80108561:	05 00 10 00 00       	add    $0x1000,%eax
80108566:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
80108569:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010856c:	3b 45 14             	cmp    0x14(%ebp),%eax
8010856f:	76 06                	jbe    80108577 <copyout+0x57>
      n = len;
80108571:	8b 45 14             	mov    0x14(%ebp),%eax
80108574:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
80108577:	8b 45 0c             	mov    0xc(%ebp),%eax
8010857a:	2b 45 ec             	sub    -0x14(%ebp),%eax
8010857d:	89 c2                	mov    %eax,%edx
8010857f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108582:	01 d0                	add    %edx,%eax
80108584:	83 ec 04             	sub    $0x4,%esp
80108587:	ff 75 f0             	pushl  -0x10(%ebp)
8010858a:	ff 75 f4             	pushl  -0xc(%ebp)
8010858d:	50                   	push   %eax
8010858e:	e8 4e cc ff ff       	call   801051e1 <memmove>
80108593:	83 c4 10             	add    $0x10,%esp
    len -= n;
80108596:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108599:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
8010859c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010859f:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
801085a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801085a5:	05 00 10 00 00       	add    $0x1000,%eax
801085aa:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801085ad:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801085b1:	0f 85 77 ff ff ff    	jne    8010852e <copyout+0xe>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801085b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
801085bc:	c9                   	leave  
801085bd:	c3                   	ret    
