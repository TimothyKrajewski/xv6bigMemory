
_pwd:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"

#define MAXPATH 512

int main(int argc, char* argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	81 ec 04 02 00 00    	sub    $0x204,%esp
	char path[MAXPATH];
	getcwd(path, MAXPATH);
  14:	83 ec 08             	sub    $0x8,%esp
  17:	68 00 02 00 00       	push   $0x200
  1c:	8d 85 f8 fd ff ff    	lea    -0x208(%ebp),%eax
  22:	50                   	push   %eax
  23:	e8 16 03 00 00       	call   33e <getcwd>
  28:	83 c4 10             	add    $0x10,%esp
	printf(0, "%s\n", path);
  2b:	83 ec 04             	sub    $0x4,%esp
  2e:	8d 85 f8 fd ff ff    	lea    -0x208(%ebp),%eax
  34:	50                   	push   %eax
  35:	68 cf 07 00 00       	push   $0x7cf
  3a:	6a 00                	push   $0x0
  3c:	e8 da 03 00 00       	call   41b <printf>
  41:	83 c4 10             	add    $0x10,%esp
	exit();
  44:	e8 55 02 00 00       	call   29e <exit>

00000049 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  49:	55                   	push   %ebp
  4a:	89 e5                	mov    %esp,%ebp
  4c:	57                   	push   %edi
  4d:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  4e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  51:	8b 55 10             	mov    0x10(%ebp),%edx
  54:	8b 45 0c             	mov    0xc(%ebp),%eax
  57:	89 cb                	mov    %ecx,%ebx
  59:	89 df                	mov    %ebx,%edi
  5b:	89 d1                	mov    %edx,%ecx
  5d:	fc                   	cld    
  5e:	f3 aa                	rep stos %al,%es:(%edi)
  60:	89 ca                	mov    %ecx,%edx
  62:	89 fb                	mov    %edi,%ebx
  64:	89 5d 08             	mov    %ebx,0x8(%ebp)
  67:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  6a:	5b                   	pop    %ebx
  6b:	5f                   	pop    %edi
  6c:	5d                   	pop    %ebp
  6d:	c3                   	ret    

0000006e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  6e:	55                   	push   %ebp
  6f:	89 e5                	mov    %esp,%ebp
  71:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  74:	8b 45 08             	mov    0x8(%ebp),%eax
  77:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  7a:	90                   	nop
  7b:	8b 45 08             	mov    0x8(%ebp),%eax
  7e:	8d 50 01             	lea    0x1(%eax),%edx
  81:	89 55 08             	mov    %edx,0x8(%ebp)
  84:	8b 55 0c             	mov    0xc(%ebp),%edx
  87:	8d 4a 01             	lea    0x1(%edx),%ecx
  8a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8d:	0f b6 12             	movzbl (%edx),%edx
  90:	88 10                	mov    %dl,(%eax)
  92:	0f b6 00             	movzbl (%eax),%eax
  95:	84 c0                	test   %al,%al
  97:	75 e2                	jne    7b <strcpy+0xd>
    ;
  return os;
  99:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  9c:	c9                   	leave  
  9d:	c3                   	ret    

0000009e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  9e:	55                   	push   %ebp
  9f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  a1:	eb 08                	jmp    ab <strcmp+0xd>
    p++, q++;
  a3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  a7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ab:	8b 45 08             	mov    0x8(%ebp),%eax
  ae:	0f b6 00             	movzbl (%eax),%eax
  b1:	84 c0                	test   %al,%al
  b3:	74 10                	je     c5 <strcmp+0x27>
  b5:	8b 45 08             	mov    0x8(%ebp),%eax
  b8:	0f b6 10             	movzbl (%eax),%edx
  bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  be:	0f b6 00             	movzbl (%eax),%eax
  c1:	38 c2                	cmp    %al,%dl
  c3:	74 de                	je     a3 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  c5:	8b 45 08             	mov    0x8(%ebp),%eax
  c8:	0f b6 00             	movzbl (%eax),%eax
  cb:	0f b6 d0             	movzbl %al,%edx
  ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  d1:	0f b6 00             	movzbl (%eax),%eax
  d4:	0f b6 c0             	movzbl %al,%eax
  d7:	29 c2                	sub    %eax,%edx
  d9:	89 d0                	mov    %edx,%eax
}
  db:	5d                   	pop    %ebp
  dc:	c3                   	ret    

000000dd <strlen>:

uint
strlen(char *s)
{
  dd:	55                   	push   %ebp
  de:	89 e5                	mov    %esp,%ebp
  e0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  e3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  ea:	eb 04                	jmp    f0 <strlen+0x13>
  ec:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  f3:	8b 45 08             	mov    0x8(%ebp),%eax
  f6:	01 d0                	add    %edx,%eax
  f8:	0f b6 00             	movzbl (%eax),%eax
  fb:	84 c0                	test   %al,%al
  fd:	75 ed                	jne    ec <strlen+0xf>
    ;
  return n;
  ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 102:	c9                   	leave  
 103:	c3                   	ret    

00000104 <memset>:

void*
memset(void *dst, int c, uint n)
{
 104:	55                   	push   %ebp
 105:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 107:	8b 45 10             	mov    0x10(%ebp),%eax
 10a:	50                   	push   %eax
 10b:	ff 75 0c             	pushl  0xc(%ebp)
 10e:	ff 75 08             	pushl  0x8(%ebp)
 111:	e8 33 ff ff ff       	call   49 <stosb>
 116:	83 c4 0c             	add    $0xc,%esp
  return dst;
 119:	8b 45 08             	mov    0x8(%ebp),%eax
}
 11c:	c9                   	leave  
 11d:	c3                   	ret    

0000011e <strchr>:

char*
strchr(const char *s, char c)
{
 11e:	55                   	push   %ebp
 11f:	89 e5                	mov    %esp,%ebp
 121:	83 ec 04             	sub    $0x4,%esp
 124:	8b 45 0c             	mov    0xc(%ebp),%eax
 127:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 12a:	eb 14                	jmp    140 <strchr+0x22>
    if(*s == c)
 12c:	8b 45 08             	mov    0x8(%ebp),%eax
 12f:	0f b6 00             	movzbl (%eax),%eax
 132:	3a 45 fc             	cmp    -0x4(%ebp),%al
 135:	75 05                	jne    13c <strchr+0x1e>
      return (char*)s;
 137:	8b 45 08             	mov    0x8(%ebp),%eax
 13a:	eb 13                	jmp    14f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 13c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 140:	8b 45 08             	mov    0x8(%ebp),%eax
 143:	0f b6 00             	movzbl (%eax),%eax
 146:	84 c0                	test   %al,%al
 148:	75 e2                	jne    12c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 14a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 14f:	c9                   	leave  
 150:	c3                   	ret    

00000151 <gets>:

char*
gets(char *buf, int max)
{
 151:	55                   	push   %ebp
 152:	89 e5                	mov    %esp,%ebp
 154:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 157:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 15e:	eb 44                	jmp    1a4 <gets+0x53>
    cc = read(0, &c, 1);
 160:	83 ec 04             	sub    $0x4,%esp
 163:	6a 01                	push   $0x1
 165:	8d 45 ef             	lea    -0x11(%ebp),%eax
 168:	50                   	push   %eax
 169:	6a 00                	push   $0x0
 16b:	e8 46 01 00 00       	call   2b6 <read>
 170:	83 c4 10             	add    $0x10,%esp
 173:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 176:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 17a:	7f 02                	jg     17e <gets+0x2d>
      break;
 17c:	eb 31                	jmp    1af <gets+0x5e>
    buf[i++] = c;
 17e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 181:	8d 50 01             	lea    0x1(%eax),%edx
 184:	89 55 f4             	mov    %edx,-0xc(%ebp)
 187:	89 c2                	mov    %eax,%edx
 189:	8b 45 08             	mov    0x8(%ebp),%eax
 18c:	01 c2                	add    %eax,%edx
 18e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 192:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 194:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 198:	3c 0a                	cmp    $0xa,%al
 19a:	74 13                	je     1af <gets+0x5e>
 19c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1a0:	3c 0d                	cmp    $0xd,%al
 1a2:	74 0b                	je     1af <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1a7:	83 c0 01             	add    $0x1,%eax
 1aa:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1ad:	7c b1                	jl     160 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1af:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1b2:	8b 45 08             	mov    0x8(%ebp),%eax
 1b5:	01 d0                	add    %edx,%eax
 1b7:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1ba:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1bd:	c9                   	leave  
 1be:	c3                   	ret    

000001bf <stat>:

int
stat(char *n, struct stat *st)
{
 1bf:	55                   	push   %ebp
 1c0:	89 e5                	mov    %esp,%ebp
 1c2:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c5:	83 ec 08             	sub    $0x8,%esp
 1c8:	6a 00                	push   $0x0
 1ca:	ff 75 08             	pushl  0x8(%ebp)
 1cd:	e8 0c 01 00 00       	call   2de <open>
 1d2:	83 c4 10             	add    $0x10,%esp
 1d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1dc:	79 07                	jns    1e5 <stat+0x26>
    return -1;
 1de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1e3:	eb 25                	jmp    20a <stat+0x4b>
  r = fstat(fd, st);
 1e5:	83 ec 08             	sub    $0x8,%esp
 1e8:	ff 75 0c             	pushl  0xc(%ebp)
 1eb:	ff 75 f4             	pushl  -0xc(%ebp)
 1ee:	e8 03 01 00 00       	call   2f6 <fstat>
 1f3:	83 c4 10             	add    $0x10,%esp
 1f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1f9:	83 ec 0c             	sub    $0xc,%esp
 1fc:	ff 75 f4             	pushl  -0xc(%ebp)
 1ff:	e8 c2 00 00 00       	call   2c6 <close>
 204:	83 c4 10             	add    $0x10,%esp
  return r;
 207:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 20a:	c9                   	leave  
 20b:	c3                   	ret    

0000020c <atoi>:

int
atoi(const char *s)
{
 20c:	55                   	push   %ebp
 20d:	89 e5                	mov    %esp,%ebp
 20f:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 212:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 219:	eb 25                	jmp    240 <atoi+0x34>
    n = n*10 + *s++ - '0';
 21b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 21e:	89 d0                	mov    %edx,%eax
 220:	c1 e0 02             	shl    $0x2,%eax
 223:	01 d0                	add    %edx,%eax
 225:	01 c0                	add    %eax,%eax
 227:	89 c1                	mov    %eax,%ecx
 229:	8b 45 08             	mov    0x8(%ebp),%eax
 22c:	8d 50 01             	lea    0x1(%eax),%edx
 22f:	89 55 08             	mov    %edx,0x8(%ebp)
 232:	0f b6 00             	movzbl (%eax),%eax
 235:	0f be c0             	movsbl %al,%eax
 238:	01 c8                	add    %ecx,%eax
 23a:	83 e8 30             	sub    $0x30,%eax
 23d:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	0f b6 00             	movzbl (%eax),%eax
 246:	3c 2f                	cmp    $0x2f,%al
 248:	7e 0a                	jle    254 <atoi+0x48>
 24a:	8b 45 08             	mov    0x8(%ebp),%eax
 24d:	0f b6 00             	movzbl (%eax),%eax
 250:	3c 39                	cmp    $0x39,%al
 252:	7e c7                	jle    21b <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 254:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 257:	c9                   	leave  
 258:	c3                   	ret    

00000259 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 259:	55                   	push   %ebp
 25a:	89 e5                	mov    %esp,%ebp
 25c:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 25f:	8b 45 08             	mov    0x8(%ebp),%eax
 262:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 265:	8b 45 0c             	mov    0xc(%ebp),%eax
 268:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 26b:	eb 17                	jmp    284 <memmove+0x2b>
    *dst++ = *src++;
 26d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 270:	8d 50 01             	lea    0x1(%eax),%edx
 273:	89 55 fc             	mov    %edx,-0x4(%ebp)
 276:	8b 55 f8             	mov    -0x8(%ebp),%edx
 279:	8d 4a 01             	lea    0x1(%edx),%ecx
 27c:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 27f:	0f b6 12             	movzbl (%edx),%edx
 282:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 284:	8b 45 10             	mov    0x10(%ebp),%eax
 287:	8d 50 ff             	lea    -0x1(%eax),%edx
 28a:	89 55 10             	mov    %edx,0x10(%ebp)
 28d:	85 c0                	test   %eax,%eax
 28f:	7f dc                	jg     26d <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 291:	8b 45 08             	mov    0x8(%ebp),%eax
}
 294:	c9                   	leave  
 295:	c3                   	ret    

00000296 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 296:	b8 01 00 00 00       	mov    $0x1,%eax
 29b:	cd 40                	int    $0x40
 29d:	c3                   	ret    

0000029e <exit>:
SYSCALL(exit)
 29e:	b8 02 00 00 00       	mov    $0x2,%eax
 2a3:	cd 40                	int    $0x40
 2a5:	c3                   	ret    

000002a6 <wait>:
SYSCALL(wait)
 2a6:	b8 03 00 00 00       	mov    $0x3,%eax
 2ab:	cd 40                	int    $0x40
 2ad:	c3                   	ret    

000002ae <pipe>:
SYSCALL(pipe)
 2ae:	b8 04 00 00 00       	mov    $0x4,%eax
 2b3:	cd 40                	int    $0x40
 2b5:	c3                   	ret    

000002b6 <read>:
SYSCALL(read)
 2b6:	b8 05 00 00 00       	mov    $0x5,%eax
 2bb:	cd 40                	int    $0x40
 2bd:	c3                   	ret    

000002be <write>:
SYSCALL(write)
 2be:	b8 10 00 00 00       	mov    $0x10,%eax
 2c3:	cd 40                	int    $0x40
 2c5:	c3                   	ret    

000002c6 <close>:
SYSCALL(close)
 2c6:	b8 15 00 00 00       	mov    $0x15,%eax
 2cb:	cd 40                	int    $0x40
 2cd:	c3                   	ret    

000002ce <kill>:
SYSCALL(kill)
 2ce:	b8 06 00 00 00       	mov    $0x6,%eax
 2d3:	cd 40                	int    $0x40
 2d5:	c3                   	ret    

000002d6 <exec>:
SYSCALL(exec)
 2d6:	b8 07 00 00 00       	mov    $0x7,%eax
 2db:	cd 40                	int    $0x40
 2dd:	c3                   	ret    

000002de <open>:
SYSCALL(open)
 2de:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e3:	cd 40                	int    $0x40
 2e5:	c3                   	ret    

000002e6 <mknod>:
SYSCALL(mknod)
 2e6:	b8 11 00 00 00       	mov    $0x11,%eax
 2eb:	cd 40                	int    $0x40
 2ed:	c3                   	ret    

000002ee <unlink>:
SYSCALL(unlink)
 2ee:	b8 12 00 00 00       	mov    $0x12,%eax
 2f3:	cd 40                	int    $0x40
 2f5:	c3                   	ret    

000002f6 <fstat>:
SYSCALL(fstat)
 2f6:	b8 08 00 00 00       	mov    $0x8,%eax
 2fb:	cd 40                	int    $0x40
 2fd:	c3                   	ret    

000002fe <link>:
SYSCALL(link)
 2fe:	b8 13 00 00 00       	mov    $0x13,%eax
 303:	cd 40                	int    $0x40
 305:	c3                   	ret    

00000306 <mkdir>:
SYSCALL(mkdir)
 306:	b8 14 00 00 00       	mov    $0x14,%eax
 30b:	cd 40                	int    $0x40
 30d:	c3                   	ret    

0000030e <chdir>:
SYSCALL(chdir)
 30e:	b8 09 00 00 00       	mov    $0x9,%eax
 313:	cd 40                	int    $0x40
 315:	c3                   	ret    

00000316 <dup>:
SYSCALL(dup)
 316:	b8 0a 00 00 00       	mov    $0xa,%eax
 31b:	cd 40                	int    $0x40
 31d:	c3                   	ret    

0000031e <getpid>:
SYSCALL(getpid)
 31e:	b8 0b 00 00 00       	mov    $0xb,%eax
 323:	cd 40                	int    $0x40
 325:	c3                   	ret    

00000326 <sbrk>:
SYSCALL(sbrk)
 326:	b8 0c 00 00 00       	mov    $0xc,%eax
 32b:	cd 40                	int    $0x40
 32d:	c3                   	ret    

0000032e <sleep>:
SYSCALL(sleep)
 32e:	b8 0d 00 00 00       	mov    $0xd,%eax
 333:	cd 40                	int    $0x40
 335:	c3                   	ret    

00000336 <uptime>:
SYSCALL(uptime)
 336:	b8 0e 00 00 00       	mov    $0xe,%eax
 33b:	cd 40                	int    $0x40
 33d:	c3                   	ret    

0000033e <getcwd>:
SYSCALL(getcwd)
 33e:	b8 16 00 00 00       	mov    $0x16,%eax
 343:	cd 40                	int    $0x40
 345:	c3                   	ret    

00000346 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 346:	55                   	push   %ebp
 347:	89 e5                	mov    %esp,%ebp
 349:	83 ec 18             	sub    $0x18,%esp
 34c:	8b 45 0c             	mov    0xc(%ebp),%eax
 34f:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 352:	83 ec 04             	sub    $0x4,%esp
 355:	6a 01                	push   $0x1
 357:	8d 45 f4             	lea    -0xc(%ebp),%eax
 35a:	50                   	push   %eax
 35b:	ff 75 08             	pushl  0x8(%ebp)
 35e:	e8 5b ff ff ff       	call   2be <write>
 363:	83 c4 10             	add    $0x10,%esp
}
 366:	c9                   	leave  
 367:	c3                   	ret    

00000368 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 368:	55                   	push   %ebp
 369:	89 e5                	mov    %esp,%ebp
 36b:	53                   	push   %ebx
 36c:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 36f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 376:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 37a:	74 17                	je     393 <printint+0x2b>
 37c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 380:	79 11                	jns    393 <printint+0x2b>
    neg = 1;
 382:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 389:	8b 45 0c             	mov    0xc(%ebp),%eax
 38c:	f7 d8                	neg    %eax
 38e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 391:	eb 06                	jmp    399 <printint+0x31>
  } else {
    x = xx;
 393:	8b 45 0c             	mov    0xc(%ebp),%eax
 396:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 399:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3a0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3a3:	8d 41 01             	lea    0x1(%ecx),%eax
 3a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3a9:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3af:	ba 00 00 00 00       	mov    $0x0,%edx
 3b4:	f7 f3                	div    %ebx
 3b6:	89 d0                	mov    %edx,%eax
 3b8:	0f b6 80 24 0a 00 00 	movzbl 0xa24(%eax),%eax
 3bf:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3c3:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3c6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3c9:	ba 00 00 00 00       	mov    $0x0,%edx
 3ce:	f7 f3                	div    %ebx
 3d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3d3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3d7:	75 c7                	jne    3a0 <printint+0x38>
  if(neg)
 3d9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3dd:	74 0e                	je     3ed <printint+0x85>
    buf[i++] = '-';
 3df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3e2:	8d 50 01             	lea    0x1(%eax),%edx
 3e5:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3e8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3ed:	eb 1d                	jmp    40c <printint+0xa4>
    putc(fd, buf[i]);
 3ef:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3f5:	01 d0                	add    %edx,%eax
 3f7:	0f b6 00             	movzbl (%eax),%eax
 3fa:	0f be c0             	movsbl %al,%eax
 3fd:	83 ec 08             	sub    $0x8,%esp
 400:	50                   	push   %eax
 401:	ff 75 08             	pushl  0x8(%ebp)
 404:	e8 3d ff ff ff       	call   346 <putc>
 409:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 40c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 410:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 414:	79 d9                	jns    3ef <printint+0x87>
    putc(fd, buf[i]);
}
 416:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 419:	c9                   	leave  
 41a:	c3                   	ret    

0000041b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 41b:	55                   	push   %ebp
 41c:	89 e5                	mov    %esp,%ebp
 41e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 421:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 428:	8d 45 0c             	lea    0xc(%ebp),%eax
 42b:	83 c0 04             	add    $0x4,%eax
 42e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 431:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 438:	e9 59 01 00 00       	jmp    596 <printf+0x17b>
    c = fmt[i] & 0xff;
 43d:	8b 55 0c             	mov    0xc(%ebp),%edx
 440:	8b 45 f0             	mov    -0x10(%ebp),%eax
 443:	01 d0                	add    %edx,%eax
 445:	0f b6 00             	movzbl (%eax),%eax
 448:	0f be c0             	movsbl %al,%eax
 44b:	25 ff 00 00 00       	and    $0xff,%eax
 450:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 453:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 457:	75 2c                	jne    485 <printf+0x6a>
      if(c == '%'){
 459:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 45d:	75 0c                	jne    46b <printf+0x50>
        state = '%';
 45f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 466:	e9 27 01 00 00       	jmp    592 <printf+0x177>
      } else {
        putc(fd, c);
 46b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 46e:	0f be c0             	movsbl %al,%eax
 471:	83 ec 08             	sub    $0x8,%esp
 474:	50                   	push   %eax
 475:	ff 75 08             	pushl  0x8(%ebp)
 478:	e8 c9 fe ff ff       	call   346 <putc>
 47d:	83 c4 10             	add    $0x10,%esp
 480:	e9 0d 01 00 00       	jmp    592 <printf+0x177>
      }
    } else if(state == '%'){
 485:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 489:	0f 85 03 01 00 00    	jne    592 <printf+0x177>
      if(c == 'd'){
 48f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 493:	75 1e                	jne    4b3 <printf+0x98>
        printint(fd, *ap, 10, 1);
 495:	8b 45 e8             	mov    -0x18(%ebp),%eax
 498:	8b 00                	mov    (%eax),%eax
 49a:	6a 01                	push   $0x1
 49c:	6a 0a                	push   $0xa
 49e:	50                   	push   %eax
 49f:	ff 75 08             	pushl  0x8(%ebp)
 4a2:	e8 c1 fe ff ff       	call   368 <printint>
 4a7:	83 c4 10             	add    $0x10,%esp
        ap++;
 4aa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4ae:	e9 d8 00 00 00       	jmp    58b <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4b3:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4b7:	74 06                	je     4bf <printf+0xa4>
 4b9:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4bd:	75 1e                	jne    4dd <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4c2:	8b 00                	mov    (%eax),%eax
 4c4:	6a 00                	push   $0x0
 4c6:	6a 10                	push   $0x10
 4c8:	50                   	push   %eax
 4c9:	ff 75 08             	pushl  0x8(%ebp)
 4cc:	e8 97 fe ff ff       	call   368 <printint>
 4d1:	83 c4 10             	add    $0x10,%esp
        ap++;
 4d4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4d8:	e9 ae 00 00 00       	jmp    58b <printf+0x170>
      } else if(c == 's'){
 4dd:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4e1:	75 43                	jne    526 <printf+0x10b>
        s = (char*)*ap;
 4e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e6:	8b 00                	mov    (%eax),%eax
 4e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4eb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4f3:	75 07                	jne    4fc <printf+0xe1>
          s = "(null)";
 4f5:	c7 45 f4 d3 07 00 00 	movl   $0x7d3,-0xc(%ebp)
        while(*s != 0){
 4fc:	eb 1c                	jmp    51a <printf+0xff>
          putc(fd, *s);
 4fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 501:	0f b6 00             	movzbl (%eax),%eax
 504:	0f be c0             	movsbl %al,%eax
 507:	83 ec 08             	sub    $0x8,%esp
 50a:	50                   	push   %eax
 50b:	ff 75 08             	pushl  0x8(%ebp)
 50e:	e8 33 fe ff ff       	call   346 <putc>
 513:	83 c4 10             	add    $0x10,%esp
          s++;
 516:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 51a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 51d:	0f b6 00             	movzbl (%eax),%eax
 520:	84 c0                	test   %al,%al
 522:	75 da                	jne    4fe <printf+0xe3>
 524:	eb 65                	jmp    58b <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 526:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 52a:	75 1d                	jne    549 <printf+0x12e>
        putc(fd, *ap);
 52c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 52f:	8b 00                	mov    (%eax),%eax
 531:	0f be c0             	movsbl %al,%eax
 534:	83 ec 08             	sub    $0x8,%esp
 537:	50                   	push   %eax
 538:	ff 75 08             	pushl  0x8(%ebp)
 53b:	e8 06 fe ff ff       	call   346 <putc>
 540:	83 c4 10             	add    $0x10,%esp
        ap++;
 543:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 547:	eb 42                	jmp    58b <printf+0x170>
      } else if(c == '%'){
 549:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 54d:	75 17                	jne    566 <printf+0x14b>
        putc(fd, c);
 54f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 552:	0f be c0             	movsbl %al,%eax
 555:	83 ec 08             	sub    $0x8,%esp
 558:	50                   	push   %eax
 559:	ff 75 08             	pushl  0x8(%ebp)
 55c:	e8 e5 fd ff ff       	call   346 <putc>
 561:	83 c4 10             	add    $0x10,%esp
 564:	eb 25                	jmp    58b <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 566:	83 ec 08             	sub    $0x8,%esp
 569:	6a 25                	push   $0x25
 56b:	ff 75 08             	pushl  0x8(%ebp)
 56e:	e8 d3 fd ff ff       	call   346 <putc>
 573:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 576:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 579:	0f be c0             	movsbl %al,%eax
 57c:	83 ec 08             	sub    $0x8,%esp
 57f:	50                   	push   %eax
 580:	ff 75 08             	pushl  0x8(%ebp)
 583:	e8 be fd ff ff       	call   346 <putc>
 588:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 58b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 592:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 596:	8b 55 0c             	mov    0xc(%ebp),%edx
 599:	8b 45 f0             	mov    -0x10(%ebp),%eax
 59c:	01 d0                	add    %edx,%eax
 59e:	0f b6 00             	movzbl (%eax),%eax
 5a1:	84 c0                	test   %al,%al
 5a3:	0f 85 94 fe ff ff    	jne    43d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5a9:	c9                   	leave  
 5aa:	c3                   	ret    

000005ab <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5ab:	55                   	push   %ebp
 5ac:	89 e5                	mov    %esp,%ebp
 5ae:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5b1:	8b 45 08             	mov    0x8(%ebp),%eax
 5b4:	83 e8 08             	sub    $0x8,%eax
 5b7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ba:	a1 40 0a 00 00       	mov    0xa40,%eax
 5bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5c2:	eb 24                	jmp    5e8 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5c7:	8b 00                	mov    (%eax),%eax
 5c9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5cc:	77 12                	ja     5e0 <free+0x35>
 5ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5d4:	77 24                	ja     5fa <free+0x4f>
 5d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5d9:	8b 00                	mov    (%eax),%eax
 5db:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5de:	77 1a                	ja     5fa <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e3:	8b 00                	mov    (%eax),%eax
 5e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5eb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5ee:	76 d4                	jbe    5c4 <free+0x19>
 5f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f3:	8b 00                	mov    (%eax),%eax
 5f5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5f8:	76 ca                	jbe    5c4 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5fd:	8b 40 04             	mov    0x4(%eax),%eax
 600:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 607:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60a:	01 c2                	add    %eax,%edx
 60c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60f:	8b 00                	mov    (%eax),%eax
 611:	39 c2                	cmp    %eax,%edx
 613:	75 24                	jne    639 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 615:	8b 45 f8             	mov    -0x8(%ebp),%eax
 618:	8b 50 04             	mov    0x4(%eax),%edx
 61b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61e:	8b 00                	mov    (%eax),%eax
 620:	8b 40 04             	mov    0x4(%eax),%eax
 623:	01 c2                	add    %eax,%edx
 625:	8b 45 f8             	mov    -0x8(%ebp),%eax
 628:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 62b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62e:	8b 00                	mov    (%eax),%eax
 630:	8b 10                	mov    (%eax),%edx
 632:	8b 45 f8             	mov    -0x8(%ebp),%eax
 635:	89 10                	mov    %edx,(%eax)
 637:	eb 0a                	jmp    643 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 639:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63c:	8b 10                	mov    (%eax),%edx
 63e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 641:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 643:	8b 45 fc             	mov    -0x4(%ebp),%eax
 646:	8b 40 04             	mov    0x4(%eax),%eax
 649:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 650:	8b 45 fc             	mov    -0x4(%ebp),%eax
 653:	01 d0                	add    %edx,%eax
 655:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 658:	75 20                	jne    67a <free+0xcf>
    p->s.size += bp->s.size;
 65a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65d:	8b 50 04             	mov    0x4(%eax),%edx
 660:	8b 45 f8             	mov    -0x8(%ebp),%eax
 663:	8b 40 04             	mov    0x4(%eax),%eax
 666:	01 c2                	add    %eax,%edx
 668:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 66e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 671:	8b 10                	mov    (%eax),%edx
 673:	8b 45 fc             	mov    -0x4(%ebp),%eax
 676:	89 10                	mov    %edx,(%eax)
 678:	eb 08                	jmp    682 <free+0xd7>
  } else
    p->s.ptr = bp;
 67a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 680:	89 10                	mov    %edx,(%eax)
  freep = p;
 682:	8b 45 fc             	mov    -0x4(%ebp),%eax
 685:	a3 40 0a 00 00       	mov    %eax,0xa40
}
 68a:	c9                   	leave  
 68b:	c3                   	ret    

0000068c <morecore>:

static Header*
morecore(uint nu)
{
 68c:	55                   	push   %ebp
 68d:	89 e5                	mov    %esp,%ebp
 68f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 692:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 699:	77 07                	ja     6a2 <morecore+0x16>
    nu = 4096;
 69b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6a2:	8b 45 08             	mov    0x8(%ebp),%eax
 6a5:	c1 e0 03             	shl    $0x3,%eax
 6a8:	83 ec 0c             	sub    $0xc,%esp
 6ab:	50                   	push   %eax
 6ac:	e8 75 fc ff ff       	call   326 <sbrk>
 6b1:	83 c4 10             	add    $0x10,%esp
 6b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6b7:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6bb:	75 07                	jne    6c4 <morecore+0x38>
    return 0;
 6bd:	b8 00 00 00 00       	mov    $0x0,%eax
 6c2:	eb 26                	jmp    6ea <morecore+0x5e>
  hp = (Header*)p;
 6c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6cd:	8b 55 08             	mov    0x8(%ebp),%edx
 6d0:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d6:	83 c0 08             	add    $0x8,%eax
 6d9:	83 ec 0c             	sub    $0xc,%esp
 6dc:	50                   	push   %eax
 6dd:	e8 c9 fe ff ff       	call   5ab <free>
 6e2:	83 c4 10             	add    $0x10,%esp
  return freep;
 6e5:	a1 40 0a 00 00       	mov    0xa40,%eax
}
 6ea:	c9                   	leave  
 6eb:	c3                   	ret    

000006ec <malloc>:

void*
malloc(uint nbytes)
{
 6ec:	55                   	push   %ebp
 6ed:	89 e5                	mov    %esp,%ebp
 6ef:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f2:	8b 45 08             	mov    0x8(%ebp),%eax
 6f5:	83 c0 07             	add    $0x7,%eax
 6f8:	c1 e8 03             	shr    $0x3,%eax
 6fb:	83 c0 01             	add    $0x1,%eax
 6fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 701:	a1 40 0a 00 00       	mov    0xa40,%eax
 706:	89 45 f0             	mov    %eax,-0x10(%ebp)
 709:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 70d:	75 23                	jne    732 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 70f:	c7 45 f0 38 0a 00 00 	movl   $0xa38,-0x10(%ebp)
 716:	8b 45 f0             	mov    -0x10(%ebp),%eax
 719:	a3 40 0a 00 00       	mov    %eax,0xa40
 71e:	a1 40 0a 00 00       	mov    0xa40,%eax
 723:	a3 38 0a 00 00       	mov    %eax,0xa38
    base.s.size = 0;
 728:	c7 05 3c 0a 00 00 00 	movl   $0x0,0xa3c
 72f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 732:	8b 45 f0             	mov    -0x10(%ebp),%eax
 735:	8b 00                	mov    (%eax),%eax
 737:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 73a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73d:	8b 40 04             	mov    0x4(%eax),%eax
 740:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 743:	72 4d                	jb     792 <malloc+0xa6>
      if(p->s.size == nunits)
 745:	8b 45 f4             	mov    -0xc(%ebp),%eax
 748:	8b 40 04             	mov    0x4(%eax),%eax
 74b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 74e:	75 0c                	jne    75c <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 750:	8b 45 f4             	mov    -0xc(%ebp),%eax
 753:	8b 10                	mov    (%eax),%edx
 755:	8b 45 f0             	mov    -0x10(%ebp),%eax
 758:	89 10                	mov    %edx,(%eax)
 75a:	eb 26                	jmp    782 <malloc+0x96>
      else {
        p->s.size -= nunits;
 75c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75f:	8b 40 04             	mov    0x4(%eax),%eax
 762:	2b 45 ec             	sub    -0x14(%ebp),%eax
 765:	89 c2                	mov    %eax,%edx
 767:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76a:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 76d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 770:	8b 40 04             	mov    0x4(%eax),%eax
 773:	c1 e0 03             	shl    $0x3,%eax
 776:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 779:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77c:	8b 55 ec             	mov    -0x14(%ebp),%edx
 77f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 782:	8b 45 f0             	mov    -0x10(%ebp),%eax
 785:	a3 40 0a 00 00       	mov    %eax,0xa40
      return (void*)(p + 1);
 78a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78d:	83 c0 08             	add    $0x8,%eax
 790:	eb 3b                	jmp    7cd <malloc+0xe1>
    }
    if(p == freep)
 792:	a1 40 0a 00 00       	mov    0xa40,%eax
 797:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 79a:	75 1e                	jne    7ba <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 79c:	83 ec 0c             	sub    $0xc,%esp
 79f:	ff 75 ec             	pushl  -0x14(%ebp)
 7a2:	e8 e5 fe ff ff       	call   68c <morecore>
 7a7:	83 c4 10             	add    $0x10,%esp
 7aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7b1:	75 07                	jne    7ba <malloc+0xce>
        return 0;
 7b3:	b8 00 00 00 00       	mov    $0x0,%eax
 7b8:	eb 13                	jmp    7cd <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c3:	8b 00                	mov    (%eax),%eax
 7c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7c8:	e9 6d ff ff ff       	jmp    73a <malloc+0x4e>
}
 7cd:	c9                   	leave  
 7ce:	c3                   	ret    
