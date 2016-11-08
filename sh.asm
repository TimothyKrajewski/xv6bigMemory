
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
       c:	e8 67 15 00 00       	call   1578 <exit>
  
  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 e0 1a 00 00 	mov    0x1ae0(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 b4 1a 00 00       	push   $0x1ab4
      2c:	e8 16 0a 00 00       	call   a47 <panic>
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
      44:	e8 2f 15 00 00       	call   1578 <exit>
    exec(ecmd->argv[0], ecmd->argv);
      49:	8b 45 f4             	mov    -0xc(%ebp),%eax
      4c:	8d 50 04             	lea    0x4(%eax),%edx
      4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      52:	8b 40 04             	mov    0x4(%eax),%eax
      55:	83 ec 08             	sub    $0x8,%esp
      58:	52                   	push   %edx
      59:	50                   	push   %eax
      5a:	e8 51 15 00 00       	call   15b0 <exec>
      5f:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      62:	8b 45 f4             	mov    -0xc(%ebp),%eax
      65:	8b 40 04             	mov    0x4(%eax),%eax
      68:	83 ec 04             	sub    $0x4,%esp
      6b:	50                   	push   %eax
      6c:	68 bb 1a 00 00       	push   $0x1abb
      71:	6a 02                	push   $0x2
      73:	e8 85 16 00 00       	call   16fd <printf>
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
      90:	e8 0b 15 00 00       	call   15a0 <close>
      95:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
      98:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9b:	8b 50 10             	mov    0x10(%eax),%edx
      9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
      a1:	8b 40 08             	mov    0x8(%eax),%eax
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	52                   	push   %edx
      a8:	50                   	push   %eax
      a9:	e8 0a 15 00 00       	call   15b8 <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	85 c0                	test   %eax,%eax
      b3:	79 1e                	jns    d3 <runcmd+0xd3>
      printf(2, "open %s failed\n", rcmd->file);
      b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
      b8:	8b 40 08             	mov    0x8(%eax),%eax
      bb:	83 ec 04             	sub    $0x4,%esp
      be:	50                   	push   %eax
      bf:	68 cb 1a 00 00       	push   $0x1acb
      c4:	6a 02                	push   $0x2
      c6:	e8 32 16 00 00       	call   16fd <printf>
      cb:	83 c4 10             	add    $0x10,%esp
      exit();
      ce:	e8 a5 14 00 00       	call   1578 <exit>
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
      f0:	e8 72 09 00 00       	call   a67 <fork1>
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
     10b:	e8 70 14 00 00       	call   1580 <wait>
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
     134:	e8 4f 14 00 00       	call   1588 <pipe>
     139:	83 c4 10             	add    $0x10,%esp
     13c:	85 c0                	test   %eax,%eax
     13e:	79 10                	jns    150 <runcmd+0x150>
      panic("pipe");
     140:	83 ec 0c             	sub    $0xc,%esp
     143:	68 db 1a 00 00       	push   $0x1adb
     148:	e8 fa 08 00 00       	call   a47 <panic>
     14d:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
     150:	e8 12 09 00 00       	call   a67 <fork1>
     155:	85 c0                	test   %eax,%eax
     157:	75 4c                	jne    1a5 <runcmd+0x1a5>
      close(1);
     159:	83 ec 0c             	sub    $0xc,%esp
     15c:	6a 01                	push   $0x1
     15e:	e8 3d 14 00 00       	call   15a0 <close>
     163:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
     166:	8b 45 e0             	mov    -0x20(%ebp),%eax
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	50                   	push   %eax
     16d:	e8 7e 14 00 00       	call   15f0 <dup>
     172:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     175:	8b 45 dc             	mov    -0x24(%ebp),%eax
     178:	83 ec 0c             	sub    $0xc,%esp
     17b:	50                   	push   %eax
     17c:	e8 1f 14 00 00       	call   15a0 <close>
     181:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     184:	8b 45 e0             	mov    -0x20(%ebp),%eax
     187:	83 ec 0c             	sub    $0xc,%esp
     18a:	50                   	push   %eax
     18b:	e8 10 14 00 00       	call   15a0 <close>
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
     1a5:	e8 bd 08 00 00       	call   a67 <fork1>
     1aa:	85 c0                	test   %eax,%eax
     1ac:	75 4c                	jne    1fa <runcmd+0x1fa>
      close(0);
     1ae:	83 ec 0c             	sub    $0xc,%esp
     1b1:	6a 00                	push   $0x0
     1b3:	e8 e8 13 00 00       	call   15a0 <close>
     1b8:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
     1bb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1be:	83 ec 0c             	sub    $0xc,%esp
     1c1:	50                   	push   %eax
     1c2:	e8 29 14 00 00       	call   15f0 <dup>
     1c7:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     1ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1cd:	83 ec 0c             	sub    $0xc,%esp
     1d0:	50                   	push   %eax
     1d1:	e8 ca 13 00 00       	call   15a0 <close>
     1d6:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     1d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1dc:	83 ec 0c             	sub    $0xc,%esp
     1df:	50                   	push   %eax
     1e0:	e8 bb 13 00 00       	call   15a0 <close>
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
     201:	e8 9a 13 00 00       	call   15a0 <close>
     206:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
     209:	8b 45 e0             	mov    -0x20(%ebp),%eax
     20c:	83 ec 0c             	sub    $0xc,%esp
     20f:	50                   	push   %eax
     210:	e8 8b 13 00 00       	call   15a0 <close>
     215:	83 c4 10             	add    $0x10,%esp
    wait();
     218:	e8 63 13 00 00       	call   1580 <wait>
    wait();
     21d:	e8 5e 13 00 00       	call   1580 <wait>
    break;
     222:	eb 24                	jmp    248 <runcmd+0x248>
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
     224:	8b 45 08             	mov    0x8(%ebp),%eax
     227:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(fork1() == 0)
     22a:	e8 38 08 00 00       	call   a67 <fork1>
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
     248:	e8 2b 13 00 00       	call   1578 <exit>

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
     256:	68 f8 1a 00 00       	push   $0x1af8
     25b:	6a 02                	push   $0x2
     25d:	e8 9b 14 00 00       	call   16fd <printf>
     262:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     265:	8b 45 0c             	mov    0xc(%ebp),%eax
     268:	83 ec 04             	sub    $0x4,%esp
     26b:	50                   	push   %eax
     26c:	6a 00                	push   $0x0
     26e:	ff 75 08             	pushl  0x8(%ebp)
     271:	e8 68 11 00 00       	call   13de <memset>
     276:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     279:	83 ec 08             	sub    $0x8,%esp
     27c:	ff 75 0c             	pushl  0xc(%ebp)
     27f:	ff 75 08             	pushl  0x8(%ebp)
     282:	e8 a4 11 00 00       	call   142b <gets>
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
     2f1:	68 fb 1a 00 00       	push   $0x1afb
     2f6:	6a 02                	push   $0x2
     2f8:	e8 00 14 00 00       	call   16fd <printf>
     2fd:	83 c4 10             	add    $0x10,%esp
		printf(2, "%s \n", history[currLoc]);
     300:	8b 45 f4             	mov    -0xc(%ebp),%eax
     303:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     30a:	8b 45 08             	mov    0x8(%ebp),%eax
     30d:	01 d0                	add    %edx,%eax
     30f:	8b 00                	mov    (%eax),%eax
     311:	83 ec 04             	sub    $0x4,%esp
     314:	50                   	push   %eax
     315:	68 ff 1a 00 00       	push   $0x1aff
     31a:	6a 02                	push   $0x2
     31c:	e8 dc 13 00 00       	call   16fd <printf>
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
     34e:	68 fb 1a 00 00       	push   $0x1afb
     353:	6a 02                	push   $0x2
     355:	e8 a3 13 00 00       	call   16fd <printf>
     35a:	83 c4 10             	add    $0x10,%esp
		printf(2, "%s \n", history[currLoc]);
     35d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     360:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     367:	8b 45 08             	mov    0x8(%ebp),%eax
     36a:	01 d0                	add    %edx,%eax
     36c:	8b 00                	mov    (%eax),%eax
     36e:	83 ec 04             	sub    $0x4,%esp
     371:	50                   	push   %eax
     372:	68 ff 1a 00 00       	push   $0x1aff
     377:	6a 02                	push   $0x2
     379:	e8 7f 13 00 00       	call   16fd <printf>
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
     39e:	68 fb 1a 00 00       	push   $0x1afb
     3a3:	6a 02                	push   $0x2
     3a5:	e8 53 13 00 00       	call   16fd <printf>
     3aa:	83 c4 10             	add    $0x10,%esp
		printf(2, "%s \n", history[currLoc]);
     3ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3b0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     3b7:	8b 45 08             	mov    0x8(%ebp),%eax
     3ba:	01 d0                	add    %edx,%eax
     3bc:	8b 00                	mov    (%eax),%eax
     3be:	83 ec 04             	sub    $0x4,%esp
     3c1:	50                   	push   %eax
     3c2:	68 ff 1a 00 00       	push   $0x1aff
     3c7:	6a 02                	push   $0x2
     3c9:	e8 2f 13 00 00       	call   16fd <printf>
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
     438:	e8 0b 0f 00 00       	call   1348 <strcpy>
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
     494:	e8 af 0e 00 00       	call   1348 <strcpy>
     499:	83 c4 10             	add    $0x10,%esp
	printf(2, "%s\n", buffer);
     49c:	83 ec 04             	sub    $0x4,%esp
     49f:	ff 75 0c             	pushl  0xc(%ebp)
     4a2:	68 04 1b 00 00       	push   $0x1b04
     4a7:	6a 02                	push   $0x2
     4a9:	e8 4f 12 00 00       	call   16fd <printf>
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
     4cb:	68 08 1b 00 00       	push   $0x1b08
     4d0:	6a 02                	push   $0x2
     4d2:	e8 26 12 00 00       	call   16fd <printf>
     4d7:	83 c4 10             	add    $0x10,%esp
printf(2, "%s\n", history[index]);
     4da:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     4e4:	8b 45 08             	mov    0x8(%ebp),%eax
     4e7:	01 d0                	add    %edx,%eax
     4e9:	8b 00                	mov    (%eax),%eax
     4eb:	83 ec 04             	sub    $0x4,%esp
     4ee:	50                   	push   %eax
     4ef:	68 04 1b 00 00       	push   $0x1b04
     4f4:	6a 02                	push   $0x2
     4f6:	e8 02 12 00 00       	call   16fd <printf>
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
     648:	e8 81 13 00 00       	call   19ce <malloc>
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
     671:	e8 58 13 00 00       	call   19ce <malloc>
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
     6a7:	e8 f4 0e 00 00       	call   15a0 <close>
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
     6b6:	68 0d 1b 00 00       	push   $0x1b0d
     6bb:	e8 f8 0e 00 00       	call   15b8 <open>
     6c0:	83 c4 10             	add    $0x10,%esp
     6c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     6c6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     6ca:	79 cf                	jns    69b <main+0x6d>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     6cc:	e9 57 03 00 00       	jmp    a28 <main+0x3fa>
	buf[strlen(buf) - 1] =0;
     6d1:	83 ec 0c             	sub    $0xc,%esp
     6d4:	68 c0 21 00 00       	push   $0x21c0
     6d9:	e8 d9 0c 00 00       	call   13b7 <strlen>
     6de:	83 c4 10             	add    $0x10,%esp
     6e1:	83 e8 01             	sub    $0x1,%eax
     6e4:	c6 80 c0 21 00 00 00 	movb   $0x0,0x21c0(%eax)
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     6eb:	0f b6 05 c0 21 00 00 	movzbl 0x21c0,%eax
     6f2:	3c 63                	cmp    $0x63,%al
     6f4:	75 60                	jne    756 <main+0x128>
     6f6:	0f b6 05 c1 21 00 00 	movzbl 0x21c1,%eax
     6fd:	3c 64                	cmp    $0x64,%al
     6ff:	75 55                	jne    756 <main+0x128>
     701:	0f b6 05 c2 21 00 00 	movzbl 0x21c2,%eax
     708:	3c 20                	cmp    $0x20,%al
     70a:	75 4a                	jne    756 <main+0x128>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     70c:	83 ec 0c             	sub    $0xc,%esp
     70f:	68 c0 21 00 00       	push   $0x21c0
     714:	e8 9e 0c 00 00       	call   13b7 <strlen>
     719:	83 c4 10             	add    $0x10,%esp
     71c:	83 e8 01             	sub    $0x1,%eax
     71f:	c6 80 c0 21 00 00 00 	movb   $0x0,0x21c0(%eax)
      if(chdir(buf+3) < 0)
     726:	83 ec 0c             	sub    $0xc,%esp
     729:	68 c3 21 00 00       	push   $0x21c3
     72e:	e8 b5 0e 00 00       	call   15e8 <chdir>
     733:	83 c4 10             	add    $0x10,%esp
     736:	85 c0                	test   %eax,%eax
     738:	79 17                	jns    751 <main+0x123>
        printf(2, "cannot cd %s\n", buf+3);
     73a:	83 ec 04             	sub    $0x4,%esp
     73d:	68 c3 21 00 00       	push   $0x21c3
     742:	68 15 1b 00 00       	push   $0x1b15
     747:	6a 02                	push   $0x2
     749:	e8 af 0f 00 00       	call   16fd <printf>
     74e:	83 c4 10             	add    $0x10,%esp
      continue;
     751:	e9 d2 02 00 00       	jmp    a28 <main+0x3fa>
    }
    char* temp = &buf[0];
     756:	c7 45 e0 c0 21 00 00 	movl   $0x21c0,-0x20(%ebp)
    
    //runs historyOut to print history
    if(strcmp(buf, "history")== 0)
     75d:	83 ec 08             	sub    $0x8,%esp
     760:	68 23 1b 00 00       	push   $0x1b23
     765:	68 c0 21 00 00       	push   $0x21c0
     76a:	e8 09 0c 00 00       	call   1378 <strcmp>
     76f:	83 c4 10             	add    $0x10,%esp
     772:	85 c0                	test   %eax,%eax
     774:	75 30                	jne    7a6 <main+0x178>
    {
	if(histNum < 1)
     776:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     77a:	7f 14                	jg     790 <main+0x162>
		printf(1, "No commands in history\n");
     77c:	83 ec 08             	sub    $0x8,%esp
     77f:	68 2b 1b 00 00       	push   $0x1b2b
     784:	6a 01                	push   $0x1
     786:	e8 72 0f 00 00       	call   16fd <printf>
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
     7a1:	e9 82 02 00 00       	jmp    a28 <main+0x3fa>
    }
    //calls lastHistory to rerun the last command entered
    if(strcmp(buf, "!!") == 0)
     7a6:	83 ec 08             	sub    $0x8,%esp
     7a9:	68 43 1b 00 00       	push   $0x1b43
     7ae:	68 c0 21 00 00       	push   $0x21c0
     7b3:	e8 c0 0b 00 00       	call   1378 <strcmp>
     7b8:	83 c4 10             	add    $0x10,%esp
     7bb:	85 c0                	test   %eax,%eax
     7bd:	0f 85 89 00 00 00    	jne    84c <main+0x21e>
    {
	if(histNum < 1)
     7c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7c7:	7f 14                	jg     7dd <main+0x1af>
		printf(1, "No commands in history\n");
     7c9:	83 ec 08             	sub    $0x8,%esp
     7cc:	68 2b 1b 00 00       	push   $0x1b2b
     7d1:	6a 01                	push   $0x1
     7d3:	e8 25 0f 00 00       	call   16fd <printf>
     7d8:	83 c4 10             	add    $0x10,%esp
     7db:	eb 6a                	jmp    847 <main+0x219>
	else
	{
	strcpy(buf,lastHistory(history, buf, histNum));
     7dd:	83 ec 04             	sub    $0x4,%esp
     7e0:	ff 75 f4             	pushl  -0xc(%ebp)
     7e3:	68 c0 21 00 00       	push   $0x21c0
     7e8:	ff 75 e8             	pushl  -0x18(%ebp)
     7eb:	e8 55 fc ff ff       	call   445 <lastHistory>
     7f0:	83 c4 10             	add    $0x10,%esp
     7f3:	83 ec 08             	sub    $0x8,%esp
     7f6:	50                   	push   %eax
     7f7:	68 c0 21 00 00       	push   $0x21c0
     7fc:	e8 47 0b 00 00       	call   1348 <strcpy>
     801:	83 c4 10             	add    $0x10,%esp
	histNum = historyUpdate(history, buf, histNum);
     804:	83 ec 04             	sub    $0x4,%esp
     807:	ff 75 f4             	pushl  -0xc(%ebp)
     80a:	68 c0 21 00 00       	push   $0x21c0
     80f:	ff 75 e8             	pushl  -0x18(%ebp)
     812:	e8 d1 fb ff ff       	call   3e8 <historyUpdate>
     817:	83 c4 10             	add    $0x10,%esp
     81a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if(fork1() == 0)
     81d:	e8 45 02 00 00       	call   a67 <fork1>
     822:	85 c0                	test   %eax,%eax
     824:	75 1c                	jne    842 <main+0x214>
	{	
	runcmd(parsecmd(buf));
     826:	83 ec 0c             	sub    $0xc,%esp
     829:	68 c0 21 00 00       	push   $0x21c0
     82e:	e8 88 05 00 00       	call   dbb <parsecmd>
     833:	83 c4 10             	add    $0x10,%esp
     836:	83 ec 0c             	sub    $0xc,%esp
     839:	50                   	push   %eax
     83a:	e8 c1 f7 ff ff       	call   0 <runcmd>
     83f:	83 c4 10             	add    $0x10,%esp
	}
	wait();
     842:	e8 39 0d 00 00       	call   1580 <wait>
	}
	continue;
     847:	e9 dc 01 00 00       	jmp    a28 <main+0x3fa>
    }

     if(strcmp(buf, "ps") == 0)
     84c:	83 ec 08             	sub    $0x8,%esp
     84f:	68 46 1b 00 00       	push   $0x1b46
     854:	68 c0 21 00 00       	push   $0x21c0
     859:	e8 1a 0b 00 00       	call   1378 <strcmp>
     85e:	83 c4 10             	add    $0x10,%esp
     861:	85 c0                	test   %eax,%eax
     863:	75 21                	jne    886 <main+0x258>
	{
		histNum = historyUpdate(history, temp, histNum);
     865:	83 ec 04             	sub    $0x4,%esp
     868:	ff 75 f4             	pushl  -0xc(%ebp)
     86b:	ff 75 e0             	pushl  -0x20(%ebp)
     86e:	ff 75 e8             	pushl  -0x18(%ebp)
     871:	e8 72 fb ff ff       	call   3e8 <historyUpdate>
     876:	83 c4 10             	add    $0x10,%esp
     879:	89 45 f4             	mov    %eax,-0xc(%ebp)
		ps();
     87c:	e8 9f 0d 00 00       	call   1620 <ps>
		continue;
     881:	e9 a2 01 00 00       	jmp    a28 <main+0x3fa>
	}
    //determines the value entered after ! and calls chooseFromHistory with that value
    if(buf[0] == '!' && buf[1] != '!')
     886:	0f b6 05 c0 21 00 00 	movzbl 0x21c0,%eax
     88d:	3c 21                	cmp    $0x21,%al
     88f:	0f 85 52 01 00 00    	jne    9e7 <main+0x3b9>
     895:	0f b6 05 c1 21 00 00 	movzbl 0x21c1,%eax
     89c:	3c 21                	cmp    $0x21,%al
     89e:	0f 84 43 01 00 00    	je     9e7 <main+0x3b9>
    {
	if(digCheck(buf[1]))
     8a4:	0f b6 05 c1 21 00 00 	movzbl 0x21c1,%eax
     8ab:	0f be c0             	movsbl %al,%eax
     8ae:	83 ec 0c             	sub    $0xc,%esp
     8b1:	50                   	push   %eax
     8b2:	e8 5a fc ff ff       	call   511 <digCheck>
     8b7:	83 c4 10             	add    $0x10,%esp
     8ba:	85 c0                	test   %eax,%eax
     8bc:	0f 84 11 01 00 00    	je     9d3 <main+0x3a5>
	{
		int test = 0;
     8c2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		if(digCheck(buf[2])){test = 10*convertDigit(buf[1]) + convertDigit(buf[2]);}
     8c9:	0f b6 05 c2 21 00 00 	movzbl 0x21c2,%eax
     8d0:	0f be c0             	movsbl %al,%eax
     8d3:	83 ec 0c             	sub    $0xc,%esp
     8d6:	50                   	push   %eax
     8d7:	e8 35 fc ff ff       	call   511 <digCheck>
     8dc:	83 c4 10             	add    $0x10,%esp
     8df:	85 c0                	test   %eax,%eax
     8e1:	74 40                	je     923 <main+0x2f5>
     8e3:	0f b6 05 c1 21 00 00 	movzbl 0x21c1,%eax
     8ea:	0f be c0             	movsbl %al,%eax
     8ed:	83 ec 0c             	sub    $0xc,%esp
     8f0:	50                   	push   %eax
     8f1:	e8 b0 fc ff ff       	call   5a6 <convertDigit>
     8f6:	83 c4 10             	add    $0x10,%esp
     8f9:	89 c2                	mov    %eax,%edx
     8fb:	89 d0                	mov    %edx,%eax
     8fd:	c1 e0 02             	shl    $0x2,%eax
     900:	01 d0                	add    %edx,%eax
     902:	01 c0                	add    %eax,%eax
     904:	89 c3                	mov    %eax,%ebx
     906:	0f b6 05 c2 21 00 00 	movzbl 0x21c2,%eax
     90d:	0f be c0             	movsbl %al,%eax
     910:	83 ec 0c             	sub    $0xc,%esp
     913:	50                   	push   %eax
     914:	e8 8d fc ff ff       	call   5a6 <convertDigit>
     919:	83 c4 10             	add    $0x10,%esp
     91c:	01 d8                	add    %ebx,%eax
     91e:	89 45 ec             	mov    %eax,-0x14(%ebp)
     921:	eb 19                	jmp    93c <main+0x30e>
		else test = convertDigit(buf[1]);
     923:	0f b6 05 c1 21 00 00 	movzbl 0x21c1,%eax
     92a:	0f be c0             	movsbl %al,%eax
     92d:	83 ec 0c             	sub    $0xc,%esp
     930:	50                   	push   %eax
     931:	e8 70 fc ff ff       	call   5a6 <convertDigit>
     936:	83 c4 10             	add    $0x10,%esp
     939:	89 45 ec             	mov    %eax,-0x14(%ebp)
		
			if(test > 0 && test <= histNum && test > histNum - 10)
     93c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     940:	7e 7d                	jle    9bf <main+0x391>
     942:	8b 45 ec             	mov    -0x14(%ebp),%eax
     945:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     948:	7f 75                	jg     9bf <main+0x391>
     94a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     94d:	83 e8 0a             	sub    $0xa,%eax
     950:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     953:	7d 6a                	jge    9bf <main+0x391>
			{
				strcpy(buf, chooseFromHistory(history, histNum, test));
     955:	83 ec 04             	sub    $0x4,%esp
     958:	ff 75 ec             	pushl  -0x14(%ebp)
     95b:	ff 75 f4             	pushl  -0xc(%ebp)
     95e:	ff 75 e8             	pushl  -0x18(%ebp)
     961:	e8 50 fb ff ff       	call   4b6 <chooseFromHistory>
     966:	83 c4 10             	add    $0x10,%esp
     969:	83 ec 08             	sub    $0x8,%esp
     96c:	50                   	push   %eax
     96d:	68 c0 21 00 00       	push   $0x21c0
     972:	e8 d1 09 00 00       	call   1348 <strcpy>
     977:	83 c4 10             	add    $0x10,%esp
				histNum = historyUpdate(history, buf, histNum);
     97a:	83 ec 04             	sub    $0x4,%esp
     97d:	ff 75 f4             	pushl  -0xc(%ebp)
     980:	68 c0 21 00 00       	push   $0x21c0
     985:	ff 75 e8             	pushl  -0x18(%ebp)
     988:	e8 5b fa ff ff       	call   3e8 <historyUpdate>
     98d:	83 c4 10             	add    $0x10,%esp
     990:	89 45 f4             	mov    %eax,-0xc(%ebp)
				if(fork1() == 0)
     993:	e8 cf 00 00 00       	call   a67 <fork1>
     998:	85 c0                	test   %eax,%eax
     99a:	75 1c                	jne    9b8 <main+0x38a>
				{
				runcmd(parsecmd(buf));
     99c:	83 ec 0c             	sub    $0xc,%esp
     99f:	68 c0 21 00 00       	push   $0x21c0
     9a4:	e8 12 04 00 00       	call   dbb <parsecmd>
     9a9:	83 c4 10             	add    $0x10,%esp
     9ac:	83 ec 0c             	sub    $0xc,%esp
     9af:	50                   	push   %eax
     9b0:	e8 4b f6 ff ff       	call   0 <runcmd>
     9b5:	83 c4 10             	add    $0x10,%esp
				}
				wait();
     9b8:	e8 c3 0b 00 00       	call   1580 <wait>
     9bd:	eb 12                	jmp    9d1 <main+0x3a3>
			}
			else
			printf(1, "This value is not in the history.\n");
     9bf:	83 ec 08             	sub    $0x8,%esp
     9c2:	68 4c 1b 00 00       	push   $0x1b4c
     9c7:	6a 01                	push   $0x1
     9c9:	e8 2f 0d 00 00       	call   16fd <printf>
     9ce:	83 c4 10             	add    $0x10,%esp

		continue;
     9d1:	eb 55                	jmp    a28 <main+0x3fa>
	}
	else {printf(1, "Error incorrect format");
     9d3:	83 ec 08             	sub    $0x8,%esp
     9d6:	68 6f 1b 00 00       	push   $0x1b6f
     9db:	6a 01                	push   $0x1
     9dd:	e8 1b 0d 00 00       	call   16fd <printf>
     9e2:	83 c4 10             	add    $0x10,%esp
	continue;}
     9e5:	eb 41                	jmp    a28 <main+0x3fa>
    }
    //defaults and runs the command on xv6
    else{
    histNum = historyUpdate(history, temp, histNum);
     9e7:	83 ec 04             	sub    $0x4,%esp
     9ea:	ff 75 f4             	pushl  -0xc(%ebp)
     9ed:	ff 75 e0             	pushl  -0x20(%ebp)
     9f0:	ff 75 e8             	pushl  -0x18(%ebp)
     9f3:	e8 f0 f9 ff ff       	call   3e8 <historyUpdate>
     9f8:	83 c4 10             	add    $0x10,%esp
     9fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(fork1() == 0)
     9fe:	e8 64 00 00 00       	call   a67 <fork1>
     a03:	85 c0                	test   %eax,%eax
     a05:	75 1c                	jne    a23 <main+0x3f5>
    {
      runcmd(parsecmd(buf));
     a07:	83 ec 0c             	sub    $0xc,%esp
     a0a:	68 c0 21 00 00       	push   $0x21c0
     a0f:	e8 a7 03 00 00       	call   dbb <parsecmd>
     a14:	83 c4 10             	add    $0x10,%esp
     a17:	83 ec 0c             	sub    $0xc,%esp
     a1a:	50                   	push   %eax
     a1b:	e8 e0 f5 ff ff       	call   0 <runcmd>
     a20:	83 c4 10             	add    $0x10,%esp
    }
    wait();
     a23:	e8 58 0b 00 00       	call   1580 <wait>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     a28:	83 ec 08             	sub    $0x8,%esp
     a2b:	6a 64                	push   $0x64
     a2d:	68 c0 21 00 00       	push   $0x21c0
     a32:	e8 16 f8 ff ff       	call   24d <getcmd>
     a37:	83 c4 10             	add    $0x10,%esp
     a3a:	85 c0                	test   %eax,%eax
     a3c:	0f 89 8f fc ff ff    	jns    6d1 <main+0xa3>
    {
      runcmd(parsecmd(buf));
    }
    wait();
  }}
  exit();
     a42:	e8 31 0b 00 00       	call   1578 <exit>

00000a47 <panic>:
}

void
panic(char *s)
{
     a47:	55                   	push   %ebp
     a48:	89 e5                	mov    %esp,%ebp
     a4a:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     a4d:	83 ec 04             	sub    $0x4,%esp
     a50:	ff 75 08             	pushl  0x8(%ebp)
     a53:	68 04 1b 00 00       	push   $0x1b04
     a58:	6a 02                	push   $0x2
     a5a:	e8 9e 0c 00 00       	call   16fd <printf>
     a5f:	83 c4 10             	add    $0x10,%esp
  exit();
     a62:	e8 11 0b 00 00       	call   1578 <exit>

00000a67 <fork1>:
}

int
fork1(void)
{
     a67:	55                   	push   %ebp
     a68:	89 e5                	mov    %esp,%ebp
     a6a:	83 ec 18             	sub    $0x18,%esp
  int pid;
  
  pid = fork();
     a6d:	e8 fe 0a 00 00       	call   1570 <fork>
     a72:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     a75:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     a79:	75 10                	jne    a8b <fork1+0x24>
    panic("fork");
     a7b:	83 ec 0c             	sub    $0xc,%esp
     a7e:	68 86 1b 00 00       	push   $0x1b86
     a83:	e8 bf ff ff ff       	call   a47 <panic>
     a88:	83 c4 10             	add    $0x10,%esp
  return pid;
     a8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     a8e:	c9                   	leave  
     a8f:	c3                   	ret    

00000a90 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     a90:	55                   	push   %ebp
     a91:	89 e5                	mov    %esp,%ebp
     a93:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     a96:	83 ec 0c             	sub    $0xc,%esp
     a99:	6a 54                	push   $0x54
     a9b:	e8 2e 0f 00 00       	call   19ce <malloc>
     aa0:	83 c4 10             	add    $0x10,%esp
     aa3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     aa6:	83 ec 04             	sub    $0x4,%esp
     aa9:	6a 54                	push   $0x54
     aab:	6a 00                	push   $0x0
     aad:	ff 75 f4             	pushl  -0xc(%ebp)
     ab0:	e8 29 09 00 00       	call   13de <memset>
     ab5:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     ab8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     abb:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     ac1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     ac4:	c9                   	leave  
     ac5:	c3                   	ret    

00000ac6 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     ac6:	55                   	push   %ebp
     ac7:	89 e5                	mov    %esp,%ebp
     ac9:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     acc:	83 ec 0c             	sub    $0xc,%esp
     acf:	6a 18                	push   $0x18
     ad1:	e8 f8 0e 00 00       	call   19ce <malloc>
     ad6:	83 c4 10             	add    $0x10,%esp
     ad9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     adc:	83 ec 04             	sub    $0x4,%esp
     adf:	6a 18                	push   $0x18
     ae1:	6a 00                	push   $0x0
     ae3:	ff 75 f4             	pushl  -0xc(%ebp)
     ae6:	e8 f3 08 00 00       	call   13de <memset>
     aeb:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     aee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af1:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     af7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     afa:	8b 55 08             	mov    0x8(%ebp),%edx
     afd:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     b00:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b03:	8b 55 0c             	mov    0xc(%ebp),%edx
     b06:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     b09:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b0c:	8b 55 10             	mov    0x10(%ebp),%edx
     b0f:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     b12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b15:	8b 55 14             	mov    0x14(%ebp),%edx
     b18:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     b1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b1e:	8b 55 18             	mov    0x18(%ebp),%edx
     b21:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     b24:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     b27:	c9                   	leave  
     b28:	c3                   	ret    

00000b29 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     b29:	55                   	push   %ebp
     b2a:	89 e5                	mov    %esp,%ebp
     b2c:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     b2f:	83 ec 0c             	sub    $0xc,%esp
     b32:	6a 0c                	push   $0xc
     b34:	e8 95 0e 00 00       	call   19ce <malloc>
     b39:	83 c4 10             	add    $0x10,%esp
     b3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     b3f:	83 ec 04             	sub    $0x4,%esp
     b42:	6a 0c                	push   $0xc
     b44:	6a 00                	push   $0x0
     b46:	ff 75 f4             	pushl  -0xc(%ebp)
     b49:	e8 90 08 00 00       	call   13de <memset>
     b4e:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     b51:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b54:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     b5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b5d:	8b 55 08             	mov    0x8(%ebp),%edx
     b60:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     b63:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b66:	8b 55 0c             	mov    0xc(%ebp),%edx
     b69:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     b6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     b6f:	c9                   	leave  
     b70:	c3                   	ret    

00000b71 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     b71:	55                   	push   %ebp
     b72:	89 e5                	mov    %esp,%ebp
     b74:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     b77:	83 ec 0c             	sub    $0xc,%esp
     b7a:	6a 0c                	push   $0xc
     b7c:	e8 4d 0e 00 00       	call   19ce <malloc>
     b81:	83 c4 10             	add    $0x10,%esp
     b84:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     b87:	83 ec 04             	sub    $0x4,%esp
     b8a:	6a 0c                	push   $0xc
     b8c:	6a 00                	push   $0x0
     b8e:	ff 75 f4             	pushl  -0xc(%ebp)
     b91:	e8 48 08 00 00       	call   13de <memset>
     b96:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     b99:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b9c:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     ba2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba5:	8b 55 08             	mov    0x8(%ebp),%edx
     ba8:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     bab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bae:	8b 55 0c             	mov    0xc(%ebp),%edx
     bb1:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     bb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bb7:	c9                   	leave  
     bb8:	c3                   	ret    

00000bb9 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     bb9:	55                   	push   %ebp
     bba:	89 e5                	mov    %esp,%ebp
     bbc:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     bbf:	83 ec 0c             	sub    $0xc,%esp
     bc2:	6a 08                	push   $0x8
     bc4:	e8 05 0e 00 00       	call   19ce <malloc>
     bc9:	83 c4 10             	add    $0x10,%esp
     bcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     bcf:	83 ec 04             	sub    $0x4,%esp
     bd2:	6a 08                	push   $0x8
     bd4:	6a 00                	push   $0x0
     bd6:	ff 75 f4             	pushl  -0xc(%ebp)
     bd9:	e8 00 08 00 00       	call   13de <memset>
     bde:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     be1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     be4:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     bea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bed:	8b 55 08             	mov    0x8(%ebp),%edx
     bf0:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     bf3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bf6:	c9                   	leave  
     bf7:	c3                   	ret    

00000bf8 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     bf8:	55                   	push   %ebp
     bf9:	89 e5                	mov    %esp,%ebp
     bfb:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;
  
  s = *ps;
     bfe:	8b 45 08             	mov    0x8(%ebp),%eax
     c01:	8b 00                	mov    (%eax),%eax
     c03:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     c06:	eb 04                	jmp    c0c <gettoken+0x14>
    s++;
     c08:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     c0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c0f:	3b 45 0c             	cmp    0xc(%ebp),%eax
     c12:	73 1e                	jae    c32 <gettoken+0x3a>
     c14:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c17:	0f b6 00             	movzbl (%eax),%eax
     c1a:	0f be c0             	movsbl %al,%eax
     c1d:	83 ec 08             	sub    $0x8,%esp
     c20:	50                   	push   %eax
     c21:	68 68 21 00 00       	push   $0x2168
     c26:	e8 cd 07 00 00       	call   13f8 <strchr>
     c2b:	83 c4 10             	add    $0x10,%esp
     c2e:	85 c0                	test   %eax,%eax
     c30:	75 d6                	jne    c08 <gettoken+0x10>
    s++;
  if(q)
     c32:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     c36:	74 08                	je     c40 <gettoken+0x48>
    *q = s;
     c38:	8b 45 10             	mov    0x10(%ebp),%eax
     c3b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c3e:	89 10                	mov    %edx,(%eax)
  ret = *s;
     c40:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c43:	0f b6 00             	movzbl (%eax),%eax
     c46:	0f be c0             	movsbl %al,%eax
     c49:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     c4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c4f:	0f b6 00             	movzbl (%eax),%eax
     c52:	0f be c0             	movsbl %al,%eax
     c55:	83 f8 29             	cmp    $0x29,%eax
     c58:	7f 14                	jg     c6e <gettoken+0x76>
     c5a:	83 f8 28             	cmp    $0x28,%eax
     c5d:	7d 28                	jge    c87 <gettoken+0x8f>
     c5f:	85 c0                	test   %eax,%eax
     c61:	0f 84 96 00 00 00    	je     cfd <gettoken+0x105>
     c67:	83 f8 26             	cmp    $0x26,%eax
     c6a:	74 1b                	je     c87 <gettoken+0x8f>
     c6c:	eb 3c                	jmp    caa <gettoken+0xb2>
     c6e:	83 f8 3e             	cmp    $0x3e,%eax
     c71:	74 1a                	je     c8d <gettoken+0x95>
     c73:	83 f8 3e             	cmp    $0x3e,%eax
     c76:	7f 0a                	jg     c82 <gettoken+0x8a>
     c78:	83 e8 3b             	sub    $0x3b,%eax
     c7b:	83 f8 01             	cmp    $0x1,%eax
     c7e:	77 2a                	ja     caa <gettoken+0xb2>
     c80:	eb 05                	jmp    c87 <gettoken+0x8f>
     c82:	83 f8 7c             	cmp    $0x7c,%eax
     c85:	75 23                	jne    caa <gettoken+0xb2>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     c87:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     c8b:	eb 71                	jmp    cfe <gettoken+0x106>
  case '>':
    s++;
     c8d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     c91:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c94:	0f b6 00             	movzbl (%eax),%eax
     c97:	3c 3e                	cmp    $0x3e,%al
     c99:	75 0d                	jne    ca8 <gettoken+0xb0>
      ret = '+';
     c9b:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     ca2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     ca6:	eb 56                	jmp    cfe <gettoken+0x106>
     ca8:	eb 54                	jmp    cfe <gettoken+0x106>
  default:
    ret = 'a';
     caa:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     cb1:	eb 04                	jmp    cb7 <gettoken+0xbf>
      s++;
     cb3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     cb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cba:	3b 45 0c             	cmp    0xc(%ebp),%eax
     cbd:	73 3c                	jae    cfb <gettoken+0x103>
     cbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc2:	0f b6 00             	movzbl (%eax),%eax
     cc5:	0f be c0             	movsbl %al,%eax
     cc8:	83 ec 08             	sub    $0x8,%esp
     ccb:	50                   	push   %eax
     ccc:	68 68 21 00 00       	push   $0x2168
     cd1:	e8 22 07 00 00       	call   13f8 <strchr>
     cd6:	83 c4 10             	add    $0x10,%esp
     cd9:	85 c0                	test   %eax,%eax
     cdb:	75 1e                	jne    cfb <gettoken+0x103>
     cdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ce0:	0f b6 00             	movzbl (%eax),%eax
     ce3:	0f be c0             	movsbl %al,%eax
     ce6:	83 ec 08             	sub    $0x8,%esp
     ce9:	50                   	push   %eax
     cea:	68 6e 21 00 00       	push   $0x216e
     cef:	e8 04 07 00 00       	call   13f8 <strchr>
     cf4:	83 c4 10             	add    $0x10,%esp
     cf7:	85 c0                	test   %eax,%eax
     cf9:	74 b8                	je     cb3 <gettoken+0xbb>
      s++;
    break;
     cfb:	eb 01                	jmp    cfe <gettoken+0x106>
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
     cfd:	90                   	nop
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     cfe:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     d02:	74 08                	je     d0c <gettoken+0x114>
    *eq = s;
     d04:	8b 45 14             	mov    0x14(%ebp),%eax
     d07:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d0a:	89 10                	mov    %edx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     d0c:	eb 04                	jmp    d12 <gettoken+0x11a>
    s++;
     d0e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     d12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d15:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d18:	73 1e                	jae    d38 <gettoken+0x140>
     d1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d1d:	0f b6 00             	movzbl (%eax),%eax
     d20:	0f be c0             	movsbl %al,%eax
     d23:	83 ec 08             	sub    $0x8,%esp
     d26:	50                   	push   %eax
     d27:	68 68 21 00 00       	push   $0x2168
     d2c:	e8 c7 06 00 00       	call   13f8 <strchr>
     d31:	83 c4 10             	add    $0x10,%esp
     d34:	85 c0                	test   %eax,%eax
     d36:	75 d6                	jne    d0e <gettoken+0x116>
    s++;
  *ps = s;
     d38:	8b 45 08             	mov    0x8(%ebp),%eax
     d3b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d3e:	89 10                	mov    %edx,(%eax)
  return ret;
     d40:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     d43:	c9                   	leave  
     d44:	c3                   	ret    

00000d45 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     d45:	55                   	push   %ebp
     d46:	89 e5                	mov    %esp,%ebp
     d48:	83 ec 18             	sub    $0x18,%esp
  char *s;
  
  s = *ps;
     d4b:	8b 45 08             	mov    0x8(%ebp),%eax
     d4e:	8b 00                	mov    (%eax),%eax
     d50:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     d53:	eb 04                	jmp    d59 <peek+0x14>
    s++;
     d55:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     d59:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d5c:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d5f:	73 1e                	jae    d7f <peek+0x3a>
     d61:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d64:	0f b6 00             	movzbl (%eax),%eax
     d67:	0f be c0             	movsbl %al,%eax
     d6a:	83 ec 08             	sub    $0x8,%esp
     d6d:	50                   	push   %eax
     d6e:	68 68 21 00 00       	push   $0x2168
     d73:	e8 80 06 00 00       	call   13f8 <strchr>
     d78:	83 c4 10             	add    $0x10,%esp
     d7b:	85 c0                	test   %eax,%eax
     d7d:	75 d6                	jne    d55 <peek+0x10>
    s++;
  *ps = s;
     d7f:	8b 45 08             	mov    0x8(%ebp),%eax
     d82:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d85:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     d87:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d8a:	0f b6 00             	movzbl (%eax),%eax
     d8d:	84 c0                	test   %al,%al
     d8f:	74 23                	je     db4 <peek+0x6f>
     d91:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d94:	0f b6 00             	movzbl (%eax),%eax
     d97:	0f be c0             	movsbl %al,%eax
     d9a:	83 ec 08             	sub    $0x8,%esp
     d9d:	50                   	push   %eax
     d9e:	ff 75 10             	pushl  0x10(%ebp)
     da1:	e8 52 06 00 00       	call   13f8 <strchr>
     da6:	83 c4 10             	add    $0x10,%esp
     da9:	85 c0                	test   %eax,%eax
     dab:	74 07                	je     db4 <peek+0x6f>
     dad:	b8 01 00 00 00       	mov    $0x1,%eax
     db2:	eb 05                	jmp    db9 <peek+0x74>
     db4:	b8 00 00 00 00       	mov    $0x0,%eax
}
     db9:	c9                   	leave  
     dba:	c3                   	ret    

00000dbb <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     dbb:	55                   	push   %ebp
     dbc:	89 e5                	mov    %esp,%ebp
     dbe:	53                   	push   %ebx
     dbf:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     dc2:	8b 5d 08             	mov    0x8(%ebp),%ebx
     dc5:	8b 45 08             	mov    0x8(%ebp),%eax
     dc8:	83 ec 0c             	sub    $0xc,%esp
     dcb:	50                   	push   %eax
     dcc:	e8 e6 05 00 00       	call   13b7 <strlen>
     dd1:	83 c4 10             	add    $0x10,%esp
     dd4:	01 d8                	add    %ebx,%eax
     dd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     dd9:	83 ec 08             	sub    $0x8,%esp
     ddc:	ff 75 f4             	pushl  -0xc(%ebp)
     ddf:	8d 45 08             	lea    0x8(%ebp),%eax
     de2:	50                   	push   %eax
     de3:	e8 61 00 00 00       	call   e49 <parseline>
     de8:	83 c4 10             	add    $0x10,%esp
     deb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     dee:	83 ec 04             	sub    $0x4,%esp
     df1:	68 8b 1b 00 00       	push   $0x1b8b
     df6:	ff 75 f4             	pushl  -0xc(%ebp)
     df9:	8d 45 08             	lea    0x8(%ebp),%eax
     dfc:	50                   	push   %eax
     dfd:	e8 43 ff ff ff       	call   d45 <peek>
     e02:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     e05:	8b 45 08             	mov    0x8(%ebp),%eax
     e08:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     e0b:	74 26                	je     e33 <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
     e0d:	8b 45 08             	mov    0x8(%ebp),%eax
     e10:	83 ec 04             	sub    $0x4,%esp
     e13:	50                   	push   %eax
     e14:	68 8c 1b 00 00       	push   $0x1b8c
     e19:	6a 02                	push   $0x2
     e1b:	e8 dd 08 00 00       	call   16fd <printf>
     e20:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     e23:	83 ec 0c             	sub    $0xc,%esp
     e26:	68 9b 1b 00 00       	push   $0x1b9b
     e2b:	e8 17 fc ff ff       	call   a47 <panic>
     e30:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
     e33:	83 ec 0c             	sub    $0xc,%esp
     e36:	ff 75 f0             	pushl  -0x10(%ebp)
     e39:	e8 e9 03 00 00       	call   1227 <nulterminate>
     e3e:	83 c4 10             	add    $0x10,%esp
  return cmd;
     e41:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     e44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e47:	c9                   	leave  
     e48:	c3                   	ret    

00000e49 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     e49:	55                   	push   %ebp
     e4a:	89 e5                	mov    %esp,%ebp
     e4c:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     e4f:	83 ec 08             	sub    $0x8,%esp
     e52:	ff 75 0c             	pushl  0xc(%ebp)
     e55:	ff 75 08             	pushl  0x8(%ebp)
     e58:	e8 99 00 00 00       	call   ef6 <parsepipe>
     e5d:	83 c4 10             	add    $0x10,%esp
     e60:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     e63:	eb 23                	jmp    e88 <parseline+0x3f>
    gettoken(ps, es, 0, 0);
     e65:	6a 00                	push   $0x0
     e67:	6a 00                	push   $0x0
     e69:	ff 75 0c             	pushl  0xc(%ebp)
     e6c:	ff 75 08             	pushl  0x8(%ebp)
     e6f:	e8 84 fd ff ff       	call   bf8 <gettoken>
     e74:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     e77:	83 ec 0c             	sub    $0xc,%esp
     e7a:	ff 75 f4             	pushl  -0xc(%ebp)
     e7d:	e8 37 fd ff ff       	call   bb9 <backcmd>
     e82:	83 c4 10             	add    $0x10,%esp
     e85:	89 45 f4             	mov    %eax,-0xc(%ebp)
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     e88:	83 ec 04             	sub    $0x4,%esp
     e8b:	68 a2 1b 00 00       	push   $0x1ba2
     e90:	ff 75 0c             	pushl  0xc(%ebp)
     e93:	ff 75 08             	pushl  0x8(%ebp)
     e96:	e8 aa fe ff ff       	call   d45 <peek>
     e9b:	83 c4 10             	add    $0x10,%esp
     e9e:	85 c0                	test   %eax,%eax
     ea0:	75 c3                	jne    e65 <parseline+0x1c>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     ea2:	83 ec 04             	sub    $0x4,%esp
     ea5:	68 a4 1b 00 00       	push   $0x1ba4
     eaa:	ff 75 0c             	pushl  0xc(%ebp)
     ead:	ff 75 08             	pushl  0x8(%ebp)
     eb0:	e8 90 fe ff ff       	call   d45 <peek>
     eb5:	83 c4 10             	add    $0x10,%esp
     eb8:	85 c0                	test   %eax,%eax
     eba:	74 35                	je     ef1 <parseline+0xa8>
    gettoken(ps, es, 0, 0);
     ebc:	6a 00                	push   $0x0
     ebe:	6a 00                	push   $0x0
     ec0:	ff 75 0c             	pushl  0xc(%ebp)
     ec3:	ff 75 08             	pushl  0x8(%ebp)
     ec6:	e8 2d fd ff ff       	call   bf8 <gettoken>
     ecb:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     ece:	83 ec 08             	sub    $0x8,%esp
     ed1:	ff 75 0c             	pushl  0xc(%ebp)
     ed4:	ff 75 08             	pushl  0x8(%ebp)
     ed7:	e8 6d ff ff ff       	call   e49 <parseline>
     edc:	83 c4 10             	add    $0x10,%esp
     edf:	83 ec 08             	sub    $0x8,%esp
     ee2:	50                   	push   %eax
     ee3:	ff 75 f4             	pushl  -0xc(%ebp)
     ee6:	e8 86 fc ff ff       	call   b71 <listcmd>
     eeb:	83 c4 10             	add    $0x10,%esp
     eee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     ef1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     ef4:	c9                   	leave  
     ef5:	c3                   	ret    

00000ef6 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     ef6:	55                   	push   %ebp
     ef7:	89 e5                	mov    %esp,%ebp
     ef9:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     efc:	83 ec 08             	sub    $0x8,%esp
     eff:	ff 75 0c             	pushl  0xc(%ebp)
     f02:	ff 75 08             	pushl  0x8(%ebp)
     f05:	e8 ec 01 00 00       	call   10f6 <parseexec>
     f0a:	83 c4 10             	add    $0x10,%esp
     f0d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     f10:	83 ec 04             	sub    $0x4,%esp
     f13:	68 a6 1b 00 00       	push   $0x1ba6
     f18:	ff 75 0c             	pushl  0xc(%ebp)
     f1b:	ff 75 08             	pushl  0x8(%ebp)
     f1e:	e8 22 fe ff ff       	call   d45 <peek>
     f23:	83 c4 10             	add    $0x10,%esp
     f26:	85 c0                	test   %eax,%eax
     f28:	74 35                	je     f5f <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
     f2a:	6a 00                	push   $0x0
     f2c:	6a 00                	push   $0x0
     f2e:	ff 75 0c             	pushl  0xc(%ebp)
     f31:	ff 75 08             	pushl  0x8(%ebp)
     f34:	e8 bf fc ff ff       	call   bf8 <gettoken>
     f39:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     f3c:	83 ec 08             	sub    $0x8,%esp
     f3f:	ff 75 0c             	pushl  0xc(%ebp)
     f42:	ff 75 08             	pushl  0x8(%ebp)
     f45:	e8 ac ff ff ff       	call   ef6 <parsepipe>
     f4a:	83 c4 10             	add    $0x10,%esp
     f4d:	83 ec 08             	sub    $0x8,%esp
     f50:	50                   	push   %eax
     f51:	ff 75 f4             	pushl  -0xc(%ebp)
     f54:	e8 d0 fb ff ff       	call   b29 <pipecmd>
     f59:	83 c4 10             	add    $0x10,%esp
     f5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     f5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     f62:	c9                   	leave  
     f63:	c3                   	ret    

00000f64 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     f64:	55                   	push   %ebp
     f65:	89 e5                	mov    %esp,%ebp
     f67:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     f6a:	e9 b6 00 00 00       	jmp    1025 <parseredirs+0xc1>
    tok = gettoken(ps, es, 0, 0);
     f6f:	6a 00                	push   $0x0
     f71:	6a 00                	push   $0x0
     f73:	ff 75 10             	pushl  0x10(%ebp)
     f76:	ff 75 0c             	pushl  0xc(%ebp)
     f79:	e8 7a fc ff ff       	call   bf8 <gettoken>
     f7e:	83 c4 10             	add    $0x10,%esp
     f81:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     f84:	8d 45 ec             	lea    -0x14(%ebp),%eax
     f87:	50                   	push   %eax
     f88:	8d 45 f0             	lea    -0x10(%ebp),%eax
     f8b:	50                   	push   %eax
     f8c:	ff 75 10             	pushl  0x10(%ebp)
     f8f:	ff 75 0c             	pushl  0xc(%ebp)
     f92:	e8 61 fc ff ff       	call   bf8 <gettoken>
     f97:	83 c4 10             	add    $0x10,%esp
     f9a:	83 f8 61             	cmp    $0x61,%eax
     f9d:	74 10                	je     faf <parseredirs+0x4b>
      panic("missing file for redirection");
     f9f:	83 ec 0c             	sub    $0xc,%esp
     fa2:	68 a8 1b 00 00       	push   $0x1ba8
     fa7:	e8 9b fa ff ff       	call   a47 <panic>
     fac:	83 c4 10             	add    $0x10,%esp
    switch(tok){
     faf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fb2:	83 f8 3c             	cmp    $0x3c,%eax
     fb5:	74 0c                	je     fc3 <parseredirs+0x5f>
     fb7:	83 f8 3e             	cmp    $0x3e,%eax
     fba:	74 26                	je     fe2 <parseredirs+0x7e>
     fbc:	83 f8 2b             	cmp    $0x2b,%eax
     fbf:	74 43                	je     1004 <parseredirs+0xa0>
     fc1:	eb 62                	jmp    1025 <parseredirs+0xc1>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     fc3:	8b 55 ec             	mov    -0x14(%ebp),%edx
     fc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fc9:	83 ec 0c             	sub    $0xc,%esp
     fcc:	6a 00                	push   $0x0
     fce:	6a 00                	push   $0x0
     fd0:	52                   	push   %edx
     fd1:	50                   	push   %eax
     fd2:	ff 75 08             	pushl  0x8(%ebp)
     fd5:	e8 ec fa ff ff       	call   ac6 <redircmd>
     fda:	83 c4 20             	add    $0x20,%esp
     fdd:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     fe0:	eb 43                	jmp    1025 <parseredirs+0xc1>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     fe2:	8b 55 ec             	mov    -0x14(%ebp),%edx
     fe5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fe8:	83 ec 0c             	sub    $0xc,%esp
     feb:	6a 01                	push   $0x1
     fed:	68 01 02 00 00       	push   $0x201
     ff2:	52                   	push   %edx
     ff3:	50                   	push   %eax
     ff4:	ff 75 08             	pushl  0x8(%ebp)
     ff7:	e8 ca fa ff ff       	call   ac6 <redircmd>
     ffc:	83 c4 20             	add    $0x20,%esp
     fff:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    1002:	eb 21                	jmp    1025 <parseredirs+0xc1>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    1004:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1007:	8b 45 f0             	mov    -0x10(%ebp),%eax
    100a:	83 ec 0c             	sub    $0xc,%esp
    100d:	6a 01                	push   $0x1
    100f:	68 01 02 00 00       	push   $0x201
    1014:	52                   	push   %edx
    1015:	50                   	push   %eax
    1016:	ff 75 08             	pushl  0x8(%ebp)
    1019:	e8 a8 fa ff ff       	call   ac6 <redircmd>
    101e:	83 c4 20             	add    $0x20,%esp
    1021:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    1024:	90                   	nop
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    1025:	83 ec 04             	sub    $0x4,%esp
    1028:	68 c5 1b 00 00       	push   $0x1bc5
    102d:	ff 75 10             	pushl  0x10(%ebp)
    1030:	ff 75 0c             	pushl  0xc(%ebp)
    1033:	e8 0d fd ff ff       	call   d45 <peek>
    1038:	83 c4 10             	add    $0x10,%esp
    103b:	85 c0                	test   %eax,%eax
    103d:	0f 85 2c ff ff ff    	jne    f6f <parseredirs+0xb>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
    1043:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1046:	c9                   	leave  
    1047:	c3                   	ret    

00001048 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
    1048:	55                   	push   %ebp
    1049:	89 e5                	mov    %esp,%ebp
    104b:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    104e:	83 ec 04             	sub    $0x4,%esp
    1051:	68 c8 1b 00 00       	push   $0x1bc8
    1056:	ff 75 0c             	pushl  0xc(%ebp)
    1059:	ff 75 08             	pushl  0x8(%ebp)
    105c:	e8 e4 fc ff ff       	call   d45 <peek>
    1061:	83 c4 10             	add    $0x10,%esp
    1064:	85 c0                	test   %eax,%eax
    1066:	75 10                	jne    1078 <parseblock+0x30>
    panic("parseblock");
    1068:	83 ec 0c             	sub    $0xc,%esp
    106b:	68 ca 1b 00 00       	push   $0x1bca
    1070:	e8 d2 f9 ff ff       	call   a47 <panic>
    1075:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
    1078:	6a 00                	push   $0x0
    107a:	6a 00                	push   $0x0
    107c:	ff 75 0c             	pushl  0xc(%ebp)
    107f:	ff 75 08             	pushl  0x8(%ebp)
    1082:	e8 71 fb ff ff       	call   bf8 <gettoken>
    1087:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
    108a:	83 ec 08             	sub    $0x8,%esp
    108d:	ff 75 0c             	pushl  0xc(%ebp)
    1090:	ff 75 08             	pushl  0x8(%ebp)
    1093:	e8 b1 fd ff ff       	call   e49 <parseline>
    1098:	83 c4 10             	add    $0x10,%esp
    109b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
    109e:	83 ec 04             	sub    $0x4,%esp
    10a1:	68 d5 1b 00 00       	push   $0x1bd5
    10a6:	ff 75 0c             	pushl  0xc(%ebp)
    10a9:	ff 75 08             	pushl  0x8(%ebp)
    10ac:	e8 94 fc ff ff       	call   d45 <peek>
    10b1:	83 c4 10             	add    $0x10,%esp
    10b4:	85 c0                	test   %eax,%eax
    10b6:	75 10                	jne    10c8 <parseblock+0x80>
    panic("syntax - missing )");
    10b8:	83 ec 0c             	sub    $0xc,%esp
    10bb:	68 d7 1b 00 00       	push   $0x1bd7
    10c0:	e8 82 f9 ff ff       	call   a47 <panic>
    10c5:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
    10c8:	6a 00                	push   $0x0
    10ca:	6a 00                	push   $0x0
    10cc:	ff 75 0c             	pushl  0xc(%ebp)
    10cf:	ff 75 08             	pushl  0x8(%ebp)
    10d2:	e8 21 fb ff ff       	call   bf8 <gettoken>
    10d7:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
    10da:	83 ec 04             	sub    $0x4,%esp
    10dd:	ff 75 0c             	pushl  0xc(%ebp)
    10e0:	ff 75 08             	pushl  0x8(%ebp)
    10e3:	ff 75 f4             	pushl  -0xc(%ebp)
    10e6:	e8 79 fe ff ff       	call   f64 <parseredirs>
    10eb:	83 c4 10             	add    $0x10,%esp
    10ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
    10f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    10f4:	c9                   	leave  
    10f5:	c3                   	ret    

000010f6 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
    10f6:	55                   	push   %ebp
    10f7:	89 e5                	mov    %esp,%ebp
    10f9:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
    10fc:	83 ec 04             	sub    $0x4,%esp
    10ff:	68 c8 1b 00 00       	push   $0x1bc8
    1104:	ff 75 0c             	pushl  0xc(%ebp)
    1107:	ff 75 08             	pushl  0x8(%ebp)
    110a:	e8 36 fc ff ff       	call   d45 <peek>
    110f:	83 c4 10             	add    $0x10,%esp
    1112:	85 c0                	test   %eax,%eax
    1114:	74 16                	je     112c <parseexec+0x36>
    return parseblock(ps, es);
    1116:	83 ec 08             	sub    $0x8,%esp
    1119:	ff 75 0c             	pushl  0xc(%ebp)
    111c:	ff 75 08             	pushl  0x8(%ebp)
    111f:	e8 24 ff ff ff       	call   1048 <parseblock>
    1124:	83 c4 10             	add    $0x10,%esp
    1127:	e9 f9 00 00 00       	jmp    1225 <parseexec+0x12f>

  ret = execcmd();
    112c:	e8 5f f9 ff ff       	call   a90 <execcmd>
    1131:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
    1134:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1137:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
    113a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
    1141:	83 ec 04             	sub    $0x4,%esp
    1144:	ff 75 0c             	pushl  0xc(%ebp)
    1147:	ff 75 08             	pushl  0x8(%ebp)
    114a:	ff 75 f0             	pushl  -0x10(%ebp)
    114d:	e8 12 fe ff ff       	call   f64 <parseredirs>
    1152:	83 c4 10             	add    $0x10,%esp
    1155:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
    1158:	e9 88 00 00 00       	jmp    11e5 <parseexec+0xef>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
    115d:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1160:	50                   	push   %eax
    1161:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1164:	50                   	push   %eax
    1165:	ff 75 0c             	pushl  0xc(%ebp)
    1168:	ff 75 08             	pushl  0x8(%ebp)
    116b:	e8 88 fa ff ff       	call   bf8 <gettoken>
    1170:	83 c4 10             	add    $0x10,%esp
    1173:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1176:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    117a:	75 05                	jne    1181 <parseexec+0x8b>
      break;
    117c:	e9 82 00 00 00       	jmp    1203 <parseexec+0x10d>
    if(tok != 'a')
    1181:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
    1185:	74 10                	je     1197 <parseexec+0xa1>
      panic("syntax");
    1187:	83 ec 0c             	sub    $0xc,%esp
    118a:	68 9b 1b 00 00       	push   $0x1b9b
    118f:	e8 b3 f8 ff ff       	call   a47 <panic>
    1194:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
    1197:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    119a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    119d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11a0:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
    11a4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    11a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11aa:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    11ad:	83 c1 08             	add    $0x8,%ecx
    11b0:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
    11b4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
    11b8:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    11bc:	7e 10                	jle    11ce <parseexec+0xd8>
      panic("too many args");
    11be:	83 ec 0c             	sub    $0xc,%esp
    11c1:	68 ea 1b 00 00       	push   $0x1bea
    11c6:	e8 7c f8 ff ff       	call   a47 <panic>
    11cb:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
    11ce:	83 ec 04             	sub    $0x4,%esp
    11d1:	ff 75 0c             	pushl  0xc(%ebp)
    11d4:	ff 75 08             	pushl  0x8(%ebp)
    11d7:	ff 75 f0             	pushl  -0x10(%ebp)
    11da:	e8 85 fd ff ff       	call   f64 <parseredirs>
    11df:	83 c4 10             	add    $0x10,%esp
    11e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    11e5:	83 ec 04             	sub    $0x4,%esp
    11e8:	68 f8 1b 00 00       	push   $0x1bf8
    11ed:	ff 75 0c             	pushl  0xc(%ebp)
    11f0:	ff 75 08             	pushl  0x8(%ebp)
    11f3:	e8 4d fb ff ff       	call   d45 <peek>
    11f8:	83 c4 10             	add    $0x10,%esp
    11fb:	85 c0                	test   %eax,%eax
    11fd:	0f 84 5a ff ff ff    	je     115d <parseexec+0x67>
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
    1203:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1206:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1209:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
    1210:	00 
  cmd->eargv[argc] = 0;
    1211:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1214:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1217:	83 c2 08             	add    $0x8,%edx
    121a:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
    1221:	00 
  return ret;
    1222:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1225:	c9                   	leave  
    1226:	c3                   	ret    

00001227 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
    1227:	55                   	push   %ebp
    1228:	89 e5                	mov    %esp,%ebp
    122a:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    122d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1231:	75 0a                	jne    123d <nulterminate+0x16>
    return 0;
    1233:	b8 00 00 00 00       	mov    $0x0,%eax
    1238:	e9 e4 00 00 00       	jmp    1321 <nulterminate+0xfa>
  
  switch(cmd->type){
    123d:	8b 45 08             	mov    0x8(%ebp),%eax
    1240:	8b 00                	mov    (%eax),%eax
    1242:	83 f8 05             	cmp    $0x5,%eax
    1245:	0f 87 d3 00 00 00    	ja     131e <nulterminate+0xf7>
    124b:	8b 04 85 00 1c 00 00 	mov    0x1c00(,%eax,4),%eax
    1252:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    1254:	8b 45 08             	mov    0x8(%ebp),%eax
    1257:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(i=0; ecmd->argv[i]; i++)
    125a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1261:	eb 14                	jmp    1277 <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
    1263:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1266:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1269:	83 c2 08             	add    $0x8,%edx
    126c:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
    1270:	c6 00 00             	movb   $0x0,(%eax)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
    1273:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1277:	8b 45 f0             	mov    -0x10(%ebp),%eax
    127a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    127d:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
    1281:	85 c0                	test   %eax,%eax
    1283:	75 de                	jne    1263 <nulterminate+0x3c>
      *ecmd->eargv[i] = 0;
    break;
    1285:	e9 94 00 00 00       	jmp    131e <nulterminate+0xf7>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    128a:	8b 45 08             	mov    0x8(%ebp),%eax
    128d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(rcmd->cmd);
    1290:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1293:	8b 40 04             	mov    0x4(%eax),%eax
    1296:	83 ec 0c             	sub    $0xc,%esp
    1299:	50                   	push   %eax
    129a:	e8 88 ff ff ff       	call   1227 <nulterminate>
    129f:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
    12a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12a5:	8b 40 0c             	mov    0xc(%eax),%eax
    12a8:	c6 00 00             	movb   $0x0,(%eax)
    break;
    12ab:	eb 71                	jmp    131e <nulterminate+0xf7>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    12ad:	8b 45 08             	mov    0x8(%ebp),%eax
    12b0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
    12b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12b6:	8b 40 04             	mov    0x4(%eax),%eax
    12b9:	83 ec 0c             	sub    $0xc,%esp
    12bc:	50                   	push   %eax
    12bd:	e8 65 ff ff ff       	call   1227 <nulterminate>
    12c2:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
    12c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12c8:	8b 40 08             	mov    0x8(%eax),%eax
    12cb:	83 ec 0c             	sub    $0xc,%esp
    12ce:	50                   	push   %eax
    12cf:	e8 53 ff ff ff       	call   1227 <nulterminate>
    12d4:	83 c4 10             	add    $0x10,%esp
    break;
    12d7:	eb 45                	jmp    131e <nulterminate+0xf7>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
    12d9:	8b 45 08             	mov    0x8(%ebp),%eax
    12dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(lcmd->left);
    12df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12e2:	8b 40 04             	mov    0x4(%eax),%eax
    12e5:	83 ec 0c             	sub    $0xc,%esp
    12e8:	50                   	push   %eax
    12e9:	e8 39 ff ff ff       	call   1227 <nulterminate>
    12ee:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
    12f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12f4:	8b 40 08             	mov    0x8(%eax),%eax
    12f7:	83 ec 0c             	sub    $0xc,%esp
    12fa:	50                   	push   %eax
    12fb:	e8 27 ff ff ff       	call   1227 <nulterminate>
    1300:	83 c4 10             	add    $0x10,%esp
    break;
    1303:	eb 19                	jmp    131e <nulterminate+0xf7>

  case BACK:
    bcmd = (struct backcmd*)cmd;
    1305:	8b 45 08             	mov    0x8(%ebp),%eax
    1308:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nulterminate(bcmd->cmd);
    130b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    130e:	8b 40 04             	mov    0x4(%eax),%eax
    1311:	83 ec 0c             	sub    $0xc,%esp
    1314:	50                   	push   %eax
    1315:	e8 0d ff ff ff       	call   1227 <nulterminate>
    131a:	83 c4 10             	add    $0x10,%esp
    break;
    131d:	90                   	nop
  }
  return cmd;
    131e:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1321:	c9                   	leave  
    1322:	c3                   	ret    

00001323 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1323:	55                   	push   %ebp
    1324:	89 e5                	mov    %esp,%ebp
    1326:	57                   	push   %edi
    1327:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1328:	8b 4d 08             	mov    0x8(%ebp),%ecx
    132b:	8b 55 10             	mov    0x10(%ebp),%edx
    132e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1331:	89 cb                	mov    %ecx,%ebx
    1333:	89 df                	mov    %ebx,%edi
    1335:	89 d1                	mov    %edx,%ecx
    1337:	fc                   	cld    
    1338:	f3 aa                	rep stos %al,%es:(%edi)
    133a:	89 ca                	mov    %ecx,%edx
    133c:	89 fb                	mov    %edi,%ebx
    133e:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1341:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1344:	5b                   	pop    %ebx
    1345:	5f                   	pop    %edi
    1346:	5d                   	pop    %ebp
    1347:	c3                   	ret    

00001348 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1348:	55                   	push   %ebp
    1349:	89 e5                	mov    %esp,%ebp
    134b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    134e:	8b 45 08             	mov    0x8(%ebp),%eax
    1351:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1354:	90                   	nop
    1355:	8b 45 08             	mov    0x8(%ebp),%eax
    1358:	8d 50 01             	lea    0x1(%eax),%edx
    135b:	89 55 08             	mov    %edx,0x8(%ebp)
    135e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1361:	8d 4a 01             	lea    0x1(%edx),%ecx
    1364:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    1367:	0f b6 12             	movzbl (%edx),%edx
    136a:	88 10                	mov    %dl,(%eax)
    136c:	0f b6 00             	movzbl (%eax),%eax
    136f:	84 c0                	test   %al,%al
    1371:	75 e2                	jne    1355 <strcpy+0xd>
    ;
  return os;
    1373:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1376:	c9                   	leave  
    1377:	c3                   	ret    

00001378 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1378:	55                   	push   %ebp
    1379:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    137b:	eb 08                	jmp    1385 <strcmp+0xd>
    p++, q++;
    137d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1381:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1385:	8b 45 08             	mov    0x8(%ebp),%eax
    1388:	0f b6 00             	movzbl (%eax),%eax
    138b:	84 c0                	test   %al,%al
    138d:	74 10                	je     139f <strcmp+0x27>
    138f:	8b 45 08             	mov    0x8(%ebp),%eax
    1392:	0f b6 10             	movzbl (%eax),%edx
    1395:	8b 45 0c             	mov    0xc(%ebp),%eax
    1398:	0f b6 00             	movzbl (%eax),%eax
    139b:	38 c2                	cmp    %al,%dl
    139d:	74 de                	je     137d <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    139f:	8b 45 08             	mov    0x8(%ebp),%eax
    13a2:	0f b6 00             	movzbl (%eax),%eax
    13a5:	0f b6 d0             	movzbl %al,%edx
    13a8:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ab:	0f b6 00             	movzbl (%eax),%eax
    13ae:	0f b6 c0             	movzbl %al,%eax
    13b1:	29 c2                	sub    %eax,%edx
    13b3:	89 d0                	mov    %edx,%eax
}
    13b5:	5d                   	pop    %ebp
    13b6:	c3                   	ret    

000013b7 <strlen>:

uint
strlen(char *s)
{
    13b7:	55                   	push   %ebp
    13b8:	89 e5                	mov    %esp,%ebp
    13ba:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    13bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    13c4:	eb 04                	jmp    13ca <strlen+0x13>
    13c6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    13ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
    13cd:	8b 45 08             	mov    0x8(%ebp),%eax
    13d0:	01 d0                	add    %edx,%eax
    13d2:	0f b6 00             	movzbl (%eax),%eax
    13d5:	84 c0                	test   %al,%al
    13d7:	75 ed                	jne    13c6 <strlen+0xf>
    ;
  return n;
    13d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    13dc:	c9                   	leave  
    13dd:	c3                   	ret    

000013de <memset>:

void*
memset(void *dst, int c, uint n)
{
    13de:	55                   	push   %ebp
    13df:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    13e1:	8b 45 10             	mov    0x10(%ebp),%eax
    13e4:	50                   	push   %eax
    13e5:	ff 75 0c             	pushl  0xc(%ebp)
    13e8:	ff 75 08             	pushl  0x8(%ebp)
    13eb:	e8 33 ff ff ff       	call   1323 <stosb>
    13f0:	83 c4 0c             	add    $0xc,%esp
  return dst;
    13f3:	8b 45 08             	mov    0x8(%ebp),%eax
}
    13f6:	c9                   	leave  
    13f7:	c3                   	ret    

000013f8 <strchr>:

char*
strchr(const char *s, char c)
{
    13f8:	55                   	push   %ebp
    13f9:	89 e5                	mov    %esp,%ebp
    13fb:	83 ec 04             	sub    $0x4,%esp
    13fe:	8b 45 0c             	mov    0xc(%ebp),%eax
    1401:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1404:	eb 14                	jmp    141a <strchr+0x22>
    if(*s == c)
    1406:	8b 45 08             	mov    0x8(%ebp),%eax
    1409:	0f b6 00             	movzbl (%eax),%eax
    140c:	3a 45 fc             	cmp    -0x4(%ebp),%al
    140f:	75 05                	jne    1416 <strchr+0x1e>
      return (char*)s;
    1411:	8b 45 08             	mov    0x8(%ebp),%eax
    1414:	eb 13                	jmp    1429 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1416:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    141a:	8b 45 08             	mov    0x8(%ebp),%eax
    141d:	0f b6 00             	movzbl (%eax),%eax
    1420:	84 c0                	test   %al,%al
    1422:	75 e2                	jne    1406 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1424:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1429:	c9                   	leave  
    142a:	c3                   	ret    

0000142b <gets>:

char*
gets(char *buf, int max)
{
    142b:	55                   	push   %ebp
    142c:	89 e5                	mov    %esp,%ebp
    142e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1431:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1438:	eb 44                	jmp    147e <gets+0x53>
    cc = read(0, &c, 1);
    143a:	83 ec 04             	sub    $0x4,%esp
    143d:	6a 01                	push   $0x1
    143f:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1442:	50                   	push   %eax
    1443:	6a 00                	push   $0x0
    1445:	e8 46 01 00 00       	call   1590 <read>
    144a:	83 c4 10             	add    $0x10,%esp
    144d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1450:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1454:	7f 02                	jg     1458 <gets+0x2d>
      break;
    1456:	eb 31                	jmp    1489 <gets+0x5e>
    buf[i++] = c;
    1458:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145b:	8d 50 01             	lea    0x1(%eax),%edx
    145e:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1461:	89 c2                	mov    %eax,%edx
    1463:	8b 45 08             	mov    0x8(%ebp),%eax
    1466:	01 c2                	add    %eax,%edx
    1468:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    146c:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    146e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1472:	3c 0a                	cmp    $0xa,%al
    1474:	74 13                	je     1489 <gets+0x5e>
    1476:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    147a:	3c 0d                	cmp    $0xd,%al
    147c:	74 0b                	je     1489 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    147e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1481:	83 c0 01             	add    $0x1,%eax
    1484:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1487:	7c b1                	jl     143a <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1489:	8b 55 f4             	mov    -0xc(%ebp),%edx
    148c:	8b 45 08             	mov    0x8(%ebp),%eax
    148f:	01 d0                	add    %edx,%eax
    1491:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1494:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1497:	c9                   	leave  
    1498:	c3                   	ret    

00001499 <stat>:

int
stat(char *n, struct stat *st)
{
    1499:	55                   	push   %ebp
    149a:	89 e5                	mov    %esp,%ebp
    149c:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    149f:	83 ec 08             	sub    $0x8,%esp
    14a2:	6a 00                	push   $0x0
    14a4:	ff 75 08             	pushl  0x8(%ebp)
    14a7:	e8 0c 01 00 00       	call   15b8 <open>
    14ac:	83 c4 10             	add    $0x10,%esp
    14af:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    14b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14b6:	79 07                	jns    14bf <stat+0x26>
    return -1;
    14b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14bd:	eb 25                	jmp    14e4 <stat+0x4b>
  r = fstat(fd, st);
    14bf:	83 ec 08             	sub    $0x8,%esp
    14c2:	ff 75 0c             	pushl  0xc(%ebp)
    14c5:	ff 75 f4             	pushl  -0xc(%ebp)
    14c8:	e8 03 01 00 00       	call   15d0 <fstat>
    14cd:	83 c4 10             	add    $0x10,%esp
    14d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    14d3:	83 ec 0c             	sub    $0xc,%esp
    14d6:	ff 75 f4             	pushl  -0xc(%ebp)
    14d9:	e8 c2 00 00 00       	call   15a0 <close>
    14de:	83 c4 10             	add    $0x10,%esp
  return r;
    14e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    14e4:	c9                   	leave  
    14e5:	c3                   	ret    

000014e6 <atoi>:

int
atoi(const char *s)
{
    14e6:	55                   	push   %ebp
    14e7:	89 e5                	mov    %esp,%ebp
    14e9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    14ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    14f3:	eb 25                	jmp    151a <atoi+0x34>
    n = n*10 + *s++ - '0';
    14f5:	8b 55 fc             	mov    -0x4(%ebp),%edx
    14f8:	89 d0                	mov    %edx,%eax
    14fa:	c1 e0 02             	shl    $0x2,%eax
    14fd:	01 d0                	add    %edx,%eax
    14ff:	01 c0                	add    %eax,%eax
    1501:	89 c1                	mov    %eax,%ecx
    1503:	8b 45 08             	mov    0x8(%ebp),%eax
    1506:	8d 50 01             	lea    0x1(%eax),%edx
    1509:	89 55 08             	mov    %edx,0x8(%ebp)
    150c:	0f b6 00             	movzbl (%eax),%eax
    150f:	0f be c0             	movsbl %al,%eax
    1512:	01 c8                	add    %ecx,%eax
    1514:	83 e8 30             	sub    $0x30,%eax
    1517:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    151a:	8b 45 08             	mov    0x8(%ebp),%eax
    151d:	0f b6 00             	movzbl (%eax),%eax
    1520:	3c 2f                	cmp    $0x2f,%al
    1522:	7e 0a                	jle    152e <atoi+0x48>
    1524:	8b 45 08             	mov    0x8(%ebp),%eax
    1527:	0f b6 00             	movzbl (%eax),%eax
    152a:	3c 39                	cmp    $0x39,%al
    152c:	7e c7                	jle    14f5 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    152e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1531:	c9                   	leave  
    1532:	c3                   	ret    

00001533 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1533:	55                   	push   %ebp
    1534:	89 e5                	mov    %esp,%ebp
    1536:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1539:	8b 45 08             	mov    0x8(%ebp),%eax
    153c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    153f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1542:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1545:	eb 17                	jmp    155e <memmove+0x2b>
    *dst++ = *src++;
    1547:	8b 45 fc             	mov    -0x4(%ebp),%eax
    154a:	8d 50 01             	lea    0x1(%eax),%edx
    154d:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1550:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1553:	8d 4a 01             	lea    0x1(%edx),%ecx
    1556:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    1559:	0f b6 12             	movzbl (%edx),%edx
    155c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    155e:	8b 45 10             	mov    0x10(%ebp),%eax
    1561:	8d 50 ff             	lea    -0x1(%eax),%edx
    1564:	89 55 10             	mov    %edx,0x10(%ebp)
    1567:	85 c0                	test   %eax,%eax
    1569:	7f dc                	jg     1547 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    156b:	8b 45 08             	mov    0x8(%ebp),%eax
}
    156e:	c9                   	leave  
    156f:	c3                   	ret    

00001570 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1570:	b8 01 00 00 00       	mov    $0x1,%eax
    1575:	cd 40                	int    $0x40
    1577:	c3                   	ret    

00001578 <exit>:
SYSCALL(exit)
    1578:	b8 02 00 00 00       	mov    $0x2,%eax
    157d:	cd 40                	int    $0x40
    157f:	c3                   	ret    

00001580 <wait>:
SYSCALL(wait)
    1580:	b8 03 00 00 00       	mov    $0x3,%eax
    1585:	cd 40                	int    $0x40
    1587:	c3                   	ret    

00001588 <pipe>:
SYSCALL(pipe)
    1588:	b8 04 00 00 00       	mov    $0x4,%eax
    158d:	cd 40                	int    $0x40
    158f:	c3                   	ret    

00001590 <read>:
SYSCALL(read)
    1590:	b8 05 00 00 00       	mov    $0x5,%eax
    1595:	cd 40                	int    $0x40
    1597:	c3                   	ret    

00001598 <write>:
SYSCALL(write)
    1598:	b8 10 00 00 00       	mov    $0x10,%eax
    159d:	cd 40                	int    $0x40
    159f:	c3                   	ret    

000015a0 <close>:
SYSCALL(close)
    15a0:	b8 15 00 00 00       	mov    $0x15,%eax
    15a5:	cd 40                	int    $0x40
    15a7:	c3                   	ret    

000015a8 <kill>:
SYSCALL(kill)
    15a8:	b8 06 00 00 00       	mov    $0x6,%eax
    15ad:	cd 40                	int    $0x40
    15af:	c3                   	ret    

000015b0 <exec>:
SYSCALL(exec)
    15b0:	b8 07 00 00 00       	mov    $0x7,%eax
    15b5:	cd 40                	int    $0x40
    15b7:	c3                   	ret    

000015b8 <open>:
SYSCALL(open)
    15b8:	b8 0f 00 00 00       	mov    $0xf,%eax
    15bd:	cd 40                	int    $0x40
    15bf:	c3                   	ret    

000015c0 <mknod>:
SYSCALL(mknod)
    15c0:	b8 11 00 00 00       	mov    $0x11,%eax
    15c5:	cd 40                	int    $0x40
    15c7:	c3                   	ret    

000015c8 <unlink>:
SYSCALL(unlink)
    15c8:	b8 12 00 00 00       	mov    $0x12,%eax
    15cd:	cd 40                	int    $0x40
    15cf:	c3                   	ret    

000015d0 <fstat>:
SYSCALL(fstat)
    15d0:	b8 08 00 00 00       	mov    $0x8,%eax
    15d5:	cd 40                	int    $0x40
    15d7:	c3                   	ret    

000015d8 <link>:
SYSCALL(link)
    15d8:	b8 13 00 00 00       	mov    $0x13,%eax
    15dd:	cd 40                	int    $0x40
    15df:	c3                   	ret    

000015e0 <mkdir>:
SYSCALL(mkdir)
    15e0:	b8 14 00 00 00       	mov    $0x14,%eax
    15e5:	cd 40                	int    $0x40
    15e7:	c3                   	ret    

000015e8 <chdir>:
SYSCALL(chdir)
    15e8:	b8 09 00 00 00       	mov    $0x9,%eax
    15ed:	cd 40                	int    $0x40
    15ef:	c3                   	ret    

000015f0 <dup>:
SYSCALL(dup)
    15f0:	b8 0a 00 00 00       	mov    $0xa,%eax
    15f5:	cd 40                	int    $0x40
    15f7:	c3                   	ret    

000015f8 <getpid>:
SYSCALL(getpid)
    15f8:	b8 0b 00 00 00       	mov    $0xb,%eax
    15fd:	cd 40                	int    $0x40
    15ff:	c3                   	ret    

00001600 <sbrk>:
SYSCALL(sbrk)
    1600:	b8 0c 00 00 00       	mov    $0xc,%eax
    1605:	cd 40                	int    $0x40
    1607:	c3                   	ret    

00001608 <sleep>:
SYSCALL(sleep)
    1608:	b8 0d 00 00 00       	mov    $0xd,%eax
    160d:	cd 40                	int    $0x40
    160f:	c3                   	ret    

00001610 <uptime>:
SYSCALL(uptime)
    1610:	b8 0e 00 00 00       	mov    $0xe,%eax
    1615:	cd 40                	int    $0x40
    1617:	c3                   	ret    

00001618 <getcwd>:
SYSCALL(getcwd)
    1618:	b8 16 00 00 00       	mov    $0x16,%eax
    161d:	cd 40                	int    $0x40
    161f:	c3                   	ret    

00001620 <ps>:
SYSCALL(ps)
    1620:	b8 17 00 00 00       	mov    $0x17,%eax
    1625:	cd 40                	int    $0x40
    1627:	c3                   	ret    

00001628 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1628:	55                   	push   %ebp
    1629:	89 e5                	mov    %esp,%ebp
    162b:	83 ec 18             	sub    $0x18,%esp
    162e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1631:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1634:	83 ec 04             	sub    $0x4,%esp
    1637:	6a 01                	push   $0x1
    1639:	8d 45 f4             	lea    -0xc(%ebp),%eax
    163c:	50                   	push   %eax
    163d:	ff 75 08             	pushl  0x8(%ebp)
    1640:	e8 53 ff ff ff       	call   1598 <write>
    1645:	83 c4 10             	add    $0x10,%esp
}
    1648:	c9                   	leave  
    1649:	c3                   	ret    

0000164a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    164a:	55                   	push   %ebp
    164b:	89 e5                	mov    %esp,%ebp
    164d:	53                   	push   %ebx
    164e:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1651:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1658:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    165c:	74 17                	je     1675 <printint+0x2b>
    165e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1662:	79 11                	jns    1675 <printint+0x2b>
    neg = 1;
    1664:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    166b:	8b 45 0c             	mov    0xc(%ebp),%eax
    166e:	f7 d8                	neg    %eax
    1670:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1673:	eb 06                	jmp    167b <printint+0x31>
  } else {
    x = xx;
    1675:	8b 45 0c             	mov    0xc(%ebp),%eax
    1678:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    167b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1682:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1685:	8d 41 01             	lea    0x1(%ecx),%eax
    1688:	89 45 f4             	mov    %eax,-0xc(%ebp)
    168b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    168e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1691:	ba 00 00 00 00       	mov    $0x0,%edx
    1696:	f7 f3                	div    %ebx
    1698:	89 d0                	mov    %edx,%eax
    169a:	0f b6 80 76 21 00 00 	movzbl 0x2176(%eax),%eax
    16a1:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    16a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    16a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    16ab:	ba 00 00 00 00       	mov    $0x0,%edx
    16b0:	f7 f3                	div    %ebx
    16b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    16b5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16b9:	75 c7                	jne    1682 <printint+0x38>
  if(neg)
    16bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    16bf:	74 0e                	je     16cf <printint+0x85>
    buf[i++] = '-';
    16c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c4:	8d 50 01             	lea    0x1(%eax),%edx
    16c7:	89 55 f4             	mov    %edx,-0xc(%ebp)
    16ca:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    16cf:	eb 1d                	jmp    16ee <printint+0xa4>
    putc(fd, buf[i]);
    16d1:	8d 55 dc             	lea    -0x24(%ebp),%edx
    16d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d7:	01 d0                	add    %edx,%eax
    16d9:	0f b6 00             	movzbl (%eax),%eax
    16dc:	0f be c0             	movsbl %al,%eax
    16df:	83 ec 08             	sub    $0x8,%esp
    16e2:	50                   	push   %eax
    16e3:	ff 75 08             	pushl  0x8(%ebp)
    16e6:	e8 3d ff ff ff       	call   1628 <putc>
    16eb:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    16ee:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    16f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16f6:	79 d9                	jns    16d1 <printint+0x87>
    putc(fd, buf[i]);
}
    16f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    16fb:	c9                   	leave  
    16fc:	c3                   	ret    

000016fd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    16fd:	55                   	push   %ebp
    16fe:	89 e5                	mov    %esp,%ebp
    1700:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1703:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    170a:	8d 45 0c             	lea    0xc(%ebp),%eax
    170d:	83 c0 04             	add    $0x4,%eax
    1710:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1713:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    171a:	e9 59 01 00 00       	jmp    1878 <printf+0x17b>
    c = fmt[i] & 0xff;
    171f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1722:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1725:	01 d0                	add    %edx,%eax
    1727:	0f b6 00             	movzbl (%eax),%eax
    172a:	0f be c0             	movsbl %al,%eax
    172d:	25 ff 00 00 00       	and    $0xff,%eax
    1732:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1735:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1739:	75 2c                	jne    1767 <printf+0x6a>
      if(c == '%'){
    173b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    173f:	75 0c                	jne    174d <printf+0x50>
        state = '%';
    1741:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1748:	e9 27 01 00 00       	jmp    1874 <printf+0x177>
      } else {
        putc(fd, c);
    174d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1750:	0f be c0             	movsbl %al,%eax
    1753:	83 ec 08             	sub    $0x8,%esp
    1756:	50                   	push   %eax
    1757:	ff 75 08             	pushl  0x8(%ebp)
    175a:	e8 c9 fe ff ff       	call   1628 <putc>
    175f:	83 c4 10             	add    $0x10,%esp
    1762:	e9 0d 01 00 00       	jmp    1874 <printf+0x177>
      }
    } else if(state == '%'){
    1767:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    176b:	0f 85 03 01 00 00    	jne    1874 <printf+0x177>
      if(c == 'd'){
    1771:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1775:	75 1e                	jne    1795 <printf+0x98>
        printint(fd, *ap, 10, 1);
    1777:	8b 45 e8             	mov    -0x18(%ebp),%eax
    177a:	8b 00                	mov    (%eax),%eax
    177c:	6a 01                	push   $0x1
    177e:	6a 0a                	push   $0xa
    1780:	50                   	push   %eax
    1781:	ff 75 08             	pushl  0x8(%ebp)
    1784:	e8 c1 fe ff ff       	call   164a <printint>
    1789:	83 c4 10             	add    $0x10,%esp
        ap++;
    178c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1790:	e9 d8 00 00 00       	jmp    186d <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1795:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1799:	74 06                	je     17a1 <printf+0xa4>
    179b:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    179f:	75 1e                	jne    17bf <printf+0xc2>
        printint(fd, *ap, 16, 0);
    17a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17a4:	8b 00                	mov    (%eax),%eax
    17a6:	6a 00                	push   $0x0
    17a8:	6a 10                	push   $0x10
    17aa:	50                   	push   %eax
    17ab:	ff 75 08             	pushl  0x8(%ebp)
    17ae:	e8 97 fe ff ff       	call   164a <printint>
    17b3:	83 c4 10             	add    $0x10,%esp
        ap++;
    17b6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    17ba:	e9 ae 00 00 00       	jmp    186d <printf+0x170>
      } else if(c == 's'){
    17bf:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    17c3:	75 43                	jne    1808 <printf+0x10b>
        s = (char*)*ap;
    17c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17c8:	8b 00                	mov    (%eax),%eax
    17ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    17cd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    17d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17d5:	75 07                	jne    17de <printf+0xe1>
          s = "(null)";
    17d7:	c7 45 f4 18 1c 00 00 	movl   $0x1c18,-0xc(%ebp)
        while(*s != 0){
    17de:	eb 1c                	jmp    17fc <printf+0xff>
          putc(fd, *s);
    17e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e3:	0f b6 00             	movzbl (%eax),%eax
    17e6:	0f be c0             	movsbl %al,%eax
    17e9:	83 ec 08             	sub    $0x8,%esp
    17ec:	50                   	push   %eax
    17ed:	ff 75 08             	pushl  0x8(%ebp)
    17f0:	e8 33 fe ff ff       	call   1628 <putc>
    17f5:	83 c4 10             	add    $0x10,%esp
          s++;
    17f8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    17fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ff:	0f b6 00             	movzbl (%eax),%eax
    1802:	84 c0                	test   %al,%al
    1804:	75 da                	jne    17e0 <printf+0xe3>
    1806:	eb 65                	jmp    186d <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1808:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    180c:	75 1d                	jne    182b <printf+0x12e>
        putc(fd, *ap);
    180e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1811:	8b 00                	mov    (%eax),%eax
    1813:	0f be c0             	movsbl %al,%eax
    1816:	83 ec 08             	sub    $0x8,%esp
    1819:	50                   	push   %eax
    181a:	ff 75 08             	pushl  0x8(%ebp)
    181d:	e8 06 fe ff ff       	call   1628 <putc>
    1822:	83 c4 10             	add    $0x10,%esp
        ap++;
    1825:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1829:	eb 42                	jmp    186d <printf+0x170>
      } else if(c == '%'){
    182b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    182f:	75 17                	jne    1848 <printf+0x14b>
        putc(fd, c);
    1831:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1834:	0f be c0             	movsbl %al,%eax
    1837:	83 ec 08             	sub    $0x8,%esp
    183a:	50                   	push   %eax
    183b:	ff 75 08             	pushl  0x8(%ebp)
    183e:	e8 e5 fd ff ff       	call   1628 <putc>
    1843:	83 c4 10             	add    $0x10,%esp
    1846:	eb 25                	jmp    186d <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1848:	83 ec 08             	sub    $0x8,%esp
    184b:	6a 25                	push   $0x25
    184d:	ff 75 08             	pushl  0x8(%ebp)
    1850:	e8 d3 fd ff ff       	call   1628 <putc>
    1855:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1858:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    185b:	0f be c0             	movsbl %al,%eax
    185e:	83 ec 08             	sub    $0x8,%esp
    1861:	50                   	push   %eax
    1862:	ff 75 08             	pushl  0x8(%ebp)
    1865:	e8 be fd ff ff       	call   1628 <putc>
    186a:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    186d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1874:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1878:	8b 55 0c             	mov    0xc(%ebp),%edx
    187b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    187e:	01 d0                	add    %edx,%eax
    1880:	0f b6 00             	movzbl (%eax),%eax
    1883:	84 c0                	test   %al,%al
    1885:	0f 85 94 fe ff ff    	jne    171f <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    188b:	c9                   	leave  
    188c:	c3                   	ret    

0000188d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    188d:	55                   	push   %ebp
    188e:	89 e5                	mov    %esp,%ebp
    1890:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1893:	8b 45 08             	mov    0x8(%ebp),%eax
    1896:	83 e8 08             	sub    $0x8,%eax
    1899:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    189c:	a1 2c 22 00 00       	mov    0x222c,%eax
    18a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    18a4:	eb 24                	jmp    18ca <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    18a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18a9:	8b 00                	mov    (%eax),%eax
    18ab:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    18ae:	77 12                	ja     18c2 <free+0x35>
    18b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18b3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    18b6:	77 24                	ja     18dc <free+0x4f>
    18b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18bb:	8b 00                	mov    (%eax),%eax
    18bd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    18c0:	77 1a                	ja     18dc <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18c5:	8b 00                	mov    (%eax),%eax
    18c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
    18ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18cd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    18d0:	76 d4                	jbe    18a6 <free+0x19>
    18d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18d5:	8b 00                	mov    (%eax),%eax
    18d7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    18da:	76 ca                	jbe    18a6 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    18dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18df:	8b 40 04             	mov    0x4(%eax),%eax
    18e2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    18e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18ec:	01 c2                	add    %eax,%edx
    18ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18f1:	8b 00                	mov    (%eax),%eax
    18f3:	39 c2                	cmp    %eax,%edx
    18f5:	75 24                	jne    191b <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    18f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18fa:	8b 50 04             	mov    0x4(%eax),%edx
    18fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1900:	8b 00                	mov    (%eax),%eax
    1902:	8b 40 04             	mov    0x4(%eax),%eax
    1905:	01 c2                	add    %eax,%edx
    1907:	8b 45 f8             	mov    -0x8(%ebp),%eax
    190a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    190d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1910:	8b 00                	mov    (%eax),%eax
    1912:	8b 10                	mov    (%eax),%edx
    1914:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1917:	89 10                	mov    %edx,(%eax)
    1919:	eb 0a                	jmp    1925 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    191b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    191e:	8b 10                	mov    (%eax),%edx
    1920:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1923:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1925:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1928:	8b 40 04             	mov    0x4(%eax),%eax
    192b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1932:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1935:	01 d0                	add    %edx,%eax
    1937:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    193a:	75 20                	jne    195c <free+0xcf>
    p->s.size += bp->s.size;
    193c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    193f:	8b 50 04             	mov    0x4(%eax),%edx
    1942:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1945:	8b 40 04             	mov    0x4(%eax),%eax
    1948:	01 c2                	add    %eax,%edx
    194a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    194d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1950:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1953:	8b 10                	mov    (%eax),%edx
    1955:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1958:	89 10                	mov    %edx,(%eax)
    195a:	eb 08                	jmp    1964 <free+0xd7>
  } else
    p->s.ptr = bp;
    195c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    195f:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1962:	89 10                	mov    %edx,(%eax)
  freep = p;
    1964:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1967:	a3 2c 22 00 00       	mov    %eax,0x222c
}
    196c:	c9                   	leave  
    196d:	c3                   	ret    

0000196e <morecore>:

static Header*
morecore(uint nu)
{
    196e:	55                   	push   %ebp
    196f:	89 e5                	mov    %esp,%ebp
    1971:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1974:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    197b:	77 07                	ja     1984 <morecore+0x16>
    nu = 4096;
    197d:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1984:	8b 45 08             	mov    0x8(%ebp),%eax
    1987:	c1 e0 03             	shl    $0x3,%eax
    198a:	83 ec 0c             	sub    $0xc,%esp
    198d:	50                   	push   %eax
    198e:	e8 6d fc ff ff       	call   1600 <sbrk>
    1993:	83 c4 10             	add    $0x10,%esp
    1996:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1999:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    199d:	75 07                	jne    19a6 <morecore+0x38>
    return 0;
    199f:	b8 00 00 00 00       	mov    $0x0,%eax
    19a4:	eb 26                	jmp    19cc <morecore+0x5e>
  hp = (Header*)p;
    19a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    19ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19af:	8b 55 08             	mov    0x8(%ebp),%edx
    19b2:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    19b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19b8:	83 c0 08             	add    $0x8,%eax
    19bb:	83 ec 0c             	sub    $0xc,%esp
    19be:	50                   	push   %eax
    19bf:	e8 c9 fe ff ff       	call   188d <free>
    19c4:	83 c4 10             	add    $0x10,%esp
  return freep;
    19c7:	a1 2c 22 00 00       	mov    0x222c,%eax
}
    19cc:	c9                   	leave  
    19cd:	c3                   	ret    

000019ce <malloc>:

void*
malloc(uint nbytes)
{
    19ce:	55                   	push   %ebp
    19cf:	89 e5                	mov    %esp,%ebp
    19d1:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    19d4:	8b 45 08             	mov    0x8(%ebp),%eax
    19d7:	83 c0 07             	add    $0x7,%eax
    19da:	c1 e8 03             	shr    $0x3,%eax
    19dd:	83 c0 01             	add    $0x1,%eax
    19e0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    19e3:	a1 2c 22 00 00       	mov    0x222c,%eax
    19e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    19eb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    19ef:	75 23                	jne    1a14 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    19f1:	c7 45 f0 24 22 00 00 	movl   $0x2224,-0x10(%ebp)
    19f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19fb:	a3 2c 22 00 00       	mov    %eax,0x222c
    1a00:	a1 2c 22 00 00       	mov    0x222c,%eax
    1a05:	a3 24 22 00 00       	mov    %eax,0x2224
    base.s.size = 0;
    1a0a:	c7 05 28 22 00 00 00 	movl   $0x0,0x2228
    1a11:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1a14:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a17:	8b 00                	mov    (%eax),%eax
    1a19:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1a1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a1f:	8b 40 04             	mov    0x4(%eax),%eax
    1a22:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1a25:	72 4d                	jb     1a74 <malloc+0xa6>
      if(p->s.size == nunits)
    1a27:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a2a:	8b 40 04             	mov    0x4(%eax),%eax
    1a2d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1a30:	75 0c                	jne    1a3e <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1a32:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a35:	8b 10                	mov    (%eax),%edx
    1a37:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a3a:	89 10                	mov    %edx,(%eax)
    1a3c:	eb 26                	jmp    1a64 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1a3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a41:	8b 40 04             	mov    0x4(%eax),%eax
    1a44:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1a47:	89 c2                	mov    %eax,%edx
    1a49:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a4c:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1a4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a52:	8b 40 04             	mov    0x4(%eax),%eax
    1a55:	c1 e0 03             	shl    $0x3,%eax
    1a58:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1a5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a5e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1a61:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1a64:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a67:	a3 2c 22 00 00       	mov    %eax,0x222c
      return (void*)(p + 1);
    1a6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a6f:	83 c0 08             	add    $0x8,%eax
    1a72:	eb 3b                	jmp    1aaf <malloc+0xe1>
    }
    if(p == freep)
    1a74:	a1 2c 22 00 00       	mov    0x222c,%eax
    1a79:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1a7c:	75 1e                	jne    1a9c <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    1a7e:	83 ec 0c             	sub    $0xc,%esp
    1a81:	ff 75 ec             	pushl  -0x14(%ebp)
    1a84:	e8 e5 fe ff ff       	call   196e <morecore>
    1a89:	83 c4 10             	add    $0x10,%esp
    1a8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a8f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a93:	75 07                	jne    1a9c <malloc+0xce>
        return 0;
    1a95:	b8 00 00 00 00       	mov    $0x0,%eax
    1a9a:	eb 13                	jmp    1aaf <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1a9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1aa2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aa5:	8b 00                	mov    (%eax),%eax
    1aa7:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1aaa:	e9 6d ff ff ff       	jmp    1a1c <malloc+0x4e>
}
    1aaf:	c9                   	leave  
    1ab0:	c3                   	ret    
