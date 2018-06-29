
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
      16:	68 cb 22 00 00       	push   $0x22cb
      1b:	e8 78 03 00 00       	call   398 <open>
      20:	83 c4 10             	add    $0x10,%esp
      23:	85 c0                	test   %eax,%eax
      25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
      27:	83 ec 04             	sub    $0x4,%esp
      2a:	6a 01                	push   $0x1
      2c:	6a 01                	push   $0x1
      2e:	68 cb 22 00 00       	push   $0x22cb
      33:	e8 68 03 00 00       	call   3a0 <mknod>
      38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
      3b:	83 ec 08             	sub    $0x8,%esp
      3e:	6a 02                	push   $0x2
      40:	68 cb 22 00 00       	push   $0x22cb
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
      6a:	68 d3 22 00 00       	push   $0x22d3
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
      8a:	68 ed 22 00 00       	push   $0x22ed
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
      a7:	68 fc 29 00 00       	push   $0x29fc
      ac:	68 00 23 00 00       	push   $0x2300
      b1:	e8 da 02 00 00       	call   390 <exec>
      b6:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec desktop failed\n");
      b9:	83 ec 08             	sub    $0x8,%esp
      bc:	68 08 23 00 00       	push   $0x2308
      c1:	6a 01                	push   $0x1
      c3:	e8 3f 04 00 00       	call   507 <printf>
      c8:	83 c4 10             	add    $0x10,%esp
      exit();
      cb:	e8 88 02 00 00       	call   358 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
      d0:	83 ec 08             	sub    $0x8,%esp
      d3:	68 23 23 00 00       	push   $0x2323
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
     4a3:	0f b6 80 04 2a 00 00 	movzbl 0x2a04(%eax),%eax
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
     5e1:	c7 45 f4 2c 23 00 00 	movl   $0x232c,-0xc(%ebp)
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
     6a7:	a1 38 2a 00 00       	mov    0x2a38,%eax
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
     772:	a3 38 2a 00 00       	mov    %eax,0x2a38
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
     7d3:	a1 38 2a 00 00       	mov    0x2a38,%eax
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
     7ef:	a1 38 2a 00 00       	mov    0x2a38,%eax
     7f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7f7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7fb:	75 23                	jne    820 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     7fd:	c7 45 f0 30 2a 00 00 	movl   $0x2a30,-0x10(%ebp)
     804:	8b 45 f0             	mov    -0x10(%ebp),%eax
     807:	a3 38 2a 00 00       	mov    %eax,0x2a38
     80c:	a1 38 2a 00 00       	mov    0x2a38,%eax
     811:	a3 30 2a 00 00       	mov    %eax,0x2a30
    base.s.size = 0;
     816:	c7 05 34 2a 00 00 00 	movl   $0x0,0x2a34
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
     873:	a3 38 2a 00 00       	mov    %eax,0x2a38
      return (void*)(p + 1);
     878:	8b 45 f4             	mov    -0xc(%ebp),%eax
     87b:	83 c0 08             	add    $0x8,%eax
     87e:	eb 3b                	jmp    8bb <malloc+0xe1>
    }
    if(p == freep)
     880:	a1 38 2a 00 00       	mov    0x2a38,%eax
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
     9c6:	68 33 23 00 00       	push   $0x2333
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

00000cd7 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     cd7:	55                   	push   %ebp
     cd8:	89 e5                	mov    %esp,%ebp
     cda:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     cdd:	8b 45 08             	mov    0x8(%ebp),%eax
     ce0:	8b 40 0c             	mov    0xc(%eax),%eax
     ce3:	89 c2                	mov    %eax,%edx
     ce5:	c1 ea 1f             	shr    $0x1f,%edx
     ce8:	01 d0                	add    %edx,%eax
     cea:	d1 f8                	sar    %eax
     cec:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     cef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf2:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     cf6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     cf9:	8b 45 10             	mov    0x10(%ebp),%eax
     cfc:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cff:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     d02:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     d06:	0f 89 98 00 00 00    	jns    da4 <APDrawPoint+0xcd>
        i = 0;
     d0c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     d13:	e9 8c 00 00 00       	jmp    da4 <APDrawPoint+0xcd>
    {
        j = x - off;
     d18:	8b 45 0c             	mov    0xc(%ebp),%eax
     d1b:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d1e:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d21:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d25:	79 69                	jns    d90 <APDrawPoint+0xb9>
            j = 0;
     d27:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d2e:	eb 60                	jmp    d90 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d30:	ff 75 fc             	pushl  -0x4(%ebp)
     d33:	ff 75 f8             	pushl  -0x8(%ebp)
     d36:	ff 75 08             	pushl  0x8(%ebp)
     d39:	e8 fd fb ff ff       	call   93b <APGetIndex>
     d3e:	83 c4 0c             	add    $0xc,%esp
     d41:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d44:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d48:	74 55                	je     d9f <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d4a:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d4e:	74 67                	je     db7 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d50:	ff 75 10             	pushl  0x10(%ebp)
     d53:	ff 75 0c             	pushl  0xc(%ebp)
     d56:	ff 75 fc             	pushl  -0x4(%ebp)
     d59:	ff 75 f8             	pushl  -0x8(%ebp)
     d5c:	e8 a1 fb ff ff       	call   902 <distance_2>
     d61:	83 c4 10             	add    $0x10,%esp
     d64:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d67:	7f 23                	jg     d8c <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d69:	8b 45 08             	mov    0x8(%ebp),%eax
     d6c:	8b 48 18             	mov    0x18(%eax),%ecx
     d6f:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d72:	89 d0                	mov    %edx,%eax
     d74:	01 c0                	add    %eax,%eax
     d76:	01 d0                	add    %edx,%eax
     d78:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d7b:	8b 45 08             	mov    0x8(%ebp),%eax
     d7e:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d82:	66 89 0a             	mov    %cx,(%edx)
     d85:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d89:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d8c:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d90:	8b 55 0c             	mov    0xc(%ebp),%edx
     d93:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d96:	01 d0                	add    %edx,%eax
     d98:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d9b:	7d 93                	jge    d30 <APDrawPoint+0x59>
     d9d:	eb 01                	jmp    da0 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d9f:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     da0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     da4:	8b 55 10             	mov    0x10(%ebp),%edx
     da7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     daa:	01 d0                	add    %edx,%eax
     dac:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     daf:	0f 8d 63 ff ff ff    	jge    d18 <APDrawPoint+0x41>
     db5:	eb 01                	jmp    db8 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     db7:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     db8:	c9                   	leave  
     db9:	c3                   	ret    

00000dba <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     dba:	55                   	push   %ebp
     dbb:	89 e5                	mov    %esp,%ebp
     dbd:	53                   	push   %ebx
     dbe:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     dc1:	8b 45 0c             	mov    0xc(%ebp),%eax
     dc4:	3b 45 14             	cmp    0x14(%ebp),%eax
     dc7:	0f 85 80 00 00 00    	jne    e4d <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     dcd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     dd1:	0f 88 9d 02 00 00    	js     1074 <APDrawLine+0x2ba>
     dd7:	8b 45 08             	mov    0x8(%ebp),%eax
     dda:	8b 00                	mov    (%eax),%eax
     ddc:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ddf:	0f 8e 8f 02 00 00    	jle    1074 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     de5:	8b 45 10             	mov    0x10(%ebp),%eax
     de8:	3b 45 18             	cmp    0x18(%ebp),%eax
     deb:	7e 12                	jle    dff <APDrawLine+0x45>
        {
            int tmp = y2;
     ded:	8b 45 18             	mov    0x18(%ebp),%eax
     df0:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     df3:	8b 45 10             	mov    0x10(%ebp),%eax
     df6:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     df9:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dfc:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     dff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e03:	79 07                	jns    e0c <APDrawLine+0x52>
     e05:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e0c:	8b 45 08             	mov    0x8(%ebp),%eax
     e0f:	8b 40 04             	mov    0x4(%eax),%eax
     e12:	3b 45 18             	cmp    0x18(%ebp),%eax
     e15:	7d 0c                	jge    e23 <APDrawLine+0x69>
     e17:	8b 45 08             	mov    0x8(%ebp),%eax
     e1a:	8b 40 04             	mov    0x4(%eax),%eax
     e1d:	83 e8 01             	sub    $0x1,%eax
     e20:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e23:	8b 45 10             	mov    0x10(%ebp),%eax
     e26:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e29:	eb 15                	jmp    e40 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e2b:	ff 75 f4             	pushl  -0xc(%ebp)
     e2e:	ff 75 0c             	pushl  0xc(%ebp)
     e31:	ff 75 08             	pushl  0x8(%ebp)
     e34:	e8 9e fe ff ff       	call   cd7 <APDrawPoint>
     e39:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e3c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e40:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e43:	3b 45 18             	cmp    0x18(%ebp),%eax
     e46:	7e e3                	jle    e2b <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e48:	e9 2b 02 00 00       	jmp    1078 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e4d:	8b 45 10             	mov    0x10(%ebp),%eax
     e50:	3b 45 18             	cmp    0x18(%ebp),%eax
     e53:	75 7f                	jne    ed4 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e55:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e59:	0f 88 18 02 00 00    	js     1077 <APDrawLine+0x2bd>
     e5f:	8b 45 08             	mov    0x8(%ebp),%eax
     e62:	8b 40 04             	mov    0x4(%eax),%eax
     e65:	3b 45 10             	cmp    0x10(%ebp),%eax
     e68:	0f 8e 09 02 00 00    	jle    1077 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e6e:	8b 45 0c             	mov    0xc(%ebp),%eax
     e71:	3b 45 14             	cmp    0x14(%ebp),%eax
     e74:	7e 12                	jle    e88 <APDrawLine+0xce>
        {
            int tmp = x2;
     e76:	8b 45 14             	mov    0x14(%ebp),%eax
     e79:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e7c:	8b 45 0c             	mov    0xc(%ebp),%eax
     e7f:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e82:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e85:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e88:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e8c:	79 07                	jns    e95 <APDrawLine+0xdb>
     e8e:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e95:	8b 45 08             	mov    0x8(%ebp),%eax
     e98:	8b 00                	mov    (%eax),%eax
     e9a:	3b 45 14             	cmp    0x14(%ebp),%eax
     e9d:	7d 0b                	jge    eaa <APDrawLine+0xf0>
     e9f:	8b 45 08             	mov    0x8(%ebp),%eax
     ea2:	8b 00                	mov    (%eax),%eax
     ea4:	83 e8 01             	sub    $0x1,%eax
     ea7:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     eaa:	8b 45 0c             	mov    0xc(%ebp),%eax
     ead:	89 45 f0             	mov    %eax,-0x10(%ebp)
     eb0:	eb 15                	jmp    ec7 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     eb2:	ff 75 10             	pushl  0x10(%ebp)
     eb5:	ff 75 f0             	pushl  -0x10(%ebp)
     eb8:	ff 75 08             	pushl  0x8(%ebp)
     ebb:	e8 17 fe ff ff       	call   cd7 <APDrawPoint>
     ec0:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     ec3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ec7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     eca:	3b 45 14             	cmp    0x14(%ebp),%eax
     ecd:	7e e3                	jle    eb2 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     ecf:	e9 a4 01 00 00       	jmp    1078 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     ed4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     edb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     ee2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ee5:	2b 45 14             	sub    0x14(%ebp),%eax
     ee8:	50                   	push   %eax
     ee9:	e8 3d fa ff ff       	call   92b <abs_int>
     eee:	83 c4 04             	add    $0x4,%esp
     ef1:	89 c3                	mov    %eax,%ebx
     ef3:	8b 45 10             	mov    0x10(%ebp),%eax
     ef6:	2b 45 18             	sub    0x18(%ebp),%eax
     ef9:	50                   	push   %eax
     efa:	e8 2c fa ff ff       	call   92b <abs_int>
     eff:	83 c4 04             	add    $0x4,%esp
     f02:	39 c3                	cmp    %eax,%ebx
     f04:	0f 8e b5 00 00 00    	jle    fbf <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f0a:	8b 45 10             	mov    0x10(%ebp),%eax
     f0d:	2b 45 18             	sub    0x18(%ebp),%eax
     f10:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f13:	db 45 b0             	fildl  -0x50(%ebp)
     f16:	8b 45 0c             	mov    0xc(%ebp),%eax
     f19:	2b 45 14             	sub    0x14(%ebp),%eax
     f1c:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f1f:	db 45 b0             	fildl  -0x50(%ebp)
     f22:	de f9                	fdivrp %st,%st(1)
     f24:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f27:	8b 45 14             	mov    0x14(%ebp),%eax
     f2a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f2d:	7e 0e                	jle    f3d <APDrawLine+0x183>
        {
            s = x1;
     f2f:	8b 45 0c             	mov    0xc(%ebp),%eax
     f32:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f35:	8b 45 14             	mov    0x14(%ebp),%eax
     f38:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f3b:	eb 0c                	jmp    f49 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f3d:	8b 45 14             	mov    0x14(%ebp),%eax
     f40:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f43:	8b 45 0c             	mov    0xc(%ebp),%eax
     f46:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f49:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f4d:	79 07                	jns    f56 <APDrawLine+0x19c>
     f4f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f56:	8b 45 08             	mov    0x8(%ebp),%eax
     f59:	8b 00                	mov    (%eax),%eax
     f5b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f5e:	7f 0b                	jg     f6b <APDrawLine+0x1b1>
     f60:	8b 45 08             	mov    0x8(%ebp),%eax
     f63:	8b 00                	mov    (%eax),%eax
     f65:	83 e8 01             	sub    $0x1,%eax
     f68:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f6b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f6e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f71:	eb 3f                	jmp    fb2 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f73:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f76:	2b 45 0c             	sub    0xc(%ebp),%eax
     f79:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f7c:	db 45 b0             	fildl  -0x50(%ebp)
     f7f:	dc 4d d0             	fmull  -0x30(%ebp)
     f82:	db 45 10             	fildl  0x10(%ebp)
     f85:	de c1                	faddp  %st,%st(1)
     f87:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f8a:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f8e:	b4 0c                	mov    $0xc,%ah
     f90:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f94:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f97:	db 5d cc             	fistpl -0x34(%ebp)
     f9a:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f9d:	ff 75 cc             	pushl  -0x34(%ebp)
     fa0:	ff 75 e4             	pushl  -0x1c(%ebp)
     fa3:	ff 75 08             	pushl  0x8(%ebp)
     fa6:	e8 2c fd ff ff       	call   cd7 <APDrawPoint>
     fab:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     fae:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     fb2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fb5:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fb8:	7e b9                	jle    f73 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     fba:	e9 b9 00 00 00       	jmp    1078 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     fbf:	8b 45 0c             	mov    0xc(%ebp),%eax
     fc2:	2b 45 14             	sub    0x14(%ebp),%eax
     fc5:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fc8:	db 45 b0             	fildl  -0x50(%ebp)
     fcb:	8b 45 10             	mov    0x10(%ebp),%eax
     fce:	2b 45 18             	sub    0x18(%ebp),%eax
     fd1:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fd4:	db 45 b0             	fildl  -0x50(%ebp)
     fd7:	de f9                	fdivrp %st,%st(1)
     fd9:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     fdc:	8b 45 10             	mov    0x10(%ebp),%eax
     fdf:	3b 45 18             	cmp    0x18(%ebp),%eax
     fe2:	7e 0e                	jle    ff2 <APDrawLine+0x238>
    {
        s = y2;
     fe4:	8b 45 18             	mov    0x18(%ebp),%eax
     fe7:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     fea:	8b 45 10             	mov    0x10(%ebp),%eax
     fed:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ff0:	eb 0c                	jmp    ffe <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     ff2:	8b 45 10             	mov    0x10(%ebp),%eax
     ff5:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     ff8:	8b 45 18             	mov    0x18(%ebp),%eax
     ffb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     ffe:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1002:	79 07                	jns    100b <APDrawLine+0x251>
    1004:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    100b:	8b 45 08             	mov    0x8(%ebp),%eax
    100e:	8b 40 04             	mov    0x4(%eax),%eax
    1011:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1014:	7f 0c                	jg     1022 <APDrawLine+0x268>
    1016:	8b 45 08             	mov    0x8(%ebp),%eax
    1019:	8b 40 04             	mov    0x4(%eax),%eax
    101c:	83 e8 01             	sub    $0x1,%eax
    101f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1022:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1025:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1028:	eb 3f                	jmp    1069 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    102a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    102d:	2b 45 10             	sub    0x10(%ebp),%eax
    1030:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1033:	db 45 b0             	fildl  -0x50(%ebp)
    1036:	dc 4d c0             	fmull  -0x40(%ebp)
    1039:	db 45 0c             	fildl  0xc(%ebp)
    103c:	de c1                	faddp  %st,%st(1)
    103e:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1041:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1045:	b4 0c                	mov    $0xc,%ah
    1047:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    104b:	d9 6d b4             	fldcw  -0x4c(%ebp)
    104e:	db 5d bc             	fistpl -0x44(%ebp)
    1051:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1054:	ff 75 e0             	pushl  -0x20(%ebp)
    1057:	ff 75 bc             	pushl  -0x44(%ebp)
    105a:	ff 75 08             	pushl  0x8(%ebp)
    105d:	e8 75 fc ff ff       	call   cd7 <APDrawPoint>
    1062:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1065:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1069:	8b 45 e0             	mov    -0x20(%ebp),%eax
    106c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    106f:	7e b9                	jle    102a <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1071:	90                   	nop
    1072:	eb 04                	jmp    1078 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1074:	90                   	nop
    1075:	eb 01                	jmp    1078 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1077:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1078:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    107b:	c9                   	leave  
    107c:	c3                   	ret    

0000107d <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    107d:	55                   	push   %ebp
    107e:	89 e5                	mov    %esp,%ebp
    1080:	53                   	push   %ebx
    1081:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1084:	8b 55 10             	mov    0x10(%ebp),%edx
    1087:	8b 45 18             	mov    0x18(%ebp),%eax
    108a:	01 d0                	add    %edx,%eax
    108c:	83 e8 01             	sub    $0x1,%eax
    108f:	83 ec 04             	sub    $0x4,%esp
    1092:	50                   	push   %eax
    1093:	ff 75 0c             	pushl  0xc(%ebp)
    1096:	ff 75 10             	pushl  0x10(%ebp)
    1099:	ff 75 0c             	pushl  0xc(%ebp)
    109c:	ff 75 08             	pushl  0x8(%ebp)
    109f:	e8 16 fd ff ff       	call   dba <APDrawLine>
    10a4:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    10a7:	8b 55 0c             	mov    0xc(%ebp),%edx
    10aa:	8b 45 14             	mov    0x14(%ebp),%eax
    10ad:	01 d0                	add    %edx,%eax
    10af:	83 e8 01             	sub    $0x1,%eax
    10b2:	83 ec 04             	sub    $0x4,%esp
    10b5:	ff 75 10             	pushl  0x10(%ebp)
    10b8:	50                   	push   %eax
    10b9:	ff 75 10             	pushl  0x10(%ebp)
    10bc:	ff 75 0c             	pushl  0xc(%ebp)
    10bf:	ff 75 08             	pushl  0x8(%ebp)
    10c2:	e8 f3 fc ff ff       	call   dba <APDrawLine>
    10c7:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    10ca:	8b 55 10             	mov    0x10(%ebp),%edx
    10cd:	8b 45 18             	mov    0x18(%ebp),%eax
    10d0:	01 d0                	add    %edx,%eax
    10d2:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10d5:	8b 55 0c             	mov    0xc(%ebp),%edx
    10d8:	8b 45 14             	mov    0x14(%ebp),%eax
    10db:	01 d0                	add    %edx,%eax
    10dd:	8d 50 ff             	lea    -0x1(%eax),%edx
    10e0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10e3:	8b 45 14             	mov    0x14(%ebp),%eax
    10e6:	01 d8                	add    %ebx,%eax
    10e8:	83 e8 01             	sub    $0x1,%eax
    10eb:	83 ec 04             	sub    $0x4,%esp
    10ee:	51                   	push   %ecx
    10ef:	52                   	push   %edx
    10f0:	ff 75 10             	pushl  0x10(%ebp)
    10f3:	50                   	push   %eax
    10f4:	ff 75 08             	pushl  0x8(%ebp)
    10f7:	e8 be fc ff ff       	call   dba <APDrawLine>
    10fc:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10ff:	8b 55 10             	mov    0x10(%ebp),%edx
    1102:	8b 45 18             	mov    0x18(%ebp),%eax
    1105:	01 d0                	add    %edx,%eax
    1107:	8d 48 ff             	lea    -0x1(%eax),%ecx
    110a:	8b 55 0c             	mov    0xc(%ebp),%edx
    110d:	8b 45 14             	mov    0x14(%ebp),%eax
    1110:	01 d0                	add    %edx,%eax
    1112:	8d 50 ff             	lea    -0x1(%eax),%edx
    1115:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1118:	8b 45 18             	mov    0x18(%ebp),%eax
    111b:	01 d8                	add    %ebx,%eax
    111d:	83 e8 01             	sub    $0x1,%eax
    1120:	83 ec 04             	sub    $0x4,%esp
    1123:	51                   	push   %ecx
    1124:	52                   	push   %edx
    1125:	50                   	push   %eax
    1126:	ff 75 0c             	pushl  0xc(%ebp)
    1129:	ff 75 08             	pushl  0x8(%ebp)
    112c:	e8 89 fc ff ff       	call   dba <APDrawLine>
    1131:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1134:	8b 55 0c             	mov    0xc(%ebp),%edx
    1137:	8b 45 14             	mov    0x14(%ebp),%eax
    113a:	01 d0                	add    %edx,%eax
    113c:	8d 50 ff             	lea    -0x1(%eax),%edx
    113f:	8b 45 08             	mov    0x8(%ebp),%eax
    1142:	8b 40 0c             	mov    0xc(%eax),%eax
    1145:	89 c1                	mov    %eax,%ecx
    1147:	c1 e9 1f             	shr    $0x1f,%ecx
    114a:	01 c8                	add    %ecx,%eax
    114c:	d1 f8                	sar    %eax
    114e:	29 c2                	sub    %eax,%edx
    1150:	89 d0                	mov    %edx,%eax
    1152:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1155:	8b 55 10             	mov    0x10(%ebp),%edx
    1158:	8b 45 18             	mov    0x18(%ebp),%eax
    115b:	01 d0                	add    %edx,%eax
    115d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1160:	8b 45 08             	mov    0x8(%ebp),%eax
    1163:	8b 40 0c             	mov    0xc(%eax),%eax
    1166:	89 c1                	mov    %eax,%ecx
    1168:	c1 e9 1f             	shr    $0x1f,%ecx
    116b:	01 c8                	add    %ecx,%eax
    116d:	d1 f8                	sar    %eax
    116f:	29 c2                	sub    %eax,%edx
    1171:	89 d0                	mov    %edx,%eax
    1173:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1176:	8b 45 08             	mov    0x8(%ebp),%eax
    1179:	8b 40 0c             	mov    0xc(%eax),%eax
    117c:	89 c2                	mov    %eax,%edx
    117e:	c1 ea 1f             	shr    $0x1f,%edx
    1181:	01 d0                	add    %edx,%eax
    1183:	d1 f8                	sar    %eax
    1185:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1188:	8b 45 08             	mov    0x8(%ebp),%eax
    118b:	8b 40 0c             	mov    0xc(%eax),%eax
    118e:	89 c2                	mov    %eax,%edx
    1190:	c1 ea 1f             	shr    $0x1f,%edx
    1193:	01 d0                	add    %edx,%eax
    1195:	d1 f8                	sar    %eax
    1197:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    119a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    119e:	0f 88 d8 00 00 00    	js     127c <APDrawRect+0x1ff>
    11a4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11a8:	0f 88 ce 00 00 00    	js     127c <APDrawRect+0x1ff>
    11ae:	8b 45 08             	mov    0x8(%ebp),%eax
    11b1:	8b 00                	mov    (%eax),%eax
    11b3:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11b6:	0f 8e c0 00 00 00    	jle    127c <APDrawRect+0x1ff>
    11bc:	8b 45 08             	mov    0x8(%ebp),%eax
    11bf:	8b 40 04             	mov    0x4(%eax),%eax
    11c2:	3b 45 10             	cmp    0x10(%ebp),%eax
    11c5:	0f 8e b1 00 00 00    	jle    127c <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    11cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11cf:	79 07                	jns    11d8 <APDrawRect+0x15b>
    11d1:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    11d8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    11dc:	79 07                	jns    11e5 <APDrawRect+0x168>
    11de:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    11e5:	8b 45 08             	mov    0x8(%ebp),%eax
    11e8:	8b 00                	mov    (%eax),%eax
    11ea:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11ed:	7f 0b                	jg     11fa <APDrawRect+0x17d>
    11ef:	8b 45 08             	mov    0x8(%ebp),%eax
    11f2:	8b 00                	mov    (%eax),%eax
    11f4:	83 e8 01             	sub    $0x1,%eax
    11f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    11fa:	8b 45 08             	mov    0x8(%ebp),%eax
    11fd:	8b 40 04             	mov    0x4(%eax),%eax
    1200:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1203:	7f 0c                	jg     1211 <APDrawRect+0x194>
    1205:	8b 45 08             	mov    0x8(%ebp),%eax
    1208:	8b 40 04             	mov    0x4(%eax),%eax
    120b:	83 e8 01             	sub    $0x1,%eax
    120e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1211:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1218:	8b 45 0c             	mov    0xc(%ebp),%eax
    121b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    121e:	eb 52                	jmp    1272 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1220:	8b 45 10             	mov    0x10(%ebp),%eax
    1223:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1226:	eb 3e                	jmp    1266 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1228:	83 ec 04             	sub    $0x4,%esp
    122b:	ff 75 e8             	pushl  -0x18(%ebp)
    122e:	ff 75 ec             	pushl  -0x14(%ebp)
    1231:	ff 75 08             	pushl  0x8(%ebp)
    1234:	e8 02 f7 ff ff       	call   93b <APGetIndex>
    1239:	83 c4 10             	add    $0x10,%esp
    123c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    123f:	8b 45 08             	mov    0x8(%ebp),%eax
    1242:	8b 48 18             	mov    0x18(%eax),%ecx
    1245:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1248:	89 d0                	mov    %edx,%eax
    124a:	01 c0                	add    %eax,%eax
    124c:	01 d0                	add    %edx,%eax
    124e:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1251:	8b 45 08             	mov    0x8(%ebp),%eax
    1254:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1258:	66 89 0a             	mov    %cx,(%edx)
    125b:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    125f:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1262:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1266:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1269:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    126c:	7e ba                	jle    1228 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    126e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1272:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1275:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1278:	7e a6                	jle    1220 <APDrawRect+0x1a3>
    127a:	eb 01                	jmp    127d <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    127c:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    127d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1280:	c9                   	leave  
    1281:	c3                   	ret    

00001282 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1282:	55                   	push   %ebp
    1283:	89 e5                	mov    %esp,%ebp
}
    1285:	90                   	nop
    1286:	5d                   	pop    %ebp
    1287:	c3                   	ret    

00001288 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1288:	55                   	push   %ebp
    1289:	89 e5                	mov    %esp,%ebp
    128b:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    128e:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1292:	0f 88 8e 01 00 00    	js     1426 <APDcCopy+0x19e>
    1298:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    129c:	0f 88 84 01 00 00    	js     1426 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    12a2:	8b 55 0c             	mov    0xc(%ebp),%edx
    12a5:	8b 45 20             	mov    0x20(%ebp),%eax
    12a8:	01 d0                	add    %edx,%eax
    12aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12ad:	8b 55 10             	mov    0x10(%ebp),%edx
    12b0:	8b 45 24             	mov    0x24(%ebp),%eax
    12b3:	01 d0                	add    %edx,%eax
    12b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    12b8:	8b 55 18             	mov    0x18(%ebp),%edx
    12bb:	8b 45 20             	mov    0x20(%ebp),%eax
    12be:	01 d0                	add    %edx,%eax
    12c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12c3:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12c6:	8b 45 24             	mov    0x24(%ebp),%eax
    12c9:	01 d0                	add    %edx,%eax
    12cb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    12ce:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    12d2:	0f 88 51 01 00 00    	js     1429 <APDcCopy+0x1a1>
    12d8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12dc:	0f 88 47 01 00 00    	js     1429 <APDcCopy+0x1a1>
    12e2:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    12e6:	0f 88 3d 01 00 00    	js     1429 <APDcCopy+0x1a1>
    12ec:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    12f0:	0f 88 33 01 00 00    	js     1429 <APDcCopy+0x1a1>
    12f6:	8b 45 14             	mov    0x14(%ebp),%eax
    12f9:	8b 00                	mov    (%eax),%eax
    12fb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    12fe:	0f 8c 25 01 00 00    	jl     1429 <APDcCopy+0x1a1>
    1304:	8b 45 14             	mov    0x14(%ebp),%eax
    1307:	8b 40 04             	mov    0x4(%eax),%eax
    130a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    130d:	0f 8c 16 01 00 00    	jl     1429 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1313:	8b 45 08             	mov    0x8(%ebp),%eax
    1316:	8b 00                	mov    (%eax),%eax
    1318:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    131b:	7f 0b                	jg     1328 <APDcCopy+0xa0>
    131d:	8b 45 08             	mov    0x8(%ebp),%eax
    1320:	8b 00                	mov    (%eax),%eax
    1322:	83 e8 01             	sub    $0x1,%eax
    1325:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1328:	8b 45 08             	mov    0x8(%ebp),%eax
    132b:	8b 40 04             	mov    0x4(%eax),%eax
    132e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1331:	7f 0c                	jg     133f <APDcCopy+0xb7>
    1333:	8b 45 08             	mov    0x8(%ebp),%eax
    1336:	8b 40 04             	mov    0x4(%eax),%eax
    1339:	83 e8 01             	sub    $0x1,%eax
    133c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    133f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1346:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    134d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1354:	e9 bc 00 00 00       	jmp    1415 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1359:	8b 45 08             	mov    0x8(%ebp),%eax
    135c:	8b 00                	mov    (%eax),%eax
    135e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1361:	8b 55 10             	mov    0x10(%ebp),%edx
    1364:	01 ca                	add    %ecx,%edx
    1366:	0f af d0             	imul   %eax,%edx
    1369:	8b 45 0c             	mov    0xc(%ebp),%eax
    136c:	01 d0                	add    %edx,%eax
    136e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1371:	8b 45 14             	mov    0x14(%ebp),%eax
    1374:	8b 00                	mov    (%eax),%eax
    1376:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1379:	8b 55 1c             	mov    0x1c(%ebp),%edx
    137c:	01 ca                	add    %ecx,%edx
    137e:	0f af d0             	imul   %eax,%edx
    1381:	8b 45 18             	mov    0x18(%ebp),%eax
    1384:	01 d0                	add    %edx,%eax
    1386:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1389:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1390:	eb 74                	jmp    1406 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1392:	8b 45 14             	mov    0x14(%ebp),%eax
    1395:	8b 50 18             	mov    0x18(%eax),%edx
    1398:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    139b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    139e:	01 c8                	add    %ecx,%eax
    13a0:	89 c1                	mov    %eax,%ecx
    13a2:	89 c8                	mov    %ecx,%eax
    13a4:	01 c0                	add    %eax,%eax
    13a6:	01 c8                	add    %ecx,%eax
    13a8:	01 d0                	add    %edx,%eax
    13aa:	0f b7 10             	movzwl (%eax),%edx
    13ad:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    13b1:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    13b5:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    13b8:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13bc:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    13c0:	38 c2                	cmp    %al,%dl
    13c2:	75 18                	jne    13dc <APDcCopy+0x154>
    13c4:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    13c8:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    13cc:	38 c2                	cmp    %al,%dl
    13ce:	75 0c                	jne    13dc <APDcCopy+0x154>
    13d0:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    13d4:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    13d8:	38 c2                	cmp    %al,%dl
    13da:	74 26                	je     1402 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    13dc:	8b 45 08             	mov    0x8(%ebp),%eax
    13df:	8b 50 18             	mov    0x18(%eax),%edx
    13e2:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    13e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13e8:	01 c8                	add    %ecx,%eax
    13ea:	89 c1                	mov    %eax,%ecx
    13ec:	89 c8                	mov    %ecx,%eax
    13ee:	01 c0                	add    %eax,%eax
    13f0:	01 c8                	add    %ecx,%eax
    13f2:	01 d0                	add    %edx,%eax
    13f4:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    13f8:	66 89 10             	mov    %dx,(%eax)
    13fb:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13ff:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1402:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1406:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1409:	2b 45 0c             	sub    0xc(%ebp),%eax
    140c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    140f:	7d 81                	jge    1392 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1411:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1415:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1418:	2b 45 10             	sub    0x10(%ebp),%eax
    141b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    141e:	0f 8d 35 ff ff ff    	jge    1359 <APDcCopy+0xd1>
    1424:	eb 04                	jmp    142a <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1426:	90                   	nop
    1427:	eb 01                	jmp    142a <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1429:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    142a:	c9                   	leave  
    142b:	c3                   	ret    

0000142c <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    142c:	55                   	push   %ebp
    142d:	89 e5                	mov    %esp,%ebp
    142f:	83 ec 1c             	sub    $0x1c,%esp
    1432:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1435:	8b 55 10             	mov    0x10(%ebp),%edx
    1438:	8b 45 14             	mov    0x14(%ebp),%eax
    143b:	88 4d ec             	mov    %cl,-0x14(%ebp)
    143e:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1441:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1444:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1448:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    144b:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    144f:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1452:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1456:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1459:	8b 45 08             	mov    0x8(%ebp),%eax
    145c:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1460:	66 89 10             	mov    %dx,(%eax)
    1463:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1467:	88 50 02             	mov    %dl,0x2(%eax)
}
    146a:	8b 45 08             	mov    0x8(%ebp),%eax
    146d:	c9                   	leave  
    146e:	c2 04 00             	ret    $0x4

00001471 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1471:	55                   	push   %ebp
    1472:	89 e5                	mov    %esp,%ebp
    1474:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1477:	8b 45 08             	mov    0x8(%ebp),%eax
    147a:	8b 00                	mov    (%eax),%eax
    147c:	83 ec 08             	sub    $0x8,%esp
    147f:	8d 55 0c             	lea    0xc(%ebp),%edx
    1482:	52                   	push   %edx
    1483:	50                   	push   %eax
    1484:	e8 77 ef ff ff       	call   400 <sendMessage>
    1489:	83 c4 10             	add    $0x10,%esp
}
    148c:	90                   	nop
    148d:	c9                   	leave  
    148e:	c3                   	ret    

0000148f <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    148f:	55                   	push   %ebp
    1490:	89 e5                	mov    %esp,%ebp
    1492:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1495:	83 ec 0c             	sub    $0xc,%esp
    1498:	68 98 00 00 00       	push   $0x98
    149d:	e8 38 f3 ff ff       	call   7da <malloc>
    14a2:	83 c4 10             	add    $0x10,%esp
    14a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    14a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14ac:	75 15                	jne    14c3 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    14ae:	83 ec 04             	sub    $0x4,%esp
    14b1:	ff 75 08             	pushl  0x8(%ebp)
    14b4:	68 44 23 00 00       	push   $0x2344
    14b9:	6a 01                	push   $0x1
    14bb:	e8 47 f0 ff ff       	call   507 <printf>
    14c0:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    14c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c6:	05 84 00 00 00       	add    $0x84,%eax
    14cb:	83 ec 08             	sub    $0x8,%esp
    14ce:	ff 75 08             	pushl  0x8(%ebp)
    14d1:	50                   	push   %eax
    14d2:	e8 50 ec ff ff       	call   127 <strcpy>
    14d7:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    14da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14dd:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    14e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e7:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f1:	8b 40 3c             	mov    0x3c(%eax),%eax
    14f4:	89 c2                	mov    %eax,%edx
    14f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f9:	8b 40 40             	mov    0x40(%eax),%eax
    14fc:	0f af d0             	imul   %eax,%edx
    14ff:	89 d0                	mov    %edx,%eax
    1501:	01 c0                	add    %eax,%eax
    1503:	01 d0                	add    %edx,%eax
    1505:	83 ec 0c             	sub    $0xc,%esp
    1508:	50                   	push   %eax
    1509:	e8 cc f2 ff ff       	call   7da <malloc>
    150e:	83 c4 10             	add    $0x10,%esp
    1511:	89 c2                	mov    %eax,%edx
    1513:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1516:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1519:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151c:	8b 40 54             	mov    0x54(%eax),%eax
    151f:	85 c0                	test   %eax,%eax
    1521:	75 15                	jne    1538 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1523:	83 ec 04             	sub    $0x4,%esp
    1526:	ff 75 08             	pushl  0x8(%ebp)
    1529:	68 64 23 00 00       	push   $0x2364
    152e:	6a 01                	push   $0x1
    1530:	e8 d2 ef ff ff       	call   507 <printf>
    1535:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1538:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153b:	8b 40 3c             	mov    0x3c(%eax),%eax
    153e:	89 c2                	mov    %eax,%edx
    1540:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1543:	8b 40 40             	mov    0x40(%eax),%eax
    1546:	0f af d0             	imul   %eax,%edx
    1549:	89 d0                	mov    %edx,%eax
    154b:	01 c0                	add    %eax,%eax
    154d:	01 c2                	add    %eax,%edx
    154f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1552:	8b 40 54             	mov    0x54(%eax),%eax
    1555:	83 ec 04             	sub    $0x4,%esp
    1558:	52                   	push   %edx
    1559:	68 ff ff ff 00       	push   $0xffffff
    155e:	50                   	push   %eax
    155f:	e8 59 ec ff ff       	call   1bd <memset>
    1564:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1567:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156a:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1571:	e8 62 ee ff ff       	call   3d8 <getpid>
    1576:	89 c2                	mov    %eax,%edx
    1578:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157b:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    157e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1581:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1588:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158b:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1592:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1595:	8b 40 58             	mov    0x58(%eax),%eax
    1598:	89 c2                	mov    %eax,%edx
    159a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159d:	8b 40 5c             	mov    0x5c(%eax),%eax
    15a0:	0f af d0             	imul   %eax,%edx
    15a3:	89 d0                	mov    %edx,%eax
    15a5:	01 c0                	add    %eax,%eax
    15a7:	01 d0                	add    %edx,%eax
    15a9:	83 ec 0c             	sub    $0xc,%esp
    15ac:	50                   	push   %eax
    15ad:	e8 28 f2 ff ff       	call   7da <malloc>
    15b2:	83 c4 10             	add    $0x10,%esp
    15b5:	89 c2                	mov    %eax,%edx
    15b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ba:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    15bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c0:	8b 40 70             	mov    0x70(%eax),%eax
    15c3:	85 c0                	test   %eax,%eax
    15c5:	75 15                	jne    15dc <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    15c7:	83 ec 04             	sub    $0x4,%esp
    15ca:	ff 75 08             	pushl  0x8(%ebp)
    15cd:	68 88 23 00 00       	push   $0x2388
    15d2:	6a 01                	push   $0x1
    15d4:	e8 2e ef ff ff       	call   507 <printf>
    15d9:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15df:	8b 40 3c             	mov    0x3c(%eax),%eax
    15e2:	89 c2                	mov    %eax,%edx
    15e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e7:	8b 40 40             	mov    0x40(%eax),%eax
    15ea:	0f af d0             	imul   %eax,%edx
    15ed:	89 d0                	mov    %edx,%eax
    15ef:	01 c0                	add    %eax,%eax
    15f1:	01 c2                	add    %eax,%edx
    15f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f6:	8b 40 54             	mov    0x54(%eax),%eax
    15f9:	83 ec 04             	sub    $0x4,%esp
    15fc:	52                   	push   %edx
    15fd:	68 ff 00 00 00       	push   $0xff
    1602:	50                   	push   %eax
    1603:	e8 b5 eb ff ff       	call   1bd <memset>
    1608:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    160b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1611:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1614:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1618:	74 49                	je     1663 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    161a:	8b 45 10             	mov    0x10(%ebp),%eax
    161d:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1623:	83 ec 0c             	sub    $0xc,%esp
    1626:	50                   	push   %eax
    1627:	e8 ae f1 ff ff       	call   7da <malloc>
    162c:	83 c4 10             	add    $0x10,%esp
    162f:	89 c2                	mov    %eax,%edx
    1631:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1634:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1637:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163a:	8b 55 10             	mov    0x10(%ebp),%edx
    163d:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1640:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1643:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    164a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164d:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1654:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1657:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    165e:	e9 8d 00 00 00       	jmp    16f0 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1663:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1666:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    166d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1670:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1677:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167a:	8b 40 20             	mov    0x20(%eax),%eax
    167d:	89 c2                	mov    %eax,%edx
    167f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1682:	8b 40 24             	mov    0x24(%eax),%eax
    1685:	0f af d0             	imul   %eax,%edx
    1688:	89 d0                	mov    %edx,%eax
    168a:	01 c0                	add    %eax,%eax
    168c:	01 d0                	add    %edx,%eax
    168e:	83 ec 0c             	sub    $0xc,%esp
    1691:	50                   	push   %eax
    1692:	e8 43 f1 ff ff       	call   7da <malloc>
    1697:	83 c4 10             	add    $0x10,%esp
    169a:	89 c2                	mov    %eax,%edx
    169c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169f:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    16a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a5:	8b 40 38             	mov    0x38(%eax),%eax
    16a8:	85 c0                	test   %eax,%eax
    16aa:	75 15                	jne    16c1 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    16ac:	83 ec 04             	sub    $0x4,%esp
    16af:	ff 75 08             	pushl  0x8(%ebp)
    16b2:	68 b0 23 00 00       	push   $0x23b0
    16b7:	6a 01                	push   $0x1
    16b9:	e8 49 ee ff ff       	call   507 <printf>
    16be:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c4:	8b 40 20             	mov    0x20(%eax),%eax
    16c7:	89 c2                	mov    %eax,%edx
    16c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16cc:	8b 40 24             	mov    0x24(%eax),%eax
    16cf:	0f af d0             	imul   %eax,%edx
    16d2:	89 d0                	mov    %edx,%eax
    16d4:	01 c0                	add    %eax,%eax
    16d6:	01 c2                	add    %eax,%edx
    16d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16db:	8b 40 38             	mov    0x38(%eax),%eax
    16de:	83 ec 04             	sub    $0x4,%esp
    16e1:	52                   	push   %edx
    16e2:	68 ff ff ff 00       	push   $0xffffff
    16e7:	50                   	push   %eax
    16e8:	e8 d0 ea ff ff       	call   1bd <memset>
    16ed:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    16f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    16f3:	c9                   	leave  
    16f4:	c3                   	ret    

000016f5 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    16f5:	55                   	push   %ebp
    16f6:	89 e5                	mov    %esp,%ebp
    16f8:	57                   	push   %edi
    16f9:	56                   	push   %esi
    16fa:	53                   	push   %ebx
    16fb:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    16fe:	8b 45 0c             	mov    0xc(%ebp),%eax
    1701:	83 f8 03             	cmp    $0x3,%eax
    1704:	74 02                	je     1708 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1706:	eb 7c                	jmp    1784 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1708:	8b 45 08             	mov    0x8(%ebp),%eax
    170b:	8b 58 1c             	mov    0x1c(%eax),%ebx
    170e:	8b 45 08             	mov    0x8(%ebp),%eax
    1711:	8b 48 18             	mov    0x18(%eax),%ecx
    1714:	8b 45 08             	mov    0x8(%ebp),%eax
    1717:	8b 50 5c             	mov    0x5c(%eax),%edx
    171a:	8b 45 08             	mov    0x8(%ebp),%eax
    171d:	8b 40 58             	mov    0x58(%eax),%eax
    1720:	8b 75 08             	mov    0x8(%ebp),%esi
    1723:	83 c6 58             	add    $0x58,%esi
    1726:	83 ec 04             	sub    $0x4,%esp
    1729:	53                   	push   %ebx
    172a:	51                   	push   %ecx
    172b:	6a 00                	push   $0x0
    172d:	52                   	push   %edx
    172e:	50                   	push   %eax
    172f:	6a 00                	push   $0x0
    1731:	6a 00                	push   $0x0
    1733:	56                   	push   %esi
    1734:	6a 00                	push   $0x0
    1736:	6a 00                	push   $0x0
    1738:	ff 75 08             	pushl  0x8(%ebp)
    173b:	e8 b8 ec ff ff       	call   3f8 <paintWindow>
    1740:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1743:	8b 45 08             	mov    0x8(%ebp),%eax
    1746:	8b 70 1c             	mov    0x1c(%eax),%esi
    1749:	8b 45 08             	mov    0x8(%ebp),%eax
    174c:	8b 58 18             	mov    0x18(%eax),%ebx
    174f:	8b 45 08             	mov    0x8(%ebp),%eax
    1752:	8b 48 08             	mov    0x8(%eax),%ecx
    1755:	8b 45 08             	mov    0x8(%ebp),%eax
    1758:	8b 50 40             	mov    0x40(%eax),%edx
    175b:	8b 45 08             	mov    0x8(%ebp),%eax
    175e:	8b 40 3c             	mov    0x3c(%eax),%eax
    1761:	8b 7d 08             	mov    0x8(%ebp),%edi
    1764:	83 c7 3c             	add    $0x3c,%edi
    1767:	83 ec 04             	sub    $0x4,%esp
    176a:	56                   	push   %esi
    176b:	53                   	push   %ebx
    176c:	51                   	push   %ecx
    176d:	52                   	push   %edx
    176e:	50                   	push   %eax
    176f:	6a 00                	push   $0x0
    1771:	6a 00                	push   $0x0
    1773:	57                   	push   %edi
    1774:	6a 32                	push   $0x32
    1776:	6a 00                	push   $0x0
    1778:	ff 75 08             	pushl  0x8(%ebp)
    177b:	e8 78 ec ff ff       	call   3f8 <paintWindow>
    1780:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1783:	90                   	nop
        default: break;
            
            
    }
    return False;
    1784:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1789:	8d 65 f4             	lea    -0xc(%ebp),%esp
    178c:	5b                   	pop    %ebx
    178d:	5e                   	pop    %esi
    178e:	5f                   	pop    %edi
    178f:	5d                   	pop    %ebp
    1790:	c3                   	ret    

00001791 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1791:	55                   	push   %ebp
    1792:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1794:	8b 45 0c             	mov    0xc(%ebp),%eax
    1797:	8b 50 08             	mov    0x8(%eax),%edx
    179a:	8b 45 08             	mov    0x8(%ebp),%eax
    179d:	8b 00                	mov    (%eax),%eax
    179f:	39 c2                	cmp    %eax,%edx
    17a1:	74 07                	je     17aa <APPreJudge+0x19>
        return False;
    17a3:	b8 00 00 00 00       	mov    $0x0,%eax
    17a8:	eb 05                	jmp    17af <APPreJudge+0x1e>
    return True;
    17aa:	b8 01 00 00 00       	mov    $0x1,%eax
}
    17af:	5d                   	pop    %ebp
    17b0:	c3                   	ret    

000017b1 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    17b1:	55                   	push   %ebp
    17b2:	89 e5                	mov    %esp,%ebp
    17b4:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    17b7:	8b 45 08             	mov    0x8(%ebp),%eax
    17ba:	8b 55 0c             	mov    0xc(%ebp),%edx
    17bd:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    17c3:	83 ec 0c             	sub    $0xc,%esp
    17c6:	ff 75 08             	pushl  0x8(%ebp)
    17c9:	e8 42 ec ff ff       	call   410 <registWindow>
    17ce:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    17d1:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    17d8:	8b 45 08             	mov    0x8(%ebp),%eax
    17db:	8b 00                	mov    (%eax),%eax
    17dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    17e0:	ff 75 f4             	pushl  -0xc(%ebp)
    17e3:	ff 75 f0             	pushl  -0x10(%ebp)
    17e6:	ff 75 ec             	pushl  -0x14(%ebp)
    17e9:	ff 75 08             	pushl  0x8(%ebp)
    17ec:	e8 80 fc ff ff       	call   1471 <APSendMessage>
    17f1:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    17f4:	83 ec 0c             	sub    $0xc,%esp
    17f7:	ff 75 08             	pushl  0x8(%ebp)
    17fa:	e8 09 ec ff ff       	call   408 <getMessage>
    17ff:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1802:	8b 45 08             	mov    0x8(%ebp),%eax
    1805:	83 c0 74             	add    $0x74,%eax
    1808:	83 ec 08             	sub    $0x8,%esp
    180b:	50                   	push   %eax
    180c:	ff 75 08             	pushl  0x8(%ebp)
    180f:	e8 7d ff ff ff       	call   1791 <APPreJudge>
    1814:	83 c4 10             	add    $0x10,%esp
    1817:	84 c0                	test   %al,%al
    1819:	74 1b                	je     1836 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    181b:	8b 45 08             	mov    0x8(%ebp),%eax
    181e:	ff 70 7c             	pushl  0x7c(%eax)
    1821:	ff 70 78             	pushl  0x78(%eax)
    1824:	ff 70 74             	pushl  0x74(%eax)
    1827:	ff 75 08             	pushl  0x8(%ebp)
    182a:	8b 45 0c             	mov    0xc(%ebp),%eax
    182d:	ff d0                	call   *%eax
    182f:	83 c4 10             	add    $0x10,%esp
    1832:	84 c0                	test   %al,%al
    1834:	75 0c                	jne    1842 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1836:	8b 45 08             	mov    0x8(%ebp),%eax
    1839:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1840:	eb b2                	jmp    17f4 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1842:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1843:	90                   	nop
    1844:	c9                   	leave  
    1845:	c3                   	ret    

00001846 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1846:	55                   	push   %ebp
    1847:	89 e5                	mov    %esp,%ebp
    1849:	57                   	push   %edi
    184a:	56                   	push   %esi
    184b:	53                   	push   %ebx
    184c:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    184f:	a1 3c 2a 00 00       	mov    0x2a3c,%eax
    1854:	85 c0                	test   %eax,%eax
    1856:	0f 85 2c 02 00 00    	jne    1a88 <APGridPaint+0x242>
    {
        iconReady = 1;
    185c:	c7 05 3c 2a 00 00 01 	movl   $0x1,0x2a3c
    1863:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1866:	8d 45 98             	lea    -0x68(%ebp),%eax
    1869:	83 ec 08             	sub    $0x8,%esp
    186c:	68 d7 23 00 00       	push   $0x23d7
    1871:	50                   	push   %eax
    1872:	e8 16 f1 ff ff       	call   98d <APLoadBitmap>
    1877:	83 c4 0c             	add    $0xc,%esp
    187a:	8b 45 98             	mov    -0x68(%ebp),%eax
    187d:	a3 60 2a 00 00       	mov    %eax,0x2a60
    1882:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1885:	a3 64 2a 00 00       	mov    %eax,0x2a64
    188a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    188d:	a3 68 2a 00 00       	mov    %eax,0x2a68
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1892:	83 ec 04             	sub    $0x4,%esp
    1895:	ff 35 68 2a 00 00    	pushl  0x2a68
    189b:	ff 35 64 2a 00 00    	pushl  0x2a64
    18a1:	ff 35 60 2a 00 00    	pushl  0x2a60
    18a7:	e8 1b f3 ff ff       	call   bc7 <APCreateCompatibleDCFromBitmap>
    18ac:	83 c4 10             	add    $0x10,%esp
    18af:	a3 6c 2a 00 00       	mov    %eax,0x2a6c
        grid_river = APLoadBitmap ("grid_river.bmp");
    18b4:	8d 45 98             	lea    -0x68(%ebp),%eax
    18b7:	83 ec 08             	sub    $0x8,%esp
    18ba:	68 e5 23 00 00       	push   $0x23e5
    18bf:	50                   	push   %eax
    18c0:	e8 c8 f0 ff ff       	call   98d <APLoadBitmap>
    18c5:	83 c4 0c             	add    $0xc,%esp
    18c8:	8b 45 98             	mov    -0x68(%ebp),%eax
    18cb:	a3 9c 2a 00 00       	mov    %eax,0x2a9c
    18d0:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18d3:	a3 a0 2a 00 00       	mov    %eax,0x2aa0
    18d8:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18db:	a3 a4 2a 00 00       	mov    %eax,0x2aa4
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    18e0:	83 ec 04             	sub    $0x4,%esp
    18e3:	ff 35 a4 2a 00 00    	pushl  0x2aa4
    18e9:	ff 35 a0 2a 00 00    	pushl  0x2aa0
    18ef:	ff 35 9c 2a 00 00    	pushl  0x2a9c
    18f5:	e8 cd f2 ff ff       	call   bc7 <APCreateCompatibleDCFromBitmap>
    18fa:	83 c4 10             	add    $0x10,%esp
    18fd:	a3 8c 2a 00 00       	mov    %eax,0x2a8c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1902:	8d 45 98             	lea    -0x68(%ebp),%eax
    1905:	83 ec 08             	sub    $0x8,%esp
    1908:	68 f4 23 00 00       	push   $0x23f4
    190d:	50                   	push   %eax
    190e:	e8 7a f0 ff ff       	call   98d <APLoadBitmap>
    1913:	83 c4 0c             	add    $0xc,%esp
    1916:	8b 45 98             	mov    -0x68(%ebp),%eax
    1919:	a3 90 2a 00 00       	mov    %eax,0x2a90
    191e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1921:	a3 94 2a 00 00       	mov    %eax,0x2a94
    1926:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1929:	a3 98 2a 00 00       	mov    %eax,0x2a98
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    192e:	83 ec 04             	sub    $0x4,%esp
    1931:	ff 35 98 2a 00 00    	pushl  0x2a98
    1937:	ff 35 94 2a 00 00    	pushl  0x2a94
    193d:	ff 35 90 2a 00 00    	pushl  0x2a90
    1943:	e8 7f f2 ff ff       	call   bc7 <APCreateCompatibleDCFromBitmap>
    1948:	83 c4 10             	add    $0x10,%esp
    194b:	a3 40 2a 00 00       	mov    %eax,0x2a40
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1950:	8d 45 98             	lea    -0x68(%ebp),%eax
    1953:	83 ec 08             	sub    $0x8,%esp
    1956:	68 03 24 00 00       	push   $0x2403
    195b:	50                   	push   %eax
    195c:	e8 2c f0 ff ff       	call   98d <APLoadBitmap>
    1961:	83 c4 0c             	add    $0xc,%esp
    1964:	8b 45 98             	mov    -0x68(%ebp),%eax
    1967:	a3 74 2a 00 00       	mov    %eax,0x2a74
    196c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    196f:	a3 78 2a 00 00       	mov    %eax,0x2a78
    1974:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1977:	a3 7c 2a 00 00       	mov    %eax,0x2a7c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    197c:	83 ec 04             	sub    $0x4,%esp
    197f:	ff 35 7c 2a 00 00    	pushl  0x2a7c
    1985:	ff 35 78 2a 00 00    	pushl  0x2a78
    198b:	ff 35 74 2a 00 00    	pushl  0x2a74
    1991:	e8 31 f2 ff ff       	call   bc7 <APCreateCompatibleDCFromBitmap>
    1996:	83 c4 10             	add    $0x10,%esp
    1999:	a3 a8 2a 00 00       	mov    %eax,0x2aa8
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    199e:	8d 45 98             	lea    -0x68(%ebp),%eax
    19a1:	83 ec 08             	sub    $0x8,%esp
    19a4:	68 11 24 00 00       	push   $0x2411
    19a9:	50                   	push   %eax
    19aa:	e8 de ef ff ff       	call   98d <APLoadBitmap>
    19af:	83 c4 0c             	add    $0xc,%esp
    19b2:	8b 45 98             	mov    -0x68(%ebp),%eax
    19b5:	a3 50 2a 00 00       	mov    %eax,0x2a50
    19ba:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19bd:	a3 54 2a 00 00       	mov    %eax,0x2a54
    19c2:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19c5:	a3 58 2a 00 00       	mov    %eax,0x2a58
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    19ca:	83 ec 04             	sub    $0x4,%esp
    19cd:	ff 35 58 2a 00 00    	pushl  0x2a58
    19d3:	ff 35 54 2a 00 00    	pushl  0x2a54
    19d9:	ff 35 50 2a 00 00    	pushl  0x2a50
    19df:	e8 e3 f1 ff ff       	call   bc7 <APCreateCompatibleDCFromBitmap>
    19e4:	83 c4 10             	add    $0x10,%esp
    19e7:	a3 70 2a 00 00       	mov    %eax,0x2a70
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    19ec:	8d 45 98             	lea    -0x68(%ebp),%eax
    19ef:	83 ec 08             	sub    $0x8,%esp
    19f2:	68 21 24 00 00       	push   $0x2421
    19f7:	50                   	push   %eax
    19f8:	e8 90 ef ff ff       	call   98d <APLoadBitmap>
    19fd:	83 c4 0c             	add    $0xc,%esp
    1a00:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a03:	a3 44 2a 00 00       	mov    %eax,0x2a44
    1a08:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a0b:	a3 48 2a 00 00       	mov    %eax,0x2a48
    1a10:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a13:	a3 4c 2a 00 00       	mov    %eax,0x2a4c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1a18:	83 ec 04             	sub    $0x4,%esp
    1a1b:	ff 35 4c 2a 00 00    	pushl  0x2a4c
    1a21:	ff 35 48 2a 00 00    	pushl  0x2a48
    1a27:	ff 35 44 2a 00 00    	pushl  0x2a44
    1a2d:	e8 95 f1 ff ff       	call   bc7 <APCreateCompatibleDCFromBitmap>
    1a32:	83 c4 10             	add    $0x10,%esp
    1a35:	a3 5c 2a 00 00       	mov    %eax,0x2a5c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1a3a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a3d:	83 ec 08             	sub    $0x8,%esp
    1a40:	68 33 24 00 00       	push   $0x2433
    1a45:	50                   	push   %eax
    1a46:	e8 42 ef ff ff       	call   98d <APLoadBitmap>
    1a4b:	83 c4 0c             	add    $0xc,%esp
    1a4e:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a51:	a3 80 2a 00 00       	mov    %eax,0x2a80
    1a56:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a59:	a3 84 2a 00 00       	mov    %eax,0x2a84
    1a5e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a61:	a3 88 2a 00 00       	mov    %eax,0x2a88
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1a66:	83 ec 04             	sub    $0x4,%esp
    1a69:	ff 35 88 2a 00 00    	pushl  0x2a88
    1a6f:	ff 35 84 2a 00 00    	pushl  0x2a84
    1a75:	ff 35 80 2a 00 00    	pushl  0x2a80
    1a7b:	e8 47 f1 ff ff       	call   bc7 <APCreateCompatibleDCFromBitmap>
    1a80:	83 c4 10             	add    $0x10,%esp
    1a83:	a3 ac 2a 00 00       	mov    %eax,0x2aac
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1a88:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8b:	8b 40 08             	mov    0x8(%eax),%eax
    1a8e:	85 c0                	test   %eax,%eax
    1a90:	75 17                	jne    1aa9 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1a92:	83 ec 08             	sub    $0x8,%esp
    1a95:	68 44 24 00 00       	push   $0x2444
    1a9a:	6a 01                	push   $0x1
    1a9c:	e8 66 ea ff ff       	call   507 <printf>
    1aa1:	83 c4 10             	add    $0x10,%esp
        return;
    1aa4:	e9 a0 04 00 00       	jmp    1f49 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1aa9:	8b 45 08             	mov    0x8(%ebp),%eax
    1aac:	8b 40 10             	mov    0x10(%eax),%eax
    1aaf:	85 c0                	test   %eax,%eax
    1ab1:	7e 10                	jle    1ac3 <APGridPaint+0x27d>
    1ab3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab6:	8b 50 14             	mov    0x14(%eax),%edx
    1ab9:	8b 45 08             	mov    0x8(%ebp),%eax
    1abc:	8b 40 10             	mov    0x10(%eax),%eax
    1abf:	39 c2                	cmp    %eax,%edx
    1ac1:	7c 17                	jl     1ada <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1ac3:	83 ec 08             	sub    $0x8,%esp
    1ac6:	68 6a 24 00 00       	push   $0x246a
    1acb:	6a 01                	push   $0x1
    1acd:	e8 35 ea ff ff       	call   507 <printf>
    1ad2:	83 c4 10             	add    $0x10,%esp
        return;
    1ad5:	e9 6f 04 00 00       	jmp    1f49 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1ada:	8b 45 08             	mov    0x8(%ebp),%eax
    1add:	8b 40 14             	mov    0x14(%eax),%eax
    1ae0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1ae6:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1ae9:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1aec:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1aef:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1af6:	e9 96 03 00 00       	jmp    1e91 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1afb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1b02:	e9 7c 03 00 00       	jmp    1e83 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1b07:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b0a:	c1 e0 04             	shl    $0x4,%eax
    1b0d:	89 c2                	mov    %eax,%edx
    1b0f:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b12:	01 c2                	add    %eax,%edx
    1b14:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b17:	01 d0                	add    %edx,%eax
    1b19:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1b1c:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1f:	8b 40 0c             	mov    0xc(%eax),%eax
    1b22:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1b25:	c1 e2 02             	shl    $0x2,%edx
    1b28:	01 d0                	add    %edx,%eax
    1b2a:	8b 00                	mov    (%eax),%eax
    1b2c:	83 f8 07             	cmp    $0x7,%eax
    1b2f:	0f 87 49 03 00 00    	ja     1e7e <APGridPaint+0x638>
    1b35:	8b 04 85 80 24 00 00 	mov    0x2480(,%eax,4),%eax
    1b3c:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b3e:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1b41:	6a 0c                	push   $0xc
    1b43:	6a 0c                	push   $0xc
    1b45:	6a 0c                	push   $0xc
    1b47:	50                   	push   %eax
    1b48:	e8 df f8 ff ff       	call   142c <RGB>
    1b4d:	83 c4 0c             	add    $0xc,%esp
    1b50:	8b 1d 6c 2a 00 00    	mov    0x2a6c,%ebx
    1b56:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b59:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b5c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b5f:	6b c0 32             	imul   $0x32,%eax,%eax
    1b62:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b65:	8b 45 08             	mov    0x8(%ebp),%eax
    1b68:	8d 78 3c             	lea    0x3c(%eax),%edi
    1b6b:	83 ec 0c             	sub    $0xc,%esp
    1b6e:	83 ec 04             	sub    $0x4,%esp
    1b71:	89 e0                	mov    %esp,%eax
    1b73:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1b77:	66 89 30             	mov    %si,(%eax)
    1b7a:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1b7e:	88 50 02             	mov    %dl,0x2(%eax)
    1b81:	6a 32                	push   $0x32
    1b83:	6a 32                	push   $0x32
    1b85:	6a 00                	push   $0x0
    1b87:	6a 00                	push   $0x0
    1b89:	53                   	push   %ebx
    1b8a:	51                   	push   %ecx
    1b8b:	ff 75 94             	pushl  -0x6c(%ebp)
    1b8e:	57                   	push   %edi
    1b8f:	e8 f4 f6 ff ff       	call   1288 <APDcCopy>
    1b94:	83 c4 30             	add    $0x30,%esp
                    break;
    1b97:	e9 e3 02 00 00       	jmp    1e7f <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1b9c:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b9f:	6a 69                	push   $0x69
    1ba1:	6a 69                	push   $0x69
    1ba3:	6a 69                	push   $0x69
    1ba5:	50                   	push   %eax
    1ba6:	e8 81 f8 ff ff       	call   142c <RGB>
    1bab:	83 c4 0c             	add    $0xc,%esp
    1bae:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1bb2:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1bb6:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1bba:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1bbd:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1bc4:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bc7:	6a 69                	push   $0x69
    1bc9:	6a 69                	push   $0x69
    1bcb:	6a 69                	push   $0x69
    1bcd:	50                   	push   %eax
    1bce:	e8 59 f8 ff ff       	call   142c <RGB>
    1bd3:	83 c4 0c             	add    $0xc,%esp
    1bd6:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1bda:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1bde:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1be2:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1be5:	8b 45 08             	mov    0x8(%ebp),%eax
    1be8:	8d 50 3c             	lea    0x3c(%eax),%edx
    1beb:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bee:	ff 75 b0             	pushl  -0x50(%ebp)
    1bf1:	ff 75 ac             	pushl  -0x54(%ebp)
    1bf4:	52                   	push   %edx
    1bf5:	50                   	push   %eax
    1bf6:	e8 61 f0 ff ff       	call   c5c <APSetPen>
    1bfb:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1bfe:	8b 45 08             	mov    0x8(%ebp),%eax
    1c01:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1c04:	8d 55 98             	lea    -0x68(%ebp),%edx
    1c07:	83 ec 04             	sub    $0x4,%esp
    1c0a:	83 ec 04             	sub    $0x4,%esp
    1c0d:	89 e0                	mov    %esp,%eax
    1c0f:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1c13:	66 89 08             	mov    %cx,(%eax)
    1c16:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1c1a:	88 48 02             	mov    %cl,0x2(%eax)
    1c1d:	53                   	push   %ebx
    1c1e:	52                   	push   %edx
    1c1f:	e8 71 f0 ff ff       	call   c95 <APSetBrush>
    1c24:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1c27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c2a:	6b d0 32             	imul   $0x32,%eax,%edx
    1c2d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c30:	6b c0 32             	imul   $0x32,%eax,%eax
    1c33:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c36:	83 c1 3c             	add    $0x3c,%ecx
    1c39:	83 ec 0c             	sub    $0xc,%esp
    1c3c:	6a 32                	push   $0x32
    1c3e:	6a 32                	push   $0x32
    1c40:	52                   	push   %edx
    1c41:	50                   	push   %eax
    1c42:	51                   	push   %ecx
    1c43:	e8 35 f4 ff ff       	call   107d <APDrawRect>
    1c48:	83 c4 20             	add    $0x20,%esp
                    break;
    1c4b:	e9 2f 02 00 00       	jmp    1e7f <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c50:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1c53:	6a 0c                	push   $0xc
    1c55:	6a 0c                	push   $0xc
    1c57:	6a 0c                	push   $0xc
    1c59:	50                   	push   %eax
    1c5a:	e8 cd f7 ff ff       	call   142c <RGB>
    1c5f:	83 c4 0c             	add    $0xc,%esp
    1c62:	8b 1d ac 2a 00 00    	mov    0x2aac,%ebx
    1c68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c6b:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c6e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c71:	6b c0 32             	imul   $0x32,%eax,%eax
    1c74:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c77:	8b 45 08             	mov    0x8(%ebp),%eax
    1c7a:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c7d:	83 ec 0c             	sub    $0xc,%esp
    1c80:	83 ec 04             	sub    $0x4,%esp
    1c83:	89 e0                	mov    %esp,%eax
    1c85:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1c89:	66 89 30             	mov    %si,(%eax)
    1c8c:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1c90:	88 50 02             	mov    %dl,0x2(%eax)
    1c93:	6a 32                	push   $0x32
    1c95:	6a 32                	push   $0x32
    1c97:	6a 00                	push   $0x0
    1c99:	6a 00                	push   $0x0
    1c9b:	53                   	push   %ebx
    1c9c:	51                   	push   %ecx
    1c9d:	ff 75 94             	pushl  -0x6c(%ebp)
    1ca0:	57                   	push   %edi
    1ca1:	e8 e2 f5 ff ff       	call   1288 <APDcCopy>
    1ca6:	83 c4 30             	add    $0x30,%esp
                    break;
    1ca9:	e9 d1 01 00 00       	jmp    1e7f <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cae:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1cb1:	6a 0c                	push   $0xc
    1cb3:	6a 0c                	push   $0xc
    1cb5:	6a 0c                	push   $0xc
    1cb7:	50                   	push   %eax
    1cb8:	e8 6f f7 ff ff       	call   142c <RGB>
    1cbd:	83 c4 0c             	add    $0xc,%esp
    1cc0:	8b 1d 8c 2a 00 00    	mov    0x2a8c,%ebx
    1cc6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cc9:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ccc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ccf:	6b c0 32             	imul   $0x32,%eax,%eax
    1cd2:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cd5:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd8:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cdb:	83 ec 0c             	sub    $0xc,%esp
    1cde:	83 ec 04             	sub    $0x4,%esp
    1ce1:	89 e0                	mov    %esp,%eax
    1ce3:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1ce7:	66 89 30             	mov    %si,(%eax)
    1cea:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1cee:	88 50 02             	mov    %dl,0x2(%eax)
    1cf1:	6a 32                	push   $0x32
    1cf3:	6a 32                	push   $0x32
    1cf5:	6a 00                	push   $0x0
    1cf7:	6a 00                	push   $0x0
    1cf9:	53                   	push   %ebx
    1cfa:	51                   	push   %ecx
    1cfb:	ff 75 94             	pushl  -0x6c(%ebp)
    1cfe:	57                   	push   %edi
    1cff:	e8 84 f5 ff ff       	call   1288 <APDcCopy>
    1d04:	83 c4 30             	add    $0x30,%esp
                    break;
    1d07:	e9 73 01 00 00       	jmp    1e7f <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d0c:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1d0f:	6a 0c                	push   $0xc
    1d11:	6a 0c                	push   $0xc
    1d13:	6a 0c                	push   $0xc
    1d15:	50                   	push   %eax
    1d16:	e8 11 f7 ff ff       	call   142c <RGB>
    1d1b:	83 c4 0c             	add    $0xc,%esp
    1d1e:	8b 1d 70 2a 00 00    	mov    0x2a70,%ebx
    1d24:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d27:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d2a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d2d:	6b c0 32             	imul   $0x32,%eax,%eax
    1d30:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d33:	8b 45 08             	mov    0x8(%ebp),%eax
    1d36:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d39:	83 ec 0c             	sub    $0xc,%esp
    1d3c:	83 ec 04             	sub    $0x4,%esp
    1d3f:	89 e0                	mov    %esp,%eax
    1d41:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1d45:	66 89 30             	mov    %si,(%eax)
    1d48:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1d4c:	88 50 02             	mov    %dl,0x2(%eax)
    1d4f:	6a 32                	push   $0x32
    1d51:	6a 32                	push   $0x32
    1d53:	6a 00                	push   $0x0
    1d55:	6a 00                	push   $0x0
    1d57:	53                   	push   %ebx
    1d58:	51                   	push   %ecx
    1d59:	ff 75 94             	pushl  -0x6c(%ebp)
    1d5c:	57                   	push   %edi
    1d5d:	e8 26 f5 ff ff       	call   1288 <APDcCopy>
    1d62:	83 c4 30             	add    $0x30,%esp
                    break;
    1d65:	e9 15 01 00 00       	jmp    1e7f <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d6a:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1d6d:	6a 0c                	push   $0xc
    1d6f:	6a 0c                	push   $0xc
    1d71:	6a 0c                	push   $0xc
    1d73:	50                   	push   %eax
    1d74:	e8 b3 f6 ff ff       	call   142c <RGB>
    1d79:	83 c4 0c             	add    $0xc,%esp
    1d7c:	8b 1d a8 2a 00 00    	mov    0x2aa8,%ebx
    1d82:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d85:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d88:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d8b:	6b c0 32             	imul   $0x32,%eax,%eax
    1d8e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d91:	8b 45 08             	mov    0x8(%ebp),%eax
    1d94:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d97:	83 ec 0c             	sub    $0xc,%esp
    1d9a:	83 ec 04             	sub    $0x4,%esp
    1d9d:	89 e0                	mov    %esp,%eax
    1d9f:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1da3:	66 89 30             	mov    %si,(%eax)
    1da6:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1daa:	88 50 02             	mov    %dl,0x2(%eax)
    1dad:	6a 32                	push   $0x32
    1daf:	6a 32                	push   $0x32
    1db1:	6a 00                	push   $0x0
    1db3:	6a 00                	push   $0x0
    1db5:	53                   	push   %ebx
    1db6:	51                   	push   %ecx
    1db7:	ff 75 94             	pushl  -0x6c(%ebp)
    1dba:	57                   	push   %edi
    1dbb:	e8 c8 f4 ff ff       	call   1288 <APDcCopy>
    1dc0:	83 c4 30             	add    $0x30,%esp
                    break;
    1dc3:	e9 b7 00 00 00       	jmp    1e7f <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dc8:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1dcb:	6a 0c                	push   $0xc
    1dcd:	6a 0c                	push   $0xc
    1dcf:	6a 0c                	push   $0xc
    1dd1:	50                   	push   %eax
    1dd2:	e8 55 f6 ff ff       	call   142c <RGB>
    1dd7:	83 c4 0c             	add    $0xc,%esp
    1dda:	8b 1d 40 2a 00 00    	mov    0x2a40,%ebx
    1de0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1de3:	6b c8 32             	imul   $0x32,%eax,%ecx
    1de6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1de9:	6b c0 32             	imul   $0x32,%eax,%eax
    1dec:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1def:	8b 45 08             	mov    0x8(%ebp),%eax
    1df2:	8d 78 3c             	lea    0x3c(%eax),%edi
    1df5:	83 ec 0c             	sub    $0xc,%esp
    1df8:	83 ec 04             	sub    $0x4,%esp
    1dfb:	89 e0                	mov    %esp,%eax
    1dfd:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1e01:	66 89 30             	mov    %si,(%eax)
    1e04:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1e08:	88 50 02             	mov    %dl,0x2(%eax)
    1e0b:	6a 32                	push   $0x32
    1e0d:	6a 32                	push   $0x32
    1e0f:	6a 00                	push   $0x0
    1e11:	6a 00                	push   $0x0
    1e13:	53                   	push   %ebx
    1e14:	51                   	push   %ecx
    1e15:	ff 75 94             	pushl  -0x6c(%ebp)
    1e18:	57                   	push   %edi
    1e19:	e8 6a f4 ff ff       	call   1288 <APDcCopy>
    1e1e:	83 c4 30             	add    $0x30,%esp
                    break;
    1e21:	eb 5c                	jmp    1e7f <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e23:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1e26:	6a 0c                	push   $0xc
    1e28:	6a 0c                	push   $0xc
    1e2a:	6a 0c                	push   $0xc
    1e2c:	50                   	push   %eax
    1e2d:	e8 fa f5 ff ff       	call   142c <RGB>
    1e32:	83 c4 0c             	add    $0xc,%esp
    1e35:	8b 1d 5c 2a 00 00    	mov    0x2a5c,%ebx
    1e3b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e3e:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e41:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e44:	6b c0 32             	imul   $0x32,%eax,%eax
    1e47:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e4a:	8b 45 08             	mov    0x8(%ebp),%eax
    1e4d:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e50:	83 ec 0c             	sub    $0xc,%esp
    1e53:	83 ec 04             	sub    $0x4,%esp
    1e56:	89 e0                	mov    %esp,%eax
    1e58:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1e5c:	66 89 30             	mov    %si,(%eax)
    1e5f:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1e63:	88 50 02             	mov    %dl,0x2(%eax)
    1e66:	6a 32                	push   $0x32
    1e68:	6a 32                	push   $0x32
    1e6a:	6a 00                	push   $0x0
    1e6c:	6a 00                	push   $0x0
    1e6e:	53                   	push   %ebx
    1e6f:	51                   	push   %ecx
    1e70:	ff 75 94             	pushl  -0x6c(%ebp)
    1e73:	57                   	push   %edi
    1e74:	e8 0f f4 ff ff       	call   1288 <APDcCopy>
    1e79:	83 c4 30             	add    $0x30,%esp
                    break;
    1e7c:	eb 01                	jmp    1e7f <APGridPaint+0x639>
                default: break;
    1e7e:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1e7f:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1e83:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1e87:	0f 8e 7a fc ff ff    	jle    1b07 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e8d:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e91:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1e95:	0f 8e 60 fc ff ff    	jle    1afb <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1e9b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e9e:	68 cd 00 00 00       	push   $0xcd
    1ea3:	6a 74                	push   $0x74
    1ea5:	6a 18                	push   $0x18
    1ea7:	50                   	push   %eax
    1ea8:	e8 7f f5 ff ff       	call   142c <RGB>
    1ead:	83 c4 0c             	add    $0xc,%esp
    1eb0:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1eb4:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1eb8:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ebc:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1ebf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1ec6:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ec9:	68 cd 00 00 00       	push   $0xcd
    1ece:	6a 74                	push   $0x74
    1ed0:	6a 18                	push   $0x18
    1ed2:	50                   	push   %eax
    1ed3:	e8 54 f5 ff ff       	call   142c <RGB>
    1ed8:	83 c4 0c             	add    $0xc,%esp
    1edb:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1edf:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1ee3:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ee7:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1eea:	8b 45 08             	mov    0x8(%ebp),%eax
    1eed:	8d 50 58             	lea    0x58(%eax),%edx
    1ef0:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ef3:	ff 75 bc             	pushl  -0x44(%ebp)
    1ef6:	ff 75 b8             	pushl  -0x48(%ebp)
    1ef9:	52                   	push   %edx
    1efa:	50                   	push   %eax
    1efb:	e8 5c ed ff ff       	call   c5c <APSetPen>
    1f00:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1f03:	8b 45 08             	mov    0x8(%ebp),%eax
    1f06:	8d 58 58             	lea    0x58(%eax),%ebx
    1f09:	8d 55 98             	lea    -0x68(%ebp),%edx
    1f0c:	83 ec 04             	sub    $0x4,%esp
    1f0f:	83 ec 04             	sub    $0x4,%esp
    1f12:	89 e0                	mov    %esp,%eax
    1f14:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1f18:	66 89 08             	mov    %cx,(%eax)
    1f1b:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1f1f:	88 48 02             	mov    %cl,0x2(%eax)
    1f22:	53                   	push   %ebx
    1f23:	52                   	push   %edx
    1f24:	e8 6c ed ff ff       	call   c95 <APSetBrush>
    1f29:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1f2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f2f:	83 c0 58             	add    $0x58,%eax
    1f32:	83 ec 0c             	sub    $0xc,%esp
    1f35:	6a 32                	push   $0x32
    1f37:	68 20 03 00 00       	push   $0x320
    1f3c:	6a 00                	push   $0x0
    1f3e:	6a 00                	push   $0x0
    1f40:	50                   	push   %eax
    1f41:	e8 37 f1 ff ff       	call   107d <APDrawRect>
    1f46:	83 c4 20             	add    $0x20,%esp
}
    1f49:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1f4c:	5b                   	pop    %ebx
    1f4d:	5e                   	pop    %esi
    1f4e:	5f                   	pop    %edi
    1f4f:	5d                   	pop    %ebp
    1f50:	c3                   	ret    

00001f51 <random>:
//

#include "APLib.h"

int random(int seed)
{
    1f51:	55                   	push   %ebp
    1f52:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1f54:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1f58:	7e 08                	jle    1f62 <random+0x11>
{
rand_num = seed;
    1f5a:	8b 45 08             	mov    0x8(%ebp),%eax
    1f5d:	a3 18 2a 00 00       	mov    %eax,0x2a18
}
rand_num *= 3;
    1f62:	8b 15 18 2a 00 00    	mov    0x2a18,%edx
    1f68:	89 d0                	mov    %edx,%eax
    1f6a:	01 c0                	add    %eax,%eax
    1f6c:	01 d0                	add    %edx,%eax
    1f6e:	a3 18 2a 00 00       	mov    %eax,0x2a18
if (rand_num < 0)
    1f73:	a1 18 2a 00 00       	mov    0x2a18,%eax
    1f78:	85 c0                	test   %eax,%eax
    1f7a:	79 0c                	jns    1f88 <random+0x37>
{
rand_num *= (-1);
    1f7c:	a1 18 2a 00 00       	mov    0x2a18,%eax
    1f81:	f7 d8                	neg    %eax
    1f83:	a3 18 2a 00 00       	mov    %eax,0x2a18
}
return rand_num % 997;
    1f88:	8b 0d 18 2a 00 00    	mov    0x2a18,%ecx
    1f8e:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1f93:	89 c8                	mov    %ecx,%eax
    1f95:	f7 ea                	imul   %edx
    1f97:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1f9a:	c1 f8 09             	sar    $0x9,%eax
    1f9d:	89 c2                	mov    %eax,%edx
    1f9f:	89 c8                	mov    %ecx,%eax
    1fa1:	c1 f8 1f             	sar    $0x1f,%eax
    1fa4:	29 c2                	sub    %eax,%edx
    1fa6:	89 d0                	mov    %edx,%eax
    1fa8:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1fae:	29 c1                	sub    %eax,%ecx
    1fb0:	89 c8                	mov    %ecx,%eax
}
    1fb2:	5d                   	pop    %ebp
    1fb3:	c3                   	ret    

00001fb4 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1fb4:	55                   	push   %ebp
    1fb5:	89 e5                	mov    %esp,%ebp
    1fb7:	53                   	push   %ebx
    1fb8:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1fbb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1fc2:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1fc6:	74 17                	je     1fdf <sprintint+0x2b>
    1fc8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1fcc:	79 11                	jns    1fdf <sprintint+0x2b>
        neg = 1;
    1fce:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1fd5:	8b 45 10             	mov    0x10(%ebp),%eax
    1fd8:	f7 d8                	neg    %eax
    1fda:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1fdd:	eb 06                	jmp    1fe5 <sprintint+0x31>
    } else {
        x = xx;
    1fdf:	8b 45 10             	mov    0x10(%ebp),%eax
    1fe2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1fe5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1fec:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1fef:	8d 41 01             	lea    0x1(%ecx),%eax
    1ff2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1ff5:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1ff8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ffb:	ba 00 00 00 00       	mov    $0x0,%edx
    2000:	f7 f3                	div    %ebx
    2002:	89 d0                	mov    %edx,%eax
    2004:	0f b6 80 1c 2a 00 00 	movzbl 0x2a1c(%eax),%eax
    200b:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    200f:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2012:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2015:	ba 00 00 00 00       	mov    $0x0,%edx
    201a:	f7 f3                	div    %ebx
    201c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    201f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2023:	75 c7                	jne    1fec <sprintint+0x38>
    if(neg)
    2025:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2029:	74 0e                	je     2039 <sprintint+0x85>
        buf[i++] = '-';
    202b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    202e:	8d 50 01             	lea    0x1(%eax),%edx
    2031:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2034:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2039:	8b 45 f8             	mov    -0x8(%ebp),%eax
    203c:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    203f:	eb 1b                	jmp    205c <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2041:	8b 45 0c             	mov    0xc(%ebp),%eax
    2044:	8b 00                	mov    (%eax),%eax
    2046:	8d 48 01             	lea    0x1(%eax),%ecx
    2049:	8b 55 0c             	mov    0xc(%ebp),%edx
    204c:	89 0a                	mov    %ecx,(%edx)
    204e:	89 c2                	mov    %eax,%edx
    2050:	8b 45 08             	mov    0x8(%ebp),%eax
    2053:	01 d0                	add    %edx,%eax
    2055:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2058:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    205c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2060:	7f df                	jg     2041 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2062:	eb 21                	jmp    2085 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2064:	8b 45 0c             	mov    0xc(%ebp),%eax
    2067:	8b 00                	mov    (%eax),%eax
    2069:	8d 48 01             	lea    0x1(%eax),%ecx
    206c:	8b 55 0c             	mov    0xc(%ebp),%edx
    206f:	89 0a                	mov    %ecx,(%edx)
    2071:	89 c2                	mov    %eax,%edx
    2073:	8b 45 08             	mov    0x8(%ebp),%eax
    2076:	01 c2                	add    %eax,%edx
    2078:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    207b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    207e:	01 c8                	add    %ecx,%eax
    2080:	0f b6 00             	movzbl (%eax),%eax
    2083:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2085:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2089:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    208d:	79 d5                	jns    2064 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    208f:	90                   	nop
    2090:	83 c4 20             	add    $0x20,%esp
    2093:	5b                   	pop    %ebx
    2094:	5d                   	pop    %ebp
    2095:	c3                   	ret    

00002096 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2096:	55                   	push   %ebp
    2097:	89 e5                	mov    %esp,%ebp
    2099:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    209c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    20a3:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    20aa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    20b1:	8d 45 0c             	lea    0xc(%ebp),%eax
    20b4:	83 c0 04             	add    $0x4,%eax
    20b7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    20ba:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    20c1:	e9 d9 01 00 00       	jmp    229f <sprintf+0x209>
        c = fmt[i] & 0xff;
    20c6:	8b 55 0c             	mov    0xc(%ebp),%edx
    20c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    20cc:	01 d0                	add    %edx,%eax
    20ce:	0f b6 00             	movzbl (%eax),%eax
    20d1:	0f be c0             	movsbl %al,%eax
    20d4:	25 ff 00 00 00       	and    $0xff,%eax
    20d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    20dc:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    20e0:	75 2c                	jne    210e <sprintf+0x78>
            if(c == '%'){
    20e2:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    20e6:	75 0c                	jne    20f4 <sprintf+0x5e>
                state = '%';
    20e8:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    20ef:	e9 a7 01 00 00       	jmp    229b <sprintf+0x205>
            } else {
                dst[j++] = c;
    20f4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20f7:	8d 50 01             	lea    0x1(%eax),%edx
    20fa:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20fd:	89 c2                	mov    %eax,%edx
    20ff:	8b 45 08             	mov    0x8(%ebp),%eax
    2102:	01 d0                	add    %edx,%eax
    2104:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2107:	88 10                	mov    %dl,(%eax)
    2109:	e9 8d 01 00 00       	jmp    229b <sprintf+0x205>
            }
        } else if(state == '%'){
    210e:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2112:	0f 85 83 01 00 00    	jne    229b <sprintf+0x205>
            if(c == 'd'){
    2118:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    211c:	75 4c                	jne    216a <sprintf+0xd4>
                buf[bi] = '\0';
    211e:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2121:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2124:	01 d0                	add    %edx,%eax
    2126:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2129:	83 ec 0c             	sub    $0xc,%esp
    212c:	8d 45 ce             	lea    -0x32(%ebp),%eax
    212f:	50                   	push   %eax
    2130:	e8 91 e1 ff ff       	call   2c6 <atoi>
    2135:	83 c4 10             	add    $0x10,%esp
    2138:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    213b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2142:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2145:	8b 00                	mov    (%eax),%eax
    2147:	83 ec 08             	sub    $0x8,%esp
    214a:	ff 75 d8             	pushl  -0x28(%ebp)
    214d:	6a 01                	push   $0x1
    214f:	6a 0a                	push   $0xa
    2151:	50                   	push   %eax
    2152:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2155:	50                   	push   %eax
    2156:	ff 75 08             	pushl  0x8(%ebp)
    2159:	e8 56 fe ff ff       	call   1fb4 <sprintint>
    215e:	83 c4 20             	add    $0x20,%esp
                ap++;
    2161:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2165:	e9 2a 01 00 00       	jmp    2294 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    216a:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    216e:	74 06                	je     2176 <sprintf+0xe0>
    2170:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2174:	75 4c                	jne    21c2 <sprintf+0x12c>
                buf[bi] = '\0';
    2176:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2179:	8b 45 f0             	mov    -0x10(%ebp),%eax
    217c:	01 d0                	add    %edx,%eax
    217e:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2181:	83 ec 0c             	sub    $0xc,%esp
    2184:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2187:	50                   	push   %eax
    2188:	e8 39 e1 ff ff       	call   2c6 <atoi>
    218d:	83 c4 10             	add    $0x10,%esp
    2190:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2193:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    219a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    219d:	8b 00                	mov    (%eax),%eax
    219f:	83 ec 08             	sub    $0x8,%esp
    21a2:	ff 75 dc             	pushl  -0x24(%ebp)
    21a5:	6a 00                	push   $0x0
    21a7:	6a 10                	push   $0x10
    21a9:	50                   	push   %eax
    21aa:	8d 45 c8             	lea    -0x38(%ebp),%eax
    21ad:	50                   	push   %eax
    21ae:	ff 75 08             	pushl  0x8(%ebp)
    21b1:	e8 fe fd ff ff       	call   1fb4 <sprintint>
    21b6:	83 c4 20             	add    $0x20,%esp
                ap++;
    21b9:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    21bd:	e9 d2 00 00 00       	jmp    2294 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    21c2:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    21c6:	75 46                	jne    220e <sprintf+0x178>
                s = (char*)*ap;
    21c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21cb:	8b 00                	mov    (%eax),%eax
    21cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    21d0:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    21d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    21d8:	75 25                	jne    21ff <sprintf+0x169>
                    s = "(null)";
    21da:	c7 45 f4 a0 24 00 00 	movl   $0x24a0,-0xc(%ebp)
                while(*s != 0){
    21e1:	eb 1c                	jmp    21ff <sprintf+0x169>
                    dst[j++] = *s;
    21e3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21e6:	8d 50 01             	lea    0x1(%eax),%edx
    21e9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21ec:	89 c2                	mov    %eax,%edx
    21ee:	8b 45 08             	mov    0x8(%ebp),%eax
    21f1:	01 c2                	add    %eax,%edx
    21f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21f6:	0f b6 00             	movzbl (%eax),%eax
    21f9:	88 02                	mov    %al,(%edx)
                    s++;
    21fb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    21ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2202:	0f b6 00             	movzbl (%eax),%eax
    2205:	84 c0                	test   %al,%al
    2207:	75 da                	jne    21e3 <sprintf+0x14d>
    2209:	e9 86 00 00 00       	jmp    2294 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    220e:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2212:	75 1d                	jne    2231 <sprintf+0x19b>
                dst[j++] = *ap;
    2214:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2217:	8d 50 01             	lea    0x1(%eax),%edx
    221a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    221d:	89 c2                	mov    %eax,%edx
    221f:	8b 45 08             	mov    0x8(%ebp),%eax
    2222:	01 c2                	add    %eax,%edx
    2224:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2227:	8b 00                	mov    (%eax),%eax
    2229:	88 02                	mov    %al,(%edx)
                ap++;
    222b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    222f:	eb 63                	jmp    2294 <sprintf+0x1fe>
            } else if(c == '%'){
    2231:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2235:	75 17                	jne    224e <sprintf+0x1b8>
                dst[j++] = c;
    2237:	8b 45 c8             	mov    -0x38(%ebp),%eax
    223a:	8d 50 01             	lea    0x1(%eax),%edx
    223d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2240:	89 c2                	mov    %eax,%edx
    2242:	8b 45 08             	mov    0x8(%ebp),%eax
    2245:	01 d0                	add    %edx,%eax
    2247:	8b 55 e0             	mov    -0x20(%ebp),%edx
    224a:	88 10                	mov    %dl,(%eax)
    224c:	eb 46                	jmp    2294 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    224e:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2252:	7e 18                	jle    226c <sprintf+0x1d6>
    2254:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2258:	7f 12                	jg     226c <sprintf+0x1d6>
            {
                buf[bi++] = c;
    225a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    225d:	8d 50 01             	lea    0x1(%eax),%edx
    2260:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2263:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2266:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    226a:	eb 2f                	jmp    229b <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    226c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    226f:	8d 50 01             	lea    0x1(%eax),%edx
    2272:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2275:	89 c2                	mov    %eax,%edx
    2277:	8b 45 08             	mov    0x8(%ebp),%eax
    227a:	01 d0                	add    %edx,%eax
    227c:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    227f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2282:	8d 50 01             	lea    0x1(%eax),%edx
    2285:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2288:	89 c2                	mov    %eax,%edx
    228a:	8b 45 08             	mov    0x8(%ebp),%eax
    228d:	01 d0                	add    %edx,%eax
    228f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2292:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2294:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    229b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    229f:	8b 55 0c             	mov    0xc(%ebp),%edx
    22a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    22a5:	01 d0                	add    %edx,%eax
    22a7:	0f b6 00             	movzbl (%eax),%eax
    22aa:	84 c0                	test   %al,%al
    22ac:	0f 85 14 fe ff ff    	jne    20c6 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    22b2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22b5:	8d 50 01             	lea    0x1(%eax),%edx
    22b8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22bb:	89 c2                	mov    %eax,%edx
    22bd:	8b 45 08             	mov    0x8(%ebp),%eax
    22c0:	01 d0                	add    %edx,%eax
    22c2:	c6 00 00             	movb   $0x0,(%eax)
}
    22c5:	90                   	nop
    22c6:	c9                   	leave  
    22c7:	c3                   	ret    
