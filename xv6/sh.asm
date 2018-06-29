
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
      1b:	8b 04 85 74 2e 00 00 	mov    0x2e74(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 48 2e 00 00       	push   $0x2e48
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
      6c:	68 4f 2e 00 00       	push   $0x2e4f
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
      bf:	68 5f 2e 00 00       	push   $0x2e5f
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
     143:	68 6f 2e 00 00       	push   $0x2e6f
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
     254:	68 8c 2e 00 00       	push   $0x2e8c
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
     2ce:	68 8f 2e 00 00       	push   $0x2e8f
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
     2e9:	0f b6 05 80 38 00 00 	movzbl 0x3880,%eax
     2f0:	3c 63                	cmp    $0x63,%al
     2f2:	75 5f                	jne    353 <main+0xb3>
     2f4:	0f b6 05 81 38 00 00 	movzbl 0x3881,%eax
     2fb:	3c 64                	cmp    $0x64,%al
     2fd:	75 54                	jne    353 <main+0xb3>
     2ff:	0f b6 05 82 38 00 00 	movzbl 0x3882,%eax
     306:	3c 20                	cmp    $0x20,%al
     308:	75 49                	jne    353 <main+0xb3>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     30a:	83 ec 0c             	sub    $0xc,%esp
     30d:	68 80 38 00 00       	push   $0x3880
     312:	e8 fc 09 00 00       	call   d13 <strlen>
     317:	83 c4 10             	add    $0x10,%esp
     31a:	83 e8 01             	sub    $0x1,%eax
     31d:	c6 80 80 38 00 00 00 	movb   $0x0,0x3880(%eax)
      if(chdir(buf+3) < 0)
     324:	b8 83 38 00 00       	mov    $0x3883,%eax
     329:	83 ec 0c             	sub    $0xc,%esp
     32c:	50                   	push   %eax
     32d:	e8 13 0c 00 00       	call   f45 <chdir>
     332:	83 c4 10             	add    $0x10,%esp
     335:	85 c0                	test   %eax,%eax
     337:	79 44                	jns    37d <main+0xdd>
        printf(2, "cannot cd %s\n", buf+3);
     339:	b8 83 38 00 00       	mov    $0x3883,%eax
     33e:	83 ec 04             	sub    $0x4,%esp
     341:	50                   	push   %eax
     342:	68 97 2e 00 00       	push   $0x2e97
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
     35f:	68 80 38 00 00       	push   $0x3880
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
     382:	68 80 38 00 00       	push   $0x3880
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
     3a8:	68 a5 2e 00 00       	push   $0x2ea5
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
     3d3:	68 a9 2e 00 00       	push   $0x2ea9
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
     576:	68 44 38 00 00       	push   $0x3844
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
     61f:	68 44 38 00 00       	push   $0x3844
     624:	e8 2b 07 00 00       	call   d54 <strchr>
     629:	83 c4 10             	add    $0x10,%esp
     62c:	85 c0                	test   %eax,%eax
     62e:	75 26                	jne    656 <gettoken+0x109>
     630:	8b 45 f4             	mov    -0xc(%ebp),%eax
     633:	0f b6 00             	movzbl (%eax),%eax
     636:	0f be c0             	movsbl %al,%eax
     639:	83 ec 08             	sub    $0x8,%esp
     63c:	50                   	push   %eax
     63d:	68 4c 38 00 00       	push   $0x384c
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
     680:	68 44 38 00 00       	push   $0x3844
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
     6c7:	68 44 38 00 00       	push   $0x3844
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
     74a:	68 ae 2e 00 00       	push   $0x2eae
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
     76d:	68 af 2e 00 00       	push   $0x2eaf
     772:	6a 02                	push   $0x2
     774:	e8 0b 09 00 00       	call   1084 <printf>
     779:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     77c:	83 ec 0c             	sub    $0xc,%esp
     77f:	68 be 2e 00 00       	push   $0x2ebe
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
     7e4:	68 c5 2e 00 00       	push   $0x2ec5
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
     7fe:	68 c7 2e 00 00       	push   $0x2ec7
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
     86c:	68 c9 2e 00 00       	push   $0x2ec9
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
     8fb:	68 cb 2e 00 00       	push   $0x2ecb
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
     981:	68 e8 2e 00 00       	push   $0x2ee8
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
     9aa:	68 eb 2e 00 00       	push   $0x2eeb
     9af:	ff 75 0c             	pushl  0xc(%ebp)
     9b2:	ff 75 08             	pushl  0x8(%ebp)
     9b5:	e8 e4 fc ff ff       	call   69e <peek>
     9ba:	83 c4 10             	add    $0x10,%esp
     9bd:	85 c0                	test   %eax,%eax
     9bf:	75 10                	jne    9d1 <parseblock+0x30>
    panic("parseblock");
     9c1:	83 ec 0c             	sub    $0xc,%esp
     9c4:	68 ed 2e 00 00       	push   $0x2eed
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
     9fa:	68 f8 2e 00 00       	push   $0x2ef8
     9ff:	ff 75 0c             	pushl  0xc(%ebp)
     a02:	ff 75 08             	pushl  0x8(%ebp)
     a05:	e8 94 fc ff ff       	call   69e <peek>
     a0a:	83 c4 10             	add    $0x10,%esp
     a0d:	85 c0                	test   %eax,%eax
     a0f:	75 10                	jne    a21 <parseblock+0x80>
    panic("syntax - missing )");
     a11:	83 ec 0c             	sub    $0xc,%esp
     a14:	68 fa 2e 00 00       	push   $0x2efa
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
     a58:	68 eb 2e 00 00       	push   $0x2eeb
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
     ae2:	68 be 2e 00 00       	push   $0x2ebe
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
     b19:	68 0d 2f 00 00       	push   $0x2f0d
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
     b40:	68 1b 2f 00 00       	push   $0x2f1b
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
     ba6:	8b 04 85 20 2f 00 00 	mov    0x2f20(,%eax,4),%eax
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
    1020:	0f b6 80 54 38 00 00 	movzbl 0x3854(%eax),%eax
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
    115e:	c7 45 f4 38 2f 00 00 	movl   $0x2f38,-0xc(%ebp)
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
    1224:	a1 ec 38 00 00       	mov    0x38ec,%eax
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
    12ef:	a3 ec 38 00 00       	mov    %eax,0x38ec
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
    1350:	a1 ec 38 00 00       	mov    0x38ec,%eax
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
    136c:	a1 ec 38 00 00       	mov    0x38ec,%eax
    1371:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1374:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1378:	75 23                	jne    139d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    137a:	c7 45 f0 e4 38 00 00 	movl   $0x38e4,-0x10(%ebp)
    1381:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1384:	a3 ec 38 00 00       	mov    %eax,0x38ec
    1389:	a1 ec 38 00 00       	mov    0x38ec,%eax
    138e:	a3 e4 38 00 00       	mov    %eax,0x38e4
    base.s.size = 0;
    1393:	c7 05 e8 38 00 00 00 	movl   $0x0,0x38e8
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
    13f0:	a3 ec 38 00 00       	mov    %eax,0x38ec
      return (void*)(p + 1);
    13f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f8:	83 c0 08             	add    $0x8,%eax
    13fb:	eb 3b                	jmp    1438 <malloc+0xe1>
    }
    if(p == freep)
    13fd:	a1 ec 38 00 00       	mov    0x38ec,%eax
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
    1543:	68 3f 2f 00 00       	push   $0x2f3f
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

00001854 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    1854:	55                   	push   %ebp
    1855:	89 e5                	mov    %esp,%ebp
    1857:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    185a:	8b 45 08             	mov    0x8(%ebp),%eax
    185d:	8b 40 0c             	mov    0xc(%eax),%eax
    1860:	89 c2                	mov    %eax,%edx
    1862:	c1 ea 1f             	shr    $0x1f,%edx
    1865:	01 d0                	add    %edx,%eax
    1867:	d1 f8                	sar    %eax
    1869:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    186c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186f:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    1873:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    1876:	8b 45 10             	mov    0x10(%ebp),%eax
    1879:	2b 45 f4             	sub    -0xc(%ebp),%eax
    187c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    187f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    1883:	0f 89 98 00 00 00    	jns    1921 <APDrawPoint+0xcd>
        i = 0;
    1889:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    1890:	e9 8c 00 00 00       	jmp    1921 <APDrawPoint+0xcd>
    {
        j = x - off;
    1895:	8b 45 0c             	mov    0xc(%ebp),%eax
    1898:	2b 45 f4             	sub    -0xc(%ebp),%eax
    189b:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    189e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    18a2:	79 69                	jns    190d <APDrawPoint+0xb9>
            j = 0;
    18a4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    18ab:	eb 60                	jmp    190d <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    18ad:	ff 75 fc             	pushl  -0x4(%ebp)
    18b0:	ff 75 f8             	pushl  -0x8(%ebp)
    18b3:	ff 75 08             	pushl  0x8(%ebp)
    18b6:	e8 fd fb ff ff       	call   14b8 <APGetIndex>
    18bb:	83 c4 0c             	add    $0xc,%esp
    18be:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    18c1:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    18c5:	74 55                	je     191c <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    18c7:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    18cb:	74 67                	je     1934 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    18cd:	ff 75 10             	pushl  0x10(%ebp)
    18d0:	ff 75 0c             	pushl  0xc(%ebp)
    18d3:	ff 75 fc             	pushl  -0x4(%ebp)
    18d6:	ff 75 f8             	pushl  -0x8(%ebp)
    18d9:	e8 a1 fb ff ff       	call   147f <distance_2>
    18de:	83 c4 10             	add    $0x10,%esp
    18e1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    18e4:	7f 23                	jg     1909 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    18e6:	8b 45 08             	mov    0x8(%ebp),%eax
    18e9:	8b 48 18             	mov    0x18(%eax),%ecx
    18ec:	8b 55 ec             	mov    -0x14(%ebp),%edx
    18ef:	89 d0                	mov    %edx,%eax
    18f1:	01 c0                	add    %eax,%eax
    18f3:	01 d0                	add    %edx,%eax
    18f5:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    18f8:	8b 45 08             	mov    0x8(%ebp),%eax
    18fb:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    18ff:	66 89 0a             	mov    %cx,(%edx)
    1902:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1906:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1909:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    190d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1910:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1913:	01 d0                	add    %edx,%eax
    1915:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1918:	7d 93                	jge    18ad <APDrawPoint+0x59>
    191a:	eb 01                	jmp    191d <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    191c:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    191d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1921:	8b 55 10             	mov    0x10(%ebp),%edx
    1924:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1927:	01 d0                	add    %edx,%eax
    1929:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    192c:	0f 8d 63 ff ff ff    	jge    1895 <APDrawPoint+0x41>
    1932:	eb 01                	jmp    1935 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1934:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    1935:	c9                   	leave  
    1936:	c3                   	ret    

00001937 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1937:	55                   	push   %ebp
    1938:	89 e5                	mov    %esp,%ebp
    193a:	53                   	push   %ebx
    193b:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    193e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1941:	3b 45 14             	cmp    0x14(%ebp),%eax
    1944:	0f 85 80 00 00 00    	jne    19ca <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    194a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    194e:	0f 88 9d 02 00 00    	js     1bf1 <APDrawLine+0x2ba>
    1954:	8b 45 08             	mov    0x8(%ebp),%eax
    1957:	8b 00                	mov    (%eax),%eax
    1959:	3b 45 0c             	cmp    0xc(%ebp),%eax
    195c:	0f 8e 8f 02 00 00    	jle    1bf1 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    1962:	8b 45 10             	mov    0x10(%ebp),%eax
    1965:	3b 45 18             	cmp    0x18(%ebp),%eax
    1968:	7e 12                	jle    197c <APDrawLine+0x45>
        {
            int tmp = y2;
    196a:	8b 45 18             	mov    0x18(%ebp),%eax
    196d:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    1970:	8b 45 10             	mov    0x10(%ebp),%eax
    1973:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1976:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1979:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    197c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1980:	79 07                	jns    1989 <APDrawLine+0x52>
    1982:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1989:	8b 45 08             	mov    0x8(%ebp),%eax
    198c:	8b 40 04             	mov    0x4(%eax),%eax
    198f:	3b 45 18             	cmp    0x18(%ebp),%eax
    1992:	7d 0c                	jge    19a0 <APDrawLine+0x69>
    1994:	8b 45 08             	mov    0x8(%ebp),%eax
    1997:	8b 40 04             	mov    0x4(%eax),%eax
    199a:	83 e8 01             	sub    $0x1,%eax
    199d:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    19a0:	8b 45 10             	mov    0x10(%ebp),%eax
    19a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    19a6:	eb 15                	jmp    19bd <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    19a8:	ff 75 f4             	pushl  -0xc(%ebp)
    19ab:	ff 75 0c             	pushl  0xc(%ebp)
    19ae:	ff 75 08             	pushl  0x8(%ebp)
    19b1:	e8 9e fe ff ff       	call   1854 <APDrawPoint>
    19b6:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    19b9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    19bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19c0:	3b 45 18             	cmp    0x18(%ebp),%eax
    19c3:	7e e3                	jle    19a8 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    19c5:	e9 2b 02 00 00       	jmp    1bf5 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    19ca:	8b 45 10             	mov    0x10(%ebp),%eax
    19cd:	3b 45 18             	cmp    0x18(%ebp),%eax
    19d0:	75 7f                	jne    1a51 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    19d2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    19d6:	0f 88 18 02 00 00    	js     1bf4 <APDrawLine+0x2bd>
    19dc:	8b 45 08             	mov    0x8(%ebp),%eax
    19df:	8b 40 04             	mov    0x4(%eax),%eax
    19e2:	3b 45 10             	cmp    0x10(%ebp),%eax
    19e5:	0f 8e 09 02 00 00    	jle    1bf4 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    19eb:	8b 45 0c             	mov    0xc(%ebp),%eax
    19ee:	3b 45 14             	cmp    0x14(%ebp),%eax
    19f1:	7e 12                	jle    1a05 <APDrawLine+0xce>
        {
            int tmp = x2;
    19f3:	8b 45 14             	mov    0x14(%ebp),%eax
    19f6:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    19f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    19fc:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    19ff:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a02:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    1a05:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1a09:	79 07                	jns    1a12 <APDrawLine+0xdb>
    1a0b:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1a12:	8b 45 08             	mov    0x8(%ebp),%eax
    1a15:	8b 00                	mov    (%eax),%eax
    1a17:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a1a:	7d 0b                	jge    1a27 <APDrawLine+0xf0>
    1a1c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1f:	8b 00                	mov    (%eax),%eax
    1a21:	83 e8 01             	sub    $0x1,%eax
    1a24:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1a27:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a2d:	eb 15                	jmp    1a44 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1a2f:	ff 75 10             	pushl  0x10(%ebp)
    1a32:	ff 75 f0             	pushl  -0x10(%ebp)
    1a35:	ff 75 08             	pushl  0x8(%ebp)
    1a38:	e8 17 fe ff ff       	call   1854 <APDrawPoint>
    1a3d:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1a40:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1a44:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a47:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a4a:	7e e3                	jle    1a2f <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1a4c:	e9 a4 01 00 00       	jmp    1bf5 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1a51:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1a58:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1a5f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a62:	2b 45 14             	sub    0x14(%ebp),%eax
    1a65:	50                   	push   %eax
    1a66:	e8 3d fa ff ff       	call   14a8 <abs_int>
    1a6b:	83 c4 04             	add    $0x4,%esp
    1a6e:	89 c3                	mov    %eax,%ebx
    1a70:	8b 45 10             	mov    0x10(%ebp),%eax
    1a73:	2b 45 18             	sub    0x18(%ebp),%eax
    1a76:	50                   	push   %eax
    1a77:	e8 2c fa ff ff       	call   14a8 <abs_int>
    1a7c:	83 c4 04             	add    $0x4,%esp
    1a7f:	39 c3                	cmp    %eax,%ebx
    1a81:	0f 8e b5 00 00 00    	jle    1b3c <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1a87:	8b 45 10             	mov    0x10(%ebp),%eax
    1a8a:	2b 45 18             	sub    0x18(%ebp),%eax
    1a8d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1a90:	db 45 b0             	fildl  -0x50(%ebp)
    1a93:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a96:	2b 45 14             	sub    0x14(%ebp),%eax
    1a99:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1a9c:	db 45 b0             	fildl  -0x50(%ebp)
    1a9f:	de f9                	fdivrp %st,%st(1)
    1aa1:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1aa4:	8b 45 14             	mov    0x14(%ebp),%eax
    1aa7:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1aaa:	7e 0e                	jle    1aba <APDrawLine+0x183>
        {
            s = x1;
    1aac:	8b 45 0c             	mov    0xc(%ebp),%eax
    1aaf:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    1ab2:	8b 45 14             	mov    0x14(%ebp),%eax
    1ab5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1ab8:	eb 0c                	jmp    1ac6 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1aba:	8b 45 14             	mov    0x14(%ebp),%eax
    1abd:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1ac0:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ac3:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1ac6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1aca:	79 07                	jns    1ad3 <APDrawLine+0x19c>
    1acc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1ad3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad6:	8b 00                	mov    (%eax),%eax
    1ad8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1adb:	7f 0b                	jg     1ae8 <APDrawLine+0x1b1>
    1add:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae0:	8b 00                	mov    (%eax),%eax
    1ae2:	83 e8 01             	sub    $0x1,%eax
    1ae5:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1ae8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1aeb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1aee:	eb 3f                	jmp    1b2f <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1af0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1af3:	2b 45 0c             	sub    0xc(%ebp),%eax
    1af6:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1af9:	db 45 b0             	fildl  -0x50(%ebp)
    1afc:	dc 4d d0             	fmull  -0x30(%ebp)
    1aff:	db 45 10             	fildl  0x10(%ebp)
    1b02:	de c1                	faddp  %st,%st(1)
    1b04:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1b07:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1b0b:	b4 0c                	mov    $0xc,%ah
    1b0d:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1b11:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1b14:	db 5d cc             	fistpl -0x34(%ebp)
    1b17:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1b1a:	ff 75 cc             	pushl  -0x34(%ebp)
    1b1d:	ff 75 e4             	pushl  -0x1c(%ebp)
    1b20:	ff 75 08             	pushl  0x8(%ebp)
    1b23:	e8 2c fd ff ff       	call   1854 <APDrawPoint>
    1b28:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1b2b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1b2f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b32:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1b35:	7e b9                	jle    1af0 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1b37:	e9 b9 00 00 00       	jmp    1bf5 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1b3c:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b3f:	2b 45 14             	sub    0x14(%ebp),%eax
    1b42:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1b45:	db 45 b0             	fildl  -0x50(%ebp)
    1b48:	8b 45 10             	mov    0x10(%ebp),%eax
    1b4b:	2b 45 18             	sub    0x18(%ebp),%eax
    1b4e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1b51:	db 45 b0             	fildl  -0x50(%ebp)
    1b54:	de f9                	fdivrp %st,%st(1)
    1b56:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1b59:	8b 45 10             	mov    0x10(%ebp),%eax
    1b5c:	3b 45 18             	cmp    0x18(%ebp),%eax
    1b5f:	7e 0e                	jle    1b6f <APDrawLine+0x238>
    {
        s = y2;
    1b61:	8b 45 18             	mov    0x18(%ebp),%eax
    1b64:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1b67:	8b 45 10             	mov    0x10(%ebp),%eax
    1b6a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1b6d:	eb 0c                	jmp    1b7b <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1b6f:	8b 45 10             	mov    0x10(%ebp),%eax
    1b72:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1b75:	8b 45 18             	mov    0x18(%ebp),%eax
    1b78:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1b7b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b7f:	79 07                	jns    1b88 <APDrawLine+0x251>
    1b81:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1b88:	8b 45 08             	mov    0x8(%ebp),%eax
    1b8b:	8b 40 04             	mov    0x4(%eax),%eax
    1b8e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1b91:	7f 0c                	jg     1b9f <APDrawLine+0x268>
    1b93:	8b 45 08             	mov    0x8(%ebp),%eax
    1b96:	8b 40 04             	mov    0x4(%eax),%eax
    1b99:	83 e8 01             	sub    $0x1,%eax
    1b9c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1b9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ba2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1ba5:	eb 3f                	jmp    1be6 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1ba7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1baa:	2b 45 10             	sub    0x10(%ebp),%eax
    1bad:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1bb0:	db 45 b0             	fildl  -0x50(%ebp)
    1bb3:	dc 4d c0             	fmull  -0x40(%ebp)
    1bb6:	db 45 0c             	fildl  0xc(%ebp)
    1bb9:	de c1                	faddp  %st,%st(1)
    1bbb:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1bbe:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1bc2:	b4 0c                	mov    $0xc,%ah
    1bc4:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1bc8:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1bcb:	db 5d bc             	fistpl -0x44(%ebp)
    1bce:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1bd1:	ff 75 e0             	pushl  -0x20(%ebp)
    1bd4:	ff 75 bc             	pushl  -0x44(%ebp)
    1bd7:	ff 75 08             	pushl  0x8(%ebp)
    1bda:	e8 75 fc ff ff       	call   1854 <APDrawPoint>
    1bdf:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1be2:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1be6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1be9:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1bec:	7e b9                	jle    1ba7 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1bee:	90                   	nop
    1bef:	eb 04                	jmp    1bf5 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1bf1:	90                   	nop
    1bf2:	eb 01                	jmp    1bf5 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1bf4:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1bf5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1bf8:	c9                   	leave  
    1bf9:	c3                   	ret    

00001bfa <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1bfa:	55                   	push   %ebp
    1bfb:	89 e5                	mov    %esp,%ebp
    1bfd:	53                   	push   %ebx
    1bfe:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1c01:	8b 55 10             	mov    0x10(%ebp),%edx
    1c04:	8b 45 18             	mov    0x18(%ebp),%eax
    1c07:	01 d0                	add    %edx,%eax
    1c09:	83 e8 01             	sub    $0x1,%eax
    1c0c:	83 ec 04             	sub    $0x4,%esp
    1c0f:	50                   	push   %eax
    1c10:	ff 75 0c             	pushl  0xc(%ebp)
    1c13:	ff 75 10             	pushl  0x10(%ebp)
    1c16:	ff 75 0c             	pushl  0xc(%ebp)
    1c19:	ff 75 08             	pushl  0x8(%ebp)
    1c1c:	e8 16 fd ff ff       	call   1937 <APDrawLine>
    1c21:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1c24:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c27:	8b 45 14             	mov    0x14(%ebp),%eax
    1c2a:	01 d0                	add    %edx,%eax
    1c2c:	83 e8 01             	sub    $0x1,%eax
    1c2f:	83 ec 04             	sub    $0x4,%esp
    1c32:	ff 75 10             	pushl  0x10(%ebp)
    1c35:	50                   	push   %eax
    1c36:	ff 75 10             	pushl  0x10(%ebp)
    1c39:	ff 75 0c             	pushl  0xc(%ebp)
    1c3c:	ff 75 08             	pushl  0x8(%ebp)
    1c3f:	e8 f3 fc ff ff       	call   1937 <APDrawLine>
    1c44:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1c47:	8b 55 10             	mov    0x10(%ebp),%edx
    1c4a:	8b 45 18             	mov    0x18(%ebp),%eax
    1c4d:	01 d0                	add    %edx,%eax
    1c4f:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1c52:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c55:	8b 45 14             	mov    0x14(%ebp),%eax
    1c58:	01 d0                	add    %edx,%eax
    1c5a:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c5d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1c60:	8b 45 14             	mov    0x14(%ebp),%eax
    1c63:	01 d8                	add    %ebx,%eax
    1c65:	83 e8 01             	sub    $0x1,%eax
    1c68:	83 ec 04             	sub    $0x4,%esp
    1c6b:	51                   	push   %ecx
    1c6c:	52                   	push   %edx
    1c6d:	ff 75 10             	pushl  0x10(%ebp)
    1c70:	50                   	push   %eax
    1c71:	ff 75 08             	pushl  0x8(%ebp)
    1c74:	e8 be fc ff ff       	call   1937 <APDrawLine>
    1c79:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1c7c:	8b 55 10             	mov    0x10(%ebp),%edx
    1c7f:	8b 45 18             	mov    0x18(%ebp),%eax
    1c82:	01 d0                	add    %edx,%eax
    1c84:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1c87:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c8a:	8b 45 14             	mov    0x14(%ebp),%eax
    1c8d:	01 d0                	add    %edx,%eax
    1c8f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c92:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1c95:	8b 45 18             	mov    0x18(%ebp),%eax
    1c98:	01 d8                	add    %ebx,%eax
    1c9a:	83 e8 01             	sub    $0x1,%eax
    1c9d:	83 ec 04             	sub    $0x4,%esp
    1ca0:	51                   	push   %ecx
    1ca1:	52                   	push   %edx
    1ca2:	50                   	push   %eax
    1ca3:	ff 75 0c             	pushl  0xc(%ebp)
    1ca6:	ff 75 08             	pushl  0x8(%ebp)
    1ca9:	e8 89 fc ff ff       	call   1937 <APDrawLine>
    1cae:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1cb1:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cb4:	8b 45 14             	mov    0x14(%ebp),%eax
    1cb7:	01 d0                	add    %edx,%eax
    1cb9:	8d 50 ff             	lea    -0x1(%eax),%edx
    1cbc:	8b 45 08             	mov    0x8(%ebp),%eax
    1cbf:	8b 40 0c             	mov    0xc(%eax),%eax
    1cc2:	89 c1                	mov    %eax,%ecx
    1cc4:	c1 e9 1f             	shr    $0x1f,%ecx
    1cc7:	01 c8                	add    %ecx,%eax
    1cc9:	d1 f8                	sar    %eax
    1ccb:	29 c2                	sub    %eax,%edx
    1ccd:	89 d0                	mov    %edx,%eax
    1ccf:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1cd2:	8b 55 10             	mov    0x10(%ebp),%edx
    1cd5:	8b 45 18             	mov    0x18(%ebp),%eax
    1cd8:	01 d0                	add    %edx,%eax
    1cda:	8d 50 ff             	lea    -0x1(%eax),%edx
    1cdd:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce0:	8b 40 0c             	mov    0xc(%eax),%eax
    1ce3:	89 c1                	mov    %eax,%ecx
    1ce5:	c1 e9 1f             	shr    $0x1f,%ecx
    1ce8:	01 c8                	add    %ecx,%eax
    1cea:	d1 f8                	sar    %eax
    1cec:	29 c2                	sub    %eax,%edx
    1cee:	89 d0                	mov    %edx,%eax
    1cf0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1cf3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf6:	8b 40 0c             	mov    0xc(%eax),%eax
    1cf9:	89 c2                	mov    %eax,%edx
    1cfb:	c1 ea 1f             	shr    $0x1f,%edx
    1cfe:	01 d0                	add    %edx,%eax
    1d00:	d1 f8                	sar    %eax
    1d02:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1d05:	8b 45 08             	mov    0x8(%ebp),%eax
    1d08:	8b 40 0c             	mov    0xc(%eax),%eax
    1d0b:	89 c2                	mov    %eax,%edx
    1d0d:	c1 ea 1f             	shr    $0x1f,%edx
    1d10:	01 d0                	add    %edx,%eax
    1d12:	d1 f8                	sar    %eax
    1d14:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1d17:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d1b:	0f 88 d8 00 00 00    	js     1df9 <APDrawRect+0x1ff>
    1d21:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d25:	0f 88 ce 00 00 00    	js     1df9 <APDrawRect+0x1ff>
    1d2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d2e:	8b 00                	mov    (%eax),%eax
    1d30:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1d33:	0f 8e c0 00 00 00    	jle    1df9 <APDrawRect+0x1ff>
    1d39:	8b 45 08             	mov    0x8(%ebp),%eax
    1d3c:	8b 40 04             	mov    0x4(%eax),%eax
    1d3f:	3b 45 10             	cmp    0x10(%ebp),%eax
    1d42:	0f 8e b1 00 00 00    	jle    1df9 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1d48:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1d4c:	79 07                	jns    1d55 <APDrawRect+0x15b>
    1d4e:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1d55:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1d59:	79 07                	jns    1d62 <APDrawRect+0x168>
    1d5b:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1d62:	8b 45 08             	mov    0x8(%ebp),%eax
    1d65:	8b 00                	mov    (%eax),%eax
    1d67:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1d6a:	7f 0b                	jg     1d77 <APDrawRect+0x17d>
    1d6c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d6f:	8b 00                	mov    (%eax),%eax
    1d71:	83 e8 01             	sub    $0x1,%eax
    1d74:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1d77:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7a:	8b 40 04             	mov    0x4(%eax),%eax
    1d7d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1d80:	7f 0c                	jg     1d8e <APDrawRect+0x194>
    1d82:	8b 45 08             	mov    0x8(%ebp),%eax
    1d85:	8b 40 04             	mov    0x4(%eax),%eax
    1d88:	83 e8 01             	sub    $0x1,%eax
    1d8b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1d8e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1d95:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d98:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1d9b:	eb 52                	jmp    1def <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1d9d:	8b 45 10             	mov    0x10(%ebp),%eax
    1da0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1da3:	eb 3e                	jmp    1de3 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1da5:	83 ec 04             	sub    $0x4,%esp
    1da8:	ff 75 e8             	pushl  -0x18(%ebp)
    1dab:	ff 75 ec             	pushl  -0x14(%ebp)
    1dae:	ff 75 08             	pushl  0x8(%ebp)
    1db1:	e8 02 f7 ff ff       	call   14b8 <APGetIndex>
    1db6:	83 c4 10             	add    $0x10,%esp
    1db9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1dbc:	8b 45 08             	mov    0x8(%ebp),%eax
    1dbf:	8b 48 18             	mov    0x18(%eax),%ecx
    1dc2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1dc5:	89 d0                	mov    %edx,%eax
    1dc7:	01 c0                	add    %eax,%eax
    1dc9:	01 d0                	add    %edx,%eax
    1dcb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1dce:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd1:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1dd5:	66 89 0a             	mov    %cx,(%edx)
    1dd8:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1ddc:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1ddf:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1de3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1de6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1de9:	7e ba                	jle    1da5 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1deb:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1def:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1df2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1df5:	7e a6                	jle    1d9d <APDrawRect+0x1a3>
    1df7:	eb 01                	jmp    1dfa <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1df9:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1dfa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1dfd:	c9                   	leave  
    1dfe:	c3                   	ret    

00001dff <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1dff:	55                   	push   %ebp
    1e00:	89 e5                	mov    %esp,%ebp
}
    1e02:	90                   	nop
    1e03:	5d                   	pop    %ebp
    1e04:	c3                   	ret    

00001e05 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1e05:	55                   	push   %ebp
    1e06:	89 e5                	mov    %esp,%ebp
    1e08:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1e0b:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1e0f:	0f 88 8e 01 00 00    	js     1fa3 <APDcCopy+0x19e>
    1e15:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1e19:	0f 88 84 01 00 00    	js     1fa3 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1e1f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e22:	8b 45 20             	mov    0x20(%ebp),%eax
    1e25:	01 d0                	add    %edx,%eax
    1e27:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1e2a:	8b 55 10             	mov    0x10(%ebp),%edx
    1e2d:	8b 45 24             	mov    0x24(%ebp),%eax
    1e30:	01 d0                	add    %edx,%eax
    1e32:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1e35:	8b 55 18             	mov    0x18(%ebp),%edx
    1e38:	8b 45 20             	mov    0x20(%ebp),%eax
    1e3b:	01 d0                	add    %edx,%eax
    1e3d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1e40:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1e43:	8b 45 24             	mov    0x24(%ebp),%eax
    1e46:	01 d0                	add    %edx,%eax
    1e48:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1e4b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1e4f:	0f 88 51 01 00 00    	js     1fa6 <APDcCopy+0x1a1>
    1e55:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e59:	0f 88 47 01 00 00    	js     1fa6 <APDcCopy+0x1a1>
    1e5f:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1e63:	0f 88 3d 01 00 00    	js     1fa6 <APDcCopy+0x1a1>
    1e69:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1e6d:	0f 88 33 01 00 00    	js     1fa6 <APDcCopy+0x1a1>
    1e73:	8b 45 14             	mov    0x14(%ebp),%eax
    1e76:	8b 00                	mov    (%eax),%eax
    1e78:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1e7b:	0f 8c 25 01 00 00    	jl     1fa6 <APDcCopy+0x1a1>
    1e81:	8b 45 14             	mov    0x14(%ebp),%eax
    1e84:	8b 40 04             	mov    0x4(%eax),%eax
    1e87:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1e8a:	0f 8c 16 01 00 00    	jl     1fa6 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1e90:	8b 45 08             	mov    0x8(%ebp),%eax
    1e93:	8b 00                	mov    (%eax),%eax
    1e95:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1e98:	7f 0b                	jg     1ea5 <APDcCopy+0xa0>
    1e9a:	8b 45 08             	mov    0x8(%ebp),%eax
    1e9d:	8b 00                	mov    (%eax),%eax
    1e9f:	83 e8 01             	sub    $0x1,%eax
    1ea2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1ea5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea8:	8b 40 04             	mov    0x4(%eax),%eax
    1eab:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1eae:	7f 0c                	jg     1ebc <APDcCopy+0xb7>
    1eb0:	8b 45 08             	mov    0x8(%ebp),%eax
    1eb3:	8b 40 04             	mov    0x4(%eax),%eax
    1eb6:	83 e8 01             	sub    $0x1,%eax
    1eb9:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1ebc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1ec3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1eca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1ed1:	e9 bc 00 00 00       	jmp    1f92 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1ed6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ed9:	8b 00                	mov    (%eax),%eax
    1edb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1ede:	8b 55 10             	mov    0x10(%ebp),%edx
    1ee1:	01 ca                	add    %ecx,%edx
    1ee3:	0f af d0             	imul   %eax,%edx
    1ee6:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ee9:	01 d0                	add    %edx,%eax
    1eeb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1eee:	8b 45 14             	mov    0x14(%ebp),%eax
    1ef1:	8b 00                	mov    (%eax),%eax
    1ef3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1ef6:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1ef9:	01 ca                	add    %ecx,%edx
    1efb:	0f af d0             	imul   %eax,%edx
    1efe:	8b 45 18             	mov    0x18(%ebp),%eax
    1f01:	01 d0                	add    %edx,%eax
    1f03:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1f06:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1f0d:	eb 74                	jmp    1f83 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1f0f:	8b 45 14             	mov    0x14(%ebp),%eax
    1f12:	8b 50 18             	mov    0x18(%eax),%edx
    1f15:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1f18:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f1b:	01 c8                	add    %ecx,%eax
    1f1d:	89 c1                	mov    %eax,%ecx
    1f1f:	89 c8                	mov    %ecx,%eax
    1f21:	01 c0                	add    %eax,%eax
    1f23:	01 c8                	add    %ecx,%eax
    1f25:	01 d0                	add    %edx,%eax
    1f27:	0f b7 10             	movzwl (%eax),%edx
    1f2a:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1f2e:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1f32:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1f35:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1f39:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1f3d:	38 c2                	cmp    %al,%dl
    1f3f:	75 18                	jne    1f59 <APDcCopy+0x154>
    1f41:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1f45:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1f49:	38 c2                	cmp    %al,%dl
    1f4b:	75 0c                	jne    1f59 <APDcCopy+0x154>
    1f4d:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1f51:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1f55:	38 c2                	cmp    %al,%dl
    1f57:	74 26                	je     1f7f <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1f59:	8b 45 08             	mov    0x8(%ebp),%eax
    1f5c:	8b 50 18             	mov    0x18(%eax),%edx
    1f5f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1f62:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f65:	01 c8                	add    %ecx,%eax
    1f67:	89 c1                	mov    %eax,%ecx
    1f69:	89 c8                	mov    %ecx,%eax
    1f6b:	01 c0                	add    %eax,%eax
    1f6d:	01 c8                	add    %ecx,%eax
    1f6f:	01 d0                	add    %edx,%eax
    1f71:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1f75:	66 89 10             	mov    %dx,(%eax)
    1f78:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1f7c:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1f7f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1f83:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1f86:	2b 45 0c             	sub    0xc(%ebp),%eax
    1f89:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1f8c:	7d 81                	jge    1f0f <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1f8e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1f92:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f95:	2b 45 10             	sub    0x10(%ebp),%eax
    1f98:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1f9b:	0f 8d 35 ff ff ff    	jge    1ed6 <APDcCopy+0xd1>
    1fa1:	eb 04                	jmp    1fa7 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1fa3:	90                   	nop
    1fa4:	eb 01                	jmp    1fa7 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1fa6:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1fa7:	c9                   	leave  
    1fa8:	c3                   	ret    

00001fa9 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1fa9:	55                   	push   %ebp
    1faa:	89 e5                	mov    %esp,%ebp
    1fac:	83 ec 1c             	sub    $0x1c,%esp
    1faf:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1fb2:	8b 55 10             	mov    0x10(%ebp),%edx
    1fb5:	8b 45 14             	mov    0x14(%ebp),%eax
    1fb8:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1fbb:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1fbe:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1fc1:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1fc5:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1fc8:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1fcc:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1fcf:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1fd3:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1fd6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fd9:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1fdd:	66 89 10             	mov    %dx,(%eax)
    1fe0:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1fe4:	88 50 02             	mov    %dl,0x2(%eax)
}
    1fe7:	8b 45 08             	mov    0x8(%ebp),%eax
    1fea:	c9                   	leave  
    1feb:	c2 04 00             	ret    $0x4

00001fee <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1fee:	55                   	push   %ebp
    1fef:	89 e5                	mov    %esp,%ebp
    1ff1:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1ff4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ff7:	8b 00                	mov    (%eax),%eax
    1ff9:	83 ec 08             	sub    $0x8,%esp
    1ffc:	8d 55 0c             	lea    0xc(%ebp),%edx
    1fff:	52                   	push   %edx
    2000:	50                   	push   %eax
    2001:	e8 77 ef ff ff       	call   f7d <sendMessage>
    2006:	83 c4 10             	add    $0x10,%esp
}
    2009:	90                   	nop
    200a:	c9                   	leave  
    200b:	c3                   	ret    

0000200c <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    200c:	55                   	push   %ebp
    200d:	89 e5                	mov    %esp,%ebp
    200f:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    2012:	83 ec 0c             	sub    $0xc,%esp
    2015:	68 98 00 00 00       	push   $0x98
    201a:	e8 38 f3 ff ff       	call   1357 <malloc>
    201f:	83 c4 10             	add    $0x10,%esp
    2022:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    2025:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2029:	75 15                	jne    2040 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    202b:	83 ec 04             	sub    $0x4,%esp
    202e:	ff 75 08             	pushl  0x8(%ebp)
    2031:	68 50 2f 00 00       	push   $0x2f50
    2036:	6a 01                	push   $0x1
    2038:	e8 47 f0 ff ff       	call   1084 <printf>
    203d:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    2040:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2043:	05 84 00 00 00       	add    $0x84,%eax
    2048:	83 ec 08             	sub    $0x8,%esp
    204b:	ff 75 08             	pushl  0x8(%ebp)
    204e:	50                   	push   %eax
    204f:	e8 50 ec ff ff       	call   ca4 <strcpy>
    2054:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    2057:	8b 45 f4             	mov    -0xc(%ebp),%eax
    205a:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    2061:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2064:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    206b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    206e:	8b 40 3c             	mov    0x3c(%eax),%eax
    2071:	89 c2                	mov    %eax,%edx
    2073:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2076:	8b 40 40             	mov    0x40(%eax),%eax
    2079:	0f af d0             	imul   %eax,%edx
    207c:	89 d0                	mov    %edx,%eax
    207e:	01 c0                	add    %eax,%eax
    2080:	01 d0                	add    %edx,%eax
    2082:	83 ec 0c             	sub    $0xc,%esp
    2085:	50                   	push   %eax
    2086:	e8 cc f2 ff ff       	call   1357 <malloc>
    208b:	83 c4 10             	add    $0x10,%esp
    208e:	89 c2                	mov    %eax,%edx
    2090:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2093:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    2096:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2099:	8b 40 54             	mov    0x54(%eax),%eax
    209c:	85 c0                	test   %eax,%eax
    209e:	75 15                	jne    20b5 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    20a0:	83 ec 04             	sub    $0x4,%esp
    20a3:	ff 75 08             	pushl  0x8(%ebp)
    20a6:	68 70 2f 00 00       	push   $0x2f70
    20ab:	6a 01                	push   $0x1
    20ad:	e8 d2 ef ff ff       	call   1084 <printf>
    20b2:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    20b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20b8:	8b 40 3c             	mov    0x3c(%eax),%eax
    20bb:	89 c2                	mov    %eax,%edx
    20bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20c0:	8b 40 40             	mov    0x40(%eax),%eax
    20c3:	0f af d0             	imul   %eax,%edx
    20c6:	89 d0                	mov    %edx,%eax
    20c8:	01 c0                	add    %eax,%eax
    20ca:	01 c2                	add    %eax,%edx
    20cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20cf:	8b 40 54             	mov    0x54(%eax),%eax
    20d2:	83 ec 04             	sub    $0x4,%esp
    20d5:	52                   	push   %edx
    20d6:	68 ff ff ff 00       	push   $0xffffff
    20db:	50                   	push   %eax
    20dc:	e8 59 ec ff ff       	call   d3a <memset>
    20e1:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    20e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20e7:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    20ee:	e8 62 ee ff ff       	call   f55 <getpid>
    20f3:	89 c2                	mov    %eax,%edx
    20f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20f8:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    20fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20fe:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    2105:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2108:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    210f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2112:	8b 40 58             	mov    0x58(%eax),%eax
    2115:	89 c2                	mov    %eax,%edx
    2117:	8b 45 f4             	mov    -0xc(%ebp),%eax
    211a:	8b 40 5c             	mov    0x5c(%eax),%eax
    211d:	0f af d0             	imul   %eax,%edx
    2120:	89 d0                	mov    %edx,%eax
    2122:	01 c0                	add    %eax,%eax
    2124:	01 d0                	add    %edx,%eax
    2126:	83 ec 0c             	sub    $0xc,%esp
    2129:	50                   	push   %eax
    212a:	e8 28 f2 ff ff       	call   1357 <malloc>
    212f:	83 c4 10             	add    $0x10,%esp
    2132:	89 c2                	mov    %eax,%edx
    2134:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2137:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    213a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    213d:	8b 40 70             	mov    0x70(%eax),%eax
    2140:	85 c0                	test   %eax,%eax
    2142:	75 15                	jne    2159 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    2144:	83 ec 04             	sub    $0x4,%esp
    2147:	ff 75 08             	pushl  0x8(%ebp)
    214a:	68 94 2f 00 00       	push   $0x2f94
    214f:	6a 01                	push   $0x1
    2151:	e8 2e ef ff ff       	call   1084 <printf>
    2156:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    2159:	8b 45 f4             	mov    -0xc(%ebp),%eax
    215c:	8b 40 3c             	mov    0x3c(%eax),%eax
    215f:	89 c2                	mov    %eax,%edx
    2161:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2164:	8b 40 40             	mov    0x40(%eax),%eax
    2167:	0f af d0             	imul   %eax,%edx
    216a:	89 d0                	mov    %edx,%eax
    216c:	01 c0                	add    %eax,%eax
    216e:	01 c2                	add    %eax,%edx
    2170:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2173:	8b 40 54             	mov    0x54(%eax),%eax
    2176:	83 ec 04             	sub    $0x4,%esp
    2179:	52                   	push   %edx
    217a:	68 ff 00 00 00       	push   $0xff
    217f:	50                   	push   %eax
    2180:	e8 b5 eb ff ff       	call   d3a <memset>
    2185:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    2188:	8b 45 f4             	mov    -0xc(%ebp),%eax
    218b:	8b 55 0c             	mov    0xc(%ebp),%edx
    218e:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    2191:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    2195:	74 49                	je     21e0 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    2197:	8b 45 10             	mov    0x10(%ebp),%eax
    219a:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    21a0:	83 ec 0c             	sub    $0xc,%esp
    21a3:	50                   	push   %eax
    21a4:	e8 ae f1 ff ff       	call   1357 <malloc>
    21a9:	83 c4 10             	add    $0x10,%esp
    21ac:	89 c2                	mov    %eax,%edx
    21ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21b1:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    21b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21b7:	8b 55 10             	mov    0x10(%ebp),%edx
    21ba:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    21bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21c0:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    21c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21ca:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    21d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21d4:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    21db:	e9 8d 00 00 00       	jmp    226d <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    21e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21e3:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    21ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21ed:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    21f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21f7:	8b 40 20             	mov    0x20(%eax),%eax
    21fa:	89 c2                	mov    %eax,%edx
    21fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21ff:	8b 40 24             	mov    0x24(%eax),%eax
    2202:	0f af d0             	imul   %eax,%edx
    2205:	89 d0                	mov    %edx,%eax
    2207:	01 c0                	add    %eax,%eax
    2209:	01 d0                	add    %edx,%eax
    220b:	83 ec 0c             	sub    $0xc,%esp
    220e:	50                   	push   %eax
    220f:	e8 43 f1 ff ff       	call   1357 <malloc>
    2214:	83 c4 10             	add    $0x10,%esp
    2217:	89 c2                	mov    %eax,%edx
    2219:	8b 45 f4             	mov    -0xc(%ebp),%eax
    221c:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    221f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2222:	8b 40 38             	mov    0x38(%eax),%eax
    2225:	85 c0                	test   %eax,%eax
    2227:	75 15                	jne    223e <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    2229:	83 ec 04             	sub    $0x4,%esp
    222c:	ff 75 08             	pushl  0x8(%ebp)
    222f:	68 bc 2f 00 00       	push   $0x2fbc
    2234:	6a 01                	push   $0x1
    2236:	e8 49 ee ff ff       	call   1084 <printf>
    223b:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    223e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2241:	8b 40 20             	mov    0x20(%eax),%eax
    2244:	89 c2                	mov    %eax,%edx
    2246:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2249:	8b 40 24             	mov    0x24(%eax),%eax
    224c:	0f af d0             	imul   %eax,%edx
    224f:	89 d0                	mov    %edx,%eax
    2251:	01 c0                	add    %eax,%eax
    2253:	01 c2                	add    %eax,%edx
    2255:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2258:	8b 40 38             	mov    0x38(%eax),%eax
    225b:	83 ec 04             	sub    $0x4,%esp
    225e:	52                   	push   %edx
    225f:	68 ff ff ff 00       	push   $0xffffff
    2264:	50                   	push   %eax
    2265:	e8 d0 ea ff ff       	call   d3a <memset>
    226a:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    226d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    2270:	c9                   	leave  
    2271:	c3                   	ret    

00002272 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    2272:	55                   	push   %ebp
    2273:	89 e5                	mov    %esp,%ebp
    2275:	57                   	push   %edi
    2276:	56                   	push   %esi
    2277:	53                   	push   %ebx
    2278:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    227b:	8b 45 0c             	mov    0xc(%ebp),%eax
    227e:	83 f8 03             	cmp    $0x3,%eax
    2281:	74 02                	je     2285 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    2283:	eb 7c                	jmp    2301 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    2285:	8b 45 08             	mov    0x8(%ebp),%eax
    2288:	8b 58 1c             	mov    0x1c(%eax),%ebx
    228b:	8b 45 08             	mov    0x8(%ebp),%eax
    228e:	8b 48 18             	mov    0x18(%eax),%ecx
    2291:	8b 45 08             	mov    0x8(%ebp),%eax
    2294:	8b 50 5c             	mov    0x5c(%eax),%edx
    2297:	8b 45 08             	mov    0x8(%ebp),%eax
    229a:	8b 40 58             	mov    0x58(%eax),%eax
    229d:	8b 75 08             	mov    0x8(%ebp),%esi
    22a0:	83 c6 58             	add    $0x58,%esi
    22a3:	83 ec 04             	sub    $0x4,%esp
    22a6:	53                   	push   %ebx
    22a7:	51                   	push   %ecx
    22a8:	6a 00                	push   $0x0
    22aa:	52                   	push   %edx
    22ab:	50                   	push   %eax
    22ac:	6a 00                	push   $0x0
    22ae:	6a 00                	push   $0x0
    22b0:	56                   	push   %esi
    22b1:	6a 00                	push   $0x0
    22b3:	6a 00                	push   $0x0
    22b5:	ff 75 08             	pushl  0x8(%ebp)
    22b8:	e8 b8 ec ff ff       	call   f75 <paintWindow>
    22bd:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    22c0:	8b 45 08             	mov    0x8(%ebp),%eax
    22c3:	8b 70 1c             	mov    0x1c(%eax),%esi
    22c6:	8b 45 08             	mov    0x8(%ebp),%eax
    22c9:	8b 58 18             	mov    0x18(%eax),%ebx
    22cc:	8b 45 08             	mov    0x8(%ebp),%eax
    22cf:	8b 48 08             	mov    0x8(%eax),%ecx
    22d2:	8b 45 08             	mov    0x8(%ebp),%eax
    22d5:	8b 50 40             	mov    0x40(%eax),%edx
    22d8:	8b 45 08             	mov    0x8(%ebp),%eax
    22db:	8b 40 3c             	mov    0x3c(%eax),%eax
    22de:	8b 7d 08             	mov    0x8(%ebp),%edi
    22e1:	83 c7 3c             	add    $0x3c,%edi
    22e4:	83 ec 04             	sub    $0x4,%esp
    22e7:	56                   	push   %esi
    22e8:	53                   	push   %ebx
    22e9:	51                   	push   %ecx
    22ea:	52                   	push   %edx
    22eb:	50                   	push   %eax
    22ec:	6a 00                	push   $0x0
    22ee:	6a 00                	push   $0x0
    22f0:	57                   	push   %edi
    22f1:	6a 32                	push   $0x32
    22f3:	6a 00                	push   $0x0
    22f5:	ff 75 08             	pushl  0x8(%ebp)
    22f8:	e8 78 ec ff ff       	call   f75 <paintWindow>
    22fd:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    2300:	90                   	nop
        default: break;
            
            
    }
    return False;
    2301:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2306:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2309:	5b                   	pop    %ebx
    230a:	5e                   	pop    %esi
    230b:	5f                   	pop    %edi
    230c:	5d                   	pop    %ebp
    230d:	c3                   	ret    

0000230e <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    230e:	55                   	push   %ebp
    230f:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    2311:	8b 45 0c             	mov    0xc(%ebp),%eax
    2314:	8b 50 08             	mov    0x8(%eax),%edx
    2317:	8b 45 08             	mov    0x8(%ebp),%eax
    231a:	8b 00                	mov    (%eax),%eax
    231c:	39 c2                	cmp    %eax,%edx
    231e:	74 07                	je     2327 <APPreJudge+0x19>
        return False;
    2320:	b8 00 00 00 00       	mov    $0x0,%eax
    2325:	eb 05                	jmp    232c <APPreJudge+0x1e>
    return True;
    2327:	b8 01 00 00 00       	mov    $0x1,%eax
}
    232c:	5d                   	pop    %ebp
    232d:	c3                   	ret    

0000232e <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    232e:	55                   	push   %ebp
    232f:	89 e5                	mov    %esp,%ebp
    2331:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    2334:	8b 45 08             	mov    0x8(%ebp),%eax
    2337:	8b 55 0c             	mov    0xc(%ebp),%edx
    233a:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    2340:	83 ec 0c             	sub    $0xc,%esp
    2343:	ff 75 08             	pushl  0x8(%ebp)
    2346:	e8 42 ec ff ff       	call   f8d <registWindow>
    234b:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    234e:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    2355:	8b 45 08             	mov    0x8(%ebp),%eax
    2358:	8b 00                	mov    (%eax),%eax
    235a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    235d:	ff 75 f4             	pushl  -0xc(%ebp)
    2360:	ff 75 f0             	pushl  -0x10(%ebp)
    2363:	ff 75 ec             	pushl  -0x14(%ebp)
    2366:	ff 75 08             	pushl  0x8(%ebp)
    2369:	e8 80 fc ff ff       	call   1fee <APSendMessage>
    236e:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    2371:	83 ec 0c             	sub    $0xc,%esp
    2374:	ff 75 08             	pushl  0x8(%ebp)
    2377:	e8 09 ec ff ff       	call   f85 <getMessage>
    237c:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    237f:	8b 45 08             	mov    0x8(%ebp),%eax
    2382:	83 c0 74             	add    $0x74,%eax
    2385:	83 ec 08             	sub    $0x8,%esp
    2388:	50                   	push   %eax
    2389:	ff 75 08             	pushl  0x8(%ebp)
    238c:	e8 7d ff ff ff       	call   230e <APPreJudge>
    2391:	83 c4 10             	add    $0x10,%esp
    2394:	84 c0                	test   %al,%al
    2396:	74 1b                	je     23b3 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    2398:	8b 45 08             	mov    0x8(%ebp),%eax
    239b:	ff 70 7c             	pushl  0x7c(%eax)
    239e:	ff 70 78             	pushl  0x78(%eax)
    23a1:	ff 70 74             	pushl  0x74(%eax)
    23a4:	ff 75 08             	pushl  0x8(%ebp)
    23a7:	8b 45 0c             	mov    0xc(%ebp),%eax
    23aa:	ff d0                	call   *%eax
    23ac:	83 c4 10             	add    $0x10,%esp
    23af:	84 c0                	test   %al,%al
    23b1:	75 0c                	jne    23bf <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    23b3:	8b 45 08             	mov    0x8(%ebp),%eax
    23b6:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    23bd:	eb b2                	jmp    2371 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    23bf:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    23c0:	90                   	nop
    23c1:	c9                   	leave  
    23c2:	c3                   	ret    

000023c3 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    23c3:	55                   	push   %ebp
    23c4:	89 e5                	mov    %esp,%ebp
    23c6:	57                   	push   %edi
    23c7:	56                   	push   %esi
    23c8:	53                   	push   %ebx
    23c9:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    23cc:	a1 f0 38 00 00       	mov    0x38f0,%eax
    23d1:	85 c0                	test   %eax,%eax
    23d3:	0f 85 2c 02 00 00    	jne    2605 <APGridPaint+0x242>
    {
        iconReady = 1;
    23d9:	c7 05 f0 38 00 00 01 	movl   $0x1,0x38f0
    23e0:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    23e3:	8d 45 98             	lea    -0x68(%ebp),%eax
    23e6:	83 ec 08             	sub    $0x8,%esp
    23e9:	68 e3 2f 00 00       	push   $0x2fe3
    23ee:	50                   	push   %eax
    23ef:	e8 16 f1 ff ff       	call   150a <APLoadBitmap>
    23f4:	83 c4 0c             	add    $0xc,%esp
    23f7:	8b 45 98             	mov    -0x68(%ebp),%eax
    23fa:	a3 14 39 00 00       	mov    %eax,0x3914
    23ff:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2402:	a3 18 39 00 00       	mov    %eax,0x3918
    2407:	8b 45 a0             	mov    -0x60(%ebp),%eax
    240a:	a3 1c 39 00 00       	mov    %eax,0x391c
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    240f:	83 ec 04             	sub    $0x4,%esp
    2412:	ff 35 1c 39 00 00    	pushl  0x391c
    2418:	ff 35 18 39 00 00    	pushl  0x3918
    241e:	ff 35 14 39 00 00    	pushl  0x3914
    2424:	e8 1b f3 ff ff       	call   1744 <APCreateCompatibleDCFromBitmap>
    2429:	83 c4 10             	add    $0x10,%esp
    242c:	a3 20 39 00 00       	mov    %eax,0x3920
        grid_river = APLoadBitmap ("grid_river.bmp");
    2431:	8d 45 98             	lea    -0x68(%ebp),%eax
    2434:	83 ec 08             	sub    $0x8,%esp
    2437:	68 f1 2f 00 00       	push   $0x2ff1
    243c:	50                   	push   %eax
    243d:	e8 c8 f0 ff ff       	call   150a <APLoadBitmap>
    2442:	83 c4 0c             	add    $0xc,%esp
    2445:	8b 45 98             	mov    -0x68(%ebp),%eax
    2448:	a3 50 39 00 00       	mov    %eax,0x3950
    244d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2450:	a3 54 39 00 00       	mov    %eax,0x3954
    2455:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2458:	a3 58 39 00 00       	mov    %eax,0x3958
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    245d:	83 ec 04             	sub    $0x4,%esp
    2460:	ff 35 58 39 00 00    	pushl  0x3958
    2466:	ff 35 54 39 00 00    	pushl  0x3954
    246c:	ff 35 50 39 00 00    	pushl  0x3950
    2472:	e8 cd f2 ff ff       	call   1744 <APCreateCompatibleDCFromBitmap>
    2477:	83 c4 10             	add    $0x10,%esp
    247a:	a3 40 39 00 00       	mov    %eax,0x3940
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    247f:	8d 45 98             	lea    -0x68(%ebp),%eax
    2482:	83 ec 08             	sub    $0x8,%esp
    2485:	68 00 30 00 00       	push   $0x3000
    248a:	50                   	push   %eax
    248b:	e8 7a f0 ff ff       	call   150a <APLoadBitmap>
    2490:	83 c4 0c             	add    $0xc,%esp
    2493:	8b 45 98             	mov    -0x68(%ebp),%eax
    2496:	a3 44 39 00 00       	mov    %eax,0x3944
    249b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    249e:	a3 48 39 00 00       	mov    %eax,0x3948
    24a3:	8b 45 a0             	mov    -0x60(%ebp),%eax
    24a6:	a3 4c 39 00 00       	mov    %eax,0x394c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    24ab:	83 ec 04             	sub    $0x4,%esp
    24ae:	ff 35 4c 39 00 00    	pushl  0x394c
    24b4:	ff 35 48 39 00 00    	pushl  0x3948
    24ba:	ff 35 44 39 00 00    	pushl  0x3944
    24c0:	e8 7f f2 ff ff       	call   1744 <APCreateCompatibleDCFromBitmap>
    24c5:	83 c4 10             	add    $0x10,%esp
    24c8:	a3 f4 38 00 00       	mov    %eax,0x38f4
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    24cd:	8d 45 98             	lea    -0x68(%ebp),%eax
    24d0:	83 ec 08             	sub    $0x8,%esp
    24d3:	68 0f 30 00 00       	push   $0x300f
    24d8:	50                   	push   %eax
    24d9:	e8 2c f0 ff ff       	call   150a <APLoadBitmap>
    24de:	83 c4 0c             	add    $0xc,%esp
    24e1:	8b 45 98             	mov    -0x68(%ebp),%eax
    24e4:	a3 28 39 00 00       	mov    %eax,0x3928
    24e9:	8b 45 9c             	mov    -0x64(%ebp),%eax
    24ec:	a3 2c 39 00 00       	mov    %eax,0x392c
    24f1:	8b 45 a0             	mov    -0x60(%ebp),%eax
    24f4:	a3 30 39 00 00       	mov    %eax,0x3930
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    24f9:	83 ec 04             	sub    $0x4,%esp
    24fc:	ff 35 30 39 00 00    	pushl  0x3930
    2502:	ff 35 2c 39 00 00    	pushl  0x392c
    2508:	ff 35 28 39 00 00    	pushl  0x3928
    250e:	e8 31 f2 ff ff       	call   1744 <APCreateCompatibleDCFromBitmap>
    2513:	83 c4 10             	add    $0x10,%esp
    2516:	a3 5c 39 00 00       	mov    %eax,0x395c
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    251b:	8d 45 98             	lea    -0x68(%ebp),%eax
    251e:	83 ec 08             	sub    $0x8,%esp
    2521:	68 1d 30 00 00       	push   $0x301d
    2526:	50                   	push   %eax
    2527:	e8 de ef ff ff       	call   150a <APLoadBitmap>
    252c:	83 c4 0c             	add    $0xc,%esp
    252f:	8b 45 98             	mov    -0x68(%ebp),%eax
    2532:	a3 04 39 00 00       	mov    %eax,0x3904
    2537:	8b 45 9c             	mov    -0x64(%ebp),%eax
    253a:	a3 08 39 00 00       	mov    %eax,0x3908
    253f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2542:	a3 0c 39 00 00       	mov    %eax,0x390c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    2547:	83 ec 04             	sub    $0x4,%esp
    254a:	ff 35 0c 39 00 00    	pushl  0x390c
    2550:	ff 35 08 39 00 00    	pushl  0x3908
    2556:	ff 35 04 39 00 00    	pushl  0x3904
    255c:	e8 e3 f1 ff ff       	call   1744 <APCreateCompatibleDCFromBitmap>
    2561:	83 c4 10             	add    $0x10,%esp
    2564:	a3 24 39 00 00       	mov    %eax,0x3924
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    2569:	8d 45 98             	lea    -0x68(%ebp),%eax
    256c:	83 ec 08             	sub    $0x8,%esp
    256f:	68 2d 30 00 00       	push   $0x302d
    2574:	50                   	push   %eax
    2575:	e8 90 ef ff ff       	call   150a <APLoadBitmap>
    257a:	83 c4 0c             	add    $0xc,%esp
    257d:	8b 45 98             	mov    -0x68(%ebp),%eax
    2580:	a3 f8 38 00 00       	mov    %eax,0x38f8
    2585:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2588:	a3 fc 38 00 00       	mov    %eax,0x38fc
    258d:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2590:	a3 00 39 00 00       	mov    %eax,0x3900
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    2595:	83 ec 04             	sub    $0x4,%esp
    2598:	ff 35 00 39 00 00    	pushl  0x3900
    259e:	ff 35 fc 38 00 00    	pushl  0x38fc
    25a4:	ff 35 f8 38 00 00    	pushl  0x38f8
    25aa:	e8 95 f1 ff ff       	call   1744 <APCreateCompatibleDCFromBitmap>
    25af:	83 c4 10             	add    $0x10,%esp
    25b2:	a3 10 39 00 00       	mov    %eax,0x3910
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    25b7:	8d 45 98             	lea    -0x68(%ebp),%eax
    25ba:	83 ec 08             	sub    $0x8,%esp
    25bd:	68 3f 30 00 00       	push   $0x303f
    25c2:	50                   	push   %eax
    25c3:	e8 42 ef ff ff       	call   150a <APLoadBitmap>
    25c8:	83 c4 0c             	add    $0xc,%esp
    25cb:	8b 45 98             	mov    -0x68(%ebp),%eax
    25ce:	a3 34 39 00 00       	mov    %eax,0x3934
    25d3:	8b 45 9c             	mov    -0x64(%ebp),%eax
    25d6:	a3 38 39 00 00       	mov    %eax,0x3938
    25db:	8b 45 a0             	mov    -0x60(%ebp),%eax
    25de:	a3 3c 39 00 00       	mov    %eax,0x393c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    25e3:	83 ec 04             	sub    $0x4,%esp
    25e6:	ff 35 3c 39 00 00    	pushl  0x393c
    25ec:	ff 35 38 39 00 00    	pushl  0x3938
    25f2:	ff 35 34 39 00 00    	pushl  0x3934
    25f8:	e8 47 f1 ff ff       	call   1744 <APCreateCompatibleDCFromBitmap>
    25fd:	83 c4 10             	add    $0x10,%esp
    2600:	a3 60 39 00 00       	mov    %eax,0x3960
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    2605:	8b 45 08             	mov    0x8(%ebp),%eax
    2608:	8b 40 08             	mov    0x8(%eax),%eax
    260b:	85 c0                	test   %eax,%eax
    260d:	75 17                	jne    2626 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    260f:	83 ec 08             	sub    $0x8,%esp
    2612:	68 50 30 00 00       	push   $0x3050
    2617:	6a 01                	push   $0x1
    2619:	e8 66 ea ff ff       	call   1084 <printf>
    261e:	83 c4 10             	add    $0x10,%esp
        return;
    2621:	e9 a0 04 00 00       	jmp    2ac6 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    2626:	8b 45 08             	mov    0x8(%ebp),%eax
    2629:	8b 40 10             	mov    0x10(%eax),%eax
    262c:	85 c0                	test   %eax,%eax
    262e:	7e 10                	jle    2640 <APGridPaint+0x27d>
    2630:	8b 45 08             	mov    0x8(%ebp),%eax
    2633:	8b 50 14             	mov    0x14(%eax),%edx
    2636:	8b 45 08             	mov    0x8(%ebp),%eax
    2639:	8b 40 10             	mov    0x10(%eax),%eax
    263c:	39 c2                	cmp    %eax,%edx
    263e:	7c 17                	jl     2657 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    2640:	83 ec 08             	sub    $0x8,%esp
    2643:	68 76 30 00 00       	push   $0x3076
    2648:	6a 01                	push   $0x1
    264a:	e8 35 ea ff ff       	call   1084 <printf>
    264f:	83 c4 10             	add    $0x10,%esp
        return;
    2652:	e9 6f 04 00 00       	jmp    2ac6 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    2657:	8b 45 08             	mov    0x8(%ebp),%eax
    265a:	8b 40 14             	mov    0x14(%eax),%eax
    265d:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    2663:	89 45 dc             	mov    %eax,-0x24(%ebp)
    2666:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2669:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    266c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    2673:	e9 96 03 00 00       	jmp    2a0e <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2678:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    267f:	e9 7c 03 00 00       	jmp    2a00 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    2684:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2687:	c1 e0 04             	shl    $0x4,%eax
    268a:	89 c2                	mov    %eax,%edx
    268c:	8b 45 d8             	mov    -0x28(%ebp),%eax
    268f:	01 c2                	add    %eax,%edx
    2691:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2694:	01 d0                	add    %edx,%eax
    2696:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    2699:	8b 45 08             	mov    0x8(%ebp),%eax
    269c:	8b 40 0c             	mov    0xc(%eax),%eax
    269f:	8b 55 dc             	mov    -0x24(%ebp),%edx
    26a2:	c1 e2 02             	shl    $0x2,%edx
    26a5:	01 d0                	add    %edx,%eax
    26a7:	8b 00                	mov    (%eax),%eax
    26a9:	83 f8 07             	cmp    $0x7,%eax
    26ac:	0f 87 49 03 00 00    	ja     29fb <APGridPaint+0x638>
    26b2:	8b 04 85 8c 30 00 00 	mov    0x308c(,%eax,4),%eax
    26b9:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    26bb:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    26be:	6a 0c                	push   $0xc
    26c0:	6a 0c                	push   $0xc
    26c2:	6a 0c                	push   $0xc
    26c4:	50                   	push   %eax
    26c5:	e8 df f8 ff ff       	call   1fa9 <RGB>
    26ca:	83 c4 0c             	add    $0xc,%esp
    26cd:	8b 1d 20 39 00 00    	mov    0x3920,%ebx
    26d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    26d6:	6b c8 32             	imul   $0x32,%eax,%ecx
    26d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    26dc:	6b c0 32             	imul   $0x32,%eax,%eax
    26df:	89 45 94             	mov    %eax,-0x6c(%ebp)
    26e2:	8b 45 08             	mov    0x8(%ebp),%eax
    26e5:	8d 78 3c             	lea    0x3c(%eax),%edi
    26e8:	83 ec 0c             	sub    $0xc,%esp
    26eb:	83 ec 04             	sub    $0x4,%esp
    26ee:	89 e0                	mov    %esp,%eax
    26f0:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    26f4:	66 89 30             	mov    %si,(%eax)
    26f7:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    26fb:	88 50 02             	mov    %dl,0x2(%eax)
    26fe:	6a 32                	push   $0x32
    2700:	6a 32                	push   $0x32
    2702:	6a 00                	push   $0x0
    2704:	6a 00                	push   $0x0
    2706:	53                   	push   %ebx
    2707:	51                   	push   %ecx
    2708:	ff 75 94             	pushl  -0x6c(%ebp)
    270b:	57                   	push   %edi
    270c:	e8 f4 f6 ff ff       	call   1e05 <APDcCopy>
    2711:	83 c4 30             	add    $0x30,%esp
                    break;
    2714:	e9 e3 02 00 00       	jmp    29fc <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    2719:	8d 45 98             	lea    -0x68(%ebp),%eax
    271c:	6a 69                	push   $0x69
    271e:	6a 69                	push   $0x69
    2720:	6a 69                	push   $0x69
    2722:	50                   	push   %eax
    2723:	e8 81 f8 ff ff       	call   1fa9 <RGB>
    2728:	83 c4 0c             	add    $0xc,%esp
    272b:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    272f:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    2733:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2737:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    273a:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    2741:	8d 45 98             	lea    -0x68(%ebp),%eax
    2744:	6a 69                	push   $0x69
    2746:	6a 69                	push   $0x69
    2748:	6a 69                	push   $0x69
    274a:	50                   	push   %eax
    274b:	e8 59 f8 ff ff       	call   1fa9 <RGB>
    2750:	83 c4 0c             	add    $0xc,%esp
    2753:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2757:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    275b:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    275f:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    2762:	8b 45 08             	mov    0x8(%ebp),%eax
    2765:	8d 50 3c             	lea    0x3c(%eax),%edx
    2768:	8d 45 98             	lea    -0x68(%ebp),%eax
    276b:	ff 75 b0             	pushl  -0x50(%ebp)
    276e:	ff 75 ac             	pushl  -0x54(%ebp)
    2771:	52                   	push   %edx
    2772:	50                   	push   %eax
    2773:	e8 61 f0 ff ff       	call   17d9 <APSetPen>
    2778:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    277b:	8b 45 08             	mov    0x8(%ebp),%eax
    277e:	8d 58 3c             	lea    0x3c(%eax),%ebx
    2781:	8d 55 98             	lea    -0x68(%ebp),%edx
    2784:	83 ec 04             	sub    $0x4,%esp
    2787:	83 ec 04             	sub    $0x4,%esp
    278a:	89 e0                	mov    %esp,%eax
    278c:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    2790:	66 89 08             	mov    %cx,(%eax)
    2793:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    2797:	88 48 02             	mov    %cl,0x2(%eax)
    279a:	53                   	push   %ebx
    279b:	52                   	push   %edx
    279c:	e8 71 f0 ff ff       	call   1812 <APSetBrush>
    27a1:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    27a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    27a7:	6b d0 32             	imul   $0x32,%eax,%edx
    27aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
    27ad:	6b c0 32             	imul   $0x32,%eax,%eax
    27b0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    27b3:	83 c1 3c             	add    $0x3c,%ecx
    27b6:	83 ec 0c             	sub    $0xc,%esp
    27b9:	6a 32                	push   $0x32
    27bb:	6a 32                	push   $0x32
    27bd:	52                   	push   %edx
    27be:	50                   	push   %eax
    27bf:	51                   	push   %ecx
    27c0:	e8 35 f4 ff ff       	call   1bfa <APDrawRect>
    27c5:	83 c4 20             	add    $0x20,%esp
                    break;
    27c8:	e9 2f 02 00 00       	jmp    29fc <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    27cd:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    27d0:	6a 0c                	push   $0xc
    27d2:	6a 0c                	push   $0xc
    27d4:	6a 0c                	push   $0xc
    27d6:	50                   	push   %eax
    27d7:	e8 cd f7 ff ff       	call   1fa9 <RGB>
    27dc:	83 c4 0c             	add    $0xc,%esp
    27df:	8b 1d 60 39 00 00    	mov    0x3960,%ebx
    27e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    27e8:	6b c8 32             	imul   $0x32,%eax,%ecx
    27eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    27ee:	6b c0 32             	imul   $0x32,%eax,%eax
    27f1:	89 45 94             	mov    %eax,-0x6c(%ebp)
    27f4:	8b 45 08             	mov    0x8(%ebp),%eax
    27f7:	8d 78 3c             	lea    0x3c(%eax),%edi
    27fa:	83 ec 0c             	sub    $0xc,%esp
    27fd:	83 ec 04             	sub    $0x4,%esp
    2800:	89 e0                	mov    %esp,%eax
    2802:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    2806:	66 89 30             	mov    %si,(%eax)
    2809:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    280d:	88 50 02             	mov    %dl,0x2(%eax)
    2810:	6a 32                	push   $0x32
    2812:	6a 32                	push   $0x32
    2814:	6a 00                	push   $0x0
    2816:	6a 00                	push   $0x0
    2818:	53                   	push   %ebx
    2819:	51                   	push   %ecx
    281a:	ff 75 94             	pushl  -0x6c(%ebp)
    281d:	57                   	push   %edi
    281e:	e8 e2 f5 ff ff       	call   1e05 <APDcCopy>
    2823:	83 c4 30             	add    $0x30,%esp
                    break;
    2826:	e9 d1 01 00 00       	jmp    29fc <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    282b:	8d 45 c9             	lea    -0x37(%ebp),%eax
    282e:	6a 0c                	push   $0xc
    2830:	6a 0c                	push   $0xc
    2832:	6a 0c                	push   $0xc
    2834:	50                   	push   %eax
    2835:	e8 6f f7 ff ff       	call   1fa9 <RGB>
    283a:	83 c4 0c             	add    $0xc,%esp
    283d:	8b 1d 40 39 00 00    	mov    0x3940,%ebx
    2843:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2846:	6b c8 32             	imul   $0x32,%eax,%ecx
    2849:	8b 45 e0             	mov    -0x20(%ebp),%eax
    284c:	6b c0 32             	imul   $0x32,%eax,%eax
    284f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2852:	8b 45 08             	mov    0x8(%ebp),%eax
    2855:	8d 78 3c             	lea    0x3c(%eax),%edi
    2858:	83 ec 0c             	sub    $0xc,%esp
    285b:	83 ec 04             	sub    $0x4,%esp
    285e:	89 e0                	mov    %esp,%eax
    2860:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    2864:	66 89 30             	mov    %si,(%eax)
    2867:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    286b:	88 50 02             	mov    %dl,0x2(%eax)
    286e:	6a 32                	push   $0x32
    2870:	6a 32                	push   $0x32
    2872:	6a 00                	push   $0x0
    2874:	6a 00                	push   $0x0
    2876:	53                   	push   %ebx
    2877:	51                   	push   %ecx
    2878:	ff 75 94             	pushl  -0x6c(%ebp)
    287b:	57                   	push   %edi
    287c:	e8 84 f5 ff ff       	call   1e05 <APDcCopy>
    2881:	83 c4 30             	add    $0x30,%esp
                    break;
    2884:	e9 73 01 00 00       	jmp    29fc <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2889:	8d 45 cc             	lea    -0x34(%ebp),%eax
    288c:	6a 0c                	push   $0xc
    288e:	6a 0c                	push   $0xc
    2890:	6a 0c                	push   $0xc
    2892:	50                   	push   %eax
    2893:	e8 11 f7 ff ff       	call   1fa9 <RGB>
    2898:	83 c4 0c             	add    $0xc,%esp
    289b:	8b 1d 24 39 00 00    	mov    0x3924,%ebx
    28a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    28a4:	6b c8 32             	imul   $0x32,%eax,%ecx
    28a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    28aa:	6b c0 32             	imul   $0x32,%eax,%eax
    28ad:	89 45 94             	mov    %eax,-0x6c(%ebp)
    28b0:	8b 45 08             	mov    0x8(%ebp),%eax
    28b3:	8d 78 3c             	lea    0x3c(%eax),%edi
    28b6:	83 ec 0c             	sub    $0xc,%esp
    28b9:	83 ec 04             	sub    $0x4,%esp
    28bc:	89 e0                	mov    %esp,%eax
    28be:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    28c2:	66 89 30             	mov    %si,(%eax)
    28c5:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    28c9:	88 50 02             	mov    %dl,0x2(%eax)
    28cc:	6a 32                	push   $0x32
    28ce:	6a 32                	push   $0x32
    28d0:	6a 00                	push   $0x0
    28d2:	6a 00                	push   $0x0
    28d4:	53                   	push   %ebx
    28d5:	51                   	push   %ecx
    28d6:	ff 75 94             	pushl  -0x6c(%ebp)
    28d9:	57                   	push   %edi
    28da:	e8 26 f5 ff ff       	call   1e05 <APDcCopy>
    28df:	83 c4 30             	add    $0x30,%esp
                    break;
    28e2:	e9 15 01 00 00       	jmp    29fc <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    28e7:	8d 45 cf             	lea    -0x31(%ebp),%eax
    28ea:	6a 0c                	push   $0xc
    28ec:	6a 0c                	push   $0xc
    28ee:	6a 0c                	push   $0xc
    28f0:	50                   	push   %eax
    28f1:	e8 b3 f6 ff ff       	call   1fa9 <RGB>
    28f6:	83 c4 0c             	add    $0xc,%esp
    28f9:	8b 1d 5c 39 00 00    	mov    0x395c,%ebx
    28ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2902:	6b c8 32             	imul   $0x32,%eax,%ecx
    2905:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2908:	6b c0 32             	imul   $0x32,%eax,%eax
    290b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    290e:	8b 45 08             	mov    0x8(%ebp),%eax
    2911:	8d 78 3c             	lea    0x3c(%eax),%edi
    2914:	83 ec 0c             	sub    $0xc,%esp
    2917:	83 ec 04             	sub    $0x4,%esp
    291a:	89 e0                	mov    %esp,%eax
    291c:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    2920:	66 89 30             	mov    %si,(%eax)
    2923:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2927:	88 50 02             	mov    %dl,0x2(%eax)
    292a:	6a 32                	push   $0x32
    292c:	6a 32                	push   $0x32
    292e:	6a 00                	push   $0x0
    2930:	6a 00                	push   $0x0
    2932:	53                   	push   %ebx
    2933:	51                   	push   %ecx
    2934:	ff 75 94             	pushl  -0x6c(%ebp)
    2937:	57                   	push   %edi
    2938:	e8 c8 f4 ff ff       	call   1e05 <APDcCopy>
    293d:	83 c4 30             	add    $0x30,%esp
                    break;
    2940:	e9 b7 00 00 00       	jmp    29fc <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2945:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2948:	6a 0c                	push   $0xc
    294a:	6a 0c                	push   $0xc
    294c:	6a 0c                	push   $0xc
    294e:	50                   	push   %eax
    294f:	e8 55 f6 ff ff       	call   1fa9 <RGB>
    2954:	83 c4 0c             	add    $0xc,%esp
    2957:	8b 1d f4 38 00 00    	mov    0x38f4,%ebx
    295d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2960:	6b c8 32             	imul   $0x32,%eax,%ecx
    2963:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2966:	6b c0 32             	imul   $0x32,%eax,%eax
    2969:	89 45 94             	mov    %eax,-0x6c(%ebp)
    296c:	8b 45 08             	mov    0x8(%ebp),%eax
    296f:	8d 78 3c             	lea    0x3c(%eax),%edi
    2972:	83 ec 0c             	sub    $0xc,%esp
    2975:	83 ec 04             	sub    $0x4,%esp
    2978:	89 e0                	mov    %esp,%eax
    297a:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    297e:	66 89 30             	mov    %si,(%eax)
    2981:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2985:	88 50 02             	mov    %dl,0x2(%eax)
    2988:	6a 32                	push   $0x32
    298a:	6a 32                	push   $0x32
    298c:	6a 00                	push   $0x0
    298e:	6a 00                	push   $0x0
    2990:	53                   	push   %ebx
    2991:	51                   	push   %ecx
    2992:	ff 75 94             	pushl  -0x6c(%ebp)
    2995:	57                   	push   %edi
    2996:	e8 6a f4 ff ff       	call   1e05 <APDcCopy>
    299b:	83 c4 30             	add    $0x30,%esp
                    break;
    299e:	eb 5c                	jmp    29fc <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    29a0:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    29a3:	6a 0c                	push   $0xc
    29a5:	6a 0c                	push   $0xc
    29a7:	6a 0c                	push   $0xc
    29a9:	50                   	push   %eax
    29aa:	e8 fa f5 ff ff       	call   1fa9 <RGB>
    29af:	83 c4 0c             	add    $0xc,%esp
    29b2:	8b 1d 10 39 00 00    	mov    0x3910,%ebx
    29b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    29bb:	6b c8 32             	imul   $0x32,%eax,%ecx
    29be:	8b 45 e0             	mov    -0x20(%ebp),%eax
    29c1:	6b c0 32             	imul   $0x32,%eax,%eax
    29c4:	89 45 94             	mov    %eax,-0x6c(%ebp)
    29c7:	8b 45 08             	mov    0x8(%ebp),%eax
    29ca:	8d 78 3c             	lea    0x3c(%eax),%edi
    29cd:	83 ec 0c             	sub    $0xc,%esp
    29d0:	83 ec 04             	sub    $0x4,%esp
    29d3:	89 e0                	mov    %esp,%eax
    29d5:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    29d9:	66 89 30             	mov    %si,(%eax)
    29dc:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    29e0:	88 50 02             	mov    %dl,0x2(%eax)
    29e3:	6a 32                	push   $0x32
    29e5:	6a 32                	push   $0x32
    29e7:	6a 00                	push   $0x0
    29e9:	6a 00                	push   $0x0
    29eb:	53                   	push   %ebx
    29ec:	51                   	push   %ecx
    29ed:	ff 75 94             	pushl  -0x6c(%ebp)
    29f0:	57                   	push   %edi
    29f1:	e8 0f f4 ff ff       	call   1e05 <APDcCopy>
    29f6:	83 c4 30             	add    $0x30,%esp
                    break;
    29f9:	eb 01                	jmp    29fc <APGridPaint+0x639>
                default: break;
    29fb:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    29fc:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2a00:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2a04:	0f 8e 7a fc ff ff    	jle    2684 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2a0a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2a0e:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2a12:	0f 8e 60 fc ff ff    	jle    2678 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2a18:	8d 45 98             	lea    -0x68(%ebp),%eax
    2a1b:	68 cd 00 00 00       	push   $0xcd
    2a20:	6a 74                	push   $0x74
    2a22:	6a 18                	push   $0x18
    2a24:	50                   	push   %eax
    2a25:	e8 7f f5 ff ff       	call   1fa9 <RGB>
    2a2a:	83 c4 0c             	add    $0xc,%esp
    2a2d:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2a31:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    2a35:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2a39:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    2a3c:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2a43:	8d 45 98             	lea    -0x68(%ebp),%eax
    2a46:	68 cd 00 00 00       	push   $0xcd
    2a4b:	6a 74                	push   $0x74
    2a4d:	6a 18                	push   $0x18
    2a4f:	50                   	push   %eax
    2a50:	e8 54 f5 ff ff       	call   1fa9 <RGB>
    2a55:	83 c4 0c             	add    $0xc,%esp
    2a58:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2a5c:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    2a60:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2a64:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    2a67:	8b 45 08             	mov    0x8(%ebp),%eax
    2a6a:	8d 50 58             	lea    0x58(%eax),%edx
    2a6d:	8d 45 98             	lea    -0x68(%ebp),%eax
    2a70:	ff 75 bc             	pushl  -0x44(%ebp)
    2a73:	ff 75 b8             	pushl  -0x48(%ebp)
    2a76:	52                   	push   %edx
    2a77:	50                   	push   %eax
    2a78:	e8 5c ed ff ff       	call   17d9 <APSetPen>
    2a7d:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2a80:	8b 45 08             	mov    0x8(%ebp),%eax
    2a83:	8d 58 58             	lea    0x58(%eax),%ebx
    2a86:	8d 55 98             	lea    -0x68(%ebp),%edx
    2a89:	83 ec 04             	sub    $0x4,%esp
    2a8c:	83 ec 04             	sub    $0x4,%esp
    2a8f:	89 e0                	mov    %esp,%eax
    2a91:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    2a95:	66 89 08             	mov    %cx,(%eax)
    2a98:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    2a9c:	88 48 02             	mov    %cl,0x2(%eax)
    2a9f:	53                   	push   %ebx
    2aa0:	52                   	push   %edx
    2aa1:	e8 6c ed ff ff       	call   1812 <APSetBrush>
    2aa6:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2aa9:	8b 45 08             	mov    0x8(%ebp),%eax
    2aac:	83 c0 58             	add    $0x58,%eax
    2aaf:	83 ec 0c             	sub    $0xc,%esp
    2ab2:	6a 32                	push   $0x32
    2ab4:	68 20 03 00 00       	push   $0x320
    2ab9:	6a 00                	push   $0x0
    2abb:	6a 00                	push   $0x0
    2abd:	50                   	push   %eax
    2abe:	e8 37 f1 ff ff       	call   1bfa <APDrawRect>
    2ac3:	83 c4 20             	add    $0x20,%esp
}
    2ac6:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2ac9:	5b                   	pop    %ebx
    2aca:	5e                   	pop    %esi
    2acb:	5f                   	pop    %edi
    2acc:	5d                   	pop    %ebp
    2acd:	c3                   	ret    

00002ace <random>:
//

#include "APLib.h"

int random(int seed)
{
    2ace:	55                   	push   %ebp
    2acf:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2ad1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2ad5:	7e 08                	jle    2adf <random+0x11>
{
rand_num = seed;
    2ad7:	8b 45 08             	mov    0x8(%ebp),%eax
    2ada:	a3 68 38 00 00       	mov    %eax,0x3868
}
rand_num *= 3;
    2adf:	8b 15 68 38 00 00    	mov    0x3868,%edx
    2ae5:	89 d0                	mov    %edx,%eax
    2ae7:	01 c0                	add    %eax,%eax
    2ae9:	01 d0                	add    %edx,%eax
    2aeb:	a3 68 38 00 00       	mov    %eax,0x3868
if (rand_num < 0)
    2af0:	a1 68 38 00 00       	mov    0x3868,%eax
    2af5:	85 c0                	test   %eax,%eax
    2af7:	79 0c                	jns    2b05 <random+0x37>
{
rand_num *= (-1);
    2af9:	a1 68 38 00 00       	mov    0x3868,%eax
    2afe:	f7 d8                	neg    %eax
    2b00:	a3 68 38 00 00       	mov    %eax,0x3868
}
return rand_num % 997;
    2b05:	8b 0d 68 38 00 00    	mov    0x3868,%ecx
    2b0b:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2b10:	89 c8                	mov    %ecx,%eax
    2b12:	f7 ea                	imul   %edx
    2b14:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2b17:	c1 f8 09             	sar    $0x9,%eax
    2b1a:	89 c2                	mov    %eax,%edx
    2b1c:	89 c8                	mov    %ecx,%eax
    2b1e:	c1 f8 1f             	sar    $0x1f,%eax
    2b21:	29 c2                	sub    %eax,%edx
    2b23:	89 d0                	mov    %edx,%eax
    2b25:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2b2b:	29 c1                	sub    %eax,%ecx
    2b2d:	89 c8                	mov    %ecx,%eax
}
    2b2f:	5d                   	pop    %ebp
    2b30:	c3                   	ret    

00002b31 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2b31:	55                   	push   %ebp
    2b32:	89 e5                	mov    %esp,%ebp
    2b34:	53                   	push   %ebx
    2b35:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2b38:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2b3f:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2b43:	74 17                	je     2b5c <sprintint+0x2b>
    2b45:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2b49:	79 11                	jns    2b5c <sprintint+0x2b>
        neg = 1;
    2b4b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2b52:	8b 45 10             	mov    0x10(%ebp),%eax
    2b55:	f7 d8                	neg    %eax
    2b57:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2b5a:	eb 06                	jmp    2b62 <sprintint+0x31>
    } else {
        x = xx;
    2b5c:	8b 45 10             	mov    0x10(%ebp),%eax
    2b5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2b62:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2b69:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2b6c:	8d 41 01             	lea    0x1(%ecx),%eax
    2b6f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2b72:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2b75:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2b78:	ba 00 00 00 00       	mov    $0x0,%edx
    2b7d:	f7 f3                	div    %ebx
    2b7f:	89 d0                	mov    %edx,%eax
    2b81:	0f b6 80 6c 38 00 00 	movzbl 0x386c(%eax),%eax
    2b88:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2b8c:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2b8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2b92:	ba 00 00 00 00       	mov    $0x0,%edx
    2b97:	f7 f3                	div    %ebx
    2b99:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2b9c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2ba0:	75 c7                	jne    2b69 <sprintint+0x38>
    if(neg)
    2ba2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ba6:	74 0e                	je     2bb6 <sprintint+0x85>
        buf[i++] = '-';
    2ba8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2bab:	8d 50 01             	lea    0x1(%eax),%edx
    2bae:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2bb1:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2bb6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2bb9:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2bbc:	eb 1b                	jmp    2bd9 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2bbe:	8b 45 0c             	mov    0xc(%ebp),%eax
    2bc1:	8b 00                	mov    (%eax),%eax
    2bc3:	8d 48 01             	lea    0x1(%eax),%ecx
    2bc6:	8b 55 0c             	mov    0xc(%ebp),%edx
    2bc9:	89 0a                	mov    %ecx,(%edx)
    2bcb:	89 c2                	mov    %eax,%edx
    2bcd:	8b 45 08             	mov    0x8(%ebp),%eax
    2bd0:	01 d0                	add    %edx,%eax
    2bd2:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2bd5:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2bd9:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2bdd:	7f df                	jg     2bbe <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2bdf:	eb 21                	jmp    2c02 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2be1:	8b 45 0c             	mov    0xc(%ebp),%eax
    2be4:	8b 00                	mov    (%eax),%eax
    2be6:	8d 48 01             	lea    0x1(%eax),%ecx
    2be9:	8b 55 0c             	mov    0xc(%ebp),%edx
    2bec:	89 0a                	mov    %ecx,(%edx)
    2bee:	89 c2                	mov    %eax,%edx
    2bf0:	8b 45 08             	mov    0x8(%ebp),%eax
    2bf3:	01 c2                	add    %eax,%edx
    2bf5:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2bf8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2bfb:	01 c8                	add    %ecx,%eax
    2bfd:	0f b6 00             	movzbl (%eax),%eax
    2c00:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2c02:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2c06:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2c0a:	79 d5                	jns    2be1 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2c0c:	90                   	nop
    2c0d:	83 c4 20             	add    $0x20,%esp
    2c10:	5b                   	pop    %ebx
    2c11:	5d                   	pop    %ebp
    2c12:	c3                   	ret    

00002c13 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2c13:	55                   	push   %ebp
    2c14:	89 e5                	mov    %esp,%ebp
    2c16:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2c19:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2c20:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2c27:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2c2e:	8d 45 0c             	lea    0xc(%ebp),%eax
    2c31:	83 c0 04             	add    $0x4,%eax
    2c34:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2c37:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2c3e:	e9 d9 01 00 00       	jmp    2e1c <sprintf+0x209>
        c = fmt[i] & 0xff;
    2c43:	8b 55 0c             	mov    0xc(%ebp),%edx
    2c46:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2c49:	01 d0                	add    %edx,%eax
    2c4b:	0f b6 00             	movzbl (%eax),%eax
    2c4e:	0f be c0             	movsbl %al,%eax
    2c51:	25 ff 00 00 00       	and    $0xff,%eax
    2c56:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2c59:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2c5d:	75 2c                	jne    2c8b <sprintf+0x78>
            if(c == '%'){
    2c5f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2c63:	75 0c                	jne    2c71 <sprintf+0x5e>
                state = '%';
    2c65:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2c6c:	e9 a7 01 00 00       	jmp    2e18 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2c71:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2c74:	8d 50 01             	lea    0x1(%eax),%edx
    2c77:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2c7a:	89 c2                	mov    %eax,%edx
    2c7c:	8b 45 08             	mov    0x8(%ebp),%eax
    2c7f:	01 d0                	add    %edx,%eax
    2c81:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2c84:	88 10                	mov    %dl,(%eax)
    2c86:	e9 8d 01 00 00       	jmp    2e18 <sprintf+0x205>
            }
        } else if(state == '%'){
    2c8b:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2c8f:	0f 85 83 01 00 00    	jne    2e18 <sprintf+0x205>
            if(c == 'd'){
    2c95:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2c99:	75 4c                	jne    2ce7 <sprintf+0xd4>
                buf[bi] = '\0';
    2c9b:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2c9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2ca1:	01 d0                	add    %edx,%eax
    2ca3:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2ca6:	83 ec 0c             	sub    $0xc,%esp
    2ca9:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2cac:	50                   	push   %eax
    2cad:	e8 91 e1 ff ff       	call   e43 <atoi>
    2cb2:	83 c4 10             	add    $0x10,%esp
    2cb5:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2cb8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2cbf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2cc2:	8b 00                	mov    (%eax),%eax
    2cc4:	83 ec 08             	sub    $0x8,%esp
    2cc7:	ff 75 d8             	pushl  -0x28(%ebp)
    2cca:	6a 01                	push   $0x1
    2ccc:	6a 0a                	push   $0xa
    2cce:	50                   	push   %eax
    2ccf:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2cd2:	50                   	push   %eax
    2cd3:	ff 75 08             	pushl  0x8(%ebp)
    2cd6:	e8 56 fe ff ff       	call   2b31 <sprintint>
    2cdb:	83 c4 20             	add    $0x20,%esp
                ap++;
    2cde:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2ce2:	e9 2a 01 00 00       	jmp    2e11 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2ce7:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2ceb:	74 06                	je     2cf3 <sprintf+0xe0>
    2ced:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2cf1:	75 4c                	jne    2d3f <sprintf+0x12c>
                buf[bi] = '\0';
    2cf3:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2cf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2cf9:	01 d0                	add    %edx,%eax
    2cfb:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2cfe:	83 ec 0c             	sub    $0xc,%esp
    2d01:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2d04:	50                   	push   %eax
    2d05:	e8 39 e1 ff ff       	call   e43 <atoi>
    2d0a:	83 c4 10             	add    $0x10,%esp
    2d0d:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2d10:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2d17:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2d1a:	8b 00                	mov    (%eax),%eax
    2d1c:	83 ec 08             	sub    $0x8,%esp
    2d1f:	ff 75 dc             	pushl  -0x24(%ebp)
    2d22:	6a 00                	push   $0x0
    2d24:	6a 10                	push   $0x10
    2d26:	50                   	push   %eax
    2d27:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2d2a:	50                   	push   %eax
    2d2b:	ff 75 08             	pushl  0x8(%ebp)
    2d2e:	e8 fe fd ff ff       	call   2b31 <sprintint>
    2d33:	83 c4 20             	add    $0x20,%esp
                ap++;
    2d36:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2d3a:	e9 d2 00 00 00       	jmp    2e11 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2d3f:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2d43:	75 46                	jne    2d8b <sprintf+0x178>
                s = (char*)*ap;
    2d45:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2d48:	8b 00                	mov    (%eax),%eax
    2d4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2d4d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2d51:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2d55:	75 25                	jne    2d7c <sprintf+0x169>
                    s = "(null)";
    2d57:	c7 45 f4 ac 30 00 00 	movl   $0x30ac,-0xc(%ebp)
                while(*s != 0){
    2d5e:	eb 1c                	jmp    2d7c <sprintf+0x169>
                    dst[j++] = *s;
    2d60:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2d63:	8d 50 01             	lea    0x1(%eax),%edx
    2d66:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2d69:	89 c2                	mov    %eax,%edx
    2d6b:	8b 45 08             	mov    0x8(%ebp),%eax
    2d6e:	01 c2                	add    %eax,%edx
    2d70:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2d73:	0f b6 00             	movzbl (%eax),%eax
    2d76:	88 02                	mov    %al,(%edx)
                    s++;
    2d78:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2d7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2d7f:	0f b6 00             	movzbl (%eax),%eax
    2d82:	84 c0                	test   %al,%al
    2d84:	75 da                	jne    2d60 <sprintf+0x14d>
    2d86:	e9 86 00 00 00       	jmp    2e11 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2d8b:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2d8f:	75 1d                	jne    2dae <sprintf+0x19b>
                dst[j++] = *ap;
    2d91:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2d94:	8d 50 01             	lea    0x1(%eax),%edx
    2d97:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2d9a:	89 c2                	mov    %eax,%edx
    2d9c:	8b 45 08             	mov    0x8(%ebp),%eax
    2d9f:	01 c2                	add    %eax,%edx
    2da1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2da4:	8b 00                	mov    (%eax),%eax
    2da6:	88 02                	mov    %al,(%edx)
                ap++;
    2da8:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2dac:	eb 63                	jmp    2e11 <sprintf+0x1fe>
            } else if(c == '%'){
    2dae:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2db2:	75 17                	jne    2dcb <sprintf+0x1b8>
                dst[j++] = c;
    2db4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2db7:	8d 50 01             	lea    0x1(%eax),%edx
    2dba:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2dbd:	89 c2                	mov    %eax,%edx
    2dbf:	8b 45 08             	mov    0x8(%ebp),%eax
    2dc2:	01 d0                	add    %edx,%eax
    2dc4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2dc7:	88 10                	mov    %dl,(%eax)
    2dc9:	eb 46                	jmp    2e11 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2dcb:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2dcf:	7e 18                	jle    2de9 <sprintf+0x1d6>
    2dd1:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2dd5:	7f 12                	jg     2de9 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2dd7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2dda:	8d 50 01             	lea    0x1(%eax),%edx
    2ddd:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2de0:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2de3:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2de7:	eb 2f                	jmp    2e18 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2de9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2dec:	8d 50 01             	lea    0x1(%eax),%edx
    2def:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2df2:	89 c2                	mov    %eax,%edx
    2df4:	8b 45 08             	mov    0x8(%ebp),%eax
    2df7:	01 d0                	add    %edx,%eax
    2df9:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2dfc:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2dff:	8d 50 01             	lea    0x1(%eax),%edx
    2e02:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2e05:	89 c2                	mov    %eax,%edx
    2e07:	8b 45 08             	mov    0x8(%ebp),%eax
    2e0a:	01 d0                	add    %edx,%eax
    2e0c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2e0f:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2e11:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2e18:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2e1c:	8b 55 0c             	mov    0xc(%ebp),%edx
    2e1f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2e22:	01 d0                	add    %edx,%eax
    2e24:	0f b6 00             	movzbl (%eax),%eax
    2e27:	84 c0                	test   %al,%al
    2e29:	0f 85 14 fe ff ff    	jne    2c43 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2e2f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2e32:	8d 50 01             	lea    0x1(%eax),%edx
    2e35:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2e38:	89 c2                	mov    %eax,%edx
    2e3a:	8b 45 08             	mov    0x8(%ebp),%eax
    2e3d:	01 d0                	add    %edx,%eax
    2e3f:	c6 00 00             	movb   $0x0,(%eax)
}
    2e42:	90                   	nop
    2e43:	c9                   	leave  
    2e44:	c3                   	ret    
