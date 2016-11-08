
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	89 cb                	mov    %ecx,%ebx
  if(argc != 3){
  11:	83 3b 03             	cmpl   $0x3,(%ebx)
  14:	74 17                	je     2d <main+0x2d>
    printf(2, "Usage: ln old new\n");
  16:	83 ec 08             	sub    $0x8,%esp
  19:	68 02 08 00 00       	push   $0x802
  1e:	6a 02                	push   $0x2
  20:	e8 29 04 00 00       	call   44e <printf>
  25:	83 c4 10             	add    $0x10,%esp
    exit();
  28:	e8 9c 02 00 00       	call   2c9 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2d:	8b 43 04             	mov    0x4(%ebx),%eax
  30:	83 c0 08             	add    $0x8,%eax
  33:	8b 10                	mov    (%eax),%edx
  35:	8b 43 04             	mov    0x4(%ebx),%eax
  38:	83 c0 04             	add    $0x4,%eax
  3b:	8b 00                	mov    (%eax),%eax
  3d:	83 ec 08             	sub    $0x8,%esp
  40:	52                   	push   %edx
  41:	50                   	push   %eax
  42:	e8 e2 02 00 00       	call   329 <link>
  47:	83 c4 10             	add    $0x10,%esp
  4a:	85 c0                	test   %eax,%eax
  4c:	79 21                	jns    6f <main+0x6f>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  4e:	8b 43 04             	mov    0x4(%ebx),%eax
  51:	83 c0 08             	add    $0x8,%eax
  54:	8b 10                	mov    (%eax),%edx
  56:	8b 43 04             	mov    0x4(%ebx),%eax
  59:	83 c0 04             	add    $0x4,%eax
  5c:	8b 00                	mov    (%eax),%eax
  5e:	52                   	push   %edx
  5f:	50                   	push   %eax
  60:	68 15 08 00 00       	push   $0x815
  65:	6a 02                	push   $0x2
  67:	e8 e2 03 00 00       	call   44e <printf>
  6c:	83 c4 10             	add    $0x10,%esp
  exit();
  6f:	e8 55 02 00 00       	call   2c9 <exit>

00000074 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  74:	55                   	push   %ebp
  75:	89 e5                	mov    %esp,%ebp
  77:	57                   	push   %edi
  78:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  79:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7c:	8b 55 10             	mov    0x10(%ebp),%edx
  7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  82:	89 cb                	mov    %ecx,%ebx
  84:	89 df                	mov    %ebx,%edi
  86:	89 d1                	mov    %edx,%ecx
  88:	fc                   	cld    
  89:	f3 aa                	rep stos %al,%es:(%edi)
  8b:	89 ca                	mov    %ecx,%edx
  8d:	89 fb                	mov    %edi,%ebx
  8f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  92:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  95:	5b                   	pop    %ebx
  96:	5f                   	pop    %edi
  97:	5d                   	pop    %ebp
  98:	c3                   	ret    

00000099 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  99:	55                   	push   %ebp
  9a:	89 e5                	mov    %esp,%ebp
  9c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  9f:	8b 45 08             	mov    0x8(%ebp),%eax
  a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  a5:	90                   	nop
  a6:	8b 45 08             	mov    0x8(%ebp),%eax
  a9:	8d 50 01             	lea    0x1(%eax),%edx
  ac:	89 55 08             	mov    %edx,0x8(%ebp)
  af:	8b 55 0c             	mov    0xc(%ebp),%edx
  b2:	8d 4a 01             	lea    0x1(%edx),%ecx
  b5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  b8:	0f b6 12             	movzbl (%edx),%edx
  bb:	88 10                	mov    %dl,(%eax)
  bd:	0f b6 00             	movzbl (%eax),%eax
  c0:	84 c0                	test   %al,%al
  c2:	75 e2                	jne    a6 <strcpy+0xd>
    ;
  return os;
  c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c7:	c9                   	leave  
  c8:	c3                   	ret    

000000c9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c9:	55                   	push   %ebp
  ca:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  cc:	eb 08                	jmp    d6 <strcmp+0xd>
    p++, q++;
  ce:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d2:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  d6:	8b 45 08             	mov    0x8(%ebp),%eax
  d9:	0f b6 00             	movzbl (%eax),%eax
  dc:	84 c0                	test   %al,%al
  de:	74 10                	je     f0 <strcmp+0x27>
  e0:	8b 45 08             	mov    0x8(%ebp),%eax
  e3:	0f b6 10             	movzbl (%eax),%edx
  e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  e9:	0f b6 00             	movzbl (%eax),%eax
  ec:	38 c2                	cmp    %al,%dl
  ee:	74 de                	je     ce <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  f0:	8b 45 08             	mov    0x8(%ebp),%eax
  f3:	0f b6 00             	movzbl (%eax),%eax
  f6:	0f b6 d0             	movzbl %al,%edx
  f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  fc:	0f b6 00             	movzbl (%eax),%eax
  ff:	0f b6 c0             	movzbl %al,%eax
 102:	29 c2                	sub    %eax,%edx
 104:	89 d0                	mov    %edx,%eax
}
 106:	5d                   	pop    %ebp
 107:	c3                   	ret    

00000108 <strlen>:

uint
strlen(char *s)
{
 108:	55                   	push   %ebp
 109:	89 e5                	mov    %esp,%ebp
 10b:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 10e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 115:	eb 04                	jmp    11b <strlen+0x13>
 117:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 11b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 11e:	8b 45 08             	mov    0x8(%ebp),%eax
 121:	01 d0                	add    %edx,%eax
 123:	0f b6 00             	movzbl (%eax),%eax
 126:	84 c0                	test   %al,%al
 128:	75 ed                	jne    117 <strlen+0xf>
    ;
  return n;
 12a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 12d:	c9                   	leave  
 12e:	c3                   	ret    

0000012f <memset>:

void*
memset(void *dst, int c, uint n)
{
 12f:	55                   	push   %ebp
 130:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 132:	8b 45 10             	mov    0x10(%ebp),%eax
 135:	50                   	push   %eax
 136:	ff 75 0c             	pushl  0xc(%ebp)
 139:	ff 75 08             	pushl  0x8(%ebp)
 13c:	e8 33 ff ff ff       	call   74 <stosb>
 141:	83 c4 0c             	add    $0xc,%esp
  return dst;
 144:	8b 45 08             	mov    0x8(%ebp),%eax
}
 147:	c9                   	leave  
 148:	c3                   	ret    

00000149 <strchr>:

char*
strchr(const char *s, char c)
{
 149:	55                   	push   %ebp
 14a:	89 e5                	mov    %esp,%ebp
 14c:	83 ec 04             	sub    $0x4,%esp
 14f:	8b 45 0c             	mov    0xc(%ebp),%eax
 152:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 155:	eb 14                	jmp    16b <strchr+0x22>
    if(*s == c)
 157:	8b 45 08             	mov    0x8(%ebp),%eax
 15a:	0f b6 00             	movzbl (%eax),%eax
 15d:	3a 45 fc             	cmp    -0x4(%ebp),%al
 160:	75 05                	jne    167 <strchr+0x1e>
      return (char*)s;
 162:	8b 45 08             	mov    0x8(%ebp),%eax
 165:	eb 13                	jmp    17a <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 167:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16b:	8b 45 08             	mov    0x8(%ebp),%eax
 16e:	0f b6 00             	movzbl (%eax),%eax
 171:	84 c0                	test   %al,%al
 173:	75 e2                	jne    157 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 175:	b8 00 00 00 00       	mov    $0x0,%eax
}
 17a:	c9                   	leave  
 17b:	c3                   	ret    

0000017c <gets>:

char*
gets(char *buf, int max)
{
 17c:	55                   	push   %ebp
 17d:	89 e5                	mov    %esp,%ebp
 17f:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 182:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 189:	eb 44                	jmp    1cf <gets+0x53>
    cc = read(0, &c, 1);
 18b:	83 ec 04             	sub    $0x4,%esp
 18e:	6a 01                	push   $0x1
 190:	8d 45 ef             	lea    -0x11(%ebp),%eax
 193:	50                   	push   %eax
 194:	6a 00                	push   $0x0
 196:	e8 46 01 00 00       	call   2e1 <read>
 19b:	83 c4 10             	add    $0x10,%esp
 19e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1a5:	7f 02                	jg     1a9 <gets+0x2d>
      break;
 1a7:	eb 31                	jmp    1da <gets+0x5e>
    buf[i++] = c;
 1a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ac:	8d 50 01             	lea    0x1(%eax),%edx
 1af:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1b2:	89 c2                	mov    %eax,%edx
 1b4:	8b 45 08             	mov    0x8(%ebp),%eax
 1b7:	01 c2                	add    %eax,%edx
 1b9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1bd:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1bf:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c3:	3c 0a                	cmp    $0xa,%al
 1c5:	74 13                	je     1da <gets+0x5e>
 1c7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1cb:	3c 0d                	cmp    $0xd,%al
 1cd:	74 0b                	je     1da <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d2:	83 c0 01             	add    $0x1,%eax
 1d5:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1d8:	7c b1                	jl     18b <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1da:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
 1e0:	01 d0                	add    %edx,%eax
 1e2:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e8:	c9                   	leave  
 1e9:	c3                   	ret    

000001ea <stat>:

int
stat(char *n, struct stat *st)
{
 1ea:	55                   	push   %ebp
 1eb:	89 e5                	mov    %esp,%ebp
 1ed:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f0:	83 ec 08             	sub    $0x8,%esp
 1f3:	6a 00                	push   $0x0
 1f5:	ff 75 08             	pushl  0x8(%ebp)
 1f8:	e8 0c 01 00 00       	call   309 <open>
 1fd:	83 c4 10             	add    $0x10,%esp
 200:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 203:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 207:	79 07                	jns    210 <stat+0x26>
    return -1;
 209:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 20e:	eb 25                	jmp    235 <stat+0x4b>
  r = fstat(fd, st);
 210:	83 ec 08             	sub    $0x8,%esp
 213:	ff 75 0c             	pushl  0xc(%ebp)
 216:	ff 75 f4             	pushl  -0xc(%ebp)
 219:	e8 03 01 00 00       	call   321 <fstat>
 21e:	83 c4 10             	add    $0x10,%esp
 221:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 224:	83 ec 0c             	sub    $0xc,%esp
 227:	ff 75 f4             	pushl  -0xc(%ebp)
 22a:	e8 c2 00 00 00       	call   2f1 <close>
 22f:	83 c4 10             	add    $0x10,%esp
  return r;
 232:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 235:	c9                   	leave  
 236:	c3                   	ret    

00000237 <atoi>:

int
atoi(const char *s)
{
 237:	55                   	push   %ebp
 238:	89 e5                	mov    %esp,%ebp
 23a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 23d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 244:	eb 25                	jmp    26b <atoi+0x34>
    n = n*10 + *s++ - '0';
 246:	8b 55 fc             	mov    -0x4(%ebp),%edx
 249:	89 d0                	mov    %edx,%eax
 24b:	c1 e0 02             	shl    $0x2,%eax
 24e:	01 d0                	add    %edx,%eax
 250:	01 c0                	add    %eax,%eax
 252:	89 c1                	mov    %eax,%ecx
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	8d 50 01             	lea    0x1(%eax),%edx
 25a:	89 55 08             	mov    %edx,0x8(%ebp)
 25d:	0f b6 00             	movzbl (%eax),%eax
 260:	0f be c0             	movsbl %al,%eax
 263:	01 c8                	add    %ecx,%eax
 265:	83 e8 30             	sub    $0x30,%eax
 268:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
 26e:	0f b6 00             	movzbl (%eax),%eax
 271:	3c 2f                	cmp    $0x2f,%al
 273:	7e 0a                	jle    27f <atoi+0x48>
 275:	8b 45 08             	mov    0x8(%ebp),%eax
 278:	0f b6 00             	movzbl (%eax),%eax
 27b:	3c 39                	cmp    $0x39,%al
 27d:	7e c7                	jle    246 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 27f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 282:	c9                   	leave  
 283:	c3                   	ret    

00000284 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 284:	55                   	push   %ebp
 285:	89 e5                	mov    %esp,%ebp
 287:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 28a:	8b 45 08             	mov    0x8(%ebp),%eax
 28d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 290:	8b 45 0c             	mov    0xc(%ebp),%eax
 293:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 296:	eb 17                	jmp    2af <memmove+0x2b>
    *dst++ = *src++;
 298:	8b 45 fc             	mov    -0x4(%ebp),%eax
 29b:	8d 50 01             	lea    0x1(%eax),%edx
 29e:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2a1:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2a4:	8d 4a 01             	lea    0x1(%edx),%ecx
 2a7:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2aa:	0f b6 12             	movzbl (%edx),%edx
 2ad:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2af:	8b 45 10             	mov    0x10(%ebp),%eax
 2b2:	8d 50 ff             	lea    -0x1(%eax),%edx
 2b5:	89 55 10             	mov    %edx,0x10(%ebp)
 2b8:	85 c0                	test   %eax,%eax
 2ba:	7f dc                	jg     298 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2bf:	c9                   	leave  
 2c0:	c3                   	ret    

000002c1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c1:	b8 01 00 00 00       	mov    $0x1,%eax
 2c6:	cd 40                	int    $0x40
 2c8:	c3                   	ret    

000002c9 <exit>:
SYSCALL(exit)
 2c9:	b8 02 00 00 00       	mov    $0x2,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <wait>:
SYSCALL(wait)
 2d1:	b8 03 00 00 00       	mov    $0x3,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <pipe>:
SYSCALL(pipe)
 2d9:	b8 04 00 00 00       	mov    $0x4,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <read>:
SYSCALL(read)
 2e1:	b8 05 00 00 00       	mov    $0x5,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <write>:
SYSCALL(write)
 2e9:	b8 10 00 00 00       	mov    $0x10,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <close>:
SYSCALL(close)
 2f1:	b8 15 00 00 00       	mov    $0x15,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <kill>:
SYSCALL(kill)
 2f9:	b8 06 00 00 00       	mov    $0x6,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <exec>:
SYSCALL(exec)
 301:	b8 07 00 00 00       	mov    $0x7,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <open>:
SYSCALL(open)
 309:	b8 0f 00 00 00       	mov    $0xf,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <mknod>:
SYSCALL(mknod)
 311:	b8 11 00 00 00       	mov    $0x11,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <unlink>:
SYSCALL(unlink)
 319:	b8 12 00 00 00       	mov    $0x12,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <fstat>:
SYSCALL(fstat)
 321:	b8 08 00 00 00       	mov    $0x8,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <link>:
SYSCALL(link)
 329:	b8 13 00 00 00       	mov    $0x13,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <mkdir>:
SYSCALL(mkdir)
 331:	b8 14 00 00 00       	mov    $0x14,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <chdir>:
SYSCALL(chdir)
 339:	b8 09 00 00 00       	mov    $0x9,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <dup>:
SYSCALL(dup)
 341:	b8 0a 00 00 00       	mov    $0xa,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <getpid>:
SYSCALL(getpid)
 349:	b8 0b 00 00 00       	mov    $0xb,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <sbrk>:
SYSCALL(sbrk)
 351:	b8 0c 00 00 00       	mov    $0xc,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <sleep>:
SYSCALL(sleep)
 359:	b8 0d 00 00 00       	mov    $0xd,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <uptime>:
SYSCALL(uptime)
 361:	b8 0e 00 00 00       	mov    $0xe,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <getcwd>:
SYSCALL(getcwd)
 369:	b8 16 00 00 00       	mov    $0x16,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <ps>:
SYSCALL(ps)
 371:	b8 17 00 00 00       	mov    $0x17,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    

00000379 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 379:	55                   	push   %ebp
 37a:	89 e5                	mov    %esp,%ebp
 37c:	83 ec 18             	sub    $0x18,%esp
 37f:	8b 45 0c             	mov    0xc(%ebp),%eax
 382:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 385:	83 ec 04             	sub    $0x4,%esp
 388:	6a 01                	push   $0x1
 38a:	8d 45 f4             	lea    -0xc(%ebp),%eax
 38d:	50                   	push   %eax
 38e:	ff 75 08             	pushl  0x8(%ebp)
 391:	e8 53 ff ff ff       	call   2e9 <write>
 396:	83 c4 10             	add    $0x10,%esp
}
 399:	c9                   	leave  
 39a:	c3                   	ret    

0000039b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 39b:	55                   	push   %ebp
 39c:	89 e5                	mov    %esp,%ebp
 39e:	53                   	push   %ebx
 39f:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3a2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3a9:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3ad:	74 17                	je     3c6 <printint+0x2b>
 3af:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3b3:	79 11                	jns    3c6 <printint+0x2b>
    neg = 1;
 3b5:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3bc:	8b 45 0c             	mov    0xc(%ebp),%eax
 3bf:	f7 d8                	neg    %eax
 3c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3c4:	eb 06                	jmp    3cc <printint+0x31>
  } else {
    x = xx;
 3c6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3d3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3d6:	8d 41 01             	lea    0x1(%ecx),%eax
 3d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3dc:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3df:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3e2:	ba 00 00 00 00       	mov    $0x0,%edx
 3e7:	f7 f3                	div    %ebx
 3e9:	89 d0                	mov    %edx,%eax
 3eb:	0f b6 80 7c 0a 00 00 	movzbl 0xa7c(%eax),%eax
 3f2:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3f6:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3fc:	ba 00 00 00 00       	mov    $0x0,%edx
 401:	f7 f3                	div    %ebx
 403:	89 45 ec             	mov    %eax,-0x14(%ebp)
 406:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 40a:	75 c7                	jne    3d3 <printint+0x38>
  if(neg)
 40c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 410:	74 0e                	je     420 <printint+0x85>
    buf[i++] = '-';
 412:	8b 45 f4             	mov    -0xc(%ebp),%eax
 415:	8d 50 01             	lea    0x1(%eax),%edx
 418:	89 55 f4             	mov    %edx,-0xc(%ebp)
 41b:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 420:	eb 1d                	jmp    43f <printint+0xa4>
    putc(fd, buf[i]);
 422:	8d 55 dc             	lea    -0x24(%ebp),%edx
 425:	8b 45 f4             	mov    -0xc(%ebp),%eax
 428:	01 d0                	add    %edx,%eax
 42a:	0f b6 00             	movzbl (%eax),%eax
 42d:	0f be c0             	movsbl %al,%eax
 430:	83 ec 08             	sub    $0x8,%esp
 433:	50                   	push   %eax
 434:	ff 75 08             	pushl  0x8(%ebp)
 437:	e8 3d ff ff ff       	call   379 <putc>
 43c:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 43f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 443:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 447:	79 d9                	jns    422 <printint+0x87>
    putc(fd, buf[i]);
}
 449:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 44c:	c9                   	leave  
 44d:	c3                   	ret    

0000044e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 44e:	55                   	push   %ebp
 44f:	89 e5                	mov    %esp,%ebp
 451:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 454:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 45b:	8d 45 0c             	lea    0xc(%ebp),%eax
 45e:	83 c0 04             	add    $0x4,%eax
 461:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 464:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 46b:	e9 59 01 00 00       	jmp    5c9 <printf+0x17b>
    c = fmt[i] & 0xff;
 470:	8b 55 0c             	mov    0xc(%ebp),%edx
 473:	8b 45 f0             	mov    -0x10(%ebp),%eax
 476:	01 d0                	add    %edx,%eax
 478:	0f b6 00             	movzbl (%eax),%eax
 47b:	0f be c0             	movsbl %al,%eax
 47e:	25 ff 00 00 00       	and    $0xff,%eax
 483:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 486:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 48a:	75 2c                	jne    4b8 <printf+0x6a>
      if(c == '%'){
 48c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 490:	75 0c                	jne    49e <printf+0x50>
        state = '%';
 492:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 499:	e9 27 01 00 00       	jmp    5c5 <printf+0x177>
      } else {
        putc(fd, c);
 49e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4a1:	0f be c0             	movsbl %al,%eax
 4a4:	83 ec 08             	sub    $0x8,%esp
 4a7:	50                   	push   %eax
 4a8:	ff 75 08             	pushl  0x8(%ebp)
 4ab:	e8 c9 fe ff ff       	call   379 <putc>
 4b0:	83 c4 10             	add    $0x10,%esp
 4b3:	e9 0d 01 00 00       	jmp    5c5 <printf+0x177>
      }
    } else if(state == '%'){
 4b8:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4bc:	0f 85 03 01 00 00    	jne    5c5 <printf+0x177>
      if(c == 'd'){
 4c2:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4c6:	75 1e                	jne    4e6 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4cb:	8b 00                	mov    (%eax),%eax
 4cd:	6a 01                	push   $0x1
 4cf:	6a 0a                	push   $0xa
 4d1:	50                   	push   %eax
 4d2:	ff 75 08             	pushl  0x8(%ebp)
 4d5:	e8 c1 fe ff ff       	call   39b <printint>
 4da:	83 c4 10             	add    $0x10,%esp
        ap++;
 4dd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4e1:	e9 d8 00 00 00       	jmp    5be <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4e6:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4ea:	74 06                	je     4f2 <printf+0xa4>
 4ec:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4f0:	75 1e                	jne    510 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4f5:	8b 00                	mov    (%eax),%eax
 4f7:	6a 00                	push   $0x0
 4f9:	6a 10                	push   $0x10
 4fb:	50                   	push   %eax
 4fc:	ff 75 08             	pushl  0x8(%ebp)
 4ff:	e8 97 fe ff ff       	call   39b <printint>
 504:	83 c4 10             	add    $0x10,%esp
        ap++;
 507:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 50b:	e9 ae 00 00 00       	jmp    5be <printf+0x170>
      } else if(c == 's'){
 510:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 514:	75 43                	jne    559 <printf+0x10b>
        s = (char*)*ap;
 516:	8b 45 e8             	mov    -0x18(%ebp),%eax
 519:	8b 00                	mov    (%eax),%eax
 51b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 51e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 522:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 526:	75 07                	jne    52f <printf+0xe1>
          s = "(null)";
 528:	c7 45 f4 29 08 00 00 	movl   $0x829,-0xc(%ebp)
        while(*s != 0){
 52f:	eb 1c                	jmp    54d <printf+0xff>
          putc(fd, *s);
 531:	8b 45 f4             	mov    -0xc(%ebp),%eax
 534:	0f b6 00             	movzbl (%eax),%eax
 537:	0f be c0             	movsbl %al,%eax
 53a:	83 ec 08             	sub    $0x8,%esp
 53d:	50                   	push   %eax
 53e:	ff 75 08             	pushl  0x8(%ebp)
 541:	e8 33 fe ff ff       	call   379 <putc>
 546:	83 c4 10             	add    $0x10,%esp
          s++;
 549:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 54d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 550:	0f b6 00             	movzbl (%eax),%eax
 553:	84 c0                	test   %al,%al
 555:	75 da                	jne    531 <printf+0xe3>
 557:	eb 65                	jmp    5be <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 559:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 55d:	75 1d                	jne    57c <printf+0x12e>
        putc(fd, *ap);
 55f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 562:	8b 00                	mov    (%eax),%eax
 564:	0f be c0             	movsbl %al,%eax
 567:	83 ec 08             	sub    $0x8,%esp
 56a:	50                   	push   %eax
 56b:	ff 75 08             	pushl  0x8(%ebp)
 56e:	e8 06 fe ff ff       	call   379 <putc>
 573:	83 c4 10             	add    $0x10,%esp
        ap++;
 576:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 57a:	eb 42                	jmp    5be <printf+0x170>
      } else if(c == '%'){
 57c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 580:	75 17                	jne    599 <printf+0x14b>
        putc(fd, c);
 582:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 585:	0f be c0             	movsbl %al,%eax
 588:	83 ec 08             	sub    $0x8,%esp
 58b:	50                   	push   %eax
 58c:	ff 75 08             	pushl  0x8(%ebp)
 58f:	e8 e5 fd ff ff       	call   379 <putc>
 594:	83 c4 10             	add    $0x10,%esp
 597:	eb 25                	jmp    5be <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 599:	83 ec 08             	sub    $0x8,%esp
 59c:	6a 25                	push   $0x25
 59e:	ff 75 08             	pushl  0x8(%ebp)
 5a1:	e8 d3 fd ff ff       	call   379 <putc>
 5a6:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ac:	0f be c0             	movsbl %al,%eax
 5af:	83 ec 08             	sub    $0x8,%esp
 5b2:	50                   	push   %eax
 5b3:	ff 75 08             	pushl  0x8(%ebp)
 5b6:	e8 be fd ff ff       	call   379 <putc>
 5bb:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5be:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5c5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5c9:	8b 55 0c             	mov    0xc(%ebp),%edx
 5cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5cf:	01 d0                	add    %edx,%eax
 5d1:	0f b6 00             	movzbl (%eax),%eax
 5d4:	84 c0                	test   %al,%al
 5d6:	0f 85 94 fe ff ff    	jne    470 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5dc:	c9                   	leave  
 5dd:	c3                   	ret    

000005de <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5de:	55                   	push   %ebp
 5df:	89 e5                	mov    %esp,%ebp
 5e1:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5e4:	8b 45 08             	mov    0x8(%ebp),%eax
 5e7:	83 e8 08             	sub    $0x8,%eax
 5ea:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ed:	a1 98 0a 00 00       	mov    0xa98,%eax
 5f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5f5:	eb 24                	jmp    61b <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fa:	8b 00                	mov    (%eax),%eax
 5fc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5ff:	77 12                	ja     613 <free+0x35>
 601:	8b 45 f8             	mov    -0x8(%ebp),%eax
 604:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 607:	77 24                	ja     62d <free+0x4f>
 609:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60c:	8b 00                	mov    (%eax),%eax
 60e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 611:	77 1a                	ja     62d <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 613:	8b 45 fc             	mov    -0x4(%ebp),%eax
 616:	8b 00                	mov    (%eax),%eax
 618:	89 45 fc             	mov    %eax,-0x4(%ebp)
 61b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 621:	76 d4                	jbe    5f7 <free+0x19>
 623:	8b 45 fc             	mov    -0x4(%ebp),%eax
 626:	8b 00                	mov    (%eax),%eax
 628:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 62b:	76 ca                	jbe    5f7 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 62d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 630:	8b 40 04             	mov    0x4(%eax),%eax
 633:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 63a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63d:	01 c2                	add    %eax,%edx
 63f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 642:	8b 00                	mov    (%eax),%eax
 644:	39 c2                	cmp    %eax,%edx
 646:	75 24                	jne    66c <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 648:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64b:	8b 50 04             	mov    0x4(%eax),%edx
 64e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 651:	8b 00                	mov    (%eax),%eax
 653:	8b 40 04             	mov    0x4(%eax),%eax
 656:	01 c2                	add    %eax,%edx
 658:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65b:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 65e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 661:	8b 00                	mov    (%eax),%eax
 663:	8b 10                	mov    (%eax),%edx
 665:	8b 45 f8             	mov    -0x8(%ebp),%eax
 668:	89 10                	mov    %edx,(%eax)
 66a:	eb 0a                	jmp    676 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 66c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66f:	8b 10                	mov    (%eax),%edx
 671:	8b 45 f8             	mov    -0x8(%ebp),%eax
 674:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 676:	8b 45 fc             	mov    -0x4(%ebp),%eax
 679:	8b 40 04             	mov    0x4(%eax),%eax
 67c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 683:	8b 45 fc             	mov    -0x4(%ebp),%eax
 686:	01 d0                	add    %edx,%eax
 688:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 68b:	75 20                	jne    6ad <free+0xcf>
    p->s.size += bp->s.size;
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	8b 50 04             	mov    0x4(%eax),%edx
 693:	8b 45 f8             	mov    -0x8(%ebp),%eax
 696:	8b 40 04             	mov    0x4(%eax),%eax
 699:	01 c2                	add    %eax,%edx
 69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a4:	8b 10                	mov    (%eax),%edx
 6a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a9:	89 10                	mov    %edx,(%eax)
 6ab:	eb 08                	jmp    6b5 <free+0xd7>
  } else
    p->s.ptr = bp;
 6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b0:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6b3:	89 10                	mov    %edx,(%eax)
  freep = p;
 6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b8:	a3 98 0a 00 00       	mov    %eax,0xa98
}
 6bd:	c9                   	leave  
 6be:	c3                   	ret    

000006bf <morecore>:

static Header*
morecore(uint nu)
{
 6bf:	55                   	push   %ebp
 6c0:	89 e5                	mov    %esp,%ebp
 6c2:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6c5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6cc:	77 07                	ja     6d5 <morecore+0x16>
    nu = 4096;
 6ce:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6d5:	8b 45 08             	mov    0x8(%ebp),%eax
 6d8:	c1 e0 03             	shl    $0x3,%eax
 6db:	83 ec 0c             	sub    $0xc,%esp
 6de:	50                   	push   %eax
 6df:	e8 6d fc ff ff       	call   351 <sbrk>
 6e4:	83 c4 10             	add    $0x10,%esp
 6e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6ea:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6ee:	75 07                	jne    6f7 <morecore+0x38>
    return 0;
 6f0:	b8 00 00 00 00       	mov    $0x0,%eax
 6f5:	eb 26                	jmp    71d <morecore+0x5e>
  hp = (Header*)p;
 6f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 700:	8b 55 08             	mov    0x8(%ebp),%edx
 703:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 706:	8b 45 f0             	mov    -0x10(%ebp),%eax
 709:	83 c0 08             	add    $0x8,%eax
 70c:	83 ec 0c             	sub    $0xc,%esp
 70f:	50                   	push   %eax
 710:	e8 c9 fe ff ff       	call   5de <free>
 715:	83 c4 10             	add    $0x10,%esp
  return freep;
 718:	a1 98 0a 00 00       	mov    0xa98,%eax
}
 71d:	c9                   	leave  
 71e:	c3                   	ret    

0000071f <malloc>:

void*
malloc(uint nbytes)
{
 71f:	55                   	push   %ebp
 720:	89 e5                	mov    %esp,%ebp
 722:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 725:	8b 45 08             	mov    0x8(%ebp),%eax
 728:	83 c0 07             	add    $0x7,%eax
 72b:	c1 e8 03             	shr    $0x3,%eax
 72e:	83 c0 01             	add    $0x1,%eax
 731:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 734:	a1 98 0a 00 00       	mov    0xa98,%eax
 739:	89 45 f0             	mov    %eax,-0x10(%ebp)
 73c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 740:	75 23                	jne    765 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 742:	c7 45 f0 90 0a 00 00 	movl   $0xa90,-0x10(%ebp)
 749:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74c:	a3 98 0a 00 00       	mov    %eax,0xa98
 751:	a1 98 0a 00 00       	mov    0xa98,%eax
 756:	a3 90 0a 00 00       	mov    %eax,0xa90
    base.s.size = 0;
 75b:	c7 05 94 0a 00 00 00 	movl   $0x0,0xa94
 762:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 765:	8b 45 f0             	mov    -0x10(%ebp),%eax
 768:	8b 00                	mov    (%eax),%eax
 76a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 76d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 770:	8b 40 04             	mov    0x4(%eax),%eax
 773:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 776:	72 4d                	jb     7c5 <malloc+0xa6>
      if(p->s.size == nunits)
 778:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77b:	8b 40 04             	mov    0x4(%eax),%eax
 77e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 781:	75 0c                	jne    78f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 783:	8b 45 f4             	mov    -0xc(%ebp),%eax
 786:	8b 10                	mov    (%eax),%edx
 788:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78b:	89 10                	mov    %edx,(%eax)
 78d:	eb 26                	jmp    7b5 <malloc+0x96>
      else {
        p->s.size -= nunits;
 78f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 792:	8b 40 04             	mov    0x4(%eax),%eax
 795:	2b 45 ec             	sub    -0x14(%ebp),%eax
 798:	89 c2                	mov    %eax,%edx
 79a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a3:	8b 40 04             	mov    0x4(%eax),%eax
 7a6:	c1 e0 03             	shl    $0x3,%eax
 7a9:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7af:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7b2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b8:	a3 98 0a 00 00       	mov    %eax,0xa98
      return (void*)(p + 1);
 7bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c0:	83 c0 08             	add    $0x8,%eax
 7c3:	eb 3b                	jmp    800 <malloc+0xe1>
    }
    if(p == freep)
 7c5:	a1 98 0a 00 00       	mov    0xa98,%eax
 7ca:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7cd:	75 1e                	jne    7ed <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7cf:	83 ec 0c             	sub    $0xc,%esp
 7d2:	ff 75 ec             	pushl  -0x14(%ebp)
 7d5:	e8 e5 fe ff ff       	call   6bf <morecore>
 7da:	83 c4 10             	add    $0x10,%esp
 7dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7e0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7e4:	75 07                	jne    7ed <malloc+0xce>
        return 0;
 7e6:	b8 00 00 00 00       	mov    $0x0,%eax
 7eb:	eb 13                	jmp    800 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f6:	8b 00                	mov    (%eax),%eax
 7f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7fb:	e9 6d ff ff ff       	jmp    76d <malloc+0x4e>
}
 800:	c9                   	leave  
 801:	c3                   	ret    
