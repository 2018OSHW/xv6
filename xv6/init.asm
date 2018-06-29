
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
      16:	68 a3 25 00 00       	push   $0x25a3
      1b:	e8 78 03 00 00       	call   398 <open>
      20:	83 c4 10             	add    $0x10,%esp
      23:	85 c0                	test   %eax,%eax
      25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
      27:	83 ec 04             	sub    $0x4,%esp
      2a:	6a 01                	push   $0x1
      2c:	6a 01                	push   $0x1
      2e:	68 a3 25 00 00       	push   $0x25a3
      33:	e8 68 03 00 00       	call   3a0 <mknod>
      38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
      3b:	83 ec 08             	sub    $0x8,%esp
      3e:	6a 02                	push   $0x2
      40:	68 a3 25 00 00       	push   $0x25a3
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
      6a:	68 ab 25 00 00       	push   $0x25ab
      6f:	6a 01                	push   $0x1
      71:	e8 a1 04 00 00       	call   517 <printf>
      76:	83 c4 10             	add    $0x10,%esp
    pid = fork();
      79:	e8 d2 02 00 00       	call   350 <fork>
      7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
      81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      85:	79 17                	jns    9e <main+0x9e>
      printf(1, "init: fork failed\n");
      87:	83 ec 08             	sub    $0x8,%esp
      8a:	68 c5 25 00 00       	push   $0x25c5
      8f:	6a 01                	push   $0x1
      91:	e8 81 04 00 00       	call   517 <printf>
      96:	83 c4 10             	add    $0x10,%esp
      exit();
      99:	e8 ba 02 00 00       	call   358 <exit>
    }
    if(pid == 0){
      9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      a2:	75 3e                	jne    e2 <main+0xe2>
     // exec("sh", argv);
      //exec("APDesktop", argv);
      //exec("APSnack",argv);
      exec("APMagicTower",argv);
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	68 40 2d 00 00       	push   $0x2d40
      ac:	68 d8 25 00 00       	push   $0x25d8
      b1:	e8 da 02 00 00       	call   390 <exec>
      b6:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec desktop failed\n");
      b9:	83 ec 08             	sub    $0x8,%esp
      bc:	68 e5 25 00 00       	push   $0x25e5
      c1:	6a 01                	push   $0x1
      c3:	e8 4f 04 00 00       	call   517 <printf>
      c8:	83 c4 10             	add    $0x10,%esp
      exit();
      cb:	e8 88 02 00 00       	call   358 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
      d0:	83 ec 08             	sub    $0x8,%esp
      d3:	68 00 26 00 00       	push   $0x2600
      d8:	6a 01                	push   $0x1
      da:	e8 38 04 00 00       	call   517 <printf>
      df:	83 c4 10             	add    $0x10,%esp
      //exec("APSnack",argv);
      exec("APMagicTower",argv);
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

00000430 <getCurrentTime>:
SYSCALL(getCurrentTime)
     430:	b8 1d 00 00 00       	mov    $0x1d,%eax
     435:	cd 40                	int    $0x40
     437:	c3                   	ret    

00000438 <removeWindow>:
SYSCALL(removeWindow)
     438:	b8 1e 00 00 00       	mov    $0x1e,%eax
     43d:	cd 40                	int    $0x40
     43f:	c3                   	ret    

00000440 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	83 ec 18             	sub    $0x18,%esp
     446:	8b 45 0c             	mov    0xc(%ebp),%eax
     449:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     44c:	83 ec 04             	sub    $0x4,%esp
     44f:	6a 01                	push   $0x1
     451:	8d 45 f4             	lea    -0xc(%ebp),%eax
     454:	50                   	push   %eax
     455:	ff 75 08             	pushl  0x8(%ebp)
     458:	e8 1b ff ff ff       	call   378 <write>
     45d:	83 c4 10             	add    $0x10,%esp
}
     460:	90                   	nop
     461:	c9                   	leave  
     462:	c3                   	ret    

00000463 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     463:	55                   	push   %ebp
     464:	89 e5                	mov    %esp,%ebp
     466:	53                   	push   %ebx
     467:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     46a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     471:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     475:	74 17                	je     48e <printint+0x2b>
     477:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     47b:	79 11                	jns    48e <printint+0x2b>
    neg = 1;
     47d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     484:	8b 45 0c             	mov    0xc(%ebp),%eax
     487:	f7 d8                	neg    %eax
     489:	89 45 ec             	mov    %eax,-0x14(%ebp)
     48c:	eb 06                	jmp    494 <printint+0x31>
  } else {
    x = xx;
     48e:	8b 45 0c             	mov    0xc(%ebp),%eax
     491:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     494:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     49b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     49e:	8d 41 01             	lea    0x1(%ecx),%eax
     4a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
     4a4:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4aa:	ba 00 00 00 00       	mov    $0x0,%edx
     4af:	f7 f3                	div    %ebx
     4b1:	89 d0                	mov    %edx,%eax
     4b3:	0f b6 80 48 2d 00 00 	movzbl 0x2d48(%eax),%eax
     4ba:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     4be:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4c4:	ba 00 00 00 00       	mov    $0x0,%edx
     4c9:	f7 f3                	div    %ebx
     4cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4ce:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4d2:	75 c7                	jne    49b <printint+0x38>
  if(neg)
     4d4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4d8:	74 2d                	je     507 <printint+0xa4>
    buf[i++] = '-';
     4da:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4dd:	8d 50 01             	lea    0x1(%eax),%edx
     4e0:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4e3:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     4e8:	eb 1d                	jmp    507 <printint+0xa4>
    putc(fd, buf[i]);
     4ea:	8d 55 dc             	lea    -0x24(%ebp),%edx
     4ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f0:	01 d0                	add    %edx,%eax
     4f2:	0f b6 00             	movzbl (%eax),%eax
     4f5:	0f be c0             	movsbl %al,%eax
     4f8:	83 ec 08             	sub    $0x8,%esp
     4fb:	50                   	push   %eax
     4fc:	ff 75 08             	pushl  0x8(%ebp)
     4ff:	e8 3c ff ff ff       	call   440 <putc>
     504:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     507:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     50b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     50f:	79 d9                	jns    4ea <printint+0x87>
    putc(fd, buf[i]);
}
     511:	90                   	nop
     512:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     515:	c9                   	leave  
     516:	c3                   	ret    

00000517 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     517:	55                   	push   %ebp
     518:	89 e5                	mov    %esp,%ebp
     51a:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     51d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     524:	8d 45 0c             	lea    0xc(%ebp),%eax
     527:	83 c0 04             	add    $0x4,%eax
     52a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     52d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     534:	e9 59 01 00 00       	jmp    692 <printf+0x17b>
    c = fmt[i] & 0xff;
     539:	8b 55 0c             	mov    0xc(%ebp),%edx
     53c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     53f:	01 d0                	add    %edx,%eax
     541:	0f b6 00             	movzbl (%eax),%eax
     544:	0f be c0             	movsbl %al,%eax
     547:	25 ff 00 00 00       	and    $0xff,%eax
     54c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     54f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     553:	75 2c                	jne    581 <printf+0x6a>
      if(c == '%'){
     555:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     559:	75 0c                	jne    567 <printf+0x50>
        state = '%';
     55b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     562:	e9 27 01 00 00       	jmp    68e <printf+0x177>
      } else {
        putc(fd, c);
     567:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     56a:	0f be c0             	movsbl %al,%eax
     56d:	83 ec 08             	sub    $0x8,%esp
     570:	50                   	push   %eax
     571:	ff 75 08             	pushl  0x8(%ebp)
     574:	e8 c7 fe ff ff       	call   440 <putc>
     579:	83 c4 10             	add    $0x10,%esp
     57c:	e9 0d 01 00 00       	jmp    68e <printf+0x177>
      }
    } else if(state == '%'){
     581:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     585:	0f 85 03 01 00 00    	jne    68e <printf+0x177>
      if(c == 'd'){
     58b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     58f:	75 1e                	jne    5af <printf+0x98>
        printint(fd, *ap, 10, 1);
     591:	8b 45 e8             	mov    -0x18(%ebp),%eax
     594:	8b 00                	mov    (%eax),%eax
     596:	6a 01                	push   $0x1
     598:	6a 0a                	push   $0xa
     59a:	50                   	push   %eax
     59b:	ff 75 08             	pushl  0x8(%ebp)
     59e:	e8 c0 fe ff ff       	call   463 <printint>
     5a3:	83 c4 10             	add    $0x10,%esp
        ap++;
     5a6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5aa:	e9 d8 00 00 00       	jmp    687 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     5af:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5b3:	74 06                	je     5bb <printf+0xa4>
     5b5:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5b9:	75 1e                	jne    5d9 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     5bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5be:	8b 00                	mov    (%eax),%eax
     5c0:	6a 00                	push   $0x0
     5c2:	6a 10                	push   $0x10
     5c4:	50                   	push   %eax
     5c5:	ff 75 08             	pushl  0x8(%ebp)
     5c8:	e8 96 fe ff ff       	call   463 <printint>
     5cd:	83 c4 10             	add    $0x10,%esp
        ap++;
     5d0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5d4:	e9 ae 00 00 00       	jmp    687 <printf+0x170>
      } else if(c == 's'){
     5d9:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     5dd:	75 43                	jne    622 <printf+0x10b>
        s = (char*)*ap;
     5df:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5e2:	8b 00                	mov    (%eax),%eax
     5e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     5e7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     5eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5ef:	75 25                	jne    616 <printf+0xff>
          s = "(null)";
     5f1:	c7 45 f4 09 26 00 00 	movl   $0x2609,-0xc(%ebp)
        while(*s != 0){
     5f8:	eb 1c                	jmp    616 <printf+0xff>
          putc(fd, *s);
     5fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5fd:	0f b6 00             	movzbl (%eax),%eax
     600:	0f be c0             	movsbl %al,%eax
     603:	83 ec 08             	sub    $0x8,%esp
     606:	50                   	push   %eax
     607:	ff 75 08             	pushl  0x8(%ebp)
     60a:	e8 31 fe ff ff       	call   440 <putc>
     60f:	83 c4 10             	add    $0x10,%esp
          s++;
     612:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     616:	8b 45 f4             	mov    -0xc(%ebp),%eax
     619:	0f b6 00             	movzbl (%eax),%eax
     61c:	84 c0                	test   %al,%al
     61e:	75 da                	jne    5fa <printf+0xe3>
     620:	eb 65                	jmp    687 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     622:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     626:	75 1d                	jne    645 <printf+0x12e>
        putc(fd, *ap);
     628:	8b 45 e8             	mov    -0x18(%ebp),%eax
     62b:	8b 00                	mov    (%eax),%eax
     62d:	0f be c0             	movsbl %al,%eax
     630:	83 ec 08             	sub    $0x8,%esp
     633:	50                   	push   %eax
     634:	ff 75 08             	pushl  0x8(%ebp)
     637:	e8 04 fe ff ff       	call   440 <putc>
     63c:	83 c4 10             	add    $0x10,%esp
        ap++;
     63f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     643:	eb 42                	jmp    687 <printf+0x170>
      } else if(c == '%'){
     645:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     649:	75 17                	jne    662 <printf+0x14b>
        putc(fd, c);
     64b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     64e:	0f be c0             	movsbl %al,%eax
     651:	83 ec 08             	sub    $0x8,%esp
     654:	50                   	push   %eax
     655:	ff 75 08             	pushl  0x8(%ebp)
     658:	e8 e3 fd ff ff       	call   440 <putc>
     65d:	83 c4 10             	add    $0x10,%esp
     660:	eb 25                	jmp    687 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     662:	83 ec 08             	sub    $0x8,%esp
     665:	6a 25                	push   $0x25
     667:	ff 75 08             	pushl  0x8(%ebp)
     66a:	e8 d1 fd ff ff       	call   440 <putc>
     66f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     672:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     675:	0f be c0             	movsbl %al,%eax
     678:	83 ec 08             	sub    $0x8,%esp
     67b:	50                   	push   %eax
     67c:	ff 75 08             	pushl  0x8(%ebp)
     67f:	e8 bc fd ff ff       	call   440 <putc>
     684:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     687:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     68e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     692:	8b 55 0c             	mov    0xc(%ebp),%edx
     695:	8b 45 f0             	mov    -0x10(%ebp),%eax
     698:	01 d0                	add    %edx,%eax
     69a:	0f b6 00             	movzbl (%eax),%eax
     69d:	84 c0                	test   %al,%al
     69f:	0f 85 94 fe ff ff    	jne    539 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     6a5:	90                   	nop
     6a6:	c9                   	leave  
     6a7:	c3                   	ret    

000006a8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     6a8:	55                   	push   %ebp
     6a9:	89 e5                	mov    %esp,%ebp
     6ab:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     6ae:	8b 45 08             	mov    0x8(%ebp),%eax
     6b1:	83 e8 08             	sub    $0x8,%eax
     6b4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6b7:	a1 a0 69 00 00       	mov    0x69a0,%eax
     6bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6bf:	eb 24                	jmp    6e5 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c4:	8b 00                	mov    (%eax),%eax
     6c6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6c9:	77 12                	ja     6dd <free+0x35>
     6cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ce:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6d1:	77 24                	ja     6f7 <free+0x4f>
     6d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d6:	8b 00                	mov    (%eax),%eax
     6d8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6db:	77 1a                	ja     6f7 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e0:	8b 00                	mov    (%eax),%eax
     6e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6e8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6eb:	76 d4                	jbe    6c1 <free+0x19>
     6ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f0:	8b 00                	mov    (%eax),%eax
     6f2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6f5:	76 ca                	jbe    6c1 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     6f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6fa:	8b 40 04             	mov    0x4(%eax),%eax
     6fd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     704:	8b 45 f8             	mov    -0x8(%ebp),%eax
     707:	01 c2                	add    %eax,%edx
     709:	8b 45 fc             	mov    -0x4(%ebp),%eax
     70c:	8b 00                	mov    (%eax),%eax
     70e:	39 c2                	cmp    %eax,%edx
     710:	75 24                	jne    736 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     712:	8b 45 f8             	mov    -0x8(%ebp),%eax
     715:	8b 50 04             	mov    0x4(%eax),%edx
     718:	8b 45 fc             	mov    -0x4(%ebp),%eax
     71b:	8b 00                	mov    (%eax),%eax
     71d:	8b 40 04             	mov    0x4(%eax),%eax
     720:	01 c2                	add    %eax,%edx
     722:	8b 45 f8             	mov    -0x8(%ebp),%eax
     725:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     728:	8b 45 fc             	mov    -0x4(%ebp),%eax
     72b:	8b 00                	mov    (%eax),%eax
     72d:	8b 10                	mov    (%eax),%edx
     72f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     732:	89 10                	mov    %edx,(%eax)
     734:	eb 0a                	jmp    740 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     736:	8b 45 fc             	mov    -0x4(%ebp),%eax
     739:	8b 10                	mov    (%eax),%edx
     73b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     73e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     740:	8b 45 fc             	mov    -0x4(%ebp),%eax
     743:	8b 40 04             	mov    0x4(%eax),%eax
     746:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     74d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     750:	01 d0                	add    %edx,%eax
     752:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     755:	75 20                	jne    777 <free+0xcf>
    p->s.size += bp->s.size;
     757:	8b 45 fc             	mov    -0x4(%ebp),%eax
     75a:	8b 50 04             	mov    0x4(%eax),%edx
     75d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     760:	8b 40 04             	mov    0x4(%eax),%eax
     763:	01 c2                	add    %eax,%edx
     765:	8b 45 fc             	mov    -0x4(%ebp),%eax
     768:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     76b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     76e:	8b 10                	mov    (%eax),%edx
     770:	8b 45 fc             	mov    -0x4(%ebp),%eax
     773:	89 10                	mov    %edx,(%eax)
     775:	eb 08                	jmp    77f <free+0xd7>
  } else
    p->s.ptr = bp;
     777:	8b 45 fc             	mov    -0x4(%ebp),%eax
     77a:	8b 55 f8             	mov    -0x8(%ebp),%edx
     77d:	89 10                	mov    %edx,(%eax)
  freep = p;
     77f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     782:	a3 a0 69 00 00       	mov    %eax,0x69a0
}
     787:	90                   	nop
     788:	c9                   	leave  
     789:	c3                   	ret    

0000078a <morecore>:

static Header*
morecore(uint nu)
{
     78a:	55                   	push   %ebp
     78b:	89 e5                	mov    %esp,%ebp
     78d:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     790:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     797:	77 07                	ja     7a0 <morecore+0x16>
    nu = 4096;
     799:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     7a0:	8b 45 08             	mov    0x8(%ebp),%eax
     7a3:	c1 e0 03             	shl    $0x3,%eax
     7a6:	83 ec 0c             	sub    $0xc,%esp
     7a9:	50                   	push   %eax
     7aa:	e8 31 fc ff ff       	call   3e0 <sbrk>
     7af:	83 c4 10             	add    $0x10,%esp
     7b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7b5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7b9:	75 07                	jne    7c2 <morecore+0x38>
    return 0;
     7bb:	b8 00 00 00 00       	mov    $0x0,%eax
     7c0:	eb 26                	jmp    7e8 <morecore+0x5e>
  hp = (Header*)p;
     7c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7cb:	8b 55 08             	mov    0x8(%ebp),%edx
     7ce:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     7d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d4:	83 c0 08             	add    $0x8,%eax
     7d7:	83 ec 0c             	sub    $0xc,%esp
     7da:	50                   	push   %eax
     7db:	e8 c8 fe ff ff       	call   6a8 <free>
     7e0:	83 c4 10             	add    $0x10,%esp
  return freep;
     7e3:	a1 a0 69 00 00       	mov    0x69a0,%eax
}
     7e8:	c9                   	leave  
     7e9:	c3                   	ret    

000007ea <malloc>:

void*
malloc(uint nbytes)
{
     7ea:	55                   	push   %ebp
     7eb:	89 e5                	mov    %esp,%ebp
     7ed:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     7f0:	8b 45 08             	mov    0x8(%ebp),%eax
     7f3:	83 c0 07             	add    $0x7,%eax
     7f6:	c1 e8 03             	shr    $0x3,%eax
     7f9:	83 c0 01             	add    $0x1,%eax
     7fc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     7ff:	a1 a0 69 00 00       	mov    0x69a0,%eax
     804:	89 45 f0             	mov    %eax,-0x10(%ebp)
     807:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     80b:	75 23                	jne    830 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     80d:	c7 45 f0 98 69 00 00 	movl   $0x6998,-0x10(%ebp)
     814:	8b 45 f0             	mov    -0x10(%ebp),%eax
     817:	a3 a0 69 00 00       	mov    %eax,0x69a0
     81c:	a1 a0 69 00 00       	mov    0x69a0,%eax
     821:	a3 98 69 00 00       	mov    %eax,0x6998
    base.s.size = 0;
     826:	c7 05 9c 69 00 00 00 	movl   $0x0,0x699c
     82d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     830:	8b 45 f0             	mov    -0x10(%ebp),%eax
     833:	8b 00                	mov    (%eax),%eax
     835:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     838:	8b 45 f4             	mov    -0xc(%ebp),%eax
     83b:	8b 40 04             	mov    0x4(%eax),%eax
     83e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     841:	72 4d                	jb     890 <malloc+0xa6>
      if(p->s.size == nunits)
     843:	8b 45 f4             	mov    -0xc(%ebp),%eax
     846:	8b 40 04             	mov    0x4(%eax),%eax
     849:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     84c:	75 0c                	jne    85a <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     84e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     851:	8b 10                	mov    (%eax),%edx
     853:	8b 45 f0             	mov    -0x10(%ebp),%eax
     856:	89 10                	mov    %edx,(%eax)
     858:	eb 26                	jmp    880 <malloc+0x96>
      else {
        p->s.size -= nunits;
     85a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85d:	8b 40 04             	mov    0x4(%eax),%eax
     860:	2b 45 ec             	sub    -0x14(%ebp),%eax
     863:	89 c2                	mov    %eax,%edx
     865:	8b 45 f4             	mov    -0xc(%ebp),%eax
     868:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     86b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     86e:	8b 40 04             	mov    0x4(%eax),%eax
     871:	c1 e0 03             	shl    $0x3,%eax
     874:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     877:	8b 45 f4             	mov    -0xc(%ebp),%eax
     87a:	8b 55 ec             	mov    -0x14(%ebp),%edx
     87d:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     880:	8b 45 f0             	mov    -0x10(%ebp),%eax
     883:	a3 a0 69 00 00       	mov    %eax,0x69a0
      return (void*)(p + 1);
     888:	8b 45 f4             	mov    -0xc(%ebp),%eax
     88b:	83 c0 08             	add    $0x8,%eax
     88e:	eb 3b                	jmp    8cb <malloc+0xe1>
    }
    if(p == freep)
     890:	a1 a0 69 00 00       	mov    0x69a0,%eax
     895:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     898:	75 1e                	jne    8b8 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     89a:	83 ec 0c             	sub    $0xc,%esp
     89d:	ff 75 ec             	pushl  -0x14(%ebp)
     8a0:	e8 e5 fe ff ff       	call   78a <morecore>
     8a5:	83 c4 10             	add    $0x10,%esp
     8a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8af:	75 07                	jne    8b8 <malloc+0xce>
        return 0;
     8b1:	b8 00 00 00 00       	mov    $0x0,%eax
     8b6:	eb 13                	jmp    8cb <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8be:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8c1:	8b 00                	mov    (%eax),%eax
     8c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     8c6:	e9 6d ff ff ff       	jmp    838 <malloc+0x4e>
}
     8cb:	c9                   	leave  
     8cc:	c3                   	ret    

000008cd <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     8cd:	55                   	push   %ebp
     8ce:	89 e5                	mov    %esp,%ebp
     8d0:	83 ec 1c             	sub    $0x1c,%esp
     8d3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     8d6:	8b 55 10             	mov    0x10(%ebp),%edx
     8d9:	8b 45 14             	mov    0x14(%ebp),%eax
     8dc:	88 4d ec             	mov    %cl,-0x14(%ebp)
     8df:	88 55 e8             	mov    %dl,-0x18(%ebp)
     8e2:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     8e5:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     8e9:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     8ec:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     8f0:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     8f3:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     8f7:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     8fa:	8b 45 08             	mov    0x8(%ebp),%eax
     8fd:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     901:	66 89 10             	mov    %dx,(%eax)
     904:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     908:	88 50 02             	mov    %dl,0x2(%eax)
}
     90b:	8b 45 08             	mov    0x8(%ebp),%eax
     90e:	c9                   	leave  
     90f:	c2 04 00             	ret    $0x4

00000912 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     912:	55                   	push   %ebp
     913:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     915:	8b 45 08             	mov    0x8(%ebp),%eax
     918:	2b 45 10             	sub    0x10(%ebp),%eax
     91b:	89 c2                	mov    %eax,%edx
     91d:	8b 45 08             	mov    0x8(%ebp),%eax
     920:	2b 45 10             	sub    0x10(%ebp),%eax
     923:	0f af d0             	imul   %eax,%edx
     926:	8b 45 0c             	mov    0xc(%ebp),%eax
     929:	2b 45 14             	sub    0x14(%ebp),%eax
     92c:	89 c1                	mov    %eax,%ecx
     92e:	8b 45 0c             	mov    0xc(%ebp),%eax
     931:	2b 45 14             	sub    0x14(%ebp),%eax
     934:	0f af c1             	imul   %ecx,%eax
     937:	01 d0                	add    %edx,%eax
}
     939:	5d                   	pop    %ebp
     93a:	c3                   	ret    

0000093b <abs_int>:

static inline int abs_int(int x)
{
     93b:	55                   	push   %ebp
     93c:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     93e:	8b 45 08             	mov    0x8(%ebp),%eax
     941:	99                   	cltd   
     942:	89 d0                	mov    %edx,%eax
     944:	33 45 08             	xor    0x8(%ebp),%eax
     947:	29 d0                	sub    %edx,%eax
}
     949:	5d                   	pop    %ebp
     94a:	c3                   	ret    

0000094b <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     94b:	55                   	push   %ebp
     94c:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     94e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     952:	79 07                	jns    95b <APGetIndex+0x10>
        return X_SMALLER;
     954:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     959:	eb 40                	jmp    99b <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     95b:	8b 45 08             	mov    0x8(%ebp),%eax
     95e:	8b 00                	mov    (%eax),%eax
     960:	3b 45 0c             	cmp    0xc(%ebp),%eax
     963:	7f 07                	jg     96c <APGetIndex+0x21>
        return X_BIGGER;
     965:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     96a:	eb 2f                	jmp    99b <APGetIndex+0x50>
    if (y < 0)
     96c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     970:	79 07                	jns    979 <APGetIndex+0x2e>
        return Y_SMALLER;
     972:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     977:	eb 22                	jmp    99b <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     979:	8b 45 08             	mov    0x8(%ebp),%eax
     97c:	8b 40 04             	mov    0x4(%eax),%eax
     97f:	3b 45 10             	cmp    0x10(%ebp),%eax
     982:	7f 07                	jg     98b <APGetIndex+0x40>
        return Y_BIGGER;
     984:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     989:	eb 10                	jmp    99b <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     98b:	8b 45 08             	mov    0x8(%ebp),%eax
     98e:	8b 00                	mov    (%eax),%eax
     990:	0f af 45 10          	imul   0x10(%ebp),%eax
     994:	89 c2                	mov    %eax,%edx
     996:	8b 45 0c             	mov    0xc(%ebp),%eax
     999:	01 d0                	add    %edx,%eax
}
     99b:	5d                   	pop    %ebp
     99c:	c3                   	ret    

0000099d <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     99d:	55                   	push   %ebp
     99e:	89 e5                	mov    %esp,%ebp
     9a0:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     9a3:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     9aa:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9ad:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     9b0:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     9b7:	83 ec 08             	sub    $0x8,%esp
     9ba:	6a 00                	push   $0x0
     9bc:	ff 75 0c             	pushl  0xc(%ebp)
     9bf:	e8 d4 f9 ff ff       	call   398 <open>
     9c4:	83 c4 10             	add    $0x10,%esp
     9c7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     9ca:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     9ce:	79 2e                	jns    9fe <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     9d0:	83 ec 04             	sub    $0x4,%esp
     9d3:	ff 75 0c             	pushl  0xc(%ebp)
     9d6:	68 10 26 00 00       	push   $0x2610
     9db:	6a 01                	push   $0x1
     9dd:	e8 35 fb ff ff       	call   517 <printf>
     9e2:	83 c4 10             	add    $0x10,%esp
        return bmp;
     9e5:	8b 45 08             	mov    0x8(%ebp),%eax
     9e8:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9eb:	89 10                	mov    %edx,(%eax)
     9ed:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9f0:	89 50 04             	mov    %edx,0x4(%eax)
     9f3:	8b 55 d0             	mov    -0x30(%ebp),%edx
     9f6:	89 50 08             	mov    %edx,0x8(%eax)
     9f9:	e9 d2 01 00 00       	jmp    bd0 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     9fe:	83 ec 04             	sub    $0x4,%esp
     a01:	6a 0e                	push   $0xe
     a03:	8d 45 ba             	lea    -0x46(%ebp),%eax
     a06:	50                   	push   %eax
     a07:	ff 75 ec             	pushl  -0x14(%ebp)
     a0a:	e8 61 f9 ff ff       	call   370 <read>
     a0f:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     a12:	83 ec 04             	sub    $0x4,%esp
     a15:	6a 28                	push   $0x28
     a17:	8d 45 92             	lea    -0x6e(%ebp),%eax
     a1a:	50                   	push   %eax
     a1b:	ff 75 ec             	pushl  -0x14(%ebp)
     a1e:	e8 4d f9 ff ff       	call   370 <read>
     a23:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     a26:	8b 45 96             	mov    -0x6a(%ebp),%eax
     a29:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     a2c:	8b 45 9a             	mov    -0x66(%ebp),%eax
     a2f:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     a32:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a35:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a38:	0f af d0             	imul   %eax,%edx
     a3b:	89 d0                	mov    %edx,%eax
     a3d:	01 c0                	add    %eax,%eax
     a3f:	01 d0                	add    %edx,%eax
     a41:	83 ec 0c             	sub    $0xc,%esp
     a44:	50                   	push   %eax
     a45:	e8 a0 fd ff ff       	call   7ea <malloc>
     a4a:	83 c4 10             	add    $0x10,%esp
     a4d:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     a50:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a54:	0f b7 c0             	movzwl %ax,%eax
     a57:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     a5a:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a5d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a60:	0f af c2             	imul   %edx,%eax
     a63:	83 c0 1f             	add    $0x1f,%eax
     a66:	c1 e8 05             	shr    $0x5,%eax
     a69:	c1 e0 02             	shl    $0x2,%eax
     a6c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     a6f:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a72:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a75:	0f af c2             	imul   %edx,%eax
     a78:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     a7b:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a7e:	83 ec 0c             	sub    $0xc,%esp
     a81:	50                   	push   %eax
     a82:	e8 63 fd ff ff       	call   7ea <malloc>
     a87:	83 c4 10             	add    $0x10,%esp
     a8a:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a8d:	83 ec 04             	sub    $0x4,%esp
     a90:	ff 75 e0             	pushl  -0x20(%ebp)
     a93:	ff 75 dc             	pushl  -0x24(%ebp)
     a96:	ff 75 ec             	pushl  -0x14(%ebp)
     a99:	e8 d2 f8 ff ff       	call   370 <read>
     a9e:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     aa1:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     aa5:	66 c1 e8 03          	shr    $0x3,%ax
     aa9:	0f b7 c0             	movzwl %ax,%eax
     aac:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     aaf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ab6:	e9 e5 00 00 00       	jmp    ba0 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     abb:	8b 55 cc             	mov    -0x34(%ebp),%edx
     abe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac1:	29 c2                	sub    %eax,%edx
     ac3:	89 d0                	mov    %edx,%eax
     ac5:	8d 50 ff             	lea    -0x1(%eax),%edx
     ac8:	8b 45 c8             	mov    -0x38(%ebp),%eax
     acb:	0f af c2             	imul   %edx,%eax
     ace:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     ad1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ad8:	e9 b1 00 00 00       	jmp    b8e <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     add:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ae0:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ae3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ae6:	01 c8                	add    %ecx,%eax
     ae8:	89 c1                	mov    %eax,%ecx
     aea:	89 c8                	mov    %ecx,%eax
     aec:	01 c0                	add    %eax,%eax
     aee:	01 c8                	add    %ecx,%eax
     af0:	01 c2                	add    %eax,%edx
     af2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af5:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     af9:	89 c1                	mov    %eax,%ecx
     afb:	8b 45 d8             	mov    -0x28(%ebp),%eax
     afe:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b02:	01 c1                	add    %eax,%ecx
     b04:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b07:	01 c8                	add    %ecx,%eax
     b09:	8d 48 ff             	lea    -0x1(%eax),%ecx
     b0c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b0f:	01 c8                	add    %ecx,%eax
     b11:	0f b6 00             	movzbl (%eax),%eax
     b14:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     b17:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b1a:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b20:	01 c8                	add    %ecx,%eax
     b22:	89 c1                	mov    %eax,%ecx
     b24:	89 c8                	mov    %ecx,%eax
     b26:	01 c0                	add    %eax,%eax
     b28:	01 c8                	add    %ecx,%eax
     b2a:	01 c2                	add    %eax,%edx
     b2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b2f:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b33:	89 c1                	mov    %eax,%ecx
     b35:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b38:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b3c:	01 c1                	add    %eax,%ecx
     b3e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b41:	01 c8                	add    %ecx,%eax
     b43:	8d 48 fe             	lea    -0x2(%eax),%ecx
     b46:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b49:	01 c8                	add    %ecx,%eax
     b4b:	0f b6 00             	movzbl (%eax),%eax
     b4e:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     b51:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b54:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b57:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b5a:	01 c8                	add    %ecx,%eax
     b5c:	89 c1                	mov    %eax,%ecx
     b5e:	89 c8                	mov    %ecx,%eax
     b60:	01 c0                	add    %eax,%eax
     b62:	01 c8                	add    %ecx,%eax
     b64:	01 c2                	add    %eax,%edx
     b66:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b69:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b6d:	89 c1                	mov    %eax,%ecx
     b6f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b72:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b76:	01 c1                	add    %eax,%ecx
     b78:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b7b:	01 c8                	add    %ecx,%eax
     b7d:	8d 48 fd             	lea    -0x3(%eax),%ecx
     b80:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b83:	01 c8                	add    %ecx,%eax
     b85:	0f b6 00             	movzbl (%eax),%eax
     b88:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     b8a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b8e:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b91:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b94:	39 c2                	cmp    %eax,%edx
     b96:	0f 87 41 ff ff ff    	ja     add <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b9c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ba0:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ba3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba6:	39 c2                	cmp    %eax,%edx
     ba8:	0f 87 0d ff ff ff    	ja     abb <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     bae:	83 ec 0c             	sub    $0xc,%esp
     bb1:	ff 75 ec             	pushl  -0x14(%ebp)
     bb4:	e8 c7 f7 ff ff       	call   380 <close>
     bb9:	83 c4 10             	add    $0x10,%esp
    return bmp;
     bbc:	8b 45 08             	mov    0x8(%ebp),%eax
     bbf:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bc2:	89 10                	mov    %edx,(%eax)
     bc4:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bc7:	89 50 04             	mov    %edx,0x4(%eax)
     bca:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bcd:	89 50 08             	mov    %edx,0x8(%eax)
}
     bd0:	8b 45 08             	mov    0x8(%ebp),%eax
     bd3:	c9                   	leave  
     bd4:	c2 04 00             	ret    $0x4

00000bd7 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     bd7:	55                   	push   %ebp
     bd8:	89 e5                	mov    %esp,%ebp
     bda:	53                   	push   %ebx
     bdb:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     bde:	83 ec 0c             	sub    $0xc,%esp
     be1:	6a 1c                	push   $0x1c
     be3:	e8 02 fc ff ff       	call   7ea <malloc>
     be8:	83 c4 10             	add    $0x10,%esp
     beb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     bee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bf1:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     bf8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     bfb:	8d 45 d8             	lea    -0x28(%ebp),%eax
     bfe:	6a 0c                	push   $0xc
     c00:	6a 0c                	push   $0xc
     c02:	6a 0c                	push   $0xc
     c04:	50                   	push   %eax
     c05:	e8 c3 fc ff ff       	call   8cd <RGB>
     c0a:	83 c4 0c             	add    $0xc,%esp
     c0d:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     c11:	66 89 43 13          	mov    %ax,0x13(%ebx)
     c15:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     c19:	88 43 15             	mov    %al,0x15(%ebx)
     c1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c1f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c22:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     c26:	66 89 48 10          	mov    %cx,0x10(%eax)
     c2a:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     c2e:	88 50 12             	mov    %dl,0x12(%eax)
     c31:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c34:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c37:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     c3b:	66 89 48 08          	mov    %cx,0x8(%eax)
     c3f:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     c43:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     c46:	8b 45 08             	mov    0x8(%ebp),%eax
     c49:	89 c2                	mov    %eax,%edx
     c4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c4e:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     c50:	8b 45 0c             	mov    0xc(%ebp),%eax
     c53:	89 c2                	mov    %eax,%edx
     c55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c58:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     c5b:	8b 55 10             	mov    0x10(%ebp),%edx
     c5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c61:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     c64:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c67:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c6a:	c9                   	leave  
     c6b:	c3                   	ret    

00000c6c <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     c6c:	55                   	push   %ebp
     c6d:	89 e5                	mov    %esp,%ebp
     c6f:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     c72:	8b 45 0c             	mov    0xc(%ebp),%eax
     c75:	8b 50 08             	mov    0x8(%eax),%edx
     c78:	89 55 f8             	mov    %edx,-0x8(%ebp)
     c7b:	8b 40 0c             	mov    0xc(%eax),%eax
     c7e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     c81:	8b 45 0c             	mov    0xc(%ebp),%eax
     c84:	8b 55 10             	mov    0x10(%ebp),%edx
     c87:	89 50 08             	mov    %edx,0x8(%eax)
     c8a:	8b 55 14             	mov    0x14(%ebp),%edx
     c8d:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c90:	8b 45 08             	mov    0x8(%ebp),%eax
     c93:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c96:	89 10                	mov    %edx,(%eax)
     c98:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c9b:	89 50 04             	mov    %edx,0x4(%eax)
}
     c9e:	8b 45 08             	mov    0x8(%ebp),%eax
     ca1:	c9                   	leave  
     ca2:	c2 04 00             	ret    $0x4

00000ca5 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     ca5:	55                   	push   %ebp
     ca6:	89 e5                	mov    %esp,%ebp
     ca8:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     cab:	8b 45 0c             	mov    0xc(%ebp),%eax
     cae:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     cb2:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     cb6:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     cba:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     cbd:	8b 45 0c             	mov    0xc(%ebp),%eax
     cc0:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     cc4:	66 89 50 10          	mov    %dx,0x10(%eax)
     cc8:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     ccc:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     ccf:	8b 45 08             	mov    0x8(%ebp),%eax
     cd2:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     cd6:	66 89 10             	mov    %dx,(%eax)
     cd9:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     cdd:	88 50 02             	mov    %dl,0x2(%eax)
}
     ce0:	8b 45 08             	mov    0x8(%ebp),%eax
     ce3:	c9                   	leave  
     ce4:	c2 04 00             	ret    $0x4

00000ce7 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     ce7:	55                   	push   %ebp
     ce8:	89 e5                	mov    %esp,%ebp
     cea:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     ced:	8b 45 0c             	mov    0xc(%ebp),%eax
     cf0:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     cf4:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     cf8:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     cfc:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     cff:	8b 45 0c             	mov    0xc(%ebp),%eax
     d02:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     d06:	66 89 50 13          	mov    %dx,0x13(%eax)
     d0a:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     d0e:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     d11:	8b 45 08             	mov    0x8(%ebp),%eax
     d14:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d18:	66 89 10             	mov    %dx,(%eax)
     d1b:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d1f:	88 50 02             	mov    %dl,0x2(%eax)
}
     d22:	8b 45 08             	mov    0x8(%ebp),%eax
     d25:	c9                   	leave  
     d26:	c2 04 00             	ret    $0x4

00000d29 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     d29:	55                   	push   %ebp
     d2a:	89 e5                	mov    %esp,%ebp
     d2c:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     d2f:	8b 45 08             	mov    0x8(%ebp),%eax
     d32:	8b 40 0c             	mov    0xc(%eax),%eax
     d35:	89 c2                	mov    %eax,%edx
     d37:	c1 ea 1f             	shr    $0x1f,%edx
     d3a:	01 d0                	add    %edx,%eax
     d3c:	d1 f8                	sar    %eax
     d3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     d41:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d44:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     d48:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     d4b:	8b 45 10             	mov    0x10(%ebp),%eax
     d4e:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d51:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     d54:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     d58:	0f 89 98 00 00 00    	jns    df6 <APDrawPoint+0xcd>
        i = 0;
     d5e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     d65:	e9 8c 00 00 00       	jmp    df6 <APDrawPoint+0xcd>
    {
        j = x - off;
     d6a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d6d:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d70:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d73:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d77:	79 69                	jns    de2 <APDrawPoint+0xb9>
            j = 0;
     d79:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d80:	eb 60                	jmp    de2 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d82:	ff 75 fc             	pushl  -0x4(%ebp)
     d85:	ff 75 f8             	pushl  -0x8(%ebp)
     d88:	ff 75 08             	pushl  0x8(%ebp)
     d8b:	e8 bb fb ff ff       	call   94b <APGetIndex>
     d90:	83 c4 0c             	add    $0xc,%esp
     d93:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d96:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d9a:	74 55                	je     df1 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d9c:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     da0:	74 67                	je     e09 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     da2:	ff 75 10             	pushl  0x10(%ebp)
     da5:	ff 75 0c             	pushl  0xc(%ebp)
     da8:	ff 75 fc             	pushl  -0x4(%ebp)
     dab:	ff 75 f8             	pushl  -0x8(%ebp)
     dae:	e8 5f fb ff ff       	call   912 <distance_2>
     db3:	83 c4 10             	add    $0x10,%esp
     db6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     db9:	7f 23                	jg     dde <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     dbb:	8b 45 08             	mov    0x8(%ebp),%eax
     dbe:	8b 48 18             	mov    0x18(%eax),%ecx
     dc1:	8b 55 ec             	mov    -0x14(%ebp),%edx
     dc4:	89 d0                	mov    %edx,%eax
     dc6:	01 c0                	add    %eax,%eax
     dc8:	01 d0                	add    %edx,%eax
     dca:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     dcd:	8b 45 08             	mov    0x8(%ebp),%eax
     dd0:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     dd4:	66 89 0a             	mov    %cx,(%edx)
     dd7:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     ddb:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     dde:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     de2:	8b 55 0c             	mov    0xc(%ebp),%edx
     de5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     de8:	01 d0                	add    %edx,%eax
     dea:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     ded:	7d 93                	jge    d82 <APDrawPoint+0x59>
     def:	eb 01                	jmp    df2 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     df1:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     df2:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     df6:	8b 55 10             	mov    0x10(%ebp),%edx
     df9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dfc:	01 d0                	add    %edx,%eax
     dfe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e01:	0f 8d 63 ff ff ff    	jge    d6a <APDrawPoint+0x41>
     e07:	eb 01                	jmp    e0a <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     e09:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     e0a:	c9                   	leave  
     e0b:	c3                   	ret    

00000e0c <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     e0c:	55                   	push   %ebp
     e0d:	89 e5                	mov    %esp,%ebp
     e0f:	53                   	push   %ebx
     e10:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     e13:	8b 45 0c             	mov    0xc(%ebp),%eax
     e16:	3b 45 14             	cmp    0x14(%ebp),%eax
     e19:	0f 85 80 00 00 00    	jne    e9f <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     e1f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e23:	0f 88 9d 02 00 00    	js     10c6 <APDrawLine+0x2ba>
     e29:	8b 45 08             	mov    0x8(%ebp),%eax
     e2c:	8b 00                	mov    (%eax),%eax
     e2e:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e31:	0f 8e 8f 02 00 00    	jle    10c6 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     e37:	8b 45 10             	mov    0x10(%ebp),%eax
     e3a:	3b 45 18             	cmp    0x18(%ebp),%eax
     e3d:	7e 12                	jle    e51 <APDrawLine+0x45>
        {
            int tmp = y2;
     e3f:	8b 45 18             	mov    0x18(%ebp),%eax
     e42:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     e45:	8b 45 10             	mov    0x10(%ebp),%eax
     e48:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     e4b:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e4e:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     e51:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e55:	79 07                	jns    e5e <APDrawLine+0x52>
     e57:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e5e:	8b 45 08             	mov    0x8(%ebp),%eax
     e61:	8b 40 04             	mov    0x4(%eax),%eax
     e64:	3b 45 18             	cmp    0x18(%ebp),%eax
     e67:	7d 0c                	jge    e75 <APDrawLine+0x69>
     e69:	8b 45 08             	mov    0x8(%ebp),%eax
     e6c:	8b 40 04             	mov    0x4(%eax),%eax
     e6f:	83 e8 01             	sub    $0x1,%eax
     e72:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e75:	8b 45 10             	mov    0x10(%ebp),%eax
     e78:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e7b:	eb 15                	jmp    e92 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e7d:	ff 75 f4             	pushl  -0xc(%ebp)
     e80:	ff 75 0c             	pushl  0xc(%ebp)
     e83:	ff 75 08             	pushl  0x8(%ebp)
     e86:	e8 9e fe ff ff       	call   d29 <APDrawPoint>
     e8b:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e8e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e92:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e95:	3b 45 18             	cmp    0x18(%ebp),%eax
     e98:	7e e3                	jle    e7d <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e9a:	e9 2b 02 00 00       	jmp    10ca <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e9f:	8b 45 10             	mov    0x10(%ebp),%eax
     ea2:	3b 45 18             	cmp    0x18(%ebp),%eax
     ea5:	75 7f                	jne    f26 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     ea7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     eab:	0f 88 18 02 00 00    	js     10c9 <APDrawLine+0x2bd>
     eb1:	8b 45 08             	mov    0x8(%ebp),%eax
     eb4:	8b 40 04             	mov    0x4(%eax),%eax
     eb7:	3b 45 10             	cmp    0x10(%ebp),%eax
     eba:	0f 8e 09 02 00 00    	jle    10c9 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     ec0:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec3:	3b 45 14             	cmp    0x14(%ebp),%eax
     ec6:	7e 12                	jle    eda <APDrawLine+0xce>
        {
            int tmp = x2;
     ec8:	8b 45 14             	mov    0x14(%ebp),%eax
     ecb:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     ece:	8b 45 0c             	mov    0xc(%ebp),%eax
     ed1:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     ed4:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ed7:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     eda:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ede:	79 07                	jns    ee7 <APDrawLine+0xdb>
     ee0:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     ee7:	8b 45 08             	mov    0x8(%ebp),%eax
     eea:	8b 00                	mov    (%eax),%eax
     eec:	3b 45 14             	cmp    0x14(%ebp),%eax
     eef:	7d 0b                	jge    efc <APDrawLine+0xf0>
     ef1:	8b 45 08             	mov    0x8(%ebp),%eax
     ef4:	8b 00                	mov    (%eax),%eax
     ef6:	83 e8 01             	sub    $0x1,%eax
     ef9:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     efc:	8b 45 0c             	mov    0xc(%ebp),%eax
     eff:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f02:	eb 15                	jmp    f19 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     f04:	ff 75 10             	pushl  0x10(%ebp)
     f07:	ff 75 f0             	pushl  -0x10(%ebp)
     f0a:	ff 75 08             	pushl  0x8(%ebp)
     f0d:	e8 17 fe ff ff       	call   d29 <APDrawPoint>
     f12:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     f15:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f19:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f1c:	3b 45 14             	cmp    0x14(%ebp),%eax
     f1f:	7e e3                	jle    f04 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     f21:	e9 a4 01 00 00       	jmp    10ca <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     f26:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f2d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     f34:	8b 45 0c             	mov    0xc(%ebp),%eax
     f37:	2b 45 14             	sub    0x14(%ebp),%eax
     f3a:	50                   	push   %eax
     f3b:	e8 fb f9 ff ff       	call   93b <abs_int>
     f40:	83 c4 04             	add    $0x4,%esp
     f43:	89 c3                	mov    %eax,%ebx
     f45:	8b 45 10             	mov    0x10(%ebp),%eax
     f48:	2b 45 18             	sub    0x18(%ebp),%eax
     f4b:	50                   	push   %eax
     f4c:	e8 ea f9 ff ff       	call   93b <abs_int>
     f51:	83 c4 04             	add    $0x4,%esp
     f54:	39 c3                	cmp    %eax,%ebx
     f56:	0f 8e b5 00 00 00    	jle    1011 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f5c:	8b 45 10             	mov    0x10(%ebp),%eax
     f5f:	2b 45 18             	sub    0x18(%ebp),%eax
     f62:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f65:	db 45 b0             	fildl  -0x50(%ebp)
     f68:	8b 45 0c             	mov    0xc(%ebp),%eax
     f6b:	2b 45 14             	sub    0x14(%ebp),%eax
     f6e:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f71:	db 45 b0             	fildl  -0x50(%ebp)
     f74:	de f9                	fdivrp %st,%st(1)
     f76:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f79:	8b 45 14             	mov    0x14(%ebp),%eax
     f7c:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f7f:	7e 0e                	jle    f8f <APDrawLine+0x183>
        {
            s = x1;
     f81:	8b 45 0c             	mov    0xc(%ebp),%eax
     f84:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f87:	8b 45 14             	mov    0x14(%ebp),%eax
     f8a:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f8d:	eb 0c                	jmp    f9b <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f8f:	8b 45 14             	mov    0x14(%ebp),%eax
     f92:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f95:	8b 45 0c             	mov    0xc(%ebp),%eax
     f98:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f9b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f9f:	79 07                	jns    fa8 <APDrawLine+0x19c>
     fa1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     fa8:	8b 45 08             	mov    0x8(%ebp),%eax
     fab:	8b 00                	mov    (%eax),%eax
     fad:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fb0:	7f 0b                	jg     fbd <APDrawLine+0x1b1>
     fb2:	8b 45 08             	mov    0x8(%ebp),%eax
     fb5:	8b 00                	mov    (%eax),%eax
     fb7:	83 e8 01             	sub    $0x1,%eax
     fba:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     fbd:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fc0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     fc3:	eb 3f                	jmp    1004 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     fc5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fc8:	2b 45 0c             	sub    0xc(%ebp),%eax
     fcb:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fce:	db 45 b0             	fildl  -0x50(%ebp)
     fd1:	dc 4d d0             	fmull  -0x30(%ebp)
     fd4:	db 45 10             	fildl  0x10(%ebp)
     fd7:	de c1                	faddp  %st,%st(1)
     fd9:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fdc:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fe0:	b4 0c                	mov    $0xc,%ah
     fe2:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fe6:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fe9:	db 5d cc             	fistpl -0x34(%ebp)
     fec:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     fef:	ff 75 cc             	pushl  -0x34(%ebp)
     ff2:	ff 75 e4             	pushl  -0x1c(%ebp)
     ff5:	ff 75 08             	pushl  0x8(%ebp)
     ff8:	e8 2c fd ff ff       	call   d29 <APDrawPoint>
     ffd:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1000:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1004:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1007:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    100a:	7e b9                	jle    fc5 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    100c:	e9 b9 00 00 00       	jmp    10ca <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1011:	8b 45 0c             	mov    0xc(%ebp),%eax
    1014:	2b 45 14             	sub    0x14(%ebp),%eax
    1017:	89 45 b0             	mov    %eax,-0x50(%ebp)
    101a:	db 45 b0             	fildl  -0x50(%ebp)
    101d:	8b 45 10             	mov    0x10(%ebp),%eax
    1020:	2b 45 18             	sub    0x18(%ebp),%eax
    1023:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1026:	db 45 b0             	fildl  -0x50(%ebp)
    1029:	de f9                	fdivrp %st,%st(1)
    102b:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    102e:	8b 45 10             	mov    0x10(%ebp),%eax
    1031:	3b 45 18             	cmp    0x18(%ebp),%eax
    1034:	7e 0e                	jle    1044 <APDrawLine+0x238>
    {
        s = y2;
    1036:	8b 45 18             	mov    0x18(%ebp),%eax
    1039:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    103c:	8b 45 10             	mov    0x10(%ebp),%eax
    103f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1042:	eb 0c                	jmp    1050 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1044:	8b 45 10             	mov    0x10(%ebp),%eax
    1047:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    104a:	8b 45 18             	mov    0x18(%ebp),%eax
    104d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1050:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1054:	79 07                	jns    105d <APDrawLine+0x251>
    1056:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    105d:	8b 45 08             	mov    0x8(%ebp),%eax
    1060:	8b 40 04             	mov    0x4(%eax),%eax
    1063:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1066:	7f 0c                	jg     1074 <APDrawLine+0x268>
    1068:	8b 45 08             	mov    0x8(%ebp),%eax
    106b:	8b 40 04             	mov    0x4(%eax),%eax
    106e:	83 e8 01             	sub    $0x1,%eax
    1071:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1074:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1077:	89 45 e0             	mov    %eax,-0x20(%ebp)
    107a:	eb 3f                	jmp    10bb <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    107c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    107f:	2b 45 10             	sub    0x10(%ebp),%eax
    1082:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1085:	db 45 b0             	fildl  -0x50(%ebp)
    1088:	dc 4d c0             	fmull  -0x40(%ebp)
    108b:	db 45 0c             	fildl  0xc(%ebp)
    108e:	de c1                	faddp  %st,%st(1)
    1090:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1093:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1097:	b4 0c                	mov    $0xc,%ah
    1099:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    109d:	d9 6d b4             	fldcw  -0x4c(%ebp)
    10a0:	db 5d bc             	fistpl -0x44(%ebp)
    10a3:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    10a6:	ff 75 e0             	pushl  -0x20(%ebp)
    10a9:	ff 75 bc             	pushl  -0x44(%ebp)
    10ac:	ff 75 08             	pushl  0x8(%ebp)
    10af:	e8 75 fc ff ff       	call   d29 <APDrawPoint>
    10b4:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    10b7:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    10bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10be:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10c1:	7e b9                	jle    107c <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    10c3:	90                   	nop
    10c4:	eb 04                	jmp    10ca <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    10c6:	90                   	nop
    10c7:	eb 01                	jmp    10ca <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    10c9:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    10ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10cd:	c9                   	leave  
    10ce:	c3                   	ret    

000010cf <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    10cf:	55                   	push   %ebp
    10d0:	89 e5                	mov    %esp,%ebp
    10d2:	53                   	push   %ebx
    10d3:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    10d6:	8b 55 10             	mov    0x10(%ebp),%edx
    10d9:	8b 45 18             	mov    0x18(%ebp),%eax
    10dc:	01 d0                	add    %edx,%eax
    10de:	83 e8 01             	sub    $0x1,%eax
    10e1:	83 ec 04             	sub    $0x4,%esp
    10e4:	50                   	push   %eax
    10e5:	ff 75 0c             	pushl  0xc(%ebp)
    10e8:	ff 75 10             	pushl  0x10(%ebp)
    10eb:	ff 75 0c             	pushl  0xc(%ebp)
    10ee:	ff 75 08             	pushl  0x8(%ebp)
    10f1:	e8 16 fd ff ff       	call   e0c <APDrawLine>
    10f6:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    10f9:	8b 55 0c             	mov    0xc(%ebp),%edx
    10fc:	8b 45 14             	mov    0x14(%ebp),%eax
    10ff:	01 d0                	add    %edx,%eax
    1101:	83 e8 01             	sub    $0x1,%eax
    1104:	83 ec 04             	sub    $0x4,%esp
    1107:	ff 75 10             	pushl  0x10(%ebp)
    110a:	50                   	push   %eax
    110b:	ff 75 10             	pushl  0x10(%ebp)
    110e:	ff 75 0c             	pushl  0xc(%ebp)
    1111:	ff 75 08             	pushl  0x8(%ebp)
    1114:	e8 f3 fc ff ff       	call   e0c <APDrawLine>
    1119:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    111c:	8b 55 10             	mov    0x10(%ebp),%edx
    111f:	8b 45 18             	mov    0x18(%ebp),%eax
    1122:	01 d0                	add    %edx,%eax
    1124:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1127:	8b 55 0c             	mov    0xc(%ebp),%edx
    112a:	8b 45 14             	mov    0x14(%ebp),%eax
    112d:	01 d0                	add    %edx,%eax
    112f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1132:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1135:	8b 45 14             	mov    0x14(%ebp),%eax
    1138:	01 d8                	add    %ebx,%eax
    113a:	83 e8 01             	sub    $0x1,%eax
    113d:	83 ec 04             	sub    $0x4,%esp
    1140:	51                   	push   %ecx
    1141:	52                   	push   %edx
    1142:	ff 75 10             	pushl  0x10(%ebp)
    1145:	50                   	push   %eax
    1146:	ff 75 08             	pushl  0x8(%ebp)
    1149:	e8 be fc ff ff       	call   e0c <APDrawLine>
    114e:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1151:	8b 55 10             	mov    0x10(%ebp),%edx
    1154:	8b 45 18             	mov    0x18(%ebp),%eax
    1157:	01 d0                	add    %edx,%eax
    1159:	8d 48 ff             	lea    -0x1(%eax),%ecx
    115c:	8b 55 0c             	mov    0xc(%ebp),%edx
    115f:	8b 45 14             	mov    0x14(%ebp),%eax
    1162:	01 d0                	add    %edx,%eax
    1164:	8d 50 ff             	lea    -0x1(%eax),%edx
    1167:	8b 5d 10             	mov    0x10(%ebp),%ebx
    116a:	8b 45 18             	mov    0x18(%ebp),%eax
    116d:	01 d8                	add    %ebx,%eax
    116f:	83 e8 01             	sub    $0x1,%eax
    1172:	83 ec 04             	sub    $0x4,%esp
    1175:	51                   	push   %ecx
    1176:	52                   	push   %edx
    1177:	50                   	push   %eax
    1178:	ff 75 0c             	pushl  0xc(%ebp)
    117b:	ff 75 08             	pushl  0x8(%ebp)
    117e:	e8 89 fc ff ff       	call   e0c <APDrawLine>
    1183:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1186:	8b 55 0c             	mov    0xc(%ebp),%edx
    1189:	8b 45 14             	mov    0x14(%ebp),%eax
    118c:	01 d0                	add    %edx,%eax
    118e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1191:	8b 45 08             	mov    0x8(%ebp),%eax
    1194:	8b 40 0c             	mov    0xc(%eax),%eax
    1197:	89 c1                	mov    %eax,%ecx
    1199:	c1 e9 1f             	shr    $0x1f,%ecx
    119c:	01 c8                	add    %ecx,%eax
    119e:	d1 f8                	sar    %eax
    11a0:	29 c2                	sub    %eax,%edx
    11a2:	89 d0                	mov    %edx,%eax
    11a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    11a7:	8b 55 10             	mov    0x10(%ebp),%edx
    11aa:	8b 45 18             	mov    0x18(%ebp),%eax
    11ad:	01 d0                	add    %edx,%eax
    11af:	8d 50 ff             	lea    -0x1(%eax),%edx
    11b2:	8b 45 08             	mov    0x8(%ebp),%eax
    11b5:	8b 40 0c             	mov    0xc(%eax),%eax
    11b8:	89 c1                	mov    %eax,%ecx
    11ba:	c1 e9 1f             	shr    $0x1f,%ecx
    11bd:	01 c8                	add    %ecx,%eax
    11bf:	d1 f8                	sar    %eax
    11c1:	29 c2                	sub    %eax,%edx
    11c3:	89 d0                	mov    %edx,%eax
    11c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    11c8:	8b 45 08             	mov    0x8(%ebp),%eax
    11cb:	8b 40 0c             	mov    0xc(%eax),%eax
    11ce:	89 c2                	mov    %eax,%edx
    11d0:	c1 ea 1f             	shr    $0x1f,%edx
    11d3:	01 d0                	add    %edx,%eax
    11d5:	d1 f8                	sar    %eax
    11d7:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    11da:	8b 45 08             	mov    0x8(%ebp),%eax
    11dd:	8b 40 0c             	mov    0xc(%eax),%eax
    11e0:	89 c2                	mov    %eax,%edx
    11e2:	c1 ea 1f             	shr    $0x1f,%edx
    11e5:	01 d0                	add    %edx,%eax
    11e7:	d1 f8                	sar    %eax
    11e9:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    11ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11f0:	0f 88 d8 00 00 00    	js     12ce <APDrawRect+0x1ff>
    11f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11fa:	0f 88 ce 00 00 00    	js     12ce <APDrawRect+0x1ff>
    1200:	8b 45 08             	mov    0x8(%ebp),%eax
    1203:	8b 00                	mov    (%eax),%eax
    1205:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1208:	0f 8e c0 00 00 00    	jle    12ce <APDrawRect+0x1ff>
    120e:	8b 45 08             	mov    0x8(%ebp),%eax
    1211:	8b 40 04             	mov    0x4(%eax),%eax
    1214:	3b 45 10             	cmp    0x10(%ebp),%eax
    1217:	0f 8e b1 00 00 00    	jle    12ce <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    121d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1221:	79 07                	jns    122a <APDrawRect+0x15b>
    1223:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    122a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    122e:	79 07                	jns    1237 <APDrawRect+0x168>
    1230:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1237:	8b 45 08             	mov    0x8(%ebp),%eax
    123a:	8b 00                	mov    (%eax),%eax
    123c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    123f:	7f 0b                	jg     124c <APDrawRect+0x17d>
    1241:	8b 45 08             	mov    0x8(%ebp),%eax
    1244:	8b 00                	mov    (%eax),%eax
    1246:	83 e8 01             	sub    $0x1,%eax
    1249:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    124c:	8b 45 08             	mov    0x8(%ebp),%eax
    124f:	8b 40 04             	mov    0x4(%eax),%eax
    1252:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1255:	7f 0c                	jg     1263 <APDrawRect+0x194>
    1257:	8b 45 08             	mov    0x8(%ebp),%eax
    125a:	8b 40 04             	mov    0x4(%eax),%eax
    125d:	83 e8 01             	sub    $0x1,%eax
    1260:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1263:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    126a:	8b 45 0c             	mov    0xc(%ebp),%eax
    126d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1270:	eb 52                	jmp    12c4 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1272:	8b 45 10             	mov    0x10(%ebp),%eax
    1275:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1278:	eb 3e                	jmp    12b8 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    127a:	83 ec 04             	sub    $0x4,%esp
    127d:	ff 75 e8             	pushl  -0x18(%ebp)
    1280:	ff 75 ec             	pushl  -0x14(%ebp)
    1283:	ff 75 08             	pushl  0x8(%ebp)
    1286:	e8 c0 f6 ff ff       	call   94b <APGetIndex>
    128b:	83 c4 10             	add    $0x10,%esp
    128e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1291:	8b 45 08             	mov    0x8(%ebp),%eax
    1294:	8b 48 18             	mov    0x18(%eax),%ecx
    1297:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    129a:	89 d0                	mov    %edx,%eax
    129c:	01 c0                	add    %eax,%eax
    129e:	01 d0                	add    %edx,%eax
    12a0:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    12a3:	8b 45 08             	mov    0x8(%ebp),%eax
    12a6:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    12aa:	66 89 0a             	mov    %cx,(%edx)
    12ad:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    12b1:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    12b4:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12b8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12bb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12be:	7e ba                	jle    127a <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12c0:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    12c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12c7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    12ca:	7e a6                	jle    1272 <APDrawRect+0x1a3>
    12cc:	eb 01                	jmp    12cf <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    12ce:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    12cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12d2:	c9                   	leave  
    12d3:	c3                   	ret    

000012d4 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    12d4:	55                   	push   %ebp
    12d5:	89 e5                	mov    %esp,%ebp
    12d7:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    12da:	83 ec 0c             	sub    $0xc,%esp
    12dd:	ff 75 0c             	pushl  0xc(%ebp)
    12e0:	e8 b1 ee ff ff       	call   196 <strlen>
    12e5:	83 c4 10             	add    $0x10,%esp
    12e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    12eb:	8b 45 08             	mov    0x8(%ebp),%eax
    12ee:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    12f2:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    12f6:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    12fa:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    12fd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1304:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    130b:	e9 bc 00 00 00       	jmp    13cc <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1310:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1313:	8b 45 0c             	mov    0xc(%ebp),%eax
    1316:	01 d0                	add    %edx,%eax
    1318:	0f b6 00             	movzbl (%eax),%eax
    131b:	0f be c0             	movsbl %al,%eax
    131e:	83 e8 20             	sub    $0x20,%eax
    1321:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1324:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1328:	0f 87 9a 00 00 00    	ja     13c8 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    132e:	8b 45 08             	mov    0x8(%ebp),%eax
    1331:	8b 00                	mov    (%eax),%eax
    1333:	0f af 45 14          	imul   0x14(%ebp),%eax
    1337:	89 c2                	mov    %eax,%edx
    1339:	8b 45 10             	mov    0x10(%ebp),%eax
    133c:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    133f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1342:	89 d0                	mov    %edx,%eax
    1344:	c1 e0 03             	shl    $0x3,%eax
    1347:	01 d0                	add    %edx,%eax
    1349:	01 c8                	add    %ecx,%eax
    134b:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    134e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1355:	eb 6b                	jmp    13c2 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1357:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    135e:	eb 50                	jmp    13b0 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    1360:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1363:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1366:	89 d0                	mov    %edx,%eax
    1368:	c1 e0 03             	shl    $0x3,%eax
    136b:	01 d0                	add    %edx,%eax
    136d:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    1373:	01 c2                	add    %eax,%edx
    1375:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1378:	01 d0                	add    %edx,%eax
    137a:	05 60 2d 00 00       	add    $0x2d60,%eax
    137f:	0f b6 00             	movzbl (%eax),%eax
    1382:	84 c0                	test   %al,%al
    1384:	74 26                	je     13ac <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    1386:	8b 45 08             	mov    0x8(%ebp),%eax
    1389:	8b 50 18             	mov    0x18(%eax),%edx
    138c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    138f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1392:	01 c8                	add    %ecx,%eax
    1394:	89 c1                	mov    %eax,%ecx
    1396:	89 c8                	mov    %ecx,%eax
    1398:	01 c0                	add    %eax,%eax
    139a:	01 c8                	add    %ecx,%eax
    139c:	01 d0                	add    %edx,%eax
    139e:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    13a2:	66 89 10             	mov    %dx,(%eax)
    13a5:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13a9:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    13ac:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    13b0:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    13b4:	7e aa                	jle    1360 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    13b6:	8b 45 08             	mov    0x8(%ebp),%eax
    13b9:	8b 00                	mov    (%eax),%eax
    13bb:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    13be:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    13c2:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    13c6:	7e 8f                	jle    1357 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    13c8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    13cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13cf:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    13d2:	0f 82 38 ff ff ff    	jb     1310 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    13d8:	90                   	nop
    13d9:	c9                   	leave  
    13da:	c3                   	ret    

000013db <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    13db:	55                   	push   %ebp
    13dc:	89 e5                	mov    %esp,%ebp
    13de:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    13e1:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    13e5:	0f 88 8e 01 00 00    	js     1579 <APDcCopy+0x19e>
    13eb:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    13ef:	0f 88 84 01 00 00    	js     1579 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    13f5:	8b 55 0c             	mov    0xc(%ebp),%edx
    13f8:	8b 45 20             	mov    0x20(%ebp),%eax
    13fb:	01 d0                	add    %edx,%eax
    13fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1400:	8b 55 10             	mov    0x10(%ebp),%edx
    1403:	8b 45 24             	mov    0x24(%ebp),%eax
    1406:	01 d0                	add    %edx,%eax
    1408:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    140b:	8b 55 18             	mov    0x18(%ebp),%edx
    140e:	8b 45 20             	mov    0x20(%ebp),%eax
    1411:	01 d0                	add    %edx,%eax
    1413:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1416:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1419:	8b 45 24             	mov    0x24(%ebp),%eax
    141c:	01 d0                	add    %edx,%eax
    141e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1421:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1425:	0f 88 51 01 00 00    	js     157c <APDcCopy+0x1a1>
    142b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    142f:	0f 88 47 01 00 00    	js     157c <APDcCopy+0x1a1>
    1435:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1439:	0f 88 3d 01 00 00    	js     157c <APDcCopy+0x1a1>
    143f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1443:	0f 88 33 01 00 00    	js     157c <APDcCopy+0x1a1>
    1449:	8b 45 14             	mov    0x14(%ebp),%eax
    144c:	8b 00                	mov    (%eax),%eax
    144e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1451:	0f 8c 25 01 00 00    	jl     157c <APDcCopy+0x1a1>
    1457:	8b 45 14             	mov    0x14(%ebp),%eax
    145a:	8b 40 04             	mov    0x4(%eax),%eax
    145d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1460:	0f 8c 16 01 00 00    	jl     157c <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1466:	8b 45 08             	mov    0x8(%ebp),%eax
    1469:	8b 00                	mov    (%eax),%eax
    146b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    146e:	7f 0b                	jg     147b <APDcCopy+0xa0>
    1470:	8b 45 08             	mov    0x8(%ebp),%eax
    1473:	8b 00                	mov    (%eax),%eax
    1475:	83 e8 01             	sub    $0x1,%eax
    1478:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    147b:	8b 45 08             	mov    0x8(%ebp),%eax
    147e:	8b 40 04             	mov    0x4(%eax),%eax
    1481:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1484:	7f 0c                	jg     1492 <APDcCopy+0xb7>
    1486:	8b 45 08             	mov    0x8(%ebp),%eax
    1489:	8b 40 04             	mov    0x4(%eax),%eax
    148c:	83 e8 01             	sub    $0x1,%eax
    148f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1492:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1499:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    14a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14a7:	e9 bc 00 00 00       	jmp    1568 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    14ac:	8b 45 08             	mov    0x8(%ebp),%eax
    14af:	8b 00                	mov    (%eax),%eax
    14b1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14b4:	8b 55 10             	mov    0x10(%ebp),%edx
    14b7:	01 ca                	add    %ecx,%edx
    14b9:	0f af d0             	imul   %eax,%edx
    14bc:	8b 45 0c             	mov    0xc(%ebp),%eax
    14bf:	01 d0                	add    %edx,%eax
    14c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    14c4:	8b 45 14             	mov    0x14(%ebp),%eax
    14c7:	8b 00                	mov    (%eax),%eax
    14c9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14cc:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14cf:	01 ca                	add    %ecx,%edx
    14d1:	0f af d0             	imul   %eax,%edx
    14d4:	8b 45 18             	mov    0x18(%ebp),%eax
    14d7:	01 d0                	add    %edx,%eax
    14d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    14dc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14e3:	eb 74                	jmp    1559 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    14e5:	8b 45 14             	mov    0x14(%ebp),%eax
    14e8:	8b 50 18             	mov    0x18(%eax),%edx
    14eb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    14ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14f1:	01 c8                	add    %ecx,%eax
    14f3:	89 c1                	mov    %eax,%ecx
    14f5:	89 c8                	mov    %ecx,%eax
    14f7:	01 c0                	add    %eax,%eax
    14f9:	01 c8                	add    %ecx,%eax
    14fb:	01 d0                	add    %edx,%eax
    14fd:	0f b7 10             	movzwl (%eax),%edx
    1500:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1504:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1508:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    150b:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    150f:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1513:	38 c2                	cmp    %al,%dl
    1515:	75 18                	jne    152f <APDcCopy+0x154>
    1517:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    151b:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    151f:	38 c2                	cmp    %al,%dl
    1521:	75 0c                	jne    152f <APDcCopy+0x154>
    1523:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1527:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    152b:	38 c2                	cmp    %al,%dl
    152d:	74 26                	je     1555 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    152f:	8b 45 08             	mov    0x8(%ebp),%eax
    1532:	8b 50 18             	mov    0x18(%eax),%edx
    1535:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1538:	8b 45 f0             	mov    -0x10(%ebp),%eax
    153b:	01 c8                	add    %ecx,%eax
    153d:	89 c1                	mov    %eax,%ecx
    153f:	89 c8                	mov    %ecx,%eax
    1541:	01 c0                	add    %eax,%eax
    1543:	01 c8                	add    %ecx,%eax
    1545:	01 d0                	add    %edx,%eax
    1547:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    154b:	66 89 10             	mov    %dx,(%eax)
    154e:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1552:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1555:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1559:	8b 45 fc             	mov    -0x4(%ebp),%eax
    155c:	2b 45 0c             	sub    0xc(%ebp),%eax
    155f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1562:	7d 81                	jge    14e5 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1564:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1568:	8b 45 f8             	mov    -0x8(%ebp),%eax
    156b:	2b 45 10             	sub    0x10(%ebp),%eax
    156e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1571:	0f 8d 35 ff ff ff    	jge    14ac <APDcCopy+0xd1>
    1577:	eb 04                	jmp    157d <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1579:	90                   	nop
    157a:	eb 01                	jmp    157d <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    157c:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    157d:	c9                   	leave  
    157e:	c3                   	ret    

0000157f <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    157f:	55                   	push   %ebp
    1580:	89 e5                	mov    %esp,%ebp
    1582:	83 ec 1c             	sub    $0x1c,%esp
    1585:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1588:	8b 55 10             	mov    0x10(%ebp),%edx
    158b:	8b 45 14             	mov    0x14(%ebp),%eax
    158e:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1591:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1594:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1597:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    159b:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    159e:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    15a2:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    15a5:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    15a9:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    15ac:	8b 45 08             	mov    0x8(%ebp),%eax
    15af:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    15b3:	66 89 10             	mov    %dx,(%eax)
    15b6:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    15ba:	88 50 02             	mov    %dl,0x2(%eax)
}
    15bd:	8b 45 08             	mov    0x8(%ebp),%eax
    15c0:	c9                   	leave  
    15c1:	c2 04 00             	ret    $0x4

000015c4 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    15c4:	55                   	push   %ebp
    15c5:	89 e5                	mov    %esp,%ebp
    15c7:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    15ca:	8b 45 08             	mov    0x8(%ebp),%eax
    15cd:	8b 00                	mov    (%eax),%eax
    15cf:	83 ec 08             	sub    $0x8,%esp
    15d2:	8d 55 0c             	lea    0xc(%ebp),%edx
    15d5:	52                   	push   %edx
    15d6:	50                   	push   %eax
    15d7:	e8 24 ee ff ff       	call   400 <sendMessage>
    15dc:	83 c4 10             	add    $0x10,%esp
}
    15df:	90                   	nop
    15e0:	c9                   	leave  
    15e1:	c3                   	ret    

000015e2 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    15e2:	55                   	push   %ebp
    15e3:	89 e5                	mov    %esp,%ebp
    15e5:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    15e8:	83 ec 0c             	sub    $0xc,%esp
    15eb:	68 9c 00 00 00       	push   $0x9c
    15f0:	e8 f5 f1 ff ff       	call   7ea <malloc>
    15f5:	83 c4 10             	add    $0x10,%esp
    15f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    15fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15ff:	75 15                	jne    1616 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1601:	83 ec 04             	sub    $0x4,%esp
    1604:	ff 75 08             	pushl  0x8(%ebp)
    1607:	68 20 26 00 00       	push   $0x2620
    160c:	6a 01                	push   $0x1
    160e:	e8 04 ef ff ff       	call   517 <printf>
    1613:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1616:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1619:	05 88 00 00 00       	add    $0x88,%eax
    161e:	83 ec 08             	sub    $0x8,%esp
    1621:	ff 75 08             	pushl  0x8(%ebp)
    1624:	50                   	push   %eax
    1625:	e8 fd ea ff ff       	call   127 <strcpy>
    162a:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    162d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1630:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1637:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163a:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1641:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1644:	8b 40 3c             	mov    0x3c(%eax),%eax
    1647:	89 c2                	mov    %eax,%edx
    1649:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164c:	8b 40 40             	mov    0x40(%eax),%eax
    164f:	0f af d0             	imul   %eax,%edx
    1652:	89 d0                	mov    %edx,%eax
    1654:	01 c0                	add    %eax,%eax
    1656:	01 d0                	add    %edx,%eax
    1658:	83 ec 0c             	sub    $0xc,%esp
    165b:	50                   	push   %eax
    165c:	e8 89 f1 ff ff       	call   7ea <malloc>
    1661:	83 c4 10             	add    $0x10,%esp
    1664:	89 c2                	mov    %eax,%edx
    1666:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1669:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    166c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166f:	8b 40 54             	mov    0x54(%eax),%eax
    1672:	85 c0                	test   %eax,%eax
    1674:	75 15                	jne    168b <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1676:	83 ec 04             	sub    $0x4,%esp
    1679:	ff 75 08             	pushl  0x8(%ebp)
    167c:	68 40 26 00 00       	push   $0x2640
    1681:	6a 01                	push   $0x1
    1683:	e8 8f ee ff ff       	call   517 <printf>
    1688:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    168b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168e:	8b 40 3c             	mov    0x3c(%eax),%eax
    1691:	89 c2                	mov    %eax,%edx
    1693:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1696:	8b 40 40             	mov    0x40(%eax),%eax
    1699:	0f af d0             	imul   %eax,%edx
    169c:	89 d0                	mov    %edx,%eax
    169e:	01 c0                	add    %eax,%eax
    16a0:	01 c2                	add    %eax,%edx
    16a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a5:	8b 40 54             	mov    0x54(%eax),%eax
    16a8:	83 ec 04             	sub    $0x4,%esp
    16ab:	52                   	push   %edx
    16ac:	68 ff ff ff 00       	push   $0xffffff
    16b1:	50                   	push   %eax
    16b2:	e8 06 eb ff ff       	call   1bd <memset>
    16b7:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    16ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16bd:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    16c4:	e8 0f ed ff ff       	call   3d8 <getpid>
    16c9:	89 c2                	mov    %eax,%edx
    16cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ce:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    16d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d4:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    16db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16de:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    16e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e8:	8b 40 58             	mov    0x58(%eax),%eax
    16eb:	89 c2                	mov    %eax,%edx
    16ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f0:	8b 40 5c             	mov    0x5c(%eax),%eax
    16f3:	0f af d0             	imul   %eax,%edx
    16f6:	89 d0                	mov    %edx,%eax
    16f8:	01 c0                	add    %eax,%eax
    16fa:	01 d0                	add    %edx,%eax
    16fc:	83 ec 0c             	sub    $0xc,%esp
    16ff:	50                   	push   %eax
    1700:	e8 e5 f0 ff ff       	call   7ea <malloc>
    1705:	83 c4 10             	add    $0x10,%esp
    1708:	89 c2                	mov    %eax,%edx
    170a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170d:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1710:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1713:	8b 40 70             	mov    0x70(%eax),%eax
    1716:	85 c0                	test   %eax,%eax
    1718:	75 15                	jne    172f <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    171a:	83 ec 04             	sub    $0x4,%esp
    171d:	ff 75 08             	pushl  0x8(%ebp)
    1720:	68 64 26 00 00       	push   $0x2664
    1725:	6a 01                	push   $0x1
    1727:	e8 eb ed ff ff       	call   517 <printf>
    172c:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    172f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1732:	8b 40 3c             	mov    0x3c(%eax),%eax
    1735:	89 c2                	mov    %eax,%edx
    1737:	8b 45 f4             	mov    -0xc(%ebp),%eax
    173a:	8b 40 40             	mov    0x40(%eax),%eax
    173d:	0f af d0             	imul   %eax,%edx
    1740:	89 d0                	mov    %edx,%eax
    1742:	01 c0                	add    %eax,%eax
    1744:	01 c2                	add    %eax,%edx
    1746:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1749:	8b 40 54             	mov    0x54(%eax),%eax
    174c:	83 ec 04             	sub    $0x4,%esp
    174f:	52                   	push   %edx
    1750:	68 ff 00 00 00       	push   $0xff
    1755:	50                   	push   %eax
    1756:	e8 62 ea ff ff       	call   1bd <memset>
    175b:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    175e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1761:	8b 55 0c             	mov    0xc(%ebp),%edx
    1764:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1767:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    176b:	74 49                	je     17b6 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    176d:	8b 45 10             	mov    0x10(%ebp),%eax
    1770:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1776:	83 ec 0c             	sub    $0xc,%esp
    1779:	50                   	push   %eax
    177a:	e8 6b f0 ff ff       	call   7ea <malloc>
    177f:	83 c4 10             	add    $0x10,%esp
    1782:	89 c2                	mov    %eax,%edx
    1784:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1787:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    178a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178d:	8b 55 10             	mov    0x10(%ebp),%edx
    1790:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1793:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1796:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    179d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a0:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    17a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17aa:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    17b1:	e9 8d 00 00 00       	jmp    1843 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    17b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b9:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    17c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c3:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    17ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17cd:	8b 40 20             	mov    0x20(%eax),%eax
    17d0:	89 c2                	mov    %eax,%edx
    17d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d5:	8b 40 24             	mov    0x24(%eax),%eax
    17d8:	0f af d0             	imul   %eax,%edx
    17db:	89 d0                	mov    %edx,%eax
    17dd:	01 c0                	add    %eax,%eax
    17df:	01 d0                	add    %edx,%eax
    17e1:	83 ec 0c             	sub    $0xc,%esp
    17e4:	50                   	push   %eax
    17e5:	e8 00 f0 ff ff       	call   7ea <malloc>
    17ea:	83 c4 10             	add    $0x10,%esp
    17ed:	89 c2                	mov    %eax,%edx
    17ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f2:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    17f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f8:	8b 40 38             	mov    0x38(%eax),%eax
    17fb:	85 c0                	test   %eax,%eax
    17fd:	75 15                	jne    1814 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    17ff:	83 ec 04             	sub    $0x4,%esp
    1802:	ff 75 08             	pushl  0x8(%ebp)
    1805:	68 8c 26 00 00       	push   $0x268c
    180a:	6a 01                	push   $0x1
    180c:	e8 06 ed ff ff       	call   517 <printf>
    1811:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1814:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1817:	8b 40 20             	mov    0x20(%eax),%eax
    181a:	89 c2                	mov    %eax,%edx
    181c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181f:	8b 40 24             	mov    0x24(%eax),%eax
    1822:	0f af d0             	imul   %eax,%edx
    1825:	89 d0                	mov    %edx,%eax
    1827:	01 c0                	add    %eax,%eax
    1829:	01 c2                	add    %eax,%edx
    182b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182e:	8b 40 38             	mov    0x38(%eax),%eax
    1831:	83 ec 04             	sub    $0x4,%esp
    1834:	52                   	push   %edx
    1835:	68 ff ff ff 00       	push   $0xffffff
    183a:	50                   	push   %eax
    183b:	e8 7d e9 ff ff       	call   1bd <memset>
    1840:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1843:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1846:	c9                   	leave  
    1847:	c3                   	ret    

00001848 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1848:	55                   	push   %ebp
    1849:	89 e5                	mov    %esp,%ebp
    184b:	57                   	push   %edi
    184c:	56                   	push   %esi
    184d:	53                   	push   %ebx
    184e:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1851:	8b 45 0c             	mov    0xc(%ebp),%eax
    1854:	83 f8 03             	cmp    $0x3,%eax
    1857:	74 0e                	je     1867 <APWndProc+0x1f>
    1859:	83 f8 0a             	cmp    $0xa,%eax
    185c:	0f 84 82 00 00 00    	je     18e4 <APWndProc+0x9c>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            break;
        default: break;
    1862:	e9 cb 00 00 00       	jmp    1932 <APWndProc+0xea>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1867:	8b 45 08             	mov    0x8(%ebp),%eax
    186a:	8b 58 1c             	mov    0x1c(%eax),%ebx
    186d:	8b 45 08             	mov    0x8(%ebp),%eax
    1870:	8b 48 18             	mov    0x18(%eax),%ecx
    1873:	8b 45 08             	mov    0x8(%ebp),%eax
    1876:	8b 50 5c             	mov    0x5c(%eax),%edx
    1879:	8b 45 08             	mov    0x8(%ebp),%eax
    187c:	8b 40 58             	mov    0x58(%eax),%eax
    187f:	8b 75 08             	mov    0x8(%ebp),%esi
    1882:	83 c6 58             	add    $0x58,%esi
    1885:	83 ec 04             	sub    $0x4,%esp
    1888:	53                   	push   %ebx
    1889:	51                   	push   %ecx
    188a:	6a 00                	push   $0x0
    188c:	52                   	push   %edx
    188d:	50                   	push   %eax
    188e:	6a 00                	push   $0x0
    1890:	6a 00                	push   $0x0
    1892:	56                   	push   %esi
    1893:	6a 00                	push   $0x0
    1895:	6a 00                	push   $0x0
    1897:	ff 75 08             	pushl  0x8(%ebp)
    189a:	e8 59 eb ff ff       	call   3f8 <paintWindow>
    189f:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    18a2:	8b 45 08             	mov    0x8(%ebp),%eax
    18a5:	8b 70 1c             	mov    0x1c(%eax),%esi
    18a8:	8b 45 08             	mov    0x8(%ebp),%eax
    18ab:	8b 58 18             	mov    0x18(%eax),%ebx
    18ae:	8b 45 08             	mov    0x8(%ebp),%eax
    18b1:	8b 48 08             	mov    0x8(%eax),%ecx
    18b4:	8b 45 08             	mov    0x8(%ebp),%eax
    18b7:	8b 50 40             	mov    0x40(%eax),%edx
    18ba:	8b 45 08             	mov    0x8(%ebp),%eax
    18bd:	8b 40 3c             	mov    0x3c(%eax),%eax
    18c0:	8b 7d 08             	mov    0x8(%ebp),%edi
    18c3:	83 c7 3c             	add    $0x3c,%edi
    18c6:	83 ec 04             	sub    $0x4,%esp
    18c9:	56                   	push   %esi
    18ca:	53                   	push   %ebx
    18cb:	51                   	push   %ecx
    18cc:	52                   	push   %edx
    18cd:	50                   	push   %eax
    18ce:	6a 00                	push   $0x0
    18d0:	6a 00                	push   $0x0
    18d2:	57                   	push   %edi
    18d3:	6a 32                	push   $0x32
    18d5:	6a 00                	push   $0x0
    18d7:	ff 75 08             	pushl  0x8(%ebp)
    18da:	e8 19 eb ff ff       	call   3f8 <paintWindow>
    18df:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    18e2:	eb 4e                	jmp    1932 <APWndProc+0xea>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
    18e4:	8b 45 18             	mov    0x18(%ebp),%eax
    18e7:	83 ec 08             	sub    $0x8,%esp
    18ea:	50                   	push   %eax
    18eb:	ff 75 08             	pushl  0x8(%ebp)
    18ee:	e8 19 08 00 00       	call   210c <updateword>
    18f3:	83 c4 10             	add    $0x10,%esp
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    18f6:	8b 45 08             	mov    0x8(%ebp),%eax
    18f9:	8b 58 1c             	mov    0x1c(%eax),%ebx
    18fc:	8b 45 08             	mov    0x8(%ebp),%eax
    18ff:	8b 48 18             	mov    0x18(%eax),%ecx
    1902:	8b 45 08             	mov    0x8(%ebp),%eax
    1905:	8b 50 5c             	mov    0x5c(%eax),%edx
    1908:	8b 45 08             	mov    0x8(%ebp),%eax
    190b:	8b 40 58             	mov    0x58(%eax),%eax
    190e:	8b 75 08             	mov    0x8(%ebp),%esi
    1911:	83 c6 58             	add    $0x58,%esi
    1914:	83 ec 04             	sub    $0x4,%esp
    1917:	53                   	push   %ebx
    1918:	51                   	push   %ecx
    1919:	6a 00                	push   $0x0
    191b:	52                   	push   %edx
    191c:	50                   	push   %eax
    191d:	6a 00                	push   $0x0
    191f:	6a 00                	push   $0x0
    1921:	56                   	push   %esi
    1922:	6a 00                	push   $0x0
    1924:	6a 00                	push   $0x0
    1926:	ff 75 08             	pushl  0x8(%ebp)
    1929:	e8 ca ea ff ff       	call   3f8 <paintWindow>
    192e:	83 c4 30             	add    $0x30,%esp
            break;
    1931:	90                   	nop
        default: break;
            
            
    }
    return False;
    1932:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1937:	8d 65 f4             	lea    -0xc(%ebp),%esp
    193a:	5b                   	pop    %ebx
    193b:	5e                   	pop    %esi
    193c:	5f                   	pop    %edi
    193d:	5d                   	pop    %ebp
    193e:	c3                   	ret    

0000193f <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    193f:	55                   	push   %ebp
    1940:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1942:	8b 45 0c             	mov    0xc(%ebp),%eax
    1945:	8b 50 08             	mov    0x8(%eax),%edx
    1948:	8b 45 08             	mov    0x8(%ebp),%eax
    194b:	8b 00                	mov    (%eax),%eax
    194d:	39 c2                	cmp    %eax,%edx
    194f:	74 07                	je     1958 <APPreJudge+0x19>
        return False;
    1951:	b8 00 00 00 00       	mov    $0x0,%eax
    1956:	eb 05                	jmp    195d <APPreJudge+0x1e>
    return True;
    1958:	b8 01 00 00 00       	mov    $0x1,%eax
}
    195d:	5d                   	pop    %ebp
    195e:	c3                   	ret    

0000195f <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    195f:	55                   	push   %ebp
    1960:	89 e5                	mov    %esp,%ebp
    1962:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1965:	8b 45 08             	mov    0x8(%ebp),%eax
    1968:	8b 55 0c             	mov    0xc(%ebp),%edx
    196b:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
    //--------add window to list
    registWindow(hwnd);
    1971:	83 ec 0c             	sub    $0xc,%esp
    1974:	ff 75 08             	pushl  0x8(%ebp)
    1977:	e8 94 ea ff ff       	call   410 <registWindow>
    197c:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    197f:	c7 45 e8 02 00 00 00 	movl   $0x2,-0x18(%ebp)
    msg.wndID = hwnd->id;
    1986:	8b 45 08             	mov    0x8(%ebp),%eax
    1989:	8b 00                	mov    (%eax),%eax
    198b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    APSendMessage(hwnd,msg);
    198e:	83 ec 0c             	sub    $0xc,%esp
    1991:	ff 75 f4             	pushl  -0xc(%ebp)
    1994:	ff 75 f0             	pushl  -0x10(%ebp)
    1997:	ff 75 ec             	pushl  -0x14(%ebp)
    199a:	ff 75 e8             	pushl  -0x18(%ebp)
    199d:	ff 75 08             	pushl  0x8(%ebp)
    19a0:	e8 1f fc ff ff       	call   15c4 <APSendMessage>
    19a5:	83 c4 20             	add    $0x20,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    19a8:	83 ec 0c             	sub    $0xc,%esp
    19ab:	ff 75 08             	pushl  0x8(%ebp)
    19ae:	e8 55 ea ff ff       	call   408 <getMessage>
    19b3:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    19b6:	8b 45 08             	mov    0x8(%ebp),%eax
    19b9:	83 c0 74             	add    $0x74,%eax
    19bc:	83 ec 08             	sub    $0x8,%esp
    19bf:	50                   	push   %eax
    19c0:	ff 75 08             	pushl  0x8(%ebp)
    19c3:	e8 77 ff ff ff       	call   193f <APPreJudge>
    19c8:	83 c4 10             	add    $0x10,%esp
    19cb:	84 c0                	test   %al,%al
    19cd:	74 24                	je     19f3 <APWndExec+0x94>
            if (wndProc(hwnd, hwnd->msg))
    19cf:	83 ec 0c             	sub    $0xc,%esp
    19d2:	8b 45 08             	mov    0x8(%ebp),%eax
    19d5:	ff b0 80 00 00 00    	pushl  0x80(%eax)
    19db:	ff 70 7c             	pushl  0x7c(%eax)
    19de:	ff 70 78             	pushl  0x78(%eax)
    19e1:	ff 70 74             	pushl  0x74(%eax)
    19e4:	ff 75 08             	pushl  0x8(%ebp)
    19e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    19ea:	ff d0                	call   *%eax
    19ec:	83 c4 20             	add    $0x20,%esp
    19ef:	84 c0                	test   %al,%al
    19f1:	75 0c                	jne    19ff <APWndExec+0xa0>
                break;
        hwnd->msg.type = MSG_NULL;
    19f3:	8b 45 08             	mov    0x8(%ebp),%eax
    19f6:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    19fd:	eb a9                	jmp    19a8 <APWndExec+0x49>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    19ff:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1a00:	90                   	nop
    1a01:	c9                   	leave  
    1a02:	c3                   	ret    

00001a03 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1a03:	55                   	push   %ebp
    1a04:	89 e5                	mov    %esp,%ebp
    1a06:	57                   	push   %edi
    1a07:	56                   	push   %esi
    1a08:	53                   	push   %ebx
    1a09:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1a0c:	a1 a4 69 00 00       	mov    0x69a4,%eax
    1a11:	85 c0                	test   %eax,%eax
    1a13:	0f 85 7a 02 00 00    	jne    1c93 <APGridPaint+0x290>
    {
        iconReady = 1;
    1a19:	c7 05 a4 69 00 00 01 	movl   $0x1,0x69a4
    1a20:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1a23:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a26:	83 ec 08             	sub    $0x8,%esp
    1a29:	68 b3 26 00 00       	push   $0x26b3
    1a2e:	50                   	push   %eax
    1a2f:	e8 69 ef ff ff       	call   99d <APLoadBitmap>
    1a34:	83 c4 0c             	add    $0xc,%esp
    1a37:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a3a:	a3 c8 69 00 00       	mov    %eax,0x69c8
    1a3f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a42:	a3 cc 69 00 00       	mov    %eax,0x69cc
    1a47:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a4a:	a3 d0 69 00 00       	mov    %eax,0x69d0
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1a4f:	83 ec 04             	sub    $0x4,%esp
    1a52:	ff 35 d0 69 00 00    	pushl  0x69d0
    1a58:	ff 35 cc 69 00 00    	pushl  0x69cc
    1a5e:	ff 35 c8 69 00 00    	pushl  0x69c8
    1a64:	e8 6e f1 ff ff       	call   bd7 <APCreateCompatibleDCFromBitmap>
    1a69:	83 c4 10             	add    $0x10,%esp
    1a6c:	a3 d4 69 00 00       	mov    %eax,0x69d4
        grid_river = APLoadBitmap ("grid_river.bmp");
    1a71:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a74:	83 ec 08             	sub    $0x8,%esp
    1a77:	68 c1 26 00 00       	push   $0x26c1
    1a7c:	50                   	push   %eax
    1a7d:	e8 1b ef ff ff       	call   99d <APLoadBitmap>
    1a82:	83 c4 0c             	add    $0xc,%esp
    1a85:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a88:	a3 10 6a 00 00       	mov    %eax,0x6a10
    1a8d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a90:	a3 14 6a 00 00       	mov    %eax,0x6a14
    1a95:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a98:	a3 18 6a 00 00       	mov    %eax,0x6a18
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1a9d:	83 ec 04             	sub    $0x4,%esp
    1aa0:	ff 35 18 6a 00 00    	pushl  0x6a18
    1aa6:	ff 35 14 6a 00 00    	pushl  0x6a14
    1aac:	ff 35 10 6a 00 00    	pushl  0x6a10
    1ab2:	e8 20 f1 ff ff       	call   bd7 <APCreateCompatibleDCFromBitmap>
    1ab7:	83 c4 10             	add    $0x10,%esp
    1aba:	a3 00 6a 00 00       	mov    %eax,0x6a00
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1abf:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ac2:	83 ec 08             	sub    $0x8,%esp
    1ac5:	68 d0 26 00 00       	push   $0x26d0
    1aca:	50                   	push   %eax
    1acb:	e8 cd ee ff ff       	call   99d <APLoadBitmap>
    1ad0:	83 c4 0c             	add    $0xc,%esp
    1ad3:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ad6:	a3 04 6a 00 00       	mov    %eax,0x6a04
    1adb:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1ade:	a3 08 6a 00 00       	mov    %eax,0x6a08
    1ae3:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ae6:	a3 0c 6a 00 00       	mov    %eax,0x6a0c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1aeb:	83 ec 04             	sub    $0x4,%esp
    1aee:	ff 35 0c 6a 00 00    	pushl  0x6a0c
    1af4:	ff 35 08 6a 00 00    	pushl  0x6a08
    1afa:	ff 35 04 6a 00 00    	pushl  0x6a04
    1b00:	e8 d2 f0 ff ff       	call   bd7 <APCreateCompatibleDCFromBitmap>
    1b05:	83 c4 10             	add    $0x10,%esp
    1b08:	a3 a8 69 00 00       	mov    %eax,0x69a8
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1b0d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b10:	83 ec 08             	sub    $0x8,%esp
    1b13:	68 df 26 00 00       	push   $0x26df
    1b18:	50                   	push   %eax
    1b19:	e8 7f ee ff ff       	call   99d <APLoadBitmap>
    1b1e:	83 c4 0c             	add    $0xc,%esp
    1b21:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b24:	a3 dc 69 00 00       	mov    %eax,0x69dc
    1b29:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b2c:	a3 e0 69 00 00       	mov    %eax,0x69e0
    1b31:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b34:	a3 e4 69 00 00       	mov    %eax,0x69e4
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1b39:	83 ec 04             	sub    $0x4,%esp
    1b3c:	ff 35 e4 69 00 00    	pushl  0x69e4
    1b42:	ff 35 e0 69 00 00    	pushl  0x69e0
    1b48:	ff 35 dc 69 00 00    	pushl  0x69dc
    1b4e:	e8 84 f0 ff ff       	call   bd7 <APCreateCompatibleDCFromBitmap>
    1b53:	83 c4 10             	add    $0x10,%esp
    1b56:	a3 20 6a 00 00       	mov    %eax,0x6a20
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1b5b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b5e:	83 ec 08             	sub    $0x8,%esp
    1b61:	68 ed 26 00 00       	push   $0x26ed
    1b66:	50                   	push   %eax
    1b67:	e8 31 ee ff ff       	call   99d <APLoadBitmap>
    1b6c:	83 c4 0c             	add    $0xc,%esp
    1b6f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b72:	a3 b8 69 00 00       	mov    %eax,0x69b8
    1b77:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b7a:	a3 bc 69 00 00       	mov    %eax,0x69bc
    1b7f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b82:	a3 c0 69 00 00       	mov    %eax,0x69c0
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1b87:	83 ec 04             	sub    $0x4,%esp
    1b8a:	ff 35 c0 69 00 00    	pushl  0x69c0
    1b90:	ff 35 bc 69 00 00    	pushl  0x69bc
    1b96:	ff 35 b8 69 00 00    	pushl  0x69b8
    1b9c:	e8 36 f0 ff ff       	call   bd7 <APCreateCompatibleDCFromBitmap>
    1ba1:	83 c4 10             	add    $0x10,%esp
    1ba4:	a3 d8 69 00 00       	mov    %eax,0x69d8
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1ba9:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bac:	83 ec 08             	sub    $0x8,%esp
    1baf:	68 fd 26 00 00       	push   $0x26fd
    1bb4:	50                   	push   %eax
    1bb5:	e8 e3 ed ff ff       	call   99d <APLoadBitmap>
    1bba:	83 c4 0c             	add    $0xc,%esp
    1bbd:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bc0:	a3 ac 69 00 00       	mov    %eax,0x69ac
    1bc5:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1bc8:	a3 b0 69 00 00       	mov    %eax,0x69b0
    1bcd:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bd0:	a3 b4 69 00 00       	mov    %eax,0x69b4
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1bd5:	83 ec 04             	sub    $0x4,%esp
    1bd8:	ff 35 b4 69 00 00    	pushl  0x69b4
    1bde:	ff 35 b0 69 00 00    	pushl  0x69b0
    1be4:	ff 35 ac 69 00 00    	pushl  0x69ac
    1bea:	e8 e8 ef ff ff       	call   bd7 <APCreateCompatibleDCFromBitmap>
    1bef:	83 c4 10             	add    $0x10,%esp
    1bf2:	a3 c4 69 00 00       	mov    %eax,0x69c4
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1bf7:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bfa:	83 ec 08             	sub    $0x8,%esp
    1bfd:	68 0f 27 00 00       	push   $0x270f
    1c02:	50                   	push   %eax
    1c03:	e8 95 ed ff ff       	call   99d <APLoadBitmap>
    1c08:	83 c4 0c             	add    $0xc,%esp
    1c0b:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c0e:	a3 f4 69 00 00       	mov    %eax,0x69f4
    1c13:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c16:	a3 f8 69 00 00       	mov    %eax,0x69f8
    1c1b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c1e:	a3 fc 69 00 00       	mov    %eax,0x69fc
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1c23:	83 ec 04             	sub    $0x4,%esp
    1c26:	ff 35 fc 69 00 00    	pushl  0x69fc
    1c2c:	ff 35 f8 69 00 00    	pushl  0x69f8
    1c32:	ff 35 f4 69 00 00    	pushl  0x69f4
    1c38:	e8 9a ef ff ff       	call   bd7 <APCreateCompatibleDCFromBitmap>
    1c3d:	83 c4 10             	add    $0x10,%esp
    1c40:	a3 24 6a 00 00       	mov    %eax,0x6a24
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    1c45:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c48:	83 ec 08             	sub    $0x8,%esp
    1c4b:	68 1e 27 00 00       	push   $0x271e
    1c50:	50                   	push   %eax
    1c51:	e8 47 ed ff ff       	call   99d <APLoadBitmap>
    1c56:	83 c4 0c             	add    $0xc,%esp
    1c59:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c5c:	a3 e8 69 00 00       	mov    %eax,0x69e8
    1c61:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c64:	a3 ec 69 00 00       	mov    %eax,0x69ec
    1c69:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c6c:	a3 f0 69 00 00       	mov    %eax,0x69f0
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    1c71:	83 ec 04             	sub    $0x4,%esp
    1c74:	ff 35 f0 69 00 00    	pushl  0x69f0
    1c7a:	ff 35 ec 69 00 00    	pushl  0x69ec
    1c80:	ff 35 e8 69 00 00    	pushl  0x69e8
    1c86:	e8 4c ef ff ff       	call   bd7 <APCreateCompatibleDCFromBitmap>
    1c8b:	83 c4 10             	add    $0x10,%esp
    1c8e:	a3 1c 6a 00 00       	mov    %eax,0x6a1c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1c93:	8b 45 08             	mov    0x8(%ebp),%eax
    1c96:	8b 40 08             	mov    0x8(%eax),%eax
    1c99:	85 c0                	test   %eax,%eax
    1c9b:	75 17                	jne    1cb4 <APGridPaint+0x2b1>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1c9d:	83 ec 08             	sub    $0x8,%esp
    1ca0:	68 30 27 00 00       	push   $0x2730
    1ca5:	6a 01                	push   $0x1
    1ca7:	e8 6b e8 ff ff       	call   517 <printf>
    1cac:	83 c4 10             	add    $0x10,%esp
        return;
    1caf:	e9 50 04 00 00       	jmp    2104 <APGridPaint+0x701>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1cb4:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb7:	8b 40 10             	mov    0x10(%eax),%eax
    1cba:	85 c0                	test   %eax,%eax
    1cbc:	7e 10                	jle    1cce <APGridPaint+0x2cb>
    1cbe:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc1:	8b 50 14             	mov    0x14(%eax),%edx
    1cc4:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc7:	8b 40 10             	mov    0x10(%eax),%eax
    1cca:	39 c2                	cmp    %eax,%edx
    1ccc:	7c 17                	jl     1ce5 <APGridPaint+0x2e2>
    {
        printf(1,"Grid mode page error!");
    1cce:	83 ec 08             	sub    $0x8,%esp
    1cd1:	68 56 27 00 00       	push   $0x2756
    1cd6:	6a 01                	push   $0x1
    1cd8:	e8 3a e8 ff ff       	call   517 <printf>
    1cdd:	83 c4 10             	add    $0x10,%esp
        return;
    1ce0:	e9 1f 04 00 00       	jmp    2104 <APGridPaint+0x701>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1ce5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce8:	8b 40 14             	mov    0x14(%eax),%eax
    1ceb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1cf1:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1cf4:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1cf7:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1cfa:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1d01:	e9 f4 03 00 00       	jmp    20fa <APGridPaint+0x6f7>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d06:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1d0d:	e9 da 03 00 00       	jmp    20ec <APGridPaint+0x6e9>
        {
            index = start + GRID_W_NUMBER * j + i;
    1d12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d15:	c1 e0 04             	shl    $0x4,%eax
    1d18:	89 c2                	mov    %eax,%edx
    1d1a:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1d1d:	01 c2                	add    %eax,%edx
    1d1f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d22:	01 d0                	add    %edx,%eax
    1d24:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1d27:	8b 45 08             	mov    0x8(%ebp),%eax
    1d2a:	8b 40 0c             	mov    0xc(%eax),%eax
    1d2d:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1d30:	c1 e2 02             	shl    $0x2,%edx
    1d33:	01 d0                	add    %edx,%eax
    1d35:	8b 00                	mov    (%eax),%eax
    1d37:	83 f8 0a             	cmp    $0xa,%eax
    1d3a:	0f 87 a7 03 00 00    	ja     20e7 <APGridPaint+0x6e4>
    1d40:	8b 04 85 6c 27 00 00 	mov    0x276c(,%eax,4),%eax
    1d47:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d49:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1d4c:	6a 0c                	push   $0xc
    1d4e:	6a 0c                	push   $0xc
    1d50:	6a 0c                	push   $0xc
    1d52:	50                   	push   %eax
    1d53:	e8 27 f8 ff ff       	call   157f <RGB>
    1d58:	83 c4 0c             	add    $0xc,%esp
    1d5b:	8b 1d d4 69 00 00    	mov    0x69d4,%ebx
    1d61:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d64:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d67:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d6a:	6b c0 32             	imul   $0x32,%eax,%eax
    1d6d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d70:	8b 45 08             	mov    0x8(%ebp),%eax
    1d73:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d76:	83 ec 0c             	sub    $0xc,%esp
    1d79:	83 ec 04             	sub    $0x4,%esp
    1d7c:	89 e0                	mov    %esp,%eax
    1d7e:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    1d82:	66 89 30             	mov    %si,(%eax)
    1d85:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    1d89:	88 50 02             	mov    %dl,0x2(%eax)
    1d8c:	6a 32                	push   $0x32
    1d8e:	6a 32                	push   $0x32
    1d90:	6a 00                	push   $0x0
    1d92:	6a 00                	push   $0x0
    1d94:	53                   	push   %ebx
    1d95:	51                   	push   %ecx
    1d96:	ff 75 94             	pushl  -0x6c(%ebp)
    1d99:	57                   	push   %edi
    1d9a:	e8 3c f6 ff ff       	call   13db <APDcCopy>
    1d9f:	83 c4 30             	add    $0x30,%esp
                    break;
    1da2:	e9 41 03 00 00       	jmp    20e8 <APGridPaint+0x6e5>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1da7:	8d 45 98             	lea    -0x68(%ebp),%eax
    1daa:	6a 69                	push   $0x69
    1dac:	6a 69                	push   $0x69
    1dae:	6a 69                	push   $0x69
    1db0:	50                   	push   %eax
    1db1:	e8 c9 f7 ff ff       	call   157f <RGB>
    1db6:	83 c4 0c             	add    $0xc,%esp
    1db9:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1dbd:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1dc1:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1dc5:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1dc8:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1dcf:	8d 45 98             	lea    -0x68(%ebp),%eax
    1dd2:	6a 69                	push   $0x69
    1dd4:	6a 69                	push   $0x69
    1dd6:	6a 69                	push   $0x69
    1dd8:	50                   	push   %eax
    1dd9:	e8 a1 f7 ff ff       	call   157f <RGB>
    1dde:	83 c4 0c             	add    $0xc,%esp
    1de1:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1de5:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1de9:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ded:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1df0:	8b 45 08             	mov    0x8(%ebp),%eax
    1df3:	8d 50 3c             	lea    0x3c(%eax),%edx
    1df6:	8d 45 98             	lea    -0x68(%ebp),%eax
    1df9:	ff 75 bc             	pushl  -0x44(%ebp)
    1dfc:	ff 75 b8             	pushl  -0x48(%ebp)
    1dff:	52                   	push   %edx
    1e00:	50                   	push   %eax
    1e01:	e8 66 ee ff ff       	call   c6c <APSetPen>
    1e06:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1e09:	8b 45 08             	mov    0x8(%ebp),%eax
    1e0c:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1e0f:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e12:	83 ec 04             	sub    $0x4,%esp
    1e15:	83 ec 04             	sub    $0x4,%esp
    1e18:	89 e0                	mov    %esp,%eax
    1e1a:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1e1e:	66 89 08             	mov    %cx,(%eax)
    1e21:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1e25:	88 48 02             	mov    %cl,0x2(%eax)
    1e28:	53                   	push   %ebx
    1e29:	52                   	push   %edx
    1e2a:	e8 76 ee ff ff       	call   ca5 <APSetBrush>
    1e2f:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1e32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e35:	6b d0 32             	imul   $0x32,%eax,%edx
    1e38:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e3b:	6b c0 32             	imul   $0x32,%eax,%eax
    1e3e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1e41:	83 c1 3c             	add    $0x3c,%ecx
    1e44:	83 ec 0c             	sub    $0xc,%esp
    1e47:	6a 32                	push   $0x32
    1e49:	6a 32                	push   $0x32
    1e4b:	52                   	push   %edx
    1e4c:	50                   	push   %eax
    1e4d:	51                   	push   %ecx
    1e4e:	e8 7c f2 ff ff       	call   10cf <APDrawRect>
    1e53:	83 c4 20             	add    $0x20,%esp
                    break;
    1e56:	e9 8d 02 00 00       	jmp    20e8 <APGridPaint+0x6e5>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e5b:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1e5e:	6a 0c                	push   $0xc
    1e60:	6a 0c                	push   $0xc
    1e62:	6a 0c                	push   $0xc
    1e64:	50                   	push   %eax
    1e65:	e8 15 f7 ff ff       	call   157f <RGB>
    1e6a:	83 c4 0c             	add    $0xc,%esp
    1e6d:	8b 1d 24 6a 00 00    	mov    0x6a24,%ebx
    1e73:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e76:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e79:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e7c:	6b c0 32             	imul   $0x32,%eax,%eax
    1e7f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e82:	8b 45 08             	mov    0x8(%ebp),%eax
    1e85:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e88:	83 ec 0c             	sub    $0xc,%esp
    1e8b:	83 ec 04             	sub    $0x4,%esp
    1e8e:	89 e0                	mov    %esp,%eax
    1e90:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1e94:	66 89 30             	mov    %si,(%eax)
    1e97:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1e9b:	88 50 02             	mov    %dl,0x2(%eax)
    1e9e:	6a 32                	push   $0x32
    1ea0:	6a 32                	push   $0x32
    1ea2:	6a 00                	push   $0x0
    1ea4:	6a 00                	push   $0x0
    1ea6:	53                   	push   %ebx
    1ea7:	51                   	push   %ecx
    1ea8:	ff 75 94             	pushl  -0x6c(%ebp)
    1eab:	57                   	push   %edi
    1eac:	e8 2a f5 ff ff       	call   13db <APDcCopy>
    1eb1:	83 c4 30             	add    $0x30,%esp
                    break;
    1eb4:	e9 2f 02 00 00       	jmp    20e8 <APGridPaint+0x6e5>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1eb9:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1ebc:	6a 0c                	push   $0xc
    1ebe:	6a 0c                	push   $0xc
    1ec0:	6a 0c                	push   $0xc
    1ec2:	50                   	push   %eax
    1ec3:	e8 b7 f6 ff ff       	call   157f <RGB>
    1ec8:	83 c4 0c             	add    $0xc,%esp
    1ecb:	8b 1d 00 6a 00 00    	mov    0x6a00,%ebx
    1ed1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ed4:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ed7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1eda:	6b c0 32             	imul   $0x32,%eax,%eax
    1edd:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ee0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee3:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ee6:	83 ec 0c             	sub    $0xc,%esp
    1ee9:	83 ec 04             	sub    $0x4,%esp
    1eec:	89 e0                	mov    %esp,%eax
    1eee:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1ef2:	66 89 30             	mov    %si,(%eax)
    1ef5:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1ef9:	88 50 02             	mov    %dl,0x2(%eax)
    1efc:	6a 32                	push   $0x32
    1efe:	6a 32                	push   $0x32
    1f00:	6a 00                	push   $0x0
    1f02:	6a 00                	push   $0x0
    1f04:	53                   	push   %ebx
    1f05:	51                   	push   %ecx
    1f06:	ff 75 94             	pushl  -0x6c(%ebp)
    1f09:	57                   	push   %edi
    1f0a:	e8 cc f4 ff ff       	call   13db <APDcCopy>
    1f0f:	83 c4 30             	add    $0x30,%esp
                    break;
    1f12:	e9 d1 01 00 00       	jmp    20e8 <APGridPaint+0x6e5>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f17:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1f1a:	6a 0c                	push   $0xc
    1f1c:	6a 0c                	push   $0xc
    1f1e:	6a 0c                	push   $0xc
    1f20:	50                   	push   %eax
    1f21:	e8 59 f6 ff ff       	call   157f <RGB>
    1f26:	83 c4 0c             	add    $0xc,%esp
    1f29:	8b 1d d8 69 00 00    	mov    0x69d8,%ebx
    1f2f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f32:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f35:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f38:	6b c0 32             	imul   $0x32,%eax,%eax
    1f3b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f41:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f44:	83 ec 0c             	sub    $0xc,%esp
    1f47:	83 ec 04             	sub    $0x4,%esp
    1f4a:	89 e0                	mov    %esp,%eax
    1f4c:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1f50:	66 89 30             	mov    %si,(%eax)
    1f53:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1f57:	88 50 02             	mov    %dl,0x2(%eax)
    1f5a:	6a 32                	push   $0x32
    1f5c:	6a 32                	push   $0x32
    1f5e:	6a 00                	push   $0x0
    1f60:	6a 00                	push   $0x0
    1f62:	53                   	push   %ebx
    1f63:	51                   	push   %ecx
    1f64:	ff 75 94             	pushl  -0x6c(%ebp)
    1f67:	57                   	push   %edi
    1f68:	e8 6e f4 ff ff       	call   13db <APDcCopy>
    1f6d:	83 c4 30             	add    $0x30,%esp
                    break;
    1f70:	e9 73 01 00 00       	jmp    20e8 <APGridPaint+0x6e5>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f75:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1f78:	6a 0c                	push   $0xc
    1f7a:	6a 0c                	push   $0xc
    1f7c:	6a 0c                	push   $0xc
    1f7e:	50                   	push   %eax
    1f7f:	e8 fb f5 ff ff       	call   157f <RGB>
    1f84:	83 c4 0c             	add    $0xc,%esp
    1f87:	8b 1d 20 6a 00 00    	mov    0x6a20,%ebx
    1f8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f90:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f93:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f96:	6b c0 32             	imul   $0x32,%eax,%eax
    1f99:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f9c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f9f:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fa2:	83 ec 0c             	sub    $0xc,%esp
    1fa5:	83 ec 04             	sub    $0x4,%esp
    1fa8:	89 e0                	mov    %esp,%eax
    1faa:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1fae:	66 89 30             	mov    %si,(%eax)
    1fb1:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1fb5:	88 50 02             	mov    %dl,0x2(%eax)
    1fb8:	6a 32                	push   $0x32
    1fba:	6a 32                	push   $0x32
    1fbc:	6a 00                	push   $0x0
    1fbe:	6a 00                	push   $0x0
    1fc0:	53                   	push   %ebx
    1fc1:	51                   	push   %ecx
    1fc2:	ff 75 94             	pushl  -0x6c(%ebp)
    1fc5:	57                   	push   %edi
    1fc6:	e8 10 f4 ff ff       	call   13db <APDcCopy>
    1fcb:	83 c4 30             	add    $0x30,%esp
                    break;
    1fce:	e9 15 01 00 00       	jmp    20e8 <APGridPaint+0x6e5>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fd3:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1fd6:	6a 0c                	push   $0xc
    1fd8:	6a 0c                	push   $0xc
    1fda:	6a 0c                	push   $0xc
    1fdc:	50                   	push   %eax
    1fdd:	e8 9d f5 ff ff       	call   157f <RGB>
    1fe2:	83 c4 0c             	add    $0xc,%esp
    1fe5:	8b 1d a8 69 00 00    	mov    0x69a8,%ebx
    1feb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fee:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ff1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ff4:	6b c0 32             	imul   $0x32,%eax,%eax
    1ff7:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ffa:	8b 45 08             	mov    0x8(%ebp),%eax
    1ffd:	8d 78 3c             	lea    0x3c(%eax),%edi
    2000:	83 ec 0c             	sub    $0xc,%esp
    2003:	83 ec 04             	sub    $0x4,%esp
    2006:	89 e0                	mov    %esp,%eax
    2008:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    200c:	66 89 30             	mov    %si,(%eax)
    200f:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2013:	88 50 02             	mov    %dl,0x2(%eax)
    2016:	6a 32                	push   $0x32
    2018:	6a 32                	push   $0x32
    201a:	6a 00                	push   $0x0
    201c:	6a 00                	push   $0x0
    201e:	53                   	push   %ebx
    201f:	51                   	push   %ecx
    2020:	ff 75 94             	pushl  -0x6c(%ebp)
    2023:	57                   	push   %edi
    2024:	e8 b2 f3 ff ff       	call   13db <APDcCopy>
    2029:	83 c4 30             	add    $0x30,%esp
                    break;
    202c:	e9 b7 00 00 00       	jmp    20e8 <APGridPaint+0x6e5>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2031:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2034:	6a 0c                	push   $0xc
    2036:	6a 0c                	push   $0xc
    2038:	6a 0c                	push   $0xc
    203a:	50                   	push   %eax
    203b:	e8 3f f5 ff ff       	call   157f <RGB>
    2040:	83 c4 0c             	add    $0xc,%esp
    2043:	8b 1d c4 69 00 00    	mov    0x69c4,%ebx
    2049:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    204c:	6b c8 32             	imul   $0x32,%eax,%ecx
    204f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2052:	6b c0 32             	imul   $0x32,%eax,%eax
    2055:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2058:	8b 45 08             	mov    0x8(%ebp),%eax
    205b:	8d 78 3c             	lea    0x3c(%eax),%edi
    205e:	83 ec 0c             	sub    $0xc,%esp
    2061:	83 ec 04             	sub    $0x4,%esp
    2064:	89 e0                	mov    %esp,%eax
    2066:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    206a:	66 89 30             	mov    %si,(%eax)
    206d:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2071:	88 50 02             	mov    %dl,0x2(%eax)
    2074:	6a 32                	push   $0x32
    2076:	6a 32                	push   $0x32
    2078:	6a 00                	push   $0x0
    207a:	6a 00                	push   $0x0
    207c:	53                   	push   %ebx
    207d:	51                   	push   %ecx
    207e:	ff 75 94             	pushl  -0x6c(%ebp)
    2081:	57                   	push   %edi
    2082:	e8 54 f3 ff ff       	call   13db <APDcCopy>
    2087:	83 c4 30             	add    $0x30,%esp
                    break;
    208a:	eb 5c                	jmp    20e8 <APGridPaint+0x6e5>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    208c:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    208f:	6a 0c                	push   $0xc
    2091:	6a 0c                	push   $0xc
    2093:	6a 0c                	push   $0xc
    2095:	50                   	push   %eax
    2096:	e8 e4 f4 ff ff       	call   157f <RGB>
    209b:	83 c4 0c             	add    $0xc,%esp
    209e:	8b 1d 1c 6a 00 00    	mov    0x6a1c,%ebx
    20a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20a7:	6b c8 32             	imul   $0x32,%eax,%ecx
    20aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
    20ad:	6b c0 32             	imul   $0x32,%eax,%eax
    20b0:	89 45 94             	mov    %eax,-0x6c(%ebp)
    20b3:	8b 45 08             	mov    0x8(%ebp),%eax
    20b6:	8d 78 3c             	lea    0x3c(%eax),%edi
    20b9:	83 ec 0c             	sub    $0xc,%esp
    20bc:	83 ec 04             	sub    $0x4,%esp
    20bf:	89 e0                	mov    %esp,%eax
    20c1:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    20c5:	66 89 30             	mov    %si,(%eax)
    20c8:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    20cc:	88 50 02             	mov    %dl,0x2(%eax)
    20cf:	6a 32                	push   $0x32
    20d1:	6a 32                	push   $0x32
    20d3:	6a 00                	push   $0x0
    20d5:	6a 00                	push   $0x0
    20d7:	53                   	push   %ebx
    20d8:	51                   	push   %ecx
    20d9:	ff 75 94             	pushl  -0x6c(%ebp)
    20dc:	57                   	push   %edi
    20dd:	e8 f9 f2 ff ff       	call   13db <APDcCopy>
    20e2:	83 c4 30             	add    $0x30,%esp
                    break;
    20e5:	eb 01                	jmp    20e8 <APGridPaint+0x6e5>
                default: break;
    20e7:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    20e8:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    20ec:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    20f0:	0f 8e 1c fc ff ff    	jle    1d12 <APGridPaint+0x30f>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    20f6:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    20fa:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    20fe:	0f 8e 02 fc ff ff    	jle    1d06 <APGridPaint+0x303>
                default: break;
            }
        }
    }
    
}
    2104:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2107:	5b                   	pop    %ebx
    2108:	5e                   	pop    %esi
    2109:	5f                   	pop    %edi
    210a:	5d                   	pop    %ebp
    210b:	c3                   	ret    

0000210c <updateword>:


void updateword(AHwnd hwnd,char* str)
{
    210c:	55                   	push   %ebp
    210d:	89 e5                	mov    %esp,%ebp
    210f:	53                   	push   %ebx
    2110:	83 ec 24             	sub    $0x24,%esp
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2113:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2116:	68 cd 00 00 00       	push   $0xcd
    211b:	6a 74                	push   $0x74
    211d:	6a 18                	push   $0x18
    211f:	50                   	push   %eax
    2120:	e8 5a f4 ff ff       	call   157f <RGB>
    2125:	83 c4 0c             	add    $0xc,%esp
    2128:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    212c:	66 89 45 f0          	mov    %ax,-0x10(%ebp)
    2130:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    2134:	88 45 f2             	mov    %al,-0xe(%ebp)
    pen.size = 1;
    2137:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    213e:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2141:	68 cd 00 00 00       	push   $0xcd
    2146:	6a 74                	push   $0x74
    2148:	6a 18                	push   $0x18
    214a:	50                   	push   %eax
    214b:	e8 2f f4 ff ff       	call   157f <RGB>
    2150:	83 c4 0c             	add    $0xc,%esp
    2153:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2157:	66 89 45 ed          	mov    %ax,-0x13(%ebp)
    215b:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    215f:	88 45 ef             	mov    %al,-0x11(%ebp)
    APSetPen(&hwnd->TitleDc,pen);
    2162:	8b 45 08             	mov    0x8(%ebp),%eax
    2165:	8d 50 58             	lea    0x58(%eax),%edx
    2168:	8d 45 d8             	lea    -0x28(%ebp),%eax
    216b:	ff 75 f4             	pushl  -0xc(%ebp)
    216e:	ff 75 f0             	pushl  -0x10(%ebp)
    2171:	52                   	push   %edx
    2172:	50                   	push   %eax
    2173:	e8 f4 ea ff ff       	call   c6c <APSetPen>
    2178:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&hwnd->TitleDc,brush);
    217b:	8b 45 08             	mov    0x8(%ebp),%eax
    217e:	8d 58 58             	lea    0x58(%eax),%ebx
    2181:	8d 55 d8             	lea    -0x28(%ebp),%edx
    2184:	83 ec 04             	sub    $0x4,%esp
    2187:	83 ec 04             	sub    $0x4,%esp
    218a:	89 e0                	mov    %esp,%eax
    218c:	0f b7 4d ed          	movzwl -0x13(%ebp),%ecx
    2190:	66 89 08             	mov    %cx,(%eax)
    2193:	0f b6 4d ef          	movzbl -0x11(%ebp),%ecx
    2197:	88 48 02             	mov    %cl,0x2(%eax)
    219a:	53                   	push   %ebx
    219b:	52                   	push   %edx
    219c:	e8 04 eb ff ff       	call   ca5 <APSetBrush>
    21a1:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&hwnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    21a4:	8b 45 08             	mov    0x8(%ebp),%eax
    21a7:	83 c0 58             	add    $0x58,%eax
    21aa:	83 ec 0c             	sub    $0xc,%esp
    21ad:	6a 32                	push   $0x32
    21af:	68 20 03 00 00       	push   $0x320
    21b4:	6a 00                	push   $0x0
    21b6:	6a 00                	push   $0x0
    21b8:	50                   	push   %eax
    21b9:	e8 11 ef ff ff       	call   10cf <APDrawRect>
    21be:	83 c4 20             	add    $0x20,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    21c1:	8d 45 d8             	lea    -0x28(%ebp),%eax
    21c4:	6a 08                	push   $0x8
    21c6:	6a 08                	push   $0x8
    21c8:	6a 08                	push   $0x8
    21ca:	50                   	push   %eax
    21cb:	e8 af f3 ff ff       	call   157f <RGB>
    21d0:	83 c4 0c             	add    $0xc,%esp
    21d3:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    21d7:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    21db:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    21df:	88 45 ec             	mov    %al,-0x14(%ebp)
    APSetFont(&hwnd->TitleDc,font);
    21e2:	8b 45 08             	mov    0x8(%ebp),%eax
    21e5:	8d 58 58             	lea    0x58(%eax),%ebx
    21e8:	8d 55 d8             	lea    -0x28(%ebp),%edx
    21eb:	83 ec 04             	sub    $0x4,%esp
    21ee:	83 ec 04             	sub    $0x4,%esp
    21f1:	89 e0                	mov    %esp,%eax
    21f3:	0f b7 4d ea          	movzwl -0x16(%ebp),%ecx
    21f7:	66 89 08             	mov    %cx,(%eax)
    21fa:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
    21fe:	88 48 02             	mov    %cl,0x2(%eax)
    2201:	53                   	push   %ebx
    2202:	52                   	push   %edx
    2203:	e8 df ea ff ff       	call   ce7 <APSetFont>
    2208:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&hwnd->TitleDc,str,10,20);
    220b:	8b 45 08             	mov    0x8(%ebp),%eax
    220e:	83 c0 58             	add    $0x58,%eax
    2211:	6a 14                	push   $0x14
    2213:	6a 0a                	push   $0xa
    2215:	ff 75 0c             	pushl  0xc(%ebp)
    2218:	50                   	push   %eax
    2219:	e8 b6 f0 ff ff       	call   12d4 <APDrawText>
    221e:	83 c4 10             	add    $0x10,%esp
}
    2221:	90                   	nop
    2222:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2225:	c9                   	leave  
    2226:	c3                   	ret    

00002227 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2227:	55                   	push   %ebp
    2228:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    222a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    222e:	7e 08                	jle    2238 <random+0x11>
{
rand_num = seed;
    2230:	8b 45 08             	mov    0x8(%ebp),%eax
    2233:	a3 80 69 00 00       	mov    %eax,0x6980
}
rand_num *= 3;
    2238:	8b 15 80 69 00 00    	mov    0x6980,%edx
    223e:	89 d0                	mov    %edx,%eax
    2240:	01 c0                	add    %eax,%eax
    2242:	01 d0                	add    %edx,%eax
    2244:	a3 80 69 00 00       	mov    %eax,0x6980
if (rand_num < 0)
    2249:	a1 80 69 00 00       	mov    0x6980,%eax
    224e:	85 c0                	test   %eax,%eax
    2250:	79 0c                	jns    225e <random+0x37>
{
rand_num *= (-1);
    2252:	a1 80 69 00 00       	mov    0x6980,%eax
    2257:	f7 d8                	neg    %eax
    2259:	a3 80 69 00 00       	mov    %eax,0x6980
}
return rand_num % 997;
    225e:	8b 0d 80 69 00 00    	mov    0x6980,%ecx
    2264:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2269:	89 c8                	mov    %ecx,%eax
    226b:	f7 ea                	imul   %edx
    226d:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2270:	c1 f8 09             	sar    $0x9,%eax
    2273:	89 c2                	mov    %eax,%edx
    2275:	89 c8                	mov    %ecx,%eax
    2277:	c1 f8 1f             	sar    $0x1f,%eax
    227a:	29 c2                	sub    %eax,%edx
    227c:	89 d0                	mov    %edx,%eax
    227e:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2284:	29 c1                	sub    %eax,%ecx
    2286:	89 c8                	mov    %ecx,%eax
}
    2288:	5d                   	pop    %ebp
    2289:	c3                   	ret    

0000228a <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    228a:	55                   	push   %ebp
    228b:	89 e5                	mov    %esp,%ebp
    228d:	53                   	push   %ebx
    228e:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2291:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2298:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    229c:	74 17                	je     22b5 <sprintint+0x2b>
    229e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    22a2:	79 11                	jns    22b5 <sprintint+0x2b>
        neg = 1;
    22a4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    22ab:	8b 45 10             	mov    0x10(%ebp),%eax
    22ae:	f7 d8                	neg    %eax
    22b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    22b3:	eb 06                	jmp    22bb <sprintint+0x31>
    } else {
        x = xx;
    22b5:	8b 45 10             	mov    0x10(%ebp),%eax
    22b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    22bb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    22c2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    22c5:	8d 41 01             	lea    0x1(%ecx),%eax
    22c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
    22cb:	8b 5d 14             	mov    0x14(%ebp),%ebx
    22ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22d1:	ba 00 00 00 00       	mov    $0x0,%edx
    22d6:	f7 f3                	div    %ebx
    22d8:	89 d0                	mov    %edx,%eax
    22da:	0f b6 80 84 69 00 00 	movzbl 0x6984(%eax),%eax
    22e1:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    22e5:	8b 5d 14             	mov    0x14(%ebp),%ebx
    22e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22eb:	ba 00 00 00 00       	mov    $0x0,%edx
    22f0:	f7 f3                	div    %ebx
    22f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    22f5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    22f9:	75 c7                	jne    22c2 <sprintint+0x38>
    if(neg)
    22fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    22ff:	74 0e                	je     230f <sprintint+0x85>
        buf[i++] = '-';
    2301:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2304:	8d 50 01             	lea    0x1(%eax),%edx
    2307:	89 55 f8             	mov    %edx,-0x8(%ebp)
    230a:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    230f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2312:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2315:	eb 1b                	jmp    2332 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2317:	8b 45 0c             	mov    0xc(%ebp),%eax
    231a:	8b 00                	mov    (%eax),%eax
    231c:	8d 48 01             	lea    0x1(%eax),%ecx
    231f:	8b 55 0c             	mov    0xc(%ebp),%edx
    2322:	89 0a                	mov    %ecx,(%edx)
    2324:	89 c2                	mov    %eax,%edx
    2326:	8b 45 08             	mov    0x8(%ebp),%eax
    2329:	01 d0                	add    %edx,%eax
    232b:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    232e:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2332:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2336:	7f df                	jg     2317 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2338:	eb 21                	jmp    235b <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    233a:	8b 45 0c             	mov    0xc(%ebp),%eax
    233d:	8b 00                	mov    (%eax),%eax
    233f:	8d 48 01             	lea    0x1(%eax),%ecx
    2342:	8b 55 0c             	mov    0xc(%ebp),%edx
    2345:	89 0a                	mov    %ecx,(%edx)
    2347:	89 c2                	mov    %eax,%edx
    2349:	8b 45 08             	mov    0x8(%ebp),%eax
    234c:	01 c2                	add    %eax,%edx
    234e:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2351:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2354:	01 c8                	add    %ecx,%eax
    2356:	0f b6 00             	movzbl (%eax),%eax
    2359:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    235b:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    235f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2363:	79 d5                	jns    233a <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2365:	90                   	nop
    2366:	83 c4 20             	add    $0x20,%esp
    2369:	5b                   	pop    %ebx
    236a:	5d                   	pop    %ebp
    236b:	c3                   	ret    

0000236c <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    236c:	55                   	push   %ebp
    236d:	89 e5                	mov    %esp,%ebp
    236f:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2372:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2379:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2380:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2387:	8d 45 0c             	lea    0xc(%ebp),%eax
    238a:	83 c0 04             	add    $0x4,%eax
    238d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2390:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2397:	e9 d9 01 00 00       	jmp    2575 <sprintf+0x209>
        c = fmt[i] & 0xff;
    239c:	8b 55 0c             	mov    0xc(%ebp),%edx
    239f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23a2:	01 d0                	add    %edx,%eax
    23a4:	0f b6 00             	movzbl (%eax),%eax
    23a7:	0f be c0             	movsbl %al,%eax
    23aa:	25 ff 00 00 00       	and    $0xff,%eax
    23af:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    23b2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    23b6:	75 2c                	jne    23e4 <sprintf+0x78>
            if(c == '%'){
    23b8:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    23bc:	75 0c                	jne    23ca <sprintf+0x5e>
                state = '%';
    23be:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    23c5:	e9 a7 01 00 00       	jmp    2571 <sprintf+0x205>
            } else {
                dst[j++] = c;
    23ca:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23cd:	8d 50 01             	lea    0x1(%eax),%edx
    23d0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23d3:	89 c2                	mov    %eax,%edx
    23d5:	8b 45 08             	mov    0x8(%ebp),%eax
    23d8:	01 d0                	add    %edx,%eax
    23da:	8b 55 e0             	mov    -0x20(%ebp),%edx
    23dd:	88 10                	mov    %dl,(%eax)
    23df:	e9 8d 01 00 00       	jmp    2571 <sprintf+0x205>
            }
        } else if(state == '%'){
    23e4:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    23e8:	0f 85 83 01 00 00    	jne    2571 <sprintf+0x205>
            if(c == 'd'){
    23ee:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    23f2:	75 4c                	jne    2440 <sprintf+0xd4>
                buf[bi] = '\0';
    23f4:	8d 55 ce             	lea    -0x32(%ebp),%edx
    23f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23fa:	01 d0                	add    %edx,%eax
    23fc:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    23ff:	83 ec 0c             	sub    $0xc,%esp
    2402:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2405:	50                   	push   %eax
    2406:	e8 bb de ff ff       	call   2c6 <atoi>
    240b:	83 c4 10             	add    $0x10,%esp
    240e:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2411:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2418:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    241b:	8b 00                	mov    (%eax),%eax
    241d:	83 ec 08             	sub    $0x8,%esp
    2420:	ff 75 d8             	pushl  -0x28(%ebp)
    2423:	6a 01                	push   $0x1
    2425:	6a 0a                	push   $0xa
    2427:	50                   	push   %eax
    2428:	8d 45 c8             	lea    -0x38(%ebp),%eax
    242b:	50                   	push   %eax
    242c:	ff 75 08             	pushl  0x8(%ebp)
    242f:	e8 56 fe ff ff       	call   228a <sprintint>
    2434:	83 c4 20             	add    $0x20,%esp
                ap++;
    2437:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    243b:	e9 2a 01 00 00       	jmp    256a <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2440:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2444:	74 06                	je     244c <sprintf+0xe0>
    2446:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    244a:	75 4c                	jne    2498 <sprintf+0x12c>
                buf[bi] = '\0';
    244c:	8d 55 ce             	lea    -0x32(%ebp),%edx
    244f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2452:	01 d0                	add    %edx,%eax
    2454:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2457:	83 ec 0c             	sub    $0xc,%esp
    245a:	8d 45 ce             	lea    -0x32(%ebp),%eax
    245d:	50                   	push   %eax
    245e:	e8 63 de ff ff       	call   2c6 <atoi>
    2463:	83 c4 10             	add    $0x10,%esp
    2466:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2469:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2470:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2473:	8b 00                	mov    (%eax),%eax
    2475:	83 ec 08             	sub    $0x8,%esp
    2478:	ff 75 dc             	pushl  -0x24(%ebp)
    247b:	6a 00                	push   $0x0
    247d:	6a 10                	push   $0x10
    247f:	50                   	push   %eax
    2480:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2483:	50                   	push   %eax
    2484:	ff 75 08             	pushl  0x8(%ebp)
    2487:	e8 fe fd ff ff       	call   228a <sprintint>
    248c:	83 c4 20             	add    $0x20,%esp
                ap++;
    248f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2493:	e9 d2 00 00 00       	jmp    256a <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2498:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    249c:	75 46                	jne    24e4 <sprintf+0x178>
                s = (char*)*ap;
    249e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24a1:	8b 00                	mov    (%eax),%eax
    24a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    24a6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    24aa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    24ae:	75 25                	jne    24d5 <sprintf+0x169>
                    s = "(null)";
    24b0:	c7 45 f4 98 27 00 00 	movl   $0x2798,-0xc(%ebp)
                while(*s != 0){
    24b7:	eb 1c                	jmp    24d5 <sprintf+0x169>
                    dst[j++] = *s;
    24b9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24bc:	8d 50 01             	lea    0x1(%eax),%edx
    24bf:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24c2:	89 c2                	mov    %eax,%edx
    24c4:	8b 45 08             	mov    0x8(%ebp),%eax
    24c7:	01 c2                	add    %eax,%edx
    24c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24cc:	0f b6 00             	movzbl (%eax),%eax
    24cf:	88 02                	mov    %al,(%edx)
                    s++;
    24d1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    24d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24d8:	0f b6 00             	movzbl (%eax),%eax
    24db:	84 c0                	test   %al,%al
    24dd:	75 da                	jne    24b9 <sprintf+0x14d>
    24df:	e9 86 00 00 00       	jmp    256a <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    24e4:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    24e8:	75 1d                	jne    2507 <sprintf+0x19b>
                dst[j++] = *ap;
    24ea:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24ed:	8d 50 01             	lea    0x1(%eax),%edx
    24f0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24f3:	89 c2                	mov    %eax,%edx
    24f5:	8b 45 08             	mov    0x8(%ebp),%eax
    24f8:	01 c2                	add    %eax,%edx
    24fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24fd:	8b 00                	mov    (%eax),%eax
    24ff:	88 02                	mov    %al,(%edx)
                ap++;
    2501:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2505:	eb 63                	jmp    256a <sprintf+0x1fe>
            } else if(c == '%'){
    2507:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    250b:	75 17                	jne    2524 <sprintf+0x1b8>
                dst[j++] = c;
    250d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2510:	8d 50 01             	lea    0x1(%eax),%edx
    2513:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2516:	89 c2                	mov    %eax,%edx
    2518:	8b 45 08             	mov    0x8(%ebp),%eax
    251b:	01 d0                	add    %edx,%eax
    251d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2520:	88 10                	mov    %dl,(%eax)
    2522:	eb 46                	jmp    256a <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2524:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2528:	7e 18                	jle    2542 <sprintf+0x1d6>
    252a:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    252e:	7f 12                	jg     2542 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2530:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2533:	8d 50 01             	lea    0x1(%eax),%edx
    2536:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2539:	8b 55 e0             	mov    -0x20(%ebp),%edx
    253c:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2540:	eb 2f                	jmp    2571 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2542:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2545:	8d 50 01             	lea    0x1(%eax),%edx
    2548:	89 55 c8             	mov    %edx,-0x38(%ebp)
    254b:	89 c2                	mov    %eax,%edx
    254d:	8b 45 08             	mov    0x8(%ebp),%eax
    2550:	01 d0                	add    %edx,%eax
    2552:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2555:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2558:	8d 50 01             	lea    0x1(%eax),%edx
    255b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    255e:	89 c2                	mov    %eax,%edx
    2560:	8b 45 08             	mov    0x8(%ebp),%eax
    2563:	01 d0                	add    %edx,%eax
    2565:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2568:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    256a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2571:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2575:	8b 55 0c             	mov    0xc(%ebp),%edx
    2578:	8b 45 ec             	mov    -0x14(%ebp),%eax
    257b:	01 d0                	add    %edx,%eax
    257d:	0f b6 00             	movzbl (%eax),%eax
    2580:	84 c0                	test   %al,%al
    2582:	0f 85 14 fe ff ff    	jne    239c <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2588:	8b 45 c8             	mov    -0x38(%ebp),%eax
    258b:	8d 50 01             	lea    0x1(%eax),%edx
    258e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2591:	89 c2                	mov    %eax,%edx
    2593:	8b 45 08             	mov    0x8(%ebp),%eax
    2596:	01 d0                	add    %edx,%eax
    2598:	c6 00 00             	movb   $0x0,(%eax)
}
    259b:	90                   	nop
    259c:	c9                   	leave  
    259d:	c3                   	ret    
