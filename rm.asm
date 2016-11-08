
_rm:     file format elf32-i386


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

  if(argc < 2){
  14:	83 3b 01             	cmpl   $0x1,(%ebx)
  17:	7f 17                	jg     30 <main+0x30>
    printf(2, "Usage: rm files...\n");
  19:	83 ec 08             	sub    $0x8,%esp
  1c:	68 1e 08 00 00       	push   $0x81e
  21:	6a 02                	push   $0x2
  23:	e8 42 04 00 00       	call   46a <printf>
  28:	83 c4 10             	add    $0x10,%esp
    exit();
  2b:	e8 b5 02 00 00       	call   2e5 <exit>
  }

  for(i = 1; i < argc; i++){
  30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  37:	eb 4b                	jmp    84 <main+0x84>
    if(unlink(argv[i]) < 0){
  39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  43:	8b 43 04             	mov    0x4(%ebx),%eax
  46:	01 d0                	add    %edx,%eax
  48:	8b 00                	mov    (%eax),%eax
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	50                   	push   %eax
  4e:	e8 e2 02 00 00       	call   335 <unlink>
  53:	83 c4 10             	add    $0x10,%esp
  56:	85 c0                	test   %eax,%eax
  58:	79 26                	jns    80 <main+0x80>
      printf(2, "rm: %s failed to delete\n", argv[i]);
  5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  64:	8b 43 04             	mov    0x4(%ebx),%eax
  67:	01 d0                	add    %edx,%eax
  69:	8b 00                	mov    (%eax),%eax
  6b:	83 ec 04             	sub    $0x4,%esp
  6e:	50                   	push   %eax
  6f:	68 32 08 00 00       	push   $0x832
  74:	6a 02                	push   $0x2
  76:	e8 ef 03 00 00       	call   46a <printf>
  7b:	83 c4 10             	add    $0x10,%esp
      break;
  7e:	eb 0b                	jmp    8b <main+0x8b>
  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  80:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  84:	8b 45 f4             	mov    -0xc(%ebp),%eax
  87:	3b 03                	cmp    (%ebx),%eax
  89:	7c ae                	jl     39 <main+0x39>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit();
  8b:	e8 55 02 00 00       	call   2e5 <exit>

00000090 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	57                   	push   %edi
  94:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  95:	8b 4d 08             	mov    0x8(%ebp),%ecx
  98:	8b 55 10             	mov    0x10(%ebp),%edx
  9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  9e:	89 cb                	mov    %ecx,%ebx
  a0:	89 df                	mov    %ebx,%edi
  a2:	89 d1                	mov    %edx,%ecx
  a4:	fc                   	cld    
  a5:	f3 aa                	rep stos %al,%es:(%edi)
  a7:	89 ca                	mov    %ecx,%edx
  a9:	89 fb                	mov    %edi,%ebx
  ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
  ae:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  b1:	5b                   	pop    %ebx
  b2:	5f                   	pop    %edi
  b3:	5d                   	pop    %ebp
  b4:	c3                   	ret    

000000b5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  b5:	55                   	push   %ebp
  b6:	89 e5                	mov    %esp,%ebp
  b8:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  bb:	8b 45 08             	mov    0x8(%ebp),%eax
  be:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  c1:	90                   	nop
  c2:	8b 45 08             	mov    0x8(%ebp),%eax
  c5:	8d 50 01             	lea    0x1(%eax),%edx
  c8:	89 55 08             	mov    %edx,0x8(%ebp)
  cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  ce:	8d 4a 01             	lea    0x1(%edx),%ecx
  d1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  d4:	0f b6 12             	movzbl (%edx),%edx
  d7:	88 10                	mov    %dl,(%eax)
  d9:	0f b6 00             	movzbl (%eax),%eax
  dc:	84 c0                	test   %al,%al
  de:	75 e2                	jne    c2 <strcpy+0xd>
    ;
  return os;
  e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e3:	c9                   	leave  
  e4:	c3                   	ret    

000000e5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e5:	55                   	push   %ebp
  e6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  e8:	eb 08                	jmp    f2 <strcmp+0xd>
    p++, q++;
  ea:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  ee:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  f2:	8b 45 08             	mov    0x8(%ebp),%eax
  f5:	0f b6 00             	movzbl (%eax),%eax
  f8:	84 c0                	test   %al,%al
  fa:	74 10                	je     10c <strcmp+0x27>
  fc:	8b 45 08             	mov    0x8(%ebp),%eax
  ff:	0f b6 10             	movzbl (%eax),%edx
 102:	8b 45 0c             	mov    0xc(%ebp),%eax
 105:	0f b6 00             	movzbl (%eax),%eax
 108:	38 c2                	cmp    %al,%dl
 10a:	74 de                	je     ea <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 10c:	8b 45 08             	mov    0x8(%ebp),%eax
 10f:	0f b6 00             	movzbl (%eax),%eax
 112:	0f b6 d0             	movzbl %al,%edx
 115:	8b 45 0c             	mov    0xc(%ebp),%eax
 118:	0f b6 00             	movzbl (%eax),%eax
 11b:	0f b6 c0             	movzbl %al,%eax
 11e:	29 c2                	sub    %eax,%edx
 120:	89 d0                	mov    %edx,%eax
}
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    

00000124 <strlen>:

uint
strlen(char *s)
{
 124:	55                   	push   %ebp
 125:	89 e5                	mov    %esp,%ebp
 127:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 12a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 131:	eb 04                	jmp    137 <strlen+0x13>
 133:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 137:	8b 55 fc             	mov    -0x4(%ebp),%edx
 13a:	8b 45 08             	mov    0x8(%ebp),%eax
 13d:	01 d0                	add    %edx,%eax
 13f:	0f b6 00             	movzbl (%eax),%eax
 142:	84 c0                	test   %al,%al
 144:	75 ed                	jne    133 <strlen+0xf>
    ;
  return n;
 146:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 149:	c9                   	leave  
 14a:	c3                   	ret    

0000014b <memset>:

void*
memset(void *dst, int c, uint n)
{
 14b:	55                   	push   %ebp
 14c:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 14e:	8b 45 10             	mov    0x10(%ebp),%eax
 151:	50                   	push   %eax
 152:	ff 75 0c             	pushl  0xc(%ebp)
 155:	ff 75 08             	pushl  0x8(%ebp)
 158:	e8 33 ff ff ff       	call   90 <stosb>
 15d:	83 c4 0c             	add    $0xc,%esp
  return dst;
 160:	8b 45 08             	mov    0x8(%ebp),%eax
}
 163:	c9                   	leave  
 164:	c3                   	ret    

00000165 <strchr>:

char*
strchr(const char *s, char c)
{
 165:	55                   	push   %ebp
 166:	89 e5                	mov    %esp,%ebp
 168:	83 ec 04             	sub    $0x4,%esp
 16b:	8b 45 0c             	mov    0xc(%ebp),%eax
 16e:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 171:	eb 14                	jmp    187 <strchr+0x22>
    if(*s == c)
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	0f b6 00             	movzbl (%eax),%eax
 179:	3a 45 fc             	cmp    -0x4(%ebp),%al
 17c:	75 05                	jne    183 <strchr+0x1e>
      return (char*)s;
 17e:	8b 45 08             	mov    0x8(%ebp),%eax
 181:	eb 13                	jmp    196 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 183:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 187:	8b 45 08             	mov    0x8(%ebp),%eax
 18a:	0f b6 00             	movzbl (%eax),%eax
 18d:	84 c0                	test   %al,%al
 18f:	75 e2                	jne    173 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 191:	b8 00 00 00 00       	mov    $0x0,%eax
}
 196:	c9                   	leave  
 197:	c3                   	ret    

00000198 <gets>:

char*
gets(char *buf, int max)
{
 198:	55                   	push   %ebp
 199:	89 e5                	mov    %esp,%ebp
 19b:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1a5:	eb 44                	jmp    1eb <gets+0x53>
    cc = read(0, &c, 1);
 1a7:	83 ec 04             	sub    $0x4,%esp
 1aa:	6a 01                	push   $0x1
 1ac:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1af:	50                   	push   %eax
 1b0:	6a 00                	push   $0x0
 1b2:	e8 46 01 00 00       	call   2fd <read>
 1b7:	83 c4 10             	add    $0x10,%esp
 1ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1bd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1c1:	7f 02                	jg     1c5 <gets+0x2d>
      break;
 1c3:	eb 31                	jmp    1f6 <gets+0x5e>
    buf[i++] = c;
 1c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c8:	8d 50 01             	lea    0x1(%eax),%edx
 1cb:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1ce:	89 c2                	mov    %eax,%edx
 1d0:	8b 45 08             	mov    0x8(%ebp),%eax
 1d3:	01 c2                	add    %eax,%edx
 1d5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1db:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1df:	3c 0a                	cmp    $0xa,%al
 1e1:	74 13                	je     1f6 <gets+0x5e>
 1e3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e7:	3c 0d                	cmp    $0xd,%al
 1e9:	74 0b                	je     1f6 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ee:	83 c0 01             	add    $0x1,%eax
 1f1:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1f4:	7c b1                	jl     1a7 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1f9:	8b 45 08             	mov    0x8(%ebp),%eax
 1fc:	01 d0                	add    %edx,%eax
 1fe:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 201:	8b 45 08             	mov    0x8(%ebp),%eax
}
 204:	c9                   	leave  
 205:	c3                   	ret    

00000206 <stat>:

int
stat(char *n, struct stat *st)
{
 206:	55                   	push   %ebp
 207:	89 e5                	mov    %esp,%ebp
 209:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 20c:	83 ec 08             	sub    $0x8,%esp
 20f:	6a 00                	push   $0x0
 211:	ff 75 08             	pushl  0x8(%ebp)
 214:	e8 0c 01 00 00       	call   325 <open>
 219:	83 c4 10             	add    $0x10,%esp
 21c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 21f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 223:	79 07                	jns    22c <stat+0x26>
    return -1;
 225:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 22a:	eb 25                	jmp    251 <stat+0x4b>
  r = fstat(fd, st);
 22c:	83 ec 08             	sub    $0x8,%esp
 22f:	ff 75 0c             	pushl  0xc(%ebp)
 232:	ff 75 f4             	pushl  -0xc(%ebp)
 235:	e8 03 01 00 00       	call   33d <fstat>
 23a:	83 c4 10             	add    $0x10,%esp
 23d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 240:	83 ec 0c             	sub    $0xc,%esp
 243:	ff 75 f4             	pushl  -0xc(%ebp)
 246:	e8 c2 00 00 00       	call   30d <close>
 24b:	83 c4 10             	add    $0x10,%esp
  return r;
 24e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 251:	c9                   	leave  
 252:	c3                   	ret    

00000253 <atoi>:

int
atoi(const char *s)
{
 253:	55                   	push   %ebp
 254:	89 e5                	mov    %esp,%ebp
 256:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 259:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 260:	eb 25                	jmp    287 <atoi+0x34>
    n = n*10 + *s++ - '0';
 262:	8b 55 fc             	mov    -0x4(%ebp),%edx
 265:	89 d0                	mov    %edx,%eax
 267:	c1 e0 02             	shl    $0x2,%eax
 26a:	01 d0                	add    %edx,%eax
 26c:	01 c0                	add    %eax,%eax
 26e:	89 c1                	mov    %eax,%ecx
 270:	8b 45 08             	mov    0x8(%ebp),%eax
 273:	8d 50 01             	lea    0x1(%eax),%edx
 276:	89 55 08             	mov    %edx,0x8(%ebp)
 279:	0f b6 00             	movzbl (%eax),%eax
 27c:	0f be c0             	movsbl %al,%eax
 27f:	01 c8                	add    %ecx,%eax
 281:	83 e8 30             	sub    $0x30,%eax
 284:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 287:	8b 45 08             	mov    0x8(%ebp),%eax
 28a:	0f b6 00             	movzbl (%eax),%eax
 28d:	3c 2f                	cmp    $0x2f,%al
 28f:	7e 0a                	jle    29b <atoi+0x48>
 291:	8b 45 08             	mov    0x8(%ebp),%eax
 294:	0f b6 00             	movzbl (%eax),%eax
 297:	3c 39                	cmp    $0x39,%al
 299:	7e c7                	jle    262 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 29b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 29e:	c9                   	leave  
 29f:	c3                   	ret    

000002a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2a6:	8b 45 08             	mov    0x8(%ebp),%eax
 2a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2ac:	8b 45 0c             	mov    0xc(%ebp),%eax
 2af:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2b2:	eb 17                	jmp    2cb <memmove+0x2b>
    *dst++ = *src++;
 2b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2b7:	8d 50 01             	lea    0x1(%eax),%edx
 2ba:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2bd:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2c0:	8d 4a 01             	lea    0x1(%edx),%ecx
 2c3:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2c6:	0f b6 12             	movzbl (%edx),%edx
 2c9:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2cb:	8b 45 10             	mov    0x10(%ebp),%eax
 2ce:	8d 50 ff             	lea    -0x1(%eax),%edx
 2d1:	89 55 10             	mov    %edx,0x10(%ebp)
 2d4:	85 c0                	test   %eax,%eax
 2d6:	7f dc                	jg     2b4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2db:	c9                   	leave  
 2dc:	c3                   	ret    

000002dd <fork>:
 2dd:	b8 01 00 00 00       	mov    $0x1,%eax
 2e2:	cd 40                	int    $0x40
 2e4:	c3                   	ret    

000002e5 <exit>:
 2e5:	b8 02 00 00 00       	mov    $0x2,%eax
 2ea:	cd 40                	int    $0x40
 2ec:	c3                   	ret    

000002ed <wait>:
 2ed:	b8 03 00 00 00       	mov    $0x3,%eax
 2f2:	cd 40                	int    $0x40
 2f4:	c3                   	ret    

000002f5 <pipe>:
 2f5:	b8 04 00 00 00       	mov    $0x4,%eax
 2fa:	cd 40                	int    $0x40
 2fc:	c3                   	ret    

000002fd <read>:
 2fd:	b8 05 00 00 00       	mov    $0x5,%eax
 302:	cd 40                	int    $0x40
 304:	c3                   	ret    

00000305 <write>:
 305:	b8 10 00 00 00       	mov    $0x10,%eax
 30a:	cd 40                	int    $0x40
 30c:	c3                   	ret    

0000030d <close>:
 30d:	b8 15 00 00 00       	mov    $0x15,%eax
 312:	cd 40                	int    $0x40
 314:	c3                   	ret    

00000315 <kill>:
 315:	b8 06 00 00 00       	mov    $0x6,%eax
 31a:	cd 40                	int    $0x40
 31c:	c3                   	ret    

0000031d <exec>:
 31d:	b8 07 00 00 00       	mov    $0x7,%eax
 322:	cd 40                	int    $0x40
 324:	c3                   	ret    

00000325 <open>:
 325:	b8 0f 00 00 00       	mov    $0xf,%eax
 32a:	cd 40                	int    $0x40
 32c:	c3                   	ret    

0000032d <mknod>:
 32d:	b8 11 00 00 00       	mov    $0x11,%eax
 332:	cd 40                	int    $0x40
 334:	c3                   	ret    

00000335 <unlink>:
 335:	b8 12 00 00 00       	mov    $0x12,%eax
 33a:	cd 40                	int    $0x40
 33c:	c3                   	ret    

0000033d <fstat>:
 33d:	b8 08 00 00 00       	mov    $0x8,%eax
 342:	cd 40                	int    $0x40
 344:	c3                   	ret    

00000345 <link>:
 345:	b8 13 00 00 00       	mov    $0x13,%eax
 34a:	cd 40                	int    $0x40
 34c:	c3                   	ret    

0000034d <mkdir>:
 34d:	b8 14 00 00 00       	mov    $0x14,%eax
 352:	cd 40                	int    $0x40
 354:	c3                   	ret    

00000355 <chdir>:
 355:	b8 09 00 00 00       	mov    $0x9,%eax
 35a:	cd 40                	int    $0x40
 35c:	c3                   	ret    

0000035d <dup>:
 35d:	b8 0a 00 00 00       	mov    $0xa,%eax
 362:	cd 40                	int    $0x40
 364:	c3                   	ret    

00000365 <getpid>:
 365:	b8 0b 00 00 00       	mov    $0xb,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret    

0000036d <sbrk>:
 36d:	b8 0c 00 00 00       	mov    $0xc,%eax
 372:	cd 40                	int    $0x40
 374:	c3                   	ret    

00000375 <sleep>:
 375:	b8 0d 00 00 00       	mov    $0xd,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret    

0000037d <uptime>:
 37d:	b8 0e 00 00 00       	mov    $0xe,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret    

00000385 <getcwd>:
 385:	b8 16 00 00 00       	mov    $0x16,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret    

0000038d <ps>:
 38d:	b8 17 00 00 00       	mov    $0x17,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret    

00000395 <putc>:
 395:	55                   	push   %ebp
 396:	89 e5                	mov    %esp,%ebp
 398:	83 ec 18             	sub    $0x18,%esp
 39b:	8b 45 0c             	mov    0xc(%ebp),%eax
 39e:	88 45 f4             	mov    %al,-0xc(%ebp)
 3a1:	83 ec 04             	sub    $0x4,%esp
 3a4:	6a 01                	push   $0x1
 3a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3a9:	50                   	push   %eax
 3aa:	ff 75 08             	pushl  0x8(%ebp)
 3ad:	e8 53 ff ff ff       	call   305 <write>
 3b2:	83 c4 10             	add    $0x10,%esp
 3b5:	c9                   	leave  
 3b6:	c3                   	ret    

000003b7 <printint>:
 3b7:	55                   	push   %ebp
 3b8:	89 e5                	mov    %esp,%ebp
 3ba:	53                   	push   %ebx
 3bb:	83 ec 24             	sub    $0x24,%esp
 3be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 3c5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3c9:	74 17                	je     3e2 <printint+0x2b>
 3cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3cf:	79 11                	jns    3e2 <printint+0x2b>
 3d1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 3d8:	8b 45 0c             	mov    0xc(%ebp),%eax
 3db:	f7 d8                	neg    %eax
 3dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3e0:	eb 06                	jmp    3e8 <printint+0x31>
 3e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 3ef:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3f2:	8d 41 01             	lea    0x1(%ecx),%eax
 3f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3f8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3fe:	ba 00 00 00 00       	mov    $0x0,%edx
 403:	f7 f3                	div    %ebx
 405:	89 d0                	mov    %edx,%eax
 407:	0f b6 80 a0 0a 00 00 	movzbl 0xaa0(%eax),%eax
 40e:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 412:	8b 5d 10             	mov    0x10(%ebp),%ebx
 415:	8b 45 ec             	mov    -0x14(%ebp),%eax
 418:	ba 00 00 00 00       	mov    $0x0,%edx
 41d:	f7 f3                	div    %ebx
 41f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 422:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 426:	75 c7                	jne    3ef <printint+0x38>
 428:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 42c:	74 0e                	je     43c <printint+0x85>
 42e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 431:	8d 50 01             	lea    0x1(%eax),%edx
 434:	89 55 f4             	mov    %edx,-0xc(%ebp)
 437:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 43c:	eb 1d                	jmp    45b <printint+0xa4>
 43e:	8d 55 dc             	lea    -0x24(%ebp),%edx
 441:	8b 45 f4             	mov    -0xc(%ebp),%eax
 444:	01 d0                	add    %edx,%eax
 446:	0f b6 00             	movzbl (%eax),%eax
 449:	0f be c0             	movsbl %al,%eax
 44c:	83 ec 08             	sub    $0x8,%esp
 44f:	50                   	push   %eax
 450:	ff 75 08             	pushl  0x8(%ebp)
 453:	e8 3d ff ff ff       	call   395 <putc>
 458:	83 c4 10             	add    $0x10,%esp
 45b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 45f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 463:	79 d9                	jns    43e <printint+0x87>
 465:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 468:	c9                   	leave  
 469:	c3                   	ret    

0000046a <printf>:
 46a:	55                   	push   %ebp
 46b:	89 e5                	mov    %esp,%ebp
 46d:	83 ec 28             	sub    $0x28,%esp
 470:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 477:	8d 45 0c             	lea    0xc(%ebp),%eax
 47a:	83 c0 04             	add    $0x4,%eax
 47d:	89 45 e8             	mov    %eax,-0x18(%ebp)
 480:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 487:	e9 59 01 00 00       	jmp    5e5 <printf+0x17b>
 48c:	8b 55 0c             	mov    0xc(%ebp),%edx
 48f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 492:	01 d0                	add    %edx,%eax
 494:	0f b6 00             	movzbl (%eax),%eax
 497:	0f be c0             	movsbl %al,%eax
 49a:	25 ff 00 00 00       	and    $0xff,%eax
 49f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 4a2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4a6:	75 2c                	jne    4d4 <printf+0x6a>
 4a8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ac:	75 0c                	jne    4ba <printf+0x50>
 4ae:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4b5:	e9 27 01 00 00       	jmp    5e1 <printf+0x177>
 4ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4bd:	0f be c0             	movsbl %al,%eax
 4c0:	83 ec 08             	sub    $0x8,%esp
 4c3:	50                   	push   %eax
 4c4:	ff 75 08             	pushl  0x8(%ebp)
 4c7:	e8 c9 fe ff ff       	call   395 <putc>
 4cc:	83 c4 10             	add    $0x10,%esp
 4cf:	e9 0d 01 00 00       	jmp    5e1 <printf+0x177>
 4d4:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4d8:	0f 85 03 01 00 00    	jne    5e1 <printf+0x177>
 4de:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4e2:	75 1e                	jne    502 <printf+0x98>
 4e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e7:	8b 00                	mov    (%eax),%eax
 4e9:	6a 01                	push   $0x1
 4eb:	6a 0a                	push   $0xa
 4ed:	50                   	push   %eax
 4ee:	ff 75 08             	pushl  0x8(%ebp)
 4f1:	e8 c1 fe ff ff       	call   3b7 <printint>
 4f6:	83 c4 10             	add    $0x10,%esp
 4f9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4fd:	e9 d8 00 00 00       	jmp    5da <printf+0x170>
 502:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 506:	74 06                	je     50e <printf+0xa4>
 508:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 50c:	75 1e                	jne    52c <printf+0xc2>
 50e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 511:	8b 00                	mov    (%eax),%eax
 513:	6a 00                	push   $0x0
 515:	6a 10                	push   $0x10
 517:	50                   	push   %eax
 518:	ff 75 08             	pushl  0x8(%ebp)
 51b:	e8 97 fe ff ff       	call   3b7 <printint>
 520:	83 c4 10             	add    $0x10,%esp
 523:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 527:	e9 ae 00 00 00       	jmp    5da <printf+0x170>
 52c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 530:	75 43                	jne    575 <printf+0x10b>
 532:	8b 45 e8             	mov    -0x18(%ebp),%eax
 535:	8b 00                	mov    (%eax),%eax
 537:	89 45 f4             	mov    %eax,-0xc(%ebp)
 53a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 53e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 542:	75 07                	jne    54b <printf+0xe1>
 544:	c7 45 f4 4b 08 00 00 	movl   $0x84b,-0xc(%ebp)
 54b:	eb 1c                	jmp    569 <printf+0xff>
 54d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 550:	0f b6 00             	movzbl (%eax),%eax
 553:	0f be c0             	movsbl %al,%eax
 556:	83 ec 08             	sub    $0x8,%esp
 559:	50                   	push   %eax
 55a:	ff 75 08             	pushl  0x8(%ebp)
 55d:	e8 33 fe ff ff       	call   395 <putc>
 562:	83 c4 10             	add    $0x10,%esp
 565:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 569:	8b 45 f4             	mov    -0xc(%ebp),%eax
 56c:	0f b6 00             	movzbl (%eax),%eax
 56f:	84 c0                	test   %al,%al
 571:	75 da                	jne    54d <printf+0xe3>
 573:	eb 65                	jmp    5da <printf+0x170>
 575:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 579:	75 1d                	jne    598 <printf+0x12e>
 57b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 57e:	8b 00                	mov    (%eax),%eax
 580:	0f be c0             	movsbl %al,%eax
 583:	83 ec 08             	sub    $0x8,%esp
 586:	50                   	push   %eax
 587:	ff 75 08             	pushl  0x8(%ebp)
 58a:	e8 06 fe ff ff       	call   395 <putc>
 58f:	83 c4 10             	add    $0x10,%esp
 592:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 596:	eb 42                	jmp    5da <printf+0x170>
 598:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 59c:	75 17                	jne    5b5 <printf+0x14b>
 59e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a1:	0f be c0             	movsbl %al,%eax
 5a4:	83 ec 08             	sub    $0x8,%esp
 5a7:	50                   	push   %eax
 5a8:	ff 75 08             	pushl  0x8(%ebp)
 5ab:	e8 e5 fd ff ff       	call   395 <putc>
 5b0:	83 c4 10             	add    $0x10,%esp
 5b3:	eb 25                	jmp    5da <printf+0x170>
 5b5:	83 ec 08             	sub    $0x8,%esp
 5b8:	6a 25                	push   $0x25
 5ba:	ff 75 08             	pushl  0x8(%ebp)
 5bd:	e8 d3 fd ff ff       	call   395 <putc>
 5c2:	83 c4 10             	add    $0x10,%esp
 5c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5c8:	0f be c0             	movsbl %al,%eax
 5cb:	83 ec 08             	sub    $0x8,%esp
 5ce:	50                   	push   %eax
 5cf:	ff 75 08             	pushl  0x8(%ebp)
 5d2:	e8 be fd ff ff       	call   395 <putc>
 5d7:	83 c4 10             	add    $0x10,%esp
 5da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 5e1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5e5:	8b 55 0c             	mov    0xc(%ebp),%edx
 5e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5eb:	01 d0                	add    %edx,%eax
 5ed:	0f b6 00             	movzbl (%eax),%eax
 5f0:	84 c0                	test   %al,%al
 5f2:	0f 85 94 fe ff ff    	jne    48c <printf+0x22>
 5f8:	c9                   	leave  
 5f9:	c3                   	ret    

000005fa <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5fa:	55                   	push   %ebp
 5fb:	89 e5                	mov    %esp,%ebp
 5fd:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 600:	8b 45 08             	mov    0x8(%ebp),%eax
 603:	83 e8 08             	sub    $0x8,%eax
 606:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 609:	a1 bc 0a 00 00       	mov    0xabc,%eax
 60e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 611:	eb 24                	jmp    637 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 613:	8b 45 fc             	mov    -0x4(%ebp),%eax
 616:	8b 00                	mov    (%eax),%eax
 618:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 61b:	77 12                	ja     62f <free+0x35>
 61d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 620:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 623:	77 24                	ja     649 <free+0x4f>
 625:	8b 45 fc             	mov    -0x4(%ebp),%eax
 628:	8b 00                	mov    (%eax),%eax
 62a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 62d:	77 1a                	ja     649 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 62f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 632:	8b 00                	mov    (%eax),%eax
 634:	89 45 fc             	mov    %eax,-0x4(%ebp)
 637:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 63d:	76 d4                	jbe    613 <free+0x19>
 63f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 642:	8b 00                	mov    (%eax),%eax
 644:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 647:	76 ca                	jbe    613 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 649:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64c:	8b 40 04             	mov    0x4(%eax),%eax
 64f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 656:	8b 45 f8             	mov    -0x8(%ebp),%eax
 659:	01 c2                	add    %eax,%edx
 65b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65e:	8b 00                	mov    (%eax),%eax
 660:	39 c2                	cmp    %eax,%edx
 662:	75 24                	jne    688 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 664:	8b 45 f8             	mov    -0x8(%ebp),%eax
 667:	8b 50 04             	mov    0x4(%eax),%edx
 66a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66d:	8b 00                	mov    (%eax),%eax
 66f:	8b 40 04             	mov    0x4(%eax),%eax
 672:	01 c2                	add    %eax,%edx
 674:	8b 45 f8             	mov    -0x8(%ebp),%eax
 677:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 67a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67d:	8b 00                	mov    (%eax),%eax
 67f:	8b 10                	mov    (%eax),%edx
 681:	8b 45 f8             	mov    -0x8(%ebp),%eax
 684:	89 10                	mov    %edx,(%eax)
 686:	eb 0a                	jmp    692 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 688:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68b:	8b 10                	mov    (%eax),%edx
 68d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 690:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 692:	8b 45 fc             	mov    -0x4(%ebp),%eax
 695:	8b 40 04             	mov    0x4(%eax),%eax
 698:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 69f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a2:	01 d0                	add    %edx,%eax
 6a4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a7:	75 20                	jne    6c9 <free+0xcf>
    p->s.size += bp->s.size;
 6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ac:	8b 50 04             	mov    0x4(%eax),%edx
 6af:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b2:	8b 40 04             	mov    0x4(%eax),%eax
 6b5:	01 c2                	add    %eax,%edx
 6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ba:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c0:	8b 10                	mov    (%eax),%edx
 6c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c5:	89 10                	mov    %edx,(%eax)
 6c7:	eb 08                	jmp    6d1 <free+0xd7>
  } else
    p->s.ptr = bp;
 6c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cc:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6cf:	89 10                	mov    %edx,(%eax)
  freep = p;
 6d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d4:	a3 bc 0a 00 00       	mov    %eax,0xabc
}
 6d9:	c9                   	leave  
 6da:	c3                   	ret    

000006db <morecore>:

static Header*
morecore(uint nu)
{
 6db:	55                   	push   %ebp
 6dc:	89 e5                	mov    %esp,%ebp
 6de:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6e1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6e8:	77 07                	ja     6f1 <morecore+0x16>
    nu = 4096;
 6ea:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6f1:	8b 45 08             	mov    0x8(%ebp),%eax
 6f4:	c1 e0 03             	shl    $0x3,%eax
 6f7:	83 ec 0c             	sub    $0xc,%esp
 6fa:	50                   	push   %eax
 6fb:	e8 6d fc ff ff       	call   36d <sbrk>
 700:	83 c4 10             	add    $0x10,%esp
 703:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 706:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 70a:	75 07                	jne    713 <morecore+0x38>
    return 0;
 70c:	b8 00 00 00 00       	mov    $0x0,%eax
 711:	eb 26                	jmp    739 <morecore+0x5e>
  hp = (Header*)p;
 713:	8b 45 f4             	mov    -0xc(%ebp),%eax
 716:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 719:	8b 45 f0             	mov    -0x10(%ebp),%eax
 71c:	8b 55 08             	mov    0x8(%ebp),%edx
 71f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 722:	8b 45 f0             	mov    -0x10(%ebp),%eax
 725:	83 c0 08             	add    $0x8,%eax
 728:	83 ec 0c             	sub    $0xc,%esp
 72b:	50                   	push   %eax
 72c:	e8 c9 fe ff ff       	call   5fa <free>
 731:	83 c4 10             	add    $0x10,%esp
  return freep;
 734:	a1 bc 0a 00 00       	mov    0xabc,%eax
}
 739:	c9                   	leave  
 73a:	c3                   	ret    

0000073b <malloc>:

void*
malloc(uint nbytes)
{
 73b:	55                   	push   %ebp
 73c:	89 e5                	mov    %esp,%ebp
 73e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 741:	8b 45 08             	mov    0x8(%ebp),%eax
 744:	83 c0 07             	add    $0x7,%eax
 747:	c1 e8 03             	shr    $0x3,%eax
 74a:	83 c0 01             	add    $0x1,%eax
 74d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 750:	a1 bc 0a 00 00       	mov    0xabc,%eax
 755:	89 45 f0             	mov    %eax,-0x10(%ebp)
 758:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 75c:	75 23                	jne    781 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 75e:	c7 45 f0 b4 0a 00 00 	movl   $0xab4,-0x10(%ebp)
 765:	8b 45 f0             	mov    -0x10(%ebp),%eax
 768:	a3 bc 0a 00 00       	mov    %eax,0xabc
 76d:	a1 bc 0a 00 00       	mov    0xabc,%eax
 772:	a3 b4 0a 00 00       	mov    %eax,0xab4
    base.s.size = 0;
 777:	c7 05 b8 0a 00 00 00 	movl   $0x0,0xab8
 77e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 781:	8b 45 f0             	mov    -0x10(%ebp),%eax
 784:	8b 00                	mov    (%eax),%eax
 786:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 789:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78c:	8b 40 04             	mov    0x4(%eax),%eax
 78f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 792:	72 4d                	jb     7e1 <malloc+0xa6>
      if(p->s.size == nunits)
 794:	8b 45 f4             	mov    -0xc(%ebp),%eax
 797:	8b 40 04             	mov    0x4(%eax),%eax
 79a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 79d:	75 0c                	jne    7ab <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 79f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a2:	8b 10                	mov    (%eax),%edx
 7a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a7:	89 10                	mov    %edx,(%eax)
 7a9:	eb 26                	jmp    7d1 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ae:	8b 40 04             	mov    0x4(%eax),%eax
 7b1:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7b4:	89 c2                	mov    %eax,%edx
 7b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bf:	8b 40 04             	mov    0x4(%eax),%eax
 7c2:	c1 e0 03             	shl    $0x3,%eax
 7c5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cb:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7ce:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d4:	a3 bc 0a 00 00       	mov    %eax,0xabc
      return (void*)(p + 1);
 7d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7dc:	83 c0 08             	add    $0x8,%eax
 7df:	eb 3b                	jmp    81c <malloc+0xe1>
    }
    if(p == freep)
 7e1:	a1 bc 0a 00 00       	mov    0xabc,%eax
 7e6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7e9:	75 1e                	jne    809 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7eb:	83 ec 0c             	sub    $0xc,%esp
 7ee:	ff 75 ec             	pushl  -0x14(%ebp)
 7f1:	e8 e5 fe ff ff       	call   6db <morecore>
 7f6:	83 c4 10             	add    $0x10,%esp
 7f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 800:	75 07                	jne    809 <malloc+0xce>
        return 0;
 802:	b8 00 00 00 00       	mov    $0x0,%eax
 807:	eb 13                	jmp    81c <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 809:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 80f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 812:	8b 00                	mov    (%eax),%eax
 814:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 817:	e9 6d ff ff ff       	jmp    789 <malloc+0x4e>
}
 81c:	c9                   	leave  
 81d:	c3                   	ret    
