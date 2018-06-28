
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

0000034b <changePosition>:
SYSCALL(changePosition)
     34b:	b8 1b 00 00 00       	mov    $0x1b,%eax
     350:	cd 40                	int    $0x40
     352:	c3                   	ret    

00000353 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     353:	55                   	push   %ebp
     354:	89 e5                	mov    %esp,%ebp
     356:	83 ec 18             	sub    $0x18,%esp
     359:	8b 45 0c             	mov    0xc(%ebp),%eax
     35c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     35f:	83 ec 04             	sub    $0x4,%esp
     362:	6a 01                	push   $0x1
     364:	8d 45 f4             	lea    -0xc(%ebp),%eax
     367:	50                   	push   %eax
     368:	ff 75 08             	pushl  0x8(%ebp)
     36b:	e8 33 ff ff ff       	call   2a3 <write>
     370:	83 c4 10             	add    $0x10,%esp
}
     373:	90                   	nop
     374:	c9                   	leave  
     375:	c3                   	ret    

00000376 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     376:	55                   	push   %ebp
     377:	89 e5                	mov    %esp,%ebp
     379:	53                   	push   %ebx
     37a:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     37d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     384:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     388:	74 17                	je     3a1 <printint+0x2b>
     38a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     38e:	79 11                	jns    3a1 <printint+0x2b>
    neg = 1;
     390:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     397:	8b 45 0c             	mov    0xc(%ebp),%eax
     39a:	f7 d8                	neg    %eax
     39c:	89 45 ec             	mov    %eax,-0x14(%ebp)
     39f:	eb 06                	jmp    3a7 <printint+0x31>
  } else {
    x = xx;
     3a1:	8b 45 0c             	mov    0xc(%ebp),%eax
     3a4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3ae:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3b1:	8d 41 01             	lea    0x1(%ecx),%eax
     3b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3b7:	8b 5d 10             	mov    0x10(%ebp),%ebx
     3ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3bd:	ba 00 00 00 00       	mov    $0x0,%edx
     3c2:	f7 f3                	div    %ebx
     3c4:	89 d0                	mov    %edx,%eax
     3c6:	0f b6 80 78 27 00 00 	movzbl 0x2778(%eax),%eax
     3cd:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     3d1:	8b 5d 10             	mov    0x10(%ebp),%ebx
     3d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3d7:	ba 00 00 00 00       	mov    $0x0,%edx
     3dc:	f7 f3                	div    %ebx
     3de:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3e1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     3e5:	75 c7                	jne    3ae <printint+0x38>
  if(neg)
     3e7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3eb:	74 2d                	je     41a <printint+0xa4>
    buf[i++] = '-';
     3ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3f0:	8d 50 01             	lea    0x1(%eax),%edx
     3f3:	89 55 f4             	mov    %edx,-0xc(%ebp)
     3f6:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     3fb:	eb 1d                	jmp    41a <printint+0xa4>
    putc(fd, buf[i]);
     3fd:	8d 55 dc             	lea    -0x24(%ebp),%edx
     400:	8b 45 f4             	mov    -0xc(%ebp),%eax
     403:	01 d0                	add    %edx,%eax
     405:	0f b6 00             	movzbl (%eax),%eax
     408:	0f be c0             	movsbl %al,%eax
     40b:	83 ec 08             	sub    $0x8,%esp
     40e:	50                   	push   %eax
     40f:	ff 75 08             	pushl  0x8(%ebp)
     412:	e8 3c ff ff ff       	call   353 <putc>
     417:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     41a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     41e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     422:	79 d9                	jns    3fd <printint+0x87>
    putc(fd, buf[i]);
}
     424:	90                   	nop
     425:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     428:	c9                   	leave  
     429:	c3                   	ret    

0000042a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     42a:	55                   	push   %ebp
     42b:	89 e5                	mov    %esp,%ebp
     42d:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     430:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     437:	8d 45 0c             	lea    0xc(%ebp),%eax
     43a:	83 c0 04             	add    $0x4,%eax
     43d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     440:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     447:	e9 59 01 00 00       	jmp    5a5 <printf+0x17b>
    c = fmt[i] & 0xff;
     44c:	8b 55 0c             	mov    0xc(%ebp),%edx
     44f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     452:	01 d0                	add    %edx,%eax
     454:	0f b6 00             	movzbl (%eax),%eax
     457:	0f be c0             	movsbl %al,%eax
     45a:	25 ff 00 00 00       	and    $0xff,%eax
     45f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     462:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     466:	75 2c                	jne    494 <printf+0x6a>
      if(c == '%'){
     468:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     46c:	75 0c                	jne    47a <printf+0x50>
        state = '%';
     46e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     475:	e9 27 01 00 00       	jmp    5a1 <printf+0x177>
      } else {
        putc(fd, c);
     47a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     47d:	0f be c0             	movsbl %al,%eax
     480:	83 ec 08             	sub    $0x8,%esp
     483:	50                   	push   %eax
     484:	ff 75 08             	pushl  0x8(%ebp)
     487:	e8 c7 fe ff ff       	call   353 <putc>
     48c:	83 c4 10             	add    $0x10,%esp
     48f:	e9 0d 01 00 00       	jmp    5a1 <printf+0x177>
      }
    } else if(state == '%'){
     494:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     498:	0f 85 03 01 00 00    	jne    5a1 <printf+0x177>
      if(c == 'd'){
     49e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4a2:	75 1e                	jne    4c2 <printf+0x98>
        printint(fd, *ap, 10, 1);
     4a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4a7:	8b 00                	mov    (%eax),%eax
     4a9:	6a 01                	push   $0x1
     4ab:	6a 0a                	push   $0xa
     4ad:	50                   	push   %eax
     4ae:	ff 75 08             	pushl  0x8(%ebp)
     4b1:	e8 c0 fe ff ff       	call   376 <printint>
     4b6:	83 c4 10             	add    $0x10,%esp
        ap++;
     4b9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4bd:	e9 d8 00 00 00       	jmp    59a <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     4c2:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     4c6:	74 06                	je     4ce <printf+0xa4>
     4c8:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     4cc:	75 1e                	jne    4ec <printf+0xc2>
        printint(fd, *ap, 16, 0);
     4ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4d1:	8b 00                	mov    (%eax),%eax
     4d3:	6a 00                	push   $0x0
     4d5:	6a 10                	push   $0x10
     4d7:	50                   	push   %eax
     4d8:	ff 75 08             	pushl  0x8(%ebp)
     4db:	e8 96 fe ff ff       	call   376 <printint>
     4e0:	83 c4 10             	add    $0x10,%esp
        ap++;
     4e3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4e7:	e9 ae 00 00 00       	jmp    59a <printf+0x170>
      } else if(c == 's'){
     4ec:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     4f0:	75 43                	jne    535 <printf+0x10b>
        s = (char*)*ap;
     4f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4f5:	8b 00                	mov    (%eax),%eax
     4f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     4fa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     4fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     502:	75 25                	jne    529 <printf+0xff>
          s = "(null)";
     504:	c7 45 f4 d0 20 00 00 	movl   $0x20d0,-0xc(%ebp)
        while(*s != 0){
     50b:	eb 1c                	jmp    529 <printf+0xff>
          putc(fd, *s);
     50d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     510:	0f b6 00             	movzbl (%eax),%eax
     513:	0f be c0             	movsbl %al,%eax
     516:	83 ec 08             	sub    $0x8,%esp
     519:	50                   	push   %eax
     51a:	ff 75 08             	pushl  0x8(%ebp)
     51d:	e8 31 fe ff ff       	call   353 <putc>
     522:	83 c4 10             	add    $0x10,%esp
          s++;
     525:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     529:	8b 45 f4             	mov    -0xc(%ebp),%eax
     52c:	0f b6 00             	movzbl (%eax),%eax
     52f:	84 c0                	test   %al,%al
     531:	75 da                	jne    50d <printf+0xe3>
     533:	eb 65                	jmp    59a <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     535:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     539:	75 1d                	jne    558 <printf+0x12e>
        putc(fd, *ap);
     53b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     53e:	8b 00                	mov    (%eax),%eax
     540:	0f be c0             	movsbl %al,%eax
     543:	83 ec 08             	sub    $0x8,%esp
     546:	50                   	push   %eax
     547:	ff 75 08             	pushl  0x8(%ebp)
     54a:	e8 04 fe ff ff       	call   353 <putc>
     54f:	83 c4 10             	add    $0x10,%esp
        ap++;
     552:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     556:	eb 42                	jmp    59a <printf+0x170>
      } else if(c == '%'){
     558:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     55c:	75 17                	jne    575 <printf+0x14b>
        putc(fd, c);
     55e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     561:	0f be c0             	movsbl %al,%eax
     564:	83 ec 08             	sub    $0x8,%esp
     567:	50                   	push   %eax
     568:	ff 75 08             	pushl  0x8(%ebp)
     56b:	e8 e3 fd ff ff       	call   353 <putc>
     570:	83 c4 10             	add    $0x10,%esp
     573:	eb 25                	jmp    59a <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     575:	83 ec 08             	sub    $0x8,%esp
     578:	6a 25                	push   $0x25
     57a:	ff 75 08             	pushl  0x8(%ebp)
     57d:	e8 d1 fd ff ff       	call   353 <putc>
     582:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     585:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     588:	0f be c0             	movsbl %al,%eax
     58b:	83 ec 08             	sub    $0x8,%esp
     58e:	50                   	push   %eax
     58f:	ff 75 08             	pushl  0x8(%ebp)
     592:	e8 bc fd ff ff       	call   353 <putc>
     597:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     59a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5a1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5a5:	8b 55 0c             	mov    0xc(%ebp),%edx
     5a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5ab:	01 d0                	add    %edx,%eax
     5ad:	0f b6 00             	movzbl (%eax),%eax
     5b0:	84 c0                	test   %al,%al
     5b2:	0f 85 94 fe ff ff    	jne    44c <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     5b8:	90                   	nop
     5b9:	c9                   	leave  
     5ba:	c3                   	ret    

000005bb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     5bb:	55                   	push   %ebp
     5bc:	89 e5                	mov    %esp,%ebp
     5be:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     5c1:	8b 45 08             	mov    0x8(%ebp),%eax
     5c4:	83 e8 08             	sub    $0x8,%eax
     5c7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     5ca:	a1 ac 27 00 00       	mov    0x27ac,%eax
     5cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
     5d2:	eb 24                	jmp    5f8 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     5d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5d7:	8b 00                	mov    (%eax),%eax
     5d9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     5dc:	77 12                	ja     5f0 <free+0x35>
     5de:	8b 45 f8             	mov    -0x8(%ebp),%eax
     5e1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     5e4:	77 24                	ja     60a <free+0x4f>
     5e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5e9:	8b 00                	mov    (%eax),%eax
     5eb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     5ee:	77 1a                	ja     60a <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     5f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5f3:	8b 00                	mov    (%eax),%eax
     5f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
     5f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     5fb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     5fe:	76 d4                	jbe    5d4 <free+0x19>
     600:	8b 45 fc             	mov    -0x4(%ebp),%eax
     603:	8b 00                	mov    (%eax),%eax
     605:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     608:	76 ca                	jbe    5d4 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     60a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     60d:	8b 40 04             	mov    0x4(%eax),%eax
     610:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     617:	8b 45 f8             	mov    -0x8(%ebp),%eax
     61a:	01 c2                	add    %eax,%edx
     61c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     61f:	8b 00                	mov    (%eax),%eax
     621:	39 c2                	cmp    %eax,%edx
     623:	75 24                	jne    649 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     625:	8b 45 f8             	mov    -0x8(%ebp),%eax
     628:	8b 50 04             	mov    0x4(%eax),%edx
     62b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     62e:	8b 00                	mov    (%eax),%eax
     630:	8b 40 04             	mov    0x4(%eax),%eax
     633:	01 c2                	add    %eax,%edx
     635:	8b 45 f8             	mov    -0x8(%ebp),%eax
     638:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     63b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     63e:	8b 00                	mov    (%eax),%eax
     640:	8b 10                	mov    (%eax),%edx
     642:	8b 45 f8             	mov    -0x8(%ebp),%eax
     645:	89 10                	mov    %edx,(%eax)
     647:	eb 0a                	jmp    653 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     649:	8b 45 fc             	mov    -0x4(%ebp),%eax
     64c:	8b 10                	mov    (%eax),%edx
     64e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     651:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     653:	8b 45 fc             	mov    -0x4(%ebp),%eax
     656:	8b 40 04             	mov    0x4(%eax),%eax
     659:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     660:	8b 45 fc             	mov    -0x4(%ebp),%eax
     663:	01 d0                	add    %edx,%eax
     665:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     668:	75 20                	jne    68a <free+0xcf>
    p->s.size += bp->s.size;
     66a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66d:	8b 50 04             	mov    0x4(%eax),%edx
     670:	8b 45 f8             	mov    -0x8(%ebp),%eax
     673:	8b 40 04             	mov    0x4(%eax),%eax
     676:	01 c2                	add    %eax,%edx
     678:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     67e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     681:	8b 10                	mov    (%eax),%edx
     683:	8b 45 fc             	mov    -0x4(%ebp),%eax
     686:	89 10                	mov    %edx,(%eax)
     688:	eb 08                	jmp    692 <free+0xd7>
  } else
    p->s.ptr = bp;
     68a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68d:	8b 55 f8             	mov    -0x8(%ebp),%edx
     690:	89 10                	mov    %edx,(%eax)
  freep = p;
     692:	8b 45 fc             	mov    -0x4(%ebp),%eax
     695:	a3 ac 27 00 00       	mov    %eax,0x27ac
}
     69a:	90                   	nop
     69b:	c9                   	leave  
     69c:	c3                   	ret    

0000069d <morecore>:

static Header*
morecore(uint nu)
{
     69d:	55                   	push   %ebp
     69e:	89 e5                	mov    %esp,%ebp
     6a0:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6a3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6aa:	77 07                	ja     6b3 <morecore+0x16>
    nu = 4096;
     6ac:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     6b3:	8b 45 08             	mov    0x8(%ebp),%eax
     6b6:	c1 e0 03             	shl    $0x3,%eax
     6b9:	83 ec 0c             	sub    $0xc,%esp
     6bc:	50                   	push   %eax
     6bd:	e8 49 fc ff ff       	call   30b <sbrk>
     6c2:	83 c4 10             	add    $0x10,%esp
     6c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     6c8:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     6cc:	75 07                	jne    6d5 <morecore+0x38>
    return 0;
     6ce:	b8 00 00 00 00       	mov    $0x0,%eax
     6d3:	eb 26                	jmp    6fb <morecore+0x5e>
  hp = (Header*)p;
     6d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     6db:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6de:	8b 55 08             	mov    0x8(%ebp),%edx
     6e1:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     6e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6e7:	83 c0 08             	add    $0x8,%eax
     6ea:	83 ec 0c             	sub    $0xc,%esp
     6ed:	50                   	push   %eax
     6ee:	e8 c8 fe ff ff       	call   5bb <free>
     6f3:	83 c4 10             	add    $0x10,%esp
  return freep;
     6f6:	a1 ac 27 00 00       	mov    0x27ac,%eax
}
     6fb:	c9                   	leave  
     6fc:	c3                   	ret    

000006fd <malloc>:

void*
malloc(uint nbytes)
{
     6fd:	55                   	push   %ebp
     6fe:	89 e5                	mov    %esp,%ebp
     700:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     703:	8b 45 08             	mov    0x8(%ebp),%eax
     706:	83 c0 07             	add    $0x7,%eax
     709:	c1 e8 03             	shr    $0x3,%eax
     70c:	83 c0 01             	add    $0x1,%eax
     70f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     712:	a1 ac 27 00 00       	mov    0x27ac,%eax
     717:	89 45 f0             	mov    %eax,-0x10(%ebp)
     71a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     71e:	75 23                	jne    743 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     720:	c7 45 f0 a4 27 00 00 	movl   $0x27a4,-0x10(%ebp)
     727:	8b 45 f0             	mov    -0x10(%ebp),%eax
     72a:	a3 ac 27 00 00       	mov    %eax,0x27ac
     72f:	a1 ac 27 00 00       	mov    0x27ac,%eax
     734:	a3 a4 27 00 00       	mov    %eax,0x27a4
    base.s.size = 0;
     739:	c7 05 a8 27 00 00 00 	movl   $0x0,0x27a8
     740:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     743:	8b 45 f0             	mov    -0x10(%ebp),%eax
     746:	8b 00                	mov    (%eax),%eax
     748:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     74b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     74e:	8b 40 04             	mov    0x4(%eax),%eax
     751:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     754:	72 4d                	jb     7a3 <malloc+0xa6>
      if(p->s.size == nunits)
     756:	8b 45 f4             	mov    -0xc(%ebp),%eax
     759:	8b 40 04             	mov    0x4(%eax),%eax
     75c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     75f:	75 0c                	jne    76d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     761:	8b 45 f4             	mov    -0xc(%ebp),%eax
     764:	8b 10                	mov    (%eax),%edx
     766:	8b 45 f0             	mov    -0x10(%ebp),%eax
     769:	89 10                	mov    %edx,(%eax)
     76b:	eb 26                	jmp    793 <malloc+0x96>
      else {
        p->s.size -= nunits;
     76d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     770:	8b 40 04             	mov    0x4(%eax),%eax
     773:	2b 45 ec             	sub    -0x14(%ebp),%eax
     776:	89 c2                	mov    %eax,%edx
     778:	8b 45 f4             	mov    -0xc(%ebp),%eax
     77b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     77e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     781:	8b 40 04             	mov    0x4(%eax),%eax
     784:	c1 e0 03             	shl    $0x3,%eax
     787:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     78a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     78d:	8b 55 ec             	mov    -0x14(%ebp),%edx
     790:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     793:	8b 45 f0             	mov    -0x10(%ebp),%eax
     796:	a3 ac 27 00 00       	mov    %eax,0x27ac
      return (void*)(p + 1);
     79b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     79e:	83 c0 08             	add    $0x8,%eax
     7a1:	eb 3b                	jmp    7de <malloc+0xe1>
    }
    if(p == freep)
     7a3:	a1 ac 27 00 00       	mov    0x27ac,%eax
     7a8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7ab:	75 1e                	jne    7cb <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7ad:	83 ec 0c             	sub    $0xc,%esp
     7b0:	ff 75 ec             	pushl  -0x14(%ebp)
     7b3:	e8 e5 fe ff ff       	call   69d <morecore>
     7b8:	83 c4 10             	add    $0x10,%esp
     7bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
     7be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7c2:	75 07                	jne    7cb <malloc+0xce>
        return 0;
     7c4:	b8 00 00 00 00       	mov    $0x0,%eax
     7c9:	eb 13                	jmp    7de <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d4:	8b 00                	mov    (%eax),%eax
     7d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     7d9:	e9 6d ff ff ff       	jmp    74b <malloc+0x4e>
}
     7de:	c9                   	leave  
     7df:	c3                   	ret    

000007e0 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     7e0:	55                   	push   %ebp
     7e1:	89 e5                	mov    %esp,%ebp
     7e3:	83 ec 1c             	sub    $0x1c,%esp
     7e6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     7e9:	8b 55 10             	mov    0x10(%ebp),%edx
     7ec:	8b 45 14             	mov    0x14(%ebp),%eax
     7ef:	88 4d ec             	mov    %cl,-0x14(%ebp)
     7f2:	88 55 e8             	mov    %dl,-0x18(%ebp)
     7f5:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     7f8:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     7fc:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     7ff:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     803:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     806:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     80a:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     80d:	8b 45 08             	mov    0x8(%ebp),%eax
     810:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     814:	66 89 10             	mov    %dx,(%eax)
     817:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     81b:	88 50 02             	mov    %dl,0x2(%eax)
}
     81e:	8b 45 08             	mov    0x8(%ebp),%eax
     821:	c9                   	leave  
     822:	c2 04 00             	ret    $0x4

00000825 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     825:	55                   	push   %ebp
     826:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     828:	8b 45 08             	mov    0x8(%ebp),%eax
     82b:	2b 45 10             	sub    0x10(%ebp),%eax
     82e:	89 c2                	mov    %eax,%edx
     830:	8b 45 08             	mov    0x8(%ebp),%eax
     833:	2b 45 10             	sub    0x10(%ebp),%eax
     836:	0f af d0             	imul   %eax,%edx
     839:	8b 45 0c             	mov    0xc(%ebp),%eax
     83c:	2b 45 14             	sub    0x14(%ebp),%eax
     83f:	89 c1                	mov    %eax,%ecx
     841:	8b 45 0c             	mov    0xc(%ebp),%eax
     844:	2b 45 14             	sub    0x14(%ebp),%eax
     847:	0f af c1             	imul   %ecx,%eax
     84a:	01 d0                	add    %edx,%eax
}
     84c:	5d                   	pop    %ebp
     84d:	c3                   	ret    

0000084e <abs_int>:

static inline int abs_int(int x)
{
     84e:	55                   	push   %ebp
     84f:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     851:	8b 45 08             	mov    0x8(%ebp),%eax
     854:	99                   	cltd   
     855:	89 d0                	mov    %edx,%eax
     857:	33 45 08             	xor    0x8(%ebp),%eax
     85a:	29 d0                	sub    %edx,%eax
}
     85c:	5d                   	pop    %ebp
     85d:	c3                   	ret    

0000085e <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     85e:	55                   	push   %ebp
     85f:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     861:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     865:	79 07                	jns    86e <APGetIndex+0x10>
        return X_SMALLER;
     867:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     86c:	eb 40                	jmp    8ae <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     86e:	8b 45 08             	mov    0x8(%ebp),%eax
     871:	8b 00                	mov    (%eax),%eax
     873:	3b 45 0c             	cmp    0xc(%ebp),%eax
     876:	7f 07                	jg     87f <APGetIndex+0x21>
        return X_BIGGER;
     878:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     87d:	eb 2f                	jmp    8ae <APGetIndex+0x50>
    if (y < 0)
     87f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     883:	79 07                	jns    88c <APGetIndex+0x2e>
        return Y_SMALLER;
     885:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     88a:	eb 22                	jmp    8ae <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     88c:	8b 45 08             	mov    0x8(%ebp),%eax
     88f:	8b 40 04             	mov    0x4(%eax),%eax
     892:	3b 45 10             	cmp    0x10(%ebp),%eax
     895:	7f 07                	jg     89e <APGetIndex+0x40>
        return Y_BIGGER;
     897:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     89c:	eb 10                	jmp    8ae <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     89e:	8b 45 08             	mov    0x8(%ebp),%eax
     8a1:	8b 00                	mov    (%eax),%eax
     8a3:	0f af 45 10          	imul   0x10(%ebp),%eax
     8a7:	89 c2                	mov    %eax,%edx
     8a9:	8b 45 0c             	mov    0xc(%ebp),%eax
     8ac:	01 d0                	add    %edx,%eax
}
     8ae:	5d                   	pop    %ebp
     8af:	c3                   	ret    

000008b0 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     8b0:	55                   	push   %ebp
     8b1:	89 e5                	mov    %esp,%ebp
     8b3:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     8b6:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     8bd:	8b 45 cc             	mov    -0x34(%ebp),%eax
     8c0:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     8c3:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     8ca:	83 ec 08             	sub    $0x8,%esp
     8cd:	6a 00                	push   $0x0
     8cf:	ff 75 0c             	pushl  0xc(%ebp)
     8d2:	e8 ec f9 ff ff       	call   2c3 <open>
     8d7:	83 c4 10             	add    $0x10,%esp
     8da:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     8dd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     8e1:	79 2e                	jns    911 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     8e3:	83 ec 04             	sub    $0x4,%esp
     8e6:	ff 75 0c             	pushl  0xc(%ebp)
     8e9:	68 d7 20 00 00       	push   $0x20d7
     8ee:	6a 01                	push   $0x1
     8f0:	e8 35 fb ff ff       	call   42a <printf>
     8f5:	83 c4 10             	add    $0x10,%esp
        return bmp;
     8f8:	8b 45 08             	mov    0x8(%ebp),%eax
     8fb:	8b 55 c8             	mov    -0x38(%ebp),%edx
     8fe:	89 10                	mov    %edx,(%eax)
     900:	8b 55 cc             	mov    -0x34(%ebp),%edx
     903:	89 50 04             	mov    %edx,0x4(%eax)
     906:	8b 55 d0             	mov    -0x30(%ebp),%edx
     909:	89 50 08             	mov    %edx,0x8(%eax)
     90c:	e9 d2 01 00 00       	jmp    ae3 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     911:	83 ec 04             	sub    $0x4,%esp
     914:	6a 0e                	push   $0xe
     916:	8d 45 ba             	lea    -0x46(%ebp),%eax
     919:	50                   	push   %eax
     91a:	ff 75 ec             	pushl  -0x14(%ebp)
     91d:	e8 79 f9 ff ff       	call   29b <read>
     922:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     925:	83 ec 04             	sub    $0x4,%esp
     928:	6a 28                	push   $0x28
     92a:	8d 45 92             	lea    -0x6e(%ebp),%eax
     92d:	50                   	push   %eax
     92e:	ff 75 ec             	pushl  -0x14(%ebp)
     931:	e8 65 f9 ff ff       	call   29b <read>
     936:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     939:	8b 45 96             	mov    -0x6a(%ebp),%eax
     93c:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     93f:	8b 45 9a             	mov    -0x66(%ebp),%eax
     942:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     945:	8b 55 c8             	mov    -0x38(%ebp),%edx
     948:	8b 45 cc             	mov    -0x34(%ebp),%eax
     94b:	0f af d0             	imul   %eax,%edx
     94e:	89 d0                	mov    %edx,%eax
     950:	01 c0                	add    %eax,%eax
     952:	01 d0                	add    %edx,%eax
     954:	83 ec 0c             	sub    $0xc,%esp
     957:	50                   	push   %eax
     958:	e8 a0 fd ff ff       	call   6fd <malloc>
     95d:	83 c4 10             	add    $0x10,%esp
     960:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     963:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     967:	0f b7 c0             	movzwl %ax,%eax
     96a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     96d:	8b 55 c8             	mov    -0x38(%ebp),%edx
     970:	8b 45 e8             	mov    -0x18(%ebp),%eax
     973:	0f af c2             	imul   %edx,%eax
     976:	83 c0 1f             	add    $0x1f,%eax
     979:	c1 e8 05             	shr    $0x5,%eax
     97c:	c1 e0 02             	shl    $0x2,%eax
     97f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     982:	8b 55 cc             	mov    -0x34(%ebp),%edx
     985:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     988:	0f af c2             	imul   %edx,%eax
     98b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     98e:	8b 45 e0             	mov    -0x20(%ebp),%eax
     991:	83 ec 0c             	sub    $0xc,%esp
     994:	50                   	push   %eax
     995:	e8 63 fd ff ff       	call   6fd <malloc>
     99a:	83 c4 10             	add    $0x10,%esp
     99d:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9a0:	83 ec 04             	sub    $0x4,%esp
     9a3:	ff 75 e0             	pushl  -0x20(%ebp)
     9a6:	ff 75 dc             	pushl  -0x24(%ebp)
     9a9:	ff 75 ec             	pushl  -0x14(%ebp)
     9ac:	e8 ea f8 ff ff       	call   29b <read>
     9b1:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     9b4:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9b8:	66 c1 e8 03          	shr    $0x3,%ax
     9bc:	0f b7 c0             	movzwl %ax,%eax
     9bf:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     9c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     9c9:	e9 e5 00 00 00       	jmp    ab3 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     9ce:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9d4:	29 c2                	sub    %eax,%edx
     9d6:	89 d0                	mov    %edx,%eax
     9d8:	8d 50 ff             	lea    -0x1(%eax),%edx
     9db:	8b 45 c8             	mov    -0x38(%ebp),%eax
     9de:	0f af c2             	imul   %edx,%eax
     9e1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     9e4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     9eb:	e9 b1 00 00 00       	jmp    aa1 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     9f0:	8b 55 d0             	mov    -0x30(%ebp),%edx
     9f3:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     9f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9f9:	01 c8                	add    %ecx,%eax
     9fb:	89 c1                	mov    %eax,%ecx
     9fd:	89 c8                	mov    %ecx,%eax
     9ff:	01 c0                	add    %eax,%eax
     a01:	01 c8                	add    %ecx,%eax
     a03:	01 c2                	add    %eax,%edx
     a05:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a08:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a0c:	89 c1                	mov    %eax,%ecx
     a0e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a11:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a15:	01 c1                	add    %eax,%ecx
     a17:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a1a:	01 c8                	add    %ecx,%eax
     a1c:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a1f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a22:	01 c8                	add    %ecx,%eax
     a24:	0f b6 00             	movzbl (%eax),%eax
     a27:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a2a:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a2d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a30:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a33:	01 c8                	add    %ecx,%eax
     a35:	89 c1                	mov    %eax,%ecx
     a37:	89 c8                	mov    %ecx,%eax
     a39:	01 c0                	add    %eax,%eax
     a3b:	01 c8                	add    %ecx,%eax
     a3d:	01 c2                	add    %eax,%edx
     a3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a42:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a46:	89 c1                	mov    %eax,%ecx
     a48:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a4b:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a4f:	01 c1                	add    %eax,%ecx
     a51:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a54:	01 c8                	add    %ecx,%eax
     a56:	8d 48 fe             	lea    -0x2(%eax),%ecx
     a59:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a5c:	01 c8                	add    %ecx,%eax
     a5e:	0f b6 00             	movzbl (%eax),%eax
     a61:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     a64:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a67:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a6d:	01 c8                	add    %ecx,%eax
     a6f:	89 c1                	mov    %eax,%ecx
     a71:	89 c8                	mov    %ecx,%eax
     a73:	01 c0                	add    %eax,%eax
     a75:	01 c8                	add    %ecx,%eax
     a77:	01 c2                	add    %eax,%edx
     a79:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a7c:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a80:	89 c1                	mov    %eax,%ecx
     a82:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a85:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a89:	01 c1                	add    %eax,%ecx
     a8b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a8e:	01 c8                	add    %ecx,%eax
     a90:	8d 48 fd             	lea    -0x3(%eax),%ecx
     a93:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a96:	01 c8                	add    %ecx,%eax
     a98:	0f b6 00             	movzbl (%eax),%eax
     a9b:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     a9d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     aa1:	8b 55 c8             	mov    -0x38(%ebp),%edx
     aa4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aa7:	39 c2                	cmp    %eax,%edx
     aa9:	0f 87 41 ff ff ff    	ja     9f0 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     aaf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ab3:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ab6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab9:	39 c2                	cmp    %eax,%edx
     abb:	0f 87 0d ff ff ff    	ja     9ce <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     ac1:	83 ec 0c             	sub    $0xc,%esp
     ac4:	ff 75 ec             	pushl  -0x14(%ebp)
     ac7:	e8 df f7 ff ff       	call   2ab <close>
     acc:	83 c4 10             	add    $0x10,%esp
    return bmp;
     acf:	8b 45 08             	mov    0x8(%ebp),%eax
     ad2:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ad5:	89 10                	mov    %edx,(%eax)
     ad7:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ada:	89 50 04             	mov    %edx,0x4(%eax)
     add:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ae0:	89 50 08             	mov    %edx,0x8(%eax)
}
     ae3:	8b 45 08             	mov    0x8(%ebp),%eax
     ae6:	c9                   	leave  
     ae7:	c2 04 00             	ret    $0x4

00000aea <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     aea:	55                   	push   %ebp
     aeb:	89 e5                	mov    %esp,%ebp
     aed:	53                   	push   %ebx
     aee:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     af1:	83 ec 0c             	sub    $0xc,%esp
     af4:	6a 1c                	push   $0x1c
     af6:	e8 02 fc ff ff       	call   6fd <malloc>
     afb:	83 c4 10             	add    $0x10,%esp
     afe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b01:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b04:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b0b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b0e:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b11:	6a 0c                	push   $0xc
     b13:	6a 0c                	push   $0xc
     b15:	6a 0c                	push   $0xc
     b17:	50                   	push   %eax
     b18:	e8 c3 fc ff ff       	call   7e0 <RGB>
     b1d:	83 c4 0c             	add    $0xc,%esp
     b20:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b24:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b28:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b2c:	88 43 15             	mov    %al,0x15(%ebx)
     b2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b32:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b35:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b39:	66 89 48 10          	mov    %cx,0x10(%eax)
     b3d:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b41:	88 50 12             	mov    %dl,0x12(%eax)
     b44:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b47:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b4a:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     b4e:	66 89 48 08          	mov    %cx,0x8(%eax)
     b52:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     b56:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     b59:	8b 45 08             	mov    0x8(%ebp),%eax
     b5c:	89 c2                	mov    %eax,%edx
     b5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b61:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     b63:	8b 45 0c             	mov    0xc(%ebp),%eax
     b66:	89 c2                	mov    %eax,%edx
     b68:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b6b:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     b6e:	8b 55 10             	mov    0x10(%ebp),%edx
     b71:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b74:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     b77:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     b7a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b7d:	c9                   	leave  
     b7e:	c3                   	ret    

00000b7f <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     b7f:	55                   	push   %ebp
     b80:	89 e5                	mov    %esp,%ebp
     b82:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     b85:	8b 45 0c             	mov    0xc(%ebp),%eax
     b88:	8b 50 08             	mov    0x8(%eax),%edx
     b8b:	89 55 f8             	mov    %edx,-0x8(%ebp)
     b8e:	8b 40 0c             	mov    0xc(%eax),%eax
     b91:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     b94:	8b 45 0c             	mov    0xc(%ebp),%eax
     b97:	8b 55 10             	mov    0x10(%ebp),%edx
     b9a:	89 50 08             	mov    %edx,0x8(%eax)
     b9d:	8b 55 14             	mov    0x14(%ebp),%edx
     ba0:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     ba3:	8b 45 08             	mov    0x8(%ebp),%eax
     ba6:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ba9:	89 10                	mov    %edx,(%eax)
     bab:	8b 55 fc             	mov    -0x4(%ebp),%edx
     bae:	89 50 04             	mov    %edx,0x4(%eax)
}
     bb1:	8b 45 08             	mov    0x8(%ebp),%eax
     bb4:	c9                   	leave  
     bb5:	c2 04 00             	ret    $0x4

00000bb8 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     bb8:	55                   	push   %ebp
     bb9:	89 e5                	mov    %esp,%ebp
     bbb:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     bbe:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc1:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     bc5:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     bc9:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     bcd:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     bd0:	8b 45 0c             	mov    0xc(%ebp),%eax
     bd3:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     bd7:	66 89 50 10          	mov    %dx,0x10(%eax)
     bdb:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     bdf:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     be2:	8b 45 08             	mov    0x8(%ebp),%eax
     be5:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     be9:	66 89 10             	mov    %dx,(%eax)
     bec:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     bf0:	88 50 02             	mov    %dl,0x2(%eax)
}
     bf3:	8b 45 08             	mov    0x8(%ebp),%eax
     bf6:	c9                   	leave  
     bf7:	c2 04 00             	ret    $0x4

00000bfa <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     bfa:	55                   	push   %ebp
     bfb:	89 e5                	mov    %esp,%ebp
     bfd:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c00:	8b 45 08             	mov    0x8(%ebp),%eax
     c03:	8b 40 0c             	mov    0xc(%eax),%eax
     c06:	89 c2                	mov    %eax,%edx
     c08:	c1 ea 1f             	shr    $0x1f,%edx
     c0b:	01 d0                	add    %edx,%eax
     c0d:	d1 f8                	sar    %eax
     c0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c15:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c19:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c1c:	8b 45 10             	mov    0x10(%ebp),%eax
     c1f:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c22:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c25:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c29:	0f 89 98 00 00 00    	jns    cc7 <APDrawPoint+0xcd>
        i = 0;
     c2f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c36:	e9 8c 00 00 00       	jmp    cc7 <APDrawPoint+0xcd>
    {
        j = x - off;
     c3b:	8b 45 0c             	mov    0xc(%ebp),%eax
     c3e:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c41:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     c44:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     c48:	79 69                	jns    cb3 <APDrawPoint+0xb9>
            j = 0;
     c4a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     c51:	eb 60                	jmp    cb3 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     c53:	ff 75 fc             	pushl  -0x4(%ebp)
     c56:	ff 75 f8             	pushl  -0x8(%ebp)
     c59:	ff 75 08             	pushl  0x8(%ebp)
     c5c:	e8 fd fb ff ff       	call   85e <APGetIndex>
     c61:	83 c4 0c             	add    $0xc,%esp
     c64:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     c67:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     c6b:	74 55                	je     cc2 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     c6d:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     c71:	74 67                	je     cda <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     c73:	ff 75 10             	pushl  0x10(%ebp)
     c76:	ff 75 0c             	pushl  0xc(%ebp)
     c79:	ff 75 fc             	pushl  -0x4(%ebp)
     c7c:	ff 75 f8             	pushl  -0x8(%ebp)
     c7f:	e8 a1 fb ff ff       	call   825 <distance_2>
     c84:	83 c4 10             	add    $0x10,%esp
     c87:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     c8a:	7f 23                	jg     caf <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     c8c:	8b 45 08             	mov    0x8(%ebp),%eax
     c8f:	8b 48 18             	mov    0x18(%eax),%ecx
     c92:	8b 55 ec             	mov    -0x14(%ebp),%edx
     c95:	89 d0                	mov    %edx,%eax
     c97:	01 c0                	add    %eax,%eax
     c99:	01 d0                	add    %edx,%eax
     c9b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     c9e:	8b 45 08             	mov    0x8(%ebp),%eax
     ca1:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     ca5:	66 89 0a             	mov    %cx,(%edx)
     ca8:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     cac:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     caf:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     cb3:	8b 55 0c             	mov    0xc(%ebp),%edx
     cb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cb9:	01 d0                	add    %edx,%eax
     cbb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     cbe:	7d 93                	jge    c53 <APDrawPoint+0x59>
     cc0:	eb 01                	jmp    cc3 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     cc2:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     cc3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     cc7:	8b 55 10             	mov    0x10(%ebp),%edx
     cca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ccd:	01 d0                	add    %edx,%eax
     ccf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     cd2:	0f 8d 63 ff ff ff    	jge    c3b <APDrawPoint+0x41>
     cd8:	eb 01                	jmp    cdb <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     cda:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     cdb:	c9                   	leave  
     cdc:	c3                   	ret    

00000cdd <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     cdd:	55                   	push   %ebp
     cde:	89 e5                	mov    %esp,%ebp
     ce0:	53                   	push   %ebx
     ce1:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     ce4:	8b 45 0c             	mov    0xc(%ebp),%eax
     ce7:	3b 45 14             	cmp    0x14(%ebp),%eax
     cea:	0f 85 80 00 00 00    	jne    d70 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     cf0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     cf4:	0f 88 9d 02 00 00    	js     f97 <APDrawLine+0x2ba>
     cfa:	8b 45 08             	mov    0x8(%ebp),%eax
     cfd:	8b 00                	mov    (%eax),%eax
     cff:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d02:	0f 8e 8f 02 00 00    	jle    f97 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d08:	8b 45 10             	mov    0x10(%ebp),%eax
     d0b:	3b 45 18             	cmp    0x18(%ebp),%eax
     d0e:	7e 12                	jle    d22 <APDrawLine+0x45>
        {
            int tmp = y2;
     d10:	8b 45 18             	mov    0x18(%ebp),%eax
     d13:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d16:	8b 45 10             	mov    0x10(%ebp),%eax
     d19:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d1c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d1f:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d22:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d26:	79 07                	jns    d2f <APDrawLine+0x52>
     d28:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d2f:	8b 45 08             	mov    0x8(%ebp),%eax
     d32:	8b 40 04             	mov    0x4(%eax),%eax
     d35:	3b 45 18             	cmp    0x18(%ebp),%eax
     d38:	7d 0c                	jge    d46 <APDrawLine+0x69>
     d3a:	8b 45 08             	mov    0x8(%ebp),%eax
     d3d:	8b 40 04             	mov    0x4(%eax),%eax
     d40:	83 e8 01             	sub    $0x1,%eax
     d43:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     d46:	8b 45 10             	mov    0x10(%ebp),%eax
     d49:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d4c:	eb 15                	jmp    d63 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     d4e:	ff 75 f4             	pushl  -0xc(%ebp)
     d51:	ff 75 0c             	pushl  0xc(%ebp)
     d54:	ff 75 08             	pushl  0x8(%ebp)
     d57:	e8 9e fe ff ff       	call   bfa <APDrawPoint>
     d5c:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     d5f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d63:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d66:	3b 45 18             	cmp    0x18(%ebp),%eax
     d69:	7e e3                	jle    d4e <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     d6b:	e9 2b 02 00 00       	jmp    f9b <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     d70:	8b 45 10             	mov    0x10(%ebp),%eax
     d73:	3b 45 18             	cmp    0x18(%ebp),%eax
     d76:	75 7f                	jne    df7 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     d78:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d7c:	0f 88 18 02 00 00    	js     f9a <APDrawLine+0x2bd>
     d82:	8b 45 08             	mov    0x8(%ebp),%eax
     d85:	8b 40 04             	mov    0x4(%eax),%eax
     d88:	3b 45 10             	cmp    0x10(%ebp),%eax
     d8b:	0f 8e 09 02 00 00    	jle    f9a <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     d91:	8b 45 0c             	mov    0xc(%ebp),%eax
     d94:	3b 45 14             	cmp    0x14(%ebp),%eax
     d97:	7e 12                	jle    dab <APDrawLine+0xce>
        {
            int tmp = x2;
     d99:	8b 45 14             	mov    0x14(%ebp),%eax
     d9c:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     d9f:	8b 45 0c             	mov    0xc(%ebp),%eax
     da2:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     da5:	8b 45 d8             	mov    -0x28(%ebp),%eax
     da8:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     dab:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     daf:	79 07                	jns    db8 <APDrawLine+0xdb>
     db1:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     db8:	8b 45 08             	mov    0x8(%ebp),%eax
     dbb:	8b 00                	mov    (%eax),%eax
     dbd:	3b 45 14             	cmp    0x14(%ebp),%eax
     dc0:	7d 0b                	jge    dcd <APDrawLine+0xf0>
     dc2:	8b 45 08             	mov    0x8(%ebp),%eax
     dc5:	8b 00                	mov    (%eax),%eax
     dc7:	83 e8 01             	sub    $0x1,%eax
     dca:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     dcd:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd0:	89 45 f0             	mov    %eax,-0x10(%ebp)
     dd3:	eb 15                	jmp    dea <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     dd5:	ff 75 10             	pushl  0x10(%ebp)
     dd8:	ff 75 f0             	pushl  -0x10(%ebp)
     ddb:	ff 75 08             	pushl  0x8(%ebp)
     dde:	e8 17 fe ff ff       	call   bfa <APDrawPoint>
     de3:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     de6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     dea:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ded:	3b 45 14             	cmp    0x14(%ebp),%eax
     df0:	7e e3                	jle    dd5 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     df2:	e9 a4 01 00 00       	jmp    f9b <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     df7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     dfe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e05:	8b 45 0c             	mov    0xc(%ebp),%eax
     e08:	2b 45 14             	sub    0x14(%ebp),%eax
     e0b:	50                   	push   %eax
     e0c:	e8 3d fa ff ff       	call   84e <abs_int>
     e11:	83 c4 04             	add    $0x4,%esp
     e14:	89 c3                	mov    %eax,%ebx
     e16:	8b 45 10             	mov    0x10(%ebp),%eax
     e19:	2b 45 18             	sub    0x18(%ebp),%eax
     e1c:	50                   	push   %eax
     e1d:	e8 2c fa ff ff       	call   84e <abs_int>
     e22:	83 c4 04             	add    $0x4,%esp
     e25:	39 c3                	cmp    %eax,%ebx
     e27:	0f 8e b5 00 00 00    	jle    ee2 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e2d:	8b 45 10             	mov    0x10(%ebp),%eax
     e30:	2b 45 18             	sub    0x18(%ebp),%eax
     e33:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e36:	db 45 b0             	fildl  -0x50(%ebp)
     e39:	8b 45 0c             	mov    0xc(%ebp),%eax
     e3c:	2b 45 14             	sub    0x14(%ebp),%eax
     e3f:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e42:	db 45 b0             	fildl  -0x50(%ebp)
     e45:	de f9                	fdivrp %st,%st(1)
     e47:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     e4a:	8b 45 14             	mov    0x14(%ebp),%eax
     e4d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e50:	7e 0e                	jle    e60 <APDrawLine+0x183>
        {
            s = x1;
     e52:	8b 45 0c             	mov    0xc(%ebp),%eax
     e55:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     e58:	8b 45 14             	mov    0x14(%ebp),%eax
     e5b:	89 45 e8             	mov    %eax,-0x18(%ebp)
     e5e:	eb 0c                	jmp    e6c <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     e60:	8b 45 14             	mov    0x14(%ebp),%eax
     e63:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     e66:	8b 45 0c             	mov    0xc(%ebp),%eax
     e69:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     e6c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     e70:	79 07                	jns    e79 <APDrawLine+0x19c>
     e72:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     e79:	8b 45 08             	mov    0x8(%ebp),%eax
     e7c:	8b 00                	mov    (%eax),%eax
     e7e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     e81:	7f 0b                	jg     e8e <APDrawLine+0x1b1>
     e83:	8b 45 08             	mov    0x8(%ebp),%eax
     e86:	8b 00                	mov    (%eax),%eax
     e88:	83 e8 01             	sub    $0x1,%eax
     e8b:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     e8e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e91:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     e94:	eb 3f                	jmp    ed5 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     e96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e99:	2b 45 0c             	sub    0xc(%ebp),%eax
     e9c:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e9f:	db 45 b0             	fildl  -0x50(%ebp)
     ea2:	dc 4d d0             	fmull  -0x30(%ebp)
     ea5:	db 45 10             	fildl  0x10(%ebp)
     ea8:	de c1                	faddp  %st,%st(1)
     eaa:	d9 7d b6             	fnstcw -0x4a(%ebp)
     ead:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     eb1:	b4 0c                	mov    $0xc,%ah
     eb3:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     eb7:	d9 6d b4             	fldcw  -0x4c(%ebp)
     eba:	db 5d cc             	fistpl -0x34(%ebp)
     ebd:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     ec0:	ff 75 cc             	pushl  -0x34(%ebp)
     ec3:	ff 75 e4             	pushl  -0x1c(%ebp)
     ec6:	ff 75 08             	pushl  0x8(%ebp)
     ec9:	e8 2c fd ff ff       	call   bfa <APDrawPoint>
     ece:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     ed1:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     ed5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ed8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     edb:	7e b9                	jle    e96 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     edd:	e9 b9 00 00 00       	jmp    f9b <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     ee2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ee5:	2b 45 14             	sub    0x14(%ebp),%eax
     ee8:	89 45 b0             	mov    %eax,-0x50(%ebp)
     eeb:	db 45 b0             	fildl  -0x50(%ebp)
     eee:	8b 45 10             	mov    0x10(%ebp),%eax
     ef1:	2b 45 18             	sub    0x18(%ebp),%eax
     ef4:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ef7:	db 45 b0             	fildl  -0x50(%ebp)
     efa:	de f9                	fdivrp %st,%st(1)
     efc:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     eff:	8b 45 10             	mov    0x10(%ebp),%eax
     f02:	3b 45 18             	cmp    0x18(%ebp),%eax
     f05:	7e 0e                	jle    f15 <APDrawLine+0x238>
    {
        s = y2;
     f07:	8b 45 18             	mov    0x18(%ebp),%eax
     f0a:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f0d:	8b 45 10             	mov    0x10(%ebp),%eax
     f10:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f13:	eb 0c                	jmp    f21 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f15:	8b 45 10             	mov    0x10(%ebp),%eax
     f18:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f1b:	8b 45 18             	mov    0x18(%ebp),%eax
     f1e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f21:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f25:	79 07                	jns    f2e <APDrawLine+0x251>
     f27:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f2e:	8b 45 08             	mov    0x8(%ebp),%eax
     f31:	8b 40 04             	mov    0x4(%eax),%eax
     f34:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f37:	7f 0c                	jg     f45 <APDrawLine+0x268>
     f39:	8b 45 08             	mov    0x8(%ebp),%eax
     f3c:	8b 40 04             	mov    0x4(%eax),%eax
     f3f:	83 e8 01             	sub    $0x1,%eax
     f42:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     f45:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f48:	89 45 e0             	mov    %eax,-0x20(%ebp)
     f4b:	eb 3f                	jmp    f8c <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     f4d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f50:	2b 45 10             	sub    0x10(%ebp),%eax
     f53:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f56:	db 45 b0             	fildl  -0x50(%ebp)
     f59:	dc 4d c0             	fmull  -0x40(%ebp)
     f5c:	db 45 0c             	fildl  0xc(%ebp)
     f5f:	de c1                	faddp  %st,%st(1)
     f61:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f64:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f68:	b4 0c                	mov    $0xc,%ah
     f6a:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f6e:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f71:	db 5d bc             	fistpl -0x44(%ebp)
     f74:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     f77:	ff 75 e0             	pushl  -0x20(%ebp)
     f7a:	ff 75 bc             	pushl  -0x44(%ebp)
     f7d:	ff 75 08             	pushl  0x8(%ebp)
     f80:	e8 75 fc ff ff       	call   bfa <APDrawPoint>
     f85:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     f88:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     f8c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f8f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f92:	7e b9                	jle    f4d <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     f94:	90                   	nop
     f95:	eb 04                	jmp    f9b <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     f97:	90                   	nop
     f98:	eb 01                	jmp    f9b <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     f9a:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     f9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     f9e:	c9                   	leave  
     f9f:	c3                   	ret    

00000fa0 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	53                   	push   %ebx
     fa4:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
     fa7:	8b 55 10             	mov    0x10(%ebp),%edx
     faa:	8b 45 18             	mov    0x18(%ebp),%eax
     fad:	01 d0                	add    %edx,%eax
     faf:	83 e8 01             	sub    $0x1,%eax
     fb2:	83 ec 04             	sub    $0x4,%esp
     fb5:	50                   	push   %eax
     fb6:	ff 75 0c             	pushl  0xc(%ebp)
     fb9:	ff 75 10             	pushl  0x10(%ebp)
     fbc:	ff 75 0c             	pushl  0xc(%ebp)
     fbf:	ff 75 08             	pushl  0x8(%ebp)
     fc2:	e8 16 fd ff ff       	call   cdd <APDrawLine>
     fc7:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
     fca:	8b 55 0c             	mov    0xc(%ebp),%edx
     fcd:	8b 45 14             	mov    0x14(%ebp),%eax
     fd0:	01 d0                	add    %edx,%eax
     fd2:	83 e8 01             	sub    $0x1,%eax
     fd5:	83 ec 04             	sub    $0x4,%esp
     fd8:	ff 75 10             	pushl  0x10(%ebp)
     fdb:	50                   	push   %eax
     fdc:	ff 75 10             	pushl  0x10(%ebp)
     fdf:	ff 75 0c             	pushl  0xc(%ebp)
     fe2:	ff 75 08             	pushl  0x8(%ebp)
     fe5:	e8 f3 fc ff ff       	call   cdd <APDrawLine>
     fea:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
     fed:	8b 55 10             	mov    0x10(%ebp),%edx
     ff0:	8b 45 18             	mov    0x18(%ebp),%eax
     ff3:	01 d0                	add    %edx,%eax
     ff5:	8d 48 ff             	lea    -0x1(%eax),%ecx
     ff8:	8b 55 0c             	mov    0xc(%ebp),%edx
     ffb:	8b 45 14             	mov    0x14(%ebp),%eax
     ffe:	01 d0                	add    %edx,%eax
    1000:	8d 50 ff             	lea    -0x1(%eax),%edx
    1003:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1006:	8b 45 14             	mov    0x14(%ebp),%eax
    1009:	01 d8                	add    %ebx,%eax
    100b:	83 e8 01             	sub    $0x1,%eax
    100e:	83 ec 04             	sub    $0x4,%esp
    1011:	51                   	push   %ecx
    1012:	52                   	push   %edx
    1013:	ff 75 10             	pushl  0x10(%ebp)
    1016:	50                   	push   %eax
    1017:	ff 75 08             	pushl  0x8(%ebp)
    101a:	e8 be fc ff ff       	call   cdd <APDrawLine>
    101f:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1022:	8b 55 10             	mov    0x10(%ebp),%edx
    1025:	8b 45 18             	mov    0x18(%ebp),%eax
    1028:	01 d0                	add    %edx,%eax
    102a:	8d 48 ff             	lea    -0x1(%eax),%ecx
    102d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1030:	8b 45 14             	mov    0x14(%ebp),%eax
    1033:	01 d0                	add    %edx,%eax
    1035:	8d 50 ff             	lea    -0x1(%eax),%edx
    1038:	8b 5d 10             	mov    0x10(%ebp),%ebx
    103b:	8b 45 18             	mov    0x18(%ebp),%eax
    103e:	01 d8                	add    %ebx,%eax
    1040:	83 e8 01             	sub    $0x1,%eax
    1043:	83 ec 04             	sub    $0x4,%esp
    1046:	51                   	push   %ecx
    1047:	52                   	push   %edx
    1048:	50                   	push   %eax
    1049:	ff 75 0c             	pushl  0xc(%ebp)
    104c:	ff 75 08             	pushl  0x8(%ebp)
    104f:	e8 89 fc ff ff       	call   cdd <APDrawLine>
    1054:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1057:	8b 55 0c             	mov    0xc(%ebp),%edx
    105a:	8b 45 14             	mov    0x14(%ebp),%eax
    105d:	01 d0                	add    %edx,%eax
    105f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1062:	8b 45 08             	mov    0x8(%ebp),%eax
    1065:	8b 40 0c             	mov    0xc(%eax),%eax
    1068:	89 c1                	mov    %eax,%ecx
    106a:	c1 e9 1f             	shr    $0x1f,%ecx
    106d:	01 c8                	add    %ecx,%eax
    106f:	d1 f8                	sar    %eax
    1071:	29 c2                	sub    %eax,%edx
    1073:	89 d0                	mov    %edx,%eax
    1075:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1078:	8b 55 10             	mov    0x10(%ebp),%edx
    107b:	8b 45 18             	mov    0x18(%ebp),%eax
    107e:	01 d0                	add    %edx,%eax
    1080:	8d 50 ff             	lea    -0x1(%eax),%edx
    1083:	8b 45 08             	mov    0x8(%ebp),%eax
    1086:	8b 40 0c             	mov    0xc(%eax),%eax
    1089:	89 c1                	mov    %eax,%ecx
    108b:	c1 e9 1f             	shr    $0x1f,%ecx
    108e:	01 c8                	add    %ecx,%eax
    1090:	d1 f8                	sar    %eax
    1092:	29 c2                	sub    %eax,%edx
    1094:	89 d0                	mov    %edx,%eax
    1096:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1099:	8b 45 08             	mov    0x8(%ebp),%eax
    109c:	8b 40 0c             	mov    0xc(%eax),%eax
    109f:	89 c2                	mov    %eax,%edx
    10a1:	c1 ea 1f             	shr    $0x1f,%edx
    10a4:	01 d0                	add    %edx,%eax
    10a6:	d1 f8                	sar    %eax
    10a8:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    10ab:	8b 45 08             	mov    0x8(%ebp),%eax
    10ae:	8b 40 0c             	mov    0xc(%eax),%eax
    10b1:	89 c2                	mov    %eax,%edx
    10b3:	c1 ea 1f             	shr    $0x1f,%edx
    10b6:	01 d0                	add    %edx,%eax
    10b8:	d1 f8                	sar    %eax
    10ba:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    10bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10c1:	0f 88 d8 00 00 00    	js     119f <APDrawRect+0x1ff>
    10c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    10cb:	0f 88 ce 00 00 00    	js     119f <APDrawRect+0x1ff>
    10d1:	8b 45 08             	mov    0x8(%ebp),%eax
    10d4:	8b 00                	mov    (%eax),%eax
    10d6:	3b 45 0c             	cmp    0xc(%ebp),%eax
    10d9:	0f 8e c0 00 00 00    	jle    119f <APDrawRect+0x1ff>
    10df:	8b 45 08             	mov    0x8(%ebp),%eax
    10e2:	8b 40 04             	mov    0x4(%eax),%eax
    10e5:	3b 45 10             	cmp    0x10(%ebp),%eax
    10e8:	0f 8e b1 00 00 00    	jle    119f <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    10ee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10f2:	79 07                	jns    10fb <APDrawRect+0x15b>
    10f4:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    10fb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    10ff:	79 07                	jns    1108 <APDrawRect+0x168>
    1101:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1108:	8b 45 08             	mov    0x8(%ebp),%eax
    110b:	8b 00                	mov    (%eax),%eax
    110d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1110:	7f 0b                	jg     111d <APDrawRect+0x17d>
    1112:	8b 45 08             	mov    0x8(%ebp),%eax
    1115:	8b 00                	mov    (%eax),%eax
    1117:	83 e8 01             	sub    $0x1,%eax
    111a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    111d:	8b 45 08             	mov    0x8(%ebp),%eax
    1120:	8b 40 04             	mov    0x4(%eax),%eax
    1123:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1126:	7f 0c                	jg     1134 <APDrawRect+0x194>
    1128:	8b 45 08             	mov    0x8(%ebp),%eax
    112b:	8b 40 04             	mov    0x4(%eax),%eax
    112e:	83 e8 01             	sub    $0x1,%eax
    1131:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1134:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    113b:	8b 45 0c             	mov    0xc(%ebp),%eax
    113e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1141:	eb 52                	jmp    1195 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1143:	8b 45 10             	mov    0x10(%ebp),%eax
    1146:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1149:	eb 3e                	jmp    1189 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    114b:	83 ec 04             	sub    $0x4,%esp
    114e:	ff 75 e8             	pushl  -0x18(%ebp)
    1151:	ff 75 ec             	pushl  -0x14(%ebp)
    1154:	ff 75 08             	pushl  0x8(%ebp)
    1157:	e8 02 f7 ff ff       	call   85e <APGetIndex>
    115c:	83 c4 10             	add    $0x10,%esp
    115f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1162:	8b 45 08             	mov    0x8(%ebp),%eax
    1165:	8b 48 18             	mov    0x18(%eax),%ecx
    1168:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    116b:	89 d0                	mov    %edx,%eax
    116d:	01 c0                	add    %eax,%eax
    116f:	01 d0                	add    %edx,%eax
    1171:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1174:	8b 45 08             	mov    0x8(%ebp),%eax
    1177:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    117b:	66 89 0a             	mov    %cx,(%edx)
    117e:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1182:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1185:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1189:	8b 45 e8             	mov    -0x18(%ebp),%eax
    118c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    118f:	7e ba                	jle    114b <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1191:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1195:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1198:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    119b:	7e a6                	jle    1143 <APDrawRect+0x1a3>
    119d:	eb 01                	jmp    11a0 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    119f:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    11a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11a3:	c9                   	leave  
    11a4:	c3                   	ret    

000011a5 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    11a5:	55                   	push   %ebp
    11a6:	89 e5                	mov    %esp,%ebp
    11a8:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    11ab:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    11af:	0f 88 8e 01 00 00    	js     1343 <APDcCopy+0x19e>
    11b5:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    11b9:	0f 88 84 01 00 00    	js     1343 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    11bf:	8b 55 0c             	mov    0xc(%ebp),%edx
    11c2:	8b 45 20             	mov    0x20(%ebp),%eax
    11c5:	01 d0                	add    %edx,%eax
    11c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11ca:	8b 55 10             	mov    0x10(%ebp),%edx
    11cd:	8b 45 24             	mov    0x24(%ebp),%eax
    11d0:	01 d0                	add    %edx,%eax
    11d2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    11d5:	8b 55 18             	mov    0x18(%ebp),%edx
    11d8:	8b 45 20             	mov    0x20(%ebp),%eax
    11db:	01 d0                	add    %edx,%eax
    11dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11e0:	8b 55 1c             	mov    0x1c(%ebp),%edx
    11e3:	8b 45 24             	mov    0x24(%ebp),%eax
    11e6:	01 d0                	add    %edx,%eax
    11e8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    11eb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11ef:	0f 88 51 01 00 00    	js     1346 <APDcCopy+0x1a1>
    11f5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    11f9:	0f 88 47 01 00 00    	js     1346 <APDcCopy+0x1a1>
    11ff:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1203:	0f 88 3d 01 00 00    	js     1346 <APDcCopy+0x1a1>
    1209:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    120d:	0f 88 33 01 00 00    	js     1346 <APDcCopy+0x1a1>
    1213:	8b 45 14             	mov    0x14(%ebp),%eax
    1216:	8b 00                	mov    (%eax),%eax
    1218:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    121b:	0f 8c 25 01 00 00    	jl     1346 <APDcCopy+0x1a1>
    1221:	8b 45 14             	mov    0x14(%ebp),%eax
    1224:	8b 40 04             	mov    0x4(%eax),%eax
    1227:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    122a:	0f 8c 16 01 00 00    	jl     1346 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1230:	8b 45 08             	mov    0x8(%ebp),%eax
    1233:	8b 00                	mov    (%eax),%eax
    1235:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1238:	7f 0b                	jg     1245 <APDcCopy+0xa0>
    123a:	8b 45 08             	mov    0x8(%ebp),%eax
    123d:	8b 00                	mov    (%eax),%eax
    123f:	83 e8 01             	sub    $0x1,%eax
    1242:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1245:	8b 45 08             	mov    0x8(%ebp),%eax
    1248:	8b 40 04             	mov    0x4(%eax),%eax
    124b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    124e:	7f 0c                	jg     125c <APDcCopy+0xb7>
    1250:	8b 45 08             	mov    0x8(%ebp),%eax
    1253:	8b 40 04             	mov    0x4(%eax),%eax
    1256:	83 e8 01             	sub    $0x1,%eax
    1259:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    125c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1263:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    126a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1271:	e9 bc 00 00 00       	jmp    1332 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1276:	8b 45 08             	mov    0x8(%ebp),%eax
    1279:	8b 00                	mov    (%eax),%eax
    127b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    127e:	8b 55 10             	mov    0x10(%ebp),%edx
    1281:	01 ca                	add    %ecx,%edx
    1283:	0f af d0             	imul   %eax,%edx
    1286:	8b 45 0c             	mov    0xc(%ebp),%eax
    1289:	01 d0                	add    %edx,%eax
    128b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    128e:	8b 45 14             	mov    0x14(%ebp),%eax
    1291:	8b 00                	mov    (%eax),%eax
    1293:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1296:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1299:	01 ca                	add    %ecx,%edx
    129b:	0f af d0             	imul   %eax,%edx
    129e:	8b 45 18             	mov    0x18(%ebp),%eax
    12a1:	01 d0                	add    %edx,%eax
    12a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    12a6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12ad:	eb 74                	jmp    1323 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    12af:	8b 45 14             	mov    0x14(%ebp),%eax
    12b2:	8b 50 18             	mov    0x18(%eax),%edx
    12b5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12bb:	01 c8                	add    %ecx,%eax
    12bd:	89 c1                	mov    %eax,%ecx
    12bf:	89 c8                	mov    %ecx,%eax
    12c1:	01 c0                	add    %eax,%eax
    12c3:	01 c8                	add    %ecx,%eax
    12c5:	01 d0                	add    %edx,%eax
    12c7:	0f b7 10             	movzwl (%eax),%edx
    12ca:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    12ce:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    12d2:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    12d5:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    12d9:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    12dd:	38 c2                	cmp    %al,%dl
    12df:	75 18                	jne    12f9 <APDcCopy+0x154>
    12e1:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    12e5:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    12e9:	38 c2                	cmp    %al,%dl
    12eb:	75 0c                	jne    12f9 <APDcCopy+0x154>
    12ed:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    12f1:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    12f5:	38 c2                	cmp    %al,%dl
    12f7:	74 26                	je     131f <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    12f9:	8b 45 08             	mov    0x8(%ebp),%eax
    12fc:	8b 50 18             	mov    0x18(%eax),%edx
    12ff:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1302:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1305:	01 c8                	add    %ecx,%eax
    1307:	89 c1                	mov    %eax,%ecx
    1309:	89 c8                	mov    %ecx,%eax
    130b:	01 c0                	add    %eax,%eax
    130d:	01 c8                	add    %ecx,%eax
    130f:	01 d0                	add    %edx,%eax
    1311:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1315:	66 89 10             	mov    %dx,(%eax)
    1318:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    131c:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    131f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1323:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1326:	2b 45 0c             	sub    0xc(%ebp),%eax
    1329:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    132c:	7d 81                	jge    12af <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    132e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1332:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1335:	2b 45 10             	sub    0x10(%ebp),%eax
    1338:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    133b:	0f 8d 35 ff ff ff    	jge    1276 <APDcCopy+0xd1>
    1341:	eb 04                	jmp    1347 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1343:	90                   	nop
    1344:	eb 01                	jmp    1347 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1346:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1347:	c9                   	leave  
    1348:	c3                   	ret    

00001349 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1349:	55                   	push   %ebp
    134a:	89 e5                	mov    %esp,%ebp
    134c:	83 ec 1c             	sub    $0x1c,%esp
    134f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1352:	8b 55 10             	mov    0x10(%ebp),%edx
    1355:	8b 45 14             	mov    0x14(%ebp),%eax
    1358:	88 4d ec             	mov    %cl,-0x14(%ebp)
    135b:	88 55 e8             	mov    %dl,-0x18(%ebp)
    135e:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1361:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1365:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1368:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    136c:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    136f:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1373:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1376:	8b 45 08             	mov    0x8(%ebp),%eax
    1379:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    137d:	66 89 10             	mov    %dx,(%eax)
    1380:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1384:	88 50 02             	mov    %dl,0x2(%eax)
}
    1387:	8b 45 08             	mov    0x8(%ebp),%eax
    138a:	c9                   	leave  
    138b:	c2 04 00             	ret    $0x4

0000138e <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    138e:	55                   	push   %ebp
    138f:	89 e5                	mov    %esp,%ebp
    1391:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1394:	8b 45 08             	mov    0x8(%ebp),%eax
    1397:	8b 00                	mov    (%eax),%eax
    1399:	83 ec 08             	sub    $0x8,%esp
    139c:	8d 55 0c             	lea    0xc(%ebp),%edx
    139f:	52                   	push   %edx
    13a0:	50                   	push   %eax
    13a1:	e8 8d ef ff ff       	call   333 <sendMessage>
    13a6:	83 c4 10             	add    $0x10,%esp
}
    13a9:	90                   	nop
    13aa:	c9                   	leave  
    13ab:	c3                   	ret    

000013ac <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    13ac:	55                   	push   %ebp
    13ad:	89 e5                	mov    %esp,%ebp
    13af:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    13b2:	83 ec 0c             	sub    $0xc,%esp
    13b5:	68 90 00 00 00       	push   $0x90
    13ba:	e8 3e f3 ff ff       	call   6fd <malloc>
    13bf:	83 c4 10             	add    $0x10,%esp
    13c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    13c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13c9:	75 15                	jne    13e0 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    13cb:	83 ec 04             	sub    $0x4,%esp
    13ce:	ff 75 08             	pushl  0x8(%ebp)
    13d1:	68 e8 20 00 00       	push   $0x20e8
    13d6:	6a 01                	push   $0x1
    13d8:	e8 4d f0 ff ff       	call   42a <printf>
    13dd:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    13e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13e3:	83 c0 7c             	add    $0x7c,%eax
    13e6:	83 ec 08             	sub    $0x8,%esp
    13e9:	ff 75 08             	pushl  0x8(%ebp)
    13ec:	50                   	push   %eax
    13ed:	e8 60 ec ff ff       	call   52 <strcpy>
    13f2:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    13f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f8:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    13ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1402:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1409:	8b 45 f4             	mov    -0xc(%ebp),%eax
    140c:	8b 40 34             	mov    0x34(%eax),%eax
    140f:	89 c2                	mov    %eax,%edx
    1411:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1414:	8b 40 38             	mov    0x38(%eax),%eax
    1417:	0f af d0             	imul   %eax,%edx
    141a:	89 d0                	mov    %edx,%eax
    141c:	01 c0                	add    %eax,%eax
    141e:	01 d0                	add    %edx,%eax
    1420:	83 ec 0c             	sub    $0xc,%esp
    1423:	50                   	push   %eax
    1424:	e8 d4 f2 ff ff       	call   6fd <malloc>
    1429:	83 c4 10             	add    $0x10,%esp
    142c:	89 c2                	mov    %eax,%edx
    142e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1431:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1434:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1437:	8b 40 4c             	mov    0x4c(%eax),%eax
    143a:	85 c0                	test   %eax,%eax
    143c:	75 15                	jne    1453 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    143e:	83 ec 04             	sub    $0x4,%esp
    1441:	ff 75 08             	pushl  0x8(%ebp)
    1444:	68 08 21 00 00       	push   $0x2108
    1449:	6a 01                	push   $0x1
    144b:	e8 da ef ff ff       	call   42a <printf>
    1450:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1453:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1456:	8b 40 34             	mov    0x34(%eax),%eax
    1459:	89 c2                	mov    %eax,%edx
    145b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145e:	8b 40 38             	mov    0x38(%eax),%eax
    1461:	0f af d0             	imul   %eax,%edx
    1464:	89 d0                	mov    %edx,%eax
    1466:	01 c0                	add    %eax,%eax
    1468:	01 c2                	add    %eax,%edx
    146a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    146d:	8b 40 4c             	mov    0x4c(%eax),%eax
    1470:	83 ec 04             	sub    $0x4,%esp
    1473:	52                   	push   %edx
    1474:	68 ff ff ff 00       	push   $0xffffff
    1479:	50                   	push   %eax
    147a:	e8 69 ec ff ff       	call   e8 <memset>
    147f:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1482:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1485:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    148c:	e8 72 ee ff ff       	call   303 <getpid>
    1491:	89 c2                	mov    %eax,%edx
    1493:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1496:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1499:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149c:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a6:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    14ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b0:	8b 40 50             	mov    0x50(%eax),%eax
    14b3:	89 c2                	mov    %eax,%edx
    14b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b8:	8b 40 54             	mov    0x54(%eax),%eax
    14bb:	0f af d0             	imul   %eax,%edx
    14be:	89 d0                	mov    %edx,%eax
    14c0:	01 c0                	add    %eax,%eax
    14c2:	01 d0                	add    %edx,%eax
    14c4:	83 ec 0c             	sub    $0xc,%esp
    14c7:	50                   	push   %eax
    14c8:	e8 30 f2 ff ff       	call   6fd <malloc>
    14cd:	83 c4 10             	add    $0x10,%esp
    14d0:	89 c2                	mov    %eax,%edx
    14d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d5:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    14d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14db:	8b 40 68             	mov    0x68(%eax),%eax
    14de:	85 c0                	test   %eax,%eax
    14e0:	75 15                	jne    14f7 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    14e2:	83 ec 04             	sub    $0x4,%esp
    14e5:	ff 75 08             	pushl  0x8(%ebp)
    14e8:	68 2c 21 00 00       	push   $0x212c
    14ed:	6a 01                	push   $0x1
    14ef:	e8 36 ef ff ff       	call   42a <printf>
    14f4:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14fa:	8b 40 34             	mov    0x34(%eax),%eax
    14fd:	89 c2                	mov    %eax,%edx
    14ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1502:	8b 40 38             	mov    0x38(%eax),%eax
    1505:	0f af d0             	imul   %eax,%edx
    1508:	89 d0                	mov    %edx,%eax
    150a:	01 c0                	add    %eax,%eax
    150c:	01 c2                	add    %eax,%edx
    150e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1511:	8b 40 4c             	mov    0x4c(%eax),%eax
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
    1533:	74 35                	je     156a <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1535:	8b 45 10             	mov    0x10(%ebp),%eax
    1538:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    153e:	83 ec 0c             	sub    $0xc,%esp
    1541:	50                   	push   %eax
    1542:	e8 b6 f1 ff ff       	call   6fd <malloc>
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
    1565:	e9 8d 00 00 00       	jmp    15f7 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    156a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156d:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1574:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1577:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    157e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1581:	8b 40 18             	mov    0x18(%eax),%eax
    1584:	89 c2                	mov    %eax,%edx
    1586:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1589:	8b 40 1c             	mov    0x1c(%eax),%eax
    158c:	0f af d0             	imul   %eax,%edx
    158f:	89 d0                	mov    %edx,%eax
    1591:	01 c0                	add    %eax,%eax
    1593:	01 d0                	add    %edx,%eax
    1595:	83 ec 0c             	sub    $0xc,%esp
    1598:	50                   	push   %eax
    1599:	e8 5f f1 ff ff       	call   6fd <malloc>
    159e:	83 c4 10             	add    $0x10,%esp
    15a1:	89 c2                	mov    %eax,%edx
    15a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a6:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    15a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ac:	8b 40 30             	mov    0x30(%eax),%eax
    15af:	85 c0                	test   %eax,%eax
    15b1:	75 15                	jne    15c8 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    15b3:	83 ec 04             	sub    $0x4,%esp
    15b6:	ff 75 08             	pushl  0x8(%ebp)
    15b9:	68 54 21 00 00       	push   $0x2154
    15be:	6a 01                	push   $0x1
    15c0:	e8 65 ee ff ff       	call   42a <printf>
    15c5:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cb:	8b 40 18             	mov    0x18(%eax),%eax
    15ce:	89 c2                	mov    %eax,%edx
    15d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d3:	8b 40 1c             	mov    0x1c(%eax),%eax
    15d6:	0f af d0             	imul   %eax,%edx
    15d9:	89 d0                	mov    %edx,%eax
    15db:	01 c0                	add    %eax,%eax
    15dd:	01 c2                	add    %eax,%edx
    15df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e2:	8b 40 30             	mov    0x30(%eax),%eax
    15e5:	83 ec 04             	sub    $0x4,%esp
    15e8:	52                   	push   %edx
    15e9:	68 ff ff ff 00       	push   $0xffffff
    15ee:	50                   	push   %eax
    15ef:	e8 f4 ea ff ff       	call   e8 <memset>
    15f4:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    15f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    15fa:	c9                   	leave  
    15fb:	c3                   	ret    

000015fc <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    15fc:	55                   	push   %ebp
    15fd:	89 e5                	mov    %esp,%ebp
    15ff:	53                   	push   %ebx
    1600:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1603:	8b 45 0c             	mov    0xc(%ebp),%eax
    1606:	83 f8 03             	cmp    $0x3,%eax
    1609:	74 02                	je     160d <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    160b:	eb 33                	jmp    1640 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    160d:	8b 45 08             	mov    0x8(%ebp),%eax
    1610:	8b 48 08             	mov    0x8(%eax),%ecx
    1613:	8b 45 08             	mov    0x8(%ebp),%eax
    1616:	8b 50 38             	mov    0x38(%eax),%edx
    1619:	8b 45 08             	mov    0x8(%ebp),%eax
    161c:	8b 40 34             	mov    0x34(%eax),%eax
    161f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1622:	83 c3 34             	add    $0x34,%ebx
    1625:	83 ec 0c             	sub    $0xc,%esp
    1628:	51                   	push   %ecx
    1629:	52                   	push   %edx
    162a:	50                   	push   %eax
    162b:	6a 00                	push   $0x0
    162d:	6a 00                	push   $0x0
    162f:	53                   	push   %ebx
    1630:	6a 32                	push   $0x32
    1632:	6a 00                	push   $0x0
    1634:	ff 75 08             	pushl  0x8(%ebp)
    1637:	e8 e7 ec ff ff       	call   323 <paintWindow>
    163c:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    163f:	90                   	nop
        default: break;
            
            
    }
    return False;
    1640:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1645:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1648:	c9                   	leave  
    1649:	c3                   	ret    

0000164a <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    164a:	55                   	push   %ebp
    164b:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    164d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1650:	8b 50 08             	mov    0x8(%eax),%edx
    1653:	8b 45 08             	mov    0x8(%ebp),%eax
    1656:	8b 00                	mov    (%eax),%eax
    1658:	39 c2                	cmp    %eax,%edx
    165a:	74 07                	je     1663 <APPreJudge+0x19>
        return False;
    165c:	b8 00 00 00 00       	mov    $0x0,%eax
    1661:	eb 05                	jmp    1668 <APPreJudge+0x1e>
    return True;
    1663:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1668:	5d                   	pop    %ebp
    1669:	c3                   	ret    

0000166a <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    166a:	55                   	push   %ebp
    166b:	89 e5                	mov    %esp,%ebp
    166d:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1670:	8b 45 08             	mov    0x8(%ebp),%eax
    1673:	8b 55 0c             	mov    0xc(%ebp),%edx
    1676:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    1679:	83 ec 0c             	sub    $0xc,%esp
    167c:	ff 75 08             	pushl  0x8(%ebp)
    167f:	e8 bf ec ff ff       	call   343 <registWindow>
    1684:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1687:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    168e:	8b 45 08             	mov    0x8(%ebp),%eax
    1691:	8b 00                	mov    (%eax),%eax
    1693:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1696:	ff 75 f4             	pushl  -0xc(%ebp)
    1699:	ff 75 f0             	pushl  -0x10(%ebp)
    169c:	ff 75 ec             	pushl  -0x14(%ebp)
    169f:	ff 75 08             	pushl  0x8(%ebp)
    16a2:	e8 e7 fc ff ff       	call   138e <APSendMessage>
    16a7:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    16aa:	83 ec 0c             	sub    $0xc,%esp
    16ad:	ff 75 08             	pushl  0x8(%ebp)
    16b0:	e8 86 ec ff ff       	call   33b <getMessage>
    16b5:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    16b8:	8b 45 08             	mov    0x8(%ebp),%eax
    16bb:	83 c0 6c             	add    $0x6c,%eax
    16be:	83 ec 08             	sub    $0x8,%esp
    16c1:	50                   	push   %eax
    16c2:	ff 75 08             	pushl  0x8(%ebp)
    16c5:	e8 80 ff ff ff       	call   164a <APPreJudge>
    16ca:	83 c4 10             	add    $0x10,%esp
    16cd:	84 c0                	test   %al,%al
    16cf:	74 1b                	je     16ec <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    16d1:	8b 45 08             	mov    0x8(%ebp),%eax
    16d4:	ff 70 74             	pushl  0x74(%eax)
    16d7:	ff 70 70             	pushl  0x70(%eax)
    16da:	ff 70 6c             	pushl  0x6c(%eax)
    16dd:	ff 75 08             	pushl  0x8(%ebp)
    16e0:	8b 45 0c             	mov    0xc(%ebp),%eax
    16e3:	ff d0                	call   *%eax
    16e5:	83 c4 10             	add    $0x10,%esp
    16e8:	84 c0                	test   %al,%al
    16ea:	75 0c                	jne    16f8 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    16ec:	8b 45 08             	mov    0x8(%ebp),%eax
    16ef:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    16f6:	eb b2                	jmp    16aa <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    16f8:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    16f9:	90                   	nop
    16fa:	c9                   	leave  
    16fb:	c3                   	ret    

000016fc <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    16fc:	55                   	push   %ebp
    16fd:	89 e5                	mov    %esp,%ebp
    16ff:	57                   	push   %edi
    1700:	56                   	push   %esi
    1701:	53                   	push   %ebx
    1702:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1705:	a1 b0 27 00 00       	mov    0x27b0,%eax
    170a:	85 c0                	test   %eax,%eax
    170c:	0f 85 2c 02 00 00    	jne    193e <APGridPaint+0x242>
    {
        iconReady = 1;
    1712:	c7 05 b0 27 00 00 01 	movl   $0x1,0x27b0
    1719:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    171c:	8d 45 98             	lea    -0x68(%ebp),%eax
    171f:	83 ec 08             	sub    $0x8,%esp
    1722:	68 7b 21 00 00       	push   $0x217b
    1727:	50                   	push   %eax
    1728:	e8 83 f1 ff ff       	call   8b0 <APLoadBitmap>
    172d:	83 c4 0c             	add    $0xc,%esp
    1730:	8b 45 98             	mov    -0x68(%ebp),%eax
    1733:	a3 d4 27 00 00       	mov    %eax,0x27d4
    1738:	8b 45 9c             	mov    -0x64(%ebp),%eax
    173b:	a3 d8 27 00 00       	mov    %eax,0x27d8
    1740:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1743:	a3 dc 27 00 00       	mov    %eax,0x27dc
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1748:	83 ec 04             	sub    $0x4,%esp
    174b:	ff 35 dc 27 00 00    	pushl  0x27dc
    1751:	ff 35 d8 27 00 00    	pushl  0x27d8
    1757:	ff 35 d4 27 00 00    	pushl  0x27d4
    175d:	e8 88 f3 ff ff       	call   aea <APCreateCompatibleDCFromBitmap>
    1762:	83 c4 10             	add    $0x10,%esp
    1765:	a3 e0 27 00 00       	mov    %eax,0x27e0
        grid_river = APLoadBitmap ("grid_river.bmp");
    176a:	8d 45 98             	lea    -0x68(%ebp),%eax
    176d:	83 ec 08             	sub    $0x8,%esp
    1770:	68 89 21 00 00       	push   $0x2189
    1775:	50                   	push   %eax
    1776:	e8 35 f1 ff ff       	call   8b0 <APLoadBitmap>
    177b:	83 c4 0c             	add    $0xc,%esp
    177e:	8b 45 98             	mov    -0x68(%ebp),%eax
    1781:	a3 10 28 00 00       	mov    %eax,0x2810
    1786:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1789:	a3 14 28 00 00       	mov    %eax,0x2814
    178e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1791:	a3 18 28 00 00       	mov    %eax,0x2818
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1796:	83 ec 04             	sub    $0x4,%esp
    1799:	ff 35 18 28 00 00    	pushl  0x2818
    179f:	ff 35 14 28 00 00    	pushl  0x2814
    17a5:	ff 35 10 28 00 00    	pushl  0x2810
    17ab:	e8 3a f3 ff ff       	call   aea <APCreateCompatibleDCFromBitmap>
    17b0:	83 c4 10             	add    $0x10,%esp
    17b3:	a3 00 28 00 00       	mov    %eax,0x2800
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    17b8:	8d 45 98             	lea    -0x68(%ebp),%eax
    17bb:	83 ec 08             	sub    $0x8,%esp
    17be:	68 98 21 00 00       	push   $0x2198
    17c3:	50                   	push   %eax
    17c4:	e8 e7 f0 ff ff       	call   8b0 <APLoadBitmap>
    17c9:	83 c4 0c             	add    $0xc,%esp
    17cc:	8b 45 98             	mov    -0x68(%ebp),%eax
    17cf:	a3 04 28 00 00       	mov    %eax,0x2804
    17d4:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17d7:	a3 08 28 00 00       	mov    %eax,0x2808
    17dc:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17df:	a3 0c 28 00 00       	mov    %eax,0x280c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    17e4:	83 ec 04             	sub    $0x4,%esp
    17e7:	ff 35 0c 28 00 00    	pushl  0x280c
    17ed:	ff 35 08 28 00 00    	pushl  0x2808
    17f3:	ff 35 04 28 00 00    	pushl  0x2804
    17f9:	e8 ec f2 ff ff       	call   aea <APCreateCompatibleDCFromBitmap>
    17fe:	83 c4 10             	add    $0x10,%esp
    1801:	a3 b4 27 00 00       	mov    %eax,0x27b4
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1806:	8d 45 98             	lea    -0x68(%ebp),%eax
    1809:	83 ec 08             	sub    $0x8,%esp
    180c:	68 a7 21 00 00       	push   $0x21a7
    1811:	50                   	push   %eax
    1812:	e8 99 f0 ff ff       	call   8b0 <APLoadBitmap>
    1817:	83 c4 0c             	add    $0xc,%esp
    181a:	8b 45 98             	mov    -0x68(%ebp),%eax
    181d:	a3 e8 27 00 00       	mov    %eax,0x27e8
    1822:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1825:	a3 ec 27 00 00       	mov    %eax,0x27ec
    182a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    182d:	a3 f0 27 00 00       	mov    %eax,0x27f0
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1832:	83 ec 04             	sub    $0x4,%esp
    1835:	ff 35 f0 27 00 00    	pushl  0x27f0
    183b:	ff 35 ec 27 00 00    	pushl  0x27ec
    1841:	ff 35 e8 27 00 00    	pushl  0x27e8
    1847:	e8 9e f2 ff ff       	call   aea <APCreateCompatibleDCFromBitmap>
    184c:	83 c4 10             	add    $0x10,%esp
    184f:	a3 1c 28 00 00       	mov    %eax,0x281c
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1854:	8d 45 98             	lea    -0x68(%ebp),%eax
    1857:	83 ec 08             	sub    $0x8,%esp
    185a:	68 b5 21 00 00       	push   $0x21b5
    185f:	50                   	push   %eax
    1860:	e8 4b f0 ff ff       	call   8b0 <APLoadBitmap>
    1865:	83 c4 0c             	add    $0xc,%esp
    1868:	8b 45 98             	mov    -0x68(%ebp),%eax
    186b:	a3 c4 27 00 00       	mov    %eax,0x27c4
    1870:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1873:	a3 c8 27 00 00       	mov    %eax,0x27c8
    1878:	8b 45 a0             	mov    -0x60(%ebp),%eax
    187b:	a3 cc 27 00 00       	mov    %eax,0x27cc
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1880:	83 ec 04             	sub    $0x4,%esp
    1883:	ff 35 cc 27 00 00    	pushl  0x27cc
    1889:	ff 35 c8 27 00 00    	pushl  0x27c8
    188f:	ff 35 c4 27 00 00    	pushl  0x27c4
    1895:	e8 50 f2 ff ff       	call   aea <APCreateCompatibleDCFromBitmap>
    189a:	83 c4 10             	add    $0x10,%esp
    189d:	a3 e4 27 00 00       	mov    %eax,0x27e4
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    18a2:	8d 45 98             	lea    -0x68(%ebp),%eax
    18a5:	83 ec 08             	sub    $0x8,%esp
    18a8:	68 c5 21 00 00       	push   $0x21c5
    18ad:	50                   	push   %eax
    18ae:	e8 fd ef ff ff       	call   8b0 <APLoadBitmap>
    18b3:	83 c4 0c             	add    $0xc,%esp
    18b6:	8b 45 98             	mov    -0x68(%ebp),%eax
    18b9:	a3 b8 27 00 00       	mov    %eax,0x27b8
    18be:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18c1:	a3 bc 27 00 00       	mov    %eax,0x27bc
    18c6:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18c9:	a3 c0 27 00 00       	mov    %eax,0x27c0
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    18ce:	83 ec 04             	sub    $0x4,%esp
    18d1:	ff 35 c0 27 00 00    	pushl  0x27c0
    18d7:	ff 35 bc 27 00 00    	pushl  0x27bc
    18dd:	ff 35 b8 27 00 00    	pushl  0x27b8
    18e3:	e8 02 f2 ff ff       	call   aea <APCreateCompatibleDCFromBitmap>
    18e8:	83 c4 10             	add    $0x10,%esp
    18eb:	a3 d0 27 00 00       	mov    %eax,0x27d0
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    18f0:	8d 45 98             	lea    -0x68(%ebp),%eax
    18f3:	83 ec 08             	sub    $0x8,%esp
    18f6:	68 d7 21 00 00       	push   $0x21d7
    18fb:	50                   	push   %eax
    18fc:	e8 af ef ff ff       	call   8b0 <APLoadBitmap>
    1901:	83 c4 0c             	add    $0xc,%esp
    1904:	8b 45 98             	mov    -0x68(%ebp),%eax
    1907:	a3 f4 27 00 00       	mov    %eax,0x27f4
    190c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    190f:	a3 f8 27 00 00       	mov    %eax,0x27f8
    1914:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1917:	a3 fc 27 00 00       	mov    %eax,0x27fc
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    191c:	83 ec 04             	sub    $0x4,%esp
    191f:	ff 35 fc 27 00 00    	pushl  0x27fc
    1925:	ff 35 f8 27 00 00    	pushl  0x27f8
    192b:	ff 35 f4 27 00 00    	pushl  0x27f4
    1931:	e8 b4 f1 ff ff       	call   aea <APCreateCompatibleDCFromBitmap>
    1936:	83 c4 10             	add    $0x10,%esp
    1939:	a3 20 28 00 00       	mov    %eax,0x2820
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    193e:	8b 45 08             	mov    0x8(%ebp),%eax
    1941:	8b 40 08             	mov    0x8(%eax),%eax
    1944:	85 c0                	test   %eax,%eax
    1946:	75 17                	jne    195f <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1948:	83 ec 08             	sub    $0x8,%esp
    194b:	68 e8 21 00 00       	push   $0x21e8
    1950:	6a 01                	push   $0x1
    1952:	e8 d3 ea ff ff       	call   42a <printf>
    1957:	83 c4 10             	add    $0x10,%esp
        return;
    195a:	e9 f2 03 00 00       	jmp    1d51 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    195f:	8b 45 08             	mov    0x8(%ebp),%eax
    1962:	8b 40 10             	mov    0x10(%eax),%eax
    1965:	85 c0                	test   %eax,%eax
    1967:	7e 10                	jle    1979 <APGridPaint+0x27d>
    1969:	8b 45 08             	mov    0x8(%ebp),%eax
    196c:	8b 50 14             	mov    0x14(%eax),%edx
    196f:	8b 45 08             	mov    0x8(%ebp),%eax
    1972:	8b 40 10             	mov    0x10(%eax),%eax
    1975:	39 c2                	cmp    %eax,%edx
    1977:	7c 17                	jl     1990 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1979:	83 ec 08             	sub    $0x8,%esp
    197c:	68 0e 22 00 00       	push   $0x220e
    1981:	6a 01                	push   $0x1
    1983:	e8 a2 ea ff ff       	call   42a <printf>
    1988:	83 c4 10             	add    $0x10,%esp
        return;
    198b:	e9 c1 03 00 00       	jmp    1d51 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1990:	8b 45 08             	mov    0x8(%ebp),%eax
    1993:	8b 40 14             	mov    0x14(%eax),%eax
    1996:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    199c:	89 45 dc             	mov    %eax,-0x24(%ebp)
    199f:	8b 45 dc             	mov    -0x24(%ebp),%eax
    19a2:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    19a5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    19ac:	e9 96 03 00 00       	jmp    1d47 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    19b1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    19b8:	e9 7c 03 00 00       	jmp    1d39 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    19bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19c0:	c1 e0 04             	shl    $0x4,%eax
    19c3:	89 c2                	mov    %eax,%edx
    19c5:	8b 45 d8             	mov    -0x28(%ebp),%eax
    19c8:	01 c2                	add    %eax,%edx
    19ca:	8b 45 e0             	mov    -0x20(%ebp),%eax
    19cd:	01 d0                	add    %edx,%eax
    19cf:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    19d2:	8b 45 08             	mov    0x8(%ebp),%eax
    19d5:	8b 40 0c             	mov    0xc(%eax),%eax
    19d8:	8b 55 dc             	mov    -0x24(%ebp),%edx
    19db:	c1 e2 02             	shl    $0x2,%edx
    19de:	01 d0                	add    %edx,%eax
    19e0:	8b 00                	mov    (%eax),%eax
    19e2:	83 f8 07             	cmp    $0x7,%eax
    19e5:	0f 87 49 03 00 00    	ja     1d34 <APGridPaint+0x638>
    19eb:	8b 04 85 24 22 00 00 	mov    0x2224(,%eax,4),%eax
    19f2:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    19f4:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    19f7:	6a 0c                	push   $0xc
    19f9:	6a 0c                	push   $0xc
    19fb:	6a 0c                	push   $0xc
    19fd:	50                   	push   %eax
    19fe:	e8 46 f9 ff ff       	call   1349 <RGB>
    1a03:	83 c4 0c             	add    $0xc,%esp
    1a06:	8b 1d e0 27 00 00    	mov    0x27e0,%ebx
    1a0c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a0f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1a12:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a15:	6b c0 32             	imul   $0x32,%eax,%eax
    1a18:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1a1b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1e:	8d 78 34             	lea    0x34(%eax),%edi
    1a21:	83 ec 0c             	sub    $0xc,%esp
    1a24:	83 ec 04             	sub    $0x4,%esp
    1a27:	89 e0                	mov    %esp,%eax
    1a29:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1a2d:	66 89 30             	mov    %si,(%eax)
    1a30:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1a34:	88 50 02             	mov    %dl,0x2(%eax)
    1a37:	6a 32                	push   $0x32
    1a39:	6a 32                	push   $0x32
    1a3b:	6a 00                	push   $0x0
    1a3d:	6a 00                	push   $0x0
    1a3f:	53                   	push   %ebx
    1a40:	51                   	push   %ecx
    1a41:	ff 75 94             	pushl  -0x6c(%ebp)
    1a44:	57                   	push   %edi
    1a45:	e8 5b f7 ff ff       	call   11a5 <APDcCopy>
    1a4a:	83 c4 30             	add    $0x30,%esp
                    break;
    1a4d:	e9 e3 02 00 00       	jmp    1d35 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1a52:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a55:	6a 69                	push   $0x69
    1a57:	6a 69                	push   $0x69
    1a59:	6a 69                	push   $0x69
    1a5b:	50                   	push   %eax
    1a5c:	e8 e8 f8 ff ff       	call   1349 <RGB>
    1a61:	83 c4 0c             	add    $0xc,%esp
    1a64:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1a68:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1a6c:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1a70:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1a73:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1a7a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a7d:	6a 69                	push   $0x69
    1a7f:	6a 69                	push   $0x69
    1a81:	6a 69                	push   $0x69
    1a83:	50                   	push   %eax
    1a84:	e8 c0 f8 ff ff       	call   1349 <RGB>
    1a89:	83 c4 0c             	add    $0xc,%esp
    1a8c:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1a90:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1a94:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1a98:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1a9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9e:	8d 50 34             	lea    0x34(%eax),%edx
    1aa1:	8d 45 98             	lea    -0x68(%ebp),%eax
    1aa4:	ff 75 bc             	pushl  -0x44(%ebp)
    1aa7:	ff 75 b8             	pushl  -0x48(%ebp)
    1aaa:	52                   	push   %edx
    1aab:	50                   	push   %eax
    1aac:	e8 ce f0 ff ff       	call   b7f <APSetPen>
    1ab1:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1ab4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab7:	8d 58 34             	lea    0x34(%eax),%ebx
    1aba:	8d 55 98             	lea    -0x68(%ebp),%edx
    1abd:	83 ec 04             	sub    $0x4,%esp
    1ac0:	83 ec 04             	sub    $0x4,%esp
    1ac3:	89 e0                	mov    %esp,%eax
    1ac5:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1ac9:	66 89 08             	mov    %cx,(%eax)
    1acc:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1ad0:	88 48 02             	mov    %cl,0x2(%eax)
    1ad3:	53                   	push   %ebx
    1ad4:	52                   	push   %edx
    1ad5:	e8 de f0 ff ff       	call   bb8 <APSetBrush>
    1ada:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1add:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ae0:	6b d0 32             	imul   $0x32,%eax,%edx
    1ae3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ae6:	6b c0 32             	imul   $0x32,%eax,%eax
    1ae9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1aec:	83 c1 34             	add    $0x34,%ecx
    1aef:	83 ec 0c             	sub    $0xc,%esp
    1af2:	6a 32                	push   $0x32
    1af4:	6a 32                	push   $0x32
    1af6:	52                   	push   %edx
    1af7:	50                   	push   %eax
    1af8:	51                   	push   %ecx
    1af9:	e8 a2 f4 ff ff       	call   fa0 <APDrawRect>
    1afe:	83 c4 20             	add    $0x20,%esp
                    break;
    1b01:	e9 2f 02 00 00       	jmp    1d35 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b06:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1b09:	6a 0c                	push   $0xc
    1b0b:	6a 0c                	push   $0xc
    1b0d:	6a 0c                	push   $0xc
    1b0f:	50                   	push   %eax
    1b10:	e8 34 f8 ff ff       	call   1349 <RGB>
    1b15:	83 c4 0c             	add    $0xc,%esp
    1b18:	8b 1d 20 28 00 00    	mov    0x2820,%ebx
    1b1e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b21:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b24:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b27:	6b c0 32             	imul   $0x32,%eax,%eax
    1b2a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b2d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b30:	8d 78 34             	lea    0x34(%eax),%edi
    1b33:	83 ec 0c             	sub    $0xc,%esp
    1b36:	83 ec 04             	sub    $0x4,%esp
    1b39:	89 e0                	mov    %esp,%eax
    1b3b:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1b3f:	66 89 30             	mov    %si,(%eax)
    1b42:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1b46:	88 50 02             	mov    %dl,0x2(%eax)
    1b49:	6a 32                	push   $0x32
    1b4b:	6a 32                	push   $0x32
    1b4d:	6a 00                	push   $0x0
    1b4f:	6a 00                	push   $0x0
    1b51:	53                   	push   %ebx
    1b52:	51                   	push   %ecx
    1b53:	ff 75 94             	pushl  -0x6c(%ebp)
    1b56:	57                   	push   %edi
    1b57:	e8 49 f6 ff ff       	call   11a5 <APDcCopy>
    1b5c:	83 c4 30             	add    $0x30,%esp
                    break;
    1b5f:	e9 d1 01 00 00       	jmp    1d35 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b64:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1b67:	6a 0c                	push   $0xc
    1b69:	6a 0c                	push   $0xc
    1b6b:	6a 0c                	push   $0xc
    1b6d:	50                   	push   %eax
    1b6e:	e8 d6 f7 ff ff       	call   1349 <RGB>
    1b73:	83 c4 0c             	add    $0xc,%esp
    1b76:	8b 1d 00 28 00 00    	mov    0x2800,%ebx
    1b7c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b7f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b82:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b85:	6b c0 32             	imul   $0x32,%eax,%eax
    1b88:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b8e:	8d 78 34             	lea    0x34(%eax),%edi
    1b91:	83 ec 0c             	sub    $0xc,%esp
    1b94:	83 ec 04             	sub    $0x4,%esp
    1b97:	89 e0                	mov    %esp,%eax
    1b99:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1b9d:	66 89 30             	mov    %si,(%eax)
    1ba0:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1ba4:	88 50 02             	mov    %dl,0x2(%eax)
    1ba7:	6a 32                	push   $0x32
    1ba9:	6a 32                	push   $0x32
    1bab:	6a 00                	push   $0x0
    1bad:	6a 00                	push   $0x0
    1baf:	53                   	push   %ebx
    1bb0:	51                   	push   %ecx
    1bb1:	ff 75 94             	pushl  -0x6c(%ebp)
    1bb4:	57                   	push   %edi
    1bb5:	e8 eb f5 ff ff       	call   11a5 <APDcCopy>
    1bba:	83 c4 30             	add    $0x30,%esp
                    break;
    1bbd:	e9 73 01 00 00       	jmp    1d35 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bc2:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1bc5:	6a 0c                	push   $0xc
    1bc7:	6a 0c                	push   $0xc
    1bc9:	6a 0c                	push   $0xc
    1bcb:	50                   	push   %eax
    1bcc:	e8 78 f7 ff ff       	call   1349 <RGB>
    1bd1:	83 c4 0c             	add    $0xc,%esp
    1bd4:	8b 1d e4 27 00 00    	mov    0x27e4,%ebx
    1bda:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bdd:	6b c8 32             	imul   $0x32,%eax,%ecx
    1be0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1be3:	6b c0 32             	imul   $0x32,%eax,%eax
    1be6:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1be9:	8b 45 08             	mov    0x8(%ebp),%eax
    1bec:	8d 78 34             	lea    0x34(%eax),%edi
    1bef:	83 ec 0c             	sub    $0xc,%esp
    1bf2:	83 ec 04             	sub    $0x4,%esp
    1bf5:	89 e0                	mov    %esp,%eax
    1bf7:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1bfb:	66 89 30             	mov    %si,(%eax)
    1bfe:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1c02:	88 50 02             	mov    %dl,0x2(%eax)
    1c05:	6a 32                	push   $0x32
    1c07:	6a 32                	push   $0x32
    1c09:	6a 00                	push   $0x0
    1c0b:	6a 00                	push   $0x0
    1c0d:	53                   	push   %ebx
    1c0e:	51                   	push   %ecx
    1c0f:	ff 75 94             	pushl  -0x6c(%ebp)
    1c12:	57                   	push   %edi
    1c13:	e8 8d f5 ff ff       	call   11a5 <APDcCopy>
    1c18:	83 c4 30             	add    $0x30,%esp
                    break;
    1c1b:	e9 15 01 00 00       	jmp    1d35 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c20:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1c23:	6a 0c                	push   $0xc
    1c25:	6a 0c                	push   $0xc
    1c27:	6a 0c                	push   $0xc
    1c29:	50                   	push   %eax
    1c2a:	e8 1a f7 ff ff       	call   1349 <RGB>
    1c2f:	83 c4 0c             	add    $0xc,%esp
    1c32:	8b 1d 1c 28 00 00    	mov    0x281c,%ebx
    1c38:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c3b:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c3e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c41:	6b c0 32             	imul   $0x32,%eax,%eax
    1c44:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c47:	8b 45 08             	mov    0x8(%ebp),%eax
    1c4a:	8d 78 34             	lea    0x34(%eax),%edi
    1c4d:	83 ec 0c             	sub    $0xc,%esp
    1c50:	83 ec 04             	sub    $0x4,%esp
    1c53:	89 e0                	mov    %esp,%eax
    1c55:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1c59:	66 89 30             	mov    %si,(%eax)
    1c5c:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1c60:	88 50 02             	mov    %dl,0x2(%eax)
    1c63:	6a 32                	push   $0x32
    1c65:	6a 32                	push   $0x32
    1c67:	6a 00                	push   $0x0
    1c69:	6a 00                	push   $0x0
    1c6b:	53                   	push   %ebx
    1c6c:	51                   	push   %ecx
    1c6d:	ff 75 94             	pushl  -0x6c(%ebp)
    1c70:	57                   	push   %edi
    1c71:	e8 2f f5 ff ff       	call   11a5 <APDcCopy>
    1c76:	83 c4 30             	add    $0x30,%esp
                    break;
    1c79:	e9 b7 00 00 00       	jmp    1d35 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c7e:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1c81:	6a 0c                	push   $0xc
    1c83:	6a 0c                	push   $0xc
    1c85:	6a 0c                	push   $0xc
    1c87:	50                   	push   %eax
    1c88:	e8 bc f6 ff ff       	call   1349 <RGB>
    1c8d:	83 c4 0c             	add    $0xc,%esp
    1c90:	8b 1d b4 27 00 00    	mov    0x27b4,%ebx
    1c96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c99:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c9c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c9f:	6b c0 32             	imul   $0x32,%eax,%eax
    1ca2:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ca5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca8:	8d 78 34             	lea    0x34(%eax),%edi
    1cab:	83 ec 0c             	sub    $0xc,%esp
    1cae:	83 ec 04             	sub    $0x4,%esp
    1cb1:	89 e0                	mov    %esp,%eax
    1cb3:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1cb7:	66 89 30             	mov    %si,(%eax)
    1cba:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1cbe:	88 50 02             	mov    %dl,0x2(%eax)
    1cc1:	6a 32                	push   $0x32
    1cc3:	6a 32                	push   $0x32
    1cc5:	6a 00                	push   $0x0
    1cc7:	6a 00                	push   $0x0
    1cc9:	53                   	push   %ebx
    1cca:	51                   	push   %ecx
    1ccb:	ff 75 94             	pushl  -0x6c(%ebp)
    1cce:	57                   	push   %edi
    1ccf:	e8 d1 f4 ff ff       	call   11a5 <APDcCopy>
    1cd4:	83 c4 30             	add    $0x30,%esp
                    break;
    1cd7:	eb 5c                	jmp    1d35 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cd9:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1cdc:	6a 0c                	push   $0xc
    1cde:	6a 0c                	push   $0xc
    1ce0:	6a 0c                	push   $0xc
    1ce2:	50                   	push   %eax
    1ce3:	e8 61 f6 ff ff       	call   1349 <RGB>
    1ce8:	83 c4 0c             	add    $0xc,%esp
    1ceb:	8b 1d d0 27 00 00    	mov    0x27d0,%ebx
    1cf1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cf4:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cf7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cfa:	6b c0 32             	imul   $0x32,%eax,%eax
    1cfd:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d00:	8b 45 08             	mov    0x8(%ebp),%eax
    1d03:	8d 78 34             	lea    0x34(%eax),%edi
    1d06:	83 ec 0c             	sub    $0xc,%esp
    1d09:	83 ec 04             	sub    $0x4,%esp
    1d0c:	89 e0                	mov    %esp,%eax
    1d0e:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1d12:	66 89 30             	mov    %si,(%eax)
    1d15:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1d19:	88 50 02             	mov    %dl,0x2(%eax)
    1d1c:	6a 32                	push   $0x32
    1d1e:	6a 32                	push   $0x32
    1d20:	6a 00                	push   $0x0
    1d22:	6a 00                	push   $0x0
    1d24:	53                   	push   %ebx
    1d25:	51                   	push   %ecx
    1d26:	ff 75 94             	pushl  -0x6c(%ebp)
    1d29:	57                   	push   %edi
    1d2a:	e8 76 f4 ff ff       	call   11a5 <APDcCopy>
    1d2f:	83 c4 30             	add    $0x30,%esp
                    break;
    1d32:	eb 01                	jmp    1d35 <APGridPaint+0x639>
                default: break;
    1d34:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d35:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1d39:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1d3d:	0f 8e 7a fc ff ff    	jle    19bd <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d43:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1d47:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1d4b:	0f 8e 60 fc ff ff    	jle    19b1 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1d51:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1d54:	5b                   	pop    %ebx
    1d55:	5e                   	pop    %esi
    1d56:	5f                   	pop    %edi
    1d57:	5d                   	pop    %ebp
    1d58:	c3                   	ret    

00001d59 <random>:
//

#include "APLib.h"

int random(int seed)
{
    1d59:	55                   	push   %ebp
    1d5a:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1d5c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1d60:	7e 08                	jle    1d6a <random+0x11>
{
rand_num = seed;
    1d62:	8b 45 08             	mov    0x8(%ebp),%eax
    1d65:	a3 8c 27 00 00       	mov    %eax,0x278c
}
rand_num *= 3;
    1d6a:	8b 15 8c 27 00 00    	mov    0x278c,%edx
    1d70:	89 d0                	mov    %edx,%eax
    1d72:	01 c0                	add    %eax,%eax
    1d74:	01 d0                	add    %edx,%eax
    1d76:	a3 8c 27 00 00       	mov    %eax,0x278c
if (rand_num < 0)
    1d7b:	a1 8c 27 00 00       	mov    0x278c,%eax
    1d80:	85 c0                	test   %eax,%eax
    1d82:	79 0c                	jns    1d90 <random+0x37>
{
rand_num *= (-1);
    1d84:	a1 8c 27 00 00       	mov    0x278c,%eax
    1d89:	f7 d8                	neg    %eax
    1d8b:	a3 8c 27 00 00       	mov    %eax,0x278c
}
return rand_num % 997;
    1d90:	8b 0d 8c 27 00 00    	mov    0x278c,%ecx
    1d96:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1d9b:	89 c8                	mov    %ecx,%eax
    1d9d:	f7 ea                	imul   %edx
    1d9f:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1da2:	c1 f8 09             	sar    $0x9,%eax
    1da5:	89 c2                	mov    %eax,%edx
    1da7:	89 c8                	mov    %ecx,%eax
    1da9:	c1 f8 1f             	sar    $0x1f,%eax
    1dac:	29 c2                	sub    %eax,%edx
    1dae:	89 d0                	mov    %edx,%eax
    1db0:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1db6:	29 c1                	sub    %eax,%ecx
    1db8:	89 c8                	mov    %ecx,%eax
}
    1dba:	5d                   	pop    %ebp
    1dbb:	c3                   	ret    

00001dbc <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1dbc:	55                   	push   %ebp
    1dbd:	89 e5                	mov    %esp,%ebp
    1dbf:	53                   	push   %ebx
    1dc0:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1dc3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1dca:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1dce:	74 17                	je     1de7 <sprintint+0x2b>
    1dd0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1dd4:	79 11                	jns    1de7 <sprintint+0x2b>
        neg = 1;
    1dd6:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1ddd:	8b 45 10             	mov    0x10(%ebp),%eax
    1de0:	f7 d8                	neg    %eax
    1de2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1de5:	eb 06                	jmp    1ded <sprintint+0x31>
    } else {
        x = xx;
    1de7:	8b 45 10             	mov    0x10(%ebp),%eax
    1dea:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1ded:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1df4:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1df7:	8d 41 01             	lea    0x1(%ecx),%eax
    1dfa:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1dfd:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e00:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e03:	ba 00 00 00 00       	mov    $0x0,%edx
    1e08:	f7 f3                	div    %ebx
    1e0a:	89 d0                	mov    %edx,%eax
    1e0c:	0f b6 80 90 27 00 00 	movzbl 0x2790(%eax),%eax
    1e13:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1e17:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e1d:	ba 00 00 00 00       	mov    $0x0,%edx
    1e22:	f7 f3                	div    %ebx
    1e24:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e27:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e2b:	75 c7                	jne    1df4 <sprintint+0x38>
    if(neg)
    1e2d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e31:	74 0e                	je     1e41 <sprintint+0x85>
        buf[i++] = '-';
    1e33:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e36:	8d 50 01             	lea    0x1(%eax),%edx
    1e39:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1e3c:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1e41:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e44:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1e47:	eb 1b                	jmp    1e64 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1e49:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e4c:	8b 00                	mov    (%eax),%eax
    1e4e:	8d 48 01             	lea    0x1(%eax),%ecx
    1e51:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e54:	89 0a                	mov    %ecx,(%edx)
    1e56:	89 c2                	mov    %eax,%edx
    1e58:	8b 45 08             	mov    0x8(%ebp),%eax
    1e5b:	01 d0                	add    %edx,%eax
    1e5d:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1e60:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1e64:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1e68:	7f df                	jg     1e49 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1e6a:	eb 21                	jmp    1e8d <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1e6c:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e6f:	8b 00                	mov    (%eax),%eax
    1e71:	8d 48 01             	lea    0x1(%eax),%ecx
    1e74:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e77:	89 0a                	mov    %ecx,(%edx)
    1e79:	89 c2                	mov    %eax,%edx
    1e7b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e7e:	01 c2                	add    %eax,%edx
    1e80:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1e83:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e86:	01 c8                	add    %ecx,%eax
    1e88:	0f b6 00             	movzbl (%eax),%eax
    1e8b:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1e8d:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1e91:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1e95:	79 d5                	jns    1e6c <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1e97:	90                   	nop
    1e98:	83 c4 20             	add    $0x20,%esp
    1e9b:	5b                   	pop    %ebx
    1e9c:	5d                   	pop    %ebp
    1e9d:	c3                   	ret    

00001e9e <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1e9e:	55                   	push   %ebp
    1e9f:	89 e5                	mov    %esp,%ebp
    1ea1:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1ea4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1eab:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1eb2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1eb9:	8d 45 0c             	lea    0xc(%ebp),%eax
    1ebc:	83 c0 04             	add    $0x4,%eax
    1ebf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1ec2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1ec9:	e9 d9 01 00 00       	jmp    20a7 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1ece:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ed1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ed4:	01 d0                	add    %edx,%eax
    1ed6:	0f b6 00             	movzbl (%eax),%eax
    1ed9:	0f be c0             	movsbl %al,%eax
    1edc:	25 ff 00 00 00       	and    $0xff,%eax
    1ee1:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1ee4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1ee8:	75 2c                	jne    1f16 <sprintf+0x78>
            if(c == '%'){
    1eea:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1eee:	75 0c                	jne    1efc <sprintf+0x5e>
                state = '%';
    1ef0:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1ef7:	e9 a7 01 00 00       	jmp    20a3 <sprintf+0x205>
            } else {
                dst[j++] = c;
    1efc:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1eff:	8d 50 01             	lea    0x1(%eax),%edx
    1f02:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f05:	89 c2                	mov    %eax,%edx
    1f07:	8b 45 08             	mov    0x8(%ebp),%eax
    1f0a:	01 d0                	add    %edx,%eax
    1f0c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f0f:	88 10                	mov    %dl,(%eax)
    1f11:	e9 8d 01 00 00       	jmp    20a3 <sprintf+0x205>
            }
        } else if(state == '%'){
    1f16:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1f1a:	0f 85 83 01 00 00    	jne    20a3 <sprintf+0x205>
            if(c == 'd'){
    1f20:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1f24:	75 4c                	jne    1f72 <sprintf+0xd4>
                buf[bi] = '\0';
    1f26:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f29:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f2c:	01 d0                	add    %edx,%eax
    1f2e:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f31:	83 ec 0c             	sub    $0xc,%esp
    1f34:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f37:	50                   	push   %eax
    1f38:	e8 b4 e2 ff ff       	call   1f1 <atoi>
    1f3d:	83 c4 10             	add    $0x10,%esp
    1f40:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1f43:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1f4a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f4d:	8b 00                	mov    (%eax),%eax
    1f4f:	83 ec 08             	sub    $0x8,%esp
    1f52:	ff 75 d8             	pushl  -0x28(%ebp)
    1f55:	6a 01                	push   $0x1
    1f57:	6a 0a                	push   $0xa
    1f59:	50                   	push   %eax
    1f5a:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1f5d:	50                   	push   %eax
    1f5e:	ff 75 08             	pushl  0x8(%ebp)
    1f61:	e8 56 fe ff ff       	call   1dbc <sprintint>
    1f66:	83 c4 20             	add    $0x20,%esp
                ap++;
    1f69:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1f6d:	e9 2a 01 00 00       	jmp    209c <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1f72:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1f76:	74 06                	je     1f7e <sprintf+0xe0>
    1f78:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1f7c:	75 4c                	jne    1fca <sprintf+0x12c>
                buf[bi] = '\0';
    1f7e:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f81:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f84:	01 d0                	add    %edx,%eax
    1f86:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f89:	83 ec 0c             	sub    $0xc,%esp
    1f8c:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f8f:	50                   	push   %eax
    1f90:	e8 5c e2 ff ff       	call   1f1 <atoi>
    1f95:	83 c4 10             	add    $0x10,%esp
    1f98:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1f9b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1fa2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fa5:	8b 00                	mov    (%eax),%eax
    1fa7:	83 ec 08             	sub    $0x8,%esp
    1faa:	ff 75 dc             	pushl  -0x24(%ebp)
    1fad:	6a 00                	push   $0x0
    1faf:	6a 10                	push   $0x10
    1fb1:	50                   	push   %eax
    1fb2:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1fb5:	50                   	push   %eax
    1fb6:	ff 75 08             	pushl  0x8(%ebp)
    1fb9:	e8 fe fd ff ff       	call   1dbc <sprintint>
    1fbe:	83 c4 20             	add    $0x20,%esp
                ap++;
    1fc1:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1fc5:	e9 d2 00 00 00       	jmp    209c <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1fca:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1fce:	75 46                	jne    2016 <sprintf+0x178>
                s = (char*)*ap;
    1fd0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fd3:	8b 00                	mov    (%eax),%eax
    1fd5:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1fd8:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1fdc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fe0:	75 25                	jne    2007 <sprintf+0x169>
                    s = "(null)";
    1fe2:	c7 45 f4 44 22 00 00 	movl   $0x2244,-0xc(%ebp)
                while(*s != 0){
    1fe9:	eb 1c                	jmp    2007 <sprintf+0x169>
                    dst[j++] = *s;
    1feb:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1fee:	8d 50 01             	lea    0x1(%eax),%edx
    1ff1:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1ff4:	89 c2                	mov    %eax,%edx
    1ff6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ff9:	01 c2                	add    %eax,%edx
    1ffb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ffe:	0f b6 00             	movzbl (%eax),%eax
    2001:	88 02                	mov    %al,(%edx)
                    s++;
    2003:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2007:	8b 45 f4             	mov    -0xc(%ebp),%eax
    200a:	0f b6 00             	movzbl (%eax),%eax
    200d:	84 c0                	test   %al,%al
    200f:	75 da                	jne    1feb <sprintf+0x14d>
    2011:	e9 86 00 00 00       	jmp    209c <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2016:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    201a:	75 1d                	jne    2039 <sprintf+0x19b>
                dst[j++] = *ap;
    201c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    201f:	8d 50 01             	lea    0x1(%eax),%edx
    2022:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2025:	89 c2                	mov    %eax,%edx
    2027:	8b 45 08             	mov    0x8(%ebp),%eax
    202a:	01 c2                	add    %eax,%edx
    202c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    202f:	8b 00                	mov    (%eax),%eax
    2031:	88 02                	mov    %al,(%edx)
                ap++;
    2033:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2037:	eb 63                	jmp    209c <sprintf+0x1fe>
            } else if(c == '%'){
    2039:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    203d:	75 17                	jne    2056 <sprintf+0x1b8>
                dst[j++] = c;
    203f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2042:	8d 50 01             	lea    0x1(%eax),%edx
    2045:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2048:	89 c2                	mov    %eax,%edx
    204a:	8b 45 08             	mov    0x8(%ebp),%eax
    204d:	01 d0                	add    %edx,%eax
    204f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2052:	88 10                	mov    %dl,(%eax)
    2054:	eb 46                	jmp    209c <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2056:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    205a:	7e 18                	jle    2074 <sprintf+0x1d6>
    205c:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2060:	7f 12                	jg     2074 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2062:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2065:	8d 50 01             	lea    0x1(%eax),%edx
    2068:	89 55 f0             	mov    %edx,-0x10(%ebp)
    206b:	8b 55 e0             	mov    -0x20(%ebp),%edx
    206e:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2072:	eb 2f                	jmp    20a3 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2074:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2077:	8d 50 01             	lea    0x1(%eax),%edx
    207a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    207d:	89 c2                	mov    %eax,%edx
    207f:	8b 45 08             	mov    0x8(%ebp),%eax
    2082:	01 d0                	add    %edx,%eax
    2084:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2087:	8b 45 c8             	mov    -0x38(%ebp),%eax
    208a:	8d 50 01             	lea    0x1(%eax),%edx
    208d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2090:	89 c2                	mov    %eax,%edx
    2092:	8b 45 08             	mov    0x8(%ebp),%eax
    2095:	01 d0                	add    %edx,%eax
    2097:	8b 55 e0             	mov    -0x20(%ebp),%edx
    209a:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    209c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    20a3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    20a7:	8b 55 0c             	mov    0xc(%ebp),%edx
    20aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
    20ad:	01 d0                	add    %edx,%eax
    20af:	0f b6 00             	movzbl (%eax),%eax
    20b2:	84 c0                	test   %al,%al
    20b4:	0f 85 14 fe ff ff    	jne    1ece <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    20ba:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20bd:	8d 50 01             	lea    0x1(%eax),%edx
    20c0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20c3:	89 c2                	mov    %eax,%edx
    20c5:	8b 45 08             	mov    0x8(%ebp),%eax
    20c8:	01 d0                	add    %edx,%eax
    20ca:	c6 00 00             	movb   $0x0,(%eax)
}
    20cd:	90                   	nop
    20ce:	c9                   	leave  
    20cf:	c3                   	ret    
