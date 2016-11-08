
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
  35:	68 d7 07 00 00       	push   $0x7d7
  3a:	6a 00                	push   $0x0
  3c:	e8 e2 03 00 00       	call   423 <printf>
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
 296:	b8 01 00 00 00       	mov    $0x1,%eax
 29b:	cd 40                	int    $0x40
 29d:	c3                   	ret    

0000029e <exit>:
 29e:	b8 02 00 00 00       	mov    $0x2,%eax
 2a3:	cd 40                	int    $0x40
 2a5:	c3                   	ret    

000002a6 <wait>:
 2a6:	b8 03 00 00 00       	mov    $0x3,%eax
 2ab:	cd 40                	int    $0x40
 2ad:	c3                   	ret    

000002ae <pipe>:
 2ae:	b8 04 00 00 00       	mov    $0x4,%eax
 2b3:	cd 40                	int    $0x40
 2b5:	c3                   	ret    

000002b6 <read>:
 2b6:	b8 05 00 00 00       	mov    $0x5,%eax
 2bb:	cd 40                	int    $0x40
 2bd:	c3                   	ret    

000002be <write>:
 2be:	b8 10 00 00 00       	mov    $0x10,%eax
 2c3:	cd 40                	int    $0x40
 2c5:	c3                   	ret    

000002c6 <close>:
 2c6:	b8 15 00 00 00       	mov    $0x15,%eax
 2cb:	cd 40                	int    $0x40
 2cd:	c3                   	ret    

000002ce <kill>:
 2ce:	b8 06 00 00 00       	mov    $0x6,%eax
 2d3:	cd 40                	int    $0x40
 2d5:	c3                   	ret    

000002d6 <exec>:
 2d6:	b8 07 00 00 00       	mov    $0x7,%eax
 2db:	cd 40                	int    $0x40
 2dd:	c3                   	ret    

000002de <open>:
 2de:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e3:	cd 40                	int    $0x40
 2e5:	c3                   	ret    

000002e6 <mknod>:
 2e6:	b8 11 00 00 00       	mov    $0x11,%eax
 2eb:	cd 40                	int    $0x40
 2ed:	c3                   	ret    

000002ee <unlink>:
 2ee:	b8 12 00 00 00       	mov    $0x12,%eax
 2f3:	cd 40                	int    $0x40
 2f5:	c3                   	ret    

000002f6 <fstat>:
 2f6:	b8 08 00 00 00       	mov    $0x8,%eax
 2fb:	cd 40                	int    $0x40
 2fd:	c3                   	ret    

000002fe <link>:
 2fe:	b8 13 00 00 00       	mov    $0x13,%eax
 303:	cd 40                	int    $0x40
 305:	c3                   	ret    

00000306 <mkdir>:
 306:	b8 14 00 00 00       	mov    $0x14,%eax
 30b:	cd 40                	int    $0x40
 30d:	c3                   	ret    

0000030e <chdir>:
 30e:	b8 09 00 00 00       	mov    $0x9,%eax
 313:	cd 40                	int    $0x40
 315:	c3                   	ret    

00000316 <dup>:
 316:	b8 0a 00 00 00       	mov    $0xa,%eax
 31b:	cd 40                	int    $0x40
 31d:	c3                   	ret    

0000031e <getpid>:
 31e:	b8 0b 00 00 00       	mov    $0xb,%eax
 323:	cd 40                	int    $0x40
 325:	c3                   	ret    

00000326 <sbrk>:
 326:	b8 0c 00 00 00       	mov    $0xc,%eax
 32b:	cd 40                	int    $0x40
 32d:	c3                   	ret    

0000032e <sleep>:
 32e:	b8 0d 00 00 00       	mov    $0xd,%eax
 333:	cd 40                	int    $0x40
 335:	c3                   	ret    

00000336 <uptime>:
 336:	b8 0e 00 00 00       	mov    $0xe,%eax
 33b:	cd 40                	int    $0x40
 33d:	c3                   	ret    

0000033e <getcwd>:
 33e:	b8 16 00 00 00       	mov    $0x16,%eax
 343:	cd 40                	int    $0x40
 345:	c3                   	ret    

00000346 <ps>:
 346:	b8 17 00 00 00       	mov    $0x17,%eax
 34b:	cd 40                	int    $0x40
 34d:	c3                   	ret    

0000034e <putc>:
 34e:	55                   	push   %ebp
 34f:	89 e5                	mov    %esp,%ebp
 351:	83 ec 18             	sub    $0x18,%esp
 354:	8b 45 0c             	mov    0xc(%ebp),%eax
 357:	88 45 f4             	mov    %al,-0xc(%ebp)
 35a:	83 ec 04             	sub    $0x4,%esp
 35d:	6a 01                	push   $0x1
 35f:	8d 45 f4             	lea    -0xc(%ebp),%eax
 362:	50                   	push   %eax
 363:	ff 75 08             	pushl  0x8(%ebp)
 366:	e8 53 ff ff ff       	call   2be <write>
 36b:	83 c4 10             	add    $0x10,%esp
 36e:	c9                   	leave  
 36f:	c3                   	ret    

00000370 <printint>:
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	53                   	push   %ebx
 374:	83 ec 24             	sub    $0x24,%esp
 377:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 37e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 382:	74 17                	je     39b <printint+0x2b>
 384:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 388:	79 11                	jns    39b <printint+0x2b>
 38a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 391:	8b 45 0c             	mov    0xc(%ebp),%eax
 394:	f7 d8                	neg    %eax
 396:	89 45 ec             	mov    %eax,-0x14(%ebp)
 399:	eb 06                	jmp    3a1 <printint+0x31>
 39b:	8b 45 0c             	mov    0xc(%ebp),%eax
 39e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 3a8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3ab:	8d 41 01             	lea    0x1(%ecx),%eax
 3ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3b1:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3b7:	ba 00 00 00 00       	mov    $0x0,%edx
 3bc:	f7 f3                	div    %ebx
 3be:	89 d0                	mov    %edx,%eax
 3c0:	0f b6 80 2c 0a 00 00 	movzbl 0xa2c(%eax),%eax
 3c7:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 3cb:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3d1:	ba 00 00 00 00       	mov    $0x0,%edx
 3d6:	f7 f3                	div    %ebx
 3d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3db:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3df:	75 c7                	jne    3a8 <printint+0x38>
 3e1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3e5:	74 0e                	je     3f5 <printint+0x85>
 3e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3ea:	8d 50 01             	lea    0x1(%eax),%edx
 3ed:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3f0:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 3f5:	eb 1d                	jmp    414 <printint+0xa4>
 3f7:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3fd:	01 d0                	add    %edx,%eax
 3ff:	0f b6 00             	movzbl (%eax),%eax
 402:	0f be c0             	movsbl %al,%eax
 405:	83 ec 08             	sub    $0x8,%esp
 408:	50                   	push   %eax
 409:	ff 75 08             	pushl  0x8(%ebp)
 40c:	e8 3d ff ff ff       	call   34e <putc>
 411:	83 c4 10             	add    $0x10,%esp
 414:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 418:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 41c:	79 d9                	jns    3f7 <printint+0x87>
 41e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 421:	c9                   	leave  
 422:	c3                   	ret    

00000423 <printf>:
 423:	55                   	push   %ebp
 424:	89 e5                	mov    %esp,%ebp
 426:	83 ec 28             	sub    $0x28,%esp
 429:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 430:	8d 45 0c             	lea    0xc(%ebp),%eax
 433:	83 c0 04             	add    $0x4,%eax
 436:	89 45 e8             	mov    %eax,-0x18(%ebp)
 439:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 440:	e9 59 01 00 00       	jmp    59e <printf+0x17b>
 445:	8b 55 0c             	mov    0xc(%ebp),%edx
 448:	8b 45 f0             	mov    -0x10(%ebp),%eax
 44b:	01 d0                	add    %edx,%eax
 44d:	0f b6 00             	movzbl (%eax),%eax
 450:	0f be c0             	movsbl %al,%eax
 453:	25 ff 00 00 00       	and    $0xff,%eax
 458:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 45b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 45f:	75 2c                	jne    48d <printf+0x6a>
 461:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 465:	75 0c                	jne    473 <printf+0x50>
 467:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 46e:	e9 27 01 00 00       	jmp    59a <printf+0x177>
 473:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 476:	0f be c0             	movsbl %al,%eax
 479:	83 ec 08             	sub    $0x8,%esp
 47c:	50                   	push   %eax
 47d:	ff 75 08             	pushl  0x8(%ebp)
 480:	e8 c9 fe ff ff       	call   34e <putc>
 485:	83 c4 10             	add    $0x10,%esp
 488:	e9 0d 01 00 00       	jmp    59a <printf+0x177>
 48d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 491:	0f 85 03 01 00 00    	jne    59a <printf+0x177>
 497:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 49b:	75 1e                	jne    4bb <printf+0x98>
 49d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4a0:	8b 00                	mov    (%eax),%eax
 4a2:	6a 01                	push   $0x1
 4a4:	6a 0a                	push   $0xa
 4a6:	50                   	push   %eax
 4a7:	ff 75 08             	pushl  0x8(%ebp)
 4aa:	e8 c1 fe ff ff       	call   370 <printint>
 4af:	83 c4 10             	add    $0x10,%esp
 4b2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4b6:	e9 d8 00 00 00       	jmp    593 <printf+0x170>
 4bb:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4bf:	74 06                	je     4c7 <printf+0xa4>
 4c1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4c5:	75 1e                	jne    4e5 <printf+0xc2>
 4c7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ca:	8b 00                	mov    (%eax),%eax
 4cc:	6a 00                	push   $0x0
 4ce:	6a 10                	push   $0x10
 4d0:	50                   	push   %eax
 4d1:	ff 75 08             	pushl  0x8(%ebp)
 4d4:	e8 97 fe ff ff       	call   370 <printint>
 4d9:	83 c4 10             	add    $0x10,%esp
 4dc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4e0:	e9 ae 00 00 00       	jmp    593 <printf+0x170>
 4e5:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4e9:	75 43                	jne    52e <printf+0x10b>
 4eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ee:	8b 00                	mov    (%eax),%eax
 4f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4f3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4f7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4fb:	75 07                	jne    504 <printf+0xe1>
 4fd:	c7 45 f4 db 07 00 00 	movl   $0x7db,-0xc(%ebp)
 504:	eb 1c                	jmp    522 <printf+0xff>
 506:	8b 45 f4             	mov    -0xc(%ebp),%eax
 509:	0f b6 00             	movzbl (%eax),%eax
 50c:	0f be c0             	movsbl %al,%eax
 50f:	83 ec 08             	sub    $0x8,%esp
 512:	50                   	push   %eax
 513:	ff 75 08             	pushl  0x8(%ebp)
 516:	e8 33 fe ff ff       	call   34e <putc>
 51b:	83 c4 10             	add    $0x10,%esp
 51e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 522:	8b 45 f4             	mov    -0xc(%ebp),%eax
 525:	0f b6 00             	movzbl (%eax),%eax
 528:	84 c0                	test   %al,%al
 52a:	75 da                	jne    506 <printf+0xe3>
 52c:	eb 65                	jmp    593 <printf+0x170>
 52e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 532:	75 1d                	jne    551 <printf+0x12e>
 534:	8b 45 e8             	mov    -0x18(%ebp),%eax
 537:	8b 00                	mov    (%eax),%eax
 539:	0f be c0             	movsbl %al,%eax
 53c:	83 ec 08             	sub    $0x8,%esp
 53f:	50                   	push   %eax
 540:	ff 75 08             	pushl  0x8(%ebp)
 543:	e8 06 fe ff ff       	call   34e <putc>
 548:	83 c4 10             	add    $0x10,%esp
 54b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 54f:	eb 42                	jmp    593 <printf+0x170>
 551:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 555:	75 17                	jne    56e <printf+0x14b>
 557:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 55a:	0f be c0             	movsbl %al,%eax
 55d:	83 ec 08             	sub    $0x8,%esp
 560:	50                   	push   %eax
 561:	ff 75 08             	pushl  0x8(%ebp)
 564:	e8 e5 fd ff ff       	call   34e <putc>
 569:	83 c4 10             	add    $0x10,%esp
 56c:	eb 25                	jmp    593 <printf+0x170>
 56e:	83 ec 08             	sub    $0x8,%esp
 571:	6a 25                	push   $0x25
 573:	ff 75 08             	pushl  0x8(%ebp)
 576:	e8 d3 fd ff ff       	call   34e <putc>
 57b:	83 c4 10             	add    $0x10,%esp
 57e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 581:	0f be c0             	movsbl %al,%eax
 584:	83 ec 08             	sub    $0x8,%esp
 587:	50                   	push   %eax
 588:	ff 75 08             	pushl  0x8(%ebp)
 58b:	e8 be fd ff ff       	call   34e <putc>
 590:	83 c4 10             	add    $0x10,%esp
 593:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 59a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 59e:	8b 55 0c             	mov    0xc(%ebp),%edx
 5a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5a4:	01 d0                	add    %edx,%eax
 5a6:	0f b6 00             	movzbl (%eax),%eax
 5a9:	84 c0                	test   %al,%al
 5ab:	0f 85 94 fe ff ff    	jne    445 <printf+0x22>
 5b1:	c9                   	leave  
 5b2:	c3                   	ret    

000005b3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5b3:	55                   	push   %ebp
 5b4:	89 e5                	mov    %esp,%ebp
 5b6:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5b9:	8b 45 08             	mov    0x8(%ebp),%eax
 5bc:	83 e8 08             	sub    $0x8,%eax
 5bf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c2:	a1 48 0a 00 00       	mov    0xa48,%eax
 5c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5ca:	eb 24                	jmp    5f0 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5cf:	8b 00                	mov    (%eax),%eax
 5d1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5d4:	77 12                	ja     5e8 <free+0x35>
 5d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5dc:	77 24                	ja     602 <free+0x4f>
 5de:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e1:	8b 00                	mov    (%eax),%eax
 5e3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5e6:	77 1a                	ja     602 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5eb:	8b 00                	mov    (%eax),%eax
 5ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f6:	76 d4                	jbe    5cc <free+0x19>
 5f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fb:	8b 00                	mov    (%eax),%eax
 5fd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 600:	76 ca                	jbe    5cc <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 602:	8b 45 f8             	mov    -0x8(%ebp),%eax
 605:	8b 40 04             	mov    0x4(%eax),%eax
 608:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 60f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 612:	01 c2                	add    %eax,%edx
 614:	8b 45 fc             	mov    -0x4(%ebp),%eax
 617:	8b 00                	mov    (%eax),%eax
 619:	39 c2                	cmp    %eax,%edx
 61b:	75 24                	jne    641 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 61d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 620:	8b 50 04             	mov    0x4(%eax),%edx
 623:	8b 45 fc             	mov    -0x4(%ebp),%eax
 626:	8b 00                	mov    (%eax),%eax
 628:	8b 40 04             	mov    0x4(%eax),%eax
 62b:	01 c2                	add    %eax,%edx
 62d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 630:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 633:	8b 45 fc             	mov    -0x4(%ebp),%eax
 636:	8b 00                	mov    (%eax),%eax
 638:	8b 10                	mov    (%eax),%edx
 63a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63d:	89 10                	mov    %edx,(%eax)
 63f:	eb 0a                	jmp    64b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 641:	8b 45 fc             	mov    -0x4(%ebp),%eax
 644:	8b 10                	mov    (%eax),%edx
 646:	8b 45 f8             	mov    -0x8(%ebp),%eax
 649:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 64b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64e:	8b 40 04             	mov    0x4(%eax),%eax
 651:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 658:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65b:	01 d0                	add    %edx,%eax
 65d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 660:	75 20                	jne    682 <free+0xcf>
    p->s.size += bp->s.size;
 662:	8b 45 fc             	mov    -0x4(%ebp),%eax
 665:	8b 50 04             	mov    0x4(%eax),%edx
 668:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66b:	8b 40 04             	mov    0x4(%eax),%eax
 66e:	01 c2                	add    %eax,%edx
 670:	8b 45 fc             	mov    -0x4(%ebp),%eax
 673:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 676:	8b 45 f8             	mov    -0x8(%ebp),%eax
 679:	8b 10                	mov    (%eax),%edx
 67b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67e:	89 10                	mov    %edx,(%eax)
 680:	eb 08                	jmp    68a <free+0xd7>
  } else
    p->s.ptr = bp;
 682:	8b 45 fc             	mov    -0x4(%ebp),%eax
 685:	8b 55 f8             	mov    -0x8(%ebp),%edx
 688:	89 10                	mov    %edx,(%eax)
  freep = p;
 68a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68d:	a3 48 0a 00 00       	mov    %eax,0xa48
}
 692:	c9                   	leave  
 693:	c3                   	ret    

00000694 <morecore>:

static Header*
morecore(uint nu)
{
 694:	55                   	push   %ebp
 695:	89 e5                	mov    %esp,%ebp
 697:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 69a:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6a1:	77 07                	ja     6aa <morecore+0x16>
    nu = 4096;
 6a3:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6aa:	8b 45 08             	mov    0x8(%ebp),%eax
 6ad:	c1 e0 03             	shl    $0x3,%eax
 6b0:	83 ec 0c             	sub    $0xc,%esp
 6b3:	50                   	push   %eax
 6b4:	e8 6d fc ff ff       	call   326 <sbrk>
 6b9:	83 c4 10             	add    $0x10,%esp
 6bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6bf:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6c3:	75 07                	jne    6cc <morecore+0x38>
    return 0;
 6c5:	b8 00 00 00 00       	mov    $0x0,%eax
 6ca:	eb 26                	jmp    6f2 <morecore+0x5e>
  hp = (Header*)p;
 6cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d5:	8b 55 08             	mov    0x8(%ebp),%edx
 6d8:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6db:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6de:	83 c0 08             	add    $0x8,%eax
 6e1:	83 ec 0c             	sub    $0xc,%esp
 6e4:	50                   	push   %eax
 6e5:	e8 c9 fe ff ff       	call   5b3 <free>
 6ea:	83 c4 10             	add    $0x10,%esp
  return freep;
 6ed:	a1 48 0a 00 00       	mov    0xa48,%eax
}
 6f2:	c9                   	leave  
 6f3:	c3                   	ret    

000006f4 <malloc>:

void*
malloc(uint nbytes)
{
 6f4:	55                   	push   %ebp
 6f5:	89 e5                	mov    %esp,%ebp
 6f7:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6fa:	8b 45 08             	mov    0x8(%ebp),%eax
 6fd:	83 c0 07             	add    $0x7,%eax
 700:	c1 e8 03             	shr    $0x3,%eax
 703:	83 c0 01             	add    $0x1,%eax
 706:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 709:	a1 48 0a 00 00       	mov    0xa48,%eax
 70e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 711:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 715:	75 23                	jne    73a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 717:	c7 45 f0 40 0a 00 00 	movl   $0xa40,-0x10(%ebp)
 71e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 721:	a3 48 0a 00 00       	mov    %eax,0xa48
 726:	a1 48 0a 00 00       	mov    0xa48,%eax
 72b:	a3 40 0a 00 00       	mov    %eax,0xa40
    base.s.size = 0;
 730:	c7 05 44 0a 00 00 00 	movl   $0x0,0xa44
 737:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 73a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73d:	8b 00                	mov    (%eax),%eax
 73f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 742:	8b 45 f4             	mov    -0xc(%ebp),%eax
 745:	8b 40 04             	mov    0x4(%eax),%eax
 748:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 74b:	72 4d                	jb     79a <malloc+0xa6>
      if(p->s.size == nunits)
 74d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 750:	8b 40 04             	mov    0x4(%eax),%eax
 753:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 756:	75 0c                	jne    764 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 758:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75b:	8b 10                	mov    (%eax),%edx
 75d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 760:	89 10                	mov    %edx,(%eax)
 762:	eb 26                	jmp    78a <malloc+0x96>
      else {
        p->s.size -= nunits;
 764:	8b 45 f4             	mov    -0xc(%ebp),%eax
 767:	8b 40 04             	mov    0x4(%eax),%eax
 76a:	2b 45 ec             	sub    -0x14(%ebp),%eax
 76d:	89 c2                	mov    %eax,%edx
 76f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 772:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 775:	8b 45 f4             	mov    -0xc(%ebp),%eax
 778:	8b 40 04             	mov    0x4(%eax),%eax
 77b:	c1 e0 03             	shl    $0x3,%eax
 77e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 781:	8b 45 f4             	mov    -0xc(%ebp),%eax
 784:	8b 55 ec             	mov    -0x14(%ebp),%edx
 787:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 78a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78d:	a3 48 0a 00 00       	mov    %eax,0xa48
      return (void*)(p + 1);
 792:	8b 45 f4             	mov    -0xc(%ebp),%eax
 795:	83 c0 08             	add    $0x8,%eax
 798:	eb 3b                	jmp    7d5 <malloc+0xe1>
    }
    if(p == freep)
 79a:	a1 48 0a 00 00       	mov    0xa48,%eax
 79f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7a2:	75 1e                	jne    7c2 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7a4:	83 ec 0c             	sub    $0xc,%esp
 7a7:	ff 75 ec             	pushl  -0x14(%ebp)
 7aa:	e8 e5 fe ff ff       	call   694 <morecore>
 7af:	83 c4 10             	add    $0x10,%esp
 7b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7b5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7b9:	75 07                	jne    7c2 <malloc+0xce>
        return 0;
 7bb:	b8 00 00 00 00       	mov    $0x0,%eax
 7c0:	eb 13                	jmp    7d5 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cb:	8b 00                	mov    (%eax),%eax
 7cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7d0:	e9 6d ff ff ff       	jmp    742 <malloc+0x4e>
}
 7d5:	c9                   	leave  
 7d6:	c3                   	ret    
