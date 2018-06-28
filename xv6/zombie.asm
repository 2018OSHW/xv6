
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
     3be:	0f b6 80 d0 24 00 00 	movzbl 0x24d0(%eax),%eax
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
     4fc:	c7 45 f4 64 1e 00 00 	movl   $0x1e64,-0xc(%ebp)
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
     5c2:	a1 00 25 00 00       	mov    0x2500,%eax
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
     68d:	a3 00 25 00 00       	mov    %eax,0x2500
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
     6ee:	a1 00 25 00 00       	mov    0x2500,%eax
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
     70a:	a1 00 25 00 00       	mov    0x2500,%eax
     70f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     712:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     716:	75 23                	jne    73b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     718:	c7 45 f0 f8 24 00 00 	movl   $0x24f8,-0x10(%ebp)
     71f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     722:	a3 00 25 00 00       	mov    %eax,0x2500
     727:	a1 00 25 00 00       	mov    0x2500,%eax
     72c:	a3 f8 24 00 00       	mov    %eax,0x24f8
    base.s.size = 0;
     731:	c7 05 fc 24 00 00 00 	movl   $0x0,0x24fc
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
     78e:	a3 00 25 00 00       	mov    %eax,0x2500
      return (void*)(p + 1);
     793:	8b 45 f4             	mov    -0xc(%ebp),%eax
     796:	83 c0 08             	add    $0x8,%eax
     799:	eb 3b                	jmp    7d6 <malloc+0xe1>
    }
    if(p == freep)
     79b:	a1 00 25 00 00       	mov    0x2500,%eax
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
     8ab:	56                   	push   %esi
     8ac:	53                   	push   %ebx
     8ad:	83 ec 70             	sub    $0x70,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     8b0:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     8b7:	8b 45 cc             	mov    -0x34(%ebp),%eax
     8ba:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     8bd:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     8c4:	83 ec 08             	sub    $0x8,%esp
     8c7:	6a 00                	push   $0x0
     8c9:	ff 75 0c             	pushl  0xc(%ebp)
     8cc:	e8 f2 f9 ff ff       	call   2c3 <open>
     8d1:	83 c4 10             	add    $0x10,%esp
     8d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     8d7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     8db:	79 2e                	jns    90b <APLoadBitmap+0x63>
    {
        printf(1, "Cannot open %s\n", filename);
     8dd:	83 ec 04             	sub    $0x4,%esp
     8e0:	ff 75 0c             	pushl  0xc(%ebp)
     8e3:	68 6c 1e 00 00       	push   $0x1e6c
     8e8:	6a 01                	push   $0x1
     8ea:	e8 33 fb ff ff       	call   422 <printf>
     8ef:	83 c4 10             	add    $0x10,%esp
        return bmp;
     8f2:	8b 45 08             	mov    0x8(%ebp),%eax
     8f5:	8b 55 c8             	mov    -0x38(%ebp),%edx
     8f8:	89 10                	mov    %edx,(%eax)
     8fa:	8b 55 cc             	mov    -0x34(%ebp),%edx
     8fd:	89 50 04             	mov    %edx,0x4(%eax)
     900:	8b 55 d0             	mov    -0x30(%ebp),%edx
     903:	89 50 08             	mov    %edx,0x8(%eax)
     906:	e9 1b 02 00 00       	jmp    b26 <APLoadBitmap+0x27e>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     90b:	83 ec 04             	sub    $0x4,%esp
     90e:	6a 10                	push   $0x10
     910:	8d 45 b8             	lea    -0x48(%ebp),%eax
     913:	50                   	push   %eax
     914:	ff 75 ec             	pushl  -0x14(%ebp)
     917:	e8 7f f9 ff ff       	call   29b <read>
     91c:	83 c4 10             	add    $0x10,%esp
    printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
     91f:	0f b7 45 c2          	movzwl -0x3e(%ebp),%eax
     923:	0f b7 f0             	movzwl %ax,%esi
     926:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
     92a:	0f b7 d8             	movzwl %ax,%ebx
     92d:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
     930:	8b 55 bc             	mov    -0x44(%ebp),%edx
     933:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
     937:	0f b7 c0             	movzwl %ax,%eax
     93a:	83 ec 04             	sub    $0x4,%esp
     93d:	56                   	push   %esi
     93e:	53                   	push   %ebx
     93f:	51                   	push   %ecx
     940:	52                   	push   %edx
     941:	50                   	push   %eax
     942:	68 7c 1e 00 00       	push   $0x1e7c
     947:	6a 01                	push   $0x1
     949:	e8 d4 fa ff ff       	call   422 <printf>
     94e:	83 c4 20             	add    $0x20,%esp
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     951:	83 ec 04             	sub    $0x4,%esp
     954:	6a 28                	push   $0x28
     956:	8d 45 90             	lea    -0x70(%ebp),%eax
     959:	50                   	push   %eax
     95a:	ff 75 ec             	pushl  -0x14(%ebp)
     95d:	e8 39 f9 ff ff       	call   29b <read>
     962:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     965:	8b 45 94             	mov    -0x6c(%ebp),%eax
     968:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     96b:	8b 45 98             	mov    -0x68(%ebp),%eax
     96e:	89 45 cc             	mov    %eax,-0x34(%ebp)
    printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
     971:	8b 55 c8             	mov    -0x38(%ebp),%edx
     974:	8b 45 cc             	mov    -0x34(%ebp),%eax
     977:	52                   	push   %edx
     978:	50                   	push   %eax
     979:	68 8c 1e 00 00       	push   $0x1e8c
     97e:	6a 01                	push   $0x1
     980:	e8 9d fa ff ff       	call   422 <printf>
     985:	83 c4 10             	add    $0x10,%esp
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     988:	8b 55 c8             	mov    -0x38(%ebp),%edx
     98b:	8b 45 cc             	mov    -0x34(%ebp),%eax
     98e:	0f af d0             	imul   %eax,%edx
     991:	89 d0                	mov    %edx,%eax
     993:	01 c0                	add    %eax,%eax
     995:	01 d0                	add    %edx,%eax
     997:	83 ec 0c             	sub    $0xc,%esp
     99a:	50                   	push   %eax
     99b:	e8 55 fd ff ff       	call   6f5 <malloc>
     9a0:	83 c4 10             	add    $0x10,%esp
     9a3:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9a6:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     9aa:	0f b7 c0             	movzwl %ax,%eax
     9ad:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9b0:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9b6:	0f af c2             	imul   %edx,%eax
     9b9:	83 c0 1f             	add    $0x1f,%eax
     9bc:	c1 e8 05             	shr    $0x5,%eax
     9bf:	c1 e0 02             	shl    $0x2,%eax
     9c2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9c5:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9cb:	0f af c2             	imul   %edx,%eax
     9ce:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9d1:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9d4:	83 ec 0c             	sub    $0xc,%esp
     9d7:	50                   	push   %eax
     9d8:	e8 18 fd ff ff       	call   6f5 <malloc>
     9dd:	83 c4 10             	add    $0x10,%esp
     9e0:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9e3:	83 ec 04             	sub    $0x4,%esp
     9e6:	ff 75 e0             	pushl  -0x20(%ebp)
     9e9:	ff 75 dc             	pushl  -0x24(%ebp)
     9ec:	ff 75 ec             	pushl  -0x14(%ebp)
     9ef:	e8 a7 f8 ff ff       	call   29b <read>
     9f4:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     9f7:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     9fb:	66 c1 e8 03          	shr    $0x3,%ax
     9ff:	0f b7 c0             	movzwl %ax,%eax
     a02:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a05:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a0c:	e9 e5 00 00 00       	jmp    af6 <APLoadBitmap+0x24e>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a11:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a14:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a17:	29 c2                	sub    %eax,%edx
     a19:	89 d0                	mov    %edx,%eax
     a1b:	8d 50 ff             	lea    -0x1(%eax),%edx
     a1e:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a21:	0f af c2             	imul   %edx,%eax
     a24:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a27:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a2e:	e9 b1 00 00 00       	jmp    ae4 <APLoadBitmap+0x23c>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a33:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a36:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a39:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a3c:	01 c8                	add    %ecx,%eax
     a3e:	89 c1                	mov    %eax,%ecx
     a40:	89 c8                	mov    %ecx,%eax
     a42:	01 c0                	add    %eax,%eax
     a44:	01 c8                	add    %ecx,%eax
     a46:	01 c2                	add    %eax,%edx
     a48:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a4b:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a4f:	89 c1                	mov    %eax,%ecx
     a51:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a54:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a58:	01 c1                	add    %eax,%ecx
     a5a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a5d:	01 c8                	add    %ecx,%eax
     a5f:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a62:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a65:	01 c8                	add    %ecx,%eax
     a67:	0f b6 00             	movzbl (%eax),%eax
     a6a:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a6d:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a70:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a73:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a76:	01 c8                	add    %ecx,%eax
     a78:	89 c1                	mov    %eax,%ecx
     a7a:	89 c8                	mov    %ecx,%eax
     a7c:	01 c0                	add    %eax,%eax
     a7e:	01 c8                	add    %ecx,%eax
     a80:	01 c2                	add    %eax,%edx
     a82:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a85:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a89:	89 c1                	mov    %eax,%ecx
     a8b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a8e:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a92:	01 c1                	add    %eax,%ecx
     a94:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a97:	01 c8                	add    %ecx,%eax
     a99:	8d 48 fe             	lea    -0x2(%eax),%ecx
     a9c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a9f:	01 c8                	add    %ecx,%eax
     aa1:	0f b6 00             	movzbl (%eax),%eax
     aa4:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     aa7:	8b 55 d0             	mov    -0x30(%ebp),%edx
     aaa:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     aad:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ab0:	01 c8                	add    %ecx,%eax
     ab2:	89 c1                	mov    %eax,%ecx
     ab4:	89 c8                	mov    %ecx,%eax
     ab6:	01 c0                	add    %eax,%eax
     ab8:	01 c8                	add    %ecx,%eax
     aba:	01 c2                	add    %eax,%edx
     abc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     abf:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ac3:	89 c1                	mov    %eax,%ecx
     ac5:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ac8:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     acc:	01 c1                	add    %eax,%ecx
     ace:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ad1:	01 c8                	add    %ecx,%eax
     ad3:	8d 48 fd             	lea    -0x3(%eax),%ecx
     ad6:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ad9:	01 c8                	add    %ecx,%eax
     adb:	0f b6 00             	movzbl (%eax),%eax
     ade:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     ae0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ae4:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ae7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aea:	39 c2                	cmp    %eax,%edx
     aec:	0f 87 41 ff ff ff    	ja     a33 <APLoadBitmap+0x18b>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     af2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     af6:	8b 55 cc             	mov    -0x34(%ebp),%edx
     af9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     afc:	39 c2                	cmp    %eax,%edx
     afe:	0f 87 0d ff ff ff    	ja     a11 <APLoadBitmap+0x169>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b04:	83 ec 0c             	sub    $0xc,%esp
     b07:	ff 75 ec             	pushl  -0x14(%ebp)
     b0a:	e8 9c f7 ff ff       	call   2ab <close>
     b0f:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b12:	8b 45 08             	mov    0x8(%ebp),%eax
     b15:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b18:	89 10                	mov    %edx,(%eax)
     b1a:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b1d:	89 50 04             	mov    %edx,0x4(%eax)
     b20:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b23:	89 50 08             	mov    %edx,0x8(%eax)
}
     b26:	8b 45 08             	mov    0x8(%ebp),%eax
     b29:	8d 65 f8             	lea    -0x8(%ebp),%esp
     b2c:	5b                   	pop    %ebx
     b2d:	5e                   	pop    %esi
     b2e:	5d                   	pop    %ebp
     b2f:	c2 04 00             	ret    $0x4

00000b32 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b32:	55                   	push   %ebp
     b33:	89 e5                	mov    %esp,%ebp
     b35:	53                   	push   %ebx
     b36:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b39:	83 ec 0c             	sub    $0xc,%esp
     b3c:	6a 1c                	push   $0x1c
     b3e:	e8 b2 fb ff ff       	call   6f5 <malloc>
     b43:	83 c4 10             	add    $0x10,%esp
     b46:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b49:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b4c:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b53:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b56:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b59:	6a 0c                	push   $0xc
     b5b:	6a 0c                	push   $0xc
     b5d:	6a 0c                	push   $0xc
     b5f:	50                   	push   %eax
     b60:	e8 73 fc ff ff       	call   7d8 <RGB>
     b65:	83 c4 0c             	add    $0xc,%esp
     b68:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b6c:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b70:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b74:	88 43 15             	mov    %al,0x15(%ebx)
     b77:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b7a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b7d:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b81:	66 89 48 10          	mov    %cx,0x10(%eax)
     b85:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b89:	88 50 12             	mov    %dl,0x12(%eax)
     b8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b8f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b92:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     b96:	66 89 48 08          	mov    %cx,0x8(%eax)
     b9a:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     b9e:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     ba1:	8b 45 08             	mov    0x8(%ebp),%eax
     ba4:	89 c2                	mov    %eax,%edx
     ba6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba9:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     bab:	8b 45 0c             	mov    0xc(%ebp),%eax
     bae:	89 c2                	mov    %eax,%edx
     bb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb3:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bb6:	8b 55 10             	mov    0x10(%ebp),%edx
     bb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bbc:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "%d %d\n", hdc->size.cx, hdc->size.cy);
    return hdc;
     bbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bc2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bc5:	c9                   	leave  
     bc6:	c3                   	ret    

00000bc7 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     bc7:	55                   	push   %ebp
     bc8:	89 e5                	mov    %esp,%ebp
     bca:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     bcd:	8b 45 0c             	mov    0xc(%ebp),%eax
     bd0:	8b 50 08             	mov    0x8(%eax),%edx
     bd3:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bd6:	8b 40 0c             	mov    0xc(%eax),%eax
     bd9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     bdc:	8b 45 0c             	mov    0xc(%ebp),%eax
     bdf:	8b 55 10             	mov    0x10(%ebp),%edx
     be2:	89 50 08             	mov    %edx,0x8(%eax)
     be5:	8b 55 14             	mov    0x14(%ebp),%edx
     be8:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     beb:	8b 45 08             	mov    0x8(%ebp),%eax
     bee:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bf1:	89 10                	mov    %edx,(%eax)
     bf3:	8b 55 fc             	mov    -0x4(%ebp),%edx
     bf6:	89 50 04             	mov    %edx,0x4(%eax)
}
     bf9:	8b 45 08             	mov    0x8(%ebp),%eax
     bfc:	c9                   	leave  
     bfd:	c2 04 00             	ret    $0x4

00000c00 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c06:	8b 45 0c             	mov    0xc(%ebp),%eax
     c09:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c0d:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c11:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c15:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c18:	8b 45 0c             	mov    0xc(%ebp),%eax
     c1b:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c1f:	66 89 50 10          	mov    %dx,0x10(%eax)
     c23:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c27:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c2a:	8b 45 08             	mov    0x8(%ebp),%eax
     c2d:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c31:	66 89 10             	mov    %dx,(%eax)
     c34:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c38:	88 50 02             	mov    %dl,0x2(%eax)
}
     c3b:	8b 45 08             	mov    0x8(%ebp),%eax
     c3e:	c9                   	leave  
     c3f:	c2 04 00             	ret    $0x4

00000c42 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c42:	55                   	push   %ebp
     c43:	89 e5                	mov    %esp,%ebp
     c45:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c48:	8b 45 08             	mov    0x8(%ebp),%eax
     c4b:	8b 40 0c             	mov    0xc(%eax),%eax
     c4e:	89 c2                	mov    %eax,%edx
     c50:	c1 ea 1f             	shr    $0x1f,%edx
     c53:	01 d0                	add    %edx,%eax
     c55:	d1 f8                	sar    %eax
     c57:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5d:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c61:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c64:	8b 45 10             	mov    0x10(%ebp),%eax
     c67:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c6d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c71:	0f 89 98 00 00 00    	jns    d0f <APDrawPoint+0xcd>
        i = 0;
     c77:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c7e:	e9 8c 00 00 00       	jmp    d0f <APDrawPoint+0xcd>
    {
        j = x - off;
     c83:	8b 45 0c             	mov    0xc(%ebp),%eax
     c86:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c89:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     c8c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     c90:	79 69                	jns    cfb <APDrawPoint+0xb9>
            j = 0;
     c92:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     c99:	eb 60                	jmp    cfb <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     c9b:	ff 75 fc             	pushl  -0x4(%ebp)
     c9e:	ff 75 f8             	pushl  -0x8(%ebp)
     ca1:	ff 75 08             	pushl  0x8(%ebp)
     ca4:	e8 ad fb ff ff       	call   856 <APGetIndex>
     ca9:	83 c4 0c             	add    $0xc,%esp
     cac:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     caf:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cb3:	74 55                	je     d0a <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cb5:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     cb9:	74 67                	je     d22 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     cbb:	ff 75 10             	pushl  0x10(%ebp)
     cbe:	ff 75 0c             	pushl  0xc(%ebp)
     cc1:	ff 75 fc             	pushl  -0x4(%ebp)
     cc4:	ff 75 f8             	pushl  -0x8(%ebp)
     cc7:	e8 51 fb ff ff       	call   81d <distance_2>
     ccc:	83 c4 10             	add    $0x10,%esp
     ccf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     cd2:	7f 23                	jg     cf7 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     cd4:	8b 45 08             	mov    0x8(%ebp),%eax
     cd7:	8b 48 18             	mov    0x18(%eax),%ecx
     cda:	8b 55 ec             	mov    -0x14(%ebp),%edx
     cdd:	89 d0                	mov    %edx,%eax
     cdf:	01 c0                	add    %eax,%eax
     ce1:	01 d0                	add    %edx,%eax
     ce3:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     ce6:	8b 45 08             	mov    0x8(%ebp),%eax
     ce9:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     ced:	66 89 0a             	mov    %cx,(%edx)
     cf0:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     cf4:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     cf7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     cfb:	8b 55 0c             	mov    0xc(%ebp),%edx
     cfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d01:	01 d0                	add    %edx,%eax
     d03:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d06:	7d 93                	jge    c9b <APDrawPoint+0x59>
     d08:	eb 01                	jmp    d0b <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d0a:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d0b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d0f:	8b 55 10             	mov    0x10(%ebp),%edx
     d12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d15:	01 d0                	add    %edx,%eax
     d17:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d1a:	0f 8d 63 ff ff ff    	jge    c83 <APDrawPoint+0x41>
     d20:	eb 01                	jmp    d23 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d22:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d23:	c9                   	leave  
     d24:	c3                   	ret    

00000d25 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d25:	55                   	push   %ebp
     d26:	89 e5                	mov    %esp,%ebp
     d28:	53                   	push   %ebx
     d29:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d2c:	8b 45 0c             	mov    0xc(%ebp),%eax
     d2f:	3b 45 14             	cmp    0x14(%ebp),%eax
     d32:	0f 85 80 00 00 00    	jne    db8 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d38:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d3c:	0f 88 9d 02 00 00    	js     fdf <APDrawLine+0x2ba>
     d42:	8b 45 08             	mov    0x8(%ebp),%eax
     d45:	8b 00                	mov    (%eax),%eax
     d47:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d4a:	0f 8e 8f 02 00 00    	jle    fdf <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d50:	8b 45 10             	mov    0x10(%ebp),%eax
     d53:	3b 45 18             	cmp    0x18(%ebp),%eax
     d56:	7e 12                	jle    d6a <APDrawLine+0x45>
        {
            int tmp = y2;
     d58:	8b 45 18             	mov    0x18(%ebp),%eax
     d5b:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d5e:	8b 45 10             	mov    0x10(%ebp),%eax
     d61:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d64:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d67:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d6a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d6e:	79 07                	jns    d77 <APDrawLine+0x52>
     d70:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d77:	8b 45 08             	mov    0x8(%ebp),%eax
     d7a:	8b 40 04             	mov    0x4(%eax),%eax
     d7d:	3b 45 18             	cmp    0x18(%ebp),%eax
     d80:	7d 0c                	jge    d8e <APDrawLine+0x69>
     d82:	8b 45 08             	mov    0x8(%ebp),%eax
     d85:	8b 40 04             	mov    0x4(%eax),%eax
     d88:	83 e8 01             	sub    $0x1,%eax
     d8b:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     d8e:	8b 45 10             	mov    0x10(%ebp),%eax
     d91:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d94:	eb 15                	jmp    dab <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     d96:	ff 75 f4             	pushl  -0xc(%ebp)
     d99:	ff 75 0c             	pushl  0xc(%ebp)
     d9c:	ff 75 08             	pushl  0x8(%ebp)
     d9f:	e8 9e fe ff ff       	call   c42 <APDrawPoint>
     da4:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     da7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     dab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dae:	3b 45 18             	cmp    0x18(%ebp),%eax
     db1:	7e e3                	jle    d96 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     db3:	e9 2b 02 00 00       	jmp    fe3 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     db8:	8b 45 10             	mov    0x10(%ebp),%eax
     dbb:	3b 45 18             	cmp    0x18(%ebp),%eax
     dbe:	75 7f                	jne    e3f <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     dc0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dc4:	0f 88 18 02 00 00    	js     fe2 <APDrawLine+0x2bd>
     dca:	8b 45 08             	mov    0x8(%ebp),%eax
     dcd:	8b 40 04             	mov    0x4(%eax),%eax
     dd0:	3b 45 10             	cmp    0x10(%ebp),%eax
     dd3:	0f 8e 09 02 00 00    	jle    fe2 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     dd9:	8b 45 0c             	mov    0xc(%ebp),%eax
     ddc:	3b 45 14             	cmp    0x14(%ebp),%eax
     ddf:	7e 12                	jle    df3 <APDrawLine+0xce>
        {
            int tmp = x2;
     de1:	8b 45 14             	mov    0x14(%ebp),%eax
     de4:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     de7:	8b 45 0c             	mov    0xc(%ebp),%eax
     dea:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     ded:	8b 45 d8             	mov    -0x28(%ebp),%eax
     df0:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     df3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     df7:	79 07                	jns    e00 <APDrawLine+0xdb>
     df9:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e00:	8b 45 08             	mov    0x8(%ebp),%eax
     e03:	8b 00                	mov    (%eax),%eax
     e05:	3b 45 14             	cmp    0x14(%ebp),%eax
     e08:	7d 0b                	jge    e15 <APDrawLine+0xf0>
     e0a:	8b 45 08             	mov    0x8(%ebp),%eax
     e0d:	8b 00                	mov    (%eax),%eax
     e0f:	83 e8 01             	sub    $0x1,%eax
     e12:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e15:	8b 45 0c             	mov    0xc(%ebp),%eax
     e18:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e1b:	eb 15                	jmp    e32 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e1d:	ff 75 10             	pushl  0x10(%ebp)
     e20:	ff 75 f0             	pushl  -0x10(%ebp)
     e23:	ff 75 08             	pushl  0x8(%ebp)
     e26:	e8 17 fe ff ff       	call   c42 <APDrawPoint>
     e2b:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e2e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e32:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e35:	3b 45 14             	cmp    0x14(%ebp),%eax
     e38:	7e e3                	jle    e1d <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e3a:	e9 a4 01 00 00       	jmp    fe3 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e3f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e46:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e4d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e50:	2b 45 14             	sub    0x14(%ebp),%eax
     e53:	50                   	push   %eax
     e54:	e8 ed f9 ff ff       	call   846 <abs_int>
     e59:	83 c4 04             	add    $0x4,%esp
     e5c:	89 c3                	mov    %eax,%ebx
     e5e:	8b 45 10             	mov    0x10(%ebp),%eax
     e61:	2b 45 18             	sub    0x18(%ebp),%eax
     e64:	50                   	push   %eax
     e65:	e8 dc f9 ff ff       	call   846 <abs_int>
     e6a:	83 c4 04             	add    $0x4,%esp
     e6d:	39 c3                	cmp    %eax,%ebx
     e6f:	0f 8e b5 00 00 00    	jle    f2a <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e75:	8b 45 10             	mov    0x10(%ebp),%eax
     e78:	2b 45 18             	sub    0x18(%ebp),%eax
     e7b:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e7e:	db 45 b0             	fildl  -0x50(%ebp)
     e81:	8b 45 0c             	mov    0xc(%ebp),%eax
     e84:	2b 45 14             	sub    0x14(%ebp),%eax
     e87:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e8a:	db 45 b0             	fildl  -0x50(%ebp)
     e8d:	de f9                	fdivrp %st,%st(1)
     e8f:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     e92:	8b 45 14             	mov    0x14(%ebp),%eax
     e95:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e98:	7e 0e                	jle    ea8 <APDrawLine+0x183>
        {
            s = x1;
     e9a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9d:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     ea0:	8b 45 14             	mov    0x14(%ebp),%eax
     ea3:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ea6:	eb 0c                	jmp    eb4 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ea8:	8b 45 14             	mov    0x14(%ebp),%eax
     eab:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     eae:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb1:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     eb4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     eb8:	79 07                	jns    ec1 <APDrawLine+0x19c>
     eba:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     ec1:	8b 45 08             	mov    0x8(%ebp),%eax
     ec4:	8b 00                	mov    (%eax),%eax
     ec6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ec9:	7f 0b                	jg     ed6 <APDrawLine+0x1b1>
     ecb:	8b 45 08             	mov    0x8(%ebp),%eax
     ece:	8b 00                	mov    (%eax),%eax
     ed0:	83 e8 01             	sub    $0x1,%eax
     ed3:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     ed6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ed9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     edc:	eb 3f                	jmp    f1d <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     ede:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ee1:	2b 45 0c             	sub    0xc(%ebp),%eax
     ee4:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ee7:	db 45 b0             	fildl  -0x50(%ebp)
     eea:	dc 4d d0             	fmull  -0x30(%ebp)
     eed:	db 45 10             	fildl  0x10(%ebp)
     ef0:	de c1                	faddp  %st,%st(1)
     ef2:	d9 7d b6             	fnstcw -0x4a(%ebp)
     ef5:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     ef9:	b4 0c                	mov    $0xc,%ah
     efb:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     eff:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f02:	db 5d cc             	fistpl -0x34(%ebp)
     f05:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f08:	ff 75 cc             	pushl  -0x34(%ebp)
     f0b:	ff 75 e4             	pushl  -0x1c(%ebp)
     f0e:	ff 75 08             	pushl  0x8(%ebp)
     f11:	e8 2c fd ff ff       	call   c42 <APDrawPoint>
     f16:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f19:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f1d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f20:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f23:	7e b9                	jle    ede <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f25:	e9 b9 00 00 00       	jmp    fe3 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f2a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f2d:	2b 45 14             	sub    0x14(%ebp),%eax
     f30:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f33:	db 45 b0             	fildl  -0x50(%ebp)
     f36:	8b 45 10             	mov    0x10(%ebp),%eax
     f39:	2b 45 18             	sub    0x18(%ebp),%eax
     f3c:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f3f:	db 45 b0             	fildl  -0x50(%ebp)
     f42:	de f9                	fdivrp %st,%st(1)
     f44:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f47:	8b 45 10             	mov    0x10(%ebp),%eax
     f4a:	3b 45 18             	cmp    0x18(%ebp),%eax
     f4d:	7e 0e                	jle    f5d <APDrawLine+0x238>
    {
        s = y2;
     f4f:	8b 45 18             	mov    0x18(%ebp),%eax
     f52:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f55:	8b 45 10             	mov    0x10(%ebp),%eax
     f58:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f5b:	eb 0c                	jmp    f69 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f5d:	8b 45 10             	mov    0x10(%ebp),%eax
     f60:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f63:	8b 45 18             	mov    0x18(%ebp),%eax
     f66:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f69:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f6d:	79 07                	jns    f76 <APDrawLine+0x251>
     f6f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f76:	8b 45 08             	mov    0x8(%ebp),%eax
     f79:	8b 40 04             	mov    0x4(%eax),%eax
     f7c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f7f:	7f 0c                	jg     f8d <APDrawLine+0x268>
     f81:	8b 45 08             	mov    0x8(%ebp),%eax
     f84:	8b 40 04             	mov    0x4(%eax),%eax
     f87:	83 e8 01             	sub    $0x1,%eax
     f8a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     f8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f90:	89 45 e0             	mov    %eax,-0x20(%ebp)
     f93:	eb 3f                	jmp    fd4 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     f95:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f98:	2b 45 10             	sub    0x10(%ebp),%eax
     f9b:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f9e:	db 45 b0             	fildl  -0x50(%ebp)
     fa1:	dc 4d c0             	fmull  -0x40(%ebp)
     fa4:	db 45 0c             	fildl  0xc(%ebp)
     fa7:	de c1                	faddp  %st,%st(1)
     fa9:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fac:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fb0:	b4 0c                	mov    $0xc,%ah
     fb2:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fb6:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fb9:	db 5d bc             	fistpl -0x44(%ebp)
     fbc:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     fbf:	ff 75 e0             	pushl  -0x20(%ebp)
     fc2:	ff 75 bc             	pushl  -0x44(%ebp)
     fc5:	ff 75 08             	pushl  0x8(%ebp)
     fc8:	e8 75 fc ff ff       	call   c42 <APDrawPoint>
     fcd:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     fd0:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     fd4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fd7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fda:	7e b9                	jle    f95 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     fdc:	90                   	nop
     fdd:	eb 04                	jmp    fe3 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     fdf:	90                   	nop
     fe0:	eb 01                	jmp    fe3 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     fe2:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     fe3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fe6:	c9                   	leave  
     fe7:	c3                   	ret    

00000fe8 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     fe8:	55                   	push   %ebp
     fe9:	89 e5                	mov    %esp,%ebp
     feb:	53                   	push   %ebx
     fec:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
     fef:	8b 55 10             	mov    0x10(%ebp),%edx
     ff2:	8b 45 18             	mov    0x18(%ebp),%eax
     ff5:	01 d0                	add    %edx,%eax
     ff7:	83 e8 01             	sub    $0x1,%eax
     ffa:	83 ec 04             	sub    $0x4,%esp
     ffd:	50                   	push   %eax
     ffe:	ff 75 0c             	pushl  0xc(%ebp)
    1001:	ff 75 10             	pushl  0x10(%ebp)
    1004:	ff 75 0c             	pushl  0xc(%ebp)
    1007:	ff 75 08             	pushl  0x8(%ebp)
    100a:	e8 16 fd ff ff       	call   d25 <APDrawLine>
    100f:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1012:	8b 55 0c             	mov    0xc(%ebp),%edx
    1015:	8b 45 14             	mov    0x14(%ebp),%eax
    1018:	01 d0                	add    %edx,%eax
    101a:	83 e8 01             	sub    $0x1,%eax
    101d:	83 ec 04             	sub    $0x4,%esp
    1020:	ff 75 10             	pushl  0x10(%ebp)
    1023:	50                   	push   %eax
    1024:	ff 75 10             	pushl  0x10(%ebp)
    1027:	ff 75 0c             	pushl  0xc(%ebp)
    102a:	ff 75 08             	pushl  0x8(%ebp)
    102d:	e8 f3 fc ff ff       	call   d25 <APDrawLine>
    1032:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1035:	8b 55 10             	mov    0x10(%ebp),%edx
    1038:	8b 45 18             	mov    0x18(%ebp),%eax
    103b:	01 d0                	add    %edx,%eax
    103d:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1040:	8b 55 0c             	mov    0xc(%ebp),%edx
    1043:	8b 45 14             	mov    0x14(%ebp),%eax
    1046:	01 d0                	add    %edx,%eax
    1048:	8d 50 ff             	lea    -0x1(%eax),%edx
    104b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    104e:	8b 45 14             	mov    0x14(%ebp),%eax
    1051:	01 d8                	add    %ebx,%eax
    1053:	83 e8 01             	sub    $0x1,%eax
    1056:	83 ec 04             	sub    $0x4,%esp
    1059:	51                   	push   %ecx
    105a:	52                   	push   %edx
    105b:	ff 75 10             	pushl  0x10(%ebp)
    105e:	50                   	push   %eax
    105f:	ff 75 08             	pushl  0x8(%ebp)
    1062:	e8 be fc ff ff       	call   d25 <APDrawLine>
    1067:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    106a:	8b 55 10             	mov    0x10(%ebp),%edx
    106d:	8b 45 18             	mov    0x18(%ebp),%eax
    1070:	01 d0                	add    %edx,%eax
    1072:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1075:	8b 55 0c             	mov    0xc(%ebp),%edx
    1078:	8b 45 14             	mov    0x14(%ebp),%eax
    107b:	01 d0                	add    %edx,%eax
    107d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1080:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1083:	8b 45 18             	mov    0x18(%ebp),%eax
    1086:	01 d8                	add    %ebx,%eax
    1088:	83 e8 01             	sub    $0x1,%eax
    108b:	83 ec 04             	sub    $0x4,%esp
    108e:	51                   	push   %ecx
    108f:	52                   	push   %edx
    1090:	50                   	push   %eax
    1091:	ff 75 0c             	pushl  0xc(%ebp)
    1094:	ff 75 08             	pushl  0x8(%ebp)
    1097:	e8 89 fc ff ff       	call   d25 <APDrawLine>
    109c:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    109f:	8b 55 0c             	mov    0xc(%ebp),%edx
    10a2:	8b 45 14             	mov    0x14(%ebp),%eax
    10a5:	01 d0                	add    %edx,%eax
    10a7:	8d 50 ff             	lea    -0x1(%eax),%edx
    10aa:	8b 45 08             	mov    0x8(%ebp),%eax
    10ad:	8b 40 0c             	mov    0xc(%eax),%eax
    10b0:	89 c1                	mov    %eax,%ecx
    10b2:	c1 e9 1f             	shr    $0x1f,%ecx
    10b5:	01 c8                	add    %ecx,%eax
    10b7:	d1 f8                	sar    %eax
    10b9:	29 c2                	sub    %eax,%edx
    10bb:	89 d0                	mov    %edx,%eax
    10bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10c0:	8b 55 10             	mov    0x10(%ebp),%edx
    10c3:	8b 45 18             	mov    0x18(%ebp),%eax
    10c6:	01 d0                	add    %edx,%eax
    10c8:	8d 50 ff             	lea    -0x1(%eax),%edx
    10cb:	8b 45 08             	mov    0x8(%ebp),%eax
    10ce:	8b 40 0c             	mov    0xc(%eax),%eax
    10d1:	89 c1                	mov    %eax,%ecx
    10d3:	c1 e9 1f             	shr    $0x1f,%ecx
    10d6:	01 c8                	add    %ecx,%eax
    10d8:	d1 f8                	sar    %eax
    10da:	29 c2                	sub    %eax,%edx
    10dc:	89 d0                	mov    %edx,%eax
    10de:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    10e1:	8b 45 08             	mov    0x8(%ebp),%eax
    10e4:	8b 40 0c             	mov    0xc(%eax),%eax
    10e7:	89 c2                	mov    %eax,%edx
    10e9:	c1 ea 1f             	shr    $0x1f,%edx
    10ec:	01 d0                	add    %edx,%eax
    10ee:	d1 f8                	sar    %eax
    10f0:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    10f3:	8b 45 08             	mov    0x8(%ebp),%eax
    10f6:	8b 40 0c             	mov    0xc(%eax),%eax
    10f9:	89 c2                	mov    %eax,%edx
    10fb:	c1 ea 1f             	shr    $0x1f,%edx
    10fe:	01 d0                	add    %edx,%eax
    1100:	d1 f8                	sar    %eax
    1102:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1105:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1109:	0f 88 d8 00 00 00    	js     11e7 <APDrawRect+0x1ff>
    110f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1113:	0f 88 ce 00 00 00    	js     11e7 <APDrawRect+0x1ff>
    1119:	8b 45 08             	mov    0x8(%ebp),%eax
    111c:	8b 00                	mov    (%eax),%eax
    111e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1121:	0f 8e c0 00 00 00    	jle    11e7 <APDrawRect+0x1ff>
    1127:	8b 45 08             	mov    0x8(%ebp),%eax
    112a:	8b 40 04             	mov    0x4(%eax),%eax
    112d:	3b 45 10             	cmp    0x10(%ebp),%eax
    1130:	0f 8e b1 00 00 00    	jle    11e7 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1136:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    113a:	79 07                	jns    1143 <APDrawRect+0x15b>
    113c:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1143:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1147:	79 07                	jns    1150 <APDrawRect+0x168>
    1149:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1150:	8b 45 08             	mov    0x8(%ebp),%eax
    1153:	8b 00                	mov    (%eax),%eax
    1155:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1158:	7f 0b                	jg     1165 <APDrawRect+0x17d>
    115a:	8b 45 08             	mov    0x8(%ebp),%eax
    115d:	8b 00                	mov    (%eax),%eax
    115f:	83 e8 01             	sub    $0x1,%eax
    1162:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1165:	8b 45 08             	mov    0x8(%ebp),%eax
    1168:	8b 40 04             	mov    0x4(%eax),%eax
    116b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    116e:	7f 0c                	jg     117c <APDrawRect+0x194>
    1170:	8b 45 08             	mov    0x8(%ebp),%eax
    1173:	8b 40 04             	mov    0x4(%eax),%eax
    1176:	83 e8 01             	sub    $0x1,%eax
    1179:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    117c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1183:	8b 45 0c             	mov    0xc(%ebp),%eax
    1186:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1189:	eb 52                	jmp    11dd <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    118b:	8b 45 10             	mov    0x10(%ebp),%eax
    118e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1191:	eb 3e                	jmp    11d1 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1193:	83 ec 04             	sub    $0x4,%esp
    1196:	ff 75 e8             	pushl  -0x18(%ebp)
    1199:	ff 75 ec             	pushl  -0x14(%ebp)
    119c:	ff 75 08             	pushl  0x8(%ebp)
    119f:	e8 b2 f6 ff ff       	call   856 <APGetIndex>
    11a4:	83 c4 10             	add    $0x10,%esp
    11a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11aa:	8b 45 08             	mov    0x8(%ebp),%eax
    11ad:	8b 48 18             	mov    0x18(%eax),%ecx
    11b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11b3:	89 d0                	mov    %edx,%eax
    11b5:	01 c0                	add    %eax,%eax
    11b7:	01 d0                	add    %edx,%eax
    11b9:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11bc:	8b 45 08             	mov    0x8(%ebp),%eax
    11bf:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11c3:	66 89 0a             	mov    %cx,(%edx)
    11c6:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    11ca:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    11cd:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11d4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11d7:	7e ba                	jle    1193 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11d9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    11dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11e0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11e3:	7e a6                	jle    118b <APDrawRect+0x1a3>
    11e5:	eb 01                	jmp    11e8 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    11e7:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    11e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11eb:	c9                   	leave  
    11ec:	c3                   	ret    

000011ed <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    11ed:	55                   	push   %ebp
    11ee:	89 e5                	mov    %esp,%ebp
    11f0:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    11f3:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    11f7:	0f 88 8e 01 00 00    	js     138b <APDcCopy+0x19e>
    11fd:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1201:	0f 88 84 01 00 00    	js     138b <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1207:	8b 55 0c             	mov    0xc(%ebp),%edx
    120a:	8b 45 20             	mov    0x20(%ebp),%eax
    120d:	01 d0                	add    %edx,%eax
    120f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1212:	8b 55 10             	mov    0x10(%ebp),%edx
    1215:	8b 45 24             	mov    0x24(%ebp),%eax
    1218:	01 d0                	add    %edx,%eax
    121a:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w, y_r = y + h;
    121d:	8b 55 18             	mov    0x18(%ebp),%edx
    1220:	8b 45 20             	mov    0x20(%ebp),%eax
    1223:	01 d0                	add    %edx,%eax
    1225:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1228:	8b 55 1c             	mov    0x1c(%ebp),%edx
    122b:	8b 45 24             	mov    0x24(%ebp),%eax
    122e:	01 d0                	add    %edx,%eax
    1230:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
    1233:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1237:	0f 88 51 01 00 00    	js     138e <APDcCopy+0x1a1>
    123d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1241:	0f 88 47 01 00 00    	js     138e <APDcCopy+0x1a1>
    1247:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    124b:	0f 88 3d 01 00 00    	js     138e <APDcCopy+0x1a1>
    1251:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1255:	0f 88 33 01 00 00    	js     138e <APDcCopy+0x1a1>
    125b:	8b 45 14             	mov    0x14(%ebp),%eax
    125e:	8b 00                	mov    (%eax),%eax
    1260:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1263:	0f 8e 25 01 00 00    	jle    138e <APDcCopy+0x1a1>
    1269:	8b 45 14             	mov    0x14(%ebp),%eax
    126c:	8b 40 04             	mov    0x4(%eax),%eax
    126f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1272:	0f 8e 16 01 00 00    	jle    138e <APDcCopy+0x1a1>
        return;
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    1278:	8b 45 08             	mov    0x8(%ebp),%eax
    127b:	8b 00                	mov    (%eax),%eax
    127d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1280:	7d 0b                	jge    128d <APDcCopy+0xa0>
    1282:	8b 45 08             	mov    0x8(%ebp),%eax
    1285:	8b 00                	mov    (%eax),%eax
    1287:	83 e8 01             	sub    $0x1,%eax
    128a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    128d:	8b 45 08             	mov    0x8(%ebp),%eax
    1290:	8b 40 04             	mov    0x4(%eax),%eax
    1293:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1296:	7d 0c                	jge    12a4 <APDcCopy+0xb7>
    1298:	8b 45 08             	mov    0x8(%ebp),%eax
    129b:	8b 40 04             	mov    0x4(%eax),%eax
    129e:	83 e8 01             	sub    $0x1,%eax
    12a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    12a4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12ab:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j < wy_r - wy; j++)
    12b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12b9:	e9 bc 00 00 00       	jmp    137a <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12be:	8b 45 08             	mov    0x8(%ebp),%eax
    12c1:	8b 00                	mov    (%eax),%eax
    12c3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12c6:	8b 55 10             	mov    0x10(%ebp),%edx
    12c9:	01 ca                	add    %ecx,%edx
    12cb:	0f af d0             	imul   %eax,%edx
    12ce:	8b 45 0c             	mov    0xc(%ebp),%eax
    12d1:	01 d0                	add    %edx,%eax
    12d3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    12d6:	8b 45 14             	mov    0x14(%ebp),%eax
    12d9:	8b 00                	mov    (%eax),%eax
    12db:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12de:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12e1:	01 ca                	add    %ecx,%edx
    12e3:	0f af d0             	imul   %eax,%edx
    12e6:	8b 45 18             	mov    0x18(%ebp),%eax
    12e9:	01 d0                	add    %edx,%eax
    12eb:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i < wx_r - wx; i++)
    12ee:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12f5:	eb 74                	jmp    136b <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    12f7:	8b 45 14             	mov    0x14(%ebp),%eax
    12fa:	8b 50 18             	mov    0x18(%eax),%edx
    12fd:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1300:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1303:	01 c8                	add    %ecx,%eax
    1305:	89 c1                	mov    %eax,%ecx
    1307:	89 c8                	mov    %ecx,%eax
    1309:	01 c0                	add    %eax,%eax
    130b:	01 c8                	add    %ecx,%eax
    130d:	01 d0                	add    %edx,%eax
    130f:	0f b7 10             	movzwl (%eax),%edx
    1312:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1316:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    131a:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    131d:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1321:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1325:	38 c2                	cmp    %al,%dl
    1327:	75 18                	jne    1341 <APDcCopy+0x154>
    1329:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    132d:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1331:	38 c2                	cmp    %al,%dl
    1333:	75 0c                	jne    1341 <APDcCopy+0x154>
    1335:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1339:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    133d:	38 c2                	cmp    %al,%dl
    133f:	74 26                	je     1367 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1341:	8b 45 08             	mov    0x8(%ebp),%eax
    1344:	8b 50 18             	mov    0x18(%eax),%edx
    1347:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    134a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    134d:	01 c8                	add    %ecx,%eax
    134f:	89 c1                	mov    %eax,%ecx
    1351:	89 c8                	mov    %ecx,%eax
    1353:	01 c0                	add    %eax,%eax
    1355:	01 c8                	add    %ecx,%eax
    1357:	01 d0                	add    %edx,%eax
    1359:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    135d:	66 89 10             	mov    %dx,(%eax)
    1360:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1364:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i < wx_r - wx; i++)
    1367:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    136b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    136e:	2b 45 0c             	sub    0xc(%ebp),%eax
    1371:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1374:	7f 81                	jg     12f7 <APDcCopy+0x10a>
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    1376:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    137a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    137d:	2b 45 10             	sub    0x10(%ebp),%eax
    1380:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1383:	0f 8f 35 ff ff ff    	jg     12be <APDcCopy+0xd1>
    1389:	eb 04                	jmp    138f <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    138b:	90                   	nop
    138c:	eb 01                	jmp    138f <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w, y_r = y + h;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
        return;
    138e:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    138f:	c9                   	leave  
    1390:	c3                   	ret    

00001391 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1391:	55                   	push   %ebp
    1392:	89 e5                	mov    %esp,%ebp
    1394:	83 ec 1c             	sub    $0x1c,%esp
    1397:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    139a:	8b 55 10             	mov    0x10(%ebp),%edx
    139d:	8b 45 14             	mov    0x14(%ebp),%eax
    13a0:	88 4d ec             	mov    %cl,-0x14(%ebp)
    13a3:	88 55 e8             	mov    %dl,-0x18(%ebp)
    13a6:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    13a9:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13ad:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13b0:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13b4:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13b7:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13bb:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13be:	8b 45 08             	mov    0x8(%ebp),%eax
    13c1:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13c5:	66 89 10             	mov    %dx,(%eax)
    13c8:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13cc:	88 50 02             	mov    %dl,0x2(%eax)
}
    13cf:	8b 45 08             	mov    0x8(%ebp),%eax
    13d2:	c9                   	leave  
    13d3:	c2 04 00             	ret    $0x4

000013d6 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    13d6:	55                   	push   %ebp
    13d7:	89 e5                	mov    %esp,%ebp
    13d9:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13dc:	8b 45 08             	mov    0x8(%ebp),%eax
    13df:	8b 00                	mov    (%eax),%eax
    13e1:	83 ec 08             	sub    $0x8,%esp
    13e4:	8d 55 0c             	lea    0xc(%ebp),%edx
    13e7:	52                   	push   %edx
    13e8:	50                   	push   %eax
    13e9:	e8 45 ef ff ff       	call   333 <sendMessage>
    13ee:	83 c4 10             	add    $0x10,%esp
}
    13f1:	90                   	nop
    13f2:	c9                   	leave  
    13f3:	c3                   	ret    

000013f4 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    13f4:	55                   	push   %ebp
    13f5:	89 e5                	mov    %esp,%ebp
    13f7:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    13fa:	83 ec 0c             	sub    $0xc,%esp
    13fd:	68 90 00 00 00       	push   $0x90
    1402:	e8 ee f2 ff ff       	call   6f5 <malloc>
    1407:	83 c4 10             	add    $0x10,%esp
    140a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    140d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1411:	75 15                	jne    1428 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1413:	83 ec 04             	sub    $0x4,%esp
    1416:	ff 75 08             	pushl  0x8(%ebp)
    1419:	68 b0 1e 00 00       	push   $0x1eb0
    141e:	6a 01                	push   $0x1
    1420:	e8 fd ef ff ff       	call   422 <printf>
    1425:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1428:	8b 45 f4             	mov    -0xc(%ebp),%eax
    142b:	83 c0 7c             	add    $0x7c,%eax
    142e:	83 ec 08             	sub    $0x8,%esp
    1431:	ff 75 08             	pushl  0x8(%ebp)
    1434:	50                   	push   %eax
    1435:	e8 18 ec ff ff       	call   52 <strcpy>
    143a:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    143d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1440:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1447:	8b 45 f4             	mov    -0xc(%ebp),%eax
    144a:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1451:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1454:	8b 40 34             	mov    0x34(%eax),%eax
    1457:	89 c2                	mov    %eax,%edx
    1459:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145c:	8b 40 38             	mov    0x38(%eax),%eax
    145f:	0f af d0             	imul   %eax,%edx
    1462:	89 d0                	mov    %edx,%eax
    1464:	01 c0                	add    %eax,%eax
    1466:	01 d0                	add    %edx,%eax
    1468:	83 ec 0c             	sub    $0xc,%esp
    146b:	50                   	push   %eax
    146c:	e8 84 f2 ff ff       	call   6f5 <malloc>
    1471:	83 c4 10             	add    $0x10,%esp
    1474:	89 c2                	mov    %eax,%edx
    1476:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1479:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    147c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    147f:	8b 40 4c             	mov    0x4c(%eax),%eax
    1482:	85 c0                	test   %eax,%eax
    1484:	75 15                	jne    149b <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1486:	83 ec 04             	sub    $0x4,%esp
    1489:	ff 75 08             	pushl  0x8(%ebp)
    148c:	68 d0 1e 00 00       	push   $0x1ed0
    1491:	6a 01                	push   $0x1
    1493:	e8 8a ef ff ff       	call   422 <printf>
    1498:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    149b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149e:	8b 40 34             	mov    0x34(%eax),%eax
    14a1:	89 c2                	mov    %eax,%edx
    14a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a6:	8b 40 38             	mov    0x38(%eax),%eax
    14a9:	0f af d0             	imul   %eax,%edx
    14ac:	89 d0                	mov    %edx,%eax
    14ae:	01 c0                	add    %eax,%eax
    14b0:	01 c2                	add    %eax,%edx
    14b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b5:	8b 40 4c             	mov    0x4c(%eax),%eax
    14b8:	83 ec 04             	sub    $0x4,%esp
    14bb:	52                   	push   %edx
    14bc:	68 ff ff ff 00       	push   $0xffffff
    14c1:	50                   	push   %eax
    14c2:	e8 21 ec ff ff       	call   e8 <memset>
    14c7:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cd:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    14d4:	e8 2a ee ff ff       	call   303 <getpid>
    14d9:	89 c2                	mov    %eax,%edx
    14db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14de:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e4:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ee:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    14f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f8:	8b 40 50             	mov    0x50(%eax),%eax
    14fb:	89 c2                	mov    %eax,%edx
    14fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1500:	8b 40 54             	mov    0x54(%eax),%eax
    1503:	0f af d0             	imul   %eax,%edx
    1506:	89 d0                	mov    %edx,%eax
    1508:	01 c0                	add    %eax,%eax
    150a:	01 d0                	add    %edx,%eax
    150c:	83 ec 0c             	sub    $0xc,%esp
    150f:	50                   	push   %eax
    1510:	e8 e0 f1 ff ff       	call   6f5 <malloc>
    1515:	83 c4 10             	add    $0x10,%esp
    1518:	89 c2                	mov    %eax,%edx
    151a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151d:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    1520:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1523:	8b 40 68             	mov    0x68(%eax),%eax
    1526:	85 c0                	test   %eax,%eax
    1528:	75 15                	jne    153f <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    152a:	83 ec 04             	sub    $0x4,%esp
    152d:	ff 75 08             	pushl  0x8(%ebp)
    1530:	68 f4 1e 00 00       	push   $0x1ef4
    1535:	6a 01                	push   $0x1
    1537:	e8 e6 ee ff ff       	call   422 <printf>
    153c:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    153f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1542:	8b 40 34             	mov    0x34(%eax),%eax
    1545:	89 c2                	mov    %eax,%edx
    1547:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154a:	8b 40 38             	mov    0x38(%eax),%eax
    154d:	0f af d0             	imul   %eax,%edx
    1550:	89 d0                	mov    %edx,%eax
    1552:	01 c0                	add    %eax,%eax
    1554:	01 c2                	add    %eax,%edx
    1556:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1559:	8b 40 4c             	mov    0x4c(%eax),%eax
    155c:	83 ec 04             	sub    $0x4,%esp
    155f:	52                   	push   %edx
    1560:	68 ff 00 00 00       	push   $0xff
    1565:	50                   	push   %eax
    1566:	e8 7d eb ff ff       	call   e8 <memset>
    156b:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    156e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1571:	8b 55 0c             	mov    0xc(%ebp),%edx
    1574:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1577:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    157b:	74 35                	je     15b2 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    157d:	8b 45 10             	mov    0x10(%ebp),%eax
    1580:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1586:	83 ec 0c             	sub    $0xc,%esp
    1589:	50                   	push   %eax
    158a:	e8 66 f1 ff ff       	call   6f5 <malloc>
    158f:	83 c4 10             	add    $0x10,%esp
    1592:	89 c2                	mov    %eax,%edx
    1594:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1597:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    159a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159d:	8b 55 10             	mov    0x10(%ebp),%edx
    15a0:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    15a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a6:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    15ad:	e9 8d 00 00 00       	jmp    163f <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b5:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bf:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c9:	8b 40 18             	mov    0x18(%eax),%eax
    15cc:	89 c2                	mov    %eax,%edx
    15ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d1:	8b 40 1c             	mov    0x1c(%eax),%eax
    15d4:	0f af d0             	imul   %eax,%edx
    15d7:	89 d0                	mov    %edx,%eax
    15d9:	01 c0                	add    %eax,%eax
    15db:	01 d0                	add    %edx,%eax
    15dd:	83 ec 0c             	sub    $0xc,%esp
    15e0:	50                   	push   %eax
    15e1:	e8 0f f1 ff ff       	call   6f5 <malloc>
    15e6:	83 c4 10             	add    $0x10,%esp
    15e9:	89 c2                	mov    %eax,%edx
    15eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ee:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    15f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f4:	8b 40 30             	mov    0x30(%eax),%eax
    15f7:	85 c0                	test   %eax,%eax
    15f9:	75 15                	jne    1610 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    15fb:	83 ec 04             	sub    $0x4,%esp
    15fe:	ff 75 08             	pushl  0x8(%ebp)
    1601:	68 1c 1f 00 00       	push   $0x1f1c
    1606:	6a 01                	push   $0x1
    1608:	e8 15 ee ff ff       	call   422 <printf>
    160d:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1610:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1613:	8b 40 18             	mov    0x18(%eax),%eax
    1616:	89 c2                	mov    %eax,%edx
    1618:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161b:	8b 40 1c             	mov    0x1c(%eax),%eax
    161e:	0f af d0             	imul   %eax,%edx
    1621:	89 d0                	mov    %edx,%eax
    1623:	01 c0                	add    %eax,%eax
    1625:	01 c2                	add    %eax,%edx
    1627:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162a:	8b 40 30             	mov    0x30(%eax),%eax
    162d:	83 ec 04             	sub    $0x4,%esp
    1630:	52                   	push   %edx
    1631:	68 ff ff ff 00       	push   $0xffffff
    1636:	50                   	push   %eax
    1637:	e8 ac ea ff ff       	call   e8 <memset>
    163c:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    163f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1642:	c9                   	leave  
    1643:	c3                   	ret    

00001644 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1644:	55                   	push   %ebp
    1645:	89 e5                	mov    %esp,%ebp
    1647:	53                   	push   %ebx
    1648:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    164b:	8b 45 0c             	mov    0xc(%ebp),%eax
    164e:	83 f8 03             	cmp    $0x3,%eax
    1651:	74 02                	je     1655 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1653:	eb 33                	jmp    1688 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1655:	8b 45 08             	mov    0x8(%ebp),%eax
    1658:	8b 48 08             	mov    0x8(%eax),%ecx
    165b:	8b 45 08             	mov    0x8(%ebp),%eax
    165e:	8b 50 38             	mov    0x38(%eax),%edx
    1661:	8b 45 08             	mov    0x8(%ebp),%eax
    1664:	8b 40 34             	mov    0x34(%eax),%eax
    1667:	8b 5d 08             	mov    0x8(%ebp),%ebx
    166a:	83 c3 34             	add    $0x34,%ebx
    166d:	83 ec 0c             	sub    $0xc,%esp
    1670:	51                   	push   %ecx
    1671:	52                   	push   %edx
    1672:	50                   	push   %eax
    1673:	6a 00                	push   $0x0
    1675:	6a 00                	push   $0x0
    1677:	53                   	push   %ebx
    1678:	6a 32                	push   $0x32
    167a:	6a 00                	push   $0x0
    167c:	ff 75 08             	pushl  0x8(%ebp)
    167f:	e8 9f ec ff ff       	call   323 <paintWindow>
    1684:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1687:	90                   	nop
        default: break;
            
            
    }
    return False;
    1688:	b8 00 00 00 00       	mov    $0x0,%eax
}
    168d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1690:	c9                   	leave  
    1691:	c3                   	ret    

00001692 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1692:	55                   	push   %ebp
    1693:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1695:	8b 45 0c             	mov    0xc(%ebp),%eax
    1698:	8b 50 08             	mov    0x8(%eax),%edx
    169b:	8b 45 08             	mov    0x8(%ebp),%eax
    169e:	8b 00                	mov    (%eax),%eax
    16a0:	39 c2                	cmp    %eax,%edx
    16a2:	74 07                	je     16ab <APPreJudge+0x19>
        return False;
    16a4:	b8 00 00 00 00       	mov    $0x0,%eax
    16a9:	eb 05                	jmp    16b0 <APPreJudge+0x1e>
    return True;
    16ab:	b8 01 00 00 00       	mov    $0x1,%eax
}
    16b0:	5d                   	pop    %ebp
    16b1:	c3                   	ret    

000016b2 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    16b2:	55                   	push   %ebp
    16b3:	89 e5                	mov    %esp,%ebp
    16b5:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    16b8:	8b 45 08             	mov    0x8(%ebp),%eax
    16bb:	8b 55 0c             	mov    0xc(%ebp),%edx
    16be:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    16c1:	83 ec 0c             	sub    $0xc,%esp
    16c4:	ff 75 08             	pushl  0x8(%ebp)
    16c7:	e8 77 ec ff ff       	call   343 <registWindow>
    16cc:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    16cf:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    16d6:	8b 45 08             	mov    0x8(%ebp),%eax
    16d9:	8b 00                	mov    (%eax),%eax
    16db:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    16de:	ff 75 f4             	pushl  -0xc(%ebp)
    16e1:	ff 75 f0             	pushl  -0x10(%ebp)
    16e4:	ff 75 ec             	pushl  -0x14(%ebp)
    16e7:	ff 75 08             	pushl  0x8(%ebp)
    16ea:	e8 e7 fc ff ff       	call   13d6 <APSendMessage>
    16ef:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    16f2:	83 ec 0c             	sub    $0xc,%esp
    16f5:	ff 75 08             	pushl  0x8(%ebp)
    16f8:	e8 3e ec ff ff       	call   33b <getMessage>
    16fd:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1700:	8b 45 08             	mov    0x8(%ebp),%eax
    1703:	83 c0 6c             	add    $0x6c,%eax
    1706:	83 ec 08             	sub    $0x8,%esp
    1709:	50                   	push   %eax
    170a:	ff 75 08             	pushl  0x8(%ebp)
    170d:	e8 80 ff ff ff       	call   1692 <APPreJudge>
    1712:	83 c4 10             	add    $0x10,%esp
    1715:	84 c0                	test   %al,%al
    1717:	74 1b                	je     1734 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    1719:	8b 45 08             	mov    0x8(%ebp),%eax
    171c:	ff 70 74             	pushl  0x74(%eax)
    171f:	ff 70 70             	pushl  0x70(%eax)
    1722:	ff 70 6c             	pushl  0x6c(%eax)
    1725:	ff 75 08             	pushl  0x8(%ebp)
    1728:	8b 45 0c             	mov    0xc(%ebp),%eax
    172b:	ff d0                	call   *%eax
    172d:	83 c4 10             	add    $0x10,%esp
    1730:	84 c0                	test   %al,%al
    1732:	75 0c                	jne    1740 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1734:	8b 45 08             	mov    0x8(%ebp),%eax
    1737:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    173e:	eb b2                	jmp    16f2 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1740:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1741:	90                   	nop
    1742:	c9                   	leave  
    1743:	c3                   	ret    

00001744 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1744:	55                   	push   %ebp
    1745:	89 e5                	mov    %esp,%ebp
    1747:	57                   	push   %edi
    1748:	56                   	push   %esi
    1749:	53                   	push   %ebx
    174a:	83 ec 4c             	sub    $0x4c,%esp
    if (!iconReady)
    174d:	a1 04 25 00 00       	mov    0x2504,%eax
    1752:	85 c0                	test   %eax,%eax
    1754:	75 7c                	jne    17d2 <APGridPaint+0x8e>
    {
        iconReady = 1;
    1756:	c7 05 04 25 00 00 01 	movl   $0x1,0x2504
    175d:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("Snake.bmp");
    1760:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1763:	83 ec 08             	sub    $0x8,%esp
    1766:	68 43 1f 00 00       	push   $0x1f43
    176b:	50                   	push   %eax
    176c:	e8 37 f1 ff ff       	call   8a8 <APLoadBitmap>
    1771:	83 c4 0c             	add    $0xc,%esp
    1774:	8b 45 b8             	mov    -0x48(%ebp),%eax
    1777:	a3 08 25 00 00       	mov    %eax,0x2508
    177c:	8b 45 bc             	mov    -0x44(%ebp),%eax
    177f:	a3 0c 25 00 00       	mov    %eax,0x250c
    1784:	8b 45 c0             	mov    -0x40(%ebp),%eax
    1787:	a3 10 25 00 00       	mov    %eax,0x2510
        printf(1,"bitmap loaded!\n");
    178c:	83 ec 08             	sub    $0x8,%esp
    178f:	68 4d 1f 00 00       	push   $0x1f4d
    1794:	6a 01                	push   $0x1
    1796:	e8 87 ec ff ff       	call   422 <printf>
    179b:	83 c4 10             	add    $0x10,%esp
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    179e:	83 ec 04             	sub    $0x4,%esp
    17a1:	ff 35 10 25 00 00    	pushl  0x2510
    17a7:	ff 35 0c 25 00 00    	pushl  0x250c
    17ad:	ff 35 08 25 00 00    	pushl  0x2508
    17b3:	e8 7a f3 ff ff       	call   b32 <APCreateCompatibleDCFromBitmap>
    17b8:	83 c4 10             	add    $0x10,%esp
    17bb:	a3 14 25 00 00       	mov    %eax,0x2514
        printf(1,"bitmap DC created!\n");
    17c0:	83 ec 08             	sub    $0x8,%esp
    17c3:	68 5d 1f 00 00       	push   $0x1f5d
    17c8:	6a 01                	push   $0x1
    17ca:	e8 53 ec ff ff       	call   422 <printf>
    17cf:	83 c4 10             	add    $0x10,%esp
    }
    
    if (!wnd->is_grid)
    17d2:	8b 45 08             	mov    0x8(%ebp),%eax
    17d5:	8b 40 08             	mov    0x8(%eax),%eax
    17d8:	85 c0                	test   %eax,%eax
    17da:	75 17                	jne    17f3 <APGridPaint+0xaf>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    17dc:	83 ec 08             	sub    $0x8,%esp
    17df:	68 74 1f 00 00       	push   $0x1f74
    17e4:	6a 01                	push   $0x1
    17e6:	e8 37 ec ff ff       	call   422 <printf>
    17eb:	83 c4 10             	add    $0x10,%esp
        return;
    17ee:	e9 55 03 00 00       	jmp    1b48 <APGridPaint+0x404>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    17f3:	8b 45 08             	mov    0x8(%ebp),%eax
    17f6:	8b 40 10             	mov    0x10(%eax),%eax
    17f9:	85 c0                	test   %eax,%eax
    17fb:	7e 10                	jle    180d <APGridPaint+0xc9>
    17fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1800:	8b 50 14             	mov    0x14(%eax),%edx
    1803:	8b 45 08             	mov    0x8(%ebp),%eax
    1806:	8b 40 10             	mov    0x10(%eax),%eax
    1809:	39 c2                	cmp    %eax,%edx
    180b:	7c 17                	jl     1824 <APGridPaint+0xe0>
    {
        printf(1,"Grid mode page error!");
    180d:	83 ec 08             	sub    $0x8,%esp
    1810:	68 9a 1f 00 00       	push   $0x1f9a
    1815:	6a 01                	push   $0x1
    1817:	e8 06 ec ff ff       	call   422 <printf>
    181c:	83 c4 10             	add    $0x10,%esp
        return;
    181f:	e9 24 03 00 00       	jmp    1b48 <APGridPaint+0x404>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1824:	8b 45 08             	mov    0x8(%ebp),%eax
    1827:	8b 40 14             	mov    0x14(%eax),%eax
    182a:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1830:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1833:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1836:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1839:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1840:	e9 f9 02 00 00       	jmp    1b3e <APGridPaint+0x3fa>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1845:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    184c:	e9 df 02 00 00       	jmp    1b30 <APGridPaint+0x3ec>
        {
            index = start + GRID_W_NUMBER * j + i;
    1851:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1854:	c1 e0 04             	shl    $0x4,%eax
    1857:	89 c2                	mov    %eax,%edx
    1859:	8b 45 d8             	mov    -0x28(%ebp),%eax
    185c:	01 c2                	add    %eax,%edx
    185e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1861:	01 d0                	add    %edx,%eax
    1863:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1866:	8b 45 08             	mov    0x8(%ebp),%eax
    1869:	8b 40 0c             	mov    0xc(%eax),%eax
    186c:	8b 55 dc             	mov    -0x24(%ebp),%edx
    186f:	c1 e2 02             	shl    $0x2,%edx
    1872:	01 d0                	add    %edx,%eax
    1874:	8b 00                	mov    (%eax),%eax
    1876:	83 f8 01             	cmp    $0x1,%eax
    1879:	0f 84 83 00 00 00    	je     1902 <APGridPaint+0x1be>
    187f:	83 f8 01             	cmp    $0x1,%eax
    1882:	7f 09                	jg     188d <APGridPaint+0x149>
    1884:	85 c0                	test   %eax,%eax
    1886:	74 1c                	je     18a4 <APGridPaint+0x160>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    1888:	e9 9f 02 00 00       	jmp    1b2c <APGridPaint+0x3e8>
        for (int i = 0; i < GRID_W_NUMBER;i++)
        {
            index = start + GRID_W_NUMBER * j + i;
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    188d:	83 f8 02             	cmp    $0x2,%eax
    1890:	0f 84 20 01 00 00    	je     19b6 <APGridPaint+0x272>
    1896:	83 f8 03             	cmp    $0x3,%eax
    1899:	0f 84 d1 01 00 00    	je     1a70 <APGridPaint+0x32c>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    189f:	e9 88 02 00 00       	jmp    1b2c <APGridPaint+0x3e8>
                    pen.size = 1;
                    brush.color = RGB(0xd2,0x69,0x1e);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);*/
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    18a4:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    18a7:	6a 0c                	push   $0xc
    18a9:	6a 0c                	push   $0xc
    18ab:	6a 0c                	push   $0xc
    18ad:	50                   	push   %eax
    18ae:	e8 de fa ff ff       	call   1391 <RGB>
    18b3:	83 c4 0c             	add    $0xc,%esp
    18b6:	8b 1d 14 25 00 00    	mov    0x2514,%ebx
    18bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18bf:	6b c8 32             	imul   $0x32,%eax,%ecx
    18c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    18c5:	6b c0 32             	imul   $0x32,%eax,%eax
    18c8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    18cb:	8b 45 08             	mov    0x8(%ebp),%eax
    18ce:	8d 78 34             	lea    0x34(%eax),%edi
    18d1:	83 ec 0c             	sub    $0xc,%esp
    18d4:	83 ec 04             	sub    $0x4,%esp
    18d7:	89 e0                	mov    %esp,%eax
    18d9:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    18dd:	66 89 30             	mov    %si,(%eax)
    18e0:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    18e4:	88 50 02             	mov    %dl,0x2(%eax)
    18e7:	6a 32                	push   $0x32
    18e9:	6a 32                	push   $0x32
    18eb:	6a 00                	push   $0x0
    18ed:	6a 00                	push   $0x0
    18ef:	53                   	push   %ebx
    18f0:	51                   	push   %ecx
    18f1:	ff 75 b4             	pushl  -0x4c(%ebp)
    18f4:	57                   	push   %edi
    18f5:	e8 f3 f8 ff ff       	call   11ed <APDcCopy>
    18fa:	83 c4 30             	add    $0x30,%esp
                    break;
    18fd:	e9 2a 02 00 00       	jmp    1b2c <APGridPaint+0x3e8>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1902:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1905:	6a 69                	push   $0x69
    1907:	6a 69                	push   $0x69
    1909:	6a 69                	push   $0x69
    190b:	50                   	push   %eax
    190c:	e8 80 fa ff ff       	call   1391 <RGB>
    1911:	83 c4 0c             	add    $0xc,%esp
    1914:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1918:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    191c:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1920:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1923:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    192a:	8d 45 b8             	lea    -0x48(%ebp),%eax
    192d:	6a 69                	push   $0x69
    192f:	6a 69                	push   $0x69
    1931:	6a 69                	push   $0x69
    1933:	50                   	push   %eax
    1934:	e8 58 fa ff ff       	call   1391 <RGB>
    1939:	83 c4 0c             	add    $0xc,%esp
    193c:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1940:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1944:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1948:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    194b:	8b 45 08             	mov    0x8(%ebp),%eax
    194e:	8d 50 34             	lea    0x34(%eax),%edx
    1951:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1954:	ff 75 d0             	pushl  -0x30(%ebp)
    1957:	ff 75 cc             	pushl  -0x34(%ebp)
    195a:	52                   	push   %edx
    195b:	50                   	push   %eax
    195c:	e8 66 f2 ff ff       	call   bc7 <APSetPen>
    1961:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1964:	8b 45 08             	mov    0x8(%ebp),%eax
    1967:	8d 58 34             	lea    0x34(%eax),%ebx
    196a:	8d 55 b8             	lea    -0x48(%ebp),%edx
    196d:	83 ec 04             	sub    $0x4,%esp
    1970:	83 ec 04             	sub    $0x4,%esp
    1973:	89 e0                	mov    %esp,%eax
    1975:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1979:	66 89 08             	mov    %cx,(%eax)
    197c:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1980:	88 48 02             	mov    %cl,0x2(%eax)
    1983:	53                   	push   %ebx
    1984:	52                   	push   %edx
    1985:	e8 76 f2 ff ff       	call   c00 <APSetBrush>
    198a:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    198d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1990:	6b d0 32             	imul   $0x32,%eax,%edx
    1993:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1996:	6b c0 32             	imul   $0x32,%eax,%eax
    1999:	8b 4d 08             	mov    0x8(%ebp),%ecx
    199c:	83 c1 34             	add    $0x34,%ecx
    199f:	83 ec 0c             	sub    $0xc,%esp
    19a2:	6a 32                	push   $0x32
    19a4:	6a 32                	push   $0x32
    19a6:	52                   	push   %edx
    19a7:	50                   	push   %eax
    19a8:	51                   	push   %ecx
    19a9:	e8 3a f6 ff ff       	call   fe8 <APDrawRect>
    19ae:	83 c4 20             	add    $0x20,%esp
                    break;
    19b1:	e9 76 01 00 00       	jmp    1b2c <APGridPaint+0x3e8>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    pen.color = RGB(0x00,0x80,0x00);
    19b6:	8d 45 b8             	lea    -0x48(%ebp),%eax
    19b9:	6a 00                	push   $0x0
    19bb:	68 80 00 00 00       	push   $0x80
    19c0:	6a 00                	push   $0x0
    19c2:	50                   	push   %eax
    19c3:	e8 c9 f9 ff ff       	call   1391 <RGB>
    19c8:	83 c4 0c             	add    $0xc,%esp
    19cb:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    19cf:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    19d3:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    19d7:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    19da:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0x80,0x00);
    19e1:	8d 45 b8             	lea    -0x48(%ebp),%eax
    19e4:	6a 00                	push   $0x0
    19e6:	68 80 00 00 00       	push   $0x80
    19eb:	6a 00                	push   $0x0
    19ed:	50                   	push   %eax
    19ee:	e8 9e f9 ff ff       	call   1391 <RGB>
    19f3:	83 c4 0c             	add    $0xc,%esp
    19f6:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    19fa:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    19fe:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1a02:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1a05:	8b 45 08             	mov    0x8(%ebp),%eax
    1a08:	8d 50 34             	lea    0x34(%eax),%edx
    1a0b:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a0e:	ff 75 d0             	pushl  -0x30(%ebp)
    1a11:	ff 75 cc             	pushl  -0x34(%ebp)
    1a14:	52                   	push   %edx
    1a15:	50                   	push   %eax
    1a16:	e8 ac f1 ff ff       	call   bc7 <APSetPen>
    1a1b:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1a1e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a21:	8d 58 34             	lea    0x34(%eax),%ebx
    1a24:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1a27:	83 ec 04             	sub    $0x4,%esp
    1a2a:	83 ec 04             	sub    $0x4,%esp
    1a2d:	89 e0                	mov    %esp,%eax
    1a2f:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1a33:	66 89 08             	mov    %cx,(%eax)
    1a36:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1a3a:	88 48 02             	mov    %cl,0x2(%eax)
    1a3d:	53                   	push   %ebx
    1a3e:	52                   	push   %edx
    1a3f:	e8 bc f1 ff ff       	call   c00 <APSetBrush>
    1a44:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1a47:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a4a:	6b d0 32             	imul   $0x32,%eax,%edx
    1a4d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a50:	6b c0 32             	imul   $0x32,%eax,%eax
    1a53:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a56:	83 c1 34             	add    $0x34,%ecx
    1a59:	83 ec 0c             	sub    $0xc,%esp
    1a5c:	6a 32                	push   $0x32
    1a5e:	6a 32                	push   $0x32
    1a60:	52                   	push   %edx
    1a61:	50                   	push   %eax
    1a62:	51                   	push   %ecx
    1a63:	e8 80 f5 ff ff       	call   fe8 <APDrawRect>
    1a68:	83 c4 20             	add    $0x20,%esp
                    break;
    1a6b:	e9 bc 00 00 00       	jmp    1b2c <APGridPaint+0x3e8>
                case GRID_RIVER:
                    //printf(1,"Grid_River");
                    pen.color = RGB(0x00,0xbf,0xff);
    1a70:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a73:	68 ff 00 00 00       	push   $0xff
    1a78:	68 bf 00 00 00       	push   $0xbf
    1a7d:	6a 00                	push   $0x0
    1a7f:	50                   	push   %eax
    1a80:	e8 0c f9 ff ff       	call   1391 <RGB>
    1a85:	83 c4 0c             	add    $0xc,%esp
    1a88:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1a8c:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1a90:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1a94:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1a97:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0xbf,0xff);
    1a9e:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1aa1:	68 ff 00 00 00       	push   $0xff
    1aa6:	68 bf 00 00 00       	push   $0xbf
    1aab:	6a 00                	push   $0x0
    1aad:	50                   	push   %eax
    1aae:	e8 de f8 ff ff       	call   1391 <RGB>
    1ab3:	83 c4 0c             	add    $0xc,%esp
    1ab6:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1aba:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1abe:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1ac2:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1ac5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac8:	8d 50 34             	lea    0x34(%eax),%edx
    1acb:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1ace:	ff 75 d0             	pushl  -0x30(%ebp)
    1ad1:	ff 75 cc             	pushl  -0x34(%ebp)
    1ad4:	52                   	push   %edx
    1ad5:	50                   	push   %eax
    1ad6:	e8 ec f0 ff ff       	call   bc7 <APSetPen>
    1adb:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1ade:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae1:	8d 58 34             	lea    0x34(%eax),%ebx
    1ae4:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1ae7:	83 ec 04             	sub    $0x4,%esp
    1aea:	83 ec 04             	sub    $0x4,%esp
    1aed:	89 e0                	mov    %esp,%eax
    1aef:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1af3:	66 89 08             	mov    %cx,(%eax)
    1af6:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1afa:	88 48 02             	mov    %cl,0x2(%eax)
    1afd:	53                   	push   %ebx
    1afe:	52                   	push   %edx
    1aff:	e8 fc f0 ff ff       	call   c00 <APSetBrush>
    1b04:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
    1b07:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b0a:	6b d0 32             	imul   $0x32,%eax,%edx
    1b0d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b10:	6b c0 32             	imul   $0x32,%eax,%eax
    1b13:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b16:	83 c1 34             	add    $0x34,%ecx
    1b19:	83 ec 0c             	sub    $0xc,%esp
    1b1c:	6a 32                	push   $0x32
    1b1e:	6a 32                	push   $0x32
    1b20:	52                   	push   %edx
    1b21:	50                   	push   %eax
    1b22:	51                   	push   %ecx
    1b23:	e8 c0 f4 ff ff       	call   fe8 <APDrawRect>
    1b28:	83 c4 20             	add    $0x20,%esp
                    break;
    1b2b:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1b2c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1b30:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1b34:	0f 8e 17 fd ff ff    	jle    1851 <APGridPaint+0x10d>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1b3a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1b3e:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1b42:	0f 8e fd fc ff ff    	jle    1845 <APGridPaint+0x101>
                    break;
                default: break;
            }
        }
    }
}
    1b48:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b4b:	5b                   	pop    %ebx
    1b4c:	5e                   	pop    %esi
    1b4d:	5f                   	pop    %edi
    1b4e:	5d                   	pop    %ebp
    1b4f:	c3                   	ret    

00001b50 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1b50:	55                   	push   %ebp
    1b51:	89 e5                	mov    %esp,%ebp
    1b53:	53                   	push   %ebx
    1b54:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1b57:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1b5e:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1b62:	74 17                	je     1b7b <sprintint+0x2b>
    1b64:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1b68:	79 11                	jns    1b7b <sprintint+0x2b>
        neg = 1;
    1b6a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1b71:	8b 45 10             	mov    0x10(%ebp),%eax
    1b74:	f7 d8                	neg    %eax
    1b76:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b79:	eb 06                	jmp    1b81 <sprintint+0x31>
    } else {
        x = xx;
    1b7b:	8b 45 10             	mov    0x10(%ebp),%eax
    1b7e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1b81:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1b88:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1b8b:	8d 41 01             	lea    0x1(%ecx),%eax
    1b8e:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1b91:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1b94:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b97:	ba 00 00 00 00       	mov    $0x0,%edx
    1b9c:	f7 f3                	div    %ebx
    1b9e:	89 d0                	mov    %edx,%eax
    1ba0:	0f b6 80 e4 24 00 00 	movzbl 0x24e4(%eax),%eax
    1ba7:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1bab:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1bae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bb1:	ba 00 00 00 00       	mov    $0x0,%edx
    1bb6:	f7 f3                	div    %ebx
    1bb8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1bbb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1bbf:	75 c7                	jne    1b88 <sprintint+0x38>
    if(neg)
    1bc1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1bc5:	74 0e                	je     1bd5 <sprintint+0x85>
        buf[i++] = '-';
    1bc7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1bca:	8d 50 01             	lea    0x1(%eax),%edx
    1bcd:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1bd0:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1bd5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1bd8:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1bdb:	eb 1b                	jmp    1bf8 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1bdd:	8b 45 0c             	mov    0xc(%ebp),%eax
    1be0:	8b 00                	mov    (%eax),%eax
    1be2:	8d 48 01             	lea    0x1(%eax),%ecx
    1be5:	8b 55 0c             	mov    0xc(%ebp),%edx
    1be8:	89 0a                	mov    %ecx,(%edx)
    1bea:	89 c2                	mov    %eax,%edx
    1bec:	8b 45 08             	mov    0x8(%ebp),%eax
    1bef:	01 d0                	add    %edx,%eax
    1bf1:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1bf4:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1bf8:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1bfc:	7f df                	jg     1bdd <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1bfe:	eb 21                	jmp    1c21 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1c00:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c03:	8b 00                	mov    (%eax),%eax
    1c05:	8d 48 01             	lea    0x1(%eax),%ecx
    1c08:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c0b:	89 0a                	mov    %ecx,(%edx)
    1c0d:	89 c2                	mov    %eax,%edx
    1c0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c12:	01 c2                	add    %eax,%edx
    1c14:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1c17:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c1a:	01 c8                	add    %ecx,%eax
    1c1c:	0f b6 00             	movzbl (%eax),%eax
    1c1f:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1c21:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1c25:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1c29:	79 d5                	jns    1c00 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1c2b:	90                   	nop
    1c2c:	83 c4 20             	add    $0x20,%esp
    1c2f:	5b                   	pop    %ebx
    1c30:	5d                   	pop    %ebp
    1c31:	c3                   	ret    

00001c32 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1c32:	55                   	push   %ebp
    1c33:	89 e5                	mov    %esp,%ebp
    1c35:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1c38:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1c3f:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1c46:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1c4d:	8d 45 0c             	lea    0xc(%ebp),%eax
    1c50:	83 c0 04             	add    $0x4,%eax
    1c53:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1c56:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1c5d:	e9 d9 01 00 00       	jmp    1e3b <sprintf+0x209>
        c = fmt[i] & 0xff;
    1c62:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c65:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c68:	01 d0                	add    %edx,%eax
    1c6a:	0f b6 00             	movzbl (%eax),%eax
    1c6d:	0f be c0             	movsbl %al,%eax
    1c70:	25 ff 00 00 00       	and    $0xff,%eax
    1c75:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1c78:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1c7c:	75 2c                	jne    1caa <sprintf+0x78>
            if(c == '%'){
    1c7e:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1c82:	75 0c                	jne    1c90 <sprintf+0x5e>
                state = '%';
    1c84:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1c8b:	e9 a7 01 00 00       	jmp    1e37 <sprintf+0x205>
            } else {
                dst[j++] = c;
    1c90:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1c93:	8d 50 01             	lea    0x1(%eax),%edx
    1c96:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1c99:	89 c2                	mov    %eax,%edx
    1c9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c9e:	01 d0                	add    %edx,%eax
    1ca0:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1ca3:	88 10                	mov    %dl,(%eax)
    1ca5:	e9 8d 01 00 00       	jmp    1e37 <sprintf+0x205>
            }
        } else if(state == '%'){
    1caa:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1cae:	0f 85 83 01 00 00    	jne    1e37 <sprintf+0x205>
            if(c == 'd'){
    1cb4:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1cb8:	75 4c                	jne    1d06 <sprintf+0xd4>
                buf[bi] = '\0';
    1cba:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1cbd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cc0:	01 d0                	add    %edx,%eax
    1cc2:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1cc5:	83 ec 0c             	sub    $0xc,%esp
    1cc8:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1ccb:	50                   	push   %eax
    1ccc:	e8 20 e5 ff ff       	call   1f1 <atoi>
    1cd1:	83 c4 10             	add    $0x10,%esp
    1cd4:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1cd7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1cde:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ce1:	8b 00                	mov    (%eax),%eax
    1ce3:	83 ec 08             	sub    $0x8,%esp
    1ce6:	ff 75 d8             	pushl  -0x28(%ebp)
    1ce9:	6a 01                	push   $0x1
    1ceb:	6a 0a                	push   $0xa
    1ced:	50                   	push   %eax
    1cee:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1cf1:	50                   	push   %eax
    1cf2:	ff 75 08             	pushl  0x8(%ebp)
    1cf5:	e8 56 fe ff ff       	call   1b50 <sprintint>
    1cfa:	83 c4 20             	add    $0x20,%esp
                ap++;
    1cfd:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1d01:	e9 2a 01 00 00       	jmp    1e30 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1d06:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1d0a:	74 06                	je     1d12 <sprintf+0xe0>
    1d0c:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1d10:	75 4c                	jne    1d5e <sprintf+0x12c>
                buf[bi] = '\0';
    1d12:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1d15:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d18:	01 d0                	add    %edx,%eax
    1d1a:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1d1d:	83 ec 0c             	sub    $0xc,%esp
    1d20:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1d23:	50                   	push   %eax
    1d24:	e8 c8 e4 ff ff       	call   1f1 <atoi>
    1d29:	83 c4 10             	add    $0x10,%esp
    1d2c:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1d2f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1d36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d39:	8b 00                	mov    (%eax),%eax
    1d3b:	83 ec 08             	sub    $0x8,%esp
    1d3e:	ff 75 dc             	pushl  -0x24(%ebp)
    1d41:	6a 00                	push   $0x0
    1d43:	6a 10                	push   $0x10
    1d45:	50                   	push   %eax
    1d46:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1d49:	50                   	push   %eax
    1d4a:	ff 75 08             	pushl  0x8(%ebp)
    1d4d:	e8 fe fd ff ff       	call   1b50 <sprintint>
    1d52:	83 c4 20             	add    $0x20,%esp
                ap++;
    1d55:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1d59:	e9 d2 00 00 00       	jmp    1e30 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1d5e:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1d62:	75 46                	jne    1daa <sprintf+0x178>
                s = (char*)*ap;
    1d64:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d67:	8b 00                	mov    (%eax),%eax
    1d69:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1d6c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1d70:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d74:	75 25                	jne    1d9b <sprintf+0x169>
                    s = "(null)";
    1d76:	c7 45 f4 b0 1f 00 00 	movl   $0x1fb0,-0xc(%ebp)
                while(*s != 0){
    1d7d:	eb 1c                	jmp    1d9b <sprintf+0x169>
                    dst[j++] = *s;
    1d7f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1d82:	8d 50 01             	lea    0x1(%eax),%edx
    1d85:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1d88:	89 c2                	mov    %eax,%edx
    1d8a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d8d:	01 c2                	add    %eax,%edx
    1d8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d92:	0f b6 00             	movzbl (%eax),%eax
    1d95:	88 02                	mov    %al,(%edx)
                    s++;
    1d97:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    1d9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d9e:	0f b6 00             	movzbl (%eax),%eax
    1da1:	84 c0                	test   %al,%al
    1da3:	75 da                	jne    1d7f <sprintf+0x14d>
    1da5:	e9 86 00 00 00       	jmp    1e30 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    1daa:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    1dae:	75 1d                	jne    1dcd <sprintf+0x19b>
                dst[j++] = *ap;
    1db0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1db3:	8d 50 01             	lea    0x1(%eax),%edx
    1db6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1db9:	89 c2                	mov    %eax,%edx
    1dbb:	8b 45 08             	mov    0x8(%ebp),%eax
    1dbe:	01 c2                	add    %eax,%edx
    1dc0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dc3:	8b 00                	mov    (%eax),%eax
    1dc5:	88 02                	mov    %al,(%edx)
                ap++;
    1dc7:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1dcb:	eb 63                	jmp    1e30 <sprintf+0x1fe>
            } else if(c == '%'){
    1dcd:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1dd1:	75 17                	jne    1dea <sprintf+0x1b8>
                dst[j++] = c;
    1dd3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1dd6:	8d 50 01             	lea    0x1(%eax),%edx
    1dd9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1ddc:	89 c2                	mov    %eax,%edx
    1dde:	8b 45 08             	mov    0x8(%ebp),%eax
    1de1:	01 d0                	add    %edx,%eax
    1de3:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1de6:	88 10                	mov    %dl,(%eax)
    1de8:	eb 46                	jmp    1e30 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    1dea:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    1dee:	7e 18                	jle    1e08 <sprintf+0x1d6>
    1df0:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    1df4:	7f 12                	jg     1e08 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    1df6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1df9:	8d 50 01             	lea    0x1(%eax),%edx
    1dfc:	89 55 f0             	mov    %edx,-0x10(%ebp)
    1dff:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1e02:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    1e06:	eb 2f                	jmp    1e37 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    1e08:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e0b:	8d 50 01             	lea    0x1(%eax),%edx
    1e0e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e11:	89 c2                	mov    %eax,%edx
    1e13:	8b 45 08             	mov    0x8(%ebp),%eax
    1e16:	01 d0                	add    %edx,%eax
    1e18:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    1e1b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e1e:	8d 50 01             	lea    0x1(%eax),%edx
    1e21:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e24:	89 c2                	mov    %eax,%edx
    1e26:	8b 45 08             	mov    0x8(%ebp),%eax
    1e29:	01 d0                	add    %edx,%eax
    1e2b:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1e2e:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    1e30:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    1e37:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1e3b:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e3e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e41:	01 d0                	add    %edx,%eax
    1e43:	0f b6 00             	movzbl (%eax),%eax
    1e46:	84 c0                	test   %al,%al
    1e48:	0f 85 14 fe ff ff    	jne    1c62 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    1e4e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e51:	8d 50 01             	lea    0x1(%eax),%edx
    1e54:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e57:	89 c2                	mov    %eax,%edx
    1e59:	8b 45 08             	mov    0x8(%ebp),%eax
    1e5c:	01 d0                	add    %edx,%eax
    1e5e:	c6 00 00             	movb   $0x0,(%eax)
}
    1e61:	90                   	nop
    1e62:	c9                   	leave  
    1e63:	c3                   	ret    
