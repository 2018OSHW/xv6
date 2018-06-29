
_init：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 14             	sub    $0x14,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
      11:	83 ec 08             	sub    $0x8,%esp
      14:	6a 02                	push   $0x2
      16:	68 77 24 00 00       	push   $0x2477
      1b:	e8 78 03 00 00       	call   398 <open>
      20:	83 c4 10             	add    $0x10,%esp
      23:	85 c0                	test   %eax,%eax
      25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
      27:	83 ec 04             	sub    $0x4,%esp
      2a:	6a 01                	push   $0x1
      2c:	6a 01                	push   $0x1
      2e:	68 77 24 00 00       	push   $0x2477
      33:	e8 68 03 00 00       	call   3a0 <mknod>
      38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
      3b:	83 ec 08             	sub    $0x8,%esp
      3e:	6a 02                	push   $0x2
      40:	68 77 24 00 00       	push   $0x2477
      45:	e8 4e 03 00 00       	call   398 <open>
      4a:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
      4d:	83 ec 0c             	sub    $0xc,%esp
      50:	6a 00                	push   $0x0
      52:	e8 79 03 00 00       	call   3d0 <dup>
      57:	83 c4 10             	add    $0x10,%esp
  dup(0);  // stderr
      5a:	83 ec 0c             	sub    $0xc,%esp
      5d:	6a 00                	push   $0x0
      5f:	e8 6c 03 00 00       	call   3d0 <dup>
      64:	83 c4 10             	add    $0x10,%esp

  for(;;){
    //printf(1, "init: starting sh\n");
    printf(1,"init: starting APdesktop\n");
      67:	83 ec 08             	sub    $0x8,%esp
      6a:	68 7f 24 00 00       	push   $0x247f
      6f:	6a 01                	push   $0x1
      71:	e8 91 04 00 00       	call   507 <printf>
      76:	83 c4 10             	add    $0x10,%esp
    pid = fork();
      79:	e8 d2 02 00 00       	call   350 <fork>
      7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
      81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      85:	79 17                	jns    9e <main+0x9e>
      printf(1, "init: fork failed\n");
      87:	83 ec 08             	sub    $0x8,%esp
      8a:	68 99 24 00 00       	push   $0x2499
      8f:	6a 01                	push   $0x1
      91:	e8 71 04 00 00       	call   507 <printf>
      96:	83 c4 10             	add    $0x10,%esp
      exit();
      99:	e8 ba 02 00 00       	call   358 <exit>
    }
    if(pid == 0){
      9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      a2:	75 3e                	jne    e2 <main+0xe2>
     // exec("sh", argv);
      //exec("APDesktop", argv);
      exec("APSnack",argv);
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	68 e0 2b 00 00       	push   $0x2be0
      ac:	68 ac 24 00 00       	push   $0x24ac
      b1:	e8 da 02 00 00       	call   390 <exec>
      b6:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec desktop failed\n");
      b9:	83 ec 08             	sub    $0x8,%esp
      bc:	68 b4 24 00 00       	push   $0x24b4
      c1:	6a 01                	push   $0x1
      c3:	e8 3f 04 00 00       	call   507 <printf>
      c8:	83 c4 10             	add    $0x10,%esp
      exit();
      cb:	e8 88 02 00 00       	call   358 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
      d0:	83 ec 08             	sub    $0x8,%esp
      d3:	68 cf 24 00 00       	push   $0x24cf
      d8:	6a 01                	push   $0x1
      da:	e8 28 04 00 00       	call   507 <printf>
      df:	83 c4 10             	add    $0x10,%esp
      //exec("APDesktop", argv);
      exec("APSnack",argv);
      printf(1, "init: exec desktop failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      e2:	e8 79 02 00 00       	call   360 <wait>
      e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
      ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      ee:	0f 88 73 ff ff ff    	js     67 <main+0x67>
      f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
      f7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
      fa:	75 d4                	jne    d0 <main+0xd0>
      printf(1, "zombie!\n");
  }
      fc:	e9 66 ff ff ff       	jmp    67 <main+0x67>

00000101 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     101:	55                   	push   %ebp
     102:	89 e5                	mov    %esp,%ebp
     104:	57                   	push   %edi
     105:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     106:	8b 4d 08             	mov    0x8(%ebp),%ecx
     109:	8b 55 10             	mov    0x10(%ebp),%edx
     10c:	8b 45 0c             	mov    0xc(%ebp),%eax
     10f:	89 cb                	mov    %ecx,%ebx
     111:	89 df                	mov    %ebx,%edi
     113:	89 d1                	mov    %edx,%ecx
     115:	fc                   	cld    
     116:	f3 aa                	rep stos %al,%es:(%edi)
     118:	89 ca                	mov    %ecx,%edx
     11a:	89 fb                	mov    %edi,%ebx
     11c:	89 5d 08             	mov    %ebx,0x8(%ebp)
     11f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     122:	90                   	nop
     123:	5b                   	pop    %ebx
     124:	5f                   	pop    %edi
     125:	5d                   	pop    %ebp
     126:	c3                   	ret    

00000127 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     127:	55                   	push   %ebp
     128:	89 e5                	mov    %esp,%ebp
     12a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     12d:	8b 45 08             	mov    0x8(%ebp),%eax
     130:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     133:	90                   	nop
     134:	8b 45 08             	mov    0x8(%ebp),%eax
     137:	8d 50 01             	lea    0x1(%eax),%edx
     13a:	89 55 08             	mov    %edx,0x8(%ebp)
     13d:	8b 55 0c             	mov    0xc(%ebp),%edx
     140:	8d 4a 01             	lea    0x1(%edx),%ecx
     143:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     146:	0f b6 12             	movzbl (%edx),%edx
     149:	88 10                	mov    %dl,(%eax)
     14b:	0f b6 00             	movzbl (%eax),%eax
     14e:	84 c0                	test   %al,%al
     150:	75 e2                	jne    134 <strcpy+0xd>
    ;
  return os;
     152:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     155:	c9                   	leave  
     156:	c3                   	ret    

00000157 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     157:	55                   	push   %ebp
     158:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     15a:	eb 08                	jmp    164 <strcmp+0xd>
    p++, q++;
     15c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     160:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     164:	8b 45 08             	mov    0x8(%ebp),%eax
     167:	0f b6 00             	movzbl (%eax),%eax
     16a:	84 c0                	test   %al,%al
     16c:	74 10                	je     17e <strcmp+0x27>
     16e:	8b 45 08             	mov    0x8(%ebp),%eax
     171:	0f b6 10             	movzbl (%eax),%edx
     174:	8b 45 0c             	mov    0xc(%ebp),%eax
     177:	0f b6 00             	movzbl (%eax),%eax
     17a:	38 c2                	cmp    %al,%dl
     17c:	74 de                	je     15c <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     17e:	8b 45 08             	mov    0x8(%ebp),%eax
     181:	0f b6 00             	movzbl (%eax),%eax
     184:	0f b6 d0             	movzbl %al,%edx
     187:	8b 45 0c             	mov    0xc(%ebp),%eax
     18a:	0f b6 00             	movzbl (%eax),%eax
     18d:	0f b6 c0             	movzbl %al,%eax
     190:	29 c2                	sub    %eax,%edx
     192:	89 d0                	mov    %edx,%eax
}
     194:	5d                   	pop    %ebp
     195:	c3                   	ret    

00000196 <strlen>:

uint
strlen(char *s)
{
     196:	55                   	push   %ebp
     197:	89 e5                	mov    %esp,%ebp
     199:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     19c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     1a3:	eb 04                	jmp    1a9 <strlen+0x13>
     1a5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     1a9:	8b 55 fc             	mov    -0x4(%ebp),%edx
     1ac:	8b 45 08             	mov    0x8(%ebp),%eax
     1af:	01 d0                	add    %edx,%eax
     1b1:	0f b6 00             	movzbl (%eax),%eax
     1b4:	84 c0                	test   %al,%al
     1b6:	75 ed                	jne    1a5 <strlen+0xf>
    ;
  return n;
     1b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     1bb:	c9                   	leave  
     1bc:	c3                   	ret    

000001bd <memset>:

void*
memset(void *dst, int c, uint n)
{
     1bd:	55                   	push   %ebp
     1be:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     1c0:	8b 45 10             	mov    0x10(%ebp),%eax
     1c3:	50                   	push   %eax
     1c4:	ff 75 0c             	pushl  0xc(%ebp)
     1c7:	ff 75 08             	pushl  0x8(%ebp)
     1ca:	e8 32 ff ff ff       	call   101 <stosb>
     1cf:	83 c4 0c             	add    $0xc,%esp
  return dst;
     1d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1d5:	c9                   	leave  
     1d6:	c3                   	ret    

000001d7 <strchr>:

char*
strchr(const char *s, char c)
{
     1d7:	55                   	push   %ebp
     1d8:	89 e5                	mov    %esp,%ebp
     1da:	83 ec 04             	sub    $0x4,%esp
     1dd:	8b 45 0c             	mov    0xc(%ebp),%eax
     1e0:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     1e3:	eb 14                	jmp    1f9 <strchr+0x22>
    if(*s == c)
     1e5:	8b 45 08             	mov    0x8(%ebp),%eax
     1e8:	0f b6 00             	movzbl (%eax),%eax
     1eb:	3a 45 fc             	cmp    -0x4(%ebp),%al
     1ee:	75 05                	jne    1f5 <strchr+0x1e>
      return (char*)s;
     1f0:	8b 45 08             	mov    0x8(%ebp),%eax
     1f3:	eb 13                	jmp    208 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     1f5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1f9:	8b 45 08             	mov    0x8(%ebp),%eax
     1fc:	0f b6 00             	movzbl (%eax),%eax
     1ff:	84 c0                	test   %al,%al
     201:	75 e2                	jne    1e5 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     203:	b8 00 00 00 00       	mov    $0x0,%eax
}
     208:	c9                   	leave  
     209:	c3                   	ret    

0000020a <gets>:

char*
gets(char *buf, int max)
{
     20a:	55                   	push   %ebp
     20b:	89 e5                	mov    %esp,%ebp
     20d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     210:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     217:	eb 42                	jmp    25b <gets+0x51>
    cc = read(0, &c, 1);
     219:	83 ec 04             	sub    $0x4,%esp
     21c:	6a 01                	push   $0x1
     21e:	8d 45 ef             	lea    -0x11(%ebp),%eax
     221:	50                   	push   %eax
     222:	6a 00                	push   $0x0
     224:	e8 47 01 00 00       	call   370 <read>
     229:	83 c4 10             	add    $0x10,%esp
     22c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     22f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     233:	7e 33                	jle    268 <gets+0x5e>
      break;
    buf[i++] = c;
     235:	8b 45 f4             	mov    -0xc(%ebp),%eax
     238:	8d 50 01             	lea    0x1(%eax),%edx
     23b:	89 55 f4             	mov    %edx,-0xc(%ebp)
     23e:	89 c2                	mov    %eax,%edx
     240:	8b 45 08             	mov    0x8(%ebp),%eax
     243:	01 c2                	add    %eax,%edx
     245:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     249:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     24b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     24f:	3c 0a                	cmp    $0xa,%al
     251:	74 16                	je     269 <gets+0x5f>
     253:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     257:	3c 0d                	cmp    $0xd,%al
     259:	74 0e                	je     269 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     25b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     25e:	83 c0 01             	add    $0x1,%eax
     261:	3b 45 0c             	cmp    0xc(%ebp),%eax
     264:	7c b3                	jl     219 <gets+0xf>
     266:	eb 01                	jmp    269 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     268:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     269:	8b 55 f4             	mov    -0xc(%ebp),%edx
     26c:	8b 45 08             	mov    0x8(%ebp),%eax
     26f:	01 d0                	add    %edx,%eax
     271:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     274:	8b 45 08             	mov    0x8(%ebp),%eax
}
     277:	c9                   	leave  
     278:	c3                   	ret    

00000279 <stat>:

int
stat(char *n, struct stat *st)
{
     279:	55                   	push   %ebp
     27a:	89 e5                	mov    %esp,%ebp
     27c:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     27f:	83 ec 08             	sub    $0x8,%esp
     282:	6a 00                	push   $0x0
     284:	ff 75 08             	pushl  0x8(%ebp)
     287:	e8 0c 01 00 00       	call   398 <open>
     28c:	83 c4 10             	add    $0x10,%esp
     28f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     292:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     296:	79 07                	jns    29f <stat+0x26>
    return -1;
     298:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     29d:	eb 25                	jmp    2c4 <stat+0x4b>
  r = fstat(fd, st);
     29f:	83 ec 08             	sub    $0x8,%esp
     2a2:	ff 75 0c             	pushl  0xc(%ebp)
     2a5:	ff 75 f4             	pushl  -0xc(%ebp)
     2a8:	e8 03 01 00 00       	call   3b0 <fstat>
     2ad:	83 c4 10             	add    $0x10,%esp
     2b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     2b3:	83 ec 0c             	sub    $0xc,%esp
     2b6:	ff 75 f4             	pushl  -0xc(%ebp)
     2b9:	e8 c2 00 00 00       	call   380 <close>
     2be:	83 c4 10             	add    $0x10,%esp
  return r;
     2c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     2c4:	c9                   	leave  
     2c5:	c3                   	ret    

000002c6 <atoi>:

int
atoi(const char *s)
{
     2c6:	55                   	push   %ebp
     2c7:	89 e5                	mov    %esp,%ebp
     2c9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     2cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     2d3:	eb 25                	jmp    2fa <atoi+0x34>
    n = n*10 + *s++ - '0';
     2d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
     2d8:	89 d0                	mov    %edx,%eax
     2da:	c1 e0 02             	shl    $0x2,%eax
     2dd:	01 d0                	add    %edx,%eax
     2df:	01 c0                	add    %eax,%eax
     2e1:	89 c1                	mov    %eax,%ecx
     2e3:	8b 45 08             	mov    0x8(%ebp),%eax
     2e6:	8d 50 01             	lea    0x1(%eax),%edx
     2e9:	89 55 08             	mov    %edx,0x8(%ebp)
     2ec:	0f b6 00             	movzbl (%eax),%eax
     2ef:	0f be c0             	movsbl %al,%eax
     2f2:	01 c8                	add    %ecx,%eax
     2f4:	83 e8 30             	sub    $0x30,%eax
     2f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     2fa:	8b 45 08             	mov    0x8(%ebp),%eax
     2fd:	0f b6 00             	movzbl (%eax),%eax
     300:	3c 2f                	cmp    $0x2f,%al
     302:	7e 0a                	jle    30e <atoi+0x48>
     304:	8b 45 08             	mov    0x8(%ebp),%eax
     307:	0f b6 00             	movzbl (%eax),%eax
     30a:	3c 39                	cmp    $0x39,%al
     30c:	7e c7                	jle    2d5 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     30e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     311:	c9                   	leave  
     312:	c3                   	ret    

00000313 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     313:	55                   	push   %ebp
     314:	89 e5                	mov    %esp,%ebp
     316:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     319:	8b 45 08             	mov    0x8(%ebp),%eax
     31c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     31f:	8b 45 0c             	mov    0xc(%ebp),%eax
     322:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     325:	eb 17                	jmp    33e <memmove+0x2b>
    *dst++ = *src++;
     327:	8b 45 fc             	mov    -0x4(%ebp),%eax
     32a:	8d 50 01             	lea    0x1(%eax),%edx
     32d:	89 55 fc             	mov    %edx,-0x4(%ebp)
     330:	8b 55 f8             	mov    -0x8(%ebp),%edx
     333:	8d 4a 01             	lea    0x1(%edx),%ecx
     336:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     339:	0f b6 12             	movzbl (%edx),%edx
     33c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     33e:	8b 45 10             	mov    0x10(%ebp),%eax
     341:	8d 50 ff             	lea    -0x1(%eax),%edx
     344:	89 55 10             	mov    %edx,0x10(%ebp)
     347:	85 c0                	test   %eax,%eax
     349:	7f dc                	jg     327 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     34b:	8b 45 08             	mov    0x8(%ebp),%eax
}
     34e:	c9                   	leave  
     34f:	c3                   	ret    

00000350 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     350:	b8 01 00 00 00       	mov    $0x1,%eax
     355:	cd 40                	int    $0x40
     357:	c3                   	ret    

00000358 <exit>:
SYSCALL(exit)
     358:	b8 02 00 00 00       	mov    $0x2,%eax
     35d:	cd 40                	int    $0x40
     35f:	c3                   	ret    

00000360 <wait>:
SYSCALL(wait)
     360:	b8 03 00 00 00       	mov    $0x3,%eax
     365:	cd 40                	int    $0x40
     367:	c3                   	ret    

00000368 <pipe>:
SYSCALL(pipe)
     368:	b8 04 00 00 00       	mov    $0x4,%eax
     36d:	cd 40                	int    $0x40
     36f:	c3                   	ret    

00000370 <read>:
SYSCALL(read)
     370:	b8 05 00 00 00       	mov    $0x5,%eax
     375:	cd 40                	int    $0x40
     377:	c3                   	ret    

00000378 <write>:
SYSCALL(write)
     378:	b8 10 00 00 00       	mov    $0x10,%eax
     37d:	cd 40                	int    $0x40
     37f:	c3                   	ret    

00000380 <close>:
SYSCALL(close)
     380:	b8 15 00 00 00       	mov    $0x15,%eax
     385:	cd 40                	int    $0x40
     387:	c3                   	ret    

00000388 <kill>:
SYSCALL(kill)
     388:	b8 06 00 00 00       	mov    $0x6,%eax
     38d:	cd 40                	int    $0x40
     38f:	c3                   	ret    

00000390 <exec>:
SYSCALL(exec)
     390:	b8 07 00 00 00       	mov    $0x7,%eax
     395:	cd 40                	int    $0x40
     397:	c3                   	ret    

00000398 <open>:
SYSCALL(open)
     398:	b8 0f 00 00 00       	mov    $0xf,%eax
     39d:	cd 40                	int    $0x40
     39f:	c3                   	ret    

000003a0 <mknod>:
SYSCALL(mknod)
     3a0:	b8 11 00 00 00       	mov    $0x11,%eax
     3a5:	cd 40                	int    $0x40
     3a7:	c3                   	ret    

000003a8 <unlink>:
SYSCALL(unlink)
     3a8:	b8 12 00 00 00       	mov    $0x12,%eax
     3ad:	cd 40                	int    $0x40
     3af:	c3                   	ret    

000003b0 <fstat>:
SYSCALL(fstat)
     3b0:	b8 08 00 00 00       	mov    $0x8,%eax
     3b5:	cd 40                	int    $0x40
     3b7:	c3                   	ret    

000003b8 <link>:
SYSCALL(link)
     3b8:	b8 13 00 00 00       	mov    $0x13,%eax
     3bd:	cd 40                	int    $0x40
     3bf:	c3                   	ret    

000003c0 <mkdir>:
SYSCALL(mkdir)
     3c0:	b8 14 00 00 00       	mov    $0x14,%eax
     3c5:	cd 40                	int    $0x40
     3c7:	c3                   	ret    

000003c8 <chdir>:
SYSCALL(chdir)
     3c8:	b8 09 00 00 00       	mov    $0x9,%eax
     3cd:	cd 40                	int    $0x40
     3cf:	c3                   	ret    

000003d0 <dup>:
SYSCALL(dup)
     3d0:	b8 0a 00 00 00       	mov    $0xa,%eax
     3d5:	cd 40                	int    $0x40
     3d7:	c3                   	ret    

000003d8 <getpid>:
SYSCALL(getpid)
     3d8:	b8 0b 00 00 00       	mov    $0xb,%eax
     3dd:	cd 40                	int    $0x40
     3df:	c3                   	ret    

000003e0 <sbrk>:
SYSCALL(sbrk)
     3e0:	b8 0c 00 00 00       	mov    $0xc,%eax
     3e5:	cd 40                	int    $0x40
     3e7:	c3                   	ret    

000003e8 <sleep>:
SYSCALL(sleep)
     3e8:	b8 0d 00 00 00       	mov    $0xd,%eax
     3ed:	cd 40                	int    $0x40
     3ef:	c3                   	ret    

000003f0 <uptime>:
SYSCALL(uptime)
     3f0:	b8 0e 00 00 00       	mov    $0xe,%eax
     3f5:	cd 40                	int    $0x40
     3f7:	c3                   	ret    

000003f8 <paintWindow>:

SYSCALL(paintWindow)
     3f8:	b8 16 00 00 00       	mov    $0x16,%eax
     3fd:	cd 40                	int    $0x40
     3ff:	c3                   	ret    

00000400 <sendMessage>:
SYSCALL(sendMessage)
     400:	b8 17 00 00 00       	mov    $0x17,%eax
     405:	cd 40                	int    $0x40
     407:	c3                   	ret    

00000408 <getMessage>:
SYSCALL(getMessage)
     408:	b8 19 00 00 00       	mov    $0x19,%eax
     40d:	cd 40                	int    $0x40
     40f:	c3                   	ret    

00000410 <registWindow>:
SYSCALL(registWindow)
     410:	b8 18 00 00 00       	mov    $0x18,%eax
     415:	cd 40                	int    $0x40
     417:	c3                   	ret    

00000418 <changePosition>:
SYSCALL(changePosition)
     418:	b8 1a 00 00 00       	mov    $0x1a,%eax
     41d:	cd 40                	int    $0x40
     41f:	c3                   	ret    

00000420 <setupTimer>:
SYSCALL(setupTimer)
     420:	b8 1b 00 00 00       	mov    $0x1b,%eax
     425:	cd 40                	int    $0x40
     427:	c3                   	ret    

00000428 <deleteTimer>:
SYSCALL(deleteTimer)
     428:	b8 1c 00 00 00       	mov    $0x1c,%eax
     42d:	cd 40                	int    $0x40
     42f:	c3                   	ret    

00000430 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	83 ec 18             	sub    $0x18,%esp
     436:	8b 45 0c             	mov    0xc(%ebp),%eax
     439:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     43c:	83 ec 04             	sub    $0x4,%esp
     43f:	6a 01                	push   $0x1
     441:	8d 45 f4             	lea    -0xc(%ebp),%eax
     444:	50                   	push   %eax
     445:	ff 75 08             	pushl  0x8(%ebp)
     448:	e8 2b ff ff ff       	call   378 <write>
     44d:	83 c4 10             	add    $0x10,%esp
}
     450:	90                   	nop
     451:	c9                   	leave  
     452:	c3                   	ret    

00000453 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     453:	55                   	push   %ebp
     454:	89 e5                	mov    %esp,%ebp
     456:	53                   	push   %ebx
     457:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     45a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     461:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     465:	74 17                	je     47e <printint+0x2b>
     467:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     46b:	79 11                	jns    47e <printint+0x2b>
    neg = 1;
     46d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     474:	8b 45 0c             	mov    0xc(%ebp),%eax
     477:	f7 d8                	neg    %eax
     479:	89 45 ec             	mov    %eax,-0x14(%ebp)
     47c:	eb 06                	jmp    484 <printint+0x31>
  } else {
    x = xx;
     47e:	8b 45 0c             	mov    0xc(%ebp),%eax
     481:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     484:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     48b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     48e:	8d 41 01             	lea    0x1(%ecx),%eax
     491:	89 45 f4             	mov    %eax,-0xc(%ebp)
     494:	8b 5d 10             	mov    0x10(%ebp),%ebx
     497:	8b 45 ec             	mov    -0x14(%ebp),%eax
     49a:	ba 00 00 00 00       	mov    $0x0,%edx
     49f:	f7 f3                	div    %ebx
     4a1:	89 d0                	mov    %edx,%eax
     4a3:	0f b6 80 e8 2b 00 00 	movzbl 0x2be8(%eax),%eax
     4aa:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     4ae:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4b4:	ba 00 00 00 00       	mov    $0x0,%edx
     4b9:	f7 f3                	div    %ebx
     4bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4be:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4c2:	75 c7                	jne    48b <printint+0x38>
  if(neg)
     4c4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4c8:	74 2d                	je     4f7 <printint+0xa4>
    buf[i++] = '-';
     4ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4cd:	8d 50 01             	lea    0x1(%eax),%edx
     4d0:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4d3:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     4d8:	eb 1d                	jmp    4f7 <printint+0xa4>
    putc(fd, buf[i]);
     4da:	8d 55 dc             	lea    -0x24(%ebp),%edx
     4dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4e0:	01 d0                	add    %edx,%eax
     4e2:	0f b6 00             	movzbl (%eax),%eax
     4e5:	0f be c0             	movsbl %al,%eax
     4e8:	83 ec 08             	sub    $0x8,%esp
     4eb:	50                   	push   %eax
     4ec:	ff 75 08             	pushl  0x8(%ebp)
     4ef:	e8 3c ff ff ff       	call   430 <putc>
     4f4:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     4f7:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     4fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4ff:	79 d9                	jns    4da <printint+0x87>
    putc(fd, buf[i]);
}
     501:	90                   	nop
     502:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     505:	c9                   	leave  
     506:	c3                   	ret    

00000507 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     507:	55                   	push   %ebp
     508:	89 e5                	mov    %esp,%ebp
     50a:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     50d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     514:	8d 45 0c             	lea    0xc(%ebp),%eax
     517:	83 c0 04             	add    $0x4,%eax
     51a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     51d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     524:	e9 59 01 00 00       	jmp    682 <printf+0x17b>
    c = fmt[i] & 0xff;
     529:	8b 55 0c             	mov    0xc(%ebp),%edx
     52c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     52f:	01 d0                	add    %edx,%eax
     531:	0f b6 00             	movzbl (%eax),%eax
     534:	0f be c0             	movsbl %al,%eax
     537:	25 ff 00 00 00       	and    $0xff,%eax
     53c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     53f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     543:	75 2c                	jne    571 <printf+0x6a>
      if(c == '%'){
     545:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     549:	75 0c                	jne    557 <printf+0x50>
        state = '%';
     54b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     552:	e9 27 01 00 00       	jmp    67e <printf+0x177>
      } else {
        putc(fd, c);
     557:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     55a:	0f be c0             	movsbl %al,%eax
     55d:	83 ec 08             	sub    $0x8,%esp
     560:	50                   	push   %eax
     561:	ff 75 08             	pushl  0x8(%ebp)
     564:	e8 c7 fe ff ff       	call   430 <putc>
     569:	83 c4 10             	add    $0x10,%esp
     56c:	e9 0d 01 00 00       	jmp    67e <printf+0x177>
      }
    } else if(state == '%'){
     571:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     575:	0f 85 03 01 00 00    	jne    67e <printf+0x177>
      if(c == 'd'){
     57b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     57f:	75 1e                	jne    59f <printf+0x98>
        printint(fd, *ap, 10, 1);
     581:	8b 45 e8             	mov    -0x18(%ebp),%eax
     584:	8b 00                	mov    (%eax),%eax
     586:	6a 01                	push   $0x1
     588:	6a 0a                	push   $0xa
     58a:	50                   	push   %eax
     58b:	ff 75 08             	pushl  0x8(%ebp)
     58e:	e8 c0 fe ff ff       	call   453 <printint>
     593:	83 c4 10             	add    $0x10,%esp
        ap++;
     596:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     59a:	e9 d8 00 00 00       	jmp    677 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     59f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5a3:	74 06                	je     5ab <printf+0xa4>
     5a5:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5a9:	75 1e                	jne    5c9 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     5ab:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5ae:	8b 00                	mov    (%eax),%eax
     5b0:	6a 00                	push   $0x0
     5b2:	6a 10                	push   $0x10
     5b4:	50                   	push   %eax
     5b5:	ff 75 08             	pushl  0x8(%ebp)
     5b8:	e8 96 fe ff ff       	call   453 <printint>
     5bd:	83 c4 10             	add    $0x10,%esp
        ap++;
     5c0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5c4:	e9 ae 00 00 00       	jmp    677 <printf+0x170>
      } else if(c == 's'){
     5c9:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     5cd:	75 43                	jne    612 <printf+0x10b>
        s = (char*)*ap;
     5cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5d2:	8b 00                	mov    (%eax),%eax
     5d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     5d7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     5db:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5df:	75 25                	jne    606 <printf+0xff>
          s = "(null)";
     5e1:	c7 45 f4 d8 24 00 00 	movl   $0x24d8,-0xc(%ebp)
        while(*s != 0){
     5e8:	eb 1c                	jmp    606 <printf+0xff>
          putc(fd, *s);
     5ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5ed:	0f b6 00             	movzbl (%eax),%eax
     5f0:	0f be c0             	movsbl %al,%eax
     5f3:	83 ec 08             	sub    $0x8,%esp
     5f6:	50                   	push   %eax
     5f7:	ff 75 08             	pushl  0x8(%ebp)
     5fa:	e8 31 fe ff ff       	call   430 <putc>
     5ff:	83 c4 10             	add    $0x10,%esp
          s++;
     602:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     606:	8b 45 f4             	mov    -0xc(%ebp),%eax
     609:	0f b6 00             	movzbl (%eax),%eax
     60c:	84 c0                	test   %al,%al
     60e:	75 da                	jne    5ea <printf+0xe3>
     610:	eb 65                	jmp    677 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     612:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     616:	75 1d                	jne    635 <printf+0x12e>
        putc(fd, *ap);
     618:	8b 45 e8             	mov    -0x18(%ebp),%eax
     61b:	8b 00                	mov    (%eax),%eax
     61d:	0f be c0             	movsbl %al,%eax
     620:	83 ec 08             	sub    $0x8,%esp
     623:	50                   	push   %eax
     624:	ff 75 08             	pushl  0x8(%ebp)
     627:	e8 04 fe ff ff       	call   430 <putc>
     62c:	83 c4 10             	add    $0x10,%esp
        ap++;
     62f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     633:	eb 42                	jmp    677 <printf+0x170>
      } else if(c == '%'){
     635:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     639:	75 17                	jne    652 <printf+0x14b>
        putc(fd, c);
     63b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     63e:	0f be c0             	movsbl %al,%eax
     641:	83 ec 08             	sub    $0x8,%esp
     644:	50                   	push   %eax
     645:	ff 75 08             	pushl  0x8(%ebp)
     648:	e8 e3 fd ff ff       	call   430 <putc>
     64d:	83 c4 10             	add    $0x10,%esp
     650:	eb 25                	jmp    677 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     652:	83 ec 08             	sub    $0x8,%esp
     655:	6a 25                	push   $0x25
     657:	ff 75 08             	pushl  0x8(%ebp)
     65a:	e8 d1 fd ff ff       	call   430 <putc>
     65f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     662:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     665:	0f be c0             	movsbl %al,%eax
     668:	83 ec 08             	sub    $0x8,%esp
     66b:	50                   	push   %eax
     66c:	ff 75 08             	pushl  0x8(%ebp)
     66f:	e8 bc fd ff ff       	call   430 <putc>
     674:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     677:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     67e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     682:	8b 55 0c             	mov    0xc(%ebp),%edx
     685:	8b 45 f0             	mov    -0x10(%ebp),%eax
     688:	01 d0                	add    %edx,%eax
     68a:	0f b6 00             	movzbl (%eax),%eax
     68d:	84 c0                	test   %al,%al
     68f:	0f 85 94 fe ff ff    	jne    529 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     695:	90                   	nop
     696:	c9                   	leave  
     697:	c3                   	ret    

00000698 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     698:	55                   	push   %ebp
     699:	89 e5                	mov    %esp,%ebp
     69b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     69e:	8b 45 08             	mov    0x8(%ebp),%eax
     6a1:	83 e8 08             	sub    $0x8,%eax
     6a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6a7:	a1 40 68 00 00       	mov    0x6840,%eax
     6ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6af:	eb 24                	jmp    6d5 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b4:	8b 00                	mov    (%eax),%eax
     6b6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6b9:	77 12                	ja     6cd <free+0x35>
     6bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6be:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6c1:	77 24                	ja     6e7 <free+0x4f>
     6c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c6:	8b 00                	mov    (%eax),%eax
     6c8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6cb:	77 1a                	ja     6e7 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d0:	8b 00                	mov    (%eax),%eax
     6d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6d8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6db:	76 d4                	jbe    6b1 <free+0x19>
     6dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e0:	8b 00                	mov    (%eax),%eax
     6e2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6e5:	76 ca                	jbe    6b1 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     6e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ea:	8b 40 04             	mov    0x4(%eax),%eax
     6ed:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6f7:	01 c2                	add    %eax,%edx
     6f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6fc:	8b 00                	mov    (%eax),%eax
     6fe:	39 c2                	cmp    %eax,%edx
     700:	75 24                	jne    726 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     702:	8b 45 f8             	mov    -0x8(%ebp),%eax
     705:	8b 50 04             	mov    0x4(%eax),%edx
     708:	8b 45 fc             	mov    -0x4(%ebp),%eax
     70b:	8b 00                	mov    (%eax),%eax
     70d:	8b 40 04             	mov    0x4(%eax),%eax
     710:	01 c2                	add    %eax,%edx
     712:	8b 45 f8             	mov    -0x8(%ebp),%eax
     715:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     718:	8b 45 fc             	mov    -0x4(%ebp),%eax
     71b:	8b 00                	mov    (%eax),%eax
     71d:	8b 10                	mov    (%eax),%edx
     71f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     722:	89 10                	mov    %edx,(%eax)
     724:	eb 0a                	jmp    730 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     726:	8b 45 fc             	mov    -0x4(%ebp),%eax
     729:	8b 10                	mov    (%eax),%edx
     72b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     72e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     730:	8b 45 fc             	mov    -0x4(%ebp),%eax
     733:	8b 40 04             	mov    0x4(%eax),%eax
     736:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     73d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     740:	01 d0                	add    %edx,%eax
     742:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     745:	75 20                	jne    767 <free+0xcf>
    p->s.size += bp->s.size;
     747:	8b 45 fc             	mov    -0x4(%ebp),%eax
     74a:	8b 50 04             	mov    0x4(%eax),%edx
     74d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     750:	8b 40 04             	mov    0x4(%eax),%eax
     753:	01 c2                	add    %eax,%edx
     755:	8b 45 fc             	mov    -0x4(%ebp),%eax
     758:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     75b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     75e:	8b 10                	mov    (%eax),%edx
     760:	8b 45 fc             	mov    -0x4(%ebp),%eax
     763:	89 10                	mov    %edx,(%eax)
     765:	eb 08                	jmp    76f <free+0xd7>
  } else
    p->s.ptr = bp;
     767:	8b 45 fc             	mov    -0x4(%ebp),%eax
     76a:	8b 55 f8             	mov    -0x8(%ebp),%edx
     76d:	89 10                	mov    %edx,(%eax)
  freep = p;
     76f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     772:	a3 40 68 00 00       	mov    %eax,0x6840
}
     777:	90                   	nop
     778:	c9                   	leave  
     779:	c3                   	ret    

0000077a <morecore>:

static Header*
morecore(uint nu)
{
     77a:	55                   	push   %ebp
     77b:	89 e5                	mov    %esp,%ebp
     77d:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     780:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     787:	77 07                	ja     790 <morecore+0x16>
    nu = 4096;
     789:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     790:	8b 45 08             	mov    0x8(%ebp),%eax
     793:	c1 e0 03             	shl    $0x3,%eax
     796:	83 ec 0c             	sub    $0xc,%esp
     799:	50                   	push   %eax
     79a:	e8 41 fc ff ff       	call   3e0 <sbrk>
     79f:	83 c4 10             	add    $0x10,%esp
     7a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7a5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7a9:	75 07                	jne    7b2 <morecore+0x38>
    return 0;
     7ab:	b8 00 00 00 00       	mov    $0x0,%eax
     7b0:	eb 26                	jmp    7d8 <morecore+0x5e>
  hp = (Header*)p;
     7b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7bb:	8b 55 08             	mov    0x8(%ebp),%edx
     7be:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     7c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7c4:	83 c0 08             	add    $0x8,%eax
     7c7:	83 ec 0c             	sub    $0xc,%esp
     7ca:	50                   	push   %eax
     7cb:	e8 c8 fe ff ff       	call   698 <free>
     7d0:	83 c4 10             	add    $0x10,%esp
  return freep;
     7d3:	a1 40 68 00 00       	mov    0x6840,%eax
}
     7d8:	c9                   	leave  
     7d9:	c3                   	ret    

000007da <malloc>:

void*
malloc(uint nbytes)
{
     7da:	55                   	push   %ebp
     7db:	89 e5                	mov    %esp,%ebp
     7dd:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     7e0:	8b 45 08             	mov    0x8(%ebp),%eax
     7e3:	83 c0 07             	add    $0x7,%eax
     7e6:	c1 e8 03             	shr    $0x3,%eax
     7e9:	83 c0 01             	add    $0x1,%eax
     7ec:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     7ef:	a1 40 68 00 00       	mov    0x6840,%eax
     7f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7f7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7fb:	75 23                	jne    820 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     7fd:	c7 45 f0 38 68 00 00 	movl   $0x6838,-0x10(%ebp)
     804:	8b 45 f0             	mov    -0x10(%ebp),%eax
     807:	a3 40 68 00 00       	mov    %eax,0x6840
     80c:	a1 40 68 00 00       	mov    0x6840,%eax
     811:	a3 38 68 00 00       	mov    %eax,0x6838
    base.s.size = 0;
     816:	c7 05 3c 68 00 00 00 	movl   $0x0,0x683c
     81d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     820:	8b 45 f0             	mov    -0x10(%ebp),%eax
     823:	8b 00                	mov    (%eax),%eax
     825:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     828:	8b 45 f4             	mov    -0xc(%ebp),%eax
     82b:	8b 40 04             	mov    0x4(%eax),%eax
     82e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     831:	72 4d                	jb     880 <malloc+0xa6>
      if(p->s.size == nunits)
     833:	8b 45 f4             	mov    -0xc(%ebp),%eax
     836:	8b 40 04             	mov    0x4(%eax),%eax
     839:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     83c:	75 0c                	jne    84a <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     83e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     841:	8b 10                	mov    (%eax),%edx
     843:	8b 45 f0             	mov    -0x10(%ebp),%eax
     846:	89 10                	mov    %edx,(%eax)
     848:	eb 26                	jmp    870 <malloc+0x96>
      else {
        p->s.size -= nunits;
     84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     84d:	8b 40 04             	mov    0x4(%eax),%eax
     850:	2b 45 ec             	sub    -0x14(%ebp),%eax
     853:	89 c2                	mov    %eax,%edx
     855:	8b 45 f4             	mov    -0xc(%ebp),%eax
     858:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     85b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85e:	8b 40 04             	mov    0x4(%eax),%eax
     861:	c1 e0 03             	shl    $0x3,%eax
     864:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     867:	8b 45 f4             	mov    -0xc(%ebp),%eax
     86a:	8b 55 ec             	mov    -0x14(%ebp),%edx
     86d:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     870:	8b 45 f0             	mov    -0x10(%ebp),%eax
     873:	a3 40 68 00 00       	mov    %eax,0x6840
      return (void*)(p + 1);
     878:	8b 45 f4             	mov    -0xc(%ebp),%eax
     87b:	83 c0 08             	add    $0x8,%eax
     87e:	eb 3b                	jmp    8bb <malloc+0xe1>
    }
    if(p == freep)
     880:	a1 40 68 00 00       	mov    0x6840,%eax
     885:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     888:	75 1e                	jne    8a8 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     88a:	83 ec 0c             	sub    $0xc,%esp
     88d:	ff 75 ec             	pushl  -0x14(%ebp)
     890:	e8 e5 fe ff ff       	call   77a <morecore>
     895:	83 c4 10             	add    $0x10,%esp
     898:	89 45 f4             	mov    %eax,-0xc(%ebp)
     89b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     89f:	75 07                	jne    8a8 <malloc+0xce>
        return 0;
     8a1:	b8 00 00 00 00       	mov    $0x0,%eax
     8a6:	eb 13                	jmp    8bb <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8b1:	8b 00                	mov    (%eax),%eax
     8b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     8b6:	e9 6d ff ff ff       	jmp    828 <malloc+0x4e>
}
     8bb:	c9                   	leave  
     8bc:	c3                   	ret    

000008bd <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     8bd:	55                   	push   %ebp
     8be:	89 e5                	mov    %esp,%ebp
     8c0:	83 ec 1c             	sub    $0x1c,%esp
     8c3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     8c6:	8b 55 10             	mov    0x10(%ebp),%edx
     8c9:	8b 45 14             	mov    0x14(%ebp),%eax
     8cc:	88 4d ec             	mov    %cl,-0x14(%ebp)
     8cf:	88 55 e8             	mov    %dl,-0x18(%ebp)
     8d2:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     8d5:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     8d9:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     8dc:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     8e0:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     8e3:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     8e7:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     8ea:	8b 45 08             	mov    0x8(%ebp),%eax
     8ed:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     8f1:	66 89 10             	mov    %dx,(%eax)
     8f4:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     8f8:	88 50 02             	mov    %dl,0x2(%eax)
}
     8fb:	8b 45 08             	mov    0x8(%ebp),%eax
     8fe:	c9                   	leave  
     8ff:	c2 04 00             	ret    $0x4

00000902 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     902:	55                   	push   %ebp
     903:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     905:	8b 45 08             	mov    0x8(%ebp),%eax
     908:	2b 45 10             	sub    0x10(%ebp),%eax
     90b:	89 c2                	mov    %eax,%edx
     90d:	8b 45 08             	mov    0x8(%ebp),%eax
     910:	2b 45 10             	sub    0x10(%ebp),%eax
     913:	0f af d0             	imul   %eax,%edx
     916:	8b 45 0c             	mov    0xc(%ebp),%eax
     919:	2b 45 14             	sub    0x14(%ebp),%eax
     91c:	89 c1                	mov    %eax,%ecx
     91e:	8b 45 0c             	mov    0xc(%ebp),%eax
     921:	2b 45 14             	sub    0x14(%ebp),%eax
     924:	0f af c1             	imul   %ecx,%eax
     927:	01 d0                	add    %edx,%eax
}
     929:	5d                   	pop    %ebp
     92a:	c3                   	ret    

0000092b <abs_int>:

static inline int abs_int(int x)
{
     92b:	55                   	push   %ebp
     92c:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     92e:	8b 45 08             	mov    0x8(%ebp),%eax
     931:	99                   	cltd   
     932:	89 d0                	mov    %edx,%eax
     934:	33 45 08             	xor    0x8(%ebp),%eax
     937:	29 d0                	sub    %edx,%eax
}
     939:	5d                   	pop    %ebp
     93a:	c3                   	ret    

0000093b <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     93b:	55                   	push   %ebp
     93c:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     93e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     942:	79 07                	jns    94b <APGetIndex+0x10>
        return X_SMALLER;
     944:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     949:	eb 40                	jmp    98b <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     94b:	8b 45 08             	mov    0x8(%ebp),%eax
     94e:	8b 00                	mov    (%eax),%eax
     950:	3b 45 0c             	cmp    0xc(%ebp),%eax
     953:	7f 07                	jg     95c <APGetIndex+0x21>
        return X_BIGGER;
     955:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     95a:	eb 2f                	jmp    98b <APGetIndex+0x50>
    if (y < 0)
     95c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     960:	79 07                	jns    969 <APGetIndex+0x2e>
        return Y_SMALLER;
     962:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     967:	eb 22                	jmp    98b <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     969:	8b 45 08             	mov    0x8(%ebp),%eax
     96c:	8b 40 04             	mov    0x4(%eax),%eax
     96f:	3b 45 10             	cmp    0x10(%ebp),%eax
     972:	7f 07                	jg     97b <APGetIndex+0x40>
        return Y_BIGGER;
     974:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     979:	eb 10                	jmp    98b <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     97b:	8b 45 08             	mov    0x8(%ebp),%eax
     97e:	8b 00                	mov    (%eax),%eax
     980:	0f af 45 10          	imul   0x10(%ebp),%eax
     984:	89 c2                	mov    %eax,%edx
     986:	8b 45 0c             	mov    0xc(%ebp),%eax
     989:	01 d0                	add    %edx,%eax
}
     98b:	5d                   	pop    %ebp
     98c:	c3                   	ret    

0000098d <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     98d:	55                   	push   %ebp
     98e:	89 e5                	mov    %esp,%ebp
     990:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     993:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     99a:	8b 45 cc             	mov    -0x34(%ebp),%eax
     99d:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     9a0:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     9a7:	83 ec 08             	sub    $0x8,%esp
     9aa:	6a 00                	push   $0x0
     9ac:	ff 75 0c             	pushl  0xc(%ebp)
     9af:	e8 e4 f9 ff ff       	call   398 <open>
     9b4:	83 c4 10             	add    $0x10,%esp
     9b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     9ba:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     9be:	79 2e                	jns    9ee <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     9c0:	83 ec 04             	sub    $0x4,%esp
     9c3:	ff 75 0c             	pushl  0xc(%ebp)
     9c6:	68 df 24 00 00       	push   $0x24df
     9cb:	6a 01                	push   $0x1
     9cd:	e8 35 fb ff ff       	call   507 <printf>
     9d2:	83 c4 10             	add    $0x10,%esp
        return bmp;
     9d5:	8b 45 08             	mov    0x8(%ebp),%eax
     9d8:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9db:	89 10                	mov    %edx,(%eax)
     9dd:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9e0:	89 50 04             	mov    %edx,0x4(%eax)
     9e3:	8b 55 d0             	mov    -0x30(%ebp),%edx
     9e6:	89 50 08             	mov    %edx,0x8(%eax)
     9e9:	e9 d2 01 00 00       	jmp    bc0 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     9ee:	83 ec 04             	sub    $0x4,%esp
     9f1:	6a 0e                	push   $0xe
     9f3:	8d 45 ba             	lea    -0x46(%ebp),%eax
     9f6:	50                   	push   %eax
     9f7:	ff 75 ec             	pushl  -0x14(%ebp)
     9fa:	e8 71 f9 ff ff       	call   370 <read>
     9ff:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     a02:	83 ec 04             	sub    $0x4,%esp
     a05:	6a 28                	push   $0x28
     a07:	8d 45 92             	lea    -0x6e(%ebp),%eax
     a0a:	50                   	push   %eax
     a0b:	ff 75 ec             	pushl  -0x14(%ebp)
     a0e:	e8 5d f9 ff ff       	call   370 <read>
     a13:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     a16:	8b 45 96             	mov    -0x6a(%ebp),%eax
     a19:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     a1c:	8b 45 9a             	mov    -0x66(%ebp),%eax
     a1f:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     a22:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a25:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a28:	0f af d0             	imul   %eax,%edx
     a2b:	89 d0                	mov    %edx,%eax
     a2d:	01 c0                	add    %eax,%eax
     a2f:	01 d0                	add    %edx,%eax
     a31:	83 ec 0c             	sub    $0xc,%esp
     a34:	50                   	push   %eax
     a35:	e8 a0 fd ff ff       	call   7da <malloc>
     a3a:	83 c4 10             	add    $0x10,%esp
     a3d:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     a40:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a44:	0f b7 c0             	movzwl %ax,%eax
     a47:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     a4a:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a4d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a50:	0f af c2             	imul   %edx,%eax
     a53:	83 c0 1f             	add    $0x1f,%eax
     a56:	c1 e8 05             	shr    $0x5,%eax
     a59:	c1 e0 02             	shl    $0x2,%eax
     a5c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     a5f:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a65:	0f af c2             	imul   %edx,%eax
     a68:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     a6b:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a6e:	83 ec 0c             	sub    $0xc,%esp
     a71:	50                   	push   %eax
     a72:	e8 63 fd ff ff       	call   7da <malloc>
     a77:	83 c4 10             	add    $0x10,%esp
     a7a:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a7d:	83 ec 04             	sub    $0x4,%esp
     a80:	ff 75 e0             	pushl  -0x20(%ebp)
     a83:	ff 75 dc             	pushl  -0x24(%ebp)
     a86:	ff 75 ec             	pushl  -0x14(%ebp)
     a89:	e8 e2 f8 ff ff       	call   370 <read>
     a8e:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a91:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a95:	66 c1 e8 03          	shr    $0x3,%ax
     a99:	0f b7 c0             	movzwl %ax,%eax
     a9c:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a9f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     aa6:	e9 e5 00 00 00       	jmp    b90 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     aab:	8b 55 cc             	mov    -0x34(%ebp),%edx
     aae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab1:	29 c2                	sub    %eax,%edx
     ab3:	89 d0                	mov    %edx,%eax
     ab5:	8d 50 ff             	lea    -0x1(%eax),%edx
     ab8:	8b 45 c8             	mov    -0x38(%ebp),%eax
     abb:	0f af c2             	imul   %edx,%eax
     abe:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     ac1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ac8:	e9 b1 00 00 00       	jmp    b7e <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     acd:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ad0:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ad3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ad6:	01 c8                	add    %ecx,%eax
     ad8:	89 c1                	mov    %eax,%ecx
     ada:	89 c8                	mov    %ecx,%eax
     adc:	01 c0                	add    %eax,%eax
     ade:	01 c8                	add    %ecx,%eax
     ae0:	01 c2                	add    %eax,%edx
     ae2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae5:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ae9:	89 c1                	mov    %eax,%ecx
     aeb:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aee:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     af2:	01 c1                	add    %eax,%ecx
     af4:	8b 45 d8             	mov    -0x28(%ebp),%eax
     af7:	01 c8                	add    %ecx,%eax
     af9:	8d 48 ff             	lea    -0x1(%eax),%ecx
     afc:	8b 45 dc             	mov    -0x24(%ebp),%eax
     aff:	01 c8                	add    %ecx,%eax
     b01:	0f b6 00             	movzbl (%eax),%eax
     b04:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     b07:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b0a:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b10:	01 c8                	add    %ecx,%eax
     b12:	89 c1                	mov    %eax,%ecx
     b14:	89 c8                	mov    %ecx,%eax
     b16:	01 c0                	add    %eax,%eax
     b18:	01 c8                	add    %ecx,%eax
     b1a:	01 c2                	add    %eax,%edx
     b1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b1f:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b23:	89 c1                	mov    %eax,%ecx
     b25:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b28:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b2c:	01 c1                	add    %eax,%ecx
     b2e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b31:	01 c8                	add    %ecx,%eax
     b33:	8d 48 fe             	lea    -0x2(%eax),%ecx
     b36:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b39:	01 c8                	add    %ecx,%eax
     b3b:	0f b6 00             	movzbl (%eax),%eax
     b3e:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     b41:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b44:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b47:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b4a:	01 c8                	add    %ecx,%eax
     b4c:	89 c1                	mov    %eax,%ecx
     b4e:	89 c8                	mov    %ecx,%eax
     b50:	01 c0                	add    %eax,%eax
     b52:	01 c8                	add    %ecx,%eax
     b54:	01 c2                	add    %eax,%edx
     b56:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b59:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b5d:	89 c1                	mov    %eax,%ecx
     b5f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b62:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b66:	01 c1                	add    %eax,%ecx
     b68:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b6b:	01 c8                	add    %ecx,%eax
     b6d:	8d 48 fd             	lea    -0x3(%eax),%ecx
     b70:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b73:	01 c8                	add    %ecx,%eax
     b75:	0f b6 00             	movzbl (%eax),%eax
     b78:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     b7a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b7e:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b81:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b84:	39 c2                	cmp    %eax,%edx
     b86:	0f 87 41 ff ff ff    	ja     acd <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b8c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b90:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b93:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b96:	39 c2                	cmp    %eax,%edx
     b98:	0f 87 0d ff ff ff    	ja     aab <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b9e:	83 ec 0c             	sub    $0xc,%esp
     ba1:	ff 75 ec             	pushl  -0x14(%ebp)
     ba4:	e8 d7 f7 ff ff       	call   380 <close>
     ba9:	83 c4 10             	add    $0x10,%esp
    return bmp;
     bac:	8b 45 08             	mov    0x8(%ebp),%eax
     baf:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bb2:	89 10                	mov    %edx,(%eax)
     bb4:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bb7:	89 50 04             	mov    %edx,0x4(%eax)
     bba:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bbd:	89 50 08             	mov    %edx,0x8(%eax)
}
     bc0:	8b 45 08             	mov    0x8(%ebp),%eax
     bc3:	c9                   	leave  
     bc4:	c2 04 00             	ret    $0x4

00000bc7 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     bc7:	55                   	push   %ebp
     bc8:	89 e5                	mov    %esp,%ebp
     bca:	53                   	push   %ebx
     bcb:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     bce:	83 ec 0c             	sub    $0xc,%esp
     bd1:	6a 1c                	push   $0x1c
     bd3:	e8 02 fc ff ff       	call   7da <malloc>
     bd8:	83 c4 10             	add    $0x10,%esp
     bdb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     bde:	8b 45 f4             	mov    -0xc(%ebp),%eax
     be1:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     be8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     beb:	8d 45 d8             	lea    -0x28(%ebp),%eax
     bee:	6a 0c                	push   $0xc
     bf0:	6a 0c                	push   $0xc
     bf2:	6a 0c                	push   $0xc
     bf4:	50                   	push   %eax
     bf5:	e8 c3 fc ff ff       	call   8bd <RGB>
     bfa:	83 c4 0c             	add    $0xc,%esp
     bfd:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     c01:	66 89 43 13          	mov    %ax,0x13(%ebx)
     c05:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     c09:	88 43 15             	mov    %al,0x15(%ebx)
     c0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c0f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c12:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     c16:	66 89 48 10          	mov    %cx,0x10(%eax)
     c1a:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     c1e:	88 50 12             	mov    %dl,0x12(%eax)
     c21:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c24:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c27:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     c2b:	66 89 48 08          	mov    %cx,0x8(%eax)
     c2f:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     c33:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     c36:	8b 45 08             	mov    0x8(%ebp),%eax
     c39:	89 c2                	mov    %eax,%edx
     c3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c3e:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     c40:	8b 45 0c             	mov    0xc(%ebp),%eax
     c43:	89 c2                	mov    %eax,%edx
     c45:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c48:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     c4b:	8b 55 10             	mov    0x10(%ebp),%edx
     c4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c51:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     c54:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c57:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c5a:	c9                   	leave  
     c5b:	c3                   	ret    

00000c5c <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     c5c:	55                   	push   %ebp
     c5d:	89 e5                	mov    %esp,%ebp
     c5f:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     c62:	8b 45 0c             	mov    0xc(%ebp),%eax
     c65:	8b 50 08             	mov    0x8(%eax),%edx
     c68:	89 55 f8             	mov    %edx,-0x8(%ebp)
     c6b:	8b 40 0c             	mov    0xc(%eax),%eax
     c6e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     c71:	8b 45 0c             	mov    0xc(%ebp),%eax
     c74:	8b 55 10             	mov    0x10(%ebp),%edx
     c77:	89 50 08             	mov    %edx,0x8(%eax)
     c7a:	8b 55 14             	mov    0x14(%ebp),%edx
     c7d:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c80:	8b 45 08             	mov    0x8(%ebp),%eax
     c83:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c86:	89 10                	mov    %edx,(%eax)
     c88:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c8b:	89 50 04             	mov    %edx,0x4(%eax)
}
     c8e:	8b 45 08             	mov    0x8(%ebp),%eax
     c91:	c9                   	leave  
     c92:	c2 04 00             	ret    $0x4

00000c95 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c95:	55                   	push   %ebp
     c96:	89 e5                	mov    %esp,%ebp
     c98:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c9b:	8b 45 0c             	mov    0xc(%ebp),%eax
     c9e:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     ca2:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     ca6:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     caa:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     cad:	8b 45 0c             	mov    0xc(%ebp),%eax
     cb0:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     cb4:	66 89 50 10          	mov    %dx,0x10(%eax)
     cb8:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     cbc:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     cbf:	8b 45 08             	mov    0x8(%ebp),%eax
     cc2:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     cc6:	66 89 10             	mov    %dx,(%eax)
     cc9:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     ccd:	88 50 02             	mov    %dl,0x2(%eax)
}
     cd0:	8b 45 08             	mov    0x8(%ebp),%eax
     cd3:	c9                   	leave  
     cd4:	c2 04 00             	ret    $0x4

00000cd7 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     cd7:	55                   	push   %ebp
     cd8:	89 e5                	mov    %esp,%ebp
     cda:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     cdd:	8b 45 0c             	mov    0xc(%ebp),%eax
     ce0:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     ce4:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     ce8:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     cec:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     cef:	8b 45 0c             	mov    0xc(%ebp),%eax
     cf2:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     cf6:	66 89 50 13          	mov    %dx,0x13(%eax)
     cfa:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     cfe:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     d01:	8b 45 08             	mov    0x8(%ebp),%eax
     d04:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d08:	66 89 10             	mov    %dx,(%eax)
     d0b:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d0f:	88 50 02             	mov    %dl,0x2(%eax)
}
     d12:	8b 45 08             	mov    0x8(%ebp),%eax
     d15:	c9                   	leave  
     d16:	c2 04 00             	ret    $0x4

00000d19 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     d19:	55                   	push   %ebp
     d1a:	89 e5                	mov    %esp,%ebp
     d1c:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     d1f:	8b 45 08             	mov    0x8(%ebp),%eax
     d22:	8b 40 0c             	mov    0xc(%eax),%eax
     d25:	89 c2                	mov    %eax,%edx
     d27:	c1 ea 1f             	shr    $0x1f,%edx
     d2a:	01 d0                	add    %edx,%eax
     d2c:	d1 f8                	sar    %eax
     d2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     d31:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d34:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     d38:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     d3b:	8b 45 10             	mov    0x10(%ebp),%eax
     d3e:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d41:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     d44:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     d48:	0f 89 98 00 00 00    	jns    de6 <APDrawPoint+0xcd>
        i = 0;
     d4e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     d55:	e9 8c 00 00 00       	jmp    de6 <APDrawPoint+0xcd>
    {
        j = x - off;
     d5a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d5d:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d60:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d63:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d67:	79 69                	jns    dd2 <APDrawPoint+0xb9>
            j = 0;
     d69:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d70:	eb 60                	jmp    dd2 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d72:	ff 75 fc             	pushl  -0x4(%ebp)
     d75:	ff 75 f8             	pushl  -0x8(%ebp)
     d78:	ff 75 08             	pushl  0x8(%ebp)
     d7b:	e8 bb fb ff ff       	call   93b <APGetIndex>
     d80:	83 c4 0c             	add    $0xc,%esp
     d83:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d86:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d8a:	74 55                	je     de1 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d8c:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d90:	74 67                	je     df9 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d92:	ff 75 10             	pushl  0x10(%ebp)
     d95:	ff 75 0c             	pushl  0xc(%ebp)
     d98:	ff 75 fc             	pushl  -0x4(%ebp)
     d9b:	ff 75 f8             	pushl  -0x8(%ebp)
     d9e:	e8 5f fb ff ff       	call   902 <distance_2>
     da3:	83 c4 10             	add    $0x10,%esp
     da6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     da9:	7f 23                	jg     dce <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     dab:	8b 45 08             	mov    0x8(%ebp),%eax
     dae:	8b 48 18             	mov    0x18(%eax),%ecx
     db1:	8b 55 ec             	mov    -0x14(%ebp),%edx
     db4:	89 d0                	mov    %edx,%eax
     db6:	01 c0                	add    %eax,%eax
     db8:	01 d0                	add    %edx,%eax
     dba:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     dbd:	8b 45 08             	mov    0x8(%ebp),%eax
     dc0:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     dc4:	66 89 0a             	mov    %cx,(%edx)
     dc7:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     dcb:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     dce:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     dd2:	8b 55 0c             	mov    0xc(%ebp),%edx
     dd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dd8:	01 d0                	add    %edx,%eax
     dda:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     ddd:	7d 93                	jge    d72 <APDrawPoint+0x59>
     ddf:	eb 01                	jmp    de2 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     de1:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     de2:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     de6:	8b 55 10             	mov    0x10(%ebp),%edx
     de9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dec:	01 d0                	add    %edx,%eax
     dee:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     df1:	0f 8d 63 ff ff ff    	jge    d5a <APDrawPoint+0x41>
     df7:	eb 01                	jmp    dfa <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     df9:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     dfa:	c9                   	leave  
     dfb:	c3                   	ret    

00000dfc <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     dfc:	55                   	push   %ebp
     dfd:	89 e5                	mov    %esp,%ebp
     dff:	53                   	push   %ebx
     e00:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     e03:	8b 45 0c             	mov    0xc(%ebp),%eax
     e06:	3b 45 14             	cmp    0x14(%ebp),%eax
     e09:	0f 85 80 00 00 00    	jne    e8f <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     e0f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e13:	0f 88 9d 02 00 00    	js     10b6 <APDrawLine+0x2ba>
     e19:	8b 45 08             	mov    0x8(%ebp),%eax
     e1c:	8b 00                	mov    (%eax),%eax
     e1e:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e21:	0f 8e 8f 02 00 00    	jle    10b6 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     e27:	8b 45 10             	mov    0x10(%ebp),%eax
     e2a:	3b 45 18             	cmp    0x18(%ebp),%eax
     e2d:	7e 12                	jle    e41 <APDrawLine+0x45>
        {
            int tmp = y2;
     e2f:	8b 45 18             	mov    0x18(%ebp),%eax
     e32:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     e35:	8b 45 10             	mov    0x10(%ebp),%eax
     e38:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     e3b:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e3e:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     e41:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e45:	79 07                	jns    e4e <APDrawLine+0x52>
     e47:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e4e:	8b 45 08             	mov    0x8(%ebp),%eax
     e51:	8b 40 04             	mov    0x4(%eax),%eax
     e54:	3b 45 18             	cmp    0x18(%ebp),%eax
     e57:	7d 0c                	jge    e65 <APDrawLine+0x69>
     e59:	8b 45 08             	mov    0x8(%ebp),%eax
     e5c:	8b 40 04             	mov    0x4(%eax),%eax
     e5f:	83 e8 01             	sub    $0x1,%eax
     e62:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e65:	8b 45 10             	mov    0x10(%ebp),%eax
     e68:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e6b:	eb 15                	jmp    e82 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e6d:	ff 75 f4             	pushl  -0xc(%ebp)
     e70:	ff 75 0c             	pushl  0xc(%ebp)
     e73:	ff 75 08             	pushl  0x8(%ebp)
     e76:	e8 9e fe ff ff       	call   d19 <APDrawPoint>
     e7b:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e7e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e82:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e85:	3b 45 18             	cmp    0x18(%ebp),%eax
     e88:	7e e3                	jle    e6d <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e8a:	e9 2b 02 00 00       	jmp    10ba <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e8f:	8b 45 10             	mov    0x10(%ebp),%eax
     e92:	3b 45 18             	cmp    0x18(%ebp),%eax
     e95:	75 7f                	jne    f16 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e97:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e9b:	0f 88 18 02 00 00    	js     10b9 <APDrawLine+0x2bd>
     ea1:	8b 45 08             	mov    0x8(%ebp),%eax
     ea4:	8b 40 04             	mov    0x4(%eax),%eax
     ea7:	3b 45 10             	cmp    0x10(%ebp),%eax
     eaa:	0f 8e 09 02 00 00    	jle    10b9 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     eb0:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb3:	3b 45 14             	cmp    0x14(%ebp),%eax
     eb6:	7e 12                	jle    eca <APDrawLine+0xce>
        {
            int tmp = x2;
     eb8:	8b 45 14             	mov    0x14(%ebp),%eax
     ebb:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     ebe:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec1:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     ec4:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ec7:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     eca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ece:	79 07                	jns    ed7 <APDrawLine+0xdb>
     ed0:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     ed7:	8b 45 08             	mov    0x8(%ebp),%eax
     eda:	8b 00                	mov    (%eax),%eax
     edc:	3b 45 14             	cmp    0x14(%ebp),%eax
     edf:	7d 0b                	jge    eec <APDrawLine+0xf0>
     ee1:	8b 45 08             	mov    0x8(%ebp),%eax
     ee4:	8b 00                	mov    (%eax),%eax
     ee6:	83 e8 01             	sub    $0x1,%eax
     ee9:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     eec:	8b 45 0c             	mov    0xc(%ebp),%eax
     eef:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ef2:	eb 15                	jmp    f09 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     ef4:	ff 75 10             	pushl  0x10(%ebp)
     ef7:	ff 75 f0             	pushl  -0x10(%ebp)
     efa:	ff 75 08             	pushl  0x8(%ebp)
     efd:	e8 17 fe ff ff       	call   d19 <APDrawPoint>
     f02:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     f05:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f09:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f0c:	3b 45 14             	cmp    0x14(%ebp),%eax
     f0f:	7e e3                	jle    ef4 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     f11:	e9 a4 01 00 00       	jmp    10ba <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     f16:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f1d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     f24:	8b 45 0c             	mov    0xc(%ebp),%eax
     f27:	2b 45 14             	sub    0x14(%ebp),%eax
     f2a:	50                   	push   %eax
     f2b:	e8 fb f9 ff ff       	call   92b <abs_int>
     f30:	83 c4 04             	add    $0x4,%esp
     f33:	89 c3                	mov    %eax,%ebx
     f35:	8b 45 10             	mov    0x10(%ebp),%eax
     f38:	2b 45 18             	sub    0x18(%ebp),%eax
     f3b:	50                   	push   %eax
     f3c:	e8 ea f9 ff ff       	call   92b <abs_int>
     f41:	83 c4 04             	add    $0x4,%esp
     f44:	39 c3                	cmp    %eax,%ebx
     f46:	0f 8e b5 00 00 00    	jle    1001 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f4c:	8b 45 10             	mov    0x10(%ebp),%eax
     f4f:	2b 45 18             	sub    0x18(%ebp),%eax
     f52:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f55:	db 45 b0             	fildl  -0x50(%ebp)
     f58:	8b 45 0c             	mov    0xc(%ebp),%eax
     f5b:	2b 45 14             	sub    0x14(%ebp),%eax
     f5e:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f61:	db 45 b0             	fildl  -0x50(%ebp)
     f64:	de f9                	fdivrp %st,%st(1)
     f66:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f69:	8b 45 14             	mov    0x14(%ebp),%eax
     f6c:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f6f:	7e 0e                	jle    f7f <APDrawLine+0x183>
        {
            s = x1;
     f71:	8b 45 0c             	mov    0xc(%ebp),%eax
     f74:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f77:	8b 45 14             	mov    0x14(%ebp),%eax
     f7a:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f7d:	eb 0c                	jmp    f8b <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f7f:	8b 45 14             	mov    0x14(%ebp),%eax
     f82:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f85:	8b 45 0c             	mov    0xc(%ebp),%eax
     f88:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f8b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f8f:	79 07                	jns    f98 <APDrawLine+0x19c>
     f91:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f98:	8b 45 08             	mov    0x8(%ebp),%eax
     f9b:	8b 00                	mov    (%eax),%eax
     f9d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fa0:	7f 0b                	jg     fad <APDrawLine+0x1b1>
     fa2:	8b 45 08             	mov    0x8(%ebp),%eax
     fa5:	8b 00                	mov    (%eax),%eax
     fa7:	83 e8 01             	sub    $0x1,%eax
     faa:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     fad:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fb0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     fb3:	eb 3f                	jmp    ff4 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     fb5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fb8:	2b 45 0c             	sub    0xc(%ebp),%eax
     fbb:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fbe:	db 45 b0             	fildl  -0x50(%ebp)
     fc1:	dc 4d d0             	fmull  -0x30(%ebp)
     fc4:	db 45 10             	fildl  0x10(%ebp)
     fc7:	de c1                	faddp  %st,%st(1)
     fc9:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fcc:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fd0:	b4 0c                	mov    $0xc,%ah
     fd2:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fd6:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fd9:	db 5d cc             	fistpl -0x34(%ebp)
     fdc:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     fdf:	ff 75 cc             	pushl  -0x34(%ebp)
     fe2:	ff 75 e4             	pushl  -0x1c(%ebp)
     fe5:	ff 75 08             	pushl  0x8(%ebp)
     fe8:	e8 2c fd ff ff       	call   d19 <APDrawPoint>
     fed:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     ff0:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     ff4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ff7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ffa:	7e b9                	jle    fb5 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     ffc:	e9 b9 00 00 00       	jmp    10ba <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1001:	8b 45 0c             	mov    0xc(%ebp),%eax
    1004:	2b 45 14             	sub    0x14(%ebp),%eax
    1007:	89 45 b0             	mov    %eax,-0x50(%ebp)
    100a:	db 45 b0             	fildl  -0x50(%ebp)
    100d:	8b 45 10             	mov    0x10(%ebp),%eax
    1010:	2b 45 18             	sub    0x18(%ebp),%eax
    1013:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1016:	db 45 b0             	fildl  -0x50(%ebp)
    1019:	de f9                	fdivrp %st,%st(1)
    101b:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    101e:	8b 45 10             	mov    0x10(%ebp),%eax
    1021:	3b 45 18             	cmp    0x18(%ebp),%eax
    1024:	7e 0e                	jle    1034 <APDrawLine+0x238>
    {
        s = y2;
    1026:	8b 45 18             	mov    0x18(%ebp),%eax
    1029:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    102c:	8b 45 10             	mov    0x10(%ebp),%eax
    102f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1032:	eb 0c                	jmp    1040 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1034:	8b 45 10             	mov    0x10(%ebp),%eax
    1037:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    103a:	8b 45 18             	mov    0x18(%ebp),%eax
    103d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1040:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1044:	79 07                	jns    104d <APDrawLine+0x251>
    1046:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    104d:	8b 45 08             	mov    0x8(%ebp),%eax
    1050:	8b 40 04             	mov    0x4(%eax),%eax
    1053:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1056:	7f 0c                	jg     1064 <APDrawLine+0x268>
    1058:	8b 45 08             	mov    0x8(%ebp),%eax
    105b:	8b 40 04             	mov    0x4(%eax),%eax
    105e:	83 e8 01             	sub    $0x1,%eax
    1061:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1064:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1067:	89 45 e0             	mov    %eax,-0x20(%ebp)
    106a:	eb 3f                	jmp    10ab <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    106c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    106f:	2b 45 10             	sub    0x10(%ebp),%eax
    1072:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1075:	db 45 b0             	fildl  -0x50(%ebp)
    1078:	dc 4d c0             	fmull  -0x40(%ebp)
    107b:	db 45 0c             	fildl  0xc(%ebp)
    107e:	de c1                	faddp  %st,%st(1)
    1080:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1083:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1087:	b4 0c                	mov    $0xc,%ah
    1089:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    108d:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1090:	db 5d bc             	fistpl -0x44(%ebp)
    1093:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1096:	ff 75 e0             	pushl  -0x20(%ebp)
    1099:	ff 75 bc             	pushl  -0x44(%ebp)
    109c:	ff 75 08             	pushl  0x8(%ebp)
    109f:	e8 75 fc ff ff       	call   d19 <APDrawPoint>
    10a4:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    10a7:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    10ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10ae:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10b1:	7e b9                	jle    106c <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    10b3:	90                   	nop
    10b4:	eb 04                	jmp    10ba <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    10b6:	90                   	nop
    10b7:	eb 01                	jmp    10ba <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    10b9:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    10ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10bd:	c9                   	leave  
    10be:	c3                   	ret    

000010bf <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    10bf:	55                   	push   %ebp
    10c0:	89 e5                	mov    %esp,%ebp
    10c2:	53                   	push   %ebx
    10c3:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    10c6:	8b 55 10             	mov    0x10(%ebp),%edx
    10c9:	8b 45 18             	mov    0x18(%ebp),%eax
    10cc:	01 d0                	add    %edx,%eax
    10ce:	83 e8 01             	sub    $0x1,%eax
    10d1:	83 ec 04             	sub    $0x4,%esp
    10d4:	50                   	push   %eax
    10d5:	ff 75 0c             	pushl  0xc(%ebp)
    10d8:	ff 75 10             	pushl  0x10(%ebp)
    10db:	ff 75 0c             	pushl  0xc(%ebp)
    10de:	ff 75 08             	pushl  0x8(%ebp)
    10e1:	e8 16 fd ff ff       	call   dfc <APDrawLine>
    10e6:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    10e9:	8b 55 0c             	mov    0xc(%ebp),%edx
    10ec:	8b 45 14             	mov    0x14(%ebp),%eax
    10ef:	01 d0                	add    %edx,%eax
    10f1:	83 e8 01             	sub    $0x1,%eax
    10f4:	83 ec 04             	sub    $0x4,%esp
    10f7:	ff 75 10             	pushl  0x10(%ebp)
    10fa:	50                   	push   %eax
    10fb:	ff 75 10             	pushl  0x10(%ebp)
    10fe:	ff 75 0c             	pushl  0xc(%ebp)
    1101:	ff 75 08             	pushl  0x8(%ebp)
    1104:	e8 f3 fc ff ff       	call   dfc <APDrawLine>
    1109:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    110c:	8b 55 10             	mov    0x10(%ebp),%edx
    110f:	8b 45 18             	mov    0x18(%ebp),%eax
    1112:	01 d0                	add    %edx,%eax
    1114:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1117:	8b 55 0c             	mov    0xc(%ebp),%edx
    111a:	8b 45 14             	mov    0x14(%ebp),%eax
    111d:	01 d0                	add    %edx,%eax
    111f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1122:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1125:	8b 45 14             	mov    0x14(%ebp),%eax
    1128:	01 d8                	add    %ebx,%eax
    112a:	83 e8 01             	sub    $0x1,%eax
    112d:	83 ec 04             	sub    $0x4,%esp
    1130:	51                   	push   %ecx
    1131:	52                   	push   %edx
    1132:	ff 75 10             	pushl  0x10(%ebp)
    1135:	50                   	push   %eax
    1136:	ff 75 08             	pushl  0x8(%ebp)
    1139:	e8 be fc ff ff       	call   dfc <APDrawLine>
    113e:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1141:	8b 55 10             	mov    0x10(%ebp),%edx
    1144:	8b 45 18             	mov    0x18(%ebp),%eax
    1147:	01 d0                	add    %edx,%eax
    1149:	8d 48 ff             	lea    -0x1(%eax),%ecx
    114c:	8b 55 0c             	mov    0xc(%ebp),%edx
    114f:	8b 45 14             	mov    0x14(%ebp),%eax
    1152:	01 d0                	add    %edx,%eax
    1154:	8d 50 ff             	lea    -0x1(%eax),%edx
    1157:	8b 5d 10             	mov    0x10(%ebp),%ebx
    115a:	8b 45 18             	mov    0x18(%ebp),%eax
    115d:	01 d8                	add    %ebx,%eax
    115f:	83 e8 01             	sub    $0x1,%eax
    1162:	83 ec 04             	sub    $0x4,%esp
    1165:	51                   	push   %ecx
    1166:	52                   	push   %edx
    1167:	50                   	push   %eax
    1168:	ff 75 0c             	pushl  0xc(%ebp)
    116b:	ff 75 08             	pushl  0x8(%ebp)
    116e:	e8 89 fc ff ff       	call   dfc <APDrawLine>
    1173:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1176:	8b 55 0c             	mov    0xc(%ebp),%edx
    1179:	8b 45 14             	mov    0x14(%ebp),%eax
    117c:	01 d0                	add    %edx,%eax
    117e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1181:	8b 45 08             	mov    0x8(%ebp),%eax
    1184:	8b 40 0c             	mov    0xc(%eax),%eax
    1187:	89 c1                	mov    %eax,%ecx
    1189:	c1 e9 1f             	shr    $0x1f,%ecx
    118c:	01 c8                	add    %ecx,%eax
    118e:	d1 f8                	sar    %eax
    1190:	29 c2                	sub    %eax,%edx
    1192:	89 d0                	mov    %edx,%eax
    1194:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1197:	8b 55 10             	mov    0x10(%ebp),%edx
    119a:	8b 45 18             	mov    0x18(%ebp),%eax
    119d:	01 d0                	add    %edx,%eax
    119f:	8d 50 ff             	lea    -0x1(%eax),%edx
    11a2:	8b 45 08             	mov    0x8(%ebp),%eax
    11a5:	8b 40 0c             	mov    0xc(%eax),%eax
    11a8:	89 c1                	mov    %eax,%ecx
    11aa:	c1 e9 1f             	shr    $0x1f,%ecx
    11ad:	01 c8                	add    %ecx,%eax
    11af:	d1 f8                	sar    %eax
    11b1:	29 c2                	sub    %eax,%edx
    11b3:	89 d0                	mov    %edx,%eax
    11b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    11b8:	8b 45 08             	mov    0x8(%ebp),%eax
    11bb:	8b 40 0c             	mov    0xc(%eax),%eax
    11be:	89 c2                	mov    %eax,%edx
    11c0:	c1 ea 1f             	shr    $0x1f,%edx
    11c3:	01 d0                	add    %edx,%eax
    11c5:	d1 f8                	sar    %eax
    11c7:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    11ca:	8b 45 08             	mov    0x8(%ebp),%eax
    11cd:	8b 40 0c             	mov    0xc(%eax),%eax
    11d0:	89 c2                	mov    %eax,%edx
    11d2:	c1 ea 1f             	shr    $0x1f,%edx
    11d5:	01 d0                	add    %edx,%eax
    11d7:	d1 f8                	sar    %eax
    11d9:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    11dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11e0:	0f 88 d8 00 00 00    	js     12be <APDrawRect+0x1ff>
    11e6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11ea:	0f 88 ce 00 00 00    	js     12be <APDrawRect+0x1ff>
    11f0:	8b 45 08             	mov    0x8(%ebp),%eax
    11f3:	8b 00                	mov    (%eax),%eax
    11f5:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11f8:	0f 8e c0 00 00 00    	jle    12be <APDrawRect+0x1ff>
    11fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1201:	8b 40 04             	mov    0x4(%eax),%eax
    1204:	3b 45 10             	cmp    0x10(%ebp),%eax
    1207:	0f 8e b1 00 00 00    	jle    12be <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    120d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1211:	79 07                	jns    121a <APDrawRect+0x15b>
    1213:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    121a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    121e:	79 07                	jns    1227 <APDrawRect+0x168>
    1220:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1227:	8b 45 08             	mov    0x8(%ebp),%eax
    122a:	8b 00                	mov    (%eax),%eax
    122c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    122f:	7f 0b                	jg     123c <APDrawRect+0x17d>
    1231:	8b 45 08             	mov    0x8(%ebp),%eax
    1234:	8b 00                	mov    (%eax),%eax
    1236:	83 e8 01             	sub    $0x1,%eax
    1239:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    123c:	8b 45 08             	mov    0x8(%ebp),%eax
    123f:	8b 40 04             	mov    0x4(%eax),%eax
    1242:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1245:	7f 0c                	jg     1253 <APDrawRect+0x194>
    1247:	8b 45 08             	mov    0x8(%ebp),%eax
    124a:	8b 40 04             	mov    0x4(%eax),%eax
    124d:	83 e8 01             	sub    $0x1,%eax
    1250:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1253:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    125a:	8b 45 0c             	mov    0xc(%ebp),%eax
    125d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1260:	eb 52                	jmp    12b4 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1262:	8b 45 10             	mov    0x10(%ebp),%eax
    1265:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1268:	eb 3e                	jmp    12a8 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    126a:	83 ec 04             	sub    $0x4,%esp
    126d:	ff 75 e8             	pushl  -0x18(%ebp)
    1270:	ff 75 ec             	pushl  -0x14(%ebp)
    1273:	ff 75 08             	pushl  0x8(%ebp)
    1276:	e8 c0 f6 ff ff       	call   93b <APGetIndex>
    127b:	83 c4 10             	add    $0x10,%esp
    127e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1281:	8b 45 08             	mov    0x8(%ebp),%eax
    1284:	8b 48 18             	mov    0x18(%eax),%ecx
    1287:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    128a:	89 d0                	mov    %edx,%eax
    128c:	01 c0                	add    %eax,%eax
    128e:	01 d0                	add    %edx,%eax
    1290:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1293:	8b 45 08             	mov    0x8(%ebp),%eax
    1296:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    129a:	66 89 0a             	mov    %cx,(%edx)
    129d:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    12a1:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    12a4:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12a8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12ab:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12ae:	7e ba                	jle    126a <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12b0:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    12b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12b7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    12ba:	7e a6                	jle    1262 <APDrawRect+0x1a3>
    12bc:	eb 01                	jmp    12bf <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    12be:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    12bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12c2:	c9                   	leave  
    12c3:	c3                   	ret    

000012c4 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    12c4:	55                   	push   %ebp
    12c5:	89 e5                	mov    %esp,%ebp
    12c7:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    12ca:	83 ec 0c             	sub    $0xc,%esp
    12cd:	ff 75 0c             	pushl  0xc(%ebp)
    12d0:	e8 c1 ee ff ff       	call   196 <strlen>
    12d5:	83 c4 10             	add    $0x10,%esp
    12d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    12db:	8b 45 08             	mov    0x8(%ebp),%eax
    12de:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    12e2:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    12e6:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    12ea:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    12ed:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    12f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12fb:	e9 bc 00 00 00       	jmp    13bc <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1300:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1303:	8b 45 0c             	mov    0xc(%ebp),%eax
    1306:	01 d0                	add    %edx,%eax
    1308:	0f b6 00             	movzbl (%eax),%eax
    130b:	0f be c0             	movsbl %al,%eax
    130e:	83 e8 20             	sub    $0x20,%eax
    1311:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1314:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1318:	0f 87 9a 00 00 00    	ja     13b8 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    131e:	8b 45 08             	mov    0x8(%ebp),%eax
    1321:	8b 00                	mov    (%eax),%eax
    1323:	0f af 45 14          	imul   0x14(%ebp),%eax
    1327:	89 c2                	mov    %eax,%edx
    1329:	8b 45 10             	mov    0x10(%ebp),%eax
    132c:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    132f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1332:	89 d0                	mov    %edx,%eax
    1334:	c1 e0 03             	shl    $0x3,%eax
    1337:	01 d0                	add    %edx,%eax
    1339:	01 c8                	add    %ecx,%eax
    133b:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    133e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1345:	eb 6b                	jmp    13b2 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1347:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    134e:	eb 50                	jmp    13a0 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    1350:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1353:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1356:	89 d0                	mov    %edx,%eax
    1358:	c1 e0 03             	shl    $0x3,%eax
    135b:	01 d0                	add    %edx,%eax
    135d:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    1363:	01 c2                	add    %eax,%edx
    1365:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1368:	01 d0                	add    %edx,%eax
    136a:	05 00 2c 00 00       	add    $0x2c00,%eax
    136f:	0f b6 00             	movzbl (%eax),%eax
    1372:	84 c0                	test   %al,%al
    1374:	74 26                	je     139c <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    1376:	8b 45 08             	mov    0x8(%ebp),%eax
    1379:	8b 50 18             	mov    0x18(%eax),%edx
    137c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    137f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1382:	01 c8                	add    %ecx,%eax
    1384:	89 c1                	mov    %eax,%ecx
    1386:	89 c8                	mov    %ecx,%eax
    1388:	01 c0                	add    %eax,%eax
    138a:	01 c8                	add    %ecx,%eax
    138c:	01 d0                	add    %edx,%eax
    138e:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1392:	66 89 10             	mov    %dx,(%eax)
    1395:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1399:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    139c:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    13a0:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    13a4:	7e aa                	jle    1350 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    13a6:	8b 45 08             	mov    0x8(%ebp),%eax
    13a9:	8b 00                	mov    (%eax),%eax
    13ab:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    13ae:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    13b2:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    13b6:	7e 8f                	jle    1347 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    13b8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    13bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13bf:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    13c2:	0f 82 38 ff ff ff    	jb     1300 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    13c8:	90                   	nop
    13c9:	c9                   	leave  
    13ca:	c3                   	ret    

000013cb <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    13cb:	55                   	push   %ebp
    13cc:	89 e5                	mov    %esp,%ebp
    13ce:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    13d1:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    13d5:	0f 88 8e 01 00 00    	js     1569 <APDcCopy+0x19e>
    13db:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    13df:	0f 88 84 01 00 00    	js     1569 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    13e5:	8b 55 0c             	mov    0xc(%ebp),%edx
    13e8:	8b 45 20             	mov    0x20(%ebp),%eax
    13eb:	01 d0                	add    %edx,%eax
    13ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
    13f0:	8b 55 10             	mov    0x10(%ebp),%edx
    13f3:	8b 45 24             	mov    0x24(%ebp),%eax
    13f6:	01 d0                	add    %edx,%eax
    13f8:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    13fb:	8b 55 18             	mov    0x18(%ebp),%edx
    13fe:	8b 45 20             	mov    0x20(%ebp),%eax
    1401:	01 d0                	add    %edx,%eax
    1403:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1406:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1409:	8b 45 24             	mov    0x24(%ebp),%eax
    140c:	01 d0                	add    %edx,%eax
    140e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1411:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1415:	0f 88 51 01 00 00    	js     156c <APDcCopy+0x1a1>
    141b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    141f:	0f 88 47 01 00 00    	js     156c <APDcCopy+0x1a1>
    1425:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1429:	0f 88 3d 01 00 00    	js     156c <APDcCopy+0x1a1>
    142f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1433:	0f 88 33 01 00 00    	js     156c <APDcCopy+0x1a1>
    1439:	8b 45 14             	mov    0x14(%ebp),%eax
    143c:	8b 00                	mov    (%eax),%eax
    143e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1441:	0f 8c 25 01 00 00    	jl     156c <APDcCopy+0x1a1>
    1447:	8b 45 14             	mov    0x14(%ebp),%eax
    144a:	8b 40 04             	mov    0x4(%eax),%eax
    144d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1450:	0f 8c 16 01 00 00    	jl     156c <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1456:	8b 45 08             	mov    0x8(%ebp),%eax
    1459:	8b 00                	mov    (%eax),%eax
    145b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    145e:	7f 0b                	jg     146b <APDcCopy+0xa0>
    1460:	8b 45 08             	mov    0x8(%ebp),%eax
    1463:	8b 00                	mov    (%eax),%eax
    1465:	83 e8 01             	sub    $0x1,%eax
    1468:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    146b:	8b 45 08             	mov    0x8(%ebp),%eax
    146e:	8b 40 04             	mov    0x4(%eax),%eax
    1471:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1474:	7f 0c                	jg     1482 <APDcCopy+0xb7>
    1476:	8b 45 08             	mov    0x8(%ebp),%eax
    1479:	8b 40 04             	mov    0x4(%eax),%eax
    147c:	83 e8 01             	sub    $0x1,%eax
    147f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1482:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1489:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1490:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1497:	e9 bc 00 00 00       	jmp    1558 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    149c:	8b 45 08             	mov    0x8(%ebp),%eax
    149f:	8b 00                	mov    (%eax),%eax
    14a1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14a4:	8b 55 10             	mov    0x10(%ebp),%edx
    14a7:	01 ca                	add    %ecx,%edx
    14a9:	0f af d0             	imul   %eax,%edx
    14ac:	8b 45 0c             	mov    0xc(%ebp),%eax
    14af:	01 d0                	add    %edx,%eax
    14b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    14b4:	8b 45 14             	mov    0x14(%ebp),%eax
    14b7:	8b 00                	mov    (%eax),%eax
    14b9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14bc:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14bf:	01 ca                	add    %ecx,%edx
    14c1:	0f af d0             	imul   %eax,%edx
    14c4:	8b 45 18             	mov    0x18(%ebp),%eax
    14c7:	01 d0                	add    %edx,%eax
    14c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    14cc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14d3:	eb 74                	jmp    1549 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    14d5:	8b 45 14             	mov    0x14(%ebp),%eax
    14d8:	8b 50 18             	mov    0x18(%eax),%edx
    14db:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    14de:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14e1:	01 c8                	add    %ecx,%eax
    14e3:	89 c1                	mov    %eax,%ecx
    14e5:	89 c8                	mov    %ecx,%eax
    14e7:	01 c0                	add    %eax,%eax
    14e9:	01 c8                	add    %ecx,%eax
    14eb:	01 d0                	add    %edx,%eax
    14ed:	0f b7 10             	movzwl (%eax),%edx
    14f0:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    14f4:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    14f8:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    14fb:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    14ff:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1503:	38 c2                	cmp    %al,%dl
    1505:	75 18                	jne    151f <APDcCopy+0x154>
    1507:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    150b:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    150f:	38 c2                	cmp    %al,%dl
    1511:	75 0c                	jne    151f <APDcCopy+0x154>
    1513:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1517:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    151b:	38 c2                	cmp    %al,%dl
    151d:	74 26                	je     1545 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    151f:	8b 45 08             	mov    0x8(%ebp),%eax
    1522:	8b 50 18             	mov    0x18(%eax),%edx
    1525:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1528:	8b 45 f0             	mov    -0x10(%ebp),%eax
    152b:	01 c8                	add    %ecx,%eax
    152d:	89 c1                	mov    %eax,%ecx
    152f:	89 c8                	mov    %ecx,%eax
    1531:	01 c0                	add    %eax,%eax
    1533:	01 c8                	add    %ecx,%eax
    1535:	01 d0                	add    %edx,%eax
    1537:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    153b:	66 89 10             	mov    %dx,(%eax)
    153e:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1542:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1545:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1549:	8b 45 fc             	mov    -0x4(%ebp),%eax
    154c:	2b 45 0c             	sub    0xc(%ebp),%eax
    154f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1552:	7d 81                	jge    14d5 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1554:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1558:	8b 45 f8             	mov    -0x8(%ebp),%eax
    155b:	2b 45 10             	sub    0x10(%ebp),%eax
    155e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1561:	0f 8d 35 ff ff ff    	jge    149c <APDcCopy+0xd1>
    1567:	eb 04                	jmp    156d <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1569:	90                   	nop
    156a:	eb 01                	jmp    156d <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    156c:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    156d:	c9                   	leave  
    156e:	c3                   	ret    

0000156f <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    156f:	55                   	push   %ebp
    1570:	89 e5                	mov    %esp,%ebp
    1572:	83 ec 1c             	sub    $0x1c,%esp
    1575:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1578:	8b 55 10             	mov    0x10(%ebp),%edx
    157b:	8b 45 14             	mov    0x14(%ebp),%eax
    157e:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1581:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1584:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1587:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    158b:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    158e:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1592:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1595:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1599:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    159c:	8b 45 08             	mov    0x8(%ebp),%eax
    159f:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    15a3:	66 89 10             	mov    %dx,(%eax)
    15a6:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    15aa:	88 50 02             	mov    %dl,0x2(%eax)
}
    15ad:	8b 45 08             	mov    0x8(%ebp),%eax
    15b0:	c9                   	leave  
    15b1:	c2 04 00             	ret    $0x4

000015b4 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    15b4:	55                   	push   %ebp
    15b5:	89 e5                	mov    %esp,%ebp
    15b7:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    15ba:	8b 45 08             	mov    0x8(%ebp),%eax
    15bd:	8b 00                	mov    (%eax),%eax
    15bf:	83 ec 08             	sub    $0x8,%esp
    15c2:	8d 55 0c             	lea    0xc(%ebp),%edx
    15c5:	52                   	push   %edx
    15c6:	50                   	push   %eax
    15c7:	e8 34 ee ff ff       	call   400 <sendMessage>
    15cc:	83 c4 10             	add    $0x10,%esp
}
    15cf:	90                   	nop
    15d0:	c9                   	leave  
    15d1:	c3                   	ret    

000015d2 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    15d2:	55                   	push   %ebp
    15d3:	89 e5                	mov    %esp,%ebp
    15d5:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    15d8:	83 ec 0c             	sub    $0xc,%esp
    15db:	68 98 00 00 00       	push   $0x98
    15e0:	e8 f5 f1 ff ff       	call   7da <malloc>
    15e5:	83 c4 10             	add    $0x10,%esp
    15e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    15eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15ef:	75 15                	jne    1606 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    15f1:	83 ec 04             	sub    $0x4,%esp
    15f4:	ff 75 08             	pushl  0x8(%ebp)
    15f7:	68 f0 24 00 00       	push   $0x24f0
    15fc:	6a 01                	push   $0x1
    15fe:	e8 04 ef ff ff       	call   507 <printf>
    1603:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1606:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1609:	05 84 00 00 00       	add    $0x84,%eax
    160e:	83 ec 08             	sub    $0x8,%esp
    1611:	ff 75 08             	pushl  0x8(%ebp)
    1614:	50                   	push   %eax
    1615:	e8 0d eb ff ff       	call   127 <strcpy>
    161a:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    161d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1620:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1627:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162a:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1631:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1634:	8b 40 3c             	mov    0x3c(%eax),%eax
    1637:	89 c2                	mov    %eax,%edx
    1639:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163c:	8b 40 40             	mov    0x40(%eax),%eax
    163f:	0f af d0             	imul   %eax,%edx
    1642:	89 d0                	mov    %edx,%eax
    1644:	01 c0                	add    %eax,%eax
    1646:	01 d0                	add    %edx,%eax
    1648:	83 ec 0c             	sub    $0xc,%esp
    164b:	50                   	push   %eax
    164c:	e8 89 f1 ff ff       	call   7da <malloc>
    1651:	83 c4 10             	add    $0x10,%esp
    1654:	89 c2                	mov    %eax,%edx
    1656:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1659:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    165c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165f:	8b 40 54             	mov    0x54(%eax),%eax
    1662:	85 c0                	test   %eax,%eax
    1664:	75 15                	jne    167b <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1666:	83 ec 04             	sub    $0x4,%esp
    1669:	ff 75 08             	pushl  0x8(%ebp)
    166c:	68 10 25 00 00       	push   $0x2510
    1671:	6a 01                	push   $0x1
    1673:	e8 8f ee ff ff       	call   507 <printf>
    1678:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    167b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167e:	8b 40 3c             	mov    0x3c(%eax),%eax
    1681:	89 c2                	mov    %eax,%edx
    1683:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1686:	8b 40 40             	mov    0x40(%eax),%eax
    1689:	0f af d0             	imul   %eax,%edx
    168c:	89 d0                	mov    %edx,%eax
    168e:	01 c0                	add    %eax,%eax
    1690:	01 c2                	add    %eax,%edx
    1692:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1695:	8b 40 54             	mov    0x54(%eax),%eax
    1698:	83 ec 04             	sub    $0x4,%esp
    169b:	52                   	push   %edx
    169c:	68 ff ff ff 00       	push   $0xffffff
    16a1:	50                   	push   %eax
    16a2:	e8 16 eb ff ff       	call   1bd <memset>
    16a7:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    16aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ad:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    16b4:	e8 1f ed ff ff       	call   3d8 <getpid>
    16b9:	89 c2                	mov    %eax,%edx
    16bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16be:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    16c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c4:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    16cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ce:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    16d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d8:	8b 40 58             	mov    0x58(%eax),%eax
    16db:	89 c2                	mov    %eax,%edx
    16dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e0:	8b 40 5c             	mov    0x5c(%eax),%eax
    16e3:	0f af d0             	imul   %eax,%edx
    16e6:	89 d0                	mov    %edx,%eax
    16e8:	01 c0                	add    %eax,%eax
    16ea:	01 d0                	add    %edx,%eax
    16ec:	83 ec 0c             	sub    $0xc,%esp
    16ef:	50                   	push   %eax
    16f0:	e8 e5 f0 ff ff       	call   7da <malloc>
    16f5:	83 c4 10             	add    $0x10,%esp
    16f8:	89 c2                	mov    %eax,%edx
    16fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fd:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1700:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1703:	8b 40 70             	mov    0x70(%eax),%eax
    1706:	85 c0                	test   %eax,%eax
    1708:	75 15                	jne    171f <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    170a:	83 ec 04             	sub    $0x4,%esp
    170d:	ff 75 08             	pushl  0x8(%ebp)
    1710:	68 34 25 00 00       	push   $0x2534
    1715:	6a 01                	push   $0x1
    1717:	e8 eb ed ff ff       	call   507 <printf>
    171c:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    171f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1722:	8b 40 3c             	mov    0x3c(%eax),%eax
    1725:	89 c2                	mov    %eax,%edx
    1727:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172a:	8b 40 40             	mov    0x40(%eax),%eax
    172d:	0f af d0             	imul   %eax,%edx
    1730:	89 d0                	mov    %edx,%eax
    1732:	01 c0                	add    %eax,%eax
    1734:	01 c2                	add    %eax,%edx
    1736:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1739:	8b 40 54             	mov    0x54(%eax),%eax
    173c:	83 ec 04             	sub    $0x4,%esp
    173f:	52                   	push   %edx
    1740:	68 ff 00 00 00       	push   $0xff
    1745:	50                   	push   %eax
    1746:	e8 72 ea ff ff       	call   1bd <memset>
    174b:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    174e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1751:	8b 55 0c             	mov    0xc(%ebp),%edx
    1754:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1757:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    175b:	74 49                	je     17a6 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    175d:	8b 45 10             	mov    0x10(%ebp),%eax
    1760:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1766:	83 ec 0c             	sub    $0xc,%esp
    1769:	50                   	push   %eax
    176a:	e8 6b f0 ff ff       	call   7da <malloc>
    176f:	83 c4 10             	add    $0x10,%esp
    1772:	89 c2                	mov    %eax,%edx
    1774:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1777:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    177a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177d:	8b 55 10             	mov    0x10(%ebp),%edx
    1780:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1783:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1786:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    178d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1790:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1797:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179a:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    17a1:	e9 8d 00 00 00       	jmp    1833 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    17a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a9:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    17b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b3:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    17ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bd:	8b 40 20             	mov    0x20(%eax),%eax
    17c0:	89 c2                	mov    %eax,%edx
    17c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c5:	8b 40 24             	mov    0x24(%eax),%eax
    17c8:	0f af d0             	imul   %eax,%edx
    17cb:	89 d0                	mov    %edx,%eax
    17cd:	01 c0                	add    %eax,%eax
    17cf:	01 d0                	add    %edx,%eax
    17d1:	83 ec 0c             	sub    $0xc,%esp
    17d4:	50                   	push   %eax
    17d5:	e8 00 f0 ff ff       	call   7da <malloc>
    17da:	83 c4 10             	add    $0x10,%esp
    17dd:	89 c2                	mov    %eax,%edx
    17df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e2:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    17e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e8:	8b 40 38             	mov    0x38(%eax),%eax
    17eb:	85 c0                	test   %eax,%eax
    17ed:	75 15                	jne    1804 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    17ef:	83 ec 04             	sub    $0x4,%esp
    17f2:	ff 75 08             	pushl  0x8(%ebp)
    17f5:	68 5c 25 00 00       	push   $0x255c
    17fa:	6a 01                	push   $0x1
    17fc:	e8 06 ed ff ff       	call   507 <printf>
    1801:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1804:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1807:	8b 40 20             	mov    0x20(%eax),%eax
    180a:	89 c2                	mov    %eax,%edx
    180c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180f:	8b 40 24             	mov    0x24(%eax),%eax
    1812:	0f af d0             	imul   %eax,%edx
    1815:	89 d0                	mov    %edx,%eax
    1817:	01 c0                	add    %eax,%eax
    1819:	01 c2                	add    %eax,%edx
    181b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181e:	8b 40 38             	mov    0x38(%eax),%eax
    1821:	83 ec 04             	sub    $0x4,%esp
    1824:	52                   	push   %edx
    1825:	68 ff ff ff 00       	push   $0xffffff
    182a:	50                   	push   %eax
    182b:	e8 8d e9 ff ff       	call   1bd <memset>
    1830:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1833:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1836:	c9                   	leave  
    1837:	c3                   	ret    

00001838 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1838:	55                   	push   %ebp
    1839:	89 e5                	mov    %esp,%ebp
    183b:	57                   	push   %edi
    183c:	56                   	push   %esi
    183d:	53                   	push   %ebx
    183e:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1841:	8b 45 0c             	mov    0xc(%ebp),%eax
    1844:	83 f8 03             	cmp    $0x3,%eax
    1847:	74 02                	je     184b <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1849:	eb 7c                	jmp    18c7 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    184b:	8b 45 08             	mov    0x8(%ebp),%eax
    184e:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1851:	8b 45 08             	mov    0x8(%ebp),%eax
    1854:	8b 48 18             	mov    0x18(%eax),%ecx
    1857:	8b 45 08             	mov    0x8(%ebp),%eax
    185a:	8b 50 5c             	mov    0x5c(%eax),%edx
    185d:	8b 45 08             	mov    0x8(%ebp),%eax
    1860:	8b 40 58             	mov    0x58(%eax),%eax
    1863:	8b 75 08             	mov    0x8(%ebp),%esi
    1866:	83 c6 58             	add    $0x58,%esi
    1869:	83 ec 04             	sub    $0x4,%esp
    186c:	53                   	push   %ebx
    186d:	51                   	push   %ecx
    186e:	6a 00                	push   $0x0
    1870:	52                   	push   %edx
    1871:	50                   	push   %eax
    1872:	6a 00                	push   $0x0
    1874:	6a 00                	push   $0x0
    1876:	56                   	push   %esi
    1877:	6a 00                	push   $0x0
    1879:	6a 00                	push   $0x0
    187b:	ff 75 08             	pushl  0x8(%ebp)
    187e:	e8 75 eb ff ff       	call   3f8 <paintWindow>
    1883:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1886:	8b 45 08             	mov    0x8(%ebp),%eax
    1889:	8b 70 1c             	mov    0x1c(%eax),%esi
    188c:	8b 45 08             	mov    0x8(%ebp),%eax
    188f:	8b 58 18             	mov    0x18(%eax),%ebx
    1892:	8b 45 08             	mov    0x8(%ebp),%eax
    1895:	8b 48 08             	mov    0x8(%eax),%ecx
    1898:	8b 45 08             	mov    0x8(%ebp),%eax
    189b:	8b 50 40             	mov    0x40(%eax),%edx
    189e:	8b 45 08             	mov    0x8(%ebp),%eax
    18a1:	8b 40 3c             	mov    0x3c(%eax),%eax
    18a4:	8b 7d 08             	mov    0x8(%ebp),%edi
    18a7:	83 c7 3c             	add    $0x3c,%edi
    18aa:	83 ec 04             	sub    $0x4,%esp
    18ad:	56                   	push   %esi
    18ae:	53                   	push   %ebx
    18af:	51                   	push   %ecx
    18b0:	52                   	push   %edx
    18b1:	50                   	push   %eax
    18b2:	6a 00                	push   $0x0
    18b4:	6a 00                	push   $0x0
    18b6:	57                   	push   %edi
    18b7:	6a 32                	push   $0x32
    18b9:	6a 00                	push   $0x0
    18bb:	ff 75 08             	pushl  0x8(%ebp)
    18be:	e8 35 eb ff ff       	call   3f8 <paintWindow>
    18c3:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    18c6:	90                   	nop
        default: break;
            
            
    }
    return False;
    18c7:	b8 00 00 00 00       	mov    $0x0,%eax
}
    18cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    18cf:	5b                   	pop    %ebx
    18d0:	5e                   	pop    %esi
    18d1:	5f                   	pop    %edi
    18d2:	5d                   	pop    %ebp
    18d3:	c3                   	ret    

000018d4 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    18d4:	55                   	push   %ebp
    18d5:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    18d7:	8b 45 0c             	mov    0xc(%ebp),%eax
    18da:	8b 50 08             	mov    0x8(%eax),%edx
    18dd:	8b 45 08             	mov    0x8(%ebp),%eax
    18e0:	8b 00                	mov    (%eax),%eax
    18e2:	39 c2                	cmp    %eax,%edx
    18e4:	74 07                	je     18ed <APPreJudge+0x19>
        return False;
    18e6:	b8 00 00 00 00       	mov    $0x0,%eax
    18eb:	eb 05                	jmp    18f2 <APPreJudge+0x1e>
    return True;
    18ed:	b8 01 00 00 00       	mov    $0x1,%eax
}
    18f2:	5d                   	pop    %ebp
    18f3:	c3                   	ret    

000018f4 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    18f4:	55                   	push   %ebp
    18f5:	89 e5                	mov    %esp,%ebp
    18f7:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    18fa:	8b 45 08             	mov    0x8(%ebp),%eax
    18fd:	8b 55 0c             	mov    0xc(%ebp),%edx
    1900:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1906:	83 ec 0c             	sub    $0xc,%esp
    1909:	ff 75 08             	pushl  0x8(%ebp)
    190c:	e8 ff ea ff ff       	call   410 <registWindow>
    1911:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1914:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    191b:	8b 45 08             	mov    0x8(%ebp),%eax
    191e:	8b 00                	mov    (%eax),%eax
    1920:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1923:	ff 75 f4             	pushl  -0xc(%ebp)
    1926:	ff 75 f0             	pushl  -0x10(%ebp)
    1929:	ff 75 ec             	pushl  -0x14(%ebp)
    192c:	ff 75 08             	pushl  0x8(%ebp)
    192f:	e8 80 fc ff ff       	call   15b4 <APSendMessage>
    1934:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1937:	83 ec 0c             	sub    $0xc,%esp
    193a:	ff 75 08             	pushl  0x8(%ebp)
    193d:	e8 c6 ea ff ff       	call   408 <getMessage>
    1942:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1945:	8b 45 08             	mov    0x8(%ebp),%eax
    1948:	83 c0 74             	add    $0x74,%eax
    194b:	83 ec 08             	sub    $0x8,%esp
    194e:	50                   	push   %eax
    194f:	ff 75 08             	pushl  0x8(%ebp)
    1952:	e8 7d ff ff ff       	call   18d4 <APPreJudge>
    1957:	83 c4 10             	add    $0x10,%esp
    195a:	84 c0                	test   %al,%al
    195c:	74 1b                	je     1979 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    195e:	8b 45 08             	mov    0x8(%ebp),%eax
    1961:	ff 70 7c             	pushl  0x7c(%eax)
    1964:	ff 70 78             	pushl  0x78(%eax)
    1967:	ff 70 74             	pushl  0x74(%eax)
    196a:	ff 75 08             	pushl  0x8(%ebp)
    196d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1970:	ff d0                	call   *%eax
    1972:	83 c4 10             	add    $0x10,%esp
    1975:	84 c0                	test   %al,%al
    1977:	75 0c                	jne    1985 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1979:	8b 45 08             	mov    0x8(%ebp),%eax
    197c:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1983:	eb b2                	jmp    1937 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1985:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1986:	90                   	nop
    1987:	c9                   	leave  
    1988:	c3                   	ret    

00001989 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1989:	55                   	push   %ebp
    198a:	89 e5                	mov    %esp,%ebp
    198c:	57                   	push   %edi
    198d:	56                   	push   %esi
    198e:	53                   	push   %ebx
    198f:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    1992:	a1 44 68 00 00       	mov    0x6844,%eax
    1997:	85 c0                	test   %eax,%eax
    1999:	0f 85 2c 02 00 00    	jne    1bcb <APGridPaint+0x242>
    {
        iconReady = 1;
    199f:	c7 05 44 68 00 00 01 	movl   $0x1,0x6844
    19a6:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    19a9:	8d 45 88             	lea    -0x78(%ebp),%eax
    19ac:	83 ec 08             	sub    $0x8,%esp
    19af:	68 83 25 00 00       	push   $0x2583
    19b4:	50                   	push   %eax
    19b5:	e8 d3 ef ff ff       	call   98d <APLoadBitmap>
    19ba:	83 c4 0c             	add    $0xc,%esp
    19bd:	8b 45 88             	mov    -0x78(%ebp),%eax
    19c0:	a3 68 68 00 00       	mov    %eax,0x6868
    19c5:	8b 45 8c             	mov    -0x74(%ebp),%eax
    19c8:	a3 6c 68 00 00       	mov    %eax,0x686c
    19cd:	8b 45 90             	mov    -0x70(%ebp),%eax
    19d0:	a3 70 68 00 00       	mov    %eax,0x6870
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    19d5:	83 ec 04             	sub    $0x4,%esp
    19d8:	ff 35 70 68 00 00    	pushl  0x6870
    19de:	ff 35 6c 68 00 00    	pushl  0x686c
    19e4:	ff 35 68 68 00 00    	pushl  0x6868
    19ea:	e8 d8 f1 ff ff       	call   bc7 <APCreateCompatibleDCFromBitmap>
    19ef:	83 c4 10             	add    $0x10,%esp
    19f2:	a3 74 68 00 00       	mov    %eax,0x6874
        grid_river = APLoadBitmap ("grid_river.bmp");
    19f7:	8d 45 88             	lea    -0x78(%ebp),%eax
    19fa:	83 ec 08             	sub    $0x8,%esp
    19fd:	68 91 25 00 00       	push   $0x2591
    1a02:	50                   	push   %eax
    1a03:	e8 85 ef ff ff       	call   98d <APLoadBitmap>
    1a08:	83 c4 0c             	add    $0xc,%esp
    1a0b:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a0e:	a3 a4 68 00 00       	mov    %eax,0x68a4
    1a13:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a16:	a3 a8 68 00 00       	mov    %eax,0x68a8
    1a1b:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a1e:	a3 ac 68 00 00       	mov    %eax,0x68ac
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1a23:	83 ec 04             	sub    $0x4,%esp
    1a26:	ff 35 ac 68 00 00    	pushl  0x68ac
    1a2c:	ff 35 a8 68 00 00    	pushl  0x68a8
    1a32:	ff 35 a4 68 00 00    	pushl  0x68a4
    1a38:	e8 8a f1 ff ff       	call   bc7 <APCreateCompatibleDCFromBitmap>
    1a3d:	83 c4 10             	add    $0x10,%esp
    1a40:	a3 94 68 00 00       	mov    %eax,0x6894
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1a45:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a48:	83 ec 08             	sub    $0x8,%esp
    1a4b:	68 a0 25 00 00       	push   $0x25a0
    1a50:	50                   	push   %eax
    1a51:	e8 37 ef ff ff       	call   98d <APLoadBitmap>
    1a56:	83 c4 0c             	add    $0xc,%esp
    1a59:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a5c:	a3 98 68 00 00       	mov    %eax,0x6898
    1a61:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a64:	a3 9c 68 00 00       	mov    %eax,0x689c
    1a69:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a6c:	a3 a0 68 00 00       	mov    %eax,0x68a0
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1a71:	83 ec 04             	sub    $0x4,%esp
    1a74:	ff 35 a0 68 00 00    	pushl  0x68a0
    1a7a:	ff 35 9c 68 00 00    	pushl  0x689c
    1a80:	ff 35 98 68 00 00    	pushl  0x6898
    1a86:	e8 3c f1 ff ff       	call   bc7 <APCreateCompatibleDCFromBitmap>
    1a8b:	83 c4 10             	add    $0x10,%esp
    1a8e:	a3 48 68 00 00       	mov    %eax,0x6848
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1a93:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a96:	83 ec 08             	sub    $0x8,%esp
    1a99:	68 af 25 00 00       	push   $0x25af
    1a9e:	50                   	push   %eax
    1a9f:	e8 e9 ee ff ff       	call   98d <APLoadBitmap>
    1aa4:	83 c4 0c             	add    $0xc,%esp
    1aa7:	8b 45 88             	mov    -0x78(%ebp),%eax
    1aaa:	a3 7c 68 00 00       	mov    %eax,0x687c
    1aaf:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1ab2:	a3 80 68 00 00       	mov    %eax,0x6880
    1ab7:	8b 45 90             	mov    -0x70(%ebp),%eax
    1aba:	a3 84 68 00 00       	mov    %eax,0x6884
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1abf:	83 ec 04             	sub    $0x4,%esp
    1ac2:	ff 35 84 68 00 00    	pushl  0x6884
    1ac8:	ff 35 80 68 00 00    	pushl  0x6880
    1ace:	ff 35 7c 68 00 00    	pushl  0x687c
    1ad4:	e8 ee f0 ff ff       	call   bc7 <APCreateCompatibleDCFromBitmap>
    1ad9:	83 c4 10             	add    $0x10,%esp
    1adc:	a3 b0 68 00 00       	mov    %eax,0x68b0
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1ae1:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ae4:	83 ec 08             	sub    $0x8,%esp
    1ae7:	68 bd 25 00 00       	push   $0x25bd
    1aec:	50                   	push   %eax
    1aed:	e8 9b ee ff ff       	call   98d <APLoadBitmap>
    1af2:	83 c4 0c             	add    $0xc,%esp
    1af5:	8b 45 88             	mov    -0x78(%ebp),%eax
    1af8:	a3 58 68 00 00       	mov    %eax,0x6858
    1afd:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b00:	a3 5c 68 00 00       	mov    %eax,0x685c
    1b05:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b08:	a3 60 68 00 00       	mov    %eax,0x6860
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1b0d:	83 ec 04             	sub    $0x4,%esp
    1b10:	ff 35 60 68 00 00    	pushl  0x6860
    1b16:	ff 35 5c 68 00 00    	pushl  0x685c
    1b1c:	ff 35 58 68 00 00    	pushl  0x6858
    1b22:	e8 a0 f0 ff ff       	call   bc7 <APCreateCompatibleDCFromBitmap>
    1b27:	83 c4 10             	add    $0x10,%esp
    1b2a:	a3 78 68 00 00       	mov    %eax,0x6878
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1b2f:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b32:	83 ec 08             	sub    $0x8,%esp
    1b35:	68 cd 25 00 00       	push   $0x25cd
    1b3a:	50                   	push   %eax
    1b3b:	e8 4d ee ff ff       	call   98d <APLoadBitmap>
    1b40:	83 c4 0c             	add    $0xc,%esp
    1b43:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b46:	a3 4c 68 00 00       	mov    %eax,0x684c
    1b4b:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b4e:	a3 50 68 00 00       	mov    %eax,0x6850
    1b53:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b56:	a3 54 68 00 00       	mov    %eax,0x6854
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1b5b:	83 ec 04             	sub    $0x4,%esp
    1b5e:	ff 35 54 68 00 00    	pushl  0x6854
    1b64:	ff 35 50 68 00 00    	pushl  0x6850
    1b6a:	ff 35 4c 68 00 00    	pushl  0x684c
    1b70:	e8 52 f0 ff ff       	call   bc7 <APCreateCompatibleDCFromBitmap>
    1b75:	83 c4 10             	add    $0x10,%esp
    1b78:	a3 64 68 00 00       	mov    %eax,0x6864
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1b7d:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b80:	83 ec 08             	sub    $0x8,%esp
    1b83:	68 df 25 00 00       	push   $0x25df
    1b88:	50                   	push   %eax
    1b89:	e8 ff ed ff ff       	call   98d <APLoadBitmap>
    1b8e:	83 c4 0c             	add    $0xc,%esp
    1b91:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b94:	a3 88 68 00 00       	mov    %eax,0x6888
    1b99:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b9c:	a3 8c 68 00 00       	mov    %eax,0x688c
    1ba1:	8b 45 90             	mov    -0x70(%ebp),%eax
    1ba4:	a3 90 68 00 00       	mov    %eax,0x6890
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1ba9:	83 ec 04             	sub    $0x4,%esp
    1bac:	ff 35 90 68 00 00    	pushl  0x6890
    1bb2:	ff 35 8c 68 00 00    	pushl  0x688c
    1bb8:	ff 35 88 68 00 00    	pushl  0x6888
    1bbe:	e8 04 f0 ff ff       	call   bc7 <APCreateCompatibleDCFromBitmap>
    1bc3:	83 c4 10             	add    $0x10,%esp
    1bc6:	a3 b4 68 00 00       	mov    %eax,0x68b4
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1bcb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bce:	8b 40 08             	mov    0x8(%eax),%eax
    1bd1:	85 c0                	test   %eax,%eax
    1bd3:	75 17                	jne    1bec <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1bd5:	83 ec 08             	sub    $0x8,%esp
    1bd8:	68 f0 25 00 00       	push   $0x25f0
    1bdd:	6a 01                	push   $0x1
    1bdf:	e8 23 e9 ff ff       	call   507 <printf>
    1be4:	83 c4 10             	add    $0x10,%esp
        return;
    1be7:	e9 07 05 00 00       	jmp    20f3 <APGridPaint+0x76a>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1bec:	8b 45 08             	mov    0x8(%ebp),%eax
    1bef:	8b 40 10             	mov    0x10(%eax),%eax
    1bf2:	85 c0                	test   %eax,%eax
    1bf4:	7e 10                	jle    1c06 <APGridPaint+0x27d>
    1bf6:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf9:	8b 50 14             	mov    0x14(%eax),%edx
    1bfc:	8b 45 08             	mov    0x8(%ebp),%eax
    1bff:	8b 40 10             	mov    0x10(%eax),%eax
    1c02:	39 c2                	cmp    %eax,%edx
    1c04:	7c 17                	jl     1c1d <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1c06:	83 ec 08             	sub    $0x8,%esp
    1c09:	68 16 26 00 00       	push   $0x2616
    1c0e:	6a 01                	push   $0x1
    1c10:	e8 f2 e8 ff ff       	call   507 <printf>
    1c15:	83 c4 10             	add    $0x10,%esp
        return;
    1c18:	e9 d6 04 00 00       	jmp    20f3 <APGridPaint+0x76a>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1c1d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c20:	8b 40 14             	mov    0x14(%eax),%eax
    1c23:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1c29:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1c2c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1c2f:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1c32:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1c39:	e9 96 03 00 00       	jmp    1fd4 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1c3e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1c45:	e9 7c 03 00 00       	jmp    1fc6 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1c4a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c4d:	c1 e0 04             	shl    $0x4,%eax
    1c50:	89 c2                	mov    %eax,%edx
    1c52:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1c55:	01 c2                	add    %eax,%edx
    1c57:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c5a:	01 d0                	add    %edx,%eax
    1c5c:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1c5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c62:	8b 40 0c             	mov    0xc(%eax),%eax
    1c65:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1c68:	c1 e2 02             	shl    $0x2,%edx
    1c6b:	01 d0                	add    %edx,%eax
    1c6d:	8b 00                	mov    (%eax),%eax
    1c6f:	83 f8 07             	cmp    $0x7,%eax
    1c72:	0f 87 49 03 00 00    	ja     1fc1 <APGridPaint+0x638>
    1c78:	8b 04 85 2c 26 00 00 	mov    0x262c(,%eax,4),%eax
    1c7f:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c81:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1c84:	6a 0c                	push   $0xc
    1c86:	6a 0c                	push   $0xc
    1c88:	6a 0c                	push   $0xc
    1c8a:	50                   	push   %eax
    1c8b:	e8 df f8 ff ff       	call   156f <RGB>
    1c90:	83 c4 0c             	add    $0xc,%esp
    1c93:	8b 1d 74 68 00 00    	mov    0x6874,%ebx
    1c99:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c9c:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c9f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ca2:	6b c0 32             	imul   $0x32,%eax,%eax
    1ca5:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1ca8:	8b 45 08             	mov    0x8(%ebp),%eax
    1cab:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cae:	83 ec 0c             	sub    $0xc,%esp
    1cb1:	83 ec 04             	sub    $0x4,%esp
    1cb4:	89 e0                	mov    %esp,%eax
    1cb6:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1cba:	66 89 30             	mov    %si,(%eax)
    1cbd:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1cc1:	88 50 02             	mov    %dl,0x2(%eax)
    1cc4:	6a 32                	push   $0x32
    1cc6:	6a 32                	push   $0x32
    1cc8:	6a 00                	push   $0x0
    1cca:	6a 00                	push   $0x0
    1ccc:	53                   	push   %ebx
    1ccd:	51                   	push   %ecx
    1cce:	ff 75 84             	pushl  -0x7c(%ebp)
    1cd1:	57                   	push   %edi
    1cd2:	e8 f4 f6 ff ff       	call   13cb <APDcCopy>
    1cd7:	83 c4 30             	add    $0x30,%esp
                    break;
    1cda:	e9 e3 02 00 00       	jmp    1fc2 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1cdf:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ce2:	6a 69                	push   $0x69
    1ce4:	6a 69                	push   $0x69
    1ce6:	6a 69                	push   $0x69
    1ce8:	50                   	push   %eax
    1ce9:	e8 81 f8 ff ff       	call   156f <RGB>
    1cee:	83 c4 0c             	add    $0xc,%esp
    1cf1:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1cf5:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1cf9:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1cfd:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1d00:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1d07:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d0a:	6a 69                	push   $0x69
    1d0c:	6a 69                	push   $0x69
    1d0e:	6a 69                	push   $0x69
    1d10:	50                   	push   %eax
    1d11:	e8 59 f8 ff ff       	call   156f <RGB>
    1d16:	83 c4 0c             	add    $0xc,%esp
    1d19:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1d1d:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1d21:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1d25:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1d28:	8b 45 08             	mov    0x8(%ebp),%eax
    1d2b:	8d 50 3c             	lea    0x3c(%eax),%edx
    1d2e:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d31:	ff 75 ac             	pushl  -0x54(%ebp)
    1d34:	ff 75 a8             	pushl  -0x58(%ebp)
    1d37:	52                   	push   %edx
    1d38:	50                   	push   %eax
    1d39:	e8 1e ef ff ff       	call   c5c <APSetPen>
    1d3e:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1d41:	8b 45 08             	mov    0x8(%ebp),%eax
    1d44:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1d47:	8d 55 88             	lea    -0x78(%ebp),%edx
    1d4a:	83 ec 04             	sub    $0x4,%esp
    1d4d:	83 ec 04             	sub    $0x4,%esp
    1d50:	89 e0                	mov    %esp,%eax
    1d52:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1d56:	66 89 08             	mov    %cx,(%eax)
    1d59:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    1d5d:	88 48 02             	mov    %cl,0x2(%eax)
    1d60:	53                   	push   %ebx
    1d61:	52                   	push   %edx
    1d62:	e8 2e ef ff ff       	call   c95 <APSetBrush>
    1d67:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1d6a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d6d:	6b d0 32             	imul   $0x32,%eax,%edx
    1d70:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d73:	6b c0 32             	imul   $0x32,%eax,%eax
    1d76:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1d79:	83 c1 3c             	add    $0x3c,%ecx
    1d7c:	83 ec 0c             	sub    $0xc,%esp
    1d7f:	6a 32                	push   $0x32
    1d81:	6a 32                	push   $0x32
    1d83:	52                   	push   %edx
    1d84:	50                   	push   %eax
    1d85:	51                   	push   %ecx
    1d86:	e8 34 f3 ff ff       	call   10bf <APDrawRect>
    1d8b:	83 c4 20             	add    $0x20,%esp
                    break;
    1d8e:	e9 2f 02 00 00       	jmp    1fc2 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d93:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1d96:	6a 0c                	push   $0xc
    1d98:	6a 0c                	push   $0xc
    1d9a:	6a 0c                	push   $0xc
    1d9c:	50                   	push   %eax
    1d9d:	e8 cd f7 ff ff       	call   156f <RGB>
    1da2:	83 c4 0c             	add    $0xc,%esp
    1da5:	8b 1d b4 68 00 00    	mov    0x68b4,%ebx
    1dab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dae:	6b c8 32             	imul   $0x32,%eax,%ecx
    1db1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1db4:	6b c0 32             	imul   $0x32,%eax,%eax
    1db7:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1dba:	8b 45 08             	mov    0x8(%ebp),%eax
    1dbd:	8d 78 3c             	lea    0x3c(%eax),%edi
    1dc0:	83 ec 0c             	sub    $0xc,%esp
    1dc3:	83 ec 04             	sub    $0x4,%esp
    1dc6:	89 e0                	mov    %esp,%eax
    1dc8:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1dcc:	66 89 30             	mov    %si,(%eax)
    1dcf:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1dd3:	88 50 02             	mov    %dl,0x2(%eax)
    1dd6:	6a 32                	push   $0x32
    1dd8:	6a 32                	push   $0x32
    1dda:	6a 00                	push   $0x0
    1ddc:	6a 00                	push   $0x0
    1dde:	53                   	push   %ebx
    1ddf:	51                   	push   %ecx
    1de0:	ff 75 84             	pushl  -0x7c(%ebp)
    1de3:	57                   	push   %edi
    1de4:	e8 e2 f5 ff ff       	call   13cb <APDcCopy>
    1de9:	83 c4 30             	add    $0x30,%esp
                    break;
    1dec:	e9 d1 01 00 00       	jmp    1fc2 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1df1:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1df4:	6a 0c                	push   $0xc
    1df6:	6a 0c                	push   $0xc
    1df8:	6a 0c                	push   $0xc
    1dfa:	50                   	push   %eax
    1dfb:	e8 6f f7 ff ff       	call   156f <RGB>
    1e00:	83 c4 0c             	add    $0xc,%esp
    1e03:	8b 1d 94 68 00 00    	mov    0x6894,%ebx
    1e09:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e0c:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e0f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e12:	6b c0 32             	imul   $0x32,%eax,%eax
    1e15:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e18:	8b 45 08             	mov    0x8(%ebp),%eax
    1e1b:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e1e:	83 ec 0c             	sub    $0xc,%esp
    1e21:	83 ec 04             	sub    $0x4,%esp
    1e24:	89 e0                	mov    %esp,%eax
    1e26:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1e2a:	66 89 30             	mov    %si,(%eax)
    1e2d:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1e31:	88 50 02             	mov    %dl,0x2(%eax)
    1e34:	6a 32                	push   $0x32
    1e36:	6a 32                	push   $0x32
    1e38:	6a 00                	push   $0x0
    1e3a:	6a 00                	push   $0x0
    1e3c:	53                   	push   %ebx
    1e3d:	51                   	push   %ecx
    1e3e:	ff 75 84             	pushl  -0x7c(%ebp)
    1e41:	57                   	push   %edi
    1e42:	e8 84 f5 ff ff       	call   13cb <APDcCopy>
    1e47:	83 c4 30             	add    $0x30,%esp
                    break;
    1e4a:	e9 73 01 00 00       	jmp    1fc2 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e4f:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1e52:	6a 0c                	push   $0xc
    1e54:	6a 0c                	push   $0xc
    1e56:	6a 0c                	push   $0xc
    1e58:	50                   	push   %eax
    1e59:	e8 11 f7 ff ff       	call   156f <RGB>
    1e5e:	83 c4 0c             	add    $0xc,%esp
    1e61:	8b 1d 78 68 00 00    	mov    0x6878,%ebx
    1e67:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e6a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e6d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e70:	6b c0 32             	imul   $0x32,%eax,%eax
    1e73:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e76:	8b 45 08             	mov    0x8(%ebp),%eax
    1e79:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e7c:	83 ec 0c             	sub    $0xc,%esp
    1e7f:	83 ec 04             	sub    $0x4,%esp
    1e82:	89 e0                	mov    %esp,%eax
    1e84:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1e88:	66 89 30             	mov    %si,(%eax)
    1e8b:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1e8f:	88 50 02             	mov    %dl,0x2(%eax)
    1e92:	6a 32                	push   $0x32
    1e94:	6a 32                	push   $0x32
    1e96:	6a 00                	push   $0x0
    1e98:	6a 00                	push   $0x0
    1e9a:	53                   	push   %ebx
    1e9b:	51                   	push   %ecx
    1e9c:	ff 75 84             	pushl  -0x7c(%ebp)
    1e9f:	57                   	push   %edi
    1ea0:	e8 26 f5 ff ff       	call   13cb <APDcCopy>
    1ea5:	83 c4 30             	add    $0x30,%esp
                    break;
    1ea8:	e9 15 01 00 00       	jmp    1fc2 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ead:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1eb0:	6a 0c                	push   $0xc
    1eb2:	6a 0c                	push   $0xc
    1eb4:	6a 0c                	push   $0xc
    1eb6:	50                   	push   %eax
    1eb7:	e8 b3 f6 ff ff       	call   156f <RGB>
    1ebc:	83 c4 0c             	add    $0xc,%esp
    1ebf:	8b 1d b0 68 00 00    	mov    0x68b0,%ebx
    1ec5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ec8:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ecb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ece:	6b c0 32             	imul   $0x32,%eax,%eax
    1ed1:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1ed4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ed7:	8d 78 3c             	lea    0x3c(%eax),%edi
    1eda:	83 ec 0c             	sub    $0xc,%esp
    1edd:	83 ec 04             	sub    $0x4,%esp
    1ee0:	89 e0                	mov    %esp,%eax
    1ee2:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1ee6:	66 89 30             	mov    %si,(%eax)
    1ee9:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1eed:	88 50 02             	mov    %dl,0x2(%eax)
    1ef0:	6a 32                	push   $0x32
    1ef2:	6a 32                	push   $0x32
    1ef4:	6a 00                	push   $0x0
    1ef6:	6a 00                	push   $0x0
    1ef8:	53                   	push   %ebx
    1ef9:	51                   	push   %ecx
    1efa:	ff 75 84             	pushl  -0x7c(%ebp)
    1efd:	57                   	push   %edi
    1efe:	e8 c8 f4 ff ff       	call   13cb <APDcCopy>
    1f03:	83 c4 30             	add    $0x30,%esp
                    break;
    1f06:	e9 b7 00 00 00       	jmp    1fc2 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f0b:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1f0e:	6a 0c                	push   $0xc
    1f10:	6a 0c                	push   $0xc
    1f12:	6a 0c                	push   $0xc
    1f14:	50                   	push   %eax
    1f15:	e8 55 f6 ff ff       	call   156f <RGB>
    1f1a:	83 c4 0c             	add    $0xc,%esp
    1f1d:	8b 1d 48 68 00 00    	mov    0x6848,%ebx
    1f23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f26:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f29:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f2c:	6b c0 32             	imul   $0x32,%eax,%eax
    1f2f:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f32:	8b 45 08             	mov    0x8(%ebp),%eax
    1f35:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f38:	83 ec 0c             	sub    $0xc,%esp
    1f3b:	83 ec 04             	sub    $0x4,%esp
    1f3e:	89 e0                	mov    %esp,%eax
    1f40:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1f44:	66 89 30             	mov    %si,(%eax)
    1f47:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1f4b:	88 50 02             	mov    %dl,0x2(%eax)
    1f4e:	6a 32                	push   $0x32
    1f50:	6a 32                	push   $0x32
    1f52:	6a 00                	push   $0x0
    1f54:	6a 00                	push   $0x0
    1f56:	53                   	push   %ebx
    1f57:	51                   	push   %ecx
    1f58:	ff 75 84             	pushl  -0x7c(%ebp)
    1f5b:	57                   	push   %edi
    1f5c:	e8 6a f4 ff ff       	call   13cb <APDcCopy>
    1f61:	83 c4 30             	add    $0x30,%esp
                    break;
    1f64:	eb 5c                	jmp    1fc2 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f66:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1f69:	6a 0c                	push   $0xc
    1f6b:	6a 0c                	push   $0xc
    1f6d:	6a 0c                	push   $0xc
    1f6f:	50                   	push   %eax
    1f70:	e8 fa f5 ff ff       	call   156f <RGB>
    1f75:	83 c4 0c             	add    $0xc,%esp
    1f78:	8b 1d 64 68 00 00    	mov    0x6864,%ebx
    1f7e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f81:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f84:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f87:	6b c0 32             	imul   $0x32,%eax,%eax
    1f8a:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1f90:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f93:	83 ec 0c             	sub    $0xc,%esp
    1f96:	83 ec 04             	sub    $0x4,%esp
    1f99:	89 e0                	mov    %esp,%eax
    1f9b:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1f9f:	66 89 30             	mov    %si,(%eax)
    1fa2:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1fa6:	88 50 02             	mov    %dl,0x2(%eax)
    1fa9:	6a 32                	push   $0x32
    1fab:	6a 32                	push   $0x32
    1fad:	6a 00                	push   $0x0
    1faf:	6a 00                	push   $0x0
    1fb1:	53                   	push   %ebx
    1fb2:	51                   	push   %ecx
    1fb3:	ff 75 84             	pushl  -0x7c(%ebp)
    1fb6:	57                   	push   %edi
    1fb7:	e8 0f f4 ff ff       	call   13cb <APDcCopy>
    1fbc:	83 c4 30             	add    $0x30,%esp
                    break;
    1fbf:	eb 01                	jmp    1fc2 <APGridPaint+0x639>
                default: break;
    1fc1:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1fc2:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1fc6:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1fca:	0f 8e 7a fc ff ff    	jle    1c4a <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1fd0:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1fd4:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1fd8:	0f 8e 60 fc ff ff    	jle    1c3e <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1fde:	8d 45 88             	lea    -0x78(%ebp),%eax
    1fe1:	68 cd 00 00 00       	push   $0xcd
    1fe6:	6a 74                	push   $0x74
    1fe8:	6a 18                	push   $0x18
    1fea:	50                   	push   %eax
    1feb:	e8 7f f5 ff ff       	call   156f <RGB>
    1ff0:	83 c4 0c             	add    $0xc,%esp
    1ff3:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1ff7:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1ffb:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1fff:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    2002:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2009:	8d 45 88             	lea    -0x78(%ebp),%eax
    200c:	68 cd 00 00 00       	push   $0xcd
    2011:	6a 74                	push   $0x74
    2013:	6a 18                	push   $0x18
    2015:	50                   	push   %eax
    2016:	e8 54 f5 ff ff       	call   156f <RGB>
    201b:	83 c4 0c             	add    $0xc,%esp
    201e:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2022:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    2026:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    202a:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    202d:	8b 45 08             	mov    0x8(%ebp),%eax
    2030:	8d 50 58             	lea    0x58(%eax),%edx
    2033:	8d 45 88             	lea    -0x78(%ebp),%eax
    2036:	ff 75 bc             	pushl  -0x44(%ebp)
    2039:	ff 75 b8             	pushl  -0x48(%ebp)
    203c:	52                   	push   %edx
    203d:	50                   	push   %eax
    203e:	e8 19 ec ff ff       	call   c5c <APSetPen>
    2043:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2046:	8b 45 08             	mov    0x8(%ebp),%eax
    2049:	8d 58 58             	lea    0x58(%eax),%ebx
    204c:	8d 55 88             	lea    -0x78(%ebp),%edx
    204f:	83 ec 04             	sub    $0x4,%esp
    2052:	83 ec 04             	sub    $0x4,%esp
    2055:	89 e0                	mov    %esp,%eax
    2057:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    205b:	66 89 08             	mov    %cx,(%eax)
    205e:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    2062:	88 48 02             	mov    %cl,0x2(%eax)
    2065:	53                   	push   %ebx
    2066:	52                   	push   %edx
    2067:	e8 29 ec ff ff       	call   c95 <APSetBrush>
    206c:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    206f:	8b 45 08             	mov    0x8(%ebp),%eax
    2072:	83 c0 58             	add    $0x58,%eax
    2075:	83 ec 0c             	sub    $0xc,%esp
    2078:	6a 32                	push   $0x32
    207a:	68 20 03 00 00       	push   $0x320
    207f:	6a 00                	push   $0x0
    2081:	6a 00                	push   $0x0
    2083:	50                   	push   %eax
    2084:	e8 36 f0 ff ff       	call   10bf <APDrawRect>
    2089:	83 c4 20             	add    $0x20,%esp
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    208c:	8d 45 88             	lea    -0x78(%ebp),%eax
    208f:	6a 08                	push   $0x8
    2091:	6a 08                	push   $0x8
    2093:	6a 08                	push   $0x8
    2095:	50                   	push   %eax
    2096:	e8 d4 f4 ff ff       	call   156f <RGB>
    209b:	83 c4 0c             	add    $0xc,%esp
    209e:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    20a2:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    20a6:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    20aa:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    20ad:	8b 45 08             	mov    0x8(%ebp),%eax
    20b0:	8d 58 58             	lea    0x58(%eax),%ebx
    20b3:	8d 55 88             	lea    -0x78(%ebp),%edx
    20b6:	83 ec 04             	sub    $0x4,%esp
    20b9:	83 ec 04             	sub    $0x4,%esp
    20bc:	89 e0                	mov    %esp,%eax
    20be:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    20c2:	66 89 08             	mov    %cx,(%eax)
    20c5:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    20c9:	88 48 02             	mov    %cl,0x2(%eax)
    20cc:	53                   	push   %ebx
    20cd:	52                   	push   %edx
    20ce:	e8 04 ec ff ff       	call   cd7 <APSetFont>
    20d3:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    20d6:	8b 45 08             	mov    0x8(%ebp),%eax
    20d9:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    20df:	8b 45 08             	mov    0x8(%ebp),%eax
    20e2:	83 c0 58             	add    $0x58,%eax
    20e5:	6a 14                	push   $0x14
    20e7:	6a 14                	push   $0x14
    20e9:	52                   	push   %edx
    20ea:	50                   	push   %eax
    20eb:	e8 d4 f1 ff ff       	call   12c4 <APDrawText>
    20f0:	83 c4 10             	add    $0x10,%esp
}
    20f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    20f6:	5b                   	pop    %ebx
    20f7:	5e                   	pop    %esi
    20f8:	5f                   	pop    %edi
    20f9:	5d                   	pop    %ebp
    20fa:	c3                   	ret    

000020fb <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    20fb:	55                   	push   %ebp
    20fc:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    20fe:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2102:	7e 08                	jle    210c <random+0x11>
{
rand_num = seed;
    2104:	8b 45 08             	mov    0x8(%ebp),%eax
    2107:	a3 20 68 00 00       	mov    %eax,0x6820
}
rand_num *= 3;
    210c:	8b 15 20 68 00 00    	mov    0x6820,%edx
    2112:	89 d0                	mov    %edx,%eax
    2114:	01 c0                	add    %eax,%eax
    2116:	01 d0                	add    %edx,%eax
    2118:	a3 20 68 00 00       	mov    %eax,0x6820
if (rand_num < 0)
    211d:	a1 20 68 00 00       	mov    0x6820,%eax
    2122:	85 c0                	test   %eax,%eax
    2124:	79 0c                	jns    2132 <random+0x37>
{
rand_num *= (-1);
    2126:	a1 20 68 00 00       	mov    0x6820,%eax
    212b:	f7 d8                	neg    %eax
    212d:	a3 20 68 00 00       	mov    %eax,0x6820
}
return rand_num % 997;
    2132:	8b 0d 20 68 00 00    	mov    0x6820,%ecx
    2138:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    213d:	89 c8                	mov    %ecx,%eax
    213f:	f7 ea                	imul   %edx
    2141:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2144:	c1 f8 09             	sar    $0x9,%eax
    2147:	89 c2                	mov    %eax,%edx
    2149:	89 c8                	mov    %ecx,%eax
    214b:	c1 f8 1f             	sar    $0x1f,%eax
    214e:	29 c2                	sub    %eax,%edx
    2150:	89 d0                	mov    %edx,%eax
    2152:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2158:	29 c1                	sub    %eax,%ecx
    215a:	89 c8                	mov    %ecx,%eax
}
    215c:	5d                   	pop    %ebp
    215d:	c3                   	ret    

0000215e <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    215e:	55                   	push   %ebp
    215f:	89 e5                	mov    %esp,%ebp
    2161:	53                   	push   %ebx
    2162:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2165:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    216c:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2170:	74 17                	je     2189 <sprintint+0x2b>
    2172:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2176:	79 11                	jns    2189 <sprintint+0x2b>
        neg = 1;
    2178:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    217f:	8b 45 10             	mov    0x10(%ebp),%eax
    2182:	f7 d8                	neg    %eax
    2184:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2187:	eb 06                	jmp    218f <sprintint+0x31>
    } else {
        x = xx;
    2189:	8b 45 10             	mov    0x10(%ebp),%eax
    218c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    218f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2196:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2199:	8d 41 01             	lea    0x1(%ecx),%eax
    219c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    219f:	8b 5d 14             	mov    0x14(%ebp),%ebx
    21a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21a5:	ba 00 00 00 00       	mov    $0x0,%edx
    21aa:	f7 f3                	div    %ebx
    21ac:	89 d0                	mov    %edx,%eax
    21ae:	0f b6 80 24 68 00 00 	movzbl 0x6824(%eax),%eax
    21b5:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    21b9:	8b 5d 14             	mov    0x14(%ebp),%ebx
    21bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21bf:	ba 00 00 00 00       	mov    $0x0,%edx
    21c4:	f7 f3                	div    %ebx
    21c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    21c9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    21cd:	75 c7                	jne    2196 <sprintint+0x38>
    if(neg)
    21cf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    21d3:	74 0e                	je     21e3 <sprintint+0x85>
        buf[i++] = '-';
    21d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21d8:	8d 50 01             	lea    0x1(%eax),%edx
    21db:	89 55 f8             	mov    %edx,-0x8(%ebp)
    21de:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    21e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21e6:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    21e9:	eb 1b                	jmp    2206 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    21eb:	8b 45 0c             	mov    0xc(%ebp),%eax
    21ee:	8b 00                	mov    (%eax),%eax
    21f0:	8d 48 01             	lea    0x1(%eax),%ecx
    21f3:	8b 55 0c             	mov    0xc(%ebp),%edx
    21f6:	89 0a                	mov    %ecx,(%edx)
    21f8:	89 c2                	mov    %eax,%edx
    21fa:	8b 45 08             	mov    0x8(%ebp),%eax
    21fd:	01 d0                	add    %edx,%eax
    21ff:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2202:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2206:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    220a:	7f df                	jg     21eb <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    220c:	eb 21                	jmp    222f <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    220e:	8b 45 0c             	mov    0xc(%ebp),%eax
    2211:	8b 00                	mov    (%eax),%eax
    2213:	8d 48 01             	lea    0x1(%eax),%ecx
    2216:	8b 55 0c             	mov    0xc(%ebp),%edx
    2219:	89 0a                	mov    %ecx,(%edx)
    221b:	89 c2                	mov    %eax,%edx
    221d:	8b 45 08             	mov    0x8(%ebp),%eax
    2220:	01 c2                	add    %eax,%edx
    2222:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2225:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2228:	01 c8                	add    %ecx,%eax
    222a:	0f b6 00             	movzbl (%eax),%eax
    222d:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    222f:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2233:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2237:	79 d5                	jns    220e <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2239:	90                   	nop
    223a:	83 c4 20             	add    $0x20,%esp
    223d:	5b                   	pop    %ebx
    223e:	5d                   	pop    %ebp
    223f:	c3                   	ret    

00002240 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2240:	55                   	push   %ebp
    2241:	89 e5                	mov    %esp,%ebp
    2243:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2246:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    224d:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2254:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    225b:	8d 45 0c             	lea    0xc(%ebp),%eax
    225e:	83 c0 04             	add    $0x4,%eax
    2261:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2264:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    226b:	e9 d9 01 00 00       	jmp    2449 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2270:	8b 55 0c             	mov    0xc(%ebp),%edx
    2273:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2276:	01 d0                	add    %edx,%eax
    2278:	0f b6 00             	movzbl (%eax),%eax
    227b:	0f be c0             	movsbl %al,%eax
    227e:	25 ff 00 00 00       	and    $0xff,%eax
    2283:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2286:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    228a:	75 2c                	jne    22b8 <sprintf+0x78>
            if(c == '%'){
    228c:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2290:	75 0c                	jne    229e <sprintf+0x5e>
                state = '%';
    2292:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2299:	e9 a7 01 00 00       	jmp    2445 <sprintf+0x205>
            } else {
                dst[j++] = c;
    229e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22a1:	8d 50 01             	lea    0x1(%eax),%edx
    22a4:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22a7:	89 c2                	mov    %eax,%edx
    22a9:	8b 45 08             	mov    0x8(%ebp),%eax
    22ac:	01 d0                	add    %edx,%eax
    22ae:	8b 55 e0             	mov    -0x20(%ebp),%edx
    22b1:	88 10                	mov    %dl,(%eax)
    22b3:	e9 8d 01 00 00       	jmp    2445 <sprintf+0x205>
            }
        } else if(state == '%'){
    22b8:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    22bc:	0f 85 83 01 00 00    	jne    2445 <sprintf+0x205>
            if(c == 'd'){
    22c2:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    22c6:	75 4c                	jne    2314 <sprintf+0xd4>
                buf[bi] = '\0';
    22c8:	8d 55 ce             	lea    -0x32(%ebp),%edx
    22cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22ce:	01 d0                	add    %edx,%eax
    22d0:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    22d3:	83 ec 0c             	sub    $0xc,%esp
    22d6:	8d 45 ce             	lea    -0x32(%ebp),%eax
    22d9:	50                   	push   %eax
    22da:	e8 e7 df ff ff       	call   2c6 <atoi>
    22df:	83 c4 10             	add    $0x10,%esp
    22e2:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    22e5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    22ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22ef:	8b 00                	mov    (%eax),%eax
    22f1:	83 ec 08             	sub    $0x8,%esp
    22f4:	ff 75 d8             	pushl  -0x28(%ebp)
    22f7:	6a 01                	push   $0x1
    22f9:	6a 0a                	push   $0xa
    22fb:	50                   	push   %eax
    22fc:	8d 45 c8             	lea    -0x38(%ebp),%eax
    22ff:	50                   	push   %eax
    2300:	ff 75 08             	pushl  0x8(%ebp)
    2303:	e8 56 fe ff ff       	call   215e <sprintint>
    2308:	83 c4 20             	add    $0x20,%esp
                ap++;
    230b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    230f:	e9 2a 01 00 00       	jmp    243e <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2314:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2318:	74 06                	je     2320 <sprintf+0xe0>
    231a:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    231e:	75 4c                	jne    236c <sprintf+0x12c>
                buf[bi] = '\0';
    2320:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2323:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2326:	01 d0                	add    %edx,%eax
    2328:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    232b:	83 ec 0c             	sub    $0xc,%esp
    232e:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2331:	50                   	push   %eax
    2332:	e8 8f df ff ff       	call   2c6 <atoi>
    2337:	83 c4 10             	add    $0x10,%esp
    233a:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    233d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2344:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2347:	8b 00                	mov    (%eax),%eax
    2349:	83 ec 08             	sub    $0x8,%esp
    234c:	ff 75 dc             	pushl  -0x24(%ebp)
    234f:	6a 00                	push   $0x0
    2351:	6a 10                	push   $0x10
    2353:	50                   	push   %eax
    2354:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2357:	50                   	push   %eax
    2358:	ff 75 08             	pushl  0x8(%ebp)
    235b:	e8 fe fd ff ff       	call   215e <sprintint>
    2360:	83 c4 20             	add    $0x20,%esp
                ap++;
    2363:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2367:	e9 d2 00 00 00       	jmp    243e <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    236c:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2370:	75 46                	jne    23b8 <sprintf+0x178>
                s = (char*)*ap;
    2372:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2375:	8b 00                	mov    (%eax),%eax
    2377:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    237a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    237e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2382:	75 25                	jne    23a9 <sprintf+0x169>
                    s = "(null)";
    2384:	c7 45 f4 4c 26 00 00 	movl   $0x264c,-0xc(%ebp)
                while(*s != 0){
    238b:	eb 1c                	jmp    23a9 <sprintf+0x169>
                    dst[j++] = *s;
    238d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2390:	8d 50 01             	lea    0x1(%eax),%edx
    2393:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2396:	89 c2                	mov    %eax,%edx
    2398:	8b 45 08             	mov    0x8(%ebp),%eax
    239b:	01 c2                	add    %eax,%edx
    239d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23a0:	0f b6 00             	movzbl (%eax),%eax
    23a3:	88 02                	mov    %al,(%edx)
                    s++;
    23a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    23a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23ac:	0f b6 00             	movzbl (%eax),%eax
    23af:	84 c0                	test   %al,%al
    23b1:	75 da                	jne    238d <sprintf+0x14d>
    23b3:	e9 86 00 00 00       	jmp    243e <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    23b8:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    23bc:	75 1d                	jne    23db <sprintf+0x19b>
                dst[j++] = *ap;
    23be:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23c1:	8d 50 01             	lea    0x1(%eax),%edx
    23c4:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23c7:	89 c2                	mov    %eax,%edx
    23c9:	8b 45 08             	mov    0x8(%ebp),%eax
    23cc:	01 c2                	add    %eax,%edx
    23ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23d1:	8b 00                	mov    (%eax),%eax
    23d3:	88 02                	mov    %al,(%edx)
                ap++;
    23d5:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    23d9:	eb 63                	jmp    243e <sprintf+0x1fe>
            } else if(c == '%'){
    23db:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    23df:	75 17                	jne    23f8 <sprintf+0x1b8>
                dst[j++] = c;
    23e1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23e4:	8d 50 01             	lea    0x1(%eax),%edx
    23e7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23ea:	89 c2                	mov    %eax,%edx
    23ec:	8b 45 08             	mov    0x8(%ebp),%eax
    23ef:	01 d0                	add    %edx,%eax
    23f1:	8b 55 e0             	mov    -0x20(%ebp),%edx
    23f4:	88 10                	mov    %dl,(%eax)
    23f6:	eb 46                	jmp    243e <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    23f8:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    23fc:	7e 18                	jle    2416 <sprintf+0x1d6>
    23fe:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2402:	7f 12                	jg     2416 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2404:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2407:	8d 50 01             	lea    0x1(%eax),%edx
    240a:	89 55 f0             	mov    %edx,-0x10(%ebp)
    240d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2410:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2414:	eb 2f                	jmp    2445 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2416:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2419:	8d 50 01             	lea    0x1(%eax),%edx
    241c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    241f:	89 c2                	mov    %eax,%edx
    2421:	8b 45 08             	mov    0x8(%ebp),%eax
    2424:	01 d0                	add    %edx,%eax
    2426:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2429:	8b 45 c8             	mov    -0x38(%ebp),%eax
    242c:	8d 50 01             	lea    0x1(%eax),%edx
    242f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2432:	89 c2                	mov    %eax,%edx
    2434:	8b 45 08             	mov    0x8(%ebp),%eax
    2437:	01 d0                	add    %edx,%eax
    2439:	8b 55 e0             	mov    -0x20(%ebp),%edx
    243c:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    243e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2445:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2449:	8b 55 0c             	mov    0xc(%ebp),%edx
    244c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    244f:	01 d0                	add    %edx,%eax
    2451:	0f b6 00             	movzbl (%eax),%eax
    2454:	84 c0                	test   %al,%al
    2456:	0f 85 14 fe ff ff    	jne    2270 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    245c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    245f:	8d 50 01             	lea    0x1(%eax),%edx
    2462:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2465:	89 c2                	mov    %eax,%edx
    2467:	8b 45 08             	mov    0x8(%ebp),%eax
    246a:	01 d0                	add    %edx,%eax
    246c:	c6 00 00             	movb   $0x0,(%eax)
}
    246f:	90                   	nop
    2470:	c9                   	leave  
    2471:	c3                   	ret    
