
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <opentest>:

// simple file system tests

void
opentest(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
       6:	a1 74 5e 00 00       	mov    0x5e74,%eax
       b:	83 ec 08             	sub    $0x8,%esp
       e:	68 36 41 00 00       	push   $0x4136
      13:	50                   	push   %eax
      14:	e8 50 3d 00 00       	call   3d69 <printf>
      19:	83 c4 10             	add    $0x10,%esp
  fd = open("echo", 0);
      1c:	83 ec 08             	sub    $0x8,%esp
      1f:	6a 00                	push   $0x0
      21:	68 20 41 00 00       	push   $0x4120
      26:	e8 01 3c 00 00       	call   3c2c <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
      31:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      35:	79 1b                	jns    52 <opentest+0x52>
    printf(stdout, "open echo failed!\n");
      37:	a1 74 5e 00 00       	mov    0x5e74,%eax
      3c:	83 ec 08             	sub    $0x8,%esp
      3f:	68 41 41 00 00       	push   $0x4141
      44:	50                   	push   %eax
      45:	e8 1f 3d 00 00       	call   3d69 <printf>
      4a:	83 c4 10             	add    $0x10,%esp
    exit();
      4d:	e8 9a 3b 00 00       	call   3bec <exit>
  }
  close(fd);
      52:	83 ec 0c             	sub    $0xc,%esp
      55:	ff 75 f4             	pushl  -0xc(%ebp)
      58:	e8 b7 3b 00 00       	call   3c14 <close>
      5d:	83 c4 10             	add    $0x10,%esp
  fd = open("doesnotexist", 0);
      60:	83 ec 08             	sub    $0x8,%esp
      63:	6a 00                	push   $0x0
      65:	68 54 41 00 00       	push   $0x4154
      6a:	e8 bd 3b 00 00       	call   3c2c <open>
      6f:	83 c4 10             	add    $0x10,%esp
      72:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
      75:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      79:	78 1b                	js     96 <opentest+0x96>
    printf(stdout, "open doesnotexist succeeded!\n");
      7b:	a1 74 5e 00 00       	mov    0x5e74,%eax
      80:	83 ec 08             	sub    $0x8,%esp
      83:	68 61 41 00 00       	push   $0x4161
      88:	50                   	push   %eax
      89:	e8 db 3c 00 00       	call   3d69 <printf>
      8e:	83 c4 10             	add    $0x10,%esp
    exit();
      91:	e8 56 3b 00 00       	call   3bec <exit>
  }
  printf(stdout, "open test ok\n");
      96:	a1 74 5e 00 00       	mov    0x5e74,%eax
      9b:	83 ec 08             	sub    $0x8,%esp
      9e:	68 7f 41 00 00       	push   $0x417f
      a3:	50                   	push   %eax
      a4:	e8 c0 3c 00 00       	call   3d69 <printf>
      a9:	83 c4 10             	add    $0x10,%esp
}
      ac:	c9                   	leave  
      ad:	c3                   	ret    

000000ae <writetest>:

void
writetest(void)
{
      ae:	55                   	push   %ebp
      af:	89 e5                	mov    %esp,%ebp
      b1:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
      b4:	a1 74 5e 00 00       	mov    0x5e74,%eax
      b9:	83 ec 08             	sub    $0x8,%esp
      bc:	68 8d 41 00 00       	push   $0x418d
      c1:	50                   	push   %eax
      c2:	e8 a2 3c 00 00       	call   3d69 <printf>
      c7:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_CREATE|O_RDWR);
      ca:	83 ec 08             	sub    $0x8,%esp
      cd:	68 02 02 00 00       	push   $0x202
      d2:	68 9e 41 00 00       	push   $0x419e
      d7:	e8 50 3b 00 00       	call   3c2c <open>
      dc:	83 c4 10             	add    $0x10,%esp
      df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
      e2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      e6:	78 22                	js     10a <writetest+0x5c>
    printf(stdout, "creat small succeeded; ok\n");
      e8:	a1 74 5e 00 00       	mov    0x5e74,%eax
      ed:	83 ec 08             	sub    $0x8,%esp
      f0:	68 a4 41 00 00       	push   $0x41a4
      f5:	50                   	push   %eax
      f6:	e8 6e 3c 00 00       	call   3d69 <printf>
      fb:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
      fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     105:	e9 8f 00 00 00       	jmp    199 <writetest+0xeb>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
     10a:	a1 74 5e 00 00       	mov    0x5e74,%eax
     10f:	83 ec 08             	sub    $0x8,%esp
     112:	68 bf 41 00 00       	push   $0x41bf
     117:	50                   	push   %eax
     118:	e8 4c 3c 00 00       	call   3d69 <printf>
     11d:	83 c4 10             	add    $0x10,%esp
    exit();
     120:	e8 c7 3a 00 00       	call   3bec <exit>
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     125:	83 ec 04             	sub    $0x4,%esp
     128:	6a 0a                	push   $0xa
     12a:	68 db 41 00 00       	push   $0x41db
     12f:	ff 75 f0             	pushl  -0x10(%ebp)
     132:	e8 d5 3a 00 00       	call   3c0c <write>
     137:	83 c4 10             	add    $0x10,%esp
     13a:	83 f8 0a             	cmp    $0xa,%eax
     13d:	74 1e                	je     15d <writetest+0xaf>
      printf(stdout, "error: write aa %d new file failed\n", i);
     13f:	a1 74 5e 00 00       	mov    0x5e74,%eax
     144:	83 ec 04             	sub    $0x4,%esp
     147:	ff 75 f4             	pushl  -0xc(%ebp)
     14a:	68 e8 41 00 00       	push   $0x41e8
     14f:	50                   	push   %eax
     150:	e8 14 3c 00 00       	call   3d69 <printf>
     155:	83 c4 10             	add    $0x10,%esp
      exit();
     158:	e8 8f 3a 00 00       	call   3bec <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     15d:	83 ec 04             	sub    $0x4,%esp
     160:	6a 0a                	push   $0xa
     162:	68 0c 42 00 00       	push   $0x420c
     167:	ff 75 f0             	pushl  -0x10(%ebp)
     16a:	e8 9d 3a 00 00       	call   3c0c <write>
     16f:	83 c4 10             	add    $0x10,%esp
     172:	83 f8 0a             	cmp    $0xa,%eax
     175:	74 1e                	je     195 <writetest+0xe7>
      printf(stdout, "error: write bb %d new file failed\n", i);
     177:	a1 74 5e 00 00       	mov    0x5e74,%eax
     17c:	83 ec 04             	sub    $0x4,%esp
     17f:	ff 75 f4             	pushl  -0xc(%ebp)
     182:	68 18 42 00 00       	push   $0x4218
     187:	50                   	push   %eax
     188:	e8 dc 3b 00 00       	call   3d69 <printf>
     18d:	83 c4 10             	add    $0x10,%esp
      exit();
     190:	e8 57 3a 00 00       	call   3bec <exit>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     195:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     199:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     19d:	7e 86                	jle    125 <writetest+0x77>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
     19f:	a1 74 5e 00 00       	mov    0x5e74,%eax
     1a4:	83 ec 08             	sub    $0x8,%esp
     1a7:	68 3c 42 00 00       	push   $0x423c
     1ac:	50                   	push   %eax
     1ad:	e8 b7 3b 00 00       	call   3d69 <printf>
     1b2:	83 c4 10             	add    $0x10,%esp
  close(fd);
     1b5:	83 ec 0c             	sub    $0xc,%esp
     1b8:	ff 75 f0             	pushl  -0x10(%ebp)
     1bb:	e8 54 3a 00 00       	call   3c14 <close>
     1c0:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     1c3:	83 ec 08             	sub    $0x8,%esp
     1c6:	6a 00                	push   $0x0
     1c8:	68 9e 41 00 00       	push   $0x419e
     1cd:	e8 5a 3a 00 00       	call   3c2c <open>
     1d2:	83 c4 10             	add    $0x10,%esp
     1d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     1d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1dc:	78 3c                	js     21a <writetest+0x16c>
    printf(stdout, "open small succeeded ok\n");
     1de:	a1 74 5e 00 00       	mov    0x5e74,%eax
     1e3:	83 ec 08             	sub    $0x8,%esp
     1e6:	68 47 42 00 00       	push   $0x4247
     1eb:	50                   	push   %eax
     1ec:	e8 78 3b 00 00       	call   3d69 <printf>
     1f1:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     1f4:	83 ec 04             	sub    $0x4,%esp
     1f7:	68 d0 07 00 00       	push   $0x7d0
     1fc:	68 c0 86 00 00       	push   $0x86c0
     201:	ff 75 f0             	pushl  -0x10(%ebp)
     204:	e8 fb 39 00 00       	call   3c04 <read>
     209:	83 c4 10             	add    $0x10,%esp
     20c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(i == 2000){
     20f:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
     216:	75 57                	jne    26f <writetest+0x1c1>
     218:	eb 1b                	jmp    235 <writetest+0x187>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
     21a:	a1 74 5e 00 00       	mov    0x5e74,%eax
     21f:	83 ec 08             	sub    $0x8,%esp
     222:	68 60 42 00 00       	push   $0x4260
     227:	50                   	push   %eax
     228:	e8 3c 3b 00 00       	call   3d69 <printf>
     22d:	83 c4 10             	add    $0x10,%esp
    exit();
     230:	e8 b7 39 00 00       	call   3bec <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
     235:	a1 74 5e 00 00       	mov    0x5e74,%eax
     23a:	83 ec 08             	sub    $0x8,%esp
     23d:	68 7b 42 00 00       	push   $0x427b
     242:	50                   	push   %eax
     243:	e8 21 3b 00 00       	call   3d69 <printf>
     248:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     24b:	83 ec 0c             	sub    $0xc,%esp
     24e:	ff 75 f0             	pushl  -0x10(%ebp)
     251:	e8 be 39 00 00       	call   3c14 <close>
     256:	83 c4 10             	add    $0x10,%esp

  if(unlink("small") < 0){
     259:	83 ec 0c             	sub    $0xc,%esp
     25c:	68 9e 41 00 00       	push   $0x419e
     261:	e8 d6 39 00 00       	call   3c3c <unlink>
     266:	83 c4 10             	add    $0x10,%esp
     269:	85 c0                	test   %eax,%eax
     26b:	79 38                	jns    2a5 <writetest+0x1f7>
     26d:	eb 1b                	jmp    28a <writetest+0x1dc>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
     26f:	a1 74 5e 00 00       	mov    0x5e74,%eax
     274:	83 ec 08             	sub    $0x8,%esp
     277:	68 8e 42 00 00       	push   $0x428e
     27c:	50                   	push   %eax
     27d:	e8 e7 3a 00 00       	call   3d69 <printf>
     282:	83 c4 10             	add    $0x10,%esp
    exit();
     285:	e8 62 39 00 00       	call   3bec <exit>
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
     28a:	a1 74 5e 00 00       	mov    0x5e74,%eax
     28f:	83 ec 08             	sub    $0x8,%esp
     292:	68 9b 42 00 00       	push   $0x429b
     297:	50                   	push   %eax
     298:	e8 cc 3a 00 00       	call   3d69 <printf>
     29d:	83 c4 10             	add    $0x10,%esp
    exit();
     2a0:	e8 47 39 00 00       	call   3bec <exit>
  }
  printf(stdout, "small file test ok\n");
     2a5:	a1 74 5e 00 00       	mov    0x5e74,%eax
     2aa:	83 ec 08             	sub    $0x8,%esp
     2ad:	68 b0 42 00 00       	push   $0x42b0
     2b2:	50                   	push   %eax
     2b3:	e8 b1 3a 00 00       	call   3d69 <printf>
     2b8:	83 c4 10             	add    $0x10,%esp
}
     2bb:	c9                   	leave  
     2bc:	c3                   	ret    

000002bd <writetest1>:

void
writetest1(void)
{
     2bd:	55                   	push   %ebp
     2be:	89 e5                	mov    %esp,%ebp
     2c0:	83 ec 18             	sub    $0x18,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
     2c3:	a1 74 5e 00 00       	mov    0x5e74,%eax
     2c8:	83 ec 08             	sub    $0x8,%esp
     2cb:	68 c4 42 00 00       	push   $0x42c4
     2d0:	50                   	push   %eax
     2d1:	e8 93 3a 00 00       	call   3d69 <printf>
     2d6:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_CREATE|O_RDWR);
     2d9:	83 ec 08             	sub    $0x8,%esp
     2dc:	68 02 02 00 00       	push   $0x202
     2e1:	68 d4 42 00 00       	push   $0x42d4
     2e6:	e8 41 39 00 00       	call   3c2c <open>
     2eb:	83 c4 10             	add    $0x10,%esp
     2ee:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     2f1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     2f5:	79 1b                	jns    312 <writetest1+0x55>
    printf(stdout, "error: creat big failed!\n");
     2f7:	a1 74 5e 00 00       	mov    0x5e74,%eax
     2fc:	83 ec 08             	sub    $0x8,%esp
     2ff:	68 d8 42 00 00       	push   $0x42d8
     304:	50                   	push   %eax
     305:	e8 5f 3a 00 00       	call   3d69 <printf>
     30a:	83 c4 10             	add    $0x10,%esp
    exit();
     30d:	e8 da 38 00 00       	call   3bec <exit>
  }

  for(i = 0; i < MAXFILE; i++){
     312:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     319:	eb 4b                	jmp    366 <writetest1+0xa9>
    ((int*)buf)[0] = i;
     31b:	ba c0 86 00 00       	mov    $0x86c0,%edx
     320:	8b 45 f4             	mov    -0xc(%ebp),%eax
     323:	89 02                	mov    %eax,(%edx)
    if(write(fd, buf, 512) != 512){
     325:	83 ec 04             	sub    $0x4,%esp
     328:	68 00 02 00 00       	push   $0x200
     32d:	68 c0 86 00 00       	push   $0x86c0
     332:	ff 75 ec             	pushl  -0x14(%ebp)
     335:	e8 d2 38 00 00       	call   3c0c <write>
     33a:	83 c4 10             	add    $0x10,%esp
     33d:	3d 00 02 00 00       	cmp    $0x200,%eax
     342:	74 1e                	je     362 <writetest1+0xa5>
      printf(stdout, "error: write big file failed\n", i);
     344:	a1 74 5e 00 00       	mov    0x5e74,%eax
     349:	83 ec 04             	sub    $0x4,%esp
     34c:	ff 75 f4             	pushl  -0xc(%ebp)
     34f:	68 f2 42 00 00       	push   $0x42f2
     354:	50                   	push   %eax
     355:	e8 0f 3a 00 00       	call   3d69 <printf>
     35a:	83 c4 10             	add    $0x10,%esp
      exit();
     35d:	e8 8a 38 00 00       	call   3bec <exit>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
     362:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     366:	8b 45 f4             	mov    -0xc(%ebp),%eax
     369:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     36e:	76 ab                	jbe    31b <writetest1+0x5e>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
     370:	83 ec 0c             	sub    $0xc,%esp
     373:	ff 75 ec             	pushl  -0x14(%ebp)
     376:	e8 99 38 00 00       	call   3c14 <close>
     37b:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_RDONLY);
     37e:	83 ec 08             	sub    $0x8,%esp
     381:	6a 00                	push   $0x0
     383:	68 d4 42 00 00       	push   $0x42d4
     388:	e8 9f 38 00 00       	call   3c2c <open>
     38d:	83 c4 10             	add    $0x10,%esp
     390:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     393:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     397:	79 1b                	jns    3b4 <writetest1+0xf7>
    printf(stdout, "error: open big failed!\n");
     399:	a1 74 5e 00 00       	mov    0x5e74,%eax
     39e:	83 ec 08             	sub    $0x8,%esp
     3a1:	68 10 43 00 00       	push   $0x4310
     3a6:	50                   	push   %eax
     3a7:	e8 bd 39 00 00       	call   3d69 <printf>
     3ac:	83 c4 10             	add    $0x10,%esp
    exit();
     3af:	e8 38 38 00 00       	call   3bec <exit>
  }

  n = 0;
     3b4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(;;){
    i = read(fd, buf, 512);
     3bb:	83 ec 04             	sub    $0x4,%esp
     3be:	68 00 02 00 00       	push   $0x200
     3c3:	68 c0 86 00 00       	push   $0x86c0
     3c8:	ff 75 ec             	pushl  -0x14(%ebp)
     3cb:	e8 34 38 00 00       	call   3c04 <read>
     3d0:	83 c4 10             	add    $0x10,%esp
     3d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(i == 0){
     3d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3da:	75 4c                	jne    428 <writetest1+0x16b>
      if(n == MAXFILE - 1){
     3dc:	81 7d f0 8b 00 00 00 	cmpl   $0x8b,-0x10(%ebp)
     3e3:	75 1e                	jne    403 <writetest1+0x146>
        printf(stdout, "read only %d blocks from big", n);
     3e5:	a1 74 5e 00 00       	mov    0x5e74,%eax
     3ea:	83 ec 04             	sub    $0x4,%esp
     3ed:	ff 75 f0             	pushl  -0x10(%ebp)
     3f0:	68 29 43 00 00       	push   $0x4329
     3f5:	50                   	push   %eax
     3f6:	e8 6e 39 00 00       	call   3d69 <printf>
     3fb:	83 c4 10             	add    $0x10,%esp
        exit();
     3fe:	e8 e9 37 00 00       	call   3bec <exit>
      }
      break;
     403:	90                   	nop
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
     404:	83 ec 0c             	sub    $0xc,%esp
     407:	ff 75 ec             	pushl  -0x14(%ebp)
     40a:	e8 05 38 00 00       	call   3c14 <close>
     40f:	83 c4 10             	add    $0x10,%esp
  if(unlink("big") < 0){
     412:	83 ec 0c             	sub    $0xc,%esp
     415:	68 d4 42 00 00       	push   $0x42d4
     41a:	e8 1d 38 00 00       	call   3c3c <unlink>
     41f:	83 c4 10             	add    $0x10,%esp
     422:	85 c0                	test   %eax,%eax
     424:	79 7c                	jns    4a2 <writetest1+0x1e5>
     426:	eb 5f                	jmp    487 <writetest1+0x1ca>
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
     428:	81 7d f4 00 02 00 00 	cmpl   $0x200,-0xc(%ebp)
     42f:	74 1e                	je     44f <writetest1+0x192>
      printf(stdout, "read failed %d\n", i);
     431:	a1 74 5e 00 00       	mov    0x5e74,%eax
     436:	83 ec 04             	sub    $0x4,%esp
     439:	ff 75 f4             	pushl  -0xc(%ebp)
     43c:	68 46 43 00 00       	push   $0x4346
     441:	50                   	push   %eax
     442:	e8 22 39 00 00       	call   3d69 <printf>
     447:	83 c4 10             	add    $0x10,%esp
      exit();
     44a:	e8 9d 37 00 00       	call   3bec <exit>
    }
    if(((int*)buf)[0] != n){
     44f:	b8 c0 86 00 00       	mov    $0x86c0,%eax
     454:	8b 00                	mov    (%eax),%eax
     456:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     459:	74 23                	je     47e <writetest1+0x1c1>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
     45b:	b8 c0 86 00 00       	mov    $0x86c0,%eax
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
     460:	8b 10                	mov    (%eax),%edx
     462:	a1 74 5e 00 00       	mov    0x5e74,%eax
     467:	52                   	push   %edx
     468:	ff 75 f0             	pushl  -0x10(%ebp)
     46b:	68 58 43 00 00       	push   $0x4358
     470:	50                   	push   %eax
     471:	e8 f3 38 00 00       	call   3d69 <printf>
     476:	83 c4 10             	add    $0x10,%esp
             n, ((int*)buf)[0]);
      exit();
     479:	e8 6e 37 00 00       	call   3bec <exit>
    }
    n++;
     47e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  }
     482:	e9 34 ff ff ff       	jmp    3bb <writetest1+0xfe>
  close(fd);
  if(unlink("big") < 0){
    printf(stdout, "unlink big failed\n");
     487:	a1 74 5e 00 00       	mov    0x5e74,%eax
     48c:	83 ec 08             	sub    $0x8,%esp
     48f:	68 78 43 00 00       	push   $0x4378
     494:	50                   	push   %eax
     495:	e8 cf 38 00 00       	call   3d69 <printf>
     49a:	83 c4 10             	add    $0x10,%esp
    exit();
     49d:	e8 4a 37 00 00       	call   3bec <exit>
  }
  printf(stdout, "big files ok\n");
     4a2:	a1 74 5e 00 00       	mov    0x5e74,%eax
     4a7:	83 ec 08             	sub    $0x8,%esp
     4aa:	68 8b 43 00 00       	push   $0x438b
     4af:	50                   	push   %eax
     4b0:	e8 b4 38 00 00       	call   3d69 <printf>
     4b5:	83 c4 10             	add    $0x10,%esp
}
     4b8:	c9                   	leave  
     4b9:	c3                   	ret    

000004ba <createtest>:

void
createtest(void)
{
     4ba:	55                   	push   %ebp
     4bb:	89 e5                	mov    %esp,%ebp
     4bd:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     4c0:	a1 74 5e 00 00       	mov    0x5e74,%eax
     4c5:	83 ec 08             	sub    $0x8,%esp
     4c8:	68 9c 43 00 00       	push   $0x439c
     4cd:	50                   	push   %eax
     4ce:	e8 96 38 00 00       	call   3d69 <printf>
     4d3:	83 c4 10             	add    $0x10,%esp

  name[0] = 'a';
     4d6:	c6 05 c0 a6 00 00 61 	movb   $0x61,0xa6c0
  name[2] = '\0';
     4dd:	c6 05 c2 a6 00 00 00 	movb   $0x0,0xa6c2
  for(i = 0; i < 52; i++){
     4e4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4eb:	eb 35                	jmp    522 <createtest+0x68>
    name[1] = '0' + i;
     4ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f0:	83 c0 30             	add    $0x30,%eax
     4f3:	a2 c1 a6 00 00       	mov    %al,0xa6c1
    fd = open(name, O_CREATE|O_RDWR);
     4f8:	83 ec 08             	sub    $0x8,%esp
     4fb:	68 02 02 00 00       	push   $0x202
     500:	68 c0 a6 00 00       	push   $0xa6c0
     505:	e8 22 37 00 00       	call   3c2c <open>
     50a:	83 c4 10             	add    $0x10,%esp
     50d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     510:	83 ec 0c             	sub    $0xc,%esp
     513:	ff 75 f0             	pushl  -0x10(%ebp)
     516:	e8 f9 36 00 00       	call   3c14 <close>
     51b:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     51e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     522:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     526:	7e c5                	jle    4ed <createtest+0x33>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     528:	c6 05 c0 a6 00 00 61 	movb   $0x61,0xa6c0
  name[2] = '\0';
     52f:	c6 05 c2 a6 00 00 00 	movb   $0x0,0xa6c2
  for(i = 0; i < 52; i++){
     536:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     53d:	eb 1f                	jmp    55e <createtest+0xa4>
    name[1] = '0' + i;
     53f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     542:	83 c0 30             	add    $0x30,%eax
     545:	a2 c1 a6 00 00       	mov    %al,0xa6c1
    unlink(name);
     54a:	83 ec 0c             	sub    $0xc,%esp
     54d:	68 c0 a6 00 00       	push   $0xa6c0
     552:	e8 e5 36 00 00       	call   3c3c <unlink>
     557:	83 c4 10             	add    $0x10,%esp
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     55a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     55e:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     562:	7e db                	jle    53f <createtest+0x85>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     564:	a1 74 5e 00 00       	mov    0x5e74,%eax
     569:	83 ec 08             	sub    $0x8,%esp
     56c:	68 c4 43 00 00       	push   $0x43c4
     571:	50                   	push   %eax
     572:	e8 f2 37 00 00       	call   3d69 <printf>
     577:	83 c4 10             	add    $0x10,%esp
}
     57a:	c9                   	leave  
     57b:	c3                   	ret    

0000057c <dirtest>:

void dirtest(void)
{
     57c:	55                   	push   %ebp
     57d:	89 e5                	mov    %esp,%ebp
     57f:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "mkdir test\n");
     582:	a1 74 5e 00 00       	mov    0x5e74,%eax
     587:	83 ec 08             	sub    $0x8,%esp
     58a:	68 ea 43 00 00       	push   $0x43ea
     58f:	50                   	push   %eax
     590:	e8 d4 37 00 00       	call   3d69 <printf>
     595:	83 c4 10             	add    $0x10,%esp

  if(mkdir("dir0") < 0){
     598:	83 ec 0c             	sub    $0xc,%esp
     59b:	68 f6 43 00 00       	push   $0x43f6
     5a0:	e8 af 36 00 00       	call   3c54 <mkdir>
     5a5:	83 c4 10             	add    $0x10,%esp
     5a8:	85 c0                	test   %eax,%eax
     5aa:	79 1b                	jns    5c7 <dirtest+0x4b>
    printf(stdout, "mkdir failed\n");
     5ac:	a1 74 5e 00 00       	mov    0x5e74,%eax
     5b1:	83 ec 08             	sub    $0x8,%esp
     5b4:	68 fb 43 00 00       	push   $0x43fb
     5b9:	50                   	push   %eax
     5ba:	e8 aa 37 00 00       	call   3d69 <printf>
     5bf:	83 c4 10             	add    $0x10,%esp
    exit();
     5c2:	e8 25 36 00 00       	call   3bec <exit>
  }

  if(chdir("dir0") < 0){
     5c7:	83 ec 0c             	sub    $0xc,%esp
     5ca:	68 f6 43 00 00       	push   $0x43f6
     5cf:	e8 88 36 00 00       	call   3c5c <chdir>
     5d4:	83 c4 10             	add    $0x10,%esp
     5d7:	85 c0                	test   %eax,%eax
     5d9:	79 1b                	jns    5f6 <dirtest+0x7a>
    printf(stdout, "chdir dir0 failed\n");
     5db:	a1 74 5e 00 00       	mov    0x5e74,%eax
     5e0:	83 ec 08             	sub    $0x8,%esp
     5e3:	68 09 44 00 00       	push   $0x4409
     5e8:	50                   	push   %eax
     5e9:	e8 7b 37 00 00       	call   3d69 <printf>
     5ee:	83 c4 10             	add    $0x10,%esp
    exit();
     5f1:	e8 f6 35 00 00       	call   3bec <exit>
  }

  if(chdir("..") < 0){
     5f6:	83 ec 0c             	sub    $0xc,%esp
     5f9:	68 1c 44 00 00       	push   $0x441c
     5fe:	e8 59 36 00 00       	call   3c5c <chdir>
     603:	83 c4 10             	add    $0x10,%esp
     606:	85 c0                	test   %eax,%eax
     608:	79 1b                	jns    625 <dirtest+0xa9>
    printf(stdout, "chdir .. failed\n");
     60a:	a1 74 5e 00 00       	mov    0x5e74,%eax
     60f:	83 ec 08             	sub    $0x8,%esp
     612:	68 1f 44 00 00       	push   $0x441f
     617:	50                   	push   %eax
     618:	e8 4c 37 00 00       	call   3d69 <printf>
     61d:	83 c4 10             	add    $0x10,%esp
    exit();
     620:	e8 c7 35 00 00       	call   3bec <exit>
  }

  if(unlink("dir0") < 0){
     625:	83 ec 0c             	sub    $0xc,%esp
     628:	68 f6 43 00 00       	push   $0x43f6
     62d:	e8 0a 36 00 00       	call   3c3c <unlink>
     632:	83 c4 10             	add    $0x10,%esp
     635:	85 c0                	test   %eax,%eax
     637:	79 1b                	jns    654 <dirtest+0xd8>
    printf(stdout, "unlink dir0 failed\n");
     639:	a1 74 5e 00 00       	mov    0x5e74,%eax
     63e:	83 ec 08             	sub    $0x8,%esp
     641:	68 30 44 00 00       	push   $0x4430
     646:	50                   	push   %eax
     647:	e8 1d 37 00 00       	call   3d69 <printf>
     64c:	83 c4 10             	add    $0x10,%esp
    exit();
     64f:	e8 98 35 00 00       	call   3bec <exit>
  }
  printf(stdout, "mkdir test\n");
     654:	a1 74 5e 00 00       	mov    0x5e74,%eax
     659:	83 ec 08             	sub    $0x8,%esp
     65c:	68 ea 43 00 00       	push   $0x43ea
     661:	50                   	push   %eax
     662:	e8 02 37 00 00       	call   3d69 <printf>
     667:	83 c4 10             	add    $0x10,%esp
}
     66a:	c9                   	leave  
     66b:	c3                   	ret    

0000066c <exectest>:

void
exectest(void)
{
     66c:	55                   	push   %ebp
     66d:	89 e5                	mov    %esp,%ebp
     66f:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "exec test\n");
     672:	a1 74 5e 00 00       	mov    0x5e74,%eax
     677:	83 ec 08             	sub    $0x8,%esp
     67a:	68 44 44 00 00       	push   $0x4444
     67f:	50                   	push   %eax
     680:	e8 e4 36 00 00       	call   3d69 <printf>
     685:	83 c4 10             	add    $0x10,%esp
  if(exec("echo", echoargv) < 0){
     688:	83 ec 08             	sub    $0x8,%esp
     68b:	68 60 5e 00 00       	push   $0x5e60
     690:	68 20 41 00 00       	push   $0x4120
     695:	e8 8a 35 00 00       	call   3c24 <exec>
     69a:	83 c4 10             	add    $0x10,%esp
     69d:	85 c0                	test   %eax,%eax
     69f:	79 1b                	jns    6bc <exectest+0x50>
    printf(stdout, "exec echo failed\n");
     6a1:	a1 74 5e 00 00       	mov    0x5e74,%eax
     6a6:	83 ec 08             	sub    $0x8,%esp
     6a9:	68 4f 44 00 00       	push   $0x444f
     6ae:	50                   	push   %eax
     6af:	e8 b5 36 00 00       	call   3d69 <printf>
     6b4:	83 c4 10             	add    $0x10,%esp
    exit();
     6b7:	e8 30 35 00 00       	call   3bec <exit>
  }
}
     6bc:	c9                   	leave  
     6bd:	c3                   	ret    

000006be <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     6be:	55                   	push   %ebp
     6bf:	89 e5                	mov    %esp,%ebp
     6c1:	83 ec 28             	sub    $0x28,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     6c4:	83 ec 0c             	sub    $0xc,%esp
     6c7:	8d 45 d8             	lea    -0x28(%ebp),%eax
     6ca:	50                   	push   %eax
     6cb:	e8 2c 35 00 00       	call   3bfc <pipe>
     6d0:	83 c4 10             	add    $0x10,%esp
     6d3:	85 c0                	test   %eax,%eax
     6d5:	74 17                	je     6ee <pipe1+0x30>
    printf(1, "pipe() failed\n");
     6d7:	83 ec 08             	sub    $0x8,%esp
     6da:	68 61 44 00 00       	push   $0x4461
     6df:	6a 01                	push   $0x1
     6e1:	e8 83 36 00 00       	call   3d69 <printf>
     6e6:	83 c4 10             	add    $0x10,%esp
    exit();
     6e9:	e8 fe 34 00 00       	call   3bec <exit>
  }
  pid = fork();
     6ee:	e8 f1 34 00 00       	call   3be4 <fork>
     6f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  seq = 0;
     6f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  if(pid == 0){
     6fd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     701:	0f 85 89 00 00 00    	jne    790 <pipe1+0xd2>
    close(fds[0]);
     707:	8b 45 d8             	mov    -0x28(%ebp),%eax
     70a:	83 ec 0c             	sub    $0xc,%esp
     70d:	50                   	push   %eax
     70e:	e8 01 35 00 00       	call   3c14 <close>
     713:	83 c4 10             	add    $0x10,%esp
    for(n = 0; n < 5; n++){
     716:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     71d:	eb 66                	jmp    785 <pipe1+0xc7>
      for(i = 0; i < 1033; i++)
     71f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     726:	eb 19                	jmp    741 <pipe1+0x83>
        buf[i] = seq++;
     728:	8b 45 f4             	mov    -0xc(%ebp),%eax
     72b:	8d 50 01             	lea    0x1(%eax),%edx
     72e:	89 55 f4             	mov    %edx,-0xc(%ebp)
     731:	89 c2                	mov    %eax,%edx
     733:	8b 45 f0             	mov    -0x10(%ebp),%eax
     736:	05 c0 86 00 00       	add    $0x86c0,%eax
     73b:	88 10                	mov    %dl,(%eax)
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     73d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     741:	81 7d f0 08 04 00 00 	cmpl   $0x408,-0x10(%ebp)
     748:	7e de                	jle    728 <pipe1+0x6a>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     74a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     74d:	83 ec 04             	sub    $0x4,%esp
     750:	68 09 04 00 00       	push   $0x409
     755:	68 c0 86 00 00       	push   $0x86c0
     75a:	50                   	push   %eax
     75b:	e8 ac 34 00 00       	call   3c0c <write>
     760:	83 c4 10             	add    $0x10,%esp
     763:	3d 09 04 00 00       	cmp    $0x409,%eax
     768:	74 17                	je     781 <pipe1+0xc3>
        printf(1, "pipe1 oops 1\n");
     76a:	83 ec 08             	sub    $0x8,%esp
     76d:	68 70 44 00 00       	push   $0x4470
     772:	6a 01                	push   $0x1
     774:	e8 f0 35 00 00       	call   3d69 <printf>
     779:	83 c4 10             	add    $0x10,%esp
        exit();
     77c:	e8 6b 34 00 00       	call   3bec <exit>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     781:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     785:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     789:	7e 94                	jle    71f <pipe1+0x61>
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
     78b:	e8 5c 34 00 00       	call   3bec <exit>
  } else if(pid > 0){
     790:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     794:	0f 8e f4 00 00 00    	jle    88e <pipe1+0x1d0>
    close(fds[1]);
     79a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     79d:	83 ec 0c             	sub    $0xc,%esp
     7a0:	50                   	push   %eax
     7a1:	e8 6e 34 00 00       	call   3c14 <close>
     7a6:	83 c4 10             	add    $0x10,%esp
    total = 0;
     7a9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    cc = 1;
     7b0:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     7b7:	eb 66                	jmp    81f <pipe1+0x161>
      for(i = 0; i < n; i++){
     7b9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     7c0:	eb 3b                	jmp    7fd <pipe1+0x13f>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     7c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7c5:	05 c0 86 00 00       	add    $0x86c0,%eax
     7ca:	0f b6 00             	movzbl (%eax),%eax
     7cd:	0f be c8             	movsbl %al,%ecx
     7d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d3:	8d 50 01             	lea    0x1(%eax),%edx
     7d6:	89 55 f4             	mov    %edx,-0xc(%ebp)
     7d9:	31 c8                	xor    %ecx,%eax
     7db:	0f b6 c0             	movzbl %al,%eax
     7de:	85 c0                	test   %eax,%eax
     7e0:	74 17                	je     7f9 <pipe1+0x13b>
          printf(1, "pipe1 oops 2\n");
     7e2:	83 ec 08             	sub    $0x8,%esp
     7e5:	68 7e 44 00 00       	push   $0x447e
     7ea:	6a 01                	push   $0x1
     7ec:	e8 78 35 00 00       	call   3d69 <printf>
     7f1:	83 c4 10             	add    $0x10,%esp
     7f4:	e9 ac 00 00 00       	jmp    8a5 <pipe1+0x1e7>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     7f9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     7fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     800:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     803:	7c bd                	jl     7c2 <pipe1+0x104>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     805:	8b 45 ec             	mov    -0x14(%ebp),%eax
     808:	01 45 e4             	add    %eax,-0x1c(%ebp)
      cc = cc * 2;
     80b:	d1 65 e8             	shll   -0x18(%ebp)
      if(cc > sizeof(buf))
     80e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     811:	3d 00 20 00 00       	cmp    $0x2000,%eax
     816:	76 07                	jbe    81f <pipe1+0x161>
        cc = sizeof(buf);
     818:	c7 45 e8 00 20 00 00 	movl   $0x2000,-0x18(%ebp)
    exit();
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     81f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     822:	83 ec 04             	sub    $0x4,%esp
     825:	ff 75 e8             	pushl  -0x18(%ebp)
     828:	68 c0 86 00 00       	push   $0x86c0
     82d:	50                   	push   %eax
     82e:	e8 d1 33 00 00       	call   3c04 <read>
     833:	83 c4 10             	add    $0x10,%esp
     836:	89 45 ec             	mov    %eax,-0x14(%ebp)
     839:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     83d:	0f 8f 76 ff ff ff    	jg     7b9 <pipe1+0xfb>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
     843:	81 7d e4 2d 14 00 00 	cmpl   $0x142d,-0x1c(%ebp)
     84a:	74 1a                	je     866 <pipe1+0x1a8>
      printf(1, "pipe1 oops 3 total %d\n", total);
     84c:	83 ec 04             	sub    $0x4,%esp
     84f:	ff 75 e4             	pushl  -0x1c(%ebp)
     852:	68 8c 44 00 00       	push   $0x448c
     857:	6a 01                	push   $0x1
     859:	e8 0b 35 00 00       	call   3d69 <printf>
     85e:	83 c4 10             	add    $0x10,%esp
      exit();
     861:	e8 86 33 00 00       	call   3bec <exit>
    }
    close(fds[0]);
     866:	8b 45 d8             	mov    -0x28(%ebp),%eax
     869:	83 ec 0c             	sub    $0xc,%esp
     86c:	50                   	push   %eax
     86d:	e8 a2 33 00 00       	call   3c14 <close>
     872:	83 c4 10             	add    $0x10,%esp
    wait();
     875:	e8 7a 33 00 00       	call   3bf4 <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     87a:	83 ec 08             	sub    $0x8,%esp
     87d:	68 b2 44 00 00       	push   $0x44b2
     882:	6a 01                	push   $0x1
     884:	e8 e0 34 00 00       	call   3d69 <printf>
     889:	83 c4 10             	add    $0x10,%esp
     88c:	eb 17                	jmp    8a5 <pipe1+0x1e7>
      exit();
    }
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
     88e:	83 ec 08             	sub    $0x8,%esp
     891:	68 a3 44 00 00       	push   $0x44a3
     896:	6a 01                	push   $0x1
     898:	e8 cc 34 00 00       	call   3d69 <printf>
     89d:	83 c4 10             	add    $0x10,%esp
    exit();
     8a0:	e8 47 33 00 00       	call   3bec <exit>
  }
  printf(1, "pipe1 ok\n");
}
     8a5:	c9                   	leave  
     8a6:	c3                   	ret    

000008a7 <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     8a7:	55                   	push   %ebp
     8a8:	89 e5                	mov    %esp,%ebp
     8aa:	83 ec 28             	sub    $0x28,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     8ad:	83 ec 08             	sub    $0x8,%esp
     8b0:	68 bc 44 00 00       	push   $0x44bc
     8b5:	6a 01                	push   $0x1
     8b7:	e8 ad 34 00 00       	call   3d69 <printf>
     8bc:	83 c4 10             	add    $0x10,%esp
  pid1 = fork();
     8bf:	e8 20 33 00 00       	call   3be4 <fork>
     8c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid1 == 0)
     8c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8cb:	75 02                	jne    8cf <preempt+0x28>
    for(;;)
      ;
     8cd:	eb fe                	jmp    8cd <preempt+0x26>

  pid2 = fork();
     8cf:	e8 10 33 00 00       	call   3be4 <fork>
     8d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid2 == 0)
     8d7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8db:	75 02                	jne    8df <preempt+0x38>
    for(;;)
      ;
     8dd:	eb fe                	jmp    8dd <preempt+0x36>

  pipe(pfds);
     8df:	83 ec 0c             	sub    $0xc,%esp
     8e2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     8e5:	50                   	push   %eax
     8e6:	e8 11 33 00 00       	call   3bfc <pipe>
     8eb:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
     8ee:	e8 f1 32 00 00       	call   3be4 <fork>
     8f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid3 == 0){
     8f6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     8fa:	75 4d                	jne    949 <preempt+0xa2>
    close(pfds[0]);
     8fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8ff:	83 ec 0c             	sub    $0xc,%esp
     902:	50                   	push   %eax
     903:	e8 0c 33 00 00       	call   3c14 <close>
     908:	83 c4 10             	add    $0x10,%esp
    if(write(pfds[1], "x", 1) != 1)
     90b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     90e:	83 ec 04             	sub    $0x4,%esp
     911:	6a 01                	push   $0x1
     913:	68 c6 44 00 00       	push   $0x44c6
     918:	50                   	push   %eax
     919:	e8 ee 32 00 00       	call   3c0c <write>
     91e:	83 c4 10             	add    $0x10,%esp
     921:	83 f8 01             	cmp    $0x1,%eax
     924:	74 12                	je     938 <preempt+0x91>
      printf(1, "preempt write error");
     926:	83 ec 08             	sub    $0x8,%esp
     929:	68 c8 44 00 00       	push   $0x44c8
     92e:	6a 01                	push   $0x1
     930:	e8 34 34 00 00       	call   3d69 <printf>
     935:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     938:	8b 45 e8             	mov    -0x18(%ebp),%eax
     93b:	83 ec 0c             	sub    $0xc,%esp
     93e:	50                   	push   %eax
     93f:	e8 d0 32 00 00       	call   3c14 <close>
     944:	83 c4 10             	add    $0x10,%esp
    for(;;)
      ;
     947:	eb fe                	jmp    947 <preempt+0xa0>
  }

  close(pfds[1]);
     949:	8b 45 e8             	mov    -0x18(%ebp),%eax
     94c:	83 ec 0c             	sub    $0xc,%esp
     94f:	50                   	push   %eax
     950:	e8 bf 32 00 00       	call   3c14 <close>
     955:	83 c4 10             	add    $0x10,%esp
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     958:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     95b:	83 ec 04             	sub    $0x4,%esp
     95e:	68 00 20 00 00       	push   $0x2000
     963:	68 c0 86 00 00       	push   $0x86c0
     968:	50                   	push   %eax
     969:	e8 96 32 00 00       	call   3c04 <read>
     96e:	83 c4 10             	add    $0x10,%esp
     971:	83 f8 01             	cmp    $0x1,%eax
     974:	74 14                	je     98a <preempt+0xe3>
    printf(1, "preempt read error");
     976:	83 ec 08             	sub    $0x8,%esp
     979:	68 dc 44 00 00       	push   $0x44dc
     97e:	6a 01                	push   $0x1
     980:	e8 e4 33 00 00       	call   3d69 <printf>
     985:	83 c4 10             	add    $0x10,%esp
     988:	eb 7e                	jmp    a08 <preempt+0x161>
    return;
  }
  close(pfds[0]);
     98a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     98d:	83 ec 0c             	sub    $0xc,%esp
     990:	50                   	push   %eax
     991:	e8 7e 32 00 00       	call   3c14 <close>
     996:	83 c4 10             	add    $0x10,%esp
  printf(1, "kill... ");
     999:	83 ec 08             	sub    $0x8,%esp
     99c:	68 ef 44 00 00       	push   $0x44ef
     9a1:	6a 01                	push   $0x1
     9a3:	e8 c1 33 00 00       	call   3d69 <printf>
     9a8:	83 c4 10             	add    $0x10,%esp
  kill(pid1);
     9ab:	83 ec 0c             	sub    $0xc,%esp
     9ae:	ff 75 f4             	pushl  -0xc(%ebp)
     9b1:	e8 66 32 00 00       	call   3c1c <kill>
     9b6:	83 c4 10             	add    $0x10,%esp
  kill(pid2);
     9b9:	83 ec 0c             	sub    $0xc,%esp
     9bc:	ff 75 f0             	pushl  -0x10(%ebp)
     9bf:	e8 58 32 00 00       	call   3c1c <kill>
     9c4:	83 c4 10             	add    $0x10,%esp
  kill(pid3);
     9c7:	83 ec 0c             	sub    $0xc,%esp
     9ca:	ff 75 ec             	pushl  -0x14(%ebp)
     9cd:	e8 4a 32 00 00       	call   3c1c <kill>
     9d2:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
     9d5:	83 ec 08             	sub    $0x8,%esp
     9d8:	68 f8 44 00 00       	push   $0x44f8
     9dd:	6a 01                	push   $0x1
     9df:	e8 85 33 00 00       	call   3d69 <printf>
     9e4:	83 c4 10             	add    $0x10,%esp
  wait();
     9e7:	e8 08 32 00 00       	call   3bf4 <wait>
  wait();
     9ec:	e8 03 32 00 00       	call   3bf4 <wait>
  wait();
     9f1:	e8 fe 31 00 00       	call   3bf4 <wait>
  printf(1, "preempt ok\n");
     9f6:	83 ec 08             	sub    $0x8,%esp
     9f9:	68 01 45 00 00       	push   $0x4501
     9fe:	6a 01                	push   $0x1
     a00:	e8 64 33 00 00       	call   3d69 <printf>
     a05:	83 c4 10             	add    $0x10,%esp
}
     a08:	c9                   	leave  
     a09:	c3                   	ret    

00000a0a <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     a0a:	55                   	push   %ebp
     a0b:	89 e5                	mov    %esp,%ebp
     a0d:	83 ec 18             	sub    $0x18,%esp
  int i, pid;

  for(i = 0; i < 100; i++){
     a10:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a17:	eb 4f                	jmp    a68 <exitwait+0x5e>
    pid = fork();
     a19:	e8 c6 31 00 00       	call   3be4 <fork>
     a1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0){
     a21:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a25:	79 14                	jns    a3b <exitwait+0x31>
      printf(1, "fork failed\n");
     a27:	83 ec 08             	sub    $0x8,%esp
     a2a:	68 0d 45 00 00       	push   $0x450d
     a2f:	6a 01                	push   $0x1
     a31:	e8 33 33 00 00       	call   3d69 <printf>
     a36:	83 c4 10             	add    $0x10,%esp
      return;
     a39:	eb 45                	jmp    a80 <exitwait+0x76>
    }
    if(pid){
     a3b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a3f:	74 1e                	je     a5f <exitwait+0x55>
      if(wait() != pid){
     a41:	e8 ae 31 00 00       	call   3bf4 <wait>
     a46:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     a49:	74 19                	je     a64 <exitwait+0x5a>
        printf(1, "wait wrong pid\n");
     a4b:	83 ec 08             	sub    $0x8,%esp
     a4e:	68 1a 45 00 00       	push   $0x451a
     a53:	6a 01                	push   $0x1
     a55:	e8 0f 33 00 00       	call   3d69 <printf>
     a5a:	83 c4 10             	add    $0x10,%esp
        return;
     a5d:	eb 21                	jmp    a80 <exitwait+0x76>
      }
    } else {
      exit();
     a5f:	e8 88 31 00 00       	call   3bec <exit>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     a64:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     a68:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     a6c:	7e ab                	jle    a19 <exitwait+0xf>
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
     a6e:	83 ec 08             	sub    $0x8,%esp
     a71:	68 2a 45 00 00       	push   $0x452a
     a76:	6a 01                	push   $0x1
     a78:	e8 ec 32 00 00       	call   3d69 <printf>
     a7d:	83 c4 10             	add    $0x10,%esp
}
     a80:	c9                   	leave  
     a81:	c3                   	ret    

00000a82 <mem>:

void
mem(void)
{
     a82:	55                   	push   %ebp
     a83:	89 e5                	mov    %esp,%ebp
     a85:	83 ec 18             	sub    $0x18,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     a88:	83 ec 08             	sub    $0x8,%esp
     a8b:	68 37 45 00 00       	push   $0x4537
     a90:	6a 01                	push   $0x1
     a92:	e8 d2 32 00 00       	call   3d69 <printf>
     a97:	83 c4 10             	add    $0x10,%esp
  ppid = getpid();
     a9a:	e8 cd 31 00 00       	call   3c6c <getpid>
     a9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if((pid = fork()) == 0){
     aa2:	e8 3d 31 00 00       	call   3be4 <fork>
     aa7:	89 45 ec             	mov    %eax,-0x14(%ebp)
     aaa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     aae:	0f 85 b7 00 00 00    	jne    b6b <mem+0xe9>
    m1 = 0;
     ab4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     abb:	eb 0e                	jmp    acb <mem+0x49>
      *(char**)m2 = m1;
     abd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ac0:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ac3:	89 10                	mov    %edx,(%eax)
      m1 = m2;
     ac5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ac8:	89 45 f4             	mov    %eax,-0xc(%ebp)

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
     acb:	83 ec 0c             	sub    $0xc,%esp
     ace:	68 11 27 00 00       	push   $0x2711
     ad3:	e8 62 35 00 00       	call   403a <malloc>
     ad8:	83 c4 10             	add    $0x10,%esp
     adb:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ade:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     ae2:	75 d9                	jne    abd <mem+0x3b>
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     ae4:	eb 1c                	jmp    b02 <mem+0x80>
      m2 = *(char**)m1;
     ae6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae9:	8b 00                	mov    (%eax),%eax
     aeb:	89 45 e8             	mov    %eax,-0x18(%ebp)
      free(m1);
     aee:	83 ec 0c             	sub    $0xc,%esp
     af1:	ff 75 f4             	pushl  -0xc(%ebp)
     af4:	e8 00 34 00 00       	call   3ef9 <free>
     af9:	83 c4 10             	add    $0x10,%esp
      m1 = m2;
     afc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     aff:	89 45 f4             	mov    %eax,-0xc(%ebp)
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     b02:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b06:	75 de                	jne    ae6 <mem+0x64>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
     b08:	83 ec 0c             	sub    $0xc,%esp
     b0b:	68 00 50 00 00       	push   $0x5000
     b10:	e8 25 35 00 00       	call   403a <malloc>
     b15:	83 c4 10             	add    $0x10,%esp
     b18:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(m1 == 0){
     b1b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b1f:	75 25                	jne    b46 <mem+0xc4>
      printf(1, "couldn't allocate mem?!!\n");
     b21:	83 ec 08             	sub    $0x8,%esp
     b24:	68 41 45 00 00       	push   $0x4541
     b29:	6a 01                	push   $0x1
     b2b:	e8 39 32 00 00       	call   3d69 <printf>
     b30:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
     b33:	83 ec 0c             	sub    $0xc,%esp
     b36:	ff 75 f0             	pushl  -0x10(%ebp)
     b39:	e8 de 30 00 00       	call   3c1c <kill>
     b3e:	83 c4 10             	add    $0x10,%esp
      exit();
     b41:	e8 a6 30 00 00       	call   3bec <exit>
    }
    free(m1);
     b46:	83 ec 0c             	sub    $0xc,%esp
     b49:	ff 75 f4             	pushl  -0xc(%ebp)
     b4c:	e8 a8 33 00 00       	call   3ef9 <free>
     b51:	83 c4 10             	add    $0x10,%esp
    printf(1, "mem ok\n");
     b54:	83 ec 08             	sub    $0x8,%esp
     b57:	68 5b 45 00 00       	push   $0x455b
     b5c:	6a 01                	push   $0x1
     b5e:	e8 06 32 00 00       	call   3d69 <printf>
     b63:	83 c4 10             	add    $0x10,%esp
    exit();
     b66:	e8 81 30 00 00       	call   3bec <exit>
  } else {
    wait();
     b6b:	e8 84 30 00 00       	call   3bf4 <wait>
  }
}
     b70:	c9                   	leave  
     b71:	c3                   	ret    

00000b72 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     b72:	55                   	push   %ebp
     b73:	89 e5                	mov    %esp,%ebp
     b75:	83 ec 38             	sub    $0x38,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     b78:	83 ec 08             	sub    $0x8,%esp
     b7b:	68 63 45 00 00       	push   $0x4563
     b80:	6a 01                	push   $0x1
     b82:	e8 e2 31 00 00       	call   3d69 <printf>
     b87:	83 c4 10             	add    $0x10,%esp

  unlink("sharedfd");
     b8a:	83 ec 0c             	sub    $0xc,%esp
     b8d:	68 72 45 00 00       	push   $0x4572
     b92:	e8 a5 30 00 00       	call   3c3c <unlink>
     b97:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", O_CREATE|O_RDWR);
     b9a:	83 ec 08             	sub    $0x8,%esp
     b9d:	68 02 02 00 00       	push   $0x202
     ba2:	68 72 45 00 00       	push   $0x4572
     ba7:	e8 80 30 00 00       	call   3c2c <open>
     bac:	83 c4 10             	add    $0x10,%esp
     baf:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     bb2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     bb6:	79 17                	jns    bcf <sharedfd+0x5d>
    printf(1, "fstests: cannot open sharedfd for writing");
     bb8:	83 ec 08             	sub    $0x8,%esp
     bbb:	68 7c 45 00 00       	push   $0x457c
     bc0:	6a 01                	push   $0x1
     bc2:	e8 a2 31 00 00       	call   3d69 <printf>
     bc7:	83 c4 10             	add    $0x10,%esp
    return;
     bca:	e9 84 01 00 00       	jmp    d53 <sharedfd+0x1e1>
  }
  pid = fork();
     bcf:	e8 10 30 00 00       	call   3be4 <fork>
     bd4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     bd7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     bdb:	75 07                	jne    be4 <sharedfd+0x72>
     bdd:	b8 63 00 00 00       	mov    $0x63,%eax
     be2:	eb 05                	jmp    be9 <sharedfd+0x77>
     be4:	b8 70 00 00 00       	mov    $0x70,%eax
     be9:	83 ec 04             	sub    $0x4,%esp
     bec:	6a 0a                	push   $0xa
     bee:	50                   	push   %eax
     bef:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     bf2:	50                   	push   %eax
     bf3:	e8 5a 2e 00 00       	call   3a52 <memset>
     bf8:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 1000; i++){
     bfb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c02:	eb 31                	jmp    c35 <sharedfd+0xc3>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     c04:	83 ec 04             	sub    $0x4,%esp
     c07:	6a 0a                	push   $0xa
     c09:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     c0c:	50                   	push   %eax
     c0d:	ff 75 e8             	pushl  -0x18(%ebp)
     c10:	e8 f7 2f 00 00       	call   3c0c <write>
     c15:	83 c4 10             	add    $0x10,%esp
     c18:	83 f8 0a             	cmp    $0xa,%eax
     c1b:	74 14                	je     c31 <sharedfd+0xbf>
      printf(1, "fstests: write sharedfd failed\n");
     c1d:	83 ec 08             	sub    $0x8,%esp
     c20:	68 a8 45 00 00       	push   $0x45a8
     c25:	6a 01                	push   $0x1
     c27:	e8 3d 31 00 00       	call   3d69 <printf>
     c2c:	83 c4 10             	add    $0x10,%esp
      break;
     c2f:	eb 0d                	jmp    c3e <sharedfd+0xcc>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
  memset(buf, pid==0?'c':'p', sizeof(buf));
  for(i = 0; i < 1000; i++){
     c31:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c35:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
     c3c:	7e c6                	jle    c04 <sharedfd+0x92>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
     c3e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     c42:	75 05                	jne    c49 <sharedfd+0xd7>
    exit();
     c44:	e8 a3 2f 00 00       	call   3bec <exit>
  else
    wait();
     c49:	e8 a6 2f 00 00       	call   3bf4 <wait>
  close(fd);
     c4e:	83 ec 0c             	sub    $0xc,%esp
     c51:	ff 75 e8             	pushl  -0x18(%ebp)
     c54:	e8 bb 2f 00 00       	call   3c14 <close>
     c59:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", 0);
     c5c:	83 ec 08             	sub    $0x8,%esp
     c5f:	6a 00                	push   $0x0
     c61:	68 72 45 00 00       	push   $0x4572
     c66:	e8 c1 2f 00 00       	call   3c2c <open>
     c6b:	83 c4 10             	add    $0x10,%esp
     c6e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     c71:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     c75:	79 17                	jns    c8e <sharedfd+0x11c>
    printf(1, "fstests: cannot open sharedfd for reading\n");
     c77:	83 ec 08             	sub    $0x8,%esp
     c7a:	68 c8 45 00 00       	push   $0x45c8
     c7f:	6a 01                	push   $0x1
     c81:	e8 e3 30 00 00       	call   3d69 <printf>
     c86:	83 c4 10             	add    $0x10,%esp
    return;
     c89:	e9 c5 00 00 00       	jmp    d53 <sharedfd+0x1e1>
  }
  nc = np = 0;
     c8e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     c95:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c98:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
     c9b:	eb 3b                	jmp    cd8 <sharedfd+0x166>
    for(i = 0; i < sizeof(buf); i++){
     c9d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ca4:	eb 2a                	jmp    cd0 <sharedfd+0x15e>
      if(buf[i] == 'c')
     ca6:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     ca9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cac:	01 d0                	add    %edx,%eax
     cae:	0f b6 00             	movzbl (%eax),%eax
     cb1:	3c 63                	cmp    $0x63,%al
     cb3:	75 04                	jne    cb9 <sharedfd+0x147>
        nc++;
     cb5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(buf[i] == 'p')
     cb9:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     cbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cbf:	01 d0                	add    %edx,%eax
     cc1:	0f b6 00             	movzbl (%eax),%eax
     cc4:	3c 70                	cmp    $0x70,%al
     cc6:	75 04                	jne    ccc <sharedfd+0x15a>
        np++;
     cc8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
     ccc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     cd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cd3:	83 f8 09             	cmp    $0x9,%eax
     cd6:	76 ce                	jbe    ca6 <sharedfd+0x134>
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
     cd8:	83 ec 04             	sub    $0x4,%esp
     cdb:	6a 0a                	push   $0xa
     cdd:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     ce0:	50                   	push   %eax
     ce1:	ff 75 e8             	pushl  -0x18(%ebp)
     ce4:	e8 1b 2f 00 00       	call   3c04 <read>
     ce9:	83 c4 10             	add    $0x10,%esp
     cec:	89 45 e0             	mov    %eax,-0x20(%ebp)
     cef:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     cf3:	7f a8                	jg     c9d <sharedfd+0x12b>
        nc++;
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
     cf5:	83 ec 0c             	sub    $0xc,%esp
     cf8:	ff 75 e8             	pushl  -0x18(%ebp)
     cfb:	e8 14 2f 00 00       	call   3c14 <close>
     d00:	83 c4 10             	add    $0x10,%esp
  unlink("sharedfd");
     d03:	83 ec 0c             	sub    $0xc,%esp
     d06:	68 72 45 00 00       	push   $0x4572
     d0b:	e8 2c 2f 00 00       	call   3c3c <unlink>
     d10:	83 c4 10             	add    $0x10,%esp
  if(nc == 10000 && np == 10000){
     d13:	81 7d f0 10 27 00 00 	cmpl   $0x2710,-0x10(%ebp)
     d1a:	75 1d                	jne    d39 <sharedfd+0x1c7>
     d1c:	81 7d ec 10 27 00 00 	cmpl   $0x2710,-0x14(%ebp)
     d23:	75 14                	jne    d39 <sharedfd+0x1c7>
    printf(1, "sharedfd ok\n");
     d25:	83 ec 08             	sub    $0x8,%esp
     d28:	68 f3 45 00 00       	push   $0x45f3
     d2d:	6a 01                	push   $0x1
     d2f:	e8 35 30 00 00       	call   3d69 <printf>
     d34:	83 c4 10             	add    $0x10,%esp
     d37:	eb 1a                	jmp    d53 <sharedfd+0x1e1>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
     d39:	ff 75 ec             	pushl  -0x14(%ebp)
     d3c:	ff 75 f0             	pushl  -0x10(%ebp)
     d3f:	68 00 46 00 00       	push   $0x4600
     d44:	6a 01                	push   $0x1
     d46:	e8 1e 30 00 00       	call   3d69 <printf>
     d4b:	83 c4 10             	add    $0x10,%esp
    exit();
     d4e:	e8 99 2e 00 00       	call   3bec <exit>
  }
}
     d53:	c9                   	leave  
     d54:	c3                   	ret    

00000d55 <twofiles>:

// two processes write two different files at the same
// time, to test block allocation.
void
twofiles(void)
{
     d55:	55                   	push   %ebp
     d56:	89 e5                	mov    %esp,%ebp
     d58:	83 ec 28             	sub    $0x28,%esp
  int fd, pid, i, j, n, total;
  char *fname;

  printf(1, "twofiles test\n");
     d5b:	83 ec 08             	sub    $0x8,%esp
     d5e:	68 15 46 00 00       	push   $0x4615
     d63:	6a 01                	push   $0x1
     d65:	e8 ff 2f 00 00       	call   3d69 <printf>
     d6a:	83 c4 10             	add    $0x10,%esp

  unlink("f1");
     d6d:	83 ec 0c             	sub    $0xc,%esp
     d70:	68 24 46 00 00       	push   $0x4624
     d75:	e8 c2 2e 00 00       	call   3c3c <unlink>
     d7a:	83 c4 10             	add    $0x10,%esp
  unlink("f2");
     d7d:	83 ec 0c             	sub    $0xc,%esp
     d80:	68 27 46 00 00       	push   $0x4627
     d85:	e8 b2 2e 00 00       	call   3c3c <unlink>
     d8a:	83 c4 10             	add    $0x10,%esp

  pid = fork();
     d8d:	e8 52 2e 00 00       	call   3be4 <fork>
     d92:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(pid < 0){
     d95:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     d99:	79 17                	jns    db2 <twofiles+0x5d>
    printf(1, "fork failed\n");
     d9b:	83 ec 08             	sub    $0x8,%esp
     d9e:	68 0d 45 00 00       	push   $0x450d
     da3:	6a 01                	push   $0x1
     da5:	e8 bf 2f 00 00       	call   3d69 <printf>
     daa:	83 c4 10             	add    $0x10,%esp
    exit();
     dad:	e8 3a 2e 00 00       	call   3bec <exit>
  }

  fname = pid ? "f1" : "f2";
     db2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     db6:	74 07                	je     dbf <twofiles+0x6a>
     db8:	b8 24 46 00 00       	mov    $0x4624,%eax
     dbd:	eb 05                	jmp    dc4 <twofiles+0x6f>
     dbf:	b8 27 46 00 00       	mov    $0x4627,%eax
     dc4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  fd = open(fname, O_CREATE | O_RDWR);
     dc7:	83 ec 08             	sub    $0x8,%esp
     dca:	68 02 02 00 00       	push   $0x202
     dcf:	ff 75 e4             	pushl  -0x1c(%ebp)
     dd2:	e8 55 2e 00 00       	call   3c2c <open>
     dd7:	83 c4 10             	add    $0x10,%esp
     dda:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(fd < 0){
     ddd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     de1:	79 17                	jns    dfa <twofiles+0xa5>
    printf(1, "create failed\n");
     de3:	83 ec 08             	sub    $0x8,%esp
     de6:	68 2a 46 00 00       	push   $0x462a
     deb:	6a 01                	push   $0x1
     ded:	e8 77 2f 00 00       	call   3d69 <printf>
     df2:	83 c4 10             	add    $0x10,%esp
    exit();
     df5:	e8 f2 2d 00 00       	call   3bec <exit>
  }

  memset(buf, pid?'p':'c', 512);
     dfa:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     dfe:	74 07                	je     e07 <twofiles+0xb2>
     e00:	b8 70 00 00 00       	mov    $0x70,%eax
     e05:	eb 05                	jmp    e0c <twofiles+0xb7>
     e07:	b8 63 00 00 00       	mov    $0x63,%eax
     e0c:	83 ec 04             	sub    $0x4,%esp
     e0f:	68 00 02 00 00       	push   $0x200
     e14:	50                   	push   %eax
     e15:	68 c0 86 00 00       	push   $0x86c0
     e1a:	e8 33 2c 00 00       	call   3a52 <memset>
     e1f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 12; i++){
     e22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e29:	eb 42                	jmp    e6d <twofiles+0x118>
    if((n = write(fd, buf, 500)) != 500){
     e2b:	83 ec 04             	sub    $0x4,%esp
     e2e:	68 f4 01 00 00       	push   $0x1f4
     e33:	68 c0 86 00 00       	push   $0x86c0
     e38:	ff 75 e0             	pushl  -0x20(%ebp)
     e3b:	e8 cc 2d 00 00       	call   3c0c <write>
     e40:	83 c4 10             	add    $0x10,%esp
     e43:	89 45 dc             	mov    %eax,-0x24(%ebp)
     e46:	81 7d dc f4 01 00 00 	cmpl   $0x1f4,-0x24(%ebp)
     e4d:	74 1a                	je     e69 <twofiles+0x114>
      printf(1, "write failed %d\n", n);
     e4f:	83 ec 04             	sub    $0x4,%esp
     e52:	ff 75 dc             	pushl  -0x24(%ebp)
     e55:	68 39 46 00 00       	push   $0x4639
     e5a:	6a 01                	push   $0x1
     e5c:	e8 08 2f 00 00       	call   3d69 <printf>
     e61:	83 c4 10             	add    $0x10,%esp
      exit();
     e64:	e8 83 2d 00 00       	call   3bec <exit>
    printf(1, "create failed\n");
    exit();
  }

  memset(buf, pid?'p':'c', 512);
  for(i = 0; i < 12; i++){
     e69:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e6d:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
     e71:	7e b8                	jle    e2b <twofiles+0xd6>
    if((n = write(fd, buf, 500)) != 500){
      printf(1, "write failed %d\n", n);
      exit();
    }
  }
  close(fd);
     e73:	83 ec 0c             	sub    $0xc,%esp
     e76:	ff 75 e0             	pushl  -0x20(%ebp)
     e79:	e8 96 2d 00 00       	call   3c14 <close>
     e7e:	83 c4 10             	add    $0x10,%esp
  if(pid)
     e81:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     e85:	74 11                	je     e98 <twofiles+0x143>
    wait();
     e87:	e8 68 2d 00 00       	call   3bf4 <wait>
  else
    exit();

  for(i = 0; i < 2; i++){
     e8c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e93:	e9 dd 00 00 00       	jmp    f75 <twofiles+0x220>
  }
  close(fd);
  if(pid)
    wait();
  else
    exit();
     e98:	e8 4f 2d 00 00       	call   3bec <exit>

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
     e9d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ea1:	74 07                	je     eaa <twofiles+0x155>
     ea3:	b8 24 46 00 00       	mov    $0x4624,%eax
     ea8:	eb 05                	jmp    eaf <twofiles+0x15a>
     eaa:	b8 27 46 00 00       	mov    $0x4627,%eax
     eaf:	83 ec 08             	sub    $0x8,%esp
     eb2:	6a 00                	push   $0x0
     eb4:	50                   	push   %eax
     eb5:	e8 72 2d 00 00       	call   3c2c <open>
     eba:	83 c4 10             	add    $0x10,%esp
     ebd:	89 45 e0             	mov    %eax,-0x20(%ebp)
    total = 0;
     ec0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
     ec7:	eb 56                	jmp    f1f <twofiles+0x1ca>
      for(j = 0; j < n; j++){
     ec9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ed0:	eb 3f                	jmp    f11 <twofiles+0x1bc>
        if(buf[j] != (i?'p':'c')){
     ed2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ed5:	05 c0 86 00 00       	add    $0x86c0,%eax
     eda:	0f b6 00             	movzbl (%eax),%eax
     edd:	0f be c0             	movsbl %al,%eax
     ee0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ee4:	74 07                	je     eed <twofiles+0x198>
     ee6:	ba 70 00 00 00       	mov    $0x70,%edx
     eeb:	eb 05                	jmp    ef2 <twofiles+0x19d>
     eed:	ba 63 00 00 00       	mov    $0x63,%edx
     ef2:	39 d0                	cmp    %edx,%eax
     ef4:	74 17                	je     f0d <twofiles+0x1b8>
          printf(1, "wrong char\n");
     ef6:	83 ec 08             	sub    $0x8,%esp
     ef9:	68 4a 46 00 00       	push   $0x464a
     efe:	6a 01                	push   $0x1
     f00:	e8 64 2e 00 00       	call   3d69 <printf>
     f05:	83 c4 10             	add    $0x10,%esp
          exit();
     f08:	e8 df 2c 00 00       	call   3bec <exit>

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
     f0d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f11:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f14:	3b 45 dc             	cmp    -0x24(%ebp),%eax
     f17:	7c b9                	jl     ed2 <twofiles+0x17d>
        if(buf[j] != (i?'p':'c')){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
     f19:	8b 45 dc             	mov    -0x24(%ebp),%eax
     f1c:	01 45 ec             	add    %eax,-0x14(%ebp)
    exit();

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
     f1f:	83 ec 04             	sub    $0x4,%esp
     f22:	68 00 20 00 00       	push   $0x2000
     f27:	68 c0 86 00 00       	push   $0x86c0
     f2c:	ff 75 e0             	pushl  -0x20(%ebp)
     f2f:	e8 d0 2c 00 00       	call   3c04 <read>
     f34:	83 c4 10             	add    $0x10,%esp
     f37:	89 45 dc             	mov    %eax,-0x24(%ebp)
     f3a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     f3e:	7f 89                	jg     ec9 <twofiles+0x174>
          exit();
        }
      }
      total += n;
    }
    close(fd);
     f40:	83 ec 0c             	sub    $0xc,%esp
     f43:	ff 75 e0             	pushl  -0x20(%ebp)
     f46:	e8 c9 2c 00 00       	call   3c14 <close>
     f4b:	83 c4 10             	add    $0x10,%esp
    if(total != 12*500){
     f4e:	81 7d ec 70 17 00 00 	cmpl   $0x1770,-0x14(%ebp)
     f55:	74 1a                	je     f71 <twofiles+0x21c>
      printf(1, "wrong length %d\n", total);
     f57:	83 ec 04             	sub    $0x4,%esp
     f5a:	ff 75 ec             	pushl  -0x14(%ebp)
     f5d:	68 56 46 00 00       	push   $0x4656
     f62:	6a 01                	push   $0x1
     f64:	e8 00 2e 00 00       	call   3d69 <printf>
     f69:	83 c4 10             	add    $0x10,%esp
      exit();
     f6c:	e8 7b 2c 00 00       	call   3bec <exit>
  if(pid)
    wait();
  else
    exit();

  for(i = 0; i < 2; i++){
     f71:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f75:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
     f79:	0f 8e 1e ff ff ff    	jle    e9d <twofiles+0x148>
      printf(1, "wrong length %d\n", total);
      exit();
    }
  }

  unlink("f1");
     f7f:	83 ec 0c             	sub    $0xc,%esp
     f82:	68 24 46 00 00       	push   $0x4624
     f87:	e8 b0 2c 00 00       	call   3c3c <unlink>
     f8c:	83 c4 10             	add    $0x10,%esp
  unlink("f2");
     f8f:	83 ec 0c             	sub    $0xc,%esp
     f92:	68 27 46 00 00       	push   $0x4627
     f97:	e8 a0 2c 00 00       	call   3c3c <unlink>
     f9c:	83 c4 10             	add    $0x10,%esp

  printf(1, "twofiles ok\n");
     f9f:	83 ec 08             	sub    $0x8,%esp
     fa2:	68 67 46 00 00       	push   $0x4667
     fa7:	6a 01                	push   $0x1
     fa9:	e8 bb 2d 00 00       	call   3d69 <printf>
     fae:	83 c4 10             	add    $0x10,%esp
}
     fb1:	c9                   	leave  
     fb2:	c3                   	ret    

00000fb3 <createdelete>:

// two processes create and delete different files in same directory
void
createdelete(void)
{
     fb3:	55                   	push   %ebp
     fb4:	89 e5                	mov    %esp,%ebp
     fb6:	83 ec 38             	sub    $0x38,%esp
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
     fb9:	83 ec 08             	sub    $0x8,%esp
     fbc:	68 74 46 00 00       	push   $0x4674
     fc1:	6a 01                	push   $0x1
     fc3:	e8 a1 2d 00 00       	call   3d69 <printf>
     fc8:	83 c4 10             	add    $0x10,%esp
  pid = fork();
     fcb:	e8 14 2c 00 00       	call   3be4 <fork>
     fd0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid < 0){
     fd3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     fd7:	79 17                	jns    ff0 <createdelete+0x3d>
    printf(1, "fork failed\n");
     fd9:	83 ec 08             	sub    $0x8,%esp
     fdc:	68 0d 45 00 00       	push   $0x450d
     fe1:	6a 01                	push   $0x1
     fe3:	e8 81 2d 00 00       	call   3d69 <printf>
     fe8:	83 c4 10             	add    $0x10,%esp
    exit();
     feb:	e8 fc 2b 00 00       	call   3bec <exit>
  }

  name[0] = pid ? 'p' : 'c';
     ff0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     ff4:	74 07                	je     ffd <createdelete+0x4a>
     ff6:	b8 70 00 00 00       	mov    $0x70,%eax
     ffb:	eb 05                	jmp    1002 <createdelete+0x4f>
     ffd:	b8 63 00 00 00       	mov    $0x63,%eax
    1002:	88 45 cc             	mov    %al,-0x34(%ebp)
  name[2] = '\0';
    1005:	c6 45 ce 00          	movb   $0x0,-0x32(%ebp)
  for(i = 0; i < N; i++){
    1009:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1010:	e9 9b 00 00 00       	jmp    10b0 <createdelete+0xfd>
    name[1] = '0' + i;
    1015:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1018:	83 c0 30             	add    $0x30,%eax
    101b:	88 45 cd             	mov    %al,-0x33(%ebp)
    fd = open(name, O_CREATE | O_RDWR);
    101e:	83 ec 08             	sub    $0x8,%esp
    1021:	68 02 02 00 00       	push   $0x202
    1026:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1029:	50                   	push   %eax
    102a:	e8 fd 2b 00 00       	call   3c2c <open>
    102f:	83 c4 10             	add    $0x10,%esp
    1032:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    1035:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1039:	79 17                	jns    1052 <createdelete+0x9f>
      printf(1, "create failed\n");
    103b:	83 ec 08             	sub    $0x8,%esp
    103e:	68 2a 46 00 00       	push   $0x462a
    1043:	6a 01                	push   $0x1
    1045:	e8 1f 2d 00 00       	call   3d69 <printf>
    104a:	83 c4 10             	add    $0x10,%esp
      exit();
    104d:	e8 9a 2b 00 00       	call   3bec <exit>
    }
    close(fd);
    1052:	83 ec 0c             	sub    $0xc,%esp
    1055:	ff 75 ec             	pushl  -0x14(%ebp)
    1058:	e8 b7 2b 00 00       	call   3c14 <close>
    105d:	83 c4 10             	add    $0x10,%esp
    if(i > 0 && (i % 2 ) == 0){
    1060:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1064:	7e 46                	jle    10ac <createdelete+0xf9>
    1066:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1069:	83 e0 01             	and    $0x1,%eax
    106c:	85 c0                	test   %eax,%eax
    106e:	75 3c                	jne    10ac <createdelete+0xf9>
      name[1] = '0' + (i / 2);
    1070:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1073:	89 c2                	mov    %eax,%edx
    1075:	c1 ea 1f             	shr    $0x1f,%edx
    1078:	01 d0                	add    %edx,%eax
    107a:	d1 f8                	sar    %eax
    107c:	83 c0 30             	add    $0x30,%eax
    107f:	88 45 cd             	mov    %al,-0x33(%ebp)
      if(unlink(name) < 0){
    1082:	83 ec 0c             	sub    $0xc,%esp
    1085:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1088:	50                   	push   %eax
    1089:	e8 ae 2b 00 00       	call   3c3c <unlink>
    108e:	83 c4 10             	add    $0x10,%esp
    1091:	85 c0                	test   %eax,%eax
    1093:	79 17                	jns    10ac <createdelete+0xf9>
        printf(1, "unlink failed\n");
    1095:	83 ec 08             	sub    $0x8,%esp
    1098:	68 87 46 00 00       	push   $0x4687
    109d:	6a 01                	push   $0x1
    109f:	e8 c5 2c 00 00       	call   3d69 <printf>
    10a4:	83 c4 10             	add    $0x10,%esp
        exit();
    10a7:	e8 40 2b 00 00       	call   3bec <exit>
    exit();
  }

  name[0] = pid ? 'p' : 'c';
  name[2] = '\0';
  for(i = 0; i < N; i++){
    10ac:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10b0:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    10b4:	0f 8e 5b ff ff ff    	jle    1015 <createdelete+0x62>
        exit();
      }
    }
  }

  if(pid==0)
    10ba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    10be:	75 05                	jne    10c5 <createdelete+0x112>
    exit();
    10c0:	e8 27 2b 00 00       	call   3bec <exit>
  else
    wait();
    10c5:	e8 2a 2b 00 00       	call   3bf4 <wait>

  for(i = 0; i < N; i++){
    10ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    10d1:	e9 22 01 00 00       	jmp    11f8 <createdelete+0x245>
    name[0] = 'p';
    10d6:	c6 45 cc 70          	movb   $0x70,-0x34(%ebp)
    name[1] = '0' + i;
    10da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10dd:	83 c0 30             	add    $0x30,%eax
    10e0:	88 45 cd             	mov    %al,-0x33(%ebp)
    fd = open(name, 0);
    10e3:	83 ec 08             	sub    $0x8,%esp
    10e6:	6a 00                	push   $0x0
    10e8:	8d 45 cc             	lea    -0x34(%ebp),%eax
    10eb:	50                   	push   %eax
    10ec:	e8 3b 2b 00 00       	call   3c2c <open>
    10f1:	83 c4 10             	add    $0x10,%esp
    10f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((i == 0 || i >= N/2) && fd < 0){
    10f7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10fb:	74 06                	je     1103 <createdelete+0x150>
    10fd:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1101:	7e 21                	jle    1124 <createdelete+0x171>
    1103:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1107:	79 1b                	jns    1124 <createdelete+0x171>
      printf(1, "oops createdelete %s didn't exist\n", name);
    1109:	83 ec 04             	sub    $0x4,%esp
    110c:	8d 45 cc             	lea    -0x34(%ebp),%eax
    110f:	50                   	push   %eax
    1110:	68 98 46 00 00       	push   $0x4698
    1115:	6a 01                	push   $0x1
    1117:	e8 4d 2c 00 00       	call   3d69 <printf>
    111c:	83 c4 10             	add    $0x10,%esp
      exit();
    111f:	e8 c8 2a 00 00       	call   3bec <exit>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    1124:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1128:	7e 27                	jle    1151 <createdelete+0x19e>
    112a:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    112e:	7f 21                	jg     1151 <createdelete+0x19e>
    1130:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1134:	78 1b                	js     1151 <createdelete+0x19e>
      printf(1, "oops createdelete %s did exist\n", name);
    1136:	83 ec 04             	sub    $0x4,%esp
    1139:	8d 45 cc             	lea    -0x34(%ebp),%eax
    113c:	50                   	push   %eax
    113d:	68 bc 46 00 00       	push   $0x46bc
    1142:	6a 01                	push   $0x1
    1144:	e8 20 2c 00 00       	call   3d69 <printf>
    1149:	83 c4 10             	add    $0x10,%esp
      exit();
    114c:	e8 9b 2a 00 00       	call   3bec <exit>
    }
    if(fd >= 0)
    1151:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1155:	78 0e                	js     1165 <createdelete+0x1b2>
      close(fd);
    1157:	83 ec 0c             	sub    $0xc,%esp
    115a:	ff 75 ec             	pushl  -0x14(%ebp)
    115d:	e8 b2 2a 00 00       	call   3c14 <close>
    1162:	83 c4 10             	add    $0x10,%esp

    name[0] = 'c';
    1165:	c6 45 cc 63          	movb   $0x63,-0x34(%ebp)
    name[1] = '0' + i;
    1169:	8b 45 f4             	mov    -0xc(%ebp),%eax
    116c:	83 c0 30             	add    $0x30,%eax
    116f:	88 45 cd             	mov    %al,-0x33(%ebp)
    fd = open(name, 0);
    1172:	83 ec 08             	sub    $0x8,%esp
    1175:	6a 00                	push   $0x0
    1177:	8d 45 cc             	lea    -0x34(%ebp),%eax
    117a:	50                   	push   %eax
    117b:	e8 ac 2a 00 00       	call   3c2c <open>
    1180:	83 c4 10             	add    $0x10,%esp
    1183:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((i == 0 || i >= N/2) && fd < 0){
    1186:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    118a:	74 06                	je     1192 <createdelete+0x1df>
    118c:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1190:	7e 21                	jle    11b3 <createdelete+0x200>
    1192:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1196:	79 1b                	jns    11b3 <createdelete+0x200>
      printf(1, "oops createdelete %s didn't exist\n", name);
    1198:	83 ec 04             	sub    $0x4,%esp
    119b:	8d 45 cc             	lea    -0x34(%ebp),%eax
    119e:	50                   	push   %eax
    119f:	68 98 46 00 00       	push   $0x4698
    11a4:	6a 01                	push   $0x1
    11a6:	e8 be 2b 00 00       	call   3d69 <printf>
    11ab:	83 c4 10             	add    $0x10,%esp
      exit();
    11ae:	e8 39 2a 00 00       	call   3bec <exit>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    11b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11b7:	7e 27                	jle    11e0 <createdelete+0x22d>
    11b9:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    11bd:	7f 21                	jg     11e0 <createdelete+0x22d>
    11bf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11c3:	78 1b                	js     11e0 <createdelete+0x22d>
      printf(1, "oops createdelete %s did exist\n", name);
    11c5:	83 ec 04             	sub    $0x4,%esp
    11c8:	8d 45 cc             	lea    -0x34(%ebp),%eax
    11cb:	50                   	push   %eax
    11cc:	68 bc 46 00 00       	push   $0x46bc
    11d1:	6a 01                	push   $0x1
    11d3:	e8 91 2b 00 00       	call   3d69 <printf>
    11d8:	83 c4 10             	add    $0x10,%esp
      exit();
    11db:	e8 0c 2a 00 00       	call   3bec <exit>
    }
    if(fd >= 0)
    11e0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11e4:	78 0e                	js     11f4 <createdelete+0x241>
      close(fd);
    11e6:	83 ec 0c             	sub    $0xc,%esp
    11e9:	ff 75 ec             	pushl  -0x14(%ebp)
    11ec:	e8 23 2a 00 00       	call   3c14 <close>
    11f1:	83 c4 10             	add    $0x10,%esp
  if(pid==0)
    exit();
  else
    wait();

  for(i = 0; i < N; i++){
    11f4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    11f8:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    11fc:	0f 8e d4 fe ff ff    	jle    10d6 <createdelete+0x123>
    }
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    1202:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1209:	eb 33                	jmp    123e <createdelete+0x28b>
    name[0] = 'p';
    120b:	c6 45 cc 70          	movb   $0x70,-0x34(%ebp)
    name[1] = '0' + i;
    120f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1212:	83 c0 30             	add    $0x30,%eax
    1215:	88 45 cd             	mov    %al,-0x33(%ebp)
    unlink(name);
    1218:	83 ec 0c             	sub    $0xc,%esp
    121b:	8d 45 cc             	lea    -0x34(%ebp),%eax
    121e:	50                   	push   %eax
    121f:	e8 18 2a 00 00       	call   3c3c <unlink>
    1224:	83 c4 10             	add    $0x10,%esp
    name[0] = 'c';
    1227:	c6 45 cc 63          	movb   $0x63,-0x34(%ebp)
    unlink(name);
    122b:	83 ec 0c             	sub    $0xc,%esp
    122e:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1231:	50                   	push   %eax
    1232:	e8 05 2a 00 00       	call   3c3c <unlink>
    1237:	83 c4 10             	add    $0x10,%esp
    }
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    123a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    123e:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1242:	7e c7                	jle    120b <createdelete+0x258>
    unlink(name);
    name[0] = 'c';
    unlink(name);
  }

  printf(1, "createdelete ok\n");
    1244:	83 ec 08             	sub    $0x8,%esp
    1247:	68 dc 46 00 00       	push   $0x46dc
    124c:	6a 01                	push   $0x1
    124e:	e8 16 2b 00 00       	call   3d69 <printf>
    1253:	83 c4 10             	add    $0x10,%esp
}
    1256:	c9                   	leave  
    1257:	c3                   	ret    

00001258 <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1258:	55                   	push   %ebp
    1259:	89 e5                	mov    %esp,%ebp
    125b:	83 ec 18             	sub    $0x18,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    125e:	83 ec 08             	sub    $0x8,%esp
    1261:	68 ed 46 00 00       	push   $0x46ed
    1266:	6a 01                	push   $0x1
    1268:	e8 fc 2a 00 00       	call   3d69 <printf>
    126d:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1270:	83 ec 08             	sub    $0x8,%esp
    1273:	68 02 02 00 00       	push   $0x202
    1278:	68 fe 46 00 00       	push   $0x46fe
    127d:	e8 aa 29 00 00       	call   3c2c <open>
    1282:	83 c4 10             	add    $0x10,%esp
    1285:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1288:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    128c:	79 17                	jns    12a5 <unlinkread+0x4d>
    printf(1, "create unlinkread failed\n");
    128e:	83 ec 08             	sub    $0x8,%esp
    1291:	68 09 47 00 00       	push   $0x4709
    1296:	6a 01                	push   $0x1
    1298:	e8 cc 2a 00 00       	call   3d69 <printf>
    129d:	83 c4 10             	add    $0x10,%esp
    exit();
    12a0:	e8 47 29 00 00       	call   3bec <exit>
  }
  write(fd, "hello", 5);
    12a5:	83 ec 04             	sub    $0x4,%esp
    12a8:	6a 05                	push   $0x5
    12aa:	68 23 47 00 00       	push   $0x4723
    12af:	ff 75 f4             	pushl  -0xc(%ebp)
    12b2:	e8 55 29 00 00       	call   3c0c <write>
    12b7:	83 c4 10             	add    $0x10,%esp
  close(fd);
    12ba:	83 ec 0c             	sub    $0xc,%esp
    12bd:	ff 75 f4             	pushl  -0xc(%ebp)
    12c0:	e8 4f 29 00 00       	call   3c14 <close>
    12c5:	83 c4 10             	add    $0x10,%esp

  fd = open("unlinkread", O_RDWR);
    12c8:	83 ec 08             	sub    $0x8,%esp
    12cb:	6a 02                	push   $0x2
    12cd:	68 fe 46 00 00       	push   $0x46fe
    12d2:	e8 55 29 00 00       	call   3c2c <open>
    12d7:	83 c4 10             	add    $0x10,%esp
    12da:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    12dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12e1:	79 17                	jns    12fa <unlinkread+0xa2>
    printf(1, "open unlinkread failed\n");
    12e3:	83 ec 08             	sub    $0x8,%esp
    12e6:	68 29 47 00 00       	push   $0x4729
    12eb:	6a 01                	push   $0x1
    12ed:	e8 77 2a 00 00       	call   3d69 <printf>
    12f2:	83 c4 10             	add    $0x10,%esp
    exit();
    12f5:	e8 f2 28 00 00       	call   3bec <exit>
  }
  if(unlink("unlinkread") != 0){
    12fa:	83 ec 0c             	sub    $0xc,%esp
    12fd:	68 fe 46 00 00       	push   $0x46fe
    1302:	e8 35 29 00 00       	call   3c3c <unlink>
    1307:	83 c4 10             	add    $0x10,%esp
    130a:	85 c0                	test   %eax,%eax
    130c:	74 17                	je     1325 <unlinkread+0xcd>
    printf(1, "unlink unlinkread failed\n");
    130e:	83 ec 08             	sub    $0x8,%esp
    1311:	68 41 47 00 00       	push   $0x4741
    1316:	6a 01                	push   $0x1
    1318:	e8 4c 2a 00 00       	call   3d69 <printf>
    131d:	83 c4 10             	add    $0x10,%esp
    exit();
    1320:	e8 c7 28 00 00       	call   3bec <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1325:	83 ec 08             	sub    $0x8,%esp
    1328:	68 02 02 00 00       	push   $0x202
    132d:	68 fe 46 00 00       	push   $0x46fe
    1332:	e8 f5 28 00 00       	call   3c2c <open>
    1337:	83 c4 10             	add    $0x10,%esp
    133a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  write(fd1, "yyy", 3);
    133d:	83 ec 04             	sub    $0x4,%esp
    1340:	6a 03                	push   $0x3
    1342:	68 5b 47 00 00       	push   $0x475b
    1347:	ff 75 f0             	pushl  -0x10(%ebp)
    134a:	e8 bd 28 00 00       	call   3c0c <write>
    134f:	83 c4 10             	add    $0x10,%esp
  close(fd1);
    1352:	83 ec 0c             	sub    $0xc,%esp
    1355:	ff 75 f0             	pushl  -0x10(%ebp)
    1358:	e8 b7 28 00 00       	call   3c14 <close>
    135d:	83 c4 10             	add    $0x10,%esp

  if(read(fd, buf, sizeof(buf)) != 5){
    1360:	83 ec 04             	sub    $0x4,%esp
    1363:	68 00 20 00 00       	push   $0x2000
    1368:	68 c0 86 00 00       	push   $0x86c0
    136d:	ff 75 f4             	pushl  -0xc(%ebp)
    1370:	e8 8f 28 00 00       	call   3c04 <read>
    1375:	83 c4 10             	add    $0x10,%esp
    1378:	83 f8 05             	cmp    $0x5,%eax
    137b:	74 17                	je     1394 <unlinkread+0x13c>
    printf(1, "unlinkread read failed");
    137d:	83 ec 08             	sub    $0x8,%esp
    1380:	68 5f 47 00 00       	push   $0x475f
    1385:	6a 01                	push   $0x1
    1387:	e8 dd 29 00 00       	call   3d69 <printf>
    138c:	83 c4 10             	add    $0x10,%esp
    exit();
    138f:	e8 58 28 00 00       	call   3bec <exit>
  }
  if(buf[0] != 'h'){
    1394:	0f b6 05 c0 86 00 00 	movzbl 0x86c0,%eax
    139b:	3c 68                	cmp    $0x68,%al
    139d:	74 17                	je     13b6 <unlinkread+0x15e>
    printf(1, "unlinkread wrong data\n");
    139f:	83 ec 08             	sub    $0x8,%esp
    13a2:	68 76 47 00 00       	push   $0x4776
    13a7:	6a 01                	push   $0x1
    13a9:	e8 bb 29 00 00       	call   3d69 <printf>
    13ae:	83 c4 10             	add    $0x10,%esp
    exit();
    13b1:	e8 36 28 00 00       	call   3bec <exit>
  }
  if(write(fd, buf, 10) != 10){
    13b6:	83 ec 04             	sub    $0x4,%esp
    13b9:	6a 0a                	push   $0xa
    13bb:	68 c0 86 00 00       	push   $0x86c0
    13c0:	ff 75 f4             	pushl  -0xc(%ebp)
    13c3:	e8 44 28 00 00       	call   3c0c <write>
    13c8:	83 c4 10             	add    $0x10,%esp
    13cb:	83 f8 0a             	cmp    $0xa,%eax
    13ce:	74 17                	je     13e7 <unlinkread+0x18f>
    printf(1, "unlinkread write failed\n");
    13d0:	83 ec 08             	sub    $0x8,%esp
    13d3:	68 8d 47 00 00       	push   $0x478d
    13d8:	6a 01                	push   $0x1
    13da:	e8 8a 29 00 00       	call   3d69 <printf>
    13df:	83 c4 10             	add    $0x10,%esp
    exit();
    13e2:	e8 05 28 00 00       	call   3bec <exit>
  }
  close(fd);
    13e7:	83 ec 0c             	sub    $0xc,%esp
    13ea:	ff 75 f4             	pushl  -0xc(%ebp)
    13ed:	e8 22 28 00 00       	call   3c14 <close>
    13f2:	83 c4 10             	add    $0x10,%esp
  unlink("unlinkread");
    13f5:	83 ec 0c             	sub    $0xc,%esp
    13f8:	68 fe 46 00 00       	push   $0x46fe
    13fd:	e8 3a 28 00 00       	call   3c3c <unlink>
    1402:	83 c4 10             	add    $0x10,%esp
  printf(1, "unlinkread ok\n");
    1405:	83 ec 08             	sub    $0x8,%esp
    1408:	68 a6 47 00 00       	push   $0x47a6
    140d:	6a 01                	push   $0x1
    140f:	e8 55 29 00 00       	call   3d69 <printf>
    1414:	83 c4 10             	add    $0x10,%esp
}
    1417:	c9                   	leave  
    1418:	c3                   	ret    

00001419 <linktest>:

void
linktest(void)
{
    1419:	55                   	push   %ebp
    141a:	89 e5                	mov    %esp,%ebp
    141c:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "linktest\n");
    141f:	83 ec 08             	sub    $0x8,%esp
    1422:	68 b5 47 00 00       	push   $0x47b5
    1427:	6a 01                	push   $0x1
    1429:	e8 3b 29 00 00       	call   3d69 <printf>
    142e:	83 c4 10             	add    $0x10,%esp

  unlink("lf1");
    1431:	83 ec 0c             	sub    $0xc,%esp
    1434:	68 bf 47 00 00       	push   $0x47bf
    1439:	e8 fe 27 00 00       	call   3c3c <unlink>
    143e:	83 c4 10             	add    $0x10,%esp
  unlink("lf2");
    1441:	83 ec 0c             	sub    $0xc,%esp
    1444:	68 c3 47 00 00       	push   $0x47c3
    1449:	e8 ee 27 00 00       	call   3c3c <unlink>
    144e:	83 c4 10             	add    $0x10,%esp

  fd = open("lf1", O_CREATE|O_RDWR);
    1451:	83 ec 08             	sub    $0x8,%esp
    1454:	68 02 02 00 00       	push   $0x202
    1459:	68 bf 47 00 00       	push   $0x47bf
    145e:	e8 c9 27 00 00       	call   3c2c <open>
    1463:	83 c4 10             	add    $0x10,%esp
    1466:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1469:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    146d:	79 17                	jns    1486 <linktest+0x6d>
    printf(1, "create lf1 failed\n");
    146f:	83 ec 08             	sub    $0x8,%esp
    1472:	68 c7 47 00 00       	push   $0x47c7
    1477:	6a 01                	push   $0x1
    1479:	e8 eb 28 00 00       	call   3d69 <printf>
    147e:	83 c4 10             	add    $0x10,%esp
    exit();
    1481:	e8 66 27 00 00       	call   3bec <exit>
  }
  if(write(fd, "hello", 5) != 5){
    1486:	83 ec 04             	sub    $0x4,%esp
    1489:	6a 05                	push   $0x5
    148b:	68 23 47 00 00       	push   $0x4723
    1490:	ff 75 f4             	pushl  -0xc(%ebp)
    1493:	e8 74 27 00 00       	call   3c0c <write>
    1498:	83 c4 10             	add    $0x10,%esp
    149b:	83 f8 05             	cmp    $0x5,%eax
    149e:	74 17                	je     14b7 <linktest+0x9e>
    printf(1, "write lf1 failed\n");
    14a0:	83 ec 08             	sub    $0x8,%esp
    14a3:	68 da 47 00 00       	push   $0x47da
    14a8:	6a 01                	push   $0x1
    14aa:	e8 ba 28 00 00       	call   3d69 <printf>
    14af:	83 c4 10             	add    $0x10,%esp
    exit();
    14b2:	e8 35 27 00 00       	call   3bec <exit>
  }
  close(fd);
    14b7:	83 ec 0c             	sub    $0xc,%esp
    14ba:	ff 75 f4             	pushl  -0xc(%ebp)
    14bd:	e8 52 27 00 00       	call   3c14 <close>
    14c2:	83 c4 10             	add    $0x10,%esp

  if(link("lf1", "lf2") < 0){
    14c5:	83 ec 08             	sub    $0x8,%esp
    14c8:	68 c3 47 00 00       	push   $0x47c3
    14cd:	68 bf 47 00 00       	push   $0x47bf
    14d2:	e8 75 27 00 00       	call   3c4c <link>
    14d7:	83 c4 10             	add    $0x10,%esp
    14da:	85 c0                	test   %eax,%eax
    14dc:	79 17                	jns    14f5 <linktest+0xdc>
    printf(1, "link lf1 lf2 failed\n");
    14de:	83 ec 08             	sub    $0x8,%esp
    14e1:	68 ec 47 00 00       	push   $0x47ec
    14e6:	6a 01                	push   $0x1
    14e8:	e8 7c 28 00 00       	call   3d69 <printf>
    14ed:	83 c4 10             	add    $0x10,%esp
    exit();
    14f0:	e8 f7 26 00 00       	call   3bec <exit>
  }
  unlink("lf1");
    14f5:	83 ec 0c             	sub    $0xc,%esp
    14f8:	68 bf 47 00 00       	push   $0x47bf
    14fd:	e8 3a 27 00 00       	call   3c3c <unlink>
    1502:	83 c4 10             	add    $0x10,%esp

  if(open("lf1", 0) >= 0){
    1505:	83 ec 08             	sub    $0x8,%esp
    1508:	6a 00                	push   $0x0
    150a:	68 bf 47 00 00       	push   $0x47bf
    150f:	e8 18 27 00 00       	call   3c2c <open>
    1514:	83 c4 10             	add    $0x10,%esp
    1517:	85 c0                	test   %eax,%eax
    1519:	78 17                	js     1532 <linktest+0x119>
    printf(1, "unlinked lf1 but it is still there!\n");
    151b:	83 ec 08             	sub    $0x8,%esp
    151e:	68 04 48 00 00       	push   $0x4804
    1523:	6a 01                	push   $0x1
    1525:	e8 3f 28 00 00       	call   3d69 <printf>
    152a:	83 c4 10             	add    $0x10,%esp
    exit();
    152d:	e8 ba 26 00 00       	call   3bec <exit>
  }

  fd = open("lf2", 0);
    1532:	83 ec 08             	sub    $0x8,%esp
    1535:	6a 00                	push   $0x0
    1537:	68 c3 47 00 00       	push   $0x47c3
    153c:	e8 eb 26 00 00       	call   3c2c <open>
    1541:	83 c4 10             	add    $0x10,%esp
    1544:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1547:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    154b:	79 17                	jns    1564 <linktest+0x14b>
    printf(1, "open lf2 failed\n");
    154d:	83 ec 08             	sub    $0x8,%esp
    1550:	68 29 48 00 00       	push   $0x4829
    1555:	6a 01                	push   $0x1
    1557:	e8 0d 28 00 00       	call   3d69 <printf>
    155c:	83 c4 10             	add    $0x10,%esp
    exit();
    155f:	e8 88 26 00 00       	call   3bec <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    1564:	83 ec 04             	sub    $0x4,%esp
    1567:	68 00 20 00 00       	push   $0x2000
    156c:	68 c0 86 00 00       	push   $0x86c0
    1571:	ff 75 f4             	pushl  -0xc(%ebp)
    1574:	e8 8b 26 00 00       	call   3c04 <read>
    1579:	83 c4 10             	add    $0x10,%esp
    157c:	83 f8 05             	cmp    $0x5,%eax
    157f:	74 17                	je     1598 <linktest+0x17f>
    printf(1, "read lf2 failed\n");
    1581:	83 ec 08             	sub    $0x8,%esp
    1584:	68 3a 48 00 00       	push   $0x483a
    1589:	6a 01                	push   $0x1
    158b:	e8 d9 27 00 00       	call   3d69 <printf>
    1590:	83 c4 10             	add    $0x10,%esp
    exit();
    1593:	e8 54 26 00 00       	call   3bec <exit>
  }
  close(fd);
    1598:	83 ec 0c             	sub    $0xc,%esp
    159b:	ff 75 f4             	pushl  -0xc(%ebp)
    159e:	e8 71 26 00 00       	call   3c14 <close>
    15a3:	83 c4 10             	add    $0x10,%esp

  if(link("lf2", "lf2") >= 0){
    15a6:	83 ec 08             	sub    $0x8,%esp
    15a9:	68 c3 47 00 00       	push   $0x47c3
    15ae:	68 c3 47 00 00       	push   $0x47c3
    15b3:	e8 94 26 00 00       	call   3c4c <link>
    15b8:	83 c4 10             	add    $0x10,%esp
    15bb:	85 c0                	test   %eax,%eax
    15bd:	78 17                	js     15d6 <linktest+0x1bd>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    15bf:	83 ec 08             	sub    $0x8,%esp
    15c2:	68 4b 48 00 00       	push   $0x484b
    15c7:	6a 01                	push   $0x1
    15c9:	e8 9b 27 00 00       	call   3d69 <printf>
    15ce:	83 c4 10             	add    $0x10,%esp
    exit();
    15d1:	e8 16 26 00 00       	call   3bec <exit>
  }

  unlink("lf2");
    15d6:	83 ec 0c             	sub    $0xc,%esp
    15d9:	68 c3 47 00 00       	push   $0x47c3
    15de:	e8 59 26 00 00       	call   3c3c <unlink>
    15e3:	83 c4 10             	add    $0x10,%esp
  if(link("lf2", "lf1") >= 0){
    15e6:	83 ec 08             	sub    $0x8,%esp
    15e9:	68 bf 47 00 00       	push   $0x47bf
    15ee:	68 c3 47 00 00       	push   $0x47c3
    15f3:	e8 54 26 00 00       	call   3c4c <link>
    15f8:	83 c4 10             	add    $0x10,%esp
    15fb:	85 c0                	test   %eax,%eax
    15fd:	78 17                	js     1616 <linktest+0x1fd>
    printf(1, "link non-existant succeeded! oops\n");
    15ff:	83 ec 08             	sub    $0x8,%esp
    1602:	68 6c 48 00 00       	push   $0x486c
    1607:	6a 01                	push   $0x1
    1609:	e8 5b 27 00 00       	call   3d69 <printf>
    160e:	83 c4 10             	add    $0x10,%esp
    exit();
    1611:	e8 d6 25 00 00       	call   3bec <exit>
  }

  if(link(".", "lf1") >= 0){
    1616:	83 ec 08             	sub    $0x8,%esp
    1619:	68 bf 47 00 00       	push   $0x47bf
    161e:	68 8f 48 00 00       	push   $0x488f
    1623:	e8 24 26 00 00       	call   3c4c <link>
    1628:	83 c4 10             	add    $0x10,%esp
    162b:	85 c0                	test   %eax,%eax
    162d:	78 17                	js     1646 <linktest+0x22d>
    printf(1, "link . lf1 succeeded! oops\n");
    162f:	83 ec 08             	sub    $0x8,%esp
    1632:	68 91 48 00 00       	push   $0x4891
    1637:	6a 01                	push   $0x1
    1639:	e8 2b 27 00 00       	call   3d69 <printf>
    163e:	83 c4 10             	add    $0x10,%esp
    exit();
    1641:	e8 a6 25 00 00       	call   3bec <exit>
  }

  printf(1, "linktest ok\n");
    1646:	83 ec 08             	sub    $0x8,%esp
    1649:	68 ad 48 00 00       	push   $0x48ad
    164e:	6a 01                	push   $0x1
    1650:	e8 14 27 00 00       	call   3d69 <printf>
    1655:	83 c4 10             	add    $0x10,%esp
}
    1658:	c9                   	leave  
    1659:	c3                   	ret    

0000165a <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    165a:	55                   	push   %ebp
    165b:	89 e5                	mov    %esp,%ebp
    165d:	83 ec 58             	sub    $0x58,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    1660:	83 ec 08             	sub    $0x8,%esp
    1663:	68 ba 48 00 00       	push   $0x48ba
    1668:	6a 01                	push   $0x1
    166a:	e8 fa 26 00 00       	call   3d69 <printf>
    166f:	83 c4 10             	add    $0x10,%esp
  file[0] = 'C';
    1672:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    1676:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  for(i = 0; i < 40; i++){
    167a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1681:	e9 fc 00 00 00       	jmp    1782 <concreate+0x128>
    file[1] = '0' + i;
    1686:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1689:	83 c0 30             	add    $0x30,%eax
    168c:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    168f:	83 ec 0c             	sub    $0xc,%esp
    1692:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1695:	50                   	push   %eax
    1696:	e8 a1 25 00 00       	call   3c3c <unlink>
    169b:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    169e:	e8 41 25 00 00       	call   3be4 <fork>
    16a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid && (i % 3) == 1){
    16a6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16aa:	74 3b                	je     16e7 <concreate+0x8d>
    16ac:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16af:	ba 56 55 55 55       	mov    $0x55555556,%edx
    16b4:	89 c8                	mov    %ecx,%eax
    16b6:	f7 ea                	imul   %edx
    16b8:	89 c8                	mov    %ecx,%eax
    16ba:	c1 f8 1f             	sar    $0x1f,%eax
    16bd:	29 c2                	sub    %eax,%edx
    16bf:	89 d0                	mov    %edx,%eax
    16c1:	01 c0                	add    %eax,%eax
    16c3:	01 d0                	add    %edx,%eax
    16c5:	29 c1                	sub    %eax,%ecx
    16c7:	89 ca                	mov    %ecx,%edx
    16c9:	83 fa 01             	cmp    $0x1,%edx
    16cc:	75 19                	jne    16e7 <concreate+0x8d>
      link("C0", file);
    16ce:	83 ec 08             	sub    $0x8,%esp
    16d1:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    16d4:	50                   	push   %eax
    16d5:	68 ca 48 00 00       	push   $0x48ca
    16da:	e8 6d 25 00 00       	call   3c4c <link>
    16df:	83 c4 10             	add    $0x10,%esp
    16e2:	e9 87 00 00 00       	jmp    176e <concreate+0x114>
    } else if(pid == 0 && (i % 5) == 1){
    16e7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16eb:	75 3b                	jne    1728 <concreate+0xce>
    16ed:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16f0:	ba 67 66 66 66       	mov    $0x66666667,%edx
    16f5:	89 c8                	mov    %ecx,%eax
    16f7:	f7 ea                	imul   %edx
    16f9:	d1 fa                	sar    %edx
    16fb:	89 c8                	mov    %ecx,%eax
    16fd:	c1 f8 1f             	sar    $0x1f,%eax
    1700:	29 c2                	sub    %eax,%edx
    1702:	89 d0                	mov    %edx,%eax
    1704:	c1 e0 02             	shl    $0x2,%eax
    1707:	01 d0                	add    %edx,%eax
    1709:	29 c1                	sub    %eax,%ecx
    170b:	89 ca                	mov    %ecx,%edx
    170d:	83 fa 01             	cmp    $0x1,%edx
    1710:	75 16                	jne    1728 <concreate+0xce>
      link("C0", file);
    1712:	83 ec 08             	sub    $0x8,%esp
    1715:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1718:	50                   	push   %eax
    1719:	68 ca 48 00 00       	push   $0x48ca
    171e:	e8 29 25 00 00       	call   3c4c <link>
    1723:	83 c4 10             	add    $0x10,%esp
    1726:	eb 46                	jmp    176e <concreate+0x114>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    1728:	83 ec 08             	sub    $0x8,%esp
    172b:	68 02 02 00 00       	push   $0x202
    1730:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1733:	50                   	push   %eax
    1734:	e8 f3 24 00 00       	call   3c2c <open>
    1739:	83 c4 10             	add    $0x10,%esp
    173c:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(fd < 0){
    173f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1743:	79 1b                	jns    1760 <concreate+0x106>
        printf(1, "concreate create %s failed\n", file);
    1745:	83 ec 04             	sub    $0x4,%esp
    1748:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    174b:	50                   	push   %eax
    174c:	68 cd 48 00 00       	push   $0x48cd
    1751:	6a 01                	push   $0x1
    1753:	e8 11 26 00 00       	call   3d69 <printf>
    1758:	83 c4 10             	add    $0x10,%esp
        exit();
    175b:	e8 8c 24 00 00       	call   3bec <exit>
      }
      close(fd);
    1760:	83 ec 0c             	sub    $0xc,%esp
    1763:	ff 75 e8             	pushl  -0x18(%ebp)
    1766:	e8 a9 24 00 00       	call   3c14 <close>
    176b:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    176e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1772:	75 05                	jne    1779 <concreate+0x11f>
      exit();
    1774:	e8 73 24 00 00       	call   3bec <exit>
    else
      wait();
    1779:	e8 76 24 00 00       	call   3bf4 <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    177e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1782:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1786:	0f 8e fa fe ff ff    	jle    1686 <concreate+0x2c>
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    178c:	83 ec 04             	sub    $0x4,%esp
    178f:	6a 28                	push   $0x28
    1791:	6a 00                	push   $0x0
    1793:	8d 45 bd             	lea    -0x43(%ebp),%eax
    1796:	50                   	push   %eax
    1797:	e8 b6 22 00 00       	call   3a52 <memset>
    179c:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    179f:	83 ec 08             	sub    $0x8,%esp
    17a2:	6a 00                	push   $0x0
    17a4:	68 8f 48 00 00       	push   $0x488f
    17a9:	e8 7e 24 00 00       	call   3c2c <open>
    17ae:	83 c4 10             	add    $0x10,%esp
    17b1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  n = 0;
    17b4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    17bb:	e9 93 00 00 00       	jmp    1853 <concreate+0x1f9>
    if(de.inum == 0)
    17c0:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    17c4:	66 85 c0             	test   %ax,%ax
    17c7:	75 05                	jne    17ce <concreate+0x174>
      continue;
    17c9:	e9 85 00 00 00       	jmp    1853 <concreate+0x1f9>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    17ce:	0f b6 45 ae          	movzbl -0x52(%ebp),%eax
    17d2:	3c 43                	cmp    $0x43,%al
    17d4:	75 7d                	jne    1853 <concreate+0x1f9>
    17d6:	0f b6 45 b0          	movzbl -0x50(%ebp),%eax
    17da:	84 c0                	test   %al,%al
    17dc:	75 75                	jne    1853 <concreate+0x1f9>
      i = de.name[1] - '0';
    17de:	0f b6 45 af          	movzbl -0x51(%ebp),%eax
    17e2:	0f be c0             	movsbl %al,%eax
    17e5:	83 e8 30             	sub    $0x30,%eax
    17e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if(i < 0 || i >= sizeof(fa)){
    17eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17ef:	78 08                	js     17f9 <concreate+0x19f>
    17f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f4:	83 f8 27             	cmp    $0x27,%eax
    17f7:	76 1e                	jbe    1817 <concreate+0x1bd>
        printf(1, "concreate weird file %s\n", de.name);
    17f9:	83 ec 04             	sub    $0x4,%esp
    17fc:	8d 45 ac             	lea    -0x54(%ebp),%eax
    17ff:	83 c0 02             	add    $0x2,%eax
    1802:	50                   	push   %eax
    1803:	68 e9 48 00 00       	push   $0x48e9
    1808:	6a 01                	push   $0x1
    180a:	e8 5a 25 00 00       	call   3d69 <printf>
    180f:	83 c4 10             	add    $0x10,%esp
        exit();
    1812:	e8 d5 23 00 00       	call   3bec <exit>
      }
      if(fa[i]){
    1817:	8d 55 bd             	lea    -0x43(%ebp),%edx
    181a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181d:	01 d0                	add    %edx,%eax
    181f:	0f b6 00             	movzbl (%eax),%eax
    1822:	84 c0                	test   %al,%al
    1824:	74 1e                	je     1844 <concreate+0x1ea>
        printf(1, "concreate duplicate file %s\n", de.name);
    1826:	83 ec 04             	sub    $0x4,%esp
    1829:	8d 45 ac             	lea    -0x54(%ebp),%eax
    182c:	83 c0 02             	add    $0x2,%eax
    182f:	50                   	push   %eax
    1830:	68 02 49 00 00       	push   $0x4902
    1835:	6a 01                	push   $0x1
    1837:	e8 2d 25 00 00       	call   3d69 <printf>
    183c:	83 c4 10             	add    $0x10,%esp
        exit();
    183f:	e8 a8 23 00 00       	call   3bec <exit>
      }
      fa[i] = 1;
    1844:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1847:	8b 45 f4             	mov    -0xc(%ebp),%eax
    184a:	01 d0                	add    %edx,%eax
    184c:	c6 00 01             	movb   $0x1,(%eax)
      n++;
    184f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  }

  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    1853:	83 ec 04             	sub    $0x4,%esp
    1856:	6a 10                	push   $0x10
    1858:	8d 45 ac             	lea    -0x54(%ebp),%eax
    185b:	50                   	push   %eax
    185c:	ff 75 e8             	pushl  -0x18(%ebp)
    185f:	e8 a0 23 00 00       	call   3c04 <read>
    1864:	83 c4 10             	add    $0x10,%esp
    1867:	85 c0                	test   %eax,%eax
    1869:	0f 8f 51 ff ff ff    	jg     17c0 <concreate+0x166>
      }
      fa[i] = 1;
      n++;
    }
  }
  close(fd);
    186f:	83 ec 0c             	sub    $0xc,%esp
    1872:	ff 75 e8             	pushl  -0x18(%ebp)
    1875:	e8 9a 23 00 00       	call   3c14 <close>
    187a:	83 c4 10             	add    $0x10,%esp

  if(n != 40){
    187d:	83 7d f0 28          	cmpl   $0x28,-0x10(%ebp)
    1881:	74 17                	je     189a <concreate+0x240>
    printf(1, "concreate not enough files in directory listing\n");
    1883:	83 ec 08             	sub    $0x8,%esp
    1886:	68 20 49 00 00       	push   $0x4920
    188b:	6a 01                	push   $0x1
    188d:	e8 d7 24 00 00       	call   3d69 <printf>
    1892:	83 c4 10             	add    $0x10,%esp
    exit();
    1895:	e8 52 23 00 00       	call   3bec <exit>
  }

  for(i = 0; i < 40; i++){
    189a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    18a1:	e9 45 01 00 00       	jmp    19eb <concreate+0x391>
    file[1] = '0' + i;
    18a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a9:	83 c0 30             	add    $0x30,%eax
    18ac:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    18af:	e8 30 23 00 00       	call   3be4 <fork>
    18b4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid < 0){
    18b7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18bb:	79 17                	jns    18d4 <concreate+0x27a>
      printf(1, "fork failed\n");
    18bd:	83 ec 08             	sub    $0x8,%esp
    18c0:	68 0d 45 00 00       	push   $0x450d
    18c5:	6a 01                	push   $0x1
    18c7:	e8 9d 24 00 00       	call   3d69 <printf>
    18cc:	83 c4 10             	add    $0x10,%esp
      exit();
    18cf:	e8 18 23 00 00       	call   3bec <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    18d4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    18d7:	ba 56 55 55 55       	mov    $0x55555556,%edx
    18dc:	89 c8                	mov    %ecx,%eax
    18de:	f7 ea                	imul   %edx
    18e0:	89 c8                	mov    %ecx,%eax
    18e2:	c1 f8 1f             	sar    $0x1f,%eax
    18e5:	29 c2                	sub    %eax,%edx
    18e7:	89 d0                	mov    %edx,%eax
    18e9:	89 c2                	mov    %eax,%edx
    18eb:	01 d2                	add    %edx,%edx
    18ed:	01 c2                	add    %eax,%edx
    18ef:	89 c8                	mov    %ecx,%eax
    18f1:	29 d0                	sub    %edx,%eax
    18f3:	85 c0                	test   %eax,%eax
    18f5:	75 06                	jne    18fd <concreate+0x2a3>
    18f7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18fb:	74 28                	je     1925 <concreate+0x2cb>
       ((i % 3) == 1 && pid != 0)){
    18fd:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1900:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1905:	89 c8                	mov    %ecx,%eax
    1907:	f7 ea                	imul   %edx
    1909:	89 c8                	mov    %ecx,%eax
    190b:	c1 f8 1f             	sar    $0x1f,%eax
    190e:	29 c2                	sub    %eax,%edx
    1910:	89 d0                	mov    %edx,%eax
    1912:	01 c0                	add    %eax,%eax
    1914:	01 d0                	add    %edx,%eax
    1916:	29 c1                	sub    %eax,%ecx
    1918:	89 ca                	mov    %ecx,%edx
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    191a:	83 fa 01             	cmp    $0x1,%edx
    191d:	75 7c                	jne    199b <concreate+0x341>
       ((i % 3) == 1 && pid != 0)){
    191f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1923:	74 76                	je     199b <concreate+0x341>
      close(open(file, 0));
    1925:	83 ec 08             	sub    $0x8,%esp
    1928:	6a 00                	push   $0x0
    192a:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    192d:	50                   	push   %eax
    192e:	e8 f9 22 00 00       	call   3c2c <open>
    1933:	83 c4 10             	add    $0x10,%esp
    1936:	83 ec 0c             	sub    $0xc,%esp
    1939:	50                   	push   %eax
    193a:	e8 d5 22 00 00       	call   3c14 <close>
    193f:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1942:	83 ec 08             	sub    $0x8,%esp
    1945:	6a 00                	push   $0x0
    1947:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    194a:	50                   	push   %eax
    194b:	e8 dc 22 00 00       	call   3c2c <open>
    1950:	83 c4 10             	add    $0x10,%esp
    1953:	83 ec 0c             	sub    $0xc,%esp
    1956:	50                   	push   %eax
    1957:	e8 b8 22 00 00       	call   3c14 <close>
    195c:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    195f:	83 ec 08             	sub    $0x8,%esp
    1962:	6a 00                	push   $0x0
    1964:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1967:	50                   	push   %eax
    1968:	e8 bf 22 00 00       	call   3c2c <open>
    196d:	83 c4 10             	add    $0x10,%esp
    1970:	83 ec 0c             	sub    $0xc,%esp
    1973:	50                   	push   %eax
    1974:	e8 9b 22 00 00       	call   3c14 <close>
    1979:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    197c:	83 ec 08             	sub    $0x8,%esp
    197f:	6a 00                	push   $0x0
    1981:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1984:	50                   	push   %eax
    1985:	e8 a2 22 00 00       	call   3c2c <open>
    198a:	83 c4 10             	add    $0x10,%esp
    198d:	83 ec 0c             	sub    $0xc,%esp
    1990:	50                   	push   %eax
    1991:	e8 7e 22 00 00       	call   3c14 <close>
    1996:	83 c4 10             	add    $0x10,%esp
    1999:	eb 3c                	jmp    19d7 <concreate+0x37d>
    } else {
      unlink(file);
    199b:	83 ec 0c             	sub    $0xc,%esp
    199e:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19a1:	50                   	push   %eax
    19a2:	e8 95 22 00 00       	call   3c3c <unlink>
    19a7:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    19aa:	83 ec 0c             	sub    $0xc,%esp
    19ad:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19b0:	50                   	push   %eax
    19b1:	e8 86 22 00 00       	call   3c3c <unlink>
    19b6:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    19b9:	83 ec 0c             	sub    $0xc,%esp
    19bc:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19bf:	50                   	push   %eax
    19c0:	e8 77 22 00 00       	call   3c3c <unlink>
    19c5:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    19c8:	83 ec 0c             	sub    $0xc,%esp
    19cb:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19ce:	50                   	push   %eax
    19cf:	e8 68 22 00 00       	call   3c3c <unlink>
    19d4:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    19d7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19db:	75 05                	jne    19e2 <concreate+0x388>
      exit();
    19dd:	e8 0a 22 00 00       	call   3bec <exit>
    else
      wait();
    19e2:	e8 0d 22 00 00       	call   3bf4 <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    19e7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    19eb:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    19ef:	0f 8e b1 fe ff ff    	jle    18a6 <concreate+0x24c>
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    19f5:	83 ec 08             	sub    $0x8,%esp
    19f8:	68 51 49 00 00       	push   $0x4951
    19fd:	6a 01                	push   $0x1
    19ff:	e8 65 23 00 00       	call   3d69 <printf>
    1a04:	83 c4 10             	add    $0x10,%esp
}
    1a07:	c9                   	leave  
    1a08:	c3                   	ret    

00001a09 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1a09:	55                   	push   %ebp
    1a0a:	89 e5                	mov    %esp,%ebp
    1a0c:	83 ec 18             	sub    $0x18,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1a0f:	83 ec 08             	sub    $0x8,%esp
    1a12:	68 5f 49 00 00       	push   $0x495f
    1a17:	6a 01                	push   $0x1
    1a19:	e8 4b 23 00 00       	call   3d69 <printf>
    1a1e:	83 c4 10             	add    $0x10,%esp

  unlink("x");
    1a21:	83 ec 0c             	sub    $0xc,%esp
    1a24:	68 c6 44 00 00       	push   $0x44c6
    1a29:	e8 0e 22 00 00       	call   3c3c <unlink>
    1a2e:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    1a31:	e8 ae 21 00 00       	call   3be4 <fork>
    1a36:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid < 0){
    1a39:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a3d:	79 17                	jns    1a56 <linkunlink+0x4d>
    printf(1, "fork failed\n");
    1a3f:	83 ec 08             	sub    $0x8,%esp
    1a42:	68 0d 45 00 00       	push   $0x450d
    1a47:	6a 01                	push   $0x1
    1a49:	e8 1b 23 00 00       	call   3d69 <printf>
    1a4e:	83 c4 10             	add    $0x10,%esp
    exit();
    1a51:	e8 96 21 00 00       	call   3bec <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    1a56:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a5a:	74 07                	je     1a63 <linkunlink+0x5a>
    1a5c:	b8 01 00 00 00       	mov    $0x1,%eax
    1a61:	eb 05                	jmp    1a68 <linkunlink+0x5f>
    1a63:	b8 61 00 00 00       	mov    $0x61,%eax
    1a68:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 100; i++){
    1a6b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1a72:	e9 9a 00 00 00       	jmp    1b11 <linkunlink+0x108>
    x = x * 1103515245 + 12345;
    1a77:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a7a:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    1a80:	05 39 30 00 00       	add    $0x3039,%eax
    1a85:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((x % 3) == 0){
    1a88:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1a8b:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1a90:	89 c8                	mov    %ecx,%eax
    1a92:	f7 e2                	mul    %edx
    1a94:	89 d0                	mov    %edx,%eax
    1a96:	d1 e8                	shr    %eax
    1a98:	89 c2                	mov    %eax,%edx
    1a9a:	01 d2                	add    %edx,%edx
    1a9c:	01 c2                	add    %eax,%edx
    1a9e:	89 c8                	mov    %ecx,%eax
    1aa0:	29 d0                	sub    %edx,%eax
    1aa2:	85 c0                	test   %eax,%eax
    1aa4:	75 23                	jne    1ac9 <linkunlink+0xc0>
      close(open("x", O_RDWR | O_CREATE));
    1aa6:	83 ec 08             	sub    $0x8,%esp
    1aa9:	68 02 02 00 00       	push   $0x202
    1aae:	68 c6 44 00 00       	push   $0x44c6
    1ab3:	e8 74 21 00 00       	call   3c2c <open>
    1ab8:	83 c4 10             	add    $0x10,%esp
    1abb:	83 ec 0c             	sub    $0xc,%esp
    1abe:	50                   	push   %eax
    1abf:	e8 50 21 00 00       	call   3c14 <close>
    1ac4:	83 c4 10             	add    $0x10,%esp
    1ac7:	eb 44                	jmp    1b0d <linkunlink+0x104>
    } else if((x % 3) == 1){
    1ac9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1acc:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1ad1:	89 c8                	mov    %ecx,%eax
    1ad3:	f7 e2                	mul    %edx
    1ad5:	d1 ea                	shr    %edx
    1ad7:	89 d0                	mov    %edx,%eax
    1ad9:	01 c0                	add    %eax,%eax
    1adb:	01 d0                	add    %edx,%eax
    1add:	29 c1                	sub    %eax,%ecx
    1adf:	89 ca                	mov    %ecx,%edx
    1ae1:	83 fa 01             	cmp    $0x1,%edx
    1ae4:	75 17                	jne    1afd <linkunlink+0xf4>
      link("cat", "x");
    1ae6:	83 ec 08             	sub    $0x8,%esp
    1ae9:	68 c6 44 00 00       	push   $0x44c6
    1aee:	68 70 49 00 00       	push   $0x4970
    1af3:	e8 54 21 00 00       	call   3c4c <link>
    1af8:	83 c4 10             	add    $0x10,%esp
    1afb:	eb 10                	jmp    1b0d <linkunlink+0x104>
    } else {
      unlink("x");
    1afd:	83 ec 0c             	sub    $0xc,%esp
    1b00:	68 c6 44 00 00       	push   $0x44c6
    1b05:	e8 32 21 00 00       	call   3c3c <unlink>
    1b0a:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1b0d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b11:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    1b15:	0f 8e 5c ff ff ff    	jle    1a77 <linkunlink+0x6e>
    } else {
      unlink("x");
    }
  }

  if(pid)
    1b1b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b1f:	74 07                	je     1b28 <linkunlink+0x11f>
    wait();
    1b21:	e8 ce 20 00 00       	call   3bf4 <wait>
    1b26:	eb 05                	jmp    1b2d <linkunlink+0x124>
  else 
    exit();
    1b28:	e8 bf 20 00 00       	call   3bec <exit>

  printf(1, "linkunlink ok\n");
    1b2d:	83 ec 08             	sub    $0x8,%esp
    1b30:	68 74 49 00 00       	push   $0x4974
    1b35:	6a 01                	push   $0x1
    1b37:	e8 2d 22 00 00       	call   3d69 <printf>
    1b3c:	83 c4 10             	add    $0x10,%esp
}
    1b3f:	c9                   	leave  
    1b40:	c3                   	ret    

00001b41 <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    1b41:	55                   	push   %ebp
    1b42:	89 e5                	mov    %esp,%ebp
    1b44:	83 ec 28             	sub    $0x28,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1b47:	83 ec 08             	sub    $0x8,%esp
    1b4a:	68 83 49 00 00       	push   $0x4983
    1b4f:	6a 01                	push   $0x1
    1b51:	e8 13 22 00 00       	call   3d69 <printf>
    1b56:	83 c4 10             	add    $0x10,%esp
  unlink("bd");
    1b59:	83 ec 0c             	sub    $0xc,%esp
    1b5c:	68 90 49 00 00       	push   $0x4990
    1b61:	e8 d6 20 00 00       	call   3c3c <unlink>
    1b66:	83 c4 10             	add    $0x10,%esp

  fd = open("bd", O_CREATE);
    1b69:	83 ec 08             	sub    $0x8,%esp
    1b6c:	68 00 02 00 00       	push   $0x200
    1b71:	68 90 49 00 00       	push   $0x4990
    1b76:	e8 b1 20 00 00       	call   3c2c <open>
    1b7b:	83 c4 10             	add    $0x10,%esp
    1b7e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0){
    1b81:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1b85:	79 17                	jns    1b9e <bigdir+0x5d>
    printf(1, "bigdir create failed\n");
    1b87:	83 ec 08             	sub    $0x8,%esp
    1b8a:	68 93 49 00 00       	push   $0x4993
    1b8f:	6a 01                	push   $0x1
    1b91:	e8 d3 21 00 00       	call   3d69 <printf>
    1b96:	83 c4 10             	add    $0x10,%esp
    exit();
    1b99:	e8 4e 20 00 00       	call   3bec <exit>
  }
  close(fd);
    1b9e:	83 ec 0c             	sub    $0xc,%esp
    1ba1:	ff 75 f0             	pushl  -0x10(%ebp)
    1ba4:	e8 6b 20 00 00       	call   3c14 <close>
    1ba9:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 500; i++){
    1bac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1bb3:	eb 61                	jmp    1c16 <bigdir+0xd5>
    name[0] = 'x';
    1bb5:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1bb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bbc:	99                   	cltd   
    1bbd:	c1 ea 1a             	shr    $0x1a,%edx
    1bc0:	01 d0                	add    %edx,%eax
    1bc2:	c1 f8 06             	sar    $0x6,%eax
    1bc5:	83 c0 30             	add    $0x30,%eax
    1bc8:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1bcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bce:	99                   	cltd   
    1bcf:	c1 ea 1a             	shr    $0x1a,%edx
    1bd2:	01 d0                	add    %edx,%eax
    1bd4:	83 e0 3f             	and    $0x3f,%eax
    1bd7:	29 d0                	sub    %edx,%eax
    1bd9:	83 c0 30             	add    $0x30,%eax
    1bdc:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1bdf:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(link("bd", name) != 0){
    1be3:	83 ec 08             	sub    $0x8,%esp
    1be6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1be9:	50                   	push   %eax
    1bea:	68 90 49 00 00       	push   $0x4990
    1bef:	e8 58 20 00 00       	call   3c4c <link>
    1bf4:	83 c4 10             	add    $0x10,%esp
    1bf7:	85 c0                	test   %eax,%eax
    1bf9:	74 17                	je     1c12 <bigdir+0xd1>
      printf(1, "bigdir link failed\n");
    1bfb:	83 ec 08             	sub    $0x8,%esp
    1bfe:	68 a9 49 00 00       	push   $0x49a9
    1c03:	6a 01                	push   $0x1
    1c05:	e8 5f 21 00 00       	call   3d69 <printf>
    1c0a:	83 c4 10             	add    $0x10,%esp
      exit();
    1c0d:	e8 da 1f 00 00       	call   3bec <exit>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    1c12:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1c16:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1c1d:	7e 96                	jle    1bb5 <bigdir+0x74>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    1c1f:	83 ec 0c             	sub    $0xc,%esp
    1c22:	68 90 49 00 00       	push   $0x4990
    1c27:	e8 10 20 00 00       	call   3c3c <unlink>
    1c2c:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    1c2f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c36:	eb 5c                	jmp    1c94 <bigdir+0x153>
    name[0] = 'x';
    1c38:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1c3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c3f:	99                   	cltd   
    1c40:	c1 ea 1a             	shr    $0x1a,%edx
    1c43:	01 d0                	add    %edx,%eax
    1c45:	c1 f8 06             	sar    $0x6,%eax
    1c48:	83 c0 30             	add    $0x30,%eax
    1c4b:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1c4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c51:	99                   	cltd   
    1c52:	c1 ea 1a             	shr    $0x1a,%edx
    1c55:	01 d0                	add    %edx,%eax
    1c57:	83 e0 3f             	and    $0x3f,%eax
    1c5a:	29 d0                	sub    %edx,%eax
    1c5c:	83 c0 30             	add    $0x30,%eax
    1c5f:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1c62:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(unlink(name) != 0){
    1c66:	83 ec 0c             	sub    $0xc,%esp
    1c69:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1c6c:	50                   	push   %eax
    1c6d:	e8 ca 1f 00 00       	call   3c3c <unlink>
    1c72:	83 c4 10             	add    $0x10,%esp
    1c75:	85 c0                	test   %eax,%eax
    1c77:	74 17                	je     1c90 <bigdir+0x14f>
      printf(1, "bigdir unlink failed");
    1c79:	83 ec 08             	sub    $0x8,%esp
    1c7c:	68 bd 49 00 00       	push   $0x49bd
    1c81:	6a 01                	push   $0x1
    1c83:	e8 e1 20 00 00       	call   3d69 <printf>
    1c88:	83 c4 10             	add    $0x10,%esp
      exit();
    1c8b:	e8 5c 1f 00 00       	call   3bec <exit>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    1c90:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1c94:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1c9b:	7e 9b                	jle    1c38 <bigdir+0xf7>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
    1c9d:	83 ec 08             	sub    $0x8,%esp
    1ca0:	68 d2 49 00 00       	push   $0x49d2
    1ca5:	6a 01                	push   $0x1
    1ca7:	e8 bd 20 00 00       	call   3d69 <printf>
    1cac:	83 c4 10             	add    $0x10,%esp
}
    1caf:	c9                   	leave  
    1cb0:	c3                   	ret    

00001cb1 <subdir>:

void
subdir(void)
{
    1cb1:	55                   	push   %ebp
    1cb2:	89 e5                	mov    %esp,%ebp
    1cb4:	83 ec 18             	sub    $0x18,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1cb7:	83 ec 08             	sub    $0x8,%esp
    1cba:	68 dd 49 00 00       	push   $0x49dd
    1cbf:	6a 01                	push   $0x1
    1cc1:	e8 a3 20 00 00       	call   3d69 <printf>
    1cc6:	83 c4 10             	add    $0x10,%esp

  unlink("ff");
    1cc9:	83 ec 0c             	sub    $0xc,%esp
    1ccc:	68 ea 49 00 00       	push   $0x49ea
    1cd1:	e8 66 1f 00 00       	call   3c3c <unlink>
    1cd6:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dd") != 0){
    1cd9:	83 ec 0c             	sub    $0xc,%esp
    1cdc:	68 ed 49 00 00       	push   $0x49ed
    1ce1:	e8 6e 1f 00 00       	call   3c54 <mkdir>
    1ce6:	83 c4 10             	add    $0x10,%esp
    1ce9:	85 c0                	test   %eax,%eax
    1ceb:	74 17                	je     1d04 <subdir+0x53>
    printf(1, "subdir mkdir dd failed\n");
    1ced:	83 ec 08             	sub    $0x8,%esp
    1cf0:	68 f0 49 00 00       	push   $0x49f0
    1cf5:	6a 01                	push   $0x1
    1cf7:	e8 6d 20 00 00       	call   3d69 <printf>
    1cfc:	83 c4 10             	add    $0x10,%esp
    exit();
    1cff:	e8 e8 1e 00 00       	call   3bec <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d04:	83 ec 08             	sub    $0x8,%esp
    1d07:	68 02 02 00 00       	push   $0x202
    1d0c:	68 08 4a 00 00       	push   $0x4a08
    1d11:	e8 16 1f 00 00       	call   3c2c <open>
    1d16:	83 c4 10             	add    $0x10,%esp
    1d19:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1d1c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d20:	79 17                	jns    1d39 <subdir+0x88>
    printf(1, "create dd/ff failed\n");
    1d22:	83 ec 08             	sub    $0x8,%esp
    1d25:	68 0e 4a 00 00       	push   $0x4a0e
    1d2a:	6a 01                	push   $0x1
    1d2c:	e8 38 20 00 00       	call   3d69 <printf>
    1d31:	83 c4 10             	add    $0x10,%esp
    exit();
    1d34:	e8 b3 1e 00 00       	call   3bec <exit>
  }
  write(fd, "ff", 2);
    1d39:	83 ec 04             	sub    $0x4,%esp
    1d3c:	6a 02                	push   $0x2
    1d3e:	68 ea 49 00 00       	push   $0x49ea
    1d43:	ff 75 f4             	pushl  -0xc(%ebp)
    1d46:	e8 c1 1e 00 00       	call   3c0c <write>
    1d4b:	83 c4 10             	add    $0x10,%esp
  close(fd);
    1d4e:	83 ec 0c             	sub    $0xc,%esp
    1d51:	ff 75 f4             	pushl  -0xc(%ebp)
    1d54:	e8 bb 1e 00 00       	call   3c14 <close>
    1d59:	83 c4 10             	add    $0x10,%esp
  
  if(unlink("dd") >= 0){
    1d5c:	83 ec 0c             	sub    $0xc,%esp
    1d5f:	68 ed 49 00 00       	push   $0x49ed
    1d64:	e8 d3 1e 00 00       	call   3c3c <unlink>
    1d69:	83 c4 10             	add    $0x10,%esp
    1d6c:	85 c0                	test   %eax,%eax
    1d6e:	78 17                	js     1d87 <subdir+0xd6>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    1d70:	83 ec 08             	sub    $0x8,%esp
    1d73:	68 24 4a 00 00       	push   $0x4a24
    1d78:	6a 01                	push   $0x1
    1d7a:	e8 ea 1f 00 00       	call   3d69 <printf>
    1d7f:	83 c4 10             	add    $0x10,%esp
    exit();
    1d82:	e8 65 1e 00 00       	call   3bec <exit>
  }

  if(mkdir("/dd/dd") != 0){
    1d87:	83 ec 0c             	sub    $0xc,%esp
    1d8a:	68 4a 4a 00 00       	push   $0x4a4a
    1d8f:	e8 c0 1e 00 00       	call   3c54 <mkdir>
    1d94:	83 c4 10             	add    $0x10,%esp
    1d97:	85 c0                	test   %eax,%eax
    1d99:	74 17                	je     1db2 <subdir+0x101>
    printf(1, "subdir mkdir dd/dd failed\n");
    1d9b:	83 ec 08             	sub    $0x8,%esp
    1d9e:	68 51 4a 00 00       	push   $0x4a51
    1da3:	6a 01                	push   $0x1
    1da5:	e8 bf 1f 00 00       	call   3d69 <printf>
    1daa:	83 c4 10             	add    $0x10,%esp
    exit();
    1dad:	e8 3a 1e 00 00       	call   3bec <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1db2:	83 ec 08             	sub    $0x8,%esp
    1db5:	68 02 02 00 00       	push   $0x202
    1dba:	68 6c 4a 00 00       	push   $0x4a6c
    1dbf:	e8 68 1e 00 00       	call   3c2c <open>
    1dc4:	83 c4 10             	add    $0x10,%esp
    1dc7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1dca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1dce:	79 17                	jns    1de7 <subdir+0x136>
    printf(1, "create dd/dd/ff failed\n");
    1dd0:	83 ec 08             	sub    $0x8,%esp
    1dd3:	68 75 4a 00 00       	push   $0x4a75
    1dd8:	6a 01                	push   $0x1
    1dda:	e8 8a 1f 00 00       	call   3d69 <printf>
    1ddf:	83 c4 10             	add    $0x10,%esp
    exit();
    1de2:	e8 05 1e 00 00       	call   3bec <exit>
  }
  write(fd, "FF", 2);
    1de7:	83 ec 04             	sub    $0x4,%esp
    1dea:	6a 02                	push   $0x2
    1dec:	68 8d 4a 00 00       	push   $0x4a8d
    1df1:	ff 75 f4             	pushl  -0xc(%ebp)
    1df4:	e8 13 1e 00 00       	call   3c0c <write>
    1df9:	83 c4 10             	add    $0x10,%esp
  close(fd);
    1dfc:	83 ec 0c             	sub    $0xc,%esp
    1dff:	ff 75 f4             	pushl  -0xc(%ebp)
    1e02:	e8 0d 1e 00 00       	call   3c14 <close>
    1e07:	83 c4 10             	add    $0x10,%esp

  fd = open("dd/dd/../ff", 0);
    1e0a:	83 ec 08             	sub    $0x8,%esp
    1e0d:	6a 00                	push   $0x0
    1e0f:	68 90 4a 00 00       	push   $0x4a90
    1e14:	e8 13 1e 00 00       	call   3c2c <open>
    1e19:	83 c4 10             	add    $0x10,%esp
    1e1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1e1f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e23:	79 17                	jns    1e3c <subdir+0x18b>
    printf(1, "open dd/dd/../ff failed\n");
    1e25:	83 ec 08             	sub    $0x8,%esp
    1e28:	68 9c 4a 00 00       	push   $0x4a9c
    1e2d:	6a 01                	push   $0x1
    1e2f:	e8 35 1f 00 00       	call   3d69 <printf>
    1e34:	83 c4 10             	add    $0x10,%esp
    exit();
    1e37:	e8 b0 1d 00 00       	call   3bec <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    1e3c:	83 ec 04             	sub    $0x4,%esp
    1e3f:	68 00 20 00 00       	push   $0x2000
    1e44:	68 c0 86 00 00       	push   $0x86c0
    1e49:	ff 75 f4             	pushl  -0xc(%ebp)
    1e4c:	e8 b3 1d 00 00       	call   3c04 <read>
    1e51:	83 c4 10             	add    $0x10,%esp
    1e54:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(cc != 2 || buf[0] != 'f'){
    1e57:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    1e5b:	75 0b                	jne    1e68 <subdir+0x1b7>
    1e5d:	0f b6 05 c0 86 00 00 	movzbl 0x86c0,%eax
    1e64:	3c 66                	cmp    $0x66,%al
    1e66:	74 17                	je     1e7f <subdir+0x1ce>
    printf(1, "dd/dd/../ff wrong content\n");
    1e68:	83 ec 08             	sub    $0x8,%esp
    1e6b:	68 b5 4a 00 00       	push   $0x4ab5
    1e70:	6a 01                	push   $0x1
    1e72:	e8 f2 1e 00 00       	call   3d69 <printf>
    1e77:	83 c4 10             	add    $0x10,%esp
    exit();
    1e7a:	e8 6d 1d 00 00       	call   3bec <exit>
  }
  close(fd);
    1e7f:	83 ec 0c             	sub    $0xc,%esp
    1e82:	ff 75 f4             	pushl  -0xc(%ebp)
    1e85:	e8 8a 1d 00 00       	call   3c14 <close>
    1e8a:	83 c4 10             	add    $0x10,%esp

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1e8d:	83 ec 08             	sub    $0x8,%esp
    1e90:	68 d0 4a 00 00       	push   $0x4ad0
    1e95:	68 6c 4a 00 00       	push   $0x4a6c
    1e9a:	e8 ad 1d 00 00       	call   3c4c <link>
    1e9f:	83 c4 10             	add    $0x10,%esp
    1ea2:	85 c0                	test   %eax,%eax
    1ea4:	74 17                	je     1ebd <subdir+0x20c>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    1ea6:	83 ec 08             	sub    $0x8,%esp
    1ea9:	68 dc 4a 00 00       	push   $0x4adc
    1eae:	6a 01                	push   $0x1
    1eb0:	e8 b4 1e 00 00       	call   3d69 <printf>
    1eb5:	83 c4 10             	add    $0x10,%esp
    exit();
    1eb8:	e8 2f 1d 00 00       	call   3bec <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    1ebd:	83 ec 0c             	sub    $0xc,%esp
    1ec0:	68 6c 4a 00 00       	push   $0x4a6c
    1ec5:	e8 72 1d 00 00       	call   3c3c <unlink>
    1eca:	83 c4 10             	add    $0x10,%esp
    1ecd:	85 c0                	test   %eax,%eax
    1ecf:	74 17                	je     1ee8 <subdir+0x237>
    printf(1, "unlink dd/dd/ff failed\n");
    1ed1:	83 ec 08             	sub    $0x8,%esp
    1ed4:	68 fd 4a 00 00       	push   $0x4afd
    1ed9:	6a 01                	push   $0x1
    1edb:	e8 89 1e 00 00       	call   3d69 <printf>
    1ee0:	83 c4 10             	add    $0x10,%esp
    exit();
    1ee3:	e8 04 1d 00 00       	call   3bec <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1ee8:	83 ec 08             	sub    $0x8,%esp
    1eeb:	6a 00                	push   $0x0
    1eed:	68 6c 4a 00 00       	push   $0x4a6c
    1ef2:	e8 35 1d 00 00       	call   3c2c <open>
    1ef7:	83 c4 10             	add    $0x10,%esp
    1efa:	85 c0                	test   %eax,%eax
    1efc:	78 17                	js     1f15 <subdir+0x264>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    1efe:	83 ec 08             	sub    $0x8,%esp
    1f01:	68 18 4b 00 00       	push   $0x4b18
    1f06:	6a 01                	push   $0x1
    1f08:	e8 5c 1e 00 00       	call   3d69 <printf>
    1f0d:	83 c4 10             	add    $0x10,%esp
    exit();
    1f10:	e8 d7 1c 00 00       	call   3bec <exit>
  }

  if(chdir("dd") != 0){
    1f15:	83 ec 0c             	sub    $0xc,%esp
    1f18:	68 ed 49 00 00       	push   $0x49ed
    1f1d:	e8 3a 1d 00 00       	call   3c5c <chdir>
    1f22:	83 c4 10             	add    $0x10,%esp
    1f25:	85 c0                	test   %eax,%eax
    1f27:	74 17                	je     1f40 <subdir+0x28f>
    printf(1, "chdir dd failed\n");
    1f29:	83 ec 08             	sub    $0x8,%esp
    1f2c:	68 3c 4b 00 00       	push   $0x4b3c
    1f31:	6a 01                	push   $0x1
    1f33:	e8 31 1e 00 00       	call   3d69 <printf>
    1f38:	83 c4 10             	add    $0x10,%esp
    exit();
    1f3b:	e8 ac 1c 00 00       	call   3bec <exit>
  }
  if(chdir("dd/../../dd") != 0){
    1f40:	83 ec 0c             	sub    $0xc,%esp
    1f43:	68 4d 4b 00 00       	push   $0x4b4d
    1f48:	e8 0f 1d 00 00       	call   3c5c <chdir>
    1f4d:	83 c4 10             	add    $0x10,%esp
    1f50:	85 c0                	test   %eax,%eax
    1f52:	74 17                	je     1f6b <subdir+0x2ba>
    printf(1, "chdir dd/../../dd failed\n");
    1f54:	83 ec 08             	sub    $0x8,%esp
    1f57:	68 59 4b 00 00       	push   $0x4b59
    1f5c:	6a 01                	push   $0x1
    1f5e:	e8 06 1e 00 00       	call   3d69 <printf>
    1f63:	83 c4 10             	add    $0x10,%esp
    exit();
    1f66:	e8 81 1c 00 00       	call   3bec <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    1f6b:	83 ec 0c             	sub    $0xc,%esp
    1f6e:	68 73 4b 00 00       	push   $0x4b73
    1f73:	e8 e4 1c 00 00       	call   3c5c <chdir>
    1f78:	83 c4 10             	add    $0x10,%esp
    1f7b:	85 c0                	test   %eax,%eax
    1f7d:	74 17                	je     1f96 <subdir+0x2e5>
    printf(1, "chdir dd/../../dd failed\n");
    1f7f:	83 ec 08             	sub    $0x8,%esp
    1f82:	68 59 4b 00 00       	push   $0x4b59
    1f87:	6a 01                	push   $0x1
    1f89:	e8 db 1d 00 00       	call   3d69 <printf>
    1f8e:	83 c4 10             	add    $0x10,%esp
    exit();
    1f91:	e8 56 1c 00 00       	call   3bec <exit>
  }
  if(chdir("./..") != 0){
    1f96:	83 ec 0c             	sub    $0xc,%esp
    1f99:	68 82 4b 00 00       	push   $0x4b82
    1f9e:	e8 b9 1c 00 00       	call   3c5c <chdir>
    1fa3:	83 c4 10             	add    $0x10,%esp
    1fa6:	85 c0                	test   %eax,%eax
    1fa8:	74 17                	je     1fc1 <subdir+0x310>
    printf(1, "chdir ./.. failed\n");
    1faa:	83 ec 08             	sub    $0x8,%esp
    1fad:	68 87 4b 00 00       	push   $0x4b87
    1fb2:	6a 01                	push   $0x1
    1fb4:	e8 b0 1d 00 00       	call   3d69 <printf>
    1fb9:	83 c4 10             	add    $0x10,%esp
    exit();
    1fbc:	e8 2b 1c 00 00       	call   3bec <exit>
  }

  fd = open("dd/dd/ffff", 0);
    1fc1:	83 ec 08             	sub    $0x8,%esp
    1fc4:	6a 00                	push   $0x0
    1fc6:	68 d0 4a 00 00       	push   $0x4ad0
    1fcb:	e8 5c 1c 00 00       	call   3c2c <open>
    1fd0:	83 c4 10             	add    $0x10,%esp
    1fd3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1fd6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fda:	79 17                	jns    1ff3 <subdir+0x342>
    printf(1, "open dd/dd/ffff failed\n");
    1fdc:	83 ec 08             	sub    $0x8,%esp
    1fdf:	68 9a 4b 00 00       	push   $0x4b9a
    1fe4:	6a 01                	push   $0x1
    1fe6:	e8 7e 1d 00 00       	call   3d69 <printf>
    1feb:	83 c4 10             	add    $0x10,%esp
    exit();
    1fee:	e8 f9 1b 00 00       	call   3bec <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    1ff3:	83 ec 04             	sub    $0x4,%esp
    1ff6:	68 00 20 00 00       	push   $0x2000
    1ffb:	68 c0 86 00 00       	push   $0x86c0
    2000:	ff 75 f4             	pushl  -0xc(%ebp)
    2003:	e8 fc 1b 00 00       	call   3c04 <read>
    2008:	83 c4 10             	add    $0x10,%esp
    200b:	83 f8 02             	cmp    $0x2,%eax
    200e:	74 17                	je     2027 <subdir+0x376>
    printf(1, "read dd/dd/ffff wrong len\n");
    2010:	83 ec 08             	sub    $0x8,%esp
    2013:	68 b2 4b 00 00       	push   $0x4bb2
    2018:	6a 01                	push   $0x1
    201a:	e8 4a 1d 00 00       	call   3d69 <printf>
    201f:	83 c4 10             	add    $0x10,%esp
    exit();
    2022:	e8 c5 1b 00 00       	call   3bec <exit>
  }
  close(fd);
    2027:	83 ec 0c             	sub    $0xc,%esp
    202a:	ff 75 f4             	pushl  -0xc(%ebp)
    202d:	e8 e2 1b 00 00       	call   3c14 <close>
    2032:	83 c4 10             	add    $0x10,%esp

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2035:	83 ec 08             	sub    $0x8,%esp
    2038:	6a 00                	push   $0x0
    203a:	68 6c 4a 00 00       	push   $0x4a6c
    203f:	e8 e8 1b 00 00       	call   3c2c <open>
    2044:	83 c4 10             	add    $0x10,%esp
    2047:	85 c0                	test   %eax,%eax
    2049:	78 17                	js     2062 <subdir+0x3b1>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    204b:	83 ec 08             	sub    $0x8,%esp
    204e:	68 d0 4b 00 00       	push   $0x4bd0
    2053:	6a 01                	push   $0x1
    2055:	e8 0f 1d 00 00       	call   3d69 <printf>
    205a:	83 c4 10             	add    $0x10,%esp
    exit();
    205d:	e8 8a 1b 00 00       	call   3bec <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2062:	83 ec 08             	sub    $0x8,%esp
    2065:	68 02 02 00 00       	push   $0x202
    206a:	68 f5 4b 00 00       	push   $0x4bf5
    206f:	e8 b8 1b 00 00       	call   3c2c <open>
    2074:	83 c4 10             	add    $0x10,%esp
    2077:	85 c0                	test   %eax,%eax
    2079:	78 17                	js     2092 <subdir+0x3e1>
    printf(1, "create dd/ff/ff succeeded!\n");
    207b:	83 ec 08             	sub    $0x8,%esp
    207e:	68 fe 4b 00 00       	push   $0x4bfe
    2083:	6a 01                	push   $0x1
    2085:	e8 df 1c 00 00       	call   3d69 <printf>
    208a:	83 c4 10             	add    $0x10,%esp
    exit();
    208d:	e8 5a 1b 00 00       	call   3bec <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2092:	83 ec 08             	sub    $0x8,%esp
    2095:	68 02 02 00 00       	push   $0x202
    209a:	68 1a 4c 00 00       	push   $0x4c1a
    209f:	e8 88 1b 00 00       	call   3c2c <open>
    20a4:	83 c4 10             	add    $0x10,%esp
    20a7:	85 c0                	test   %eax,%eax
    20a9:	78 17                	js     20c2 <subdir+0x411>
    printf(1, "create dd/xx/ff succeeded!\n");
    20ab:	83 ec 08             	sub    $0x8,%esp
    20ae:	68 23 4c 00 00       	push   $0x4c23
    20b3:	6a 01                	push   $0x1
    20b5:	e8 af 1c 00 00       	call   3d69 <printf>
    20ba:	83 c4 10             	add    $0x10,%esp
    exit();
    20bd:	e8 2a 1b 00 00       	call   3bec <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    20c2:	83 ec 08             	sub    $0x8,%esp
    20c5:	68 00 02 00 00       	push   $0x200
    20ca:	68 ed 49 00 00       	push   $0x49ed
    20cf:	e8 58 1b 00 00       	call   3c2c <open>
    20d4:	83 c4 10             	add    $0x10,%esp
    20d7:	85 c0                	test   %eax,%eax
    20d9:	78 17                	js     20f2 <subdir+0x441>
    printf(1, "create dd succeeded!\n");
    20db:	83 ec 08             	sub    $0x8,%esp
    20de:	68 3f 4c 00 00       	push   $0x4c3f
    20e3:	6a 01                	push   $0x1
    20e5:	e8 7f 1c 00 00       	call   3d69 <printf>
    20ea:	83 c4 10             	add    $0x10,%esp
    exit();
    20ed:	e8 fa 1a 00 00       	call   3bec <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    20f2:	83 ec 08             	sub    $0x8,%esp
    20f5:	6a 02                	push   $0x2
    20f7:	68 ed 49 00 00       	push   $0x49ed
    20fc:	e8 2b 1b 00 00       	call   3c2c <open>
    2101:	83 c4 10             	add    $0x10,%esp
    2104:	85 c0                	test   %eax,%eax
    2106:	78 17                	js     211f <subdir+0x46e>
    printf(1, "open dd rdwr succeeded!\n");
    2108:	83 ec 08             	sub    $0x8,%esp
    210b:	68 55 4c 00 00       	push   $0x4c55
    2110:	6a 01                	push   $0x1
    2112:	e8 52 1c 00 00       	call   3d69 <printf>
    2117:	83 c4 10             	add    $0x10,%esp
    exit();
    211a:	e8 cd 1a 00 00       	call   3bec <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    211f:	83 ec 08             	sub    $0x8,%esp
    2122:	6a 01                	push   $0x1
    2124:	68 ed 49 00 00       	push   $0x49ed
    2129:	e8 fe 1a 00 00       	call   3c2c <open>
    212e:	83 c4 10             	add    $0x10,%esp
    2131:	85 c0                	test   %eax,%eax
    2133:	78 17                	js     214c <subdir+0x49b>
    printf(1, "open dd wronly succeeded!\n");
    2135:	83 ec 08             	sub    $0x8,%esp
    2138:	68 6e 4c 00 00       	push   $0x4c6e
    213d:	6a 01                	push   $0x1
    213f:	e8 25 1c 00 00       	call   3d69 <printf>
    2144:	83 c4 10             	add    $0x10,%esp
    exit();
    2147:	e8 a0 1a 00 00       	call   3bec <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    214c:	83 ec 08             	sub    $0x8,%esp
    214f:	68 89 4c 00 00       	push   $0x4c89
    2154:	68 f5 4b 00 00       	push   $0x4bf5
    2159:	e8 ee 1a 00 00       	call   3c4c <link>
    215e:	83 c4 10             	add    $0x10,%esp
    2161:	85 c0                	test   %eax,%eax
    2163:	75 17                	jne    217c <subdir+0x4cb>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    2165:	83 ec 08             	sub    $0x8,%esp
    2168:	68 94 4c 00 00       	push   $0x4c94
    216d:	6a 01                	push   $0x1
    216f:	e8 f5 1b 00 00       	call   3d69 <printf>
    2174:	83 c4 10             	add    $0x10,%esp
    exit();
    2177:	e8 70 1a 00 00       	call   3bec <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    217c:	83 ec 08             	sub    $0x8,%esp
    217f:	68 89 4c 00 00       	push   $0x4c89
    2184:	68 1a 4c 00 00       	push   $0x4c1a
    2189:	e8 be 1a 00 00       	call   3c4c <link>
    218e:	83 c4 10             	add    $0x10,%esp
    2191:	85 c0                	test   %eax,%eax
    2193:	75 17                	jne    21ac <subdir+0x4fb>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2195:	83 ec 08             	sub    $0x8,%esp
    2198:	68 b8 4c 00 00       	push   $0x4cb8
    219d:	6a 01                	push   $0x1
    219f:	e8 c5 1b 00 00       	call   3d69 <printf>
    21a4:	83 c4 10             	add    $0x10,%esp
    exit();
    21a7:	e8 40 1a 00 00       	call   3bec <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    21ac:	83 ec 08             	sub    $0x8,%esp
    21af:	68 d0 4a 00 00       	push   $0x4ad0
    21b4:	68 08 4a 00 00       	push   $0x4a08
    21b9:	e8 8e 1a 00 00       	call   3c4c <link>
    21be:	83 c4 10             	add    $0x10,%esp
    21c1:	85 c0                	test   %eax,%eax
    21c3:	75 17                	jne    21dc <subdir+0x52b>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    21c5:	83 ec 08             	sub    $0x8,%esp
    21c8:	68 dc 4c 00 00       	push   $0x4cdc
    21cd:	6a 01                	push   $0x1
    21cf:	e8 95 1b 00 00       	call   3d69 <printf>
    21d4:	83 c4 10             	add    $0x10,%esp
    exit();
    21d7:	e8 10 1a 00 00       	call   3bec <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    21dc:	83 ec 0c             	sub    $0xc,%esp
    21df:	68 f5 4b 00 00       	push   $0x4bf5
    21e4:	e8 6b 1a 00 00       	call   3c54 <mkdir>
    21e9:	83 c4 10             	add    $0x10,%esp
    21ec:	85 c0                	test   %eax,%eax
    21ee:	75 17                	jne    2207 <subdir+0x556>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    21f0:	83 ec 08             	sub    $0x8,%esp
    21f3:	68 fe 4c 00 00       	push   $0x4cfe
    21f8:	6a 01                	push   $0x1
    21fa:	e8 6a 1b 00 00       	call   3d69 <printf>
    21ff:	83 c4 10             	add    $0x10,%esp
    exit();
    2202:	e8 e5 19 00 00       	call   3bec <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    2207:	83 ec 0c             	sub    $0xc,%esp
    220a:	68 1a 4c 00 00       	push   $0x4c1a
    220f:	e8 40 1a 00 00       	call   3c54 <mkdir>
    2214:	83 c4 10             	add    $0x10,%esp
    2217:	85 c0                	test   %eax,%eax
    2219:	75 17                	jne    2232 <subdir+0x581>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    221b:	83 ec 08             	sub    $0x8,%esp
    221e:	68 19 4d 00 00       	push   $0x4d19
    2223:	6a 01                	push   $0x1
    2225:	e8 3f 1b 00 00       	call   3d69 <printf>
    222a:	83 c4 10             	add    $0x10,%esp
    exit();
    222d:	e8 ba 19 00 00       	call   3bec <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    2232:	83 ec 0c             	sub    $0xc,%esp
    2235:	68 d0 4a 00 00       	push   $0x4ad0
    223a:	e8 15 1a 00 00       	call   3c54 <mkdir>
    223f:	83 c4 10             	add    $0x10,%esp
    2242:	85 c0                	test   %eax,%eax
    2244:	75 17                	jne    225d <subdir+0x5ac>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2246:	83 ec 08             	sub    $0x8,%esp
    2249:	68 34 4d 00 00       	push   $0x4d34
    224e:	6a 01                	push   $0x1
    2250:	e8 14 1b 00 00       	call   3d69 <printf>
    2255:	83 c4 10             	add    $0x10,%esp
    exit();
    2258:	e8 8f 19 00 00       	call   3bec <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    225d:	83 ec 0c             	sub    $0xc,%esp
    2260:	68 1a 4c 00 00       	push   $0x4c1a
    2265:	e8 d2 19 00 00       	call   3c3c <unlink>
    226a:	83 c4 10             	add    $0x10,%esp
    226d:	85 c0                	test   %eax,%eax
    226f:	75 17                	jne    2288 <subdir+0x5d7>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2271:	83 ec 08             	sub    $0x8,%esp
    2274:	68 51 4d 00 00       	push   $0x4d51
    2279:	6a 01                	push   $0x1
    227b:	e8 e9 1a 00 00       	call   3d69 <printf>
    2280:	83 c4 10             	add    $0x10,%esp
    exit();
    2283:	e8 64 19 00 00       	call   3bec <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    2288:	83 ec 0c             	sub    $0xc,%esp
    228b:	68 f5 4b 00 00       	push   $0x4bf5
    2290:	e8 a7 19 00 00       	call   3c3c <unlink>
    2295:	83 c4 10             	add    $0x10,%esp
    2298:	85 c0                	test   %eax,%eax
    229a:	75 17                	jne    22b3 <subdir+0x602>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    229c:	83 ec 08             	sub    $0x8,%esp
    229f:	68 6d 4d 00 00       	push   $0x4d6d
    22a4:	6a 01                	push   $0x1
    22a6:	e8 be 1a 00 00       	call   3d69 <printf>
    22ab:	83 c4 10             	add    $0x10,%esp
    exit();
    22ae:	e8 39 19 00 00       	call   3bec <exit>
  }
  if(chdir("dd/ff") == 0){
    22b3:	83 ec 0c             	sub    $0xc,%esp
    22b6:	68 08 4a 00 00       	push   $0x4a08
    22bb:	e8 9c 19 00 00       	call   3c5c <chdir>
    22c0:	83 c4 10             	add    $0x10,%esp
    22c3:	85 c0                	test   %eax,%eax
    22c5:	75 17                	jne    22de <subdir+0x62d>
    printf(1, "chdir dd/ff succeeded!\n");
    22c7:	83 ec 08             	sub    $0x8,%esp
    22ca:	68 89 4d 00 00       	push   $0x4d89
    22cf:	6a 01                	push   $0x1
    22d1:	e8 93 1a 00 00       	call   3d69 <printf>
    22d6:	83 c4 10             	add    $0x10,%esp
    exit();
    22d9:	e8 0e 19 00 00       	call   3bec <exit>
  }
  if(chdir("dd/xx") == 0){
    22de:	83 ec 0c             	sub    $0xc,%esp
    22e1:	68 a1 4d 00 00       	push   $0x4da1
    22e6:	e8 71 19 00 00       	call   3c5c <chdir>
    22eb:	83 c4 10             	add    $0x10,%esp
    22ee:	85 c0                	test   %eax,%eax
    22f0:	75 17                	jne    2309 <subdir+0x658>
    printf(1, "chdir dd/xx succeeded!\n");
    22f2:	83 ec 08             	sub    $0x8,%esp
    22f5:	68 a7 4d 00 00       	push   $0x4da7
    22fa:	6a 01                	push   $0x1
    22fc:	e8 68 1a 00 00       	call   3d69 <printf>
    2301:	83 c4 10             	add    $0x10,%esp
    exit();
    2304:	e8 e3 18 00 00       	call   3bec <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    2309:	83 ec 0c             	sub    $0xc,%esp
    230c:	68 d0 4a 00 00       	push   $0x4ad0
    2311:	e8 26 19 00 00       	call   3c3c <unlink>
    2316:	83 c4 10             	add    $0x10,%esp
    2319:	85 c0                	test   %eax,%eax
    231b:	74 17                	je     2334 <subdir+0x683>
    printf(1, "unlink dd/dd/ff failed\n");
    231d:	83 ec 08             	sub    $0x8,%esp
    2320:	68 fd 4a 00 00       	push   $0x4afd
    2325:	6a 01                	push   $0x1
    2327:	e8 3d 1a 00 00       	call   3d69 <printf>
    232c:	83 c4 10             	add    $0x10,%esp
    exit();
    232f:	e8 b8 18 00 00       	call   3bec <exit>
  }
  if(unlink("dd/ff") != 0){
    2334:	83 ec 0c             	sub    $0xc,%esp
    2337:	68 08 4a 00 00       	push   $0x4a08
    233c:	e8 fb 18 00 00       	call   3c3c <unlink>
    2341:	83 c4 10             	add    $0x10,%esp
    2344:	85 c0                	test   %eax,%eax
    2346:	74 17                	je     235f <subdir+0x6ae>
    printf(1, "unlink dd/ff failed\n");
    2348:	83 ec 08             	sub    $0x8,%esp
    234b:	68 bf 4d 00 00       	push   $0x4dbf
    2350:	6a 01                	push   $0x1
    2352:	e8 12 1a 00 00       	call   3d69 <printf>
    2357:	83 c4 10             	add    $0x10,%esp
    exit();
    235a:	e8 8d 18 00 00       	call   3bec <exit>
  }
  if(unlink("dd") == 0){
    235f:	83 ec 0c             	sub    $0xc,%esp
    2362:	68 ed 49 00 00       	push   $0x49ed
    2367:	e8 d0 18 00 00       	call   3c3c <unlink>
    236c:	83 c4 10             	add    $0x10,%esp
    236f:	85 c0                	test   %eax,%eax
    2371:	75 17                	jne    238a <subdir+0x6d9>
    printf(1, "unlink non-empty dd succeeded!\n");
    2373:	83 ec 08             	sub    $0x8,%esp
    2376:	68 d4 4d 00 00       	push   $0x4dd4
    237b:	6a 01                	push   $0x1
    237d:	e8 e7 19 00 00       	call   3d69 <printf>
    2382:	83 c4 10             	add    $0x10,%esp
    exit();
    2385:	e8 62 18 00 00       	call   3bec <exit>
  }
  if(unlink("dd/dd") < 0){
    238a:	83 ec 0c             	sub    $0xc,%esp
    238d:	68 f4 4d 00 00       	push   $0x4df4
    2392:	e8 a5 18 00 00       	call   3c3c <unlink>
    2397:	83 c4 10             	add    $0x10,%esp
    239a:	85 c0                	test   %eax,%eax
    239c:	79 17                	jns    23b5 <subdir+0x704>
    printf(1, "unlink dd/dd failed\n");
    239e:	83 ec 08             	sub    $0x8,%esp
    23a1:	68 fa 4d 00 00       	push   $0x4dfa
    23a6:	6a 01                	push   $0x1
    23a8:	e8 bc 19 00 00       	call   3d69 <printf>
    23ad:	83 c4 10             	add    $0x10,%esp
    exit();
    23b0:	e8 37 18 00 00       	call   3bec <exit>
  }
  if(unlink("dd") < 0){
    23b5:	83 ec 0c             	sub    $0xc,%esp
    23b8:	68 ed 49 00 00       	push   $0x49ed
    23bd:	e8 7a 18 00 00       	call   3c3c <unlink>
    23c2:	83 c4 10             	add    $0x10,%esp
    23c5:	85 c0                	test   %eax,%eax
    23c7:	79 17                	jns    23e0 <subdir+0x72f>
    printf(1, "unlink dd failed\n");
    23c9:	83 ec 08             	sub    $0x8,%esp
    23cc:	68 0f 4e 00 00       	push   $0x4e0f
    23d1:	6a 01                	push   $0x1
    23d3:	e8 91 19 00 00       	call   3d69 <printf>
    23d8:	83 c4 10             	add    $0x10,%esp
    exit();
    23db:	e8 0c 18 00 00       	call   3bec <exit>
  }

  printf(1, "subdir ok\n");
    23e0:	83 ec 08             	sub    $0x8,%esp
    23e3:	68 21 4e 00 00       	push   $0x4e21
    23e8:	6a 01                	push   $0x1
    23ea:	e8 7a 19 00 00       	call   3d69 <printf>
    23ef:	83 c4 10             	add    $0x10,%esp
}
    23f2:	c9                   	leave  
    23f3:	c3                   	ret    

000023f4 <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    23f4:	55                   	push   %ebp
    23f5:	89 e5                	mov    %esp,%ebp
    23f7:	83 ec 18             	sub    $0x18,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    23fa:	83 ec 08             	sub    $0x8,%esp
    23fd:	68 2c 4e 00 00       	push   $0x4e2c
    2402:	6a 01                	push   $0x1
    2404:	e8 60 19 00 00       	call   3d69 <printf>
    2409:	83 c4 10             	add    $0x10,%esp

  unlink("bigwrite");
    240c:	83 ec 0c             	sub    $0xc,%esp
    240f:	68 3b 4e 00 00       	push   $0x4e3b
    2414:	e8 23 18 00 00       	call   3c3c <unlink>
    2419:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    241c:	c7 45 f4 f3 01 00 00 	movl   $0x1f3,-0xc(%ebp)
    2423:	e9 a8 00 00 00       	jmp    24d0 <bigwrite+0xdc>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2428:	83 ec 08             	sub    $0x8,%esp
    242b:	68 02 02 00 00       	push   $0x202
    2430:	68 3b 4e 00 00       	push   $0x4e3b
    2435:	e8 f2 17 00 00       	call   3c2c <open>
    243a:	83 c4 10             	add    $0x10,%esp
    243d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    2440:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2444:	79 17                	jns    245d <bigwrite+0x69>
      printf(1, "cannot create bigwrite\n");
    2446:	83 ec 08             	sub    $0x8,%esp
    2449:	68 44 4e 00 00       	push   $0x4e44
    244e:	6a 01                	push   $0x1
    2450:	e8 14 19 00 00       	call   3d69 <printf>
    2455:	83 c4 10             	add    $0x10,%esp
      exit();
    2458:	e8 8f 17 00 00       	call   3bec <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    245d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2464:	eb 3f                	jmp    24a5 <bigwrite+0xb1>
      int cc = write(fd, buf, sz);
    2466:	83 ec 04             	sub    $0x4,%esp
    2469:	ff 75 f4             	pushl  -0xc(%ebp)
    246c:	68 c0 86 00 00       	push   $0x86c0
    2471:	ff 75 ec             	pushl  -0x14(%ebp)
    2474:	e8 93 17 00 00       	call   3c0c <write>
    2479:	83 c4 10             	add    $0x10,%esp
    247c:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(cc != sz){
    247f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2482:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2485:	74 1a                	je     24a1 <bigwrite+0xad>
        printf(1, "write(%d) ret %d\n", sz, cc);
    2487:	ff 75 e8             	pushl  -0x18(%ebp)
    248a:	ff 75 f4             	pushl  -0xc(%ebp)
    248d:	68 5c 4e 00 00       	push   $0x4e5c
    2492:	6a 01                	push   $0x1
    2494:	e8 d0 18 00 00       	call   3d69 <printf>
    2499:	83 c4 10             	add    $0x10,%esp
        exit();
    249c:	e8 4b 17 00 00       	call   3bec <exit>
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
    24a1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    24a5:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    24a9:	7e bb                	jle    2466 <bigwrite+0x72>
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    24ab:	83 ec 0c             	sub    $0xc,%esp
    24ae:	ff 75 ec             	pushl  -0x14(%ebp)
    24b1:	e8 5e 17 00 00       	call   3c14 <close>
    24b6:	83 c4 10             	add    $0x10,%esp
    unlink("bigwrite");
    24b9:	83 ec 0c             	sub    $0xc,%esp
    24bc:	68 3b 4e 00 00       	push   $0x4e3b
    24c1:	e8 76 17 00 00       	call   3c3c <unlink>
    24c6:	83 c4 10             	add    $0x10,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    24c9:	81 45 f4 d7 01 00 00 	addl   $0x1d7,-0xc(%ebp)
    24d0:	81 7d f4 ff 17 00 00 	cmpl   $0x17ff,-0xc(%ebp)
    24d7:	0f 8e 4b ff ff ff    	jle    2428 <bigwrite+0x34>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
    24dd:	83 ec 08             	sub    $0x8,%esp
    24e0:	68 6e 4e 00 00       	push   $0x4e6e
    24e5:	6a 01                	push   $0x1
    24e7:	e8 7d 18 00 00       	call   3d69 <printf>
    24ec:	83 c4 10             	add    $0x10,%esp
}
    24ef:	c9                   	leave  
    24f0:	c3                   	ret    

000024f1 <bigfile>:

void
bigfile(void)
{
    24f1:	55                   	push   %ebp
    24f2:	89 e5                	mov    %esp,%ebp
    24f4:	83 ec 18             	sub    $0x18,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    24f7:	83 ec 08             	sub    $0x8,%esp
    24fa:	68 7b 4e 00 00       	push   $0x4e7b
    24ff:	6a 01                	push   $0x1
    2501:	e8 63 18 00 00       	call   3d69 <printf>
    2506:	83 c4 10             	add    $0x10,%esp

  unlink("bigfile");
    2509:	83 ec 0c             	sub    $0xc,%esp
    250c:	68 89 4e 00 00       	push   $0x4e89
    2511:	e8 26 17 00 00       	call   3c3c <unlink>
    2516:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", O_CREATE | O_RDWR);
    2519:	83 ec 08             	sub    $0x8,%esp
    251c:	68 02 02 00 00       	push   $0x202
    2521:	68 89 4e 00 00       	push   $0x4e89
    2526:	e8 01 17 00 00       	call   3c2c <open>
    252b:	83 c4 10             	add    $0x10,%esp
    252e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    2531:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2535:	79 17                	jns    254e <bigfile+0x5d>
    printf(1, "cannot create bigfile");
    2537:	83 ec 08             	sub    $0x8,%esp
    253a:	68 91 4e 00 00       	push   $0x4e91
    253f:	6a 01                	push   $0x1
    2541:	e8 23 18 00 00       	call   3d69 <printf>
    2546:	83 c4 10             	add    $0x10,%esp
    exit();
    2549:	e8 9e 16 00 00       	call   3bec <exit>
  }
  for(i = 0; i < 20; i++){
    254e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2555:	eb 52                	jmp    25a9 <bigfile+0xb8>
    memset(buf, i, 600);
    2557:	83 ec 04             	sub    $0x4,%esp
    255a:	68 58 02 00 00       	push   $0x258
    255f:	ff 75 f4             	pushl  -0xc(%ebp)
    2562:	68 c0 86 00 00       	push   $0x86c0
    2567:	e8 e6 14 00 00       	call   3a52 <memset>
    256c:	83 c4 10             	add    $0x10,%esp
    if(write(fd, buf, 600) != 600){
    256f:	83 ec 04             	sub    $0x4,%esp
    2572:	68 58 02 00 00       	push   $0x258
    2577:	68 c0 86 00 00       	push   $0x86c0
    257c:	ff 75 ec             	pushl  -0x14(%ebp)
    257f:	e8 88 16 00 00       	call   3c0c <write>
    2584:	83 c4 10             	add    $0x10,%esp
    2587:	3d 58 02 00 00       	cmp    $0x258,%eax
    258c:	74 17                	je     25a5 <bigfile+0xb4>
      printf(1, "write bigfile failed\n");
    258e:	83 ec 08             	sub    $0x8,%esp
    2591:	68 a7 4e 00 00       	push   $0x4ea7
    2596:	6a 01                	push   $0x1
    2598:	e8 cc 17 00 00       	call   3d69 <printf>
    259d:	83 c4 10             	add    $0x10,%esp
      exit();
    25a0:	e8 47 16 00 00       	call   3bec <exit>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    25a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    25a9:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    25ad:	7e a8                	jle    2557 <bigfile+0x66>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    25af:	83 ec 0c             	sub    $0xc,%esp
    25b2:	ff 75 ec             	pushl  -0x14(%ebp)
    25b5:	e8 5a 16 00 00       	call   3c14 <close>
    25ba:	83 c4 10             	add    $0x10,%esp

  fd = open("bigfile", 0);
    25bd:	83 ec 08             	sub    $0x8,%esp
    25c0:	6a 00                	push   $0x0
    25c2:	68 89 4e 00 00       	push   $0x4e89
    25c7:	e8 60 16 00 00       	call   3c2c <open>
    25cc:	83 c4 10             	add    $0x10,%esp
    25cf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    25d2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    25d6:	79 17                	jns    25ef <bigfile+0xfe>
    printf(1, "cannot open bigfile\n");
    25d8:	83 ec 08             	sub    $0x8,%esp
    25db:	68 bd 4e 00 00       	push   $0x4ebd
    25e0:	6a 01                	push   $0x1
    25e2:	e8 82 17 00 00       	call   3d69 <printf>
    25e7:	83 c4 10             	add    $0x10,%esp
    exit();
    25ea:	e8 fd 15 00 00       	call   3bec <exit>
  }
  total = 0;
    25ef:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(i = 0; ; i++){
    25f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    cc = read(fd, buf, 300);
    25fd:	83 ec 04             	sub    $0x4,%esp
    2600:	68 2c 01 00 00       	push   $0x12c
    2605:	68 c0 86 00 00       	push   $0x86c0
    260a:	ff 75 ec             	pushl  -0x14(%ebp)
    260d:	e8 f2 15 00 00       	call   3c04 <read>
    2612:	83 c4 10             	add    $0x10,%esp
    2615:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(cc < 0){
    2618:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    261c:	79 17                	jns    2635 <bigfile+0x144>
      printf(1, "read bigfile failed\n");
    261e:	83 ec 08             	sub    $0x8,%esp
    2621:	68 d2 4e 00 00       	push   $0x4ed2
    2626:	6a 01                	push   $0x1
    2628:	e8 3c 17 00 00       	call   3d69 <printf>
    262d:	83 c4 10             	add    $0x10,%esp
      exit();
    2630:	e8 b7 15 00 00       	call   3bec <exit>
    }
    if(cc == 0)
    2635:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2639:	75 1e                	jne    2659 <bigfile+0x168>
      break;
    263b:	90                   	nop
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    263c:	83 ec 0c             	sub    $0xc,%esp
    263f:	ff 75 ec             	pushl  -0x14(%ebp)
    2642:	e8 cd 15 00 00       	call   3c14 <close>
    2647:	83 c4 10             	add    $0x10,%esp
  if(total != 20*600){
    264a:	81 7d f0 e0 2e 00 00 	cmpl   $0x2ee0,-0x10(%ebp)
    2651:	0f 84 93 00 00 00    	je     26ea <bigfile+0x1f9>
    2657:	eb 7a                	jmp    26d3 <bigfile+0x1e2>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
    2659:	81 7d e8 2c 01 00 00 	cmpl   $0x12c,-0x18(%ebp)
    2660:	74 17                	je     2679 <bigfile+0x188>
      printf(1, "short read bigfile\n");
    2662:	83 ec 08             	sub    $0x8,%esp
    2665:	68 e7 4e 00 00       	push   $0x4ee7
    266a:	6a 01                	push   $0x1
    266c:	e8 f8 16 00 00       	call   3d69 <printf>
    2671:	83 c4 10             	add    $0x10,%esp
      exit();
    2674:	e8 73 15 00 00       	call   3bec <exit>
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    2679:	0f b6 05 c0 86 00 00 	movzbl 0x86c0,%eax
    2680:	0f be d0             	movsbl %al,%edx
    2683:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2686:	89 c1                	mov    %eax,%ecx
    2688:	c1 e9 1f             	shr    $0x1f,%ecx
    268b:	01 c8                	add    %ecx,%eax
    268d:	d1 f8                	sar    %eax
    268f:	39 c2                	cmp    %eax,%edx
    2691:	75 1a                	jne    26ad <bigfile+0x1bc>
    2693:	0f b6 05 eb 87 00 00 	movzbl 0x87eb,%eax
    269a:	0f be d0             	movsbl %al,%edx
    269d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26a0:	89 c1                	mov    %eax,%ecx
    26a2:	c1 e9 1f             	shr    $0x1f,%ecx
    26a5:	01 c8                	add    %ecx,%eax
    26a7:	d1 f8                	sar    %eax
    26a9:	39 c2                	cmp    %eax,%edx
    26ab:	74 17                	je     26c4 <bigfile+0x1d3>
      printf(1, "read bigfile wrong data\n");
    26ad:	83 ec 08             	sub    $0x8,%esp
    26b0:	68 fb 4e 00 00       	push   $0x4efb
    26b5:	6a 01                	push   $0x1
    26b7:	e8 ad 16 00 00       	call   3d69 <printf>
    26bc:	83 c4 10             	add    $0x10,%esp
      exit();
    26bf:	e8 28 15 00 00       	call   3bec <exit>
    }
    total += cc;
    26c4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    26c7:	01 45 f0             	add    %eax,-0x10(%ebp)
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    26ca:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
    26ce:	e9 2a ff ff ff       	jmp    25fd <bigfile+0x10c>
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    26d3:	83 ec 08             	sub    $0x8,%esp
    26d6:	68 14 4f 00 00       	push   $0x4f14
    26db:	6a 01                	push   $0x1
    26dd:	e8 87 16 00 00       	call   3d69 <printf>
    26e2:	83 c4 10             	add    $0x10,%esp
    exit();
    26e5:	e8 02 15 00 00       	call   3bec <exit>
  }
  unlink("bigfile");
    26ea:	83 ec 0c             	sub    $0xc,%esp
    26ed:	68 89 4e 00 00       	push   $0x4e89
    26f2:	e8 45 15 00 00       	call   3c3c <unlink>
    26f7:	83 c4 10             	add    $0x10,%esp

  printf(1, "bigfile test ok\n");
    26fa:	83 ec 08             	sub    $0x8,%esp
    26fd:	68 2e 4f 00 00       	push   $0x4f2e
    2702:	6a 01                	push   $0x1
    2704:	e8 60 16 00 00       	call   3d69 <printf>
    2709:	83 c4 10             	add    $0x10,%esp
}
    270c:	c9                   	leave  
    270d:	c3                   	ret    

0000270e <fourteen>:

void
fourteen(void)
{
    270e:	55                   	push   %ebp
    270f:	89 e5                	mov    %esp,%ebp
    2711:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2714:	83 ec 08             	sub    $0x8,%esp
    2717:	68 3f 4f 00 00       	push   $0x4f3f
    271c:	6a 01                	push   $0x1
    271e:	e8 46 16 00 00       	call   3d69 <printf>
    2723:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234") != 0){
    2726:	83 ec 0c             	sub    $0xc,%esp
    2729:	68 4e 4f 00 00       	push   $0x4f4e
    272e:	e8 21 15 00 00       	call   3c54 <mkdir>
    2733:	83 c4 10             	add    $0x10,%esp
    2736:	85 c0                	test   %eax,%eax
    2738:	74 17                	je     2751 <fourteen+0x43>
    printf(1, "mkdir 12345678901234 failed\n");
    273a:	83 ec 08             	sub    $0x8,%esp
    273d:	68 5d 4f 00 00       	push   $0x4f5d
    2742:	6a 01                	push   $0x1
    2744:	e8 20 16 00 00       	call   3d69 <printf>
    2749:	83 c4 10             	add    $0x10,%esp
    exit();
    274c:	e8 9b 14 00 00       	call   3bec <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    2751:	83 ec 0c             	sub    $0xc,%esp
    2754:	68 7c 4f 00 00       	push   $0x4f7c
    2759:	e8 f6 14 00 00       	call   3c54 <mkdir>
    275e:	83 c4 10             	add    $0x10,%esp
    2761:	85 c0                	test   %eax,%eax
    2763:	74 17                	je     277c <fourteen+0x6e>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2765:	83 ec 08             	sub    $0x8,%esp
    2768:	68 9c 4f 00 00       	push   $0x4f9c
    276d:	6a 01                	push   $0x1
    276f:	e8 f5 15 00 00       	call   3d69 <printf>
    2774:	83 c4 10             	add    $0x10,%esp
    exit();
    2777:	e8 70 14 00 00       	call   3bec <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    277c:	83 ec 08             	sub    $0x8,%esp
    277f:	68 00 02 00 00       	push   $0x200
    2784:	68 cc 4f 00 00       	push   $0x4fcc
    2789:	e8 9e 14 00 00       	call   3c2c <open>
    278e:	83 c4 10             	add    $0x10,%esp
    2791:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2794:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2798:	79 17                	jns    27b1 <fourteen+0xa3>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    279a:	83 ec 08             	sub    $0x8,%esp
    279d:	68 fc 4f 00 00       	push   $0x4ffc
    27a2:	6a 01                	push   $0x1
    27a4:	e8 c0 15 00 00       	call   3d69 <printf>
    27a9:	83 c4 10             	add    $0x10,%esp
    exit();
    27ac:	e8 3b 14 00 00       	call   3bec <exit>
  }
  close(fd);
    27b1:	83 ec 0c             	sub    $0xc,%esp
    27b4:	ff 75 f4             	pushl  -0xc(%ebp)
    27b7:	e8 58 14 00 00       	call   3c14 <close>
    27bc:	83 c4 10             	add    $0x10,%esp
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    27bf:	83 ec 08             	sub    $0x8,%esp
    27c2:	6a 00                	push   $0x0
    27c4:	68 3c 50 00 00       	push   $0x503c
    27c9:	e8 5e 14 00 00       	call   3c2c <open>
    27ce:	83 c4 10             	add    $0x10,%esp
    27d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    27d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    27d8:	79 17                	jns    27f1 <fourteen+0xe3>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    27da:	83 ec 08             	sub    $0x8,%esp
    27dd:	68 6c 50 00 00       	push   $0x506c
    27e2:	6a 01                	push   $0x1
    27e4:	e8 80 15 00 00       	call   3d69 <printf>
    27e9:	83 c4 10             	add    $0x10,%esp
    exit();
    27ec:	e8 fb 13 00 00       	call   3bec <exit>
  }
  close(fd);
    27f1:	83 ec 0c             	sub    $0xc,%esp
    27f4:	ff 75 f4             	pushl  -0xc(%ebp)
    27f7:	e8 18 14 00 00       	call   3c14 <close>
    27fc:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234/12345678901234") == 0){
    27ff:	83 ec 0c             	sub    $0xc,%esp
    2802:	68 a6 50 00 00       	push   $0x50a6
    2807:	e8 48 14 00 00       	call   3c54 <mkdir>
    280c:	83 c4 10             	add    $0x10,%esp
    280f:	85 c0                	test   %eax,%eax
    2811:	75 17                	jne    282a <fourteen+0x11c>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2813:	83 ec 08             	sub    $0x8,%esp
    2816:	68 c4 50 00 00       	push   $0x50c4
    281b:	6a 01                	push   $0x1
    281d:	e8 47 15 00 00       	call   3d69 <printf>
    2822:	83 c4 10             	add    $0x10,%esp
    exit();
    2825:	e8 c2 13 00 00       	call   3bec <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    282a:	83 ec 0c             	sub    $0xc,%esp
    282d:	68 f4 50 00 00       	push   $0x50f4
    2832:	e8 1d 14 00 00       	call   3c54 <mkdir>
    2837:	83 c4 10             	add    $0x10,%esp
    283a:	85 c0                	test   %eax,%eax
    283c:	75 17                	jne    2855 <fourteen+0x147>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    283e:	83 ec 08             	sub    $0x8,%esp
    2841:	68 14 51 00 00       	push   $0x5114
    2846:	6a 01                	push   $0x1
    2848:	e8 1c 15 00 00       	call   3d69 <printf>
    284d:	83 c4 10             	add    $0x10,%esp
    exit();
    2850:	e8 97 13 00 00       	call   3bec <exit>
  }

  printf(1, "fourteen ok\n");
    2855:	83 ec 08             	sub    $0x8,%esp
    2858:	68 45 51 00 00       	push   $0x5145
    285d:	6a 01                	push   $0x1
    285f:	e8 05 15 00 00       	call   3d69 <printf>
    2864:	83 c4 10             	add    $0x10,%esp
}
    2867:	c9                   	leave  
    2868:	c3                   	ret    

00002869 <rmdot>:

void
rmdot(void)
{
    2869:	55                   	push   %ebp
    286a:	89 e5                	mov    %esp,%ebp
    286c:	83 ec 08             	sub    $0x8,%esp
  printf(1, "rmdot test\n");
    286f:	83 ec 08             	sub    $0x8,%esp
    2872:	68 52 51 00 00       	push   $0x5152
    2877:	6a 01                	push   $0x1
    2879:	e8 eb 14 00 00       	call   3d69 <printf>
    287e:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dots") != 0){
    2881:	83 ec 0c             	sub    $0xc,%esp
    2884:	68 5e 51 00 00       	push   $0x515e
    2889:	e8 c6 13 00 00       	call   3c54 <mkdir>
    288e:	83 c4 10             	add    $0x10,%esp
    2891:	85 c0                	test   %eax,%eax
    2893:	74 17                	je     28ac <rmdot+0x43>
    printf(1, "mkdir dots failed\n");
    2895:	83 ec 08             	sub    $0x8,%esp
    2898:	68 63 51 00 00       	push   $0x5163
    289d:	6a 01                	push   $0x1
    289f:	e8 c5 14 00 00       	call   3d69 <printf>
    28a4:	83 c4 10             	add    $0x10,%esp
    exit();
    28a7:	e8 40 13 00 00       	call   3bec <exit>
  }
  if(chdir("dots") != 0){
    28ac:	83 ec 0c             	sub    $0xc,%esp
    28af:	68 5e 51 00 00       	push   $0x515e
    28b4:	e8 a3 13 00 00       	call   3c5c <chdir>
    28b9:	83 c4 10             	add    $0x10,%esp
    28bc:	85 c0                	test   %eax,%eax
    28be:	74 17                	je     28d7 <rmdot+0x6e>
    printf(1, "chdir dots failed\n");
    28c0:	83 ec 08             	sub    $0x8,%esp
    28c3:	68 76 51 00 00       	push   $0x5176
    28c8:	6a 01                	push   $0x1
    28ca:	e8 9a 14 00 00       	call   3d69 <printf>
    28cf:	83 c4 10             	add    $0x10,%esp
    exit();
    28d2:	e8 15 13 00 00       	call   3bec <exit>
  }
  if(unlink(".") == 0){
    28d7:	83 ec 0c             	sub    $0xc,%esp
    28da:	68 8f 48 00 00       	push   $0x488f
    28df:	e8 58 13 00 00       	call   3c3c <unlink>
    28e4:	83 c4 10             	add    $0x10,%esp
    28e7:	85 c0                	test   %eax,%eax
    28e9:	75 17                	jne    2902 <rmdot+0x99>
    printf(1, "rm . worked!\n");
    28eb:	83 ec 08             	sub    $0x8,%esp
    28ee:	68 89 51 00 00       	push   $0x5189
    28f3:	6a 01                	push   $0x1
    28f5:	e8 6f 14 00 00       	call   3d69 <printf>
    28fa:	83 c4 10             	add    $0x10,%esp
    exit();
    28fd:	e8 ea 12 00 00       	call   3bec <exit>
  }
  if(unlink("..") == 0){
    2902:	83 ec 0c             	sub    $0xc,%esp
    2905:	68 1c 44 00 00       	push   $0x441c
    290a:	e8 2d 13 00 00       	call   3c3c <unlink>
    290f:	83 c4 10             	add    $0x10,%esp
    2912:	85 c0                	test   %eax,%eax
    2914:	75 17                	jne    292d <rmdot+0xc4>
    printf(1, "rm .. worked!\n");
    2916:	83 ec 08             	sub    $0x8,%esp
    2919:	68 97 51 00 00       	push   $0x5197
    291e:	6a 01                	push   $0x1
    2920:	e8 44 14 00 00       	call   3d69 <printf>
    2925:	83 c4 10             	add    $0x10,%esp
    exit();
    2928:	e8 bf 12 00 00       	call   3bec <exit>
  }
  if(chdir("/") != 0){
    292d:	83 ec 0c             	sub    $0xc,%esp
    2930:	68 a6 51 00 00       	push   $0x51a6
    2935:	e8 22 13 00 00       	call   3c5c <chdir>
    293a:	83 c4 10             	add    $0x10,%esp
    293d:	85 c0                	test   %eax,%eax
    293f:	74 17                	je     2958 <rmdot+0xef>
    printf(1, "chdir / failed\n");
    2941:	83 ec 08             	sub    $0x8,%esp
    2944:	68 a8 51 00 00       	push   $0x51a8
    2949:	6a 01                	push   $0x1
    294b:	e8 19 14 00 00       	call   3d69 <printf>
    2950:	83 c4 10             	add    $0x10,%esp
    exit();
    2953:	e8 94 12 00 00       	call   3bec <exit>
  }
  if(unlink("dots/.") == 0){
    2958:	83 ec 0c             	sub    $0xc,%esp
    295b:	68 b8 51 00 00       	push   $0x51b8
    2960:	e8 d7 12 00 00       	call   3c3c <unlink>
    2965:	83 c4 10             	add    $0x10,%esp
    2968:	85 c0                	test   %eax,%eax
    296a:	75 17                	jne    2983 <rmdot+0x11a>
    printf(1, "unlink dots/. worked!\n");
    296c:	83 ec 08             	sub    $0x8,%esp
    296f:	68 bf 51 00 00       	push   $0x51bf
    2974:	6a 01                	push   $0x1
    2976:	e8 ee 13 00 00       	call   3d69 <printf>
    297b:	83 c4 10             	add    $0x10,%esp
    exit();
    297e:	e8 69 12 00 00       	call   3bec <exit>
  }
  if(unlink("dots/..") == 0){
    2983:	83 ec 0c             	sub    $0xc,%esp
    2986:	68 d6 51 00 00       	push   $0x51d6
    298b:	e8 ac 12 00 00       	call   3c3c <unlink>
    2990:	83 c4 10             	add    $0x10,%esp
    2993:	85 c0                	test   %eax,%eax
    2995:	75 17                	jne    29ae <rmdot+0x145>
    printf(1, "unlink dots/.. worked!\n");
    2997:	83 ec 08             	sub    $0x8,%esp
    299a:	68 de 51 00 00       	push   $0x51de
    299f:	6a 01                	push   $0x1
    29a1:	e8 c3 13 00 00       	call   3d69 <printf>
    29a6:	83 c4 10             	add    $0x10,%esp
    exit();
    29a9:	e8 3e 12 00 00       	call   3bec <exit>
  }
  if(unlink("dots") != 0){
    29ae:	83 ec 0c             	sub    $0xc,%esp
    29b1:	68 5e 51 00 00       	push   $0x515e
    29b6:	e8 81 12 00 00       	call   3c3c <unlink>
    29bb:	83 c4 10             	add    $0x10,%esp
    29be:	85 c0                	test   %eax,%eax
    29c0:	74 17                	je     29d9 <rmdot+0x170>
    printf(1, "unlink dots failed!\n");
    29c2:	83 ec 08             	sub    $0x8,%esp
    29c5:	68 f6 51 00 00       	push   $0x51f6
    29ca:	6a 01                	push   $0x1
    29cc:	e8 98 13 00 00       	call   3d69 <printf>
    29d1:	83 c4 10             	add    $0x10,%esp
    exit();
    29d4:	e8 13 12 00 00       	call   3bec <exit>
  }
  printf(1, "rmdot ok\n");
    29d9:	83 ec 08             	sub    $0x8,%esp
    29dc:	68 0b 52 00 00       	push   $0x520b
    29e1:	6a 01                	push   $0x1
    29e3:	e8 81 13 00 00       	call   3d69 <printf>
    29e8:	83 c4 10             	add    $0x10,%esp
}
    29eb:	c9                   	leave  
    29ec:	c3                   	ret    

000029ed <dirfile>:

void
dirfile(void)
{
    29ed:	55                   	push   %ebp
    29ee:	89 e5                	mov    %esp,%ebp
    29f0:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "dir vs file\n");
    29f3:	83 ec 08             	sub    $0x8,%esp
    29f6:	68 15 52 00 00       	push   $0x5215
    29fb:	6a 01                	push   $0x1
    29fd:	e8 67 13 00 00       	call   3d69 <printf>
    2a02:	83 c4 10             	add    $0x10,%esp

  fd = open("dirfile", O_CREATE);
    2a05:	83 ec 08             	sub    $0x8,%esp
    2a08:	68 00 02 00 00       	push   $0x200
    2a0d:	68 22 52 00 00       	push   $0x5222
    2a12:	e8 15 12 00 00       	call   3c2c <open>
    2a17:	83 c4 10             	add    $0x10,%esp
    2a1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2a1d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a21:	79 17                	jns    2a3a <dirfile+0x4d>
    printf(1, "create dirfile failed\n");
    2a23:	83 ec 08             	sub    $0x8,%esp
    2a26:	68 2a 52 00 00       	push   $0x522a
    2a2b:	6a 01                	push   $0x1
    2a2d:	e8 37 13 00 00       	call   3d69 <printf>
    2a32:	83 c4 10             	add    $0x10,%esp
    exit();
    2a35:	e8 b2 11 00 00       	call   3bec <exit>
  }
  close(fd);
    2a3a:	83 ec 0c             	sub    $0xc,%esp
    2a3d:	ff 75 f4             	pushl  -0xc(%ebp)
    2a40:	e8 cf 11 00 00       	call   3c14 <close>
    2a45:	83 c4 10             	add    $0x10,%esp
  if(chdir("dirfile") == 0){
    2a48:	83 ec 0c             	sub    $0xc,%esp
    2a4b:	68 22 52 00 00       	push   $0x5222
    2a50:	e8 07 12 00 00       	call   3c5c <chdir>
    2a55:	83 c4 10             	add    $0x10,%esp
    2a58:	85 c0                	test   %eax,%eax
    2a5a:	75 17                	jne    2a73 <dirfile+0x86>
    printf(1, "chdir dirfile succeeded!\n");
    2a5c:	83 ec 08             	sub    $0x8,%esp
    2a5f:	68 41 52 00 00       	push   $0x5241
    2a64:	6a 01                	push   $0x1
    2a66:	e8 fe 12 00 00       	call   3d69 <printf>
    2a6b:	83 c4 10             	add    $0x10,%esp
    exit();
    2a6e:	e8 79 11 00 00       	call   3bec <exit>
  }
  fd = open("dirfile/xx", 0);
    2a73:	83 ec 08             	sub    $0x8,%esp
    2a76:	6a 00                	push   $0x0
    2a78:	68 5b 52 00 00       	push   $0x525b
    2a7d:	e8 aa 11 00 00       	call   3c2c <open>
    2a82:	83 c4 10             	add    $0x10,%esp
    2a85:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2a88:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a8c:	78 17                	js     2aa5 <dirfile+0xb8>
    printf(1, "create dirfile/xx succeeded!\n");
    2a8e:	83 ec 08             	sub    $0x8,%esp
    2a91:	68 66 52 00 00       	push   $0x5266
    2a96:	6a 01                	push   $0x1
    2a98:	e8 cc 12 00 00       	call   3d69 <printf>
    2a9d:	83 c4 10             	add    $0x10,%esp
    exit();
    2aa0:	e8 47 11 00 00       	call   3bec <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    2aa5:	83 ec 08             	sub    $0x8,%esp
    2aa8:	68 00 02 00 00       	push   $0x200
    2aad:	68 5b 52 00 00       	push   $0x525b
    2ab2:	e8 75 11 00 00       	call   3c2c <open>
    2ab7:	83 c4 10             	add    $0x10,%esp
    2aba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2abd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ac1:	78 17                	js     2ada <dirfile+0xed>
    printf(1, "create dirfile/xx succeeded!\n");
    2ac3:	83 ec 08             	sub    $0x8,%esp
    2ac6:	68 66 52 00 00       	push   $0x5266
    2acb:	6a 01                	push   $0x1
    2acd:	e8 97 12 00 00       	call   3d69 <printf>
    2ad2:	83 c4 10             	add    $0x10,%esp
    exit();
    2ad5:	e8 12 11 00 00       	call   3bec <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    2ada:	83 ec 0c             	sub    $0xc,%esp
    2add:	68 5b 52 00 00       	push   $0x525b
    2ae2:	e8 6d 11 00 00       	call   3c54 <mkdir>
    2ae7:	83 c4 10             	add    $0x10,%esp
    2aea:	85 c0                	test   %eax,%eax
    2aec:	75 17                	jne    2b05 <dirfile+0x118>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2aee:	83 ec 08             	sub    $0x8,%esp
    2af1:	68 84 52 00 00       	push   $0x5284
    2af6:	6a 01                	push   $0x1
    2af8:	e8 6c 12 00 00       	call   3d69 <printf>
    2afd:	83 c4 10             	add    $0x10,%esp
    exit();
    2b00:	e8 e7 10 00 00       	call   3bec <exit>
  }
  if(unlink("dirfile/xx") == 0){
    2b05:	83 ec 0c             	sub    $0xc,%esp
    2b08:	68 5b 52 00 00       	push   $0x525b
    2b0d:	e8 2a 11 00 00       	call   3c3c <unlink>
    2b12:	83 c4 10             	add    $0x10,%esp
    2b15:	85 c0                	test   %eax,%eax
    2b17:	75 17                	jne    2b30 <dirfile+0x143>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2b19:	83 ec 08             	sub    $0x8,%esp
    2b1c:	68 a1 52 00 00       	push   $0x52a1
    2b21:	6a 01                	push   $0x1
    2b23:	e8 41 12 00 00       	call   3d69 <printf>
    2b28:	83 c4 10             	add    $0x10,%esp
    exit();
    2b2b:	e8 bc 10 00 00       	call   3bec <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    2b30:	83 ec 08             	sub    $0x8,%esp
    2b33:	68 5b 52 00 00       	push   $0x525b
    2b38:	68 bf 52 00 00       	push   $0x52bf
    2b3d:	e8 0a 11 00 00       	call   3c4c <link>
    2b42:	83 c4 10             	add    $0x10,%esp
    2b45:	85 c0                	test   %eax,%eax
    2b47:	75 17                	jne    2b60 <dirfile+0x173>
    printf(1, "link to dirfile/xx succeeded!\n");
    2b49:	83 ec 08             	sub    $0x8,%esp
    2b4c:	68 c8 52 00 00       	push   $0x52c8
    2b51:	6a 01                	push   $0x1
    2b53:	e8 11 12 00 00       	call   3d69 <printf>
    2b58:	83 c4 10             	add    $0x10,%esp
    exit();
    2b5b:	e8 8c 10 00 00       	call   3bec <exit>
  }
  if(unlink("dirfile") != 0){
    2b60:	83 ec 0c             	sub    $0xc,%esp
    2b63:	68 22 52 00 00       	push   $0x5222
    2b68:	e8 cf 10 00 00       	call   3c3c <unlink>
    2b6d:	83 c4 10             	add    $0x10,%esp
    2b70:	85 c0                	test   %eax,%eax
    2b72:	74 17                	je     2b8b <dirfile+0x19e>
    printf(1, "unlink dirfile failed!\n");
    2b74:	83 ec 08             	sub    $0x8,%esp
    2b77:	68 e7 52 00 00       	push   $0x52e7
    2b7c:	6a 01                	push   $0x1
    2b7e:	e8 e6 11 00 00       	call   3d69 <printf>
    2b83:	83 c4 10             	add    $0x10,%esp
    exit();
    2b86:	e8 61 10 00 00       	call   3bec <exit>
  }

  fd = open(".", O_RDWR);
    2b8b:	83 ec 08             	sub    $0x8,%esp
    2b8e:	6a 02                	push   $0x2
    2b90:	68 8f 48 00 00       	push   $0x488f
    2b95:	e8 92 10 00 00       	call   3c2c <open>
    2b9a:	83 c4 10             	add    $0x10,%esp
    2b9d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2ba0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ba4:	78 17                	js     2bbd <dirfile+0x1d0>
    printf(1, "open . for writing succeeded!\n");
    2ba6:	83 ec 08             	sub    $0x8,%esp
    2ba9:	68 00 53 00 00       	push   $0x5300
    2bae:	6a 01                	push   $0x1
    2bb0:	e8 b4 11 00 00       	call   3d69 <printf>
    2bb5:	83 c4 10             	add    $0x10,%esp
    exit();
    2bb8:	e8 2f 10 00 00       	call   3bec <exit>
  }
  fd = open(".", 0);
    2bbd:	83 ec 08             	sub    $0x8,%esp
    2bc0:	6a 00                	push   $0x0
    2bc2:	68 8f 48 00 00       	push   $0x488f
    2bc7:	e8 60 10 00 00       	call   3c2c <open>
    2bcc:	83 c4 10             	add    $0x10,%esp
    2bcf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(write(fd, "x", 1) > 0){
    2bd2:	83 ec 04             	sub    $0x4,%esp
    2bd5:	6a 01                	push   $0x1
    2bd7:	68 c6 44 00 00       	push   $0x44c6
    2bdc:	ff 75 f4             	pushl  -0xc(%ebp)
    2bdf:	e8 28 10 00 00       	call   3c0c <write>
    2be4:	83 c4 10             	add    $0x10,%esp
    2be7:	85 c0                	test   %eax,%eax
    2be9:	7e 17                	jle    2c02 <dirfile+0x215>
    printf(1, "write . succeeded!\n");
    2beb:	83 ec 08             	sub    $0x8,%esp
    2bee:	68 1f 53 00 00       	push   $0x531f
    2bf3:	6a 01                	push   $0x1
    2bf5:	e8 6f 11 00 00       	call   3d69 <printf>
    2bfa:	83 c4 10             	add    $0x10,%esp
    exit();
    2bfd:	e8 ea 0f 00 00       	call   3bec <exit>
  }
  close(fd);
    2c02:	83 ec 0c             	sub    $0xc,%esp
    2c05:	ff 75 f4             	pushl  -0xc(%ebp)
    2c08:	e8 07 10 00 00       	call   3c14 <close>
    2c0d:	83 c4 10             	add    $0x10,%esp

  printf(1, "dir vs file OK\n");
    2c10:	83 ec 08             	sub    $0x8,%esp
    2c13:	68 33 53 00 00       	push   $0x5333
    2c18:	6a 01                	push   $0x1
    2c1a:	e8 4a 11 00 00       	call   3d69 <printf>
    2c1f:	83 c4 10             	add    $0x10,%esp
}
    2c22:	c9                   	leave  
    2c23:	c3                   	ret    

00002c24 <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2c24:	55                   	push   %ebp
    2c25:	89 e5                	mov    %esp,%ebp
    2c27:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2c2a:	83 ec 08             	sub    $0x8,%esp
    2c2d:	68 43 53 00 00       	push   $0x5343
    2c32:	6a 01                	push   $0x1
    2c34:	e8 30 11 00 00       	call   3d69 <printf>
    2c39:	83 c4 10             	add    $0x10,%esp

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2c3c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2c43:	e9 e7 00 00 00       	jmp    2d2f <iref+0x10b>
    if(mkdir("irefd") != 0){
    2c48:	83 ec 0c             	sub    $0xc,%esp
    2c4b:	68 54 53 00 00       	push   $0x5354
    2c50:	e8 ff 0f 00 00       	call   3c54 <mkdir>
    2c55:	83 c4 10             	add    $0x10,%esp
    2c58:	85 c0                	test   %eax,%eax
    2c5a:	74 17                	je     2c73 <iref+0x4f>
      printf(1, "mkdir irefd failed\n");
    2c5c:	83 ec 08             	sub    $0x8,%esp
    2c5f:	68 5a 53 00 00       	push   $0x535a
    2c64:	6a 01                	push   $0x1
    2c66:	e8 fe 10 00 00       	call   3d69 <printf>
    2c6b:	83 c4 10             	add    $0x10,%esp
      exit();
    2c6e:	e8 79 0f 00 00       	call   3bec <exit>
    }
    if(chdir("irefd") != 0){
    2c73:	83 ec 0c             	sub    $0xc,%esp
    2c76:	68 54 53 00 00       	push   $0x5354
    2c7b:	e8 dc 0f 00 00       	call   3c5c <chdir>
    2c80:	83 c4 10             	add    $0x10,%esp
    2c83:	85 c0                	test   %eax,%eax
    2c85:	74 17                	je     2c9e <iref+0x7a>
      printf(1, "chdir irefd failed\n");
    2c87:	83 ec 08             	sub    $0x8,%esp
    2c8a:	68 6e 53 00 00       	push   $0x536e
    2c8f:	6a 01                	push   $0x1
    2c91:	e8 d3 10 00 00       	call   3d69 <printf>
    2c96:	83 c4 10             	add    $0x10,%esp
      exit();
    2c99:	e8 4e 0f 00 00       	call   3bec <exit>
    }

    mkdir("");
    2c9e:	83 ec 0c             	sub    $0xc,%esp
    2ca1:	68 82 53 00 00       	push   $0x5382
    2ca6:	e8 a9 0f 00 00       	call   3c54 <mkdir>
    2cab:	83 c4 10             	add    $0x10,%esp
    link("README", "");
    2cae:	83 ec 08             	sub    $0x8,%esp
    2cb1:	68 82 53 00 00       	push   $0x5382
    2cb6:	68 bf 52 00 00       	push   $0x52bf
    2cbb:	e8 8c 0f 00 00       	call   3c4c <link>
    2cc0:	83 c4 10             	add    $0x10,%esp
    fd = open("", O_CREATE);
    2cc3:	83 ec 08             	sub    $0x8,%esp
    2cc6:	68 00 02 00 00       	push   $0x200
    2ccb:	68 82 53 00 00       	push   $0x5382
    2cd0:	e8 57 0f 00 00       	call   3c2c <open>
    2cd5:	83 c4 10             	add    $0x10,%esp
    2cd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2cdb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2cdf:	78 0e                	js     2cef <iref+0xcb>
      close(fd);
    2ce1:	83 ec 0c             	sub    $0xc,%esp
    2ce4:	ff 75 f0             	pushl  -0x10(%ebp)
    2ce7:	e8 28 0f 00 00       	call   3c14 <close>
    2cec:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2cef:	83 ec 08             	sub    $0x8,%esp
    2cf2:	68 00 02 00 00       	push   $0x200
    2cf7:	68 83 53 00 00       	push   $0x5383
    2cfc:	e8 2b 0f 00 00       	call   3c2c <open>
    2d01:	83 c4 10             	add    $0x10,%esp
    2d04:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2d07:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d0b:	78 0e                	js     2d1b <iref+0xf7>
      close(fd);
    2d0d:	83 ec 0c             	sub    $0xc,%esp
    2d10:	ff 75 f0             	pushl  -0x10(%ebp)
    2d13:	e8 fc 0e 00 00       	call   3c14 <close>
    2d18:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2d1b:	83 ec 0c             	sub    $0xc,%esp
    2d1e:	68 83 53 00 00       	push   $0x5383
    2d23:	e8 14 0f 00 00       	call   3c3c <unlink>
    2d28:	83 c4 10             	add    $0x10,%esp
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2d2b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2d2f:	83 7d f4 32          	cmpl   $0x32,-0xc(%ebp)
    2d33:	0f 8e 0f ff ff ff    	jle    2c48 <iref+0x24>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    2d39:	83 ec 0c             	sub    $0xc,%esp
    2d3c:	68 a6 51 00 00       	push   $0x51a6
    2d41:	e8 16 0f 00 00       	call   3c5c <chdir>
    2d46:	83 c4 10             	add    $0x10,%esp
  printf(1, "empty file name OK\n");
    2d49:	83 ec 08             	sub    $0x8,%esp
    2d4c:	68 86 53 00 00       	push   $0x5386
    2d51:	6a 01                	push   $0x1
    2d53:	e8 11 10 00 00       	call   3d69 <printf>
    2d58:	83 c4 10             	add    $0x10,%esp
}
    2d5b:	c9                   	leave  
    2d5c:	c3                   	ret    

00002d5d <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2d5d:	55                   	push   %ebp
    2d5e:	89 e5                	mov    %esp,%ebp
    2d60:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
    2d63:	83 ec 08             	sub    $0x8,%esp
    2d66:	68 9a 53 00 00       	push   $0x539a
    2d6b:	6a 01                	push   $0x1
    2d6d:	e8 f7 0f 00 00       	call   3d69 <printf>
    2d72:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<1000; n++){
    2d75:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2d7c:	eb 1f                	jmp    2d9d <forktest+0x40>
    pid = fork();
    2d7e:	e8 61 0e 00 00       	call   3be4 <fork>
    2d83:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
    2d86:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d8a:	79 02                	jns    2d8e <forktest+0x31>
      break;
    2d8c:	eb 18                	jmp    2da6 <forktest+0x49>
    if(pid == 0)
    2d8e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d92:	75 05                	jne    2d99 <forktest+0x3c>
      exit();
    2d94:	e8 53 0e 00 00       	call   3bec <exit>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    2d99:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2d9d:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    2da4:	7e d8                	jle    2d7e <forktest+0x21>
      break;
    if(pid == 0)
      exit();
  }
  
  if(n == 1000){
    2da6:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
    2dad:	75 17                	jne    2dc6 <forktest+0x69>
    printf(1, "fork claimed to work 1000 times!\n");
    2daf:	83 ec 08             	sub    $0x8,%esp
    2db2:	68 a8 53 00 00       	push   $0x53a8
    2db7:	6a 01                	push   $0x1
    2db9:	e8 ab 0f 00 00       	call   3d69 <printf>
    2dbe:	83 c4 10             	add    $0x10,%esp
    exit();
    2dc1:	e8 26 0e 00 00       	call   3bec <exit>
  }
  
  for(; n > 0; n--){
    2dc6:	eb 24                	jmp    2dec <forktest+0x8f>
    if(wait() < 0){
    2dc8:	e8 27 0e 00 00       	call   3bf4 <wait>
    2dcd:	85 c0                	test   %eax,%eax
    2dcf:	79 17                	jns    2de8 <forktest+0x8b>
      printf(1, "wait stopped early\n");
    2dd1:	83 ec 08             	sub    $0x8,%esp
    2dd4:	68 ca 53 00 00       	push   $0x53ca
    2dd9:	6a 01                	push   $0x1
    2ddb:	e8 89 0f 00 00       	call   3d69 <printf>
    2de0:	83 c4 10             	add    $0x10,%esp
      exit();
    2de3:	e8 04 0e 00 00       	call   3bec <exit>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
    2de8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    2dec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2df0:	7f d6                	jg     2dc8 <forktest+0x6b>
      printf(1, "wait stopped early\n");
      exit();
    }
  }
  
  if(wait() != -1){
    2df2:	e8 fd 0d 00 00       	call   3bf4 <wait>
    2df7:	83 f8 ff             	cmp    $0xffffffff,%eax
    2dfa:	74 17                	je     2e13 <forktest+0xb6>
    printf(1, "wait got too many\n");
    2dfc:	83 ec 08             	sub    $0x8,%esp
    2dff:	68 de 53 00 00       	push   $0x53de
    2e04:	6a 01                	push   $0x1
    2e06:	e8 5e 0f 00 00       	call   3d69 <printf>
    2e0b:	83 c4 10             	add    $0x10,%esp
    exit();
    2e0e:	e8 d9 0d 00 00       	call   3bec <exit>
  }
  
  printf(1, "fork test OK\n");
    2e13:	83 ec 08             	sub    $0x8,%esp
    2e16:	68 f1 53 00 00       	push   $0x53f1
    2e1b:	6a 01                	push   $0x1
    2e1d:	e8 47 0f 00 00       	call   3d69 <printf>
    2e22:	83 c4 10             	add    $0x10,%esp
}
    2e25:	c9                   	leave  
    2e26:	c3                   	ret    

00002e27 <sbrktest>:

void
sbrktest(void)
{
    2e27:	55                   	push   %ebp
    2e28:	89 e5                	mov    %esp,%ebp
    2e2a:	53                   	push   %ebx
    2e2b:	83 ec 64             	sub    $0x64,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    2e2e:	a1 74 5e 00 00       	mov    0x5e74,%eax
    2e33:	83 ec 08             	sub    $0x8,%esp
    2e36:	68 ff 53 00 00       	push   $0x53ff
    2e3b:	50                   	push   %eax
    2e3c:	e8 28 0f 00 00       	call   3d69 <printf>
    2e41:	83 c4 10             	add    $0x10,%esp
  oldbrk = sbrk(0);
    2e44:	83 ec 0c             	sub    $0xc,%esp
    2e47:	6a 00                	push   $0x0
    2e49:	e8 26 0e 00 00       	call   3c74 <sbrk>
    2e4e:	83 c4 10             	add    $0x10,%esp
    2e51:	89 45 ec             	mov    %eax,-0x14(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    2e54:	83 ec 0c             	sub    $0xc,%esp
    2e57:	6a 00                	push   $0x0
    2e59:	e8 16 0e 00 00       	call   3c74 <sbrk>
    2e5e:	83 c4 10             	add    $0x10,%esp
    2e61:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int i;
  for(i = 0; i < 5000; i++){ 
    2e64:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2e6b:	eb 4f                	jmp    2ebc <sbrktest+0x95>
    b = sbrk(1);
    2e6d:	83 ec 0c             	sub    $0xc,%esp
    2e70:	6a 01                	push   $0x1
    2e72:	e8 fd 0d 00 00       	call   3c74 <sbrk>
    2e77:	83 c4 10             	add    $0x10,%esp
    2e7a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(b != a){
    2e7d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2e80:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2e83:	74 24                	je     2ea9 <sbrktest+0x82>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    2e85:	a1 74 5e 00 00       	mov    0x5e74,%eax
    2e8a:	83 ec 0c             	sub    $0xc,%esp
    2e8d:	ff 75 e8             	pushl  -0x18(%ebp)
    2e90:	ff 75 f4             	pushl  -0xc(%ebp)
    2e93:	ff 75 f0             	pushl  -0x10(%ebp)
    2e96:	68 0a 54 00 00       	push   $0x540a
    2e9b:	50                   	push   %eax
    2e9c:	e8 c8 0e 00 00       	call   3d69 <printf>
    2ea1:	83 c4 20             	add    $0x20,%esp
      exit();
    2ea4:	e8 43 0d 00 00       	call   3bec <exit>
    }
    *b = 1;
    2ea9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2eac:	c6 00 01             	movb   $0x1,(%eax)
    a = b + 1;
    2eaf:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2eb2:	83 c0 01             	add    $0x1,%eax
    2eb5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){ 
    2eb8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2ebc:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
    2ec3:	7e a8                	jle    2e6d <sbrktest+0x46>
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    2ec5:	e8 1a 0d 00 00       	call   3be4 <fork>
    2eca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    2ecd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    2ed1:	79 1b                	jns    2eee <sbrktest+0xc7>
    printf(stdout, "sbrk test fork failed\n");
    2ed3:	a1 74 5e 00 00       	mov    0x5e74,%eax
    2ed8:	83 ec 08             	sub    $0x8,%esp
    2edb:	68 25 54 00 00       	push   $0x5425
    2ee0:	50                   	push   %eax
    2ee1:	e8 83 0e 00 00       	call   3d69 <printf>
    2ee6:	83 c4 10             	add    $0x10,%esp
    exit();
    2ee9:	e8 fe 0c 00 00       	call   3bec <exit>
  }
  c = sbrk(1);
    2eee:	83 ec 0c             	sub    $0xc,%esp
    2ef1:	6a 01                	push   $0x1
    2ef3:	e8 7c 0d 00 00       	call   3c74 <sbrk>
    2ef8:	83 c4 10             	add    $0x10,%esp
    2efb:	89 45 e0             	mov    %eax,-0x20(%ebp)
  c = sbrk(1);
    2efe:	83 ec 0c             	sub    $0xc,%esp
    2f01:	6a 01                	push   $0x1
    2f03:	e8 6c 0d 00 00       	call   3c74 <sbrk>
    2f08:	83 c4 10             	add    $0x10,%esp
    2f0b:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a + 1){
    2f0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f11:	83 c0 01             	add    $0x1,%eax
    2f14:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    2f17:	74 1b                	je     2f34 <sbrktest+0x10d>
    printf(stdout, "sbrk test failed post-fork\n");
    2f19:	a1 74 5e 00 00       	mov    0x5e74,%eax
    2f1e:	83 ec 08             	sub    $0x8,%esp
    2f21:	68 3c 54 00 00       	push   $0x543c
    2f26:	50                   	push   %eax
    2f27:	e8 3d 0e 00 00       	call   3d69 <printf>
    2f2c:	83 c4 10             	add    $0x10,%esp
    exit();
    2f2f:	e8 b8 0c 00 00       	call   3bec <exit>
  }
  if(pid == 0)
    2f34:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    2f38:	75 05                	jne    2f3f <sbrktest+0x118>
    exit();
    2f3a:	e8 ad 0c 00 00       	call   3bec <exit>
  wait();
    2f3f:	e8 b0 0c 00 00       	call   3bf4 <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    2f44:	83 ec 0c             	sub    $0xc,%esp
    2f47:	6a 00                	push   $0x0
    2f49:	e8 26 0d 00 00       	call   3c74 <sbrk>
    2f4e:	83 c4 10             	add    $0x10,%esp
    2f51:	89 45 f4             	mov    %eax,-0xc(%ebp)
  amt = (BIG) - (uint)a;
    2f54:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f57:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2f5c:	29 c2                	sub    %eax,%edx
    2f5e:	89 d0                	mov    %edx,%eax
    2f60:	89 45 dc             	mov    %eax,-0x24(%ebp)
  p = sbrk(amt);
    2f63:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2f66:	83 ec 0c             	sub    $0xc,%esp
    2f69:	50                   	push   %eax
    2f6a:	e8 05 0d 00 00       	call   3c74 <sbrk>
    2f6f:	83 c4 10             	add    $0x10,%esp
    2f72:	89 45 d8             	mov    %eax,-0x28(%ebp)
  if (p != a) { 
    2f75:	8b 45 d8             	mov    -0x28(%ebp),%eax
    2f78:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2f7b:	74 1b                	je     2f98 <sbrktest+0x171>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    2f7d:	a1 74 5e 00 00       	mov    0x5e74,%eax
    2f82:	83 ec 08             	sub    $0x8,%esp
    2f85:	68 58 54 00 00       	push   $0x5458
    2f8a:	50                   	push   %eax
    2f8b:	e8 d9 0d 00 00       	call   3d69 <printf>
    2f90:	83 c4 10             	add    $0x10,%esp
    exit();
    2f93:	e8 54 0c 00 00       	call   3bec <exit>
  }
  lastaddr = (char*) (BIG-1);
    2f98:	c7 45 d4 ff ff 3f 06 	movl   $0x63fffff,-0x2c(%ebp)
  *lastaddr = 99;
    2f9f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2fa2:	c6 00 63             	movb   $0x63,(%eax)

  // can one de-allocate?
  a = sbrk(0);
    2fa5:	83 ec 0c             	sub    $0xc,%esp
    2fa8:	6a 00                	push   $0x0
    2faa:	e8 c5 0c 00 00       	call   3c74 <sbrk>
    2faf:	83 c4 10             	add    $0x10,%esp
    2fb2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-4096);
    2fb5:	83 ec 0c             	sub    $0xc,%esp
    2fb8:	68 00 f0 ff ff       	push   $0xfffff000
    2fbd:	e8 b2 0c 00 00       	call   3c74 <sbrk>
    2fc2:	83 c4 10             	add    $0x10,%esp
    2fc5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c == (char*)0xffffffff){
    2fc8:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    2fcc:	75 1b                	jne    2fe9 <sbrktest+0x1c2>
    printf(stdout, "sbrk could not deallocate\n");
    2fce:	a1 74 5e 00 00       	mov    0x5e74,%eax
    2fd3:	83 ec 08             	sub    $0x8,%esp
    2fd6:	68 96 54 00 00       	push   $0x5496
    2fdb:	50                   	push   %eax
    2fdc:	e8 88 0d 00 00       	call   3d69 <printf>
    2fe1:	83 c4 10             	add    $0x10,%esp
    exit();
    2fe4:	e8 03 0c 00 00       	call   3bec <exit>
  }
  c = sbrk(0);
    2fe9:	83 ec 0c             	sub    $0xc,%esp
    2fec:	6a 00                	push   $0x0
    2fee:	e8 81 0c 00 00       	call   3c74 <sbrk>
    2ff3:	83 c4 10             	add    $0x10,%esp
    2ff6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a - 4096){
    2ff9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2ffc:	2d 00 10 00 00       	sub    $0x1000,%eax
    3001:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    3004:	74 1e                	je     3024 <sbrktest+0x1fd>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    3006:	a1 74 5e 00 00       	mov    0x5e74,%eax
    300b:	ff 75 e0             	pushl  -0x20(%ebp)
    300e:	ff 75 f4             	pushl  -0xc(%ebp)
    3011:	68 b4 54 00 00       	push   $0x54b4
    3016:	50                   	push   %eax
    3017:	e8 4d 0d 00 00       	call   3d69 <printf>
    301c:	83 c4 10             	add    $0x10,%esp
    exit();
    301f:	e8 c8 0b 00 00       	call   3bec <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    3024:	83 ec 0c             	sub    $0xc,%esp
    3027:	6a 00                	push   $0x0
    3029:	e8 46 0c 00 00       	call   3c74 <sbrk>
    302e:	83 c4 10             	add    $0x10,%esp
    3031:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(4096);
    3034:	83 ec 0c             	sub    $0xc,%esp
    3037:	68 00 10 00 00       	push   $0x1000
    303c:	e8 33 0c 00 00       	call   3c74 <sbrk>
    3041:	83 c4 10             	add    $0x10,%esp
    3044:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a || sbrk(0) != a + 4096){
    3047:	8b 45 e0             	mov    -0x20(%ebp),%eax
    304a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    304d:	75 1b                	jne    306a <sbrktest+0x243>
    304f:	83 ec 0c             	sub    $0xc,%esp
    3052:	6a 00                	push   $0x0
    3054:	e8 1b 0c 00 00       	call   3c74 <sbrk>
    3059:	83 c4 10             	add    $0x10,%esp
    305c:	89 c2                	mov    %eax,%edx
    305e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3061:	05 00 10 00 00       	add    $0x1000,%eax
    3066:	39 c2                	cmp    %eax,%edx
    3068:	74 1e                	je     3088 <sbrktest+0x261>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    306a:	a1 74 5e 00 00       	mov    0x5e74,%eax
    306f:	ff 75 e0             	pushl  -0x20(%ebp)
    3072:	ff 75 f4             	pushl  -0xc(%ebp)
    3075:	68 ec 54 00 00       	push   $0x54ec
    307a:	50                   	push   %eax
    307b:	e8 e9 0c 00 00       	call   3d69 <printf>
    3080:	83 c4 10             	add    $0x10,%esp
    exit();
    3083:	e8 64 0b 00 00       	call   3bec <exit>
  }
  if(*lastaddr == 99){
    3088:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    308b:	0f b6 00             	movzbl (%eax),%eax
    308e:	3c 63                	cmp    $0x63,%al
    3090:	75 1b                	jne    30ad <sbrktest+0x286>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    3092:	a1 74 5e 00 00       	mov    0x5e74,%eax
    3097:	83 ec 08             	sub    $0x8,%esp
    309a:	68 14 55 00 00       	push   $0x5514
    309f:	50                   	push   %eax
    30a0:	e8 c4 0c 00 00       	call   3d69 <printf>
    30a5:	83 c4 10             	add    $0x10,%esp
    exit();
    30a8:	e8 3f 0b 00 00       	call   3bec <exit>
  }

  a = sbrk(0);
    30ad:	83 ec 0c             	sub    $0xc,%esp
    30b0:	6a 00                	push   $0x0
    30b2:	e8 bd 0b 00 00       	call   3c74 <sbrk>
    30b7:	83 c4 10             	add    $0x10,%esp
    30ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-(sbrk(0) - oldbrk));
    30bd:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    30c0:	83 ec 0c             	sub    $0xc,%esp
    30c3:	6a 00                	push   $0x0
    30c5:	e8 aa 0b 00 00       	call   3c74 <sbrk>
    30ca:	83 c4 10             	add    $0x10,%esp
    30cd:	29 c3                	sub    %eax,%ebx
    30cf:	89 d8                	mov    %ebx,%eax
    30d1:	83 ec 0c             	sub    $0xc,%esp
    30d4:	50                   	push   %eax
    30d5:	e8 9a 0b 00 00       	call   3c74 <sbrk>
    30da:	83 c4 10             	add    $0x10,%esp
    30dd:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a){
    30e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    30e3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    30e6:	74 1e                	je     3106 <sbrktest+0x2df>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    30e8:	a1 74 5e 00 00       	mov    0x5e74,%eax
    30ed:	ff 75 e0             	pushl  -0x20(%ebp)
    30f0:	ff 75 f4             	pushl  -0xc(%ebp)
    30f3:	68 44 55 00 00       	push   $0x5544
    30f8:	50                   	push   %eax
    30f9:	e8 6b 0c 00 00       	call   3d69 <printf>
    30fe:	83 c4 10             	add    $0x10,%esp
    exit();
    3101:	e8 e6 0a 00 00       	call   3bec <exit>
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3106:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
    310d:	eb 76                	jmp    3185 <sbrktest+0x35e>
    ppid = getpid();
    310f:	e8 58 0b 00 00       	call   3c6c <getpid>
    3114:	89 45 d0             	mov    %eax,-0x30(%ebp)
    pid = fork();
    3117:	e8 c8 0a 00 00       	call   3be4 <fork>
    311c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(pid < 0){
    311f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3123:	79 1b                	jns    3140 <sbrktest+0x319>
      printf(stdout, "fork failed\n");
    3125:	a1 74 5e 00 00       	mov    0x5e74,%eax
    312a:	83 ec 08             	sub    $0x8,%esp
    312d:	68 0d 45 00 00       	push   $0x450d
    3132:	50                   	push   %eax
    3133:	e8 31 0c 00 00       	call   3d69 <printf>
    3138:	83 c4 10             	add    $0x10,%esp
      exit();
    313b:	e8 ac 0a 00 00       	call   3bec <exit>
    }
    if(pid == 0){
    3140:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3144:	75 33                	jne    3179 <sbrktest+0x352>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    3146:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3149:	0f b6 00             	movzbl (%eax),%eax
    314c:	0f be d0             	movsbl %al,%edx
    314f:	a1 74 5e 00 00       	mov    0x5e74,%eax
    3154:	52                   	push   %edx
    3155:	ff 75 f4             	pushl  -0xc(%ebp)
    3158:	68 65 55 00 00       	push   $0x5565
    315d:	50                   	push   %eax
    315e:	e8 06 0c 00 00       	call   3d69 <printf>
    3163:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
    3166:	83 ec 0c             	sub    $0xc,%esp
    3169:	ff 75 d0             	pushl  -0x30(%ebp)
    316c:	e8 ab 0a 00 00       	call   3c1c <kill>
    3171:	83 c4 10             	add    $0x10,%esp
      exit();
    3174:	e8 73 0a 00 00       	call   3bec <exit>
    }
    wait();
    3179:	e8 76 0a 00 00       	call   3bf4 <wait>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    317e:	81 45 f4 50 c3 00 00 	addl   $0xc350,-0xc(%ebp)
    3185:	81 7d f4 7f 84 1e 80 	cmpl   $0x801e847f,-0xc(%ebp)
    318c:	76 81                	jbe    310f <sbrktest+0x2e8>
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    318e:	83 ec 0c             	sub    $0xc,%esp
    3191:	8d 45 c8             	lea    -0x38(%ebp),%eax
    3194:	50                   	push   %eax
    3195:	e8 62 0a 00 00       	call   3bfc <pipe>
    319a:	83 c4 10             	add    $0x10,%esp
    319d:	85 c0                	test   %eax,%eax
    319f:	74 17                	je     31b8 <sbrktest+0x391>
    printf(1, "pipe() failed\n");
    31a1:	83 ec 08             	sub    $0x8,%esp
    31a4:	68 61 44 00 00       	push   $0x4461
    31a9:	6a 01                	push   $0x1
    31ab:	e8 b9 0b 00 00       	call   3d69 <printf>
    31b0:	83 c4 10             	add    $0x10,%esp
    exit();
    31b3:	e8 34 0a 00 00       	call   3bec <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    31b8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    31bf:	e9 88 00 00 00       	jmp    324c <sbrktest+0x425>
    if((pids[i] = fork()) == 0){
    31c4:	e8 1b 0a 00 00       	call   3be4 <fork>
    31c9:	89 c2                	mov    %eax,%edx
    31cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    31ce:	89 54 85 a0          	mov    %edx,-0x60(%ebp,%eax,4)
    31d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    31d5:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    31d9:	85 c0                	test   %eax,%eax
    31db:	75 4a                	jne    3227 <sbrktest+0x400>
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    31dd:	83 ec 0c             	sub    $0xc,%esp
    31e0:	6a 00                	push   $0x0
    31e2:	e8 8d 0a 00 00       	call   3c74 <sbrk>
    31e7:	83 c4 10             	add    $0x10,%esp
    31ea:	ba 00 00 40 06       	mov    $0x6400000,%edx
    31ef:	29 c2                	sub    %eax,%edx
    31f1:	89 d0                	mov    %edx,%eax
    31f3:	83 ec 0c             	sub    $0xc,%esp
    31f6:	50                   	push   %eax
    31f7:	e8 78 0a 00 00       	call   3c74 <sbrk>
    31fc:	83 c4 10             	add    $0x10,%esp
      write(fds[1], "x", 1);
    31ff:	8b 45 cc             	mov    -0x34(%ebp),%eax
    3202:	83 ec 04             	sub    $0x4,%esp
    3205:	6a 01                	push   $0x1
    3207:	68 c6 44 00 00       	push   $0x44c6
    320c:	50                   	push   %eax
    320d:	e8 fa 09 00 00       	call   3c0c <write>
    3212:	83 c4 10             	add    $0x10,%esp
      // sit around until killed
      for(;;) sleep(1000);
    3215:	83 ec 0c             	sub    $0xc,%esp
    3218:	68 e8 03 00 00       	push   $0x3e8
    321d:	e8 5a 0a 00 00       	call   3c7c <sleep>
    3222:	83 c4 10             	add    $0x10,%esp
    3225:	eb ee                	jmp    3215 <sbrktest+0x3ee>
    }
    if(pids[i] != -1)
    3227:	8b 45 f0             	mov    -0x10(%ebp),%eax
    322a:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    322e:	83 f8 ff             	cmp    $0xffffffff,%eax
    3231:	74 15                	je     3248 <sbrktest+0x421>
      read(fds[0], &scratch, 1);
    3233:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3236:	83 ec 04             	sub    $0x4,%esp
    3239:	6a 01                	push   $0x1
    323b:	8d 55 9f             	lea    -0x61(%ebp),%edx
    323e:	52                   	push   %edx
    323f:	50                   	push   %eax
    3240:	e8 bf 09 00 00       	call   3c04 <read>
    3245:	83 c4 10             	add    $0x10,%esp
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3248:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    324c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    324f:	83 f8 09             	cmp    $0x9,%eax
    3252:	0f 86 6c ff ff ff    	jbe    31c4 <sbrktest+0x39d>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    3258:	83 ec 0c             	sub    $0xc,%esp
    325b:	68 00 10 00 00       	push   $0x1000
    3260:	e8 0f 0a 00 00       	call   3c74 <sbrk>
    3265:	83 c4 10             	add    $0x10,%esp
    3268:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    326b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3272:	eb 2a                	jmp    329e <sbrktest+0x477>
    if(pids[i] == -1)
    3274:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3277:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    327b:	83 f8 ff             	cmp    $0xffffffff,%eax
    327e:	75 02                	jne    3282 <sbrktest+0x45b>
      continue;
    3280:	eb 18                	jmp    329a <sbrktest+0x473>
    kill(pids[i]);
    3282:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3285:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3289:	83 ec 0c             	sub    $0xc,%esp
    328c:	50                   	push   %eax
    328d:	e8 8a 09 00 00       	call   3c1c <kill>
    3292:	83 c4 10             	add    $0x10,%esp
    wait();
    3295:	e8 5a 09 00 00       	call   3bf4 <wait>
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    329a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    329e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    32a1:	83 f8 09             	cmp    $0x9,%eax
    32a4:	76 ce                	jbe    3274 <sbrktest+0x44d>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    32a6:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    32aa:	75 1b                	jne    32c7 <sbrktest+0x4a0>
    printf(stdout, "failed sbrk leaked memory\n");
    32ac:	a1 74 5e 00 00       	mov    0x5e74,%eax
    32b1:	83 ec 08             	sub    $0x8,%esp
    32b4:	68 7e 55 00 00       	push   $0x557e
    32b9:	50                   	push   %eax
    32ba:	e8 aa 0a 00 00       	call   3d69 <printf>
    32bf:	83 c4 10             	add    $0x10,%esp
    exit();
    32c2:	e8 25 09 00 00       	call   3bec <exit>
  }

  if(sbrk(0) > oldbrk)
    32c7:	83 ec 0c             	sub    $0xc,%esp
    32ca:	6a 00                	push   $0x0
    32cc:	e8 a3 09 00 00       	call   3c74 <sbrk>
    32d1:	83 c4 10             	add    $0x10,%esp
    32d4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    32d7:	76 20                	jbe    32f9 <sbrktest+0x4d2>
    sbrk(-(sbrk(0) - oldbrk));
    32d9:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    32dc:	83 ec 0c             	sub    $0xc,%esp
    32df:	6a 00                	push   $0x0
    32e1:	e8 8e 09 00 00       	call   3c74 <sbrk>
    32e6:	83 c4 10             	add    $0x10,%esp
    32e9:	29 c3                	sub    %eax,%ebx
    32eb:	89 d8                	mov    %ebx,%eax
    32ed:	83 ec 0c             	sub    $0xc,%esp
    32f0:	50                   	push   %eax
    32f1:	e8 7e 09 00 00       	call   3c74 <sbrk>
    32f6:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    32f9:	a1 74 5e 00 00       	mov    0x5e74,%eax
    32fe:	83 ec 08             	sub    $0x8,%esp
    3301:	68 99 55 00 00       	push   $0x5599
    3306:	50                   	push   %eax
    3307:	e8 5d 0a 00 00       	call   3d69 <printf>
    330c:	83 c4 10             	add    $0x10,%esp
}
    330f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3312:	c9                   	leave  
    3313:	c3                   	ret    

00003314 <validateint>:

void
validateint(int *p)
{
    3314:	55                   	push   %ebp
    3315:	89 e5                	mov    %esp,%ebp
    3317:	53                   	push   %ebx
    3318:	83 ec 10             	sub    $0x10,%esp
  int res;
  asm("mov %%esp, %%ebx\n\t"
    331b:	b8 0d 00 00 00       	mov    $0xd,%eax
    3320:	8b 55 08             	mov    0x8(%ebp),%edx
    3323:	89 d1                	mov    %edx,%ecx
    3325:	89 e3                	mov    %esp,%ebx
    3327:	89 cc                	mov    %ecx,%esp
    3329:	cd 40                	int    $0x40
    332b:	89 dc                	mov    %ebx,%esp
    332d:	89 45 f8             	mov    %eax,-0x8(%ebp)
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    3330:	83 c4 10             	add    $0x10,%esp
    3333:	5b                   	pop    %ebx
    3334:	5d                   	pop    %ebp
    3335:	c3                   	ret    

00003336 <validatetest>:

void
validatetest(void)
{
    3336:	55                   	push   %ebp
    3337:	89 e5                	mov    %esp,%ebp
    3339:	83 ec 18             	sub    $0x18,%esp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    333c:	a1 74 5e 00 00       	mov    0x5e74,%eax
    3341:	83 ec 08             	sub    $0x8,%esp
    3344:	68 a7 55 00 00       	push   $0x55a7
    3349:	50                   	push   %eax
    334a:	e8 1a 0a 00 00       	call   3d69 <printf>
    334f:	83 c4 10             	add    $0x10,%esp
  hi = 1100*1024;
    3352:	c7 45 f0 00 30 11 00 	movl   $0x113000,-0x10(%ebp)

  for(p = 0; p <= (uint)hi; p += 4096){
    3359:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3360:	e9 8a 00 00 00       	jmp    33ef <validatetest+0xb9>
    if((pid = fork()) == 0){
    3365:	e8 7a 08 00 00       	call   3be4 <fork>
    336a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    336d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3371:	75 14                	jne    3387 <validatetest+0x51>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
    3373:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3376:	83 ec 0c             	sub    $0xc,%esp
    3379:	50                   	push   %eax
    337a:	e8 95 ff ff ff       	call   3314 <validateint>
    337f:	83 c4 10             	add    $0x10,%esp
      exit();
    3382:	e8 65 08 00 00       	call   3bec <exit>
    }
    sleep(0);
    3387:	83 ec 0c             	sub    $0xc,%esp
    338a:	6a 00                	push   $0x0
    338c:	e8 eb 08 00 00       	call   3c7c <sleep>
    3391:	83 c4 10             	add    $0x10,%esp
    sleep(0);
    3394:	83 ec 0c             	sub    $0xc,%esp
    3397:	6a 00                	push   $0x0
    3399:	e8 de 08 00 00       	call   3c7c <sleep>
    339e:	83 c4 10             	add    $0x10,%esp
    kill(pid);
    33a1:	83 ec 0c             	sub    $0xc,%esp
    33a4:	ff 75 ec             	pushl  -0x14(%ebp)
    33a7:	e8 70 08 00 00       	call   3c1c <kill>
    33ac:	83 c4 10             	add    $0x10,%esp
    wait();
    33af:	e8 40 08 00 00       	call   3bf4 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    33b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    33b7:	83 ec 08             	sub    $0x8,%esp
    33ba:	50                   	push   %eax
    33bb:	68 b6 55 00 00       	push   $0x55b6
    33c0:	e8 87 08 00 00       	call   3c4c <link>
    33c5:	83 c4 10             	add    $0x10,%esp
    33c8:	83 f8 ff             	cmp    $0xffffffff,%eax
    33cb:	74 1b                	je     33e8 <validatetest+0xb2>
      printf(stdout, "link should not succeed\n");
    33cd:	a1 74 5e 00 00       	mov    0x5e74,%eax
    33d2:	83 ec 08             	sub    $0x8,%esp
    33d5:	68 c1 55 00 00       	push   $0x55c1
    33da:	50                   	push   %eax
    33db:	e8 89 09 00 00       	call   3d69 <printf>
    33e0:	83 c4 10             	add    $0x10,%esp
      exit();
    33e3:	e8 04 08 00 00       	call   3bec <exit>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    33e8:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    33ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
    33f2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    33f5:	0f 83 6a ff ff ff    	jae    3365 <validatetest+0x2f>
      printf(stdout, "link should not succeed\n");
      exit();
    }
  }

  printf(stdout, "validate ok\n");
    33fb:	a1 74 5e 00 00       	mov    0x5e74,%eax
    3400:	83 ec 08             	sub    $0x8,%esp
    3403:	68 da 55 00 00       	push   $0x55da
    3408:	50                   	push   %eax
    3409:	e8 5b 09 00 00       	call   3d69 <printf>
    340e:	83 c4 10             	add    $0x10,%esp
}
    3411:	c9                   	leave  
    3412:	c3                   	ret    

00003413 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    3413:	55                   	push   %ebp
    3414:	89 e5                	mov    %esp,%ebp
    3416:	83 ec 18             	sub    $0x18,%esp
  int i;

  printf(stdout, "bss test\n");
    3419:	a1 74 5e 00 00       	mov    0x5e74,%eax
    341e:	83 ec 08             	sub    $0x8,%esp
    3421:	68 e7 55 00 00       	push   $0x55e7
    3426:	50                   	push   %eax
    3427:	e8 3d 09 00 00       	call   3d69 <printf>
    342c:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    342f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3436:	eb 2e                	jmp    3466 <bsstest+0x53>
    if(uninit[i] != '\0'){
    3438:	8b 45 f4             	mov    -0xc(%ebp),%eax
    343b:	05 80 5f 00 00       	add    $0x5f80,%eax
    3440:	0f b6 00             	movzbl (%eax),%eax
    3443:	84 c0                	test   %al,%al
    3445:	74 1b                	je     3462 <bsstest+0x4f>
      printf(stdout, "bss test failed\n");
    3447:	a1 74 5e 00 00       	mov    0x5e74,%eax
    344c:	83 ec 08             	sub    $0x8,%esp
    344f:	68 f1 55 00 00       	push   $0x55f1
    3454:	50                   	push   %eax
    3455:	e8 0f 09 00 00       	call   3d69 <printf>
    345a:	83 c4 10             	add    $0x10,%esp
      exit();
    345d:	e8 8a 07 00 00       	call   3bec <exit>
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    3462:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3466:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3469:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    346e:	76 c8                	jbe    3438 <bsstest+0x25>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit();
    }
  }
  printf(stdout, "bss test ok\n");
    3470:	a1 74 5e 00 00       	mov    0x5e74,%eax
    3475:	83 ec 08             	sub    $0x8,%esp
    3478:	68 02 56 00 00       	push   $0x5602
    347d:	50                   	push   %eax
    347e:	e8 e6 08 00 00       	call   3d69 <printf>
    3483:	83 c4 10             	add    $0x10,%esp
}
    3486:	c9                   	leave  
    3487:	c3                   	ret    

00003488 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    3488:	55                   	push   %ebp
    3489:	89 e5                	mov    %esp,%ebp
    348b:	83 ec 18             	sub    $0x18,%esp
  int pid, fd;

  unlink("bigarg-ok");
    348e:	83 ec 0c             	sub    $0xc,%esp
    3491:	68 0f 56 00 00       	push   $0x560f
    3496:	e8 a1 07 00 00       	call   3c3c <unlink>
    349b:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    349e:	e8 41 07 00 00       	call   3be4 <fork>
    34a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    34a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    34aa:	0f 85 97 00 00 00    	jne    3547 <bigargtest+0xbf>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    34b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    34b7:	eb 12                	jmp    34cb <bigargtest+0x43>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    34b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    34bc:	c7 04 85 c0 5e 00 00 	movl   $0x561c,0x5ec0(,%eax,4)
    34c3:	1c 56 00 00 
  unlink("bigarg-ok");
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    34c7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    34cb:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
    34cf:	7e e8                	jle    34b9 <bigargtest+0x31>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    34d1:	c7 05 3c 5f 00 00 00 	movl   $0x0,0x5f3c
    34d8:	00 00 00 
    printf(stdout, "bigarg test\n");
    34db:	a1 74 5e 00 00       	mov    0x5e74,%eax
    34e0:	83 ec 08             	sub    $0x8,%esp
    34e3:	68 f9 56 00 00       	push   $0x56f9
    34e8:	50                   	push   %eax
    34e9:	e8 7b 08 00 00       	call   3d69 <printf>
    34ee:	83 c4 10             	add    $0x10,%esp
    exec("echo", args);
    34f1:	83 ec 08             	sub    $0x8,%esp
    34f4:	68 c0 5e 00 00       	push   $0x5ec0
    34f9:	68 20 41 00 00       	push   $0x4120
    34fe:	e8 21 07 00 00       	call   3c24 <exec>
    3503:	83 c4 10             	add    $0x10,%esp
    printf(stdout, "bigarg test ok\n");
    3506:	a1 74 5e 00 00       	mov    0x5e74,%eax
    350b:	83 ec 08             	sub    $0x8,%esp
    350e:	68 06 57 00 00       	push   $0x5706
    3513:	50                   	push   %eax
    3514:	e8 50 08 00 00       	call   3d69 <printf>
    3519:	83 c4 10             	add    $0x10,%esp
    fd = open("bigarg-ok", O_CREATE);
    351c:	83 ec 08             	sub    $0x8,%esp
    351f:	68 00 02 00 00       	push   $0x200
    3524:	68 0f 56 00 00       	push   $0x560f
    3529:	e8 fe 06 00 00       	call   3c2c <open>
    352e:	83 c4 10             	add    $0x10,%esp
    3531:	89 45 ec             	mov    %eax,-0x14(%ebp)
    close(fd);
    3534:	83 ec 0c             	sub    $0xc,%esp
    3537:	ff 75 ec             	pushl  -0x14(%ebp)
    353a:	e8 d5 06 00 00       	call   3c14 <close>
    353f:	83 c4 10             	add    $0x10,%esp
    exit();
    3542:	e8 a5 06 00 00       	call   3bec <exit>
  } else if(pid < 0){
    3547:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    354b:	79 1b                	jns    3568 <bigargtest+0xe0>
    printf(stdout, "bigargtest: fork failed\n");
    354d:	a1 74 5e 00 00       	mov    0x5e74,%eax
    3552:	83 ec 08             	sub    $0x8,%esp
    3555:	68 16 57 00 00       	push   $0x5716
    355a:	50                   	push   %eax
    355b:	e8 09 08 00 00       	call   3d69 <printf>
    3560:	83 c4 10             	add    $0x10,%esp
    exit();
    3563:	e8 84 06 00 00       	call   3bec <exit>
  }
  wait();
    3568:	e8 87 06 00 00       	call   3bf4 <wait>
  fd = open("bigarg-ok", 0);
    356d:	83 ec 08             	sub    $0x8,%esp
    3570:	6a 00                	push   $0x0
    3572:	68 0f 56 00 00       	push   $0x560f
    3577:	e8 b0 06 00 00       	call   3c2c <open>
    357c:	83 c4 10             	add    $0x10,%esp
    357f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    3582:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3586:	79 1b                	jns    35a3 <bigargtest+0x11b>
    printf(stdout, "bigarg test failed!\n");
    3588:	a1 74 5e 00 00       	mov    0x5e74,%eax
    358d:	83 ec 08             	sub    $0x8,%esp
    3590:	68 2f 57 00 00       	push   $0x572f
    3595:	50                   	push   %eax
    3596:	e8 ce 07 00 00       	call   3d69 <printf>
    359b:	83 c4 10             	add    $0x10,%esp
    exit();
    359e:	e8 49 06 00 00       	call   3bec <exit>
  }
  close(fd);
    35a3:	83 ec 0c             	sub    $0xc,%esp
    35a6:	ff 75 ec             	pushl  -0x14(%ebp)
    35a9:	e8 66 06 00 00       	call   3c14 <close>
    35ae:	83 c4 10             	add    $0x10,%esp
  unlink("bigarg-ok");
    35b1:	83 ec 0c             	sub    $0xc,%esp
    35b4:	68 0f 56 00 00       	push   $0x560f
    35b9:	e8 7e 06 00 00       	call   3c3c <unlink>
    35be:	83 c4 10             	add    $0x10,%esp
}
    35c1:	c9                   	leave  
    35c2:	c3                   	ret    

000035c3 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    35c3:	55                   	push   %ebp
    35c4:	89 e5                	mov    %esp,%ebp
    35c6:	53                   	push   %ebx
    35c7:	83 ec 64             	sub    $0x64,%esp
  int nfiles;
  int fsblocks = 0;
    35ca:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  printf(1, "fsfull test\n");
    35d1:	83 ec 08             	sub    $0x8,%esp
    35d4:	68 44 57 00 00       	push   $0x5744
    35d9:	6a 01                	push   $0x1
    35db:	e8 89 07 00 00       	call   3d69 <printf>
    35e0:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    35e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    char name[64];
    name[0] = 'f';
    35ea:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    35ee:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    35f1:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    35f6:	89 c8                	mov    %ecx,%eax
    35f8:	f7 ea                	imul   %edx
    35fa:	c1 fa 06             	sar    $0x6,%edx
    35fd:	89 c8                	mov    %ecx,%eax
    35ff:	c1 f8 1f             	sar    $0x1f,%eax
    3602:	29 c2                	sub    %eax,%edx
    3604:	89 d0                	mov    %edx,%eax
    3606:	83 c0 30             	add    $0x30,%eax
    3609:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    360c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    360f:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3614:	89 d8                	mov    %ebx,%eax
    3616:	f7 ea                	imul   %edx
    3618:	c1 fa 06             	sar    $0x6,%edx
    361b:	89 d8                	mov    %ebx,%eax
    361d:	c1 f8 1f             	sar    $0x1f,%eax
    3620:	89 d1                	mov    %edx,%ecx
    3622:	29 c1                	sub    %eax,%ecx
    3624:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    362a:	29 c3                	sub    %eax,%ebx
    362c:	89 d9                	mov    %ebx,%ecx
    362e:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3633:	89 c8                	mov    %ecx,%eax
    3635:	f7 ea                	imul   %edx
    3637:	c1 fa 05             	sar    $0x5,%edx
    363a:	89 c8                	mov    %ecx,%eax
    363c:	c1 f8 1f             	sar    $0x1f,%eax
    363f:	29 c2                	sub    %eax,%edx
    3641:	89 d0                	mov    %edx,%eax
    3643:	83 c0 30             	add    $0x30,%eax
    3646:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3649:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    364c:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3651:	89 d8                	mov    %ebx,%eax
    3653:	f7 ea                	imul   %edx
    3655:	c1 fa 05             	sar    $0x5,%edx
    3658:	89 d8                	mov    %ebx,%eax
    365a:	c1 f8 1f             	sar    $0x1f,%eax
    365d:	89 d1                	mov    %edx,%ecx
    365f:	29 c1                	sub    %eax,%ecx
    3661:	6b c1 64             	imul   $0x64,%ecx,%eax
    3664:	29 c3                	sub    %eax,%ebx
    3666:	89 d9                	mov    %ebx,%ecx
    3668:	ba 67 66 66 66       	mov    $0x66666667,%edx
    366d:	89 c8                	mov    %ecx,%eax
    366f:	f7 ea                	imul   %edx
    3671:	c1 fa 02             	sar    $0x2,%edx
    3674:	89 c8                	mov    %ecx,%eax
    3676:	c1 f8 1f             	sar    $0x1f,%eax
    3679:	29 c2                	sub    %eax,%edx
    367b:	89 d0                	mov    %edx,%eax
    367d:	83 c0 30             	add    $0x30,%eax
    3680:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    3683:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3686:	ba 67 66 66 66       	mov    $0x66666667,%edx
    368b:	89 c8                	mov    %ecx,%eax
    368d:	f7 ea                	imul   %edx
    368f:	c1 fa 02             	sar    $0x2,%edx
    3692:	89 c8                	mov    %ecx,%eax
    3694:	c1 f8 1f             	sar    $0x1f,%eax
    3697:	29 c2                	sub    %eax,%edx
    3699:	89 d0                	mov    %edx,%eax
    369b:	c1 e0 02             	shl    $0x2,%eax
    369e:	01 d0                	add    %edx,%eax
    36a0:	01 c0                	add    %eax,%eax
    36a2:	29 c1                	sub    %eax,%ecx
    36a4:	89 ca                	mov    %ecx,%edx
    36a6:	89 d0                	mov    %edx,%eax
    36a8:	83 c0 30             	add    $0x30,%eax
    36ab:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    36ae:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    printf(1, "writing %s\n", name);
    36b2:	83 ec 04             	sub    $0x4,%esp
    36b5:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    36b8:	50                   	push   %eax
    36b9:	68 51 57 00 00       	push   $0x5751
    36be:	6a 01                	push   $0x1
    36c0:	e8 a4 06 00 00       	call   3d69 <printf>
    36c5:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    36c8:	83 ec 08             	sub    $0x8,%esp
    36cb:	68 02 02 00 00       	push   $0x202
    36d0:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    36d3:	50                   	push   %eax
    36d4:	e8 53 05 00 00       	call   3c2c <open>
    36d9:	83 c4 10             	add    $0x10,%esp
    36dc:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(fd < 0){
    36df:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    36e3:	79 18                	jns    36fd <fsfull+0x13a>
      printf(1, "open %s failed\n", name);
    36e5:	83 ec 04             	sub    $0x4,%esp
    36e8:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    36eb:	50                   	push   %eax
    36ec:	68 5d 57 00 00       	push   $0x575d
    36f1:	6a 01                	push   $0x1
    36f3:	e8 71 06 00 00       	call   3d69 <printf>
    36f8:	83 c4 10             	add    $0x10,%esp
      break;
    36fb:	eb 6e                	jmp    376b <fsfull+0x1a8>
    }
    int total = 0;
    36fd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while(1){
      int cc = write(fd, buf, 512);
    3704:	83 ec 04             	sub    $0x4,%esp
    3707:	68 00 02 00 00       	push   $0x200
    370c:	68 c0 86 00 00       	push   $0x86c0
    3711:	ff 75 e8             	pushl  -0x18(%ebp)
    3714:	e8 f3 04 00 00       	call   3c0c <write>
    3719:	83 c4 10             	add    $0x10,%esp
    371c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(cc < 512)
    371f:	81 7d e4 ff 01 00 00 	cmpl   $0x1ff,-0x1c(%ebp)
    3726:	7f 2c                	jg     3754 <fsfull+0x191>
        break;
    3728:	90                   	nop
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    3729:	83 ec 04             	sub    $0x4,%esp
    372c:	ff 75 ec             	pushl  -0x14(%ebp)
    372f:	68 6d 57 00 00       	push   $0x576d
    3734:	6a 01                	push   $0x1
    3736:	e8 2e 06 00 00       	call   3d69 <printf>
    373b:	83 c4 10             	add    $0x10,%esp
    close(fd);
    373e:	83 ec 0c             	sub    $0xc,%esp
    3741:	ff 75 e8             	pushl  -0x18(%ebp)
    3744:	e8 cb 04 00 00       	call   3c14 <close>
    3749:	83 c4 10             	add    $0x10,%esp
    if(total == 0)
    374c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3750:	75 10                	jne    3762 <fsfull+0x19f>
    3752:	eb 0c                	jmp    3760 <fsfull+0x19d>
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
      total += cc;
    3754:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3757:	01 45 ec             	add    %eax,-0x14(%ebp)
      fsblocks++;
    375a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    }
    375e:	eb a4                	jmp    3704 <fsfull+0x141>
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
    3760:	eb 09                	jmp    376b <fsfull+0x1a8>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    3762:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
  }
    3766:	e9 7f fe ff ff       	jmp    35ea <fsfull+0x27>

  while(nfiles >= 0){
    376b:	e9 db 00 00 00       	jmp    384b <fsfull+0x288>
    char name[64];
    name[0] = 'f';
    3770:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    3774:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3777:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    377c:	89 c8                	mov    %ecx,%eax
    377e:	f7 ea                	imul   %edx
    3780:	c1 fa 06             	sar    $0x6,%edx
    3783:	89 c8                	mov    %ecx,%eax
    3785:	c1 f8 1f             	sar    $0x1f,%eax
    3788:	29 c2                	sub    %eax,%edx
    378a:	89 d0                	mov    %edx,%eax
    378c:	83 c0 30             	add    $0x30,%eax
    378f:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3792:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3795:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    379a:	89 d8                	mov    %ebx,%eax
    379c:	f7 ea                	imul   %edx
    379e:	c1 fa 06             	sar    $0x6,%edx
    37a1:	89 d8                	mov    %ebx,%eax
    37a3:	c1 f8 1f             	sar    $0x1f,%eax
    37a6:	89 d1                	mov    %edx,%ecx
    37a8:	29 c1                	sub    %eax,%ecx
    37aa:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    37b0:	29 c3                	sub    %eax,%ebx
    37b2:	89 d9                	mov    %ebx,%ecx
    37b4:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    37b9:	89 c8                	mov    %ecx,%eax
    37bb:	f7 ea                	imul   %edx
    37bd:	c1 fa 05             	sar    $0x5,%edx
    37c0:	89 c8                	mov    %ecx,%eax
    37c2:	c1 f8 1f             	sar    $0x1f,%eax
    37c5:	29 c2                	sub    %eax,%edx
    37c7:	89 d0                	mov    %edx,%eax
    37c9:	83 c0 30             	add    $0x30,%eax
    37cc:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    37cf:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    37d2:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    37d7:	89 d8                	mov    %ebx,%eax
    37d9:	f7 ea                	imul   %edx
    37db:	c1 fa 05             	sar    $0x5,%edx
    37de:	89 d8                	mov    %ebx,%eax
    37e0:	c1 f8 1f             	sar    $0x1f,%eax
    37e3:	89 d1                	mov    %edx,%ecx
    37e5:	29 c1                	sub    %eax,%ecx
    37e7:	6b c1 64             	imul   $0x64,%ecx,%eax
    37ea:	29 c3                	sub    %eax,%ebx
    37ec:	89 d9                	mov    %ebx,%ecx
    37ee:	ba 67 66 66 66       	mov    $0x66666667,%edx
    37f3:	89 c8                	mov    %ecx,%eax
    37f5:	f7 ea                	imul   %edx
    37f7:	c1 fa 02             	sar    $0x2,%edx
    37fa:	89 c8                	mov    %ecx,%eax
    37fc:	c1 f8 1f             	sar    $0x1f,%eax
    37ff:	29 c2                	sub    %eax,%edx
    3801:	89 d0                	mov    %edx,%eax
    3803:	83 c0 30             	add    $0x30,%eax
    3806:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    3809:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    380c:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3811:	89 c8                	mov    %ecx,%eax
    3813:	f7 ea                	imul   %edx
    3815:	c1 fa 02             	sar    $0x2,%edx
    3818:	89 c8                	mov    %ecx,%eax
    381a:	c1 f8 1f             	sar    $0x1f,%eax
    381d:	29 c2                	sub    %eax,%edx
    381f:	89 d0                	mov    %edx,%eax
    3821:	c1 e0 02             	shl    $0x2,%eax
    3824:	01 d0                	add    %edx,%eax
    3826:	01 c0                	add    %eax,%eax
    3828:	29 c1                	sub    %eax,%ecx
    382a:	89 ca                	mov    %ecx,%edx
    382c:	89 d0                	mov    %edx,%eax
    382e:	83 c0 30             	add    $0x30,%eax
    3831:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    3834:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    unlink(name);
    3838:	83 ec 0c             	sub    $0xc,%esp
    383b:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    383e:	50                   	push   %eax
    383f:	e8 f8 03 00 00       	call   3c3c <unlink>
    3844:	83 c4 10             	add    $0x10,%esp
    nfiles--;
    3847:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    384b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    384f:	0f 89 1b ff ff ff    	jns    3770 <fsfull+0x1ad>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
    3855:	83 ec 08             	sub    $0x8,%esp
    3858:	68 7d 57 00 00       	push   $0x577d
    385d:	6a 01                	push   $0x1
    385f:	e8 05 05 00 00       	call   3d69 <printf>
    3864:	83 c4 10             	add    $0x10,%esp
}
    3867:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    386a:	c9                   	leave  
    386b:	c3                   	ret    

0000386c <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    386c:	55                   	push   %ebp
    386d:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
    386f:	a1 78 5e 00 00       	mov    0x5e78,%eax
    3874:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    387a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    387f:	a3 78 5e 00 00       	mov    %eax,0x5e78
  return randstate;
    3884:	a1 78 5e 00 00       	mov    0x5e78,%eax
}
    3889:	5d                   	pop    %ebp
    388a:	c3                   	ret    

0000388b <main>:

int
main(int argc, char *argv[])
{
    388b:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    388f:	83 e4 f0             	and    $0xfffffff0,%esp
    3892:	ff 71 fc             	pushl  -0x4(%ecx)
    3895:	55                   	push   %ebp
    3896:	89 e5                	mov    %esp,%ebp
    3898:	51                   	push   %ecx
    3899:	83 ec 04             	sub    $0x4,%esp
  printf(1, "usertests starting\n");
    389c:	83 ec 08             	sub    $0x8,%esp
    389f:	68 93 57 00 00       	push   $0x5793
    38a4:	6a 01                	push   $0x1
    38a6:	e8 be 04 00 00       	call   3d69 <printf>
    38ab:	83 c4 10             	add    $0x10,%esp

  if(open("usertests.ran", 0) >= 0){
    38ae:	83 ec 08             	sub    $0x8,%esp
    38b1:	6a 00                	push   $0x0
    38b3:	68 a7 57 00 00       	push   $0x57a7
    38b8:	e8 6f 03 00 00       	call   3c2c <open>
    38bd:	83 c4 10             	add    $0x10,%esp
    38c0:	85 c0                	test   %eax,%eax
    38c2:	78 17                	js     38db <main+0x50>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    38c4:	83 ec 08             	sub    $0x8,%esp
    38c7:	68 b8 57 00 00       	push   $0x57b8
    38cc:	6a 01                	push   $0x1
    38ce:	e8 96 04 00 00       	call   3d69 <printf>
    38d3:	83 c4 10             	add    $0x10,%esp
    exit();
    38d6:	e8 11 03 00 00       	call   3bec <exit>
  }
  close(open("usertests.ran", O_CREATE));
    38db:	83 ec 08             	sub    $0x8,%esp
    38de:	68 00 02 00 00       	push   $0x200
    38e3:	68 a7 57 00 00       	push   $0x57a7
    38e8:	e8 3f 03 00 00       	call   3c2c <open>
    38ed:	83 c4 10             	add    $0x10,%esp
    38f0:	83 ec 0c             	sub    $0xc,%esp
    38f3:	50                   	push   %eax
    38f4:	e8 1b 03 00 00       	call   3c14 <close>
    38f9:	83 c4 10             	add    $0x10,%esp

  bigargtest();
    38fc:	e8 87 fb ff ff       	call   3488 <bigargtest>
  bigwrite();
    3901:	e8 ee ea ff ff       	call   23f4 <bigwrite>
  bigargtest();
    3906:	e8 7d fb ff ff       	call   3488 <bigargtest>
  bsstest();
    390b:	e8 03 fb ff ff       	call   3413 <bsstest>
  sbrktest();
    3910:	e8 12 f5 ff ff       	call   2e27 <sbrktest>
  validatetest();
    3915:	e8 1c fa ff ff       	call   3336 <validatetest>

  opentest();
    391a:	e8 e1 c6 ff ff       	call   0 <opentest>
  writetest();
    391f:	e8 8a c7 ff ff       	call   ae <writetest>
  writetest1();
    3924:	e8 94 c9 ff ff       	call   2bd <writetest1>
  createtest();
    3929:	e8 8c cb ff ff       	call   4ba <createtest>

  mem();
    392e:	e8 4f d1 ff ff       	call   a82 <mem>
  pipe1();
    3933:	e8 86 cd ff ff       	call   6be <pipe1>
  preempt();
    3938:	e8 6a cf ff ff       	call   8a7 <preempt>
  exitwait();
    393d:	e8 c8 d0 ff ff       	call   a0a <exitwait>

  rmdot();
    3942:	e8 22 ef ff ff       	call   2869 <rmdot>
  fourteen();
    3947:	e8 c2 ed ff ff       	call   270e <fourteen>
  bigfile();
    394c:	e8 a0 eb ff ff       	call   24f1 <bigfile>
  subdir();
    3951:	e8 5b e3 ff ff       	call   1cb1 <subdir>
  concreate();
    3956:	e8 ff dc ff ff       	call   165a <concreate>
  linkunlink();
    395b:	e8 a9 e0 ff ff       	call   1a09 <linkunlink>
  linktest();
    3960:	e8 b4 da ff ff       	call   1419 <linktest>
  unlinkread();
    3965:	e8 ee d8 ff ff       	call   1258 <unlinkread>
  createdelete();
    396a:	e8 44 d6 ff ff       	call   fb3 <createdelete>
  twofiles();
    396f:	e8 e1 d3 ff ff       	call   d55 <twofiles>
  sharedfd();
    3974:	e8 f9 d1 ff ff       	call   b72 <sharedfd>
  dirfile();
    3979:	e8 6f f0 ff ff       	call   29ed <dirfile>
  iref();
    397e:	e8 a1 f2 ff ff       	call   2c24 <iref>
  forktest();
    3983:	e8 d5 f3 ff ff       	call   2d5d <forktest>
  bigdir(); // slow
    3988:	e8 b4 e1 ff ff       	call   1b41 <bigdir>

  exectest();
    398d:	e8 da cc ff ff       	call   66c <exectest>

  exit();
    3992:	e8 55 02 00 00       	call   3bec <exit>

00003997 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    3997:	55                   	push   %ebp
    3998:	89 e5                	mov    %esp,%ebp
    399a:	57                   	push   %edi
    399b:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    399c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    399f:	8b 55 10             	mov    0x10(%ebp),%edx
    39a2:	8b 45 0c             	mov    0xc(%ebp),%eax
    39a5:	89 cb                	mov    %ecx,%ebx
    39a7:	89 df                	mov    %ebx,%edi
    39a9:	89 d1                	mov    %edx,%ecx
    39ab:	fc                   	cld    
    39ac:	f3 aa                	rep stos %al,%es:(%edi)
    39ae:	89 ca                	mov    %ecx,%edx
    39b0:	89 fb                	mov    %edi,%ebx
    39b2:	89 5d 08             	mov    %ebx,0x8(%ebp)
    39b5:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    39b8:	5b                   	pop    %ebx
    39b9:	5f                   	pop    %edi
    39ba:	5d                   	pop    %ebp
    39bb:	c3                   	ret    

000039bc <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    39bc:	55                   	push   %ebp
    39bd:	89 e5                	mov    %esp,%ebp
    39bf:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    39c2:	8b 45 08             	mov    0x8(%ebp),%eax
    39c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    39c8:	90                   	nop
    39c9:	8b 45 08             	mov    0x8(%ebp),%eax
    39cc:	8d 50 01             	lea    0x1(%eax),%edx
    39cf:	89 55 08             	mov    %edx,0x8(%ebp)
    39d2:	8b 55 0c             	mov    0xc(%ebp),%edx
    39d5:	8d 4a 01             	lea    0x1(%edx),%ecx
    39d8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    39db:	0f b6 12             	movzbl (%edx),%edx
    39de:	88 10                	mov    %dl,(%eax)
    39e0:	0f b6 00             	movzbl (%eax),%eax
    39e3:	84 c0                	test   %al,%al
    39e5:	75 e2                	jne    39c9 <strcpy+0xd>
    ;
  return os;
    39e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    39ea:	c9                   	leave  
    39eb:	c3                   	ret    

000039ec <strcmp>:

int
strcmp(const char *p, const char *q)
{
    39ec:	55                   	push   %ebp
    39ed:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    39ef:	eb 08                	jmp    39f9 <strcmp+0xd>
    p++, q++;
    39f1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    39f5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    39f9:	8b 45 08             	mov    0x8(%ebp),%eax
    39fc:	0f b6 00             	movzbl (%eax),%eax
    39ff:	84 c0                	test   %al,%al
    3a01:	74 10                	je     3a13 <strcmp+0x27>
    3a03:	8b 45 08             	mov    0x8(%ebp),%eax
    3a06:	0f b6 10             	movzbl (%eax),%edx
    3a09:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a0c:	0f b6 00             	movzbl (%eax),%eax
    3a0f:	38 c2                	cmp    %al,%dl
    3a11:	74 de                	je     39f1 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    3a13:	8b 45 08             	mov    0x8(%ebp),%eax
    3a16:	0f b6 00             	movzbl (%eax),%eax
    3a19:	0f b6 d0             	movzbl %al,%edx
    3a1c:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a1f:	0f b6 00             	movzbl (%eax),%eax
    3a22:	0f b6 c0             	movzbl %al,%eax
    3a25:	29 c2                	sub    %eax,%edx
    3a27:	89 d0                	mov    %edx,%eax
}
    3a29:	5d                   	pop    %ebp
    3a2a:	c3                   	ret    

00003a2b <strlen>:

uint
strlen(char *s)
{
    3a2b:	55                   	push   %ebp
    3a2c:	89 e5                	mov    %esp,%ebp
    3a2e:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    3a31:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    3a38:	eb 04                	jmp    3a3e <strlen+0x13>
    3a3a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    3a3e:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3a41:	8b 45 08             	mov    0x8(%ebp),%eax
    3a44:	01 d0                	add    %edx,%eax
    3a46:	0f b6 00             	movzbl (%eax),%eax
    3a49:	84 c0                	test   %al,%al
    3a4b:	75 ed                	jne    3a3a <strlen+0xf>
    ;
  return n;
    3a4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3a50:	c9                   	leave  
    3a51:	c3                   	ret    

00003a52 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3a52:	55                   	push   %ebp
    3a53:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    3a55:	8b 45 10             	mov    0x10(%ebp),%eax
    3a58:	50                   	push   %eax
    3a59:	ff 75 0c             	pushl  0xc(%ebp)
    3a5c:	ff 75 08             	pushl  0x8(%ebp)
    3a5f:	e8 33 ff ff ff       	call   3997 <stosb>
    3a64:	83 c4 0c             	add    $0xc,%esp
  return dst;
    3a67:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3a6a:	c9                   	leave  
    3a6b:	c3                   	ret    

00003a6c <strchr>:

char*
strchr(const char *s, char c)
{
    3a6c:	55                   	push   %ebp
    3a6d:	89 e5                	mov    %esp,%ebp
    3a6f:	83 ec 04             	sub    $0x4,%esp
    3a72:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a75:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    3a78:	eb 14                	jmp    3a8e <strchr+0x22>
    if(*s == c)
    3a7a:	8b 45 08             	mov    0x8(%ebp),%eax
    3a7d:	0f b6 00             	movzbl (%eax),%eax
    3a80:	3a 45 fc             	cmp    -0x4(%ebp),%al
    3a83:	75 05                	jne    3a8a <strchr+0x1e>
      return (char*)s;
    3a85:	8b 45 08             	mov    0x8(%ebp),%eax
    3a88:	eb 13                	jmp    3a9d <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    3a8a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3a8e:	8b 45 08             	mov    0x8(%ebp),%eax
    3a91:	0f b6 00             	movzbl (%eax),%eax
    3a94:	84 c0                	test   %al,%al
    3a96:	75 e2                	jne    3a7a <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    3a98:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3a9d:	c9                   	leave  
    3a9e:	c3                   	ret    

00003a9f <gets>:

char*
gets(char *buf, int max)
{
    3a9f:	55                   	push   %ebp
    3aa0:	89 e5                	mov    %esp,%ebp
    3aa2:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3aa5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3aac:	eb 44                	jmp    3af2 <gets+0x53>
    cc = read(0, &c, 1);
    3aae:	83 ec 04             	sub    $0x4,%esp
    3ab1:	6a 01                	push   $0x1
    3ab3:	8d 45 ef             	lea    -0x11(%ebp),%eax
    3ab6:	50                   	push   %eax
    3ab7:	6a 00                	push   $0x0
    3ab9:	e8 46 01 00 00       	call   3c04 <read>
    3abe:	83 c4 10             	add    $0x10,%esp
    3ac1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    3ac4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3ac8:	7f 02                	jg     3acc <gets+0x2d>
      break;
    3aca:	eb 31                	jmp    3afd <gets+0x5e>
    buf[i++] = c;
    3acc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3acf:	8d 50 01             	lea    0x1(%eax),%edx
    3ad2:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3ad5:	89 c2                	mov    %eax,%edx
    3ad7:	8b 45 08             	mov    0x8(%ebp),%eax
    3ada:	01 c2                	add    %eax,%edx
    3adc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3ae0:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    3ae2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3ae6:	3c 0a                	cmp    $0xa,%al
    3ae8:	74 13                	je     3afd <gets+0x5e>
    3aea:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3aee:	3c 0d                	cmp    $0xd,%al
    3af0:	74 0b                	je     3afd <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3af2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3af5:	83 c0 01             	add    $0x1,%eax
    3af8:	3b 45 0c             	cmp    0xc(%ebp),%eax
    3afb:	7c b1                	jl     3aae <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3afd:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3b00:	8b 45 08             	mov    0x8(%ebp),%eax
    3b03:	01 d0                	add    %edx,%eax
    3b05:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    3b08:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3b0b:	c9                   	leave  
    3b0c:	c3                   	ret    

00003b0d <stat>:

int
stat(char *n, struct stat *st)
{
    3b0d:	55                   	push   %ebp
    3b0e:	89 e5                	mov    %esp,%ebp
    3b10:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3b13:	83 ec 08             	sub    $0x8,%esp
    3b16:	6a 00                	push   $0x0
    3b18:	ff 75 08             	pushl  0x8(%ebp)
    3b1b:	e8 0c 01 00 00       	call   3c2c <open>
    3b20:	83 c4 10             	add    $0x10,%esp
    3b23:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    3b26:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3b2a:	79 07                	jns    3b33 <stat+0x26>
    return -1;
    3b2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3b31:	eb 25                	jmp    3b58 <stat+0x4b>
  r = fstat(fd, st);
    3b33:	83 ec 08             	sub    $0x8,%esp
    3b36:	ff 75 0c             	pushl  0xc(%ebp)
    3b39:	ff 75 f4             	pushl  -0xc(%ebp)
    3b3c:	e8 03 01 00 00       	call   3c44 <fstat>
    3b41:	83 c4 10             	add    $0x10,%esp
    3b44:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    3b47:	83 ec 0c             	sub    $0xc,%esp
    3b4a:	ff 75 f4             	pushl  -0xc(%ebp)
    3b4d:	e8 c2 00 00 00       	call   3c14 <close>
    3b52:	83 c4 10             	add    $0x10,%esp
  return r;
    3b55:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    3b58:	c9                   	leave  
    3b59:	c3                   	ret    

00003b5a <atoi>:

int
atoi(const char *s)
{
    3b5a:	55                   	push   %ebp
    3b5b:	89 e5                	mov    %esp,%ebp
    3b5d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    3b60:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    3b67:	eb 25                	jmp    3b8e <atoi+0x34>
    n = n*10 + *s++ - '0';
    3b69:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3b6c:	89 d0                	mov    %edx,%eax
    3b6e:	c1 e0 02             	shl    $0x2,%eax
    3b71:	01 d0                	add    %edx,%eax
    3b73:	01 c0                	add    %eax,%eax
    3b75:	89 c1                	mov    %eax,%ecx
    3b77:	8b 45 08             	mov    0x8(%ebp),%eax
    3b7a:	8d 50 01             	lea    0x1(%eax),%edx
    3b7d:	89 55 08             	mov    %edx,0x8(%ebp)
    3b80:	0f b6 00             	movzbl (%eax),%eax
    3b83:	0f be c0             	movsbl %al,%eax
    3b86:	01 c8                	add    %ecx,%eax
    3b88:	83 e8 30             	sub    $0x30,%eax
    3b8b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3b8e:	8b 45 08             	mov    0x8(%ebp),%eax
    3b91:	0f b6 00             	movzbl (%eax),%eax
    3b94:	3c 2f                	cmp    $0x2f,%al
    3b96:	7e 0a                	jle    3ba2 <atoi+0x48>
    3b98:	8b 45 08             	mov    0x8(%ebp),%eax
    3b9b:	0f b6 00             	movzbl (%eax),%eax
    3b9e:	3c 39                	cmp    $0x39,%al
    3ba0:	7e c7                	jle    3b69 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    3ba2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3ba5:	c9                   	leave  
    3ba6:	c3                   	ret    

00003ba7 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3ba7:	55                   	push   %ebp
    3ba8:	89 e5                	mov    %esp,%ebp
    3baa:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    3bad:	8b 45 08             	mov    0x8(%ebp),%eax
    3bb0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    3bb3:	8b 45 0c             	mov    0xc(%ebp),%eax
    3bb6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    3bb9:	eb 17                	jmp    3bd2 <memmove+0x2b>
    *dst++ = *src++;
    3bbb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3bbe:	8d 50 01             	lea    0x1(%eax),%edx
    3bc1:	89 55 fc             	mov    %edx,-0x4(%ebp)
    3bc4:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3bc7:	8d 4a 01             	lea    0x1(%edx),%ecx
    3bca:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    3bcd:	0f b6 12             	movzbl (%edx),%edx
    3bd0:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3bd2:	8b 45 10             	mov    0x10(%ebp),%eax
    3bd5:	8d 50 ff             	lea    -0x1(%eax),%edx
    3bd8:	89 55 10             	mov    %edx,0x10(%ebp)
    3bdb:	85 c0                	test   %eax,%eax
    3bdd:	7f dc                	jg     3bbb <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    3bdf:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3be2:	c9                   	leave  
    3be3:	c3                   	ret    

00003be4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3be4:	b8 01 00 00 00       	mov    $0x1,%eax
    3be9:	cd 40                	int    $0x40
    3beb:	c3                   	ret    

00003bec <exit>:
SYSCALL(exit)
    3bec:	b8 02 00 00 00       	mov    $0x2,%eax
    3bf1:	cd 40                	int    $0x40
    3bf3:	c3                   	ret    

00003bf4 <wait>:
SYSCALL(wait)
    3bf4:	b8 03 00 00 00       	mov    $0x3,%eax
    3bf9:	cd 40                	int    $0x40
    3bfb:	c3                   	ret    

00003bfc <pipe>:
SYSCALL(pipe)
    3bfc:	b8 04 00 00 00       	mov    $0x4,%eax
    3c01:	cd 40                	int    $0x40
    3c03:	c3                   	ret    

00003c04 <read>:
SYSCALL(read)
    3c04:	b8 05 00 00 00       	mov    $0x5,%eax
    3c09:	cd 40                	int    $0x40
    3c0b:	c3                   	ret    

00003c0c <write>:
SYSCALL(write)
    3c0c:	b8 10 00 00 00       	mov    $0x10,%eax
    3c11:	cd 40                	int    $0x40
    3c13:	c3                   	ret    

00003c14 <close>:
SYSCALL(close)
    3c14:	b8 15 00 00 00       	mov    $0x15,%eax
    3c19:	cd 40                	int    $0x40
    3c1b:	c3                   	ret    

00003c1c <kill>:
SYSCALL(kill)
    3c1c:	b8 06 00 00 00       	mov    $0x6,%eax
    3c21:	cd 40                	int    $0x40
    3c23:	c3                   	ret    

00003c24 <exec>:
SYSCALL(exec)
    3c24:	b8 07 00 00 00       	mov    $0x7,%eax
    3c29:	cd 40                	int    $0x40
    3c2b:	c3                   	ret    

00003c2c <open>:
SYSCALL(open)
    3c2c:	b8 0f 00 00 00       	mov    $0xf,%eax
    3c31:	cd 40                	int    $0x40
    3c33:	c3                   	ret    

00003c34 <mknod>:
SYSCALL(mknod)
    3c34:	b8 11 00 00 00       	mov    $0x11,%eax
    3c39:	cd 40                	int    $0x40
    3c3b:	c3                   	ret    

00003c3c <unlink>:
SYSCALL(unlink)
    3c3c:	b8 12 00 00 00       	mov    $0x12,%eax
    3c41:	cd 40                	int    $0x40
    3c43:	c3                   	ret    

00003c44 <fstat>:
SYSCALL(fstat)
    3c44:	b8 08 00 00 00       	mov    $0x8,%eax
    3c49:	cd 40                	int    $0x40
    3c4b:	c3                   	ret    

00003c4c <link>:
SYSCALL(link)
    3c4c:	b8 13 00 00 00       	mov    $0x13,%eax
    3c51:	cd 40                	int    $0x40
    3c53:	c3                   	ret    

00003c54 <mkdir>:
SYSCALL(mkdir)
    3c54:	b8 14 00 00 00       	mov    $0x14,%eax
    3c59:	cd 40                	int    $0x40
    3c5b:	c3                   	ret    

00003c5c <chdir>:
SYSCALL(chdir)
    3c5c:	b8 09 00 00 00       	mov    $0x9,%eax
    3c61:	cd 40                	int    $0x40
    3c63:	c3                   	ret    

00003c64 <dup>:
SYSCALL(dup)
    3c64:	b8 0a 00 00 00       	mov    $0xa,%eax
    3c69:	cd 40                	int    $0x40
    3c6b:	c3                   	ret    

00003c6c <getpid>:
SYSCALL(getpid)
    3c6c:	b8 0b 00 00 00       	mov    $0xb,%eax
    3c71:	cd 40                	int    $0x40
    3c73:	c3                   	ret    

00003c74 <sbrk>:
SYSCALL(sbrk)
    3c74:	b8 0c 00 00 00       	mov    $0xc,%eax
    3c79:	cd 40                	int    $0x40
    3c7b:	c3                   	ret    

00003c7c <sleep>:
SYSCALL(sleep)
    3c7c:	b8 0d 00 00 00       	mov    $0xd,%eax
    3c81:	cd 40                	int    $0x40
    3c83:	c3                   	ret    

00003c84 <uptime>:
SYSCALL(uptime)
    3c84:	b8 0e 00 00 00       	mov    $0xe,%eax
    3c89:	cd 40                	int    $0x40
    3c8b:	c3                   	ret    

00003c8c <getcwd>:
SYSCALL(getcwd)
    3c8c:	b8 16 00 00 00       	mov    $0x16,%eax
    3c91:	cd 40                	int    $0x40
    3c93:	c3                   	ret    

00003c94 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    3c94:	55                   	push   %ebp
    3c95:	89 e5                	mov    %esp,%ebp
    3c97:	83 ec 18             	sub    $0x18,%esp
    3c9a:	8b 45 0c             	mov    0xc(%ebp),%eax
    3c9d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    3ca0:	83 ec 04             	sub    $0x4,%esp
    3ca3:	6a 01                	push   $0x1
    3ca5:	8d 45 f4             	lea    -0xc(%ebp),%eax
    3ca8:	50                   	push   %eax
    3ca9:	ff 75 08             	pushl  0x8(%ebp)
    3cac:	e8 5b ff ff ff       	call   3c0c <write>
    3cb1:	83 c4 10             	add    $0x10,%esp
}
    3cb4:	c9                   	leave  
    3cb5:	c3                   	ret    

00003cb6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3cb6:	55                   	push   %ebp
    3cb7:	89 e5                	mov    %esp,%ebp
    3cb9:	53                   	push   %ebx
    3cba:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    3cbd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    3cc4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    3cc8:	74 17                	je     3ce1 <printint+0x2b>
    3cca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    3cce:	79 11                	jns    3ce1 <printint+0x2b>
    neg = 1;
    3cd0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    3cd7:	8b 45 0c             	mov    0xc(%ebp),%eax
    3cda:	f7 d8                	neg    %eax
    3cdc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3cdf:	eb 06                	jmp    3ce7 <printint+0x31>
  } else {
    x = xx;
    3ce1:	8b 45 0c             	mov    0xc(%ebp),%eax
    3ce4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    3ce7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    3cee:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3cf1:	8d 41 01             	lea    0x1(%ecx),%eax
    3cf4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3cf7:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3cfa:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3cfd:	ba 00 00 00 00       	mov    $0x0,%edx
    3d02:	f7 f3                	div    %ebx
    3d04:	89 d0                	mov    %edx,%eax
    3d06:	0f b6 80 7c 5e 00 00 	movzbl 0x5e7c(%eax),%eax
    3d0d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    3d11:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3d14:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3d17:	ba 00 00 00 00       	mov    $0x0,%edx
    3d1c:	f7 f3                	div    %ebx
    3d1e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3d21:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3d25:	75 c7                	jne    3cee <printint+0x38>
  if(neg)
    3d27:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3d2b:	74 0e                	je     3d3b <printint+0x85>
    buf[i++] = '-';
    3d2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d30:	8d 50 01             	lea    0x1(%eax),%edx
    3d33:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3d36:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    3d3b:	eb 1d                	jmp    3d5a <printint+0xa4>
    putc(fd, buf[i]);
    3d3d:	8d 55 dc             	lea    -0x24(%ebp),%edx
    3d40:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d43:	01 d0                	add    %edx,%eax
    3d45:	0f b6 00             	movzbl (%eax),%eax
    3d48:	0f be c0             	movsbl %al,%eax
    3d4b:	83 ec 08             	sub    $0x8,%esp
    3d4e:	50                   	push   %eax
    3d4f:	ff 75 08             	pushl  0x8(%ebp)
    3d52:	e8 3d ff ff ff       	call   3c94 <putc>
    3d57:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    3d5a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    3d5e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3d62:	79 d9                	jns    3d3d <printint+0x87>
    putc(fd, buf[i]);
}
    3d64:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3d67:	c9                   	leave  
    3d68:	c3                   	ret    

00003d69 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3d69:	55                   	push   %ebp
    3d6a:	89 e5                	mov    %esp,%ebp
    3d6c:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    3d6f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    3d76:	8d 45 0c             	lea    0xc(%ebp),%eax
    3d79:	83 c0 04             	add    $0x4,%eax
    3d7c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    3d7f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3d86:	e9 59 01 00 00       	jmp    3ee4 <printf+0x17b>
    c = fmt[i] & 0xff;
    3d8b:	8b 55 0c             	mov    0xc(%ebp),%edx
    3d8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3d91:	01 d0                	add    %edx,%eax
    3d93:	0f b6 00             	movzbl (%eax),%eax
    3d96:	0f be c0             	movsbl %al,%eax
    3d99:	25 ff 00 00 00       	and    $0xff,%eax
    3d9e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    3da1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3da5:	75 2c                	jne    3dd3 <printf+0x6a>
      if(c == '%'){
    3da7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    3dab:	75 0c                	jne    3db9 <printf+0x50>
        state = '%';
    3dad:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    3db4:	e9 27 01 00 00       	jmp    3ee0 <printf+0x177>
      } else {
        putc(fd, c);
    3db9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3dbc:	0f be c0             	movsbl %al,%eax
    3dbf:	83 ec 08             	sub    $0x8,%esp
    3dc2:	50                   	push   %eax
    3dc3:	ff 75 08             	pushl  0x8(%ebp)
    3dc6:	e8 c9 fe ff ff       	call   3c94 <putc>
    3dcb:	83 c4 10             	add    $0x10,%esp
    3dce:	e9 0d 01 00 00       	jmp    3ee0 <printf+0x177>
      }
    } else if(state == '%'){
    3dd3:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    3dd7:	0f 85 03 01 00 00    	jne    3ee0 <printf+0x177>
      if(c == 'd'){
    3ddd:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    3de1:	75 1e                	jne    3e01 <printf+0x98>
        printint(fd, *ap, 10, 1);
    3de3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3de6:	8b 00                	mov    (%eax),%eax
    3de8:	6a 01                	push   $0x1
    3dea:	6a 0a                	push   $0xa
    3dec:	50                   	push   %eax
    3ded:	ff 75 08             	pushl  0x8(%ebp)
    3df0:	e8 c1 fe ff ff       	call   3cb6 <printint>
    3df5:	83 c4 10             	add    $0x10,%esp
        ap++;
    3df8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3dfc:	e9 d8 00 00 00       	jmp    3ed9 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    3e01:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    3e05:	74 06                	je     3e0d <printf+0xa4>
    3e07:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    3e0b:	75 1e                	jne    3e2b <printf+0xc2>
        printint(fd, *ap, 16, 0);
    3e0d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3e10:	8b 00                	mov    (%eax),%eax
    3e12:	6a 00                	push   $0x0
    3e14:	6a 10                	push   $0x10
    3e16:	50                   	push   %eax
    3e17:	ff 75 08             	pushl  0x8(%ebp)
    3e1a:	e8 97 fe ff ff       	call   3cb6 <printint>
    3e1f:	83 c4 10             	add    $0x10,%esp
        ap++;
    3e22:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3e26:	e9 ae 00 00 00       	jmp    3ed9 <printf+0x170>
      } else if(c == 's'){
    3e2b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    3e2f:	75 43                	jne    3e74 <printf+0x10b>
        s = (char*)*ap;
    3e31:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3e34:	8b 00                	mov    (%eax),%eax
    3e36:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    3e39:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    3e3d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3e41:	75 07                	jne    3e4a <printf+0xe1>
          s = "(null)";
    3e43:	c7 45 f4 e2 57 00 00 	movl   $0x57e2,-0xc(%ebp)
        while(*s != 0){
    3e4a:	eb 1c                	jmp    3e68 <printf+0xff>
          putc(fd, *s);
    3e4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e4f:	0f b6 00             	movzbl (%eax),%eax
    3e52:	0f be c0             	movsbl %al,%eax
    3e55:	83 ec 08             	sub    $0x8,%esp
    3e58:	50                   	push   %eax
    3e59:	ff 75 08             	pushl  0x8(%ebp)
    3e5c:	e8 33 fe ff ff       	call   3c94 <putc>
    3e61:	83 c4 10             	add    $0x10,%esp
          s++;
    3e64:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    3e68:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e6b:	0f b6 00             	movzbl (%eax),%eax
    3e6e:	84 c0                	test   %al,%al
    3e70:	75 da                	jne    3e4c <printf+0xe3>
    3e72:	eb 65                	jmp    3ed9 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3e74:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    3e78:	75 1d                	jne    3e97 <printf+0x12e>
        putc(fd, *ap);
    3e7a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3e7d:	8b 00                	mov    (%eax),%eax
    3e7f:	0f be c0             	movsbl %al,%eax
    3e82:	83 ec 08             	sub    $0x8,%esp
    3e85:	50                   	push   %eax
    3e86:	ff 75 08             	pushl  0x8(%ebp)
    3e89:	e8 06 fe ff ff       	call   3c94 <putc>
    3e8e:	83 c4 10             	add    $0x10,%esp
        ap++;
    3e91:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3e95:	eb 42                	jmp    3ed9 <printf+0x170>
      } else if(c == '%'){
    3e97:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    3e9b:	75 17                	jne    3eb4 <printf+0x14b>
        putc(fd, c);
    3e9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3ea0:	0f be c0             	movsbl %al,%eax
    3ea3:	83 ec 08             	sub    $0x8,%esp
    3ea6:	50                   	push   %eax
    3ea7:	ff 75 08             	pushl  0x8(%ebp)
    3eaa:	e8 e5 fd ff ff       	call   3c94 <putc>
    3eaf:	83 c4 10             	add    $0x10,%esp
    3eb2:	eb 25                	jmp    3ed9 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3eb4:	83 ec 08             	sub    $0x8,%esp
    3eb7:	6a 25                	push   $0x25
    3eb9:	ff 75 08             	pushl  0x8(%ebp)
    3ebc:	e8 d3 fd ff ff       	call   3c94 <putc>
    3ec1:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    3ec4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3ec7:	0f be c0             	movsbl %al,%eax
    3eca:	83 ec 08             	sub    $0x8,%esp
    3ecd:	50                   	push   %eax
    3ece:	ff 75 08             	pushl  0x8(%ebp)
    3ed1:	e8 be fd ff ff       	call   3c94 <putc>
    3ed6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    3ed9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3ee0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3ee4:	8b 55 0c             	mov    0xc(%ebp),%edx
    3ee7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3eea:	01 d0                	add    %edx,%eax
    3eec:	0f b6 00             	movzbl (%eax),%eax
    3eef:	84 c0                	test   %al,%al
    3ef1:	0f 85 94 fe ff ff    	jne    3d8b <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3ef7:	c9                   	leave  
    3ef8:	c3                   	ret    

00003ef9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3ef9:	55                   	push   %ebp
    3efa:	89 e5                	mov    %esp,%ebp
    3efc:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3eff:	8b 45 08             	mov    0x8(%ebp),%eax
    3f02:	83 e8 08             	sub    $0x8,%eax
    3f05:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3f08:	a1 48 5f 00 00       	mov    0x5f48,%eax
    3f0d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    3f10:	eb 24                	jmp    3f36 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3f12:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f15:	8b 00                	mov    (%eax),%eax
    3f17:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3f1a:	77 12                	ja     3f2e <free+0x35>
    3f1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f1f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3f22:	77 24                	ja     3f48 <free+0x4f>
    3f24:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f27:	8b 00                	mov    (%eax),%eax
    3f29:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    3f2c:	77 1a                	ja     3f48 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3f2e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f31:	8b 00                	mov    (%eax),%eax
    3f33:	89 45 fc             	mov    %eax,-0x4(%ebp)
    3f36:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f39:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3f3c:	76 d4                	jbe    3f12 <free+0x19>
    3f3e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f41:	8b 00                	mov    (%eax),%eax
    3f43:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    3f46:	76 ca                	jbe    3f12 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    3f48:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f4b:	8b 40 04             	mov    0x4(%eax),%eax
    3f4e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    3f55:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f58:	01 c2                	add    %eax,%edx
    3f5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f5d:	8b 00                	mov    (%eax),%eax
    3f5f:	39 c2                	cmp    %eax,%edx
    3f61:	75 24                	jne    3f87 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    3f63:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f66:	8b 50 04             	mov    0x4(%eax),%edx
    3f69:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f6c:	8b 00                	mov    (%eax),%eax
    3f6e:	8b 40 04             	mov    0x4(%eax),%eax
    3f71:	01 c2                	add    %eax,%edx
    3f73:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f76:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    3f79:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f7c:	8b 00                	mov    (%eax),%eax
    3f7e:	8b 10                	mov    (%eax),%edx
    3f80:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f83:	89 10                	mov    %edx,(%eax)
    3f85:	eb 0a                	jmp    3f91 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    3f87:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f8a:	8b 10                	mov    (%eax),%edx
    3f8c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f8f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    3f91:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f94:	8b 40 04             	mov    0x4(%eax),%eax
    3f97:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    3f9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fa1:	01 d0                	add    %edx,%eax
    3fa3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    3fa6:	75 20                	jne    3fc8 <free+0xcf>
    p->s.size += bp->s.size;
    3fa8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fab:	8b 50 04             	mov    0x4(%eax),%edx
    3fae:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fb1:	8b 40 04             	mov    0x4(%eax),%eax
    3fb4:	01 c2                	add    %eax,%edx
    3fb6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fb9:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3fbc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fbf:	8b 10                	mov    (%eax),%edx
    3fc1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fc4:	89 10                	mov    %edx,(%eax)
    3fc6:	eb 08                	jmp    3fd0 <free+0xd7>
  } else
    p->s.ptr = bp;
    3fc8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fcb:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3fce:	89 10                	mov    %edx,(%eax)
  freep = p;
    3fd0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fd3:	a3 48 5f 00 00       	mov    %eax,0x5f48
}
    3fd8:	c9                   	leave  
    3fd9:	c3                   	ret    

00003fda <morecore>:

static Header*
morecore(uint nu)
{
    3fda:	55                   	push   %ebp
    3fdb:	89 e5                	mov    %esp,%ebp
    3fdd:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    3fe0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    3fe7:	77 07                	ja     3ff0 <morecore+0x16>
    nu = 4096;
    3fe9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    3ff0:	8b 45 08             	mov    0x8(%ebp),%eax
    3ff3:	c1 e0 03             	shl    $0x3,%eax
    3ff6:	83 ec 0c             	sub    $0xc,%esp
    3ff9:	50                   	push   %eax
    3ffa:	e8 75 fc ff ff       	call   3c74 <sbrk>
    3fff:	83 c4 10             	add    $0x10,%esp
    4002:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    4005:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    4009:	75 07                	jne    4012 <morecore+0x38>
    return 0;
    400b:	b8 00 00 00 00       	mov    $0x0,%eax
    4010:	eb 26                	jmp    4038 <morecore+0x5e>
  hp = (Header*)p;
    4012:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4015:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    4018:	8b 45 f0             	mov    -0x10(%ebp),%eax
    401b:	8b 55 08             	mov    0x8(%ebp),%edx
    401e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    4021:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4024:	83 c0 08             	add    $0x8,%eax
    4027:	83 ec 0c             	sub    $0xc,%esp
    402a:	50                   	push   %eax
    402b:	e8 c9 fe ff ff       	call   3ef9 <free>
    4030:	83 c4 10             	add    $0x10,%esp
  return freep;
    4033:	a1 48 5f 00 00       	mov    0x5f48,%eax
}
    4038:	c9                   	leave  
    4039:	c3                   	ret    

0000403a <malloc>:

void*
malloc(uint nbytes)
{
    403a:	55                   	push   %ebp
    403b:	89 e5                	mov    %esp,%ebp
    403d:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4040:	8b 45 08             	mov    0x8(%ebp),%eax
    4043:	83 c0 07             	add    $0x7,%eax
    4046:	c1 e8 03             	shr    $0x3,%eax
    4049:	83 c0 01             	add    $0x1,%eax
    404c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    404f:	a1 48 5f 00 00       	mov    0x5f48,%eax
    4054:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4057:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    405b:	75 23                	jne    4080 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    405d:	c7 45 f0 40 5f 00 00 	movl   $0x5f40,-0x10(%ebp)
    4064:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4067:	a3 48 5f 00 00       	mov    %eax,0x5f48
    406c:	a1 48 5f 00 00       	mov    0x5f48,%eax
    4071:	a3 40 5f 00 00       	mov    %eax,0x5f40
    base.s.size = 0;
    4076:	c7 05 44 5f 00 00 00 	movl   $0x0,0x5f44
    407d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4080:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4083:	8b 00                	mov    (%eax),%eax
    4085:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    4088:	8b 45 f4             	mov    -0xc(%ebp),%eax
    408b:	8b 40 04             	mov    0x4(%eax),%eax
    408e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    4091:	72 4d                	jb     40e0 <malloc+0xa6>
      if(p->s.size == nunits)
    4093:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4096:	8b 40 04             	mov    0x4(%eax),%eax
    4099:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    409c:	75 0c                	jne    40aa <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    409e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40a1:	8b 10                	mov    (%eax),%edx
    40a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    40a6:	89 10                	mov    %edx,(%eax)
    40a8:	eb 26                	jmp    40d0 <malloc+0x96>
      else {
        p->s.size -= nunits;
    40aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40ad:	8b 40 04             	mov    0x4(%eax),%eax
    40b0:	2b 45 ec             	sub    -0x14(%ebp),%eax
    40b3:	89 c2                	mov    %eax,%edx
    40b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40b8:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    40bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40be:	8b 40 04             	mov    0x4(%eax),%eax
    40c1:	c1 e0 03             	shl    $0x3,%eax
    40c4:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    40c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40ca:	8b 55 ec             	mov    -0x14(%ebp),%edx
    40cd:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    40d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    40d3:	a3 48 5f 00 00       	mov    %eax,0x5f48
      return (void*)(p + 1);
    40d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40db:	83 c0 08             	add    $0x8,%eax
    40de:	eb 3b                	jmp    411b <malloc+0xe1>
    }
    if(p == freep)
    40e0:	a1 48 5f 00 00       	mov    0x5f48,%eax
    40e5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    40e8:	75 1e                	jne    4108 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    40ea:	83 ec 0c             	sub    $0xc,%esp
    40ed:	ff 75 ec             	pushl  -0x14(%ebp)
    40f0:	e8 e5 fe ff ff       	call   3fda <morecore>
    40f5:	83 c4 10             	add    $0x10,%esp
    40f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    40fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    40ff:	75 07                	jne    4108 <malloc+0xce>
        return 0;
    4101:	b8 00 00 00 00       	mov    $0x0,%eax
    4106:	eb 13                	jmp    411b <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4108:	8b 45 f4             	mov    -0xc(%ebp),%eax
    410b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    410e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4111:	8b 00                	mov    (%eax),%eax
    4113:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    4116:	e9 6d ff ff ff       	jmp    4088 <malloc+0x4e>
}
    411b:	c9                   	leave  
    411c:	c3                   	ret    
