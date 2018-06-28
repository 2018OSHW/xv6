
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

0000032b <sendMessage>:
SYSCALL(sendMessage)
     32b:	b8 17 00 00 00       	mov    $0x17,%eax
     330:	cd 40                	int    $0x40
     332:	c3                   	ret    

00000333 <getMessage>:
SYSCALL(getMessage)
     333:	b8 19 00 00 00       	mov    $0x19,%eax
     338:	cd 40                	int    $0x40
     33a:	c3                   	ret    

0000033b <registWindow>:
SYSCALL(registWindow)
     33b:	b8 18 00 00 00       	mov    $0x18,%eax
     340:	cd 40                	int    $0x40
     342:	c3                   	ret    

00000343 <changePosition>:
SYSCALL(changePosition)
     343:	b8 1a 00 00 00       	mov    $0x1a,%eax
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
     3be:	0f b6 80 b4 28 00 00 	movzbl 0x28b4(%eax),%eax
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
     4fc:	c7 45 f4 e4 21 00 00 	movl   $0x21e4,-0xc(%ebp)
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
     5c2:	a1 e8 28 00 00       	mov    0x28e8,%eax
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
     68d:	a3 e8 28 00 00       	mov    %eax,0x28e8
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
     6ee:	a1 e8 28 00 00       	mov    0x28e8,%eax
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
     70a:	a1 e8 28 00 00       	mov    0x28e8,%eax
     70f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     712:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     716:	75 23                	jne    73b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     718:	c7 45 f0 e0 28 00 00 	movl   $0x28e0,-0x10(%ebp)
     71f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     722:	a3 e8 28 00 00       	mov    %eax,0x28e8
     727:	a1 e8 28 00 00       	mov    0x28e8,%eax
     72c:	a3 e0 28 00 00       	mov    %eax,0x28e0
    base.s.size = 0;
     731:	c7 05 e4 28 00 00 00 	movl   $0x0,0x28e4
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
     78e:	a3 e8 28 00 00       	mov    %eax,0x28e8
      return (void*)(p + 1);
     793:	8b 45 f4             	mov    -0xc(%ebp),%eax
     796:	83 c0 08             	add    $0x8,%eax
     799:	eb 3b                	jmp    7d6 <malloc+0xe1>
    }
    if(p == freep)
     79b:	a1 e8 28 00 00       	mov    0x28e8,%eax
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
     8e1:	68 eb 21 00 00       	push   $0x21eb
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

0000119d <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    119d:	55                   	push   %ebp
    119e:	89 e5                	mov    %esp,%ebp
}
    11a0:	90                   	nop
    11a1:	5d                   	pop    %ebp
    11a2:	c3                   	ret    

000011a3 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    11a3:	55                   	push   %ebp
    11a4:	89 e5                	mov    %esp,%ebp
    11a6:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    11a9:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    11ad:	0f 88 8e 01 00 00    	js     1341 <APDcCopy+0x19e>
    11b3:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    11b7:	0f 88 84 01 00 00    	js     1341 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    11bd:	8b 55 0c             	mov    0xc(%ebp),%edx
    11c0:	8b 45 20             	mov    0x20(%ebp),%eax
    11c3:	01 d0                	add    %edx,%eax
    11c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11c8:	8b 55 10             	mov    0x10(%ebp),%edx
    11cb:	8b 45 24             	mov    0x24(%ebp),%eax
    11ce:	01 d0                	add    %edx,%eax
    11d0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    11d3:	8b 55 18             	mov    0x18(%ebp),%edx
    11d6:	8b 45 20             	mov    0x20(%ebp),%eax
    11d9:	01 d0                	add    %edx,%eax
    11db:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11de:	8b 55 1c             	mov    0x1c(%ebp),%edx
    11e1:	8b 45 24             	mov    0x24(%ebp),%eax
    11e4:	01 d0                	add    %edx,%eax
    11e6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    11e9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11ed:	0f 88 51 01 00 00    	js     1344 <APDcCopy+0x1a1>
    11f3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    11f7:	0f 88 47 01 00 00    	js     1344 <APDcCopy+0x1a1>
    11fd:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1201:	0f 88 3d 01 00 00    	js     1344 <APDcCopy+0x1a1>
    1207:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    120b:	0f 88 33 01 00 00    	js     1344 <APDcCopy+0x1a1>
    1211:	8b 45 14             	mov    0x14(%ebp),%eax
    1214:	8b 00                	mov    (%eax),%eax
    1216:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1219:	0f 8c 25 01 00 00    	jl     1344 <APDcCopy+0x1a1>
    121f:	8b 45 14             	mov    0x14(%ebp),%eax
    1222:	8b 40 04             	mov    0x4(%eax),%eax
    1225:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1228:	0f 8c 16 01 00 00    	jl     1344 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    122e:	8b 45 08             	mov    0x8(%ebp),%eax
    1231:	8b 00                	mov    (%eax),%eax
    1233:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1236:	7f 0b                	jg     1243 <APDcCopy+0xa0>
    1238:	8b 45 08             	mov    0x8(%ebp),%eax
    123b:	8b 00                	mov    (%eax),%eax
    123d:	83 e8 01             	sub    $0x1,%eax
    1240:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1243:	8b 45 08             	mov    0x8(%ebp),%eax
    1246:	8b 40 04             	mov    0x4(%eax),%eax
    1249:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    124c:	7f 0c                	jg     125a <APDcCopy+0xb7>
    124e:	8b 45 08             	mov    0x8(%ebp),%eax
    1251:	8b 40 04             	mov    0x4(%eax),%eax
    1254:	83 e8 01             	sub    $0x1,%eax
    1257:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    125a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1261:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1268:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    126f:	e9 bc 00 00 00       	jmp    1330 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1274:	8b 45 08             	mov    0x8(%ebp),%eax
    1277:	8b 00                	mov    (%eax),%eax
    1279:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    127c:	8b 55 10             	mov    0x10(%ebp),%edx
    127f:	01 ca                	add    %ecx,%edx
    1281:	0f af d0             	imul   %eax,%edx
    1284:	8b 45 0c             	mov    0xc(%ebp),%eax
    1287:	01 d0                	add    %edx,%eax
    1289:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    128c:	8b 45 14             	mov    0x14(%ebp),%eax
    128f:	8b 00                	mov    (%eax),%eax
    1291:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1294:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1297:	01 ca                	add    %ecx,%edx
    1299:	0f af d0             	imul   %eax,%edx
    129c:	8b 45 18             	mov    0x18(%ebp),%eax
    129f:	01 d0                	add    %edx,%eax
    12a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    12a4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12ab:	eb 74                	jmp    1321 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    12ad:	8b 45 14             	mov    0x14(%ebp),%eax
    12b0:	8b 50 18             	mov    0x18(%eax),%edx
    12b3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12b9:	01 c8                	add    %ecx,%eax
    12bb:	89 c1                	mov    %eax,%ecx
    12bd:	89 c8                	mov    %ecx,%eax
    12bf:	01 c0                	add    %eax,%eax
    12c1:	01 c8                	add    %ecx,%eax
    12c3:	01 d0                	add    %edx,%eax
    12c5:	0f b7 10             	movzwl (%eax),%edx
    12c8:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    12cc:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    12d0:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    12d3:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    12d7:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    12db:	38 c2                	cmp    %al,%dl
    12dd:	75 18                	jne    12f7 <APDcCopy+0x154>
    12df:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    12e3:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    12e7:	38 c2                	cmp    %al,%dl
    12e9:	75 0c                	jne    12f7 <APDcCopy+0x154>
    12eb:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    12ef:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    12f3:	38 c2                	cmp    %al,%dl
    12f5:	74 26                	je     131d <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    12f7:	8b 45 08             	mov    0x8(%ebp),%eax
    12fa:	8b 50 18             	mov    0x18(%eax),%edx
    12fd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1300:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1303:	01 c8                	add    %ecx,%eax
    1305:	89 c1                	mov    %eax,%ecx
    1307:	89 c8                	mov    %ecx,%eax
    1309:	01 c0                	add    %eax,%eax
    130b:	01 c8                	add    %ecx,%eax
    130d:	01 d0                	add    %edx,%eax
    130f:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1313:	66 89 10             	mov    %dx,(%eax)
    1316:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    131a:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    131d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1321:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1324:	2b 45 0c             	sub    0xc(%ebp),%eax
    1327:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    132a:	7d 81                	jge    12ad <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    132c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1330:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1333:	2b 45 10             	sub    0x10(%ebp),%eax
    1336:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1339:	0f 8d 35 ff ff ff    	jge    1274 <APDcCopy+0xd1>
    133f:	eb 04                	jmp    1345 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1341:	90                   	nop
    1342:	eb 01                	jmp    1345 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1344:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1345:	c9                   	leave  
    1346:	c3                   	ret    

00001347 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1347:	55                   	push   %ebp
    1348:	89 e5                	mov    %esp,%ebp
    134a:	83 ec 1c             	sub    $0x1c,%esp
    134d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1350:	8b 55 10             	mov    0x10(%ebp),%edx
    1353:	8b 45 14             	mov    0x14(%ebp),%eax
    1356:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1359:	88 55 e8             	mov    %dl,-0x18(%ebp)
    135c:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    135f:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1363:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1366:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    136a:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    136d:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1371:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1374:	8b 45 08             	mov    0x8(%ebp),%eax
    1377:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    137b:	66 89 10             	mov    %dx,(%eax)
    137e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1382:	88 50 02             	mov    %dl,0x2(%eax)
}
    1385:	8b 45 08             	mov    0x8(%ebp),%eax
    1388:	c9                   	leave  
    1389:	c2 04 00             	ret    $0x4

0000138c <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    138c:	55                   	push   %ebp
    138d:	89 e5                	mov    %esp,%ebp
    138f:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1392:	8b 45 08             	mov    0x8(%ebp),%eax
    1395:	8b 00                	mov    (%eax),%eax
    1397:	83 ec 08             	sub    $0x8,%esp
    139a:	8d 55 0c             	lea    0xc(%ebp),%edx
    139d:	52                   	push   %edx
    139e:	50                   	push   %eax
    139f:	e8 87 ef ff ff       	call   32b <sendMessage>
    13a4:	83 c4 10             	add    $0x10,%esp
}
    13a7:	90                   	nop
    13a8:	c9                   	leave  
    13a9:	c3                   	ret    

000013aa <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    13aa:	55                   	push   %ebp
    13ab:	89 e5                	mov    %esp,%ebp
    13ad:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    13b0:	83 ec 0c             	sub    $0xc,%esp
    13b3:	68 98 00 00 00       	push   $0x98
    13b8:	e8 38 f3 ff ff       	call   6f5 <malloc>
    13bd:	83 c4 10             	add    $0x10,%esp
    13c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    13c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13c7:	75 15                	jne    13de <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    13c9:	83 ec 04             	sub    $0x4,%esp
    13cc:	ff 75 08             	pushl  0x8(%ebp)
    13cf:	68 fc 21 00 00       	push   $0x21fc
    13d4:	6a 01                	push   $0x1
    13d6:	e8 47 f0 ff ff       	call   422 <printf>
    13db:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    13de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13e1:	05 84 00 00 00       	add    $0x84,%eax
    13e6:	83 ec 08             	sub    $0x8,%esp
    13e9:	ff 75 08             	pushl  0x8(%ebp)
    13ec:	50                   	push   %eax
    13ed:	e8 60 ec ff ff       	call   52 <strcpy>
    13f2:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    13f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f8:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    13ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1402:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1409:	8b 45 f4             	mov    -0xc(%ebp),%eax
    140c:	8b 40 3c             	mov    0x3c(%eax),%eax
    140f:	89 c2                	mov    %eax,%edx
    1411:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1414:	8b 40 40             	mov    0x40(%eax),%eax
    1417:	0f af d0             	imul   %eax,%edx
    141a:	89 d0                	mov    %edx,%eax
    141c:	01 c0                	add    %eax,%eax
    141e:	01 d0                	add    %edx,%eax
    1420:	83 ec 0c             	sub    $0xc,%esp
    1423:	50                   	push   %eax
    1424:	e8 cc f2 ff ff       	call   6f5 <malloc>
    1429:	83 c4 10             	add    $0x10,%esp
    142c:	89 c2                	mov    %eax,%edx
    142e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1431:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1434:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1437:	8b 40 54             	mov    0x54(%eax),%eax
    143a:	85 c0                	test   %eax,%eax
    143c:	75 15                	jne    1453 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    143e:	83 ec 04             	sub    $0x4,%esp
    1441:	ff 75 08             	pushl  0x8(%ebp)
    1444:	68 1c 22 00 00       	push   $0x221c
    1449:	6a 01                	push   $0x1
    144b:	e8 d2 ef ff ff       	call   422 <printf>
    1450:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1453:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1456:	8b 40 3c             	mov    0x3c(%eax),%eax
    1459:	89 c2                	mov    %eax,%edx
    145b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145e:	8b 40 40             	mov    0x40(%eax),%eax
    1461:	0f af d0             	imul   %eax,%edx
    1464:	89 d0                	mov    %edx,%eax
    1466:	01 c0                	add    %eax,%eax
    1468:	01 c2                	add    %eax,%edx
    146a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    146d:	8b 40 54             	mov    0x54(%eax),%eax
    1470:	83 ec 04             	sub    $0x4,%esp
    1473:	52                   	push   %edx
    1474:	68 ff ff ff 00       	push   $0xffffff
    1479:	50                   	push   %eax
    147a:	e8 69 ec ff ff       	call   e8 <memset>
    147f:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1482:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1485:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    148c:	e8 72 ee ff ff       	call   303 <getpid>
    1491:	89 c2                	mov    %eax,%edx
    1493:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1496:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1499:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149c:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a6:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    14ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b0:	8b 40 58             	mov    0x58(%eax),%eax
    14b3:	89 c2                	mov    %eax,%edx
    14b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b8:	8b 40 5c             	mov    0x5c(%eax),%eax
    14bb:	0f af d0             	imul   %eax,%edx
    14be:	89 d0                	mov    %edx,%eax
    14c0:	01 c0                	add    %eax,%eax
    14c2:	01 d0                	add    %edx,%eax
    14c4:	83 ec 0c             	sub    $0xc,%esp
    14c7:	50                   	push   %eax
    14c8:	e8 28 f2 ff ff       	call   6f5 <malloc>
    14cd:	83 c4 10             	add    $0x10,%esp
    14d0:	89 c2                	mov    %eax,%edx
    14d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d5:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    14d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14db:	8b 40 70             	mov    0x70(%eax),%eax
    14de:	85 c0                	test   %eax,%eax
    14e0:	75 15                	jne    14f7 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    14e2:	83 ec 04             	sub    $0x4,%esp
    14e5:	ff 75 08             	pushl  0x8(%ebp)
    14e8:	68 40 22 00 00       	push   $0x2240
    14ed:	6a 01                	push   $0x1
    14ef:	e8 2e ef ff ff       	call   422 <printf>
    14f4:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14fa:	8b 40 3c             	mov    0x3c(%eax),%eax
    14fd:	89 c2                	mov    %eax,%edx
    14ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1502:	8b 40 40             	mov    0x40(%eax),%eax
    1505:	0f af d0             	imul   %eax,%edx
    1508:	89 d0                	mov    %edx,%eax
    150a:	01 c0                	add    %eax,%eax
    150c:	01 c2                	add    %eax,%edx
    150e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1511:	8b 40 54             	mov    0x54(%eax),%eax
    1514:	83 ec 04             	sub    $0x4,%esp
    1517:	52                   	push   %edx
    1518:	68 ff 00 00 00       	push   $0xff
    151d:	50                   	push   %eax
    151e:	e8 c5 eb ff ff       	call   e8 <memset>
    1523:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1526:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1529:	8b 55 0c             	mov    0xc(%ebp),%edx
    152c:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    152f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1533:	74 49                	je     157e <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1535:	8b 45 10             	mov    0x10(%ebp),%eax
    1538:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    153e:	83 ec 0c             	sub    $0xc,%esp
    1541:	50                   	push   %eax
    1542:	e8 ae f1 ff ff       	call   6f5 <malloc>
    1547:	83 c4 10             	add    $0x10,%esp
    154a:	89 c2                	mov    %eax,%edx
    154c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154f:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1552:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1555:	8b 55 10             	mov    0x10(%ebp),%edx
    1558:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    155b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155e:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1565:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1568:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    156f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1572:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1579:	e9 8d 00 00 00       	jmp    160b <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    157e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1581:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1588:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158b:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1592:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1595:	8b 40 20             	mov    0x20(%eax),%eax
    1598:	89 c2                	mov    %eax,%edx
    159a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159d:	8b 40 24             	mov    0x24(%eax),%eax
    15a0:	0f af d0             	imul   %eax,%edx
    15a3:	89 d0                	mov    %edx,%eax
    15a5:	01 c0                	add    %eax,%eax
    15a7:	01 d0                	add    %edx,%eax
    15a9:	83 ec 0c             	sub    $0xc,%esp
    15ac:	50                   	push   %eax
    15ad:	e8 43 f1 ff ff       	call   6f5 <malloc>
    15b2:	83 c4 10             	add    $0x10,%esp
    15b5:	89 c2                	mov    %eax,%edx
    15b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ba:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    15bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c0:	8b 40 38             	mov    0x38(%eax),%eax
    15c3:	85 c0                	test   %eax,%eax
    15c5:	75 15                	jne    15dc <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    15c7:	83 ec 04             	sub    $0x4,%esp
    15ca:	ff 75 08             	pushl  0x8(%ebp)
    15cd:	68 68 22 00 00       	push   $0x2268
    15d2:	6a 01                	push   $0x1
    15d4:	e8 49 ee ff ff       	call   422 <printf>
    15d9:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15df:	8b 40 20             	mov    0x20(%eax),%eax
    15e2:	89 c2                	mov    %eax,%edx
    15e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e7:	8b 40 24             	mov    0x24(%eax),%eax
    15ea:	0f af d0             	imul   %eax,%edx
    15ed:	89 d0                	mov    %edx,%eax
    15ef:	01 c0                	add    %eax,%eax
    15f1:	01 c2                	add    %eax,%edx
    15f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f6:	8b 40 38             	mov    0x38(%eax),%eax
    15f9:	83 ec 04             	sub    $0x4,%esp
    15fc:	52                   	push   %edx
    15fd:	68 ff ff ff 00       	push   $0xffffff
    1602:	50                   	push   %eax
    1603:	e8 e0 ea ff ff       	call   e8 <memset>
    1608:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    160b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    160e:	c9                   	leave  
    160f:	c3                   	ret    

00001610 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1610:	55                   	push   %ebp
    1611:	89 e5                	mov    %esp,%ebp
    1613:	57                   	push   %edi
    1614:	56                   	push   %esi
    1615:	53                   	push   %ebx
    1616:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1619:	8b 45 0c             	mov    0xc(%ebp),%eax
    161c:	83 f8 03             	cmp    $0x3,%eax
    161f:	74 02                	je     1623 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1621:	eb 7c                	jmp    169f <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1623:	8b 45 08             	mov    0x8(%ebp),%eax
    1626:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1629:	8b 45 08             	mov    0x8(%ebp),%eax
    162c:	8b 48 18             	mov    0x18(%eax),%ecx
    162f:	8b 45 08             	mov    0x8(%ebp),%eax
    1632:	8b 50 5c             	mov    0x5c(%eax),%edx
    1635:	8b 45 08             	mov    0x8(%ebp),%eax
    1638:	8b 40 58             	mov    0x58(%eax),%eax
    163b:	8b 75 08             	mov    0x8(%ebp),%esi
    163e:	83 c6 58             	add    $0x58,%esi
    1641:	83 ec 04             	sub    $0x4,%esp
    1644:	53                   	push   %ebx
    1645:	51                   	push   %ecx
    1646:	6a 00                	push   $0x0
    1648:	52                   	push   %edx
    1649:	50                   	push   %eax
    164a:	6a 00                	push   $0x0
    164c:	6a 00                	push   $0x0
    164e:	56                   	push   %esi
    164f:	6a 00                	push   $0x0
    1651:	6a 00                	push   $0x0
    1653:	ff 75 08             	pushl  0x8(%ebp)
    1656:	e8 c8 ec ff ff       	call   323 <paintWindow>
    165b:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    165e:	8b 45 08             	mov    0x8(%ebp),%eax
    1661:	8b 70 1c             	mov    0x1c(%eax),%esi
    1664:	8b 45 08             	mov    0x8(%ebp),%eax
    1667:	8b 58 18             	mov    0x18(%eax),%ebx
    166a:	8b 45 08             	mov    0x8(%ebp),%eax
    166d:	8b 48 08             	mov    0x8(%eax),%ecx
    1670:	8b 45 08             	mov    0x8(%ebp),%eax
    1673:	8b 50 40             	mov    0x40(%eax),%edx
    1676:	8b 45 08             	mov    0x8(%ebp),%eax
    1679:	8b 40 3c             	mov    0x3c(%eax),%eax
    167c:	8b 7d 08             	mov    0x8(%ebp),%edi
    167f:	83 c7 3c             	add    $0x3c,%edi
    1682:	83 ec 04             	sub    $0x4,%esp
    1685:	56                   	push   %esi
    1686:	53                   	push   %ebx
    1687:	51                   	push   %ecx
    1688:	52                   	push   %edx
    1689:	50                   	push   %eax
    168a:	6a 00                	push   $0x0
    168c:	6a 00                	push   $0x0
    168e:	57                   	push   %edi
    168f:	6a 32                	push   $0x32
    1691:	6a 00                	push   $0x0
    1693:	ff 75 08             	pushl  0x8(%ebp)
    1696:	e8 88 ec ff ff       	call   323 <paintWindow>
    169b:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    169e:	90                   	nop
        default: break;
            
            
    }
    return False;
    169f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    16a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16a7:	5b                   	pop    %ebx
    16a8:	5e                   	pop    %esi
    16a9:	5f                   	pop    %edi
    16aa:	5d                   	pop    %ebp
    16ab:	c3                   	ret    

000016ac <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    16ac:	55                   	push   %ebp
    16ad:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    16af:	8b 45 0c             	mov    0xc(%ebp),%eax
    16b2:	8b 50 08             	mov    0x8(%eax),%edx
    16b5:	8b 45 08             	mov    0x8(%ebp),%eax
    16b8:	8b 00                	mov    (%eax),%eax
    16ba:	39 c2                	cmp    %eax,%edx
    16bc:	74 07                	je     16c5 <APPreJudge+0x19>
        return False;
    16be:	b8 00 00 00 00       	mov    $0x0,%eax
    16c3:	eb 05                	jmp    16ca <APPreJudge+0x1e>
    return True;
    16c5:	b8 01 00 00 00       	mov    $0x1,%eax
}
    16ca:	5d                   	pop    %ebp
    16cb:	c3                   	ret    

000016cc <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    16cc:	55                   	push   %ebp
    16cd:	89 e5                	mov    %esp,%ebp
    16cf:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    16d2:	8b 45 08             	mov    0x8(%ebp),%eax
    16d5:	8b 55 0c             	mov    0xc(%ebp),%edx
    16d8:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    16de:	83 ec 0c             	sub    $0xc,%esp
    16e1:	ff 75 08             	pushl  0x8(%ebp)
    16e4:	e8 52 ec ff ff       	call   33b <registWindow>
    16e9:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    16ec:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    16f3:	8b 45 08             	mov    0x8(%ebp),%eax
    16f6:	8b 00                	mov    (%eax),%eax
    16f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    16fb:	ff 75 f4             	pushl  -0xc(%ebp)
    16fe:	ff 75 f0             	pushl  -0x10(%ebp)
    1701:	ff 75 ec             	pushl  -0x14(%ebp)
    1704:	ff 75 08             	pushl  0x8(%ebp)
    1707:	e8 80 fc ff ff       	call   138c <APSendMessage>
    170c:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    170f:	83 ec 0c             	sub    $0xc,%esp
    1712:	ff 75 08             	pushl  0x8(%ebp)
    1715:	e8 19 ec ff ff       	call   333 <getMessage>
    171a:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    171d:	8b 45 08             	mov    0x8(%ebp),%eax
    1720:	83 c0 74             	add    $0x74,%eax
    1723:	83 ec 08             	sub    $0x8,%esp
    1726:	50                   	push   %eax
    1727:	ff 75 08             	pushl  0x8(%ebp)
    172a:	e8 7d ff ff ff       	call   16ac <APPreJudge>
    172f:	83 c4 10             	add    $0x10,%esp
    1732:	84 c0                	test   %al,%al
    1734:	74 1b                	je     1751 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1736:	8b 45 08             	mov    0x8(%ebp),%eax
    1739:	ff 70 7c             	pushl  0x7c(%eax)
    173c:	ff 70 78             	pushl  0x78(%eax)
    173f:	ff 70 74             	pushl  0x74(%eax)
    1742:	ff 75 08             	pushl  0x8(%ebp)
    1745:	8b 45 0c             	mov    0xc(%ebp),%eax
    1748:	ff d0                	call   *%eax
    174a:	83 c4 10             	add    $0x10,%esp
    174d:	84 c0                	test   %al,%al
    174f:	75 0c                	jne    175d <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1751:	8b 45 08             	mov    0x8(%ebp),%eax
    1754:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    175b:	eb b2                	jmp    170f <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    175d:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    175e:	90                   	nop
    175f:	c9                   	leave  
    1760:	c3                   	ret    

00001761 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1761:	55                   	push   %ebp
    1762:	89 e5                	mov    %esp,%ebp
    1764:	57                   	push   %edi
    1765:	56                   	push   %esi
    1766:	53                   	push   %ebx
    1767:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    176a:	a1 ec 28 00 00       	mov    0x28ec,%eax
    176f:	85 c0                	test   %eax,%eax
    1771:	0f 85 2c 02 00 00    	jne    19a3 <APGridPaint+0x242>
    {
        iconReady = 1;
    1777:	c7 05 ec 28 00 00 01 	movl   $0x1,0x28ec
    177e:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1781:	8d 45 98             	lea    -0x68(%ebp),%eax
    1784:	83 ec 08             	sub    $0x8,%esp
    1787:	68 8f 22 00 00       	push   $0x228f
    178c:	50                   	push   %eax
    178d:	e8 16 f1 ff ff       	call   8a8 <APLoadBitmap>
    1792:	83 c4 0c             	add    $0xc,%esp
    1795:	8b 45 98             	mov    -0x68(%ebp),%eax
    1798:	a3 10 29 00 00       	mov    %eax,0x2910
    179d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17a0:	a3 14 29 00 00       	mov    %eax,0x2914
    17a5:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17a8:	a3 18 29 00 00       	mov    %eax,0x2918
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    17ad:	83 ec 04             	sub    $0x4,%esp
    17b0:	ff 35 18 29 00 00    	pushl  0x2918
    17b6:	ff 35 14 29 00 00    	pushl  0x2914
    17bc:	ff 35 10 29 00 00    	pushl  0x2910
    17c2:	e8 1b f3 ff ff       	call   ae2 <APCreateCompatibleDCFromBitmap>
    17c7:	83 c4 10             	add    $0x10,%esp
    17ca:	a3 1c 29 00 00       	mov    %eax,0x291c
        grid_river = APLoadBitmap ("grid_river.bmp");
    17cf:	8d 45 98             	lea    -0x68(%ebp),%eax
    17d2:	83 ec 08             	sub    $0x8,%esp
    17d5:	68 9d 22 00 00       	push   $0x229d
    17da:	50                   	push   %eax
    17db:	e8 c8 f0 ff ff       	call   8a8 <APLoadBitmap>
    17e0:	83 c4 0c             	add    $0xc,%esp
    17e3:	8b 45 98             	mov    -0x68(%ebp),%eax
    17e6:	a3 4c 29 00 00       	mov    %eax,0x294c
    17eb:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17ee:	a3 50 29 00 00       	mov    %eax,0x2950
    17f3:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17f6:	a3 54 29 00 00       	mov    %eax,0x2954
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    17fb:	83 ec 04             	sub    $0x4,%esp
    17fe:	ff 35 54 29 00 00    	pushl  0x2954
    1804:	ff 35 50 29 00 00    	pushl  0x2950
    180a:	ff 35 4c 29 00 00    	pushl  0x294c
    1810:	e8 cd f2 ff ff       	call   ae2 <APCreateCompatibleDCFromBitmap>
    1815:	83 c4 10             	add    $0x10,%esp
    1818:	a3 3c 29 00 00       	mov    %eax,0x293c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    181d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1820:	83 ec 08             	sub    $0x8,%esp
    1823:	68 ac 22 00 00       	push   $0x22ac
    1828:	50                   	push   %eax
    1829:	e8 7a f0 ff ff       	call   8a8 <APLoadBitmap>
    182e:	83 c4 0c             	add    $0xc,%esp
    1831:	8b 45 98             	mov    -0x68(%ebp),%eax
    1834:	a3 40 29 00 00       	mov    %eax,0x2940
    1839:	8b 45 9c             	mov    -0x64(%ebp),%eax
    183c:	a3 44 29 00 00       	mov    %eax,0x2944
    1841:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1844:	a3 48 29 00 00       	mov    %eax,0x2948
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1849:	83 ec 04             	sub    $0x4,%esp
    184c:	ff 35 48 29 00 00    	pushl  0x2948
    1852:	ff 35 44 29 00 00    	pushl  0x2944
    1858:	ff 35 40 29 00 00    	pushl  0x2940
    185e:	e8 7f f2 ff ff       	call   ae2 <APCreateCompatibleDCFromBitmap>
    1863:	83 c4 10             	add    $0x10,%esp
    1866:	a3 f0 28 00 00       	mov    %eax,0x28f0
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    186b:	8d 45 98             	lea    -0x68(%ebp),%eax
    186e:	83 ec 08             	sub    $0x8,%esp
    1871:	68 bb 22 00 00       	push   $0x22bb
    1876:	50                   	push   %eax
    1877:	e8 2c f0 ff ff       	call   8a8 <APLoadBitmap>
    187c:	83 c4 0c             	add    $0xc,%esp
    187f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1882:	a3 24 29 00 00       	mov    %eax,0x2924
    1887:	8b 45 9c             	mov    -0x64(%ebp),%eax
    188a:	a3 28 29 00 00       	mov    %eax,0x2928
    188f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1892:	a3 2c 29 00 00       	mov    %eax,0x292c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1897:	83 ec 04             	sub    $0x4,%esp
    189a:	ff 35 2c 29 00 00    	pushl  0x292c
    18a0:	ff 35 28 29 00 00    	pushl  0x2928
    18a6:	ff 35 24 29 00 00    	pushl  0x2924
    18ac:	e8 31 f2 ff ff       	call   ae2 <APCreateCompatibleDCFromBitmap>
    18b1:	83 c4 10             	add    $0x10,%esp
    18b4:	a3 58 29 00 00       	mov    %eax,0x2958
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    18b9:	8d 45 98             	lea    -0x68(%ebp),%eax
    18bc:	83 ec 08             	sub    $0x8,%esp
    18bf:	68 c9 22 00 00       	push   $0x22c9
    18c4:	50                   	push   %eax
    18c5:	e8 de ef ff ff       	call   8a8 <APLoadBitmap>
    18ca:	83 c4 0c             	add    $0xc,%esp
    18cd:	8b 45 98             	mov    -0x68(%ebp),%eax
    18d0:	a3 00 29 00 00       	mov    %eax,0x2900
    18d5:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18d8:	a3 04 29 00 00       	mov    %eax,0x2904
    18dd:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18e0:	a3 08 29 00 00       	mov    %eax,0x2908
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    18e5:	83 ec 04             	sub    $0x4,%esp
    18e8:	ff 35 08 29 00 00    	pushl  0x2908
    18ee:	ff 35 04 29 00 00    	pushl  0x2904
    18f4:	ff 35 00 29 00 00    	pushl  0x2900
    18fa:	e8 e3 f1 ff ff       	call   ae2 <APCreateCompatibleDCFromBitmap>
    18ff:	83 c4 10             	add    $0x10,%esp
    1902:	a3 20 29 00 00       	mov    %eax,0x2920
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1907:	8d 45 98             	lea    -0x68(%ebp),%eax
    190a:	83 ec 08             	sub    $0x8,%esp
    190d:	68 d9 22 00 00       	push   $0x22d9
    1912:	50                   	push   %eax
    1913:	e8 90 ef ff ff       	call   8a8 <APLoadBitmap>
    1918:	83 c4 0c             	add    $0xc,%esp
    191b:	8b 45 98             	mov    -0x68(%ebp),%eax
    191e:	a3 f4 28 00 00       	mov    %eax,0x28f4
    1923:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1926:	a3 f8 28 00 00       	mov    %eax,0x28f8
    192b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    192e:	a3 fc 28 00 00       	mov    %eax,0x28fc
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1933:	83 ec 04             	sub    $0x4,%esp
    1936:	ff 35 fc 28 00 00    	pushl  0x28fc
    193c:	ff 35 f8 28 00 00    	pushl  0x28f8
    1942:	ff 35 f4 28 00 00    	pushl  0x28f4
    1948:	e8 95 f1 ff ff       	call   ae2 <APCreateCompatibleDCFromBitmap>
    194d:	83 c4 10             	add    $0x10,%esp
    1950:	a3 0c 29 00 00       	mov    %eax,0x290c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1955:	8d 45 98             	lea    -0x68(%ebp),%eax
    1958:	83 ec 08             	sub    $0x8,%esp
    195b:	68 eb 22 00 00       	push   $0x22eb
    1960:	50                   	push   %eax
    1961:	e8 42 ef ff ff       	call   8a8 <APLoadBitmap>
    1966:	83 c4 0c             	add    $0xc,%esp
    1969:	8b 45 98             	mov    -0x68(%ebp),%eax
    196c:	a3 30 29 00 00       	mov    %eax,0x2930
    1971:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1974:	a3 34 29 00 00       	mov    %eax,0x2934
    1979:	8b 45 a0             	mov    -0x60(%ebp),%eax
    197c:	a3 38 29 00 00       	mov    %eax,0x2938
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1981:	83 ec 04             	sub    $0x4,%esp
    1984:	ff 35 38 29 00 00    	pushl  0x2938
    198a:	ff 35 34 29 00 00    	pushl  0x2934
    1990:	ff 35 30 29 00 00    	pushl  0x2930
    1996:	e8 47 f1 ff ff       	call   ae2 <APCreateCompatibleDCFromBitmap>
    199b:	83 c4 10             	add    $0x10,%esp
    199e:	a3 5c 29 00 00       	mov    %eax,0x295c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    19a3:	8b 45 08             	mov    0x8(%ebp),%eax
    19a6:	8b 40 08             	mov    0x8(%eax),%eax
    19a9:	85 c0                	test   %eax,%eax
    19ab:	75 17                	jne    19c4 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    19ad:	83 ec 08             	sub    $0x8,%esp
    19b0:	68 fc 22 00 00       	push   $0x22fc
    19b5:	6a 01                	push   $0x1
    19b7:	e8 66 ea ff ff       	call   422 <printf>
    19bc:	83 c4 10             	add    $0x10,%esp
        return;
    19bf:	e9 a0 04 00 00       	jmp    1e64 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    19c4:	8b 45 08             	mov    0x8(%ebp),%eax
    19c7:	8b 40 10             	mov    0x10(%eax),%eax
    19ca:	85 c0                	test   %eax,%eax
    19cc:	7e 10                	jle    19de <APGridPaint+0x27d>
    19ce:	8b 45 08             	mov    0x8(%ebp),%eax
    19d1:	8b 50 14             	mov    0x14(%eax),%edx
    19d4:	8b 45 08             	mov    0x8(%ebp),%eax
    19d7:	8b 40 10             	mov    0x10(%eax),%eax
    19da:	39 c2                	cmp    %eax,%edx
    19dc:	7c 17                	jl     19f5 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    19de:	83 ec 08             	sub    $0x8,%esp
    19e1:	68 22 23 00 00       	push   $0x2322
    19e6:	6a 01                	push   $0x1
    19e8:	e8 35 ea ff ff       	call   422 <printf>
    19ed:	83 c4 10             	add    $0x10,%esp
        return;
    19f0:	e9 6f 04 00 00       	jmp    1e64 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    19f5:	8b 45 08             	mov    0x8(%ebp),%eax
    19f8:	8b 40 14             	mov    0x14(%eax),%eax
    19fb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a01:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a04:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a07:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a0a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a11:	e9 96 03 00 00       	jmp    1dac <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a16:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a1d:	e9 7c 03 00 00       	jmp    1d9e <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a25:	c1 e0 04             	shl    $0x4,%eax
    1a28:	89 c2                	mov    %eax,%edx
    1a2a:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a2d:	01 c2                	add    %eax,%edx
    1a2f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a32:	01 d0                	add    %edx,%eax
    1a34:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a37:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3a:	8b 40 0c             	mov    0xc(%eax),%eax
    1a3d:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a40:	c1 e2 02             	shl    $0x2,%edx
    1a43:	01 d0                	add    %edx,%eax
    1a45:	8b 00                	mov    (%eax),%eax
    1a47:	83 f8 07             	cmp    $0x7,%eax
    1a4a:	0f 87 49 03 00 00    	ja     1d99 <APGridPaint+0x638>
    1a50:	8b 04 85 38 23 00 00 	mov    0x2338(,%eax,4),%eax
    1a57:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1a59:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1a5c:	6a 0c                	push   $0xc
    1a5e:	6a 0c                	push   $0xc
    1a60:	6a 0c                	push   $0xc
    1a62:	50                   	push   %eax
    1a63:	e8 df f8 ff ff       	call   1347 <RGB>
    1a68:	83 c4 0c             	add    $0xc,%esp
    1a6b:	8b 1d 1c 29 00 00    	mov    0x291c,%ebx
    1a71:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a74:	6b c8 32             	imul   $0x32,%eax,%ecx
    1a77:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a7a:	6b c0 32             	imul   $0x32,%eax,%eax
    1a7d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1a80:	8b 45 08             	mov    0x8(%ebp),%eax
    1a83:	8d 78 3c             	lea    0x3c(%eax),%edi
    1a86:	83 ec 0c             	sub    $0xc,%esp
    1a89:	83 ec 04             	sub    $0x4,%esp
    1a8c:	89 e0                	mov    %esp,%eax
    1a8e:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1a92:	66 89 30             	mov    %si,(%eax)
    1a95:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1a99:	88 50 02             	mov    %dl,0x2(%eax)
    1a9c:	6a 32                	push   $0x32
    1a9e:	6a 32                	push   $0x32
    1aa0:	6a 00                	push   $0x0
    1aa2:	6a 00                	push   $0x0
    1aa4:	53                   	push   %ebx
    1aa5:	51                   	push   %ecx
    1aa6:	ff 75 94             	pushl  -0x6c(%ebp)
    1aa9:	57                   	push   %edi
    1aaa:	e8 f4 f6 ff ff       	call   11a3 <APDcCopy>
    1aaf:	83 c4 30             	add    $0x30,%esp
                    break;
    1ab2:	e9 e3 02 00 00       	jmp    1d9a <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1ab7:	8d 45 98             	lea    -0x68(%ebp),%eax
    1aba:	6a 69                	push   $0x69
    1abc:	6a 69                	push   $0x69
    1abe:	6a 69                	push   $0x69
    1ac0:	50                   	push   %eax
    1ac1:	e8 81 f8 ff ff       	call   1347 <RGB>
    1ac6:	83 c4 0c             	add    $0xc,%esp
    1ac9:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1acd:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1ad1:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ad5:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1ad8:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1adf:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ae2:	6a 69                	push   $0x69
    1ae4:	6a 69                	push   $0x69
    1ae6:	6a 69                	push   $0x69
    1ae8:	50                   	push   %eax
    1ae9:	e8 59 f8 ff ff       	call   1347 <RGB>
    1aee:	83 c4 0c             	add    $0xc,%esp
    1af1:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1af5:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1af9:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1afd:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b00:	8b 45 08             	mov    0x8(%ebp),%eax
    1b03:	8d 50 3c             	lea    0x3c(%eax),%edx
    1b06:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b09:	ff 75 b0             	pushl  -0x50(%ebp)
    1b0c:	ff 75 ac             	pushl  -0x54(%ebp)
    1b0f:	52                   	push   %edx
    1b10:	50                   	push   %eax
    1b11:	e8 61 f0 ff ff       	call   b77 <APSetPen>
    1b16:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b19:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1c:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1b1f:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b22:	83 ec 04             	sub    $0x4,%esp
    1b25:	83 ec 04             	sub    $0x4,%esp
    1b28:	89 e0                	mov    %esp,%eax
    1b2a:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1b2e:	66 89 08             	mov    %cx,(%eax)
    1b31:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1b35:	88 48 02             	mov    %cl,0x2(%eax)
    1b38:	53                   	push   %ebx
    1b39:	52                   	push   %edx
    1b3a:	e8 71 f0 ff ff       	call   bb0 <APSetBrush>
    1b3f:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b45:	6b d0 32             	imul   $0x32,%eax,%edx
    1b48:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b4b:	6b c0 32             	imul   $0x32,%eax,%eax
    1b4e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b51:	83 c1 3c             	add    $0x3c,%ecx
    1b54:	83 ec 0c             	sub    $0xc,%esp
    1b57:	6a 32                	push   $0x32
    1b59:	6a 32                	push   $0x32
    1b5b:	52                   	push   %edx
    1b5c:	50                   	push   %eax
    1b5d:	51                   	push   %ecx
    1b5e:	e8 35 f4 ff ff       	call   f98 <APDrawRect>
    1b63:	83 c4 20             	add    $0x20,%esp
                    break;
    1b66:	e9 2f 02 00 00       	jmp    1d9a <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b6b:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1b6e:	6a 0c                	push   $0xc
    1b70:	6a 0c                	push   $0xc
    1b72:	6a 0c                	push   $0xc
    1b74:	50                   	push   %eax
    1b75:	e8 cd f7 ff ff       	call   1347 <RGB>
    1b7a:	83 c4 0c             	add    $0xc,%esp
    1b7d:	8b 1d 5c 29 00 00    	mov    0x295c,%ebx
    1b83:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b86:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b89:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b8c:	6b c0 32             	imul   $0x32,%eax,%eax
    1b8f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b92:	8b 45 08             	mov    0x8(%ebp),%eax
    1b95:	8d 78 3c             	lea    0x3c(%eax),%edi
    1b98:	83 ec 0c             	sub    $0xc,%esp
    1b9b:	83 ec 04             	sub    $0x4,%esp
    1b9e:	89 e0                	mov    %esp,%eax
    1ba0:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1ba4:	66 89 30             	mov    %si,(%eax)
    1ba7:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1bab:	88 50 02             	mov    %dl,0x2(%eax)
    1bae:	6a 32                	push   $0x32
    1bb0:	6a 32                	push   $0x32
    1bb2:	6a 00                	push   $0x0
    1bb4:	6a 00                	push   $0x0
    1bb6:	53                   	push   %ebx
    1bb7:	51                   	push   %ecx
    1bb8:	ff 75 94             	pushl  -0x6c(%ebp)
    1bbb:	57                   	push   %edi
    1bbc:	e8 e2 f5 ff ff       	call   11a3 <APDcCopy>
    1bc1:	83 c4 30             	add    $0x30,%esp
                    break;
    1bc4:	e9 d1 01 00 00       	jmp    1d9a <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bc9:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1bcc:	6a 0c                	push   $0xc
    1bce:	6a 0c                	push   $0xc
    1bd0:	6a 0c                	push   $0xc
    1bd2:	50                   	push   %eax
    1bd3:	e8 6f f7 ff ff       	call   1347 <RGB>
    1bd8:	83 c4 0c             	add    $0xc,%esp
    1bdb:	8b 1d 3c 29 00 00    	mov    0x293c,%ebx
    1be1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1be4:	6b c8 32             	imul   $0x32,%eax,%ecx
    1be7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bea:	6b c0 32             	imul   $0x32,%eax,%eax
    1bed:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bf0:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf3:	8d 78 3c             	lea    0x3c(%eax),%edi
    1bf6:	83 ec 0c             	sub    $0xc,%esp
    1bf9:	83 ec 04             	sub    $0x4,%esp
    1bfc:	89 e0                	mov    %esp,%eax
    1bfe:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1c02:	66 89 30             	mov    %si,(%eax)
    1c05:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c09:	88 50 02             	mov    %dl,0x2(%eax)
    1c0c:	6a 32                	push   $0x32
    1c0e:	6a 32                	push   $0x32
    1c10:	6a 00                	push   $0x0
    1c12:	6a 00                	push   $0x0
    1c14:	53                   	push   %ebx
    1c15:	51                   	push   %ecx
    1c16:	ff 75 94             	pushl  -0x6c(%ebp)
    1c19:	57                   	push   %edi
    1c1a:	e8 84 f5 ff ff       	call   11a3 <APDcCopy>
    1c1f:	83 c4 30             	add    $0x30,%esp
                    break;
    1c22:	e9 73 01 00 00       	jmp    1d9a <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c27:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c2a:	6a 0c                	push   $0xc
    1c2c:	6a 0c                	push   $0xc
    1c2e:	6a 0c                	push   $0xc
    1c30:	50                   	push   %eax
    1c31:	e8 11 f7 ff ff       	call   1347 <RGB>
    1c36:	83 c4 0c             	add    $0xc,%esp
    1c39:	8b 1d 20 29 00 00    	mov    0x2920,%ebx
    1c3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c42:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c45:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c48:	6b c0 32             	imul   $0x32,%eax,%eax
    1c4b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c51:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c54:	83 ec 0c             	sub    $0xc,%esp
    1c57:	83 ec 04             	sub    $0x4,%esp
    1c5a:	89 e0                	mov    %esp,%eax
    1c5c:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1c60:	66 89 30             	mov    %si,(%eax)
    1c63:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1c67:	88 50 02             	mov    %dl,0x2(%eax)
    1c6a:	6a 32                	push   $0x32
    1c6c:	6a 32                	push   $0x32
    1c6e:	6a 00                	push   $0x0
    1c70:	6a 00                	push   $0x0
    1c72:	53                   	push   %ebx
    1c73:	51                   	push   %ecx
    1c74:	ff 75 94             	pushl  -0x6c(%ebp)
    1c77:	57                   	push   %edi
    1c78:	e8 26 f5 ff ff       	call   11a3 <APDcCopy>
    1c7d:	83 c4 30             	add    $0x30,%esp
                    break;
    1c80:	e9 15 01 00 00       	jmp    1d9a <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c85:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1c88:	6a 0c                	push   $0xc
    1c8a:	6a 0c                	push   $0xc
    1c8c:	6a 0c                	push   $0xc
    1c8e:	50                   	push   %eax
    1c8f:	e8 b3 f6 ff ff       	call   1347 <RGB>
    1c94:	83 c4 0c             	add    $0xc,%esp
    1c97:	8b 1d 58 29 00 00    	mov    0x2958,%ebx
    1c9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ca0:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ca3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ca6:	6b c0 32             	imul   $0x32,%eax,%eax
    1ca9:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cac:	8b 45 08             	mov    0x8(%ebp),%eax
    1caf:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cb2:	83 ec 0c             	sub    $0xc,%esp
    1cb5:	83 ec 04             	sub    $0x4,%esp
    1cb8:	89 e0                	mov    %esp,%eax
    1cba:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1cbe:	66 89 30             	mov    %si,(%eax)
    1cc1:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1cc5:	88 50 02             	mov    %dl,0x2(%eax)
    1cc8:	6a 32                	push   $0x32
    1cca:	6a 32                	push   $0x32
    1ccc:	6a 00                	push   $0x0
    1cce:	6a 00                	push   $0x0
    1cd0:	53                   	push   %ebx
    1cd1:	51                   	push   %ecx
    1cd2:	ff 75 94             	pushl  -0x6c(%ebp)
    1cd5:	57                   	push   %edi
    1cd6:	e8 c8 f4 ff ff       	call   11a3 <APDcCopy>
    1cdb:	83 c4 30             	add    $0x30,%esp
                    break;
    1cde:	e9 b7 00 00 00       	jmp    1d9a <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ce3:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1ce6:	6a 0c                	push   $0xc
    1ce8:	6a 0c                	push   $0xc
    1cea:	6a 0c                	push   $0xc
    1cec:	50                   	push   %eax
    1ced:	e8 55 f6 ff ff       	call   1347 <RGB>
    1cf2:	83 c4 0c             	add    $0xc,%esp
    1cf5:	8b 1d f0 28 00 00    	mov    0x28f0,%ebx
    1cfb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cfe:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d01:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d04:	6b c0 32             	imul   $0x32,%eax,%eax
    1d07:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d0a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d0d:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d10:	83 ec 0c             	sub    $0xc,%esp
    1d13:	83 ec 04             	sub    $0x4,%esp
    1d16:	89 e0                	mov    %esp,%eax
    1d18:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d1c:	66 89 30             	mov    %si,(%eax)
    1d1f:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d23:	88 50 02             	mov    %dl,0x2(%eax)
    1d26:	6a 32                	push   $0x32
    1d28:	6a 32                	push   $0x32
    1d2a:	6a 00                	push   $0x0
    1d2c:	6a 00                	push   $0x0
    1d2e:	53                   	push   %ebx
    1d2f:	51                   	push   %ecx
    1d30:	ff 75 94             	pushl  -0x6c(%ebp)
    1d33:	57                   	push   %edi
    1d34:	e8 6a f4 ff ff       	call   11a3 <APDcCopy>
    1d39:	83 c4 30             	add    $0x30,%esp
                    break;
    1d3c:	eb 5c                	jmp    1d9a <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d3e:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d41:	6a 0c                	push   $0xc
    1d43:	6a 0c                	push   $0xc
    1d45:	6a 0c                	push   $0xc
    1d47:	50                   	push   %eax
    1d48:	e8 fa f5 ff ff       	call   1347 <RGB>
    1d4d:	83 c4 0c             	add    $0xc,%esp
    1d50:	8b 1d 0c 29 00 00    	mov    0x290c,%ebx
    1d56:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d59:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d5c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d5f:	6b c0 32             	imul   $0x32,%eax,%eax
    1d62:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d65:	8b 45 08             	mov    0x8(%ebp),%eax
    1d68:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d6b:	83 ec 0c             	sub    $0xc,%esp
    1d6e:	83 ec 04             	sub    $0x4,%esp
    1d71:	89 e0                	mov    %esp,%eax
    1d73:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1d77:	66 89 30             	mov    %si,(%eax)
    1d7a:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1d7e:	88 50 02             	mov    %dl,0x2(%eax)
    1d81:	6a 32                	push   $0x32
    1d83:	6a 32                	push   $0x32
    1d85:	6a 00                	push   $0x0
    1d87:	6a 00                	push   $0x0
    1d89:	53                   	push   %ebx
    1d8a:	51                   	push   %ecx
    1d8b:	ff 75 94             	pushl  -0x6c(%ebp)
    1d8e:	57                   	push   %edi
    1d8f:	e8 0f f4 ff ff       	call   11a3 <APDcCopy>
    1d94:	83 c4 30             	add    $0x30,%esp
                    break;
    1d97:	eb 01                	jmp    1d9a <APGridPaint+0x639>
                default: break;
    1d99:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d9a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1d9e:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1da2:	0f 8e 7a fc ff ff    	jle    1a22 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1da8:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1dac:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1db0:	0f 8e 60 fc ff ff    	jle    1a16 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1db6:	8d 45 98             	lea    -0x68(%ebp),%eax
    1db9:	68 cd 00 00 00       	push   $0xcd
    1dbe:	6a 74                	push   $0x74
    1dc0:	6a 18                	push   $0x18
    1dc2:	50                   	push   %eax
    1dc3:	e8 7f f5 ff ff       	call   1347 <RGB>
    1dc8:	83 c4 0c             	add    $0xc,%esp
    1dcb:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1dcf:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1dd3:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1dd7:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1dda:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1de1:	8d 45 98             	lea    -0x68(%ebp),%eax
    1de4:	68 cd 00 00 00       	push   $0xcd
    1de9:	6a 74                	push   $0x74
    1deb:	6a 18                	push   $0x18
    1ded:	50                   	push   %eax
    1dee:	e8 54 f5 ff ff       	call   1347 <RGB>
    1df3:	83 c4 0c             	add    $0xc,%esp
    1df6:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1dfa:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1dfe:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e02:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1e05:	8b 45 08             	mov    0x8(%ebp),%eax
    1e08:	8d 50 58             	lea    0x58(%eax),%edx
    1e0b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e0e:	ff 75 bc             	pushl  -0x44(%ebp)
    1e11:	ff 75 b8             	pushl  -0x48(%ebp)
    1e14:	52                   	push   %edx
    1e15:	50                   	push   %eax
    1e16:	e8 5c ed ff ff       	call   b77 <APSetPen>
    1e1b:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1e1e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e21:	8d 58 58             	lea    0x58(%eax),%ebx
    1e24:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e27:	83 ec 04             	sub    $0x4,%esp
    1e2a:	83 ec 04             	sub    $0x4,%esp
    1e2d:	89 e0                	mov    %esp,%eax
    1e2f:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1e33:	66 89 08             	mov    %cx,(%eax)
    1e36:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1e3a:	88 48 02             	mov    %cl,0x2(%eax)
    1e3d:	53                   	push   %ebx
    1e3e:	52                   	push   %edx
    1e3f:	e8 6c ed ff ff       	call   bb0 <APSetBrush>
    1e44:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1e47:	8b 45 08             	mov    0x8(%ebp),%eax
    1e4a:	83 c0 58             	add    $0x58,%eax
    1e4d:	83 ec 0c             	sub    $0xc,%esp
    1e50:	6a 32                	push   $0x32
    1e52:	68 20 03 00 00       	push   $0x320
    1e57:	6a 00                	push   $0x0
    1e59:	6a 00                	push   $0x0
    1e5b:	50                   	push   %eax
    1e5c:	e8 37 f1 ff ff       	call   f98 <APDrawRect>
    1e61:	83 c4 20             	add    $0x20,%esp
}
    1e64:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1e67:	5b                   	pop    %ebx
    1e68:	5e                   	pop    %esi
    1e69:	5f                   	pop    %edi
    1e6a:	5d                   	pop    %ebp
    1e6b:	c3                   	ret    

00001e6c <random>:
//

#include "APLib.h"

int random(int seed)
{
    1e6c:	55                   	push   %ebp
    1e6d:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1e6f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1e73:	7e 08                	jle    1e7d <random+0x11>
{
rand_num = seed;
    1e75:	8b 45 08             	mov    0x8(%ebp),%eax
    1e78:	a3 c8 28 00 00       	mov    %eax,0x28c8
}
rand_num *= 3;
    1e7d:	8b 15 c8 28 00 00    	mov    0x28c8,%edx
    1e83:	89 d0                	mov    %edx,%eax
    1e85:	01 c0                	add    %eax,%eax
    1e87:	01 d0                	add    %edx,%eax
    1e89:	a3 c8 28 00 00       	mov    %eax,0x28c8
if (rand_num < 0)
    1e8e:	a1 c8 28 00 00       	mov    0x28c8,%eax
    1e93:	85 c0                	test   %eax,%eax
    1e95:	79 0c                	jns    1ea3 <random+0x37>
{
rand_num *= (-1);
    1e97:	a1 c8 28 00 00       	mov    0x28c8,%eax
    1e9c:	f7 d8                	neg    %eax
    1e9e:	a3 c8 28 00 00       	mov    %eax,0x28c8
}
return rand_num % 997;
    1ea3:	8b 0d c8 28 00 00    	mov    0x28c8,%ecx
    1ea9:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1eae:	89 c8                	mov    %ecx,%eax
    1eb0:	f7 ea                	imul   %edx
    1eb2:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1eb5:	c1 f8 09             	sar    $0x9,%eax
    1eb8:	89 c2                	mov    %eax,%edx
    1eba:	89 c8                	mov    %ecx,%eax
    1ebc:	c1 f8 1f             	sar    $0x1f,%eax
    1ebf:	29 c2                	sub    %eax,%edx
    1ec1:	89 d0                	mov    %edx,%eax
    1ec3:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1ec9:	29 c1                	sub    %eax,%ecx
    1ecb:	89 c8                	mov    %ecx,%eax
}
    1ecd:	5d                   	pop    %ebp
    1ece:	c3                   	ret    

00001ecf <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1ecf:	55                   	push   %ebp
    1ed0:	89 e5                	mov    %esp,%ebp
    1ed2:	53                   	push   %ebx
    1ed3:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1ed6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1edd:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1ee1:	74 17                	je     1efa <sprintint+0x2b>
    1ee3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1ee7:	79 11                	jns    1efa <sprintint+0x2b>
        neg = 1;
    1ee9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1ef0:	8b 45 10             	mov    0x10(%ebp),%eax
    1ef3:	f7 d8                	neg    %eax
    1ef5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1ef8:	eb 06                	jmp    1f00 <sprintint+0x31>
    } else {
        x = xx;
    1efa:	8b 45 10             	mov    0x10(%ebp),%eax
    1efd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1f00:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1f07:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1f0a:	8d 41 01             	lea    0x1(%ecx),%eax
    1f0d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1f10:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f13:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f16:	ba 00 00 00 00       	mov    $0x0,%edx
    1f1b:	f7 f3                	div    %ebx
    1f1d:	89 d0                	mov    %edx,%eax
    1f1f:	0f b6 80 cc 28 00 00 	movzbl 0x28cc(%eax),%eax
    1f26:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1f2a:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f30:	ba 00 00 00 00       	mov    $0x0,%edx
    1f35:	f7 f3                	div    %ebx
    1f37:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f3a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f3e:	75 c7                	jne    1f07 <sprintint+0x38>
    if(neg)
    1f40:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f44:	74 0e                	je     1f54 <sprintint+0x85>
        buf[i++] = '-';
    1f46:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f49:	8d 50 01             	lea    0x1(%eax),%edx
    1f4c:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1f4f:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1f54:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f57:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1f5a:	eb 1b                	jmp    1f77 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1f5c:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f5f:	8b 00                	mov    (%eax),%eax
    1f61:	8d 48 01             	lea    0x1(%eax),%ecx
    1f64:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f67:	89 0a                	mov    %ecx,(%edx)
    1f69:	89 c2                	mov    %eax,%edx
    1f6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f6e:	01 d0                	add    %edx,%eax
    1f70:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1f73:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1f77:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1f7b:	7f df                	jg     1f5c <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1f7d:	eb 21                	jmp    1fa0 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1f7f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f82:	8b 00                	mov    (%eax),%eax
    1f84:	8d 48 01             	lea    0x1(%eax),%ecx
    1f87:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f8a:	89 0a                	mov    %ecx,(%edx)
    1f8c:	89 c2                	mov    %eax,%edx
    1f8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f91:	01 c2                	add    %eax,%edx
    1f93:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1f96:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f99:	01 c8                	add    %ecx,%eax
    1f9b:	0f b6 00             	movzbl (%eax),%eax
    1f9e:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fa0:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1fa4:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1fa8:	79 d5                	jns    1f7f <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1faa:	90                   	nop
    1fab:	83 c4 20             	add    $0x20,%esp
    1fae:	5b                   	pop    %ebx
    1faf:	5d                   	pop    %ebp
    1fb0:	c3                   	ret    

00001fb1 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1fb1:	55                   	push   %ebp
    1fb2:	89 e5                	mov    %esp,%ebp
    1fb4:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1fb7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1fbe:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1fc5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1fcc:	8d 45 0c             	lea    0xc(%ebp),%eax
    1fcf:	83 c0 04             	add    $0x4,%eax
    1fd2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1fd5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1fdc:	e9 d9 01 00 00       	jmp    21ba <sprintf+0x209>
        c = fmt[i] & 0xff;
    1fe1:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fe4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1fe7:	01 d0                	add    %edx,%eax
    1fe9:	0f b6 00             	movzbl (%eax),%eax
    1fec:	0f be c0             	movsbl %al,%eax
    1fef:	25 ff 00 00 00       	and    $0xff,%eax
    1ff4:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1ff7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1ffb:	75 2c                	jne    2029 <sprintf+0x78>
            if(c == '%'){
    1ffd:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2001:	75 0c                	jne    200f <sprintf+0x5e>
                state = '%';
    2003:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    200a:	e9 a7 01 00 00       	jmp    21b6 <sprintf+0x205>
            } else {
                dst[j++] = c;
    200f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2012:	8d 50 01             	lea    0x1(%eax),%edx
    2015:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2018:	89 c2                	mov    %eax,%edx
    201a:	8b 45 08             	mov    0x8(%ebp),%eax
    201d:	01 d0                	add    %edx,%eax
    201f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2022:	88 10                	mov    %dl,(%eax)
    2024:	e9 8d 01 00 00       	jmp    21b6 <sprintf+0x205>
            }
        } else if(state == '%'){
    2029:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    202d:	0f 85 83 01 00 00    	jne    21b6 <sprintf+0x205>
            if(c == 'd'){
    2033:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2037:	75 4c                	jne    2085 <sprintf+0xd4>
                buf[bi] = '\0';
    2039:	8d 55 ce             	lea    -0x32(%ebp),%edx
    203c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    203f:	01 d0                	add    %edx,%eax
    2041:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2044:	83 ec 0c             	sub    $0xc,%esp
    2047:	8d 45 ce             	lea    -0x32(%ebp),%eax
    204a:	50                   	push   %eax
    204b:	e8 a1 e1 ff ff       	call   1f1 <atoi>
    2050:	83 c4 10             	add    $0x10,%esp
    2053:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2056:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    205d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2060:	8b 00                	mov    (%eax),%eax
    2062:	83 ec 08             	sub    $0x8,%esp
    2065:	ff 75 d8             	pushl  -0x28(%ebp)
    2068:	6a 01                	push   $0x1
    206a:	6a 0a                	push   $0xa
    206c:	50                   	push   %eax
    206d:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2070:	50                   	push   %eax
    2071:	ff 75 08             	pushl  0x8(%ebp)
    2074:	e8 56 fe ff ff       	call   1ecf <sprintint>
    2079:	83 c4 20             	add    $0x20,%esp
                ap++;
    207c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2080:	e9 2a 01 00 00       	jmp    21af <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2085:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2089:	74 06                	je     2091 <sprintf+0xe0>
    208b:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    208f:	75 4c                	jne    20dd <sprintf+0x12c>
                buf[bi] = '\0';
    2091:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2094:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2097:	01 d0                	add    %edx,%eax
    2099:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    209c:	83 ec 0c             	sub    $0xc,%esp
    209f:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20a2:	50                   	push   %eax
    20a3:	e8 49 e1 ff ff       	call   1f1 <atoi>
    20a8:	83 c4 10             	add    $0x10,%esp
    20ab:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    20ae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    20b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20b8:	8b 00                	mov    (%eax),%eax
    20ba:	83 ec 08             	sub    $0x8,%esp
    20bd:	ff 75 dc             	pushl  -0x24(%ebp)
    20c0:	6a 00                	push   $0x0
    20c2:	6a 10                	push   $0x10
    20c4:	50                   	push   %eax
    20c5:	8d 45 c8             	lea    -0x38(%ebp),%eax
    20c8:	50                   	push   %eax
    20c9:	ff 75 08             	pushl  0x8(%ebp)
    20cc:	e8 fe fd ff ff       	call   1ecf <sprintint>
    20d1:	83 c4 20             	add    $0x20,%esp
                ap++;
    20d4:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    20d8:	e9 d2 00 00 00       	jmp    21af <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    20dd:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    20e1:	75 46                	jne    2129 <sprintf+0x178>
                s = (char*)*ap;
    20e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20e6:	8b 00                	mov    (%eax),%eax
    20e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    20eb:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    20ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    20f3:	75 25                	jne    211a <sprintf+0x169>
                    s = "(null)";
    20f5:	c7 45 f4 58 23 00 00 	movl   $0x2358,-0xc(%ebp)
                while(*s != 0){
    20fc:	eb 1c                	jmp    211a <sprintf+0x169>
                    dst[j++] = *s;
    20fe:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2101:	8d 50 01             	lea    0x1(%eax),%edx
    2104:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2107:	89 c2                	mov    %eax,%edx
    2109:	8b 45 08             	mov    0x8(%ebp),%eax
    210c:	01 c2                	add    %eax,%edx
    210e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2111:	0f b6 00             	movzbl (%eax),%eax
    2114:	88 02                	mov    %al,(%edx)
                    s++;
    2116:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    211a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    211d:	0f b6 00             	movzbl (%eax),%eax
    2120:	84 c0                	test   %al,%al
    2122:	75 da                	jne    20fe <sprintf+0x14d>
    2124:	e9 86 00 00 00       	jmp    21af <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2129:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    212d:	75 1d                	jne    214c <sprintf+0x19b>
                dst[j++] = *ap;
    212f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2132:	8d 50 01             	lea    0x1(%eax),%edx
    2135:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2138:	89 c2                	mov    %eax,%edx
    213a:	8b 45 08             	mov    0x8(%ebp),%eax
    213d:	01 c2                	add    %eax,%edx
    213f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2142:	8b 00                	mov    (%eax),%eax
    2144:	88 02                	mov    %al,(%edx)
                ap++;
    2146:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    214a:	eb 63                	jmp    21af <sprintf+0x1fe>
            } else if(c == '%'){
    214c:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2150:	75 17                	jne    2169 <sprintf+0x1b8>
                dst[j++] = c;
    2152:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2155:	8d 50 01             	lea    0x1(%eax),%edx
    2158:	89 55 c8             	mov    %edx,-0x38(%ebp)
    215b:	89 c2                	mov    %eax,%edx
    215d:	8b 45 08             	mov    0x8(%ebp),%eax
    2160:	01 d0                	add    %edx,%eax
    2162:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2165:	88 10                	mov    %dl,(%eax)
    2167:	eb 46                	jmp    21af <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2169:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    216d:	7e 18                	jle    2187 <sprintf+0x1d6>
    216f:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2173:	7f 12                	jg     2187 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2175:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2178:	8d 50 01             	lea    0x1(%eax),%edx
    217b:	89 55 f0             	mov    %edx,-0x10(%ebp)
    217e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2181:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2185:	eb 2f                	jmp    21b6 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2187:	8b 45 c8             	mov    -0x38(%ebp),%eax
    218a:	8d 50 01             	lea    0x1(%eax),%edx
    218d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2190:	89 c2                	mov    %eax,%edx
    2192:	8b 45 08             	mov    0x8(%ebp),%eax
    2195:	01 d0                	add    %edx,%eax
    2197:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    219a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    219d:	8d 50 01             	lea    0x1(%eax),%edx
    21a0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21a3:	89 c2                	mov    %eax,%edx
    21a5:	8b 45 08             	mov    0x8(%ebp),%eax
    21a8:	01 d0                	add    %edx,%eax
    21aa:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21ad:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    21af:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    21b6:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    21ba:	8b 55 0c             	mov    0xc(%ebp),%edx
    21bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    21c0:	01 d0                	add    %edx,%eax
    21c2:	0f b6 00             	movzbl (%eax),%eax
    21c5:	84 c0                	test   %al,%al
    21c7:	0f 85 14 fe ff ff    	jne    1fe1 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    21cd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21d0:	8d 50 01             	lea    0x1(%eax),%edx
    21d3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21d6:	89 c2                	mov    %eax,%edx
    21d8:	8b 45 08             	mov    0x8(%ebp),%eax
    21db:	01 d0                	add    %edx,%eax
    21dd:	c6 00 00             	movb   $0x0,(%eax)
}
    21e0:	90                   	nop
    21e1:	c9                   	leave  
    21e2:	c3                   	ret    
