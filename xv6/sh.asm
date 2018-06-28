
_sh：     文件格式 elf32-i386


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
       c:	e8 c4 0e 00 00       	call   ed5 <exit>
  
  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 ec 2c 00 00 	mov    0x2cec(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 c0 2c 00 00       	push   $0x2cc0
      2c:	e8 6b 03 00 00       	call   39c <panic>
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
      44:	e8 8c 0e 00 00       	call   ed5 <exit>
    exec(ecmd->argv[0], ecmd->argv);
      49:	8b 45 f4             	mov    -0xc(%ebp),%eax
      4c:	8d 50 04             	lea    0x4(%eax),%edx
      4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      52:	8b 40 04             	mov    0x4(%eax),%eax
      55:	83 ec 08             	sub    $0x8,%esp
      58:	52                   	push   %edx
      59:	50                   	push   %eax
      5a:	e8 ae 0e 00 00       	call   f0d <exec>
      5f:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      62:	8b 45 f4             	mov    -0xc(%ebp),%eax
      65:	8b 40 04             	mov    0x4(%eax),%eax
      68:	83 ec 04             	sub    $0x4,%esp
      6b:	50                   	push   %eax
      6c:	68 c7 2c 00 00       	push   $0x2cc7
      71:	6a 02                	push   $0x2
      73:	e8 04 10 00 00       	call   107c <printf>
      78:	83 c4 10             	add    $0x10,%esp
    break;
      7b:	e9 c6 01 00 00       	jmp    246 <runcmd+0x246>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      80:	8b 45 08             	mov    0x8(%ebp),%eax
      83:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(rcmd->fd);
      86:	8b 45 f0             	mov    -0x10(%ebp),%eax
      89:	8b 40 14             	mov    0x14(%eax),%eax
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	50                   	push   %eax
      90:	e8 68 0e 00 00       	call   efd <close>
      95:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
      98:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9b:	8b 50 10             	mov    0x10(%eax),%edx
      9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
      a1:	8b 40 08             	mov    0x8(%eax),%eax
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	52                   	push   %edx
      a8:	50                   	push   %eax
      a9:	e8 67 0e 00 00       	call   f15 <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	85 c0                	test   %eax,%eax
      b3:	79 1e                	jns    d3 <runcmd+0xd3>
      printf(2, "open %s failed\n", rcmd->file);
      b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
      b8:	8b 40 08             	mov    0x8(%eax),%eax
      bb:	83 ec 04             	sub    $0x4,%esp
      be:	50                   	push   %eax
      bf:	68 d7 2c 00 00       	push   $0x2cd7
      c4:	6a 02                	push   $0x2
      c6:	e8 b1 0f 00 00       	call   107c <printf>
      cb:	83 c4 10             	add    $0x10,%esp
      exit();
      ce:	e8 02 0e 00 00       	call   ed5 <exit>
    }
    runcmd(rcmd->cmd);
      d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
      d6:	8b 40 04             	mov    0x4(%eax),%eax
      d9:	83 ec 0c             	sub    $0xc,%esp
      dc:	50                   	push   %eax
      dd:	e8 1e ff ff ff       	call   0 <runcmd>
      e2:	83 c4 10             	add    $0x10,%esp
    break;
      e5:	e9 5c 01 00 00       	jmp    246 <runcmd+0x246>

  case LIST:
    lcmd = (struct listcmd*)cmd;
      ea:	8b 45 08             	mov    0x8(%ebp),%eax
      ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fork1() == 0)
      f0:	e8 c7 02 00 00       	call   3bc <fork1>
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
     10b:	e8 cd 0d 00 00       	call   edd <wait>
    runcmd(lcmd->right);
     110:	8b 45 ec             	mov    -0x14(%ebp),%eax
     113:	8b 40 08             	mov    0x8(%eax),%eax
     116:	83 ec 0c             	sub    $0xc,%esp
     119:	50                   	push   %eax
     11a:	e8 e1 fe ff ff       	call   0 <runcmd>
     11f:	83 c4 10             	add    $0x10,%esp
    break;
     122:	e9 1f 01 00 00       	jmp    246 <runcmd+0x246>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     127:	8b 45 08             	mov    0x8(%ebp),%eax
     12a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pipe(p) < 0)
     12d:	83 ec 0c             	sub    $0xc,%esp
     130:	8d 45 dc             	lea    -0x24(%ebp),%eax
     133:	50                   	push   %eax
     134:	e8 ac 0d 00 00       	call   ee5 <pipe>
     139:	83 c4 10             	add    $0x10,%esp
     13c:	85 c0                	test   %eax,%eax
     13e:	79 10                	jns    150 <runcmd+0x150>
      panic("pipe");
     140:	83 ec 0c             	sub    $0xc,%esp
     143:	68 e7 2c 00 00       	push   $0x2ce7
     148:	e8 4f 02 00 00       	call   39c <panic>
     14d:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
     150:	e8 67 02 00 00       	call   3bc <fork1>
     155:	85 c0                	test   %eax,%eax
     157:	75 4c                	jne    1a5 <runcmd+0x1a5>
      close(1);
     159:	83 ec 0c             	sub    $0xc,%esp
     15c:	6a 01                	push   $0x1
     15e:	e8 9a 0d 00 00       	call   efd <close>
     163:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
     166:	8b 45 e0             	mov    -0x20(%ebp),%eax
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	50                   	push   %eax
     16d:	e8 db 0d 00 00       	call   f4d <dup>
     172:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     175:	8b 45 dc             	mov    -0x24(%ebp),%eax
     178:	83 ec 0c             	sub    $0xc,%esp
     17b:	50                   	push   %eax
     17c:	e8 7c 0d 00 00       	call   efd <close>
     181:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     184:	8b 45 e0             	mov    -0x20(%ebp),%eax
     187:	83 ec 0c             	sub    $0xc,%esp
     18a:	50                   	push   %eax
     18b:	e8 6d 0d 00 00       	call   efd <close>
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
     1a5:	e8 12 02 00 00       	call   3bc <fork1>
     1aa:	85 c0                	test   %eax,%eax
     1ac:	75 4c                	jne    1fa <runcmd+0x1fa>
      close(0);
     1ae:	83 ec 0c             	sub    $0xc,%esp
     1b1:	6a 00                	push   $0x0
     1b3:	e8 45 0d 00 00       	call   efd <close>
     1b8:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
     1bb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1be:	83 ec 0c             	sub    $0xc,%esp
     1c1:	50                   	push   %eax
     1c2:	e8 86 0d 00 00       	call   f4d <dup>
     1c7:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     1ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1cd:	83 ec 0c             	sub    $0xc,%esp
     1d0:	50                   	push   %eax
     1d1:	e8 27 0d 00 00       	call   efd <close>
     1d6:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     1d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1dc:	83 ec 0c             	sub    $0xc,%esp
     1df:	50                   	push   %eax
     1e0:	e8 18 0d 00 00       	call   efd <close>
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
     201:	e8 f7 0c 00 00       	call   efd <close>
     206:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
     209:	8b 45 e0             	mov    -0x20(%ebp),%eax
     20c:	83 ec 0c             	sub    $0xc,%esp
     20f:	50                   	push   %eax
     210:	e8 e8 0c 00 00       	call   efd <close>
     215:	83 c4 10             	add    $0x10,%esp
    wait();
     218:	e8 c0 0c 00 00       	call   edd <wait>
    wait();
     21d:	e8 bb 0c 00 00       	call   edd <wait>
    break;
     222:	eb 22                	jmp    246 <runcmd+0x246>
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
     224:	8b 45 08             	mov    0x8(%ebp),%eax
     227:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(fork1() == 0)
     22a:	e8 8d 01 00 00       	call   3bc <fork1>
     22f:	85 c0                	test   %eax,%eax
     231:	75 12                	jne    245 <runcmd+0x245>
      runcmd(bcmd->cmd);
     233:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     236:	8b 40 04             	mov    0x4(%eax),%eax
     239:	83 ec 0c             	sub    $0xc,%esp
     23c:	50                   	push   %eax
     23d:	e8 be fd ff ff       	call   0 <runcmd>
     242:	83 c4 10             	add    $0x10,%esp
    break;
     245:	90                   	nop
  }
  exit();
     246:	e8 8a 0c 00 00       	call   ed5 <exit>

0000024b <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     24b:	55                   	push   %ebp
     24c:	89 e5                	mov    %esp,%ebp
     24e:	83 ec 08             	sub    $0x8,%esp
  printf(2, "$ ");
     251:	83 ec 08             	sub    $0x8,%esp
     254:	68 04 2d 00 00       	push   $0x2d04
     259:	6a 02                	push   $0x2
     25b:	e8 1c 0e 00 00       	call   107c <printf>
     260:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     263:	8b 45 0c             	mov    0xc(%ebp),%eax
     266:	83 ec 04             	sub    $0x4,%esp
     269:	50                   	push   %eax
     26a:	6a 00                	push   $0x0
     26c:	ff 75 08             	pushl  0x8(%ebp)
     26f:	e8 c6 0a 00 00       	call   d3a <memset>
     274:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     277:	83 ec 08             	sub    $0x8,%esp
     27a:	ff 75 0c             	pushl  0xc(%ebp)
     27d:	ff 75 08             	pushl  0x8(%ebp)
     280:	e8 02 0b 00 00       	call   d87 <gets>
     285:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     288:	8b 45 08             	mov    0x8(%ebp),%eax
     28b:	0f b6 00             	movzbl (%eax),%eax
     28e:	84 c0                	test   %al,%al
     290:	75 07                	jne    299 <getcmd+0x4e>
    return -1;
     292:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     297:	eb 05                	jmp    29e <getcmd+0x53>
  return 0;
     299:	b8 00 00 00 00       	mov    $0x0,%eax
}
     29e:	c9                   	leave  
     29f:	c3                   	ret    

000002a0 <main>:

int
main(void)
{
     2a0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     2a4:	83 e4 f0             	and    $0xfffffff0,%esp
     2a7:	ff 71 fc             	pushl  -0x4(%ecx)
     2aa:	55                   	push   %ebp
     2ab:	89 e5                	mov    %esp,%ebp
     2ad:	51                   	push   %ecx
     2ae:	83 ec 14             	sub    $0x14,%esp
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     2b1:	eb 16                	jmp    2c9 <main+0x29>
    if(fd >= 3){
     2b3:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
     2b7:	7e 10                	jle    2c9 <main+0x29>
      close(fd);
     2b9:	83 ec 0c             	sub    $0xc,%esp
     2bc:	ff 75 f4             	pushl  -0xc(%ebp)
     2bf:	e8 39 0c 00 00       	call   efd <close>
     2c4:	83 c4 10             	add    $0x10,%esp
      break;
     2c7:	eb 1b                	jmp    2e4 <main+0x44>
{
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     2c9:	83 ec 08             	sub    $0x8,%esp
     2cc:	6a 02                	push   $0x2
     2ce:	68 07 2d 00 00       	push   $0x2d07
     2d3:	e8 3d 0c 00 00       	call   f15 <open>
     2d8:	83 c4 10             	add    $0x10,%esp
     2db:	89 45 f4             	mov    %eax,-0xc(%ebp)
     2de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2e2:	79 cf                	jns    2b3 <main+0x13>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     2e4:	e9 94 00 00 00       	jmp    37d <main+0xdd>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     2e9:	0f b6 05 c0 36 00 00 	movzbl 0x36c0,%eax
     2f0:	3c 63                	cmp    $0x63,%al
     2f2:	75 5f                	jne    353 <main+0xb3>
     2f4:	0f b6 05 c1 36 00 00 	movzbl 0x36c1,%eax
     2fb:	3c 64                	cmp    $0x64,%al
     2fd:	75 54                	jne    353 <main+0xb3>
     2ff:	0f b6 05 c2 36 00 00 	movzbl 0x36c2,%eax
     306:	3c 20                	cmp    $0x20,%al
     308:	75 49                	jne    353 <main+0xb3>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     30a:	83 ec 0c             	sub    $0xc,%esp
     30d:	68 c0 36 00 00       	push   $0x36c0
     312:	e8 fc 09 00 00       	call   d13 <strlen>
     317:	83 c4 10             	add    $0x10,%esp
     31a:	83 e8 01             	sub    $0x1,%eax
     31d:	c6 80 c0 36 00 00 00 	movb   $0x0,0x36c0(%eax)
      if(chdir(buf+3) < 0)
     324:	b8 c3 36 00 00       	mov    $0x36c3,%eax
     329:	83 ec 0c             	sub    $0xc,%esp
     32c:	50                   	push   %eax
     32d:	e8 13 0c 00 00       	call   f45 <chdir>
     332:	83 c4 10             	add    $0x10,%esp
     335:	85 c0                	test   %eax,%eax
     337:	79 44                	jns    37d <main+0xdd>
        printf(2, "cannot cd %s\n", buf+3);
     339:	b8 c3 36 00 00       	mov    $0x36c3,%eax
     33e:	83 ec 04             	sub    $0x4,%esp
     341:	50                   	push   %eax
     342:	68 0f 2d 00 00       	push   $0x2d0f
     347:	6a 02                	push   $0x2
     349:	e8 2e 0d 00 00       	call   107c <printf>
     34e:	83 c4 10             	add    $0x10,%esp
      continue;
     351:	eb 2a                	jmp    37d <main+0xdd>
    }
    if(fork1() == 0)
     353:	e8 64 00 00 00       	call   3bc <fork1>
     358:	85 c0                	test   %eax,%eax
     35a:	75 1c                	jne    378 <main+0xd8>
      runcmd(parsecmd(buf));
     35c:	83 ec 0c             	sub    $0xc,%esp
     35f:	68 c0 36 00 00       	push   $0x36c0
     364:	e8 ab 03 00 00       	call   714 <parsecmd>
     369:	83 c4 10             	add    $0x10,%esp
     36c:	83 ec 0c             	sub    $0xc,%esp
     36f:	50                   	push   %eax
     370:	e8 8b fc ff ff       	call   0 <runcmd>
     375:	83 c4 10             	add    $0x10,%esp
    wait();
     378:	e8 60 0b 00 00       	call   edd <wait>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     37d:	83 ec 08             	sub    $0x8,%esp
     380:	6a 64                	push   $0x64
     382:	68 c0 36 00 00       	push   $0x36c0
     387:	e8 bf fe ff ff       	call   24b <getcmd>
     38c:	83 c4 10             	add    $0x10,%esp
     38f:	85 c0                	test   %eax,%eax
     391:	0f 89 52 ff ff ff    	jns    2e9 <main+0x49>
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit();
     397:	e8 39 0b 00 00       	call   ed5 <exit>

0000039c <panic>:
}

void
panic(char *s)
{
     39c:	55                   	push   %ebp
     39d:	89 e5                	mov    %esp,%ebp
     39f:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     3a2:	83 ec 04             	sub    $0x4,%esp
     3a5:	ff 75 08             	pushl  0x8(%ebp)
     3a8:	68 1d 2d 00 00       	push   $0x2d1d
     3ad:	6a 02                	push   $0x2
     3af:	e8 c8 0c 00 00       	call   107c <printf>
     3b4:	83 c4 10             	add    $0x10,%esp
  exit();
     3b7:	e8 19 0b 00 00       	call   ed5 <exit>

000003bc <fork1>:
}

int
fork1(void)
{
     3bc:	55                   	push   %ebp
     3bd:	89 e5                	mov    %esp,%ebp
     3bf:	83 ec 18             	sub    $0x18,%esp
  int pid;
  
  pid = fork();
     3c2:	e8 06 0b 00 00       	call   ecd <fork>
     3c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     3ca:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     3ce:	75 10                	jne    3e0 <fork1+0x24>
    panic("fork");
     3d0:	83 ec 0c             	sub    $0xc,%esp
     3d3:	68 21 2d 00 00       	push   $0x2d21
     3d8:	e8 bf ff ff ff       	call   39c <panic>
     3dd:	83 c4 10             	add    $0x10,%esp
  return pid;
     3e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     3e3:	c9                   	leave  
     3e4:	c3                   	ret    

000003e5 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3e5:	55                   	push   %ebp
     3e6:	89 e5                	mov    %esp,%ebp
     3e8:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3eb:	83 ec 0c             	sub    $0xc,%esp
     3ee:	6a 54                	push   $0x54
     3f0:	e8 5a 0f 00 00       	call   134f <malloc>
     3f5:	83 c4 10             	add    $0x10,%esp
     3f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     3fb:	83 ec 04             	sub    $0x4,%esp
     3fe:	6a 54                	push   $0x54
     400:	6a 00                	push   $0x0
     402:	ff 75 f4             	pushl  -0xc(%ebp)
     405:	e8 30 09 00 00       	call   d3a <memset>
     40a:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     40d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     410:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     416:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     419:	c9                   	leave  
     41a:	c3                   	ret    

0000041b <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     41b:	55                   	push   %ebp
     41c:	89 e5                	mov    %esp,%ebp
     41e:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     421:	83 ec 0c             	sub    $0xc,%esp
     424:	6a 18                	push   $0x18
     426:	e8 24 0f 00 00       	call   134f <malloc>
     42b:	83 c4 10             	add    $0x10,%esp
     42e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     431:	83 ec 04             	sub    $0x4,%esp
     434:	6a 18                	push   $0x18
     436:	6a 00                	push   $0x0
     438:	ff 75 f4             	pushl  -0xc(%ebp)
     43b:	e8 fa 08 00 00       	call   d3a <memset>
     440:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     443:	8b 45 f4             	mov    -0xc(%ebp),%eax
     446:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     44c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     44f:	8b 55 08             	mov    0x8(%ebp),%edx
     452:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     455:	8b 45 f4             	mov    -0xc(%ebp),%eax
     458:	8b 55 0c             	mov    0xc(%ebp),%edx
     45b:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     45e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     461:	8b 55 10             	mov    0x10(%ebp),%edx
     464:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     467:	8b 45 f4             	mov    -0xc(%ebp),%eax
     46a:	8b 55 14             	mov    0x14(%ebp),%edx
     46d:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     470:	8b 45 f4             	mov    -0xc(%ebp),%eax
     473:	8b 55 18             	mov    0x18(%ebp),%edx
     476:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     479:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     47c:	c9                   	leave  
     47d:	c3                   	ret    

0000047e <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     47e:	55                   	push   %ebp
     47f:	89 e5                	mov    %esp,%ebp
     481:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     484:	83 ec 0c             	sub    $0xc,%esp
     487:	6a 0c                	push   $0xc
     489:	e8 c1 0e 00 00       	call   134f <malloc>
     48e:	83 c4 10             	add    $0x10,%esp
     491:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     494:	83 ec 04             	sub    $0x4,%esp
     497:	6a 0c                	push   $0xc
     499:	6a 00                	push   $0x0
     49b:	ff 75 f4             	pushl  -0xc(%ebp)
     49e:	e8 97 08 00 00       	call   d3a <memset>
     4a3:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     4a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4a9:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     4af:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4b2:	8b 55 08             	mov    0x8(%ebp),%edx
     4b5:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     4b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4bb:	8b 55 0c             	mov    0xc(%ebp),%edx
     4be:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     4c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     4c4:	c9                   	leave  
     4c5:	c3                   	ret    

000004c6 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4c6:	55                   	push   %ebp
     4c7:	89 e5                	mov    %esp,%ebp
     4c9:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4cc:	83 ec 0c             	sub    $0xc,%esp
     4cf:	6a 0c                	push   $0xc
     4d1:	e8 79 0e 00 00       	call   134f <malloc>
     4d6:	83 c4 10             	add    $0x10,%esp
     4d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     4dc:	83 ec 04             	sub    $0x4,%esp
     4df:	6a 0c                	push   $0xc
     4e1:	6a 00                	push   $0x0
     4e3:	ff 75 f4             	pushl  -0xc(%ebp)
     4e6:	e8 4f 08 00 00       	call   d3a <memset>
     4eb:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     4ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f1:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     4f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4fa:	8b 55 08             	mov    0x8(%ebp),%edx
     4fd:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     500:	8b 45 f4             	mov    -0xc(%ebp),%eax
     503:	8b 55 0c             	mov    0xc(%ebp),%edx
     506:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     509:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     50c:	c9                   	leave  
     50d:	c3                   	ret    

0000050e <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     50e:	55                   	push   %ebp
     50f:	89 e5                	mov    %esp,%ebp
     511:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     514:	83 ec 0c             	sub    $0xc,%esp
     517:	6a 08                	push   $0x8
     519:	e8 31 0e 00 00       	call   134f <malloc>
     51e:	83 c4 10             	add    $0x10,%esp
     521:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     524:	83 ec 04             	sub    $0x4,%esp
     527:	6a 08                	push   $0x8
     529:	6a 00                	push   $0x0
     52b:	ff 75 f4             	pushl  -0xc(%ebp)
     52e:	e8 07 08 00 00       	call   d3a <memset>
     533:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     536:	8b 45 f4             	mov    -0xc(%ebp),%eax
     539:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     53f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     542:	8b 55 08             	mov    0x8(%ebp),%edx
     545:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     548:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     54b:	c9                   	leave  
     54c:	c3                   	ret    

0000054d <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     54d:	55                   	push   %ebp
     54e:	89 e5                	mov    %esp,%ebp
     550:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;
  
  s = *ps;
     553:	8b 45 08             	mov    0x8(%ebp),%eax
     556:	8b 00                	mov    (%eax),%eax
     558:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     55b:	eb 04                	jmp    561 <gettoken+0x14>
    s++;
     55d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     561:	8b 45 f4             	mov    -0xc(%ebp),%eax
     564:	3b 45 0c             	cmp    0xc(%ebp),%eax
     567:	73 1e                	jae    587 <gettoken+0x3a>
     569:	8b 45 f4             	mov    -0xc(%ebp),%eax
     56c:	0f b6 00             	movzbl (%eax),%eax
     56f:	0f be c0             	movsbl %al,%eax
     572:	83 ec 08             	sub    $0x8,%esp
     575:	50                   	push   %eax
     576:	68 74 36 00 00       	push   $0x3674
     57b:	e8 d4 07 00 00       	call   d54 <strchr>
     580:	83 c4 10             	add    $0x10,%esp
     583:	85 c0                	test   %eax,%eax
     585:	75 d6                	jne    55d <gettoken+0x10>
    s++;
  if(q)
     587:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     58b:	74 08                	je     595 <gettoken+0x48>
    *q = s;
     58d:	8b 45 10             	mov    0x10(%ebp),%eax
     590:	8b 55 f4             	mov    -0xc(%ebp),%edx
     593:	89 10                	mov    %edx,(%eax)
  ret = *s;
     595:	8b 45 f4             	mov    -0xc(%ebp),%eax
     598:	0f b6 00             	movzbl (%eax),%eax
     59b:	0f be c0             	movsbl %al,%eax
     59e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     5a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5a4:	0f b6 00             	movzbl (%eax),%eax
     5a7:	0f be c0             	movsbl %al,%eax
     5aa:	83 f8 29             	cmp    $0x29,%eax
     5ad:	7f 14                	jg     5c3 <gettoken+0x76>
     5af:	83 f8 28             	cmp    $0x28,%eax
     5b2:	7d 28                	jge    5dc <gettoken+0x8f>
     5b4:	85 c0                	test   %eax,%eax
     5b6:	0f 84 94 00 00 00    	je     650 <gettoken+0x103>
     5bc:	83 f8 26             	cmp    $0x26,%eax
     5bf:	74 1b                	je     5dc <gettoken+0x8f>
     5c1:	eb 3a                	jmp    5fd <gettoken+0xb0>
     5c3:	83 f8 3e             	cmp    $0x3e,%eax
     5c6:	74 1a                	je     5e2 <gettoken+0x95>
     5c8:	83 f8 3e             	cmp    $0x3e,%eax
     5cb:	7f 0a                	jg     5d7 <gettoken+0x8a>
     5cd:	83 e8 3b             	sub    $0x3b,%eax
     5d0:	83 f8 01             	cmp    $0x1,%eax
     5d3:	77 28                	ja     5fd <gettoken+0xb0>
     5d5:	eb 05                	jmp    5dc <gettoken+0x8f>
     5d7:	83 f8 7c             	cmp    $0x7c,%eax
     5da:	75 21                	jne    5fd <gettoken+0xb0>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     5dc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     5e0:	eb 75                	jmp    657 <gettoken+0x10a>
  case '>':
    s++;
     5e2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     5e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5e9:	0f b6 00             	movzbl (%eax),%eax
     5ec:	3c 3e                	cmp    $0x3e,%al
     5ee:	75 63                	jne    653 <gettoken+0x106>
      ret = '+';
     5f0:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     5f7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     5fb:	eb 56                	jmp    653 <gettoken+0x106>
  default:
    ret = 'a';
     5fd:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     604:	eb 04                	jmp    60a <gettoken+0xbd>
      s++;
     606:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     60a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     60d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     610:	73 44                	jae    656 <gettoken+0x109>
     612:	8b 45 f4             	mov    -0xc(%ebp),%eax
     615:	0f b6 00             	movzbl (%eax),%eax
     618:	0f be c0             	movsbl %al,%eax
     61b:	83 ec 08             	sub    $0x8,%esp
     61e:	50                   	push   %eax
     61f:	68 74 36 00 00       	push   $0x3674
     624:	e8 2b 07 00 00       	call   d54 <strchr>
     629:	83 c4 10             	add    $0x10,%esp
     62c:	85 c0                	test   %eax,%eax
     62e:	75 26                	jne    656 <gettoken+0x109>
     630:	8b 45 f4             	mov    -0xc(%ebp),%eax
     633:	0f b6 00             	movzbl (%eax),%eax
     636:	0f be c0             	movsbl %al,%eax
     639:	83 ec 08             	sub    $0x8,%esp
     63c:	50                   	push   %eax
     63d:	68 7c 36 00 00       	push   $0x367c
     642:	e8 0d 07 00 00       	call   d54 <strchr>
     647:	83 c4 10             	add    $0x10,%esp
     64a:	85 c0                	test   %eax,%eax
     64c:	74 b8                	je     606 <gettoken+0xb9>
      s++;
    break;
     64e:	eb 06                	jmp    656 <gettoken+0x109>
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
     650:	90                   	nop
     651:	eb 04                	jmp    657 <gettoken+0x10a>
    s++;
    if(*s == '>'){
      ret = '+';
      s++;
    }
    break;
     653:	90                   	nop
     654:	eb 01                	jmp    657 <gettoken+0x10a>
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
     656:	90                   	nop
  }
  if(eq)
     657:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     65b:	74 0e                	je     66b <gettoken+0x11e>
    *eq = s;
     65d:	8b 45 14             	mov    0x14(%ebp),%eax
     660:	8b 55 f4             	mov    -0xc(%ebp),%edx
     663:	89 10                	mov    %edx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     665:	eb 04                	jmp    66b <gettoken+0x11e>
    s++;
     667:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     66b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     66e:	3b 45 0c             	cmp    0xc(%ebp),%eax
     671:	73 1e                	jae    691 <gettoken+0x144>
     673:	8b 45 f4             	mov    -0xc(%ebp),%eax
     676:	0f b6 00             	movzbl (%eax),%eax
     679:	0f be c0             	movsbl %al,%eax
     67c:	83 ec 08             	sub    $0x8,%esp
     67f:	50                   	push   %eax
     680:	68 74 36 00 00       	push   $0x3674
     685:	e8 ca 06 00 00       	call   d54 <strchr>
     68a:	83 c4 10             	add    $0x10,%esp
     68d:	85 c0                	test   %eax,%eax
     68f:	75 d6                	jne    667 <gettoken+0x11a>
    s++;
  *ps = s;
     691:	8b 45 08             	mov    0x8(%ebp),%eax
     694:	8b 55 f4             	mov    -0xc(%ebp),%edx
     697:	89 10                	mov    %edx,(%eax)
  return ret;
     699:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     69c:	c9                   	leave  
     69d:	c3                   	ret    

0000069e <peek>:

int
peek(char **ps, char *es, char *toks)
{
     69e:	55                   	push   %ebp
     69f:	89 e5                	mov    %esp,%ebp
     6a1:	83 ec 18             	sub    $0x18,%esp
  char *s;
  
  s = *ps;
     6a4:	8b 45 08             	mov    0x8(%ebp),%eax
     6a7:	8b 00                	mov    (%eax),%eax
     6a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     6ac:	eb 04                	jmp    6b2 <peek+0x14>
    s++;
     6ae:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     6b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6b5:	3b 45 0c             	cmp    0xc(%ebp),%eax
     6b8:	73 1e                	jae    6d8 <peek+0x3a>
     6ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6bd:	0f b6 00             	movzbl (%eax),%eax
     6c0:	0f be c0             	movsbl %al,%eax
     6c3:	83 ec 08             	sub    $0x8,%esp
     6c6:	50                   	push   %eax
     6c7:	68 74 36 00 00       	push   $0x3674
     6cc:	e8 83 06 00 00       	call   d54 <strchr>
     6d1:	83 c4 10             	add    $0x10,%esp
     6d4:	85 c0                	test   %eax,%eax
     6d6:	75 d6                	jne    6ae <peek+0x10>
    s++;
  *ps = s;
     6d8:	8b 45 08             	mov    0x8(%ebp),%eax
     6db:	8b 55 f4             	mov    -0xc(%ebp),%edx
     6de:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     6e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6e3:	0f b6 00             	movzbl (%eax),%eax
     6e6:	84 c0                	test   %al,%al
     6e8:	74 23                	je     70d <peek+0x6f>
     6ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6ed:	0f b6 00             	movzbl (%eax),%eax
     6f0:	0f be c0             	movsbl %al,%eax
     6f3:	83 ec 08             	sub    $0x8,%esp
     6f6:	50                   	push   %eax
     6f7:	ff 75 10             	pushl  0x10(%ebp)
     6fa:	e8 55 06 00 00       	call   d54 <strchr>
     6ff:	83 c4 10             	add    $0x10,%esp
     702:	85 c0                	test   %eax,%eax
     704:	74 07                	je     70d <peek+0x6f>
     706:	b8 01 00 00 00       	mov    $0x1,%eax
     70b:	eb 05                	jmp    712 <peek+0x74>
     70d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     712:	c9                   	leave  
     713:	c3                   	ret    

00000714 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     714:	55                   	push   %ebp
     715:	89 e5                	mov    %esp,%ebp
     717:	53                   	push   %ebx
     718:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     71b:	8b 5d 08             	mov    0x8(%ebp),%ebx
     71e:	8b 45 08             	mov    0x8(%ebp),%eax
     721:	83 ec 0c             	sub    $0xc,%esp
     724:	50                   	push   %eax
     725:	e8 e9 05 00 00       	call   d13 <strlen>
     72a:	83 c4 10             	add    $0x10,%esp
     72d:	01 d8                	add    %ebx,%eax
     72f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     732:	83 ec 08             	sub    $0x8,%esp
     735:	ff 75 f4             	pushl  -0xc(%ebp)
     738:	8d 45 08             	lea    0x8(%ebp),%eax
     73b:	50                   	push   %eax
     73c:	e8 61 00 00 00       	call   7a2 <parseline>
     741:	83 c4 10             	add    $0x10,%esp
     744:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     747:	83 ec 04             	sub    $0x4,%esp
     74a:	68 26 2d 00 00       	push   $0x2d26
     74f:	ff 75 f4             	pushl  -0xc(%ebp)
     752:	8d 45 08             	lea    0x8(%ebp),%eax
     755:	50                   	push   %eax
     756:	e8 43 ff ff ff       	call   69e <peek>
     75b:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     75e:	8b 45 08             	mov    0x8(%ebp),%eax
     761:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     764:	74 26                	je     78c <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
     766:	8b 45 08             	mov    0x8(%ebp),%eax
     769:	83 ec 04             	sub    $0x4,%esp
     76c:	50                   	push   %eax
     76d:	68 27 2d 00 00       	push   $0x2d27
     772:	6a 02                	push   $0x2
     774:	e8 03 09 00 00       	call   107c <printf>
     779:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     77c:	83 ec 0c             	sub    $0xc,%esp
     77f:	68 36 2d 00 00       	push   $0x2d36
     784:	e8 13 fc ff ff       	call   39c <panic>
     789:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
     78c:	83 ec 0c             	sub    $0xc,%esp
     78f:	ff 75 f0             	pushl  -0x10(%ebp)
     792:	e8 eb 03 00 00       	call   b82 <nulterminate>
     797:	83 c4 10             	add    $0x10,%esp
  return cmd;
     79a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     79d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7a0:	c9                   	leave  
     7a1:	c3                   	ret    

000007a2 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     7a2:	55                   	push   %ebp
     7a3:	89 e5                	mov    %esp,%ebp
     7a5:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     7a8:	83 ec 08             	sub    $0x8,%esp
     7ab:	ff 75 0c             	pushl  0xc(%ebp)
     7ae:	ff 75 08             	pushl  0x8(%ebp)
     7b1:	e8 99 00 00 00       	call   84f <parsepipe>
     7b6:	83 c4 10             	add    $0x10,%esp
     7b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     7bc:	eb 23                	jmp    7e1 <parseline+0x3f>
    gettoken(ps, es, 0, 0);
     7be:	6a 00                	push   $0x0
     7c0:	6a 00                	push   $0x0
     7c2:	ff 75 0c             	pushl  0xc(%ebp)
     7c5:	ff 75 08             	pushl  0x8(%ebp)
     7c8:	e8 80 fd ff ff       	call   54d <gettoken>
     7cd:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     7d0:	83 ec 0c             	sub    $0xc,%esp
     7d3:	ff 75 f4             	pushl  -0xc(%ebp)
     7d6:	e8 33 fd ff ff       	call   50e <backcmd>
     7db:	83 c4 10             	add    $0x10,%esp
     7de:	89 45 f4             	mov    %eax,-0xc(%ebp)
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     7e1:	83 ec 04             	sub    $0x4,%esp
     7e4:	68 3d 2d 00 00       	push   $0x2d3d
     7e9:	ff 75 0c             	pushl  0xc(%ebp)
     7ec:	ff 75 08             	pushl  0x8(%ebp)
     7ef:	e8 aa fe ff ff       	call   69e <peek>
     7f4:	83 c4 10             	add    $0x10,%esp
     7f7:	85 c0                	test   %eax,%eax
     7f9:	75 c3                	jne    7be <parseline+0x1c>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     7fb:	83 ec 04             	sub    $0x4,%esp
     7fe:	68 3f 2d 00 00       	push   $0x2d3f
     803:	ff 75 0c             	pushl  0xc(%ebp)
     806:	ff 75 08             	pushl  0x8(%ebp)
     809:	e8 90 fe ff ff       	call   69e <peek>
     80e:	83 c4 10             	add    $0x10,%esp
     811:	85 c0                	test   %eax,%eax
     813:	74 35                	je     84a <parseline+0xa8>
    gettoken(ps, es, 0, 0);
     815:	6a 00                	push   $0x0
     817:	6a 00                	push   $0x0
     819:	ff 75 0c             	pushl  0xc(%ebp)
     81c:	ff 75 08             	pushl  0x8(%ebp)
     81f:	e8 29 fd ff ff       	call   54d <gettoken>
     824:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     827:	83 ec 08             	sub    $0x8,%esp
     82a:	ff 75 0c             	pushl  0xc(%ebp)
     82d:	ff 75 08             	pushl  0x8(%ebp)
     830:	e8 6d ff ff ff       	call   7a2 <parseline>
     835:	83 c4 10             	add    $0x10,%esp
     838:	83 ec 08             	sub    $0x8,%esp
     83b:	50                   	push   %eax
     83c:	ff 75 f4             	pushl  -0xc(%ebp)
     83f:	e8 82 fc ff ff       	call   4c6 <listcmd>
     844:	83 c4 10             	add    $0x10,%esp
     847:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     84d:	c9                   	leave  
     84e:	c3                   	ret    

0000084f <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     84f:	55                   	push   %ebp
     850:	89 e5                	mov    %esp,%ebp
     852:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     855:	83 ec 08             	sub    $0x8,%esp
     858:	ff 75 0c             	pushl  0xc(%ebp)
     85b:	ff 75 08             	pushl  0x8(%ebp)
     85e:	e8 ec 01 00 00       	call   a4f <parseexec>
     863:	83 c4 10             	add    $0x10,%esp
     866:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     869:	83 ec 04             	sub    $0x4,%esp
     86c:	68 41 2d 00 00       	push   $0x2d41
     871:	ff 75 0c             	pushl  0xc(%ebp)
     874:	ff 75 08             	pushl  0x8(%ebp)
     877:	e8 22 fe ff ff       	call   69e <peek>
     87c:	83 c4 10             	add    $0x10,%esp
     87f:	85 c0                	test   %eax,%eax
     881:	74 35                	je     8b8 <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
     883:	6a 00                	push   $0x0
     885:	6a 00                	push   $0x0
     887:	ff 75 0c             	pushl  0xc(%ebp)
     88a:	ff 75 08             	pushl  0x8(%ebp)
     88d:	e8 bb fc ff ff       	call   54d <gettoken>
     892:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     895:	83 ec 08             	sub    $0x8,%esp
     898:	ff 75 0c             	pushl  0xc(%ebp)
     89b:	ff 75 08             	pushl  0x8(%ebp)
     89e:	e8 ac ff ff ff       	call   84f <parsepipe>
     8a3:	83 c4 10             	add    $0x10,%esp
     8a6:	83 ec 08             	sub    $0x8,%esp
     8a9:	50                   	push   %eax
     8aa:	ff 75 f4             	pushl  -0xc(%ebp)
     8ad:	e8 cc fb ff ff       	call   47e <pipecmd>
     8b2:	83 c4 10             	add    $0x10,%esp
     8b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     8b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     8bb:	c9                   	leave  
     8bc:	c3                   	ret    

000008bd <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     8bd:	55                   	push   %ebp
     8be:	89 e5                	mov    %esp,%ebp
     8c0:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     8c3:	e9 b6 00 00 00       	jmp    97e <parseredirs+0xc1>
    tok = gettoken(ps, es, 0, 0);
     8c8:	6a 00                	push   $0x0
     8ca:	6a 00                	push   $0x0
     8cc:	ff 75 10             	pushl  0x10(%ebp)
     8cf:	ff 75 0c             	pushl  0xc(%ebp)
     8d2:	e8 76 fc ff ff       	call   54d <gettoken>
     8d7:	83 c4 10             	add    $0x10,%esp
     8da:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     8dd:	8d 45 ec             	lea    -0x14(%ebp),%eax
     8e0:	50                   	push   %eax
     8e1:	8d 45 f0             	lea    -0x10(%ebp),%eax
     8e4:	50                   	push   %eax
     8e5:	ff 75 10             	pushl  0x10(%ebp)
     8e8:	ff 75 0c             	pushl  0xc(%ebp)
     8eb:	e8 5d fc ff ff       	call   54d <gettoken>
     8f0:	83 c4 10             	add    $0x10,%esp
     8f3:	83 f8 61             	cmp    $0x61,%eax
     8f6:	74 10                	je     908 <parseredirs+0x4b>
      panic("missing file for redirection");
     8f8:	83 ec 0c             	sub    $0xc,%esp
     8fb:	68 43 2d 00 00       	push   $0x2d43
     900:	e8 97 fa ff ff       	call   39c <panic>
     905:	83 c4 10             	add    $0x10,%esp
    switch(tok){
     908:	8b 45 f4             	mov    -0xc(%ebp),%eax
     90b:	83 f8 3c             	cmp    $0x3c,%eax
     90e:	74 0c                	je     91c <parseredirs+0x5f>
     910:	83 f8 3e             	cmp    $0x3e,%eax
     913:	74 26                	je     93b <parseredirs+0x7e>
     915:	83 f8 2b             	cmp    $0x2b,%eax
     918:	74 43                	je     95d <parseredirs+0xa0>
     91a:	eb 62                	jmp    97e <parseredirs+0xc1>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     91c:	8b 55 ec             	mov    -0x14(%ebp),%edx
     91f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     922:	83 ec 0c             	sub    $0xc,%esp
     925:	6a 00                	push   $0x0
     927:	6a 00                	push   $0x0
     929:	52                   	push   %edx
     92a:	50                   	push   %eax
     92b:	ff 75 08             	pushl  0x8(%ebp)
     92e:	e8 e8 fa ff ff       	call   41b <redircmd>
     933:	83 c4 20             	add    $0x20,%esp
     936:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     939:	eb 43                	jmp    97e <parseredirs+0xc1>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     93b:	8b 55 ec             	mov    -0x14(%ebp),%edx
     93e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     941:	83 ec 0c             	sub    $0xc,%esp
     944:	6a 01                	push   $0x1
     946:	68 01 02 00 00       	push   $0x201
     94b:	52                   	push   %edx
     94c:	50                   	push   %eax
     94d:	ff 75 08             	pushl  0x8(%ebp)
     950:	e8 c6 fa ff ff       	call   41b <redircmd>
     955:	83 c4 20             	add    $0x20,%esp
     958:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     95b:	eb 21                	jmp    97e <parseredirs+0xc1>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     95d:	8b 55 ec             	mov    -0x14(%ebp),%edx
     960:	8b 45 f0             	mov    -0x10(%ebp),%eax
     963:	83 ec 0c             	sub    $0xc,%esp
     966:	6a 01                	push   $0x1
     968:	68 01 02 00 00       	push   $0x201
     96d:	52                   	push   %edx
     96e:	50                   	push   %eax
     96f:	ff 75 08             	pushl  0x8(%ebp)
     972:	e8 a4 fa ff ff       	call   41b <redircmd>
     977:	83 c4 20             	add    $0x20,%esp
     97a:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     97d:	90                   	nop
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     97e:	83 ec 04             	sub    $0x4,%esp
     981:	68 60 2d 00 00       	push   $0x2d60
     986:	ff 75 10             	pushl  0x10(%ebp)
     989:	ff 75 0c             	pushl  0xc(%ebp)
     98c:	e8 0d fd ff ff       	call   69e <peek>
     991:	83 c4 10             	add    $0x10,%esp
     994:	85 c0                	test   %eax,%eax
     996:	0f 85 2c ff ff ff    	jne    8c8 <parseredirs+0xb>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
     99c:	8b 45 08             	mov    0x8(%ebp),%eax
}
     99f:	c9                   	leave  
     9a0:	c3                   	ret    

000009a1 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     9a1:	55                   	push   %ebp
     9a2:	89 e5                	mov    %esp,%ebp
     9a4:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     9a7:	83 ec 04             	sub    $0x4,%esp
     9aa:	68 63 2d 00 00       	push   $0x2d63
     9af:	ff 75 0c             	pushl  0xc(%ebp)
     9b2:	ff 75 08             	pushl  0x8(%ebp)
     9b5:	e8 e4 fc ff ff       	call   69e <peek>
     9ba:	83 c4 10             	add    $0x10,%esp
     9bd:	85 c0                	test   %eax,%eax
     9bf:	75 10                	jne    9d1 <parseblock+0x30>
    panic("parseblock");
     9c1:	83 ec 0c             	sub    $0xc,%esp
     9c4:	68 65 2d 00 00       	push   $0x2d65
     9c9:	e8 ce f9 ff ff       	call   39c <panic>
     9ce:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     9d1:	6a 00                	push   $0x0
     9d3:	6a 00                	push   $0x0
     9d5:	ff 75 0c             	pushl  0xc(%ebp)
     9d8:	ff 75 08             	pushl  0x8(%ebp)
     9db:	e8 6d fb ff ff       	call   54d <gettoken>
     9e0:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
     9e3:	83 ec 08             	sub    $0x8,%esp
     9e6:	ff 75 0c             	pushl  0xc(%ebp)
     9e9:	ff 75 08             	pushl  0x8(%ebp)
     9ec:	e8 b1 fd ff ff       	call   7a2 <parseline>
     9f1:	83 c4 10             	add    $0x10,%esp
     9f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     9f7:	83 ec 04             	sub    $0x4,%esp
     9fa:	68 70 2d 00 00       	push   $0x2d70
     9ff:	ff 75 0c             	pushl  0xc(%ebp)
     a02:	ff 75 08             	pushl  0x8(%ebp)
     a05:	e8 94 fc ff ff       	call   69e <peek>
     a0a:	83 c4 10             	add    $0x10,%esp
     a0d:	85 c0                	test   %eax,%eax
     a0f:	75 10                	jne    a21 <parseblock+0x80>
    panic("syntax - missing )");
     a11:	83 ec 0c             	sub    $0xc,%esp
     a14:	68 72 2d 00 00       	push   $0x2d72
     a19:	e8 7e f9 ff ff       	call   39c <panic>
     a1e:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     a21:	6a 00                	push   $0x0
     a23:	6a 00                	push   $0x0
     a25:	ff 75 0c             	pushl  0xc(%ebp)
     a28:	ff 75 08             	pushl  0x8(%ebp)
     a2b:	e8 1d fb ff ff       	call   54d <gettoken>
     a30:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
     a33:	83 ec 04             	sub    $0x4,%esp
     a36:	ff 75 0c             	pushl  0xc(%ebp)
     a39:	ff 75 08             	pushl  0x8(%ebp)
     a3c:	ff 75 f4             	pushl  -0xc(%ebp)
     a3f:	e8 79 fe ff ff       	call   8bd <parseredirs>
     a44:	83 c4 10             	add    $0x10,%esp
     a47:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     a4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     a4d:	c9                   	leave  
     a4e:	c3                   	ret    

00000a4f <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     a4f:	55                   	push   %ebp
     a50:	89 e5                	mov    %esp,%ebp
     a52:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     a55:	83 ec 04             	sub    $0x4,%esp
     a58:	68 63 2d 00 00       	push   $0x2d63
     a5d:	ff 75 0c             	pushl  0xc(%ebp)
     a60:	ff 75 08             	pushl  0x8(%ebp)
     a63:	e8 36 fc ff ff       	call   69e <peek>
     a68:	83 c4 10             	add    $0x10,%esp
     a6b:	85 c0                	test   %eax,%eax
     a6d:	74 16                	je     a85 <parseexec+0x36>
    return parseblock(ps, es);
     a6f:	83 ec 08             	sub    $0x8,%esp
     a72:	ff 75 0c             	pushl  0xc(%ebp)
     a75:	ff 75 08             	pushl  0x8(%ebp)
     a78:	e8 24 ff ff ff       	call   9a1 <parseblock>
     a7d:	83 c4 10             	add    $0x10,%esp
     a80:	e9 fb 00 00 00       	jmp    b80 <parseexec+0x131>

  ret = execcmd();
     a85:	e8 5b f9 ff ff       	call   3e5 <execcmd>
     a8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
     a8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a90:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
     a93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
     a9a:	83 ec 04             	sub    $0x4,%esp
     a9d:	ff 75 0c             	pushl  0xc(%ebp)
     aa0:	ff 75 08             	pushl  0x8(%ebp)
     aa3:	ff 75 f0             	pushl  -0x10(%ebp)
     aa6:	e8 12 fe ff ff       	call   8bd <parseredirs>
     aab:	83 c4 10             	add    $0x10,%esp
     aae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     ab1:	e9 87 00 00 00       	jmp    b3d <parseexec+0xee>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     ab6:	8d 45 e0             	lea    -0x20(%ebp),%eax
     ab9:	50                   	push   %eax
     aba:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     abd:	50                   	push   %eax
     abe:	ff 75 0c             	pushl  0xc(%ebp)
     ac1:	ff 75 08             	pushl  0x8(%ebp)
     ac4:	e8 84 fa ff ff       	call   54d <gettoken>
     ac9:	83 c4 10             	add    $0x10,%esp
     acc:	89 45 e8             	mov    %eax,-0x18(%ebp)
     acf:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     ad3:	0f 84 84 00 00 00    	je     b5d <parseexec+0x10e>
      break;
    if(tok != 'a')
     ad9:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     add:	74 10                	je     aef <parseexec+0xa0>
      panic("syntax");
     adf:	83 ec 0c             	sub    $0xc,%esp
     ae2:	68 36 2d 00 00       	push   $0x2d36
     ae7:	e8 b0 f8 ff ff       	call   39c <panic>
     aec:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
     aef:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     af2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     af5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     af8:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     afc:	8b 55 e0             	mov    -0x20(%ebp),%edx
     aff:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b02:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     b05:	83 c1 08             	add    $0x8,%ecx
     b08:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     b0c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
     b10:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     b14:	7e 10                	jle    b26 <parseexec+0xd7>
      panic("too many args");
     b16:	83 ec 0c             	sub    $0xc,%esp
     b19:	68 85 2d 00 00       	push   $0x2d85
     b1e:	e8 79 f8 ff ff       	call   39c <panic>
     b23:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
     b26:	83 ec 04             	sub    $0x4,%esp
     b29:	ff 75 0c             	pushl  0xc(%ebp)
     b2c:	ff 75 08             	pushl  0x8(%ebp)
     b2f:	ff 75 f0             	pushl  -0x10(%ebp)
     b32:	e8 86 fd ff ff       	call   8bd <parseredirs>
     b37:	83 c4 10             	add    $0x10,%esp
     b3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     b3d:	83 ec 04             	sub    $0x4,%esp
     b40:	68 93 2d 00 00       	push   $0x2d93
     b45:	ff 75 0c             	pushl  0xc(%ebp)
     b48:	ff 75 08             	pushl  0x8(%ebp)
     b4b:	e8 4e fb ff ff       	call   69e <peek>
     b50:	83 c4 10             	add    $0x10,%esp
     b53:	85 c0                	test   %eax,%eax
     b55:	0f 84 5b ff ff ff    	je     ab6 <parseexec+0x67>
     b5b:	eb 01                	jmp    b5e <parseexec+0x10f>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
     b5d:	90                   	nop
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     b5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b61:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b64:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     b6b:	00 
  cmd->eargv[argc] = 0;
     b6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b72:	83 c2 08             	add    $0x8,%edx
     b75:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     b7c:	00 
  return ret;
     b7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     b80:	c9                   	leave  
     b81:	c3                   	ret    

00000b82 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     b82:	55                   	push   %ebp
     b83:	89 e5                	mov    %esp,%ebp
     b85:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     b88:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     b8c:	75 0a                	jne    b98 <nulterminate+0x16>
    return 0;
     b8e:	b8 00 00 00 00       	mov    $0x0,%eax
     b93:	e9 e4 00 00 00       	jmp    c7c <nulterminate+0xfa>
  
  switch(cmd->type){
     b98:	8b 45 08             	mov    0x8(%ebp),%eax
     b9b:	8b 00                	mov    (%eax),%eax
     b9d:	83 f8 05             	cmp    $0x5,%eax
     ba0:	0f 87 d3 00 00 00    	ja     c79 <nulterminate+0xf7>
     ba6:	8b 04 85 98 2d 00 00 	mov    0x2d98(,%eax,4),%eax
     bad:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     baf:	8b 45 08             	mov    0x8(%ebp),%eax
     bb2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     bb5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     bbc:	eb 14                	jmp    bd2 <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
     bbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bc1:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bc4:	83 c2 08             	add    $0x8,%edx
     bc7:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     bcb:	c6 00 00             	movb   $0x0,(%eax)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     bce:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     bd2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bd5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bd8:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     bdc:	85 c0                	test   %eax,%eax
     bde:	75 de                	jne    bbe <nulterminate+0x3c>
      *ecmd->eargv[i] = 0;
    break;
     be0:	e9 94 00 00 00       	jmp    c79 <nulterminate+0xf7>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     be5:	8b 45 08             	mov    0x8(%ebp),%eax
     be8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(rcmd->cmd);
     beb:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bee:	8b 40 04             	mov    0x4(%eax),%eax
     bf1:	83 ec 0c             	sub    $0xc,%esp
     bf4:	50                   	push   %eax
     bf5:	e8 88 ff ff ff       	call   b82 <nulterminate>
     bfa:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     bfd:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c00:	8b 40 0c             	mov    0xc(%eax),%eax
     c03:	c6 00 00             	movb   $0x0,(%eax)
    break;
     c06:	eb 71                	jmp    c79 <nulterminate+0xf7>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     c08:	8b 45 08             	mov    0x8(%ebp),%eax
     c0b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
     c0e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c11:	8b 40 04             	mov    0x4(%eax),%eax
     c14:	83 ec 0c             	sub    $0xc,%esp
     c17:	50                   	push   %eax
     c18:	e8 65 ff ff ff       	call   b82 <nulterminate>
     c1d:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
     c20:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c23:	8b 40 08             	mov    0x8(%eax),%eax
     c26:	83 ec 0c             	sub    $0xc,%esp
     c29:	50                   	push   %eax
     c2a:	e8 53 ff ff ff       	call   b82 <nulterminate>
     c2f:	83 c4 10             	add    $0x10,%esp
    break;
     c32:	eb 45                	jmp    c79 <nulterminate+0xf7>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
     c34:	8b 45 08             	mov    0x8(%ebp),%eax
     c37:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(lcmd->left);
     c3a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c3d:	8b 40 04             	mov    0x4(%eax),%eax
     c40:	83 ec 0c             	sub    $0xc,%esp
     c43:	50                   	push   %eax
     c44:	e8 39 ff ff ff       	call   b82 <nulterminate>
     c49:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
     c4c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c4f:	8b 40 08             	mov    0x8(%eax),%eax
     c52:	83 ec 0c             	sub    $0xc,%esp
     c55:	50                   	push   %eax
     c56:	e8 27 ff ff ff       	call   b82 <nulterminate>
     c5b:	83 c4 10             	add    $0x10,%esp
    break;
     c5e:	eb 19                	jmp    c79 <nulterminate+0xf7>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     c60:	8b 45 08             	mov    0x8(%ebp),%eax
     c63:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nulterminate(bcmd->cmd);
     c66:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c69:	8b 40 04             	mov    0x4(%eax),%eax
     c6c:	83 ec 0c             	sub    $0xc,%esp
     c6f:	50                   	push   %eax
     c70:	e8 0d ff ff ff       	call   b82 <nulterminate>
     c75:	83 c4 10             	add    $0x10,%esp
    break;
     c78:	90                   	nop
  }
  return cmd;
     c79:	8b 45 08             	mov    0x8(%ebp),%eax
}
     c7c:	c9                   	leave  
     c7d:	c3                   	ret    

00000c7e <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     c7e:	55                   	push   %ebp
     c7f:	89 e5                	mov    %esp,%ebp
     c81:	57                   	push   %edi
     c82:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     c83:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c86:	8b 55 10             	mov    0x10(%ebp),%edx
     c89:	8b 45 0c             	mov    0xc(%ebp),%eax
     c8c:	89 cb                	mov    %ecx,%ebx
     c8e:	89 df                	mov    %ebx,%edi
     c90:	89 d1                	mov    %edx,%ecx
     c92:	fc                   	cld    
     c93:	f3 aa                	rep stos %al,%es:(%edi)
     c95:	89 ca                	mov    %ecx,%edx
     c97:	89 fb                	mov    %edi,%ebx
     c99:	89 5d 08             	mov    %ebx,0x8(%ebp)
     c9c:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     c9f:	90                   	nop
     ca0:	5b                   	pop    %ebx
     ca1:	5f                   	pop    %edi
     ca2:	5d                   	pop    %ebp
     ca3:	c3                   	ret    

00000ca4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     ca4:	55                   	push   %ebp
     ca5:	89 e5                	mov    %esp,%ebp
     ca7:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     caa:	8b 45 08             	mov    0x8(%ebp),%eax
     cad:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     cb0:	90                   	nop
     cb1:	8b 45 08             	mov    0x8(%ebp),%eax
     cb4:	8d 50 01             	lea    0x1(%eax),%edx
     cb7:	89 55 08             	mov    %edx,0x8(%ebp)
     cba:	8b 55 0c             	mov    0xc(%ebp),%edx
     cbd:	8d 4a 01             	lea    0x1(%edx),%ecx
     cc0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     cc3:	0f b6 12             	movzbl (%edx),%edx
     cc6:	88 10                	mov    %dl,(%eax)
     cc8:	0f b6 00             	movzbl (%eax),%eax
     ccb:	84 c0                	test   %al,%al
     ccd:	75 e2                	jne    cb1 <strcpy+0xd>
    ;
  return os;
     ccf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     cd2:	c9                   	leave  
     cd3:	c3                   	ret    

00000cd4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     cd4:	55                   	push   %ebp
     cd5:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     cd7:	eb 08                	jmp    ce1 <strcmp+0xd>
    p++, q++;
     cd9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     cdd:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     ce1:	8b 45 08             	mov    0x8(%ebp),%eax
     ce4:	0f b6 00             	movzbl (%eax),%eax
     ce7:	84 c0                	test   %al,%al
     ce9:	74 10                	je     cfb <strcmp+0x27>
     ceb:	8b 45 08             	mov    0x8(%ebp),%eax
     cee:	0f b6 10             	movzbl (%eax),%edx
     cf1:	8b 45 0c             	mov    0xc(%ebp),%eax
     cf4:	0f b6 00             	movzbl (%eax),%eax
     cf7:	38 c2                	cmp    %al,%dl
     cf9:	74 de                	je     cd9 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     cfb:	8b 45 08             	mov    0x8(%ebp),%eax
     cfe:	0f b6 00             	movzbl (%eax),%eax
     d01:	0f b6 d0             	movzbl %al,%edx
     d04:	8b 45 0c             	mov    0xc(%ebp),%eax
     d07:	0f b6 00             	movzbl (%eax),%eax
     d0a:	0f b6 c0             	movzbl %al,%eax
     d0d:	29 c2                	sub    %eax,%edx
     d0f:	89 d0                	mov    %edx,%eax
}
     d11:	5d                   	pop    %ebp
     d12:	c3                   	ret    

00000d13 <strlen>:

uint
strlen(char *s)
{
     d13:	55                   	push   %ebp
     d14:	89 e5                	mov    %esp,%ebp
     d16:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     d19:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     d20:	eb 04                	jmp    d26 <strlen+0x13>
     d22:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d26:	8b 55 fc             	mov    -0x4(%ebp),%edx
     d29:	8b 45 08             	mov    0x8(%ebp),%eax
     d2c:	01 d0                	add    %edx,%eax
     d2e:	0f b6 00             	movzbl (%eax),%eax
     d31:	84 c0                	test   %al,%al
     d33:	75 ed                	jne    d22 <strlen+0xf>
    ;
  return n;
     d35:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     d38:	c9                   	leave  
     d39:	c3                   	ret    

00000d3a <memset>:

void*
memset(void *dst, int c, uint n)
{
     d3a:	55                   	push   %ebp
     d3b:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     d3d:	8b 45 10             	mov    0x10(%ebp),%eax
     d40:	50                   	push   %eax
     d41:	ff 75 0c             	pushl  0xc(%ebp)
     d44:	ff 75 08             	pushl  0x8(%ebp)
     d47:	e8 32 ff ff ff       	call   c7e <stosb>
     d4c:	83 c4 0c             	add    $0xc,%esp
  return dst;
     d4f:	8b 45 08             	mov    0x8(%ebp),%eax
}
     d52:	c9                   	leave  
     d53:	c3                   	ret    

00000d54 <strchr>:

char*
strchr(const char *s, char c)
{
     d54:	55                   	push   %ebp
     d55:	89 e5                	mov    %esp,%ebp
     d57:	83 ec 04             	sub    $0x4,%esp
     d5a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d5d:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     d60:	eb 14                	jmp    d76 <strchr+0x22>
    if(*s == c)
     d62:	8b 45 08             	mov    0x8(%ebp),%eax
     d65:	0f b6 00             	movzbl (%eax),%eax
     d68:	3a 45 fc             	cmp    -0x4(%ebp),%al
     d6b:	75 05                	jne    d72 <strchr+0x1e>
      return (char*)s;
     d6d:	8b 45 08             	mov    0x8(%ebp),%eax
     d70:	eb 13                	jmp    d85 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     d72:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d76:	8b 45 08             	mov    0x8(%ebp),%eax
     d79:	0f b6 00             	movzbl (%eax),%eax
     d7c:	84 c0                	test   %al,%al
     d7e:	75 e2                	jne    d62 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     d80:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d85:	c9                   	leave  
     d86:	c3                   	ret    

00000d87 <gets>:

char*
gets(char *buf, int max)
{
     d87:	55                   	push   %ebp
     d88:	89 e5                	mov    %esp,%ebp
     d8a:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d94:	eb 42                	jmp    dd8 <gets+0x51>
    cc = read(0, &c, 1);
     d96:	83 ec 04             	sub    $0x4,%esp
     d99:	6a 01                	push   $0x1
     d9b:	8d 45 ef             	lea    -0x11(%ebp),%eax
     d9e:	50                   	push   %eax
     d9f:	6a 00                	push   $0x0
     da1:	e8 47 01 00 00       	call   eed <read>
     da6:	83 c4 10             	add    $0x10,%esp
     da9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     dac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     db0:	7e 33                	jle    de5 <gets+0x5e>
      break;
    buf[i++] = c;
     db2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     db5:	8d 50 01             	lea    0x1(%eax),%edx
     db8:	89 55 f4             	mov    %edx,-0xc(%ebp)
     dbb:	89 c2                	mov    %eax,%edx
     dbd:	8b 45 08             	mov    0x8(%ebp),%eax
     dc0:	01 c2                	add    %eax,%edx
     dc2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     dc6:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     dc8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     dcc:	3c 0a                	cmp    $0xa,%al
     dce:	74 16                	je     de6 <gets+0x5f>
     dd0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     dd4:	3c 0d                	cmp    $0xd,%al
     dd6:	74 0e                	je     de6 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     dd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ddb:	83 c0 01             	add    $0x1,%eax
     dde:	3b 45 0c             	cmp    0xc(%ebp),%eax
     de1:	7c b3                	jl     d96 <gets+0xf>
     de3:	eb 01                	jmp    de6 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     de5:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     de6:	8b 55 f4             	mov    -0xc(%ebp),%edx
     de9:	8b 45 08             	mov    0x8(%ebp),%eax
     dec:	01 d0                	add    %edx,%eax
     dee:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     df1:	8b 45 08             	mov    0x8(%ebp),%eax
}
     df4:	c9                   	leave  
     df5:	c3                   	ret    

00000df6 <stat>:

int
stat(char *n, struct stat *st)
{
     df6:	55                   	push   %ebp
     df7:	89 e5                	mov    %esp,%ebp
     df9:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     dfc:	83 ec 08             	sub    $0x8,%esp
     dff:	6a 00                	push   $0x0
     e01:	ff 75 08             	pushl  0x8(%ebp)
     e04:	e8 0c 01 00 00       	call   f15 <open>
     e09:	83 c4 10             	add    $0x10,%esp
     e0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     e0f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e13:	79 07                	jns    e1c <stat+0x26>
    return -1;
     e15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     e1a:	eb 25                	jmp    e41 <stat+0x4b>
  r = fstat(fd, st);
     e1c:	83 ec 08             	sub    $0x8,%esp
     e1f:	ff 75 0c             	pushl  0xc(%ebp)
     e22:	ff 75 f4             	pushl  -0xc(%ebp)
     e25:	e8 03 01 00 00       	call   f2d <fstat>
     e2a:	83 c4 10             	add    $0x10,%esp
     e2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     e30:	83 ec 0c             	sub    $0xc,%esp
     e33:	ff 75 f4             	pushl  -0xc(%ebp)
     e36:	e8 c2 00 00 00       	call   efd <close>
     e3b:	83 c4 10             	add    $0x10,%esp
  return r;
     e3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     e41:	c9                   	leave  
     e42:	c3                   	ret    

00000e43 <atoi>:

int
atoi(const char *s)
{
     e43:	55                   	push   %ebp
     e44:	89 e5                	mov    %esp,%ebp
     e46:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     e49:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     e50:	eb 25                	jmp    e77 <atoi+0x34>
    n = n*10 + *s++ - '0';
     e52:	8b 55 fc             	mov    -0x4(%ebp),%edx
     e55:	89 d0                	mov    %edx,%eax
     e57:	c1 e0 02             	shl    $0x2,%eax
     e5a:	01 d0                	add    %edx,%eax
     e5c:	01 c0                	add    %eax,%eax
     e5e:	89 c1                	mov    %eax,%ecx
     e60:	8b 45 08             	mov    0x8(%ebp),%eax
     e63:	8d 50 01             	lea    0x1(%eax),%edx
     e66:	89 55 08             	mov    %edx,0x8(%ebp)
     e69:	0f b6 00             	movzbl (%eax),%eax
     e6c:	0f be c0             	movsbl %al,%eax
     e6f:	01 c8                	add    %ecx,%eax
     e71:	83 e8 30             	sub    $0x30,%eax
     e74:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e77:	8b 45 08             	mov    0x8(%ebp),%eax
     e7a:	0f b6 00             	movzbl (%eax),%eax
     e7d:	3c 2f                	cmp    $0x2f,%al
     e7f:	7e 0a                	jle    e8b <atoi+0x48>
     e81:	8b 45 08             	mov    0x8(%ebp),%eax
     e84:	0f b6 00             	movzbl (%eax),%eax
     e87:	3c 39                	cmp    $0x39,%al
     e89:	7e c7                	jle    e52 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     e8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     e8e:	c9                   	leave  
     e8f:	c3                   	ret    

00000e90 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     e96:	8b 45 08             	mov    0x8(%ebp),%eax
     e99:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     e9c:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     ea2:	eb 17                	jmp    ebb <memmove+0x2b>
    *dst++ = *src++;
     ea4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ea7:	8d 50 01             	lea    0x1(%eax),%edx
     eaa:	89 55 fc             	mov    %edx,-0x4(%ebp)
     ead:	8b 55 f8             	mov    -0x8(%ebp),%edx
     eb0:	8d 4a 01             	lea    0x1(%edx),%ecx
     eb3:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     eb6:	0f b6 12             	movzbl (%edx),%edx
     eb9:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     ebb:	8b 45 10             	mov    0x10(%ebp),%eax
     ebe:	8d 50 ff             	lea    -0x1(%eax),%edx
     ec1:	89 55 10             	mov    %edx,0x10(%ebp)
     ec4:	85 c0                	test   %eax,%eax
     ec6:	7f dc                	jg     ea4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     ec8:	8b 45 08             	mov    0x8(%ebp),%eax
}
     ecb:	c9                   	leave  
     ecc:	c3                   	ret    

00000ecd <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     ecd:	b8 01 00 00 00       	mov    $0x1,%eax
     ed2:	cd 40                	int    $0x40
     ed4:	c3                   	ret    

00000ed5 <exit>:
SYSCALL(exit)
     ed5:	b8 02 00 00 00       	mov    $0x2,%eax
     eda:	cd 40                	int    $0x40
     edc:	c3                   	ret    

00000edd <wait>:
SYSCALL(wait)
     edd:	b8 03 00 00 00       	mov    $0x3,%eax
     ee2:	cd 40                	int    $0x40
     ee4:	c3                   	ret    

00000ee5 <pipe>:
SYSCALL(pipe)
     ee5:	b8 04 00 00 00       	mov    $0x4,%eax
     eea:	cd 40                	int    $0x40
     eec:	c3                   	ret    

00000eed <read>:
SYSCALL(read)
     eed:	b8 05 00 00 00       	mov    $0x5,%eax
     ef2:	cd 40                	int    $0x40
     ef4:	c3                   	ret    

00000ef5 <write>:
SYSCALL(write)
     ef5:	b8 10 00 00 00       	mov    $0x10,%eax
     efa:	cd 40                	int    $0x40
     efc:	c3                   	ret    

00000efd <close>:
SYSCALL(close)
     efd:	b8 15 00 00 00       	mov    $0x15,%eax
     f02:	cd 40                	int    $0x40
     f04:	c3                   	ret    

00000f05 <kill>:
SYSCALL(kill)
     f05:	b8 06 00 00 00       	mov    $0x6,%eax
     f0a:	cd 40                	int    $0x40
     f0c:	c3                   	ret    

00000f0d <exec>:
SYSCALL(exec)
     f0d:	b8 07 00 00 00       	mov    $0x7,%eax
     f12:	cd 40                	int    $0x40
     f14:	c3                   	ret    

00000f15 <open>:
SYSCALL(open)
     f15:	b8 0f 00 00 00       	mov    $0xf,%eax
     f1a:	cd 40                	int    $0x40
     f1c:	c3                   	ret    

00000f1d <mknod>:
SYSCALL(mknod)
     f1d:	b8 11 00 00 00       	mov    $0x11,%eax
     f22:	cd 40                	int    $0x40
     f24:	c3                   	ret    

00000f25 <unlink>:
SYSCALL(unlink)
     f25:	b8 12 00 00 00       	mov    $0x12,%eax
     f2a:	cd 40                	int    $0x40
     f2c:	c3                   	ret    

00000f2d <fstat>:
SYSCALL(fstat)
     f2d:	b8 08 00 00 00       	mov    $0x8,%eax
     f32:	cd 40                	int    $0x40
     f34:	c3                   	ret    

00000f35 <link>:
SYSCALL(link)
     f35:	b8 13 00 00 00       	mov    $0x13,%eax
     f3a:	cd 40                	int    $0x40
     f3c:	c3                   	ret    

00000f3d <mkdir>:
SYSCALL(mkdir)
     f3d:	b8 14 00 00 00       	mov    $0x14,%eax
     f42:	cd 40                	int    $0x40
     f44:	c3                   	ret    

00000f45 <chdir>:
SYSCALL(chdir)
     f45:	b8 09 00 00 00       	mov    $0x9,%eax
     f4a:	cd 40                	int    $0x40
     f4c:	c3                   	ret    

00000f4d <dup>:
SYSCALL(dup)
     f4d:	b8 0a 00 00 00       	mov    $0xa,%eax
     f52:	cd 40                	int    $0x40
     f54:	c3                   	ret    

00000f55 <getpid>:
SYSCALL(getpid)
     f55:	b8 0b 00 00 00       	mov    $0xb,%eax
     f5a:	cd 40                	int    $0x40
     f5c:	c3                   	ret    

00000f5d <sbrk>:
SYSCALL(sbrk)
     f5d:	b8 0c 00 00 00       	mov    $0xc,%eax
     f62:	cd 40                	int    $0x40
     f64:	c3                   	ret    

00000f65 <sleep>:
SYSCALL(sleep)
     f65:	b8 0d 00 00 00       	mov    $0xd,%eax
     f6a:	cd 40                	int    $0x40
     f6c:	c3                   	ret    

00000f6d <uptime>:
SYSCALL(uptime)
     f6d:	b8 0e 00 00 00       	mov    $0xe,%eax
     f72:	cd 40                	int    $0x40
     f74:	c3                   	ret    

00000f75 <paintWindow>:

SYSCALL(paintWindow)
     f75:	b8 16 00 00 00       	mov    $0x16,%eax
     f7a:	cd 40                	int    $0x40
     f7c:	c3                   	ret    

00000f7d <initStringFigure>:
SYSCALL(initStringFigure)
     f7d:	b8 17 00 00 00       	mov    $0x17,%eax
     f82:	cd 40                	int    $0x40
     f84:	c3                   	ret    

00000f85 <sendMessage>:
SYSCALL(sendMessage)
     f85:	b8 18 00 00 00       	mov    $0x18,%eax
     f8a:	cd 40                	int    $0x40
     f8c:	c3                   	ret    

00000f8d <getMessage>:
SYSCALL(getMessage)
     f8d:	b8 1a 00 00 00       	mov    $0x1a,%eax
     f92:	cd 40                	int    $0x40
     f94:	c3                   	ret    

00000f95 <registWindow>:
SYSCALL(registWindow)
     f95:	b8 19 00 00 00       	mov    $0x19,%eax
     f9a:	cd 40                	int    $0x40
     f9c:	c3                   	ret    

00000f9d <changePosition>:
SYSCALL(changePosition)
     f9d:	b8 1b 00 00 00       	mov    $0x1b,%eax
     fa2:	cd 40                	int    $0x40
     fa4:	c3                   	ret    

00000fa5 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     fa5:	55                   	push   %ebp
     fa6:	89 e5                	mov    %esp,%ebp
     fa8:	83 ec 18             	sub    $0x18,%esp
     fab:	8b 45 0c             	mov    0xc(%ebp),%eax
     fae:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     fb1:	83 ec 04             	sub    $0x4,%esp
     fb4:	6a 01                	push   $0x1
     fb6:	8d 45 f4             	lea    -0xc(%ebp),%eax
     fb9:	50                   	push   %eax
     fba:	ff 75 08             	pushl  0x8(%ebp)
     fbd:	e8 33 ff ff ff       	call   ef5 <write>
     fc2:	83 c4 10             	add    $0x10,%esp
}
     fc5:	90                   	nop
     fc6:	c9                   	leave  
     fc7:	c3                   	ret    

00000fc8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     fc8:	55                   	push   %ebp
     fc9:	89 e5                	mov    %esp,%ebp
     fcb:	53                   	push   %ebx
     fcc:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     fcf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     fd6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     fda:	74 17                	je     ff3 <printint+0x2b>
     fdc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     fe0:	79 11                	jns    ff3 <printint+0x2b>
    neg = 1;
     fe2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     fe9:	8b 45 0c             	mov    0xc(%ebp),%eax
     fec:	f7 d8                	neg    %eax
     fee:	89 45 ec             	mov    %eax,-0x14(%ebp)
     ff1:	eb 06                	jmp    ff9 <printint+0x31>
  } else {
    x = xx;
     ff3:	8b 45 0c             	mov    0xc(%ebp),%eax
     ff6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     ff9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1000:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1003:	8d 41 01             	lea    0x1(%ecx),%eax
    1006:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1009:	8b 5d 10             	mov    0x10(%ebp),%ebx
    100c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    100f:	ba 00 00 00 00       	mov    $0x0,%edx
    1014:	f7 f3                	div    %ebx
    1016:	89 d0                	mov    %edx,%eax
    1018:	0f b6 80 84 36 00 00 	movzbl 0x3684(%eax),%eax
    101f:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1023:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1026:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1029:	ba 00 00 00 00       	mov    $0x0,%edx
    102e:	f7 f3                	div    %ebx
    1030:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1033:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1037:	75 c7                	jne    1000 <printint+0x38>
  if(neg)
    1039:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    103d:	74 2d                	je     106c <printint+0xa4>
    buf[i++] = '-';
    103f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1042:	8d 50 01             	lea    0x1(%eax),%edx
    1045:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1048:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    104d:	eb 1d                	jmp    106c <printint+0xa4>
    putc(fd, buf[i]);
    104f:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1052:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1055:	01 d0                	add    %edx,%eax
    1057:	0f b6 00             	movzbl (%eax),%eax
    105a:	0f be c0             	movsbl %al,%eax
    105d:	83 ec 08             	sub    $0x8,%esp
    1060:	50                   	push   %eax
    1061:	ff 75 08             	pushl  0x8(%ebp)
    1064:	e8 3c ff ff ff       	call   fa5 <putc>
    1069:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    106c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1070:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1074:	79 d9                	jns    104f <printint+0x87>
    putc(fd, buf[i]);
}
    1076:	90                   	nop
    1077:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    107a:	c9                   	leave  
    107b:	c3                   	ret    

0000107c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    107c:	55                   	push   %ebp
    107d:	89 e5                	mov    %esp,%ebp
    107f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1082:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1089:	8d 45 0c             	lea    0xc(%ebp),%eax
    108c:	83 c0 04             	add    $0x4,%eax
    108f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1092:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1099:	e9 59 01 00 00       	jmp    11f7 <printf+0x17b>
    c = fmt[i] & 0xff;
    109e:	8b 55 0c             	mov    0xc(%ebp),%edx
    10a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10a4:	01 d0                	add    %edx,%eax
    10a6:	0f b6 00             	movzbl (%eax),%eax
    10a9:	0f be c0             	movsbl %al,%eax
    10ac:	25 ff 00 00 00       	and    $0xff,%eax
    10b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    10b4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10b8:	75 2c                	jne    10e6 <printf+0x6a>
      if(c == '%'){
    10ba:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    10be:	75 0c                	jne    10cc <printf+0x50>
        state = '%';
    10c0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    10c7:	e9 27 01 00 00       	jmp    11f3 <printf+0x177>
      } else {
        putc(fd, c);
    10cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10cf:	0f be c0             	movsbl %al,%eax
    10d2:	83 ec 08             	sub    $0x8,%esp
    10d5:	50                   	push   %eax
    10d6:	ff 75 08             	pushl  0x8(%ebp)
    10d9:	e8 c7 fe ff ff       	call   fa5 <putc>
    10de:	83 c4 10             	add    $0x10,%esp
    10e1:	e9 0d 01 00 00       	jmp    11f3 <printf+0x177>
      }
    } else if(state == '%'){
    10e6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    10ea:	0f 85 03 01 00 00    	jne    11f3 <printf+0x177>
      if(c == 'd'){
    10f0:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    10f4:	75 1e                	jne    1114 <printf+0x98>
        printint(fd, *ap, 10, 1);
    10f6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10f9:	8b 00                	mov    (%eax),%eax
    10fb:	6a 01                	push   $0x1
    10fd:	6a 0a                	push   $0xa
    10ff:	50                   	push   %eax
    1100:	ff 75 08             	pushl  0x8(%ebp)
    1103:	e8 c0 fe ff ff       	call   fc8 <printint>
    1108:	83 c4 10             	add    $0x10,%esp
        ap++;
    110b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    110f:	e9 d8 00 00 00       	jmp    11ec <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1114:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1118:	74 06                	je     1120 <printf+0xa4>
    111a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    111e:	75 1e                	jne    113e <printf+0xc2>
        printint(fd, *ap, 16, 0);
    1120:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1123:	8b 00                	mov    (%eax),%eax
    1125:	6a 00                	push   $0x0
    1127:	6a 10                	push   $0x10
    1129:	50                   	push   %eax
    112a:	ff 75 08             	pushl  0x8(%ebp)
    112d:	e8 96 fe ff ff       	call   fc8 <printint>
    1132:	83 c4 10             	add    $0x10,%esp
        ap++;
    1135:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1139:	e9 ae 00 00 00       	jmp    11ec <printf+0x170>
      } else if(c == 's'){
    113e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1142:	75 43                	jne    1187 <printf+0x10b>
        s = (char*)*ap;
    1144:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1147:	8b 00                	mov    (%eax),%eax
    1149:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    114c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1150:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1154:	75 25                	jne    117b <printf+0xff>
          s = "(null)";
    1156:	c7 45 f4 b0 2d 00 00 	movl   $0x2db0,-0xc(%ebp)
        while(*s != 0){
    115d:	eb 1c                	jmp    117b <printf+0xff>
          putc(fd, *s);
    115f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1162:	0f b6 00             	movzbl (%eax),%eax
    1165:	0f be c0             	movsbl %al,%eax
    1168:	83 ec 08             	sub    $0x8,%esp
    116b:	50                   	push   %eax
    116c:	ff 75 08             	pushl  0x8(%ebp)
    116f:	e8 31 fe ff ff       	call   fa5 <putc>
    1174:	83 c4 10             	add    $0x10,%esp
          s++;
    1177:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    117b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    117e:	0f b6 00             	movzbl (%eax),%eax
    1181:	84 c0                	test   %al,%al
    1183:	75 da                	jne    115f <printf+0xe3>
    1185:	eb 65                	jmp    11ec <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1187:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    118b:	75 1d                	jne    11aa <printf+0x12e>
        putc(fd, *ap);
    118d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1190:	8b 00                	mov    (%eax),%eax
    1192:	0f be c0             	movsbl %al,%eax
    1195:	83 ec 08             	sub    $0x8,%esp
    1198:	50                   	push   %eax
    1199:	ff 75 08             	pushl  0x8(%ebp)
    119c:	e8 04 fe ff ff       	call   fa5 <putc>
    11a1:	83 c4 10             	add    $0x10,%esp
        ap++;
    11a4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    11a8:	eb 42                	jmp    11ec <printf+0x170>
      } else if(c == '%'){
    11aa:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    11ae:	75 17                	jne    11c7 <printf+0x14b>
        putc(fd, c);
    11b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11b3:	0f be c0             	movsbl %al,%eax
    11b6:	83 ec 08             	sub    $0x8,%esp
    11b9:	50                   	push   %eax
    11ba:	ff 75 08             	pushl  0x8(%ebp)
    11bd:	e8 e3 fd ff ff       	call   fa5 <putc>
    11c2:	83 c4 10             	add    $0x10,%esp
    11c5:	eb 25                	jmp    11ec <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    11c7:	83 ec 08             	sub    $0x8,%esp
    11ca:	6a 25                	push   $0x25
    11cc:	ff 75 08             	pushl  0x8(%ebp)
    11cf:	e8 d1 fd ff ff       	call   fa5 <putc>
    11d4:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    11d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11da:	0f be c0             	movsbl %al,%eax
    11dd:	83 ec 08             	sub    $0x8,%esp
    11e0:	50                   	push   %eax
    11e1:	ff 75 08             	pushl  0x8(%ebp)
    11e4:	e8 bc fd ff ff       	call   fa5 <putc>
    11e9:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    11ec:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    11f3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    11f7:	8b 55 0c             	mov    0xc(%ebp),%edx
    11fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11fd:	01 d0                	add    %edx,%eax
    11ff:	0f b6 00             	movzbl (%eax),%eax
    1202:	84 c0                	test   %al,%al
    1204:	0f 85 94 fe ff ff    	jne    109e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    120a:	90                   	nop
    120b:	c9                   	leave  
    120c:	c3                   	ret    

0000120d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    120d:	55                   	push   %ebp
    120e:	89 e5                	mov    %esp,%ebp
    1210:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1213:	8b 45 08             	mov    0x8(%ebp),%eax
    1216:	83 e8 08             	sub    $0x8,%eax
    1219:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    121c:	a1 2c 37 00 00       	mov    0x372c,%eax
    1221:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1224:	eb 24                	jmp    124a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1226:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1229:	8b 00                	mov    (%eax),%eax
    122b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    122e:	77 12                	ja     1242 <free+0x35>
    1230:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1233:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1236:	77 24                	ja     125c <free+0x4f>
    1238:	8b 45 fc             	mov    -0x4(%ebp),%eax
    123b:	8b 00                	mov    (%eax),%eax
    123d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1240:	77 1a                	ja     125c <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1242:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1245:	8b 00                	mov    (%eax),%eax
    1247:	89 45 fc             	mov    %eax,-0x4(%ebp)
    124a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    124d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1250:	76 d4                	jbe    1226 <free+0x19>
    1252:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1255:	8b 00                	mov    (%eax),%eax
    1257:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    125a:	76 ca                	jbe    1226 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    125c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    125f:	8b 40 04             	mov    0x4(%eax),%eax
    1262:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1269:	8b 45 f8             	mov    -0x8(%ebp),%eax
    126c:	01 c2                	add    %eax,%edx
    126e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1271:	8b 00                	mov    (%eax),%eax
    1273:	39 c2                	cmp    %eax,%edx
    1275:	75 24                	jne    129b <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1277:	8b 45 f8             	mov    -0x8(%ebp),%eax
    127a:	8b 50 04             	mov    0x4(%eax),%edx
    127d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1280:	8b 00                	mov    (%eax),%eax
    1282:	8b 40 04             	mov    0x4(%eax),%eax
    1285:	01 c2                	add    %eax,%edx
    1287:	8b 45 f8             	mov    -0x8(%ebp),%eax
    128a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    128d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1290:	8b 00                	mov    (%eax),%eax
    1292:	8b 10                	mov    (%eax),%edx
    1294:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1297:	89 10                	mov    %edx,(%eax)
    1299:	eb 0a                	jmp    12a5 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    129b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    129e:	8b 10                	mov    (%eax),%edx
    12a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12a3:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    12a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12a8:	8b 40 04             	mov    0x4(%eax),%eax
    12ab:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    12b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12b5:	01 d0                	add    %edx,%eax
    12b7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12ba:	75 20                	jne    12dc <free+0xcf>
    p->s.size += bp->s.size;
    12bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12bf:	8b 50 04             	mov    0x4(%eax),%edx
    12c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12c5:	8b 40 04             	mov    0x4(%eax),%eax
    12c8:	01 c2                	add    %eax,%edx
    12ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12cd:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    12d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12d3:	8b 10                	mov    (%eax),%edx
    12d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12d8:	89 10                	mov    %edx,(%eax)
    12da:	eb 08                	jmp    12e4 <free+0xd7>
  } else
    p->s.ptr = bp;
    12dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12df:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12e2:	89 10                	mov    %edx,(%eax)
  freep = p;
    12e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12e7:	a3 2c 37 00 00       	mov    %eax,0x372c
}
    12ec:	90                   	nop
    12ed:	c9                   	leave  
    12ee:	c3                   	ret    

000012ef <morecore>:

static Header*
morecore(uint nu)
{
    12ef:	55                   	push   %ebp
    12f0:	89 e5                	mov    %esp,%ebp
    12f2:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    12f5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    12fc:	77 07                	ja     1305 <morecore+0x16>
    nu = 4096;
    12fe:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1305:	8b 45 08             	mov    0x8(%ebp),%eax
    1308:	c1 e0 03             	shl    $0x3,%eax
    130b:	83 ec 0c             	sub    $0xc,%esp
    130e:	50                   	push   %eax
    130f:	e8 49 fc ff ff       	call   f5d <sbrk>
    1314:	83 c4 10             	add    $0x10,%esp
    1317:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    131a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    131e:	75 07                	jne    1327 <morecore+0x38>
    return 0;
    1320:	b8 00 00 00 00       	mov    $0x0,%eax
    1325:	eb 26                	jmp    134d <morecore+0x5e>
  hp = (Header*)p;
    1327:	8b 45 f4             	mov    -0xc(%ebp),%eax
    132a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    132d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1330:	8b 55 08             	mov    0x8(%ebp),%edx
    1333:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1336:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1339:	83 c0 08             	add    $0x8,%eax
    133c:	83 ec 0c             	sub    $0xc,%esp
    133f:	50                   	push   %eax
    1340:	e8 c8 fe ff ff       	call   120d <free>
    1345:	83 c4 10             	add    $0x10,%esp
  return freep;
    1348:	a1 2c 37 00 00       	mov    0x372c,%eax
}
    134d:	c9                   	leave  
    134e:	c3                   	ret    

0000134f <malloc>:

void*
malloc(uint nbytes)
{
    134f:	55                   	push   %ebp
    1350:	89 e5                	mov    %esp,%ebp
    1352:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1355:	8b 45 08             	mov    0x8(%ebp),%eax
    1358:	83 c0 07             	add    $0x7,%eax
    135b:	c1 e8 03             	shr    $0x3,%eax
    135e:	83 c0 01             	add    $0x1,%eax
    1361:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1364:	a1 2c 37 00 00       	mov    0x372c,%eax
    1369:	89 45 f0             	mov    %eax,-0x10(%ebp)
    136c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1370:	75 23                	jne    1395 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1372:	c7 45 f0 24 37 00 00 	movl   $0x3724,-0x10(%ebp)
    1379:	8b 45 f0             	mov    -0x10(%ebp),%eax
    137c:	a3 2c 37 00 00       	mov    %eax,0x372c
    1381:	a1 2c 37 00 00       	mov    0x372c,%eax
    1386:	a3 24 37 00 00       	mov    %eax,0x3724
    base.s.size = 0;
    138b:	c7 05 28 37 00 00 00 	movl   $0x0,0x3728
    1392:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1395:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1398:	8b 00                	mov    (%eax),%eax
    139a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    139d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13a0:	8b 40 04             	mov    0x4(%eax),%eax
    13a3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13a6:	72 4d                	jb     13f5 <malloc+0xa6>
      if(p->s.size == nunits)
    13a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13ab:	8b 40 04             	mov    0x4(%eax),%eax
    13ae:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13b1:	75 0c                	jne    13bf <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    13b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13b6:	8b 10                	mov    (%eax),%edx
    13b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13bb:	89 10                	mov    %edx,(%eax)
    13bd:	eb 26                	jmp    13e5 <malloc+0x96>
      else {
        p->s.size -= nunits;
    13bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13c2:	8b 40 04             	mov    0x4(%eax),%eax
    13c5:	2b 45 ec             	sub    -0x14(%ebp),%eax
    13c8:	89 c2                	mov    %eax,%edx
    13ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13cd:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    13d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13d3:	8b 40 04             	mov    0x4(%eax),%eax
    13d6:	c1 e0 03             	shl    $0x3,%eax
    13d9:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    13dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13df:	8b 55 ec             	mov    -0x14(%ebp),%edx
    13e2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    13e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13e8:	a3 2c 37 00 00       	mov    %eax,0x372c
      return (void*)(p + 1);
    13ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f0:	83 c0 08             	add    $0x8,%eax
    13f3:	eb 3b                	jmp    1430 <malloc+0xe1>
    }
    if(p == freep)
    13f5:	a1 2c 37 00 00       	mov    0x372c,%eax
    13fa:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    13fd:	75 1e                	jne    141d <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    13ff:	83 ec 0c             	sub    $0xc,%esp
    1402:	ff 75 ec             	pushl  -0x14(%ebp)
    1405:	e8 e5 fe ff ff       	call   12ef <morecore>
    140a:	83 c4 10             	add    $0x10,%esp
    140d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1410:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1414:	75 07                	jne    141d <malloc+0xce>
        return 0;
    1416:	b8 00 00 00 00       	mov    $0x0,%eax
    141b:	eb 13                	jmp    1430 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    141d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1420:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1423:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1426:	8b 00                	mov    (%eax),%eax
    1428:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    142b:	e9 6d ff ff ff       	jmp    139d <malloc+0x4e>
}
    1430:	c9                   	leave  
    1431:	c3                   	ret    

00001432 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1432:	55                   	push   %ebp
    1433:	89 e5                	mov    %esp,%ebp
    1435:	83 ec 1c             	sub    $0x1c,%esp
    1438:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    143b:	8b 55 10             	mov    0x10(%ebp),%edx
    143e:	8b 45 14             	mov    0x14(%ebp),%eax
    1441:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1444:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1447:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    144a:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    144e:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1451:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1455:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1458:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    145c:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    145f:	8b 45 08             	mov    0x8(%ebp),%eax
    1462:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1466:	66 89 10             	mov    %dx,(%eax)
    1469:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    146d:	88 50 02             	mov    %dl,0x2(%eax)
}
    1470:	8b 45 08             	mov    0x8(%ebp),%eax
    1473:	c9                   	leave  
    1474:	c2 04 00             	ret    $0x4

00001477 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
    1477:	55                   	push   %ebp
    1478:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
    147a:	8b 45 08             	mov    0x8(%ebp),%eax
    147d:	2b 45 10             	sub    0x10(%ebp),%eax
    1480:	89 c2                	mov    %eax,%edx
    1482:	8b 45 08             	mov    0x8(%ebp),%eax
    1485:	2b 45 10             	sub    0x10(%ebp),%eax
    1488:	0f af d0             	imul   %eax,%edx
    148b:	8b 45 0c             	mov    0xc(%ebp),%eax
    148e:	2b 45 14             	sub    0x14(%ebp),%eax
    1491:	89 c1                	mov    %eax,%ecx
    1493:	8b 45 0c             	mov    0xc(%ebp),%eax
    1496:	2b 45 14             	sub    0x14(%ebp),%eax
    1499:	0f af c1             	imul   %ecx,%eax
    149c:	01 d0                	add    %edx,%eax
}
    149e:	5d                   	pop    %ebp
    149f:	c3                   	ret    

000014a0 <abs_int>:

static inline int abs_int(int x)
{
    14a0:	55                   	push   %ebp
    14a1:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
    14a3:	8b 45 08             	mov    0x8(%ebp),%eax
    14a6:	99                   	cltd   
    14a7:	89 d0                	mov    %edx,%eax
    14a9:	33 45 08             	xor    0x8(%ebp),%eax
    14ac:	29 d0                	sub    %edx,%eax
}
    14ae:	5d                   	pop    %ebp
    14af:	c3                   	ret    

000014b0 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
    14b0:	55                   	push   %ebp
    14b1:	89 e5                	mov    %esp,%ebp
    if (x < 0)
    14b3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14b7:	79 07                	jns    14c0 <APGetIndex+0x10>
        return X_SMALLER;
    14b9:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    14be:	eb 40                	jmp    1500 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
    14c0:	8b 45 08             	mov    0x8(%ebp),%eax
    14c3:	8b 00                	mov    (%eax),%eax
    14c5:	3b 45 0c             	cmp    0xc(%ebp),%eax
    14c8:	7f 07                	jg     14d1 <APGetIndex+0x21>
        return X_BIGGER;
    14ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14cf:	eb 2f                	jmp    1500 <APGetIndex+0x50>
    if (y < 0)
    14d1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    14d5:	79 07                	jns    14de <APGetIndex+0x2e>
        return Y_SMALLER;
    14d7:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
    14dc:	eb 22                	jmp    1500 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
    14de:	8b 45 08             	mov    0x8(%ebp),%eax
    14e1:	8b 40 04             	mov    0x4(%eax),%eax
    14e4:	3b 45 10             	cmp    0x10(%ebp),%eax
    14e7:	7f 07                	jg     14f0 <APGetIndex+0x40>
        return Y_BIGGER;
    14e9:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    14ee:	eb 10                	jmp    1500 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
    14f0:	8b 45 08             	mov    0x8(%ebp),%eax
    14f3:	8b 00                	mov    (%eax),%eax
    14f5:	0f af 45 10          	imul   0x10(%ebp),%eax
    14f9:	89 c2                	mov    %eax,%edx
    14fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    14fe:	01 d0                	add    %edx,%eax
}
    1500:	5d                   	pop    %ebp
    1501:	c3                   	ret    

00001502 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
    1502:	55                   	push   %ebp
    1503:	89 e5                	mov    %esp,%ebp
    1505:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    1508:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    150f:	8b 45 cc             	mov    -0x34(%ebp),%eax
    1512:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
    1515:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
    151c:	83 ec 08             	sub    $0x8,%esp
    151f:	6a 00                	push   $0x0
    1521:	ff 75 0c             	pushl  0xc(%ebp)
    1524:	e8 ec f9 ff ff       	call   f15 <open>
    1529:	83 c4 10             	add    $0x10,%esp
    152c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
    152f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1533:	79 2e                	jns    1563 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
    1535:	83 ec 04             	sub    $0x4,%esp
    1538:	ff 75 0c             	pushl  0xc(%ebp)
    153b:	68 b7 2d 00 00       	push   $0x2db7
    1540:	6a 01                	push   $0x1
    1542:	e8 35 fb ff ff       	call   107c <printf>
    1547:	83 c4 10             	add    $0x10,%esp
        return bmp;
    154a:	8b 45 08             	mov    0x8(%ebp),%eax
    154d:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1550:	89 10                	mov    %edx,(%eax)
    1552:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1555:	89 50 04             	mov    %edx,0x4(%eax)
    1558:	8b 55 d0             	mov    -0x30(%ebp),%edx
    155b:	89 50 08             	mov    %edx,0x8(%eax)
    155e:	e9 d2 01 00 00       	jmp    1735 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    1563:	83 ec 04             	sub    $0x4,%esp
    1566:	6a 0e                	push   $0xe
    1568:	8d 45 ba             	lea    -0x46(%ebp),%eax
    156b:	50                   	push   %eax
    156c:	ff 75 ec             	pushl  -0x14(%ebp)
    156f:	e8 79 f9 ff ff       	call   eed <read>
    1574:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    1577:	83 ec 04             	sub    $0x4,%esp
    157a:	6a 28                	push   $0x28
    157c:	8d 45 92             	lea    -0x6e(%ebp),%eax
    157f:	50                   	push   %eax
    1580:	ff 75 ec             	pushl  -0x14(%ebp)
    1583:	e8 65 f9 ff ff       	call   eed <read>
    1588:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
    158b:	8b 45 96             	mov    -0x6a(%ebp),%eax
    158e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
    1591:	8b 45 9a             	mov    -0x66(%ebp),%eax
    1594:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    1597:	8b 55 c8             	mov    -0x38(%ebp),%edx
    159a:	8b 45 cc             	mov    -0x34(%ebp),%eax
    159d:	0f af d0             	imul   %eax,%edx
    15a0:	89 d0                	mov    %edx,%eax
    15a2:	01 c0                	add    %eax,%eax
    15a4:	01 d0                	add    %edx,%eax
    15a6:	83 ec 0c             	sub    $0xc,%esp
    15a9:	50                   	push   %eax
    15aa:	e8 a0 fd ff ff       	call   134f <malloc>
    15af:	83 c4 10             	add    $0x10,%esp
    15b2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
    15b5:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    15b9:	0f b7 c0             	movzwl %ax,%eax
    15bc:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    15bf:	8b 55 c8             	mov    -0x38(%ebp),%edx
    15c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15c5:	0f af c2             	imul   %edx,%eax
    15c8:	83 c0 1f             	add    $0x1f,%eax
    15cb:	c1 e8 05             	shr    $0x5,%eax
    15ce:	c1 e0 02             	shl    $0x2,%eax
    15d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
    15d4:	8b 55 cc             	mov    -0x34(%ebp),%edx
    15d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15da:	0f af c2             	imul   %edx,%eax
    15dd:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    15e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    15e3:	83 ec 0c             	sub    $0xc,%esp
    15e6:	50                   	push   %eax
    15e7:	e8 63 fd ff ff       	call   134f <malloc>
    15ec:	83 c4 10             	add    $0x10,%esp
    15ef:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    15f2:	83 ec 04             	sub    $0x4,%esp
    15f5:	ff 75 e0             	pushl  -0x20(%ebp)
    15f8:	ff 75 dc             	pushl  -0x24(%ebp)
    15fb:	ff 75 ec             	pushl  -0x14(%ebp)
    15fe:	e8 ea f8 ff ff       	call   eed <read>
    1603:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
    1606:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    160a:	66 c1 e8 03          	shr    $0x3,%ax
    160e:	0f b7 c0             	movzwl %ax,%eax
    1611:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
    1614:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    161b:	e9 e5 00 00 00       	jmp    1705 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
    1620:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1623:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1626:	29 c2                	sub    %eax,%edx
    1628:	89 d0                	mov    %edx,%eax
    162a:	8d 50 ff             	lea    -0x1(%eax),%edx
    162d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1630:	0f af c2             	imul   %edx,%eax
    1633:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
    1636:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    163d:	e9 b1 00 00 00       	jmp    16f3 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
    1642:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1645:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1648:	8b 45 f0             	mov    -0x10(%ebp),%eax
    164b:	01 c8                	add    %ecx,%eax
    164d:	89 c1                	mov    %eax,%ecx
    164f:	89 c8                	mov    %ecx,%eax
    1651:	01 c0                	add    %eax,%eax
    1653:	01 c8                	add    %ecx,%eax
    1655:	01 c2                	add    %eax,%edx
    1657:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165a:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    165e:	89 c1                	mov    %eax,%ecx
    1660:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1663:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1667:	01 c1                	add    %eax,%ecx
    1669:	8b 45 d8             	mov    -0x28(%ebp),%eax
    166c:	01 c8                	add    %ecx,%eax
    166e:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1671:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1674:	01 c8                	add    %ecx,%eax
    1676:	0f b6 00             	movzbl (%eax),%eax
    1679:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
    167c:	8b 55 d0             	mov    -0x30(%ebp),%edx
    167f:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1682:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1685:	01 c8                	add    %ecx,%eax
    1687:	89 c1                	mov    %eax,%ecx
    1689:	89 c8                	mov    %ecx,%eax
    168b:	01 c0                	add    %eax,%eax
    168d:	01 c8                	add    %ecx,%eax
    168f:	01 c2                	add    %eax,%edx
    1691:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1694:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1698:	89 c1                	mov    %eax,%ecx
    169a:	8b 45 d8             	mov    -0x28(%ebp),%eax
    169d:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    16a1:	01 c1                	add    %eax,%ecx
    16a3:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16a6:	01 c8                	add    %ecx,%eax
    16a8:	8d 48 fe             	lea    -0x2(%eax),%ecx
    16ab:	8b 45 dc             	mov    -0x24(%ebp),%eax
    16ae:	01 c8                	add    %ecx,%eax
    16b0:	0f b6 00             	movzbl (%eax),%eax
    16b3:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
    16b6:	8b 55 d0             	mov    -0x30(%ebp),%edx
    16b9:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    16bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16bf:	01 c8                	add    %ecx,%eax
    16c1:	89 c1                	mov    %eax,%ecx
    16c3:	89 c8                	mov    %ecx,%eax
    16c5:	01 c0                	add    %eax,%eax
    16c7:	01 c8                	add    %ecx,%eax
    16c9:	01 c2                	add    %eax,%edx
    16cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ce:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    16d2:	89 c1                	mov    %eax,%ecx
    16d4:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16d7:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    16db:	01 c1                	add    %eax,%ecx
    16dd:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16e0:	01 c8                	add    %ecx,%eax
    16e2:	8d 48 fd             	lea    -0x3(%eax),%ecx
    16e5:	8b 45 dc             	mov    -0x24(%ebp),%eax
    16e8:	01 c8                	add    %ecx,%eax
    16ea:	0f b6 00             	movzbl (%eax),%eax
    16ed:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    16ef:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    16f3:	8b 55 c8             	mov    -0x38(%ebp),%edx
    16f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16f9:	39 c2                	cmp    %eax,%edx
    16fb:	0f 87 41 ff ff ff    	ja     1642 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    1701:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1705:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1708:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170b:	39 c2                	cmp    %eax,%edx
    170d:	0f 87 0d ff ff ff    	ja     1620 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    1713:	83 ec 0c             	sub    $0xc,%esp
    1716:	ff 75 ec             	pushl  -0x14(%ebp)
    1719:	e8 df f7 ff ff       	call   efd <close>
    171e:	83 c4 10             	add    $0x10,%esp
    return bmp;
    1721:	8b 45 08             	mov    0x8(%ebp),%eax
    1724:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1727:	89 10                	mov    %edx,(%eax)
    1729:	8b 55 cc             	mov    -0x34(%ebp),%edx
    172c:	89 50 04             	mov    %edx,0x4(%eax)
    172f:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1732:	89 50 08             	mov    %edx,0x8(%eax)
}
    1735:	8b 45 08             	mov    0x8(%ebp),%eax
    1738:	c9                   	leave  
    1739:	c2 04 00             	ret    $0x4

0000173c <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    173c:	55                   	push   %ebp
    173d:	89 e5                	mov    %esp,%ebp
    173f:	53                   	push   %ebx
    1740:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    1743:	83 ec 0c             	sub    $0xc,%esp
    1746:	6a 1c                	push   $0x1c
    1748:	e8 02 fc ff ff       	call   134f <malloc>
    174d:	83 c4 10             	add    $0x10,%esp
    1750:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    1753:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1756:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    175d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    1760:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1763:	6a 0c                	push   $0xc
    1765:	6a 0c                	push   $0xc
    1767:	6a 0c                	push   $0xc
    1769:	50                   	push   %eax
    176a:	e8 c3 fc ff ff       	call   1432 <RGB>
    176f:	83 c4 0c             	add    $0xc,%esp
    1772:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    1776:	66 89 43 13          	mov    %ax,0x13(%ebx)
    177a:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    177e:	88 43 15             	mov    %al,0x15(%ebx)
    1781:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1784:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1787:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    178b:	66 89 48 10          	mov    %cx,0x10(%eax)
    178f:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    1793:	88 50 12             	mov    %dl,0x12(%eax)
    1796:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1799:	8b 55 f4             	mov    -0xc(%ebp),%edx
    179c:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    17a0:	66 89 48 08          	mov    %cx,0x8(%eax)
    17a4:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    17a8:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    17ab:	8b 45 08             	mov    0x8(%ebp),%eax
    17ae:	89 c2                	mov    %eax,%edx
    17b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b3:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    17b5:	8b 45 0c             	mov    0xc(%ebp),%eax
    17b8:	89 c2                	mov    %eax,%edx
    17ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bd:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    17c0:	8b 55 10             	mov    0x10(%ebp),%edx
    17c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c6:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    17c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    17cc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    17cf:	c9                   	leave  
    17d0:	c3                   	ret    

000017d1 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    17d1:	55                   	push   %ebp
    17d2:	89 e5                	mov    %esp,%ebp
    17d4:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    17d7:	8b 45 0c             	mov    0xc(%ebp),%eax
    17da:	8b 50 08             	mov    0x8(%eax),%edx
    17dd:	89 55 f8             	mov    %edx,-0x8(%ebp)
    17e0:	8b 40 0c             	mov    0xc(%eax),%eax
    17e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    17e6:	8b 45 0c             	mov    0xc(%ebp),%eax
    17e9:	8b 55 10             	mov    0x10(%ebp),%edx
    17ec:	89 50 08             	mov    %edx,0x8(%eax)
    17ef:	8b 55 14             	mov    0x14(%ebp),%edx
    17f2:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    17f5:	8b 45 08             	mov    0x8(%ebp),%eax
    17f8:	8b 55 f8             	mov    -0x8(%ebp),%edx
    17fb:	89 10                	mov    %edx,(%eax)
    17fd:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1800:	89 50 04             	mov    %edx,0x4(%eax)
}
    1803:	8b 45 08             	mov    0x8(%ebp),%eax
    1806:	c9                   	leave  
    1807:	c2 04 00             	ret    $0x4

0000180a <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    180a:	55                   	push   %ebp
    180b:	89 e5                	mov    %esp,%ebp
    180d:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    1810:	8b 45 0c             	mov    0xc(%ebp),%eax
    1813:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    1817:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    181b:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    181f:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    1822:	8b 45 0c             	mov    0xc(%ebp),%eax
    1825:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1829:	66 89 50 10          	mov    %dx,0x10(%eax)
    182d:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1831:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    1834:	8b 45 08             	mov    0x8(%ebp),%eax
    1837:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    183b:	66 89 10             	mov    %dx,(%eax)
    183e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1842:	88 50 02             	mov    %dl,0x2(%eax)
}
    1845:	8b 45 08             	mov    0x8(%ebp),%eax
    1848:	c9                   	leave  
    1849:	c2 04 00             	ret    $0x4

0000184c <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    184c:	55                   	push   %ebp
    184d:	89 e5                	mov    %esp,%ebp
    184f:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    1852:	8b 45 08             	mov    0x8(%ebp),%eax
    1855:	8b 40 0c             	mov    0xc(%eax),%eax
    1858:	89 c2                	mov    %eax,%edx
    185a:	c1 ea 1f             	shr    $0x1f,%edx
    185d:	01 d0                	add    %edx,%eax
    185f:	d1 f8                	sar    %eax
    1861:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    1864:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1867:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    186b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    186e:	8b 45 10             	mov    0x10(%ebp),%eax
    1871:	2b 45 f4             	sub    -0xc(%ebp),%eax
    1874:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    1877:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    187b:	0f 89 98 00 00 00    	jns    1919 <APDrawPoint+0xcd>
        i = 0;
    1881:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    1888:	e9 8c 00 00 00       	jmp    1919 <APDrawPoint+0xcd>
    {
        j = x - off;
    188d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1890:	2b 45 f4             	sub    -0xc(%ebp),%eax
    1893:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    1896:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    189a:	79 69                	jns    1905 <APDrawPoint+0xb9>
            j = 0;
    189c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    18a3:	eb 60                	jmp    1905 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    18a5:	ff 75 fc             	pushl  -0x4(%ebp)
    18a8:	ff 75 f8             	pushl  -0x8(%ebp)
    18ab:	ff 75 08             	pushl  0x8(%ebp)
    18ae:	e8 fd fb ff ff       	call   14b0 <APGetIndex>
    18b3:	83 c4 0c             	add    $0xc,%esp
    18b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    18b9:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    18bd:	74 55                	je     1914 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    18bf:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    18c3:	74 67                	je     192c <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    18c5:	ff 75 10             	pushl  0x10(%ebp)
    18c8:	ff 75 0c             	pushl  0xc(%ebp)
    18cb:	ff 75 fc             	pushl  -0x4(%ebp)
    18ce:	ff 75 f8             	pushl  -0x8(%ebp)
    18d1:	e8 a1 fb ff ff       	call   1477 <distance_2>
    18d6:	83 c4 10             	add    $0x10,%esp
    18d9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    18dc:	7f 23                	jg     1901 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    18de:	8b 45 08             	mov    0x8(%ebp),%eax
    18e1:	8b 48 18             	mov    0x18(%eax),%ecx
    18e4:	8b 55 ec             	mov    -0x14(%ebp),%edx
    18e7:	89 d0                	mov    %edx,%eax
    18e9:	01 c0                	add    %eax,%eax
    18eb:	01 d0                	add    %edx,%eax
    18ed:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    18f0:	8b 45 08             	mov    0x8(%ebp),%eax
    18f3:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    18f7:	66 89 0a             	mov    %cx,(%edx)
    18fa:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    18fe:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1901:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1905:	8b 55 0c             	mov    0xc(%ebp),%edx
    1908:	8b 45 f4             	mov    -0xc(%ebp),%eax
    190b:	01 d0                	add    %edx,%eax
    190d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1910:	7d 93                	jge    18a5 <APDrawPoint+0x59>
    1912:	eb 01                	jmp    1915 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1914:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    1915:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1919:	8b 55 10             	mov    0x10(%ebp),%edx
    191c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    191f:	01 d0                	add    %edx,%eax
    1921:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1924:	0f 8d 63 ff ff ff    	jge    188d <APDrawPoint+0x41>
    192a:	eb 01                	jmp    192d <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    192c:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    192d:	c9                   	leave  
    192e:	c3                   	ret    

0000192f <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    192f:	55                   	push   %ebp
    1930:	89 e5                	mov    %esp,%ebp
    1932:	53                   	push   %ebx
    1933:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1936:	8b 45 0c             	mov    0xc(%ebp),%eax
    1939:	3b 45 14             	cmp    0x14(%ebp),%eax
    193c:	0f 85 80 00 00 00    	jne    19c2 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1942:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1946:	0f 88 9d 02 00 00    	js     1be9 <APDrawLine+0x2ba>
    194c:	8b 45 08             	mov    0x8(%ebp),%eax
    194f:	8b 00                	mov    (%eax),%eax
    1951:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1954:	0f 8e 8f 02 00 00    	jle    1be9 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    195a:	8b 45 10             	mov    0x10(%ebp),%eax
    195d:	3b 45 18             	cmp    0x18(%ebp),%eax
    1960:	7e 12                	jle    1974 <APDrawLine+0x45>
        {
            int tmp = y2;
    1962:	8b 45 18             	mov    0x18(%ebp),%eax
    1965:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    1968:	8b 45 10             	mov    0x10(%ebp),%eax
    196b:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    196e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1971:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    1974:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1978:	79 07                	jns    1981 <APDrawLine+0x52>
    197a:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1981:	8b 45 08             	mov    0x8(%ebp),%eax
    1984:	8b 40 04             	mov    0x4(%eax),%eax
    1987:	3b 45 18             	cmp    0x18(%ebp),%eax
    198a:	7d 0c                	jge    1998 <APDrawLine+0x69>
    198c:	8b 45 08             	mov    0x8(%ebp),%eax
    198f:	8b 40 04             	mov    0x4(%eax),%eax
    1992:	83 e8 01             	sub    $0x1,%eax
    1995:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    1998:	8b 45 10             	mov    0x10(%ebp),%eax
    199b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    199e:	eb 15                	jmp    19b5 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    19a0:	ff 75 f4             	pushl  -0xc(%ebp)
    19a3:	ff 75 0c             	pushl  0xc(%ebp)
    19a6:	ff 75 08             	pushl  0x8(%ebp)
    19a9:	e8 9e fe ff ff       	call   184c <APDrawPoint>
    19ae:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    19b1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    19b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19b8:	3b 45 18             	cmp    0x18(%ebp),%eax
    19bb:	7e e3                	jle    19a0 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    19bd:	e9 2b 02 00 00       	jmp    1bed <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    19c2:	8b 45 10             	mov    0x10(%ebp),%eax
    19c5:	3b 45 18             	cmp    0x18(%ebp),%eax
    19c8:	75 7f                	jne    1a49 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    19ca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    19ce:	0f 88 18 02 00 00    	js     1bec <APDrawLine+0x2bd>
    19d4:	8b 45 08             	mov    0x8(%ebp),%eax
    19d7:	8b 40 04             	mov    0x4(%eax),%eax
    19da:	3b 45 10             	cmp    0x10(%ebp),%eax
    19dd:	0f 8e 09 02 00 00    	jle    1bec <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    19e3:	8b 45 0c             	mov    0xc(%ebp),%eax
    19e6:	3b 45 14             	cmp    0x14(%ebp),%eax
    19e9:	7e 12                	jle    19fd <APDrawLine+0xce>
        {
            int tmp = x2;
    19eb:	8b 45 14             	mov    0x14(%ebp),%eax
    19ee:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    19f1:	8b 45 0c             	mov    0xc(%ebp),%eax
    19f4:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    19f7:	8b 45 d8             	mov    -0x28(%ebp),%eax
    19fa:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    19fd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1a01:	79 07                	jns    1a0a <APDrawLine+0xdb>
    1a03:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1a0a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0d:	8b 00                	mov    (%eax),%eax
    1a0f:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a12:	7d 0b                	jge    1a1f <APDrawLine+0xf0>
    1a14:	8b 45 08             	mov    0x8(%ebp),%eax
    1a17:	8b 00                	mov    (%eax),%eax
    1a19:	83 e8 01             	sub    $0x1,%eax
    1a1c:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1a1f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a22:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a25:	eb 15                	jmp    1a3c <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1a27:	ff 75 10             	pushl  0x10(%ebp)
    1a2a:	ff 75 f0             	pushl  -0x10(%ebp)
    1a2d:	ff 75 08             	pushl  0x8(%ebp)
    1a30:	e8 17 fe ff ff       	call   184c <APDrawPoint>
    1a35:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1a38:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1a3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a3f:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a42:	7e e3                	jle    1a27 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1a44:	e9 a4 01 00 00       	jmp    1bed <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1a49:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1a50:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1a57:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a5a:	2b 45 14             	sub    0x14(%ebp),%eax
    1a5d:	50                   	push   %eax
    1a5e:	e8 3d fa ff ff       	call   14a0 <abs_int>
    1a63:	83 c4 04             	add    $0x4,%esp
    1a66:	89 c3                	mov    %eax,%ebx
    1a68:	8b 45 10             	mov    0x10(%ebp),%eax
    1a6b:	2b 45 18             	sub    0x18(%ebp),%eax
    1a6e:	50                   	push   %eax
    1a6f:	e8 2c fa ff ff       	call   14a0 <abs_int>
    1a74:	83 c4 04             	add    $0x4,%esp
    1a77:	39 c3                	cmp    %eax,%ebx
    1a79:	0f 8e b5 00 00 00    	jle    1b34 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1a7f:	8b 45 10             	mov    0x10(%ebp),%eax
    1a82:	2b 45 18             	sub    0x18(%ebp),%eax
    1a85:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1a88:	db 45 b0             	fildl  -0x50(%ebp)
    1a8b:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a8e:	2b 45 14             	sub    0x14(%ebp),%eax
    1a91:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1a94:	db 45 b0             	fildl  -0x50(%ebp)
    1a97:	de f9                	fdivrp %st,%st(1)
    1a99:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1a9c:	8b 45 14             	mov    0x14(%ebp),%eax
    1a9f:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1aa2:	7e 0e                	jle    1ab2 <APDrawLine+0x183>
        {
            s = x1;
    1aa4:	8b 45 0c             	mov    0xc(%ebp),%eax
    1aa7:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    1aaa:	8b 45 14             	mov    0x14(%ebp),%eax
    1aad:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1ab0:	eb 0c                	jmp    1abe <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1ab2:	8b 45 14             	mov    0x14(%ebp),%eax
    1ab5:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1ab8:	8b 45 0c             	mov    0xc(%ebp),%eax
    1abb:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1abe:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ac2:	79 07                	jns    1acb <APDrawLine+0x19c>
    1ac4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1acb:	8b 45 08             	mov    0x8(%ebp),%eax
    1ace:	8b 00                	mov    (%eax),%eax
    1ad0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1ad3:	7f 0b                	jg     1ae0 <APDrawLine+0x1b1>
    1ad5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad8:	8b 00                	mov    (%eax),%eax
    1ada:	83 e8 01             	sub    $0x1,%eax
    1add:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1ae0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ae3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1ae6:	eb 3f                	jmp    1b27 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1ae8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1aeb:	2b 45 0c             	sub    0xc(%ebp),%eax
    1aee:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1af1:	db 45 b0             	fildl  -0x50(%ebp)
    1af4:	dc 4d d0             	fmull  -0x30(%ebp)
    1af7:	db 45 10             	fildl  0x10(%ebp)
    1afa:	de c1                	faddp  %st,%st(1)
    1afc:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1aff:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1b03:	b4 0c                	mov    $0xc,%ah
    1b05:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1b09:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1b0c:	db 5d cc             	fistpl -0x34(%ebp)
    1b0f:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1b12:	ff 75 cc             	pushl  -0x34(%ebp)
    1b15:	ff 75 e4             	pushl  -0x1c(%ebp)
    1b18:	ff 75 08             	pushl  0x8(%ebp)
    1b1b:	e8 2c fd ff ff       	call   184c <APDrawPoint>
    1b20:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1b23:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1b27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b2a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1b2d:	7e b9                	jle    1ae8 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1b2f:	e9 b9 00 00 00       	jmp    1bed <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1b34:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b37:	2b 45 14             	sub    0x14(%ebp),%eax
    1b3a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1b3d:	db 45 b0             	fildl  -0x50(%ebp)
    1b40:	8b 45 10             	mov    0x10(%ebp),%eax
    1b43:	2b 45 18             	sub    0x18(%ebp),%eax
    1b46:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1b49:	db 45 b0             	fildl  -0x50(%ebp)
    1b4c:	de f9                	fdivrp %st,%st(1)
    1b4e:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1b51:	8b 45 10             	mov    0x10(%ebp),%eax
    1b54:	3b 45 18             	cmp    0x18(%ebp),%eax
    1b57:	7e 0e                	jle    1b67 <APDrawLine+0x238>
    {
        s = y2;
    1b59:	8b 45 18             	mov    0x18(%ebp),%eax
    1b5c:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1b5f:	8b 45 10             	mov    0x10(%ebp),%eax
    1b62:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1b65:	eb 0c                	jmp    1b73 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1b67:	8b 45 10             	mov    0x10(%ebp),%eax
    1b6a:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1b6d:	8b 45 18             	mov    0x18(%ebp),%eax
    1b70:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1b73:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b77:	79 07                	jns    1b80 <APDrawLine+0x251>
    1b79:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1b80:	8b 45 08             	mov    0x8(%ebp),%eax
    1b83:	8b 40 04             	mov    0x4(%eax),%eax
    1b86:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1b89:	7f 0c                	jg     1b97 <APDrawLine+0x268>
    1b8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b8e:	8b 40 04             	mov    0x4(%eax),%eax
    1b91:	83 e8 01             	sub    $0x1,%eax
    1b94:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1b97:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b9a:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1b9d:	eb 3f                	jmp    1bde <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1b9f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ba2:	2b 45 10             	sub    0x10(%ebp),%eax
    1ba5:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1ba8:	db 45 b0             	fildl  -0x50(%ebp)
    1bab:	dc 4d c0             	fmull  -0x40(%ebp)
    1bae:	db 45 0c             	fildl  0xc(%ebp)
    1bb1:	de c1                	faddp  %st,%st(1)
    1bb3:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1bb6:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1bba:	b4 0c                	mov    $0xc,%ah
    1bbc:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1bc0:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1bc3:	db 5d bc             	fistpl -0x44(%ebp)
    1bc6:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1bc9:	ff 75 e0             	pushl  -0x20(%ebp)
    1bcc:	ff 75 bc             	pushl  -0x44(%ebp)
    1bcf:	ff 75 08             	pushl  0x8(%ebp)
    1bd2:	e8 75 fc ff ff       	call   184c <APDrawPoint>
    1bd7:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1bda:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1bde:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1be1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1be4:	7e b9                	jle    1b9f <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1be6:	90                   	nop
    1be7:	eb 04                	jmp    1bed <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1be9:	90                   	nop
    1bea:	eb 01                	jmp    1bed <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1bec:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1bed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1bf0:	c9                   	leave  
    1bf1:	c3                   	ret    

00001bf2 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1bf2:	55                   	push   %ebp
    1bf3:	89 e5                	mov    %esp,%ebp
    1bf5:	53                   	push   %ebx
    1bf6:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1bf9:	8b 55 10             	mov    0x10(%ebp),%edx
    1bfc:	8b 45 18             	mov    0x18(%ebp),%eax
    1bff:	01 d0                	add    %edx,%eax
    1c01:	83 e8 01             	sub    $0x1,%eax
    1c04:	83 ec 04             	sub    $0x4,%esp
    1c07:	50                   	push   %eax
    1c08:	ff 75 0c             	pushl  0xc(%ebp)
    1c0b:	ff 75 10             	pushl  0x10(%ebp)
    1c0e:	ff 75 0c             	pushl  0xc(%ebp)
    1c11:	ff 75 08             	pushl  0x8(%ebp)
    1c14:	e8 16 fd ff ff       	call   192f <APDrawLine>
    1c19:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1c1c:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c1f:	8b 45 14             	mov    0x14(%ebp),%eax
    1c22:	01 d0                	add    %edx,%eax
    1c24:	83 e8 01             	sub    $0x1,%eax
    1c27:	83 ec 04             	sub    $0x4,%esp
    1c2a:	ff 75 10             	pushl  0x10(%ebp)
    1c2d:	50                   	push   %eax
    1c2e:	ff 75 10             	pushl  0x10(%ebp)
    1c31:	ff 75 0c             	pushl  0xc(%ebp)
    1c34:	ff 75 08             	pushl  0x8(%ebp)
    1c37:	e8 f3 fc ff ff       	call   192f <APDrawLine>
    1c3c:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1c3f:	8b 55 10             	mov    0x10(%ebp),%edx
    1c42:	8b 45 18             	mov    0x18(%ebp),%eax
    1c45:	01 d0                	add    %edx,%eax
    1c47:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1c4a:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c4d:	8b 45 14             	mov    0x14(%ebp),%eax
    1c50:	01 d0                	add    %edx,%eax
    1c52:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c55:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1c58:	8b 45 14             	mov    0x14(%ebp),%eax
    1c5b:	01 d8                	add    %ebx,%eax
    1c5d:	83 e8 01             	sub    $0x1,%eax
    1c60:	83 ec 04             	sub    $0x4,%esp
    1c63:	51                   	push   %ecx
    1c64:	52                   	push   %edx
    1c65:	ff 75 10             	pushl  0x10(%ebp)
    1c68:	50                   	push   %eax
    1c69:	ff 75 08             	pushl  0x8(%ebp)
    1c6c:	e8 be fc ff ff       	call   192f <APDrawLine>
    1c71:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1c74:	8b 55 10             	mov    0x10(%ebp),%edx
    1c77:	8b 45 18             	mov    0x18(%ebp),%eax
    1c7a:	01 d0                	add    %edx,%eax
    1c7c:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1c7f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c82:	8b 45 14             	mov    0x14(%ebp),%eax
    1c85:	01 d0                	add    %edx,%eax
    1c87:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c8a:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1c8d:	8b 45 18             	mov    0x18(%ebp),%eax
    1c90:	01 d8                	add    %ebx,%eax
    1c92:	83 e8 01             	sub    $0x1,%eax
    1c95:	83 ec 04             	sub    $0x4,%esp
    1c98:	51                   	push   %ecx
    1c99:	52                   	push   %edx
    1c9a:	50                   	push   %eax
    1c9b:	ff 75 0c             	pushl  0xc(%ebp)
    1c9e:	ff 75 08             	pushl  0x8(%ebp)
    1ca1:	e8 89 fc ff ff       	call   192f <APDrawLine>
    1ca6:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1ca9:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cac:	8b 45 14             	mov    0x14(%ebp),%eax
    1caf:	01 d0                	add    %edx,%eax
    1cb1:	8d 50 ff             	lea    -0x1(%eax),%edx
    1cb4:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb7:	8b 40 0c             	mov    0xc(%eax),%eax
    1cba:	89 c1                	mov    %eax,%ecx
    1cbc:	c1 e9 1f             	shr    $0x1f,%ecx
    1cbf:	01 c8                	add    %ecx,%eax
    1cc1:	d1 f8                	sar    %eax
    1cc3:	29 c2                	sub    %eax,%edx
    1cc5:	89 d0                	mov    %edx,%eax
    1cc7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1cca:	8b 55 10             	mov    0x10(%ebp),%edx
    1ccd:	8b 45 18             	mov    0x18(%ebp),%eax
    1cd0:	01 d0                	add    %edx,%eax
    1cd2:	8d 50 ff             	lea    -0x1(%eax),%edx
    1cd5:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd8:	8b 40 0c             	mov    0xc(%eax),%eax
    1cdb:	89 c1                	mov    %eax,%ecx
    1cdd:	c1 e9 1f             	shr    $0x1f,%ecx
    1ce0:	01 c8                	add    %ecx,%eax
    1ce2:	d1 f8                	sar    %eax
    1ce4:	29 c2                	sub    %eax,%edx
    1ce6:	89 d0                	mov    %edx,%eax
    1ce8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1ceb:	8b 45 08             	mov    0x8(%ebp),%eax
    1cee:	8b 40 0c             	mov    0xc(%eax),%eax
    1cf1:	89 c2                	mov    %eax,%edx
    1cf3:	c1 ea 1f             	shr    $0x1f,%edx
    1cf6:	01 d0                	add    %edx,%eax
    1cf8:	d1 f8                	sar    %eax
    1cfa:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1cfd:	8b 45 08             	mov    0x8(%ebp),%eax
    1d00:	8b 40 0c             	mov    0xc(%eax),%eax
    1d03:	89 c2                	mov    %eax,%edx
    1d05:	c1 ea 1f             	shr    $0x1f,%edx
    1d08:	01 d0                	add    %edx,%eax
    1d0a:	d1 f8                	sar    %eax
    1d0c:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1d0f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d13:	0f 88 d8 00 00 00    	js     1df1 <APDrawRect+0x1ff>
    1d19:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d1d:	0f 88 ce 00 00 00    	js     1df1 <APDrawRect+0x1ff>
    1d23:	8b 45 08             	mov    0x8(%ebp),%eax
    1d26:	8b 00                	mov    (%eax),%eax
    1d28:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1d2b:	0f 8e c0 00 00 00    	jle    1df1 <APDrawRect+0x1ff>
    1d31:	8b 45 08             	mov    0x8(%ebp),%eax
    1d34:	8b 40 04             	mov    0x4(%eax),%eax
    1d37:	3b 45 10             	cmp    0x10(%ebp),%eax
    1d3a:	0f 8e b1 00 00 00    	jle    1df1 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1d40:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1d44:	79 07                	jns    1d4d <APDrawRect+0x15b>
    1d46:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1d4d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1d51:	79 07                	jns    1d5a <APDrawRect+0x168>
    1d53:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1d5a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d5d:	8b 00                	mov    (%eax),%eax
    1d5f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1d62:	7f 0b                	jg     1d6f <APDrawRect+0x17d>
    1d64:	8b 45 08             	mov    0x8(%ebp),%eax
    1d67:	8b 00                	mov    (%eax),%eax
    1d69:	83 e8 01             	sub    $0x1,%eax
    1d6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1d6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d72:	8b 40 04             	mov    0x4(%eax),%eax
    1d75:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1d78:	7f 0c                	jg     1d86 <APDrawRect+0x194>
    1d7a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7d:	8b 40 04             	mov    0x4(%eax),%eax
    1d80:	83 e8 01             	sub    $0x1,%eax
    1d83:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1d86:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1d8d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d90:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1d93:	eb 52                	jmp    1de7 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1d95:	8b 45 10             	mov    0x10(%ebp),%eax
    1d98:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1d9b:	eb 3e                	jmp    1ddb <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1d9d:	83 ec 04             	sub    $0x4,%esp
    1da0:	ff 75 e8             	pushl  -0x18(%ebp)
    1da3:	ff 75 ec             	pushl  -0x14(%ebp)
    1da6:	ff 75 08             	pushl  0x8(%ebp)
    1da9:	e8 02 f7 ff ff       	call   14b0 <APGetIndex>
    1dae:	83 c4 10             	add    $0x10,%esp
    1db1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1db4:	8b 45 08             	mov    0x8(%ebp),%eax
    1db7:	8b 48 18             	mov    0x18(%eax),%ecx
    1dba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1dbd:	89 d0                	mov    %edx,%eax
    1dbf:	01 c0                	add    %eax,%eax
    1dc1:	01 d0                	add    %edx,%eax
    1dc3:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1dc6:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc9:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1dcd:	66 89 0a             	mov    %cx,(%edx)
    1dd0:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1dd4:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1dd7:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1ddb:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1dde:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1de1:	7e ba                	jle    1d9d <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1de3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1de7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1dea:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1ded:	7e a6                	jle    1d95 <APDrawRect+0x1a3>
    1def:	eb 01                	jmp    1df2 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1df1:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1df2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1df5:	c9                   	leave  
    1df6:	c3                   	ret    

00001df7 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1df7:	55                   	push   %ebp
    1df8:	89 e5                	mov    %esp,%ebp
    1dfa:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1dfd:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1e01:	0f 88 8e 01 00 00    	js     1f95 <APDcCopy+0x19e>
    1e07:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1e0b:	0f 88 84 01 00 00    	js     1f95 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1e11:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e14:	8b 45 20             	mov    0x20(%ebp),%eax
    1e17:	01 d0                	add    %edx,%eax
    1e19:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1e1c:	8b 55 10             	mov    0x10(%ebp),%edx
    1e1f:	8b 45 24             	mov    0x24(%ebp),%eax
    1e22:	01 d0                	add    %edx,%eax
    1e24:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1e27:	8b 55 18             	mov    0x18(%ebp),%edx
    1e2a:	8b 45 20             	mov    0x20(%ebp),%eax
    1e2d:	01 d0                	add    %edx,%eax
    1e2f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1e32:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1e35:	8b 45 24             	mov    0x24(%ebp),%eax
    1e38:	01 d0                	add    %edx,%eax
    1e3a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1e3d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1e41:	0f 88 51 01 00 00    	js     1f98 <APDcCopy+0x1a1>
    1e47:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e4b:	0f 88 47 01 00 00    	js     1f98 <APDcCopy+0x1a1>
    1e51:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1e55:	0f 88 3d 01 00 00    	js     1f98 <APDcCopy+0x1a1>
    1e5b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1e5f:	0f 88 33 01 00 00    	js     1f98 <APDcCopy+0x1a1>
    1e65:	8b 45 14             	mov    0x14(%ebp),%eax
    1e68:	8b 00                	mov    (%eax),%eax
    1e6a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1e6d:	0f 8c 25 01 00 00    	jl     1f98 <APDcCopy+0x1a1>
    1e73:	8b 45 14             	mov    0x14(%ebp),%eax
    1e76:	8b 40 04             	mov    0x4(%eax),%eax
    1e79:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1e7c:	0f 8c 16 01 00 00    	jl     1f98 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1e82:	8b 45 08             	mov    0x8(%ebp),%eax
    1e85:	8b 00                	mov    (%eax),%eax
    1e87:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1e8a:	7f 0b                	jg     1e97 <APDcCopy+0xa0>
    1e8c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e8f:	8b 00                	mov    (%eax),%eax
    1e91:	83 e8 01             	sub    $0x1,%eax
    1e94:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1e97:	8b 45 08             	mov    0x8(%ebp),%eax
    1e9a:	8b 40 04             	mov    0x4(%eax),%eax
    1e9d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1ea0:	7f 0c                	jg     1eae <APDcCopy+0xb7>
    1ea2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea5:	8b 40 04             	mov    0x4(%eax),%eax
    1ea8:	83 e8 01             	sub    $0x1,%eax
    1eab:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1eae:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1eb5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1ebc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1ec3:	e9 bc 00 00 00       	jmp    1f84 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1ec8:	8b 45 08             	mov    0x8(%ebp),%eax
    1ecb:	8b 00                	mov    (%eax),%eax
    1ecd:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1ed0:	8b 55 10             	mov    0x10(%ebp),%edx
    1ed3:	01 ca                	add    %ecx,%edx
    1ed5:	0f af d0             	imul   %eax,%edx
    1ed8:	8b 45 0c             	mov    0xc(%ebp),%eax
    1edb:	01 d0                	add    %edx,%eax
    1edd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1ee0:	8b 45 14             	mov    0x14(%ebp),%eax
    1ee3:	8b 00                	mov    (%eax),%eax
    1ee5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1ee8:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1eeb:	01 ca                	add    %ecx,%edx
    1eed:	0f af d0             	imul   %eax,%edx
    1ef0:	8b 45 18             	mov    0x18(%ebp),%eax
    1ef3:	01 d0                	add    %edx,%eax
    1ef5:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1ef8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1eff:	eb 74                	jmp    1f75 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1f01:	8b 45 14             	mov    0x14(%ebp),%eax
    1f04:	8b 50 18             	mov    0x18(%eax),%edx
    1f07:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1f0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f0d:	01 c8                	add    %ecx,%eax
    1f0f:	89 c1                	mov    %eax,%ecx
    1f11:	89 c8                	mov    %ecx,%eax
    1f13:	01 c0                	add    %eax,%eax
    1f15:	01 c8                	add    %ecx,%eax
    1f17:	01 d0                	add    %edx,%eax
    1f19:	0f b7 10             	movzwl (%eax),%edx
    1f1c:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1f20:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1f24:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1f27:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1f2b:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1f2f:	38 c2                	cmp    %al,%dl
    1f31:	75 18                	jne    1f4b <APDcCopy+0x154>
    1f33:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1f37:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1f3b:	38 c2                	cmp    %al,%dl
    1f3d:	75 0c                	jne    1f4b <APDcCopy+0x154>
    1f3f:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1f43:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1f47:	38 c2                	cmp    %al,%dl
    1f49:	74 26                	je     1f71 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1f4b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f4e:	8b 50 18             	mov    0x18(%eax),%edx
    1f51:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1f54:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f57:	01 c8                	add    %ecx,%eax
    1f59:	89 c1                	mov    %eax,%ecx
    1f5b:	89 c8                	mov    %ecx,%eax
    1f5d:	01 c0                	add    %eax,%eax
    1f5f:	01 c8                	add    %ecx,%eax
    1f61:	01 d0                	add    %edx,%eax
    1f63:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1f67:	66 89 10             	mov    %dx,(%eax)
    1f6a:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1f6e:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1f71:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1f75:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1f78:	2b 45 0c             	sub    0xc(%ebp),%eax
    1f7b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1f7e:	7d 81                	jge    1f01 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1f80:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1f84:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f87:	2b 45 10             	sub    0x10(%ebp),%eax
    1f8a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1f8d:	0f 8d 35 ff ff ff    	jge    1ec8 <APDcCopy+0xd1>
    1f93:	eb 04                	jmp    1f99 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1f95:	90                   	nop
    1f96:	eb 01                	jmp    1f99 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1f98:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1f99:	c9                   	leave  
    1f9a:	c3                   	ret    

00001f9b <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1f9b:	55                   	push   %ebp
    1f9c:	89 e5                	mov    %esp,%ebp
    1f9e:	83 ec 1c             	sub    $0x1c,%esp
    1fa1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1fa4:	8b 55 10             	mov    0x10(%ebp),%edx
    1fa7:	8b 45 14             	mov    0x14(%ebp),%eax
    1faa:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1fad:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1fb0:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1fb3:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1fb7:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1fba:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1fbe:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1fc1:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1fc5:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1fc8:	8b 45 08             	mov    0x8(%ebp),%eax
    1fcb:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1fcf:	66 89 10             	mov    %dx,(%eax)
    1fd2:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1fd6:	88 50 02             	mov    %dl,0x2(%eax)
}
    1fd9:	8b 45 08             	mov    0x8(%ebp),%eax
    1fdc:	c9                   	leave  
    1fdd:	c2 04 00             	ret    $0x4

00001fe0 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1fe0:	55                   	push   %ebp
    1fe1:	89 e5                	mov    %esp,%ebp
    1fe3:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1fe6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe9:	8b 00                	mov    (%eax),%eax
    1feb:	83 ec 08             	sub    $0x8,%esp
    1fee:	8d 55 0c             	lea    0xc(%ebp),%edx
    1ff1:	52                   	push   %edx
    1ff2:	50                   	push   %eax
    1ff3:	e8 8d ef ff ff       	call   f85 <sendMessage>
    1ff8:	83 c4 10             	add    $0x10,%esp
}
    1ffb:	90                   	nop
    1ffc:	c9                   	leave  
    1ffd:	c3                   	ret    

00001ffe <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1ffe:	55                   	push   %ebp
    1fff:	89 e5                	mov    %esp,%ebp
    2001:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    2004:	83 ec 0c             	sub    $0xc,%esp
    2007:	68 90 00 00 00       	push   $0x90
    200c:	e8 3e f3 ff ff       	call   134f <malloc>
    2011:	83 c4 10             	add    $0x10,%esp
    2014:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    2017:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    201b:	75 15                	jne    2032 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    201d:	83 ec 04             	sub    $0x4,%esp
    2020:	ff 75 08             	pushl  0x8(%ebp)
    2023:	68 c8 2d 00 00       	push   $0x2dc8
    2028:	6a 01                	push   $0x1
    202a:	e8 4d f0 ff ff       	call   107c <printf>
    202f:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    2032:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2035:	83 c0 7c             	add    $0x7c,%eax
    2038:	83 ec 08             	sub    $0x8,%esp
    203b:	ff 75 08             	pushl  0x8(%ebp)
    203e:	50                   	push   %eax
    203f:	e8 60 ec ff ff       	call   ca4 <strcpy>
    2044:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    2047:	8b 45 f4             	mov    -0xc(%ebp),%eax
    204a:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    2051:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2054:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    205b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    205e:	8b 40 34             	mov    0x34(%eax),%eax
    2061:	89 c2                	mov    %eax,%edx
    2063:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2066:	8b 40 38             	mov    0x38(%eax),%eax
    2069:	0f af d0             	imul   %eax,%edx
    206c:	89 d0                	mov    %edx,%eax
    206e:	01 c0                	add    %eax,%eax
    2070:	01 d0                	add    %edx,%eax
    2072:	83 ec 0c             	sub    $0xc,%esp
    2075:	50                   	push   %eax
    2076:	e8 d4 f2 ff ff       	call   134f <malloc>
    207b:	83 c4 10             	add    $0x10,%esp
    207e:	89 c2                	mov    %eax,%edx
    2080:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2083:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    2086:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2089:	8b 40 4c             	mov    0x4c(%eax),%eax
    208c:	85 c0                	test   %eax,%eax
    208e:	75 15                	jne    20a5 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    2090:	83 ec 04             	sub    $0x4,%esp
    2093:	ff 75 08             	pushl  0x8(%ebp)
    2096:	68 e8 2d 00 00       	push   $0x2de8
    209b:	6a 01                	push   $0x1
    209d:	e8 da ef ff ff       	call   107c <printf>
    20a2:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    20a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20a8:	8b 40 34             	mov    0x34(%eax),%eax
    20ab:	89 c2                	mov    %eax,%edx
    20ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20b0:	8b 40 38             	mov    0x38(%eax),%eax
    20b3:	0f af d0             	imul   %eax,%edx
    20b6:	89 d0                	mov    %edx,%eax
    20b8:	01 c0                	add    %eax,%eax
    20ba:	01 c2                	add    %eax,%edx
    20bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20bf:	8b 40 4c             	mov    0x4c(%eax),%eax
    20c2:	83 ec 04             	sub    $0x4,%esp
    20c5:	52                   	push   %edx
    20c6:	68 ff ff ff 00       	push   $0xffffff
    20cb:	50                   	push   %eax
    20cc:	e8 69 ec ff ff       	call   d3a <memset>
    20d1:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    20d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20d7:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    20de:	e8 72 ee ff ff       	call   f55 <getpid>
    20e3:	89 c2                	mov    %eax,%edx
    20e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20e8:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    20eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20ee:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    20f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20f8:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    20ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2102:	8b 40 50             	mov    0x50(%eax),%eax
    2105:	89 c2                	mov    %eax,%edx
    2107:	8b 45 f4             	mov    -0xc(%ebp),%eax
    210a:	8b 40 54             	mov    0x54(%eax),%eax
    210d:	0f af d0             	imul   %eax,%edx
    2110:	89 d0                	mov    %edx,%eax
    2112:	01 c0                	add    %eax,%eax
    2114:	01 d0                	add    %edx,%eax
    2116:	83 ec 0c             	sub    $0xc,%esp
    2119:	50                   	push   %eax
    211a:	e8 30 f2 ff ff       	call   134f <malloc>
    211f:	83 c4 10             	add    $0x10,%esp
    2122:	89 c2                	mov    %eax,%edx
    2124:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2127:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    212a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    212d:	8b 40 68             	mov    0x68(%eax),%eax
    2130:	85 c0                	test   %eax,%eax
    2132:	75 15                	jne    2149 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    2134:	83 ec 04             	sub    $0x4,%esp
    2137:	ff 75 08             	pushl  0x8(%ebp)
    213a:	68 0c 2e 00 00       	push   $0x2e0c
    213f:	6a 01                	push   $0x1
    2141:	e8 36 ef ff ff       	call   107c <printf>
    2146:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    2149:	8b 45 f4             	mov    -0xc(%ebp),%eax
    214c:	8b 40 34             	mov    0x34(%eax),%eax
    214f:	89 c2                	mov    %eax,%edx
    2151:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2154:	8b 40 38             	mov    0x38(%eax),%eax
    2157:	0f af d0             	imul   %eax,%edx
    215a:	89 d0                	mov    %edx,%eax
    215c:	01 c0                	add    %eax,%eax
    215e:	01 c2                	add    %eax,%edx
    2160:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2163:	8b 40 4c             	mov    0x4c(%eax),%eax
    2166:	83 ec 04             	sub    $0x4,%esp
    2169:	52                   	push   %edx
    216a:	68 ff 00 00 00       	push   $0xff
    216f:	50                   	push   %eax
    2170:	e8 c5 eb ff ff       	call   d3a <memset>
    2175:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    2178:	8b 45 f4             	mov    -0xc(%ebp),%eax
    217b:	8b 55 0c             	mov    0xc(%ebp),%edx
    217e:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    2181:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    2185:	74 35                	je     21bc <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    2187:	8b 45 10             	mov    0x10(%ebp),%eax
    218a:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    2190:	83 ec 0c             	sub    $0xc,%esp
    2193:	50                   	push   %eax
    2194:	e8 b6 f1 ff ff       	call   134f <malloc>
    2199:	83 c4 10             	add    $0x10,%esp
    219c:	89 c2                	mov    %eax,%edx
    219e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21a1:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    21a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21a7:	8b 55 10             	mov    0x10(%ebp),%edx
    21aa:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    21ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21b0:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    21b7:	e9 8d 00 00 00       	jmp    2249 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    21bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21bf:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    21c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21c9:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    21d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21d3:	8b 40 18             	mov    0x18(%eax),%eax
    21d6:	89 c2                	mov    %eax,%edx
    21d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21db:	8b 40 1c             	mov    0x1c(%eax),%eax
    21de:	0f af d0             	imul   %eax,%edx
    21e1:	89 d0                	mov    %edx,%eax
    21e3:	01 c0                	add    %eax,%eax
    21e5:	01 d0                	add    %edx,%eax
    21e7:	83 ec 0c             	sub    $0xc,%esp
    21ea:	50                   	push   %eax
    21eb:	e8 5f f1 ff ff       	call   134f <malloc>
    21f0:	83 c4 10             	add    $0x10,%esp
    21f3:	89 c2                	mov    %eax,%edx
    21f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21f8:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    21fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21fe:	8b 40 30             	mov    0x30(%eax),%eax
    2201:	85 c0                	test   %eax,%eax
    2203:	75 15                	jne    221a <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    2205:	83 ec 04             	sub    $0x4,%esp
    2208:	ff 75 08             	pushl  0x8(%ebp)
    220b:	68 34 2e 00 00       	push   $0x2e34
    2210:	6a 01                	push   $0x1
    2212:	e8 65 ee ff ff       	call   107c <printf>
    2217:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    221a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    221d:	8b 40 18             	mov    0x18(%eax),%eax
    2220:	89 c2                	mov    %eax,%edx
    2222:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2225:	8b 40 1c             	mov    0x1c(%eax),%eax
    2228:	0f af d0             	imul   %eax,%edx
    222b:	89 d0                	mov    %edx,%eax
    222d:	01 c0                	add    %eax,%eax
    222f:	01 c2                	add    %eax,%edx
    2231:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2234:	8b 40 30             	mov    0x30(%eax),%eax
    2237:	83 ec 04             	sub    $0x4,%esp
    223a:	52                   	push   %edx
    223b:	68 ff ff ff 00       	push   $0xffffff
    2240:	50                   	push   %eax
    2241:	e8 f4 ea ff ff       	call   d3a <memset>
    2246:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    2249:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    224c:	c9                   	leave  
    224d:	c3                   	ret    

0000224e <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    224e:	55                   	push   %ebp
    224f:	89 e5                	mov    %esp,%ebp
    2251:	53                   	push   %ebx
    2252:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    2255:	8b 45 0c             	mov    0xc(%ebp),%eax
    2258:	83 f8 03             	cmp    $0x3,%eax
    225b:	74 02                	je     225f <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    225d:	eb 33                	jmp    2292 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    225f:	8b 45 08             	mov    0x8(%ebp),%eax
    2262:	8b 48 08             	mov    0x8(%eax),%ecx
    2265:	8b 45 08             	mov    0x8(%ebp),%eax
    2268:	8b 50 38             	mov    0x38(%eax),%edx
    226b:	8b 45 08             	mov    0x8(%ebp),%eax
    226e:	8b 40 34             	mov    0x34(%eax),%eax
    2271:	8b 5d 08             	mov    0x8(%ebp),%ebx
    2274:	83 c3 34             	add    $0x34,%ebx
    2277:	83 ec 0c             	sub    $0xc,%esp
    227a:	51                   	push   %ecx
    227b:	52                   	push   %edx
    227c:	50                   	push   %eax
    227d:	6a 00                	push   $0x0
    227f:	6a 00                	push   $0x0
    2281:	53                   	push   %ebx
    2282:	6a 32                	push   $0x32
    2284:	6a 00                	push   $0x0
    2286:	ff 75 08             	pushl  0x8(%ebp)
    2289:	e8 e7 ec ff ff       	call   f75 <paintWindow>
    228e:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    2291:	90                   	nop
        default: break;
            
            
    }
    return False;
    2292:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2297:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    229a:	c9                   	leave  
    229b:	c3                   	ret    

0000229c <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    229c:	55                   	push   %ebp
    229d:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    229f:	8b 45 0c             	mov    0xc(%ebp),%eax
    22a2:	8b 50 08             	mov    0x8(%eax),%edx
    22a5:	8b 45 08             	mov    0x8(%ebp),%eax
    22a8:	8b 00                	mov    (%eax),%eax
    22aa:	39 c2                	cmp    %eax,%edx
    22ac:	74 07                	je     22b5 <APPreJudge+0x19>
        return False;
    22ae:	b8 00 00 00 00       	mov    $0x0,%eax
    22b3:	eb 05                	jmp    22ba <APPreJudge+0x1e>
    return True;
    22b5:	b8 01 00 00 00       	mov    $0x1,%eax
}
    22ba:	5d                   	pop    %ebp
    22bb:	c3                   	ret    

000022bc <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    22bc:	55                   	push   %ebp
    22bd:	89 e5                	mov    %esp,%ebp
    22bf:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    22c2:	8b 45 08             	mov    0x8(%ebp),%eax
    22c5:	8b 55 0c             	mov    0xc(%ebp),%edx
    22c8:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    22cb:	83 ec 0c             	sub    $0xc,%esp
    22ce:	ff 75 08             	pushl  0x8(%ebp)
    22d1:	e8 bf ec ff ff       	call   f95 <registWindow>
    22d6:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    22d9:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    22e0:	8b 45 08             	mov    0x8(%ebp),%eax
    22e3:	8b 00                	mov    (%eax),%eax
    22e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    22e8:	ff 75 f4             	pushl  -0xc(%ebp)
    22eb:	ff 75 f0             	pushl  -0x10(%ebp)
    22ee:	ff 75 ec             	pushl  -0x14(%ebp)
    22f1:	ff 75 08             	pushl  0x8(%ebp)
    22f4:	e8 e7 fc ff ff       	call   1fe0 <APSendMessage>
    22f9:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    22fc:	83 ec 0c             	sub    $0xc,%esp
    22ff:	ff 75 08             	pushl  0x8(%ebp)
    2302:	e8 86 ec ff ff       	call   f8d <getMessage>
    2307:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    230a:	8b 45 08             	mov    0x8(%ebp),%eax
    230d:	83 c0 6c             	add    $0x6c,%eax
    2310:	83 ec 08             	sub    $0x8,%esp
    2313:	50                   	push   %eax
    2314:	ff 75 08             	pushl  0x8(%ebp)
    2317:	e8 80 ff ff ff       	call   229c <APPreJudge>
    231c:	83 c4 10             	add    $0x10,%esp
    231f:	84 c0                	test   %al,%al
    2321:	74 1b                	je     233e <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    2323:	8b 45 08             	mov    0x8(%ebp),%eax
    2326:	ff 70 74             	pushl  0x74(%eax)
    2329:	ff 70 70             	pushl  0x70(%eax)
    232c:	ff 70 6c             	pushl  0x6c(%eax)
    232f:	ff 75 08             	pushl  0x8(%ebp)
    2332:	8b 45 0c             	mov    0xc(%ebp),%eax
    2335:	ff d0                	call   *%eax
    2337:	83 c4 10             	add    $0x10,%esp
    233a:	84 c0                	test   %al,%al
    233c:	75 0c                	jne    234a <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    233e:	8b 45 08             	mov    0x8(%ebp),%eax
    2341:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    2348:	eb b2                	jmp    22fc <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    234a:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    234b:	90                   	nop
    234c:	c9                   	leave  
    234d:	c3                   	ret    

0000234e <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    234e:	55                   	push   %ebp
    234f:	89 e5                	mov    %esp,%ebp
    2351:	57                   	push   %edi
    2352:	56                   	push   %esi
    2353:	53                   	push   %ebx
    2354:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    2357:	a1 30 37 00 00       	mov    0x3730,%eax
    235c:	85 c0                	test   %eax,%eax
    235e:	0f 85 2c 02 00 00    	jne    2590 <APGridPaint+0x242>
    {
        iconReady = 1;
    2364:	c7 05 30 37 00 00 01 	movl   $0x1,0x3730
    236b:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    236e:	8d 45 98             	lea    -0x68(%ebp),%eax
    2371:	83 ec 08             	sub    $0x8,%esp
    2374:	68 5b 2e 00 00       	push   $0x2e5b
    2379:	50                   	push   %eax
    237a:	e8 83 f1 ff ff       	call   1502 <APLoadBitmap>
    237f:	83 c4 0c             	add    $0xc,%esp
    2382:	8b 45 98             	mov    -0x68(%ebp),%eax
    2385:	a3 54 37 00 00       	mov    %eax,0x3754
    238a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    238d:	a3 58 37 00 00       	mov    %eax,0x3758
    2392:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2395:	a3 5c 37 00 00       	mov    %eax,0x375c
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    239a:	83 ec 04             	sub    $0x4,%esp
    239d:	ff 35 5c 37 00 00    	pushl  0x375c
    23a3:	ff 35 58 37 00 00    	pushl  0x3758
    23a9:	ff 35 54 37 00 00    	pushl  0x3754
    23af:	e8 88 f3 ff ff       	call   173c <APCreateCompatibleDCFromBitmap>
    23b4:	83 c4 10             	add    $0x10,%esp
    23b7:	a3 60 37 00 00       	mov    %eax,0x3760
        grid_river = APLoadBitmap ("grid_river.bmp");
    23bc:	8d 45 98             	lea    -0x68(%ebp),%eax
    23bf:	83 ec 08             	sub    $0x8,%esp
    23c2:	68 69 2e 00 00       	push   $0x2e69
    23c7:	50                   	push   %eax
    23c8:	e8 35 f1 ff ff       	call   1502 <APLoadBitmap>
    23cd:	83 c4 0c             	add    $0xc,%esp
    23d0:	8b 45 98             	mov    -0x68(%ebp),%eax
    23d3:	a3 90 37 00 00       	mov    %eax,0x3790
    23d8:	8b 45 9c             	mov    -0x64(%ebp),%eax
    23db:	a3 94 37 00 00       	mov    %eax,0x3794
    23e0:	8b 45 a0             	mov    -0x60(%ebp),%eax
    23e3:	a3 98 37 00 00       	mov    %eax,0x3798
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    23e8:	83 ec 04             	sub    $0x4,%esp
    23eb:	ff 35 98 37 00 00    	pushl  0x3798
    23f1:	ff 35 94 37 00 00    	pushl  0x3794
    23f7:	ff 35 90 37 00 00    	pushl  0x3790
    23fd:	e8 3a f3 ff ff       	call   173c <APCreateCompatibleDCFromBitmap>
    2402:	83 c4 10             	add    $0x10,%esp
    2405:	a3 80 37 00 00       	mov    %eax,0x3780
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    240a:	8d 45 98             	lea    -0x68(%ebp),%eax
    240d:	83 ec 08             	sub    $0x8,%esp
    2410:	68 78 2e 00 00       	push   $0x2e78
    2415:	50                   	push   %eax
    2416:	e8 e7 f0 ff ff       	call   1502 <APLoadBitmap>
    241b:	83 c4 0c             	add    $0xc,%esp
    241e:	8b 45 98             	mov    -0x68(%ebp),%eax
    2421:	a3 84 37 00 00       	mov    %eax,0x3784
    2426:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2429:	a3 88 37 00 00       	mov    %eax,0x3788
    242e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2431:	a3 8c 37 00 00       	mov    %eax,0x378c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    2436:	83 ec 04             	sub    $0x4,%esp
    2439:	ff 35 8c 37 00 00    	pushl  0x378c
    243f:	ff 35 88 37 00 00    	pushl  0x3788
    2445:	ff 35 84 37 00 00    	pushl  0x3784
    244b:	e8 ec f2 ff ff       	call   173c <APCreateCompatibleDCFromBitmap>
    2450:	83 c4 10             	add    $0x10,%esp
    2453:	a3 34 37 00 00       	mov    %eax,0x3734
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    2458:	8d 45 98             	lea    -0x68(%ebp),%eax
    245b:	83 ec 08             	sub    $0x8,%esp
    245e:	68 87 2e 00 00       	push   $0x2e87
    2463:	50                   	push   %eax
    2464:	e8 99 f0 ff ff       	call   1502 <APLoadBitmap>
    2469:	83 c4 0c             	add    $0xc,%esp
    246c:	8b 45 98             	mov    -0x68(%ebp),%eax
    246f:	a3 68 37 00 00       	mov    %eax,0x3768
    2474:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2477:	a3 6c 37 00 00       	mov    %eax,0x376c
    247c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    247f:	a3 70 37 00 00       	mov    %eax,0x3770
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    2484:	83 ec 04             	sub    $0x4,%esp
    2487:	ff 35 70 37 00 00    	pushl  0x3770
    248d:	ff 35 6c 37 00 00    	pushl  0x376c
    2493:	ff 35 68 37 00 00    	pushl  0x3768
    2499:	e8 9e f2 ff ff       	call   173c <APCreateCompatibleDCFromBitmap>
    249e:	83 c4 10             	add    $0x10,%esp
    24a1:	a3 9c 37 00 00       	mov    %eax,0x379c
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    24a6:	8d 45 98             	lea    -0x68(%ebp),%eax
    24a9:	83 ec 08             	sub    $0x8,%esp
    24ac:	68 95 2e 00 00       	push   $0x2e95
    24b1:	50                   	push   %eax
    24b2:	e8 4b f0 ff ff       	call   1502 <APLoadBitmap>
    24b7:	83 c4 0c             	add    $0xc,%esp
    24ba:	8b 45 98             	mov    -0x68(%ebp),%eax
    24bd:	a3 44 37 00 00       	mov    %eax,0x3744
    24c2:	8b 45 9c             	mov    -0x64(%ebp),%eax
    24c5:	a3 48 37 00 00       	mov    %eax,0x3748
    24ca:	8b 45 a0             	mov    -0x60(%ebp),%eax
    24cd:	a3 4c 37 00 00       	mov    %eax,0x374c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    24d2:	83 ec 04             	sub    $0x4,%esp
    24d5:	ff 35 4c 37 00 00    	pushl  0x374c
    24db:	ff 35 48 37 00 00    	pushl  0x3748
    24e1:	ff 35 44 37 00 00    	pushl  0x3744
    24e7:	e8 50 f2 ff ff       	call   173c <APCreateCompatibleDCFromBitmap>
    24ec:	83 c4 10             	add    $0x10,%esp
    24ef:	a3 64 37 00 00       	mov    %eax,0x3764
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    24f4:	8d 45 98             	lea    -0x68(%ebp),%eax
    24f7:	83 ec 08             	sub    $0x8,%esp
    24fa:	68 a5 2e 00 00       	push   $0x2ea5
    24ff:	50                   	push   %eax
    2500:	e8 fd ef ff ff       	call   1502 <APLoadBitmap>
    2505:	83 c4 0c             	add    $0xc,%esp
    2508:	8b 45 98             	mov    -0x68(%ebp),%eax
    250b:	a3 38 37 00 00       	mov    %eax,0x3738
    2510:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2513:	a3 3c 37 00 00       	mov    %eax,0x373c
    2518:	8b 45 a0             	mov    -0x60(%ebp),%eax
    251b:	a3 40 37 00 00       	mov    %eax,0x3740
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    2520:	83 ec 04             	sub    $0x4,%esp
    2523:	ff 35 40 37 00 00    	pushl  0x3740
    2529:	ff 35 3c 37 00 00    	pushl  0x373c
    252f:	ff 35 38 37 00 00    	pushl  0x3738
    2535:	e8 02 f2 ff ff       	call   173c <APCreateCompatibleDCFromBitmap>
    253a:	83 c4 10             	add    $0x10,%esp
    253d:	a3 50 37 00 00       	mov    %eax,0x3750
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    2542:	8d 45 98             	lea    -0x68(%ebp),%eax
    2545:	83 ec 08             	sub    $0x8,%esp
    2548:	68 b7 2e 00 00       	push   $0x2eb7
    254d:	50                   	push   %eax
    254e:	e8 af ef ff ff       	call   1502 <APLoadBitmap>
    2553:	83 c4 0c             	add    $0xc,%esp
    2556:	8b 45 98             	mov    -0x68(%ebp),%eax
    2559:	a3 74 37 00 00       	mov    %eax,0x3774
    255e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2561:	a3 78 37 00 00       	mov    %eax,0x3778
    2566:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2569:	a3 7c 37 00 00       	mov    %eax,0x377c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    256e:	83 ec 04             	sub    $0x4,%esp
    2571:	ff 35 7c 37 00 00    	pushl  0x377c
    2577:	ff 35 78 37 00 00    	pushl  0x3778
    257d:	ff 35 74 37 00 00    	pushl  0x3774
    2583:	e8 b4 f1 ff ff       	call   173c <APCreateCompatibleDCFromBitmap>
    2588:	83 c4 10             	add    $0x10,%esp
    258b:	a3 a0 37 00 00       	mov    %eax,0x37a0
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    2590:	8b 45 08             	mov    0x8(%ebp),%eax
    2593:	8b 40 08             	mov    0x8(%eax),%eax
    2596:	85 c0                	test   %eax,%eax
    2598:	75 17                	jne    25b1 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    259a:	83 ec 08             	sub    $0x8,%esp
    259d:	68 c8 2e 00 00       	push   $0x2ec8
    25a2:	6a 01                	push   $0x1
    25a4:	e8 d3 ea ff ff       	call   107c <printf>
    25a9:	83 c4 10             	add    $0x10,%esp
        return;
    25ac:	e9 f2 03 00 00       	jmp    29a3 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    25b1:	8b 45 08             	mov    0x8(%ebp),%eax
    25b4:	8b 40 10             	mov    0x10(%eax),%eax
    25b7:	85 c0                	test   %eax,%eax
    25b9:	7e 10                	jle    25cb <APGridPaint+0x27d>
    25bb:	8b 45 08             	mov    0x8(%ebp),%eax
    25be:	8b 50 14             	mov    0x14(%eax),%edx
    25c1:	8b 45 08             	mov    0x8(%ebp),%eax
    25c4:	8b 40 10             	mov    0x10(%eax),%eax
    25c7:	39 c2                	cmp    %eax,%edx
    25c9:	7c 17                	jl     25e2 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    25cb:	83 ec 08             	sub    $0x8,%esp
    25ce:	68 ee 2e 00 00       	push   $0x2eee
    25d3:	6a 01                	push   $0x1
    25d5:	e8 a2 ea ff ff       	call   107c <printf>
    25da:	83 c4 10             	add    $0x10,%esp
        return;
    25dd:	e9 c1 03 00 00       	jmp    29a3 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    25e2:	8b 45 08             	mov    0x8(%ebp),%eax
    25e5:	8b 40 14             	mov    0x14(%eax),%eax
    25e8:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    25ee:	89 45 dc             	mov    %eax,-0x24(%ebp)
    25f1:	8b 45 dc             	mov    -0x24(%ebp),%eax
    25f4:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    25f7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    25fe:	e9 96 03 00 00       	jmp    2999 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2603:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    260a:	e9 7c 03 00 00       	jmp    298b <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    260f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2612:	c1 e0 04             	shl    $0x4,%eax
    2615:	89 c2                	mov    %eax,%edx
    2617:	8b 45 d8             	mov    -0x28(%ebp),%eax
    261a:	01 c2                	add    %eax,%edx
    261c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    261f:	01 d0                	add    %edx,%eax
    2621:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    2624:	8b 45 08             	mov    0x8(%ebp),%eax
    2627:	8b 40 0c             	mov    0xc(%eax),%eax
    262a:	8b 55 dc             	mov    -0x24(%ebp),%edx
    262d:	c1 e2 02             	shl    $0x2,%edx
    2630:	01 d0                	add    %edx,%eax
    2632:	8b 00                	mov    (%eax),%eax
    2634:	83 f8 07             	cmp    $0x7,%eax
    2637:	0f 87 49 03 00 00    	ja     2986 <APGridPaint+0x638>
    263d:	8b 04 85 04 2f 00 00 	mov    0x2f04(,%eax,4),%eax
    2644:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2646:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    2649:	6a 0c                	push   $0xc
    264b:	6a 0c                	push   $0xc
    264d:	6a 0c                	push   $0xc
    264f:	50                   	push   %eax
    2650:	e8 46 f9 ff ff       	call   1f9b <RGB>
    2655:	83 c4 0c             	add    $0xc,%esp
    2658:	8b 1d 60 37 00 00    	mov    0x3760,%ebx
    265e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2661:	6b c8 32             	imul   $0x32,%eax,%ecx
    2664:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2667:	6b c0 32             	imul   $0x32,%eax,%eax
    266a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    266d:	8b 45 08             	mov    0x8(%ebp),%eax
    2670:	8d 78 34             	lea    0x34(%eax),%edi
    2673:	83 ec 0c             	sub    $0xc,%esp
    2676:	83 ec 04             	sub    $0x4,%esp
    2679:	89 e0                	mov    %esp,%eax
    267b:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    267f:	66 89 30             	mov    %si,(%eax)
    2682:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    2686:	88 50 02             	mov    %dl,0x2(%eax)
    2689:	6a 32                	push   $0x32
    268b:	6a 32                	push   $0x32
    268d:	6a 00                	push   $0x0
    268f:	6a 00                	push   $0x0
    2691:	53                   	push   %ebx
    2692:	51                   	push   %ecx
    2693:	ff 75 94             	pushl  -0x6c(%ebp)
    2696:	57                   	push   %edi
    2697:	e8 5b f7 ff ff       	call   1df7 <APDcCopy>
    269c:	83 c4 30             	add    $0x30,%esp
                    break;
    269f:	e9 e3 02 00 00       	jmp    2987 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    26a4:	8d 45 98             	lea    -0x68(%ebp),%eax
    26a7:	6a 69                	push   $0x69
    26a9:	6a 69                	push   $0x69
    26ab:	6a 69                	push   $0x69
    26ad:	50                   	push   %eax
    26ae:	e8 e8 f8 ff ff       	call   1f9b <RGB>
    26b3:	83 c4 0c             	add    $0xc,%esp
    26b6:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    26ba:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    26be:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    26c2:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    26c5:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    26cc:	8d 45 98             	lea    -0x68(%ebp),%eax
    26cf:	6a 69                	push   $0x69
    26d1:	6a 69                	push   $0x69
    26d3:	6a 69                	push   $0x69
    26d5:	50                   	push   %eax
    26d6:	e8 c0 f8 ff ff       	call   1f9b <RGB>
    26db:	83 c4 0c             	add    $0xc,%esp
    26de:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    26e2:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    26e6:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    26ea:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    26ed:	8b 45 08             	mov    0x8(%ebp),%eax
    26f0:	8d 50 34             	lea    0x34(%eax),%edx
    26f3:	8d 45 98             	lea    -0x68(%ebp),%eax
    26f6:	ff 75 bc             	pushl  -0x44(%ebp)
    26f9:	ff 75 b8             	pushl  -0x48(%ebp)
    26fc:	52                   	push   %edx
    26fd:	50                   	push   %eax
    26fe:	e8 ce f0 ff ff       	call   17d1 <APSetPen>
    2703:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    2706:	8b 45 08             	mov    0x8(%ebp),%eax
    2709:	8d 58 34             	lea    0x34(%eax),%ebx
    270c:	8d 55 98             	lea    -0x68(%ebp),%edx
    270f:	83 ec 04             	sub    $0x4,%esp
    2712:	83 ec 04             	sub    $0x4,%esp
    2715:	89 e0                	mov    %esp,%eax
    2717:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    271b:	66 89 08             	mov    %cx,(%eax)
    271e:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    2722:	88 48 02             	mov    %cl,0x2(%eax)
    2725:	53                   	push   %ebx
    2726:	52                   	push   %edx
    2727:	e8 de f0 ff ff       	call   180a <APSetBrush>
    272c:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    272f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2732:	6b d0 32             	imul   $0x32,%eax,%edx
    2735:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2738:	6b c0 32             	imul   $0x32,%eax,%eax
    273b:	8b 4d 08             	mov    0x8(%ebp),%ecx
    273e:	83 c1 34             	add    $0x34,%ecx
    2741:	83 ec 0c             	sub    $0xc,%esp
    2744:	6a 32                	push   $0x32
    2746:	6a 32                	push   $0x32
    2748:	52                   	push   %edx
    2749:	50                   	push   %eax
    274a:	51                   	push   %ecx
    274b:	e8 a2 f4 ff ff       	call   1bf2 <APDrawRect>
    2750:	83 c4 20             	add    $0x20,%esp
                    break;
    2753:	e9 2f 02 00 00       	jmp    2987 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2758:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    275b:	6a 0c                	push   $0xc
    275d:	6a 0c                	push   $0xc
    275f:	6a 0c                	push   $0xc
    2761:	50                   	push   %eax
    2762:	e8 34 f8 ff ff       	call   1f9b <RGB>
    2767:	83 c4 0c             	add    $0xc,%esp
    276a:	8b 1d a0 37 00 00    	mov    0x37a0,%ebx
    2770:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2773:	6b c8 32             	imul   $0x32,%eax,%ecx
    2776:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2779:	6b c0 32             	imul   $0x32,%eax,%eax
    277c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    277f:	8b 45 08             	mov    0x8(%ebp),%eax
    2782:	8d 78 34             	lea    0x34(%eax),%edi
    2785:	83 ec 0c             	sub    $0xc,%esp
    2788:	83 ec 04             	sub    $0x4,%esp
    278b:	89 e0                	mov    %esp,%eax
    278d:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    2791:	66 89 30             	mov    %si,(%eax)
    2794:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    2798:	88 50 02             	mov    %dl,0x2(%eax)
    279b:	6a 32                	push   $0x32
    279d:	6a 32                	push   $0x32
    279f:	6a 00                	push   $0x0
    27a1:	6a 00                	push   $0x0
    27a3:	53                   	push   %ebx
    27a4:	51                   	push   %ecx
    27a5:	ff 75 94             	pushl  -0x6c(%ebp)
    27a8:	57                   	push   %edi
    27a9:	e8 49 f6 ff ff       	call   1df7 <APDcCopy>
    27ae:	83 c4 30             	add    $0x30,%esp
                    break;
    27b1:	e9 d1 01 00 00       	jmp    2987 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    27b6:	8d 45 c9             	lea    -0x37(%ebp),%eax
    27b9:	6a 0c                	push   $0xc
    27bb:	6a 0c                	push   $0xc
    27bd:	6a 0c                	push   $0xc
    27bf:	50                   	push   %eax
    27c0:	e8 d6 f7 ff ff       	call   1f9b <RGB>
    27c5:	83 c4 0c             	add    $0xc,%esp
    27c8:	8b 1d 80 37 00 00    	mov    0x3780,%ebx
    27ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    27d1:	6b c8 32             	imul   $0x32,%eax,%ecx
    27d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    27d7:	6b c0 32             	imul   $0x32,%eax,%eax
    27da:	89 45 94             	mov    %eax,-0x6c(%ebp)
    27dd:	8b 45 08             	mov    0x8(%ebp),%eax
    27e0:	8d 78 34             	lea    0x34(%eax),%edi
    27e3:	83 ec 0c             	sub    $0xc,%esp
    27e6:	83 ec 04             	sub    $0x4,%esp
    27e9:	89 e0                	mov    %esp,%eax
    27eb:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    27ef:	66 89 30             	mov    %si,(%eax)
    27f2:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    27f6:	88 50 02             	mov    %dl,0x2(%eax)
    27f9:	6a 32                	push   $0x32
    27fb:	6a 32                	push   $0x32
    27fd:	6a 00                	push   $0x0
    27ff:	6a 00                	push   $0x0
    2801:	53                   	push   %ebx
    2802:	51                   	push   %ecx
    2803:	ff 75 94             	pushl  -0x6c(%ebp)
    2806:	57                   	push   %edi
    2807:	e8 eb f5 ff ff       	call   1df7 <APDcCopy>
    280c:	83 c4 30             	add    $0x30,%esp
                    break;
    280f:	e9 73 01 00 00       	jmp    2987 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2814:	8d 45 cc             	lea    -0x34(%ebp),%eax
    2817:	6a 0c                	push   $0xc
    2819:	6a 0c                	push   $0xc
    281b:	6a 0c                	push   $0xc
    281d:	50                   	push   %eax
    281e:	e8 78 f7 ff ff       	call   1f9b <RGB>
    2823:	83 c4 0c             	add    $0xc,%esp
    2826:	8b 1d 64 37 00 00    	mov    0x3764,%ebx
    282c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    282f:	6b c8 32             	imul   $0x32,%eax,%ecx
    2832:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2835:	6b c0 32             	imul   $0x32,%eax,%eax
    2838:	89 45 94             	mov    %eax,-0x6c(%ebp)
    283b:	8b 45 08             	mov    0x8(%ebp),%eax
    283e:	8d 78 34             	lea    0x34(%eax),%edi
    2841:	83 ec 0c             	sub    $0xc,%esp
    2844:	83 ec 04             	sub    $0x4,%esp
    2847:	89 e0                	mov    %esp,%eax
    2849:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    284d:	66 89 30             	mov    %si,(%eax)
    2850:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    2854:	88 50 02             	mov    %dl,0x2(%eax)
    2857:	6a 32                	push   $0x32
    2859:	6a 32                	push   $0x32
    285b:	6a 00                	push   $0x0
    285d:	6a 00                	push   $0x0
    285f:	53                   	push   %ebx
    2860:	51                   	push   %ecx
    2861:	ff 75 94             	pushl  -0x6c(%ebp)
    2864:	57                   	push   %edi
    2865:	e8 8d f5 ff ff       	call   1df7 <APDcCopy>
    286a:	83 c4 30             	add    $0x30,%esp
                    break;
    286d:	e9 15 01 00 00       	jmp    2987 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2872:	8d 45 cf             	lea    -0x31(%ebp),%eax
    2875:	6a 0c                	push   $0xc
    2877:	6a 0c                	push   $0xc
    2879:	6a 0c                	push   $0xc
    287b:	50                   	push   %eax
    287c:	e8 1a f7 ff ff       	call   1f9b <RGB>
    2881:	83 c4 0c             	add    $0xc,%esp
    2884:	8b 1d 9c 37 00 00    	mov    0x379c,%ebx
    288a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    288d:	6b c8 32             	imul   $0x32,%eax,%ecx
    2890:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2893:	6b c0 32             	imul   $0x32,%eax,%eax
    2896:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2899:	8b 45 08             	mov    0x8(%ebp),%eax
    289c:	8d 78 34             	lea    0x34(%eax),%edi
    289f:	83 ec 0c             	sub    $0xc,%esp
    28a2:	83 ec 04             	sub    $0x4,%esp
    28a5:	89 e0                	mov    %esp,%eax
    28a7:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    28ab:	66 89 30             	mov    %si,(%eax)
    28ae:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    28b2:	88 50 02             	mov    %dl,0x2(%eax)
    28b5:	6a 32                	push   $0x32
    28b7:	6a 32                	push   $0x32
    28b9:	6a 00                	push   $0x0
    28bb:	6a 00                	push   $0x0
    28bd:	53                   	push   %ebx
    28be:	51                   	push   %ecx
    28bf:	ff 75 94             	pushl  -0x6c(%ebp)
    28c2:	57                   	push   %edi
    28c3:	e8 2f f5 ff ff       	call   1df7 <APDcCopy>
    28c8:	83 c4 30             	add    $0x30,%esp
                    break;
    28cb:	e9 b7 00 00 00       	jmp    2987 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    28d0:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    28d3:	6a 0c                	push   $0xc
    28d5:	6a 0c                	push   $0xc
    28d7:	6a 0c                	push   $0xc
    28d9:	50                   	push   %eax
    28da:	e8 bc f6 ff ff       	call   1f9b <RGB>
    28df:	83 c4 0c             	add    $0xc,%esp
    28e2:	8b 1d 34 37 00 00    	mov    0x3734,%ebx
    28e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    28eb:	6b c8 32             	imul   $0x32,%eax,%ecx
    28ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
    28f1:	6b c0 32             	imul   $0x32,%eax,%eax
    28f4:	89 45 94             	mov    %eax,-0x6c(%ebp)
    28f7:	8b 45 08             	mov    0x8(%ebp),%eax
    28fa:	8d 78 34             	lea    0x34(%eax),%edi
    28fd:	83 ec 0c             	sub    $0xc,%esp
    2900:	83 ec 04             	sub    $0x4,%esp
    2903:	89 e0                	mov    %esp,%eax
    2905:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2909:	66 89 30             	mov    %si,(%eax)
    290c:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2910:	88 50 02             	mov    %dl,0x2(%eax)
    2913:	6a 32                	push   $0x32
    2915:	6a 32                	push   $0x32
    2917:	6a 00                	push   $0x0
    2919:	6a 00                	push   $0x0
    291b:	53                   	push   %ebx
    291c:	51                   	push   %ecx
    291d:	ff 75 94             	pushl  -0x6c(%ebp)
    2920:	57                   	push   %edi
    2921:	e8 d1 f4 ff ff       	call   1df7 <APDcCopy>
    2926:	83 c4 30             	add    $0x30,%esp
                    break;
    2929:	eb 5c                	jmp    2987 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    292b:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    292e:	6a 0c                	push   $0xc
    2930:	6a 0c                	push   $0xc
    2932:	6a 0c                	push   $0xc
    2934:	50                   	push   %eax
    2935:	e8 61 f6 ff ff       	call   1f9b <RGB>
    293a:	83 c4 0c             	add    $0xc,%esp
    293d:	8b 1d 50 37 00 00    	mov    0x3750,%ebx
    2943:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2946:	6b c8 32             	imul   $0x32,%eax,%ecx
    2949:	8b 45 e0             	mov    -0x20(%ebp),%eax
    294c:	6b c0 32             	imul   $0x32,%eax,%eax
    294f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2952:	8b 45 08             	mov    0x8(%ebp),%eax
    2955:	8d 78 34             	lea    0x34(%eax),%edi
    2958:	83 ec 0c             	sub    $0xc,%esp
    295b:	83 ec 04             	sub    $0x4,%esp
    295e:	89 e0                	mov    %esp,%eax
    2960:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2964:	66 89 30             	mov    %si,(%eax)
    2967:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    296b:	88 50 02             	mov    %dl,0x2(%eax)
    296e:	6a 32                	push   $0x32
    2970:	6a 32                	push   $0x32
    2972:	6a 00                	push   $0x0
    2974:	6a 00                	push   $0x0
    2976:	53                   	push   %ebx
    2977:	51                   	push   %ecx
    2978:	ff 75 94             	pushl  -0x6c(%ebp)
    297b:	57                   	push   %edi
    297c:	e8 76 f4 ff ff       	call   1df7 <APDcCopy>
    2981:	83 c4 30             	add    $0x30,%esp
                    break;
    2984:	eb 01                	jmp    2987 <APGridPaint+0x639>
                default: break;
    2986:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2987:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    298b:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    298f:	0f 8e 7a fc ff ff    	jle    260f <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2995:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2999:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    299d:	0f 8e 60 fc ff ff    	jle    2603 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    29a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    29a6:	5b                   	pop    %ebx
    29a7:	5e                   	pop    %esi
    29a8:	5f                   	pop    %edi
    29a9:	5d                   	pop    %ebp
    29aa:	c3                   	ret    

000029ab <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    29ab:	55                   	push   %ebp
    29ac:	89 e5                	mov    %esp,%ebp
    29ae:	53                   	push   %ebx
    29af:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    29b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    29b9:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    29bd:	74 17                	je     29d6 <sprintint+0x2b>
    29bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    29c3:	79 11                	jns    29d6 <sprintint+0x2b>
        neg = 1;
    29c5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    29cc:	8b 45 10             	mov    0x10(%ebp),%eax
    29cf:	f7 d8                	neg    %eax
    29d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    29d4:	eb 06                	jmp    29dc <sprintint+0x31>
    } else {
        x = xx;
    29d6:	8b 45 10             	mov    0x10(%ebp),%eax
    29d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    29dc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    29e3:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    29e6:	8d 41 01             	lea    0x1(%ecx),%eax
    29e9:	89 45 f8             	mov    %eax,-0x8(%ebp)
    29ec:	8b 5d 14             	mov    0x14(%ebp),%ebx
    29ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
    29f2:	ba 00 00 00 00       	mov    $0x0,%edx
    29f7:	f7 f3                	div    %ebx
    29f9:	89 d0                	mov    %edx,%eax
    29fb:	0f b6 80 98 36 00 00 	movzbl 0x3698(%eax),%eax
    2a02:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2a06:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2a09:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2a0c:	ba 00 00 00 00       	mov    $0x0,%edx
    2a11:	f7 f3                	div    %ebx
    2a13:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2a16:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2a1a:	75 c7                	jne    29e3 <sprintint+0x38>
    if(neg)
    2a1c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a20:	74 0e                	je     2a30 <sprintint+0x85>
        buf[i++] = '-';
    2a22:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2a25:	8d 50 01             	lea    0x1(%eax),%edx
    2a28:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2a2b:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2a30:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2a33:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2a36:	eb 1b                	jmp    2a53 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2a38:	8b 45 0c             	mov    0xc(%ebp),%eax
    2a3b:	8b 00                	mov    (%eax),%eax
    2a3d:	8d 48 01             	lea    0x1(%eax),%ecx
    2a40:	8b 55 0c             	mov    0xc(%ebp),%edx
    2a43:	89 0a                	mov    %ecx,(%edx)
    2a45:	89 c2                	mov    %eax,%edx
    2a47:	8b 45 08             	mov    0x8(%ebp),%eax
    2a4a:	01 d0                	add    %edx,%eax
    2a4c:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2a4f:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2a53:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2a57:	7f df                	jg     2a38 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2a59:	eb 21                	jmp    2a7c <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2a5b:	8b 45 0c             	mov    0xc(%ebp),%eax
    2a5e:	8b 00                	mov    (%eax),%eax
    2a60:	8d 48 01             	lea    0x1(%eax),%ecx
    2a63:	8b 55 0c             	mov    0xc(%ebp),%edx
    2a66:	89 0a                	mov    %ecx,(%edx)
    2a68:	89 c2                	mov    %eax,%edx
    2a6a:	8b 45 08             	mov    0x8(%ebp),%eax
    2a6d:	01 c2                	add    %eax,%edx
    2a6f:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2a72:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2a75:	01 c8                	add    %ecx,%eax
    2a77:	0f b6 00             	movzbl (%eax),%eax
    2a7a:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2a7c:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2a80:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2a84:	79 d5                	jns    2a5b <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2a86:	90                   	nop
    2a87:	83 c4 20             	add    $0x20,%esp
    2a8a:	5b                   	pop    %ebx
    2a8b:	5d                   	pop    %ebp
    2a8c:	c3                   	ret    

00002a8d <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2a8d:	55                   	push   %ebp
    2a8e:	89 e5                	mov    %esp,%ebp
    2a90:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2a93:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2a9a:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2aa1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2aa8:	8d 45 0c             	lea    0xc(%ebp),%eax
    2aab:	83 c0 04             	add    $0x4,%eax
    2aae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2ab1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2ab8:	e9 d9 01 00 00       	jmp    2c96 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2abd:	8b 55 0c             	mov    0xc(%ebp),%edx
    2ac0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2ac3:	01 d0                	add    %edx,%eax
    2ac5:	0f b6 00             	movzbl (%eax),%eax
    2ac8:	0f be c0             	movsbl %al,%eax
    2acb:	25 ff 00 00 00       	and    $0xff,%eax
    2ad0:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2ad3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2ad7:	75 2c                	jne    2b05 <sprintf+0x78>
            if(c == '%'){
    2ad9:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2add:	75 0c                	jne    2aeb <sprintf+0x5e>
                state = '%';
    2adf:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2ae6:	e9 a7 01 00 00       	jmp    2c92 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2aeb:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2aee:	8d 50 01             	lea    0x1(%eax),%edx
    2af1:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2af4:	89 c2                	mov    %eax,%edx
    2af6:	8b 45 08             	mov    0x8(%ebp),%eax
    2af9:	01 d0                	add    %edx,%eax
    2afb:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2afe:	88 10                	mov    %dl,(%eax)
    2b00:	e9 8d 01 00 00       	jmp    2c92 <sprintf+0x205>
            }
        } else if(state == '%'){
    2b05:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2b09:	0f 85 83 01 00 00    	jne    2c92 <sprintf+0x205>
            if(c == 'd'){
    2b0f:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2b13:	75 4c                	jne    2b61 <sprintf+0xd4>
                buf[bi] = '\0';
    2b15:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2b18:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2b1b:	01 d0                	add    %edx,%eax
    2b1d:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2b20:	83 ec 0c             	sub    $0xc,%esp
    2b23:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2b26:	50                   	push   %eax
    2b27:	e8 17 e3 ff ff       	call   e43 <atoi>
    2b2c:	83 c4 10             	add    $0x10,%esp
    2b2f:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2b32:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2b39:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2b3c:	8b 00                	mov    (%eax),%eax
    2b3e:	83 ec 08             	sub    $0x8,%esp
    2b41:	ff 75 d8             	pushl  -0x28(%ebp)
    2b44:	6a 01                	push   $0x1
    2b46:	6a 0a                	push   $0xa
    2b48:	50                   	push   %eax
    2b49:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2b4c:	50                   	push   %eax
    2b4d:	ff 75 08             	pushl  0x8(%ebp)
    2b50:	e8 56 fe ff ff       	call   29ab <sprintint>
    2b55:	83 c4 20             	add    $0x20,%esp
                ap++;
    2b58:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2b5c:	e9 2a 01 00 00       	jmp    2c8b <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2b61:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2b65:	74 06                	je     2b6d <sprintf+0xe0>
    2b67:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2b6b:	75 4c                	jne    2bb9 <sprintf+0x12c>
                buf[bi] = '\0';
    2b6d:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2b70:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2b73:	01 d0                	add    %edx,%eax
    2b75:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2b78:	83 ec 0c             	sub    $0xc,%esp
    2b7b:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2b7e:	50                   	push   %eax
    2b7f:	e8 bf e2 ff ff       	call   e43 <atoi>
    2b84:	83 c4 10             	add    $0x10,%esp
    2b87:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2b8a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2b91:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2b94:	8b 00                	mov    (%eax),%eax
    2b96:	83 ec 08             	sub    $0x8,%esp
    2b99:	ff 75 dc             	pushl  -0x24(%ebp)
    2b9c:	6a 00                	push   $0x0
    2b9e:	6a 10                	push   $0x10
    2ba0:	50                   	push   %eax
    2ba1:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2ba4:	50                   	push   %eax
    2ba5:	ff 75 08             	pushl  0x8(%ebp)
    2ba8:	e8 fe fd ff ff       	call   29ab <sprintint>
    2bad:	83 c4 20             	add    $0x20,%esp
                ap++;
    2bb0:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2bb4:	e9 d2 00 00 00       	jmp    2c8b <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2bb9:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2bbd:	75 46                	jne    2c05 <sprintf+0x178>
                s = (char*)*ap;
    2bbf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2bc2:	8b 00                	mov    (%eax),%eax
    2bc4:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2bc7:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2bcb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2bcf:	75 25                	jne    2bf6 <sprintf+0x169>
                    s = "(null)";
    2bd1:	c7 45 f4 24 2f 00 00 	movl   $0x2f24,-0xc(%ebp)
                while(*s != 0){
    2bd8:	eb 1c                	jmp    2bf6 <sprintf+0x169>
                    dst[j++] = *s;
    2bda:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2bdd:	8d 50 01             	lea    0x1(%eax),%edx
    2be0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2be3:	89 c2                	mov    %eax,%edx
    2be5:	8b 45 08             	mov    0x8(%ebp),%eax
    2be8:	01 c2                	add    %eax,%edx
    2bea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2bed:	0f b6 00             	movzbl (%eax),%eax
    2bf0:	88 02                	mov    %al,(%edx)
                    s++;
    2bf2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2bf6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2bf9:	0f b6 00             	movzbl (%eax),%eax
    2bfc:	84 c0                	test   %al,%al
    2bfe:	75 da                	jne    2bda <sprintf+0x14d>
    2c00:	e9 86 00 00 00       	jmp    2c8b <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2c05:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2c09:	75 1d                	jne    2c28 <sprintf+0x19b>
                dst[j++] = *ap;
    2c0b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2c0e:	8d 50 01             	lea    0x1(%eax),%edx
    2c11:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2c14:	89 c2                	mov    %eax,%edx
    2c16:	8b 45 08             	mov    0x8(%ebp),%eax
    2c19:	01 c2                	add    %eax,%edx
    2c1b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2c1e:	8b 00                	mov    (%eax),%eax
    2c20:	88 02                	mov    %al,(%edx)
                ap++;
    2c22:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2c26:	eb 63                	jmp    2c8b <sprintf+0x1fe>
            } else if(c == '%'){
    2c28:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2c2c:	75 17                	jne    2c45 <sprintf+0x1b8>
                dst[j++] = c;
    2c2e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2c31:	8d 50 01             	lea    0x1(%eax),%edx
    2c34:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2c37:	89 c2                	mov    %eax,%edx
    2c39:	8b 45 08             	mov    0x8(%ebp),%eax
    2c3c:	01 d0                	add    %edx,%eax
    2c3e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2c41:	88 10                	mov    %dl,(%eax)
    2c43:	eb 46                	jmp    2c8b <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2c45:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2c49:	7e 18                	jle    2c63 <sprintf+0x1d6>
    2c4b:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2c4f:	7f 12                	jg     2c63 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2c51:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2c54:	8d 50 01             	lea    0x1(%eax),%edx
    2c57:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2c5a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2c5d:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2c61:	eb 2f                	jmp    2c92 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2c63:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2c66:	8d 50 01             	lea    0x1(%eax),%edx
    2c69:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2c6c:	89 c2                	mov    %eax,%edx
    2c6e:	8b 45 08             	mov    0x8(%ebp),%eax
    2c71:	01 d0                	add    %edx,%eax
    2c73:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2c76:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2c79:	8d 50 01             	lea    0x1(%eax),%edx
    2c7c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2c7f:	89 c2                	mov    %eax,%edx
    2c81:	8b 45 08             	mov    0x8(%ebp),%eax
    2c84:	01 d0                	add    %edx,%eax
    2c86:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2c89:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2c8b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2c92:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2c96:	8b 55 0c             	mov    0xc(%ebp),%edx
    2c99:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2c9c:	01 d0                	add    %edx,%eax
    2c9e:	0f b6 00             	movzbl (%eax),%eax
    2ca1:	84 c0                	test   %al,%al
    2ca3:	0f 85 14 fe ff ff    	jne    2abd <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2ca9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2cac:	8d 50 01             	lea    0x1(%eax),%edx
    2caf:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2cb2:	89 c2                	mov    %eax,%edx
    2cb4:	8b 45 08             	mov    0x8(%ebp),%eax
    2cb7:	01 d0                	add    %edx,%eax
    2cb9:	c6 00 00             	movb   $0x0,(%eax)
}
    2cbc:	90                   	nop
    2cbd:	c9                   	leave  
    2cbe:	c3                   	ret    
