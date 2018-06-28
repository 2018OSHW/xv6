
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
      1b:	8b 04 85 e4 2a 00 00 	mov    0x2ae4(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 b8 2a 00 00       	push   $0x2ab8
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
      6c:	68 bf 2a 00 00       	push   $0x2abf
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
      bf:	68 cf 2a 00 00       	push   $0x2acf
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
     143:	68 df 2a 00 00       	push   $0x2adf
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
     254:	68 fc 2a 00 00       	push   $0x2afc
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
     2ce:	68 ff 2a 00 00       	push   $0x2aff
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
     2e9:	0f b6 05 a0 34 00 00 	movzbl 0x34a0,%eax
     2f0:	3c 63                	cmp    $0x63,%al
     2f2:	75 5f                	jne    353 <main+0xb3>
     2f4:	0f b6 05 a1 34 00 00 	movzbl 0x34a1,%eax
     2fb:	3c 64                	cmp    $0x64,%al
     2fd:	75 54                	jne    353 <main+0xb3>
     2ff:	0f b6 05 a2 34 00 00 	movzbl 0x34a2,%eax
     306:	3c 20                	cmp    $0x20,%al
     308:	75 49                	jne    353 <main+0xb3>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     30a:	83 ec 0c             	sub    $0xc,%esp
     30d:	68 a0 34 00 00       	push   $0x34a0
     312:	e8 fc 09 00 00       	call   d13 <strlen>
     317:	83 c4 10             	add    $0x10,%esp
     31a:	83 e8 01             	sub    $0x1,%eax
     31d:	c6 80 a0 34 00 00 00 	movb   $0x0,0x34a0(%eax)
      if(chdir(buf+3) < 0)
     324:	b8 a3 34 00 00       	mov    $0x34a3,%eax
     329:	83 ec 0c             	sub    $0xc,%esp
     32c:	50                   	push   %eax
     32d:	e8 13 0c 00 00       	call   f45 <chdir>
     332:	83 c4 10             	add    $0x10,%esp
     335:	85 c0                	test   %eax,%eax
     337:	79 44                	jns    37d <main+0xdd>
        printf(2, "cannot cd %s\n", buf+3);
     339:	b8 a3 34 00 00       	mov    $0x34a3,%eax
     33e:	83 ec 04             	sub    $0x4,%esp
     341:	50                   	push   %eax
     342:	68 07 2b 00 00       	push   $0x2b07
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
     35f:	68 a0 34 00 00       	push   $0x34a0
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
     382:	68 a0 34 00 00       	push   $0x34a0
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
     3a8:	68 15 2b 00 00       	push   $0x2b15
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
     3d3:	68 19 2b 00 00       	push   $0x2b19
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
     576:	68 50 34 00 00       	push   $0x3450
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
     61f:	68 50 34 00 00       	push   $0x3450
     624:	e8 2b 07 00 00       	call   d54 <strchr>
     629:	83 c4 10             	add    $0x10,%esp
     62c:	85 c0                	test   %eax,%eax
     62e:	75 26                	jne    656 <gettoken+0x109>
     630:	8b 45 f4             	mov    -0xc(%ebp),%eax
     633:	0f b6 00             	movzbl (%eax),%eax
     636:	0f be c0             	movsbl %al,%eax
     639:	83 ec 08             	sub    $0x8,%esp
     63c:	50                   	push   %eax
     63d:	68 58 34 00 00       	push   $0x3458
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
     680:	68 50 34 00 00       	push   $0x3450
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
     6c7:	68 50 34 00 00       	push   $0x3450
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
     74a:	68 1e 2b 00 00       	push   $0x2b1e
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
     76d:	68 1f 2b 00 00       	push   $0x2b1f
     772:	6a 02                	push   $0x2
     774:	e8 fb 08 00 00       	call   1074 <printf>
     779:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     77c:	83 ec 0c             	sub    $0xc,%esp
     77f:	68 2e 2b 00 00       	push   $0x2b2e
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
     7e4:	68 35 2b 00 00       	push   $0x2b35
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
     7fe:	68 37 2b 00 00       	push   $0x2b37
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
     86c:	68 39 2b 00 00       	push   $0x2b39
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
     8fb:	68 3b 2b 00 00       	push   $0x2b3b
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
     981:	68 58 2b 00 00       	push   $0x2b58
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
     9aa:	68 5b 2b 00 00       	push   $0x2b5b
     9af:	ff 75 0c             	pushl  0xc(%ebp)
     9b2:	ff 75 08             	pushl  0x8(%ebp)
     9b5:	e8 e4 fc ff ff       	call   69e <peek>
     9ba:	83 c4 10             	add    $0x10,%esp
     9bd:	85 c0                	test   %eax,%eax
     9bf:	75 10                	jne    9d1 <parseblock+0x30>
    panic("parseblock");
     9c1:	83 ec 0c             	sub    $0xc,%esp
     9c4:	68 5d 2b 00 00       	push   $0x2b5d
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
     9fa:	68 68 2b 00 00       	push   $0x2b68
     9ff:	ff 75 0c             	pushl  0xc(%ebp)
     a02:	ff 75 08             	pushl  0x8(%ebp)
     a05:	e8 94 fc ff ff       	call   69e <peek>
     a0a:	83 c4 10             	add    $0x10,%esp
     a0d:	85 c0                	test   %eax,%eax
     a0f:	75 10                	jne    a21 <parseblock+0x80>
    panic("syntax - missing )");
     a11:	83 ec 0c             	sub    $0xc,%esp
     a14:	68 6a 2b 00 00       	push   $0x2b6a
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
     a58:	68 5b 2b 00 00       	push   $0x2b5b
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
     ae2:	68 2e 2b 00 00       	push   $0x2b2e
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
     b19:	68 7d 2b 00 00       	push   $0x2b7d
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
     b40:	68 8b 2b 00 00       	push   $0x2b8b
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
     ba6:	8b 04 85 90 2b 00 00 	mov    0x2b90(,%eax,4),%eax
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
    1010:	0f b6 80 60 34 00 00 	movzbl 0x3460(%eax),%eax
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
    114e:	c7 45 f4 a8 2b 00 00 	movl   $0x2ba8,-0xc(%ebp)
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
    1214:	a1 0c 35 00 00       	mov    0x350c,%eax
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
    12df:	a3 0c 35 00 00       	mov    %eax,0x350c
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
    1340:	a1 0c 35 00 00       	mov    0x350c,%eax
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
    135c:	a1 0c 35 00 00       	mov    0x350c,%eax
    1361:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1364:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1368:	75 23                	jne    138d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    136a:	c7 45 f0 04 35 00 00 	movl   $0x3504,-0x10(%ebp)
    1371:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1374:	a3 0c 35 00 00       	mov    %eax,0x350c
    1379:	a1 0c 35 00 00       	mov    0x350c,%eax
    137e:	a3 04 35 00 00       	mov    %eax,0x3504
    base.s.size = 0;
    1383:	c7 05 08 35 00 00 00 	movl   $0x0,0x3508
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
    13e0:	a3 0c 35 00 00       	mov    %eax,0x350c
      return (void*)(p + 1);
    13e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13e8:	83 c0 08             	add    $0x8,%eax
    13eb:	eb 3b                	jmp    1428 <malloc+0xe1>
    }
    if(p == freep)
    13ed:	a1 0c 35 00 00       	mov    0x350c,%eax
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
    14fd:	56                   	push   %esi
    14fe:	53                   	push   %ebx
    14ff:	83 ec 70             	sub    $0x70,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    1502:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    1509:	8b 45 cc             	mov    -0x34(%ebp),%eax
    150c:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
    150f:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
    1516:	83 ec 08             	sub    $0x8,%esp
    1519:	6a 00                	push   $0x0
    151b:	ff 75 0c             	pushl  0xc(%ebp)
    151e:	e8 f2 f9 ff ff       	call   f15 <open>
    1523:	83 c4 10             	add    $0x10,%esp
    1526:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
    1529:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    152d:	79 2e                	jns    155d <APLoadBitmap+0x63>
    {
        printf(1, "Cannot open %s\n", filename);
    152f:	83 ec 04             	sub    $0x4,%esp
    1532:	ff 75 0c             	pushl  0xc(%ebp)
    1535:	68 b0 2b 00 00       	push   $0x2bb0
    153a:	6a 01                	push   $0x1
    153c:	e8 33 fb ff ff       	call   1074 <printf>
    1541:	83 c4 10             	add    $0x10,%esp
        return bmp;
    1544:	8b 45 08             	mov    0x8(%ebp),%eax
    1547:	8b 55 c8             	mov    -0x38(%ebp),%edx
    154a:	89 10                	mov    %edx,(%eax)
    154c:	8b 55 cc             	mov    -0x34(%ebp),%edx
    154f:	89 50 04             	mov    %edx,0x4(%eax)
    1552:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1555:	89 50 08             	mov    %edx,0x8(%eax)
    1558:	e9 1b 02 00 00       	jmp    1778 <APLoadBitmap+0x27e>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    155d:	83 ec 04             	sub    $0x4,%esp
    1560:	6a 10                	push   $0x10
    1562:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1565:	50                   	push   %eax
    1566:	ff 75 ec             	pushl  -0x14(%ebp)
    1569:	e8 7f f9 ff ff       	call   eed <read>
    156e:	83 c4 10             	add    $0x10,%esp
    printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    1571:	0f b7 45 c2          	movzwl -0x3e(%ebp),%eax
    1575:	0f b7 f0             	movzwl %ax,%esi
    1578:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
    157c:	0f b7 d8             	movzwl %ax,%ebx
    157f:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
    1582:	8b 55 bc             	mov    -0x44(%ebp),%edx
    1585:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1589:	0f b7 c0             	movzwl %ax,%eax
    158c:	83 ec 04             	sub    $0x4,%esp
    158f:	56                   	push   %esi
    1590:	53                   	push   %ebx
    1591:	51                   	push   %ecx
    1592:	52                   	push   %edx
    1593:	50                   	push   %eax
    1594:	68 c0 2b 00 00       	push   $0x2bc0
    1599:	6a 01                	push   $0x1
    159b:	e8 d4 fa ff ff       	call   1074 <printf>
    15a0:	83 c4 20             	add    $0x20,%esp
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    15a3:	83 ec 04             	sub    $0x4,%esp
    15a6:	6a 28                	push   $0x28
    15a8:	8d 45 90             	lea    -0x70(%ebp),%eax
    15ab:	50                   	push   %eax
    15ac:	ff 75 ec             	pushl  -0x14(%ebp)
    15af:	e8 39 f9 ff ff       	call   eed <read>
    15b4:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
    15b7:	8b 45 94             	mov    -0x6c(%ebp),%eax
    15ba:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
    15bd:	8b 45 98             	mov    -0x68(%ebp),%eax
    15c0:	89 45 cc             	mov    %eax,-0x34(%ebp)
    printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    15c3:	8b 55 c8             	mov    -0x38(%ebp),%edx
    15c6:	8b 45 cc             	mov    -0x34(%ebp),%eax
    15c9:	52                   	push   %edx
    15ca:	50                   	push   %eax
    15cb:	68 d0 2b 00 00       	push   $0x2bd0
    15d0:	6a 01                	push   $0x1
    15d2:	e8 9d fa ff ff       	call   1074 <printf>
    15d7:	83 c4 10             	add    $0x10,%esp
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    15da:	8b 55 c8             	mov    -0x38(%ebp),%edx
    15dd:	8b 45 cc             	mov    -0x34(%ebp),%eax
    15e0:	0f af d0             	imul   %eax,%edx
    15e3:	89 d0                	mov    %edx,%eax
    15e5:	01 c0                	add    %eax,%eax
    15e7:	01 d0                	add    %edx,%eax
    15e9:	83 ec 0c             	sub    $0xc,%esp
    15ec:	50                   	push   %eax
    15ed:	e8 55 fd ff ff       	call   1347 <malloc>
    15f2:	83 c4 10             	add    $0x10,%esp
    15f5:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
    15f8:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
    15fc:	0f b7 c0             	movzwl %ax,%eax
    15ff:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    1602:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1605:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1608:	0f af c2             	imul   %edx,%eax
    160b:	83 c0 1f             	add    $0x1f,%eax
    160e:	c1 e8 05             	shr    $0x5,%eax
    1611:	c1 e0 02             	shl    $0x2,%eax
    1614:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
    1617:	8b 55 cc             	mov    -0x34(%ebp),%edx
    161a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    161d:	0f af c2             	imul   %edx,%eax
    1620:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    1623:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1626:	83 ec 0c             	sub    $0xc,%esp
    1629:	50                   	push   %eax
    162a:	e8 18 fd ff ff       	call   1347 <malloc>
    162f:	83 c4 10             	add    $0x10,%esp
    1632:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    1635:	83 ec 04             	sub    $0x4,%esp
    1638:	ff 75 e0             	pushl  -0x20(%ebp)
    163b:	ff 75 dc             	pushl  -0x24(%ebp)
    163e:	ff 75 ec             	pushl  -0x14(%ebp)
    1641:	e8 a7 f8 ff ff       	call   eed <read>
    1646:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
    1649:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
    164d:	66 c1 e8 03          	shr    $0x3,%ax
    1651:	0f b7 c0             	movzwl %ax,%eax
    1654:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
    1657:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    165e:	e9 e5 00 00 00       	jmp    1748 <APLoadBitmap+0x24e>
    {
        int off = (bmp.height - j - 1) * bmp.width;
    1663:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1666:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1669:	29 c2                	sub    %eax,%edx
    166b:	89 d0                	mov    %edx,%eax
    166d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1670:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1673:	0f af c2             	imul   %edx,%eax
    1676:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
    1679:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1680:	e9 b1 00 00 00       	jmp    1736 <APLoadBitmap+0x23c>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
    1685:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1688:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    168b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    168e:	01 c8                	add    %ecx,%eax
    1690:	89 c1                	mov    %eax,%ecx
    1692:	89 c8                	mov    %ecx,%eax
    1694:	01 c0                	add    %eax,%eax
    1696:	01 c8                	add    %ecx,%eax
    1698:	01 c2                	add    %eax,%edx
    169a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169d:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    16a1:	89 c1                	mov    %eax,%ecx
    16a3:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16a6:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    16aa:	01 c1                	add    %eax,%ecx
    16ac:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16af:	01 c8                	add    %ecx,%eax
    16b1:	8d 48 ff             	lea    -0x1(%eax),%ecx
    16b4:	8b 45 dc             	mov    -0x24(%ebp),%eax
    16b7:	01 c8                	add    %ecx,%eax
    16b9:	0f b6 00             	movzbl (%eax),%eax
    16bc:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
    16bf:	8b 55 d0             	mov    -0x30(%ebp),%edx
    16c2:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    16c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16c8:	01 c8                	add    %ecx,%eax
    16ca:	89 c1                	mov    %eax,%ecx
    16cc:	89 c8                	mov    %ecx,%eax
    16ce:	01 c0                	add    %eax,%eax
    16d0:	01 c8                	add    %ecx,%eax
    16d2:	01 c2                	add    %eax,%edx
    16d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d7:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    16db:	89 c1                	mov    %eax,%ecx
    16dd:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16e0:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    16e4:	01 c1                	add    %eax,%ecx
    16e6:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16e9:	01 c8                	add    %ecx,%eax
    16eb:	8d 48 fe             	lea    -0x2(%eax),%ecx
    16ee:	8b 45 dc             	mov    -0x24(%ebp),%eax
    16f1:	01 c8                	add    %ecx,%eax
    16f3:	0f b6 00             	movzbl (%eax),%eax
    16f6:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
    16f9:	8b 55 d0             	mov    -0x30(%ebp),%edx
    16fc:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    16ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1702:	01 c8                	add    %ecx,%eax
    1704:	89 c1                	mov    %eax,%ecx
    1706:	89 c8                	mov    %ecx,%eax
    1708:	01 c0                	add    %eax,%eax
    170a:	01 c8                	add    %ecx,%eax
    170c:	01 c2                	add    %eax,%edx
    170e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1711:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1715:	89 c1                	mov    %eax,%ecx
    1717:	8b 45 d8             	mov    -0x28(%ebp),%eax
    171a:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    171e:	01 c1                	add    %eax,%ecx
    1720:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1723:	01 c8                	add    %ecx,%eax
    1725:	8d 48 fd             	lea    -0x3(%eax),%ecx
    1728:	8b 45 dc             	mov    -0x24(%ebp),%eax
    172b:	01 c8                	add    %ecx,%eax
    172d:	0f b6 00             	movzbl (%eax),%eax
    1730:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    1732:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1736:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1739:	8b 45 f0             	mov    -0x10(%ebp),%eax
    173c:	39 c2                	cmp    %eax,%edx
    173e:	0f 87 41 ff ff ff    	ja     1685 <APLoadBitmap+0x18b>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    1744:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1748:	8b 55 cc             	mov    -0x34(%ebp),%edx
    174b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    174e:	39 c2                	cmp    %eax,%edx
    1750:	0f 87 0d ff ff ff    	ja     1663 <APLoadBitmap+0x169>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    1756:	83 ec 0c             	sub    $0xc,%esp
    1759:	ff 75 ec             	pushl  -0x14(%ebp)
    175c:	e8 9c f7 ff ff       	call   efd <close>
    1761:	83 c4 10             	add    $0x10,%esp
    return bmp;
    1764:	8b 45 08             	mov    0x8(%ebp),%eax
    1767:	8b 55 c8             	mov    -0x38(%ebp),%edx
    176a:	89 10                	mov    %edx,(%eax)
    176c:	8b 55 cc             	mov    -0x34(%ebp),%edx
    176f:	89 50 04             	mov    %edx,0x4(%eax)
    1772:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1775:	89 50 08             	mov    %edx,0x8(%eax)
}
    1778:	8b 45 08             	mov    0x8(%ebp),%eax
    177b:	8d 65 f8             	lea    -0x8(%ebp),%esp
    177e:	5b                   	pop    %ebx
    177f:	5e                   	pop    %esi
    1780:	5d                   	pop    %ebp
    1781:	c2 04 00             	ret    $0x4

00001784 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    1784:	55                   	push   %ebp
    1785:	89 e5                	mov    %esp,%ebp
    1787:	53                   	push   %ebx
    1788:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    178b:	83 ec 0c             	sub    $0xc,%esp
    178e:	6a 1c                	push   $0x1c
    1790:	e8 b2 fb ff ff       	call   1347 <malloc>
    1795:	83 c4 10             	add    $0x10,%esp
    1798:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    179b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179e:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    17a5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    17a8:	8d 45 d8             	lea    -0x28(%ebp),%eax
    17ab:	6a 0c                	push   $0xc
    17ad:	6a 0c                	push   $0xc
    17af:	6a 0c                	push   $0xc
    17b1:	50                   	push   %eax
    17b2:	e8 73 fc ff ff       	call   142a <RGB>
    17b7:	83 c4 0c             	add    $0xc,%esp
    17ba:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    17be:	66 89 43 13          	mov    %ax,0x13(%ebx)
    17c2:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    17c6:	88 43 15             	mov    %al,0x15(%ebx)
    17c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17cf:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    17d3:	66 89 48 10          	mov    %cx,0x10(%eax)
    17d7:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    17db:	88 50 12             	mov    %dl,0x12(%eax)
    17de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17e4:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    17e8:	66 89 48 08          	mov    %cx,0x8(%eax)
    17ec:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    17f0:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    17f3:	8b 45 08             	mov    0x8(%ebp),%eax
    17f6:	89 c2                	mov    %eax,%edx
    17f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17fb:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    17fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    1800:	89 c2                	mov    %eax,%edx
    1802:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1805:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    1808:	8b 55 10             	mov    0x10(%ebp),%edx
    180b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180e:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "%d %d\n", hdc->size.cx, hdc->size.cy);
    return hdc;
    1811:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1814:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1817:	c9                   	leave  
    1818:	c3                   	ret    

00001819 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    1819:	55                   	push   %ebp
    181a:	89 e5                	mov    %esp,%ebp
    181c:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    181f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1822:	8b 50 08             	mov    0x8(%eax),%edx
    1825:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1828:	8b 40 0c             	mov    0xc(%eax),%eax
    182b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    182e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1831:	8b 55 10             	mov    0x10(%ebp),%edx
    1834:	89 50 08             	mov    %edx,0x8(%eax)
    1837:	8b 55 14             	mov    0x14(%ebp),%edx
    183a:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    183d:	8b 45 08             	mov    0x8(%ebp),%eax
    1840:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1843:	89 10                	mov    %edx,(%eax)
    1845:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1848:	89 50 04             	mov    %edx,0x4(%eax)
}
    184b:	8b 45 08             	mov    0x8(%ebp),%eax
    184e:	c9                   	leave  
    184f:	c2 04 00             	ret    $0x4

00001852 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    1852:	55                   	push   %ebp
    1853:	89 e5                	mov    %esp,%ebp
    1855:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    1858:	8b 45 0c             	mov    0xc(%ebp),%eax
    185b:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    185f:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1863:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1867:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    186a:	8b 45 0c             	mov    0xc(%ebp),%eax
    186d:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1871:	66 89 50 10          	mov    %dx,0x10(%eax)
    1875:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1879:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    187c:	8b 45 08             	mov    0x8(%ebp),%eax
    187f:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1883:	66 89 10             	mov    %dx,(%eax)
    1886:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    188a:	88 50 02             	mov    %dl,0x2(%eax)
}
    188d:	8b 45 08             	mov    0x8(%ebp),%eax
    1890:	c9                   	leave  
    1891:	c2 04 00             	ret    $0x4

00001894 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    1894:	55                   	push   %ebp
    1895:	89 e5                	mov    %esp,%ebp
    1897:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    189a:	8b 45 08             	mov    0x8(%ebp),%eax
    189d:	8b 40 0c             	mov    0xc(%eax),%eax
    18a0:	89 c2                	mov    %eax,%edx
    18a2:	c1 ea 1f             	shr    $0x1f,%edx
    18a5:	01 d0                	add    %edx,%eax
    18a7:	d1 f8                	sar    %eax
    18a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    18ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18af:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    18b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    18b6:	8b 45 10             	mov    0x10(%ebp),%eax
    18b9:	2b 45 f4             	sub    -0xc(%ebp),%eax
    18bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    18bf:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    18c3:	0f 89 98 00 00 00    	jns    1961 <APDrawPoint+0xcd>
        i = 0;
    18c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    18d0:	e9 8c 00 00 00       	jmp    1961 <APDrawPoint+0xcd>
    {
        j = x - off;
    18d5:	8b 45 0c             	mov    0xc(%ebp),%eax
    18d8:	2b 45 f4             	sub    -0xc(%ebp),%eax
    18db:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    18de:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    18e2:	79 69                	jns    194d <APDrawPoint+0xb9>
            j = 0;
    18e4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    18eb:	eb 60                	jmp    194d <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    18ed:	ff 75 fc             	pushl  -0x4(%ebp)
    18f0:	ff 75 f8             	pushl  -0x8(%ebp)
    18f3:	ff 75 08             	pushl  0x8(%ebp)
    18f6:	e8 ad fb ff ff       	call   14a8 <APGetIndex>
    18fb:	83 c4 0c             	add    $0xc,%esp
    18fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    1901:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    1905:	74 55                	je     195c <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    1907:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    190b:	74 67                	je     1974 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    190d:	ff 75 10             	pushl  0x10(%ebp)
    1910:	ff 75 0c             	pushl  0xc(%ebp)
    1913:	ff 75 fc             	pushl  -0x4(%ebp)
    1916:	ff 75 f8             	pushl  -0x8(%ebp)
    1919:	e8 51 fb ff ff       	call   146f <distance_2>
    191e:	83 c4 10             	add    $0x10,%esp
    1921:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1924:	7f 23                	jg     1949 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    1926:	8b 45 08             	mov    0x8(%ebp),%eax
    1929:	8b 48 18             	mov    0x18(%eax),%ecx
    192c:	8b 55 ec             	mov    -0x14(%ebp),%edx
    192f:	89 d0                	mov    %edx,%eax
    1931:	01 c0                	add    %eax,%eax
    1933:	01 d0                	add    %edx,%eax
    1935:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1938:	8b 45 08             	mov    0x8(%ebp),%eax
    193b:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    193f:	66 89 0a             	mov    %cx,(%edx)
    1942:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1946:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1949:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    194d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1950:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1953:	01 d0                	add    %edx,%eax
    1955:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1958:	7d 93                	jge    18ed <APDrawPoint+0x59>
    195a:	eb 01                	jmp    195d <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    195c:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    195d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1961:	8b 55 10             	mov    0x10(%ebp),%edx
    1964:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1967:	01 d0                	add    %edx,%eax
    1969:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    196c:	0f 8d 63 ff ff ff    	jge    18d5 <APDrawPoint+0x41>
    1972:	eb 01                	jmp    1975 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1974:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    1975:	c9                   	leave  
    1976:	c3                   	ret    

00001977 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1977:	55                   	push   %ebp
    1978:	89 e5                	mov    %esp,%ebp
    197a:	53                   	push   %ebx
    197b:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    197e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1981:	3b 45 14             	cmp    0x14(%ebp),%eax
    1984:	0f 85 80 00 00 00    	jne    1a0a <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    198a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    198e:	0f 88 9d 02 00 00    	js     1c31 <APDrawLine+0x2ba>
    1994:	8b 45 08             	mov    0x8(%ebp),%eax
    1997:	8b 00                	mov    (%eax),%eax
    1999:	3b 45 0c             	cmp    0xc(%ebp),%eax
    199c:	0f 8e 8f 02 00 00    	jle    1c31 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    19a2:	8b 45 10             	mov    0x10(%ebp),%eax
    19a5:	3b 45 18             	cmp    0x18(%ebp),%eax
    19a8:	7e 12                	jle    19bc <APDrawLine+0x45>
        {
            int tmp = y2;
    19aa:	8b 45 18             	mov    0x18(%ebp),%eax
    19ad:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    19b0:	8b 45 10             	mov    0x10(%ebp),%eax
    19b3:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    19b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
    19b9:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    19bc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    19c0:	79 07                	jns    19c9 <APDrawLine+0x52>
    19c2:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    19c9:	8b 45 08             	mov    0x8(%ebp),%eax
    19cc:	8b 40 04             	mov    0x4(%eax),%eax
    19cf:	3b 45 18             	cmp    0x18(%ebp),%eax
    19d2:	7d 0c                	jge    19e0 <APDrawLine+0x69>
    19d4:	8b 45 08             	mov    0x8(%ebp),%eax
    19d7:	8b 40 04             	mov    0x4(%eax),%eax
    19da:	83 e8 01             	sub    $0x1,%eax
    19dd:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    19e0:	8b 45 10             	mov    0x10(%ebp),%eax
    19e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    19e6:	eb 15                	jmp    19fd <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    19e8:	ff 75 f4             	pushl  -0xc(%ebp)
    19eb:	ff 75 0c             	pushl  0xc(%ebp)
    19ee:	ff 75 08             	pushl  0x8(%ebp)
    19f1:	e8 9e fe ff ff       	call   1894 <APDrawPoint>
    19f6:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    19f9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    19fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a00:	3b 45 18             	cmp    0x18(%ebp),%eax
    1a03:	7e e3                	jle    19e8 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    1a05:	e9 2b 02 00 00       	jmp    1c35 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1a0a:	8b 45 10             	mov    0x10(%ebp),%eax
    1a0d:	3b 45 18             	cmp    0x18(%ebp),%eax
    1a10:	75 7f                	jne    1a91 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    1a12:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1a16:	0f 88 18 02 00 00    	js     1c34 <APDrawLine+0x2bd>
    1a1c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1f:	8b 40 04             	mov    0x4(%eax),%eax
    1a22:	3b 45 10             	cmp    0x10(%ebp),%eax
    1a25:	0f 8e 09 02 00 00    	jle    1c34 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1a2b:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a2e:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a31:	7e 12                	jle    1a45 <APDrawLine+0xce>
        {
            int tmp = x2;
    1a33:	8b 45 14             	mov    0x14(%ebp),%eax
    1a36:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1a39:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a3c:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1a3f:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a42:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    1a45:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1a49:	79 07                	jns    1a52 <APDrawLine+0xdb>
    1a4b:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1a52:	8b 45 08             	mov    0x8(%ebp),%eax
    1a55:	8b 00                	mov    (%eax),%eax
    1a57:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a5a:	7d 0b                	jge    1a67 <APDrawLine+0xf0>
    1a5c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5f:	8b 00                	mov    (%eax),%eax
    1a61:	83 e8 01             	sub    $0x1,%eax
    1a64:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1a67:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a6d:	eb 15                	jmp    1a84 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1a6f:	ff 75 10             	pushl  0x10(%ebp)
    1a72:	ff 75 f0             	pushl  -0x10(%ebp)
    1a75:	ff 75 08             	pushl  0x8(%ebp)
    1a78:	e8 17 fe ff ff       	call   1894 <APDrawPoint>
    1a7d:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1a80:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1a84:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a87:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a8a:	7e e3                	jle    1a6f <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1a8c:	e9 a4 01 00 00       	jmp    1c35 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1a91:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1a98:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1a9f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1aa2:	2b 45 14             	sub    0x14(%ebp),%eax
    1aa5:	50                   	push   %eax
    1aa6:	e8 ed f9 ff ff       	call   1498 <abs_int>
    1aab:	83 c4 04             	add    $0x4,%esp
    1aae:	89 c3                	mov    %eax,%ebx
    1ab0:	8b 45 10             	mov    0x10(%ebp),%eax
    1ab3:	2b 45 18             	sub    0x18(%ebp),%eax
    1ab6:	50                   	push   %eax
    1ab7:	e8 dc f9 ff ff       	call   1498 <abs_int>
    1abc:	83 c4 04             	add    $0x4,%esp
    1abf:	39 c3                	cmp    %eax,%ebx
    1ac1:	0f 8e b5 00 00 00    	jle    1b7c <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1ac7:	8b 45 10             	mov    0x10(%ebp),%eax
    1aca:	2b 45 18             	sub    0x18(%ebp),%eax
    1acd:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1ad0:	db 45 b0             	fildl  -0x50(%ebp)
    1ad3:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ad6:	2b 45 14             	sub    0x14(%ebp),%eax
    1ad9:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1adc:	db 45 b0             	fildl  -0x50(%ebp)
    1adf:	de f9                	fdivrp %st,%st(1)
    1ae1:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1ae4:	8b 45 14             	mov    0x14(%ebp),%eax
    1ae7:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1aea:	7e 0e                	jle    1afa <APDrawLine+0x183>
        {
            s = x1;
    1aec:	8b 45 0c             	mov    0xc(%ebp),%eax
    1aef:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    1af2:	8b 45 14             	mov    0x14(%ebp),%eax
    1af5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1af8:	eb 0c                	jmp    1b06 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1afa:	8b 45 14             	mov    0x14(%ebp),%eax
    1afd:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1b00:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b03:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1b06:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b0a:	79 07                	jns    1b13 <APDrawLine+0x19c>
    1b0c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1b13:	8b 45 08             	mov    0x8(%ebp),%eax
    1b16:	8b 00                	mov    (%eax),%eax
    1b18:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1b1b:	7f 0b                	jg     1b28 <APDrawLine+0x1b1>
    1b1d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b20:	8b 00                	mov    (%eax),%eax
    1b22:	83 e8 01             	sub    $0x1,%eax
    1b25:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1b28:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b2b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1b2e:	eb 3f                	jmp    1b6f <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1b30:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b33:	2b 45 0c             	sub    0xc(%ebp),%eax
    1b36:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1b39:	db 45 b0             	fildl  -0x50(%ebp)
    1b3c:	dc 4d d0             	fmull  -0x30(%ebp)
    1b3f:	db 45 10             	fildl  0x10(%ebp)
    1b42:	de c1                	faddp  %st,%st(1)
    1b44:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1b47:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1b4b:	b4 0c                	mov    $0xc,%ah
    1b4d:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1b51:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1b54:	db 5d cc             	fistpl -0x34(%ebp)
    1b57:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1b5a:	ff 75 cc             	pushl  -0x34(%ebp)
    1b5d:	ff 75 e4             	pushl  -0x1c(%ebp)
    1b60:	ff 75 08             	pushl  0x8(%ebp)
    1b63:	e8 2c fd ff ff       	call   1894 <APDrawPoint>
    1b68:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1b6b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1b6f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b72:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1b75:	7e b9                	jle    1b30 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1b77:	e9 b9 00 00 00       	jmp    1c35 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1b7c:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b7f:	2b 45 14             	sub    0x14(%ebp),%eax
    1b82:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1b85:	db 45 b0             	fildl  -0x50(%ebp)
    1b88:	8b 45 10             	mov    0x10(%ebp),%eax
    1b8b:	2b 45 18             	sub    0x18(%ebp),%eax
    1b8e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1b91:	db 45 b0             	fildl  -0x50(%ebp)
    1b94:	de f9                	fdivrp %st,%st(1)
    1b96:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1b99:	8b 45 10             	mov    0x10(%ebp),%eax
    1b9c:	3b 45 18             	cmp    0x18(%ebp),%eax
    1b9f:	7e 0e                	jle    1baf <APDrawLine+0x238>
    {
        s = y2;
    1ba1:	8b 45 18             	mov    0x18(%ebp),%eax
    1ba4:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1ba7:	8b 45 10             	mov    0x10(%ebp),%eax
    1baa:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1bad:	eb 0c                	jmp    1bbb <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1baf:	8b 45 10             	mov    0x10(%ebp),%eax
    1bb2:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1bb5:	8b 45 18             	mov    0x18(%ebp),%eax
    1bb8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1bbb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1bbf:	79 07                	jns    1bc8 <APDrawLine+0x251>
    1bc1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1bc8:	8b 45 08             	mov    0x8(%ebp),%eax
    1bcb:	8b 40 04             	mov    0x4(%eax),%eax
    1bce:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1bd1:	7f 0c                	jg     1bdf <APDrawLine+0x268>
    1bd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd6:	8b 40 04             	mov    0x4(%eax),%eax
    1bd9:	83 e8 01             	sub    $0x1,%eax
    1bdc:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1bdf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1be2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1be5:	eb 3f                	jmp    1c26 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1be7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bea:	2b 45 10             	sub    0x10(%ebp),%eax
    1bed:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1bf0:	db 45 b0             	fildl  -0x50(%ebp)
    1bf3:	dc 4d c0             	fmull  -0x40(%ebp)
    1bf6:	db 45 0c             	fildl  0xc(%ebp)
    1bf9:	de c1                	faddp  %st,%st(1)
    1bfb:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1bfe:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1c02:	b4 0c                	mov    $0xc,%ah
    1c04:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1c08:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1c0b:	db 5d bc             	fistpl -0x44(%ebp)
    1c0e:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1c11:	ff 75 e0             	pushl  -0x20(%ebp)
    1c14:	ff 75 bc             	pushl  -0x44(%ebp)
    1c17:	ff 75 08             	pushl  0x8(%ebp)
    1c1a:	e8 75 fc ff ff       	call   1894 <APDrawPoint>
    1c1f:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1c22:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1c26:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c29:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1c2c:	7e b9                	jle    1be7 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1c2e:	90                   	nop
    1c2f:	eb 04                	jmp    1c35 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1c31:	90                   	nop
    1c32:	eb 01                	jmp    1c35 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1c34:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1c35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1c38:	c9                   	leave  
    1c39:	c3                   	ret    

00001c3a <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1c3a:	55                   	push   %ebp
    1c3b:	89 e5                	mov    %esp,%ebp
    1c3d:	53                   	push   %ebx
    1c3e:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1c41:	8b 55 10             	mov    0x10(%ebp),%edx
    1c44:	8b 45 18             	mov    0x18(%ebp),%eax
    1c47:	01 d0                	add    %edx,%eax
    1c49:	83 e8 01             	sub    $0x1,%eax
    1c4c:	83 ec 04             	sub    $0x4,%esp
    1c4f:	50                   	push   %eax
    1c50:	ff 75 0c             	pushl  0xc(%ebp)
    1c53:	ff 75 10             	pushl  0x10(%ebp)
    1c56:	ff 75 0c             	pushl  0xc(%ebp)
    1c59:	ff 75 08             	pushl  0x8(%ebp)
    1c5c:	e8 16 fd ff ff       	call   1977 <APDrawLine>
    1c61:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1c64:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c67:	8b 45 14             	mov    0x14(%ebp),%eax
    1c6a:	01 d0                	add    %edx,%eax
    1c6c:	83 e8 01             	sub    $0x1,%eax
    1c6f:	83 ec 04             	sub    $0x4,%esp
    1c72:	ff 75 10             	pushl  0x10(%ebp)
    1c75:	50                   	push   %eax
    1c76:	ff 75 10             	pushl  0x10(%ebp)
    1c79:	ff 75 0c             	pushl  0xc(%ebp)
    1c7c:	ff 75 08             	pushl  0x8(%ebp)
    1c7f:	e8 f3 fc ff ff       	call   1977 <APDrawLine>
    1c84:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1c87:	8b 55 10             	mov    0x10(%ebp),%edx
    1c8a:	8b 45 18             	mov    0x18(%ebp),%eax
    1c8d:	01 d0                	add    %edx,%eax
    1c8f:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1c92:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c95:	8b 45 14             	mov    0x14(%ebp),%eax
    1c98:	01 d0                	add    %edx,%eax
    1c9a:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c9d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1ca0:	8b 45 14             	mov    0x14(%ebp),%eax
    1ca3:	01 d8                	add    %ebx,%eax
    1ca5:	83 e8 01             	sub    $0x1,%eax
    1ca8:	83 ec 04             	sub    $0x4,%esp
    1cab:	51                   	push   %ecx
    1cac:	52                   	push   %edx
    1cad:	ff 75 10             	pushl  0x10(%ebp)
    1cb0:	50                   	push   %eax
    1cb1:	ff 75 08             	pushl  0x8(%ebp)
    1cb4:	e8 be fc ff ff       	call   1977 <APDrawLine>
    1cb9:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1cbc:	8b 55 10             	mov    0x10(%ebp),%edx
    1cbf:	8b 45 18             	mov    0x18(%ebp),%eax
    1cc2:	01 d0                	add    %edx,%eax
    1cc4:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1cc7:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cca:	8b 45 14             	mov    0x14(%ebp),%eax
    1ccd:	01 d0                	add    %edx,%eax
    1ccf:	8d 50 ff             	lea    -0x1(%eax),%edx
    1cd2:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1cd5:	8b 45 18             	mov    0x18(%ebp),%eax
    1cd8:	01 d8                	add    %ebx,%eax
    1cda:	83 e8 01             	sub    $0x1,%eax
    1cdd:	83 ec 04             	sub    $0x4,%esp
    1ce0:	51                   	push   %ecx
    1ce1:	52                   	push   %edx
    1ce2:	50                   	push   %eax
    1ce3:	ff 75 0c             	pushl  0xc(%ebp)
    1ce6:	ff 75 08             	pushl  0x8(%ebp)
    1ce9:	e8 89 fc ff ff       	call   1977 <APDrawLine>
    1cee:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1cf1:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cf4:	8b 45 14             	mov    0x14(%ebp),%eax
    1cf7:	01 d0                	add    %edx,%eax
    1cf9:	8d 50 ff             	lea    -0x1(%eax),%edx
    1cfc:	8b 45 08             	mov    0x8(%ebp),%eax
    1cff:	8b 40 0c             	mov    0xc(%eax),%eax
    1d02:	89 c1                	mov    %eax,%ecx
    1d04:	c1 e9 1f             	shr    $0x1f,%ecx
    1d07:	01 c8                	add    %ecx,%eax
    1d09:	d1 f8                	sar    %eax
    1d0b:	29 c2                	sub    %eax,%edx
    1d0d:	89 d0                	mov    %edx,%eax
    1d0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1d12:	8b 55 10             	mov    0x10(%ebp),%edx
    1d15:	8b 45 18             	mov    0x18(%ebp),%eax
    1d18:	01 d0                	add    %edx,%eax
    1d1a:	8d 50 ff             	lea    -0x1(%eax),%edx
    1d1d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d20:	8b 40 0c             	mov    0xc(%eax),%eax
    1d23:	89 c1                	mov    %eax,%ecx
    1d25:	c1 e9 1f             	shr    $0x1f,%ecx
    1d28:	01 c8                	add    %ecx,%eax
    1d2a:	d1 f8                	sar    %eax
    1d2c:	29 c2                	sub    %eax,%edx
    1d2e:	89 d0                	mov    %edx,%eax
    1d30:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1d33:	8b 45 08             	mov    0x8(%ebp),%eax
    1d36:	8b 40 0c             	mov    0xc(%eax),%eax
    1d39:	89 c2                	mov    %eax,%edx
    1d3b:	c1 ea 1f             	shr    $0x1f,%edx
    1d3e:	01 d0                	add    %edx,%eax
    1d40:	d1 f8                	sar    %eax
    1d42:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1d45:	8b 45 08             	mov    0x8(%ebp),%eax
    1d48:	8b 40 0c             	mov    0xc(%eax),%eax
    1d4b:	89 c2                	mov    %eax,%edx
    1d4d:	c1 ea 1f             	shr    $0x1f,%edx
    1d50:	01 d0                	add    %edx,%eax
    1d52:	d1 f8                	sar    %eax
    1d54:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1d57:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d5b:	0f 88 d8 00 00 00    	js     1e39 <APDrawRect+0x1ff>
    1d61:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d65:	0f 88 ce 00 00 00    	js     1e39 <APDrawRect+0x1ff>
    1d6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d6e:	8b 00                	mov    (%eax),%eax
    1d70:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1d73:	0f 8e c0 00 00 00    	jle    1e39 <APDrawRect+0x1ff>
    1d79:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7c:	8b 40 04             	mov    0x4(%eax),%eax
    1d7f:	3b 45 10             	cmp    0x10(%ebp),%eax
    1d82:	0f 8e b1 00 00 00    	jle    1e39 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1d88:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1d8c:	79 07                	jns    1d95 <APDrawRect+0x15b>
    1d8e:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1d95:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1d99:	79 07                	jns    1da2 <APDrawRect+0x168>
    1d9b:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1da2:	8b 45 08             	mov    0x8(%ebp),%eax
    1da5:	8b 00                	mov    (%eax),%eax
    1da7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1daa:	7f 0b                	jg     1db7 <APDrawRect+0x17d>
    1dac:	8b 45 08             	mov    0x8(%ebp),%eax
    1daf:	8b 00                	mov    (%eax),%eax
    1db1:	83 e8 01             	sub    $0x1,%eax
    1db4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1db7:	8b 45 08             	mov    0x8(%ebp),%eax
    1dba:	8b 40 04             	mov    0x4(%eax),%eax
    1dbd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1dc0:	7f 0c                	jg     1dce <APDrawRect+0x194>
    1dc2:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc5:	8b 40 04             	mov    0x4(%eax),%eax
    1dc8:	83 e8 01             	sub    $0x1,%eax
    1dcb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1dce:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1dd5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1dd8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1ddb:	eb 52                	jmp    1e2f <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1ddd:	8b 45 10             	mov    0x10(%ebp),%eax
    1de0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1de3:	eb 3e                	jmp    1e23 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1de5:	83 ec 04             	sub    $0x4,%esp
    1de8:	ff 75 e8             	pushl  -0x18(%ebp)
    1deb:	ff 75 ec             	pushl  -0x14(%ebp)
    1dee:	ff 75 08             	pushl  0x8(%ebp)
    1df1:	e8 b2 f6 ff ff       	call   14a8 <APGetIndex>
    1df6:	83 c4 10             	add    $0x10,%esp
    1df9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1dfc:	8b 45 08             	mov    0x8(%ebp),%eax
    1dff:	8b 48 18             	mov    0x18(%eax),%ecx
    1e02:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1e05:	89 d0                	mov    %edx,%eax
    1e07:	01 c0                	add    %eax,%eax
    1e09:	01 d0                	add    %edx,%eax
    1e0b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1e0e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e11:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1e15:	66 89 0a             	mov    %cx,(%edx)
    1e18:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1e1c:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1e1f:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1e23:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1e26:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1e29:	7e ba                	jle    1de5 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1e2b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1e2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e32:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1e35:	7e a6                	jle    1ddd <APDrawRect+0x1a3>
    1e37:	eb 01                	jmp    1e3a <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1e39:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1e3a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1e3d:	c9                   	leave  
    1e3e:	c3                   	ret    

00001e3f <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1e3f:	55                   	push   %ebp
    1e40:	89 e5                	mov    %esp,%ebp
    1e42:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1e45:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1e49:	0f 88 8e 01 00 00    	js     1fdd <APDcCopy+0x19e>
    1e4f:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1e53:	0f 88 84 01 00 00    	js     1fdd <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1e59:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e5c:	8b 45 20             	mov    0x20(%ebp),%eax
    1e5f:	01 d0                	add    %edx,%eax
    1e61:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1e64:	8b 55 10             	mov    0x10(%ebp),%edx
    1e67:	8b 45 24             	mov    0x24(%ebp),%eax
    1e6a:	01 d0                	add    %edx,%eax
    1e6c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w, y_r = y + h;
    1e6f:	8b 55 18             	mov    0x18(%ebp),%edx
    1e72:	8b 45 20             	mov    0x20(%ebp),%eax
    1e75:	01 d0                	add    %edx,%eax
    1e77:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1e7a:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1e7d:	8b 45 24             	mov    0x24(%ebp),%eax
    1e80:	01 d0                	add    %edx,%eax
    1e82:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
    1e85:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1e89:	0f 88 51 01 00 00    	js     1fe0 <APDcCopy+0x1a1>
    1e8f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e93:	0f 88 47 01 00 00    	js     1fe0 <APDcCopy+0x1a1>
    1e99:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1e9d:	0f 88 3d 01 00 00    	js     1fe0 <APDcCopy+0x1a1>
    1ea3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1ea7:	0f 88 33 01 00 00    	js     1fe0 <APDcCopy+0x1a1>
    1ead:	8b 45 14             	mov    0x14(%ebp),%eax
    1eb0:	8b 00                	mov    (%eax),%eax
    1eb2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1eb5:	0f 8e 25 01 00 00    	jle    1fe0 <APDcCopy+0x1a1>
    1ebb:	8b 45 14             	mov    0x14(%ebp),%eax
    1ebe:	8b 40 04             	mov    0x4(%eax),%eax
    1ec1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1ec4:	0f 8e 16 01 00 00    	jle    1fe0 <APDcCopy+0x1a1>
        return;
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    1eca:	8b 45 08             	mov    0x8(%ebp),%eax
    1ecd:	8b 00                	mov    (%eax),%eax
    1ecf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1ed2:	7d 0b                	jge    1edf <APDcCopy+0xa0>
    1ed4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ed7:	8b 00                	mov    (%eax),%eax
    1ed9:	83 e8 01             	sub    $0x1,%eax
    1edc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    1edf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee2:	8b 40 04             	mov    0x4(%eax),%eax
    1ee5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1ee8:	7d 0c                	jge    1ef6 <APDcCopy+0xb7>
    1eea:	8b 45 08             	mov    0x8(%ebp),%eax
    1eed:	8b 40 04             	mov    0x4(%eax),%eax
    1ef0:	83 e8 01             	sub    $0x1,%eax
    1ef3:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1ef6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1efd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j < wy_r - wy; j++)
    1f04:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1f0b:	e9 bc 00 00 00       	jmp    1fcc <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1f10:	8b 45 08             	mov    0x8(%ebp),%eax
    1f13:	8b 00                	mov    (%eax),%eax
    1f15:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1f18:	8b 55 10             	mov    0x10(%ebp),%edx
    1f1b:	01 ca                	add    %ecx,%edx
    1f1d:	0f af d0             	imul   %eax,%edx
    1f20:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f23:	01 d0                	add    %edx,%eax
    1f25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1f28:	8b 45 14             	mov    0x14(%ebp),%eax
    1f2b:	8b 00                	mov    (%eax),%eax
    1f2d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1f30:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1f33:	01 ca                	add    %ecx,%edx
    1f35:	0f af d0             	imul   %eax,%edx
    1f38:	8b 45 18             	mov    0x18(%ebp),%eax
    1f3b:	01 d0                	add    %edx,%eax
    1f3d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i < wx_r - wx; i++)
    1f40:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1f47:	eb 74                	jmp    1fbd <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1f49:	8b 45 14             	mov    0x14(%ebp),%eax
    1f4c:	8b 50 18             	mov    0x18(%eax),%edx
    1f4f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1f52:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f55:	01 c8                	add    %ecx,%eax
    1f57:	89 c1                	mov    %eax,%ecx
    1f59:	89 c8                	mov    %ecx,%eax
    1f5b:	01 c0                	add    %eax,%eax
    1f5d:	01 c8                	add    %ecx,%eax
    1f5f:	01 d0                	add    %edx,%eax
    1f61:	0f b7 10             	movzwl (%eax),%edx
    1f64:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1f68:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1f6c:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1f6f:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1f73:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1f77:	38 c2                	cmp    %al,%dl
    1f79:	75 18                	jne    1f93 <APDcCopy+0x154>
    1f7b:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1f7f:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1f83:	38 c2                	cmp    %al,%dl
    1f85:	75 0c                	jne    1f93 <APDcCopy+0x154>
    1f87:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1f8b:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1f8f:	38 c2                	cmp    %al,%dl
    1f91:	74 26                	je     1fb9 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1f93:	8b 45 08             	mov    0x8(%ebp),%eax
    1f96:	8b 50 18             	mov    0x18(%eax),%edx
    1f99:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1f9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f9f:	01 c8                	add    %ecx,%eax
    1fa1:	89 c1                	mov    %eax,%ecx
    1fa3:	89 c8                	mov    %ecx,%eax
    1fa5:	01 c0                	add    %eax,%eax
    1fa7:	01 c8                	add    %ecx,%eax
    1fa9:	01 d0                	add    %edx,%eax
    1fab:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1faf:	66 89 10             	mov    %dx,(%eax)
    1fb2:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1fb6:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i < wx_r - wx; i++)
    1fb9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1fbd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1fc0:	2b 45 0c             	sub    0xc(%ebp),%eax
    1fc3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1fc6:	7f 81                	jg     1f49 <APDcCopy+0x10a>
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    1fc8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1fcc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fcf:	2b 45 10             	sub    0x10(%ebp),%eax
    1fd2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1fd5:	0f 8f 35 ff ff ff    	jg     1f10 <APDcCopy+0xd1>
    1fdb:	eb 04                	jmp    1fe1 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1fdd:	90                   	nop
    1fde:	eb 01                	jmp    1fe1 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w, y_r = y + h;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
        return;
    1fe0:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1fe1:	c9                   	leave  
    1fe2:	c3                   	ret    

00001fe3 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1fe3:	55                   	push   %ebp
    1fe4:	89 e5                	mov    %esp,%ebp
    1fe6:	83 ec 1c             	sub    $0x1c,%esp
    1fe9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1fec:	8b 55 10             	mov    0x10(%ebp),%edx
    1fef:	8b 45 14             	mov    0x14(%ebp),%eax
    1ff2:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1ff5:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1ff8:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1ffb:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1fff:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    2002:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    2006:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    2009:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    200d:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    2010:	8b 45 08             	mov    0x8(%ebp),%eax
    2013:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    2017:	66 89 10             	mov    %dx,(%eax)
    201a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    201e:	88 50 02             	mov    %dl,0x2(%eax)
}
    2021:	8b 45 08             	mov    0x8(%ebp),%eax
    2024:	c9                   	leave  
    2025:	c2 04 00             	ret    $0x4

00002028 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    2028:	55                   	push   %ebp
    2029:	89 e5                	mov    %esp,%ebp
    202b:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    202e:	8b 45 08             	mov    0x8(%ebp),%eax
    2031:	8b 00                	mov    (%eax),%eax
    2033:	83 ec 08             	sub    $0x8,%esp
    2036:	8d 55 0c             	lea    0xc(%ebp),%edx
    2039:	52                   	push   %edx
    203a:	50                   	push   %eax
    203b:	e8 45 ef ff ff       	call   f85 <sendMessage>
    2040:	83 c4 10             	add    $0x10,%esp
}
    2043:	90                   	nop
    2044:	c9                   	leave  
    2045:	c3                   	ret    

00002046 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    2046:	55                   	push   %ebp
    2047:	89 e5                	mov    %esp,%ebp
    2049:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    204c:	83 ec 0c             	sub    $0xc,%esp
    204f:	68 90 00 00 00       	push   $0x90
    2054:	e8 ee f2 ff ff       	call   1347 <malloc>
    2059:	83 c4 10             	add    $0x10,%esp
    205c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    205f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2063:	75 15                	jne    207a <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    2065:	83 ec 04             	sub    $0x4,%esp
    2068:	ff 75 08             	pushl  0x8(%ebp)
    206b:	68 f4 2b 00 00       	push   $0x2bf4
    2070:	6a 01                	push   $0x1
    2072:	e8 fd ef ff ff       	call   1074 <printf>
    2077:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    207a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    207d:	83 c0 7c             	add    $0x7c,%eax
    2080:	83 ec 08             	sub    $0x8,%esp
    2083:	ff 75 08             	pushl  0x8(%ebp)
    2086:	50                   	push   %eax
    2087:	e8 18 ec ff ff       	call   ca4 <strcpy>
    208c:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    208f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2092:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    2099:	8b 45 f4             	mov    -0xc(%ebp),%eax
    209c:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    20a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20a6:	8b 40 34             	mov    0x34(%eax),%eax
    20a9:	89 c2                	mov    %eax,%edx
    20ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20ae:	8b 40 38             	mov    0x38(%eax),%eax
    20b1:	0f af d0             	imul   %eax,%edx
    20b4:	89 d0                	mov    %edx,%eax
    20b6:	01 c0                	add    %eax,%eax
    20b8:	01 d0                	add    %edx,%eax
    20ba:	83 ec 0c             	sub    $0xc,%esp
    20bd:	50                   	push   %eax
    20be:	e8 84 f2 ff ff       	call   1347 <malloc>
    20c3:	83 c4 10             	add    $0x10,%esp
    20c6:	89 c2                	mov    %eax,%edx
    20c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20cb:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    20ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20d1:	8b 40 4c             	mov    0x4c(%eax),%eax
    20d4:	85 c0                	test   %eax,%eax
    20d6:	75 15                	jne    20ed <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    20d8:	83 ec 04             	sub    $0x4,%esp
    20db:	ff 75 08             	pushl  0x8(%ebp)
    20de:	68 14 2c 00 00       	push   $0x2c14
    20e3:	6a 01                	push   $0x1
    20e5:	e8 8a ef ff ff       	call   1074 <printf>
    20ea:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    20ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20f0:	8b 40 34             	mov    0x34(%eax),%eax
    20f3:	89 c2                	mov    %eax,%edx
    20f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20f8:	8b 40 38             	mov    0x38(%eax),%eax
    20fb:	0f af d0             	imul   %eax,%edx
    20fe:	89 d0                	mov    %edx,%eax
    2100:	01 c0                	add    %eax,%eax
    2102:	01 c2                	add    %eax,%edx
    2104:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2107:	8b 40 4c             	mov    0x4c(%eax),%eax
    210a:	83 ec 04             	sub    $0x4,%esp
    210d:	52                   	push   %edx
    210e:	68 ff ff ff 00       	push   $0xffffff
    2113:	50                   	push   %eax
    2114:	e8 21 ec ff ff       	call   d3a <memset>
    2119:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    211c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    211f:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    2126:	e8 2a ee ff ff       	call   f55 <getpid>
    212b:	89 c2                	mov    %eax,%edx
    212d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2130:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    2133:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2136:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    213d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2140:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    2147:	8b 45 f4             	mov    -0xc(%ebp),%eax
    214a:	8b 40 50             	mov    0x50(%eax),%eax
    214d:	89 c2                	mov    %eax,%edx
    214f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2152:	8b 40 54             	mov    0x54(%eax),%eax
    2155:	0f af d0             	imul   %eax,%edx
    2158:	89 d0                	mov    %edx,%eax
    215a:	01 c0                	add    %eax,%eax
    215c:	01 d0                	add    %edx,%eax
    215e:	83 ec 0c             	sub    $0xc,%esp
    2161:	50                   	push   %eax
    2162:	e8 e0 f1 ff ff       	call   1347 <malloc>
    2167:	83 c4 10             	add    $0x10,%esp
    216a:	89 c2                	mov    %eax,%edx
    216c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    216f:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    2172:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2175:	8b 40 68             	mov    0x68(%eax),%eax
    2178:	85 c0                	test   %eax,%eax
    217a:	75 15                	jne    2191 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    217c:	83 ec 04             	sub    $0x4,%esp
    217f:	ff 75 08             	pushl  0x8(%ebp)
    2182:	68 38 2c 00 00       	push   $0x2c38
    2187:	6a 01                	push   $0x1
    2189:	e8 e6 ee ff ff       	call   1074 <printf>
    218e:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    2191:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2194:	8b 40 34             	mov    0x34(%eax),%eax
    2197:	89 c2                	mov    %eax,%edx
    2199:	8b 45 f4             	mov    -0xc(%ebp),%eax
    219c:	8b 40 38             	mov    0x38(%eax),%eax
    219f:	0f af d0             	imul   %eax,%edx
    21a2:	89 d0                	mov    %edx,%eax
    21a4:	01 c0                	add    %eax,%eax
    21a6:	01 c2                	add    %eax,%edx
    21a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21ab:	8b 40 4c             	mov    0x4c(%eax),%eax
    21ae:	83 ec 04             	sub    $0x4,%esp
    21b1:	52                   	push   %edx
    21b2:	68 ff 00 00 00       	push   $0xff
    21b7:	50                   	push   %eax
    21b8:	e8 7d eb ff ff       	call   d3a <memset>
    21bd:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    21c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21c3:	8b 55 0c             	mov    0xc(%ebp),%edx
    21c6:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    21c9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    21cd:	74 35                	je     2204 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    21cf:	8b 45 10             	mov    0x10(%ebp),%eax
    21d2:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    21d8:	83 ec 0c             	sub    $0xc,%esp
    21db:	50                   	push   %eax
    21dc:	e8 66 f1 ff ff       	call   1347 <malloc>
    21e1:	83 c4 10             	add    $0x10,%esp
    21e4:	89 c2                	mov    %eax,%edx
    21e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21e9:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    21ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21ef:	8b 55 10             	mov    0x10(%ebp),%edx
    21f2:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    21f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21f8:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    21ff:	e9 8d 00 00 00       	jmp    2291 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    2204:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2207:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    220e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2211:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    2218:	8b 45 f4             	mov    -0xc(%ebp),%eax
    221b:	8b 40 18             	mov    0x18(%eax),%eax
    221e:	89 c2                	mov    %eax,%edx
    2220:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2223:	8b 40 1c             	mov    0x1c(%eax),%eax
    2226:	0f af d0             	imul   %eax,%edx
    2229:	89 d0                	mov    %edx,%eax
    222b:	01 c0                	add    %eax,%eax
    222d:	01 d0                	add    %edx,%eax
    222f:	83 ec 0c             	sub    $0xc,%esp
    2232:	50                   	push   %eax
    2233:	e8 0f f1 ff ff       	call   1347 <malloc>
    2238:	83 c4 10             	add    $0x10,%esp
    223b:	89 c2                	mov    %eax,%edx
    223d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2240:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    2243:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2246:	8b 40 30             	mov    0x30(%eax),%eax
    2249:	85 c0                	test   %eax,%eax
    224b:	75 15                	jne    2262 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    224d:	83 ec 04             	sub    $0x4,%esp
    2250:	ff 75 08             	pushl  0x8(%ebp)
    2253:	68 60 2c 00 00       	push   $0x2c60
    2258:	6a 01                	push   $0x1
    225a:	e8 15 ee ff ff       	call   1074 <printf>
    225f:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    2262:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2265:	8b 40 18             	mov    0x18(%eax),%eax
    2268:	89 c2                	mov    %eax,%edx
    226a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    226d:	8b 40 1c             	mov    0x1c(%eax),%eax
    2270:	0f af d0             	imul   %eax,%edx
    2273:	89 d0                	mov    %edx,%eax
    2275:	01 c0                	add    %eax,%eax
    2277:	01 c2                	add    %eax,%edx
    2279:	8b 45 f4             	mov    -0xc(%ebp),%eax
    227c:	8b 40 30             	mov    0x30(%eax),%eax
    227f:	83 ec 04             	sub    $0x4,%esp
    2282:	52                   	push   %edx
    2283:	68 ff ff ff 00       	push   $0xffffff
    2288:	50                   	push   %eax
    2289:	e8 ac ea ff ff       	call   d3a <memset>
    228e:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    2291:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    2294:	c9                   	leave  
    2295:	c3                   	ret    

00002296 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    2296:	55                   	push   %ebp
    2297:	89 e5                	mov    %esp,%ebp
    2299:	53                   	push   %ebx
    229a:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    229d:	8b 45 0c             	mov    0xc(%ebp),%eax
    22a0:	83 f8 03             	cmp    $0x3,%eax
    22a3:	74 02                	je     22a7 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    22a5:	eb 33                	jmp    22da <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    22a7:	8b 45 08             	mov    0x8(%ebp),%eax
    22aa:	8b 48 08             	mov    0x8(%eax),%ecx
    22ad:	8b 45 08             	mov    0x8(%ebp),%eax
    22b0:	8b 50 38             	mov    0x38(%eax),%edx
    22b3:	8b 45 08             	mov    0x8(%ebp),%eax
    22b6:	8b 40 34             	mov    0x34(%eax),%eax
    22b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
    22bc:	83 c3 34             	add    $0x34,%ebx
    22bf:	83 ec 0c             	sub    $0xc,%esp
    22c2:	51                   	push   %ecx
    22c3:	52                   	push   %edx
    22c4:	50                   	push   %eax
    22c5:	6a 00                	push   $0x0
    22c7:	6a 00                	push   $0x0
    22c9:	53                   	push   %ebx
    22ca:	6a 32                	push   $0x32
    22cc:	6a 00                	push   $0x0
    22ce:	ff 75 08             	pushl  0x8(%ebp)
    22d1:	e8 9f ec ff ff       	call   f75 <paintWindow>
    22d6:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    22d9:	90                   	nop
        default: break;
            
            
    }
    return False;
    22da:	b8 00 00 00 00       	mov    $0x0,%eax
}
    22df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    22e2:	c9                   	leave  
    22e3:	c3                   	ret    

000022e4 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    22e4:	55                   	push   %ebp
    22e5:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    22e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    22ea:	8b 50 08             	mov    0x8(%eax),%edx
    22ed:	8b 45 08             	mov    0x8(%ebp),%eax
    22f0:	8b 00                	mov    (%eax),%eax
    22f2:	39 c2                	cmp    %eax,%edx
    22f4:	74 07                	je     22fd <APPreJudge+0x19>
        return False;
    22f6:	b8 00 00 00 00       	mov    $0x0,%eax
    22fb:	eb 05                	jmp    2302 <APPreJudge+0x1e>
    return True;
    22fd:	b8 01 00 00 00       	mov    $0x1,%eax
}
    2302:	5d                   	pop    %ebp
    2303:	c3                   	ret    

00002304 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    2304:	55                   	push   %ebp
    2305:	89 e5                	mov    %esp,%ebp
    2307:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    230a:	8b 45 08             	mov    0x8(%ebp),%eax
    230d:	8b 55 0c             	mov    0xc(%ebp),%edx
    2310:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    2313:	83 ec 0c             	sub    $0xc,%esp
    2316:	ff 75 08             	pushl  0x8(%ebp)
    2319:	e8 77 ec ff ff       	call   f95 <registWindow>
    231e:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    2321:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    2328:	8b 45 08             	mov    0x8(%ebp),%eax
    232b:	8b 00                	mov    (%eax),%eax
    232d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    2330:	ff 75 f4             	pushl  -0xc(%ebp)
    2333:	ff 75 f0             	pushl  -0x10(%ebp)
    2336:	ff 75 ec             	pushl  -0x14(%ebp)
    2339:	ff 75 08             	pushl  0x8(%ebp)
    233c:	e8 e7 fc ff ff       	call   2028 <APSendMessage>
    2341:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    2344:	83 ec 0c             	sub    $0xc,%esp
    2347:	ff 75 08             	pushl  0x8(%ebp)
    234a:	e8 3e ec ff ff       	call   f8d <getMessage>
    234f:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    2352:	8b 45 08             	mov    0x8(%ebp),%eax
    2355:	83 c0 6c             	add    $0x6c,%eax
    2358:	83 ec 08             	sub    $0x8,%esp
    235b:	50                   	push   %eax
    235c:	ff 75 08             	pushl  0x8(%ebp)
    235f:	e8 80 ff ff ff       	call   22e4 <APPreJudge>
    2364:	83 c4 10             	add    $0x10,%esp
    2367:	84 c0                	test   %al,%al
    2369:	74 1b                	je     2386 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    236b:	8b 45 08             	mov    0x8(%ebp),%eax
    236e:	ff 70 74             	pushl  0x74(%eax)
    2371:	ff 70 70             	pushl  0x70(%eax)
    2374:	ff 70 6c             	pushl  0x6c(%eax)
    2377:	ff 75 08             	pushl  0x8(%ebp)
    237a:	8b 45 0c             	mov    0xc(%ebp),%eax
    237d:	ff d0                	call   *%eax
    237f:	83 c4 10             	add    $0x10,%esp
    2382:	84 c0                	test   %al,%al
    2384:	75 0c                	jne    2392 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    2386:	8b 45 08             	mov    0x8(%ebp),%eax
    2389:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    2390:	eb b2                	jmp    2344 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    2392:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    2393:	90                   	nop
    2394:	c9                   	leave  
    2395:	c3                   	ret    

00002396 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    2396:	55                   	push   %ebp
    2397:	89 e5                	mov    %esp,%ebp
    2399:	57                   	push   %edi
    239a:	56                   	push   %esi
    239b:	53                   	push   %ebx
    239c:	83 ec 4c             	sub    $0x4c,%esp
    if (!iconReady)
    239f:	a1 10 35 00 00       	mov    0x3510,%eax
    23a4:	85 c0                	test   %eax,%eax
    23a6:	75 7c                	jne    2424 <APGridPaint+0x8e>
    {
        iconReady = 1;
    23a8:	c7 05 10 35 00 00 01 	movl   $0x1,0x3510
    23af:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("Snake.bmp");
    23b2:	8d 45 b8             	lea    -0x48(%ebp),%eax
    23b5:	83 ec 08             	sub    $0x8,%esp
    23b8:	68 87 2c 00 00       	push   $0x2c87
    23bd:	50                   	push   %eax
    23be:	e8 37 f1 ff ff       	call   14fa <APLoadBitmap>
    23c3:	83 c4 0c             	add    $0xc,%esp
    23c6:	8b 45 b8             	mov    -0x48(%ebp),%eax
    23c9:	a3 14 35 00 00       	mov    %eax,0x3514
    23ce:	8b 45 bc             	mov    -0x44(%ebp),%eax
    23d1:	a3 18 35 00 00       	mov    %eax,0x3518
    23d6:	8b 45 c0             	mov    -0x40(%ebp),%eax
    23d9:	a3 1c 35 00 00       	mov    %eax,0x351c
        printf(1,"bitmap loaded!\n");
    23de:	83 ec 08             	sub    $0x8,%esp
    23e1:	68 91 2c 00 00       	push   $0x2c91
    23e6:	6a 01                	push   $0x1
    23e8:	e8 87 ec ff ff       	call   1074 <printf>
    23ed:	83 c4 10             	add    $0x10,%esp
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    23f0:	83 ec 04             	sub    $0x4,%esp
    23f3:	ff 35 1c 35 00 00    	pushl  0x351c
    23f9:	ff 35 18 35 00 00    	pushl  0x3518
    23ff:	ff 35 14 35 00 00    	pushl  0x3514
    2405:	e8 7a f3 ff ff       	call   1784 <APCreateCompatibleDCFromBitmap>
    240a:	83 c4 10             	add    $0x10,%esp
    240d:	a3 20 35 00 00       	mov    %eax,0x3520
        printf(1,"bitmap DC created!\n");
    2412:	83 ec 08             	sub    $0x8,%esp
    2415:	68 a1 2c 00 00       	push   $0x2ca1
    241a:	6a 01                	push   $0x1
    241c:	e8 53 ec ff ff       	call   1074 <printf>
    2421:	83 c4 10             	add    $0x10,%esp
    }
    
    if (!wnd->is_grid)
    2424:	8b 45 08             	mov    0x8(%ebp),%eax
    2427:	8b 40 08             	mov    0x8(%eax),%eax
    242a:	85 c0                	test   %eax,%eax
    242c:	75 17                	jne    2445 <APGridPaint+0xaf>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    242e:	83 ec 08             	sub    $0x8,%esp
    2431:	68 b8 2c 00 00       	push   $0x2cb8
    2436:	6a 01                	push   $0x1
    2438:	e8 37 ec ff ff       	call   1074 <printf>
    243d:	83 c4 10             	add    $0x10,%esp
        return;
    2440:	e9 55 03 00 00       	jmp    279a <APGridPaint+0x404>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    2445:	8b 45 08             	mov    0x8(%ebp),%eax
    2448:	8b 40 10             	mov    0x10(%eax),%eax
    244b:	85 c0                	test   %eax,%eax
    244d:	7e 10                	jle    245f <APGridPaint+0xc9>
    244f:	8b 45 08             	mov    0x8(%ebp),%eax
    2452:	8b 50 14             	mov    0x14(%eax),%edx
    2455:	8b 45 08             	mov    0x8(%ebp),%eax
    2458:	8b 40 10             	mov    0x10(%eax),%eax
    245b:	39 c2                	cmp    %eax,%edx
    245d:	7c 17                	jl     2476 <APGridPaint+0xe0>
    {
        printf(1,"Grid mode page error!");
    245f:	83 ec 08             	sub    $0x8,%esp
    2462:	68 de 2c 00 00       	push   $0x2cde
    2467:	6a 01                	push   $0x1
    2469:	e8 06 ec ff ff       	call   1074 <printf>
    246e:	83 c4 10             	add    $0x10,%esp
        return;
    2471:	e9 24 03 00 00       	jmp    279a <APGridPaint+0x404>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    2476:	8b 45 08             	mov    0x8(%ebp),%eax
    2479:	8b 40 14             	mov    0x14(%eax),%eax
    247c:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    2482:	89 45 dc             	mov    %eax,-0x24(%ebp)
    2485:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2488:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    248b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    2492:	e9 f9 02 00 00       	jmp    2790 <APGridPaint+0x3fa>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2497:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    249e:	e9 df 02 00 00       	jmp    2782 <APGridPaint+0x3ec>
        {
            index = start + GRID_W_NUMBER * j + i;
    24a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24a6:	c1 e0 04             	shl    $0x4,%eax
    24a9:	89 c2                	mov    %eax,%edx
    24ab:	8b 45 d8             	mov    -0x28(%ebp),%eax
    24ae:	01 c2                	add    %eax,%edx
    24b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    24b3:	01 d0                	add    %edx,%eax
    24b5:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    24b8:	8b 45 08             	mov    0x8(%ebp),%eax
    24bb:	8b 40 0c             	mov    0xc(%eax),%eax
    24be:	8b 55 dc             	mov    -0x24(%ebp),%edx
    24c1:	c1 e2 02             	shl    $0x2,%edx
    24c4:	01 d0                	add    %edx,%eax
    24c6:	8b 00                	mov    (%eax),%eax
    24c8:	83 f8 01             	cmp    $0x1,%eax
    24cb:	0f 84 83 00 00 00    	je     2554 <APGridPaint+0x1be>
    24d1:	83 f8 01             	cmp    $0x1,%eax
    24d4:	7f 09                	jg     24df <APGridPaint+0x149>
    24d6:	85 c0                	test   %eax,%eax
    24d8:	74 1c                	je     24f6 <APGridPaint+0x160>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    24da:	e9 9f 02 00 00       	jmp    277e <APGridPaint+0x3e8>
        for (int i = 0; i < GRID_W_NUMBER;i++)
        {
            index = start + GRID_W_NUMBER * j + i;
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    24df:	83 f8 02             	cmp    $0x2,%eax
    24e2:	0f 84 20 01 00 00    	je     2608 <APGridPaint+0x272>
    24e8:	83 f8 03             	cmp    $0x3,%eax
    24eb:	0f 84 d1 01 00 00    	je     26c2 <APGridPaint+0x32c>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    24f1:	e9 88 02 00 00       	jmp    277e <APGridPaint+0x3e8>
                    pen.size = 1;
                    brush.color = RGB(0xd2,0x69,0x1e);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);*/
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    24f6:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    24f9:	6a 0c                	push   $0xc
    24fb:	6a 0c                	push   $0xc
    24fd:	6a 0c                	push   $0xc
    24ff:	50                   	push   %eax
    2500:	e8 de fa ff ff       	call   1fe3 <RGB>
    2505:	83 c4 0c             	add    $0xc,%esp
    2508:	8b 1d 20 35 00 00    	mov    0x3520,%ebx
    250e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2511:	6b c8 32             	imul   $0x32,%eax,%ecx
    2514:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2517:	6b c0 32             	imul   $0x32,%eax,%eax
    251a:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    251d:	8b 45 08             	mov    0x8(%ebp),%eax
    2520:	8d 78 34             	lea    0x34(%eax),%edi
    2523:	83 ec 0c             	sub    $0xc,%esp
    2526:	83 ec 04             	sub    $0x4,%esp
    2529:	89 e0                	mov    %esp,%eax
    252b:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    252f:	66 89 30             	mov    %si,(%eax)
    2532:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2536:	88 50 02             	mov    %dl,0x2(%eax)
    2539:	6a 32                	push   $0x32
    253b:	6a 32                	push   $0x32
    253d:	6a 00                	push   $0x0
    253f:	6a 00                	push   $0x0
    2541:	53                   	push   %ebx
    2542:	51                   	push   %ecx
    2543:	ff 75 b4             	pushl  -0x4c(%ebp)
    2546:	57                   	push   %edi
    2547:	e8 f3 f8 ff ff       	call   1e3f <APDcCopy>
    254c:	83 c4 30             	add    $0x30,%esp
                    break;
    254f:	e9 2a 02 00 00       	jmp    277e <APGridPaint+0x3e8>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    2554:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2557:	6a 69                	push   $0x69
    2559:	6a 69                	push   $0x69
    255b:	6a 69                	push   $0x69
    255d:	50                   	push   %eax
    255e:	e8 80 fa ff ff       	call   1fe3 <RGB>
    2563:	83 c4 0c             	add    $0xc,%esp
    2566:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    256a:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    256e:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    2572:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    2575:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    257c:	8d 45 b8             	lea    -0x48(%ebp),%eax
    257f:	6a 69                	push   $0x69
    2581:	6a 69                	push   $0x69
    2583:	6a 69                	push   $0x69
    2585:	50                   	push   %eax
    2586:	e8 58 fa ff ff       	call   1fe3 <RGB>
    258b:	83 c4 0c             	add    $0xc,%esp
    258e:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    2592:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    2596:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    259a:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    259d:	8b 45 08             	mov    0x8(%ebp),%eax
    25a0:	8d 50 34             	lea    0x34(%eax),%edx
    25a3:	8d 45 b8             	lea    -0x48(%ebp),%eax
    25a6:	ff 75 d0             	pushl  -0x30(%ebp)
    25a9:	ff 75 cc             	pushl  -0x34(%ebp)
    25ac:	52                   	push   %edx
    25ad:	50                   	push   %eax
    25ae:	e8 66 f2 ff ff       	call   1819 <APSetPen>
    25b3:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    25b6:	8b 45 08             	mov    0x8(%ebp),%eax
    25b9:	8d 58 34             	lea    0x34(%eax),%ebx
    25bc:	8d 55 b8             	lea    -0x48(%ebp),%edx
    25bf:	83 ec 04             	sub    $0x4,%esp
    25c2:	83 ec 04             	sub    $0x4,%esp
    25c5:	89 e0                	mov    %esp,%eax
    25c7:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    25cb:	66 89 08             	mov    %cx,(%eax)
    25ce:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    25d2:	88 48 02             	mov    %cl,0x2(%eax)
    25d5:	53                   	push   %ebx
    25d6:	52                   	push   %edx
    25d7:	e8 76 f2 ff ff       	call   1852 <APSetBrush>
    25dc:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    25df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    25e2:	6b d0 32             	imul   $0x32,%eax,%edx
    25e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    25e8:	6b c0 32             	imul   $0x32,%eax,%eax
    25eb:	8b 4d 08             	mov    0x8(%ebp),%ecx
    25ee:	83 c1 34             	add    $0x34,%ecx
    25f1:	83 ec 0c             	sub    $0xc,%esp
    25f4:	6a 32                	push   $0x32
    25f6:	6a 32                	push   $0x32
    25f8:	52                   	push   %edx
    25f9:	50                   	push   %eax
    25fa:	51                   	push   %ecx
    25fb:	e8 3a f6 ff ff       	call   1c3a <APDrawRect>
    2600:	83 c4 20             	add    $0x20,%esp
                    break;
    2603:	e9 76 01 00 00       	jmp    277e <APGridPaint+0x3e8>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    pen.color = RGB(0x00,0x80,0x00);
    2608:	8d 45 b8             	lea    -0x48(%ebp),%eax
    260b:	6a 00                	push   $0x0
    260d:	68 80 00 00 00       	push   $0x80
    2612:	6a 00                	push   $0x0
    2614:	50                   	push   %eax
    2615:	e8 c9 f9 ff ff       	call   1fe3 <RGB>
    261a:	83 c4 0c             	add    $0xc,%esp
    261d:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    2621:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    2625:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    2629:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    262c:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0x80,0x00);
    2633:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2636:	6a 00                	push   $0x0
    2638:	68 80 00 00 00       	push   $0x80
    263d:	6a 00                	push   $0x0
    263f:	50                   	push   %eax
    2640:	e8 9e f9 ff ff       	call   1fe3 <RGB>
    2645:	83 c4 0c             	add    $0xc,%esp
    2648:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    264c:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    2650:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    2654:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    2657:	8b 45 08             	mov    0x8(%ebp),%eax
    265a:	8d 50 34             	lea    0x34(%eax),%edx
    265d:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2660:	ff 75 d0             	pushl  -0x30(%ebp)
    2663:	ff 75 cc             	pushl  -0x34(%ebp)
    2666:	52                   	push   %edx
    2667:	50                   	push   %eax
    2668:	e8 ac f1 ff ff       	call   1819 <APSetPen>
    266d:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    2670:	8b 45 08             	mov    0x8(%ebp),%eax
    2673:	8d 58 34             	lea    0x34(%eax),%ebx
    2676:	8d 55 b8             	lea    -0x48(%ebp),%edx
    2679:	83 ec 04             	sub    $0x4,%esp
    267c:	83 ec 04             	sub    $0x4,%esp
    267f:	89 e0                	mov    %esp,%eax
    2681:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    2685:	66 89 08             	mov    %cx,(%eax)
    2688:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    268c:	88 48 02             	mov    %cl,0x2(%eax)
    268f:	53                   	push   %ebx
    2690:	52                   	push   %edx
    2691:	e8 bc f1 ff ff       	call   1852 <APSetBrush>
    2696:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    2699:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    269c:	6b d0 32             	imul   $0x32,%eax,%edx
    269f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    26a2:	6b c0 32             	imul   $0x32,%eax,%eax
    26a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    26a8:	83 c1 34             	add    $0x34,%ecx
    26ab:	83 ec 0c             	sub    $0xc,%esp
    26ae:	6a 32                	push   $0x32
    26b0:	6a 32                	push   $0x32
    26b2:	52                   	push   %edx
    26b3:	50                   	push   %eax
    26b4:	51                   	push   %ecx
    26b5:	e8 80 f5 ff ff       	call   1c3a <APDrawRect>
    26ba:	83 c4 20             	add    $0x20,%esp
                    break;
    26bd:	e9 bc 00 00 00       	jmp    277e <APGridPaint+0x3e8>
                case GRID_RIVER:
                    //printf(1,"Grid_River");
                    pen.color = RGB(0x00,0xbf,0xff);
    26c2:	8d 45 b8             	lea    -0x48(%ebp),%eax
    26c5:	68 ff 00 00 00       	push   $0xff
    26ca:	68 bf 00 00 00       	push   $0xbf
    26cf:	6a 00                	push   $0x0
    26d1:	50                   	push   %eax
    26d2:	e8 0c f9 ff ff       	call   1fe3 <RGB>
    26d7:	83 c4 0c             	add    $0xc,%esp
    26da:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    26de:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    26e2:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    26e6:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    26e9:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0xbf,0xff);
    26f0:	8d 45 b8             	lea    -0x48(%ebp),%eax
    26f3:	68 ff 00 00 00       	push   $0xff
    26f8:	68 bf 00 00 00       	push   $0xbf
    26fd:	6a 00                	push   $0x0
    26ff:	50                   	push   %eax
    2700:	e8 de f8 ff ff       	call   1fe3 <RGB>
    2705:	83 c4 0c             	add    $0xc,%esp
    2708:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    270c:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    2710:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    2714:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    2717:	8b 45 08             	mov    0x8(%ebp),%eax
    271a:	8d 50 34             	lea    0x34(%eax),%edx
    271d:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2720:	ff 75 d0             	pushl  -0x30(%ebp)
    2723:	ff 75 cc             	pushl  -0x34(%ebp)
    2726:	52                   	push   %edx
    2727:	50                   	push   %eax
    2728:	e8 ec f0 ff ff       	call   1819 <APSetPen>
    272d:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    2730:	8b 45 08             	mov    0x8(%ebp),%eax
    2733:	8d 58 34             	lea    0x34(%eax),%ebx
    2736:	8d 55 b8             	lea    -0x48(%ebp),%edx
    2739:	83 ec 04             	sub    $0x4,%esp
    273c:	83 ec 04             	sub    $0x4,%esp
    273f:	89 e0                	mov    %esp,%eax
    2741:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    2745:	66 89 08             	mov    %cx,(%eax)
    2748:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    274c:	88 48 02             	mov    %cl,0x2(%eax)
    274f:	53                   	push   %ebx
    2750:	52                   	push   %edx
    2751:	e8 fc f0 ff ff       	call   1852 <APSetBrush>
    2756:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
    2759:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    275c:	6b d0 32             	imul   $0x32,%eax,%edx
    275f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2762:	6b c0 32             	imul   $0x32,%eax,%eax
    2765:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2768:	83 c1 34             	add    $0x34,%ecx
    276b:	83 ec 0c             	sub    $0xc,%esp
    276e:	6a 32                	push   $0x32
    2770:	6a 32                	push   $0x32
    2772:	52                   	push   %edx
    2773:	50                   	push   %eax
    2774:	51                   	push   %ecx
    2775:	e8 c0 f4 ff ff       	call   1c3a <APDrawRect>
    277a:	83 c4 20             	add    $0x20,%esp
                    break;
    277d:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    277e:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2782:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2786:	0f 8e 17 fd ff ff    	jle    24a3 <APGridPaint+0x10d>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    278c:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2790:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2794:	0f 8e fd fc ff ff    	jle    2497 <APGridPaint+0x101>
                    break;
                default: break;
            }
        }
    }
}
    279a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    279d:	5b                   	pop    %ebx
    279e:	5e                   	pop    %esi
    279f:	5f                   	pop    %edi
    27a0:	5d                   	pop    %ebp
    27a1:	c3                   	ret    

000027a2 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    27a2:	55                   	push   %ebp
    27a3:	89 e5                	mov    %esp,%ebp
    27a5:	53                   	push   %ebx
    27a6:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    27a9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    27b0:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    27b4:	74 17                	je     27cd <sprintint+0x2b>
    27b6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    27ba:	79 11                	jns    27cd <sprintint+0x2b>
        neg = 1;
    27bc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    27c3:	8b 45 10             	mov    0x10(%ebp),%eax
    27c6:	f7 d8                	neg    %eax
    27c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    27cb:	eb 06                	jmp    27d3 <sprintint+0x31>
    } else {
        x = xx;
    27cd:	8b 45 10             	mov    0x10(%ebp),%eax
    27d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    27d3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    27da:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    27dd:	8d 41 01             	lea    0x1(%ecx),%eax
    27e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    27e3:	8b 5d 14             	mov    0x14(%ebp),%ebx
    27e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    27e9:	ba 00 00 00 00       	mov    $0x0,%edx
    27ee:	f7 f3                	div    %ebx
    27f0:	89 d0                	mov    %edx,%eax
    27f2:	0f b6 80 74 34 00 00 	movzbl 0x3474(%eax),%eax
    27f9:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    27fd:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2800:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2803:	ba 00 00 00 00       	mov    $0x0,%edx
    2808:	f7 f3                	div    %ebx
    280a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    280d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2811:	75 c7                	jne    27da <sprintint+0x38>
    if(neg)
    2813:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2817:	74 0e                	je     2827 <sprintint+0x85>
        buf[i++] = '-';
    2819:	8b 45 f8             	mov    -0x8(%ebp),%eax
    281c:	8d 50 01             	lea    0x1(%eax),%edx
    281f:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2822:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2827:	8b 45 f8             	mov    -0x8(%ebp),%eax
    282a:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    282d:	eb 1b                	jmp    284a <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    282f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2832:	8b 00                	mov    (%eax),%eax
    2834:	8d 48 01             	lea    0x1(%eax),%ecx
    2837:	8b 55 0c             	mov    0xc(%ebp),%edx
    283a:	89 0a                	mov    %ecx,(%edx)
    283c:	89 c2                	mov    %eax,%edx
    283e:	8b 45 08             	mov    0x8(%ebp),%eax
    2841:	01 d0                	add    %edx,%eax
    2843:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2846:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    284a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    284e:	7f df                	jg     282f <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2850:	eb 21                	jmp    2873 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2852:	8b 45 0c             	mov    0xc(%ebp),%eax
    2855:	8b 00                	mov    (%eax),%eax
    2857:	8d 48 01             	lea    0x1(%eax),%ecx
    285a:	8b 55 0c             	mov    0xc(%ebp),%edx
    285d:	89 0a                	mov    %ecx,(%edx)
    285f:	89 c2                	mov    %eax,%edx
    2861:	8b 45 08             	mov    0x8(%ebp),%eax
    2864:	01 c2                	add    %eax,%edx
    2866:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2869:	8b 45 f8             	mov    -0x8(%ebp),%eax
    286c:	01 c8                	add    %ecx,%eax
    286e:	0f b6 00             	movzbl (%eax),%eax
    2871:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2873:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2877:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    287b:	79 d5                	jns    2852 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    287d:	90                   	nop
    287e:	83 c4 20             	add    $0x20,%esp
    2881:	5b                   	pop    %ebx
    2882:	5d                   	pop    %ebp
    2883:	c3                   	ret    

00002884 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2884:	55                   	push   %ebp
    2885:	89 e5                	mov    %esp,%ebp
    2887:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    288a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2891:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2898:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    289f:	8d 45 0c             	lea    0xc(%ebp),%eax
    28a2:	83 c0 04             	add    $0x4,%eax
    28a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    28a8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    28af:	e9 d9 01 00 00       	jmp    2a8d <sprintf+0x209>
        c = fmt[i] & 0xff;
    28b4:	8b 55 0c             	mov    0xc(%ebp),%edx
    28b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    28ba:	01 d0                	add    %edx,%eax
    28bc:	0f b6 00             	movzbl (%eax),%eax
    28bf:	0f be c0             	movsbl %al,%eax
    28c2:	25 ff 00 00 00       	and    $0xff,%eax
    28c7:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    28ca:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    28ce:	75 2c                	jne    28fc <sprintf+0x78>
            if(c == '%'){
    28d0:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    28d4:	75 0c                	jne    28e2 <sprintf+0x5e>
                state = '%';
    28d6:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    28dd:	e9 a7 01 00 00       	jmp    2a89 <sprintf+0x205>
            } else {
                dst[j++] = c;
    28e2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    28e5:	8d 50 01             	lea    0x1(%eax),%edx
    28e8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    28eb:	89 c2                	mov    %eax,%edx
    28ed:	8b 45 08             	mov    0x8(%ebp),%eax
    28f0:	01 d0                	add    %edx,%eax
    28f2:	8b 55 e0             	mov    -0x20(%ebp),%edx
    28f5:	88 10                	mov    %dl,(%eax)
    28f7:	e9 8d 01 00 00       	jmp    2a89 <sprintf+0x205>
            }
        } else if(state == '%'){
    28fc:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2900:	0f 85 83 01 00 00    	jne    2a89 <sprintf+0x205>
            if(c == 'd'){
    2906:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    290a:	75 4c                	jne    2958 <sprintf+0xd4>
                buf[bi] = '\0';
    290c:	8d 55 ce             	lea    -0x32(%ebp),%edx
    290f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2912:	01 d0                	add    %edx,%eax
    2914:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2917:	83 ec 0c             	sub    $0xc,%esp
    291a:	8d 45 ce             	lea    -0x32(%ebp),%eax
    291d:	50                   	push   %eax
    291e:	e8 20 e5 ff ff       	call   e43 <atoi>
    2923:	83 c4 10             	add    $0x10,%esp
    2926:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2929:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2930:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2933:	8b 00                	mov    (%eax),%eax
    2935:	83 ec 08             	sub    $0x8,%esp
    2938:	ff 75 d8             	pushl  -0x28(%ebp)
    293b:	6a 01                	push   $0x1
    293d:	6a 0a                	push   $0xa
    293f:	50                   	push   %eax
    2940:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2943:	50                   	push   %eax
    2944:	ff 75 08             	pushl  0x8(%ebp)
    2947:	e8 56 fe ff ff       	call   27a2 <sprintint>
    294c:	83 c4 20             	add    $0x20,%esp
                ap++;
    294f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2953:	e9 2a 01 00 00       	jmp    2a82 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2958:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    295c:	74 06                	je     2964 <sprintf+0xe0>
    295e:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2962:	75 4c                	jne    29b0 <sprintf+0x12c>
                buf[bi] = '\0';
    2964:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2967:	8b 45 f0             	mov    -0x10(%ebp),%eax
    296a:	01 d0                	add    %edx,%eax
    296c:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    296f:	83 ec 0c             	sub    $0xc,%esp
    2972:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2975:	50                   	push   %eax
    2976:	e8 c8 e4 ff ff       	call   e43 <atoi>
    297b:	83 c4 10             	add    $0x10,%esp
    297e:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2981:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2988:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    298b:	8b 00                	mov    (%eax),%eax
    298d:	83 ec 08             	sub    $0x8,%esp
    2990:	ff 75 dc             	pushl  -0x24(%ebp)
    2993:	6a 00                	push   $0x0
    2995:	6a 10                	push   $0x10
    2997:	50                   	push   %eax
    2998:	8d 45 c8             	lea    -0x38(%ebp),%eax
    299b:	50                   	push   %eax
    299c:	ff 75 08             	pushl  0x8(%ebp)
    299f:	e8 fe fd ff ff       	call   27a2 <sprintint>
    29a4:	83 c4 20             	add    $0x20,%esp
                ap++;
    29a7:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    29ab:	e9 d2 00 00 00       	jmp    2a82 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    29b0:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    29b4:	75 46                	jne    29fc <sprintf+0x178>
                s = (char*)*ap;
    29b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    29b9:	8b 00                	mov    (%eax),%eax
    29bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    29be:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    29c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    29c6:	75 25                	jne    29ed <sprintf+0x169>
                    s = "(null)";
    29c8:	c7 45 f4 f4 2c 00 00 	movl   $0x2cf4,-0xc(%ebp)
                while(*s != 0){
    29cf:	eb 1c                	jmp    29ed <sprintf+0x169>
                    dst[j++] = *s;
    29d1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    29d4:	8d 50 01             	lea    0x1(%eax),%edx
    29d7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    29da:	89 c2                	mov    %eax,%edx
    29dc:	8b 45 08             	mov    0x8(%ebp),%eax
    29df:	01 c2                	add    %eax,%edx
    29e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    29e4:	0f b6 00             	movzbl (%eax),%eax
    29e7:	88 02                	mov    %al,(%edx)
                    s++;
    29e9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    29ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    29f0:	0f b6 00             	movzbl (%eax),%eax
    29f3:	84 c0                	test   %al,%al
    29f5:	75 da                	jne    29d1 <sprintf+0x14d>
    29f7:	e9 86 00 00 00       	jmp    2a82 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    29fc:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2a00:	75 1d                	jne    2a1f <sprintf+0x19b>
                dst[j++] = *ap;
    2a02:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2a05:	8d 50 01             	lea    0x1(%eax),%edx
    2a08:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2a0b:	89 c2                	mov    %eax,%edx
    2a0d:	8b 45 08             	mov    0x8(%ebp),%eax
    2a10:	01 c2                	add    %eax,%edx
    2a12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2a15:	8b 00                	mov    (%eax),%eax
    2a17:	88 02                	mov    %al,(%edx)
                ap++;
    2a19:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2a1d:	eb 63                	jmp    2a82 <sprintf+0x1fe>
            } else if(c == '%'){
    2a1f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2a23:	75 17                	jne    2a3c <sprintf+0x1b8>
                dst[j++] = c;
    2a25:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2a28:	8d 50 01             	lea    0x1(%eax),%edx
    2a2b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2a2e:	89 c2                	mov    %eax,%edx
    2a30:	8b 45 08             	mov    0x8(%ebp),%eax
    2a33:	01 d0                	add    %edx,%eax
    2a35:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2a38:	88 10                	mov    %dl,(%eax)
    2a3a:	eb 46                	jmp    2a82 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2a3c:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2a40:	7e 18                	jle    2a5a <sprintf+0x1d6>
    2a42:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2a46:	7f 12                	jg     2a5a <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2a48:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2a4b:	8d 50 01             	lea    0x1(%eax),%edx
    2a4e:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2a51:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2a54:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2a58:	eb 2f                	jmp    2a89 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2a5a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2a5d:	8d 50 01             	lea    0x1(%eax),%edx
    2a60:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2a63:	89 c2                	mov    %eax,%edx
    2a65:	8b 45 08             	mov    0x8(%ebp),%eax
    2a68:	01 d0                	add    %edx,%eax
    2a6a:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2a6d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2a70:	8d 50 01             	lea    0x1(%eax),%edx
    2a73:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2a76:	89 c2                	mov    %eax,%edx
    2a78:	8b 45 08             	mov    0x8(%ebp),%eax
    2a7b:	01 d0                	add    %edx,%eax
    2a7d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2a80:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2a82:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2a89:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2a8d:	8b 55 0c             	mov    0xc(%ebp),%edx
    2a90:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2a93:	01 d0                	add    %edx,%eax
    2a95:	0f b6 00             	movzbl (%eax),%eax
    2a98:	84 c0                	test   %al,%al
    2a9a:	0f 85 14 fe ff ff    	jne    28b4 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2aa0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2aa3:	8d 50 01             	lea    0x1(%eax),%edx
    2aa6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2aa9:	89 c2                	mov    %eax,%edx
    2aab:	8b 45 08             	mov    0x8(%ebp),%eax
    2aae:	01 d0                	add    %edx,%eax
    2ab0:	c6 00 00             	movb   $0x0,(%eax)
}
    2ab3:	90                   	nop
    2ab4:	c9                   	leave  
    2ab5:	c3                   	ret    
