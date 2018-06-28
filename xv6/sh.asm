
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
      1b:	8b 04 85 64 2e 00 00 	mov    0x2e64(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 38 2e 00 00       	push   $0x2e38
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
      6c:	68 3f 2e 00 00       	push   $0x2e3f
      71:	6a 02                	push   $0x2
      73:	e8 fc 0f 00 00       	call   1074 <printf>
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
      bf:	68 4f 2e 00 00       	push   $0x2e4f
      c4:	6a 02                	push   $0x2
      c6:	e8 a9 0f 00 00       	call   1074 <printf>
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
     143:	68 5f 2e 00 00       	push   $0x2e5f
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
     254:	68 7c 2e 00 00       	push   $0x2e7c
     259:	6a 02                	push   $0x2
     25b:	e8 14 0e 00 00       	call   1074 <printf>
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
     2ce:	68 7f 2e 00 00       	push   $0x2e7f
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
     342:	68 87 2e 00 00       	push   $0x2e87
     347:	6a 02                	push   $0x2
     349:	e8 26 0d 00 00       	call   1074 <printf>
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
     3a8:	68 95 2e 00 00       	push   $0x2e95
     3ad:	6a 02                	push   $0x2
     3af:	e8 c0 0c 00 00       	call   1074 <printf>
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
     3d3:	68 99 2e 00 00       	push   $0x2e99
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
     3f0:	e8 52 0f 00 00       	call   1347 <malloc>
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
     426:	e8 1c 0f 00 00       	call   1347 <malloc>
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
     489:	e8 b9 0e 00 00       	call   1347 <malloc>
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
     4d1:	e8 71 0e 00 00       	call   1347 <malloc>
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
     519:	e8 29 0e 00 00       	call   1347 <malloc>
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
     576:	68 34 38 00 00       	push   $0x3834
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
     61f:	68 34 38 00 00       	push   $0x3834
     624:	e8 2b 07 00 00       	call   d54 <strchr>
     629:	83 c4 10             	add    $0x10,%esp
     62c:	85 c0                	test   %eax,%eax
     62e:	75 26                	jne    656 <gettoken+0x109>
     630:	8b 45 f4             	mov    -0xc(%ebp),%eax
     633:	0f b6 00             	movzbl (%eax),%eax
     636:	0f be c0             	movsbl %al,%eax
     639:	83 ec 08             	sub    $0x8,%esp
     63c:	50                   	push   %eax
     63d:	68 3c 38 00 00       	push   $0x383c
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
     680:	68 34 38 00 00       	push   $0x3834
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
     6c7:	68 34 38 00 00       	push   $0x3834
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
     74a:	68 9e 2e 00 00       	push   $0x2e9e
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
     76d:	68 9f 2e 00 00       	push   $0x2e9f
     772:	6a 02                	push   $0x2
     774:	e8 fb 08 00 00       	call   1074 <printf>
     779:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     77c:	83 ec 0c             	sub    $0xc,%esp
     77f:	68 ae 2e 00 00       	push   $0x2eae
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
     7e4:	68 b5 2e 00 00       	push   $0x2eb5
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
     7fe:	68 b7 2e 00 00       	push   $0x2eb7
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
     86c:	68 b9 2e 00 00       	push   $0x2eb9
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
     8fb:	68 bb 2e 00 00       	push   $0x2ebb
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
     981:	68 d8 2e 00 00       	push   $0x2ed8
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
     9aa:	68 db 2e 00 00       	push   $0x2edb
     9af:	ff 75 0c             	pushl  0xc(%ebp)
     9b2:	ff 75 08             	pushl  0x8(%ebp)
     9b5:	e8 e4 fc ff ff       	call   69e <peek>
     9ba:	83 c4 10             	add    $0x10,%esp
     9bd:	85 c0                	test   %eax,%eax
     9bf:	75 10                	jne    9d1 <parseblock+0x30>
    panic("parseblock");
     9c1:	83 ec 0c             	sub    $0xc,%esp
     9c4:	68 dd 2e 00 00       	push   $0x2edd
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
     9fa:	68 e8 2e 00 00       	push   $0x2ee8
     9ff:	ff 75 0c             	pushl  0xc(%ebp)
     a02:	ff 75 08             	pushl  0x8(%ebp)
     a05:	e8 94 fc ff ff       	call   69e <peek>
     a0a:	83 c4 10             	add    $0x10,%esp
     a0d:	85 c0                	test   %eax,%eax
     a0f:	75 10                	jne    a21 <parseblock+0x80>
    panic("syntax - missing )");
     a11:	83 ec 0c             	sub    $0xc,%esp
     a14:	68 ea 2e 00 00       	push   $0x2eea
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
     a58:	68 db 2e 00 00       	push   $0x2edb
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
     ae2:	68 ae 2e 00 00       	push   $0x2eae
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
     b19:	68 fd 2e 00 00       	push   $0x2efd
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
     b40:	68 0b 2f 00 00       	push   $0x2f0b
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
     ba6:	8b 04 85 10 2f 00 00 	mov    0x2f10(,%eax,4),%eax
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

00000f9d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     f9d:	55                   	push   %ebp
     f9e:	89 e5                	mov    %esp,%ebp
     fa0:	83 ec 18             	sub    $0x18,%esp
     fa3:	8b 45 0c             	mov    0xc(%ebp),%eax
     fa6:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     fa9:	83 ec 04             	sub    $0x4,%esp
     fac:	6a 01                	push   $0x1
     fae:	8d 45 f4             	lea    -0xc(%ebp),%eax
     fb1:	50                   	push   %eax
     fb2:	ff 75 08             	pushl  0x8(%ebp)
     fb5:	e8 3b ff ff ff       	call   ef5 <write>
     fba:	83 c4 10             	add    $0x10,%esp
}
     fbd:	90                   	nop
     fbe:	c9                   	leave  
     fbf:	c3                   	ret    

00000fc0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     fc0:	55                   	push   %ebp
     fc1:	89 e5                	mov    %esp,%ebp
     fc3:	53                   	push   %ebx
     fc4:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     fc7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     fce:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     fd2:	74 17                	je     feb <printint+0x2b>
     fd4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     fd8:	79 11                	jns    feb <printint+0x2b>
    neg = 1;
     fda:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     fe1:	8b 45 0c             	mov    0xc(%ebp),%eax
     fe4:	f7 d8                	neg    %eax
     fe6:	89 45 ec             	mov    %eax,-0x14(%ebp)
     fe9:	eb 06                	jmp    ff1 <printint+0x31>
  } else {
    x = xx;
     feb:	8b 45 0c             	mov    0xc(%ebp),%eax
     fee:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     ff1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     ff8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     ffb:	8d 41 01             	lea    0x1(%ecx),%eax
     ffe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1001:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1004:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1007:	ba 00 00 00 00       	mov    $0x0,%edx
    100c:	f7 f3                	div    %ebx
    100e:	89 d0                	mov    %edx,%eax
    1010:	0f b6 80 44 38 00 00 	movzbl 0x3844(%eax),%eax
    1017:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    101b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    101e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1021:	ba 00 00 00 00       	mov    $0x0,%edx
    1026:	f7 f3                	div    %ebx
    1028:	89 45 ec             	mov    %eax,-0x14(%ebp)
    102b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    102f:	75 c7                	jne    ff8 <printint+0x38>
  if(neg)
    1031:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1035:	74 2d                	je     1064 <printint+0xa4>
    buf[i++] = '-';
    1037:	8b 45 f4             	mov    -0xc(%ebp),%eax
    103a:	8d 50 01             	lea    0x1(%eax),%edx
    103d:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1040:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1045:	eb 1d                	jmp    1064 <printint+0xa4>
    putc(fd, buf[i]);
    1047:	8d 55 dc             	lea    -0x24(%ebp),%edx
    104a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    104d:	01 d0                	add    %edx,%eax
    104f:	0f b6 00             	movzbl (%eax),%eax
    1052:	0f be c0             	movsbl %al,%eax
    1055:	83 ec 08             	sub    $0x8,%esp
    1058:	50                   	push   %eax
    1059:	ff 75 08             	pushl  0x8(%ebp)
    105c:	e8 3c ff ff ff       	call   f9d <putc>
    1061:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1064:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1068:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    106c:	79 d9                	jns    1047 <printint+0x87>
    putc(fd, buf[i]);
}
    106e:	90                   	nop
    106f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1072:	c9                   	leave  
    1073:	c3                   	ret    

00001074 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1074:	55                   	push   %ebp
    1075:	89 e5                	mov    %esp,%ebp
    1077:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    107a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1081:	8d 45 0c             	lea    0xc(%ebp),%eax
    1084:	83 c0 04             	add    $0x4,%eax
    1087:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    108a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1091:	e9 59 01 00 00       	jmp    11ef <printf+0x17b>
    c = fmt[i] & 0xff;
    1096:	8b 55 0c             	mov    0xc(%ebp),%edx
    1099:	8b 45 f0             	mov    -0x10(%ebp),%eax
    109c:	01 d0                	add    %edx,%eax
    109e:	0f b6 00             	movzbl (%eax),%eax
    10a1:	0f be c0             	movsbl %al,%eax
    10a4:	25 ff 00 00 00       	and    $0xff,%eax
    10a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    10ac:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10b0:	75 2c                	jne    10de <printf+0x6a>
      if(c == '%'){
    10b2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    10b6:	75 0c                	jne    10c4 <printf+0x50>
        state = '%';
    10b8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    10bf:	e9 27 01 00 00       	jmp    11eb <printf+0x177>
      } else {
        putc(fd, c);
    10c4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10c7:	0f be c0             	movsbl %al,%eax
    10ca:	83 ec 08             	sub    $0x8,%esp
    10cd:	50                   	push   %eax
    10ce:	ff 75 08             	pushl  0x8(%ebp)
    10d1:	e8 c7 fe ff ff       	call   f9d <putc>
    10d6:	83 c4 10             	add    $0x10,%esp
    10d9:	e9 0d 01 00 00       	jmp    11eb <printf+0x177>
      }
    } else if(state == '%'){
    10de:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    10e2:	0f 85 03 01 00 00    	jne    11eb <printf+0x177>
      if(c == 'd'){
    10e8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    10ec:	75 1e                	jne    110c <printf+0x98>
        printint(fd, *ap, 10, 1);
    10ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10f1:	8b 00                	mov    (%eax),%eax
    10f3:	6a 01                	push   $0x1
    10f5:	6a 0a                	push   $0xa
    10f7:	50                   	push   %eax
    10f8:	ff 75 08             	pushl  0x8(%ebp)
    10fb:	e8 c0 fe ff ff       	call   fc0 <printint>
    1100:	83 c4 10             	add    $0x10,%esp
        ap++;
    1103:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1107:	e9 d8 00 00 00       	jmp    11e4 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    110c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1110:	74 06                	je     1118 <printf+0xa4>
    1112:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1116:	75 1e                	jne    1136 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    1118:	8b 45 e8             	mov    -0x18(%ebp),%eax
    111b:	8b 00                	mov    (%eax),%eax
    111d:	6a 00                	push   $0x0
    111f:	6a 10                	push   $0x10
    1121:	50                   	push   %eax
    1122:	ff 75 08             	pushl  0x8(%ebp)
    1125:	e8 96 fe ff ff       	call   fc0 <printint>
    112a:	83 c4 10             	add    $0x10,%esp
        ap++;
    112d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1131:	e9 ae 00 00 00       	jmp    11e4 <printf+0x170>
      } else if(c == 's'){
    1136:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    113a:	75 43                	jne    117f <printf+0x10b>
        s = (char*)*ap;
    113c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    113f:	8b 00                	mov    (%eax),%eax
    1141:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1144:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1148:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    114c:	75 25                	jne    1173 <printf+0xff>
          s = "(null)";
    114e:	c7 45 f4 28 2f 00 00 	movl   $0x2f28,-0xc(%ebp)
        while(*s != 0){
    1155:	eb 1c                	jmp    1173 <printf+0xff>
          putc(fd, *s);
    1157:	8b 45 f4             	mov    -0xc(%ebp),%eax
    115a:	0f b6 00             	movzbl (%eax),%eax
    115d:	0f be c0             	movsbl %al,%eax
    1160:	83 ec 08             	sub    $0x8,%esp
    1163:	50                   	push   %eax
    1164:	ff 75 08             	pushl  0x8(%ebp)
    1167:	e8 31 fe ff ff       	call   f9d <putc>
    116c:	83 c4 10             	add    $0x10,%esp
          s++;
    116f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1173:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1176:	0f b6 00             	movzbl (%eax),%eax
    1179:	84 c0                	test   %al,%al
    117b:	75 da                	jne    1157 <printf+0xe3>
    117d:	eb 65                	jmp    11e4 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    117f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1183:	75 1d                	jne    11a2 <printf+0x12e>
        putc(fd, *ap);
    1185:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1188:	8b 00                	mov    (%eax),%eax
    118a:	0f be c0             	movsbl %al,%eax
    118d:	83 ec 08             	sub    $0x8,%esp
    1190:	50                   	push   %eax
    1191:	ff 75 08             	pushl  0x8(%ebp)
    1194:	e8 04 fe ff ff       	call   f9d <putc>
    1199:	83 c4 10             	add    $0x10,%esp
        ap++;
    119c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    11a0:	eb 42                	jmp    11e4 <printf+0x170>
      } else if(c == '%'){
    11a2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    11a6:	75 17                	jne    11bf <printf+0x14b>
        putc(fd, c);
    11a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11ab:	0f be c0             	movsbl %al,%eax
    11ae:	83 ec 08             	sub    $0x8,%esp
    11b1:	50                   	push   %eax
    11b2:	ff 75 08             	pushl  0x8(%ebp)
    11b5:	e8 e3 fd ff ff       	call   f9d <putc>
    11ba:	83 c4 10             	add    $0x10,%esp
    11bd:	eb 25                	jmp    11e4 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    11bf:	83 ec 08             	sub    $0x8,%esp
    11c2:	6a 25                	push   $0x25
    11c4:	ff 75 08             	pushl  0x8(%ebp)
    11c7:	e8 d1 fd ff ff       	call   f9d <putc>
    11cc:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    11cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11d2:	0f be c0             	movsbl %al,%eax
    11d5:	83 ec 08             	sub    $0x8,%esp
    11d8:	50                   	push   %eax
    11d9:	ff 75 08             	pushl  0x8(%ebp)
    11dc:	e8 bc fd ff ff       	call   f9d <putc>
    11e1:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    11e4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    11eb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    11ef:	8b 55 0c             	mov    0xc(%ebp),%edx
    11f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11f5:	01 d0                	add    %edx,%eax
    11f7:	0f b6 00             	movzbl (%eax),%eax
    11fa:	84 c0                	test   %al,%al
    11fc:	0f 85 94 fe ff ff    	jne    1096 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1202:	90                   	nop
    1203:	c9                   	leave  
    1204:	c3                   	ret    

00001205 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1205:	55                   	push   %ebp
    1206:	89 e5                	mov    %esp,%ebp
    1208:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    120b:	8b 45 08             	mov    0x8(%ebp),%eax
    120e:	83 e8 08             	sub    $0x8,%eax
    1211:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1214:	a1 ec 38 00 00       	mov    0x38ec,%eax
    1219:	89 45 fc             	mov    %eax,-0x4(%ebp)
    121c:	eb 24                	jmp    1242 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    121e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1221:	8b 00                	mov    (%eax),%eax
    1223:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1226:	77 12                	ja     123a <free+0x35>
    1228:	8b 45 f8             	mov    -0x8(%ebp),%eax
    122b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    122e:	77 24                	ja     1254 <free+0x4f>
    1230:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1233:	8b 00                	mov    (%eax),%eax
    1235:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1238:	77 1a                	ja     1254 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    123a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    123d:	8b 00                	mov    (%eax),%eax
    123f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1242:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1245:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1248:	76 d4                	jbe    121e <free+0x19>
    124a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    124d:	8b 00                	mov    (%eax),%eax
    124f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1252:	76 ca                	jbe    121e <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1254:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1257:	8b 40 04             	mov    0x4(%eax),%eax
    125a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1261:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1264:	01 c2                	add    %eax,%edx
    1266:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1269:	8b 00                	mov    (%eax),%eax
    126b:	39 c2                	cmp    %eax,%edx
    126d:	75 24                	jne    1293 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    126f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1272:	8b 50 04             	mov    0x4(%eax),%edx
    1275:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1278:	8b 00                	mov    (%eax),%eax
    127a:	8b 40 04             	mov    0x4(%eax),%eax
    127d:	01 c2                	add    %eax,%edx
    127f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1282:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1285:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1288:	8b 00                	mov    (%eax),%eax
    128a:	8b 10                	mov    (%eax),%edx
    128c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    128f:	89 10                	mov    %edx,(%eax)
    1291:	eb 0a                	jmp    129d <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1293:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1296:	8b 10                	mov    (%eax),%edx
    1298:	8b 45 f8             	mov    -0x8(%ebp),%eax
    129b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    129d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12a0:	8b 40 04             	mov    0x4(%eax),%eax
    12a3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    12aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ad:	01 d0                	add    %edx,%eax
    12af:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12b2:	75 20                	jne    12d4 <free+0xcf>
    p->s.size += bp->s.size;
    12b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12b7:	8b 50 04             	mov    0x4(%eax),%edx
    12ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12bd:	8b 40 04             	mov    0x4(%eax),%eax
    12c0:	01 c2                	add    %eax,%edx
    12c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12c5:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    12c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12cb:	8b 10                	mov    (%eax),%edx
    12cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12d0:	89 10                	mov    %edx,(%eax)
    12d2:	eb 08                	jmp    12dc <free+0xd7>
  } else
    p->s.ptr = bp;
    12d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12d7:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12da:	89 10                	mov    %edx,(%eax)
  freep = p;
    12dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12df:	a3 ec 38 00 00       	mov    %eax,0x38ec
}
    12e4:	90                   	nop
    12e5:	c9                   	leave  
    12e6:	c3                   	ret    

000012e7 <morecore>:

static Header*
morecore(uint nu)
{
    12e7:	55                   	push   %ebp
    12e8:	89 e5                	mov    %esp,%ebp
    12ea:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    12ed:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    12f4:	77 07                	ja     12fd <morecore+0x16>
    nu = 4096;
    12f6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    12fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1300:	c1 e0 03             	shl    $0x3,%eax
    1303:	83 ec 0c             	sub    $0xc,%esp
    1306:	50                   	push   %eax
    1307:	e8 51 fc ff ff       	call   f5d <sbrk>
    130c:	83 c4 10             	add    $0x10,%esp
    130f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1312:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1316:	75 07                	jne    131f <morecore+0x38>
    return 0;
    1318:	b8 00 00 00 00       	mov    $0x0,%eax
    131d:	eb 26                	jmp    1345 <morecore+0x5e>
  hp = (Header*)p;
    131f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1322:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1325:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1328:	8b 55 08             	mov    0x8(%ebp),%edx
    132b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    132e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1331:	83 c0 08             	add    $0x8,%eax
    1334:	83 ec 0c             	sub    $0xc,%esp
    1337:	50                   	push   %eax
    1338:	e8 c8 fe ff ff       	call   1205 <free>
    133d:	83 c4 10             	add    $0x10,%esp
  return freep;
    1340:	a1 ec 38 00 00       	mov    0x38ec,%eax
}
    1345:	c9                   	leave  
    1346:	c3                   	ret    

00001347 <malloc>:

void*
malloc(uint nbytes)
{
    1347:	55                   	push   %ebp
    1348:	89 e5                	mov    %esp,%ebp
    134a:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    134d:	8b 45 08             	mov    0x8(%ebp),%eax
    1350:	83 c0 07             	add    $0x7,%eax
    1353:	c1 e8 03             	shr    $0x3,%eax
    1356:	83 c0 01             	add    $0x1,%eax
    1359:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    135c:	a1 ec 38 00 00       	mov    0x38ec,%eax
    1361:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1364:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1368:	75 23                	jne    138d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    136a:	c7 45 f0 e4 38 00 00 	movl   $0x38e4,-0x10(%ebp)
    1371:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1374:	a3 ec 38 00 00       	mov    %eax,0x38ec
    1379:	a1 ec 38 00 00       	mov    0x38ec,%eax
    137e:	a3 e4 38 00 00       	mov    %eax,0x38e4
    base.s.size = 0;
    1383:	c7 05 e8 38 00 00 00 	movl   $0x0,0x38e8
    138a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    138d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1390:	8b 00                	mov    (%eax),%eax
    1392:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1395:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1398:	8b 40 04             	mov    0x4(%eax),%eax
    139b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    139e:	72 4d                	jb     13ed <malloc+0xa6>
      if(p->s.size == nunits)
    13a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13a3:	8b 40 04             	mov    0x4(%eax),%eax
    13a6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13a9:	75 0c                	jne    13b7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    13ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13ae:	8b 10                	mov    (%eax),%edx
    13b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13b3:	89 10                	mov    %edx,(%eax)
    13b5:	eb 26                	jmp    13dd <malloc+0x96>
      else {
        p->s.size -= nunits;
    13b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13ba:	8b 40 04             	mov    0x4(%eax),%eax
    13bd:	2b 45 ec             	sub    -0x14(%ebp),%eax
    13c0:	89 c2                	mov    %eax,%edx
    13c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13c5:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    13c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13cb:	8b 40 04             	mov    0x4(%eax),%eax
    13ce:	c1 e0 03             	shl    $0x3,%eax
    13d1:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    13d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13d7:	8b 55 ec             	mov    -0x14(%ebp),%edx
    13da:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    13dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13e0:	a3 ec 38 00 00       	mov    %eax,0x38ec
      return (void*)(p + 1);
    13e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13e8:	83 c0 08             	add    $0x8,%eax
    13eb:	eb 3b                	jmp    1428 <malloc+0xe1>
    }
    if(p == freep)
    13ed:	a1 ec 38 00 00       	mov    0x38ec,%eax
    13f2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    13f5:	75 1e                	jne    1415 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    13f7:	83 ec 0c             	sub    $0xc,%esp
    13fa:	ff 75 ec             	pushl  -0x14(%ebp)
    13fd:	e8 e5 fe ff ff       	call   12e7 <morecore>
    1402:	83 c4 10             	add    $0x10,%esp
    1405:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1408:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    140c:	75 07                	jne    1415 <malloc+0xce>
        return 0;
    140e:	b8 00 00 00 00       	mov    $0x0,%eax
    1413:	eb 13                	jmp    1428 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1415:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1418:	89 45 f0             	mov    %eax,-0x10(%ebp)
    141b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    141e:	8b 00                	mov    (%eax),%eax
    1420:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1423:	e9 6d ff ff ff       	jmp    1395 <malloc+0x4e>
}
    1428:	c9                   	leave  
    1429:	c3                   	ret    

0000142a <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    142a:	55                   	push   %ebp
    142b:	89 e5                	mov    %esp,%ebp
    142d:	83 ec 1c             	sub    $0x1c,%esp
    1430:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1433:	8b 55 10             	mov    0x10(%ebp),%edx
    1436:	8b 45 14             	mov    0x14(%ebp),%eax
    1439:	88 4d ec             	mov    %cl,-0x14(%ebp)
    143c:	88 55 e8             	mov    %dl,-0x18(%ebp)
    143f:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1442:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1446:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1449:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    144d:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1450:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1454:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1457:	8b 45 08             	mov    0x8(%ebp),%eax
    145a:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    145e:	66 89 10             	mov    %dx,(%eax)
    1461:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1465:	88 50 02             	mov    %dl,0x2(%eax)
}
    1468:	8b 45 08             	mov    0x8(%ebp),%eax
    146b:	c9                   	leave  
    146c:	c2 04 00             	ret    $0x4

0000146f <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
    146f:	55                   	push   %ebp
    1470:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
    1472:	8b 45 08             	mov    0x8(%ebp),%eax
    1475:	2b 45 10             	sub    0x10(%ebp),%eax
    1478:	89 c2                	mov    %eax,%edx
    147a:	8b 45 08             	mov    0x8(%ebp),%eax
    147d:	2b 45 10             	sub    0x10(%ebp),%eax
    1480:	0f af d0             	imul   %eax,%edx
    1483:	8b 45 0c             	mov    0xc(%ebp),%eax
    1486:	2b 45 14             	sub    0x14(%ebp),%eax
    1489:	89 c1                	mov    %eax,%ecx
    148b:	8b 45 0c             	mov    0xc(%ebp),%eax
    148e:	2b 45 14             	sub    0x14(%ebp),%eax
    1491:	0f af c1             	imul   %ecx,%eax
    1494:	01 d0                	add    %edx,%eax
}
    1496:	5d                   	pop    %ebp
    1497:	c3                   	ret    

00001498 <abs_int>:

static inline int abs_int(int x)
{
    1498:	55                   	push   %ebp
    1499:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
    149b:	8b 45 08             	mov    0x8(%ebp),%eax
    149e:	99                   	cltd   
    149f:	89 d0                	mov    %edx,%eax
    14a1:	33 45 08             	xor    0x8(%ebp),%eax
    14a4:	29 d0                	sub    %edx,%eax
}
    14a6:	5d                   	pop    %ebp
    14a7:	c3                   	ret    

000014a8 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
    14a8:	55                   	push   %ebp
    14a9:	89 e5                	mov    %esp,%ebp
    if (x < 0)
    14ab:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14af:	79 07                	jns    14b8 <APGetIndex+0x10>
        return X_SMALLER;
    14b1:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    14b6:	eb 40                	jmp    14f8 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
    14b8:	8b 45 08             	mov    0x8(%ebp),%eax
    14bb:	8b 00                	mov    (%eax),%eax
    14bd:	3b 45 0c             	cmp    0xc(%ebp),%eax
    14c0:	7f 07                	jg     14c9 <APGetIndex+0x21>
        return X_BIGGER;
    14c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14c7:	eb 2f                	jmp    14f8 <APGetIndex+0x50>
    if (y < 0)
    14c9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    14cd:	79 07                	jns    14d6 <APGetIndex+0x2e>
        return Y_SMALLER;
    14cf:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
    14d4:	eb 22                	jmp    14f8 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
    14d6:	8b 45 08             	mov    0x8(%ebp),%eax
    14d9:	8b 40 04             	mov    0x4(%eax),%eax
    14dc:	3b 45 10             	cmp    0x10(%ebp),%eax
    14df:	7f 07                	jg     14e8 <APGetIndex+0x40>
        return Y_BIGGER;
    14e1:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    14e6:	eb 10                	jmp    14f8 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
    14e8:	8b 45 08             	mov    0x8(%ebp),%eax
    14eb:	8b 00                	mov    (%eax),%eax
    14ed:	0f af 45 10          	imul   0x10(%ebp),%eax
    14f1:	89 c2                	mov    %eax,%edx
    14f3:	8b 45 0c             	mov    0xc(%ebp),%eax
    14f6:	01 d0                	add    %edx,%eax
}
    14f8:	5d                   	pop    %ebp
    14f9:	c3                   	ret    

000014fa <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
    14fa:	55                   	push   %ebp
    14fb:	89 e5                	mov    %esp,%ebp
    14fd:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    1500:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    1507:	8b 45 cc             	mov    -0x34(%ebp),%eax
    150a:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
    150d:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
    1514:	83 ec 08             	sub    $0x8,%esp
    1517:	6a 00                	push   $0x0
    1519:	ff 75 0c             	pushl  0xc(%ebp)
    151c:	e8 f4 f9 ff ff       	call   f15 <open>
    1521:	83 c4 10             	add    $0x10,%esp
    1524:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
    1527:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    152b:	79 2e                	jns    155b <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
    152d:	83 ec 04             	sub    $0x4,%esp
    1530:	ff 75 0c             	pushl  0xc(%ebp)
    1533:	68 2f 2f 00 00       	push   $0x2f2f
    1538:	6a 01                	push   $0x1
    153a:	e8 35 fb ff ff       	call   1074 <printf>
    153f:	83 c4 10             	add    $0x10,%esp
        return bmp;
    1542:	8b 45 08             	mov    0x8(%ebp),%eax
    1545:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1548:	89 10                	mov    %edx,(%eax)
    154a:	8b 55 cc             	mov    -0x34(%ebp),%edx
    154d:	89 50 04             	mov    %edx,0x4(%eax)
    1550:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1553:	89 50 08             	mov    %edx,0x8(%eax)
    1556:	e9 d2 01 00 00       	jmp    172d <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    155b:	83 ec 04             	sub    $0x4,%esp
    155e:	6a 0e                	push   $0xe
    1560:	8d 45 ba             	lea    -0x46(%ebp),%eax
    1563:	50                   	push   %eax
    1564:	ff 75 ec             	pushl  -0x14(%ebp)
    1567:	e8 81 f9 ff ff       	call   eed <read>
    156c:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    156f:	83 ec 04             	sub    $0x4,%esp
    1572:	6a 28                	push   $0x28
    1574:	8d 45 92             	lea    -0x6e(%ebp),%eax
    1577:	50                   	push   %eax
    1578:	ff 75 ec             	pushl  -0x14(%ebp)
    157b:	e8 6d f9 ff ff       	call   eed <read>
    1580:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
    1583:	8b 45 96             	mov    -0x6a(%ebp),%eax
    1586:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
    1589:	8b 45 9a             	mov    -0x66(%ebp),%eax
    158c:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    158f:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1592:	8b 45 cc             	mov    -0x34(%ebp),%eax
    1595:	0f af d0             	imul   %eax,%edx
    1598:	89 d0                	mov    %edx,%eax
    159a:	01 c0                	add    %eax,%eax
    159c:	01 d0                	add    %edx,%eax
    159e:	83 ec 0c             	sub    $0xc,%esp
    15a1:	50                   	push   %eax
    15a2:	e8 a0 fd ff ff       	call   1347 <malloc>
    15a7:	83 c4 10             	add    $0x10,%esp
    15aa:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
    15ad:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    15b1:	0f b7 c0             	movzwl %ax,%eax
    15b4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    15b7:	8b 55 c8             	mov    -0x38(%ebp),%edx
    15ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15bd:	0f af c2             	imul   %edx,%eax
    15c0:	83 c0 1f             	add    $0x1f,%eax
    15c3:	c1 e8 05             	shr    $0x5,%eax
    15c6:	c1 e0 02             	shl    $0x2,%eax
    15c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
    15cc:	8b 55 cc             	mov    -0x34(%ebp),%edx
    15cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15d2:	0f af c2             	imul   %edx,%eax
    15d5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    15d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    15db:	83 ec 0c             	sub    $0xc,%esp
    15de:	50                   	push   %eax
    15df:	e8 63 fd ff ff       	call   1347 <malloc>
    15e4:	83 c4 10             	add    $0x10,%esp
    15e7:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    15ea:	83 ec 04             	sub    $0x4,%esp
    15ed:	ff 75 e0             	pushl  -0x20(%ebp)
    15f0:	ff 75 dc             	pushl  -0x24(%ebp)
    15f3:	ff 75 ec             	pushl  -0x14(%ebp)
    15f6:	e8 f2 f8 ff ff       	call   eed <read>
    15fb:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
    15fe:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    1602:	66 c1 e8 03          	shr    $0x3,%ax
    1606:	0f b7 c0             	movzwl %ax,%eax
    1609:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
    160c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1613:	e9 e5 00 00 00       	jmp    16fd <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
    1618:	8b 55 cc             	mov    -0x34(%ebp),%edx
    161b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161e:	29 c2                	sub    %eax,%edx
    1620:	89 d0                	mov    %edx,%eax
    1622:	8d 50 ff             	lea    -0x1(%eax),%edx
    1625:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1628:	0f af c2             	imul   %edx,%eax
    162b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
    162e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1635:	e9 b1 00 00 00       	jmp    16eb <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
    163a:	8b 55 d0             	mov    -0x30(%ebp),%edx
    163d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1640:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1643:	01 c8                	add    %ecx,%eax
    1645:	89 c1                	mov    %eax,%ecx
    1647:	89 c8                	mov    %ecx,%eax
    1649:	01 c0                	add    %eax,%eax
    164b:	01 c8                	add    %ecx,%eax
    164d:	01 c2                	add    %eax,%edx
    164f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1652:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1656:	89 c1                	mov    %eax,%ecx
    1658:	8b 45 d8             	mov    -0x28(%ebp),%eax
    165b:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    165f:	01 c1                	add    %eax,%ecx
    1661:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1664:	01 c8                	add    %ecx,%eax
    1666:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1669:	8b 45 dc             	mov    -0x24(%ebp),%eax
    166c:	01 c8                	add    %ecx,%eax
    166e:	0f b6 00             	movzbl (%eax),%eax
    1671:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
    1674:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1677:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    167a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    167d:	01 c8                	add    %ecx,%eax
    167f:	89 c1                	mov    %eax,%ecx
    1681:	89 c8                	mov    %ecx,%eax
    1683:	01 c0                	add    %eax,%eax
    1685:	01 c8                	add    %ecx,%eax
    1687:	01 c2                	add    %eax,%edx
    1689:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168c:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1690:	89 c1                	mov    %eax,%ecx
    1692:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1695:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1699:	01 c1                	add    %eax,%ecx
    169b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    169e:	01 c8                	add    %ecx,%eax
    16a0:	8d 48 fe             	lea    -0x2(%eax),%ecx
    16a3:	8b 45 dc             	mov    -0x24(%ebp),%eax
    16a6:	01 c8                	add    %ecx,%eax
    16a8:	0f b6 00             	movzbl (%eax),%eax
    16ab:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
    16ae:	8b 55 d0             	mov    -0x30(%ebp),%edx
    16b1:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    16b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16b7:	01 c8                	add    %ecx,%eax
    16b9:	89 c1                	mov    %eax,%ecx
    16bb:	89 c8                	mov    %ecx,%eax
    16bd:	01 c0                	add    %eax,%eax
    16bf:	01 c8                	add    %ecx,%eax
    16c1:	01 c2                	add    %eax,%edx
    16c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c6:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    16ca:	89 c1                	mov    %eax,%ecx
    16cc:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16cf:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    16d3:	01 c1                	add    %eax,%ecx
    16d5:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16d8:	01 c8                	add    %ecx,%eax
    16da:	8d 48 fd             	lea    -0x3(%eax),%ecx
    16dd:	8b 45 dc             	mov    -0x24(%ebp),%eax
    16e0:	01 c8                	add    %ecx,%eax
    16e2:	0f b6 00             	movzbl (%eax),%eax
    16e5:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    16e7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    16eb:	8b 55 c8             	mov    -0x38(%ebp),%edx
    16ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16f1:	39 c2                	cmp    %eax,%edx
    16f3:	0f 87 41 ff ff ff    	ja     163a <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    16f9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    16fd:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1700:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1703:	39 c2                	cmp    %eax,%edx
    1705:	0f 87 0d ff ff ff    	ja     1618 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    170b:	83 ec 0c             	sub    $0xc,%esp
    170e:	ff 75 ec             	pushl  -0x14(%ebp)
    1711:	e8 e7 f7 ff ff       	call   efd <close>
    1716:	83 c4 10             	add    $0x10,%esp
    return bmp;
    1719:	8b 45 08             	mov    0x8(%ebp),%eax
    171c:	8b 55 c8             	mov    -0x38(%ebp),%edx
    171f:	89 10                	mov    %edx,(%eax)
    1721:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1724:	89 50 04             	mov    %edx,0x4(%eax)
    1727:	8b 55 d0             	mov    -0x30(%ebp),%edx
    172a:	89 50 08             	mov    %edx,0x8(%eax)
}
    172d:	8b 45 08             	mov    0x8(%ebp),%eax
    1730:	c9                   	leave  
    1731:	c2 04 00             	ret    $0x4

00001734 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    1734:	55                   	push   %ebp
    1735:	89 e5                	mov    %esp,%ebp
    1737:	53                   	push   %ebx
    1738:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    173b:	83 ec 0c             	sub    $0xc,%esp
    173e:	6a 1c                	push   $0x1c
    1740:	e8 02 fc ff ff       	call   1347 <malloc>
    1745:	83 c4 10             	add    $0x10,%esp
    1748:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    174b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    174e:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    1755:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    1758:	8d 45 d8             	lea    -0x28(%ebp),%eax
    175b:	6a 0c                	push   $0xc
    175d:	6a 0c                	push   $0xc
    175f:	6a 0c                	push   $0xc
    1761:	50                   	push   %eax
    1762:	e8 c3 fc ff ff       	call   142a <RGB>
    1767:	83 c4 0c             	add    $0xc,%esp
    176a:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    176e:	66 89 43 13          	mov    %ax,0x13(%ebx)
    1772:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    1776:	88 43 15             	mov    %al,0x15(%ebx)
    1779:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    177f:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    1783:	66 89 48 10          	mov    %cx,0x10(%eax)
    1787:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    178b:	88 50 12             	mov    %dl,0x12(%eax)
    178e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1791:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1794:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    1798:	66 89 48 08          	mov    %cx,0x8(%eax)
    179c:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    17a0:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    17a3:	8b 45 08             	mov    0x8(%ebp),%eax
    17a6:	89 c2                	mov    %eax,%edx
    17a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ab:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    17ad:	8b 45 0c             	mov    0xc(%ebp),%eax
    17b0:	89 c2                	mov    %eax,%edx
    17b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b5:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    17b8:	8b 55 10             	mov    0x10(%ebp),%edx
    17bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17be:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    17c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    17c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    17c7:	c9                   	leave  
    17c8:	c3                   	ret    

000017c9 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    17c9:	55                   	push   %ebp
    17ca:	89 e5                	mov    %esp,%ebp
    17cc:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    17cf:	8b 45 0c             	mov    0xc(%ebp),%eax
    17d2:	8b 50 08             	mov    0x8(%eax),%edx
    17d5:	89 55 f8             	mov    %edx,-0x8(%ebp)
    17d8:	8b 40 0c             	mov    0xc(%eax),%eax
    17db:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    17de:	8b 45 0c             	mov    0xc(%ebp),%eax
    17e1:	8b 55 10             	mov    0x10(%ebp),%edx
    17e4:	89 50 08             	mov    %edx,0x8(%eax)
    17e7:	8b 55 14             	mov    0x14(%ebp),%edx
    17ea:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    17ed:	8b 45 08             	mov    0x8(%ebp),%eax
    17f0:	8b 55 f8             	mov    -0x8(%ebp),%edx
    17f3:	89 10                	mov    %edx,(%eax)
    17f5:	8b 55 fc             	mov    -0x4(%ebp),%edx
    17f8:	89 50 04             	mov    %edx,0x4(%eax)
}
    17fb:	8b 45 08             	mov    0x8(%ebp),%eax
    17fe:	c9                   	leave  
    17ff:	c2 04 00             	ret    $0x4

00001802 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    1802:	55                   	push   %ebp
    1803:	89 e5                	mov    %esp,%ebp
    1805:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    1808:	8b 45 0c             	mov    0xc(%ebp),%eax
    180b:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    180f:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1813:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1817:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    181a:	8b 45 0c             	mov    0xc(%ebp),%eax
    181d:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1821:	66 89 50 10          	mov    %dx,0x10(%eax)
    1825:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1829:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    182c:	8b 45 08             	mov    0x8(%ebp),%eax
    182f:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1833:	66 89 10             	mov    %dx,(%eax)
    1836:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    183a:	88 50 02             	mov    %dl,0x2(%eax)
}
    183d:	8b 45 08             	mov    0x8(%ebp),%eax
    1840:	c9                   	leave  
    1841:	c2 04 00             	ret    $0x4

00001844 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    1844:	55                   	push   %ebp
    1845:	89 e5                	mov    %esp,%ebp
    1847:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    184a:	8b 45 08             	mov    0x8(%ebp),%eax
    184d:	8b 40 0c             	mov    0xc(%eax),%eax
    1850:	89 c2                	mov    %eax,%edx
    1852:	c1 ea 1f             	shr    $0x1f,%edx
    1855:	01 d0                	add    %edx,%eax
    1857:	d1 f8                	sar    %eax
    1859:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    185c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185f:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    1863:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    1866:	8b 45 10             	mov    0x10(%ebp),%eax
    1869:	2b 45 f4             	sub    -0xc(%ebp),%eax
    186c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    186f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    1873:	0f 89 98 00 00 00    	jns    1911 <APDrawPoint+0xcd>
        i = 0;
    1879:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    1880:	e9 8c 00 00 00       	jmp    1911 <APDrawPoint+0xcd>
    {
        j = x - off;
    1885:	8b 45 0c             	mov    0xc(%ebp),%eax
    1888:	2b 45 f4             	sub    -0xc(%ebp),%eax
    188b:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    188e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1892:	79 69                	jns    18fd <APDrawPoint+0xb9>
            j = 0;
    1894:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    189b:	eb 60                	jmp    18fd <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    189d:	ff 75 fc             	pushl  -0x4(%ebp)
    18a0:	ff 75 f8             	pushl  -0x8(%ebp)
    18a3:	ff 75 08             	pushl  0x8(%ebp)
    18a6:	e8 fd fb ff ff       	call   14a8 <APGetIndex>
    18ab:	83 c4 0c             	add    $0xc,%esp
    18ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    18b1:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    18b5:	74 55                	je     190c <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    18b7:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    18bb:	74 67                	je     1924 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    18bd:	ff 75 10             	pushl  0x10(%ebp)
    18c0:	ff 75 0c             	pushl  0xc(%ebp)
    18c3:	ff 75 fc             	pushl  -0x4(%ebp)
    18c6:	ff 75 f8             	pushl  -0x8(%ebp)
    18c9:	e8 a1 fb ff ff       	call   146f <distance_2>
    18ce:	83 c4 10             	add    $0x10,%esp
    18d1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    18d4:	7f 23                	jg     18f9 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    18d6:	8b 45 08             	mov    0x8(%ebp),%eax
    18d9:	8b 48 18             	mov    0x18(%eax),%ecx
    18dc:	8b 55 ec             	mov    -0x14(%ebp),%edx
    18df:	89 d0                	mov    %edx,%eax
    18e1:	01 c0                	add    %eax,%eax
    18e3:	01 d0                	add    %edx,%eax
    18e5:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    18e8:	8b 45 08             	mov    0x8(%ebp),%eax
    18eb:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    18ef:	66 89 0a             	mov    %cx,(%edx)
    18f2:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    18f6:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    18f9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    18fd:	8b 55 0c             	mov    0xc(%ebp),%edx
    1900:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1903:	01 d0                	add    %edx,%eax
    1905:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1908:	7d 93                	jge    189d <APDrawPoint+0x59>
    190a:	eb 01                	jmp    190d <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    190c:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    190d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1911:	8b 55 10             	mov    0x10(%ebp),%edx
    1914:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1917:	01 d0                	add    %edx,%eax
    1919:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    191c:	0f 8d 63 ff ff ff    	jge    1885 <APDrawPoint+0x41>
    1922:	eb 01                	jmp    1925 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1924:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    1925:	c9                   	leave  
    1926:	c3                   	ret    

00001927 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1927:	55                   	push   %ebp
    1928:	89 e5                	mov    %esp,%ebp
    192a:	53                   	push   %ebx
    192b:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    192e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1931:	3b 45 14             	cmp    0x14(%ebp),%eax
    1934:	0f 85 80 00 00 00    	jne    19ba <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    193a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    193e:	0f 88 9d 02 00 00    	js     1be1 <APDrawLine+0x2ba>
    1944:	8b 45 08             	mov    0x8(%ebp),%eax
    1947:	8b 00                	mov    (%eax),%eax
    1949:	3b 45 0c             	cmp    0xc(%ebp),%eax
    194c:	0f 8e 8f 02 00 00    	jle    1be1 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    1952:	8b 45 10             	mov    0x10(%ebp),%eax
    1955:	3b 45 18             	cmp    0x18(%ebp),%eax
    1958:	7e 12                	jle    196c <APDrawLine+0x45>
        {
            int tmp = y2;
    195a:	8b 45 18             	mov    0x18(%ebp),%eax
    195d:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    1960:	8b 45 10             	mov    0x10(%ebp),%eax
    1963:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1966:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1969:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    196c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1970:	79 07                	jns    1979 <APDrawLine+0x52>
    1972:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1979:	8b 45 08             	mov    0x8(%ebp),%eax
    197c:	8b 40 04             	mov    0x4(%eax),%eax
    197f:	3b 45 18             	cmp    0x18(%ebp),%eax
    1982:	7d 0c                	jge    1990 <APDrawLine+0x69>
    1984:	8b 45 08             	mov    0x8(%ebp),%eax
    1987:	8b 40 04             	mov    0x4(%eax),%eax
    198a:	83 e8 01             	sub    $0x1,%eax
    198d:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    1990:	8b 45 10             	mov    0x10(%ebp),%eax
    1993:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1996:	eb 15                	jmp    19ad <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1998:	ff 75 f4             	pushl  -0xc(%ebp)
    199b:	ff 75 0c             	pushl  0xc(%ebp)
    199e:	ff 75 08             	pushl  0x8(%ebp)
    19a1:	e8 9e fe ff ff       	call   1844 <APDrawPoint>
    19a6:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    19a9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    19ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19b0:	3b 45 18             	cmp    0x18(%ebp),%eax
    19b3:	7e e3                	jle    1998 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    19b5:	e9 2b 02 00 00       	jmp    1be5 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    19ba:	8b 45 10             	mov    0x10(%ebp),%eax
    19bd:	3b 45 18             	cmp    0x18(%ebp),%eax
    19c0:	75 7f                	jne    1a41 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    19c2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    19c6:	0f 88 18 02 00 00    	js     1be4 <APDrawLine+0x2bd>
    19cc:	8b 45 08             	mov    0x8(%ebp),%eax
    19cf:	8b 40 04             	mov    0x4(%eax),%eax
    19d2:	3b 45 10             	cmp    0x10(%ebp),%eax
    19d5:	0f 8e 09 02 00 00    	jle    1be4 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    19db:	8b 45 0c             	mov    0xc(%ebp),%eax
    19de:	3b 45 14             	cmp    0x14(%ebp),%eax
    19e1:	7e 12                	jle    19f5 <APDrawLine+0xce>
        {
            int tmp = x2;
    19e3:	8b 45 14             	mov    0x14(%ebp),%eax
    19e6:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    19e9:	8b 45 0c             	mov    0xc(%ebp),%eax
    19ec:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    19ef:	8b 45 d8             	mov    -0x28(%ebp),%eax
    19f2:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    19f5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    19f9:	79 07                	jns    1a02 <APDrawLine+0xdb>
    19fb:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1a02:	8b 45 08             	mov    0x8(%ebp),%eax
    1a05:	8b 00                	mov    (%eax),%eax
    1a07:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a0a:	7d 0b                	jge    1a17 <APDrawLine+0xf0>
    1a0c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0f:	8b 00                	mov    (%eax),%eax
    1a11:	83 e8 01             	sub    $0x1,%eax
    1a14:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1a17:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a1d:	eb 15                	jmp    1a34 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1a1f:	ff 75 10             	pushl  0x10(%ebp)
    1a22:	ff 75 f0             	pushl  -0x10(%ebp)
    1a25:	ff 75 08             	pushl  0x8(%ebp)
    1a28:	e8 17 fe ff ff       	call   1844 <APDrawPoint>
    1a2d:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1a30:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1a34:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a37:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a3a:	7e e3                	jle    1a1f <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1a3c:	e9 a4 01 00 00       	jmp    1be5 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1a41:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1a48:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1a4f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a52:	2b 45 14             	sub    0x14(%ebp),%eax
    1a55:	50                   	push   %eax
    1a56:	e8 3d fa ff ff       	call   1498 <abs_int>
    1a5b:	83 c4 04             	add    $0x4,%esp
    1a5e:	89 c3                	mov    %eax,%ebx
    1a60:	8b 45 10             	mov    0x10(%ebp),%eax
    1a63:	2b 45 18             	sub    0x18(%ebp),%eax
    1a66:	50                   	push   %eax
    1a67:	e8 2c fa ff ff       	call   1498 <abs_int>
    1a6c:	83 c4 04             	add    $0x4,%esp
    1a6f:	39 c3                	cmp    %eax,%ebx
    1a71:	0f 8e b5 00 00 00    	jle    1b2c <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1a77:	8b 45 10             	mov    0x10(%ebp),%eax
    1a7a:	2b 45 18             	sub    0x18(%ebp),%eax
    1a7d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1a80:	db 45 b0             	fildl  -0x50(%ebp)
    1a83:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a86:	2b 45 14             	sub    0x14(%ebp),%eax
    1a89:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1a8c:	db 45 b0             	fildl  -0x50(%ebp)
    1a8f:	de f9                	fdivrp %st,%st(1)
    1a91:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1a94:	8b 45 14             	mov    0x14(%ebp),%eax
    1a97:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1a9a:	7e 0e                	jle    1aaa <APDrawLine+0x183>
        {
            s = x1;
    1a9c:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a9f:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    1aa2:	8b 45 14             	mov    0x14(%ebp),%eax
    1aa5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1aa8:	eb 0c                	jmp    1ab6 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1aaa:	8b 45 14             	mov    0x14(%ebp),%eax
    1aad:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1ab0:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ab3:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1ab6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1aba:	79 07                	jns    1ac3 <APDrawLine+0x19c>
    1abc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1ac3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac6:	8b 00                	mov    (%eax),%eax
    1ac8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1acb:	7f 0b                	jg     1ad8 <APDrawLine+0x1b1>
    1acd:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad0:	8b 00                	mov    (%eax),%eax
    1ad2:	83 e8 01             	sub    $0x1,%eax
    1ad5:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1ad8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1adb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1ade:	eb 3f                	jmp    1b1f <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1ae0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ae3:	2b 45 0c             	sub    0xc(%ebp),%eax
    1ae6:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1ae9:	db 45 b0             	fildl  -0x50(%ebp)
    1aec:	dc 4d d0             	fmull  -0x30(%ebp)
    1aef:	db 45 10             	fildl  0x10(%ebp)
    1af2:	de c1                	faddp  %st,%st(1)
    1af4:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1af7:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1afb:	b4 0c                	mov    $0xc,%ah
    1afd:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1b01:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1b04:	db 5d cc             	fistpl -0x34(%ebp)
    1b07:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1b0a:	ff 75 cc             	pushl  -0x34(%ebp)
    1b0d:	ff 75 e4             	pushl  -0x1c(%ebp)
    1b10:	ff 75 08             	pushl  0x8(%ebp)
    1b13:	e8 2c fd ff ff       	call   1844 <APDrawPoint>
    1b18:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1b1b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1b1f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b22:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1b25:	7e b9                	jle    1ae0 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1b27:	e9 b9 00 00 00       	jmp    1be5 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1b2c:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b2f:	2b 45 14             	sub    0x14(%ebp),%eax
    1b32:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1b35:	db 45 b0             	fildl  -0x50(%ebp)
    1b38:	8b 45 10             	mov    0x10(%ebp),%eax
    1b3b:	2b 45 18             	sub    0x18(%ebp),%eax
    1b3e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1b41:	db 45 b0             	fildl  -0x50(%ebp)
    1b44:	de f9                	fdivrp %st,%st(1)
    1b46:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1b49:	8b 45 10             	mov    0x10(%ebp),%eax
    1b4c:	3b 45 18             	cmp    0x18(%ebp),%eax
    1b4f:	7e 0e                	jle    1b5f <APDrawLine+0x238>
    {
        s = y2;
    1b51:	8b 45 18             	mov    0x18(%ebp),%eax
    1b54:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1b57:	8b 45 10             	mov    0x10(%ebp),%eax
    1b5a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1b5d:	eb 0c                	jmp    1b6b <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1b5f:	8b 45 10             	mov    0x10(%ebp),%eax
    1b62:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1b65:	8b 45 18             	mov    0x18(%ebp),%eax
    1b68:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1b6b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b6f:	79 07                	jns    1b78 <APDrawLine+0x251>
    1b71:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1b78:	8b 45 08             	mov    0x8(%ebp),%eax
    1b7b:	8b 40 04             	mov    0x4(%eax),%eax
    1b7e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1b81:	7f 0c                	jg     1b8f <APDrawLine+0x268>
    1b83:	8b 45 08             	mov    0x8(%ebp),%eax
    1b86:	8b 40 04             	mov    0x4(%eax),%eax
    1b89:	83 e8 01             	sub    $0x1,%eax
    1b8c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1b8f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b92:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1b95:	eb 3f                	jmp    1bd6 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1b97:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b9a:	2b 45 10             	sub    0x10(%ebp),%eax
    1b9d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1ba0:	db 45 b0             	fildl  -0x50(%ebp)
    1ba3:	dc 4d c0             	fmull  -0x40(%ebp)
    1ba6:	db 45 0c             	fildl  0xc(%ebp)
    1ba9:	de c1                	faddp  %st,%st(1)
    1bab:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1bae:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1bb2:	b4 0c                	mov    $0xc,%ah
    1bb4:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1bb8:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1bbb:	db 5d bc             	fistpl -0x44(%ebp)
    1bbe:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1bc1:	ff 75 e0             	pushl  -0x20(%ebp)
    1bc4:	ff 75 bc             	pushl  -0x44(%ebp)
    1bc7:	ff 75 08             	pushl  0x8(%ebp)
    1bca:	e8 75 fc ff ff       	call   1844 <APDrawPoint>
    1bcf:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1bd2:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1bd6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bd9:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1bdc:	7e b9                	jle    1b97 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1bde:	90                   	nop
    1bdf:	eb 04                	jmp    1be5 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1be1:	90                   	nop
    1be2:	eb 01                	jmp    1be5 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1be4:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1be5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1be8:	c9                   	leave  
    1be9:	c3                   	ret    

00001bea <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1bea:	55                   	push   %ebp
    1beb:	89 e5                	mov    %esp,%ebp
    1bed:	53                   	push   %ebx
    1bee:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1bf1:	8b 55 10             	mov    0x10(%ebp),%edx
    1bf4:	8b 45 18             	mov    0x18(%ebp),%eax
    1bf7:	01 d0                	add    %edx,%eax
    1bf9:	83 e8 01             	sub    $0x1,%eax
    1bfc:	83 ec 04             	sub    $0x4,%esp
    1bff:	50                   	push   %eax
    1c00:	ff 75 0c             	pushl  0xc(%ebp)
    1c03:	ff 75 10             	pushl  0x10(%ebp)
    1c06:	ff 75 0c             	pushl  0xc(%ebp)
    1c09:	ff 75 08             	pushl  0x8(%ebp)
    1c0c:	e8 16 fd ff ff       	call   1927 <APDrawLine>
    1c11:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1c14:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c17:	8b 45 14             	mov    0x14(%ebp),%eax
    1c1a:	01 d0                	add    %edx,%eax
    1c1c:	83 e8 01             	sub    $0x1,%eax
    1c1f:	83 ec 04             	sub    $0x4,%esp
    1c22:	ff 75 10             	pushl  0x10(%ebp)
    1c25:	50                   	push   %eax
    1c26:	ff 75 10             	pushl  0x10(%ebp)
    1c29:	ff 75 0c             	pushl  0xc(%ebp)
    1c2c:	ff 75 08             	pushl  0x8(%ebp)
    1c2f:	e8 f3 fc ff ff       	call   1927 <APDrawLine>
    1c34:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1c37:	8b 55 10             	mov    0x10(%ebp),%edx
    1c3a:	8b 45 18             	mov    0x18(%ebp),%eax
    1c3d:	01 d0                	add    %edx,%eax
    1c3f:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1c42:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c45:	8b 45 14             	mov    0x14(%ebp),%eax
    1c48:	01 d0                	add    %edx,%eax
    1c4a:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c4d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1c50:	8b 45 14             	mov    0x14(%ebp),%eax
    1c53:	01 d8                	add    %ebx,%eax
    1c55:	83 e8 01             	sub    $0x1,%eax
    1c58:	83 ec 04             	sub    $0x4,%esp
    1c5b:	51                   	push   %ecx
    1c5c:	52                   	push   %edx
    1c5d:	ff 75 10             	pushl  0x10(%ebp)
    1c60:	50                   	push   %eax
    1c61:	ff 75 08             	pushl  0x8(%ebp)
    1c64:	e8 be fc ff ff       	call   1927 <APDrawLine>
    1c69:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1c6c:	8b 55 10             	mov    0x10(%ebp),%edx
    1c6f:	8b 45 18             	mov    0x18(%ebp),%eax
    1c72:	01 d0                	add    %edx,%eax
    1c74:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1c77:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c7a:	8b 45 14             	mov    0x14(%ebp),%eax
    1c7d:	01 d0                	add    %edx,%eax
    1c7f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c82:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1c85:	8b 45 18             	mov    0x18(%ebp),%eax
    1c88:	01 d8                	add    %ebx,%eax
    1c8a:	83 e8 01             	sub    $0x1,%eax
    1c8d:	83 ec 04             	sub    $0x4,%esp
    1c90:	51                   	push   %ecx
    1c91:	52                   	push   %edx
    1c92:	50                   	push   %eax
    1c93:	ff 75 0c             	pushl  0xc(%ebp)
    1c96:	ff 75 08             	pushl  0x8(%ebp)
    1c99:	e8 89 fc ff ff       	call   1927 <APDrawLine>
    1c9e:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1ca1:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ca4:	8b 45 14             	mov    0x14(%ebp),%eax
    1ca7:	01 d0                	add    %edx,%eax
    1ca9:	8d 50 ff             	lea    -0x1(%eax),%edx
    1cac:	8b 45 08             	mov    0x8(%ebp),%eax
    1caf:	8b 40 0c             	mov    0xc(%eax),%eax
    1cb2:	89 c1                	mov    %eax,%ecx
    1cb4:	c1 e9 1f             	shr    $0x1f,%ecx
    1cb7:	01 c8                	add    %ecx,%eax
    1cb9:	d1 f8                	sar    %eax
    1cbb:	29 c2                	sub    %eax,%edx
    1cbd:	89 d0                	mov    %edx,%eax
    1cbf:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1cc2:	8b 55 10             	mov    0x10(%ebp),%edx
    1cc5:	8b 45 18             	mov    0x18(%ebp),%eax
    1cc8:	01 d0                	add    %edx,%eax
    1cca:	8d 50 ff             	lea    -0x1(%eax),%edx
    1ccd:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd0:	8b 40 0c             	mov    0xc(%eax),%eax
    1cd3:	89 c1                	mov    %eax,%ecx
    1cd5:	c1 e9 1f             	shr    $0x1f,%ecx
    1cd8:	01 c8                	add    %ecx,%eax
    1cda:	d1 f8                	sar    %eax
    1cdc:	29 c2                	sub    %eax,%edx
    1cde:	89 d0                	mov    %edx,%eax
    1ce0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1ce3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce6:	8b 40 0c             	mov    0xc(%eax),%eax
    1ce9:	89 c2                	mov    %eax,%edx
    1ceb:	c1 ea 1f             	shr    $0x1f,%edx
    1cee:	01 d0                	add    %edx,%eax
    1cf0:	d1 f8                	sar    %eax
    1cf2:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1cf5:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf8:	8b 40 0c             	mov    0xc(%eax),%eax
    1cfb:	89 c2                	mov    %eax,%edx
    1cfd:	c1 ea 1f             	shr    $0x1f,%edx
    1d00:	01 d0                	add    %edx,%eax
    1d02:	d1 f8                	sar    %eax
    1d04:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1d07:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d0b:	0f 88 d8 00 00 00    	js     1de9 <APDrawRect+0x1ff>
    1d11:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d15:	0f 88 ce 00 00 00    	js     1de9 <APDrawRect+0x1ff>
    1d1b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d1e:	8b 00                	mov    (%eax),%eax
    1d20:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1d23:	0f 8e c0 00 00 00    	jle    1de9 <APDrawRect+0x1ff>
    1d29:	8b 45 08             	mov    0x8(%ebp),%eax
    1d2c:	8b 40 04             	mov    0x4(%eax),%eax
    1d2f:	3b 45 10             	cmp    0x10(%ebp),%eax
    1d32:	0f 8e b1 00 00 00    	jle    1de9 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1d38:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1d3c:	79 07                	jns    1d45 <APDrawRect+0x15b>
    1d3e:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1d45:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1d49:	79 07                	jns    1d52 <APDrawRect+0x168>
    1d4b:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1d52:	8b 45 08             	mov    0x8(%ebp),%eax
    1d55:	8b 00                	mov    (%eax),%eax
    1d57:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1d5a:	7f 0b                	jg     1d67 <APDrawRect+0x17d>
    1d5c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d5f:	8b 00                	mov    (%eax),%eax
    1d61:	83 e8 01             	sub    $0x1,%eax
    1d64:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1d67:	8b 45 08             	mov    0x8(%ebp),%eax
    1d6a:	8b 40 04             	mov    0x4(%eax),%eax
    1d6d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1d70:	7f 0c                	jg     1d7e <APDrawRect+0x194>
    1d72:	8b 45 08             	mov    0x8(%ebp),%eax
    1d75:	8b 40 04             	mov    0x4(%eax),%eax
    1d78:	83 e8 01             	sub    $0x1,%eax
    1d7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1d7e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1d85:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d88:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1d8b:	eb 52                	jmp    1ddf <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1d8d:	8b 45 10             	mov    0x10(%ebp),%eax
    1d90:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1d93:	eb 3e                	jmp    1dd3 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1d95:	83 ec 04             	sub    $0x4,%esp
    1d98:	ff 75 e8             	pushl  -0x18(%ebp)
    1d9b:	ff 75 ec             	pushl  -0x14(%ebp)
    1d9e:	ff 75 08             	pushl  0x8(%ebp)
    1da1:	e8 02 f7 ff ff       	call   14a8 <APGetIndex>
    1da6:	83 c4 10             	add    $0x10,%esp
    1da9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1dac:	8b 45 08             	mov    0x8(%ebp),%eax
    1daf:	8b 48 18             	mov    0x18(%eax),%ecx
    1db2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1db5:	89 d0                	mov    %edx,%eax
    1db7:	01 c0                	add    %eax,%eax
    1db9:	01 d0                	add    %edx,%eax
    1dbb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1dbe:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc1:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1dc5:	66 89 0a             	mov    %cx,(%edx)
    1dc8:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1dcc:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1dcf:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1dd3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1dd6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1dd9:	7e ba                	jle    1d95 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1ddb:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1ddf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1de2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1de5:	7e a6                	jle    1d8d <APDrawRect+0x1a3>
    1de7:	eb 01                	jmp    1dea <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1de9:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1dea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1ded:	c9                   	leave  
    1dee:	c3                   	ret    

00001def <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1def:	55                   	push   %ebp
    1df0:	89 e5                	mov    %esp,%ebp
}
    1df2:	90                   	nop
    1df3:	5d                   	pop    %ebp
    1df4:	c3                   	ret    

00001df5 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1df5:	55                   	push   %ebp
    1df6:	89 e5                	mov    %esp,%ebp
    1df8:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1dfb:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1dff:	0f 88 8e 01 00 00    	js     1f93 <APDcCopy+0x19e>
    1e05:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1e09:	0f 88 84 01 00 00    	js     1f93 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1e0f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e12:	8b 45 20             	mov    0x20(%ebp),%eax
    1e15:	01 d0                	add    %edx,%eax
    1e17:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1e1a:	8b 55 10             	mov    0x10(%ebp),%edx
    1e1d:	8b 45 24             	mov    0x24(%ebp),%eax
    1e20:	01 d0                	add    %edx,%eax
    1e22:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1e25:	8b 55 18             	mov    0x18(%ebp),%edx
    1e28:	8b 45 20             	mov    0x20(%ebp),%eax
    1e2b:	01 d0                	add    %edx,%eax
    1e2d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1e30:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1e33:	8b 45 24             	mov    0x24(%ebp),%eax
    1e36:	01 d0                	add    %edx,%eax
    1e38:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1e3b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1e3f:	0f 88 51 01 00 00    	js     1f96 <APDcCopy+0x1a1>
    1e45:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e49:	0f 88 47 01 00 00    	js     1f96 <APDcCopy+0x1a1>
    1e4f:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1e53:	0f 88 3d 01 00 00    	js     1f96 <APDcCopy+0x1a1>
    1e59:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1e5d:	0f 88 33 01 00 00    	js     1f96 <APDcCopy+0x1a1>
    1e63:	8b 45 14             	mov    0x14(%ebp),%eax
    1e66:	8b 00                	mov    (%eax),%eax
    1e68:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1e6b:	0f 8c 25 01 00 00    	jl     1f96 <APDcCopy+0x1a1>
    1e71:	8b 45 14             	mov    0x14(%ebp),%eax
    1e74:	8b 40 04             	mov    0x4(%eax),%eax
    1e77:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1e7a:	0f 8c 16 01 00 00    	jl     1f96 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1e80:	8b 45 08             	mov    0x8(%ebp),%eax
    1e83:	8b 00                	mov    (%eax),%eax
    1e85:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1e88:	7f 0b                	jg     1e95 <APDcCopy+0xa0>
    1e8a:	8b 45 08             	mov    0x8(%ebp),%eax
    1e8d:	8b 00                	mov    (%eax),%eax
    1e8f:	83 e8 01             	sub    $0x1,%eax
    1e92:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1e95:	8b 45 08             	mov    0x8(%ebp),%eax
    1e98:	8b 40 04             	mov    0x4(%eax),%eax
    1e9b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1e9e:	7f 0c                	jg     1eac <APDcCopy+0xb7>
    1ea0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea3:	8b 40 04             	mov    0x4(%eax),%eax
    1ea6:	83 e8 01             	sub    $0x1,%eax
    1ea9:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1eac:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1eb3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1eba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1ec1:	e9 bc 00 00 00       	jmp    1f82 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1ec6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec9:	8b 00                	mov    (%eax),%eax
    1ecb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1ece:	8b 55 10             	mov    0x10(%ebp),%edx
    1ed1:	01 ca                	add    %ecx,%edx
    1ed3:	0f af d0             	imul   %eax,%edx
    1ed6:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ed9:	01 d0                	add    %edx,%eax
    1edb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1ede:	8b 45 14             	mov    0x14(%ebp),%eax
    1ee1:	8b 00                	mov    (%eax),%eax
    1ee3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1ee6:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1ee9:	01 ca                	add    %ecx,%edx
    1eeb:	0f af d0             	imul   %eax,%edx
    1eee:	8b 45 18             	mov    0x18(%ebp),%eax
    1ef1:	01 d0                	add    %edx,%eax
    1ef3:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1ef6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1efd:	eb 74                	jmp    1f73 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1eff:	8b 45 14             	mov    0x14(%ebp),%eax
    1f02:	8b 50 18             	mov    0x18(%eax),%edx
    1f05:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1f08:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f0b:	01 c8                	add    %ecx,%eax
    1f0d:	89 c1                	mov    %eax,%ecx
    1f0f:	89 c8                	mov    %ecx,%eax
    1f11:	01 c0                	add    %eax,%eax
    1f13:	01 c8                	add    %ecx,%eax
    1f15:	01 d0                	add    %edx,%eax
    1f17:	0f b7 10             	movzwl (%eax),%edx
    1f1a:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1f1e:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1f22:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1f25:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1f29:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1f2d:	38 c2                	cmp    %al,%dl
    1f2f:	75 18                	jne    1f49 <APDcCopy+0x154>
    1f31:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1f35:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1f39:	38 c2                	cmp    %al,%dl
    1f3b:	75 0c                	jne    1f49 <APDcCopy+0x154>
    1f3d:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1f41:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1f45:	38 c2                	cmp    %al,%dl
    1f47:	74 26                	je     1f6f <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1f49:	8b 45 08             	mov    0x8(%ebp),%eax
    1f4c:	8b 50 18             	mov    0x18(%eax),%edx
    1f4f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1f52:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f55:	01 c8                	add    %ecx,%eax
    1f57:	89 c1                	mov    %eax,%ecx
    1f59:	89 c8                	mov    %ecx,%eax
    1f5b:	01 c0                	add    %eax,%eax
    1f5d:	01 c8                	add    %ecx,%eax
    1f5f:	01 d0                	add    %edx,%eax
    1f61:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1f65:	66 89 10             	mov    %dx,(%eax)
    1f68:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1f6c:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1f6f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1f73:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1f76:	2b 45 0c             	sub    0xc(%ebp),%eax
    1f79:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1f7c:	7d 81                	jge    1eff <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1f7e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1f82:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f85:	2b 45 10             	sub    0x10(%ebp),%eax
    1f88:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1f8b:	0f 8d 35 ff ff ff    	jge    1ec6 <APDcCopy+0xd1>
    1f91:	eb 04                	jmp    1f97 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1f93:	90                   	nop
    1f94:	eb 01                	jmp    1f97 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1f96:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1f97:	c9                   	leave  
    1f98:	c3                   	ret    

00001f99 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1f99:	55                   	push   %ebp
    1f9a:	89 e5                	mov    %esp,%ebp
    1f9c:	83 ec 1c             	sub    $0x1c,%esp
    1f9f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1fa2:	8b 55 10             	mov    0x10(%ebp),%edx
    1fa5:	8b 45 14             	mov    0x14(%ebp),%eax
    1fa8:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1fab:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1fae:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1fb1:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1fb5:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1fb8:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1fbc:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1fbf:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1fc3:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1fc6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc9:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1fcd:	66 89 10             	mov    %dx,(%eax)
    1fd0:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1fd4:	88 50 02             	mov    %dl,0x2(%eax)
}
    1fd7:	8b 45 08             	mov    0x8(%ebp),%eax
    1fda:	c9                   	leave  
    1fdb:	c2 04 00             	ret    $0x4

00001fde <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1fde:	55                   	push   %ebp
    1fdf:	89 e5                	mov    %esp,%ebp
    1fe1:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1fe4:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe7:	8b 00                	mov    (%eax),%eax
    1fe9:	83 ec 08             	sub    $0x8,%esp
    1fec:	8d 55 0c             	lea    0xc(%ebp),%edx
    1fef:	52                   	push   %edx
    1ff0:	50                   	push   %eax
    1ff1:	e8 87 ef ff ff       	call   f7d <sendMessage>
    1ff6:	83 c4 10             	add    $0x10,%esp
}
    1ff9:	90                   	nop
    1ffa:	c9                   	leave  
    1ffb:	c3                   	ret    

00001ffc <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1ffc:	55                   	push   %ebp
    1ffd:	89 e5                	mov    %esp,%ebp
    1fff:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    2002:	83 ec 0c             	sub    $0xc,%esp
    2005:	68 98 00 00 00       	push   $0x98
    200a:	e8 38 f3 ff ff       	call   1347 <malloc>
    200f:	83 c4 10             	add    $0x10,%esp
    2012:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    2015:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2019:	75 15                	jne    2030 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    201b:	83 ec 04             	sub    $0x4,%esp
    201e:	ff 75 08             	pushl  0x8(%ebp)
    2021:	68 40 2f 00 00       	push   $0x2f40
    2026:	6a 01                	push   $0x1
    2028:	e8 47 f0 ff ff       	call   1074 <printf>
    202d:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    2030:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2033:	05 84 00 00 00       	add    $0x84,%eax
    2038:	83 ec 08             	sub    $0x8,%esp
    203b:	ff 75 08             	pushl  0x8(%ebp)
    203e:	50                   	push   %eax
    203f:	e8 60 ec ff ff       	call   ca4 <strcpy>
    2044:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    2047:	8b 45 f4             	mov    -0xc(%ebp),%eax
    204a:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    2051:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2054:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    205b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    205e:	8b 40 3c             	mov    0x3c(%eax),%eax
    2061:	89 c2                	mov    %eax,%edx
    2063:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2066:	8b 40 40             	mov    0x40(%eax),%eax
    2069:	0f af d0             	imul   %eax,%edx
    206c:	89 d0                	mov    %edx,%eax
    206e:	01 c0                	add    %eax,%eax
    2070:	01 d0                	add    %edx,%eax
    2072:	83 ec 0c             	sub    $0xc,%esp
    2075:	50                   	push   %eax
    2076:	e8 cc f2 ff ff       	call   1347 <malloc>
    207b:	83 c4 10             	add    $0x10,%esp
    207e:	89 c2                	mov    %eax,%edx
    2080:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2083:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    2086:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2089:	8b 40 54             	mov    0x54(%eax),%eax
    208c:	85 c0                	test   %eax,%eax
    208e:	75 15                	jne    20a5 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    2090:	83 ec 04             	sub    $0x4,%esp
    2093:	ff 75 08             	pushl  0x8(%ebp)
    2096:	68 60 2f 00 00       	push   $0x2f60
    209b:	6a 01                	push   $0x1
    209d:	e8 d2 ef ff ff       	call   1074 <printf>
    20a2:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    20a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20a8:	8b 40 3c             	mov    0x3c(%eax),%eax
    20ab:	89 c2                	mov    %eax,%edx
    20ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20b0:	8b 40 40             	mov    0x40(%eax),%eax
    20b3:	0f af d0             	imul   %eax,%edx
    20b6:	89 d0                	mov    %edx,%eax
    20b8:	01 c0                	add    %eax,%eax
    20ba:	01 c2                	add    %eax,%edx
    20bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20bf:	8b 40 54             	mov    0x54(%eax),%eax
    20c2:	83 ec 04             	sub    $0x4,%esp
    20c5:	52                   	push   %edx
    20c6:	68 ff ff ff 00       	push   $0xffffff
    20cb:	50                   	push   %eax
    20cc:	e8 69 ec ff ff       	call   d3a <memset>
    20d1:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    20d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20d7:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    20de:	e8 72 ee ff ff       	call   f55 <getpid>
    20e3:	89 c2                	mov    %eax,%edx
    20e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20e8:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    20eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20ee:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    20f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20f8:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    20ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2102:	8b 40 58             	mov    0x58(%eax),%eax
    2105:	89 c2                	mov    %eax,%edx
    2107:	8b 45 f4             	mov    -0xc(%ebp),%eax
    210a:	8b 40 5c             	mov    0x5c(%eax),%eax
    210d:	0f af d0             	imul   %eax,%edx
    2110:	89 d0                	mov    %edx,%eax
    2112:	01 c0                	add    %eax,%eax
    2114:	01 d0                	add    %edx,%eax
    2116:	83 ec 0c             	sub    $0xc,%esp
    2119:	50                   	push   %eax
    211a:	e8 28 f2 ff ff       	call   1347 <malloc>
    211f:	83 c4 10             	add    $0x10,%esp
    2122:	89 c2                	mov    %eax,%edx
    2124:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2127:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    212a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    212d:	8b 40 70             	mov    0x70(%eax),%eax
    2130:	85 c0                	test   %eax,%eax
    2132:	75 15                	jne    2149 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    2134:	83 ec 04             	sub    $0x4,%esp
    2137:	ff 75 08             	pushl  0x8(%ebp)
    213a:	68 84 2f 00 00       	push   $0x2f84
    213f:	6a 01                	push   $0x1
    2141:	e8 2e ef ff ff       	call   1074 <printf>
    2146:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    2149:	8b 45 f4             	mov    -0xc(%ebp),%eax
    214c:	8b 40 3c             	mov    0x3c(%eax),%eax
    214f:	89 c2                	mov    %eax,%edx
    2151:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2154:	8b 40 40             	mov    0x40(%eax),%eax
    2157:	0f af d0             	imul   %eax,%edx
    215a:	89 d0                	mov    %edx,%eax
    215c:	01 c0                	add    %eax,%eax
    215e:	01 c2                	add    %eax,%edx
    2160:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2163:	8b 40 54             	mov    0x54(%eax),%eax
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
    2185:	74 49                	je     21d0 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    2187:	8b 45 10             	mov    0x10(%ebp),%eax
    218a:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    2190:	83 ec 0c             	sub    $0xc,%esp
    2193:	50                   	push   %eax
    2194:	e8 ae f1 ff ff       	call   1347 <malloc>
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
        r->pos_x = 0;
    21b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21ba:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    21c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21c4:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    21cb:	e9 8d 00 00 00       	jmp    225d <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    21d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21d3:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    21da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21dd:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    21e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21e7:	8b 40 20             	mov    0x20(%eax),%eax
    21ea:	89 c2                	mov    %eax,%edx
    21ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21ef:	8b 40 24             	mov    0x24(%eax),%eax
    21f2:	0f af d0             	imul   %eax,%edx
    21f5:	89 d0                	mov    %edx,%eax
    21f7:	01 c0                	add    %eax,%eax
    21f9:	01 d0                	add    %edx,%eax
    21fb:	83 ec 0c             	sub    $0xc,%esp
    21fe:	50                   	push   %eax
    21ff:	e8 43 f1 ff ff       	call   1347 <malloc>
    2204:	83 c4 10             	add    $0x10,%esp
    2207:	89 c2                	mov    %eax,%edx
    2209:	8b 45 f4             	mov    -0xc(%ebp),%eax
    220c:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    220f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2212:	8b 40 38             	mov    0x38(%eax),%eax
    2215:	85 c0                	test   %eax,%eax
    2217:	75 15                	jne    222e <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    2219:	83 ec 04             	sub    $0x4,%esp
    221c:	ff 75 08             	pushl  0x8(%ebp)
    221f:	68 ac 2f 00 00       	push   $0x2fac
    2224:	6a 01                	push   $0x1
    2226:	e8 49 ee ff ff       	call   1074 <printf>
    222b:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    222e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2231:	8b 40 20             	mov    0x20(%eax),%eax
    2234:	89 c2                	mov    %eax,%edx
    2236:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2239:	8b 40 24             	mov    0x24(%eax),%eax
    223c:	0f af d0             	imul   %eax,%edx
    223f:	89 d0                	mov    %edx,%eax
    2241:	01 c0                	add    %eax,%eax
    2243:	01 c2                	add    %eax,%edx
    2245:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2248:	8b 40 38             	mov    0x38(%eax),%eax
    224b:	83 ec 04             	sub    $0x4,%esp
    224e:	52                   	push   %edx
    224f:	68 ff ff ff 00       	push   $0xffffff
    2254:	50                   	push   %eax
    2255:	e8 e0 ea ff ff       	call   d3a <memset>
    225a:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    225d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    2260:	c9                   	leave  
    2261:	c3                   	ret    

00002262 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    2262:	55                   	push   %ebp
    2263:	89 e5                	mov    %esp,%ebp
    2265:	57                   	push   %edi
    2266:	56                   	push   %esi
    2267:	53                   	push   %ebx
    2268:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    226b:	8b 45 0c             	mov    0xc(%ebp),%eax
    226e:	83 f8 03             	cmp    $0x3,%eax
    2271:	74 02                	je     2275 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    2273:	eb 7c                	jmp    22f1 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    2275:	8b 45 08             	mov    0x8(%ebp),%eax
    2278:	8b 58 1c             	mov    0x1c(%eax),%ebx
    227b:	8b 45 08             	mov    0x8(%ebp),%eax
    227e:	8b 48 18             	mov    0x18(%eax),%ecx
    2281:	8b 45 08             	mov    0x8(%ebp),%eax
    2284:	8b 50 5c             	mov    0x5c(%eax),%edx
    2287:	8b 45 08             	mov    0x8(%ebp),%eax
    228a:	8b 40 58             	mov    0x58(%eax),%eax
    228d:	8b 75 08             	mov    0x8(%ebp),%esi
    2290:	83 c6 58             	add    $0x58,%esi
    2293:	83 ec 04             	sub    $0x4,%esp
    2296:	53                   	push   %ebx
    2297:	51                   	push   %ecx
    2298:	6a 00                	push   $0x0
    229a:	52                   	push   %edx
    229b:	50                   	push   %eax
    229c:	6a 00                	push   $0x0
    229e:	6a 00                	push   $0x0
    22a0:	56                   	push   %esi
    22a1:	6a 00                	push   $0x0
    22a3:	6a 00                	push   $0x0
    22a5:	ff 75 08             	pushl  0x8(%ebp)
    22a8:	e8 c8 ec ff ff       	call   f75 <paintWindow>
    22ad:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    22b0:	8b 45 08             	mov    0x8(%ebp),%eax
    22b3:	8b 70 1c             	mov    0x1c(%eax),%esi
    22b6:	8b 45 08             	mov    0x8(%ebp),%eax
    22b9:	8b 58 18             	mov    0x18(%eax),%ebx
    22bc:	8b 45 08             	mov    0x8(%ebp),%eax
    22bf:	8b 48 08             	mov    0x8(%eax),%ecx
    22c2:	8b 45 08             	mov    0x8(%ebp),%eax
    22c5:	8b 50 40             	mov    0x40(%eax),%edx
    22c8:	8b 45 08             	mov    0x8(%ebp),%eax
    22cb:	8b 40 3c             	mov    0x3c(%eax),%eax
    22ce:	8b 7d 08             	mov    0x8(%ebp),%edi
    22d1:	83 c7 3c             	add    $0x3c,%edi
    22d4:	83 ec 04             	sub    $0x4,%esp
    22d7:	56                   	push   %esi
    22d8:	53                   	push   %ebx
    22d9:	51                   	push   %ecx
    22da:	52                   	push   %edx
    22db:	50                   	push   %eax
    22dc:	6a 00                	push   $0x0
    22de:	6a 00                	push   $0x0
    22e0:	57                   	push   %edi
    22e1:	6a 32                	push   $0x32
    22e3:	6a 00                	push   $0x0
    22e5:	ff 75 08             	pushl  0x8(%ebp)
    22e8:	e8 88 ec ff ff       	call   f75 <paintWindow>
    22ed:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    22f0:	90                   	nop
        default: break;
            
            
    }
    return False;
    22f1:	b8 00 00 00 00       	mov    $0x0,%eax
}
    22f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
    22f9:	5b                   	pop    %ebx
    22fa:	5e                   	pop    %esi
    22fb:	5f                   	pop    %edi
    22fc:	5d                   	pop    %ebp
    22fd:	c3                   	ret    

000022fe <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    22fe:	55                   	push   %ebp
    22ff:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    2301:	8b 45 0c             	mov    0xc(%ebp),%eax
    2304:	8b 50 08             	mov    0x8(%eax),%edx
    2307:	8b 45 08             	mov    0x8(%ebp),%eax
    230a:	8b 00                	mov    (%eax),%eax
    230c:	39 c2                	cmp    %eax,%edx
    230e:	74 07                	je     2317 <APPreJudge+0x19>
        return False;
    2310:	b8 00 00 00 00       	mov    $0x0,%eax
    2315:	eb 05                	jmp    231c <APPreJudge+0x1e>
    return True;
    2317:	b8 01 00 00 00       	mov    $0x1,%eax
}
    231c:	5d                   	pop    %ebp
    231d:	c3                   	ret    

0000231e <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    231e:	55                   	push   %ebp
    231f:	89 e5                	mov    %esp,%ebp
    2321:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    2324:	8b 45 08             	mov    0x8(%ebp),%eax
    2327:	8b 55 0c             	mov    0xc(%ebp),%edx
    232a:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    2330:	83 ec 0c             	sub    $0xc,%esp
    2333:	ff 75 08             	pushl  0x8(%ebp)
    2336:	e8 52 ec ff ff       	call   f8d <registWindow>
    233b:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    233e:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    2345:	8b 45 08             	mov    0x8(%ebp),%eax
    2348:	8b 00                	mov    (%eax),%eax
    234a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    234d:	ff 75 f4             	pushl  -0xc(%ebp)
    2350:	ff 75 f0             	pushl  -0x10(%ebp)
    2353:	ff 75 ec             	pushl  -0x14(%ebp)
    2356:	ff 75 08             	pushl  0x8(%ebp)
    2359:	e8 80 fc ff ff       	call   1fde <APSendMessage>
    235e:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    2361:	83 ec 0c             	sub    $0xc,%esp
    2364:	ff 75 08             	pushl  0x8(%ebp)
    2367:	e8 19 ec ff ff       	call   f85 <getMessage>
    236c:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    236f:	8b 45 08             	mov    0x8(%ebp),%eax
    2372:	83 c0 74             	add    $0x74,%eax
    2375:	83 ec 08             	sub    $0x8,%esp
    2378:	50                   	push   %eax
    2379:	ff 75 08             	pushl  0x8(%ebp)
    237c:	e8 7d ff ff ff       	call   22fe <APPreJudge>
    2381:	83 c4 10             	add    $0x10,%esp
    2384:	84 c0                	test   %al,%al
    2386:	74 1b                	je     23a3 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    2388:	8b 45 08             	mov    0x8(%ebp),%eax
    238b:	ff 70 7c             	pushl  0x7c(%eax)
    238e:	ff 70 78             	pushl  0x78(%eax)
    2391:	ff 70 74             	pushl  0x74(%eax)
    2394:	ff 75 08             	pushl  0x8(%ebp)
    2397:	8b 45 0c             	mov    0xc(%ebp),%eax
    239a:	ff d0                	call   *%eax
    239c:	83 c4 10             	add    $0x10,%esp
    239f:	84 c0                	test   %al,%al
    23a1:	75 0c                	jne    23af <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    23a3:	8b 45 08             	mov    0x8(%ebp),%eax
    23a6:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    23ad:	eb b2                	jmp    2361 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    23af:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    23b0:	90                   	nop
    23b1:	c9                   	leave  
    23b2:	c3                   	ret    

000023b3 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    23b3:	55                   	push   %ebp
    23b4:	89 e5                	mov    %esp,%ebp
    23b6:	57                   	push   %edi
    23b7:	56                   	push   %esi
    23b8:	53                   	push   %ebx
    23b9:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    23bc:	a1 f0 38 00 00       	mov    0x38f0,%eax
    23c1:	85 c0                	test   %eax,%eax
    23c3:	0f 85 2c 02 00 00    	jne    25f5 <APGridPaint+0x242>
    {
        iconReady = 1;
    23c9:	c7 05 f0 38 00 00 01 	movl   $0x1,0x38f0
    23d0:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    23d3:	8d 45 98             	lea    -0x68(%ebp),%eax
    23d6:	83 ec 08             	sub    $0x8,%esp
    23d9:	68 d3 2f 00 00       	push   $0x2fd3
    23de:	50                   	push   %eax
    23df:	e8 16 f1 ff ff       	call   14fa <APLoadBitmap>
    23e4:	83 c4 0c             	add    $0xc,%esp
    23e7:	8b 45 98             	mov    -0x68(%ebp),%eax
    23ea:	a3 14 39 00 00       	mov    %eax,0x3914
    23ef:	8b 45 9c             	mov    -0x64(%ebp),%eax
    23f2:	a3 18 39 00 00       	mov    %eax,0x3918
    23f7:	8b 45 a0             	mov    -0x60(%ebp),%eax
    23fa:	a3 1c 39 00 00       	mov    %eax,0x391c
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    23ff:	83 ec 04             	sub    $0x4,%esp
    2402:	ff 35 1c 39 00 00    	pushl  0x391c
    2408:	ff 35 18 39 00 00    	pushl  0x3918
    240e:	ff 35 14 39 00 00    	pushl  0x3914
    2414:	e8 1b f3 ff ff       	call   1734 <APCreateCompatibleDCFromBitmap>
    2419:	83 c4 10             	add    $0x10,%esp
    241c:	a3 20 39 00 00       	mov    %eax,0x3920
        grid_river = APLoadBitmap ("grid_river.bmp");
    2421:	8d 45 98             	lea    -0x68(%ebp),%eax
    2424:	83 ec 08             	sub    $0x8,%esp
    2427:	68 e1 2f 00 00       	push   $0x2fe1
    242c:	50                   	push   %eax
    242d:	e8 c8 f0 ff ff       	call   14fa <APLoadBitmap>
    2432:	83 c4 0c             	add    $0xc,%esp
    2435:	8b 45 98             	mov    -0x68(%ebp),%eax
    2438:	a3 50 39 00 00       	mov    %eax,0x3950
    243d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2440:	a3 54 39 00 00       	mov    %eax,0x3954
    2445:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2448:	a3 58 39 00 00       	mov    %eax,0x3958
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    244d:	83 ec 04             	sub    $0x4,%esp
    2450:	ff 35 58 39 00 00    	pushl  0x3958
    2456:	ff 35 54 39 00 00    	pushl  0x3954
    245c:	ff 35 50 39 00 00    	pushl  0x3950
    2462:	e8 cd f2 ff ff       	call   1734 <APCreateCompatibleDCFromBitmap>
    2467:	83 c4 10             	add    $0x10,%esp
    246a:	a3 40 39 00 00       	mov    %eax,0x3940
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    246f:	8d 45 98             	lea    -0x68(%ebp),%eax
    2472:	83 ec 08             	sub    $0x8,%esp
    2475:	68 f0 2f 00 00       	push   $0x2ff0
    247a:	50                   	push   %eax
    247b:	e8 7a f0 ff ff       	call   14fa <APLoadBitmap>
    2480:	83 c4 0c             	add    $0xc,%esp
    2483:	8b 45 98             	mov    -0x68(%ebp),%eax
    2486:	a3 44 39 00 00       	mov    %eax,0x3944
    248b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    248e:	a3 48 39 00 00       	mov    %eax,0x3948
    2493:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2496:	a3 4c 39 00 00       	mov    %eax,0x394c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    249b:	83 ec 04             	sub    $0x4,%esp
    249e:	ff 35 4c 39 00 00    	pushl  0x394c
    24a4:	ff 35 48 39 00 00    	pushl  0x3948
    24aa:	ff 35 44 39 00 00    	pushl  0x3944
    24b0:	e8 7f f2 ff ff       	call   1734 <APCreateCompatibleDCFromBitmap>
    24b5:	83 c4 10             	add    $0x10,%esp
    24b8:	a3 f4 38 00 00       	mov    %eax,0x38f4
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    24bd:	8d 45 98             	lea    -0x68(%ebp),%eax
    24c0:	83 ec 08             	sub    $0x8,%esp
    24c3:	68 ff 2f 00 00       	push   $0x2fff
    24c8:	50                   	push   %eax
    24c9:	e8 2c f0 ff ff       	call   14fa <APLoadBitmap>
    24ce:	83 c4 0c             	add    $0xc,%esp
    24d1:	8b 45 98             	mov    -0x68(%ebp),%eax
    24d4:	a3 28 39 00 00       	mov    %eax,0x3928
    24d9:	8b 45 9c             	mov    -0x64(%ebp),%eax
    24dc:	a3 2c 39 00 00       	mov    %eax,0x392c
    24e1:	8b 45 a0             	mov    -0x60(%ebp),%eax
    24e4:	a3 30 39 00 00       	mov    %eax,0x3930
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    24e9:	83 ec 04             	sub    $0x4,%esp
    24ec:	ff 35 30 39 00 00    	pushl  0x3930
    24f2:	ff 35 2c 39 00 00    	pushl  0x392c
    24f8:	ff 35 28 39 00 00    	pushl  0x3928
    24fe:	e8 31 f2 ff ff       	call   1734 <APCreateCompatibleDCFromBitmap>
    2503:	83 c4 10             	add    $0x10,%esp
    2506:	a3 5c 39 00 00       	mov    %eax,0x395c
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    250b:	8d 45 98             	lea    -0x68(%ebp),%eax
    250e:	83 ec 08             	sub    $0x8,%esp
    2511:	68 0d 30 00 00       	push   $0x300d
    2516:	50                   	push   %eax
    2517:	e8 de ef ff ff       	call   14fa <APLoadBitmap>
    251c:	83 c4 0c             	add    $0xc,%esp
    251f:	8b 45 98             	mov    -0x68(%ebp),%eax
    2522:	a3 04 39 00 00       	mov    %eax,0x3904
    2527:	8b 45 9c             	mov    -0x64(%ebp),%eax
    252a:	a3 08 39 00 00       	mov    %eax,0x3908
    252f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2532:	a3 0c 39 00 00       	mov    %eax,0x390c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    2537:	83 ec 04             	sub    $0x4,%esp
    253a:	ff 35 0c 39 00 00    	pushl  0x390c
    2540:	ff 35 08 39 00 00    	pushl  0x3908
    2546:	ff 35 04 39 00 00    	pushl  0x3904
    254c:	e8 e3 f1 ff ff       	call   1734 <APCreateCompatibleDCFromBitmap>
    2551:	83 c4 10             	add    $0x10,%esp
    2554:	a3 24 39 00 00       	mov    %eax,0x3924
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    2559:	8d 45 98             	lea    -0x68(%ebp),%eax
    255c:	83 ec 08             	sub    $0x8,%esp
    255f:	68 1d 30 00 00       	push   $0x301d
    2564:	50                   	push   %eax
    2565:	e8 90 ef ff ff       	call   14fa <APLoadBitmap>
    256a:	83 c4 0c             	add    $0xc,%esp
    256d:	8b 45 98             	mov    -0x68(%ebp),%eax
    2570:	a3 f8 38 00 00       	mov    %eax,0x38f8
    2575:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2578:	a3 fc 38 00 00       	mov    %eax,0x38fc
    257d:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2580:	a3 00 39 00 00       	mov    %eax,0x3900
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    2585:	83 ec 04             	sub    $0x4,%esp
    2588:	ff 35 00 39 00 00    	pushl  0x3900
    258e:	ff 35 fc 38 00 00    	pushl  0x38fc
    2594:	ff 35 f8 38 00 00    	pushl  0x38f8
    259a:	e8 95 f1 ff ff       	call   1734 <APCreateCompatibleDCFromBitmap>
    259f:	83 c4 10             	add    $0x10,%esp
    25a2:	a3 10 39 00 00       	mov    %eax,0x3910
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    25a7:	8d 45 98             	lea    -0x68(%ebp),%eax
    25aa:	83 ec 08             	sub    $0x8,%esp
    25ad:	68 2f 30 00 00       	push   $0x302f
    25b2:	50                   	push   %eax
    25b3:	e8 42 ef ff ff       	call   14fa <APLoadBitmap>
    25b8:	83 c4 0c             	add    $0xc,%esp
    25bb:	8b 45 98             	mov    -0x68(%ebp),%eax
    25be:	a3 34 39 00 00       	mov    %eax,0x3934
    25c3:	8b 45 9c             	mov    -0x64(%ebp),%eax
    25c6:	a3 38 39 00 00       	mov    %eax,0x3938
    25cb:	8b 45 a0             	mov    -0x60(%ebp),%eax
    25ce:	a3 3c 39 00 00       	mov    %eax,0x393c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    25d3:	83 ec 04             	sub    $0x4,%esp
    25d6:	ff 35 3c 39 00 00    	pushl  0x393c
    25dc:	ff 35 38 39 00 00    	pushl  0x3938
    25e2:	ff 35 34 39 00 00    	pushl  0x3934
    25e8:	e8 47 f1 ff ff       	call   1734 <APCreateCompatibleDCFromBitmap>
    25ed:	83 c4 10             	add    $0x10,%esp
    25f0:	a3 60 39 00 00       	mov    %eax,0x3960
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    25f5:	8b 45 08             	mov    0x8(%ebp),%eax
    25f8:	8b 40 08             	mov    0x8(%eax),%eax
    25fb:	85 c0                	test   %eax,%eax
    25fd:	75 17                	jne    2616 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    25ff:	83 ec 08             	sub    $0x8,%esp
    2602:	68 40 30 00 00       	push   $0x3040
    2607:	6a 01                	push   $0x1
    2609:	e8 66 ea ff ff       	call   1074 <printf>
    260e:	83 c4 10             	add    $0x10,%esp
        return;
    2611:	e9 a0 04 00 00       	jmp    2ab6 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    2616:	8b 45 08             	mov    0x8(%ebp),%eax
    2619:	8b 40 10             	mov    0x10(%eax),%eax
    261c:	85 c0                	test   %eax,%eax
    261e:	7e 10                	jle    2630 <APGridPaint+0x27d>
    2620:	8b 45 08             	mov    0x8(%ebp),%eax
    2623:	8b 50 14             	mov    0x14(%eax),%edx
    2626:	8b 45 08             	mov    0x8(%ebp),%eax
    2629:	8b 40 10             	mov    0x10(%eax),%eax
    262c:	39 c2                	cmp    %eax,%edx
    262e:	7c 17                	jl     2647 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    2630:	83 ec 08             	sub    $0x8,%esp
    2633:	68 66 30 00 00       	push   $0x3066
    2638:	6a 01                	push   $0x1
    263a:	e8 35 ea ff ff       	call   1074 <printf>
    263f:	83 c4 10             	add    $0x10,%esp
        return;
    2642:	e9 6f 04 00 00       	jmp    2ab6 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    2647:	8b 45 08             	mov    0x8(%ebp),%eax
    264a:	8b 40 14             	mov    0x14(%eax),%eax
    264d:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    2653:	89 45 dc             	mov    %eax,-0x24(%ebp)
    2656:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2659:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    265c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    2663:	e9 96 03 00 00       	jmp    29fe <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2668:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    266f:	e9 7c 03 00 00       	jmp    29f0 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    2674:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2677:	c1 e0 04             	shl    $0x4,%eax
    267a:	89 c2                	mov    %eax,%edx
    267c:	8b 45 d8             	mov    -0x28(%ebp),%eax
    267f:	01 c2                	add    %eax,%edx
    2681:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2684:	01 d0                	add    %edx,%eax
    2686:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    2689:	8b 45 08             	mov    0x8(%ebp),%eax
    268c:	8b 40 0c             	mov    0xc(%eax),%eax
    268f:	8b 55 dc             	mov    -0x24(%ebp),%edx
    2692:	c1 e2 02             	shl    $0x2,%edx
    2695:	01 d0                	add    %edx,%eax
    2697:	8b 00                	mov    (%eax),%eax
    2699:	83 f8 07             	cmp    $0x7,%eax
    269c:	0f 87 49 03 00 00    	ja     29eb <APGridPaint+0x638>
    26a2:	8b 04 85 7c 30 00 00 	mov    0x307c(,%eax,4),%eax
    26a9:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    26ab:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    26ae:	6a 0c                	push   $0xc
    26b0:	6a 0c                	push   $0xc
    26b2:	6a 0c                	push   $0xc
    26b4:	50                   	push   %eax
    26b5:	e8 df f8 ff ff       	call   1f99 <RGB>
    26ba:	83 c4 0c             	add    $0xc,%esp
    26bd:	8b 1d 20 39 00 00    	mov    0x3920,%ebx
    26c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    26c6:	6b c8 32             	imul   $0x32,%eax,%ecx
    26c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    26cc:	6b c0 32             	imul   $0x32,%eax,%eax
    26cf:	89 45 94             	mov    %eax,-0x6c(%ebp)
    26d2:	8b 45 08             	mov    0x8(%ebp),%eax
    26d5:	8d 78 3c             	lea    0x3c(%eax),%edi
    26d8:	83 ec 0c             	sub    $0xc,%esp
    26db:	83 ec 04             	sub    $0x4,%esp
    26de:	89 e0                	mov    %esp,%eax
    26e0:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    26e4:	66 89 30             	mov    %si,(%eax)
    26e7:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    26eb:	88 50 02             	mov    %dl,0x2(%eax)
    26ee:	6a 32                	push   $0x32
    26f0:	6a 32                	push   $0x32
    26f2:	6a 00                	push   $0x0
    26f4:	6a 00                	push   $0x0
    26f6:	53                   	push   %ebx
    26f7:	51                   	push   %ecx
    26f8:	ff 75 94             	pushl  -0x6c(%ebp)
    26fb:	57                   	push   %edi
    26fc:	e8 f4 f6 ff ff       	call   1df5 <APDcCopy>
    2701:	83 c4 30             	add    $0x30,%esp
                    break;
    2704:	e9 e3 02 00 00       	jmp    29ec <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    2709:	8d 45 98             	lea    -0x68(%ebp),%eax
    270c:	6a 69                	push   $0x69
    270e:	6a 69                	push   $0x69
    2710:	6a 69                	push   $0x69
    2712:	50                   	push   %eax
    2713:	e8 81 f8 ff ff       	call   1f99 <RGB>
    2718:	83 c4 0c             	add    $0xc,%esp
    271b:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    271f:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    2723:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2727:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    272a:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    2731:	8d 45 98             	lea    -0x68(%ebp),%eax
    2734:	6a 69                	push   $0x69
    2736:	6a 69                	push   $0x69
    2738:	6a 69                	push   $0x69
    273a:	50                   	push   %eax
    273b:	e8 59 f8 ff ff       	call   1f99 <RGB>
    2740:	83 c4 0c             	add    $0xc,%esp
    2743:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2747:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    274b:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    274f:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    2752:	8b 45 08             	mov    0x8(%ebp),%eax
    2755:	8d 50 3c             	lea    0x3c(%eax),%edx
    2758:	8d 45 98             	lea    -0x68(%ebp),%eax
    275b:	ff 75 b0             	pushl  -0x50(%ebp)
    275e:	ff 75 ac             	pushl  -0x54(%ebp)
    2761:	52                   	push   %edx
    2762:	50                   	push   %eax
    2763:	e8 61 f0 ff ff       	call   17c9 <APSetPen>
    2768:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    276b:	8b 45 08             	mov    0x8(%ebp),%eax
    276e:	8d 58 3c             	lea    0x3c(%eax),%ebx
    2771:	8d 55 98             	lea    -0x68(%ebp),%edx
    2774:	83 ec 04             	sub    $0x4,%esp
    2777:	83 ec 04             	sub    $0x4,%esp
    277a:	89 e0                	mov    %esp,%eax
    277c:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    2780:	66 89 08             	mov    %cx,(%eax)
    2783:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    2787:	88 48 02             	mov    %cl,0x2(%eax)
    278a:	53                   	push   %ebx
    278b:	52                   	push   %edx
    278c:	e8 71 f0 ff ff       	call   1802 <APSetBrush>
    2791:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    2794:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2797:	6b d0 32             	imul   $0x32,%eax,%edx
    279a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    279d:	6b c0 32             	imul   $0x32,%eax,%eax
    27a0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    27a3:	83 c1 3c             	add    $0x3c,%ecx
    27a6:	83 ec 0c             	sub    $0xc,%esp
    27a9:	6a 32                	push   $0x32
    27ab:	6a 32                	push   $0x32
    27ad:	52                   	push   %edx
    27ae:	50                   	push   %eax
    27af:	51                   	push   %ecx
    27b0:	e8 35 f4 ff ff       	call   1bea <APDrawRect>
    27b5:	83 c4 20             	add    $0x20,%esp
                    break;
    27b8:	e9 2f 02 00 00       	jmp    29ec <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    27bd:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    27c0:	6a 0c                	push   $0xc
    27c2:	6a 0c                	push   $0xc
    27c4:	6a 0c                	push   $0xc
    27c6:	50                   	push   %eax
    27c7:	e8 cd f7 ff ff       	call   1f99 <RGB>
    27cc:	83 c4 0c             	add    $0xc,%esp
    27cf:	8b 1d 60 39 00 00    	mov    0x3960,%ebx
    27d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    27d8:	6b c8 32             	imul   $0x32,%eax,%ecx
    27db:	8b 45 e0             	mov    -0x20(%ebp),%eax
    27de:	6b c0 32             	imul   $0x32,%eax,%eax
    27e1:	89 45 94             	mov    %eax,-0x6c(%ebp)
    27e4:	8b 45 08             	mov    0x8(%ebp),%eax
    27e7:	8d 78 3c             	lea    0x3c(%eax),%edi
    27ea:	83 ec 0c             	sub    $0xc,%esp
    27ed:	83 ec 04             	sub    $0x4,%esp
    27f0:	89 e0                	mov    %esp,%eax
    27f2:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    27f6:	66 89 30             	mov    %si,(%eax)
    27f9:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    27fd:	88 50 02             	mov    %dl,0x2(%eax)
    2800:	6a 32                	push   $0x32
    2802:	6a 32                	push   $0x32
    2804:	6a 00                	push   $0x0
    2806:	6a 00                	push   $0x0
    2808:	53                   	push   %ebx
    2809:	51                   	push   %ecx
    280a:	ff 75 94             	pushl  -0x6c(%ebp)
    280d:	57                   	push   %edi
    280e:	e8 e2 f5 ff ff       	call   1df5 <APDcCopy>
    2813:	83 c4 30             	add    $0x30,%esp
                    break;
    2816:	e9 d1 01 00 00       	jmp    29ec <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    281b:	8d 45 c9             	lea    -0x37(%ebp),%eax
    281e:	6a 0c                	push   $0xc
    2820:	6a 0c                	push   $0xc
    2822:	6a 0c                	push   $0xc
    2824:	50                   	push   %eax
    2825:	e8 6f f7 ff ff       	call   1f99 <RGB>
    282a:	83 c4 0c             	add    $0xc,%esp
    282d:	8b 1d 40 39 00 00    	mov    0x3940,%ebx
    2833:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2836:	6b c8 32             	imul   $0x32,%eax,%ecx
    2839:	8b 45 e0             	mov    -0x20(%ebp),%eax
    283c:	6b c0 32             	imul   $0x32,%eax,%eax
    283f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2842:	8b 45 08             	mov    0x8(%ebp),%eax
    2845:	8d 78 3c             	lea    0x3c(%eax),%edi
    2848:	83 ec 0c             	sub    $0xc,%esp
    284b:	83 ec 04             	sub    $0x4,%esp
    284e:	89 e0                	mov    %esp,%eax
    2850:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    2854:	66 89 30             	mov    %si,(%eax)
    2857:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    285b:	88 50 02             	mov    %dl,0x2(%eax)
    285e:	6a 32                	push   $0x32
    2860:	6a 32                	push   $0x32
    2862:	6a 00                	push   $0x0
    2864:	6a 00                	push   $0x0
    2866:	53                   	push   %ebx
    2867:	51                   	push   %ecx
    2868:	ff 75 94             	pushl  -0x6c(%ebp)
    286b:	57                   	push   %edi
    286c:	e8 84 f5 ff ff       	call   1df5 <APDcCopy>
    2871:	83 c4 30             	add    $0x30,%esp
                    break;
    2874:	e9 73 01 00 00       	jmp    29ec <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2879:	8d 45 cc             	lea    -0x34(%ebp),%eax
    287c:	6a 0c                	push   $0xc
    287e:	6a 0c                	push   $0xc
    2880:	6a 0c                	push   $0xc
    2882:	50                   	push   %eax
    2883:	e8 11 f7 ff ff       	call   1f99 <RGB>
    2888:	83 c4 0c             	add    $0xc,%esp
    288b:	8b 1d 24 39 00 00    	mov    0x3924,%ebx
    2891:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2894:	6b c8 32             	imul   $0x32,%eax,%ecx
    2897:	8b 45 e0             	mov    -0x20(%ebp),%eax
    289a:	6b c0 32             	imul   $0x32,%eax,%eax
    289d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    28a0:	8b 45 08             	mov    0x8(%ebp),%eax
    28a3:	8d 78 3c             	lea    0x3c(%eax),%edi
    28a6:	83 ec 0c             	sub    $0xc,%esp
    28a9:	83 ec 04             	sub    $0x4,%esp
    28ac:	89 e0                	mov    %esp,%eax
    28ae:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    28b2:	66 89 30             	mov    %si,(%eax)
    28b5:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    28b9:	88 50 02             	mov    %dl,0x2(%eax)
    28bc:	6a 32                	push   $0x32
    28be:	6a 32                	push   $0x32
    28c0:	6a 00                	push   $0x0
    28c2:	6a 00                	push   $0x0
    28c4:	53                   	push   %ebx
    28c5:	51                   	push   %ecx
    28c6:	ff 75 94             	pushl  -0x6c(%ebp)
    28c9:	57                   	push   %edi
    28ca:	e8 26 f5 ff ff       	call   1df5 <APDcCopy>
    28cf:	83 c4 30             	add    $0x30,%esp
                    break;
    28d2:	e9 15 01 00 00       	jmp    29ec <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    28d7:	8d 45 cf             	lea    -0x31(%ebp),%eax
    28da:	6a 0c                	push   $0xc
    28dc:	6a 0c                	push   $0xc
    28de:	6a 0c                	push   $0xc
    28e0:	50                   	push   %eax
    28e1:	e8 b3 f6 ff ff       	call   1f99 <RGB>
    28e6:	83 c4 0c             	add    $0xc,%esp
    28e9:	8b 1d 5c 39 00 00    	mov    0x395c,%ebx
    28ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    28f2:	6b c8 32             	imul   $0x32,%eax,%ecx
    28f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    28f8:	6b c0 32             	imul   $0x32,%eax,%eax
    28fb:	89 45 94             	mov    %eax,-0x6c(%ebp)
    28fe:	8b 45 08             	mov    0x8(%ebp),%eax
    2901:	8d 78 3c             	lea    0x3c(%eax),%edi
    2904:	83 ec 0c             	sub    $0xc,%esp
    2907:	83 ec 04             	sub    $0x4,%esp
    290a:	89 e0                	mov    %esp,%eax
    290c:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    2910:	66 89 30             	mov    %si,(%eax)
    2913:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2917:	88 50 02             	mov    %dl,0x2(%eax)
    291a:	6a 32                	push   $0x32
    291c:	6a 32                	push   $0x32
    291e:	6a 00                	push   $0x0
    2920:	6a 00                	push   $0x0
    2922:	53                   	push   %ebx
    2923:	51                   	push   %ecx
    2924:	ff 75 94             	pushl  -0x6c(%ebp)
    2927:	57                   	push   %edi
    2928:	e8 c8 f4 ff ff       	call   1df5 <APDcCopy>
    292d:	83 c4 30             	add    $0x30,%esp
                    break;
    2930:	e9 b7 00 00 00       	jmp    29ec <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2935:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2938:	6a 0c                	push   $0xc
    293a:	6a 0c                	push   $0xc
    293c:	6a 0c                	push   $0xc
    293e:	50                   	push   %eax
    293f:	e8 55 f6 ff ff       	call   1f99 <RGB>
    2944:	83 c4 0c             	add    $0xc,%esp
    2947:	8b 1d f4 38 00 00    	mov    0x38f4,%ebx
    294d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2950:	6b c8 32             	imul   $0x32,%eax,%ecx
    2953:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2956:	6b c0 32             	imul   $0x32,%eax,%eax
    2959:	89 45 94             	mov    %eax,-0x6c(%ebp)
    295c:	8b 45 08             	mov    0x8(%ebp),%eax
    295f:	8d 78 3c             	lea    0x3c(%eax),%edi
    2962:	83 ec 0c             	sub    $0xc,%esp
    2965:	83 ec 04             	sub    $0x4,%esp
    2968:	89 e0                	mov    %esp,%eax
    296a:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    296e:	66 89 30             	mov    %si,(%eax)
    2971:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2975:	88 50 02             	mov    %dl,0x2(%eax)
    2978:	6a 32                	push   $0x32
    297a:	6a 32                	push   $0x32
    297c:	6a 00                	push   $0x0
    297e:	6a 00                	push   $0x0
    2980:	53                   	push   %ebx
    2981:	51                   	push   %ecx
    2982:	ff 75 94             	pushl  -0x6c(%ebp)
    2985:	57                   	push   %edi
    2986:	e8 6a f4 ff ff       	call   1df5 <APDcCopy>
    298b:	83 c4 30             	add    $0x30,%esp
                    break;
    298e:	eb 5c                	jmp    29ec <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2990:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    2993:	6a 0c                	push   $0xc
    2995:	6a 0c                	push   $0xc
    2997:	6a 0c                	push   $0xc
    2999:	50                   	push   %eax
    299a:	e8 fa f5 ff ff       	call   1f99 <RGB>
    299f:	83 c4 0c             	add    $0xc,%esp
    29a2:	8b 1d 10 39 00 00    	mov    0x3910,%ebx
    29a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    29ab:	6b c8 32             	imul   $0x32,%eax,%ecx
    29ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
    29b1:	6b c0 32             	imul   $0x32,%eax,%eax
    29b4:	89 45 94             	mov    %eax,-0x6c(%ebp)
    29b7:	8b 45 08             	mov    0x8(%ebp),%eax
    29ba:	8d 78 3c             	lea    0x3c(%eax),%edi
    29bd:	83 ec 0c             	sub    $0xc,%esp
    29c0:	83 ec 04             	sub    $0x4,%esp
    29c3:	89 e0                	mov    %esp,%eax
    29c5:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    29c9:	66 89 30             	mov    %si,(%eax)
    29cc:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    29d0:	88 50 02             	mov    %dl,0x2(%eax)
    29d3:	6a 32                	push   $0x32
    29d5:	6a 32                	push   $0x32
    29d7:	6a 00                	push   $0x0
    29d9:	6a 00                	push   $0x0
    29db:	53                   	push   %ebx
    29dc:	51                   	push   %ecx
    29dd:	ff 75 94             	pushl  -0x6c(%ebp)
    29e0:	57                   	push   %edi
    29e1:	e8 0f f4 ff ff       	call   1df5 <APDcCopy>
    29e6:	83 c4 30             	add    $0x30,%esp
                    break;
    29e9:	eb 01                	jmp    29ec <APGridPaint+0x639>
                default: break;
    29eb:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    29ec:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    29f0:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    29f4:	0f 8e 7a fc ff ff    	jle    2674 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    29fa:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    29fe:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2a02:	0f 8e 60 fc ff ff    	jle    2668 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2a08:	8d 45 98             	lea    -0x68(%ebp),%eax
    2a0b:	68 cd 00 00 00       	push   $0xcd
    2a10:	6a 74                	push   $0x74
    2a12:	6a 18                	push   $0x18
    2a14:	50                   	push   %eax
    2a15:	e8 7f f5 ff ff       	call   1f99 <RGB>
    2a1a:	83 c4 0c             	add    $0xc,%esp
    2a1d:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2a21:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    2a25:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2a29:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    2a2c:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2a33:	8d 45 98             	lea    -0x68(%ebp),%eax
    2a36:	68 cd 00 00 00       	push   $0xcd
    2a3b:	6a 74                	push   $0x74
    2a3d:	6a 18                	push   $0x18
    2a3f:	50                   	push   %eax
    2a40:	e8 54 f5 ff ff       	call   1f99 <RGB>
    2a45:	83 c4 0c             	add    $0xc,%esp
    2a48:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2a4c:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    2a50:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2a54:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    2a57:	8b 45 08             	mov    0x8(%ebp),%eax
    2a5a:	8d 50 58             	lea    0x58(%eax),%edx
    2a5d:	8d 45 98             	lea    -0x68(%ebp),%eax
    2a60:	ff 75 bc             	pushl  -0x44(%ebp)
    2a63:	ff 75 b8             	pushl  -0x48(%ebp)
    2a66:	52                   	push   %edx
    2a67:	50                   	push   %eax
    2a68:	e8 5c ed ff ff       	call   17c9 <APSetPen>
    2a6d:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2a70:	8b 45 08             	mov    0x8(%ebp),%eax
    2a73:	8d 58 58             	lea    0x58(%eax),%ebx
    2a76:	8d 55 98             	lea    -0x68(%ebp),%edx
    2a79:	83 ec 04             	sub    $0x4,%esp
    2a7c:	83 ec 04             	sub    $0x4,%esp
    2a7f:	89 e0                	mov    %esp,%eax
    2a81:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    2a85:	66 89 08             	mov    %cx,(%eax)
    2a88:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    2a8c:	88 48 02             	mov    %cl,0x2(%eax)
    2a8f:	53                   	push   %ebx
    2a90:	52                   	push   %edx
    2a91:	e8 6c ed ff ff       	call   1802 <APSetBrush>
    2a96:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2a99:	8b 45 08             	mov    0x8(%ebp),%eax
    2a9c:	83 c0 58             	add    $0x58,%eax
    2a9f:	83 ec 0c             	sub    $0xc,%esp
    2aa2:	6a 32                	push   $0x32
    2aa4:	68 20 03 00 00       	push   $0x320
    2aa9:	6a 00                	push   $0x0
    2aab:	6a 00                	push   $0x0
    2aad:	50                   	push   %eax
    2aae:	e8 37 f1 ff ff       	call   1bea <APDrawRect>
    2ab3:	83 c4 20             	add    $0x20,%esp
}
    2ab6:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2ab9:	5b                   	pop    %ebx
    2aba:	5e                   	pop    %esi
    2abb:	5f                   	pop    %edi
    2abc:	5d                   	pop    %ebp
    2abd:	c3                   	ret    

00002abe <random>:
//

#include "APLib.h"

int random(int seed)
{
    2abe:	55                   	push   %ebp
    2abf:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2ac1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2ac5:	7e 08                	jle    2acf <random+0x11>
{
rand_num = seed;
    2ac7:	8b 45 08             	mov    0x8(%ebp),%eax
    2aca:	a3 58 38 00 00       	mov    %eax,0x3858
}
rand_num *= 3;
    2acf:	8b 15 58 38 00 00    	mov    0x3858,%edx
    2ad5:	89 d0                	mov    %edx,%eax
    2ad7:	01 c0                	add    %eax,%eax
    2ad9:	01 d0                	add    %edx,%eax
    2adb:	a3 58 38 00 00       	mov    %eax,0x3858
if (rand_num < 0)
    2ae0:	a1 58 38 00 00       	mov    0x3858,%eax
    2ae5:	85 c0                	test   %eax,%eax
    2ae7:	79 0c                	jns    2af5 <random+0x37>
{
rand_num *= (-1);
    2ae9:	a1 58 38 00 00       	mov    0x3858,%eax
    2aee:	f7 d8                	neg    %eax
    2af0:	a3 58 38 00 00       	mov    %eax,0x3858
}
return rand_num % 997;
    2af5:	8b 0d 58 38 00 00    	mov    0x3858,%ecx
    2afb:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2b00:	89 c8                	mov    %ecx,%eax
    2b02:	f7 ea                	imul   %edx
    2b04:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2b07:	c1 f8 09             	sar    $0x9,%eax
    2b0a:	89 c2                	mov    %eax,%edx
    2b0c:	89 c8                	mov    %ecx,%eax
    2b0e:	c1 f8 1f             	sar    $0x1f,%eax
    2b11:	29 c2                	sub    %eax,%edx
    2b13:	89 d0                	mov    %edx,%eax
    2b15:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2b1b:	29 c1                	sub    %eax,%ecx
    2b1d:	89 c8                	mov    %ecx,%eax
}
    2b1f:	5d                   	pop    %ebp
    2b20:	c3                   	ret    

00002b21 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2b21:	55                   	push   %ebp
    2b22:	89 e5                	mov    %esp,%ebp
    2b24:	53                   	push   %ebx
    2b25:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2b28:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2b2f:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2b33:	74 17                	je     2b4c <sprintint+0x2b>
    2b35:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2b39:	79 11                	jns    2b4c <sprintint+0x2b>
        neg = 1;
    2b3b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2b42:	8b 45 10             	mov    0x10(%ebp),%eax
    2b45:	f7 d8                	neg    %eax
    2b47:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2b4a:	eb 06                	jmp    2b52 <sprintint+0x31>
    } else {
        x = xx;
    2b4c:	8b 45 10             	mov    0x10(%ebp),%eax
    2b4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2b52:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2b59:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2b5c:	8d 41 01             	lea    0x1(%ecx),%eax
    2b5f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2b62:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2b65:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2b68:	ba 00 00 00 00       	mov    $0x0,%edx
    2b6d:	f7 f3                	div    %ebx
    2b6f:	89 d0                	mov    %edx,%eax
    2b71:	0f b6 80 5c 38 00 00 	movzbl 0x385c(%eax),%eax
    2b78:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2b7c:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2b7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2b82:	ba 00 00 00 00       	mov    $0x0,%edx
    2b87:	f7 f3                	div    %ebx
    2b89:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2b8c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2b90:	75 c7                	jne    2b59 <sprintint+0x38>
    if(neg)
    2b92:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2b96:	74 0e                	je     2ba6 <sprintint+0x85>
        buf[i++] = '-';
    2b98:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2b9b:	8d 50 01             	lea    0x1(%eax),%edx
    2b9e:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2ba1:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2ba6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2ba9:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2bac:	eb 1b                	jmp    2bc9 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2bae:	8b 45 0c             	mov    0xc(%ebp),%eax
    2bb1:	8b 00                	mov    (%eax),%eax
    2bb3:	8d 48 01             	lea    0x1(%eax),%ecx
    2bb6:	8b 55 0c             	mov    0xc(%ebp),%edx
    2bb9:	89 0a                	mov    %ecx,(%edx)
    2bbb:	89 c2                	mov    %eax,%edx
    2bbd:	8b 45 08             	mov    0x8(%ebp),%eax
    2bc0:	01 d0                	add    %edx,%eax
    2bc2:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2bc5:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2bc9:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2bcd:	7f df                	jg     2bae <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2bcf:	eb 21                	jmp    2bf2 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2bd1:	8b 45 0c             	mov    0xc(%ebp),%eax
    2bd4:	8b 00                	mov    (%eax),%eax
    2bd6:	8d 48 01             	lea    0x1(%eax),%ecx
    2bd9:	8b 55 0c             	mov    0xc(%ebp),%edx
    2bdc:	89 0a                	mov    %ecx,(%edx)
    2bde:	89 c2                	mov    %eax,%edx
    2be0:	8b 45 08             	mov    0x8(%ebp),%eax
    2be3:	01 c2                	add    %eax,%edx
    2be5:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2be8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2beb:	01 c8                	add    %ecx,%eax
    2bed:	0f b6 00             	movzbl (%eax),%eax
    2bf0:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2bf2:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2bf6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2bfa:	79 d5                	jns    2bd1 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2bfc:	90                   	nop
    2bfd:	83 c4 20             	add    $0x20,%esp
    2c00:	5b                   	pop    %ebx
    2c01:	5d                   	pop    %ebp
    2c02:	c3                   	ret    

00002c03 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2c03:	55                   	push   %ebp
    2c04:	89 e5                	mov    %esp,%ebp
    2c06:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2c09:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2c10:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2c17:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2c1e:	8d 45 0c             	lea    0xc(%ebp),%eax
    2c21:	83 c0 04             	add    $0x4,%eax
    2c24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2c27:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2c2e:	e9 d9 01 00 00       	jmp    2e0c <sprintf+0x209>
        c = fmt[i] & 0xff;
    2c33:	8b 55 0c             	mov    0xc(%ebp),%edx
    2c36:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2c39:	01 d0                	add    %edx,%eax
    2c3b:	0f b6 00             	movzbl (%eax),%eax
    2c3e:	0f be c0             	movsbl %al,%eax
    2c41:	25 ff 00 00 00       	and    $0xff,%eax
    2c46:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2c49:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2c4d:	75 2c                	jne    2c7b <sprintf+0x78>
            if(c == '%'){
    2c4f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2c53:	75 0c                	jne    2c61 <sprintf+0x5e>
                state = '%';
    2c55:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2c5c:	e9 a7 01 00 00       	jmp    2e08 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2c61:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2c64:	8d 50 01             	lea    0x1(%eax),%edx
    2c67:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2c6a:	89 c2                	mov    %eax,%edx
    2c6c:	8b 45 08             	mov    0x8(%ebp),%eax
    2c6f:	01 d0                	add    %edx,%eax
    2c71:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2c74:	88 10                	mov    %dl,(%eax)
    2c76:	e9 8d 01 00 00       	jmp    2e08 <sprintf+0x205>
            }
        } else if(state == '%'){
    2c7b:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2c7f:	0f 85 83 01 00 00    	jne    2e08 <sprintf+0x205>
            if(c == 'd'){
    2c85:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2c89:	75 4c                	jne    2cd7 <sprintf+0xd4>
                buf[bi] = '\0';
    2c8b:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2c8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2c91:	01 d0                	add    %edx,%eax
    2c93:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2c96:	83 ec 0c             	sub    $0xc,%esp
    2c99:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2c9c:	50                   	push   %eax
    2c9d:	e8 a1 e1 ff ff       	call   e43 <atoi>
    2ca2:	83 c4 10             	add    $0x10,%esp
    2ca5:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2ca8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2caf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2cb2:	8b 00                	mov    (%eax),%eax
    2cb4:	83 ec 08             	sub    $0x8,%esp
    2cb7:	ff 75 d8             	pushl  -0x28(%ebp)
    2cba:	6a 01                	push   $0x1
    2cbc:	6a 0a                	push   $0xa
    2cbe:	50                   	push   %eax
    2cbf:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2cc2:	50                   	push   %eax
    2cc3:	ff 75 08             	pushl  0x8(%ebp)
    2cc6:	e8 56 fe ff ff       	call   2b21 <sprintint>
    2ccb:	83 c4 20             	add    $0x20,%esp
                ap++;
    2cce:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2cd2:	e9 2a 01 00 00       	jmp    2e01 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2cd7:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2cdb:	74 06                	je     2ce3 <sprintf+0xe0>
    2cdd:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2ce1:	75 4c                	jne    2d2f <sprintf+0x12c>
                buf[bi] = '\0';
    2ce3:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2ce6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2ce9:	01 d0                	add    %edx,%eax
    2ceb:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2cee:	83 ec 0c             	sub    $0xc,%esp
    2cf1:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2cf4:	50                   	push   %eax
    2cf5:	e8 49 e1 ff ff       	call   e43 <atoi>
    2cfa:	83 c4 10             	add    $0x10,%esp
    2cfd:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2d00:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2d07:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2d0a:	8b 00                	mov    (%eax),%eax
    2d0c:	83 ec 08             	sub    $0x8,%esp
    2d0f:	ff 75 dc             	pushl  -0x24(%ebp)
    2d12:	6a 00                	push   $0x0
    2d14:	6a 10                	push   $0x10
    2d16:	50                   	push   %eax
    2d17:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2d1a:	50                   	push   %eax
    2d1b:	ff 75 08             	pushl  0x8(%ebp)
    2d1e:	e8 fe fd ff ff       	call   2b21 <sprintint>
    2d23:	83 c4 20             	add    $0x20,%esp
                ap++;
    2d26:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2d2a:	e9 d2 00 00 00       	jmp    2e01 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2d2f:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2d33:	75 46                	jne    2d7b <sprintf+0x178>
                s = (char*)*ap;
    2d35:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2d38:	8b 00                	mov    (%eax),%eax
    2d3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2d3d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2d41:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2d45:	75 25                	jne    2d6c <sprintf+0x169>
                    s = "(null)";
    2d47:	c7 45 f4 9c 30 00 00 	movl   $0x309c,-0xc(%ebp)
                while(*s != 0){
    2d4e:	eb 1c                	jmp    2d6c <sprintf+0x169>
                    dst[j++] = *s;
    2d50:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2d53:	8d 50 01             	lea    0x1(%eax),%edx
    2d56:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2d59:	89 c2                	mov    %eax,%edx
    2d5b:	8b 45 08             	mov    0x8(%ebp),%eax
    2d5e:	01 c2                	add    %eax,%edx
    2d60:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2d63:	0f b6 00             	movzbl (%eax),%eax
    2d66:	88 02                	mov    %al,(%edx)
                    s++;
    2d68:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2d6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2d6f:	0f b6 00             	movzbl (%eax),%eax
    2d72:	84 c0                	test   %al,%al
    2d74:	75 da                	jne    2d50 <sprintf+0x14d>
    2d76:	e9 86 00 00 00       	jmp    2e01 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2d7b:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2d7f:	75 1d                	jne    2d9e <sprintf+0x19b>
                dst[j++] = *ap;
    2d81:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2d84:	8d 50 01             	lea    0x1(%eax),%edx
    2d87:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2d8a:	89 c2                	mov    %eax,%edx
    2d8c:	8b 45 08             	mov    0x8(%ebp),%eax
    2d8f:	01 c2                	add    %eax,%edx
    2d91:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2d94:	8b 00                	mov    (%eax),%eax
    2d96:	88 02                	mov    %al,(%edx)
                ap++;
    2d98:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2d9c:	eb 63                	jmp    2e01 <sprintf+0x1fe>
            } else if(c == '%'){
    2d9e:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2da2:	75 17                	jne    2dbb <sprintf+0x1b8>
                dst[j++] = c;
    2da4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2da7:	8d 50 01             	lea    0x1(%eax),%edx
    2daa:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2dad:	89 c2                	mov    %eax,%edx
    2daf:	8b 45 08             	mov    0x8(%ebp),%eax
    2db2:	01 d0                	add    %edx,%eax
    2db4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2db7:	88 10                	mov    %dl,(%eax)
    2db9:	eb 46                	jmp    2e01 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2dbb:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2dbf:	7e 18                	jle    2dd9 <sprintf+0x1d6>
    2dc1:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2dc5:	7f 12                	jg     2dd9 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2dc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2dca:	8d 50 01             	lea    0x1(%eax),%edx
    2dcd:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2dd0:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2dd3:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2dd7:	eb 2f                	jmp    2e08 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2dd9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2ddc:	8d 50 01             	lea    0x1(%eax),%edx
    2ddf:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2de2:	89 c2                	mov    %eax,%edx
    2de4:	8b 45 08             	mov    0x8(%ebp),%eax
    2de7:	01 d0                	add    %edx,%eax
    2de9:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2dec:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2def:	8d 50 01             	lea    0x1(%eax),%edx
    2df2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2df5:	89 c2                	mov    %eax,%edx
    2df7:	8b 45 08             	mov    0x8(%ebp),%eax
    2dfa:	01 d0                	add    %edx,%eax
    2dfc:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2dff:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2e01:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2e08:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2e0c:	8b 55 0c             	mov    0xc(%ebp),%edx
    2e0f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2e12:	01 d0                	add    %edx,%eax
    2e14:	0f b6 00             	movzbl (%eax),%eax
    2e17:	84 c0                	test   %al,%al
    2e19:	0f 85 14 fe ff ff    	jne    2c33 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2e1f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2e22:	8d 50 01             	lea    0x1(%eax),%edx
    2e25:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2e28:	89 c2                	mov    %eax,%edx
    2e2a:	8b 45 08             	mov    0x8(%ebp),%eax
    2e2d:	01 d0                	add    %edx,%eax
    2e2f:	c6 00 00             	movb   $0x0,(%eax)
}
    2e32:	90                   	nop
    2e33:	c9                   	leave  
    2e34:	c3                   	ret    
