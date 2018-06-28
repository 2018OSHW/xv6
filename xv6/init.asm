
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
      16:	68 3f 1f 00 00       	push   $0x1f3f
      1b:	e8 78 03 00 00       	call   398 <open>
      20:	83 c4 10             	add    $0x10,%esp
      23:	85 c0                	test   %eax,%eax
      25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
      27:	83 ec 04             	sub    $0x4,%esp
      2a:	6a 01                	push   $0x1
      2c:	6a 01                	push   $0x1
      2e:	68 3f 1f 00 00       	push   $0x1f3f
      33:	e8 68 03 00 00       	call   3a0 <mknod>
      38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
      3b:	83 ec 08             	sub    $0x8,%esp
      3e:	6a 02                	push   $0x2
      40:	68 3f 1f 00 00       	push   $0x1f3f
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
      6a:	68 47 1f 00 00       	push   $0x1f47
      6f:	6a 01                	push   $0x1
      71:	e8 81 04 00 00       	call   4f7 <printf>
      76:	83 c4 10             	add    $0x10,%esp
    pid = fork();
      79:	e8 d2 02 00 00       	call   350 <fork>
      7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
      81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      85:	79 17                	jns    9e <main+0x9e>
      printf(1, "init: fork failed\n");
      87:	83 ec 08             	sub    $0x8,%esp
      8a:	68 61 1f 00 00       	push   $0x1f61
      8f:	6a 01                	push   $0x1
      91:	e8 61 04 00 00       	call   4f7 <printf>
      96:	83 c4 10             	add    $0x10,%esp
      exit();
      99:	e8 ba 02 00 00       	call   358 <exit>
    }
    if(pid == 0){
      9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      a2:	75 3e                	jne    e2 <main+0xe2>
     // exec("sh", argv);
      exec("APDesktop", argv);
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	68 10 26 00 00       	push   $0x2610
      ac:	68 74 1f 00 00       	push   $0x1f74
      b1:	e8 da 02 00 00       	call   390 <exec>
      b6:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec desktop failed\n");
      b9:	83 ec 08             	sub    $0x8,%esp
      bc:	68 7e 1f 00 00       	push   $0x1f7e
      c1:	6a 01                	push   $0x1
      c3:	e8 2f 04 00 00       	call   4f7 <printf>
      c8:	83 c4 10             	add    $0x10,%esp
      exit();
      cb:	e8 88 02 00 00       	call   358 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
      d0:	83 ec 08             	sub    $0x8,%esp
      d3:	68 99 1f 00 00       	push   $0x1f99
      d8:	6a 01                	push   $0x1
      da:	e8 18 04 00 00       	call   4f7 <printf>
      df:	83 c4 10             	add    $0x10,%esp
     // exec("sh", argv);
      exec("APDesktop", argv);
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

00000400 <initStringFigure>:
SYSCALL(initStringFigure)
     400:	b8 17 00 00 00       	mov    $0x17,%eax
     405:	cd 40                	int    $0x40
     407:	c3                   	ret    

00000408 <sendMessage>:
SYSCALL(sendMessage)
     408:	b8 18 00 00 00       	mov    $0x18,%eax
     40d:	cd 40                	int    $0x40
     40f:	c3                   	ret    

00000410 <getMessage>:
SYSCALL(getMessage)
     410:	b8 1a 00 00 00       	mov    $0x1a,%eax
     415:	cd 40                	int    $0x40
     417:	c3                   	ret    

00000418 <registWindow>:
SYSCALL(registWindow)
     418:	b8 19 00 00 00       	mov    $0x19,%eax
     41d:	cd 40                	int    $0x40
     41f:	c3                   	ret    

00000420 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	83 ec 18             	sub    $0x18,%esp
     426:	8b 45 0c             	mov    0xc(%ebp),%eax
     429:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     42c:	83 ec 04             	sub    $0x4,%esp
     42f:	6a 01                	push   $0x1
     431:	8d 45 f4             	lea    -0xc(%ebp),%eax
     434:	50                   	push   %eax
     435:	ff 75 08             	pushl  0x8(%ebp)
     438:	e8 3b ff ff ff       	call   378 <write>
     43d:	83 c4 10             	add    $0x10,%esp
}
     440:	90                   	nop
     441:	c9                   	leave  
     442:	c3                   	ret    

00000443 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     443:	55                   	push   %ebp
     444:	89 e5                	mov    %esp,%ebp
     446:	53                   	push   %ebx
     447:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     44a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     451:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     455:	74 17                	je     46e <printint+0x2b>
     457:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     45b:	79 11                	jns    46e <printint+0x2b>
    neg = 1;
     45d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     464:	8b 45 0c             	mov    0xc(%ebp),%eax
     467:	f7 d8                	neg    %eax
     469:	89 45 ec             	mov    %eax,-0x14(%ebp)
     46c:	eb 06                	jmp    474 <printint+0x31>
  } else {
    x = xx;
     46e:	8b 45 0c             	mov    0xc(%ebp),%eax
     471:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     474:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     47b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     47e:	8d 41 01             	lea    0x1(%ecx),%eax
     481:	89 45 f4             	mov    %eax,-0xc(%ebp)
     484:	8b 5d 10             	mov    0x10(%ebp),%ebx
     487:	8b 45 ec             	mov    -0x14(%ebp),%eax
     48a:	ba 00 00 00 00       	mov    $0x0,%edx
     48f:	f7 f3                	div    %ebx
     491:	89 d0                	mov    %edx,%eax
     493:	0f b6 80 18 26 00 00 	movzbl 0x2618(%eax),%eax
     49a:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     49e:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4a4:	ba 00 00 00 00       	mov    $0x0,%edx
     4a9:	f7 f3                	div    %ebx
     4ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4ae:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4b2:	75 c7                	jne    47b <printint+0x38>
  if(neg)
     4b4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4b8:	74 2d                	je     4e7 <printint+0xa4>
    buf[i++] = '-';
     4ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4bd:	8d 50 01             	lea    0x1(%eax),%edx
     4c0:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4c3:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     4c8:	eb 1d                	jmp    4e7 <printint+0xa4>
    putc(fd, buf[i]);
     4ca:	8d 55 dc             	lea    -0x24(%ebp),%edx
     4cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4d0:	01 d0                	add    %edx,%eax
     4d2:	0f b6 00             	movzbl (%eax),%eax
     4d5:	0f be c0             	movsbl %al,%eax
     4d8:	83 ec 08             	sub    $0x8,%esp
     4db:	50                   	push   %eax
     4dc:	ff 75 08             	pushl  0x8(%ebp)
     4df:	e8 3c ff ff ff       	call   420 <putc>
     4e4:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     4e7:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     4eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4ef:	79 d9                	jns    4ca <printint+0x87>
    putc(fd, buf[i]);
}
     4f1:	90                   	nop
     4f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4f5:	c9                   	leave  
     4f6:	c3                   	ret    

000004f7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     4f7:	55                   	push   %ebp
     4f8:	89 e5                	mov    %esp,%ebp
     4fa:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     4fd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     504:	8d 45 0c             	lea    0xc(%ebp),%eax
     507:	83 c0 04             	add    $0x4,%eax
     50a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     50d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     514:	e9 59 01 00 00       	jmp    672 <printf+0x17b>
    c = fmt[i] & 0xff;
     519:	8b 55 0c             	mov    0xc(%ebp),%edx
     51c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     51f:	01 d0                	add    %edx,%eax
     521:	0f b6 00             	movzbl (%eax),%eax
     524:	0f be c0             	movsbl %al,%eax
     527:	25 ff 00 00 00       	and    $0xff,%eax
     52c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     52f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     533:	75 2c                	jne    561 <printf+0x6a>
      if(c == '%'){
     535:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     539:	75 0c                	jne    547 <printf+0x50>
        state = '%';
     53b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     542:	e9 27 01 00 00       	jmp    66e <printf+0x177>
      } else {
        putc(fd, c);
     547:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     54a:	0f be c0             	movsbl %al,%eax
     54d:	83 ec 08             	sub    $0x8,%esp
     550:	50                   	push   %eax
     551:	ff 75 08             	pushl  0x8(%ebp)
     554:	e8 c7 fe ff ff       	call   420 <putc>
     559:	83 c4 10             	add    $0x10,%esp
     55c:	e9 0d 01 00 00       	jmp    66e <printf+0x177>
      }
    } else if(state == '%'){
     561:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     565:	0f 85 03 01 00 00    	jne    66e <printf+0x177>
      if(c == 'd'){
     56b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     56f:	75 1e                	jne    58f <printf+0x98>
        printint(fd, *ap, 10, 1);
     571:	8b 45 e8             	mov    -0x18(%ebp),%eax
     574:	8b 00                	mov    (%eax),%eax
     576:	6a 01                	push   $0x1
     578:	6a 0a                	push   $0xa
     57a:	50                   	push   %eax
     57b:	ff 75 08             	pushl  0x8(%ebp)
     57e:	e8 c0 fe ff ff       	call   443 <printint>
     583:	83 c4 10             	add    $0x10,%esp
        ap++;
     586:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     58a:	e9 d8 00 00 00       	jmp    667 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     58f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     593:	74 06                	je     59b <printf+0xa4>
     595:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     599:	75 1e                	jne    5b9 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     59b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     59e:	8b 00                	mov    (%eax),%eax
     5a0:	6a 00                	push   $0x0
     5a2:	6a 10                	push   $0x10
     5a4:	50                   	push   %eax
     5a5:	ff 75 08             	pushl  0x8(%ebp)
     5a8:	e8 96 fe ff ff       	call   443 <printint>
     5ad:	83 c4 10             	add    $0x10,%esp
        ap++;
     5b0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5b4:	e9 ae 00 00 00       	jmp    667 <printf+0x170>
      } else if(c == 's'){
     5b9:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     5bd:	75 43                	jne    602 <printf+0x10b>
        s = (char*)*ap;
     5bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5c2:	8b 00                	mov    (%eax),%eax
     5c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     5c7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     5cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5cf:	75 25                	jne    5f6 <printf+0xff>
          s = "(null)";
     5d1:	c7 45 f4 a2 1f 00 00 	movl   $0x1fa2,-0xc(%ebp)
        while(*s != 0){
     5d8:	eb 1c                	jmp    5f6 <printf+0xff>
          putc(fd, *s);
     5da:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5dd:	0f b6 00             	movzbl (%eax),%eax
     5e0:	0f be c0             	movsbl %al,%eax
     5e3:	83 ec 08             	sub    $0x8,%esp
     5e6:	50                   	push   %eax
     5e7:	ff 75 08             	pushl  0x8(%ebp)
     5ea:	e8 31 fe ff ff       	call   420 <putc>
     5ef:	83 c4 10             	add    $0x10,%esp
          s++;
     5f2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     5f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5f9:	0f b6 00             	movzbl (%eax),%eax
     5fc:	84 c0                	test   %al,%al
     5fe:	75 da                	jne    5da <printf+0xe3>
     600:	eb 65                	jmp    667 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     602:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     606:	75 1d                	jne    625 <printf+0x12e>
        putc(fd, *ap);
     608:	8b 45 e8             	mov    -0x18(%ebp),%eax
     60b:	8b 00                	mov    (%eax),%eax
     60d:	0f be c0             	movsbl %al,%eax
     610:	83 ec 08             	sub    $0x8,%esp
     613:	50                   	push   %eax
     614:	ff 75 08             	pushl  0x8(%ebp)
     617:	e8 04 fe ff ff       	call   420 <putc>
     61c:	83 c4 10             	add    $0x10,%esp
        ap++;
     61f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     623:	eb 42                	jmp    667 <printf+0x170>
      } else if(c == '%'){
     625:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     629:	75 17                	jne    642 <printf+0x14b>
        putc(fd, c);
     62b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     62e:	0f be c0             	movsbl %al,%eax
     631:	83 ec 08             	sub    $0x8,%esp
     634:	50                   	push   %eax
     635:	ff 75 08             	pushl  0x8(%ebp)
     638:	e8 e3 fd ff ff       	call   420 <putc>
     63d:	83 c4 10             	add    $0x10,%esp
     640:	eb 25                	jmp    667 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     642:	83 ec 08             	sub    $0x8,%esp
     645:	6a 25                	push   $0x25
     647:	ff 75 08             	pushl  0x8(%ebp)
     64a:	e8 d1 fd ff ff       	call   420 <putc>
     64f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     652:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     655:	0f be c0             	movsbl %al,%eax
     658:	83 ec 08             	sub    $0x8,%esp
     65b:	50                   	push   %eax
     65c:	ff 75 08             	pushl  0x8(%ebp)
     65f:	e8 bc fd ff ff       	call   420 <putc>
     664:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     667:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     66e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     672:	8b 55 0c             	mov    0xc(%ebp),%edx
     675:	8b 45 f0             	mov    -0x10(%ebp),%eax
     678:	01 d0                	add    %edx,%eax
     67a:	0f b6 00             	movzbl (%eax),%eax
     67d:	84 c0                	test   %al,%al
     67f:	0f 85 94 fe ff ff    	jne    519 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     685:	90                   	nop
     686:	c9                   	leave  
     687:	c3                   	ret    

00000688 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     688:	55                   	push   %ebp
     689:	89 e5                	mov    %esp,%ebp
     68b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     68e:	8b 45 08             	mov    0x8(%ebp),%eax
     691:	83 e8 08             	sub    $0x8,%eax
     694:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     697:	a1 48 26 00 00       	mov    0x2648,%eax
     69c:	89 45 fc             	mov    %eax,-0x4(%ebp)
     69f:	eb 24                	jmp    6c5 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a4:	8b 00                	mov    (%eax),%eax
     6a6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6a9:	77 12                	ja     6bd <free+0x35>
     6ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ae:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6b1:	77 24                	ja     6d7 <free+0x4f>
     6b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b6:	8b 00                	mov    (%eax),%eax
     6b8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6bb:	77 1a                	ja     6d7 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c0:	8b 00                	mov    (%eax),%eax
     6c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6cb:	76 d4                	jbe    6a1 <free+0x19>
     6cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d0:	8b 00                	mov    (%eax),%eax
     6d2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6d5:	76 ca                	jbe    6a1 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     6d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6da:	8b 40 04             	mov    0x4(%eax),%eax
     6dd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6e7:	01 c2                	add    %eax,%edx
     6e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ec:	8b 00                	mov    (%eax),%eax
     6ee:	39 c2                	cmp    %eax,%edx
     6f0:	75 24                	jne    716 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     6f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6f5:	8b 50 04             	mov    0x4(%eax),%edx
     6f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6fb:	8b 00                	mov    (%eax),%eax
     6fd:	8b 40 04             	mov    0x4(%eax),%eax
     700:	01 c2                	add    %eax,%edx
     702:	8b 45 f8             	mov    -0x8(%ebp),%eax
     705:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     708:	8b 45 fc             	mov    -0x4(%ebp),%eax
     70b:	8b 00                	mov    (%eax),%eax
     70d:	8b 10                	mov    (%eax),%edx
     70f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     712:	89 10                	mov    %edx,(%eax)
     714:	eb 0a                	jmp    720 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     716:	8b 45 fc             	mov    -0x4(%ebp),%eax
     719:	8b 10                	mov    (%eax),%edx
     71b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     71e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     720:	8b 45 fc             	mov    -0x4(%ebp),%eax
     723:	8b 40 04             	mov    0x4(%eax),%eax
     726:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     72d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     730:	01 d0                	add    %edx,%eax
     732:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     735:	75 20                	jne    757 <free+0xcf>
    p->s.size += bp->s.size;
     737:	8b 45 fc             	mov    -0x4(%ebp),%eax
     73a:	8b 50 04             	mov    0x4(%eax),%edx
     73d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     740:	8b 40 04             	mov    0x4(%eax),%eax
     743:	01 c2                	add    %eax,%edx
     745:	8b 45 fc             	mov    -0x4(%ebp),%eax
     748:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     74b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     74e:	8b 10                	mov    (%eax),%edx
     750:	8b 45 fc             	mov    -0x4(%ebp),%eax
     753:	89 10                	mov    %edx,(%eax)
     755:	eb 08                	jmp    75f <free+0xd7>
  } else
    p->s.ptr = bp;
     757:	8b 45 fc             	mov    -0x4(%ebp),%eax
     75a:	8b 55 f8             	mov    -0x8(%ebp),%edx
     75d:	89 10                	mov    %edx,(%eax)
  freep = p;
     75f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     762:	a3 48 26 00 00       	mov    %eax,0x2648
}
     767:	90                   	nop
     768:	c9                   	leave  
     769:	c3                   	ret    

0000076a <morecore>:

static Header*
morecore(uint nu)
{
     76a:	55                   	push   %ebp
     76b:	89 e5                	mov    %esp,%ebp
     76d:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     770:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     777:	77 07                	ja     780 <morecore+0x16>
    nu = 4096;
     779:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     780:	8b 45 08             	mov    0x8(%ebp),%eax
     783:	c1 e0 03             	shl    $0x3,%eax
     786:	83 ec 0c             	sub    $0xc,%esp
     789:	50                   	push   %eax
     78a:	e8 51 fc ff ff       	call   3e0 <sbrk>
     78f:	83 c4 10             	add    $0x10,%esp
     792:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     795:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     799:	75 07                	jne    7a2 <morecore+0x38>
    return 0;
     79b:	b8 00 00 00 00       	mov    $0x0,%eax
     7a0:	eb 26                	jmp    7c8 <morecore+0x5e>
  hp = (Header*)p;
     7a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7ab:	8b 55 08             	mov    0x8(%ebp),%edx
     7ae:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     7b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7b4:	83 c0 08             	add    $0x8,%eax
     7b7:	83 ec 0c             	sub    $0xc,%esp
     7ba:	50                   	push   %eax
     7bb:	e8 c8 fe ff ff       	call   688 <free>
     7c0:	83 c4 10             	add    $0x10,%esp
  return freep;
     7c3:	a1 48 26 00 00       	mov    0x2648,%eax
}
     7c8:	c9                   	leave  
     7c9:	c3                   	ret    

000007ca <malloc>:

void*
malloc(uint nbytes)
{
     7ca:	55                   	push   %ebp
     7cb:	89 e5                	mov    %esp,%ebp
     7cd:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     7d0:	8b 45 08             	mov    0x8(%ebp),%eax
     7d3:	83 c0 07             	add    $0x7,%eax
     7d6:	c1 e8 03             	shr    $0x3,%eax
     7d9:	83 c0 01             	add    $0x1,%eax
     7dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     7df:	a1 48 26 00 00       	mov    0x2648,%eax
     7e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7e7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7eb:	75 23                	jne    810 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     7ed:	c7 45 f0 40 26 00 00 	movl   $0x2640,-0x10(%ebp)
     7f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7f7:	a3 48 26 00 00       	mov    %eax,0x2648
     7fc:	a1 48 26 00 00       	mov    0x2648,%eax
     801:	a3 40 26 00 00       	mov    %eax,0x2640
    base.s.size = 0;
     806:	c7 05 44 26 00 00 00 	movl   $0x0,0x2644
     80d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     810:	8b 45 f0             	mov    -0x10(%ebp),%eax
     813:	8b 00                	mov    (%eax),%eax
     815:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     818:	8b 45 f4             	mov    -0xc(%ebp),%eax
     81b:	8b 40 04             	mov    0x4(%eax),%eax
     81e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     821:	72 4d                	jb     870 <malloc+0xa6>
      if(p->s.size == nunits)
     823:	8b 45 f4             	mov    -0xc(%ebp),%eax
     826:	8b 40 04             	mov    0x4(%eax),%eax
     829:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     82c:	75 0c                	jne    83a <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     82e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     831:	8b 10                	mov    (%eax),%edx
     833:	8b 45 f0             	mov    -0x10(%ebp),%eax
     836:	89 10                	mov    %edx,(%eax)
     838:	eb 26                	jmp    860 <malloc+0x96>
      else {
        p->s.size -= nunits;
     83a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     83d:	8b 40 04             	mov    0x4(%eax),%eax
     840:	2b 45 ec             	sub    -0x14(%ebp),%eax
     843:	89 c2                	mov    %eax,%edx
     845:	8b 45 f4             	mov    -0xc(%ebp),%eax
     848:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     84b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     84e:	8b 40 04             	mov    0x4(%eax),%eax
     851:	c1 e0 03             	shl    $0x3,%eax
     854:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     857:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85a:	8b 55 ec             	mov    -0x14(%ebp),%edx
     85d:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     860:	8b 45 f0             	mov    -0x10(%ebp),%eax
     863:	a3 48 26 00 00       	mov    %eax,0x2648
      return (void*)(p + 1);
     868:	8b 45 f4             	mov    -0xc(%ebp),%eax
     86b:	83 c0 08             	add    $0x8,%eax
     86e:	eb 3b                	jmp    8ab <malloc+0xe1>
    }
    if(p == freep)
     870:	a1 48 26 00 00       	mov    0x2648,%eax
     875:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     878:	75 1e                	jne    898 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     87a:	83 ec 0c             	sub    $0xc,%esp
     87d:	ff 75 ec             	pushl  -0x14(%ebp)
     880:	e8 e5 fe ff ff       	call   76a <morecore>
     885:	83 c4 10             	add    $0x10,%esp
     888:	89 45 f4             	mov    %eax,-0xc(%ebp)
     88b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     88f:	75 07                	jne    898 <malloc+0xce>
        return 0;
     891:	b8 00 00 00 00       	mov    $0x0,%eax
     896:	eb 13                	jmp    8ab <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     898:	8b 45 f4             	mov    -0xc(%ebp),%eax
     89b:	89 45 f0             	mov    %eax,-0x10(%ebp)
     89e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8a1:	8b 00                	mov    (%eax),%eax
     8a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     8a6:	e9 6d ff ff ff       	jmp    818 <malloc+0x4e>
}
     8ab:	c9                   	leave  
     8ac:	c3                   	ret    

000008ad <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     8ad:	55                   	push   %ebp
     8ae:	89 e5                	mov    %esp,%ebp
     8b0:	83 ec 1c             	sub    $0x1c,%esp
     8b3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     8b6:	8b 55 10             	mov    0x10(%ebp),%edx
     8b9:	8b 45 14             	mov    0x14(%ebp),%eax
     8bc:	88 4d ec             	mov    %cl,-0x14(%ebp)
     8bf:	88 55 e8             	mov    %dl,-0x18(%ebp)
     8c2:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     8c5:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     8c9:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     8cc:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     8d0:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     8d3:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     8d7:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     8da:	8b 45 08             	mov    0x8(%ebp),%eax
     8dd:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     8e1:	66 89 10             	mov    %dx,(%eax)
     8e4:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     8e8:	88 50 02             	mov    %dl,0x2(%eax)
}
     8eb:	8b 45 08             	mov    0x8(%ebp),%eax
     8ee:	c9                   	leave  
     8ef:	c2 04 00             	ret    $0x4

000008f2 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     8f2:	55                   	push   %ebp
     8f3:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     8f5:	8b 45 08             	mov    0x8(%ebp),%eax
     8f8:	2b 45 10             	sub    0x10(%ebp),%eax
     8fb:	89 c2                	mov    %eax,%edx
     8fd:	8b 45 08             	mov    0x8(%ebp),%eax
     900:	2b 45 10             	sub    0x10(%ebp),%eax
     903:	0f af d0             	imul   %eax,%edx
     906:	8b 45 0c             	mov    0xc(%ebp),%eax
     909:	2b 45 14             	sub    0x14(%ebp),%eax
     90c:	89 c1                	mov    %eax,%ecx
     90e:	8b 45 0c             	mov    0xc(%ebp),%eax
     911:	2b 45 14             	sub    0x14(%ebp),%eax
     914:	0f af c1             	imul   %ecx,%eax
     917:	01 d0                	add    %edx,%eax
}
     919:	5d                   	pop    %ebp
     91a:	c3                   	ret    

0000091b <abs_int>:

static inline int abs_int(int x)
{
     91b:	55                   	push   %ebp
     91c:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     91e:	8b 45 08             	mov    0x8(%ebp),%eax
     921:	99                   	cltd   
     922:	89 d0                	mov    %edx,%eax
     924:	33 45 08             	xor    0x8(%ebp),%eax
     927:	29 d0                	sub    %edx,%eax
}
     929:	5d                   	pop    %ebp
     92a:	c3                   	ret    

0000092b <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     92b:	55                   	push   %ebp
     92c:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     92e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     932:	79 07                	jns    93b <APGetIndex+0x10>
        return X_SMALLER;
     934:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     939:	eb 40                	jmp    97b <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     93b:	8b 45 08             	mov    0x8(%ebp),%eax
     93e:	8b 00                	mov    (%eax),%eax
     940:	3b 45 0c             	cmp    0xc(%ebp),%eax
     943:	7f 07                	jg     94c <APGetIndex+0x21>
        return X_BIGGER;
     945:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     94a:	eb 2f                	jmp    97b <APGetIndex+0x50>
    if (y < 0)
     94c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     950:	79 07                	jns    959 <APGetIndex+0x2e>
        return Y_SMALLER;
     952:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     957:	eb 22                	jmp    97b <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     959:	8b 45 08             	mov    0x8(%ebp),%eax
     95c:	8b 40 04             	mov    0x4(%eax),%eax
     95f:	3b 45 10             	cmp    0x10(%ebp),%eax
     962:	7f 07                	jg     96b <APGetIndex+0x40>
        return Y_BIGGER;
     964:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     969:	eb 10                	jmp    97b <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     96b:	8b 45 08             	mov    0x8(%ebp),%eax
     96e:	8b 00                	mov    (%eax),%eax
     970:	0f af 45 10          	imul   0x10(%ebp),%eax
     974:	89 c2                	mov    %eax,%edx
     976:	8b 45 0c             	mov    0xc(%ebp),%eax
     979:	01 d0                	add    %edx,%eax
}
     97b:	5d                   	pop    %ebp
     97c:	c3                   	ret    

0000097d <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     97d:	55                   	push   %ebp
     97e:	89 e5                	mov    %esp,%ebp
     980:	56                   	push   %esi
     981:	53                   	push   %ebx
     982:	83 ec 70             	sub    $0x70,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     985:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     98c:	8b 45 cc             	mov    -0x34(%ebp),%eax
     98f:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     992:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     999:	83 ec 08             	sub    $0x8,%esp
     99c:	6a 00                	push   $0x0
     99e:	ff 75 0c             	pushl  0xc(%ebp)
     9a1:	e8 f2 f9 ff ff       	call   398 <open>
     9a6:	83 c4 10             	add    $0x10,%esp
     9a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     9ac:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     9b0:	79 2e                	jns    9e0 <APLoadBitmap+0x63>
    {
        printf(1, "Cannot open %s\n", filename);
     9b2:	83 ec 04             	sub    $0x4,%esp
     9b5:	ff 75 0c             	pushl  0xc(%ebp)
     9b8:	68 ac 1f 00 00       	push   $0x1fac
     9bd:	6a 01                	push   $0x1
     9bf:	e8 33 fb ff ff       	call   4f7 <printf>
     9c4:	83 c4 10             	add    $0x10,%esp
        return bmp;
     9c7:	8b 45 08             	mov    0x8(%ebp),%eax
     9ca:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9cd:	89 10                	mov    %edx,(%eax)
     9cf:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9d2:	89 50 04             	mov    %edx,0x4(%eax)
     9d5:	8b 55 d0             	mov    -0x30(%ebp),%edx
     9d8:	89 50 08             	mov    %edx,0x8(%eax)
     9db:	e9 1b 02 00 00       	jmp    bfb <APLoadBitmap+0x27e>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     9e0:	83 ec 04             	sub    $0x4,%esp
     9e3:	6a 10                	push   $0x10
     9e5:	8d 45 b8             	lea    -0x48(%ebp),%eax
     9e8:	50                   	push   %eax
     9e9:	ff 75 ec             	pushl  -0x14(%ebp)
     9ec:	e8 7f f9 ff ff       	call   370 <read>
     9f1:	83 c4 10             	add    $0x10,%esp
    printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
     9f4:	0f b7 45 c2          	movzwl -0x3e(%ebp),%eax
     9f8:	0f b7 f0             	movzwl %ax,%esi
     9fb:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
     9ff:	0f b7 d8             	movzwl %ax,%ebx
     a02:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
     a05:	8b 55 bc             	mov    -0x44(%ebp),%edx
     a08:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
     a0c:	0f b7 c0             	movzwl %ax,%eax
     a0f:	83 ec 04             	sub    $0x4,%esp
     a12:	56                   	push   %esi
     a13:	53                   	push   %ebx
     a14:	51                   	push   %ecx
     a15:	52                   	push   %edx
     a16:	50                   	push   %eax
     a17:	68 bc 1f 00 00       	push   $0x1fbc
     a1c:	6a 01                	push   $0x1
     a1e:	e8 d4 fa ff ff       	call   4f7 <printf>
     a23:	83 c4 20             	add    $0x20,%esp
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     a26:	83 ec 04             	sub    $0x4,%esp
     a29:	6a 28                	push   $0x28
     a2b:	8d 45 90             	lea    -0x70(%ebp),%eax
     a2e:	50                   	push   %eax
     a2f:	ff 75 ec             	pushl  -0x14(%ebp)
     a32:	e8 39 f9 ff ff       	call   370 <read>
     a37:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     a3a:	8b 45 94             	mov    -0x6c(%ebp),%eax
     a3d:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     a40:	8b 45 98             	mov    -0x68(%ebp),%eax
     a43:	89 45 cc             	mov    %eax,-0x34(%ebp)
    printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
     a46:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a49:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a4c:	52                   	push   %edx
     a4d:	50                   	push   %eax
     a4e:	68 cc 1f 00 00       	push   $0x1fcc
     a53:	6a 01                	push   $0x1
     a55:	e8 9d fa ff ff       	call   4f7 <printf>
     a5a:	83 c4 10             	add    $0x10,%esp
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     a5d:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a60:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a63:	0f af d0             	imul   %eax,%edx
     a66:	89 d0                	mov    %edx,%eax
     a68:	01 c0                	add    %eax,%eax
     a6a:	01 d0                	add    %edx,%eax
     a6c:	83 ec 0c             	sub    $0xc,%esp
     a6f:	50                   	push   %eax
     a70:	e8 55 fd ff ff       	call   7ca <malloc>
     a75:	83 c4 10             	add    $0x10,%esp
     a78:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     a7b:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     a7f:	0f b7 c0             	movzwl %ax,%eax
     a82:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     a85:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a88:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a8b:	0f af c2             	imul   %edx,%eax
     a8e:	83 c0 1f             	add    $0x1f,%eax
     a91:	c1 e8 05             	shr    $0x5,%eax
     a94:	c1 e0 02             	shl    $0x2,%eax
     a97:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     a9a:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     aa0:	0f af c2             	imul   %edx,%eax
     aa3:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     aa6:	8b 45 e0             	mov    -0x20(%ebp),%eax
     aa9:	83 ec 0c             	sub    $0xc,%esp
     aac:	50                   	push   %eax
     aad:	e8 18 fd ff ff       	call   7ca <malloc>
     ab2:	83 c4 10             	add    $0x10,%esp
     ab5:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     ab8:	83 ec 04             	sub    $0x4,%esp
     abb:	ff 75 e0             	pushl  -0x20(%ebp)
     abe:	ff 75 dc             	pushl  -0x24(%ebp)
     ac1:	ff 75 ec             	pushl  -0x14(%ebp)
     ac4:	e8 a7 f8 ff ff       	call   370 <read>
     ac9:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     acc:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     ad0:	66 c1 e8 03          	shr    $0x3,%ax
     ad4:	0f b7 c0             	movzwl %ax,%eax
     ad7:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     ada:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ae1:	e9 e5 00 00 00       	jmp    bcb <APLoadBitmap+0x24e>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     ae6:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ae9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aec:	29 c2                	sub    %eax,%edx
     aee:	89 d0                	mov    %edx,%eax
     af0:	8d 50 ff             	lea    -0x1(%eax),%edx
     af3:	8b 45 c8             	mov    -0x38(%ebp),%eax
     af6:	0f af c2             	imul   %edx,%eax
     af9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     afc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b03:	e9 b1 00 00 00       	jmp    bb9 <APLoadBitmap+0x23c>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     b08:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b0b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b11:	01 c8                	add    %ecx,%eax
     b13:	89 c1                	mov    %eax,%ecx
     b15:	89 c8                	mov    %ecx,%eax
     b17:	01 c0                	add    %eax,%eax
     b19:	01 c8                	add    %ecx,%eax
     b1b:	01 c2                	add    %eax,%edx
     b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b20:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b24:	89 c1                	mov    %eax,%ecx
     b26:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b29:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b2d:	01 c1                	add    %eax,%ecx
     b2f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b32:	01 c8                	add    %ecx,%eax
     b34:	8d 48 ff             	lea    -0x1(%eax),%ecx
     b37:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b3a:	01 c8                	add    %ecx,%eax
     b3c:	0f b6 00             	movzbl (%eax),%eax
     b3f:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     b42:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b45:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b48:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b4b:	01 c8                	add    %ecx,%eax
     b4d:	89 c1                	mov    %eax,%ecx
     b4f:	89 c8                	mov    %ecx,%eax
     b51:	01 c0                	add    %eax,%eax
     b53:	01 c8                	add    %ecx,%eax
     b55:	01 c2                	add    %eax,%edx
     b57:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b5a:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b5e:	89 c1                	mov    %eax,%ecx
     b60:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b63:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b67:	01 c1                	add    %eax,%ecx
     b69:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b6c:	01 c8                	add    %ecx,%eax
     b6e:	8d 48 fe             	lea    -0x2(%eax),%ecx
     b71:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b74:	01 c8                	add    %ecx,%eax
     b76:	0f b6 00             	movzbl (%eax),%eax
     b79:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     b7c:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b7f:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b82:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b85:	01 c8                	add    %ecx,%eax
     b87:	89 c1                	mov    %eax,%ecx
     b89:	89 c8                	mov    %ecx,%eax
     b8b:	01 c0                	add    %eax,%eax
     b8d:	01 c8                	add    %ecx,%eax
     b8f:	01 c2                	add    %eax,%edx
     b91:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b94:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b98:	89 c1                	mov    %eax,%ecx
     b9a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b9d:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ba1:	01 c1                	add    %eax,%ecx
     ba3:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ba6:	01 c8                	add    %ecx,%eax
     ba8:	8d 48 fd             	lea    -0x3(%eax),%ecx
     bab:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bae:	01 c8                	add    %ecx,%eax
     bb0:	0f b6 00             	movzbl (%eax),%eax
     bb3:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     bb5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     bb9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bbf:	39 c2                	cmp    %eax,%edx
     bc1:	0f 87 41 ff ff ff    	ja     b08 <APLoadBitmap+0x18b>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     bc7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     bcb:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd1:	39 c2                	cmp    %eax,%edx
     bd3:	0f 87 0d ff ff ff    	ja     ae6 <APLoadBitmap+0x169>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     bd9:	83 ec 0c             	sub    $0xc,%esp
     bdc:	ff 75 ec             	pushl  -0x14(%ebp)
     bdf:	e8 9c f7 ff ff       	call   380 <close>
     be4:	83 c4 10             	add    $0x10,%esp
    return bmp;
     be7:	8b 45 08             	mov    0x8(%ebp),%eax
     bea:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bed:	89 10                	mov    %edx,(%eax)
     bef:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bf2:	89 50 04             	mov    %edx,0x4(%eax)
     bf5:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bf8:	89 50 08             	mov    %edx,0x8(%eax)
}
     bfb:	8b 45 08             	mov    0x8(%ebp),%eax
     bfe:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c01:	5b                   	pop    %ebx
     c02:	5e                   	pop    %esi
     c03:	5d                   	pop    %ebp
     c04:	c2 04 00             	ret    $0x4

00000c07 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     c07:	55                   	push   %ebp
     c08:	89 e5                	mov    %esp,%ebp
     c0a:	53                   	push   %ebx
     c0b:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     c0e:	83 ec 0c             	sub    $0xc,%esp
     c11:	6a 1c                	push   $0x1c
     c13:	e8 b2 fb ff ff       	call   7ca <malloc>
     c18:	83 c4 10             	add    $0x10,%esp
     c1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     c1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c21:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     c28:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c2b:	8d 45 d8             	lea    -0x28(%ebp),%eax
     c2e:	6a 0c                	push   $0xc
     c30:	6a 0c                	push   $0xc
     c32:	6a 0c                	push   $0xc
     c34:	50                   	push   %eax
     c35:	e8 73 fc ff ff       	call   8ad <RGB>
     c3a:	83 c4 0c             	add    $0xc,%esp
     c3d:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     c41:	66 89 43 13          	mov    %ax,0x13(%ebx)
     c45:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     c49:	88 43 15             	mov    %al,0x15(%ebx)
     c4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c4f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c52:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     c56:	66 89 48 10          	mov    %cx,0x10(%eax)
     c5a:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     c5e:	88 50 12             	mov    %dl,0x12(%eax)
     c61:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c64:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c67:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     c6b:	66 89 48 08          	mov    %cx,0x8(%eax)
     c6f:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     c73:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     c76:	8b 45 08             	mov    0x8(%ebp),%eax
     c79:	89 c2                	mov    %eax,%edx
     c7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c7e:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     c80:	8b 45 0c             	mov    0xc(%ebp),%eax
     c83:	89 c2                	mov    %eax,%edx
     c85:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c88:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     c8b:	8b 55 10             	mov    0x10(%ebp),%edx
     c8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c91:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "%d %d\n", hdc->size.cx, hdc->size.cy);
    return hdc;
     c94:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c97:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c9a:	c9                   	leave  
     c9b:	c3                   	ret    

00000c9c <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     c9c:	55                   	push   %ebp
     c9d:	89 e5                	mov    %esp,%ebp
     c9f:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     ca2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ca5:	8b 50 08             	mov    0x8(%eax),%edx
     ca8:	89 55 f8             	mov    %edx,-0x8(%ebp)
     cab:	8b 40 0c             	mov    0xc(%eax),%eax
     cae:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     cb1:	8b 45 0c             	mov    0xc(%ebp),%eax
     cb4:	8b 55 10             	mov    0x10(%ebp),%edx
     cb7:	89 50 08             	mov    %edx,0x8(%eax)
     cba:	8b 55 14             	mov    0x14(%ebp),%edx
     cbd:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     cc0:	8b 45 08             	mov    0x8(%ebp),%eax
     cc3:	8b 55 f8             	mov    -0x8(%ebp),%edx
     cc6:	89 10                	mov    %edx,(%eax)
     cc8:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ccb:	89 50 04             	mov    %edx,0x4(%eax)
}
     cce:	8b 45 08             	mov    0x8(%ebp),%eax
     cd1:	c9                   	leave  
     cd2:	c2 04 00             	ret    $0x4

00000cd5 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     cd5:	55                   	push   %ebp
     cd6:	89 e5                	mov    %esp,%ebp
     cd8:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
     cde:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     ce2:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     ce6:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     cea:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     ced:	8b 45 0c             	mov    0xc(%ebp),%eax
     cf0:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     cf4:	66 89 50 10          	mov    %dx,0x10(%eax)
     cf8:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     cfc:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     cff:	8b 45 08             	mov    0x8(%ebp),%eax
     d02:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d06:	66 89 10             	mov    %dx,(%eax)
     d09:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d0d:	88 50 02             	mov    %dl,0x2(%eax)
}
     d10:	8b 45 08             	mov    0x8(%ebp),%eax
     d13:	c9                   	leave  
     d14:	c2 04 00             	ret    $0x4

00000d17 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     d17:	55                   	push   %ebp
     d18:	89 e5                	mov    %esp,%ebp
     d1a:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     d1d:	8b 45 08             	mov    0x8(%ebp),%eax
     d20:	8b 40 0c             	mov    0xc(%eax),%eax
     d23:	89 c2                	mov    %eax,%edx
     d25:	c1 ea 1f             	shr    $0x1f,%edx
     d28:	01 d0                	add    %edx,%eax
     d2a:	d1 f8                	sar    %eax
     d2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     d2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d32:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     d36:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     d39:	8b 45 10             	mov    0x10(%ebp),%eax
     d3c:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d3f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     d42:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     d46:	0f 89 98 00 00 00    	jns    de4 <APDrawPoint+0xcd>
        i = 0;
     d4c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     d53:	e9 8c 00 00 00       	jmp    de4 <APDrawPoint+0xcd>
    {
        j = x - off;
     d58:	8b 45 0c             	mov    0xc(%ebp),%eax
     d5b:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d5e:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d61:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d65:	79 69                	jns    dd0 <APDrawPoint+0xb9>
            j = 0;
     d67:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d6e:	eb 60                	jmp    dd0 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d70:	ff 75 fc             	pushl  -0x4(%ebp)
     d73:	ff 75 f8             	pushl  -0x8(%ebp)
     d76:	ff 75 08             	pushl  0x8(%ebp)
     d79:	e8 ad fb ff ff       	call   92b <APGetIndex>
     d7e:	83 c4 0c             	add    $0xc,%esp
     d81:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d84:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d88:	74 55                	je     ddf <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d8a:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d8e:	74 67                	je     df7 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d90:	ff 75 10             	pushl  0x10(%ebp)
     d93:	ff 75 0c             	pushl  0xc(%ebp)
     d96:	ff 75 fc             	pushl  -0x4(%ebp)
     d99:	ff 75 f8             	pushl  -0x8(%ebp)
     d9c:	e8 51 fb ff ff       	call   8f2 <distance_2>
     da1:	83 c4 10             	add    $0x10,%esp
     da4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     da7:	7f 23                	jg     dcc <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     da9:	8b 45 08             	mov    0x8(%ebp),%eax
     dac:	8b 48 18             	mov    0x18(%eax),%ecx
     daf:	8b 55 ec             	mov    -0x14(%ebp),%edx
     db2:	89 d0                	mov    %edx,%eax
     db4:	01 c0                	add    %eax,%eax
     db6:	01 d0                	add    %edx,%eax
     db8:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     dbb:	8b 45 08             	mov    0x8(%ebp),%eax
     dbe:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     dc2:	66 89 0a             	mov    %cx,(%edx)
     dc5:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     dc9:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     dcc:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     dd0:	8b 55 0c             	mov    0xc(%ebp),%edx
     dd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dd6:	01 d0                	add    %edx,%eax
     dd8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     ddb:	7d 93                	jge    d70 <APDrawPoint+0x59>
     ddd:	eb 01                	jmp    de0 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     ddf:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     de0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     de4:	8b 55 10             	mov    0x10(%ebp),%edx
     de7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dea:	01 d0                	add    %edx,%eax
     dec:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     def:	0f 8d 63 ff ff ff    	jge    d58 <APDrawPoint+0x41>
     df5:	eb 01                	jmp    df8 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     df7:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     df8:	c9                   	leave  
     df9:	c3                   	ret    

00000dfa <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     dfa:	55                   	push   %ebp
     dfb:	89 e5                	mov    %esp,%ebp
     dfd:	53                   	push   %ebx
     dfe:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     e01:	8b 45 0c             	mov    0xc(%ebp),%eax
     e04:	3b 45 14             	cmp    0x14(%ebp),%eax
     e07:	0f 85 80 00 00 00    	jne    e8d <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     e0d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e11:	0f 88 9d 02 00 00    	js     10b4 <APDrawLine+0x2ba>
     e17:	8b 45 08             	mov    0x8(%ebp),%eax
     e1a:	8b 00                	mov    (%eax),%eax
     e1c:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e1f:	0f 8e 8f 02 00 00    	jle    10b4 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     e25:	8b 45 10             	mov    0x10(%ebp),%eax
     e28:	3b 45 18             	cmp    0x18(%ebp),%eax
     e2b:	7e 12                	jle    e3f <APDrawLine+0x45>
        {
            int tmp = y2;
     e2d:	8b 45 18             	mov    0x18(%ebp),%eax
     e30:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     e33:	8b 45 10             	mov    0x10(%ebp),%eax
     e36:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     e39:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e3c:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     e3f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e43:	79 07                	jns    e4c <APDrawLine+0x52>
     e45:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e4c:	8b 45 08             	mov    0x8(%ebp),%eax
     e4f:	8b 40 04             	mov    0x4(%eax),%eax
     e52:	3b 45 18             	cmp    0x18(%ebp),%eax
     e55:	7d 0c                	jge    e63 <APDrawLine+0x69>
     e57:	8b 45 08             	mov    0x8(%ebp),%eax
     e5a:	8b 40 04             	mov    0x4(%eax),%eax
     e5d:	83 e8 01             	sub    $0x1,%eax
     e60:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e63:	8b 45 10             	mov    0x10(%ebp),%eax
     e66:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e69:	eb 15                	jmp    e80 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e6b:	ff 75 f4             	pushl  -0xc(%ebp)
     e6e:	ff 75 0c             	pushl  0xc(%ebp)
     e71:	ff 75 08             	pushl  0x8(%ebp)
     e74:	e8 9e fe ff ff       	call   d17 <APDrawPoint>
     e79:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e7c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e80:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e83:	3b 45 18             	cmp    0x18(%ebp),%eax
     e86:	7e e3                	jle    e6b <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e88:	e9 2b 02 00 00       	jmp    10b8 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e8d:	8b 45 10             	mov    0x10(%ebp),%eax
     e90:	3b 45 18             	cmp    0x18(%ebp),%eax
     e93:	75 7f                	jne    f14 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e95:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e99:	0f 88 18 02 00 00    	js     10b7 <APDrawLine+0x2bd>
     e9f:	8b 45 08             	mov    0x8(%ebp),%eax
     ea2:	8b 40 04             	mov    0x4(%eax),%eax
     ea5:	3b 45 10             	cmp    0x10(%ebp),%eax
     ea8:	0f 8e 09 02 00 00    	jle    10b7 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     eae:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb1:	3b 45 14             	cmp    0x14(%ebp),%eax
     eb4:	7e 12                	jle    ec8 <APDrawLine+0xce>
        {
            int tmp = x2;
     eb6:	8b 45 14             	mov    0x14(%ebp),%eax
     eb9:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     ebc:	8b 45 0c             	mov    0xc(%ebp),%eax
     ebf:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     ec2:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ec5:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     ec8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ecc:	79 07                	jns    ed5 <APDrawLine+0xdb>
     ece:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     ed5:	8b 45 08             	mov    0x8(%ebp),%eax
     ed8:	8b 00                	mov    (%eax),%eax
     eda:	3b 45 14             	cmp    0x14(%ebp),%eax
     edd:	7d 0b                	jge    eea <APDrawLine+0xf0>
     edf:	8b 45 08             	mov    0x8(%ebp),%eax
     ee2:	8b 00                	mov    (%eax),%eax
     ee4:	83 e8 01             	sub    $0x1,%eax
     ee7:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     eea:	8b 45 0c             	mov    0xc(%ebp),%eax
     eed:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ef0:	eb 15                	jmp    f07 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     ef2:	ff 75 10             	pushl  0x10(%ebp)
     ef5:	ff 75 f0             	pushl  -0x10(%ebp)
     ef8:	ff 75 08             	pushl  0x8(%ebp)
     efb:	e8 17 fe ff ff       	call   d17 <APDrawPoint>
     f00:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     f03:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f07:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f0a:	3b 45 14             	cmp    0x14(%ebp),%eax
     f0d:	7e e3                	jle    ef2 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     f0f:	e9 a4 01 00 00       	jmp    10b8 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     f14:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f1b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     f22:	8b 45 0c             	mov    0xc(%ebp),%eax
     f25:	2b 45 14             	sub    0x14(%ebp),%eax
     f28:	50                   	push   %eax
     f29:	e8 ed f9 ff ff       	call   91b <abs_int>
     f2e:	83 c4 04             	add    $0x4,%esp
     f31:	89 c3                	mov    %eax,%ebx
     f33:	8b 45 10             	mov    0x10(%ebp),%eax
     f36:	2b 45 18             	sub    0x18(%ebp),%eax
     f39:	50                   	push   %eax
     f3a:	e8 dc f9 ff ff       	call   91b <abs_int>
     f3f:	83 c4 04             	add    $0x4,%esp
     f42:	39 c3                	cmp    %eax,%ebx
     f44:	0f 8e b5 00 00 00    	jle    fff <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f4a:	8b 45 10             	mov    0x10(%ebp),%eax
     f4d:	2b 45 18             	sub    0x18(%ebp),%eax
     f50:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f53:	db 45 b0             	fildl  -0x50(%ebp)
     f56:	8b 45 0c             	mov    0xc(%ebp),%eax
     f59:	2b 45 14             	sub    0x14(%ebp),%eax
     f5c:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f5f:	db 45 b0             	fildl  -0x50(%ebp)
     f62:	de f9                	fdivrp %st,%st(1)
     f64:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f67:	8b 45 14             	mov    0x14(%ebp),%eax
     f6a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f6d:	7e 0e                	jle    f7d <APDrawLine+0x183>
        {
            s = x1;
     f6f:	8b 45 0c             	mov    0xc(%ebp),%eax
     f72:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f75:	8b 45 14             	mov    0x14(%ebp),%eax
     f78:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f7b:	eb 0c                	jmp    f89 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f7d:	8b 45 14             	mov    0x14(%ebp),%eax
     f80:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f83:	8b 45 0c             	mov    0xc(%ebp),%eax
     f86:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f89:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f8d:	79 07                	jns    f96 <APDrawLine+0x19c>
     f8f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f96:	8b 45 08             	mov    0x8(%ebp),%eax
     f99:	8b 00                	mov    (%eax),%eax
     f9b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f9e:	7f 0b                	jg     fab <APDrawLine+0x1b1>
     fa0:	8b 45 08             	mov    0x8(%ebp),%eax
     fa3:	8b 00                	mov    (%eax),%eax
     fa5:	83 e8 01             	sub    $0x1,%eax
     fa8:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     fab:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     fb1:	eb 3f                	jmp    ff2 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     fb3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fb6:	2b 45 0c             	sub    0xc(%ebp),%eax
     fb9:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fbc:	db 45 b0             	fildl  -0x50(%ebp)
     fbf:	dc 4d d0             	fmull  -0x30(%ebp)
     fc2:	db 45 10             	fildl  0x10(%ebp)
     fc5:	de c1                	faddp  %st,%st(1)
     fc7:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fca:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fce:	b4 0c                	mov    $0xc,%ah
     fd0:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fd4:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fd7:	db 5d cc             	fistpl -0x34(%ebp)
     fda:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     fdd:	ff 75 cc             	pushl  -0x34(%ebp)
     fe0:	ff 75 e4             	pushl  -0x1c(%ebp)
     fe3:	ff 75 08             	pushl  0x8(%ebp)
     fe6:	e8 2c fd ff ff       	call   d17 <APDrawPoint>
     feb:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     fee:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     ff2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ff5:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ff8:	7e b9                	jle    fb3 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     ffa:	e9 b9 00 00 00       	jmp    10b8 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     fff:	8b 45 0c             	mov    0xc(%ebp),%eax
    1002:	2b 45 14             	sub    0x14(%ebp),%eax
    1005:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1008:	db 45 b0             	fildl  -0x50(%ebp)
    100b:	8b 45 10             	mov    0x10(%ebp),%eax
    100e:	2b 45 18             	sub    0x18(%ebp),%eax
    1011:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1014:	db 45 b0             	fildl  -0x50(%ebp)
    1017:	de f9                	fdivrp %st,%st(1)
    1019:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    101c:	8b 45 10             	mov    0x10(%ebp),%eax
    101f:	3b 45 18             	cmp    0x18(%ebp),%eax
    1022:	7e 0e                	jle    1032 <APDrawLine+0x238>
    {
        s = y2;
    1024:	8b 45 18             	mov    0x18(%ebp),%eax
    1027:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    102a:	8b 45 10             	mov    0x10(%ebp),%eax
    102d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1030:	eb 0c                	jmp    103e <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1032:	8b 45 10             	mov    0x10(%ebp),%eax
    1035:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1038:	8b 45 18             	mov    0x18(%ebp),%eax
    103b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    103e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1042:	79 07                	jns    104b <APDrawLine+0x251>
    1044:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    104b:	8b 45 08             	mov    0x8(%ebp),%eax
    104e:	8b 40 04             	mov    0x4(%eax),%eax
    1051:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1054:	7f 0c                	jg     1062 <APDrawLine+0x268>
    1056:	8b 45 08             	mov    0x8(%ebp),%eax
    1059:	8b 40 04             	mov    0x4(%eax),%eax
    105c:	83 e8 01             	sub    $0x1,%eax
    105f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1062:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1065:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1068:	eb 3f                	jmp    10a9 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    106a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    106d:	2b 45 10             	sub    0x10(%ebp),%eax
    1070:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1073:	db 45 b0             	fildl  -0x50(%ebp)
    1076:	dc 4d c0             	fmull  -0x40(%ebp)
    1079:	db 45 0c             	fildl  0xc(%ebp)
    107c:	de c1                	faddp  %st,%st(1)
    107e:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1081:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1085:	b4 0c                	mov    $0xc,%ah
    1087:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    108b:	d9 6d b4             	fldcw  -0x4c(%ebp)
    108e:	db 5d bc             	fistpl -0x44(%ebp)
    1091:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1094:	ff 75 e0             	pushl  -0x20(%ebp)
    1097:	ff 75 bc             	pushl  -0x44(%ebp)
    109a:	ff 75 08             	pushl  0x8(%ebp)
    109d:	e8 75 fc ff ff       	call   d17 <APDrawPoint>
    10a2:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    10a5:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    10a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10ac:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10af:	7e b9                	jle    106a <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    10b1:	90                   	nop
    10b2:	eb 04                	jmp    10b8 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    10b4:	90                   	nop
    10b5:	eb 01                	jmp    10b8 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    10b7:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    10b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10bb:	c9                   	leave  
    10bc:	c3                   	ret    

000010bd <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    10bd:	55                   	push   %ebp
    10be:	89 e5                	mov    %esp,%ebp
    10c0:	53                   	push   %ebx
    10c1:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    10c4:	8b 55 10             	mov    0x10(%ebp),%edx
    10c7:	8b 45 18             	mov    0x18(%ebp),%eax
    10ca:	01 d0                	add    %edx,%eax
    10cc:	83 e8 01             	sub    $0x1,%eax
    10cf:	83 ec 04             	sub    $0x4,%esp
    10d2:	50                   	push   %eax
    10d3:	ff 75 0c             	pushl  0xc(%ebp)
    10d6:	ff 75 10             	pushl  0x10(%ebp)
    10d9:	ff 75 0c             	pushl  0xc(%ebp)
    10dc:	ff 75 08             	pushl  0x8(%ebp)
    10df:	e8 16 fd ff ff       	call   dfa <APDrawLine>
    10e4:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    10e7:	8b 55 0c             	mov    0xc(%ebp),%edx
    10ea:	8b 45 14             	mov    0x14(%ebp),%eax
    10ed:	01 d0                	add    %edx,%eax
    10ef:	83 e8 01             	sub    $0x1,%eax
    10f2:	83 ec 04             	sub    $0x4,%esp
    10f5:	ff 75 10             	pushl  0x10(%ebp)
    10f8:	50                   	push   %eax
    10f9:	ff 75 10             	pushl  0x10(%ebp)
    10fc:	ff 75 0c             	pushl  0xc(%ebp)
    10ff:	ff 75 08             	pushl  0x8(%ebp)
    1102:	e8 f3 fc ff ff       	call   dfa <APDrawLine>
    1107:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    110a:	8b 55 10             	mov    0x10(%ebp),%edx
    110d:	8b 45 18             	mov    0x18(%ebp),%eax
    1110:	01 d0                	add    %edx,%eax
    1112:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1115:	8b 55 0c             	mov    0xc(%ebp),%edx
    1118:	8b 45 14             	mov    0x14(%ebp),%eax
    111b:	01 d0                	add    %edx,%eax
    111d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1120:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1123:	8b 45 14             	mov    0x14(%ebp),%eax
    1126:	01 d8                	add    %ebx,%eax
    1128:	83 e8 01             	sub    $0x1,%eax
    112b:	83 ec 04             	sub    $0x4,%esp
    112e:	51                   	push   %ecx
    112f:	52                   	push   %edx
    1130:	ff 75 10             	pushl  0x10(%ebp)
    1133:	50                   	push   %eax
    1134:	ff 75 08             	pushl  0x8(%ebp)
    1137:	e8 be fc ff ff       	call   dfa <APDrawLine>
    113c:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    113f:	8b 55 10             	mov    0x10(%ebp),%edx
    1142:	8b 45 18             	mov    0x18(%ebp),%eax
    1145:	01 d0                	add    %edx,%eax
    1147:	8d 48 ff             	lea    -0x1(%eax),%ecx
    114a:	8b 55 0c             	mov    0xc(%ebp),%edx
    114d:	8b 45 14             	mov    0x14(%ebp),%eax
    1150:	01 d0                	add    %edx,%eax
    1152:	8d 50 ff             	lea    -0x1(%eax),%edx
    1155:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1158:	8b 45 18             	mov    0x18(%ebp),%eax
    115b:	01 d8                	add    %ebx,%eax
    115d:	83 e8 01             	sub    $0x1,%eax
    1160:	83 ec 04             	sub    $0x4,%esp
    1163:	51                   	push   %ecx
    1164:	52                   	push   %edx
    1165:	50                   	push   %eax
    1166:	ff 75 0c             	pushl  0xc(%ebp)
    1169:	ff 75 08             	pushl  0x8(%ebp)
    116c:	e8 89 fc ff ff       	call   dfa <APDrawLine>
    1171:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1174:	8b 55 0c             	mov    0xc(%ebp),%edx
    1177:	8b 45 14             	mov    0x14(%ebp),%eax
    117a:	01 d0                	add    %edx,%eax
    117c:	8d 50 ff             	lea    -0x1(%eax),%edx
    117f:	8b 45 08             	mov    0x8(%ebp),%eax
    1182:	8b 40 0c             	mov    0xc(%eax),%eax
    1185:	89 c1                	mov    %eax,%ecx
    1187:	c1 e9 1f             	shr    $0x1f,%ecx
    118a:	01 c8                	add    %ecx,%eax
    118c:	d1 f8                	sar    %eax
    118e:	29 c2                	sub    %eax,%edx
    1190:	89 d0                	mov    %edx,%eax
    1192:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1195:	8b 55 10             	mov    0x10(%ebp),%edx
    1198:	8b 45 18             	mov    0x18(%ebp),%eax
    119b:	01 d0                	add    %edx,%eax
    119d:	8d 50 ff             	lea    -0x1(%eax),%edx
    11a0:	8b 45 08             	mov    0x8(%ebp),%eax
    11a3:	8b 40 0c             	mov    0xc(%eax),%eax
    11a6:	89 c1                	mov    %eax,%ecx
    11a8:	c1 e9 1f             	shr    $0x1f,%ecx
    11ab:	01 c8                	add    %ecx,%eax
    11ad:	d1 f8                	sar    %eax
    11af:	29 c2                	sub    %eax,%edx
    11b1:	89 d0                	mov    %edx,%eax
    11b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    11b6:	8b 45 08             	mov    0x8(%ebp),%eax
    11b9:	8b 40 0c             	mov    0xc(%eax),%eax
    11bc:	89 c2                	mov    %eax,%edx
    11be:	c1 ea 1f             	shr    $0x1f,%edx
    11c1:	01 d0                	add    %edx,%eax
    11c3:	d1 f8                	sar    %eax
    11c5:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    11c8:	8b 45 08             	mov    0x8(%ebp),%eax
    11cb:	8b 40 0c             	mov    0xc(%eax),%eax
    11ce:	89 c2                	mov    %eax,%edx
    11d0:	c1 ea 1f             	shr    $0x1f,%edx
    11d3:	01 d0                	add    %edx,%eax
    11d5:	d1 f8                	sar    %eax
    11d7:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    11da:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11de:	0f 88 d8 00 00 00    	js     12bc <APDrawRect+0x1ff>
    11e4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11e8:	0f 88 ce 00 00 00    	js     12bc <APDrawRect+0x1ff>
    11ee:	8b 45 08             	mov    0x8(%ebp),%eax
    11f1:	8b 00                	mov    (%eax),%eax
    11f3:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11f6:	0f 8e c0 00 00 00    	jle    12bc <APDrawRect+0x1ff>
    11fc:	8b 45 08             	mov    0x8(%ebp),%eax
    11ff:	8b 40 04             	mov    0x4(%eax),%eax
    1202:	3b 45 10             	cmp    0x10(%ebp),%eax
    1205:	0f 8e b1 00 00 00    	jle    12bc <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    120b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    120f:	79 07                	jns    1218 <APDrawRect+0x15b>
    1211:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1218:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    121c:	79 07                	jns    1225 <APDrawRect+0x168>
    121e:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1225:	8b 45 08             	mov    0x8(%ebp),%eax
    1228:	8b 00                	mov    (%eax),%eax
    122a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    122d:	7f 0b                	jg     123a <APDrawRect+0x17d>
    122f:	8b 45 08             	mov    0x8(%ebp),%eax
    1232:	8b 00                	mov    (%eax),%eax
    1234:	83 e8 01             	sub    $0x1,%eax
    1237:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    123a:	8b 45 08             	mov    0x8(%ebp),%eax
    123d:	8b 40 04             	mov    0x4(%eax),%eax
    1240:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1243:	7f 0c                	jg     1251 <APDrawRect+0x194>
    1245:	8b 45 08             	mov    0x8(%ebp),%eax
    1248:	8b 40 04             	mov    0x4(%eax),%eax
    124b:	83 e8 01             	sub    $0x1,%eax
    124e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1251:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1258:	8b 45 0c             	mov    0xc(%ebp),%eax
    125b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    125e:	eb 52                	jmp    12b2 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1260:	8b 45 10             	mov    0x10(%ebp),%eax
    1263:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1266:	eb 3e                	jmp    12a6 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1268:	83 ec 04             	sub    $0x4,%esp
    126b:	ff 75 e8             	pushl  -0x18(%ebp)
    126e:	ff 75 ec             	pushl  -0x14(%ebp)
    1271:	ff 75 08             	pushl  0x8(%ebp)
    1274:	e8 b2 f6 ff ff       	call   92b <APGetIndex>
    1279:	83 c4 10             	add    $0x10,%esp
    127c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    127f:	8b 45 08             	mov    0x8(%ebp),%eax
    1282:	8b 48 18             	mov    0x18(%eax),%ecx
    1285:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1288:	89 d0                	mov    %edx,%eax
    128a:	01 c0                	add    %eax,%eax
    128c:	01 d0                	add    %edx,%eax
    128e:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1291:	8b 45 08             	mov    0x8(%ebp),%eax
    1294:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1298:	66 89 0a             	mov    %cx,(%edx)
    129b:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    129f:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    12a2:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12a6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12a9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12ac:	7e ba                	jle    1268 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12ae:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    12b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12b5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    12b8:	7e a6                	jle    1260 <APDrawRect+0x1a3>
    12ba:	eb 01                	jmp    12bd <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    12bc:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    12bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12c0:	c9                   	leave  
    12c1:	c3                   	ret    

000012c2 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    12c2:	55                   	push   %ebp
    12c3:	89 e5                	mov    %esp,%ebp
    12c5:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    12c8:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    12cc:	0f 88 8e 01 00 00    	js     1460 <APDcCopy+0x19e>
    12d2:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    12d6:	0f 88 84 01 00 00    	js     1460 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    12dc:	8b 55 0c             	mov    0xc(%ebp),%edx
    12df:	8b 45 20             	mov    0x20(%ebp),%eax
    12e2:	01 d0                	add    %edx,%eax
    12e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12e7:	8b 55 10             	mov    0x10(%ebp),%edx
    12ea:	8b 45 24             	mov    0x24(%ebp),%eax
    12ed:	01 d0                	add    %edx,%eax
    12ef:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w, y_r = y + h;
    12f2:	8b 55 18             	mov    0x18(%ebp),%edx
    12f5:	8b 45 20             	mov    0x20(%ebp),%eax
    12f8:	01 d0                	add    %edx,%eax
    12fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12fd:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1300:	8b 45 24             	mov    0x24(%ebp),%eax
    1303:	01 d0                	add    %edx,%eax
    1305:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
    1308:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    130c:	0f 88 51 01 00 00    	js     1463 <APDcCopy+0x1a1>
    1312:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1316:	0f 88 47 01 00 00    	js     1463 <APDcCopy+0x1a1>
    131c:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1320:	0f 88 3d 01 00 00    	js     1463 <APDcCopy+0x1a1>
    1326:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    132a:	0f 88 33 01 00 00    	js     1463 <APDcCopy+0x1a1>
    1330:	8b 45 14             	mov    0x14(%ebp),%eax
    1333:	8b 00                	mov    (%eax),%eax
    1335:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1338:	0f 8e 25 01 00 00    	jle    1463 <APDcCopy+0x1a1>
    133e:	8b 45 14             	mov    0x14(%ebp),%eax
    1341:	8b 40 04             	mov    0x4(%eax),%eax
    1344:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1347:	0f 8e 16 01 00 00    	jle    1463 <APDcCopy+0x1a1>
        return;
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    134d:	8b 45 08             	mov    0x8(%ebp),%eax
    1350:	8b 00                	mov    (%eax),%eax
    1352:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1355:	7d 0b                	jge    1362 <APDcCopy+0xa0>
    1357:	8b 45 08             	mov    0x8(%ebp),%eax
    135a:	8b 00                	mov    (%eax),%eax
    135c:	83 e8 01             	sub    $0x1,%eax
    135f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    1362:	8b 45 08             	mov    0x8(%ebp),%eax
    1365:	8b 40 04             	mov    0x4(%eax),%eax
    1368:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    136b:	7d 0c                	jge    1379 <APDcCopy+0xb7>
    136d:	8b 45 08             	mov    0x8(%ebp),%eax
    1370:	8b 40 04             	mov    0x4(%eax),%eax
    1373:	83 e8 01             	sub    $0x1,%eax
    1376:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1379:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1380:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j < wy_r - wy; j++)
    1387:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    138e:	e9 bc 00 00 00       	jmp    144f <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1393:	8b 45 08             	mov    0x8(%ebp),%eax
    1396:	8b 00                	mov    (%eax),%eax
    1398:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    139b:	8b 55 10             	mov    0x10(%ebp),%edx
    139e:	01 ca                	add    %ecx,%edx
    13a0:	0f af d0             	imul   %eax,%edx
    13a3:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a6:	01 d0                	add    %edx,%eax
    13a8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    13ab:	8b 45 14             	mov    0x14(%ebp),%eax
    13ae:	8b 00                	mov    (%eax),%eax
    13b0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13b3:	8b 55 1c             	mov    0x1c(%ebp),%edx
    13b6:	01 ca                	add    %ecx,%edx
    13b8:	0f af d0             	imul   %eax,%edx
    13bb:	8b 45 18             	mov    0x18(%ebp),%eax
    13be:	01 d0                	add    %edx,%eax
    13c0:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i < wx_r - wx; i++)
    13c3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13ca:	eb 74                	jmp    1440 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    13cc:	8b 45 14             	mov    0x14(%ebp),%eax
    13cf:	8b 50 18             	mov    0x18(%eax),%edx
    13d2:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    13d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13d8:	01 c8                	add    %ecx,%eax
    13da:	89 c1                	mov    %eax,%ecx
    13dc:	89 c8                	mov    %ecx,%eax
    13de:	01 c0                	add    %eax,%eax
    13e0:	01 c8                	add    %ecx,%eax
    13e2:	01 d0                	add    %edx,%eax
    13e4:	0f b7 10             	movzwl (%eax),%edx
    13e7:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    13eb:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    13ef:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    13f2:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13f6:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    13fa:	38 c2                	cmp    %al,%dl
    13fc:	75 18                	jne    1416 <APDcCopy+0x154>
    13fe:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1402:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1406:	38 c2                	cmp    %al,%dl
    1408:	75 0c                	jne    1416 <APDcCopy+0x154>
    140a:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    140e:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1412:	38 c2                	cmp    %al,%dl
    1414:	74 26                	je     143c <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1416:	8b 45 08             	mov    0x8(%ebp),%eax
    1419:	8b 50 18             	mov    0x18(%eax),%edx
    141c:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    141f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1422:	01 c8                	add    %ecx,%eax
    1424:	89 c1                	mov    %eax,%ecx
    1426:	89 c8                	mov    %ecx,%eax
    1428:	01 c0                	add    %eax,%eax
    142a:	01 c8                	add    %ecx,%eax
    142c:	01 d0                	add    %edx,%eax
    142e:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1432:	66 89 10             	mov    %dx,(%eax)
    1435:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1439:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i < wx_r - wx; i++)
    143c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1440:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1443:	2b 45 0c             	sub    0xc(%ebp),%eax
    1446:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1449:	7f 81                	jg     13cc <APDcCopy+0x10a>
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    144b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    144f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1452:	2b 45 10             	sub    0x10(%ebp),%eax
    1455:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1458:	0f 8f 35 ff ff ff    	jg     1393 <APDcCopy+0xd1>
    145e:	eb 04                	jmp    1464 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1460:	90                   	nop
    1461:	eb 01                	jmp    1464 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w, y_r = y + h;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
        return;
    1463:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1464:	c9                   	leave  
    1465:	c3                   	ret    

00001466 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1466:	55                   	push   %ebp
    1467:	89 e5                	mov    %esp,%ebp
    1469:	83 ec 1c             	sub    $0x1c,%esp
    146c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    146f:	8b 55 10             	mov    0x10(%ebp),%edx
    1472:	8b 45 14             	mov    0x14(%ebp),%eax
    1475:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1478:	88 55 e8             	mov    %dl,-0x18(%ebp)
    147b:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    147e:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1482:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1485:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1489:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    148c:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1490:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1493:	8b 45 08             	mov    0x8(%ebp),%eax
    1496:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    149a:	66 89 10             	mov    %dx,(%eax)
    149d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    14a1:	88 50 02             	mov    %dl,0x2(%eax)
}
    14a4:	8b 45 08             	mov    0x8(%ebp),%eax
    14a7:	c9                   	leave  
    14a8:	c2 04 00             	ret    $0x4

000014ab <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    14ab:	55                   	push   %ebp
    14ac:	89 e5                	mov    %esp,%ebp
    14ae:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    14b1:	8b 45 08             	mov    0x8(%ebp),%eax
    14b4:	8b 00                	mov    (%eax),%eax
    14b6:	83 ec 08             	sub    $0x8,%esp
    14b9:	8d 55 0c             	lea    0xc(%ebp),%edx
    14bc:	52                   	push   %edx
    14bd:	50                   	push   %eax
    14be:	e8 45 ef ff ff       	call   408 <sendMessage>
    14c3:	83 c4 10             	add    $0x10,%esp
}
    14c6:	90                   	nop
    14c7:	c9                   	leave  
    14c8:	c3                   	ret    

000014c9 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    14c9:	55                   	push   %ebp
    14ca:	89 e5                	mov    %esp,%ebp
    14cc:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    14cf:	83 ec 0c             	sub    $0xc,%esp
    14d2:	68 90 00 00 00       	push   $0x90
    14d7:	e8 ee f2 ff ff       	call   7ca <malloc>
    14dc:	83 c4 10             	add    $0x10,%esp
    14df:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    14e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14e6:	75 15                	jne    14fd <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    14e8:	83 ec 04             	sub    $0x4,%esp
    14eb:	ff 75 08             	pushl  0x8(%ebp)
    14ee:	68 f0 1f 00 00       	push   $0x1ff0
    14f3:	6a 01                	push   $0x1
    14f5:	e8 fd ef ff ff       	call   4f7 <printf>
    14fa:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    14fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1500:	83 c0 7c             	add    $0x7c,%eax
    1503:	83 ec 08             	sub    $0x8,%esp
    1506:	ff 75 08             	pushl  0x8(%ebp)
    1509:	50                   	push   %eax
    150a:	e8 18 ec ff ff       	call   127 <strcpy>
    150f:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1512:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1515:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    151c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151f:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1526:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1529:	8b 40 34             	mov    0x34(%eax),%eax
    152c:	89 c2                	mov    %eax,%edx
    152e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1531:	8b 40 38             	mov    0x38(%eax),%eax
    1534:	0f af d0             	imul   %eax,%edx
    1537:	89 d0                	mov    %edx,%eax
    1539:	01 c0                	add    %eax,%eax
    153b:	01 d0                	add    %edx,%eax
    153d:	83 ec 0c             	sub    $0xc,%esp
    1540:	50                   	push   %eax
    1541:	e8 84 f2 ff ff       	call   7ca <malloc>
    1546:	83 c4 10             	add    $0x10,%esp
    1549:	89 c2                	mov    %eax,%edx
    154b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154e:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1551:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1554:	8b 40 4c             	mov    0x4c(%eax),%eax
    1557:	85 c0                	test   %eax,%eax
    1559:	75 15                	jne    1570 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    155b:	83 ec 04             	sub    $0x4,%esp
    155e:	ff 75 08             	pushl  0x8(%ebp)
    1561:	68 10 20 00 00       	push   $0x2010
    1566:	6a 01                	push   $0x1
    1568:	e8 8a ef ff ff       	call   4f7 <printf>
    156d:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1570:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1573:	8b 40 34             	mov    0x34(%eax),%eax
    1576:	89 c2                	mov    %eax,%edx
    1578:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157b:	8b 40 38             	mov    0x38(%eax),%eax
    157e:	0f af d0             	imul   %eax,%edx
    1581:	89 d0                	mov    %edx,%eax
    1583:	01 c0                	add    %eax,%eax
    1585:	01 c2                	add    %eax,%edx
    1587:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158a:	8b 40 4c             	mov    0x4c(%eax),%eax
    158d:	83 ec 04             	sub    $0x4,%esp
    1590:	52                   	push   %edx
    1591:	68 ff ff ff 00       	push   $0xffffff
    1596:	50                   	push   %eax
    1597:	e8 21 ec ff ff       	call   1bd <memset>
    159c:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    159f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a2:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    15a9:	e8 2a ee ff ff       	call   3d8 <getpid>
    15ae:	89 c2                	mov    %eax,%edx
    15b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b3:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    15b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b9:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    15c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c3:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    15ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cd:	8b 40 50             	mov    0x50(%eax),%eax
    15d0:	89 c2                	mov    %eax,%edx
    15d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d5:	8b 40 54             	mov    0x54(%eax),%eax
    15d8:	0f af d0             	imul   %eax,%edx
    15db:	89 d0                	mov    %edx,%eax
    15dd:	01 c0                	add    %eax,%eax
    15df:	01 d0                	add    %edx,%eax
    15e1:	83 ec 0c             	sub    $0xc,%esp
    15e4:	50                   	push   %eax
    15e5:	e8 e0 f1 ff ff       	call   7ca <malloc>
    15ea:	83 c4 10             	add    $0x10,%esp
    15ed:	89 c2                	mov    %eax,%edx
    15ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f2:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    15f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f8:	8b 40 68             	mov    0x68(%eax),%eax
    15fb:	85 c0                	test   %eax,%eax
    15fd:	75 15                	jne    1614 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    15ff:	83 ec 04             	sub    $0x4,%esp
    1602:	ff 75 08             	pushl  0x8(%ebp)
    1605:	68 34 20 00 00       	push   $0x2034
    160a:	6a 01                	push   $0x1
    160c:	e8 e6 ee ff ff       	call   4f7 <printf>
    1611:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1614:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1617:	8b 40 34             	mov    0x34(%eax),%eax
    161a:	89 c2                	mov    %eax,%edx
    161c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161f:	8b 40 38             	mov    0x38(%eax),%eax
    1622:	0f af d0             	imul   %eax,%edx
    1625:	89 d0                	mov    %edx,%eax
    1627:	01 c0                	add    %eax,%eax
    1629:	01 c2                	add    %eax,%edx
    162b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162e:	8b 40 4c             	mov    0x4c(%eax),%eax
    1631:	83 ec 04             	sub    $0x4,%esp
    1634:	52                   	push   %edx
    1635:	68 ff 00 00 00       	push   $0xff
    163a:	50                   	push   %eax
    163b:	e8 7d eb ff ff       	call   1bd <memset>
    1640:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1643:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1646:	8b 55 0c             	mov    0xc(%ebp),%edx
    1649:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    164c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1650:	74 35                	je     1687 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1652:	8b 45 10             	mov    0x10(%ebp),%eax
    1655:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    165b:	83 ec 0c             	sub    $0xc,%esp
    165e:	50                   	push   %eax
    165f:	e8 66 f1 ff ff       	call   7ca <malloc>
    1664:	83 c4 10             	add    $0x10,%esp
    1667:	89 c2                	mov    %eax,%edx
    1669:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166c:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    166f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1672:	8b 55 10             	mov    0x10(%ebp),%edx
    1675:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1678:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167b:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    1682:	e9 8d 00 00 00       	jmp    1714 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1687:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168a:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1691:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1694:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    169b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169e:	8b 40 18             	mov    0x18(%eax),%eax
    16a1:	89 c2                	mov    %eax,%edx
    16a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a6:	8b 40 1c             	mov    0x1c(%eax),%eax
    16a9:	0f af d0             	imul   %eax,%edx
    16ac:	89 d0                	mov    %edx,%eax
    16ae:	01 c0                	add    %eax,%eax
    16b0:	01 d0                	add    %edx,%eax
    16b2:	83 ec 0c             	sub    $0xc,%esp
    16b5:	50                   	push   %eax
    16b6:	e8 0f f1 ff ff       	call   7ca <malloc>
    16bb:	83 c4 10             	add    $0x10,%esp
    16be:	89 c2                	mov    %eax,%edx
    16c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c3:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    16c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c9:	8b 40 30             	mov    0x30(%eax),%eax
    16cc:	85 c0                	test   %eax,%eax
    16ce:	75 15                	jne    16e5 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    16d0:	83 ec 04             	sub    $0x4,%esp
    16d3:	ff 75 08             	pushl  0x8(%ebp)
    16d6:	68 5c 20 00 00       	push   $0x205c
    16db:	6a 01                	push   $0x1
    16dd:	e8 15 ee ff ff       	call   4f7 <printf>
    16e2:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e8:	8b 40 18             	mov    0x18(%eax),%eax
    16eb:	89 c2                	mov    %eax,%edx
    16ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f0:	8b 40 1c             	mov    0x1c(%eax),%eax
    16f3:	0f af d0             	imul   %eax,%edx
    16f6:	89 d0                	mov    %edx,%eax
    16f8:	01 c0                	add    %eax,%eax
    16fa:	01 c2                	add    %eax,%edx
    16fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ff:	8b 40 30             	mov    0x30(%eax),%eax
    1702:	83 ec 04             	sub    $0x4,%esp
    1705:	52                   	push   %edx
    1706:	68 ff ff ff 00       	push   $0xffffff
    170b:	50                   	push   %eax
    170c:	e8 ac ea ff ff       	call   1bd <memset>
    1711:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1714:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1717:	c9                   	leave  
    1718:	c3                   	ret    

00001719 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1719:	55                   	push   %ebp
    171a:	89 e5                	mov    %esp,%ebp
    171c:	53                   	push   %ebx
    171d:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1720:	8b 45 0c             	mov    0xc(%ebp),%eax
    1723:	83 f8 03             	cmp    $0x3,%eax
    1726:	74 02                	je     172a <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1728:	eb 33                	jmp    175d <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    172a:	8b 45 08             	mov    0x8(%ebp),%eax
    172d:	8b 48 08             	mov    0x8(%eax),%ecx
    1730:	8b 45 08             	mov    0x8(%ebp),%eax
    1733:	8b 50 38             	mov    0x38(%eax),%edx
    1736:	8b 45 08             	mov    0x8(%ebp),%eax
    1739:	8b 40 34             	mov    0x34(%eax),%eax
    173c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    173f:	83 c3 34             	add    $0x34,%ebx
    1742:	83 ec 0c             	sub    $0xc,%esp
    1745:	51                   	push   %ecx
    1746:	52                   	push   %edx
    1747:	50                   	push   %eax
    1748:	6a 00                	push   $0x0
    174a:	6a 00                	push   $0x0
    174c:	53                   	push   %ebx
    174d:	6a 32                	push   $0x32
    174f:	6a 00                	push   $0x0
    1751:	ff 75 08             	pushl  0x8(%ebp)
    1754:	e8 9f ec ff ff       	call   3f8 <paintWindow>
    1759:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    175c:	90                   	nop
        default: break;
            
            
    }
    return False;
    175d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1762:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1765:	c9                   	leave  
    1766:	c3                   	ret    

00001767 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1767:	55                   	push   %ebp
    1768:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    176a:	8b 45 0c             	mov    0xc(%ebp),%eax
    176d:	8b 50 08             	mov    0x8(%eax),%edx
    1770:	8b 45 08             	mov    0x8(%ebp),%eax
    1773:	8b 00                	mov    (%eax),%eax
    1775:	39 c2                	cmp    %eax,%edx
    1777:	74 07                	je     1780 <APPreJudge+0x19>
        return False;
    1779:	b8 00 00 00 00       	mov    $0x0,%eax
    177e:	eb 05                	jmp    1785 <APPreJudge+0x1e>
    return True;
    1780:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1785:	5d                   	pop    %ebp
    1786:	c3                   	ret    

00001787 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1787:	55                   	push   %ebp
    1788:	89 e5                	mov    %esp,%ebp
    178a:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    178d:	8b 45 08             	mov    0x8(%ebp),%eax
    1790:	8b 55 0c             	mov    0xc(%ebp),%edx
    1793:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    1796:	83 ec 0c             	sub    $0xc,%esp
    1799:	ff 75 08             	pushl  0x8(%ebp)
    179c:	e8 77 ec ff ff       	call   418 <registWindow>
    17a1:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    17a4:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    17ab:	8b 45 08             	mov    0x8(%ebp),%eax
    17ae:	8b 00                	mov    (%eax),%eax
    17b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    17b3:	ff 75 f4             	pushl  -0xc(%ebp)
    17b6:	ff 75 f0             	pushl  -0x10(%ebp)
    17b9:	ff 75 ec             	pushl  -0x14(%ebp)
    17bc:	ff 75 08             	pushl  0x8(%ebp)
    17bf:	e8 e7 fc ff ff       	call   14ab <APSendMessage>
    17c4:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    17c7:	83 ec 0c             	sub    $0xc,%esp
    17ca:	ff 75 08             	pushl  0x8(%ebp)
    17cd:	e8 3e ec ff ff       	call   410 <getMessage>
    17d2:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    17d5:	8b 45 08             	mov    0x8(%ebp),%eax
    17d8:	83 c0 6c             	add    $0x6c,%eax
    17db:	83 ec 08             	sub    $0x8,%esp
    17de:	50                   	push   %eax
    17df:	ff 75 08             	pushl  0x8(%ebp)
    17e2:	e8 80 ff ff ff       	call   1767 <APPreJudge>
    17e7:	83 c4 10             	add    $0x10,%esp
    17ea:	84 c0                	test   %al,%al
    17ec:	74 1b                	je     1809 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    17ee:	8b 45 08             	mov    0x8(%ebp),%eax
    17f1:	ff 70 74             	pushl  0x74(%eax)
    17f4:	ff 70 70             	pushl  0x70(%eax)
    17f7:	ff 70 6c             	pushl  0x6c(%eax)
    17fa:	ff 75 08             	pushl  0x8(%ebp)
    17fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    1800:	ff d0                	call   *%eax
    1802:	83 c4 10             	add    $0x10,%esp
    1805:	84 c0                	test   %al,%al
    1807:	75 0c                	jne    1815 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1809:	8b 45 08             	mov    0x8(%ebp),%eax
    180c:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1813:	eb b2                	jmp    17c7 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1815:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1816:	90                   	nop
    1817:	c9                   	leave  
    1818:	c3                   	ret    

00001819 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1819:	55                   	push   %ebp
    181a:	89 e5                	mov    %esp,%ebp
    181c:	57                   	push   %edi
    181d:	56                   	push   %esi
    181e:	53                   	push   %ebx
    181f:	83 ec 4c             	sub    $0x4c,%esp
    if (!iconReady)
    1822:	a1 4c 26 00 00       	mov    0x264c,%eax
    1827:	85 c0                	test   %eax,%eax
    1829:	75 7c                	jne    18a7 <APGridPaint+0x8e>
    {
        iconReady = 1;
    182b:	c7 05 4c 26 00 00 01 	movl   $0x1,0x264c
    1832:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("Snake.bmp");
    1835:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1838:	83 ec 08             	sub    $0x8,%esp
    183b:	68 83 20 00 00       	push   $0x2083
    1840:	50                   	push   %eax
    1841:	e8 37 f1 ff ff       	call   97d <APLoadBitmap>
    1846:	83 c4 0c             	add    $0xc,%esp
    1849:	8b 45 b8             	mov    -0x48(%ebp),%eax
    184c:	a3 50 26 00 00       	mov    %eax,0x2650
    1851:	8b 45 bc             	mov    -0x44(%ebp),%eax
    1854:	a3 54 26 00 00       	mov    %eax,0x2654
    1859:	8b 45 c0             	mov    -0x40(%ebp),%eax
    185c:	a3 58 26 00 00       	mov    %eax,0x2658
        printf(1,"bitmap loaded!\n");
    1861:	83 ec 08             	sub    $0x8,%esp
    1864:	68 8d 20 00 00       	push   $0x208d
    1869:	6a 01                	push   $0x1
    186b:	e8 87 ec ff ff       	call   4f7 <printf>
    1870:	83 c4 10             	add    $0x10,%esp
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1873:	83 ec 04             	sub    $0x4,%esp
    1876:	ff 35 58 26 00 00    	pushl  0x2658
    187c:	ff 35 54 26 00 00    	pushl  0x2654
    1882:	ff 35 50 26 00 00    	pushl  0x2650
    1888:	e8 7a f3 ff ff       	call   c07 <APCreateCompatibleDCFromBitmap>
    188d:	83 c4 10             	add    $0x10,%esp
    1890:	a3 5c 26 00 00       	mov    %eax,0x265c
        printf(1,"bitmap DC created!\n");
    1895:	83 ec 08             	sub    $0x8,%esp
    1898:	68 9d 20 00 00       	push   $0x209d
    189d:	6a 01                	push   $0x1
    189f:	e8 53 ec ff ff       	call   4f7 <printf>
    18a4:	83 c4 10             	add    $0x10,%esp
    }
    
    if (!wnd->is_grid)
    18a7:	8b 45 08             	mov    0x8(%ebp),%eax
    18aa:	8b 40 08             	mov    0x8(%eax),%eax
    18ad:	85 c0                	test   %eax,%eax
    18af:	75 17                	jne    18c8 <APGridPaint+0xaf>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    18b1:	83 ec 08             	sub    $0x8,%esp
    18b4:	68 b4 20 00 00       	push   $0x20b4
    18b9:	6a 01                	push   $0x1
    18bb:	e8 37 ec ff ff       	call   4f7 <printf>
    18c0:	83 c4 10             	add    $0x10,%esp
        return;
    18c3:	e9 55 03 00 00       	jmp    1c1d <APGridPaint+0x404>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    18c8:	8b 45 08             	mov    0x8(%ebp),%eax
    18cb:	8b 40 10             	mov    0x10(%eax),%eax
    18ce:	85 c0                	test   %eax,%eax
    18d0:	7e 10                	jle    18e2 <APGridPaint+0xc9>
    18d2:	8b 45 08             	mov    0x8(%ebp),%eax
    18d5:	8b 50 14             	mov    0x14(%eax),%edx
    18d8:	8b 45 08             	mov    0x8(%ebp),%eax
    18db:	8b 40 10             	mov    0x10(%eax),%eax
    18de:	39 c2                	cmp    %eax,%edx
    18e0:	7c 17                	jl     18f9 <APGridPaint+0xe0>
    {
        printf(1,"Grid mode page error!");
    18e2:	83 ec 08             	sub    $0x8,%esp
    18e5:	68 da 20 00 00       	push   $0x20da
    18ea:	6a 01                	push   $0x1
    18ec:	e8 06 ec ff ff       	call   4f7 <printf>
    18f1:	83 c4 10             	add    $0x10,%esp
        return;
    18f4:	e9 24 03 00 00       	jmp    1c1d <APGridPaint+0x404>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    18f9:	8b 45 08             	mov    0x8(%ebp),%eax
    18fc:	8b 40 14             	mov    0x14(%eax),%eax
    18ff:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1905:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1908:	8b 45 dc             	mov    -0x24(%ebp),%eax
    190b:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    190e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1915:	e9 f9 02 00 00       	jmp    1c13 <APGridPaint+0x3fa>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    191a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1921:	e9 df 02 00 00       	jmp    1c05 <APGridPaint+0x3ec>
        {
            index = start + GRID_W_NUMBER * j + i;
    1926:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1929:	c1 e0 04             	shl    $0x4,%eax
    192c:	89 c2                	mov    %eax,%edx
    192e:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1931:	01 c2                	add    %eax,%edx
    1933:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1936:	01 d0                	add    %edx,%eax
    1938:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    193b:	8b 45 08             	mov    0x8(%ebp),%eax
    193e:	8b 40 0c             	mov    0xc(%eax),%eax
    1941:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1944:	c1 e2 02             	shl    $0x2,%edx
    1947:	01 d0                	add    %edx,%eax
    1949:	8b 00                	mov    (%eax),%eax
    194b:	83 f8 01             	cmp    $0x1,%eax
    194e:	0f 84 83 00 00 00    	je     19d7 <APGridPaint+0x1be>
    1954:	83 f8 01             	cmp    $0x1,%eax
    1957:	7f 09                	jg     1962 <APGridPaint+0x149>
    1959:	85 c0                	test   %eax,%eax
    195b:	74 1c                	je     1979 <APGridPaint+0x160>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    195d:	e9 9f 02 00 00       	jmp    1c01 <APGridPaint+0x3e8>
        for (int i = 0; i < GRID_W_NUMBER;i++)
        {
            index = start + GRID_W_NUMBER * j + i;
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1962:	83 f8 02             	cmp    $0x2,%eax
    1965:	0f 84 20 01 00 00    	je     1a8b <APGridPaint+0x272>
    196b:	83 f8 03             	cmp    $0x3,%eax
    196e:	0f 84 d1 01 00 00    	je     1b45 <APGridPaint+0x32c>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    1974:	e9 88 02 00 00       	jmp    1c01 <APGridPaint+0x3e8>
                    pen.size = 1;
                    brush.color = RGB(0xd2,0x69,0x1e);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);*/
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1979:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    197c:	6a 0c                	push   $0xc
    197e:	6a 0c                	push   $0xc
    1980:	6a 0c                	push   $0xc
    1982:	50                   	push   %eax
    1983:	e8 de fa ff ff       	call   1466 <RGB>
    1988:	83 c4 0c             	add    $0xc,%esp
    198b:	8b 1d 5c 26 00 00    	mov    0x265c,%ebx
    1991:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1994:	6b c8 32             	imul   $0x32,%eax,%ecx
    1997:	8b 45 e0             	mov    -0x20(%ebp),%eax
    199a:	6b c0 32             	imul   $0x32,%eax,%eax
    199d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    19a0:	8b 45 08             	mov    0x8(%ebp),%eax
    19a3:	8d 78 34             	lea    0x34(%eax),%edi
    19a6:	83 ec 0c             	sub    $0xc,%esp
    19a9:	83 ec 04             	sub    $0x4,%esp
    19ac:	89 e0                	mov    %esp,%eax
    19ae:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    19b2:	66 89 30             	mov    %si,(%eax)
    19b5:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    19b9:	88 50 02             	mov    %dl,0x2(%eax)
    19bc:	6a 32                	push   $0x32
    19be:	6a 32                	push   $0x32
    19c0:	6a 00                	push   $0x0
    19c2:	6a 00                	push   $0x0
    19c4:	53                   	push   %ebx
    19c5:	51                   	push   %ecx
    19c6:	ff 75 b4             	pushl  -0x4c(%ebp)
    19c9:	57                   	push   %edi
    19ca:	e8 f3 f8 ff ff       	call   12c2 <APDcCopy>
    19cf:	83 c4 30             	add    $0x30,%esp
                    break;
    19d2:	e9 2a 02 00 00       	jmp    1c01 <APGridPaint+0x3e8>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    19d7:	8d 45 b8             	lea    -0x48(%ebp),%eax
    19da:	6a 69                	push   $0x69
    19dc:	6a 69                	push   $0x69
    19de:	6a 69                	push   $0x69
    19e0:	50                   	push   %eax
    19e1:	e8 80 fa ff ff       	call   1466 <RGB>
    19e6:	83 c4 0c             	add    $0xc,%esp
    19e9:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    19ed:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    19f1:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    19f5:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    19f8:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    19ff:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a02:	6a 69                	push   $0x69
    1a04:	6a 69                	push   $0x69
    1a06:	6a 69                	push   $0x69
    1a08:	50                   	push   %eax
    1a09:	e8 58 fa ff ff       	call   1466 <RGB>
    1a0e:	83 c4 0c             	add    $0xc,%esp
    1a11:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1a15:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1a19:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1a1d:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1a20:	8b 45 08             	mov    0x8(%ebp),%eax
    1a23:	8d 50 34             	lea    0x34(%eax),%edx
    1a26:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a29:	ff 75 d0             	pushl  -0x30(%ebp)
    1a2c:	ff 75 cc             	pushl  -0x34(%ebp)
    1a2f:	52                   	push   %edx
    1a30:	50                   	push   %eax
    1a31:	e8 66 f2 ff ff       	call   c9c <APSetPen>
    1a36:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1a39:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3c:	8d 58 34             	lea    0x34(%eax),%ebx
    1a3f:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1a42:	83 ec 04             	sub    $0x4,%esp
    1a45:	83 ec 04             	sub    $0x4,%esp
    1a48:	89 e0                	mov    %esp,%eax
    1a4a:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1a4e:	66 89 08             	mov    %cx,(%eax)
    1a51:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1a55:	88 48 02             	mov    %cl,0x2(%eax)
    1a58:	53                   	push   %ebx
    1a59:	52                   	push   %edx
    1a5a:	e8 76 f2 ff ff       	call   cd5 <APSetBrush>
    1a5f:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1a62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a65:	6b d0 32             	imul   $0x32,%eax,%edx
    1a68:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a6b:	6b c0 32             	imul   $0x32,%eax,%eax
    1a6e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a71:	83 c1 34             	add    $0x34,%ecx
    1a74:	83 ec 0c             	sub    $0xc,%esp
    1a77:	6a 32                	push   $0x32
    1a79:	6a 32                	push   $0x32
    1a7b:	52                   	push   %edx
    1a7c:	50                   	push   %eax
    1a7d:	51                   	push   %ecx
    1a7e:	e8 3a f6 ff ff       	call   10bd <APDrawRect>
    1a83:	83 c4 20             	add    $0x20,%esp
                    break;
    1a86:	e9 76 01 00 00       	jmp    1c01 <APGridPaint+0x3e8>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    pen.color = RGB(0x00,0x80,0x00);
    1a8b:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a8e:	6a 00                	push   $0x0
    1a90:	68 80 00 00 00       	push   $0x80
    1a95:	6a 00                	push   $0x0
    1a97:	50                   	push   %eax
    1a98:	e8 c9 f9 ff ff       	call   1466 <RGB>
    1a9d:	83 c4 0c             	add    $0xc,%esp
    1aa0:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1aa4:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1aa8:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1aac:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1aaf:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0x80,0x00);
    1ab6:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1ab9:	6a 00                	push   $0x0
    1abb:	68 80 00 00 00       	push   $0x80
    1ac0:	6a 00                	push   $0x0
    1ac2:	50                   	push   %eax
    1ac3:	e8 9e f9 ff ff       	call   1466 <RGB>
    1ac8:	83 c4 0c             	add    $0xc,%esp
    1acb:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1acf:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1ad3:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1ad7:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1ada:	8b 45 08             	mov    0x8(%ebp),%eax
    1add:	8d 50 34             	lea    0x34(%eax),%edx
    1ae0:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1ae3:	ff 75 d0             	pushl  -0x30(%ebp)
    1ae6:	ff 75 cc             	pushl  -0x34(%ebp)
    1ae9:	52                   	push   %edx
    1aea:	50                   	push   %eax
    1aeb:	e8 ac f1 ff ff       	call   c9c <APSetPen>
    1af0:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1af3:	8b 45 08             	mov    0x8(%ebp),%eax
    1af6:	8d 58 34             	lea    0x34(%eax),%ebx
    1af9:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1afc:	83 ec 04             	sub    $0x4,%esp
    1aff:	83 ec 04             	sub    $0x4,%esp
    1b02:	89 e0                	mov    %esp,%eax
    1b04:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1b08:	66 89 08             	mov    %cx,(%eax)
    1b0b:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1b0f:	88 48 02             	mov    %cl,0x2(%eax)
    1b12:	53                   	push   %ebx
    1b13:	52                   	push   %edx
    1b14:	e8 bc f1 ff ff       	call   cd5 <APSetBrush>
    1b19:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b1c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b1f:	6b d0 32             	imul   $0x32,%eax,%edx
    1b22:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b25:	6b c0 32             	imul   $0x32,%eax,%eax
    1b28:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b2b:	83 c1 34             	add    $0x34,%ecx
    1b2e:	83 ec 0c             	sub    $0xc,%esp
    1b31:	6a 32                	push   $0x32
    1b33:	6a 32                	push   $0x32
    1b35:	52                   	push   %edx
    1b36:	50                   	push   %eax
    1b37:	51                   	push   %ecx
    1b38:	e8 80 f5 ff ff       	call   10bd <APDrawRect>
    1b3d:	83 c4 20             	add    $0x20,%esp
                    break;
    1b40:	e9 bc 00 00 00       	jmp    1c01 <APGridPaint+0x3e8>
                case GRID_RIVER:
                    //printf(1,"Grid_River");
                    pen.color = RGB(0x00,0xbf,0xff);
    1b45:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b48:	68 ff 00 00 00       	push   $0xff
    1b4d:	68 bf 00 00 00       	push   $0xbf
    1b52:	6a 00                	push   $0x0
    1b54:	50                   	push   %eax
    1b55:	e8 0c f9 ff ff       	call   1466 <RGB>
    1b5a:	83 c4 0c             	add    $0xc,%esp
    1b5d:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1b61:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1b65:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1b69:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1b6c:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0xbf,0xff);
    1b73:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b76:	68 ff 00 00 00       	push   $0xff
    1b7b:	68 bf 00 00 00       	push   $0xbf
    1b80:	6a 00                	push   $0x0
    1b82:	50                   	push   %eax
    1b83:	e8 de f8 ff ff       	call   1466 <RGB>
    1b88:	83 c4 0c             	add    $0xc,%esp
    1b8b:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1b8f:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1b93:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1b97:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b9a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b9d:	8d 50 34             	lea    0x34(%eax),%edx
    1ba0:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1ba3:	ff 75 d0             	pushl  -0x30(%ebp)
    1ba6:	ff 75 cc             	pushl  -0x34(%ebp)
    1ba9:	52                   	push   %edx
    1baa:	50                   	push   %eax
    1bab:	e8 ec f0 ff ff       	call   c9c <APSetPen>
    1bb0:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1bb3:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb6:	8d 58 34             	lea    0x34(%eax),%ebx
    1bb9:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1bbc:	83 ec 04             	sub    $0x4,%esp
    1bbf:	83 ec 04             	sub    $0x4,%esp
    1bc2:	89 e0                	mov    %esp,%eax
    1bc4:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1bc8:	66 89 08             	mov    %cx,(%eax)
    1bcb:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1bcf:	88 48 02             	mov    %cl,0x2(%eax)
    1bd2:	53                   	push   %ebx
    1bd3:	52                   	push   %edx
    1bd4:	e8 fc f0 ff ff       	call   cd5 <APSetBrush>
    1bd9:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
    1bdc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bdf:	6b d0 32             	imul   $0x32,%eax,%edx
    1be2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1be5:	6b c0 32             	imul   $0x32,%eax,%eax
    1be8:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1beb:	83 c1 34             	add    $0x34,%ecx
    1bee:	83 ec 0c             	sub    $0xc,%esp
    1bf1:	6a 32                	push   $0x32
    1bf3:	6a 32                	push   $0x32
    1bf5:	52                   	push   %edx
    1bf6:	50                   	push   %eax
    1bf7:	51                   	push   %ecx
    1bf8:	e8 c0 f4 ff ff       	call   10bd <APDrawRect>
    1bfd:	83 c4 20             	add    $0x20,%esp
                    break;
    1c00:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1c01:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1c05:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1c09:	0f 8e 17 fd ff ff    	jle    1926 <APGridPaint+0x10d>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1c0f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1c13:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1c17:	0f 8e fd fc ff ff    	jle    191a <APGridPaint+0x101>
                    break;
                default: break;
            }
        }
    }
}
    1c1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1c20:	5b                   	pop    %ebx
    1c21:	5e                   	pop    %esi
    1c22:	5f                   	pop    %edi
    1c23:	5d                   	pop    %ebp
    1c24:	c3                   	ret    

00001c25 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1c25:	55                   	push   %ebp
    1c26:	89 e5                	mov    %esp,%ebp
    1c28:	53                   	push   %ebx
    1c29:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1c2c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1c33:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1c37:	74 17                	je     1c50 <sprintint+0x2b>
    1c39:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1c3d:	79 11                	jns    1c50 <sprintint+0x2b>
        neg = 1;
    1c3f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1c46:	8b 45 10             	mov    0x10(%ebp),%eax
    1c49:	f7 d8                	neg    %eax
    1c4b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1c4e:	eb 06                	jmp    1c56 <sprintint+0x31>
    } else {
        x = xx;
    1c50:	8b 45 10             	mov    0x10(%ebp),%eax
    1c53:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1c56:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1c5d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1c60:	8d 41 01             	lea    0x1(%ecx),%eax
    1c63:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1c66:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1c69:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c6c:	ba 00 00 00 00       	mov    $0x0,%edx
    1c71:	f7 f3                	div    %ebx
    1c73:	89 d0                	mov    %edx,%eax
    1c75:	0f b6 80 2c 26 00 00 	movzbl 0x262c(%eax),%eax
    1c7c:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1c80:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1c83:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c86:	ba 00 00 00 00       	mov    $0x0,%edx
    1c8b:	f7 f3                	div    %ebx
    1c8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1c90:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1c94:	75 c7                	jne    1c5d <sprintint+0x38>
    if(neg)
    1c96:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1c9a:	74 0e                	je     1caa <sprintint+0x85>
        buf[i++] = '-';
    1c9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c9f:	8d 50 01             	lea    0x1(%eax),%edx
    1ca2:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1ca5:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1caa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1cad:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1cb0:	eb 1b                	jmp    1ccd <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1cb2:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cb5:	8b 00                	mov    (%eax),%eax
    1cb7:	8d 48 01             	lea    0x1(%eax),%ecx
    1cba:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cbd:	89 0a                	mov    %ecx,(%edx)
    1cbf:	89 c2                	mov    %eax,%edx
    1cc1:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc4:	01 d0                	add    %edx,%eax
    1cc6:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1cc9:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1ccd:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1cd1:	7f df                	jg     1cb2 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1cd3:	eb 21                	jmp    1cf6 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1cd5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cd8:	8b 00                	mov    (%eax),%eax
    1cda:	8d 48 01             	lea    0x1(%eax),%ecx
    1cdd:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ce0:	89 0a                	mov    %ecx,(%edx)
    1ce2:	89 c2                	mov    %eax,%edx
    1ce4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce7:	01 c2                	add    %eax,%edx
    1ce9:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1cec:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1cef:	01 c8                	add    %ecx,%eax
    1cf1:	0f b6 00             	movzbl (%eax),%eax
    1cf4:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1cf6:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1cfa:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1cfe:	79 d5                	jns    1cd5 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1d00:	90                   	nop
    1d01:	83 c4 20             	add    $0x20,%esp
    1d04:	5b                   	pop    %ebx
    1d05:	5d                   	pop    %ebp
    1d06:	c3                   	ret    

00001d07 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1d07:	55                   	push   %ebp
    1d08:	89 e5                	mov    %esp,%ebp
    1d0a:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1d0d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1d14:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1d1b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1d22:	8d 45 0c             	lea    0xc(%ebp),%eax
    1d25:	83 c0 04             	add    $0x4,%eax
    1d28:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1d2b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1d32:	e9 d9 01 00 00       	jmp    1f10 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1d37:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1d3d:	01 d0                	add    %edx,%eax
    1d3f:	0f b6 00             	movzbl (%eax),%eax
    1d42:	0f be c0             	movsbl %al,%eax
    1d45:	25 ff 00 00 00       	and    $0xff,%eax
    1d4a:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1d4d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1d51:	75 2c                	jne    1d7f <sprintf+0x78>
            if(c == '%'){
    1d53:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1d57:	75 0c                	jne    1d65 <sprintf+0x5e>
                state = '%';
    1d59:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1d60:	e9 a7 01 00 00       	jmp    1f0c <sprintf+0x205>
            } else {
                dst[j++] = c;
    1d65:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1d68:	8d 50 01             	lea    0x1(%eax),%edx
    1d6b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1d6e:	89 c2                	mov    %eax,%edx
    1d70:	8b 45 08             	mov    0x8(%ebp),%eax
    1d73:	01 d0                	add    %edx,%eax
    1d75:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1d78:	88 10                	mov    %dl,(%eax)
    1d7a:	e9 8d 01 00 00       	jmp    1f0c <sprintf+0x205>
            }
        } else if(state == '%'){
    1d7f:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1d83:	0f 85 83 01 00 00    	jne    1f0c <sprintf+0x205>
            if(c == 'd'){
    1d89:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1d8d:	75 4c                	jne    1ddb <sprintf+0xd4>
                buf[bi] = '\0';
    1d8f:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1d92:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d95:	01 d0                	add    %edx,%eax
    1d97:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1d9a:	83 ec 0c             	sub    $0xc,%esp
    1d9d:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1da0:	50                   	push   %eax
    1da1:	e8 20 e5 ff ff       	call   2c6 <atoi>
    1da6:	83 c4 10             	add    $0x10,%esp
    1da9:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1dac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1db3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1db6:	8b 00                	mov    (%eax),%eax
    1db8:	83 ec 08             	sub    $0x8,%esp
    1dbb:	ff 75 d8             	pushl  -0x28(%ebp)
    1dbe:	6a 01                	push   $0x1
    1dc0:	6a 0a                	push   $0xa
    1dc2:	50                   	push   %eax
    1dc3:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1dc6:	50                   	push   %eax
    1dc7:	ff 75 08             	pushl  0x8(%ebp)
    1dca:	e8 56 fe ff ff       	call   1c25 <sprintint>
    1dcf:	83 c4 20             	add    $0x20,%esp
                ap++;
    1dd2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1dd6:	e9 2a 01 00 00       	jmp    1f05 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1ddb:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1ddf:	74 06                	je     1de7 <sprintf+0xe0>
    1de1:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1de5:	75 4c                	jne    1e33 <sprintf+0x12c>
                buf[bi] = '\0';
    1de7:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1dea:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ded:	01 d0                	add    %edx,%eax
    1def:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1df2:	83 ec 0c             	sub    $0xc,%esp
    1df5:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1df8:	50                   	push   %eax
    1df9:	e8 c8 e4 ff ff       	call   2c6 <atoi>
    1dfe:	83 c4 10             	add    $0x10,%esp
    1e01:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1e04:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1e0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e0e:	8b 00                	mov    (%eax),%eax
    1e10:	83 ec 08             	sub    $0x8,%esp
    1e13:	ff 75 dc             	pushl  -0x24(%ebp)
    1e16:	6a 00                	push   $0x0
    1e18:	6a 10                	push   $0x10
    1e1a:	50                   	push   %eax
    1e1b:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1e1e:	50                   	push   %eax
    1e1f:	ff 75 08             	pushl  0x8(%ebp)
    1e22:	e8 fe fd ff ff       	call   1c25 <sprintint>
    1e27:	83 c4 20             	add    $0x20,%esp
                ap++;
    1e2a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1e2e:	e9 d2 00 00 00       	jmp    1f05 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1e33:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1e37:	75 46                	jne    1e7f <sprintf+0x178>
                s = (char*)*ap;
    1e39:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e3c:	8b 00                	mov    (%eax),%eax
    1e3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1e41:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1e45:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e49:	75 25                	jne    1e70 <sprintf+0x169>
                    s = "(null)";
    1e4b:	c7 45 f4 f0 20 00 00 	movl   $0x20f0,-0xc(%ebp)
                while(*s != 0){
    1e52:	eb 1c                	jmp    1e70 <sprintf+0x169>
                    dst[j++] = *s;
    1e54:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e57:	8d 50 01             	lea    0x1(%eax),%edx
    1e5a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e5d:	89 c2                	mov    %eax,%edx
    1e5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e62:	01 c2                	add    %eax,%edx
    1e64:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e67:	0f b6 00             	movzbl (%eax),%eax
    1e6a:	88 02                	mov    %al,(%edx)
                    s++;
    1e6c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    1e70:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e73:	0f b6 00             	movzbl (%eax),%eax
    1e76:	84 c0                	test   %al,%al
    1e78:	75 da                	jne    1e54 <sprintf+0x14d>
    1e7a:	e9 86 00 00 00       	jmp    1f05 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    1e7f:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    1e83:	75 1d                	jne    1ea2 <sprintf+0x19b>
                dst[j++] = *ap;
    1e85:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e88:	8d 50 01             	lea    0x1(%eax),%edx
    1e8b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e8e:	89 c2                	mov    %eax,%edx
    1e90:	8b 45 08             	mov    0x8(%ebp),%eax
    1e93:	01 c2                	add    %eax,%edx
    1e95:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e98:	8b 00                	mov    (%eax),%eax
    1e9a:	88 02                	mov    %al,(%edx)
                ap++;
    1e9c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1ea0:	eb 63                	jmp    1f05 <sprintf+0x1fe>
            } else if(c == '%'){
    1ea2:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1ea6:	75 17                	jne    1ebf <sprintf+0x1b8>
                dst[j++] = c;
    1ea8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1eab:	8d 50 01             	lea    0x1(%eax),%edx
    1eae:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1eb1:	89 c2                	mov    %eax,%edx
    1eb3:	8b 45 08             	mov    0x8(%ebp),%eax
    1eb6:	01 d0                	add    %edx,%eax
    1eb8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1ebb:	88 10                	mov    %dl,(%eax)
    1ebd:	eb 46                	jmp    1f05 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    1ebf:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    1ec3:	7e 18                	jle    1edd <sprintf+0x1d6>
    1ec5:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    1ec9:	7f 12                	jg     1edd <sprintf+0x1d6>
            {
                buf[bi++] = c;
    1ecb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ece:	8d 50 01             	lea    0x1(%eax),%edx
    1ed1:	89 55 f0             	mov    %edx,-0x10(%ebp)
    1ed4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1ed7:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    1edb:	eb 2f                	jmp    1f0c <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    1edd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1ee0:	8d 50 01             	lea    0x1(%eax),%edx
    1ee3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1ee6:	89 c2                	mov    %eax,%edx
    1ee8:	8b 45 08             	mov    0x8(%ebp),%eax
    1eeb:	01 d0                	add    %edx,%eax
    1eed:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    1ef0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1ef3:	8d 50 01             	lea    0x1(%eax),%edx
    1ef6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1ef9:	89 c2                	mov    %eax,%edx
    1efb:	8b 45 08             	mov    0x8(%ebp),%eax
    1efe:	01 d0                	add    %edx,%eax
    1f00:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f03:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    1f05:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    1f0c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1f10:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f13:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f16:	01 d0                	add    %edx,%eax
    1f18:	0f b6 00             	movzbl (%eax),%eax
    1f1b:	84 c0                	test   %al,%al
    1f1d:	0f 85 14 fe ff ff    	jne    1d37 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    1f23:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f26:	8d 50 01             	lea    0x1(%eax),%edx
    1f29:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f2c:	89 c2                	mov    %eax,%edx
    1f2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f31:	01 d0                	add    %edx,%eax
    1f33:	c6 00 00             	movb   $0x0,(%eax)
}
    1f36:	90                   	nop
    1f37:	c9                   	leave  
    1f38:	c3                   	ret    
