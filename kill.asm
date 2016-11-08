
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	83 ec 10             	sub    $0x10,%esp
  12:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 1){
  14:	83 3b 00             	cmpl   $0x0,(%ebx)
  17:	7f 17                	jg     30 <main+0x30>
    printf(2, "usage: kill pid...\n");
  19:	83 ec 08             	sub    $0x8,%esp
  1c:	68 00 08 00 00       	push   $0x800
  21:	6a 02                	push   $0x2
  23:	e8 24 04 00 00       	call   44c <printf>
  28:	83 c4 10             	add    $0x10,%esp
    exit();
  2b:	e8 97 02 00 00       	call   2c7 <exit>
  }
  for(i=1; i<argc; i++)
  30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  37:	eb 2d                	jmp    66 <main+0x66>
    kill(atoi(argv[i]));
  39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  43:	8b 43 04             	mov    0x4(%ebx),%eax
  46:	01 d0                	add    %edx,%eax
  48:	8b 00                	mov    (%eax),%eax
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	50                   	push   %eax
  4e:	e8 e2 01 00 00       	call   235 <atoi>
  53:	83 c4 10             	add    $0x10,%esp
  56:	83 ec 0c             	sub    $0xc,%esp
  59:	50                   	push   %eax
  5a:	e8 98 02 00 00       	call   2f7 <kill>
  5f:	83 c4 10             	add    $0x10,%esp

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  62:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  66:	8b 45 f4             	mov    -0xc(%ebp),%eax
  69:	3b 03                	cmp    (%ebx),%eax
  6b:	7c cc                	jl     39 <main+0x39>
    kill(atoi(argv[i]));
  exit();
  6d:	e8 55 02 00 00       	call   2c7 <exit>

00000072 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  72:	55                   	push   %ebp
  73:	89 e5                	mov    %esp,%ebp
  75:	57                   	push   %edi
  76:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  77:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7a:	8b 55 10             	mov    0x10(%ebp),%edx
  7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  80:	89 cb                	mov    %ecx,%ebx
  82:	89 df                	mov    %ebx,%edi
  84:	89 d1                	mov    %edx,%ecx
  86:	fc                   	cld    
  87:	f3 aa                	rep stos %al,%es:(%edi)
  89:	89 ca                	mov    %ecx,%edx
  8b:	89 fb                	mov    %edi,%ebx
  8d:	89 5d 08             	mov    %ebx,0x8(%ebp)
  90:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  93:	5b                   	pop    %ebx
  94:	5f                   	pop    %edi
  95:	5d                   	pop    %ebp
  96:	c3                   	ret    

00000097 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  97:	55                   	push   %ebp
  98:	89 e5                	mov    %esp,%ebp
  9a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  9d:	8b 45 08             	mov    0x8(%ebp),%eax
  a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  a3:	90                   	nop
  a4:	8b 45 08             	mov    0x8(%ebp),%eax
  a7:	8d 50 01             	lea    0x1(%eax),%edx
  aa:	89 55 08             	mov    %edx,0x8(%ebp)
  ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  b0:	8d 4a 01             	lea    0x1(%edx),%ecx
  b3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  b6:	0f b6 12             	movzbl (%edx),%edx
  b9:	88 10                	mov    %dl,(%eax)
  bb:	0f b6 00             	movzbl (%eax),%eax
  be:	84 c0                	test   %al,%al
  c0:	75 e2                	jne    a4 <strcpy+0xd>
    ;
  return os;
  c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c5:	c9                   	leave  
  c6:	c3                   	ret    

000000c7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c7:	55                   	push   %ebp
  c8:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  ca:	eb 08                	jmp    d4 <strcmp+0xd>
    p++, q++;
  cc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  d4:	8b 45 08             	mov    0x8(%ebp),%eax
  d7:	0f b6 00             	movzbl (%eax),%eax
  da:	84 c0                	test   %al,%al
  dc:	74 10                	je     ee <strcmp+0x27>
  de:	8b 45 08             	mov    0x8(%ebp),%eax
  e1:	0f b6 10             	movzbl (%eax),%edx
  e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  e7:	0f b6 00             	movzbl (%eax),%eax
  ea:	38 c2                	cmp    %al,%dl
  ec:	74 de                	je     cc <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  ee:	8b 45 08             	mov    0x8(%ebp),%eax
  f1:	0f b6 00             	movzbl (%eax),%eax
  f4:	0f b6 d0             	movzbl %al,%edx
  f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  fa:	0f b6 00             	movzbl (%eax),%eax
  fd:	0f b6 c0             	movzbl %al,%eax
 100:	29 c2                	sub    %eax,%edx
 102:	89 d0                	mov    %edx,%eax
}
 104:	5d                   	pop    %ebp
 105:	c3                   	ret    

00000106 <strlen>:

uint
strlen(char *s)
{
 106:	55                   	push   %ebp
 107:	89 e5                	mov    %esp,%ebp
 109:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 10c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 113:	eb 04                	jmp    119 <strlen+0x13>
 115:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 119:	8b 55 fc             	mov    -0x4(%ebp),%edx
 11c:	8b 45 08             	mov    0x8(%ebp),%eax
 11f:	01 d0                	add    %edx,%eax
 121:	0f b6 00             	movzbl (%eax),%eax
 124:	84 c0                	test   %al,%al
 126:	75 ed                	jne    115 <strlen+0xf>
    ;
  return n;
 128:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 12b:	c9                   	leave  
 12c:	c3                   	ret    

0000012d <memset>:

void*
memset(void *dst, int c, uint n)
{
 12d:	55                   	push   %ebp
 12e:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 130:	8b 45 10             	mov    0x10(%ebp),%eax
 133:	50                   	push   %eax
 134:	ff 75 0c             	pushl  0xc(%ebp)
 137:	ff 75 08             	pushl  0x8(%ebp)
 13a:	e8 33 ff ff ff       	call   72 <stosb>
 13f:	83 c4 0c             	add    $0xc,%esp
  return dst;
 142:	8b 45 08             	mov    0x8(%ebp),%eax
}
 145:	c9                   	leave  
 146:	c3                   	ret    

00000147 <strchr>:

char*
strchr(const char *s, char c)
{
 147:	55                   	push   %ebp
 148:	89 e5                	mov    %esp,%ebp
 14a:	83 ec 04             	sub    $0x4,%esp
 14d:	8b 45 0c             	mov    0xc(%ebp),%eax
 150:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 153:	eb 14                	jmp    169 <strchr+0x22>
    if(*s == c)
 155:	8b 45 08             	mov    0x8(%ebp),%eax
 158:	0f b6 00             	movzbl (%eax),%eax
 15b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 15e:	75 05                	jne    165 <strchr+0x1e>
      return (char*)s;
 160:	8b 45 08             	mov    0x8(%ebp),%eax
 163:	eb 13                	jmp    178 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 165:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 169:	8b 45 08             	mov    0x8(%ebp),%eax
 16c:	0f b6 00             	movzbl (%eax),%eax
 16f:	84 c0                	test   %al,%al
 171:	75 e2                	jne    155 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 173:	b8 00 00 00 00       	mov    $0x0,%eax
}
 178:	c9                   	leave  
 179:	c3                   	ret    

0000017a <gets>:

char*
gets(char *buf, int max)
{
 17a:	55                   	push   %ebp
 17b:	89 e5                	mov    %esp,%ebp
 17d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 180:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 187:	eb 44                	jmp    1cd <gets+0x53>
    cc = read(0, &c, 1);
 189:	83 ec 04             	sub    $0x4,%esp
 18c:	6a 01                	push   $0x1
 18e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 191:	50                   	push   %eax
 192:	6a 00                	push   $0x0
 194:	e8 46 01 00 00       	call   2df <read>
 199:	83 c4 10             	add    $0x10,%esp
 19c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 19f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1a3:	7f 02                	jg     1a7 <gets+0x2d>
      break;
 1a5:	eb 31                	jmp    1d8 <gets+0x5e>
    buf[i++] = c;
 1a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1aa:	8d 50 01             	lea    0x1(%eax),%edx
 1ad:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1b0:	89 c2                	mov    %eax,%edx
 1b2:	8b 45 08             	mov    0x8(%ebp),%eax
 1b5:	01 c2                	add    %eax,%edx
 1b7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1bb:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1bd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c1:	3c 0a                	cmp    $0xa,%al
 1c3:	74 13                	je     1d8 <gets+0x5e>
 1c5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c9:	3c 0d                	cmp    $0xd,%al
 1cb:	74 0b                	je     1d8 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d0:	83 c0 01             	add    $0x1,%eax
 1d3:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1d6:	7c b1                	jl     189 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1db:	8b 45 08             	mov    0x8(%ebp),%eax
 1de:	01 d0                	add    %edx,%eax
 1e0:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e6:	c9                   	leave  
 1e7:	c3                   	ret    

000001e8 <stat>:

int
stat(char *n, struct stat *st)
{
 1e8:	55                   	push   %ebp
 1e9:	89 e5                	mov    %esp,%ebp
 1eb:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ee:	83 ec 08             	sub    $0x8,%esp
 1f1:	6a 00                	push   $0x0
 1f3:	ff 75 08             	pushl  0x8(%ebp)
 1f6:	e8 0c 01 00 00       	call   307 <open>
 1fb:	83 c4 10             	add    $0x10,%esp
 1fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 201:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 205:	79 07                	jns    20e <stat+0x26>
    return -1;
 207:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 20c:	eb 25                	jmp    233 <stat+0x4b>
  r = fstat(fd, st);
 20e:	83 ec 08             	sub    $0x8,%esp
 211:	ff 75 0c             	pushl  0xc(%ebp)
 214:	ff 75 f4             	pushl  -0xc(%ebp)
 217:	e8 03 01 00 00       	call   31f <fstat>
 21c:	83 c4 10             	add    $0x10,%esp
 21f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 222:	83 ec 0c             	sub    $0xc,%esp
 225:	ff 75 f4             	pushl  -0xc(%ebp)
 228:	e8 c2 00 00 00       	call   2ef <close>
 22d:	83 c4 10             	add    $0x10,%esp
  return r;
 230:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 233:	c9                   	leave  
 234:	c3                   	ret    

00000235 <atoi>:

int
atoi(const char *s)
{
 235:	55                   	push   %ebp
 236:	89 e5                	mov    %esp,%ebp
 238:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 23b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 242:	eb 25                	jmp    269 <atoi+0x34>
    n = n*10 + *s++ - '0';
 244:	8b 55 fc             	mov    -0x4(%ebp),%edx
 247:	89 d0                	mov    %edx,%eax
 249:	c1 e0 02             	shl    $0x2,%eax
 24c:	01 d0                	add    %edx,%eax
 24e:	01 c0                	add    %eax,%eax
 250:	89 c1                	mov    %eax,%ecx
 252:	8b 45 08             	mov    0x8(%ebp),%eax
 255:	8d 50 01             	lea    0x1(%eax),%edx
 258:	89 55 08             	mov    %edx,0x8(%ebp)
 25b:	0f b6 00             	movzbl (%eax),%eax
 25e:	0f be c0             	movsbl %al,%eax
 261:	01 c8                	add    %ecx,%eax
 263:	83 e8 30             	sub    $0x30,%eax
 266:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 269:	8b 45 08             	mov    0x8(%ebp),%eax
 26c:	0f b6 00             	movzbl (%eax),%eax
 26f:	3c 2f                	cmp    $0x2f,%al
 271:	7e 0a                	jle    27d <atoi+0x48>
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 00             	movzbl (%eax),%eax
 279:	3c 39                	cmp    $0x39,%al
 27b:	7e c7                	jle    244 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 27d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 280:	c9                   	leave  
 281:	c3                   	ret    

00000282 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 282:	55                   	push   %ebp
 283:	89 e5                	mov    %esp,%ebp
 285:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 28e:	8b 45 0c             	mov    0xc(%ebp),%eax
 291:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 294:	eb 17                	jmp    2ad <memmove+0x2b>
    *dst++ = *src++;
 296:	8b 45 fc             	mov    -0x4(%ebp),%eax
 299:	8d 50 01             	lea    0x1(%eax),%edx
 29c:	89 55 fc             	mov    %edx,-0x4(%ebp)
 29f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2a2:	8d 4a 01             	lea    0x1(%edx),%ecx
 2a5:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2a8:	0f b6 12             	movzbl (%edx),%edx
 2ab:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ad:	8b 45 10             	mov    0x10(%ebp),%eax
 2b0:	8d 50 ff             	lea    -0x1(%eax),%edx
 2b3:	89 55 10             	mov    %edx,0x10(%ebp)
 2b6:	85 c0                	test   %eax,%eax
 2b8:	7f dc                	jg     296 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2ba:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2bd:	c9                   	leave  
 2be:	c3                   	ret    

000002bf <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2bf:	b8 01 00 00 00       	mov    $0x1,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <exit>:
SYSCALL(exit)
 2c7:	b8 02 00 00 00       	mov    $0x2,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <wait>:
SYSCALL(wait)
 2cf:	b8 03 00 00 00       	mov    $0x3,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <pipe>:
SYSCALL(pipe)
 2d7:	b8 04 00 00 00       	mov    $0x4,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <read>:
SYSCALL(read)
 2df:	b8 05 00 00 00       	mov    $0x5,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <write>:
SYSCALL(write)
 2e7:	b8 10 00 00 00       	mov    $0x10,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <close>:
SYSCALL(close)
 2ef:	b8 15 00 00 00       	mov    $0x15,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <kill>:
SYSCALL(kill)
 2f7:	b8 06 00 00 00       	mov    $0x6,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <exec>:
SYSCALL(exec)
 2ff:	b8 07 00 00 00       	mov    $0x7,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <open>:
SYSCALL(open)
 307:	b8 0f 00 00 00       	mov    $0xf,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <mknod>:
SYSCALL(mknod)
 30f:	b8 11 00 00 00       	mov    $0x11,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <unlink>:
SYSCALL(unlink)
 317:	b8 12 00 00 00       	mov    $0x12,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <fstat>:
SYSCALL(fstat)
 31f:	b8 08 00 00 00       	mov    $0x8,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <link>:
SYSCALL(link)
 327:	b8 13 00 00 00       	mov    $0x13,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <mkdir>:
SYSCALL(mkdir)
 32f:	b8 14 00 00 00       	mov    $0x14,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <chdir>:
SYSCALL(chdir)
 337:	b8 09 00 00 00       	mov    $0x9,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <dup>:
SYSCALL(dup)
 33f:	b8 0a 00 00 00       	mov    $0xa,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <getpid>:
SYSCALL(getpid)
 347:	b8 0b 00 00 00       	mov    $0xb,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <sbrk>:
SYSCALL(sbrk)
 34f:	b8 0c 00 00 00       	mov    $0xc,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <sleep>:
SYSCALL(sleep)
 357:	b8 0d 00 00 00       	mov    $0xd,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <uptime>:
SYSCALL(uptime)
 35f:	b8 0e 00 00 00       	mov    $0xe,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <getcwd>:
SYSCALL(getcwd)
 367:	b8 16 00 00 00       	mov    $0x16,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <ps>:
SYSCALL(ps)
 36f:	b8 17 00 00 00       	mov    $0x17,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 377:	55                   	push   %ebp
 378:	89 e5                	mov    %esp,%ebp
 37a:	83 ec 18             	sub    $0x18,%esp
 37d:	8b 45 0c             	mov    0xc(%ebp),%eax
 380:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 383:	83 ec 04             	sub    $0x4,%esp
 386:	6a 01                	push   $0x1
 388:	8d 45 f4             	lea    -0xc(%ebp),%eax
 38b:	50                   	push   %eax
 38c:	ff 75 08             	pushl  0x8(%ebp)
 38f:	e8 53 ff ff ff       	call   2e7 <write>
 394:	83 c4 10             	add    $0x10,%esp
}
 397:	c9                   	leave  
 398:	c3                   	ret    

00000399 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 399:	55                   	push   %ebp
 39a:	89 e5                	mov    %esp,%ebp
 39c:	53                   	push   %ebx
 39d:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3a0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3a7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3ab:	74 17                	je     3c4 <printint+0x2b>
 3ad:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3b1:	79 11                	jns    3c4 <printint+0x2b>
    neg = 1;
 3b3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 3bd:	f7 d8                	neg    %eax
 3bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3c2:	eb 06                	jmp    3ca <printint+0x31>
  } else {
    x = xx;
 3c4:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3d1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3d4:	8d 41 01             	lea    0x1(%ecx),%eax
 3d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3da:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3e0:	ba 00 00 00 00       	mov    $0x0,%edx
 3e5:	f7 f3                	div    %ebx
 3e7:	89 d0                	mov    %edx,%eax
 3e9:	0f b6 80 68 0a 00 00 	movzbl 0xa68(%eax),%eax
 3f0:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3f4:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3fa:	ba 00 00 00 00       	mov    $0x0,%edx
 3ff:	f7 f3                	div    %ebx
 401:	89 45 ec             	mov    %eax,-0x14(%ebp)
 404:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 408:	75 c7                	jne    3d1 <printint+0x38>
  if(neg)
 40a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 40e:	74 0e                	je     41e <printint+0x85>
    buf[i++] = '-';
 410:	8b 45 f4             	mov    -0xc(%ebp),%eax
 413:	8d 50 01             	lea    0x1(%eax),%edx
 416:	89 55 f4             	mov    %edx,-0xc(%ebp)
 419:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 41e:	eb 1d                	jmp    43d <printint+0xa4>
    putc(fd, buf[i]);
 420:	8d 55 dc             	lea    -0x24(%ebp),%edx
 423:	8b 45 f4             	mov    -0xc(%ebp),%eax
 426:	01 d0                	add    %edx,%eax
 428:	0f b6 00             	movzbl (%eax),%eax
 42b:	0f be c0             	movsbl %al,%eax
 42e:	83 ec 08             	sub    $0x8,%esp
 431:	50                   	push   %eax
 432:	ff 75 08             	pushl  0x8(%ebp)
 435:	e8 3d ff ff ff       	call   377 <putc>
 43a:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 43d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 441:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 445:	79 d9                	jns    420 <printint+0x87>
    putc(fd, buf[i]);
}
 447:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 44a:	c9                   	leave  
 44b:	c3                   	ret    

0000044c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 44c:	55                   	push   %ebp
 44d:	89 e5                	mov    %esp,%ebp
 44f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 452:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 459:	8d 45 0c             	lea    0xc(%ebp),%eax
 45c:	83 c0 04             	add    $0x4,%eax
 45f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 462:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 469:	e9 59 01 00 00       	jmp    5c7 <printf+0x17b>
    c = fmt[i] & 0xff;
 46e:	8b 55 0c             	mov    0xc(%ebp),%edx
 471:	8b 45 f0             	mov    -0x10(%ebp),%eax
 474:	01 d0                	add    %edx,%eax
 476:	0f b6 00             	movzbl (%eax),%eax
 479:	0f be c0             	movsbl %al,%eax
 47c:	25 ff 00 00 00       	and    $0xff,%eax
 481:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 484:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 488:	75 2c                	jne    4b6 <printf+0x6a>
      if(c == '%'){
 48a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 48e:	75 0c                	jne    49c <printf+0x50>
        state = '%';
 490:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 497:	e9 27 01 00 00       	jmp    5c3 <printf+0x177>
      } else {
        putc(fd, c);
 49c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 49f:	0f be c0             	movsbl %al,%eax
 4a2:	83 ec 08             	sub    $0x8,%esp
 4a5:	50                   	push   %eax
 4a6:	ff 75 08             	pushl  0x8(%ebp)
 4a9:	e8 c9 fe ff ff       	call   377 <putc>
 4ae:	83 c4 10             	add    $0x10,%esp
 4b1:	e9 0d 01 00 00       	jmp    5c3 <printf+0x177>
      }
    } else if(state == '%'){
 4b6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4ba:	0f 85 03 01 00 00    	jne    5c3 <printf+0x177>
      if(c == 'd'){
 4c0:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4c4:	75 1e                	jne    4e4 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4c6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4c9:	8b 00                	mov    (%eax),%eax
 4cb:	6a 01                	push   $0x1
 4cd:	6a 0a                	push   $0xa
 4cf:	50                   	push   %eax
 4d0:	ff 75 08             	pushl  0x8(%ebp)
 4d3:	e8 c1 fe ff ff       	call   399 <printint>
 4d8:	83 c4 10             	add    $0x10,%esp
        ap++;
 4db:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4df:	e9 d8 00 00 00       	jmp    5bc <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4e4:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4e8:	74 06                	je     4f0 <printf+0xa4>
 4ea:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4ee:	75 1e                	jne    50e <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4f0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4f3:	8b 00                	mov    (%eax),%eax
 4f5:	6a 00                	push   $0x0
 4f7:	6a 10                	push   $0x10
 4f9:	50                   	push   %eax
 4fa:	ff 75 08             	pushl  0x8(%ebp)
 4fd:	e8 97 fe ff ff       	call   399 <printint>
 502:	83 c4 10             	add    $0x10,%esp
        ap++;
 505:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 509:	e9 ae 00 00 00       	jmp    5bc <printf+0x170>
      } else if(c == 's'){
 50e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 512:	75 43                	jne    557 <printf+0x10b>
        s = (char*)*ap;
 514:	8b 45 e8             	mov    -0x18(%ebp),%eax
 517:	8b 00                	mov    (%eax),%eax
 519:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 51c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 520:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 524:	75 07                	jne    52d <printf+0xe1>
          s = "(null)";
 526:	c7 45 f4 14 08 00 00 	movl   $0x814,-0xc(%ebp)
        while(*s != 0){
 52d:	eb 1c                	jmp    54b <printf+0xff>
          putc(fd, *s);
 52f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 532:	0f b6 00             	movzbl (%eax),%eax
 535:	0f be c0             	movsbl %al,%eax
 538:	83 ec 08             	sub    $0x8,%esp
 53b:	50                   	push   %eax
 53c:	ff 75 08             	pushl  0x8(%ebp)
 53f:	e8 33 fe ff ff       	call   377 <putc>
 544:	83 c4 10             	add    $0x10,%esp
          s++;
 547:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 54b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 54e:	0f b6 00             	movzbl (%eax),%eax
 551:	84 c0                	test   %al,%al
 553:	75 da                	jne    52f <printf+0xe3>
 555:	eb 65                	jmp    5bc <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 557:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 55b:	75 1d                	jne    57a <printf+0x12e>
        putc(fd, *ap);
 55d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 560:	8b 00                	mov    (%eax),%eax
 562:	0f be c0             	movsbl %al,%eax
 565:	83 ec 08             	sub    $0x8,%esp
 568:	50                   	push   %eax
 569:	ff 75 08             	pushl  0x8(%ebp)
 56c:	e8 06 fe ff ff       	call   377 <putc>
 571:	83 c4 10             	add    $0x10,%esp
        ap++;
 574:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 578:	eb 42                	jmp    5bc <printf+0x170>
      } else if(c == '%'){
 57a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 57e:	75 17                	jne    597 <printf+0x14b>
        putc(fd, c);
 580:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 583:	0f be c0             	movsbl %al,%eax
 586:	83 ec 08             	sub    $0x8,%esp
 589:	50                   	push   %eax
 58a:	ff 75 08             	pushl  0x8(%ebp)
 58d:	e8 e5 fd ff ff       	call   377 <putc>
 592:	83 c4 10             	add    $0x10,%esp
 595:	eb 25                	jmp    5bc <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 597:	83 ec 08             	sub    $0x8,%esp
 59a:	6a 25                	push   $0x25
 59c:	ff 75 08             	pushl  0x8(%ebp)
 59f:	e8 d3 fd ff ff       	call   377 <putc>
 5a4:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5aa:	0f be c0             	movsbl %al,%eax
 5ad:	83 ec 08             	sub    $0x8,%esp
 5b0:	50                   	push   %eax
 5b1:	ff 75 08             	pushl  0x8(%ebp)
 5b4:	e8 be fd ff ff       	call   377 <putc>
 5b9:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5bc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5c3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5c7:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5cd:	01 d0                	add    %edx,%eax
 5cf:	0f b6 00             	movzbl (%eax),%eax
 5d2:	84 c0                	test   %al,%al
 5d4:	0f 85 94 fe ff ff    	jne    46e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5da:	c9                   	leave  
 5db:	c3                   	ret    

000005dc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5dc:	55                   	push   %ebp
 5dd:	89 e5                	mov    %esp,%ebp
 5df:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5e2:	8b 45 08             	mov    0x8(%ebp),%eax
 5e5:	83 e8 08             	sub    $0x8,%eax
 5e8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5eb:	a1 84 0a 00 00       	mov    0xa84,%eax
 5f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5f3:	eb 24                	jmp    619 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f8:	8b 00                	mov    (%eax),%eax
 5fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5fd:	77 12                	ja     611 <free+0x35>
 5ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
 602:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 605:	77 24                	ja     62b <free+0x4f>
 607:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60a:	8b 00                	mov    (%eax),%eax
 60c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 60f:	77 1a                	ja     62b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 611:	8b 45 fc             	mov    -0x4(%ebp),%eax
 614:	8b 00                	mov    (%eax),%eax
 616:	89 45 fc             	mov    %eax,-0x4(%ebp)
 619:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 61f:	76 d4                	jbe    5f5 <free+0x19>
 621:	8b 45 fc             	mov    -0x4(%ebp),%eax
 624:	8b 00                	mov    (%eax),%eax
 626:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 629:	76 ca                	jbe    5f5 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 62b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62e:	8b 40 04             	mov    0x4(%eax),%eax
 631:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 638:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63b:	01 c2                	add    %eax,%edx
 63d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 640:	8b 00                	mov    (%eax),%eax
 642:	39 c2                	cmp    %eax,%edx
 644:	75 24                	jne    66a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 646:	8b 45 f8             	mov    -0x8(%ebp),%eax
 649:	8b 50 04             	mov    0x4(%eax),%edx
 64c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64f:	8b 00                	mov    (%eax),%eax
 651:	8b 40 04             	mov    0x4(%eax),%eax
 654:	01 c2                	add    %eax,%edx
 656:	8b 45 f8             	mov    -0x8(%ebp),%eax
 659:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 65c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65f:	8b 00                	mov    (%eax),%eax
 661:	8b 10                	mov    (%eax),%edx
 663:	8b 45 f8             	mov    -0x8(%ebp),%eax
 666:	89 10                	mov    %edx,(%eax)
 668:	eb 0a                	jmp    674 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 66a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66d:	8b 10                	mov    (%eax),%edx
 66f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 672:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 674:	8b 45 fc             	mov    -0x4(%ebp),%eax
 677:	8b 40 04             	mov    0x4(%eax),%eax
 67a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 681:	8b 45 fc             	mov    -0x4(%ebp),%eax
 684:	01 d0                	add    %edx,%eax
 686:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 689:	75 20                	jne    6ab <free+0xcf>
    p->s.size += bp->s.size;
 68b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68e:	8b 50 04             	mov    0x4(%eax),%edx
 691:	8b 45 f8             	mov    -0x8(%ebp),%eax
 694:	8b 40 04             	mov    0x4(%eax),%eax
 697:	01 c2                	add    %eax,%edx
 699:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 69f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a2:	8b 10                	mov    (%eax),%edx
 6a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a7:	89 10                	mov    %edx,(%eax)
 6a9:	eb 08                	jmp    6b3 <free+0xd7>
  } else
    p->s.ptr = bp;
 6ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ae:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6b1:	89 10                	mov    %edx,(%eax)
  freep = p;
 6b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b6:	a3 84 0a 00 00       	mov    %eax,0xa84
}
 6bb:	c9                   	leave  
 6bc:	c3                   	ret    

000006bd <morecore>:

static Header*
morecore(uint nu)
{
 6bd:	55                   	push   %ebp
 6be:	89 e5                	mov    %esp,%ebp
 6c0:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6c3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6ca:	77 07                	ja     6d3 <morecore+0x16>
    nu = 4096;
 6cc:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6d3:	8b 45 08             	mov    0x8(%ebp),%eax
 6d6:	c1 e0 03             	shl    $0x3,%eax
 6d9:	83 ec 0c             	sub    $0xc,%esp
 6dc:	50                   	push   %eax
 6dd:	e8 6d fc ff ff       	call   34f <sbrk>
 6e2:	83 c4 10             	add    $0x10,%esp
 6e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6e8:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6ec:	75 07                	jne    6f5 <morecore+0x38>
    return 0;
 6ee:	b8 00 00 00 00       	mov    $0x0,%eax
 6f3:	eb 26                	jmp    71b <morecore+0x5e>
  hp = (Header*)p;
 6f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6fe:	8b 55 08             	mov    0x8(%ebp),%edx
 701:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 704:	8b 45 f0             	mov    -0x10(%ebp),%eax
 707:	83 c0 08             	add    $0x8,%eax
 70a:	83 ec 0c             	sub    $0xc,%esp
 70d:	50                   	push   %eax
 70e:	e8 c9 fe ff ff       	call   5dc <free>
 713:	83 c4 10             	add    $0x10,%esp
  return freep;
 716:	a1 84 0a 00 00       	mov    0xa84,%eax
}
 71b:	c9                   	leave  
 71c:	c3                   	ret    

0000071d <malloc>:

void*
malloc(uint nbytes)
{
 71d:	55                   	push   %ebp
 71e:	89 e5                	mov    %esp,%ebp
 720:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 723:	8b 45 08             	mov    0x8(%ebp),%eax
 726:	83 c0 07             	add    $0x7,%eax
 729:	c1 e8 03             	shr    $0x3,%eax
 72c:	83 c0 01             	add    $0x1,%eax
 72f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 732:	a1 84 0a 00 00       	mov    0xa84,%eax
 737:	89 45 f0             	mov    %eax,-0x10(%ebp)
 73a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 73e:	75 23                	jne    763 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 740:	c7 45 f0 7c 0a 00 00 	movl   $0xa7c,-0x10(%ebp)
 747:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74a:	a3 84 0a 00 00       	mov    %eax,0xa84
 74f:	a1 84 0a 00 00       	mov    0xa84,%eax
 754:	a3 7c 0a 00 00       	mov    %eax,0xa7c
    base.s.size = 0;
 759:	c7 05 80 0a 00 00 00 	movl   $0x0,0xa80
 760:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 763:	8b 45 f0             	mov    -0x10(%ebp),%eax
 766:	8b 00                	mov    (%eax),%eax
 768:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 76b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76e:	8b 40 04             	mov    0x4(%eax),%eax
 771:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 774:	72 4d                	jb     7c3 <malloc+0xa6>
      if(p->s.size == nunits)
 776:	8b 45 f4             	mov    -0xc(%ebp),%eax
 779:	8b 40 04             	mov    0x4(%eax),%eax
 77c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 77f:	75 0c                	jne    78d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 781:	8b 45 f4             	mov    -0xc(%ebp),%eax
 784:	8b 10                	mov    (%eax),%edx
 786:	8b 45 f0             	mov    -0x10(%ebp),%eax
 789:	89 10                	mov    %edx,(%eax)
 78b:	eb 26                	jmp    7b3 <malloc+0x96>
      else {
        p->s.size -= nunits;
 78d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 790:	8b 40 04             	mov    0x4(%eax),%eax
 793:	2b 45 ec             	sub    -0x14(%ebp),%eax
 796:	89 c2                	mov    %eax,%edx
 798:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 79e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a1:	8b 40 04             	mov    0x4(%eax),%eax
 7a4:	c1 e0 03             	shl    $0x3,%eax
 7a7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ad:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7b0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b6:	a3 84 0a 00 00       	mov    %eax,0xa84
      return (void*)(p + 1);
 7bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7be:	83 c0 08             	add    $0x8,%eax
 7c1:	eb 3b                	jmp    7fe <malloc+0xe1>
    }
    if(p == freep)
 7c3:	a1 84 0a 00 00       	mov    0xa84,%eax
 7c8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7cb:	75 1e                	jne    7eb <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7cd:	83 ec 0c             	sub    $0xc,%esp
 7d0:	ff 75 ec             	pushl  -0x14(%ebp)
 7d3:	e8 e5 fe ff ff       	call   6bd <morecore>
 7d8:	83 c4 10             	add    $0x10,%esp
 7db:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7e2:	75 07                	jne    7eb <malloc+0xce>
        return 0;
 7e4:	b8 00 00 00 00       	mov    $0x0,%eax
 7e9:	eb 13                	jmp    7fe <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f4:	8b 00                	mov    (%eax),%eax
 7f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7f9:	e9 6d ff ff ff       	jmp    76b <malloc+0x4e>
}
 7fe:	c9                   	leave  
 7ff:	c3                   	ret    
