
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	81 ec 24 02 00 00    	sub    $0x224,%esp
  int fd, i;
  char path[] = "stressfs0";
  14:	c7 45 e6 73 74 72 65 	movl   $0x65727473,-0x1a(%ebp)
  1b:	c7 45 ea 73 73 66 73 	movl   $0x73667373,-0x16(%ebp)
  22:	66 c7 45 ee 30 00    	movw   $0x30,-0x12(%ebp)
  char data[512];

  printf(1, "stressfs starting\n");
  28:	83 ec 08             	sub    $0x8,%esp
  2b:	68 df 08 00 00       	push   $0x8df
  30:	6a 01                	push   $0x1
  32:	e8 f4 04 00 00       	call   52b <printf>
  37:	83 c4 10             	add    $0x10,%esp
  memset(data, 'a', sizeof(data));
  3a:	83 ec 04             	sub    $0x4,%esp
  3d:	68 00 02 00 00       	push   $0x200
  42:	6a 61                	push   $0x61
  44:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
  4a:	50                   	push   %eax
  4b:	e8 bc 01 00 00       	call   20c <memset>
  50:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
  53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  5a:	eb 0f                	jmp    6b <main+0x6b>
    if(fork() > 0)
  5c:	e8 3d 03 00 00       	call   39e <fork>
  61:	85 c0                	test   %eax,%eax
  63:	7e 02                	jle    67 <main+0x67>
      break;
  65:	eb 0a                	jmp    71 <main+0x71>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
  67:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  6b:	83 7d f4 03          	cmpl   $0x3,-0xc(%ebp)
  6f:	7e eb                	jle    5c <main+0x5c>
    if(fork() > 0)
      break;

  printf(1, "write %d\n", i);
  71:	83 ec 04             	sub    $0x4,%esp
  74:	ff 75 f4             	pushl  -0xc(%ebp)
  77:	68 f2 08 00 00       	push   $0x8f2
  7c:	6a 01                	push   $0x1
  7e:	e8 a8 04 00 00       	call   52b <printf>
  83:	83 c4 10             	add    $0x10,%esp

  path[8] += i;
  86:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
  8a:	89 c2                	mov    %eax,%edx
  8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8f:	01 d0                	add    %edx,%eax
  91:	88 45 ee             	mov    %al,-0x12(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  94:	83 ec 08             	sub    $0x8,%esp
  97:	68 02 02 00 00       	push   $0x202
  9c:	8d 45 e6             	lea    -0x1a(%ebp),%eax
  9f:	50                   	push   %eax
  a0:	e8 41 03 00 00       	call   3e6 <open>
  a5:	83 c4 10             	add    $0x10,%esp
  a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 20; i++)
  ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  b2:	eb 1e                	jmp    d2 <main+0xd2>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  b4:	83 ec 04             	sub    $0x4,%esp
  b7:	68 00 02 00 00       	push   $0x200
  bc:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
  c2:	50                   	push   %eax
  c3:	ff 75 f0             	pushl  -0x10(%ebp)
  c6:	e8 fb 02 00 00       	call   3c6 <write>
  cb:	83 c4 10             	add    $0x10,%esp

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
  ce:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  d2:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
  d6:	7e dc                	jle    b4 <main+0xb4>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
  d8:	83 ec 0c             	sub    $0xc,%esp
  db:	ff 75 f0             	pushl  -0x10(%ebp)
  de:	e8 eb 02 00 00       	call   3ce <close>
  e3:	83 c4 10             	add    $0x10,%esp

  printf(1, "read\n");
  e6:	83 ec 08             	sub    $0x8,%esp
  e9:	68 fc 08 00 00       	push   $0x8fc
  ee:	6a 01                	push   $0x1
  f0:	e8 36 04 00 00       	call   52b <printf>
  f5:	83 c4 10             	add    $0x10,%esp

  fd = open(path, O_RDONLY);
  f8:	83 ec 08             	sub    $0x8,%esp
  fb:	6a 00                	push   $0x0
  fd:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 100:	50                   	push   %eax
 101:	e8 e0 02 00 00       	call   3e6 <open>
 106:	83 c4 10             	add    $0x10,%esp
 109:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < 20; i++)
 10c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 113:	eb 1e                	jmp    133 <main+0x133>
    read(fd, data, sizeof(data));
 115:	83 ec 04             	sub    $0x4,%esp
 118:	68 00 02 00 00       	push   $0x200
 11d:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
 123:	50                   	push   %eax
 124:	ff 75 f0             	pushl  -0x10(%ebp)
 127:	e8 92 02 00 00       	call   3be <read>
 12c:	83 c4 10             	add    $0x10,%esp
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
 12f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 133:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
 137:	7e dc                	jle    115 <main+0x115>
    read(fd, data, sizeof(data));
  close(fd);
 139:	83 ec 0c             	sub    $0xc,%esp
 13c:	ff 75 f0             	pushl  -0x10(%ebp)
 13f:	e8 8a 02 00 00       	call   3ce <close>
 144:	83 c4 10             	add    $0x10,%esp

  wait();
 147:	e8 62 02 00 00       	call   3ae <wait>
  
  exit();
 14c:	e8 55 02 00 00       	call   3a6 <exit>

00000151 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 151:	55                   	push   %ebp
 152:	89 e5                	mov    %esp,%ebp
 154:	57                   	push   %edi
 155:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 156:	8b 4d 08             	mov    0x8(%ebp),%ecx
 159:	8b 55 10             	mov    0x10(%ebp),%edx
 15c:	8b 45 0c             	mov    0xc(%ebp),%eax
 15f:	89 cb                	mov    %ecx,%ebx
 161:	89 df                	mov    %ebx,%edi
 163:	89 d1                	mov    %edx,%ecx
 165:	fc                   	cld    
 166:	f3 aa                	rep stos %al,%es:(%edi)
 168:	89 ca                	mov    %ecx,%edx
 16a:	89 fb                	mov    %edi,%ebx
 16c:	89 5d 08             	mov    %ebx,0x8(%ebp)
 16f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 172:	5b                   	pop    %ebx
 173:	5f                   	pop    %edi
 174:	5d                   	pop    %ebp
 175:	c3                   	ret    

00000176 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 176:	55                   	push   %ebp
 177:	89 e5                	mov    %esp,%ebp
 179:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 17c:	8b 45 08             	mov    0x8(%ebp),%eax
 17f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 182:	90                   	nop
 183:	8b 45 08             	mov    0x8(%ebp),%eax
 186:	8d 50 01             	lea    0x1(%eax),%edx
 189:	89 55 08             	mov    %edx,0x8(%ebp)
 18c:	8b 55 0c             	mov    0xc(%ebp),%edx
 18f:	8d 4a 01             	lea    0x1(%edx),%ecx
 192:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 195:	0f b6 12             	movzbl (%edx),%edx
 198:	88 10                	mov    %dl,(%eax)
 19a:	0f b6 00             	movzbl (%eax),%eax
 19d:	84 c0                	test   %al,%al
 19f:	75 e2                	jne    183 <strcpy+0xd>
    ;
  return os;
 1a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1a4:	c9                   	leave  
 1a5:	c3                   	ret    

000001a6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a6:	55                   	push   %ebp
 1a7:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1a9:	eb 08                	jmp    1b3 <strcmp+0xd>
    p++, q++;
 1ab:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1af:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	0f b6 00             	movzbl (%eax),%eax
 1b9:	84 c0                	test   %al,%al
 1bb:	74 10                	je     1cd <strcmp+0x27>
 1bd:	8b 45 08             	mov    0x8(%ebp),%eax
 1c0:	0f b6 10             	movzbl (%eax),%edx
 1c3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c6:	0f b6 00             	movzbl (%eax),%eax
 1c9:	38 c2                	cmp    %al,%dl
 1cb:	74 de                	je     1ab <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1cd:	8b 45 08             	mov    0x8(%ebp),%eax
 1d0:	0f b6 00             	movzbl (%eax),%eax
 1d3:	0f b6 d0             	movzbl %al,%edx
 1d6:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d9:	0f b6 00             	movzbl (%eax),%eax
 1dc:	0f b6 c0             	movzbl %al,%eax
 1df:	29 c2                	sub    %eax,%edx
 1e1:	89 d0                	mov    %edx,%eax
}
 1e3:	5d                   	pop    %ebp
 1e4:	c3                   	ret    

000001e5 <strlen>:

uint
strlen(char *s)
{
 1e5:	55                   	push   %ebp
 1e6:	89 e5                	mov    %esp,%ebp
 1e8:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1f2:	eb 04                	jmp    1f8 <strlen+0x13>
 1f4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1f8:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1fb:	8b 45 08             	mov    0x8(%ebp),%eax
 1fe:	01 d0                	add    %edx,%eax
 200:	0f b6 00             	movzbl (%eax),%eax
 203:	84 c0                	test   %al,%al
 205:	75 ed                	jne    1f4 <strlen+0xf>
    ;
  return n;
 207:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 20a:	c9                   	leave  
 20b:	c3                   	ret    

0000020c <memset>:

void*
memset(void *dst, int c, uint n)
{
 20c:	55                   	push   %ebp
 20d:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 20f:	8b 45 10             	mov    0x10(%ebp),%eax
 212:	50                   	push   %eax
 213:	ff 75 0c             	pushl  0xc(%ebp)
 216:	ff 75 08             	pushl  0x8(%ebp)
 219:	e8 33 ff ff ff       	call   151 <stosb>
 21e:	83 c4 0c             	add    $0xc,%esp
  return dst;
 221:	8b 45 08             	mov    0x8(%ebp),%eax
}
 224:	c9                   	leave  
 225:	c3                   	ret    

00000226 <strchr>:

char*
strchr(const char *s, char c)
{
 226:	55                   	push   %ebp
 227:	89 e5                	mov    %esp,%ebp
 229:	83 ec 04             	sub    $0x4,%esp
 22c:	8b 45 0c             	mov    0xc(%ebp),%eax
 22f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 232:	eb 14                	jmp    248 <strchr+0x22>
    if(*s == c)
 234:	8b 45 08             	mov    0x8(%ebp),%eax
 237:	0f b6 00             	movzbl (%eax),%eax
 23a:	3a 45 fc             	cmp    -0x4(%ebp),%al
 23d:	75 05                	jne    244 <strchr+0x1e>
      return (char*)s;
 23f:	8b 45 08             	mov    0x8(%ebp),%eax
 242:	eb 13                	jmp    257 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 244:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 248:	8b 45 08             	mov    0x8(%ebp),%eax
 24b:	0f b6 00             	movzbl (%eax),%eax
 24e:	84 c0                	test   %al,%al
 250:	75 e2                	jne    234 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 252:	b8 00 00 00 00       	mov    $0x0,%eax
}
 257:	c9                   	leave  
 258:	c3                   	ret    

00000259 <gets>:

char*
gets(char *buf, int max)
{
 259:	55                   	push   %ebp
 25a:	89 e5                	mov    %esp,%ebp
 25c:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 25f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 266:	eb 44                	jmp    2ac <gets+0x53>
    cc = read(0, &c, 1);
 268:	83 ec 04             	sub    $0x4,%esp
 26b:	6a 01                	push   $0x1
 26d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 270:	50                   	push   %eax
 271:	6a 00                	push   $0x0
 273:	e8 46 01 00 00       	call   3be <read>
 278:	83 c4 10             	add    $0x10,%esp
 27b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 27e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 282:	7f 02                	jg     286 <gets+0x2d>
      break;
 284:	eb 31                	jmp    2b7 <gets+0x5e>
    buf[i++] = c;
 286:	8b 45 f4             	mov    -0xc(%ebp),%eax
 289:	8d 50 01             	lea    0x1(%eax),%edx
 28c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 28f:	89 c2                	mov    %eax,%edx
 291:	8b 45 08             	mov    0x8(%ebp),%eax
 294:	01 c2                	add    %eax,%edx
 296:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 29a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 29c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2a0:	3c 0a                	cmp    $0xa,%al
 2a2:	74 13                	je     2b7 <gets+0x5e>
 2a4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2a8:	3c 0d                	cmp    $0xd,%al
 2aa:	74 0b                	je     2b7 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2af:	83 c0 01             	add    $0x1,%eax
 2b2:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2b5:	7c b1                	jl     268 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2ba:	8b 45 08             	mov    0x8(%ebp),%eax
 2bd:	01 d0                	add    %edx,%eax
 2bf:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2c2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c5:	c9                   	leave  
 2c6:	c3                   	ret    

000002c7 <stat>:

int
stat(char *n, struct stat *st)
{
 2c7:	55                   	push   %ebp
 2c8:	89 e5                	mov    %esp,%ebp
 2ca:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2cd:	83 ec 08             	sub    $0x8,%esp
 2d0:	6a 00                	push   $0x0
 2d2:	ff 75 08             	pushl  0x8(%ebp)
 2d5:	e8 0c 01 00 00       	call   3e6 <open>
 2da:	83 c4 10             	add    $0x10,%esp
 2dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2e0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2e4:	79 07                	jns    2ed <stat+0x26>
    return -1;
 2e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2eb:	eb 25                	jmp    312 <stat+0x4b>
  r = fstat(fd, st);
 2ed:	83 ec 08             	sub    $0x8,%esp
 2f0:	ff 75 0c             	pushl  0xc(%ebp)
 2f3:	ff 75 f4             	pushl  -0xc(%ebp)
 2f6:	e8 03 01 00 00       	call   3fe <fstat>
 2fb:	83 c4 10             	add    $0x10,%esp
 2fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 301:	83 ec 0c             	sub    $0xc,%esp
 304:	ff 75 f4             	pushl  -0xc(%ebp)
 307:	e8 c2 00 00 00       	call   3ce <close>
 30c:	83 c4 10             	add    $0x10,%esp
  return r;
 30f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 312:	c9                   	leave  
 313:	c3                   	ret    

00000314 <atoi>:

int
atoi(const char *s)
{
 314:	55                   	push   %ebp
 315:	89 e5                	mov    %esp,%ebp
 317:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 31a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 321:	eb 25                	jmp    348 <atoi+0x34>
    n = n*10 + *s++ - '0';
 323:	8b 55 fc             	mov    -0x4(%ebp),%edx
 326:	89 d0                	mov    %edx,%eax
 328:	c1 e0 02             	shl    $0x2,%eax
 32b:	01 d0                	add    %edx,%eax
 32d:	01 c0                	add    %eax,%eax
 32f:	89 c1                	mov    %eax,%ecx
 331:	8b 45 08             	mov    0x8(%ebp),%eax
 334:	8d 50 01             	lea    0x1(%eax),%edx
 337:	89 55 08             	mov    %edx,0x8(%ebp)
 33a:	0f b6 00             	movzbl (%eax),%eax
 33d:	0f be c0             	movsbl %al,%eax
 340:	01 c8                	add    %ecx,%eax
 342:	83 e8 30             	sub    $0x30,%eax
 345:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 348:	8b 45 08             	mov    0x8(%ebp),%eax
 34b:	0f b6 00             	movzbl (%eax),%eax
 34e:	3c 2f                	cmp    $0x2f,%al
 350:	7e 0a                	jle    35c <atoi+0x48>
 352:	8b 45 08             	mov    0x8(%ebp),%eax
 355:	0f b6 00             	movzbl (%eax),%eax
 358:	3c 39                	cmp    $0x39,%al
 35a:	7e c7                	jle    323 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 35c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 35f:	c9                   	leave  
 360:	c3                   	ret    

00000361 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 361:	55                   	push   %ebp
 362:	89 e5                	mov    %esp,%ebp
 364:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 367:	8b 45 08             	mov    0x8(%ebp),%eax
 36a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 36d:	8b 45 0c             	mov    0xc(%ebp),%eax
 370:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 373:	eb 17                	jmp    38c <memmove+0x2b>
    *dst++ = *src++;
 375:	8b 45 fc             	mov    -0x4(%ebp),%eax
 378:	8d 50 01             	lea    0x1(%eax),%edx
 37b:	89 55 fc             	mov    %edx,-0x4(%ebp)
 37e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 381:	8d 4a 01             	lea    0x1(%edx),%ecx
 384:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 387:	0f b6 12             	movzbl (%edx),%edx
 38a:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 38c:	8b 45 10             	mov    0x10(%ebp),%eax
 38f:	8d 50 ff             	lea    -0x1(%eax),%edx
 392:	89 55 10             	mov    %edx,0x10(%ebp)
 395:	85 c0                	test   %eax,%eax
 397:	7f dc                	jg     375 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 399:	8b 45 08             	mov    0x8(%ebp),%eax
}
 39c:	c9                   	leave  
 39d:	c3                   	ret    

0000039e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 39e:	b8 01 00 00 00       	mov    $0x1,%eax
 3a3:	cd 40                	int    $0x40
 3a5:	c3                   	ret    

000003a6 <exit>:
SYSCALL(exit)
 3a6:	b8 02 00 00 00       	mov    $0x2,%eax
 3ab:	cd 40                	int    $0x40
 3ad:	c3                   	ret    

000003ae <wait>:
SYSCALL(wait)
 3ae:	b8 03 00 00 00       	mov    $0x3,%eax
 3b3:	cd 40                	int    $0x40
 3b5:	c3                   	ret    

000003b6 <pipe>:
SYSCALL(pipe)
 3b6:	b8 04 00 00 00       	mov    $0x4,%eax
 3bb:	cd 40                	int    $0x40
 3bd:	c3                   	ret    

000003be <read>:
SYSCALL(read)
 3be:	b8 05 00 00 00       	mov    $0x5,%eax
 3c3:	cd 40                	int    $0x40
 3c5:	c3                   	ret    

000003c6 <write>:
SYSCALL(write)
 3c6:	b8 10 00 00 00       	mov    $0x10,%eax
 3cb:	cd 40                	int    $0x40
 3cd:	c3                   	ret    

000003ce <close>:
SYSCALL(close)
 3ce:	b8 15 00 00 00       	mov    $0x15,%eax
 3d3:	cd 40                	int    $0x40
 3d5:	c3                   	ret    

000003d6 <kill>:
SYSCALL(kill)
 3d6:	b8 06 00 00 00       	mov    $0x6,%eax
 3db:	cd 40                	int    $0x40
 3dd:	c3                   	ret    

000003de <exec>:
SYSCALL(exec)
 3de:	b8 07 00 00 00       	mov    $0x7,%eax
 3e3:	cd 40                	int    $0x40
 3e5:	c3                   	ret    

000003e6 <open>:
SYSCALL(open)
 3e6:	b8 0f 00 00 00       	mov    $0xf,%eax
 3eb:	cd 40                	int    $0x40
 3ed:	c3                   	ret    

000003ee <mknod>:
SYSCALL(mknod)
 3ee:	b8 11 00 00 00       	mov    $0x11,%eax
 3f3:	cd 40                	int    $0x40
 3f5:	c3                   	ret    

000003f6 <unlink>:
SYSCALL(unlink)
 3f6:	b8 12 00 00 00       	mov    $0x12,%eax
 3fb:	cd 40                	int    $0x40
 3fd:	c3                   	ret    

000003fe <fstat>:
SYSCALL(fstat)
 3fe:	b8 08 00 00 00       	mov    $0x8,%eax
 403:	cd 40                	int    $0x40
 405:	c3                   	ret    

00000406 <link>:
SYSCALL(link)
 406:	b8 13 00 00 00       	mov    $0x13,%eax
 40b:	cd 40                	int    $0x40
 40d:	c3                   	ret    

0000040e <mkdir>:
SYSCALL(mkdir)
 40e:	b8 14 00 00 00       	mov    $0x14,%eax
 413:	cd 40                	int    $0x40
 415:	c3                   	ret    

00000416 <chdir>:
SYSCALL(chdir)
 416:	b8 09 00 00 00       	mov    $0x9,%eax
 41b:	cd 40                	int    $0x40
 41d:	c3                   	ret    

0000041e <dup>:
SYSCALL(dup)
 41e:	b8 0a 00 00 00       	mov    $0xa,%eax
 423:	cd 40                	int    $0x40
 425:	c3                   	ret    

00000426 <getpid>:
SYSCALL(getpid)
 426:	b8 0b 00 00 00       	mov    $0xb,%eax
 42b:	cd 40                	int    $0x40
 42d:	c3                   	ret    

0000042e <sbrk>:
SYSCALL(sbrk)
 42e:	b8 0c 00 00 00       	mov    $0xc,%eax
 433:	cd 40                	int    $0x40
 435:	c3                   	ret    

00000436 <sleep>:
SYSCALL(sleep)
 436:	b8 0d 00 00 00       	mov    $0xd,%eax
 43b:	cd 40                	int    $0x40
 43d:	c3                   	ret    

0000043e <uptime>:
SYSCALL(uptime)
 43e:	b8 0e 00 00 00       	mov    $0xe,%eax
 443:	cd 40                	int    $0x40
 445:	c3                   	ret    

00000446 <getcwd>:
SYSCALL(getcwd)
 446:	b8 16 00 00 00       	mov    $0x16,%eax
 44b:	cd 40                	int    $0x40
 44d:	c3                   	ret    

0000044e <ps>:
SYSCALL(ps)
 44e:	b8 17 00 00 00       	mov    $0x17,%eax
 453:	cd 40                	int    $0x40
 455:	c3                   	ret    

00000456 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 456:	55                   	push   %ebp
 457:	89 e5                	mov    %esp,%ebp
 459:	83 ec 18             	sub    $0x18,%esp
 45c:	8b 45 0c             	mov    0xc(%ebp),%eax
 45f:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 462:	83 ec 04             	sub    $0x4,%esp
 465:	6a 01                	push   $0x1
 467:	8d 45 f4             	lea    -0xc(%ebp),%eax
 46a:	50                   	push   %eax
 46b:	ff 75 08             	pushl  0x8(%ebp)
 46e:	e8 53 ff ff ff       	call   3c6 <write>
 473:	83 c4 10             	add    $0x10,%esp
}
 476:	c9                   	leave  
 477:	c3                   	ret    

00000478 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 478:	55                   	push   %ebp
 479:	89 e5                	mov    %esp,%ebp
 47b:	53                   	push   %ebx
 47c:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 47f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 486:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 48a:	74 17                	je     4a3 <printint+0x2b>
 48c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 490:	79 11                	jns    4a3 <printint+0x2b>
    neg = 1;
 492:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 499:	8b 45 0c             	mov    0xc(%ebp),%eax
 49c:	f7 d8                	neg    %eax
 49e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4a1:	eb 06                	jmp    4a9 <printint+0x31>
  } else {
    x = xx;
 4a3:	8b 45 0c             	mov    0xc(%ebp),%eax
 4a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4a9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4b0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4b3:	8d 41 01             	lea    0x1(%ecx),%eax
 4b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4b9:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4bc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4bf:	ba 00 00 00 00       	mov    $0x0,%edx
 4c4:	f7 f3                	div    %ebx
 4c6:	89 d0                	mov    %edx,%eax
 4c8:	0f b6 80 54 0b 00 00 	movzbl 0xb54(%eax),%eax
 4cf:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4d3:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4d9:	ba 00 00 00 00       	mov    $0x0,%edx
 4de:	f7 f3                	div    %ebx
 4e0:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4e3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e7:	75 c7                	jne    4b0 <printint+0x38>
  if(neg)
 4e9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4ed:	74 0e                	je     4fd <printint+0x85>
    buf[i++] = '-';
 4ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4f2:	8d 50 01             	lea    0x1(%eax),%edx
 4f5:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4f8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4fd:	eb 1d                	jmp    51c <printint+0xa4>
    putc(fd, buf[i]);
 4ff:	8d 55 dc             	lea    -0x24(%ebp),%edx
 502:	8b 45 f4             	mov    -0xc(%ebp),%eax
 505:	01 d0                	add    %edx,%eax
 507:	0f b6 00             	movzbl (%eax),%eax
 50a:	0f be c0             	movsbl %al,%eax
 50d:	83 ec 08             	sub    $0x8,%esp
 510:	50                   	push   %eax
 511:	ff 75 08             	pushl  0x8(%ebp)
 514:	e8 3d ff ff ff       	call   456 <putc>
 519:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 51c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 520:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 524:	79 d9                	jns    4ff <printint+0x87>
    putc(fd, buf[i]);
}
 526:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 529:	c9                   	leave  
 52a:	c3                   	ret    

0000052b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 52b:	55                   	push   %ebp
 52c:	89 e5                	mov    %esp,%ebp
 52e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 531:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 538:	8d 45 0c             	lea    0xc(%ebp),%eax
 53b:	83 c0 04             	add    $0x4,%eax
 53e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 541:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 548:	e9 59 01 00 00       	jmp    6a6 <printf+0x17b>
    c = fmt[i] & 0xff;
 54d:	8b 55 0c             	mov    0xc(%ebp),%edx
 550:	8b 45 f0             	mov    -0x10(%ebp),%eax
 553:	01 d0                	add    %edx,%eax
 555:	0f b6 00             	movzbl (%eax),%eax
 558:	0f be c0             	movsbl %al,%eax
 55b:	25 ff 00 00 00       	and    $0xff,%eax
 560:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 563:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 567:	75 2c                	jne    595 <printf+0x6a>
      if(c == '%'){
 569:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 56d:	75 0c                	jne    57b <printf+0x50>
        state = '%';
 56f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 576:	e9 27 01 00 00       	jmp    6a2 <printf+0x177>
      } else {
        putc(fd, c);
 57b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 57e:	0f be c0             	movsbl %al,%eax
 581:	83 ec 08             	sub    $0x8,%esp
 584:	50                   	push   %eax
 585:	ff 75 08             	pushl  0x8(%ebp)
 588:	e8 c9 fe ff ff       	call   456 <putc>
 58d:	83 c4 10             	add    $0x10,%esp
 590:	e9 0d 01 00 00       	jmp    6a2 <printf+0x177>
      }
    } else if(state == '%'){
 595:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 599:	0f 85 03 01 00 00    	jne    6a2 <printf+0x177>
      if(c == 'd'){
 59f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5a3:	75 1e                	jne    5c3 <printf+0x98>
        printint(fd, *ap, 10, 1);
 5a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a8:	8b 00                	mov    (%eax),%eax
 5aa:	6a 01                	push   $0x1
 5ac:	6a 0a                	push   $0xa
 5ae:	50                   	push   %eax
 5af:	ff 75 08             	pushl  0x8(%ebp)
 5b2:	e8 c1 fe ff ff       	call   478 <printint>
 5b7:	83 c4 10             	add    $0x10,%esp
        ap++;
 5ba:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5be:	e9 d8 00 00 00       	jmp    69b <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 5c3:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5c7:	74 06                	je     5cf <printf+0xa4>
 5c9:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5cd:	75 1e                	jne    5ed <printf+0xc2>
        printint(fd, *ap, 16, 0);
 5cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d2:	8b 00                	mov    (%eax),%eax
 5d4:	6a 00                	push   $0x0
 5d6:	6a 10                	push   $0x10
 5d8:	50                   	push   %eax
 5d9:	ff 75 08             	pushl  0x8(%ebp)
 5dc:	e8 97 fe ff ff       	call   478 <printint>
 5e1:	83 c4 10             	add    $0x10,%esp
        ap++;
 5e4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5e8:	e9 ae 00 00 00       	jmp    69b <printf+0x170>
      } else if(c == 's'){
 5ed:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5f1:	75 43                	jne    636 <printf+0x10b>
        s = (char*)*ap;
 5f3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5f6:	8b 00                	mov    (%eax),%eax
 5f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5fb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5ff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 603:	75 07                	jne    60c <printf+0xe1>
          s = "(null)";
 605:	c7 45 f4 02 09 00 00 	movl   $0x902,-0xc(%ebp)
        while(*s != 0){
 60c:	eb 1c                	jmp    62a <printf+0xff>
          putc(fd, *s);
 60e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 611:	0f b6 00             	movzbl (%eax),%eax
 614:	0f be c0             	movsbl %al,%eax
 617:	83 ec 08             	sub    $0x8,%esp
 61a:	50                   	push   %eax
 61b:	ff 75 08             	pushl  0x8(%ebp)
 61e:	e8 33 fe ff ff       	call   456 <putc>
 623:	83 c4 10             	add    $0x10,%esp
          s++;
 626:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 62a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 62d:	0f b6 00             	movzbl (%eax),%eax
 630:	84 c0                	test   %al,%al
 632:	75 da                	jne    60e <printf+0xe3>
 634:	eb 65                	jmp    69b <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 636:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 63a:	75 1d                	jne    659 <printf+0x12e>
        putc(fd, *ap);
 63c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 63f:	8b 00                	mov    (%eax),%eax
 641:	0f be c0             	movsbl %al,%eax
 644:	83 ec 08             	sub    $0x8,%esp
 647:	50                   	push   %eax
 648:	ff 75 08             	pushl  0x8(%ebp)
 64b:	e8 06 fe ff ff       	call   456 <putc>
 650:	83 c4 10             	add    $0x10,%esp
        ap++;
 653:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 657:	eb 42                	jmp    69b <printf+0x170>
      } else if(c == '%'){
 659:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 65d:	75 17                	jne    676 <printf+0x14b>
        putc(fd, c);
 65f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 662:	0f be c0             	movsbl %al,%eax
 665:	83 ec 08             	sub    $0x8,%esp
 668:	50                   	push   %eax
 669:	ff 75 08             	pushl  0x8(%ebp)
 66c:	e8 e5 fd ff ff       	call   456 <putc>
 671:	83 c4 10             	add    $0x10,%esp
 674:	eb 25                	jmp    69b <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 676:	83 ec 08             	sub    $0x8,%esp
 679:	6a 25                	push   $0x25
 67b:	ff 75 08             	pushl  0x8(%ebp)
 67e:	e8 d3 fd ff ff       	call   456 <putc>
 683:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 686:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 689:	0f be c0             	movsbl %al,%eax
 68c:	83 ec 08             	sub    $0x8,%esp
 68f:	50                   	push   %eax
 690:	ff 75 08             	pushl  0x8(%ebp)
 693:	e8 be fd ff ff       	call   456 <putc>
 698:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 69b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6a2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6a6:	8b 55 0c             	mov    0xc(%ebp),%edx
 6a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6ac:	01 d0                	add    %edx,%eax
 6ae:	0f b6 00             	movzbl (%eax),%eax
 6b1:	84 c0                	test   %al,%al
 6b3:	0f 85 94 fe ff ff    	jne    54d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6b9:	c9                   	leave  
 6ba:	c3                   	ret    

000006bb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6bb:	55                   	push   %ebp
 6bc:	89 e5                	mov    %esp,%ebp
 6be:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6c1:	8b 45 08             	mov    0x8(%ebp),%eax
 6c4:	83 e8 08             	sub    $0x8,%eax
 6c7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ca:	a1 70 0b 00 00       	mov    0xb70,%eax
 6cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6d2:	eb 24                	jmp    6f8 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d7:	8b 00                	mov    (%eax),%eax
 6d9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6dc:	77 12                	ja     6f0 <free+0x35>
 6de:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6e4:	77 24                	ja     70a <free+0x4f>
 6e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e9:	8b 00                	mov    (%eax),%eax
 6eb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6ee:	77 1a                	ja     70a <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f3:	8b 00                	mov    (%eax),%eax
 6f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6fe:	76 d4                	jbe    6d4 <free+0x19>
 700:	8b 45 fc             	mov    -0x4(%ebp),%eax
 703:	8b 00                	mov    (%eax),%eax
 705:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 708:	76 ca                	jbe    6d4 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 70a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70d:	8b 40 04             	mov    0x4(%eax),%eax
 710:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 717:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71a:	01 c2                	add    %eax,%edx
 71c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71f:	8b 00                	mov    (%eax),%eax
 721:	39 c2                	cmp    %eax,%edx
 723:	75 24                	jne    749 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 725:	8b 45 f8             	mov    -0x8(%ebp),%eax
 728:	8b 50 04             	mov    0x4(%eax),%edx
 72b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72e:	8b 00                	mov    (%eax),%eax
 730:	8b 40 04             	mov    0x4(%eax),%eax
 733:	01 c2                	add    %eax,%edx
 735:	8b 45 f8             	mov    -0x8(%ebp),%eax
 738:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 73b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73e:	8b 00                	mov    (%eax),%eax
 740:	8b 10                	mov    (%eax),%edx
 742:	8b 45 f8             	mov    -0x8(%ebp),%eax
 745:	89 10                	mov    %edx,(%eax)
 747:	eb 0a                	jmp    753 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 749:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74c:	8b 10                	mov    (%eax),%edx
 74e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 751:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 753:	8b 45 fc             	mov    -0x4(%ebp),%eax
 756:	8b 40 04             	mov    0x4(%eax),%eax
 759:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 760:	8b 45 fc             	mov    -0x4(%ebp),%eax
 763:	01 d0                	add    %edx,%eax
 765:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 768:	75 20                	jne    78a <free+0xcf>
    p->s.size += bp->s.size;
 76a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76d:	8b 50 04             	mov    0x4(%eax),%edx
 770:	8b 45 f8             	mov    -0x8(%ebp),%eax
 773:	8b 40 04             	mov    0x4(%eax),%eax
 776:	01 c2                	add    %eax,%edx
 778:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 77e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 781:	8b 10                	mov    (%eax),%edx
 783:	8b 45 fc             	mov    -0x4(%ebp),%eax
 786:	89 10                	mov    %edx,(%eax)
 788:	eb 08                	jmp    792 <free+0xd7>
  } else
    p->s.ptr = bp;
 78a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 790:	89 10                	mov    %edx,(%eax)
  freep = p;
 792:	8b 45 fc             	mov    -0x4(%ebp),%eax
 795:	a3 70 0b 00 00       	mov    %eax,0xb70
}
 79a:	c9                   	leave  
 79b:	c3                   	ret    

0000079c <morecore>:

static Header*
morecore(uint nu)
{
 79c:	55                   	push   %ebp
 79d:	89 e5                	mov    %esp,%ebp
 79f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7a2:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7a9:	77 07                	ja     7b2 <morecore+0x16>
    nu = 4096;
 7ab:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7b2:	8b 45 08             	mov    0x8(%ebp),%eax
 7b5:	c1 e0 03             	shl    $0x3,%eax
 7b8:	83 ec 0c             	sub    $0xc,%esp
 7bb:	50                   	push   %eax
 7bc:	e8 6d fc ff ff       	call   42e <sbrk>
 7c1:	83 c4 10             	add    $0x10,%esp
 7c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7c7:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7cb:	75 07                	jne    7d4 <morecore+0x38>
    return 0;
 7cd:	b8 00 00 00 00       	mov    $0x0,%eax
 7d2:	eb 26                	jmp    7fa <morecore+0x5e>
  hp = (Header*)p;
 7d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7da:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7dd:	8b 55 08             	mov    0x8(%ebp),%edx
 7e0:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e6:	83 c0 08             	add    $0x8,%eax
 7e9:	83 ec 0c             	sub    $0xc,%esp
 7ec:	50                   	push   %eax
 7ed:	e8 c9 fe ff ff       	call   6bb <free>
 7f2:	83 c4 10             	add    $0x10,%esp
  return freep;
 7f5:	a1 70 0b 00 00       	mov    0xb70,%eax
}
 7fa:	c9                   	leave  
 7fb:	c3                   	ret    

000007fc <malloc>:

void*
malloc(uint nbytes)
{
 7fc:	55                   	push   %ebp
 7fd:	89 e5                	mov    %esp,%ebp
 7ff:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 802:	8b 45 08             	mov    0x8(%ebp),%eax
 805:	83 c0 07             	add    $0x7,%eax
 808:	c1 e8 03             	shr    $0x3,%eax
 80b:	83 c0 01             	add    $0x1,%eax
 80e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 811:	a1 70 0b 00 00       	mov    0xb70,%eax
 816:	89 45 f0             	mov    %eax,-0x10(%ebp)
 819:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 81d:	75 23                	jne    842 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 81f:	c7 45 f0 68 0b 00 00 	movl   $0xb68,-0x10(%ebp)
 826:	8b 45 f0             	mov    -0x10(%ebp),%eax
 829:	a3 70 0b 00 00       	mov    %eax,0xb70
 82e:	a1 70 0b 00 00       	mov    0xb70,%eax
 833:	a3 68 0b 00 00       	mov    %eax,0xb68
    base.s.size = 0;
 838:	c7 05 6c 0b 00 00 00 	movl   $0x0,0xb6c
 83f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 842:	8b 45 f0             	mov    -0x10(%ebp),%eax
 845:	8b 00                	mov    (%eax),%eax
 847:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84d:	8b 40 04             	mov    0x4(%eax),%eax
 850:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 853:	72 4d                	jb     8a2 <malloc+0xa6>
      if(p->s.size == nunits)
 855:	8b 45 f4             	mov    -0xc(%ebp),%eax
 858:	8b 40 04             	mov    0x4(%eax),%eax
 85b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 85e:	75 0c                	jne    86c <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 860:	8b 45 f4             	mov    -0xc(%ebp),%eax
 863:	8b 10                	mov    (%eax),%edx
 865:	8b 45 f0             	mov    -0x10(%ebp),%eax
 868:	89 10                	mov    %edx,(%eax)
 86a:	eb 26                	jmp    892 <malloc+0x96>
      else {
        p->s.size -= nunits;
 86c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86f:	8b 40 04             	mov    0x4(%eax),%eax
 872:	2b 45 ec             	sub    -0x14(%ebp),%eax
 875:	89 c2                	mov    %eax,%edx
 877:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87a:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 87d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 880:	8b 40 04             	mov    0x4(%eax),%eax
 883:	c1 e0 03             	shl    $0x3,%eax
 886:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 889:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88c:	8b 55 ec             	mov    -0x14(%ebp),%edx
 88f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 892:	8b 45 f0             	mov    -0x10(%ebp),%eax
 895:	a3 70 0b 00 00       	mov    %eax,0xb70
      return (void*)(p + 1);
 89a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89d:	83 c0 08             	add    $0x8,%eax
 8a0:	eb 3b                	jmp    8dd <malloc+0xe1>
    }
    if(p == freep)
 8a2:	a1 70 0b 00 00       	mov    0xb70,%eax
 8a7:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8aa:	75 1e                	jne    8ca <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 8ac:	83 ec 0c             	sub    $0xc,%esp
 8af:	ff 75 ec             	pushl  -0x14(%ebp)
 8b2:	e8 e5 fe ff ff       	call   79c <morecore>
 8b7:	83 c4 10             	add    $0x10,%esp
 8ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8c1:	75 07                	jne    8ca <malloc+0xce>
        return 0;
 8c3:	b8 00 00 00 00       	mov    $0x0,%eax
 8c8:	eb 13                	jmp    8dd <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d3:	8b 00                	mov    (%eax),%eax
 8d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8d8:	e9 6d ff ff ff       	jmp    84a <malloc+0x4e>
}
 8dd:	c9                   	leave  
 8de:	c3                   	ret    
