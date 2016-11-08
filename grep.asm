
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
   6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
   d:	e9 ad 00 00 00       	jmp    bf <grep+0xbf>
    m += n;
  12:	8b 45 ec             	mov    -0x14(%ebp),%eax
  15:	01 45 f4             	add    %eax,-0xc(%ebp)
    p = buf;
  18:	c7 45 f0 40 0e 00 00 	movl   $0xe40,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  1f:	eb 4a                	jmp    6b <grep+0x6b>
      *q = 0;
  21:	8b 45 e8             	mov    -0x18(%ebp),%eax
  24:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
  27:	83 ec 08             	sub    $0x8,%esp
  2a:	ff 75 f0             	pushl  -0x10(%ebp)
  2d:	ff 75 08             	pushl  0x8(%ebp)
  30:	e8 9b 01 00 00       	call   1d0 <match>
  35:	83 c4 10             	add    $0x10,%esp
  38:	85 c0                	test   %eax,%eax
  3a:	74 26                	je     62 <grep+0x62>
        *q = '\n';
  3c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  3f:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
  42:	8b 45 e8             	mov    -0x18(%ebp),%eax
  45:	83 c0 01             	add    $0x1,%eax
  48:	89 c2                	mov    %eax,%edx
  4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  4d:	29 c2                	sub    %eax,%edx
  4f:	89 d0                	mov    %edx,%eax
  51:	83 ec 04             	sub    $0x4,%esp
  54:	50                   	push   %eax
  55:	ff 75 f0             	pushl  -0x10(%ebp)
  58:	6a 01                	push   $0x1
  5a:	e8 42 05 00 00       	call   5a1 <write>
  5f:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
  62:	8b 45 e8             	mov    -0x18(%ebp),%eax
  65:	83 c0 01             	add    $0x1,%eax
  68:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
    m += n;
    p = buf;
    while((q = strchr(p, '\n')) != 0){
  6b:	83 ec 08             	sub    $0x8,%esp
  6e:	6a 0a                	push   $0xa
  70:	ff 75 f0             	pushl  -0x10(%ebp)
  73:	e8 89 03 00 00       	call   401 <strchr>
  78:	83 c4 10             	add    $0x10,%esp
  7b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  7e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  82:	75 9d                	jne    21 <grep+0x21>
        *q = '\n';
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
  84:	81 7d f0 40 0e 00 00 	cmpl   $0xe40,-0x10(%ebp)
  8b:	75 07                	jne    94 <grep+0x94>
      m = 0;
  8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
  94:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  98:	7e 25                	jle    bf <grep+0xbf>
      m -= p - buf;
  9a:	ba 40 0e 00 00       	mov    $0xe40,%edx
  9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  a2:	29 c2                	sub    %eax,%edx
  a4:	89 d0                	mov    %edx,%eax
  a6:	01 45 f4             	add    %eax,-0xc(%ebp)
      memmove(buf, p, m);
  a9:	83 ec 04             	sub    $0x4,%esp
  ac:	ff 75 f4             	pushl  -0xc(%ebp)
  af:	ff 75 f0             	pushl  -0x10(%ebp)
  b2:	68 40 0e 00 00       	push   $0xe40
  b7:	e8 80 04 00 00       	call   53c <memmove>
  bc:	83 c4 10             	add    $0x10,%esp
{
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
  bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  c2:	ba 00 04 00 00       	mov    $0x400,%edx
  c7:	29 c2                	sub    %eax,%edx
  c9:	89 d0                	mov    %edx,%eax
  cb:	89 c2                	mov    %eax,%edx
  cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  d0:	05 40 0e 00 00       	add    $0xe40,%eax
  d5:	83 ec 04             	sub    $0x4,%esp
  d8:	52                   	push   %edx
  d9:	50                   	push   %eax
  da:	ff 75 0c             	pushl  0xc(%ebp)
  dd:	e8 b7 04 00 00       	call   599 <read>
  e2:	83 c4 10             	add    $0x10,%esp
  e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  e8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  ec:	0f 8f 20 ff ff ff    	jg     12 <grep+0x12>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
  f2:	c9                   	leave  
  f3:	c3                   	ret    

000000f4 <main>:

int
main(int argc, char *argv[])
{
  f4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f8:	83 e4 f0             	and    $0xfffffff0,%esp
  fb:	ff 71 fc             	pushl  -0x4(%ecx)
  fe:	55                   	push   %ebp
  ff:	89 e5                	mov    %esp,%ebp
 101:	53                   	push   %ebx
 102:	51                   	push   %ecx
 103:	83 ec 10             	sub    $0x10,%esp
 106:	89 cb                	mov    %ecx,%ebx
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
 108:	83 3b 01             	cmpl   $0x1,(%ebx)
 10b:	7f 17                	jg     124 <main+0x30>
    printf(2, "usage: grep pattern [file ...]\n");
 10d:	83 ec 08             	sub    $0x8,%esp
 110:	68 b4 0a 00 00       	push   $0xab4
 115:	6a 02                	push   $0x2
 117:	e8 e2 05 00 00       	call   6fe <printf>
 11c:	83 c4 10             	add    $0x10,%esp
    exit();
 11f:	e8 5d 04 00 00       	call   581 <exit>
  }
  pattern = argv[1];
 124:	8b 43 04             	mov    0x4(%ebx),%eax
 127:	8b 40 04             	mov    0x4(%eax),%eax
 12a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  if(argc <= 2){
 12d:	83 3b 02             	cmpl   $0x2,(%ebx)
 130:	7f 15                	jg     147 <main+0x53>
    grep(pattern, 0);
 132:	83 ec 08             	sub    $0x8,%esp
 135:	6a 00                	push   $0x0
 137:	ff 75 f0             	pushl  -0x10(%ebp)
 13a:	e8 c1 fe ff ff       	call   0 <grep>
 13f:	83 c4 10             	add    $0x10,%esp
    exit();
 142:	e8 3a 04 00 00       	call   581 <exit>
  }

  for(i = 2; i < argc; i++){
 147:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
 14e:	eb 74                	jmp    1c4 <main+0xd0>
    if((fd = open(argv[i], 0)) < 0){
 150:	8b 45 f4             	mov    -0xc(%ebp),%eax
 153:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 15a:	8b 43 04             	mov    0x4(%ebx),%eax
 15d:	01 d0                	add    %edx,%eax
 15f:	8b 00                	mov    (%eax),%eax
 161:	83 ec 08             	sub    $0x8,%esp
 164:	6a 00                	push   $0x0
 166:	50                   	push   %eax
 167:	e8 55 04 00 00       	call   5c1 <open>
 16c:	83 c4 10             	add    $0x10,%esp
 16f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 172:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 176:	79 29                	jns    1a1 <main+0xad>
      printf(1, "grep: cannot open %s\n", argv[i]);
 178:	8b 45 f4             	mov    -0xc(%ebp),%eax
 17b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 182:	8b 43 04             	mov    0x4(%ebx),%eax
 185:	01 d0                	add    %edx,%eax
 187:	8b 00                	mov    (%eax),%eax
 189:	83 ec 04             	sub    $0x4,%esp
 18c:	50                   	push   %eax
 18d:	68 d4 0a 00 00       	push   $0xad4
 192:	6a 01                	push   $0x1
 194:	e8 65 05 00 00       	call   6fe <printf>
 199:	83 c4 10             	add    $0x10,%esp
      exit();
 19c:	e8 e0 03 00 00       	call   581 <exit>
    }
    grep(pattern, fd);
 1a1:	83 ec 08             	sub    $0x8,%esp
 1a4:	ff 75 ec             	pushl  -0x14(%ebp)
 1a7:	ff 75 f0             	pushl  -0x10(%ebp)
 1aa:	e8 51 fe ff ff       	call   0 <grep>
 1af:	83 c4 10             	add    $0x10,%esp
    close(fd);
 1b2:	83 ec 0c             	sub    $0xc,%esp
 1b5:	ff 75 ec             	pushl  -0x14(%ebp)
 1b8:	e8 ec 03 00 00       	call   5a9 <close>
 1bd:	83 c4 10             	add    $0x10,%esp
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
 1c0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 1c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c7:	3b 03                	cmp    (%ebx),%eax
 1c9:	7c 85                	jl     150 <main+0x5c>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
 1cb:	e8 b1 03 00 00       	call   581 <exit>

000001d0 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '^')
 1d6:	8b 45 08             	mov    0x8(%ebp),%eax
 1d9:	0f b6 00             	movzbl (%eax),%eax
 1dc:	3c 5e                	cmp    $0x5e,%al
 1de:	75 17                	jne    1f7 <match+0x27>
    return matchhere(re+1, text);
 1e0:	8b 45 08             	mov    0x8(%ebp),%eax
 1e3:	83 c0 01             	add    $0x1,%eax
 1e6:	83 ec 08             	sub    $0x8,%esp
 1e9:	ff 75 0c             	pushl  0xc(%ebp)
 1ec:	50                   	push   %eax
 1ed:	e8 38 00 00 00       	call   22a <matchhere>
 1f2:	83 c4 10             	add    $0x10,%esp
 1f5:	eb 31                	jmp    228 <match+0x58>
  do{  // must look at empty string
    if(matchhere(re, text))
 1f7:	83 ec 08             	sub    $0x8,%esp
 1fa:	ff 75 0c             	pushl  0xc(%ebp)
 1fd:	ff 75 08             	pushl  0x8(%ebp)
 200:	e8 25 00 00 00       	call   22a <matchhere>
 205:	83 c4 10             	add    $0x10,%esp
 208:	85 c0                	test   %eax,%eax
 20a:	74 07                	je     213 <match+0x43>
      return 1;
 20c:	b8 01 00 00 00       	mov    $0x1,%eax
 211:	eb 15                	jmp    228 <match+0x58>
  }while(*text++ != '\0');
 213:	8b 45 0c             	mov    0xc(%ebp),%eax
 216:	8d 50 01             	lea    0x1(%eax),%edx
 219:	89 55 0c             	mov    %edx,0xc(%ebp)
 21c:	0f b6 00             	movzbl (%eax),%eax
 21f:	84 c0                	test   %al,%al
 221:	75 d4                	jne    1f7 <match+0x27>
  return 0;
 223:	b8 00 00 00 00       	mov    $0x0,%eax
}
 228:	c9                   	leave  
 229:	c3                   	ret    

0000022a <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 22a:	55                   	push   %ebp
 22b:	89 e5                	mov    %esp,%ebp
 22d:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '\0')
 230:	8b 45 08             	mov    0x8(%ebp),%eax
 233:	0f b6 00             	movzbl (%eax),%eax
 236:	84 c0                	test   %al,%al
 238:	75 0a                	jne    244 <matchhere+0x1a>
    return 1;
 23a:	b8 01 00 00 00       	mov    $0x1,%eax
 23f:	e9 99 00 00 00       	jmp    2dd <matchhere+0xb3>
  if(re[1] == '*')
 244:	8b 45 08             	mov    0x8(%ebp),%eax
 247:	83 c0 01             	add    $0x1,%eax
 24a:	0f b6 00             	movzbl (%eax),%eax
 24d:	3c 2a                	cmp    $0x2a,%al
 24f:	75 21                	jne    272 <matchhere+0x48>
    return matchstar(re[0], re+2, text);
 251:	8b 45 08             	mov    0x8(%ebp),%eax
 254:	8d 50 02             	lea    0x2(%eax),%edx
 257:	8b 45 08             	mov    0x8(%ebp),%eax
 25a:	0f b6 00             	movzbl (%eax),%eax
 25d:	0f be c0             	movsbl %al,%eax
 260:	83 ec 04             	sub    $0x4,%esp
 263:	ff 75 0c             	pushl  0xc(%ebp)
 266:	52                   	push   %edx
 267:	50                   	push   %eax
 268:	e8 72 00 00 00       	call   2df <matchstar>
 26d:	83 c4 10             	add    $0x10,%esp
 270:	eb 6b                	jmp    2dd <matchhere+0xb3>
  if(re[0] == '$' && re[1] == '\0')
 272:	8b 45 08             	mov    0x8(%ebp),%eax
 275:	0f b6 00             	movzbl (%eax),%eax
 278:	3c 24                	cmp    $0x24,%al
 27a:	75 1d                	jne    299 <matchhere+0x6f>
 27c:	8b 45 08             	mov    0x8(%ebp),%eax
 27f:	83 c0 01             	add    $0x1,%eax
 282:	0f b6 00             	movzbl (%eax),%eax
 285:	84 c0                	test   %al,%al
 287:	75 10                	jne    299 <matchhere+0x6f>
    return *text == '\0';
 289:	8b 45 0c             	mov    0xc(%ebp),%eax
 28c:	0f b6 00             	movzbl (%eax),%eax
 28f:	84 c0                	test   %al,%al
 291:	0f 94 c0             	sete   %al
 294:	0f b6 c0             	movzbl %al,%eax
 297:	eb 44                	jmp    2dd <matchhere+0xb3>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 299:	8b 45 0c             	mov    0xc(%ebp),%eax
 29c:	0f b6 00             	movzbl (%eax),%eax
 29f:	84 c0                	test   %al,%al
 2a1:	74 35                	je     2d8 <matchhere+0xae>
 2a3:	8b 45 08             	mov    0x8(%ebp),%eax
 2a6:	0f b6 00             	movzbl (%eax),%eax
 2a9:	3c 2e                	cmp    $0x2e,%al
 2ab:	74 10                	je     2bd <matchhere+0x93>
 2ad:	8b 45 08             	mov    0x8(%ebp),%eax
 2b0:	0f b6 10             	movzbl (%eax),%edx
 2b3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b6:	0f b6 00             	movzbl (%eax),%eax
 2b9:	38 c2                	cmp    %al,%dl
 2bb:	75 1b                	jne    2d8 <matchhere+0xae>
    return matchhere(re+1, text+1);
 2bd:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c0:	8d 50 01             	lea    0x1(%eax),%edx
 2c3:	8b 45 08             	mov    0x8(%ebp),%eax
 2c6:	83 c0 01             	add    $0x1,%eax
 2c9:	83 ec 08             	sub    $0x8,%esp
 2cc:	52                   	push   %edx
 2cd:	50                   	push   %eax
 2ce:	e8 57 ff ff ff       	call   22a <matchhere>
 2d3:	83 c4 10             	add    $0x10,%esp
 2d6:	eb 05                	jmp    2dd <matchhere+0xb3>
  return 0;
 2d8:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2dd:	c9                   	leave  
 2de:	c3                   	ret    

000002df <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
 2df:	55                   	push   %ebp
 2e0:	89 e5                	mov    %esp,%ebp
 2e2:	83 ec 08             	sub    $0x8,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 2e5:	83 ec 08             	sub    $0x8,%esp
 2e8:	ff 75 10             	pushl  0x10(%ebp)
 2eb:	ff 75 0c             	pushl  0xc(%ebp)
 2ee:	e8 37 ff ff ff       	call   22a <matchhere>
 2f3:	83 c4 10             	add    $0x10,%esp
 2f6:	85 c0                	test   %eax,%eax
 2f8:	74 07                	je     301 <matchstar+0x22>
      return 1;
 2fa:	b8 01 00 00 00       	mov    $0x1,%eax
 2ff:	eb 29                	jmp    32a <matchstar+0x4b>
  }while(*text!='\0' && (*text++==c || c=='.'));
 301:	8b 45 10             	mov    0x10(%ebp),%eax
 304:	0f b6 00             	movzbl (%eax),%eax
 307:	84 c0                	test   %al,%al
 309:	74 1a                	je     325 <matchstar+0x46>
 30b:	8b 45 10             	mov    0x10(%ebp),%eax
 30e:	8d 50 01             	lea    0x1(%eax),%edx
 311:	89 55 10             	mov    %edx,0x10(%ebp)
 314:	0f b6 00             	movzbl (%eax),%eax
 317:	0f be c0             	movsbl %al,%eax
 31a:	3b 45 08             	cmp    0x8(%ebp),%eax
 31d:	74 c6                	je     2e5 <matchstar+0x6>
 31f:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
 323:	74 c0                	je     2e5 <matchstar+0x6>
  return 0;
 325:	b8 00 00 00 00       	mov    $0x0,%eax
}
 32a:	c9                   	leave  
 32b:	c3                   	ret    

0000032c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 32c:	55                   	push   %ebp
 32d:	89 e5                	mov    %esp,%ebp
 32f:	57                   	push   %edi
 330:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 331:	8b 4d 08             	mov    0x8(%ebp),%ecx
 334:	8b 55 10             	mov    0x10(%ebp),%edx
 337:	8b 45 0c             	mov    0xc(%ebp),%eax
 33a:	89 cb                	mov    %ecx,%ebx
 33c:	89 df                	mov    %ebx,%edi
 33e:	89 d1                	mov    %edx,%ecx
 340:	fc                   	cld    
 341:	f3 aa                	rep stos %al,%es:(%edi)
 343:	89 ca                	mov    %ecx,%edx
 345:	89 fb                	mov    %edi,%ebx
 347:	89 5d 08             	mov    %ebx,0x8(%ebp)
 34a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 34d:	5b                   	pop    %ebx
 34e:	5f                   	pop    %edi
 34f:	5d                   	pop    %ebp
 350:	c3                   	ret    

00000351 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 351:	55                   	push   %ebp
 352:	89 e5                	mov    %esp,%ebp
 354:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 357:	8b 45 08             	mov    0x8(%ebp),%eax
 35a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 35d:	90                   	nop
 35e:	8b 45 08             	mov    0x8(%ebp),%eax
 361:	8d 50 01             	lea    0x1(%eax),%edx
 364:	89 55 08             	mov    %edx,0x8(%ebp)
 367:	8b 55 0c             	mov    0xc(%ebp),%edx
 36a:	8d 4a 01             	lea    0x1(%edx),%ecx
 36d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 370:	0f b6 12             	movzbl (%edx),%edx
 373:	88 10                	mov    %dl,(%eax)
 375:	0f b6 00             	movzbl (%eax),%eax
 378:	84 c0                	test   %al,%al
 37a:	75 e2                	jne    35e <strcpy+0xd>
    ;
  return os;
 37c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 37f:	c9                   	leave  
 380:	c3                   	ret    

00000381 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 381:	55                   	push   %ebp
 382:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 384:	eb 08                	jmp    38e <strcmp+0xd>
    p++, q++;
 386:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 38a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 38e:	8b 45 08             	mov    0x8(%ebp),%eax
 391:	0f b6 00             	movzbl (%eax),%eax
 394:	84 c0                	test   %al,%al
 396:	74 10                	je     3a8 <strcmp+0x27>
 398:	8b 45 08             	mov    0x8(%ebp),%eax
 39b:	0f b6 10             	movzbl (%eax),%edx
 39e:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a1:	0f b6 00             	movzbl (%eax),%eax
 3a4:	38 c2                	cmp    %al,%dl
 3a6:	74 de                	je     386 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3a8:	8b 45 08             	mov    0x8(%ebp),%eax
 3ab:	0f b6 00             	movzbl (%eax),%eax
 3ae:	0f b6 d0             	movzbl %al,%edx
 3b1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b4:	0f b6 00             	movzbl (%eax),%eax
 3b7:	0f b6 c0             	movzbl %al,%eax
 3ba:	29 c2                	sub    %eax,%edx
 3bc:	89 d0                	mov    %edx,%eax
}
 3be:	5d                   	pop    %ebp
 3bf:	c3                   	ret    

000003c0 <strlen>:

uint
strlen(char *s)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3cd:	eb 04                	jmp    3d3 <strlen+0x13>
 3cf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3d6:	8b 45 08             	mov    0x8(%ebp),%eax
 3d9:	01 d0                	add    %edx,%eax
 3db:	0f b6 00             	movzbl (%eax),%eax
 3de:	84 c0                	test   %al,%al
 3e0:	75 ed                	jne    3cf <strlen+0xf>
    ;
  return n;
 3e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3e5:	c9                   	leave  
 3e6:	c3                   	ret    

000003e7 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3e7:	55                   	push   %ebp
 3e8:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 3ea:	8b 45 10             	mov    0x10(%ebp),%eax
 3ed:	50                   	push   %eax
 3ee:	ff 75 0c             	pushl  0xc(%ebp)
 3f1:	ff 75 08             	pushl  0x8(%ebp)
 3f4:	e8 33 ff ff ff       	call   32c <stosb>
 3f9:	83 c4 0c             	add    $0xc,%esp
  return dst;
 3fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3ff:	c9                   	leave  
 400:	c3                   	ret    

00000401 <strchr>:

char*
strchr(const char *s, char c)
{
 401:	55                   	push   %ebp
 402:	89 e5                	mov    %esp,%ebp
 404:	83 ec 04             	sub    $0x4,%esp
 407:	8b 45 0c             	mov    0xc(%ebp),%eax
 40a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 40d:	eb 14                	jmp    423 <strchr+0x22>
    if(*s == c)
 40f:	8b 45 08             	mov    0x8(%ebp),%eax
 412:	0f b6 00             	movzbl (%eax),%eax
 415:	3a 45 fc             	cmp    -0x4(%ebp),%al
 418:	75 05                	jne    41f <strchr+0x1e>
      return (char*)s;
 41a:	8b 45 08             	mov    0x8(%ebp),%eax
 41d:	eb 13                	jmp    432 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 41f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 423:	8b 45 08             	mov    0x8(%ebp),%eax
 426:	0f b6 00             	movzbl (%eax),%eax
 429:	84 c0                	test   %al,%al
 42b:	75 e2                	jne    40f <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 42d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 432:	c9                   	leave  
 433:	c3                   	ret    

00000434 <gets>:

char*
gets(char *buf, int max)
{
 434:	55                   	push   %ebp
 435:	89 e5                	mov    %esp,%ebp
 437:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 43a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 441:	eb 44                	jmp    487 <gets+0x53>
    cc = read(0, &c, 1);
 443:	83 ec 04             	sub    $0x4,%esp
 446:	6a 01                	push   $0x1
 448:	8d 45 ef             	lea    -0x11(%ebp),%eax
 44b:	50                   	push   %eax
 44c:	6a 00                	push   $0x0
 44e:	e8 46 01 00 00       	call   599 <read>
 453:	83 c4 10             	add    $0x10,%esp
 456:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 459:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 45d:	7f 02                	jg     461 <gets+0x2d>
      break;
 45f:	eb 31                	jmp    492 <gets+0x5e>
    buf[i++] = c;
 461:	8b 45 f4             	mov    -0xc(%ebp),%eax
 464:	8d 50 01             	lea    0x1(%eax),%edx
 467:	89 55 f4             	mov    %edx,-0xc(%ebp)
 46a:	89 c2                	mov    %eax,%edx
 46c:	8b 45 08             	mov    0x8(%ebp),%eax
 46f:	01 c2                	add    %eax,%edx
 471:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 475:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 477:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 47b:	3c 0a                	cmp    $0xa,%al
 47d:	74 13                	je     492 <gets+0x5e>
 47f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 483:	3c 0d                	cmp    $0xd,%al
 485:	74 0b                	je     492 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 487:	8b 45 f4             	mov    -0xc(%ebp),%eax
 48a:	83 c0 01             	add    $0x1,%eax
 48d:	3b 45 0c             	cmp    0xc(%ebp),%eax
 490:	7c b1                	jl     443 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 492:	8b 55 f4             	mov    -0xc(%ebp),%edx
 495:	8b 45 08             	mov    0x8(%ebp),%eax
 498:	01 d0                	add    %edx,%eax
 49a:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 49d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4a0:	c9                   	leave  
 4a1:	c3                   	ret    

000004a2 <stat>:

int
stat(char *n, struct stat *st)
{
 4a2:	55                   	push   %ebp
 4a3:	89 e5                	mov    %esp,%ebp
 4a5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4a8:	83 ec 08             	sub    $0x8,%esp
 4ab:	6a 00                	push   $0x0
 4ad:	ff 75 08             	pushl  0x8(%ebp)
 4b0:	e8 0c 01 00 00       	call   5c1 <open>
 4b5:	83 c4 10             	add    $0x10,%esp
 4b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4bb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4bf:	79 07                	jns    4c8 <stat+0x26>
    return -1;
 4c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4c6:	eb 25                	jmp    4ed <stat+0x4b>
  r = fstat(fd, st);
 4c8:	83 ec 08             	sub    $0x8,%esp
 4cb:	ff 75 0c             	pushl  0xc(%ebp)
 4ce:	ff 75 f4             	pushl  -0xc(%ebp)
 4d1:	e8 03 01 00 00       	call   5d9 <fstat>
 4d6:	83 c4 10             	add    $0x10,%esp
 4d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 4dc:	83 ec 0c             	sub    $0xc,%esp
 4df:	ff 75 f4             	pushl  -0xc(%ebp)
 4e2:	e8 c2 00 00 00       	call   5a9 <close>
 4e7:	83 c4 10             	add    $0x10,%esp
  return r;
 4ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 4ed:	c9                   	leave  
 4ee:	c3                   	ret    

000004ef <atoi>:

int
atoi(const char *s)
{
 4ef:	55                   	push   %ebp
 4f0:	89 e5                	mov    %esp,%ebp
 4f2:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 4f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 4fc:	eb 25                	jmp    523 <atoi+0x34>
    n = n*10 + *s++ - '0';
 4fe:	8b 55 fc             	mov    -0x4(%ebp),%edx
 501:	89 d0                	mov    %edx,%eax
 503:	c1 e0 02             	shl    $0x2,%eax
 506:	01 d0                	add    %edx,%eax
 508:	01 c0                	add    %eax,%eax
 50a:	89 c1                	mov    %eax,%ecx
 50c:	8b 45 08             	mov    0x8(%ebp),%eax
 50f:	8d 50 01             	lea    0x1(%eax),%edx
 512:	89 55 08             	mov    %edx,0x8(%ebp)
 515:	0f b6 00             	movzbl (%eax),%eax
 518:	0f be c0             	movsbl %al,%eax
 51b:	01 c8                	add    %ecx,%eax
 51d:	83 e8 30             	sub    $0x30,%eax
 520:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 523:	8b 45 08             	mov    0x8(%ebp),%eax
 526:	0f b6 00             	movzbl (%eax),%eax
 529:	3c 2f                	cmp    $0x2f,%al
 52b:	7e 0a                	jle    537 <atoi+0x48>
 52d:	8b 45 08             	mov    0x8(%ebp),%eax
 530:	0f b6 00             	movzbl (%eax),%eax
 533:	3c 39                	cmp    $0x39,%al
 535:	7e c7                	jle    4fe <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 537:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 53a:	c9                   	leave  
 53b:	c3                   	ret    

0000053c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 53c:	55                   	push   %ebp
 53d:	89 e5                	mov    %esp,%ebp
 53f:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 542:	8b 45 08             	mov    0x8(%ebp),%eax
 545:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 548:	8b 45 0c             	mov    0xc(%ebp),%eax
 54b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 54e:	eb 17                	jmp    567 <memmove+0x2b>
    *dst++ = *src++;
 550:	8b 45 fc             	mov    -0x4(%ebp),%eax
 553:	8d 50 01             	lea    0x1(%eax),%edx
 556:	89 55 fc             	mov    %edx,-0x4(%ebp)
 559:	8b 55 f8             	mov    -0x8(%ebp),%edx
 55c:	8d 4a 01             	lea    0x1(%edx),%ecx
 55f:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 562:	0f b6 12             	movzbl (%edx),%edx
 565:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 567:	8b 45 10             	mov    0x10(%ebp),%eax
 56a:	8d 50 ff             	lea    -0x1(%eax),%edx
 56d:	89 55 10             	mov    %edx,0x10(%ebp)
 570:	85 c0                	test   %eax,%eax
 572:	7f dc                	jg     550 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 574:	8b 45 08             	mov    0x8(%ebp),%eax
}
 577:	c9                   	leave  
 578:	c3                   	ret    

00000579 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 579:	b8 01 00 00 00       	mov    $0x1,%eax
 57e:	cd 40                	int    $0x40
 580:	c3                   	ret    

00000581 <exit>:
SYSCALL(exit)
 581:	b8 02 00 00 00       	mov    $0x2,%eax
 586:	cd 40                	int    $0x40
 588:	c3                   	ret    

00000589 <wait>:
SYSCALL(wait)
 589:	b8 03 00 00 00       	mov    $0x3,%eax
 58e:	cd 40                	int    $0x40
 590:	c3                   	ret    

00000591 <pipe>:
SYSCALL(pipe)
 591:	b8 04 00 00 00       	mov    $0x4,%eax
 596:	cd 40                	int    $0x40
 598:	c3                   	ret    

00000599 <read>:
SYSCALL(read)
 599:	b8 05 00 00 00       	mov    $0x5,%eax
 59e:	cd 40                	int    $0x40
 5a0:	c3                   	ret    

000005a1 <write>:
SYSCALL(write)
 5a1:	b8 10 00 00 00       	mov    $0x10,%eax
 5a6:	cd 40                	int    $0x40
 5a8:	c3                   	ret    

000005a9 <close>:
SYSCALL(close)
 5a9:	b8 15 00 00 00       	mov    $0x15,%eax
 5ae:	cd 40                	int    $0x40
 5b0:	c3                   	ret    

000005b1 <kill>:
SYSCALL(kill)
 5b1:	b8 06 00 00 00       	mov    $0x6,%eax
 5b6:	cd 40                	int    $0x40
 5b8:	c3                   	ret    

000005b9 <exec>:
SYSCALL(exec)
 5b9:	b8 07 00 00 00       	mov    $0x7,%eax
 5be:	cd 40                	int    $0x40
 5c0:	c3                   	ret    

000005c1 <open>:
SYSCALL(open)
 5c1:	b8 0f 00 00 00       	mov    $0xf,%eax
 5c6:	cd 40                	int    $0x40
 5c8:	c3                   	ret    

000005c9 <mknod>:
SYSCALL(mknod)
 5c9:	b8 11 00 00 00       	mov    $0x11,%eax
 5ce:	cd 40                	int    $0x40
 5d0:	c3                   	ret    

000005d1 <unlink>:
SYSCALL(unlink)
 5d1:	b8 12 00 00 00       	mov    $0x12,%eax
 5d6:	cd 40                	int    $0x40
 5d8:	c3                   	ret    

000005d9 <fstat>:
SYSCALL(fstat)
 5d9:	b8 08 00 00 00       	mov    $0x8,%eax
 5de:	cd 40                	int    $0x40
 5e0:	c3                   	ret    

000005e1 <link>:
SYSCALL(link)
 5e1:	b8 13 00 00 00       	mov    $0x13,%eax
 5e6:	cd 40                	int    $0x40
 5e8:	c3                   	ret    

000005e9 <mkdir>:
SYSCALL(mkdir)
 5e9:	b8 14 00 00 00       	mov    $0x14,%eax
 5ee:	cd 40                	int    $0x40
 5f0:	c3                   	ret    

000005f1 <chdir>:
SYSCALL(chdir)
 5f1:	b8 09 00 00 00       	mov    $0x9,%eax
 5f6:	cd 40                	int    $0x40
 5f8:	c3                   	ret    

000005f9 <dup>:
SYSCALL(dup)
 5f9:	b8 0a 00 00 00       	mov    $0xa,%eax
 5fe:	cd 40                	int    $0x40
 600:	c3                   	ret    

00000601 <getpid>:
SYSCALL(getpid)
 601:	b8 0b 00 00 00       	mov    $0xb,%eax
 606:	cd 40                	int    $0x40
 608:	c3                   	ret    

00000609 <sbrk>:
SYSCALL(sbrk)
 609:	b8 0c 00 00 00       	mov    $0xc,%eax
 60e:	cd 40                	int    $0x40
 610:	c3                   	ret    

00000611 <sleep>:
SYSCALL(sleep)
 611:	b8 0d 00 00 00       	mov    $0xd,%eax
 616:	cd 40                	int    $0x40
 618:	c3                   	ret    

00000619 <uptime>:
SYSCALL(uptime)
 619:	b8 0e 00 00 00       	mov    $0xe,%eax
 61e:	cd 40                	int    $0x40
 620:	c3                   	ret    

00000621 <getcwd>:
SYSCALL(getcwd)
 621:	b8 16 00 00 00       	mov    $0x16,%eax
 626:	cd 40                	int    $0x40
 628:	c3                   	ret    

00000629 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 629:	55                   	push   %ebp
 62a:	89 e5                	mov    %esp,%ebp
 62c:	83 ec 18             	sub    $0x18,%esp
 62f:	8b 45 0c             	mov    0xc(%ebp),%eax
 632:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 635:	83 ec 04             	sub    $0x4,%esp
 638:	6a 01                	push   $0x1
 63a:	8d 45 f4             	lea    -0xc(%ebp),%eax
 63d:	50                   	push   %eax
 63e:	ff 75 08             	pushl  0x8(%ebp)
 641:	e8 5b ff ff ff       	call   5a1 <write>
 646:	83 c4 10             	add    $0x10,%esp
}
 649:	c9                   	leave  
 64a:	c3                   	ret    

0000064b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 64b:	55                   	push   %ebp
 64c:	89 e5                	mov    %esp,%ebp
 64e:	53                   	push   %ebx
 64f:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 652:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 659:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 65d:	74 17                	je     676 <printint+0x2b>
 65f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 663:	79 11                	jns    676 <printint+0x2b>
    neg = 1;
 665:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 66c:	8b 45 0c             	mov    0xc(%ebp),%eax
 66f:	f7 d8                	neg    %eax
 671:	89 45 ec             	mov    %eax,-0x14(%ebp)
 674:	eb 06                	jmp    67c <printint+0x31>
  } else {
    x = xx;
 676:	8b 45 0c             	mov    0xc(%ebp),%eax
 679:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 67c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 683:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 686:	8d 41 01             	lea    0x1(%ecx),%eax
 689:	89 45 f4             	mov    %eax,-0xc(%ebp)
 68c:	8b 5d 10             	mov    0x10(%ebp),%ebx
 68f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 692:	ba 00 00 00 00       	mov    $0x0,%edx
 697:	f7 f3                	div    %ebx
 699:	89 d0                	mov    %edx,%eax
 69b:	0f b6 80 c0 0d 00 00 	movzbl 0xdc0(%eax),%eax
 6a2:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 6a6:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6ac:	ba 00 00 00 00       	mov    $0x0,%edx
 6b1:	f7 f3                	div    %ebx
 6b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6b6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6ba:	75 c7                	jne    683 <printint+0x38>
  if(neg)
 6bc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6c0:	74 0e                	je     6d0 <printint+0x85>
    buf[i++] = '-';
 6c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c5:	8d 50 01             	lea    0x1(%eax),%edx
 6c8:	89 55 f4             	mov    %edx,-0xc(%ebp)
 6cb:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 6d0:	eb 1d                	jmp    6ef <printint+0xa4>
    putc(fd, buf[i]);
 6d2:	8d 55 dc             	lea    -0x24(%ebp),%edx
 6d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6d8:	01 d0                	add    %edx,%eax
 6da:	0f b6 00             	movzbl (%eax),%eax
 6dd:	0f be c0             	movsbl %al,%eax
 6e0:	83 ec 08             	sub    $0x8,%esp
 6e3:	50                   	push   %eax
 6e4:	ff 75 08             	pushl  0x8(%ebp)
 6e7:	e8 3d ff ff ff       	call   629 <putc>
 6ec:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6ef:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 6f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6f7:	79 d9                	jns    6d2 <printint+0x87>
    putc(fd, buf[i]);
}
 6f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6fc:	c9                   	leave  
 6fd:	c3                   	ret    

000006fe <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6fe:	55                   	push   %ebp
 6ff:	89 e5                	mov    %esp,%ebp
 701:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 704:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 70b:	8d 45 0c             	lea    0xc(%ebp),%eax
 70e:	83 c0 04             	add    $0x4,%eax
 711:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 714:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 71b:	e9 59 01 00 00       	jmp    879 <printf+0x17b>
    c = fmt[i] & 0xff;
 720:	8b 55 0c             	mov    0xc(%ebp),%edx
 723:	8b 45 f0             	mov    -0x10(%ebp),%eax
 726:	01 d0                	add    %edx,%eax
 728:	0f b6 00             	movzbl (%eax),%eax
 72b:	0f be c0             	movsbl %al,%eax
 72e:	25 ff 00 00 00       	and    $0xff,%eax
 733:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 736:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 73a:	75 2c                	jne    768 <printf+0x6a>
      if(c == '%'){
 73c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 740:	75 0c                	jne    74e <printf+0x50>
        state = '%';
 742:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 749:	e9 27 01 00 00       	jmp    875 <printf+0x177>
      } else {
        putc(fd, c);
 74e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 751:	0f be c0             	movsbl %al,%eax
 754:	83 ec 08             	sub    $0x8,%esp
 757:	50                   	push   %eax
 758:	ff 75 08             	pushl  0x8(%ebp)
 75b:	e8 c9 fe ff ff       	call   629 <putc>
 760:	83 c4 10             	add    $0x10,%esp
 763:	e9 0d 01 00 00       	jmp    875 <printf+0x177>
      }
    } else if(state == '%'){
 768:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 76c:	0f 85 03 01 00 00    	jne    875 <printf+0x177>
      if(c == 'd'){
 772:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 776:	75 1e                	jne    796 <printf+0x98>
        printint(fd, *ap, 10, 1);
 778:	8b 45 e8             	mov    -0x18(%ebp),%eax
 77b:	8b 00                	mov    (%eax),%eax
 77d:	6a 01                	push   $0x1
 77f:	6a 0a                	push   $0xa
 781:	50                   	push   %eax
 782:	ff 75 08             	pushl  0x8(%ebp)
 785:	e8 c1 fe ff ff       	call   64b <printint>
 78a:	83 c4 10             	add    $0x10,%esp
        ap++;
 78d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 791:	e9 d8 00 00 00       	jmp    86e <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 796:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 79a:	74 06                	je     7a2 <printf+0xa4>
 79c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 7a0:	75 1e                	jne    7c0 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 7a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7a5:	8b 00                	mov    (%eax),%eax
 7a7:	6a 00                	push   $0x0
 7a9:	6a 10                	push   $0x10
 7ab:	50                   	push   %eax
 7ac:	ff 75 08             	pushl  0x8(%ebp)
 7af:	e8 97 fe ff ff       	call   64b <printint>
 7b4:	83 c4 10             	add    $0x10,%esp
        ap++;
 7b7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7bb:	e9 ae 00 00 00       	jmp    86e <printf+0x170>
      } else if(c == 's'){
 7c0:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 7c4:	75 43                	jne    809 <printf+0x10b>
        s = (char*)*ap;
 7c6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7c9:	8b 00                	mov    (%eax),%eax
 7cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 7ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 7d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7d6:	75 07                	jne    7df <printf+0xe1>
          s = "(null)";
 7d8:	c7 45 f4 ea 0a 00 00 	movl   $0xaea,-0xc(%ebp)
        while(*s != 0){
 7df:	eb 1c                	jmp    7fd <printf+0xff>
          putc(fd, *s);
 7e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e4:	0f b6 00             	movzbl (%eax),%eax
 7e7:	0f be c0             	movsbl %al,%eax
 7ea:	83 ec 08             	sub    $0x8,%esp
 7ed:	50                   	push   %eax
 7ee:	ff 75 08             	pushl  0x8(%ebp)
 7f1:	e8 33 fe ff ff       	call   629 <putc>
 7f6:	83 c4 10             	add    $0x10,%esp
          s++;
 7f9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 800:	0f b6 00             	movzbl (%eax),%eax
 803:	84 c0                	test   %al,%al
 805:	75 da                	jne    7e1 <printf+0xe3>
 807:	eb 65                	jmp    86e <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 809:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 80d:	75 1d                	jne    82c <printf+0x12e>
        putc(fd, *ap);
 80f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 812:	8b 00                	mov    (%eax),%eax
 814:	0f be c0             	movsbl %al,%eax
 817:	83 ec 08             	sub    $0x8,%esp
 81a:	50                   	push   %eax
 81b:	ff 75 08             	pushl  0x8(%ebp)
 81e:	e8 06 fe ff ff       	call   629 <putc>
 823:	83 c4 10             	add    $0x10,%esp
        ap++;
 826:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 82a:	eb 42                	jmp    86e <printf+0x170>
      } else if(c == '%'){
 82c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 830:	75 17                	jne    849 <printf+0x14b>
        putc(fd, c);
 832:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 835:	0f be c0             	movsbl %al,%eax
 838:	83 ec 08             	sub    $0x8,%esp
 83b:	50                   	push   %eax
 83c:	ff 75 08             	pushl  0x8(%ebp)
 83f:	e8 e5 fd ff ff       	call   629 <putc>
 844:	83 c4 10             	add    $0x10,%esp
 847:	eb 25                	jmp    86e <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 849:	83 ec 08             	sub    $0x8,%esp
 84c:	6a 25                	push   $0x25
 84e:	ff 75 08             	pushl  0x8(%ebp)
 851:	e8 d3 fd ff ff       	call   629 <putc>
 856:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 859:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 85c:	0f be c0             	movsbl %al,%eax
 85f:	83 ec 08             	sub    $0x8,%esp
 862:	50                   	push   %eax
 863:	ff 75 08             	pushl  0x8(%ebp)
 866:	e8 be fd ff ff       	call   629 <putc>
 86b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 86e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 875:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 879:	8b 55 0c             	mov    0xc(%ebp),%edx
 87c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 87f:	01 d0                	add    %edx,%eax
 881:	0f b6 00             	movzbl (%eax),%eax
 884:	84 c0                	test   %al,%al
 886:	0f 85 94 fe ff ff    	jne    720 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 88c:	c9                   	leave  
 88d:	c3                   	ret    

0000088e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 88e:	55                   	push   %ebp
 88f:	89 e5                	mov    %esp,%ebp
 891:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 894:	8b 45 08             	mov    0x8(%ebp),%eax
 897:	83 e8 08             	sub    $0x8,%eax
 89a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89d:	a1 08 0e 00 00       	mov    0xe08,%eax
 8a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8a5:	eb 24                	jmp    8cb <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8aa:	8b 00                	mov    (%eax),%eax
 8ac:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8af:	77 12                	ja     8c3 <free+0x35>
 8b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8b4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8b7:	77 24                	ja     8dd <free+0x4f>
 8b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8bc:	8b 00                	mov    (%eax),%eax
 8be:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8c1:	77 1a                	ja     8dd <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c6:	8b 00                	mov    (%eax),%eax
 8c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ce:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8d1:	76 d4                	jbe    8a7 <free+0x19>
 8d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d6:	8b 00                	mov    (%eax),%eax
 8d8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8db:	76 ca                	jbe    8a7 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 8dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8e0:	8b 40 04             	mov    0x4(%eax),%eax
 8e3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ed:	01 c2                	add    %eax,%edx
 8ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f2:	8b 00                	mov    (%eax),%eax
 8f4:	39 c2                	cmp    %eax,%edx
 8f6:	75 24                	jne    91c <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 8f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8fb:	8b 50 04             	mov    0x4(%eax),%edx
 8fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
 901:	8b 00                	mov    (%eax),%eax
 903:	8b 40 04             	mov    0x4(%eax),%eax
 906:	01 c2                	add    %eax,%edx
 908:	8b 45 f8             	mov    -0x8(%ebp),%eax
 90b:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 90e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 911:	8b 00                	mov    (%eax),%eax
 913:	8b 10                	mov    (%eax),%edx
 915:	8b 45 f8             	mov    -0x8(%ebp),%eax
 918:	89 10                	mov    %edx,(%eax)
 91a:	eb 0a                	jmp    926 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 91c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 91f:	8b 10                	mov    (%eax),%edx
 921:	8b 45 f8             	mov    -0x8(%ebp),%eax
 924:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 926:	8b 45 fc             	mov    -0x4(%ebp),%eax
 929:	8b 40 04             	mov    0x4(%eax),%eax
 92c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 933:	8b 45 fc             	mov    -0x4(%ebp),%eax
 936:	01 d0                	add    %edx,%eax
 938:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 93b:	75 20                	jne    95d <free+0xcf>
    p->s.size += bp->s.size;
 93d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 940:	8b 50 04             	mov    0x4(%eax),%edx
 943:	8b 45 f8             	mov    -0x8(%ebp),%eax
 946:	8b 40 04             	mov    0x4(%eax),%eax
 949:	01 c2                	add    %eax,%edx
 94b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 94e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 951:	8b 45 f8             	mov    -0x8(%ebp),%eax
 954:	8b 10                	mov    (%eax),%edx
 956:	8b 45 fc             	mov    -0x4(%ebp),%eax
 959:	89 10                	mov    %edx,(%eax)
 95b:	eb 08                	jmp    965 <free+0xd7>
  } else
    p->s.ptr = bp;
 95d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 960:	8b 55 f8             	mov    -0x8(%ebp),%edx
 963:	89 10                	mov    %edx,(%eax)
  freep = p;
 965:	8b 45 fc             	mov    -0x4(%ebp),%eax
 968:	a3 08 0e 00 00       	mov    %eax,0xe08
}
 96d:	c9                   	leave  
 96e:	c3                   	ret    

0000096f <morecore>:

static Header*
morecore(uint nu)
{
 96f:	55                   	push   %ebp
 970:	89 e5                	mov    %esp,%ebp
 972:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 975:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 97c:	77 07                	ja     985 <morecore+0x16>
    nu = 4096;
 97e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 985:	8b 45 08             	mov    0x8(%ebp),%eax
 988:	c1 e0 03             	shl    $0x3,%eax
 98b:	83 ec 0c             	sub    $0xc,%esp
 98e:	50                   	push   %eax
 98f:	e8 75 fc ff ff       	call   609 <sbrk>
 994:	83 c4 10             	add    $0x10,%esp
 997:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 99a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 99e:	75 07                	jne    9a7 <morecore+0x38>
    return 0;
 9a0:	b8 00 00 00 00       	mov    $0x0,%eax
 9a5:	eb 26                	jmp    9cd <morecore+0x5e>
  hp = (Header*)p;
 9a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 9ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9b0:	8b 55 08             	mov    0x8(%ebp),%edx
 9b3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 9b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9b9:	83 c0 08             	add    $0x8,%eax
 9bc:	83 ec 0c             	sub    $0xc,%esp
 9bf:	50                   	push   %eax
 9c0:	e8 c9 fe ff ff       	call   88e <free>
 9c5:	83 c4 10             	add    $0x10,%esp
  return freep;
 9c8:	a1 08 0e 00 00       	mov    0xe08,%eax
}
 9cd:	c9                   	leave  
 9ce:	c3                   	ret    

000009cf <malloc>:

void*
malloc(uint nbytes)
{
 9cf:	55                   	push   %ebp
 9d0:	89 e5                	mov    %esp,%ebp
 9d2:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d5:	8b 45 08             	mov    0x8(%ebp),%eax
 9d8:	83 c0 07             	add    $0x7,%eax
 9db:	c1 e8 03             	shr    $0x3,%eax
 9de:	83 c0 01             	add    $0x1,%eax
 9e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 9e4:	a1 08 0e 00 00       	mov    0xe08,%eax
 9e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9f0:	75 23                	jne    a15 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 9f2:	c7 45 f0 00 0e 00 00 	movl   $0xe00,-0x10(%ebp)
 9f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9fc:	a3 08 0e 00 00       	mov    %eax,0xe08
 a01:	a1 08 0e 00 00       	mov    0xe08,%eax
 a06:	a3 00 0e 00 00       	mov    %eax,0xe00
    base.s.size = 0;
 a0b:	c7 05 04 0e 00 00 00 	movl   $0x0,0xe04
 a12:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a15:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a18:	8b 00                	mov    (%eax),%eax
 a1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a20:	8b 40 04             	mov    0x4(%eax),%eax
 a23:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a26:	72 4d                	jb     a75 <malloc+0xa6>
      if(p->s.size == nunits)
 a28:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a2b:	8b 40 04             	mov    0x4(%eax),%eax
 a2e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a31:	75 0c                	jne    a3f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 a33:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a36:	8b 10                	mov    (%eax),%edx
 a38:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a3b:	89 10                	mov    %edx,(%eax)
 a3d:	eb 26                	jmp    a65 <malloc+0x96>
      else {
        p->s.size -= nunits;
 a3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a42:	8b 40 04             	mov    0x4(%eax),%eax
 a45:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a48:	89 c2                	mov    %eax,%edx
 a4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a4d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a50:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a53:	8b 40 04             	mov    0x4(%eax),%eax
 a56:	c1 e0 03             	shl    $0x3,%eax
 a59:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a5f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a62:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a65:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a68:	a3 08 0e 00 00       	mov    %eax,0xe08
      return (void*)(p + 1);
 a6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a70:	83 c0 08             	add    $0x8,%eax
 a73:	eb 3b                	jmp    ab0 <malloc+0xe1>
    }
    if(p == freep)
 a75:	a1 08 0e 00 00       	mov    0xe08,%eax
 a7a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a7d:	75 1e                	jne    a9d <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 a7f:	83 ec 0c             	sub    $0xc,%esp
 a82:	ff 75 ec             	pushl  -0x14(%ebp)
 a85:	e8 e5 fe ff ff       	call   96f <morecore>
 a8a:	83 c4 10             	add    $0x10,%esp
 a8d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a90:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a94:	75 07                	jne    a9d <malloc+0xce>
        return 0;
 a96:	b8 00 00 00 00       	mov    $0x0,%eax
 a9b:	eb 13                	jmp    ab0 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aa0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 aa3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aa6:	8b 00                	mov    (%eax),%eax
 aa8:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 aab:	e9 6d ff ff ff       	jmp    a1d <malloc+0x4e>
}
 ab0:	c9                   	leave  
 ab1:	c3                   	ret    
