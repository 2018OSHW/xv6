
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
      16:	68 bb 22 00 00       	push   $0x22bb
      1b:	e8 78 03 00 00       	call   398 <open>
      20:	83 c4 10             	add    $0x10,%esp
      23:	85 c0                	test   %eax,%eax
      25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
      27:	83 ec 04             	sub    $0x4,%esp
      2a:	6a 01                	push   $0x1
      2c:	6a 01                	push   $0x1
      2e:	68 bb 22 00 00       	push   $0x22bb
      33:	e8 68 03 00 00       	call   3a0 <mknod>
      38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
      3b:	83 ec 08             	sub    $0x8,%esp
      3e:	6a 02                	push   $0x2
      40:	68 bb 22 00 00       	push   $0x22bb
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
      6a:	68 c3 22 00 00       	push   $0x22c3
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
      8a:	68 dd 22 00 00       	push   $0x22dd
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
      a7:	68 f0 29 00 00       	push   $0x29f0
      ac:	68 f0 22 00 00       	push   $0x22f0
      b1:	e8 da 02 00 00       	call   390 <exec>
      b6:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec desktop failed\n");
      b9:	83 ec 08             	sub    $0x8,%esp
      bc:	68 fa 22 00 00       	push   $0x22fa
      c1:	6a 01                	push   $0x1
      c3:	e8 2f 04 00 00       	call   4f7 <printf>
      c8:	83 c4 10             	add    $0x10,%esp
      exit();
      cb:	e8 88 02 00 00       	call   358 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
      d0:	83 ec 08             	sub    $0x8,%esp
      d3:	68 15 23 00 00       	push   $0x2315
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
     493:	0f b6 80 f8 29 00 00 	movzbl 0x29f8(%eax),%eax
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
     5d1:	c7 45 f4 1e 23 00 00 	movl   $0x231e,-0xc(%ebp)
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
     697:	a1 2c 2a 00 00       	mov    0x2a2c,%eax
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
     762:	a3 2c 2a 00 00       	mov    %eax,0x2a2c
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
     7c3:	a1 2c 2a 00 00       	mov    0x2a2c,%eax
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
     7df:	a1 2c 2a 00 00       	mov    0x2a2c,%eax
     7e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7e7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7eb:	75 23                	jne    810 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     7ed:	c7 45 f0 24 2a 00 00 	movl   $0x2a24,-0x10(%ebp)
     7f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7f7:	a3 2c 2a 00 00       	mov    %eax,0x2a2c
     7fc:	a1 2c 2a 00 00       	mov    0x2a2c,%eax
     801:	a3 24 2a 00 00       	mov    %eax,0x2a24
    base.s.size = 0;
     806:	c7 05 28 2a 00 00 00 	movl   $0x0,0x2a28
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
     863:	a3 2c 2a 00 00       	mov    %eax,0x2a2c
      return (void*)(p + 1);
     868:	8b 45 f4             	mov    -0xc(%ebp),%eax
     86b:	83 c0 08             	add    $0x8,%eax
     86e:	eb 3b                	jmp    8ab <malloc+0xe1>
    }
    if(p == freep)
     870:	a1 2c 2a 00 00       	mov    0x2a2c,%eax
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
     980:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     983:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     98a:	8b 45 cc             	mov    -0x34(%ebp),%eax
     98d:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     990:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     997:	83 ec 08             	sub    $0x8,%esp
     99a:	6a 00                	push   $0x0
     99c:	ff 75 0c             	pushl  0xc(%ebp)
     99f:	e8 f4 f9 ff ff       	call   398 <open>
     9a4:	83 c4 10             	add    $0x10,%esp
     9a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     9aa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     9ae:	79 2e                	jns    9de <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     9b0:	83 ec 04             	sub    $0x4,%esp
     9b3:	ff 75 0c             	pushl  0xc(%ebp)
     9b6:	68 25 23 00 00       	push   $0x2325
     9bb:	6a 01                	push   $0x1
     9bd:	e8 35 fb ff ff       	call   4f7 <printf>
     9c2:	83 c4 10             	add    $0x10,%esp
        return bmp;
     9c5:	8b 45 08             	mov    0x8(%ebp),%eax
     9c8:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9cb:	89 10                	mov    %edx,(%eax)
     9cd:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9d0:	89 50 04             	mov    %edx,0x4(%eax)
     9d3:	8b 55 d0             	mov    -0x30(%ebp),%edx
     9d6:	89 50 08             	mov    %edx,0x8(%eax)
     9d9:	e9 d2 01 00 00       	jmp    bb0 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     9de:	83 ec 04             	sub    $0x4,%esp
     9e1:	6a 0e                	push   $0xe
     9e3:	8d 45 ba             	lea    -0x46(%ebp),%eax
     9e6:	50                   	push   %eax
     9e7:	ff 75 ec             	pushl  -0x14(%ebp)
     9ea:	e8 81 f9 ff ff       	call   370 <read>
     9ef:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     9f2:	83 ec 04             	sub    $0x4,%esp
     9f5:	6a 28                	push   $0x28
     9f7:	8d 45 92             	lea    -0x6e(%ebp),%eax
     9fa:	50                   	push   %eax
     9fb:	ff 75 ec             	pushl  -0x14(%ebp)
     9fe:	e8 6d f9 ff ff       	call   370 <read>
     a03:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     a06:	8b 45 96             	mov    -0x6a(%ebp),%eax
     a09:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     a0c:	8b 45 9a             	mov    -0x66(%ebp),%eax
     a0f:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     a12:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a15:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a18:	0f af d0             	imul   %eax,%edx
     a1b:	89 d0                	mov    %edx,%eax
     a1d:	01 c0                	add    %eax,%eax
     a1f:	01 d0                	add    %edx,%eax
     a21:	83 ec 0c             	sub    $0xc,%esp
     a24:	50                   	push   %eax
     a25:	e8 a0 fd ff ff       	call   7ca <malloc>
     a2a:	83 c4 10             	add    $0x10,%esp
     a2d:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     a30:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a34:	0f b7 c0             	movzwl %ax,%eax
     a37:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     a3a:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a3d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a40:	0f af c2             	imul   %edx,%eax
     a43:	83 c0 1f             	add    $0x1f,%eax
     a46:	c1 e8 05             	shr    $0x5,%eax
     a49:	c1 e0 02             	shl    $0x2,%eax
     a4c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     a4f:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a55:	0f af c2             	imul   %edx,%eax
     a58:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     a5b:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a5e:	83 ec 0c             	sub    $0xc,%esp
     a61:	50                   	push   %eax
     a62:	e8 63 fd ff ff       	call   7ca <malloc>
     a67:	83 c4 10             	add    $0x10,%esp
     a6a:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a6d:	83 ec 04             	sub    $0x4,%esp
     a70:	ff 75 e0             	pushl  -0x20(%ebp)
     a73:	ff 75 dc             	pushl  -0x24(%ebp)
     a76:	ff 75 ec             	pushl  -0x14(%ebp)
     a79:	e8 f2 f8 ff ff       	call   370 <read>
     a7e:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a81:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a85:	66 c1 e8 03          	shr    $0x3,%ax
     a89:	0f b7 c0             	movzwl %ax,%eax
     a8c:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a8f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a96:	e9 e5 00 00 00       	jmp    b80 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a9b:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa1:	29 c2                	sub    %eax,%edx
     aa3:	89 d0                	mov    %edx,%eax
     aa5:	8d 50 ff             	lea    -0x1(%eax),%edx
     aa8:	8b 45 c8             	mov    -0x38(%ebp),%eax
     aab:	0f af c2             	imul   %edx,%eax
     aae:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     ab1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ab8:	e9 b1 00 00 00       	jmp    b6e <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     abd:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ac0:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ac3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ac6:	01 c8                	add    %ecx,%eax
     ac8:	89 c1                	mov    %eax,%ecx
     aca:	89 c8                	mov    %ecx,%eax
     acc:	01 c0                	add    %eax,%eax
     ace:	01 c8                	add    %ecx,%eax
     ad0:	01 c2                	add    %eax,%edx
     ad2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad5:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ad9:	89 c1                	mov    %eax,%ecx
     adb:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ade:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ae2:	01 c1                	add    %eax,%ecx
     ae4:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ae7:	01 c8                	add    %ecx,%eax
     ae9:	8d 48 ff             	lea    -0x1(%eax),%ecx
     aec:	8b 45 dc             	mov    -0x24(%ebp),%eax
     aef:	01 c8                	add    %ecx,%eax
     af1:	0f b6 00             	movzbl (%eax),%eax
     af4:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     af7:	8b 55 d0             	mov    -0x30(%ebp),%edx
     afa:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     afd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b00:	01 c8                	add    %ecx,%eax
     b02:	89 c1                	mov    %eax,%ecx
     b04:	89 c8                	mov    %ecx,%eax
     b06:	01 c0                	add    %eax,%eax
     b08:	01 c8                	add    %ecx,%eax
     b0a:	01 c2                	add    %eax,%edx
     b0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b0f:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b13:	89 c1                	mov    %eax,%ecx
     b15:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b18:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b1c:	01 c1                	add    %eax,%ecx
     b1e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b21:	01 c8                	add    %ecx,%eax
     b23:	8d 48 fe             	lea    -0x2(%eax),%ecx
     b26:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b29:	01 c8                	add    %ecx,%eax
     b2b:	0f b6 00             	movzbl (%eax),%eax
     b2e:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     b31:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b34:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b37:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b3a:	01 c8                	add    %ecx,%eax
     b3c:	89 c1                	mov    %eax,%ecx
     b3e:	89 c8                	mov    %ecx,%eax
     b40:	01 c0                	add    %eax,%eax
     b42:	01 c8                	add    %ecx,%eax
     b44:	01 c2                	add    %eax,%edx
     b46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b49:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b4d:	89 c1                	mov    %eax,%ecx
     b4f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b52:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b56:	01 c1                	add    %eax,%ecx
     b58:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b5b:	01 c8                	add    %ecx,%eax
     b5d:	8d 48 fd             	lea    -0x3(%eax),%ecx
     b60:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b63:	01 c8                	add    %ecx,%eax
     b65:	0f b6 00             	movzbl (%eax),%eax
     b68:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     b6a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b6e:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b71:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b74:	39 c2                	cmp    %eax,%edx
     b76:	0f 87 41 ff ff ff    	ja     abd <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b7c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b80:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b83:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b86:	39 c2                	cmp    %eax,%edx
     b88:	0f 87 0d ff ff ff    	ja     a9b <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b8e:	83 ec 0c             	sub    $0xc,%esp
     b91:	ff 75 ec             	pushl  -0x14(%ebp)
     b94:	e8 e7 f7 ff ff       	call   380 <close>
     b99:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b9c:	8b 45 08             	mov    0x8(%ebp),%eax
     b9f:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ba2:	89 10                	mov    %edx,(%eax)
     ba4:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ba7:	89 50 04             	mov    %edx,0x4(%eax)
     baa:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bad:	89 50 08             	mov    %edx,0x8(%eax)
}
     bb0:	8b 45 08             	mov    0x8(%ebp),%eax
     bb3:	c9                   	leave  
     bb4:	c2 04 00             	ret    $0x4

00000bb7 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     bb7:	55                   	push   %ebp
     bb8:	89 e5                	mov    %esp,%ebp
     bba:	53                   	push   %ebx
     bbb:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     bbe:	83 ec 0c             	sub    $0xc,%esp
     bc1:	6a 1c                	push   $0x1c
     bc3:	e8 02 fc ff ff       	call   7ca <malloc>
     bc8:	83 c4 10             	add    $0x10,%esp
     bcb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     bce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd1:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     bd8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     bdb:	8d 45 d8             	lea    -0x28(%ebp),%eax
     bde:	6a 0c                	push   $0xc
     be0:	6a 0c                	push   $0xc
     be2:	6a 0c                	push   $0xc
     be4:	50                   	push   %eax
     be5:	e8 c3 fc ff ff       	call   8ad <RGB>
     bea:	83 c4 0c             	add    $0xc,%esp
     bed:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     bf1:	66 89 43 13          	mov    %ax,0x13(%ebx)
     bf5:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     bf9:	88 43 15             	mov    %al,0x15(%ebx)
     bfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bff:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c02:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     c06:	66 89 48 10          	mov    %cx,0x10(%eax)
     c0a:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     c0e:	88 50 12             	mov    %dl,0x12(%eax)
     c11:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c14:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c17:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     c1b:	66 89 48 08          	mov    %cx,0x8(%eax)
     c1f:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     c23:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     c26:	8b 45 08             	mov    0x8(%ebp),%eax
     c29:	89 c2                	mov    %eax,%edx
     c2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c2e:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     c30:	8b 45 0c             	mov    0xc(%ebp),%eax
     c33:	89 c2                	mov    %eax,%edx
     c35:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c38:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     c3b:	8b 55 10             	mov    0x10(%ebp),%edx
     c3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c41:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     c44:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c47:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c4a:	c9                   	leave  
     c4b:	c3                   	ret    

00000c4c <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     c4c:	55                   	push   %ebp
     c4d:	89 e5                	mov    %esp,%ebp
     c4f:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     c52:	8b 45 0c             	mov    0xc(%ebp),%eax
     c55:	8b 50 08             	mov    0x8(%eax),%edx
     c58:	89 55 f8             	mov    %edx,-0x8(%ebp)
     c5b:	8b 40 0c             	mov    0xc(%eax),%eax
     c5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     c61:	8b 45 0c             	mov    0xc(%ebp),%eax
     c64:	8b 55 10             	mov    0x10(%ebp),%edx
     c67:	89 50 08             	mov    %edx,0x8(%eax)
     c6a:	8b 55 14             	mov    0x14(%ebp),%edx
     c6d:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c70:	8b 45 08             	mov    0x8(%ebp),%eax
     c73:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c76:	89 10                	mov    %edx,(%eax)
     c78:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c7b:	89 50 04             	mov    %edx,0x4(%eax)
}
     c7e:	8b 45 08             	mov    0x8(%ebp),%eax
     c81:	c9                   	leave  
     c82:	c2 04 00             	ret    $0x4

00000c85 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c85:	55                   	push   %ebp
     c86:	89 e5                	mov    %esp,%ebp
     c88:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c8b:	8b 45 0c             	mov    0xc(%ebp),%eax
     c8e:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c92:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c96:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c9a:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c9d:	8b 45 0c             	mov    0xc(%ebp),%eax
     ca0:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     ca4:	66 89 50 10          	mov    %dx,0x10(%eax)
     ca8:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     cac:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     caf:	8b 45 08             	mov    0x8(%ebp),%eax
     cb2:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     cb6:	66 89 10             	mov    %dx,(%eax)
     cb9:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     cbd:	88 50 02             	mov    %dl,0x2(%eax)
}
     cc0:	8b 45 08             	mov    0x8(%ebp),%eax
     cc3:	c9                   	leave  
     cc4:	c2 04 00             	ret    $0x4

00000cc7 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     cc7:	55                   	push   %ebp
     cc8:	89 e5                	mov    %esp,%ebp
     cca:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     ccd:	8b 45 08             	mov    0x8(%ebp),%eax
     cd0:	8b 40 0c             	mov    0xc(%eax),%eax
     cd3:	89 c2                	mov    %eax,%edx
     cd5:	c1 ea 1f             	shr    $0x1f,%edx
     cd8:	01 d0                	add    %edx,%eax
     cda:	d1 f8                	sar    %eax
     cdc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     cdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ce2:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     ce6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     ce9:	8b 45 10             	mov    0x10(%ebp),%eax
     cec:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cef:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     cf2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     cf6:	0f 89 98 00 00 00    	jns    d94 <APDrawPoint+0xcd>
        i = 0;
     cfc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     d03:	e9 8c 00 00 00       	jmp    d94 <APDrawPoint+0xcd>
    {
        j = x - off;
     d08:	8b 45 0c             	mov    0xc(%ebp),%eax
     d0b:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d0e:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d11:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d15:	79 69                	jns    d80 <APDrawPoint+0xb9>
            j = 0;
     d17:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d1e:	eb 60                	jmp    d80 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d20:	ff 75 fc             	pushl  -0x4(%ebp)
     d23:	ff 75 f8             	pushl  -0x8(%ebp)
     d26:	ff 75 08             	pushl  0x8(%ebp)
     d29:	e8 fd fb ff ff       	call   92b <APGetIndex>
     d2e:	83 c4 0c             	add    $0xc,%esp
     d31:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d34:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d38:	74 55                	je     d8f <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d3a:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d3e:	74 67                	je     da7 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d40:	ff 75 10             	pushl  0x10(%ebp)
     d43:	ff 75 0c             	pushl  0xc(%ebp)
     d46:	ff 75 fc             	pushl  -0x4(%ebp)
     d49:	ff 75 f8             	pushl  -0x8(%ebp)
     d4c:	e8 a1 fb ff ff       	call   8f2 <distance_2>
     d51:	83 c4 10             	add    $0x10,%esp
     d54:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d57:	7f 23                	jg     d7c <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d59:	8b 45 08             	mov    0x8(%ebp),%eax
     d5c:	8b 48 18             	mov    0x18(%eax),%ecx
     d5f:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d62:	89 d0                	mov    %edx,%eax
     d64:	01 c0                	add    %eax,%eax
     d66:	01 d0                	add    %edx,%eax
     d68:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d6b:	8b 45 08             	mov    0x8(%ebp),%eax
     d6e:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d72:	66 89 0a             	mov    %cx,(%edx)
     d75:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d79:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d7c:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d80:	8b 55 0c             	mov    0xc(%ebp),%edx
     d83:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d86:	01 d0                	add    %edx,%eax
     d88:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d8b:	7d 93                	jge    d20 <APDrawPoint+0x59>
     d8d:	eb 01                	jmp    d90 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d8f:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d90:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d94:	8b 55 10             	mov    0x10(%ebp),%edx
     d97:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d9a:	01 d0                	add    %edx,%eax
     d9c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d9f:	0f 8d 63 ff ff ff    	jge    d08 <APDrawPoint+0x41>
     da5:	eb 01                	jmp    da8 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     da7:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     da8:	c9                   	leave  
     da9:	c3                   	ret    

00000daa <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     daa:	55                   	push   %ebp
     dab:	89 e5                	mov    %esp,%ebp
     dad:	53                   	push   %ebx
     dae:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     db1:	8b 45 0c             	mov    0xc(%ebp),%eax
     db4:	3b 45 14             	cmp    0x14(%ebp),%eax
     db7:	0f 85 80 00 00 00    	jne    e3d <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     dbd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     dc1:	0f 88 9d 02 00 00    	js     1064 <APDrawLine+0x2ba>
     dc7:	8b 45 08             	mov    0x8(%ebp),%eax
     dca:	8b 00                	mov    (%eax),%eax
     dcc:	3b 45 0c             	cmp    0xc(%ebp),%eax
     dcf:	0f 8e 8f 02 00 00    	jle    1064 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     dd5:	8b 45 10             	mov    0x10(%ebp),%eax
     dd8:	3b 45 18             	cmp    0x18(%ebp),%eax
     ddb:	7e 12                	jle    def <APDrawLine+0x45>
        {
            int tmp = y2;
     ddd:	8b 45 18             	mov    0x18(%ebp),%eax
     de0:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     de3:	8b 45 10             	mov    0x10(%ebp),%eax
     de6:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     de9:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dec:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     def:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     df3:	79 07                	jns    dfc <APDrawLine+0x52>
     df5:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     dfc:	8b 45 08             	mov    0x8(%ebp),%eax
     dff:	8b 40 04             	mov    0x4(%eax),%eax
     e02:	3b 45 18             	cmp    0x18(%ebp),%eax
     e05:	7d 0c                	jge    e13 <APDrawLine+0x69>
     e07:	8b 45 08             	mov    0x8(%ebp),%eax
     e0a:	8b 40 04             	mov    0x4(%eax),%eax
     e0d:	83 e8 01             	sub    $0x1,%eax
     e10:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e13:	8b 45 10             	mov    0x10(%ebp),%eax
     e16:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e19:	eb 15                	jmp    e30 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e1b:	ff 75 f4             	pushl  -0xc(%ebp)
     e1e:	ff 75 0c             	pushl  0xc(%ebp)
     e21:	ff 75 08             	pushl  0x8(%ebp)
     e24:	e8 9e fe ff ff       	call   cc7 <APDrawPoint>
     e29:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e2c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e30:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e33:	3b 45 18             	cmp    0x18(%ebp),%eax
     e36:	7e e3                	jle    e1b <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e38:	e9 2b 02 00 00       	jmp    1068 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e3d:	8b 45 10             	mov    0x10(%ebp),%eax
     e40:	3b 45 18             	cmp    0x18(%ebp),%eax
     e43:	75 7f                	jne    ec4 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e45:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e49:	0f 88 18 02 00 00    	js     1067 <APDrawLine+0x2bd>
     e4f:	8b 45 08             	mov    0x8(%ebp),%eax
     e52:	8b 40 04             	mov    0x4(%eax),%eax
     e55:	3b 45 10             	cmp    0x10(%ebp),%eax
     e58:	0f 8e 09 02 00 00    	jle    1067 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e5e:	8b 45 0c             	mov    0xc(%ebp),%eax
     e61:	3b 45 14             	cmp    0x14(%ebp),%eax
     e64:	7e 12                	jle    e78 <APDrawLine+0xce>
        {
            int tmp = x2;
     e66:	8b 45 14             	mov    0x14(%ebp),%eax
     e69:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e6c:	8b 45 0c             	mov    0xc(%ebp),%eax
     e6f:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e72:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e75:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e78:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e7c:	79 07                	jns    e85 <APDrawLine+0xdb>
     e7e:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e85:	8b 45 08             	mov    0x8(%ebp),%eax
     e88:	8b 00                	mov    (%eax),%eax
     e8a:	3b 45 14             	cmp    0x14(%ebp),%eax
     e8d:	7d 0b                	jge    e9a <APDrawLine+0xf0>
     e8f:	8b 45 08             	mov    0x8(%ebp),%eax
     e92:	8b 00                	mov    (%eax),%eax
     e94:	83 e8 01             	sub    $0x1,%eax
     e97:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e9a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ea0:	eb 15                	jmp    eb7 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     ea2:	ff 75 10             	pushl  0x10(%ebp)
     ea5:	ff 75 f0             	pushl  -0x10(%ebp)
     ea8:	ff 75 08             	pushl  0x8(%ebp)
     eab:	e8 17 fe ff ff       	call   cc7 <APDrawPoint>
     eb0:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     eb3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     eb7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     eba:	3b 45 14             	cmp    0x14(%ebp),%eax
     ebd:	7e e3                	jle    ea2 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     ebf:	e9 a4 01 00 00       	jmp    1068 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     ec4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     ecb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     ed2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ed5:	2b 45 14             	sub    0x14(%ebp),%eax
     ed8:	50                   	push   %eax
     ed9:	e8 3d fa ff ff       	call   91b <abs_int>
     ede:	83 c4 04             	add    $0x4,%esp
     ee1:	89 c3                	mov    %eax,%ebx
     ee3:	8b 45 10             	mov    0x10(%ebp),%eax
     ee6:	2b 45 18             	sub    0x18(%ebp),%eax
     ee9:	50                   	push   %eax
     eea:	e8 2c fa ff ff       	call   91b <abs_int>
     eef:	83 c4 04             	add    $0x4,%esp
     ef2:	39 c3                	cmp    %eax,%ebx
     ef4:	0f 8e b5 00 00 00    	jle    faf <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     efa:	8b 45 10             	mov    0x10(%ebp),%eax
     efd:	2b 45 18             	sub    0x18(%ebp),%eax
     f00:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f03:	db 45 b0             	fildl  -0x50(%ebp)
     f06:	8b 45 0c             	mov    0xc(%ebp),%eax
     f09:	2b 45 14             	sub    0x14(%ebp),%eax
     f0c:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f0f:	db 45 b0             	fildl  -0x50(%ebp)
     f12:	de f9                	fdivrp %st,%st(1)
     f14:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f17:	8b 45 14             	mov    0x14(%ebp),%eax
     f1a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f1d:	7e 0e                	jle    f2d <APDrawLine+0x183>
        {
            s = x1;
     f1f:	8b 45 0c             	mov    0xc(%ebp),%eax
     f22:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f25:	8b 45 14             	mov    0x14(%ebp),%eax
     f28:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f2b:	eb 0c                	jmp    f39 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f2d:	8b 45 14             	mov    0x14(%ebp),%eax
     f30:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f33:	8b 45 0c             	mov    0xc(%ebp),%eax
     f36:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f39:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f3d:	79 07                	jns    f46 <APDrawLine+0x19c>
     f3f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f46:	8b 45 08             	mov    0x8(%ebp),%eax
     f49:	8b 00                	mov    (%eax),%eax
     f4b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f4e:	7f 0b                	jg     f5b <APDrawLine+0x1b1>
     f50:	8b 45 08             	mov    0x8(%ebp),%eax
     f53:	8b 00                	mov    (%eax),%eax
     f55:	83 e8 01             	sub    $0x1,%eax
     f58:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f5b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f5e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f61:	eb 3f                	jmp    fa2 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f63:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f66:	2b 45 0c             	sub    0xc(%ebp),%eax
     f69:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f6c:	db 45 b0             	fildl  -0x50(%ebp)
     f6f:	dc 4d d0             	fmull  -0x30(%ebp)
     f72:	db 45 10             	fildl  0x10(%ebp)
     f75:	de c1                	faddp  %st,%st(1)
     f77:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f7a:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f7e:	b4 0c                	mov    $0xc,%ah
     f80:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f84:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f87:	db 5d cc             	fistpl -0x34(%ebp)
     f8a:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f8d:	ff 75 cc             	pushl  -0x34(%ebp)
     f90:	ff 75 e4             	pushl  -0x1c(%ebp)
     f93:	ff 75 08             	pushl  0x8(%ebp)
     f96:	e8 2c fd ff ff       	call   cc7 <APDrawPoint>
     f9b:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f9e:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     fa2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fa5:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fa8:	7e b9                	jle    f63 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     faa:	e9 b9 00 00 00       	jmp    1068 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     faf:	8b 45 0c             	mov    0xc(%ebp),%eax
     fb2:	2b 45 14             	sub    0x14(%ebp),%eax
     fb5:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fb8:	db 45 b0             	fildl  -0x50(%ebp)
     fbb:	8b 45 10             	mov    0x10(%ebp),%eax
     fbe:	2b 45 18             	sub    0x18(%ebp),%eax
     fc1:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fc4:	db 45 b0             	fildl  -0x50(%ebp)
     fc7:	de f9                	fdivrp %st,%st(1)
     fc9:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     fcc:	8b 45 10             	mov    0x10(%ebp),%eax
     fcf:	3b 45 18             	cmp    0x18(%ebp),%eax
     fd2:	7e 0e                	jle    fe2 <APDrawLine+0x238>
    {
        s = y2;
     fd4:	8b 45 18             	mov    0x18(%ebp),%eax
     fd7:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     fda:	8b 45 10             	mov    0x10(%ebp),%eax
     fdd:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fe0:	eb 0c                	jmp    fee <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     fe2:	8b 45 10             	mov    0x10(%ebp),%eax
     fe5:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     fe8:	8b 45 18             	mov    0x18(%ebp),%eax
     feb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     fee:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ff2:	79 07                	jns    ffb <APDrawLine+0x251>
     ff4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     ffb:	8b 45 08             	mov    0x8(%ebp),%eax
     ffe:	8b 40 04             	mov    0x4(%eax),%eax
    1001:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1004:	7f 0c                	jg     1012 <APDrawLine+0x268>
    1006:	8b 45 08             	mov    0x8(%ebp),%eax
    1009:	8b 40 04             	mov    0x4(%eax),%eax
    100c:	83 e8 01             	sub    $0x1,%eax
    100f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1012:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1015:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1018:	eb 3f                	jmp    1059 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    101a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    101d:	2b 45 10             	sub    0x10(%ebp),%eax
    1020:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1023:	db 45 b0             	fildl  -0x50(%ebp)
    1026:	dc 4d c0             	fmull  -0x40(%ebp)
    1029:	db 45 0c             	fildl  0xc(%ebp)
    102c:	de c1                	faddp  %st,%st(1)
    102e:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1031:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1035:	b4 0c                	mov    $0xc,%ah
    1037:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    103b:	d9 6d b4             	fldcw  -0x4c(%ebp)
    103e:	db 5d bc             	fistpl -0x44(%ebp)
    1041:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1044:	ff 75 e0             	pushl  -0x20(%ebp)
    1047:	ff 75 bc             	pushl  -0x44(%ebp)
    104a:	ff 75 08             	pushl  0x8(%ebp)
    104d:	e8 75 fc ff ff       	call   cc7 <APDrawPoint>
    1052:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1055:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1059:	8b 45 e0             	mov    -0x20(%ebp),%eax
    105c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    105f:	7e b9                	jle    101a <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1061:	90                   	nop
    1062:	eb 04                	jmp    1068 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1064:	90                   	nop
    1065:	eb 01                	jmp    1068 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1067:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1068:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    106b:	c9                   	leave  
    106c:	c3                   	ret    

0000106d <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    106d:	55                   	push   %ebp
    106e:	89 e5                	mov    %esp,%ebp
    1070:	53                   	push   %ebx
    1071:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1074:	8b 55 10             	mov    0x10(%ebp),%edx
    1077:	8b 45 18             	mov    0x18(%ebp),%eax
    107a:	01 d0                	add    %edx,%eax
    107c:	83 e8 01             	sub    $0x1,%eax
    107f:	83 ec 04             	sub    $0x4,%esp
    1082:	50                   	push   %eax
    1083:	ff 75 0c             	pushl  0xc(%ebp)
    1086:	ff 75 10             	pushl  0x10(%ebp)
    1089:	ff 75 0c             	pushl  0xc(%ebp)
    108c:	ff 75 08             	pushl  0x8(%ebp)
    108f:	e8 16 fd ff ff       	call   daa <APDrawLine>
    1094:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1097:	8b 55 0c             	mov    0xc(%ebp),%edx
    109a:	8b 45 14             	mov    0x14(%ebp),%eax
    109d:	01 d0                	add    %edx,%eax
    109f:	83 e8 01             	sub    $0x1,%eax
    10a2:	83 ec 04             	sub    $0x4,%esp
    10a5:	ff 75 10             	pushl  0x10(%ebp)
    10a8:	50                   	push   %eax
    10a9:	ff 75 10             	pushl  0x10(%ebp)
    10ac:	ff 75 0c             	pushl  0xc(%ebp)
    10af:	ff 75 08             	pushl  0x8(%ebp)
    10b2:	e8 f3 fc ff ff       	call   daa <APDrawLine>
    10b7:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    10ba:	8b 55 10             	mov    0x10(%ebp),%edx
    10bd:	8b 45 18             	mov    0x18(%ebp),%eax
    10c0:	01 d0                	add    %edx,%eax
    10c2:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10c5:	8b 55 0c             	mov    0xc(%ebp),%edx
    10c8:	8b 45 14             	mov    0x14(%ebp),%eax
    10cb:	01 d0                	add    %edx,%eax
    10cd:	8d 50 ff             	lea    -0x1(%eax),%edx
    10d0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10d3:	8b 45 14             	mov    0x14(%ebp),%eax
    10d6:	01 d8                	add    %ebx,%eax
    10d8:	83 e8 01             	sub    $0x1,%eax
    10db:	83 ec 04             	sub    $0x4,%esp
    10de:	51                   	push   %ecx
    10df:	52                   	push   %edx
    10e0:	ff 75 10             	pushl  0x10(%ebp)
    10e3:	50                   	push   %eax
    10e4:	ff 75 08             	pushl  0x8(%ebp)
    10e7:	e8 be fc ff ff       	call   daa <APDrawLine>
    10ec:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10ef:	8b 55 10             	mov    0x10(%ebp),%edx
    10f2:	8b 45 18             	mov    0x18(%ebp),%eax
    10f5:	01 d0                	add    %edx,%eax
    10f7:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10fa:	8b 55 0c             	mov    0xc(%ebp),%edx
    10fd:	8b 45 14             	mov    0x14(%ebp),%eax
    1100:	01 d0                	add    %edx,%eax
    1102:	8d 50 ff             	lea    -0x1(%eax),%edx
    1105:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1108:	8b 45 18             	mov    0x18(%ebp),%eax
    110b:	01 d8                	add    %ebx,%eax
    110d:	83 e8 01             	sub    $0x1,%eax
    1110:	83 ec 04             	sub    $0x4,%esp
    1113:	51                   	push   %ecx
    1114:	52                   	push   %edx
    1115:	50                   	push   %eax
    1116:	ff 75 0c             	pushl  0xc(%ebp)
    1119:	ff 75 08             	pushl  0x8(%ebp)
    111c:	e8 89 fc ff ff       	call   daa <APDrawLine>
    1121:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1124:	8b 55 0c             	mov    0xc(%ebp),%edx
    1127:	8b 45 14             	mov    0x14(%ebp),%eax
    112a:	01 d0                	add    %edx,%eax
    112c:	8d 50 ff             	lea    -0x1(%eax),%edx
    112f:	8b 45 08             	mov    0x8(%ebp),%eax
    1132:	8b 40 0c             	mov    0xc(%eax),%eax
    1135:	89 c1                	mov    %eax,%ecx
    1137:	c1 e9 1f             	shr    $0x1f,%ecx
    113a:	01 c8                	add    %ecx,%eax
    113c:	d1 f8                	sar    %eax
    113e:	29 c2                	sub    %eax,%edx
    1140:	89 d0                	mov    %edx,%eax
    1142:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1145:	8b 55 10             	mov    0x10(%ebp),%edx
    1148:	8b 45 18             	mov    0x18(%ebp),%eax
    114b:	01 d0                	add    %edx,%eax
    114d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1150:	8b 45 08             	mov    0x8(%ebp),%eax
    1153:	8b 40 0c             	mov    0xc(%eax),%eax
    1156:	89 c1                	mov    %eax,%ecx
    1158:	c1 e9 1f             	shr    $0x1f,%ecx
    115b:	01 c8                	add    %ecx,%eax
    115d:	d1 f8                	sar    %eax
    115f:	29 c2                	sub    %eax,%edx
    1161:	89 d0                	mov    %edx,%eax
    1163:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1166:	8b 45 08             	mov    0x8(%ebp),%eax
    1169:	8b 40 0c             	mov    0xc(%eax),%eax
    116c:	89 c2                	mov    %eax,%edx
    116e:	c1 ea 1f             	shr    $0x1f,%edx
    1171:	01 d0                	add    %edx,%eax
    1173:	d1 f8                	sar    %eax
    1175:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1178:	8b 45 08             	mov    0x8(%ebp),%eax
    117b:	8b 40 0c             	mov    0xc(%eax),%eax
    117e:	89 c2                	mov    %eax,%edx
    1180:	c1 ea 1f             	shr    $0x1f,%edx
    1183:	01 d0                	add    %edx,%eax
    1185:	d1 f8                	sar    %eax
    1187:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    118a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    118e:	0f 88 d8 00 00 00    	js     126c <APDrawRect+0x1ff>
    1194:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1198:	0f 88 ce 00 00 00    	js     126c <APDrawRect+0x1ff>
    119e:	8b 45 08             	mov    0x8(%ebp),%eax
    11a1:	8b 00                	mov    (%eax),%eax
    11a3:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11a6:	0f 8e c0 00 00 00    	jle    126c <APDrawRect+0x1ff>
    11ac:	8b 45 08             	mov    0x8(%ebp),%eax
    11af:	8b 40 04             	mov    0x4(%eax),%eax
    11b2:	3b 45 10             	cmp    0x10(%ebp),%eax
    11b5:	0f 8e b1 00 00 00    	jle    126c <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    11bb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11bf:	79 07                	jns    11c8 <APDrawRect+0x15b>
    11c1:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    11c8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    11cc:	79 07                	jns    11d5 <APDrawRect+0x168>
    11ce:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    11d5:	8b 45 08             	mov    0x8(%ebp),%eax
    11d8:	8b 00                	mov    (%eax),%eax
    11da:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11dd:	7f 0b                	jg     11ea <APDrawRect+0x17d>
    11df:	8b 45 08             	mov    0x8(%ebp),%eax
    11e2:	8b 00                	mov    (%eax),%eax
    11e4:	83 e8 01             	sub    $0x1,%eax
    11e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    11ea:	8b 45 08             	mov    0x8(%ebp),%eax
    11ed:	8b 40 04             	mov    0x4(%eax),%eax
    11f0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11f3:	7f 0c                	jg     1201 <APDrawRect+0x194>
    11f5:	8b 45 08             	mov    0x8(%ebp),%eax
    11f8:	8b 40 04             	mov    0x4(%eax),%eax
    11fb:	83 e8 01             	sub    $0x1,%eax
    11fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1201:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1208:	8b 45 0c             	mov    0xc(%ebp),%eax
    120b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    120e:	eb 52                	jmp    1262 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1210:	8b 45 10             	mov    0x10(%ebp),%eax
    1213:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1216:	eb 3e                	jmp    1256 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1218:	83 ec 04             	sub    $0x4,%esp
    121b:	ff 75 e8             	pushl  -0x18(%ebp)
    121e:	ff 75 ec             	pushl  -0x14(%ebp)
    1221:	ff 75 08             	pushl  0x8(%ebp)
    1224:	e8 02 f7 ff ff       	call   92b <APGetIndex>
    1229:	83 c4 10             	add    $0x10,%esp
    122c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    122f:	8b 45 08             	mov    0x8(%ebp),%eax
    1232:	8b 48 18             	mov    0x18(%eax),%ecx
    1235:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1238:	89 d0                	mov    %edx,%eax
    123a:	01 c0                	add    %eax,%eax
    123c:	01 d0                	add    %edx,%eax
    123e:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1241:	8b 45 08             	mov    0x8(%ebp),%eax
    1244:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1248:	66 89 0a             	mov    %cx,(%edx)
    124b:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    124f:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1252:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1256:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1259:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    125c:	7e ba                	jle    1218 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    125e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1262:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1265:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1268:	7e a6                	jle    1210 <APDrawRect+0x1a3>
    126a:	eb 01                	jmp    126d <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    126c:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    126d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1270:	c9                   	leave  
    1271:	c3                   	ret    

00001272 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1272:	55                   	push   %ebp
    1273:	89 e5                	mov    %esp,%ebp
}
    1275:	90                   	nop
    1276:	5d                   	pop    %ebp
    1277:	c3                   	ret    

00001278 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1278:	55                   	push   %ebp
    1279:	89 e5                	mov    %esp,%ebp
    127b:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    127e:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1282:	0f 88 8e 01 00 00    	js     1416 <APDcCopy+0x19e>
    1288:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    128c:	0f 88 84 01 00 00    	js     1416 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1292:	8b 55 0c             	mov    0xc(%ebp),%edx
    1295:	8b 45 20             	mov    0x20(%ebp),%eax
    1298:	01 d0                	add    %edx,%eax
    129a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    129d:	8b 55 10             	mov    0x10(%ebp),%edx
    12a0:	8b 45 24             	mov    0x24(%ebp),%eax
    12a3:	01 d0                	add    %edx,%eax
    12a5:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    12a8:	8b 55 18             	mov    0x18(%ebp),%edx
    12ab:	8b 45 20             	mov    0x20(%ebp),%eax
    12ae:	01 d0                	add    %edx,%eax
    12b0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12b3:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12b6:	8b 45 24             	mov    0x24(%ebp),%eax
    12b9:	01 d0                	add    %edx,%eax
    12bb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    12be:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    12c2:	0f 88 51 01 00 00    	js     1419 <APDcCopy+0x1a1>
    12c8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12cc:	0f 88 47 01 00 00    	js     1419 <APDcCopy+0x1a1>
    12d2:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    12d6:	0f 88 3d 01 00 00    	js     1419 <APDcCopy+0x1a1>
    12dc:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    12e0:	0f 88 33 01 00 00    	js     1419 <APDcCopy+0x1a1>
    12e6:	8b 45 14             	mov    0x14(%ebp),%eax
    12e9:	8b 00                	mov    (%eax),%eax
    12eb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    12ee:	0f 8c 25 01 00 00    	jl     1419 <APDcCopy+0x1a1>
    12f4:	8b 45 14             	mov    0x14(%ebp),%eax
    12f7:	8b 40 04             	mov    0x4(%eax),%eax
    12fa:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12fd:	0f 8c 16 01 00 00    	jl     1419 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1303:	8b 45 08             	mov    0x8(%ebp),%eax
    1306:	8b 00                	mov    (%eax),%eax
    1308:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    130b:	7f 0b                	jg     1318 <APDcCopy+0xa0>
    130d:	8b 45 08             	mov    0x8(%ebp),%eax
    1310:	8b 00                	mov    (%eax),%eax
    1312:	83 e8 01             	sub    $0x1,%eax
    1315:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1318:	8b 45 08             	mov    0x8(%ebp),%eax
    131b:	8b 40 04             	mov    0x4(%eax),%eax
    131e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1321:	7f 0c                	jg     132f <APDcCopy+0xb7>
    1323:	8b 45 08             	mov    0x8(%ebp),%eax
    1326:	8b 40 04             	mov    0x4(%eax),%eax
    1329:	83 e8 01             	sub    $0x1,%eax
    132c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    132f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1336:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    133d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1344:	e9 bc 00 00 00       	jmp    1405 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1349:	8b 45 08             	mov    0x8(%ebp),%eax
    134c:	8b 00                	mov    (%eax),%eax
    134e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1351:	8b 55 10             	mov    0x10(%ebp),%edx
    1354:	01 ca                	add    %ecx,%edx
    1356:	0f af d0             	imul   %eax,%edx
    1359:	8b 45 0c             	mov    0xc(%ebp),%eax
    135c:	01 d0                	add    %edx,%eax
    135e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1361:	8b 45 14             	mov    0x14(%ebp),%eax
    1364:	8b 00                	mov    (%eax),%eax
    1366:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1369:	8b 55 1c             	mov    0x1c(%ebp),%edx
    136c:	01 ca                	add    %ecx,%edx
    136e:	0f af d0             	imul   %eax,%edx
    1371:	8b 45 18             	mov    0x18(%ebp),%eax
    1374:	01 d0                	add    %edx,%eax
    1376:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1379:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1380:	eb 74                	jmp    13f6 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1382:	8b 45 14             	mov    0x14(%ebp),%eax
    1385:	8b 50 18             	mov    0x18(%eax),%edx
    1388:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    138b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    138e:	01 c8                	add    %ecx,%eax
    1390:	89 c1                	mov    %eax,%ecx
    1392:	89 c8                	mov    %ecx,%eax
    1394:	01 c0                	add    %eax,%eax
    1396:	01 c8                	add    %ecx,%eax
    1398:	01 d0                	add    %edx,%eax
    139a:	0f b7 10             	movzwl (%eax),%edx
    139d:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    13a1:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    13a5:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    13a8:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13ac:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    13b0:	38 c2                	cmp    %al,%dl
    13b2:	75 18                	jne    13cc <APDcCopy+0x154>
    13b4:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    13b8:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    13bc:	38 c2                	cmp    %al,%dl
    13be:	75 0c                	jne    13cc <APDcCopy+0x154>
    13c0:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    13c4:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    13c8:	38 c2                	cmp    %al,%dl
    13ca:	74 26                	je     13f2 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    13cc:	8b 45 08             	mov    0x8(%ebp),%eax
    13cf:	8b 50 18             	mov    0x18(%eax),%edx
    13d2:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    13d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13d8:	01 c8                	add    %ecx,%eax
    13da:	89 c1                	mov    %eax,%ecx
    13dc:	89 c8                	mov    %ecx,%eax
    13de:	01 c0                	add    %eax,%eax
    13e0:	01 c8                	add    %ecx,%eax
    13e2:	01 d0                	add    %edx,%eax
    13e4:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    13e8:	66 89 10             	mov    %dx,(%eax)
    13eb:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13ef:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    13f2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    13f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13f9:	2b 45 0c             	sub    0xc(%ebp),%eax
    13fc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    13ff:	7d 81                	jge    1382 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1401:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1405:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1408:	2b 45 10             	sub    0x10(%ebp),%eax
    140b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    140e:	0f 8d 35 ff ff ff    	jge    1349 <APDcCopy+0xd1>
    1414:	eb 04                	jmp    141a <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1416:	90                   	nop
    1417:	eb 01                	jmp    141a <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1419:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    141a:	c9                   	leave  
    141b:	c3                   	ret    

0000141c <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    141c:	55                   	push   %ebp
    141d:	89 e5                	mov    %esp,%ebp
    141f:	83 ec 1c             	sub    $0x1c,%esp
    1422:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1425:	8b 55 10             	mov    0x10(%ebp),%edx
    1428:	8b 45 14             	mov    0x14(%ebp),%eax
    142b:	88 4d ec             	mov    %cl,-0x14(%ebp)
    142e:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1431:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1434:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1438:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    143b:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    143f:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1442:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1446:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1449:	8b 45 08             	mov    0x8(%ebp),%eax
    144c:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1450:	66 89 10             	mov    %dx,(%eax)
    1453:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1457:	88 50 02             	mov    %dl,0x2(%eax)
}
    145a:	8b 45 08             	mov    0x8(%ebp),%eax
    145d:	c9                   	leave  
    145e:	c2 04 00             	ret    $0x4

00001461 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1461:	55                   	push   %ebp
    1462:	89 e5                	mov    %esp,%ebp
    1464:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1467:	8b 45 08             	mov    0x8(%ebp),%eax
    146a:	8b 00                	mov    (%eax),%eax
    146c:	83 ec 08             	sub    $0x8,%esp
    146f:	8d 55 0c             	lea    0xc(%ebp),%edx
    1472:	52                   	push   %edx
    1473:	50                   	push   %eax
    1474:	e8 87 ef ff ff       	call   400 <sendMessage>
    1479:	83 c4 10             	add    $0x10,%esp
}
    147c:	90                   	nop
    147d:	c9                   	leave  
    147e:	c3                   	ret    

0000147f <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    147f:	55                   	push   %ebp
    1480:	89 e5                	mov    %esp,%ebp
    1482:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1485:	83 ec 0c             	sub    $0xc,%esp
    1488:	68 98 00 00 00       	push   $0x98
    148d:	e8 38 f3 ff ff       	call   7ca <malloc>
    1492:	83 c4 10             	add    $0x10,%esp
    1495:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1498:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    149c:	75 15                	jne    14b3 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    149e:	83 ec 04             	sub    $0x4,%esp
    14a1:	ff 75 08             	pushl  0x8(%ebp)
    14a4:	68 38 23 00 00       	push   $0x2338
    14a9:	6a 01                	push   $0x1
    14ab:	e8 47 f0 ff ff       	call   4f7 <printf>
    14b0:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    14b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b6:	05 84 00 00 00       	add    $0x84,%eax
    14bb:	83 ec 08             	sub    $0x8,%esp
    14be:	ff 75 08             	pushl  0x8(%ebp)
    14c1:	50                   	push   %eax
    14c2:	e8 60 ec ff ff       	call   127 <strcpy>
    14c7:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    14ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cd:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    14d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d7:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e1:	8b 40 3c             	mov    0x3c(%eax),%eax
    14e4:	89 c2                	mov    %eax,%edx
    14e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e9:	8b 40 40             	mov    0x40(%eax),%eax
    14ec:	0f af d0             	imul   %eax,%edx
    14ef:	89 d0                	mov    %edx,%eax
    14f1:	01 c0                	add    %eax,%eax
    14f3:	01 d0                	add    %edx,%eax
    14f5:	83 ec 0c             	sub    $0xc,%esp
    14f8:	50                   	push   %eax
    14f9:	e8 cc f2 ff ff       	call   7ca <malloc>
    14fe:	83 c4 10             	add    $0x10,%esp
    1501:	89 c2                	mov    %eax,%edx
    1503:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1506:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1509:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150c:	8b 40 54             	mov    0x54(%eax),%eax
    150f:	85 c0                	test   %eax,%eax
    1511:	75 15                	jne    1528 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1513:	83 ec 04             	sub    $0x4,%esp
    1516:	ff 75 08             	pushl  0x8(%ebp)
    1519:	68 58 23 00 00       	push   $0x2358
    151e:	6a 01                	push   $0x1
    1520:	e8 d2 ef ff ff       	call   4f7 <printf>
    1525:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1528:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152b:	8b 40 3c             	mov    0x3c(%eax),%eax
    152e:	89 c2                	mov    %eax,%edx
    1530:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1533:	8b 40 40             	mov    0x40(%eax),%eax
    1536:	0f af d0             	imul   %eax,%edx
    1539:	89 d0                	mov    %edx,%eax
    153b:	01 c0                	add    %eax,%eax
    153d:	01 c2                	add    %eax,%edx
    153f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1542:	8b 40 54             	mov    0x54(%eax),%eax
    1545:	83 ec 04             	sub    $0x4,%esp
    1548:	52                   	push   %edx
    1549:	68 ff ff ff 00       	push   $0xffffff
    154e:	50                   	push   %eax
    154f:	e8 69 ec ff ff       	call   1bd <memset>
    1554:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1557:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155a:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1561:	e8 72 ee ff ff       	call   3d8 <getpid>
    1566:	89 c2                	mov    %eax,%edx
    1568:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156b:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    156e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1571:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1578:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157b:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1582:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1585:	8b 40 58             	mov    0x58(%eax),%eax
    1588:	89 c2                	mov    %eax,%edx
    158a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158d:	8b 40 5c             	mov    0x5c(%eax),%eax
    1590:	0f af d0             	imul   %eax,%edx
    1593:	89 d0                	mov    %edx,%eax
    1595:	01 c0                	add    %eax,%eax
    1597:	01 d0                	add    %edx,%eax
    1599:	83 ec 0c             	sub    $0xc,%esp
    159c:	50                   	push   %eax
    159d:	e8 28 f2 ff ff       	call   7ca <malloc>
    15a2:	83 c4 10             	add    $0x10,%esp
    15a5:	89 c2                	mov    %eax,%edx
    15a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15aa:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    15ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b0:	8b 40 70             	mov    0x70(%eax),%eax
    15b3:	85 c0                	test   %eax,%eax
    15b5:	75 15                	jne    15cc <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    15b7:	83 ec 04             	sub    $0x4,%esp
    15ba:	ff 75 08             	pushl  0x8(%ebp)
    15bd:	68 7c 23 00 00       	push   $0x237c
    15c2:	6a 01                	push   $0x1
    15c4:	e8 2e ef ff ff       	call   4f7 <printf>
    15c9:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cf:	8b 40 3c             	mov    0x3c(%eax),%eax
    15d2:	89 c2                	mov    %eax,%edx
    15d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d7:	8b 40 40             	mov    0x40(%eax),%eax
    15da:	0f af d0             	imul   %eax,%edx
    15dd:	89 d0                	mov    %edx,%eax
    15df:	01 c0                	add    %eax,%eax
    15e1:	01 c2                	add    %eax,%edx
    15e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e6:	8b 40 54             	mov    0x54(%eax),%eax
    15e9:	83 ec 04             	sub    $0x4,%esp
    15ec:	52                   	push   %edx
    15ed:	68 ff 00 00 00       	push   $0xff
    15f2:	50                   	push   %eax
    15f3:	e8 c5 eb ff ff       	call   1bd <memset>
    15f8:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    15fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15fe:	8b 55 0c             	mov    0xc(%ebp),%edx
    1601:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1604:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1608:	74 49                	je     1653 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    160a:	8b 45 10             	mov    0x10(%ebp),%eax
    160d:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1613:	83 ec 0c             	sub    $0xc,%esp
    1616:	50                   	push   %eax
    1617:	e8 ae f1 ff ff       	call   7ca <malloc>
    161c:	83 c4 10             	add    $0x10,%esp
    161f:	89 c2                	mov    %eax,%edx
    1621:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1624:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1627:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162a:	8b 55 10             	mov    0x10(%ebp),%edx
    162d:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1630:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1633:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    163a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163d:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1644:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1647:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    164e:	e9 8d 00 00 00       	jmp    16e0 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1653:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1656:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    165d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1660:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1667:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166a:	8b 40 20             	mov    0x20(%eax),%eax
    166d:	89 c2                	mov    %eax,%edx
    166f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1672:	8b 40 24             	mov    0x24(%eax),%eax
    1675:	0f af d0             	imul   %eax,%edx
    1678:	89 d0                	mov    %edx,%eax
    167a:	01 c0                	add    %eax,%eax
    167c:	01 d0                	add    %edx,%eax
    167e:	83 ec 0c             	sub    $0xc,%esp
    1681:	50                   	push   %eax
    1682:	e8 43 f1 ff ff       	call   7ca <malloc>
    1687:	83 c4 10             	add    $0x10,%esp
    168a:	89 c2                	mov    %eax,%edx
    168c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168f:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1692:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1695:	8b 40 38             	mov    0x38(%eax),%eax
    1698:	85 c0                	test   %eax,%eax
    169a:	75 15                	jne    16b1 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    169c:	83 ec 04             	sub    $0x4,%esp
    169f:	ff 75 08             	pushl  0x8(%ebp)
    16a2:	68 a4 23 00 00       	push   $0x23a4
    16a7:	6a 01                	push   $0x1
    16a9:	e8 49 ee ff ff       	call   4f7 <printf>
    16ae:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b4:	8b 40 20             	mov    0x20(%eax),%eax
    16b7:	89 c2                	mov    %eax,%edx
    16b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16bc:	8b 40 24             	mov    0x24(%eax),%eax
    16bf:	0f af d0             	imul   %eax,%edx
    16c2:	89 d0                	mov    %edx,%eax
    16c4:	01 c0                	add    %eax,%eax
    16c6:	01 c2                	add    %eax,%edx
    16c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16cb:	8b 40 38             	mov    0x38(%eax),%eax
    16ce:	83 ec 04             	sub    $0x4,%esp
    16d1:	52                   	push   %edx
    16d2:	68 ff ff ff 00       	push   $0xffffff
    16d7:	50                   	push   %eax
    16d8:	e8 e0 ea ff ff       	call   1bd <memset>
    16dd:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    16e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    16e3:	c9                   	leave  
    16e4:	c3                   	ret    

000016e5 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    16e5:	55                   	push   %ebp
    16e6:	89 e5                	mov    %esp,%ebp
    16e8:	57                   	push   %edi
    16e9:	56                   	push   %esi
    16ea:	53                   	push   %ebx
    16eb:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    16ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    16f1:	83 f8 03             	cmp    $0x3,%eax
    16f4:	74 02                	je     16f8 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    16f6:	eb 7c                	jmp    1774 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    16f8:	8b 45 08             	mov    0x8(%ebp),%eax
    16fb:	8b 58 1c             	mov    0x1c(%eax),%ebx
    16fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1701:	8b 48 18             	mov    0x18(%eax),%ecx
    1704:	8b 45 08             	mov    0x8(%ebp),%eax
    1707:	8b 50 5c             	mov    0x5c(%eax),%edx
    170a:	8b 45 08             	mov    0x8(%ebp),%eax
    170d:	8b 40 58             	mov    0x58(%eax),%eax
    1710:	8b 75 08             	mov    0x8(%ebp),%esi
    1713:	83 c6 58             	add    $0x58,%esi
    1716:	83 ec 04             	sub    $0x4,%esp
    1719:	53                   	push   %ebx
    171a:	51                   	push   %ecx
    171b:	6a 00                	push   $0x0
    171d:	52                   	push   %edx
    171e:	50                   	push   %eax
    171f:	6a 00                	push   $0x0
    1721:	6a 00                	push   $0x0
    1723:	56                   	push   %esi
    1724:	6a 00                	push   $0x0
    1726:	6a 00                	push   $0x0
    1728:	ff 75 08             	pushl  0x8(%ebp)
    172b:	e8 c8 ec ff ff       	call   3f8 <paintWindow>
    1730:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1733:	8b 45 08             	mov    0x8(%ebp),%eax
    1736:	8b 70 1c             	mov    0x1c(%eax),%esi
    1739:	8b 45 08             	mov    0x8(%ebp),%eax
    173c:	8b 58 18             	mov    0x18(%eax),%ebx
    173f:	8b 45 08             	mov    0x8(%ebp),%eax
    1742:	8b 48 08             	mov    0x8(%eax),%ecx
    1745:	8b 45 08             	mov    0x8(%ebp),%eax
    1748:	8b 50 40             	mov    0x40(%eax),%edx
    174b:	8b 45 08             	mov    0x8(%ebp),%eax
    174e:	8b 40 3c             	mov    0x3c(%eax),%eax
    1751:	8b 7d 08             	mov    0x8(%ebp),%edi
    1754:	83 c7 3c             	add    $0x3c,%edi
    1757:	83 ec 04             	sub    $0x4,%esp
    175a:	56                   	push   %esi
    175b:	53                   	push   %ebx
    175c:	51                   	push   %ecx
    175d:	52                   	push   %edx
    175e:	50                   	push   %eax
    175f:	6a 00                	push   $0x0
    1761:	6a 00                	push   $0x0
    1763:	57                   	push   %edi
    1764:	6a 32                	push   $0x32
    1766:	6a 00                	push   $0x0
    1768:	ff 75 08             	pushl  0x8(%ebp)
    176b:	e8 88 ec ff ff       	call   3f8 <paintWindow>
    1770:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1773:	90                   	nop
        default: break;
            
            
    }
    return False;
    1774:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1779:	8d 65 f4             	lea    -0xc(%ebp),%esp
    177c:	5b                   	pop    %ebx
    177d:	5e                   	pop    %esi
    177e:	5f                   	pop    %edi
    177f:	5d                   	pop    %ebp
    1780:	c3                   	ret    

00001781 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1781:	55                   	push   %ebp
    1782:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1784:	8b 45 0c             	mov    0xc(%ebp),%eax
    1787:	8b 50 08             	mov    0x8(%eax),%edx
    178a:	8b 45 08             	mov    0x8(%ebp),%eax
    178d:	8b 00                	mov    (%eax),%eax
    178f:	39 c2                	cmp    %eax,%edx
    1791:	74 07                	je     179a <APPreJudge+0x19>
        return False;
    1793:	b8 00 00 00 00       	mov    $0x0,%eax
    1798:	eb 05                	jmp    179f <APPreJudge+0x1e>
    return True;
    179a:	b8 01 00 00 00       	mov    $0x1,%eax
}
    179f:	5d                   	pop    %ebp
    17a0:	c3                   	ret    

000017a1 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    17a1:	55                   	push   %ebp
    17a2:	89 e5                	mov    %esp,%ebp
    17a4:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    17a7:	8b 45 08             	mov    0x8(%ebp),%eax
    17aa:	8b 55 0c             	mov    0xc(%ebp),%edx
    17ad:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    17b3:	83 ec 0c             	sub    $0xc,%esp
    17b6:	ff 75 08             	pushl  0x8(%ebp)
    17b9:	e8 52 ec ff ff       	call   410 <registWindow>
    17be:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    17c1:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    17c8:	8b 45 08             	mov    0x8(%ebp),%eax
    17cb:	8b 00                	mov    (%eax),%eax
    17cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    17d0:	ff 75 f4             	pushl  -0xc(%ebp)
    17d3:	ff 75 f0             	pushl  -0x10(%ebp)
    17d6:	ff 75 ec             	pushl  -0x14(%ebp)
    17d9:	ff 75 08             	pushl  0x8(%ebp)
    17dc:	e8 80 fc ff ff       	call   1461 <APSendMessage>
    17e1:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    17e4:	83 ec 0c             	sub    $0xc,%esp
    17e7:	ff 75 08             	pushl  0x8(%ebp)
    17ea:	e8 19 ec ff ff       	call   408 <getMessage>
    17ef:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    17f2:	8b 45 08             	mov    0x8(%ebp),%eax
    17f5:	83 c0 74             	add    $0x74,%eax
    17f8:	83 ec 08             	sub    $0x8,%esp
    17fb:	50                   	push   %eax
    17fc:	ff 75 08             	pushl  0x8(%ebp)
    17ff:	e8 7d ff ff ff       	call   1781 <APPreJudge>
    1804:	83 c4 10             	add    $0x10,%esp
    1807:	84 c0                	test   %al,%al
    1809:	74 1b                	je     1826 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    180b:	8b 45 08             	mov    0x8(%ebp),%eax
    180e:	ff 70 7c             	pushl  0x7c(%eax)
    1811:	ff 70 78             	pushl  0x78(%eax)
    1814:	ff 70 74             	pushl  0x74(%eax)
    1817:	ff 75 08             	pushl  0x8(%ebp)
    181a:	8b 45 0c             	mov    0xc(%ebp),%eax
    181d:	ff d0                	call   *%eax
    181f:	83 c4 10             	add    $0x10,%esp
    1822:	84 c0                	test   %al,%al
    1824:	75 0c                	jne    1832 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1826:	8b 45 08             	mov    0x8(%ebp),%eax
    1829:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1830:	eb b2                	jmp    17e4 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1832:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1833:	90                   	nop
    1834:	c9                   	leave  
    1835:	c3                   	ret    

00001836 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1836:	55                   	push   %ebp
    1837:	89 e5                	mov    %esp,%ebp
    1839:	57                   	push   %edi
    183a:	56                   	push   %esi
    183b:	53                   	push   %ebx
    183c:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    183f:	a1 30 2a 00 00       	mov    0x2a30,%eax
    1844:	85 c0                	test   %eax,%eax
    1846:	0f 85 2c 02 00 00    	jne    1a78 <APGridPaint+0x242>
    {
        iconReady = 1;
    184c:	c7 05 30 2a 00 00 01 	movl   $0x1,0x2a30
    1853:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1856:	8d 45 98             	lea    -0x68(%ebp),%eax
    1859:	83 ec 08             	sub    $0x8,%esp
    185c:	68 cb 23 00 00       	push   $0x23cb
    1861:	50                   	push   %eax
    1862:	e8 16 f1 ff ff       	call   97d <APLoadBitmap>
    1867:	83 c4 0c             	add    $0xc,%esp
    186a:	8b 45 98             	mov    -0x68(%ebp),%eax
    186d:	a3 54 2a 00 00       	mov    %eax,0x2a54
    1872:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1875:	a3 58 2a 00 00       	mov    %eax,0x2a58
    187a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    187d:	a3 5c 2a 00 00       	mov    %eax,0x2a5c
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1882:	83 ec 04             	sub    $0x4,%esp
    1885:	ff 35 5c 2a 00 00    	pushl  0x2a5c
    188b:	ff 35 58 2a 00 00    	pushl  0x2a58
    1891:	ff 35 54 2a 00 00    	pushl  0x2a54
    1897:	e8 1b f3 ff ff       	call   bb7 <APCreateCompatibleDCFromBitmap>
    189c:	83 c4 10             	add    $0x10,%esp
    189f:	a3 60 2a 00 00       	mov    %eax,0x2a60
        grid_river = APLoadBitmap ("grid_river.bmp");
    18a4:	8d 45 98             	lea    -0x68(%ebp),%eax
    18a7:	83 ec 08             	sub    $0x8,%esp
    18aa:	68 d9 23 00 00       	push   $0x23d9
    18af:	50                   	push   %eax
    18b0:	e8 c8 f0 ff ff       	call   97d <APLoadBitmap>
    18b5:	83 c4 0c             	add    $0xc,%esp
    18b8:	8b 45 98             	mov    -0x68(%ebp),%eax
    18bb:	a3 90 2a 00 00       	mov    %eax,0x2a90
    18c0:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18c3:	a3 94 2a 00 00       	mov    %eax,0x2a94
    18c8:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18cb:	a3 98 2a 00 00       	mov    %eax,0x2a98
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    18d0:	83 ec 04             	sub    $0x4,%esp
    18d3:	ff 35 98 2a 00 00    	pushl  0x2a98
    18d9:	ff 35 94 2a 00 00    	pushl  0x2a94
    18df:	ff 35 90 2a 00 00    	pushl  0x2a90
    18e5:	e8 cd f2 ff ff       	call   bb7 <APCreateCompatibleDCFromBitmap>
    18ea:	83 c4 10             	add    $0x10,%esp
    18ed:	a3 80 2a 00 00       	mov    %eax,0x2a80
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    18f2:	8d 45 98             	lea    -0x68(%ebp),%eax
    18f5:	83 ec 08             	sub    $0x8,%esp
    18f8:	68 e8 23 00 00       	push   $0x23e8
    18fd:	50                   	push   %eax
    18fe:	e8 7a f0 ff ff       	call   97d <APLoadBitmap>
    1903:	83 c4 0c             	add    $0xc,%esp
    1906:	8b 45 98             	mov    -0x68(%ebp),%eax
    1909:	a3 84 2a 00 00       	mov    %eax,0x2a84
    190e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1911:	a3 88 2a 00 00       	mov    %eax,0x2a88
    1916:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1919:	a3 8c 2a 00 00       	mov    %eax,0x2a8c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    191e:	83 ec 04             	sub    $0x4,%esp
    1921:	ff 35 8c 2a 00 00    	pushl  0x2a8c
    1927:	ff 35 88 2a 00 00    	pushl  0x2a88
    192d:	ff 35 84 2a 00 00    	pushl  0x2a84
    1933:	e8 7f f2 ff ff       	call   bb7 <APCreateCompatibleDCFromBitmap>
    1938:	83 c4 10             	add    $0x10,%esp
    193b:	a3 34 2a 00 00       	mov    %eax,0x2a34
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1940:	8d 45 98             	lea    -0x68(%ebp),%eax
    1943:	83 ec 08             	sub    $0x8,%esp
    1946:	68 f7 23 00 00       	push   $0x23f7
    194b:	50                   	push   %eax
    194c:	e8 2c f0 ff ff       	call   97d <APLoadBitmap>
    1951:	83 c4 0c             	add    $0xc,%esp
    1954:	8b 45 98             	mov    -0x68(%ebp),%eax
    1957:	a3 68 2a 00 00       	mov    %eax,0x2a68
    195c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    195f:	a3 6c 2a 00 00       	mov    %eax,0x2a6c
    1964:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1967:	a3 70 2a 00 00       	mov    %eax,0x2a70
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    196c:	83 ec 04             	sub    $0x4,%esp
    196f:	ff 35 70 2a 00 00    	pushl  0x2a70
    1975:	ff 35 6c 2a 00 00    	pushl  0x2a6c
    197b:	ff 35 68 2a 00 00    	pushl  0x2a68
    1981:	e8 31 f2 ff ff       	call   bb7 <APCreateCompatibleDCFromBitmap>
    1986:	83 c4 10             	add    $0x10,%esp
    1989:	a3 9c 2a 00 00       	mov    %eax,0x2a9c
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    198e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1991:	83 ec 08             	sub    $0x8,%esp
    1994:	68 05 24 00 00       	push   $0x2405
    1999:	50                   	push   %eax
    199a:	e8 de ef ff ff       	call   97d <APLoadBitmap>
    199f:	83 c4 0c             	add    $0xc,%esp
    19a2:	8b 45 98             	mov    -0x68(%ebp),%eax
    19a5:	a3 44 2a 00 00       	mov    %eax,0x2a44
    19aa:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19ad:	a3 48 2a 00 00       	mov    %eax,0x2a48
    19b2:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19b5:	a3 4c 2a 00 00       	mov    %eax,0x2a4c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    19ba:	83 ec 04             	sub    $0x4,%esp
    19bd:	ff 35 4c 2a 00 00    	pushl  0x2a4c
    19c3:	ff 35 48 2a 00 00    	pushl  0x2a48
    19c9:	ff 35 44 2a 00 00    	pushl  0x2a44
    19cf:	e8 e3 f1 ff ff       	call   bb7 <APCreateCompatibleDCFromBitmap>
    19d4:	83 c4 10             	add    $0x10,%esp
    19d7:	a3 64 2a 00 00       	mov    %eax,0x2a64
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    19dc:	8d 45 98             	lea    -0x68(%ebp),%eax
    19df:	83 ec 08             	sub    $0x8,%esp
    19e2:	68 15 24 00 00       	push   $0x2415
    19e7:	50                   	push   %eax
    19e8:	e8 90 ef ff ff       	call   97d <APLoadBitmap>
    19ed:	83 c4 0c             	add    $0xc,%esp
    19f0:	8b 45 98             	mov    -0x68(%ebp),%eax
    19f3:	a3 38 2a 00 00       	mov    %eax,0x2a38
    19f8:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19fb:	a3 3c 2a 00 00       	mov    %eax,0x2a3c
    1a00:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a03:	a3 40 2a 00 00       	mov    %eax,0x2a40
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1a08:	83 ec 04             	sub    $0x4,%esp
    1a0b:	ff 35 40 2a 00 00    	pushl  0x2a40
    1a11:	ff 35 3c 2a 00 00    	pushl  0x2a3c
    1a17:	ff 35 38 2a 00 00    	pushl  0x2a38
    1a1d:	e8 95 f1 ff ff       	call   bb7 <APCreateCompatibleDCFromBitmap>
    1a22:	83 c4 10             	add    $0x10,%esp
    1a25:	a3 50 2a 00 00       	mov    %eax,0x2a50
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1a2a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a2d:	83 ec 08             	sub    $0x8,%esp
    1a30:	68 27 24 00 00       	push   $0x2427
    1a35:	50                   	push   %eax
    1a36:	e8 42 ef ff ff       	call   97d <APLoadBitmap>
    1a3b:	83 c4 0c             	add    $0xc,%esp
    1a3e:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a41:	a3 74 2a 00 00       	mov    %eax,0x2a74
    1a46:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a49:	a3 78 2a 00 00       	mov    %eax,0x2a78
    1a4e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a51:	a3 7c 2a 00 00       	mov    %eax,0x2a7c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1a56:	83 ec 04             	sub    $0x4,%esp
    1a59:	ff 35 7c 2a 00 00    	pushl  0x2a7c
    1a5f:	ff 35 78 2a 00 00    	pushl  0x2a78
    1a65:	ff 35 74 2a 00 00    	pushl  0x2a74
    1a6b:	e8 47 f1 ff ff       	call   bb7 <APCreateCompatibleDCFromBitmap>
    1a70:	83 c4 10             	add    $0x10,%esp
    1a73:	a3 a0 2a 00 00       	mov    %eax,0x2aa0
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1a78:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7b:	8b 40 08             	mov    0x8(%eax),%eax
    1a7e:	85 c0                	test   %eax,%eax
    1a80:	75 17                	jne    1a99 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1a82:	83 ec 08             	sub    $0x8,%esp
    1a85:	68 38 24 00 00       	push   $0x2438
    1a8a:	6a 01                	push   $0x1
    1a8c:	e8 66 ea ff ff       	call   4f7 <printf>
    1a91:	83 c4 10             	add    $0x10,%esp
        return;
    1a94:	e9 a0 04 00 00       	jmp    1f39 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1a99:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9c:	8b 40 10             	mov    0x10(%eax),%eax
    1a9f:	85 c0                	test   %eax,%eax
    1aa1:	7e 10                	jle    1ab3 <APGridPaint+0x27d>
    1aa3:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa6:	8b 50 14             	mov    0x14(%eax),%edx
    1aa9:	8b 45 08             	mov    0x8(%ebp),%eax
    1aac:	8b 40 10             	mov    0x10(%eax),%eax
    1aaf:	39 c2                	cmp    %eax,%edx
    1ab1:	7c 17                	jl     1aca <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1ab3:	83 ec 08             	sub    $0x8,%esp
    1ab6:	68 5e 24 00 00       	push   $0x245e
    1abb:	6a 01                	push   $0x1
    1abd:	e8 35 ea ff ff       	call   4f7 <printf>
    1ac2:	83 c4 10             	add    $0x10,%esp
        return;
    1ac5:	e9 6f 04 00 00       	jmp    1f39 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1aca:	8b 45 08             	mov    0x8(%ebp),%eax
    1acd:	8b 40 14             	mov    0x14(%eax),%eax
    1ad0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1ad6:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1ad9:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1adc:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1adf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1ae6:	e9 96 03 00 00       	jmp    1e81 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1aeb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1af2:	e9 7c 03 00 00       	jmp    1e73 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1af7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1afa:	c1 e0 04             	shl    $0x4,%eax
    1afd:	89 c2                	mov    %eax,%edx
    1aff:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b02:	01 c2                	add    %eax,%edx
    1b04:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b07:	01 d0                	add    %edx,%eax
    1b09:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1b0c:	8b 45 08             	mov    0x8(%ebp),%eax
    1b0f:	8b 40 0c             	mov    0xc(%eax),%eax
    1b12:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1b15:	c1 e2 02             	shl    $0x2,%edx
    1b18:	01 d0                	add    %edx,%eax
    1b1a:	8b 00                	mov    (%eax),%eax
    1b1c:	83 f8 07             	cmp    $0x7,%eax
    1b1f:	0f 87 49 03 00 00    	ja     1e6e <APGridPaint+0x638>
    1b25:	8b 04 85 74 24 00 00 	mov    0x2474(,%eax,4),%eax
    1b2c:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b2e:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1b31:	6a 0c                	push   $0xc
    1b33:	6a 0c                	push   $0xc
    1b35:	6a 0c                	push   $0xc
    1b37:	50                   	push   %eax
    1b38:	e8 df f8 ff ff       	call   141c <RGB>
    1b3d:	83 c4 0c             	add    $0xc,%esp
    1b40:	8b 1d 60 2a 00 00    	mov    0x2a60,%ebx
    1b46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b49:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b4c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b4f:	6b c0 32             	imul   $0x32,%eax,%eax
    1b52:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b55:	8b 45 08             	mov    0x8(%ebp),%eax
    1b58:	8d 78 3c             	lea    0x3c(%eax),%edi
    1b5b:	83 ec 0c             	sub    $0xc,%esp
    1b5e:	83 ec 04             	sub    $0x4,%esp
    1b61:	89 e0                	mov    %esp,%eax
    1b63:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1b67:	66 89 30             	mov    %si,(%eax)
    1b6a:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1b6e:	88 50 02             	mov    %dl,0x2(%eax)
    1b71:	6a 32                	push   $0x32
    1b73:	6a 32                	push   $0x32
    1b75:	6a 00                	push   $0x0
    1b77:	6a 00                	push   $0x0
    1b79:	53                   	push   %ebx
    1b7a:	51                   	push   %ecx
    1b7b:	ff 75 94             	pushl  -0x6c(%ebp)
    1b7e:	57                   	push   %edi
    1b7f:	e8 f4 f6 ff ff       	call   1278 <APDcCopy>
    1b84:	83 c4 30             	add    $0x30,%esp
                    break;
    1b87:	e9 e3 02 00 00       	jmp    1e6f <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1b8c:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b8f:	6a 69                	push   $0x69
    1b91:	6a 69                	push   $0x69
    1b93:	6a 69                	push   $0x69
    1b95:	50                   	push   %eax
    1b96:	e8 81 f8 ff ff       	call   141c <RGB>
    1b9b:	83 c4 0c             	add    $0xc,%esp
    1b9e:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ba2:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1ba6:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1baa:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1bad:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1bb4:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bb7:	6a 69                	push   $0x69
    1bb9:	6a 69                	push   $0x69
    1bbb:	6a 69                	push   $0x69
    1bbd:	50                   	push   %eax
    1bbe:	e8 59 f8 ff ff       	call   141c <RGB>
    1bc3:	83 c4 0c             	add    $0xc,%esp
    1bc6:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1bca:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1bce:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1bd2:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1bd5:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd8:	8d 50 3c             	lea    0x3c(%eax),%edx
    1bdb:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bde:	ff 75 b0             	pushl  -0x50(%ebp)
    1be1:	ff 75 ac             	pushl  -0x54(%ebp)
    1be4:	52                   	push   %edx
    1be5:	50                   	push   %eax
    1be6:	e8 61 f0 ff ff       	call   c4c <APSetPen>
    1beb:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1bee:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf1:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1bf4:	8d 55 98             	lea    -0x68(%ebp),%edx
    1bf7:	83 ec 04             	sub    $0x4,%esp
    1bfa:	83 ec 04             	sub    $0x4,%esp
    1bfd:	89 e0                	mov    %esp,%eax
    1bff:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1c03:	66 89 08             	mov    %cx,(%eax)
    1c06:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1c0a:	88 48 02             	mov    %cl,0x2(%eax)
    1c0d:	53                   	push   %ebx
    1c0e:	52                   	push   %edx
    1c0f:	e8 71 f0 ff ff       	call   c85 <APSetBrush>
    1c14:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1c17:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c1a:	6b d0 32             	imul   $0x32,%eax,%edx
    1c1d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c20:	6b c0 32             	imul   $0x32,%eax,%eax
    1c23:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c26:	83 c1 3c             	add    $0x3c,%ecx
    1c29:	83 ec 0c             	sub    $0xc,%esp
    1c2c:	6a 32                	push   $0x32
    1c2e:	6a 32                	push   $0x32
    1c30:	52                   	push   %edx
    1c31:	50                   	push   %eax
    1c32:	51                   	push   %ecx
    1c33:	e8 35 f4 ff ff       	call   106d <APDrawRect>
    1c38:	83 c4 20             	add    $0x20,%esp
                    break;
    1c3b:	e9 2f 02 00 00       	jmp    1e6f <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c40:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1c43:	6a 0c                	push   $0xc
    1c45:	6a 0c                	push   $0xc
    1c47:	6a 0c                	push   $0xc
    1c49:	50                   	push   %eax
    1c4a:	e8 cd f7 ff ff       	call   141c <RGB>
    1c4f:	83 c4 0c             	add    $0xc,%esp
    1c52:	8b 1d a0 2a 00 00    	mov    0x2aa0,%ebx
    1c58:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c5b:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c5e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c61:	6b c0 32             	imul   $0x32,%eax,%eax
    1c64:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c67:	8b 45 08             	mov    0x8(%ebp),%eax
    1c6a:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c6d:	83 ec 0c             	sub    $0xc,%esp
    1c70:	83 ec 04             	sub    $0x4,%esp
    1c73:	89 e0                	mov    %esp,%eax
    1c75:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1c79:	66 89 30             	mov    %si,(%eax)
    1c7c:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1c80:	88 50 02             	mov    %dl,0x2(%eax)
    1c83:	6a 32                	push   $0x32
    1c85:	6a 32                	push   $0x32
    1c87:	6a 00                	push   $0x0
    1c89:	6a 00                	push   $0x0
    1c8b:	53                   	push   %ebx
    1c8c:	51                   	push   %ecx
    1c8d:	ff 75 94             	pushl  -0x6c(%ebp)
    1c90:	57                   	push   %edi
    1c91:	e8 e2 f5 ff ff       	call   1278 <APDcCopy>
    1c96:	83 c4 30             	add    $0x30,%esp
                    break;
    1c99:	e9 d1 01 00 00       	jmp    1e6f <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c9e:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1ca1:	6a 0c                	push   $0xc
    1ca3:	6a 0c                	push   $0xc
    1ca5:	6a 0c                	push   $0xc
    1ca7:	50                   	push   %eax
    1ca8:	e8 6f f7 ff ff       	call   141c <RGB>
    1cad:	83 c4 0c             	add    $0xc,%esp
    1cb0:	8b 1d 80 2a 00 00    	mov    0x2a80,%ebx
    1cb6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cb9:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cbc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cbf:	6b c0 32             	imul   $0x32,%eax,%eax
    1cc2:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cc5:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc8:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ccb:	83 ec 0c             	sub    $0xc,%esp
    1cce:	83 ec 04             	sub    $0x4,%esp
    1cd1:	89 e0                	mov    %esp,%eax
    1cd3:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1cd7:	66 89 30             	mov    %si,(%eax)
    1cda:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1cde:	88 50 02             	mov    %dl,0x2(%eax)
    1ce1:	6a 32                	push   $0x32
    1ce3:	6a 32                	push   $0x32
    1ce5:	6a 00                	push   $0x0
    1ce7:	6a 00                	push   $0x0
    1ce9:	53                   	push   %ebx
    1cea:	51                   	push   %ecx
    1ceb:	ff 75 94             	pushl  -0x6c(%ebp)
    1cee:	57                   	push   %edi
    1cef:	e8 84 f5 ff ff       	call   1278 <APDcCopy>
    1cf4:	83 c4 30             	add    $0x30,%esp
                    break;
    1cf7:	e9 73 01 00 00       	jmp    1e6f <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cfc:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1cff:	6a 0c                	push   $0xc
    1d01:	6a 0c                	push   $0xc
    1d03:	6a 0c                	push   $0xc
    1d05:	50                   	push   %eax
    1d06:	e8 11 f7 ff ff       	call   141c <RGB>
    1d0b:	83 c4 0c             	add    $0xc,%esp
    1d0e:	8b 1d 64 2a 00 00    	mov    0x2a64,%ebx
    1d14:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d17:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d1a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d1d:	6b c0 32             	imul   $0x32,%eax,%eax
    1d20:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d23:	8b 45 08             	mov    0x8(%ebp),%eax
    1d26:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d29:	83 ec 0c             	sub    $0xc,%esp
    1d2c:	83 ec 04             	sub    $0x4,%esp
    1d2f:	89 e0                	mov    %esp,%eax
    1d31:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1d35:	66 89 30             	mov    %si,(%eax)
    1d38:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1d3c:	88 50 02             	mov    %dl,0x2(%eax)
    1d3f:	6a 32                	push   $0x32
    1d41:	6a 32                	push   $0x32
    1d43:	6a 00                	push   $0x0
    1d45:	6a 00                	push   $0x0
    1d47:	53                   	push   %ebx
    1d48:	51                   	push   %ecx
    1d49:	ff 75 94             	pushl  -0x6c(%ebp)
    1d4c:	57                   	push   %edi
    1d4d:	e8 26 f5 ff ff       	call   1278 <APDcCopy>
    1d52:	83 c4 30             	add    $0x30,%esp
                    break;
    1d55:	e9 15 01 00 00       	jmp    1e6f <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d5a:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1d5d:	6a 0c                	push   $0xc
    1d5f:	6a 0c                	push   $0xc
    1d61:	6a 0c                	push   $0xc
    1d63:	50                   	push   %eax
    1d64:	e8 b3 f6 ff ff       	call   141c <RGB>
    1d69:	83 c4 0c             	add    $0xc,%esp
    1d6c:	8b 1d 9c 2a 00 00    	mov    0x2a9c,%ebx
    1d72:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d75:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d78:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d7b:	6b c0 32             	imul   $0x32,%eax,%eax
    1d7e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d81:	8b 45 08             	mov    0x8(%ebp),%eax
    1d84:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d87:	83 ec 0c             	sub    $0xc,%esp
    1d8a:	83 ec 04             	sub    $0x4,%esp
    1d8d:	89 e0                	mov    %esp,%eax
    1d8f:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1d93:	66 89 30             	mov    %si,(%eax)
    1d96:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1d9a:	88 50 02             	mov    %dl,0x2(%eax)
    1d9d:	6a 32                	push   $0x32
    1d9f:	6a 32                	push   $0x32
    1da1:	6a 00                	push   $0x0
    1da3:	6a 00                	push   $0x0
    1da5:	53                   	push   %ebx
    1da6:	51                   	push   %ecx
    1da7:	ff 75 94             	pushl  -0x6c(%ebp)
    1daa:	57                   	push   %edi
    1dab:	e8 c8 f4 ff ff       	call   1278 <APDcCopy>
    1db0:	83 c4 30             	add    $0x30,%esp
                    break;
    1db3:	e9 b7 00 00 00       	jmp    1e6f <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1db8:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1dbb:	6a 0c                	push   $0xc
    1dbd:	6a 0c                	push   $0xc
    1dbf:	6a 0c                	push   $0xc
    1dc1:	50                   	push   %eax
    1dc2:	e8 55 f6 ff ff       	call   141c <RGB>
    1dc7:	83 c4 0c             	add    $0xc,%esp
    1dca:	8b 1d 34 2a 00 00    	mov    0x2a34,%ebx
    1dd0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dd3:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dd6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dd9:	6b c0 32             	imul   $0x32,%eax,%eax
    1ddc:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ddf:	8b 45 08             	mov    0x8(%ebp),%eax
    1de2:	8d 78 3c             	lea    0x3c(%eax),%edi
    1de5:	83 ec 0c             	sub    $0xc,%esp
    1de8:	83 ec 04             	sub    $0x4,%esp
    1deb:	89 e0                	mov    %esp,%eax
    1ded:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1df1:	66 89 30             	mov    %si,(%eax)
    1df4:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1df8:	88 50 02             	mov    %dl,0x2(%eax)
    1dfb:	6a 32                	push   $0x32
    1dfd:	6a 32                	push   $0x32
    1dff:	6a 00                	push   $0x0
    1e01:	6a 00                	push   $0x0
    1e03:	53                   	push   %ebx
    1e04:	51                   	push   %ecx
    1e05:	ff 75 94             	pushl  -0x6c(%ebp)
    1e08:	57                   	push   %edi
    1e09:	e8 6a f4 ff ff       	call   1278 <APDcCopy>
    1e0e:	83 c4 30             	add    $0x30,%esp
                    break;
    1e11:	eb 5c                	jmp    1e6f <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e13:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1e16:	6a 0c                	push   $0xc
    1e18:	6a 0c                	push   $0xc
    1e1a:	6a 0c                	push   $0xc
    1e1c:	50                   	push   %eax
    1e1d:	e8 fa f5 ff ff       	call   141c <RGB>
    1e22:	83 c4 0c             	add    $0xc,%esp
    1e25:	8b 1d 50 2a 00 00    	mov    0x2a50,%ebx
    1e2b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e2e:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e31:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e34:	6b c0 32             	imul   $0x32,%eax,%eax
    1e37:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e3a:	8b 45 08             	mov    0x8(%ebp),%eax
    1e3d:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e40:	83 ec 0c             	sub    $0xc,%esp
    1e43:	83 ec 04             	sub    $0x4,%esp
    1e46:	89 e0                	mov    %esp,%eax
    1e48:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1e4c:	66 89 30             	mov    %si,(%eax)
    1e4f:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1e53:	88 50 02             	mov    %dl,0x2(%eax)
    1e56:	6a 32                	push   $0x32
    1e58:	6a 32                	push   $0x32
    1e5a:	6a 00                	push   $0x0
    1e5c:	6a 00                	push   $0x0
    1e5e:	53                   	push   %ebx
    1e5f:	51                   	push   %ecx
    1e60:	ff 75 94             	pushl  -0x6c(%ebp)
    1e63:	57                   	push   %edi
    1e64:	e8 0f f4 ff ff       	call   1278 <APDcCopy>
    1e69:	83 c4 30             	add    $0x30,%esp
                    break;
    1e6c:	eb 01                	jmp    1e6f <APGridPaint+0x639>
                default: break;
    1e6e:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1e6f:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1e73:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1e77:	0f 8e 7a fc ff ff    	jle    1af7 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e7d:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e81:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1e85:	0f 8e 60 fc ff ff    	jle    1aeb <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1e8b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e8e:	68 cd 00 00 00       	push   $0xcd
    1e93:	6a 74                	push   $0x74
    1e95:	6a 18                	push   $0x18
    1e97:	50                   	push   %eax
    1e98:	e8 7f f5 ff ff       	call   141c <RGB>
    1e9d:	83 c4 0c             	add    $0xc,%esp
    1ea0:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ea4:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1ea8:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1eac:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1eaf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1eb6:	8d 45 98             	lea    -0x68(%ebp),%eax
    1eb9:	68 cd 00 00 00       	push   $0xcd
    1ebe:	6a 74                	push   $0x74
    1ec0:	6a 18                	push   $0x18
    1ec2:	50                   	push   %eax
    1ec3:	e8 54 f5 ff ff       	call   141c <RGB>
    1ec8:	83 c4 0c             	add    $0xc,%esp
    1ecb:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ecf:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1ed3:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ed7:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1eda:	8b 45 08             	mov    0x8(%ebp),%eax
    1edd:	8d 50 58             	lea    0x58(%eax),%edx
    1ee0:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ee3:	ff 75 bc             	pushl  -0x44(%ebp)
    1ee6:	ff 75 b8             	pushl  -0x48(%ebp)
    1ee9:	52                   	push   %edx
    1eea:	50                   	push   %eax
    1eeb:	e8 5c ed ff ff       	call   c4c <APSetPen>
    1ef0:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1ef3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef6:	8d 58 58             	lea    0x58(%eax),%ebx
    1ef9:	8d 55 98             	lea    -0x68(%ebp),%edx
    1efc:	83 ec 04             	sub    $0x4,%esp
    1eff:	83 ec 04             	sub    $0x4,%esp
    1f02:	89 e0                	mov    %esp,%eax
    1f04:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1f08:	66 89 08             	mov    %cx,(%eax)
    1f0b:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1f0f:	88 48 02             	mov    %cl,0x2(%eax)
    1f12:	53                   	push   %ebx
    1f13:	52                   	push   %edx
    1f14:	e8 6c ed ff ff       	call   c85 <APSetBrush>
    1f19:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1f1c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f1f:	83 c0 58             	add    $0x58,%eax
    1f22:	83 ec 0c             	sub    $0xc,%esp
    1f25:	6a 32                	push   $0x32
    1f27:	68 20 03 00 00       	push   $0x320
    1f2c:	6a 00                	push   $0x0
    1f2e:	6a 00                	push   $0x0
    1f30:	50                   	push   %eax
    1f31:	e8 37 f1 ff ff       	call   106d <APDrawRect>
    1f36:	83 c4 20             	add    $0x20,%esp
}
    1f39:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1f3c:	5b                   	pop    %ebx
    1f3d:	5e                   	pop    %esi
    1f3e:	5f                   	pop    %edi
    1f3f:	5d                   	pop    %ebp
    1f40:	c3                   	ret    

00001f41 <random>:
//

#include "APLib.h"

int random(int seed)
{
    1f41:	55                   	push   %ebp
    1f42:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1f44:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1f48:	7e 08                	jle    1f52 <random+0x11>
{
rand_num = seed;
    1f4a:	8b 45 08             	mov    0x8(%ebp),%eax
    1f4d:	a3 0c 2a 00 00       	mov    %eax,0x2a0c
}
rand_num *= 3;
    1f52:	8b 15 0c 2a 00 00    	mov    0x2a0c,%edx
    1f58:	89 d0                	mov    %edx,%eax
    1f5a:	01 c0                	add    %eax,%eax
    1f5c:	01 d0                	add    %edx,%eax
    1f5e:	a3 0c 2a 00 00       	mov    %eax,0x2a0c
if (rand_num < 0)
    1f63:	a1 0c 2a 00 00       	mov    0x2a0c,%eax
    1f68:	85 c0                	test   %eax,%eax
    1f6a:	79 0c                	jns    1f78 <random+0x37>
{
rand_num *= (-1);
    1f6c:	a1 0c 2a 00 00       	mov    0x2a0c,%eax
    1f71:	f7 d8                	neg    %eax
    1f73:	a3 0c 2a 00 00       	mov    %eax,0x2a0c
}
return rand_num % 997;
    1f78:	8b 0d 0c 2a 00 00    	mov    0x2a0c,%ecx
    1f7e:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1f83:	89 c8                	mov    %ecx,%eax
    1f85:	f7 ea                	imul   %edx
    1f87:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1f8a:	c1 f8 09             	sar    $0x9,%eax
    1f8d:	89 c2                	mov    %eax,%edx
    1f8f:	89 c8                	mov    %ecx,%eax
    1f91:	c1 f8 1f             	sar    $0x1f,%eax
    1f94:	29 c2                	sub    %eax,%edx
    1f96:	89 d0                	mov    %edx,%eax
    1f98:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1f9e:	29 c1                	sub    %eax,%ecx
    1fa0:	89 c8                	mov    %ecx,%eax
}
    1fa2:	5d                   	pop    %ebp
    1fa3:	c3                   	ret    

00001fa4 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1fa4:	55                   	push   %ebp
    1fa5:	89 e5                	mov    %esp,%ebp
    1fa7:	53                   	push   %ebx
    1fa8:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1fab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1fb2:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1fb6:	74 17                	je     1fcf <sprintint+0x2b>
    1fb8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1fbc:	79 11                	jns    1fcf <sprintint+0x2b>
        neg = 1;
    1fbe:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1fc5:	8b 45 10             	mov    0x10(%ebp),%eax
    1fc8:	f7 d8                	neg    %eax
    1fca:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1fcd:	eb 06                	jmp    1fd5 <sprintint+0x31>
    } else {
        x = xx;
    1fcf:	8b 45 10             	mov    0x10(%ebp),%eax
    1fd2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1fd5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1fdc:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1fdf:	8d 41 01             	lea    0x1(%ecx),%eax
    1fe2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1fe5:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1fe8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1feb:	ba 00 00 00 00       	mov    $0x0,%edx
    1ff0:	f7 f3                	div    %ebx
    1ff2:	89 d0                	mov    %edx,%eax
    1ff4:	0f b6 80 10 2a 00 00 	movzbl 0x2a10(%eax),%eax
    1ffb:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1fff:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2002:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2005:	ba 00 00 00 00       	mov    $0x0,%edx
    200a:	f7 f3                	div    %ebx
    200c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    200f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2013:	75 c7                	jne    1fdc <sprintint+0x38>
    if(neg)
    2015:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2019:	74 0e                	je     2029 <sprintint+0x85>
        buf[i++] = '-';
    201b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    201e:	8d 50 01             	lea    0x1(%eax),%edx
    2021:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2024:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2029:	8b 45 f8             	mov    -0x8(%ebp),%eax
    202c:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    202f:	eb 1b                	jmp    204c <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2031:	8b 45 0c             	mov    0xc(%ebp),%eax
    2034:	8b 00                	mov    (%eax),%eax
    2036:	8d 48 01             	lea    0x1(%eax),%ecx
    2039:	8b 55 0c             	mov    0xc(%ebp),%edx
    203c:	89 0a                	mov    %ecx,(%edx)
    203e:	89 c2                	mov    %eax,%edx
    2040:	8b 45 08             	mov    0x8(%ebp),%eax
    2043:	01 d0                	add    %edx,%eax
    2045:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2048:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    204c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2050:	7f df                	jg     2031 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2052:	eb 21                	jmp    2075 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2054:	8b 45 0c             	mov    0xc(%ebp),%eax
    2057:	8b 00                	mov    (%eax),%eax
    2059:	8d 48 01             	lea    0x1(%eax),%ecx
    205c:	8b 55 0c             	mov    0xc(%ebp),%edx
    205f:	89 0a                	mov    %ecx,(%edx)
    2061:	89 c2                	mov    %eax,%edx
    2063:	8b 45 08             	mov    0x8(%ebp),%eax
    2066:	01 c2                	add    %eax,%edx
    2068:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    206b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    206e:	01 c8                	add    %ecx,%eax
    2070:	0f b6 00             	movzbl (%eax),%eax
    2073:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2075:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2079:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    207d:	79 d5                	jns    2054 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    207f:	90                   	nop
    2080:	83 c4 20             	add    $0x20,%esp
    2083:	5b                   	pop    %ebx
    2084:	5d                   	pop    %ebp
    2085:	c3                   	ret    

00002086 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2086:	55                   	push   %ebp
    2087:	89 e5                	mov    %esp,%ebp
    2089:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    208c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2093:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    209a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    20a1:	8d 45 0c             	lea    0xc(%ebp),%eax
    20a4:	83 c0 04             	add    $0x4,%eax
    20a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    20aa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    20b1:	e9 d9 01 00 00       	jmp    228f <sprintf+0x209>
        c = fmt[i] & 0xff;
    20b6:	8b 55 0c             	mov    0xc(%ebp),%edx
    20b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    20bc:	01 d0                	add    %edx,%eax
    20be:	0f b6 00             	movzbl (%eax),%eax
    20c1:	0f be c0             	movsbl %al,%eax
    20c4:	25 ff 00 00 00       	and    $0xff,%eax
    20c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    20cc:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    20d0:	75 2c                	jne    20fe <sprintf+0x78>
            if(c == '%'){
    20d2:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    20d6:	75 0c                	jne    20e4 <sprintf+0x5e>
                state = '%';
    20d8:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    20df:	e9 a7 01 00 00       	jmp    228b <sprintf+0x205>
            } else {
                dst[j++] = c;
    20e4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20e7:	8d 50 01             	lea    0x1(%eax),%edx
    20ea:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20ed:	89 c2                	mov    %eax,%edx
    20ef:	8b 45 08             	mov    0x8(%ebp),%eax
    20f2:	01 d0                	add    %edx,%eax
    20f4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    20f7:	88 10                	mov    %dl,(%eax)
    20f9:	e9 8d 01 00 00       	jmp    228b <sprintf+0x205>
            }
        } else if(state == '%'){
    20fe:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2102:	0f 85 83 01 00 00    	jne    228b <sprintf+0x205>
            if(c == 'd'){
    2108:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    210c:	75 4c                	jne    215a <sprintf+0xd4>
                buf[bi] = '\0';
    210e:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2111:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2114:	01 d0                	add    %edx,%eax
    2116:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2119:	83 ec 0c             	sub    $0xc,%esp
    211c:	8d 45 ce             	lea    -0x32(%ebp),%eax
    211f:	50                   	push   %eax
    2120:	e8 a1 e1 ff ff       	call   2c6 <atoi>
    2125:	83 c4 10             	add    $0x10,%esp
    2128:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    212b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2132:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2135:	8b 00                	mov    (%eax),%eax
    2137:	83 ec 08             	sub    $0x8,%esp
    213a:	ff 75 d8             	pushl  -0x28(%ebp)
    213d:	6a 01                	push   $0x1
    213f:	6a 0a                	push   $0xa
    2141:	50                   	push   %eax
    2142:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2145:	50                   	push   %eax
    2146:	ff 75 08             	pushl  0x8(%ebp)
    2149:	e8 56 fe ff ff       	call   1fa4 <sprintint>
    214e:	83 c4 20             	add    $0x20,%esp
                ap++;
    2151:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2155:	e9 2a 01 00 00       	jmp    2284 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    215a:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    215e:	74 06                	je     2166 <sprintf+0xe0>
    2160:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2164:	75 4c                	jne    21b2 <sprintf+0x12c>
                buf[bi] = '\0';
    2166:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2169:	8b 45 f0             	mov    -0x10(%ebp),%eax
    216c:	01 d0                	add    %edx,%eax
    216e:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2171:	83 ec 0c             	sub    $0xc,%esp
    2174:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2177:	50                   	push   %eax
    2178:	e8 49 e1 ff ff       	call   2c6 <atoi>
    217d:	83 c4 10             	add    $0x10,%esp
    2180:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2183:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    218a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    218d:	8b 00                	mov    (%eax),%eax
    218f:	83 ec 08             	sub    $0x8,%esp
    2192:	ff 75 dc             	pushl  -0x24(%ebp)
    2195:	6a 00                	push   $0x0
    2197:	6a 10                	push   $0x10
    2199:	50                   	push   %eax
    219a:	8d 45 c8             	lea    -0x38(%ebp),%eax
    219d:	50                   	push   %eax
    219e:	ff 75 08             	pushl  0x8(%ebp)
    21a1:	e8 fe fd ff ff       	call   1fa4 <sprintint>
    21a6:	83 c4 20             	add    $0x20,%esp
                ap++;
    21a9:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    21ad:	e9 d2 00 00 00       	jmp    2284 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    21b2:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    21b6:	75 46                	jne    21fe <sprintf+0x178>
                s = (char*)*ap;
    21b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21bb:	8b 00                	mov    (%eax),%eax
    21bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    21c0:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    21c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    21c8:	75 25                	jne    21ef <sprintf+0x169>
                    s = "(null)";
    21ca:	c7 45 f4 94 24 00 00 	movl   $0x2494,-0xc(%ebp)
                while(*s != 0){
    21d1:	eb 1c                	jmp    21ef <sprintf+0x169>
                    dst[j++] = *s;
    21d3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21d6:	8d 50 01             	lea    0x1(%eax),%edx
    21d9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21dc:	89 c2                	mov    %eax,%edx
    21de:	8b 45 08             	mov    0x8(%ebp),%eax
    21e1:	01 c2                	add    %eax,%edx
    21e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21e6:	0f b6 00             	movzbl (%eax),%eax
    21e9:	88 02                	mov    %al,(%edx)
                    s++;
    21eb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    21ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21f2:	0f b6 00             	movzbl (%eax),%eax
    21f5:	84 c0                	test   %al,%al
    21f7:	75 da                	jne    21d3 <sprintf+0x14d>
    21f9:	e9 86 00 00 00       	jmp    2284 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    21fe:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2202:	75 1d                	jne    2221 <sprintf+0x19b>
                dst[j++] = *ap;
    2204:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2207:	8d 50 01             	lea    0x1(%eax),%edx
    220a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    220d:	89 c2                	mov    %eax,%edx
    220f:	8b 45 08             	mov    0x8(%ebp),%eax
    2212:	01 c2                	add    %eax,%edx
    2214:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2217:	8b 00                	mov    (%eax),%eax
    2219:	88 02                	mov    %al,(%edx)
                ap++;
    221b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    221f:	eb 63                	jmp    2284 <sprintf+0x1fe>
            } else if(c == '%'){
    2221:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2225:	75 17                	jne    223e <sprintf+0x1b8>
                dst[j++] = c;
    2227:	8b 45 c8             	mov    -0x38(%ebp),%eax
    222a:	8d 50 01             	lea    0x1(%eax),%edx
    222d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2230:	89 c2                	mov    %eax,%edx
    2232:	8b 45 08             	mov    0x8(%ebp),%eax
    2235:	01 d0                	add    %edx,%eax
    2237:	8b 55 e0             	mov    -0x20(%ebp),%edx
    223a:	88 10                	mov    %dl,(%eax)
    223c:	eb 46                	jmp    2284 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    223e:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2242:	7e 18                	jle    225c <sprintf+0x1d6>
    2244:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2248:	7f 12                	jg     225c <sprintf+0x1d6>
            {
                buf[bi++] = c;
    224a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    224d:	8d 50 01             	lea    0x1(%eax),%edx
    2250:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2253:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2256:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    225a:	eb 2f                	jmp    228b <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    225c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    225f:	8d 50 01             	lea    0x1(%eax),%edx
    2262:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2265:	89 c2                	mov    %eax,%edx
    2267:	8b 45 08             	mov    0x8(%ebp),%eax
    226a:	01 d0                	add    %edx,%eax
    226c:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    226f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2272:	8d 50 01             	lea    0x1(%eax),%edx
    2275:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2278:	89 c2                	mov    %eax,%edx
    227a:	8b 45 08             	mov    0x8(%ebp),%eax
    227d:	01 d0                	add    %edx,%eax
    227f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2282:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2284:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    228b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    228f:	8b 55 0c             	mov    0xc(%ebp),%edx
    2292:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2295:	01 d0                	add    %edx,%eax
    2297:	0f b6 00             	movzbl (%eax),%eax
    229a:	84 c0                	test   %al,%al
    229c:	0f 85 14 fe ff ff    	jne    20b6 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    22a2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22a5:	8d 50 01             	lea    0x1(%eax),%edx
    22a8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22ab:	89 c2                	mov    %eax,%edx
    22ad:	8b 45 08             	mov    0x8(%ebp),%eax
    22b0:	01 d0                	add    %edx,%eax
    22b2:	c6 00 00             	movb   $0x0,(%eax)
}
    22b5:	90                   	nop
    22b6:	c9                   	leave  
    22b7:	c3                   	ret    
