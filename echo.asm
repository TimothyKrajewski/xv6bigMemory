
_echo:     file format elf32-i386


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
   f:	83 ec 10             	sub    $0x10,%esp
  12:	89 cb                	mov    %ecx,%ebx
  int i;

  for(i = 1; i < argc; i++)
  14:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  1b:	eb 3c                	jmp    59 <main+0x59>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  20:	83 c0 01             	add    $0x1,%eax
  23:	3b 03                	cmp    (%ebx),%eax
  25:	7d 07                	jge    2e <main+0x2e>
  27:	ba f3 07 00 00       	mov    $0x7f3,%edx
  2c:	eb 05                	jmp    33 <main+0x33>
  2e:	ba f5 07 00 00       	mov    $0x7f5,%edx
  33:	8b 45 f4             	mov    -0xc(%ebp),%eax
  36:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  3d:	8b 43 04             	mov    0x4(%ebx),%eax
  40:	01 c8                	add    %ecx,%eax
  42:	8b 00                	mov    (%eax),%eax
  44:	52                   	push   %edx
  45:	50                   	push   %eax
  46:	68 f7 07 00 00       	push   $0x7f7
  4b:	6a 01                	push   $0x1
  4d:	e8 ed 03 00 00       	call   43f <printf>
  52:	83 c4 10             	add    $0x10,%esp
int
main(int argc, char *argv[])
{
  int i;

  for(i = 1; i < argc; i++)
  55:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  59:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5c:	3b 03                	cmp    (%ebx),%eax
  5e:	7c bd                	jl     1d <main+0x1d>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  exit();
  60:	e8 55 02 00 00       	call   2ba <exit>

00000065 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  65:	55                   	push   %ebp
  66:	89 e5                	mov    %esp,%ebp
  68:	57                   	push   %edi
  69:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  6a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6d:	8b 55 10             	mov    0x10(%ebp),%edx
  70:	8b 45 0c             	mov    0xc(%ebp),%eax
  73:	89 cb                	mov    %ecx,%ebx
  75:	89 df                	mov    %ebx,%edi
  77:	89 d1                	mov    %edx,%ecx
  79:	fc                   	cld    
  7a:	f3 aa                	rep stos %al,%es:(%edi)
  7c:	89 ca                	mov    %ecx,%edx
  7e:	89 fb                	mov    %edi,%ebx
  80:	89 5d 08             	mov    %ebx,0x8(%ebp)
  83:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  86:	5b                   	pop    %ebx
  87:	5f                   	pop    %edi
  88:	5d                   	pop    %ebp
  89:	c3                   	ret    

0000008a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  8a:	55                   	push   %ebp
  8b:	89 e5                	mov    %esp,%ebp
  8d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  90:	8b 45 08             	mov    0x8(%ebp),%eax
  93:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  96:	90                   	nop
  97:	8b 45 08             	mov    0x8(%ebp),%eax
  9a:	8d 50 01             	lea    0x1(%eax),%edx
  9d:	89 55 08             	mov    %edx,0x8(%ebp)
  a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  a3:	8d 4a 01             	lea    0x1(%edx),%ecx
  a6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  a9:	0f b6 12             	movzbl (%edx),%edx
  ac:	88 10                	mov    %dl,(%eax)
  ae:	0f b6 00             	movzbl (%eax),%eax
  b1:	84 c0                	test   %al,%al
  b3:	75 e2                	jne    97 <strcpy+0xd>
    ;
  return os;
  b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  b8:	c9                   	leave  
  b9:	c3                   	ret    

000000ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ba:	55                   	push   %ebp
  bb:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  bd:	eb 08                	jmp    c7 <strcmp+0xd>
    p++, q++;
  bf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c7:	8b 45 08             	mov    0x8(%ebp),%eax
  ca:	0f b6 00             	movzbl (%eax),%eax
  cd:	84 c0                	test   %al,%al
  cf:	74 10                	je     e1 <strcmp+0x27>
  d1:	8b 45 08             	mov    0x8(%ebp),%eax
  d4:	0f b6 10             	movzbl (%eax),%edx
  d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  da:	0f b6 00             	movzbl (%eax),%eax
  dd:	38 c2                	cmp    %al,%dl
  df:	74 de                	je     bf <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e1:	8b 45 08             	mov    0x8(%ebp),%eax
  e4:	0f b6 00             	movzbl (%eax),%eax
  e7:	0f b6 d0             	movzbl %al,%edx
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	0f b6 00             	movzbl (%eax),%eax
  f0:	0f b6 c0             	movzbl %al,%eax
  f3:	29 c2                	sub    %eax,%edx
  f5:	89 d0                	mov    %edx,%eax
}
  f7:	5d                   	pop    %ebp
  f8:	c3                   	ret    

000000f9 <strlen>:

uint
strlen(char *s)
{
  f9:	55                   	push   %ebp
  fa:	89 e5                	mov    %esp,%ebp
  fc:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 106:	eb 04                	jmp    10c <strlen+0x13>
 108:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 10c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 10f:	8b 45 08             	mov    0x8(%ebp),%eax
 112:	01 d0                	add    %edx,%eax
 114:	0f b6 00             	movzbl (%eax),%eax
 117:	84 c0                	test   %al,%al
 119:	75 ed                	jne    108 <strlen+0xf>
    ;
  return n;
 11b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 11e:	c9                   	leave  
 11f:	c3                   	ret    

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 123:	8b 45 10             	mov    0x10(%ebp),%eax
 126:	50                   	push   %eax
 127:	ff 75 0c             	pushl  0xc(%ebp)
 12a:	ff 75 08             	pushl  0x8(%ebp)
 12d:	e8 33 ff ff ff       	call   65 <stosb>
 132:	83 c4 0c             	add    $0xc,%esp
  return dst;
 135:	8b 45 08             	mov    0x8(%ebp),%eax
}
 138:	c9                   	leave  
 139:	c3                   	ret    

0000013a <strchr>:

char*
strchr(const char *s, char c)
{
 13a:	55                   	push   %ebp
 13b:	89 e5                	mov    %esp,%ebp
 13d:	83 ec 04             	sub    $0x4,%esp
 140:	8b 45 0c             	mov    0xc(%ebp),%eax
 143:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 146:	eb 14                	jmp    15c <strchr+0x22>
    if(*s == c)
 148:	8b 45 08             	mov    0x8(%ebp),%eax
 14b:	0f b6 00             	movzbl (%eax),%eax
 14e:	3a 45 fc             	cmp    -0x4(%ebp),%al
 151:	75 05                	jne    158 <strchr+0x1e>
      return (char*)s;
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	eb 13                	jmp    16b <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 158:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 15c:	8b 45 08             	mov    0x8(%ebp),%eax
 15f:	0f b6 00             	movzbl (%eax),%eax
 162:	84 c0                	test   %al,%al
 164:	75 e2                	jne    148 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 166:	b8 00 00 00 00       	mov    $0x0,%eax
}
 16b:	c9                   	leave  
 16c:	c3                   	ret    

0000016d <gets>:

char*
gets(char *buf, int max)
{
 16d:	55                   	push   %ebp
 16e:	89 e5                	mov    %esp,%ebp
 170:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 173:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 17a:	eb 44                	jmp    1c0 <gets+0x53>
    cc = read(0, &c, 1);
 17c:	83 ec 04             	sub    $0x4,%esp
 17f:	6a 01                	push   $0x1
 181:	8d 45 ef             	lea    -0x11(%ebp),%eax
 184:	50                   	push   %eax
 185:	6a 00                	push   $0x0
 187:	e8 46 01 00 00       	call   2d2 <read>
 18c:	83 c4 10             	add    $0x10,%esp
 18f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 192:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 196:	7f 02                	jg     19a <gets+0x2d>
      break;
 198:	eb 31                	jmp    1cb <gets+0x5e>
    buf[i++] = c;
 19a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19d:	8d 50 01             	lea    0x1(%eax),%edx
 1a0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1a3:	89 c2                	mov    %eax,%edx
 1a5:	8b 45 08             	mov    0x8(%ebp),%eax
 1a8:	01 c2                	add    %eax,%edx
 1aa:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ae:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1b0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1b4:	3c 0a                	cmp    $0xa,%al
 1b6:	74 13                	je     1cb <gets+0x5e>
 1b8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1bc:	3c 0d                	cmp    $0xd,%al
 1be:	74 0b                	je     1cb <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c3:	83 c0 01             	add    $0x1,%eax
 1c6:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1c9:	7c b1                	jl     17c <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1ce:	8b 45 08             	mov    0x8(%ebp),%eax
 1d1:	01 d0                	add    %edx,%eax
 1d3:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1d6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1d9:	c9                   	leave  
 1da:	c3                   	ret    

000001db <stat>:

int
stat(char *n, struct stat *st)
{
 1db:	55                   	push   %ebp
 1dc:	89 e5                	mov    %esp,%ebp
 1de:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e1:	83 ec 08             	sub    $0x8,%esp
 1e4:	6a 00                	push   $0x0
 1e6:	ff 75 08             	pushl  0x8(%ebp)
 1e9:	e8 0c 01 00 00       	call   2fa <open>
 1ee:	83 c4 10             	add    $0x10,%esp
 1f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1f4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1f8:	79 07                	jns    201 <stat+0x26>
    return -1;
 1fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1ff:	eb 25                	jmp    226 <stat+0x4b>
  r = fstat(fd, st);
 201:	83 ec 08             	sub    $0x8,%esp
 204:	ff 75 0c             	pushl  0xc(%ebp)
 207:	ff 75 f4             	pushl  -0xc(%ebp)
 20a:	e8 03 01 00 00       	call   312 <fstat>
 20f:	83 c4 10             	add    $0x10,%esp
 212:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 215:	83 ec 0c             	sub    $0xc,%esp
 218:	ff 75 f4             	pushl  -0xc(%ebp)
 21b:	e8 c2 00 00 00       	call   2e2 <close>
 220:	83 c4 10             	add    $0x10,%esp
  return r;
 223:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 226:	c9                   	leave  
 227:	c3                   	ret    

00000228 <atoi>:

int
atoi(const char *s)
{
 228:	55                   	push   %ebp
 229:	89 e5                	mov    %esp,%ebp
 22b:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 22e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 235:	eb 25                	jmp    25c <atoi+0x34>
    n = n*10 + *s++ - '0';
 237:	8b 55 fc             	mov    -0x4(%ebp),%edx
 23a:	89 d0                	mov    %edx,%eax
 23c:	c1 e0 02             	shl    $0x2,%eax
 23f:	01 d0                	add    %edx,%eax
 241:	01 c0                	add    %eax,%eax
 243:	89 c1                	mov    %eax,%ecx
 245:	8b 45 08             	mov    0x8(%ebp),%eax
 248:	8d 50 01             	lea    0x1(%eax),%edx
 24b:	89 55 08             	mov    %edx,0x8(%ebp)
 24e:	0f b6 00             	movzbl (%eax),%eax
 251:	0f be c0             	movsbl %al,%eax
 254:	01 c8                	add    %ecx,%eax
 256:	83 e8 30             	sub    $0x30,%eax
 259:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 25c:	8b 45 08             	mov    0x8(%ebp),%eax
 25f:	0f b6 00             	movzbl (%eax),%eax
 262:	3c 2f                	cmp    $0x2f,%al
 264:	7e 0a                	jle    270 <atoi+0x48>
 266:	8b 45 08             	mov    0x8(%ebp),%eax
 269:	0f b6 00             	movzbl (%eax),%eax
 26c:	3c 39                	cmp    $0x39,%al
 26e:	7e c7                	jle    237 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 270:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 273:	c9                   	leave  
 274:	c3                   	ret    

00000275 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 275:	55                   	push   %ebp
 276:	89 e5                	mov    %esp,%ebp
 278:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 27b:	8b 45 08             	mov    0x8(%ebp),%eax
 27e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 281:	8b 45 0c             	mov    0xc(%ebp),%eax
 284:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 287:	eb 17                	jmp    2a0 <memmove+0x2b>
    *dst++ = *src++;
 289:	8b 45 fc             	mov    -0x4(%ebp),%eax
 28c:	8d 50 01             	lea    0x1(%eax),%edx
 28f:	89 55 fc             	mov    %edx,-0x4(%ebp)
 292:	8b 55 f8             	mov    -0x8(%ebp),%edx
 295:	8d 4a 01             	lea    0x1(%edx),%ecx
 298:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 29b:	0f b6 12             	movzbl (%edx),%edx
 29e:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2a0:	8b 45 10             	mov    0x10(%ebp),%eax
 2a3:	8d 50 ff             	lea    -0x1(%eax),%edx
 2a6:	89 55 10             	mov    %edx,0x10(%ebp)
 2a9:	85 c0                	test   %eax,%eax
 2ab:	7f dc                	jg     289 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2ad:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2b0:	c9                   	leave  
 2b1:	c3                   	ret    

000002b2 <fork>:
 2b2:	b8 01 00 00 00       	mov    $0x1,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <exit>:
 2ba:	b8 02 00 00 00       	mov    $0x2,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <wait>:
 2c2:	b8 03 00 00 00       	mov    $0x3,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <pipe>:
 2ca:	b8 04 00 00 00       	mov    $0x4,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <read>:
 2d2:	b8 05 00 00 00       	mov    $0x5,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <write>:
 2da:	b8 10 00 00 00       	mov    $0x10,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <close>:
 2e2:	b8 15 00 00 00       	mov    $0x15,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <kill>:
 2ea:	b8 06 00 00 00       	mov    $0x6,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <exec>:
 2f2:	b8 07 00 00 00       	mov    $0x7,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <open>:
 2fa:	b8 0f 00 00 00       	mov    $0xf,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <mknod>:
 302:	b8 11 00 00 00       	mov    $0x11,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <unlink>:
 30a:	b8 12 00 00 00       	mov    $0x12,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <fstat>:
 312:	b8 08 00 00 00       	mov    $0x8,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <link>:
 31a:	b8 13 00 00 00       	mov    $0x13,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <mkdir>:
 322:	b8 14 00 00 00       	mov    $0x14,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <chdir>:
 32a:	b8 09 00 00 00       	mov    $0x9,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <dup>:
 332:	b8 0a 00 00 00       	mov    $0xa,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <getpid>:
 33a:	b8 0b 00 00 00       	mov    $0xb,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <sbrk>:
 342:	b8 0c 00 00 00       	mov    $0xc,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <sleep>:
 34a:	b8 0d 00 00 00       	mov    $0xd,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <uptime>:
 352:	b8 0e 00 00 00       	mov    $0xe,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <getcwd>:
 35a:	b8 16 00 00 00       	mov    $0x16,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <ps>:
 362:	b8 17 00 00 00       	mov    $0x17,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <putc>:
 36a:	55                   	push   %ebp
 36b:	89 e5                	mov    %esp,%ebp
 36d:	83 ec 18             	sub    $0x18,%esp
 370:	8b 45 0c             	mov    0xc(%ebp),%eax
 373:	88 45 f4             	mov    %al,-0xc(%ebp)
 376:	83 ec 04             	sub    $0x4,%esp
 379:	6a 01                	push   $0x1
 37b:	8d 45 f4             	lea    -0xc(%ebp),%eax
 37e:	50                   	push   %eax
 37f:	ff 75 08             	pushl  0x8(%ebp)
 382:	e8 53 ff ff ff       	call   2da <write>
 387:	83 c4 10             	add    $0x10,%esp
 38a:	c9                   	leave  
 38b:	c3                   	ret    

0000038c <printint>:
 38c:	55                   	push   %ebp
 38d:	89 e5                	mov    %esp,%ebp
 38f:	53                   	push   %ebx
 390:	83 ec 24             	sub    $0x24,%esp
 393:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 39a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 39e:	74 17                	je     3b7 <printint+0x2b>
 3a0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3a4:	79 11                	jns    3b7 <printint+0x2b>
 3a6:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 3ad:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b0:	f7 d8                	neg    %eax
 3b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3b5:	eb 06                	jmp    3bd <printint+0x31>
 3b7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 3c4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3c7:	8d 41 01             	lea    0x1(%ecx),%eax
 3ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3cd:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3d3:	ba 00 00 00 00       	mov    $0x0,%edx
 3d8:	f7 f3                	div    %ebx
 3da:	89 d0                	mov    %edx,%eax
 3dc:	0f b6 80 50 0a 00 00 	movzbl 0xa50(%eax),%eax
 3e3:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 3e7:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3ed:	ba 00 00 00 00       	mov    $0x0,%edx
 3f2:	f7 f3                	div    %ebx
 3f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3f7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3fb:	75 c7                	jne    3c4 <printint+0x38>
 3fd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 401:	74 0e                	je     411 <printint+0x85>
 403:	8b 45 f4             	mov    -0xc(%ebp),%eax
 406:	8d 50 01             	lea    0x1(%eax),%edx
 409:	89 55 f4             	mov    %edx,-0xc(%ebp)
 40c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 411:	eb 1d                	jmp    430 <printint+0xa4>
 413:	8d 55 dc             	lea    -0x24(%ebp),%edx
 416:	8b 45 f4             	mov    -0xc(%ebp),%eax
 419:	01 d0                	add    %edx,%eax
 41b:	0f b6 00             	movzbl (%eax),%eax
 41e:	0f be c0             	movsbl %al,%eax
 421:	83 ec 08             	sub    $0x8,%esp
 424:	50                   	push   %eax
 425:	ff 75 08             	pushl  0x8(%ebp)
 428:	e8 3d ff ff ff       	call   36a <putc>
 42d:	83 c4 10             	add    $0x10,%esp
 430:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 434:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 438:	79 d9                	jns    413 <printint+0x87>
 43a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 43d:	c9                   	leave  
 43e:	c3                   	ret    

0000043f <printf>:
 43f:	55                   	push   %ebp
 440:	89 e5                	mov    %esp,%ebp
 442:	83 ec 28             	sub    $0x28,%esp
 445:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 44c:	8d 45 0c             	lea    0xc(%ebp),%eax
 44f:	83 c0 04             	add    $0x4,%eax
 452:	89 45 e8             	mov    %eax,-0x18(%ebp)
 455:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 45c:	e9 59 01 00 00       	jmp    5ba <printf+0x17b>
 461:	8b 55 0c             	mov    0xc(%ebp),%edx
 464:	8b 45 f0             	mov    -0x10(%ebp),%eax
 467:	01 d0                	add    %edx,%eax
 469:	0f b6 00             	movzbl (%eax),%eax
 46c:	0f be c0             	movsbl %al,%eax
 46f:	25 ff 00 00 00       	and    $0xff,%eax
 474:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 477:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 47b:	75 2c                	jne    4a9 <printf+0x6a>
 47d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 481:	75 0c                	jne    48f <printf+0x50>
 483:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 48a:	e9 27 01 00 00       	jmp    5b6 <printf+0x177>
 48f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 492:	0f be c0             	movsbl %al,%eax
 495:	83 ec 08             	sub    $0x8,%esp
 498:	50                   	push   %eax
 499:	ff 75 08             	pushl  0x8(%ebp)
 49c:	e8 c9 fe ff ff       	call   36a <putc>
 4a1:	83 c4 10             	add    $0x10,%esp
 4a4:	e9 0d 01 00 00       	jmp    5b6 <printf+0x177>
 4a9:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4ad:	0f 85 03 01 00 00    	jne    5b6 <printf+0x177>
 4b3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4b7:	75 1e                	jne    4d7 <printf+0x98>
 4b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4bc:	8b 00                	mov    (%eax),%eax
 4be:	6a 01                	push   $0x1
 4c0:	6a 0a                	push   $0xa
 4c2:	50                   	push   %eax
 4c3:	ff 75 08             	pushl  0x8(%ebp)
 4c6:	e8 c1 fe ff ff       	call   38c <printint>
 4cb:	83 c4 10             	add    $0x10,%esp
 4ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4d2:	e9 d8 00 00 00       	jmp    5af <printf+0x170>
 4d7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4db:	74 06                	je     4e3 <printf+0xa4>
 4dd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4e1:	75 1e                	jne    501 <printf+0xc2>
 4e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e6:	8b 00                	mov    (%eax),%eax
 4e8:	6a 00                	push   $0x0
 4ea:	6a 10                	push   $0x10
 4ec:	50                   	push   %eax
 4ed:	ff 75 08             	pushl  0x8(%ebp)
 4f0:	e8 97 fe ff ff       	call   38c <printint>
 4f5:	83 c4 10             	add    $0x10,%esp
 4f8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4fc:	e9 ae 00 00 00       	jmp    5af <printf+0x170>
 501:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 505:	75 43                	jne    54a <printf+0x10b>
 507:	8b 45 e8             	mov    -0x18(%ebp),%eax
 50a:	8b 00                	mov    (%eax),%eax
 50c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 50f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 513:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 517:	75 07                	jne    520 <printf+0xe1>
 519:	c7 45 f4 fc 07 00 00 	movl   $0x7fc,-0xc(%ebp)
 520:	eb 1c                	jmp    53e <printf+0xff>
 522:	8b 45 f4             	mov    -0xc(%ebp),%eax
 525:	0f b6 00             	movzbl (%eax),%eax
 528:	0f be c0             	movsbl %al,%eax
 52b:	83 ec 08             	sub    $0x8,%esp
 52e:	50                   	push   %eax
 52f:	ff 75 08             	pushl  0x8(%ebp)
 532:	e8 33 fe ff ff       	call   36a <putc>
 537:	83 c4 10             	add    $0x10,%esp
 53a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 53e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 541:	0f b6 00             	movzbl (%eax),%eax
 544:	84 c0                	test   %al,%al
 546:	75 da                	jne    522 <printf+0xe3>
 548:	eb 65                	jmp    5af <printf+0x170>
 54a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 54e:	75 1d                	jne    56d <printf+0x12e>
 550:	8b 45 e8             	mov    -0x18(%ebp),%eax
 553:	8b 00                	mov    (%eax),%eax
 555:	0f be c0             	movsbl %al,%eax
 558:	83 ec 08             	sub    $0x8,%esp
 55b:	50                   	push   %eax
 55c:	ff 75 08             	pushl  0x8(%ebp)
 55f:	e8 06 fe ff ff       	call   36a <putc>
 564:	83 c4 10             	add    $0x10,%esp
 567:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 56b:	eb 42                	jmp    5af <printf+0x170>
 56d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 571:	75 17                	jne    58a <printf+0x14b>
 573:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 576:	0f be c0             	movsbl %al,%eax
 579:	83 ec 08             	sub    $0x8,%esp
 57c:	50                   	push   %eax
 57d:	ff 75 08             	pushl  0x8(%ebp)
 580:	e8 e5 fd ff ff       	call   36a <putc>
 585:	83 c4 10             	add    $0x10,%esp
 588:	eb 25                	jmp    5af <printf+0x170>
 58a:	83 ec 08             	sub    $0x8,%esp
 58d:	6a 25                	push   $0x25
 58f:	ff 75 08             	pushl  0x8(%ebp)
 592:	e8 d3 fd ff ff       	call   36a <putc>
 597:	83 c4 10             	add    $0x10,%esp
 59a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 59d:	0f be c0             	movsbl %al,%eax
 5a0:	83 ec 08             	sub    $0x8,%esp
 5a3:	50                   	push   %eax
 5a4:	ff 75 08             	pushl  0x8(%ebp)
 5a7:	e8 be fd ff ff       	call   36a <putc>
 5ac:	83 c4 10             	add    $0x10,%esp
 5af:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 5b6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5ba:	8b 55 0c             	mov    0xc(%ebp),%edx
 5bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5c0:	01 d0                	add    %edx,%eax
 5c2:	0f b6 00             	movzbl (%eax),%eax
 5c5:	84 c0                	test   %al,%al
 5c7:	0f 85 94 fe ff ff    	jne    461 <printf+0x22>
 5cd:	c9                   	leave  
 5ce:	c3                   	ret    

000005cf <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5cf:	55                   	push   %ebp
 5d0:	89 e5                	mov    %esp,%ebp
 5d2:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5d5:	8b 45 08             	mov    0x8(%ebp),%eax
 5d8:	83 e8 08             	sub    $0x8,%eax
 5db:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5de:	a1 6c 0a 00 00       	mov    0xa6c,%eax
 5e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5e6:	eb 24                	jmp    60c <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5eb:	8b 00                	mov    (%eax),%eax
 5ed:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f0:	77 12                	ja     604 <free+0x35>
 5f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f8:	77 24                	ja     61e <free+0x4f>
 5fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fd:	8b 00                	mov    (%eax),%eax
 5ff:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 602:	77 1a                	ja     61e <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 604:	8b 45 fc             	mov    -0x4(%ebp),%eax
 607:	8b 00                	mov    (%eax),%eax
 609:	89 45 fc             	mov    %eax,-0x4(%ebp)
 60c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 612:	76 d4                	jbe    5e8 <free+0x19>
 614:	8b 45 fc             	mov    -0x4(%ebp),%eax
 617:	8b 00                	mov    (%eax),%eax
 619:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 61c:	76 ca                	jbe    5e8 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 61e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 621:	8b 40 04             	mov    0x4(%eax),%eax
 624:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 62b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62e:	01 c2                	add    %eax,%edx
 630:	8b 45 fc             	mov    -0x4(%ebp),%eax
 633:	8b 00                	mov    (%eax),%eax
 635:	39 c2                	cmp    %eax,%edx
 637:	75 24                	jne    65d <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 639:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63c:	8b 50 04             	mov    0x4(%eax),%edx
 63f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 642:	8b 00                	mov    (%eax),%eax
 644:	8b 40 04             	mov    0x4(%eax),%eax
 647:	01 c2                	add    %eax,%edx
 649:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64c:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 64f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 652:	8b 00                	mov    (%eax),%eax
 654:	8b 10                	mov    (%eax),%edx
 656:	8b 45 f8             	mov    -0x8(%ebp),%eax
 659:	89 10                	mov    %edx,(%eax)
 65b:	eb 0a                	jmp    667 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 65d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 660:	8b 10                	mov    (%eax),%edx
 662:	8b 45 f8             	mov    -0x8(%ebp),%eax
 665:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 667:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66a:	8b 40 04             	mov    0x4(%eax),%eax
 66d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 674:	8b 45 fc             	mov    -0x4(%ebp),%eax
 677:	01 d0                	add    %edx,%eax
 679:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 67c:	75 20                	jne    69e <free+0xcf>
    p->s.size += bp->s.size;
 67e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 681:	8b 50 04             	mov    0x4(%eax),%edx
 684:	8b 45 f8             	mov    -0x8(%ebp),%eax
 687:	8b 40 04             	mov    0x4(%eax),%eax
 68a:	01 c2                	add    %eax,%edx
 68c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 692:	8b 45 f8             	mov    -0x8(%ebp),%eax
 695:	8b 10                	mov    (%eax),%edx
 697:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69a:	89 10                	mov    %edx,(%eax)
 69c:	eb 08                	jmp    6a6 <free+0xd7>
  } else
    p->s.ptr = bp;
 69e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a1:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6a4:	89 10                	mov    %edx,(%eax)
  freep = p;
 6a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a9:	a3 6c 0a 00 00       	mov    %eax,0xa6c
}
 6ae:	c9                   	leave  
 6af:	c3                   	ret    

000006b0 <morecore>:

static Header*
morecore(uint nu)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6b6:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6bd:	77 07                	ja     6c6 <morecore+0x16>
    nu = 4096;
 6bf:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6c6:	8b 45 08             	mov    0x8(%ebp),%eax
 6c9:	c1 e0 03             	shl    $0x3,%eax
 6cc:	83 ec 0c             	sub    $0xc,%esp
 6cf:	50                   	push   %eax
 6d0:	e8 6d fc ff ff       	call   342 <sbrk>
 6d5:	83 c4 10             	add    $0x10,%esp
 6d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6db:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6df:	75 07                	jne    6e8 <morecore+0x38>
    return 0;
 6e1:	b8 00 00 00 00       	mov    $0x0,%eax
 6e6:	eb 26                	jmp    70e <morecore+0x5e>
  hp = (Header*)p;
 6e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f1:	8b 55 08             	mov    0x8(%ebp),%edx
 6f4:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6fa:	83 c0 08             	add    $0x8,%eax
 6fd:	83 ec 0c             	sub    $0xc,%esp
 700:	50                   	push   %eax
 701:	e8 c9 fe ff ff       	call   5cf <free>
 706:	83 c4 10             	add    $0x10,%esp
  return freep;
 709:	a1 6c 0a 00 00       	mov    0xa6c,%eax
}
 70e:	c9                   	leave  
 70f:	c3                   	ret    

00000710 <malloc>:

void*
malloc(uint nbytes)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 716:	8b 45 08             	mov    0x8(%ebp),%eax
 719:	83 c0 07             	add    $0x7,%eax
 71c:	c1 e8 03             	shr    $0x3,%eax
 71f:	83 c0 01             	add    $0x1,%eax
 722:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 725:	a1 6c 0a 00 00       	mov    0xa6c,%eax
 72a:	89 45 f0             	mov    %eax,-0x10(%ebp)
 72d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 731:	75 23                	jne    756 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 733:	c7 45 f0 64 0a 00 00 	movl   $0xa64,-0x10(%ebp)
 73a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73d:	a3 6c 0a 00 00       	mov    %eax,0xa6c
 742:	a1 6c 0a 00 00       	mov    0xa6c,%eax
 747:	a3 64 0a 00 00       	mov    %eax,0xa64
    base.s.size = 0;
 74c:	c7 05 68 0a 00 00 00 	movl   $0x0,0xa68
 753:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 756:	8b 45 f0             	mov    -0x10(%ebp),%eax
 759:	8b 00                	mov    (%eax),%eax
 75b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 75e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 761:	8b 40 04             	mov    0x4(%eax),%eax
 764:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 767:	72 4d                	jb     7b6 <malloc+0xa6>
      if(p->s.size == nunits)
 769:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76c:	8b 40 04             	mov    0x4(%eax),%eax
 76f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 772:	75 0c                	jne    780 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 774:	8b 45 f4             	mov    -0xc(%ebp),%eax
 777:	8b 10                	mov    (%eax),%edx
 779:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77c:	89 10                	mov    %edx,(%eax)
 77e:	eb 26                	jmp    7a6 <malloc+0x96>
      else {
        p->s.size -= nunits;
 780:	8b 45 f4             	mov    -0xc(%ebp),%eax
 783:	8b 40 04             	mov    0x4(%eax),%eax
 786:	2b 45 ec             	sub    -0x14(%ebp),%eax
 789:	89 c2                	mov    %eax,%edx
 78b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 791:	8b 45 f4             	mov    -0xc(%ebp),%eax
 794:	8b 40 04             	mov    0x4(%eax),%eax
 797:	c1 e0 03             	shl    $0x3,%eax
 79a:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 79d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a0:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7a3:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a9:	a3 6c 0a 00 00       	mov    %eax,0xa6c
      return (void*)(p + 1);
 7ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b1:	83 c0 08             	add    $0x8,%eax
 7b4:	eb 3b                	jmp    7f1 <malloc+0xe1>
    }
    if(p == freep)
 7b6:	a1 6c 0a 00 00       	mov    0xa6c,%eax
 7bb:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7be:	75 1e                	jne    7de <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7c0:	83 ec 0c             	sub    $0xc,%esp
 7c3:	ff 75 ec             	pushl  -0x14(%ebp)
 7c6:	e8 e5 fe ff ff       	call   6b0 <morecore>
 7cb:	83 c4 10             	add    $0x10,%esp
 7ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7d5:	75 07                	jne    7de <malloc+0xce>
        return 0;
 7d7:	b8 00 00 00 00       	mov    $0x0,%eax
 7dc:	eb 13                	jmp    7f1 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e7:	8b 00                	mov    (%eax),%eax
 7e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7ec:	e9 6d ff ff ff       	jmp    75e <malloc+0x4e>
}
 7f1:	c9                   	leave  
 7f2:	c3                   	ret    
