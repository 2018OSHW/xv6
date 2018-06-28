
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
      16:	68 3f 21 00 00       	push   $0x213f
      1b:	e8 78 03 00 00       	call   398 <open>
      20:	83 c4 10             	add    $0x10,%esp
      23:	85 c0                	test   %eax,%eax
      25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
      27:	83 ec 04             	sub    $0x4,%esp
      2a:	6a 01                	push   $0x1
      2c:	6a 01                	push   $0x1
      2e:	68 3f 21 00 00       	push   $0x213f
      33:	e8 68 03 00 00       	call   3a0 <mknod>
      38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
      3b:	83 ec 08             	sub    $0x8,%esp
      3e:	6a 02                	push   $0x2
      40:	68 3f 21 00 00       	push   $0x213f
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
      6a:	68 47 21 00 00       	push   $0x2147
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
      8a:	68 61 21 00 00       	push   $0x2161
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
      a7:	68 2c 28 00 00       	push   $0x282c
      ac:	68 74 21 00 00       	push   $0x2174
      b1:	e8 da 02 00 00       	call   390 <exec>
      b6:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec desktop failed\n");
      b9:	83 ec 08             	sub    $0x8,%esp
      bc:	68 7e 21 00 00       	push   $0x217e
      c1:	6a 01                	push   $0x1
      c3:	e8 2f 04 00 00       	call   4f7 <printf>
      c8:	83 c4 10             	add    $0x10,%esp
      exit();
      cb:	e8 88 02 00 00       	call   358 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
      d0:	83 ec 08             	sub    $0x8,%esp
      d3:	68 99 21 00 00       	push   $0x2199
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
     493:	0f b6 80 34 28 00 00 	movzbl 0x2834(%eax),%eax
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
     5d1:	c7 45 f4 a2 21 00 00 	movl   $0x21a2,-0xc(%ebp)
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
     697:	a1 64 28 00 00       	mov    0x2864,%eax
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
     762:	a3 64 28 00 00       	mov    %eax,0x2864
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
     7c3:	a1 64 28 00 00       	mov    0x2864,%eax
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
     7df:	a1 64 28 00 00       	mov    0x2864,%eax
     7e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7e7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7eb:	75 23                	jne    810 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     7ed:	c7 45 f0 5c 28 00 00 	movl   $0x285c,-0x10(%ebp)
     7f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7f7:	a3 64 28 00 00       	mov    %eax,0x2864
     7fc:	a1 64 28 00 00       	mov    0x2864,%eax
     801:	a3 5c 28 00 00       	mov    %eax,0x285c
    base.s.size = 0;
     806:	c7 05 60 28 00 00 00 	movl   $0x0,0x2860
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
     863:	a3 64 28 00 00       	mov    %eax,0x2864
      return (void*)(p + 1);
     868:	8b 45 f4             	mov    -0xc(%ebp),%eax
     86b:	83 c0 08             	add    $0x8,%eax
     86e:	eb 3b                	jmp    8ab <malloc+0xe1>
    }
    if(p == freep)
     870:	a1 64 28 00 00       	mov    0x2864,%eax
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
     9b6:	68 a9 21 00 00       	push   $0x21a9
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

00001272 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1272:	55                   	push   %ebp
    1273:	89 e5                	mov    %esp,%ebp
    1275:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1278:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    127c:	0f 88 8e 01 00 00    	js     1410 <APDcCopy+0x19e>
    1282:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1286:	0f 88 84 01 00 00    	js     1410 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    128c:	8b 55 0c             	mov    0xc(%ebp),%edx
    128f:	8b 45 20             	mov    0x20(%ebp),%eax
    1292:	01 d0                	add    %edx,%eax
    1294:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1297:	8b 55 10             	mov    0x10(%ebp),%edx
    129a:	8b 45 24             	mov    0x24(%ebp),%eax
    129d:	01 d0                	add    %edx,%eax
    129f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    12a2:	8b 55 18             	mov    0x18(%ebp),%edx
    12a5:	8b 45 20             	mov    0x20(%ebp),%eax
    12a8:	01 d0                	add    %edx,%eax
    12aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12ad:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12b0:	8b 45 24             	mov    0x24(%ebp),%eax
    12b3:	01 d0                	add    %edx,%eax
    12b5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    12b8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    12bc:	0f 88 51 01 00 00    	js     1413 <APDcCopy+0x1a1>
    12c2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12c6:	0f 88 47 01 00 00    	js     1413 <APDcCopy+0x1a1>
    12cc:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    12d0:	0f 88 3d 01 00 00    	js     1413 <APDcCopy+0x1a1>
    12d6:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    12da:	0f 88 33 01 00 00    	js     1413 <APDcCopy+0x1a1>
    12e0:	8b 45 14             	mov    0x14(%ebp),%eax
    12e3:	8b 00                	mov    (%eax),%eax
    12e5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    12e8:	0f 8c 25 01 00 00    	jl     1413 <APDcCopy+0x1a1>
    12ee:	8b 45 14             	mov    0x14(%ebp),%eax
    12f1:	8b 40 04             	mov    0x4(%eax),%eax
    12f4:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12f7:	0f 8c 16 01 00 00    	jl     1413 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    12fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1300:	8b 00                	mov    (%eax),%eax
    1302:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1305:	7f 0b                	jg     1312 <APDcCopy+0xa0>
    1307:	8b 45 08             	mov    0x8(%ebp),%eax
    130a:	8b 00                	mov    (%eax),%eax
    130c:	83 e8 01             	sub    $0x1,%eax
    130f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1312:	8b 45 08             	mov    0x8(%ebp),%eax
    1315:	8b 40 04             	mov    0x4(%eax),%eax
    1318:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    131b:	7f 0c                	jg     1329 <APDcCopy+0xb7>
    131d:	8b 45 08             	mov    0x8(%ebp),%eax
    1320:	8b 40 04             	mov    0x4(%eax),%eax
    1323:	83 e8 01             	sub    $0x1,%eax
    1326:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1329:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1330:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1337:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    133e:	e9 bc 00 00 00       	jmp    13ff <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1343:	8b 45 08             	mov    0x8(%ebp),%eax
    1346:	8b 00                	mov    (%eax),%eax
    1348:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    134b:	8b 55 10             	mov    0x10(%ebp),%edx
    134e:	01 ca                	add    %ecx,%edx
    1350:	0f af d0             	imul   %eax,%edx
    1353:	8b 45 0c             	mov    0xc(%ebp),%eax
    1356:	01 d0                	add    %edx,%eax
    1358:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    135b:	8b 45 14             	mov    0x14(%ebp),%eax
    135e:	8b 00                	mov    (%eax),%eax
    1360:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1363:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1366:	01 ca                	add    %ecx,%edx
    1368:	0f af d0             	imul   %eax,%edx
    136b:	8b 45 18             	mov    0x18(%ebp),%eax
    136e:	01 d0                	add    %edx,%eax
    1370:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1373:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    137a:	eb 74                	jmp    13f0 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    137c:	8b 45 14             	mov    0x14(%ebp),%eax
    137f:	8b 50 18             	mov    0x18(%eax),%edx
    1382:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1385:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1388:	01 c8                	add    %ecx,%eax
    138a:	89 c1                	mov    %eax,%ecx
    138c:	89 c8                	mov    %ecx,%eax
    138e:	01 c0                	add    %eax,%eax
    1390:	01 c8                	add    %ecx,%eax
    1392:	01 d0                	add    %edx,%eax
    1394:	0f b7 10             	movzwl (%eax),%edx
    1397:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    139b:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    139f:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    13a2:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13a6:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    13aa:	38 c2                	cmp    %al,%dl
    13ac:	75 18                	jne    13c6 <APDcCopy+0x154>
    13ae:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    13b2:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    13b6:	38 c2                	cmp    %al,%dl
    13b8:	75 0c                	jne    13c6 <APDcCopy+0x154>
    13ba:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    13be:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    13c2:	38 c2                	cmp    %al,%dl
    13c4:	74 26                	je     13ec <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    13c6:	8b 45 08             	mov    0x8(%ebp),%eax
    13c9:	8b 50 18             	mov    0x18(%eax),%edx
    13cc:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    13cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13d2:	01 c8                	add    %ecx,%eax
    13d4:	89 c1                	mov    %eax,%ecx
    13d6:	89 c8                	mov    %ecx,%eax
    13d8:	01 c0                	add    %eax,%eax
    13da:	01 c8                	add    %ecx,%eax
    13dc:	01 d0                	add    %edx,%eax
    13de:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    13e2:	66 89 10             	mov    %dx,(%eax)
    13e5:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13e9:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    13ec:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    13f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13f3:	2b 45 0c             	sub    0xc(%ebp),%eax
    13f6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    13f9:	7d 81                	jge    137c <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    13fb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    13ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1402:	2b 45 10             	sub    0x10(%ebp),%eax
    1405:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1408:	0f 8d 35 ff ff ff    	jge    1343 <APDcCopy+0xd1>
    140e:	eb 04                	jmp    1414 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1410:	90                   	nop
    1411:	eb 01                	jmp    1414 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1413:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1414:	c9                   	leave  
    1415:	c3                   	ret    

00001416 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1416:	55                   	push   %ebp
    1417:	89 e5                	mov    %esp,%ebp
    1419:	83 ec 1c             	sub    $0x1c,%esp
    141c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    141f:	8b 55 10             	mov    0x10(%ebp),%edx
    1422:	8b 45 14             	mov    0x14(%ebp),%eax
    1425:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1428:	88 55 e8             	mov    %dl,-0x18(%ebp)
    142b:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    142e:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1432:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1435:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1439:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    143c:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1440:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1443:	8b 45 08             	mov    0x8(%ebp),%eax
    1446:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    144a:	66 89 10             	mov    %dx,(%eax)
    144d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1451:	88 50 02             	mov    %dl,0x2(%eax)
}
    1454:	8b 45 08             	mov    0x8(%ebp),%eax
    1457:	c9                   	leave  
    1458:	c2 04 00             	ret    $0x4

0000145b <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    145b:	55                   	push   %ebp
    145c:	89 e5                	mov    %esp,%ebp
    145e:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1461:	8b 45 08             	mov    0x8(%ebp),%eax
    1464:	8b 00                	mov    (%eax),%eax
    1466:	83 ec 08             	sub    $0x8,%esp
    1469:	8d 55 0c             	lea    0xc(%ebp),%edx
    146c:	52                   	push   %edx
    146d:	50                   	push   %eax
    146e:	e8 95 ef ff ff       	call   408 <sendMessage>
    1473:	83 c4 10             	add    $0x10,%esp
}
    1476:	90                   	nop
    1477:	c9                   	leave  
    1478:	c3                   	ret    

00001479 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1479:	55                   	push   %ebp
    147a:	89 e5                	mov    %esp,%ebp
    147c:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    147f:	83 ec 0c             	sub    $0xc,%esp
    1482:	68 90 00 00 00       	push   $0x90
    1487:	e8 3e f3 ff ff       	call   7ca <malloc>
    148c:	83 c4 10             	add    $0x10,%esp
    148f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1492:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1496:	75 15                	jne    14ad <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1498:	83 ec 04             	sub    $0x4,%esp
    149b:	ff 75 08             	pushl  0x8(%ebp)
    149e:	68 bc 21 00 00       	push   $0x21bc
    14a3:	6a 01                	push   $0x1
    14a5:	e8 4d f0 ff ff       	call   4f7 <printf>
    14aa:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    14ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b0:	83 c0 7c             	add    $0x7c,%eax
    14b3:	83 ec 08             	sub    $0x8,%esp
    14b6:	ff 75 08             	pushl  0x8(%ebp)
    14b9:	50                   	push   %eax
    14ba:	e8 68 ec ff ff       	call   127 <strcpy>
    14bf:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    14c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c5:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    14cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cf:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d9:	8b 40 34             	mov    0x34(%eax),%eax
    14dc:	89 c2                	mov    %eax,%edx
    14de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e1:	8b 40 38             	mov    0x38(%eax),%eax
    14e4:	0f af d0             	imul   %eax,%edx
    14e7:	89 d0                	mov    %edx,%eax
    14e9:	01 c0                	add    %eax,%eax
    14eb:	01 d0                	add    %edx,%eax
    14ed:	83 ec 0c             	sub    $0xc,%esp
    14f0:	50                   	push   %eax
    14f1:	e8 d4 f2 ff ff       	call   7ca <malloc>
    14f6:	83 c4 10             	add    $0x10,%esp
    14f9:	89 c2                	mov    %eax,%edx
    14fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14fe:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1501:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1504:	8b 40 4c             	mov    0x4c(%eax),%eax
    1507:	85 c0                	test   %eax,%eax
    1509:	75 15                	jne    1520 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    150b:	83 ec 04             	sub    $0x4,%esp
    150e:	ff 75 08             	pushl  0x8(%ebp)
    1511:	68 dc 21 00 00       	push   $0x21dc
    1516:	6a 01                	push   $0x1
    1518:	e8 da ef ff ff       	call   4f7 <printf>
    151d:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1520:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1523:	8b 40 34             	mov    0x34(%eax),%eax
    1526:	89 c2                	mov    %eax,%edx
    1528:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152b:	8b 40 38             	mov    0x38(%eax),%eax
    152e:	0f af d0             	imul   %eax,%edx
    1531:	89 d0                	mov    %edx,%eax
    1533:	01 c0                	add    %eax,%eax
    1535:	01 c2                	add    %eax,%edx
    1537:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153a:	8b 40 4c             	mov    0x4c(%eax),%eax
    153d:	83 ec 04             	sub    $0x4,%esp
    1540:	52                   	push   %edx
    1541:	68 ff ff ff 00       	push   $0xffffff
    1546:	50                   	push   %eax
    1547:	e8 71 ec ff ff       	call   1bd <memset>
    154c:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    154f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1552:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    1559:	e8 7a ee ff ff       	call   3d8 <getpid>
    155e:	89 c2                	mov    %eax,%edx
    1560:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1563:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1566:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1569:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1570:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1573:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    157a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157d:	8b 40 50             	mov    0x50(%eax),%eax
    1580:	89 c2                	mov    %eax,%edx
    1582:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1585:	8b 40 54             	mov    0x54(%eax),%eax
    1588:	0f af d0             	imul   %eax,%edx
    158b:	89 d0                	mov    %edx,%eax
    158d:	01 c0                	add    %eax,%eax
    158f:	01 d0                	add    %edx,%eax
    1591:	83 ec 0c             	sub    $0xc,%esp
    1594:	50                   	push   %eax
    1595:	e8 30 f2 ff ff       	call   7ca <malloc>
    159a:	83 c4 10             	add    $0x10,%esp
    159d:	89 c2                	mov    %eax,%edx
    159f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a2:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    15a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a8:	8b 40 68             	mov    0x68(%eax),%eax
    15ab:	85 c0                	test   %eax,%eax
    15ad:	75 15                	jne    15c4 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    15af:	83 ec 04             	sub    $0x4,%esp
    15b2:	ff 75 08             	pushl  0x8(%ebp)
    15b5:	68 00 22 00 00       	push   $0x2200
    15ba:	6a 01                	push   $0x1
    15bc:	e8 36 ef ff ff       	call   4f7 <printf>
    15c1:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c7:	8b 40 34             	mov    0x34(%eax),%eax
    15ca:	89 c2                	mov    %eax,%edx
    15cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cf:	8b 40 38             	mov    0x38(%eax),%eax
    15d2:	0f af d0             	imul   %eax,%edx
    15d5:	89 d0                	mov    %edx,%eax
    15d7:	01 c0                	add    %eax,%eax
    15d9:	01 c2                	add    %eax,%edx
    15db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15de:	8b 40 4c             	mov    0x4c(%eax),%eax
    15e1:	83 ec 04             	sub    $0x4,%esp
    15e4:	52                   	push   %edx
    15e5:	68 ff 00 00 00       	push   $0xff
    15ea:	50                   	push   %eax
    15eb:	e8 cd eb ff ff       	call   1bd <memset>
    15f0:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    15f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f6:	8b 55 0c             	mov    0xc(%ebp),%edx
    15f9:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    15fc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1600:	74 35                	je     1637 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1602:	8b 45 10             	mov    0x10(%ebp),%eax
    1605:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    160b:	83 ec 0c             	sub    $0xc,%esp
    160e:	50                   	push   %eax
    160f:	e8 b6 f1 ff ff       	call   7ca <malloc>
    1614:	83 c4 10             	add    $0x10,%esp
    1617:	89 c2                	mov    %eax,%edx
    1619:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161c:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    161f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1622:	8b 55 10             	mov    0x10(%ebp),%edx
    1625:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1628:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162b:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    1632:	e9 8d 00 00 00       	jmp    16c4 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1637:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163a:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1641:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1644:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    164b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164e:	8b 40 18             	mov    0x18(%eax),%eax
    1651:	89 c2                	mov    %eax,%edx
    1653:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1656:	8b 40 1c             	mov    0x1c(%eax),%eax
    1659:	0f af d0             	imul   %eax,%edx
    165c:	89 d0                	mov    %edx,%eax
    165e:	01 c0                	add    %eax,%eax
    1660:	01 d0                	add    %edx,%eax
    1662:	83 ec 0c             	sub    $0xc,%esp
    1665:	50                   	push   %eax
    1666:	e8 5f f1 ff ff       	call   7ca <malloc>
    166b:	83 c4 10             	add    $0x10,%esp
    166e:	89 c2                	mov    %eax,%edx
    1670:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1673:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    1676:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1679:	8b 40 30             	mov    0x30(%eax),%eax
    167c:	85 c0                	test   %eax,%eax
    167e:	75 15                	jne    1695 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1680:	83 ec 04             	sub    $0x4,%esp
    1683:	ff 75 08             	pushl  0x8(%ebp)
    1686:	68 28 22 00 00       	push   $0x2228
    168b:	6a 01                	push   $0x1
    168d:	e8 65 ee ff ff       	call   4f7 <printf>
    1692:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1695:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1698:	8b 40 18             	mov    0x18(%eax),%eax
    169b:	89 c2                	mov    %eax,%edx
    169d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a0:	8b 40 1c             	mov    0x1c(%eax),%eax
    16a3:	0f af d0             	imul   %eax,%edx
    16a6:	89 d0                	mov    %edx,%eax
    16a8:	01 c0                	add    %eax,%eax
    16aa:	01 c2                	add    %eax,%edx
    16ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16af:	8b 40 30             	mov    0x30(%eax),%eax
    16b2:	83 ec 04             	sub    $0x4,%esp
    16b5:	52                   	push   %edx
    16b6:	68 ff ff ff 00       	push   $0xffffff
    16bb:	50                   	push   %eax
    16bc:	e8 fc ea ff ff       	call   1bd <memset>
    16c1:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    16c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    16c7:	c9                   	leave  
    16c8:	c3                   	ret    

000016c9 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    16c9:	55                   	push   %ebp
    16ca:	89 e5                	mov    %esp,%ebp
    16cc:	53                   	push   %ebx
    16cd:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    16d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    16d3:	83 f8 03             	cmp    $0x3,%eax
    16d6:	74 02                	je     16da <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    16d8:	eb 33                	jmp    170d <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    16da:	8b 45 08             	mov    0x8(%ebp),%eax
    16dd:	8b 48 08             	mov    0x8(%eax),%ecx
    16e0:	8b 45 08             	mov    0x8(%ebp),%eax
    16e3:	8b 50 38             	mov    0x38(%eax),%edx
    16e6:	8b 45 08             	mov    0x8(%ebp),%eax
    16e9:	8b 40 34             	mov    0x34(%eax),%eax
    16ec:	8b 5d 08             	mov    0x8(%ebp),%ebx
    16ef:	83 c3 34             	add    $0x34,%ebx
    16f2:	83 ec 0c             	sub    $0xc,%esp
    16f5:	51                   	push   %ecx
    16f6:	52                   	push   %edx
    16f7:	50                   	push   %eax
    16f8:	6a 00                	push   $0x0
    16fa:	6a 00                	push   $0x0
    16fc:	53                   	push   %ebx
    16fd:	6a 32                	push   $0x32
    16ff:	6a 00                	push   $0x0
    1701:	ff 75 08             	pushl  0x8(%ebp)
    1704:	e8 ef ec ff ff       	call   3f8 <paintWindow>
    1709:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    170c:	90                   	nop
        default: break;
            
            
    }
    return False;
    170d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1712:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1715:	c9                   	leave  
    1716:	c3                   	ret    

00001717 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1717:	55                   	push   %ebp
    1718:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    171a:	8b 45 0c             	mov    0xc(%ebp),%eax
    171d:	8b 50 08             	mov    0x8(%eax),%edx
    1720:	8b 45 08             	mov    0x8(%ebp),%eax
    1723:	8b 00                	mov    (%eax),%eax
    1725:	39 c2                	cmp    %eax,%edx
    1727:	74 07                	je     1730 <APPreJudge+0x19>
        return False;
    1729:	b8 00 00 00 00       	mov    $0x0,%eax
    172e:	eb 05                	jmp    1735 <APPreJudge+0x1e>
    return True;
    1730:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1735:	5d                   	pop    %ebp
    1736:	c3                   	ret    

00001737 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1737:	55                   	push   %ebp
    1738:	89 e5                	mov    %esp,%ebp
    173a:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    173d:	8b 45 08             	mov    0x8(%ebp),%eax
    1740:	8b 55 0c             	mov    0xc(%ebp),%edx
    1743:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    1746:	83 ec 0c             	sub    $0xc,%esp
    1749:	ff 75 08             	pushl  0x8(%ebp)
    174c:	e8 c7 ec ff ff       	call   418 <registWindow>
    1751:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1754:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    175b:	8b 45 08             	mov    0x8(%ebp),%eax
    175e:	8b 00                	mov    (%eax),%eax
    1760:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1763:	ff 75 f4             	pushl  -0xc(%ebp)
    1766:	ff 75 f0             	pushl  -0x10(%ebp)
    1769:	ff 75 ec             	pushl  -0x14(%ebp)
    176c:	ff 75 08             	pushl  0x8(%ebp)
    176f:	e8 e7 fc ff ff       	call   145b <APSendMessage>
    1774:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1777:	83 ec 0c             	sub    $0xc,%esp
    177a:	ff 75 08             	pushl  0x8(%ebp)
    177d:	e8 8e ec ff ff       	call   410 <getMessage>
    1782:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1785:	8b 45 08             	mov    0x8(%ebp),%eax
    1788:	83 c0 6c             	add    $0x6c,%eax
    178b:	83 ec 08             	sub    $0x8,%esp
    178e:	50                   	push   %eax
    178f:	ff 75 08             	pushl  0x8(%ebp)
    1792:	e8 80 ff ff ff       	call   1717 <APPreJudge>
    1797:	83 c4 10             	add    $0x10,%esp
    179a:	84 c0                	test   %al,%al
    179c:	74 1b                	je     17b9 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    179e:	8b 45 08             	mov    0x8(%ebp),%eax
    17a1:	ff 70 74             	pushl  0x74(%eax)
    17a4:	ff 70 70             	pushl  0x70(%eax)
    17a7:	ff 70 6c             	pushl  0x6c(%eax)
    17aa:	ff 75 08             	pushl  0x8(%ebp)
    17ad:	8b 45 0c             	mov    0xc(%ebp),%eax
    17b0:	ff d0                	call   *%eax
    17b2:	83 c4 10             	add    $0x10,%esp
    17b5:	84 c0                	test   %al,%al
    17b7:	75 0c                	jne    17c5 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    17b9:	8b 45 08             	mov    0x8(%ebp),%eax
    17bc:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    17c3:	eb b2                	jmp    1777 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    17c5:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    17c6:	90                   	nop
    17c7:	c9                   	leave  
    17c8:	c3                   	ret    

000017c9 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    17c9:	55                   	push   %ebp
    17ca:	89 e5                	mov    %esp,%ebp
    17cc:	57                   	push   %edi
    17cd:	56                   	push   %esi
    17ce:	53                   	push   %ebx
    17cf:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    17d2:	a1 68 28 00 00       	mov    0x2868,%eax
    17d7:	85 c0                	test   %eax,%eax
    17d9:	0f 85 2c 02 00 00    	jne    1a0b <APGridPaint+0x242>
    {
        iconReady = 1;
    17df:	c7 05 68 28 00 00 01 	movl   $0x1,0x2868
    17e6:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    17e9:	8d 45 98             	lea    -0x68(%ebp),%eax
    17ec:	83 ec 08             	sub    $0x8,%esp
    17ef:	68 4f 22 00 00       	push   $0x224f
    17f4:	50                   	push   %eax
    17f5:	e8 83 f1 ff ff       	call   97d <APLoadBitmap>
    17fa:	83 c4 0c             	add    $0xc,%esp
    17fd:	8b 45 98             	mov    -0x68(%ebp),%eax
    1800:	a3 8c 28 00 00       	mov    %eax,0x288c
    1805:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1808:	a3 90 28 00 00       	mov    %eax,0x2890
    180d:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1810:	a3 94 28 00 00       	mov    %eax,0x2894
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1815:	83 ec 04             	sub    $0x4,%esp
    1818:	ff 35 94 28 00 00    	pushl  0x2894
    181e:	ff 35 90 28 00 00    	pushl  0x2890
    1824:	ff 35 8c 28 00 00    	pushl  0x288c
    182a:	e8 88 f3 ff ff       	call   bb7 <APCreateCompatibleDCFromBitmap>
    182f:	83 c4 10             	add    $0x10,%esp
    1832:	a3 98 28 00 00       	mov    %eax,0x2898
        grid_river = APLoadBitmap ("grid_river.bmp");
    1837:	8d 45 98             	lea    -0x68(%ebp),%eax
    183a:	83 ec 08             	sub    $0x8,%esp
    183d:	68 5d 22 00 00       	push   $0x225d
    1842:	50                   	push   %eax
    1843:	e8 35 f1 ff ff       	call   97d <APLoadBitmap>
    1848:	83 c4 0c             	add    $0xc,%esp
    184b:	8b 45 98             	mov    -0x68(%ebp),%eax
    184e:	a3 c8 28 00 00       	mov    %eax,0x28c8
    1853:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1856:	a3 cc 28 00 00       	mov    %eax,0x28cc
    185b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    185e:	a3 d0 28 00 00       	mov    %eax,0x28d0
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1863:	83 ec 04             	sub    $0x4,%esp
    1866:	ff 35 d0 28 00 00    	pushl  0x28d0
    186c:	ff 35 cc 28 00 00    	pushl  0x28cc
    1872:	ff 35 c8 28 00 00    	pushl  0x28c8
    1878:	e8 3a f3 ff ff       	call   bb7 <APCreateCompatibleDCFromBitmap>
    187d:	83 c4 10             	add    $0x10,%esp
    1880:	a3 b8 28 00 00       	mov    %eax,0x28b8
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1885:	8d 45 98             	lea    -0x68(%ebp),%eax
    1888:	83 ec 08             	sub    $0x8,%esp
    188b:	68 6c 22 00 00       	push   $0x226c
    1890:	50                   	push   %eax
    1891:	e8 e7 f0 ff ff       	call   97d <APLoadBitmap>
    1896:	83 c4 0c             	add    $0xc,%esp
    1899:	8b 45 98             	mov    -0x68(%ebp),%eax
    189c:	a3 bc 28 00 00       	mov    %eax,0x28bc
    18a1:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18a4:	a3 c0 28 00 00       	mov    %eax,0x28c0
    18a9:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18ac:	a3 c4 28 00 00       	mov    %eax,0x28c4
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    18b1:	83 ec 04             	sub    $0x4,%esp
    18b4:	ff 35 c4 28 00 00    	pushl  0x28c4
    18ba:	ff 35 c0 28 00 00    	pushl  0x28c0
    18c0:	ff 35 bc 28 00 00    	pushl  0x28bc
    18c6:	e8 ec f2 ff ff       	call   bb7 <APCreateCompatibleDCFromBitmap>
    18cb:	83 c4 10             	add    $0x10,%esp
    18ce:	a3 6c 28 00 00       	mov    %eax,0x286c
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    18d3:	8d 45 98             	lea    -0x68(%ebp),%eax
    18d6:	83 ec 08             	sub    $0x8,%esp
    18d9:	68 7b 22 00 00       	push   $0x227b
    18de:	50                   	push   %eax
    18df:	e8 99 f0 ff ff       	call   97d <APLoadBitmap>
    18e4:	83 c4 0c             	add    $0xc,%esp
    18e7:	8b 45 98             	mov    -0x68(%ebp),%eax
    18ea:	a3 a0 28 00 00       	mov    %eax,0x28a0
    18ef:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18f2:	a3 a4 28 00 00       	mov    %eax,0x28a4
    18f7:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18fa:	a3 a8 28 00 00       	mov    %eax,0x28a8
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    18ff:	83 ec 04             	sub    $0x4,%esp
    1902:	ff 35 a8 28 00 00    	pushl  0x28a8
    1908:	ff 35 a4 28 00 00    	pushl  0x28a4
    190e:	ff 35 a0 28 00 00    	pushl  0x28a0
    1914:	e8 9e f2 ff ff       	call   bb7 <APCreateCompatibleDCFromBitmap>
    1919:	83 c4 10             	add    $0x10,%esp
    191c:	a3 d4 28 00 00       	mov    %eax,0x28d4
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1921:	8d 45 98             	lea    -0x68(%ebp),%eax
    1924:	83 ec 08             	sub    $0x8,%esp
    1927:	68 89 22 00 00       	push   $0x2289
    192c:	50                   	push   %eax
    192d:	e8 4b f0 ff ff       	call   97d <APLoadBitmap>
    1932:	83 c4 0c             	add    $0xc,%esp
    1935:	8b 45 98             	mov    -0x68(%ebp),%eax
    1938:	a3 7c 28 00 00       	mov    %eax,0x287c
    193d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1940:	a3 80 28 00 00       	mov    %eax,0x2880
    1945:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1948:	a3 84 28 00 00       	mov    %eax,0x2884
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    194d:	83 ec 04             	sub    $0x4,%esp
    1950:	ff 35 84 28 00 00    	pushl  0x2884
    1956:	ff 35 80 28 00 00    	pushl  0x2880
    195c:	ff 35 7c 28 00 00    	pushl  0x287c
    1962:	e8 50 f2 ff ff       	call   bb7 <APCreateCompatibleDCFromBitmap>
    1967:	83 c4 10             	add    $0x10,%esp
    196a:	a3 9c 28 00 00       	mov    %eax,0x289c
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    196f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1972:	83 ec 08             	sub    $0x8,%esp
    1975:	68 99 22 00 00       	push   $0x2299
    197a:	50                   	push   %eax
    197b:	e8 fd ef ff ff       	call   97d <APLoadBitmap>
    1980:	83 c4 0c             	add    $0xc,%esp
    1983:	8b 45 98             	mov    -0x68(%ebp),%eax
    1986:	a3 70 28 00 00       	mov    %eax,0x2870
    198b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    198e:	a3 74 28 00 00       	mov    %eax,0x2874
    1993:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1996:	a3 78 28 00 00       	mov    %eax,0x2878
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    199b:	83 ec 04             	sub    $0x4,%esp
    199e:	ff 35 78 28 00 00    	pushl  0x2878
    19a4:	ff 35 74 28 00 00    	pushl  0x2874
    19aa:	ff 35 70 28 00 00    	pushl  0x2870
    19b0:	e8 02 f2 ff ff       	call   bb7 <APCreateCompatibleDCFromBitmap>
    19b5:	83 c4 10             	add    $0x10,%esp
    19b8:	a3 88 28 00 00       	mov    %eax,0x2888
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    19bd:	8d 45 98             	lea    -0x68(%ebp),%eax
    19c0:	83 ec 08             	sub    $0x8,%esp
    19c3:	68 ab 22 00 00       	push   $0x22ab
    19c8:	50                   	push   %eax
    19c9:	e8 af ef ff ff       	call   97d <APLoadBitmap>
    19ce:	83 c4 0c             	add    $0xc,%esp
    19d1:	8b 45 98             	mov    -0x68(%ebp),%eax
    19d4:	a3 ac 28 00 00       	mov    %eax,0x28ac
    19d9:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19dc:	a3 b0 28 00 00       	mov    %eax,0x28b0
    19e1:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19e4:	a3 b4 28 00 00       	mov    %eax,0x28b4
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    19e9:	83 ec 04             	sub    $0x4,%esp
    19ec:	ff 35 b4 28 00 00    	pushl  0x28b4
    19f2:	ff 35 b0 28 00 00    	pushl  0x28b0
    19f8:	ff 35 ac 28 00 00    	pushl  0x28ac
    19fe:	e8 b4 f1 ff ff       	call   bb7 <APCreateCompatibleDCFromBitmap>
    1a03:	83 c4 10             	add    $0x10,%esp
    1a06:	a3 d8 28 00 00       	mov    %eax,0x28d8
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1a0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0e:	8b 40 08             	mov    0x8(%eax),%eax
    1a11:	85 c0                	test   %eax,%eax
    1a13:	75 17                	jne    1a2c <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1a15:	83 ec 08             	sub    $0x8,%esp
    1a18:	68 bc 22 00 00       	push   $0x22bc
    1a1d:	6a 01                	push   $0x1
    1a1f:	e8 d3 ea ff ff       	call   4f7 <printf>
    1a24:	83 c4 10             	add    $0x10,%esp
        return;
    1a27:	e9 f2 03 00 00       	jmp    1e1e <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1a2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2f:	8b 40 10             	mov    0x10(%eax),%eax
    1a32:	85 c0                	test   %eax,%eax
    1a34:	7e 10                	jle    1a46 <APGridPaint+0x27d>
    1a36:	8b 45 08             	mov    0x8(%ebp),%eax
    1a39:	8b 50 14             	mov    0x14(%eax),%edx
    1a3c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3f:	8b 40 10             	mov    0x10(%eax),%eax
    1a42:	39 c2                	cmp    %eax,%edx
    1a44:	7c 17                	jl     1a5d <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1a46:	83 ec 08             	sub    $0x8,%esp
    1a49:	68 e2 22 00 00       	push   $0x22e2
    1a4e:	6a 01                	push   $0x1
    1a50:	e8 a2 ea ff ff       	call   4f7 <printf>
    1a55:	83 c4 10             	add    $0x10,%esp
        return;
    1a58:	e9 c1 03 00 00       	jmp    1e1e <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1a5d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a60:	8b 40 14             	mov    0x14(%eax),%eax
    1a63:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a69:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a6c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a6f:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a72:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a79:	e9 96 03 00 00       	jmp    1e14 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a7e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a85:	e9 7c 03 00 00       	jmp    1e06 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a8a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a8d:	c1 e0 04             	shl    $0x4,%eax
    1a90:	89 c2                	mov    %eax,%edx
    1a92:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a95:	01 c2                	add    %eax,%edx
    1a97:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a9a:	01 d0                	add    %edx,%eax
    1a9c:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa2:	8b 40 0c             	mov    0xc(%eax),%eax
    1aa5:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1aa8:	c1 e2 02             	shl    $0x2,%edx
    1aab:	01 d0                	add    %edx,%eax
    1aad:	8b 00                	mov    (%eax),%eax
    1aaf:	83 f8 07             	cmp    $0x7,%eax
    1ab2:	0f 87 49 03 00 00    	ja     1e01 <APGridPaint+0x638>
    1ab8:	8b 04 85 f8 22 00 00 	mov    0x22f8(,%eax,4),%eax
    1abf:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ac1:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1ac4:	6a 0c                	push   $0xc
    1ac6:	6a 0c                	push   $0xc
    1ac8:	6a 0c                	push   $0xc
    1aca:	50                   	push   %eax
    1acb:	e8 46 f9 ff ff       	call   1416 <RGB>
    1ad0:	83 c4 0c             	add    $0xc,%esp
    1ad3:	8b 1d 98 28 00 00    	mov    0x2898,%ebx
    1ad9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1adc:	6b c8 32             	imul   $0x32,%eax,%ecx
    1adf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ae2:	6b c0 32             	imul   $0x32,%eax,%eax
    1ae5:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ae8:	8b 45 08             	mov    0x8(%ebp),%eax
    1aeb:	8d 78 34             	lea    0x34(%eax),%edi
    1aee:	83 ec 0c             	sub    $0xc,%esp
    1af1:	83 ec 04             	sub    $0x4,%esp
    1af4:	89 e0                	mov    %esp,%eax
    1af6:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1afa:	66 89 30             	mov    %si,(%eax)
    1afd:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1b01:	88 50 02             	mov    %dl,0x2(%eax)
    1b04:	6a 32                	push   $0x32
    1b06:	6a 32                	push   $0x32
    1b08:	6a 00                	push   $0x0
    1b0a:	6a 00                	push   $0x0
    1b0c:	53                   	push   %ebx
    1b0d:	51                   	push   %ecx
    1b0e:	ff 75 94             	pushl  -0x6c(%ebp)
    1b11:	57                   	push   %edi
    1b12:	e8 5b f7 ff ff       	call   1272 <APDcCopy>
    1b17:	83 c4 30             	add    $0x30,%esp
                    break;
    1b1a:	e9 e3 02 00 00       	jmp    1e02 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1b1f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b22:	6a 69                	push   $0x69
    1b24:	6a 69                	push   $0x69
    1b26:	6a 69                	push   $0x69
    1b28:	50                   	push   %eax
    1b29:	e8 e8 f8 ff ff       	call   1416 <RGB>
    1b2e:	83 c4 0c             	add    $0xc,%esp
    1b31:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b35:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1b39:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b3d:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1b40:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1b47:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b4a:	6a 69                	push   $0x69
    1b4c:	6a 69                	push   $0x69
    1b4e:	6a 69                	push   $0x69
    1b50:	50                   	push   %eax
    1b51:	e8 c0 f8 ff ff       	call   1416 <RGB>
    1b56:	83 c4 0c             	add    $0xc,%esp
    1b59:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b5d:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1b61:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b65:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b68:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6b:	8d 50 34             	lea    0x34(%eax),%edx
    1b6e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b71:	ff 75 bc             	pushl  -0x44(%ebp)
    1b74:	ff 75 b8             	pushl  -0x48(%ebp)
    1b77:	52                   	push   %edx
    1b78:	50                   	push   %eax
    1b79:	e8 ce f0 ff ff       	call   c4c <APSetPen>
    1b7e:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b81:	8b 45 08             	mov    0x8(%ebp),%eax
    1b84:	8d 58 34             	lea    0x34(%eax),%ebx
    1b87:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b8a:	83 ec 04             	sub    $0x4,%esp
    1b8d:	83 ec 04             	sub    $0x4,%esp
    1b90:	89 e0                	mov    %esp,%eax
    1b92:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1b96:	66 89 08             	mov    %cx,(%eax)
    1b99:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1b9d:	88 48 02             	mov    %cl,0x2(%eax)
    1ba0:	53                   	push   %ebx
    1ba1:	52                   	push   %edx
    1ba2:	e8 de f0 ff ff       	call   c85 <APSetBrush>
    1ba7:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1baa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bad:	6b d0 32             	imul   $0x32,%eax,%edx
    1bb0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bb3:	6b c0 32             	imul   $0x32,%eax,%eax
    1bb6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bb9:	83 c1 34             	add    $0x34,%ecx
    1bbc:	83 ec 0c             	sub    $0xc,%esp
    1bbf:	6a 32                	push   $0x32
    1bc1:	6a 32                	push   $0x32
    1bc3:	52                   	push   %edx
    1bc4:	50                   	push   %eax
    1bc5:	51                   	push   %ecx
    1bc6:	e8 a2 f4 ff ff       	call   106d <APDrawRect>
    1bcb:	83 c4 20             	add    $0x20,%esp
                    break;
    1bce:	e9 2f 02 00 00       	jmp    1e02 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bd3:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1bd6:	6a 0c                	push   $0xc
    1bd8:	6a 0c                	push   $0xc
    1bda:	6a 0c                	push   $0xc
    1bdc:	50                   	push   %eax
    1bdd:	e8 34 f8 ff ff       	call   1416 <RGB>
    1be2:	83 c4 0c             	add    $0xc,%esp
    1be5:	8b 1d d8 28 00 00    	mov    0x28d8,%ebx
    1beb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bee:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bf1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bf4:	6b c0 32             	imul   $0x32,%eax,%eax
    1bf7:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bfa:	8b 45 08             	mov    0x8(%ebp),%eax
    1bfd:	8d 78 34             	lea    0x34(%eax),%edi
    1c00:	83 ec 0c             	sub    $0xc,%esp
    1c03:	83 ec 04             	sub    $0x4,%esp
    1c06:	89 e0                	mov    %esp,%eax
    1c08:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1c0c:	66 89 30             	mov    %si,(%eax)
    1c0f:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1c13:	88 50 02             	mov    %dl,0x2(%eax)
    1c16:	6a 32                	push   $0x32
    1c18:	6a 32                	push   $0x32
    1c1a:	6a 00                	push   $0x0
    1c1c:	6a 00                	push   $0x0
    1c1e:	53                   	push   %ebx
    1c1f:	51                   	push   %ecx
    1c20:	ff 75 94             	pushl  -0x6c(%ebp)
    1c23:	57                   	push   %edi
    1c24:	e8 49 f6 ff ff       	call   1272 <APDcCopy>
    1c29:	83 c4 30             	add    $0x30,%esp
                    break;
    1c2c:	e9 d1 01 00 00       	jmp    1e02 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c31:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1c34:	6a 0c                	push   $0xc
    1c36:	6a 0c                	push   $0xc
    1c38:	6a 0c                	push   $0xc
    1c3a:	50                   	push   %eax
    1c3b:	e8 d6 f7 ff ff       	call   1416 <RGB>
    1c40:	83 c4 0c             	add    $0xc,%esp
    1c43:	8b 1d b8 28 00 00    	mov    0x28b8,%ebx
    1c49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c4c:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c4f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c52:	6b c0 32             	imul   $0x32,%eax,%eax
    1c55:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c58:	8b 45 08             	mov    0x8(%ebp),%eax
    1c5b:	8d 78 34             	lea    0x34(%eax),%edi
    1c5e:	83 ec 0c             	sub    $0xc,%esp
    1c61:	83 ec 04             	sub    $0x4,%esp
    1c64:	89 e0                	mov    %esp,%eax
    1c66:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1c6a:	66 89 30             	mov    %si,(%eax)
    1c6d:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c71:	88 50 02             	mov    %dl,0x2(%eax)
    1c74:	6a 32                	push   $0x32
    1c76:	6a 32                	push   $0x32
    1c78:	6a 00                	push   $0x0
    1c7a:	6a 00                	push   $0x0
    1c7c:	53                   	push   %ebx
    1c7d:	51                   	push   %ecx
    1c7e:	ff 75 94             	pushl  -0x6c(%ebp)
    1c81:	57                   	push   %edi
    1c82:	e8 eb f5 ff ff       	call   1272 <APDcCopy>
    1c87:	83 c4 30             	add    $0x30,%esp
                    break;
    1c8a:	e9 73 01 00 00       	jmp    1e02 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c8f:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c92:	6a 0c                	push   $0xc
    1c94:	6a 0c                	push   $0xc
    1c96:	6a 0c                	push   $0xc
    1c98:	50                   	push   %eax
    1c99:	e8 78 f7 ff ff       	call   1416 <RGB>
    1c9e:	83 c4 0c             	add    $0xc,%esp
    1ca1:	8b 1d 9c 28 00 00    	mov    0x289c,%ebx
    1ca7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1caa:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cad:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cb0:	6b c0 32             	imul   $0x32,%eax,%eax
    1cb3:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cb6:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb9:	8d 78 34             	lea    0x34(%eax),%edi
    1cbc:	83 ec 0c             	sub    $0xc,%esp
    1cbf:	83 ec 04             	sub    $0x4,%esp
    1cc2:	89 e0                	mov    %esp,%eax
    1cc4:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1cc8:	66 89 30             	mov    %si,(%eax)
    1ccb:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1ccf:	88 50 02             	mov    %dl,0x2(%eax)
    1cd2:	6a 32                	push   $0x32
    1cd4:	6a 32                	push   $0x32
    1cd6:	6a 00                	push   $0x0
    1cd8:	6a 00                	push   $0x0
    1cda:	53                   	push   %ebx
    1cdb:	51                   	push   %ecx
    1cdc:	ff 75 94             	pushl  -0x6c(%ebp)
    1cdf:	57                   	push   %edi
    1ce0:	e8 8d f5 ff ff       	call   1272 <APDcCopy>
    1ce5:	83 c4 30             	add    $0x30,%esp
                    break;
    1ce8:	e9 15 01 00 00       	jmp    1e02 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ced:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1cf0:	6a 0c                	push   $0xc
    1cf2:	6a 0c                	push   $0xc
    1cf4:	6a 0c                	push   $0xc
    1cf6:	50                   	push   %eax
    1cf7:	e8 1a f7 ff ff       	call   1416 <RGB>
    1cfc:	83 c4 0c             	add    $0xc,%esp
    1cff:	8b 1d d4 28 00 00    	mov    0x28d4,%ebx
    1d05:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d08:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d0b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d0e:	6b c0 32             	imul   $0x32,%eax,%eax
    1d11:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d14:	8b 45 08             	mov    0x8(%ebp),%eax
    1d17:	8d 78 34             	lea    0x34(%eax),%edi
    1d1a:	83 ec 0c             	sub    $0xc,%esp
    1d1d:	83 ec 04             	sub    $0x4,%esp
    1d20:	89 e0                	mov    %esp,%eax
    1d22:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1d26:	66 89 30             	mov    %si,(%eax)
    1d29:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1d2d:	88 50 02             	mov    %dl,0x2(%eax)
    1d30:	6a 32                	push   $0x32
    1d32:	6a 32                	push   $0x32
    1d34:	6a 00                	push   $0x0
    1d36:	6a 00                	push   $0x0
    1d38:	53                   	push   %ebx
    1d39:	51                   	push   %ecx
    1d3a:	ff 75 94             	pushl  -0x6c(%ebp)
    1d3d:	57                   	push   %edi
    1d3e:	e8 2f f5 ff ff       	call   1272 <APDcCopy>
    1d43:	83 c4 30             	add    $0x30,%esp
                    break;
    1d46:	e9 b7 00 00 00       	jmp    1e02 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d4b:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1d4e:	6a 0c                	push   $0xc
    1d50:	6a 0c                	push   $0xc
    1d52:	6a 0c                	push   $0xc
    1d54:	50                   	push   %eax
    1d55:	e8 bc f6 ff ff       	call   1416 <RGB>
    1d5a:	83 c4 0c             	add    $0xc,%esp
    1d5d:	8b 1d 6c 28 00 00    	mov    0x286c,%ebx
    1d63:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d66:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d69:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d6c:	6b c0 32             	imul   $0x32,%eax,%eax
    1d6f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d72:	8b 45 08             	mov    0x8(%ebp),%eax
    1d75:	8d 78 34             	lea    0x34(%eax),%edi
    1d78:	83 ec 0c             	sub    $0xc,%esp
    1d7b:	83 ec 04             	sub    $0x4,%esp
    1d7e:	89 e0                	mov    %esp,%eax
    1d80:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d84:	66 89 30             	mov    %si,(%eax)
    1d87:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d8b:	88 50 02             	mov    %dl,0x2(%eax)
    1d8e:	6a 32                	push   $0x32
    1d90:	6a 32                	push   $0x32
    1d92:	6a 00                	push   $0x0
    1d94:	6a 00                	push   $0x0
    1d96:	53                   	push   %ebx
    1d97:	51                   	push   %ecx
    1d98:	ff 75 94             	pushl  -0x6c(%ebp)
    1d9b:	57                   	push   %edi
    1d9c:	e8 d1 f4 ff ff       	call   1272 <APDcCopy>
    1da1:	83 c4 30             	add    $0x30,%esp
                    break;
    1da4:	eb 5c                	jmp    1e02 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1da6:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1da9:	6a 0c                	push   $0xc
    1dab:	6a 0c                	push   $0xc
    1dad:	6a 0c                	push   $0xc
    1daf:	50                   	push   %eax
    1db0:	e8 61 f6 ff ff       	call   1416 <RGB>
    1db5:	83 c4 0c             	add    $0xc,%esp
    1db8:	8b 1d 88 28 00 00    	mov    0x2888,%ebx
    1dbe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dc1:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dc4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dc7:	6b c0 32             	imul   $0x32,%eax,%eax
    1dca:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dcd:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd0:	8d 78 34             	lea    0x34(%eax),%edi
    1dd3:	83 ec 0c             	sub    $0xc,%esp
    1dd6:	83 ec 04             	sub    $0x4,%esp
    1dd9:	89 e0                	mov    %esp,%eax
    1ddb:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1ddf:	66 89 30             	mov    %si,(%eax)
    1de2:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1de6:	88 50 02             	mov    %dl,0x2(%eax)
    1de9:	6a 32                	push   $0x32
    1deb:	6a 32                	push   $0x32
    1ded:	6a 00                	push   $0x0
    1def:	6a 00                	push   $0x0
    1df1:	53                   	push   %ebx
    1df2:	51                   	push   %ecx
    1df3:	ff 75 94             	pushl  -0x6c(%ebp)
    1df6:	57                   	push   %edi
    1df7:	e8 76 f4 ff ff       	call   1272 <APDcCopy>
    1dfc:	83 c4 30             	add    $0x30,%esp
                    break;
    1dff:	eb 01                	jmp    1e02 <APGridPaint+0x639>
                default: break;
    1e01:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1e02:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1e06:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1e0a:	0f 8e 7a fc ff ff    	jle    1a8a <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e10:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e14:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1e18:	0f 8e 60 fc ff ff    	jle    1a7e <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1e1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1e21:	5b                   	pop    %ebx
    1e22:	5e                   	pop    %esi
    1e23:	5f                   	pop    %edi
    1e24:	5d                   	pop    %ebp
    1e25:	c3                   	ret    

00001e26 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1e26:	55                   	push   %ebp
    1e27:	89 e5                	mov    %esp,%ebp
    1e29:	53                   	push   %ebx
    1e2a:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1e2d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1e34:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1e38:	74 17                	je     1e51 <sprintint+0x2b>
    1e3a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e3e:	79 11                	jns    1e51 <sprintint+0x2b>
        neg = 1;
    1e40:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1e47:	8b 45 10             	mov    0x10(%ebp),%eax
    1e4a:	f7 d8                	neg    %eax
    1e4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e4f:	eb 06                	jmp    1e57 <sprintint+0x31>
    } else {
        x = xx;
    1e51:	8b 45 10             	mov    0x10(%ebp),%eax
    1e54:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1e57:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1e5e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1e61:	8d 41 01             	lea    0x1(%ecx),%eax
    1e64:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1e67:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e6d:	ba 00 00 00 00       	mov    $0x0,%edx
    1e72:	f7 f3                	div    %ebx
    1e74:	89 d0                	mov    %edx,%eax
    1e76:	0f b6 80 48 28 00 00 	movzbl 0x2848(%eax),%eax
    1e7d:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1e81:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e84:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e87:	ba 00 00 00 00       	mov    $0x0,%edx
    1e8c:	f7 f3                	div    %ebx
    1e8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e91:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e95:	75 c7                	jne    1e5e <sprintint+0x38>
    if(neg)
    1e97:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e9b:	74 0e                	je     1eab <sprintint+0x85>
        buf[i++] = '-';
    1e9d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ea0:	8d 50 01             	lea    0x1(%eax),%edx
    1ea3:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1ea6:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1eab:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1eae:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1eb1:	eb 1b                	jmp    1ece <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1eb3:	8b 45 0c             	mov    0xc(%ebp),%eax
    1eb6:	8b 00                	mov    (%eax),%eax
    1eb8:	8d 48 01             	lea    0x1(%eax),%ecx
    1ebb:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ebe:	89 0a                	mov    %ecx,(%edx)
    1ec0:	89 c2                	mov    %eax,%edx
    1ec2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec5:	01 d0                	add    %edx,%eax
    1ec7:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1eca:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1ece:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1ed2:	7f df                	jg     1eb3 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1ed4:	eb 21                	jmp    1ef7 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1ed6:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ed9:	8b 00                	mov    (%eax),%eax
    1edb:	8d 48 01             	lea    0x1(%eax),%ecx
    1ede:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ee1:	89 0a                	mov    %ecx,(%edx)
    1ee3:	89 c2                	mov    %eax,%edx
    1ee5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee8:	01 c2                	add    %eax,%edx
    1eea:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1eed:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ef0:	01 c8                	add    %ecx,%eax
    1ef2:	0f b6 00             	movzbl (%eax),%eax
    1ef5:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1ef7:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1efb:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1eff:	79 d5                	jns    1ed6 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1f01:	90                   	nop
    1f02:	83 c4 20             	add    $0x20,%esp
    1f05:	5b                   	pop    %ebx
    1f06:	5d                   	pop    %ebp
    1f07:	c3                   	ret    

00001f08 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1f08:	55                   	push   %ebp
    1f09:	89 e5                	mov    %esp,%ebp
    1f0b:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1f0e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1f15:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1f1c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1f23:	8d 45 0c             	lea    0xc(%ebp),%eax
    1f26:	83 c0 04             	add    $0x4,%eax
    1f29:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1f2c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1f33:	e9 d9 01 00 00       	jmp    2111 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1f38:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f3b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f3e:	01 d0                	add    %edx,%eax
    1f40:	0f b6 00             	movzbl (%eax),%eax
    1f43:	0f be c0             	movsbl %al,%eax
    1f46:	25 ff 00 00 00       	and    $0xff,%eax
    1f4b:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1f4e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1f52:	75 2c                	jne    1f80 <sprintf+0x78>
            if(c == '%'){
    1f54:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1f58:	75 0c                	jne    1f66 <sprintf+0x5e>
                state = '%';
    1f5a:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1f61:	e9 a7 01 00 00       	jmp    210d <sprintf+0x205>
            } else {
                dst[j++] = c;
    1f66:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f69:	8d 50 01             	lea    0x1(%eax),%edx
    1f6c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f6f:	89 c2                	mov    %eax,%edx
    1f71:	8b 45 08             	mov    0x8(%ebp),%eax
    1f74:	01 d0                	add    %edx,%eax
    1f76:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f79:	88 10                	mov    %dl,(%eax)
    1f7b:	e9 8d 01 00 00       	jmp    210d <sprintf+0x205>
            }
        } else if(state == '%'){
    1f80:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1f84:	0f 85 83 01 00 00    	jne    210d <sprintf+0x205>
            if(c == 'd'){
    1f8a:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1f8e:	75 4c                	jne    1fdc <sprintf+0xd4>
                buf[bi] = '\0';
    1f90:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f93:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f96:	01 d0                	add    %edx,%eax
    1f98:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f9b:	83 ec 0c             	sub    $0xc,%esp
    1f9e:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1fa1:	50                   	push   %eax
    1fa2:	e8 1f e3 ff ff       	call   2c6 <atoi>
    1fa7:	83 c4 10             	add    $0x10,%esp
    1faa:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1fad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1fb4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fb7:	8b 00                	mov    (%eax),%eax
    1fb9:	83 ec 08             	sub    $0x8,%esp
    1fbc:	ff 75 d8             	pushl  -0x28(%ebp)
    1fbf:	6a 01                	push   $0x1
    1fc1:	6a 0a                	push   $0xa
    1fc3:	50                   	push   %eax
    1fc4:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1fc7:	50                   	push   %eax
    1fc8:	ff 75 08             	pushl  0x8(%ebp)
    1fcb:	e8 56 fe ff ff       	call   1e26 <sprintint>
    1fd0:	83 c4 20             	add    $0x20,%esp
                ap++;
    1fd3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1fd7:	e9 2a 01 00 00       	jmp    2106 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1fdc:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1fe0:	74 06                	je     1fe8 <sprintf+0xe0>
    1fe2:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1fe6:	75 4c                	jne    2034 <sprintf+0x12c>
                buf[bi] = '\0';
    1fe8:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1feb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1fee:	01 d0                	add    %edx,%eax
    1ff0:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1ff3:	83 ec 0c             	sub    $0xc,%esp
    1ff6:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1ff9:	50                   	push   %eax
    1ffa:	e8 c7 e2 ff ff       	call   2c6 <atoi>
    1fff:	83 c4 10             	add    $0x10,%esp
    2002:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2005:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    200c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    200f:	8b 00                	mov    (%eax),%eax
    2011:	83 ec 08             	sub    $0x8,%esp
    2014:	ff 75 dc             	pushl  -0x24(%ebp)
    2017:	6a 00                	push   $0x0
    2019:	6a 10                	push   $0x10
    201b:	50                   	push   %eax
    201c:	8d 45 c8             	lea    -0x38(%ebp),%eax
    201f:	50                   	push   %eax
    2020:	ff 75 08             	pushl  0x8(%ebp)
    2023:	e8 fe fd ff ff       	call   1e26 <sprintint>
    2028:	83 c4 20             	add    $0x20,%esp
                ap++;
    202b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    202f:	e9 d2 00 00 00       	jmp    2106 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2034:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2038:	75 46                	jne    2080 <sprintf+0x178>
                s = (char*)*ap;
    203a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    203d:	8b 00                	mov    (%eax),%eax
    203f:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2042:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2046:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    204a:	75 25                	jne    2071 <sprintf+0x169>
                    s = "(null)";
    204c:	c7 45 f4 18 23 00 00 	movl   $0x2318,-0xc(%ebp)
                while(*s != 0){
    2053:	eb 1c                	jmp    2071 <sprintf+0x169>
                    dst[j++] = *s;
    2055:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2058:	8d 50 01             	lea    0x1(%eax),%edx
    205b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    205e:	89 c2                	mov    %eax,%edx
    2060:	8b 45 08             	mov    0x8(%ebp),%eax
    2063:	01 c2                	add    %eax,%edx
    2065:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2068:	0f b6 00             	movzbl (%eax),%eax
    206b:	88 02                	mov    %al,(%edx)
                    s++;
    206d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2071:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2074:	0f b6 00             	movzbl (%eax),%eax
    2077:	84 c0                	test   %al,%al
    2079:	75 da                	jne    2055 <sprintf+0x14d>
    207b:	e9 86 00 00 00       	jmp    2106 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2080:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2084:	75 1d                	jne    20a3 <sprintf+0x19b>
                dst[j++] = *ap;
    2086:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2089:	8d 50 01             	lea    0x1(%eax),%edx
    208c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    208f:	89 c2                	mov    %eax,%edx
    2091:	8b 45 08             	mov    0x8(%ebp),%eax
    2094:	01 c2                	add    %eax,%edx
    2096:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2099:	8b 00                	mov    (%eax),%eax
    209b:	88 02                	mov    %al,(%edx)
                ap++;
    209d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    20a1:	eb 63                	jmp    2106 <sprintf+0x1fe>
            } else if(c == '%'){
    20a3:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    20a7:	75 17                	jne    20c0 <sprintf+0x1b8>
                dst[j++] = c;
    20a9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20ac:	8d 50 01             	lea    0x1(%eax),%edx
    20af:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20b2:	89 c2                	mov    %eax,%edx
    20b4:	8b 45 08             	mov    0x8(%ebp),%eax
    20b7:	01 d0                	add    %edx,%eax
    20b9:	8b 55 e0             	mov    -0x20(%ebp),%edx
    20bc:	88 10                	mov    %dl,(%eax)
    20be:	eb 46                	jmp    2106 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    20c0:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    20c4:	7e 18                	jle    20de <sprintf+0x1d6>
    20c6:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    20ca:	7f 12                	jg     20de <sprintf+0x1d6>
            {
                buf[bi++] = c;
    20cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20cf:	8d 50 01             	lea    0x1(%eax),%edx
    20d2:	89 55 f0             	mov    %edx,-0x10(%ebp)
    20d5:	8b 55 e0             	mov    -0x20(%ebp),%edx
    20d8:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    20dc:	eb 2f                	jmp    210d <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    20de:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20e1:	8d 50 01             	lea    0x1(%eax),%edx
    20e4:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20e7:	89 c2                	mov    %eax,%edx
    20e9:	8b 45 08             	mov    0x8(%ebp),%eax
    20ec:	01 d0                	add    %edx,%eax
    20ee:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    20f1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20f4:	8d 50 01             	lea    0x1(%eax),%edx
    20f7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20fa:	89 c2                	mov    %eax,%edx
    20fc:	8b 45 08             	mov    0x8(%ebp),%eax
    20ff:	01 d0                	add    %edx,%eax
    2101:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2104:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2106:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    210d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2111:	8b 55 0c             	mov    0xc(%ebp),%edx
    2114:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2117:	01 d0                	add    %edx,%eax
    2119:	0f b6 00             	movzbl (%eax),%eax
    211c:	84 c0                	test   %al,%al
    211e:	0f 85 14 fe ff ff    	jne    1f38 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2124:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2127:	8d 50 01             	lea    0x1(%eax),%edx
    212a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    212d:	89 c2                	mov    %eax,%edx
    212f:	8b 45 08             	mov    0x8(%ebp),%eax
    2132:	01 d0                	add    %edx,%eax
    2134:	c6 00 00             	movb   $0x0,(%eax)
}
    2137:	90                   	nop
    2138:	c9                   	leave  
    2139:	c3                   	ret    
