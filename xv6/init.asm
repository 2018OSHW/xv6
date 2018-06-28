
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
      16:	68 ab 21 00 00       	push   $0x21ab
      1b:	e8 78 03 00 00       	call   398 <open>
      20:	83 c4 10             	add    $0x10,%esp
      23:	85 c0                	test   %eax,%eax
      25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
      27:	83 ec 04             	sub    $0x4,%esp
      2a:	6a 01                	push   $0x1
      2c:	6a 01                	push   $0x1
      2e:	68 ab 21 00 00       	push   $0x21ab
      33:	e8 68 03 00 00       	call   3a0 <mknod>
      38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
      3b:	83 ec 08             	sub    $0x8,%esp
      3e:	6a 02                	push   $0x2
      40:	68 ab 21 00 00       	push   $0x21ab
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
      6a:	68 b3 21 00 00       	push   $0x21b3
      6f:	6a 01                	push   $0x1
      71:	e8 89 04 00 00       	call   4ff <printf>
      76:	83 c4 10             	add    $0x10,%esp
    pid = fork();
      79:	e8 d2 02 00 00       	call   350 <fork>
      7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
      81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      85:	79 17                	jns    9e <main+0x9e>
      printf(1, "init: fork failed\n");
      87:	83 ec 08             	sub    $0x8,%esp
      8a:	68 cd 21 00 00       	push   $0x21cd
      8f:	6a 01                	push   $0x1
      91:	e8 69 04 00 00       	call   4ff <printf>
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
      a7:	68 b8 28 00 00       	push   $0x28b8
      ac:	68 e0 21 00 00       	push   $0x21e0
      b1:	e8 da 02 00 00       	call   390 <exec>
      b6:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec desktop failed\n");
      b9:	83 ec 08             	sub    $0x8,%esp
      bc:	68 ea 21 00 00       	push   $0x21ea
      c1:	6a 01                	push   $0x1
      c3:	e8 37 04 00 00       	call   4ff <printf>
      c8:	83 c4 10             	add    $0x10,%esp
      exit();
      cb:	e8 88 02 00 00       	call   358 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
      d0:	83 ec 08             	sub    $0x8,%esp
      d3:	68 05 22 00 00       	push   $0x2205
      d8:	6a 01                	push   $0x1
      da:	e8 20 04 00 00       	call   4ff <printf>
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

00000420 <changePosition>:
SYSCALL(changePosition)
     420:	b8 1b 00 00 00       	mov    $0x1b,%eax
     425:	cd 40                	int    $0x40
     427:	c3                   	ret    

00000428 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     428:	55                   	push   %ebp
     429:	89 e5                	mov    %esp,%ebp
     42b:	83 ec 18             	sub    $0x18,%esp
     42e:	8b 45 0c             	mov    0xc(%ebp),%eax
     431:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     434:	83 ec 04             	sub    $0x4,%esp
     437:	6a 01                	push   $0x1
     439:	8d 45 f4             	lea    -0xc(%ebp),%eax
     43c:	50                   	push   %eax
     43d:	ff 75 08             	pushl  0x8(%ebp)
     440:	e8 33 ff ff ff       	call   378 <write>
     445:	83 c4 10             	add    $0x10,%esp
}
     448:	90                   	nop
     449:	c9                   	leave  
     44a:	c3                   	ret    

0000044b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     44b:	55                   	push   %ebp
     44c:	89 e5                	mov    %esp,%ebp
     44e:	53                   	push   %ebx
     44f:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     452:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     459:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     45d:	74 17                	je     476 <printint+0x2b>
     45f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     463:	79 11                	jns    476 <printint+0x2b>
    neg = 1;
     465:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     46c:	8b 45 0c             	mov    0xc(%ebp),%eax
     46f:	f7 d8                	neg    %eax
     471:	89 45 ec             	mov    %eax,-0x14(%ebp)
     474:	eb 06                	jmp    47c <printint+0x31>
  } else {
    x = xx;
     476:	8b 45 0c             	mov    0xc(%ebp),%eax
     479:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     47c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     483:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     486:	8d 41 01             	lea    0x1(%ecx),%eax
     489:	89 45 f4             	mov    %eax,-0xc(%ebp)
     48c:	8b 5d 10             	mov    0x10(%ebp),%ebx
     48f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     492:	ba 00 00 00 00       	mov    $0x0,%edx
     497:	f7 f3                	div    %ebx
     499:	89 d0                	mov    %edx,%eax
     49b:	0f b6 80 c0 28 00 00 	movzbl 0x28c0(%eax),%eax
     4a2:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     4a6:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4ac:	ba 00 00 00 00       	mov    $0x0,%edx
     4b1:	f7 f3                	div    %ebx
     4b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4b6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4ba:	75 c7                	jne    483 <printint+0x38>
  if(neg)
     4bc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4c0:	74 2d                	je     4ef <printint+0xa4>
    buf[i++] = '-';
     4c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4c5:	8d 50 01             	lea    0x1(%eax),%edx
     4c8:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4cb:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     4d0:	eb 1d                	jmp    4ef <printint+0xa4>
    putc(fd, buf[i]);
     4d2:	8d 55 dc             	lea    -0x24(%ebp),%edx
     4d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4d8:	01 d0                	add    %edx,%eax
     4da:	0f b6 00             	movzbl (%eax),%eax
     4dd:	0f be c0             	movsbl %al,%eax
     4e0:	83 ec 08             	sub    $0x8,%esp
     4e3:	50                   	push   %eax
     4e4:	ff 75 08             	pushl  0x8(%ebp)
     4e7:	e8 3c ff ff ff       	call   428 <putc>
     4ec:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     4ef:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     4f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4f7:	79 d9                	jns    4d2 <printint+0x87>
    putc(fd, buf[i]);
}
     4f9:	90                   	nop
     4fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4fd:	c9                   	leave  
     4fe:	c3                   	ret    

000004ff <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     4ff:	55                   	push   %ebp
     500:	89 e5                	mov    %esp,%ebp
     502:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     505:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     50c:	8d 45 0c             	lea    0xc(%ebp),%eax
     50f:	83 c0 04             	add    $0x4,%eax
     512:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     515:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     51c:	e9 59 01 00 00       	jmp    67a <printf+0x17b>
    c = fmt[i] & 0xff;
     521:	8b 55 0c             	mov    0xc(%ebp),%edx
     524:	8b 45 f0             	mov    -0x10(%ebp),%eax
     527:	01 d0                	add    %edx,%eax
     529:	0f b6 00             	movzbl (%eax),%eax
     52c:	0f be c0             	movsbl %al,%eax
     52f:	25 ff 00 00 00       	and    $0xff,%eax
     534:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     537:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     53b:	75 2c                	jne    569 <printf+0x6a>
      if(c == '%'){
     53d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     541:	75 0c                	jne    54f <printf+0x50>
        state = '%';
     543:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     54a:	e9 27 01 00 00       	jmp    676 <printf+0x177>
      } else {
        putc(fd, c);
     54f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     552:	0f be c0             	movsbl %al,%eax
     555:	83 ec 08             	sub    $0x8,%esp
     558:	50                   	push   %eax
     559:	ff 75 08             	pushl  0x8(%ebp)
     55c:	e8 c7 fe ff ff       	call   428 <putc>
     561:	83 c4 10             	add    $0x10,%esp
     564:	e9 0d 01 00 00       	jmp    676 <printf+0x177>
      }
    } else if(state == '%'){
     569:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     56d:	0f 85 03 01 00 00    	jne    676 <printf+0x177>
      if(c == 'd'){
     573:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     577:	75 1e                	jne    597 <printf+0x98>
        printint(fd, *ap, 10, 1);
     579:	8b 45 e8             	mov    -0x18(%ebp),%eax
     57c:	8b 00                	mov    (%eax),%eax
     57e:	6a 01                	push   $0x1
     580:	6a 0a                	push   $0xa
     582:	50                   	push   %eax
     583:	ff 75 08             	pushl  0x8(%ebp)
     586:	e8 c0 fe ff ff       	call   44b <printint>
     58b:	83 c4 10             	add    $0x10,%esp
        ap++;
     58e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     592:	e9 d8 00 00 00       	jmp    66f <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     597:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     59b:	74 06                	je     5a3 <printf+0xa4>
     59d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5a1:	75 1e                	jne    5c1 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     5a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5a6:	8b 00                	mov    (%eax),%eax
     5a8:	6a 00                	push   $0x0
     5aa:	6a 10                	push   $0x10
     5ac:	50                   	push   %eax
     5ad:	ff 75 08             	pushl  0x8(%ebp)
     5b0:	e8 96 fe ff ff       	call   44b <printint>
     5b5:	83 c4 10             	add    $0x10,%esp
        ap++;
     5b8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5bc:	e9 ae 00 00 00       	jmp    66f <printf+0x170>
      } else if(c == 's'){
     5c1:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     5c5:	75 43                	jne    60a <printf+0x10b>
        s = (char*)*ap;
     5c7:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5ca:	8b 00                	mov    (%eax),%eax
     5cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     5cf:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     5d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5d7:	75 25                	jne    5fe <printf+0xff>
          s = "(null)";
     5d9:	c7 45 f4 0e 22 00 00 	movl   $0x220e,-0xc(%ebp)
        while(*s != 0){
     5e0:	eb 1c                	jmp    5fe <printf+0xff>
          putc(fd, *s);
     5e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5e5:	0f b6 00             	movzbl (%eax),%eax
     5e8:	0f be c0             	movsbl %al,%eax
     5eb:	83 ec 08             	sub    $0x8,%esp
     5ee:	50                   	push   %eax
     5ef:	ff 75 08             	pushl  0x8(%ebp)
     5f2:	e8 31 fe ff ff       	call   428 <putc>
     5f7:	83 c4 10             	add    $0x10,%esp
          s++;
     5fa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     5fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     601:	0f b6 00             	movzbl (%eax),%eax
     604:	84 c0                	test   %al,%al
     606:	75 da                	jne    5e2 <printf+0xe3>
     608:	eb 65                	jmp    66f <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     60a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     60e:	75 1d                	jne    62d <printf+0x12e>
        putc(fd, *ap);
     610:	8b 45 e8             	mov    -0x18(%ebp),%eax
     613:	8b 00                	mov    (%eax),%eax
     615:	0f be c0             	movsbl %al,%eax
     618:	83 ec 08             	sub    $0x8,%esp
     61b:	50                   	push   %eax
     61c:	ff 75 08             	pushl  0x8(%ebp)
     61f:	e8 04 fe ff ff       	call   428 <putc>
     624:	83 c4 10             	add    $0x10,%esp
        ap++;
     627:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     62b:	eb 42                	jmp    66f <printf+0x170>
      } else if(c == '%'){
     62d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     631:	75 17                	jne    64a <printf+0x14b>
        putc(fd, c);
     633:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     636:	0f be c0             	movsbl %al,%eax
     639:	83 ec 08             	sub    $0x8,%esp
     63c:	50                   	push   %eax
     63d:	ff 75 08             	pushl  0x8(%ebp)
     640:	e8 e3 fd ff ff       	call   428 <putc>
     645:	83 c4 10             	add    $0x10,%esp
     648:	eb 25                	jmp    66f <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     64a:	83 ec 08             	sub    $0x8,%esp
     64d:	6a 25                	push   $0x25
     64f:	ff 75 08             	pushl  0x8(%ebp)
     652:	e8 d1 fd ff ff       	call   428 <putc>
     657:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     65a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     65d:	0f be c0             	movsbl %al,%eax
     660:	83 ec 08             	sub    $0x8,%esp
     663:	50                   	push   %eax
     664:	ff 75 08             	pushl  0x8(%ebp)
     667:	e8 bc fd ff ff       	call   428 <putc>
     66c:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     66f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     676:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     67a:	8b 55 0c             	mov    0xc(%ebp),%edx
     67d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     680:	01 d0                	add    %edx,%eax
     682:	0f b6 00             	movzbl (%eax),%eax
     685:	84 c0                	test   %al,%al
     687:	0f 85 94 fe ff ff    	jne    521 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     68d:	90                   	nop
     68e:	c9                   	leave  
     68f:	c3                   	ret    

00000690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     696:	8b 45 08             	mov    0x8(%ebp),%eax
     699:	83 e8 08             	sub    $0x8,%eax
     69c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     69f:	a1 f4 28 00 00       	mov    0x28f4,%eax
     6a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6a7:	eb 24                	jmp    6cd <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ac:	8b 00                	mov    (%eax),%eax
     6ae:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6b1:	77 12                	ja     6c5 <free+0x35>
     6b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6b9:	77 24                	ja     6df <free+0x4f>
     6bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6be:	8b 00                	mov    (%eax),%eax
     6c0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6c3:	77 1a                	ja     6df <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c8:	8b 00                	mov    (%eax),%eax
     6ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6d0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6d3:	76 d4                	jbe    6a9 <free+0x19>
     6d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d8:	8b 00                	mov    (%eax),%eax
     6da:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6dd:	76 ca                	jbe    6a9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     6df:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6e2:	8b 40 04             	mov    0x4(%eax),%eax
     6e5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ef:	01 c2                	add    %eax,%edx
     6f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f4:	8b 00                	mov    (%eax),%eax
     6f6:	39 c2                	cmp    %eax,%edx
     6f8:	75 24                	jne    71e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     6fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6fd:	8b 50 04             	mov    0x4(%eax),%edx
     700:	8b 45 fc             	mov    -0x4(%ebp),%eax
     703:	8b 00                	mov    (%eax),%eax
     705:	8b 40 04             	mov    0x4(%eax),%eax
     708:	01 c2                	add    %eax,%edx
     70a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     70d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     710:	8b 45 fc             	mov    -0x4(%ebp),%eax
     713:	8b 00                	mov    (%eax),%eax
     715:	8b 10                	mov    (%eax),%edx
     717:	8b 45 f8             	mov    -0x8(%ebp),%eax
     71a:	89 10                	mov    %edx,(%eax)
     71c:	eb 0a                	jmp    728 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     71e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     721:	8b 10                	mov    (%eax),%edx
     723:	8b 45 f8             	mov    -0x8(%ebp),%eax
     726:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     728:	8b 45 fc             	mov    -0x4(%ebp),%eax
     72b:	8b 40 04             	mov    0x4(%eax),%eax
     72e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     735:	8b 45 fc             	mov    -0x4(%ebp),%eax
     738:	01 d0                	add    %edx,%eax
     73a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     73d:	75 20                	jne    75f <free+0xcf>
    p->s.size += bp->s.size;
     73f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     742:	8b 50 04             	mov    0x4(%eax),%edx
     745:	8b 45 f8             	mov    -0x8(%ebp),%eax
     748:	8b 40 04             	mov    0x4(%eax),%eax
     74b:	01 c2                	add    %eax,%edx
     74d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     750:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     753:	8b 45 f8             	mov    -0x8(%ebp),%eax
     756:	8b 10                	mov    (%eax),%edx
     758:	8b 45 fc             	mov    -0x4(%ebp),%eax
     75b:	89 10                	mov    %edx,(%eax)
     75d:	eb 08                	jmp    767 <free+0xd7>
  } else
    p->s.ptr = bp;
     75f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     762:	8b 55 f8             	mov    -0x8(%ebp),%edx
     765:	89 10                	mov    %edx,(%eax)
  freep = p;
     767:	8b 45 fc             	mov    -0x4(%ebp),%eax
     76a:	a3 f4 28 00 00       	mov    %eax,0x28f4
}
     76f:	90                   	nop
     770:	c9                   	leave  
     771:	c3                   	ret    

00000772 <morecore>:

static Header*
morecore(uint nu)
{
     772:	55                   	push   %ebp
     773:	89 e5                	mov    %esp,%ebp
     775:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     778:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     77f:	77 07                	ja     788 <morecore+0x16>
    nu = 4096;
     781:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     788:	8b 45 08             	mov    0x8(%ebp),%eax
     78b:	c1 e0 03             	shl    $0x3,%eax
     78e:	83 ec 0c             	sub    $0xc,%esp
     791:	50                   	push   %eax
     792:	e8 49 fc ff ff       	call   3e0 <sbrk>
     797:	83 c4 10             	add    $0x10,%esp
     79a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     79d:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7a1:	75 07                	jne    7aa <morecore+0x38>
    return 0;
     7a3:	b8 00 00 00 00       	mov    $0x0,%eax
     7a8:	eb 26                	jmp    7d0 <morecore+0x5e>
  hp = (Header*)p;
     7aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7b3:	8b 55 08             	mov    0x8(%ebp),%edx
     7b6:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     7b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7bc:	83 c0 08             	add    $0x8,%eax
     7bf:	83 ec 0c             	sub    $0xc,%esp
     7c2:	50                   	push   %eax
     7c3:	e8 c8 fe ff ff       	call   690 <free>
     7c8:	83 c4 10             	add    $0x10,%esp
  return freep;
     7cb:	a1 f4 28 00 00       	mov    0x28f4,%eax
}
     7d0:	c9                   	leave  
     7d1:	c3                   	ret    

000007d2 <malloc>:

void*
malloc(uint nbytes)
{
     7d2:	55                   	push   %ebp
     7d3:	89 e5                	mov    %esp,%ebp
     7d5:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     7d8:	8b 45 08             	mov    0x8(%ebp),%eax
     7db:	83 c0 07             	add    $0x7,%eax
     7de:	c1 e8 03             	shr    $0x3,%eax
     7e1:	83 c0 01             	add    $0x1,%eax
     7e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     7e7:	a1 f4 28 00 00       	mov    0x28f4,%eax
     7ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7ef:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7f3:	75 23                	jne    818 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     7f5:	c7 45 f0 ec 28 00 00 	movl   $0x28ec,-0x10(%ebp)
     7fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7ff:	a3 f4 28 00 00       	mov    %eax,0x28f4
     804:	a1 f4 28 00 00       	mov    0x28f4,%eax
     809:	a3 ec 28 00 00       	mov    %eax,0x28ec
    base.s.size = 0;
     80e:	c7 05 f0 28 00 00 00 	movl   $0x0,0x28f0
     815:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     818:	8b 45 f0             	mov    -0x10(%ebp),%eax
     81b:	8b 00                	mov    (%eax),%eax
     81d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     820:	8b 45 f4             	mov    -0xc(%ebp),%eax
     823:	8b 40 04             	mov    0x4(%eax),%eax
     826:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     829:	72 4d                	jb     878 <malloc+0xa6>
      if(p->s.size == nunits)
     82b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     82e:	8b 40 04             	mov    0x4(%eax),%eax
     831:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     834:	75 0c                	jne    842 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     836:	8b 45 f4             	mov    -0xc(%ebp),%eax
     839:	8b 10                	mov    (%eax),%edx
     83b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     83e:	89 10                	mov    %edx,(%eax)
     840:	eb 26                	jmp    868 <malloc+0x96>
      else {
        p->s.size -= nunits;
     842:	8b 45 f4             	mov    -0xc(%ebp),%eax
     845:	8b 40 04             	mov    0x4(%eax),%eax
     848:	2b 45 ec             	sub    -0x14(%ebp),%eax
     84b:	89 c2                	mov    %eax,%edx
     84d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     850:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     853:	8b 45 f4             	mov    -0xc(%ebp),%eax
     856:	8b 40 04             	mov    0x4(%eax),%eax
     859:	c1 e0 03             	shl    $0x3,%eax
     85c:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     85f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     862:	8b 55 ec             	mov    -0x14(%ebp),%edx
     865:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     868:	8b 45 f0             	mov    -0x10(%ebp),%eax
     86b:	a3 f4 28 00 00       	mov    %eax,0x28f4
      return (void*)(p + 1);
     870:	8b 45 f4             	mov    -0xc(%ebp),%eax
     873:	83 c0 08             	add    $0x8,%eax
     876:	eb 3b                	jmp    8b3 <malloc+0xe1>
    }
    if(p == freep)
     878:	a1 f4 28 00 00       	mov    0x28f4,%eax
     87d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     880:	75 1e                	jne    8a0 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     882:	83 ec 0c             	sub    $0xc,%esp
     885:	ff 75 ec             	pushl  -0x14(%ebp)
     888:	e8 e5 fe ff ff       	call   772 <morecore>
     88d:	83 c4 10             	add    $0x10,%esp
     890:	89 45 f4             	mov    %eax,-0xc(%ebp)
     893:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     897:	75 07                	jne    8a0 <malloc+0xce>
        return 0;
     899:	b8 00 00 00 00       	mov    $0x0,%eax
     89e:	eb 13                	jmp    8b3 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8a9:	8b 00                	mov    (%eax),%eax
     8ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     8ae:	e9 6d ff ff ff       	jmp    820 <malloc+0x4e>
}
     8b3:	c9                   	leave  
     8b4:	c3                   	ret    

000008b5 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     8b5:	55                   	push   %ebp
     8b6:	89 e5                	mov    %esp,%ebp
     8b8:	83 ec 1c             	sub    $0x1c,%esp
     8bb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     8be:	8b 55 10             	mov    0x10(%ebp),%edx
     8c1:	8b 45 14             	mov    0x14(%ebp),%eax
     8c4:	88 4d ec             	mov    %cl,-0x14(%ebp)
     8c7:	88 55 e8             	mov    %dl,-0x18(%ebp)
     8ca:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     8cd:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     8d1:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     8d4:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     8d8:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     8db:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     8df:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     8e2:	8b 45 08             	mov    0x8(%ebp),%eax
     8e5:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     8e9:	66 89 10             	mov    %dx,(%eax)
     8ec:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     8f0:	88 50 02             	mov    %dl,0x2(%eax)
}
     8f3:	8b 45 08             	mov    0x8(%ebp),%eax
     8f6:	c9                   	leave  
     8f7:	c2 04 00             	ret    $0x4

000008fa <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     8fa:	55                   	push   %ebp
     8fb:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     8fd:	8b 45 08             	mov    0x8(%ebp),%eax
     900:	2b 45 10             	sub    0x10(%ebp),%eax
     903:	89 c2                	mov    %eax,%edx
     905:	8b 45 08             	mov    0x8(%ebp),%eax
     908:	2b 45 10             	sub    0x10(%ebp),%eax
     90b:	0f af d0             	imul   %eax,%edx
     90e:	8b 45 0c             	mov    0xc(%ebp),%eax
     911:	2b 45 14             	sub    0x14(%ebp),%eax
     914:	89 c1                	mov    %eax,%ecx
     916:	8b 45 0c             	mov    0xc(%ebp),%eax
     919:	2b 45 14             	sub    0x14(%ebp),%eax
     91c:	0f af c1             	imul   %ecx,%eax
     91f:	01 d0                	add    %edx,%eax
}
     921:	5d                   	pop    %ebp
     922:	c3                   	ret    

00000923 <abs_int>:

static inline int abs_int(int x)
{
     923:	55                   	push   %ebp
     924:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     926:	8b 45 08             	mov    0x8(%ebp),%eax
     929:	99                   	cltd   
     92a:	89 d0                	mov    %edx,%eax
     92c:	33 45 08             	xor    0x8(%ebp),%eax
     92f:	29 d0                	sub    %edx,%eax
}
     931:	5d                   	pop    %ebp
     932:	c3                   	ret    

00000933 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     933:	55                   	push   %ebp
     934:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     936:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     93a:	79 07                	jns    943 <APGetIndex+0x10>
        return X_SMALLER;
     93c:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     941:	eb 40                	jmp    983 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     943:	8b 45 08             	mov    0x8(%ebp),%eax
     946:	8b 00                	mov    (%eax),%eax
     948:	3b 45 0c             	cmp    0xc(%ebp),%eax
     94b:	7f 07                	jg     954 <APGetIndex+0x21>
        return X_BIGGER;
     94d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     952:	eb 2f                	jmp    983 <APGetIndex+0x50>
    if (y < 0)
     954:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     958:	79 07                	jns    961 <APGetIndex+0x2e>
        return Y_SMALLER;
     95a:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     95f:	eb 22                	jmp    983 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     961:	8b 45 08             	mov    0x8(%ebp),%eax
     964:	8b 40 04             	mov    0x4(%eax),%eax
     967:	3b 45 10             	cmp    0x10(%ebp),%eax
     96a:	7f 07                	jg     973 <APGetIndex+0x40>
        return Y_BIGGER;
     96c:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     971:	eb 10                	jmp    983 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     973:	8b 45 08             	mov    0x8(%ebp),%eax
     976:	8b 00                	mov    (%eax),%eax
     978:	0f af 45 10          	imul   0x10(%ebp),%eax
     97c:	89 c2                	mov    %eax,%edx
     97e:	8b 45 0c             	mov    0xc(%ebp),%eax
     981:	01 d0                	add    %edx,%eax
}
     983:	5d                   	pop    %ebp
     984:	c3                   	ret    

00000985 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     985:	55                   	push   %ebp
     986:	89 e5                	mov    %esp,%ebp
     988:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     98b:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     992:	8b 45 cc             	mov    -0x34(%ebp),%eax
     995:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     998:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     99f:	83 ec 08             	sub    $0x8,%esp
     9a2:	6a 00                	push   $0x0
     9a4:	ff 75 0c             	pushl  0xc(%ebp)
     9a7:	e8 ec f9 ff ff       	call   398 <open>
     9ac:	83 c4 10             	add    $0x10,%esp
     9af:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     9b2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     9b6:	79 2e                	jns    9e6 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     9b8:	83 ec 04             	sub    $0x4,%esp
     9bb:	ff 75 0c             	pushl  0xc(%ebp)
     9be:	68 15 22 00 00       	push   $0x2215
     9c3:	6a 01                	push   $0x1
     9c5:	e8 35 fb ff ff       	call   4ff <printf>
     9ca:	83 c4 10             	add    $0x10,%esp
        return bmp;
     9cd:	8b 45 08             	mov    0x8(%ebp),%eax
     9d0:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9d3:	89 10                	mov    %edx,(%eax)
     9d5:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9d8:	89 50 04             	mov    %edx,0x4(%eax)
     9db:	8b 55 d0             	mov    -0x30(%ebp),%edx
     9de:	89 50 08             	mov    %edx,0x8(%eax)
     9e1:	e9 d2 01 00 00       	jmp    bb8 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     9e6:	83 ec 04             	sub    $0x4,%esp
     9e9:	6a 0e                	push   $0xe
     9eb:	8d 45 ba             	lea    -0x46(%ebp),%eax
     9ee:	50                   	push   %eax
     9ef:	ff 75 ec             	pushl  -0x14(%ebp)
     9f2:	e8 79 f9 ff ff       	call   370 <read>
     9f7:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     9fa:	83 ec 04             	sub    $0x4,%esp
     9fd:	6a 28                	push   $0x28
     9ff:	8d 45 92             	lea    -0x6e(%ebp),%eax
     a02:	50                   	push   %eax
     a03:	ff 75 ec             	pushl  -0x14(%ebp)
     a06:	e8 65 f9 ff ff       	call   370 <read>
     a0b:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     a0e:	8b 45 96             	mov    -0x6a(%ebp),%eax
     a11:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     a14:	8b 45 9a             	mov    -0x66(%ebp),%eax
     a17:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     a1a:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a1d:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a20:	0f af d0             	imul   %eax,%edx
     a23:	89 d0                	mov    %edx,%eax
     a25:	01 c0                	add    %eax,%eax
     a27:	01 d0                	add    %edx,%eax
     a29:	83 ec 0c             	sub    $0xc,%esp
     a2c:	50                   	push   %eax
     a2d:	e8 a0 fd ff ff       	call   7d2 <malloc>
     a32:	83 c4 10             	add    $0x10,%esp
     a35:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     a38:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a3c:	0f b7 c0             	movzwl %ax,%eax
     a3f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     a42:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a45:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a48:	0f af c2             	imul   %edx,%eax
     a4b:	83 c0 1f             	add    $0x1f,%eax
     a4e:	c1 e8 05             	shr    $0x5,%eax
     a51:	c1 e0 02             	shl    $0x2,%eax
     a54:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     a57:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a5a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a5d:	0f af c2             	imul   %edx,%eax
     a60:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     a63:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a66:	83 ec 0c             	sub    $0xc,%esp
     a69:	50                   	push   %eax
     a6a:	e8 63 fd ff ff       	call   7d2 <malloc>
     a6f:	83 c4 10             	add    $0x10,%esp
     a72:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a75:	83 ec 04             	sub    $0x4,%esp
     a78:	ff 75 e0             	pushl  -0x20(%ebp)
     a7b:	ff 75 dc             	pushl  -0x24(%ebp)
     a7e:	ff 75 ec             	pushl  -0x14(%ebp)
     a81:	e8 ea f8 ff ff       	call   370 <read>
     a86:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a89:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a8d:	66 c1 e8 03          	shr    $0x3,%ax
     a91:	0f b7 c0             	movzwl %ax,%eax
     a94:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a97:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a9e:	e9 e5 00 00 00       	jmp    b88 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     aa3:	8b 55 cc             	mov    -0x34(%ebp),%edx
     aa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa9:	29 c2                	sub    %eax,%edx
     aab:	89 d0                	mov    %edx,%eax
     aad:	8d 50 ff             	lea    -0x1(%eax),%edx
     ab0:	8b 45 c8             	mov    -0x38(%ebp),%eax
     ab3:	0f af c2             	imul   %edx,%eax
     ab6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     ab9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ac0:	e9 b1 00 00 00       	jmp    b76 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     ac5:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ac8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     acb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ace:	01 c8                	add    %ecx,%eax
     ad0:	89 c1                	mov    %eax,%ecx
     ad2:	89 c8                	mov    %ecx,%eax
     ad4:	01 c0                	add    %eax,%eax
     ad6:	01 c8                	add    %ecx,%eax
     ad8:	01 c2                	add    %eax,%edx
     ada:	8b 45 f4             	mov    -0xc(%ebp),%eax
     add:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ae1:	89 c1                	mov    %eax,%ecx
     ae3:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ae6:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     aea:	01 c1                	add    %eax,%ecx
     aec:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aef:	01 c8                	add    %ecx,%eax
     af1:	8d 48 ff             	lea    -0x1(%eax),%ecx
     af4:	8b 45 dc             	mov    -0x24(%ebp),%eax
     af7:	01 c8                	add    %ecx,%eax
     af9:	0f b6 00             	movzbl (%eax),%eax
     afc:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     aff:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b02:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b05:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b08:	01 c8                	add    %ecx,%eax
     b0a:	89 c1                	mov    %eax,%ecx
     b0c:	89 c8                	mov    %ecx,%eax
     b0e:	01 c0                	add    %eax,%eax
     b10:	01 c8                	add    %ecx,%eax
     b12:	01 c2                	add    %eax,%edx
     b14:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b17:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b1b:	89 c1                	mov    %eax,%ecx
     b1d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b20:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b24:	01 c1                	add    %eax,%ecx
     b26:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b29:	01 c8                	add    %ecx,%eax
     b2b:	8d 48 fe             	lea    -0x2(%eax),%ecx
     b2e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b31:	01 c8                	add    %ecx,%eax
     b33:	0f b6 00             	movzbl (%eax),%eax
     b36:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     b39:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b3c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b42:	01 c8                	add    %ecx,%eax
     b44:	89 c1                	mov    %eax,%ecx
     b46:	89 c8                	mov    %ecx,%eax
     b48:	01 c0                	add    %eax,%eax
     b4a:	01 c8                	add    %ecx,%eax
     b4c:	01 c2                	add    %eax,%edx
     b4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b51:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b55:	89 c1                	mov    %eax,%ecx
     b57:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b5a:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b5e:	01 c1                	add    %eax,%ecx
     b60:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b63:	01 c8                	add    %ecx,%eax
     b65:	8d 48 fd             	lea    -0x3(%eax),%ecx
     b68:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b6b:	01 c8                	add    %ecx,%eax
     b6d:	0f b6 00             	movzbl (%eax),%eax
     b70:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     b72:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b76:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b79:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b7c:	39 c2                	cmp    %eax,%edx
     b7e:	0f 87 41 ff ff ff    	ja     ac5 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b84:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b88:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b8e:	39 c2                	cmp    %eax,%edx
     b90:	0f 87 0d ff ff ff    	ja     aa3 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b96:	83 ec 0c             	sub    $0xc,%esp
     b99:	ff 75 ec             	pushl  -0x14(%ebp)
     b9c:	e8 df f7 ff ff       	call   380 <close>
     ba1:	83 c4 10             	add    $0x10,%esp
    return bmp;
     ba4:	8b 45 08             	mov    0x8(%ebp),%eax
     ba7:	8b 55 c8             	mov    -0x38(%ebp),%edx
     baa:	89 10                	mov    %edx,(%eax)
     bac:	8b 55 cc             	mov    -0x34(%ebp),%edx
     baf:	89 50 04             	mov    %edx,0x4(%eax)
     bb2:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bb5:	89 50 08             	mov    %edx,0x8(%eax)
}
     bb8:	8b 45 08             	mov    0x8(%ebp),%eax
     bbb:	c9                   	leave  
     bbc:	c2 04 00             	ret    $0x4

00000bbf <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     bbf:	55                   	push   %ebp
     bc0:	89 e5                	mov    %esp,%ebp
     bc2:	53                   	push   %ebx
     bc3:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     bc6:	83 ec 0c             	sub    $0xc,%esp
     bc9:	6a 1c                	push   $0x1c
     bcb:	e8 02 fc ff ff       	call   7d2 <malloc>
     bd0:	83 c4 10             	add    $0x10,%esp
     bd3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     bd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd9:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     be0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     be3:	8d 45 d8             	lea    -0x28(%ebp),%eax
     be6:	6a 0c                	push   $0xc
     be8:	6a 0c                	push   $0xc
     bea:	6a 0c                	push   $0xc
     bec:	50                   	push   %eax
     bed:	e8 c3 fc ff ff       	call   8b5 <RGB>
     bf2:	83 c4 0c             	add    $0xc,%esp
     bf5:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     bf9:	66 89 43 13          	mov    %ax,0x13(%ebx)
     bfd:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     c01:	88 43 15             	mov    %al,0x15(%ebx)
     c04:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c07:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c0a:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     c0e:	66 89 48 10          	mov    %cx,0x10(%eax)
     c12:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     c16:	88 50 12             	mov    %dl,0x12(%eax)
     c19:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c1f:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     c23:	66 89 48 08          	mov    %cx,0x8(%eax)
     c27:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     c2b:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     c2e:	8b 45 08             	mov    0x8(%ebp),%eax
     c31:	89 c2                	mov    %eax,%edx
     c33:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c36:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     c38:	8b 45 0c             	mov    0xc(%ebp),%eax
     c3b:	89 c2                	mov    %eax,%edx
     c3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c40:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     c43:	8b 55 10             	mov    0x10(%ebp),%edx
     c46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c49:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     c4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c4f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c52:	c9                   	leave  
     c53:	c3                   	ret    

00000c54 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     c54:	55                   	push   %ebp
     c55:	89 e5                	mov    %esp,%ebp
     c57:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     c5a:	8b 45 0c             	mov    0xc(%ebp),%eax
     c5d:	8b 50 08             	mov    0x8(%eax),%edx
     c60:	89 55 f8             	mov    %edx,-0x8(%ebp)
     c63:	8b 40 0c             	mov    0xc(%eax),%eax
     c66:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     c69:	8b 45 0c             	mov    0xc(%ebp),%eax
     c6c:	8b 55 10             	mov    0x10(%ebp),%edx
     c6f:	89 50 08             	mov    %edx,0x8(%eax)
     c72:	8b 55 14             	mov    0x14(%ebp),%edx
     c75:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c78:	8b 45 08             	mov    0x8(%ebp),%eax
     c7b:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c7e:	89 10                	mov    %edx,(%eax)
     c80:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c83:	89 50 04             	mov    %edx,0x4(%eax)
}
     c86:	8b 45 08             	mov    0x8(%ebp),%eax
     c89:	c9                   	leave  
     c8a:	c2 04 00             	ret    $0x4

00000c8d <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c8d:	55                   	push   %ebp
     c8e:	89 e5                	mov    %esp,%ebp
     c90:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c93:	8b 45 0c             	mov    0xc(%ebp),%eax
     c96:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c9a:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c9e:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     ca2:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     ca5:	8b 45 0c             	mov    0xc(%ebp),%eax
     ca8:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     cac:	66 89 50 10          	mov    %dx,0x10(%eax)
     cb0:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     cb4:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     cb7:	8b 45 08             	mov    0x8(%ebp),%eax
     cba:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     cbe:	66 89 10             	mov    %dx,(%eax)
     cc1:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     cc5:	88 50 02             	mov    %dl,0x2(%eax)
}
     cc8:	8b 45 08             	mov    0x8(%ebp),%eax
     ccb:	c9                   	leave  
     ccc:	c2 04 00             	ret    $0x4

00000ccf <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     ccf:	55                   	push   %ebp
     cd0:	89 e5                	mov    %esp,%ebp
     cd2:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     cd5:	8b 45 08             	mov    0x8(%ebp),%eax
     cd8:	8b 40 0c             	mov    0xc(%eax),%eax
     cdb:	89 c2                	mov    %eax,%edx
     cdd:	c1 ea 1f             	shr    $0x1f,%edx
     ce0:	01 d0                	add    %edx,%eax
     ce2:	d1 f8                	sar    %eax
     ce4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     ce7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cea:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     cee:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     cf1:	8b 45 10             	mov    0x10(%ebp),%eax
     cf4:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cf7:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     cfa:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     cfe:	0f 89 98 00 00 00    	jns    d9c <APDrawPoint+0xcd>
        i = 0;
     d04:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     d0b:	e9 8c 00 00 00       	jmp    d9c <APDrawPoint+0xcd>
    {
        j = x - off;
     d10:	8b 45 0c             	mov    0xc(%ebp),%eax
     d13:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d16:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d19:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d1d:	79 69                	jns    d88 <APDrawPoint+0xb9>
            j = 0;
     d1f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d26:	eb 60                	jmp    d88 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d28:	ff 75 fc             	pushl  -0x4(%ebp)
     d2b:	ff 75 f8             	pushl  -0x8(%ebp)
     d2e:	ff 75 08             	pushl  0x8(%ebp)
     d31:	e8 fd fb ff ff       	call   933 <APGetIndex>
     d36:	83 c4 0c             	add    $0xc,%esp
     d39:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d3c:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d40:	74 55                	je     d97 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d42:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d46:	74 67                	je     daf <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d48:	ff 75 10             	pushl  0x10(%ebp)
     d4b:	ff 75 0c             	pushl  0xc(%ebp)
     d4e:	ff 75 fc             	pushl  -0x4(%ebp)
     d51:	ff 75 f8             	pushl  -0x8(%ebp)
     d54:	e8 a1 fb ff ff       	call   8fa <distance_2>
     d59:	83 c4 10             	add    $0x10,%esp
     d5c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d5f:	7f 23                	jg     d84 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d61:	8b 45 08             	mov    0x8(%ebp),%eax
     d64:	8b 48 18             	mov    0x18(%eax),%ecx
     d67:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d6a:	89 d0                	mov    %edx,%eax
     d6c:	01 c0                	add    %eax,%eax
     d6e:	01 d0                	add    %edx,%eax
     d70:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d73:	8b 45 08             	mov    0x8(%ebp),%eax
     d76:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d7a:	66 89 0a             	mov    %cx,(%edx)
     d7d:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d81:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d84:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d88:	8b 55 0c             	mov    0xc(%ebp),%edx
     d8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d8e:	01 d0                	add    %edx,%eax
     d90:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d93:	7d 93                	jge    d28 <APDrawPoint+0x59>
     d95:	eb 01                	jmp    d98 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d97:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d98:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d9c:	8b 55 10             	mov    0x10(%ebp),%edx
     d9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da2:	01 d0                	add    %edx,%eax
     da4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     da7:	0f 8d 63 ff ff ff    	jge    d10 <APDrawPoint+0x41>
     dad:	eb 01                	jmp    db0 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     daf:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     db0:	c9                   	leave  
     db1:	c3                   	ret    

00000db2 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     db2:	55                   	push   %ebp
     db3:	89 e5                	mov    %esp,%ebp
     db5:	53                   	push   %ebx
     db6:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     db9:	8b 45 0c             	mov    0xc(%ebp),%eax
     dbc:	3b 45 14             	cmp    0x14(%ebp),%eax
     dbf:	0f 85 80 00 00 00    	jne    e45 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     dc5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     dc9:	0f 88 9d 02 00 00    	js     106c <APDrawLine+0x2ba>
     dcf:	8b 45 08             	mov    0x8(%ebp),%eax
     dd2:	8b 00                	mov    (%eax),%eax
     dd4:	3b 45 0c             	cmp    0xc(%ebp),%eax
     dd7:	0f 8e 8f 02 00 00    	jle    106c <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     ddd:	8b 45 10             	mov    0x10(%ebp),%eax
     de0:	3b 45 18             	cmp    0x18(%ebp),%eax
     de3:	7e 12                	jle    df7 <APDrawLine+0x45>
        {
            int tmp = y2;
     de5:	8b 45 18             	mov    0x18(%ebp),%eax
     de8:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     deb:	8b 45 10             	mov    0x10(%ebp),%eax
     dee:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     df1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     df4:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     df7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dfb:	79 07                	jns    e04 <APDrawLine+0x52>
     dfd:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e04:	8b 45 08             	mov    0x8(%ebp),%eax
     e07:	8b 40 04             	mov    0x4(%eax),%eax
     e0a:	3b 45 18             	cmp    0x18(%ebp),%eax
     e0d:	7d 0c                	jge    e1b <APDrawLine+0x69>
     e0f:	8b 45 08             	mov    0x8(%ebp),%eax
     e12:	8b 40 04             	mov    0x4(%eax),%eax
     e15:	83 e8 01             	sub    $0x1,%eax
     e18:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e1b:	8b 45 10             	mov    0x10(%ebp),%eax
     e1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e21:	eb 15                	jmp    e38 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e23:	ff 75 f4             	pushl  -0xc(%ebp)
     e26:	ff 75 0c             	pushl  0xc(%ebp)
     e29:	ff 75 08             	pushl  0x8(%ebp)
     e2c:	e8 9e fe ff ff       	call   ccf <APDrawPoint>
     e31:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e34:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e38:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e3b:	3b 45 18             	cmp    0x18(%ebp),%eax
     e3e:	7e e3                	jle    e23 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e40:	e9 2b 02 00 00       	jmp    1070 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e45:	8b 45 10             	mov    0x10(%ebp),%eax
     e48:	3b 45 18             	cmp    0x18(%ebp),%eax
     e4b:	75 7f                	jne    ecc <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e4d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e51:	0f 88 18 02 00 00    	js     106f <APDrawLine+0x2bd>
     e57:	8b 45 08             	mov    0x8(%ebp),%eax
     e5a:	8b 40 04             	mov    0x4(%eax),%eax
     e5d:	3b 45 10             	cmp    0x10(%ebp),%eax
     e60:	0f 8e 09 02 00 00    	jle    106f <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e66:	8b 45 0c             	mov    0xc(%ebp),%eax
     e69:	3b 45 14             	cmp    0x14(%ebp),%eax
     e6c:	7e 12                	jle    e80 <APDrawLine+0xce>
        {
            int tmp = x2;
     e6e:	8b 45 14             	mov    0x14(%ebp),%eax
     e71:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e74:	8b 45 0c             	mov    0xc(%ebp),%eax
     e77:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e7a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e7d:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e80:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e84:	79 07                	jns    e8d <APDrawLine+0xdb>
     e86:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e8d:	8b 45 08             	mov    0x8(%ebp),%eax
     e90:	8b 00                	mov    (%eax),%eax
     e92:	3b 45 14             	cmp    0x14(%ebp),%eax
     e95:	7d 0b                	jge    ea2 <APDrawLine+0xf0>
     e97:	8b 45 08             	mov    0x8(%ebp),%eax
     e9a:	8b 00                	mov    (%eax),%eax
     e9c:	83 e8 01             	sub    $0x1,%eax
     e9f:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     ea2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ea8:	eb 15                	jmp    ebf <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     eaa:	ff 75 10             	pushl  0x10(%ebp)
     ead:	ff 75 f0             	pushl  -0x10(%ebp)
     eb0:	ff 75 08             	pushl  0x8(%ebp)
     eb3:	e8 17 fe ff ff       	call   ccf <APDrawPoint>
     eb8:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     ebb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ebf:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ec2:	3b 45 14             	cmp    0x14(%ebp),%eax
     ec5:	7e e3                	jle    eaa <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     ec7:	e9 a4 01 00 00       	jmp    1070 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     ecc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     ed3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     eda:	8b 45 0c             	mov    0xc(%ebp),%eax
     edd:	2b 45 14             	sub    0x14(%ebp),%eax
     ee0:	50                   	push   %eax
     ee1:	e8 3d fa ff ff       	call   923 <abs_int>
     ee6:	83 c4 04             	add    $0x4,%esp
     ee9:	89 c3                	mov    %eax,%ebx
     eeb:	8b 45 10             	mov    0x10(%ebp),%eax
     eee:	2b 45 18             	sub    0x18(%ebp),%eax
     ef1:	50                   	push   %eax
     ef2:	e8 2c fa ff ff       	call   923 <abs_int>
     ef7:	83 c4 04             	add    $0x4,%esp
     efa:	39 c3                	cmp    %eax,%ebx
     efc:	0f 8e b5 00 00 00    	jle    fb7 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f02:	8b 45 10             	mov    0x10(%ebp),%eax
     f05:	2b 45 18             	sub    0x18(%ebp),%eax
     f08:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f0b:	db 45 b0             	fildl  -0x50(%ebp)
     f0e:	8b 45 0c             	mov    0xc(%ebp),%eax
     f11:	2b 45 14             	sub    0x14(%ebp),%eax
     f14:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f17:	db 45 b0             	fildl  -0x50(%ebp)
     f1a:	de f9                	fdivrp %st,%st(1)
     f1c:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f1f:	8b 45 14             	mov    0x14(%ebp),%eax
     f22:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f25:	7e 0e                	jle    f35 <APDrawLine+0x183>
        {
            s = x1;
     f27:	8b 45 0c             	mov    0xc(%ebp),%eax
     f2a:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f2d:	8b 45 14             	mov    0x14(%ebp),%eax
     f30:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f33:	eb 0c                	jmp    f41 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f35:	8b 45 14             	mov    0x14(%ebp),%eax
     f38:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f3b:	8b 45 0c             	mov    0xc(%ebp),%eax
     f3e:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f41:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f45:	79 07                	jns    f4e <APDrawLine+0x19c>
     f47:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f4e:	8b 45 08             	mov    0x8(%ebp),%eax
     f51:	8b 00                	mov    (%eax),%eax
     f53:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f56:	7f 0b                	jg     f63 <APDrawLine+0x1b1>
     f58:	8b 45 08             	mov    0x8(%ebp),%eax
     f5b:	8b 00                	mov    (%eax),%eax
     f5d:	83 e8 01             	sub    $0x1,%eax
     f60:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f63:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f66:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f69:	eb 3f                	jmp    faa <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f6b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f6e:	2b 45 0c             	sub    0xc(%ebp),%eax
     f71:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f74:	db 45 b0             	fildl  -0x50(%ebp)
     f77:	dc 4d d0             	fmull  -0x30(%ebp)
     f7a:	db 45 10             	fildl  0x10(%ebp)
     f7d:	de c1                	faddp  %st,%st(1)
     f7f:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f82:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f86:	b4 0c                	mov    $0xc,%ah
     f88:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f8c:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f8f:	db 5d cc             	fistpl -0x34(%ebp)
     f92:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f95:	ff 75 cc             	pushl  -0x34(%ebp)
     f98:	ff 75 e4             	pushl  -0x1c(%ebp)
     f9b:	ff 75 08             	pushl  0x8(%ebp)
     f9e:	e8 2c fd ff ff       	call   ccf <APDrawPoint>
     fa3:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     fa6:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     faa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fad:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fb0:	7e b9                	jle    f6b <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     fb2:	e9 b9 00 00 00       	jmp    1070 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     fb7:	8b 45 0c             	mov    0xc(%ebp),%eax
     fba:	2b 45 14             	sub    0x14(%ebp),%eax
     fbd:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fc0:	db 45 b0             	fildl  -0x50(%ebp)
     fc3:	8b 45 10             	mov    0x10(%ebp),%eax
     fc6:	2b 45 18             	sub    0x18(%ebp),%eax
     fc9:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fcc:	db 45 b0             	fildl  -0x50(%ebp)
     fcf:	de f9                	fdivrp %st,%st(1)
     fd1:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     fd4:	8b 45 10             	mov    0x10(%ebp),%eax
     fd7:	3b 45 18             	cmp    0x18(%ebp),%eax
     fda:	7e 0e                	jle    fea <APDrawLine+0x238>
    {
        s = y2;
     fdc:	8b 45 18             	mov    0x18(%ebp),%eax
     fdf:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     fe2:	8b 45 10             	mov    0x10(%ebp),%eax
     fe5:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fe8:	eb 0c                	jmp    ff6 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     fea:	8b 45 10             	mov    0x10(%ebp),%eax
     fed:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     ff0:	8b 45 18             	mov    0x18(%ebp),%eax
     ff3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     ff6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ffa:	79 07                	jns    1003 <APDrawLine+0x251>
     ffc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1003:	8b 45 08             	mov    0x8(%ebp),%eax
    1006:	8b 40 04             	mov    0x4(%eax),%eax
    1009:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    100c:	7f 0c                	jg     101a <APDrawLine+0x268>
    100e:	8b 45 08             	mov    0x8(%ebp),%eax
    1011:	8b 40 04             	mov    0x4(%eax),%eax
    1014:	83 e8 01             	sub    $0x1,%eax
    1017:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    101a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    101d:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1020:	eb 3f                	jmp    1061 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1022:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1025:	2b 45 10             	sub    0x10(%ebp),%eax
    1028:	89 45 b0             	mov    %eax,-0x50(%ebp)
    102b:	db 45 b0             	fildl  -0x50(%ebp)
    102e:	dc 4d c0             	fmull  -0x40(%ebp)
    1031:	db 45 0c             	fildl  0xc(%ebp)
    1034:	de c1                	faddp  %st,%st(1)
    1036:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1039:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    103d:	b4 0c                	mov    $0xc,%ah
    103f:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1043:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1046:	db 5d bc             	fistpl -0x44(%ebp)
    1049:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    104c:	ff 75 e0             	pushl  -0x20(%ebp)
    104f:	ff 75 bc             	pushl  -0x44(%ebp)
    1052:	ff 75 08             	pushl  0x8(%ebp)
    1055:	e8 75 fc ff ff       	call   ccf <APDrawPoint>
    105a:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    105d:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1061:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1064:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1067:	7e b9                	jle    1022 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1069:	90                   	nop
    106a:	eb 04                	jmp    1070 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    106c:	90                   	nop
    106d:	eb 01                	jmp    1070 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    106f:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1070:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1073:	c9                   	leave  
    1074:	c3                   	ret    

00001075 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1075:	55                   	push   %ebp
    1076:	89 e5                	mov    %esp,%ebp
    1078:	53                   	push   %ebx
    1079:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    107c:	8b 55 10             	mov    0x10(%ebp),%edx
    107f:	8b 45 18             	mov    0x18(%ebp),%eax
    1082:	01 d0                	add    %edx,%eax
    1084:	83 e8 01             	sub    $0x1,%eax
    1087:	83 ec 04             	sub    $0x4,%esp
    108a:	50                   	push   %eax
    108b:	ff 75 0c             	pushl  0xc(%ebp)
    108e:	ff 75 10             	pushl  0x10(%ebp)
    1091:	ff 75 0c             	pushl  0xc(%ebp)
    1094:	ff 75 08             	pushl  0x8(%ebp)
    1097:	e8 16 fd ff ff       	call   db2 <APDrawLine>
    109c:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    109f:	8b 55 0c             	mov    0xc(%ebp),%edx
    10a2:	8b 45 14             	mov    0x14(%ebp),%eax
    10a5:	01 d0                	add    %edx,%eax
    10a7:	83 e8 01             	sub    $0x1,%eax
    10aa:	83 ec 04             	sub    $0x4,%esp
    10ad:	ff 75 10             	pushl  0x10(%ebp)
    10b0:	50                   	push   %eax
    10b1:	ff 75 10             	pushl  0x10(%ebp)
    10b4:	ff 75 0c             	pushl  0xc(%ebp)
    10b7:	ff 75 08             	pushl  0x8(%ebp)
    10ba:	e8 f3 fc ff ff       	call   db2 <APDrawLine>
    10bf:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    10c2:	8b 55 10             	mov    0x10(%ebp),%edx
    10c5:	8b 45 18             	mov    0x18(%ebp),%eax
    10c8:	01 d0                	add    %edx,%eax
    10ca:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10cd:	8b 55 0c             	mov    0xc(%ebp),%edx
    10d0:	8b 45 14             	mov    0x14(%ebp),%eax
    10d3:	01 d0                	add    %edx,%eax
    10d5:	8d 50 ff             	lea    -0x1(%eax),%edx
    10d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10db:	8b 45 14             	mov    0x14(%ebp),%eax
    10de:	01 d8                	add    %ebx,%eax
    10e0:	83 e8 01             	sub    $0x1,%eax
    10e3:	83 ec 04             	sub    $0x4,%esp
    10e6:	51                   	push   %ecx
    10e7:	52                   	push   %edx
    10e8:	ff 75 10             	pushl  0x10(%ebp)
    10eb:	50                   	push   %eax
    10ec:	ff 75 08             	pushl  0x8(%ebp)
    10ef:	e8 be fc ff ff       	call   db2 <APDrawLine>
    10f4:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10f7:	8b 55 10             	mov    0x10(%ebp),%edx
    10fa:	8b 45 18             	mov    0x18(%ebp),%eax
    10fd:	01 d0                	add    %edx,%eax
    10ff:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1102:	8b 55 0c             	mov    0xc(%ebp),%edx
    1105:	8b 45 14             	mov    0x14(%ebp),%eax
    1108:	01 d0                	add    %edx,%eax
    110a:	8d 50 ff             	lea    -0x1(%eax),%edx
    110d:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1110:	8b 45 18             	mov    0x18(%ebp),%eax
    1113:	01 d8                	add    %ebx,%eax
    1115:	83 e8 01             	sub    $0x1,%eax
    1118:	83 ec 04             	sub    $0x4,%esp
    111b:	51                   	push   %ecx
    111c:	52                   	push   %edx
    111d:	50                   	push   %eax
    111e:	ff 75 0c             	pushl  0xc(%ebp)
    1121:	ff 75 08             	pushl  0x8(%ebp)
    1124:	e8 89 fc ff ff       	call   db2 <APDrawLine>
    1129:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    112c:	8b 55 0c             	mov    0xc(%ebp),%edx
    112f:	8b 45 14             	mov    0x14(%ebp),%eax
    1132:	01 d0                	add    %edx,%eax
    1134:	8d 50 ff             	lea    -0x1(%eax),%edx
    1137:	8b 45 08             	mov    0x8(%ebp),%eax
    113a:	8b 40 0c             	mov    0xc(%eax),%eax
    113d:	89 c1                	mov    %eax,%ecx
    113f:	c1 e9 1f             	shr    $0x1f,%ecx
    1142:	01 c8                	add    %ecx,%eax
    1144:	d1 f8                	sar    %eax
    1146:	29 c2                	sub    %eax,%edx
    1148:	89 d0                	mov    %edx,%eax
    114a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    114d:	8b 55 10             	mov    0x10(%ebp),%edx
    1150:	8b 45 18             	mov    0x18(%ebp),%eax
    1153:	01 d0                	add    %edx,%eax
    1155:	8d 50 ff             	lea    -0x1(%eax),%edx
    1158:	8b 45 08             	mov    0x8(%ebp),%eax
    115b:	8b 40 0c             	mov    0xc(%eax),%eax
    115e:	89 c1                	mov    %eax,%ecx
    1160:	c1 e9 1f             	shr    $0x1f,%ecx
    1163:	01 c8                	add    %ecx,%eax
    1165:	d1 f8                	sar    %eax
    1167:	29 c2                	sub    %eax,%edx
    1169:	89 d0                	mov    %edx,%eax
    116b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    116e:	8b 45 08             	mov    0x8(%ebp),%eax
    1171:	8b 40 0c             	mov    0xc(%eax),%eax
    1174:	89 c2                	mov    %eax,%edx
    1176:	c1 ea 1f             	shr    $0x1f,%edx
    1179:	01 d0                	add    %edx,%eax
    117b:	d1 f8                	sar    %eax
    117d:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1180:	8b 45 08             	mov    0x8(%ebp),%eax
    1183:	8b 40 0c             	mov    0xc(%eax),%eax
    1186:	89 c2                	mov    %eax,%edx
    1188:	c1 ea 1f             	shr    $0x1f,%edx
    118b:	01 d0                	add    %edx,%eax
    118d:	d1 f8                	sar    %eax
    118f:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1192:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1196:	0f 88 d8 00 00 00    	js     1274 <APDrawRect+0x1ff>
    119c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11a0:	0f 88 ce 00 00 00    	js     1274 <APDrawRect+0x1ff>
    11a6:	8b 45 08             	mov    0x8(%ebp),%eax
    11a9:	8b 00                	mov    (%eax),%eax
    11ab:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11ae:	0f 8e c0 00 00 00    	jle    1274 <APDrawRect+0x1ff>
    11b4:	8b 45 08             	mov    0x8(%ebp),%eax
    11b7:	8b 40 04             	mov    0x4(%eax),%eax
    11ba:	3b 45 10             	cmp    0x10(%ebp),%eax
    11bd:	0f 8e b1 00 00 00    	jle    1274 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    11c3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11c7:	79 07                	jns    11d0 <APDrawRect+0x15b>
    11c9:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    11d0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    11d4:	79 07                	jns    11dd <APDrawRect+0x168>
    11d6:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    11dd:	8b 45 08             	mov    0x8(%ebp),%eax
    11e0:	8b 00                	mov    (%eax),%eax
    11e2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11e5:	7f 0b                	jg     11f2 <APDrawRect+0x17d>
    11e7:	8b 45 08             	mov    0x8(%ebp),%eax
    11ea:	8b 00                	mov    (%eax),%eax
    11ec:	83 e8 01             	sub    $0x1,%eax
    11ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    11f2:	8b 45 08             	mov    0x8(%ebp),%eax
    11f5:	8b 40 04             	mov    0x4(%eax),%eax
    11f8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11fb:	7f 0c                	jg     1209 <APDrawRect+0x194>
    11fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1200:	8b 40 04             	mov    0x4(%eax),%eax
    1203:	83 e8 01             	sub    $0x1,%eax
    1206:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1209:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1210:	8b 45 0c             	mov    0xc(%ebp),%eax
    1213:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1216:	eb 52                	jmp    126a <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1218:	8b 45 10             	mov    0x10(%ebp),%eax
    121b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    121e:	eb 3e                	jmp    125e <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1220:	83 ec 04             	sub    $0x4,%esp
    1223:	ff 75 e8             	pushl  -0x18(%ebp)
    1226:	ff 75 ec             	pushl  -0x14(%ebp)
    1229:	ff 75 08             	pushl  0x8(%ebp)
    122c:	e8 02 f7 ff ff       	call   933 <APGetIndex>
    1231:	83 c4 10             	add    $0x10,%esp
    1234:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1237:	8b 45 08             	mov    0x8(%ebp),%eax
    123a:	8b 48 18             	mov    0x18(%eax),%ecx
    123d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1240:	89 d0                	mov    %edx,%eax
    1242:	01 c0                	add    %eax,%eax
    1244:	01 d0                	add    %edx,%eax
    1246:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1249:	8b 45 08             	mov    0x8(%ebp),%eax
    124c:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1250:	66 89 0a             	mov    %cx,(%edx)
    1253:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1257:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    125a:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    125e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1261:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1264:	7e ba                	jle    1220 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1266:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    126a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    126d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1270:	7e a6                	jle    1218 <APDrawRect+0x1a3>
    1272:	eb 01                	jmp    1275 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1274:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1275:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1278:	c9                   	leave  
    1279:	c3                   	ret    

0000127a <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    127a:	55                   	push   %ebp
    127b:	89 e5                	mov    %esp,%ebp
    127d:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1280:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1284:	0f 88 8e 01 00 00    	js     1418 <APDcCopy+0x19e>
    128a:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    128e:	0f 88 84 01 00 00    	js     1418 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1294:	8b 55 0c             	mov    0xc(%ebp),%edx
    1297:	8b 45 20             	mov    0x20(%ebp),%eax
    129a:	01 d0                	add    %edx,%eax
    129c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    129f:	8b 55 10             	mov    0x10(%ebp),%edx
    12a2:	8b 45 24             	mov    0x24(%ebp),%eax
    12a5:	01 d0                	add    %edx,%eax
    12a7:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    12aa:	8b 55 18             	mov    0x18(%ebp),%edx
    12ad:	8b 45 20             	mov    0x20(%ebp),%eax
    12b0:	01 d0                	add    %edx,%eax
    12b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12b5:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12b8:	8b 45 24             	mov    0x24(%ebp),%eax
    12bb:	01 d0                	add    %edx,%eax
    12bd:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    12c0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    12c4:	0f 88 51 01 00 00    	js     141b <APDcCopy+0x1a1>
    12ca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12ce:	0f 88 47 01 00 00    	js     141b <APDcCopy+0x1a1>
    12d4:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    12d8:	0f 88 3d 01 00 00    	js     141b <APDcCopy+0x1a1>
    12de:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    12e2:	0f 88 33 01 00 00    	js     141b <APDcCopy+0x1a1>
    12e8:	8b 45 14             	mov    0x14(%ebp),%eax
    12eb:	8b 00                	mov    (%eax),%eax
    12ed:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    12f0:	0f 8c 25 01 00 00    	jl     141b <APDcCopy+0x1a1>
    12f6:	8b 45 14             	mov    0x14(%ebp),%eax
    12f9:	8b 40 04             	mov    0x4(%eax),%eax
    12fc:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12ff:	0f 8c 16 01 00 00    	jl     141b <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1305:	8b 45 08             	mov    0x8(%ebp),%eax
    1308:	8b 00                	mov    (%eax),%eax
    130a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    130d:	7f 0b                	jg     131a <APDcCopy+0xa0>
    130f:	8b 45 08             	mov    0x8(%ebp),%eax
    1312:	8b 00                	mov    (%eax),%eax
    1314:	83 e8 01             	sub    $0x1,%eax
    1317:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    131a:	8b 45 08             	mov    0x8(%ebp),%eax
    131d:	8b 40 04             	mov    0x4(%eax),%eax
    1320:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1323:	7f 0c                	jg     1331 <APDcCopy+0xb7>
    1325:	8b 45 08             	mov    0x8(%ebp),%eax
    1328:	8b 40 04             	mov    0x4(%eax),%eax
    132b:	83 e8 01             	sub    $0x1,%eax
    132e:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1331:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1338:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    133f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1346:	e9 bc 00 00 00       	jmp    1407 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    134b:	8b 45 08             	mov    0x8(%ebp),%eax
    134e:	8b 00                	mov    (%eax),%eax
    1350:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1353:	8b 55 10             	mov    0x10(%ebp),%edx
    1356:	01 ca                	add    %ecx,%edx
    1358:	0f af d0             	imul   %eax,%edx
    135b:	8b 45 0c             	mov    0xc(%ebp),%eax
    135e:	01 d0                	add    %edx,%eax
    1360:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1363:	8b 45 14             	mov    0x14(%ebp),%eax
    1366:	8b 00                	mov    (%eax),%eax
    1368:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    136b:	8b 55 1c             	mov    0x1c(%ebp),%edx
    136e:	01 ca                	add    %ecx,%edx
    1370:	0f af d0             	imul   %eax,%edx
    1373:	8b 45 18             	mov    0x18(%ebp),%eax
    1376:	01 d0                	add    %edx,%eax
    1378:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    137b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1382:	eb 74                	jmp    13f8 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1384:	8b 45 14             	mov    0x14(%ebp),%eax
    1387:	8b 50 18             	mov    0x18(%eax),%edx
    138a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    138d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1390:	01 c8                	add    %ecx,%eax
    1392:	89 c1                	mov    %eax,%ecx
    1394:	89 c8                	mov    %ecx,%eax
    1396:	01 c0                	add    %eax,%eax
    1398:	01 c8                	add    %ecx,%eax
    139a:	01 d0                	add    %edx,%eax
    139c:	0f b7 10             	movzwl (%eax),%edx
    139f:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    13a3:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    13a7:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    13aa:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13ae:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    13b2:	38 c2                	cmp    %al,%dl
    13b4:	75 18                	jne    13ce <APDcCopy+0x154>
    13b6:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    13ba:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    13be:	38 c2                	cmp    %al,%dl
    13c0:	75 0c                	jne    13ce <APDcCopy+0x154>
    13c2:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    13c6:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    13ca:	38 c2                	cmp    %al,%dl
    13cc:	74 26                	je     13f4 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    13ce:	8b 45 08             	mov    0x8(%ebp),%eax
    13d1:	8b 50 18             	mov    0x18(%eax),%edx
    13d4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    13d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13da:	01 c8                	add    %ecx,%eax
    13dc:	89 c1                	mov    %eax,%ecx
    13de:	89 c8                	mov    %ecx,%eax
    13e0:	01 c0                	add    %eax,%eax
    13e2:	01 c8                	add    %ecx,%eax
    13e4:	01 d0                	add    %edx,%eax
    13e6:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    13ea:	66 89 10             	mov    %dx,(%eax)
    13ed:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13f1:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    13f4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    13f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13fb:	2b 45 0c             	sub    0xc(%ebp),%eax
    13fe:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1401:	7d 81                	jge    1384 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1403:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1407:	8b 45 f8             	mov    -0x8(%ebp),%eax
    140a:	2b 45 10             	sub    0x10(%ebp),%eax
    140d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1410:	0f 8d 35 ff ff ff    	jge    134b <APDcCopy+0xd1>
    1416:	eb 04                	jmp    141c <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1418:	90                   	nop
    1419:	eb 01                	jmp    141c <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    141b:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    141c:	c9                   	leave  
    141d:	c3                   	ret    

0000141e <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    141e:	55                   	push   %ebp
    141f:	89 e5                	mov    %esp,%ebp
    1421:	83 ec 1c             	sub    $0x1c,%esp
    1424:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1427:	8b 55 10             	mov    0x10(%ebp),%edx
    142a:	8b 45 14             	mov    0x14(%ebp),%eax
    142d:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1430:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1433:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1436:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    143a:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    143d:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1441:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1444:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1448:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    144b:	8b 45 08             	mov    0x8(%ebp),%eax
    144e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1452:	66 89 10             	mov    %dx,(%eax)
    1455:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1459:	88 50 02             	mov    %dl,0x2(%eax)
}
    145c:	8b 45 08             	mov    0x8(%ebp),%eax
    145f:	c9                   	leave  
    1460:	c2 04 00             	ret    $0x4

00001463 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1463:	55                   	push   %ebp
    1464:	89 e5                	mov    %esp,%ebp
    1466:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1469:	8b 45 08             	mov    0x8(%ebp),%eax
    146c:	8b 00                	mov    (%eax),%eax
    146e:	83 ec 08             	sub    $0x8,%esp
    1471:	8d 55 0c             	lea    0xc(%ebp),%edx
    1474:	52                   	push   %edx
    1475:	50                   	push   %eax
    1476:	e8 8d ef ff ff       	call   408 <sendMessage>
    147b:	83 c4 10             	add    $0x10,%esp
}
    147e:	90                   	nop
    147f:	c9                   	leave  
    1480:	c3                   	ret    

00001481 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1481:	55                   	push   %ebp
    1482:	89 e5                	mov    %esp,%ebp
    1484:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1487:	83 ec 0c             	sub    $0xc,%esp
    148a:	68 90 00 00 00       	push   $0x90
    148f:	e8 3e f3 ff ff       	call   7d2 <malloc>
    1494:	83 c4 10             	add    $0x10,%esp
    1497:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    149a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    149e:	75 15                	jne    14b5 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    14a0:	83 ec 04             	sub    $0x4,%esp
    14a3:	ff 75 08             	pushl  0x8(%ebp)
    14a6:	68 28 22 00 00       	push   $0x2228
    14ab:	6a 01                	push   $0x1
    14ad:	e8 4d f0 ff ff       	call   4ff <printf>
    14b2:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    14b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b8:	83 c0 7c             	add    $0x7c,%eax
    14bb:	83 ec 08             	sub    $0x8,%esp
    14be:	ff 75 08             	pushl  0x8(%ebp)
    14c1:	50                   	push   %eax
    14c2:	e8 60 ec ff ff       	call   127 <strcpy>
    14c7:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    14ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cd:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    14d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d7:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e1:	8b 40 34             	mov    0x34(%eax),%eax
    14e4:	89 c2                	mov    %eax,%edx
    14e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e9:	8b 40 38             	mov    0x38(%eax),%eax
    14ec:	0f af d0             	imul   %eax,%edx
    14ef:	89 d0                	mov    %edx,%eax
    14f1:	01 c0                	add    %eax,%eax
    14f3:	01 d0                	add    %edx,%eax
    14f5:	83 ec 0c             	sub    $0xc,%esp
    14f8:	50                   	push   %eax
    14f9:	e8 d4 f2 ff ff       	call   7d2 <malloc>
    14fe:	83 c4 10             	add    $0x10,%esp
    1501:	89 c2                	mov    %eax,%edx
    1503:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1506:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1509:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150c:	8b 40 4c             	mov    0x4c(%eax),%eax
    150f:	85 c0                	test   %eax,%eax
    1511:	75 15                	jne    1528 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1513:	83 ec 04             	sub    $0x4,%esp
    1516:	ff 75 08             	pushl  0x8(%ebp)
    1519:	68 48 22 00 00       	push   $0x2248
    151e:	6a 01                	push   $0x1
    1520:	e8 da ef ff ff       	call   4ff <printf>
    1525:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1528:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152b:	8b 40 34             	mov    0x34(%eax),%eax
    152e:	89 c2                	mov    %eax,%edx
    1530:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1533:	8b 40 38             	mov    0x38(%eax),%eax
    1536:	0f af d0             	imul   %eax,%edx
    1539:	89 d0                	mov    %edx,%eax
    153b:	01 c0                	add    %eax,%eax
    153d:	01 c2                	add    %eax,%edx
    153f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1542:	8b 40 4c             	mov    0x4c(%eax),%eax
    1545:	83 ec 04             	sub    $0x4,%esp
    1548:	52                   	push   %edx
    1549:	68 ff ff ff 00       	push   $0xffffff
    154e:	50                   	push   %eax
    154f:	e8 69 ec ff ff       	call   1bd <memset>
    1554:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1557:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155a:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    1561:	e8 72 ee ff ff       	call   3d8 <getpid>
    1566:	89 c2                	mov    %eax,%edx
    1568:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156b:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    156e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1571:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1578:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157b:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1582:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1585:	8b 40 50             	mov    0x50(%eax),%eax
    1588:	89 c2                	mov    %eax,%edx
    158a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158d:	8b 40 54             	mov    0x54(%eax),%eax
    1590:	0f af d0             	imul   %eax,%edx
    1593:	89 d0                	mov    %edx,%eax
    1595:	01 c0                	add    %eax,%eax
    1597:	01 d0                	add    %edx,%eax
    1599:	83 ec 0c             	sub    $0xc,%esp
    159c:	50                   	push   %eax
    159d:	e8 30 f2 ff ff       	call   7d2 <malloc>
    15a2:	83 c4 10             	add    $0x10,%esp
    15a5:	89 c2                	mov    %eax,%edx
    15a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15aa:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    15ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b0:	8b 40 68             	mov    0x68(%eax),%eax
    15b3:	85 c0                	test   %eax,%eax
    15b5:	75 15                	jne    15cc <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    15b7:	83 ec 04             	sub    $0x4,%esp
    15ba:	ff 75 08             	pushl  0x8(%ebp)
    15bd:	68 6c 22 00 00       	push   $0x226c
    15c2:	6a 01                	push   $0x1
    15c4:	e8 36 ef ff ff       	call   4ff <printf>
    15c9:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cf:	8b 40 34             	mov    0x34(%eax),%eax
    15d2:	89 c2                	mov    %eax,%edx
    15d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d7:	8b 40 38             	mov    0x38(%eax),%eax
    15da:	0f af d0             	imul   %eax,%edx
    15dd:	89 d0                	mov    %edx,%eax
    15df:	01 c0                	add    %eax,%eax
    15e1:	01 c2                	add    %eax,%edx
    15e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e6:	8b 40 4c             	mov    0x4c(%eax),%eax
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
    1608:	74 35                	je     163f <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    160a:	8b 45 10             	mov    0x10(%ebp),%eax
    160d:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1613:	83 ec 0c             	sub    $0xc,%esp
    1616:	50                   	push   %eax
    1617:	e8 b6 f1 ff ff       	call   7d2 <malloc>
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
    163a:	e9 8d 00 00 00       	jmp    16cc <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    163f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1642:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1649:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164c:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1653:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1656:	8b 40 18             	mov    0x18(%eax),%eax
    1659:	89 c2                	mov    %eax,%edx
    165b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165e:	8b 40 1c             	mov    0x1c(%eax),%eax
    1661:	0f af d0             	imul   %eax,%edx
    1664:	89 d0                	mov    %edx,%eax
    1666:	01 c0                	add    %eax,%eax
    1668:	01 d0                	add    %edx,%eax
    166a:	83 ec 0c             	sub    $0xc,%esp
    166d:	50                   	push   %eax
    166e:	e8 5f f1 ff ff       	call   7d2 <malloc>
    1673:	83 c4 10             	add    $0x10,%esp
    1676:	89 c2                	mov    %eax,%edx
    1678:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167b:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    167e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1681:	8b 40 30             	mov    0x30(%eax),%eax
    1684:	85 c0                	test   %eax,%eax
    1686:	75 15                	jne    169d <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1688:	83 ec 04             	sub    $0x4,%esp
    168b:	ff 75 08             	pushl  0x8(%ebp)
    168e:	68 94 22 00 00       	push   $0x2294
    1693:	6a 01                	push   $0x1
    1695:	e8 65 ee ff ff       	call   4ff <printf>
    169a:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    169d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a0:	8b 40 18             	mov    0x18(%eax),%eax
    16a3:	89 c2                	mov    %eax,%edx
    16a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a8:	8b 40 1c             	mov    0x1c(%eax),%eax
    16ab:	0f af d0             	imul   %eax,%edx
    16ae:	89 d0                	mov    %edx,%eax
    16b0:	01 c0                	add    %eax,%eax
    16b2:	01 c2                	add    %eax,%edx
    16b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b7:	8b 40 30             	mov    0x30(%eax),%eax
    16ba:	83 ec 04             	sub    $0x4,%esp
    16bd:	52                   	push   %edx
    16be:	68 ff ff ff 00       	push   $0xffffff
    16c3:	50                   	push   %eax
    16c4:	e8 f4 ea ff ff       	call   1bd <memset>
    16c9:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    16cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    16cf:	c9                   	leave  
    16d0:	c3                   	ret    

000016d1 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    16d1:	55                   	push   %ebp
    16d2:	89 e5                	mov    %esp,%ebp
    16d4:	53                   	push   %ebx
    16d5:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    16d8:	8b 45 0c             	mov    0xc(%ebp),%eax
    16db:	83 f8 03             	cmp    $0x3,%eax
    16de:	74 02                	je     16e2 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    16e0:	eb 33                	jmp    1715 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    16e2:	8b 45 08             	mov    0x8(%ebp),%eax
    16e5:	8b 48 08             	mov    0x8(%eax),%ecx
    16e8:	8b 45 08             	mov    0x8(%ebp),%eax
    16eb:	8b 50 38             	mov    0x38(%eax),%edx
    16ee:	8b 45 08             	mov    0x8(%ebp),%eax
    16f1:	8b 40 34             	mov    0x34(%eax),%eax
    16f4:	8b 5d 08             	mov    0x8(%ebp),%ebx
    16f7:	83 c3 34             	add    $0x34,%ebx
    16fa:	83 ec 0c             	sub    $0xc,%esp
    16fd:	51                   	push   %ecx
    16fe:	52                   	push   %edx
    16ff:	50                   	push   %eax
    1700:	6a 00                	push   $0x0
    1702:	6a 00                	push   $0x0
    1704:	53                   	push   %ebx
    1705:	6a 32                	push   $0x32
    1707:	6a 00                	push   $0x0
    1709:	ff 75 08             	pushl  0x8(%ebp)
    170c:	e8 e7 ec ff ff       	call   3f8 <paintWindow>
    1711:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1714:	90                   	nop
        default: break;
            
            
    }
    return False;
    1715:	b8 00 00 00 00       	mov    $0x0,%eax
}
    171a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    171d:	c9                   	leave  
    171e:	c3                   	ret    

0000171f <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    171f:	55                   	push   %ebp
    1720:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1722:	8b 45 0c             	mov    0xc(%ebp),%eax
    1725:	8b 50 08             	mov    0x8(%eax),%edx
    1728:	8b 45 08             	mov    0x8(%ebp),%eax
    172b:	8b 00                	mov    (%eax),%eax
    172d:	39 c2                	cmp    %eax,%edx
    172f:	74 07                	je     1738 <APPreJudge+0x19>
        return False;
    1731:	b8 00 00 00 00       	mov    $0x0,%eax
    1736:	eb 05                	jmp    173d <APPreJudge+0x1e>
    return True;
    1738:	b8 01 00 00 00       	mov    $0x1,%eax
}
    173d:	5d                   	pop    %ebp
    173e:	c3                   	ret    

0000173f <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    173f:	55                   	push   %ebp
    1740:	89 e5                	mov    %esp,%ebp
    1742:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1745:	8b 45 08             	mov    0x8(%ebp),%eax
    1748:	8b 55 0c             	mov    0xc(%ebp),%edx
    174b:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    174e:	83 ec 0c             	sub    $0xc,%esp
    1751:	ff 75 08             	pushl  0x8(%ebp)
    1754:	e8 bf ec ff ff       	call   418 <registWindow>
    1759:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    175c:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1763:	8b 45 08             	mov    0x8(%ebp),%eax
    1766:	8b 00                	mov    (%eax),%eax
    1768:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    176b:	ff 75 f4             	pushl  -0xc(%ebp)
    176e:	ff 75 f0             	pushl  -0x10(%ebp)
    1771:	ff 75 ec             	pushl  -0x14(%ebp)
    1774:	ff 75 08             	pushl  0x8(%ebp)
    1777:	e8 e7 fc ff ff       	call   1463 <APSendMessage>
    177c:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    177f:	83 ec 0c             	sub    $0xc,%esp
    1782:	ff 75 08             	pushl  0x8(%ebp)
    1785:	e8 86 ec ff ff       	call   410 <getMessage>
    178a:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    178d:	8b 45 08             	mov    0x8(%ebp),%eax
    1790:	83 c0 6c             	add    $0x6c,%eax
    1793:	83 ec 08             	sub    $0x8,%esp
    1796:	50                   	push   %eax
    1797:	ff 75 08             	pushl  0x8(%ebp)
    179a:	e8 80 ff ff ff       	call   171f <APPreJudge>
    179f:	83 c4 10             	add    $0x10,%esp
    17a2:	84 c0                	test   %al,%al
    17a4:	74 1b                	je     17c1 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    17a6:	8b 45 08             	mov    0x8(%ebp),%eax
    17a9:	ff 70 74             	pushl  0x74(%eax)
    17ac:	ff 70 70             	pushl  0x70(%eax)
    17af:	ff 70 6c             	pushl  0x6c(%eax)
    17b2:	ff 75 08             	pushl  0x8(%ebp)
    17b5:	8b 45 0c             	mov    0xc(%ebp),%eax
    17b8:	ff d0                	call   *%eax
    17ba:	83 c4 10             	add    $0x10,%esp
    17bd:	84 c0                	test   %al,%al
    17bf:	75 0c                	jne    17cd <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    17c1:	8b 45 08             	mov    0x8(%ebp),%eax
    17c4:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    17cb:	eb b2                	jmp    177f <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    17cd:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    17ce:	90                   	nop
    17cf:	c9                   	leave  
    17d0:	c3                   	ret    

000017d1 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    17d1:	55                   	push   %ebp
    17d2:	89 e5                	mov    %esp,%ebp
    17d4:	57                   	push   %edi
    17d5:	56                   	push   %esi
    17d6:	53                   	push   %ebx
    17d7:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    17da:	a1 f8 28 00 00       	mov    0x28f8,%eax
    17df:	85 c0                	test   %eax,%eax
    17e1:	0f 85 2c 02 00 00    	jne    1a13 <APGridPaint+0x242>
    {
        iconReady = 1;
    17e7:	c7 05 f8 28 00 00 01 	movl   $0x1,0x28f8
    17ee:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    17f1:	8d 45 98             	lea    -0x68(%ebp),%eax
    17f4:	83 ec 08             	sub    $0x8,%esp
    17f7:	68 bb 22 00 00       	push   $0x22bb
    17fc:	50                   	push   %eax
    17fd:	e8 83 f1 ff ff       	call   985 <APLoadBitmap>
    1802:	83 c4 0c             	add    $0xc,%esp
    1805:	8b 45 98             	mov    -0x68(%ebp),%eax
    1808:	a3 1c 29 00 00       	mov    %eax,0x291c
    180d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1810:	a3 20 29 00 00       	mov    %eax,0x2920
    1815:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1818:	a3 24 29 00 00       	mov    %eax,0x2924
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    181d:	83 ec 04             	sub    $0x4,%esp
    1820:	ff 35 24 29 00 00    	pushl  0x2924
    1826:	ff 35 20 29 00 00    	pushl  0x2920
    182c:	ff 35 1c 29 00 00    	pushl  0x291c
    1832:	e8 88 f3 ff ff       	call   bbf <APCreateCompatibleDCFromBitmap>
    1837:	83 c4 10             	add    $0x10,%esp
    183a:	a3 28 29 00 00       	mov    %eax,0x2928
        grid_river = APLoadBitmap ("grid_river.bmp");
    183f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1842:	83 ec 08             	sub    $0x8,%esp
    1845:	68 c9 22 00 00       	push   $0x22c9
    184a:	50                   	push   %eax
    184b:	e8 35 f1 ff ff       	call   985 <APLoadBitmap>
    1850:	83 c4 0c             	add    $0xc,%esp
    1853:	8b 45 98             	mov    -0x68(%ebp),%eax
    1856:	a3 58 29 00 00       	mov    %eax,0x2958
    185b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    185e:	a3 5c 29 00 00       	mov    %eax,0x295c
    1863:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1866:	a3 60 29 00 00       	mov    %eax,0x2960
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    186b:	83 ec 04             	sub    $0x4,%esp
    186e:	ff 35 60 29 00 00    	pushl  0x2960
    1874:	ff 35 5c 29 00 00    	pushl  0x295c
    187a:	ff 35 58 29 00 00    	pushl  0x2958
    1880:	e8 3a f3 ff ff       	call   bbf <APCreateCompatibleDCFromBitmap>
    1885:	83 c4 10             	add    $0x10,%esp
    1888:	a3 48 29 00 00       	mov    %eax,0x2948
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    188d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1890:	83 ec 08             	sub    $0x8,%esp
    1893:	68 d8 22 00 00       	push   $0x22d8
    1898:	50                   	push   %eax
    1899:	e8 e7 f0 ff ff       	call   985 <APLoadBitmap>
    189e:	83 c4 0c             	add    $0xc,%esp
    18a1:	8b 45 98             	mov    -0x68(%ebp),%eax
    18a4:	a3 4c 29 00 00       	mov    %eax,0x294c
    18a9:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18ac:	a3 50 29 00 00       	mov    %eax,0x2950
    18b1:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18b4:	a3 54 29 00 00       	mov    %eax,0x2954
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    18b9:	83 ec 04             	sub    $0x4,%esp
    18bc:	ff 35 54 29 00 00    	pushl  0x2954
    18c2:	ff 35 50 29 00 00    	pushl  0x2950
    18c8:	ff 35 4c 29 00 00    	pushl  0x294c
    18ce:	e8 ec f2 ff ff       	call   bbf <APCreateCompatibleDCFromBitmap>
    18d3:	83 c4 10             	add    $0x10,%esp
    18d6:	a3 fc 28 00 00       	mov    %eax,0x28fc
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    18db:	8d 45 98             	lea    -0x68(%ebp),%eax
    18de:	83 ec 08             	sub    $0x8,%esp
    18e1:	68 e7 22 00 00       	push   $0x22e7
    18e6:	50                   	push   %eax
    18e7:	e8 99 f0 ff ff       	call   985 <APLoadBitmap>
    18ec:	83 c4 0c             	add    $0xc,%esp
    18ef:	8b 45 98             	mov    -0x68(%ebp),%eax
    18f2:	a3 30 29 00 00       	mov    %eax,0x2930
    18f7:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18fa:	a3 34 29 00 00       	mov    %eax,0x2934
    18ff:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1902:	a3 38 29 00 00       	mov    %eax,0x2938
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1907:	83 ec 04             	sub    $0x4,%esp
    190a:	ff 35 38 29 00 00    	pushl  0x2938
    1910:	ff 35 34 29 00 00    	pushl  0x2934
    1916:	ff 35 30 29 00 00    	pushl  0x2930
    191c:	e8 9e f2 ff ff       	call   bbf <APCreateCompatibleDCFromBitmap>
    1921:	83 c4 10             	add    $0x10,%esp
    1924:	a3 64 29 00 00       	mov    %eax,0x2964
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1929:	8d 45 98             	lea    -0x68(%ebp),%eax
    192c:	83 ec 08             	sub    $0x8,%esp
    192f:	68 f5 22 00 00       	push   $0x22f5
    1934:	50                   	push   %eax
    1935:	e8 4b f0 ff ff       	call   985 <APLoadBitmap>
    193a:	83 c4 0c             	add    $0xc,%esp
    193d:	8b 45 98             	mov    -0x68(%ebp),%eax
    1940:	a3 0c 29 00 00       	mov    %eax,0x290c
    1945:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1948:	a3 10 29 00 00       	mov    %eax,0x2910
    194d:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1950:	a3 14 29 00 00       	mov    %eax,0x2914
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1955:	83 ec 04             	sub    $0x4,%esp
    1958:	ff 35 14 29 00 00    	pushl  0x2914
    195e:	ff 35 10 29 00 00    	pushl  0x2910
    1964:	ff 35 0c 29 00 00    	pushl  0x290c
    196a:	e8 50 f2 ff ff       	call   bbf <APCreateCompatibleDCFromBitmap>
    196f:	83 c4 10             	add    $0x10,%esp
    1972:	a3 2c 29 00 00       	mov    %eax,0x292c
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1977:	8d 45 98             	lea    -0x68(%ebp),%eax
    197a:	83 ec 08             	sub    $0x8,%esp
    197d:	68 05 23 00 00       	push   $0x2305
    1982:	50                   	push   %eax
    1983:	e8 fd ef ff ff       	call   985 <APLoadBitmap>
    1988:	83 c4 0c             	add    $0xc,%esp
    198b:	8b 45 98             	mov    -0x68(%ebp),%eax
    198e:	a3 00 29 00 00       	mov    %eax,0x2900
    1993:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1996:	a3 04 29 00 00       	mov    %eax,0x2904
    199b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    199e:	a3 08 29 00 00       	mov    %eax,0x2908
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    19a3:	83 ec 04             	sub    $0x4,%esp
    19a6:	ff 35 08 29 00 00    	pushl  0x2908
    19ac:	ff 35 04 29 00 00    	pushl  0x2904
    19b2:	ff 35 00 29 00 00    	pushl  0x2900
    19b8:	e8 02 f2 ff ff       	call   bbf <APCreateCompatibleDCFromBitmap>
    19bd:	83 c4 10             	add    $0x10,%esp
    19c0:	a3 18 29 00 00       	mov    %eax,0x2918
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    19c5:	8d 45 98             	lea    -0x68(%ebp),%eax
    19c8:	83 ec 08             	sub    $0x8,%esp
    19cb:	68 17 23 00 00       	push   $0x2317
    19d0:	50                   	push   %eax
    19d1:	e8 af ef ff ff       	call   985 <APLoadBitmap>
    19d6:	83 c4 0c             	add    $0xc,%esp
    19d9:	8b 45 98             	mov    -0x68(%ebp),%eax
    19dc:	a3 3c 29 00 00       	mov    %eax,0x293c
    19e1:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19e4:	a3 40 29 00 00       	mov    %eax,0x2940
    19e9:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19ec:	a3 44 29 00 00       	mov    %eax,0x2944
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    19f1:	83 ec 04             	sub    $0x4,%esp
    19f4:	ff 35 44 29 00 00    	pushl  0x2944
    19fa:	ff 35 40 29 00 00    	pushl  0x2940
    1a00:	ff 35 3c 29 00 00    	pushl  0x293c
    1a06:	e8 b4 f1 ff ff       	call   bbf <APCreateCompatibleDCFromBitmap>
    1a0b:	83 c4 10             	add    $0x10,%esp
    1a0e:	a3 68 29 00 00       	mov    %eax,0x2968
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1a13:	8b 45 08             	mov    0x8(%ebp),%eax
    1a16:	8b 40 08             	mov    0x8(%eax),%eax
    1a19:	85 c0                	test   %eax,%eax
    1a1b:	75 17                	jne    1a34 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1a1d:	83 ec 08             	sub    $0x8,%esp
    1a20:	68 28 23 00 00       	push   $0x2328
    1a25:	6a 01                	push   $0x1
    1a27:	e8 d3 ea ff ff       	call   4ff <printf>
    1a2c:	83 c4 10             	add    $0x10,%esp
        return;
    1a2f:	e9 f2 03 00 00       	jmp    1e26 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1a34:	8b 45 08             	mov    0x8(%ebp),%eax
    1a37:	8b 40 10             	mov    0x10(%eax),%eax
    1a3a:	85 c0                	test   %eax,%eax
    1a3c:	7e 10                	jle    1a4e <APGridPaint+0x27d>
    1a3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a41:	8b 50 14             	mov    0x14(%eax),%edx
    1a44:	8b 45 08             	mov    0x8(%ebp),%eax
    1a47:	8b 40 10             	mov    0x10(%eax),%eax
    1a4a:	39 c2                	cmp    %eax,%edx
    1a4c:	7c 17                	jl     1a65 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1a4e:	83 ec 08             	sub    $0x8,%esp
    1a51:	68 4e 23 00 00       	push   $0x234e
    1a56:	6a 01                	push   $0x1
    1a58:	e8 a2 ea ff ff       	call   4ff <printf>
    1a5d:	83 c4 10             	add    $0x10,%esp
        return;
    1a60:	e9 c1 03 00 00       	jmp    1e26 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1a65:	8b 45 08             	mov    0x8(%ebp),%eax
    1a68:	8b 40 14             	mov    0x14(%eax),%eax
    1a6b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a71:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a74:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a77:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a7a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a81:	e9 96 03 00 00       	jmp    1e1c <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a86:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a8d:	e9 7c 03 00 00       	jmp    1e0e <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a92:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a95:	c1 e0 04             	shl    $0x4,%eax
    1a98:	89 c2                	mov    %eax,%edx
    1a9a:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a9d:	01 c2                	add    %eax,%edx
    1a9f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1aa2:	01 d0                	add    %edx,%eax
    1aa4:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1aa7:	8b 45 08             	mov    0x8(%ebp),%eax
    1aaa:	8b 40 0c             	mov    0xc(%eax),%eax
    1aad:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1ab0:	c1 e2 02             	shl    $0x2,%edx
    1ab3:	01 d0                	add    %edx,%eax
    1ab5:	8b 00                	mov    (%eax),%eax
    1ab7:	83 f8 07             	cmp    $0x7,%eax
    1aba:	0f 87 49 03 00 00    	ja     1e09 <APGridPaint+0x638>
    1ac0:	8b 04 85 64 23 00 00 	mov    0x2364(,%eax,4),%eax
    1ac7:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ac9:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1acc:	6a 0c                	push   $0xc
    1ace:	6a 0c                	push   $0xc
    1ad0:	6a 0c                	push   $0xc
    1ad2:	50                   	push   %eax
    1ad3:	e8 46 f9 ff ff       	call   141e <RGB>
    1ad8:	83 c4 0c             	add    $0xc,%esp
    1adb:	8b 1d 28 29 00 00    	mov    0x2928,%ebx
    1ae1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ae4:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ae7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1aea:	6b c0 32             	imul   $0x32,%eax,%eax
    1aed:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1af0:	8b 45 08             	mov    0x8(%ebp),%eax
    1af3:	8d 78 34             	lea    0x34(%eax),%edi
    1af6:	83 ec 0c             	sub    $0xc,%esp
    1af9:	83 ec 04             	sub    $0x4,%esp
    1afc:	89 e0                	mov    %esp,%eax
    1afe:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1b02:	66 89 30             	mov    %si,(%eax)
    1b05:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1b09:	88 50 02             	mov    %dl,0x2(%eax)
    1b0c:	6a 32                	push   $0x32
    1b0e:	6a 32                	push   $0x32
    1b10:	6a 00                	push   $0x0
    1b12:	6a 00                	push   $0x0
    1b14:	53                   	push   %ebx
    1b15:	51                   	push   %ecx
    1b16:	ff 75 94             	pushl  -0x6c(%ebp)
    1b19:	57                   	push   %edi
    1b1a:	e8 5b f7 ff ff       	call   127a <APDcCopy>
    1b1f:	83 c4 30             	add    $0x30,%esp
                    break;
    1b22:	e9 e3 02 00 00       	jmp    1e0a <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1b27:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b2a:	6a 69                	push   $0x69
    1b2c:	6a 69                	push   $0x69
    1b2e:	6a 69                	push   $0x69
    1b30:	50                   	push   %eax
    1b31:	e8 e8 f8 ff ff       	call   141e <RGB>
    1b36:	83 c4 0c             	add    $0xc,%esp
    1b39:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b3d:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1b41:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b45:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1b48:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1b4f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b52:	6a 69                	push   $0x69
    1b54:	6a 69                	push   $0x69
    1b56:	6a 69                	push   $0x69
    1b58:	50                   	push   %eax
    1b59:	e8 c0 f8 ff ff       	call   141e <RGB>
    1b5e:	83 c4 0c             	add    $0xc,%esp
    1b61:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b65:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1b69:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b6d:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b70:	8b 45 08             	mov    0x8(%ebp),%eax
    1b73:	8d 50 34             	lea    0x34(%eax),%edx
    1b76:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b79:	ff 75 bc             	pushl  -0x44(%ebp)
    1b7c:	ff 75 b8             	pushl  -0x48(%ebp)
    1b7f:	52                   	push   %edx
    1b80:	50                   	push   %eax
    1b81:	e8 ce f0 ff ff       	call   c54 <APSetPen>
    1b86:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b89:	8b 45 08             	mov    0x8(%ebp),%eax
    1b8c:	8d 58 34             	lea    0x34(%eax),%ebx
    1b8f:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b92:	83 ec 04             	sub    $0x4,%esp
    1b95:	83 ec 04             	sub    $0x4,%esp
    1b98:	89 e0                	mov    %esp,%eax
    1b9a:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1b9e:	66 89 08             	mov    %cx,(%eax)
    1ba1:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1ba5:	88 48 02             	mov    %cl,0x2(%eax)
    1ba8:	53                   	push   %ebx
    1ba9:	52                   	push   %edx
    1baa:	e8 de f0 ff ff       	call   c8d <APSetBrush>
    1baf:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1bb2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bb5:	6b d0 32             	imul   $0x32,%eax,%edx
    1bb8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bbb:	6b c0 32             	imul   $0x32,%eax,%eax
    1bbe:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bc1:	83 c1 34             	add    $0x34,%ecx
    1bc4:	83 ec 0c             	sub    $0xc,%esp
    1bc7:	6a 32                	push   $0x32
    1bc9:	6a 32                	push   $0x32
    1bcb:	52                   	push   %edx
    1bcc:	50                   	push   %eax
    1bcd:	51                   	push   %ecx
    1bce:	e8 a2 f4 ff ff       	call   1075 <APDrawRect>
    1bd3:	83 c4 20             	add    $0x20,%esp
                    break;
    1bd6:	e9 2f 02 00 00       	jmp    1e0a <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bdb:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1bde:	6a 0c                	push   $0xc
    1be0:	6a 0c                	push   $0xc
    1be2:	6a 0c                	push   $0xc
    1be4:	50                   	push   %eax
    1be5:	e8 34 f8 ff ff       	call   141e <RGB>
    1bea:	83 c4 0c             	add    $0xc,%esp
    1bed:	8b 1d 68 29 00 00    	mov    0x2968,%ebx
    1bf3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bf6:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bf9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bfc:	6b c0 32             	imul   $0x32,%eax,%eax
    1bff:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c02:	8b 45 08             	mov    0x8(%ebp),%eax
    1c05:	8d 78 34             	lea    0x34(%eax),%edi
    1c08:	83 ec 0c             	sub    $0xc,%esp
    1c0b:	83 ec 04             	sub    $0x4,%esp
    1c0e:	89 e0                	mov    %esp,%eax
    1c10:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1c14:	66 89 30             	mov    %si,(%eax)
    1c17:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1c1b:	88 50 02             	mov    %dl,0x2(%eax)
    1c1e:	6a 32                	push   $0x32
    1c20:	6a 32                	push   $0x32
    1c22:	6a 00                	push   $0x0
    1c24:	6a 00                	push   $0x0
    1c26:	53                   	push   %ebx
    1c27:	51                   	push   %ecx
    1c28:	ff 75 94             	pushl  -0x6c(%ebp)
    1c2b:	57                   	push   %edi
    1c2c:	e8 49 f6 ff ff       	call   127a <APDcCopy>
    1c31:	83 c4 30             	add    $0x30,%esp
                    break;
    1c34:	e9 d1 01 00 00       	jmp    1e0a <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c39:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1c3c:	6a 0c                	push   $0xc
    1c3e:	6a 0c                	push   $0xc
    1c40:	6a 0c                	push   $0xc
    1c42:	50                   	push   %eax
    1c43:	e8 d6 f7 ff ff       	call   141e <RGB>
    1c48:	83 c4 0c             	add    $0xc,%esp
    1c4b:	8b 1d 48 29 00 00    	mov    0x2948,%ebx
    1c51:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c54:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c57:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c5a:	6b c0 32             	imul   $0x32,%eax,%eax
    1c5d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c60:	8b 45 08             	mov    0x8(%ebp),%eax
    1c63:	8d 78 34             	lea    0x34(%eax),%edi
    1c66:	83 ec 0c             	sub    $0xc,%esp
    1c69:	83 ec 04             	sub    $0x4,%esp
    1c6c:	89 e0                	mov    %esp,%eax
    1c6e:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1c72:	66 89 30             	mov    %si,(%eax)
    1c75:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c79:	88 50 02             	mov    %dl,0x2(%eax)
    1c7c:	6a 32                	push   $0x32
    1c7e:	6a 32                	push   $0x32
    1c80:	6a 00                	push   $0x0
    1c82:	6a 00                	push   $0x0
    1c84:	53                   	push   %ebx
    1c85:	51                   	push   %ecx
    1c86:	ff 75 94             	pushl  -0x6c(%ebp)
    1c89:	57                   	push   %edi
    1c8a:	e8 eb f5 ff ff       	call   127a <APDcCopy>
    1c8f:	83 c4 30             	add    $0x30,%esp
                    break;
    1c92:	e9 73 01 00 00       	jmp    1e0a <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c97:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c9a:	6a 0c                	push   $0xc
    1c9c:	6a 0c                	push   $0xc
    1c9e:	6a 0c                	push   $0xc
    1ca0:	50                   	push   %eax
    1ca1:	e8 78 f7 ff ff       	call   141e <RGB>
    1ca6:	83 c4 0c             	add    $0xc,%esp
    1ca9:	8b 1d 2c 29 00 00    	mov    0x292c,%ebx
    1caf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cb2:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cb5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cb8:	6b c0 32             	imul   $0x32,%eax,%eax
    1cbb:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cbe:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc1:	8d 78 34             	lea    0x34(%eax),%edi
    1cc4:	83 ec 0c             	sub    $0xc,%esp
    1cc7:	83 ec 04             	sub    $0x4,%esp
    1cca:	89 e0                	mov    %esp,%eax
    1ccc:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1cd0:	66 89 30             	mov    %si,(%eax)
    1cd3:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1cd7:	88 50 02             	mov    %dl,0x2(%eax)
    1cda:	6a 32                	push   $0x32
    1cdc:	6a 32                	push   $0x32
    1cde:	6a 00                	push   $0x0
    1ce0:	6a 00                	push   $0x0
    1ce2:	53                   	push   %ebx
    1ce3:	51                   	push   %ecx
    1ce4:	ff 75 94             	pushl  -0x6c(%ebp)
    1ce7:	57                   	push   %edi
    1ce8:	e8 8d f5 ff ff       	call   127a <APDcCopy>
    1ced:	83 c4 30             	add    $0x30,%esp
                    break;
    1cf0:	e9 15 01 00 00       	jmp    1e0a <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cf5:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1cf8:	6a 0c                	push   $0xc
    1cfa:	6a 0c                	push   $0xc
    1cfc:	6a 0c                	push   $0xc
    1cfe:	50                   	push   %eax
    1cff:	e8 1a f7 ff ff       	call   141e <RGB>
    1d04:	83 c4 0c             	add    $0xc,%esp
    1d07:	8b 1d 64 29 00 00    	mov    0x2964,%ebx
    1d0d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d10:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d13:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d16:	6b c0 32             	imul   $0x32,%eax,%eax
    1d19:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d1c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d1f:	8d 78 34             	lea    0x34(%eax),%edi
    1d22:	83 ec 0c             	sub    $0xc,%esp
    1d25:	83 ec 04             	sub    $0x4,%esp
    1d28:	89 e0                	mov    %esp,%eax
    1d2a:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1d2e:	66 89 30             	mov    %si,(%eax)
    1d31:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1d35:	88 50 02             	mov    %dl,0x2(%eax)
    1d38:	6a 32                	push   $0x32
    1d3a:	6a 32                	push   $0x32
    1d3c:	6a 00                	push   $0x0
    1d3e:	6a 00                	push   $0x0
    1d40:	53                   	push   %ebx
    1d41:	51                   	push   %ecx
    1d42:	ff 75 94             	pushl  -0x6c(%ebp)
    1d45:	57                   	push   %edi
    1d46:	e8 2f f5 ff ff       	call   127a <APDcCopy>
    1d4b:	83 c4 30             	add    $0x30,%esp
                    break;
    1d4e:	e9 b7 00 00 00       	jmp    1e0a <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d53:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1d56:	6a 0c                	push   $0xc
    1d58:	6a 0c                	push   $0xc
    1d5a:	6a 0c                	push   $0xc
    1d5c:	50                   	push   %eax
    1d5d:	e8 bc f6 ff ff       	call   141e <RGB>
    1d62:	83 c4 0c             	add    $0xc,%esp
    1d65:	8b 1d fc 28 00 00    	mov    0x28fc,%ebx
    1d6b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d6e:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d71:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d74:	6b c0 32             	imul   $0x32,%eax,%eax
    1d77:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d7a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7d:	8d 78 34             	lea    0x34(%eax),%edi
    1d80:	83 ec 0c             	sub    $0xc,%esp
    1d83:	83 ec 04             	sub    $0x4,%esp
    1d86:	89 e0                	mov    %esp,%eax
    1d88:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d8c:	66 89 30             	mov    %si,(%eax)
    1d8f:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d93:	88 50 02             	mov    %dl,0x2(%eax)
    1d96:	6a 32                	push   $0x32
    1d98:	6a 32                	push   $0x32
    1d9a:	6a 00                	push   $0x0
    1d9c:	6a 00                	push   $0x0
    1d9e:	53                   	push   %ebx
    1d9f:	51                   	push   %ecx
    1da0:	ff 75 94             	pushl  -0x6c(%ebp)
    1da3:	57                   	push   %edi
    1da4:	e8 d1 f4 ff ff       	call   127a <APDcCopy>
    1da9:	83 c4 30             	add    $0x30,%esp
                    break;
    1dac:	eb 5c                	jmp    1e0a <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dae:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1db1:	6a 0c                	push   $0xc
    1db3:	6a 0c                	push   $0xc
    1db5:	6a 0c                	push   $0xc
    1db7:	50                   	push   %eax
    1db8:	e8 61 f6 ff ff       	call   141e <RGB>
    1dbd:	83 c4 0c             	add    $0xc,%esp
    1dc0:	8b 1d 18 29 00 00    	mov    0x2918,%ebx
    1dc6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dc9:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dcc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dcf:	6b c0 32             	imul   $0x32,%eax,%eax
    1dd2:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dd5:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd8:	8d 78 34             	lea    0x34(%eax),%edi
    1ddb:	83 ec 0c             	sub    $0xc,%esp
    1dde:	83 ec 04             	sub    $0x4,%esp
    1de1:	89 e0                	mov    %esp,%eax
    1de3:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1de7:	66 89 30             	mov    %si,(%eax)
    1dea:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1dee:	88 50 02             	mov    %dl,0x2(%eax)
    1df1:	6a 32                	push   $0x32
    1df3:	6a 32                	push   $0x32
    1df5:	6a 00                	push   $0x0
    1df7:	6a 00                	push   $0x0
    1df9:	53                   	push   %ebx
    1dfa:	51                   	push   %ecx
    1dfb:	ff 75 94             	pushl  -0x6c(%ebp)
    1dfe:	57                   	push   %edi
    1dff:	e8 76 f4 ff ff       	call   127a <APDcCopy>
    1e04:	83 c4 30             	add    $0x30,%esp
                    break;
    1e07:	eb 01                	jmp    1e0a <APGridPaint+0x639>
                default: break;
    1e09:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1e0a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1e0e:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1e12:	0f 8e 7a fc ff ff    	jle    1a92 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e18:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e1c:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1e20:	0f 8e 60 fc ff ff    	jle    1a86 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1e26:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1e29:	5b                   	pop    %ebx
    1e2a:	5e                   	pop    %esi
    1e2b:	5f                   	pop    %edi
    1e2c:	5d                   	pop    %ebp
    1e2d:	c3                   	ret    

00001e2e <random>:
//

#include "APLib.h"

int random(int seed)
{
    1e2e:	55                   	push   %ebp
    1e2f:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1e31:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1e35:	7e 08                	jle    1e3f <random+0x11>
{
rand_num = seed;
    1e37:	8b 45 08             	mov    0x8(%ebp),%eax
    1e3a:	a3 d4 28 00 00       	mov    %eax,0x28d4
}
rand_num *= 3;
    1e3f:	8b 15 d4 28 00 00    	mov    0x28d4,%edx
    1e45:	89 d0                	mov    %edx,%eax
    1e47:	01 c0                	add    %eax,%eax
    1e49:	01 d0                	add    %edx,%eax
    1e4b:	a3 d4 28 00 00       	mov    %eax,0x28d4
if (rand_num < 0)
    1e50:	a1 d4 28 00 00       	mov    0x28d4,%eax
    1e55:	85 c0                	test   %eax,%eax
    1e57:	79 0c                	jns    1e65 <random+0x37>
{
rand_num *= (-1);
    1e59:	a1 d4 28 00 00       	mov    0x28d4,%eax
    1e5e:	f7 d8                	neg    %eax
    1e60:	a3 d4 28 00 00       	mov    %eax,0x28d4
}
return rand_num % 997;
    1e65:	8b 0d d4 28 00 00    	mov    0x28d4,%ecx
    1e6b:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1e70:	89 c8                	mov    %ecx,%eax
    1e72:	f7 ea                	imul   %edx
    1e74:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1e77:	c1 f8 09             	sar    $0x9,%eax
    1e7a:	89 c2                	mov    %eax,%edx
    1e7c:	89 c8                	mov    %ecx,%eax
    1e7e:	c1 f8 1f             	sar    $0x1f,%eax
    1e81:	29 c2                	sub    %eax,%edx
    1e83:	89 d0                	mov    %edx,%eax
    1e85:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1e8b:	29 c1                	sub    %eax,%ecx
    1e8d:	89 c8                	mov    %ecx,%eax
}
    1e8f:	5d                   	pop    %ebp
    1e90:	c3                   	ret    

00001e91 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1e91:	55                   	push   %ebp
    1e92:	89 e5                	mov    %esp,%ebp
    1e94:	53                   	push   %ebx
    1e95:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1e98:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1e9f:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1ea3:	74 17                	je     1ebc <sprintint+0x2b>
    1ea5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1ea9:	79 11                	jns    1ebc <sprintint+0x2b>
        neg = 1;
    1eab:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1eb2:	8b 45 10             	mov    0x10(%ebp),%eax
    1eb5:	f7 d8                	neg    %eax
    1eb7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1eba:	eb 06                	jmp    1ec2 <sprintint+0x31>
    } else {
        x = xx;
    1ebc:	8b 45 10             	mov    0x10(%ebp),%eax
    1ebf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1ec2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1ec9:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1ecc:	8d 41 01             	lea    0x1(%ecx),%eax
    1ecf:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1ed2:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1ed5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ed8:	ba 00 00 00 00       	mov    $0x0,%edx
    1edd:	f7 f3                	div    %ebx
    1edf:	89 d0                	mov    %edx,%eax
    1ee1:	0f b6 80 d8 28 00 00 	movzbl 0x28d8(%eax),%eax
    1ee8:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1eec:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1eef:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ef2:	ba 00 00 00 00       	mov    $0x0,%edx
    1ef7:	f7 f3                	div    %ebx
    1ef9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1efc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f00:	75 c7                	jne    1ec9 <sprintint+0x38>
    if(neg)
    1f02:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f06:	74 0e                	je     1f16 <sprintint+0x85>
        buf[i++] = '-';
    1f08:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f0b:	8d 50 01             	lea    0x1(%eax),%edx
    1f0e:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1f11:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1f16:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f19:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1f1c:	eb 1b                	jmp    1f39 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1f1e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f21:	8b 00                	mov    (%eax),%eax
    1f23:	8d 48 01             	lea    0x1(%eax),%ecx
    1f26:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f29:	89 0a                	mov    %ecx,(%edx)
    1f2b:	89 c2                	mov    %eax,%edx
    1f2d:	8b 45 08             	mov    0x8(%ebp),%eax
    1f30:	01 d0                	add    %edx,%eax
    1f32:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1f35:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1f39:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1f3d:	7f df                	jg     1f1e <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1f3f:	eb 21                	jmp    1f62 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1f41:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f44:	8b 00                	mov    (%eax),%eax
    1f46:	8d 48 01             	lea    0x1(%eax),%ecx
    1f49:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f4c:	89 0a                	mov    %ecx,(%edx)
    1f4e:	89 c2                	mov    %eax,%edx
    1f50:	8b 45 08             	mov    0x8(%ebp),%eax
    1f53:	01 c2                	add    %eax,%edx
    1f55:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1f58:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f5b:	01 c8                	add    %ecx,%eax
    1f5d:	0f b6 00             	movzbl (%eax),%eax
    1f60:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1f62:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1f66:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1f6a:	79 d5                	jns    1f41 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1f6c:	90                   	nop
    1f6d:	83 c4 20             	add    $0x20,%esp
    1f70:	5b                   	pop    %ebx
    1f71:	5d                   	pop    %ebp
    1f72:	c3                   	ret    

00001f73 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1f73:	55                   	push   %ebp
    1f74:	89 e5                	mov    %esp,%ebp
    1f76:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1f79:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1f80:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1f87:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1f8e:	8d 45 0c             	lea    0xc(%ebp),%eax
    1f91:	83 c0 04             	add    $0x4,%eax
    1f94:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1f97:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1f9e:	e9 d9 01 00 00       	jmp    217c <sprintf+0x209>
        c = fmt[i] & 0xff;
    1fa3:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fa6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1fa9:	01 d0                	add    %edx,%eax
    1fab:	0f b6 00             	movzbl (%eax),%eax
    1fae:	0f be c0             	movsbl %al,%eax
    1fb1:	25 ff 00 00 00       	and    $0xff,%eax
    1fb6:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1fb9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1fbd:	75 2c                	jne    1feb <sprintf+0x78>
            if(c == '%'){
    1fbf:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1fc3:	75 0c                	jne    1fd1 <sprintf+0x5e>
                state = '%';
    1fc5:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1fcc:	e9 a7 01 00 00       	jmp    2178 <sprintf+0x205>
            } else {
                dst[j++] = c;
    1fd1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1fd4:	8d 50 01             	lea    0x1(%eax),%edx
    1fd7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1fda:	89 c2                	mov    %eax,%edx
    1fdc:	8b 45 08             	mov    0x8(%ebp),%eax
    1fdf:	01 d0                	add    %edx,%eax
    1fe1:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1fe4:	88 10                	mov    %dl,(%eax)
    1fe6:	e9 8d 01 00 00       	jmp    2178 <sprintf+0x205>
            }
        } else if(state == '%'){
    1feb:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1fef:	0f 85 83 01 00 00    	jne    2178 <sprintf+0x205>
            if(c == 'd'){
    1ff5:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1ff9:	75 4c                	jne    2047 <sprintf+0xd4>
                buf[bi] = '\0';
    1ffb:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1ffe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2001:	01 d0                	add    %edx,%eax
    2003:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2006:	83 ec 0c             	sub    $0xc,%esp
    2009:	8d 45 ce             	lea    -0x32(%ebp),%eax
    200c:	50                   	push   %eax
    200d:	e8 b4 e2 ff ff       	call   2c6 <atoi>
    2012:	83 c4 10             	add    $0x10,%esp
    2015:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2018:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    201f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2022:	8b 00                	mov    (%eax),%eax
    2024:	83 ec 08             	sub    $0x8,%esp
    2027:	ff 75 d8             	pushl  -0x28(%ebp)
    202a:	6a 01                	push   $0x1
    202c:	6a 0a                	push   $0xa
    202e:	50                   	push   %eax
    202f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2032:	50                   	push   %eax
    2033:	ff 75 08             	pushl  0x8(%ebp)
    2036:	e8 56 fe ff ff       	call   1e91 <sprintint>
    203b:	83 c4 20             	add    $0x20,%esp
                ap++;
    203e:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2042:	e9 2a 01 00 00       	jmp    2171 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2047:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    204b:	74 06                	je     2053 <sprintf+0xe0>
    204d:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2051:	75 4c                	jne    209f <sprintf+0x12c>
                buf[bi] = '\0';
    2053:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2056:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2059:	01 d0                	add    %edx,%eax
    205b:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    205e:	83 ec 0c             	sub    $0xc,%esp
    2061:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2064:	50                   	push   %eax
    2065:	e8 5c e2 ff ff       	call   2c6 <atoi>
    206a:	83 c4 10             	add    $0x10,%esp
    206d:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2070:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2077:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    207a:	8b 00                	mov    (%eax),%eax
    207c:	83 ec 08             	sub    $0x8,%esp
    207f:	ff 75 dc             	pushl  -0x24(%ebp)
    2082:	6a 00                	push   $0x0
    2084:	6a 10                	push   $0x10
    2086:	50                   	push   %eax
    2087:	8d 45 c8             	lea    -0x38(%ebp),%eax
    208a:	50                   	push   %eax
    208b:	ff 75 08             	pushl  0x8(%ebp)
    208e:	e8 fe fd ff ff       	call   1e91 <sprintint>
    2093:	83 c4 20             	add    $0x20,%esp
                ap++;
    2096:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    209a:	e9 d2 00 00 00       	jmp    2171 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    209f:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    20a3:	75 46                	jne    20eb <sprintf+0x178>
                s = (char*)*ap;
    20a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20a8:	8b 00                	mov    (%eax),%eax
    20aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    20ad:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    20b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    20b5:	75 25                	jne    20dc <sprintf+0x169>
                    s = "(null)";
    20b7:	c7 45 f4 84 23 00 00 	movl   $0x2384,-0xc(%ebp)
                while(*s != 0){
    20be:	eb 1c                	jmp    20dc <sprintf+0x169>
                    dst[j++] = *s;
    20c0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20c3:	8d 50 01             	lea    0x1(%eax),%edx
    20c6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20c9:	89 c2                	mov    %eax,%edx
    20cb:	8b 45 08             	mov    0x8(%ebp),%eax
    20ce:	01 c2                	add    %eax,%edx
    20d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20d3:	0f b6 00             	movzbl (%eax),%eax
    20d6:	88 02                	mov    %al,(%edx)
                    s++;
    20d8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    20dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20df:	0f b6 00             	movzbl (%eax),%eax
    20e2:	84 c0                	test   %al,%al
    20e4:	75 da                	jne    20c0 <sprintf+0x14d>
    20e6:	e9 86 00 00 00       	jmp    2171 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    20eb:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    20ef:	75 1d                	jne    210e <sprintf+0x19b>
                dst[j++] = *ap;
    20f1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20f4:	8d 50 01             	lea    0x1(%eax),%edx
    20f7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20fa:	89 c2                	mov    %eax,%edx
    20fc:	8b 45 08             	mov    0x8(%ebp),%eax
    20ff:	01 c2                	add    %eax,%edx
    2101:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2104:	8b 00                	mov    (%eax),%eax
    2106:	88 02                	mov    %al,(%edx)
                ap++;
    2108:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    210c:	eb 63                	jmp    2171 <sprintf+0x1fe>
            } else if(c == '%'){
    210e:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2112:	75 17                	jne    212b <sprintf+0x1b8>
                dst[j++] = c;
    2114:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2117:	8d 50 01             	lea    0x1(%eax),%edx
    211a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    211d:	89 c2                	mov    %eax,%edx
    211f:	8b 45 08             	mov    0x8(%ebp),%eax
    2122:	01 d0                	add    %edx,%eax
    2124:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2127:	88 10                	mov    %dl,(%eax)
    2129:	eb 46                	jmp    2171 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    212b:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    212f:	7e 18                	jle    2149 <sprintf+0x1d6>
    2131:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2135:	7f 12                	jg     2149 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2137:	8b 45 f0             	mov    -0x10(%ebp),%eax
    213a:	8d 50 01             	lea    0x1(%eax),%edx
    213d:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2140:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2143:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2147:	eb 2f                	jmp    2178 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2149:	8b 45 c8             	mov    -0x38(%ebp),%eax
    214c:	8d 50 01             	lea    0x1(%eax),%edx
    214f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2152:	89 c2                	mov    %eax,%edx
    2154:	8b 45 08             	mov    0x8(%ebp),%eax
    2157:	01 d0                	add    %edx,%eax
    2159:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    215c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    215f:	8d 50 01             	lea    0x1(%eax),%edx
    2162:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2165:	89 c2                	mov    %eax,%edx
    2167:	8b 45 08             	mov    0x8(%ebp),%eax
    216a:	01 d0                	add    %edx,%eax
    216c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    216f:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2171:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2178:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    217c:	8b 55 0c             	mov    0xc(%ebp),%edx
    217f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2182:	01 d0                	add    %edx,%eax
    2184:	0f b6 00             	movzbl (%eax),%eax
    2187:	84 c0                	test   %al,%al
    2189:	0f 85 14 fe ff ff    	jne    1fa3 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    218f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2192:	8d 50 01             	lea    0x1(%eax),%edx
    2195:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2198:	89 c2                	mov    %eax,%edx
    219a:	8b 45 08             	mov    0x8(%ebp),%eax
    219d:	01 d0                	add    %edx,%eax
    219f:	c6 00 00             	movb   $0x0,(%eax)
}
    21a2:	90                   	nop
    21a3:	c9                   	leave  
    21a4:	c3                   	ret    
