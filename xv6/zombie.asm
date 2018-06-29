
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

0000034b <setupTimer>:
SYSCALL(setupTimer)
     34b:	b8 1b 00 00 00       	mov    $0x1b,%eax
     350:	cd 40                	int    $0x40
     352:	c3                   	ret    

00000353 <deleteTimer>:
SYSCALL(deleteTimer)
     353:	b8 1c 00 00 00       	mov    $0x1c,%eax
     358:	cd 40                	int    $0x40
     35a:	c3                   	ret    

0000035b <getCurrentTime>:
SYSCALL(getCurrentTime)
     35b:	b8 1d 00 00 00       	mov    $0x1d,%eax
     360:	cd 40                	int    $0x40
     362:	c3                   	ret    

00000363 <removeWindow>:
SYSCALL(removeWindow)
     363:	b8 1e 00 00 00       	mov    $0x1e,%eax
     368:	cd 40                	int    $0x40
     36a:	c3                   	ret    

0000036b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     36b:	55                   	push   %ebp
     36c:	89 e5                	mov    %esp,%ebp
     36e:	83 ec 18             	sub    $0x18,%esp
     371:	8b 45 0c             	mov    0xc(%ebp),%eax
     374:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     377:	83 ec 04             	sub    $0x4,%esp
     37a:	6a 01                	push   $0x1
     37c:	8d 45 f4             	lea    -0xc(%ebp),%eax
     37f:	50                   	push   %eax
     380:	ff 75 08             	pushl  0x8(%ebp)
     383:	e8 1b ff ff ff       	call   2a3 <write>
     388:	83 c4 10             	add    $0x10,%esp
}
     38b:	90                   	nop
     38c:	c9                   	leave  
     38d:	c3                   	ret    

0000038e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     38e:	55                   	push   %ebp
     38f:	89 e5                	mov    %esp,%ebp
     391:	53                   	push   %ebx
     392:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     395:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     39c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3a0:	74 17                	je     3b9 <printint+0x2b>
     3a2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3a6:	79 11                	jns    3b9 <printint+0x2b>
    neg = 1;
     3a8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3af:	8b 45 0c             	mov    0xc(%ebp),%eax
     3b2:	f7 d8                	neg    %eax
     3b4:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3b7:	eb 06                	jmp    3bf <printint+0x31>
  } else {
    x = xx;
     3b9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3c6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3c9:	8d 41 01             	lea    0x1(%ecx),%eax
     3cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3cf:	8b 5d 10             	mov    0x10(%ebp),%ebx
     3d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3d5:	ba 00 00 00 00       	mov    $0x0,%edx
     3da:	f7 f3                	div    %ebx
     3dc:	89 d0                	mov    %edx,%eax
     3de:	0f b6 80 80 2b 00 00 	movzbl 0x2b80(%eax),%eax
     3e5:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     3e9:	8b 5d 10             	mov    0x10(%ebp),%ebx
     3ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3ef:	ba 00 00 00 00       	mov    $0x0,%edx
     3f4:	f7 f3                	div    %ebx
     3f6:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3f9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     3fd:	75 c7                	jne    3c6 <printint+0x38>
  if(neg)
     3ff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     403:	74 2d                	je     432 <printint+0xa4>
    buf[i++] = '-';
     405:	8b 45 f4             	mov    -0xc(%ebp),%eax
     408:	8d 50 01             	lea    0x1(%eax),%edx
     40b:	89 55 f4             	mov    %edx,-0xc(%ebp)
     40e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     413:	eb 1d                	jmp    432 <printint+0xa4>
    putc(fd, buf[i]);
     415:	8d 55 dc             	lea    -0x24(%ebp),%edx
     418:	8b 45 f4             	mov    -0xc(%ebp),%eax
     41b:	01 d0                	add    %edx,%eax
     41d:	0f b6 00             	movzbl (%eax),%eax
     420:	0f be c0             	movsbl %al,%eax
     423:	83 ec 08             	sub    $0x8,%esp
     426:	50                   	push   %eax
     427:	ff 75 08             	pushl  0x8(%ebp)
     42a:	e8 3c ff ff ff       	call   36b <putc>
     42f:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     432:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     436:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     43a:	79 d9                	jns    415 <printint+0x87>
    putc(fd, buf[i]);
}
     43c:	90                   	nop
     43d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     440:	c9                   	leave  
     441:	c3                   	ret    

00000442 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     442:	55                   	push   %ebp
     443:	89 e5                	mov    %esp,%ebp
     445:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     448:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     44f:	8d 45 0c             	lea    0xc(%ebp),%eax
     452:	83 c0 04             	add    $0x4,%eax
     455:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     458:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     45f:	e9 59 01 00 00       	jmp    5bd <printf+0x17b>
    c = fmt[i] & 0xff;
     464:	8b 55 0c             	mov    0xc(%ebp),%edx
     467:	8b 45 f0             	mov    -0x10(%ebp),%eax
     46a:	01 d0                	add    %edx,%eax
     46c:	0f b6 00             	movzbl (%eax),%eax
     46f:	0f be c0             	movsbl %al,%eax
     472:	25 ff 00 00 00       	and    $0xff,%eax
     477:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     47a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     47e:	75 2c                	jne    4ac <printf+0x6a>
      if(c == '%'){
     480:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     484:	75 0c                	jne    492 <printf+0x50>
        state = '%';
     486:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     48d:	e9 27 01 00 00       	jmp    5b9 <printf+0x177>
      } else {
        putc(fd, c);
     492:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     495:	0f be c0             	movsbl %al,%eax
     498:	83 ec 08             	sub    $0x8,%esp
     49b:	50                   	push   %eax
     49c:	ff 75 08             	pushl  0x8(%ebp)
     49f:	e8 c7 fe ff ff       	call   36b <putc>
     4a4:	83 c4 10             	add    $0x10,%esp
     4a7:	e9 0d 01 00 00       	jmp    5b9 <printf+0x177>
      }
    } else if(state == '%'){
     4ac:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4b0:	0f 85 03 01 00 00    	jne    5b9 <printf+0x177>
      if(c == 'd'){
     4b6:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4ba:	75 1e                	jne    4da <printf+0x98>
        printint(fd, *ap, 10, 1);
     4bc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4bf:	8b 00                	mov    (%eax),%eax
     4c1:	6a 01                	push   $0x1
     4c3:	6a 0a                	push   $0xa
     4c5:	50                   	push   %eax
     4c6:	ff 75 08             	pushl  0x8(%ebp)
     4c9:	e8 c0 fe ff ff       	call   38e <printint>
     4ce:	83 c4 10             	add    $0x10,%esp
        ap++;
     4d1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4d5:	e9 d8 00 00 00       	jmp    5b2 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     4da:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     4de:	74 06                	je     4e6 <printf+0xa4>
     4e0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     4e4:	75 1e                	jne    504 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     4e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4e9:	8b 00                	mov    (%eax),%eax
     4eb:	6a 00                	push   $0x0
     4ed:	6a 10                	push   $0x10
     4ef:	50                   	push   %eax
     4f0:	ff 75 08             	pushl  0x8(%ebp)
     4f3:	e8 96 fe ff ff       	call   38e <printint>
     4f8:	83 c4 10             	add    $0x10,%esp
        ap++;
     4fb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4ff:	e9 ae 00 00 00       	jmp    5b2 <printf+0x170>
      } else if(c == 's'){
     504:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     508:	75 43                	jne    54d <printf+0x10b>
        s = (char*)*ap;
     50a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     50d:	8b 00                	mov    (%eax),%eax
     50f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     512:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     516:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     51a:	75 25                	jne    541 <printf+0xff>
          s = "(null)";
     51c:	c7 45 f4 5c 24 00 00 	movl   $0x245c,-0xc(%ebp)
        while(*s != 0){
     523:	eb 1c                	jmp    541 <printf+0xff>
          putc(fd, *s);
     525:	8b 45 f4             	mov    -0xc(%ebp),%eax
     528:	0f b6 00             	movzbl (%eax),%eax
     52b:	0f be c0             	movsbl %al,%eax
     52e:	83 ec 08             	sub    $0x8,%esp
     531:	50                   	push   %eax
     532:	ff 75 08             	pushl  0x8(%ebp)
     535:	e8 31 fe ff ff       	call   36b <putc>
     53a:	83 c4 10             	add    $0x10,%esp
          s++;
     53d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     541:	8b 45 f4             	mov    -0xc(%ebp),%eax
     544:	0f b6 00             	movzbl (%eax),%eax
     547:	84 c0                	test   %al,%al
     549:	75 da                	jne    525 <printf+0xe3>
     54b:	eb 65                	jmp    5b2 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     54d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     551:	75 1d                	jne    570 <printf+0x12e>
        putc(fd, *ap);
     553:	8b 45 e8             	mov    -0x18(%ebp),%eax
     556:	8b 00                	mov    (%eax),%eax
     558:	0f be c0             	movsbl %al,%eax
     55b:	83 ec 08             	sub    $0x8,%esp
     55e:	50                   	push   %eax
     55f:	ff 75 08             	pushl  0x8(%ebp)
     562:	e8 04 fe ff ff       	call   36b <putc>
     567:	83 c4 10             	add    $0x10,%esp
        ap++;
     56a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     56e:	eb 42                	jmp    5b2 <printf+0x170>
      } else if(c == '%'){
     570:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     574:	75 17                	jne    58d <printf+0x14b>
        putc(fd, c);
     576:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     579:	0f be c0             	movsbl %al,%eax
     57c:	83 ec 08             	sub    $0x8,%esp
     57f:	50                   	push   %eax
     580:	ff 75 08             	pushl  0x8(%ebp)
     583:	e8 e3 fd ff ff       	call   36b <putc>
     588:	83 c4 10             	add    $0x10,%esp
     58b:	eb 25                	jmp    5b2 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     58d:	83 ec 08             	sub    $0x8,%esp
     590:	6a 25                	push   $0x25
     592:	ff 75 08             	pushl  0x8(%ebp)
     595:	e8 d1 fd ff ff       	call   36b <putc>
     59a:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     59d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5a0:	0f be c0             	movsbl %al,%eax
     5a3:	83 ec 08             	sub    $0x8,%esp
     5a6:	50                   	push   %eax
     5a7:	ff 75 08             	pushl  0x8(%ebp)
     5aa:	e8 bc fd ff ff       	call   36b <putc>
     5af:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5b2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5b9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5bd:	8b 55 0c             	mov    0xc(%ebp),%edx
     5c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5c3:	01 d0                	add    %edx,%eax
     5c5:	0f b6 00             	movzbl (%eax),%eax
     5c8:	84 c0                	test   %al,%al
     5ca:	0f 85 94 fe ff ff    	jne    464 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     5d0:	90                   	nop
     5d1:	c9                   	leave  
     5d2:	c3                   	ret    

000005d3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     5d3:	55                   	push   %ebp
     5d4:	89 e5                	mov    %esp,%ebp
     5d6:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     5d9:	8b 45 08             	mov    0x8(%ebp),%eax
     5dc:	83 e8 08             	sub    $0x8,%eax
     5df:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     5e2:	a1 e0 67 00 00       	mov    0x67e0,%eax
     5e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
     5ea:	eb 24                	jmp    610 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     5ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5ef:	8b 00                	mov    (%eax),%eax
     5f1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     5f4:	77 12                	ja     608 <free+0x35>
     5f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     5f9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     5fc:	77 24                	ja     622 <free+0x4f>
     5fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
     601:	8b 00                	mov    (%eax),%eax
     603:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     606:	77 1a                	ja     622 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     608:	8b 45 fc             	mov    -0x4(%ebp),%eax
     60b:	8b 00                	mov    (%eax),%eax
     60d:	89 45 fc             	mov    %eax,-0x4(%ebp)
     610:	8b 45 f8             	mov    -0x8(%ebp),%eax
     613:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     616:	76 d4                	jbe    5ec <free+0x19>
     618:	8b 45 fc             	mov    -0x4(%ebp),%eax
     61b:	8b 00                	mov    (%eax),%eax
     61d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     620:	76 ca                	jbe    5ec <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     622:	8b 45 f8             	mov    -0x8(%ebp),%eax
     625:	8b 40 04             	mov    0x4(%eax),%eax
     628:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     62f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     632:	01 c2                	add    %eax,%edx
     634:	8b 45 fc             	mov    -0x4(%ebp),%eax
     637:	8b 00                	mov    (%eax),%eax
     639:	39 c2                	cmp    %eax,%edx
     63b:	75 24                	jne    661 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     63d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     640:	8b 50 04             	mov    0x4(%eax),%edx
     643:	8b 45 fc             	mov    -0x4(%ebp),%eax
     646:	8b 00                	mov    (%eax),%eax
     648:	8b 40 04             	mov    0x4(%eax),%eax
     64b:	01 c2                	add    %eax,%edx
     64d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     650:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     653:	8b 45 fc             	mov    -0x4(%ebp),%eax
     656:	8b 00                	mov    (%eax),%eax
     658:	8b 10                	mov    (%eax),%edx
     65a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     65d:	89 10                	mov    %edx,(%eax)
     65f:	eb 0a                	jmp    66b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     661:	8b 45 fc             	mov    -0x4(%ebp),%eax
     664:	8b 10                	mov    (%eax),%edx
     666:	8b 45 f8             	mov    -0x8(%ebp),%eax
     669:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     66b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66e:	8b 40 04             	mov    0x4(%eax),%eax
     671:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     678:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67b:	01 d0                	add    %edx,%eax
     67d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     680:	75 20                	jne    6a2 <free+0xcf>
    p->s.size += bp->s.size;
     682:	8b 45 fc             	mov    -0x4(%ebp),%eax
     685:	8b 50 04             	mov    0x4(%eax),%edx
     688:	8b 45 f8             	mov    -0x8(%ebp),%eax
     68b:	8b 40 04             	mov    0x4(%eax),%eax
     68e:	01 c2                	add    %eax,%edx
     690:	8b 45 fc             	mov    -0x4(%ebp),%eax
     693:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     696:	8b 45 f8             	mov    -0x8(%ebp),%eax
     699:	8b 10                	mov    (%eax),%edx
     69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69e:	89 10                	mov    %edx,(%eax)
     6a0:	eb 08                	jmp    6aa <free+0xd7>
  } else
    p->s.ptr = bp;
     6a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a5:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6a8:	89 10                	mov    %edx,(%eax)
  freep = p;
     6aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ad:	a3 e0 67 00 00       	mov    %eax,0x67e0
}
     6b2:	90                   	nop
     6b3:	c9                   	leave  
     6b4:	c3                   	ret    

000006b5 <morecore>:

static Header*
morecore(uint nu)
{
     6b5:	55                   	push   %ebp
     6b6:	89 e5                	mov    %esp,%ebp
     6b8:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6bb:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6c2:	77 07                	ja     6cb <morecore+0x16>
    nu = 4096;
     6c4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     6cb:	8b 45 08             	mov    0x8(%ebp),%eax
     6ce:	c1 e0 03             	shl    $0x3,%eax
     6d1:	83 ec 0c             	sub    $0xc,%esp
     6d4:	50                   	push   %eax
     6d5:	e8 31 fc ff ff       	call   30b <sbrk>
     6da:	83 c4 10             	add    $0x10,%esp
     6dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     6e0:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     6e4:	75 07                	jne    6ed <morecore+0x38>
    return 0;
     6e6:	b8 00 00 00 00       	mov    $0x0,%eax
     6eb:	eb 26                	jmp    713 <morecore+0x5e>
  hp = (Header*)p;
     6ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     6f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6f6:	8b 55 08             	mov    0x8(%ebp),%edx
     6f9:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     6fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6ff:	83 c0 08             	add    $0x8,%eax
     702:	83 ec 0c             	sub    $0xc,%esp
     705:	50                   	push   %eax
     706:	e8 c8 fe ff ff       	call   5d3 <free>
     70b:	83 c4 10             	add    $0x10,%esp
  return freep;
     70e:	a1 e0 67 00 00       	mov    0x67e0,%eax
}
     713:	c9                   	leave  
     714:	c3                   	ret    

00000715 <malloc>:

void*
malloc(uint nbytes)
{
     715:	55                   	push   %ebp
     716:	89 e5                	mov    %esp,%ebp
     718:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     71b:	8b 45 08             	mov    0x8(%ebp),%eax
     71e:	83 c0 07             	add    $0x7,%eax
     721:	c1 e8 03             	shr    $0x3,%eax
     724:	83 c0 01             	add    $0x1,%eax
     727:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     72a:	a1 e0 67 00 00       	mov    0x67e0,%eax
     72f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     732:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     736:	75 23                	jne    75b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     738:	c7 45 f0 d8 67 00 00 	movl   $0x67d8,-0x10(%ebp)
     73f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     742:	a3 e0 67 00 00       	mov    %eax,0x67e0
     747:	a1 e0 67 00 00       	mov    0x67e0,%eax
     74c:	a3 d8 67 00 00       	mov    %eax,0x67d8
    base.s.size = 0;
     751:	c7 05 dc 67 00 00 00 	movl   $0x0,0x67dc
     758:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     75b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     75e:	8b 00                	mov    (%eax),%eax
     760:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     763:	8b 45 f4             	mov    -0xc(%ebp),%eax
     766:	8b 40 04             	mov    0x4(%eax),%eax
     769:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     76c:	72 4d                	jb     7bb <malloc+0xa6>
      if(p->s.size == nunits)
     76e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     771:	8b 40 04             	mov    0x4(%eax),%eax
     774:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     777:	75 0c                	jne    785 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     779:	8b 45 f4             	mov    -0xc(%ebp),%eax
     77c:	8b 10                	mov    (%eax),%edx
     77e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     781:	89 10                	mov    %edx,(%eax)
     783:	eb 26                	jmp    7ab <malloc+0x96>
      else {
        p->s.size -= nunits;
     785:	8b 45 f4             	mov    -0xc(%ebp),%eax
     788:	8b 40 04             	mov    0x4(%eax),%eax
     78b:	2b 45 ec             	sub    -0x14(%ebp),%eax
     78e:	89 c2                	mov    %eax,%edx
     790:	8b 45 f4             	mov    -0xc(%ebp),%eax
     793:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     796:	8b 45 f4             	mov    -0xc(%ebp),%eax
     799:	8b 40 04             	mov    0x4(%eax),%eax
     79c:	c1 e0 03             	shl    $0x3,%eax
     79f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a5:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7a8:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7ae:	a3 e0 67 00 00       	mov    %eax,0x67e0
      return (void*)(p + 1);
     7b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b6:	83 c0 08             	add    $0x8,%eax
     7b9:	eb 3b                	jmp    7f6 <malloc+0xe1>
    }
    if(p == freep)
     7bb:	a1 e0 67 00 00       	mov    0x67e0,%eax
     7c0:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7c3:	75 1e                	jne    7e3 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7c5:	83 ec 0c             	sub    $0xc,%esp
     7c8:	ff 75 ec             	pushl  -0x14(%ebp)
     7cb:	e8 e5 fe ff ff       	call   6b5 <morecore>
     7d0:	83 c4 10             	add    $0x10,%esp
     7d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
     7d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7da:	75 07                	jne    7e3 <malloc+0xce>
        return 0;
     7dc:	b8 00 00 00 00       	mov    $0x0,%eax
     7e1:	eb 13                	jmp    7f6 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ec:	8b 00                	mov    (%eax),%eax
     7ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     7f1:	e9 6d ff ff ff       	jmp    763 <malloc+0x4e>
}
     7f6:	c9                   	leave  
     7f7:	c3                   	ret    

000007f8 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     7f8:	55                   	push   %ebp
     7f9:	89 e5                	mov    %esp,%ebp
     7fb:	83 ec 1c             	sub    $0x1c,%esp
     7fe:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     801:	8b 55 10             	mov    0x10(%ebp),%edx
     804:	8b 45 14             	mov    0x14(%ebp),%eax
     807:	88 4d ec             	mov    %cl,-0x14(%ebp)
     80a:	88 55 e8             	mov    %dl,-0x18(%ebp)
     80d:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     810:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     814:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     817:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     81b:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     81e:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     822:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     825:	8b 45 08             	mov    0x8(%ebp),%eax
     828:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     82c:	66 89 10             	mov    %dx,(%eax)
     82f:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     833:	88 50 02             	mov    %dl,0x2(%eax)
}
     836:	8b 45 08             	mov    0x8(%ebp),%eax
     839:	c9                   	leave  
     83a:	c2 04 00             	ret    $0x4

0000083d <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     83d:	55                   	push   %ebp
     83e:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     840:	8b 45 08             	mov    0x8(%ebp),%eax
     843:	2b 45 10             	sub    0x10(%ebp),%eax
     846:	89 c2                	mov    %eax,%edx
     848:	8b 45 08             	mov    0x8(%ebp),%eax
     84b:	2b 45 10             	sub    0x10(%ebp),%eax
     84e:	0f af d0             	imul   %eax,%edx
     851:	8b 45 0c             	mov    0xc(%ebp),%eax
     854:	2b 45 14             	sub    0x14(%ebp),%eax
     857:	89 c1                	mov    %eax,%ecx
     859:	8b 45 0c             	mov    0xc(%ebp),%eax
     85c:	2b 45 14             	sub    0x14(%ebp),%eax
     85f:	0f af c1             	imul   %ecx,%eax
     862:	01 d0                	add    %edx,%eax
}
     864:	5d                   	pop    %ebp
     865:	c3                   	ret    

00000866 <abs_int>:

static inline int abs_int(int x)
{
     866:	55                   	push   %ebp
     867:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     869:	8b 45 08             	mov    0x8(%ebp),%eax
     86c:	99                   	cltd   
     86d:	89 d0                	mov    %edx,%eax
     86f:	33 45 08             	xor    0x8(%ebp),%eax
     872:	29 d0                	sub    %edx,%eax
}
     874:	5d                   	pop    %ebp
     875:	c3                   	ret    

00000876 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     876:	55                   	push   %ebp
     877:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     879:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     87d:	79 07                	jns    886 <APGetIndex+0x10>
        return X_SMALLER;
     87f:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     884:	eb 40                	jmp    8c6 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     886:	8b 45 08             	mov    0x8(%ebp),%eax
     889:	8b 00                	mov    (%eax),%eax
     88b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     88e:	7f 07                	jg     897 <APGetIndex+0x21>
        return X_BIGGER;
     890:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     895:	eb 2f                	jmp    8c6 <APGetIndex+0x50>
    if (y < 0)
     897:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     89b:	79 07                	jns    8a4 <APGetIndex+0x2e>
        return Y_SMALLER;
     89d:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8a2:	eb 22                	jmp    8c6 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8a4:	8b 45 08             	mov    0x8(%ebp),%eax
     8a7:	8b 40 04             	mov    0x4(%eax),%eax
     8aa:	3b 45 10             	cmp    0x10(%ebp),%eax
     8ad:	7f 07                	jg     8b6 <APGetIndex+0x40>
        return Y_BIGGER;
     8af:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8b4:	eb 10                	jmp    8c6 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8b6:	8b 45 08             	mov    0x8(%ebp),%eax
     8b9:	8b 00                	mov    (%eax),%eax
     8bb:	0f af 45 10          	imul   0x10(%ebp),%eax
     8bf:	89 c2                	mov    %eax,%edx
     8c1:	8b 45 0c             	mov    0xc(%ebp),%eax
     8c4:	01 d0                	add    %edx,%eax
}
     8c6:	5d                   	pop    %ebp
     8c7:	c3                   	ret    

000008c8 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     8c8:	55                   	push   %ebp
     8c9:	89 e5                	mov    %esp,%ebp
     8cb:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     8ce:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     8d5:	8b 45 cc             	mov    -0x34(%ebp),%eax
     8d8:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     8db:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     8e2:	83 ec 08             	sub    $0x8,%esp
     8e5:	6a 00                	push   $0x0
     8e7:	ff 75 0c             	pushl  0xc(%ebp)
     8ea:	e8 d4 f9 ff ff       	call   2c3 <open>
     8ef:	83 c4 10             	add    $0x10,%esp
     8f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     8f5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     8f9:	79 2e                	jns    929 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     8fb:	83 ec 04             	sub    $0x4,%esp
     8fe:	ff 75 0c             	pushl  0xc(%ebp)
     901:	68 63 24 00 00       	push   $0x2463
     906:	6a 01                	push   $0x1
     908:	e8 35 fb ff ff       	call   442 <printf>
     90d:	83 c4 10             	add    $0x10,%esp
        return bmp;
     910:	8b 45 08             	mov    0x8(%ebp),%eax
     913:	8b 55 c8             	mov    -0x38(%ebp),%edx
     916:	89 10                	mov    %edx,(%eax)
     918:	8b 55 cc             	mov    -0x34(%ebp),%edx
     91b:	89 50 04             	mov    %edx,0x4(%eax)
     91e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     921:	89 50 08             	mov    %edx,0x8(%eax)
     924:	e9 d2 01 00 00       	jmp    afb <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     929:	83 ec 04             	sub    $0x4,%esp
     92c:	6a 0e                	push   $0xe
     92e:	8d 45 ba             	lea    -0x46(%ebp),%eax
     931:	50                   	push   %eax
     932:	ff 75 ec             	pushl  -0x14(%ebp)
     935:	e8 61 f9 ff ff       	call   29b <read>
     93a:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     93d:	83 ec 04             	sub    $0x4,%esp
     940:	6a 28                	push   $0x28
     942:	8d 45 92             	lea    -0x6e(%ebp),%eax
     945:	50                   	push   %eax
     946:	ff 75 ec             	pushl  -0x14(%ebp)
     949:	e8 4d f9 ff ff       	call   29b <read>
     94e:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     951:	8b 45 96             	mov    -0x6a(%ebp),%eax
     954:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     957:	8b 45 9a             	mov    -0x66(%ebp),%eax
     95a:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     95d:	8b 55 c8             	mov    -0x38(%ebp),%edx
     960:	8b 45 cc             	mov    -0x34(%ebp),%eax
     963:	0f af d0             	imul   %eax,%edx
     966:	89 d0                	mov    %edx,%eax
     968:	01 c0                	add    %eax,%eax
     96a:	01 d0                	add    %edx,%eax
     96c:	83 ec 0c             	sub    $0xc,%esp
     96f:	50                   	push   %eax
     970:	e8 a0 fd ff ff       	call   715 <malloc>
     975:	83 c4 10             	add    $0x10,%esp
     978:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     97b:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     97f:	0f b7 c0             	movzwl %ax,%eax
     982:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     985:	8b 55 c8             	mov    -0x38(%ebp),%edx
     988:	8b 45 e8             	mov    -0x18(%ebp),%eax
     98b:	0f af c2             	imul   %edx,%eax
     98e:	83 c0 1f             	add    $0x1f,%eax
     991:	c1 e8 05             	shr    $0x5,%eax
     994:	c1 e0 02             	shl    $0x2,%eax
     997:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     99a:	8b 55 cc             	mov    -0x34(%ebp),%edx
     99d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9a0:	0f af c2             	imul   %edx,%eax
     9a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9a9:	83 ec 0c             	sub    $0xc,%esp
     9ac:	50                   	push   %eax
     9ad:	e8 63 fd ff ff       	call   715 <malloc>
     9b2:	83 c4 10             	add    $0x10,%esp
     9b5:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9b8:	83 ec 04             	sub    $0x4,%esp
     9bb:	ff 75 e0             	pushl  -0x20(%ebp)
     9be:	ff 75 dc             	pushl  -0x24(%ebp)
     9c1:	ff 75 ec             	pushl  -0x14(%ebp)
     9c4:	e8 d2 f8 ff ff       	call   29b <read>
     9c9:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     9cc:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9d0:	66 c1 e8 03          	shr    $0x3,%ax
     9d4:	0f b7 c0             	movzwl %ax,%eax
     9d7:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     9da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     9e1:	e9 e5 00 00 00       	jmp    acb <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     9e6:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9ec:	29 c2                	sub    %eax,%edx
     9ee:	89 d0                	mov    %edx,%eax
     9f0:	8d 50 ff             	lea    -0x1(%eax),%edx
     9f3:	8b 45 c8             	mov    -0x38(%ebp),%eax
     9f6:	0f af c2             	imul   %edx,%eax
     9f9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     9fc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a03:	e9 b1 00 00 00       	jmp    ab9 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a08:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a0b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a11:	01 c8                	add    %ecx,%eax
     a13:	89 c1                	mov    %eax,%ecx
     a15:	89 c8                	mov    %ecx,%eax
     a17:	01 c0                	add    %eax,%eax
     a19:	01 c8                	add    %ecx,%eax
     a1b:	01 c2                	add    %eax,%edx
     a1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a20:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a24:	89 c1                	mov    %eax,%ecx
     a26:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a29:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a2d:	01 c1                	add    %eax,%ecx
     a2f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a32:	01 c8                	add    %ecx,%eax
     a34:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a37:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a3a:	01 c8                	add    %ecx,%eax
     a3c:	0f b6 00             	movzbl (%eax),%eax
     a3f:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a42:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a45:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a48:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a4b:	01 c8                	add    %ecx,%eax
     a4d:	89 c1                	mov    %eax,%ecx
     a4f:	89 c8                	mov    %ecx,%eax
     a51:	01 c0                	add    %eax,%eax
     a53:	01 c8                	add    %ecx,%eax
     a55:	01 c2                	add    %eax,%edx
     a57:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a5a:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a5e:	89 c1                	mov    %eax,%ecx
     a60:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a63:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a67:	01 c1                	add    %eax,%ecx
     a69:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a6c:	01 c8                	add    %ecx,%eax
     a6e:	8d 48 fe             	lea    -0x2(%eax),%ecx
     a71:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a74:	01 c8                	add    %ecx,%eax
     a76:	0f b6 00             	movzbl (%eax),%eax
     a79:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     a7c:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a7f:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a82:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a85:	01 c8                	add    %ecx,%eax
     a87:	89 c1                	mov    %eax,%ecx
     a89:	89 c8                	mov    %ecx,%eax
     a8b:	01 c0                	add    %eax,%eax
     a8d:	01 c8                	add    %ecx,%eax
     a8f:	01 c2                	add    %eax,%edx
     a91:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a94:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a98:	89 c1                	mov    %eax,%ecx
     a9a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a9d:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     aa1:	01 c1                	add    %eax,%ecx
     aa3:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aa6:	01 c8                	add    %ecx,%eax
     aa8:	8d 48 fd             	lea    -0x3(%eax),%ecx
     aab:	8b 45 dc             	mov    -0x24(%ebp),%eax
     aae:	01 c8                	add    %ecx,%eax
     ab0:	0f b6 00             	movzbl (%eax),%eax
     ab3:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     ab5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ab9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     abc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     abf:	39 c2                	cmp    %eax,%edx
     ac1:	0f 87 41 ff ff ff    	ja     a08 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     ac7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     acb:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ace:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad1:	39 c2                	cmp    %eax,%edx
     ad3:	0f 87 0d ff ff ff    	ja     9e6 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     ad9:	83 ec 0c             	sub    $0xc,%esp
     adc:	ff 75 ec             	pushl  -0x14(%ebp)
     adf:	e8 c7 f7 ff ff       	call   2ab <close>
     ae4:	83 c4 10             	add    $0x10,%esp
    return bmp;
     ae7:	8b 45 08             	mov    0x8(%ebp),%eax
     aea:	8b 55 c8             	mov    -0x38(%ebp),%edx
     aed:	89 10                	mov    %edx,(%eax)
     aef:	8b 55 cc             	mov    -0x34(%ebp),%edx
     af2:	89 50 04             	mov    %edx,0x4(%eax)
     af5:	8b 55 d0             	mov    -0x30(%ebp),%edx
     af8:	89 50 08             	mov    %edx,0x8(%eax)
}
     afb:	8b 45 08             	mov    0x8(%ebp),%eax
     afe:	c9                   	leave  
     aff:	c2 04 00             	ret    $0x4

00000b02 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b02:	55                   	push   %ebp
     b03:	89 e5                	mov    %esp,%ebp
     b05:	53                   	push   %ebx
     b06:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b09:	83 ec 0c             	sub    $0xc,%esp
     b0c:	6a 1c                	push   $0x1c
     b0e:	e8 02 fc ff ff       	call   715 <malloc>
     b13:	83 c4 10             	add    $0x10,%esp
     b16:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b19:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b1c:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b23:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b26:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b29:	6a 0c                	push   $0xc
     b2b:	6a 0c                	push   $0xc
     b2d:	6a 0c                	push   $0xc
     b2f:	50                   	push   %eax
     b30:	e8 c3 fc ff ff       	call   7f8 <RGB>
     b35:	83 c4 0c             	add    $0xc,%esp
     b38:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b3c:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b40:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b44:	88 43 15             	mov    %al,0x15(%ebx)
     b47:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b4a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b4d:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b51:	66 89 48 10          	mov    %cx,0x10(%eax)
     b55:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b59:	88 50 12             	mov    %dl,0x12(%eax)
     b5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b5f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b62:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     b66:	66 89 48 08          	mov    %cx,0x8(%eax)
     b6a:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     b6e:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     b71:	8b 45 08             	mov    0x8(%ebp),%eax
     b74:	89 c2                	mov    %eax,%edx
     b76:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b79:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     b7b:	8b 45 0c             	mov    0xc(%ebp),%eax
     b7e:	89 c2                	mov    %eax,%edx
     b80:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b83:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     b86:	8b 55 10             	mov    0x10(%ebp),%edx
     b89:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b8c:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     b8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     b92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b95:	c9                   	leave  
     b96:	c3                   	ret    

00000b97 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     b97:	55                   	push   %ebp
     b98:	89 e5                	mov    %esp,%ebp
     b9a:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     b9d:	8b 45 0c             	mov    0xc(%ebp),%eax
     ba0:	8b 50 08             	mov    0x8(%eax),%edx
     ba3:	89 55 f8             	mov    %edx,-0x8(%ebp)
     ba6:	8b 40 0c             	mov    0xc(%eax),%eax
     ba9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     bac:	8b 45 0c             	mov    0xc(%ebp),%eax
     baf:	8b 55 10             	mov    0x10(%ebp),%edx
     bb2:	89 50 08             	mov    %edx,0x8(%eax)
     bb5:	8b 55 14             	mov    0x14(%ebp),%edx
     bb8:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     bbb:	8b 45 08             	mov    0x8(%ebp),%eax
     bbe:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bc1:	89 10                	mov    %edx,(%eax)
     bc3:	8b 55 fc             	mov    -0x4(%ebp),%edx
     bc6:	89 50 04             	mov    %edx,0x4(%eax)
}
     bc9:	8b 45 08             	mov    0x8(%ebp),%eax
     bcc:	c9                   	leave  
     bcd:	c2 04 00             	ret    $0x4

00000bd0 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     bd6:	8b 45 0c             	mov    0xc(%ebp),%eax
     bd9:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     bdd:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     be1:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     be5:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     be8:	8b 45 0c             	mov    0xc(%ebp),%eax
     beb:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     bef:	66 89 50 10          	mov    %dx,0x10(%eax)
     bf3:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     bf7:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     bfa:	8b 45 08             	mov    0x8(%ebp),%eax
     bfd:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c01:	66 89 10             	mov    %dx,(%eax)
     c04:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c08:	88 50 02             	mov    %dl,0x2(%eax)
}
     c0b:	8b 45 08             	mov    0x8(%ebp),%eax
     c0e:	c9                   	leave  
     c0f:	c2 04 00             	ret    $0x4

00000c12 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     c12:	55                   	push   %ebp
     c13:	89 e5                	mov    %esp,%ebp
     c15:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     c18:	8b 45 0c             	mov    0xc(%ebp),%eax
     c1b:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     c1f:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c23:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     c27:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     c2a:	8b 45 0c             	mov    0xc(%ebp),%eax
     c2d:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c31:	66 89 50 13          	mov    %dx,0x13(%eax)
     c35:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c39:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     c3c:	8b 45 08             	mov    0x8(%ebp),%eax
     c3f:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c43:	66 89 10             	mov    %dx,(%eax)
     c46:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c4a:	88 50 02             	mov    %dl,0x2(%eax)
}
     c4d:	8b 45 08             	mov    0x8(%ebp),%eax
     c50:	c9                   	leave  
     c51:	c2 04 00             	ret    $0x4

00000c54 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c54:	55                   	push   %ebp
     c55:	89 e5                	mov    %esp,%ebp
     c57:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c5a:	8b 45 08             	mov    0x8(%ebp),%eax
     c5d:	8b 40 0c             	mov    0xc(%eax),%eax
     c60:	89 c2                	mov    %eax,%edx
     c62:	c1 ea 1f             	shr    $0x1f,%edx
     c65:	01 d0                	add    %edx,%eax
     c67:	d1 f8                	sar    %eax
     c69:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c6f:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c73:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c76:	8b 45 10             	mov    0x10(%ebp),%eax
     c79:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c7f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c83:	0f 89 98 00 00 00    	jns    d21 <APDrawPoint+0xcd>
        i = 0;
     c89:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c90:	e9 8c 00 00 00       	jmp    d21 <APDrawPoint+0xcd>
    {
        j = x - off;
     c95:	8b 45 0c             	mov    0xc(%ebp),%eax
     c98:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c9b:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     c9e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     ca2:	79 69                	jns    d0d <APDrawPoint+0xb9>
            j = 0;
     ca4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     cab:	eb 60                	jmp    d0d <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     cad:	ff 75 fc             	pushl  -0x4(%ebp)
     cb0:	ff 75 f8             	pushl  -0x8(%ebp)
     cb3:	ff 75 08             	pushl  0x8(%ebp)
     cb6:	e8 bb fb ff ff       	call   876 <APGetIndex>
     cbb:	83 c4 0c             	add    $0xc,%esp
     cbe:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     cc1:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cc5:	74 55                	je     d1c <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cc7:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     ccb:	74 67                	je     d34 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     ccd:	ff 75 10             	pushl  0x10(%ebp)
     cd0:	ff 75 0c             	pushl  0xc(%ebp)
     cd3:	ff 75 fc             	pushl  -0x4(%ebp)
     cd6:	ff 75 f8             	pushl  -0x8(%ebp)
     cd9:	e8 5f fb ff ff       	call   83d <distance_2>
     cde:	83 c4 10             	add    $0x10,%esp
     ce1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     ce4:	7f 23                	jg     d09 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     ce6:	8b 45 08             	mov    0x8(%ebp),%eax
     ce9:	8b 48 18             	mov    0x18(%eax),%ecx
     cec:	8b 55 ec             	mov    -0x14(%ebp),%edx
     cef:	89 d0                	mov    %edx,%eax
     cf1:	01 c0                	add    %eax,%eax
     cf3:	01 d0                	add    %edx,%eax
     cf5:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     cf8:	8b 45 08             	mov    0x8(%ebp),%eax
     cfb:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     cff:	66 89 0a             	mov    %cx,(%edx)
     d02:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d06:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d09:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d0d:	8b 55 0c             	mov    0xc(%ebp),%edx
     d10:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d13:	01 d0                	add    %edx,%eax
     d15:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d18:	7d 93                	jge    cad <APDrawPoint+0x59>
     d1a:	eb 01                	jmp    d1d <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d1c:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d1d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d21:	8b 55 10             	mov    0x10(%ebp),%edx
     d24:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d27:	01 d0                	add    %edx,%eax
     d29:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d2c:	0f 8d 63 ff ff ff    	jge    c95 <APDrawPoint+0x41>
     d32:	eb 01                	jmp    d35 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d34:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d35:	c9                   	leave  
     d36:	c3                   	ret    

00000d37 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d37:	55                   	push   %ebp
     d38:	89 e5                	mov    %esp,%ebp
     d3a:	53                   	push   %ebx
     d3b:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d3e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d41:	3b 45 14             	cmp    0x14(%ebp),%eax
     d44:	0f 85 80 00 00 00    	jne    dca <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d4a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d4e:	0f 88 9d 02 00 00    	js     ff1 <APDrawLine+0x2ba>
     d54:	8b 45 08             	mov    0x8(%ebp),%eax
     d57:	8b 00                	mov    (%eax),%eax
     d59:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d5c:	0f 8e 8f 02 00 00    	jle    ff1 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d62:	8b 45 10             	mov    0x10(%ebp),%eax
     d65:	3b 45 18             	cmp    0x18(%ebp),%eax
     d68:	7e 12                	jle    d7c <APDrawLine+0x45>
        {
            int tmp = y2;
     d6a:	8b 45 18             	mov    0x18(%ebp),%eax
     d6d:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d70:	8b 45 10             	mov    0x10(%ebp),%eax
     d73:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d76:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d79:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d7c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d80:	79 07                	jns    d89 <APDrawLine+0x52>
     d82:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d89:	8b 45 08             	mov    0x8(%ebp),%eax
     d8c:	8b 40 04             	mov    0x4(%eax),%eax
     d8f:	3b 45 18             	cmp    0x18(%ebp),%eax
     d92:	7d 0c                	jge    da0 <APDrawLine+0x69>
     d94:	8b 45 08             	mov    0x8(%ebp),%eax
     d97:	8b 40 04             	mov    0x4(%eax),%eax
     d9a:	83 e8 01             	sub    $0x1,%eax
     d9d:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     da0:	8b 45 10             	mov    0x10(%ebp),%eax
     da3:	89 45 f4             	mov    %eax,-0xc(%ebp)
     da6:	eb 15                	jmp    dbd <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     da8:	ff 75 f4             	pushl  -0xc(%ebp)
     dab:	ff 75 0c             	pushl  0xc(%ebp)
     dae:	ff 75 08             	pushl  0x8(%ebp)
     db1:	e8 9e fe ff ff       	call   c54 <APDrawPoint>
     db6:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     db9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     dbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dc0:	3b 45 18             	cmp    0x18(%ebp),%eax
     dc3:	7e e3                	jle    da8 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     dc5:	e9 2b 02 00 00       	jmp    ff5 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     dca:	8b 45 10             	mov    0x10(%ebp),%eax
     dcd:	3b 45 18             	cmp    0x18(%ebp),%eax
     dd0:	75 7f                	jne    e51 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     dd2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dd6:	0f 88 18 02 00 00    	js     ff4 <APDrawLine+0x2bd>
     ddc:	8b 45 08             	mov    0x8(%ebp),%eax
     ddf:	8b 40 04             	mov    0x4(%eax),%eax
     de2:	3b 45 10             	cmp    0x10(%ebp),%eax
     de5:	0f 8e 09 02 00 00    	jle    ff4 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     deb:	8b 45 0c             	mov    0xc(%ebp),%eax
     dee:	3b 45 14             	cmp    0x14(%ebp),%eax
     df1:	7e 12                	jle    e05 <APDrawLine+0xce>
        {
            int tmp = x2;
     df3:	8b 45 14             	mov    0x14(%ebp),%eax
     df6:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     df9:	8b 45 0c             	mov    0xc(%ebp),%eax
     dfc:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     dff:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e02:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e05:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e09:	79 07                	jns    e12 <APDrawLine+0xdb>
     e0b:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e12:	8b 45 08             	mov    0x8(%ebp),%eax
     e15:	8b 00                	mov    (%eax),%eax
     e17:	3b 45 14             	cmp    0x14(%ebp),%eax
     e1a:	7d 0b                	jge    e27 <APDrawLine+0xf0>
     e1c:	8b 45 08             	mov    0x8(%ebp),%eax
     e1f:	8b 00                	mov    (%eax),%eax
     e21:	83 e8 01             	sub    $0x1,%eax
     e24:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e27:	8b 45 0c             	mov    0xc(%ebp),%eax
     e2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e2d:	eb 15                	jmp    e44 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e2f:	ff 75 10             	pushl  0x10(%ebp)
     e32:	ff 75 f0             	pushl  -0x10(%ebp)
     e35:	ff 75 08             	pushl  0x8(%ebp)
     e38:	e8 17 fe ff ff       	call   c54 <APDrawPoint>
     e3d:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e40:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e44:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e47:	3b 45 14             	cmp    0x14(%ebp),%eax
     e4a:	7e e3                	jle    e2f <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e4c:	e9 a4 01 00 00       	jmp    ff5 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e51:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e58:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e5f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e62:	2b 45 14             	sub    0x14(%ebp),%eax
     e65:	50                   	push   %eax
     e66:	e8 fb f9 ff ff       	call   866 <abs_int>
     e6b:	83 c4 04             	add    $0x4,%esp
     e6e:	89 c3                	mov    %eax,%ebx
     e70:	8b 45 10             	mov    0x10(%ebp),%eax
     e73:	2b 45 18             	sub    0x18(%ebp),%eax
     e76:	50                   	push   %eax
     e77:	e8 ea f9 ff ff       	call   866 <abs_int>
     e7c:	83 c4 04             	add    $0x4,%esp
     e7f:	39 c3                	cmp    %eax,%ebx
     e81:	0f 8e b5 00 00 00    	jle    f3c <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e87:	8b 45 10             	mov    0x10(%ebp),%eax
     e8a:	2b 45 18             	sub    0x18(%ebp),%eax
     e8d:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e90:	db 45 b0             	fildl  -0x50(%ebp)
     e93:	8b 45 0c             	mov    0xc(%ebp),%eax
     e96:	2b 45 14             	sub    0x14(%ebp),%eax
     e99:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e9c:	db 45 b0             	fildl  -0x50(%ebp)
     e9f:	de f9                	fdivrp %st,%st(1)
     ea1:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     ea4:	8b 45 14             	mov    0x14(%ebp),%eax
     ea7:	3b 45 0c             	cmp    0xc(%ebp),%eax
     eaa:	7e 0e                	jle    eba <APDrawLine+0x183>
        {
            s = x1;
     eac:	8b 45 0c             	mov    0xc(%ebp),%eax
     eaf:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     eb2:	8b 45 14             	mov    0x14(%ebp),%eax
     eb5:	89 45 e8             	mov    %eax,-0x18(%ebp)
     eb8:	eb 0c                	jmp    ec6 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     eba:	8b 45 14             	mov    0x14(%ebp),%eax
     ebd:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     ec0:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec3:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     ec6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     eca:	79 07                	jns    ed3 <APDrawLine+0x19c>
     ecc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     ed3:	8b 45 08             	mov    0x8(%ebp),%eax
     ed6:	8b 00                	mov    (%eax),%eax
     ed8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     edb:	7f 0b                	jg     ee8 <APDrawLine+0x1b1>
     edd:	8b 45 08             	mov    0x8(%ebp),%eax
     ee0:	8b 00                	mov    (%eax),%eax
     ee2:	83 e8 01             	sub    $0x1,%eax
     ee5:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     ee8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     eeb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     eee:	eb 3f                	jmp    f2f <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     ef0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ef3:	2b 45 0c             	sub    0xc(%ebp),%eax
     ef6:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ef9:	db 45 b0             	fildl  -0x50(%ebp)
     efc:	dc 4d d0             	fmull  -0x30(%ebp)
     eff:	db 45 10             	fildl  0x10(%ebp)
     f02:	de c1                	faddp  %st,%st(1)
     f04:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f07:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f0b:	b4 0c                	mov    $0xc,%ah
     f0d:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f11:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f14:	db 5d cc             	fistpl -0x34(%ebp)
     f17:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f1a:	ff 75 cc             	pushl  -0x34(%ebp)
     f1d:	ff 75 e4             	pushl  -0x1c(%ebp)
     f20:	ff 75 08             	pushl  0x8(%ebp)
     f23:	e8 2c fd ff ff       	call   c54 <APDrawPoint>
     f28:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f2b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f2f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f32:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f35:	7e b9                	jle    ef0 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f37:	e9 b9 00 00 00       	jmp    ff5 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f3c:	8b 45 0c             	mov    0xc(%ebp),%eax
     f3f:	2b 45 14             	sub    0x14(%ebp),%eax
     f42:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f45:	db 45 b0             	fildl  -0x50(%ebp)
     f48:	8b 45 10             	mov    0x10(%ebp),%eax
     f4b:	2b 45 18             	sub    0x18(%ebp),%eax
     f4e:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f51:	db 45 b0             	fildl  -0x50(%ebp)
     f54:	de f9                	fdivrp %st,%st(1)
     f56:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f59:	8b 45 10             	mov    0x10(%ebp),%eax
     f5c:	3b 45 18             	cmp    0x18(%ebp),%eax
     f5f:	7e 0e                	jle    f6f <APDrawLine+0x238>
    {
        s = y2;
     f61:	8b 45 18             	mov    0x18(%ebp),%eax
     f64:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f67:	8b 45 10             	mov    0x10(%ebp),%eax
     f6a:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f6d:	eb 0c                	jmp    f7b <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f6f:	8b 45 10             	mov    0x10(%ebp),%eax
     f72:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f75:	8b 45 18             	mov    0x18(%ebp),%eax
     f78:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f7b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f7f:	79 07                	jns    f88 <APDrawLine+0x251>
     f81:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f88:	8b 45 08             	mov    0x8(%ebp),%eax
     f8b:	8b 40 04             	mov    0x4(%eax),%eax
     f8e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f91:	7f 0c                	jg     f9f <APDrawLine+0x268>
     f93:	8b 45 08             	mov    0x8(%ebp),%eax
     f96:	8b 40 04             	mov    0x4(%eax),%eax
     f99:	83 e8 01             	sub    $0x1,%eax
     f9c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     f9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fa2:	89 45 e0             	mov    %eax,-0x20(%ebp)
     fa5:	eb 3f                	jmp    fe6 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     fa7:	8b 45 e0             	mov    -0x20(%ebp),%eax
     faa:	2b 45 10             	sub    0x10(%ebp),%eax
     fad:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fb0:	db 45 b0             	fildl  -0x50(%ebp)
     fb3:	dc 4d c0             	fmull  -0x40(%ebp)
     fb6:	db 45 0c             	fildl  0xc(%ebp)
     fb9:	de c1                	faddp  %st,%st(1)
     fbb:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fbe:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fc2:	b4 0c                	mov    $0xc,%ah
     fc4:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fc8:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fcb:	db 5d bc             	fistpl -0x44(%ebp)
     fce:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     fd1:	ff 75 e0             	pushl  -0x20(%ebp)
     fd4:	ff 75 bc             	pushl  -0x44(%ebp)
     fd7:	ff 75 08             	pushl  0x8(%ebp)
     fda:	e8 75 fc ff ff       	call   c54 <APDrawPoint>
     fdf:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     fe2:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     fe6:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fe9:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fec:	7e b9                	jle    fa7 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     fee:	90                   	nop
     fef:	eb 04                	jmp    ff5 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     ff1:	90                   	nop
     ff2:	eb 01                	jmp    ff5 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     ff4:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     ff5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ff8:	c9                   	leave  
     ff9:	c3                   	ret    

00000ffa <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     ffa:	55                   	push   %ebp
     ffb:	89 e5                	mov    %esp,%ebp
     ffd:	53                   	push   %ebx
     ffe:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1001:	8b 55 10             	mov    0x10(%ebp),%edx
    1004:	8b 45 18             	mov    0x18(%ebp),%eax
    1007:	01 d0                	add    %edx,%eax
    1009:	83 e8 01             	sub    $0x1,%eax
    100c:	83 ec 04             	sub    $0x4,%esp
    100f:	50                   	push   %eax
    1010:	ff 75 0c             	pushl  0xc(%ebp)
    1013:	ff 75 10             	pushl  0x10(%ebp)
    1016:	ff 75 0c             	pushl  0xc(%ebp)
    1019:	ff 75 08             	pushl  0x8(%ebp)
    101c:	e8 16 fd ff ff       	call   d37 <APDrawLine>
    1021:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1024:	8b 55 0c             	mov    0xc(%ebp),%edx
    1027:	8b 45 14             	mov    0x14(%ebp),%eax
    102a:	01 d0                	add    %edx,%eax
    102c:	83 e8 01             	sub    $0x1,%eax
    102f:	83 ec 04             	sub    $0x4,%esp
    1032:	ff 75 10             	pushl  0x10(%ebp)
    1035:	50                   	push   %eax
    1036:	ff 75 10             	pushl  0x10(%ebp)
    1039:	ff 75 0c             	pushl  0xc(%ebp)
    103c:	ff 75 08             	pushl  0x8(%ebp)
    103f:	e8 f3 fc ff ff       	call   d37 <APDrawLine>
    1044:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1047:	8b 55 10             	mov    0x10(%ebp),%edx
    104a:	8b 45 18             	mov    0x18(%ebp),%eax
    104d:	01 d0                	add    %edx,%eax
    104f:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1052:	8b 55 0c             	mov    0xc(%ebp),%edx
    1055:	8b 45 14             	mov    0x14(%ebp),%eax
    1058:	01 d0                	add    %edx,%eax
    105a:	8d 50 ff             	lea    -0x1(%eax),%edx
    105d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1060:	8b 45 14             	mov    0x14(%ebp),%eax
    1063:	01 d8                	add    %ebx,%eax
    1065:	83 e8 01             	sub    $0x1,%eax
    1068:	83 ec 04             	sub    $0x4,%esp
    106b:	51                   	push   %ecx
    106c:	52                   	push   %edx
    106d:	ff 75 10             	pushl  0x10(%ebp)
    1070:	50                   	push   %eax
    1071:	ff 75 08             	pushl  0x8(%ebp)
    1074:	e8 be fc ff ff       	call   d37 <APDrawLine>
    1079:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    107c:	8b 55 10             	mov    0x10(%ebp),%edx
    107f:	8b 45 18             	mov    0x18(%ebp),%eax
    1082:	01 d0                	add    %edx,%eax
    1084:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1087:	8b 55 0c             	mov    0xc(%ebp),%edx
    108a:	8b 45 14             	mov    0x14(%ebp),%eax
    108d:	01 d0                	add    %edx,%eax
    108f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1092:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1095:	8b 45 18             	mov    0x18(%ebp),%eax
    1098:	01 d8                	add    %ebx,%eax
    109a:	83 e8 01             	sub    $0x1,%eax
    109d:	83 ec 04             	sub    $0x4,%esp
    10a0:	51                   	push   %ecx
    10a1:	52                   	push   %edx
    10a2:	50                   	push   %eax
    10a3:	ff 75 0c             	pushl  0xc(%ebp)
    10a6:	ff 75 08             	pushl  0x8(%ebp)
    10a9:	e8 89 fc ff ff       	call   d37 <APDrawLine>
    10ae:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10b1:	8b 55 0c             	mov    0xc(%ebp),%edx
    10b4:	8b 45 14             	mov    0x14(%ebp),%eax
    10b7:	01 d0                	add    %edx,%eax
    10b9:	8d 50 ff             	lea    -0x1(%eax),%edx
    10bc:	8b 45 08             	mov    0x8(%ebp),%eax
    10bf:	8b 40 0c             	mov    0xc(%eax),%eax
    10c2:	89 c1                	mov    %eax,%ecx
    10c4:	c1 e9 1f             	shr    $0x1f,%ecx
    10c7:	01 c8                	add    %ecx,%eax
    10c9:	d1 f8                	sar    %eax
    10cb:	29 c2                	sub    %eax,%edx
    10cd:	89 d0                	mov    %edx,%eax
    10cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10d2:	8b 55 10             	mov    0x10(%ebp),%edx
    10d5:	8b 45 18             	mov    0x18(%ebp),%eax
    10d8:	01 d0                	add    %edx,%eax
    10da:	8d 50 ff             	lea    -0x1(%eax),%edx
    10dd:	8b 45 08             	mov    0x8(%ebp),%eax
    10e0:	8b 40 0c             	mov    0xc(%eax),%eax
    10e3:	89 c1                	mov    %eax,%ecx
    10e5:	c1 e9 1f             	shr    $0x1f,%ecx
    10e8:	01 c8                	add    %ecx,%eax
    10ea:	d1 f8                	sar    %eax
    10ec:	29 c2                	sub    %eax,%edx
    10ee:	89 d0                	mov    %edx,%eax
    10f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    10f3:	8b 45 08             	mov    0x8(%ebp),%eax
    10f6:	8b 40 0c             	mov    0xc(%eax),%eax
    10f9:	89 c2                	mov    %eax,%edx
    10fb:	c1 ea 1f             	shr    $0x1f,%edx
    10fe:	01 d0                	add    %edx,%eax
    1100:	d1 f8                	sar    %eax
    1102:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1105:	8b 45 08             	mov    0x8(%ebp),%eax
    1108:	8b 40 0c             	mov    0xc(%eax),%eax
    110b:	89 c2                	mov    %eax,%edx
    110d:	c1 ea 1f             	shr    $0x1f,%edx
    1110:	01 d0                	add    %edx,%eax
    1112:	d1 f8                	sar    %eax
    1114:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1117:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    111b:	0f 88 d8 00 00 00    	js     11f9 <APDrawRect+0x1ff>
    1121:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1125:	0f 88 ce 00 00 00    	js     11f9 <APDrawRect+0x1ff>
    112b:	8b 45 08             	mov    0x8(%ebp),%eax
    112e:	8b 00                	mov    (%eax),%eax
    1130:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1133:	0f 8e c0 00 00 00    	jle    11f9 <APDrawRect+0x1ff>
    1139:	8b 45 08             	mov    0x8(%ebp),%eax
    113c:	8b 40 04             	mov    0x4(%eax),%eax
    113f:	3b 45 10             	cmp    0x10(%ebp),%eax
    1142:	0f 8e b1 00 00 00    	jle    11f9 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1148:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    114c:	79 07                	jns    1155 <APDrawRect+0x15b>
    114e:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1155:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1159:	79 07                	jns    1162 <APDrawRect+0x168>
    115b:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1162:	8b 45 08             	mov    0x8(%ebp),%eax
    1165:	8b 00                	mov    (%eax),%eax
    1167:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    116a:	7f 0b                	jg     1177 <APDrawRect+0x17d>
    116c:	8b 45 08             	mov    0x8(%ebp),%eax
    116f:	8b 00                	mov    (%eax),%eax
    1171:	83 e8 01             	sub    $0x1,%eax
    1174:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1177:	8b 45 08             	mov    0x8(%ebp),%eax
    117a:	8b 40 04             	mov    0x4(%eax),%eax
    117d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1180:	7f 0c                	jg     118e <APDrawRect+0x194>
    1182:	8b 45 08             	mov    0x8(%ebp),%eax
    1185:	8b 40 04             	mov    0x4(%eax),%eax
    1188:	83 e8 01             	sub    $0x1,%eax
    118b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    118e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1195:	8b 45 0c             	mov    0xc(%ebp),%eax
    1198:	89 45 ec             	mov    %eax,-0x14(%ebp)
    119b:	eb 52                	jmp    11ef <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    119d:	8b 45 10             	mov    0x10(%ebp),%eax
    11a0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11a3:	eb 3e                	jmp    11e3 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    11a5:	83 ec 04             	sub    $0x4,%esp
    11a8:	ff 75 e8             	pushl  -0x18(%ebp)
    11ab:	ff 75 ec             	pushl  -0x14(%ebp)
    11ae:	ff 75 08             	pushl  0x8(%ebp)
    11b1:	e8 c0 f6 ff ff       	call   876 <APGetIndex>
    11b6:	83 c4 10             	add    $0x10,%esp
    11b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11bc:	8b 45 08             	mov    0x8(%ebp),%eax
    11bf:	8b 48 18             	mov    0x18(%eax),%ecx
    11c2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11c5:	89 d0                	mov    %edx,%eax
    11c7:	01 c0                	add    %eax,%eax
    11c9:	01 d0                	add    %edx,%eax
    11cb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11ce:	8b 45 08             	mov    0x8(%ebp),%eax
    11d1:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11d5:	66 89 0a             	mov    %cx,(%edx)
    11d8:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    11dc:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    11df:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11e6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11e9:	7e ba                	jle    11a5 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11eb:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    11ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11f2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11f5:	7e a6                	jle    119d <APDrawRect+0x1a3>
    11f7:	eb 01                	jmp    11fa <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    11f9:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    11fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11fd:	c9                   	leave  
    11fe:	c3                   	ret    

000011ff <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    11ff:	55                   	push   %ebp
    1200:	89 e5                	mov    %esp,%ebp
    1202:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    1205:	83 ec 0c             	sub    $0xc,%esp
    1208:	ff 75 0c             	pushl  0xc(%ebp)
    120b:	e8 b1 ee ff ff       	call   c1 <strlen>
    1210:	83 c4 10             	add    $0x10,%esp
    1213:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1216:	8b 45 08             	mov    0x8(%ebp),%eax
    1219:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    121d:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1221:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1225:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1228:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    122f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1236:	e9 bc 00 00 00       	jmp    12f7 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    123b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    123e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1241:	01 d0                	add    %edx,%eax
    1243:	0f b6 00             	movzbl (%eax),%eax
    1246:	0f be c0             	movsbl %al,%eax
    1249:	83 e8 20             	sub    $0x20,%eax
    124c:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    124f:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1253:	0f 87 9a 00 00 00    	ja     12f3 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1259:	8b 45 08             	mov    0x8(%ebp),%eax
    125c:	8b 00                	mov    (%eax),%eax
    125e:	0f af 45 14          	imul   0x14(%ebp),%eax
    1262:	89 c2                	mov    %eax,%edx
    1264:	8b 45 10             	mov    0x10(%ebp),%eax
    1267:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    126a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    126d:	89 d0                	mov    %edx,%eax
    126f:	c1 e0 03             	shl    $0x3,%eax
    1272:	01 d0                	add    %edx,%eax
    1274:	01 c8                	add    %ecx,%eax
    1276:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1279:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1280:	eb 6b                	jmp    12ed <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1282:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1289:	eb 50                	jmp    12db <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    128b:	8b 55 ec             	mov    -0x14(%ebp),%edx
    128e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1291:	89 d0                	mov    %edx,%eax
    1293:	c1 e0 03             	shl    $0x3,%eax
    1296:	01 d0                	add    %edx,%eax
    1298:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    129e:	01 c2                	add    %eax,%edx
    12a0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12a3:	01 d0                	add    %edx,%eax
    12a5:	05 a0 2b 00 00       	add    $0x2ba0,%eax
    12aa:	0f b6 00             	movzbl (%eax),%eax
    12ad:	84 c0                	test   %al,%al
    12af:	74 26                	je     12d7 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    12b1:	8b 45 08             	mov    0x8(%ebp),%eax
    12b4:	8b 50 18             	mov    0x18(%eax),%edx
    12b7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    12ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12bd:	01 c8                	add    %ecx,%eax
    12bf:	89 c1                	mov    %eax,%ecx
    12c1:	89 c8                	mov    %ecx,%eax
    12c3:	01 c0                	add    %eax,%eax
    12c5:	01 c8                	add    %ecx,%eax
    12c7:	01 d0                	add    %edx,%eax
    12c9:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    12cd:	66 89 10             	mov    %dx,(%eax)
    12d0:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    12d4:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    12d7:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12db:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    12df:	7e aa                	jle    128b <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    12e1:	8b 45 08             	mov    0x8(%ebp),%eax
    12e4:	8b 00                	mov    (%eax),%eax
    12e6:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    12e9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    12ed:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    12f1:	7e 8f                	jle    1282 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    12f3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    12f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12fa:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    12fd:	0f 82 38 ff ff ff    	jb     123b <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1303:	90                   	nop
    1304:	c9                   	leave  
    1305:	c3                   	ret    

00001306 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1306:	55                   	push   %ebp
    1307:	89 e5                	mov    %esp,%ebp
    1309:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    130c:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1310:	0f 88 8e 01 00 00    	js     14a4 <APDcCopy+0x19e>
    1316:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    131a:	0f 88 84 01 00 00    	js     14a4 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1320:	8b 55 0c             	mov    0xc(%ebp),%edx
    1323:	8b 45 20             	mov    0x20(%ebp),%eax
    1326:	01 d0                	add    %edx,%eax
    1328:	89 45 fc             	mov    %eax,-0x4(%ebp)
    132b:	8b 55 10             	mov    0x10(%ebp),%edx
    132e:	8b 45 24             	mov    0x24(%ebp),%eax
    1331:	01 d0                	add    %edx,%eax
    1333:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1336:	8b 55 18             	mov    0x18(%ebp),%edx
    1339:	8b 45 20             	mov    0x20(%ebp),%eax
    133c:	01 d0                	add    %edx,%eax
    133e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1341:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1344:	8b 45 24             	mov    0x24(%ebp),%eax
    1347:	01 d0                	add    %edx,%eax
    1349:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    134c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1350:	0f 88 51 01 00 00    	js     14a7 <APDcCopy+0x1a1>
    1356:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    135a:	0f 88 47 01 00 00    	js     14a7 <APDcCopy+0x1a1>
    1360:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1364:	0f 88 3d 01 00 00    	js     14a7 <APDcCopy+0x1a1>
    136a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    136e:	0f 88 33 01 00 00    	js     14a7 <APDcCopy+0x1a1>
    1374:	8b 45 14             	mov    0x14(%ebp),%eax
    1377:	8b 00                	mov    (%eax),%eax
    1379:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    137c:	0f 8c 25 01 00 00    	jl     14a7 <APDcCopy+0x1a1>
    1382:	8b 45 14             	mov    0x14(%ebp),%eax
    1385:	8b 40 04             	mov    0x4(%eax),%eax
    1388:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    138b:	0f 8c 16 01 00 00    	jl     14a7 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1391:	8b 45 08             	mov    0x8(%ebp),%eax
    1394:	8b 00                	mov    (%eax),%eax
    1396:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1399:	7f 0b                	jg     13a6 <APDcCopy+0xa0>
    139b:	8b 45 08             	mov    0x8(%ebp),%eax
    139e:	8b 00                	mov    (%eax),%eax
    13a0:	83 e8 01             	sub    $0x1,%eax
    13a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    13a6:	8b 45 08             	mov    0x8(%ebp),%eax
    13a9:	8b 40 04             	mov    0x4(%eax),%eax
    13ac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13af:	7f 0c                	jg     13bd <APDcCopy+0xb7>
    13b1:	8b 45 08             	mov    0x8(%ebp),%eax
    13b4:	8b 40 04             	mov    0x4(%eax),%eax
    13b7:	83 e8 01             	sub    $0x1,%eax
    13ba:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    13bd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    13c4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    13cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13d2:	e9 bc 00 00 00       	jmp    1493 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    13d7:	8b 45 08             	mov    0x8(%ebp),%eax
    13da:	8b 00                	mov    (%eax),%eax
    13dc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13df:	8b 55 10             	mov    0x10(%ebp),%edx
    13e2:	01 ca                	add    %ecx,%edx
    13e4:	0f af d0             	imul   %eax,%edx
    13e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ea:	01 d0                	add    %edx,%eax
    13ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    13ef:	8b 45 14             	mov    0x14(%ebp),%eax
    13f2:	8b 00                	mov    (%eax),%eax
    13f4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13f7:	8b 55 1c             	mov    0x1c(%ebp),%edx
    13fa:	01 ca                	add    %ecx,%edx
    13fc:	0f af d0             	imul   %eax,%edx
    13ff:	8b 45 18             	mov    0x18(%ebp),%eax
    1402:	01 d0                	add    %edx,%eax
    1404:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1407:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    140e:	eb 74                	jmp    1484 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1410:	8b 45 14             	mov    0x14(%ebp),%eax
    1413:	8b 50 18             	mov    0x18(%eax),%edx
    1416:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1419:	8b 45 f0             	mov    -0x10(%ebp),%eax
    141c:	01 c8                	add    %ecx,%eax
    141e:	89 c1                	mov    %eax,%ecx
    1420:	89 c8                	mov    %ecx,%eax
    1422:	01 c0                	add    %eax,%eax
    1424:	01 c8                	add    %ecx,%eax
    1426:	01 d0                	add    %edx,%eax
    1428:	0f b7 10             	movzwl (%eax),%edx
    142b:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    142f:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1433:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1436:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    143a:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    143e:	38 c2                	cmp    %al,%dl
    1440:	75 18                	jne    145a <APDcCopy+0x154>
    1442:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1446:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    144a:	38 c2                	cmp    %al,%dl
    144c:	75 0c                	jne    145a <APDcCopy+0x154>
    144e:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1452:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1456:	38 c2                	cmp    %al,%dl
    1458:	74 26                	je     1480 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    145a:	8b 45 08             	mov    0x8(%ebp),%eax
    145d:	8b 50 18             	mov    0x18(%eax),%edx
    1460:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1463:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1466:	01 c8                	add    %ecx,%eax
    1468:	89 c1                	mov    %eax,%ecx
    146a:	89 c8                	mov    %ecx,%eax
    146c:	01 c0                	add    %eax,%eax
    146e:	01 c8                	add    %ecx,%eax
    1470:	01 d0                	add    %edx,%eax
    1472:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1476:	66 89 10             	mov    %dx,(%eax)
    1479:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    147d:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1480:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1484:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1487:	2b 45 0c             	sub    0xc(%ebp),%eax
    148a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    148d:	7d 81                	jge    1410 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    148f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1493:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1496:	2b 45 10             	sub    0x10(%ebp),%eax
    1499:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    149c:	0f 8d 35 ff ff ff    	jge    13d7 <APDcCopy+0xd1>
    14a2:	eb 04                	jmp    14a8 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    14a4:	90                   	nop
    14a5:	eb 01                	jmp    14a8 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    14a7:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    14a8:	c9                   	leave  
    14a9:	c3                   	ret    

000014aa <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    14aa:	55                   	push   %ebp
    14ab:	89 e5                	mov    %esp,%ebp
    14ad:	83 ec 1c             	sub    $0x1c,%esp
    14b0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    14b3:	8b 55 10             	mov    0x10(%ebp),%edx
    14b6:	8b 45 14             	mov    0x14(%ebp),%eax
    14b9:	88 4d ec             	mov    %cl,-0x14(%ebp)
    14bc:	88 55 e8             	mov    %dl,-0x18(%ebp)
    14bf:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    14c2:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    14c6:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    14c9:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    14cd:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    14d0:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    14d4:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    14d7:	8b 45 08             	mov    0x8(%ebp),%eax
    14da:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    14de:	66 89 10             	mov    %dx,(%eax)
    14e1:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    14e5:	88 50 02             	mov    %dl,0x2(%eax)
}
    14e8:	8b 45 08             	mov    0x8(%ebp),%eax
    14eb:	c9                   	leave  
    14ec:	c2 04 00             	ret    $0x4

000014ef <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    14ef:	55                   	push   %ebp
    14f0:	89 e5                	mov    %esp,%ebp
    14f2:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    14f5:	8b 45 08             	mov    0x8(%ebp),%eax
    14f8:	8b 00                	mov    (%eax),%eax
    14fa:	83 ec 08             	sub    $0x8,%esp
    14fd:	8d 55 0c             	lea    0xc(%ebp),%edx
    1500:	52                   	push   %edx
    1501:	50                   	push   %eax
    1502:	e8 24 ee ff ff       	call   32b <sendMessage>
    1507:	83 c4 10             	add    $0x10,%esp
}
    150a:	90                   	nop
    150b:	c9                   	leave  
    150c:	c3                   	ret    

0000150d <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    150d:	55                   	push   %ebp
    150e:	89 e5                	mov    %esp,%ebp
    1510:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1513:	83 ec 0c             	sub    $0xc,%esp
    1516:	68 98 00 00 00       	push   $0x98
    151b:	e8 f5 f1 ff ff       	call   715 <malloc>
    1520:	83 c4 10             	add    $0x10,%esp
    1523:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1526:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    152a:	75 15                	jne    1541 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    152c:	83 ec 04             	sub    $0x4,%esp
    152f:	ff 75 08             	pushl  0x8(%ebp)
    1532:	68 74 24 00 00       	push   $0x2474
    1537:	6a 01                	push   $0x1
    1539:	e8 04 ef ff ff       	call   442 <printf>
    153e:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1541:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1544:	05 84 00 00 00       	add    $0x84,%eax
    1549:	83 ec 08             	sub    $0x8,%esp
    154c:	ff 75 08             	pushl  0x8(%ebp)
    154f:	50                   	push   %eax
    1550:	e8 fd ea ff ff       	call   52 <strcpy>
    1555:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1558:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155b:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1562:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1565:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    156c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156f:	8b 40 3c             	mov    0x3c(%eax),%eax
    1572:	89 c2                	mov    %eax,%edx
    1574:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1577:	8b 40 40             	mov    0x40(%eax),%eax
    157a:	0f af d0             	imul   %eax,%edx
    157d:	89 d0                	mov    %edx,%eax
    157f:	01 c0                	add    %eax,%eax
    1581:	01 d0                	add    %edx,%eax
    1583:	83 ec 0c             	sub    $0xc,%esp
    1586:	50                   	push   %eax
    1587:	e8 89 f1 ff ff       	call   715 <malloc>
    158c:	83 c4 10             	add    $0x10,%esp
    158f:	89 c2                	mov    %eax,%edx
    1591:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1594:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1597:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159a:	8b 40 54             	mov    0x54(%eax),%eax
    159d:	85 c0                	test   %eax,%eax
    159f:	75 15                	jne    15b6 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    15a1:	83 ec 04             	sub    $0x4,%esp
    15a4:	ff 75 08             	pushl  0x8(%ebp)
    15a7:	68 94 24 00 00       	push   $0x2494
    15ac:	6a 01                	push   $0x1
    15ae:	e8 8f ee ff ff       	call   442 <printf>
    15b3:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b9:	8b 40 3c             	mov    0x3c(%eax),%eax
    15bc:	89 c2                	mov    %eax,%edx
    15be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c1:	8b 40 40             	mov    0x40(%eax),%eax
    15c4:	0f af d0             	imul   %eax,%edx
    15c7:	89 d0                	mov    %edx,%eax
    15c9:	01 c0                	add    %eax,%eax
    15cb:	01 c2                	add    %eax,%edx
    15cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d0:	8b 40 54             	mov    0x54(%eax),%eax
    15d3:	83 ec 04             	sub    $0x4,%esp
    15d6:	52                   	push   %edx
    15d7:	68 ff ff ff 00       	push   $0xffffff
    15dc:	50                   	push   %eax
    15dd:	e8 06 eb ff ff       	call   e8 <memset>
    15e2:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    15e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e8:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    15ef:	e8 0f ed ff ff       	call   303 <getpid>
    15f4:	89 c2                	mov    %eax,%edx
    15f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f9:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    15fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ff:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1606:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1609:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1610:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1613:	8b 40 58             	mov    0x58(%eax),%eax
    1616:	89 c2                	mov    %eax,%edx
    1618:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161b:	8b 40 5c             	mov    0x5c(%eax),%eax
    161e:	0f af d0             	imul   %eax,%edx
    1621:	89 d0                	mov    %edx,%eax
    1623:	01 c0                	add    %eax,%eax
    1625:	01 d0                	add    %edx,%eax
    1627:	83 ec 0c             	sub    $0xc,%esp
    162a:	50                   	push   %eax
    162b:	e8 e5 f0 ff ff       	call   715 <malloc>
    1630:	83 c4 10             	add    $0x10,%esp
    1633:	89 c2                	mov    %eax,%edx
    1635:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1638:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    163b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163e:	8b 40 70             	mov    0x70(%eax),%eax
    1641:	85 c0                	test   %eax,%eax
    1643:	75 15                	jne    165a <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1645:	83 ec 04             	sub    $0x4,%esp
    1648:	ff 75 08             	pushl  0x8(%ebp)
    164b:	68 b8 24 00 00       	push   $0x24b8
    1650:	6a 01                	push   $0x1
    1652:	e8 eb ed ff ff       	call   442 <printf>
    1657:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    165a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165d:	8b 40 3c             	mov    0x3c(%eax),%eax
    1660:	89 c2                	mov    %eax,%edx
    1662:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1665:	8b 40 40             	mov    0x40(%eax),%eax
    1668:	0f af d0             	imul   %eax,%edx
    166b:	89 d0                	mov    %edx,%eax
    166d:	01 c0                	add    %eax,%eax
    166f:	01 c2                	add    %eax,%edx
    1671:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1674:	8b 40 54             	mov    0x54(%eax),%eax
    1677:	83 ec 04             	sub    $0x4,%esp
    167a:	52                   	push   %edx
    167b:	68 ff 00 00 00       	push   $0xff
    1680:	50                   	push   %eax
    1681:	e8 62 ea ff ff       	call   e8 <memset>
    1686:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1689:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168c:	8b 55 0c             	mov    0xc(%ebp),%edx
    168f:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1692:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1696:	74 49                	je     16e1 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1698:	8b 45 10             	mov    0x10(%ebp),%eax
    169b:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    16a1:	83 ec 0c             	sub    $0xc,%esp
    16a4:	50                   	push   %eax
    16a5:	e8 6b f0 ff ff       	call   715 <malloc>
    16aa:	83 c4 10             	add    $0x10,%esp
    16ad:	89 c2                	mov    %eax,%edx
    16af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b2:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    16b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b8:	8b 55 10             	mov    0x10(%ebp),%edx
    16bb:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    16be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c1:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    16c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16cb:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    16d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d5:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    16dc:	e9 8d 00 00 00       	jmp    176e <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    16e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e4:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    16eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ee:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f8:	8b 40 20             	mov    0x20(%eax),%eax
    16fb:	89 c2                	mov    %eax,%edx
    16fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1700:	8b 40 24             	mov    0x24(%eax),%eax
    1703:	0f af d0             	imul   %eax,%edx
    1706:	89 d0                	mov    %edx,%eax
    1708:	01 c0                	add    %eax,%eax
    170a:	01 d0                	add    %edx,%eax
    170c:	83 ec 0c             	sub    $0xc,%esp
    170f:	50                   	push   %eax
    1710:	e8 00 f0 ff ff       	call   715 <malloc>
    1715:	83 c4 10             	add    $0x10,%esp
    1718:	89 c2                	mov    %eax,%edx
    171a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171d:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1720:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1723:	8b 40 38             	mov    0x38(%eax),%eax
    1726:	85 c0                	test   %eax,%eax
    1728:	75 15                	jne    173f <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    172a:	83 ec 04             	sub    $0x4,%esp
    172d:	ff 75 08             	pushl  0x8(%ebp)
    1730:	68 e0 24 00 00       	push   $0x24e0
    1735:	6a 01                	push   $0x1
    1737:	e8 06 ed ff ff       	call   442 <printf>
    173c:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    173f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1742:	8b 40 20             	mov    0x20(%eax),%eax
    1745:	89 c2                	mov    %eax,%edx
    1747:	8b 45 f4             	mov    -0xc(%ebp),%eax
    174a:	8b 40 24             	mov    0x24(%eax),%eax
    174d:	0f af d0             	imul   %eax,%edx
    1750:	89 d0                	mov    %edx,%eax
    1752:	01 c0                	add    %eax,%eax
    1754:	01 c2                	add    %eax,%edx
    1756:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1759:	8b 40 38             	mov    0x38(%eax),%eax
    175c:	83 ec 04             	sub    $0x4,%esp
    175f:	52                   	push   %edx
    1760:	68 ff ff ff 00       	push   $0xffffff
    1765:	50                   	push   %eax
    1766:	e8 7d e9 ff ff       	call   e8 <memset>
    176b:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    176e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1771:	c9                   	leave  
    1772:	c3                   	ret    

00001773 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1773:	55                   	push   %ebp
    1774:	89 e5                	mov    %esp,%ebp
    1776:	57                   	push   %edi
    1777:	56                   	push   %esi
    1778:	53                   	push   %ebx
    1779:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    177c:	8b 45 0c             	mov    0xc(%ebp),%eax
    177f:	83 f8 03             	cmp    $0x3,%eax
    1782:	74 02                	je     1786 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1784:	eb 7c                	jmp    1802 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1786:	8b 45 08             	mov    0x8(%ebp),%eax
    1789:	8b 58 1c             	mov    0x1c(%eax),%ebx
    178c:	8b 45 08             	mov    0x8(%ebp),%eax
    178f:	8b 48 18             	mov    0x18(%eax),%ecx
    1792:	8b 45 08             	mov    0x8(%ebp),%eax
    1795:	8b 50 5c             	mov    0x5c(%eax),%edx
    1798:	8b 45 08             	mov    0x8(%ebp),%eax
    179b:	8b 40 58             	mov    0x58(%eax),%eax
    179e:	8b 75 08             	mov    0x8(%ebp),%esi
    17a1:	83 c6 58             	add    $0x58,%esi
    17a4:	83 ec 04             	sub    $0x4,%esp
    17a7:	53                   	push   %ebx
    17a8:	51                   	push   %ecx
    17a9:	6a 00                	push   $0x0
    17ab:	52                   	push   %edx
    17ac:	50                   	push   %eax
    17ad:	6a 00                	push   $0x0
    17af:	6a 00                	push   $0x0
    17b1:	56                   	push   %esi
    17b2:	6a 00                	push   $0x0
    17b4:	6a 00                	push   $0x0
    17b6:	ff 75 08             	pushl  0x8(%ebp)
    17b9:	e8 65 eb ff ff       	call   323 <paintWindow>
    17be:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    17c1:	8b 45 08             	mov    0x8(%ebp),%eax
    17c4:	8b 70 1c             	mov    0x1c(%eax),%esi
    17c7:	8b 45 08             	mov    0x8(%ebp),%eax
    17ca:	8b 58 18             	mov    0x18(%eax),%ebx
    17cd:	8b 45 08             	mov    0x8(%ebp),%eax
    17d0:	8b 48 08             	mov    0x8(%eax),%ecx
    17d3:	8b 45 08             	mov    0x8(%ebp),%eax
    17d6:	8b 50 40             	mov    0x40(%eax),%edx
    17d9:	8b 45 08             	mov    0x8(%ebp),%eax
    17dc:	8b 40 3c             	mov    0x3c(%eax),%eax
    17df:	8b 7d 08             	mov    0x8(%ebp),%edi
    17e2:	83 c7 3c             	add    $0x3c,%edi
    17e5:	83 ec 04             	sub    $0x4,%esp
    17e8:	56                   	push   %esi
    17e9:	53                   	push   %ebx
    17ea:	51                   	push   %ecx
    17eb:	52                   	push   %edx
    17ec:	50                   	push   %eax
    17ed:	6a 00                	push   $0x0
    17ef:	6a 00                	push   $0x0
    17f1:	57                   	push   %edi
    17f2:	6a 32                	push   $0x32
    17f4:	6a 00                	push   $0x0
    17f6:	ff 75 08             	pushl  0x8(%ebp)
    17f9:	e8 25 eb ff ff       	call   323 <paintWindow>
    17fe:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1801:	90                   	nop
        default: break;
            
            
    }
    return False;
    1802:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1807:	8d 65 f4             	lea    -0xc(%ebp),%esp
    180a:	5b                   	pop    %ebx
    180b:	5e                   	pop    %esi
    180c:	5f                   	pop    %edi
    180d:	5d                   	pop    %ebp
    180e:	c3                   	ret    

0000180f <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    180f:	55                   	push   %ebp
    1810:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1812:	8b 45 0c             	mov    0xc(%ebp),%eax
    1815:	8b 50 08             	mov    0x8(%eax),%edx
    1818:	8b 45 08             	mov    0x8(%ebp),%eax
    181b:	8b 00                	mov    (%eax),%eax
    181d:	39 c2                	cmp    %eax,%edx
    181f:	74 07                	je     1828 <APPreJudge+0x19>
        return False;
    1821:	b8 00 00 00 00       	mov    $0x0,%eax
    1826:	eb 05                	jmp    182d <APPreJudge+0x1e>
    return True;
    1828:	b8 01 00 00 00       	mov    $0x1,%eax
}
    182d:	5d                   	pop    %ebp
    182e:	c3                   	ret    

0000182f <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    182f:	55                   	push   %ebp
    1830:	89 e5                	mov    %esp,%ebp
    1832:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1835:	8b 45 08             	mov    0x8(%ebp),%eax
    1838:	8b 55 0c             	mov    0xc(%ebp),%edx
    183b:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1841:	83 ec 0c             	sub    $0xc,%esp
    1844:	ff 75 08             	pushl  0x8(%ebp)
    1847:	e8 ef ea ff ff       	call   33b <registWindow>
    184c:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    184f:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1856:	8b 45 08             	mov    0x8(%ebp),%eax
    1859:	8b 00                	mov    (%eax),%eax
    185b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    185e:	ff 75 f4             	pushl  -0xc(%ebp)
    1861:	ff 75 f0             	pushl  -0x10(%ebp)
    1864:	ff 75 ec             	pushl  -0x14(%ebp)
    1867:	ff 75 08             	pushl  0x8(%ebp)
    186a:	e8 80 fc ff ff       	call   14ef <APSendMessage>
    186f:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1872:	83 ec 0c             	sub    $0xc,%esp
    1875:	ff 75 08             	pushl  0x8(%ebp)
    1878:	e8 b6 ea ff ff       	call   333 <getMessage>
    187d:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1880:	8b 45 08             	mov    0x8(%ebp),%eax
    1883:	83 c0 74             	add    $0x74,%eax
    1886:	83 ec 08             	sub    $0x8,%esp
    1889:	50                   	push   %eax
    188a:	ff 75 08             	pushl  0x8(%ebp)
    188d:	e8 7d ff ff ff       	call   180f <APPreJudge>
    1892:	83 c4 10             	add    $0x10,%esp
    1895:	84 c0                	test   %al,%al
    1897:	74 1b                	je     18b4 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1899:	8b 45 08             	mov    0x8(%ebp),%eax
    189c:	ff 70 7c             	pushl  0x7c(%eax)
    189f:	ff 70 78             	pushl  0x78(%eax)
    18a2:	ff 70 74             	pushl  0x74(%eax)
    18a5:	ff 75 08             	pushl  0x8(%ebp)
    18a8:	8b 45 0c             	mov    0xc(%ebp),%eax
    18ab:	ff d0                	call   *%eax
    18ad:	83 c4 10             	add    $0x10,%esp
    18b0:	84 c0                	test   %al,%al
    18b2:	75 0c                	jne    18c0 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    18b4:	8b 45 08             	mov    0x8(%ebp),%eax
    18b7:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    18be:	eb b2                	jmp    1872 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    18c0:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    18c1:	90                   	nop
    18c2:	c9                   	leave  
    18c3:	c3                   	ret    

000018c4 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    18c4:	55                   	push   %ebp
    18c5:	89 e5                	mov    %esp,%ebp
    18c7:	57                   	push   %edi
    18c8:	56                   	push   %esi
    18c9:	53                   	push   %ebx
    18ca:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    18cd:	a1 e4 67 00 00       	mov    0x67e4,%eax
    18d2:	85 c0                	test   %eax,%eax
    18d4:	0f 85 7a 02 00 00    	jne    1b54 <APGridPaint+0x290>
    {
        iconReady = 1;
    18da:	c7 05 e4 67 00 00 01 	movl   $0x1,0x67e4
    18e1:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    18e4:	8d 45 88             	lea    -0x78(%ebp),%eax
    18e7:	83 ec 08             	sub    $0x8,%esp
    18ea:	68 07 25 00 00       	push   $0x2507
    18ef:	50                   	push   %eax
    18f0:	e8 d3 ef ff ff       	call   8c8 <APLoadBitmap>
    18f5:	83 c4 0c             	add    $0xc,%esp
    18f8:	8b 45 88             	mov    -0x78(%ebp),%eax
    18fb:	a3 08 68 00 00       	mov    %eax,0x6808
    1900:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1903:	a3 0c 68 00 00       	mov    %eax,0x680c
    1908:	8b 45 90             	mov    -0x70(%ebp),%eax
    190b:	a3 10 68 00 00       	mov    %eax,0x6810
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1910:	83 ec 04             	sub    $0x4,%esp
    1913:	ff 35 10 68 00 00    	pushl  0x6810
    1919:	ff 35 0c 68 00 00    	pushl  0x680c
    191f:	ff 35 08 68 00 00    	pushl  0x6808
    1925:	e8 d8 f1 ff ff       	call   b02 <APCreateCompatibleDCFromBitmap>
    192a:	83 c4 10             	add    $0x10,%esp
    192d:	a3 14 68 00 00       	mov    %eax,0x6814
        grid_river = APLoadBitmap ("grid_river.bmp");
    1932:	8d 45 88             	lea    -0x78(%ebp),%eax
    1935:	83 ec 08             	sub    $0x8,%esp
    1938:	68 15 25 00 00       	push   $0x2515
    193d:	50                   	push   %eax
    193e:	e8 85 ef ff ff       	call   8c8 <APLoadBitmap>
    1943:	83 c4 0c             	add    $0xc,%esp
    1946:	8b 45 88             	mov    -0x78(%ebp),%eax
    1949:	a3 50 68 00 00       	mov    %eax,0x6850
    194e:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1951:	a3 54 68 00 00       	mov    %eax,0x6854
    1956:	8b 45 90             	mov    -0x70(%ebp),%eax
    1959:	a3 58 68 00 00       	mov    %eax,0x6858
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    195e:	83 ec 04             	sub    $0x4,%esp
    1961:	ff 35 58 68 00 00    	pushl  0x6858
    1967:	ff 35 54 68 00 00    	pushl  0x6854
    196d:	ff 35 50 68 00 00    	pushl  0x6850
    1973:	e8 8a f1 ff ff       	call   b02 <APCreateCompatibleDCFromBitmap>
    1978:	83 c4 10             	add    $0x10,%esp
    197b:	a3 40 68 00 00       	mov    %eax,0x6840
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1980:	8d 45 88             	lea    -0x78(%ebp),%eax
    1983:	83 ec 08             	sub    $0x8,%esp
    1986:	68 24 25 00 00       	push   $0x2524
    198b:	50                   	push   %eax
    198c:	e8 37 ef ff ff       	call   8c8 <APLoadBitmap>
    1991:	83 c4 0c             	add    $0xc,%esp
    1994:	8b 45 88             	mov    -0x78(%ebp),%eax
    1997:	a3 44 68 00 00       	mov    %eax,0x6844
    199c:	8b 45 8c             	mov    -0x74(%ebp),%eax
    199f:	a3 48 68 00 00       	mov    %eax,0x6848
    19a4:	8b 45 90             	mov    -0x70(%ebp),%eax
    19a7:	a3 4c 68 00 00       	mov    %eax,0x684c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    19ac:	83 ec 04             	sub    $0x4,%esp
    19af:	ff 35 4c 68 00 00    	pushl  0x684c
    19b5:	ff 35 48 68 00 00    	pushl  0x6848
    19bb:	ff 35 44 68 00 00    	pushl  0x6844
    19c1:	e8 3c f1 ff ff       	call   b02 <APCreateCompatibleDCFromBitmap>
    19c6:	83 c4 10             	add    $0x10,%esp
    19c9:	a3 e8 67 00 00       	mov    %eax,0x67e8
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    19ce:	8d 45 88             	lea    -0x78(%ebp),%eax
    19d1:	83 ec 08             	sub    $0x8,%esp
    19d4:	68 33 25 00 00       	push   $0x2533
    19d9:	50                   	push   %eax
    19da:	e8 e9 ee ff ff       	call   8c8 <APLoadBitmap>
    19df:	83 c4 0c             	add    $0xc,%esp
    19e2:	8b 45 88             	mov    -0x78(%ebp),%eax
    19e5:	a3 1c 68 00 00       	mov    %eax,0x681c
    19ea:	8b 45 8c             	mov    -0x74(%ebp),%eax
    19ed:	a3 20 68 00 00       	mov    %eax,0x6820
    19f2:	8b 45 90             	mov    -0x70(%ebp),%eax
    19f5:	a3 24 68 00 00       	mov    %eax,0x6824
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    19fa:	83 ec 04             	sub    $0x4,%esp
    19fd:	ff 35 24 68 00 00    	pushl  0x6824
    1a03:	ff 35 20 68 00 00    	pushl  0x6820
    1a09:	ff 35 1c 68 00 00    	pushl  0x681c
    1a0f:	e8 ee f0 ff ff       	call   b02 <APCreateCompatibleDCFromBitmap>
    1a14:	83 c4 10             	add    $0x10,%esp
    1a17:	a3 60 68 00 00       	mov    %eax,0x6860
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1a1c:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a1f:	83 ec 08             	sub    $0x8,%esp
    1a22:	68 41 25 00 00       	push   $0x2541
    1a27:	50                   	push   %eax
    1a28:	e8 9b ee ff ff       	call   8c8 <APLoadBitmap>
    1a2d:	83 c4 0c             	add    $0xc,%esp
    1a30:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a33:	a3 f8 67 00 00       	mov    %eax,0x67f8
    1a38:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a3b:	a3 fc 67 00 00       	mov    %eax,0x67fc
    1a40:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a43:	a3 00 68 00 00       	mov    %eax,0x6800
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1a48:	83 ec 04             	sub    $0x4,%esp
    1a4b:	ff 35 00 68 00 00    	pushl  0x6800
    1a51:	ff 35 fc 67 00 00    	pushl  0x67fc
    1a57:	ff 35 f8 67 00 00    	pushl  0x67f8
    1a5d:	e8 a0 f0 ff ff       	call   b02 <APCreateCompatibleDCFromBitmap>
    1a62:	83 c4 10             	add    $0x10,%esp
    1a65:	a3 18 68 00 00       	mov    %eax,0x6818
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1a6a:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a6d:	83 ec 08             	sub    $0x8,%esp
    1a70:	68 51 25 00 00       	push   $0x2551
    1a75:	50                   	push   %eax
    1a76:	e8 4d ee ff ff       	call   8c8 <APLoadBitmap>
    1a7b:	83 c4 0c             	add    $0xc,%esp
    1a7e:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a81:	a3 ec 67 00 00       	mov    %eax,0x67ec
    1a86:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a89:	a3 f0 67 00 00       	mov    %eax,0x67f0
    1a8e:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a91:	a3 f4 67 00 00       	mov    %eax,0x67f4
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1a96:	83 ec 04             	sub    $0x4,%esp
    1a99:	ff 35 f4 67 00 00    	pushl  0x67f4
    1a9f:	ff 35 f0 67 00 00    	pushl  0x67f0
    1aa5:	ff 35 ec 67 00 00    	pushl  0x67ec
    1aab:	e8 52 f0 ff ff       	call   b02 <APCreateCompatibleDCFromBitmap>
    1ab0:	83 c4 10             	add    $0x10,%esp
    1ab3:	a3 04 68 00 00       	mov    %eax,0x6804
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1ab8:	8d 45 88             	lea    -0x78(%ebp),%eax
    1abb:	83 ec 08             	sub    $0x8,%esp
    1abe:	68 63 25 00 00       	push   $0x2563
    1ac3:	50                   	push   %eax
    1ac4:	e8 ff ed ff ff       	call   8c8 <APLoadBitmap>
    1ac9:	83 c4 0c             	add    $0xc,%esp
    1acc:	8b 45 88             	mov    -0x78(%ebp),%eax
    1acf:	a3 34 68 00 00       	mov    %eax,0x6834
    1ad4:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1ad7:	a3 38 68 00 00       	mov    %eax,0x6838
    1adc:	8b 45 90             	mov    -0x70(%ebp),%eax
    1adf:	a3 3c 68 00 00       	mov    %eax,0x683c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1ae4:	83 ec 04             	sub    $0x4,%esp
    1ae7:	ff 35 3c 68 00 00    	pushl  0x683c
    1aed:	ff 35 38 68 00 00    	pushl  0x6838
    1af3:	ff 35 34 68 00 00    	pushl  0x6834
    1af9:	e8 04 f0 ff ff       	call   b02 <APCreateCompatibleDCFromBitmap>
    1afe:	83 c4 10             	add    $0x10,%esp
    1b01:	a3 64 68 00 00       	mov    %eax,0x6864
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    1b06:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b09:	83 ec 08             	sub    $0x8,%esp
    1b0c:	68 72 25 00 00       	push   $0x2572
    1b11:	50                   	push   %eax
    1b12:	e8 b1 ed ff ff       	call   8c8 <APLoadBitmap>
    1b17:	83 c4 0c             	add    $0xc,%esp
    1b1a:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b1d:	a3 28 68 00 00       	mov    %eax,0x6828
    1b22:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b25:	a3 2c 68 00 00       	mov    %eax,0x682c
    1b2a:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b2d:	a3 30 68 00 00       	mov    %eax,0x6830
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    1b32:	83 ec 04             	sub    $0x4,%esp
    1b35:	ff 35 30 68 00 00    	pushl  0x6830
    1b3b:	ff 35 2c 68 00 00    	pushl  0x682c
    1b41:	ff 35 28 68 00 00    	pushl  0x6828
    1b47:	e8 b6 ef ff ff       	call   b02 <APCreateCompatibleDCFromBitmap>
    1b4c:	83 c4 10             	add    $0x10,%esp
    1b4f:	a3 5c 68 00 00       	mov    %eax,0x685c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1b54:	8b 45 08             	mov    0x8(%ebp),%eax
    1b57:	8b 40 08             	mov    0x8(%eax),%eax
    1b5a:	85 c0                	test   %eax,%eax
    1b5c:	75 17                	jne    1b75 <APGridPaint+0x2b1>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1b5e:	83 ec 08             	sub    $0x8,%esp
    1b61:	68 84 25 00 00       	push   $0x2584
    1b66:	6a 01                	push   $0x1
    1b68:	e8 d5 e8 ff ff       	call   442 <printf>
    1b6d:	83 c4 10             	add    $0x10,%esp
        return;
    1b70:	e9 65 05 00 00       	jmp    20da <APGridPaint+0x816>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1b75:	8b 45 08             	mov    0x8(%ebp),%eax
    1b78:	8b 40 10             	mov    0x10(%eax),%eax
    1b7b:	85 c0                	test   %eax,%eax
    1b7d:	7e 10                	jle    1b8f <APGridPaint+0x2cb>
    1b7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b82:	8b 50 14             	mov    0x14(%eax),%edx
    1b85:	8b 45 08             	mov    0x8(%ebp),%eax
    1b88:	8b 40 10             	mov    0x10(%eax),%eax
    1b8b:	39 c2                	cmp    %eax,%edx
    1b8d:	7c 17                	jl     1ba6 <APGridPaint+0x2e2>
    {
        printf(1,"Grid mode page error!");
    1b8f:	83 ec 08             	sub    $0x8,%esp
    1b92:	68 aa 25 00 00       	push   $0x25aa
    1b97:	6a 01                	push   $0x1
    1b99:	e8 a4 e8 ff ff       	call   442 <printf>
    1b9e:	83 c4 10             	add    $0x10,%esp
        return;
    1ba1:	e9 34 05 00 00       	jmp    20da <APGridPaint+0x816>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1ba6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba9:	8b 40 14             	mov    0x14(%eax),%eax
    1bac:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1bb2:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1bb5:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1bb8:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1bbb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1bc2:	e9 f4 03 00 00       	jmp    1fbb <APGridPaint+0x6f7>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1bc7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1bce:	e9 da 03 00 00       	jmp    1fad <APGridPaint+0x6e9>
        {
            index = start + GRID_W_NUMBER * j + i;
    1bd3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bd6:	c1 e0 04             	shl    $0x4,%eax
    1bd9:	89 c2                	mov    %eax,%edx
    1bdb:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1bde:	01 c2                	add    %eax,%edx
    1be0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1be3:	01 d0                	add    %edx,%eax
    1be5:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1be8:	8b 45 08             	mov    0x8(%ebp),%eax
    1beb:	8b 40 0c             	mov    0xc(%eax),%eax
    1bee:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1bf1:	c1 e2 02             	shl    $0x2,%edx
    1bf4:	01 d0                	add    %edx,%eax
    1bf6:	8b 00                	mov    (%eax),%eax
    1bf8:	83 f8 0a             	cmp    $0xa,%eax
    1bfb:	0f 87 a7 03 00 00    	ja     1fa8 <APGridPaint+0x6e4>
    1c01:	8b 04 85 c0 25 00 00 	mov    0x25c0(,%eax,4),%eax
    1c08:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c0a:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1c0d:	6a 0c                	push   $0xc
    1c0f:	6a 0c                	push   $0xc
    1c11:	6a 0c                	push   $0xc
    1c13:	50                   	push   %eax
    1c14:	e8 91 f8 ff ff       	call   14aa <RGB>
    1c19:	83 c4 0c             	add    $0xc,%esp
    1c1c:	8b 1d 14 68 00 00    	mov    0x6814,%ebx
    1c22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c25:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c28:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c2b:	6b c0 32             	imul   $0x32,%eax,%eax
    1c2e:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1c31:	8b 45 08             	mov    0x8(%ebp),%eax
    1c34:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c37:	83 ec 0c             	sub    $0xc,%esp
    1c3a:	83 ec 04             	sub    $0x4,%esp
    1c3d:	89 e0                	mov    %esp,%eax
    1c3f:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    1c43:	66 89 30             	mov    %si,(%eax)
    1c46:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    1c4a:	88 50 02             	mov    %dl,0x2(%eax)
    1c4d:	6a 32                	push   $0x32
    1c4f:	6a 32                	push   $0x32
    1c51:	6a 00                	push   $0x0
    1c53:	6a 00                	push   $0x0
    1c55:	53                   	push   %ebx
    1c56:	51                   	push   %ecx
    1c57:	ff 75 84             	pushl  -0x7c(%ebp)
    1c5a:	57                   	push   %edi
    1c5b:	e8 a6 f6 ff ff       	call   1306 <APDcCopy>
    1c60:	83 c4 30             	add    $0x30,%esp
                    break;
    1c63:	e9 41 03 00 00       	jmp    1fa9 <APGridPaint+0x6e5>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1c68:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c6b:	6a 69                	push   $0x69
    1c6d:	6a 69                	push   $0x69
    1c6f:	6a 69                	push   $0x69
    1c71:	50                   	push   %eax
    1c72:	e8 33 f8 ff ff       	call   14aa <RGB>
    1c77:	83 c4 0c             	add    $0xc,%esp
    1c7a:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1c7e:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1c82:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1c86:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1c89:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1c90:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c93:	6a 69                	push   $0x69
    1c95:	6a 69                	push   $0x69
    1c97:	6a 69                	push   $0x69
    1c99:	50                   	push   %eax
    1c9a:	e8 0b f8 ff ff       	call   14aa <RGB>
    1c9f:	83 c4 0c             	add    $0xc,%esp
    1ca2:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1ca6:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1caa:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1cae:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1cb1:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb4:	8d 50 3c             	lea    0x3c(%eax),%edx
    1cb7:	8d 45 88             	lea    -0x78(%ebp),%eax
    1cba:	ff 75 ac             	pushl  -0x54(%ebp)
    1cbd:	ff 75 a8             	pushl  -0x58(%ebp)
    1cc0:	52                   	push   %edx
    1cc1:	50                   	push   %eax
    1cc2:	e8 d0 ee ff ff       	call   b97 <APSetPen>
    1cc7:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1cca:	8b 45 08             	mov    0x8(%ebp),%eax
    1ccd:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1cd0:	8d 55 88             	lea    -0x78(%ebp),%edx
    1cd3:	83 ec 04             	sub    $0x4,%esp
    1cd6:	83 ec 04             	sub    $0x4,%esp
    1cd9:	89 e0                	mov    %esp,%eax
    1cdb:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1cdf:	66 89 08             	mov    %cx,(%eax)
    1ce2:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    1ce6:	88 48 02             	mov    %cl,0x2(%eax)
    1ce9:	53                   	push   %ebx
    1cea:	52                   	push   %edx
    1ceb:	e8 e0 ee ff ff       	call   bd0 <APSetBrush>
    1cf0:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1cf3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cf6:	6b d0 32             	imul   $0x32,%eax,%edx
    1cf9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cfc:	6b c0 32             	imul   $0x32,%eax,%eax
    1cff:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1d02:	83 c1 3c             	add    $0x3c,%ecx
    1d05:	83 ec 0c             	sub    $0xc,%esp
    1d08:	6a 32                	push   $0x32
    1d0a:	6a 32                	push   $0x32
    1d0c:	52                   	push   %edx
    1d0d:	50                   	push   %eax
    1d0e:	51                   	push   %ecx
    1d0f:	e8 e6 f2 ff ff       	call   ffa <APDrawRect>
    1d14:	83 c4 20             	add    $0x20,%esp
                    break;
    1d17:	e9 8d 02 00 00       	jmp    1fa9 <APGridPaint+0x6e5>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d1c:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1d1f:	6a 0c                	push   $0xc
    1d21:	6a 0c                	push   $0xc
    1d23:	6a 0c                	push   $0xc
    1d25:	50                   	push   %eax
    1d26:	e8 7f f7 ff ff       	call   14aa <RGB>
    1d2b:	83 c4 0c             	add    $0xc,%esp
    1d2e:	8b 1d 64 68 00 00    	mov    0x6864,%ebx
    1d34:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d37:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d3a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d3d:	6b c0 32             	imul   $0x32,%eax,%eax
    1d40:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1d43:	8b 45 08             	mov    0x8(%ebp),%eax
    1d46:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d49:	83 ec 0c             	sub    $0xc,%esp
    1d4c:	83 ec 04             	sub    $0x4,%esp
    1d4f:	89 e0                	mov    %esp,%eax
    1d51:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1d55:	66 89 30             	mov    %si,(%eax)
    1d58:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1d5c:	88 50 02             	mov    %dl,0x2(%eax)
    1d5f:	6a 32                	push   $0x32
    1d61:	6a 32                	push   $0x32
    1d63:	6a 00                	push   $0x0
    1d65:	6a 00                	push   $0x0
    1d67:	53                   	push   %ebx
    1d68:	51                   	push   %ecx
    1d69:	ff 75 84             	pushl  -0x7c(%ebp)
    1d6c:	57                   	push   %edi
    1d6d:	e8 94 f5 ff ff       	call   1306 <APDcCopy>
    1d72:	83 c4 30             	add    $0x30,%esp
                    break;
    1d75:	e9 2f 02 00 00       	jmp    1fa9 <APGridPaint+0x6e5>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d7a:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1d7d:	6a 0c                	push   $0xc
    1d7f:	6a 0c                	push   $0xc
    1d81:	6a 0c                	push   $0xc
    1d83:	50                   	push   %eax
    1d84:	e8 21 f7 ff ff       	call   14aa <RGB>
    1d89:	83 c4 0c             	add    $0xc,%esp
    1d8c:	8b 1d 40 68 00 00    	mov    0x6840,%ebx
    1d92:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d95:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d98:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d9b:	6b c0 32             	imul   $0x32,%eax,%eax
    1d9e:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1da1:	8b 45 08             	mov    0x8(%ebp),%eax
    1da4:	8d 78 3c             	lea    0x3c(%eax),%edi
    1da7:	83 ec 0c             	sub    $0xc,%esp
    1daa:	83 ec 04             	sub    $0x4,%esp
    1dad:	89 e0                	mov    %esp,%eax
    1daf:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1db3:	66 89 30             	mov    %si,(%eax)
    1db6:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1dba:	88 50 02             	mov    %dl,0x2(%eax)
    1dbd:	6a 32                	push   $0x32
    1dbf:	6a 32                	push   $0x32
    1dc1:	6a 00                	push   $0x0
    1dc3:	6a 00                	push   $0x0
    1dc5:	53                   	push   %ebx
    1dc6:	51                   	push   %ecx
    1dc7:	ff 75 84             	pushl  -0x7c(%ebp)
    1dca:	57                   	push   %edi
    1dcb:	e8 36 f5 ff ff       	call   1306 <APDcCopy>
    1dd0:	83 c4 30             	add    $0x30,%esp
                    break;
    1dd3:	e9 d1 01 00 00       	jmp    1fa9 <APGridPaint+0x6e5>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dd8:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1ddb:	6a 0c                	push   $0xc
    1ddd:	6a 0c                	push   $0xc
    1ddf:	6a 0c                	push   $0xc
    1de1:	50                   	push   %eax
    1de2:	e8 c3 f6 ff ff       	call   14aa <RGB>
    1de7:	83 c4 0c             	add    $0xc,%esp
    1dea:	8b 1d 18 68 00 00    	mov    0x6818,%ebx
    1df0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1df3:	6b c8 32             	imul   $0x32,%eax,%ecx
    1df6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1df9:	6b c0 32             	imul   $0x32,%eax,%eax
    1dfc:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1dff:	8b 45 08             	mov    0x8(%ebp),%eax
    1e02:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e05:	83 ec 0c             	sub    $0xc,%esp
    1e08:	83 ec 04             	sub    $0x4,%esp
    1e0b:	89 e0                	mov    %esp,%eax
    1e0d:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1e11:	66 89 30             	mov    %si,(%eax)
    1e14:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1e18:	88 50 02             	mov    %dl,0x2(%eax)
    1e1b:	6a 32                	push   $0x32
    1e1d:	6a 32                	push   $0x32
    1e1f:	6a 00                	push   $0x0
    1e21:	6a 00                	push   $0x0
    1e23:	53                   	push   %ebx
    1e24:	51                   	push   %ecx
    1e25:	ff 75 84             	pushl  -0x7c(%ebp)
    1e28:	57                   	push   %edi
    1e29:	e8 d8 f4 ff ff       	call   1306 <APDcCopy>
    1e2e:	83 c4 30             	add    $0x30,%esp
                    break;
    1e31:	e9 73 01 00 00       	jmp    1fa9 <APGridPaint+0x6e5>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e36:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1e39:	6a 0c                	push   $0xc
    1e3b:	6a 0c                	push   $0xc
    1e3d:	6a 0c                	push   $0xc
    1e3f:	50                   	push   %eax
    1e40:	e8 65 f6 ff ff       	call   14aa <RGB>
    1e45:	83 c4 0c             	add    $0xc,%esp
    1e48:	8b 1d 60 68 00 00    	mov    0x6860,%ebx
    1e4e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e51:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e54:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e57:	6b c0 32             	imul   $0x32,%eax,%eax
    1e5a:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e5d:	8b 45 08             	mov    0x8(%ebp),%eax
    1e60:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e63:	83 ec 0c             	sub    $0xc,%esp
    1e66:	83 ec 04             	sub    $0x4,%esp
    1e69:	89 e0                	mov    %esp,%eax
    1e6b:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1e6f:	66 89 30             	mov    %si,(%eax)
    1e72:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1e76:	88 50 02             	mov    %dl,0x2(%eax)
    1e79:	6a 32                	push   $0x32
    1e7b:	6a 32                	push   $0x32
    1e7d:	6a 00                	push   $0x0
    1e7f:	6a 00                	push   $0x0
    1e81:	53                   	push   %ebx
    1e82:	51                   	push   %ecx
    1e83:	ff 75 84             	pushl  -0x7c(%ebp)
    1e86:	57                   	push   %edi
    1e87:	e8 7a f4 ff ff       	call   1306 <APDcCopy>
    1e8c:	83 c4 30             	add    $0x30,%esp
                    break;
    1e8f:	e9 15 01 00 00       	jmp    1fa9 <APGridPaint+0x6e5>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e94:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1e97:	6a 0c                	push   $0xc
    1e99:	6a 0c                	push   $0xc
    1e9b:	6a 0c                	push   $0xc
    1e9d:	50                   	push   %eax
    1e9e:	e8 07 f6 ff ff       	call   14aa <RGB>
    1ea3:	83 c4 0c             	add    $0xc,%esp
    1ea6:	8b 1d e8 67 00 00    	mov    0x67e8,%ebx
    1eac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1eaf:	6b c8 32             	imul   $0x32,%eax,%ecx
    1eb2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1eb5:	6b c0 32             	imul   $0x32,%eax,%eax
    1eb8:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1ebb:	8b 45 08             	mov    0x8(%ebp),%eax
    1ebe:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ec1:	83 ec 0c             	sub    $0xc,%esp
    1ec4:	83 ec 04             	sub    $0x4,%esp
    1ec7:	89 e0                	mov    %esp,%eax
    1ec9:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1ecd:	66 89 30             	mov    %si,(%eax)
    1ed0:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1ed4:	88 50 02             	mov    %dl,0x2(%eax)
    1ed7:	6a 32                	push   $0x32
    1ed9:	6a 32                	push   $0x32
    1edb:	6a 00                	push   $0x0
    1edd:	6a 00                	push   $0x0
    1edf:	53                   	push   %ebx
    1ee0:	51                   	push   %ecx
    1ee1:	ff 75 84             	pushl  -0x7c(%ebp)
    1ee4:	57                   	push   %edi
    1ee5:	e8 1c f4 ff ff       	call   1306 <APDcCopy>
    1eea:	83 c4 30             	add    $0x30,%esp
                    break;
    1eed:	e9 b7 00 00 00       	jmp    1fa9 <APGridPaint+0x6e5>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ef2:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1ef5:	6a 0c                	push   $0xc
    1ef7:	6a 0c                	push   $0xc
    1ef9:	6a 0c                	push   $0xc
    1efb:	50                   	push   %eax
    1efc:	e8 a9 f5 ff ff       	call   14aa <RGB>
    1f01:	83 c4 0c             	add    $0xc,%esp
    1f04:	8b 1d 04 68 00 00    	mov    0x6804,%ebx
    1f0a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f0d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f10:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f13:	6b c0 32             	imul   $0x32,%eax,%eax
    1f16:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f19:	8b 45 08             	mov    0x8(%ebp),%eax
    1f1c:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f1f:	83 ec 0c             	sub    $0xc,%esp
    1f22:	83 ec 04             	sub    $0x4,%esp
    1f25:	89 e0                	mov    %esp,%eax
    1f27:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1f2b:	66 89 30             	mov    %si,(%eax)
    1f2e:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1f32:	88 50 02             	mov    %dl,0x2(%eax)
    1f35:	6a 32                	push   $0x32
    1f37:	6a 32                	push   $0x32
    1f39:	6a 00                	push   $0x0
    1f3b:	6a 00                	push   $0x0
    1f3d:	53                   	push   %ebx
    1f3e:	51                   	push   %ecx
    1f3f:	ff 75 84             	pushl  -0x7c(%ebp)
    1f42:	57                   	push   %edi
    1f43:	e8 be f3 ff ff       	call   1306 <APDcCopy>
    1f48:	83 c4 30             	add    $0x30,%esp
                    break;
    1f4b:	eb 5c                	jmp    1fa9 <APGridPaint+0x6e5>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f4d:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1f50:	6a 0c                	push   $0xc
    1f52:	6a 0c                	push   $0xc
    1f54:	6a 0c                	push   $0xc
    1f56:	50                   	push   %eax
    1f57:	e8 4e f5 ff ff       	call   14aa <RGB>
    1f5c:	83 c4 0c             	add    $0xc,%esp
    1f5f:	8b 1d 5c 68 00 00    	mov    0x685c,%ebx
    1f65:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f68:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f6b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f6e:	6b c0 32             	imul   $0x32,%eax,%eax
    1f71:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f74:	8b 45 08             	mov    0x8(%ebp),%eax
    1f77:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f7a:	83 ec 0c             	sub    $0xc,%esp
    1f7d:	83 ec 04             	sub    $0x4,%esp
    1f80:	89 e0                	mov    %esp,%eax
    1f82:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1f86:	66 89 30             	mov    %si,(%eax)
    1f89:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1f8d:	88 50 02             	mov    %dl,0x2(%eax)
    1f90:	6a 32                	push   $0x32
    1f92:	6a 32                	push   $0x32
    1f94:	6a 00                	push   $0x0
    1f96:	6a 00                	push   $0x0
    1f98:	53                   	push   %ebx
    1f99:	51                   	push   %ecx
    1f9a:	ff 75 84             	pushl  -0x7c(%ebp)
    1f9d:	57                   	push   %edi
    1f9e:	e8 63 f3 ff ff       	call   1306 <APDcCopy>
    1fa3:	83 c4 30             	add    $0x30,%esp
                    break;
    1fa6:	eb 01                	jmp    1fa9 <APGridPaint+0x6e5>
                default: break;
    1fa8:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1fa9:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1fad:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1fb1:	0f 8e 1c fc ff ff    	jle    1bd3 <APGridPaint+0x30f>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1fb7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1fbb:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1fbf:	0f 8e 02 fc ff ff    	jle    1bc7 <APGridPaint+0x303>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1fc5:	8d 45 88             	lea    -0x78(%ebp),%eax
    1fc8:	68 cd 00 00 00       	push   $0xcd
    1fcd:	6a 74                	push   $0x74
    1fcf:	6a 18                	push   $0x18
    1fd1:	50                   	push   %eax
    1fd2:	e8 d3 f4 ff ff       	call   14aa <RGB>
    1fd7:	83 c4 0c             	add    $0xc,%esp
    1fda:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1fde:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1fe2:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1fe6:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1fe9:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1ff0:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ff3:	68 cd 00 00 00       	push   $0xcd
    1ff8:	6a 74                	push   $0x74
    1ffa:	6a 18                	push   $0x18
    1ffc:	50                   	push   %eax
    1ffd:	e8 a8 f4 ff ff       	call   14aa <RGB>
    2002:	83 c4 0c             	add    $0xc,%esp
    2005:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2009:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    200d:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2011:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    2014:	8b 45 08             	mov    0x8(%ebp),%eax
    2017:	8d 50 58             	lea    0x58(%eax),%edx
    201a:	8d 45 88             	lea    -0x78(%ebp),%eax
    201d:	ff 75 bc             	pushl  -0x44(%ebp)
    2020:	ff 75 b8             	pushl  -0x48(%ebp)
    2023:	52                   	push   %edx
    2024:	50                   	push   %eax
    2025:	e8 6d eb ff ff       	call   b97 <APSetPen>
    202a:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    202d:	8b 45 08             	mov    0x8(%ebp),%eax
    2030:	8d 58 58             	lea    0x58(%eax),%ebx
    2033:	8d 55 88             	lea    -0x78(%ebp),%edx
    2036:	83 ec 04             	sub    $0x4,%esp
    2039:	83 ec 04             	sub    $0x4,%esp
    203c:	89 e0                	mov    %esp,%eax
    203e:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    2042:	66 89 08             	mov    %cx,(%eax)
    2045:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    2049:	88 48 02             	mov    %cl,0x2(%eax)
    204c:	53                   	push   %ebx
    204d:	52                   	push   %edx
    204e:	e8 7d eb ff ff       	call   bd0 <APSetBrush>
    2053:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2056:	8b 45 08             	mov    0x8(%ebp),%eax
    2059:	83 c0 58             	add    $0x58,%eax
    205c:	83 ec 0c             	sub    $0xc,%esp
    205f:	6a 32                	push   $0x32
    2061:	68 20 03 00 00       	push   $0x320
    2066:	6a 00                	push   $0x0
    2068:	6a 00                	push   $0x0
    206a:	50                   	push   %eax
    206b:	e8 8a ef ff ff       	call   ffa <APDrawRect>
    2070:	83 c4 20             	add    $0x20,%esp


    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    2073:	8d 45 88             	lea    -0x78(%ebp),%eax
    2076:	6a 08                	push   $0x8
    2078:	6a 08                	push   $0x8
    207a:	6a 08                	push   $0x8
    207c:	50                   	push   %eax
    207d:	e8 28 f4 ff ff       	call   14aa <RGB>
    2082:	83 c4 0c             	add    $0xc,%esp
    2085:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2089:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    208d:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2091:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    2094:	8b 45 08             	mov    0x8(%ebp),%eax
    2097:	8d 58 58             	lea    0x58(%eax),%ebx
    209a:	8d 55 88             	lea    -0x78(%ebp),%edx
    209d:	83 ec 04             	sub    $0x4,%esp
    20a0:	83 ec 04             	sub    $0x4,%esp
    20a3:	89 e0                	mov    %esp,%eax
    20a5:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    20a9:	66 89 08             	mov    %cx,(%eax)
    20ac:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    20b0:	88 48 02             	mov    %cl,0x2(%eax)
    20b3:	53                   	push   %ebx
    20b4:	52                   	push   %edx
    20b5:	e8 58 eb ff ff       	call   c12 <APSetFont>
    20ba:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    20bd:	8b 45 08             	mov    0x8(%ebp),%eax
    20c0:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    20c6:	8b 45 08             	mov    0x8(%ebp),%eax
    20c9:	83 c0 58             	add    $0x58,%eax
    20cc:	6a 14                	push   $0x14
    20ce:	6a 14                	push   $0x14
    20d0:	52                   	push   %edx
    20d1:	50                   	push   %eax
    20d2:	e8 28 f1 ff ff       	call   11ff <APDrawText>
    20d7:	83 c4 10             	add    $0x10,%esp
    
}
    20da:	8d 65 f4             	lea    -0xc(%ebp),%esp
    20dd:	5b                   	pop    %ebx
    20de:	5e                   	pop    %esi
    20df:	5f                   	pop    %edi
    20e0:	5d                   	pop    %ebp
    20e1:	c3                   	ret    

000020e2 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    20e2:	55                   	push   %ebp
    20e3:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    20e5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    20e9:	7e 08                	jle    20f3 <random+0x11>
{
rand_num = seed;
    20eb:	8b 45 08             	mov    0x8(%ebp),%eax
    20ee:	a3 c0 67 00 00       	mov    %eax,0x67c0
}
rand_num *= 3;
    20f3:	8b 15 c0 67 00 00    	mov    0x67c0,%edx
    20f9:	89 d0                	mov    %edx,%eax
    20fb:	01 c0                	add    %eax,%eax
    20fd:	01 d0                	add    %edx,%eax
    20ff:	a3 c0 67 00 00       	mov    %eax,0x67c0
if (rand_num < 0)
    2104:	a1 c0 67 00 00       	mov    0x67c0,%eax
    2109:	85 c0                	test   %eax,%eax
    210b:	79 0c                	jns    2119 <random+0x37>
{
rand_num *= (-1);
    210d:	a1 c0 67 00 00       	mov    0x67c0,%eax
    2112:	f7 d8                	neg    %eax
    2114:	a3 c0 67 00 00       	mov    %eax,0x67c0
}
return rand_num % 997;
    2119:	8b 0d c0 67 00 00    	mov    0x67c0,%ecx
    211f:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2124:	89 c8                	mov    %ecx,%eax
    2126:	f7 ea                	imul   %edx
    2128:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    212b:	c1 f8 09             	sar    $0x9,%eax
    212e:	89 c2                	mov    %eax,%edx
    2130:	89 c8                	mov    %ecx,%eax
    2132:	c1 f8 1f             	sar    $0x1f,%eax
    2135:	29 c2                	sub    %eax,%edx
    2137:	89 d0                	mov    %edx,%eax
    2139:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    213f:	29 c1                	sub    %eax,%ecx
    2141:	89 c8                	mov    %ecx,%eax
}
    2143:	5d                   	pop    %ebp
    2144:	c3                   	ret    

00002145 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2145:	55                   	push   %ebp
    2146:	89 e5                	mov    %esp,%ebp
    2148:	53                   	push   %ebx
    2149:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    214c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2153:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2157:	74 17                	je     2170 <sprintint+0x2b>
    2159:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    215d:	79 11                	jns    2170 <sprintint+0x2b>
        neg = 1;
    215f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2166:	8b 45 10             	mov    0x10(%ebp),%eax
    2169:	f7 d8                	neg    %eax
    216b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    216e:	eb 06                	jmp    2176 <sprintint+0x31>
    } else {
        x = xx;
    2170:	8b 45 10             	mov    0x10(%ebp),%eax
    2173:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2176:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    217d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2180:	8d 41 01             	lea    0x1(%ecx),%eax
    2183:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2186:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2189:	8b 45 f0             	mov    -0x10(%ebp),%eax
    218c:	ba 00 00 00 00       	mov    $0x0,%edx
    2191:	f7 f3                	div    %ebx
    2193:	89 d0                	mov    %edx,%eax
    2195:	0f b6 80 c4 67 00 00 	movzbl 0x67c4(%eax),%eax
    219c:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    21a0:	8b 5d 14             	mov    0x14(%ebp),%ebx
    21a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21a6:	ba 00 00 00 00       	mov    $0x0,%edx
    21ab:	f7 f3                	div    %ebx
    21ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
    21b0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    21b4:	75 c7                	jne    217d <sprintint+0x38>
    if(neg)
    21b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    21ba:	74 0e                	je     21ca <sprintint+0x85>
        buf[i++] = '-';
    21bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21bf:	8d 50 01             	lea    0x1(%eax),%edx
    21c2:	89 55 f8             	mov    %edx,-0x8(%ebp)
    21c5:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    21ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21cd:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    21d0:	eb 1b                	jmp    21ed <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    21d2:	8b 45 0c             	mov    0xc(%ebp),%eax
    21d5:	8b 00                	mov    (%eax),%eax
    21d7:	8d 48 01             	lea    0x1(%eax),%ecx
    21da:	8b 55 0c             	mov    0xc(%ebp),%edx
    21dd:	89 0a                	mov    %ecx,(%edx)
    21df:	89 c2                	mov    %eax,%edx
    21e1:	8b 45 08             	mov    0x8(%ebp),%eax
    21e4:	01 d0                	add    %edx,%eax
    21e6:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    21e9:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    21ed:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    21f1:	7f df                	jg     21d2 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    21f3:	eb 21                	jmp    2216 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    21f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    21f8:	8b 00                	mov    (%eax),%eax
    21fa:	8d 48 01             	lea    0x1(%eax),%ecx
    21fd:	8b 55 0c             	mov    0xc(%ebp),%edx
    2200:	89 0a                	mov    %ecx,(%edx)
    2202:	89 c2                	mov    %eax,%edx
    2204:	8b 45 08             	mov    0x8(%ebp),%eax
    2207:	01 c2                	add    %eax,%edx
    2209:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    220c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    220f:	01 c8                	add    %ecx,%eax
    2211:	0f b6 00             	movzbl (%eax),%eax
    2214:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2216:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    221a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    221e:	79 d5                	jns    21f5 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2220:	90                   	nop
    2221:	83 c4 20             	add    $0x20,%esp
    2224:	5b                   	pop    %ebx
    2225:	5d                   	pop    %ebp
    2226:	c3                   	ret    

00002227 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2227:	55                   	push   %ebp
    2228:	89 e5                	mov    %esp,%ebp
    222a:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    222d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2234:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    223b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2242:	8d 45 0c             	lea    0xc(%ebp),%eax
    2245:	83 c0 04             	add    $0x4,%eax
    2248:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    224b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2252:	e9 d9 01 00 00       	jmp    2430 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2257:	8b 55 0c             	mov    0xc(%ebp),%edx
    225a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    225d:	01 d0                	add    %edx,%eax
    225f:	0f b6 00             	movzbl (%eax),%eax
    2262:	0f be c0             	movsbl %al,%eax
    2265:	25 ff 00 00 00       	and    $0xff,%eax
    226a:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    226d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2271:	75 2c                	jne    229f <sprintf+0x78>
            if(c == '%'){
    2273:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2277:	75 0c                	jne    2285 <sprintf+0x5e>
                state = '%';
    2279:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2280:	e9 a7 01 00 00       	jmp    242c <sprintf+0x205>
            } else {
                dst[j++] = c;
    2285:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2288:	8d 50 01             	lea    0x1(%eax),%edx
    228b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    228e:	89 c2                	mov    %eax,%edx
    2290:	8b 45 08             	mov    0x8(%ebp),%eax
    2293:	01 d0                	add    %edx,%eax
    2295:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2298:	88 10                	mov    %dl,(%eax)
    229a:	e9 8d 01 00 00       	jmp    242c <sprintf+0x205>
            }
        } else if(state == '%'){
    229f:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    22a3:	0f 85 83 01 00 00    	jne    242c <sprintf+0x205>
            if(c == 'd'){
    22a9:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    22ad:	75 4c                	jne    22fb <sprintf+0xd4>
                buf[bi] = '\0';
    22af:	8d 55 ce             	lea    -0x32(%ebp),%edx
    22b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22b5:	01 d0                	add    %edx,%eax
    22b7:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    22ba:	83 ec 0c             	sub    $0xc,%esp
    22bd:	8d 45 ce             	lea    -0x32(%ebp),%eax
    22c0:	50                   	push   %eax
    22c1:	e8 2b df ff ff       	call   1f1 <atoi>
    22c6:	83 c4 10             	add    $0x10,%esp
    22c9:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    22cc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    22d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22d6:	8b 00                	mov    (%eax),%eax
    22d8:	83 ec 08             	sub    $0x8,%esp
    22db:	ff 75 d8             	pushl  -0x28(%ebp)
    22de:	6a 01                	push   $0x1
    22e0:	6a 0a                	push   $0xa
    22e2:	50                   	push   %eax
    22e3:	8d 45 c8             	lea    -0x38(%ebp),%eax
    22e6:	50                   	push   %eax
    22e7:	ff 75 08             	pushl  0x8(%ebp)
    22ea:	e8 56 fe ff ff       	call   2145 <sprintint>
    22ef:	83 c4 20             	add    $0x20,%esp
                ap++;
    22f2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    22f6:	e9 2a 01 00 00       	jmp    2425 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    22fb:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    22ff:	74 06                	je     2307 <sprintf+0xe0>
    2301:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2305:	75 4c                	jne    2353 <sprintf+0x12c>
                buf[bi] = '\0';
    2307:	8d 55 ce             	lea    -0x32(%ebp),%edx
    230a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    230d:	01 d0                	add    %edx,%eax
    230f:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2312:	83 ec 0c             	sub    $0xc,%esp
    2315:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2318:	50                   	push   %eax
    2319:	e8 d3 de ff ff       	call   1f1 <atoi>
    231e:	83 c4 10             	add    $0x10,%esp
    2321:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2324:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    232b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    232e:	8b 00                	mov    (%eax),%eax
    2330:	83 ec 08             	sub    $0x8,%esp
    2333:	ff 75 dc             	pushl  -0x24(%ebp)
    2336:	6a 00                	push   $0x0
    2338:	6a 10                	push   $0x10
    233a:	50                   	push   %eax
    233b:	8d 45 c8             	lea    -0x38(%ebp),%eax
    233e:	50                   	push   %eax
    233f:	ff 75 08             	pushl  0x8(%ebp)
    2342:	e8 fe fd ff ff       	call   2145 <sprintint>
    2347:	83 c4 20             	add    $0x20,%esp
                ap++;
    234a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    234e:	e9 d2 00 00 00       	jmp    2425 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2353:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2357:	75 46                	jne    239f <sprintf+0x178>
                s = (char*)*ap;
    2359:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    235c:	8b 00                	mov    (%eax),%eax
    235e:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2361:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2365:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2369:	75 25                	jne    2390 <sprintf+0x169>
                    s = "(null)";
    236b:	c7 45 f4 ec 25 00 00 	movl   $0x25ec,-0xc(%ebp)
                while(*s != 0){
    2372:	eb 1c                	jmp    2390 <sprintf+0x169>
                    dst[j++] = *s;
    2374:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2377:	8d 50 01             	lea    0x1(%eax),%edx
    237a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    237d:	89 c2                	mov    %eax,%edx
    237f:	8b 45 08             	mov    0x8(%ebp),%eax
    2382:	01 c2                	add    %eax,%edx
    2384:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2387:	0f b6 00             	movzbl (%eax),%eax
    238a:	88 02                	mov    %al,(%edx)
                    s++;
    238c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2390:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2393:	0f b6 00             	movzbl (%eax),%eax
    2396:	84 c0                	test   %al,%al
    2398:	75 da                	jne    2374 <sprintf+0x14d>
    239a:	e9 86 00 00 00       	jmp    2425 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    239f:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    23a3:	75 1d                	jne    23c2 <sprintf+0x19b>
                dst[j++] = *ap;
    23a5:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23a8:	8d 50 01             	lea    0x1(%eax),%edx
    23ab:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23ae:	89 c2                	mov    %eax,%edx
    23b0:	8b 45 08             	mov    0x8(%ebp),%eax
    23b3:	01 c2                	add    %eax,%edx
    23b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23b8:	8b 00                	mov    (%eax),%eax
    23ba:	88 02                	mov    %al,(%edx)
                ap++;
    23bc:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    23c0:	eb 63                	jmp    2425 <sprintf+0x1fe>
            } else if(c == '%'){
    23c2:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    23c6:	75 17                	jne    23df <sprintf+0x1b8>
                dst[j++] = c;
    23c8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23cb:	8d 50 01             	lea    0x1(%eax),%edx
    23ce:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23d1:	89 c2                	mov    %eax,%edx
    23d3:	8b 45 08             	mov    0x8(%ebp),%eax
    23d6:	01 d0                	add    %edx,%eax
    23d8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    23db:	88 10                	mov    %dl,(%eax)
    23dd:	eb 46                	jmp    2425 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    23df:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    23e3:	7e 18                	jle    23fd <sprintf+0x1d6>
    23e5:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    23e9:	7f 12                	jg     23fd <sprintf+0x1d6>
            {
                buf[bi++] = c;
    23eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23ee:	8d 50 01             	lea    0x1(%eax),%edx
    23f1:	89 55 f0             	mov    %edx,-0x10(%ebp)
    23f4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    23f7:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    23fb:	eb 2f                	jmp    242c <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    23fd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2400:	8d 50 01             	lea    0x1(%eax),%edx
    2403:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2406:	89 c2                	mov    %eax,%edx
    2408:	8b 45 08             	mov    0x8(%ebp),%eax
    240b:	01 d0                	add    %edx,%eax
    240d:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2410:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2413:	8d 50 01             	lea    0x1(%eax),%edx
    2416:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2419:	89 c2                	mov    %eax,%edx
    241b:	8b 45 08             	mov    0x8(%ebp),%eax
    241e:	01 d0                	add    %edx,%eax
    2420:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2423:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2425:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    242c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2430:	8b 55 0c             	mov    0xc(%ebp),%edx
    2433:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2436:	01 d0                	add    %edx,%eax
    2438:	0f b6 00             	movzbl (%eax),%eax
    243b:	84 c0                	test   %al,%al
    243d:	0f 85 14 fe ff ff    	jne    2257 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2443:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2446:	8d 50 01             	lea    0x1(%eax),%edx
    2449:	89 55 c8             	mov    %edx,-0x38(%ebp)
    244c:	89 c2                	mov    %eax,%edx
    244e:	8b 45 08             	mov    0x8(%ebp),%eax
    2451:	01 d0                	add    %edx,%eax
    2453:	c6 00 00             	movb   $0x0,(%eax)
}
    2456:	90                   	nop
    2457:	c9                   	leave  
    2458:	c3                   	ret    
