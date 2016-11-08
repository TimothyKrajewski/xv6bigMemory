
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 63 02 00 00       	call   279 <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 ed 02 00 00       	call   311 <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit();
  27:	e8 55 02 00 00       	call   281 <exit>

0000002c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  2c:	55                   	push   %ebp
  2d:	89 e5                	mov    %esp,%ebp
  2f:	57                   	push   %edi
  30:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  31:	8b 4d 08             	mov    0x8(%ebp),%ecx
  34:	8b 55 10             	mov    0x10(%ebp),%edx
  37:	8b 45 0c             	mov    0xc(%ebp),%eax
  3a:	89 cb                	mov    %ecx,%ebx
  3c:	89 df                	mov    %ebx,%edi
  3e:	89 d1                	mov    %edx,%ecx
  40:	fc                   	cld    
  41:	f3 aa                	rep stos %al,%es:(%edi)
  43:	89 ca                	mov    %ecx,%edx
  45:	89 fb                	mov    %edi,%ebx
  47:	89 5d 08             	mov    %ebx,0x8(%ebp)
  4a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  4d:	5b                   	pop    %ebx
  4e:	5f                   	pop    %edi
  4f:	5d                   	pop    %ebp
  50:	c3                   	ret    

00000051 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  51:	55                   	push   %ebp
  52:	89 e5                	mov    %esp,%ebp
  54:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  57:	8b 45 08             	mov    0x8(%ebp),%eax
  5a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  5d:	90                   	nop
  5e:	8b 45 08             	mov    0x8(%ebp),%eax
  61:	8d 50 01             	lea    0x1(%eax),%edx
  64:	89 55 08             	mov    %edx,0x8(%ebp)
  67:	8b 55 0c             	mov    0xc(%ebp),%edx
  6a:	8d 4a 01             	lea    0x1(%edx),%ecx
  6d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  70:	0f b6 12             	movzbl (%edx),%edx
  73:	88 10                	mov    %dl,(%eax)
  75:	0f b6 00             	movzbl (%eax),%eax
  78:	84 c0                	test   %al,%al
  7a:	75 e2                	jne    5e <strcpy+0xd>
    ;
  return os;
  7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  7f:	c9                   	leave  
  80:	c3                   	ret    

00000081 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  81:	55                   	push   %ebp
  82:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  84:	eb 08                	jmp    8e <strcmp+0xd>
    p++, q++;
  86:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  8a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  8e:	8b 45 08             	mov    0x8(%ebp),%eax
  91:	0f b6 00             	movzbl (%eax),%eax
  94:	84 c0                	test   %al,%al
  96:	74 10                	je     a8 <strcmp+0x27>
  98:	8b 45 08             	mov    0x8(%ebp),%eax
  9b:	0f b6 10             	movzbl (%eax),%edx
  9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  a1:	0f b6 00             	movzbl (%eax),%eax
  a4:	38 c2                	cmp    %al,%dl
  a6:	74 de                	je     86 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a8:	8b 45 08             	mov    0x8(%ebp),%eax
  ab:	0f b6 00             	movzbl (%eax),%eax
  ae:	0f b6 d0             	movzbl %al,%edx
  b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  b4:	0f b6 00             	movzbl (%eax),%eax
  b7:	0f b6 c0             	movzbl %al,%eax
  ba:	29 c2                	sub    %eax,%edx
  bc:	89 d0                	mov    %edx,%eax
}
  be:	5d                   	pop    %ebp
  bf:	c3                   	ret    

000000c0 <strlen>:

uint
strlen(char *s)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  cd:	eb 04                	jmp    d3 <strlen+0x13>
  cf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  d6:	8b 45 08             	mov    0x8(%ebp),%eax
  d9:	01 d0                	add    %edx,%eax
  db:	0f b6 00             	movzbl (%eax),%eax
  de:	84 c0                	test   %al,%al
  e0:	75 ed                	jne    cf <strlen+0xf>
    ;
  return n;
  e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e5:	c9                   	leave  
  e6:	c3                   	ret    

000000e7 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e7:	55                   	push   %ebp
  e8:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  ea:	8b 45 10             	mov    0x10(%ebp),%eax
  ed:	50                   	push   %eax
  ee:	ff 75 0c             	pushl  0xc(%ebp)
  f1:	ff 75 08             	pushl  0x8(%ebp)
  f4:	e8 33 ff ff ff       	call   2c <stosb>
  f9:	83 c4 0c             	add    $0xc,%esp
  return dst;
  fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  ff:	c9                   	leave  
 100:	c3                   	ret    

00000101 <strchr>:

char*
strchr(const char *s, char c)
{
 101:	55                   	push   %ebp
 102:	89 e5                	mov    %esp,%ebp
 104:	83 ec 04             	sub    $0x4,%esp
 107:	8b 45 0c             	mov    0xc(%ebp),%eax
 10a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 10d:	eb 14                	jmp    123 <strchr+0x22>
    if(*s == c)
 10f:	8b 45 08             	mov    0x8(%ebp),%eax
 112:	0f b6 00             	movzbl (%eax),%eax
 115:	3a 45 fc             	cmp    -0x4(%ebp),%al
 118:	75 05                	jne    11f <strchr+0x1e>
      return (char*)s;
 11a:	8b 45 08             	mov    0x8(%ebp),%eax
 11d:	eb 13                	jmp    132 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 11f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 123:	8b 45 08             	mov    0x8(%ebp),%eax
 126:	0f b6 00             	movzbl (%eax),%eax
 129:	84 c0                	test   %al,%al
 12b:	75 e2                	jne    10f <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 12d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 132:	c9                   	leave  
 133:	c3                   	ret    

00000134 <gets>:

char*
gets(char *buf, int max)
{
 134:	55                   	push   %ebp
 135:	89 e5                	mov    %esp,%ebp
 137:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 141:	eb 44                	jmp    187 <gets+0x53>
    cc = read(0, &c, 1);
 143:	83 ec 04             	sub    $0x4,%esp
 146:	6a 01                	push   $0x1
 148:	8d 45 ef             	lea    -0x11(%ebp),%eax
 14b:	50                   	push   %eax
 14c:	6a 00                	push   $0x0
 14e:	e8 46 01 00 00       	call   299 <read>
 153:	83 c4 10             	add    $0x10,%esp
 156:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 159:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 15d:	7f 02                	jg     161 <gets+0x2d>
      break;
 15f:	eb 31                	jmp    192 <gets+0x5e>
    buf[i++] = c;
 161:	8b 45 f4             	mov    -0xc(%ebp),%eax
 164:	8d 50 01             	lea    0x1(%eax),%edx
 167:	89 55 f4             	mov    %edx,-0xc(%ebp)
 16a:	89 c2                	mov    %eax,%edx
 16c:	8b 45 08             	mov    0x8(%ebp),%eax
 16f:	01 c2                	add    %eax,%edx
 171:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 175:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 177:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 17b:	3c 0a                	cmp    $0xa,%al
 17d:	74 13                	je     192 <gets+0x5e>
 17f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 183:	3c 0d                	cmp    $0xd,%al
 185:	74 0b                	je     192 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 187:	8b 45 f4             	mov    -0xc(%ebp),%eax
 18a:	83 c0 01             	add    $0x1,%eax
 18d:	3b 45 0c             	cmp    0xc(%ebp),%eax
 190:	7c b1                	jl     143 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 192:	8b 55 f4             	mov    -0xc(%ebp),%edx
 195:	8b 45 08             	mov    0x8(%ebp),%eax
 198:	01 d0                	add    %edx,%eax
 19a:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 19d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1a0:	c9                   	leave  
 1a1:	c3                   	ret    

000001a2 <stat>:

int
stat(char *n, struct stat *st)
{
 1a2:	55                   	push   %ebp
 1a3:	89 e5                	mov    %esp,%ebp
 1a5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a8:	83 ec 08             	sub    $0x8,%esp
 1ab:	6a 00                	push   $0x0
 1ad:	ff 75 08             	pushl  0x8(%ebp)
 1b0:	e8 0c 01 00 00       	call   2c1 <open>
 1b5:	83 c4 10             	add    $0x10,%esp
 1b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1bb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1bf:	79 07                	jns    1c8 <stat+0x26>
    return -1;
 1c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1c6:	eb 25                	jmp    1ed <stat+0x4b>
  r = fstat(fd, st);
 1c8:	83 ec 08             	sub    $0x8,%esp
 1cb:	ff 75 0c             	pushl  0xc(%ebp)
 1ce:	ff 75 f4             	pushl  -0xc(%ebp)
 1d1:	e8 03 01 00 00       	call   2d9 <fstat>
 1d6:	83 c4 10             	add    $0x10,%esp
 1d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1dc:	83 ec 0c             	sub    $0xc,%esp
 1df:	ff 75 f4             	pushl  -0xc(%ebp)
 1e2:	e8 c2 00 00 00       	call   2a9 <close>
 1e7:	83 c4 10             	add    $0x10,%esp
  return r;
 1ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1ed:	c9                   	leave  
 1ee:	c3                   	ret    

000001ef <atoi>:

int
atoi(const char *s)
{
 1ef:	55                   	push   %ebp
 1f0:	89 e5                	mov    %esp,%ebp
 1f2:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 1fc:	eb 25                	jmp    223 <atoi+0x34>
    n = n*10 + *s++ - '0';
 1fe:	8b 55 fc             	mov    -0x4(%ebp),%edx
 201:	89 d0                	mov    %edx,%eax
 203:	c1 e0 02             	shl    $0x2,%eax
 206:	01 d0                	add    %edx,%eax
 208:	01 c0                	add    %eax,%eax
 20a:	89 c1                	mov    %eax,%ecx
 20c:	8b 45 08             	mov    0x8(%ebp),%eax
 20f:	8d 50 01             	lea    0x1(%eax),%edx
 212:	89 55 08             	mov    %edx,0x8(%ebp)
 215:	0f b6 00             	movzbl (%eax),%eax
 218:	0f be c0             	movsbl %al,%eax
 21b:	01 c8                	add    %ecx,%eax
 21d:	83 e8 30             	sub    $0x30,%eax
 220:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	0f b6 00             	movzbl (%eax),%eax
 229:	3c 2f                	cmp    $0x2f,%al
 22b:	7e 0a                	jle    237 <atoi+0x48>
 22d:	8b 45 08             	mov    0x8(%ebp),%eax
 230:	0f b6 00             	movzbl (%eax),%eax
 233:	3c 39                	cmp    $0x39,%al
 235:	7e c7                	jle    1fe <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 237:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 23a:	c9                   	leave  
 23b:	c3                   	ret    

0000023c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 23c:	55                   	push   %ebp
 23d:	89 e5                	mov    %esp,%ebp
 23f:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 242:	8b 45 08             	mov    0x8(%ebp),%eax
 245:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 248:	8b 45 0c             	mov    0xc(%ebp),%eax
 24b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 24e:	eb 17                	jmp    267 <memmove+0x2b>
    *dst++ = *src++;
 250:	8b 45 fc             	mov    -0x4(%ebp),%eax
 253:	8d 50 01             	lea    0x1(%eax),%edx
 256:	89 55 fc             	mov    %edx,-0x4(%ebp)
 259:	8b 55 f8             	mov    -0x8(%ebp),%edx
 25c:	8d 4a 01             	lea    0x1(%edx),%ecx
 25f:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 262:	0f b6 12             	movzbl (%edx),%edx
 265:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 267:	8b 45 10             	mov    0x10(%ebp),%eax
 26a:	8d 50 ff             	lea    -0x1(%eax),%edx
 26d:	89 55 10             	mov    %edx,0x10(%ebp)
 270:	85 c0                	test   %eax,%eax
 272:	7f dc                	jg     250 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 274:	8b 45 08             	mov    0x8(%ebp),%eax
}
 277:	c9                   	leave  
 278:	c3                   	ret    

00000279 <fork>:
 279:	b8 01 00 00 00       	mov    $0x1,%eax
 27e:	cd 40                	int    $0x40
 280:	c3                   	ret    

00000281 <exit>:
 281:	b8 02 00 00 00       	mov    $0x2,%eax
 286:	cd 40                	int    $0x40
 288:	c3                   	ret    

00000289 <wait>:
 289:	b8 03 00 00 00       	mov    $0x3,%eax
 28e:	cd 40                	int    $0x40
 290:	c3                   	ret    

00000291 <pipe>:
 291:	b8 04 00 00 00       	mov    $0x4,%eax
 296:	cd 40                	int    $0x40
 298:	c3                   	ret    

00000299 <read>:
 299:	b8 05 00 00 00       	mov    $0x5,%eax
 29e:	cd 40                	int    $0x40
 2a0:	c3                   	ret    

000002a1 <write>:
 2a1:	b8 10 00 00 00       	mov    $0x10,%eax
 2a6:	cd 40                	int    $0x40
 2a8:	c3                   	ret    

000002a9 <close>:
 2a9:	b8 15 00 00 00       	mov    $0x15,%eax
 2ae:	cd 40                	int    $0x40
 2b0:	c3                   	ret    

000002b1 <kill>:
 2b1:	b8 06 00 00 00       	mov    $0x6,%eax
 2b6:	cd 40                	int    $0x40
 2b8:	c3                   	ret    

000002b9 <exec>:
 2b9:	b8 07 00 00 00       	mov    $0x7,%eax
 2be:	cd 40                	int    $0x40
 2c0:	c3                   	ret    

000002c1 <open>:
 2c1:	b8 0f 00 00 00       	mov    $0xf,%eax
 2c6:	cd 40                	int    $0x40
 2c8:	c3                   	ret    

000002c9 <mknod>:
 2c9:	b8 11 00 00 00       	mov    $0x11,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <unlink>:
 2d1:	b8 12 00 00 00       	mov    $0x12,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <fstat>:
 2d9:	b8 08 00 00 00       	mov    $0x8,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <link>:
 2e1:	b8 13 00 00 00       	mov    $0x13,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <mkdir>:
 2e9:	b8 14 00 00 00       	mov    $0x14,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <chdir>:
 2f1:	b8 09 00 00 00       	mov    $0x9,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <dup>:
 2f9:	b8 0a 00 00 00       	mov    $0xa,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <getpid>:
 301:	b8 0b 00 00 00       	mov    $0xb,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <sbrk>:
 309:	b8 0c 00 00 00       	mov    $0xc,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <sleep>:
 311:	b8 0d 00 00 00       	mov    $0xd,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <uptime>:
 319:	b8 0e 00 00 00       	mov    $0xe,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <getcwd>:
 321:	b8 16 00 00 00       	mov    $0x16,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <ps>:
 329:	b8 17 00 00 00       	mov    $0x17,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <putc>:
 331:	55                   	push   %ebp
 332:	89 e5                	mov    %esp,%ebp
 334:	83 ec 18             	sub    $0x18,%esp
 337:	8b 45 0c             	mov    0xc(%ebp),%eax
 33a:	88 45 f4             	mov    %al,-0xc(%ebp)
 33d:	83 ec 04             	sub    $0x4,%esp
 340:	6a 01                	push   $0x1
 342:	8d 45 f4             	lea    -0xc(%ebp),%eax
 345:	50                   	push   %eax
 346:	ff 75 08             	pushl  0x8(%ebp)
 349:	e8 53 ff ff ff       	call   2a1 <write>
 34e:	83 c4 10             	add    $0x10,%esp
 351:	c9                   	leave  
 352:	c3                   	ret    

00000353 <printint>:
 353:	55                   	push   %ebp
 354:	89 e5                	mov    %esp,%ebp
 356:	53                   	push   %ebx
 357:	83 ec 24             	sub    $0x24,%esp
 35a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 361:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 365:	74 17                	je     37e <printint+0x2b>
 367:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 36b:	79 11                	jns    37e <printint+0x2b>
 36d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 374:	8b 45 0c             	mov    0xc(%ebp),%eax
 377:	f7 d8                	neg    %eax
 379:	89 45 ec             	mov    %eax,-0x14(%ebp)
 37c:	eb 06                	jmp    384 <printint+0x31>
 37e:	8b 45 0c             	mov    0xc(%ebp),%eax
 381:	89 45 ec             	mov    %eax,-0x14(%ebp)
 384:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 38b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 38e:	8d 41 01             	lea    0x1(%ecx),%eax
 391:	89 45 f4             	mov    %eax,-0xc(%ebp)
 394:	8b 5d 10             	mov    0x10(%ebp),%ebx
 397:	8b 45 ec             	mov    -0x14(%ebp),%eax
 39a:	ba 00 00 00 00       	mov    $0x0,%edx
 39f:	f7 f3                	div    %ebx
 3a1:	89 d0                	mov    %edx,%eax
 3a3:	0f b6 80 0c 0a 00 00 	movzbl 0xa0c(%eax),%eax
 3aa:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 3ae:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3b4:	ba 00 00 00 00       	mov    $0x0,%edx
 3b9:	f7 f3                	div    %ebx
 3bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3be:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3c2:	75 c7                	jne    38b <printint+0x38>
 3c4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3c8:	74 0e                	je     3d8 <printint+0x85>
 3ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3cd:	8d 50 01             	lea    0x1(%eax),%edx
 3d0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3d3:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 3d8:	eb 1d                	jmp    3f7 <printint+0xa4>
 3da:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3e0:	01 d0                	add    %edx,%eax
 3e2:	0f b6 00             	movzbl (%eax),%eax
 3e5:	0f be c0             	movsbl %al,%eax
 3e8:	83 ec 08             	sub    $0x8,%esp
 3eb:	50                   	push   %eax
 3ec:	ff 75 08             	pushl  0x8(%ebp)
 3ef:	e8 3d ff ff ff       	call   331 <putc>
 3f4:	83 c4 10             	add    $0x10,%esp
 3f7:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 3fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3ff:	79 d9                	jns    3da <printint+0x87>
 401:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 404:	c9                   	leave  
 405:	c3                   	ret    

00000406 <printf>:
 406:	55                   	push   %ebp
 407:	89 e5                	mov    %esp,%ebp
 409:	83 ec 28             	sub    $0x28,%esp
 40c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 413:	8d 45 0c             	lea    0xc(%ebp),%eax
 416:	83 c0 04             	add    $0x4,%eax
 419:	89 45 e8             	mov    %eax,-0x18(%ebp)
 41c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 423:	e9 59 01 00 00       	jmp    581 <printf+0x17b>
 428:	8b 55 0c             	mov    0xc(%ebp),%edx
 42b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 42e:	01 d0                	add    %edx,%eax
 430:	0f b6 00             	movzbl (%eax),%eax
 433:	0f be c0             	movsbl %al,%eax
 436:	25 ff 00 00 00       	and    $0xff,%eax
 43b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 43e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 442:	75 2c                	jne    470 <printf+0x6a>
 444:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 448:	75 0c                	jne    456 <printf+0x50>
 44a:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 451:	e9 27 01 00 00       	jmp    57d <printf+0x177>
 456:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 459:	0f be c0             	movsbl %al,%eax
 45c:	83 ec 08             	sub    $0x8,%esp
 45f:	50                   	push   %eax
 460:	ff 75 08             	pushl  0x8(%ebp)
 463:	e8 c9 fe ff ff       	call   331 <putc>
 468:	83 c4 10             	add    $0x10,%esp
 46b:	e9 0d 01 00 00       	jmp    57d <printf+0x177>
 470:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 474:	0f 85 03 01 00 00    	jne    57d <printf+0x177>
 47a:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 47e:	75 1e                	jne    49e <printf+0x98>
 480:	8b 45 e8             	mov    -0x18(%ebp),%eax
 483:	8b 00                	mov    (%eax),%eax
 485:	6a 01                	push   $0x1
 487:	6a 0a                	push   $0xa
 489:	50                   	push   %eax
 48a:	ff 75 08             	pushl  0x8(%ebp)
 48d:	e8 c1 fe ff ff       	call   353 <printint>
 492:	83 c4 10             	add    $0x10,%esp
 495:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 499:	e9 d8 00 00 00       	jmp    576 <printf+0x170>
 49e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4a2:	74 06                	je     4aa <printf+0xa4>
 4a4:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4a8:	75 1e                	jne    4c8 <printf+0xc2>
 4aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ad:	8b 00                	mov    (%eax),%eax
 4af:	6a 00                	push   $0x0
 4b1:	6a 10                	push   $0x10
 4b3:	50                   	push   %eax
 4b4:	ff 75 08             	pushl  0x8(%ebp)
 4b7:	e8 97 fe ff ff       	call   353 <printint>
 4bc:	83 c4 10             	add    $0x10,%esp
 4bf:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4c3:	e9 ae 00 00 00       	jmp    576 <printf+0x170>
 4c8:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4cc:	75 43                	jne    511 <printf+0x10b>
 4ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4d1:	8b 00                	mov    (%eax),%eax
 4d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4d6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4da:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4de:	75 07                	jne    4e7 <printf+0xe1>
 4e0:	c7 45 f4 ba 07 00 00 	movl   $0x7ba,-0xc(%ebp)
 4e7:	eb 1c                	jmp    505 <printf+0xff>
 4e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ec:	0f b6 00             	movzbl (%eax),%eax
 4ef:	0f be c0             	movsbl %al,%eax
 4f2:	83 ec 08             	sub    $0x8,%esp
 4f5:	50                   	push   %eax
 4f6:	ff 75 08             	pushl  0x8(%ebp)
 4f9:	e8 33 fe ff ff       	call   331 <putc>
 4fe:	83 c4 10             	add    $0x10,%esp
 501:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 505:	8b 45 f4             	mov    -0xc(%ebp),%eax
 508:	0f b6 00             	movzbl (%eax),%eax
 50b:	84 c0                	test   %al,%al
 50d:	75 da                	jne    4e9 <printf+0xe3>
 50f:	eb 65                	jmp    576 <printf+0x170>
 511:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 515:	75 1d                	jne    534 <printf+0x12e>
 517:	8b 45 e8             	mov    -0x18(%ebp),%eax
 51a:	8b 00                	mov    (%eax),%eax
 51c:	0f be c0             	movsbl %al,%eax
 51f:	83 ec 08             	sub    $0x8,%esp
 522:	50                   	push   %eax
 523:	ff 75 08             	pushl  0x8(%ebp)
 526:	e8 06 fe ff ff       	call   331 <putc>
 52b:	83 c4 10             	add    $0x10,%esp
 52e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 532:	eb 42                	jmp    576 <printf+0x170>
 534:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 538:	75 17                	jne    551 <printf+0x14b>
 53a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 53d:	0f be c0             	movsbl %al,%eax
 540:	83 ec 08             	sub    $0x8,%esp
 543:	50                   	push   %eax
 544:	ff 75 08             	pushl  0x8(%ebp)
 547:	e8 e5 fd ff ff       	call   331 <putc>
 54c:	83 c4 10             	add    $0x10,%esp
 54f:	eb 25                	jmp    576 <printf+0x170>
 551:	83 ec 08             	sub    $0x8,%esp
 554:	6a 25                	push   $0x25
 556:	ff 75 08             	pushl  0x8(%ebp)
 559:	e8 d3 fd ff ff       	call   331 <putc>
 55e:	83 c4 10             	add    $0x10,%esp
 561:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 564:	0f be c0             	movsbl %al,%eax
 567:	83 ec 08             	sub    $0x8,%esp
 56a:	50                   	push   %eax
 56b:	ff 75 08             	pushl  0x8(%ebp)
 56e:	e8 be fd ff ff       	call   331 <putc>
 573:	83 c4 10             	add    $0x10,%esp
 576:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 57d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 581:	8b 55 0c             	mov    0xc(%ebp),%edx
 584:	8b 45 f0             	mov    -0x10(%ebp),%eax
 587:	01 d0                	add    %edx,%eax
 589:	0f b6 00             	movzbl (%eax),%eax
 58c:	84 c0                	test   %al,%al
 58e:	0f 85 94 fe ff ff    	jne    428 <printf+0x22>
 594:	c9                   	leave  
 595:	c3                   	ret    

00000596 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 596:	55                   	push   %ebp
 597:	89 e5                	mov    %esp,%ebp
 599:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 59c:	8b 45 08             	mov    0x8(%ebp),%eax
 59f:	83 e8 08             	sub    $0x8,%eax
 5a2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a5:	a1 28 0a 00 00       	mov    0xa28,%eax
 5aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5ad:	eb 24                	jmp    5d3 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5af:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5b2:	8b 00                	mov    (%eax),%eax
 5b4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5b7:	77 12                	ja     5cb <free+0x35>
 5b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5bc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5bf:	77 24                	ja     5e5 <free+0x4f>
 5c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5c4:	8b 00                	mov    (%eax),%eax
 5c6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5c9:	77 1a                	ja     5e5 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ce:	8b 00                	mov    (%eax),%eax
 5d0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5d9:	76 d4                	jbe    5af <free+0x19>
 5db:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5de:	8b 00                	mov    (%eax),%eax
 5e0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5e3:	76 ca                	jbe    5af <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5e8:	8b 40 04             	mov    0x4(%eax),%eax
 5eb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f5:	01 c2                	add    %eax,%edx
 5f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fa:	8b 00                	mov    (%eax),%eax
 5fc:	39 c2                	cmp    %eax,%edx
 5fe:	75 24                	jne    624 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 600:	8b 45 f8             	mov    -0x8(%ebp),%eax
 603:	8b 50 04             	mov    0x4(%eax),%edx
 606:	8b 45 fc             	mov    -0x4(%ebp),%eax
 609:	8b 00                	mov    (%eax),%eax
 60b:	8b 40 04             	mov    0x4(%eax),%eax
 60e:	01 c2                	add    %eax,%edx
 610:	8b 45 f8             	mov    -0x8(%ebp),%eax
 613:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 616:	8b 45 fc             	mov    -0x4(%ebp),%eax
 619:	8b 00                	mov    (%eax),%eax
 61b:	8b 10                	mov    (%eax),%edx
 61d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 620:	89 10                	mov    %edx,(%eax)
 622:	eb 0a                	jmp    62e <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 624:	8b 45 fc             	mov    -0x4(%ebp),%eax
 627:	8b 10                	mov    (%eax),%edx
 629:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62c:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 62e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 631:	8b 40 04             	mov    0x4(%eax),%eax
 634:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 63b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63e:	01 d0                	add    %edx,%eax
 640:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 643:	75 20                	jne    665 <free+0xcf>
    p->s.size += bp->s.size;
 645:	8b 45 fc             	mov    -0x4(%ebp),%eax
 648:	8b 50 04             	mov    0x4(%eax),%edx
 64b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64e:	8b 40 04             	mov    0x4(%eax),%eax
 651:	01 c2                	add    %eax,%edx
 653:	8b 45 fc             	mov    -0x4(%ebp),%eax
 656:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 659:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65c:	8b 10                	mov    (%eax),%edx
 65e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 661:	89 10                	mov    %edx,(%eax)
 663:	eb 08                	jmp    66d <free+0xd7>
  } else
    p->s.ptr = bp;
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 55 f8             	mov    -0x8(%ebp),%edx
 66b:	89 10                	mov    %edx,(%eax)
  freep = p;
 66d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 670:	a3 28 0a 00 00       	mov    %eax,0xa28
}
 675:	c9                   	leave  
 676:	c3                   	ret    

00000677 <morecore>:

static Header*
morecore(uint nu)
{
 677:	55                   	push   %ebp
 678:	89 e5                	mov    %esp,%ebp
 67a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 67d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 684:	77 07                	ja     68d <morecore+0x16>
    nu = 4096;
 686:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 68d:	8b 45 08             	mov    0x8(%ebp),%eax
 690:	c1 e0 03             	shl    $0x3,%eax
 693:	83 ec 0c             	sub    $0xc,%esp
 696:	50                   	push   %eax
 697:	e8 6d fc ff ff       	call   309 <sbrk>
 69c:	83 c4 10             	add    $0x10,%esp
 69f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6a2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6a6:	75 07                	jne    6af <morecore+0x38>
    return 0;
 6a8:	b8 00 00 00 00       	mov    $0x0,%eax
 6ad:	eb 26                	jmp    6d5 <morecore+0x5e>
  hp = (Header*)p;
 6af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6b8:	8b 55 08             	mov    0x8(%ebp),%edx
 6bb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6be:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c1:	83 c0 08             	add    $0x8,%eax
 6c4:	83 ec 0c             	sub    $0xc,%esp
 6c7:	50                   	push   %eax
 6c8:	e8 c9 fe ff ff       	call   596 <free>
 6cd:	83 c4 10             	add    $0x10,%esp
  return freep;
 6d0:	a1 28 0a 00 00       	mov    0xa28,%eax
}
 6d5:	c9                   	leave  
 6d6:	c3                   	ret    

000006d7 <malloc>:

void*
malloc(uint nbytes)
{
 6d7:	55                   	push   %ebp
 6d8:	89 e5                	mov    %esp,%ebp
 6da:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6dd:	8b 45 08             	mov    0x8(%ebp),%eax
 6e0:	83 c0 07             	add    $0x7,%eax
 6e3:	c1 e8 03             	shr    $0x3,%eax
 6e6:	83 c0 01             	add    $0x1,%eax
 6e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6ec:	a1 28 0a 00 00       	mov    0xa28,%eax
 6f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6f8:	75 23                	jne    71d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 6fa:	c7 45 f0 20 0a 00 00 	movl   $0xa20,-0x10(%ebp)
 701:	8b 45 f0             	mov    -0x10(%ebp),%eax
 704:	a3 28 0a 00 00       	mov    %eax,0xa28
 709:	a1 28 0a 00 00       	mov    0xa28,%eax
 70e:	a3 20 0a 00 00       	mov    %eax,0xa20
    base.s.size = 0;
 713:	c7 05 24 0a 00 00 00 	movl   $0x0,0xa24
 71a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 71d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 720:	8b 00                	mov    (%eax),%eax
 722:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 725:	8b 45 f4             	mov    -0xc(%ebp),%eax
 728:	8b 40 04             	mov    0x4(%eax),%eax
 72b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 72e:	72 4d                	jb     77d <malloc+0xa6>
      if(p->s.size == nunits)
 730:	8b 45 f4             	mov    -0xc(%ebp),%eax
 733:	8b 40 04             	mov    0x4(%eax),%eax
 736:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 739:	75 0c                	jne    747 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 73b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73e:	8b 10                	mov    (%eax),%edx
 740:	8b 45 f0             	mov    -0x10(%ebp),%eax
 743:	89 10                	mov    %edx,(%eax)
 745:	eb 26                	jmp    76d <malloc+0x96>
      else {
        p->s.size -= nunits;
 747:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74a:	8b 40 04             	mov    0x4(%eax),%eax
 74d:	2b 45 ec             	sub    -0x14(%ebp),%eax
 750:	89 c2                	mov    %eax,%edx
 752:	8b 45 f4             	mov    -0xc(%ebp),%eax
 755:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 758:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75b:	8b 40 04             	mov    0x4(%eax),%eax
 75e:	c1 e0 03             	shl    $0x3,%eax
 761:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 764:	8b 45 f4             	mov    -0xc(%ebp),%eax
 767:	8b 55 ec             	mov    -0x14(%ebp),%edx
 76a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 76d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 770:	a3 28 0a 00 00       	mov    %eax,0xa28
      return (void*)(p + 1);
 775:	8b 45 f4             	mov    -0xc(%ebp),%eax
 778:	83 c0 08             	add    $0x8,%eax
 77b:	eb 3b                	jmp    7b8 <malloc+0xe1>
    }
    if(p == freep)
 77d:	a1 28 0a 00 00       	mov    0xa28,%eax
 782:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 785:	75 1e                	jne    7a5 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 787:	83 ec 0c             	sub    $0xc,%esp
 78a:	ff 75 ec             	pushl  -0x14(%ebp)
 78d:	e8 e5 fe ff ff       	call   677 <morecore>
 792:	83 c4 10             	add    $0x10,%esp
 795:	89 45 f4             	mov    %eax,-0xc(%ebp)
 798:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 79c:	75 07                	jne    7a5 <malloc+0xce>
        return 0;
 79e:	b8 00 00 00 00       	mov    $0x0,%eax
 7a3:	eb 13                	jmp    7b8 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ae:	8b 00                	mov    (%eax),%eax
 7b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7b3:	e9 6d ff ff ff       	jmp    725 <malloc+0x4e>
}
 7b8:	c9                   	leave  
 7b9:	c3                   	ret    
