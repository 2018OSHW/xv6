
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

0000035b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     35b:	55                   	push   %ebp
     35c:	89 e5                	mov    %esp,%ebp
     35e:	83 ec 18             	sub    $0x18,%esp
     361:	8b 45 0c             	mov    0xc(%ebp),%eax
     364:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     367:	83 ec 04             	sub    $0x4,%esp
     36a:	6a 01                	push   $0x1
     36c:	8d 45 f4             	lea    -0xc(%ebp),%eax
     36f:	50                   	push   %eax
     370:	ff 75 08             	pushl  0x8(%ebp)
     373:	e8 2b ff ff ff       	call   2a3 <write>
     378:	83 c4 10             	add    $0x10,%esp
}
     37b:	90                   	nop
     37c:	c9                   	leave  
     37d:	c3                   	ret    

0000037e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     37e:	55                   	push   %ebp
     37f:	89 e5                	mov    %esp,%ebp
     381:	53                   	push   %ebx
     382:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     385:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     38c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     390:	74 17                	je     3a9 <printint+0x2b>
     392:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     396:	79 11                	jns    3a9 <printint+0x2b>
    neg = 1;
     398:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     39f:	8b 45 0c             	mov    0xc(%ebp),%eax
     3a2:	f7 d8                	neg    %eax
     3a4:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3a7:	eb 06                	jmp    3af <printint+0x31>
  } else {
    x = xx;
     3a9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3b6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3b9:	8d 41 01             	lea    0x1(%ecx),%eax
     3bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3bf:	8b 5d 10             	mov    0x10(%ebp),%ebx
     3c2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3c5:	ba 00 00 00 00       	mov    $0x0,%edx
     3ca:	f7 f3                	div    %ebx
     3cc:	89 d0                	mov    %edx,%eax
     3ce:	0f b6 80 c4 28 00 00 	movzbl 0x28c4(%eax),%eax
     3d5:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     3d9:	8b 5d 10             	mov    0x10(%ebp),%ebx
     3dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3df:	ba 00 00 00 00       	mov    $0x0,%edx
     3e4:	f7 f3                	div    %ebx
     3e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3e9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     3ed:	75 c7                	jne    3b6 <printint+0x38>
  if(neg)
     3ef:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3f3:	74 2d                	je     422 <printint+0xa4>
    buf[i++] = '-';
     3f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3f8:	8d 50 01             	lea    0x1(%eax),%edx
     3fb:	89 55 f4             	mov    %edx,-0xc(%ebp)
     3fe:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     403:	eb 1d                	jmp    422 <printint+0xa4>
    putc(fd, buf[i]);
     405:	8d 55 dc             	lea    -0x24(%ebp),%edx
     408:	8b 45 f4             	mov    -0xc(%ebp),%eax
     40b:	01 d0                	add    %edx,%eax
     40d:	0f b6 00             	movzbl (%eax),%eax
     410:	0f be c0             	movsbl %al,%eax
     413:	83 ec 08             	sub    $0x8,%esp
     416:	50                   	push   %eax
     417:	ff 75 08             	pushl  0x8(%ebp)
     41a:	e8 3c ff ff ff       	call   35b <putc>
     41f:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     422:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     426:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     42a:	79 d9                	jns    405 <printint+0x87>
    putc(fd, buf[i]);
}
     42c:	90                   	nop
     42d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     430:	c9                   	leave  
     431:	c3                   	ret    

00000432 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     432:	55                   	push   %ebp
     433:	89 e5                	mov    %esp,%ebp
     435:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     438:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     43f:	8d 45 0c             	lea    0xc(%ebp),%eax
     442:	83 c0 04             	add    $0x4,%eax
     445:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     448:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     44f:	e9 59 01 00 00       	jmp    5ad <printf+0x17b>
    c = fmt[i] & 0xff;
     454:	8b 55 0c             	mov    0xc(%ebp),%edx
     457:	8b 45 f0             	mov    -0x10(%ebp),%eax
     45a:	01 d0                	add    %edx,%eax
     45c:	0f b6 00             	movzbl (%eax),%eax
     45f:	0f be c0             	movsbl %al,%eax
     462:	25 ff 00 00 00       	and    $0xff,%eax
     467:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     46a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     46e:	75 2c                	jne    49c <printf+0x6a>
      if(c == '%'){
     470:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     474:	75 0c                	jne    482 <printf+0x50>
        state = '%';
     476:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     47d:	e9 27 01 00 00       	jmp    5a9 <printf+0x177>
      } else {
        putc(fd, c);
     482:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     485:	0f be c0             	movsbl %al,%eax
     488:	83 ec 08             	sub    $0x8,%esp
     48b:	50                   	push   %eax
     48c:	ff 75 08             	pushl  0x8(%ebp)
     48f:	e8 c7 fe ff ff       	call   35b <putc>
     494:	83 c4 10             	add    $0x10,%esp
     497:	e9 0d 01 00 00       	jmp    5a9 <printf+0x177>
      }
    } else if(state == '%'){
     49c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4a0:	0f 85 03 01 00 00    	jne    5a9 <printf+0x177>
      if(c == 'd'){
     4a6:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4aa:	75 1e                	jne    4ca <printf+0x98>
        printint(fd, *ap, 10, 1);
     4ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4af:	8b 00                	mov    (%eax),%eax
     4b1:	6a 01                	push   $0x1
     4b3:	6a 0a                	push   $0xa
     4b5:	50                   	push   %eax
     4b6:	ff 75 08             	pushl  0x8(%ebp)
     4b9:	e8 c0 fe ff ff       	call   37e <printint>
     4be:	83 c4 10             	add    $0x10,%esp
        ap++;
     4c1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4c5:	e9 d8 00 00 00       	jmp    5a2 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     4ca:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     4ce:	74 06                	je     4d6 <printf+0xa4>
     4d0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     4d4:	75 1e                	jne    4f4 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     4d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4d9:	8b 00                	mov    (%eax),%eax
     4db:	6a 00                	push   $0x0
     4dd:	6a 10                	push   $0x10
     4df:	50                   	push   %eax
     4e0:	ff 75 08             	pushl  0x8(%ebp)
     4e3:	e8 96 fe ff ff       	call   37e <printint>
     4e8:	83 c4 10             	add    $0x10,%esp
        ap++;
     4eb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4ef:	e9 ae 00 00 00       	jmp    5a2 <printf+0x170>
      } else if(c == 's'){
     4f4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     4f8:	75 43                	jne    53d <printf+0x10b>
        s = (char*)*ap;
     4fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4fd:	8b 00                	mov    (%eax),%eax
     4ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     502:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     506:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     50a:	75 25                	jne    531 <printf+0xff>
          s = "(null)";
     50c:	c7 45 f4 f4 21 00 00 	movl   $0x21f4,-0xc(%ebp)
        while(*s != 0){
     513:	eb 1c                	jmp    531 <printf+0xff>
          putc(fd, *s);
     515:	8b 45 f4             	mov    -0xc(%ebp),%eax
     518:	0f b6 00             	movzbl (%eax),%eax
     51b:	0f be c0             	movsbl %al,%eax
     51e:	83 ec 08             	sub    $0x8,%esp
     521:	50                   	push   %eax
     522:	ff 75 08             	pushl  0x8(%ebp)
     525:	e8 31 fe ff ff       	call   35b <putc>
     52a:	83 c4 10             	add    $0x10,%esp
          s++;
     52d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     531:	8b 45 f4             	mov    -0xc(%ebp),%eax
     534:	0f b6 00             	movzbl (%eax),%eax
     537:	84 c0                	test   %al,%al
     539:	75 da                	jne    515 <printf+0xe3>
     53b:	eb 65                	jmp    5a2 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     53d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     541:	75 1d                	jne    560 <printf+0x12e>
        putc(fd, *ap);
     543:	8b 45 e8             	mov    -0x18(%ebp),%eax
     546:	8b 00                	mov    (%eax),%eax
     548:	0f be c0             	movsbl %al,%eax
     54b:	83 ec 08             	sub    $0x8,%esp
     54e:	50                   	push   %eax
     54f:	ff 75 08             	pushl  0x8(%ebp)
     552:	e8 04 fe ff ff       	call   35b <putc>
     557:	83 c4 10             	add    $0x10,%esp
        ap++;
     55a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     55e:	eb 42                	jmp    5a2 <printf+0x170>
      } else if(c == '%'){
     560:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     564:	75 17                	jne    57d <printf+0x14b>
        putc(fd, c);
     566:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     569:	0f be c0             	movsbl %al,%eax
     56c:	83 ec 08             	sub    $0x8,%esp
     56f:	50                   	push   %eax
     570:	ff 75 08             	pushl  0x8(%ebp)
     573:	e8 e3 fd ff ff       	call   35b <putc>
     578:	83 c4 10             	add    $0x10,%esp
     57b:	eb 25                	jmp    5a2 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     57d:	83 ec 08             	sub    $0x8,%esp
     580:	6a 25                	push   $0x25
     582:	ff 75 08             	pushl  0x8(%ebp)
     585:	e8 d1 fd ff ff       	call   35b <putc>
     58a:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     58d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     590:	0f be c0             	movsbl %al,%eax
     593:	83 ec 08             	sub    $0x8,%esp
     596:	50                   	push   %eax
     597:	ff 75 08             	pushl  0x8(%ebp)
     59a:	e8 bc fd ff ff       	call   35b <putc>
     59f:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5a2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5a9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5ad:	8b 55 0c             	mov    0xc(%ebp),%edx
     5b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5b3:	01 d0                	add    %edx,%eax
     5b5:	0f b6 00             	movzbl (%eax),%eax
     5b8:	84 c0                	test   %al,%al
     5ba:	0f 85 94 fe ff ff    	jne    454 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     5c0:	90                   	nop
     5c1:	c9                   	leave  
     5c2:	c3                   	ret    

000005c3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     5c3:	55                   	push   %ebp
     5c4:	89 e5                	mov    %esp,%ebp
     5c6:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     5c9:	8b 45 08             	mov    0x8(%ebp),%eax
     5cc:	83 e8 08             	sub    $0x8,%eax
     5cf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     5d2:	a1 f8 28 00 00       	mov    0x28f8,%eax
     5d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
     5da:	eb 24                	jmp    600 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     5dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5df:	8b 00                	mov    (%eax),%eax
     5e1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     5e4:	77 12                	ja     5f8 <free+0x35>
     5e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     5e9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     5ec:	77 24                	ja     612 <free+0x4f>
     5ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5f1:	8b 00                	mov    (%eax),%eax
     5f3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     5f6:	77 1a                	ja     612 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     5f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5fb:	8b 00                	mov    (%eax),%eax
     5fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
     600:	8b 45 f8             	mov    -0x8(%ebp),%eax
     603:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     606:	76 d4                	jbe    5dc <free+0x19>
     608:	8b 45 fc             	mov    -0x4(%ebp),%eax
     60b:	8b 00                	mov    (%eax),%eax
     60d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     610:	76 ca                	jbe    5dc <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     612:	8b 45 f8             	mov    -0x8(%ebp),%eax
     615:	8b 40 04             	mov    0x4(%eax),%eax
     618:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     61f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     622:	01 c2                	add    %eax,%edx
     624:	8b 45 fc             	mov    -0x4(%ebp),%eax
     627:	8b 00                	mov    (%eax),%eax
     629:	39 c2                	cmp    %eax,%edx
     62b:	75 24                	jne    651 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     62d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     630:	8b 50 04             	mov    0x4(%eax),%edx
     633:	8b 45 fc             	mov    -0x4(%ebp),%eax
     636:	8b 00                	mov    (%eax),%eax
     638:	8b 40 04             	mov    0x4(%eax),%eax
     63b:	01 c2                	add    %eax,%edx
     63d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     640:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     643:	8b 45 fc             	mov    -0x4(%ebp),%eax
     646:	8b 00                	mov    (%eax),%eax
     648:	8b 10                	mov    (%eax),%edx
     64a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     64d:	89 10                	mov    %edx,(%eax)
     64f:	eb 0a                	jmp    65b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     651:	8b 45 fc             	mov    -0x4(%ebp),%eax
     654:	8b 10                	mov    (%eax),%edx
     656:	8b 45 f8             	mov    -0x8(%ebp),%eax
     659:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     65b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     65e:	8b 40 04             	mov    0x4(%eax),%eax
     661:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     668:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66b:	01 d0                	add    %edx,%eax
     66d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     670:	75 20                	jne    692 <free+0xcf>
    p->s.size += bp->s.size;
     672:	8b 45 fc             	mov    -0x4(%ebp),%eax
     675:	8b 50 04             	mov    0x4(%eax),%edx
     678:	8b 45 f8             	mov    -0x8(%ebp),%eax
     67b:	8b 40 04             	mov    0x4(%eax),%eax
     67e:	01 c2                	add    %eax,%edx
     680:	8b 45 fc             	mov    -0x4(%ebp),%eax
     683:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     686:	8b 45 f8             	mov    -0x8(%ebp),%eax
     689:	8b 10                	mov    (%eax),%edx
     68b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68e:	89 10                	mov    %edx,(%eax)
     690:	eb 08                	jmp    69a <free+0xd7>
  } else
    p->s.ptr = bp;
     692:	8b 45 fc             	mov    -0x4(%ebp),%eax
     695:	8b 55 f8             	mov    -0x8(%ebp),%edx
     698:	89 10                	mov    %edx,(%eax)
  freep = p;
     69a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69d:	a3 f8 28 00 00       	mov    %eax,0x28f8
}
     6a2:	90                   	nop
     6a3:	c9                   	leave  
     6a4:	c3                   	ret    

000006a5 <morecore>:

static Header*
morecore(uint nu)
{
     6a5:	55                   	push   %ebp
     6a6:	89 e5                	mov    %esp,%ebp
     6a8:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6ab:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6b2:	77 07                	ja     6bb <morecore+0x16>
    nu = 4096;
     6b4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     6bb:	8b 45 08             	mov    0x8(%ebp),%eax
     6be:	c1 e0 03             	shl    $0x3,%eax
     6c1:	83 ec 0c             	sub    $0xc,%esp
     6c4:	50                   	push   %eax
     6c5:	e8 41 fc ff ff       	call   30b <sbrk>
     6ca:	83 c4 10             	add    $0x10,%esp
     6cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     6d0:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     6d4:	75 07                	jne    6dd <morecore+0x38>
    return 0;
     6d6:	b8 00 00 00 00       	mov    $0x0,%eax
     6db:	eb 26                	jmp    703 <morecore+0x5e>
  hp = (Header*)p;
     6dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     6e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6e6:	8b 55 08             	mov    0x8(%ebp),%edx
     6e9:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     6ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6ef:	83 c0 08             	add    $0x8,%eax
     6f2:	83 ec 0c             	sub    $0xc,%esp
     6f5:	50                   	push   %eax
     6f6:	e8 c8 fe ff ff       	call   5c3 <free>
     6fb:	83 c4 10             	add    $0x10,%esp
  return freep;
     6fe:	a1 f8 28 00 00       	mov    0x28f8,%eax
}
     703:	c9                   	leave  
     704:	c3                   	ret    

00000705 <malloc>:

void*
malloc(uint nbytes)
{
     705:	55                   	push   %ebp
     706:	89 e5                	mov    %esp,%ebp
     708:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     70b:	8b 45 08             	mov    0x8(%ebp),%eax
     70e:	83 c0 07             	add    $0x7,%eax
     711:	c1 e8 03             	shr    $0x3,%eax
     714:	83 c0 01             	add    $0x1,%eax
     717:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     71a:	a1 f8 28 00 00       	mov    0x28f8,%eax
     71f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     722:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     726:	75 23                	jne    74b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     728:	c7 45 f0 f0 28 00 00 	movl   $0x28f0,-0x10(%ebp)
     72f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     732:	a3 f8 28 00 00       	mov    %eax,0x28f8
     737:	a1 f8 28 00 00       	mov    0x28f8,%eax
     73c:	a3 f0 28 00 00       	mov    %eax,0x28f0
    base.s.size = 0;
     741:	c7 05 f4 28 00 00 00 	movl   $0x0,0x28f4
     748:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     74b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     74e:	8b 00                	mov    (%eax),%eax
     750:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     753:	8b 45 f4             	mov    -0xc(%ebp),%eax
     756:	8b 40 04             	mov    0x4(%eax),%eax
     759:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     75c:	72 4d                	jb     7ab <malloc+0xa6>
      if(p->s.size == nunits)
     75e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     761:	8b 40 04             	mov    0x4(%eax),%eax
     764:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     767:	75 0c                	jne    775 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     769:	8b 45 f4             	mov    -0xc(%ebp),%eax
     76c:	8b 10                	mov    (%eax),%edx
     76e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     771:	89 10                	mov    %edx,(%eax)
     773:	eb 26                	jmp    79b <malloc+0x96>
      else {
        p->s.size -= nunits;
     775:	8b 45 f4             	mov    -0xc(%ebp),%eax
     778:	8b 40 04             	mov    0x4(%eax),%eax
     77b:	2b 45 ec             	sub    -0x14(%ebp),%eax
     77e:	89 c2                	mov    %eax,%edx
     780:	8b 45 f4             	mov    -0xc(%ebp),%eax
     783:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     786:	8b 45 f4             	mov    -0xc(%ebp),%eax
     789:	8b 40 04             	mov    0x4(%eax),%eax
     78c:	c1 e0 03             	shl    $0x3,%eax
     78f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     792:	8b 45 f4             	mov    -0xc(%ebp),%eax
     795:	8b 55 ec             	mov    -0x14(%ebp),%edx
     798:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     79b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     79e:	a3 f8 28 00 00       	mov    %eax,0x28f8
      return (void*)(p + 1);
     7a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a6:	83 c0 08             	add    $0x8,%eax
     7a9:	eb 3b                	jmp    7e6 <malloc+0xe1>
    }
    if(p == freep)
     7ab:	a1 f8 28 00 00       	mov    0x28f8,%eax
     7b0:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7b3:	75 1e                	jne    7d3 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7b5:	83 ec 0c             	sub    $0xc,%esp
     7b8:	ff 75 ec             	pushl  -0x14(%ebp)
     7bb:	e8 e5 fe ff ff       	call   6a5 <morecore>
     7c0:	83 c4 10             	add    $0x10,%esp
     7c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
     7c6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7ca:	75 07                	jne    7d3 <malloc+0xce>
        return 0;
     7cc:	b8 00 00 00 00       	mov    $0x0,%eax
     7d1:	eb 13                	jmp    7e6 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7dc:	8b 00                	mov    (%eax),%eax
     7de:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     7e1:	e9 6d ff ff ff       	jmp    753 <malloc+0x4e>
}
     7e6:	c9                   	leave  
     7e7:	c3                   	ret    

000007e8 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     7e8:	55                   	push   %ebp
     7e9:	89 e5                	mov    %esp,%ebp
     7eb:	83 ec 1c             	sub    $0x1c,%esp
     7ee:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     7f1:	8b 55 10             	mov    0x10(%ebp),%edx
     7f4:	8b 45 14             	mov    0x14(%ebp),%eax
     7f7:	88 4d ec             	mov    %cl,-0x14(%ebp)
     7fa:	88 55 e8             	mov    %dl,-0x18(%ebp)
     7fd:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     800:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     804:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     807:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     80b:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     80e:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     812:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     815:	8b 45 08             	mov    0x8(%ebp),%eax
     818:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     81c:	66 89 10             	mov    %dx,(%eax)
     81f:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     823:	88 50 02             	mov    %dl,0x2(%eax)
}
     826:	8b 45 08             	mov    0x8(%ebp),%eax
     829:	c9                   	leave  
     82a:	c2 04 00             	ret    $0x4

0000082d <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     82d:	55                   	push   %ebp
     82e:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     830:	8b 45 08             	mov    0x8(%ebp),%eax
     833:	2b 45 10             	sub    0x10(%ebp),%eax
     836:	89 c2                	mov    %eax,%edx
     838:	8b 45 08             	mov    0x8(%ebp),%eax
     83b:	2b 45 10             	sub    0x10(%ebp),%eax
     83e:	0f af d0             	imul   %eax,%edx
     841:	8b 45 0c             	mov    0xc(%ebp),%eax
     844:	2b 45 14             	sub    0x14(%ebp),%eax
     847:	89 c1                	mov    %eax,%ecx
     849:	8b 45 0c             	mov    0xc(%ebp),%eax
     84c:	2b 45 14             	sub    0x14(%ebp),%eax
     84f:	0f af c1             	imul   %ecx,%eax
     852:	01 d0                	add    %edx,%eax
}
     854:	5d                   	pop    %ebp
     855:	c3                   	ret    

00000856 <abs_int>:

static inline int abs_int(int x)
{
     856:	55                   	push   %ebp
     857:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     859:	8b 45 08             	mov    0x8(%ebp),%eax
     85c:	99                   	cltd   
     85d:	89 d0                	mov    %edx,%eax
     85f:	33 45 08             	xor    0x8(%ebp),%eax
     862:	29 d0                	sub    %edx,%eax
}
     864:	5d                   	pop    %ebp
     865:	c3                   	ret    

00000866 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     866:	55                   	push   %ebp
     867:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     869:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     86d:	79 07                	jns    876 <APGetIndex+0x10>
        return X_SMALLER;
     86f:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     874:	eb 40                	jmp    8b6 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     876:	8b 45 08             	mov    0x8(%ebp),%eax
     879:	8b 00                	mov    (%eax),%eax
     87b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     87e:	7f 07                	jg     887 <APGetIndex+0x21>
        return X_BIGGER;
     880:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     885:	eb 2f                	jmp    8b6 <APGetIndex+0x50>
    if (y < 0)
     887:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     88b:	79 07                	jns    894 <APGetIndex+0x2e>
        return Y_SMALLER;
     88d:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     892:	eb 22                	jmp    8b6 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     894:	8b 45 08             	mov    0x8(%ebp),%eax
     897:	8b 40 04             	mov    0x4(%eax),%eax
     89a:	3b 45 10             	cmp    0x10(%ebp),%eax
     89d:	7f 07                	jg     8a6 <APGetIndex+0x40>
        return Y_BIGGER;
     89f:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8a4:	eb 10                	jmp    8b6 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8a6:	8b 45 08             	mov    0x8(%ebp),%eax
     8a9:	8b 00                	mov    (%eax),%eax
     8ab:	0f af 45 10          	imul   0x10(%ebp),%eax
     8af:	89 c2                	mov    %eax,%edx
     8b1:	8b 45 0c             	mov    0xc(%ebp),%eax
     8b4:	01 d0                	add    %edx,%eax
}
     8b6:	5d                   	pop    %ebp
     8b7:	c3                   	ret    

000008b8 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     8b8:	55                   	push   %ebp
     8b9:	89 e5                	mov    %esp,%ebp
     8bb:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     8be:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     8c5:	8b 45 cc             	mov    -0x34(%ebp),%eax
     8c8:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     8cb:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     8d2:	83 ec 08             	sub    $0x8,%esp
     8d5:	6a 00                	push   $0x0
     8d7:	ff 75 0c             	pushl  0xc(%ebp)
     8da:	e8 e4 f9 ff ff       	call   2c3 <open>
     8df:	83 c4 10             	add    $0x10,%esp
     8e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     8e5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     8e9:	79 2e                	jns    919 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     8eb:	83 ec 04             	sub    $0x4,%esp
     8ee:	ff 75 0c             	pushl  0xc(%ebp)
     8f1:	68 fb 21 00 00       	push   $0x21fb
     8f6:	6a 01                	push   $0x1
     8f8:	e8 35 fb ff ff       	call   432 <printf>
     8fd:	83 c4 10             	add    $0x10,%esp
        return bmp;
     900:	8b 45 08             	mov    0x8(%ebp),%eax
     903:	8b 55 c8             	mov    -0x38(%ebp),%edx
     906:	89 10                	mov    %edx,(%eax)
     908:	8b 55 cc             	mov    -0x34(%ebp),%edx
     90b:	89 50 04             	mov    %edx,0x4(%eax)
     90e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     911:	89 50 08             	mov    %edx,0x8(%eax)
     914:	e9 d2 01 00 00       	jmp    aeb <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     919:	83 ec 04             	sub    $0x4,%esp
     91c:	6a 0e                	push   $0xe
     91e:	8d 45 ba             	lea    -0x46(%ebp),%eax
     921:	50                   	push   %eax
     922:	ff 75 ec             	pushl  -0x14(%ebp)
     925:	e8 71 f9 ff ff       	call   29b <read>
     92a:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     92d:	83 ec 04             	sub    $0x4,%esp
     930:	6a 28                	push   $0x28
     932:	8d 45 92             	lea    -0x6e(%ebp),%eax
     935:	50                   	push   %eax
     936:	ff 75 ec             	pushl  -0x14(%ebp)
     939:	e8 5d f9 ff ff       	call   29b <read>
     93e:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     941:	8b 45 96             	mov    -0x6a(%ebp),%eax
     944:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     947:	8b 45 9a             	mov    -0x66(%ebp),%eax
     94a:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     94d:	8b 55 c8             	mov    -0x38(%ebp),%edx
     950:	8b 45 cc             	mov    -0x34(%ebp),%eax
     953:	0f af d0             	imul   %eax,%edx
     956:	89 d0                	mov    %edx,%eax
     958:	01 c0                	add    %eax,%eax
     95a:	01 d0                	add    %edx,%eax
     95c:	83 ec 0c             	sub    $0xc,%esp
     95f:	50                   	push   %eax
     960:	e8 a0 fd ff ff       	call   705 <malloc>
     965:	83 c4 10             	add    $0x10,%esp
     968:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     96b:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     96f:	0f b7 c0             	movzwl %ax,%eax
     972:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     975:	8b 55 c8             	mov    -0x38(%ebp),%edx
     978:	8b 45 e8             	mov    -0x18(%ebp),%eax
     97b:	0f af c2             	imul   %edx,%eax
     97e:	83 c0 1f             	add    $0x1f,%eax
     981:	c1 e8 05             	shr    $0x5,%eax
     984:	c1 e0 02             	shl    $0x2,%eax
     987:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     98a:	8b 55 cc             	mov    -0x34(%ebp),%edx
     98d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     990:	0f af c2             	imul   %edx,%eax
     993:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     996:	8b 45 e0             	mov    -0x20(%ebp),%eax
     999:	83 ec 0c             	sub    $0xc,%esp
     99c:	50                   	push   %eax
     99d:	e8 63 fd ff ff       	call   705 <malloc>
     9a2:	83 c4 10             	add    $0x10,%esp
     9a5:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9a8:	83 ec 04             	sub    $0x4,%esp
     9ab:	ff 75 e0             	pushl  -0x20(%ebp)
     9ae:	ff 75 dc             	pushl  -0x24(%ebp)
     9b1:	ff 75 ec             	pushl  -0x14(%ebp)
     9b4:	e8 e2 f8 ff ff       	call   29b <read>
     9b9:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     9bc:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9c0:	66 c1 e8 03          	shr    $0x3,%ax
     9c4:	0f b7 c0             	movzwl %ax,%eax
     9c7:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     9ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     9d1:	e9 e5 00 00 00       	jmp    abb <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     9d6:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9dc:	29 c2                	sub    %eax,%edx
     9de:	89 d0                	mov    %edx,%eax
     9e0:	8d 50 ff             	lea    -0x1(%eax),%edx
     9e3:	8b 45 c8             	mov    -0x38(%ebp),%eax
     9e6:	0f af c2             	imul   %edx,%eax
     9e9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     9ec:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     9f3:	e9 b1 00 00 00       	jmp    aa9 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     9f8:	8b 55 d0             	mov    -0x30(%ebp),%edx
     9fb:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     9fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a01:	01 c8                	add    %ecx,%eax
     a03:	89 c1                	mov    %eax,%ecx
     a05:	89 c8                	mov    %ecx,%eax
     a07:	01 c0                	add    %eax,%eax
     a09:	01 c8                	add    %ecx,%eax
     a0b:	01 c2                	add    %eax,%edx
     a0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a10:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a14:	89 c1                	mov    %eax,%ecx
     a16:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a19:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a1d:	01 c1                	add    %eax,%ecx
     a1f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a22:	01 c8                	add    %ecx,%eax
     a24:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a27:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a2a:	01 c8                	add    %ecx,%eax
     a2c:	0f b6 00             	movzbl (%eax),%eax
     a2f:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a32:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a35:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a38:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a3b:	01 c8                	add    %ecx,%eax
     a3d:	89 c1                	mov    %eax,%ecx
     a3f:	89 c8                	mov    %ecx,%eax
     a41:	01 c0                	add    %eax,%eax
     a43:	01 c8                	add    %ecx,%eax
     a45:	01 c2                	add    %eax,%edx
     a47:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a4a:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a4e:	89 c1                	mov    %eax,%ecx
     a50:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a53:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a57:	01 c1                	add    %eax,%ecx
     a59:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a5c:	01 c8                	add    %ecx,%eax
     a5e:	8d 48 fe             	lea    -0x2(%eax),%ecx
     a61:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a64:	01 c8                	add    %ecx,%eax
     a66:	0f b6 00             	movzbl (%eax),%eax
     a69:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     a6c:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a6f:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a72:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a75:	01 c8                	add    %ecx,%eax
     a77:	89 c1                	mov    %eax,%ecx
     a79:	89 c8                	mov    %ecx,%eax
     a7b:	01 c0                	add    %eax,%eax
     a7d:	01 c8                	add    %ecx,%eax
     a7f:	01 c2                	add    %eax,%edx
     a81:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a84:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a88:	89 c1                	mov    %eax,%ecx
     a8a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a8d:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a91:	01 c1                	add    %eax,%ecx
     a93:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a96:	01 c8                	add    %ecx,%eax
     a98:	8d 48 fd             	lea    -0x3(%eax),%ecx
     a9b:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a9e:	01 c8                	add    %ecx,%eax
     aa0:	0f b6 00             	movzbl (%eax),%eax
     aa3:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     aa5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     aa9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     aac:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aaf:	39 c2                	cmp    %eax,%edx
     ab1:	0f 87 41 ff ff ff    	ja     9f8 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     ab7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     abb:	8b 55 cc             	mov    -0x34(%ebp),%edx
     abe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac1:	39 c2                	cmp    %eax,%edx
     ac3:	0f 87 0d ff ff ff    	ja     9d6 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     ac9:	83 ec 0c             	sub    $0xc,%esp
     acc:	ff 75 ec             	pushl  -0x14(%ebp)
     acf:	e8 d7 f7 ff ff       	call   2ab <close>
     ad4:	83 c4 10             	add    $0x10,%esp
    return bmp;
     ad7:	8b 45 08             	mov    0x8(%ebp),%eax
     ada:	8b 55 c8             	mov    -0x38(%ebp),%edx
     add:	89 10                	mov    %edx,(%eax)
     adf:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ae2:	89 50 04             	mov    %edx,0x4(%eax)
     ae5:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ae8:	89 50 08             	mov    %edx,0x8(%eax)
}
     aeb:	8b 45 08             	mov    0x8(%ebp),%eax
     aee:	c9                   	leave  
     aef:	c2 04 00             	ret    $0x4

00000af2 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     af2:	55                   	push   %ebp
     af3:	89 e5                	mov    %esp,%ebp
     af5:	53                   	push   %ebx
     af6:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     af9:	83 ec 0c             	sub    $0xc,%esp
     afc:	6a 1c                	push   $0x1c
     afe:	e8 02 fc ff ff       	call   705 <malloc>
     b03:	83 c4 10             	add    $0x10,%esp
     b06:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b09:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b0c:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b13:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b16:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b19:	6a 0c                	push   $0xc
     b1b:	6a 0c                	push   $0xc
     b1d:	6a 0c                	push   $0xc
     b1f:	50                   	push   %eax
     b20:	e8 c3 fc ff ff       	call   7e8 <RGB>
     b25:	83 c4 0c             	add    $0xc,%esp
     b28:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b2c:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b30:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b34:	88 43 15             	mov    %al,0x15(%ebx)
     b37:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b3d:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b41:	66 89 48 10          	mov    %cx,0x10(%eax)
     b45:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b49:	88 50 12             	mov    %dl,0x12(%eax)
     b4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b4f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b52:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     b56:	66 89 48 08          	mov    %cx,0x8(%eax)
     b5a:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     b5e:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     b61:	8b 45 08             	mov    0x8(%ebp),%eax
     b64:	89 c2                	mov    %eax,%edx
     b66:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b69:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     b6b:	8b 45 0c             	mov    0xc(%ebp),%eax
     b6e:	89 c2                	mov    %eax,%edx
     b70:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b73:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     b76:	8b 55 10             	mov    0x10(%ebp),%edx
     b79:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b7c:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     b7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     b82:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b85:	c9                   	leave  
     b86:	c3                   	ret    

00000b87 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     b87:	55                   	push   %ebp
     b88:	89 e5                	mov    %esp,%ebp
     b8a:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     b8d:	8b 45 0c             	mov    0xc(%ebp),%eax
     b90:	8b 50 08             	mov    0x8(%eax),%edx
     b93:	89 55 f8             	mov    %edx,-0x8(%ebp)
     b96:	8b 40 0c             	mov    0xc(%eax),%eax
     b99:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     b9c:	8b 45 0c             	mov    0xc(%ebp),%eax
     b9f:	8b 55 10             	mov    0x10(%ebp),%edx
     ba2:	89 50 08             	mov    %edx,0x8(%eax)
     ba5:	8b 55 14             	mov    0x14(%ebp),%edx
     ba8:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     bab:	8b 45 08             	mov    0x8(%ebp),%eax
     bae:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bb1:	89 10                	mov    %edx,(%eax)
     bb3:	8b 55 fc             	mov    -0x4(%ebp),%edx
     bb6:	89 50 04             	mov    %edx,0x4(%eax)
}
     bb9:	8b 45 08             	mov    0x8(%ebp),%eax
     bbc:	c9                   	leave  
     bbd:	c2 04 00             	ret    $0x4

00000bc0 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     bc0:	55                   	push   %ebp
     bc1:	89 e5                	mov    %esp,%ebp
     bc3:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     bc6:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc9:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     bcd:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     bd1:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     bd5:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     bd8:	8b 45 0c             	mov    0xc(%ebp),%eax
     bdb:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     bdf:	66 89 50 10          	mov    %dx,0x10(%eax)
     be3:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     be7:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     bea:	8b 45 08             	mov    0x8(%ebp),%eax
     bed:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     bf1:	66 89 10             	mov    %dx,(%eax)
     bf4:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     bf8:	88 50 02             	mov    %dl,0x2(%eax)
}
     bfb:	8b 45 08             	mov    0x8(%ebp),%eax
     bfe:	c9                   	leave  
     bff:	c2 04 00             	ret    $0x4

00000c02 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c02:	55                   	push   %ebp
     c03:	89 e5                	mov    %esp,%ebp
     c05:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c08:	8b 45 08             	mov    0x8(%ebp),%eax
     c0b:	8b 40 0c             	mov    0xc(%eax),%eax
     c0e:	89 c2                	mov    %eax,%edx
     c10:	c1 ea 1f             	shr    $0x1f,%edx
     c13:	01 d0                	add    %edx,%eax
     c15:	d1 f8                	sar    %eax
     c17:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c1d:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c21:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c24:	8b 45 10             	mov    0x10(%ebp),%eax
     c27:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c2a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c2d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c31:	0f 89 98 00 00 00    	jns    ccf <APDrawPoint+0xcd>
        i = 0;
     c37:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c3e:	e9 8c 00 00 00       	jmp    ccf <APDrawPoint+0xcd>
    {
        j = x - off;
     c43:	8b 45 0c             	mov    0xc(%ebp),%eax
     c46:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c49:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     c4c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     c50:	79 69                	jns    cbb <APDrawPoint+0xb9>
            j = 0;
     c52:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     c59:	eb 60                	jmp    cbb <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     c5b:	ff 75 fc             	pushl  -0x4(%ebp)
     c5e:	ff 75 f8             	pushl  -0x8(%ebp)
     c61:	ff 75 08             	pushl  0x8(%ebp)
     c64:	e8 fd fb ff ff       	call   866 <APGetIndex>
     c69:	83 c4 0c             	add    $0xc,%esp
     c6c:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     c6f:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     c73:	74 55                	je     cca <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     c75:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     c79:	74 67                	je     ce2 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     c7b:	ff 75 10             	pushl  0x10(%ebp)
     c7e:	ff 75 0c             	pushl  0xc(%ebp)
     c81:	ff 75 fc             	pushl  -0x4(%ebp)
     c84:	ff 75 f8             	pushl  -0x8(%ebp)
     c87:	e8 a1 fb ff ff       	call   82d <distance_2>
     c8c:	83 c4 10             	add    $0x10,%esp
     c8f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     c92:	7f 23                	jg     cb7 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     c94:	8b 45 08             	mov    0x8(%ebp),%eax
     c97:	8b 48 18             	mov    0x18(%eax),%ecx
     c9a:	8b 55 ec             	mov    -0x14(%ebp),%edx
     c9d:	89 d0                	mov    %edx,%eax
     c9f:	01 c0                	add    %eax,%eax
     ca1:	01 d0                	add    %edx,%eax
     ca3:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     ca6:	8b 45 08             	mov    0x8(%ebp),%eax
     ca9:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     cad:	66 89 0a             	mov    %cx,(%edx)
     cb0:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     cb4:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     cb7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     cbb:	8b 55 0c             	mov    0xc(%ebp),%edx
     cbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc1:	01 d0                	add    %edx,%eax
     cc3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     cc6:	7d 93                	jge    c5b <APDrawPoint+0x59>
     cc8:	eb 01                	jmp    ccb <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     cca:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     ccb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     ccf:	8b 55 10             	mov    0x10(%ebp),%edx
     cd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cd5:	01 d0                	add    %edx,%eax
     cd7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     cda:	0f 8d 63 ff ff ff    	jge    c43 <APDrawPoint+0x41>
     ce0:	eb 01                	jmp    ce3 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     ce2:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     ce3:	c9                   	leave  
     ce4:	c3                   	ret    

00000ce5 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     ce5:	55                   	push   %ebp
     ce6:	89 e5                	mov    %esp,%ebp
     ce8:	53                   	push   %ebx
     ce9:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     cec:	8b 45 0c             	mov    0xc(%ebp),%eax
     cef:	3b 45 14             	cmp    0x14(%ebp),%eax
     cf2:	0f 85 80 00 00 00    	jne    d78 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     cf8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     cfc:	0f 88 9d 02 00 00    	js     f9f <APDrawLine+0x2ba>
     d02:	8b 45 08             	mov    0x8(%ebp),%eax
     d05:	8b 00                	mov    (%eax),%eax
     d07:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d0a:	0f 8e 8f 02 00 00    	jle    f9f <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d10:	8b 45 10             	mov    0x10(%ebp),%eax
     d13:	3b 45 18             	cmp    0x18(%ebp),%eax
     d16:	7e 12                	jle    d2a <APDrawLine+0x45>
        {
            int tmp = y2;
     d18:	8b 45 18             	mov    0x18(%ebp),%eax
     d1b:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d1e:	8b 45 10             	mov    0x10(%ebp),%eax
     d21:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d24:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d27:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d2a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d2e:	79 07                	jns    d37 <APDrawLine+0x52>
     d30:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d37:	8b 45 08             	mov    0x8(%ebp),%eax
     d3a:	8b 40 04             	mov    0x4(%eax),%eax
     d3d:	3b 45 18             	cmp    0x18(%ebp),%eax
     d40:	7d 0c                	jge    d4e <APDrawLine+0x69>
     d42:	8b 45 08             	mov    0x8(%ebp),%eax
     d45:	8b 40 04             	mov    0x4(%eax),%eax
     d48:	83 e8 01             	sub    $0x1,%eax
     d4b:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     d4e:	8b 45 10             	mov    0x10(%ebp),%eax
     d51:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d54:	eb 15                	jmp    d6b <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     d56:	ff 75 f4             	pushl  -0xc(%ebp)
     d59:	ff 75 0c             	pushl  0xc(%ebp)
     d5c:	ff 75 08             	pushl  0x8(%ebp)
     d5f:	e8 9e fe ff ff       	call   c02 <APDrawPoint>
     d64:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     d67:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d6e:	3b 45 18             	cmp    0x18(%ebp),%eax
     d71:	7e e3                	jle    d56 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     d73:	e9 2b 02 00 00       	jmp    fa3 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     d78:	8b 45 10             	mov    0x10(%ebp),%eax
     d7b:	3b 45 18             	cmp    0x18(%ebp),%eax
     d7e:	75 7f                	jne    dff <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     d80:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d84:	0f 88 18 02 00 00    	js     fa2 <APDrawLine+0x2bd>
     d8a:	8b 45 08             	mov    0x8(%ebp),%eax
     d8d:	8b 40 04             	mov    0x4(%eax),%eax
     d90:	3b 45 10             	cmp    0x10(%ebp),%eax
     d93:	0f 8e 09 02 00 00    	jle    fa2 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     d99:	8b 45 0c             	mov    0xc(%ebp),%eax
     d9c:	3b 45 14             	cmp    0x14(%ebp),%eax
     d9f:	7e 12                	jle    db3 <APDrawLine+0xce>
        {
            int tmp = x2;
     da1:	8b 45 14             	mov    0x14(%ebp),%eax
     da4:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     da7:	8b 45 0c             	mov    0xc(%ebp),%eax
     daa:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     dad:	8b 45 d8             	mov    -0x28(%ebp),%eax
     db0:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     db3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     db7:	79 07                	jns    dc0 <APDrawLine+0xdb>
     db9:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     dc0:	8b 45 08             	mov    0x8(%ebp),%eax
     dc3:	8b 00                	mov    (%eax),%eax
     dc5:	3b 45 14             	cmp    0x14(%ebp),%eax
     dc8:	7d 0b                	jge    dd5 <APDrawLine+0xf0>
     dca:	8b 45 08             	mov    0x8(%ebp),%eax
     dcd:	8b 00                	mov    (%eax),%eax
     dcf:	83 e8 01             	sub    $0x1,%eax
     dd2:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     dd5:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ddb:	eb 15                	jmp    df2 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     ddd:	ff 75 10             	pushl  0x10(%ebp)
     de0:	ff 75 f0             	pushl  -0x10(%ebp)
     de3:	ff 75 08             	pushl  0x8(%ebp)
     de6:	e8 17 fe ff ff       	call   c02 <APDrawPoint>
     deb:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     dee:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     df2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     df5:	3b 45 14             	cmp    0x14(%ebp),%eax
     df8:	7e e3                	jle    ddd <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     dfa:	e9 a4 01 00 00       	jmp    fa3 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     dff:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e06:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e0d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e10:	2b 45 14             	sub    0x14(%ebp),%eax
     e13:	50                   	push   %eax
     e14:	e8 3d fa ff ff       	call   856 <abs_int>
     e19:	83 c4 04             	add    $0x4,%esp
     e1c:	89 c3                	mov    %eax,%ebx
     e1e:	8b 45 10             	mov    0x10(%ebp),%eax
     e21:	2b 45 18             	sub    0x18(%ebp),%eax
     e24:	50                   	push   %eax
     e25:	e8 2c fa ff ff       	call   856 <abs_int>
     e2a:	83 c4 04             	add    $0x4,%esp
     e2d:	39 c3                	cmp    %eax,%ebx
     e2f:	0f 8e b5 00 00 00    	jle    eea <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e35:	8b 45 10             	mov    0x10(%ebp),%eax
     e38:	2b 45 18             	sub    0x18(%ebp),%eax
     e3b:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e3e:	db 45 b0             	fildl  -0x50(%ebp)
     e41:	8b 45 0c             	mov    0xc(%ebp),%eax
     e44:	2b 45 14             	sub    0x14(%ebp),%eax
     e47:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e4a:	db 45 b0             	fildl  -0x50(%ebp)
     e4d:	de f9                	fdivrp %st,%st(1)
     e4f:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     e52:	8b 45 14             	mov    0x14(%ebp),%eax
     e55:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e58:	7e 0e                	jle    e68 <APDrawLine+0x183>
        {
            s = x1;
     e5a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e5d:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     e60:	8b 45 14             	mov    0x14(%ebp),%eax
     e63:	89 45 e8             	mov    %eax,-0x18(%ebp)
     e66:	eb 0c                	jmp    e74 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     e68:	8b 45 14             	mov    0x14(%ebp),%eax
     e6b:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     e6e:	8b 45 0c             	mov    0xc(%ebp),%eax
     e71:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     e74:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     e78:	79 07                	jns    e81 <APDrawLine+0x19c>
     e7a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     e81:	8b 45 08             	mov    0x8(%ebp),%eax
     e84:	8b 00                	mov    (%eax),%eax
     e86:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     e89:	7f 0b                	jg     e96 <APDrawLine+0x1b1>
     e8b:	8b 45 08             	mov    0x8(%ebp),%eax
     e8e:	8b 00                	mov    (%eax),%eax
     e90:	83 e8 01             	sub    $0x1,%eax
     e93:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     e96:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e99:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     e9c:	eb 3f                	jmp    edd <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     e9e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ea1:	2b 45 0c             	sub    0xc(%ebp),%eax
     ea4:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ea7:	db 45 b0             	fildl  -0x50(%ebp)
     eaa:	dc 4d d0             	fmull  -0x30(%ebp)
     ead:	db 45 10             	fildl  0x10(%ebp)
     eb0:	de c1                	faddp  %st,%st(1)
     eb2:	d9 7d b6             	fnstcw -0x4a(%ebp)
     eb5:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     eb9:	b4 0c                	mov    $0xc,%ah
     ebb:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     ebf:	d9 6d b4             	fldcw  -0x4c(%ebp)
     ec2:	db 5d cc             	fistpl -0x34(%ebp)
     ec5:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     ec8:	ff 75 cc             	pushl  -0x34(%ebp)
     ecb:	ff 75 e4             	pushl  -0x1c(%ebp)
     ece:	ff 75 08             	pushl  0x8(%ebp)
     ed1:	e8 2c fd ff ff       	call   c02 <APDrawPoint>
     ed6:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     ed9:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     edd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ee0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ee3:	7e b9                	jle    e9e <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     ee5:	e9 b9 00 00 00       	jmp    fa3 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     eea:	8b 45 0c             	mov    0xc(%ebp),%eax
     eed:	2b 45 14             	sub    0x14(%ebp),%eax
     ef0:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ef3:	db 45 b0             	fildl  -0x50(%ebp)
     ef6:	8b 45 10             	mov    0x10(%ebp),%eax
     ef9:	2b 45 18             	sub    0x18(%ebp),%eax
     efc:	89 45 b0             	mov    %eax,-0x50(%ebp)
     eff:	db 45 b0             	fildl  -0x50(%ebp)
     f02:	de f9                	fdivrp %st,%st(1)
     f04:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f07:	8b 45 10             	mov    0x10(%ebp),%eax
     f0a:	3b 45 18             	cmp    0x18(%ebp),%eax
     f0d:	7e 0e                	jle    f1d <APDrawLine+0x238>
    {
        s = y2;
     f0f:	8b 45 18             	mov    0x18(%ebp),%eax
     f12:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f15:	8b 45 10             	mov    0x10(%ebp),%eax
     f18:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f1b:	eb 0c                	jmp    f29 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f1d:	8b 45 10             	mov    0x10(%ebp),%eax
     f20:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f23:	8b 45 18             	mov    0x18(%ebp),%eax
     f26:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f29:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f2d:	79 07                	jns    f36 <APDrawLine+0x251>
     f2f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f36:	8b 45 08             	mov    0x8(%ebp),%eax
     f39:	8b 40 04             	mov    0x4(%eax),%eax
     f3c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f3f:	7f 0c                	jg     f4d <APDrawLine+0x268>
     f41:	8b 45 08             	mov    0x8(%ebp),%eax
     f44:	8b 40 04             	mov    0x4(%eax),%eax
     f47:	83 e8 01             	sub    $0x1,%eax
     f4a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     f4d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f50:	89 45 e0             	mov    %eax,-0x20(%ebp)
     f53:	eb 3f                	jmp    f94 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     f55:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f58:	2b 45 10             	sub    0x10(%ebp),%eax
     f5b:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f5e:	db 45 b0             	fildl  -0x50(%ebp)
     f61:	dc 4d c0             	fmull  -0x40(%ebp)
     f64:	db 45 0c             	fildl  0xc(%ebp)
     f67:	de c1                	faddp  %st,%st(1)
     f69:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f6c:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f70:	b4 0c                	mov    $0xc,%ah
     f72:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f76:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f79:	db 5d bc             	fistpl -0x44(%ebp)
     f7c:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     f7f:	ff 75 e0             	pushl  -0x20(%ebp)
     f82:	ff 75 bc             	pushl  -0x44(%ebp)
     f85:	ff 75 08             	pushl  0x8(%ebp)
     f88:	e8 75 fc ff ff       	call   c02 <APDrawPoint>
     f8d:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     f90:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     f94:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f97:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f9a:	7e b9                	jle    f55 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     f9c:	90                   	nop
     f9d:	eb 04                	jmp    fa3 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     f9f:	90                   	nop
     fa0:	eb 01                	jmp    fa3 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     fa2:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     fa3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fa6:	c9                   	leave  
     fa7:	c3                   	ret    

00000fa8 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     fa8:	55                   	push   %ebp
     fa9:	89 e5                	mov    %esp,%ebp
     fab:	53                   	push   %ebx
     fac:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
     faf:	8b 55 10             	mov    0x10(%ebp),%edx
     fb2:	8b 45 18             	mov    0x18(%ebp),%eax
     fb5:	01 d0                	add    %edx,%eax
     fb7:	83 e8 01             	sub    $0x1,%eax
     fba:	83 ec 04             	sub    $0x4,%esp
     fbd:	50                   	push   %eax
     fbe:	ff 75 0c             	pushl  0xc(%ebp)
     fc1:	ff 75 10             	pushl  0x10(%ebp)
     fc4:	ff 75 0c             	pushl  0xc(%ebp)
     fc7:	ff 75 08             	pushl  0x8(%ebp)
     fca:	e8 16 fd ff ff       	call   ce5 <APDrawLine>
     fcf:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
     fd2:	8b 55 0c             	mov    0xc(%ebp),%edx
     fd5:	8b 45 14             	mov    0x14(%ebp),%eax
     fd8:	01 d0                	add    %edx,%eax
     fda:	83 e8 01             	sub    $0x1,%eax
     fdd:	83 ec 04             	sub    $0x4,%esp
     fe0:	ff 75 10             	pushl  0x10(%ebp)
     fe3:	50                   	push   %eax
     fe4:	ff 75 10             	pushl  0x10(%ebp)
     fe7:	ff 75 0c             	pushl  0xc(%ebp)
     fea:	ff 75 08             	pushl  0x8(%ebp)
     fed:	e8 f3 fc ff ff       	call   ce5 <APDrawLine>
     ff2:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
     ff5:	8b 55 10             	mov    0x10(%ebp),%edx
     ff8:	8b 45 18             	mov    0x18(%ebp),%eax
     ffb:	01 d0                	add    %edx,%eax
     ffd:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1000:	8b 55 0c             	mov    0xc(%ebp),%edx
    1003:	8b 45 14             	mov    0x14(%ebp),%eax
    1006:	01 d0                	add    %edx,%eax
    1008:	8d 50 ff             	lea    -0x1(%eax),%edx
    100b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    100e:	8b 45 14             	mov    0x14(%ebp),%eax
    1011:	01 d8                	add    %ebx,%eax
    1013:	83 e8 01             	sub    $0x1,%eax
    1016:	83 ec 04             	sub    $0x4,%esp
    1019:	51                   	push   %ecx
    101a:	52                   	push   %edx
    101b:	ff 75 10             	pushl  0x10(%ebp)
    101e:	50                   	push   %eax
    101f:	ff 75 08             	pushl  0x8(%ebp)
    1022:	e8 be fc ff ff       	call   ce5 <APDrawLine>
    1027:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    102a:	8b 55 10             	mov    0x10(%ebp),%edx
    102d:	8b 45 18             	mov    0x18(%ebp),%eax
    1030:	01 d0                	add    %edx,%eax
    1032:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1035:	8b 55 0c             	mov    0xc(%ebp),%edx
    1038:	8b 45 14             	mov    0x14(%ebp),%eax
    103b:	01 d0                	add    %edx,%eax
    103d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1040:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1043:	8b 45 18             	mov    0x18(%ebp),%eax
    1046:	01 d8                	add    %ebx,%eax
    1048:	83 e8 01             	sub    $0x1,%eax
    104b:	83 ec 04             	sub    $0x4,%esp
    104e:	51                   	push   %ecx
    104f:	52                   	push   %edx
    1050:	50                   	push   %eax
    1051:	ff 75 0c             	pushl  0xc(%ebp)
    1054:	ff 75 08             	pushl  0x8(%ebp)
    1057:	e8 89 fc ff ff       	call   ce5 <APDrawLine>
    105c:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    105f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1062:	8b 45 14             	mov    0x14(%ebp),%eax
    1065:	01 d0                	add    %edx,%eax
    1067:	8d 50 ff             	lea    -0x1(%eax),%edx
    106a:	8b 45 08             	mov    0x8(%ebp),%eax
    106d:	8b 40 0c             	mov    0xc(%eax),%eax
    1070:	89 c1                	mov    %eax,%ecx
    1072:	c1 e9 1f             	shr    $0x1f,%ecx
    1075:	01 c8                	add    %ecx,%eax
    1077:	d1 f8                	sar    %eax
    1079:	29 c2                	sub    %eax,%edx
    107b:	89 d0                	mov    %edx,%eax
    107d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1080:	8b 55 10             	mov    0x10(%ebp),%edx
    1083:	8b 45 18             	mov    0x18(%ebp),%eax
    1086:	01 d0                	add    %edx,%eax
    1088:	8d 50 ff             	lea    -0x1(%eax),%edx
    108b:	8b 45 08             	mov    0x8(%ebp),%eax
    108e:	8b 40 0c             	mov    0xc(%eax),%eax
    1091:	89 c1                	mov    %eax,%ecx
    1093:	c1 e9 1f             	shr    $0x1f,%ecx
    1096:	01 c8                	add    %ecx,%eax
    1098:	d1 f8                	sar    %eax
    109a:	29 c2                	sub    %eax,%edx
    109c:	89 d0                	mov    %edx,%eax
    109e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    10a1:	8b 45 08             	mov    0x8(%ebp),%eax
    10a4:	8b 40 0c             	mov    0xc(%eax),%eax
    10a7:	89 c2                	mov    %eax,%edx
    10a9:	c1 ea 1f             	shr    $0x1f,%edx
    10ac:	01 d0                	add    %edx,%eax
    10ae:	d1 f8                	sar    %eax
    10b0:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    10b3:	8b 45 08             	mov    0x8(%ebp),%eax
    10b6:	8b 40 0c             	mov    0xc(%eax),%eax
    10b9:	89 c2                	mov    %eax,%edx
    10bb:	c1 ea 1f             	shr    $0x1f,%edx
    10be:	01 d0                	add    %edx,%eax
    10c0:	d1 f8                	sar    %eax
    10c2:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    10c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10c9:	0f 88 d8 00 00 00    	js     11a7 <APDrawRect+0x1ff>
    10cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    10d3:	0f 88 ce 00 00 00    	js     11a7 <APDrawRect+0x1ff>
    10d9:	8b 45 08             	mov    0x8(%ebp),%eax
    10dc:	8b 00                	mov    (%eax),%eax
    10de:	3b 45 0c             	cmp    0xc(%ebp),%eax
    10e1:	0f 8e c0 00 00 00    	jle    11a7 <APDrawRect+0x1ff>
    10e7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ea:	8b 40 04             	mov    0x4(%eax),%eax
    10ed:	3b 45 10             	cmp    0x10(%ebp),%eax
    10f0:	0f 8e b1 00 00 00    	jle    11a7 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    10f6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10fa:	79 07                	jns    1103 <APDrawRect+0x15b>
    10fc:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1103:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1107:	79 07                	jns    1110 <APDrawRect+0x168>
    1109:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1110:	8b 45 08             	mov    0x8(%ebp),%eax
    1113:	8b 00                	mov    (%eax),%eax
    1115:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1118:	7f 0b                	jg     1125 <APDrawRect+0x17d>
    111a:	8b 45 08             	mov    0x8(%ebp),%eax
    111d:	8b 00                	mov    (%eax),%eax
    111f:	83 e8 01             	sub    $0x1,%eax
    1122:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1125:	8b 45 08             	mov    0x8(%ebp),%eax
    1128:	8b 40 04             	mov    0x4(%eax),%eax
    112b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    112e:	7f 0c                	jg     113c <APDrawRect+0x194>
    1130:	8b 45 08             	mov    0x8(%ebp),%eax
    1133:	8b 40 04             	mov    0x4(%eax),%eax
    1136:	83 e8 01             	sub    $0x1,%eax
    1139:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    113c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1143:	8b 45 0c             	mov    0xc(%ebp),%eax
    1146:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1149:	eb 52                	jmp    119d <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    114b:	8b 45 10             	mov    0x10(%ebp),%eax
    114e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1151:	eb 3e                	jmp    1191 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1153:	83 ec 04             	sub    $0x4,%esp
    1156:	ff 75 e8             	pushl  -0x18(%ebp)
    1159:	ff 75 ec             	pushl  -0x14(%ebp)
    115c:	ff 75 08             	pushl  0x8(%ebp)
    115f:	e8 02 f7 ff ff       	call   866 <APGetIndex>
    1164:	83 c4 10             	add    $0x10,%esp
    1167:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    116a:	8b 45 08             	mov    0x8(%ebp),%eax
    116d:	8b 48 18             	mov    0x18(%eax),%ecx
    1170:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1173:	89 d0                	mov    %edx,%eax
    1175:	01 c0                	add    %eax,%eax
    1177:	01 d0                	add    %edx,%eax
    1179:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    117c:	8b 45 08             	mov    0x8(%ebp),%eax
    117f:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1183:	66 89 0a             	mov    %cx,(%edx)
    1186:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    118a:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    118d:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1191:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1194:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1197:	7e ba                	jle    1153 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1199:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    119d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11a0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11a3:	7e a6                	jle    114b <APDrawRect+0x1a3>
    11a5:	eb 01                	jmp    11a8 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    11a7:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    11a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11ab:	c9                   	leave  
    11ac:	c3                   	ret    

000011ad <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    11ad:	55                   	push   %ebp
    11ae:	89 e5                	mov    %esp,%ebp
}
    11b0:	90                   	nop
    11b1:	5d                   	pop    %ebp
    11b2:	c3                   	ret    

000011b3 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    11b3:	55                   	push   %ebp
    11b4:	89 e5                	mov    %esp,%ebp
    11b6:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    11b9:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    11bd:	0f 88 8e 01 00 00    	js     1351 <APDcCopy+0x19e>
    11c3:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    11c7:	0f 88 84 01 00 00    	js     1351 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    11cd:	8b 55 0c             	mov    0xc(%ebp),%edx
    11d0:	8b 45 20             	mov    0x20(%ebp),%eax
    11d3:	01 d0                	add    %edx,%eax
    11d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11d8:	8b 55 10             	mov    0x10(%ebp),%edx
    11db:	8b 45 24             	mov    0x24(%ebp),%eax
    11de:	01 d0                	add    %edx,%eax
    11e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    11e3:	8b 55 18             	mov    0x18(%ebp),%edx
    11e6:	8b 45 20             	mov    0x20(%ebp),%eax
    11e9:	01 d0                	add    %edx,%eax
    11eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11ee:	8b 55 1c             	mov    0x1c(%ebp),%edx
    11f1:	8b 45 24             	mov    0x24(%ebp),%eax
    11f4:	01 d0                	add    %edx,%eax
    11f6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    11f9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11fd:	0f 88 51 01 00 00    	js     1354 <APDcCopy+0x1a1>
    1203:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1207:	0f 88 47 01 00 00    	js     1354 <APDcCopy+0x1a1>
    120d:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1211:	0f 88 3d 01 00 00    	js     1354 <APDcCopy+0x1a1>
    1217:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    121b:	0f 88 33 01 00 00    	js     1354 <APDcCopy+0x1a1>
    1221:	8b 45 14             	mov    0x14(%ebp),%eax
    1224:	8b 00                	mov    (%eax),%eax
    1226:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1229:	0f 8c 25 01 00 00    	jl     1354 <APDcCopy+0x1a1>
    122f:	8b 45 14             	mov    0x14(%ebp),%eax
    1232:	8b 40 04             	mov    0x4(%eax),%eax
    1235:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1238:	0f 8c 16 01 00 00    	jl     1354 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    123e:	8b 45 08             	mov    0x8(%ebp),%eax
    1241:	8b 00                	mov    (%eax),%eax
    1243:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1246:	7f 0b                	jg     1253 <APDcCopy+0xa0>
    1248:	8b 45 08             	mov    0x8(%ebp),%eax
    124b:	8b 00                	mov    (%eax),%eax
    124d:	83 e8 01             	sub    $0x1,%eax
    1250:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1253:	8b 45 08             	mov    0x8(%ebp),%eax
    1256:	8b 40 04             	mov    0x4(%eax),%eax
    1259:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    125c:	7f 0c                	jg     126a <APDcCopy+0xb7>
    125e:	8b 45 08             	mov    0x8(%ebp),%eax
    1261:	8b 40 04             	mov    0x4(%eax),%eax
    1264:	83 e8 01             	sub    $0x1,%eax
    1267:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    126a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1271:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1278:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    127f:	e9 bc 00 00 00       	jmp    1340 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1284:	8b 45 08             	mov    0x8(%ebp),%eax
    1287:	8b 00                	mov    (%eax),%eax
    1289:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    128c:	8b 55 10             	mov    0x10(%ebp),%edx
    128f:	01 ca                	add    %ecx,%edx
    1291:	0f af d0             	imul   %eax,%edx
    1294:	8b 45 0c             	mov    0xc(%ebp),%eax
    1297:	01 d0                	add    %edx,%eax
    1299:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    129c:	8b 45 14             	mov    0x14(%ebp),%eax
    129f:	8b 00                	mov    (%eax),%eax
    12a1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12a4:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12a7:	01 ca                	add    %ecx,%edx
    12a9:	0f af d0             	imul   %eax,%edx
    12ac:	8b 45 18             	mov    0x18(%ebp),%eax
    12af:	01 d0                	add    %edx,%eax
    12b1:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    12b4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12bb:	eb 74                	jmp    1331 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    12bd:	8b 45 14             	mov    0x14(%ebp),%eax
    12c0:	8b 50 18             	mov    0x18(%eax),%edx
    12c3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12c9:	01 c8                	add    %ecx,%eax
    12cb:	89 c1                	mov    %eax,%ecx
    12cd:	89 c8                	mov    %ecx,%eax
    12cf:	01 c0                	add    %eax,%eax
    12d1:	01 c8                	add    %ecx,%eax
    12d3:	01 d0                	add    %edx,%eax
    12d5:	0f b7 10             	movzwl (%eax),%edx
    12d8:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    12dc:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    12e0:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    12e3:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    12e7:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    12eb:	38 c2                	cmp    %al,%dl
    12ed:	75 18                	jne    1307 <APDcCopy+0x154>
    12ef:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    12f3:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    12f7:	38 c2                	cmp    %al,%dl
    12f9:	75 0c                	jne    1307 <APDcCopy+0x154>
    12fb:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    12ff:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1303:	38 c2                	cmp    %al,%dl
    1305:	74 26                	je     132d <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1307:	8b 45 08             	mov    0x8(%ebp),%eax
    130a:	8b 50 18             	mov    0x18(%eax),%edx
    130d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1310:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1313:	01 c8                	add    %ecx,%eax
    1315:	89 c1                	mov    %eax,%ecx
    1317:	89 c8                	mov    %ecx,%eax
    1319:	01 c0                	add    %eax,%eax
    131b:	01 c8                	add    %ecx,%eax
    131d:	01 d0                	add    %edx,%eax
    131f:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1323:	66 89 10             	mov    %dx,(%eax)
    1326:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    132a:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    132d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1331:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1334:	2b 45 0c             	sub    0xc(%ebp),%eax
    1337:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    133a:	7d 81                	jge    12bd <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    133c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1340:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1343:	2b 45 10             	sub    0x10(%ebp),%eax
    1346:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1349:	0f 8d 35 ff ff ff    	jge    1284 <APDcCopy+0xd1>
    134f:	eb 04                	jmp    1355 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1351:	90                   	nop
    1352:	eb 01                	jmp    1355 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1354:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1355:	c9                   	leave  
    1356:	c3                   	ret    

00001357 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1357:	55                   	push   %ebp
    1358:	89 e5                	mov    %esp,%ebp
    135a:	83 ec 1c             	sub    $0x1c,%esp
    135d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1360:	8b 55 10             	mov    0x10(%ebp),%edx
    1363:	8b 45 14             	mov    0x14(%ebp),%eax
    1366:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1369:	88 55 e8             	mov    %dl,-0x18(%ebp)
    136c:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    136f:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1373:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1376:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    137a:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    137d:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1381:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1384:	8b 45 08             	mov    0x8(%ebp),%eax
    1387:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    138b:	66 89 10             	mov    %dx,(%eax)
    138e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1392:	88 50 02             	mov    %dl,0x2(%eax)
}
    1395:	8b 45 08             	mov    0x8(%ebp),%eax
    1398:	c9                   	leave  
    1399:	c2 04 00             	ret    $0x4

0000139c <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    139c:	55                   	push   %ebp
    139d:	89 e5                	mov    %esp,%ebp
    139f:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13a2:	8b 45 08             	mov    0x8(%ebp),%eax
    13a5:	8b 00                	mov    (%eax),%eax
    13a7:	83 ec 08             	sub    $0x8,%esp
    13aa:	8d 55 0c             	lea    0xc(%ebp),%edx
    13ad:	52                   	push   %edx
    13ae:	50                   	push   %eax
    13af:	e8 77 ef ff ff       	call   32b <sendMessage>
    13b4:	83 c4 10             	add    $0x10,%esp
}
    13b7:	90                   	nop
    13b8:	c9                   	leave  
    13b9:	c3                   	ret    

000013ba <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    13ba:	55                   	push   %ebp
    13bb:	89 e5                	mov    %esp,%ebp
    13bd:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    13c0:	83 ec 0c             	sub    $0xc,%esp
    13c3:	68 98 00 00 00       	push   $0x98
    13c8:	e8 38 f3 ff ff       	call   705 <malloc>
    13cd:	83 c4 10             	add    $0x10,%esp
    13d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    13d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13d7:	75 15                	jne    13ee <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    13d9:	83 ec 04             	sub    $0x4,%esp
    13dc:	ff 75 08             	pushl  0x8(%ebp)
    13df:	68 0c 22 00 00       	push   $0x220c
    13e4:	6a 01                	push   $0x1
    13e6:	e8 47 f0 ff ff       	call   432 <printf>
    13eb:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    13ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f1:	05 84 00 00 00       	add    $0x84,%eax
    13f6:	83 ec 08             	sub    $0x8,%esp
    13f9:	ff 75 08             	pushl  0x8(%ebp)
    13fc:	50                   	push   %eax
    13fd:	e8 50 ec ff ff       	call   52 <strcpy>
    1402:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1405:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1408:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    140f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1412:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1419:	8b 45 f4             	mov    -0xc(%ebp),%eax
    141c:	8b 40 3c             	mov    0x3c(%eax),%eax
    141f:	89 c2                	mov    %eax,%edx
    1421:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1424:	8b 40 40             	mov    0x40(%eax),%eax
    1427:	0f af d0             	imul   %eax,%edx
    142a:	89 d0                	mov    %edx,%eax
    142c:	01 c0                	add    %eax,%eax
    142e:	01 d0                	add    %edx,%eax
    1430:	83 ec 0c             	sub    $0xc,%esp
    1433:	50                   	push   %eax
    1434:	e8 cc f2 ff ff       	call   705 <malloc>
    1439:	83 c4 10             	add    $0x10,%esp
    143c:	89 c2                	mov    %eax,%edx
    143e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1441:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1444:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1447:	8b 40 54             	mov    0x54(%eax),%eax
    144a:	85 c0                	test   %eax,%eax
    144c:	75 15                	jne    1463 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    144e:	83 ec 04             	sub    $0x4,%esp
    1451:	ff 75 08             	pushl  0x8(%ebp)
    1454:	68 2c 22 00 00       	push   $0x222c
    1459:	6a 01                	push   $0x1
    145b:	e8 d2 ef ff ff       	call   432 <printf>
    1460:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1463:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1466:	8b 40 3c             	mov    0x3c(%eax),%eax
    1469:	89 c2                	mov    %eax,%edx
    146b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    146e:	8b 40 40             	mov    0x40(%eax),%eax
    1471:	0f af d0             	imul   %eax,%edx
    1474:	89 d0                	mov    %edx,%eax
    1476:	01 c0                	add    %eax,%eax
    1478:	01 c2                	add    %eax,%edx
    147a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    147d:	8b 40 54             	mov    0x54(%eax),%eax
    1480:	83 ec 04             	sub    $0x4,%esp
    1483:	52                   	push   %edx
    1484:	68 ff ff ff 00       	push   $0xffffff
    1489:	50                   	push   %eax
    148a:	e8 59 ec ff ff       	call   e8 <memset>
    148f:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1492:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1495:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    149c:	e8 62 ee ff ff       	call   303 <getpid>
    14a1:	89 c2                	mov    %eax,%edx
    14a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a6:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ac:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b6:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    14bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c0:	8b 40 58             	mov    0x58(%eax),%eax
    14c3:	89 c2                	mov    %eax,%edx
    14c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c8:	8b 40 5c             	mov    0x5c(%eax),%eax
    14cb:	0f af d0             	imul   %eax,%edx
    14ce:	89 d0                	mov    %edx,%eax
    14d0:	01 c0                	add    %eax,%eax
    14d2:	01 d0                	add    %edx,%eax
    14d4:	83 ec 0c             	sub    $0xc,%esp
    14d7:	50                   	push   %eax
    14d8:	e8 28 f2 ff ff       	call   705 <malloc>
    14dd:	83 c4 10             	add    $0x10,%esp
    14e0:	89 c2                	mov    %eax,%edx
    14e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e5:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    14e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14eb:	8b 40 70             	mov    0x70(%eax),%eax
    14ee:	85 c0                	test   %eax,%eax
    14f0:	75 15                	jne    1507 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    14f2:	83 ec 04             	sub    $0x4,%esp
    14f5:	ff 75 08             	pushl  0x8(%ebp)
    14f8:	68 50 22 00 00       	push   $0x2250
    14fd:	6a 01                	push   $0x1
    14ff:	e8 2e ef ff ff       	call   432 <printf>
    1504:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1507:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150a:	8b 40 3c             	mov    0x3c(%eax),%eax
    150d:	89 c2                	mov    %eax,%edx
    150f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1512:	8b 40 40             	mov    0x40(%eax),%eax
    1515:	0f af d0             	imul   %eax,%edx
    1518:	89 d0                	mov    %edx,%eax
    151a:	01 c0                	add    %eax,%eax
    151c:	01 c2                	add    %eax,%edx
    151e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1521:	8b 40 54             	mov    0x54(%eax),%eax
    1524:	83 ec 04             	sub    $0x4,%esp
    1527:	52                   	push   %edx
    1528:	68 ff 00 00 00       	push   $0xff
    152d:	50                   	push   %eax
    152e:	e8 b5 eb ff ff       	call   e8 <memset>
    1533:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1536:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1539:	8b 55 0c             	mov    0xc(%ebp),%edx
    153c:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    153f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1543:	74 49                	je     158e <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1545:	8b 45 10             	mov    0x10(%ebp),%eax
    1548:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    154e:	83 ec 0c             	sub    $0xc,%esp
    1551:	50                   	push   %eax
    1552:	e8 ae f1 ff ff       	call   705 <malloc>
    1557:	83 c4 10             	add    $0x10,%esp
    155a:	89 c2                	mov    %eax,%edx
    155c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155f:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1562:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1565:	8b 55 10             	mov    0x10(%ebp),%edx
    1568:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    156b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156e:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1575:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1578:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    157f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1582:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1589:	e9 8d 00 00 00       	jmp    161b <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    158e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1591:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1598:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159b:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a5:	8b 40 20             	mov    0x20(%eax),%eax
    15a8:	89 c2                	mov    %eax,%edx
    15aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ad:	8b 40 24             	mov    0x24(%eax),%eax
    15b0:	0f af d0             	imul   %eax,%edx
    15b3:	89 d0                	mov    %edx,%eax
    15b5:	01 c0                	add    %eax,%eax
    15b7:	01 d0                	add    %edx,%eax
    15b9:	83 ec 0c             	sub    $0xc,%esp
    15bc:	50                   	push   %eax
    15bd:	e8 43 f1 ff ff       	call   705 <malloc>
    15c2:	83 c4 10             	add    $0x10,%esp
    15c5:	89 c2                	mov    %eax,%edx
    15c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ca:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    15cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d0:	8b 40 38             	mov    0x38(%eax),%eax
    15d3:	85 c0                	test   %eax,%eax
    15d5:	75 15                	jne    15ec <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    15d7:	83 ec 04             	sub    $0x4,%esp
    15da:	ff 75 08             	pushl  0x8(%ebp)
    15dd:	68 78 22 00 00       	push   $0x2278
    15e2:	6a 01                	push   $0x1
    15e4:	e8 49 ee ff ff       	call   432 <printf>
    15e9:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ef:	8b 40 20             	mov    0x20(%eax),%eax
    15f2:	89 c2                	mov    %eax,%edx
    15f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f7:	8b 40 24             	mov    0x24(%eax),%eax
    15fa:	0f af d0             	imul   %eax,%edx
    15fd:	89 d0                	mov    %edx,%eax
    15ff:	01 c0                	add    %eax,%eax
    1601:	01 c2                	add    %eax,%edx
    1603:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1606:	8b 40 38             	mov    0x38(%eax),%eax
    1609:	83 ec 04             	sub    $0x4,%esp
    160c:	52                   	push   %edx
    160d:	68 ff ff ff 00       	push   $0xffffff
    1612:	50                   	push   %eax
    1613:	e8 d0 ea ff ff       	call   e8 <memset>
    1618:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    161b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    161e:	c9                   	leave  
    161f:	c3                   	ret    

00001620 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1620:	55                   	push   %ebp
    1621:	89 e5                	mov    %esp,%ebp
    1623:	57                   	push   %edi
    1624:	56                   	push   %esi
    1625:	53                   	push   %ebx
    1626:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1629:	8b 45 0c             	mov    0xc(%ebp),%eax
    162c:	83 f8 03             	cmp    $0x3,%eax
    162f:	74 02                	je     1633 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1631:	eb 7c                	jmp    16af <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1633:	8b 45 08             	mov    0x8(%ebp),%eax
    1636:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1639:	8b 45 08             	mov    0x8(%ebp),%eax
    163c:	8b 48 18             	mov    0x18(%eax),%ecx
    163f:	8b 45 08             	mov    0x8(%ebp),%eax
    1642:	8b 50 5c             	mov    0x5c(%eax),%edx
    1645:	8b 45 08             	mov    0x8(%ebp),%eax
    1648:	8b 40 58             	mov    0x58(%eax),%eax
    164b:	8b 75 08             	mov    0x8(%ebp),%esi
    164e:	83 c6 58             	add    $0x58,%esi
    1651:	83 ec 04             	sub    $0x4,%esp
    1654:	53                   	push   %ebx
    1655:	51                   	push   %ecx
    1656:	6a 00                	push   $0x0
    1658:	52                   	push   %edx
    1659:	50                   	push   %eax
    165a:	6a 00                	push   $0x0
    165c:	6a 00                	push   $0x0
    165e:	56                   	push   %esi
    165f:	6a 00                	push   $0x0
    1661:	6a 00                	push   $0x0
    1663:	ff 75 08             	pushl  0x8(%ebp)
    1666:	e8 b8 ec ff ff       	call   323 <paintWindow>
    166b:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    166e:	8b 45 08             	mov    0x8(%ebp),%eax
    1671:	8b 70 1c             	mov    0x1c(%eax),%esi
    1674:	8b 45 08             	mov    0x8(%ebp),%eax
    1677:	8b 58 18             	mov    0x18(%eax),%ebx
    167a:	8b 45 08             	mov    0x8(%ebp),%eax
    167d:	8b 48 08             	mov    0x8(%eax),%ecx
    1680:	8b 45 08             	mov    0x8(%ebp),%eax
    1683:	8b 50 40             	mov    0x40(%eax),%edx
    1686:	8b 45 08             	mov    0x8(%ebp),%eax
    1689:	8b 40 3c             	mov    0x3c(%eax),%eax
    168c:	8b 7d 08             	mov    0x8(%ebp),%edi
    168f:	83 c7 3c             	add    $0x3c,%edi
    1692:	83 ec 04             	sub    $0x4,%esp
    1695:	56                   	push   %esi
    1696:	53                   	push   %ebx
    1697:	51                   	push   %ecx
    1698:	52                   	push   %edx
    1699:	50                   	push   %eax
    169a:	6a 00                	push   $0x0
    169c:	6a 00                	push   $0x0
    169e:	57                   	push   %edi
    169f:	6a 32                	push   $0x32
    16a1:	6a 00                	push   $0x0
    16a3:	ff 75 08             	pushl  0x8(%ebp)
    16a6:	e8 78 ec ff ff       	call   323 <paintWindow>
    16ab:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    16ae:	90                   	nop
        default: break;
            
            
    }
    return False;
    16af:	b8 00 00 00 00       	mov    $0x0,%eax
}
    16b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16b7:	5b                   	pop    %ebx
    16b8:	5e                   	pop    %esi
    16b9:	5f                   	pop    %edi
    16ba:	5d                   	pop    %ebp
    16bb:	c3                   	ret    

000016bc <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    16bc:	55                   	push   %ebp
    16bd:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    16bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    16c2:	8b 50 08             	mov    0x8(%eax),%edx
    16c5:	8b 45 08             	mov    0x8(%ebp),%eax
    16c8:	8b 00                	mov    (%eax),%eax
    16ca:	39 c2                	cmp    %eax,%edx
    16cc:	74 07                	je     16d5 <APPreJudge+0x19>
        return False;
    16ce:	b8 00 00 00 00       	mov    $0x0,%eax
    16d3:	eb 05                	jmp    16da <APPreJudge+0x1e>
    return True;
    16d5:	b8 01 00 00 00       	mov    $0x1,%eax
}
    16da:	5d                   	pop    %ebp
    16db:	c3                   	ret    

000016dc <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    16dc:	55                   	push   %ebp
    16dd:	89 e5                	mov    %esp,%ebp
    16df:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    16e2:	8b 45 08             	mov    0x8(%ebp),%eax
    16e5:	8b 55 0c             	mov    0xc(%ebp),%edx
    16e8:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    16ee:	83 ec 0c             	sub    $0xc,%esp
    16f1:	ff 75 08             	pushl  0x8(%ebp)
    16f4:	e8 42 ec ff ff       	call   33b <registWindow>
    16f9:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    16fc:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1703:	8b 45 08             	mov    0x8(%ebp),%eax
    1706:	8b 00                	mov    (%eax),%eax
    1708:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    170b:	ff 75 f4             	pushl  -0xc(%ebp)
    170e:	ff 75 f0             	pushl  -0x10(%ebp)
    1711:	ff 75 ec             	pushl  -0x14(%ebp)
    1714:	ff 75 08             	pushl  0x8(%ebp)
    1717:	e8 80 fc ff ff       	call   139c <APSendMessage>
    171c:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    171f:	83 ec 0c             	sub    $0xc,%esp
    1722:	ff 75 08             	pushl  0x8(%ebp)
    1725:	e8 09 ec ff ff       	call   333 <getMessage>
    172a:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    172d:	8b 45 08             	mov    0x8(%ebp),%eax
    1730:	83 c0 74             	add    $0x74,%eax
    1733:	83 ec 08             	sub    $0x8,%esp
    1736:	50                   	push   %eax
    1737:	ff 75 08             	pushl  0x8(%ebp)
    173a:	e8 7d ff ff ff       	call   16bc <APPreJudge>
    173f:	83 c4 10             	add    $0x10,%esp
    1742:	84 c0                	test   %al,%al
    1744:	74 1b                	je     1761 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1746:	8b 45 08             	mov    0x8(%ebp),%eax
    1749:	ff 70 7c             	pushl  0x7c(%eax)
    174c:	ff 70 78             	pushl  0x78(%eax)
    174f:	ff 70 74             	pushl  0x74(%eax)
    1752:	ff 75 08             	pushl  0x8(%ebp)
    1755:	8b 45 0c             	mov    0xc(%ebp),%eax
    1758:	ff d0                	call   *%eax
    175a:	83 c4 10             	add    $0x10,%esp
    175d:	84 c0                	test   %al,%al
    175f:	75 0c                	jne    176d <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1761:	8b 45 08             	mov    0x8(%ebp),%eax
    1764:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    176b:	eb b2                	jmp    171f <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    176d:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    176e:	90                   	nop
    176f:	c9                   	leave  
    1770:	c3                   	ret    

00001771 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1771:	55                   	push   %ebp
    1772:	89 e5                	mov    %esp,%ebp
    1774:	57                   	push   %edi
    1775:	56                   	push   %esi
    1776:	53                   	push   %ebx
    1777:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    177a:	a1 fc 28 00 00       	mov    0x28fc,%eax
    177f:	85 c0                	test   %eax,%eax
    1781:	0f 85 2c 02 00 00    	jne    19b3 <APGridPaint+0x242>
    {
        iconReady = 1;
    1787:	c7 05 fc 28 00 00 01 	movl   $0x1,0x28fc
    178e:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1791:	8d 45 98             	lea    -0x68(%ebp),%eax
    1794:	83 ec 08             	sub    $0x8,%esp
    1797:	68 9f 22 00 00       	push   $0x229f
    179c:	50                   	push   %eax
    179d:	e8 16 f1 ff ff       	call   8b8 <APLoadBitmap>
    17a2:	83 c4 0c             	add    $0xc,%esp
    17a5:	8b 45 98             	mov    -0x68(%ebp),%eax
    17a8:	a3 20 29 00 00       	mov    %eax,0x2920
    17ad:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17b0:	a3 24 29 00 00       	mov    %eax,0x2924
    17b5:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17b8:	a3 28 29 00 00       	mov    %eax,0x2928
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    17bd:	83 ec 04             	sub    $0x4,%esp
    17c0:	ff 35 28 29 00 00    	pushl  0x2928
    17c6:	ff 35 24 29 00 00    	pushl  0x2924
    17cc:	ff 35 20 29 00 00    	pushl  0x2920
    17d2:	e8 1b f3 ff ff       	call   af2 <APCreateCompatibleDCFromBitmap>
    17d7:	83 c4 10             	add    $0x10,%esp
    17da:	a3 2c 29 00 00       	mov    %eax,0x292c
        grid_river = APLoadBitmap ("grid_river.bmp");
    17df:	8d 45 98             	lea    -0x68(%ebp),%eax
    17e2:	83 ec 08             	sub    $0x8,%esp
    17e5:	68 ad 22 00 00       	push   $0x22ad
    17ea:	50                   	push   %eax
    17eb:	e8 c8 f0 ff ff       	call   8b8 <APLoadBitmap>
    17f0:	83 c4 0c             	add    $0xc,%esp
    17f3:	8b 45 98             	mov    -0x68(%ebp),%eax
    17f6:	a3 5c 29 00 00       	mov    %eax,0x295c
    17fb:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17fe:	a3 60 29 00 00       	mov    %eax,0x2960
    1803:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1806:	a3 64 29 00 00       	mov    %eax,0x2964
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    180b:	83 ec 04             	sub    $0x4,%esp
    180e:	ff 35 64 29 00 00    	pushl  0x2964
    1814:	ff 35 60 29 00 00    	pushl  0x2960
    181a:	ff 35 5c 29 00 00    	pushl  0x295c
    1820:	e8 cd f2 ff ff       	call   af2 <APCreateCompatibleDCFromBitmap>
    1825:	83 c4 10             	add    $0x10,%esp
    1828:	a3 4c 29 00 00       	mov    %eax,0x294c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    182d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1830:	83 ec 08             	sub    $0x8,%esp
    1833:	68 bc 22 00 00       	push   $0x22bc
    1838:	50                   	push   %eax
    1839:	e8 7a f0 ff ff       	call   8b8 <APLoadBitmap>
    183e:	83 c4 0c             	add    $0xc,%esp
    1841:	8b 45 98             	mov    -0x68(%ebp),%eax
    1844:	a3 50 29 00 00       	mov    %eax,0x2950
    1849:	8b 45 9c             	mov    -0x64(%ebp),%eax
    184c:	a3 54 29 00 00       	mov    %eax,0x2954
    1851:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1854:	a3 58 29 00 00       	mov    %eax,0x2958
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1859:	83 ec 04             	sub    $0x4,%esp
    185c:	ff 35 58 29 00 00    	pushl  0x2958
    1862:	ff 35 54 29 00 00    	pushl  0x2954
    1868:	ff 35 50 29 00 00    	pushl  0x2950
    186e:	e8 7f f2 ff ff       	call   af2 <APCreateCompatibleDCFromBitmap>
    1873:	83 c4 10             	add    $0x10,%esp
    1876:	a3 00 29 00 00       	mov    %eax,0x2900
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    187b:	8d 45 98             	lea    -0x68(%ebp),%eax
    187e:	83 ec 08             	sub    $0x8,%esp
    1881:	68 cb 22 00 00       	push   $0x22cb
    1886:	50                   	push   %eax
    1887:	e8 2c f0 ff ff       	call   8b8 <APLoadBitmap>
    188c:	83 c4 0c             	add    $0xc,%esp
    188f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1892:	a3 34 29 00 00       	mov    %eax,0x2934
    1897:	8b 45 9c             	mov    -0x64(%ebp),%eax
    189a:	a3 38 29 00 00       	mov    %eax,0x2938
    189f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18a2:	a3 3c 29 00 00       	mov    %eax,0x293c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    18a7:	83 ec 04             	sub    $0x4,%esp
    18aa:	ff 35 3c 29 00 00    	pushl  0x293c
    18b0:	ff 35 38 29 00 00    	pushl  0x2938
    18b6:	ff 35 34 29 00 00    	pushl  0x2934
    18bc:	e8 31 f2 ff ff       	call   af2 <APCreateCompatibleDCFromBitmap>
    18c1:	83 c4 10             	add    $0x10,%esp
    18c4:	a3 68 29 00 00       	mov    %eax,0x2968
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    18c9:	8d 45 98             	lea    -0x68(%ebp),%eax
    18cc:	83 ec 08             	sub    $0x8,%esp
    18cf:	68 d9 22 00 00       	push   $0x22d9
    18d4:	50                   	push   %eax
    18d5:	e8 de ef ff ff       	call   8b8 <APLoadBitmap>
    18da:	83 c4 0c             	add    $0xc,%esp
    18dd:	8b 45 98             	mov    -0x68(%ebp),%eax
    18e0:	a3 10 29 00 00       	mov    %eax,0x2910
    18e5:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18e8:	a3 14 29 00 00       	mov    %eax,0x2914
    18ed:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18f0:	a3 18 29 00 00       	mov    %eax,0x2918
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    18f5:	83 ec 04             	sub    $0x4,%esp
    18f8:	ff 35 18 29 00 00    	pushl  0x2918
    18fe:	ff 35 14 29 00 00    	pushl  0x2914
    1904:	ff 35 10 29 00 00    	pushl  0x2910
    190a:	e8 e3 f1 ff ff       	call   af2 <APCreateCompatibleDCFromBitmap>
    190f:	83 c4 10             	add    $0x10,%esp
    1912:	a3 30 29 00 00       	mov    %eax,0x2930
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1917:	8d 45 98             	lea    -0x68(%ebp),%eax
    191a:	83 ec 08             	sub    $0x8,%esp
    191d:	68 e9 22 00 00       	push   $0x22e9
    1922:	50                   	push   %eax
    1923:	e8 90 ef ff ff       	call   8b8 <APLoadBitmap>
    1928:	83 c4 0c             	add    $0xc,%esp
    192b:	8b 45 98             	mov    -0x68(%ebp),%eax
    192e:	a3 04 29 00 00       	mov    %eax,0x2904
    1933:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1936:	a3 08 29 00 00       	mov    %eax,0x2908
    193b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    193e:	a3 0c 29 00 00       	mov    %eax,0x290c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1943:	83 ec 04             	sub    $0x4,%esp
    1946:	ff 35 0c 29 00 00    	pushl  0x290c
    194c:	ff 35 08 29 00 00    	pushl  0x2908
    1952:	ff 35 04 29 00 00    	pushl  0x2904
    1958:	e8 95 f1 ff ff       	call   af2 <APCreateCompatibleDCFromBitmap>
    195d:	83 c4 10             	add    $0x10,%esp
    1960:	a3 1c 29 00 00       	mov    %eax,0x291c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1965:	8d 45 98             	lea    -0x68(%ebp),%eax
    1968:	83 ec 08             	sub    $0x8,%esp
    196b:	68 fb 22 00 00       	push   $0x22fb
    1970:	50                   	push   %eax
    1971:	e8 42 ef ff ff       	call   8b8 <APLoadBitmap>
    1976:	83 c4 0c             	add    $0xc,%esp
    1979:	8b 45 98             	mov    -0x68(%ebp),%eax
    197c:	a3 40 29 00 00       	mov    %eax,0x2940
    1981:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1984:	a3 44 29 00 00       	mov    %eax,0x2944
    1989:	8b 45 a0             	mov    -0x60(%ebp),%eax
    198c:	a3 48 29 00 00       	mov    %eax,0x2948
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1991:	83 ec 04             	sub    $0x4,%esp
    1994:	ff 35 48 29 00 00    	pushl  0x2948
    199a:	ff 35 44 29 00 00    	pushl  0x2944
    19a0:	ff 35 40 29 00 00    	pushl  0x2940
    19a6:	e8 47 f1 ff ff       	call   af2 <APCreateCompatibleDCFromBitmap>
    19ab:	83 c4 10             	add    $0x10,%esp
    19ae:	a3 6c 29 00 00       	mov    %eax,0x296c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    19b3:	8b 45 08             	mov    0x8(%ebp),%eax
    19b6:	8b 40 08             	mov    0x8(%eax),%eax
    19b9:	85 c0                	test   %eax,%eax
    19bb:	75 17                	jne    19d4 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    19bd:	83 ec 08             	sub    $0x8,%esp
    19c0:	68 0c 23 00 00       	push   $0x230c
    19c5:	6a 01                	push   $0x1
    19c7:	e8 66 ea ff ff       	call   432 <printf>
    19cc:	83 c4 10             	add    $0x10,%esp
        return;
    19cf:	e9 a0 04 00 00       	jmp    1e74 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    19d4:	8b 45 08             	mov    0x8(%ebp),%eax
    19d7:	8b 40 10             	mov    0x10(%eax),%eax
    19da:	85 c0                	test   %eax,%eax
    19dc:	7e 10                	jle    19ee <APGridPaint+0x27d>
    19de:	8b 45 08             	mov    0x8(%ebp),%eax
    19e1:	8b 50 14             	mov    0x14(%eax),%edx
    19e4:	8b 45 08             	mov    0x8(%ebp),%eax
    19e7:	8b 40 10             	mov    0x10(%eax),%eax
    19ea:	39 c2                	cmp    %eax,%edx
    19ec:	7c 17                	jl     1a05 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    19ee:	83 ec 08             	sub    $0x8,%esp
    19f1:	68 32 23 00 00       	push   $0x2332
    19f6:	6a 01                	push   $0x1
    19f8:	e8 35 ea ff ff       	call   432 <printf>
    19fd:	83 c4 10             	add    $0x10,%esp
        return;
    1a00:	e9 6f 04 00 00       	jmp    1e74 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1a05:	8b 45 08             	mov    0x8(%ebp),%eax
    1a08:	8b 40 14             	mov    0x14(%eax),%eax
    1a0b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a11:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a14:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a17:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a1a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a21:	e9 96 03 00 00       	jmp    1dbc <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a26:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a2d:	e9 7c 03 00 00       	jmp    1dae <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a35:	c1 e0 04             	shl    $0x4,%eax
    1a38:	89 c2                	mov    %eax,%edx
    1a3a:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a3d:	01 c2                	add    %eax,%edx
    1a3f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a42:	01 d0                	add    %edx,%eax
    1a44:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a47:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4a:	8b 40 0c             	mov    0xc(%eax),%eax
    1a4d:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a50:	c1 e2 02             	shl    $0x2,%edx
    1a53:	01 d0                	add    %edx,%eax
    1a55:	8b 00                	mov    (%eax),%eax
    1a57:	83 f8 07             	cmp    $0x7,%eax
    1a5a:	0f 87 49 03 00 00    	ja     1da9 <APGridPaint+0x638>
    1a60:	8b 04 85 48 23 00 00 	mov    0x2348(,%eax,4),%eax
    1a67:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1a69:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1a6c:	6a 0c                	push   $0xc
    1a6e:	6a 0c                	push   $0xc
    1a70:	6a 0c                	push   $0xc
    1a72:	50                   	push   %eax
    1a73:	e8 df f8 ff ff       	call   1357 <RGB>
    1a78:	83 c4 0c             	add    $0xc,%esp
    1a7b:	8b 1d 2c 29 00 00    	mov    0x292c,%ebx
    1a81:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a84:	6b c8 32             	imul   $0x32,%eax,%ecx
    1a87:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a8a:	6b c0 32             	imul   $0x32,%eax,%eax
    1a8d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1a90:	8b 45 08             	mov    0x8(%ebp),%eax
    1a93:	8d 78 3c             	lea    0x3c(%eax),%edi
    1a96:	83 ec 0c             	sub    $0xc,%esp
    1a99:	83 ec 04             	sub    $0x4,%esp
    1a9c:	89 e0                	mov    %esp,%eax
    1a9e:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1aa2:	66 89 30             	mov    %si,(%eax)
    1aa5:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1aa9:	88 50 02             	mov    %dl,0x2(%eax)
    1aac:	6a 32                	push   $0x32
    1aae:	6a 32                	push   $0x32
    1ab0:	6a 00                	push   $0x0
    1ab2:	6a 00                	push   $0x0
    1ab4:	53                   	push   %ebx
    1ab5:	51                   	push   %ecx
    1ab6:	ff 75 94             	pushl  -0x6c(%ebp)
    1ab9:	57                   	push   %edi
    1aba:	e8 f4 f6 ff ff       	call   11b3 <APDcCopy>
    1abf:	83 c4 30             	add    $0x30,%esp
                    break;
    1ac2:	e9 e3 02 00 00       	jmp    1daa <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1ac7:	8d 45 98             	lea    -0x68(%ebp),%eax
    1aca:	6a 69                	push   $0x69
    1acc:	6a 69                	push   $0x69
    1ace:	6a 69                	push   $0x69
    1ad0:	50                   	push   %eax
    1ad1:	e8 81 f8 ff ff       	call   1357 <RGB>
    1ad6:	83 c4 0c             	add    $0xc,%esp
    1ad9:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1add:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1ae1:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ae5:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1ae8:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1aef:	8d 45 98             	lea    -0x68(%ebp),%eax
    1af2:	6a 69                	push   $0x69
    1af4:	6a 69                	push   $0x69
    1af6:	6a 69                	push   $0x69
    1af8:	50                   	push   %eax
    1af9:	e8 59 f8 ff ff       	call   1357 <RGB>
    1afe:	83 c4 0c             	add    $0xc,%esp
    1b01:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b05:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1b09:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b0d:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b10:	8b 45 08             	mov    0x8(%ebp),%eax
    1b13:	8d 50 3c             	lea    0x3c(%eax),%edx
    1b16:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b19:	ff 75 b0             	pushl  -0x50(%ebp)
    1b1c:	ff 75 ac             	pushl  -0x54(%ebp)
    1b1f:	52                   	push   %edx
    1b20:	50                   	push   %eax
    1b21:	e8 61 f0 ff ff       	call   b87 <APSetPen>
    1b26:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b29:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2c:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1b2f:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b32:	83 ec 04             	sub    $0x4,%esp
    1b35:	83 ec 04             	sub    $0x4,%esp
    1b38:	89 e0                	mov    %esp,%eax
    1b3a:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1b3e:	66 89 08             	mov    %cx,(%eax)
    1b41:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1b45:	88 48 02             	mov    %cl,0x2(%eax)
    1b48:	53                   	push   %ebx
    1b49:	52                   	push   %edx
    1b4a:	e8 71 f0 ff ff       	call   bc0 <APSetBrush>
    1b4f:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b55:	6b d0 32             	imul   $0x32,%eax,%edx
    1b58:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b5b:	6b c0 32             	imul   $0x32,%eax,%eax
    1b5e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b61:	83 c1 3c             	add    $0x3c,%ecx
    1b64:	83 ec 0c             	sub    $0xc,%esp
    1b67:	6a 32                	push   $0x32
    1b69:	6a 32                	push   $0x32
    1b6b:	52                   	push   %edx
    1b6c:	50                   	push   %eax
    1b6d:	51                   	push   %ecx
    1b6e:	e8 35 f4 ff ff       	call   fa8 <APDrawRect>
    1b73:	83 c4 20             	add    $0x20,%esp
                    break;
    1b76:	e9 2f 02 00 00       	jmp    1daa <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b7b:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1b7e:	6a 0c                	push   $0xc
    1b80:	6a 0c                	push   $0xc
    1b82:	6a 0c                	push   $0xc
    1b84:	50                   	push   %eax
    1b85:	e8 cd f7 ff ff       	call   1357 <RGB>
    1b8a:	83 c4 0c             	add    $0xc,%esp
    1b8d:	8b 1d 6c 29 00 00    	mov    0x296c,%ebx
    1b93:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b96:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b99:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b9c:	6b c0 32             	imul   $0x32,%eax,%eax
    1b9f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ba2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba5:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ba8:	83 ec 0c             	sub    $0xc,%esp
    1bab:	83 ec 04             	sub    $0x4,%esp
    1bae:	89 e0                	mov    %esp,%eax
    1bb0:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1bb4:	66 89 30             	mov    %si,(%eax)
    1bb7:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1bbb:	88 50 02             	mov    %dl,0x2(%eax)
    1bbe:	6a 32                	push   $0x32
    1bc0:	6a 32                	push   $0x32
    1bc2:	6a 00                	push   $0x0
    1bc4:	6a 00                	push   $0x0
    1bc6:	53                   	push   %ebx
    1bc7:	51                   	push   %ecx
    1bc8:	ff 75 94             	pushl  -0x6c(%ebp)
    1bcb:	57                   	push   %edi
    1bcc:	e8 e2 f5 ff ff       	call   11b3 <APDcCopy>
    1bd1:	83 c4 30             	add    $0x30,%esp
                    break;
    1bd4:	e9 d1 01 00 00       	jmp    1daa <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bd9:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1bdc:	6a 0c                	push   $0xc
    1bde:	6a 0c                	push   $0xc
    1be0:	6a 0c                	push   $0xc
    1be2:	50                   	push   %eax
    1be3:	e8 6f f7 ff ff       	call   1357 <RGB>
    1be8:	83 c4 0c             	add    $0xc,%esp
    1beb:	8b 1d 4c 29 00 00    	mov    0x294c,%ebx
    1bf1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bf4:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bf7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bfa:	6b c0 32             	imul   $0x32,%eax,%eax
    1bfd:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c00:	8b 45 08             	mov    0x8(%ebp),%eax
    1c03:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c06:	83 ec 0c             	sub    $0xc,%esp
    1c09:	83 ec 04             	sub    $0x4,%esp
    1c0c:	89 e0                	mov    %esp,%eax
    1c0e:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1c12:	66 89 30             	mov    %si,(%eax)
    1c15:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c19:	88 50 02             	mov    %dl,0x2(%eax)
    1c1c:	6a 32                	push   $0x32
    1c1e:	6a 32                	push   $0x32
    1c20:	6a 00                	push   $0x0
    1c22:	6a 00                	push   $0x0
    1c24:	53                   	push   %ebx
    1c25:	51                   	push   %ecx
    1c26:	ff 75 94             	pushl  -0x6c(%ebp)
    1c29:	57                   	push   %edi
    1c2a:	e8 84 f5 ff ff       	call   11b3 <APDcCopy>
    1c2f:	83 c4 30             	add    $0x30,%esp
                    break;
    1c32:	e9 73 01 00 00       	jmp    1daa <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c37:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c3a:	6a 0c                	push   $0xc
    1c3c:	6a 0c                	push   $0xc
    1c3e:	6a 0c                	push   $0xc
    1c40:	50                   	push   %eax
    1c41:	e8 11 f7 ff ff       	call   1357 <RGB>
    1c46:	83 c4 0c             	add    $0xc,%esp
    1c49:	8b 1d 30 29 00 00    	mov    0x2930,%ebx
    1c4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c52:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c55:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c58:	6b c0 32             	imul   $0x32,%eax,%eax
    1c5b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c5e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c61:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c64:	83 ec 0c             	sub    $0xc,%esp
    1c67:	83 ec 04             	sub    $0x4,%esp
    1c6a:	89 e0                	mov    %esp,%eax
    1c6c:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1c70:	66 89 30             	mov    %si,(%eax)
    1c73:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1c77:	88 50 02             	mov    %dl,0x2(%eax)
    1c7a:	6a 32                	push   $0x32
    1c7c:	6a 32                	push   $0x32
    1c7e:	6a 00                	push   $0x0
    1c80:	6a 00                	push   $0x0
    1c82:	53                   	push   %ebx
    1c83:	51                   	push   %ecx
    1c84:	ff 75 94             	pushl  -0x6c(%ebp)
    1c87:	57                   	push   %edi
    1c88:	e8 26 f5 ff ff       	call   11b3 <APDcCopy>
    1c8d:	83 c4 30             	add    $0x30,%esp
                    break;
    1c90:	e9 15 01 00 00       	jmp    1daa <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c95:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1c98:	6a 0c                	push   $0xc
    1c9a:	6a 0c                	push   $0xc
    1c9c:	6a 0c                	push   $0xc
    1c9e:	50                   	push   %eax
    1c9f:	e8 b3 f6 ff ff       	call   1357 <RGB>
    1ca4:	83 c4 0c             	add    $0xc,%esp
    1ca7:	8b 1d 68 29 00 00    	mov    0x2968,%ebx
    1cad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cb0:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cb3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cb6:	6b c0 32             	imul   $0x32,%eax,%eax
    1cb9:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cbc:	8b 45 08             	mov    0x8(%ebp),%eax
    1cbf:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cc2:	83 ec 0c             	sub    $0xc,%esp
    1cc5:	83 ec 04             	sub    $0x4,%esp
    1cc8:	89 e0                	mov    %esp,%eax
    1cca:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1cce:	66 89 30             	mov    %si,(%eax)
    1cd1:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1cd5:	88 50 02             	mov    %dl,0x2(%eax)
    1cd8:	6a 32                	push   $0x32
    1cda:	6a 32                	push   $0x32
    1cdc:	6a 00                	push   $0x0
    1cde:	6a 00                	push   $0x0
    1ce0:	53                   	push   %ebx
    1ce1:	51                   	push   %ecx
    1ce2:	ff 75 94             	pushl  -0x6c(%ebp)
    1ce5:	57                   	push   %edi
    1ce6:	e8 c8 f4 ff ff       	call   11b3 <APDcCopy>
    1ceb:	83 c4 30             	add    $0x30,%esp
                    break;
    1cee:	e9 b7 00 00 00       	jmp    1daa <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cf3:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1cf6:	6a 0c                	push   $0xc
    1cf8:	6a 0c                	push   $0xc
    1cfa:	6a 0c                	push   $0xc
    1cfc:	50                   	push   %eax
    1cfd:	e8 55 f6 ff ff       	call   1357 <RGB>
    1d02:	83 c4 0c             	add    $0xc,%esp
    1d05:	8b 1d 00 29 00 00    	mov    0x2900,%ebx
    1d0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d0e:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d11:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d14:	6b c0 32             	imul   $0x32,%eax,%eax
    1d17:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d1d:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d20:	83 ec 0c             	sub    $0xc,%esp
    1d23:	83 ec 04             	sub    $0x4,%esp
    1d26:	89 e0                	mov    %esp,%eax
    1d28:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d2c:	66 89 30             	mov    %si,(%eax)
    1d2f:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d33:	88 50 02             	mov    %dl,0x2(%eax)
    1d36:	6a 32                	push   $0x32
    1d38:	6a 32                	push   $0x32
    1d3a:	6a 00                	push   $0x0
    1d3c:	6a 00                	push   $0x0
    1d3e:	53                   	push   %ebx
    1d3f:	51                   	push   %ecx
    1d40:	ff 75 94             	pushl  -0x6c(%ebp)
    1d43:	57                   	push   %edi
    1d44:	e8 6a f4 ff ff       	call   11b3 <APDcCopy>
    1d49:	83 c4 30             	add    $0x30,%esp
                    break;
    1d4c:	eb 5c                	jmp    1daa <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d4e:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d51:	6a 0c                	push   $0xc
    1d53:	6a 0c                	push   $0xc
    1d55:	6a 0c                	push   $0xc
    1d57:	50                   	push   %eax
    1d58:	e8 fa f5 ff ff       	call   1357 <RGB>
    1d5d:	83 c4 0c             	add    $0xc,%esp
    1d60:	8b 1d 1c 29 00 00    	mov    0x291c,%ebx
    1d66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d69:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d6c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d6f:	6b c0 32             	imul   $0x32,%eax,%eax
    1d72:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d75:	8b 45 08             	mov    0x8(%ebp),%eax
    1d78:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d7b:	83 ec 0c             	sub    $0xc,%esp
    1d7e:	83 ec 04             	sub    $0x4,%esp
    1d81:	89 e0                	mov    %esp,%eax
    1d83:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1d87:	66 89 30             	mov    %si,(%eax)
    1d8a:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1d8e:	88 50 02             	mov    %dl,0x2(%eax)
    1d91:	6a 32                	push   $0x32
    1d93:	6a 32                	push   $0x32
    1d95:	6a 00                	push   $0x0
    1d97:	6a 00                	push   $0x0
    1d99:	53                   	push   %ebx
    1d9a:	51                   	push   %ecx
    1d9b:	ff 75 94             	pushl  -0x6c(%ebp)
    1d9e:	57                   	push   %edi
    1d9f:	e8 0f f4 ff ff       	call   11b3 <APDcCopy>
    1da4:	83 c4 30             	add    $0x30,%esp
                    break;
    1da7:	eb 01                	jmp    1daa <APGridPaint+0x639>
                default: break;
    1da9:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1daa:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1dae:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1db2:	0f 8e 7a fc ff ff    	jle    1a32 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1db8:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1dbc:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1dc0:	0f 8e 60 fc ff ff    	jle    1a26 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1dc6:	8d 45 98             	lea    -0x68(%ebp),%eax
    1dc9:	68 cd 00 00 00       	push   $0xcd
    1dce:	6a 74                	push   $0x74
    1dd0:	6a 18                	push   $0x18
    1dd2:	50                   	push   %eax
    1dd3:	e8 7f f5 ff ff       	call   1357 <RGB>
    1dd8:	83 c4 0c             	add    $0xc,%esp
    1ddb:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ddf:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1de3:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1de7:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1dea:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1df1:	8d 45 98             	lea    -0x68(%ebp),%eax
    1df4:	68 cd 00 00 00       	push   $0xcd
    1df9:	6a 74                	push   $0x74
    1dfb:	6a 18                	push   $0x18
    1dfd:	50                   	push   %eax
    1dfe:	e8 54 f5 ff ff       	call   1357 <RGB>
    1e03:	83 c4 0c             	add    $0xc,%esp
    1e06:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e0a:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1e0e:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e12:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1e15:	8b 45 08             	mov    0x8(%ebp),%eax
    1e18:	8d 50 58             	lea    0x58(%eax),%edx
    1e1b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e1e:	ff 75 bc             	pushl  -0x44(%ebp)
    1e21:	ff 75 b8             	pushl  -0x48(%ebp)
    1e24:	52                   	push   %edx
    1e25:	50                   	push   %eax
    1e26:	e8 5c ed ff ff       	call   b87 <APSetPen>
    1e2b:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1e2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e31:	8d 58 58             	lea    0x58(%eax),%ebx
    1e34:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e37:	83 ec 04             	sub    $0x4,%esp
    1e3a:	83 ec 04             	sub    $0x4,%esp
    1e3d:	89 e0                	mov    %esp,%eax
    1e3f:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1e43:	66 89 08             	mov    %cx,(%eax)
    1e46:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1e4a:	88 48 02             	mov    %cl,0x2(%eax)
    1e4d:	53                   	push   %ebx
    1e4e:	52                   	push   %edx
    1e4f:	e8 6c ed ff ff       	call   bc0 <APSetBrush>
    1e54:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1e57:	8b 45 08             	mov    0x8(%ebp),%eax
    1e5a:	83 c0 58             	add    $0x58,%eax
    1e5d:	83 ec 0c             	sub    $0xc,%esp
    1e60:	6a 32                	push   $0x32
    1e62:	68 20 03 00 00       	push   $0x320
    1e67:	6a 00                	push   $0x0
    1e69:	6a 00                	push   $0x0
    1e6b:	50                   	push   %eax
    1e6c:	e8 37 f1 ff ff       	call   fa8 <APDrawRect>
    1e71:	83 c4 20             	add    $0x20,%esp
}
    1e74:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1e77:	5b                   	pop    %ebx
    1e78:	5e                   	pop    %esi
    1e79:	5f                   	pop    %edi
    1e7a:	5d                   	pop    %ebp
    1e7b:	c3                   	ret    

00001e7c <random>:
//

#include "APLib.h"

int random(int seed)
{
    1e7c:	55                   	push   %ebp
    1e7d:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1e7f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1e83:	7e 08                	jle    1e8d <random+0x11>
{
rand_num = seed;
    1e85:	8b 45 08             	mov    0x8(%ebp),%eax
    1e88:	a3 d8 28 00 00       	mov    %eax,0x28d8
}
rand_num *= 3;
    1e8d:	8b 15 d8 28 00 00    	mov    0x28d8,%edx
    1e93:	89 d0                	mov    %edx,%eax
    1e95:	01 c0                	add    %eax,%eax
    1e97:	01 d0                	add    %edx,%eax
    1e99:	a3 d8 28 00 00       	mov    %eax,0x28d8
if (rand_num < 0)
    1e9e:	a1 d8 28 00 00       	mov    0x28d8,%eax
    1ea3:	85 c0                	test   %eax,%eax
    1ea5:	79 0c                	jns    1eb3 <random+0x37>
{
rand_num *= (-1);
    1ea7:	a1 d8 28 00 00       	mov    0x28d8,%eax
    1eac:	f7 d8                	neg    %eax
    1eae:	a3 d8 28 00 00       	mov    %eax,0x28d8
}
return rand_num % 997;
    1eb3:	8b 0d d8 28 00 00    	mov    0x28d8,%ecx
    1eb9:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1ebe:	89 c8                	mov    %ecx,%eax
    1ec0:	f7 ea                	imul   %edx
    1ec2:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1ec5:	c1 f8 09             	sar    $0x9,%eax
    1ec8:	89 c2                	mov    %eax,%edx
    1eca:	89 c8                	mov    %ecx,%eax
    1ecc:	c1 f8 1f             	sar    $0x1f,%eax
    1ecf:	29 c2                	sub    %eax,%edx
    1ed1:	89 d0                	mov    %edx,%eax
    1ed3:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1ed9:	29 c1                	sub    %eax,%ecx
    1edb:	89 c8                	mov    %ecx,%eax
}
    1edd:	5d                   	pop    %ebp
    1ede:	c3                   	ret    

00001edf <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1edf:	55                   	push   %ebp
    1ee0:	89 e5                	mov    %esp,%ebp
    1ee2:	53                   	push   %ebx
    1ee3:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1ee6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1eed:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1ef1:	74 17                	je     1f0a <sprintint+0x2b>
    1ef3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1ef7:	79 11                	jns    1f0a <sprintint+0x2b>
        neg = 1;
    1ef9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1f00:	8b 45 10             	mov    0x10(%ebp),%eax
    1f03:	f7 d8                	neg    %eax
    1f05:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f08:	eb 06                	jmp    1f10 <sprintint+0x31>
    } else {
        x = xx;
    1f0a:	8b 45 10             	mov    0x10(%ebp),%eax
    1f0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1f10:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1f17:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1f1a:	8d 41 01             	lea    0x1(%ecx),%eax
    1f1d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1f20:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f23:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f26:	ba 00 00 00 00       	mov    $0x0,%edx
    1f2b:	f7 f3                	div    %ebx
    1f2d:	89 d0                	mov    %edx,%eax
    1f2f:	0f b6 80 dc 28 00 00 	movzbl 0x28dc(%eax),%eax
    1f36:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1f3a:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f40:	ba 00 00 00 00       	mov    $0x0,%edx
    1f45:	f7 f3                	div    %ebx
    1f47:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f4a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f4e:	75 c7                	jne    1f17 <sprintint+0x38>
    if(neg)
    1f50:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f54:	74 0e                	je     1f64 <sprintint+0x85>
        buf[i++] = '-';
    1f56:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f59:	8d 50 01             	lea    0x1(%eax),%edx
    1f5c:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1f5f:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1f64:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f67:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1f6a:	eb 1b                	jmp    1f87 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1f6c:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f6f:	8b 00                	mov    (%eax),%eax
    1f71:	8d 48 01             	lea    0x1(%eax),%ecx
    1f74:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f77:	89 0a                	mov    %ecx,(%edx)
    1f79:	89 c2                	mov    %eax,%edx
    1f7b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f7e:	01 d0                	add    %edx,%eax
    1f80:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1f83:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1f87:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1f8b:	7f df                	jg     1f6c <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1f8d:	eb 21                	jmp    1fb0 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1f8f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f92:	8b 00                	mov    (%eax),%eax
    1f94:	8d 48 01             	lea    0x1(%eax),%ecx
    1f97:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f9a:	89 0a                	mov    %ecx,(%edx)
    1f9c:	89 c2                	mov    %eax,%edx
    1f9e:	8b 45 08             	mov    0x8(%ebp),%eax
    1fa1:	01 c2                	add    %eax,%edx
    1fa3:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1fa6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fa9:	01 c8                	add    %ecx,%eax
    1fab:	0f b6 00             	movzbl (%eax),%eax
    1fae:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fb0:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1fb4:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1fb8:	79 d5                	jns    1f8f <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1fba:	90                   	nop
    1fbb:	83 c4 20             	add    $0x20,%esp
    1fbe:	5b                   	pop    %ebx
    1fbf:	5d                   	pop    %ebp
    1fc0:	c3                   	ret    

00001fc1 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1fc1:	55                   	push   %ebp
    1fc2:	89 e5                	mov    %esp,%ebp
    1fc4:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1fc7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1fce:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1fd5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1fdc:	8d 45 0c             	lea    0xc(%ebp),%eax
    1fdf:	83 c0 04             	add    $0x4,%eax
    1fe2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1fe5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1fec:	e9 d9 01 00 00       	jmp    21ca <sprintf+0x209>
        c = fmt[i] & 0xff;
    1ff1:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ff4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ff7:	01 d0                	add    %edx,%eax
    1ff9:	0f b6 00             	movzbl (%eax),%eax
    1ffc:	0f be c0             	movsbl %al,%eax
    1fff:	25 ff 00 00 00       	and    $0xff,%eax
    2004:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2007:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    200b:	75 2c                	jne    2039 <sprintf+0x78>
            if(c == '%'){
    200d:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2011:	75 0c                	jne    201f <sprintf+0x5e>
                state = '%';
    2013:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    201a:	e9 a7 01 00 00       	jmp    21c6 <sprintf+0x205>
            } else {
                dst[j++] = c;
    201f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2022:	8d 50 01             	lea    0x1(%eax),%edx
    2025:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2028:	89 c2                	mov    %eax,%edx
    202a:	8b 45 08             	mov    0x8(%ebp),%eax
    202d:	01 d0                	add    %edx,%eax
    202f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2032:	88 10                	mov    %dl,(%eax)
    2034:	e9 8d 01 00 00       	jmp    21c6 <sprintf+0x205>
            }
        } else if(state == '%'){
    2039:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    203d:	0f 85 83 01 00 00    	jne    21c6 <sprintf+0x205>
            if(c == 'd'){
    2043:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2047:	75 4c                	jne    2095 <sprintf+0xd4>
                buf[bi] = '\0';
    2049:	8d 55 ce             	lea    -0x32(%ebp),%edx
    204c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    204f:	01 d0                	add    %edx,%eax
    2051:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2054:	83 ec 0c             	sub    $0xc,%esp
    2057:	8d 45 ce             	lea    -0x32(%ebp),%eax
    205a:	50                   	push   %eax
    205b:	e8 91 e1 ff ff       	call   1f1 <atoi>
    2060:	83 c4 10             	add    $0x10,%esp
    2063:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2066:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    206d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2070:	8b 00                	mov    (%eax),%eax
    2072:	83 ec 08             	sub    $0x8,%esp
    2075:	ff 75 d8             	pushl  -0x28(%ebp)
    2078:	6a 01                	push   $0x1
    207a:	6a 0a                	push   $0xa
    207c:	50                   	push   %eax
    207d:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2080:	50                   	push   %eax
    2081:	ff 75 08             	pushl  0x8(%ebp)
    2084:	e8 56 fe ff ff       	call   1edf <sprintint>
    2089:	83 c4 20             	add    $0x20,%esp
                ap++;
    208c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2090:	e9 2a 01 00 00       	jmp    21bf <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2095:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2099:	74 06                	je     20a1 <sprintf+0xe0>
    209b:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    209f:	75 4c                	jne    20ed <sprintf+0x12c>
                buf[bi] = '\0';
    20a1:	8d 55 ce             	lea    -0x32(%ebp),%edx
    20a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20a7:	01 d0                	add    %edx,%eax
    20a9:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    20ac:	83 ec 0c             	sub    $0xc,%esp
    20af:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20b2:	50                   	push   %eax
    20b3:	e8 39 e1 ff ff       	call   1f1 <atoi>
    20b8:	83 c4 10             	add    $0x10,%esp
    20bb:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    20be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    20c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20c8:	8b 00                	mov    (%eax),%eax
    20ca:	83 ec 08             	sub    $0x8,%esp
    20cd:	ff 75 dc             	pushl  -0x24(%ebp)
    20d0:	6a 00                	push   $0x0
    20d2:	6a 10                	push   $0x10
    20d4:	50                   	push   %eax
    20d5:	8d 45 c8             	lea    -0x38(%ebp),%eax
    20d8:	50                   	push   %eax
    20d9:	ff 75 08             	pushl  0x8(%ebp)
    20dc:	e8 fe fd ff ff       	call   1edf <sprintint>
    20e1:	83 c4 20             	add    $0x20,%esp
                ap++;
    20e4:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    20e8:	e9 d2 00 00 00       	jmp    21bf <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    20ed:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    20f1:	75 46                	jne    2139 <sprintf+0x178>
                s = (char*)*ap;
    20f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20f6:	8b 00                	mov    (%eax),%eax
    20f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    20fb:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    20ff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2103:	75 25                	jne    212a <sprintf+0x169>
                    s = "(null)";
    2105:	c7 45 f4 68 23 00 00 	movl   $0x2368,-0xc(%ebp)
                while(*s != 0){
    210c:	eb 1c                	jmp    212a <sprintf+0x169>
                    dst[j++] = *s;
    210e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2111:	8d 50 01             	lea    0x1(%eax),%edx
    2114:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2117:	89 c2                	mov    %eax,%edx
    2119:	8b 45 08             	mov    0x8(%ebp),%eax
    211c:	01 c2                	add    %eax,%edx
    211e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2121:	0f b6 00             	movzbl (%eax),%eax
    2124:	88 02                	mov    %al,(%edx)
                    s++;
    2126:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    212a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    212d:	0f b6 00             	movzbl (%eax),%eax
    2130:	84 c0                	test   %al,%al
    2132:	75 da                	jne    210e <sprintf+0x14d>
    2134:	e9 86 00 00 00       	jmp    21bf <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2139:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    213d:	75 1d                	jne    215c <sprintf+0x19b>
                dst[j++] = *ap;
    213f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2142:	8d 50 01             	lea    0x1(%eax),%edx
    2145:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2148:	89 c2                	mov    %eax,%edx
    214a:	8b 45 08             	mov    0x8(%ebp),%eax
    214d:	01 c2                	add    %eax,%edx
    214f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2152:	8b 00                	mov    (%eax),%eax
    2154:	88 02                	mov    %al,(%edx)
                ap++;
    2156:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    215a:	eb 63                	jmp    21bf <sprintf+0x1fe>
            } else if(c == '%'){
    215c:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2160:	75 17                	jne    2179 <sprintf+0x1b8>
                dst[j++] = c;
    2162:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2165:	8d 50 01             	lea    0x1(%eax),%edx
    2168:	89 55 c8             	mov    %edx,-0x38(%ebp)
    216b:	89 c2                	mov    %eax,%edx
    216d:	8b 45 08             	mov    0x8(%ebp),%eax
    2170:	01 d0                	add    %edx,%eax
    2172:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2175:	88 10                	mov    %dl,(%eax)
    2177:	eb 46                	jmp    21bf <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2179:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    217d:	7e 18                	jle    2197 <sprintf+0x1d6>
    217f:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2183:	7f 12                	jg     2197 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2185:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2188:	8d 50 01             	lea    0x1(%eax),%edx
    218b:	89 55 f0             	mov    %edx,-0x10(%ebp)
    218e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2191:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2195:	eb 2f                	jmp    21c6 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2197:	8b 45 c8             	mov    -0x38(%ebp),%eax
    219a:	8d 50 01             	lea    0x1(%eax),%edx
    219d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21a0:	89 c2                	mov    %eax,%edx
    21a2:	8b 45 08             	mov    0x8(%ebp),%eax
    21a5:	01 d0                	add    %edx,%eax
    21a7:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    21aa:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21ad:	8d 50 01             	lea    0x1(%eax),%edx
    21b0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21b3:	89 c2                	mov    %eax,%edx
    21b5:	8b 45 08             	mov    0x8(%ebp),%eax
    21b8:	01 d0                	add    %edx,%eax
    21ba:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21bd:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    21bf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    21c6:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    21ca:	8b 55 0c             	mov    0xc(%ebp),%edx
    21cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    21d0:	01 d0                	add    %edx,%eax
    21d2:	0f b6 00             	movzbl (%eax),%eax
    21d5:	84 c0                	test   %al,%al
    21d7:	0f 85 14 fe ff ff    	jne    1ff1 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    21dd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21e0:	8d 50 01             	lea    0x1(%eax),%edx
    21e3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21e6:	89 c2                	mov    %eax,%edx
    21e8:	8b 45 08             	mov    0x8(%ebp),%eax
    21eb:	01 d0                	add    %edx,%eax
    21ed:	c6 00 00             	movb   $0x0,(%eax)
}
    21f0:	90                   	nop
    21f1:	c9                   	leave  
    21f2:	c3                   	ret    
