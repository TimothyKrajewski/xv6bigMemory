
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <opentest>:
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
       6:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
       b:	83 ec 08             	sub    $0x8,%esp
       e:	68 3e 41 00 00       	push   $0x413e
      13:	50                   	push   %eax
      14:	e8 58 3d 00 00       	call   3d71 <printf>
      19:	83 c4 10             	add    $0x10,%esp
      1c:	83 ec 08             	sub    $0x8,%esp
      1f:	6a 00                	push   $0x0
      21:	68 28 41 00 00       	push   $0x4128
      26:	e8 01 3c 00 00       	call   3c2c <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      31:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      35:	79 1b                	jns    52 <opentest+0x52>
      37:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
      3c:	83 ec 08             	sub    $0x8,%esp
      3f:	68 49 41 00 00       	push   $0x4149
      44:	50                   	push   %eax
      45:	e8 27 3d 00 00       	call   3d71 <printf>
      4a:	83 c4 10             	add    $0x10,%esp
      4d:	e8 9a 3b 00 00       	call   3bec <exit>
      52:	83 ec 0c             	sub    $0xc,%esp
      55:	ff 75 f4             	pushl  -0xc(%ebp)
      58:	e8 b7 3b 00 00       	call   3c14 <close>
      5d:	83 c4 10             	add    $0x10,%esp
      60:	83 ec 08             	sub    $0x8,%esp
      63:	6a 00                	push   $0x0
      65:	68 5c 41 00 00       	push   $0x415c
      6a:	e8 bd 3b 00 00       	call   3c2c <open>
      6f:	83 c4 10             	add    $0x10,%esp
      72:	89 45 f4             	mov    %eax,-0xc(%ebp)
      75:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      79:	78 1b                	js     96 <opentest+0x96>
      7b:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
      80:	83 ec 08             	sub    $0x8,%esp
      83:	68 69 41 00 00       	push   $0x4169
      88:	50                   	push   %eax
      89:	e8 e3 3c 00 00       	call   3d71 <printf>
      8e:	83 c4 10             	add    $0x10,%esp
      91:	e8 56 3b 00 00       	call   3bec <exit>
      96:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
      9b:	83 ec 08             	sub    $0x8,%esp
      9e:	68 87 41 00 00       	push   $0x4187
      a3:	50                   	push   %eax
      a4:	e8 c8 3c 00 00       	call   3d71 <printf>
      a9:	83 c4 10             	add    $0x10,%esp
      ac:	c9                   	leave  
      ad:	c3                   	ret    

000000ae <writetest>:
      ae:	55                   	push   %ebp
      af:	89 e5                	mov    %esp,%ebp
      b1:	83 ec 18             	sub    $0x18,%esp
      b4:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
      b9:	83 ec 08             	sub    $0x8,%esp
      bc:	68 95 41 00 00       	push   $0x4195
      c1:	50                   	push   %eax
      c2:	e8 aa 3c 00 00       	call   3d71 <printf>
      c7:	83 c4 10             	add    $0x10,%esp
      ca:	83 ec 08             	sub    $0x8,%esp
      cd:	68 02 02 00 00       	push   $0x202
      d2:	68 a6 41 00 00       	push   $0x41a6
      d7:	e8 50 3b 00 00       	call   3c2c <open>
      dc:	83 c4 10             	add    $0x10,%esp
      df:	89 45 f0             	mov    %eax,-0x10(%ebp)
      e2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      e6:	78 22                	js     10a <writetest+0x5c>
      e8:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
      ed:	83 ec 08             	sub    $0x8,%esp
      f0:	68 ac 41 00 00       	push   $0x41ac
      f5:	50                   	push   %eax
      f6:	e8 76 3c 00 00       	call   3d71 <printf>
      fb:	83 c4 10             	add    $0x10,%esp
      fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     105:	e9 8f 00 00 00       	jmp    199 <writetest+0xeb>
     10a:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     10f:	83 ec 08             	sub    $0x8,%esp
     112:	68 c7 41 00 00       	push   $0x41c7
     117:	50                   	push   %eax
     118:	e8 54 3c 00 00       	call   3d71 <printf>
     11d:	83 c4 10             	add    $0x10,%esp
     120:	e8 c7 3a 00 00       	call   3bec <exit>
     125:	83 ec 04             	sub    $0x4,%esp
     128:	6a 0a                	push   $0xa
     12a:	68 e3 41 00 00       	push   $0x41e3
     12f:	ff 75 f0             	pushl  -0x10(%ebp)
     132:	e8 d5 3a 00 00       	call   3c0c <write>
     137:	83 c4 10             	add    $0x10,%esp
     13a:	83 f8 0a             	cmp    $0xa,%eax
     13d:	74 1e                	je     15d <writetest+0xaf>
     13f:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     144:	83 ec 04             	sub    $0x4,%esp
     147:	ff 75 f4             	pushl  -0xc(%ebp)
     14a:	68 f0 41 00 00       	push   $0x41f0
     14f:	50                   	push   %eax
     150:	e8 1c 3c 00 00       	call   3d71 <printf>
     155:	83 c4 10             	add    $0x10,%esp
     158:	e8 8f 3a 00 00       	call   3bec <exit>
     15d:	83 ec 04             	sub    $0x4,%esp
     160:	6a 0a                	push   $0xa
     162:	68 14 42 00 00       	push   $0x4214
     167:	ff 75 f0             	pushl  -0x10(%ebp)
     16a:	e8 9d 3a 00 00       	call   3c0c <write>
     16f:	83 c4 10             	add    $0x10,%esp
     172:	83 f8 0a             	cmp    $0xa,%eax
     175:	74 1e                	je     195 <writetest+0xe7>
     177:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     17c:	83 ec 04             	sub    $0x4,%esp
     17f:	ff 75 f4             	pushl  -0xc(%ebp)
     182:	68 20 42 00 00       	push   $0x4220
     187:	50                   	push   %eax
     188:	e8 e4 3b 00 00       	call   3d71 <printf>
     18d:	83 c4 10             	add    $0x10,%esp
     190:	e8 57 3a 00 00       	call   3bec <exit>
     195:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     199:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     19d:	7e 86                	jle    125 <writetest+0x77>
     19f:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     1a4:	83 ec 08             	sub    $0x8,%esp
     1a7:	68 44 42 00 00       	push   $0x4244
     1ac:	50                   	push   %eax
     1ad:	e8 bf 3b 00 00       	call   3d71 <printf>
     1b2:	83 c4 10             	add    $0x10,%esp
     1b5:	83 ec 0c             	sub    $0xc,%esp
     1b8:	ff 75 f0             	pushl  -0x10(%ebp)
     1bb:	e8 54 3a 00 00       	call   3c14 <close>
     1c0:	83 c4 10             	add    $0x10,%esp
     1c3:	83 ec 08             	sub    $0x8,%esp
     1c6:	6a 00                	push   $0x0
     1c8:	68 a6 41 00 00       	push   $0x41a6
     1cd:	e8 5a 3a 00 00       	call   3c2c <open>
     1d2:	83 c4 10             	add    $0x10,%esp
     1d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     1d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1dc:	78 3c                	js     21a <writetest+0x16c>
     1de:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     1e3:	83 ec 08             	sub    $0x8,%esp
     1e6:	68 4f 42 00 00       	push   $0x424f
     1eb:	50                   	push   %eax
     1ec:	e8 80 3b 00 00       	call   3d71 <printf>
     1f1:	83 c4 10             	add    $0x10,%esp
     1f4:	83 ec 04             	sub    $0x4,%esp
     1f7:	68 d0 07 00 00       	push   $0x7d0
     1fc:	68 c0 86 00 00       	push   $0x86c0
     201:	ff 75 f0             	pushl  -0x10(%ebp)
     204:	e8 fb 39 00 00       	call   3c04 <read>
     209:	83 c4 10             	add    $0x10,%esp
     20c:	89 45 f4             	mov    %eax,-0xc(%ebp)
     20f:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
     216:	75 57                	jne    26f <writetest+0x1c1>
     218:	eb 1b                	jmp    235 <writetest+0x187>
     21a:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     21f:	83 ec 08             	sub    $0x8,%esp
     222:	68 68 42 00 00       	push   $0x4268
     227:	50                   	push   %eax
     228:	e8 44 3b 00 00       	call   3d71 <printf>
     22d:	83 c4 10             	add    $0x10,%esp
     230:	e8 b7 39 00 00       	call   3bec <exit>
     235:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     23a:	83 ec 08             	sub    $0x8,%esp
     23d:	68 83 42 00 00       	push   $0x4283
     242:	50                   	push   %eax
     243:	e8 29 3b 00 00       	call   3d71 <printf>
     248:	83 c4 10             	add    $0x10,%esp
     24b:	83 ec 0c             	sub    $0xc,%esp
     24e:	ff 75 f0             	pushl  -0x10(%ebp)
     251:	e8 be 39 00 00       	call   3c14 <close>
     256:	83 c4 10             	add    $0x10,%esp
     259:	83 ec 0c             	sub    $0xc,%esp
     25c:	68 a6 41 00 00       	push   $0x41a6
     261:	e8 d6 39 00 00       	call   3c3c <unlink>
     266:	83 c4 10             	add    $0x10,%esp
     269:	85 c0                	test   %eax,%eax
     26b:	79 38                	jns    2a5 <writetest+0x1f7>
     26d:	eb 1b                	jmp    28a <writetest+0x1dc>
     26f:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     274:	83 ec 08             	sub    $0x8,%esp
     277:	68 96 42 00 00       	push   $0x4296
     27c:	50                   	push   %eax
     27d:	e8 ef 3a 00 00       	call   3d71 <printf>
     282:	83 c4 10             	add    $0x10,%esp
     285:	e8 62 39 00 00       	call   3bec <exit>
     28a:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     28f:	83 ec 08             	sub    $0x8,%esp
     292:	68 a3 42 00 00       	push   $0x42a3
     297:	50                   	push   %eax
     298:	e8 d4 3a 00 00       	call   3d71 <printf>
     29d:	83 c4 10             	add    $0x10,%esp
     2a0:	e8 47 39 00 00       	call   3bec <exit>
     2a5:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     2aa:	83 ec 08             	sub    $0x8,%esp
     2ad:	68 b8 42 00 00       	push   $0x42b8
     2b2:	50                   	push   %eax
     2b3:	e8 b9 3a 00 00       	call   3d71 <printf>
     2b8:	83 c4 10             	add    $0x10,%esp
     2bb:	c9                   	leave  
     2bc:	c3                   	ret    

000002bd <writetest1>:
     2bd:	55                   	push   %ebp
     2be:	89 e5                	mov    %esp,%ebp
     2c0:	83 ec 18             	sub    $0x18,%esp
     2c3:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     2c8:	83 ec 08             	sub    $0x8,%esp
     2cb:	68 cc 42 00 00       	push   $0x42cc
     2d0:	50                   	push   %eax
     2d1:	e8 9b 3a 00 00       	call   3d71 <printf>
     2d6:	83 c4 10             	add    $0x10,%esp
     2d9:	83 ec 08             	sub    $0x8,%esp
     2dc:	68 02 02 00 00       	push   $0x202
     2e1:	68 dc 42 00 00       	push   $0x42dc
     2e6:	e8 41 39 00 00       	call   3c2c <open>
     2eb:	83 c4 10             	add    $0x10,%esp
     2ee:	89 45 ec             	mov    %eax,-0x14(%ebp)
     2f1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     2f5:	79 1b                	jns    312 <writetest1+0x55>
     2f7:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     2fc:	83 ec 08             	sub    $0x8,%esp
     2ff:	68 e0 42 00 00       	push   $0x42e0
     304:	50                   	push   %eax
     305:	e8 67 3a 00 00       	call   3d71 <printf>
     30a:	83 c4 10             	add    $0x10,%esp
     30d:	e8 da 38 00 00       	call   3bec <exit>
     312:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     319:	eb 4b                	jmp    366 <writetest1+0xa9>
     31b:	ba c0 86 00 00       	mov    $0x86c0,%edx
     320:	8b 45 f4             	mov    -0xc(%ebp),%eax
     323:	89 02                	mov    %eax,(%edx)
     325:	83 ec 04             	sub    $0x4,%esp
     328:	68 00 02 00 00       	push   $0x200
     32d:	68 c0 86 00 00       	push   $0x86c0
     332:	ff 75 ec             	pushl  -0x14(%ebp)
     335:	e8 d2 38 00 00       	call   3c0c <write>
     33a:	83 c4 10             	add    $0x10,%esp
     33d:	3d 00 02 00 00       	cmp    $0x200,%eax
     342:	74 1e                	je     362 <writetest1+0xa5>
     344:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     349:	83 ec 04             	sub    $0x4,%esp
     34c:	ff 75 f4             	pushl  -0xc(%ebp)
     34f:	68 fa 42 00 00       	push   $0x42fa
     354:	50                   	push   %eax
     355:	e8 17 3a 00 00       	call   3d71 <printf>
     35a:	83 c4 10             	add    $0x10,%esp
     35d:	e8 8a 38 00 00       	call   3bec <exit>
     362:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     366:	8b 45 f4             	mov    -0xc(%ebp),%eax
     369:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     36e:	76 ab                	jbe    31b <writetest1+0x5e>
     370:	83 ec 0c             	sub    $0xc,%esp
     373:	ff 75 ec             	pushl  -0x14(%ebp)
     376:	e8 99 38 00 00       	call   3c14 <close>
     37b:	83 c4 10             	add    $0x10,%esp
     37e:	83 ec 08             	sub    $0x8,%esp
     381:	6a 00                	push   $0x0
     383:	68 dc 42 00 00       	push   $0x42dc
     388:	e8 9f 38 00 00       	call   3c2c <open>
     38d:	83 c4 10             	add    $0x10,%esp
     390:	89 45 ec             	mov    %eax,-0x14(%ebp)
     393:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     397:	79 1b                	jns    3b4 <writetest1+0xf7>
     399:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     39e:	83 ec 08             	sub    $0x8,%esp
     3a1:	68 18 43 00 00       	push   $0x4318
     3a6:	50                   	push   %eax
     3a7:	e8 c5 39 00 00       	call   3d71 <printf>
     3ac:	83 c4 10             	add    $0x10,%esp
     3af:	e8 38 38 00 00       	call   3bec <exit>
     3b4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     3bb:	83 ec 04             	sub    $0x4,%esp
     3be:	68 00 02 00 00       	push   $0x200
     3c3:	68 c0 86 00 00       	push   $0x86c0
     3c8:	ff 75 ec             	pushl  -0x14(%ebp)
     3cb:	e8 34 38 00 00       	call   3c04 <read>
     3d0:	83 c4 10             	add    $0x10,%esp
     3d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3da:	75 4c                	jne    428 <writetest1+0x16b>
     3dc:	81 7d f0 8b 00 00 00 	cmpl   $0x8b,-0x10(%ebp)
     3e3:	75 1e                	jne    403 <writetest1+0x146>
     3e5:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     3ea:	83 ec 04             	sub    $0x4,%esp
     3ed:	ff 75 f0             	pushl  -0x10(%ebp)
     3f0:	68 31 43 00 00       	push   $0x4331
     3f5:	50                   	push   %eax
     3f6:	e8 76 39 00 00       	call   3d71 <printf>
     3fb:	83 c4 10             	add    $0x10,%esp
     3fe:	e8 e9 37 00 00       	call   3bec <exit>
     403:	90                   	nop
     404:	83 ec 0c             	sub    $0xc,%esp
     407:	ff 75 ec             	pushl  -0x14(%ebp)
     40a:	e8 05 38 00 00       	call   3c14 <close>
     40f:	83 c4 10             	add    $0x10,%esp
     412:	83 ec 0c             	sub    $0xc,%esp
     415:	68 dc 42 00 00       	push   $0x42dc
     41a:	e8 1d 38 00 00       	call   3c3c <unlink>
     41f:	83 c4 10             	add    $0x10,%esp
     422:	85 c0                	test   %eax,%eax
     424:	79 7c                	jns    4a2 <writetest1+0x1e5>
     426:	eb 5f                	jmp    487 <writetest1+0x1ca>
     428:	81 7d f4 00 02 00 00 	cmpl   $0x200,-0xc(%ebp)
     42f:	74 1e                	je     44f <writetest1+0x192>
     431:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     436:	83 ec 04             	sub    $0x4,%esp
     439:	ff 75 f4             	pushl  -0xc(%ebp)
     43c:	68 4e 43 00 00       	push   $0x434e
     441:	50                   	push   %eax
     442:	e8 2a 39 00 00       	call   3d71 <printf>
     447:	83 c4 10             	add    $0x10,%esp
     44a:	e8 9d 37 00 00       	call   3bec <exit>
     44f:	b8 c0 86 00 00       	mov    $0x86c0,%eax
     454:	8b 00                	mov    (%eax),%eax
     456:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     459:	74 23                	je     47e <writetest1+0x1c1>
     45b:	b8 c0 86 00 00       	mov    $0x86c0,%eax
     460:	8b 10                	mov    (%eax),%edx
     462:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     467:	52                   	push   %edx
     468:	ff 75 f0             	pushl  -0x10(%ebp)
     46b:	68 60 43 00 00       	push   $0x4360
     470:	50                   	push   %eax
     471:	e8 fb 38 00 00       	call   3d71 <printf>
     476:	83 c4 10             	add    $0x10,%esp
     479:	e8 6e 37 00 00       	call   3bec <exit>
     47e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     482:	e9 34 ff ff ff       	jmp    3bb <writetest1+0xfe>
     487:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     48c:	83 ec 08             	sub    $0x8,%esp
     48f:	68 80 43 00 00       	push   $0x4380
     494:	50                   	push   %eax
     495:	e8 d7 38 00 00       	call   3d71 <printf>
     49a:	83 c4 10             	add    $0x10,%esp
     49d:	e8 4a 37 00 00       	call   3bec <exit>
     4a2:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     4a7:	83 ec 08             	sub    $0x8,%esp
     4aa:	68 93 43 00 00       	push   $0x4393
     4af:	50                   	push   %eax
     4b0:	e8 bc 38 00 00       	call   3d71 <printf>
     4b5:	83 c4 10             	add    $0x10,%esp
     4b8:	c9                   	leave  
     4b9:	c3                   	ret    

000004ba <createtest>:
     4ba:	55                   	push   %ebp
     4bb:	89 e5                	mov    %esp,%ebp
     4bd:	83 ec 18             	sub    $0x18,%esp
     4c0:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     4c5:	83 ec 08             	sub    $0x8,%esp
     4c8:	68 a4 43 00 00       	push   $0x43a4
     4cd:	50                   	push   %eax
     4ce:	e8 9e 38 00 00       	call   3d71 <printf>
     4d3:	83 c4 10             	add    $0x10,%esp
     4d6:	c6 05 c0 a6 00 00 61 	movb   $0x61,0xa6c0
     4dd:	c6 05 c2 a6 00 00 00 	movb   $0x0,0xa6c2
     4e4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4eb:	eb 35                	jmp    522 <createtest+0x68>
     4ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f0:	83 c0 30             	add    $0x30,%eax
     4f3:	a2 c1 a6 00 00       	mov    %al,0xa6c1
     4f8:	83 ec 08             	sub    $0x8,%esp
     4fb:	68 02 02 00 00       	push   $0x202
     500:	68 c0 a6 00 00       	push   $0xa6c0
     505:	e8 22 37 00 00       	call   3c2c <open>
     50a:	83 c4 10             	add    $0x10,%esp
     50d:	89 45 f0             	mov    %eax,-0x10(%ebp)
     510:	83 ec 0c             	sub    $0xc,%esp
     513:	ff 75 f0             	pushl  -0x10(%ebp)
     516:	e8 f9 36 00 00       	call   3c14 <close>
     51b:	83 c4 10             	add    $0x10,%esp
     51e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     522:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     526:	7e c5                	jle    4ed <createtest+0x33>
     528:	c6 05 c0 a6 00 00 61 	movb   $0x61,0xa6c0
     52f:	c6 05 c2 a6 00 00 00 	movb   $0x0,0xa6c2
     536:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     53d:	eb 1f                	jmp    55e <createtest+0xa4>
     53f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     542:	83 c0 30             	add    $0x30,%eax
     545:	a2 c1 a6 00 00       	mov    %al,0xa6c1
     54a:	83 ec 0c             	sub    $0xc,%esp
     54d:	68 c0 a6 00 00       	push   $0xa6c0
     552:	e8 e5 36 00 00       	call   3c3c <unlink>
     557:	83 c4 10             	add    $0x10,%esp
     55a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     55e:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     562:	7e db                	jle    53f <createtest+0x85>
     564:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     569:	83 ec 08             	sub    $0x8,%esp
     56c:	68 cc 43 00 00       	push   $0x43cc
     571:	50                   	push   %eax
     572:	e8 fa 37 00 00       	call   3d71 <printf>
     577:	83 c4 10             	add    $0x10,%esp
     57a:	c9                   	leave  
     57b:	c3                   	ret    

0000057c <dirtest>:
     57c:	55                   	push   %ebp
     57d:	89 e5                	mov    %esp,%ebp
     57f:	83 ec 08             	sub    $0x8,%esp
     582:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     587:	83 ec 08             	sub    $0x8,%esp
     58a:	68 f2 43 00 00       	push   $0x43f2
     58f:	50                   	push   %eax
     590:	e8 dc 37 00 00       	call   3d71 <printf>
     595:	83 c4 10             	add    $0x10,%esp
     598:	83 ec 0c             	sub    $0xc,%esp
     59b:	68 fe 43 00 00       	push   $0x43fe
     5a0:	e8 af 36 00 00       	call   3c54 <mkdir>
     5a5:	83 c4 10             	add    $0x10,%esp
     5a8:	85 c0                	test   %eax,%eax
     5aa:	79 1b                	jns    5c7 <dirtest+0x4b>
     5ac:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     5b1:	83 ec 08             	sub    $0x8,%esp
     5b4:	68 03 44 00 00       	push   $0x4403
     5b9:	50                   	push   %eax
     5ba:	e8 b2 37 00 00       	call   3d71 <printf>
     5bf:	83 c4 10             	add    $0x10,%esp
     5c2:	e8 25 36 00 00       	call   3bec <exit>
     5c7:	83 ec 0c             	sub    $0xc,%esp
     5ca:	68 fe 43 00 00       	push   $0x43fe
     5cf:	e8 88 36 00 00       	call   3c5c <chdir>
     5d4:	83 c4 10             	add    $0x10,%esp
     5d7:	85 c0                	test   %eax,%eax
     5d9:	79 1b                	jns    5f6 <dirtest+0x7a>
     5db:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     5e0:	83 ec 08             	sub    $0x8,%esp
     5e3:	68 11 44 00 00       	push   $0x4411
     5e8:	50                   	push   %eax
     5e9:	e8 83 37 00 00       	call   3d71 <printf>
     5ee:	83 c4 10             	add    $0x10,%esp
     5f1:	e8 f6 35 00 00       	call   3bec <exit>
     5f6:	83 ec 0c             	sub    $0xc,%esp
     5f9:	68 24 44 00 00       	push   $0x4424
     5fe:	e8 59 36 00 00       	call   3c5c <chdir>
     603:	83 c4 10             	add    $0x10,%esp
     606:	85 c0                	test   %eax,%eax
     608:	79 1b                	jns    625 <dirtest+0xa9>
     60a:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     60f:	83 ec 08             	sub    $0x8,%esp
     612:	68 27 44 00 00       	push   $0x4427
     617:	50                   	push   %eax
     618:	e8 54 37 00 00       	call   3d71 <printf>
     61d:	83 c4 10             	add    $0x10,%esp
     620:	e8 c7 35 00 00       	call   3bec <exit>
     625:	83 ec 0c             	sub    $0xc,%esp
     628:	68 fe 43 00 00       	push   $0x43fe
     62d:	e8 0a 36 00 00       	call   3c3c <unlink>
     632:	83 c4 10             	add    $0x10,%esp
     635:	85 c0                	test   %eax,%eax
     637:	79 1b                	jns    654 <dirtest+0xd8>
     639:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     63e:	83 ec 08             	sub    $0x8,%esp
     641:	68 38 44 00 00       	push   $0x4438
     646:	50                   	push   %eax
     647:	e8 25 37 00 00       	call   3d71 <printf>
     64c:	83 c4 10             	add    $0x10,%esp
     64f:	e8 98 35 00 00       	call   3bec <exit>
     654:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     659:	83 ec 08             	sub    $0x8,%esp
     65c:	68 f2 43 00 00       	push   $0x43f2
     661:	50                   	push   %eax
     662:	e8 0a 37 00 00       	call   3d71 <printf>
     667:	83 c4 10             	add    $0x10,%esp
     66a:	c9                   	leave  
     66b:	c3                   	ret    

0000066c <exectest>:
     66c:	55                   	push   %ebp
     66d:	89 e5                	mov    %esp,%ebp
     66f:	83 ec 08             	sub    $0x8,%esp
     672:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     677:	83 ec 08             	sub    $0x8,%esp
     67a:	68 4c 44 00 00       	push   $0x444c
     67f:	50                   	push   %eax
     680:	e8 ec 36 00 00       	call   3d71 <printf>
     685:	83 c4 10             	add    $0x10,%esp
     688:	83 ec 08             	sub    $0x8,%esp
     68b:	68 68 5e 00 00       	push   $0x5e68
     690:	68 28 41 00 00       	push   $0x4128
     695:	e8 8a 35 00 00       	call   3c24 <exec>
     69a:	83 c4 10             	add    $0x10,%esp
     69d:	85 c0                	test   %eax,%eax
     69f:	79 1b                	jns    6bc <exectest+0x50>
     6a1:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
     6a6:	83 ec 08             	sub    $0x8,%esp
     6a9:	68 57 44 00 00       	push   $0x4457
     6ae:	50                   	push   %eax
     6af:	e8 bd 36 00 00       	call   3d71 <printf>
     6b4:	83 c4 10             	add    $0x10,%esp
     6b7:	e8 30 35 00 00       	call   3bec <exit>
     6bc:	c9                   	leave  
     6bd:	c3                   	ret    

000006be <pipe1>:
     6be:	55                   	push   %ebp
     6bf:	89 e5                	mov    %esp,%ebp
     6c1:	83 ec 28             	sub    $0x28,%esp
     6c4:	83 ec 0c             	sub    $0xc,%esp
     6c7:	8d 45 d8             	lea    -0x28(%ebp),%eax
     6ca:	50                   	push   %eax
     6cb:	e8 2c 35 00 00       	call   3bfc <pipe>
     6d0:	83 c4 10             	add    $0x10,%esp
     6d3:	85 c0                	test   %eax,%eax
     6d5:	74 17                	je     6ee <pipe1+0x30>
     6d7:	83 ec 08             	sub    $0x8,%esp
     6da:	68 69 44 00 00       	push   $0x4469
     6df:	6a 01                	push   $0x1
     6e1:	e8 8b 36 00 00       	call   3d71 <printf>
     6e6:	83 c4 10             	add    $0x10,%esp
     6e9:	e8 fe 34 00 00       	call   3bec <exit>
     6ee:	e8 f1 34 00 00       	call   3be4 <fork>
     6f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
     6f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     6fd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     701:	0f 85 89 00 00 00    	jne    790 <pipe1+0xd2>
     707:	8b 45 d8             	mov    -0x28(%ebp),%eax
     70a:	83 ec 0c             	sub    $0xc,%esp
     70d:	50                   	push   %eax
     70e:	e8 01 35 00 00       	call   3c14 <close>
     713:	83 c4 10             	add    $0x10,%esp
     716:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     71d:	eb 66                	jmp    785 <pipe1+0xc7>
     71f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     726:	eb 19                	jmp    741 <pipe1+0x83>
     728:	8b 45 f4             	mov    -0xc(%ebp),%eax
     72b:	8d 50 01             	lea    0x1(%eax),%edx
     72e:	89 55 f4             	mov    %edx,-0xc(%ebp)
     731:	89 c2                	mov    %eax,%edx
     733:	8b 45 f0             	mov    -0x10(%ebp),%eax
     736:	05 c0 86 00 00       	add    $0x86c0,%eax
     73b:	88 10                	mov    %dl,(%eax)
     73d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     741:	81 7d f0 08 04 00 00 	cmpl   $0x408,-0x10(%ebp)
     748:	7e de                	jle    728 <pipe1+0x6a>
     74a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     74d:	83 ec 04             	sub    $0x4,%esp
     750:	68 09 04 00 00       	push   $0x409
     755:	68 c0 86 00 00       	push   $0x86c0
     75a:	50                   	push   %eax
     75b:	e8 ac 34 00 00       	call   3c0c <write>
     760:	83 c4 10             	add    $0x10,%esp
     763:	3d 09 04 00 00       	cmp    $0x409,%eax
     768:	74 17                	je     781 <pipe1+0xc3>
     76a:	83 ec 08             	sub    $0x8,%esp
     76d:	68 78 44 00 00       	push   $0x4478
     772:	6a 01                	push   $0x1
     774:	e8 f8 35 00 00       	call   3d71 <printf>
     779:	83 c4 10             	add    $0x10,%esp
     77c:	e8 6b 34 00 00       	call   3bec <exit>
     781:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     785:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     789:	7e 94                	jle    71f <pipe1+0x61>
     78b:	e8 5c 34 00 00       	call   3bec <exit>
     790:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     794:	0f 8e f4 00 00 00    	jle    88e <pipe1+0x1d0>
     79a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     79d:	83 ec 0c             	sub    $0xc,%esp
     7a0:	50                   	push   %eax
     7a1:	e8 6e 34 00 00       	call   3c14 <close>
     7a6:	83 c4 10             	add    $0x10,%esp
     7a9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
     7b0:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
     7b7:	eb 66                	jmp    81f <pipe1+0x161>
     7b9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     7c0:	eb 3b                	jmp    7fd <pipe1+0x13f>
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
     7e2:	83 ec 08             	sub    $0x8,%esp
     7e5:	68 86 44 00 00       	push   $0x4486
     7ea:	6a 01                	push   $0x1
     7ec:	e8 80 35 00 00       	call   3d71 <printf>
     7f1:	83 c4 10             	add    $0x10,%esp
     7f4:	e9 ac 00 00 00       	jmp    8a5 <pipe1+0x1e7>
     7f9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     7fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     800:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     803:	7c bd                	jl     7c2 <pipe1+0x104>
     805:	8b 45 ec             	mov    -0x14(%ebp),%eax
     808:	01 45 e4             	add    %eax,-0x1c(%ebp)
     80b:	d1 65 e8             	shll   -0x18(%ebp)
     80e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     811:	3d 00 20 00 00       	cmp    $0x2000,%eax
     816:	76 07                	jbe    81f <pipe1+0x161>
     818:	c7 45 e8 00 20 00 00 	movl   $0x2000,-0x18(%ebp)
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
     843:	81 7d e4 2d 14 00 00 	cmpl   $0x142d,-0x1c(%ebp)
     84a:	74 1a                	je     866 <pipe1+0x1a8>
     84c:	83 ec 04             	sub    $0x4,%esp
     84f:	ff 75 e4             	pushl  -0x1c(%ebp)
     852:	68 94 44 00 00       	push   $0x4494
     857:	6a 01                	push   $0x1
     859:	e8 13 35 00 00       	call   3d71 <printf>
     85e:	83 c4 10             	add    $0x10,%esp
     861:	e8 86 33 00 00       	call   3bec <exit>
     866:	8b 45 d8             	mov    -0x28(%ebp),%eax
     869:	83 ec 0c             	sub    $0xc,%esp
     86c:	50                   	push   %eax
     86d:	e8 a2 33 00 00       	call   3c14 <close>
     872:	83 c4 10             	add    $0x10,%esp
     875:	e8 7a 33 00 00       	call   3bf4 <wait>
     87a:	83 ec 08             	sub    $0x8,%esp
     87d:	68 ba 44 00 00       	push   $0x44ba
     882:	6a 01                	push   $0x1
     884:	e8 e8 34 00 00       	call   3d71 <printf>
     889:	83 c4 10             	add    $0x10,%esp
     88c:	eb 17                	jmp    8a5 <pipe1+0x1e7>
     88e:	83 ec 08             	sub    $0x8,%esp
     891:	68 ab 44 00 00       	push   $0x44ab
     896:	6a 01                	push   $0x1
     898:	e8 d4 34 00 00       	call   3d71 <printf>
     89d:	83 c4 10             	add    $0x10,%esp
     8a0:	e8 47 33 00 00       	call   3bec <exit>
     8a5:	c9                   	leave  
     8a6:	c3                   	ret    

000008a7 <preempt>:
     8a7:	55                   	push   %ebp
     8a8:	89 e5                	mov    %esp,%ebp
     8aa:	83 ec 28             	sub    $0x28,%esp
     8ad:	83 ec 08             	sub    $0x8,%esp
     8b0:	68 c4 44 00 00       	push   $0x44c4
     8b5:	6a 01                	push   $0x1
     8b7:	e8 b5 34 00 00       	call   3d71 <printf>
     8bc:	83 c4 10             	add    $0x10,%esp
     8bf:	e8 20 33 00 00       	call   3be4 <fork>
     8c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8cb:	75 02                	jne    8cf <preempt+0x28>
     8cd:	eb fe                	jmp    8cd <preempt+0x26>
     8cf:	e8 10 33 00 00       	call   3be4 <fork>
     8d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8d7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8db:	75 02                	jne    8df <preempt+0x38>
     8dd:	eb fe                	jmp    8dd <preempt+0x36>
     8df:	83 ec 0c             	sub    $0xc,%esp
     8e2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     8e5:	50                   	push   %eax
     8e6:	e8 11 33 00 00       	call   3bfc <pipe>
     8eb:	83 c4 10             	add    $0x10,%esp
     8ee:	e8 f1 32 00 00       	call   3be4 <fork>
     8f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
     8f6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     8fa:	75 4d                	jne    949 <preempt+0xa2>
     8fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8ff:	83 ec 0c             	sub    $0xc,%esp
     902:	50                   	push   %eax
     903:	e8 0c 33 00 00       	call   3c14 <close>
     908:	83 c4 10             	add    $0x10,%esp
     90b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     90e:	83 ec 04             	sub    $0x4,%esp
     911:	6a 01                	push   $0x1
     913:	68 ce 44 00 00       	push   $0x44ce
     918:	50                   	push   %eax
     919:	e8 ee 32 00 00       	call   3c0c <write>
     91e:	83 c4 10             	add    $0x10,%esp
     921:	83 f8 01             	cmp    $0x1,%eax
     924:	74 12                	je     938 <preempt+0x91>
     926:	83 ec 08             	sub    $0x8,%esp
     929:	68 d0 44 00 00       	push   $0x44d0
     92e:	6a 01                	push   $0x1
     930:	e8 3c 34 00 00       	call   3d71 <printf>
     935:	83 c4 10             	add    $0x10,%esp
     938:	8b 45 e8             	mov    -0x18(%ebp),%eax
     93b:	83 ec 0c             	sub    $0xc,%esp
     93e:	50                   	push   %eax
     93f:	e8 d0 32 00 00       	call   3c14 <close>
     944:	83 c4 10             	add    $0x10,%esp
     947:	eb fe                	jmp    947 <preempt+0xa0>
     949:	8b 45 e8             	mov    -0x18(%ebp),%eax
     94c:	83 ec 0c             	sub    $0xc,%esp
     94f:	50                   	push   %eax
     950:	e8 bf 32 00 00       	call   3c14 <close>
     955:	83 c4 10             	add    $0x10,%esp
     958:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     95b:	83 ec 04             	sub    $0x4,%esp
     95e:	68 00 20 00 00       	push   $0x2000
     963:	68 c0 86 00 00       	push   $0x86c0
     968:	50                   	push   %eax
     969:	e8 96 32 00 00       	call   3c04 <read>
     96e:	83 c4 10             	add    $0x10,%esp
     971:	83 f8 01             	cmp    $0x1,%eax
     974:	74 14                	je     98a <preempt+0xe3>
     976:	83 ec 08             	sub    $0x8,%esp
     979:	68 e4 44 00 00       	push   $0x44e4
     97e:	6a 01                	push   $0x1
     980:	e8 ec 33 00 00       	call   3d71 <printf>
     985:	83 c4 10             	add    $0x10,%esp
     988:	eb 7e                	jmp    a08 <preempt+0x161>
     98a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     98d:	83 ec 0c             	sub    $0xc,%esp
     990:	50                   	push   %eax
     991:	e8 7e 32 00 00       	call   3c14 <close>
     996:	83 c4 10             	add    $0x10,%esp
     999:	83 ec 08             	sub    $0x8,%esp
     99c:	68 f7 44 00 00       	push   $0x44f7
     9a1:	6a 01                	push   $0x1
     9a3:	e8 c9 33 00 00       	call   3d71 <printf>
     9a8:	83 c4 10             	add    $0x10,%esp
     9ab:	83 ec 0c             	sub    $0xc,%esp
     9ae:	ff 75 f4             	pushl  -0xc(%ebp)
     9b1:	e8 66 32 00 00       	call   3c1c <kill>
     9b6:	83 c4 10             	add    $0x10,%esp
     9b9:	83 ec 0c             	sub    $0xc,%esp
     9bc:	ff 75 f0             	pushl  -0x10(%ebp)
     9bf:	e8 58 32 00 00       	call   3c1c <kill>
     9c4:	83 c4 10             	add    $0x10,%esp
     9c7:	83 ec 0c             	sub    $0xc,%esp
     9ca:	ff 75 ec             	pushl  -0x14(%ebp)
     9cd:	e8 4a 32 00 00       	call   3c1c <kill>
     9d2:	83 c4 10             	add    $0x10,%esp
     9d5:	83 ec 08             	sub    $0x8,%esp
     9d8:	68 00 45 00 00       	push   $0x4500
     9dd:	6a 01                	push   $0x1
     9df:	e8 8d 33 00 00       	call   3d71 <printf>
     9e4:	83 c4 10             	add    $0x10,%esp
     9e7:	e8 08 32 00 00       	call   3bf4 <wait>
     9ec:	e8 03 32 00 00       	call   3bf4 <wait>
     9f1:	e8 fe 31 00 00       	call   3bf4 <wait>
     9f6:	83 ec 08             	sub    $0x8,%esp
     9f9:	68 09 45 00 00       	push   $0x4509
     9fe:	6a 01                	push   $0x1
     a00:	e8 6c 33 00 00       	call   3d71 <printf>
     a05:	83 c4 10             	add    $0x10,%esp
     a08:	c9                   	leave  
     a09:	c3                   	ret    

00000a0a <exitwait>:
     a0a:	55                   	push   %ebp
     a0b:	89 e5                	mov    %esp,%ebp
     a0d:	83 ec 18             	sub    $0x18,%esp
     a10:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a17:	eb 4f                	jmp    a68 <exitwait+0x5e>
     a19:	e8 c6 31 00 00       	call   3be4 <fork>
     a1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a21:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a25:	79 14                	jns    a3b <exitwait+0x31>
     a27:	83 ec 08             	sub    $0x8,%esp
     a2a:	68 15 45 00 00       	push   $0x4515
     a2f:	6a 01                	push   $0x1
     a31:	e8 3b 33 00 00       	call   3d71 <printf>
     a36:	83 c4 10             	add    $0x10,%esp
     a39:	eb 45                	jmp    a80 <exitwait+0x76>
     a3b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a3f:	74 1e                	je     a5f <exitwait+0x55>
     a41:	e8 ae 31 00 00       	call   3bf4 <wait>
     a46:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     a49:	74 19                	je     a64 <exitwait+0x5a>
     a4b:	83 ec 08             	sub    $0x8,%esp
     a4e:	68 22 45 00 00       	push   $0x4522
     a53:	6a 01                	push   $0x1
     a55:	e8 17 33 00 00       	call   3d71 <printf>
     a5a:	83 c4 10             	add    $0x10,%esp
     a5d:	eb 21                	jmp    a80 <exitwait+0x76>
     a5f:	e8 88 31 00 00       	call   3bec <exit>
     a64:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     a68:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     a6c:	7e ab                	jle    a19 <exitwait+0xf>
     a6e:	83 ec 08             	sub    $0x8,%esp
     a71:	68 32 45 00 00       	push   $0x4532
     a76:	6a 01                	push   $0x1
     a78:	e8 f4 32 00 00       	call   3d71 <printf>
     a7d:	83 c4 10             	add    $0x10,%esp
     a80:	c9                   	leave  
     a81:	c3                   	ret    

00000a82 <mem>:
     a82:	55                   	push   %ebp
     a83:	89 e5                	mov    %esp,%ebp
     a85:	83 ec 18             	sub    $0x18,%esp
     a88:	83 ec 08             	sub    $0x8,%esp
     a8b:	68 3f 45 00 00       	push   $0x453f
     a90:	6a 01                	push   $0x1
     a92:	e8 da 32 00 00       	call   3d71 <printf>
     a97:	83 c4 10             	add    $0x10,%esp
     a9a:	e8 cd 31 00 00       	call   3c6c <getpid>
     a9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     aa2:	e8 3d 31 00 00       	call   3be4 <fork>
     aa7:	89 45 ec             	mov    %eax,-0x14(%ebp)
     aaa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     aae:	0f 85 b7 00 00 00    	jne    b6b <mem+0xe9>
     ab4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     abb:	eb 0e                	jmp    acb <mem+0x49>
     abd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ac0:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ac3:	89 10                	mov    %edx,(%eax)
     ac5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ac8:	89 45 f4             	mov    %eax,-0xc(%ebp)
     acb:	83 ec 0c             	sub    $0xc,%esp
     ace:	68 11 27 00 00       	push   $0x2711
     ad3:	e8 6a 35 00 00       	call   4042 <malloc>
     ad8:	83 c4 10             	add    $0x10,%esp
     adb:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ade:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     ae2:	75 d9                	jne    abd <mem+0x3b>
     ae4:	eb 1c                	jmp    b02 <mem+0x80>
     ae6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae9:	8b 00                	mov    (%eax),%eax
     aeb:	89 45 e8             	mov    %eax,-0x18(%ebp)
     aee:	83 ec 0c             	sub    $0xc,%esp
     af1:	ff 75 f4             	pushl  -0xc(%ebp)
     af4:	e8 08 34 00 00       	call   3f01 <free>
     af9:	83 c4 10             	add    $0x10,%esp
     afc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     aff:	89 45 f4             	mov    %eax,-0xc(%ebp)
     b02:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b06:	75 de                	jne    ae6 <mem+0x64>
     b08:	83 ec 0c             	sub    $0xc,%esp
     b0b:	68 00 50 00 00       	push   $0x5000
     b10:	e8 2d 35 00 00       	call   4042 <malloc>
     b15:	83 c4 10             	add    $0x10,%esp
     b18:	89 45 f4             	mov    %eax,-0xc(%ebp)
     b1b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b1f:	75 25                	jne    b46 <mem+0xc4>
     b21:	83 ec 08             	sub    $0x8,%esp
     b24:	68 49 45 00 00       	push   $0x4549
     b29:	6a 01                	push   $0x1
     b2b:	e8 41 32 00 00       	call   3d71 <printf>
     b30:	83 c4 10             	add    $0x10,%esp
     b33:	83 ec 0c             	sub    $0xc,%esp
     b36:	ff 75 f0             	pushl  -0x10(%ebp)
     b39:	e8 de 30 00 00       	call   3c1c <kill>
     b3e:	83 c4 10             	add    $0x10,%esp
     b41:	e8 a6 30 00 00       	call   3bec <exit>
     b46:	83 ec 0c             	sub    $0xc,%esp
     b49:	ff 75 f4             	pushl  -0xc(%ebp)
     b4c:	e8 b0 33 00 00       	call   3f01 <free>
     b51:	83 c4 10             	add    $0x10,%esp
     b54:	83 ec 08             	sub    $0x8,%esp
     b57:	68 63 45 00 00       	push   $0x4563
     b5c:	6a 01                	push   $0x1
     b5e:	e8 0e 32 00 00       	call   3d71 <printf>
     b63:	83 c4 10             	add    $0x10,%esp
     b66:	e8 81 30 00 00       	call   3bec <exit>
     b6b:	e8 84 30 00 00       	call   3bf4 <wait>
     b70:	c9                   	leave  
     b71:	c3                   	ret    

00000b72 <sharedfd>:
     b72:	55                   	push   %ebp
     b73:	89 e5                	mov    %esp,%ebp
     b75:	83 ec 38             	sub    $0x38,%esp
     b78:	83 ec 08             	sub    $0x8,%esp
     b7b:	68 6b 45 00 00       	push   $0x456b
     b80:	6a 01                	push   $0x1
     b82:	e8 ea 31 00 00       	call   3d71 <printf>
     b87:	83 c4 10             	add    $0x10,%esp
     b8a:	83 ec 0c             	sub    $0xc,%esp
     b8d:	68 7a 45 00 00       	push   $0x457a
     b92:	e8 a5 30 00 00       	call   3c3c <unlink>
     b97:	83 c4 10             	add    $0x10,%esp
     b9a:	83 ec 08             	sub    $0x8,%esp
     b9d:	68 02 02 00 00       	push   $0x202
     ba2:	68 7a 45 00 00       	push   $0x457a
     ba7:	e8 80 30 00 00       	call   3c2c <open>
     bac:	83 c4 10             	add    $0x10,%esp
     baf:	89 45 e8             	mov    %eax,-0x18(%ebp)
     bb2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     bb6:	79 17                	jns    bcf <sharedfd+0x5d>
     bb8:	83 ec 08             	sub    $0x8,%esp
     bbb:	68 84 45 00 00       	push   $0x4584
     bc0:	6a 01                	push   $0x1
     bc2:	e8 aa 31 00 00       	call   3d71 <printf>
     bc7:	83 c4 10             	add    $0x10,%esp
     bca:	e9 84 01 00 00       	jmp    d53 <sharedfd+0x1e1>
     bcf:	e8 10 30 00 00       	call   3be4 <fork>
     bd4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
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
     bfb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c02:	eb 31                	jmp    c35 <sharedfd+0xc3>
     c04:	83 ec 04             	sub    $0x4,%esp
     c07:	6a 0a                	push   $0xa
     c09:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     c0c:	50                   	push   %eax
     c0d:	ff 75 e8             	pushl  -0x18(%ebp)
     c10:	e8 f7 2f 00 00       	call   3c0c <write>
     c15:	83 c4 10             	add    $0x10,%esp
     c18:	83 f8 0a             	cmp    $0xa,%eax
     c1b:	74 14                	je     c31 <sharedfd+0xbf>
     c1d:	83 ec 08             	sub    $0x8,%esp
     c20:	68 b0 45 00 00       	push   $0x45b0
     c25:	6a 01                	push   $0x1
     c27:	e8 45 31 00 00       	call   3d71 <printf>
     c2c:	83 c4 10             	add    $0x10,%esp
     c2f:	eb 0d                	jmp    c3e <sharedfd+0xcc>
     c31:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c35:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
     c3c:	7e c6                	jle    c04 <sharedfd+0x92>
     c3e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     c42:	75 05                	jne    c49 <sharedfd+0xd7>
     c44:	e8 a3 2f 00 00       	call   3bec <exit>
     c49:	e8 a6 2f 00 00       	call   3bf4 <wait>
     c4e:	83 ec 0c             	sub    $0xc,%esp
     c51:	ff 75 e8             	pushl  -0x18(%ebp)
     c54:	e8 bb 2f 00 00       	call   3c14 <close>
     c59:	83 c4 10             	add    $0x10,%esp
     c5c:	83 ec 08             	sub    $0x8,%esp
     c5f:	6a 00                	push   $0x0
     c61:	68 7a 45 00 00       	push   $0x457a
     c66:	e8 c1 2f 00 00       	call   3c2c <open>
     c6b:	83 c4 10             	add    $0x10,%esp
     c6e:	89 45 e8             	mov    %eax,-0x18(%ebp)
     c71:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     c75:	79 17                	jns    c8e <sharedfd+0x11c>
     c77:	83 ec 08             	sub    $0x8,%esp
     c7a:	68 d0 45 00 00       	push   $0x45d0
     c7f:	6a 01                	push   $0x1
     c81:	e8 eb 30 00 00       	call   3d71 <printf>
     c86:	83 c4 10             	add    $0x10,%esp
     c89:	e9 c5 00 00 00       	jmp    d53 <sharedfd+0x1e1>
     c8e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     c95:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c98:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c9b:	eb 3b                	jmp    cd8 <sharedfd+0x166>
     c9d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ca4:	eb 2a                	jmp    cd0 <sharedfd+0x15e>
     ca6:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     ca9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cac:	01 d0                	add    %edx,%eax
     cae:	0f b6 00             	movzbl (%eax),%eax
     cb1:	3c 63                	cmp    $0x63,%al
     cb3:	75 04                	jne    cb9 <sharedfd+0x147>
     cb5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     cb9:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     cbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cbf:	01 d0                	add    %edx,%eax
     cc1:	0f b6 00             	movzbl (%eax),%eax
     cc4:	3c 70                	cmp    $0x70,%al
     cc6:	75 04                	jne    ccc <sharedfd+0x15a>
     cc8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     ccc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     cd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cd3:	83 f8 09             	cmp    $0x9,%eax
     cd6:	76 ce                	jbe    ca6 <sharedfd+0x134>
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
     cf5:	83 ec 0c             	sub    $0xc,%esp
     cf8:	ff 75 e8             	pushl  -0x18(%ebp)
     cfb:	e8 14 2f 00 00       	call   3c14 <close>
     d00:	83 c4 10             	add    $0x10,%esp
     d03:	83 ec 0c             	sub    $0xc,%esp
     d06:	68 7a 45 00 00       	push   $0x457a
     d0b:	e8 2c 2f 00 00       	call   3c3c <unlink>
     d10:	83 c4 10             	add    $0x10,%esp
     d13:	81 7d f0 10 27 00 00 	cmpl   $0x2710,-0x10(%ebp)
     d1a:	75 1d                	jne    d39 <sharedfd+0x1c7>
     d1c:	81 7d ec 10 27 00 00 	cmpl   $0x2710,-0x14(%ebp)
     d23:	75 14                	jne    d39 <sharedfd+0x1c7>
     d25:	83 ec 08             	sub    $0x8,%esp
     d28:	68 fb 45 00 00       	push   $0x45fb
     d2d:	6a 01                	push   $0x1
     d2f:	e8 3d 30 00 00       	call   3d71 <printf>
     d34:	83 c4 10             	add    $0x10,%esp
     d37:	eb 1a                	jmp    d53 <sharedfd+0x1e1>
     d39:	ff 75 ec             	pushl  -0x14(%ebp)
     d3c:	ff 75 f0             	pushl  -0x10(%ebp)
     d3f:	68 08 46 00 00       	push   $0x4608
     d44:	6a 01                	push   $0x1
     d46:	e8 26 30 00 00       	call   3d71 <printf>
     d4b:	83 c4 10             	add    $0x10,%esp
     d4e:	e8 99 2e 00 00       	call   3bec <exit>
     d53:	c9                   	leave  
     d54:	c3                   	ret    

00000d55 <twofiles>:
     d55:	55                   	push   %ebp
     d56:	89 e5                	mov    %esp,%ebp
     d58:	83 ec 28             	sub    $0x28,%esp
     d5b:	83 ec 08             	sub    $0x8,%esp
     d5e:	68 1d 46 00 00       	push   $0x461d
     d63:	6a 01                	push   $0x1
     d65:	e8 07 30 00 00       	call   3d71 <printf>
     d6a:	83 c4 10             	add    $0x10,%esp
     d6d:	83 ec 0c             	sub    $0xc,%esp
     d70:	68 2c 46 00 00       	push   $0x462c
     d75:	e8 c2 2e 00 00       	call   3c3c <unlink>
     d7a:	83 c4 10             	add    $0x10,%esp
     d7d:	83 ec 0c             	sub    $0xc,%esp
     d80:	68 2f 46 00 00       	push   $0x462f
     d85:	e8 b2 2e 00 00       	call   3c3c <unlink>
     d8a:	83 c4 10             	add    $0x10,%esp
     d8d:	e8 52 2e 00 00       	call   3be4 <fork>
     d92:	89 45 e8             	mov    %eax,-0x18(%ebp)
     d95:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     d99:	79 17                	jns    db2 <twofiles+0x5d>
     d9b:	83 ec 08             	sub    $0x8,%esp
     d9e:	68 15 45 00 00       	push   $0x4515
     da3:	6a 01                	push   $0x1
     da5:	e8 c7 2f 00 00       	call   3d71 <printf>
     daa:	83 c4 10             	add    $0x10,%esp
     dad:	e8 3a 2e 00 00       	call   3bec <exit>
     db2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     db6:	74 07                	je     dbf <twofiles+0x6a>
     db8:	b8 2c 46 00 00       	mov    $0x462c,%eax
     dbd:	eb 05                	jmp    dc4 <twofiles+0x6f>
     dbf:	b8 2f 46 00 00       	mov    $0x462f,%eax
     dc4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     dc7:	83 ec 08             	sub    $0x8,%esp
     dca:	68 02 02 00 00       	push   $0x202
     dcf:	ff 75 e4             	pushl  -0x1c(%ebp)
     dd2:	e8 55 2e 00 00       	call   3c2c <open>
     dd7:	83 c4 10             	add    $0x10,%esp
     dda:	89 45 e0             	mov    %eax,-0x20(%ebp)
     ddd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     de1:	79 17                	jns    dfa <twofiles+0xa5>
     de3:	83 ec 08             	sub    $0x8,%esp
     de6:	68 32 46 00 00       	push   $0x4632
     deb:	6a 01                	push   $0x1
     ded:	e8 7f 2f 00 00       	call   3d71 <printf>
     df2:	83 c4 10             	add    $0x10,%esp
     df5:	e8 f2 2d 00 00       	call   3bec <exit>
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
     e22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e29:	eb 42                	jmp    e6d <twofiles+0x118>
     e2b:	83 ec 04             	sub    $0x4,%esp
     e2e:	68 f4 01 00 00       	push   $0x1f4
     e33:	68 c0 86 00 00       	push   $0x86c0
     e38:	ff 75 e0             	pushl  -0x20(%ebp)
     e3b:	e8 cc 2d 00 00       	call   3c0c <write>
     e40:	83 c4 10             	add    $0x10,%esp
     e43:	89 45 dc             	mov    %eax,-0x24(%ebp)
     e46:	81 7d dc f4 01 00 00 	cmpl   $0x1f4,-0x24(%ebp)
     e4d:	74 1a                	je     e69 <twofiles+0x114>
     e4f:	83 ec 04             	sub    $0x4,%esp
     e52:	ff 75 dc             	pushl  -0x24(%ebp)
     e55:	68 41 46 00 00       	push   $0x4641
     e5a:	6a 01                	push   $0x1
     e5c:	e8 10 2f 00 00       	call   3d71 <printf>
     e61:	83 c4 10             	add    $0x10,%esp
     e64:	e8 83 2d 00 00       	call   3bec <exit>
     e69:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e6d:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
     e71:	7e b8                	jle    e2b <twofiles+0xd6>
     e73:	83 ec 0c             	sub    $0xc,%esp
     e76:	ff 75 e0             	pushl  -0x20(%ebp)
     e79:	e8 96 2d 00 00       	call   3c14 <close>
     e7e:	83 c4 10             	add    $0x10,%esp
     e81:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     e85:	74 11                	je     e98 <twofiles+0x143>
     e87:	e8 68 2d 00 00       	call   3bf4 <wait>
     e8c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e93:	e9 dd 00 00 00       	jmp    f75 <twofiles+0x220>
     e98:	e8 4f 2d 00 00       	call   3bec <exit>
     e9d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ea1:	74 07                	je     eaa <twofiles+0x155>
     ea3:	b8 2c 46 00 00       	mov    $0x462c,%eax
     ea8:	eb 05                	jmp    eaf <twofiles+0x15a>
     eaa:	b8 2f 46 00 00       	mov    $0x462f,%eax
     eaf:	83 ec 08             	sub    $0x8,%esp
     eb2:	6a 00                	push   $0x0
     eb4:	50                   	push   %eax
     eb5:	e8 72 2d 00 00       	call   3c2c <open>
     eba:	83 c4 10             	add    $0x10,%esp
     ebd:	89 45 e0             	mov    %eax,-0x20(%ebp)
     ec0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     ec7:	eb 56                	jmp    f1f <twofiles+0x1ca>
     ec9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ed0:	eb 3f                	jmp    f11 <twofiles+0x1bc>
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
     ef6:	83 ec 08             	sub    $0x8,%esp
     ef9:	68 52 46 00 00       	push   $0x4652
     efe:	6a 01                	push   $0x1
     f00:	e8 6c 2e 00 00       	call   3d71 <printf>
     f05:	83 c4 10             	add    $0x10,%esp
     f08:	e8 df 2c 00 00       	call   3bec <exit>
     f0d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f11:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f14:	3b 45 dc             	cmp    -0x24(%ebp),%eax
     f17:	7c b9                	jl     ed2 <twofiles+0x17d>
     f19:	8b 45 dc             	mov    -0x24(%ebp),%eax
     f1c:	01 45 ec             	add    %eax,-0x14(%ebp)
     f1f:	83 ec 04             	sub    $0x4,%esp
     f22:	68 00 20 00 00       	push   $0x2000
     f27:	68 c0 86 00 00       	push   $0x86c0
     f2c:	ff 75 e0             	pushl  -0x20(%ebp)
     f2f:	e8 d0 2c 00 00       	call   3c04 <read>
     f34:	83 c4 10             	add    $0x10,%esp
     f37:	89 45 dc             	mov    %eax,-0x24(%ebp)
     f3a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     f3e:	7f 89                	jg     ec9 <twofiles+0x174>
     f40:	83 ec 0c             	sub    $0xc,%esp
     f43:	ff 75 e0             	pushl  -0x20(%ebp)
     f46:	e8 c9 2c 00 00       	call   3c14 <close>
     f4b:	83 c4 10             	add    $0x10,%esp
     f4e:	81 7d ec 70 17 00 00 	cmpl   $0x1770,-0x14(%ebp)
     f55:	74 1a                	je     f71 <twofiles+0x21c>
     f57:	83 ec 04             	sub    $0x4,%esp
     f5a:	ff 75 ec             	pushl  -0x14(%ebp)
     f5d:	68 5e 46 00 00       	push   $0x465e
     f62:	6a 01                	push   $0x1
     f64:	e8 08 2e 00 00       	call   3d71 <printf>
     f69:	83 c4 10             	add    $0x10,%esp
     f6c:	e8 7b 2c 00 00       	call   3bec <exit>
     f71:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f75:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
     f79:	0f 8e 1e ff ff ff    	jle    e9d <twofiles+0x148>
     f7f:	83 ec 0c             	sub    $0xc,%esp
     f82:	68 2c 46 00 00       	push   $0x462c
     f87:	e8 b0 2c 00 00       	call   3c3c <unlink>
     f8c:	83 c4 10             	add    $0x10,%esp
     f8f:	83 ec 0c             	sub    $0xc,%esp
     f92:	68 2f 46 00 00       	push   $0x462f
     f97:	e8 a0 2c 00 00       	call   3c3c <unlink>
     f9c:	83 c4 10             	add    $0x10,%esp
     f9f:	83 ec 08             	sub    $0x8,%esp
     fa2:	68 6f 46 00 00       	push   $0x466f
     fa7:	6a 01                	push   $0x1
     fa9:	e8 c3 2d 00 00       	call   3d71 <printf>
     fae:	83 c4 10             	add    $0x10,%esp
     fb1:	c9                   	leave  
     fb2:	c3                   	ret    

00000fb3 <createdelete>:
     fb3:	55                   	push   %ebp
     fb4:	89 e5                	mov    %esp,%ebp
     fb6:	83 ec 38             	sub    $0x38,%esp
     fb9:	83 ec 08             	sub    $0x8,%esp
     fbc:	68 7c 46 00 00       	push   $0x467c
     fc1:	6a 01                	push   $0x1
     fc3:	e8 a9 2d 00 00       	call   3d71 <printf>
     fc8:	83 c4 10             	add    $0x10,%esp
     fcb:	e8 14 2c 00 00       	call   3be4 <fork>
     fd0:	89 45 f0             	mov    %eax,-0x10(%ebp)
     fd3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     fd7:	79 17                	jns    ff0 <createdelete+0x3d>
     fd9:	83 ec 08             	sub    $0x8,%esp
     fdc:	68 15 45 00 00       	push   $0x4515
     fe1:	6a 01                	push   $0x1
     fe3:	e8 89 2d 00 00       	call   3d71 <printf>
     fe8:	83 c4 10             	add    $0x10,%esp
     feb:	e8 fc 2b 00 00       	call   3bec <exit>
     ff0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     ff4:	74 07                	je     ffd <createdelete+0x4a>
     ff6:	b8 70 00 00 00       	mov    $0x70,%eax
     ffb:	eb 05                	jmp    1002 <createdelete+0x4f>
     ffd:	b8 63 00 00 00       	mov    $0x63,%eax
    1002:	88 45 cc             	mov    %al,-0x34(%ebp)
    1005:	c6 45 ce 00          	movb   $0x0,-0x32(%ebp)
    1009:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1010:	e9 9b 00 00 00       	jmp    10b0 <createdelete+0xfd>
    1015:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1018:	83 c0 30             	add    $0x30,%eax
    101b:	88 45 cd             	mov    %al,-0x33(%ebp)
    101e:	83 ec 08             	sub    $0x8,%esp
    1021:	68 02 02 00 00       	push   $0x202
    1026:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1029:	50                   	push   %eax
    102a:	e8 fd 2b 00 00       	call   3c2c <open>
    102f:	83 c4 10             	add    $0x10,%esp
    1032:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1035:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1039:	79 17                	jns    1052 <createdelete+0x9f>
    103b:	83 ec 08             	sub    $0x8,%esp
    103e:	68 32 46 00 00       	push   $0x4632
    1043:	6a 01                	push   $0x1
    1045:	e8 27 2d 00 00       	call   3d71 <printf>
    104a:	83 c4 10             	add    $0x10,%esp
    104d:	e8 9a 2b 00 00       	call   3bec <exit>
    1052:	83 ec 0c             	sub    $0xc,%esp
    1055:	ff 75 ec             	pushl  -0x14(%ebp)
    1058:	e8 b7 2b 00 00       	call   3c14 <close>
    105d:	83 c4 10             	add    $0x10,%esp
    1060:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1064:	7e 46                	jle    10ac <createdelete+0xf9>
    1066:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1069:	83 e0 01             	and    $0x1,%eax
    106c:	85 c0                	test   %eax,%eax
    106e:	75 3c                	jne    10ac <createdelete+0xf9>
    1070:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1073:	89 c2                	mov    %eax,%edx
    1075:	c1 ea 1f             	shr    $0x1f,%edx
    1078:	01 d0                	add    %edx,%eax
    107a:	d1 f8                	sar    %eax
    107c:	83 c0 30             	add    $0x30,%eax
    107f:	88 45 cd             	mov    %al,-0x33(%ebp)
    1082:	83 ec 0c             	sub    $0xc,%esp
    1085:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1088:	50                   	push   %eax
    1089:	e8 ae 2b 00 00       	call   3c3c <unlink>
    108e:	83 c4 10             	add    $0x10,%esp
    1091:	85 c0                	test   %eax,%eax
    1093:	79 17                	jns    10ac <createdelete+0xf9>
    1095:	83 ec 08             	sub    $0x8,%esp
    1098:	68 8f 46 00 00       	push   $0x468f
    109d:	6a 01                	push   $0x1
    109f:	e8 cd 2c 00 00       	call   3d71 <printf>
    10a4:	83 c4 10             	add    $0x10,%esp
    10a7:	e8 40 2b 00 00       	call   3bec <exit>
    10ac:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10b0:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    10b4:	0f 8e 5b ff ff ff    	jle    1015 <createdelete+0x62>
    10ba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    10be:	75 05                	jne    10c5 <createdelete+0x112>
    10c0:	e8 27 2b 00 00       	call   3bec <exit>
    10c5:	e8 2a 2b 00 00       	call   3bf4 <wait>
    10ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    10d1:	e9 22 01 00 00       	jmp    11f8 <createdelete+0x245>
    10d6:	c6 45 cc 70          	movb   $0x70,-0x34(%ebp)
    10da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10dd:	83 c0 30             	add    $0x30,%eax
    10e0:	88 45 cd             	mov    %al,-0x33(%ebp)
    10e3:	83 ec 08             	sub    $0x8,%esp
    10e6:	6a 00                	push   $0x0
    10e8:	8d 45 cc             	lea    -0x34(%ebp),%eax
    10eb:	50                   	push   %eax
    10ec:	e8 3b 2b 00 00       	call   3c2c <open>
    10f1:	83 c4 10             	add    $0x10,%esp
    10f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    10f7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10fb:	74 06                	je     1103 <createdelete+0x150>
    10fd:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1101:	7e 21                	jle    1124 <createdelete+0x171>
    1103:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1107:	79 1b                	jns    1124 <createdelete+0x171>
    1109:	83 ec 04             	sub    $0x4,%esp
    110c:	8d 45 cc             	lea    -0x34(%ebp),%eax
    110f:	50                   	push   %eax
    1110:	68 a0 46 00 00       	push   $0x46a0
    1115:	6a 01                	push   $0x1
    1117:	e8 55 2c 00 00       	call   3d71 <printf>
    111c:	83 c4 10             	add    $0x10,%esp
    111f:	e8 c8 2a 00 00       	call   3bec <exit>
    1124:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1128:	7e 27                	jle    1151 <createdelete+0x19e>
    112a:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    112e:	7f 21                	jg     1151 <createdelete+0x19e>
    1130:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1134:	78 1b                	js     1151 <createdelete+0x19e>
    1136:	83 ec 04             	sub    $0x4,%esp
    1139:	8d 45 cc             	lea    -0x34(%ebp),%eax
    113c:	50                   	push   %eax
    113d:	68 c4 46 00 00       	push   $0x46c4
    1142:	6a 01                	push   $0x1
    1144:	e8 28 2c 00 00       	call   3d71 <printf>
    1149:	83 c4 10             	add    $0x10,%esp
    114c:	e8 9b 2a 00 00       	call   3bec <exit>
    1151:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1155:	78 0e                	js     1165 <createdelete+0x1b2>
    1157:	83 ec 0c             	sub    $0xc,%esp
    115a:	ff 75 ec             	pushl  -0x14(%ebp)
    115d:	e8 b2 2a 00 00       	call   3c14 <close>
    1162:	83 c4 10             	add    $0x10,%esp
    1165:	c6 45 cc 63          	movb   $0x63,-0x34(%ebp)
    1169:	8b 45 f4             	mov    -0xc(%ebp),%eax
    116c:	83 c0 30             	add    $0x30,%eax
    116f:	88 45 cd             	mov    %al,-0x33(%ebp)
    1172:	83 ec 08             	sub    $0x8,%esp
    1175:	6a 00                	push   $0x0
    1177:	8d 45 cc             	lea    -0x34(%ebp),%eax
    117a:	50                   	push   %eax
    117b:	e8 ac 2a 00 00       	call   3c2c <open>
    1180:	83 c4 10             	add    $0x10,%esp
    1183:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1186:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    118a:	74 06                	je     1192 <createdelete+0x1df>
    118c:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1190:	7e 21                	jle    11b3 <createdelete+0x200>
    1192:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1196:	79 1b                	jns    11b3 <createdelete+0x200>
    1198:	83 ec 04             	sub    $0x4,%esp
    119b:	8d 45 cc             	lea    -0x34(%ebp),%eax
    119e:	50                   	push   %eax
    119f:	68 a0 46 00 00       	push   $0x46a0
    11a4:	6a 01                	push   $0x1
    11a6:	e8 c6 2b 00 00       	call   3d71 <printf>
    11ab:	83 c4 10             	add    $0x10,%esp
    11ae:	e8 39 2a 00 00       	call   3bec <exit>
    11b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11b7:	7e 27                	jle    11e0 <createdelete+0x22d>
    11b9:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    11bd:	7f 21                	jg     11e0 <createdelete+0x22d>
    11bf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11c3:	78 1b                	js     11e0 <createdelete+0x22d>
    11c5:	83 ec 04             	sub    $0x4,%esp
    11c8:	8d 45 cc             	lea    -0x34(%ebp),%eax
    11cb:	50                   	push   %eax
    11cc:	68 c4 46 00 00       	push   $0x46c4
    11d1:	6a 01                	push   $0x1
    11d3:	e8 99 2b 00 00       	call   3d71 <printf>
    11d8:	83 c4 10             	add    $0x10,%esp
    11db:	e8 0c 2a 00 00       	call   3bec <exit>
    11e0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11e4:	78 0e                	js     11f4 <createdelete+0x241>
    11e6:	83 ec 0c             	sub    $0xc,%esp
    11e9:	ff 75 ec             	pushl  -0x14(%ebp)
    11ec:	e8 23 2a 00 00       	call   3c14 <close>
    11f1:	83 c4 10             	add    $0x10,%esp
    11f4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    11f8:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    11fc:	0f 8e d4 fe ff ff    	jle    10d6 <createdelete+0x123>
    1202:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1209:	eb 33                	jmp    123e <createdelete+0x28b>
    120b:	c6 45 cc 70          	movb   $0x70,-0x34(%ebp)
    120f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1212:	83 c0 30             	add    $0x30,%eax
    1215:	88 45 cd             	mov    %al,-0x33(%ebp)
    1218:	83 ec 0c             	sub    $0xc,%esp
    121b:	8d 45 cc             	lea    -0x34(%ebp),%eax
    121e:	50                   	push   %eax
    121f:	e8 18 2a 00 00       	call   3c3c <unlink>
    1224:	83 c4 10             	add    $0x10,%esp
    1227:	c6 45 cc 63          	movb   $0x63,-0x34(%ebp)
    122b:	83 ec 0c             	sub    $0xc,%esp
    122e:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1231:	50                   	push   %eax
    1232:	e8 05 2a 00 00       	call   3c3c <unlink>
    1237:	83 c4 10             	add    $0x10,%esp
    123a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    123e:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1242:	7e c7                	jle    120b <createdelete+0x258>
    1244:	83 ec 08             	sub    $0x8,%esp
    1247:	68 e4 46 00 00       	push   $0x46e4
    124c:	6a 01                	push   $0x1
    124e:	e8 1e 2b 00 00       	call   3d71 <printf>
    1253:	83 c4 10             	add    $0x10,%esp
    1256:	c9                   	leave  
    1257:	c3                   	ret    

00001258 <unlinkread>:
    1258:	55                   	push   %ebp
    1259:	89 e5                	mov    %esp,%ebp
    125b:	83 ec 18             	sub    $0x18,%esp
    125e:	83 ec 08             	sub    $0x8,%esp
    1261:	68 f5 46 00 00       	push   $0x46f5
    1266:	6a 01                	push   $0x1
    1268:	e8 04 2b 00 00       	call   3d71 <printf>
    126d:	83 c4 10             	add    $0x10,%esp
    1270:	83 ec 08             	sub    $0x8,%esp
    1273:	68 02 02 00 00       	push   $0x202
    1278:	68 06 47 00 00       	push   $0x4706
    127d:	e8 aa 29 00 00       	call   3c2c <open>
    1282:	83 c4 10             	add    $0x10,%esp
    1285:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1288:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    128c:	79 17                	jns    12a5 <unlinkread+0x4d>
    128e:	83 ec 08             	sub    $0x8,%esp
    1291:	68 11 47 00 00       	push   $0x4711
    1296:	6a 01                	push   $0x1
    1298:	e8 d4 2a 00 00       	call   3d71 <printf>
    129d:	83 c4 10             	add    $0x10,%esp
    12a0:	e8 47 29 00 00       	call   3bec <exit>
    12a5:	83 ec 04             	sub    $0x4,%esp
    12a8:	6a 05                	push   $0x5
    12aa:	68 2b 47 00 00       	push   $0x472b
    12af:	ff 75 f4             	pushl  -0xc(%ebp)
    12b2:	e8 55 29 00 00       	call   3c0c <write>
    12b7:	83 c4 10             	add    $0x10,%esp
    12ba:	83 ec 0c             	sub    $0xc,%esp
    12bd:	ff 75 f4             	pushl  -0xc(%ebp)
    12c0:	e8 4f 29 00 00       	call   3c14 <close>
    12c5:	83 c4 10             	add    $0x10,%esp
    12c8:	83 ec 08             	sub    $0x8,%esp
    12cb:	6a 02                	push   $0x2
    12cd:	68 06 47 00 00       	push   $0x4706
    12d2:	e8 55 29 00 00       	call   3c2c <open>
    12d7:	83 c4 10             	add    $0x10,%esp
    12da:	89 45 f4             	mov    %eax,-0xc(%ebp)
    12dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12e1:	79 17                	jns    12fa <unlinkread+0xa2>
    12e3:	83 ec 08             	sub    $0x8,%esp
    12e6:	68 31 47 00 00       	push   $0x4731
    12eb:	6a 01                	push   $0x1
    12ed:	e8 7f 2a 00 00       	call   3d71 <printf>
    12f2:	83 c4 10             	add    $0x10,%esp
    12f5:	e8 f2 28 00 00       	call   3bec <exit>
    12fa:	83 ec 0c             	sub    $0xc,%esp
    12fd:	68 06 47 00 00       	push   $0x4706
    1302:	e8 35 29 00 00       	call   3c3c <unlink>
    1307:	83 c4 10             	add    $0x10,%esp
    130a:	85 c0                	test   %eax,%eax
    130c:	74 17                	je     1325 <unlinkread+0xcd>
    130e:	83 ec 08             	sub    $0x8,%esp
    1311:	68 49 47 00 00       	push   $0x4749
    1316:	6a 01                	push   $0x1
    1318:	e8 54 2a 00 00       	call   3d71 <printf>
    131d:	83 c4 10             	add    $0x10,%esp
    1320:	e8 c7 28 00 00       	call   3bec <exit>
    1325:	83 ec 08             	sub    $0x8,%esp
    1328:	68 02 02 00 00       	push   $0x202
    132d:	68 06 47 00 00       	push   $0x4706
    1332:	e8 f5 28 00 00       	call   3c2c <open>
    1337:	83 c4 10             	add    $0x10,%esp
    133a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    133d:	83 ec 04             	sub    $0x4,%esp
    1340:	6a 03                	push   $0x3
    1342:	68 63 47 00 00       	push   $0x4763
    1347:	ff 75 f0             	pushl  -0x10(%ebp)
    134a:	e8 bd 28 00 00       	call   3c0c <write>
    134f:	83 c4 10             	add    $0x10,%esp
    1352:	83 ec 0c             	sub    $0xc,%esp
    1355:	ff 75 f0             	pushl  -0x10(%ebp)
    1358:	e8 b7 28 00 00       	call   3c14 <close>
    135d:	83 c4 10             	add    $0x10,%esp
    1360:	83 ec 04             	sub    $0x4,%esp
    1363:	68 00 20 00 00       	push   $0x2000
    1368:	68 c0 86 00 00       	push   $0x86c0
    136d:	ff 75 f4             	pushl  -0xc(%ebp)
    1370:	e8 8f 28 00 00       	call   3c04 <read>
    1375:	83 c4 10             	add    $0x10,%esp
    1378:	83 f8 05             	cmp    $0x5,%eax
    137b:	74 17                	je     1394 <unlinkread+0x13c>
    137d:	83 ec 08             	sub    $0x8,%esp
    1380:	68 67 47 00 00       	push   $0x4767
    1385:	6a 01                	push   $0x1
    1387:	e8 e5 29 00 00       	call   3d71 <printf>
    138c:	83 c4 10             	add    $0x10,%esp
    138f:	e8 58 28 00 00       	call   3bec <exit>
    1394:	0f b6 05 c0 86 00 00 	movzbl 0x86c0,%eax
    139b:	3c 68                	cmp    $0x68,%al
    139d:	74 17                	je     13b6 <unlinkread+0x15e>
    139f:	83 ec 08             	sub    $0x8,%esp
    13a2:	68 7e 47 00 00       	push   $0x477e
    13a7:	6a 01                	push   $0x1
    13a9:	e8 c3 29 00 00       	call   3d71 <printf>
    13ae:	83 c4 10             	add    $0x10,%esp
    13b1:	e8 36 28 00 00       	call   3bec <exit>
    13b6:	83 ec 04             	sub    $0x4,%esp
    13b9:	6a 0a                	push   $0xa
    13bb:	68 c0 86 00 00       	push   $0x86c0
    13c0:	ff 75 f4             	pushl  -0xc(%ebp)
    13c3:	e8 44 28 00 00       	call   3c0c <write>
    13c8:	83 c4 10             	add    $0x10,%esp
    13cb:	83 f8 0a             	cmp    $0xa,%eax
    13ce:	74 17                	je     13e7 <unlinkread+0x18f>
    13d0:	83 ec 08             	sub    $0x8,%esp
    13d3:	68 95 47 00 00       	push   $0x4795
    13d8:	6a 01                	push   $0x1
    13da:	e8 92 29 00 00       	call   3d71 <printf>
    13df:	83 c4 10             	add    $0x10,%esp
    13e2:	e8 05 28 00 00       	call   3bec <exit>
    13e7:	83 ec 0c             	sub    $0xc,%esp
    13ea:	ff 75 f4             	pushl  -0xc(%ebp)
    13ed:	e8 22 28 00 00       	call   3c14 <close>
    13f2:	83 c4 10             	add    $0x10,%esp
    13f5:	83 ec 0c             	sub    $0xc,%esp
    13f8:	68 06 47 00 00       	push   $0x4706
    13fd:	e8 3a 28 00 00       	call   3c3c <unlink>
    1402:	83 c4 10             	add    $0x10,%esp
    1405:	83 ec 08             	sub    $0x8,%esp
    1408:	68 ae 47 00 00       	push   $0x47ae
    140d:	6a 01                	push   $0x1
    140f:	e8 5d 29 00 00       	call   3d71 <printf>
    1414:	83 c4 10             	add    $0x10,%esp
    1417:	c9                   	leave  
    1418:	c3                   	ret    

00001419 <linktest>:
    1419:	55                   	push   %ebp
    141a:	89 e5                	mov    %esp,%ebp
    141c:	83 ec 18             	sub    $0x18,%esp
    141f:	83 ec 08             	sub    $0x8,%esp
    1422:	68 bd 47 00 00       	push   $0x47bd
    1427:	6a 01                	push   $0x1
    1429:	e8 43 29 00 00       	call   3d71 <printf>
    142e:	83 c4 10             	add    $0x10,%esp
    1431:	83 ec 0c             	sub    $0xc,%esp
    1434:	68 c7 47 00 00       	push   $0x47c7
    1439:	e8 fe 27 00 00       	call   3c3c <unlink>
    143e:	83 c4 10             	add    $0x10,%esp
    1441:	83 ec 0c             	sub    $0xc,%esp
    1444:	68 cb 47 00 00       	push   $0x47cb
    1449:	e8 ee 27 00 00       	call   3c3c <unlink>
    144e:	83 c4 10             	add    $0x10,%esp
    1451:	83 ec 08             	sub    $0x8,%esp
    1454:	68 02 02 00 00       	push   $0x202
    1459:	68 c7 47 00 00       	push   $0x47c7
    145e:	e8 c9 27 00 00       	call   3c2c <open>
    1463:	83 c4 10             	add    $0x10,%esp
    1466:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1469:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    146d:	79 17                	jns    1486 <linktest+0x6d>
    146f:	83 ec 08             	sub    $0x8,%esp
    1472:	68 cf 47 00 00       	push   $0x47cf
    1477:	6a 01                	push   $0x1
    1479:	e8 f3 28 00 00       	call   3d71 <printf>
    147e:	83 c4 10             	add    $0x10,%esp
    1481:	e8 66 27 00 00       	call   3bec <exit>
    1486:	83 ec 04             	sub    $0x4,%esp
    1489:	6a 05                	push   $0x5
    148b:	68 2b 47 00 00       	push   $0x472b
    1490:	ff 75 f4             	pushl  -0xc(%ebp)
    1493:	e8 74 27 00 00       	call   3c0c <write>
    1498:	83 c4 10             	add    $0x10,%esp
    149b:	83 f8 05             	cmp    $0x5,%eax
    149e:	74 17                	je     14b7 <linktest+0x9e>
    14a0:	83 ec 08             	sub    $0x8,%esp
    14a3:	68 e2 47 00 00       	push   $0x47e2
    14a8:	6a 01                	push   $0x1
    14aa:	e8 c2 28 00 00       	call   3d71 <printf>
    14af:	83 c4 10             	add    $0x10,%esp
    14b2:	e8 35 27 00 00       	call   3bec <exit>
    14b7:	83 ec 0c             	sub    $0xc,%esp
    14ba:	ff 75 f4             	pushl  -0xc(%ebp)
    14bd:	e8 52 27 00 00       	call   3c14 <close>
    14c2:	83 c4 10             	add    $0x10,%esp
    14c5:	83 ec 08             	sub    $0x8,%esp
    14c8:	68 cb 47 00 00       	push   $0x47cb
    14cd:	68 c7 47 00 00       	push   $0x47c7
    14d2:	e8 75 27 00 00       	call   3c4c <link>
    14d7:	83 c4 10             	add    $0x10,%esp
    14da:	85 c0                	test   %eax,%eax
    14dc:	79 17                	jns    14f5 <linktest+0xdc>
    14de:	83 ec 08             	sub    $0x8,%esp
    14e1:	68 f4 47 00 00       	push   $0x47f4
    14e6:	6a 01                	push   $0x1
    14e8:	e8 84 28 00 00       	call   3d71 <printf>
    14ed:	83 c4 10             	add    $0x10,%esp
    14f0:	e8 f7 26 00 00       	call   3bec <exit>
    14f5:	83 ec 0c             	sub    $0xc,%esp
    14f8:	68 c7 47 00 00       	push   $0x47c7
    14fd:	e8 3a 27 00 00       	call   3c3c <unlink>
    1502:	83 c4 10             	add    $0x10,%esp
    1505:	83 ec 08             	sub    $0x8,%esp
    1508:	6a 00                	push   $0x0
    150a:	68 c7 47 00 00       	push   $0x47c7
    150f:	e8 18 27 00 00       	call   3c2c <open>
    1514:	83 c4 10             	add    $0x10,%esp
    1517:	85 c0                	test   %eax,%eax
    1519:	78 17                	js     1532 <linktest+0x119>
    151b:	83 ec 08             	sub    $0x8,%esp
    151e:	68 0c 48 00 00       	push   $0x480c
    1523:	6a 01                	push   $0x1
    1525:	e8 47 28 00 00       	call   3d71 <printf>
    152a:	83 c4 10             	add    $0x10,%esp
    152d:	e8 ba 26 00 00       	call   3bec <exit>
    1532:	83 ec 08             	sub    $0x8,%esp
    1535:	6a 00                	push   $0x0
    1537:	68 cb 47 00 00       	push   $0x47cb
    153c:	e8 eb 26 00 00       	call   3c2c <open>
    1541:	83 c4 10             	add    $0x10,%esp
    1544:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1547:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    154b:	79 17                	jns    1564 <linktest+0x14b>
    154d:	83 ec 08             	sub    $0x8,%esp
    1550:	68 31 48 00 00       	push   $0x4831
    1555:	6a 01                	push   $0x1
    1557:	e8 15 28 00 00       	call   3d71 <printf>
    155c:	83 c4 10             	add    $0x10,%esp
    155f:	e8 88 26 00 00       	call   3bec <exit>
    1564:	83 ec 04             	sub    $0x4,%esp
    1567:	68 00 20 00 00       	push   $0x2000
    156c:	68 c0 86 00 00       	push   $0x86c0
    1571:	ff 75 f4             	pushl  -0xc(%ebp)
    1574:	e8 8b 26 00 00       	call   3c04 <read>
    1579:	83 c4 10             	add    $0x10,%esp
    157c:	83 f8 05             	cmp    $0x5,%eax
    157f:	74 17                	je     1598 <linktest+0x17f>
    1581:	83 ec 08             	sub    $0x8,%esp
    1584:	68 42 48 00 00       	push   $0x4842
    1589:	6a 01                	push   $0x1
    158b:	e8 e1 27 00 00       	call   3d71 <printf>
    1590:	83 c4 10             	add    $0x10,%esp
    1593:	e8 54 26 00 00       	call   3bec <exit>
    1598:	83 ec 0c             	sub    $0xc,%esp
    159b:	ff 75 f4             	pushl  -0xc(%ebp)
    159e:	e8 71 26 00 00       	call   3c14 <close>
    15a3:	83 c4 10             	add    $0x10,%esp
    15a6:	83 ec 08             	sub    $0x8,%esp
    15a9:	68 cb 47 00 00       	push   $0x47cb
    15ae:	68 cb 47 00 00       	push   $0x47cb
    15b3:	e8 94 26 00 00       	call   3c4c <link>
    15b8:	83 c4 10             	add    $0x10,%esp
    15bb:	85 c0                	test   %eax,%eax
    15bd:	78 17                	js     15d6 <linktest+0x1bd>
    15bf:	83 ec 08             	sub    $0x8,%esp
    15c2:	68 53 48 00 00       	push   $0x4853
    15c7:	6a 01                	push   $0x1
    15c9:	e8 a3 27 00 00       	call   3d71 <printf>
    15ce:	83 c4 10             	add    $0x10,%esp
    15d1:	e8 16 26 00 00       	call   3bec <exit>
    15d6:	83 ec 0c             	sub    $0xc,%esp
    15d9:	68 cb 47 00 00       	push   $0x47cb
    15de:	e8 59 26 00 00       	call   3c3c <unlink>
    15e3:	83 c4 10             	add    $0x10,%esp
    15e6:	83 ec 08             	sub    $0x8,%esp
    15e9:	68 c7 47 00 00       	push   $0x47c7
    15ee:	68 cb 47 00 00       	push   $0x47cb
    15f3:	e8 54 26 00 00       	call   3c4c <link>
    15f8:	83 c4 10             	add    $0x10,%esp
    15fb:	85 c0                	test   %eax,%eax
    15fd:	78 17                	js     1616 <linktest+0x1fd>
    15ff:	83 ec 08             	sub    $0x8,%esp
    1602:	68 74 48 00 00       	push   $0x4874
    1607:	6a 01                	push   $0x1
    1609:	e8 63 27 00 00       	call   3d71 <printf>
    160e:	83 c4 10             	add    $0x10,%esp
    1611:	e8 d6 25 00 00       	call   3bec <exit>
    1616:	83 ec 08             	sub    $0x8,%esp
    1619:	68 c7 47 00 00       	push   $0x47c7
    161e:	68 97 48 00 00       	push   $0x4897
    1623:	e8 24 26 00 00       	call   3c4c <link>
    1628:	83 c4 10             	add    $0x10,%esp
    162b:	85 c0                	test   %eax,%eax
    162d:	78 17                	js     1646 <linktest+0x22d>
    162f:	83 ec 08             	sub    $0x8,%esp
    1632:	68 99 48 00 00       	push   $0x4899
    1637:	6a 01                	push   $0x1
    1639:	e8 33 27 00 00       	call   3d71 <printf>
    163e:	83 c4 10             	add    $0x10,%esp
    1641:	e8 a6 25 00 00       	call   3bec <exit>
    1646:	83 ec 08             	sub    $0x8,%esp
    1649:	68 b5 48 00 00       	push   $0x48b5
    164e:	6a 01                	push   $0x1
    1650:	e8 1c 27 00 00       	call   3d71 <printf>
    1655:	83 c4 10             	add    $0x10,%esp
    1658:	c9                   	leave  
    1659:	c3                   	ret    

0000165a <concreate>:
    165a:	55                   	push   %ebp
    165b:	89 e5                	mov    %esp,%ebp
    165d:	83 ec 58             	sub    $0x58,%esp
    1660:	83 ec 08             	sub    $0x8,%esp
    1663:	68 c2 48 00 00       	push   $0x48c2
    1668:	6a 01                	push   $0x1
    166a:	e8 02 27 00 00       	call   3d71 <printf>
    166f:	83 c4 10             	add    $0x10,%esp
    1672:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
    1676:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
    167a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1681:	e9 fc 00 00 00       	jmp    1782 <concreate+0x128>
    1686:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1689:	83 c0 30             	add    $0x30,%eax
    168c:	88 45 e6             	mov    %al,-0x1a(%ebp)
    168f:	83 ec 0c             	sub    $0xc,%esp
    1692:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1695:	50                   	push   %eax
    1696:	e8 a1 25 00 00       	call   3c3c <unlink>
    169b:	83 c4 10             	add    $0x10,%esp
    169e:	e8 41 25 00 00       	call   3be4 <fork>
    16a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
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
    16ce:	83 ec 08             	sub    $0x8,%esp
    16d1:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    16d4:	50                   	push   %eax
    16d5:	68 d2 48 00 00       	push   $0x48d2
    16da:	e8 6d 25 00 00       	call   3c4c <link>
    16df:	83 c4 10             	add    $0x10,%esp
    16e2:	e9 87 00 00 00       	jmp    176e <concreate+0x114>
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
    1712:	83 ec 08             	sub    $0x8,%esp
    1715:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1718:	50                   	push   %eax
    1719:	68 d2 48 00 00       	push   $0x48d2
    171e:	e8 29 25 00 00       	call   3c4c <link>
    1723:	83 c4 10             	add    $0x10,%esp
    1726:	eb 46                	jmp    176e <concreate+0x114>
    1728:	83 ec 08             	sub    $0x8,%esp
    172b:	68 02 02 00 00       	push   $0x202
    1730:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1733:	50                   	push   %eax
    1734:	e8 f3 24 00 00       	call   3c2c <open>
    1739:	83 c4 10             	add    $0x10,%esp
    173c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    173f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1743:	79 1b                	jns    1760 <concreate+0x106>
    1745:	83 ec 04             	sub    $0x4,%esp
    1748:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    174b:	50                   	push   %eax
    174c:	68 d5 48 00 00       	push   $0x48d5
    1751:	6a 01                	push   $0x1
    1753:	e8 19 26 00 00       	call   3d71 <printf>
    1758:	83 c4 10             	add    $0x10,%esp
    175b:	e8 8c 24 00 00       	call   3bec <exit>
    1760:	83 ec 0c             	sub    $0xc,%esp
    1763:	ff 75 e8             	pushl  -0x18(%ebp)
    1766:	e8 a9 24 00 00       	call   3c14 <close>
    176b:	83 c4 10             	add    $0x10,%esp
    176e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1772:	75 05                	jne    1779 <concreate+0x11f>
    1774:	e8 73 24 00 00       	call   3bec <exit>
    1779:	e8 76 24 00 00       	call   3bf4 <wait>
    177e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1782:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1786:	0f 8e fa fe ff ff    	jle    1686 <concreate+0x2c>
    178c:	83 ec 04             	sub    $0x4,%esp
    178f:	6a 28                	push   $0x28
    1791:	6a 00                	push   $0x0
    1793:	8d 45 bd             	lea    -0x43(%ebp),%eax
    1796:	50                   	push   %eax
    1797:	e8 b6 22 00 00       	call   3a52 <memset>
    179c:	83 c4 10             	add    $0x10,%esp
    179f:	83 ec 08             	sub    $0x8,%esp
    17a2:	6a 00                	push   $0x0
    17a4:	68 97 48 00 00       	push   $0x4897
    17a9:	e8 7e 24 00 00       	call   3c2c <open>
    17ae:	83 c4 10             	add    $0x10,%esp
    17b1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    17b4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    17bb:	e9 93 00 00 00       	jmp    1853 <concreate+0x1f9>
    17c0:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    17c4:	66 85 c0             	test   %ax,%ax
    17c7:	75 05                	jne    17ce <concreate+0x174>
    17c9:	e9 85 00 00 00       	jmp    1853 <concreate+0x1f9>
    17ce:	0f b6 45 ae          	movzbl -0x52(%ebp),%eax
    17d2:	3c 43                	cmp    $0x43,%al
    17d4:	75 7d                	jne    1853 <concreate+0x1f9>
    17d6:	0f b6 45 b0          	movzbl -0x50(%ebp),%eax
    17da:	84 c0                	test   %al,%al
    17dc:	75 75                	jne    1853 <concreate+0x1f9>
    17de:	0f b6 45 af          	movzbl -0x51(%ebp),%eax
    17e2:	0f be c0             	movsbl %al,%eax
    17e5:	83 e8 30             	sub    $0x30,%eax
    17e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    17eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17ef:	78 08                	js     17f9 <concreate+0x19f>
    17f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f4:	83 f8 27             	cmp    $0x27,%eax
    17f7:	76 1e                	jbe    1817 <concreate+0x1bd>
    17f9:	83 ec 04             	sub    $0x4,%esp
    17fc:	8d 45 ac             	lea    -0x54(%ebp),%eax
    17ff:	83 c0 02             	add    $0x2,%eax
    1802:	50                   	push   %eax
    1803:	68 f1 48 00 00       	push   $0x48f1
    1808:	6a 01                	push   $0x1
    180a:	e8 62 25 00 00       	call   3d71 <printf>
    180f:	83 c4 10             	add    $0x10,%esp
    1812:	e8 d5 23 00 00       	call   3bec <exit>
    1817:	8d 55 bd             	lea    -0x43(%ebp),%edx
    181a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181d:	01 d0                	add    %edx,%eax
    181f:	0f b6 00             	movzbl (%eax),%eax
    1822:	84 c0                	test   %al,%al
    1824:	74 1e                	je     1844 <concreate+0x1ea>
    1826:	83 ec 04             	sub    $0x4,%esp
    1829:	8d 45 ac             	lea    -0x54(%ebp),%eax
    182c:	83 c0 02             	add    $0x2,%eax
    182f:	50                   	push   %eax
    1830:	68 0a 49 00 00       	push   $0x490a
    1835:	6a 01                	push   $0x1
    1837:	e8 35 25 00 00       	call   3d71 <printf>
    183c:	83 c4 10             	add    $0x10,%esp
    183f:	e8 a8 23 00 00       	call   3bec <exit>
    1844:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1847:	8b 45 f4             	mov    -0xc(%ebp),%eax
    184a:	01 d0                	add    %edx,%eax
    184c:	c6 00 01             	movb   $0x1,(%eax)
    184f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1853:	83 ec 04             	sub    $0x4,%esp
    1856:	6a 10                	push   $0x10
    1858:	8d 45 ac             	lea    -0x54(%ebp),%eax
    185b:	50                   	push   %eax
    185c:	ff 75 e8             	pushl  -0x18(%ebp)
    185f:	e8 a0 23 00 00       	call   3c04 <read>
    1864:	83 c4 10             	add    $0x10,%esp
    1867:	85 c0                	test   %eax,%eax
    1869:	0f 8f 51 ff ff ff    	jg     17c0 <concreate+0x166>
    186f:	83 ec 0c             	sub    $0xc,%esp
    1872:	ff 75 e8             	pushl  -0x18(%ebp)
    1875:	e8 9a 23 00 00       	call   3c14 <close>
    187a:	83 c4 10             	add    $0x10,%esp
    187d:	83 7d f0 28          	cmpl   $0x28,-0x10(%ebp)
    1881:	74 17                	je     189a <concreate+0x240>
    1883:	83 ec 08             	sub    $0x8,%esp
    1886:	68 28 49 00 00       	push   $0x4928
    188b:	6a 01                	push   $0x1
    188d:	e8 df 24 00 00       	call   3d71 <printf>
    1892:	83 c4 10             	add    $0x10,%esp
    1895:	e8 52 23 00 00       	call   3bec <exit>
    189a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    18a1:	e9 45 01 00 00       	jmp    19eb <concreate+0x391>
    18a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a9:	83 c0 30             	add    $0x30,%eax
    18ac:	88 45 e6             	mov    %al,-0x1a(%ebp)
    18af:	e8 30 23 00 00       	call   3be4 <fork>
    18b4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18b7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18bb:	79 17                	jns    18d4 <concreate+0x27a>
    18bd:	83 ec 08             	sub    $0x8,%esp
    18c0:	68 15 45 00 00       	push   $0x4515
    18c5:	6a 01                	push   $0x1
    18c7:	e8 a5 24 00 00       	call   3d71 <printf>
    18cc:	83 c4 10             	add    $0x10,%esp
    18cf:	e8 18 23 00 00       	call   3bec <exit>
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
    191a:	83 fa 01             	cmp    $0x1,%edx
    191d:	75 7c                	jne    199b <concreate+0x341>
    191f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1923:	74 76                	je     199b <concreate+0x341>
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
    199b:	83 ec 0c             	sub    $0xc,%esp
    199e:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19a1:	50                   	push   %eax
    19a2:	e8 95 22 00 00       	call   3c3c <unlink>
    19a7:	83 c4 10             	add    $0x10,%esp
    19aa:	83 ec 0c             	sub    $0xc,%esp
    19ad:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19b0:	50                   	push   %eax
    19b1:	e8 86 22 00 00       	call   3c3c <unlink>
    19b6:	83 c4 10             	add    $0x10,%esp
    19b9:	83 ec 0c             	sub    $0xc,%esp
    19bc:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19bf:	50                   	push   %eax
    19c0:	e8 77 22 00 00       	call   3c3c <unlink>
    19c5:	83 c4 10             	add    $0x10,%esp
    19c8:	83 ec 0c             	sub    $0xc,%esp
    19cb:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19ce:	50                   	push   %eax
    19cf:	e8 68 22 00 00       	call   3c3c <unlink>
    19d4:	83 c4 10             	add    $0x10,%esp
    19d7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19db:	75 05                	jne    19e2 <concreate+0x388>
    19dd:	e8 0a 22 00 00       	call   3bec <exit>
    19e2:	e8 0d 22 00 00       	call   3bf4 <wait>
    19e7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    19eb:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    19ef:	0f 8e b1 fe ff ff    	jle    18a6 <concreate+0x24c>
    19f5:	83 ec 08             	sub    $0x8,%esp
    19f8:	68 59 49 00 00       	push   $0x4959
    19fd:	6a 01                	push   $0x1
    19ff:	e8 6d 23 00 00       	call   3d71 <printf>
    1a04:	83 c4 10             	add    $0x10,%esp
    1a07:	c9                   	leave  
    1a08:	c3                   	ret    

00001a09 <linkunlink>:
    1a09:	55                   	push   %ebp
    1a0a:	89 e5                	mov    %esp,%ebp
    1a0c:	83 ec 18             	sub    $0x18,%esp
    1a0f:	83 ec 08             	sub    $0x8,%esp
    1a12:	68 67 49 00 00       	push   $0x4967
    1a17:	6a 01                	push   $0x1
    1a19:	e8 53 23 00 00       	call   3d71 <printf>
    1a1e:	83 c4 10             	add    $0x10,%esp
    1a21:	83 ec 0c             	sub    $0xc,%esp
    1a24:	68 ce 44 00 00       	push   $0x44ce
    1a29:	e8 0e 22 00 00       	call   3c3c <unlink>
    1a2e:	83 c4 10             	add    $0x10,%esp
    1a31:	e8 ae 21 00 00       	call   3be4 <fork>
    1a36:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1a39:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a3d:	79 17                	jns    1a56 <linkunlink+0x4d>
    1a3f:	83 ec 08             	sub    $0x8,%esp
    1a42:	68 15 45 00 00       	push   $0x4515
    1a47:	6a 01                	push   $0x1
    1a49:	e8 23 23 00 00       	call   3d71 <printf>
    1a4e:	83 c4 10             	add    $0x10,%esp
    1a51:	e8 96 21 00 00       	call   3bec <exit>
    1a56:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a5a:	74 07                	je     1a63 <linkunlink+0x5a>
    1a5c:	b8 01 00 00 00       	mov    $0x1,%eax
    1a61:	eb 05                	jmp    1a68 <linkunlink+0x5f>
    1a63:	b8 61 00 00 00       	mov    $0x61,%eax
    1a68:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a6b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1a72:	e9 9a 00 00 00       	jmp    1b11 <linkunlink+0x108>
    1a77:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a7a:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    1a80:	05 39 30 00 00       	add    $0x3039,%eax
    1a85:	89 45 f0             	mov    %eax,-0x10(%ebp)
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
    1aa6:	83 ec 08             	sub    $0x8,%esp
    1aa9:	68 02 02 00 00       	push   $0x202
    1aae:	68 ce 44 00 00       	push   $0x44ce
    1ab3:	e8 74 21 00 00       	call   3c2c <open>
    1ab8:	83 c4 10             	add    $0x10,%esp
    1abb:	83 ec 0c             	sub    $0xc,%esp
    1abe:	50                   	push   %eax
    1abf:	e8 50 21 00 00       	call   3c14 <close>
    1ac4:	83 c4 10             	add    $0x10,%esp
    1ac7:	eb 44                	jmp    1b0d <linkunlink+0x104>
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
    1ae6:	83 ec 08             	sub    $0x8,%esp
    1ae9:	68 ce 44 00 00       	push   $0x44ce
    1aee:	68 78 49 00 00       	push   $0x4978
    1af3:	e8 54 21 00 00       	call   3c4c <link>
    1af8:	83 c4 10             	add    $0x10,%esp
    1afb:	eb 10                	jmp    1b0d <linkunlink+0x104>
    1afd:	83 ec 0c             	sub    $0xc,%esp
    1b00:	68 ce 44 00 00       	push   $0x44ce
    1b05:	e8 32 21 00 00       	call   3c3c <unlink>
    1b0a:	83 c4 10             	add    $0x10,%esp
    1b0d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b11:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    1b15:	0f 8e 5c ff ff ff    	jle    1a77 <linkunlink+0x6e>
    1b1b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b1f:	74 07                	je     1b28 <linkunlink+0x11f>
    1b21:	e8 ce 20 00 00       	call   3bf4 <wait>
    1b26:	eb 05                	jmp    1b2d <linkunlink+0x124>
    1b28:	e8 bf 20 00 00       	call   3bec <exit>
    1b2d:	83 ec 08             	sub    $0x8,%esp
    1b30:	68 7c 49 00 00       	push   $0x497c
    1b35:	6a 01                	push   $0x1
    1b37:	e8 35 22 00 00       	call   3d71 <printf>
    1b3c:	83 c4 10             	add    $0x10,%esp
    1b3f:	c9                   	leave  
    1b40:	c3                   	ret    

00001b41 <bigdir>:
    1b41:	55                   	push   %ebp
    1b42:	89 e5                	mov    %esp,%ebp
    1b44:	83 ec 28             	sub    $0x28,%esp
    1b47:	83 ec 08             	sub    $0x8,%esp
    1b4a:	68 8b 49 00 00       	push   $0x498b
    1b4f:	6a 01                	push   $0x1
    1b51:	e8 1b 22 00 00       	call   3d71 <printf>
    1b56:	83 c4 10             	add    $0x10,%esp
    1b59:	83 ec 0c             	sub    $0xc,%esp
    1b5c:	68 98 49 00 00       	push   $0x4998
    1b61:	e8 d6 20 00 00       	call   3c3c <unlink>
    1b66:	83 c4 10             	add    $0x10,%esp
    1b69:	83 ec 08             	sub    $0x8,%esp
    1b6c:	68 00 02 00 00       	push   $0x200
    1b71:	68 98 49 00 00       	push   $0x4998
    1b76:	e8 b1 20 00 00       	call   3c2c <open>
    1b7b:	83 c4 10             	add    $0x10,%esp
    1b7e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b81:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1b85:	79 17                	jns    1b9e <bigdir+0x5d>
    1b87:	83 ec 08             	sub    $0x8,%esp
    1b8a:	68 9b 49 00 00       	push   $0x499b
    1b8f:	6a 01                	push   $0x1
    1b91:	e8 db 21 00 00       	call   3d71 <printf>
    1b96:	83 c4 10             	add    $0x10,%esp
    1b99:	e8 4e 20 00 00       	call   3bec <exit>
    1b9e:	83 ec 0c             	sub    $0xc,%esp
    1ba1:	ff 75 f0             	pushl  -0x10(%ebp)
    1ba4:	e8 6b 20 00 00       	call   3c14 <close>
    1ba9:	83 c4 10             	add    $0x10,%esp
    1bac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1bb3:	eb 61                	jmp    1c16 <bigdir+0xd5>
    1bb5:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    1bb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bbc:	99                   	cltd   
    1bbd:	c1 ea 1a             	shr    $0x1a,%edx
    1bc0:	01 d0                	add    %edx,%eax
    1bc2:	c1 f8 06             	sar    $0x6,%eax
    1bc5:	83 c0 30             	add    $0x30,%eax
    1bc8:	88 45 e7             	mov    %al,-0x19(%ebp)
    1bcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bce:	99                   	cltd   
    1bcf:	c1 ea 1a             	shr    $0x1a,%edx
    1bd2:	01 d0                	add    %edx,%eax
    1bd4:	83 e0 3f             	and    $0x3f,%eax
    1bd7:	29 d0                	sub    %edx,%eax
    1bd9:	83 c0 30             	add    $0x30,%eax
    1bdc:	88 45 e8             	mov    %al,-0x18(%ebp)
    1bdf:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    1be3:	83 ec 08             	sub    $0x8,%esp
    1be6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1be9:	50                   	push   %eax
    1bea:	68 98 49 00 00       	push   $0x4998
    1bef:	e8 58 20 00 00       	call   3c4c <link>
    1bf4:	83 c4 10             	add    $0x10,%esp
    1bf7:	85 c0                	test   %eax,%eax
    1bf9:	74 17                	je     1c12 <bigdir+0xd1>
    1bfb:	83 ec 08             	sub    $0x8,%esp
    1bfe:	68 b1 49 00 00       	push   $0x49b1
    1c03:	6a 01                	push   $0x1
    1c05:	e8 67 21 00 00       	call   3d71 <printf>
    1c0a:	83 c4 10             	add    $0x10,%esp
    1c0d:	e8 da 1f 00 00       	call   3bec <exit>
    1c12:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1c16:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1c1d:	7e 96                	jle    1bb5 <bigdir+0x74>
    1c1f:	83 ec 0c             	sub    $0xc,%esp
    1c22:	68 98 49 00 00       	push   $0x4998
    1c27:	e8 10 20 00 00       	call   3c3c <unlink>
    1c2c:	83 c4 10             	add    $0x10,%esp
    1c2f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c36:	eb 5c                	jmp    1c94 <bigdir+0x153>
    1c38:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    1c3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c3f:	99                   	cltd   
    1c40:	c1 ea 1a             	shr    $0x1a,%edx
    1c43:	01 d0                	add    %edx,%eax
    1c45:	c1 f8 06             	sar    $0x6,%eax
    1c48:	83 c0 30             	add    $0x30,%eax
    1c4b:	88 45 e7             	mov    %al,-0x19(%ebp)
    1c4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c51:	99                   	cltd   
    1c52:	c1 ea 1a             	shr    $0x1a,%edx
    1c55:	01 d0                	add    %edx,%eax
    1c57:	83 e0 3f             	and    $0x3f,%eax
    1c5a:	29 d0                	sub    %edx,%eax
    1c5c:	83 c0 30             	add    $0x30,%eax
    1c5f:	88 45 e8             	mov    %al,-0x18(%ebp)
    1c62:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    1c66:	83 ec 0c             	sub    $0xc,%esp
    1c69:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1c6c:	50                   	push   %eax
    1c6d:	e8 ca 1f 00 00       	call   3c3c <unlink>
    1c72:	83 c4 10             	add    $0x10,%esp
    1c75:	85 c0                	test   %eax,%eax
    1c77:	74 17                	je     1c90 <bigdir+0x14f>
    1c79:	83 ec 08             	sub    $0x8,%esp
    1c7c:	68 c5 49 00 00       	push   $0x49c5
    1c81:	6a 01                	push   $0x1
    1c83:	e8 e9 20 00 00       	call   3d71 <printf>
    1c88:	83 c4 10             	add    $0x10,%esp
    1c8b:	e8 5c 1f 00 00       	call   3bec <exit>
    1c90:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1c94:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1c9b:	7e 9b                	jle    1c38 <bigdir+0xf7>
    1c9d:	83 ec 08             	sub    $0x8,%esp
    1ca0:	68 da 49 00 00       	push   $0x49da
    1ca5:	6a 01                	push   $0x1
    1ca7:	e8 c5 20 00 00       	call   3d71 <printf>
    1cac:	83 c4 10             	add    $0x10,%esp
    1caf:	c9                   	leave  
    1cb0:	c3                   	ret    

00001cb1 <subdir>:
    1cb1:	55                   	push   %ebp
    1cb2:	89 e5                	mov    %esp,%ebp
    1cb4:	83 ec 18             	sub    $0x18,%esp
    1cb7:	83 ec 08             	sub    $0x8,%esp
    1cba:	68 e5 49 00 00       	push   $0x49e5
    1cbf:	6a 01                	push   $0x1
    1cc1:	e8 ab 20 00 00       	call   3d71 <printf>
    1cc6:	83 c4 10             	add    $0x10,%esp
    1cc9:	83 ec 0c             	sub    $0xc,%esp
    1ccc:	68 f2 49 00 00       	push   $0x49f2
    1cd1:	e8 66 1f 00 00       	call   3c3c <unlink>
    1cd6:	83 c4 10             	add    $0x10,%esp
    1cd9:	83 ec 0c             	sub    $0xc,%esp
    1cdc:	68 f5 49 00 00       	push   $0x49f5
    1ce1:	e8 6e 1f 00 00       	call   3c54 <mkdir>
    1ce6:	83 c4 10             	add    $0x10,%esp
    1ce9:	85 c0                	test   %eax,%eax
    1ceb:	74 17                	je     1d04 <subdir+0x53>
    1ced:	83 ec 08             	sub    $0x8,%esp
    1cf0:	68 f8 49 00 00       	push   $0x49f8
    1cf5:	6a 01                	push   $0x1
    1cf7:	e8 75 20 00 00       	call   3d71 <printf>
    1cfc:	83 c4 10             	add    $0x10,%esp
    1cff:	e8 e8 1e 00 00       	call   3bec <exit>
    1d04:	83 ec 08             	sub    $0x8,%esp
    1d07:	68 02 02 00 00       	push   $0x202
    1d0c:	68 10 4a 00 00       	push   $0x4a10
    1d11:	e8 16 1f 00 00       	call   3c2c <open>
    1d16:	83 c4 10             	add    $0x10,%esp
    1d19:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1d1c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d20:	79 17                	jns    1d39 <subdir+0x88>
    1d22:	83 ec 08             	sub    $0x8,%esp
    1d25:	68 16 4a 00 00       	push   $0x4a16
    1d2a:	6a 01                	push   $0x1
    1d2c:	e8 40 20 00 00       	call   3d71 <printf>
    1d31:	83 c4 10             	add    $0x10,%esp
    1d34:	e8 b3 1e 00 00       	call   3bec <exit>
    1d39:	83 ec 04             	sub    $0x4,%esp
    1d3c:	6a 02                	push   $0x2
    1d3e:	68 f2 49 00 00       	push   $0x49f2
    1d43:	ff 75 f4             	pushl  -0xc(%ebp)
    1d46:	e8 c1 1e 00 00       	call   3c0c <write>
    1d4b:	83 c4 10             	add    $0x10,%esp
    1d4e:	83 ec 0c             	sub    $0xc,%esp
    1d51:	ff 75 f4             	pushl  -0xc(%ebp)
    1d54:	e8 bb 1e 00 00       	call   3c14 <close>
    1d59:	83 c4 10             	add    $0x10,%esp
    1d5c:	83 ec 0c             	sub    $0xc,%esp
    1d5f:	68 f5 49 00 00       	push   $0x49f5
    1d64:	e8 d3 1e 00 00       	call   3c3c <unlink>
    1d69:	83 c4 10             	add    $0x10,%esp
    1d6c:	85 c0                	test   %eax,%eax
    1d6e:	78 17                	js     1d87 <subdir+0xd6>
    1d70:	83 ec 08             	sub    $0x8,%esp
    1d73:	68 2c 4a 00 00       	push   $0x4a2c
    1d78:	6a 01                	push   $0x1
    1d7a:	e8 f2 1f 00 00       	call   3d71 <printf>
    1d7f:	83 c4 10             	add    $0x10,%esp
    1d82:	e8 65 1e 00 00       	call   3bec <exit>
    1d87:	83 ec 0c             	sub    $0xc,%esp
    1d8a:	68 52 4a 00 00       	push   $0x4a52
    1d8f:	e8 c0 1e 00 00       	call   3c54 <mkdir>
    1d94:	83 c4 10             	add    $0x10,%esp
    1d97:	85 c0                	test   %eax,%eax
    1d99:	74 17                	je     1db2 <subdir+0x101>
    1d9b:	83 ec 08             	sub    $0x8,%esp
    1d9e:	68 59 4a 00 00       	push   $0x4a59
    1da3:	6a 01                	push   $0x1
    1da5:	e8 c7 1f 00 00       	call   3d71 <printf>
    1daa:	83 c4 10             	add    $0x10,%esp
    1dad:	e8 3a 1e 00 00       	call   3bec <exit>
    1db2:	83 ec 08             	sub    $0x8,%esp
    1db5:	68 02 02 00 00       	push   $0x202
    1dba:	68 74 4a 00 00       	push   $0x4a74
    1dbf:	e8 68 1e 00 00       	call   3c2c <open>
    1dc4:	83 c4 10             	add    $0x10,%esp
    1dc7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1dca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1dce:	79 17                	jns    1de7 <subdir+0x136>
    1dd0:	83 ec 08             	sub    $0x8,%esp
    1dd3:	68 7d 4a 00 00       	push   $0x4a7d
    1dd8:	6a 01                	push   $0x1
    1dda:	e8 92 1f 00 00       	call   3d71 <printf>
    1ddf:	83 c4 10             	add    $0x10,%esp
    1de2:	e8 05 1e 00 00       	call   3bec <exit>
    1de7:	83 ec 04             	sub    $0x4,%esp
    1dea:	6a 02                	push   $0x2
    1dec:	68 95 4a 00 00       	push   $0x4a95
    1df1:	ff 75 f4             	pushl  -0xc(%ebp)
    1df4:	e8 13 1e 00 00       	call   3c0c <write>
    1df9:	83 c4 10             	add    $0x10,%esp
    1dfc:	83 ec 0c             	sub    $0xc,%esp
    1dff:	ff 75 f4             	pushl  -0xc(%ebp)
    1e02:	e8 0d 1e 00 00       	call   3c14 <close>
    1e07:	83 c4 10             	add    $0x10,%esp
    1e0a:	83 ec 08             	sub    $0x8,%esp
    1e0d:	6a 00                	push   $0x0
    1e0f:	68 98 4a 00 00       	push   $0x4a98
    1e14:	e8 13 1e 00 00       	call   3c2c <open>
    1e19:	83 c4 10             	add    $0x10,%esp
    1e1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1e1f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e23:	79 17                	jns    1e3c <subdir+0x18b>
    1e25:	83 ec 08             	sub    $0x8,%esp
    1e28:	68 a4 4a 00 00       	push   $0x4aa4
    1e2d:	6a 01                	push   $0x1
    1e2f:	e8 3d 1f 00 00       	call   3d71 <printf>
    1e34:	83 c4 10             	add    $0x10,%esp
    1e37:	e8 b0 1d 00 00       	call   3bec <exit>
    1e3c:	83 ec 04             	sub    $0x4,%esp
    1e3f:	68 00 20 00 00       	push   $0x2000
    1e44:	68 c0 86 00 00       	push   $0x86c0
    1e49:	ff 75 f4             	pushl  -0xc(%ebp)
    1e4c:	e8 b3 1d 00 00       	call   3c04 <read>
    1e51:	83 c4 10             	add    $0x10,%esp
    1e54:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e57:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    1e5b:	75 0b                	jne    1e68 <subdir+0x1b7>
    1e5d:	0f b6 05 c0 86 00 00 	movzbl 0x86c0,%eax
    1e64:	3c 66                	cmp    $0x66,%al
    1e66:	74 17                	je     1e7f <subdir+0x1ce>
    1e68:	83 ec 08             	sub    $0x8,%esp
    1e6b:	68 bd 4a 00 00       	push   $0x4abd
    1e70:	6a 01                	push   $0x1
    1e72:	e8 fa 1e 00 00       	call   3d71 <printf>
    1e77:	83 c4 10             	add    $0x10,%esp
    1e7a:	e8 6d 1d 00 00       	call   3bec <exit>
    1e7f:	83 ec 0c             	sub    $0xc,%esp
    1e82:	ff 75 f4             	pushl  -0xc(%ebp)
    1e85:	e8 8a 1d 00 00       	call   3c14 <close>
    1e8a:	83 c4 10             	add    $0x10,%esp
    1e8d:	83 ec 08             	sub    $0x8,%esp
    1e90:	68 d8 4a 00 00       	push   $0x4ad8
    1e95:	68 74 4a 00 00       	push   $0x4a74
    1e9a:	e8 ad 1d 00 00       	call   3c4c <link>
    1e9f:	83 c4 10             	add    $0x10,%esp
    1ea2:	85 c0                	test   %eax,%eax
    1ea4:	74 17                	je     1ebd <subdir+0x20c>
    1ea6:	83 ec 08             	sub    $0x8,%esp
    1ea9:	68 e4 4a 00 00       	push   $0x4ae4
    1eae:	6a 01                	push   $0x1
    1eb0:	e8 bc 1e 00 00       	call   3d71 <printf>
    1eb5:	83 c4 10             	add    $0x10,%esp
    1eb8:	e8 2f 1d 00 00       	call   3bec <exit>
    1ebd:	83 ec 0c             	sub    $0xc,%esp
    1ec0:	68 74 4a 00 00       	push   $0x4a74
    1ec5:	e8 72 1d 00 00       	call   3c3c <unlink>
    1eca:	83 c4 10             	add    $0x10,%esp
    1ecd:	85 c0                	test   %eax,%eax
    1ecf:	74 17                	je     1ee8 <subdir+0x237>
    1ed1:	83 ec 08             	sub    $0x8,%esp
    1ed4:	68 05 4b 00 00       	push   $0x4b05
    1ed9:	6a 01                	push   $0x1
    1edb:	e8 91 1e 00 00       	call   3d71 <printf>
    1ee0:	83 c4 10             	add    $0x10,%esp
    1ee3:	e8 04 1d 00 00       	call   3bec <exit>
    1ee8:	83 ec 08             	sub    $0x8,%esp
    1eeb:	6a 00                	push   $0x0
    1eed:	68 74 4a 00 00       	push   $0x4a74
    1ef2:	e8 35 1d 00 00       	call   3c2c <open>
    1ef7:	83 c4 10             	add    $0x10,%esp
    1efa:	85 c0                	test   %eax,%eax
    1efc:	78 17                	js     1f15 <subdir+0x264>
    1efe:	83 ec 08             	sub    $0x8,%esp
    1f01:	68 20 4b 00 00       	push   $0x4b20
    1f06:	6a 01                	push   $0x1
    1f08:	e8 64 1e 00 00       	call   3d71 <printf>
    1f0d:	83 c4 10             	add    $0x10,%esp
    1f10:	e8 d7 1c 00 00       	call   3bec <exit>
    1f15:	83 ec 0c             	sub    $0xc,%esp
    1f18:	68 f5 49 00 00       	push   $0x49f5
    1f1d:	e8 3a 1d 00 00       	call   3c5c <chdir>
    1f22:	83 c4 10             	add    $0x10,%esp
    1f25:	85 c0                	test   %eax,%eax
    1f27:	74 17                	je     1f40 <subdir+0x28f>
    1f29:	83 ec 08             	sub    $0x8,%esp
    1f2c:	68 44 4b 00 00       	push   $0x4b44
    1f31:	6a 01                	push   $0x1
    1f33:	e8 39 1e 00 00       	call   3d71 <printf>
    1f38:	83 c4 10             	add    $0x10,%esp
    1f3b:	e8 ac 1c 00 00       	call   3bec <exit>
    1f40:	83 ec 0c             	sub    $0xc,%esp
    1f43:	68 55 4b 00 00       	push   $0x4b55
    1f48:	e8 0f 1d 00 00       	call   3c5c <chdir>
    1f4d:	83 c4 10             	add    $0x10,%esp
    1f50:	85 c0                	test   %eax,%eax
    1f52:	74 17                	je     1f6b <subdir+0x2ba>
    1f54:	83 ec 08             	sub    $0x8,%esp
    1f57:	68 61 4b 00 00       	push   $0x4b61
    1f5c:	6a 01                	push   $0x1
    1f5e:	e8 0e 1e 00 00       	call   3d71 <printf>
    1f63:	83 c4 10             	add    $0x10,%esp
    1f66:	e8 81 1c 00 00       	call   3bec <exit>
    1f6b:	83 ec 0c             	sub    $0xc,%esp
    1f6e:	68 7b 4b 00 00       	push   $0x4b7b
    1f73:	e8 e4 1c 00 00       	call   3c5c <chdir>
    1f78:	83 c4 10             	add    $0x10,%esp
    1f7b:	85 c0                	test   %eax,%eax
    1f7d:	74 17                	je     1f96 <subdir+0x2e5>
    1f7f:	83 ec 08             	sub    $0x8,%esp
    1f82:	68 61 4b 00 00       	push   $0x4b61
    1f87:	6a 01                	push   $0x1
    1f89:	e8 e3 1d 00 00       	call   3d71 <printf>
    1f8e:	83 c4 10             	add    $0x10,%esp
    1f91:	e8 56 1c 00 00       	call   3bec <exit>
    1f96:	83 ec 0c             	sub    $0xc,%esp
    1f99:	68 8a 4b 00 00       	push   $0x4b8a
    1f9e:	e8 b9 1c 00 00       	call   3c5c <chdir>
    1fa3:	83 c4 10             	add    $0x10,%esp
    1fa6:	85 c0                	test   %eax,%eax
    1fa8:	74 17                	je     1fc1 <subdir+0x310>
    1faa:	83 ec 08             	sub    $0x8,%esp
    1fad:	68 8f 4b 00 00       	push   $0x4b8f
    1fb2:	6a 01                	push   $0x1
    1fb4:	e8 b8 1d 00 00       	call   3d71 <printf>
    1fb9:	83 c4 10             	add    $0x10,%esp
    1fbc:	e8 2b 1c 00 00       	call   3bec <exit>
    1fc1:	83 ec 08             	sub    $0x8,%esp
    1fc4:	6a 00                	push   $0x0
    1fc6:	68 d8 4a 00 00       	push   $0x4ad8
    1fcb:	e8 5c 1c 00 00       	call   3c2c <open>
    1fd0:	83 c4 10             	add    $0x10,%esp
    1fd3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1fd6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fda:	79 17                	jns    1ff3 <subdir+0x342>
    1fdc:	83 ec 08             	sub    $0x8,%esp
    1fdf:	68 a2 4b 00 00       	push   $0x4ba2
    1fe4:	6a 01                	push   $0x1
    1fe6:	e8 86 1d 00 00       	call   3d71 <printf>
    1feb:	83 c4 10             	add    $0x10,%esp
    1fee:	e8 f9 1b 00 00       	call   3bec <exit>
    1ff3:	83 ec 04             	sub    $0x4,%esp
    1ff6:	68 00 20 00 00       	push   $0x2000
    1ffb:	68 c0 86 00 00       	push   $0x86c0
    2000:	ff 75 f4             	pushl  -0xc(%ebp)
    2003:	e8 fc 1b 00 00       	call   3c04 <read>
    2008:	83 c4 10             	add    $0x10,%esp
    200b:	83 f8 02             	cmp    $0x2,%eax
    200e:	74 17                	je     2027 <subdir+0x376>
    2010:	83 ec 08             	sub    $0x8,%esp
    2013:	68 ba 4b 00 00       	push   $0x4bba
    2018:	6a 01                	push   $0x1
    201a:	e8 52 1d 00 00       	call   3d71 <printf>
    201f:	83 c4 10             	add    $0x10,%esp
    2022:	e8 c5 1b 00 00       	call   3bec <exit>
    2027:	83 ec 0c             	sub    $0xc,%esp
    202a:	ff 75 f4             	pushl  -0xc(%ebp)
    202d:	e8 e2 1b 00 00       	call   3c14 <close>
    2032:	83 c4 10             	add    $0x10,%esp
    2035:	83 ec 08             	sub    $0x8,%esp
    2038:	6a 00                	push   $0x0
    203a:	68 74 4a 00 00       	push   $0x4a74
    203f:	e8 e8 1b 00 00       	call   3c2c <open>
    2044:	83 c4 10             	add    $0x10,%esp
    2047:	85 c0                	test   %eax,%eax
    2049:	78 17                	js     2062 <subdir+0x3b1>
    204b:	83 ec 08             	sub    $0x8,%esp
    204e:	68 d8 4b 00 00       	push   $0x4bd8
    2053:	6a 01                	push   $0x1
    2055:	e8 17 1d 00 00       	call   3d71 <printf>
    205a:	83 c4 10             	add    $0x10,%esp
    205d:	e8 8a 1b 00 00       	call   3bec <exit>
    2062:	83 ec 08             	sub    $0x8,%esp
    2065:	68 02 02 00 00       	push   $0x202
    206a:	68 fd 4b 00 00       	push   $0x4bfd
    206f:	e8 b8 1b 00 00       	call   3c2c <open>
    2074:	83 c4 10             	add    $0x10,%esp
    2077:	85 c0                	test   %eax,%eax
    2079:	78 17                	js     2092 <subdir+0x3e1>
    207b:	83 ec 08             	sub    $0x8,%esp
    207e:	68 06 4c 00 00       	push   $0x4c06
    2083:	6a 01                	push   $0x1
    2085:	e8 e7 1c 00 00       	call   3d71 <printf>
    208a:	83 c4 10             	add    $0x10,%esp
    208d:	e8 5a 1b 00 00       	call   3bec <exit>
    2092:	83 ec 08             	sub    $0x8,%esp
    2095:	68 02 02 00 00       	push   $0x202
    209a:	68 22 4c 00 00       	push   $0x4c22
    209f:	e8 88 1b 00 00       	call   3c2c <open>
    20a4:	83 c4 10             	add    $0x10,%esp
    20a7:	85 c0                	test   %eax,%eax
    20a9:	78 17                	js     20c2 <subdir+0x411>
    20ab:	83 ec 08             	sub    $0x8,%esp
    20ae:	68 2b 4c 00 00       	push   $0x4c2b
    20b3:	6a 01                	push   $0x1
    20b5:	e8 b7 1c 00 00       	call   3d71 <printf>
    20ba:	83 c4 10             	add    $0x10,%esp
    20bd:	e8 2a 1b 00 00       	call   3bec <exit>
    20c2:	83 ec 08             	sub    $0x8,%esp
    20c5:	68 00 02 00 00       	push   $0x200
    20ca:	68 f5 49 00 00       	push   $0x49f5
    20cf:	e8 58 1b 00 00       	call   3c2c <open>
    20d4:	83 c4 10             	add    $0x10,%esp
    20d7:	85 c0                	test   %eax,%eax
    20d9:	78 17                	js     20f2 <subdir+0x441>
    20db:	83 ec 08             	sub    $0x8,%esp
    20de:	68 47 4c 00 00       	push   $0x4c47
    20e3:	6a 01                	push   $0x1
    20e5:	e8 87 1c 00 00       	call   3d71 <printf>
    20ea:	83 c4 10             	add    $0x10,%esp
    20ed:	e8 fa 1a 00 00       	call   3bec <exit>
    20f2:	83 ec 08             	sub    $0x8,%esp
    20f5:	6a 02                	push   $0x2
    20f7:	68 f5 49 00 00       	push   $0x49f5
    20fc:	e8 2b 1b 00 00       	call   3c2c <open>
    2101:	83 c4 10             	add    $0x10,%esp
    2104:	85 c0                	test   %eax,%eax
    2106:	78 17                	js     211f <subdir+0x46e>
    2108:	83 ec 08             	sub    $0x8,%esp
    210b:	68 5d 4c 00 00       	push   $0x4c5d
    2110:	6a 01                	push   $0x1
    2112:	e8 5a 1c 00 00       	call   3d71 <printf>
    2117:	83 c4 10             	add    $0x10,%esp
    211a:	e8 cd 1a 00 00       	call   3bec <exit>
    211f:	83 ec 08             	sub    $0x8,%esp
    2122:	6a 01                	push   $0x1
    2124:	68 f5 49 00 00       	push   $0x49f5
    2129:	e8 fe 1a 00 00       	call   3c2c <open>
    212e:	83 c4 10             	add    $0x10,%esp
    2131:	85 c0                	test   %eax,%eax
    2133:	78 17                	js     214c <subdir+0x49b>
    2135:	83 ec 08             	sub    $0x8,%esp
    2138:	68 76 4c 00 00       	push   $0x4c76
    213d:	6a 01                	push   $0x1
    213f:	e8 2d 1c 00 00       	call   3d71 <printf>
    2144:	83 c4 10             	add    $0x10,%esp
    2147:	e8 a0 1a 00 00       	call   3bec <exit>
    214c:	83 ec 08             	sub    $0x8,%esp
    214f:	68 91 4c 00 00       	push   $0x4c91
    2154:	68 fd 4b 00 00       	push   $0x4bfd
    2159:	e8 ee 1a 00 00       	call   3c4c <link>
    215e:	83 c4 10             	add    $0x10,%esp
    2161:	85 c0                	test   %eax,%eax
    2163:	75 17                	jne    217c <subdir+0x4cb>
    2165:	83 ec 08             	sub    $0x8,%esp
    2168:	68 9c 4c 00 00       	push   $0x4c9c
    216d:	6a 01                	push   $0x1
    216f:	e8 fd 1b 00 00       	call   3d71 <printf>
    2174:	83 c4 10             	add    $0x10,%esp
    2177:	e8 70 1a 00 00       	call   3bec <exit>
    217c:	83 ec 08             	sub    $0x8,%esp
    217f:	68 91 4c 00 00       	push   $0x4c91
    2184:	68 22 4c 00 00       	push   $0x4c22
    2189:	e8 be 1a 00 00       	call   3c4c <link>
    218e:	83 c4 10             	add    $0x10,%esp
    2191:	85 c0                	test   %eax,%eax
    2193:	75 17                	jne    21ac <subdir+0x4fb>
    2195:	83 ec 08             	sub    $0x8,%esp
    2198:	68 c0 4c 00 00       	push   $0x4cc0
    219d:	6a 01                	push   $0x1
    219f:	e8 cd 1b 00 00       	call   3d71 <printf>
    21a4:	83 c4 10             	add    $0x10,%esp
    21a7:	e8 40 1a 00 00       	call   3bec <exit>
    21ac:	83 ec 08             	sub    $0x8,%esp
    21af:	68 d8 4a 00 00       	push   $0x4ad8
    21b4:	68 10 4a 00 00       	push   $0x4a10
    21b9:	e8 8e 1a 00 00       	call   3c4c <link>
    21be:	83 c4 10             	add    $0x10,%esp
    21c1:	85 c0                	test   %eax,%eax
    21c3:	75 17                	jne    21dc <subdir+0x52b>
    21c5:	83 ec 08             	sub    $0x8,%esp
    21c8:	68 e4 4c 00 00       	push   $0x4ce4
    21cd:	6a 01                	push   $0x1
    21cf:	e8 9d 1b 00 00       	call   3d71 <printf>
    21d4:	83 c4 10             	add    $0x10,%esp
    21d7:	e8 10 1a 00 00       	call   3bec <exit>
    21dc:	83 ec 0c             	sub    $0xc,%esp
    21df:	68 fd 4b 00 00       	push   $0x4bfd
    21e4:	e8 6b 1a 00 00       	call   3c54 <mkdir>
    21e9:	83 c4 10             	add    $0x10,%esp
    21ec:	85 c0                	test   %eax,%eax
    21ee:	75 17                	jne    2207 <subdir+0x556>
    21f0:	83 ec 08             	sub    $0x8,%esp
    21f3:	68 06 4d 00 00       	push   $0x4d06
    21f8:	6a 01                	push   $0x1
    21fa:	e8 72 1b 00 00       	call   3d71 <printf>
    21ff:	83 c4 10             	add    $0x10,%esp
    2202:	e8 e5 19 00 00       	call   3bec <exit>
    2207:	83 ec 0c             	sub    $0xc,%esp
    220a:	68 22 4c 00 00       	push   $0x4c22
    220f:	e8 40 1a 00 00       	call   3c54 <mkdir>
    2214:	83 c4 10             	add    $0x10,%esp
    2217:	85 c0                	test   %eax,%eax
    2219:	75 17                	jne    2232 <subdir+0x581>
    221b:	83 ec 08             	sub    $0x8,%esp
    221e:	68 21 4d 00 00       	push   $0x4d21
    2223:	6a 01                	push   $0x1
    2225:	e8 47 1b 00 00       	call   3d71 <printf>
    222a:	83 c4 10             	add    $0x10,%esp
    222d:	e8 ba 19 00 00       	call   3bec <exit>
    2232:	83 ec 0c             	sub    $0xc,%esp
    2235:	68 d8 4a 00 00       	push   $0x4ad8
    223a:	e8 15 1a 00 00       	call   3c54 <mkdir>
    223f:	83 c4 10             	add    $0x10,%esp
    2242:	85 c0                	test   %eax,%eax
    2244:	75 17                	jne    225d <subdir+0x5ac>
    2246:	83 ec 08             	sub    $0x8,%esp
    2249:	68 3c 4d 00 00       	push   $0x4d3c
    224e:	6a 01                	push   $0x1
    2250:	e8 1c 1b 00 00       	call   3d71 <printf>
    2255:	83 c4 10             	add    $0x10,%esp
    2258:	e8 8f 19 00 00       	call   3bec <exit>
    225d:	83 ec 0c             	sub    $0xc,%esp
    2260:	68 22 4c 00 00       	push   $0x4c22
    2265:	e8 d2 19 00 00       	call   3c3c <unlink>
    226a:	83 c4 10             	add    $0x10,%esp
    226d:	85 c0                	test   %eax,%eax
    226f:	75 17                	jne    2288 <subdir+0x5d7>
    2271:	83 ec 08             	sub    $0x8,%esp
    2274:	68 59 4d 00 00       	push   $0x4d59
    2279:	6a 01                	push   $0x1
    227b:	e8 f1 1a 00 00       	call   3d71 <printf>
    2280:	83 c4 10             	add    $0x10,%esp
    2283:	e8 64 19 00 00       	call   3bec <exit>
    2288:	83 ec 0c             	sub    $0xc,%esp
    228b:	68 fd 4b 00 00       	push   $0x4bfd
    2290:	e8 a7 19 00 00       	call   3c3c <unlink>
    2295:	83 c4 10             	add    $0x10,%esp
    2298:	85 c0                	test   %eax,%eax
    229a:	75 17                	jne    22b3 <subdir+0x602>
    229c:	83 ec 08             	sub    $0x8,%esp
    229f:	68 75 4d 00 00       	push   $0x4d75
    22a4:	6a 01                	push   $0x1
    22a6:	e8 c6 1a 00 00       	call   3d71 <printf>
    22ab:	83 c4 10             	add    $0x10,%esp
    22ae:	e8 39 19 00 00       	call   3bec <exit>
    22b3:	83 ec 0c             	sub    $0xc,%esp
    22b6:	68 10 4a 00 00       	push   $0x4a10
    22bb:	e8 9c 19 00 00       	call   3c5c <chdir>
    22c0:	83 c4 10             	add    $0x10,%esp
    22c3:	85 c0                	test   %eax,%eax
    22c5:	75 17                	jne    22de <subdir+0x62d>
    22c7:	83 ec 08             	sub    $0x8,%esp
    22ca:	68 91 4d 00 00       	push   $0x4d91
    22cf:	6a 01                	push   $0x1
    22d1:	e8 9b 1a 00 00       	call   3d71 <printf>
    22d6:	83 c4 10             	add    $0x10,%esp
    22d9:	e8 0e 19 00 00       	call   3bec <exit>
    22de:	83 ec 0c             	sub    $0xc,%esp
    22e1:	68 a9 4d 00 00       	push   $0x4da9
    22e6:	e8 71 19 00 00       	call   3c5c <chdir>
    22eb:	83 c4 10             	add    $0x10,%esp
    22ee:	85 c0                	test   %eax,%eax
    22f0:	75 17                	jne    2309 <subdir+0x658>
    22f2:	83 ec 08             	sub    $0x8,%esp
    22f5:	68 af 4d 00 00       	push   $0x4daf
    22fa:	6a 01                	push   $0x1
    22fc:	e8 70 1a 00 00       	call   3d71 <printf>
    2301:	83 c4 10             	add    $0x10,%esp
    2304:	e8 e3 18 00 00       	call   3bec <exit>
    2309:	83 ec 0c             	sub    $0xc,%esp
    230c:	68 d8 4a 00 00       	push   $0x4ad8
    2311:	e8 26 19 00 00       	call   3c3c <unlink>
    2316:	83 c4 10             	add    $0x10,%esp
    2319:	85 c0                	test   %eax,%eax
    231b:	74 17                	je     2334 <subdir+0x683>
    231d:	83 ec 08             	sub    $0x8,%esp
    2320:	68 05 4b 00 00       	push   $0x4b05
    2325:	6a 01                	push   $0x1
    2327:	e8 45 1a 00 00       	call   3d71 <printf>
    232c:	83 c4 10             	add    $0x10,%esp
    232f:	e8 b8 18 00 00       	call   3bec <exit>
    2334:	83 ec 0c             	sub    $0xc,%esp
    2337:	68 10 4a 00 00       	push   $0x4a10
    233c:	e8 fb 18 00 00       	call   3c3c <unlink>
    2341:	83 c4 10             	add    $0x10,%esp
    2344:	85 c0                	test   %eax,%eax
    2346:	74 17                	je     235f <subdir+0x6ae>
    2348:	83 ec 08             	sub    $0x8,%esp
    234b:	68 c7 4d 00 00       	push   $0x4dc7
    2350:	6a 01                	push   $0x1
    2352:	e8 1a 1a 00 00       	call   3d71 <printf>
    2357:	83 c4 10             	add    $0x10,%esp
    235a:	e8 8d 18 00 00       	call   3bec <exit>
    235f:	83 ec 0c             	sub    $0xc,%esp
    2362:	68 f5 49 00 00       	push   $0x49f5
    2367:	e8 d0 18 00 00       	call   3c3c <unlink>
    236c:	83 c4 10             	add    $0x10,%esp
    236f:	85 c0                	test   %eax,%eax
    2371:	75 17                	jne    238a <subdir+0x6d9>
    2373:	83 ec 08             	sub    $0x8,%esp
    2376:	68 dc 4d 00 00       	push   $0x4ddc
    237b:	6a 01                	push   $0x1
    237d:	e8 ef 19 00 00       	call   3d71 <printf>
    2382:	83 c4 10             	add    $0x10,%esp
    2385:	e8 62 18 00 00       	call   3bec <exit>
    238a:	83 ec 0c             	sub    $0xc,%esp
    238d:	68 fc 4d 00 00       	push   $0x4dfc
    2392:	e8 a5 18 00 00       	call   3c3c <unlink>
    2397:	83 c4 10             	add    $0x10,%esp
    239a:	85 c0                	test   %eax,%eax
    239c:	79 17                	jns    23b5 <subdir+0x704>
    239e:	83 ec 08             	sub    $0x8,%esp
    23a1:	68 02 4e 00 00       	push   $0x4e02
    23a6:	6a 01                	push   $0x1
    23a8:	e8 c4 19 00 00       	call   3d71 <printf>
    23ad:	83 c4 10             	add    $0x10,%esp
    23b0:	e8 37 18 00 00       	call   3bec <exit>
    23b5:	83 ec 0c             	sub    $0xc,%esp
    23b8:	68 f5 49 00 00       	push   $0x49f5
    23bd:	e8 7a 18 00 00       	call   3c3c <unlink>
    23c2:	83 c4 10             	add    $0x10,%esp
    23c5:	85 c0                	test   %eax,%eax
    23c7:	79 17                	jns    23e0 <subdir+0x72f>
    23c9:	83 ec 08             	sub    $0x8,%esp
    23cc:	68 17 4e 00 00       	push   $0x4e17
    23d1:	6a 01                	push   $0x1
    23d3:	e8 99 19 00 00       	call   3d71 <printf>
    23d8:	83 c4 10             	add    $0x10,%esp
    23db:	e8 0c 18 00 00       	call   3bec <exit>
    23e0:	83 ec 08             	sub    $0x8,%esp
    23e3:	68 29 4e 00 00       	push   $0x4e29
    23e8:	6a 01                	push   $0x1
    23ea:	e8 82 19 00 00       	call   3d71 <printf>
    23ef:	83 c4 10             	add    $0x10,%esp
    23f2:	c9                   	leave  
    23f3:	c3                   	ret    

000023f4 <bigwrite>:
    23f4:	55                   	push   %ebp
    23f5:	89 e5                	mov    %esp,%ebp
    23f7:	83 ec 18             	sub    $0x18,%esp
    23fa:	83 ec 08             	sub    $0x8,%esp
    23fd:	68 34 4e 00 00       	push   $0x4e34
    2402:	6a 01                	push   $0x1
    2404:	e8 68 19 00 00       	call   3d71 <printf>
    2409:	83 c4 10             	add    $0x10,%esp
    240c:	83 ec 0c             	sub    $0xc,%esp
    240f:	68 43 4e 00 00       	push   $0x4e43
    2414:	e8 23 18 00 00       	call   3c3c <unlink>
    2419:	83 c4 10             	add    $0x10,%esp
    241c:	c7 45 f4 f3 01 00 00 	movl   $0x1f3,-0xc(%ebp)
    2423:	e9 a8 00 00 00       	jmp    24d0 <bigwrite+0xdc>
    2428:	83 ec 08             	sub    $0x8,%esp
    242b:	68 02 02 00 00       	push   $0x202
    2430:	68 43 4e 00 00       	push   $0x4e43
    2435:	e8 f2 17 00 00       	call   3c2c <open>
    243a:	83 c4 10             	add    $0x10,%esp
    243d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2440:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2444:	79 17                	jns    245d <bigwrite+0x69>
    2446:	83 ec 08             	sub    $0x8,%esp
    2449:	68 4c 4e 00 00       	push   $0x4e4c
    244e:	6a 01                	push   $0x1
    2450:	e8 1c 19 00 00       	call   3d71 <printf>
    2455:	83 c4 10             	add    $0x10,%esp
    2458:	e8 8f 17 00 00       	call   3bec <exit>
    245d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2464:	eb 3f                	jmp    24a5 <bigwrite+0xb1>
    2466:	83 ec 04             	sub    $0x4,%esp
    2469:	ff 75 f4             	pushl  -0xc(%ebp)
    246c:	68 c0 86 00 00       	push   $0x86c0
    2471:	ff 75 ec             	pushl  -0x14(%ebp)
    2474:	e8 93 17 00 00       	call   3c0c <write>
    2479:	83 c4 10             	add    $0x10,%esp
    247c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    247f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2482:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2485:	74 1a                	je     24a1 <bigwrite+0xad>
    2487:	ff 75 e8             	pushl  -0x18(%ebp)
    248a:	ff 75 f4             	pushl  -0xc(%ebp)
    248d:	68 64 4e 00 00       	push   $0x4e64
    2492:	6a 01                	push   $0x1
    2494:	e8 d8 18 00 00       	call   3d71 <printf>
    2499:	83 c4 10             	add    $0x10,%esp
    249c:	e8 4b 17 00 00       	call   3bec <exit>
    24a1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    24a5:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    24a9:	7e bb                	jle    2466 <bigwrite+0x72>
    24ab:	83 ec 0c             	sub    $0xc,%esp
    24ae:	ff 75 ec             	pushl  -0x14(%ebp)
    24b1:	e8 5e 17 00 00       	call   3c14 <close>
    24b6:	83 c4 10             	add    $0x10,%esp
    24b9:	83 ec 0c             	sub    $0xc,%esp
    24bc:	68 43 4e 00 00       	push   $0x4e43
    24c1:	e8 76 17 00 00       	call   3c3c <unlink>
    24c6:	83 c4 10             	add    $0x10,%esp
    24c9:	81 45 f4 d7 01 00 00 	addl   $0x1d7,-0xc(%ebp)
    24d0:	81 7d f4 ff 17 00 00 	cmpl   $0x17ff,-0xc(%ebp)
    24d7:	0f 8e 4b ff ff ff    	jle    2428 <bigwrite+0x34>
    24dd:	83 ec 08             	sub    $0x8,%esp
    24e0:	68 76 4e 00 00       	push   $0x4e76
    24e5:	6a 01                	push   $0x1
    24e7:	e8 85 18 00 00       	call   3d71 <printf>
    24ec:	83 c4 10             	add    $0x10,%esp
    24ef:	c9                   	leave  
    24f0:	c3                   	ret    

000024f1 <bigfile>:
    24f1:	55                   	push   %ebp
    24f2:	89 e5                	mov    %esp,%ebp
    24f4:	83 ec 18             	sub    $0x18,%esp
    24f7:	83 ec 08             	sub    $0x8,%esp
    24fa:	68 83 4e 00 00       	push   $0x4e83
    24ff:	6a 01                	push   $0x1
    2501:	e8 6b 18 00 00       	call   3d71 <printf>
    2506:	83 c4 10             	add    $0x10,%esp
    2509:	83 ec 0c             	sub    $0xc,%esp
    250c:	68 91 4e 00 00       	push   $0x4e91
    2511:	e8 26 17 00 00       	call   3c3c <unlink>
    2516:	83 c4 10             	add    $0x10,%esp
    2519:	83 ec 08             	sub    $0x8,%esp
    251c:	68 02 02 00 00       	push   $0x202
    2521:	68 91 4e 00 00       	push   $0x4e91
    2526:	e8 01 17 00 00       	call   3c2c <open>
    252b:	83 c4 10             	add    $0x10,%esp
    252e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2531:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2535:	79 17                	jns    254e <bigfile+0x5d>
    2537:	83 ec 08             	sub    $0x8,%esp
    253a:	68 99 4e 00 00       	push   $0x4e99
    253f:	6a 01                	push   $0x1
    2541:	e8 2b 18 00 00       	call   3d71 <printf>
    2546:	83 c4 10             	add    $0x10,%esp
    2549:	e8 9e 16 00 00       	call   3bec <exit>
    254e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2555:	eb 52                	jmp    25a9 <bigfile+0xb8>
    2557:	83 ec 04             	sub    $0x4,%esp
    255a:	68 58 02 00 00       	push   $0x258
    255f:	ff 75 f4             	pushl  -0xc(%ebp)
    2562:	68 c0 86 00 00       	push   $0x86c0
    2567:	e8 e6 14 00 00       	call   3a52 <memset>
    256c:	83 c4 10             	add    $0x10,%esp
    256f:	83 ec 04             	sub    $0x4,%esp
    2572:	68 58 02 00 00       	push   $0x258
    2577:	68 c0 86 00 00       	push   $0x86c0
    257c:	ff 75 ec             	pushl  -0x14(%ebp)
    257f:	e8 88 16 00 00       	call   3c0c <write>
    2584:	83 c4 10             	add    $0x10,%esp
    2587:	3d 58 02 00 00       	cmp    $0x258,%eax
    258c:	74 17                	je     25a5 <bigfile+0xb4>
    258e:	83 ec 08             	sub    $0x8,%esp
    2591:	68 af 4e 00 00       	push   $0x4eaf
    2596:	6a 01                	push   $0x1
    2598:	e8 d4 17 00 00       	call   3d71 <printf>
    259d:	83 c4 10             	add    $0x10,%esp
    25a0:	e8 47 16 00 00       	call   3bec <exit>
    25a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    25a9:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    25ad:	7e a8                	jle    2557 <bigfile+0x66>
    25af:	83 ec 0c             	sub    $0xc,%esp
    25b2:	ff 75 ec             	pushl  -0x14(%ebp)
    25b5:	e8 5a 16 00 00       	call   3c14 <close>
    25ba:	83 c4 10             	add    $0x10,%esp
    25bd:	83 ec 08             	sub    $0x8,%esp
    25c0:	6a 00                	push   $0x0
    25c2:	68 91 4e 00 00       	push   $0x4e91
    25c7:	e8 60 16 00 00       	call   3c2c <open>
    25cc:	83 c4 10             	add    $0x10,%esp
    25cf:	89 45 ec             	mov    %eax,-0x14(%ebp)
    25d2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    25d6:	79 17                	jns    25ef <bigfile+0xfe>
    25d8:	83 ec 08             	sub    $0x8,%esp
    25db:	68 c5 4e 00 00       	push   $0x4ec5
    25e0:	6a 01                	push   $0x1
    25e2:	e8 8a 17 00 00       	call   3d71 <printf>
    25e7:	83 c4 10             	add    $0x10,%esp
    25ea:	e8 fd 15 00 00       	call   3bec <exit>
    25ef:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    25f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    25fd:	83 ec 04             	sub    $0x4,%esp
    2600:	68 2c 01 00 00       	push   $0x12c
    2605:	68 c0 86 00 00       	push   $0x86c0
    260a:	ff 75 ec             	pushl  -0x14(%ebp)
    260d:	e8 f2 15 00 00       	call   3c04 <read>
    2612:	83 c4 10             	add    $0x10,%esp
    2615:	89 45 e8             	mov    %eax,-0x18(%ebp)
    2618:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    261c:	79 17                	jns    2635 <bigfile+0x144>
    261e:	83 ec 08             	sub    $0x8,%esp
    2621:	68 da 4e 00 00       	push   $0x4eda
    2626:	6a 01                	push   $0x1
    2628:	e8 44 17 00 00       	call   3d71 <printf>
    262d:	83 c4 10             	add    $0x10,%esp
    2630:	e8 b7 15 00 00       	call   3bec <exit>
    2635:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2639:	75 1e                	jne    2659 <bigfile+0x168>
    263b:	90                   	nop
    263c:	83 ec 0c             	sub    $0xc,%esp
    263f:	ff 75 ec             	pushl  -0x14(%ebp)
    2642:	e8 cd 15 00 00       	call   3c14 <close>
    2647:	83 c4 10             	add    $0x10,%esp
    264a:	81 7d f0 e0 2e 00 00 	cmpl   $0x2ee0,-0x10(%ebp)
    2651:	0f 84 93 00 00 00    	je     26ea <bigfile+0x1f9>
    2657:	eb 7a                	jmp    26d3 <bigfile+0x1e2>
    2659:	81 7d e8 2c 01 00 00 	cmpl   $0x12c,-0x18(%ebp)
    2660:	74 17                	je     2679 <bigfile+0x188>
    2662:	83 ec 08             	sub    $0x8,%esp
    2665:	68 ef 4e 00 00       	push   $0x4eef
    266a:	6a 01                	push   $0x1
    266c:	e8 00 17 00 00       	call   3d71 <printf>
    2671:	83 c4 10             	add    $0x10,%esp
    2674:	e8 73 15 00 00       	call   3bec <exit>
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
    26ad:	83 ec 08             	sub    $0x8,%esp
    26b0:	68 03 4f 00 00       	push   $0x4f03
    26b5:	6a 01                	push   $0x1
    26b7:	e8 b5 16 00 00       	call   3d71 <printf>
    26bc:	83 c4 10             	add    $0x10,%esp
    26bf:	e8 28 15 00 00       	call   3bec <exit>
    26c4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    26c7:	01 45 f0             	add    %eax,-0x10(%ebp)
    26ca:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    26ce:	e9 2a ff ff ff       	jmp    25fd <bigfile+0x10c>
    26d3:	83 ec 08             	sub    $0x8,%esp
    26d6:	68 1c 4f 00 00       	push   $0x4f1c
    26db:	6a 01                	push   $0x1
    26dd:	e8 8f 16 00 00       	call   3d71 <printf>
    26e2:	83 c4 10             	add    $0x10,%esp
    26e5:	e8 02 15 00 00       	call   3bec <exit>
    26ea:	83 ec 0c             	sub    $0xc,%esp
    26ed:	68 91 4e 00 00       	push   $0x4e91
    26f2:	e8 45 15 00 00       	call   3c3c <unlink>
    26f7:	83 c4 10             	add    $0x10,%esp
    26fa:	83 ec 08             	sub    $0x8,%esp
    26fd:	68 36 4f 00 00       	push   $0x4f36
    2702:	6a 01                	push   $0x1
    2704:	e8 68 16 00 00       	call   3d71 <printf>
    2709:	83 c4 10             	add    $0x10,%esp
    270c:	c9                   	leave  
    270d:	c3                   	ret    

0000270e <fourteen>:
    270e:	55                   	push   %ebp
    270f:	89 e5                	mov    %esp,%ebp
    2711:	83 ec 18             	sub    $0x18,%esp
    2714:	83 ec 08             	sub    $0x8,%esp
    2717:	68 47 4f 00 00       	push   $0x4f47
    271c:	6a 01                	push   $0x1
    271e:	e8 4e 16 00 00       	call   3d71 <printf>
    2723:	83 c4 10             	add    $0x10,%esp
    2726:	83 ec 0c             	sub    $0xc,%esp
    2729:	68 56 4f 00 00       	push   $0x4f56
    272e:	e8 21 15 00 00       	call   3c54 <mkdir>
    2733:	83 c4 10             	add    $0x10,%esp
    2736:	85 c0                	test   %eax,%eax
    2738:	74 17                	je     2751 <fourteen+0x43>
    273a:	83 ec 08             	sub    $0x8,%esp
    273d:	68 65 4f 00 00       	push   $0x4f65
    2742:	6a 01                	push   $0x1
    2744:	e8 28 16 00 00       	call   3d71 <printf>
    2749:	83 c4 10             	add    $0x10,%esp
    274c:	e8 9b 14 00 00       	call   3bec <exit>
    2751:	83 ec 0c             	sub    $0xc,%esp
    2754:	68 84 4f 00 00       	push   $0x4f84
    2759:	e8 f6 14 00 00       	call   3c54 <mkdir>
    275e:	83 c4 10             	add    $0x10,%esp
    2761:	85 c0                	test   %eax,%eax
    2763:	74 17                	je     277c <fourteen+0x6e>
    2765:	83 ec 08             	sub    $0x8,%esp
    2768:	68 a4 4f 00 00       	push   $0x4fa4
    276d:	6a 01                	push   $0x1
    276f:	e8 fd 15 00 00       	call   3d71 <printf>
    2774:	83 c4 10             	add    $0x10,%esp
    2777:	e8 70 14 00 00       	call   3bec <exit>
    277c:	83 ec 08             	sub    $0x8,%esp
    277f:	68 00 02 00 00       	push   $0x200
    2784:	68 d4 4f 00 00       	push   $0x4fd4
    2789:	e8 9e 14 00 00       	call   3c2c <open>
    278e:	83 c4 10             	add    $0x10,%esp
    2791:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2794:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2798:	79 17                	jns    27b1 <fourteen+0xa3>
    279a:	83 ec 08             	sub    $0x8,%esp
    279d:	68 04 50 00 00       	push   $0x5004
    27a2:	6a 01                	push   $0x1
    27a4:	e8 c8 15 00 00       	call   3d71 <printf>
    27a9:	83 c4 10             	add    $0x10,%esp
    27ac:	e8 3b 14 00 00       	call   3bec <exit>
    27b1:	83 ec 0c             	sub    $0xc,%esp
    27b4:	ff 75 f4             	pushl  -0xc(%ebp)
    27b7:	e8 58 14 00 00       	call   3c14 <close>
    27bc:	83 c4 10             	add    $0x10,%esp
    27bf:	83 ec 08             	sub    $0x8,%esp
    27c2:	6a 00                	push   $0x0
    27c4:	68 44 50 00 00       	push   $0x5044
    27c9:	e8 5e 14 00 00       	call   3c2c <open>
    27ce:	83 c4 10             	add    $0x10,%esp
    27d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    27d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    27d8:	79 17                	jns    27f1 <fourteen+0xe3>
    27da:	83 ec 08             	sub    $0x8,%esp
    27dd:	68 74 50 00 00       	push   $0x5074
    27e2:	6a 01                	push   $0x1
    27e4:	e8 88 15 00 00       	call   3d71 <printf>
    27e9:	83 c4 10             	add    $0x10,%esp
    27ec:	e8 fb 13 00 00       	call   3bec <exit>
    27f1:	83 ec 0c             	sub    $0xc,%esp
    27f4:	ff 75 f4             	pushl  -0xc(%ebp)
    27f7:	e8 18 14 00 00       	call   3c14 <close>
    27fc:	83 c4 10             	add    $0x10,%esp
    27ff:	83 ec 0c             	sub    $0xc,%esp
    2802:	68 ae 50 00 00       	push   $0x50ae
    2807:	e8 48 14 00 00       	call   3c54 <mkdir>
    280c:	83 c4 10             	add    $0x10,%esp
    280f:	85 c0                	test   %eax,%eax
    2811:	75 17                	jne    282a <fourteen+0x11c>
    2813:	83 ec 08             	sub    $0x8,%esp
    2816:	68 cc 50 00 00       	push   $0x50cc
    281b:	6a 01                	push   $0x1
    281d:	e8 4f 15 00 00       	call   3d71 <printf>
    2822:	83 c4 10             	add    $0x10,%esp
    2825:	e8 c2 13 00 00       	call   3bec <exit>
    282a:	83 ec 0c             	sub    $0xc,%esp
    282d:	68 fc 50 00 00       	push   $0x50fc
    2832:	e8 1d 14 00 00       	call   3c54 <mkdir>
    2837:	83 c4 10             	add    $0x10,%esp
    283a:	85 c0                	test   %eax,%eax
    283c:	75 17                	jne    2855 <fourteen+0x147>
    283e:	83 ec 08             	sub    $0x8,%esp
    2841:	68 1c 51 00 00       	push   $0x511c
    2846:	6a 01                	push   $0x1
    2848:	e8 24 15 00 00       	call   3d71 <printf>
    284d:	83 c4 10             	add    $0x10,%esp
    2850:	e8 97 13 00 00       	call   3bec <exit>
    2855:	83 ec 08             	sub    $0x8,%esp
    2858:	68 4d 51 00 00       	push   $0x514d
    285d:	6a 01                	push   $0x1
    285f:	e8 0d 15 00 00       	call   3d71 <printf>
    2864:	83 c4 10             	add    $0x10,%esp
    2867:	c9                   	leave  
    2868:	c3                   	ret    

00002869 <rmdot>:
    2869:	55                   	push   %ebp
    286a:	89 e5                	mov    %esp,%ebp
    286c:	83 ec 08             	sub    $0x8,%esp
    286f:	83 ec 08             	sub    $0x8,%esp
    2872:	68 5a 51 00 00       	push   $0x515a
    2877:	6a 01                	push   $0x1
    2879:	e8 f3 14 00 00       	call   3d71 <printf>
    287e:	83 c4 10             	add    $0x10,%esp
    2881:	83 ec 0c             	sub    $0xc,%esp
    2884:	68 66 51 00 00       	push   $0x5166
    2889:	e8 c6 13 00 00       	call   3c54 <mkdir>
    288e:	83 c4 10             	add    $0x10,%esp
    2891:	85 c0                	test   %eax,%eax
    2893:	74 17                	je     28ac <rmdot+0x43>
    2895:	83 ec 08             	sub    $0x8,%esp
    2898:	68 6b 51 00 00       	push   $0x516b
    289d:	6a 01                	push   $0x1
    289f:	e8 cd 14 00 00       	call   3d71 <printf>
    28a4:	83 c4 10             	add    $0x10,%esp
    28a7:	e8 40 13 00 00       	call   3bec <exit>
    28ac:	83 ec 0c             	sub    $0xc,%esp
    28af:	68 66 51 00 00       	push   $0x5166
    28b4:	e8 a3 13 00 00       	call   3c5c <chdir>
    28b9:	83 c4 10             	add    $0x10,%esp
    28bc:	85 c0                	test   %eax,%eax
    28be:	74 17                	je     28d7 <rmdot+0x6e>
    28c0:	83 ec 08             	sub    $0x8,%esp
    28c3:	68 7e 51 00 00       	push   $0x517e
    28c8:	6a 01                	push   $0x1
    28ca:	e8 a2 14 00 00       	call   3d71 <printf>
    28cf:	83 c4 10             	add    $0x10,%esp
    28d2:	e8 15 13 00 00       	call   3bec <exit>
    28d7:	83 ec 0c             	sub    $0xc,%esp
    28da:	68 97 48 00 00       	push   $0x4897
    28df:	e8 58 13 00 00       	call   3c3c <unlink>
    28e4:	83 c4 10             	add    $0x10,%esp
    28e7:	85 c0                	test   %eax,%eax
    28e9:	75 17                	jne    2902 <rmdot+0x99>
    28eb:	83 ec 08             	sub    $0x8,%esp
    28ee:	68 91 51 00 00       	push   $0x5191
    28f3:	6a 01                	push   $0x1
    28f5:	e8 77 14 00 00       	call   3d71 <printf>
    28fa:	83 c4 10             	add    $0x10,%esp
    28fd:	e8 ea 12 00 00       	call   3bec <exit>
    2902:	83 ec 0c             	sub    $0xc,%esp
    2905:	68 24 44 00 00       	push   $0x4424
    290a:	e8 2d 13 00 00       	call   3c3c <unlink>
    290f:	83 c4 10             	add    $0x10,%esp
    2912:	85 c0                	test   %eax,%eax
    2914:	75 17                	jne    292d <rmdot+0xc4>
    2916:	83 ec 08             	sub    $0x8,%esp
    2919:	68 9f 51 00 00       	push   $0x519f
    291e:	6a 01                	push   $0x1
    2920:	e8 4c 14 00 00       	call   3d71 <printf>
    2925:	83 c4 10             	add    $0x10,%esp
    2928:	e8 bf 12 00 00       	call   3bec <exit>
    292d:	83 ec 0c             	sub    $0xc,%esp
    2930:	68 ae 51 00 00       	push   $0x51ae
    2935:	e8 22 13 00 00       	call   3c5c <chdir>
    293a:	83 c4 10             	add    $0x10,%esp
    293d:	85 c0                	test   %eax,%eax
    293f:	74 17                	je     2958 <rmdot+0xef>
    2941:	83 ec 08             	sub    $0x8,%esp
    2944:	68 b0 51 00 00       	push   $0x51b0
    2949:	6a 01                	push   $0x1
    294b:	e8 21 14 00 00       	call   3d71 <printf>
    2950:	83 c4 10             	add    $0x10,%esp
    2953:	e8 94 12 00 00       	call   3bec <exit>
    2958:	83 ec 0c             	sub    $0xc,%esp
    295b:	68 c0 51 00 00       	push   $0x51c0
    2960:	e8 d7 12 00 00       	call   3c3c <unlink>
    2965:	83 c4 10             	add    $0x10,%esp
    2968:	85 c0                	test   %eax,%eax
    296a:	75 17                	jne    2983 <rmdot+0x11a>
    296c:	83 ec 08             	sub    $0x8,%esp
    296f:	68 c7 51 00 00       	push   $0x51c7
    2974:	6a 01                	push   $0x1
    2976:	e8 f6 13 00 00       	call   3d71 <printf>
    297b:	83 c4 10             	add    $0x10,%esp
    297e:	e8 69 12 00 00       	call   3bec <exit>
    2983:	83 ec 0c             	sub    $0xc,%esp
    2986:	68 de 51 00 00       	push   $0x51de
    298b:	e8 ac 12 00 00       	call   3c3c <unlink>
    2990:	83 c4 10             	add    $0x10,%esp
    2993:	85 c0                	test   %eax,%eax
    2995:	75 17                	jne    29ae <rmdot+0x145>
    2997:	83 ec 08             	sub    $0x8,%esp
    299a:	68 e6 51 00 00       	push   $0x51e6
    299f:	6a 01                	push   $0x1
    29a1:	e8 cb 13 00 00       	call   3d71 <printf>
    29a6:	83 c4 10             	add    $0x10,%esp
    29a9:	e8 3e 12 00 00       	call   3bec <exit>
    29ae:	83 ec 0c             	sub    $0xc,%esp
    29b1:	68 66 51 00 00       	push   $0x5166
    29b6:	e8 81 12 00 00       	call   3c3c <unlink>
    29bb:	83 c4 10             	add    $0x10,%esp
    29be:	85 c0                	test   %eax,%eax
    29c0:	74 17                	je     29d9 <rmdot+0x170>
    29c2:	83 ec 08             	sub    $0x8,%esp
    29c5:	68 fe 51 00 00       	push   $0x51fe
    29ca:	6a 01                	push   $0x1
    29cc:	e8 a0 13 00 00       	call   3d71 <printf>
    29d1:	83 c4 10             	add    $0x10,%esp
    29d4:	e8 13 12 00 00       	call   3bec <exit>
    29d9:	83 ec 08             	sub    $0x8,%esp
    29dc:	68 13 52 00 00       	push   $0x5213
    29e1:	6a 01                	push   $0x1
    29e3:	e8 89 13 00 00       	call   3d71 <printf>
    29e8:	83 c4 10             	add    $0x10,%esp
    29eb:	c9                   	leave  
    29ec:	c3                   	ret    

000029ed <dirfile>:
    29ed:	55                   	push   %ebp
    29ee:	89 e5                	mov    %esp,%ebp
    29f0:	83 ec 18             	sub    $0x18,%esp
    29f3:	83 ec 08             	sub    $0x8,%esp
    29f6:	68 1d 52 00 00       	push   $0x521d
    29fb:	6a 01                	push   $0x1
    29fd:	e8 6f 13 00 00       	call   3d71 <printf>
    2a02:	83 c4 10             	add    $0x10,%esp
    2a05:	83 ec 08             	sub    $0x8,%esp
    2a08:	68 00 02 00 00       	push   $0x200
    2a0d:	68 2a 52 00 00       	push   $0x522a
    2a12:	e8 15 12 00 00       	call   3c2c <open>
    2a17:	83 c4 10             	add    $0x10,%esp
    2a1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2a1d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a21:	79 17                	jns    2a3a <dirfile+0x4d>
    2a23:	83 ec 08             	sub    $0x8,%esp
    2a26:	68 32 52 00 00       	push   $0x5232
    2a2b:	6a 01                	push   $0x1
    2a2d:	e8 3f 13 00 00       	call   3d71 <printf>
    2a32:	83 c4 10             	add    $0x10,%esp
    2a35:	e8 b2 11 00 00       	call   3bec <exit>
    2a3a:	83 ec 0c             	sub    $0xc,%esp
    2a3d:	ff 75 f4             	pushl  -0xc(%ebp)
    2a40:	e8 cf 11 00 00       	call   3c14 <close>
    2a45:	83 c4 10             	add    $0x10,%esp
    2a48:	83 ec 0c             	sub    $0xc,%esp
    2a4b:	68 2a 52 00 00       	push   $0x522a
    2a50:	e8 07 12 00 00       	call   3c5c <chdir>
    2a55:	83 c4 10             	add    $0x10,%esp
    2a58:	85 c0                	test   %eax,%eax
    2a5a:	75 17                	jne    2a73 <dirfile+0x86>
    2a5c:	83 ec 08             	sub    $0x8,%esp
    2a5f:	68 49 52 00 00       	push   $0x5249
    2a64:	6a 01                	push   $0x1
    2a66:	e8 06 13 00 00       	call   3d71 <printf>
    2a6b:	83 c4 10             	add    $0x10,%esp
    2a6e:	e8 79 11 00 00       	call   3bec <exit>
    2a73:	83 ec 08             	sub    $0x8,%esp
    2a76:	6a 00                	push   $0x0
    2a78:	68 63 52 00 00       	push   $0x5263
    2a7d:	e8 aa 11 00 00       	call   3c2c <open>
    2a82:	83 c4 10             	add    $0x10,%esp
    2a85:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2a88:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a8c:	78 17                	js     2aa5 <dirfile+0xb8>
    2a8e:	83 ec 08             	sub    $0x8,%esp
    2a91:	68 6e 52 00 00       	push   $0x526e
    2a96:	6a 01                	push   $0x1
    2a98:	e8 d4 12 00 00       	call   3d71 <printf>
    2a9d:	83 c4 10             	add    $0x10,%esp
    2aa0:	e8 47 11 00 00       	call   3bec <exit>
    2aa5:	83 ec 08             	sub    $0x8,%esp
    2aa8:	68 00 02 00 00       	push   $0x200
    2aad:	68 63 52 00 00       	push   $0x5263
    2ab2:	e8 75 11 00 00       	call   3c2c <open>
    2ab7:	83 c4 10             	add    $0x10,%esp
    2aba:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2abd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ac1:	78 17                	js     2ada <dirfile+0xed>
    2ac3:	83 ec 08             	sub    $0x8,%esp
    2ac6:	68 6e 52 00 00       	push   $0x526e
    2acb:	6a 01                	push   $0x1
    2acd:	e8 9f 12 00 00       	call   3d71 <printf>
    2ad2:	83 c4 10             	add    $0x10,%esp
    2ad5:	e8 12 11 00 00       	call   3bec <exit>
    2ada:	83 ec 0c             	sub    $0xc,%esp
    2add:	68 63 52 00 00       	push   $0x5263
    2ae2:	e8 6d 11 00 00       	call   3c54 <mkdir>
    2ae7:	83 c4 10             	add    $0x10,%esp
    2aea:	85 c0                	test   %eax,%eax
    2aec:	75 17                	jne    2b05 <dirfile+0x118>
    2aee:	83 ec 08             	sub    $0x8,%esp
    2af1:	68 8c 52 00 00       	push   $0x528c
    2af6:	6a 01                	push   $0x1
    2af8:	e8 74 12 00 00       	call   3d71 <printf>
    2afd:	83 c4 10             	add    $0x10,%esp
    2b00:	e8 e7 10 00 00       	call   3bec <exit>
    2b05:	83 ec 0c             	sub    $0xc,%esp
    2b08:	68 63 52 00 00       	push   $0x5263
    2b0d:	e8 2a 11 00 00       	call   3c3c <unlink>
    2b12:	83 c4 10             	add    $0x10,%esp
    2b15:	85 c0                	test   %eax,%eax
    2b17:	75 17                	jne    2b30 <dirfile+0x143>
    2b19:	83 ec 08             	sub    $0x8,%esp
    2b1c:	68 a9 52 00 00       	push   $0x52a9
    2b21:	6a 01                	push   $0x1
    2b23:	e8 49 12 00 00       	call   3d71 <printf>
    2b28:	83 c4 10             	add    $0x10,%esp
    2b2b:	e8 bc 10 00 00       	call   3bec <exit>
    2b30:	83 ec 08             	sub    $0x8,%esp
    2b33:	68 63 52 00 00       	push   $0x5263
    2b38:	68 c7 52 00 00       	push   $0x52c7
    2b3d:	e8 0a 11 00 00       	call   3c4c <link>
    2b42:	83 c4 10             	add    $0x10,%esp
    2b45:	85 c0                	test   %eax,%eax
    2b47:	75 17                	jne    2b60 <dirfile+0x173>
    2b49:	83 ec 08             	sub    $0x8,%esp
    2b4c:	68 d0 52 00 00       	push   $0x52d0
    2b51:	6a 01                	push   $0x1
    2b53:	e8 19 12 00 00       	call   3d71 <printf>
    2b58:	83 c4 10             	add    $0x10,%esp
    2b5b:	e8 8c 10 00 00       	call   3bec <exit>
    2b60:	83 ec 0c             	sub    $0xc,%esp
    2b63:	68 2a 52 00 00       	push   $0x522a
    2b68:	e8 cf 10 00 00       	call   3c3c <unlink>
    2b6d:	83 c4 10             	add    $0x10,%esp
    2b70:	85 c0                	test   %eax,%eax
    2b72:	74 17                	je     2b8b <dirfile+0x19e>
    2b74:	83 ec 08             	sub    $0x8,%esp
    2b77:	68 ef 52 00 00       	push   $0x52ef
    2b7c:	6a 01                	push   $0x1
    2b7e:	e8 ee 11 00 00       	call   3d71 <printf>
    2b83:	83 c4 10             	add    $0x10,%esp
    2b86:	e8 61 10 00 00       	call   3bec <exit>
    2b8b:	83 ec 08             	sub    $0x8,%esp
    2b8e:	6a 02                	push   $0x2
    2b90:	68 97 48 00 00       	push   $0x4897
    2b95:	e8 92 10 00 00       	call   3c2c <open>
    2b9a:	83 c4 10             	add    $0x10,%esp
    2b9d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2ba0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ba4:	78 17                	js     2bbd <dirfile+0x1d0>
    2ba6:	83 ec 08             	sub    $0x8,%esp
    2ba9:	68 08 53 00 00       	push   $0x5308
    2bae:	6a 01                	push   $0x1
    2bb0:	e8 bc 11 00 00       	call   3d71 <printf>
    2bb5:	83 c4 10             	add    $0x10,%esp
    2bb8:	e8 2f 10 00 00       	call   3bec <exit>
    2bbd:	83 ec 08             	sub    $0x8,%esp
    2bc0:	6a 00                	push   $0x0
    2bc2:	68 97 48 00 00       	push   $0x4897
    2bc7:	e8 60 10 00 00       	call   3c2c <open>
    2bcc:	83 c4 10             	add    $0x10,%esp
    2bcf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2bd2:	83 ec 04             	sub    $0x4,%esp
    2bd5:	6a 01                	push   $0x1
    2bd7:	68 ce 44 00 00       	push   $0x44ce
    2bdc:	ff 75 f4             	pushl  -0xc(%ebp)
    2bdf:	e8 28 10 00 00       	call   3c0c <write>
    2be4:	83 c4 10             	add    $0x10,%esp
    2be7:	85 c0                	test   %eax,%eax
    2be9:	7e 17                	jle    2c02 <dirfile+0x215>
    2beb:	83 ec 08             	sub    $0x8,%esp
    2bee:	68 27 53 00 00       	push   $0x5327
    2bf3:	6a 01                	push   $0x1
    2bf5:	e8 77 11 00 00       	call   3d71 <printf>
    2bfa:	83 c4 10             	add    $0x10,%esp
    2bfd:	e8 ea 0f 00 00       	call   3bec <exit>
    2c02:	83 ec 0c             	sub    $0xc,%esp
    2c05:	ff 75 f4             	pushl  -0xc(%ebp)
    2c08:	e8 07 10 00 00       	call   3c14 <close>
    2c0d:	83 c4 10             	add    $0x10,%esp
    2c10:	83 ec 08             	sub    $0x8,%esp
    2c13:	68 3b 53 00 00       	push   $0x533b
    2c18:	6a 01                	push   $0x1
    2c1a:	e8 52 11 00 00       	call   3d71 <printf>
    2c1f:	83 c4 10             	add    $0x10,%esp
    2c22:	c9                   	leave  
    2c23:	c3                   	ret    

00002c24 <iref>:
    2c24:	55                   	push   %ebp
    2c25:	89 e5                	mov    %esp,%ebp
    2c27:	83 ec 18             	sub    $0x18,%esp
    2c2a:	83 ec 08             	sub    $0x8,%esp
    2c2d:	68 4b 53 00 00       	push   $0x534b
    2c32:	6a 01                	push   $0x1
    2c34:	e8 38 11 00 00       	call   3d71 <printf>
    2c39:	83 c4 10             	add    $0x10,%esp
    2c3c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2c43:	e9 e7 00 00 00       	jmp    2d2f <iref+0x10b>
    2c48:	83 ec 0c             	sub    $0xc,%esp
    2c4b:	68 5c 53 00 00       	push   $0x535c
    2c50:	e8 ff 0f 00 00       	call   3c54 <mkdir>
    2c55:	83 c4 10             	add    $0x10,%esp
    2c58:	85 c0                	test   %eax,%eax
    2c5a:	74 17                	je     2c73 <iref+0x4f>
    2c5c:	83 ec 08             	sub    $0x8,%esp
    2c5f:	68 62 53 00 00       	push   $0x5362
    2c64:	6a 01                	push   $0x1
    2c66:	e8 06 11 00 00       	call   3d71 <printf>
    2c6b:	83 c4 10             	add    $0x10,%esp
    2c6e:	e8 79 0f 00 00       	call   3bec <exit>
    2c73:	83 ec 0c             	sub    $0xc,%esp
    2c76:	68 5c 53 00 00       	push   $0x535c
    2c7b:	e8 dc 0f 00 00       	call   3c5c <chdir>
    2c80:	83 c4 10             	add    $0x10,%esp
    2c83:	85 c0                	test   %eax,%eax
    2c85:	74 17                	je     2c9e <iref+0x7a>
    2c87:	83 ec 08             	sub    $0x8,%esp
    2c8a:	68 76 53 00 00       	push   $0x5376
    2c8f:	6a 01                	push   $0x1
    2c91:	e8 db 10 00 00       	call   3d71 <printf>
    2c96:	83 c4 10             	add    $0x10,%esp
    2c99:	e8 4e 0f 00 00       	call   3bec <exit>
    2c9e:	83 ec 0c             	sub    $0xc,%esp
    2ca1:	68 8a 53 00 00       	push   $0x538a
    2ca6:	e8 a9 0f 00 00       	call   3c54 <mkdir>
    2cab:	83 c4 10             	add    $0x10,%esp
    2cae:	83 ec 08             	sub    $0x8,%esp
    2cb1:	68 8a 53 00 00       	push   $0x538a
    2cb6:	68 c7 52 00 00       	push   $0x52c7
    2cbb:	e8 8c 0f 00 00       	call   3c4c <link>
    2cc0:	83 c4 10             	add    $0x10,%esp
    2cc3:	83 ec 08             	sub    $0x8,%esp
    2cc6:	68 00 02 00 00       	push   $0x200
    2ccb:	68 8a 53 00 00       	push   $0x538a
    2cd0:	e8 57 0f 00 00       	call   3c2c <open>
    2cd5:	83 c4 10             	add    $0x10,%esp
    2cd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2cdb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2cdf:	78 0e                	js     2cef <iref+0xcb>
    2ce1:	83 ec 0c             	sub    $0xc,%esp
    2ce4:	ff 75 f0             	pushl  -0x10(%ebp)
    2ce7:	e8 28 0f 00 00       	call   3c14 <close>
    2cec:	83 c4 10             	add    $0x10,%esp
    2cef:	83 ec 08             	sub    $0x8,%esp
    2cf2:	68 00 02 00 00       	push   $0x200
    2cf7:	68 8b 53 00 00       	push   $0x538b
    2cfc:	e8 2b 0f 00 00       	call   3c2c <open>
    2d01:	83 c4 10             	add    $0x10,%esp
    2d04:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2d07:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d0b:	78 0e                	js     2d1b <iref+0xf7>
    2d0d:	83 ec 0c             	sub    $0xc,%esp
    2d10:	ff 75 f0             	pushl  -0x10(%ebp)
    2d13:	e8 fc 0e 00 00       	call   3c14 <close>
    2d18:	83 c4 10             	add    $0x10,%esp
    2d1b:	83 ec 0c             	sub    $0xc,%esp
    2d1e:	68 8b 53 00 00       	push   $0x538b
    2d23:	e8 14 0f 00 00       	call   3c3c <unlink>
    2d28:	83 c4 10             	add    $0x10,%esp
    2d2b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2d2f:	83 7d f4 32          	cmpl   $0x32,-0xc(%ebp)
    2d33:	0f 8e 0f ff ff ff    	jle    2c48 <iref+0x24>
    2d39:	83 ec 0c             	sub    $0xc,%esp
    2d3c:	68 ae 51 00 00       	push   $0x51ae
    2d41:	e8 16 0f 00 00       	call   3c5c <chdir>
    2d46:	83 c4 10             	add    $0x10,%esp
    2d49:	83 ec 08             	sub    $0x8,%esp
    2d4c:	68 8e 53 00 00       	push   $0x538e
    2d51:	6a 01                	push   $0x1
    2d53:	e8 19 10 00 00       	call   3d71 <printf>
    2d58:	83 c4 10             	add    $0x10,%esp
    2d5b:	c9                   	leave  
    2d5c:	c3                   	ret    

00002d5d <forktest>:
    2d5d:	55                   	push   %ebp
    2d5e:	89 e5                	mov    %esp,%ebp
    2d60:	83 ec 18             	sub    $0x18,%esp
    2d63:	83 ec 08             	sub    $0x8,%esp
    2d66:	68 a2 53 00 00       	push   $0x53a2
    2d6b:	6a 01                	push   $0x1
    2d6d:	e8 ff 0f 00 00       	call   3d71 <printf>
    2d72:	83 c4 10             	add    $0x10,%esp
    2d75:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2d7c:	eb 1f                	jmp    2d9d <forktest+0x40>
    2d7e:	e8 61 0e 00 00       	call   3be4 <fork>
    2d83:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2d86:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d8a:	79 02                	jns    2d8e <forktest+0x31>
    2d8c:	eb 18                	jmp    2da6 <forktest+0x49>
    2d8e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d92:	75 05                	jne    2d99 <forktest+0x3c>
    2d94:	e8 53 0e 00 00       	call   3bec <exit>
    2d99:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2d9d:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    2da4:	7e d8                	jle    2d7e <forktest+0x21>
    2da6:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
    2dad:	75 17                	jne    2dc6 <forktest+0x69>
    2daf:	83 ec 08             	sub    $0x8,%esp
    2db2:	68 b0 53 00 00       	push   $0x53b0
    2db7:	6a 01                	push   $0x1
    2db9:	e8 b3 0f 00 00       	call   3d71 <printf>
    2dbe:	83 c4 10             	add    $0x10,%esp
    2dc1:	e8 26 0e 00 00       	call   3bec <exit>
    2dc6:	eb 24                	jmp    2dec <forktest+0x8f>
    2dc8:	e8 27 0e 00 00       	call   3bf4 <wait>
    2dcd:	85 c0                	test   %eax,%eax
    2dcf:	79 17                	jns    2de8 <forktest+0x8b>
    2dd1:	83 ec 08             	sub    $0x8,%esp
    2dd4:	68 d2 53 00 00       	push   $0x53d2
    2dd9:	6a 01                	push   $0x1
    2ddb:	e8 91 0f 00 00       	call   3d71 <printf>
    2de0:	83 c4 10             	add    $0x10,%esp
    2de3:	e8 04 0e 00 00       	call   3bec <exit>
    2de8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    2dec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2df0:	7f d6                	jg     2dc8 <forktest+0x6b>
    2df2:	e8 fd 0d 00 00       	call   3bf4 <wait>
    2df7:	83 f8 ff             	cmp    $0xffffffff,%eax
    2dfa:	74 17                	je     2e13 <forktest+0xb6>
    2dfc:	83 ec 08             	sub    $0x8,%esp
    2dff:	68 e6 53 00 00       	push   $0x53e6
    2e04:	6a 01                	push   $0x1
    2e06:	e8 66 0f 00 00       	call   3d71 <printf>
    2e0b:	83 c4 10             	add    $0x10,%esp
    2e0e:	e8 d9 0d 00 00       	call   3bec <exit>
    2e13:	83 ec 08             	sub    $0x8,%esp
    2e16:	68 f9 53 00 00       	push   $0x53f9
    2e1b:	6a 01                	push   $0x1
    2e1d:	e8 4f 0f 00 00       	call   3d71 <printf>
    2e22:	83 c4 10             	add    $0x10,%esp
    2e25:	c9                   	leave  
    2e26:	c3                   	ret    

00002e27 <sbrktest>:
    2e27:	55                   	push   %ebp
    2e28:	89 e5                	mov    %esp,%ebp
    2e2a:	53                   	push   %ebx
    2e2b:	83 ec 64             	sub    $0x64,%esp
    2e2e:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    2e33:	83 ec 08             	sub    $0x8,%esp
    2e36:	68 07 54 00 00       	push   $0x5407
    2e3b:	50                   	push   %eax
    2e3c:	e8 30 0f 00 00       	call   3d71 <printf>
    2e41:	83 c4 10             	add    $0x10,%esp
    2e44:	83 ec 0c             	sub    $0xc,%esp
    2e47:	6a 00                	push   $0x0
    2e49:	e8 26 0e 00 00       	call   3c74 <sbrk>
    2e4e:	83 c4 10             	add    $0x10,%esp
    2e51:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2e54:	83 ec 0c             	sub    $0xc,%esp
    2e57:	6a 00                	push   $0x0
    2e59:	e8 16 0e 00 00       	call   3c74 <sbrk>
    2e5e:	83 c4 10             	add    $0x10,%esp
    2e61:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2e64:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2e6b:	eb 4f                	jmp    2ebc <sbrktest+0x95>
    2e6d:	83 ec 0c             	sub    $0xc,%esp
    2e70:	6a 01                	push   $0x1
    2e72:	e8 fd 0d 00 00       	call   3c74 <sbrk>
    2e77:	83 c4 10             	add    $0x10,%esp
    2e7a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    2e7d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2e80:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2e83:	74 24                	je     2ea9 <sbrktest+0x82>
    2e85:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    2e8a:	83 ec 0c             	sub    $0xc,%esp
    2e8d:	ff 75 e8             	pushl  -0x18(%ebp)
    2e90:	ff 75 f4             	pushl  -0xc(%ebp)
    2e93:	ff 75 f0             	pushl  -0x10(%ebp)
    2e96:	68 12 54 00 00       	push   $0x5412
    2e9b:	50                   	push   %eax
    2e9c:	e8 d0 0e 00 00       	call   3d71 <printf>
    2ea1:	83 c4 20             	add    $0x20,%esp
    2ea4:	e8 43 0d 00 00       	call   3bec <exit>
    2ea9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2eac:	c6 00 01             	movb   $0x1,(%eax)
    2eaf:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2eb2:	83 c0 01             	add    $0x1,%eax
    2eb5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2eb8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2ebc:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
    2ec3:	7e a8                	jle    2e6d <sbrktest+0x46>
    2ec5:	e8 1a 0d 00 00       	call   3be4 <fork>
    2eca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    2ecd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    2ed1:	79 1b                	jns    2eee <sbrktest+0xc7>
    2ed3:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    2ed8:	83 ec 08             	sub    $0x8,%esp
    2edb:	68 2d 54 00 00       	push   $0x542d
    2ee0:	50                   	push   %eax
    2ee1:	e8 8b 0e 00 00       	call   3d71 <printf>
    2ee6:	83 c4 10             	add    $0x10,%esp
    2ee9:	e8 fe 0c 00 00       	call   3bec <exit>
    2eee:	83 ec 0c             	sub    $0xc,%esp
    2ef1:	6a 01                	push   $0x1
    2ef3:	e8 7c 0d 00 00       	call   3c74 <sbrk>
    2ef8:	83 c4 10             	add    $0x10,%esp
    2efb:	89 45 e0             	mov    %eax,-0x20(%ebp)
    2efe:	83 ec 0c             	sub    $0xc,%esp
    2f01:	6a 01                	push   $0x1
    2f03:	e8 6c 0d 00 00       	call   3c74 <sbrk>
    2f08:	83 c4 10             	add    $0x10,%esp
    2f0b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    2f0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f11:	83 c0 01             	add    $0x1,%eax
    2f14:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    2f17:	74 1b                	je     2f34 <sbrktest+0x10d>
    2f19:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    2f1e:	83 ec 08             	sub    $0x8,%esp
    2f21:	68 44 54 00 00       	push   $0x5444
    2f26:	50                   	push   %eax
    2f27:	e8 45 0e 00 00       	call   3d71 <printf>
    2f2c:	83 c4 10             	add    $0x10,%esp
    2f2f:	e8 b8 0c 00 00       	call   3bec <exit>
    2f34:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    2f38:	75 05                	jne    2f3f <sbrktest+0x118>
    2f3a:	e8 ad 0c 00 00       	call   3bec <exit>
    2f3f:	e8 b0 0c 00 00       	call   3bf4 <wait>
    2f44:	83 ec 0c             	sub    $0xc,%esp
    2f47:	6a 00                	push   $0x0
    2f49:	e8 26 0d 00 00       	call   3c74 <sbrk>
    2f4e:	83 c4 10             	add    $0x10,%esp
    2f51:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2f54:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f57:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2f5c:	29 c2                	sub    %eax,%edx
    2f5e:	89 d0                	mov    %edx,%eax
    2f60:	89 45 dc             	mov    %eax,-0x24(%ebp)
    2f63:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2f66:	83 ec 0c             	sub    $0xc,%esp
    2f69:	50                   	push   %eax
    2f6a:	e8 05 0d 00 00       	call   3c74 <sbrk>
    2f6f:	83 c4 10             	add    $0x10,%esp
    2f72:	89 45 d8             	mov    %eax,-0x28(%ebp)
    2f75:	8b 45 d8             	mov    -0x28(%ebp),%eax
    2f78:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2f7b:	74 1b                	je     2f98 <sbrktest+0x171>
    2f7d:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    2f82:	83 ec 08             	sub    $0x8,%esp
    2f85:	68 60 54 00 00       	push   $0x5460
    2f8a:	50                   	push   %eax
    2f8b:	e8 e1 0d 00 00       	call   3d71 <printf>
    2f90:	83 c4 10             	add    $0x10,%esp
    2f93:	e8 54 0c 00 00       	call   3bec <exit>
    2f98:	c7 45 d4 ff ff 3f 06 	movl   $0x63fffff,-0x2c(%ebp)
    2f9f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2fa2:	c6 00 63             	movb   $0x63,(%eax)
    2fa5:	83 ec 0c             	sub    $0xc,%esp
    2fa8:	6a 00                	push   $0x0
    2faa:	e8 c5 0c 00 00       	call   3c74 <sbrk>
    2faf:	83 c4 10             	add    $0x10,%esp
    2fb2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2fb5:	83 ec 0c             	sub    $0xc,%esp
    2fb8:	68 00 f0 ff ff       	push   $0xfffff000
    2fbd:	e8 b2 0c 00 00       	call   3c74 <sbrk>
    2fc2:	83 c4 10             	add    $0x10,%esp
    2fc5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    2fc8:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    2fcc:	75 1b                	jne    2fe9 <sbrktest+0x1c2>
    2fce:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    2fd3:	83 ec 08             	sub    $0x8,%esp
    2fd6:	68 9e 54 00 00       	push   $0x549e
    2fdb:	50                   	push   %eax
    2fdc:	e8 90 0d 00 00       	call   3d71 <printf>
    2fe1:	83 c4 10             	add    $0x10,%esp
    2fe4:	e8 03 0c 00 00       	call   3bec <exit>
    2fe9:	83 ec 0c             	sub    $0xc,%esp
    2fec:	6a 00                	push   $0x0
    2fee:	e8 81 0c 00 00       	call   3c74 <sbrk>
    2ff3:	83 c4 10             	add    $0x10,%esp
    2ff6:	89 45 e0             	mov    %eax,-0x20(%ebp)
    2ff9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2ffc:	2d 00 10 00 00       	sub    $0x1000,%eax
    3001:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    3004:	74 1e                	je     3024 <sbrktest+0x1fd>
    3006:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    300b:	ff 75 e0             	pushl  -0x20(%ebp)
    300e:	ff 75 f4             	pushl  -0xc(%ebp)
    3011:	68 bc 54 00 00       	push   $0x54bc
    3016:	50                   	push   %eax
    3017:	e8 55 0d 00 00       	call   3d71 <printf>
    301c:	83 c4 10             	add    $0x10,%esp
    301f:	e8 c8 0b 00 00       	call   3bec <exit>
    3024:	83 ec 0c             	sub    $0xc,%esp
    3027:	6a 00                	push   $0x0
    3029:	e8 46 0c 00 00       	call   3c74 <sbrk>
    302e:	83 c4 10             	add    $0x10,%esp
    3031:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3034:	83 ec 0c             	sub    $0xc,%esp
    3037:	68 00 10 00 00       	push   $0x1000
    303c:	e8 33 0c 00 00       	call   3c74 <sbrk>
    3041:	83 c4 10             	add    $0x10,%esp
    3044:	89 45 e0             	mov    %eax,-0x20(%ebp)
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
    306a:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    306f:	ff 75 e0             	pushl  -0x20(%ebp)
    3072:	ff 75 f4             	pushl  -0xc(%ebp)
    3075:	68 f4 54 00 00       	push   $0x54f4
    307a:	50                   	push   %eax
    307b:	e8 f1 0c 00 00       	call   3d71 <printf>
    3080:	83 c4 10             	add    $0x10,%esp
    3083:	e8 64 0b 00 00       	call   3bec <exit>
    3088:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    308b:	0f b6 00             	movzbl (%eax),%eax
    308e:	3c 63                	cmp    $0x63,%al
    3090:	75 1b                	jne    30ad <sbrktest+0x286>
    3092:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    3097:	83 ec 08             	sub    $0x8,%esp
    309a:	68 1c 55 00 00       	push   $0x551c
    309f:	50                   	push   %eax
    30a0:	e8 cc 0c 00 00       	call   3d71 <printf>
    30a5:	83 c4 10             	add    $0x10,%esp
    30a8:	e8 3f 0b 00 00       	call   3bec <exit>
    30ad:	83 ec 0c             	sub    $0xc,%esp
    30b0:	6a 00                	push   $0x0
    30b2:	e8 bd 0b 00 00       	call   3c74 <sbrk>
    30b7:	83 c4 10             	add    $0x10,%esp
    30ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
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
    30e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    30e3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    30e6:	74 1e                	je     3106 <sbrktest+0x2df>
    30e8:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    30ed:	ff 75 e0             	pushl  -0x20(%ebp)
    30f0:	ff 75 f4             	pushl  -0xc(%ebp)
    30f3:	68 4c 55 00 00       	push   $0x554c
    30f8:	50                   	push   %eax
    30f9:	e8 73 0c 00 00       	call   3d71 <printf>
    30fe:	83 c4 10             	add    $0x10,%esp
    3101:	e8 e6 0a 00 00       	call   3bec <exit>
    3106:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
    310d:	eb 76                	jmp    3185 <sbrktest+0x35e>
    310f:	e8 58 0b 00 00       	call   3c6c <getpid>
    3114:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3117:	e8 c8 0a 00 00       	call   3be4 <fork>
    311c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    311f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3123:	79 1b                	jns    3140 <sbrktest+0x319>
    3125:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    312a:	83 ec 08             	sub    $0x8,%esp
    312d:	68 15 45 00 00       	push   $0x4515
    3132:	50                   	push   %eax
    3133:	e8 39 0c 00 00       	call   3d71 <printf>
    3138:	83 c4 10             	add    $0x10,%esp
    313b:	e8 ac 0a 00 00       	call   3bec <exit>
    3140:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3144:	75 33                	jne    3179 <sbrktest+0x352>
    3146:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3149:	0f b6 00             	movzbl (%eax),%eax
    314c:	0f be d0             	movsbl %al,%edx
    314f:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    3154:	52                   	push   %edx
    3155:	ff 75 f4             	pushl  -0xc(%ebp)
    3158:	68 6d 55 00 00       	push   $0x556d
    315d:	50                   	push   %eax
    315e:	e8 0e 0c 00 00       	call   3d71 <printf>
    3163:	83 c4 10             	add    $0x10,%esp
    3166:	83 ec 0c             	sub    $0xc,%esp
    3169:	ff 75 d0             	pushl  -0x30(%ebp)
    316c:	e8 ab 0a 00 00       	call   3c1c <kill>
    3171:	83 c4 10             	add    $0x10,%esp
    3174:	e8 73 0a 00 00       	call   3bec <exit>
    3179:	e8 76 0a 00 00       	call   3bf4 <wait>
    317e:	81 45 f4 50 c3 00 00 	addl   $0xc350,-0xc(%ebp)
    3185:	81 7d f4 7f 84 1e 80 	cmpl   $0x801e847f,-0xc(%ebp)
    318c:	76 81                	jbe    310f <sbrktest+0x2e8>
    318e:	83 ec 0c             	sub    $0xc,%esp
    3191:	8d 45 c8             	lea    -0x38(%ebp),%eax
    3194:	50                   	push   %eax
    3195:	e8 62 0a 00 00       	call   3bfc <pipe>
    319a:	83 c4 10             	add    $0x10,%esp
    319d:	85 c0                	test   %eax,%eax
    319f:	74 17                	je     31b8 <sbrktest+0x391>
    31a1:	83 ec 08             	sub    $0x8,%esp
    31a4:	68 69 44 00 00       	push   $0x4469
    31a9:	6a 01                	push   $0x1
    31ab:	e8 c1 0b 00 00       	call   3d71 <printf>
    31b0:	83 c4 10             	add    $0x10,%esp
    31b3:	e8 34 0a 00 00       	call   3bec <exit>
    31b8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    31bf:	e9 88 00 00 00       	jmp    324c <sbrktest+0x425>
    31c4:	e8 1b 0a 00 00       	call   3be4 <fork>
    31c9:	89 c2                	mov    %eax,%edx
    31cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    31ce:	89 54 85 a0          	mov    %edx,-0x60(%ebp,%eax,4)
    31d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    31d5:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    31d9:	85 c0                	test   %eax,%eax
    31db:	75 4a                	jne    3227 <sbrktest+0x400>
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
    31ff:	8b 45 cc             	mov    -0x34(%ebp),%eax
    3202:	83 ec 04             	sub    $0x4,%esp
    3205:	6a 01                	push   $0x1
    3207:	68 ce 44 00 00       	push   $0x44ce
    320c:	50                   	push   %eax
    320d:	e8 fa 09 00 00       	call   3c0c <write>
    3212:	83 c4 10             	add    $0x10,%esp
    3215:	83 ec 0c             	sub    $0xc,%esp
    3218:	68 e8 03 00 00       	push   $0x3e8
    321d:	e8 5a 0a 00 00       	call   3c7c <sleep>
    3222:	83 c4 10             	add    $0x10,%esp
    3225:	eb ee                	jmp    3215 <sbrktest+0x3ee>
    3227:	8b 45 f0             	mov    -0x10(%ebp),%eax
    322a:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    322e:	83 f8 ff             	cmp    $0xffffffff,%eax
    3231:	74 15                	je     3248 <sbrktest+0x421>
    3233:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3236:	83 ec 04             	sub    $0x4,%esp
    3239:	6a 01                	push   $0x1
    323b:	8d 55 9f             	lea    -0x61(%ebp),%edx
    323e:	52                   	push   %edx
    323f:	50                   	push   %eax
    3240:	e8 bf 09 00 00       	call   3c04 <read>
    3245:	83 c4 10             	add    $0x10,%esp
    3248:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    324c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    324f:	83 f8 09             	cmp    $0x9,%eax
    3252:	0f 86 6c ff ff ff    	jbe    31c4 <sbrktest+0x39d>
    3258:	83 ec 0c             	sub    $0xc,%esp
    325b:	68 00 10 00 00       	push   $0x1000
    3260:	e8 0f 0a 00 00       	call   3c74 <sbrk>
    3265:	83 c4 10             	add    $0x10,%esp
    3268:	89 45 e0             	mov    %eax,-0x20(%ebp)
    326b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3272:	eb 2a                	jmp    329e <sbrktest+0x477>
    3274:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3277:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    327b:	83 f8 ff             	cmp    $0xffffffff,%eax
    327e:	75 02                	jne    3282 <sbrktest+0x45b>
    3280:	eb 18                	jmp    329a <sbrktest+0x473>
    3282:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3285:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3289:	83 ec 0c             	sub    $0xc,%esp
    328c:	50                   	push   %eax
    328d:	e8 8a 09 00 00       	call   3c1c <kill>
    3292:	83 c4 10             	add    $0x10,%esp
    3295:	e8 5a 09 00 00       	call   3bf4 <wait>
    329a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    329e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    32a1:	83 f8 09             	cmp    $0x9,%eax
    32a4:	76 ce                	jbe    3274 <sbrktest+0x44d>
    32a6:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    32aa:	75 1b                	jne    32c7 <sbrktest+0x4a0>
    32ac:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    32b1:	83 ec 08             	sub    $0x8,%esp
    32b4:	68 86 55 00 00       	push   $0x5586
    32b9:	50                   	push   %eax
    32ba:	e8 b2 0a 00 00       	call   3d71 <printf>
    32bf:	83 c4 10             	add    $0x10,%esp
    32c2:	e8 25 09 00 00       	call   3bec <exit>
    32c7:	83 ec 0c             	sub    $0xc,%esp
    32ca:	6a 00                	push   $0x0
    32cc:	e8 a3 09 00 00       	call   3c74 <sbrk>
    32d1:	83 c4 10             	add    $0x10,%esp
    32d4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    32d7:	76 20                	jbe    32f9 <sbrktest+0x4d2>
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
    32f9:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    32fe:	83 ec 08             	sub    $0x8,%esp
    3301:	68 a1 55 00 00       	push   $0x55a1
    3306:	50                   	push   %eax
    3307:	e8 65 0a 00 00       	call   3d71 <printf>
    330c:	83 c4 10             	add    $0x10,%esp
    330f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3312:	c9                   	leave  
    3313:	c3                   	ret    

00003314 <validateint>:
    3314:	55                   	push   %ebp
    3315:	89 e5                	mov    %esp,%ebp
    3317:	53                   	push   %ebx
    3318:	83 ec 10             	sub    $0x10,%esp
    331b:	b8 0d 00 00 00       	mov    $0xd,%eax
    3320:	8b 55 08             	mov    0x8(%ebp),%edx
    3323:	89 d1                	mov    %edx,%ecx
    3325:	89 e3                	mov    %esp,%ebx
    3327:	89 cc                	mov    %ecx,%esp
    3329:	cd 40                	int    $0x40
    332b:	89 dc                	mov    %ebx,%esp
    332d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    3330:	83 c4 10             	add    $0x10,%esp
    3333:	5b                   	pop    %ebx
    3334:	5d                   	pop    %ebp
    3335:	c3                   	ret    

00003336 <validatetest>:
    3336:	55                   	push   %ebp
    3337:	89 e5                	mov    %esp,%ebp
    3339:	83 ec 18             	sub    $0x18,%esp
    333c:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    3341:	83 ec 08             	sub    $0x8,%esp
    3344:	68 af 55 00 00       	push   $0x55af
    3349:	50                   	push   %eax
    334a:	e8 22 0a 00 00       	call   3d71 <printf>
    334f:	83 c4 10             	add    $0x10,%esp
    3352:	c7 45 f0 00 30 11 00 	movl   $0x113000,-0x10(%ebp)
    3359:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3360:	e9 8a 00 00 00       	jmp    33ef <validatetest+0xb9>
    3365:	e8 7a 08 00 00       	call   3be4 <fork>
    336a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    336d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3371:	75 14                	jne    3387 <validatetest+0x51>
    3373:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3376:	83 ec 0c             	sub    $0xc,%esp
    3379:	50                   	push   %eax
    337a:	e8 95 ff ff ff       	call   3314 <validateint>
    337f:	83 c4 10             	add    $0x10,%esp
    3382:	e8 65 08 00 00       	call   3bec <exit>
    3387:	83 ec 0c             	sub    $0xc,%esp
    338a:	6a 00                	push   $0x0
    338c:	e8 eb 08 00 00       	call   3c7c <sleep>
    3391:	83 c4 10             	add    $0x10,%esp
    3394:	83 ec 0c             	sub    $0xc,%esp
    3397:	6a 00                	push   $0x0
    3399:	e8 de 08 00 00       	call   3c7c <sleep>
    339e:	83 c4 10             	add    $0x10,%esp
    33a1:	83 ec 0c             	sub    $0xc,%esp
    33a4:	ff 75 ec             	pushl  -0x14(%ebp)
    33a7:	e8 70 08 00 00       	call   3c1c <kill>
    33ac:	83 c4 10             	add    $0x10,%esp
    33af:	e8 40 08 00 00       	call   3bf4 <wait>
    33b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    33b7:	83 ec 08             	sub    $0x8,%esp
    33ba:	50                   	push   %eax
    33bb:	68 be 55 00 00       	push   $0x55be
    33c0:	e8 87 08 00 00       	call   3c4c <link>
    33c5:	83 c4 10             	add    $0x10,%esp
    33c8:	83 f8 ff             	cmp    $0xffffffff,%eax
    33cb:	74 1b                	je     33e8 <validatetest+0xb2>
    33cd:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    33d2:	83 ec 08             	sub    $0x8,%esp
    33d5:	68 c9 55 00 00       	push   $0x55c9
    33da:	50                   	push   %eax
    33db:	e8 91 09 00 00       	call   3d71 <printf>
    33e0:	83 c4 10             	add    $0x10,%esp
    33e3:	e8 04 08 00 00       	call   3bec <exit>
    33e8:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    33ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
    33f2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    33f5:	0f 83 6a ff ff ff    	jae    3365 <validatetest+0x2f>
    33fb:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    3400:	83 ec 08             	sub    $0x8,%esp
    3403:	68 e2 55 00 00       	push   $0x55e2
    3408:	50                   	push   %eax
    3409:	e8 63 09 00 00       	call   3d71 <printf>
    340e:	83 c4 10             	add    $0x10,%esp
    3411:	c9                   	leave  
    3412:	c3                   	ret    

00003413 <bsstest>:
    3413:	55                   	push   %ebp
    3414:	89 e5                	mov    %esp,%ebp
    3416:	83 ec 18             	sub    $0x18,%esp
    3419:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    341e:	83 ec 08             	sub    $0x8,%esp
    3421:	68 ef 55 00 00       	push   $0x55ef
    3426:	50                   	push   %eax
    3427:	e8 45 09 00 00       	call   3d71 <printf>
    342c:	83 c4 10             	add    $0x10,%esp
    342f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3436:	eb 2e                	jmp    3466 <bsstest+0x53>
    3438:	8b 45 f4             	mov    -0xc(%ebp),%eax
    343b:	05 80 5f 00 00       	add    $0x5f80,%eax
    3440:	0f b6 00             	movzbl (%eax),%eax
    3443:	84 c0                	test   %al,%al
    3445:	74 1b                	je     3462 <bsstest+0x4f>
    3447:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    344c:	83 ec 08             	sub    $0x8,%esp
    344f:	68 f9 55 00 00       	push   $0x55f9
    3454:	50                   	push   %eax
    3455:	e8 17 09 00 00       	call   3d71 <printf>
    345a:	83 c4 10             	add    $0x10,%esp
    345d:	e8 8a 07 00 00       	call   3bec <exit>
    3462:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3466:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3469:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    346e:	76 c8                	jbe    3438 <bsstest+0x25>
    3470:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    3475:	83 ec 08             	sub    $0x8,%esp
    3478:	68 0a 56 00 00       	push   $0x560a
    347d:	50                   	push   %eax
    347e:	e8 ee 08 00 00       	call   3d71 <printf>
    3483:	83 c4 10             	add    $0x10,%esp
    3486:	c9                   	leave  
    3487:	c3                   	ret    

00003488 <bigargtest>:
    3488:	55                   	push   %ebp
    3489:	89 e5                	mov    %esp,%ebp
    348b:	83 ec 18             	sub    $0x18,%esp
    348e:	83 ec 0c             	sub    $0xc,%esp
    3491:	68 17 56 00 00       	push   $0x5617
    3496:	e8 a1 07 00 00       	call   3c3c <unlink>
    349b:	83 c4 10             	add    $0x10,%esp
    349e:	e8 41 07 00 00       	call   3be4 <fork>
    34a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    34a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    34aa:	0f 85 97 00 00 00    	jne    3547 <bigargtest+0xbf>
    34b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    34b7:	eb 12                	jmp    34cb <bigargtest+0x43>
    34b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    34bc:	c7 04 85 c0 5e 00 00 	movl   $0x5624,0x5ec0(,%eax,4)
    34c3:	24 56 00 00 
    34c7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    34cb:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
    34cf:	7e e8                	jle    34b9 <bigargtest+0x31>
    34d1:	c7 05 3c 5f 00 00 00 	movl   $0x0,0x5f3c
    34d8:	00 00 00 
    34db:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    34e0:	83 ec 08             	sub    $0x8,%esp
    34e3:	68 01 57 00 00       	push   $0x5701
    34e8:	50                   	push   %eax
    34e9:	e8 83 08 00 00       	call   3d71 <printf>
    34ee:	83 c4 10             	add    $0x10,%esp
    34f1:	83 ec 08             	sub    $0x8,%esp
    34f4:	68 c0 5e 00 00       	push   $0x5ec0
    34f9:	68 28 41 00 00       	push   $0x4128
    34fe:	e8 21 07 00 00       	call   3c24 <exec>
    3503:	83 c4 10             	add    $0x10,%esp
    3506:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    350b:	83 ec 08             	sub    $0x8,%esp
    350e:	68 0e 57 00 00       	push   $0x570e
    3513:	50                   	push   %eax
    3514:	e8 58 08 00 00       	call   3d71 <printf>
    3519:	83 c4 10             	add    $0x10,%esp
    351c:	83 ec 08             	sub    $0x8,%esp
    351f:	68 00 02 00 00       	push   $0x200
    3524:	68 17 56 00 00       	push   $0x5617
    3529:	e8 fe 06 00 00       	call   3c2c <open>
    352e:	83 c4 10             	add    $0x10,%esp
    3531:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3534:	83 ec 0c             	sub    $0xc,%esp
    3537:	ff 75 ec             	pushl  -0x14(%ebp)
    353a:	e8 d5 06 00 00       	call   3c14 <close>
    353f:	83 c4 10             	add    $0x10,%esp
    3542:	e8 a5 06 00 00       	call   3bec <exit>
    3547:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    354b:	79 1b                	jns    3568 <bigargtest+0xe0>
    354d:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    3552:	83 ec 08             	sub    $0x8,%esp
    3555:	68 1e 57 00 00       	push   $0x571e
    355a:	50                   	push   %eax
    355b:	e8 11 08 00 00       	call   3d71 <printf>
    3560:	83 c4 10             	add    $0x10,%esp
    3563:	e8 84 06 00 00       	call   3bec <exit>
    3568:	e8 87 06 00 00       	call   3bf4 <wait>
    356d:	83 ec 08             	sub    $0x8,%esp
    3570:	6a 00                	push   $0x0
    3572:	68 17 56 00 00       	push   $0x5617
    3577:	e8 b0 06 00 00       	call   3c2c <open>
    357c:	83 c4 10             	add    $0x10,%esp
    357f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3582:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3586:	79 1b                	jns    35a3 <bigargtest+0x11b>
    3588:	a1 7c 5e 00 00       	mov    0x5e7c,%eax
    358d:	83 ec 08             	sub    $0x8,%esp
    3590:	68 37 57 00 00       	push   $0x5737
    3595:	50                   	push   %eax
    3596:	e8 d6 07 00 00       	call   3d71 <printf>
    359b:	83 c4 10             	add    $0x10,%esp
    359e:	e8 49 06 00 00       	call   3bec <exit>
    35a3:	83 ec 0c             	sub    $0xc,%esp
    35a6:	ff 75 ec             	pushl  -0x14(%ebp)
    35a9:	e8 66 06 00 00       	call   3c14 <close>
    35ae:	83 c4 10             	add    $0x10,%esp
    35b1:	83 ec 0c             	sub    $0xc,%esp
    35b4:	68 17 56 00 00       	push   $0x5617
    35b9:	e8 7e 06 00 00       	call   3c3c <unlink>
    35be:	83 c4 10             	add    $0x10,%esp
    35c1:	c9                   	leave  
    35c2:	c3                   	ret    

000035c3 <fsfull>:
    35c3:	55                   	push   %ebp
    35c4:	89 e5                	mov    %esp,%ebp
    35c6:	53                   	push   %ebx
    35c7:	83 ec 64             	sub    $0x64,%esp
    35ca:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    35d1:	83 ec 08             	sub    $0x8,%esp
    35d4:	68 4c 57 00 00       	push   $0x574c
    35d9:	6a 01                	push   $0x1
    35db:	e8 91 07 00 00       	call   3d71 <printf>
    35e0:	83 c4 10             	add    $0x10,%esp
    35e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    35ea:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
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
    36ae:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    36b2:	83 ec 04             	sub    $0x4,%esp
    36b5:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    36b8:	50                   	push   %eax
    36b9:	68 59 57 00 00       	push   $0x5759
    36be:	6a 01                	push   $0x1
    36c0:	e8 ac 06 00 00       	call   3d71 <printf>
    36c5:	83 c4 10             	add    $0x10,%esp
    36c8:	83 ec 08             	sub    $0x8,%esp
    36cb:	68 02 02 00 00       	push   $0x202
    36d0:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    36d3:	50                   	push   %eax
    36d4:	e8 53 05 00 00       	call   3c2c <open>
    36d9:	83 c4 10             	add    $0x10,%esp
    36dc:	89 45 e8             	mov    %eax,-0x18(%ebp)
    36df:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    36e3:	79 18                	jns    36fd <fsfull+0x13a>
    36e5:	83 ec 04             	sub    $0x4,%esp
    36e8:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    36eb:	50                   	push   %eax
    36ec:	68 65 57 00 00       	push   $0x5765
    36f1:	6a 01                	push   $0x1
    36f3:	e8 79 06 00 00       	call   3d71 <printf>
    36f8:	83 c4 10             	add    $0x10,%esp
    36fb:	eb 6e                	jmp    376b <fsfull+0x1a8>
    36fd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    3704:	83 ec 04             	sub    $0x4,%esp
    3707:	68 00 02 00 00       	push   $0x200
    370c:	68 c0 86 00 00       	push   $0x86c0
    3711:	ff 75 e8             	pushl  -0x18(%ebp)
    3714:	e8 f3 04 00 00       	call   3c0c <write>
    3719:	83 c4 10             	add    $0x10,%esp
    371c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    371f:	81 7d e4 ff 01 00 00 	cmpl   $0x1ff,-0x1c(%ebp)
    3726:	7f 2c                	jg     3754 <fsfull+0x191>
    3728:	90                   	nop
    3729:	83 ec 04             	sub    $0x4,%esp
    372c:	ff 75 ec             	pushl  -0x14(%ebp)
    372f:	68 75 57 00 00       	push   $0x5775
    3734:	6a 01                	push   $0x1
    3736:	e8 36 06 00 00       	call   3d71 <printf>
    373b:	83 c4 10             	add    $0x10,%esp
    373e:	83 ec 0c             	sub    $0xc,%esp
    3741:	ff 75 e8             	pushl  -0x18(%ebp)
    3744:	e8 cb 04 00 00       	call   3c14 <close>
    3749:	83 c4 10             	add    $0x10,%esp
    374c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3750:	75 10                	jne    3762 <fsfull+0x19f>
    3752:	eb 0c                	jmp    3760 <fsfull+0x19d>
    3754:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3757:	01 45 ec             	add    %eax,-0x14(%ebp)
    375a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    375e:	eb a4                	jmp    3704 <fsfull+0x141>
    3760:	eb 09                	jmp    376b <fsfull+0x1a8>
    3762:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3766:	e9 7f fe ff ff       	jmp    35ea <fsfull+0x27>
    376b:	e9 db 00 00 00       	jmp    384b <fsfull+0x288>
    3770:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
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
    3834:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    3838:	83 ec 0c             	sub    $0xc,%esp
    383b:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    383e:	50                   	push   %eax
    383f:	e8 f8 03 00 00       	call   3c3c <unlink>
    3844:	83 c4 10             	add    $0x10,%esp
    3847:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    384b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    384f:	0f 89 1b ff ff ff    	jns    3770 <fsfull+0x1ad>
    3855:	83 ec 08             	sub    $0x8,%esp
    3858:	68 85 57 00 00       	push   $0x5785
    385d:	6a 01                	push   $0x1
    385f:	e8 0d 05 00 00       	call   3d71 <printf>
    3864:	83 c4 10             	add    $0x10,%esp
    3867:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    386a:	c9                   	leave  
    386b:	c3                   	ret    

0000386c <rand>:
    386c:	55                   	push   %ebp
    386d:	89 e5                	mov    %esp,%ebp
    386f:	a1 80 5e 00 00       	mov    0x5e80,%eax
    3874:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    387a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    387f:	a3 80 5e 00 00       	mov    %eax,0x5e80
    3884:	a1 80 5e 00 00       	mov    0x5e80,%eax
    3889:	5d                   	pop    %ebp
    388a:	c3                   	ret    

0000388b <main>:
    388b:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    388f:	83 e4 f0             	and    $0xfffffff0,%esp
    3892:	ff 71 fc             	pushl  -0x4(%ecx)
    3895:	55                   	push   %ebp
    3896:	89 e5                	mov    %esp,%ebp
    3898:	51                   	push   %ecx
    3899:	83 ec 04             	sub    $0x4,%esp
    389c:	83 ec 08             	sub    $0x8,%esp
    389f:	68 9b 57 00 00       	push   $0x579b
    38a4:	6a 01                	push   $0x1
    38a6:	e8 c6 04 00 00       	call   3d71 <printf>
    38ab:	83 c4 10             	add    $0x10,%esp
    38ae:	83 ec 08             	sub    $0x8,%esp
    38b1:	6a 00                	push   $0x0
    38b3:	68 af 57 00 00       	push   $0x57af
    38b8:	e8 6f 03 00 00       	call   3c2c <open>
    38bd:	83 c4 10             	add    $0x10,%esp
    38c0:	85 c0                	test   %eax,%eax
    38c2:	78 17                	js     38db <main+0x50>
    38c4:	83 ec 08             	sub    $0x8,%esp
    38c7:	68 c0 57 00 00       	push   $0x57c0
    38cc:	6a 01                	push   $0x1
    38ce:	e8 9e 04 00 00       	call   3d71 <printf>
    38d3:	83 c4 10             	add    $0x10,%esp
    38d6:	e8 11 03 00 00       	call   3bec <exit>
    38db:	83 ec 08             	sub    $0x8,%esp
    38de:	68 00 02 00 00       	push   $0x200
    38e3:	68 af 57 00 00       	push   $0x57af
    38e8:	e8 3f 03 00 00       	call   3c2c <open>
    38ed:	83 c4 10             	add    $0x10,%esp
    38f0:	83 ec 0c             	sub    $0xc,%esp
    38f3:	50                   	push   %eax
    38f4:	e8 1b 03 00 00       	call   3c14 <close>
    38f9:	83 c4 10             	add    $0x10,%esp
    38fc:	e8 87 fb ff ff       	call   3488 <bigargtest>
    3901:	e8 ee ea ff ff       	call   23f4 <bigwrite>
    3906:	e8 7d fb ff ff       	call   3488 <bigargtest>
    390b:	e8 03 fb ff ff       	call   3413 <bsstest>
    3910:	e8 12 f5 ff ff       	call   2e27 <sbrktest>
    3915:	e8 1c fa ff ff       	call   3336 <validatetest>
    391a:	e8 e1 c6 ff ff       	call   0 <opentest>
    391f:	e8 8a c7 ff ff       	call   ae <writetest>
    3924:	e8 94 c9 ff ff       	call   2bd <writetest1>
    3929:	e8 8c cb ff ff       	call   4ba <createtest>
    392e:	e8 4f d1 ff ff       	call   a82 <mem>
    3933:	e8 86 cd ff ff       	call   6be <pipe1>
    3938:	e8 6a cf ff ff       	call   8a7 <preempt>
    393d:	e8 c8 d0 ff ff       	call   a0a <exitwait>
    3942:	e8 22 ef ff ff       	call   2869 <rmdot>
    3947:	e8 c2 ed ff ff       	call   270e <fourteen>
    394c:	e8 a0 eb ff ff       	call   24f1 <bigfile>
    3951:	e8 5b e3 ff ff       	call   1cb1 <subdir>
    3956:	e8 ff dc ff ff       	call   165a <concreate>
    395b:	e8 a9 e0 ff ff       	call   1a09 <linkunlink>
    3960:	e8 b4 da ff ff       	call   1419 <linktest>
    3965:	e8 ee d8 ff ff       	call   1258 <unlinkread>
    396a:	e8 44 d6 ff ff       	call   fb3 <createdelete>
    396f:	e8 e1 d3 ff ff       	call   d55 <twofiles>
    3974:	e8 f9 d1 ff ff       	call   b72 <sharedfd>
    3979:	e8 6f f0 ff ff       	call   29ed <dirfile>
    397e:	e8 a1 f2 ff ff       	call   2c24 <iref>
    3983:	e8 d5 f3 ff ff       	call   2d5d <forktest>
    3988:	e8 b4 e1 ff ff       	call   1b41 <bigdir>
    398d:	e8 da cc ff ff       	call   66c <exectest>
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
    3be4:	b8 01 00 00 00       	mov    $0x1,%eax
    3be9:	cd 40                	int    $0x40
    3beb:	c3                   	ret    

00003bec <exit>:
    3bec:	b8 02 00 00 00       	mov    $0x2,%eax
    3bf1:	cd 40                	int    $0x40
    3bf3:	c3                   	ret    

00003bf4 <wait>:
    3bf4:	b8 03 00 00 00       	mov    $0x3,%eax
    3bf9:	cd 40                	int    $0x40
    3bfb:	c3                   	ret    

00003bfc <pipe>:
    3bfc:	b8 04 00 00 00       	mov    $0x4,%eax
    3c01:	cd 40                	int    $0x40
    3c03:	c3                   	ret    

00003c04 <read>:
    3c04:	b8 05 00 00 00       	mov    $0x5,%eax
    3c09:	cd 40                	int    $0x40
    3c0b:	c3                   	ret    

00003c0c <write>:
    3c0c:	b8 10 00 00 00       	mov    $0x10,%eax
    3c11:	cd 40                	int    $0x40
    3c13:	c3                   	ret    

00003c14 <close>:
    3c14:	b8 15 00 00 00       	mov    $0x15,%eax
    3c19:	cd 40                	int    $0x40
    3c1b:	c3                   	ret    

00003c1c <kill>:
    3c1c:	b8 06 00 00 00       	mov    $0x6,%eax
    3c21:	cd 40                	int    $0x40
    3c23:	c3                   	ret    

00003c24 <exec>:
    3c24:	b8 07 00 00 00       	mov    $0x7,%eax
    3c29:	cd 40                	int    $0x40
    3c2b:	c3                   	ret    

00003c2c <open>:
    3c2c:	b8 0f 00 00 00       	mov    $0xf,%eax
    3c31:	cd 40                	int    $0x40
    3c33:	c3                   	ret    

00003c34 <mknod>:
    3c34:	b8 11 00 00 00       	mov    $0x11,%eax
    3c39:	cd 40                	int    $0x40
    3c3b:	c3                   	ret    

00003c3c <unlink>:
    3c3c:	b8 12 00 00 00       	mov    $0x12,%eax
    3c41:	cd 40                	int    $0x40
    3c43:	c3                   	ret    

00003c44 <fstat>:
    3c44:	b8 08 00 00 00       	mov    $0x8,%eax
    3c49:	cd 40                	int    $0x40
    3c4b:	c3                   	ret    

00003c4c <link>:
    3c4c:	b8 13 00 00 00       	mov    $0x13,%eax
    3c51:	cd 40                	int    $0x40
    3c53:	c3                   	ret    

00003c54 <mkdir>:
    3c54:	b8 14 00 00 00       	mov    $0x14,%eax
    3c59:	cd 40                	int    $0x40
    3c5b:	c3                   	ret    

00003c5c <chdir>:
    3c5c:	b8 09 00 00 00       	mov    $0x9,%eax
    3c61:	cd 40                	int    $0x40
    3c63:	c3                   	ret    

00003c64 <dup>:
    3c64:	b8 0a 00 00 00       	mov    $0xa,%eax
    3c69:	cd 40                	int    $0x40
    3c6b:	c3                   	ret    

00003c6c <getpid>:
    3c6c:	b8 0b 00 00 00       	mov    $0xb,%eax
    3c71:	cd 40                	int    $0x40
    3c73:	c3                   	ret    

00003c74 <sbrk>:
    3c74:	b8 0c 00 00 00       	mov    $0xc,%eax
    3c79:	cd 40                	int    $0x40
    3c7b:	c3                   	ret    

00003c7c <sleep>:
    3c7c:	b8 0d 00 00 00       	mov    $0xd,%eax
    3c81:	cd 40                	int    $0x40
    3c83:	c3                   	ret    

00003c84 <uptime>:
    3c84:	b8 0e 00 00 00       	mov    $0xe,%eax
    3c89:	cd 40                	int    $0x40
    3c8b:	c3                   	ret    

00003c8c <getcwd>:
    3c8c:	b8 16 00 00 00       	mov    $0x16,%eax
    3c91:	cd 40                	int    $0x40
    3c93:	c3                   	ret    

00003c94 <ps>:
    3c94:	b8 17 00 00 00       	mov    $0x17,%eax
    3c99:	cd 40                	int    $0x40
    3c9b:	c3                   	ret    

00003c9c <putc>:
    3c9c:	55                   	push   %ebp
    3c9d:	89 e5                	mov    %esp,%ebp
    3c9f:	83 ec 18             	sub    $0x18,%esp
    3ca2:	8b 45 0c             	mov    0xc(%ebp),%eax
    3ca5:	88 45 f4             	mov    %al,-0xc(%ebp)
    3ca8:	83 ec 04             	sub    $0x4,%esp
    3cab:	6a 01                	push   $0x1
    3cad:	8d 45 f4             	lea    -0xc(%ebp),%eax
    3cb0:	50                   	push   %eax
    3cb1:	ff 75 08             	pushl  0x8(%ebp)
    3cb4:	e8 53 ff ff ff       	call   3c0c <write>
    3cb9:	83 c4 10             	add    $0x10,%esp
    3cbc:	c9                   	leave  
    3cbd:	c3                   	ret    

00003cbe <printint>:
    3cbe:	55                   	push   %ebp
    3cbf:	89 e5                	mov    %esp,%ebp
    3cc1:	53                   	push   %ebx
    3cc2:	83 ec 24             	sub    $0x24,%esp
    3cc5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3ccc:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    3cd0:	74 17                	je     3ce9 <printint+0x2b>
    3cd2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    3cd6:	79 11                	jns    3ce9 <printint+0x2b>
    3cd8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    3cdf:	8b 45 0c             	mov    0xc(%ebp),%eax
    3ce2:	f7 d8                	neg    %eax
    3ce4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3ce7:	eb 06                	jmp    3cef <printint+0x31>
    3ce9:	8b 45 0c             	mov    0xc(%ebp),%eax
    3cec:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3cef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3cf6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3cf9:	8d 41 01             	lea    0x1(%ecx),%eax
    3cfc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3cff:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3d02:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3d05:	ba 00 00 00 00       	mov    $0x0,%edx
    3d0a:	f7 f3                	div    %ebx
    3d0c:	89 d0                	mov    %edx,%eax
    3d0e:	0f b6 80 84 5e 00 00 	movzbl 0x5e84(%eax),%eax
    3d15:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    3d19:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3d1c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3d1f:	ba 00 00 00 00       	mov    $0x0,%edx
    3d24:	f7 f3                	div    %ebx
    3d26:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3d29:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3d2d:	75 c7                	jne    3cf6 <printint+0x38>
    3d2f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3d33:	74 0e                	je     3d43 <printint+0x85>
    3d35:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d38:	8d 50 01             	lea    0x1(%eax),%edx
    3d3b:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3d3e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    3d43:	eb 1d                	jmp    3d62 <printint+0xa4>
    3d45:	8d 55 dc             	lea    -0x24(%ebp),%edx
    3d48:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d4b:	01 d0                	add    %edx,%eax
    3d4d:	0f b6 00             	movzbl (%eax),%eax
    3d50:	0f be c0             	movsbl %al,%eax
    3d53:	83 ec 08             	sub    $0x8,%esp
    3d56:	50                   	push   %eax
    3d57:	ff 75 08             	pushl  0x8(%ebp)
    3d5a:	e8 3d ff ff ff       	call   3c9c <putc>
    3d5f:	83 c4 10             	add    $0x10,%esp
    3d62:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    3d66:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3d6a:	79 d9                	jns    3d45 <printint+0x87>
    3d6c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3d6f:	c9                   	leave  
    3d70:	c3                   	ret    

00003d71 <printf>:
    3d71:	55                   	push   %ebp
    3d72:	89 e5                	mov    %esp,%ebp
    3d74:	83 ec 28             	sub    $0x28,%esp
    3d77:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    3d7e:	8d 45 0c             	lea    0xc(%ebp),%eax
    3d81:	83 c0 04             	add    $0x4,%eax
    3d84:	89 45 e8             	mov    %eax,-0x18(%ebp)
    3d87:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3d8e:	e9 59 01 00 00       	jmp    3eec <printf+0x17b>
    3d93:	8b 55 0c             	mov    0xc(%ebp),%edx
    3d96:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3d99:	01 d0                	add    %edx,%eax
    3d9b:	0f b6 00             	movzbl (%eax),%eax
    3d9e:	0f be c0             	movsbl %al,%eax
    3da1:	25 ff 00 00 00       	and    $0xff,%eax
    3da6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    3da9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3dad:	75 2c                	jne    3ddb <printf+0x6a>
    3daf:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    3db3:	75 0c                	jne    3dc1 <printf+0x50>
    3db5:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    3dbc:	e9 27 01 00 00       	jmp    3ee8 <printf+0x177>
    3dc1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3dc4:	0f be c0             	movsbl %al,%eax
    3dc7:	83 ec 08             	sub    $0x8,%esp
    3dca:	50                   	push   %eax
    3dcb:	ff 75 08             	pushl  0x8(%ebp)
    3dce:	e8 c9 fe ff ff       	call   3c9c <putc>
    3dd3:	83 c4 10             	add    $0x10,%esp
    3dd6:	e9 0d 01 00 00       	jmp    3ee8 <printf+0x177>
    3ddb:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    3ddf:	0f 85 03 01 00 00    	jne    3ee8 <printf+0x177>
    3de5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    3de9:	75 1e                	jne    3e09 <printf+0x98>
    3deb:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3dee:	8b 00                	mov    (%eax),%eax
    3df0:	6a 01                	push   $0x1
    3df2:	6a 0a                	push   $0xa
    3df4:	50                   	push   %eax
    3df5:	ff 75 08             	pushl  0x8(%ebp)
    3df8:	e8 c1 fe ff ff       	call   3cbe <printint>
    3dfd:	83 c4 10             	add    $0x10,%esp
    3e00:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3e04:	e9 d8 00 00 00       	jmp    3ee1 <printf+0x170>
    3e09:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    3e0d:	74 06                	je     3e15 <printf+0xa4>
    3e0f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    3e13:	75 1e                	jne    3e33 <printf+0xc2>
    3e15:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3e18:	8b 00                	mov    (%eax),%eax
    3e1a:	6a 00                	push   $0x0
    3e1c:	6a 10                	push   $0x10
    3e1e:	50                   	push   %eax
    3e1f:	ff 75 08             	pushl  0x8(%ebp)
    3e22:	e8 97 fe ff ff       	call   3cbe <printint>
    3e27:	83 c4 10             	add    $0x10,%esp
    3e2a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3e2e:	e9 ae 00 00 00       	jmp    3ee1 <printf+0x170>
    3e33:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    3e37:	75 43                	jne    3e7c <printf+0x10b>
    3e39:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3e3c:	8b 00                	mov    (%eax),%eax
    3e3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3e41:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3e45:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3e49:	75 07                	jne    3e52 <printf+0xe1>
    3e4b:	c7 45 f4 ea 57 00 00 	movl   $0x57ea,-0xc(%ebp)
    3e52:	eb 1c                	jmp    3e70 <printf+0xff>
    3e54:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e57:	0f b6 00             	movzbl (%eax),%eax
    3e5a:	0f be c0             	movsbl %al,%eax
    3e5d:	83 ec 08             	sub    $0x8,%esp
    3e60:	50                   	push   %eax
    3e61:	ff 75 08             	pushl  0x8(%ebp)
    3e64:	e8 33 fe ff ff       	call   3c9c <putc>
    3e69:	83 c4 10             	add    $0x10,%esp
    3e6c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3e70:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e73:	0f b6 00             	movzbl (%eax),%eax
    3e76:	84 c0                	test   %al,%al
    3e78:	75 da                	jne    3e54 <printf+0xe3>
    3e7a:	eb 65                	jmp    3ee1 <printf+0x170>
    3e7c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    3e80:	75 1d                	jne    3e9f <printf+0x12e>
    3e82:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3e85:	8b 00                	mov    (%eax),%eax
    3e87:	0f be c0             	movsbl %al,%eax
    3e8a:	83 ec 08             	sub    $0x8,%esp
    3e8d:	50                   	push   %eax
    3e8e:	ff 75 08             	pushl  0x8(%ebp)
    3e91:	e8 06 fe ff ff       	call   3c9c <putc>
    3e96:	83 c4 10             	add    $0x10,%esp
    3e99:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3e9d:	eb 42                	jmp    3ee1 <printf+0x170>
    3e9f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    3ea3:	75 17                	jne    3ebc <printf+0x14b>
    3ea5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3ea8:	0f be c0             	movsbl %al,%eax
    3eab:	83 ec 08             	sub    $0x8,%esp
    3eae:	50                   	push   %eax
    3eaf:	ff 75 08             	pushl  0x8(%ebp)
    3eb2:	e8 e5 fd ff ff       	call   3c9c <putc>
    3eb7:	83 c4 10             	add    $0x10,%esp
    3eba:	eb 25                	jmp    3ee1 <printf+0x170>
    3ebc:	83 ec 08             	sub    $0x8,%esp
    3ebf:	6a 25                	push   $0x25
    3ec1:	ff 75 08             	pushl  0x8(%ebp)
    3ec4:	e8 d3 fd ff ff       	call   3c9c <putc>
    3ec9:	83 c4 10             	add    $0x10,%esp
    3ecc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3ecf:	0f be c0             	movsbl %al,%eax
    3ed2:	83 ec 08             	sub    $0x8,%esp
    3ed5:	50                   	push   %eax
    3ed6:	ff 75 08             	pushl  0x8(%ebp)
    3ed9:	e8 be fd ff ff       	call   3c9c <putc>
    3ede:	83 c4 10             	add    $0x10,%esp
    3ee1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    3ee8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3eec:	8b 55 0c             	mov    0xc(%ebp),%edx
    3eef:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3ef2:	01 d0                	add    %edx,%eax
    3ef4:	0f b6 00             	movzbl (%eax),%eax
    3ef7:	84 c0                	test   %al,%al
    3ef9:	0f 85 94 fe ff ff    	jne    3d93 <printf+0x22>
    3eff:	c9                   	leave  
    3f00:	c3                   	ret    

00003f01 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3f01:	55                   	push   %ebp
    3f02:	89 e5                	mov    %esp,%ebp
    3f04:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3f07:	8b 45 08             	mov    0x8(%ebp),%eax
    3f0a:	83 e8 08             	sub    $0x8,%eax
    3f0d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3f10:	a1 48 5f 00 00       	mov    0x5f48,%eax
    3f15:	89 45 fc             	mov    %eax,-0x4(%ebp)
    3f18:	eb 24                	jmp    3f3e <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3f1a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f1d:	8b 00                	mov    (%eax),%eax
    3f1f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3f22:	77 12                	ja     3f36 <free+0x35>
    3f24:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f27:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3f2a:	77 24                	ja     3f50 <free+0x4f>
    3f2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f2f:	8b 00                	mov    (%eax),%eax
    3f31:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    3f34:	77 1a                	ja     3f50 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3f36:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f39:	8b 00                	mov    (%eax),%eax
    3f3b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    3f3e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f41:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3f44:	76 d4                	jbe    3f1a <free+0x19>
    3f46:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f49:	8b 00                	mov    (%eax),%eax
    3f4b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    3f4e:	76 ca                	jbe    3f1a <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    3f50:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f53:	8b 40 04             	mov    0x4(%eax),%eax
    3f56:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    3f5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f60:	01 c2                	add    %eax,%edx
    3f62:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f65:	8b 00                	mov    (%eax),%eax
    3f67:	39 c2                	cmp    %eax,%edx
    3f69:	75 24                	jne    3f8f <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    3f6b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f6e:	8b 50 04             	mov    0x4(%eax),%edx
    3f71:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f74:	8b 00                	mov    (%eax),%eax
    3f76:	8b 40 04             	mov    0x4(%eax),%eax
    3f79:	01 c2                	add    %eax,%edx
    3f7b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f7e:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    3f81:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f84:	8b 00                	mov    (%eax),%eax
    3f86:	8b 10                	mov    (%eax),%edx
    3f88:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f8b:	89 10                	mov    %edx,(%eax)
    3f8d:	eb 0a                	jmp    3f99 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    3f8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f92:	8b 10                	mov    (%eax),%edx
    3f94:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f97:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    3f99:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f9c:	8b 40 04             	mov    0x4(%eax),%eax
    3f9f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    3fa6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fa9:	01 d0                	add    %edx,%eax
    3fab:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    3fae:	75 20                	jne    3fd0 <free+0xcf>
    p->s.size += bp->s.size;
    3fb0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fb3:	8b 50 04             	mov    0x4(%eax),%edx
    3fb6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fb9:	8b 40 04             	mov    0x4(%eax),%eax
    3fbc:	01 c2                	add    %eax,%edx
    3fbe:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fc1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3fc4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fc7:	8b 10                	mov    (%eax),%edx
    3fc9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fcc:	89 10                	mov    %edx,(%eax)
    3fce:	eb 08                	jmp    3fd8 <free+0xd7>
  } else
    p->s.ptr = bp;
    3fd0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fd3:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3fd6:	89 10                	mov    %edx,(%eax)
  freep = p;
    3fd8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fdb:	a3 48 5f 00 00       	mov    %eax,0x5f48
}
    3fe0:	c9                   	leave  
    3fe1:	c3                   	ret    

00003fe2 <morecore>:

static Header*
morecore(uint nu)
{
    3fe2:	55                   	push   %ebp
    3fe3:	89 e5                	mov    %esp,%ebp
    3fe5:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    3fe8:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    3fef:	77 07                	ja     3ff8 <morecore+0x16>
    nu = 4096;
    3ff1:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    3ff8:	8b 45 08             	mov    0x8(%ebp),%eax
    3ffb:	c1 e0 03             	shl    $0x3,%eax
    3ffe:	83 ec 0c             	sub    $0xc,%esp
    4001:	50                   	push   %eax
    4002:	e8 6d fc ff ff       	call   3c74 <sbrk>
    4007:	83 c4 10             	add    $0x10,%esp
    400a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    400d:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    4011:	75 07                	jne    401a <morecore+0x38>
    return 0;
    4013:	b8 00 00 00 00       	mov    $0x0,%eax
    4018:	eb 26                	jmp    4040 <morecore+0x5e>
  hp = (Header*)p;
    401a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    401d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    4020:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4023:	8b 55 08             	mov    0x8(%ebp),%edx
    4026:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    4029:	8b 45 f0             	mov    -0x10(%ebp),%eax
    402c:	83 c0 08             	add    $0x8,%eax
    402f:	83 ec 0c             	sub    $0xc,%esp
    4032:	50                   	push   %eax
    4033:	e8 c9 fe ff ff       	call   3f01 <free>
    4038:	83 c4 10             	add    $0x10,%esp
  return freep;
    403b:	a1 48 5f 00 00       	mov    0x5f48,%eax
}
    4040:	c9                   	leave  
    4041:	c3                   	ret    

00004042 <malloc>:

void*
malloc(uint nbytes)
{
    4042:	55                   	push   %ebp
    4043:	89 e5                	mov    %esp,%ebp
    4045:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4048:	8b 45 08             	mov    0x8(%ebp),%eax
    404b:	83 c0 07             	add    $0x7,%eax
    404e:	c1 e8 03             	shr    $0x3,%eax
    4051:	83 c0 01             	add    $0x1,%eax
    4054:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    4057:	a1 48 5f 00 00       	mov    0x5f48,%eax
    405c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    405f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4063:	75 23                	jne    4088 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    4065:	c7 45 f0 40 5f 00 00 	movl   $0x5f40,-0x10(%ebp)
    406c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    406f:	a3 48 5f 00 00       	mov    %eax,0x5f48
    4074:	a1 48 5f 00 00       	mov    0x5f48,%eax
    4079:	a3 40 5f 00 00       	mov    %eax,0x5f40
    base.s.size = 0;
    407e:	c7 05 44 5f 00 00 00 	movl   $0x0,0x5f44
    4085:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4088:	8b 45 f0             	mov    -0x10(%ebp),%eax
    408b:	8b 00                	mov    (%eax),%eax
    408d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    4090:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4093:	8b 40 04             	mov    0x4(%eax),%eax
    4096:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    4099:	72 4d                	jb     40e8 <malloc+0xa6>
      if(p->s.size == nunits)
    409b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    409e:	8b 40 04             	mov    0x4(%eax),%eax
    40a1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    40a4:	75 0c                	jne    40b2 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    40a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40a9:	8b 10                	mov    (%eax),%edx
    40ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
    40ae:	89 10                	mov    %edx,(%eax)
    40b0:	eb 26                	jmp    40d8 <malloc+0x96>
      else {
        p->s.size -= nunits;
    40b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40b5:	8b 40 04             	mov    0x4(%eax),%eax
    40b8:	2b 45 ec             	sub    -0x14(%ebp),%eax
    40bb:	89 c2                	mov    %eax,%edx
    40bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40c0:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    40c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40c6:	8b 40 04             	mov    0x4(%eax),%eax
    40c9:	c1 e0 03             	shl    $0x3,%eax
    40cc:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    40cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40d2:	8b 55 ec             	mov    -0x14(%ebp),%edx
    40d5:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    40d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    40db:	a3 48 5f 00 00       	mov    %eax,0x5f48
      return (void*)(p + 1);
    40e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40e3:	83 c0 08             	add    $0x8,%eax
    40e6:	eb 3b                	jmp    4123 <malloc+0xe1>
    }
    if(p == freep)
    40e8:	a1 48 5f 00 00       	mov    0x5f48,%eax
    40ed:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    40f0:	75 1e                	jne    4110 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    40f2:	83 ec 0c             	sub    $0xc,%esp
    40f5:	ff 75 ec             	pushl  -0x14(%ebp)
    40f8:	e8 e5 fe ff ff       	call   3fe2 <morecore>
    40fd:	83 c4 10             	add    $0x10,%esp
    4100:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4103:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4107:	75 07                	jne    4110 <malloc+0xce>
        return 0;
    4109:	b8 00 00 00 00       	mov    $0x0,%eax
    410e:	eb 13                	jmp    4123 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4110:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4113:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4116:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4119:	8b 00                	mov    (%eax),%eax
    411b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    411e:	e9 6d ff ff ff       	jmp    4090 <malloc+0x4e>
}
    4123:	c9                   	leave  
    4124:	c3                   	ret    
