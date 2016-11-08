
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 05                	jne    11 <runcmd+0x11>
    exit();
       c:	e8 2d 15 00 00       	call   153e <exit>
  
  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 9c 1a 00 00 	mov    0x1a9c(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 70 1a 00 00       	push   $0x1a70
      2c:	e8 dc 09 00 00       	call   a0d <panic>
      31:	83 c4 10             	add    $0x10,%esp

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      34:	8b 45 08             	mov    0x8(%ebp),%eax
      37:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ecmd->argv[0] == 0)
      3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
      3d:	8b 40 04             	mov    0x4(%eax),%eax
      40:	85 c0                	test   %eax,%eax
      42:	75 05                	jne    49 <runcmd+0x49>
      exit();
      44:	e8 f5 14 00 00       	call   153e <exit>
    exec(ecmd->argv[0], ecmd->argv);
      49:	8b 45 f4             	mov    -0xc(%ebp),%eax
      4c:	8d 50 04             	lea    0x4(%eax),%edx
      4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      52:	8b 40 04             	mov    0x4(%eax),%eax
      55:	83 ec 08             	sub    $0x8,%esp
      58:	52                   	push   %edx
      59:	50                   	push   %eax
      5a:	e8 17 15 00 00       	call   1576 <exec>
      5f:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      62:	8b 45 f4             	mov    -0xc(%ebp),%eax
      65:	8b 40 04             	mov    0x4(%eax),%eax
      68:	83 ec 04             	sub    $0x4,%esp
      6b:	50                   	push   %eax
      6c:	68 77 1a 00 00       	push   $0x1a77
      71:	6a 02                	push   $0x2
      73:	e8 43 16 00 00       	call   16bb <printf>
      78:	83 c4 10             	add    $0x10,%esp
    break;
      7b:	e9 c8 01 00 00       	jmp    248 <runcmd+0x248>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      80:	8b 45 08             	mov    0x8(%ebp),%eax
      83:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(rcmd->fd);
      86:	8b 45 f0             	mov    -0x10(%ebp),%eax
      89:	8b 40 14             	mov    0x14(%eax),%eax
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	50                   	push   %eax
      90:	e8 d1 14 00 00       	call   1566 <close>
      95:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
      98:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9b:	8b 50 10             	mov    0x10(%eax),%edx
      9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
      a1:	8b 40 08             	mov    0x8(%eax),%eax
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	52                   	push   %edx
      a8:	50                   	push   %eax
      a9:	e8 d0 14 00 00       	call   157e <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	85 c0                	test   %eax,%eax
      b3:	79 1e                	jns    d3 <runcmd+0xd3>
      printf(2, "open %s failed\n", rcmd->file);
      b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
      b8:	8b 40 08             	mov    0x8(%eax),%eax
      bb:	83 ec 04             	sub    $0x4,%esp
      be:	50                   	push   %eax
      bf:	68 87 1a 00 00       	push   $0x1a87
      c4:	6a 02                	push   $0x2
      c6:	e8 f0 15 00 00       	call   16bb <printf>
      cb:	83 c4 10             	add    $0x10,%esp
      exit();
      ce:	e8 6b 14 00 00       	call   153e <exit>
    }
    runcmd(rcmd->cmd);
      d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
      d6:	8b 40 04             	mov    0x4(%eax),%eax
      d9:	83 ec 0c             	sub    $0xc,%esp
      dc:	50                   	push   %eax
      dd:	e8 1e ff ff ff       	call   0 <runcmd>
      e2:	83 c4 10             	add    $0x10,%esp
    break;
      e5:	e9 5e 01 00 00       	jmp    248 <runcmd+0x248>

  case LIST:
    lcmd = (struct listcmd*)cmd;
      ea:	8b 45 08             	mov    0x8(%ebp),%eax
      ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fork1() == 0)
      f0:	e8 38 09 00 00       	call   a2d <fork1>
      f5:	85 c0                	test   %eax,%eax
      f7:	75 12                	jne    10b <runcmd+0x10b>
      runcmd(lcmd->left);
      f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
      fc:	8b 40 04             	mov    0x4(%eax),%eax
      ff:	83 ec 0c             	sub    $0xc,%esp
     102:	50                   	push   %eax
     103:	e8 f8 fe ff ff       	call   0 <runcmd>
     108:	83 c4 10             	add    $0x10,%esp
    wait();
     10b:	e8 36 14 00 00       	call   1546 <wait>
    runcmd(lcmd->right);
     110:	8b 45 ec             	mov    -0x14(%ebp),%eax
     113:	8b 40 08             	mov    0x8(%eax),%eax
     116:	83 ec 0c             	sub    $0xc,%esp
     119:	50                   	push   %eax
     11a:	e8 e1 fe ff ff       	call   0 <runcmd>
     11f:	83 c4 10             	add    $0x10,%esp
    break;
     122:	e9 21 01 00 00       	jmp    248 <runcmd+0x248>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     127:	8b 45 08             	mov    0x8(%ebp),%eax
     12a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pipe(p) < 0)
     12d:	83 ec 0c             	sub    $0xc,%esp
     130:	8d 45 dc             	lea    -0x24(%ebp),%eax
     133:	50                   	push   %eax
     134:	e8 15 14 00 00       	call   154e <pipe>
     139:	83 c4 10             	add    $0x10,%esp
     13c:	85 c0                	test   %eax,%eax
     13e:	79 10                	jns    150 <runcmd+0x150>
      panic("pipe");
     140:	83 ec 0c             	sub    $0xc,%esp
     143:	68 97 1a 00 00       	push   $0x1a97
     148:	e8 c0 08 00 00       	call   a0d <panic>
     14d:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
     150:	e8 d8 08 00 00       	call   a2d <fork1>
     155:	85 c0                	test   %eax,%eax
     157:	75 4c                	jne    1a5 <runcmd+0x1a5>
      close(1);
     159:	83 ec 0c             	sub    $0xc,%esp
     15c:	6a 01                	push   $0x1
     15e:	e8 03 14 00 00       	call   1566 <close>
     163:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
     166:	8b 45 e0             	mov    -0x20(%ebp),%eax
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	50                   	push   %eax
     16d:	e8 44 14 00 00       	call   15b6 <dup>
     172:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     175:	8b 45 dc             	mov    -0x24(%ebp),%eax
     178:	83 ec 0c             	sub    $0xc,%esp
     17b:	50                   	push   %eax
     17c:	e8 e5 13 00 00       	call   1566 <close>
     181:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     184:	8b 45 e0             	mov    -0x20(%ebp),%eax
     187:	83 ec 0c             	sub    $0xc,%esp
     18a:	50                   	push   %eax
     18b:	e8 d6 13 00 00       	call   1566 <close>
     190:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->left);
     193:	8b 45 e8             	mov    -0x18(%ebp),%eax
     196:	8b 40 04             	mov    0x4(%eax),%eax
     199:	83 ec 0c             	sub    $0xc,%esp
     19c:	50                   	push   %eax
     19d:	e8 5e fe ff ff       	call   0 <runcmd>
     1a2:	83 c4 10             	add    $0x10,%esp
    }
    if(fork1() == 0){
     1a5:	e8 83 08 00 00       	call   a2d <fork1>
     1aa:	85 c0                	test   %eax,%eax
     1ac:	75 4c                	jne    1fa <runcmd+0x1fa>
      close(0);
     1ae:	83 ec 0c             	sub    $0xc,%esp
     1b1:	6a 00                	push   $0x0
     1b3:	e8 ae 13 00 00       	call   1566 <close>
     1b8:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
     1bb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1be:	83 ec 0c             	sub    $0xc,%esp
     1c1:	50                   	push   %eax
     1c2:	e8 ef 13 00 00       	call   15b6 <dup>
     1c7:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     1ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1cd:	83 ec 0c             	sub    $0xc,%esp
     1d0:	50                   	push   %eax
     1d1:	e8 90 13 00 00       	call   1566 <close>
     1d6:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     1d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1dc:	83 ec 0c             	sub    $0xc,%esp
     1df:	50                   	push   %eax
     1e0:	e8 81 13 00 00       	call   1566 <close>
     1e5:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->right);
     1e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     1eb:	8b 40 08             	mov    0x8(%eax),%eax
     1ee:	83 ec 0c             	sub    $0xc,%esp
     1f1:	50                   	push   %eax
     1f2:	e8 09 fe ff ff       	call   0 <runcmd>
     1f7:	83 c4 10             	add    $0x10,%esp
    }
    close(p[0]);
     1fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1fd:	83 ec 0c             	sub    $0xc,%esp
     200:	50                   	push   %eax
     201:	e8 60 13 00 00       	call   1566 <close>
     206:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
     209:	8b 45 e0             	mov    -0x20(%ebp),%eax
     20c:	83 ec 0c             	sub    $0xc,%esp
     20f:	50                   	push   %eax
     210:	e8 51 13 00 00       	call   1566 <close>
     215:	83 c4 10             	add    $0x10,%esp
    wait();
     218:	e8 29 13 00 00       	call   1546 <wait>
    wait();
     21d:	e8 24 13 00 00       	call   1546 <wait>
    break;
     222:	eb 24                	jmp    248 <runcmd+0x248>
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
     224:	8b 45 08             	mov    0x8(%ebp),%eax
     227:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(fork1() == 0)
     22a:	e8 fe 07 00 00       	call   a2d <fork1>
     22f:	85 c0                	test   %eax,%eax
     231:	75 14                	jne    247 <runcmd+0x247>
      runcmd(bcmd->cmd);
     233:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     236:	8b 40 04             	mov    0x4(%eax),%eax
     239:	83 ec 0c             	sub    $0xc,%esp
     23c:	50                   	push   %eax
     23d:	e8 be fd ff ff       	call   0 <runcmd>
     242:	83 c4 10             	add    $0x10,%esp
    break;
     245:	eb 00                	jmp    247 <runcmd+0x247>
     247:	90                   	nop
  }
  exit();
     248:	e8 f1 12 00 00       	call   153e <exit>

0000024d <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     24d:	55                   	push   %ebp
     24e:	89 e5                	mov    %esp,%ebp
     250:	83 ec 08             	sub    $0x8,%esp
  printf(2, "$ ");
     253:	83 ec 08             	sub    $0x8,%esp
     256:	68 b4 1a 00 00       	push   $0x1ab4
     25b:	6a 02                	push   $0x2
     25d:	e8 59 14 00 00       	call   16bb <printf>
     262:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     265:	8b 45 0c             	mov    0xc(%ebp),%eax
     268:	83 ec 04             	sub    $0x4,%esp
     26b:	50                   	push   %eax
     26c:	6a 00                	push   $0x0
     26e:	ff 75 08             	pushl  0x8(%ebp)
     271:	e8 2e 11 00 00       	call   13a4 <memset>
     276:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     279:	83 ec 08             	sub    $0x8,%esp
     27c:	ff 75 0c             	pushl  0xc(%ebp)
     27f:	ff 75 08             	pushl  0x8(%ebp)
     282:	e8 6a 11 00 00       	call   13f1 <gets>
     287:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     28a:	8b 45 08             	mov    0x8(%ebp),%eax
     28d:	0f b6 00             	movzbl (%eax),%eax
     290:	84 c0                	test   %al,%al
     292:	75 07                	jne    29b <getcmd+0x4e>
    return -1;
     294:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     299:	eb 05                	jmp    2a0 <getcmd+0x53>
  return 0;
     29b:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2a0:	c9                   	leave  
     2a1:	c3                   	ret    

000002a2 <historyOut>:
//prints out history when called
int historyOut(char **history, int histNum)
{
     2a2:	55                   	push   %ebp
     2a3:	89 e5                	mov    %esp,%ebp
     2a5:	83 ec 28             	sub    $0x28,%esp
int tempNum = histNum - 1; 
     2a8:	8b 45 0c             	mov    0xc(%ebp),%eax
     2ab:	83 e8 01             	sub    $0x1,%eax
     2ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
int currLoc = tempNum % MAX_HISTORY; //current location in array
     2b1:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     2b4:	ba 67 66 66 66       	mov    $0x66666667,%edx
     2b9:	89 c8                	mov    %ecx,%eax
     2bb:	f7 ea                	imul   %edx
     2bd:	c1 fa 02             	sar    $0x2,%edx
     2c0:	89 c8                	mov    %ecx,%eax
     2c2:	c1 f8 1f             	sar    $0x1f,%eax
     2c5:	29 c2                	sub    %eax,%edx
     2c7:	89 d0                	mov    %edx,%eax
     2c9:	c1 e0 02             	shl    $0x2,%eax
     2cc:	01 d0                	add    %edx,%eax
     2ce:	01 c0                	add    %eax,%eax
     2d0:	29 c1                	sub    %eax,%ecx
     2d2:	89 c8                	mov    %ecx,%eax
     2d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
int lineNum = histNum; //keeps track of the number assigned to the history val.
     2d7:	8b 45 0c             	mov    0xc(%ebp),%eax
     2da:	89 45 f0             	mov    %eax,-0x10(%ebp)
int i;

if(histNum <= 10)
     2dd:	83 7d 0c 0a          	cmpl   $0xa,0xc(%ebp)
     2e1:	7f 58                	jg     33b <historyOut+0x99>
{
	for(i = currLoc; i>=0; i--)
     2e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
     2e9:	eb 45                	jmp    330 <historyOut+0x8e>
	{
		printf(2, "%d ", lineNum);
     2eb:	83 ec 04             	sub    $0x4,%esp
     2ee:	ff 75 f0             	pushl  -0x10(%ebp)
     2f1:	68 b7 1a 00 00       	push   $0x1ab7
     2f6:	6a 02                	push   $0x2
     2f8:	e8 be 13 00 00       	call   16bb <printf>
     2fd:	83 c4 10             	add    $0x10,%esp
		printf(2, "%s \n", history[currLoc]);
     300:	8b 45 f4             	mov    -0xc(%ebp),%eax
     303:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     30a:	8b 45 08             	mov    0x8(%ebp),%eax
     30d:	01 d0                	add    %edx,%eax
     30f:	8b 00                	mov    (%eax),%eax
     311:	83 ec 04             	sub    $0x4,%esp
     314:	50                   	push   %eax
     315:	68 bb 1a 00 00       	push   $0x1abb
     31a:	6a 02                	push   $0x2
     31c:	e8 9a 13 00 00       	call   16bb <printf>
     321:	83 c4 10             	add    $0x10,%esp
		currLoc--;
     324:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
		lineNum--;
     328:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
int lineNum = histNum; //keeps track of the number assigned to the history val.
int i;

if(histNum <= 10)
{
	for(i = currLoc; i>=0; i--)
     32c:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
     330:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     334:	79 b5                	jns    2eb <historyOut+0x49>
     336:	e9 a8 00 00 00       	jmp    3e3 <historyOut+0x141>
	}
}

else
{
	int border = 8 - currLoc; //offsets for wraparound
     33b:	b8 08 00 00 00       	mov    $0x8,%eax
     340:	2b 45 f4             	sub    -0xc(%ebp),%eax
     343:	89 45 e8             	mov    %eax,-0x18(%ebp)
	while(currLoc >= 0)
     346:	eb 41                	jmp    389 <historyOut+0xe7>
	{
		printf(2, "%d ", lineNum);
     348:	83 ec 04             	sub    $0x4,%esp
     34b:	ff 75 f0             	pushl  -0x10(%ebp)
     34e:	68 b7 1a 00 00       	push   $0x1ab7
     353:	6a 02                	push   $0x2
     355:	e8 61 13 00 00       	call   16bb <printf>
     35a:	83 c4 10             	add    $0x10,%esp
		printf(2, "%s \n", history[currLoc]);
     35d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     360:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     367:	8b 45 08             	mov    0x8(%ebp),%eax
     36a:	01 d0                	add    %edx,%eax
     36c:	8b 00                	mov    (%eax),%eax
     36e:	83 ec 04             	sub    $0x4,%esp
     371:	50                   	push   %eax
     372:	68 bb 1a 00 00       	push   $0x1abb
     377:	6a 02                	push   $0x2
     379:	e8 3d 13 00 00       	call   16bb <printf>
     37e:	83 c4 10             	add    $0x10,%esp
		currLoc--;
     381:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
		lineNum--;
     385:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
}

else
{
	int border = 8 - currLoc; //offsets for wraparound
	while(currLoc >= 0)
     389:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     38d:	79 b9                	jns    348 <historyOut+0xa6>
		printf(2, "%d ", lineNum);
		printf(2, "%s \n", history[currLoc]);
		currLoc--;
		lineNum--;
	}
	currLoc = 9;
     38f:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%ebp)

	while(border >= 0)
     396:	eb 45                	jmp    3dd <historyOut+0x13b>
	{
		printf(2, "%d ", lineNum);
     398:	83 ec 04             	sub    $0x4,%esp
     39b:	ff 75 f0             	pushl  -0x10(%ebp)
     39e:	68 b7 1a 00 00       	push   $0x1ab7
     3a3:	6a 02                	push   $0x2
     3a5:	e8 11 13 00 00       	call   16bb <printf>
     3aa:	83 c4 10             	add    $0x10,%esp
		printf(2, "%s \n", history[currLoc]);
     3ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3b0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     3b7:	8b 45 08             	mov    0x8(%ebp),%eax
     3ba:	01 d0                	add    %edx,%eax
     3bc:	8b 00                	mov    (%eax),%eax
     3be:	83 ec 04             	sub    $0x4,%esp
     3c1:	50                   	push   %eax
     3c2:	68 bb 1a 00 00       	push   $0x1abb
     3c7:	6a 02                	push   $0x2
     3c9:	e8 ed 12 00 00       	call   16bb <printf>
     3ce:	83 c4 10             	add    $0x10,%esp
		currLoc--;
     3d1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
		lineNum--;
     3d5:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
		border--;
     3d9:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
		currLoc--;
		lineNum--;
	}
	currLoc = 9;

	while(border >= 0)
     3dd:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     3e1:	79 b5                	jns    398 <historyOut+0xf6>
		currLoc--;
		lineNum--;
		border--;
	}
}
return histNum;
     3e3:	8b 45 0c             	mov    0xc(%ebp),%eax
}
     3e6:	c9                   	leave  
     3e7:	c3                   	ret    

000003e8 <historyUpdate>:
//adds values to the history when called
int historyUpdate(char **history, char *enteredArgs, int histNum)
{
     3e8:	55                   	push   %ebp
     3e9:	89 e5                	mov    %esp,%ebp
     3eb:	83 ec 18             	sub    $0x18,%esp
int tempNum2 = histNum++;
     3ee:	8b 45 10             	mov    0x10(%ebp),%eax
     3f1:	8d 50 01             	lea    0x1(%eax),%edx
     3f4:	89 55 10             	mov    %edx,0x10(%ebp)
     3f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
int index = tempNum2 % MAX_HISTORY;
     3fa:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3fd:	ba 67 66 66 66       	mov    $0x66666667,%edx
     402:	89 c8                	mov    %ecx,%eax
     404:	f7 ea                	imul   %edx
     406:	c1 fa 02             	sar    $0x2,%edx
     409:	89 c8                	mov    %ecx,%eax
     40b:	c1 f8 1f             	sar    $0x1f,%eax
     40e:	29 c2                	sub    %eax,%edx
     410:	89 d0                	mov    %edx,%eax
     412:	c1 e0 02             	shl    $0x2,%eax
     415:	01 d0                	add    %edx,%eax
     417:	01 c0                	add    %eax,%eax
     419:	29 c1                	sub    %eax,%ecx
     41b:	89 c8                	mov    %ecx,%eax
     41d:	89 45 f0             	mov    %eax,-0x10(%ebp)
strcpy(history[index], enteredArgs);
     420:	8b 45 f0             	mov    -0x10(%ebp),%eax
     423:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     42a:	8b 45 08             	mov    0x8(%ebp),%eax
     42d:	01 d0                	add    %edx,%eax
     42f:	8b 00                	mov    (%eax),%eax
     431:	83 ec 08             	sub    $0x8,%esp
     434:	ff 75 0c             	pushl  0xc(%ebp)
     437:	50                   	push   %eax
     438:	e8 d1 0e 00 00       	call   130e <strcpy>
     43d:	83 c4 10             	add    $0x10,%esp
return histNum;
     440:	8b 45 10             	mov    0x10(%ebp),%eax
}
     443:	c9                   	leave  
     444:	c3                   	ret    

00000445 <lastHistory>:
//returns the string of the last value entered that was stored in history
char* lastHistory(char **history, char* buffer, int histNum)
{
     445:	55                   	push   %ebp
     446:	89 e5                	mov    %esp,%ebp
     448:	83 ec 18             	sub    $0x18,%esp
	int index = (histNum - 1) % 10;
     44b:	8b 45 10             	mov    0x10(%ebp),%eax
     44e:	8d 48 ff             	lea    -0x1(%eax),%ecx
     451:	ba 67 66 66 66       	mov    $0x66666667,%edx
     456:	89 c8                	mov    %ecx,%eax
     458:	f7 ea                	imul   %edx
     45a:	c1 fa 02             	sar    $0x2,%edx
     45d:	89 c8                	mov    %ecx,%eax
     45f:	c1 f8 1f             	sar    $0x1f,%eax
     462:	29 c2                	sub    %eax,%edx
     464:	89 d0                	mov    %edx,%eax
     466:	89 45 f4             	mov    %eax,-0xc(%ebp)
     469:	8b 55 f4             	mov    -0xc(%ebp),%edx
     46c:	89 d0                	mov    %edx,%eax
     46e:	c1 e0 02             	shl    $0x2,%eax
     471:	01 d0                	add    %edx,%eax
     473:	01 c0                	add    %eax,%eax
     475:	29 c1                	sub    %eax,%ecx
     477:	89 c8                	mov    %ecx,%eax
     479:	89 45 f4             	mov    %eax,-0xc(%ebp)
        strcpy(buffer, history[index]);
     47c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     47f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     486:	8b 45 08             	mov    0x8(%ebp),%eax
     489:	01 d0                	add    %edx,%eax
     48b:	8b 00                	mov    (%eax),%eax
     48d:	83 ec 08             	sub    $0x8,%esp
     490:	50                   	push   %eax
     491:	ff 75 0c             	pushl  0xc(%ebp)
     494:	e8 75 0e 00 00       	call   130e <strcpy>
     499:	83 c4 10             	add    $0x10,%esp
	printf(2, "%s\n", buffer);
     49c:	83 ec 04             	sub    $0x4,%esp
     49f:	ff 75 0c             	pushl  0xc(%ebp)
     4a2:	68 c0 1a 00 00       	push   $0x1ac0
     4a7:	6a 02                	push   $0x2
     4a9:	e8 0d 12 00 00       	call   16bb <printf>
     4ae:	83 c4 10             	add    $0x10,%esp
	return buffer;
     4b1:	8b 45 0c             	mov    0xc(%ebp),%eax
}
     4b4:	c9                   	leave  
     4b5:	c3                   	ret    

000004b6 <chooseFromHistory>:
//returns the string of the value stored at the historyIndex entered by the user
//following !
char* chooseFromHistory(char** history, int histNum, int historyIndex)
{
     4b6:	55                   	push   %ebp
     4b7:	89 e5                	mov    %esp,%ebp
     4b9:	83 ec 18             	sub    $0x18,%esp
int index = historyIndex-1 % 10;
     4bc:	8b 45 10             	mov    0x10(%ebp),%eax
     4bf:	83 e8 01             	sub    $0x1,%eax
     4c2:	89 45 f4             	mov    %eax,-0xc(%ebp)

printf(2, "%d: ", historyIndex);
     4c5:	83 ec 04             	sub    $0x4,%esp
     4c8:	ff 75 10             	pushl  0x10(%ebp)
     4cb:	68 c4 1a 00 00       	push   $0x1ac4
     4d0:	6a 02                	push   $0x2
     4d2:	e8 e4 11 00 00       	call   16bb <printf>
     4d7:	83 c4 10             	add    $0x10,%esp
printf(2, "%s\n", history[index]);
     4da:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     4e4:	8b 45 08             	mov    0x8(%ebp),%eax
     4e7:	01 d0                	add    %edx,%eax
     4e9:	8b 00                	mov    (%eax),%eax
     4eb:	83 ec 04             	sub    $0x4,%esp
     4ee:	50                   	push   %eax
     4ef:	68 c0 1a 00 00       	push   $0x1ac0
     4f4:	6a 02                	push   $0x2
     4f6:	e8 c0 11 00 00       	call   16bb <printf>
     4fb:	83 c4 10             	add    $0x10,%esp
return history[index];
     4fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     501:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     508:	8b 45 08             	mov    0x8(%ebp),%eax
     50b:	01 d0                	add    %edx,%eax
     50d:	8b 00                	mov    (%eax),%eax
}
     50f:	c9                   	leave  
     510:	c3                   	ret    

00000511 <digCheck>:
//implemented my own check since isdigit can't be imported here
int digCheck(char num)
{
     511:	55                   	push   %ebp
     512:	89 e5                	mov    %esp,%ebp
     514:	83 ec 04             	sub    $0x4,%esp
     517:	8b 45 08             	mov    0x8(%ebp),%eax
     51a:	88 45 fc             	mov    %al,-0x4(%ebp)
	if(num == '0')
     51d:	80 7d fc 30          	cmpb   $0x30,-0x4(%ebp)
     521:	75 07                	jne    52a <digCheck+0x19>
	return 1;
     523:	b8 01 00 00 00       	mov    $0x1,%eax
     528:	eb 7a                	jmp    5a4 <digCheck+0x93>
	else if(num == '1')
     52a:	80 7d fc 31          	cmpb   $0x31,-0x4(%ebp)
     52e:	75 07                	jne    537 <digCheck+0x26>
	return 1;
     530:	b8 01 00 00 00       	mov    $0x1,%eax
     535:	eb 6d                	jmp    5a4 <digCheck+0x93>
	else if(num == '2')
     537:	80 7d fc 32          	cmpb   $0x32,-0x4(%ebp)
     53b:	75 07                	jne    544 <digCheck+0x33>
	return 1;
     53d:	b8 01 00 00 00       	mov    $0x1,%eax
     542:	eb 60                	jmp    5a4 <digCheck+0x93>
	else if(num == '3')
     544:	80 7d fc 33          	cmpb   $0x33,-0x4(%ebp)
     548:	75 07                	jne    551 <digCheck+0x40>
	return 1;
     54a:	b8 01 00 00 00       	mov    $0x1,%eax
     54f:	eb 53                	jmp    5a4 <digCheck+0x93>
	else if(num == '4')
     551:	80 7d fc 34          	cmpb   $0x34,-0x4(%ebp)
     555:	75 07                	jne    55e <digCheck+0x4d>
	return 1;
     557:	b8 01 00 00 00       	mov    $0x1,%eax
     55c:	eb 46                	jmp    5a4 <digCheck+0x93>
	else if(num == '5')
     55e:	80 7d fc 35          	cmpb   $0x35,-0x4(%ebp)
     562:	75 07                	jne    56b <digCheck+0x5a>
	return 1;
     564:	b8 01 00 00 00       	mov    $0x1,%eax
     569:	eb 39                	jmp    5a4 <digCheck+0x93>
	else if(num == '6')
     56b:	80 7d fc 36          	cmpb   $0x36,-0x4(%ebp)
     56f:	75 07                	jne    578 <digCheck+0x67>
	return 1;
     571:	b8 01 00 00 00       	mov    $0x1,%eax
     576:	eb 2c                	jmp    5a4 <digCheck+0x93>
	else if(num == '7')
     578:	80 7d fc 37          	cmpb   $0x37,-0x4(%ebp)
     57c:	75 07                	jne    585 <digCheck+0x74>
	return 1;
     57e:	b8 01 00 00 00       	mov    $0x1,%eax
     583:	eb 1f                	jmp    5a4 <digCheck+0x93>
	else if(num == '8')
     585:	80 7d fc 38          	cmpb   $0x38,-0x4(%ebp)
     589:	75 07                	jne    592 <digCheck+0x81>
	return 1;
     58b:	b8 01 00 00 00       	mov    $0x1,%eax
     590:	eb 12                	jmp    5a4 <digCheck+0x93>
	else if(num == '9')
     592:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
     596:	75 07                	jne    59f <digCheck+0x8e>
	return 1;
     598:	b8 01 00 00 00       	mov    $0x1,%eax
     59d:	eb 05                	jmp    5a4 <digCheck+0x93>
	return 0;
     59f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     5a4:	c9                   	leave  
     5a5:	c3                   	ret    

000005a6 <convertDigit>:
//changes the char to an int since sscanf can't be used here
int convertDigit(char num)
{
     5a6:	55                   	push   %ebp
     5a7:	89 e5                	mov    %esp,%ebp
     5a9:	83 ec 04             	sub    $0x4,%esp
     5ac:	8b 45 08             	mov    0x8(%ebp),%eax
     5af:	88 45 fc             	mov    %al,-0x4(%ebp)
	if(num == '0')
     5b2:	80 7d fc 30          	cmpb   $0x30,-0x4(%ebp)
     5b6:	75 07                	jne    5bf <convertDigit+0x19>
	return 0;
     5b8:	b8 00 00 00 00       	mov    $0x0,%eax
     5bd:	eb 6d                	jmp    62c <convertDigit+0x86>
	else if(num == '1')
     5bf:	80 7d fc 31          	cmpb   $0x31,-0x4(%ebp)
     5c3:	75 07                	jne    5cc <convertDigit+0x26>
	return 1;
     5c5:	b8 01 00 00 00       	mov    $0x1,%eax
     5ca:	eb 60                	jmp    62c <convertDigit+0x86>
	else if(num == '2')
     5cc:	80 7d fc 32          	cmpb   $0x32,-0x4(%ebp)
     5d0:	75 07                	jne    5d9 <convertDigit+0x33>
	return 2;
     5d2:	b8 02 00 00 00       	mov    $0x2,%eax
     5d7:	eb 53                	jmp    62c <convertDigit+0x86>
	else if(num == '3')
     5d9:	80 7d fc 33          	cmpb   $0x33,-0x4(%ebp)
     5dd:	75 07                	jne    5e6 <convertDigit+0x40>
	return 3;
     5df:	b8 03 00 00 00       	mov    $0x3,%eax
     5e4:	eb 46                	jmp    62c <convertDigit+0x86>
	else if(num == '4')
     5e6:	80 7d fc 34          	cmpb   $0x34,-0x4(%ebp)
     5ea:	75 07                	jne    5f3 <convertDigit+0x4d>
	return 4;
     5ec:	b8 04 00 00 00       	mov    $0x4,%eax
     5f1:	eb 39                	jmp    62c <convertDigit+0x86>
	else if(num == '5')
     5f3:	80 7d fc 35          	cmpb   $0x35,-0x4(%ebp)
     5f7:	75 07                	jne    600 <convertDigit+0x5a>
	return 5;
     5f9:	b8 05 00 00 00       	mov    $0x5,%eax
     5fe:	eb 2c                	jmp    62c <convertDigit+0x86>
	else if(num == '6')
     600:	80 7d fc 36          	cmpb   $0x36,-0x4(%ebp)
     604:	75 07                	jne    60d <convertDigit+0x67>
	return 6;
     606:	b8 06 00 00 00       	mov    $0x6,%eax
     60b:	eb 1f                	jmp    62c <convertDigit+0x86>
	else if(num == '7')
     60d:	80 7d fc 37          	cmpb   $0x37,-0x4(%ebp)
     611:	75 07                	jne    61a <convertDigit+0x74>
	return 7;
     613:	b8 07 00 00 00       	mov    $0x7,%eax
     618:	eb 12                	jmp    62c <convertDigit+0x86>
	else if(num == '8')
     61a:	80 7d fc 38          	cmpb   $0x38,-0x4(%ebp)
     61e:	75 07                	jne    627 <convertDigit+0x81>
	return 8;
     620:	b8 08 00 00 00       	mov    $0x8,%eax
     625:	eb 05                	jmp    62c <convertDigit+0x86>
	else return 9;
     627:	b8 09 00 00 00       	mov    $0x9,%eax
}
     62c:	c9                   	leave  
     62d:	c3                   	ret    

0000062e <main>:

int
main(void)
{
     62e:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     632:	83 e4 f0             	and    $0xfffffff0,%esp
     635:	ff 71 fc             	pushl  -0x4(%ecx)
     638:	55                   	push   %ebp
     639:	89 e5                	mov    %esp,%ebp
     63b:	53                   	push   %ebx
     63c:	51                   	push   %ecx
     63d:	83 ec 20             	sub    $0x20,%esp
  static char buf[100];
  int fd;
  char** history;
  int histNum;
  history = malloc(100 * sizeof(char *));
     640:	83 ec 0c             	sub    $0xc,%esp
     643:	68 90 01 00 00       	push   $0x190
     648:	e8 3f 13 00 00       	call   198c <malloc>
     64d:	83 c4 10             	add    $0x10,%esp
     650:	89 45 e8             	mov    %eax,-0x18(%ebp)
  int i;
  
for(i = 0; i< 100; i++)
     653:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     65a:	eb 37                	jmp    693 <main+0x65>
{
history[i] = malloc(100 * sizeof(char));
     65c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     65f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     666:	8b 45 e8             	mov    -0x18(%ebp),%eax
     669:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
     66c:	83 ec 0c             	sub    $0xc,%esp
     66f:	6a 64                	push   $0x64
     671:	e8 16 13 00 00       	call   198c <malloc>
     676:	83 c4 10             	add    $0x10,%esp
     679:	89 03                	mov    %eax,(%ebx)
history[i][0] = '\0';
     67b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     67e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     685:	8b 45 e8             	mov    -0x18(%ebp),%eax
     688:	01 d0                	add    %edx,%eax
     68a:	8b 00                	mov    (%eax),%eax
     68c:	c6 00 00             	movb   $0x0,(%eax)
  char** history;
  int histNum;
  history = malloc(100 * sizeof(char *));
  int i;
  
for(i = 0; i< 100; i++)
     68f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     693:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
     697:	7e c3                	jle    65c <main+0x2e>
history[i] = malloc(100 * sizeof(char));
history[i][0] = '\0';
}
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     699:	eb 16                	jmp    6b1 <main+0x83>
    if(fd >= 3){
     69b:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
     69f:	7e 10                	jle    6b1 <main+0x83>
      close(fd);
     6a1:	83 ec 0c             	sub    $0xc,%esp
     6a4:	ff 75 e4             	pushl  -0x1c(%ebp)
     6a7:	e8 ba 0e 00 00       	call   1566 <close>
     6ac:	83 c4 10             	add    $0x10,%esp
      break;
     6af:	eb 1b                	jmp    6cc <main+0x9e>
history[i] = malloc(100 * sizeof(char));
history[i][0] = '\0';
}
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     6b1:	83 ec 08             	sub    $0x8,%esp
     6b4:	6a 02                	push   $0x2
     6b6:	68 c9 1a 00 00       	push   $0x1ac9
     6bb:	e8 be 0e 00 00       	call   157e <open>
     6c0:	83 c4 10             	add    $0x10,%esp
     6c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     6c6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     6ca:	79 cf                	jns    69b <main+0x6d>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     6cc:	e9 1d 03 00 00       	jmp    9ee <main+0x3c0>
	buf[strlen(buf) - 1] =0;
     6d1:	83 ec 0c             	sub    $0xc,%esp
     6d4:	68 40 21 00 00       	push   $0x2140
     6d9:	e8 9f 0c 00 00       	call   137d <strlen>
     6de:	83 c4 10             	add    $0x10,%esp
     6e1:	83 e8 01             	sub    $0x1,%eax
     6e4:	c6 80 40 21 00 00 00 	movb   $0x0,0x2140(%eax)
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     6eb:	0f b6 05 40 21 00 00 	movzbl 0x2140,%eax
     6f2:	3c 63                	cmp    $0x63,%al
     6f4:	75 60                	jne    756 <main+0x128>
     6f6:	0f b6 05 41 21 00 00 	movzbl 0x2141,%eax
     6fd:	3c 64                	cmp    $0x64,%al
     6ff:	75 55                	jne    756 <main+0x128>
     701:	0f b6 05 42 21 00 00 	movzbl 0x2142,%eax
     708:	3c 20                	cmp    $0x20,%al
     70a:	75 4a                	jne    756 <main+0x128>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     70c:	83 ec 0c             	sub    $0xc,%esp
     70f:	68 40 21 00 00       	push   $0x2140
     714:	e8 64 0c 00 00       	call   137d <strlen>
     719:	83 c4 10             	add    $0x10,%esp
     71c:	83 e8 01             	sub    $0x1,%eax
     71f:	c6 80 40 21 00 00 00 	movb   $0x0,0x2140(%eax)
      if(chdir(buf+3) < 0)
     726:	83 ec 0c             	sub    $0xc,%esp
     729:	68 43 21 00 00       	push   $0x2143
     72e:	e8 7b 0e 00 00       	call   15ae <chdir>
     733:	83 c4 10             	add    $0x10,%esp
     736:	85 c0                	test   %eax,%eax
     738:	79 17                	jns    751 <main+0x123>
        printf(2, "cannot cd %s\n", buf+3);
     73a:	83 ec 04             	sub    $0x4,%esp
     73d:	68 43 21 00 00       	push   $0x2143
     742:	68 d1 1a 00 00       	push   $0x1ad1
     747:	6a 02                	push   $0x2
     749:	e8 6d 0f 00 00       	call   16bb <printf>
     74e:	83 c4 10             	add    $0x10,%esp
      continue;
     751:	e9 98 02 00 00       	jmp    9ee <main+0x3c0>
    }
    char* temp = &buf[0];
     756:	c7 45 e0 40 21 00 00 	movl   $0x2140,-0x20(%ebp)
    
    //runs historyOut to print history
    if(strcmp(buf, "history")== 0)
     75d:	83 ec 08             	sub    $0x8,%esp
     760:	68 df 1a 00 00       	push   $0x1adf
     765:	68 40 21 00 00       	push   $0x2140
     76a:	e8 cf 0b 00 00       	call   133e <strcmp>
     76f:	83 c4 10             	add    $0x10,%esp
     772:	85 c0                	test   %eax,%eax
     774:	75 30                	jne    7a6 <main+0x178>
    {
	if(histNum < 1)
     776:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     77a:	7f 14                	jg     790 <main+0x162>
		printf(1, "No commands in history\n");
     77c:	83 ec 08             	sub    $0x8,%esp
     77f:	68 e7 1a 00 00       	push   $0x1ae7
     784:	6a 01                	push   $0x1
     786:	e8 30 0f 00 00       	call   16bb <printf>
     78b:	83 c4 10             	add    $0x10,%esp
     78e:	eb 11                	jmp    7a1 <main+0x173>
	else
	historyOut(history, histNum);
     790:	83 ec 08             	sub    $0x8,%esp
     793:	ff 75 f4             	pushl  -0xc(%ebp)
     796:	ff 75 e8             	pushl  -0x18(%ebp)
     799:	e8 04 fb ff ff       	call   2a2 <historyOut>
     79e:	83 c4 10             	add    $0x10,%esp
	continue;
     7a1:	e9 48 02 00 00       	jmp    9ee <main+0x3c0>
    }
    //calls lastHistory to rerun the last command entered
    if(strcmp(buf, "!!") == 0)
     7a6:	83 ec 08             	sub    $0x8,%esp
     7a9:	68 ff 1a 00 00       	push   $0x1aff
     7ae:	68 40 21 00 00       	push   $0x2140
     7b3:	e8 86 0b 00 00       	call   133e <strcmp>
     7b8:	83 c4 10             	add    $0x10,%esp
     7bb:	85 c0                	test   %eax,%eax
     7bd:	0f 85 89 00 00 00    	jne    84c <main+0x21e>
    {
	if(histNum < 1)
     7c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7c7:	7f 14                	jg     7dd <main+0x1af>
		printf(1, "No commands in history\n");
     7c9:	83 ec 08             	sub    $0x8,%esp
     7cc:	68 e7 1a 00 00       	push   $0x1ae7
     7d1:	6a 01                	push   $0x1
     7d3:	e8 e3 0e 00 00       	call   16bb <printf>
     7d8:	83 c4 10             	add    $0x10,%esp
     7db:	eb 6a                	jmp    847 <main+0x219>
	else
	{
	strcpy(buf,lastHistory(history, buf, histNum));
     7dd:	83 ec 04             	sub    $0x4,%esp
     7e0:	ff 75 f4             	pushl  -0xc(%ebp)
     7e3:	68 40 21 00 00       	push   $0x2140
     7e8:	ff 75 e8             	pushl  -0x18(%ebp)
     7eb:	e8 55 fc ff ff       	call   445 <lastHistory>
     7f0:	83 c4 10             	add    $0x10,%esp
     7f3:	83 ec 08             	sub    $0x8,%esp
     7f6:	50                   	push   %eax
     7f7:	68 40 21 00 00       	push   $0x2140
     7fc:	e8 0d 0b 00 00       	call   130e <strcpy>
     801:	83 c4 10             	add    $0x10,%esp
	histNum = historyUpdate(history, buf, histNum);
     804:	83 ec 04             	sub    $0x4,%esp
     807:	ff 75 f4             	pushl  -0xc(%ebp)
     80a:	68 40 21 00 00       	push   $0x2140
     80f:	ff 75 e8             	pushl  -0x18(%ebp)
     812:	e8 d1 fb ff ff       	call   3e8 <historyUpdate>
     817:	83 c4 10             	add    $0x10,%esp
     81a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if(fork1() == 0)
     81d:	e8 0b 02 00 00       	call   a2d <fork1>
     822:	85 c0                	test   %eax,%eax
     824:	75 1c                	jne    842 <main+0x214>
	{	
	runcmd(parsecmd(buf));
     826:	83 ec 0c             	sub    $0xc,%esp
     829:	68 40 21 00 00       	push   $0x2140
     82e:	e8 4e 05 00 00       	call   d81 <parsecmd>
     833:	83 c4 10             	add    $0x10,%esp
     836:	83 ec 0c             	sub    $0xc,%esp
     839:	50                   	push   %eax
     83a:	e8 c1 f7 ff ff       	call   0 <runcmd>
     83f:	83 c4 10             	add    $0x10,%esp
	}
	wait();
     842:	e8 ff 0c 00 00       	call   1546 <wait>
	}
	continue;
     847:	e9 a2 01 00 00       	jmp    9ee <main+0x3c0>
    }
    //determines the value entered after ! and calls chooseFromHistory with that value
    if(buf[0] == '!' && buf[1] != '!')
     84c:	0f b6 05 40 21 00 00 	movzbl 0x2140,%eax
     853:	3c 21                	cmp    $0x21,%al
     855:	0f 85 52 01 00 00    	jne    9ad <main+0x37f>
     85b:	0f b6 05 41 21 00 00 	movzbl 0x2141,%eax
     862:	3c 21                	cmp    $0x21,%al
     864:	0f 84 43 01 00 00    	je     9ad <main+0x37f>
    {
	if(digCheck(buf[1]))
     86a:	0f b6 05 41 21 00 00 	movzbl 0x2141,%eax
     871:	0f be c0             	movsbl %al,%eax
     874:	83 ec 0c             	sub    $0xc,%esp
     877:	50                   	push   %eax
     878:	e8 94 fc ff ff       	call   511 <digCheck>
     87d:	83 c4 10             	add    $0x10,%esp
     880:	85 c0                	test   %eax,%eax
     882:	0f 84 11 01 00 00    	je     999 <main+0x36b>
	{
		int test = 0;
     888:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		if(digCheck(buf[2])){test = 10*convertDigit(buf[1]) + convertDigit(buf[2]);}
     88f:	0f b6 05 42 21 00 00 	movzbl 0x2142,%eax
     896:	0f be c0             	movsbl %al,%eax
     899:	83 ec 0c             	sub    $0xc,%esp
     89c:	50                   	push   %eax
     89d:	e8 6f fc ff ff       	call   511 <digCheck>
     8a2:	83 c4 10             	add    $0x10,%esp
     8a5:	85 c0                	test   %eax,%eax
     8a7:	74 40                	je     8e9 <main+0x2bb>
     8a9:	0f b6 05 41 21 00 00 	movzbl 0x2141,%eax
     8b0:	0f be c0             	movsbl %al,%eax
     8b3:	83 ec 0c             	sub    $0xc,%esp
     8b6:	50                   	push   %eax
     8b7:	e8 ea fc ff ff       	call   5a6 <convertDigit>
     8bc:	83 c4 10             	add    $0x10,%esp
     8bf:	89 c2                	mov    %eax,%edx
     8c1:	89 d0                	mov    %edx,%eax
     8c3:	c1 e0 02             	shl    $0x2,%eax
     8c6:	01 d0                	add    %edx,%eax
     8c8:	01 c0                	add    %eax,%eax
     8ca:	89 c3                	mov    %eax,%ebx
     8cc:	0f b6 05 42 21 00 00 	movzbl 0x2142,%eax
     8d3:	0f be c0             	movsbl %al,%eax
     8d6:	83 ec 0c             	sub    $0xc,%esp
     8d9:	50                   	push   %eax
     8da:	e8 c7 fc ff ff       	call   5a6 <convertDigit>
     8df:	83 c4 10             	add    $0x10,%esp
     8e2:	01 d8                	add    %ebx,%eax
     8e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
     8e7:	eb 19                	jmp    902 <main+0x2d4>
		else test = convertDigit(buf[1]);
     8e9:	0f b6 05 41 21 00 00 	movzbl 0x2141,%eax
     8f0:	0f be c0             	movsbl %al,%eax
     8f3:	83 ec 0c             	sub    $0xc,%esp
     8f6:	50                   	push   %eax
     8f7:	e8 aa fc ff ff       	call   5a6 <convertDigit>
     8fc:	83 c4 10             	add    $0x10,%esp
     8ff:	89 45 ec             	mov    %eax,-0x14(%ebp)
		
			if(test > 0 && test <= histNum && test > histNum - 10)
     902:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     906:	7e 7d                	jle    985 <main+0x357>
     908:	8b 45 ec             	mov    -0x14(%ebp),%eax
     90b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     90e:	7f 75                	jg     985 <main+0x357>
     910:	8b 45 f4             	mov    -0xc(%ebp),%eax
     913:	83 e8 0a             	sub    $0xa,%eax
     916:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     919:	7d 6a                	jge    985 <main+0x357>
			{
				strcpy(buf, chooseFromHistory(history, histNum, test));
     91b:	83 ec 04             	sub    $0x4,%esp
     91e:	ff 75 ec             	pushl  -0x14(%ebp)
     921:	ff 75 f4             	pushl  -0xc(%ebp)
     924:	ff 75 e8             	pushl  -0x18(%ebp)
     927:	e8 8a fb ff ff       	call   4b6 <chooseFromHistory>
     92c:	83 c4 10             	add    $0x10,%esp
     92f:	83 ec 08             	sub    $0x8,%esp
     932:	50                   	push   %eax
     933:	68 40 21 00 00       	push   $0x2140
     938:	e8 d1 09 00 00       	call   130e <strcpy>
     93d:	83 c4 10             	add    $0x10,%esp
				histNum = historyUpdate(history, buf, histNum);
     940:	83 ec 04             	sub    $0x4,%esp
     943:	ff 75 f4             	pushl  -0xc(%ebp)
     946:	68 40 21 00 00       	push   $0x2140
     94b:	ff 75 e8             	pushl  -0x18(%ebp)
     94e:	e8 95 fa ff ff       	call   3e8 <historyUpdate>
     953:	83 c4 10             	add    $0x10,%esp
     956:	89 45 f4             	mov    %eax,-0xc(%ebp)
				if(fork1() == 0)
     959:	e8 cf 00 00 00       	call   a2d <fork1>
     95e:	85 c0                	test   %eax,%eax
     960:	75 1c                	jne    97e <main+0x350>
				{
				runcmd(parsecmd(buf));
     962:	83 ec 0c             	sub    $0xc,%esp
     965:	68 40 21 00 00       	push   $0x2140
     96a:	e8 12 04 00 00       	call   d81 <parsecmd>
     96f:	83 c4 10             	add    $0x10,%esp
     972:	83 ec 0c             	sub    $0xc,%esp
     975:	50                   	push   %eax
     976:	e8 85 f6 ff ff       	call   0 <runcmd>
     97b:	83 c4 10             	add    $0x10,%esp
				}
				wait();
     97e:	e8 c3 0b 00 00       	call   1546 <wait>
     983:	eb 12                	jmp    997 <main+0x369>
			}
			else
			printf(1, "This value is not in the history.\n");
     985:	83 ec 08             	sub    $0x8,%esp
     988:	68 04 1b 00 00       	push   $0x1b04
     98d:	6a 01                	push   $0x1
     98f:	e8 27 0d 00 00       	call   16bb <printf>
     994:	83 c4 10             	add    $0x10,%esp

		continue;
     997:	eb 55                	jmp    9ee <main+0x3c0>
	}
	else {printf(1, "Error incorrect format");
     999:	83 ec 08             	sub    $0x8,%esp
     99c:	68 27 1b 00 00       	push   $0x1b27
     9a1:	6a 01                	push   $0x1
     9a3:	e8 13 0d 00 00       	call   16bb <printf>
     9a8:	83 c4 10             	add    $0x10,%esp
	continue;}
     9ab:	eb 41                	jmp    9ee <main+0x3c0>
    }
    //defaults and runs the command on xv6
    else{
    histNum = historyUpdate(history, temp, histNum);
     9ad:	83 ec 04             	sub    $0x4,%esp
     9b0:	ff 75 f4             	pushl  -0xc(%ebp)
     9b3:	ff 75 e0             	pushl  -0x20(%ebp)
     9b6:	ff 75 e8             	pushl  -0x18(%ebp)
     9b9:	e8 2a fa ff ff       	call   3e8 <historyUpdate>
     9be:	83 c4 10             	add    $0x10,%esp
     9c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(fork1() == 0)
     9c4:	e8 64 00 00 00       	call   a2d <fork1>
     9c9:	85 c0                	test   %eax,%eax
     9cb:	75 1c                	jne    9e9 <main+0x3bb>
    {
      runcmd(parsecmd(buf));
     9cd:	83 ec 0c             	sub    $0xc,%esp
     9d0:	68 40 21 00 00       	push   $0x2140
     9d5:	e8 a7 03 00 00       	call   d81 <parsecmd>
     9da:	83 c4 10             	add    $0x10,%esp
     9dd:	83 ec 0c             	sub    $0xc,%esp
     9e0:	50                   	push   %eax
     9e1:	e8 1a f6 ff ff       	call   0 <runcmd>
     9e6:	83 c4 10             	add    $0x10,%esp
    }
    wait();
     9e9:	e8 58 0b 00 00       	call   1546 <wait>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     9ee:	83 ec 08             	sub    $0x8,%esp
     9f1:	6a 64                	push   $0x64
     9f3:	68 40 21 00 00       	push   $0x2140
     9f8:	e8 50 f8 ff ff       	call   24d <getcmd>
     9fd:	83 c4 10             	add    $0x10,%esp
     a00:	85 c0                	test   %eax,%eax
     a02:	0f 89 c9 fc ff ff    	jns    6d1 <main+0xa3>
    {
      runcmd(parsecmd(buf));
    }
    wait();
  }}
  exit();
     a08:	e8 31 0b 00 00       	call   153e <exit>

00000a0d <panic>:
}

void
panic(char *s)
{
     a0d:	55                   	push   %ebp
     a0e:	89 e5                	mov    %esp,%ebp
     a10:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     a13:	83 ec 04             	sub    $0x4,%esp
     a16:	ff 75 08             	pushl  0x8(%ebp)
     a19:	68 c0 1a 00 00       	push   $0x1ac0
     a1e:	6a 02                	push   $0x2
     a20:	e8 96 0c 00 00       	call   16bb <printf>
     a25:	83 c4 10             	add    $0x10,%esp
  exit();
     a28:	e8 11 0b 00 00       	call   153e <exit>

00000a2d <fork1>:
}

int
fork1(void)
{
     a2d:	55                   	push   %ebp
     a2e:	89 e5                	mov    %esp,%ebp
     a30:	83 ec 18             	sub    $0x18,%esp
  int pid;
  
  pid = fork();
     a33:	e8 fe 0a 00 00       	call   1536 <fork>
     a38:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     a3b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     a3f:	75 10                	jne    a51 <fork1+0x24>
    panic("fork");
     a41:	83 ec 0c             	sub    $0xc,%esp
     a44:	68 3e 1b 00 00       	push   $0x1b3e
     a49:	e8 bf ff ff ff       	call   a0d <panic>
     a4e:	83 c4 10             	add    $0x10,%esp
  return pid;
     a51:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     a54:	c9                   	leave  
     a55:	c3                   	ret    

00000a56 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     a56:	55                   	push   %ebp
     a57:	89 e5                	mov    %esp,%ebp
     a59:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     a5c:	83 ec 0c             	sub    $0xc,%esp
     a5f:	6a 54                	push   $0x54
     a61:	e8 26 0f 00 00       	call   198c <malloc>
     a66:	83 c4 10             	add    $0x10,%esp
     a69:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     a6c:	83 ec 04             	sub    $0x4,%esp
     a6f:	6a 54                	push   $0x54
     a71:	6a 00                	push   $0x0
     a73:	ff 75 f4             	pushl  -0xc(%ebp)
     a76:	e8 29 09 00 00       	call   13a4 <memset>
     a7b:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     a7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a81:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     a87:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     a8a:	c9                   	leave  
     a8b:	c3                   	ret    

00000a8c <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     a8c:	55                   	push   %ebp
     a8d:	89 e5                	mov    %esp,%ebp
     a8f:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     a92:	83 ec 0c             	sub    $0xc,%esp
     a95:	6a 18                	push   $0x18
     a97:	e8 f0 0e 00 00       	call   198c <malloc>
     a9c:	83 c4 10             	add    $0x10,%esp
     a9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     aa2:	83 ec 04             	sub    $0x4,%esp
     aa5:	6a 18                	push   $0x18
     aa7:	6a 00                	push   $0x0
     aa9:	ff 75 f4             	pushl  -0xc(%ebp)
     aac:	e8 f3 08 00 00       	call   13a4 <memset>
     ab1:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab7:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     abd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac0:	8b 55 08             	mov    0x8(%ebp),%edx
     ac3:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     ac6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac9:	8b 55 0c             	mov    0xc(%ebp),%edx
     acc:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     acf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad2:	8b 55 10             	mov    0x10(%ebp),%edx
     ad5:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     ad8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     adb:	8b 55 14             	mov    0x14(%ebp),%edx
     ade:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     ae1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae4:	8b 55 18             	mov    0x18(%ebp),%edx
     ae7:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     aea:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     aed:	c9                   	leave  
     aee:	c3                   	ret    

00000aef <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     aef:	55                   	push   %ebp
     af0:	89 e5                	mov    %esp,%ebp
     af2:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     af5:	83 ec 0c             	sub    $0xc,%esp
     af8:	6a 0c                	push   $0xc
     afa:	e8 8d 0e 00 00       	call   198c <malloc>
     aff:	83 c4 10             	add    $0x10,%esp
     b02:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     b05:	83 ec 04             	sub    $0x4,%esp
     b08:	6a 0c                	push   $0xc
     b0a:	6a 00                	push   $0x0
     b0c:	ff 75 f4             	pushl  -0xc(%ebp)
     b0f:	e8 90 08 00 00       	call   13a4 <memset>
     b14:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     b17:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b1a:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     b20:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b23:	8b 55 08             	mov    0x8(%ebp),%edx
     b26:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     b29:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b2c:	8b 55 0c             	mov    0xc(%ebp),%edx
     b2f:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     b32:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     b35:	c9                   	leave  
     b36:	c3                   	ret    

00000b37 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     b37:	55                   	push   %ebp
     b38:	89 e5                	mov    %esp,%ebp
     b3a:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     b3d:	83 ec 0c             	sub    $0xc,%esp
     b40:	6a 0c                	push   $0xc
     b42:	e8 45 0e 00 00       	call   198c <malloc>
     b47:	83 c4 10             	add    $0x10,%esp
     b4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     b4d:	83 ec 04             	sub    $0x4,%esp
     b50:	6a 0c                	push   $0xc
     b52:	6a 00                	push   $0x0
     b54:	ff 75 f4             	pushl  -0xc(%ebp)
     b57:	e8 48 08 00 00       	call   13a4 <memset>
     b5c:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     b5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b62:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     b68:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b6b:	8b 55 08             	mov    0x8(%ebp),%edx
     b6e:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     b71:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b74:	8b 55 0c             	mov    0xc(%ebp),%edx
     b77:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     b7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     b7d:	c9                   	leave  
     b7e:	c3                   	ret    

00000b7f <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     b7f:	55                   	push   %ebp
     b80:	89 e5                	mov    %esp,%ebp
     b82:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     b85:	83 ec 0c             	sub    $0xc,%esp
     b88:	6a 08                	push   $0x8
     b8a:	e8 fd 0d 00 00       	call   198c <malloc>
     b8f:	83 c4 10             	add    $0x10,%esp
     b92:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     b95:	83 ec 04             	sub    $0x4,%esp
     b98:	6a 08                	push   $0x8
     b9a:	6a 00                	push   $0x0
     b9c:	ff 75 f4             	pushl  -0xc(%ebp)
     b9f:	e8 00 08 00 00       	call   13a4 <memset>
     ba4:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     ba7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     baa:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     bb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb3:	8b 55 08             	mov    0x8(%ebp),%edx
     bb6:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     bb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bbc:	c9                   	leave  
     bbd:	c3                   	ret    

00000bbe <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     bbe:	55                   	push   %ebp
     bbf:	89 e5                	mov    %esp,%ebp
     bc1:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;
  
  s = *ps;
     bc4:	8b 45 08             	mov    0x8(%ebp),%eax
     bc7:	8b 00                	mov    (%eax),%eax
     bc9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     bcc:	eb 04                	jmp    bd2 <gettoken+0x14>
    s++;
     bce:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     bd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd5:	3b 45 0c             	cmp    0xc(%ebp),%eax
     bd8:	73 1e                	jae    bf8 <gettoken+0x3a>
     bda:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bdd:	0f b6 00             	movzbl (%eax),%eax
     be0:	0f be c0             	movsbl %al,%eax
     be3:	83 ec 08             	sub    $0x8,%esp
     be6:	50                   	push   %eax
     be7:	68 20 21 00 00       	push   $0x2120
     bec:	e8 cd 07 00 00       	call   13be <strchr>
     bf1:	83 c4 10             	add    $0x10,%esp
     bf4:	85 c0                	test   %eax,%eax
     bf6:	75 d6                	jne    bce <gettoken+0x10>
    s++;
  if(q)
     bf8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     bfc:	74 08                	je     c06 <gettoken+0x48>
    *q = s;
     bfe:	8b 45 10             	mov    0x10(%ebp),%eax
     c01:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c04:	89 10                	mov    %edx,(%eax)
  ret = *s;
     c06:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c09:	0f b6 00             	movzbl (%eax),%eax
     c0c:	0f be c0             	movsbl %al,%eax
     c0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     c12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c15:	0f b6 00             	movzbl (%eax),%eax
     c18:	0f be c0             	movsbl %al,%eax
     c1b:	83 f8 29             	cmp    $0x29,%eax
     c1e:	7f 14                	jg     c34 <gettoken+0x76>
     c20:	83 f8 28             	cmp    $0x28,%eax
     c23:	7d 28                	jge    c4d <gettoken+0x8f>
     c25:	85 c0                	test   %eax,%eax
     c27:	0f 84 96 00 00 00    	je     cc3 <gettoken+0x105>
     c2d:	83 f8 26             	cmp    $0x26,%eax
     c30:	74 1b                	je     c4d <gettoken+0x8f>
     c32:	eb 3c                	jmp    c70 <gettoken+0xb2>
     c34:	83 f8 3e             	cmp    $0x3e,%eax
     c37:	74 1a                	je     c53 <gettoken+0x95>
     c39:	83 f8 3e             	cmp    $0x3e,%eax
     c3c:	7f 0a                	jg     c48 <gettoken+0x8a>
     c3e:	83 e8 3b             	sub    $0x3b,%eax
     c41:	83 f8 01             	cmp    $0x1,%eax
     c44:	77 2a                	ja     c70 <gettoken+0xb2>
     c46:	eb 05                	jmp    c4d <gettoken+0x8f>
     c48:	83 f8 7c             	cmp    $0x7c,%eax
     c4b:	75 23                	jne    c70 <gettoken+0xb2>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     c4d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     c51:	eb 71                	jmp    cc4 <gettoken+0x106>
  case '>':
    s++;
     c53:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     c57:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5a:	0f b6 00             	movzbl (%eax),%eax
     c5d:	3c 3e                	cmp    $0x3e,%al
     c5f:	75 0d                	jne    c6e <gettoken+0xb0>
      ret = '+';
     c61:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     c68:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     c6c:	eb 56                	jmp    cc4 <gettoken+0x106>
     c6e:	eb 54                	jmp    cc4 <gettoken+0x106>
  default:
    ret = 'a';
     c70:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     c77:	eb 04                	jmp    c7d <gettoken+0xbf>
      s++;
     c79:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     c7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c80:	3b 45 0c             	cmp    0xc(%ebp),%eax
     c83:	73 3c                	jae    cc1 <gettoken+0x103>
     c85:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c88:	0f b6 00             	movzbl (%eax),%eax
     c8b:	0f be c0             	movsbl %al,%eax
     c8e:	83 ec 08             	sub    $0x8,%esp
     c91:	50                   	push   %eax
     c92:	68 20 21 00 00       	push   $0x2120
     c97:	e8 22 07 00 00       	call   13be <strchr>
     c9c:	83 c4 10             	add    $0x10,%esp
     c9f:	85 c0                	test   %eax,%eax
     ca1:	75 1e                	jne    cc1 <gettoken+0x103>
     ca3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca6:	0f b6 00             	movzbl (%eax),%eax
     ca9:	0f be c0             	movsbl %al,%eax
     cac:	83 ec 08             	sub    $0x8,%esp
     caf:	50                   	push   %eax
     cb0:	68 26 21 00 00       	push   $0x2126
     cb5:	e8 04 07 00 00       	call   13be <strchr>
     cba:	83 c4 10             	add    $0x10,%esp
     cbd:	85 c0                	test   %eax,%eax
     cbf:	74 b8                	je     c79 <gettoken+0xbb>
      s++;
    break;
     cc1:	eb 01                	jmp    cc4 <gettoken+0x106>
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
     cc3:	90                   	nop
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     cc4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     cc8:	74 08                	je     cd2 <gettoken+0x114>
    *eq = s;
     cca:	8b 45 14             	mov    0x14(%ebp),%eax
     ccd:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cd0:	89 10                	mov    %edx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     cd2:	eb 04                	jmp    cd8 <gettoken+0x11a>
    s++;
     cd4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     cd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cdb:	3b 45 0c             	cmp    0xc(%ebp),%eax
     cde:	73 1e                	jae    cfe <gettoken+0x140>
     ce0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ce3:	0f b6 00             	movzbl (%eax),%eax
     ce6:	0f be c0             	movsbl %al,%eax
     ce9:	83 ec 08             	sub    $0x8,%esp
     cec:	50                   	push   %eax
     ced:	68 20 21 00 00       	push   $0x2120
     cf2:	e8 c7 06 00 00       	call   13be <strchr>
     cf7:	83 c4 10             	add    $0x10,%esp
     cfa:	85 c0                	test   %eax,%eax
     cfc:	75 d6                	jne    cd4 <gettoken+0x116>
    s++;
  *ps = s;
     cfe:	8b 45 08             	mov    0x8(%ebp),%eax
     d01:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d04:	89 10                	mov    %edx,(%eax)
  return ret;
     d06:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     d09:	c9                   	leave  
     d0a:	c3                   	ret    

00000d0b <peek>:

int
peek(char **ps, char *es, char *toks)
{
     d0b:	55                   	push   %ebp
     d0c:	89 e5                	mov    %esp,%ebp
     d0e:	83 ec 18             	sub    $0x18,%esp
  char *s;
  
  s = *ps;
     d11:	8b 45 08             	mov    0x8(%ebp),%eax
     d14:	8b 00                	mov    (%eax),%eax
     d16:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     d19:	eb 04                	jmp    d1f <peek+0x14>
    s++;
     d1b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     d1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d22:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d25:	73 1e                	jae    d45 <peek+0x3a>
     d27:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d2a:	0f b6 00             	movzbl (%eax),%eax
     d2d:	0f be c0             	movsbl %al,%eax
     d30:	83 ec 08             	sub    $0x8,%esp
     d33:	50                   	push   %eax
     d34:	68 20 21 00 00       	push   $0x2120
     d39:	e8 80 06 00 00       	call   13be <strchr>
     d3e:	83 c4 10             	add    $0x10,%esp
     d41:	85 c0                	test   %eax,%eax
     d43:	75 d6                	jne    d1b <peek+0x10>
    s++;
  *ps = s;
     d45:	8b 45 08             	mov    0x8(%ebp),%eax
     d48:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d4b:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     d4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d50:	0f b6 00             	movzbl (%eax),%eax
     d53:	84 c0                	test   %al,%al
     d55:	74 23                	je     d7a <peek+0x6f>
     d57:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d5a:	0f b6 00             	movzbl (%eax),%eax
     d5d:	0f be c0             	movsbl %al,%eax
     d60:	83 ec 08             	sub    $0x8,%esp
     d63:	50                   	push   %eax
     d64:	ff 75 10             	pushl  0x10(%ebp)
     d67:	e8 52 06 00 00       	call   13be <strchr>
     d6c:	83 c4 10             	add    $0x10,%esp
     d6f:	85 c0                	test   %eax,%eax
     d71:	74 07                	je     d7a <peek+0x6f>
     d73:	b8 01 00 00 00       	mov    $0x1,%eax
     d78:	eb 05                	jmp    d7f <peek+0x74>
     d7a:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d7f:	c9                   	leave  
     d80:	c3                   	ret    

00000d81 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     d81:	55                   	push   %ebp
     d82:	89 e5                	mov    %esp,%ebp
     d84:	53                   	push   %ebx
     d85:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     d88:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d8b:	8b 45 08             	mov    0x8(%ebp),%eax
     d8e:	83 ec 0c             	sub    $0xc,%esp
     d91:	50                   	push   %eax
     d92:	e8 e6 05 00 00       	call   137d <strlen>
     d97:	83 c4 10             	add    $0x10,%esp
     d9a:	01 d8                	add    %ebx,%eax
     d9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     d9f:	83 ec 08             	sub    $0x8,%esp
     da2:	ff 75 f4             	pushl  -0xc(%ebp)
     da5:	8d 45 08             	lea    0x8(%ebp),%eax
     da8:	50                   	push   %eax
     da9:	e8 61 00 00 00       	call   e0f <parseline>
     dae:	83 c4 10             	add    $0x10,%esp
     db1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     db4:	83 ec 04             	sub    $0x4,%esp
     db7:	68 43 1b 00 00       	push   $0x1b43
     dbc:	ff 75 f4             	pushl  -0xc(%ebp)
     dbf:	8d 45 08             	lea    0x8(%ebp),%eax
     dc2:	50                   	push   %eax
     dc3:	e8 43 ff ff ff       	call   d0b <peek>
     dc8:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     dcb:	8b 45 08             	mov    0x8(%ebp),%eax
     dce:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     dd1:	74 26                	je     df9 <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
     dd3:	8b 45 08             	mov    0x8(%ebp),%eax
     dd6:	83 ec 04             	sub    $0x4,%esp
     dd9:	50                   	push   %eax
     dda:	68 44 1b 00 00       	push   $0x1b44
     ddf:	6a 02                	push   $0x2
     de1:	e8 d5 08 00 00       	call   16bb <printf>
     de6:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     de9:	83 ec 0c             	sub    $0xc,%esp
     dec:	68 53 1b 00 00       	push   $0x1b53
     df1:	e8 17 fc ff ff       	call   a0d <panic>
     df6:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
     df9:	83 ec 0c             	sub    $0xc,%esp
     dfc:	ff 75 f0             	pushl  -0x10(%ebp)
     dff:	e8 e9 03 00 00       	call   11ed <nulterminate>
     e04:	83 c4 10             	add    $0x10,%esp
  return cmd;
     e07:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     e0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e0d:	c9                   	leave  
     e0e:	c3                   	ret    

00000e0f <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     e0f:	55                   	push   %ebp
     e10:	89 e5                	mov    %esp,%ebp
     e12:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     e15:	83 ec 08             	sub    $0x8,%esp
     e18:	ff 75 0c             	pushl  0xc(%ebp)
     e1b:	ff 75 08             	pushl  0x8(%ebp)
     e1e:	e8 99 00 00 00       	call   ebc <parsepipe>
     e23:	83 c4 10             	add    $0x10,%esp
     e26:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     e29:	eb 23                	jmp    e4e <parseline+0x3f>
    gettoken(ps, es, 0, 0);
     e2b:	6a 00                	push   $0x0
     e2d:	6a 00                	push   $0x0
     e2f:	ff 75 0c             	pushl  0xc(%ebp)
     e32:	ff 75 08             	pushl  0x8(%ebp)
     e35:	e8 84 fd ff ff       	call   bbe <gettoken>
     e3a:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     e3d:	83 ec 0c             	sub    $0xc,%esp
     e40:	ff 75 f4             	pushl  -0xc(%ebp)
     e43:	e8 37 fd ff ff       	call   b7f <backcmd>
     e48:	83 c4 10             	add    $0x10,%esp
     e4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     e4e:	83 ec 04             	sub    $0x4,%esp
     e51:	68 5a 1b 00 00       	push   $0x1b5a
     e56:	ff 75 0c             	pushl  0xc(%ebp)
     e59:	ff 75 08             	pushl  0x8(%ebp)
     e5c:	e8 aa fe ff ff       	call   d0b <peek>
     e61:	83 c4 10             	add    $0x10,%esp
     e64:	85 c0                	test   %eax,%eax
     e66:	75 c3                	jne    e2b <parseline+0x1c>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     e68:	83 ec 04             	sub    $0x4,%esp
     e6b:	68 5c 1b 00 00       	push   $0x1b5c
     e70:	ff 75 0c             	pushl  0xc(%ebp)
     e73:	ff 75 08             	pushl  0x8(%ebp)
     e76:	e8 90 fe ff ff       	call   d0b <peek>
     e7b:	83 c4 10             	add    $0x10,%esp
     e7e:	85 c0                	test   %eax,%eax
     e80:	74 35                	je     eb7 <parseline+0xa8>
    gettoken(ps, es, 0, 0);
     e82:	6a 00                	push   $0x0
     e84:	6a 00                	push   $0x0
     e86:	ff 75 0c             	pushl  0xc(%ebp)
     e89:	ff 75 08             	pushl  0x8(%ebp)
     e8c:	e8 2d fd ff ff       	call   bbe <gettoken>
     e91:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     e94:	83 ec 08             	sub    $0x8,%esp
     e97:	ff 75 0c             	pushl  0xc(%ebp)
     e9a:	ff 75 08             	pushl  0x8(%ebp)
     e9d:	e8 6d ff ff ff       	call   e0f <parseline>
     ea2:	83 c4 10             	add    $0x10,%esp
     ea5:	83 ec 08             	sub    $0x8,%esp
     ea8:	50                   	push   %eax
     ea9:	ff 75 f4             	pushl  -0xc(%ebp)
     eac:	e8 86 fc ff ff       	call   b37 <listcmd>
     eb1:	83 c4 10             	add    $0x10,%esp
     eb4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     eb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     eba:	c9                   	leave  
     ebb:	c3                   	ret    

00000ebc <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     ebc:	55                   	push   %ebp
     ebd:	89 e5                	mov    %esp,%ebp
     ebf:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     ec2:	83 ec 08             	sub    $0x8,%esp
     ec5:	ff 75 0c             	pushl  0xc(%ebp)
     ec8:	ff 75 08             	pushl  0x8(%ebp)
     ecb:	e8 ec 01 00 00       	call   10bc <parseexec>
     ed0:	83 c4 10             	add    $0x10,%esp
     ed3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     ed6:	83 ec 04             	sub    $0x4,%esp
     ed9:	68 5e 1b 00 00       	push   $0x1b5e
     ede:	ff 75 0c             	pushl  0xc(%ebp)
     ee1:	ff 75 08             	pushl  0x8(%ebp)
     ee4:	e8 22 fe ff ff       	call   d0b <peek>
     ee9:	83 c4 10             	add    $0x10,%esp
     eec:	85 c0                	test   %eax,%eax
     eee:	74 35                	je     f25 <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
     ef0:	6a 00                	push   $0x0
     ef2:	6a 00                	push   $0x0
     ef4:	ff 75 0c             	pushl  0xc(%ebp)
     ef7:	ff 75 08             	pushl  0x8(%ebp)
     efa:	e8 bf fc ff ff       	call   bbe <gettoken>
     eff:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     f02:	83 ec 08             	sub    $0x8,%esp
     f05:	ff 75 0c             	pushl  0xc(%ebp)
     f08:	ff 75 08             	pushl  0x8(%ebp)
     f0b:	e8 ac ff ff ff       	call   ebc <parsepipe>
     f10:	83 c4 10             	add    $0x10,%esp
     f13:	83 ec 08             	sub    $0x8,%esp
     f16:	50                   	push   %eax
     f17:	ff 75 f4             	pushl  -0xc(%ebp)
     f1a:	e8 d0 fb ff ff       	call   aef <pipecmd>
     f1f:	83 c4 10             	add    $0x10,%esp
     f22:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     f25:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     f28:	c9                   	leave  
     f29:	c3                   	ret    

00000f2a <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     f2a:	55                   	push   %ebp
     f2b:	89 e5                	mov    %esp,%ebp
     f2d:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     f30:	e9 b6 00 00 00       	jmp    feb <parseredirs+0xc1>
    tok = gettoken(ps, es, 0, 0);
     f35:	6a 00                	push   $0x0
     f37:	6a 00                	push   $0x0
     f39:	ff 75 10             	pushl  0x10(%ebp)
     f3c:	ff 75 0c             	pushl  0xc(%ebp)
     f3f:	e8 7a fc ff ff       	call   bbe <gettoken>
     f44:	83 c4 10             	add    $0x10,%esp
     f47:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     f4a:	8d 45 ec             	lea    -0x14(%ebp),%eax
     f4d:	50                   	push   %eax
     f4e:	8d 45 f0             	lea    -0x10(%ebp),%eax
     f51:	50                   	push   %eax
     f52:	ff 75 10             	pushl  0x10(%ebp)
     f55:	ff 75 0c             	pushl  0xc(%ebp)
     f58:	e8 61 fc ff ff       	call   bbe <gettoken>
     f5d:	83 c4 10             	add    $0x10,%esp
     f60:	83 f8 61             	cmp    $0x61,%eax
     f63:	74 10                	je     f75 <parseredirs+0x4b>
      panic("missing file for redirection");
     f65:	83 ec 0c             	sub    $0xc,%esp
     f68:	68 60 1b 00 00       	push   $0x1b60
     f6d:	e8 9b fa ff ff       	call   a0d <panic>
     f72:	83 c4 10             	add    $0x10,%esp
    switch(tok){
     f75:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f78:	83 f8 3c             	cmp    $0x3c,%eax
     f7b:	74 0c                	je     f89 <parseredirs+0x5f>
     f7d:	83 f8 3e             	cmp    $0x3e,%eax
     f80:	74 26                	je     fa8 <parseredirs+0x7e>
     f82:	83 f8 2b             	cmp    $0x2b,%eax
     f85:	74 43                	je     fca <parseredirs+0xa0>
     f87:	eb 62                	jmp    feb <parseredirs+0xc1>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     f89:	8b 55 ec             	mov    -0x14(%ebp),%edx
     f8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f8f:	83 ec 0c             	sub    $0xc,%esp
     f92:	6a 00                	push   $0x0
     f94:	6a 00                	push   $0x0
     f96:	52                   	push   %edx
     f97:	50                   	push   %eax
     f98:	ff 75 08             	pushl  0x8(%ebp)
     f9b:	e8 ec fa ff ff       	call   a8c <redircmd>
     fa0:	83 c4 20             	add    $0x20,%esp
     fa3:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     fa6:	eb 43                	jmp    feb <parseredirs+0xc1>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     fa8:	8b 55 ec             	mov    -0x14(%ebp),%edx
     fab:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fae:	83 ec 0c             	sub    $0xc,%esp
     fb1:	6a 01                	push   $0x1
     fb3:	68 01 02 00 00       	push   $0x201
     fb8:	52                   	push   %edx
     fb9:	50                   	push   %eax
     fba:	ff 75 08             	pushl  0x8(%ebp)
     fbd:	e8 ca fa ff ff       	call   a8c <redircmd>
     fc2:	83 c4 20             	add    $0x20,%esp
     fc5:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     fc8:	eb 21                	jmp    feb <parseredirs+0xc1>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     fca:	8b 55 ec             	mov    -0x14(%ebp),%edx
     fcd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fd0:	83 ec 0c             	sub    $0xc,%esp
     fd3:	6a 01                	push   $0x1
     fd5:	68 01 02 00 00       	push   $0x201
     fda:	52                   	push   %edx
     fdb:	50                   	push   %eax
     fdc:	ff 75 08             	pushl  0x8(%ebp)
     fdf:	e8 a8 fa ff ff       	call   a8c <redircmd>
     fe4:	83 c4 20             	add    $0x20,%esp
     fe7:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     fea:	90                   	nop
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     feb:	83 ec 04             	sub    $0x4,%esp
     fee:	68 7d 1b 00 00       	push   $0x1b7d
     ff3:	ff 75 10             	pushl  0x10(%ebp)
     ff6:	ff 75 0c             	pushl  0xc(%ebp)
     ff9:	e8 0d fd ff ff       	call   d0b <peek>
     ffe:	83 c4 10             	add    $0x10,%esp
    1001:	85 c0                	test   %eax,%eax
    1003:	0f 85 2c ff ff ff    	jne    f35 <parseredirs+0xb>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
    1009:	8b 45 08             	mov    0x8(%ebp),%eax
}
    100c:	c9                   	leave  
    100d:	c3                   	ret    

0000100e <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
    100e:	55                   	push   %ebp
    100f:	89 e5                	mov    %esp,%ebp
    1011:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    1014:	83 ec 04             	sub    $0x4,%esp
    1017:	68 80 1b 00 00       	push   $0x1b80
    101c:	ff 75 0c             	pushl  0xc(%ebp)
    101f:	ff 75 08             	pushl  0x8(%ebp)
    1022:	e8 e4 fc ff ff       	call   d0b <peek>
    1027:	83 c4 10             	add    $0x10,%esp
    102a:	85 c0                	test   %eax,%eax
    102c:	75 10                	jne    103e <parseblock+0x30>
    panic("parseblock");
    102e:	83 ec 0c             	sub    $0xc,%esp
    1031:	68 82 1b 00 00       	push   $0x1b82
    1036:	e8 d2 f9 ff ff       	call   a0d <panic>
    103b:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
    103e:	6a 00                	push   $0x0
    1040:	6a 00                	push   $0x0
    1042:	ff 75 0c             	pushl  0xc(%ebp)
    1045:	ff 75 08             	pushl  0x8(%ebp)
    1048:	e8 71 fb ff ff       	call   bbe <gettoken>
    104d:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
    1050:	83 ec 08             	sub    $0x8,%esp
    1053:	ff 75 0c             	pushl  0xc(%ebp)
    1056:	ff 75 08             	pushl  0x8(%ebp)
    1059:	e8 b1 fd ff ff       	call   e0f <parseline>
    105e:	83 c4 10             	add    $0x10,%esp
    1061:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
    1064:	83 ec 04             	sub    $0x4,%esp
    1067:	68 8d 1b 00 00       	push   $0x1b8d
    106c:	ff 75 0c             	pushl  0xc(%ebp)
    106f:	ff 75 08             	pushl  0x8(%ebp)
    1072:	e8 94 fc ff ff       	call   d0b <peek>
    1077:	83 c4 10             	add    $0x10,%esp
    107a:	85 c0                	test   %eax,%eax
    107c:	75 10                	jne    108e <parseblock+0x80>
    panic("syntax - missing )");
    107e:	83 ec 0c             	sub    $0xc,%esp
    1081:	68 8f 1b 00 00       	push   $0x1b8f
    1086:	e8 82 f9 ff ff       	call   a0d <panic>
    108b:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
    108e:	6a 00                	push   $0x0
    1090:	6a 00                	push   $0x0
    1092:	ff 75 0c             	pushl  0xc(%ebp)
    1095:	ff 75 08             	pushl  0x8(%ebp)
    1098:	e8 21 fb ff ff       	call   bbe <gettoken>
    109d:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
    10a0:	83 ec 04             	sub    $0x4,%esp
    10a3:	ff 75 0c             	pushl  0xc(%ebp)
    10a6:	ff 75 08             	pushl  0x8(%ebp)
    10a9:	ff 75 f4             	pushl  -0xc(%ebp)
    10ac:	e8 79 fe ff ff       	call   f2a <parseredirs>
    10b1:	83 c4 10             	add    $0x10,%esp
    10b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
    10b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    10ba:	c9                   	leave  
    10bb:	c3                   	ret    

000010bc <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
    10bc:	55                   	push   %ebp
    10bd:	89 e5                	mov    %esp,%ebp
    10bf:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
    10c2:	83 ec 04             	sub    $0x4,%esp
    10c5:	68 80 1b 00 00       	push   $0x1b80
    10ca:	ff 75 0c             	pushl  0xc(%ebp)
    10cd:	ff 75 08             	pushl  0x8(%ebp)
    10d0:	e8 36 fc ff ff       	call   d0b <peek>
    10d5:	83 c4 10             	add    $0x10,%esp
    10d8:	85 c0                	test   %eax,%eax
    10da:	74 16                	je     10f2 <parseexec+0x36>
    return parseblock(ps, es);
    10dc:	83 ec 08             	sub    $0x8,%esp
    10df:	ff 75 0c             	pushl  0xc(%ebp)
    10e2:	ff 75 08             	pushl  0x8(%ebp)
    10e5:	e8 24 ff ff ff       	call   100e <parseblock>
    10ea:	83 c4 10             	add    $0x10,%esp
    10ed:	e9 f9 00 00 00       	jmp    11eb <parseexec+0x12f>

  ret = execcmd();
    10f2:	e8 5f f9 ff ff       	call   a56 <execcmd>
    10f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
    10fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10fd:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
    1100:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
    1107:	83 ec 04             	sub    $0x4,%esp
    110a:	ff 75 0c             	pushl  0xc(%ebp)
    110d:	ff 75 08             	pushl  0x8(%ebp)
    1110:	ff 75 f0             	pushl  -0x10(%ebp)
    1113:	e8 12 fe ff ff       	call   f2a <parseredirs>
    1118:	83 c4 10             	add    $0x10,%esp
    111b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
    111e:	e9 88 00 00 00       	jmp    11ab <parseexec+0xef>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
    1123:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1126:	50                   	push   %eax
    1127:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    112a:	50                   	push   %eax
    112b:	ff 75 0c             	pushl  0xc(%ebp)
    112e:	ff 75 08             	pushl  0x8(%ebp)
    1131:	e8 88 fa ff ff       	call   bbe <gettoken>
    1136:	83 c4 10             	add    $0x10,%esp
    1139:	89 45 e8             	mov    %eax,-0x18(%ebp)
    113c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1140:	75 05                	jne    1147 <parseexec+0x8b>
      break;
    1142:	e9 82 00 00 00       	jmp    11c9 <parseexec+0x10d>
    if(tok != 'a')
    1147:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
    114b:	74 10                	je     115d <parseexec+0xa1>
      panic("syntax");
    114d:	83 ec 0c             	sub    $0xc,%esp
    1150:	68 53 1b 00 00       	push   $0x1b53
    1155:	e8 b3 f8 ff ff       	call   a0d <panic>
    115a:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
    115d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1160:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1163:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1166:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
    116a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    116d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1170:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1173:	83 c1 08             	add    $0x8,%ecx
    1176:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
    117a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
    117e:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1182:	7e 10                	jle    1194 <parseexec+0xd8>
      panic("too many args");
    1184:	83 ec 0c             	sub    $0xc,%esp
    1187:	68 a2 1b 00 00       	push   $0x1ba2
    118c:	e8 7c f8 ff ff       	call   a0d <panic>
    1191:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
    1194:	83 ec 04             	sub    $0x4,%esp
    1197:	ff 75 0c             	pushl  0xc(%ebp)
    119a:	ff 75 08             	pushl  0x8(%ebp)
    119d:	ff 75 f0             	pushl  -0x10(%ebp)
    11a0:	e8 85 fd ff ff       	call   f2a <parseredirs>
    11a5:	83 c4 10             	add    $0x10,%esp
    11a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    11ab:	83 ec 04             	sub    $0x4,%esp
    11ae:	68 b0 1b 00 00       	push   $0x1bb0
    11b3:	ff 75 0c             	pushl  0xc(%ebp)
    11b6:	ff 75 08             	pushl  0x8(%ebp)
    11b9:	e8 4d fb ff ff       	call   d0b <peek>
    11be:	83 c4 10             	add    $0x10,%esp
    11c1:	85 c0                	test   %eax,%eax
    11c3:	0f 84 5a ff ff ff    	je     1123 <parseexec+0x67>
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
    11c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11cf:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
    11d6:	00 
  cmd->eargv[argc] = 0;
    11d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11da:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11dd:	83 c2 08             	add    $0x8,%edx
    11e0:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
    11e7:	00 
  return ret;
    11e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    11eb:	c9                   	leave  
    11ec:	c3                   	ret    

000011ed <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
    11ed:	55                   	push   %ebp
    11ee:	89 e5                	mov    %esp,%ebp
    11f0:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    11f3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    11f7:	75 0a                	jne    1203 <nulterminate+0x16>
    return 0;
    11f9:	b8 00 00 00 00       	mov    $0x0,%eax
    11fe:	e9 e4 00 00 00       	jmp    12e7 <nulterminate+0xfa>
  
  switch(cmd->type){
    1203:	8b 45 08             	mov    0x8(%ebp),%eax
    1206:	8b 00                	mov    (%eax),%eax
    1208:	83 f8 05             	cmp    $0x5,%eax
    120b:	0f 87 d3 00 00 00    	ja     12e4 <nulterminate+0xf7>
    1211:	8b 04 85 b8 1b 00 00 	mov    0x1bb8(,%eax,4),%eax
    1218:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    121a:	8b 45 08             	mov    0x8(%ebp),%eax
    121d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(i=0; ecmd->argv[i]; i++)
    1220:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1227:	eb 14                	jmp    123d <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
    1229:	8b 45 f0             	mov    -0x10(%ebp),%eax
    122c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    122f:	83 c2 08             	add    $0x8,%edx
    1232:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
    1236:	c6 00 00             	movb   $0x0,(%eax)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
    1239:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    123d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1240:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1243:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
    1247:	85 c0                	test   %eax,%eax
    1249:	75 de                	jne    1229 <nulterminate+0x3c>
      *ecmd->eargv[i] = 0;
    break;
    124b:	e9 94 00 00 00       	jmp    12e4 <nulterminate+0xf7>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    1250:	8b 45 08             	mov    0x8(%ebp),%eax
    1253:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(rcmd->cmd);
    1256:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1259:	8b 40 04             	mov    0x4(%eax),%eax
    125c:	83 ec 0c             	sub    $0xc,%esp
    125f:	50                   	push   %eax
    1260:	e8 88 ff ff ff       	call   11ed <nulterminate>
    1265:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
    1268:	8b 45 ec             	mov    -0x14(%ebp),%eax
    126b:	8b 40 0c             	mov    0xc(%eax),%eax
    126e:	c6 00 00             	movb   $0x0,(%eax)
    break;
    1271:	eb 71                	jmp    12e4 <nulterminate+0xf7>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    1273:	8b 45 08             	mov    0x8(%ebp),%eax
    1276:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
    1279:	8b 45 e8             	mov    -0x18(%ebp),%eax
    127c:	8b 40 04             	mov    0x4(%eax),%eax
    127f:	83 ec 0c             	sub    $0xc,%esp
    1282:	50                   	push   %eax
    1283:	e8 65 ff ff ff       	call   11ed <nulterminate>
    1288:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
    128b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    128e:	8b 40 08             	mov    0x8(%eax),%eax
    1291:	83 ec 0c             	sub    $0xc,%esp
    1294:	50                   	push   %eax
    1295:	e8 53 ff ff ff       	call   11ed <nulterminate>
    129a:	83 c4 10             	add    $0x10,%esp
    break;
    129d:	eb 45                	jmp    12e4 <nulterminate+0xf7>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
    129f:	8b 45 08             	mov    0x8(%ebp),%eax
    12a2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(lcmd->left);
    12a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12a8:	8b 40 04             	mov    0x4(%eax),%eax
    12ab:	83 ec 0c             	sub    $0xc,%esp
    12ae:	50                   	push   %eax
    12af:	e8 39 ff ff ff       	call   11ed <nulterminate>
    12b4:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
    12b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12ba:	8b 40 08             	mov    0x8(%eax),%eax
    12bd:	83 ec 0c             	sub    $0xc,%esp
    12c0:	50                   	push   %eax
    12c1:	e8 27 ff ff ff       	call   11ed <nulterminate>
    12c6:	83 c4 10             	add    $0x10,%esp
    break;
    12c9:	eb 19                	jmp    12e4 <nulterminate+0xf7>

  case BACK:
    bcmd = (struct backcmd*)cmd;
    12cb:	8b 45 08             	mov    0x8(%ebp),%eax
    12ce:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nulterminate(bcmd->cmd);
    12d1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12d4:	8b 40 04             	mov    0x4(%eax),%eax
    12d7:	83 ec 0c             	sub    $0xc,%esp
    12da:	50                   	push   %eax
    12db:	e8 0d ff ff ff       	call   11ed <nulterminate>
    12e0:	83 c4 10             	add    $0x10,%esp
    break;
    12e3:	90                   	nop
  }
  return cmd;
    12e4:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12e7:	c9                   	leave  
    12e8:	c3                   	ret    

000012e9 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    12e9:	55                   	push   %ebp
    12ea:	89 e5                	mov    %esp,%ebp
    12ec:	57                   	push   %edi
    12ed:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    12ee:	8b 4d 08             	mov    0x8(%ebp),%ecx
    12f1:	8b 55 10             	mov    0x10(%ebp),%edx
    12f4:	8b 45 0c             	mov    0xc(%ebp),%eax
    12f7:	89 cb                	mov    %ecx,%ebx
    12f9:	89 df                	mov    %ebx,%edi
    12fb:	89 d1                	mov    %edx,%ecx
    12fd:	fc                   	cld    
    12fe:	f3 aa                	rep stos %al,%es:(%edi)
    1300:	89 ca                	mov    %ecx,%edx
    1302:	89 fb                	mov    %edi,%ebx
    1304:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1307:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    130a:	5b                   	pop    %ebx
    130b:	5f                   	pop    %edi
    130c:	5d                   	pop    %ebp
    130d:	c3                   	ret    

0000130e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    130e:	55                   	push   %ebp
    130f:	89 e5                	mov    %esp,%ebp
    1311:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1314:	8b 45 08             	mov    0x8(%ebp),%eax
    1317:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    131a:	90                   	nop
    131b:	8b 45 08             	mov    0x8(%ebp),%eax
    131e:	8d 50 01             	lea    0x1(%eax),%edx
    1321:	89 55 08             	mov    %edx,0x8(%ebp)
    1324:	8b 55 0c             	mov    0xc(%ebp),%edx
    1327:	8d 4a 01             	lea    0x1(%edx),%ecx
    132a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    132d:	0f b6 12             	movzbl (%edx),%edx
    1330:	88 10                	mov    %dl,(%eax)
    1332:	0f b6 00             	movzbl (%eax),%eax
    1335:	84 c0                	test   %al,%al
    1337:	75 e2                	jne    131b <strcpy+0xd>
    ;
  return os;
    1339:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    133c:	c9                   	leave  
    133d:	c3                   	ret    

0000133e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    133e:	55                   	push   %ebp
    133f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1341:	eb 08                	jmp    134b <strcmp+0xd>
    p++, q++;
    1343:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1347:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    134b:	8b 45 08             	mov    0x8(%ebp),%eax
    134e:	0f b6 00             	movzbl (%eax),%eax
    1351:	84 c0                	test   %al,%al
    1353:	74 10                	je     1365 <strcmp+0x27>
    1355:	8b 45 08             	mov    0x8(%ebp),%eax
    1358:	0f b6 10             	movzbl (%eax),%edx
    135b:	8b 45 0c             	mov    0xc(%ebp),%eax
    135e:	0f b6 00             	movzbl (%eax),%eax
    1361:	38 c2                	cmp    %al,%dl
    1363:	74 de                	je     1343 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1365:	8b 45 08             	mov    0x8(%ebp),%eax
    1368:	0f b6 00             	movzbl (%eax),%eax
    136b:	0f b6 d0             	movzbl %al,%edx
    136e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1371:	0f b6 00             	movzbl (%eax),%eax
    1374:	0f b6 c0             	movzbl %al,%eax
    1377:	29 c2                	sub    %eax,%edx
    1379:	89 d0                	mov    %edx,%eax
}
    137b:	5d                   	pop    %ebp
    137c:	c3                   	ret    

0000137d <strlen>:

uint
strlen(char *s)
{
    137d:	55                   	push   %ebp
    137e:	89 e5                	mov    %esp,%ebp
    1380:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1383:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    138a:	eb 04                	jmp    1390 <strlen+0x13>
    138c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1390:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1393:	8b 45 08             	mov    0x8(%ebp),%eax
    1396:	01 d0                	add    %edx,%eax
    1398:	0f b6 00             	movzbl (%eax),%eax
    139b:	84 c0                	test   %al,%al
    139d:	75 ed                	jne    138c <strlen+0xf>
    ;
  return n;
    139f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    13a2:	c9                   	leave  
    13a3:	c3                   	ret    

000013a4 <memset>:

void*
memset(void *dst, int c, uint n)
{
    13a4:	55                   	push   %ebp
    13a5:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    13a7:	8b 45 10             	mov    0x10(%ebp),%eax
    13aa:	50                   	push   %eax
    13ab:	ff 75 0c             	pushl  0xc(%ebp)
    13ae:	ff 75 08             	pushl  0x8(%ebp)
    13b1:	e8 33 ff ff ff       	call   12e9 <stosb>
    13b6:	83 c4 0c             	add    $0xc,%esp
  return dst;
    13b9:	8b 45 08             	mov    0x8(%ebp),%eax
}
    13bc:	c9                   	leave  
    13bd:	c3                   	ret    

000013be <strchr>:

char*
strchr(const char *s, char c)
{
    13be:	55                   	push   %ebp
    13bf:	89 e5                	mov    %esp,%ebp
    13c1:	83 ec 04             	sub    $0x4,%esp
    13c4:	8b 45 0c             	mov    0xc(%ebp),%eax
    13c7:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    13ca:	eb 14                	jmp    13e0 <strchr+0x22>
    if(*s == c)
    13cc:	8b 45 08             	mov    0x8(%ebp),%eax
    13cf:	0f b6 00             	movzbl (%eax),%eax
    13d2:	3a 45 fc             	cmp    -0x4(%ebp),%al
    13d5:	75 05                	jne    13dc <strchr+0x1e>
      return (char*)s;
    13d7:	8b 45 08             	mov    0x8(%ebp),%eax
    13da:	eb 13                	jmp    13ef <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    13dc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    13e0:	8b 45 08             	mov    0x8(%ebp),%eax
    13e3:	0f b6 00             	movzbl (%eax),%eax
    13e6:	84 c0                	test   %al,%al
    13e8:	75 e2                	jne    13cc <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    13ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
    13ef:	c9                   	leave  
    13f0:	c3                   	ret    

000013f1 <gets>:

char*
gets(char *buf, int max)
{
    13f1:	55                   	push   %ebp
    13f2:	89 e5                	mov    %esp,%ebp
    13f4:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    13f7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13fe:	eb 44                	jmp    1444 <gets+0x53>
    cc = read(0, &c, 1);
    1400:	83 ec 04             	sub    $0x4,%esp
    1403:	6a 01                	push   $0x1
    1405:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1408:	50                   	push   %eax
    1409:	6a 00                	push   $0x0
    140b:	e8 46 01 00 00       	call   1556 <read>
    1410:	83 c4 10             	add    $0x10,%esp
    1413:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1416:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    141a:	7f 02                	jg     141e <gets+0x2d>
      break;
    141c:	eb 31                	jmp    144f <gets+0x5e>
    buf[i++] = c;
    141e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1421:	8d 50 01             	lea    0x1(%eax),%edx
    1424:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1427:	89 c2                	mov    %eax,%edx
    1429:	8b 45 08             	mov    0x8(%ebp),%eax
    142c:	01 c2                	add    %eax,%edx
    142e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1432:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1434:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1438:	3c 0a                	cmp    $0xa,%al
    143a:	74 13                	je     144f <gets+0x5e>
    143c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1440:	3c 0d                	cmp    $0xd,%al
    1442:	74 0b                	je     144f <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1444:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1447:	83 c0 01             	add    $0x1,%eax
    144a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    144d:	7c b1                	jl     1400 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    144f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1452:	8b 45 08             	mov    0x8(%ebp),%eax
    1455:	01 d0                	add    %edx,%eax
    1457:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    145a:	8b 45 08             	mov    0x8(%ebp),%eax
}
    145d:	c9                   	leave  
    145e:	c3                   	ret    

0000145f <stat>:

int
stat(char *n, struct stat *st)
{
    145f:	55                   	push   %ebp
    1460:	89 e5                	mov    %esp,%ebp
    1462:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1465:	83 ec 08             	sub    $0x8,%esp
    1468:	6a 00                	push   $0x0
    146a:	ff 75 08             	pushl  0x8(%ebp)
    146d:	e8 0c 01 00 00       	call   157e <open>
    1472:	83 c4 10             	add    $0x10,%esp
    1475:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1478:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    147c:	79 07                	jns    1485 <stat+0x26>
    return -1;
    147e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1483:	eb 25                	jmp    14aa <stat+0x4b>
  r = fstat(fd, st);
    1485:	83 ec 08             	sub    $0x8,%esp
    1488:	ff 75 0c             	pushl  0xc(%ebp)
    148b:	ff 75 f4             	pushl  -0xc(%ebp)
    148e:	e8 03 01 00 00       	call   1596 <fstat>
    1493:	83 c4 10             	add    $0x10,%esp
    1496:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1499:	83 ec 0c             	sub    $0xc,%esp
    149c:	ff 75 f4             	pushl  -0xc(%ebp)
    149f:	e8 c2 00 00 00       	call   1566 <close>
    14a4:	83 c4 10             	add    $0x10,%esp
  return r;
    14a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    14aa:	c9                   	leave  
    14ab:	c3                   	ret    

000014ac <atoi>:

int
atoi(const char *s)
{
    14ac:	55                   	push   %ebp
    14ad:	89 e5                	mov    %esp,%ebp
    14af:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    14b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    14b9:	eb 25                	jmp    14e0 <atoi+0x34>
    n = n*10 + *s++ - '0';
    14bb:	8b 55 fc             	mov    -0x4(%ebp),%edx
    14be:	89 d0                	mov    %edx,%eax
    14c0:	c1 e0 02             	shl    $0x2,%eax
    14c3:	01 d0                	add    %edx,%eax
    14c5:	01 c0                	add    %eax,%eax
    14c7:	89 c1                	mov    %eax,%ecx
    14c9:	8b 45 08             	mov    0x8(%ebp),%eax
    14cc:	8d 50 01             	lea    0x1(%eax),%edx
    14cf:	89 55 08             	mov    %edx,0x8(%ebp)
    14d2:	0f b6 00             	movzbl (%eax),%eax
    14d5:	0f be c0             	movsbl %al,%eax
    14d8:	01 c8                	add    %ecx,%eax
    14da:	83 e8 30             	sub    $0x30,%eax
    14dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    14e0:	8b 45 08             	mov    0x8(%ebp),%eax
    14e3:	0f b6 00             	movzbl (%eax),%eax
    14e6:	3c 2f                	cmp    $0x2f,%al
    14e8:	7e 0a                	jle    14f4 <atoi+0x48>
    14ea:	8b 45 08             	mov    0x8(%ebp),%eax
    14ed:	0f b6 00             	movzbl (%eax),%eax
    14f0:	3c 39                	cmp    $0x39,%al
    14f2:	7e c7                	jle    14bb <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    14f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    14f7:	c9                   	leave  
    14f8:	c3                   	ret    

000014f9 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    14f9:	55                   	push   %ebp
    14fa:	89 e5                	mov    %esp,%ebp
    14fc:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    14ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1502:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1505:	8b 45 0c             	mov    0xc(%ebp),%eax
    1508:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    150b:	eb 17                	jmp    1524 <memmove+0x2b>
    *dst++ = *src++;
    150d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1510:	8d 50 01             	lea    0x1(%eax),%edx
    1513:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1516:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1519:	8d 4a 01             	lea    0x1(%edx),%ecx
    151c:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    151f:	0f b6 12             	movzbl (%edx),%edx
    1522:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1524:	8b 45 10             	mov    0x10(%ebp),%eax
    1527:	8d 50 ff             	lea    -0x1(%eax),%edx
    152a:	89 55 10             	mov    %edx,0x10(%ebp)
    152d:	85 c0                	test   %eax,%eax
    152f:	7f dc                	jg     150d <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1531:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1534:	c9                   	leave  
    1535:	c3                   	ret    

00001536 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1536:	b8 01 00 00 00       	mov    $0x1,%eax
    153b:	cd 40                	int    $0x40
    153d:	c3                   	ret    

0000153e <exit>:
SYSCALL(exit)
    153e:	b8 02 00 00 00       	mov    $0x2,%eax
    1543:	cd 40                	int    $0x40
    1545:	c3                   	ret    

00001546 <wait>:
SYSCALL(wait)
    1546:	b8 03 00 00 00       	mov    $0x3,%eax
    154b:	cd 40                	int    $0x40
    154d:	c3                   	ret    

0000154e <pipe>:
SYSCALL(pipe)
    154e:	b8 04 00 00 00       	mov    $0x4,%eax
    1553:	cd 40                	int    $0x40
    1555:	c3                   	ret    

00001556 <read>:
SYSCALL(read)
    1556:	b8 05 00 00 00       	mov    $0x5,%eax
    155b:	cd 40                	int    $0x40
    155d:	c3                   	ret    

0000155e <write>:
SYSCALL(write)
    155e:	b8 10 00 00 00       	mov    $0x10,%eax
    1563:	cd 40                	int    $0x40
    1565:	c3                   	ret    

00001566 <close>:
SYSCALL(close)
    1566:	b8 15 00 00 00       	mov    $0x15,%eax
    156b:	cd 40                	int    $0x40
    156d:	c3                   	ret    

0000156e <kill>:
SYSCALL(kill)
    156e:	b8 06 00 00 00       	mov    $0x6,%eax
    1573:	cd 40                	int    $0x40
    1575:	c3                   	ret    

00001576 <exec>:
SYSCALL(exec)
    1576:	b8 07 00 00 00       	mov    $0x7,%eax
    157b:	cd 40                	int    $0x40
    157d:	c3                   	ret    

0000157e <open>:
SYSCALL(open)
    157e:	b8 0f 00 00 00       	mov    $0xf,%eax
    1583:	cd 40                	int    $0x40
    1585:	c3                   	ret    

00001586 <mknod>:
SYSCALL(mknod)
    1586:	b8 11 00 00 00       	mov    $0x11,%eax
    158b:	cd 40                	int    $0x40
    158d:	c3                   	ret    

0000158e <unlink>:
SYSCALL(unlink)
    158e:	b8 12 00 00 00       	mov    $0x12,%eax
    1593:	cd 40                	int    $0x40
    1595:	c3                   	ret    

00001596 <fstat>:
SYSCALL(fstat)
    1596:	b8 08 00 00 00       	mov    $0x8,%eax
    159b:	cd 40                	int    $0x40
    159d:	c3                   	ret    

0000159e <link>:
SYSCALL(link)
    159e:	b8 13 00 00 00       	mov    $0x13,%eax
    15a3:	cd 40                	int    $0x40
    15a5:	c3                   	ret    

000015a6 <mkdir>:
SYSCALL(mkdir)
    15a6:	b8 14 00 00 00       	mov    $0x14,%eax
    15ab:	cd 40                	int    $0x40
    15ad:	c3                   	ret    

000015ae <chdir>:
SYSCALL(chdir)
    15ae:	b8 09 00 00 00       	mov    $0x9,%eax
    15b3:	cd 40                	int    $0x40
    15b5:	c3                   	ret    

000015b6 <dup>:
SYSCALL(dup)
    15b6:	b8 0a 00 00 00       	mov    $0xa,%eax
    15bb:	cd 40                	int    $0x40
    15bd:	c3                   	ret    

000015be <getpid>:
SYSCALL(getpid)
    15be:	b8 0b 00 00 00       	mov    $0xb,%eax
    15c3:	cd 40                	int    $0x40
    15c5:	c3                   	ret    

000015c6 <sbrk>:
SYSCALL(sbrk)
    15c6:	b8 0c 00 00 00       	mov    $0xc,%eax
    15cb:	cd 40                	int    $0x40
    15cd:	c3                   	ret    

000015ce <sleep>:
SYSCALL(sleep)
    15ce:	b8 0d 00 00 00       	mov    $0xd,%eax
    15d3:	cd 40                	int    $0x40
    15d5:	c3                   	ret    

000015d6 <uptime>:
SYSCALL(uptime)
    15d6:	b8 0e 00 00 00       	mov    $0xe,%eax
    15db:	cd 40                	int    $0x40
    15dd:	c3                   	ret    

000015de <getcwd>:
SYSCALL(getcwd)
    15de:	b8 16 00 00 00       	mov    $0x16,%eax
    15e3:	cd 40                	int    $0x40
    15e5:	c3                   	ret    

000015e6 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    15e6:	55                   	push   %ebp
    15e7:	89 e5                	mov    %esp,%ebp
    15e9:	83 ec 18             	sub    $0x18,%esp
    15ec:	8b 45 0c             	mov    0xc(%ebp),%eax
    15ef:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    15f2:	83 ec 04             	sub    $0x4,%esp
    15f5:	6a 01                	push   $0x1
    15f7:	8d 45 f4             	lea    -0xc(%ebp),%eax
    15fa:	50                   	push   %eax
    15fb:	ff 75 08             	pushl  0x8(%ebp)
    15fe:	e8 5b ff ff ff       	call   155e <write>
    1603:	83 c4 10             	add    $0x10,%esp
}
    1606:	c9                   	leave  
    1607:	c3                   	ret    

00001608 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1608:	55                   	push   %ebp
    1609:	89 e5                	mov    %esp,%ebp
    160b:	53                   	push   %ebx
    160c:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    160f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1616:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    161a:	74 17                	je     1633 <printint+0x2b>
    161c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1620:	79 11                	jns    1633 <printint+0x2b>
    neg = 1;
    1622:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1629:	8b 45 0c             	mov    0xc(%ebp),%eax
    162c:	f7 d8                	neg    %eax
    162e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1631:	eb 06                	jmp    1639 <printint+0x31>
  } else {
    x = xx;
    1633:	8b 45 0c             	mov    0xc(%ebp),%eax
    1636:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1639:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1640:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1643:	8d 41 01             	lea    0x1(%ecx),%eax
    1646:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1649:	8b 5d 10             	mov    0x10(%ebp),%ebx
    164c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    164f:	ba 00 00 00 00       	mov    $0x0,%edx
    1654:	f7 f3                	div    %ebx
    1656:	89 d0                	mov    %edx,%eax
    1658:	0f b6 80 2e 21 00 00 	movzbl 0x212e(%eax),%eax
    165f:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1663:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1666:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1669:	ba 00 00 00 00       	mov    $0x0,%edx
    166e:	f7 f3                	div    %ebx
    1670:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1673:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1677:	75 c7                	jne    1640 <printint+0x38>
  if(neg)
    1679:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    167d:	74 0e                	je     168d <printint+0x85>
    buf[i++] = '-';
    167f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1682:	8d 50 01             	lea    0x1(%eax),%edx
    1685:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1688:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    168d:	eb 1d                	jmp    16ac <printint+0xa4>
    putc(fd, buf[i]);
    168f:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1692:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1695:	01 d0                	add    %edx,%eax
    1697:	0f b6 00             	movzbl (%eax),%eax
    169a:	0f be c0             	movsbl %al,%eax
    169d:	83 ec 08             	sub    $0x8,%esp
    16a0:	50                   	push   %eax
    16a1:	ff 75 08             	pushl  0x8(%ebp)
    16a4:	e8 3d ff ff ff       	call   15e6 <putc>
    16a9:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    16ac:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    16b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16b4:	79 d9                	jns    168f <printint+0x87>
    putc(fd, buf[i]);
}
    16b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    16b9:	c9                   	leave  
    16ba:	c3                   	ret    

000016bb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    16bb:	55                   	push   %ebp
    16bc:	89 e5                	mov    %esp,%ebp
    16be:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    16c1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    16c8:	8d 45 0c             	lea    0xc(%ebp),%eax
    16cb:	83 c0 04             	add    $0x4,%eax
    16ce:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    16d1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    16d8:	e9 59 01 00 00       	jmp    1836 <printf+0x17b>
    c = fmt[i] & 0xff;
    16dd:	8b 55 0c             	mov    0xc(%ebp),%edx
    16e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16e3:	01 d0                	add    %edx,%eax
    16e5:	0f b6 00             	movzbl (%eax),%eax
    16e8:	0f be c0             	movsbl %al,%eax
    16eb:	25 ff 00 00 00       	and    $0xff,%eax
    16f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    16f3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16f7:	75 2c                	jne    1725 <printf+0x6a>
      if(c == '%'){
    16f9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    16fd:	75 0c                	jne    170b <printf+0x50>
        state = '%';
    16ff:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1706:	e9 27 01 00 00       	jmp    1832 <printf+0x177>
      } else {
        putc(fd, c);
    170b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    170e:	0f be c0             	movsbl %al,%eax
    1711:	83 ec 08             	sub    $0x8,%esp
    1714:	50                   	push   %eax
    1715:	ff 75 08             	pushl  0x8(%ebp)
    1718:	e8 c9 fe ff ff       	call   15e6 <putc>
    171d:	83 c4 10             	add    $0x10,%esp
    1720:	e9 0d 01 00 00       	jmp    1832 <printf+0x177>
      }
    } else if(state == '%'){
    1725:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1729:	0f 85 03 01 00 00    	jne    1832 <printf+0x177>
      if(c == 'd'){
    172f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1733:	75 1e                	jne    1753 <printf+0x98>
        printint(fd, *ap, 10, 1);
    1735:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1738:	8b 00                	mov    (%eax),%eax
    173a:	6a 01                	push   $0x1
    173c:	6a 0a                	push   $0xa
    173e:	50                   	push   %eax
    173f:	ff 75 08             	pushl  0x8(%ebp)
    1742:	e8 c1 fe ff ff       	call   1608 <printint>
    1747:	83 c4 10             	add    $0x10,%esp
        ap++;
    174a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    174e:	e9 d8 00 00 00       	jmp    182b <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1753:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1757:	74 06                	je     175f <printf+0xa4>
    1759:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    175d:	75 1e                	jne    177d <printf+0xc2>
        printint(fd, *ap, 16, 0);
    175f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1762:	8b 00                	mov    (%eax),%eax
    1764:	6a 00                	push   $0x0
    1766:	6a 10                	push   $0x10
    1768:	50                   	push   %eax
    1769:	ff 75 08             	pushl  0x8(%ebp)
    176c:	e8 97 fe ff ff       	call   1608 <printint>
    1771:	83 c4 10             	add    $0x10,%esp
        ap++;
    1774:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1778:	e9 ae 00 00 00       	jmp    182b <printf+0x170>
      } else if(c == 's'){
    177d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1781:	75 43                	jne    17c6 <printf+0x10b>
        s = (char*)*ap;
    1783:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1786:	8b 00                	mov    (%eax),%eax
    1788:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    178b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    178f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1793:	75 07                	jne    179c <printf+0xe1>
          s = "(null)";
    1795:	c7 45 f4 d0 1b 00 00 	movl   $0x1bd0,-0xc(%ebp)
        while(*s != 0){
    179c:	eb 1c                	jmp    17ba <printf+0xff>
          putc(fd, *s);
    179e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a1:	0f b6 00             	movzbl (%eax),%eax
    17a4:	0f be c0             	movsbl %al,%eax
    17a7:	83 ec 08             	sub    $0x8,%esp
    17aa:	50                   	push   %eax
    17ab:	ff 75 08             	pushl  0x8(%ebp)
    17ae:	e8 33 fe ff ff       	call   15e6 <putc>
    17b3:	83 c4 10             	add    $0x10,%esp
          s++;
    17b6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    17ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bd:	0f b6 00             	movzbl (%eax),%eax
    17c0:	84 c0                	test   %al,%al
    17c2:	75 da                	jne    179e <printf+0xe3>
    17c4:	eb 65                	jmp    182b <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    17c6:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    17ca:	75 1d                	jne    17e9 <printf+0x12e>
        putc(fd, *ap);
    17cc:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17cf:	8b 00                	mov    (%eax),%eax
    17d1:	0f be c0             	movsbl %al,%eax
    17d4:	83 ec 08             	sub    $0x8,%esp
    17d7:	50                   	push   %eax
    17d8:	ff 75 08             	pushl  0x8(%ebp)
    17db:	e8 06 fe ff ff       	call   15e6 <putc>
    17e0:	83 c4 10             	add    $0x10,%esp
        ap++;
    17e3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    17e7:	eb 42                	jmp    182b <printf+0x170>
      } else if(c == '%'){
    17e9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    17ed:	75 17                	jne    1806 <printf+0x14b>
        putc(fd, c);
    17ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    17f2:	0f be c0             	movsbl %al,%eax
    17f5:	83 ec 08             	sub    $0x8,%esp
    17f8:	50                   	push   %eax
    17f9:	ff 75 08             	pushl  0x8(%ebp)
    17fc:	e8 e5 fd ff ff       	call   15e6 <putc>
    1801:	83 c4 10             	add    $0x10,%esp
    1804:	eb 25                	jmp    182b <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1806:	83 ec 08             	sub    $0x8,%esp
    1809:	6a 25                	push   $0x25
    180b:	ff 75 08             	pushl  0x8(%ebp)
    180e:	e8 d3 fd ff ff       	call   15e6 <putc>
    1813:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1816:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1819:	0f be c0             	movsbl %al,%eax
    181c:	83 ec 08             	sub    $0x8,%esp
    181f:	50                   	push   %eax
    1820:	ff 75 08             	pushl  0x8(%ebp)
    1823:	e8 be fd ff ff       	call   15e6 <putc>
    1828:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    182b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1832:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1836:	8b 55 0c             	mov    0xc(%ebp),%edx
    1839:	8b 45 f0             	mov    -0x10(%ebp),%eax
    183c:	01 d0                	add    %edx,%eax
    183e:	0f b6 00             	movzbl (%eax),%eax
    1841:	84 c0                	test   %al,%al
    1843:	0f 85 94 fe ff ff    	jne    16dd <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1849:	c9                   	leave  
    184a:	c3                   	ret    

0000184b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    184b:	55                   	push   %ebp
    184c:	89 e5                	mov    %esp,%ebp
    184e:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1851:	8b 45 08             	mov    0x8(%ebp),%eax
    1854:	83 e8 08             	sub    $0x8,%eax
    1857:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    185a:	a1 ac 21 00 00       	mov    0x21ac,%eax
    185f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1862:	eb 24                	jmp    1888 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1864:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1867:	8b 00                	mov    (%eax),%eax
    1869:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    186c:	77 12                	ja     1880 <free+0x35>
    186e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1871:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1874:	77 24                	ja     189a <free+0x4f>
    1876:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1879:	8b 00                	mov    (%eax),%eax
    187b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    187e:	77 1a                	ja     189a <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1880:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1883:	8b 00                	mov    (%eax),%eax
    1885:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1888:	8b 45 f8             	mov    -0x8(%ebp),%eax
    188b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    188e:	76 d4                	jbe    1864 <free+0x19>
    1890:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1893:	8b 00                	mov    (%eax),%eax
    1895:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1898:	76 ca                	jbe    1864 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    189a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    189d:	8b 40 04             	mov    0x4(%eax),%eax
    18a0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    18a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18aa:	01 c2                	add    %eax,%edx
    18ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18af:	8b 00                	mov    (%eax),%eax
    18b1:	39 c2                	cmp    %eax,%edx
    18b3:	75 24                	jne    18d9 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    18b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18b8:	8b 50 04             	mov    0x4(%eax),%edx
    18bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18be:	8b 00                	mov    (%eax),%eax
    18c0:	8b 40 04             	mov    0x4(%eax),%eax
    18c3:	01 c2                	add    %eax,%edx
    18c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18c8:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    18cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18ce:	8b 00                	mov    (%eax),%eax
    18d0:	8b 10                	mov    (%eax),%edx
    18d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18d5:	89 10                	mov    %edx,(%eax)
    18d7:	eb 0a                	jmp    18e3 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    18d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18dc:	8b 10                	mov    (%eax),%edx
    18de:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18e1:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    18e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18e6:	8b 40 04             	mov    0x4(%eax),%eax
    18e9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    18f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18f3:	01 d0                	add    %edx,%eax
    18f5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    18f8:	75 20                	jne    191a <free+0xcf>
    p->s.size += bp->s.size;
    18fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18fd:	8b 50 04             	mov    0x4(%eax),%edx
    1900:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1903:	8b 40 04             	mov    0x4(%eax),%eax
    1906:	01 c2                	add    %eax,%edx
    1908:	8b 45 fc             	mov    -0x4(%ebp),%eax
    190b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    190e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1911:	8b 10                	mov    (%eax),%edx
    1913:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1916:	89 10                	mov    %edx,(%eax)
    1918:	eb 08                	jmp    1922 <free+0xd7>
  } else
    p->s.ptr = bp;
    191a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    191d:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1920:	89 10                	mov    %edx,(%eax)
  freep = p;
    1922:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1925:	a3 ac 21 00 00       	mov    %eax,0x21ac
}
    192a:	c9                   	leave  
    192b:	c3                   	ret    

0000192c <morecore>:

static Header*
morecore(uint nu)
{
    192c:	55                   	push   %ebp
    192d:	89 e5                	mov    %esp,%ebp
    192f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1932:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1939:	77 07                	ja     1942 <morecore+0x16>
    nu = 4096;
    193b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1942:	8b 45 08             	mov    0x8(%ebp),%eax
    1945:	c1 e0 03             	shl    $0x3,%eax
    1948:	83 ec 0c             	sub    $0xc,%esp
    194b:	50                   	push   %eax
    194c:	e8 75 fc ff ff       	call   15c6 <sbrk>
    1951:	83 c4 10             	add    $0x10,%esp
    1954:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1957:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    195b:	75 07                	jne    1964 <morecore+0x38>
    return 0;
    195d:	b8 00 00 00 00       	mov    $0x0,%eax
    1962:	eb 26                	jmp    198a <morecore+0x5e>
  hp = (Header*)p;
    1964:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1967:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    196a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    196d:	8b 55 08             	mov    0x8(%ebp),%edx
    1970:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1973:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1976:	83 c0 08             	add    $0x8,%eax
    1979:	83 ec 0c             	sub    $0xc,%esp
    197c:	50                   	push   %eax
    197d:	e8 c9 fe ff ff       	call   184b <free>
    1982:	83 c4 10             	add    $0x10,%esp
  return freep;
    1985:	a1 ac 21 00 00       	mov    0x21ac,%eax
}
    198a:	c9                   	leave  
    198b:	c3                   	ret    

0000198c <malloc>:

void*
malloc(uint nbytes)
{
    198c:	55                   	push   %ebp
    198d:	89 e5                	mov    %esp,%ebp
    198f:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1992:	8b 45 08             	mov    0x8(%ebp),%eax
    1995:	83 c0 07             	add    $0x7,%eax
    1998:	c1 e8 03             	shr    $0x3,%eax
    199b:	83 c0 01             	add    $0x1,%eax
    199e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    19a1:	a1 ac 21 00 00       	mov    0x21ac,%eax
    19a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    19a9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    19ad:	75 23                	jne    19d2 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    19af:	c7 45 f0 a4 21 00 00 	movl   $0x21a4,-0x10(%ebp)
    19b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19b9:	a3 ac 21 00 00       	mov    %eax,0x21ac
    19be:	a1 ac 21 00 00       	mov    0x21ac,%eax
    19c3:	a3 a4 21 00 00       	mov    %eax,0x21a4
    base.s.size = 0;
    19c8:	c7 05 a8 21 00 00 00 	movl   $0x0,0x21a8
    19cf:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    19d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19d5:	8b 00                	mov    (%eax),%eax
    19d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    19da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19dd:	8b 40 04             	mov    0x4(%eax),%eax
    19e0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    19e3:	72 4d                	jb     1a32 <malloc+0xa6>
      if(p->s.size == nunits)
    19e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e8:	8b 40 04             	mov    0x4(%eax),%eax
    19eb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    19ee:	75 0c                	jne    19fc <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    19f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19f3:	8b 10                	mov    (%eax),%edx
    19f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19f8:	89 10                	mov    %edx,(%eax)
    19fa:	eb 26                	jmp    1a22 <malloc+0x96>
      else {
        p->s.size -= nunits;
    19fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ff:	8b 40 04             	mov    0x4(%eax),%eax
    1a02:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1a05:	89 c2                	mov    %eax,%edx
    1a07:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a0a:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1a0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a10:	8b 40 04             	mov    0x4(%eax),%eax
    1a13:	c1 e0 03             	shl    $0x3,%eax
    1a16:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1a19:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a1c:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1a1f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1a22:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a25:	a3 ac 21 00 00       	mov    %eax,0x21ac
      return (void*)(p + 1);
    1a2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a2d:	83 c0 08             	add    $0x8,%eax
    1a30:	eb 3b                	jmp    1a6d <malloc+0xe1>
    }
    if(p == freep)
    1a32:	a1 ac 21 00 00       	mov    0x21ac,%eax
    1a37:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1a3a:	75 1e                	jne    1a5a <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    1a3c:	83 ec 0c             	sub    $0xc,%esp
    1a3f:	ff 75 ec             	pushl  -0x14(%ebp)
    1a42:	e8 e5 fe ff ff       	call   192c <morecore>
    1a47:	83 c4 10             	add    $0x10,%esp
    1a4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a4d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a51:	75 07                	jne    1a5a <malloc+0xce>
        return 0;
    1a53:	b8 00 00 00 00       	mov    $0x0,%eax
    1a58:	eb 13                	jmp    1a6d <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1a5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a60:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a63:	8b 00                	mov    (%eax),%eax
    1a65:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1a68:	e9 6d ff ff ff       	jmp    19da <malloc+0x4e>
}
    1a6d:	c9                   	leave  
    1a6e:	c3                   	ret    
