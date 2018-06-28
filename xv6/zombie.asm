
_zombie：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
      11:	e8 65 02 00 00       	call   27b <fork>
      16:	85 c0                	test   %eax,%eax
      18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
      1a:	83 ec 0c             	sub    $0xc,%esp
      1d:	6a 05                	push   $0x5
      1f:	e8 ef 02 00 00       	call   313 <sleep>
      24:	83 c4 10             	add    $0x10,%esp
  exit();
      27:	e8 57 02 00 00       	call   283 <exit>

0000002c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
      2c:	55                   	push   %ebp
      2d:	89 e5                	mov    %esp,%ebp
      2f:	57                   	push   %edi
      30:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      31:	8b 4d 08             	mov    0x8(%ebp),%ecx
      34:	8b 55 10             	mov    0x10(%ebp),%edx
      37:	8b 45 0c             	mov    0xc(%ebp),%eax
      3a:	89 cb                	mov    %ecx,%ebx
      3c:	89 df                	mov    %ebx,%edi
      3e:	89 d1                	mov    %edx,%ecx
      40:	fc                   	cld    
      41:	f3 aa                	rep stos %al,%es:(%edi)
      43:	89 ca                	mov    %ecx,%edx
      45:	89 fb                	mov    %edi,%ebx
      47:	89 5d 08             	mov    %ebx,0x8(%ebp)
      4a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      4d:	90                   	nop
      4e:	5b                   	pop    %ebx
      4f:	5f                   	pop    %edi
      50:	5d                   	pop    %ebp
      51:	c3                   	ret    

00000052 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      52:	55                   	push   %ebp
      53:	89 e5                	mov    %esp,%ebp
      55:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      58:	8b 45 08             	mov    0x8(%ebp),%eax
      5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      5e:	90                   	nop
      5f:	8b 45 08             	mov    0x8(%ebp),%eax
      62:	8d 50 01             	lea    0x1(%eax),%edx
      65:	89 55 08             	mov    %edx,0x8(%ebp)
      68:	8b 55 0c             	mov    0xc(%ebp),%edx
      6b:	8d 4a 01             	lea    0x1(%edx),%ecx
      6e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
      71:	0f b6 12             	movzbl (%edx),%edx
      74:	88 10                	mov    %dl,(%eax)
      76:	0f b6 00             	movzbl (%eax),%eax
      79:	84 c0                	test   %al,%al
      7b:	75 e2                	jne    5f <strcpy+0xd>
    ;
  return os;
      7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      80:	c9                   	leave  
      81:	c3                   	ret    

00000082 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      82:	55                   	push   %ebp
      83:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      85:	eb 08                	jmp    8f <strcmp+0xd>
    p++, q++;
      87:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      8b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
      8f:	8b 45 08             	mov    0x8(%ebp),%eax
      92:	0f b6 00             	movzbl (%eax),%eax
      95:	84 c0                	test   %al,%al
      97:	74 10                	je     a9 <strcmp+0x27>
      99:	8b 45 08             	mov    0x8(%ebp),%eax
      9c:	0f b6 10             	movzbl (%eax),%edx
      9f:	8b 45 0c             	mov    0xc(%ebp),%eax
      a2:	0f b6 00             	movzbl (%eax),%eax
      a5:	38 c2                	cmp    %al,%dl
      a7:	74 de                	je     87 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
      a9:	8b 45 08             	mov    0x8(%ebp),%eax
      ac:	0f b6 00             	movzbl (%eax),%eax
      af:	0f b6 d0             	movzbl %al,%edx
      b2:	8b 45 0c             	mov    0xc(%ebp),%eax
      b5:	0f b6 00             	movzbl (%eax),%eax
      b8:	0f b6 c0             	movzbl %al,%eax
      bb:	29 c2                	sub    %eax,%edx
      bd:	89 d0                	mov    %edx,%eax
}
      bf:	5d                   	pop    %ebp
      c0:	c3                   	ret    

000000c1 <strlen>:

uint
strlen(char *s)
{
      c1:	55                   	push   %ebp
      c2:	89 e5                	mov    %esp,%ebp
      c4:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
      c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
      ce:	eb 04                	jmp    d4 <strlen+0x13>
      d0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
      d4:	8b 55 fc             	mov    -0x4(%ebp),%edx
      d7:	8b 45 08             	mov    0x8(%ebp),%eax
      da:	01 d0                	add    %edx,%eax
      dc:	0f b6 00             	movzbl (%eax),%eax
      df:	84 c0                	test   %al,%al
      e1:	75 ed                	jne    d0 <strlen+0xf>
    ;
  return n;
      e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      e6:	c9                   	leave  
      e7:	c3                   	ret    

000000e8 <memset>:

void*
memset(void *dst, int c, uint n)
{
      e8:	55                   	push   %ebp
      e9:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
      eb:	8b 45 10             	mov    0x10(%ebp),%eax
      ee:	50                   	push   %eax
      ef:	ff 75 0c             	pushl  0xc(%ebp)
      f2:	ff 75 08             	pushl  0x8(%ebp)
      f5:	e8 32 ff ff ff       	call   2c <stosb>
      fa:	83 c4 0c             	add    $0xc,%esp
  return dst;
      fd:	8b 45 08             	mov    0x8(%ebp),%eax
}
     100:	c9                   	leave  
     101:	c3                   	ret    

00000102 <strchr>:

char*
strchr(const char *s, char c)
{
     102:	55                   	push   %ebp
     103:	89 e5                	mov    %esp,%ebp
     105:	83 ec 04             	sub    $0x4,%esp
     108:	8b 45 0c             	mov    0xc(%ebp),%eax
     10b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     10e:	eb 14                	jmp    124 <strchr+0x22>
    if(*s == c)
     110:	8b 45 08             	mov    0x8(%ebp),%eax
     113:	0f b6 00             	movzbl (%eax),%eax
     116:	3a 45 fc             	cmp    -0x4(%ebp),%al
     119:	75 05                	jne    120 <strchr+0x1e>
      return (char*)s;
     11b:	8b 45 08             	mov    0x8(%ebp),%eax
     11e:	eb 13                	jmp    133 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     120:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     124:	8b 45 08             	mov    0x8(%ebp),%eax
     127:	0f b6 00             	movzbl (%eax),%eax
     12a:	84 c0                	test   %al,%al
     12c:	75 e2                	jne    110 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     12e:	b8 00 00 00 00       	mov    $0x0,%eax
}
     133:	c9                   	leave  
     134:	c3                   	ret    

00000135 <gets>:

char*
gets(char *buf, int max)
{
     135:	55                   	push   %ebp
     136:	89 e5                	mov    %esp,%ebp
     138:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     13b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     142:	eb 42                	jmp    186 <gets+0x51>
    cc = read(0, &c, 1);
     144:	83 ec 04             	sub    $0x4,%esp
     147:	6a 01                	push   $0x1
     149:	8d 45 ef             	lea    -0x11(%ebp),%eax
     14c:	50                   	push   %eax
     14d:	6a 00                	push   $0x0
     14f:	e8 47 01 00 00       	call   29b <read>
     154:	83 c4 10             	add    $0x10,%esp
     157:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     15a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     15e:	7e 33                	jle    193 <gets+0x5e>
      break;
    buf[i++] = c;
     160:	8b 45 f4             	mov    -0xc(%ebp),%eax
     163:	8d 50 01             	lea    0x1(%eax),%edx
     166:	89 55 f4             	mov    %edx,-0xc(%ebp)
     169:	89 c2                	mov    %eax,%edx
     16b:	8b 45 08             	mov    0x8(%ebp),%eax
     16e:	01 c2                	add    %eax,%edx
     170:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     174:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     176:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     17a:	3c 0a                	cmp    $0xa,%al
     17c:	74 16                	je     194 <gets+0x5f>
     17e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     182:	3c 0d                	cmp    $0xd,%al
     184:	74 0e                	je     194 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     186:	8b 45 f4             	mov    -0xc(%ebp),%eax
     189:	83 c0 01             	add    $0x1,%eax
     18c:	3b 45 0c             	cmp    0xc(%ebp),%eax
     18f:	7c b3                	jl     144 <gets+0xf>
     191:	eb 01                	jmp    194 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     193:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     194:	8b 55 f4             	mov    -0xc(%ebp),%edx
     197:	8b 45 08             	mov    0x8(%ebp),%eax
     19a:	01 d0                	add    %edx,%eax
     19c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     19f:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1a2:	c9                   	leave  
     1a3:	c3                   	ret    

000001a4 <stat>:

int
stat(char *n, struct stat *st)
{
     1a4:	55                   	push   %ebp
     1a5:	89 e5                	mov    %esp,%ebp
     1a7:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     1aa:	83 ec 08             	sub    $0x8,%esp
     1ad:	6a 00                	push   $0x0
     1af:	ff 75 08             	pushl  0x8(%ebp)
     1b2:	e8 0c 01 00 00       	call   2c3 <open>
     1b7:	83 c4 10             	add    $0x10,%esp
     1ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     1bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     1c1:	79 07                	jns    1ca <stat+0x26>
    return -1;
     1c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     1c8:	eb 25                	jmp    1ef <stat+0x4b>
  r = fstat(fd, st);
     1ca:	83 ec 08             	sub    $0x8,%esp
     1cd:	ff 75 0c             	pushl  0xc(%ebp)
     1d0:	ff 75 f4             	pushl  -0xc(%ebp)
     1d3:	e8 03 01 00 00       	call   2db <fstat>
     1d8:	83 c4 10             	add    $0x10,%esp
     1db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     1de:	83 ec 0c             	sub    $0xc,%esp
     1e1:	ff 75 f4             	pushl  -0xc(%ebp)
     1e4:	e8 c2 00 00 00       	call   2ab <close>
     1e9:	83 c4 10             	add    $0x10,%esp
  return r;
     1ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     1ef:	c9                   	leave  
     1f0:	c3                   	ret    

000001f1 <atoi>:

int
atoi(const char *s)
{
     1f1:	55                   	push   %ebp
     1f2:	89 e5                	mov    %esp,%ebp
     1f4:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     1f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     1fe:	eb 25                	jmp    225 <atoi+0x34>
    n = n*10 + *s++ - '0';
     200:	8b 55 fc             	mov    -0x4(%ebp),%edx
     203:	89 d0                	mov    %edx,%eax
     205:	c1 e0 02             	shl    $0x2,%eax
     208:	01 d0                	add    %edx,%eax
     20a:	01 c0                	add    %eax,%eax
     20c:	89 c1                	mov    %eax,%ecx
     20e:	8b 45 08             	mov    0x8(%ebp),%eax
     211:	8d 50 01             	lea    0x1(%eax),%edx
     214:	89 55 08             	mov    %edx,0x8(%ebp)
     217:	0f b6 00             	movzbl (%eax),%eax
     21a:	0f be c0             	movsbl %al,%eax
     21d:	01 c8                	add    %ecx,%eax
     21f:	83 e8 30             	sub    $0x30,%eax
     222:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     225:	8b 45 08             	mov    0x8(%ebp),%eax
     228:	0f b6 00             	movzbl (%eax),%eax
     22b:	3c 2f                	cmp    $0x2f,%al
     22d:	7e 0a                	jle    239 <atoi+0x48>
     22f:	8b 45 08             	mov    0x8(%ebp),%eax
     232:	0f b6 00             	movzbl (%eax),%eax
     235:	3c 39                	cmp    $0x39,%al
     237:	7e c7                	jle    200 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     239:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     23c:	c9                   	leave  
     23d:	c3                   	ret    

0000023e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     23e:	55                   	push   %ebp
     23f:	89 e5                	mov    %esp,%ebp
     241:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     244:	8b 45 08             	mov    0x8(%ebp),%eax
     247:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     24a:	8b 45 0c             	mov    0xc(%ebp),%eax
     24d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     250:	eb 17                	jmp    269 <memmove+0x2b>
    *dst++ = *src++;
     252:	8b 45 fc             	mov    -0x4(%ebp),%eax
     255:	8d 50 01             	lea    0x1(%eax),%edx
     258:	89 55 fc             	mov    %edx,-0x4(%ebp)
     25b:	8b 55 f8             	mov    -0x8(%ebp),%edx
     25e:	8d 4a 01             	lea    0x1(%edx),%ecx
     261:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     264:	0f b6 12             	movzbl (%edx),%edx
     267:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     269:	8b 45 10             	mov    0x10(%ebp),%eax
     26c:	8d 50 ff             	lea    -0x1(%eax),%edx
     26f:	89 55 10             	mov    %edx,0x10(%ebp)
     272:	85 c0                	test   %eax,%eax
     274:	7f dc                	jg     252 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     276:	8b 45 08             	mov    0x8(%ebp),%eax
}
     279:	c9                   	leave  
     27a:	c3                   	ret    

0000027b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     27b:	b8 01 00 00 00       	mov    $0x1,%eax
     280:	cd 40                	int    $0x40
     282:	c3                   	ret    

00000283 <exit>:
SYSCALL(exit)
     283:	b8 02 00 00 00       	mov    $0x2,%eax
     288:	cd 40                	int    $0x40
     28a:	c3                   	ret    

0000028b <wait>:
SYSCALL(wait)
     28b:	b8 03 00 00 00       	mov    $0x3,%eax
     290:	cd 40                	int    $0x40
     292:	c3                   	ret    

00000293 <pipe>:
SYSCALL(pipe)
     293:	b8 04 00 00 00       	mov    $0x4,%eax
     298:	cd 40                	int    $0x40
     29a:	c3                   	ret    

0000029b <read>:
SYSCALL(read)
     29b:	b8 05 00 00 00       	mov    $0x5,%eax
     2a0:	cd 40                	int    $0x40
     2a2:	c3                   	ret    

000002a3 <write>:
SYSCALL(write)
     2a3:	b8 10 00 00 00       	mov    $0x10,%eax
     2a8:	cd 40                	int    $0x40
     2aa:	c3                   	ret    

000002ab <close>:
SYSCALL(close)
     2ab:	b8 15 00 00 00       	mov    $0x15,%eax
     2b0:	cd 40                	int    $0x40
     2b2:	c3                   	ret    

000002b3 <kill>:
SYSCALL(kill)
     2b3:	b8 06 00 00 00       	mov    $0x6,%eax
     2b8:	cd 40                	int    $0x40
     2ba:	c3                   	ret    

000002bb <exec>:
SYSCALL(exec)
     2bb:	b8 07 00 00 00       	mov    $0x7,%eax
     2c0:	cd 40                	int    $0x40
     2c2:	c3                   	ret    

000002c3 <open>:
SYSCALL(open)
     2c3:	b8 0f 00 00 00       	mov    $0xf,%eax
     2c8:	cd 40                	int    $0x40
     2ca:	c3                   	ret    

000002cb <mknod>:
SYSCALL(mknod)
     2cb:	b8 11 00 00 00       	mov    $0x11,%eax
     2d0:	cd 40                	int    $0x40
     2d2:	c3                   	ret    

000002d3 <unlink>:
SYSCALL(unlink)
     2d3:	b8 12 00 00 00       	mov    $0x12,%eax
     2d8:	cd 40                	int    $0x40
     2da:	c3                   	ret    

000002db <fstat>:
SYSCALL(fstat)
     2db:	b8 08 00 00 00       	mov    $0x8,%eax
     2e0:	cd 40                	int    $0x40
     2e2:	c3                   	ret    

000002e3 <link>:
SYSCALL(link)
     2e3:	b8 13 00 00 00       	mov    $0x13,%eax
     2e8:	cd 40                	int    $0x40
     2ea:	c3                   	ret    

000002eb <mkdir>:
SYSCALL(mkdir)
     2eb:	b8 14 00 00 00       	mov    $0x14,%eax
     2f0:	cd 40                	int    $0x40
     2f2:	c3                   	ret    

000002f3 <chdir>:
SYSCALL(chdir)
     2f3:	b8 09 00 00 00       	mov    $0x9,%eax
     2f8:	cd 40                	int    $0x40
     2fa:	c3                   	ret    

000002fb <dup>:
SYSCALL(dup)
     2fb:	b8 0a 00 00 00       	mov    $0xa,%eax
     300:	cd 40                	int    $0x40
     302:	c3                   	ret    

00000303 <getpid>:
SYSCALL(getpid)
     303:	b8 0b 00 00 00       	mov    $0xb,%eax
     308:	cd 40                	int    $0x40
     30a:	c3                   	ret    

0000030b <sbrk>:
SYSCALL(sbrk)
     30b:	b8 0c 00 00 00       	mov    $0xc,%eax
     310:	cd 40                	int    $0x40
     312:	c3                   	ret    

00000313 <sleep>:
SYSCALL(sleep)
     313:	b8 0d 00 00 00       	mov    $0xd,%eax
     318:	cd 40                	int    $0x40
     31a:	c3                   	ret    

0000031b <uptime>:
SYSCALL(uptime)
     31b:	b8 0e 00 00 00       	mov    $0xe,%eax
     320:	cd 40                	int    $0x40
     322:	c3                   	ret    

00000323 <paintWindow>:

SYSCALL(paintWindow)
     323:	b8 16 00 00 00       	mov    $0x16,%eax
     328:	cd 40                	int    $0x40
     32a:	c3                   	ret    

0000032b <initStringFigure>:
SYSCALL(initStringFigure)
     32b:	b8 17 00 00 00       	mov    $0x17,%eax
     330:	cd 40                	int    $0x40
     332:	c3                   	ret    

00000333 <sendMessage>:
SYSCALL(sendMessage)
     333:	b8 18 00 00 00       	mov    $0x18,%eax
     338:	cd 40                	int    $0x40
     33a:	c3                   	ret    

0000033b <getMessage>:
SYSCALL(getMessage)
     33b:	b8 1a 00 00 00       	mov    $0x1a,%eax
     340:	cd 40                	int    $0x40
     342:	c3                   	ret    

00000343 <registWindow>:
SYSCALL(registWindow)
     343:	b8 19 00 00 00       	mov    $0x19,%eax
     348:	cd 40                	int    $0x40
     34a:	c3                   	ret    

0000034b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     34b:	55                   	push   %ebp
     34c:	89 e5                	mov    %esp,%ebp
     34e:	83 ec 18             	sub    $0x18,%esp
     351:	8b 45 0c             	mov    0xc(%ebp),%eax
     354:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     357:	83 ec 04             	sub    $0x4,%esp
     35a:	6a 01                	push   $0x1
     35c:	8d 45 f4             	lea    -0xc(%ebp),%eax
     35f:	50                   	push   %eax
     360:	ff 75 08             	pushl  0x8(%ebp)
     363:	e8 3b ff ff ff       	call   2a3 <write>
     368:	83 c4 10             	add    $0x10,%esp
}
     36b:	90                   	nop
     36c:	c9                   	leave  
     36d:	c3                   	ret    

0000036e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     36e:	55                   	push   %ebp
     36f:	89 e5                	mov    %esp,%ebp
     371:	53                   	push   %ebx
     372:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     375:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     37c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     380:	74 17                	je     399 <printint+0x2b>
     382:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     386:	79 11                	jns    399 <printint+0x2b>
    neg = 1;
     388:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     38f:	8b 45 0c             	mov    0xc(%ebp),%eax
     392:	f7 d8                	neg    %eax
     394:	89 45 ec             	mov    %eax,-0x14(%ebp)
     397:	eb 06                	jmp    39f <printint+0x31>
  } else {
    x = xx;
     399:	8b 45 0c             	mov    0xc(%ebp),%eax
     39c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     39f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3a6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3a9:	8d 41 01             	lea    0x1(%ecx),%eax
     3ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3af:	8b 5d 10             	mov    0x10(%ebp),%ebx
     3b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3b5:	ba 00 00 00 00       	mov    $0x0,%edx
     3ba:	f7 f3                	div    %ebx
     3bc:	89 d0                	mov    %edx,%eax
     3be:	0f b6 80 f0 26 00 00 	movzbl 0x26f0(%eax),%eax
     3c5:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     3c9:	8b 5d 10             	mov    0x10(%ebp),%ebx
     3cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3cf:	ba 00 00 00 00       	mov    $0x0,%edx
     3d4:	f7 f3                	div    %ebx
     3d6:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3d9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     3dd:	75 c7                	jne    3a6 <printint+0x38>
  if(neg)
     3df:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3e3:	74 2d                	je     412 <printint+0xa4>
    buf[i++] = '-';
     3e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3e8:	8d 50 01             	lea    0x1(%eax),%edx
     3eb:	89 55 f4             	mov    %edx,-0xc(%ebp)
     3ee:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     3f3:	eb 1d                	jmp    412 <printint+0xa4>
    putc(fd, buf[i]);
     3f5:	8d 55 dc             	lea    -0x24(%ebp),%edx
     3f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3fb:	01 d0                	add    %edx,%eax
     3fd:	0f b6 00             	movzbl (%eax),%eax
     400:	0f be c0             	movsbl %al,%eax
     403:	83 ec 08             	sub    $0x8,%esp
     406:	50                   	push   %eax
     407:	ff 75 08             	pushl  0x8(%ebp)
     40a:	e8 3c ff ff ff       	call   34b <putc>
     40f:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     412:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     416:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     41a:	79 d9                	jns    3f5 <printint+0x87>
    putc(fd, buf[i]);
}
     41c:	90                   	nop
     41d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     420:	c9                   	leave  
     421:	c3                   	ret    

00000422 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     422:	55                   	push   %ebp
     423:	89 e5                	mov    %esp,%ebp
     425:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     428:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     42f:	8d 45 0c             	lea    0xc(%ebp),%eax
     432:	83 c0 04             	add    $0x4,%eax
     435:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     438:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     43f:	e9 59 01 00 00       	jmp    59d <printf+0x17b>
    c = fmt[i] & 0xff;
     444:	8b 55 0c             	mov    0xc(%ebp),%edx
     447:	8b 45 f0             	mov    -0x10(%ebp),%eax
     44a:	01 d0                	add    %edx,%eax
     44c:	0f b6 00             	movzbl (%eax),%eax
     44f:	0f be c0             	movsbl %al,%eax
     452:	25 ff 00 00 00       	and    $0xff,%eax
     457:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     45a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     45e:	75 2c                	jne    48c <printf+0x6a>
      if(c == '%'){
     460:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     464:	75 0c                	jne    472 <printf+0x50>
        state = '%';
     466:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     46d:	e9 27 01 00 00       	jmp    599 <printf+0x177>
      } else {
        putc(fd, c);
     472:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     475:	0f be c0             	movsbl %al,%eax
     478:	83 ec 08             	sub    $0x8,%esp
     47b:	50                   	push   %eax
     47c:	ff 75 08             	pushl  0x8(%ebp)
     47f:	e8 c7 fe ff ff       	call   34b <putc>
     484:	83 c4 10             	add    $0x10,%esp
     487:	e9 0d 01 00 00       	jmp    599 <printf+0x177>
      }
    } else if(state == '%'){
     48c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     490:	0f 85 03 01 00 00    	jne    599 <printf+0x177>
      if(c == 'd'){
     496:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     49a:	75 1e                	jne    4ba <printf+0x98>
        printint(fd, *ap, 10, 1);
     49c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     49f:	8b 00                	mov    (%eax),%eax
     4a1:	6a 01                	push   $0x1
     4a3:	6a 0a                	push   $0xa
     4a5:	50                   	push   %eax
     4a6:	ff 75 08             	pushl  0x8(%ebp)
     4a9:	e8 c0 fe ff ff       	call   36e <printint>
     4ae:	83 c4 10             	add    $0x10,%esp
        ap++;
     4b1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4b5:	e9 d8 00 00 00       	jmp    592 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     4ba:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     4be:	74 06                	je     4c6 <printf+0xa4>
     4c0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     4c4:	75 1e                	jne    4e4 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     4c6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4c9:	8b 00                	mov    (%eax),%eax
     4cb:	6a 00                	push   $0x0
     4cd:	6a 10                	push   $0x10
     4cf:	50                   	push   %eax
     4d0:	ff 75 08             	pushl  0x8(%ebp)
     4d3:	e8 96 fe ff ff       	call   36e <printint>
     4d8:	83 c4 10             	add    $0x10,%esp
        ap++;
     4db:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4df:	e9 ae 00 00 00       	jmp    592 <printf+0x170>
      } else if(c == 's'){
     4e4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     4e8:	75 43                	jne    52d <printf+0x10b>
        s = (char*)*ap;
     4ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4ed:	8b 00                	mov    (%eax),%eax
     4ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     4f2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     4f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4fa:	75 25                	jne    521 <printf+0xff>
          s = "(null)";
     4fc:	c7 45 f4 68 20 00 00 	movl   $0x2068,-0xc(%ebp)
        while(*s != 0){
     503:	eb 1c                	jmp    521 <printf+0xff>
          putc(fd, *s);
     505:	8b 45 f4             	mov    -0xc(%ebp),%eax
     508:	0f b6 00             	movzbl (%eax),%eax
     50b:	0f be c0             	movsbl %al,%eax
     50e:	83 ec 08             	sub    $0x8,%esp
     511:	50                   	push   %eax
     512:	ff 75 08             	pushl  0x8(%ebp)
     515:	e8 31 fe ff ff       	call   34b <putc>
     51a:	83 c4 10             	add    $0x10,%esp
          s++;
     51d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     521:	8b 45 f4             	mov    -0xc(%ebp),%eax
     524:	0f b6 00             	movzbl (%eax),%eax
     527:	84 c0                	test   %al,%al
     529:	75 da                	jne    505 <printf+0xe3>
     52b:	eb 65                	jmp    592 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     52d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     531:	75 1d                	jne    550 <printf+0x12e>
        putc(fd, *ap);
     533:	8b 45 e8             	mov    -0x18(%ebp),%eax
     536:	8b 00                	mov    (%eax),%eax
     538:	0f be c0             	movsbl %al,%eax
     53b:	83 ec 08             	sub    $0x8,%esp
     53e:	50                   	push   %eax
     53f:	ff 75 08             	pushl  0x8(%ebp)
     542:	e8 04 fe ff ff       	call   34b <putc>
     547:	83 c4 10             	add    $0x10,%esp
        ap++;
     54a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     54e:	eb 42                	jmp    592 <printf+0x170>
      } else if(c == '%'){
     550:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     554:	75 17                	jne    56d <printf+0x14b>
        putc(fd, c);
     556:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     559:	0f be c0             	movsbl %al,%eax
     55c:	83 ec 08             	sub    $0x8,%esp
     55f:	50                   	push   %eax
     560:	ff 75 08             	pushl  0x8(%ebp)
     563:	e8 e3 fd ff ff       	call   34b <putc>
     568:	83 c4 10             	add    $0x10,%esp
     56b:	eb 25                	jmp    592 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     56d:	83 ec 08             	sub    $0x8,%esp
     570:	6a 25                	push   $0x25
     572:	ff 75 08             	pushl  0x8(%ebp)
     575:	e8 d1 fd ff ff       	call   34b <putc>
     57a:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     57d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     580:	0f be c0             	movsbl %al,%eax
     583:	83 ec 08             	sub    $0x8,%esp
     586:	50                   	push   %eax
     587:	ff 75 08             	pushl  0x8(%ebp)
     58a:	e8 bc fd ff ff       	call   34b <putc>
     58f:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     592:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     599:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     59d:	8b 55 0c             	mov    0xc(%ebp),%edx
     5a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5a3:	01 d0                	add    %edx,%eax
     5a5:	0f b6 00             	movzbl (%eax),%eax
     5a8:	84 c0                	test   %al,%al
     5aa:	0f 85 94 fe ff ff    	jne    444 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     5b0:	90                   	nop
     5b1:	c9                   	leave  
     5b2:	c3                   	ret    

000005b3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     5b3:	55                   	push   %ebp
     5b4:	89 e5                	mov    %esp,%ebp
     5b6:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     5b9:	8b 45 08             	mov    0x8(%ebp),%eax
     5bc:	83 e8 08             	sub    $0x8,%eax
     5bf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     5c2:	a1 20 27 00 00       	mov    0x2720,%eax
     5c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
     5ca:	eb 24                	jmp    5f0 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     5cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5cf:	8b 00                	mov    (%eax),%eax
     5d1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     5d4:	77 12                	ja     5e8 <free+0x35>
     5d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     5d9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     5dc:	77 24                	ja     602 <free+0x4f>
     5de:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5e1:	8b 00                	mov    (%eax),%eax
     5e3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     5e6:	77 1a                	ja     602 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     5e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5eb:	8b 00                	mov    (%eax),%eax
     5ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
     5f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     5f3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     5f6:	76 d4                	jbe    5cc <free+0x19>
     5f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5fb:	8b 00                	mov    (%eax),%eax
     5fd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     600:	76 ca                	jbe    5cc <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     602:	8b 45 f8             	mov    -0x8(%ebp),%eax
     605:	8b 40 04             	mov    0x4(%eax),%eax
     608:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     60f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     612:	01 c2                	add    %eax,%edx
     614:	8b 45 fc             	mov    -0x4(%ebp),%eax
     617:	8b 00                	mov    (%eax),%eax
     619:	39 c2                	cmp    %eax,%edx
     61b:	75 24                	jne    641 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     61d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     620:	8b 50 04             	mov    0x4(%eax),%edx
     623:	8b 45 fc             	mov    -0x4(%ebp),%eax
     626:	8b 00                	mov    (%eax),%eax
     628:	8b 40 04             	mov    0x4(%eax),%eax
     62b:	01 c2                	add    %eax,%edx
     62d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     630:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     633:	8b 45 fc             	mov    -0x4(%ebp),%eax
     636:	8b 00                	mov    (%eax),%eax
     638:	8b 10                	mov    (%eax),%edx
     63a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     63d:	89 10                	mov    %edx,(%eax)
     63f:	eb 0a                	jmp    64b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     641:	8b 45 fc             	mov    -0x4(%ebp),%eax
     644:	8b 10                	mov    (%eax),%edx
     646:	8b 45 f8             	mov    -0x8(%ebp),%eax
     649:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     64b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     64e:	8b 40 04             	mov    0x4(%eax),%eax
     651:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     658:	8b 45 fc             	mov    -0x4(%ebp),%eax
     65b:	01 d0                	add    %edx,%eax
     65d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     660:	75 20                	jne    682 <free+0xcf>
    p->s.size += bp->s.size;
     662:	8b 45 fc             	mov    -0x4(%ebp),%eax
     665:	8b 50 04             	mov    0x4(%eax),%edx
     668:	8b 45 f8             	mov    -0x8(%ebp),%eax
     66b:	8b 40 04             	mov    0x4(%eax),%eax
     66e:	01 c2                	add    %eax,%edx
     670:	8b 45 fc             	mov    -0x4(%ebp),%eax
     673:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     676:	8b 45 f8             	mov    -0x8(%ebp),%eax
     679:	8b 10                	mov    (%eax),%edx
     67b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67e:	89 10                	mov    %edx,(%eax)
     680:	eb 08                	jmp    68a <free+0xd7>
  } else
    p->s.ptr = bp;
     682:	8b 45 fc             	mov    -0x4(%ebp),%eax
     685:	8b 55 f8             	mov    -0x8(%ebp),%edx
     688:	89 10                	mov    %edx,(%eax)
  freep = p;
     68a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68d:	a3 20 27 00 00       	mov    %eax,0x2720
}
     692:	90                   	nop
     693:	c9                   	leave  
     694:	c3                   	ret    

00000695 <morecore>:

static Header*
morecore(uint nu)
{
     695:	55                   	push   %ebp
     696:	89 e5                	mov    %esp,%ebp
     698:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     69b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6a2:	77 07                	ja     6ab <morecore+0x16>
    nu = 4096;
     6a4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     6ab:	8b 45 08             	mov    0x8(%ebp),%eax
     6ae:	c1 e0 03             	shl    $0x3,%eax
     6b1:	83 ec 0c             	sub    $0xc,%esp
     6b4:	50                   	push   %eax
     6b5:	e8 51 fc ff ff       	call   30b <sbrk>
     6ba:	83 c4 10             	add    $0x10,%esp
     6bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     6c0:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     6c4:	75 07                	jne    6cd <morecore+0x38>
    return 0;
     6c6:	b8 00 00 00 00       	mov    $0x0,%eax
     6cb:	eb 26                	jmp    6f3 <morecore+0x5e>
  hp = (Header*)p;
     6cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     6d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6d6:	8b 55 08             	mov    0x8(%ebp),%edx
     6d9:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     6dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6df:	83 c0 08             	add    $0x8,%eax
     6e2:	83 ec 0c             	sub    $0xc,%esp
     6e5:	50                   	push   %eax
     6e6:	e8 c8 fe ff ff       	call   5b3 <free>
     6eb:	83 c4 10             	add    $0x10,%esp
  return freep;
     6ee:	a1 20 27 00 00       	mov    0x2720,%eax
}
     6f3:	c9                   	leave  
     6f4:	c3                   	ret    

000006f5 <malloc>:

void*
malloc(uint nbytes)
{
     6f5:	55                   	push   %ebp
     6f6:	89 e5                	mov    %esp,%ebp
     6f8:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     6fb:	8b 45 08             	mov    0x8(%ebp),%eax
     6fe:	83 c0 07             	add    $0x7,%eax
     701:	c1 e8 03             	shr    $0x3,%eax
     704:	83 c0 01             	add    $0x1,%eax
     707:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     70a:	a1 20 27 00 00       	mov    0x2720,%eax
     70f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     712:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     716:	75 23                	jne    73b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     718:	c7 45 f0 18 27 00 00 	movl   $0x2718,-0x10(%ebp)
     71f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     722:	a3 20 27 00 00       	mov    %eax,0x2720
     727:	a1 20 27 00 00       	mov    0x2720,%eax
     72c:	a3 18 27 00 00       	mov    %eax,0x2718
    base.s.size = 0;
     731:	c7 05 1c 27 00 00 00 	movl   $0x0,0x271c
     738:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     73b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     73e:	8b 00                	mov    (%eax),%eax
     740:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     743:	8b 45 f4             	mov    -0xc(%ebp),%eax
     746:	8b 40 04             	mov    0x4(%eax),%eax
     749:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     74c:	72 4d                	jb     79b <malloc+0xa6>
      if(p->s.size == nunits)
     74e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     751:	8b 40 04             	mov    0x4(%eax),%eax
     754:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     757:	75 0c                	jne    765 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     759:	8b 45 f4             	mov    -0xc(%ebp),%eax
     75c:	8b 10                	mov    (%eax),%edx
     75e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     761:	89 10                	mov    %edx,(%eax)
     763:	eb 26                	jmp    78b <malloc+0x96>
      else {
        p->s.size -= nunits;
     765:	8b 45 f4             	mov    -0xc(%ebp),%eax
     768:	8b 40 04             	mov    0x4(%eax),%eax
     76b:	2b 45 ec             	sub    -0x14(%ebp),%eax
     76e:	89 c2                	mov    %eax,%edx
     770:	8b 45 f4             	mov    -0xc(%ebp),%eax
     773:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     776:	8b 45 f4             	mov    -0xc(%ebp),%eax
     779:	8b 40 04             	mov    0x4(%eax),%eax
     77c:	c1 e0 03             	shl    $0x3,%eax
     77f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     782:	8b 45 f4             	mov    -0xc(%ebp),%eax
     785:	8b 55 ec             	mov    -0x14(%ebp),%edx
     788:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     78b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     78e:	a3 20 27 00 00       	mov    %eax,0x2720
      return (void*)(p + 1);
     793:	8b 45 f4             	mov    -0xc(%ebp),%eax
     796:	83 c0 08             	add    $0x8,%eax
     799:	eb 3b                	jmp    7d6 <malloc+0xe1>
    }
    if(p == freep)
     79b:	a1 20 27 00 00       	mov    0x2720,%eax
     7a0:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7a3:	75 1e                	jne    7c3 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7a5:	83 ec 0c             	sub    $0xc,%esp
     7a8:	ff 75 ec             	pushl  -0x14(%ebp)
     7ab:	e8 e5 fe ff ff       	call   695 <morecore>
     7b0:	83 c4 10             	add    $0x10,%esp
     7b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
     7b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7ba:	75 07                	jne    7c3 <malloc+0xce>
        return 0;
     7bc:	b8 00 00 00 00       	mov    $0x0,%eax
     7c1:	eb 13                	jmp    7d6 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7cc:	8b 00                	mov    (%eax),%eax
     7ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     7d1:	e9 6d ff ff ff       	jmp    743 <malloc+0x4e>
}
     7d6:	c9                   	leave  
     7d7:	c3                   	ret    

000007d8 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     7d8:	55                   	push   %ebp
     7d9:	89 e5                	mov    %esp,%ebp
     7db:	83 ec 1c             	sub    $0x1c,%esp
     7de:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     7e1:	8b 55 10             	mov    0x10(%ebp),%edx
     7e4:	8b 45 14             	mov    0x14(%ebp),%eax
     7e7:	88 4d ec             	mov    %cl,-0x14(%ebp)
     7ea:	88 55 e8             	mov    %dl,-0x18(%ebp)
     7ed:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     7f0:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     7f4:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     7f7:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     7fb:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     7fe:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     802:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     805:	8b 45 08             	mov    0x8(%ebp),%eax
     808:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     80c:	66 89 10             	mov    %dx,(%eax)
     80f:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     813:	88 50 02             	mov    %dl,0x2(%eax)
}
     816:	8b 45 08             	mov    0x8(%ebp),%eax
     819:	c9                   	leave  
     81a:	c2 04 00             	ret    $0x4

0000081d <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     81d:	55                   	push   %ebp
     81e:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     820:	8b 45 08             	mov    0x8(%ebp),%eax
     823:	2b 45 10             	sub    0x10(%ebp),%eax
     826:	89 c2                	mov    %eax,%edx
     828:	8b 45 08             	mov    0x8(%ebp),%eax
     82b:	2b 45 10             	sub    0x10(%ebp),%eax
     82e:	0f af d0             	imul   %eax,%edx
     831:	8b 45 0c             	mov    0xc(%ebp),%eax
     834:	2b 45 14             	sub    0x14(%ebp),%eax
     837:	89 c1                	mov    %eax,%ecx
     839:	8b 45 0c             	mov    0xc(%ebp),%eax
     83c:	2b 45 14             	sub    0x14(%ebp),%eax
     83f:	0f af c1             	imul   %ecx,%eax
     842:	01 d0                	add    %edx,%eax
}
     844:	5d                   	pop    %ebp
     845:	c3                   	ret    

00000846 <abs_int>:

static inline int abs_int(int x)
{
     846:	55                   	push   %ebp
     847:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     849:	8b 45 08             	mov    0x8(%ebp),%eax
     84c:	99                   	cltd   
     84d:	89 d0                	mov    %edx,%eax
     84f:	33 45 08             	xor    0x8(%ebp),%eax
     852:	29 d0                	sub    %edx,%eax
}
     854:	5d                   	pop    %ebp
     855:	c3                   	ret    

00000856 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     856:	55                   	push   %ebp
     857:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     859:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     85d:	79 07                	jns    866 <APGetIndex+0x10>
        return X_SMALLER;
     85f:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     864:	eb 40                	jmp    8a6 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     866:	8b 45 08             	mov    0x8(%ebp),%eax
     869:	8b 00                	mov    (%eax),%eax
     86b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     86e:	7f 07                	jg     877 <APGetIndex+0x21>
        return X_BIGGER;
     870:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     875:	eb 2f                	jmp    8a6 <APGetIndex+0x50>
    if (y < 0)
     877:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     87b:	79 07                	jns    884 <APGetIndex+0x2e>
        return Y_SMALLER;
     87d:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     882:	eb 22                	jmp    8a6 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     884:	8b 45 08             	mov    0x8(%ebp),%eax
     887:	8b 40 04             	mov    0x4(%eax),%eax
     88a:	3b 45 10             	cmp    0x10(%ebp),%eax
     88d:	7f 07                	jg     896 <APGetIndex+0x40>
        return Y_BIGGER;
     88f:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     894:	eb 10                	jmp    8a6 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     896:	8b 45 08             	mov    0x8(%ebp),%eax
     899:	8b 00                	mov    (%eax),%eax
     89b:	0f af 45 10          	imul   0x10(%ebp),%eax
     89f:	89 c2                	mov    %eax,%edx
     8a1:	8b 45 0c             	mov    0xc(%ebp),%eax
     8a4:	01 d0                	add    %edx,%eax
}
     8a6:	5d                   	pop    %ebp
     8a7:	c3                   	ret    

000008a8 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     8a8:	55                   	push   %ebp
     8a9:	89 e5                	mov    %esp,%ebp
     8ab:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     8ae:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     8b5:	8b 45 cc             	mov    -0x34(%ebp),%eax
     8b8:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     8bb:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     8c2:	83 ec 08             	sub    $0x8,%esp
     8c5:	6a 00                	push   $0x0
     8c7:	ff 75 0c             	pushl  0xc(%ebp)
     8ca:	e8 f4 f9 ff ff       	call   2c3 <open>
     8cf:	83 c4 10             	add    $0x10,%esp
     8d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     8d5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     8d9:	79 2e                	jns    909 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     8db:	83 ec 04             	sub    $0x4,%esp
     8de:	ff 75 0c             	pushl  0xc(%ebp)
     8e1:	68 6f 20 00 00       	push   $0x206f
     8e6:	6a 01                	push   $0x1
     8e8:	e8 35 fb ff ff       	call   422 <printf>
     8ed:	83 c4 10             	add    $0x10,%esp
        return bmp;
     8f0:	8b 45 08             	mov    0x8(%ebp),%eax
     8f3:	8b 55 c8             	mov    -0x38(%ebp),%edx
     8f6:	89 10                	mov    %edx,(%eax)
     8f8:	8b 55 cc             	mov    -0x34(%ebp),%edx
     8fb:	89 50 04             	mov    %edx,0x4(%eax)
     8fe:	8b 55 d0             	mov    -0x30(%ebp),%edx
     901:	89 50 08             	mov    %edx,0x8(%eax)
     904:	e9 d2 01 00 00       	jmp    adb <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     909:	83 ec 04             	sub    $0x4,%esp
     90c:	6a 0e                	push   $0xe
     90e:	8d 45 ba             	lea    -0x46(%ebp),%eax
     911:	50                   	push   %eax
     912:	ff 75 ec             	pushl  -0x14(%ebp)
     915:	e8 81 f9 ff ff       	call   29b <read>
     91a:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     91d:	83 ec 04             	sub    $0x4,%esp
     920:	6a 28                	push   $0x28
     922:	8d 45 92             	lea    -0x6e(%ebp),%eax
     925:	50                   	push   %eax
     926:	ff 75 ec             	pushl  -0x14(%ebp)
     929:	e8 6d f9 ff ff       	call   29b <read>
     92e:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     931:	8b 45 96             	mov    -0x6a(%ebp),%eax
     934:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     937:	8b 45 9a             	mov    -0x66(%ebp),%eax
     93a:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     93d:	8b 55 c8             	mov    -0x38(%ebp),%edx
     940:	8b 45 cc             	mov    -0x34(%ebp),%eax
     943:	0f af d0             	imul   %eax,%edx
     946:	89 d0                	mov    %edx,%eax
     948:	01 c0                	add    %eax,%eax
     94a:	01 d0                	add    %edx,%eax
     94c:	83 ec 0c             	sub    $0xc,%esp
     94f:	50                   	push   %eax
     950:	e8 a0 fd ff ff       	call   6f5 <malloc>
     955:	83 c4 10             	add    $0x10,%esp
     958:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     95b:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     95f:	0f b7 c0             	movzwl %ax,%eax
     962:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     965:	8b 55 c8             	mov    -0x38(%ebp),%edx
     968:	8b 45 e8             	mov    -0x18(%ebp),%eax
     96b:	0f af c2             	imul   %edx,%eax
     96e:	83 c0 1f             	add    $0x1f,%eax
     971:	c1 e8 05             	shr    $0x5,%eax
     974:	c1 e0 02             	shl    $0x2,%eax
     977:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     97a:	8b 55 cc             	mov    -0x34(%ebp),%edx
     97d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     980:	0f af c2             	imul   %edx,%eax
     983:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     986:	8b 45 e0             	mov    -0x20(%ebp),%eax
     989:	83 ec 0c             	sub    $0xc,%esp
     98c:	50                   	push   %eax
     98d:	e8 63 fd ff ff       	call   6f5 <malloc>
     992:	83 c4 10             	add    $0x10,%esp
     995:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     998:	83 ec 04             	sub    $0x4,%esp
     99b:	ff 75 e0             	pushl  -0x20(%ebp)
     99e:	ff 75 dc             	pushl  -0x24(%ebp)
     9a1:	ff 75 ec             	pushl  -0x14(%ebp)
     9a4:	e8 f2 f8 ff ff       	call   29b <read>
     9a9:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     9ac:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9b0:	66 c1 e8 03          	shr    $0x3,%ax
     9b4:	0f b7 c0             	movzwl %ax,%eax
     9b7:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     9ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     9c1:	e9 e5 00 00 00       	jmp    aab <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     9c6:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9cc:	29 c2                	sub    %eax,%edx
     9ce:	89 d0                	mov    %edx,%eax
     9d0:	8d 50 ff             	lea    -0x1(%eax),%edx
     9d3:	8b 45 c8             	mov    -0x38(%ebp),%eax
     9d6:	0f af c2             	imul   %edx,%eax
     9d9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     9dc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     9e3:	e9 b1 00 00 00       	jmp    a99 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     9e8:	8b 55 d0             	mov    -0x30(%ebp),%edx
     9eb:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     9ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9f1:	01 c8                	add    %ecx,%eax
     9f3:	89 c1                	mov    %eax,%ecx
     9f5:	89 c8                	mov    %ecx,%eax
     9f7:	01 c0                	add    %eax,%eax
     9f9:	01 c8                	add    %ecx,%eax
     9fb:	01 c2                	add    %eax,%edx
     9fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a00:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a04:	89 c1                	mov    %eax,%ecx
     a06:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a09:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a0d:	01 c1                	add    %eax,%ecx
     a0f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a12:	01 c8                	add    %ecx,%eax
     a14:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a17:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a1a:	01 c8                	add    %ecx,%eax
     a1c:	0f b6 00             	movzbl (%eax),%eax
     a1f:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a22:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a25:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a28:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a2b:	01 c8                	add    %ecx,%eax
     a2d:	89 c1                	mov    %eax,%ecx
     a2f:	89 c8                	mov    %ecx,%eax
     a31:	01 c0                	add    %eax,%eax
     a33:	01 c8                	add    %ecx,%eax
     a35:	01 c2                	add    %eax,%edx
     a37:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a3a:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a3e:	89 c1                	mov    %eax,%ecx
     a40:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a43:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a47:	01 c1                	add    %eax,%ecx
     a49:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a4c:	01 c8                	add    %ecx,%eax
     a4e:	8d 48 fe             	lea    -0x2(%eax),%ecx
     a51:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a54:	01 c8                	add    %ecx,%eax
     a56:	0f b6 00             	movzbl (%eax),%eax
     a59:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     a5c:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a5f:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a62:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a65:	01 c8                	add    %ecx,%eax
     a67:	89 c1                	mov    %eax,%ecx
     a69:	89 c8                	mov    %ecx,%eax
     a6b:	01 c0                	add    %eax,%eax
     a6d:	01 c8                	add    %ecx,%eax
     a6f:	01 c2                	add    %eax,%edx
     a71:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a74:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a78:	89 c1                	mov    %eax,%ecx
     a7a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a7d:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a81:	01 c1                	add    %eax,%ecx
     a83:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a86:	01 c8                	add    %ecx,%eax
     a88:	8d 48 fd             	lea    -0x3(%eax),%ecx
     a8b:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a8e:	01 c8                	add    %ecx,%eax
     a90:	0f b6 00             	movzbl (%eax),%eax
     a93:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     a95:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     a99:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a9f:	39 c2                	cmp    %eax,%edx
     aa1:	0f 87 41 ff ff ff    	ja     9e8 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     aa7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     aab:	8b 55 cc             	mov    -0x34(%ebp),%edx
     aae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab1:	39 c2                	cmp    %eax,%edx
     ab3:	0f 87 0d ff ff ff    	ja     9c6 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     ab9:	83 ec 0c             	sub    $0xc,%esp
     abc:	ff 75 ec             	pushl  -0x14(%ebp)
     abf:	e8 e7 f7 ff ff       	call   2ab <close>
     ac4:	83 c4 10             	add    $0x10,%esp
    return bmp;
     ac7:	8b 45 08             	mov    0x8(%ebp),%eax
     aca:	8b 55 c8             	mov    -0x38(%ebp),%edx
     acd:	89 10                	mov    %edx,(%eax)
     acf:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ad2:	89 50 04             	mov    %edx,0x4(%eax)
     ad5:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ad8:	89 50 08             	mov    %edx,0x8(%eax)
}
     adb:	8b 45 08             	mov    0x8(%ebp),%eax
     ade:	c9                   	leave  
     adf:	c2 04 00             	ret    $0x4

00000ae2 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     ae2:	55                   	push   %ebp
     ae3:	89 e5                	mov    %esp,%ebp
     ae5:	53                   	push   %ebx
     ae6:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     ae9:	83 ec 0c             	sub    $0xc,%esp
     aec:	6a 1c                	push   $0x1c
     aee:	e8 02 fc ff ff       	call   6f5 <malloc>
     af3:	83 c4 10             	add    $0x10,%esp
     af6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     af9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     afc:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b03:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b06:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b09:	6a 0c                	push   $0xc
     b0b:	6a 0c                	push   $0xc
     b0d:	6a 0c                	push   $0xc
     b0f:	50                   	push   %eax
     b10:	e8 c3 fc ff ff       	call   7d8 <RGB>
     b15:	83 c4 0c             	add    $0xc,%esp
     b18:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b1c:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b20:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b24:	88 43 15             	mov    %al,0x15(%ebx)
     b27:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b2a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b2d:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b31:	66 89 48 10          	mov    %cx,0x10(%eax)
     b35:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b39:	88 50 12             	mov    %dl,0x12(%eax)
     b3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b3f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b42:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     b46:	66 89 48 08          	mov    %cx,0x8(%eax)
     b4a:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     b4e:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     b51:	8b 45 08             	mov    0x8(%ebp),%eax
     b54:	89 c2                	mov    %eax,%edx
     b56:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b59:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     b5b:	8b 45 0c             	mov    0xc(%ebp),%eax
     b5e:	89 c2                	mov    %eax,%edx
     b60:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b63:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     b66:	8b 55 10             	mov    0x10(%ebp),%edx
     b69:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b6c:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     b6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     b72:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b75:	c9                   	leave  
     b76:	c3                   	ret    

00000b77 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     b77:	55                   	push   %ebp
     b78:	89 e5                	mov    %esp,%ebp
     b7a:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     b7d:	8b 45 0c             	mov    0xc(%ebp),%eax
     b80:	8b 50 08             	mov    0x8(%eax),%edx
     b83:	89 55 f8             	mov    %edx,-0x8(%ebp)
     b86:	8b 40 0c             	mov    0xc(%eax),%eax
     b89:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     b8c:	8b 45 0c             	mov    0xc(%ebp),%eax
     b8f:	8b 55 10             	mov    0x10(%ebp),%edx
     b92:	89 50 08             	mov    %edx,0x8(%eax)
     b95:	8b 55 14             	mov    0x14(%ebp),%edx
     b98:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     b9b:	8b 45 08             	mov    0x8(%ebp),%eax
     b9e:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ba1:	89 10                	mov    %edx,(%eax)
     ba3:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ba6:	89 50 04             	mov    %edx,0x4(%eax)
}
     ba9:	8b 45 08             	mov    0x8(%ebp),%eax
     bac:	c9                   	leave  
     bad:	c2 04 00             	ret    $0x4

00000bb0 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     bb6:	8b 45 0c             	mov    0xc(%ebp),%eax
     bb9:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     bbd:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     bc1:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     bc5:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     bc8:	8b 45 0c             	mov    0xc(%ebp),%eax
     bcb:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     bcf:	66 89 50 10          	mov    %dx,0x10(%eax)
     bd3:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     bd7:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     bda:	8b 45 08             	mov    0x8(%ebp),%eax
     bdd:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     be1:	66 89 10             	mov    %dx,(%eax)
     be4:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     be8:	88 50 02             	mov    %dl,0x2(%eax)
}
     beb:	8b 45 08             	mov    0x8(%ebp),%eax
     bee:	c9                   	leave  
     bef:	c2 04 00             	ret    $0x4

00000bf2 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     bf2:	55                   	push   %ebp
     bf3:	89 e5                	mov    %esp,%ebp
     bf5:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     bf8:	8b 45 08             	mov    0x8(%ebp),%eax
     bfb:	8b 40 0c             	mov    0xc(%eax),%eax
     bfe:	89 c2                	mov    %eax,%edx
     c00:	c1 ea 1f             	shr    $0x1f,%edx
     c03:	01 d0                	add    %edx,%eax
     c05:	d1 f8                	sar    %eax
     c07:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c0d:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c11:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c14:	8b 45 10             	mov    0x10(%ebp),%eax
     c17:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c1a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c1d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c21:	0f 89 98 00 00 00    	jns    cbf <APDrawPoint+0xcd>
        i = 0;
     c27:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c2e:	e9 8c 00 00 00       	jmp    cbf <APDrawPoint+0xcd>
    {
        j = x - off;
     c33:	8b 45 0c             	mov    0xc(%ebp),%eax
     c36:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c39:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     c3c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     c40:	79 69                	jns    cab <APDrawPoint+0xb9>
            j = 0;
     c42:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     c49:	eb 60                	jmp    cab <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     c4b:	ff 75 fc             	pushl  -0x4(%ebp)
     c4e:	ff 75 f8             	pushl  -0x8(%ebp)
     c51:	ff 75 08             	pushl  0x8(%ebp)
     c54:	e8 fd fb ff ff       	call   856 <APGetIndex>
     c59:	83 c4 0c             	add    $0xc,%esp
     c5c:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     c5f:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     c63:	74 55                	je     cba <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     c65:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     c69:	74 67                	je     cd2 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     c6b:	ff 75 10             	pushl  0x10(%ebp)
     c6e:	ff 75 0c             	pushl  0xc(%ebp)
     c71:	ff 75 fc             	pushl  -0x4(%ebp)
     c74:	ff 75 f8             	pushl  -0x8(%ebp)
     c77:	e8 a1 fb ff ff       	call   81d <distance_2>
     c7c:	83 c4 10             	add    $0x10,%esp
     c7f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     c82:	7f 23                	jg     ca7 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     c84:	8b 45 08             	mov    0x8(%ebp),%eax
     c87:	8b 48 18             	mov    0x18(%eax),%ecx
     c8a:	8b 55 ec             	mov    -0x14(%ebp),%edx
     c8d:	89 d0                	mov    %edx,%eax
     c8f:	01 c0                	add    %eax,%eax
     c91:	01 d0                	add    %edx,%eax
     c93:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     c96:	8b 45 08             	mov    0x8(%ebp),%eax
     c99:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     c9d:	66 89 0a             	mov    %cx,(%edx)
     ca0:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     ca4:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     ca7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     cab:	8b 55 0c             	mov    0xc(%ebp),%edx
     cae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cb1:	01 d0                	add    %edx,%eax
     cb3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     cb6:	7d 93                	jge    c4b <APDrawPoint+0x59>
     cb8:	eb 01                	jmp    cbb <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     cba:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     cbb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     cbf:	8b 55 10             	mov    0x10(%ebp),%edx
     cc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc5:	01 d0                	add    %edx,%eax
     cc7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     cca:	0f 8d 63 ff ff ff    	jge    c33 <APDrawPoint+0x41>
     cd0:	eb 01                	jmp    cd3 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     cd2:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     cd3:	c9                   	leave  
     cd4:	c3                   	ret    

00000cd5 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     cd5:	55                   	push   %ebp
     cd6:	89 e5                	mov    %esp,%ebp
     cd8:	53                   	push   %ebx
     cd9:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     cdc:	8b 45 0c             	mov    0xc(%ebp),%eax
     cdf:	3b 45 14             	cmp    0x14(%ebp),%eax
     ce2:	0f 85 80 00 00 00    	jne    d68 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     ce8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     cec:	0f 88 9d 02 00 00    	js     f8f <APDrawLine+0x2ba>
     cf2:	8b 45 08             	mov    0x8(%ebp),%eax
     cf5:	8b 00                	mov    (%eax),%eax
     cf7:	3b 45 0c             	cmp    0xc(%ebp),%eax
     cfa:	0f 8e 8f 02 00 00    	jle    f8f <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d00:	8b 45 10             	mov    0x10(%ebp),%eax
     d03:	3b 45 18             	cmp    0x18(%ebp),%eax
     d06:	7e 12                	jle    d1a <APDrawLine+0x45>
        {
            int tmp = y2;
     d08:	8b 45 18             	mov    0x18(%ebp),%eax
     d0b:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d0e:	8b 45 10             	mov    0x10(%ebp),%eax
     d11:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d14:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d17:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d1a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d1e:	79 07                	jns    d27 <APDrawLine+0x52>
     d20:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d27:	8b 45 08             	mov    0x8(%ebp),%eax
     d2a:	8b 40 04             	mov    0x4(%eax),%eax
     d2d:	3b 45 18             	cmp    0x18(%ebp),%eax
     d30:	7d 0c                	jge    d3e <APDrawLine+0x69>
     d32:	8b 45 08             	mov    0x8(%ebp),%eax
     d35:	8b 40 04             	mov    0x4(%eax),%eax
     d38:	83 e8 01             	sub    $0x1,%eax
     d3b:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     d3e:	8b 45 10             	mov    0x10(%ebp),%eax
     d41:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d44:	eb 15                	jmp    d5b <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     d46:	ff 75 f4             	pushl  -0xc(%ebp)
     d49:	ff 75 0c             	pushl  0xc(%ebp)
     d4c:	ff 75 08             	pushl  0x8(%ebp)
     d4f:	e8 9e fe ff ff       	call   bf2 <APDrawPoint>
     d54:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     d57:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d5e:	3b 45 18             	cmp    0x18(%ebp),%eax
     d61:	7e e3                	jle    d46 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     d63:	e9 2b 02 00 00       	jmp    f93 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     d68:	8b 45 10             	mov    0x10(%ebp),%eax
     d6b:	3b 45 18             	cmp    0x18(%ebp),%eax
     d6e:	75 7f                	jne    def <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     d70:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d74:	0f 88 18 02 00 00    	js     f92 <APDrawLine+0x2bd>
     d7a:	8b 45 08             	mov    0x8(%ebp),%eax
     d7d:	8b 40 04             	mov    0x4(%eax),%eax
     d80:	3b 45 10             	cmp    0x10(%ebp),%eax
     d83:	0f 8e 09 02 00 00    	jle    f92 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     d89:	8b 45 0c             	mov    0xc(%ebp),%eax
     d8c:	3b 45 14             	cmp    0x14(%ebp),%eax
     d8f:	7e 12                	jle    da3 <APDrawLine+0xce>
        {
            int tmp = x2;
     d91:	8b 45 14             	mov    0x14(%ebp),%eax
     d94:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     d97:	8b 45 0c             	mov    0xc(%ebp),%eax
     d9a:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     d9d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     da0:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     da3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     da7:	79 07                	jns    db0 <APDrawLine+0xdb>
     da9:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     db0:	8b 45 08             	mov    0x8(%ebp),%eax
     db3:	8b 00                	mov    (%eax),%eax
     db5:	3b 45 14             	cmp    0x14(%ebp),%eax
     db8:	7d 0b                	jge    dc5 <APDrawLine+0xf0>
     dba:	8b 45 08             	mov    0x8(%ebp),%eax
     dbd:	8b 00                	mov    (%eax),%eax
     dbf:	83 e8 01             	sub    $0x1,%eax
     dc2:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     dc5:	8b 45 0c             	mov    0xc(%ebp),%eax
     dc8:	89 45 f0             	mov    %eax,-0x10(%ebp)
     dcb:	eb 15                	jmp    de2 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     dcd:	ff 75 10             	pushl  0x10(%ebp)
     dd0:	ff 75 f0             	pushl  -0x10(%ebp)
     dd3:	ff 75 08             	pushl  0x8(%ebp)
     dd6:	e8 17 fe ff ff       	call   bf2 <APDrawPoint>
     ddb:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     dde:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     de2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     de5:	3b 45 14             	cmp    0x14(%ebp),%eax
     de8:	7e e3                	jle    dcd <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     dea:	e9 a4 01 00 00       	jmp    f93 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     def:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     df6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
     e00:	2b 45 14             	sub    0x14(%ebp),%eax
     e03:	50                   	push   %eax
     e04:	e8 3d fa ff ff       	call   846 <abs_int>
     e09:	83 c4 04             	add    $0x4,%esp
     e0c:	89 c3                	mov    %eax,%ebx
     e0e:	8b 45 10             	mov    0x10(%ebp),%eax
     e11:	2b 45 18             	sub    0x18(%ebp),%eax
     e14:	50                   	push   %eax
     e15:	e8 2c fa ff ff       	call   846 <abs_int>
     e1a:	83 c4 04             	add    $0x4,%esp
     e1d:	39 c3                	cmp    %eax,%ebx
     e1f:	0f 8e b5 00 00 00    	jle    eda <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e25:	8b 45 10             	mov    0x10(%ebp),%eax
     e28:	2b 45 18             	sub    0x18(%ebp),%eax
     e2b:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e2e:	db 45 b0             	fildl  -0x50(%ebp)
     e31:	8b 45 0c             	mov    0xc(%ebp),%eax
     e34:	2b 45 14             	sub    0x14(%ebp),%eax
     e37:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e3a:	db 45 b0             	fildl  -0x50(%ebp)
     e3d:	de f9                	fdivrp %st,%st(1)
     e3f:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     e42:	8b 45 14             	mov    0x14(%ebp),%eax
     e45:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e48:	7e 0e                	jle    e58 <APDrawLine+0x183>
        {
            s = x1;
     e4a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e4d:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     e50:	8b 45 14             	mov    0x14(%ebp),%eax
     e53:	89 45 e8             	mov    %eax,-0x18(%ebp)
     e56:	eb 0c                	jmp    e64 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     e58:	8b 45 14             	mov    0x14(%ebp),%eax
     e5b:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     e5e:	8b 45 0c             	mov    0xc(%ebp),%eax
     e61:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     e64:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     e68:	79 07                	jns    e71 <APDrawLine+0x19c>
     e6a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     e71:	8b 45 08             	mov    0x8(%ebp),%eax
     e74:	8b 00                	mov    (%eax),%eax
     e76:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     e79:	7f 0b                	jg     e86 <APDrawLine+0x1b1>
     e7b:	8b 45 08             	mov    0x8(%ebp),%eax
     e7e:	8b 00                	mov    (%eax),%eax
     e80:	83 e8 01             	sub    $0x1,%eax
     e83:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     e86:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e89:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     e8c:	eb 3f                	jmp    ecd <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     e8e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e91:	2b 45 0c             	sub    0xc(%ebp),%eax
     e94:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e97:	db 45 b0             	fildl  -0x50(%ebp)
     e9a:	dc 4d d0             	fmull  -0x30(%ebp)
     e9d:	db 45 10             	fildl  0x10(%ebp)
     ea0:	de c1                	faddp  %st,%st(1)
     ea2:	d9 7d b6             	fnstcw -0x4a(%ebp)
     ea5:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     ea9:	b4 0c                	mov    $0xc,%ah
     eab:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     eaf:	d9 6d b4             	fldcw  -0x4c(%ebp)
     eb2:	db 5d cc             	fistpl -0x34(%ebp)
     eb5:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     eb8:	ff 75 cc             	pushl  -0x34(%ebp)
     ebb:	ff 75 e4             	pushl  -0x1c(%ebp)
     ebe:	ff 75 08             	pushl  0x8(%ebp)
     ec1:	e8 2c fd ff ff       	call   bf2 <APDrawPoint>
     ec6:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     ec9:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     ecd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ed0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ed3:	7e b9                	jle    e8e <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     ed5:	e9 b9 00 00 00       	jmp    f93 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     eda:	8b 45 0c             	mov    0xc(%ebp),%eax
     edd:	2b 45 14             	sub    0x14(%ebp),%eax
     ee0:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ee3:	db 45 b0             	fildl  -0x50(%ebp)
     ee6:	8b 45 10             	mov    0x10(%ebp),%eax
     ee9:	2b 45 18             	sub    0x18(%ebp),%eax
     eec:	89 45 b0             	mov    %eax,-0x50(%ebp)
     eef:	db 45 b0             	fildl  -0x50(%ebp)
     ef2:	de f9                	fdivrp %st,%st(1)
     ef4:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     ef7:	8b 45 10             	mov    0x10(%ebp),%eax
     efa:	3b 45 18             	cmp    0x18(%ebp),%eax
     efd:	7e 0e                	jle    f0d <APDrawLine+0x238>
    {
        s = y2;
     eff:	8b 45 18             	mov    0x18(%ebp),%eax
     f02:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f05:	8b 45 10             	mov    0x10(%ebp),%eax
     f08:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f0b:	eb 0c                	jmp    f19 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f0d:	8b 45 10             	mov    0x10(%ebp),%eax
     f10:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f13:	8b 45 18             	mov    0x18(%ebp),%eax
     f16:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f19:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f1d:	79 07                	jns    f26 <APDrawLine+0x251>
     f1f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f26:	8b 45 08             	mov    0x8(%ebp),%eax
     f29:	8b 40 04             	mov    0x4(%eax),%eax
     f2c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f2f:	7f 0c                	jg     f3d <APDrawLine+0x268>
     f31:	8b 45 08             	mov    0x8(%ebp),%eax
     f34:	8b 40 04             	mov    0x4(%eax),%eax
     f37:	83 e8 01             	sub    $0x1,%eax
     f3a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     f3d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f40:	89 45 e0             	mov    %eax,-0x20(%ebp)
     f43:	eb 3f                	jmp    f84 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     f45:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f48:	2b 45 10             	sub    0x10(%ebp),%eax
     f4b:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f4e:	db 45 b0             	fildl  -0x50(%ebp)
     f51:	dc 4d c0             	fmull  -0x40(%ebp)
     f54:	db 45 0c             	fildl  0xc(%ebp)
     f57:	de c1                	faddp  %st,%st(1)
     f59:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f5c:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f60:	b4 0c                	mov    $0xc,%ah
     f62:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f66:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f69:	db 5d bc             	fistpl -0x44(%ebp)
     f6c:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     f6f:	ff 75 e0             	pushl  -0x20(%ebp)
     f72:	ff 75 bc             	pushl  -0x44(%ebp)
     f75:	ff 75 08             	pushl  0x8(%ebp)
     f78:	e8 75 fc ff ff       	call   bf2 <APDrawPoint>
     f7d:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     f80:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     f84:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f87:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f8a:	7e b9                	jle    f45 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     f8c:	90                   	nop
     f8d:	eb 04                	jmp    f93 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     f8f:	90                   	nop
     f90:	eb 01                	jmp    f93 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     f92:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     f93:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     f96:	c9                   	leave  
     f97:	c3                   	ret    

00000f98 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     f98:	55                   	push   %ebp
     f99:	89 e5                	mov    %esp,%ebp
     f9b:	53                   	push   %ebx
     f9c:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
     f9f:	8b 55 10             	mov    0x10(%ebp),%edx
     fa2:	8b 45 18             	mov    0x18(%ebp),%eax
     fa5:	01 d0                	add    %edx,%eax
     fa7:	83 e8 01             	sub    $0x1,%eax
     faa:	83 ec 04             	sub    $0x4,%esp
     fad:	50                   	push   %eax
     fae:	ff 75 0c             	pushl  0xc(%ebp)
     fb1:	ff 75 10             	pushl  0x10(%ebp)
     fb4:	ff 75 0c             	pushl  0xc(%ebp)
     fb7:	ff 75 08             	pushl  0x8(%ebp)
     fba:	e8 16 fd ff ff       	call   cd5 <APDrawLine>
     fbf:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
     fc2:	8b 55 0c             	mov    0xc(%ebp),%edx
     fc5:	8b 45 14             	mov    0x14(%ebp),%eax
     fc8:	01 d0                	add    %edx,%eax
     fca:	83 e8 01             	sub    $0x1,%eax
     fcd:	83 ec 04             	sub    $0x4,%esp
     fd0:	ff 75 10             	pushl  0x10(%ebp)
     fd3:	50                   	push   %eax
     fd4:	ff 75 10             	pushl  0x10(%ebp)
     fd7:	ff 75 0c             	pushl  0xc(%ebp)
     fda:	ff 75 08             	pushl  0x8(%ebp)
     fdd:	e8 f3 fc ff ff       	call   cd5 <APDrawLine>
     fe2:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
     fe5:	8b 55 10             	mov    0x10(%ebp),%edx
     fe8:	8b 45 18             	mov    0x18(%ebp),%eax
     feb:	01 d0                	add    %edx,%eax
     fed:	8d 48 ff             	lea    -0x1(%eax),%ecx
     ff0:	8b 55 0c             	mov    0xc(%ebp),%edx
     ff3:	8b 45 14             	mov    0x14(%ebp),%eax
     ff6:	01 d0                	add    %edx,%eax
     ff8:	8d 50 ff             	lea    -0x1(%eax),%edx
     ffb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     ffe:	8b 45 14             	mov    0x14(%ebp),%eax
    1001:	01 d8                	add    %ebx,%eax
    1003:	83 e8 01             	sub    $0x1,%eax
    1006:	83 ec 04             	sub    $0x4,%esp
    1009:	51                   	push   %ecx
    100a:	52                   	push   %edx
    100b:	ff 75 10             	pushl  0x10(%ebp)
    100e:	50                   	push   %eax
    100f:	ff 75 08             	pushl  0x8(%ebp)
    1012:	e8 be fc ff ff       	call   cd5 <APDrawLine>
    1017:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    101a:	8b 55 10             	mov    0x10(%ebp),%edx
    101d:	8b 45 18             	mov    0x18(%ebp),%eax
    1020:	01 d0                	add    %edx,%eax
    1022:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1025:	8b 55 0c             	mov    0xc(%ebp),%edx
    1028:	8b 45 14             	mov    0x14(%ebp),%eax
    102b:	01 d0                	add    %edx,%eax
    102d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1030:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1033:	8b 45 18             	mov    0x18(%ebp),%eax
    1036:	01 d8                	add    %ebx,%eax
    1038:	83 e8 01             	sub    $0x1,%eax
    103b:	83 ec 04             	sub    $0x4,%esp
    103e:	51                   	push   %ecx
    103f:	52                   	push   %edx
    1040:	50                   	push   %eax
    1041:	ff 75 0c             	pushl  0xc(%ebp)
    1044:	ff 75 08             	pushl  0x8(%ebp)
    1047:	e8 89 fc ff ff       	call   cd5 <APDrawLine>
    104c:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    104f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1052:	8b 45 14             	mov    0x14(%ebp),%eax
    1055:	01 d0                	add    %edx,%eax
    1057:	8d 50 ff             	lea    -0x1(%eax),%edx
    105a:	8b 45 08             	mov    0x8(%ebp),%eax
    105d:	8b 40 0c             	mov    0xc(%eax),%eax
    1060:	89 c1                	mov    %eax,%ecx
    1062:	c1 e9 1f             	shr    $0x1f,%ecx
    1065:	01 c8                	add    %ecx,%eax
    1067:	d1 f8                	sar    %eax
    1069:	29 c2                	sub    %eax,%edx
    106b:	89 d0                	mov    %edx,%eax
    106d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1070:	8b 55 10             	mov    0x10(%ebp),%edx
    1073:	8b 45 18             	mov    0x18(%ebp),%eax
    1076:	01 d0                	add    %edx,%eax
    1078:	8d 50 ff             	lea    -0x1(%eax),%edx
    107b:	8b 45 08             	mov    0x8(%ebp),%eax
    107e:	8b 40 0c             	mov    0xc(%eax),%eax
    1081:	89 c1                	mov    %eax,%ecx
    1083:	c1 e9 1f             	shr    $0x1f,%ecx
    1086:	01 c8                	add    %ecx,%eax
    1088:	d1 f8                	sar    %eax
    108a:	29 c2                	sub    %eax,%edx
    108c:	89 d0                	mov    %edx,%eax
    108e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1091:	8b 45 08             	mov    0x8(%ebp),%eax
    1094:	8b 40 0c             	mov    0xc(%eax),%eax
    1097:	89 c2                	mov    %eax,%edx
    1099:	c1 ea 1f             	shr    $0x1f,%edx
    109c:	01 d0                	add    %edx,%eax
    109e:	d1 f8                	sar    %eax
    10a0:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    10a3:	8b 45 08             	mov    0x8(%ebp),%eax
    10a6:	8b 40 0c             	mov    0xc(%eax),%eax
    10a9:	89 c2                	mov    %eax,%edx
    10ab:	c1 ea 1f             	shr    $0x1f,%edx
    10ae:	01 d0                	add    %edx,%eax
    10b0:	d1 f8                	sar    %eax
    10b2:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    10b5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10b9:	0f 88 d8 00 00 00    	js     1197 <APDrawRect+0x1ff>
    10bf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    10c3:	0f 88 ce 00 00 00    	js     1197 <APDrawRect+0x1ff>
    10c9:	8b 45 08             	mov    0x8(%ebp),%eax
    10cc:	8b 00                	mov    (%eax),%eax
    10ce:	3b 45 0c             	cmp    0xc(%ebp),%eax
    10d1:	0f 8e c0 00 00 00    	jle    1197 <APDrawRect+0x1ff>
    10d7:	8b 45 08             	mov    0x8(%ebp),%eax
    10da:	8b 40 04             	mov    0x4(%eax),%eax
    10dd:	3b 45 10             	cmp    0x10(%ebp),%eax
    10e0:	0f 8e b1 00 00 00    	jle    1197 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    10e6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10ea:	79 07                	jns    10f3 <APDrawRect+0x15b>
    10ec:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    10f3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    10f7:	79 07                	jns    1100 <APDrawRect+0x168>
    10f9:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1100:	8b 45 08             	mov    0x8(%ebp),%eax
    1103:	8b 00                	mov    (%eax),%eax
    1105:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1108:	7f 0b                	jg     1115 <APDrawRect+0x17d>
    110a:	8b 45 08             	mov    0x8(%ebp),%eax
    110d:	8b 00                	mov    (%eax),%eax
    110f:	83 e8 01             	sub    $0x1,%eax
    1112:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1115:	8b 45 08             	mov    0x8(%ebp),%eax
    1118:	8b 40 04             	mov    0x4(%eax),%eax
    111b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    111e:	7f 0c                	jg     112c <APDrawRect+0x194>
    1120:	8b 45 08             	mov    0x8(%ebp),%eax
    1123:	8b 40 04             	mov    0x4(%eax),%eax
    1126:	83 e8 01             	sub    $0x1,%eax
    1129:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    112c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1133:	8b 45 0c             	mov    0xc(%ebp),%eax
    1136:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1139:	eb 52                	jmp    118d <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    113b:	8b 45 10             	mov    0x10(%ebp),%eax
    113e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1141:	eb 3e                	jmp    1181 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1143:	83 ec 04             	sub    $0x4,%esp
    1146:	ff 75 e8             	pushl  -0x18(%ebp)
    1149:	ff 75 ec             	pushl  -0x14(%ebp)
    114c:	ff 75 08             	pushl  0x8(%ebp)
    114f:	e8 02 f7 ff ff       	call   856 <APGetIndex>
    1154:	83 c4 10             	add    $0x10,%esp
    1157:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    115a:	8b 45 08             	mov    0x8(%ebp),%eax
    115d:	8b 48 18             	mov    0x18(%eax),%ecx
    1160:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1163:	89 d0                	mov    %edx,%eax
    1165:	01 c0                	add    %eax,%eax
    1167:	01 d0                	add    %edx,%eax
    1169:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    116c:	8b 45 08             	mov    0x8(%ebp),%eax
    116f:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1173:	66 89 0a             	mov    %cx,(%edx)
    1176:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    117a:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    117d:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1181:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1184:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1187:	7e ba                	jle    1143 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1189:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    118d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1190:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1193:	7e a6                	jle    113b <APDrawRect+0x1a3>
    1195:	eb 01                	jmp    1198 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1197:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1198:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    119b:	c9                   	leave  
    119c:	c3                   	ret    

0000119d <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    119d:	55                   	push   %ebp
    119e:	89 e5                	mov    %esp,%ebp
    11a0:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    11a3:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    11a7:	0f 88 8e 01 00 00    	js     133b <APDcCopy+0x19e>
    11ad:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    11b1:	0f 88 84 01 00 00    	js     133b <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    11b7:	8b 55 0c             	mov    0xc(%ebp),%edx
    11ba:	8b 45 20             	mov    0x20(%ebp),%eax
    11bd:	01 d0                	add    %edx,%eax
    11bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11c2:	8b 55 10             	mov    0x10(%ebp),%edx
    11c5:	8b 45 24             	mov    0x24(%ebp),%eax
    11c8:	01 d0                	add    %edx,%eax
    11ca:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    11cd:	8b 55 18             	mov    0x18(%ebp),%edx
    11d0:	8b 45 20             	mov    0x20(%ebp),%eax
    11d3:	01 d0                	add    %edx,%eax
    11d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11d8:	8b 55 1c             	mov    0x1c(%ebp),%edx
    11db:	8b 45 24             	mov    0x24(%ebp),%eax
    11de:	01 d0                	add    %edx,%eax
    11e0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    11e3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11e7:	0f 88 51 01 00 00    	js     133e <APDcCopy+0x1a1>
    11ed:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    11f1:	0f 88 47 01 00 00    	js     133e <APDcCopy+0x1a1>
    11f7:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    11fb:	0f 88 3d 01 00 00    	js     133e <APDcCopy+0x1a1>
    1201:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1205:	0f 88 33 01 00 00    	js     133e <APDcCopy+0x1a1>
    120b:	8b 45 14             	mov    0x14(%ebp),%eax
    120e:	8b 00                	mov    (%eax),%eax
    1210:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1213:	0f 8c 25 01 00 00    	jl     133e <APDcCopy+0x1a1>
    1219:	8b 45 14             	mov    0x14(%ebp),%eax
    121c:	8b 40 04             	mov    0x4(%eax),%eax
    121f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1222:	0f 8c 16 01 00 00    	jl     133e <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1228:	8b 45 08             	mov    0x8(%ebp),%eax
    122b:	8b 00                	mov    (%eax),%eax
    122d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1230:	7f 0b                	jg     123d <APDcCopy+0xa0>
    1232:	8b 45 08             	mov    0x8(%ebp),%eax
    1235:	8b 00                	mov    (%eax),%eax
    1237:	83 e8 01             	sub    $0x1,%eax
    123a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    123d:	8b 45 08             	mov    0x8(%ebp),%eax
    1240:	8b 40 04             	mov    0x4(%eax),%eax
    1243:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1246:	7f 0c                	jg     1254 <APDcCopy+0xb7>
    1248:	8b 45 08             	mov    0x8(%ebp),%eax
    124b:	8b 40 04             	mov    0x4(%eax),%eax
    124e:	83 e8 01             	sub    $0x1,%eax
    1251:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1254:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    125b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1262:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1269:	e9 bc 00 00 00       	jmp    132a <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    126e:	8b 45 08             	mov    0x8(%ebp),%eax
    1271:	8b 00                	mov    (%eax),%eax
    1273:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1276:	8b 55 10             	mov    0x10(%ebp),%edx
    1279:	01 ca                	add    %ecx,%edx
    127b:	0f af d0             	imul   %eax,%edx
    127e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1281:	01 d0                	add    %edx,%eax
    1283:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1286:	8b 45 14             	mov    0x14(%ebp),%eax
    1289:	8b 00                	mov    (%eax),%eax
    128b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    128e:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1291:	01 ca                	add    %ecx,%edx
    1293:	0f af d0             	imul   %eax,%edx
    1296:	8b 45 18             	mov    0x18(%ebp),%eax
    1299:	01 d0                	add    %edx,%eax
    129b:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    129e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12a5:	eb 74                	jmp    131b <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    12a7:	8b 45 14             	mov    0x14(%ebp),%eax
    12aa:	8b 50 18             	mov    0x18(%eax),%edx
    12ad:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12b3:	01 c8                	add    %ecx,%eax
    12b5:	89 c1                	mov    %eax,%ecx
    12b7:	89 c8                	mov    %ecx,%eax
    12b9:	01 c0                	add    %eax,%eax
    12bb:	01 c8                	add    %ecx,%eax
    12bd:	01 d0                	add    %edx,%eax
    12bf:	0f b7 10             	movzwl (%eax),%edx
    12c2:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    12c6:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    12ca:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    12cd:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    12d1:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    12d5:	38 c2                	cmp    %al,%dl
    12d7:	75 18                	jne    12f1 <APDcCopy+0x154>
    12d9:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    12dd:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    12e1:	38 c2                	cmp    %al,%dl
    12e3:	75 0c                	jne    12f1 <APDcCopy+0x154>
    12e5:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    12e9:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    12ed:	38 c2                	cmp    %al,%dl
    12ef:	74 26                	je     1317 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    12f1:	8b 45 08             	mov    0x8(%ebp),%eax
    12f4:	8b 50 18             	mov    0x18(%eax),%edx
    12f7:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    12fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12fd:	01 c8                	add    %ecx,%eax
    12ff:	89 c1                	mov    %eax,%ecx
    1301:	89 c8                	mov    %ecx,%eax
    1303:	01 c0                	add    %eax,%eax
    1305:	01 c8                	add    %ecx,%eax
    1307:	01 d0                	add    %edx,%eax
    1309:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    130d:	66 89 10             	mov    %dx,(%eax)
    1310:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1314:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1317:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    131b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    131e:	2b 45 0c             	sub    0xc(%ebp),%eax
    1321:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1324:	7d 81                	jge    12a7 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1326:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    132a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    132d:	2b 45 10             	sub    0x10(%ebp),%eax
    1330:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1333:	0f 8d 35 ff ff ff    	jge    126e <APDcCopy+0xd1>
    1339:	eb 04                	jmp    133f <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    133b:	90                   	nop
    133c:	eb 01                	jmp    133f <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    133e:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    133f:	c9                   	leave  
    1340:	c3                   	ret    

00001341 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1341:	55                   	push   %ebp
    1342:	89 e5                	mov    %esp,%ebp
    1344:	83 ec 1c             	sub    $0x1c,%esp
    1347:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    134a:	8b 55 10             	mov    0x10(%ebp),%edx
    134d:	8b 45 14             	mov    0x14(%ebp),%eax
    1350:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1353:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1356:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1359:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    135d:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1360:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1364:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1367:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    136b:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    136e:	8b 45 08             	mov    0x8(%ebp),%eax
    1371:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1375:	66 89 10             	mov    %dx,(%eax)
    1378:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    137c:	88 50 02             	mov    %dl,0x2(%eax)
}
    137f:	8b 45 08             	mov    0x8(%ebp),%eax
    1382:	c9                   	leave  
    1383:	c2 04 00             	ret    $0x4

00001386 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1386:	55                   	push   %ebp
    1387:	89 e5                	mov    %esp,%ebp
    1389:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    138c:	8b 45 08             	mov    0x8(%ebp),%eax
    138f:	8b 00                	mov    (%eax),%eax
    1391:	83 ec 08             	sub    $0x8,%esp
    1394:	8d 55 0c             	lea    0xc(%ebp),%edx
    1397:	52                   	push   %edx
    1398:	50                   	push   %eax
    1399:	e8 95 ef ff ff       	call   333 <sendMessage>
    139e:	83 c4 10             	add    $0x10,%esp
}
    13a1:	90                   	nop
    13a2:	c9                   	leave  
    13a3:	c3                   	ret    

000013a4 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    13a4:	55                   	push   %ebp
    13a5:	89 e5                	mov    %esp,%ebp
    13a7:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    13aa:	83 ec 0c             	sub    $0xc,%esp
    13ad:	68 90 00 00 00       	push   $0x90
    13b2:	e8 3e f3 ff ff       	call   6f5 <malloc>
    13b7:	83 c4 10             	add    $0x10,%esp
    13ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    13bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13c1:	75 15                	jne    13d8 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    13c3:	83 ec 04             	sub    $0x4,%esp
    13c6:	ff 75 08             	pushl  0x8(%ebp)
    13c9:	68 80 20 00 00       	push   $0x2080
    13ce:	6a 01                	push   $0x1
    13d0:	e8 4d f0 ff ff       	call   422 <printf>
    13d5:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    13d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13db:	83 c0 7c             	add    $0x7c,%eax
    13de:	83 ec 08             	sub    $0x8,%esp
    13e1:	ff 75 08             	pushl  0x8(%ebp)
    13e4:	50                   	push   %eax
    13e5:	e8 68 ec ff ff       	call   52 <strcpy>
    13ea:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    13ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f0:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    13f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13fa:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1401:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1404:	8b 40 34             	mov    0x34(%eax),%eax
    1407:	89 c2                	mov    %eax,%edx
    1409:	8b 45 f4             	mov    -0xc(%ebp),%eax
    140c:	8b 40 38             	mov    0x38(%eax),%eax
    140f:	0f af d0             	imul   %eax,%edx
    1412:	89 d0                	mov    %edx,%eax
    1414:	01 c0                	add    %eax,%eax
    1416:	01 d0                	add    %edx,%eax
    1418:	83 ec 0c             	sub    $0xc,%esp
    141b:	50                   	push   %eax
    141c:	e8 d4 f2 ff ff       	call   6f5 <malloc>
    1421:	83 c4 10             	add    $0x10,%esp
    1424:	89 c2                	mov    %eax,%edx
    1426:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1429:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    142c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    142f:	8b 40 4c             	mov    0x4c(%eax),%eax
    1432:	85 c0                	test   %eax,%eax
    1434:	75 15                	jne    144b <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1436:	83 ec 04             	sub    $0x4,%esp
    1439:	ff 75 08             	pushl  0x8(%ebp)
    143c:	68 a0 20 00 00       	push   $0x20a0
    1441:	6a 01                	push   $0x1
    1443:	e8 da ef ff ff       	call   422 <printf>
    1448:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    144b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    144e:	8b 40 34             	mov    0x34(%eax),%eax
    1451:	89 c2                	mov    %eax,%edx
    1453:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1456:	8b 40 38             	mov    0x38(%eax),%eax
    1459:	0f af d0             	imul   %eax,%edx
    145c:	89 d0                	mov    %edx,%eax
    145e:	01 c0                	add    %eax,%eax
    1460:	01 c2                	add    %eax,%edx
    1462:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1465:	8b 40 4c             	mov    0x4c(%eax),%eax
    1468:	83 ec 04             	sub    $0x4,%esp
    146b:	52                   	push   %edx
    146c:	68 ff ff ff 00       	push   $0xffffff
    1471:	50                   	push   %eax
    1472:	e8 71 ec ff ff       	call   e8 <memset>
    1477:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    147a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    147d:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    1484:	e8 7a ee ff ff       	call   303 <getpid>
    1489:	89 c2                	mov    %eax,%edx
    148b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    148e:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1491:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1494:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    149b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149e:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    14a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a8:	8b 40 50             	mov    0x50(%eax),%eax
    14ab:	89 c2                	mov    %eax,%edx
    14ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b0:	8b 40 54             	mov    0x54(%eax),%eax
    14b3:	0f af d0             	imul   %eax,%edx
    14b6:	89 d0                	mov    %edx,%eax
    14b8:	01 c0                	add    %eax,%eax
    14ba:	01 d0                	add    %edx,%eax
    14bc:	83 ec 0c             	sub    $0xc,%esp
    14bf:	50                   	push   %eax
    14c0:	e8 30 f2 ff ff       	call   6f5 <malloc>
    14c5:	83 c4 10             	add    $0x10,%esp
    14c8:	89 c2                	mov    %eax,%edx
    14ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cd:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    14d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d3:	8b 40 68             	mov    0x68(%eax),%eax
    14d6:	85 c0                	test   %eax,%eax
    14d8:	75 15                	jne    14ef <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    14da:	83 ec 04             	sub    $0x4,%esp
    14dd:	ff 75 08             	pushl  0x8(%ebp)
    14e0:	68 c4 20 00 00       	push   $0x20c4
    14e5:	6a 01                	push   $0x1
    14e7:	e8 36 ef ff ff       	call   422 <printf>
    14ec:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f2:	8b 40 34             	mov    0x34(%eax),%eax
    14f5:	89 c2                	mov    %eax,%edx
    14f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14fa:	8b 40 38             	mov    0x38(%eax),%eax
    14fd:	0f af d0             	imul   %eax,%edx
    1500:	89 d0                	mov    %edx,%eax
    1502:	01 c0                	add    %eax,%eax
    1504:	01 c2                	add    %eax,%edx
    1506:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1509:	8b 40 4c             	mov    0x4c(%eax),%eax
    150c:	83 ec 04             	sub    $0x4,%esp
    150f:	52                   	push   %edx
    1510:	68 ff 00 00 00       	push   $0xff
    1515:	50                   	push   %eax
    1516:	e8 cd eb ff ff       	call   e8 <memset>
    151b:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    151e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1521:	8b 55 0c             	mov    0xc(%ebp),%edx
    1524:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1527:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    152b:	74 35                	je     1562 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    152d:	8b 45 10             	mov    0x10(%ebp),%eax
    1530:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1536:	83 ec 0c             	sub    $0xc,%esp
    1539:	50                   	push   %eax
    153a:	e8 b6 f1 ff ff       	call   6f5 <malloc>
    153f:	83 c4 10             	add    $0x10,%esp
    1542:	89 c2                	mov    %eax,%edx
    1544:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1547:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    154a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154d:	8b 55 10             	mov    0x10(%ebp),%edx
    1550:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1553:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1556:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    155d:	e9 8d 00 00 00       	jmp    15ef <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1562:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1565:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    156c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156f:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1576:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1579:	8b 40 18             	mov    0x18(%eax),%eax
    157c:	89 c2                	mov    %eax,%edx
    157e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1581:	8b 40 1c             	mov    0x1c(%eax),%eax
    1584:	0f af d0             	imul   %eax,%edx
    1587:	89 d0                	mov    %edx,%eax
    1589:	01 c0                	add    %eax,%eax
    158b:	01 d0                	add    %edx,%eax
    158d:	83 ec 0c             	sub    $0xc,%esp
    1590:	50                   	push   %eax
    1591:	e8 5f f1 ff ff       	call   6f5 <malloc>
    1596:	83 c4 10             	add    $0x10,%esp
    1599:	89 c2                	mov    %eax,%edx
    159b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159e:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    15a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a4:	8b 40 30             	mov    0x30(%eax),%eax
    15a7:	85 c0                	test   %eax,%eax
    15a9:	75 15                	jne    15c0 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    15ab:	83 ec 04             	sub    $0x4,%esp
    15ae:	ff 75 08             	pushl  0x8(%ebp)
    15b1:	68 ec 20 00 00       	push   $0x20ec
    15b6:	6a 01                	push   $0x1
    15b8:	e8 65 ee ff ff       	call   422 <printf>
    15bd:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c3:	8b 40 18             	mov    0x18(%eax),%eax
    15c6:	89 c2                	mov    %eax,%edx
    15c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cb:	8b 40 1c             	mov    0x1c(%eax),%eax
    15ce:	0f af d0             	imul   %eax,%edx
    15d1:	89 d0                	mov    %edx,%eax
    15d3:	01 c0                	add    %eax,%eax
    15d5:	01 c2                	add    %eax,%edx
    15d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15da:	8b 40 30             	mov    0x30(%eax),%eax
    15dd:	83 ec 04             	sub    $0x4,%esp
    15e0:	52                   	push   %edx
    15e1:	68 ff ff ff 00       	push   $0xffffff
    15e6:	50                   	push   %eax
    15e7:	e8 fc ea ff ff       	call   e8 <memset>
    15ec:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    15ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    15f2:	c9                   	leave  
    15f3:	c3                   	ret    

000015f4 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    15f4:	55                   	push   %ebp
    15f5:	89 e5                	mov    %esp,%ebp
    15f7:	53                   	push   %ebx
    15f8:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    15fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    15fe:	83 f8 03             	cmp    $0x3,%eax
    1601:	74 02                	je     1605 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1603:	eb 33                	jmp    1638 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1605:	8b 45 08             	mov    0x8(%ebp),%eax
    1608:	8b 48 08             	mov    0x8(%eax),%ecx
    160b:	8b 45 08             	mov    0x8(%ebp),%eax
    160e:	8b 50 38             	mov    0x38(%eax),%edx
    1611:	8b 45 08             	mov    0x8(%ebp),%eax
    1614:	8b 40 34             	mov    0x34(%eax),%eax
    1617:	8b 5d 08             	mov    0x8(%ebp),%ebx
    161a:	83 c3 34             	add    $0x34,%ebx
    161d:	83 ec 0c             	sub    $0xc,%esp
    1620:	51                   	push   %ecx
    1621:	52                   	push   %edx
    1622:	50                   	push   %eax
    1623:	6a 00                	push   $0x0
    1625:	6a 00                	push   $0x0
    1627:	53                   	push   %ebx
    1628:	6a 32                	push   $0x32
    162a:	6a 00                	push   $0x0
    162c:	ff 75 08             	pushl  0x8(%ebp)
    162f:	e8 ef ec ff ff       	call   323 <paintWindow>
    1634:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1637:	90                   	nop
        default: break;
            
            
    }
    return False;
    1638:	b8 00 00 00 00       	mov    $0x0,%eax
}
    163d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1640:	c9                   	leave  
    1641:	c3                   	ret    

00001642 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1642:	55                   	push   %ebp
    1643:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1645:	8b 45 0c             	mov    0xc(%ebp),%eax
    1648:	8b 50 08             	mov    0x8(%eax),%edx
    164b:	8b 45 08             	mov    0x8(%ebp),%eax
    164e:	8b 00                	mov    (%eax),%eax
    1650:	39 c2                	cmp    %eax,%edx
    1652:	74 07                	je     165b <APPreJudge+0x19>
        return False;
    1654:	b8 00 00 00 00       	mov    $0x0,%eax
    1659:	eb 05                	jmp    1660 <APPreJudge+0x1e>
    return True;
    165b:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1660:	5d                   	pop    %ebp
    1661:	c3                   	ret    

00001662 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1662:	55                   	push   %ebp
    1663:	89 e5                	mov    %esp,%ebp
    1665:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1668:	8b 45 08             	mov    0x8(%ebp),%eax
    166b:	8b 55 0c             	mov    0xc(%ebp),%edx
    166e:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    1671:	83 ec 0c             	sub    $0xc,%esp
    1674:	ff 75 08             	pushl  0x8(%ebp)
    1677:	e8 c7 ec ff ff       	call   343 <registWindow>
    167c:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    167f:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1686:	8b 45 08             	mov    0x8(%ebp),%eax
    1689:	8b 00                	mov    (%eax),%eax
    168b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    168e:	ff 75 f4             	pushl  -0xc(%ebp)
    1691:	ff 75 f0             	pushl  -0x10(%ebp)
    1694:	ff 75 ec             	pushl  -0x14(%ebp)
    1697:	ff 75 08             	pushl  0x8(%ebp)
    169a:	e8 e7 fc ff ff       	call   1386 <APSendMessage>
    169f:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    16a2:	83 ec 0c             	sub    $0xc,%esp
    16a5:	ff 75 08             	pushl  0x8(%ebp)
    16a8:	e8 8e ec ff ff       	call   33b <getMessage>
    16ad:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    16b0:	8b 45 08             	mov    0x8(%ebp),%eax
    16b3:	83 c0 6c             	add    $0x6c,%eax
    16b6:	83 ec 08             	sub    $0x8,%esp
    16b9:	50                   	push   %eax
    16ba:	ff 75 08             	pushl  0x8(%ebp)
    16bd:	e8 80 ff ff ff       	call   1642 <APPreJudge>
    16c2:	83 c4 10             	add    $0x10,%esp
    16c5:	84 c0                	test   %al,%al
    16c7:	74 1b                	je     16e4 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    16c9:	8b 45 08             	mov    0x8(%ebp),%eax
    16cc:	ff 70 74             	pushl  0x74(%eax)
    16cf:	ff 70 70             	pushl  0x70(%eax)
    16d2:	ff 70 6c             	pushl  0x6c(%eax)
    16d5:	ff 75 08             	pushl  0x8(%ebp)
    16d8:	8b 45 0c             	mov    0xc(%ebp),%eax
    16db:	ff d0                	call   *%eax
    16dd:	83 c4 10             	add    $0x10,%esp
    16e0:	84 c0                	test   %al,%al
    16e2:	75 0c                	jne    16f0 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    16e4:	8b 45 08             	mov    0x8(%ebp),%eax
    16e7:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    16ee:	eb b2                	jmp    16a2 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    16f0:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    16f1:	90                   	nop
    16f2:	c9                   	leave  
    16f3:	c3                   	ret    

000016f4 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    16f4:	55                   	push   %ebp
    16f5:	89 e5                	mov    %esp,%ebp
    16f7:	57                   	push   %edi
    16f8:	56                   	push   %esi
    16f9:	53                   	push   %ebx
    16fa:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    16fd:	a1 24 27 00 00       	mov    0x2724,%eax
    1702:	85 c0                	test   %eax,%eax
    1704:	0f 85 2c 02 00 00    	jne    1936 <APGridPaint+0x242>
    {
        iconReady = 1;
    170a:	c7 05 24 27 00 00 01 	movl   $0x1,0x2724
    1711:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1714:	8d 45 98             	lea    -0x68(%ebp),%eax
    1717:	83 ec 08             	sub    $0x8,%esp
    171a:	68 13 21 00 00       	push   $0x2113
    171f:	50                   	push   %eax
    1720:	e8 83 f1 ff ff       	call   8a8 <APLoadBitmap>
    1725:	83 c4 0c             	add    $0xc,%esp
    1728:	8b 45 98             	mov    -0x68(%ebp),%eax
    172b:	a3 48 27 00 00       	mov    %eax,0x2748
    1730:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1733:	a3 4c 27 00 00       	mov    %eax,0x274c
    1738:	8b 45 a0             	mov    -0x60(%ebp),%eax
    173b:	a3 50 27 00 00       	mov    %eax,0x2750
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1740:	83 ec 04             	sub    $0x4,%esp
    1743:	ff 35 50 27 00 00    	pushl  0x2750
    1749:	ff 35 4c 27 00 00    	pushl  0x274c
    174f:	ff 35 48 27 00 00    	pushl  0x2748
    1755:	e8 88 f3 ff ff       	call   ae2 <APCreateCompatibleDCFromBitmap>
    175a:	83 c4 10             	add    $0x10,%esp
    175d:	a3 54 27 00 00       	mov    %eax,0x2754
        grid_river = APLoadBitmap ("grid_river.bmp");
    1762:	8d 45 98             	lea    -0x68(%ebp),%eax
    1765:	83 ec 08             	sub    $0x8,%esp
    1768:	68 21 21 00 00       	push   $0x2121
    176d:	50                   	push   %eax
    176e:	e8 35 f1 ff ff       	call   8a8 <APLoadBitmap>
    1773:	83 c4 0c             	add    $0xc,%esp
    1776:	8b 45 98             	mov    -0x68(%ebp),%eax
    1779:	a3 84 27 00 00       	mov    %eax,0x2784
    177e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1781:	a3 88 27 00 00       	mov    %eax,0x2788
    1786:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1789:	a3 8c 27 00 00       	mov    %eax,0x278c
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    178e:	83 ec 04             	sub    $0x4,%esp
    1791:	ff 35 8c 27 00 00    	pushl  0x278c
    1797:	ff 35 88 27 00 00    	pushl  0x2788
    179d:	ff 35 84 27 00 00    	pushl  0x2784
    17a3:	e8 3a f3 ff ff       	call   ae2 <APCreateCompatibleDCFromBitmap>
    17a8:	83 c4 10             	add    $0x10,%esp
    17ab:	a3 74 27 00 00       	mov    %eax,0x2774
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    17b0:	8d 45 98             	lea    -0x68(%ebp),%eax
    17b3:	83 ec 08             	sub    $0x8,%esp
    17b6:	68 30 21 00 00       	push   $0x2130
    17bb:	50                   	push   %eax
    17bc:	e8 e7 f0 ff ff       	call   8a8 <APLoadBitmap>
    17c1:	83 c4 0c             	add    $0xc,%esp
    17c4:	8b 45 98             	mov    -0x68(%ebp),%eax
    17c7:	a3 78 27 00 00       	mov    %eax,0x2778
    17cc:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17cf:	a3 7c 27 00 00       	mov    %eax,0x277c
    17d4:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17d7:	a3 80 27 00 00       	mov    %eax,0x2780
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    17dc:	83 ec 04             	sub    $0x4,%esp
    17df:	ff 35 80 27 00 00    	pushl  0x2780
    17e5:	ff 35 7c 27 00 00    	pushl  0x277c
    17eb:	ff 35 78 27 00 00    	pushl  0x2778
    17f1:	e8 ec f2 ff ff       	call   ae2 <APCreateCompatibleDCFromBitmap>
    17f6:	83 c4 10             	add    $0x10,%esp
    17f9:	a3 28 27 00 00       	mov    %eax,0x2728
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    17fe:	8d 45 98             	lea    -0x68(%ebp),%eax
    1801:	83 ec 08             	sub    $0x8,%esp
    1804:	68 3f 21 00 00       	push   $0x213f
    1809:	50                   	push   %eax
    180a:	e8 99 f0 ff ff       	call   8a8 <APLoadBitmap>
    180f:	83 c4 0c             	add    $0xc,%esp
    1812:	8b 45 98             	mov    -0x68(%ebp),%eax
    1815:	a3 5c 27 00 00       	mov    %eax,0x275c
    181a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    181d:	a3 60 27 00 00       	mov    %eax,0x2760
    1822:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1825:	a3 64 27 00 00       	mov    %eax,0x2764
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    182a:	83 ec 04             	sub    $0x4,%esp
    182d:	ff 35 64 27 00 00    	pushl  0x2764
    1833:	ff 35 60 27 00 00    	pushl  0x2760
    1839:	ff 35 5c 27 00 00    	pushl  0x275c
    183f:	e8 9e f2 ff ff       	call   ae2 <APCreateCompatibleDCFromBitmap>
    1844:	83 c4 10             	add    $0x10,%esp
    1847:	a3 90 27 00 00       	mov    %eax,0x2790
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    184c:	8d 45 98             	lea    -0x68(%ebp),%eax
    184f:	83 ec 08             	sub    $0x8,%esp
    1852:	68 4d 21 00 00       	push   $0x214d
    1857:	50                   	push   %eax
    1858:	e8 4b f0 ff ff       	call   8a8 <APLoadBitmap>
    185d:	83 c4 0c             	add    $0xc,%esp
    1860:	8b 45 98             	mov    -0x68(%ebp),%eax
    1863:	a3 38 27 00 00       	mov    %eax,0x2738
    1868:	8b 45 9c             	mov    -0x64(%ebp),%eax
    186b:	a3 3c 27 00 00       	mov    %eax,0x273c
    1870:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1873:	a3 40 27 00 00       	mov    %eax,0x2740
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1878:	83 ec 04             	sub    $0x4,%esp
    187b:	ff 35 40 27 00 00    	pushl  0x2740
    1881:	ff 35 3c 27 00 00    	pushl  0x273c
    1887:	ff 35 38 27 00 00    	pushl  0x2738
    188d:	e8 50 f2 ff ff       	call   ae2 <APCreateCompatibleDCFromBitmap>
    1892:	83 c4 10             	add    $0x10,%esp
    1895:	a3 58 27 00 00       	mov    %eax,0x2758
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    189a:	8d 45 98             	lea    -0x68(%ebp),%eax
    189d:	83 ec 08             	sub    $0x8,%esp
    18a0:	68 5d 21 00 00       	push   $0x215d
    18a5:	50                   	push   %eax
    18a6:	e8 fd ef ff ff       	call   8a8 <APLoadBitmap>
    18ab:	83 c4 0c             	add    $0xc,%esp
    18ae:	8b 45 98             	mov    -0x68(%ebp),%eax
    18b1:	a3 2c 27 00 00       	mov    %eax,0x272c
    18b6:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18b9:	a3 30 27 00 00       	mov    %eax,0x2730
    18be:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18c1:	a3 34 27 00 00       	mov    %eax,0x2734
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    18c6:	83 ec 04             	sub    $0x4,%esp
    18c9:	ff 35 34 27 00 00    	pushl  0x2734
    18cf:	ff 35 30 27 00 00    	pushl  0x2730
    18d5:	ff 35 2c 27 00 00    	pushl  0x272c
    18db:	e8 02 f2 ff ff       	call   ae2 <APCreateCompatibleDCFromBitmap>
    18e0:	83 c4 10             	add    $0x10,%esp
    18e3:	a3 44 27 00 00       	mov    %eax,0x2744
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    18e8:	8d 45 98             	lea    -0x68(%ebp),%eax
    18eb:	83 ec 08             	sub    $0x8,%esp
    18ee:	68 6f 21 00 00       	push   $0x216f
    18f3:	50                   	push   %eax
    18f4:	e8 af ef ff ff       	call   8a8 <APLoadBitmap>
    18f9:	83 c4 0c             	add    $0xc,%esp
    18fc:	8b 45 98             	mov    -0x68(%ebp),%eax
    18ff:	a3 68 27 00 00       	mov    %eax,0x2768
    1904:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1907:	a3 6c 27 00 00       	mov    %eax,0x276c
    190c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    190f:	a3 70 27 00 00       	mov    %eax,0x2770
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1914:	83 ec 04             	sub    $0x4,%esp
    1917:	ff 35 70 27 00 00    	pushl  0x2770
    191d:	ff 35 6c 27 00 00    	pushl  0x276c
    1923:	ff 35 68 27 00 00    	pushl  0x2768
    1929:	e8 b4 f1 ff ff       	call   ae2 <APCreateCompatibleDCFromBitmap>
    192e:	83 c4 10             	add    $0x10,%esp
    1931:	a3 94 27 00 00       	mov    %eax,0x2794
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1936:	8b 45 08             	mov    0x8(%ebp),%eax
    1939:	8b 40 08             	mov    0x8(%eax),%eax
    193c:	85 c0                	test   %eax,%eax
    193e:	75 17                	jne    1957 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1940:	83 ec 08             	sub    $0x8,%esp
    1943:	68 80 21 00 00       	push   $0x2180
    1948:	6a 01                	push   $0x1
    194a:	e8 d3 ea ff ff       	call   422 <printf>
    194f:	83 c4 10             	add    $0x10,%esp
        return;
    1952:	e9 f2 03 00 00       	jmp    1d49 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1957:	8b 45 08             	mov    0x8(%ebp),%eax
    195a:	8b 40 10             	mov    0x10(%eax),%eax
    195d:	85 c0                	test   %eax,%eax
    195f:	7e 10                	jle    1971 <APGridPaint+0x27d>
    1961:	8b 45 08             	mov    0x8(%ebp),%eax
    1964:	8b 50 14             	mov    0x14(%eax),%edx
    1967:	8b 45 08             	mov    0x8(%ebp),%eax
    196a:	8b 40 10             	mov    0x10(%eax),%eax
    196d:	39 c2                	cmp    %eax,%edx
    196f:	7c 17                	jl     1988 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1971:	83 ec 08             	sub    $0x8,%esp
    1974:	68 a6 21 00 00       	push   $0x21a6
    1979:	6a 01                	push   $0x1
    197b:	e8 a2 ea ff ff       	call   422 <printf>
    1980:	83 c4 10             	add    $0x10,%esp
        return;
    1983:	e9 c1 03 00 00       	jmp    1d49 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1988:	8b 45 08             	mov    0x8(%ebp),%eax
    198b:	8b 40 14             	mov    0x14(%eax),%eax
    198e:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1994:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1997:	8b 45 dc             	mov    -0x24(%ebp),%eax
    199a:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    199d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    19a4:	e9 96 03 00 00       	jmp    1d3f <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    19a9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    19b0:	e9 7c 03 00 00       	jmp    1d31 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    19b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19b8:	c1 e0 04             	shl    $0x4,%eax
    19bb:	89 c2                	mov    %eax,%edx
    19bd:	8b 45 d8             	mov    -0x28(%ebp),%eax
    19c0:	01 c2                	add    %eax,%edx
    19c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    19c5:	01 d0                	add    %edx,%eax
    19c7:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    19ca:	8b 45 08             	mov    0x8(%ebp),%eax
    19cd:	8b 40 0c             	mov    0xc(%eax),%eax
    19d0:	8b 55 dc             	mov    -0x24(%ebp),%edx
    19d3:	c1 e2 02             	shl    $0x2,%edx
    19d6:	01 d0                	add    %edx,%eax
    19d8:	8b 00                	mov    (%eax),%eax
    19da:	83 f8 07             	cmp    $0x7,%eax
    19dd:	0f 87 49 03 00 00    	ja     1d2c <APGridPaint+0x638>
    19e3:	8b 04 85 bc 21 00 00 	mov    0x21bc(,%eax,4),%eax
    19ea:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    19ec:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    19ef:	6a 0c                	push   $0xc
    19f1:	6a 0c                	push   $0xc
    19f3:	6a 0c                	push   $0xc
    19f5:	50                   	push   %eax
    19f6:	e8 46 f9 ff ff       	call   1341 <RGB>
    19fb:	83 c4 0c             	add    $0xc,%esp
    19fe:	8b 1d 54 27 00 00    	mov    0x2754,%ebx
    1a04:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a07:	6b c8 32             	imul   $0x32,%eax,%ecx
    1a0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a0d:	6b c0 32             	imul   $0x32,%eax,%eax
    1a10:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1a13:	8b 45 08             	mov    0x8(%ebp),%eax
    1a16:	8d 78 34             	lea    0x34(%eax),%edi
    1a19:	83 ec 0c             	sub    $0xc,%esp
    1a1c:	83 ec 04             	sub    $0x4,%esp
    1a1f:	89 e0                	mov    %esp,%eax
    1a21:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1a25:	66 89 30             	mov    %si,(%eax)
    1a28:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1a2c:	88 50 02             	mov    %dl,0x2(%eax)
    1a2f:	6a 32                	push   $0x32
    1a31:	6a 32                	push   $0x32
    1a33:	6a 00                	push   $0x0
    1a35:	6a 00                	push   $0x0
    1a37:	53                   	push   %ebx
    1a38:	51                   	push   %ecx
    1a39:	ff 75 94             	pushl  -0x6c(%ebp)
    1a3c:	57                   	push   %edi
    1a3d:	e8 5b f7 ff ff       	call   119d <APDcCopy>
    1a42:	83 c4 30             	add    $0x30,%esp
                    break;
    1a45:	e9 e3 02 00 00       	jmp    1d2d <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1a4a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a4d:	6a 69                	push   $0x69
    1a4f:	6a 69                	push   $0x69
    1a51:	6a 69                	push   $0x69
    1a53:	50                   	push   %eax
    1a54:	e8 e8 f8 ff ff       	call   1341 <RGB>
    1a59:	83 c4 0c             	add    $0xc,%esp
    1a5c:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1a60:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1a64:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1a68:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1a6b:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1a72:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a75:	6a 69                	push   $0x69
    1a77:	6a 69                	push   $0x69
    1a79:	6a 69                	push   $0x69
    1a7b:	50                   	push   %eax
    1a7c:	e8 c0 f8 ff ff       	call   1341 <RGB>
    1a81:	83 c4 0c             	add    $0xc,%esp
    1a84:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1a88:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1a8c:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1a90:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1a93:	8b 45 08             	mov    0x8(%ebp),%eax
    1a96:	8d 50 34             	lea    0x34(%eax),%edx
    1a99:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a9c:	ff 75 bc             	pushl  -0x44(%ebp)
    1a9f:	ff 75 b8             	pushl  -0x48(%ebp)
    1aa2:	52                   	push   %edx
    1aa3:	50                   	push   %eax
    1aa4:	e8 ce f0 ff ff       	call   b77 <APSetPen>
    1aa9:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1aac:	8b 45 08             	mov    0x8(%ebp),%eax
    1aaf:	8d 58 34             	lea    0x34(%eax),%ebx
    1ab2:	8d 55 98             	lea    -0x68(%ebp),%edx
    1ab5:	83 ec 04             	sub    $0x4,%esp
    1ab8:	83 ec 04             	sub    $0x4,%esp
    1abb:	89 e0                	mov    %esp,%eax
    1abd:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1ac1:	66 89 08             	mov    %cx,(%eax)
    1ac4:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1ac8:	88 48 02             	mov    %cl,0x2(%eax)
    1acb:	53                   	push   %ebx
    1acc:	52                   	push   %edx
    1acd:	e8 de f0 ff ff       	call   bb0 <APSetBrush>
    1ad2:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1ad5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ad8:	6b d0 32             	imul   $0x32,%eax,%edx
    1adb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ade:	6b c0 32             	imul   $0x32,%eax,%eax
    1ae1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1ae4:	83 c1 34             	add    $0x34,%ecx
    1ae7:	83 ec 0c             	sub    $0xc,%esp
    1aea:	6a 32                	push   $0x32
    1aec:	6a 32                	push   $0x32
    1aee:	52                   	push   %edx
    1aef:	50                   	push   %eax
    1af0:	51                   	push   %ecx
    1af1:	e8 a2 f4 ff ff       	call   f98 <APDrawRect>
    1af6:	83 c4 20             	add    $0x20,%esp
                    break;
    1af9:	e9 2f 02 00 00       	jmp    1d2d <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1afe:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1b01:	6a 0c                	push   $0xc
    1b03:	6a 0c                	push   $0xc
    1b05:	6a 0c                	push   $0xc
    1b07:	50                   	push   %eax
    1b08:	e8 34 f8 ff ff       	call   1341 <RGB>
    1b0d:	83 c4 0c             	add    $0xc,%esp
    1b10:	8b 1d 94 27 00 00    	mov    0x2794,%ebx
    1b16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b19:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b1c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b1f:	6b c0 32             	imul   $0x32,%eax,%eax
    1b22:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b25:	8b 45 08             	mov    0x8(%ebp),%eax
    1b28:	8d 78 34             	lea    0x34(%eax),%edi
    1b2b:	83 ec 0c             	sub    $0xc,%esp
    1b2e:	83 ec 04             	sub    $0x4,%esp
    1b31:	89 e0                	mov    %esp,%eax
    1b33:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1b37:	66 89 30             	mov    %si,(%eax)
    1b3a:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1b3e:	88 50 02             	mov    %dl,0x2(%eax)
    1b41:	6a 32                	push   $0x32
    1b43:	6a 32                	push   $0x32
    1b45:	6a 00                	push   $0x0
    1b47:	6a 00                	push   $0x0
    1b49:	53                   	push   %ebx
    1b4a:	51                   	push   %ecx
    1b4b:	ff 75 94             	pushl  -0x6c(%ebp)
    1b4e:	57                   	push   %edi
    1b4f:	e8 49 f6 ff ff       	call   119d <APDcCopy>
    1b54:	83 c4 30             	add    $0x30,%esp
                    break;
    1b57:	e9 d1 01 00 00       	jmp    1d2d <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b5c:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1b5f:	6a 0c                	push   $0xc
    1b61:	6a 0c                	push   $0xc
    1b63:	6a 0c                	push   $0xc
    1b65:	50                   	push   %eax
    1b66:	e8 d6 f7 ff ff       	call   1341 <RGB>
    1b6b:	83 c4 0c             	add    $0xc,%esp
    1b6e:	8b 1d 74 27 00 00    	mov    0x2774,%ebx
    1b74:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b77:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b7a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b7d:	6b c0 32             	imul   $0x32,%eax,%eax
    1b80:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b83:	8b 45 08             	mov    0x8(%ebp),%eax
    1b86:	8d 78 34             	lea    0x34(%eax),%edi
    1b89:	83 ec 0c             	sub    $0xc,%esp
    1b8c:	83 ec 04             	sub    $0x4,%esp
    1b8f:	89 e0                	mov    %esp,%eax
    1b91:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1b95:	66 89 30             	mov    %si,(%eax)
    1b98:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1b9c:	88 50 02             	mov    %dl,0x2(%eax)
    1b9f:	6a 32                	push   $0x32
    1ba1:	6a 32                	push   $0x32
    1ba3:	6a 00                	push   $0x0
    1ba5:	6a 00                	push   $0x0
    1ba7:	53                   	push   %ebx
    1ba8:	51                   	push   %ecx
    1ba9:	ff 75 94             	pushl  -0x6c(%ebp)
    1bac:	57                   	push   %edi
    1bad:	e8 eb f5 ff ff       	call   119d <APDcCopy>
    1bb2:	83 c4 30             	add    $0x30,%esp
                    break;
    1bb5:	e9 73 01 00 00       	jmp    1d2d <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bba:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1bbd:	6a 0c                	push   $0xc
    1bbf:	6a 0c                	push   $0xc
    1bc1:	6a 0c                	push   $0xc
    1bc3:	50                   	push   %eax
    1bc4:	e8 78 f7 ff ff       	call   1341 <RGB>
    1bc9:	83 c4 0c             	add    $0xc,%esp
    1bcc:	8b 1d 58 27 00 00    	mov    0x2758,%ebx
    1bd2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bd5:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bd8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bdb:	6b c0 32             	imul   $0x32,%eax,%eax
    1bde:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1be1:	8b 45 08             	mov    0x8(%ebp),%eax
    1be4:	8d 78 34             	lea    0x34(%eax),%edi
    1be7:	83 ec 0c             	sub    $0xc,%esp
    1bea:	83 ec 04             	sub    $0x4,%esp
    1bed:	89 e0                	mov    %esp,%eax
    1bef:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1bf3:	66 89 30             	mov    %si,(%eax)
    1bf6:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1bfa:	88 50 02             	mov    %dl,0x2(%eax)
    1bfd:	6a 32                	push   $0x32
    1bff:	6a 32                	push   $0x32
    1c01:	6a 00                	push   $0x0
    1c03:	6a 00                	push   $0x0
    1c05:	53                   	push   %ebx
    1c06:	51                   	push   %ecx
    1c07:	ff 75 94             	pushl  -0x6c(%ebp)
    1c0a:	57                   	push   %edi
    1c0b:	e8 8d f5 ff ff       	call   119d <APDcCopy>
    1c10:	83 c4 30             	add    $0x30,%esp
                    break;
    1c13:	e9 15 01 00 00       	jmp    1d2d <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c18:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1c1b:	6a 0c                	push   $0xc
    1c1d:	6a 0c                	push   $0xc
    1c1f:	6a 0c                	push   $0xc
    1c21:	50                   	push   %eax
    1c22:	e8 1a f7 ff ff       	call   1341 <RGB>
    1c27:	83 c4 0c             	add    $0xc,%esp
    1c2a:	8b 1d 90 27 00 00    	mov    0x2790,%ebx
    1c30:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c33:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c36:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c39:	6b c0 32             	imul   $0x32,%eax,%eax
    1c3c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c42:	8d 78 34             	lea    0x34(%eax),%edi
    1c45:	83 ec 0c             	sub    $0xc,%esp
    1c48:	83 ec 04             	sub    $0x4,%esp
    1c4b:	89 e0                	mov    %esp,%eax
    1c4d:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1c51:	66 89 30             	mov    %si,(%eax)
    1c54:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1c58:	88 50 02             	mov    %dl,0x2(%eax)
    1c5b:	6a 32                	push   $0x32
    1c5d:	6a 32                	push   $0x32
    1c5f:	6a 00                	push   $0x0
    1c61:	6a 00                	push   $0x0
    1c63:	53                   	push   %ebx
    1c64:	51                   	push   %ecx
    1c65:	ff 75 94             	pushl  -0x6c(%ebp)
    1c68:	57                   	push   %edi
    1c69:	e8 2f f5 ff ff       	call   119d <APDcCopy>
    1c6e:	83 c4 30             	add    $0x30,%esp
                    break;
    1c71:	e9 b7 00 00 00       	jmp    1d2d <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c76:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1c79:	6a 0c                	push   $0xc
    1c7b:	6a 0c                	push   $0xc
    1c7d:	6a 0c                	push   $0xc
    1c7f:	50                   	push   %eax
    1c80:	e8 bc f6 ff ff       	call   1341 <RGB>
    1c85:	83 c4 0c             	add    $0xc,%esp
    1c88:	8b 1d 28 27 00 00    	mov    0x2728,%ebx
    1c8e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c91:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c94:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c97:	6b c0 32             	imul   $0x32,%eax,%eax
    1c9a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c9d:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca0:	8d 78 34             	lea    0x34(%eax),%edi
    1ca3:	83 ec 0c             	sub    $0xc,%esp
    1ca6:	83 ec 04             	sub    $0x4,%esp
    1ca9:	89 e0                	mov    %esp,%eax
    1cab:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1caf:	66 89 30             	mov    %si,(%eax)
    1cb2:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1cb6:	88 50 02             	mov    %dl,0x2(%eax)
    1cb9:	6a 32                	push   $0x32
    1cbb:	6a 32                	push   $0x32
    1cbd:	6a 00                	push   $0x0
    1cbf:	6a 00                	push   $0x0
    1cc1:	53                   	push   %ebx
    1cc2:	51                   	push   %ecx
    1cc3:	ff 75 94             	pushl  -0x6c(%ebp)
    1cc6:	57                   	push   %edi
    1cc7:	e8 d1 f4 ff ff       	call   119d <APDcCopy>
    1ccc:	83 c4 30             	add    $0x30,%esp
                    break;
    1ccf:	eb 5c                	jmp    1d2d <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cd1:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1cd4:	6a 0c                	push   $0xc
    1cd6:	6a 0c                	push   $0xc
    1cd8:	6a 0c                	push   $0xc
    1cda:	50                   	push   %eax
    1cdb:	e8 61 f6 ff ff       	call   1341 <RGB>
    1ce0:	83 c4 0c             	add    $0xc,%esp
    1ce3:	8b 1d 44 27 00 00    	mov    0x2744,%ebx
    1ce9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cec:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cef:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cf2:	6b c0 32             	imul   $0x32,%eax,%eax
    1cf5:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cf8:	8b 45 08             	mov    0x8(%ebp),%eax
    1cfb:	8d 78 34             	lea    0x34(%eax),%edi
    1cfe:	83 ec 0c             	sub    $0xc,%esp
    1d01:	83 ec 04             	sub    $0x4,%esp
    1d04:	89 e0                	mov    %esp,%eax
    1d06:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1d0a:	66 89 30             	mov    %si,(%eax)
    1d0d:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1d11:	88 50 02             	mov    %dl,0x2(%eax)
    1d14:	6a 32                	push   $0x32
    1d16:	6a 32                	push   $0x32
    1d18:	6a 00                	push   $0x0
    1d1a:	6a 00                	push   $0x0
    1d1c:	53                   	push   %ebx
    1d1d:	51                   	push   %ecx
    1d1e:	ff 75 94             	pushl  -0x6c(%ebp)
    1d21:	57                   	push   %edi
    1d22:	e8 76 f4 ff ff       	call   119d <APDcCopy>
    1d27:	83 c4 30             	add    $0x30,%esp
                    break;
    1d2a:	eb 01                	jmp    1d2d <APGridPaint+0x639>
                default: break;
    1d2c:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d2d:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1d31:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1d35:	0f 8e 7a fc ff ff    	jle    19b5 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d3b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1d3f:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1d43:	0f 8e 60 fc ff ff    	jle    19a9 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1d49:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1d4c:	5b                   	pop    %ebx
    1d4d:	5e                   	pop    %esi
    1d4e:	5f                   	pop    %edi
    1d4f:	5d                   	pop    %ebp
    1d50:	c3                   	ret    

00001d51 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1d51:	55                   	push   %ebp
    1d52:	89 e5                	mov    %esp,%ebp
    1d54:	53                   	push   %ebx
    1d55:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1d58:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1d5f:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1d63:	74 17                	je     1d7c <sprintint+0x2b>
    1d65:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1d69:	79 11                	jns    1d7c <sprintint+0x2b>
        neg = 1;
    1d6b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1d72:	8b 45 10             	mov    0x10(%ebp),%eax
    1d75:	f7 d8                	neg    %eax
    1d77:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1d7a:	eb 06                	jmp    1d82 <sprintint+0x31>
    } else {
        x = xx;
    1d7c:	8b 45 10             	mov    0x10(%ebp),%eax
    1d7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1d82:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1d89:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1d8c:	8d 41 01             	lea    0x1(%ecx),%eax
    1d8f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1d92:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1d95:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d98:	ba 00 00 00 00       	mov    $0x0,%edx
    1d9d:	f7 f3                	div    %ebx
    1d9f:	89 d0                	mov    %edx,%eax
    1da1:	0f b6 80 04 27 00 00 	movzbl 0x2704(%eax),%eax
    1da8:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1dac:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1daf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1db2:	ba 00 00 00 00       	mov    $0x0,%edx
    1db7:	f7 f3                	div    %ebx
    1db9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1dbc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1dc0:	75 c7                	jne    1d89 <sprintint+0x38>
    if(neg)
    1dc2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1dc6:	74 0e                	je     1dd6 <sprintint+0x85>
        buf[i++] = '-';
    1dc8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1dcb:	8d 50 01             	lea    0x1(%eax),%edx
    1dce:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1dd1:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1dd6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1dd9:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1ddc:	eb 1b                	jmp    1df9 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1dde:	8b 45 0c             	mov    0xc(%ebp),%eax
    1de1:	8b 00                	mov    (%eax),%eax
    1de3:	8d 48 01             	lea    0x1(%eax),%ecx
    1de6:	8b 55 0c             	mov    0xc(%ebp),%edx
    1de9:	89 0a                	mov    %ecx,(%edx)
    1deb:	89 c2                	mov    %eax,%edx
    1ded:	8b 45 08             	mov    0x8(%ebp),%eax
    1df0:	01 d0                	add    %edx,%eax
    1df2:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1df5:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1df9:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1dfd:	7f df                	jg     1dde <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1dff:	eb 21                	jmp    1e22 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1e01:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e04:	8b 00                	mov    (%eax),%eax
    1e06:	8d 48 01             	lea    0x1(%eax),%ecx
    1e09:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e0c:	89 0a                	mov    %ecx,(%edx)
    1e0e:	89 c2                	mov    %eax,%edx
    1e10:	8b 45 08             	mov    0x8(%ebp),%eax
    1e13:	01 c2                	add    %eax,%edx
    1e15:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1e18:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e1b:	01 c8                	add    %ecx,%eax
    1e1d:	0f b6 00             	movzbl (%eax),%eax
    1e20:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1e22:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1e26:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1e2a:	79 d5                	jns    1e01 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1e2c:	90                   	nop
    1e2d:	83 c4 20             	add    $0x20,%esp
    1e30:	5b                   	pop    %ebx
    1e31:	5d                   	pop    %ebp
    1e32:	c3                   	ret    

00001e33 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1e33:	55                   	push   %ebp
    1e34:	89 e5                	mov    %esp,%ebp
    1e36:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1e39:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1e40:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1e47:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1e4e:	8d 45 0c             	lea    0xc(%ebp),%eax
    1e51:	83 c0 04             	add    $0x4,%eax
    1e54:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1e57:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1e5e:	e9 d9 01 00 00       	jmp    203c <sprintf+0x209>
        c = fmt[i] & 0xff;
    1e63:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e66:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e69:	01 d0                	add    %edx,%eax
    1e6b:	0f b6 00             	movzbl (%eax),%eax
    1e6e:	0f be c0             	movsbl %al,%eax
    1e71:	25 ff 00 00 00       	and    $0xff,%eax
    1e76:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1e79:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1e7d:	75 2c                	jne    1eab <sprintf+0x78>
            if(c == '%'){
    1e7f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1e83:	75 0c                	jne    1e91 <sprintf+0x5e>
                state = '%';
    1e85:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1e8c:	e9 a7 01 00 00       	jmp    2038 <sprintf+0x205>
            } else {
                dst[j++] = c;
    1e91:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e94:	8d 50 01             	lea    0x1(%eax),%edx
    1e97:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e9a:	89 c2                	mov    %eax,%edx
    1e9c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e9f:	01 d0                	add    %edx,%eax
    1ea1:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1ea4:	88 10                	mov    %dl,(%eax)
    1ea6:	e9 8d 01 00 00       	jmp    2038 <sprintf+0x205>
            }
        } else if(state == '%'){
    1eab:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1eaf:	0f 85 83 01 00 00    	jne    2038 <sprintf+0x205>
            if(c == 'd'){
    1eb5:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1eb9:	75 4c                	jne    1f07 <sprintf+0xd4>
                buf[bi] = '\0';
    1ebb:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1ebe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ec1:	01 d0                	add    %edx,%eax
    1ec3:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1ec6:	83 ec 0c             	sub    $0xc,%esp
    1ec9:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1ecc:	50                   	push   %eax
    1ecd:	e8 1f e3 ff ff       	call   1f1 <atoi>
    1ed2:	83 c4 10             	add    $0x10,%esp
    1ed5:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1ed8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1edf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ee2:	8b 00                	mov    (%eax),%eax
    1ee4:	83 ec 08             	sub    $0x8,%esp
    1ee7:	ff 75 d8             	pushl  -0x28(%ebp)
    1eea:	6a 01                	push   $0x1
    1eec:	6a 0a                	push   $0xa
    1eee:	50                   	push   %eax
    1eef:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1ef2:	50                   	push   %eax
    1ef3:	ff 75 08             	pushl  0x8(%ebp)
    1ef6:	e8 56 fe ff ff       	call   1d51 <sprintint>
    1efb:	83 c4 20             	add    $0x20,%esp
                ap++;
    1efe:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1f02:	e9 2a 01 00 00       	jmp    2031 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1f07:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1f0b:	74 06                	je     1f13 <sprintf+0xe0>
    1f0d:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1f11:	75 4c                	jne    1f5f <sprintf+0x12c>
                buf[bi] = '\0';
    1f13:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f16:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f19:	01 d0                	add    %edx,%eax
    1f1b:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f1e:	83 ec 0c             	sub    $0xc,%esp
    1f21:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f24:	50                   	push   %eax
    1f25:	e8 c7 e2 ff ff       	call   1f1 <atoi>
    1f2a:	83 c4 10             	add    $0x10,%esp
    1f2d:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1f30:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1f37:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f3a:	8b 00                	mov    (%eax),%eax
    1f3c:	83 ec 08             	sub    $0x8,%esp
    1f3f:	ff 75 dc             	pushl  -0x24(%ebp)
    1f42:	6a 00                	push   $0x0
    1f44:	6a 10                	push   $0x10
    1f46:	50                   	push   %eax
    1f47:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1f4a:	50                   	push   %eax
    1f4b:	ff 75 08             	pushl  0x8(%ebp)
    1f4e:	e8 fe fd ff ff       	call   1d51 <sprintint>
    1f53:	83 c4 20             	add    $0x20,%esp
                ap++;
    1f56:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1f5a:	e9 d2 00 00 00       	jmp    2031 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1f5f:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1f63:	75 46                	jne    1fab <sprintf+0x178>
                s = (char*)*ap;
    1f65:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f68:	8b 00                	mov    (%eax),%eax
    1f6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1f6d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1f71:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f75:	75 25                	jne    1f9c <sprintf+0x169>
                    s = "(null)";
    1f77:	c7 45 f4 dc 21 00 00 	movl   $0x21dc,-0xc(%ebp)
                while(*s != 0){
    1f7e:	eb 1c                	jmp    1f9c <sprintf+0x169>
                    dst[j++] = *s;
    1f80:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f83:	8d 50 01             	lea    0x1(%eax),%edx
    1f86:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f89:	89 c2                	mov    %eax,%edx
    1f8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f8e:	01 c2                	add    %eax,%edx
    1f90:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f93:	0f b6 00             	movzbl (%eax),%eax
    1f96:	88 02                	mov    %al,(%edx)
                    s++;
    1f98:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    1f9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f9f:	0f b6 00             	movzbl (%eax),%eax
    1fa2:	84 c0                	test   %al,%al
    1fa4:	75 da                	jne    1f80 <sprintf+0x14d>
    1fa6:	e9 86 00 00 00       	jmp    2031 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    1fab:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    1faf:	75 1d                	jne    1fce <sprintf+0x19b>
                dst[j++] = *ap;
    1fb1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1fb4:	8d 50 01             	lea    0x1(%eax),%edx
    1fb7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1fba:	89 c2                	mov    %eax,%edx
    1fbc:	8b 45 08             	mov    0x8(%ebp),%eax
    1fbf:	01 c2                	add    %eax,%edx
    1fc1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fc4:	8b 00                	mov    (%eax),%eax
    1fc6:	88 02                	mov    %al,(%edx)
                ap++;
    1fc8:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1fcc:	eb 63                	jmp    2031 <sprintf+0x1fe>
            } else if(c == '%'){
    1fce:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1fd2:	75 17                	jne    1feb <sprintf+0x1b8>
                dst[j++] = c;
    1fd4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1fd7:	8d 50 01             	lea    0x1(%eax),%edx
    1fda:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1fdd:	89 c2                	mov    %eax,%edx
    1fdf:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe2:	01 d0                	add    %edx,%eax
    1fe4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1fe7:	88 10                	mov    %dl,(%eax)
    1fe9:	eb 46                	jmp    2031 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    1feb:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    1fef:	7e 18                	jle    2009 <sprintf+0x1d6>
    1ff1:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    1ff5:	7f 12                	jg     2009 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    1ff7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ffa:	8d 50 01             	lea    0x1(%eax),%edx
    1ffd:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2000:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2003:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2007:	eb 2f                	jmp    2038 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2009:	8b 45 c8             	mov    -0x38(%ebp),%eax
    200c:	8d 50 01             	lea    0x1(%eax),%edx
    200f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2012:	89 c2                	mov    %eax,%edx
    2014:	8b 45 08             	mov    0x8(%ebp),%eax
    2017:	01 d0                	add    %edx,%eax
    2019:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    201c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    201f:	8d 50 01             	lea    0x1(%eax),%edx
    2022:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2025:	89 c2                	mov    %eax,%edx
    2027:	8b 45 08             	mov    0x8(%ebp),%eax
    202a:	01 d0                	add    %edx,%eax
    202c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    202f:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2031:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2038:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    203c:	8b 55 0c             	mov    0xc(%ebp),%edx
    203f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2042:	01 d0                	add    %edx,%eax
    2044:	0f b6 00             	movzbl (%eax),%eax
    2047:	84 c0                	test   %al,%al
    2049:	0f 85 14 fe ff ff    	jne    1e63 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    204f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2052:	8d 50 01             	lea    0x1(%eax),%edx
    2055:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2058:	89 c2                	mov    %eax,%edx
    205a:	8b 45 08             	mov    0x8(%ebp),%eax
    205d:	01 d0                	add    %edx,%eax
    205f:	c6 00 00             	movb   $0x0,(%eax)
}
    2062:	90                   	nop
    2063:	c9                   	leave  
    2064:	c3                   	ret    
