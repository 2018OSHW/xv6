
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
      1b:	8b 04 85 f4 31 00 00 	mov    0x31f4(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 c8 31 00 00       	push   $0x31c8
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
      6c:	68 cf 31 00 00       	push   $0x31cf
      71:	6a 02                	push   $0x2
      73:	e8 1c 10 00 00       	call   1094 <printf>
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
      bf:	68 df 31 00 00       	push   $0x31df
      c4:	6a 02                	push   $0x2
      c6:	e8 c9 0f 00 00       	call   1094 <printf>
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
     143:	68 ef 31 00 00       	push   $0x31ef
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
     254:	68 0c 32 00 00       	push   $0x320c
     259:	6a 02                	push   $0x2
     25b:	e8 34 0e 00 00       	call   1094 <printf>
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
     2ce:	68 0f 32 00 00       	push   $0x320f
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
     2e9:	0f b6 05 c0 78 00 00 	movzbl 0x78c0,%eax
     2f0:	3c 63                	cmp    $0x63,%al
     2f2:	75 5f                	jne    353 <main+0xb3>
     2f4:	0f b6 05 c1 78 00 00 	movzbl 0x78c1,%eax
     2fb:	3c 64                	cmp    $0x64,%al
     2fd:	75 54                	jne    353 <main+0xb3>
     2ff:	0f b6 05 c2 78 00 00 	movzbl 0x78c2,%eax
     306:	3c 20                	cmp    $0x20,%al
     308:	75 49                	jne    353 <main+0xb3>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     30a:	83 ec 0c             	sub    $0xc,%esp
     30d:	68 c0 78 00 00       	push   $0x78c0
     312:	e8 fc 09 00 00       	call   d13 <strlen>
     317:	83 c4 10             	add    $0x10,%esp
     31a:	83 e8 01             	sub    $0x1,%eax
     31d:	c6 80 c0 78 00 00 00 	movb   $0x0,0x78c0(%eax)
      if(chdir(buf+3) < 0)
     324:	b8 c3 78 00 00       	mov    $0x78c3,%eax
     329:	83 ec 0c             	sub    $0xc,%esp
     32c:	50                   	push   %eax
     32d:	e8 13 0c 00 00       	call   f45 <chdir>
     332:	83 c4 10             	add    $0x10,%esp
     335:	85 c0                	test   %eax,%eax
     337:	79 44                	jns    37d <main+0xdd>
        printf(2, "cannot cd %s\n", buf+3);
     339:	b8 c3 78 00 00       	mov    $0x78c3,%eax
     33e:	83 ec 04             	sub    $0x4,%esp
     341:	50                   	push   %eax
     342:	68 17 32 00 00       	push   $0x3217
     347:	6a 02                	push   $0x2
     349:	e8 46 0d 00 00       	call   1094 <printf>
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
     35f:	68 c0 78 00 00       	push   $0x78c0
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
     382:	68 c0 78 00 00       	push   $0x78c0
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
     3a8:	68 25 32 00 00       	push   $0x3225
     3ad:	6a 02                	push   $0x2
     3af:	e8 e0 0c 00 00       	call   1094 <printf>
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
     3d3:	68 29 32 00 00       	push   $0x3229
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
     3f0:	e8 72 0f 00 00       	call   1367 <malloc>
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
     426:	e8 3c 0f 00 00       	call   1367 <malloc>
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
     489:	e8 d9 0e 00 00       	call   1367 <malloc>
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
     4d1:	e8 91 0e 00 00       	call   1367 <malloc>
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
     519:	e8 49 0e 00 00       	call   1367 <malloc>
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
     576:	68 40 3c 00 00       	push   $0x3c40
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
     61f:	68 40 3c 00 00       	push   $0x3c40
     624:	e8 2b 07 00 00       	call   d54 <strchr>
     629:	83 c4 10             	add    $0x10,%esp
     62c:	85 c0                	test   %eax,%eax
     62e:	75 26                	jne    656 <gettoken+0x109>
     630:	8b 45 f4             	mov    -0xc(%ebp),%eax
     633:	0f b6 00             	movzbl (%eax),%eax
     636:	0f be c0             	movsbl %al,%eax
     639:	83 ec 08             	sub    $0x8,%esp
     63c:	50                   	push   %eax
     63d:	68 48 3c 00 00       	push   $0x3c48
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
     680:	68 40 3c 00 00       	push   $0x3c40
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
     6c7:	68 40 3c 00 00       	push   $0x3c40
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
     74a:	68 2e 32 00 00       	push   $0x322e
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
     76d:	68 2f 32 00 00       	push   $0x322f
     772:	6a 02                	push   $0x2
     774:	e8 1b 09 00 00       	call   1094 <printf>
     779:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     77c:	83 ec 0c             	sub    $0xc,%esp
     77f:	68 3e 32 00 00       	push   $0x323e
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
     7e4:	68 45 32 00 00       	push   $0x3245
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
     7fe:	68 47 32 00 00       	push   $0x3247
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
     86c:	68 49 32 00 00       	push   $0x3249
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
     8fb:	68 4b 32 00 00       	push   $0x324b
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
     981:	68 68 32 00 00       	push   $0x3268
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
     9aa:	68 6b 32 00 00       	push   $0x326b
     9af:	ff 75 0c             	pushl  0xc(%ebp)
     9b2:	ff 75 08             	pushl  0x8(%ebp)
     9b5:	e8 e4 fc ff ff       	call   69e <peek>
     9ba:	83 c4 10             	add    $0x10,%esp
     9bd:	85 c0                	test   %eax,%eax
     9bf:	75 10                	jne    9d1 <parseblock+0x30>
    panic("parseblock");
     9c1:	83 ec 0c             	sub    $0xc,%esp
     9c4:	68 6d 32 00 00       	push   $0x326d
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
     9fa:	68 78 32 00 00       	push   $0x3278
     9ff:	ff 75 0c             	pushl  0xc(%ebp)
     a02:	ff 75 08             	pushl  0x8(%ebp)
     a05:	e8 94 fc ff ff       	call   69e <peek>
     a0a:	83 c4 10             	add    $0x10,%esp
     a0d:	85 c0                	test   %eax,%eax
     a0f:	75 10                	jne    a21 <parseblock+0x80>
    panic("syntax - missing )");
     a11:	83 ec 0c             	sub    $0xc,%esp
     a14:	68 7a 32 00 00       	push   $0x327a
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
     a58:	68 6b 32 00 00       	push   $0x326b
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
     ae2:	68 3e 32 00 00       	push   $0x323e
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
     b19:	68 8d 32 00 00       	push   $0x328d
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
     b40:	68 9b 32 00 00       	push   $0x329b
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
     ba6:	8b 04 85 a0 32 00 00 	mov    0x32a0(,%eax,4),%eax
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

00000fad <getCurrentTime>:
SYSCALL(getCurrentTime)
     fad:	b8 1d 00 00 00       	mov    $0x1d,%eax
     fb2:	cd 40                	int    $0x40
     fb4:	c3                   	ret    

00000fb5 <removeWindow>:
SYSCALL(removeWindow)
     fb5:	b8 1e 00 00 00       	mov    $0x1e,%eax
     fba:	cd 40                	int    $0x40
     fbc:	c3                   	ret    

00000fbd <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     fbd:	55                   	push   %ebp
     fbe:	89 e5                	mov    %esp,%ebp
     fc0:	83 ec 18             	sub    $0x18,%esp
     fc3:	8b 45 0c             	mov    0xc(%ebp),%eax
     fc6:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     fc9:	83 ec 04             	sub    $0x4,%esp
     fcc:	6a 01                	push   $0x1
     fce:	8d 45 f4             	lea    -0xc(%ebp),%eax
     fd1:	50                   	push   %eax
     fd2:	ff 75 08             	pushl  0x8(%ebp)
     fd5:	e8 1b ff ff ff       	call   ef5 <write>
     fda:	83 c4 10             	add    $0x10,%esp
}
     fdd:	90                   	nop
     fde:	c9                   	leave  
     fdf:	c3                   	ret    

00000fe0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	53                   	push   %ebx
     fe4:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     fe7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     fee:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     ff2:	74 17                	je     100b <printint+0x2b>
     ff4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ff8:	79 11                	jns    100b <printint+0x2b>
    neg = 1;
     ffa:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1001:	8b 45 0c             	mov    0xc(%ebp),%eax
    1004:	f7 d8                	neg    %eax
    1006:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1009:	eb 06                	jmp    1011 <printint+0x31>
  } else {
    x = xx;
    100b:	8b 45 0c             	mov    0xc(%ebp),%eax
    100e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1011:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1018:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    101b:	8d 41 01             	lea    0x1(%ecx),%eax
    101e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1021:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1024:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1027:	ba 00 00 00 00       	mov    $0x0,%edx
    102c:	f7 f3                	div    %ebx
    102e:	89 d0                	mov    %edx,%eax
    1030:	0f b6 80 50 3c 00 00 	movzbl 0x3c50(%eax),%eax
    1037:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    103b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    103e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1041:	ba 00 00 00 00       	mov    $0x0,%edx
    1046:	f7 f3                	div    %ebx
    1048:	89 45 ec             	mov    %eax,-0x14(%ebp)
    104b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    104f:	75 c7                	jne    1018 <printint+0x38>
  if(neg)
    1051:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1055:	74 2d                	je     1084 <printint+0xa4>
    buf[i++] = '-';
    1057:	8b 45 f4             	mov    -0xc(%ebp),%eax
    105a:	8d 50 01             	lea    0x1(%eax),%edx
    105d:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1060:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1065:	eb 1d                	jmp    1084 <printint+0xa4>
    putc(fd, buf[i]);
    1067:	8d 55 dc             	lea    -0x24(%ebp),%edx
    106a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    106d:	01 d0                	add    %edx,%eax
    106f:	0f b6 00             	movzbl (%eax),%eax
    1072:	0f be c0             	movsbl %al,%eax
    1075:	83 ec 08             	sub    $0x8,%esp
    1078:	50                   	push   %eax
    1079:	ff 75 08             	pushl  0x8(%ebp)
    107c:	e8 3c ff ff ff       	call   fbd <putc>
    1081:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1084:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1088:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    108c:	79 d9                	jns    1067 <printint+0x87>
    putc(fd, buf[i]);
}
    108e:	90                   	nop
    108f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1092:	c9                   	leave  
    1093:	c3                   	ret    

00001094 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1094:	55                   	push   %ebp
    1095:	89 e5                	mov    %esp,%ebp
    1097:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    109a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    10a1:	8d 45 0c             	lea    0xc(%ebp),%eax
    10a4:	83 c0 04             	add    $0x4,%eax
    10a7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    10aa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    10b1:	e9 59 01 00 00       	jmp    120f <printf+0x17b>
    c = fmt[i] & 0xff;
    10b6:	8b 55 0c             	mov    0xc(%ebp),%edx
    10b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10bc:	01 d0                	add    %edx,%eax
    10be:	0f b6 00             	movzbl (%eax),%eax
    10c1:	0f be c0             	movsbl %al,%eax
    10c4:	25 ff 00 00 00       	and    $0xff,%eax
    10c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    10cc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10d0:	75 2c                	jne    10fe <printf+0x6a>
      if(c == '%'){
    10d2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    10d6:	75 0c                	jne    10e4 <printf+0x50>
        state = '%';
    10d8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    10df:	e9 27 01 00 00       	jmp    120b <printf+0x177>
      } else {
        putc(fd, c);
    10e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10e7:	0f be c0             	movsbl %al,%eax
    10ea:	83 ec 08             	sub    $0x8,%esp
    10ed:	50                   	push   %eax
    10ee:	ff 75 08             	pushl  0x8(%ebp)
    10f1:	e8 c7 fe ff ff       	call   fbd <putc>
    10f6:	83 c4 10             	add    $0x10,%esp
    10f9:	e9 0d 01 00 00       	jmp    120b <printf+0x177>
      }
    } else if(state == '%'){
    10fe:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1102:	0f 85 03 01 00 00    	jne    120b <printf+0x177>
      if(c == 'd'){
    1108:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    110c:	75 1e                	jne    112c <printf+0x98>
        printint(fd, *ap, 10, 1);
    110e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1111:	8b 00                	mov    (%eax),%eax
    1113:	6a 01                	push   $0x1
    1115:	6a 0a                	push   $0xa
    1117:	50                   	push   %eax
    1118:	ff 75 08             	pushl  0x8(%ebp)
    111b:	e8 c0 fe ff ff       	call   fe0 <printint>
    1120:	83 c4 10             	add    $0x10,%esp
        ap++;
    1123:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1127:	e9 d8 00 00 00       	jmp    1204 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    112c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1130:	74 06                	je     1138 <printf+0xa4>
    1132:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1136:	75 1e                	jne    1156 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    1138:	8b 45 e8             	mov    -0x18(%ebp),%eax
    113b:	8b 00                	mov    (%eax),%eax
    113d:	6a 00                	push   $0x0
    113f:	6a 10                	push   $0x10
    1141:	50                   	push   %eax
    1142:	ff 75 08             	pushl  0x8(%ebp)
    1145:	e8 96 fe ff ff       	call   fe0 <printint>
    114a:	83 c4 10             	add    $0x10,%esp
        ap++;
    114d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1151:	e9 ae 00 00 00       	jmp    1204 <printf+0x170>
      } else if(c == 's'){
    1156:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    115a:	75 43                	jne    119f <printf+0x10b>
        s = (char*)*ap;
    115c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    115f:	8b 00                	mov    (%eax),%eax
    1161:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1164:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1168:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    116c:	75 25                	jne    1193 <printf+0xff>
          s = "(null)";
    116e:	c7 45 f4 b8 32 00 00 	movl   $0x32b8,-0xc(%ebp)
        while(*s != 0){
    1175:	eb 1c                	jmp    1193 <printf+0xff>
          putc(fd, *s);
    1177:	8b 45 f4             	mov    -0xc(%ebp),%eax
    117a:	0f b6 00             	movzbl (%eax),%eax
    117d:	0f be c0             	movsbl %al,%eax
    1180:	83 ec 08             	sub    $0x8,%esp
    1183:	50                   	push   %eax
    1184:	ff 75 08             	pushl  0x8(%ebp)
    1187:	e8 31 fe ff ff       	call   fbd <putc>
    118c:	83 c4 10             	add    $0x10,%esp
          s++;
    118f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1193:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1196:	0f b6 00             	movzbl (%eax),%eax
    1199:	84 c0                	test   %al,%al
    119b:	75 da                	jne    1177 <printf+0xe3>
    119d:	eb 65                	jmp    1204 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    119f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    11a3:	75 1d                	jne    11c2 <printf+0x12e>
        putc(fd, *ap);
    11a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11a8:	8b 00                	mov    (%eax),%eax
    11aa:	0f be c0             	movsbl %al,%eax
    11ad:	83 ec 08             	sub    $0x8,%esp
    11b0:	50                   	push   %eax
    11b1:	ff 75 08             	pushl  0x8(%ebp)
    11b4:	e8 04 fe ff ff       	call   fbd <putc>
    11b9:	83 c4 10             	add    $0x10,%esp
        ap++;
    11bc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    11c0:	eb 42                	jmp    1204 <printf+0x170>
      } else if(c == '%'){
    11c2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    11c6:	75 17                	jne    11df <printf+0x14b>
        putc(fd, c);
    11c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11cb:	0f be c0             	movsbl %al,%eax
    11ce:	83 ec 08             	sub    $0x8,%esp
    11d1:	50                   	push   %eax
    11d2:	ff 75 08             	pushl  0x8(%ebp)
    11d5:	e8 e3 fd ff ff       	call   fbd <putc>
    11da:	83 c4 10             	add    $0x10,%esp
    11dd:	eb 25                	jmp    1204 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    11df:	83 ec 08             	sub    $0x8,%esp
    11e2:	6a 25                	push   $0x25
    11e4:	ff 75 08             	pushl  0x8(%ebp)
    11e7:	e8 d1 fd ff ff       	call   fbd <putc>
    11ec:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    11ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11f2:	0f be c0             	movsbl %al,%eax
    11f5:	83 ec 08             	sub    $0x8,%esp
    11f8:	50                   	push   %eax
    11f9:	ff 75 08             	pushl  0x8(%ebp)
    11fc:	e8 bc fd ff ff       	call   fbd <putc>
    1201:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1204:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    120b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    120f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1212:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1215:	01 d0                	add    %edx,%eax
    1217:	0f b6 00             	movzbl (%eax),%eax
    121a:	84 c0                	test   %al,%al
    121c:	0f 85 94 fe ff ff    	jne    10b6 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1222:	90                   	nop
    1223:	c9                   	leave  
    1224:	c3                   	ret    

00001225 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1225:	55                   	push   %ebp
    1226:	89 e5                	mov    %esp,%ebp
    1228:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    122b:	8b 45 08             	mov    0x8(%ebp),%eax
    122e:	83 e8 08             	sub    $0x8,%eax
    1231:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1234:	a1 2c 79 00 00       	mov    0x792c,%eax
    1239:	89 45 fc             	mov    %eax,-0x4(%ebp)
    123c:	eb 24                	jmp    1262 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    123e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1241:	8b 00                	mov    (%eax),%eax
    1243:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1246:	77 12                	ja     125a <free+0x35>
    1248:	8b 45 f8             	mov    -0x8(%ebp),%eax
    124b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    124e:	77 24                	ja     1274 <free+0x4f>
    1250:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1253:	8b 00                	mov    (%eax),%eax
    1255:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1258:	77 1a                	ja     1274 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    125a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    125d:	8b 00                	mov    (%eax),%eax
    125f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1262:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1265:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1268:	76 d4                	jbe    123e <free+0x19>
    126a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    126d:	8b 00                	mov    (%eax),%eax
    126f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1272:	76 ca                	jbe    123e <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1274:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1277:	8b 40 04             	mov    0x4(%eax),%eax
    127a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1281:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1284:	01 c2                	add    %eax,%edx
    1286:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1289:	8b 00                	mov    (%eax),%eax
    128b:	39 c2                	cmp    %eax,%edx
    128d:	75 24                	jne    12b3 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    128f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1292:	8b 50 04             	mov    0x4(%eax),%edx
    1295:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1298:	8b 00                	mov    (%eax),%eax
    129a:	8b 40 04             	mov    0x4(%eax),%eax
    129d:	01 c2                	add    %eax,%edx
    129f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12a2:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    12a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12a8:	8b 00                	mov    (%eax),%eax
    12aa:	8b 10                	mov    (%eax),%edx
    12ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12af:	89 10                	mov    %edx,(%eax)
    12b1:	eb 0a                	jmp    12bd <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    12b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12b6:	8b 10                	mov    (%eax),%edx
    12b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12bb:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    12bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12c0:	8b 40 04             	mov    0x4(%eax),%eax
    12c3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    12ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12cd:	01 d0                	add    %edx,%eax
    12cf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12d2:	75 20                	jne    12f4 <free+0xcf>
    p->s.size += bp->s.size;
    12d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12d7:	8b 50 04             	mov    0x4(%eax),%edx
    12da:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12dd:	8b 40 04             	mov    0x4(%eax),%eax
    12e0:	01 c2                	add    %eax,%edx
    12e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12e5:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    12e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12eb:	8b 10                	mov    (%eax),%edx
    12ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12f0:	89 10                	mov    %edx,(%eax)
    12f2:	eb 08                	jmp    12fc <free+0xd7>
  } else
    p->s.ptr = bp;
    12f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12f7:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12fa:	89 10                	mov    %edx,(%eax)
  freep = p;
    12fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ff:	a3 2c 79 00 00       	mov    %eax,0x792c
}
    1304:	90                   	nop
    1305:	c9                   	leave  
    1306:	c3                   	ret    

00001307 <morecore>:

static Header*
morecore(uint nu)
{
    1307:	55                   	push   %ebp
    1308:	89 e5                	mov    %esp,%ebp
    130a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    130d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1314:	77 07                	ja     131d <morecore+0x16>
    nu = 4096;
    1316:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    131d:	8b 45 08             	mov    0x8(%ebp),%eax
    1320:	c1 e0 03             	shl    $0x3,%eax
    1323:	83 ec 0c             	sub    $0xc,%esp
    1326:	50                   	push   %eax
    1327:	e8 31 fc ff ff       	call   f5d <sbrk>
    132c:	83 c4 10             	add    $0x10,%esp
    132f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1332:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1336:	75 07                	jne    133f <morecore+0x38>
    return 0;
    1338:	b8 00 00 00 00       	mov    $0x0,%eax
    133d:	eb 26                	jmp    1365 <morecore+0x5e>
  hp = (Header*)p;
    133f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1342:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1345:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1348:	8b 55 08             	mov    0x8(%ebp),%edx
    134b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    134e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1351:	83 c0 08             	add    $0x8,%eax
    1354:	83 ec 0c             	sub    $0xc,%esp
    1357:	50                   	push   %eax
    1358:	e8 c8 fe ff ff       	call   1225 <free>
    135d:	83 c4 10             	add    $0x10,%esp
  return freep;
    1360:	a1 2c 79 00 00       	mov    0x792c,%eax
}
    1365:	c9                   	leave  
    1366:	c3                   	ret    

00001367 <malloc>:

void*
malloc(uint nbytes)
{
    1367:	55                   	push   %ebp
    1368:	89 e5                	mov    %esp,%ebp
    136a:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    136d:	8b 45 08             	mov    0x8(%ebp),%eax
    1370:	83 c0 07             	add    $0x7,%eax
    1373:	c1 e8 03             	shr    $0x3,%eax
    1376:	83 c0 01             	add    $0x1,%eax
    1379:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    137c:	a1 2c 79 00 00       	mov    0x792c,%eax
    1381:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1384:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1388:	75 23                	jne    13ad <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    138a:	c7 45 f0 24 79 00 00 	movl   $0x7924,-0x10(%ebp)
    1391:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1394:	a3 2c 79 00 00       	mov    %eax,0x792c
    1399:	a1 2c 79 00 00       	mov    0x792c,%eax
    139e:	a3 24 79 00 00       	mov    %eax,0x7924
    base.s.size = 0;
    13a3:	c7 05 28 79 00 00 00 	movl   $0x0,0x7928
    13aa:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13b0:	8b 00                	mov    (%eax),%eax
    13b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    13b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13b8:	8b 40 04             	mov    0x4(%eax),%eax
    13bb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13be:	72 4d                	jb     140d <malloc+0xa6>
      if(p->s.size == nunits)
    13c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13c3:	8b 40 04             	mov    0x4(%eax),%eax
    13c6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13c9:	75 0c                	jne    13d7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    13cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13ce:	8b 10                	mov    (%eax),%edx
    13d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13d3:	89 10                	mov    %edx,(%eax)
    13d5:	eb 26                	jmp    13fd <malloc+0x96>
      else {
        p->s.size -= nunits;
    13d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13da:	8b 40 04             	mov    0x4(%eax),%eax
    13dd:	2b 45 ec             	sub    -0x14(%ebp),%eax
    13e0:	89 c2                	mov    %eax,%edx
    13e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13e5:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    13e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13eb:	8b 40 04             	mov    0x4(%eax),%eax
    13ee:	c1 e0 03             	shl    $0x3,%eax
    13f1:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    13f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f7:	8b 55 ec             	mov    -0x14(%ebp),%edx
    13fa:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    13fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1400:	a3 2c 79 00 00       	mov    %eax,0x792c
      return (void*)(p + 1);
    1405:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1408:	83 c0 08             	add    $0x8,%eax
    140b:	eb 3b                	jmp    1448 <malloc+0xe1>
    }
    if(p == freep)
    140d:	a1 2c 79 00 00       	mov    0x792c,%eax
    1412:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1415:	75 1e                	jne    1435 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    1417:	83 ec 0c             	sub    $0xc,%esp
    141a:	ff 75 ec             	pushl  -0x14(%ebp)
    141d:	e8 e5 fe ff ff       	call   1307 <morecore>
    1422:	83 c4 10             	add    $0x10,%esp
    1425:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1428:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    142c:	75 07                	jne    1435 <malloc+0xce>
        return 0;
    142e:	b8 00 00 00 00       	mov    $0x0,%eax
    1433:	eb 13                	jmp    1448 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1435:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1438:	89 45 f0             	mov    %eax,-0x10(%ebp)
    143b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    143e:	8b 00                	mov    (%eax),%eax
    1440:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1443:	e9 6d ff ff ff       	jmp    13b5 <malloc+0x4e>
}
    1448:	c9                   	leave  
    1449:	c3                   	ret    

0000144a <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    144a:	55                   	push   %ebp
    144b:	89 e5                	mov    %esp,%ebp
    144d:	83 ec 1c             	sub    $0x1c,%esp
    1450:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1453:	8b 55 10             	mov    0x10(%ebp),%edx
    1456:	8b 45 14             	mov    0x14(%ebp),%eax
    1459:	88 4d ec             	mov    %cl,-0x14(%ebp)
    145c:	88 55 e8             	mov    %dl,-0x18(%ebp)
    145f:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1462:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1466:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1469:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    146d:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1470:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1474:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1477:	8b 45 08             	mov    0x8(%ebp),%eax
    147a:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    147e:	66 89 10             	mov    %dx,(%eax)
    1481:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1485:	88 50 02             	mov    %dl,0x2(%eax)
}
    1488:	8b 45 08             	mov    0x8(%ebp),%eax
    148b:	c9                   	leave  
    148c:	c2 04 00             	ret    $0x4

0000148f <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
    148f:	55                   	push   %ebp
    1490:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
    1492:	8b 45 08             	mov    0x8(%ebp),%eax
    1495:	2b 45 10             	sub    0x10(%ebp),%eax
    1498:	89 c2                	mov    %eax,%edx
    149a:	8b 45 08             	mov    0x8(%ebp),%eax
    149d:	2b 45 10             	sub    0x10(%ebp),%eax
    14a0:	0f af d0             	imul   %eax,%edx
    14a3:	8b 45 0c             	mov    0xc(%ebp),%eax
    14a6:	2b 45 14             	sub    0x14(%ebp),%eax
    14a9:	89 c1                	mov    %eax,%ecx
    14ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    14ae:	2b 45 14             	sub    0x14(%ebp),%eax
    14b1:	0f af c1             	imul   %ecx,%eax
    14b4:	01 d0                	add    %edx,%eax
}
    14b6:	5d                   	pop    %ebp
    14b7:	c3                   	ret    

000014b8 <abs_int>:

static inline int abs_int(int x)
{
    14b8:	55                   	push   %ebp
    14b9:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
    14bb:	8b 45 08             	mov    0x8(%ebp),%eax
    14be:	99                   	cltd   
    14bf:	89 d0                	mov    %edx,%eax
    14c1:	33 45 08             	xor    0x8(%ebp),%eax
    14c4:	29 d0                	sub    %edx,%eax
}
    14c6:	5d                   	pop    %ebp
    14c7:	c3                   	ret    

000014c8 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
    14c8:	55                   	push   %ebp
    14c9:	89 e5                	mov    %esp,%ebp
    if (x < 0)
    14cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14cf:	79 07                	jns    14d8 <APGetIndex+0x10>
        return X_SMALLER;
    14d1:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    14d6:	eb 40                	jmp    1518 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
    14d8:	8b 45 08             	mov    0x8(%ebp),%eax
    14db:	8b 00                	mov    (%eax),%eax
    14dd:	3b 45 0c             	cmp    0xc(%ebp),%eax
    14e0:	7f 07                	jg     14e9 <APGetIndex+0x21>
        return X_BIGGER;
    14e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14e7:	eb 2f                	jmp    1518 <APGetIndex+0x50>
    if (y < 0)
    14e9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    14ed:	79 07                	jns    14f6 <APGetIndex+0x2e>
        return Y_SMALLER;
    14ef:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
    14f4:	eb 22                	jmp    1518 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
    14f6:	8b 45 08             	mov    0x8(%ebp),%eax
    14f9:	8b 40 04             	mov    0x4(%eax),%eax
    14fc:	3b 45 10             	cmp    0x10(%ebp),%eax
    14ff:	7f 07                	jg     1508 <APGetIndex+0x40>
        return Y_BIGGER;
    1501:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    1506:	eb 10                	jmp    1518 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
    1508:	8b 45 08             	mov    0x8(%ebp),%eax
    150b:	8b 00                	mov    (%eax),%eax
    150d:	0f af 45 10          	imul   0x10(%ebp),%eax
    1511:	89 c2                	mov    %eax,%edx
    1513:	8b 45 0c             	mov    0xc(%ebp),%eax
    1516:	01 d0                	add    %edx,%eax
}
    1518:	5d                   	pop    %ebp
    1519:	c3                   	ret    

0000151a <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
    151a:	55                   	push   %ebp
    151b:	89 e5                	mov    %esp,%ebp
    151d:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    1520:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    1527:	8b 45 cc             	mov    -0x34(%ebp),%eax
    152a:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
    152d:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
    1534:	83 ec 08             	sub    $0x8,%esp
    1537:	6a 00                	push   $0x0
    1539:	ff 75 0c             	pushl  0xc(%ebp)
    153c:	e8 d4 f9 ff ff       	call   f15 <open>
    1541:	83 c4 10             	add    $0x10,%esp
    1544:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
    1547:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    154b:	79 2e                	jns    157b <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
    154d:	83 ec 04             	sub    $0x4,%esp
    1550:	ff 75 0c             	pushl  0xc(%ebp)
    1553:	68 bf 32 00 00       	push   $0x32bf
    1558:	6a 01                	push   $0x1
    155a:	e8 35 fb ff ff       	call   1094 <printf>
    155f:	83 c4 10             	add    $0x10,%esp
        return bmp;
    1562:	8b 45 08             	mov    0x8(%ebp),%eax
    1565:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1568:	89 10                	mov    %edx,(%eax)
    156a:	8b 55 cc             	mov    -0x34(%ebp),%edx
    156d:	89 50 04             	mov    %edx,0x4(%eax)
    1570:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1573:	89 50 08             	mov    %edx,0x8(%eax)
    1576:	e9 d2 01 00 00       	jmp    174d <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    157b:	83 ec 04             	sub    $0x4,%esp
    157e:	6a 0e                	push   $0xe
    1580:	8d 45 ba             	lea    -0x46(%ebp),%eax
    1583:	50                   	push   %eax
    1584:	ff 75 ec             	pushl  -0x14(%ebp)
    1587:	e8 61 f9 ff ff       	call   eed <read>
    158c:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    158f:	83 ec 04             	sub    $0x4,%esp
    1592:	6a 28                	push   $0x28
    1594:	8d 45 92             	lea    -0x6e(%ebp),%eax
    1597:	50                   	push   %eax
    1598:	ff 75 ec             	pushl  -0x14(%ebp)
    159b:	e8 4d f9 ff ff       	call   eed <read>
    15a0:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
    15a3:	8b 45 96             	mov    -0x6a(%ebp),%eax
    15a6:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
    15a9:	8b 45 9a             	mov    -0x66(%ebp),%eax
    15ac:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    15af:	8b 55 c8             	mov    -0x38(%ebp),%edx
    15b2:	8b 45 cc             	mov    -0x34(%ebp),%eax
    15b5:	0f af d0             	imul   %eax,%edx
    15b8:	89 d0                	mov    %edx,%eax
    15ba:	01 c0                	add    %eax,%eax
    15bc:	01 d0                	add    %edx,%eax
    15be:	83 ec 0c             	sub    $0xc,%esp
    15c1:	50                   	push   %eax
    15c2:	e8 a0 fd ff ff       	call   1367 <malloc>
    15c7:	83 c4 10             	add    $0x10,%esp
    15ca:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
    15cd:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    15d1:	0f b7 c0             	movzwl %ax,%eax
    15d4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    15d7:	8b 55 c8             	mov    -0x38(%ebp),%edx
    15da:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15dd:	0f af c2             	imul   %edx,%eax
    15e0:	83 c0 1f             	add    $0x1f,%eax
    15e3:	c1 e8 05             	shr    $0x5,%eax
    15e6:	c1 e0 02             	shl    $0x2,%eax
    15e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
    15ec:	8b 55 cc             	mov    -0x34(%ebp),%edx
    15ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15f2:	0f af c2             	imul   %edx,%eax
    15f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    15f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    15fb:	83 ec 0c             	sub    $0xc,%esp
    15fe:	50                   	push   %eax
    15ff:	e8 63 fd ff ff       	call   1367 <malloc>
    1604:	83 c4 10             	add    $0x10,%esp
    1607:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    160a:	83 ec 04             	sub    $0x4,%esp
    160d:	ff 75 e0             	pushl  -0x20(%ebp)
    1610:	ff 75 dc             	pushl  -0x24(%ebp)
    1613:	ff 75 ec             	pushl  -0x14(%ebp)
    1616:	e8 d2 f8 ff ff       	call   eed <read>
    161b:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
    161e:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    1622:	66 c1 e8 03          	shr    $0x3,%ax
    1626:	0f b7 c0             	movzwl %ax,%eax
    1629:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
    162c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1633:	e9 e5 00 00 00       	jmp    171d <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
    1638:	8b 55 cc             	mov    -0x34(%ebp),%edx
    163b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163e:	29 c2                	sub    %eax,%edx
    1640:	89 d0                	mov    %edx,%eax
    1642:	8d 50 ff             	lea    -0x1(%eax),%edx
    1645:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1648:	0f af c2             	imul   %edx,%eax
    164b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
    164e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1655:	e9 b1 00 00 00       	jmp    170b <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
    165a:	8b 55 d0             	mov    -0x30(%ebp),%edx
    165d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1660:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1663:	01 c8                	add    %ecx,%eax
    1665:	89 c1                	mov    %eax,%ecx
    1667:	89 c8                	mov    %ecx,%eax
    1669:	01 c0                	add    %eax,%eax
    166b:	01 c8                	add    %ecx,%eax
    166d:	01 c2                	add    %eax,%edx
    166f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1672:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1676:	89 c1                	mov    %eax,%ecx
    1678:	8b 45 d8             	mov    -0x28(%ebp),%eax
    167b:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    167f:	01 c1                	add    %eax,%ecx
    1681:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1684:	01 c8                	add    %ecx,%eax
    1686:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1689:	8b 45 dc             	mov    -0x24(%ebp),%eax
    168c:	01 c8                	add    %ecx,%eax
    168e:	0f b6 00             	movzbl (%eax),%eax
    1691:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
    1694:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1697:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    169a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    169d:	01 c8                	add    %ecx,%eax
    169f:	89 c1                	mov    %eax,%ecx
    16a1:	89 c8                	mov    %ecx,%eax
    16a3:	01 c0                	add    %eax,%eax
    16a5:	01 c8                	add    %ecx,%eax
    16a7:	01 c2                	add    %eax,%edx
    16a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ac:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    16b0:	89 c1                	mov    %eax,%ecx
    16b2:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16b5:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    16b9:	01 c1                	add    %eax,%ecx
    16bb:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16be:	01 c8                	add    %ecx,%eax
    16c0:	8d 48 fe             	lea    -0x2(%eax),%ecx
    16c3:	8b 45 dc             	mov    -0x24(%ebp),%eax
    16c6:	01 c8                	add    %ecx,%eax
    16c8:	0f b6 00             	movzbl (%eax),%eax
    16cb:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
    16ce:	8b 55 d0             	mov    -0x30(%ebp),%edx
    16d1:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    16d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16d7:	01 c8                	add    %ecx,%eax
    16d9:	89 c1                	mov    %eax,%ecx
    16db:	89 c8                	mov    %ecx,%eax
    16dd:	01 c0                	add    %eax,%eax
    16df:	01 c8                	add    %ecx,%eax
    16e1:	01 c2                	add    %eax,%edx
    16e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e6:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    16ea:	89 c1                	mov    %eax,%ecx
    16ec:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16ef:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    16f3:	01 c1                	add    %eax,%ecx
    16f5:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16f8:	01 c8                	add    %ecx,%eax
    16fa:	8d 48 fd             	lea    -0x3(%eax),%ecx
    16fd:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1700:	01 c8                	add    %ecx,%eax
    1702:	0f b6 00             	movzbl (%eax),%eax
    1705:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    1707:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    170b:	8b 55 c8             	mov    -0x38(%ebp),%edx
    170e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1711:	39 c2                	cmp    %eax,%edx
    1713:	0f 87 41 ff ff ff    	ja     165a <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    1719:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    171d:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1720:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1723:	39 c2                	cmp    %eax,%edx
    1725:	0f 87 0d ff ff ff    	ja     1638 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    172b:	83 ec 0c             	sub    $0xc,%esp
    172e:	ff 75 ec             	pushl  -0x14(%ebp)
    1731:	e8 c7 f7 ff ff       	call   efd <close>
    1736:	83 c4 10             	add    $0x10,%esp
    return bmp;
    1739:	8b 45 08             	mov    0x8(%ebp),%eax
    173c:	8b 55 c8             	mov    -0x38(%ebp),%edx
    173f:	89 10                	mov    %edx,(%eax)
    1741:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1744:	89 50 04             	mov    %edx,0x4(%eax)
    1747:	8b 55 d0             	mov    -0x30(%ebp),%edx
    174a:	89 50 08             	mov    %edx,0x8(%eax)
}
    174d:	8b 45 08             	mov    0x8(%ebp),%eax
    1750:	c9                   	leave  
    1751:	c2 04 00             	ret    $0x4

00001754 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    1754:	55                   	push   %ebp
    1755:	89 e5                	mov    %esp,%ebp
    1757:	53                   	push   %ebx
    1758:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    175b:	83 ec 0c             	sub    $0xc,%esp
    175e:	6a 1c                	push   $0x1c
    1760:	e8 02 fc ff ff       	call   1367 <malloc>
    1765:	83 c4 10             	add    $0x10,%esp
    1768:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    176b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    176e:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    1775:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    1778:	8d 45 d8             	lea    -0x28(%ebp),%eax
    177b:	6a 0c                	push   $0xc
    177d:	6a 0c                	push   $0xc
    177f:	6a 0c                	push   $0xc
    1781:	50                   	push   %eax
    1782:	e8 c3 fc ff ff       	call   144a <RGB>
    1787:	83 c4 0c             	add    $0xc,%esp
    178a:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    178e:	66 89 43 13          	mov    %ax,0x13(%ebx)
    1792:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    1796:	88 43 15             	mov    %al,0x15(%ebx)
    1799:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    179f:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    17a3:	66 89 48 10          	mov    %cx,0x10(%eax)
    17a7:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    17ab:	88 50 12             	mov    %dl,0x12(%eax)
    17ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17b4:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    17b8:	66 89 48 08          	mov    %cx,0x8(%eax)
    17bc:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    17c0:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    17c3:	8b 45 08             	mov    0x8(%ebp),%eax
    17c6:	89 c2                	mov    %eax,%edx
    17c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17cb:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    17cd:	8b 45 0c             	mov    0xc(%ebp),%eax
    17d0:	89 c2                	mov    %eax,%edx
    17d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d5:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    17d8:	8b 55 10             	mov    0x10(%ebp),%edx
    17db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17de:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    17e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    17e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    17e7:	c9                   	leave  
    17e8:	c3                   	ret    

000017e9 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    17e9:	55                   	push   %ebp
    17ea:	89 e5                	mov    %esp,%ebp
    17ec:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    17ef:	8b 45 0c             	mov    0xc(%ebp),%eax
    17f2:	8b 50 08             	mov    0x8(%eax),%edx
    17f5:	89 55 f8             	mov    %edx,-0x8(%ebp)
    17f8:	8b 40 0c             	mov    0xc(%eax),%eax
    17fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    17fe:	8b 45 0c             	mov    0xc(%ebp),%eax
    1801:	8b 55 10             	mov    0x10(%ebp),%edx
    1804:	89 50 08             	mov    %edx,0x8(%eax)
    1807:	8b 55 14             	mov    0x14(%ebp),%edx
    180a:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    180d:	8b 45 08             	mov    0x8(%ebp),%eax
    1810:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1813:	89 10                	mov    %edx,(%eax)
    1815:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1818:	89 50 04             	mov    %edx,0x4(%eax)
}
    181b:	8b 45 08             	mov    0x8(%ebp),%eax
    181e:	c9                   	leave  
    181f:	c2 04 00             	ret    $0x4

00001822 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    1822:	55                   	push   %ebp
    1823:	89 e5                	mov    %esp,%ebp
    1825:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    1828:	8b 45 0c             	mov    0xc(%ebp),%eax
    182b:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    182f:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1833:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1837:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    183a:	8b 45 0c             	mov    0xc(%ebp),%eax
    183d:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1841:	66 89 50 10          	mov    %dx,0x10(%eax)
    1845:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1849:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    184c:	8b 45 08             	mov    0x8(%ebp),%eax
    184f:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1853:	66 89 10             	mov    %dx,(%eax)
    1856:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    185a:	88 50 02             	mov    %dl,0x2(%eax)
}
    185d:	8b 45 08             	mov    0x8(%ebp),%eax
    1860:	c9                   	leave  
    1861:	c2 04 00             	ret    $0x4

00001864 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
    1864:	55                   	push   %ebp
    1865:	89 e5                	mov    %esp,%ebp
    1867:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
    186a:	8b 45 0c             	mov    0xc(%ebp),%eax
    186d:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1871:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1875:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1879:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
    187c:	8b 45 0c             	mov    0xc(%ebp),%eax
    187f:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1883:	66 89 50 13          	mov    %dx,0x13(%eax)
    1887:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    188b:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
    188e:	8b 45 08             	mov    0x8(%ebp),%eax
    1891:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1895:	66 89 10             	mov    %dx,(%eax)
    1898:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    189c:	88 50 02             	mov    %dl,0x2(%eax)
}
    189f:	8b 45 08             	mov    0x8(%ebp),%eax
    18a2:	c9                   	leave  
    18a3:	c2 04 00             	ret    $0x4

000018a6 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    18a6:	55                   	push   %ebp
    18a7:	89 e5                	mov    %esp,%ebp
    18a9:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    18ac:	8b 45 08             	mov    0x8(%ebp),%eax
    18af:	8b 40 0c             	mov    0xc(%eax),%eax
    18b2:	89 c2                	mov    %eax,%edx
    18b4:	c1 ea 1f             	shr    $0x1f,%edx
    18b7:	01 d0                	add    %edx,%eax
    18b9:	d1 f8                	sar    %eax
    18bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    18be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c1:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    18c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    18c8:	8b 45 10             	mov    0x10(%ebp),%eax
    18cb:	2b 45 f4             	sub    -0xc(%ebp),%eax
    18ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    18d1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    18d5:	0f 89 98 00 00 00    	jns    1973 <APDrawPoint+0xcd>
        i = 0;
    18db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    18e2:	e9 8c 00 00 00       	jmp    1973 <APDrawPoint+0xcd>
    {
        j = x - off;
    18e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    18ea:	2b 45 f4             	sub    -0xc(%ebp),%eax
    18ed:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    18f0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    18f4:	79 69                	jns    195f <APDrawPoint+0xb9>
            j = 0;
    18f6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    18fd:	eb 60                	jmp    195f <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    18ff:	ff 75 fc             	pushl  -0x4(%ebp)
    1902:	ff 75 f8             	pushl  -0x8(%ebp)
    1905:	ff 75 08             	pushl  0x8(%ebp)
    1908:	e8 bb fb ff ff       	call   14c8 <APGetIndex>
    190d:	83 c4 0c             	add    $0xc,%esp
    1910:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    1913:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    1917:	74 55                	je     196e <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    1919:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    191d:	74 67                	je     1986 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    191f:	ff 75 10             	pushl  0x10(%ebp)
    1922:	ff 75 0c             	pushl  0xc(%ebp)
    1925:	ff 75 fc             	pushl  -0x4(%ebp)
    1928:	ff 75 f8             	pushl  -0x8(%ebp)
    192b:	e8 5f fb ff ff       	call   148f <distance_2>
    1930:	83 c4 10             	add    $0x10,%esp
    1933:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1936:	7f 23                	jg     195b <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    1938:	8b 45 08             	mov    0x8(%ebp),%eax
    193b:	8b 48 18             	mov    0x18(%eax),%ecx
    193e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1941:	89 d0                	mov    %edx,%eax
    1943:	01 c0                	add    %eax,%eax
    1945:	01 d0                	add    %edx,%eax
    1947:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    194a:	8b 45 08             	mov    0x8(%ebp),%eax
    194d:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    1951:	66 89 0a             	mov    %cx,(%edx)
    1954:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1958:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    195b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    195f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1962:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1965:	01 d0                	add    %edx,%eax
    1967:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    196a:	7d 93                	jge    18ff <APDrawPoint+0x59>
    196c:	eb 01                	jmp    196f <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    196e:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    196f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1973:	8b 55 10             	mov    0x10(%ebp),%edx
    1976:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1979:	01 d0                	add    %edx,%eax
    197b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    197e:	0f 8d 63 ff ff ff    	jge    18e7 <APDrawPoint+0x41>
    1984:	eb 01                	jmp    1987 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1986:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    1987:	c9                   	leave  
    1988:	c3                   	ret    

00001989 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1989:	55                   	push   %ebp
    198a:	89 e5                	mov    %esp,%ebp
    198c:	53                   	push   %ebx
    198d:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1990:	8b 45 0c             	mov    0xc(%ebp),%eax
    1993:	3b 45 14             	cmp    0x14(%ebp),%eax
    1996:	0f 85 80 00 00 00    	jne    1a1c <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    199c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    19a0:	0f 88 9d 02 00 00    	js     1c43 <APDrawLine+0x2ba>
    19a6:	8b 45 08             	mov    0x8(%ebp),%eax
    19a9:	8b 00                	mov    (%eax),%eax
    19ab:	3b 45 0c             	cmp    0xc(%ebp),%eax
    19ae:	0f 8e 8f 02 00 00    	jle    1c43 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    19b4:	8b 45 10             	mov    0x10(%ebp),%eax
    19b7:	3b 45 18             	cmp    0x18(%ebp),%eax
    19ba:	7e 12                	jle    19ce <APDrawLine+0x45>
        {
            int tmp = y2;
    19bc:	8b 45 18             	mov    0x18(%ebp),%eax
    19bf:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    19c2:	8b 45 10             	mov    0x10(%ebp),%eax
    19c5:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    19c8:	8b 45 dc             	mov    -0x24(%ebp),%eax
    19cb:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    19ce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    19d2:	79 07                	jns    19db <APDrawLine+0x52>
    19d4:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    19db:	8b 45 08             	mov    0x8(%ebp),%eax
    19de:	8b 40 04             	mov    0x4(%eax),%eax
    19e1:	3b 45 18             	cmp    0x18(%ebp),%eax
    19e4:	7d 0c                	jge    19f2 <APDrawLine+0x69>
    19e6:	8b 45 08             	mov    0x8(%ebp),%eax
    19e9:	8b 40 04             	mov    0x4(%eax),%eax
    19ec:	83 e8 01             	sub    $0x1,%eax
    19ef:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    19f2:	8b 45 10             	mov    0x10(%ebp),%eax
    19f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    19f8:	eb 15                	jmp    1a0f <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    19fa:	ff 75 f4             	pushl  -0xc(%ebp)
    19fd:	ff 75 0c             	pushl  0xc(%ebp)
    1a00:	ff 75 08             	pushl  0x8(%ebp)
    1a03:	e8 9e fe ff ff       	call   18a6 <APDrawPoint>
    1a08:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1a0b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1a0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a12:	3b 45 18             	cmp    0x18(%ebp),%eax
    1a15:	7e e3                	jle    19fa <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    1a17:	e9 2b 02 00 00       	jmp    1c47 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1a1c:	8b 45 10             	mov    0x10(%ebp),%eax
    1a1f:	3b 45 18             	cmp    0x18(%ebp),%eax
    1a22:	75 7f                	jne    1aa3 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    1a24:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1a28:	0f 88 18 02 00 00    	js     1c46 <APDrawLine+0x2bd>
    1a2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a31:	8b 40 04             	mov    0x4(%eax),%eax
    1a34:	3b 45 10             	cmp    0x10(%ebp),%eax
    1a37:	0f 8e 09 02 00 00    	jle    1c46 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1a3d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a40:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a43:	7e 12                	jle    1a57 <APDrawLine+0xce>
        {
            int tmp = x2;
    1a45:	8b 45 14             	mov    0x14(%ebp),%eax
    1a48:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1a4b:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a4e:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1a51:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a54:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    1a57:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1a5b:	79 07                	jns    1a64 <APDrawLine+0xdb>
    1a5d:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1a64:	8b 45 08             	mov    0x8(%ebp),%eax
    1a67:	8b 00                	mov    (%eax),%eax
    1a69:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a6c:	7d 0b                	jge    1a79 <APDrawLine+0xf0>
    1a6e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a71:	8b 00                	mov    (%eax),%eax
    1a73:	83 e8 01             	sub    $0x1,%eax
    1a76:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1a79:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a7f:	eb 15                	jmp    1a96 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1a81:	ff 75 10             	pushl  0x10(%ebp)
    1a84:	ff 75 f0             	pushl  -0x10(%ebp)
    1a87:	ff 75 08             	pushl  0x8(%ebp)
    1a8a:	e8 17 fe ff ff       	call   18a6 <APDrawPoint>
    1a8f:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1a92:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1a96:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a99:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a9c:	7e e3                	jle    1a81 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1a9e:	e9 a4 01 00 00       	jmp    1c47 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1aa3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1aaa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1ab1:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ab4:	2b 45 14             	sub    0x14(%ebp),%eax
    1ab7:	50                   	push   %eax
    1ab8:	e8 fb f9 ff ff       	call   14b8 <abs_int>
    1abd:	83 c4 04             	add    $0x4,%esp
    1ac0:	89 c3                	mov    %eax,%ebx
    1ac2:	8b 45 10             	mov    0x10(%ebp),%eax
    1ac5:	2b 45 18             	sub    0x18(%ebp),%eax
    1ac8:	50                   	push   %eax
    1ac9:	e8 ea f9 ff ff       	call   14b8 <abs_int>
    1ace:	83 c4 04             	add    $0x4,%esp
    1ad1:	39 c3                	cmp    %eax,%ebx
    1ad3:	0f 8e b5 00 00 00    	jle    1b8e <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1ad9:	8b 45 10             	mov    0x10(%ebp),%eax
    1adc:	2b 45 18             	sub    0x18(%ebp),%eax
    1adf:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1ae2:	db 45 b0             	fildl  -0x50(%ebp)
    1ae5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ae8:	2b 45 14             	sub    0x14(%ebp),%eax
    1aeb:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1aee:	db 45 b0             	fildl  -0x50(%ebp)
    1af1:	de f9                	fdivrp %st,%st(1)
    1af3:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1af6:	8b 45 14             	mov    0x14(%ebp),%eax
    1af9:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1afc:	7e 0e                	jle    1b0c <APDrawLine+0x183>
        {
            s = x1;
    1afe:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b01:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    1b04:	8b 45 14             	mov    0x14(%ebp),%eax
    1b07:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1b0a:	eb 0c                	jmp    1b18 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1b0c:	8b 45 14             	mov    0x14(%ebp),%eax
    1b0f:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1b12:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b15:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1b18:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b1c:	79 07                	jns    1b25 <APDrawLine+0x19c>
    1b1e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1b25:	8b 45 08             	mov    0x8(%ebp),%eax
    1b28:	8b 00                	mov    (%eax),%eax
    1b2a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1b2d:	7f 0b                	jg     1b3a <APDrawLine+0x1b1>
    1b2f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b32:	8b 00                	mov    (%eax),%eax
    1b34:	83 e8 01             	sub    $0x1,%eax
    1b37:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1b3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b3d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1b40:	eb 3f                	jmp    1b81 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1b42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b45:	2b 45 0c             	sub    0xc(%ebp),%eax
    1b48:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1b4b:	db 45 b0             	fildl  -0x50(%ebp)
    1b4e:	dc 4d d0             	fmull  -0x30(%ebp)
    1b51:	db 45 10             	fildl  0x10(%ebp)
    1b54:	de c1                	faddp  %st,%st(1)
    1b56:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1b59:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1b5d:	b4 0c                	mov    $0xc,%ah
    1b5f:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1b63:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1b66:	db 5d cc             	fistpl -0x34(%ebp)
    1b69:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1b6c:	ff 75 cc             	pushl  -0x34(%ebp)
    1b6f:	ff 75 e4             	pushl  -0x1c(%ebp)
    1b72:	ff 75 08             	pushl  0x8(%ebp)
    1b75:	e8 2c fd ff ff       	call   18a6 <APDrawPoint>
    1b7a:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1b7d:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1b81:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b84:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1b87:	7e b9                	jle    1b42 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1b89:	e9 b9 00 00 00       	jmp    1c47 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1b8e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b91:	2b 45 14             	sub    0x14(%ebp),%eax
    1b94:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1b97:	db 45 b0             	fildl  -0x50(%ebp)
    1b9a:	8b 45 10             	mov    0x10(%ebp),%eax
    1b9d:	2b 45 18             	sub    0x18(%ebp),%eax
    1ba0:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1ba3:	db 45 b0             	fildl  -0x50(%ebp)
    1ba6:	de f9                	fdivrp %st,%st(1)
    1ba8:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1bab:	8b 45 10             	mov    0x10(%ebp),%eax
    1bae:	3b 45 18             	cmp    0x18(%ebp),%eax
    1bb1:	7e 0e                	jle    1bc1 <APDrawLine+0x238>
    {
        s = y2;
    1bb3:	8b 45 18             	mov    0x18(%ebp),%eax
    1bb6:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1bb9:	8b 45 10             	mov    0x10(%ebp),%eax
    1bbc:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1bbf:	eb 0c                	jmp    1bcd <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1bc1:	8b 45 10             	mov    0x10(%ebp),%eax
    1bc4:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1bc7:	8b 45 18             	mov    0x18(%ebp),%eax
    1bca:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1bcd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1bd1:	79 07                	jns    1bda <APDrawLine+0x251>
    1bd3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1bda:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdd:	8b 40 04             	mov    0x4(%eax),%eax
    1be0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1be3:	7f 0c                	jg     1bf1 <APDrawLine+0x268>
    1be5:	8b 45 08             	mov    0x8(%ebp),%eax
    1be8:	8b 40 04             	mov    0x4(%eax),%eax
    1beb:	83 e8 01             	sub    $0x1,%eax
    1bee:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1bf1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1bf4:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1bf7:	eb 3f                	jmp    1c38 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1bf9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bfc:	2b 45 10             	sub    0x10(%ebp),%eax
    1bff:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1c02:	db 45 b0             	fildl  -0x50(%ebp)
    1c05:	dc 4d c0             	fmull  -0x40(%ebp)
    1c08:	db 45 0c             	fildl  0xc(%ebp)
    1c0b:	de c1                	faddp  %st,%st(1)
    1c0d:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1c10:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1c14:	b4 0c                	mov    $0xc,%ah
    1c16:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1c1a:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1c1d:	db 5d bc             	fistpl -0x44(%ebp)
    1c20:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1c23:	ff 75 e0             	pushl  -0x20(%ebp)
    1c26:	ff 75 bc             	pushl  -0x44(%ebp)
    1c29:	ff 75 08             	pushl  0x8(%ebp)
    1c2c:	e8 75 fc ff ff       	call   18a6 <APDrawPoint>
    1c31:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1c34:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1c38:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c3b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1c3e:	7e b9                	jle    1bf9 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1c40:	90                   	nop
    1c41:	eb 04                	jmp    1c47 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1c43:	90                   	nop
    1c44:	eb 01                	jmp    1c47 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1c46:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1c47:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1c4a:	c9                   	leave  
    1c4b:	c3                   	ret    

00001c4c <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1c4c:	55                   	push   %ebp
    1c4d:	89 e5                	mov    %esp,%ebp
    1c4f:	53                   	push   %ebx
    1c50:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1c53:	8b 55 10             	mov    0x10(%ebp),%edx
    1c56:	8b 45 18             	mov    0x18(%ebp),%eax
    1c59:	01 d0                	add    %edx,%eax
    1c5b:	83 e8 01             	sub    $0x1,%eax
    1c5e:	83 ec 04             	sub    $0x4,%esp
    1c61:	50                   	push   %eax
    1c62:	ff 75 0c             	pushl  0xc(%ebp)
    1c65:	ff 75 10             	pushl  0x10(%ebp)
    1c68:	ff 75 0c             	pushl  0xc(%ebp)
    1c6b:	ff 75 08             	pushl  0x8(%ebp)
    1c6e:	e8 16 fd ff ff       	call   1989 <APDrawLine>
    1c73:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1c76:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c79:	8b 45 14             	mov    0x14(%ebp),%eax
    1c7c:	01 d0                	add    %edx,%eax
    1c7e:	83 e8 01             	sub    $0x1,%eax
    1c81:	83 ec 04             	sub    $0x4,%esp
    1c84:	ff 75 10             	pushl  0x10(%ebp)
    1c87:	50                   	push   %eax
    1c88:	ff 75 10             	pushl  0x10(%ebp)
    1c8b:	ff 75 0c             	pushl  0xc(%ebp)
    1c8e:	ff 75 08             	pushl  0x8(%ebp)
    1c91:	e8 f3 fc ff ff       	call   1989 <APDrawLine>
    1c96:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1c99:	8b 55 10             	mov    0x10(%ebp),%edx
    1c9c:	8b 45 18             	mov    0x18(%ebp),%eax
    1c9f:	01 d0                	add    %edx,%eax
    1ca1:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1ca4:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ca7:	8b 45 14             	mov    0x14(%ebp),%eax
    1caa:	01 d0                	add    %edx,%eax
    1cac:	8d 50 ff             	lea    -0x1(%eax),%edx
    1caf:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1cb2:	8b 45 14             	mov    0x14(%ebp),%eax
    1cb5:	01 d8                	add    %ebx,%eax
    1cb7:	83 e8 01             	sub    $0x1,%eax
    1cba:	83 ec 04             	sub    $0x4,%esp
    1cbd:	51                   	push   %ecx
    1cbe:	52                   	push   %edx
    1cbf:	ff 75 10             	pushl  0x10(%ebp)
    1cc2:	50                   	push   %eax
    1cc3:	ff 75 08             	pushl  0x8(%ebp)
    1cc6:	e8 be fc ff ff       	call   1989 <APDrawLine>
    1ccb:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1cce:	8b 55 10             	mov    0x10(%ebp),%edx
    1cd1:	8b 45 18             	mov    0x18(%ebp),%eax
    1cd4:	01 d0                	add    %edx,%eax
    1cd6:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1cd9:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cdc:	8b 45 14             	mov    0x14(%ebp),%eax
    1cdf:	01 d0                	add    %edx,%eax
    1ce1:	8d 50 ff             	lea    -0x1(%eax),%edx
    1ce4:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1ce7:	8b 45 18             	mov    0x18(%ebp),%eax
    1cea:	01 d8                	add    %ebx,%eax
    1cec:	83 e8 01             	sub    $0x1,%eax
    1cef:	83 ec 04             	sub    $0x4,%esp
    1cf2:	51                   	push   %ecx
    1cf3:	52                   	push   %edx
    1cf4:	50                   	push   %eax
    1cf5:	ff 75 0c             	pushl  0xc(%ebp)
    1cf8:	ff 75 08             	pushl  0x8(%ebp)
    1cfb:	e8 89 fc ff ff       	call   1989 <APDrawLine>
    1d00:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1d03:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d06:	8b 45 14             	mov    0x14(%ebp),%eax
    1d09:	01 d0                	add    %edx,%eax
    1d0b:	8d 50 ff             	lea    -0x1(%eax),%edx
    1d0e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d11:	8b 40 0c             	mov    0xc(%eax),%eax
    1d14:	89 c1                	mov    %eax,%ecx
    1d16:	c1 e9 1f             	shr    $0x1f,%ecx
    1d19:	01 c8                	add    %ecx,%eax
    1d1b:	d1 f8                	sar    %eax
    1d1d:	29 c2                	sub    %eax,%edx
    1d1f:	89 d0                	mov    %edx,%eax
    1d21:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1d24:	8b 55 10             	mov    0x10(%ebp),%edx
    1d27:	8b 45 18             	mov    0x18(%ebp),%eax
    1d2a:	01 d0                	add    %edx,%eax
    1d2c:	8d 50 ff             	lea    -0x1(%eax),%edx
    1d2f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d32:	8b 40 0c             	mov    0xc(%eax),%eax
    1d35:	89 c1                	mov    %eax,%ecx
    1d37:	c1 e9 1f             	shr    $0x1f,%ecx
    1d3a:	01 c8                	add    %ecx,%eax
    1d3c:	d1 f8                	sar    %eax
    1d3e:	29 c2                	sub    %eax,%edx
    1d40:	89 d0                	mov    %edx,%eax
    1d42:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1d45:	8b 45 08             	mov    0x8(%ebp),%eax
    1d48:	8b 40 0c             	mov    0xc(%eax),%eax
    1d4b:	89 c2                	mov    %eax,%edx
    1d4d:	c1 ea 1f             	shr    $0x1f,%edx
    1d50:	01 d0                	add    %edx,%eax
    1d52:	d1 f8                	sar    %eax
    1d54:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1d57:	8b 45 08             	mov    0x8(%ebp),%eax
    1d5a:	8b 40 0c             	mov    0xc(%eax),%eax
    1d5d:	89 c2                	mov    %eax,%edx
    1d5f:	c1 ea 1f             	shr    $0x1f,%edx
    1d62:	01 d0                	add    %edx,%eax
    1d64:	d1 f8                	sar    %eax
    1d66:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1d69:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d6d:	0f 88 d8 00 00 00    	js     1e4b <APDrawRect+0x1ff>
    1d73:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d77:	0f 88 ce 00 00 00    	js     1e4b <APDrawRect+0x1ff>
    1d7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d80:	8b 00                	mov    (%eax),%eax
    1d82:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1d85:	0f 8e c0 00 00 00    	jle    1e4b <APDrawRect+0x1ff>
    1d8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d8e:	8b 40 04             	mov    0x4(%eax),%eax
    1d91:	3b 45 10             	cmp    0x10(%ebp),%eax
    1d94:	0f 8e b1 00 00 00    	jle    1e4b <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1d9a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1d9e:	79 07                	jns    1da7 <APDrawRect+0x15b>
    1da0:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1da7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1dab:	79 07                	jns    1db4 <APDrawRect+0x168>
    1dad:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1db4:	8b 45 08             	mov    0x8(%ebp),%eax
    1db7:	8b 00                	mov    (%eax),%eax
    1db9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1dbc:	7f 0b                	jg     1dc9 <APDrawRect+0x17d>
    1dbe:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc1:	8b 00                	mov    (%eax),%eax
    1dc3:	83 e8 01             	sub    $0x1,%eax
    1dc6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1dc9:	8b 45 08             	mov    0x8(%ebp),%eax
    1dcc:	8b 40 04             	mov    0x4(%eax),%eax
    1dcf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1dd2:	7f 0c                	jg     1de0 <APDrawRect+0x194>
    1dd4:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd7:	8b 40 04             	mov    0x4(%eax),%eax
    1dda:	83 e8 01             	sub    $0x1,%eax
    1ddd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1de0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1de7:	8b 45 0c             	mov    0xc(%ebp),%eax
    1dea:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1ded:	eb 52                	jmp    1e41 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1def:	8b 45 10             	mov    0x10(%ebp),%eax
    1df2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1df5:	eb 3e                	jmp    1e35 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1df7:	83 ec 04             	sub    $0x4,%esp
    1dfa:	ff 75 e8             	pushl  -0x18(%ebp)
    1dfd:	ff 75 ec             	pushl  -0x14(%ebp)
    1e00:	ff 75 08             	pushl  0x8(%ebp)
    1e03:	e8 c0 f6 ff ff       	call   14c8 <APGetIndex>
    1e08:	83 c4 10             	add    $0x10,%esp
    1e0b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1e0e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e11:	8b 48 18             	mov    0x18(%eax),%ecx
    1e14:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1e17:	89 d0                	mov    %edx,%eax
    1e19:	01 c0                	add    %eax,%eax
    1e1b:	01 d0                	add    %edx,%eax
    1e1d:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1e20:	8b 45 08             	mov    0x8(%ebp),%eax
    1e23:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1e27:	66 89 0a             	mov    %cx,(%edx)
    1e2a:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1e2e:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1e31:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1e35:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1e38:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1e3b:	7e ba                	jle    1df7 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1e3d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1e41:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e44:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1e47:	7e a6                	jle    1def <APDrawRect+0x1a3>
    1e49:	eb 01                	jmp    1e4c <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1e4b:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1e4c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1e4f:	c9                   	leave  
    1e50:	c3                   	ret    

00001e51 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1e51:	55                   	push   %ebp
    1e52:	89 e5                	mov    %esp,%ebp
    1e54:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    1e57:	83 ec 0c             	sub    $0xc,%esp
    1e5a:	ff 75 0c             	pushl  0xc(%ebp)
    1e5d:	e8 b1 ee ff ff       	call   d13 <strlen>
    1e62:	83 c4 10             	add    $0x10,%esp
    1e65:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1e68:	8b 45 08             	mov    0x8(%ebp),%eax
    1e6b:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1e6f:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1e73:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1e77:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1e7a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1e81:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1e88:	e9 bc 00 00 00       	jmp    1f49 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1e8d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1e90:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e93:	01 d0                	add    %edx,%eax
    1e95:	0f b6 00             	movzbl (%eax),%eax
    1e98:	0f be c0             	movsbl %al,%eax
    1e9b:	83 e8 20             	sub    $0x20,%eax
    1e9e:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1ea1:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1ea5:	0f 87 9a 00 00 00    	ja     1f45 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1eab:	8b 45 08             	mov    0x8(%ebp),%eax
    1eae:	8b 00                	mov    (%eax),%eax
    1eb0:	0f af 45 14          	imul   0x14(%ebp),%eax
    1eb4:	89 c2                	mov    %eax,%edx
    1eb6:	8b 45 10             	mov    0x10(%ebp),%eax
    1eb9:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1ebc:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ebf:	89 d0                	mov    %edx,%eax
    1ec1:	c1 e0 03             	shl    $0x3,%eax
    1ec4:	01 d0                	add    %edx,%eax
    1ec6:	01 c8                	add    %ecx,%eax
    1ec8:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1ecb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1ed2:	eb 6b                	jmp    1f3f <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1ed4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1edb:	eb 50                	jmp    1f2d <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    1edd:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1ee0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1ee3:	89 d0                	mov    %edx,%eax
    1ee5:	c1 e0 03             	shl    $0x3,%eax
    1ee8:	01 d0                	add    %edx,%eax
    1eea:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    1ef0:	01 c2                	add    %eax,%edx
    1ef2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1ef5:	01 d0                	add    %edx,%eax
    1ef7:	05 80 3c 00 00       	add    $0x3c80,%eax
    1efc:	0f b6 00             	movzbl (%eax),%eax
    1eff:	84 c0                	test   %al,%al
    1f01:	74 26                	je     1f29 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    1f03:	8b 45 08             	mov    0x8(%ebp),%eax
    1f06:	8b 50 18             	mov    0x18(%eax),%edx
    1f09:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1f0c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1f0f:	01 c8                	add    %ecx,%eax
    1f11:	89 c1                	mov    %eax,%ecx
    1f13:	89 c8                	mov    %ecx,%eax
    1f15:	01 c0                	add    %eax,%eax
    1f17:	01 c8                	add    %ecx,%eax
    1f19:	01 d0                	add    %edx,%eax
    1f1b:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1f1f:	66 89 10             	mov    %dx,(%eax)
    1f22:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1f26:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1f29:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1f2d:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1f31:	7e aa                	jle    1edd <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1f33:	8b 45 08             	mov    0x8(%ebp),%eax
    1f36:	8b 00                	mov    (%eax),%eax
    1f38:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1f3b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1f3f:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1f43:	7e 8f                	jle    1ed4 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    1f45:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1f49:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f4c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1f4f:	0f 82 38 ff ff ff    	jb     1e8d <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1f55:	90                   	nop
    1f56:	c9                   	leave  
    1f57:	c3                   	ret    

00001f58 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1f58:	55                   	push   %ebp
    1f59:	89 e5                	mov    %esp,%ebp
    1f5b:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1f5e:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1f62:	0f 88 8e 01 00 00    	js     20f6 <APDcCopy+0x19e>
    1f68:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1f6c:	0f 88 84 01 00 00    	js     20f6 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1f72:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f75:	8b 45 20             	mov    0x20(%ebp),%eax
    1f78:	01 d0                	add    %edx,%eax
    1f7a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1f7d:	8b 55 10             	mov    0x10(%ebp),%edx
    1f80:	8b 45 24             	mov    0x24(%ebp),%eax
    1f83:	01 d0                	add    %edx,%eax
    1f85:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1f88:	8b 55 18             	mov    0x18(%ebp),%edx
    1f8b:	8b 45 20             	mov    0x20(%ebp),%eax
    1f8e:	01 d0                	add    %edx,%eax
    1f90:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1f93:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1f96:	8b 45 24             	mov    0x24(%ebp),%eax
    1f99:	01 d0                	add    %edx,%eax
    1f9b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1f9e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1fa2:	0f 88 51 01 00 00    	js     20f9 <APDcCopy+0x1a1>
    1fa8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1fac:	0f 88 47 01 00 00    	js     20f9 <APDcCopy+0x1a1>
    1fb2:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1fb6:	0f 88 3d 01 00 00    	js     20f9 <APDcCopy+0x1a1>
    1fbc:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1fc0:	0f 88 33 01 00 00    	js     20f9 <APDcCopy+0x1a1>
    1fc6:	8b 45 14             	mov    0x14(%ebp),%eax
    1fc9:	8b 00                	mov    (%eax),%eax
    1fcb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1fce:	0f 8c 25 01 00 00    	jl     20f9 <APDcCopy+0x1a1>
    1fd4:	8b 45 14             	mov    0x14(%ebp),%eax
    1fd7:	8b 40 04             	mov    0x4(%eax),%eax
    1fda:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1fdd:	0f 8c 16 01 00 00    	jl     20f9 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1fe3:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe6:	8b 00                	mov    (%eax),%eax
    1fe8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1feb:	7f 0b                	jg     1ff8 <APDcCopy+0xa0>
    1fed:	8b 45 08             	mov    0x8(%ebp),%eax
    1ff0:	8b 00                	mov    (%eax),%eax
    1ff2:	83 e8 01             	sub    $0x1,%eax
    1ff5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1ff8:	8b 45 08             	mov    0x8(%ebp),%eax
    1ffb:	8b 40 04             	mov    0x4(%eax),%eax
    1ffe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2001:	7f 0c                	jg     200f <APDcCopy+0xb7>
    2003:	8b 45 08             	mov    0x8(%ebp),%eax
    2006:	8b 40 04             	mov    0x4(%eax),%eax
    2009:	83 e8 01             	sub    $0x1,%eax
    200c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    200f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    2016:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    201d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2024:	e9 bc 00 00 00       	jmp    20e5 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    2029:	8b 45 08             	mov    0x8(%ebp),%eax
    202c:	8b 00                	mov    (%eax),%eax
    202e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2031:	8b 55 10             	mov    0x10(%ebp),%edx
    2034:	01 ca                	add    %ecx,%edx
    2036:	0f af d0             	imul   %eax,%edx
    2039:	8b 45 0c             	mov    0xc(%ebp),%eax
    203c:	01 d0                	add    %edx,%eax
    203e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    2041:	8b 45 14             	mov    0x14(%ebp),%eax
    2044:	8b 00                	mov    (%eax),%eax
    2046:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2049:	8b 55 1c             	mov    0x1c(%ebp),%edx
    204c:	01 ca                	add    %ecx,%edx
    204e:	0f af d0             	imul   %eax,%edx
    2051:	8b 45 18             	mov    0x18(%ebp),%eax
    2054:	01 d0                	add    %edx,%eax
    2056:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    2059:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2060:	eb 74                	jmp    20d6 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    2062:	8b 45 14             	mov    0x14(%ebp),%eax
    2065:	8b 50 18             	mov    0x18(%eax),%edx
    2068:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    206b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    206e:	01 c8                	add    %ecx,%eax
    2070:	89 c1                	mov    %eax,%ecx
    2072:	89 c8                	mov    %ecx,%eax
    2074:	01 c0                	add    %eax,%eax
    2076:	01 c8                	add    %ecx,%eax
    2078:	01 d0                	add    %edx,%eax
    207a:	0f b7 10             	movzwl (%eax),%edx
    207d:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    2081:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    2085:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    2088:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    208c:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    2090:	38 c2                	cmp    %al,%dl
    2092:	75 18                	jne    20ac <APDcCopy+0x154>
    2094:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    2098:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    209c:	38 c2                	cmp    %al,%dl
    209e:	75 0c                	jne    20ac <APDcCopy+0x154>
    20a0:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    20a4:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    20a8:	38 c2                	cmp    %al,%dl
    20aa:	74 26                	je     20d2 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    20ac:	8b 45 08             	mov    0x8(%ebp),%eax
    20af:	8b 50 18             	mov    0x18(%eax),%edx
    20b2:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    20b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20b8:	01 c8                	add    %ecx,%eax
    20ba:	89 c1                	mov    %eax,%ecx
    20bc:	89 c8                	mov    %ecx,%eax
    20be:	01 c0                	add    %eax,%eax
    20c0:	01 c8                	add    %ecx,%eax
    20c2:	01 d0                	add    %edx,%eax
    20c4:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    20c8:	66 89 10             	mov    %dx,(%eax)
    20cb:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    20cf:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    20d2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    20d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    20d9:	2b 45 0c             	sub    0xc(%ebp),%eax
    20dc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    20df:	7d 81                	jge    2062 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    20e1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    20e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20e8:	2b 45 10             	sub    0x10(%ebp),%eax
    20eb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    20ee:	0f 8d 35 ff ff ff    	jge    2029 <APDcCopy+0xd1>
    20f4:	eb 04                	jmp    20fa <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    20f6:	90                   	nop
    20f7:	eb 01                	jmp    20fa <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    20f9:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    20fa:	c9                   	leave  
    20fb:	c3                   	ret    

000020fc <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    20fc:	55                   	push   %ebp
    20fd:	89 e5                	mov    %esp,%ebp
    20ff:	83 ec 1c             	sub    $0x1c,%esp
    2102:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    2105:	8b 55 10             	mov    0x10(%ebp),%edx
    2108:	8b 45 14             	mov    0x14(%ebp),%eax
    210b:	88 4d ec             	mov    %cl,-0x14(%ebp)
    210e:	88 55 e8             	mov    %dl,-0x18(%ebp)
    2111:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    2114:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    2118:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    211b:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    211f:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    2122:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    2126:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    2129:	8b 45 08             	mov    0x8(%ebp),%eax
    212c:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    2130:	66 89 10             	mov    %dx,(%eax)
    2133:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    2137:	88 50 02             	mov    %dl,0x2(%eax)
}
    213a:	8b 45 08             	mov    0x8(%ebp),%eax
    213d:	c9                   	leave  
    213e:	c2 04 00             	ret    $0x4

00002141 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    2141:	55                   	push   %ebp
    2142:	89 e5                	mov    %esp,%ebp
    2144:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    2147:	8b 45 08             	mov    0x8(%ebp),%eax
    214a:	8b 00                	mov    (%eax),%eax
    214c:	83 ec 08             	sub    $0x8,%esp
    214f:	8d 55 0c             	lea    0xc(%ebp),%edx
    2152:	52                   	push   %edx
    2153:	50                   	push   %eax
    2154:	e8 24 ee ff ff       	call   f7d <sendMessage>
    2159:	83 c4 10             	add    $0x10,%esp
}
    215c:	90                   	nop
    215d:	c9                   	leave  
    215e:	c3                   	ret    

0000215f <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    215f:	55                   	push   %ebp
    2160:	89 e5                	mov    %esp,%ebp
    2162:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    2165:	83 ec 0c             	sub    $0xc,%esp
    2168:	68 9c 00 00 00       	push   $0x9c
    216d:	e8 f5 f1 ff ff       	call   1367 <malloc>
    2172:	83 c4 10             	add    $0x10,%esp
    2175:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    2178:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    217c:	75 15                	jne    2193 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    217e:	83 ec 04             	sub    $0x4,%esp
    2181:	ff 75 08             	pushl  0x8(%ebp)
    2184:	68 d0 32 00 00       	push   $0x32d0
    2189:	6a 01                	push   $0x1
    218b:	e8 04 ef ff ff       	call   1094 <printf>
    2190:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    2193:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2196:	05 88 00 00 00       	add    $0x88,%eax
    219b:	83 ec 08             	sub    $0x8,%esp
    219e:	ff 75 08             	pushl  0x8(%ebp)
    21a1:	50                   	push   %eax
    21a2:	e8 fd ea ff ff       	call   ca4 <strcpy>
    21a7:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    21aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21ad:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    21b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21b7:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    21be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21c1:	8b 40 3c             	mov    0x3c(%eax),%eax
    21c4:	89 c2                	mov    %eax,%edx
    21c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21c9:	8b 40 40             	mov    0x40(%eax),%eax
    21cc:	0f af d0             	imul   %eax,%edx
    21cf:	89 d0                	mov    %edx,%eax
    21d1:	01 c0                	add    %eax,%eax
    21d3:	01 d0                	add    %edx,%eax
    21d5:	83 ec 0c             	sub    $0xc,%esp
    21d8:	50                   	push   %eax
    21d9:	e8 89 f1 ff ff       	call   1367 <malloc>
    21de:	83 c4 10             	add    $0x10,%esp
    21e1:	89 c2                	mov    %eax,%edx
    21e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21e6:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    21e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21ec:	8b 40 54             	mov    0x54(%eax),%eax
    21ef:	85 c0                	test   %eax,%eax
    21f1:	75 15                	jne    2208 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    21f3:	83 ec 04             	sub    $0x4,%esp
    21f6:	ff 75 08             	pushl  0x8(%ebp)
    21f9:	68 f0 32 00 00       	push   $0x32f0
    21fe:	6a 01                	push   $0x1
    2200:	e8 8f ee ff ff       	call   1094 <printf>
    2205:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    2208:	8b 45 f4             	mov    -0xc(%ebp),%eax
    220b:	8b 40 3c             	mov    0x3c(%eax),%eax
    220e:	89 c2                	mov    %eax,%edx
    2210:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2213:	8b 40 40             	mov    0x40(%eax),%eax
    2216:	0f af d0             	imul   %eax,%edx
    2219:	89 d0                	mov    %edx,%eax
    221b:	01 c0                	add    %eax,%eax
    221d:	01 c2                	add    %eax,%edx
    221f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2222:	8b 40 54             	mov    0x54(%eax),%eax
    2225:	83 ec 04             	sub    $0x4,%esp
    2228:	52                   	push   %edx
    2229:	68 ff ff ff 00       	push   $0xffffff
    222e:	50                   	push   %eax
    222f:	e8 06 eb ff ff       	call   d3a <memset>
    2234:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    2237:	8b 45 f4             	mov    -0xc(%ebp),%eax
    223a:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    2241:	e8 0f ed ff ff       	call   f55 <getpid>
    2246:	89 c2                	mov    %eax,%edx
    2248:	8b 45 f4             	mov    -0xc(%ebp),%eax
    224b:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    224e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2251:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    2258:	8b 45 f4             	mov    -0xc(%ebp),%eax
    225b:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    2262:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2265:	8b 40 58             	mov    0x58(%eax),%eax
    2268:	89 c2                	mov    %eax,%edx
    226a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    226d:	8b 40 5c             	mov    0x5c(%eax),%eax
    2270:	0f af d0             	imul   %eax,%edx
    2273:	89 d0                	mov    %edx,%eax
    2275:	01 c0                	add    %eax,%eax
    2277:	01 d0                	add    %edx,%eax
    2279:	83 ec 0c             	sub    $0xc,%esp
    227c:	50                   	push   %eax
    227d:	e8 e5 f0 ff ff       	call   1367 <malloc>
    2282:	83 c4 10             	add    $0x10,%esp
    2285:	89 c2                	mov    %eax,%edx
    2287:	8b 45 f4             	mov    -0xc(%ebp),%eax
    228a:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    228d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2290:	8b 40 70             	mov    0x70(%eax),%eax
    2293:	85 c0                	test   %eax,%eax
    2295:	75 15                	jne    22ac <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    2297:	83 ec 04             	sub    $0x4,%esp
    229a:	ff 75 08             	pushl  0x8(%ebp)
    229d:	68 14 33 00 00       	push   $0x3314
    22a2:	6a 01                	push   $0x1
    22a4:	e8 eb ed ff ff       	call   1094 <printf>
    22a9:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    22ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22af:	8b 40 3c             	mov    0x3c(%eax),%eax
    22b2:	89 c2                	mov    %eax,%edx
    22b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22b7:	8b 40 40             	mov    0x40(%eax),%eax
    22ba:	0f af d0             	imul   %eax,%edx
    22bd:	89 d0                	mov    %edx,%eax
    22bf:	01 c0                	add    %eax,%eax
    22c1:	01 c2                	add    %eax,%edx
    22c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22c6:	8b 40 54             	mov    0x54(%eax),%eax
    22c9:	83 ec 04             	sub    $0x4,%esp
    22cc:	52                   	push   %edx
    22cd:	68 ff 00 00 00       	push   $0xff
    22d2:	50                   	push   %eax
    22d3:	e8 62 ea ff ff       	call   d3a <memset>
    22d8:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    22db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22de:	8b 55 0c             	mov    0xc(%ebp),%edx
    22e1:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    22e4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    22e8:	74 49                	je     2333 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    22ea:	8b 45 10             	mov    0x10(%ebp),%eax
    22ed:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    22f3:	83 ec 0c             	sub    $0xc,%esp
    22f6:	50                   	push   %eax
    22f7:	e8 6b f0 ff ff       	call   1367 <malloc>
    22fc:	83 c4 10             	add    $0x10,%esp
    22ff:	89 c2                	mov    %eax,%edx
    2301:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2304:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    2307:	8b 45 f4             	mov    -0xc(%ebp),%eax
    230a:	8b 55 10             	mov    0x10(%ebp),%edx
    230d:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    2310:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2313:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    231a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    231d:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    2324:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2327:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    232e:	e9 8d 00 00 00       	jmp    23c0 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    2333:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2336:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    233d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2340:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    2347:	8b 45 f4             	mov    -0xc(%ebp),%eax
    234a:	8b 40 20             	mov    0x20(%eax),%eax
    234d:	89 c2                	mov    %eax,%edx
    234f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2352:	8b 40 24             	mov    0x24(%eax),%eax
    2355:	0f af d0             	imul   %eax,%edx
    2358:	89 d0                	mov    %edx,%eax
    235a:	01 c0                	add    %eax,%eax
    235c:	01 d0                	add    %edx,%eax
    235e:	83 ec 0c             	sub    $0xc,%esp
    2361:	50                   	push   %eax
    2362:	e8 00 f0 ff ff       	call   1367 <malloc>
    2367:	83 c4 10             	add    $0x10,%esp
    236a:	89 c2                	mov    %eax,%edx
    236c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    236f:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    2372:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2375:	8b 40 38             	mov    0x38(%eax),%eax
    2378:	85 c0                	test   %eax,%eax
    237a:	75 15                	jne    2391 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    237c:	83 ec 04             	sub    $0x4,%esp
    237f:	ff 75 08             	pushl  0x8(%ebp)
    2382:	68 3c 33 00 00       	push   $0x333c
    2387:	6a 01                	push   $0x1
    2389:	e8 06 ed ff ff       	call   1094 <printf>
    238e:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    2391:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2394:	8b 40 20             	mov    0x20(%eax),%eax
    2397:	89 c2                	mov    %eax,%edx
    2399:	8b 45 f4             	mov    -0xc(%ebp),%eax
    239c:	8b 40 24             	mov    0x24(%eax),%eax
    239f:	0f af d0             	imul   %eax,%edx
    23a2:	89 d0                	mov    %edx,%eax
    23a4:	01 c0                	add    %eax,%eax
    23a6:	01 c2                	add    %eax,%edx
    23a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23ab:	8b 40 38             	mov    0x38(%eax),%eax
    23ae:	83 ec 04             	sub    $0x4,%esp
    23b1:	52                   	push   %edx
    23b2:	68 ff ff ff 00       	push   $0xffffff
    23b7:	50                   	push   %eax
    23b8:	e8 7d e9 ff ff       	call   d3a <memset>
    23bd:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    23c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    23c3:	c9                   	leave  
    23c4:	c3                   	ret    

000023c5 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    23c5:	55                   	push   %ebp
    23c6:	89 e5                	mov    %esp,%ebp
    23c8:	57                   	push   %edi
    23c9:	56                   	push   %esi
    23ca:	53                   	push   %ebx
    23cb:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    23ce:	8b 45 0c             	mov    0xc(%ebp),%eax
    23d1:	83 f8 03             	cmp    $0x3,%eax
    23d4:	74 0e                	je     23e4 <APWndProc+0x1f>
    23d6:	83 f8 0a             	cmp    $0xa,%eax
    23d9:	0f 84 82 00 00 00    	je     2461 <APWndProc+0x9c>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            break;
        default: break;
    23df:	e9 cb 00 00 00       	jmp    24af <APWndProc+0xea>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    23e4:	8b 45 08             	mov    0x8(%ebp),%eax
    23e7:	8b 58 1c             	mov    0x1c(%eax),%ebx
    23ea:	8b 45 08             	mov    0x8(%ebp),%eax
    23ed:	8b 48 18             	mov    0x18(%eax),%ecx
    23f0:	8b 45 08             	mov    0x8(%ebp),%eax
    23f3:	8b 50 5c             	mov    0x5c(%eax),%edx
    23f6:	8b 45 08             	mov    0x8(%ebp),%eax
    23f9:	8b 40 58             	mov    0x58(%eax),%eax
    23fc:	8b 75 08             	mov    0x8(%ebp),%esi
    23ff:	83 c6 58             	add    $0x58,%esi
    2402:	83 ec 04             	sub    $0x4,%esp
    2405:	53                   	push   %ebx
    2406:	51                   	push   %ecx
    2407:	6a 00                	push   $0x0
    2409:	52                   	push   %edx
    240a:	50                   	push   %eax
    240b:	6a 00                	push   $0x0
    240d:	6a 00                	push   $0x0
    240f:	56                   	push   %esi
    2410:	6a 00                	push   $0x0
    2412:	6a 00                	push   $0x0
    2414:	ff 75 08             	pushl  0x8(%ebp)
    2417:	e8 59 eb ff ff       	call   f75 <paintWindow>
    241c:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    241f:	8b 45 08             	mov    0x8(%ebp),%eax
    2422:	8b 70 1c             	mov    0x1c(%eax),%esi
    2425:	8b 45 08             	mov    0x8(%ebp),%eax
    2428:	8b 58 18             	mov    0x18(%eax),%ebx
    242b:	8b 45 08             	mov    0x8(%ebp),%eax
    242e:	8b 48 08             	mov    0x8(%eax),%ecx
    2431:	8b 45 08             	mov    0x8(%ebp),%eax
    2434:	8b 50 40             	mov    0x40(%eax),%edx
    2437:	8b 45 08             	mov    0x8(%ebp),%eax
    243a:	8b 40 3c             	mov    0x3c(%eax),%eax
    243d:	8b 7d 08             	mov    0x8(%ebp),%edi
    2440:	83 c7 3c             	add    $0x3c,%edi
    2443:	83 ec 04             	sub    $0x4,%esp
    2446:	56                   	push   %esi
    2447:	53                   	push   %ebx
    2448:	51                   	push   %ecx
    2449:	52                   	push   %edx
    244a:	50                   	push   %eax
    244b:	6a 00                	push   $0x0
    244d:	6a 00                	push   $0x0
    244f:	57                   	push   %edi
    2450:	6a 32                	push   $0x32
    2452:	6a 00                	push   $0x0
    2454:	ff 75 08             	pushl  0x8(%ebp)
    2457:	e8 19 eb ff ff       	call   f75 <paintWindow>
    245c:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    245f:	eb 4e                	jmp    24af <APWndProc+0xea>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
    2461:	8b 45 18             	mov    0x18(%ebp),%eax
    2464:	83 ec 08             	sub    $0x8,%esp
    2467:	50                   	push   %eax
    2468:	ff 75 08             	pushl  0x8(%ebp)
    246b:	e8 c5 08 00 00       	call   2d35 <updateword>
    2470:	83 c4 10             	add    $0x10,%esp
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    2473:	8b 45 08             	mov    0x8(%ebp),%eax
    2476:	8b 58 1c             	mov    0x1c(%eax),%ebx
    2479:	8b 45 08             	mov    0x8(%ebp),%eax
    247c:	8b 48 18             	mov    0x18(%eax),%ecx
    247f:	8b 45 08             	mov    0x8(%ebp),%eax
    2482:	8b 50 5c             	mov    0x5c(%eax),%edx
    2485:	8b 45 08             	mov    0x8(%ebp),%eax
    2488:	8b 40 58             	mov    0x58(%eax),%eax
    248b:	8b 75 08             	mov    0x8(%ebp),%esi
    248e:	83 c6 58             	add    $0x58,%esi
    2491:	83 ec 04             	sub    $0x4,%esp
    2494:	53                   	push   %ebx
    2495:	51                   	push   %ecx
    2496:	6a 00                	push   $0x0
    2498:	52                   	push   %edx
    2499:	50                   	push   %eax
    249a:	6a 00                	push   $0x0
    249c:	6a 00                	push   $0x0
    249e:	56                   	push   %esi
    249f:	6a 00                	push   $0x0
    24a1:	6a 00                	push   $0x0
    24a3:	ff 75 08             	pushl  0x8(%ebp)
    24a6:	e8 ca ea ff ff       	call   f75 <paintWindow>
    24ab:	83 c4 30             	add    $0x30,%esp
            break;
    24ae:	90                   	nop
        default: break;
            
            
    }
    return False;
    24af:	b8 00 00 00 00       	mov    $0x0,%eax
}
    24b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    24b7:	5b                   	pop    %ebx
    24b8:	5e                   	pop    %esi
    24b9:	5f                   	pop    %edi
    24ba:	5d                   	pop    %ebp
    24bb:	c3                   	ret    

000024bc <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    24bc:	55                   	push   %ebp
    24bd:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    24bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    24c2:	8b 50 08             	mov    0x8(%eax),%edx
    24c5:	8b 45 08             	mov    0x8(%ebp),%eax
    24c8:	8b 00                	mov    (%eax),%eax
    24ca:	39 c2                	cmp    %eax,%edx
    24cc:	74 07                	je     24d5 <APPreJudge+0x19>
        return False;
    24ce:	b8 00 00 00 00       	mov    $0x0,%eax
    24d3:	eb 05                	jmp    24da <APPreJudge+0x1e>
    return True;
    24d5:	b8 01 00 00 00       	mov    $0x1,%eax
}
    24da:	5d                   	pop    %ebp
    24db:	c3                   	ret    

000024dc <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    24dc:	55                   	push   %ebp
    24dd:	89 e5                	mov    %esp,%ebp
    24df:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    24e2:	8b 45 08             	mov    0x8(%ebp),%eax
    24e5:	8b 55 0c             	mov    0xc(%ebp),%edx
    24e8:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
    //--------add window to list
    registWindow(hwnd);
    24ee:	83 ec 0c             	sub    $0xc,%esp
    24f1:	ff 75 08             	pushl  0x8(%ebp)
    24f4:	e8 94 ea ff ff       	call   f8d <registWindow>
    24f9:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    24fc:	c7 45 e8 02 00 00 00 	movl   $0x2,-0x18(%ebp)
    msg.wndID = hwnd->id;
    2503:	8b 45 08             	mov    0x8(%ebp),%eax
    2506:	8b 00                	mov    (%eax),%eax
    2508:	89 45 f0             	mov    %eax,-0x10(%ebp)
    APSendMessage(hwnd,msg);
    250b:	83 ec 0c             	sub    $0xc,%esp
    250e:	ff 75 f4             	pushl  -0xc(%ebp)
    2511:	ff 75 f0             	pushl  -0x10(%ebp)
    2514:	ff 75 ec             	pushl  -0x14(%ebp)
    2517:	ff 75 e8             	pushl  -0x18(%ebp)
    251a:	ff 75 08             	pushl  0x8(%ebp)
    251d:	e8 1f fc ff ff       	call   2141 <APSendMessage>
    2522:	83 c4 20             	add    $0x20,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    2525:	83 ec 0c             	sub    $0xc,%esp
    2528:	ff 75 08             	pushl  0x8(%ebp)
    252b:	e8 55 ea ff ff       	call   f85 <getMessage>
    2530:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    2533:	8b 45 08             	mov    0x8(%ebp),%eax
    2536:	83 c0 74             	add    $0x74,%eax
    2539:	83 ec 08             	sub    $0x8,%esp
    253c:	50                   	push   %eax
    253d:	ff 75 08             	pushl  0x8(%ebp)
    2540:	e8 77 ff ff ff       	call   24bc <APPreJudge>
    2545:	83 c4 10             	add    $0x10,%esp
    2548:	84 c0                	test   %al,%al
    254a:	74 24                	je     2570 <APWndExec+0x94>
            if (wndProc(hwnd, hwnd->msg))
    254c:	83 ec 0c             	sub    $0xc,%esp
    254f:	8b 45 08             	mov    0x8(%ebp),%eax
    2552:	ff b0 80 00 00 00    	pushl  0x80(%eax)
    2558:	ff 70 7c             	pushl  0x7c(%eax)
    255b:	ff 70 78             	pushl  0x78(%eax)
    255e:	ff 70 74             	pushl  0x74(%eax)
    2561:	ff 75 08             	pushl  0x8(%ebp)
    2564:	8b 45 0c             	mov    0xc(%ebp),%eax
    2567:	ff d0                	call   *%eax
    2569:	83 c4 20             	add    $0x20,%esp
    256c:	84 c0                	test   %al,%al
    256e:	75 0c                	jne    257c <APWndExec+0xa0>
                break;
        hwnd->msg.type = MSG_NULL;
    2570:	8b 45 08             	mov    0x8(%ebp),%eax
    2573:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    257a:	eb a9                	jmp    2525 <APWndExec+0x49>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    257c:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    257d:	90                   	nop
    257e:	c9                   	leave  
    257f:	c3                   	ret    

00002580 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    2580:	55                   	push   %ebp
    2581:	89 e5                	mov    %esp,%ebp
    2583:	57                   	push   %edi
    2584:	56                   	push   %esi
    2585:	53                   	push   %ebx
    2586:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    2589:	a1 30 79 00 00       	mov    0x7930,%eax
    258e:	85 c0                	test   %eax,%eax
    2590:	0f 85 c8 02 00 00    	jne    285e <APGridPaint+0x2de>
    {
        iconReady = 1;
    2596:	c7 05 30 79 00 00 01 	movl   $0x1,0x7930
    259d:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    25a0:	8d 45 98             	lea    -0x68(%ebp),%eax
    25a3:	83 ec 08             	sub    $0x8,%esp
    25a6:	68 63 33 00 00       	push   $0x3363
    25ab:	50                   	push   %eax
    25ac:	e8 69 ef ff ff       	call   151a <APLoadBitmap>
    25b1:	83 c4 0c             	add    $0xc,%esp
    25b4:	8b 45 98             	mov    -0x68(%ebp),%eax
    25b7:	a3 60 79 00 00       	mov    %eax,0x7960
    25bc:	8b 45 9c             	mov    -0x64(%ebp),%eax
    25bf:	a3 64 79 00 00       	mov    %eax,0x7964
    25c4:	8b 45 a0             	mov    -0x60(%ebp),%eax
    25c7:	a3 68 79 00 00       	mov    %eax,0x7968
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    25cc:	83 ec 04             	sub    $0x4,%esp
    25cf:	ff 35 68 79 00 00    	pushl  0x7968
    25d5:	ff 35 64 79 00 00    	pushl  0x7964
    25db:	ff 35 60 79 00 00    	pushl  0x7960
    25e1:	e8 6e f1 ff ff       	call   1754 <APCreateCompatibleDCFromBitmap>
    25e6:	83 c4 10             	add    $0x10,%esp
    25e9:	a3 6c 79 00 00       	mov    %eax,0x796c
        grid_river = APLoadBitmap ("grid_river.bmp");
    25ee:	8d 45 98             	lea    -0x68(%ebp),%eax
    25f1:	83 ec 08             	sub    $0x8,%esp
    25f4:	68 71 33 00 00       	push   $0x3371
    25f9:	50                   	push   %eax
    25fa:	e8 1b ef ff ff       	call   151a <APLoadBitmap>
    25ff:	83 c4 0c             	add    $0xc,%esp
    2602:	8b 45 98             	mov    -0x68(%ebp),%eax
    2605:	a3 ac 79 00 00       	mov    %eax,0x79ac
    260a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    260d:	a3 b0 79 00 00       	mov    %eax,0x79b0
    2612:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2615:	a3 b4 79 00 00       	mov    %eax,0x79b4
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    261a:	83 ec 04             	sub    $0x4,%esp
    261d:	ff 35 b4 79 00 00    	pushl  0x79b4
    2623:	ff 35 b0 79 00 00    	pushl  0x79b0
    2629:	ff 35 ac 79 00 00    	pushl  0x79ac
    262f:	e8 20 f1 ff ff       	call   1754 <APCreateCompatibleDCFromBitmap>
    2634:	83 c4 10             	add    $0x10,%esp
    2637:	a3 9c 79 00 00       	mov    %eax,0x799c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    263c:	8d 45 98             	lea    -0x68(%ebp),%eax
    263f:	83 ec 08             	sub    $0x8,%esp
    2642:	68 80 33 00 00       	push   $0x3380
    2647:	50                   	push   %eax
    2648:	e8 cd ee ff ff       	call   151a <APLoadBitmap>
    264d:	83 c4 0c             	add    $0xc,%esp
    2650:	8b 45 98             	mov    -0x68(%ebp),%eax
    2653:	a3 a0 79 00 00       	mov    %eax,0x79a0
    2658:	8b 45 9c             	mov    -0x64(%ebp),%eax
    265b:	a3 a4 79 00 00       	mov    %eax,0x79a4
    2660:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2663:	a3 a8 79 00 00       	mov    %eax,0x79a8
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    2668:	83 ec 04             	sub    $0x4,%esp
    266b:	ff 35 a8 79 00 00    	pushl  0x79a8
    2671:	ff 35 a4 79 00 00    	pushl  0x79a4
    2677:	ff 35 a0 79 00 00    	pushl  0x79a0
    267d:	e8 d2 f0 ff ff       	call   1754 <APCreateCompatibleDCFromBitmap>
    2682:	83 c4 10             	add    $0x10,%esp
    2685:	a3 34 79 00 00       	mov    %eax,0x7934
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    268a:	8d 45 98             	lea    -0x68(%ebp),%eax
    268d:	83 ec 08             	sub    $0x8,%esp
    2690:	68 8f 33 00 00       	push   $0x338f
    2695:	50                   	push   %eax
    2696:	e8 7f ee ff ff       	call   151a <APLoadBitmap>
    269b:	83 c4 0c             	add    $0xc,%esp
    269e:	8b 45 98             	mov    -0x68(%ebp),%eax
    26a1:	a3 38 79 00 00       	mov    %eax,0x7938
    26a6:	8b 45 9c             	mov    -0x64(%ebp),%eax
    26a9:	a3 3c 79 00 00       	mov    %eax,0x793c
    26ae:	8b 45 a0             	mov    -0x60(%ebp),%eax
    26b1:	a3 40 79 00 00       	mov    %eax,0x7940
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    26b6:	83 ec 04             	sub    $0x4,%esp
    26b9:	ff 35 40 79 00 00    	pushl  0x7940
    26bf:	ff 35 3c 79 00 00    	pushl  0x793c
    26c5:	ff 35 38 79 00 00    	pushl  0x7938
    26cb:	e8 84 f0 ff ff       	call   1754 <APCreateCompatibleDCFromBitmap>
    26d0:	83 c4 10             	add    $0x10,%esp
    26d3:	a3 5c 79 00 00       	mov    %eax,0x795c
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    26d8:	8d 45 98             	lea    -0x68(%ebp),%eax
    26db:	83 ec 08             	sub    $0x8,%esp
    26de:	68 a1 33 00 00       	push   $0x33a1
    26e3:	50                   	push   %eax
    26e4:	e8 31 ee ff ff       	call   151a <APLoadBitmap>
    26e9:	83 c4 0c             	add    $0xc,%esp
    26ec:	8b 45 98             	mov    -0x68(%ebp),%eax
    26ef:	a3 78 79 00 00       	mov    %eax,0x7978
    26f4:	8b 45 9c             	mov    -0x64(%ebp),%eax
    26f7:	a3 7c 79 00 00       	mov    %eax,0x797c
    26fc:	8b 45 a0             	mov    -0x60(%ebp),%eax
    26ff:	a3 80 79 00 00       	mov    %eax,0x7980
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    2704:	83 ec 04             	sub    $0x4,%esp
    2707:	ff 35 80 79 00 00    	pushl  0x7980
    270d:	ff 35 7c 79 00 00    	pushl  0x797c
    2713:	ff 35 78 79 00 00    	pushl  0x7978
    2719:	e8 36 f0 ff ff       	call   1754 <APCreateCompatibleDCFromBitmap>
    271e:	83 c4 10             	add    $0x10,%esp
    2721:	a3 bc 79 00 00       	mov    %eax,0x79bc
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    2726:	8d 45 98             	lea    -0x68(%ebp),%eax
    2729:	83 ec 08             	sub    $0x8,%esp
    272c:	68 af 33 00 00       	push   $0x33af
    2731:	50                   	push   %eax
    2732:	e8 e3 ed ff ff       	call   151a <APLoadBitmap>
    2737:	83 c4 0c             	add    $0xc,%esp
    273a:	8b 45 98             	mov    -0x68(%ebp),%eax
    273d:	a3 50 79 00 00       	mov    %eax,0x7950
    2742:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2745:	a3 54 79 00 00       	mov    %eax,0x7954
    274a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    274d:	a3 58 79 00 00       	mov    %eax,0x7958
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    2752:	83 ec 04             	sub    $0x4,%esp
    2755:	ff 35 58 79 00 00    	pushl  0x7958
    275b:	ff 35 54 79 00 00    	pushl  0x7954
    2761:	ff 35 50 79 00 00    	pushl  0x7950
    2767:	e8 e8 ef ff ff       	call   1754 <APCreateCompatibleDCFromBitmap>
    276c:	83 c4 10             	add    $0x10,%esp
    276f:	a3 70 79 00 00       	mov    %eax,0x7970
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    2774:	8d 45 98             	lea    -0x68(%ebp),%eax
    2777:	83 ec 08             	sub    $0x8,%esp
    277a:	68 bf 33 00 00       	push   $0x33bf
    277f:	50                   	push   %eax
    2780:	e8 95 ed ff ff       	call   151a <APLoadBitmap>
    2785:	83 c4 0c             	add    $0xc,%esp
    2788:	8b 45 98             	mov    -0x68(%ebp),%eax
    278b:	a3 90 79 00 00       	mov    %eax,0x7990
    2790:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2793:	a3 94 79 00 00       	mov    %eax,0x7994
    2798:	8b 45 a0             	mov    -0x60(%ebp),%eax
    279b:	a3 98 79 00 00       	mov    %eax,0x7998
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    27a0:	83 ec 04             	sub    $0x4,%esp
    27a3:	ff 35 98 79 00 00    	pushl  0x7998
    27a9:	ff 35 94 79 00 00    	pushl  0x7994
    27af:	ff 35 90 79 00 00    	pushl  0x7990
    27b5:	e8 9a ef ff ff       	call   1754 <APCreateCompatibleDCFromBitmap>
    27ba:	83 c4 10             	add    $0x10,%esp
    27bd:	a3 c0 79 00 00       	mov    %eax,0x79c0
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    27c2:	8d 45 98             	lea    -0x68(%ebp),%eax
    27c5:	83 ec 08             	sub    $0x8,%esp
    27c8:	68 ce 33 00 00       	push   $0x33ce
    27cd:	50                   	push   %eax
    27ce:	e8 47 ed ff ff       	call   151a <APLoadBitmap>
    27d3:	83 c4 0c             	add    $0xc,%esp
    27d6:	8b 45 98             	mov    -0x68(%ebp),%eax
    27d9:	a3 84 79 00 00       	mov    %eax,0x7984
    27de:	8b 45 9c             	mov    -0x64(%ebp),%eax
    27e1:	a3 88 79 00 00       	mov    %eax,0x7988
    27e6:	8b 45 a0             	mov    -0x60(%ebp),%eax
    27e9:	a3 8c 79 00 00       	mov    %eax,0x798c
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    27ee:	83 ec 04             	sub    $0x4,%esp
    27f1:	ff 35 8c 79 00 00    	pushl  0x798c
    27f7:	ff 35 88 79 00 00    	pushl  0x7988
    27fd:	ff 35 84 79 00 00    	pushl  0x7984
    2803:	e8 4c ef ff ff       	call   1754 <APCreateCompatibleDCFromBitmap>
    2808:	83 c4 10             	add    $0x10,%esp
    280b:	a3 b8 79 00 00       	mov    %eax,0x79b8
        grid_tower = APLoadBitmap ("grid_tower.bmp");
    2810:	8d 45 98             	lea    -0x68(%ebp),%eax
    2813:	83 ec 08             	sub    $0x8,%esp
    2816:	68 dd 33 00 00       	push   $0x33dd
    281b:	50                   	push   %eax
    281c:	e8 f9 ec ff ff       	call   151a <APLoadBitmap>
    2821:	83 c4 0c             	add    $0xc,%esp
    2824:	8b 45 98             	mov    -0x68(%ebp),%eax
    2827:	a3 44 79 00 00       	mov    %eax,0x7944
    282c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    282f:	a3 48 79 00 00       	mov    %eax,0x7948
    2834:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2837:	a3 4c 79 00 00       	mov    %eax,0x794c
        g_tower = APCreateCompatibleDCFromBitmap(grid_tower);
    283c:	83 ec 04             	sub    $0x4,%esp
    283f:	ff 35 4c 79 00 00    	pushl  0x794c
    2845:	ff 35 48 79 00 00    	pushl  0x7948
    284b:	ff 35 44 79 00 00    	pushl  0x7944
    2851:	e8 fe ee ff ff       	call   1754 <APCreateCompatibleDCFromBitmap>
    2856:	83 c4 10             	add    $0x10,%esp
    2859:	a3 74 79 00 00       	mov    %eax,0x7974
   
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    285e:	8b 45 08             	mov    0x8(%ebp),%eax
    2861:	8b 40 08             	mov    0x8(%eax),%eax
    2864:	85 c0                	test   %eax,%eax
    2866:	75 17                	jne    287f <APGridPaint+0x2ff>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    2868:	83 ec 08             	sub    $0x8,%esp
    286b:	68 ec 33 00 00       	push   $0x33ec
    2870:	6a 01                	push   $0x1
    2872:	e8 1d e8 ff ff       	call   1094 <printf>
    2877:	83 c4 10             	add    $0x10,%esp
        return;
    287a:	e9 ae 04 00 00       	jmp    2d2d <APGridPaint+0x7ad>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    287f:	8b 45 08             	mov    0x8(%ebp),%eax
    2882:	8b 40 10             	mov    0x10(%eax),%eax
    2885:	85 c0                	test   %eax,%eax
    2887:	7e 10                	jle    2899 <APGridPaint+0x319>
    2889:	8b 45 08             	mov    0x8(%ebp),%eax
    288c:	8b 50 14             	mov    0x14(%eax),%edx
    288f:	8b 45 08             	mov    0x8(%ebp),%eax
    2892:	8b 40 10             	mov    0x10(%eax),%eax
    2895:	39 c2                	cmp    %eax,%edx
    2897:	7c 17                	jl     28b0 <APGridPaint+0x330>
    {
        printf(1,"Grid mode page error!");
    2899:	83 ec 08             	sub    $0x8,%esp
    289c:	68 12 34 00 00       	push   $0x3412
    28a1:	6a 01                	push   $0x1
    28a3:	e8 ec e7 ff ff       	call   1094 <printf>
    28a8:	83 c4 10             	add    $0x10,%esp
        return;
    28ab:	e9 7d 04 00 00       	jmp    2d2d <APGridPaint+0x7ad>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    28b0:	8b 45 08             	mov    0x8(%ebp),%eax
    28b3:	8b 40 14             	mov    0x14(%eax),%eax
    28b6:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    28bc:	89 45 dc             	mov    %eax,-0x24(%ebp)
    28bf:	8b 45 dc             	mov    -0x24(%ebp),%eax
    28c2:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    28c5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    28cc:	e9 52 04 00 00       	jmp    2d23 <APGridPaint+0x7a3>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    28d1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    28d8:	e9 38 04 00 00       	jmp    2d15 <APGridPaint+0x795>
        {
            index = start + GRID_W_NUMBER * j + i;
    28dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    28e0:	c1 e0 04             	shl    $0x4,%eax
    28e3:	89 c2                	mov    %eax,%edx
    28e5:	8b 45 d8             	mov    -0x28(%ebp),%eax
    28e8:	01 c2                	add    %eax,%edx
    28ea:	8b 45 e0             	mov    -0x20(%ebp),%eax
    28ed:	01 d0                	add    %edx,%eax
    28ef:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    28f2:	8b 45 08             	mov    0x8(%ebp),%eax
    28f5:	8b 40 0c             	mov    0xc(%eax),%eax
    28f8:	8b 55 dc             	mov    -0x24(%ebp),%edx
    28fb:	c1 e2 02             	shl    $0x2,%edx
    28fe:	01 d0                	add    %edx,%eax
    2900:	8b 00                	mov    (%eax),%eax
    2902:	83 f8 0b             	cmp    $0xb,%eax
    2905:	0f 87 05 04 00 00    	ja     2d10 <APGridPaint+0x790>
    290b:	8b 04 85 28 34 00 00 	mov    0x3428(,%eax,4),%eax
    2912:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2914:	8d 45 bd             	lea    -0x43(%ebp),%eax
    2917:	6a 0c                	push   $0xc
    2919:	6a 0c                	push   $0xc
    291b:	6a 0c                	push   $0xc
    291d:	50                   	push   %eax
    291e:	e8 d9 f7 ff ff       	call   20fc <RGB>
    2923:	83 c4 0c             	add    $0xc,%esp
    2926:	8b 1d 6c 79 00 00    	mov    0x796c,%ebx
    292c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    292f:	6b c8 32             	imul   $0x32,%eax,%ecx
    2932:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2935:	6b c0 32             	imul   $0x32,%eax,%eax
    2938:	89 45 94             	mov    %eax,-0x6c(%ebp)
    293b:	8b 45 08             	mov    0x8(%ebp),%eax
    293e:	8d 78 3c             	lea    0x3c(%eax),%edi
    2941:	83 ec 0c             	sub    $0xc,%esp
    2944:	83 ec 04             	sub    $0x4,%esp
    2947:	89 e0                	mov    %esp,%eax
    2949:	0f b7 75 bd          	movzwl -0x43(%ebp),%esi
    294d:	66 89 30             	mov    %si,(%eax)
    2950:	0f b6 55 bf          	movzbl -0x41(%ebp),%edx
    2954:	88 50 02             	mov    %dl,0x2(%eax)
    2957:	6a 32                	push   $0x32
    2959:	6a 32                	push   $0x32
    295b:	6a 00                	push   $0x0
    295d:	6a 00                	push   $0x0
    295f:	53                   	push   %ebx
    2960:	51                   	push   %ecx
    2961:	ff 75 94             	pushl  -0x6c(%ebp)
    2964:	57                   	push   %edi
    2965:	e8 ee f5 ff ff       	call   1f58 <APDcCopy>
    296a:	83 c4 30             	add    $0x30,%esp
                    break;
    296d:	e9 9f 03 00 00       	jmp    2d11 <APGridPaint+0x791>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    2972:	8d 45 98             	lea    -0x68(%ebp),%eax
    2975:	6a 69                	push   $0x69
    2977:	6a 69                	push   $0x69
    2979:	6a 69                	push   $0x69
    297b:	50                   	push   %eax
    297c:	e8 7b f7 ff ff       	call   20fc <RGB>
    2981:	83 c4 0c             	add    $0xc,%esp
    2984:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2988:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    298c:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2990:	88 45 b6             	mov    %al,-0x4a(%ebp)
                    pen.size = 1;
    2993:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    299a:	8d 45 98             	lea    -0x68(%ebp),%eax
    299d:	6a 69                	push   $0x69
    299f:	6a 69                	push   $0x69
    29a1:	6a 69                	push   $0x69
    29a3:	50                   	push   %eax
    29a4:	e8 53 f7 ff ff       	call   20fc <RGB>
    29a9:	83 c4 0c             	add    $0xc,%esp
    29ac:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    29b0:	66 89 45 b1          	mov    %ax,-0x4f(%ebp)
    29b4:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    29b8:	88 45 b3             	mov    %al,-0x4d(%ebp)
                    APSetPen(&wnd->Dc,pen);
    29bb:	8b 45 08             	mov    0x8(%ebp),%eax
    29be:	8d 50 3c             	lea    0x3c(%eax),%edx
    29c1:	8d 45 98             	lea    -0x68(%ebp),%eax
    29c4:	ff 75 b8             	pushl  -0x48(%ebp)
    29c7:	ff 75 b4             	pushl  -0x4c(%ebp)
    29ca:	52                   	push   %edx
    29cb:	50                   	push   %eax
    29cc:	e8 18 ee ff ff       	call   17e9 <APSetPen>
    29d1:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    29d4:	8b 45 08             	mov    0x8(%ebp),%eax
    29d7:	8d 58 3c             	lea    0x3c(%eax),%ebx
    29da:	8d 55 98             	lea    -0x68(%ebp),%edx
    29dd:	83 ec 04             	sub    $0x4,%esp
    29e0:	83 ec 04             	sub    $0x4,%esp
    29e3:	89 e0                	mov    %esp,%eax
    29e5:	0f b7 4d b1          	movzwl -0x4f(%ebp),%ecx
    29e9:	66 89 08             	mov    %cx,(%eax)
    29ec:	0f b6 4d b3          	movzbl -0x4d(%ebp),%ecx
    29f0:	88 48 02             	mov    %cl,0x2(%eax)
    29f3:	53                   	push   %ebx
    29f4:	52                   	push   %edx
    29f5:	e8 28 ee ff ff       	call   1822 <APSetBrush>
    29fa:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    29fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2a00:	6b d0 32             	imul   $0x32,%eax,%edx
    2a03:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2a06:	6b c0 32             	imul   $0x32,%eax,%eax
    2a09:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2a0c:	83 c1 3c             	add    $0x3c,%ecx
    2a0f:	83 ec 0c             	sub    $0xc,%esp
    2a12:	6a 32                	push   $0x32
    2a14:	6a 32                	push   $0x32
    2a16:	52                   	push   %edx
    2a17:	50                   	push   %eax
    2a18:	51                   	push   %ecx
    2a19:	e8 2e f2 ff ff       	call   1c4c <APDrawRect>
    2a1e:	83 c4 20             	add    $0x20,%esp
                    break;
    2a21:	e9 eb 02 00 00       	jmp    2d11 <APGridPaint+0x791>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2a26:	8d 45 c0             	lea    -0x40(%ebp),%eax
    2a29:	6a 0c                	push   $0xc
    2a2b:	6a 0c                	push   $0xc
    2a2d:	6a 0c                	push   $0xc
    2a2f:	50                   	push   %eax
    2a30:	e8 c7 f6 ff ff       	call   20fc <RGB>
    2a35:	83 c4 0c             	add    $0xc,%esp
    2a38:	8b 1d c0 79 00 00    	mov    0x79c0,%ebx
    2a3e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2a41:	6b c8 32             	imul   $0x32,%eax,%ecx
    2a44:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2a47:	6b c0 32             	imul   $0x32,%eax,%eax
    2a4a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2a4d:	8b 45 08             	mov    0x8(%ebp),%eax
    2a50:	8d 78 3c             	lea    0x3c(%eax),%edi
    2a53:	83 ec 0c             	sub    $0xc,%esp
    2a56:	83 ec 04             	sub    $0x4,%esp
    2a59:	89 e0                	mov    %esp,%eax
    2a5b:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    2a5f:	66 89 30             	mov    %si,(%eax)
    2a62:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    2a66:	88 50 02             	mov    %dl,0x2(%eax)
    2a69:	6a 32                	push   $0x32
    2a6b:	6a 32                	push   $0x32
    2a6d:	6a 00                	push   $0x0
    2a6f:	6a 00                	push   $0x0
    2a71:	53                   	push   %ebx
    2a72:	51                   	push   %ecx
    2a73:	ff 75 94             	pushl  -0x6c(%ebp)
    2a76:	57                   	push   %edi
    2a77:	e8 dc f4 ff ff       	call   1f58 <APDcCopy>
    2a7c:	83 c4 30             	add    $0x30,%esp
                    break;
    2a7f:	e9 8d 02 00 00       	jmp    2d11 <APGridPaint+0x791>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2a84:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    2a87:	6a 0c                	push   $0xc
    2a89:	6a 0c                	push   $0xc
    2a8b:	6a 0c                	push   $0xc
    2a8d:	50                   	push   %eax
    2a8e:	e8 69 f6 ff ff       	call   20fc <RGB>
    2a93:	83 c4 0c             	add    $0xc,%esp
    2a96:	8b 1d 9c 79 00 00    	mov    0x799c,%ebx
    2a9c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2a9f:	6b c8 32             	imul   $0x32,%eax,%ecx
    2aa2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2aa5:	6b c0 32             	imul   $0x32,%eax,%eax
    2aa8:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2aab:	8b 45 08             	mov    0x8(%ebp),%eax
    2aae:	8d 78 3c             	lea    0x3c(%eax),%edi
    2ab1:	83 ec 0c             	sub    $0xc,%esp
    2ab4:	83 ec 04             	sub    $0x4,%esp
    2ab7:	89 e0                	mov    %esp,%eax
    2ab9:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    2abd:	66 89 30             	mov    %si,(%eax)
    2ac0:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    2ac4:	88 50 02             	mov    %dl,0x2(%eax)
    2ac7:	6a 32                	push   $0x32
    2ac9:	6a 32                	push   $0x32
    2acb:	6a 00                	push   $0x0
    2acd:	6a 00                	push   $0x0
    2acf:	53                   	push   %ebx
    2ad0:	51                   	push   %ecx
    2ad1:	ff 75 94             	pushl  -0x6c(%ebp)
    2ad4:	57                   	push   %edi
    2ad5:	e8 7e f4 ff ff       	call   1f58 <APDcCopy>
    2ada:	83 c4 30             	add    $0x30,%esp
                    break;
    2add:	e9 2f 02 00 00       	jmp    2d11 <APGridPaint+0x791>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2ae2:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    2ae5:	6a 0c                	push   $0xc
    2ae7:	6a 0c                	push   $0xc
    2ae9:	6a 0c                	push   $0xc
    2aeb:	50                   	push   %eax
    2aec:	e8 0b f6 ff ff       	call   20fc <RGB>
    2af1:	83 c4 0c             	add    $0xc,%esp
    2af4:	8b 1d 70 79 00 00    	mov    0x7970,%ebx
    2afa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2afd:	6b c8 32             	imul   $0x32,%eax,%ecx
    2b00:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2b03:	6b c0 32             	imul   $0x32,%eax,%eax
    2b06:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2b09:	8b 45 08             	mov    0x8(%ebp),%eax
    2b0c:	8d 78 3c             	lea    0x3c(%eax),%edi
    2b0f:	83 ec 0c             	sub    $0xc,%esp
    2b12:	83 ec 04             	sub    $0x4,%esp
    2b15:	89 e0                	mov    %esp,%eax
    2b17:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    2b1b:	66 89 30             	mov    %si,(%eax)
    2b1e:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    2b22:	88 50 02             	mov    %dl,0x2(%eax)
    2b25:	6a 32                	push   $0x32
    2b27:	6a 32                	push   $0x32
    2b29:	6a 00                	push   $0x0
    2b2b:	6a 00                	push   $0x0
    2b2d:	53                   	push   %ebx
    2b2e:	51                   	push   %ecx
    2b2f:	ff 75 94             	pushl  -0x6c(%ebp)
    2b32:	57                   	push   %edi
    2b33:	e8 20 f4 ff ff       	call   1f58 <APDcCopy>
    2b38:	83 c4 30             	add    $0x30,%esp
                    break;
    2b3b:	e9 d1 01 00 00       	jmp    2d11 <APGridPaint+0x791>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2b40:	8d 45 c9             	lea    -0x37(%ebp),%eax
    2b43:	6a 0c                	push   $0xc
    2b45:	6a 0c                	push   $0xc
    2b47:	6a 0c                	push   $0xc
    2b49:	50                   	push   %eax
    2b4a:	e8 ad f5 ff ff       	call   20fc <RGB>
    2b4f:	83 c4 0c             	add    $0xc,%esp
    2b52:	8b 1d bc 79 00 00    	mov    0x79bc,%ebx
    2b58:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2b5b:	6b c8 32             	imul   $0x32,%eax,%ecx
    2b5e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2b61:	6b c0 32             	imul   $0x32,%eax,%eax
    2b64:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2b67:	8b 45 08             	mov    0x8(%ebp),%eax
    2b6a:	8d 78 3c             	lea    0x3c(%eax),%edi
    2b6d:	83 ec 0c             	sub    $0xc,%esp
    2b70:	83 ec 04             	sub    $0x4,%esp
    2b73:	89 e0                	mov    %esp,%eax
    2b75:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    2b79:	66 89 30             	mov    %si,(%eax)
    2b7c:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    2b80:	88 50 02             	mov    %dl,0x2(%eax)
    2b83:	6a 32                	push   $0x32
    2b85:	6a 32                	push   $0x32
    2b87:	6a 00                	push   $0x0
    2b89:	6a 00                	push   $0x0
    2b8b:	53                   	push   %ebx
    2b8c:	51                   	push   %ecx
    2b8d:	ff 75 94             	pushl  -0x6c(%ebp)
    2b90:	57                   	push   %edi
    2b91:	e8 c2 f3 ff ff       	call   1f58 <APDcCopy>
    2b96:	83 c4 30             	add    $0x30,%esp
                    break;
    2b99:	e9 73 01 00 00       	jmp    2d11 <APGridPaint+0x791>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2b9e:	8d 45 cc             	lea    -0x34(%ebp),%eax
    2ba1:	6a 0c                	push   $0xc
    2ba3:	6a 0c                	push   $0xc
    2ba5:	6a 0c                	push   $0xc
    2ba7:	50                   	push   %eax
    2ba8:	e8 4f f5 ff ff       	call   20fc <RGB>
    2bad:	83 c4 0c             	add    $0xc,%esp
    2bb0:	8b 1d 34 79 00 00    	mov    0x7934,%ebx
    2bb6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2bb9:	6b c8 32             	imul   $0x32,%eax,%ecx
    2bbc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2bbf:	6b c0 32             	imul   $0x32,%eax,%eax
    2bc2:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2bc5:	8b 45 08             	mov    0x8(%ebp),%eax
    2bc8:	8d 78 3c             	lea    0x3c(%eax),%edi
    2bcb:	83 ec 0c             	sub    $0xc,%esp
    2bce:	83 ec 04             	sub    $0x4,%esp
    2bd1:	89 e0                	mov    %esp,%eax
    2bd3:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    2bd7:	66 89 30             	mov    %si,(%eax)
    2bda:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    2bde:	88 50 02             	mov    %dl,0x2(%eax)
    2be1:	6a 32                	push   $0x32
    2be3:	6a 32                	push   $0x32
    2be5:	6a 00                	push   $0x0
    2be7:	6a 00                	push   $0x0
    2be9:	53                   	push   %ebx
    2bea:	51                   	push   %ecx
    2beb:	ff 75 94             	pushl  -0x6c(%ebp)
    2bee:	57                   	push   %edi
    2bef:	e8 64 f3 ff ff       	call   1f58 <APDcCopy>
    2bf4:	83 c4 30             	add    $0x30,%esp
                    break;
    2bf7:	e9 15 01 00 00       	jmp    2d11 <APGridPaint+0x791>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2bfc:	8d 45 cf             	lea    -0x31(%ebp),%eax
    2bff:	6a 0c                	push   $0xc
    2c01:	6a 0c                	push   $0xc
    2c03:	6a 0c                	push   $0xc
    2c05:	50                   	push   %eax
    2c06:	e8 f1 f4 ff ff       	call   20fc <RGB>
    2c0b:	83 c4 0c             	add    $0xc,%esp
    2c0e:	8b 1d 5c 79 00 00    	mov    0x795c,%ebx
    2c14:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2c17:	6b c8 32             	imul   $0x32,%eax,%ecx
    2c1a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2c1d:	6b c0 32             	imul   $0x32,%eax,%eax
    2c20:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2c23:	8b 45 08             	mov    0x8(%ebp),%eax
    2c26:	8d 78 3c             	lea    0x3c(%eax),%edi
    2c29:	83 ec 0c             	sub    $0xc,%esp
    2c2c:	83 ec 04             	sub    $0x4,%esp
    2c2f:	89 e0                	mov    %esp,%eax
    2c31:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    2c35:	66 89 30             	mov    %si,(%eax)
    2c38:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2c3c:	88 50 02             	mov    %dl,0x2(%eax)
    2c3f:	6a 32                	push   $0x32
    2c41:	6a 32                	push   $0x32
    2c43:	6a 00                	push   $0x0
    2c45:	6a 00                	push   $0x0
    2c47:	53                   	push   %ebx
    2c48:	51                   	push   %ecx
    2c49:	ff 75 94             	pushl  -0x6c(%ebp)
    2c4c:	57                   	push   %edi
    2c4d:	e8 06 f3 ff ff       	call   1f58 <APDcCopy>
    2c52:	83 c4 30             	add    $0x30,%esp
                    break;
    2c55:	e9 b7 00 00 00       	jmp    2d11 <APGridPaint+0x791>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2c5a:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2c5d:	6a 0c                	push   $0xc
    2c5f:	6a 0c                	push   $0xc
    2c61:	6a 0c                	push   $0xc
    2c63:	50                   	push   %eax
    2c64:	e8 93 f4 ff ff       	call   20fc <RGB>
    2c69:	83 c4 0c             	add    $0xc,%esp
    2c6c:	8b 1d b8 79 00 00    	mov    0x79b8,%ebx
    2c72:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2c75:	6b c8 32             	imul   $0x32,%eax,%ecx
    2c78:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2c7b:	6b c0 32             	imul   $0x32,%eax,%eax
    2c7e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2c81:	8b 45 08             	mov    0x8(%ebp),%eax
    2c84:	8d 78 3c             	lea    0x3c(%eax),%edi
    2c87:	83 ec 0c             	sub    $0xc,%esp
    2c8a:	83 ec 04             	sub    $0x4,%esp
    2c8d:	89 e0                	mov    %esp,%eax
    2c8f:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2c93:	66 89 30             	mov    %si,(%eax)
    2c96:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2c9a:	88 50 02             	mov    %dl,0x2(%eax)
    2c9d:	6a 32                	push   $0x32
    2c9f:	6a 32                	push   $0x32
    2ca1:	6a 00                	push   $0x0
    2ca3:	6a 00                	push   $0x0
    2ca5:	53                   	push   %ebx
    2ca6:	51                   	push   %ecx
    2ca7:	ff 75 94             	pushl  -0x6c(%ebp)
    2caa:	57                   	push   %edi
    2cab:	e8 a8 f2 ff ff       	call   1f58 <APDcCopy>
    2cb0:	83 c4 30             	add    $0x30,%esp
                    break;
    2cb3:	eb 5c                	jmp    2d11 <APGridPaint+0x791>
                case GRID_PROGRAM_TOWER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_tower,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2cb5:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    2cb8:	6a 0c                	push   $0xc
    2cba:	6a 0c                	push   $0xc
    2cbc:	6a 0c                	push   $0xc
    2cbe:	50                   	push   %eax
    2cbf:	e8 38 f4 ff ff       	call   20fc <RGB>
    2cc4:	83 c4 0c             	add    $0xc,%esp
    2cc7:	8b 1d 74 79 00 00    	mov    0x7974,%ebx
    2ccd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2cd0:	6b c8 32             	imul   $0x32,%eax,%ecx
    2cd3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2cd6:	6b c0 32             	imul   $0x32,%eax,%eax
    2cd9:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2cdc:	8b 45 08             	mov    0x8(%ebp),%eax
    2cdf:	8d 78 3c             	lea    0x3c(%eax),%edi
    2ce2:	83 ec 0c             	sub    $0xc,%esp
    2ce5:	83 ec 04             	sub    $0x4,%esp
    2ce8:	89 e0                	mov    %esp,%eax
    2cea:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2cee:	66 89 30             	mov    %si,(%eax)
    2cf1:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2cf5:	88 50 02             	mov    %dl,0x2(%eax)
    2cf8:	6a 32                	push   $0x32
    2cfa:	6a 32                	push   $0x32
    2cfc:	6a 00                	push   $0x0
    2cfe:	6a 00                	push   $0x0
    2d00:	53                   	push   %ebx
    2d01:	51                   	push   %ecx
    2d02:	ff 75 94             	pushl  -0x6c(%ebp)
    2d05:	57                   	push   %edi
    2d06:	e8 4d f2 ff ff       	call   1f58 <APDcCopy>
    2d0b:	83 c4 30             	add    $0x30,%esp
                    break;
    2d0e:	eb 01                	jmp    2d11 <APGridPaint+0x791>
                default: break;
    2d10:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2d11:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2d15:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2d19:	0f 8e be fb ff ff    	jle    28dd <APGridPaint+0x35d>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2d1f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2d23:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2d27:	0f 8e a4 fb ff ff    	jle    28d1 <APGridPaint+0x351>
                    break;
                default: break;
            }
        }
    }
}
    2d2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2d30:	5b                   	pop    %ebx
    2d31:	5e                   	pop    %esi
    2d32:	5f                   	pop    %edi
    2d33:	5d                   	pop    %ebp
    2d34:	c3                   	ret    

00002d35 <updateword>:


void updateword(AHwnd hwnd,char* str)
{
    2d35:	55                   	push   %ebp
    2d36:	89 e5                	mov    %esp,%ebp
    2d38:	53                   	push   %ebx
    2d39:	83 ec 24             	sub    $0x24,%esp
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2d3c:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2d3f:	68 cd 00 00 00       	push   $0xcd
    2d44:	6a 74                	push   $0x74
    2d46:	6a 18                	push   $0x18
    2d48:	50                   	push   %eax
    2d49:	e8 ae f3 ff ff       	call   20fc <RGB>
    2d4e:	83 c4 0c             	add    $0xc,%esp
    2d51:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2d55:	66 89 45 f0          	mov    %ax,-0x10(%ebp)
    2d59:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    2d5d:	88 45 f2             	mov    %al,-0xe(%ebp)
    pen.size = 1;
    2d60:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2d67:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2d6a:	68 cd 00 00 00       	push   $0xcd
    2d6f:	6a 74                	push   $0x74
    2d71:	6a 18                	push   $0x18
    2d73:	50                   	push   %eax
    2d74:	e8 83 f3 ff ff       	call   20fc <RGB>
    2d79:	83 c4 0c             	add    $0xc,%esp
    2d7c:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2d80:	66 89 45 ed          	mov    %ax,-0x13(%ebp)
    2d84:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    2d88:	88 45 ef             	mov    %al,-0x11(%ebp)
    APSetPen(&hwnd->TitleDc,pen);
    2d8b:	8b 45 08             	mov    0x8(%ebp),%eax
    2d8e:	8d 50 58             	lea    0x58(%eax),%edx
    2d91:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2d94:	ff 75 f4             	pushl  -0xc(%ebp)
    2d97:	ff 75 f0             	pushl  -0x10(%ebp)
    2d9a:	52                   	push   %edx
    2d9b:	50                   	push   %eax
    2d9c:	e8 48 ea ff ff       	call   17e9 <APSetPen>
    2da1:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&hwnd->TitleDc,brush);
    2da4:	8b 45 08             	mov    0x8(%ebp),%eax
    2da7:	8d 58 58             	lea    0x58(%eax),%ebx
    2daa:	8d 55 d8             	lea    -0x28(%ebp),%edx
    2dad:	83 ec 04             	sub    $0x4,%esp
    2db0:	83 ec 04             	sub    $0x4,%esp
    2db3:	89 e0                	mov    %esp,%eax
    2db5:	0f b7 4d ed          	movzwl -0x13(%ebp),%ecx
    2db9:	66 89 08             	mov    %cx,(%eax)
    2dbc:	0f b6 4d ef          	movzbl -0x11(%ebp),%ecx
    2dc0:	88 48 02             	mov    %cl,0x2(%eax)
    2dc3:	53                   	push   %ebx
    2dc4:	52                   	push   %edx
    2dc5:	e8 58 ea ff ff       	call   1822 <APSetBrush>
    2dca:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&hwnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2dcd:	8b 45 08             	mov    0x8(%ebp),%eax
    2dd0:	83 c0 58             	add    $0x58,%eax
    2dd3:	83 ec 0c             	sub    $0xc,%esp
    2dd6:	6a 32                	push   $0x32
    2dd8:	68 20 03 00 00       	push   $0x320
    2ddd:	6a 00                	push   $0x0
    2ddf:	6a 00                	push   $0x0
    2de1:	50                   	push   %eax
    2de2:	e8 65 ee ff ff       	call   1c4c <APDrawRect>
    2de7:	83 c4 20             	add    $0x20,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    2dea:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2ded:	6a 08                	push   $0x8
    2def:	6a 08                	push   $0x8
    2df1:	6a 08                	push   $0x8
    2df3:	50                   	push   %eax
    2df4:	e8 03 f3 ff ff       	call   20fc <RGB>
    2df9:	83 c4 0c             	add    $0xc,%esp
    2dfc:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2e00:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    2e04:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    2e08:	88 45 ec             	mov    %al,-0x14(%ebp)
    APSetFont(&hwnd->TitleDc,font);
    2e0b:	8b 45 08             	mov    0x8(%ebp),%eax
    2e0e:	8d 58 58             	lea    0x58(%eax),%ebx
    2e11:	8d 55 d8             	lea    -0x28(%ebp),%edx
    2e14:	83 ec 04             	sub    $0x4,%esp
    2e17:	83 ec 04             	sub    $0x4,%esp
    2e1a:	89 e0                	mov    %esp,%eax
    2e1c:	0f b7 4d ea          	movzwl -0x16(%ebp),%ecx
    2e20:	66 89 08             	mov    %cx,(%eax)
    2e23:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
    2e27:	88 48 02             	mov    %cl,0x2(%eax)
    2e2a:	53                   	push   %ebx
    2e2b:	52                   	push   %edx
    2e2c:	e8 33 ea ff ff       	call   1864 <APSetFont>
    2e31:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&hwnd->TitleDc,str,10,20);
    2e34:	8b 45 08             	mov    0x8(%ebp),%eax
    2e37:	83 c0 58             	add    $0x58,%eax
    2e3a:	6a 14                	push   $0x14
    2e3c:	6a 0a                	push   $0xa
    2e3e:	ff 75 0c             	pushl  0xc(%ebp)
    2e41:	50                   	push   %eax
    2e42:	e8 0a f0 ff ff       	call   1e51 <APDrawText>
    2e47:	83 c4 10             	add    $0x10,%esp
}
    2e4a:	90                   	nop
    2e4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2e4e:	c9                   	leave  
    2e4f:	c3                   	ret    

00002e50 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2e50:	55                   	push   %ebp
    2e51:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2e53:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2e57:	7e 08                	jle    2e61 <random+0x11>
{
rand_num = seed;
    2e59:	8b 45 08             	mov    0x8(%ebp),%eax
    2e5c:	a3 a0 78 00 00       	mov    %eax,0x78a0
}
rand_num *= 3;
    2e61:	8b 15 a0 78 00 00    	mov    0x78a0,%edx
    2e67:	89 d0                	mov    %edx,%eax
    2e69:	01 c0                	add    %eax,%eax
    2e6b:	01 d0                	add    %edx,%eax
    2e6d:	a3 a0 78 00 00       	mov    %eax,0x78a0
if (rand_num < 0)
    2e72:	a1 a0 78 00 00       	mov    0x78a0,%eax
    2e77:	85 c0                	test   %eax,%eax
    2e79:	79 0c                	jns    2e87 <random+0x37>
{
rand_num *= (-1);
    2e7b:	a1 a0 78 00 00       	mov    0x78a0,%eax
    2e80:	f7 d8                	neg    %eax
    2e82:	a3 a0 78 00 00       	mov    %eax,0x78a0
}
return rand_num % 997;
    2e87:	8b 0d a0 78 00 00    	mov    0x78a0,%ecx
    2e8d:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2e92:	89 c8                	mov    %ecx,%eax
    2e94:	f7 ea                	imul   %edx
    2e96:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2e99:	c1 f8 09             	sar    $0x9,%eax
    2e9c:	89 c2                	mov    %eax,%edx
    2e9e:	89 c8                	mov    %ecx,%eax
    2ea0:	c1 f8 1f             	sar    $0x1f,%eax
    2ea3:	29 c2                	sub    %eax,%edx
    2ea5:	89 d0                	mov    %edx,%eax
    2ea7:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2ead:	29 c1                	sub    %eax,%ecx
    2eaf:	89 c8                	mov    %ecx,%eax
}
    2eb1:	5d                   	pop    %ebp
    2eb2:	c3                   	ret    

00002eb3 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2eb3:	55                   	push   %ebp
    2eb4:	89 e5                	mov    %esp,%ebp
    2eb6:	53                   	push   %ebx
    2eb7:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2eba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2ec1:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2ec5:	74 17                	je     2ede <sprintint+0x2b>
    2ec7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2ecb:	79 11                	jns    2ede <sprintint+0x2b>
        neg = 1;
    2ecd:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2ed4:	8b 45 10             	mov    0x10(%ebp),%eax
    2ed7:	f7 d8                	neg    %eax
    2ed9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2edc:	eb 06                	jmp    2ee4 <sprintint+0x31>
    } else {
        x = xx;
    2ede:	8b 45 10             	mov    0x10(%ebp),%eax
    2ee1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2ee4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2eeb:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2eee:	8d 41 01             	lea    0x1(%ecx),%eax
    2ef1:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2ef4:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2ef7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2efa:	ba 00 00 00 00       	mov    $0x0,%edx
    2eff:	f7 f3                	div    %ebx
    2f01:	89 d0                	mov    %edx,%eax
    2f03:	0f b6 80 a4 78 00 00 	movzbl 0x78a4(%eax),%eax
    2f0a:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2f0e:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2f11:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2f14:	ba 00 00 00 00       	mov    $0x0,%edx
    2f19:	f7 f3                	div    %ebx
    2f1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2f1e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2f22:	75 c7                	jne    2eeb <sprintint+0x38>
    if(neg)
    2f24:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2f28:	74 0e                	je     2f38 <sprintint+0x85>
        buf[i++] = '-';
    2f2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2f2d:	8d 50 01             	lea    0x1(%eax),%edx
    2f30:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2f33:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2f38:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2f3b:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2f3e:	eb 1b                	jmp    2f5b <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2f40:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f43:	8b 00                	mov    (%eax),%eax
    2f45:	8d 48 01             	lea    0x1(%eax),%ecx
    2f48:	8b 55 0c             	mov    0xc(%ebp),%edx
    2f4b:	89 0a                	mov    %ecx,(%edx)
    2f4d:	89 c2                	mov    %eax,%edx
    2f4f:	8b 45 08             	mov    0x8(%ebp),%eax
    2f52:	01 d0                	add    %edx,%eax
    2f54:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2f57:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2f5b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2f5f:	7f df                	jg     2f40 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2f61:	eb 21                	jmp    2f84 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2f63:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f66:	8b 00                	mov    (%eax),%eax
    2f68:	8d 48 01             	lea    0x1(%eax),%ecx
    2f6b:	8b 55 0c             	mov    0xc(%ebp),%edx
    2f6e:	89 0a                	mov    %ecx,(%edx)
    2f70:	89 c2                	mov    %eax,%edx
    2f72:	8b 45 08             	mov    0x8(%ebp),%eax
    2f75:	01 c2                	add    %eax,%edx
    2f77:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2f7a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2f7d:	01 c8                	add    %ecx,%eax
    2f7f:	0f b6 00             	movzbl (%eax),%eax
    2f82:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2f84:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2f88:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2f8c:	79 d5                	jns    2f63 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2f8e:	90                   	nop
    2f8f:	83 c4 20             	add    $0x20,%esp
    2f92:	5b                   	pop    %ebx
    2f93:	5d                   	pop    %ebp
    2f94:	c3                   	ret    

00002f95 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2f95:	55                   	push   %ebp
    2f96:	89 e5                	mov    %esp,%ebp
    2f98:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2f9b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2fa2:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2fa9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2fb0:	8d 45 0c             	lea    0xc(%ebp),%eax
    2fb3:	83 c0 04             	add    $0x4,%eax
    2fb6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2fb9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2fc0:	e9 d9 01 00 00       	jmp    319e <sprintf+0x209>
        c = fmt[i] & 0xff;
    2fc5:	8b 55 0c             	mov    0xc(%ebp),%edx
    2fc8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2fcb:	01 d0                	add    %edx,%eax
    2fcd:	0f b6 00             	movzbl (%eax),%eax
    2fd0:	0f be c0             	movsbl %al,%eax
    2fd3:	25 ff 00 00 00       	and    $0xff,%eax
    2fd8:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2fdb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2fdf:	75 2c                	jne    300d <sprintf+0x78>
            if(c == '%'){
    2fe1:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2fe5:	75 0c                	jne    2ff3 <sprintf+0x5e>
                state = '%';
    2fe7:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2fee:	e9 a7 01 00 00       	jmp    319a <sprintf+0x205>
            } else {
                dst[j++] = c;
    2ff3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2ff6:	8d 50 01             	lea    0x1(%eax),%edx
    2ff9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2ffc:	89 c2                	mov    %eax,%edx
    2ffe:	8b 45 08             	mov    0x8(%ebp),%eax
    3001:	01 d0                	add    %edx,%eax
    3003:	8b 55 e0             	mov    -0x20(%ebp),%edx
    3006:	88 10                	mov    %dl,(%eax)
    3008:	e9 8d 01 00 00       	jmp    319a <sprintf+0x205>
            }
        } else if(state == '%'){
    300d:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    3011:	0f 85 83 01 00 00    	jne    319a <sprintf+0x205>
            if(c == 'd'){
    3017:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    301b:	75 4c                	jne    3069 <sprintf+0xd4>
                buf[bi] = '\0';
    301d:	8d 55 ce             	lea    -0x32(%ebp),%edx
    3020:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3023:	01 d0                	add    %edx,%eax
    3025:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    3028:	83 ec 0c             	sub    $0xc,%esp
    302b:	8d 45 ce             	lea    -0x32(%ebp),%eax
    302e:	50                   	push   %eax
    302f:	e8 0f de ff ff       	call   e43 <atoi>
    3034:	83 c4 10             	add    $0x10,%esp
    3037:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    303a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    3041:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3044:	8b 00                	mov    (%eax),%eax
    3046:	83 ec 08             	sub    $0x8,%esp
    3049:	ff 75 d8             	pushl  -0x28(%ebp)
    304c:	6a 01                	push   $0x1
    304e:	6a 0a                	push   $0xa
    3050:	50                   	push   %eax
    3051:	8d 45 c8             	lea    -0x38(%ebp),%eax
    3054:	50                   	push   %eax
    3055:	ff 75 08             	pushl  0x8(%ebp)
    3058:	e8 56 fe ff ff       	call   2eb3 <sprintint>
    305d:	83 c4 20             	add    $0x20,%esp
                ap++;
    3060:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    3064:	e9 2a 01 00 00       	jmp    3193 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    3069:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    306d:	74 06                	je     3075 <sprintf+0xe0>
    306f:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    3073:	75 4c                	jne    30c1 <sprintf+0x12c>
                buf[bi] = '\0';
    3075:	8d 55 ce             	lea    -0x32(%ebp),%edx
    3078:	8b 45 f0             	mov    -0x10(%ebp),%eax
    307b:	01 d0                	add    %edx,%eax
    307d:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    3080:	83 ec 0c             	sub    $0xc,%esp
    3083:	8d 45 ce             	lea    -0x32(%ebp),%eax
    3086:	50                   	push   %eax
    3087:	e8 b7 dd ff ff       	call   e43 <atoi>
    308c:	83 c4 10             	add    $0x10,%esp
    308f:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    3092:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    3099:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    309c:	8b 00                	mov    (%eax),%eax
    309e:	83 ec 08             	sub    $0x8,%esp
    30a1:	ff 75 dc             	pushl  -0x24(%ebp)
    30a4:	6a 00                	push   $0x0
    30a6:	6a 10                	push   $0x10
    30a8:	50                   	push   %eax
    30a9:	8d 45 c8             	lea    -0x38(%ebp),%eax
    30ac:	50                   	push   %eax
    30ad:	ff 75 08             	pushl  0x8(%ebp)
    30b0:	e8 fe fd ff ff       	call   2eb3 <sprintint>
    30b5:	83 c4 20             	add    $0x20,%esp
                ap++;
    30b8:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    30bc:	e9 d2 00 00 00       	jmp    3193 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    30c1:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    30c5:	75 46                	jne    310d <sprintf+0x178>
                s = (char*)*ap;
    30c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    30ca:	8b 00                	mov    (%eax),%eax
    30cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    30cf:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    30d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    30d7:	75 25                	jne    30fe <sprintf+0x169>
                    s = "(null)";
    30d9:	c7 45 f4 58 34 00 00 	movl   $0x3458,-0xc(%ebp)
                while(*s != 0){
    30e0:	eb 1c                	jmp    30fe <sprintf+0x169>
                    dst[j++] = *s;
    30e2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    30e5:	8d 50 01             	lea    0x1(%eax),%edx
    30e8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    30eb:	89 c2                	mov    %eax,%edx
    30ed:	8b 45 08             	mov    0x8(%ebp),%eax
    30f0:	01 c2                	add    %eax,%edx
    30f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    30f5:	0f b6 00             	movzbl (%eax),%eax
    30f8:	88 02                	mov    %al,(%edx)
                    s++;
    30fa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    30fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3101:	0f b6 00             	movzbl (%eax),%eax
    3104:	84 c0                	test   %al,%al
    3106:	75 da                	jne    30e2 <sprintf+0x14d>
    3108:	e9 86 00 00 00       	jmp    3193 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    310d:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    3111:	75 1d                	jne    3130 <sprintf+0x19b>
                dst[j++] = *ap;
    3113:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3116:	8d 50 01             	lea    0x1(%eax),%edx
    3119:	89 55 c8             	mov    %edx,-0x38(%ebp)
    311c:	89 c2                	mov    %eax,%edx
    311e:	8b 45 08             	mov    0x8(%ebp),%eax
    3121:	01 c2                	add    %eax,%edx
    3123:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3126:	8b 00                	mov    (%eax),%eax
    3128:	88 02                	mov    %al,(%edx)
                ap++;
    312a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    312e:	eb 63                	jmp    3193 <sprintf+0x1fe>
            } else if(c == '%'){
    3130:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    3134:	75 17                	jne    314d <sprintf+0x1b8>
                dst[j++] = c;
    3136:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3139:	8d 50 01             	lea    0x1(%eax),%edx
    313c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    313f:	89 c2                	mov    %eax,%edx
    3141:	8b 45 08             	mov    0x8(%ebp),%eax
    3144:	01 d0                	add    %edx,%eax
    3146:	8b 55 e0             	mov    -0x20(%ebp),%edx
    3149:	88 10                	mov    %dl,(%eax)
    314b:	eb 46                	jmp    3193 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    314d:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    3151:	7e 18                	jle    316b <sprintf+0x1d6>
    3153:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    3157:	7f 12                	jg     316b <sprintf+0x1d6>
            {
                buf[bi++] = c;
    3159:	8b 45 f0             	mov    -0x10(%ebp),%eax
    315c:	8d 50 01             	lea    0x1(%eax),%edx
    315f:	89 55 f0             	mov    %edx,-0x10(%ebp)
    3162:	8b 55 e0             	mov    -0x20(%ebp),%edx
    3165:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    3169:	eb 2f                	jmp    319a <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    316b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    316e:	8d 50 01             	lea    0x1(%eax),%edx
    3171:	89 55 c8             	mov    %edx,-0x38(%ebp)
    3174:	89 c2                	mov    %eax,%edx
    3176:	8b 45 08             	mov    0x8(%ebp),%eax
    3179:	01 d0                	add    %edx,%eax
    317b:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    317e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3181:	8d 50 01             	lea    0x1(%eax),%edx
    3184:	89 55 c8             	mov    %edx,-0x38(%ebp)
    3187:	89 c2                	mov    %eax,%edx
    3189:	8b 45 08             	mov    0x8(%ebp),%eax
    318c:	01 d0                	add    %edx,%eax
    318e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    3191:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    3193:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    319a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    319e:	8b 55 0c             	mov    0xc(%ebp),%edx
    31a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    31a4:	01 d0                	add    %edx,%eax
    31a6:	0f b6 00             	movzbl (%eax),%eax
    31a9:	84 c0                	test   %al,%al
    31ab:	0f 85 14 fe ff ff    	jne    2fc5 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    31b1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    31b4:	8d 50 01             	lea    0x1(%eax),%edx
    31b7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    31ba:	89 c2                	mov    %eax,%edx
    31bc:	8b 45 08             	mov    0x8(%ebp),%eax
    31bf:	01 d0                	add    %edx,%eax
    31c1:	c6 00 00             	movb   $0x0,(%eax)
}
    31c4:	90                   	nop
    31c5:	c9                   	leave  
    31c6:	c3                   	ret    
