
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
      1b:	8b 04 85 1c 30 00 00 	mov    0x301c(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 f0 2f 00 00       	push   $0x2ff0
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
      6c:	68 f7 2f 00 00       	push   $0x2ff7
      71:	6a 02                	push   $0x2
      73:	e8 0c 10 00 00       	call   1084 <printf>
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
      bf:	68 07 30 00 00       	push   $0x3007
      c4:	6a 02                	push   $0x2
      c6:	e8 b9 0f 00 00       	call   1084 <printf>
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
     143:	68 17 30 00 00       	push   $0x3017
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
     254:	68 34 30 00 00       	push   $0x3034
     259:	6a 02                	push   $0x2
     25b:	e8 24 0e 00 00       	call   1084 <printf>
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
     2ce:	68 37 30 00 00       	push   $0x3037
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
     2e9:	0f b6 05 a0 76 00 00 	movzbl 0x76a0,%eax
     2f0:	3c 63                	cmp    $0x63,%al
     2f2:	75 5f                	jne    353 <main+0xb3>
     2f4:	0f b6 05 a1 76 00 00 	movzbl 0x76a1,%eax
     2fb:	3c 64                	cmp    $0x64,%al
     2fd:	75 54                	jne    353 <main+0xb3>
     2ff:	0f b6 05 a2 76 00 00 	movzbl 0x76a2,%eax
     306:	3c 20                	cmp    $0x20,%al
     308:	75 49                	jne    353 <main+0xb3>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     30a:	83 ec 0c             	sub    $0xc,%esp
     30d:	68 a0 76 00 00       	push   $0x76a0
     312:	e8 fc 09 00 00       	call   d13 <strlen>
     317:	83 c4 10             	add    $0x10,%esp
     31a:	83 e8 01             	sub    $0x1,%eax
     31d:	c6 80 a0 76 00 00 00 	movb   $0x0,0x76a0(%eax)
      if(chdir(buf+3) < 0)
     324:	b8 a3 76 00 00       	mov    $0x76a3,%eax
     329:	83 ec 0c             	sub    $0xc,%esp
     32c:	50                   	push   %eax
     32d:	e8 13 0c 00 00       	call   f45 <chdir>
     332:	83 c4 10             	add    $0x10,%esp
     335:	85 c0                	test   %eax,%eax
     337:	79 44                	jns    37d <main+0xdd>
        printf(2, "cannot cd %s\n", buf+3);
     339:	b8 a3 76 00 00       	mov    $0x76a3,%eax
     33e:	83 ec 04             	sub    $0x4,%esp
     341:	50                   	push   %eax
     342:	68 3f 30 00 00       	push   $0x303f
     347:	6a 02                	push   $0x2
     349:	e8 36 0d 00 00       	call   1084 <printf>
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
     35f:	68 a0 76 00 00       	push   $0x76a0
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
     382:	68 a0 76 00 00       	push   $0x76a0
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
     3a8:	68 4d 30 00 00       	push   $0x304d
     3ad:	6a 02                	push   $0x2
     3af:	e8 d0 0c 00 00       	call   1084 <printf>
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
     3d3:	68 51 30 00 00       	push   $0x3051
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
     3f0:	e8 62 0f 00 00       	call   1357 <malloc>
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
     426:	e8 2c 0f 00 00       	call   1357 <malloc>
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
     489:	e8 c9 0e 00 00       	call   1357 <malloc>
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
     4d1:	e8 81 0e 00 00       	call   1357 <malloc>
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
     519:	e8 39 0e 00 00       	call   1357 <malloc>
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
     576:	68 20 3a 00 00       	push   $0x3a20
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
     61f:	68 20 3a 00 00       	push   $0x3a20
     624:	e8 2b 07 00 00       	call   d54 <strchr>
     629:	83 c4 10             	add    $0x10,%esp
     62c:	85 c0                	test   %eax,%eax
     62e:	75 26                	jne    656 <gettoken+0x109>
     630:	8b 45 f4             	mov    -0xc(%ebp),%eax
     633:	0f b6 00             	movzbl (%eax),%eax
     636:	0f be c0             	movsbl %al,%eax
     639:	83 ec 08             	sub    $0x8,%esp
     63c:	50                   	push   %eax
     63d:	68 28 3a 00 00       	push   $0x3a28
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
     680:	68 20 3a 00 00       	push   $0x3a20
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
     6c7:	68 20 3a 00 00       	push   $0x3a20
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
     74a:	68 56 30 00 00       	push   $0x3056
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
     76d:	68 57 30 00 00       	push   $0x3057
     772:	6a 02                	push   $0x2
     774:	e8 0b 09 00 00       	call   1084 <printf>
     779:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     77c:	83 ec 0c             	sub    $0xc,%esp
     77f:	68 66 30 00 00       	push   $0x3066
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
     7e4:	68 6d 30 00 00       	push   $0x306d
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
     7fe:	68 6f 30 00 00       	push   $0x306f
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
     86c:	68 71 30 00 00       	push   $0x3071
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
     8fb:	68 73 30 00 00       	push   $0x3073
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
     981:	68 90 30 00 00       	push   $0x3090
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
     9aa:	68 93 30 00 00       	push   $0x3093
     9af:	ff 75 0c             	pushl  0xc(%ebp)
     9b2:	ff 75 08             	pushl  0x8(%ebp)
     9b5:	e8 e4 fc ff ff       	call   69e <peek>
     9ba:	83 c4 10             	add    $0x10,%esp
     9bd:	85 c0                	test   %eax,%eax
     9bf:	75 10                	jne    9d1 <parseblock+0x30>
    panic("parseblock");
     9c1:	83 ec 0c             	sub    $0xc,%esp
     9c4:	68 95 30 00 00       	push   $0x3095
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
     9fa:	68 a0 30 00 00       	push   $0x30a0
     9ff:	ff 75 0c             	pushl  0xc(%ebp)
     a02:	ff 75 08             	pushl  0x8(%ebp)
     a05:	e8 94 fc ff ff       	call   69e <peek>
     a0a:	83 c4 10             	add    $0x10,%esp
     a0d:	85 c0                	test   %eax,%eax
     a0f:	75 10                	jne    a21 <parseblock+0x80>
    panic("syntax - missing )");
     a11:	83 ec 0c             	sub    $0xc,%esp
     a14:	68 a2 30 00 00       	push   $0x30a2
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
     a58:	68 93 30 00 00       	push   $0x3093
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
     ae2:	68 66 30 00 00       	push   $0x3066
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
     b19:	68 b5 30 00 00       	push   $0x30b5
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
     b40:	68 c3 30 00 00       	push   $0x30c3
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
     ba6:	8b 04 85 c8 30 00 00 	mov    0x30c8(,%eax,4),%eax
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

00000f7d <sendMessage>:
SYSCALL(sendMessage)
     f7d:	b8 17 00 00 00       	mov    $0x17,%eax
     f82:	cd 40                	int    $0x40
     f84:	c3                   	ret    

00000f85 <getMessage>:
SYSCALL(getMessage)
     f85:	b8 19 00 00 00       	mov    $0x19,%eax
     f8a:	cd 40                	int    $0x40
     f8c:	c3                   	ret    

00000f8d <registWindow>:
SYSCALL(registWindow)
     f8d:	b8 18 00 00 00       	mov    $0x18,%eax
     f92:	cd 40                	int    $0x40
     f94:	c3                   	ret    

00000f95 <changePosition>:
SYSCALL(changePosition)
     f95:	b8 1a 00 00 00       	mov    $0x1a,%eax
     f9a:	cd 40                	int    $0x40
     f9c:	c3                   	ret    

00000f9d <setupTimer>:
SYSCALL(setupTimer)
     f9d:	b8 1b 00 00 00       	mov    $0x1b,%eax
     fa2:	cd 40                	int    $0x40
     fa4:	c3                   	ret    

00000fa5 <deleteTimer>:
SYSCALL(deleteTimer)
     fa5:	b8 1c 00 00 00       	mov    $0x1c,%eax
     faa:	cd 40                	int    $0x40
     fac:	c3                   	ret    

00000fad <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     fad:	55                   	push   %ebp
     fae:	89 e5                	mov    %esp,%ebp
     fb0:	83 ec 18             	sub    $0x18,%esp
     fb3:	8b 45 0c             	mov    0xc(%ebp),%eax
     fb6:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     fb9:	83 ec 04             	sub    $0x4,%esp
     fbc:	6a 01                	push   $0x1
     fbe:	8d 45 f4             	lea    -0xc(%ebp),%eax
     fc1:	50                   	push   %eax
     fc2:	ff 75 08             	pushl  0x8(%ebp)
     fc5:	e8 2b ff ff ff       	call   ef5 <write>
     fca:	83 c4 10             	add    $0x10,%esp
}
     fcd:	90                   	nop
     fce:	c9                   	leave  
     fcf:	c3                   	ret    

00000fd0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     fd0:	55                   	push   %ebp
     fd1:	89 e5                	mov    %esp,%ebp
     fd3:	53                   	push   %ebx
     fd4:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     fd7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     fde:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     fe2:	74 17                	je     ffb <printint+0x2b>
     fe4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     fe8:	79 11                	jns    ffb <printint+0x2b>
    neg = 1;
     fea:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     ff1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ff4:	f7 d8                	neg    %eax
     ff6:	89 45 ec             	mov    %eax,-0x14(%ebp)
     ff9:	eb 06                	jmp    1001 <printint+0x31>
  } else {
    x = xx;
     ffb:	8b 45 0c             	mov    0xc(%ebp),%eax
     ffe:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1001:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1008:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    100b:	8d 41 01             	lea    0x1(%ecx),%eax
    100e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1011:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1014:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1017:	ba 00 00 00 00       	mov    $0x0,%edx
    101c:	f7 f3                	div    %ebx
    101e:	89 d0                	mov    %edx,%eax
    1020:	0f b6 80 30 3a 00 00 	movzbl 0x3a30(%eax),%eax
    1027:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    102b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    102e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1031:	ba 00 00 00 00       	mov    $0x0,%edx
    1036:	f7 f3                	div    %ebx
    1038:	89 45 ec             	mov    %eax,-0x14(%ebp)
    103b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    103f:	75 c7                	jne    1008 <printint+0x38>
  if(neg)
    1041:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1045:	74 2d                	je     1074 <printint+0xa4>
    buf[i++] = '-';
    1047:	8b 45 f4             	mov    -0xc(%ebp),%eax
    104a:	8d 50 01             	lea    0x1(%eax),%edx
    104d:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1050:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1055:	eb 1d                	jmp    1074 <printint+0xa4>
    putc(fd, buf[i]);
    1057:	8d 55 dc             	lea    -0x24(%ebp),%edx
    105a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    105d:	01 d0                	add    %edx,%eax
    105f:	0f b6 00             	movzbl (%eax),%eax
    1062:	0f be c0             	movsbl %al,%eax
    1065:	83 ec 08             	sub    $0x8,%esp
    1068:	50                   	push   %eax
    1069:	ff 75 08             	pushl  0x8(%ebp)
    106c:	e8 3c ff ff ff       	call   fad <putc>
    1071:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1074:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1078:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    107c:	79 d9                	jns    1057 <printint+0x87>
    putc(fd, buf[i]);
}
    107e:	90                   	nop
    107f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1082:	c9                   	leave  
    1083:	c3                   	ret    

00001084 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1084:	55                   	push   %ebp
    1085:	89 e5                	mov    %esp,%ebp
    1087:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    108a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1091:	8d 45 0c             	lea    0xc(%ebp),%eax
    1094:	83 c0 04             	add    $0x4,%eax
    1097:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    109a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    10a1:	e9 59 01 00 00       	jmp    11ff <printf+0x17b>
    c = fmt[i] & 0xff;
    10a6:	8b 55 0c             	mov    0xc(%ebp),%edx
    10a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10ac:	01 d0                	add    %edx,%eax
    10ae:	0f b6 00             	movzbl (%eax),%eax
    10b1:	0f be c0             	movsbl %al,%eax
    10b4:	25 ff 00 00 00       	and    $0xff,%eax
    10b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    10bc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10c0:	75 2c                	jne    10ee <printf+0x6a>
      if(c == '%'){
    10c2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    10c6:	75 0c                	jne    10d4 <printf+0x50>
        state = '%';
    10c8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    10cf:	e9 27 01 00 00       	jmp    11fb <printf+0x177>
      } else {
        putc(fd, c);
    10d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10d7:	0f be c0             	movsbl %al,%eax
    10da:	83 ec 08             	sub    $0x8,%esp
    10dd:	50                   	push   %eax
    10de:	ff 75 08             	pushl  0x8(%ebp)
    10e1:	e8 c7 fe ff ff       	call   fad <putc>
    10e6:	83 c4 10             	add    $0x10,%esp
    10e9:	e9 0d 01 00 00       	jmp    11fb <printf+0x177>
      }
    } else if(state == '%'){
    10ee:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    10f2:	0f 85 03 01 00 00    	jne    11fb <printf+0x177>
      if(c == 'd'){
    10f8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    10fc:	75 1e                	jne    111c <printf+0x98>
        printint(fd, *ap, 10, 1);
    10fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1101:	8b 00                	mov    (%eax),%eax
    1103:	6a 01                	push   $0x1
    1105:	6a 0a                	push   $0xa
    1107:	50                   	push   %eax
    1108:	ff 75 08             	pushl  0x8(%ebp)
    110b:	e8 c0 fe ff ff       	call   fd0 <printint>
    1110:	83 c4 10             	add    $0x10,%esp
        ap++;
    1113:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1117:	e9 d8 00 00 00       	jmp    11f4 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    111c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1120:	74 06                	je     1128 <printf+0xa4>
    1122:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1126:	75 1e                	jne    1146 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    1128:	8b 45 e8             	mov    -0x18(%ebp),%eax
    112b:	8b 00                	mov    (%eax),%eax
    112d:	6a 00                	push   $0x0
    112f:	6a 10                	push   $0x10
    1131:	50                   	push   %eax
    1132:	ff 75 08             	pushl  0x8(%ebp)
    1135:	e8 96 fe ff ff       	call   fd0 <printint>
    113a:	83 c4 10             	add    $0x10,%esp
        ap++;
    113d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1141:	e9 ae 00 00 00       	jmp    11f4 <printf+0x170>
      } else if(c == 's'){
    1146:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    114a:	75 43                	jne    118f <printf+0x10b>
        s = (char*)*ap;
    114c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    114f:	8b 00                	mov    (%eax),%eax
    1151:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1154:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1158:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    115c:	75 25                	jne    1183 <printf+0xff>
          s = "(null)";
    115e:	c7 45 f4 e0 30 00 00 	movl   $0x30e0,-0xc(%ebp)
        while(*s != 0){
    1165:	eb 1c                	jmp    1183 <printf+0xff>
          putc(fd, *s);
    1167:	8b 45 f4             	mov    -0xc(%ebp),%eax
    116a:	0f b6 00             	movzbl (%eax),%eax
    116d:	0f be c0             	movsbl %al,%eax
    1170:	83 ec 08             	sub    $0x8,%esp
    1173:	50                   	push   %eax
    1174:	ff 75 08             	pushl  0x8(%ebp)
    1177:	e8 31 fe ff ff       	call   fad <putc>
    117c:	83 c4 10             	add    $0x10,%esp
          s++;
    117f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1183:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1186:	0f b6 00             	movzbl (%eax),%eax
    1189:	84 c0                	test   %al,%al
    118b:	75 da                	jne    1167 <printf+0xe3>
    118d:	eb 65                	jmp    11f4 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    118f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1193:	75 1d                	jne    11b2 <printf+0x12e>
        putc(fd, *ap);
    1195:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1198:	8b 00                	mov    (%eax),%eax
    119a:	0f be c0             	movsbl %al,%eax
    119d:	83 ec 08             	sub    $0x8,%esp
    11a0:	50                   	push   %eax
    11a1:	ff 75 08             	pushl  0x8(%ebp)
    11a4:	e8 04 fe ff ff       	call   fad <putc>
    11a9:	83 c4 10             	add    $0x10,%esp
        ap++;
    11ac:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    11b0:	eb 42                	jmp    11f4 <printf+0x170>
      } else if(c == '%'){
    11b2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    11b6:	75 17                	jne    11cf <printf+0x14b>
        putc(fd, c);
    11b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11bb:	0f be c0             	movsbl %al,%eax
    11be:	83 ec 08             	sub    $0x8,%esp
    11c1:	50                   	push   %eax
    11c2:	ff 75 08             	pushl  0x8(%ebp)
    11c5:	e8 e3 fd ff ff       	call   fad <putc>
    11ca:	83 c4 10             	add    $0x10,%esp
    11cd:	eb 25                	jmp    11f4 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    11cf:	83 ec 08             	sub    $0x8,%esp
    11d2:	6a 25                	push   $0x25
    11d4:	ff 75 08             	pushl  0x8(%ebp)
    11d7:	e8 d1 fd ff ff       	call   fad <putc>
    11dc:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    11df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11e2:	0f be c0             	movsbl %al,%eax
    11e5:	83 ec 08             	sub    $0x8,%esp
    11e8:	50                   	push   %eax
    11e9:	ff 75 08             	pushl  0x8(%ebp)
    11ec:	e8 bc fd ff ff       	call   fad <putc>
    11f1:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    11f4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    11fb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    11ff:	8b 55 0c             	mov    0xc(%ebp),%edx
    1202:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1205:	01 d0                	add    %edx,%eax
    1207:	0f b6 00             	movzbl (%eax),%eax
    120a:	84 c0                	test   %al,%al
    120c:	0f 85 94 fe ff ff    	jne    10a6 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1212:	90                   	nop
    1213:	c9                   	leave  
    1214:	c3                   	ret    

00001215 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1215:	55                   	push   %ebp
    1216:	89 e5                	mov    %esp,%ebp
    1218:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    121b:	8b 45 08             	mov    0x8(%ebp),%eax
    121e:	83 e8 08             	sub    $0x8,%eax
    1221:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1224:	a1 0c 77 00 00       	mov    0x770c,%eax
    1229:	89 45 fc             	mov    %eax,-0x4(%ebp)
    122c:	eb 24                	jmp    1252 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    122e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1231:	8b 00                	mov    (%eax),%eax
    1233:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1236:	77 12                	ja     124a <free+0x35>
    1238:	8b 45 f8             	mov    -0x8(%ebp),%eax
    123b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    123e:	77 24                	ja     1264 <free+0x4f>
    1240:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1243:	8b 00                	mov    (%eax),%eax
    1245:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1248:	77 1a                	ja     1264 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    124a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    124d:	8b 00                	mov    (%eax),%eax
    124f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1252:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1255:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1258:	76 d4                	jbe    122e <free+0x19>
    125a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    125d:	8b 00                	mov    (%eax),%eax
    125f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1262:	76 ca                	jbe    122e <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1264:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1267:	8b 40 04             	mov    0x4(%eax),%eax
    126a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1271:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1274:	01 c2                	add    %eax,%edx
    1276:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1279:	8b 00                	mov    (%eax),%eax
    127b:	39 c2                	cmp    %eax,%edx
    127d:	75 24                	jne    12a3 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    127f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1282:	8b 50 04             	mov    0x4(%eax),%edx
    1285:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1288:	8b 00                	mov    (%eax),%eax
    128a:	8b 40 04             	mov    0x4(%eax),%eax
    128d:	01 c2                	add    %eax,%edx
    128f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1292:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1295:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1298:	8b 00                	mov    (%eax),%eax
    129a:	8b 10                	mov    (%eax),%edx
    129c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    129f:	89 10                	mov    %edx,(%eax)
    12a1:	eb 0a                	jmp    12ad <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    12a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12a6:	8b 10                	mov    (%eax),%edx
    12a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12ab:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    12ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12b0:	8b 40 04             	mov    0x4(%eax),%eax
    12b3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    12ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12bd:	01 d0                	add    %edx,%eax
    12bf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12c2:	75 20                	jne    12e4 <free+0xcf>
    p->s.size += bp->s.size;
    12c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12c7:	8b 50 04             	mov    0x4(%eax),%edx
    12ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12cd:	8b 40 04             	mov    0x4(%eax),%eax
    12d0:	01 c2                	add    %eax,%edx
    12d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12d5:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    12d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12db:	8b 10                	mov    (%eax),%edx
    12dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12e0:	89 10                	mov    %edx,(%eax)
    12e2:	eb 08                	jmp    12ec <free+0xd7>
  } else
    p->s.ptr = bp;
    12e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12e7:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12ea:	89 10                	mov    %edx,(%eax)
  freep = p;
    12ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ef:	a3 0c 77 00 00       	mov    %eax,0x770c
}
    12f4:	90                   	nop
    12f5:	c9                   	leave  
    12f6:	c3                   	ret    

000012f7 <morecore>:

static Header*
morecore(uint nu)
{
    12f7:	55                   	push   %ebp
    12f8:	89 e5                	mov    %esp,%ebp
    12fa:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    12fd:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1304:	77 07                	ja     130d <morecore+0x16>
    nu = 4096;
    1306:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    130d:	8b 45 08             	mov    0x8(%ebp),%eax
    1310:	c1 e0 03             	shl    $0x3,%eax
    1313:	83 ec 0c             	sub    $0xc,%esp
    1316:	50                   	push   %eax
    1317:	e8 41 fc ff ff       	call   f5d <sbrk>
    131c:	83 c4 10             	add    $0x10,%esp
    131f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1322:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1326:	75 07                	jne    132f <morecore+0x38>
    return 0;
    1328:	b8 00 00 00 00       	mov    $0x0,%eax
    132d:	eb 26                	jmp    1355 <morecore+0x5e>
  hp = (Header*)p;
    132f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1332:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1335:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1338:	8b 55 08             	mov    0x8(%ebp),%edx
    133b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    133e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1341:	83 c0 08             	add    $0x8,%eax
    1344:	83 ec 0c             	sub    $0xc,%esp
    1347:	50                   	push   %eax
    1348:	e8 c8 fe ff ff       	call   1215 <free>
    134d:	83 c4 10             	add    $0x10,%esp
  return freep;
    1350:	a1 0c 77 00 00       	mov    0x770c,%eax
}
    1355:	c9                   	leave  
    1356:	c3                   	ret    

00001357 <malloc>:

void*
malloc(uint nbytes)
{
    1357:	55                   	push   %ebp
    1358:	89 e5                	mov    %esp,%ebp
    135a:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    135d:	8b 45 08             	mov    0x8(%ebp),%eax
    1360:	83 c0 07             	add    $0x7,%eax
    1363:	c1 e8 03             	shr    $0x3,%eax
    1366:	83 c0 01             	add    $0x1,%eax
    1369:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    136c:	a1 0c 77 00 00       	mov    0x770c,%eax
    1371:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1374:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1378:	75 23                	jne    139d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    137a:	c7 45 f0 04 77 00 00 	movl   $0x7704,-0x10(%ebp)
    1381:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1384:	a3 0c 77 00 00       	mov    %eax,0x770c
    1389:	a1 0c 77 00 00       	mov    0x770c,%eax
    138e:	a3 04 77 00 00       	mov    %eax,0x7704
    base.s.size = 0;
    1393:	c7 05 08 77 00 00 00 	movl   $0x0,0x7708
    139a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    139d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13a0:	8b 00                	mov    (%eax),%eax
    13a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    13a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13a8:	8b 40 04             	mov    0x4(%eax),%eax
    13ab:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13ae:	72 4d                	jb     13fd <malloc+0xa6>
      if(p->s.size == nunits)
    13b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13b3:	8b 40 04             	mov    0x4(%eax),%eax
    13b6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13b9:	75 0c                	jne    13c7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    13bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13be:	8b 10                	mov    (%eax),%edx
    13c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13c3:	89 10                	mov    %edx,(%eax)
    13c5:	eb 26                	jmp    13ed <malloc+0x96>
      else {
        p->s.size -= nunits;
    13c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13ca:	8b 40 04             	mov    0x4(%eax),%eax
    13cd:	2b 45 ec             	sub    -0x14(%ebp),%eax
    13d0:	89 c2                	mov    %eax,%edx
    13d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13d5:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    13d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13db:	8b 40 04             	mov    0x4(%eax),%eax
    13de:	c1 e0 03             	shl    $0x3,%eax
    13e1:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    13e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13e7:	8b 55 ec             	mov    -0x14(%ebp),%edx
    13ea:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    13ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13f0:	a3 0c 77 00 00       	mov    %eax,0x770c
      return (void*)(p + 1);
    13f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f8:	83 c0 08             	add    $0x8,%eax
    13fb:	eb 3b                	jmp    1438 <malloc+0xe1>
    }
    if(p == freep)
    13fd:	a1 0c 77 00 00       	mov    0x770c,%eax
    1402:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1405:	75 1e                	jne    1425 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    1407:	83 ec 0c             	sub    $0xc,%esp
    140a:	ff 75 ec             	pushl  -0x14(%ebp)
    140d:	e8 e5 fe ff ff       	call   12f7 <morecore>
    1412:	83 c4 10             	add    $0x10,%esp
    1415:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1418:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    141c:	75 07                	jne    1425 <malloc+0xce>
        return 0;
    141e:	b8 00 00 00 00       	mov    $0x0,%eax
    1423:	eb 13                	jmp    1438 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1425:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1428:	89 45 f0             	mov    %eax,-0x10(%ebp)
    142b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    142e:	8b 00                	mov    (%eax),%eax
    1430:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1433:	e9 6d ff ff ff       	jmp    13a5 <malloc+0x4e>
}
    1438:	c9                   	leave  
    1439:	c3                   	ret    

0000143a <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    143a:	55                   	push   %ebp
    143b:	89 e5                	mov    %esp,%ebp
    143d:	83 ec 1c             	sub    $0x1c,%esp
    1440:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1443:	8b 55 10             	mov    0x10(%ebp),%edx
    1446:	8b 45 14             	mov    0x14(%ebp),%eax
    1449:	88 4d ec             	mov    %cl,-0x14(%ebp)
    144c:	88 55 e8             	mov    %dl,-0x18(%ebp)
    144f:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1452:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1456:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1459:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    145d:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1460:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1464:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1467:	8b 45 08             	mov    0x8(%ebp),%eax
    146a:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    146e:	66 89 10             	mov    %dx,(%eax)
    1471:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1475:	88 50 02             	mov    %dl,0x2(%eax)
}
    1478:	8b 45 08             	mov    0x8(%ebp),%eax
    147b:	c9                   	leave  
    147c:	c2 04 00             	ret    $0x4

0000147f <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
    147f:	55                   	push   %ebp
    1480:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
    1482:	8b 45 08             	mov    0x8(%ebp),%eax
    1485:	2b 45 10             	sub    0x10(%ebp),%eax
    1488:	89 c2                	mov    %eax,%edx
    148a:	8b 45 08             	mov    0x8(%ebp),%eax
    148d:	2b 45 10             	sub    0x10(%ebp),%eax
    1490:	0f af d0             	imul   %eax,%edx
    1493:	8b 45 0c             	mov    0xc(%ebp),%eax
    1496:	2b 45 14             	sub    0x14(%ebp),%eax
    1499:	89 c1                	mov    %eax,%ecx
    149b:	8b 45 0c             	mov    0xc(%ebp),%eax
    149e:	2b 45 14             	sub    0x14(%ebp),%eax
    14a1:	0f af c1             	imul   %ecx,%eax
    14a4:	01 d0                	add    %edx,%eax
}
    14a6:	5d                   	pop    %ebp
    14a7:	c3                   	ret    

000014a8 <abs_int>:

static inline int abs_int(int x)
{
    14a8:	55                   	push   %ebp
    14a9:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
    14ab:	8b 45 08             	mov    0x8(%ebp),%eax
    14ae:	99                   	cltd   
    14af:	89 d0                	mov    %edx,%eax
    14b1:	33 45 08             	xor    0x8(%ebp),%eax
    14b4:	29 d0                	sub    %edx,%eax
}
    14b6:	5d                   	pop    %ebp
    14b7:	c3                   	ret    

000014b8 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
    14b8:	55                   	push   %ebp
    14b9:	89 e5                	mov    %esp,%ebp
    if (x < 0)
    14bb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14bf:	79 07                	jns    14c8 <APGetIndex+0x10>
        return X_SMALLER;
    14c1:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    14c6:	eb 40                	jmp    1508 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
    14c8:	8b 45 08             	mov    0x8(%ebp),%eax
    14cb:	8b 00                	mov    (%eax),%eax
    14cd:	3b 45 0c             	cmp    0xc(%ebp),%eax
    14d0:	7f 07                	jg     14d9 <APGetIndex+0x21>
        return X_BIGGER;
    14d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14d7:	eb 2f                	jmp    1508 <APGetIndex+0x50>
    if (y < 0)
    14d9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    14dd:	79 07                	jns    14e6 <APGetIndex+0x2e>
        return Y_SMALLER;
    14df:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
    14e4:	eb 22                	jmp    1508 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
    14e6:	8b 45 08             	mov    0x8(%ebp),%eax
    14e9:	8b 40 04             	mov    0x4(%eax),%eax
    14ec:	3b 45 10             	cmp    0x10(%ebp),%eax
    14ef:	7f 07                	jg     14f8 <APGetIndex+0x40>
        return Y_BIGGER;
    14f1:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    14f6:	eb 10                	jmp    1508 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
    14f8:	8b 45 08             	mov    0x8(%ebp),%eax
    14fb:	8b 00                	mov    (%eax),%eax
    14fd:	0f af 45 10          	imul   0x10(%ebp),%eax
    1501:	89 c2                	mov    %eax,%edx
    1503:	8b 45 0c             	mov    0xc(%ebp),%eax
    1506:	01 d0                	add    %edx,%eax
}
    1508:	5d                   	pop    %ebp
    1509:	c3                   	ret    

0000150a <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
    150a:	55                   	push   %ebp
    150b:	89 e5                	mov    %esp,%ebp
    150d:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    1510:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    1517:	8b 45 cc             	mov    -0x34(%ebp),%eax
    151a:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
    151d:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
    1524:	83 ec 08             	sub    $0x8,%esp
    1527:	6a 00                	push   $0x0
    1529:	ff 75 0c             	pushl  0xc(%ebp)
    152c:	e8 e4 f9 ff ff       	call   f15 <open>
    1531:	83 c4 10             	add    $0x10,%esp
    1534:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
    1537:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    153b:	79 2e                	jns    156b <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
    153d:	83 ec 04             	sub    $0x4,%esp
    1540:	ff 75 0c             	pushl  0xc(%ebp)
    1543:	68 e7 30 00 00       	push   $0x30e7
    1548:	6a 01                	push   $0x1
    154a:	e8 35 fb ff ff       	call   1084 <printf>
    154f:	83 c4 10             	add    $0x10,%esp
        return bmp;
    1552:	8b 45 08             	mov    0x8(%ebp),%eax
    1555:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1558:	89 10                	mov    %edx,(%eax)
    155a:	8b 55 cc             	mov    -0x34(%ebp),%edx
    155d:	89 50 04             	mov    %edx,0x4(%eax)
    1560:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1563:	89 50 08             	mov    %edx,0x8(%eax)
    1566:	e9 d2 01 00 00       	jmp    173d <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    156b:	83 ec 04             	sub    $0x4,%esp
    156e:	6a 0e                	push   $0xe
    1570:	8d 45 ba             	lea    -0x46(%ebp),%eax
    1573:	50                   	push   %eax
    1574:	ff 75 ec             	pushl  -0x14(%ebp)
    1577:	e8 71 f9 ff ff       	call   eed <read>
    157c:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    157f:	83 ec 04             	sub    $0x4,%esp
    1582:	6a 28                	push   $0x28
    1584:	8d 45 92             	lea    -0x6e(%ebp),%eax
    1587:	50                   	push   %eax
    1588:	ff 75 ec             	pushl  -0x14(%ebp)
    158b:	e8 5d f9 ff ff       	call   eed <read>
    1590:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
    1593:	8b 45 96             	mov    -0x6a(%ebp),%eax
    1596:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
    1599:	8b 45 9a             	mov    -0x66(%ebp),%eax
    159c:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    159f:	8b 55 c8             	mov    -0x38(%ebp),%edx
    15a2:	8b 45 cc             	mov    -0x34(%ebp),%eax
    15a5:	0f af d0             	imul   %eax,%edx
    15a8:	89 d0                	mov    %edx,%eax
    15aa:	01 c0                	add    %eax,%eax
    15ac:	01 d0                	add    %edx,%eax
    15ae:	83 ec 0c             	sub    $0xc,%esp
    15b1:	50                   	push   %eax
    15b2:	e8 a0 fd ff ff       	call   1357 <malloc>
    15b7:	83 c4 10             	add    $0x10,%esp
    15ba:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
    15bd:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    15c1:	0f b7 c0             	movzwl %ax,%eax
    15c4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    15c7:	8b 55 c8             	mov    -0x38(%ebp),%edx
    15ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15cd:	0f af c2             	imul   %edx,%eax
    15d0:	83 c0 1f             	add    $0x1f,%eax
    15d3:	c1 e8 05             	shr    $0x5,%eax
    15d6:	c1 e0 02             	shl    $0x2,%eax
    15d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
    15dc:	8b 55 cc             	mov    -0x34(%ebp),%edx
    15df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15e2:	0f af c2             	imul   %edx,%eax
    15e5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    15e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    15eb:	83 ec 0c             	sub    $0xc,%esp
    15ee:	50                   	push   %eax
    15ef:	e8 63 fd ff ff       	call   1357 <malloc>
    15f4:	83 c4 10             	add    $0x10,%esp
    15f7:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    15fa:	83 ec 04             	sub    $0x4,%esp
    15fd:	ff 75 e0             	pushl  -0x20(%ebp)
    1600:	ff 75 dc             	pushl  -0x24(%ebp)
    1603:	ff 75 ec             	pushl  -0x14(%ebp)
    1606:	e8 e2 f8 ff ff       	call   eed <read>
    160b:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
    160e:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    1612:	66 c1 e8 03          	shr    $0x3,%ax
    1616:	0f b7 c0             	movzwl %ax,%eax
    1619:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
    161c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1623:	e9 e5 00 00 00       	jmp    170d <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
    1628:	8b 55 cc             	mov    -0x34(%ebp),%edx
    162b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162e:	29 c2                	sub    %eax,%edx
    1630:	89 d0                	mov    %edx,%eax
    1632:	8d 50 ff             	lea    -0x1(%eax),%edx
    1635:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1638:	0f af c2             	imul   %edx,%eax
    163b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
    163e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1645:	e9 b1 00 00 00       	jmp    16fb <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
    164a:	8b 55 d0             	mov    -0x30(%ebp),%edx
    164d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1650:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1653:	01 c8                	add    %ecx,%eax
    1655:	89 c1                	mov    %eax,%ecx
    1657:	89 c8                	mov    %ecx,%eax
    1659:	01 c0                	add    %eax,%eax
    165b:	01 c8                	add    %ecx,%eax
    165d:	01 c2                	add    %eax,%edx
    165f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1662:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1666:	89 c1                	mov    %eax,%ecx
    1668:	8b 45 d8             	mov    -0x28(%ebp),%eax
    166b:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    166f:	01 c1                	add    %eax,%ecx
    1671:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1674:	01 c8                	add    %ecx,%eax
    1676:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1679:	8b 45 dc             	mov    -0x24(%ebp),%eax
    167c:	01 c8                	add    %ecx,%eax
    167e:	0f b6 00             	movzbl (%eax),%eax
    1681:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
    1684:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1687:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    168a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    168d:	01 c8                	add    %ecx,%eax
    168f:	89 c1                	mov    %eax,%ecx
    1691:	89 c8                	mov    %ecx,%eax
    1693:	01 c0                	add    %eax,%eax
    1695:	01 c8                	add    %ecx,%eax
    1697:	01 c2                	add    %eax,%edx
    1699:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169c:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    16a0:	89 c1                	mov    %eax,%ecx
    16a2:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16a5:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    16a9:	01 c1                	add    %eax,%ecx
    16ab:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16ae:	01 c8                	add    %ecx,%eax
    16b0:	8d 48 fe             	lea    -0x2(%eax),%ecx
    16b3:	8b 45 dc             	mov    -0x24(%ebp),%eax
    16b6:	01 c8                	add    %ecx,%eax
    16b8:	0f b6 00             	movzbl (%eax),%eax
    16bb:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
    16be:	8b 55 d0             	mov    -0x30(%ebp),%edx
    16c1:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    16c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16c7:	01 c8                	add    %ecx,%eax
    16c9:	89 c1                	mov    %eax,%ecx
    16cb:	89 c8                	mov    %ecx,%eax
    16cd:	01 c0                	add    %eax,%eax
    16cf:	01 c8                	add    %ecx,%eax
    16d1:	01 c2                	add    %eax,%edx
    16d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d6:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    16da:	89 c1                	mov    %eax,%ecx
    16dc:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16df:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    16e3:	01 c1                	add    %eax,%ecx
    16e5:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16e8:	01 c8                	add    %ecx,%eax
    16ea:	8d 48 fd             	lea    -0x3(%eax),%ecx
    16ed:	8b 45 dc             	mov    -0x24(%ebp),%eax
    16f0:	01 c8                	add    %ecx,%eax
    16f2:	0f b6 00             	movzbl (%eax),%eax
    16f5:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    16f7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    16fb:	8b 55 c8             	mov    -0x38(%ebp),%edx
    16fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1701:	39 c2                	cmp    %eax,%edx
    1703:	0f 87 41 ff ff ff    	ja     164a <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    1709:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    170d:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1710:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1713:	39 c2                	cmp    %eax,%edx
    1715:	0f 87 0d ff ff ff    	ja     1628 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    171b:	83 ec 0c             	sub    $0xc,%esp
    171e:	ff 75 ec             	pushl  -0x14(%ebp)
    1721:	e8 d7 f7 ff ff       	call   efd <close>
    1726:	83 c4 10             	add    $0x10,%esp
    return bmp;
    1729:	8b 45 08             	mov    0x8(%ebp),%eax
    172c:	8b 55 c8             	mov    -0x38(%ebp),%edx
    172f:	89 10                	mov    %edx,(%eax)
    1731:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1734:	89 50 04             	mov    %edx,0x4(%eax)
    1737:	8b 55 d0             	mov    -0x30(%ebp),%edx
    173a:	89 50 08             	mov    %edx,0x8(%eax)
}
    173d:	8b 45 08             	mov    0x8(%ebp),%eax
    1740:	c9                   	leave  
    1741:	c2 04 00             	ret    $0x4

00001744 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    1744:	55                   	push   %ebp
    1745:	89 e5                	mov    %esp,%ebp
    1747:	53                   	push   %ebx
    1748:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    174b:	83 ec 0c             	sub    $0xc,%esp
    174e:	6a 1c                	push   $0x1c
    1750:	e8 02 fc ff ff       	call   1357 <malloc>
    1755:	83 c4 10             	add    $0x10,%esp
    1758:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    175b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175e:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    1765:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    1768:	8d 45 d8             	lea    -0x28(%ebp),%eax
    176b:	6a 0c                	push   $0xc
    176d:	6a 0c                	push   $0xc
    176f:	6a 0c                	push   $0xc
    1771:	50                   	push   %eax
    1772:	e8 c3 fc ff ff       	call   143a <RGB>
    1777:	83 c4 0c             	add    $0xc,%esp
    177a:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    177e:	66 89 43 13          	mov    %ax,0x13(%ebx)
    1782:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    1786:	88 43 15             	mov    %al,0x15(%ebx)
    1789:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    178f:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    1793:	66 89 48 10          	mov    %cx,0x10(%eax)
    1797:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    179b:	88 50 12             	mov    %dl,0x12(%eax)
    179e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17a4:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    17a8:	66 89 48 08          	mov    %cx,0x8(%eax)
    17ac:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    17b0:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    17b3:	8b 45 08             	mov    0x8(%ebp),%eax
    17b6:	89 c2                	mov    %eax,%edx
    17b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bb:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    17bd:	8b 45 0c             	mov    0xc(%ebp),%eax
    17c0:	89 c2                	mov    %eax,%edx
    17c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c5:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    17c8:	8b 55 10             	mov    0x10(%ebp),%edx
    17cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ce:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    17d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    17d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    17d7:	c9                   	leave  
    17d8:	c3                   	ret    

000017d9 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    17d9:	55                   	push   %ebp
    17da:	89 e5                	mov    %esp,%ebp
    17dc:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    17df:	8b 45 0c             	mov    0xc(%ebp),%eax
    17e2:	8b 50 08             	mov    0x8(%eax),%edx
    17e5:	89 55 f8             	mov    %edx,-0x8(%ebp)
    17e8:	8b 40 0c             	mov    0xc(%eax),%eax
    17eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    17ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    17f1:	8b 55 10             	mov    0x10(%ebp),%edx
    17f4:	89 50 08             	mov    %edx,0x8(%eax)
    17f7:	8b 55 14             	mov    0x14(%ebp),%edx
    17fa:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    17fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1800:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1803:	89 10                	mov    %edx,(%eax)
    1805:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1808:	89 50 04             	mov    %edx,0x4(%eax)
}
    180b:	8b 45 08             	mov    0x8(%ebp),%eax
    180e:	c9                   	leave  
    180f:	c2 04 00             	ret    $0x4

00001812 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    1812:	55                   	push   %ebp
    1813:	89 e5                	mov    %esp,%ebp
    1815:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    1818:	8b 45 0c             	mov    0xc(%ebp),%eax
    181b:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    181f:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1823:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1827:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    182a:	8b 45 0c             	mov    0xc(%ebp),%eax
    182d:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1831:	66 89 50 10          	mov    %dx,0x10(%eax)
    1835:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1839:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    183c:	8b 45 08             	mov    0x8(%ebp),%eax
    183f:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1843:	66 89 10             	mov    %dx,(%eax)
    1846:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    184a:	88 50 02             	mov    %dl,0x2(%eax)
}
    184d:	8b 45 08             	mov    0x8(%ebp),%eax
    1850:	c9                   	leave  
    1851:	c2 04 00             	ret    $0x4

00001854 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
    1854:	55                   	push   %ebp
    1855:	89 e5                	mov    %esp,%ebp
    1857:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
    185a:	8b 45 0c             	mov    0xc(%ebp),%eax
    185d:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1861:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1865:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1869:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
    186c:	8b 45 0c             	mov    0xc(%ebp),%eax
    186f:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1873:	66 89 50 13          	mov    %dx,0x13(%eax)
    1877:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    187b:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
    187e:	8b 45 08             	mov    0x8(%ebp),%eax
    1881:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1885:	66 89 10             	mov    %dx,(%eax)
    1888:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    188c:	88 50 02             	mov    %dl,0x2(%eax)
}
    188f:	8b 45 08             	mov    0x8(%ebp),%eax
    1892:	c9                   	leave  
    1893:	c2 04 00             	ret    $0x4

00001896 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    1896:	55                   	push   %ebp
    1897:	89 e5                	mov    %esp,%ebp
    1899:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    189c:	8b 45 08             	mov    0x8(%ebp),%eax
    189f:	8b 40 0c             	mov    0xc(%eax),%eax
    18a2:	89 c2                	mov    %eax,%edx
    18a4:	c1 ea 1f             	shr    $0x1f,%edx
    18a7:	01 d0                	add    %edx,%eax
    18a9:	d1 f8                	sar    %eax
    18ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    18ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b1:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    18b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    18b8:	8b 45 10             	mov    0x10(%ebp),%eax
    18bb:	2b 45 f4             	sub    -0xc(%ebp),%eax
    18be:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    18c1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    18c5:	0f 89 98 00 00 00    	jns    1963 <APDrawPoint+0xcd>
        i = 0;
    18cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    18d2:	e9 8c 00 00 00       	jmp    1963 <APDrawPoint+0xcd>
    {
        j = x - off;
    18d7:	8b 45 0c             	mov    0xc(%ebp),%eax
    18da:	2b 45 f4             	sub    -0xc(%ebp),%eax
    18dd:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    18e0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    18e4:	79 69                	jns    194f <APDrawPoint+0xb9>
            j = 0;
    18e6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    18ed:	eb 60                	jmp    194f <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    18ef:	ff 75 fc             	pushl  -0x4(%ebp)
    18f2:	ff 75 f8             	pushl  -0x8(%ebp)
    18f5:	ff 75 08             	pushl  0x8(%ebp)
    18f8:	e8 bb fb ff ff       	call   14b8 <APGetIndex>
    18fd:	83 c4 0c             	add    $0xc,%esp
    1900:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    1903:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    1907:	74 55                	je     195e <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    1909:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    190d:	74 67                	je     1976 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    190f:	ff 75 10             	pushl  0x10(%ebp)
    1912:	ff 75 0c             	pushl  0xc(%ebp)
    1915:	ff 75 fc             	pushl  -0x4(%ebp)
    1918:	ff 75 f8             	pushl  -0x8(%ebp)
    191b:	e8 5f fb ff ff       	call   147f <distance_2>
    1920:	83 c4 10             	add    $0x10,%esp
    1923:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1926:	7f 23                	jg     194b <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    1928:	8b 45 08             	mov    0x8(%ebp),%eax
    192b:	8b 48 18             	mov    0x18(%eax),%ecx
    192e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1931:	89 d0                	mov    %edx,%eax
    1933:	01 c0                	add    %eax,%eax
    1935:	01 d0                	add    %edx,%eax
    1937:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    193a:	8b 45 08             	mov    0x8(%ebp),%eax
    193d:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    1941:	66 89 0a             	mov    %cx,(%edx)
    1944:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1948:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    194b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    194f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1952:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1955:	01 d0                	add    %edx,%eax
    1957:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    195a:	7d 93                	jge    18ef <APDrawPoint+0x59>
    195c:	eb 01                	jmp    195f <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    195e:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    195f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1963:	8b 55 10             	mov    0x10(%ebp),%edx
    1966:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1969:	01 d0                	add    %edx,%eax
    196b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    196e:	0f 8d 63 ff ff ff    	jge    18d7 <APDrawPoint+0x41>
    1974:	eb 01                	jmp    1977 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1976:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    1977:	c9                   	leave  
    1978:	c3                   	ret    

00001979 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1979:	55                   	push   %ebp
    197a:	89 e5                	mov    %esp,%ebp
    197c:	53                   	push   %ebx
    197d:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1980:	8b 45 0c             	mov    0xc(%ebp),%eax
    1983:	3b 45 14             	cmp    0x14(%ebp),%eax
    1986:	0f 85 80 00 00 00    	jne    1a0c <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    198c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1990:	0f 88 9d 02 00 00    	js     1c33 <APDrawLine+0x2ba>
    1996:	8b 45 08             	mov    0x8(%ebp),%eax
    1999:	8b 00                	mov    (%eax),%eax
    199b:	3b 45 0c             	cmp    0xc(%ebp),%eax
    199e:	0f 8e 8f 02 00 00    	jle    1c33 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    19a4:	8b 45 10             	mov    0x10(%ebp),%eax
    19a7:	3b 45 18             	cmp    0x18(%ebp),%eax
    19aa:	7e 12                	jle    19be <APDrawLine+0x45>
        {
            int tmp = y2;
    19ac:	8b 45 18             	mov    0x18(%ebp),%eax
    19af:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    19b2:	8b 45 10             	mov    0x10(%ebp),%eax
    19b5:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    19b8:	8b 45 dc             	mov    -0x24(%ebp),%eax
    19bb:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    19be:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    19c2:	79 07                	jns    19cb <APDrawLine+0x52>
    19c4:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    19cb:	8b 45 08             	mov    0x8(%ebp),%eax
    19ce:	8b 40 04             	mov    0x4(%eax),%eax
    19d1:	3b 45 18             	cmp    0x18(%ebp),%eax
    19d4:	7d 0c                	jge    19e2 <APDrawLine+0x69>
    19d6:	8b 45 08             	mov    0x8(%ebp),%eax
    19d9:	8b 40 04             	mov    0x4(%eax),%eax
    19dc:	83 e8 01             	sub    $0x1,%eax
    19df:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    19e2:	8b 45 10             	mov    0x10(%ebp),%eax
    19e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    19e8:	eb 15                	jmp    19ff <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    19ea:	ff 75 f4             	pushl  -0xc(%ebp)
    19ed:	ff 75 0c             	pushl  0xc(%ebp)
    19f0:	ff 75 08             	pushl  0x8(%ebp)
    19f3:	e8 9e fe ff ff       	call   1896 <APDrawPoint>
    19f8:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    19fb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    19ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a02:	3b 45 18             	cmp    0x18(%ebp),%eax
    1a05:	7e e3                	jle    19ea <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    1a07:	e9 2b 02 00 00       	jmp    1c37 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1a0c:	8b 45 10             	mov    0x10(%ebp),%eax
    1a0f:	3b 45 18             	cmp    0x18(%ebp),%eax
    1a12:	75 7f                	jne    1a93 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    1a14:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1a18:	0f 88 18 02 00 00    	js     1c36 <APDrawLine+0x2bd>
    1a1e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a21:	8b 40 04             	mov    0x4(%eax),%eax
    1a24:	3b 45 10             	cmp    0x10(%ebp),%eax
    1a27:	0f 8e 09 02 00 00    	jle    1c36 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1a2d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a30:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a33:	7e 12                	jle    1a47 <APDrawLine+0xce>
        {
            int tmp = x2;
    1a35:	8b 45 14             	mov    0x14(%ebp),%eax
    1a38:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1a3b:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a3e:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1a41:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a44:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    1a47:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1a4b:	79 07                	jns    1a54 <APDrawLine+0xdb>
    1a4d:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1a54:	8b 45 08             	mov    0x8(%ebp),%eax
    1a57:	8b 00                	mov    (%eax),%eax
    1a59:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a5c:	7d 0b                	jge    1a69 <APDrawLine+0xf0>
    1a5e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a61:	8b 00                	mov    (%eax),%eax
    1a63:	83 e8 01             	sub    $0x1,%eax
    1a66:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1a69:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a6c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a6f:	eb 15                	jmp    1a86 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1a71:	ff 75 10             	pushl  0x10(%ebp)
    1a74:	ff 75 f0             	pushl  -0x10(%ebp)
    1a77:	ff 75 08             	pushl  0x8(%ebp)
    1a7a:	e8 17 fe ff ff       	call   1896 <APDrawPoint>
    1a7f:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1a82:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1a86:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a89:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a8c:	7e e3                	jle    1a71 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1a8e:	e9 a4 01 00 00       	jmp    1c37 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1a93:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1a9a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1aa1:	8b 45 0c             	mov    0xc(%ebp),%eax
    1aa4:	2b 45 14             	sub    0x14(%ebp),%eax
    1aa7:	50                   	push   %eax
    1aa8:	e8 fb f9 ff ff       	call   14a8 <abs_int>
    1aad:	83 c4 04             	add    $0x4,%esp
    1ab0:	89 c3                	mov    %eax,%ebx
    1ab2:	8b 45 10             	mov    0x10(%ebp),%eax
    1ab5:	2b 45 18             	sub    0x18(%ebp),%eax
    1ab8:	50                   	push   %eax
    1ab9:	e8 ea f9 ff ff       	call   14a8 <abs_int>
    1abe:	83 c4 04             	add    $0x4,%esp
    1ac1:	39 c3                	cmp    %eax,%ebx
    1ac3:	0f 8e b5 00 00 00    	jle    1b7e <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1ac9:	8b 45 10             	mov    0x10(%ebp),%eax
    1acc:	2b 45 18             	sub    0x18(%ebp),%eax
    1acf:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1ad2:	db 45 b0             	fildl  -0x50(%ebp)
    1ad5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ad8:	2b 45 14             	sub    0x14(%ebp),%eax
    1adb:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1ade:	db 45 b0             	fildl  -0x50(%ebp)
    1ae1:	de f9                	fdivrp %st,%st(1)
    1ae3:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1ae6:	8b 45 14             	mov    0x14(%ebp),%eax
    1ae9:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1aec:	7e 0e                	jle    1afc <APDrawLine+0x183>
        {
            s = x1;
    1aee:	8b 45 0c             	mov    0xc(%ebp),%eax
    1af1:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    1af4:	8b 45 14             	mov    0x14(%ebp),%eax
    1af7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1afa:	eb 0c                	jmp    1b08 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1afc:	8b 45 14             	mov    0x14(%ebp),%eax
    1aff:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1b02:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b05:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1b08:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b0c:	79 07                	jns    1b15 <APDrawLine+0x19c>
    1b0e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1b15:	8b 45 08             	mov    0x8(%ebp),%eax
    1b18:	8b 00                	mov    (%eax),%eax
    1b1a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1b1d:	7f 0b                	jg     1b2a <APDrawLine+0x1b1>
    1b1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b22:	8b 00                	mov    (%eax),%eax
    1b24:	83 e8 01             	sub    $0x1,%eax
    1b27:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1b2a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b2d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1b30:	eb 3f                	jmp    1b71 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1b32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b35:	2b 45 0c             	sub    0xc(%ebp),%eax
    1b38:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1b3b:	db 45 b0             	fildl  -0x50(%ebp)
    1b3e:	dc 4d d0             	fmull  -0x30(%ebp)
    1b41:	db 45 10             	fildl  0x10(%ebp)
    1b44:	de c1                	faddp  %st,%st(1)
    1b46:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1b49:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1b4d:	b4 0c                	mov    $0xc,%ah
    1b4f:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1b53:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1b56:	db 5d cc             	fistpl -0x34(%ebp)
    1b59:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1b5c:	ff 75 cc             	pushl  -0x34(%ebp)
    1b5f:	ff 75 e4             	pushl  -0x1c(%ebp)
    1b62:	ff 75 08             	pushl  0x8(%ebp)
    1b65:	e8 2c fd ff ff       	call   1896 <APDrawPoint>
    1b6a:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1b6d:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1b71:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b74:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1b77:	7e b9                	jle    1b32 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1b79:	e9 b9 00 00 00       	jmp    1c37 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1b7e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b81:	2b 45 14             	sub    0x14(%ebp),%eax
    1b84:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1b87:	db 45 b0             	fildl  -0x50(%ebp)
    1b8a:	8b 45 10             	mov    0x10(%ebp),%eax
    1b8d:	2b 45 18             	sub    0x18(%ebp),%eax
    1b90:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1b93:	db 45 b0             	fildl  -0x50(%ebp)
    1b96:	de f9                	fdivrp %st,%st(1)
    1b98:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1b9b:	8b 45 10             	mov    0x10(%ebp),%eax
    1b9e:	3b 45 18             	cmp    0x18(%ebp),%eax
    1ba1:	7e 0e                	jle    1bb1 <APDrawLine+0x238>
    {
        s = y2;
    1ba3:	8b 45 18             	mov    0x18(%ebp),%eax
    1ba6:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1ba9:	8b 45 10             	mov    0x10(%ebp),%eax
    1bac:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1baf:	eb 0c                	jmp    1bbd <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1bb1:	8b 45 10             	mov    0x10(%ebp),%eax
    1bb4:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1bb7:	8b 45 18             	mov    0x18(%ebp),%eax
    1bba:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1bbd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1bc1:	79 07                	jns    1bca <APDrawLine+0x251>
    1bc3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1bca:	8b 45 08             	mov    0x8(%ebp),%eax
    1bcd:	8b 40 04             	mov    0x4(%eax),%eax
    1bd0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1bd3:	7f 0c                	jg     1be1 <APDrawLine+0x268>
    1bd5:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd8:	8b 40 04             	mov    0x4(%eax),%eax
    1bdb:	83 e8 01             	sub    $0x1,%eax
    1bde:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1be1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1be4:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1be7:	eb 3f                	jmp    1c28 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1be9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bec:	2b 45 10             	sub    0x10(%ebp),%eax
    1bef:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1bf2:	db 45 b0             	fildl  -0x50(%ebp)
    1bf5:	dc 4d c0             	fmull  -0x40(%ebp)
    1bf8:	db 45 0c             	fildl  0xc(%ebp)
    1bfb:	de c1                	faddp  %st,%st(1)
    1bfd:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1c00:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1c04:	b4 0c                	mov    $0xc,%ah
    1c06:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1c0a:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1c0d:	db 5d bc             	fistpl -0x44(%ebp)
    1c10:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1c13:	ff 75 e0             	pushl  -0x20(%ebp)
    1c16:	ff 75 bc             	pushl  -0x44(%ebp)
    1c19:	ff 75 08             	pushl  0x8(%ebp)
    1c1c:	e8 75 fc ff ff       	call   1896 <APDrawPoint>
    1c21:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1c24:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1c28:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c2b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1c2e:	7e b9                	jle    1be9 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1c30:	90                   	nop
    1c31:	eb 04                	jmp    1c37 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1c33:	90                   	nop
    1c34:	eb 01                	jmp    1c37 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1c36:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1c37:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1c3a:	c9                   	leave  
    1c3b:	c3                   	ret    

00001c3c <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1c3c:	55                   	push   %ebp
    1c3d:	89 e5                	mov    %esp,%ebp
    1c3f:	53                   	push   %ebx
    1c40:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1c43:	8b 55 10             	mov    0x10(%ebp),%edx
    1c46:	8b 45 18             	mov    0x18(%ebp),%eax
    1c49:	01 d0                	add    %edx,%eax
    1c4b:	83 e8 01             	sub    $0x1,%eax
    1c4e:	83 ec 04             	sub    $0x4,%esp
    1c51:	50                   	push   %eax
    1c52:	ff 75 0c             	pushl  0xc(%ebp)
    1c55:	ff 75 10             	pushl  0x10(%ebp)
    1c58:	ff 75 0c             	pushl  0xc(%ebp)
    1c5b:	ff 75 08             	pushl  0x8(%ebp)
    1c5e:	e8 16 fd ff ff       	call   1979 <APDrawLine>
    1c63:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1c66:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c69:	8b 45 14             	mov    0x14(%ebp),%eax
    1c6c:	01 d0                	add    %edx,%eax
    1c6e:	83 e8 01             	sub    $0x1,%eax
    1c71:	83 ec 04             	sub    $0x4,%esp
    1c74:	ff 75 10             	pushl  0x10(%ebp)
    1c77:	50                   	push   %eax
    1c78:	ff 75 10             	pushl  0x10(%ebp)
    1c7b:	ff 75 0c             	pushl  0xc(%ebp)
    1c7e:	ff 75 08             	pushl  0x8(%ebp)
    1c81:	e8 f3 fc ff ff       	call   1979 <APDrawLine>
    1c86:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1c89:	8b 55 10             	mov    0x10(%ebp),%edx
    1c8c:	8b 45 18             	mov    0x18(%ebp),%eax
    1c8f:	01 d0                	add    %edx,%eax
    1c91:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1c94:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c97:	8b 45 14             	mov    0x14(%ebp),%eax
    1c9a:	01 d0                	add    %edx,%eax
    1c9c:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c9f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1ca2:	8b 45 14             	mov    0x14(%ebp),%eax
    1ca5:	01 d8                	add    %ebx,%eax
    1ca7:	83 e8 01             	sub    $0x1,%eax
    1caa:	83 ec 04             	sub    $0x4,%esp
    1cad:	51                   	push   %ecx
    1cae:	52                   	push   %edx
    1caf:	ff 75 10             	pushl  0x10(%ebp)
    1cb2:	50                   	push   %eax
    1cb3:	ff 75 08             	pushl  0x8(%ebp)
    1cb6:	e8 be fc ff ff       	call   1979 <APDrawLine>
    1cbb:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1cbe:	8b 55 10             	mov    0x10(%ebp),%edx
    1cc1:	8b 45 18             	mov    0x18(%ebp),%eax
    1cc4:	01 d0                	add    %edx,%eax
    1cc6:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1cc9:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ccc:	8b 45 14             	mov    0x14(%ebp),%eax
    1ccf:	01 d0                	add    %edx,%eax
    1cd1:	8d 50 ff             	lea    -0x1(%eax),%edx
    1cd4:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1cd7:	8b 45 18             	mov    0x18(%ebp),%eax
    1cda:	01 d8                	add    %ebx,%eax
    1cdc:	83 e8 01             	sub    $0x1,%eax
    1cdf:	83 ec 04             	sub    $0x4,%esp
    1ce2:	51                   	push   %ecx
    1ce3:	52                   	push   %edx
    1ce4:	50                   	push   %eax
    1ce5:	ff 75 0c             	pushl  0xc(%ebp)
    1ce8:	ff 75 08             	pushl  0x8(%ebp)
    1ceb:	e8 89 fc ff ff       	call   1979 <APDrawLine>
    1cf0:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1cf3:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cf6:	8b 45 14             	mov    0x14(%ebp),%eax
    1cf9:	01 d0                	add    %edx,%eax
    1cfb:	8d 50 ff             	lea    -0x1(%eax),%edx
    1cfe:	8b 45 08             	mov    0x8(%ebp),%eax
    1d01:	8b 40 0c             	mov    0xc(%eax),%eax
    1d04:	89 c1                	mov    %eax,%ecx
    1d06:	c1 e9 1f             	shr    $0x1f,%ecx
    1d09:	01 c8                	add    %ecx,%eax
    1d0b:	d1 f8                	sar    %eax
    1d0d:	29 c2                	sub    %eax,%edx
    1d0f:	89 d0                	mov    %edx,%eax
    1d11:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1d14:	8b 55 10             	mov    0x10(%ebp),%edx
    1d17:	8b 45 18             	mov    0x18(%ebp),%eax
    1d1a:	01 d0                	add    %edx,%eax
    1d1c:	8d 50 ff             	lea    -0x1(%eax),%edx
    1d1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d22:	8b 40 0c             	mov    0xc(%eax),%eax
    1d25:	89 c1                	mov    %eax,%ecx
    1d27:	c1 e9 1f             	shr    $0x1f,%ecx
    1d2a:	01 c8                	add    %ecx,%eax
    1d2c:	d1 f8                	sar    %eax
    1d2e:	29 c2                	sub    %eax,%edx
    1d30:	89 d0                	mov    %edx,%eax
    1d32:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1d35:	8b 45 08             	mov    0x8(%ebp),%eax
    1d38:	8b 40 0c             	mov    0xc(%eax),%eax
    1d3b:	89 c2                	mov    %eax,%edx
    1d3d:	c1 ea 1f             	shr    $0x1f,%edx
    1d40:	01 d0                	add    %edx,%eax
    1d42:	d1 f8                	sar    %eax
    1d44:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1d47:	8b 45 08             	mov    0x8(%ebp),%eax
    1d4a:	8b 40 0c             	mov    0xc(%eax),%eax
    1d4d:	89 c2                	mov    %eax,%edx
    1d4f:	c1 ea 1f             	shr    $0x1f,%edx
    1d52:	01 d0                	add    %edx,%eax
    1d54:	d1 f8                	sar    %eax
    1d56:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1d59:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d5d:	0f 88 d8 00 00 00    	js     1e3b <APDrawRect+0x1ff>
    1d63:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d67:	0f 88 ce 00 00 00    	js     1e3b <APDrawRect+0x1ff>
    1d6d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d70:	8b 00                	mov    (%eax),%eax
    1d72:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1d75:	0f 8e c0 00 00 00    	jle    1e3b <APDrawRect+0x1ff>
    1d7b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7e:	8b 40 04             	mov    0x4(%eax),%eax
    1d81:	3b 45 10             	cmp    0x10(%ebp),%eax
    1d84:	0f 8e b1 00 00 00    	jle    1e3b <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1d8a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1d8e:	79 07                	jns    1d97 <APDrawRect+0x15b>
    1d90:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1d97:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1d9b:	79 07                	jns    1da4 <APDrawRect+0x168>
    1d9d:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1da4:	8b 45 08             	mov    0x8(%ebp),%eax
    1da7:	8b 00                	mov    (%eax),%eax
    1da9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1dac:	7f 0b                	jg     1db9 <APDrawRect+0x17d>
    1dae:	8b 45 08             	mov    0x8(%ebp),%eax
    1db1:	8b 00                	mov    (%eax),%eax
    1db3:	83 e8 01             	sub    $0x1,%eax
    1db6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1db9:	8b 45 08             	mov    0x8(%ebp),%eax
    1dbc:	8b 40 04             	mov    0x4(%eax),%eax
    1dbf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1dc2:	7f 0c                	jg     1dd0 <APDrawRect+0x194>
    1dc4:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc7:	8b 40 04             	mov    0x4(%eax),%eax
    1dca:	83 e8 01             	sub    $0x1,%eax
    1dcd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1dd0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
    1dda:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1ddd:	eb 52                	jmp    1e31 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1ddf:	8b 45 10             	mov    0x10(%ebp),%eax
    1de2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1de5:	eb 3e                	jmp    1e25 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1de7:	83 ec 04             	sub    $0x4,%esp
    1dea:	ff 75 e8             	pushl  -0x18(%ebp)
    1ded:	ff 75 ec             	pushl  -0x14(%ebp)
    1df0:	ff 75 08             	pushl  0x8(%ebp)
    1df3:	e8 c0 f6 ff ff       	call   14b8 <APGetIndex>
    1df8:	83 c4 10             	add    $0x10,%esp
    1dfb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1dfe:	8b 45 08             	mov    0x8(%ebp),%eax
    1e01:	8b 48 18             	mov    0x18(%eax),%ecx
    1e04:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1e07:	89 d0                	mov    %edx,%eax
    1e09:	01 c0                	add    %eax,%eax
    1e0b:	01 d0                	add    %edx,%eax
    1e0d:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1e10:	8b 45 08             	mov    0x8(%ebp),%eax
    1e13:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1e17:	66 89 0a             	mov    %cx,(%edx)
    1e1a:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1e1e:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1e21:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1e25:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1e28:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1e2b:	7e ba                	jle    1de7 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1e2d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1e31:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e34:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1e37:	7e a6                	jle    1ddf <APDrawRect+0x1a3>
    1e39:	eb 01                	jmp    1e3c <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1e3b:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1e3c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1e3f:	c9                   	leave  
    1e40:	c3                   	ret    

00001e41 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1e41:	55                   	push   %ebp
    1e42:	89 e5                	mov    %esp,%ebp
    1e44:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    1e47:	83 ec 0c             	sub    $0xc,%esp
    1e4a:	ff 75 0c             	pushl  0xc(%ebp)
    1e4d:	e8 c1 ee ff ff       	call   d13 <strlen>
    1e52:	83 c4 10             	add    $0x10,%esp
    1e55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1e58:	8b 45 08             	mov    0x8(%ebp),%eax
    1e5b:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1e5f:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1e63:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1e67:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1e6a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1e71:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1e78:	e9 bc 00 00 00       	jmp    1f39 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1e7d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1e80:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e83:	01 d0                	add    %edx,%eax
    1e85:	0f b6 00             	movzbl (%eax),%eax
    1e88:	0f be c0             	movsbl %al,%eax
    1e8b:	83 e8 20             	sub    $0x20,%eax
    1e8e:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1e91:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1e95:	0f 87 9a 00 00 00    	ja     1f35 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1e9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e9e:	8b 00                	mov    (%eax),%eax
    1ea0:	0f af 45 14          	imul   0x14(%ebp),%eax
    1ea4:	89 c2                	mov    %eax,%edx
    1ea6:	8b 45 10             	mov    0x10(%ebp),%eax
    1ea9:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1eac:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1eaf:	89 d0                	mov    %edx,%eax
    1eb1:	c1 e0 03             	shl    $0x3,%eax
    1eb4:	01 d0                	add    %edx,%eax
    1eb6:	01 c8                	add    %ecx,%eax
    1eb8:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1ebb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1ec2:	eb 6b                	jmp    1f2f <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1ec4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1ecb:	eb 50                	jmp    1f1d <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    1ecd:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1ed0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1ed3:	89 d0                	mov    %edx,%eax
    1ed5:	c1 e0 03             	shl    $0x3,%eax
    1ed8:	01 d0                	add    %edx,%eax
    1eda:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    1ee0:	01 c2                	add    %eax,%edx
    1ee2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1ee5:	01 d0                	add    %edx,%eax
    1ee7:	05 60 3a 00 00       	add    $0x3a60,%eax
    1eec:	0f b6 00             	movzbl (%eax),%eax
    1eef:	84 c0                	test   %al,%al
    1ef1:	74 26                	je     1f19 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    1ef3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef6:	8b 50 18             	mov    0x18(%eax),%edx
    1ef9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1efc:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1eff:	01 c8                	add    %ecx,%eax
    1f01:	89 c1                	mov    %eax,%ecx
    1f03:	89 c8                	mov    %ecx,%eax
    1f05:	01 c0                	add    %eax,%eax
    1f07:	01 c8                	add    %ecx,%eax
    1f09:	01 d0                	add    %edx,%eax
    1f0b:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1f0f:	66 89 10             	mov    %dx,(%eax)
    1f12:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1f16:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1f19:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1f1d:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1f21:	7e aa                	jle    1ecd <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1f23:	8b 45 08             	mov    0x8(%ebp),%eax
    1f26:	8b 00                	mov    (%eax),%eax
    1f28:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1f2b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1f2f:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1f33:	7e 8f                	jle    1ec4 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    1f35:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1f39:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f3c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1f3f:	0f 82 38 ff ff ff    	jb     1e7d <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1f45:	90                   	nop
    1f46:	c9                   	leave  
    1f47:	c3                   	ret    

00001f48 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1f48:	55                   	push   %ebp
    1f49:	89 e5                	mov    %esp,%ebp
    1f4b:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1f4e:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1f52:	0f 88 8e 01 00 00    	js     20e6 <APDcCopy+0x19e>
    1f58:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1f5c:	0f 88 84 01 00 00    	js     20e6 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1f62:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f65:	8b 45 20             	mov    0x20(%ebp),%eax
    1f68:	01 d0                	add    %edx,%eax
    1f6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1f6d:	8b 55 10             	mov    0x10(%ebp),%edx
    1f70:	8b 45 24             	mov    0x24(%ebp),%eax
    1f73:	01 d0                	add    %edx,%eax
    1f75:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1f78:	8b 55 18             	mov    0x18(%ebp),%edx
    1f7b:	8b 45 20             	mov    0x20(%ebp),%eax
    1f7e:	01 d0                	add    %edx,%eax
    1f80:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1f83:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1f86:	8b 45 24             	mov    0x24(%ebp),%eax
    1f89:	01 d0                	add    %edx,%eax
    1f8b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1f8e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1f92:	0f 88 51 01 00 00    	js     20e9 <APDcCopy+0x1a1>
    1f98:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1f9c:	0f 88 47 01 00 00    	js     20e9 <APDcCopy+0x1a1>
    1fa2:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1fa6:	0f 88 3d 01 00 00    	js     20e9 <APDcCopy+0x1a1>
    1fac:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1fb0:	0f 88 33 01 00 00    	js     20e9 <APDcCopy+0x1a1>
    1fb6:	8b 45 14             	mov    0x14(%ebp),%eax
    1fb9:	8b 00                	mov    (%eax),%eax
    1fbb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1fbe:	0f 8c 25 01 00 00    	jl     20e9 <APDcCopy+0x1a1>
    1fc4:	8b 45 14             	mov    0x14(%ebp),%eax
    1fc7:	8b 40 04             	mov    0x4(%eax),%eax
    1fca:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1fcd:	0f 8c 16 01 00 00    	jl     20e9 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1fd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1fd6:	8b 00                	mov    (%eax),%eax
    1fd8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1fdb:	7f 0b                	jg     1fe8 <APDcCopy+0xa0>
    1fdd:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe0:	8b 00                	mov    (%eax),%eax
    1fe2:	83 e8 01             	sub    $0x1,%eax
    1fe5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1fe8:	8b 45 08             	mov    0x8(%ebp),%eax
    1feb:	8b 40 04             	mov    0x4(%eax),%eax
    1fee:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1ff1:	7f 0c                	jg     1fff <APDcCopy+0xb7>
    1ff3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ff6:	8b 40 04             	mov    0x4(%eax),%eax
    1ff9:	83 e8 01             	sub    $0x1,%eax
    1ffc:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1fff:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    2006:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    200d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2014:	e9 bc 00 00 00       	jmp    20d5 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    2019:	8b 45 08             	mov    0x8(%ebp),%eax
    201c:	8b 00                	mov    (%eax),%eax
    201e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2021:	8b 55 10             	mov    0x10(%ebp),%edx
    2024:	01 ca                	add    %ecx,%edx
    2026:	0f af d0             	imul   %eax,%edx
    2029:	8b 45 0c             	mov    0xc(%ebp),%eax
    202c:	01 d0                	add    %edx,%eax
    202e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    2031:	8b 45 14             	mov    0x14(%ebp),%eax
    2034:	8b 00                	mov    (%eax),%eax
    2036:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2039:	8b 55 1c             	mov    0x1c(%ebp),%edx
    203c:	01 ca                	add    %ecx,%edx
    203e:	0f af d0             	imul   %eax,%edx
    2041:	8b 45 18             	mov    0x18(%ebp),%eax
    2044:	01 d0                	add    %edx,%eax
    2046:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    2049:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2050:	eb 74                	jmp    20c6 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    2052:	8b 45 14             	mov    0x14(%ebp),%eax
    2055:	8b 50 18             	mov    0x18(%eax),%edx
    2058:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    205b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    205e:	01 c8                	add    %ecx,%eax
    2060:	89 c1                	mov    %eax,%ecx
    2062:	89 c8                	mov    %ecx,%eax
    2064:	01 c0                	add    %eax,%eax
    2066:	01 c8                	add    %ecx,%eax
    2068:	01 d0                	add    %edx,%eax
    206a:	0f b7 10             	movzwl (%eax),%edx
    206d:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    2071:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    2075:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    2078:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    207c:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    2080:	38 c2                	cmp    %al,%dl
    2082:	75 18                	jne    209c <APDcCopy+0x154>
    2084:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    2088:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    208c:	38 c2                	cmp    %al,%dl
    208e:	75 0c                	jne    209c <APDcCopy+0x154>
    2090:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    2094:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    2098:	38 c2                	cmp    %al,%dl
    209a:	74 26                	je     20c2 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    209c:	8b 45 08             	mov    0x8(%ebp),%eax
    209f:	8b 50 18             	mov    0x18(%eax),%edx
    20a2:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    20a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20a8:	01 c8                	add    %ecx,%eax
    20aa:	89 c1                	mov    %eax,%ecx
    20ac:	89 c8                	mov    %ecx,%eax
    20ae:	01 c0                	add    %eax,%eax
    20b0:	01 c8                	add    %ecx,%eax
    20b2:	01 d0                	add    %edx,%eax
    20b4:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    20b8:	66 89 10             	mov    %dx,(%eax)
    20bb:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    20bf:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    20c2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    20c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    20c9:	2b 45 0c             	sub    0xc(%ebp),%eax
    20cc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    20cf:	7d 81                	jge    2052 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    20d1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    20d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20d8:	2b 45 10             	sub    0x10(%ebp),%eax
    20db:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    20de:	0f 8d 35 ff ff ff    	jge    2019 <APDcCopy+0xd1>
    20e4:	eb 04                	jmp    20ea <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    20e6:	90                   	nop
    20e7:	eb 01                	jmp    20ea <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    20e9:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    20ea:	c9                   	leave  
    20eb:	c3                   	ret    

000020ec <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    20ec:	55                   	push   %ebp
    20ed:	89 e5                	mov    %esp,%ebp
    20ef:	83 ec 1c             	sub    $0x1c,%esp
    20f2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    20f5:	8b 55 10             	mov    0x10(%ebp),%edx
    20f8:	8b 45 14             	mov    0x14(%ebp),%eax
    20fb:	88 4d ec             	mov    %cl,-0x14(%ebp)
    20fe:	88 55 e8             	mov    %dl,-0x18(%ebp)
    2101:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    2104:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    2108:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    210b:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    210f:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    2112:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    2116:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    2119:	8b 45 08             	mov    0x8(%ebp),%eax
    211c:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    2120:	66 89 10             	mov    %dx,(%eax)
    2123:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    2127:	88 50 02             	mov    %dl,0x2(%eax)
}
    212a:	8b 45 08             	mov    0x8(%ebp),%eax
    212d:	c9                   	leave  
    212e:	c2 04 00             	ret    $0x4

00002131 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    2131:	55                   	push   %ebp
    2132:	89 e5                	mov    %esp,%ebp
    2134:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    2137:	8b 45 08             	mov    0x8(%ebp),%eax
    213a:	8b 00                	mov    (%eax),%eax
    213c:	83 ec 08             	sub    $0x8,%esp
    213f:	8d 55 0c             	lea    0xc(%ebp),%edx
    2142:	52                   	push   %edx
    2143:	50                   	push   %eax
    2144:	e8 34 ee ff ff       	call   f7d <sendMessage>
    2149:	83 c4 10             	add    $0x10,%esp
}
    214c:	90                   	nop
    214d:	c9                   	leave  
    214e:	c3                   	ret    

0000214f <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    214f:	55                   	push   %ebp
    2150:	89 e5                	mov    %esp,%ebp
    2152:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    2155:	83 ec 0c             	sub    $0xc,%esp
    2158:	68 98 00 00 00       	push   $0x98
    215d:	e8 f5 f1 ff ff       	call   1357 <malloc>
    2162:	83 c4 10             	add    $0x10,%esp
    2165:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    2168:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    216c:	75 15                	jne    2183 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    216e:	83 ec 04             	sub    $0x4,%esp
    2171:	ff 75 08             	pushl  0x8(%ebp)
    2174:	68 f8 30 00 00       	push   $0x30f8
    2179:	6a 01                	push   $0x1
    217b:	e8 04 ef ff ff       	call   1084 <printf>
    2180:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    2183:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2186:	05 84 00 00 00       	add    $0x84,%eax
    218b:	83 ec 08             	sub    $0x8,%esp
    218e:	ff 75 08             	pushl  0x8(%ebp)
    2191:	50                   	push   %eax
    2192:	e8 0d eb ff ff       	call   ca4 <strcpy>
    2197:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    219a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    219d:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    21a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21a7:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    21ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21b1:	8b 40 3c             	mov    0x3c(%eax),%eax
    21b4:	89 c2                	mov    %eax,%edx
    21b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21b9:	8b 40 40             	mov    0x40(%eax),%eax
    21bc:	0f af d0             	imul   %eax,%edx
    21bf:	89 d0                	mov    %edx,%eax
    21c1:	01 c0                	add    %eax,%eax
    21c3:	01 d0                	add    %edx,%eax
    21c5:	83 ec 0c             	sub    $0xc,%esp
    21c8:	50                   	push   %eax
    21c9:	e8 89 f1 ff ff       	call   1357 <malloc>
    21ce:	83 c4 10             	add    $0x10,%esp
    21d1:	89 c2                	mov    %eax,%edx
    21d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21d6:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    21d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21dc:	8b 40 54             	mov    0x54(%eax),%eax
    21df:	85 c0                	test   %eax,%eax
    21e1:	75 15                	jne    21f8 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    21e3:	83 ec 04             	sub    $0x4,%esp
    21e6:	ff 75 08             	pushl  0x8(%ebp)
    21e9:	68 18 31 00 00       	push   $0x3118
    21ee:	6a 01                	push   $0x1
    21f0:	e8 8f ee ff ff       	call   1084 <printf>
    21f5:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    21f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21fb:	8b 40 3c             	mov    0x3c(%eax),%eax
    21fe:	89 c2                	mov    %eax,%edx
    2200:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2203:	8b 40 40             	mov    0x40(%eax),%eax
    2206:	0f af d0             	imul   %eax,%edx
    2209:	89 d0                	mov    %edx,%eax
    220b:	01 c0                	add    %eax,%eax
    220d:	01 c2                	add    %eax,%edx
    220f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2212:	8b 40 54             	mov    0x54(%eax),%eax
    2215:	83 ec 04             	sub    $0x4,%esp
    2218:	52                   	push   %edx
    2219:	68 ff ff ff 00       	push   $0xffffff
    221e:	50                   	push   %eax
    221f:	e8 16 eb ff ff       	call   d3a <memset>
    2224:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    2227:	8b 45 f4             	mov    -0xc(%ebp),%eax
    222a:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    2231:	e8 1f ed ff ff       	call   f55 <getpid>
    2236:	89 c2                	mov    %eax,%edx
    2238:	8b 45 f4             	mov    -0xc(%ebp),%eax
    223b:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    223e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2241:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    2248:	8b 45 f4             	mov    -0xc(%ebp),%eax
    224b:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    2252:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2255:	8b 40 58             	mov    0x58(%eax),%eax
    2258:	89 c2                	mov    %eax,%edx
    225a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    225d:	8b 40 5c             	mov    0x5c(%eax),%eax
    2260:	0f af d0             	imul   %eax,%edx
    2263:	89 d0                	mov    %edx,%eax
    2265:	01 c0                	add    %eax,%eax
    2267:	01 d0                	add    %edx,%eax
    2269:	83 ec 0c             	sub    $0xc,%esp
    226c:	50                   	push   %eax
    226d:	e8 e5 f0 ff ff       	call   1357 <malloc>
    2272:	83 c4 10             	add    $0x10,%esp
    2275:	89 c2                	mov    %eax,%edx
    2277:	8b 45 f4             	mov    -0xc(%ebp),%eax
    227a:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    227d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2280:	8b 40 70             	mov    0x70(%eax),%eax
    2283:	85 c0                	test   %eax,%eax
    2285:	75 15                	jne    229c <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    2287:	83 ec 04             	sub    $0x4,%esp
    228a:	ff 75 08             	pushl  0x8(%ebp)
    228d:	68 3c 31 00 00       	push   $0x313c
    2292:	6a 01                	push   $0x1
    2294:	e8 eb ed ff ff       	call   1084 <printf>
    2299:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    229c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    229f:	8b 40 3c             	mov    0x3c(%eax),%eax
    22a2:	89 c2                	mov    %eax,%edx
    22a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22a7:	8b 40 40             	mov    0x40(%eax),%eax
    22aa:	0f af d0             	imul   %eax,%edx
    22ad:	89 d0                	mov    %edx,%eax
    22af:	01 c0                	add    %eax,%eax
    22b1:	01 c2                	add    %eax,%edx
    22b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22b6:	8b 40 54             	mov    0x54(%eax),%eax
    22b9:	83 ec 04             	sub    $0x4,%esp
    22bc:	52                   	push   %edx
    22bd:	68 ff 00 00 00       	push   $0xff
    22c2:	50                   	push   %eax
    22c3:	e8 72 ea ff ff       	call   d3a <memset>
    22c8:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    22cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22ce:	8b 55 0c             	mov    0xc(%ebp),%edx
    22d1:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    22d4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    22d8:	74 49                	je     2323 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    22da:	8b 45 10             	mov    0x10(%ebp),%eax
    22dd:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    22e3:	83 ec 0c             	sub    $0xc,%esp
    22e6:	50                   	push   %eax
    22e7:	e8 6b f0 ff ff       	call   1357 <malloc>
    22ec:	83 c4 10             	add    $0x10,%esp
    22ef:	89 c2                	mov    %eax,%edx
    22f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22f4:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    22f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22fa:	8b 55 10             	mov    0x10(%ebp),%edx
    22fd:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    2300:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2303:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    230a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    230d:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    2314:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2317:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    231e:	e9 8d 00 00 00       	jmp    23b0 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    2323:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2326:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    232d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2330:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    2337:	8b 45 f4             	mov    -0xc(%ebp),%eax
    233a:	8b 40 20             	mov    0x20(%eax),%eax
    233d:	89 c2                	mov    %eax,%edx
    233f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2342:	8b 40 24             	mov    0x24(%eax),%eax
    2345:	0f af d0             	imul   %eax,%edx
    2348:	89 d0                	mov    %edx,%eax
    234a:	01 c0                	add    %eax,%eax
    234c:	01 d0                	add    %edx,%eax
    234e:	83 ec 0c             	sub    $0xc,%esp
    2351:	50                   	push   %eax
    2352:	e8 00 f0 ff ff       	call   1357 <malloc>
    2357:	83 c4 10             	add    $0x10,%esp
    235a:	89 c2                	mov    %eax,%edx
    235c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    235f:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    2362:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2365:	8b 40 38             	mov    0x38(%eax),%eax
    2368:	85 c0                	test   %eax,%eax
    236a:	75 15                	jne    2381 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    236c:	83 ec 04             	sub    $0x4,%esp
    236f:	ff 75 08             	pushl  0x8(%ebp)
    2372:	68 64 31 00 00       	push   $0x3164
    2377:	6a 01                	push   $0x1
    2379:	e8 06 ed ff ff       	call   1084 <printf>
    237e:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    2381:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2384:	8b 40 20             	mov    0x20(%eax),%eax
    2387:	89 c2                	mov    %eax,%edx
    2389:	8b 45 f4             	mov    -0xc(%ebp),%eax
    238c:	8b 40 24             	mov    0x24(%eax),%eax
    238f:	0f af d0             	imul   %eax,%edx
    2392:	89 d0                	mov    %edx,%eax
    2394:	01 c0                	add    %eax,%eax
    2396:	01 c2                	add    %eax,%edx
    2398:	8b 45 f4             	mov    -0xc(%ebp),%eax
    239b:	8b 40 38             	mov    0x38(%eax),%eax
    239e:	83 ec 04             	sub    $0x4,%esp
    23a1:	52                   	push   %edx
    23a2:	68 ff ff ff 00       	push   $0xffffff
    23a7:	50                   	push   %eax
    23a8:	e8 8d e9 ff ff       	call   d3a <memset>
    23ad:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    23b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    23b3:	c9                   	leave  
    23b4:	c3                   	ret    

000023b5 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    23b5:	55                   	push   %ebp
    23b6:	89 e5                	mov    %esp,%ebp
    23b8:	57                   	push   %edi
    23b9:	56                   	push   %esi
    23ba:	53                   	push   %ebx
    23bb:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    23be:	8b 45 0c             	mov    0xc(%ebp),%eax
    23c1:	83 f8 03             	cmp    $0x3,%eax
    23c4:	74 02                	je     23c8 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    23c6:	eb 7c                	jmp    2444 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    23c8:	8b 45 08             	mov    0x8(%ebp),%eax
    23cb:	8b 58 1c             	mov    0x1c(%eax),%ebx
    23ce:	8b 45 08             	mov    0x8(%ebp),%eax
    23d1:	8b 48 18             	mov    0x18(%eax),%ecx
    23d4:	8b 45 08             	mov    0x8(%ebp),%eax
    23d7:	8b 50 5c             	mov    0x5c(%eax),%edx
    23da:	8b 45 08             	mov    0x8(%ebp),%eax
    23dd:	8b 40 58             	mov    0x58(%eax),%eax
    23e0:	8b 75 08             	mov    0x8(%ebp),%esi
    23e3:	83 c6 58             	add    $0x58,%esi
    23e6:	83 ec 04             	sub    $0x4,%esp
    23e9:	53                   	push   %ebx
    23ea:	51                   	push   %ecx
    23eb:	6a 00                	push   $0x0
    23ed:	52                   	push   %edx
    23ee:	50                   	push   %eax
    23ef:	6a 00                	push   $0x0
    23f1:	6a 00                	push   $0x0
    23f3:	56                   	push   %esi
    23f4:	6a 00                	push   $0x0
    23f6:	6a 00                	push   $0x0
    23f8:	ff 75 08             	pushl  0x8(%ebp)
    23fb:	e8 75 eb ff ff       	call   f75 <paintWindow>
    2400:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    2403:	8b 45 08             	mov    0x8(%ebp),%eax
    2406:	8b 70 1c             	mov    0x1c(%eax),%esi
    2409:	8b 45 08             	mov    0x8(%ebp),%eax
    240c:	8b 58 18             	mov    0x18(%eax),%ebx
    240f:	8b 45 08             	mov    0x8(%ebp),%eax
    2412:	8b 48 08             	mov    0x8(%eax),%ecx
    2415:	8b 45 08             	mov    0x8(%ebp),%eax
    2418:	8b 50 40             	mov    0x40(%eax),%edx
    241b:	8b 45 08             	mov    0x8(%ebp),%eax
    241e:	8b 40 3c             	mov    0x3c(%eax),%eax
    2421:	8b 7d 08             	mov    0x8(%ebp),%edi
    2424:	83 c7 3c             	add    $0x3c,%edi
    2427:	83 ec 04             	sub    $0x4,%esp
    242a:	56                   	push   %esi
    242b:	53                   	push   %ebx
    242c:	51                   	push   %ecx
    242d:	52                   	push   %edx
    242e:	50                   	push   %eax
    242f:	6a 00                	push   $0x0
    2431:	6a 00                	push   $0x0
    2433:	57                   	push   %edi
    2434:	6a 32                	push   $0x32
    2436:	6a 00                	push   $0x0
    2438:	ff 75 08             	pushl  0x8(%ebp)
    243b:	e8 35 eb ff ff       	call   f75 <paintWindow>
    2440:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    2443:	90                   	nop
        default: break;
            
            
    }
    return False;
    2444:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2449:	8d 65 f4             	lea    -0xc(%ebp),%esp
    244c:	5b                   	pop    %ebx
    244d:	5e                   	pop    %esi
    244e:	5f                   	pop    %edi
    244f:	5d                   	pop    %ebp
    2450:	c3                   	ret    

00002451 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    2451:	55                   	push   %ebp
    2452:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    2454:	8b 45 0c             	mov    0xc(%ebp),%eax
    2457:	8b 50 08             	mov    0x8(%eax),%edx
    245a:	8b 45 08             	mov    0x8(%ebp),%eax
    245d:	8b 00                	mov    (%eax),%eax
    245f:	39 c2                	cmp    %eax,%edx
    2461:	74 07                	je     246a <APPreJudge+0x19>
        return False;
    2463:	b8 00 00 00 00       	mov    $0x0,%eax
    2468:	eb 05                	jmp    246f <APPreJudge+0x1e>
    return True;
    246a:	b8 01 00 00 00       	mov    $0x1,%eax
}
    246f:	5d                   	pop    %ebp
    2470:	c3                   	ret    

00002471 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    2471:	55                   	push   %ebp
    2472:	89 e5                	mov    %esp,%ebp
    2474:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    2477:	8b 45 08             	mov    0x8(%ebp),%eax
    247a:	8b 55 0c             	mov    0xc(%ebp),%edx
    247d:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    2483:	83 ec 0c             	sub    $0xc,%esp
    2486:	ff 75 08             	pushl  0x8(%ebp)
    2489:	e8 ff ea ff ff       	call   f8d <registWindow>
    248e:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    2491:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    2498:	8b 45 08             	mov    0x8(%ebp),%eax
    249b:	8b 00                	mov    (%eax),%eax
    249d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    24a0:	ff 75 f4             	pushl  -0xc(%ebp)
    24a3:	ff 75 f0             	pushl  -0x10(%ebp)
    24a6:	ff 75 ec             	pushl  -0x14(%ebp)
    24a9:	ff 75 08             	pushl  0x8(%ebp)
    24ac:	e8 80 fc ff ff       	call   2131 <APSendMessage>
    24b1:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    24b4:	83 ec 0c             	sub    $0xc,%esp
    24b7:	ff 75 08             	pushl  0x8(%ebp)
    24ba:	e8 c6 ea ff ff       	call   f85 <getMessage>
    24bf:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    24c2:	8b 45 08             	mov    0x8(%ebp),%eax
    24c5:	83 c0 74             	add    $0x74,%eax
    24c8:	83 ec 08             	sub    $0x8,%esp
    24cb:	50                   	push   %eax
    24cc:	ff 75 08             	pushl  0x8(%ebp)
    24cf:	e8 7d ff ff ff       	call   2451 <APPreJudge>
    24d4:	83 c4 10             	add    $0x10,%esp
    24d7:	84 c0                	test   %al,%al
    24d9:	74 1b                	je     24f6 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    24db:	8b 45 08             	mov    0x8(%ebp),%eax
    24de:	ff 70 7c             	pushl  0x7c(%eax)
    24e1:	ff 70 78             	pushl  0x78(%eax)
    24e4:	ff 70 74             	pushl  0x74(%eax)
    24e7:	ff 75 08             	pushl  0x8(%ebp)
    24ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    24ed:	ff d0                	call   *%eax
    24ef:	83 c4 10             	add    $0x10,%esp
    24f2:	84 c0                	test   %al,%al
    24f4:	75 0c                	jne    2502 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    24f6:	8b 45 08             	mov    0x8(%ebp),%eax
    24f9:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    2500:	eb b2                	jmp    24b4 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    2502:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    2503:	90                   	nop
    2504:	c9                   	leave  
    2505:	c3                   	ret    

00002506 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    2506:	55                   	push   %ebp
    2507:	89 e5                	mov    %esp,%ebp
    2509:	57                   	push   %edi
    250a:	56                   	push   %esi
    250b:	53                   	push   %ebx
    250c:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    250f:	a1 10 77 00 00       	mov    0x7710,%eax
    2514:	85 c0                	test   %eax,%eax
    2516:	0f 85 2c 02 00 00    	jne    2748 <APGridPaint+0x242>
    {
        iconReady = 1;
    251c:	c7 05 10 77 00 00 01 	movl   $0x1,0x7710
    2523:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    2526:	8d 45 88             	lea    -0x78(%ebp),%eax
    2529:	83 ec 08             	sub    $0x8,%esp
    252c:	68 8b 31 00 00       	push   $0x318b
    2531:	50                   	push   %eax
    2532:	e8 d3 ef ff ff       	call   150a <APLoadBitmap>
    2537:	83 c4 0c             	add    $0xc,%esp
    253a:	8b 45 88             	mov    -0x78(%ebp),%eax
    253d:	a3 34 77 00 00       	mov    %eax,0x7734
    2542:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2545:	a3 38 77 00 00       	mov    %eax,0x7738
    254a:	8b 45 90             	mov    -0x70(%ebp),%eax
    254d:	a3 3c 77 00 00       	mov    %eax,0x773c
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    2552:	83 ec 04             	sub    $0x4,%esp
    2555:	ff 35 3c 77 00 00    	pushl  0x773c
    255b:	ff 35 38 77 00 00    	pushl  0x7738
    2561:	ff 35 34 77 00 00    	pushl  0x7734
    2567:	e8 d8 f1 ff ff       	call   1744 <APCreateCompatibleDCFromBitmap>
    256c:	83 c4 10             	add    $0x10,%esp
    256f:	a3 40 77 00 00       	mov    %eax,0x7740
        grid_river = APLoadBitmap ("grid_river.bmp");
    2574:	8d 45 88             	lea    -0x78(%ebp),%eax
    2577:	83 ec 08             	sub    $0x8,%esp
    257a:	68 99 31 00 00       	push   $0x3199
    257f:	50                   	push   %eax
    2580:	e8 85 ef ff ff       	call   150a <APLoadBitmap>
    2585:	83 c4 0c             	add    $0xc,%esp
    2588:	8b 45 88             	mov    -0x78(%ebp),%eax
    258b:	a3 70 77 00 00       	mov    %eax,0x7770
    2590:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2593:	a3 74 77 00 00       	mov    %eax,0x7774
    2598:	8b 45 90             	mov    -0x70(%ebp),%eax
    259b:	a3 78 77 00 00       	mov    %eax,0x7778
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    25a0:	83 ec 04             	sub    $0x4,%esp
    25a3:	ff 35 78 77 00 00    	pushl  0x7778
    25a9:	ff 35 74 77 00 00    	pushl  0x7774
    25af:	ff 35 70 77 00 00    	pushl  0x7770
    25b5:	e8 8a f1 ff ff       	call   1744 <APCreateCompatibleDCFromBitmap>
    25ba:	83 c4 10             	add    $0x10,%esp
    25bd:	a3 60 77 00 00       	mov    %eax,0x7760
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    25c2:	8d 45 88             	lea    -0x78(%ebp),%eax
    25c5:	83 ec 08             	sub    $0x8,%esp
    25c8:	68 a8 31 00 00       	push   $0x31a8
    25cd:	50                   	push   %eax
    25ce:	e8 37 ef ff ff       	call   150a <APLoadBitmap>
    25d3:	83 c4 0c             	add    $0xc,%esp
    25d6:	8b 45 88             	mov    -0x78(%ebp),%eax
    25d9:	a3 64 77 00 00       	mov    %eax,0x7764
    25de:	8b 45 8c             	mov    -0x74(%ebp),%eax
    25e1:	a3 68 77 00 00       	mov    %eax,0x7768
    25e6:	8b 45 90             	mov    -0x70(%ebp),%eax
    25e9:	a3 6c 77 00 00       	mov    %eax,0x776c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    25ee:	83 ec 04             	sub    $0x4,%esp
    25f1:	ff 35 6c 77 00 00    	pushl  0x776c
    25f7:	ff 35 68 77 00 00    	pushl  0x7768
    25fd:	ff 35 64 77 00 00    	pushl  0x7764
    2603:	e8 3c f1 ff ff       	call   1744 <APCreateCompatibleDCFromBitmap>
    2608:	83 c4 10             	add    $0x10,%esp
    260b:	a3 14 77 00 00       	mov    %eax,0x7714
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    2610:	8d 45 88             	lea    -0x78(%ebp),%eax
    2613:	83 ec 08             	sub    $0x8,%esp
    2616:	68 b7 31 00 00       	push   $0x31b7
    261b:	50                   	push   %eax
    261c:	e8 e9 ee ff ff       	call   150a <APLoadBitmap>
    2621:	83 c4 0c             	add    $0xc,%esp
    2624:	8b 45 88             	mov    -0x78(%ebp),%eax
    2627:	a3 48 77 00 00       	mov    %eax,0x7748
    262c:	8b 45 8c             	mov    -0x74(%ebp),%eax
    262f:	a3 4c 77 00 00       	mov    %eax,0x774c
    2634:	8b 45 90             	mov    -0x70(%ebp),%eax
    2637:	a3 50 77 00 00       	mov    %eax,0x7750
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    263c:	83 ec 04             	sub    $0x4,%esp
    263f:	ff 35 50 77 00 00    	pushl  0x7750
    2645:	ff 35 4c 77 00 00    	pushl  0x774c
    264b:	ff 35 48 77 00 00    	pushl  0x7748
    2651:	e8 ee f0 ff ff       	call   1744 <APCreateCompatibleDCFromBitmap>
    2656:	83 c4 10             	add    $0x10,%esp
    2659:	a3 7c 77 00 00       	mov    %eax,0x777c
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    265e:	8d 45 88             	lea    -0x78(%ebp),%eax
    2661:	83 ec 08             	sub    $0x8,%esp
    2664:	68 c5 31 00 00       	push   $0x31c5
    2669:	50                   	push   %eax
    266a:	e8 9b ee ff ff       	call   150a <APLoadBitmap>
    266f:	83 c4 0c             	add    $0xc,%esp
    2672:	8b 45 88             	mov    -0x78(%ebp),%eax
    2675:	a3 24 77 00 00       	mov    %eax,0x7724
    267a:	8b 45 8c             	mov    -0x74(%ebp),%eax
    267d:	a3 28 77 00 00       	mov    %eax,0x7728
    2682:	8b 45 90             	mov    -0x70(%ebp),%eax
    2685:	a3 2c 77 00 00       	mov    %eax,0x772c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    268a:	83 ec 04             	sub    $0x4,%esp
    268d:	ff 35 2c 77 00 00    	pushl  0x772c
    2693:	ff 35 28 77 00 00    	pushl  0x7728
    2699:	ff 35 24 77 00 00    	pushl  0x7724
    269f:	e8 a0 f0 ff ff       	call   1744 <APCreateCompatibleDCFromBitmap>
    26a4:	83 c4 10             	add    $0x10,%esp
    26a7:	a3 44 77 00 00       	mov    %eax,0x7744
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    26ac:	8d 45 88             	lea    -0x78(%ebp),%eax
    26af:	83 ec 08             	sub    $0x8,%esp
    26b2:	68 d5 31 00 00       	push   $0x31d5
    26b7:	50                   	push   %eax
    26b8:	e8 4d ee ff ff       	call   150a <APLoadBitmap>
    26bd:	83 c4 0c             	add    $0xc,%esp
    26c0:	8b 45 88             	mov    -0x78(%ebp),%eax
    26c3:	a3 18 77 00 00       	mov    %eax,0x7718
    26c8:	8b 45 8c             	mov    -0x74(%ebp),%eax
    26cb:	a3 1c 77 00 00       	mov    %eax,0x771c
    26d0:	8b 45 90             	mov    -0x70(%ebp),%eax
    26d3:	a3 20 77 00 00       	mov    %eax,0x7720
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    26d8:	83 ec 04             	sub    $0x4,%esp
    26db:	ff 35 20 77 00 00    	pushl  0x7720
    26e1:	ff 35 1c 77 00 00    	pushl  0x771c
    26e7:	ff 35 18 77 00 00    	pushl  0x7718
    26ed:	e8 52 f0 ff ff       	call   1744 <APCreateCompatibleDCFromBitmap>
    26f2:	83 c4 10             	add    $0x10,%esp
    26f5:	a3 30 77 00 00       	mov    %eax,0x7730
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    26fa:	8d 45 88             	lea    -0x78(%ebp),%eax
    26fd:	83 ec 08             	sub    $0x8,%esp
    2700:	68 e7 31 00 00       	push   $0x31e7
    2705:	50                   	push   %eax
    2706:	e8 ff ed ff ff       	call   150a <APLoadBitmap>
    270b:	83 c4 0c             	add    $0xc,%esp
    270e:	8b 45 88             	mov    -0x78(%ebp),%eax
    2711:	a3 54 77 00 00       	mov    %eax,0x7754
    2716:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2719:	a3 58 77 00 00       	mov    %eax,0x7758
    271e:	8b 45 90             	mov    -0x70(%ebp),%eax
    2721:	a3 5c 77 00 00       	mov    %eax,0x775c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    2726:	83 ec 04             	sub    $0x4,%esp
    2729:	ff 35 5c 77 00 00    	pushl  0x775c
    272f:	ff 35 58 77 00 00    	pushl  0x7758
    2735:	ff 35 54 77 00 00    	pushl  0x7754
    273b:	e8 04 f0 ff ff       	call   1744 <APCreateCompatibleDCFromBitmap>
    2740:	83 c4 10             	add    $0x10,%esp
    2743:	a3 80 77 00 00       	mov    %eax,0x7780
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    2748:	8b 45 08             	mov    0x8(%ebp),%eax
    274b:	8b 40 08             	mov    0x8(%eax),%eax
    274e:	85 c0                	test   %eax,%eax
    2750:	75 17                	jne    2769 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    2752:	83 ec 08             	sub    $0x8,%esp
    2755:	68 f8 31 00 00       	push   $0x31f8
    275a:	6a 01                	push   $0x1
    275c:	e8 23 e9 ff ff       	call   1084 <printf>
    2761:	83 c4 10             	add    $0x10,%esp
        return;
    2764:	e9 07 05 00 00       	jmp    2c70 <APGridPaint+0x76a>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    2769:	8b 45 08             	mov    0x8(%ebp),%eax
    276c:	8b 40 10             	mov    0x10(%eax),%eax
    276f:	85 c0                	test   %eax,%eax
    2771:	7e 10                	jle    2783 <APGridPaint+0x27d>
    2773:	8b 45 08             	mov    0x8(%ebp),%eax
    2776:	8b 50 14             	mov    0x14(%eax),%edx
    2779:	8b 45 08             	mov    0x8(%ebp),%eax
    277c:	8b 40 10             	mov    0x10(%eax),%eax
    277f:	39 c2                	cmp    %eax,%edx
    2781:	7c 17                	jl     279a <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    2783:	83 ec 08             	sub    $0x8,%esp
    2786:	68 1e 32 00 00       	push   $0x321e
    278b:	6a 01                	push   $0x1
    278d:	e8 f2 e8 ff ff       	call   1084 <printf>
    2792:	83 c4 10             	add    $0x10,%esp
        return;
    2795:	e9 d6 04 00 00       	jmp    2c70 <APGridPaint+0x76a>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    279a:	8b 45 08             	mov    0x8(%ebp),%eax
    279d:	8b 40 14             	mov    0x14(%eax),%eax
    27a0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    27a6:	89 45 dc             	mov    %eax,-0x24(%ebp)
    27a9:	8b 45 dc             	mov    -0x24(%ebp),%eax
    27ac:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    27af:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    27b6:	e9 96 03 00 00       	jmp    2b51 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    27bb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    27c2:	e9 7c 03 00 00       	jmp    2b43 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    27c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    27ca:	c1 e0 04             	shl    $0x4,%eax
    27cd:	89 c2                	mov    %eax,%edx
    27cf:	8b 45 d8             	mov    -0x28(%ebp),%eax
    27d2:	01 c2                	add    %eax,%edx
    27d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    27d7:	01 d0                	add    %edx,%eax
    27d9:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    27dc:	8b 45 08             	mov    0x8(%ebp),%eax
    27df:	8b 40 0c             	mov    0xc(%eax),%eax
    27e2:	8b 55 dc             	mov    -0x24(%ebp),%edx
    27e5:	c1 e2 02             	shl    $0x2,%edx
    27e8:	01 d0                	add    %edx,%eax
    27ea:	8b 00                	mov    (%eax),%eax
    27ec:	83 f8 07             	cmp    $0x7,%eax
    27ef:	0f 87 49 03 00 00    	ja     2b3e <APGridPaint+0x638>
    27f5:	8b 04 85 34 32 00 00 	mov    0x3234(,%eax,4),%eax
    27fc:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    27fe:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    2801:	6a 0c                	push   $0xc
    2803:	6a 0c                	push   $0xc
    2805:	6a 0c                	push   $0xc
    2807:	50                   	push   %eax
    2808:	e8 df f8 ff ff       	call   20ec <RGB>
    280d:	83 c4 0c             	add    $0xc,%esp
    2810:	8b 1d 40 77 00 00    	mov    0x7740,%ebx
    2816:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2819:	6b c8 32             	imul   $0x32,%eax,%ecx
    281c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    281f:	6b c0 32             	imul   $0x32,%eax,%eax
    2822:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2825:	8b 45 08             	mov    0x8(%ebp),%eax
    2828:	8d 78 3c             	lea    0x3c(%eax),%edi
    282b:	83 ec 0c             	sub    $0xc,%esp
    282e:	83 ec 04             	sub    $0x4,%esp
    2831:	89 e0                	mov    %esp,%eax
    2833:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    2837:	66 89 30             	mov    %si,(%eax)
    283a:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    283e:	88 50 02             	mov    %dl,0x2(%eax)
    2841:	6a 32                	push   $0x32
    2843:	6a 32                	push   $0x32
    2845:	6a 00                	push   $0x0
    2847:	6a 00                	push   $0x0
    2849:	53                   	push   %ebx
    284a:	51                   	push   %ecx
    284b:	ff 75 84             	pushl  -0x7c(%ebp)
    284e:	57                   	push   %edi
    284f:	e8 f4 f6 ff ff       	call   1f48 <APDcCopy>
    2854:	83 c4 30             	add    $0x30,%esp
                    break;
    2857:	e9 e3 02 00 00       	jmp    2b3f <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    285c:	8d 45 88             	lea    -0x78(%ebp),%eax
    285f:	6a 69                	push   $0x69
    2861:	6a 69                	push   $0x69
    2863:	6a 69                	push   $0x69
    2865:	50                   	push   %eax
    2866:	e8 81 f8 ff ff       	call   20ec <RGB>
    286b:	83 c4 0c             	add    $0xc,%esp
    286e:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2872:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    2876:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    287a:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    287d:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    2884:	8d 45 88             	lea    -0x78(%ebp),%eax
    2887:	6a 69                	push   $0x69
    2889:	6a 69                	push   $0x69
    288b:	6a 69                	push   $0x69
    288d:	50                   	push   %eax
    288e:	e8 59 f8 ff ff       	call   20ec <RGB>
    2893:	83 c4 0c             	add    $0xc,%esp
    2896:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    289a:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    289e:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    28a2:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    28a5:	8b 45 08             	mov    0x8(%ebp),%eax
    28a8:	8d 50 3c             	lea    0x3c(%eax),%edx
    28ab:	8d 45 88             	lea    -0x78(%ebp),%eax
    28ae:	ff 75 ac             	pushl  -0x54(%ebp)
    28b1:	ff 75 a8             	pushl  -0x58(%ebp)
    28b4:	52                   	push   %edx
    28b5:	50                   	push   %eax
    28b6:	e8 1e ef ff ff       	call   17d9 <APSetPen>
    28bb:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    28be:	8b 45 08             	mov    0x8(%ebp),%eax
    28c1:	8d 58 3c             	lea    0x3c(%eax),%ebx
    28c4:	8d 55 88             	lea    -0x78(%ebp),%edx
    28c7:	83 ec 04             	sub    $0x4,%esp
    28ca:	83 ec 04             	sub    $0x4,%esp
    28cd:	89 e0                	mov    %esp,%eax
    28cf:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    28d3:	66 89 08             	mov    %cx,(%eax)
    28d6:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    28da:	88 48 02             	mov    %cl,0x2(%eax)
    28dd:	53                   	push   %ebx
    28de:	52                   	push   %edx
    28df:	e8 2e ef ff ff       	call   1812 <APSetBrush>
    28e4:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    28e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    28ea:	6b d0 32             	imul   $0x32,%eax,%edx
    28ed:	8b 45 e0             	mov    -0x20(%ebp),%eax
    28f0:	6b c0 32             	imul   $0x32,%eax,%eax
    28f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    28f6:	83 c1 3c             	add    $0x3c,%ecx
    28f9:	83 ec 0c             	sub    $0xc,%esp
    28fc:	6a 32                	push   $0x32
    28fe:	6a 32                	push   $0x32
    2900:	52                   	push   %edx
    2901:	50                   	push   %eax
    2902:	51                   	push   %ecx
    2903:	e8 34 f3 ff ff       	call   1c3c <APDrawRect>
    2908:	83 c4 20             	add    $0x20,%esp
                    break;
    290b:	e9 2f 02 00 00       	jmp    2b3f <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2910:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    2913:	6a 0c                	push   $0xc
    2915:	6a 0c                	push   $0xc
    2917:	6a 0c                	push   $0xc
    2919:	50                   	push   %eax
    291a:	e8 cd f7 ff ff       	call   20ec <RGB>
    291f:	83 c4 0c             	add    $0xc,%esp
    2922:	8b 1d 80 77 00 00    	mov    0x7780,%ebx
    2928:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    292b:	6b c8 32             	imul   $0x32,%eax,%ecx
    292e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2931:	6b c0 32             	imul   $0x32,%eax,%eax
    2934:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2937:	8b 45 08             	mov    0x8(%ebp),%eax
    293a:	8d 78 3c             	lea    0x3c(%eax),%edi
    293d:	83 ec 0c             	sub    $0xc,%esp
    2940:	83 ec 04             	sub    $0x4,%esp
    2943:	89 e0                	mov    %esp,%eax
    2945:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    2949:	66 89 30             	mov    %si,(%eax)
    294c:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    2950:	88 50 02             	mov    %dl,0x2(%eax)
    2953:	6a 32                	push   $0x32
    2955:	6a 32                	push   $0x32
    2957:	6a 00                	push   $0x0
    2959:	6a 00                	push   $0x0
    295b:	53                   	push   %ebx
    295c:	51                   	push   %ecx
    295d:	ff 75 84             	pushl  -0x7c(%ebp)
    2960:	57                   	push   %edi
    2961:	e8 e2 f5 ff ff       	call   1f48 <APDcCopy>
    2966:	83 c4 30             	add    $0x30,%esp
                    break;
    2969:	e9 d1 01 00 00       	jmp    2b3f <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    296e:	8d 45 c9             	lea    -0x37(%ebp),%eax
    2971:	6a 0c                	push   $0xc
    2973:	6a 0c                	push   $0xc
    2975:	6a 0c                	push   $0xc
    2977:	50                   	push   %eax
    2978:	e8 6f f7 ff ff       	call   20ec <RGB>
    297d:	83 c4 0c             	add    $0xc,%esp
    2980:	8b 1d 60 77 00 00    	mov    0x7760,%ebx
    2986:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2989:	6b c8 32             	imul   $0x32,%eax,%ecx
    298c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    298f:	6b c0 32             	imul   $0x32,%eax,%eax
    2992:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2995:	8b 45 08             	mov    0x8(%ebp),%eax
    2998:	8d 78 3c             	lea    0x3c(%eax),%edi
    299b:	83 ec 0c             	sub    $0xc,%esp
    299e:	83 ec 04             	sub    $0x4,%esp
    29a1:	89 e0                	mov    %esp,%eax
    29a3:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    29a7:	66 89 30             	mov    %si,(%eax)
    29aa:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    29ae:	88 50 02             	mov    %dl,0x2(%eax)
    29b1:	6a 32                	push   $0x32
    29b3:	6a 32                	push   $0x32
    29b5:	6a 00                	push   $0x0
    29b7:	6a 00                	push   $0x0
    29b9:	53                   	push   %ebx
    29ba:	51                   	push   %ecx
    29bb:	ff 75 84             	pushl  -0x7c(%ebp)
    29be:	57                   	push   %edi
    29bf:	e8 84 f5 ff ff       	call   1f48 <APDcCopy>
    29c4:	83 c4 30             	add    $0x30,%esp
                    break;
    29c7:	e9 73 01 00 00       	jmp    2b3f <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    29cc:	8d 45 cc             	lea    -0x34(%ebp),%eax
    29cf:	6a 0c                	push   $0xc
    29d1:	6a 0c                	push   $0xc
    29d3:	6a 0c                	push   $0xc
    29d5:	50                   	push   %eax
    29d6:	e8 11 f7 ff ff       	call   20ec <RGB>
    29db:	83 c4 0c             	add    $0xc,%esp
    29de:	8b 1d 44 77 00 00    	mov    0x7744,%ebx
    29e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    29e7:	6b c8 32             	imul   $0x32,%eax,%ecx
    29ea:	8b 45 e0             	mov    -0x20(%ebp),%eax
    29ed:	6b c0 32             	imul   $0x32,%eax,%eax
    29f0:	89 45 84             	mov    %eax,-0x7c(%ebp)
    29f3:	8b 45 08             	mov    0x8(%ebp),%eax
    29f6:	8d 78 3c             	lea    0x3c(%eax),%edi
    29f9:	83 ec 0c             	sub    $0xc,%esp
    29fc:	83 ec 04             	sub    $0x4,%esp
    29ff:	89 e0                	mov    %esp,%eax
    2a01:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    2a05:	66 89 30             	mov    %si,(%eax)
    2a08:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    2a0c:	88 50 02             	mov    %dl,0x2(%eax)
    2a0f:	6a 32                	push   $0x32
    2a11:	6a 32                	push   $0x32
    2a13:	6a 00                	push   $0x0
    2a15:	6a 00                	push   $0x0
    2a17:	53                   	push   %ebx
    2a18:	51                   	push   %ecx
    2a19:	ff 75 84             	pushl  -0x7c(%ebp)
    2a1c:	57                   	push   %edi
    2a1d:	e8 26 f5 ff ff       	call   1f48 <APDcCopy>
    2a22:	83 c4 30             	add    $0x30,%esp
                    break;
    2a25:	e9 15 01 00 00       	jmp    2b3f <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2a2a:	8d 45 cf             	lea    -0x31(%ebp),%eax
    2a2d:	6a 0c                	push   $0xc
    2a2f:	6a 0c                	push   $0xc
    2a31:	6a 0c                	push   $0xc
    2a33:	50                   	push   %eax
    2a34:	e8 b3 f6 ff ff       	call   20ec <RGB>
    2a39:	83 c4 0c             	add    $0xc,%esp
    2a3c:	8b 1d 7c 77 00 00    	mov    0x777c,%ebx
    2a42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2a45:	6b c8 32             	imul   $0x32,%eax,%ecx
    2a48:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2a4b:	6b c0 32             	imul   $0x32,%eax,%eax
    2a4e:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2a51:	8b 45 08             	mov    0x8(%ebp),%eax
    2a54:	8d 78 3c             	lea    0x3c(%eax),%edi
    2a57:	83 ec 0c             	sub    $0xc,%esp
    2a5a:	83 ec 04             	sub    $0x4,%esp
    2a5d:	89 e0                	mov    %esp,%eax
    2a5f:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    2a63:	66 89 30             	mov    %si,(%eax)
    2a66:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2a6a:	88 50 02             	mov    %dl,0x2(%eax)
    2a6d:	6a 32                	push   $0x32
    2a6f:	6a 32                	push   $0x32
    2a71:	6a 00                	push   $0x0
    2a73:	6a 00                	push   $0x0
    2a75:	53                   	push   %ebx
    2a76:	51                   	push   %ecx
    2a77:	ff 75 84             	pushl  -0x7c(%ebp)
    2a7a:	57                   	push   %edi
    2a7b:	e8 c8 f4 ff ff       	call   1f48 <APDcCopy>
    2a80:	83 c4 30             	add    $0x30,%esp
                    break;
    2a83:	e9 b7 00 00 00       	jmp    2b3f <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2a88:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2a8b:	6a 0c                	push   $0xc
    2a8d:	6a 0c                	push   $0xc
    2a8f:	6a 0c                	push   $0xc
    2a91:	50                   	push   %eax
    2a92:	e8 55 f6 ff ff       	call   20ec <RGB>
    2a97:	83 c4 0c             	add    $0xc,%esp
    2a9a:	8b 1d 14 77 00 00    	mov    0x7714,%ebx
    2aa0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2aa3:	6b c8 32             	imul   $0x32,%eax,%ecx
    2aa6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2aa9:	6b c0 32             	imul   $0x32,%eax,%eax
    2aac:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2aaf:	8b 45 08             	mov    0x8(%ebp),%eax
    2ab2:	8d 78 3c             	lea    0x3c(%eax),%edi
    2ab5:	83 ec 0c             	sub    $0xc,%esp
    2ab8:	83 ec 04             	sub    $0x4,%esp
    2abb:	89 e0                	mov    %esp,%eax
    2abd:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2ac1:	66 89 30             	mov    %si,(%eax)
    2ac4:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2ac8:	88 50 02             	mov    %dl,0x2(%eax)
    2acb:	6a 32                	push   $0x32
    2acd:	6a 32                	push   $0x32
    2acf:	6a 00                	push   $0x0
    2ad1:	6a 00                	push   $0x0
    2ad3:	53                   	push   %ebx
    2ad4:	51                   	push   %ecx
    2ad5:	ff 75 84             	pushl  -0x7c(%ebp)
    2ad8:	57                   	push   %edi
    2ad9:	e8 6a f4 ff ff       	call   1f48 <APDcCopy>
    2ade:	83 c4 30             	add    $0x30,%esp
                    break;
    2ae1:	eb 5c                	jmp    2b3f <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2ae3:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    2ae6:	6a 0c                	push   $0xc
    2ae8:	6a 0c                	push   $0xc
    2aea:	6a 0c                	push   $0xc
    2aec:	50                   	push   %eax
    2aed:	e8 fa f5 ff ff       	call   20ec <RGB>
    2af2:	83 c4 0c             	add    $0xc,%esp
    2af5:	8b 1d 30 77 00 00    	mov    0x7730,%ebx
    2afb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2afe:	6b c8 32             	imul   $0x32,%eax,%ecx
    2b01:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2b04:	6b c0 32             	imul   $0x32,%eax,%eax
    2b07:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2b0a:	8b 45 08             	mov    0x8(%ebp),%eax
    2b0d:	8d 78 3c             	lea    0x3c(%eax),%edi
    2b10:	83 ec 0c             	sub    $0xc,%esp
    2b13:	83 ec 04             	sub    $0x4,%esp
    2b16:	89 e0                	mov    %esp,%eax
    2b18:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2b1c:	66 89 30             	mov    %si,(%eax)
    2b1f:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2b23:	88 50 02             	mov    %dl,0x2(%eax)
    2b26:	6a 32                	push   $0x32
    2b28:	6a 32                	push   $0x32
    2b2a:	6a 00                	push   $0x0
    2b2c:	6a 00                	push   $0x0
    2b2e:	53                   	push   %ebx
    2b2f:	51                   	push   %ecx
    2b30:	ff 75 84             	pushl  -0x7c(%ebp)
    2b33:	57                   	push   %edi
    2b34:	e8 0f f4 ff ff       	call   1f48 <APDcCopy>
    2b39:	83 c4 30             	add    $0x30,%esp
                    break;
    2b3c:	eb 01                	jmp    2b3f <APGridPaint+0x639>
                default: break;
    2b3e:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2b3f:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2b43:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2b47:	0f 8e 7a fc ff ff    	jle    27c7 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2b4d:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2b51:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2b55:	0f 8e 60 fc ff ff    	jle    27bb <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2b5b:	8d 45 88             	lea    -0x78(%ebp),%eax
    2b5e:	68 cd 00 00 00       	push   $0xcd
    2b63:	6a 74                	push   $0x74
    2b65:	6a 18                	push   $0x18
    2b67:	50                   	push   %eax
    2b68:	e8 7f f5 ff ff       	call   20ec <RGB>
    2b6d:	83 c4 0c             	add    $0xc,%esp
    2b70:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2b74:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    2b78:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2b7c:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    2b7f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2b86:	8d 45 88             	lea    -0x78(%ebp),%eax
    2b89:	68 cd 00 00 00       	push   $0xcd
    2b8e:	6a 74                	push   $0x74
    2b90:	6a 18                	push   $0x18
    2b92:	50                   	push   %eax
    2b93:	e8 54 f5 ff ff       	call   20ec <RGB>
    2b98:	83 c4 0c             	add    $0xc,%esp
    2b9b:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2b9f:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    2ba3:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2ba7:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    2baa:	8b 45 08             	mov    0x8(%ebp),%eax
    2bad:	8d 50 58             	lea    0x58(%eax),%edx
    2bb0:	8d 45 88             	lea    -0x78(%ebp),%eax
    2bb3:	ff 75 bc             	pushl  -0x44(%ebp)
    2bb6:	ff 75 b8             	pushl  -0x48(%ebp)
    2bb9:	52                   	push   %edx
    2bba:	50                   	push   %eax
    2bbb:	e8 19 ec ff ff       	call   17d9 <APSetPen>
    2bc0:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2bc3:	8b 45 08             	mov    0x8(%ebp),%eax
    2bc6:	8d 58 58             	lea    0x58(%eax),%ebx
    2bc9:	8d 55 88             	lea    -0x78(%ebp),%edx
    2bcc:	83 ec 04             	sub    $0x4,%esp
    2bcf:	83 ec 04             	sub    $0x4,%esp
    2bd2:	89 e0                	mov    %esp,%eax
    2bd4:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    2bd8:	66 89 08             	mov    %cx,(%eax)
    2bdb:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    2bdf:	88 48 02             	mov    %cl,0x2(%eax)
    2be2:	53                   	push   %ebx
    2be3:	52                   	push   %edx
    2be4:	e8 29 ec ff ff       	call   1812 <APSetBrush>
    2be9:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2bec:	8b 45 08             	mov    0x8(%ebp),%eax
    2bef:	83 c0 58             	add    $0x58,%eax
    2bf2:	83 ec 0c             	sub    $0xc,%esp
    2bf5:	6a 32                	push   $0x32
    2bf7:	68 20 03 00 00       	push   $0x320
    2bfc:	6a 00                	push   $0x0
    2bfe:	6a 00                	push   $0x0
    2c00:	50                   	push   %eax
    2c01:	e8 36 f0 ff ff       	call   1c3c <APDrawRect>
    2c06:	83 c4 20             	add    $0x20,%esp
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    2c09:	8d 45 88             	lea    -0x78(%ebp),%eax
    2c0c:	6a 08                	push   $0x8
    2c0e:	6a 08                	push   $0x8
    2c10:	6a 08                	push   $0x8
    2c12:	50                   	push   %eax
    2c13:	e8 d4 f4 ff ff       	call   20ec <RGB>
    2c18:	83 c4 0c             	add    $0xc,%esp
    2c1b:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2c1f:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    2c23:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2c27:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    2c2a:	8b 45 08             	mov    0x8(%ebp),%eax
    2c2d:	8d 58 58             	lea    0x58(%eax),%ebx
    2c30:	8d 55 88             	lea    -0x78(%ebp),%edx
    2c33:	83 ec 04             	sub    $0x4,%esp
    2c36:	83 ec 04             	sub    $0x4,%esp
    2c39:	89 e0                	mov    %esp,%eax
    2c3b:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    2c3f:	66 89 08             	mov    %cx,(%eax)
    2c42:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    2c46:	88 48 02             	mov    %cl,0x2(%eax)
    2c49:	53                   	push   %ebx
    2c4a:	52                   	push   %edx
    2c4b:	e8 04 ec ff ff       	call   1854 <APSetFont>
    2c50:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    2c53:	8b 45 08             	mov    0x8(%ebp),%eax
    2c56:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    2c5c:	8b 45 08             	mov    0x8(%ebp),%eax
    2c5f:	83 c0 58             	add    $0x58,%eax
    2c62:	6a 14                	push   $0x14
    2c64:	6a 14                	push   $0x14
    2c66:	52                   	push   %edx
    2c67:	50                   	push   %eax
    2c68:	e8 d4 f1 ff ff       	call   1e41 <APDrawText>
    2c6d:	83 c4 10             	add    $0x10,%esp
}
    2c70:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2c73:	5b                   	pop    %ebx
    2c74:	5e                   	pop    %esi
    2c75:	5f                   	pop    %edi
    2c76:	5d                   	pop    %ebp
    2c77:	c3                   	ret    

00002c78 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2c78:	55                   	push   %ebp
    2c79:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2c7b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2c7f:	7e 08                	jle    2c89 <random+0x11>
{
rand_num = seed;
    2c81:	8b 45 08             	mov    0x8(%ebp),%eax
    2c84:	a3 80 76 00 00       	mov    %eax,0x7680
}
rand_num *= 3;
    2c89:	8b 15 80 76 00 00    	mov    0x7680,%edx
    2c8f:	89 d0                	mov    %edx,%eax
    2c91:	01 c0                	add    %eax,%eax
    2c93:	01 d0                	add    %edx,%eax
    2c95:	a3 80 76 00 00       	mov    %eax,0x7680
if (rand_num < 0)
    2c9a:	a1 80 76 00 00       	mov    0x7680,%eax
    2c9f:	85 c0                	test   %eax,%eax
    2ca1:	79 0c                	jns    2caf <random+0x37>
{
rand_num *= (-1);
    2ca3:	a1 80 76 00 00       	mov    0x7680,%eax
    2ca8:	f7 d8                	neg    %eax
    2caa:	a3 80 76 00 00       	mov    %eax,0x7680
}
return rand_num % 997;
    2caf:	8b 0d 80 76 00 00    	mov    0x7680,%ecx
    2cb5:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2cba:	89 c8                	mov    %ecx,%eax
    2cbc:	f7 ea                	imul   %edx
    2cbe:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2cc1:	c1 f8 09             	sar    $0x9,%eax
    2cc4:	89 c2                	mov    %eax,%edx
    2cc6:	89 c8                	mov    %ecx,%eax
    2cc8:	c1 f8 1f             	sar    $0x1f,%eax
    2ccb:	29 c2                	sub    %eax,%edx
    2ccd:	89 d0                	mov    %edx,%eax
    2ccf:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2cd5:	29 c1                	sub    %eax,%ecx
    2cd7:	89 c8                	mov    %ecx,%eax
}
    2cd9:	5d                   	pop    %ebp
    2cda:	c3                   	ret    

00002cdb <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2cdb:	55                   	push   %ebp
    2cdc:	89 e5                	mov    %esp,%ebp
    2cde:	53                   	push   %ebx
    2cdf:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2ce2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2ce9:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2ced:	74 17                	je     2d06 <sprintint+0x2b>
    2cef:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2cf3:	79 11                	jns    2d06 <sprintint+0x2b>
        neg = 1;
    2cf5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2cfc:	8b 45 10             	mov    0x10(%ebp),%eax
    2cff:	f7 d8                	neg    %eax
    2d01:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2d04:	eb 06                	jmp    2d0c <sprintint+0x31>
    } else {
        x = xx;
    2d06:	8b 45 10             	mov    0x10(%ebp),%eax
    2d09:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2d0c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2d13:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2d16:	8d 41 01             	lea    0x1(%ecx),%eax
    2d19:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2d1c:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2d1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2d22:	ba 00 00 00 00       	mov    $0x0,%edx
    2d27:	f7 f3                	div    %ebx
    2d29:	89 d0                	mov    %edx,%eax
    2d2b:	0f b6 80 84 76 00 00 	movzbl 0x7684(%eax),%eax
    2d32:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2d36:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2d39:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2d3c:	ba 00 00 00 00       	mov    $0x0,%edx
    2d41:	f7 f3                	div    %ebx
    2d43:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2d46:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d4a:	75 c7                	jne    2d13 <sprintint+0x38>
    if(neg)
    2d4c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2d50:	74 0e                	je     2d60 <sprintint+0x85>
        buf[i++] = '-';
    2d52:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2d55:	8d 50 01             	lea    0x1(%eax),%edx
    2d58:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2d5b:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2d60:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2d63:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2d66:	eb 1b                	jmp    2d83 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2d68:	8b 45 0c             	mov    0xc(%ebp),%eax
    2d6b:	8b 00                	mov    (%eax),%eax
    2d6d:	8d 48 01             	lea    0x1(%eax),%ecx
    2d70:	8b 55 0c             	mov    0xc(%ebp),%edx
    2d73:	89 0a                	mov    %ecx,(%edx)
    2d75:	89 c2                	mov    %eax,%edx
    2d77:	8b 45 08             	mov    0x8(%ebp),%eax
    2d7a:	01 d0                	add    %edx,%eax
    2d7c:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2d7f:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2d83:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2d87:	7f df                	jg     2d68 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2d89:	eb 21                	jmp    2dac <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2d8b:	8b 45 0c             	mov    0xc(%ebp),%eax
    2d8e:	8b 00                	mov    (%eax),%eax
    2d90:	8d 48 01             	lea    0x1(%eax),%ecx
    2d93:	8b 55 0c             	mov    0xc(%ebp),%edx
    2d96:	89 0a                	mov    %ecx,(%edx)
    2d98:	89 c2                	mov    %eax,%edx
    2d9a:	8b 45 08             	mov    0x8(%ebp),%eax
    2d9d:	01 c2                	add    %eax,%edx
    2d9f:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2da2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2da5:	01 c8                	add    %ecx,%eax
    2da7:	0f b6 00             	movzbl (%eax),%eax
    2daa:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2dac:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2db0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2db4:	79 d5                	jns    2d8b <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2db6:	90                   	nop
    2db7:	83 c4 20             	add    $0x20,%esp
    2dba:	5b                   	pop    %ebx
    2dbb:	5d                   	pop    %ebp
    2dbc:	c3                   	ret    

00002dbd <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2dbd:	55                   	push   %ebp
    2dbe:	89 e5                	mov    %esp,%ebp
    2dc0:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2dc3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2dca:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2dd1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2dd8:	8d 45 0c             	lea    0xc(%ebp),%eax
    2ddb:	83 c0 04             	add    $0x4,%eax
    2dde:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2de1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2de8:	e9 d9 01 00 00       	jmp    2fc6 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2ded:	8b 55 0c             	mov    0xc(%ebp),%edx
    2df0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2df3:	01 d0                	add    %edx,%eax
    2df5:	0f b6 00             	movzbl (%eax),%eax
    2df8:	0f be c0             	movsbl %al,%eax
    2dfb:	25 ff 00 00 00       	and    $0xff,%eax
    2e00:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2e03:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2e07:	75 2c                	jne    2e35 <sprintf+0x78>
            if(c == '%'){
    2e09:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2e0d:	75 0c                	jne    2e1b <sprintf+0x5e>
                state = '%';
    2e0f:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2e16:	e9 a7 01 00 00       	jmp    2fc2 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2e1b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2e1e:	8d 50 01             	lea    0x1(%eax),%edx
    2e21:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2e24:	89 c2                	mov    %eax,%edx
    2e26:	8b 45 08             	mov    0x8(%ebp),%eax
    2e29:	01 d0                	add    %edx,%eax
    2e2b:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2e2e:	88 10                	mov    %dl,(%eax)
    2e30:	e9 8d 01 00 00       	jmp    2fc2 <sprintf+0x205>
            }
        } else if(state == '%'){
    2e35:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2e39:	0f 85 83 01 00 00    	jne    2fc2 <sprintf+0x205>
            if(c == 'd'){
    2e3f:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2e43:	75 4c                	jne    2e91 <sprintf+0xd4>
                buf[bi] = '\0';
    2e45:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2e48:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2e4b:	01 d0                	add    %edx,%eax
    2e4d:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2e50:	83 ec 0c             	sub    $0xc,%esp
    2e53:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2e56:	50                   	push   %eax
    2e57:	e8 e7 df ff ff       	call   e43 <atoi>
    2e5c:	83 c4 10             	add    $0x10,%esp
    2e5f:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2e62:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2e69:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2e6c:	8b 00                	mov    (%eax),%eax
    2e6e:	83 ec 08             	sub    $0x8,%esp
    2e71:	ff 75 d8             	pushl  -0x28(%ebp)
    2e74:	6a 01                	push   $0x1
    2e76:	6a 0a                	push   $0xa
    2e78:	50                   	push   %eax
    2e79:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2e7c:	50                   	push   %eax
    2e7d:	ff 75 08             	pushl  0x8(%ebp)
    2e80:	e8 56 fe ff ff       	call   2cdb <sprintint>
    2e85:	83 c4 20             	add    $0x20,%esp
                ap++;
    2e88:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2e8c:	e9 2a 01 00 00       	jmp    2fbb <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2e91:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2e95:	74 06                	je     2e9d <sprintf+0xe0>
    2e97:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2e9b:	75 4c                	jne    2ee9 <sprintf+0x12c>
                buf[bi] = '\0';
    2e9d:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2ea0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2ea3:	01 d0                	add    %edx,%eax
    2ea5:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2ea8:	83 ec 0c             	sub    $0xc,%esp
    2eab:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2eae:	50                   	push   %eax
    2eaf:	e8 8f df ff ff       	call   e43 <atoi>
    2eb4:	83 c4 10             	add    $0x10,%esp
    2eb7:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2eba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2ec1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2ec4:	8b 00                	mov    (%eax),%eax
    2ec6:	83 ec 08             	sub    $0x8,%esp
    2ec9:	ff 75 dc             	pushl  -0x24(%ebp)
    2ecc:	6a 00                	push   $0x0
    2ece:	6a 10                	push   $0x10
    2ed0:	50                   	push   %eax
    2ed1:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2ed4:	50                   	push   %eax
    2ed5:	ff 75 08             	pushl  0x8(%ebp)
    2ed8:	e8 fe fd ff ff       	call   2cdb <sprintint>
    2edd:	83 c4 20             	add    $0x20,%esp
                ap++;
    2ee0:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2ee4:	e9 d2 00 00 00       	jmp    2fbb <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2ee9:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2eed:	75 46                	jne    2f35 <sprintf+0x178>
                s = (char*)*ap;
    2eef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2ef2:	8b 00                	mov    (%eax),%eax
    2ef4:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2ef7:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2efb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2eff:	75 25                	jne    2f26 <sprintf+0x169>
                    s = "(null)";
    2f01:	c7 45 f4 54 32 00 00 	movl   $0x3254,-0xc(%ebp)
                while(*s != 0){
    2f08:	eb 1c                	jmp    2f26 <sprintf+0x169>
                    dst[j++] = *s;
    2f0a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2f0d:	8d 50 01             	lea    0x1(%eax),%edx
    2f10:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2f13:	89 c2                	mov    %eax,%edx
    2f15:	8b 45 08             	mov    0x8(%ebp),%eax
    2f18:	01 c2                	add    %eax,%edx
    2f1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f1d:	0f b6 00             	movzbl (%eax),%eax
    2f20:	88 02                	mov    %al,(%edx)
                    s++;
    2f22:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2f26:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f29:	0f b6 00             	movzbl (%eax),%eax
    2f2c:	84 c0                	test   %al,%al
    2f2e:	75 da                	jne    2f0a <sprintf+0x14d>
    2f30:	e9 86 00 00 00       	jmp    2fbb <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2f35:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2f39:	75 1d                	jne    2f58 <sprintf+0x19b>
                dst[j++] = *ap;
    2f3b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2f3e:	8d 50 01             	lea    0x1(%eax),%edx
    2f41:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2f44:	89 c2                	mov    %eax,%edx
    2f46:	8b 45 08             	mov    0x8(%ebp),%eax
    2f49:	01 c2                	add    %eax,%edx
    2f4b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2f4e:	8b 00                	mov    (%eax),%eax
    2f50:	88 02                	mov    %al,(%edx)
                ap++;
    2f52:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2f56:	eb 63                	jmp    2fbb <sprintf+0x1fe>
            } else if(c == '%'){
    2f58:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2f5c:	75 17                	jne    2f75 <sprintf+0x1b8>
                dst[j++] = c;
    2f5e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2f61:	8d 50 01             	lea    0x1(%eax),%edx
    2f64:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2f67:	89 c2                	mov    %eax,%edx
    2f69:	8b 45 08             	mov    0x8(%ebp),%eax
    2f6c:	01 d0                	add    %edx,%eax
    2f6e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2f71:	88 10                	mov    %dl,(%eax)
    2f73:	eb 46                	jmp    2fbb <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2f75:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2f79:	7e 18                	jle    2f93 <sprintf+0x1d6>
    2f7b:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2f7f:	7f 12                	jg     2f93 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2f81:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2f84:	8d 50 01             	lea    0x1(%eax),%edx
    2f87:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2f8a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2f8d:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2f91:	eb 2f                	jmp    2fc2 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2f93:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2f96:	8d 50 01             	lea    0x1(%eax),%edx
    2f99:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2f9c:	89 c2                	mov    %eax,%edx
    2f9e:	8b 45 08             	mov    0x8(%ebp),%eax
    2fa1:	01 d0                	add    %edx,%eax
    2fa3:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2fa6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2fa9:	8d 50 01             	lea    0x1(%eax),%edx
    2fac:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2faf:	89 c2                	mov    %eax,%edx
    2fb1:	8b 45 08             	mov    0x8(%ebp),%eax
    2fb4:	01 d0                	add    %edx,%eax
    2fb6:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2fb9:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2fbb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2fc2:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2fc6:	8b 55 0c             	mov    0xc(%ebp),%edx
    2fc9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2fcc:	01 d0                	add    %edx,%eax
    2fce:	0f b6 00             	movzbl (%eax),%eax
    2fd1:	84 c0                	test   %al,%al
    2fd3:	0f 85 14 fe ff ff    	jne    2ded <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2fd9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2fdc:	8d 50 01             	lea    0x1(%eax),%edx
    2fdf:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2fe2:	89 c2                	mov    %eax,%edx
    2fe4:	8b 45 08             	mov    0x8(%ebp),%eax
    2fe7:	01 d0                	add    %edx,%eax
    2fe9:	c6 00 00             	movb   $0x0,(%eax)
}
    2fec:	90                   	nop
    2fed:	c9                   	leave  
    2fee:	c3                   	ret    
