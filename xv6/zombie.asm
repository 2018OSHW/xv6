
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
     3ce:	0f b6 80 a0 2a 00 00 	movzbl 0x2aa0(%eax),%eax
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
     50c:	c7 45 f4 a0 23 00 00 	movl   $0x23a0,-0xc(%ebp)
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
     5d2:	a1 00 67 00 00       	mov    0x6700,%eax
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
     69d:	a3 00 67 00 00       	mov    %eax,0x6700
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
     6fe:	a1 00 67 00 00       	mov    0x6700,%eax
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
     71a:	a1 00 67 00 00       	mov    0x6700,%eax
     71f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     722:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     726:	75 23                	jne    74b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     728:	c7 45 f0 f8 66 00 00 	movl   $0x66f8,-0x10(%ebp)
     72f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     732:	a3 00 67 00 00       	mov    %eax,0x6700
     737:	a1 00 67 00 00       	mov    0x6700,%eax
     73c:	a3 f8 66 00 00       	mov    %eax,0x66f8
    base.s.size = 0;
     741:	c7 05 fc 66 00 00 00 	movl   $0x0,0x66fc
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
     79e:	a3 00 67 00 00       	mov    %eax,0x6700
      return (void*)(p + 1);
     7a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a6:	83 c0 08             	add    $0x8,%eax
     7a9:	eb 3b                	jmp    7e6 <malloc+0xe1>
    }
    if(p == freep)
     7ab:	a1 00 67 00 00       	mov    0x6700,%eax
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
     8f1:	68 a7 23 00 00       	push   $0x23a7
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

00000c02 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     c02:	55                   	push   %ebp
     c03:	89 e5                	mov    %esp,%ebp
     c05:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     c08:	8b 45 0c             	mov    0xc(%ebp),%eax
     c0b:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     c0f:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c13:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     c17:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     c1a:	8b 45 0c             	mov    0xc(%ebp),%eax
     c1d:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c21:	66 89 50 13          	mov    %dx,0x13(%eax)
     c25:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c29:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     c2c:	8b 45 08             	mov    0x8(%ebp),%eax
     c2f:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c33:	66 89 10             	mov    %dx,(%eax)
     c36:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c3a:	88 50 02             	mov    %dl,0x2(%eax)
}
     c3d:	8b 45 08             	mov    0x8(%ebp),%eax
     c40:	c9                   	leave  
     c41:	c2 04 00             	ret    $0x4

00000c44 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c44:	55                   	push   %ebp
     c45:	89 e5                	mov    %esp,%ebp
     c47:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c4a:	8b 45 08             	mov    0x8(%ebp),%eax
     c4d:	8b 40 0c             	mov    0xc(%eax),%eax
     c50:	89 c2                	mov    %eax,%edx
     c52:	c1 ea 1f             	shr    $0x1f,%edx
     c55:	01 d0                	add    %edx,%eax
     c57:	d1 f8                	sar    %eax
     c59:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5f:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c63:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c66:	8b 45 10             	mov    0x10(%ebp),%eax
     c69:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c6c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c6f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c73:	0f 89 98 00 00 00    	jns    d11 <APDrawPoint+0xcd>
        i = 0;
     c79:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c80:	e9 8c 00 00 00       	jmp    d11 <APDrawPoint+0xcd>
    {
        j = x - off;
     c85:	8b 45 0c             	mov    0xc(%ebp),%eax
     c88:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c8b:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     c8e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     c92:	79 69                	jns    cfd <APDrawPoint+0xb9>
            j = 0;
     c94:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     c9b:	eb 60                	jmp    cfd <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     c9d:	ff 75 fc             	pushl  -0x4(%ebp)
     ca0:	ff 75 f8             	pushl  -0x8(%ebp)
     ca3:	ff 75 08             	pushl  0x8(%ebp)
     ca6:	e8 bb fb ff ff       	call   866 <APGetIndex>
     cab:	83 c4 0c             	add    $0xc,%esp
     cae:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     cb1:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cb5:	74 55                	je     d0c <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cb7:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     cbb:	74 67                	je     d24 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     cbd:	ff 75 10             	pushl  0x10(%ebp)
     cc0:	ff 75 0c             	pushl  0xc(%ebp)
     cc3:	ff 75 fc             	pushl  -0x4(%ebp)
     cc6:	ff 75 f8             	pushl  -0x8(%ebp)
     cc9:	e8 5f fb ff ff       	call   82d <distance_2>
     cce:	83 c4 10             	add    $0x10,%esp
     cd1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     cd4:	7f 23                	jg     cf9 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     cd6:	8b 45 08             	mov    0x8(%ebp),%eax
     cd9:	8b 48 18             	mov    0x18(%eax),%ecx
     cdc:	8b 55 ec             	mov    -0x14(%ebp),%edx
     cdf:	89 d0                	mov    %edx,%eax
     ce1:	01 c0                	add    %eax,%eax
     ce3:	01 d0                	add    %edx,%eax
     ce5:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     ce8:	8b 45 08             	mov    0x8(%ebp),%eax
     ceb:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     cef:	66 89 0a             	mov    %cx,(%edx)
     cf2:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     cf6:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     cf9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     cfd:	8b 55 0c             	mov    0xc(%ebp),%edx
     d00:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d03:	01 d0                	add    %edx,%eax
     d05:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d08:	7d 93                	jge    c9d <APDrawPoint+0x59>
     d0a:	eb 01                	jmp    d0d <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d0c:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d0d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d11:	8b 55 10             	mov    0x10(%ebp),%edx
     d14:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d17:	01 d0                	add    %edx,%eax
     d19:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d1c:	0f 8d 63 ff ff ff    	jge    c85 <APDrawPoint+0x41>
     d22:	eb 01                	jmp    d25 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d24:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d25:	c9                   	leave  
     d26:	c3                   	ret    

00000d27 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d27:	55                   	push   %ebp
     d28:	89 e5                	mov    %esp,%ebp
     d2a:	53                   	push   %ebx
     d2b:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d2e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d31:	3b 45 14             	cmp    0x14(%ebp),%eax
     d34:	0f 85 80 00 00 00    	jne    dba <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d3a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d3e:	0f 88 9d 02 00 00    	js     fe1 <APDrawLine+0x2ba>
     d44:	8b 45 08             	mov    0x8(%ebp),%eax
     d47:	8b 00                	mov    (%eax),%eax
     d49:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d4c:	0f 8e 8f 02 00 00    	jle    fe1 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d52:	8b 45 10             	mov    0x10(%ebp),%eax
     d55:	3b 45 18             	cmp    0x18(%ebp),%eax
     d58:	7e 12                	jle    d6c <APDrawLine+0x45>
        {
            int tmp = y2;
     d5a:	8b 45 18             	mov    0x18(%ebp),%eax
     d5d:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d60:	8b 45 10             	mov    0x10(%ebp),%eax
     d63:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d66:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d69:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d6c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d70:	79 07                	jns    d79 <APDrawLine+0x52>
     d72:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d79:	8b 45 08             	mov    0x8(%ebp),%eax
     d7c:	8b 40 04             	mov    0x4(%eax),%eax
     d7f:	3b 45 18             	cmp    0x18(%ebp),%eax
     d82:	7d 0c                	jge    d90 <APDrawLine+0x69>
     d84:	8b 45 08             	mov    0x8(%ebp),%eax
     d87:	8b 40 04             	mov    0x4(%eax),%eax
     d8a:	83 e8 01             	sub    $0x1,%eax
     d8d:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     d90:	8b 45 10             	mov    0x10(%ebp),%eax
     d93:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d96:	eb 15                	jmp    dad <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     d98:	ff 75 f4             	pushl  -0xc(%ebp)
     d9b:	ff 75 0c             	pushl  0xc(%ebp)
     d9e:	ff 75 08             	pushl  0x8(%ebp)
     da1:	e8 9e fe ff ff       	call   c44 <APDrawPoint>
     da6:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     da9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     dad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     db0:	3b 45 18             	cmp    0x18(%ebp),%eax
     db3:	7e e3                	jle    d98 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     db5:	e9 2b 02 00 00       	jmp    fe5 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     dba:	8b 45 10             	mov    0x10(%ebp),%eax
     dbd:	3b 45 18             	cmp    0x18(%ebp),%eax
     dc0:	75 7f                	jne    e41 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     dc2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dc6:	0f 88 18 02 00 00    	js     fe4 <APDrawLine+0x2bd>
     dcc:	8b 45 08             	mov    0x8(%ebp),%eax
     dcf:	8b 40 04             	mov    0x4(%eax),%eax
     dd2:	3b 45 10             	cmp    0x10(%ebp),%eax
     dd5:	0f 8e 09 02 00 00    	jle    fe4 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     ddb:	8b 45 0c             	mov    0xc(%ebp),%eax
     dde:	3b 45 14             	cmp    0x14(%ebp),%eax
     de1:	7e 12                	jle    df5 <APDrawLine+0xce>
        {
            int tmp = x2;
     de3:	8b 45 14             	mov    0x14(%ebp),%eax
     de6:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     de9:	8b 45 0c             	mov    0xc(%ebp),%eax
     dec:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     def:	8b 45 d8             	mov    -0x28(%ebp),%eax
     df2:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     df5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     df9:	79 07                	jns    e02 <APDrawLine+0xdb>
     dfb:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e02:	8b 45 08             	mov    0x8(%ebp),%eax
     e05:	8b 00                	mov    (%eax),%eax
     e07:	3b 45 14             	cmp    0x14(%ebp),%eax
     e0a:	7d 0b                	jge    e17 <APDrawLine+0xf0>
     e0c:	8b 45 08             	mov    0x8(%ebp),%eax
     e0f:	8b 00                	mov    (%eax),%eax
     e11:	83 e8 01             	sub    $0x1,%eax
     e14:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e17:	8b 45 0c             	mov    0xc(%ebp),%eax
     e1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e1d:	eb 15                	jmp    e34 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e1f:	ff 75 10             	pushl  0x10(%ebp)
     e22:	ff 75 f0             	pushl  -0x10(%ebp)
     e25:	ff 75 08             	pushl  0x8(%ebp)
     e28:	e8 17 fe ff ff       	call   c44 <APDrawPoint>
     e2d:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e30:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e34:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e37:	3b 45 14             	cmp    0x14(%ebp),%eax
     e3a:	7e e3                	jle    e1f <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e3c:	e9 a4 01 00 00       	jmp    fe5 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e41:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e48:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e4f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e52:	2b 45 14             	sub    0x14(%ebp),%eax
     e55:	50                   	push   %eax
     e56:	e8 fb f9 ff ff       	call   856 <abs_int>
     e5b:	83 c4 04             	add    $0x4,%esp
     e5e:	89 c3                	mov    %eax,%ebx
     e60:	8b 45 10             	mov    0x10(%ebp),%eax
     e63:	2b 45 18             	sub    0x18(%ebp),%eax
     e66:	50                   	push   %eax
     e67:	e8 ea f9 ff ff       	call   856 <abs_int>
     e6c:	83 c4 04             	add    $0x4,%esp
     e6f:	39 c3                	cmp    %eax,%ebx
     e71:	0f 8e b5 00 00 00    	jle    f2c <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e77:	8b 45 10             	mov    0x10(%ebp),%eax
     e7a:	2b 45 18             	sub    0x18(%ebp),%eax
     e7d:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e80:	db 45 b0             	fildl  -0x50(%ebp)
     e83:	8b 45 0c             	mov    0xc(%ebp),%eax
     e86:	2b 45 14             	sub    0x14(%ebp),%eax
     e89:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e8c:	db 45 b0             	fildl  -0x50(%ebp)
     e8f:	de f9                	fdivrp %st,%st(1)
     e91:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     e94:	8b 45 14             	mov    0x14(%ebp),%eax
     e97:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e9a:	7e 0e                	jle    eaa <APDrawLine+0x183>
        {
            s = x1;
     e9c:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9f:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     ea2:	8b 45 14             	mov    0x14(%ebp),%eax
     ea5:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ea8:	eb 0c                	jmp    eb6 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     eaa:	8b 45 14             	mov    0x14(%ebp),%eax
     ead:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     eb0:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb3:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     eb6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     eba:	79 07                	jns    ec3 <APDrawLine+0x19c>
     ebc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     ec3:	8b 45 08             	mov    0x8(%ebp),%eax
     ec6:	8b 00                	mov    (%eax),%eax
     ec8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ecb:	7f 0b                	jg     ed8 <APDrawLine+0x1b1>
     ecd:	8b 45 08             	mov    0x8(%ebp),%eax
     ed0:	8b 00                	mov    (%eax),%eax
     ed2:	83 e8 01             	sub    $0x1,%eax
     ed5:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     ed8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     edb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     ede:	eb 3f                	jmp    f1f <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     ee0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ee3:	2b 45 0c             	sub    0xc(%ebp),%eax
     ee6:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ee9:	db 45 b0             	fildl  -0x50(%ebp)
     eec:	dc 4d d0             	fmull  -0x30(%ebp)
     eef:	db 45 10             	fildl  0x10(%ebp)
     ef2:	de c1                	faddp  %st,%st(1)
     ef4:	d9 7d b6             	fnstcw -0x4a(%ebp)
     ef7:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     efb:	b4 0c                	mov    $0xc,%ah
     efd:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f01:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f04:	db 5d cc             	fistpl -0x34(%ebp)
     f07:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f0a:	ff 75 cc             	pushl  -0x34(%ebp)
     f0d:	ff 75 e4             	pushl  -0x1c(%ebp)
     f10:	ff 75 08             	pushl  0x8(%ebp)
     f13:	e8 2c fd ff ff       	call   c44 <APDrawPoint>
     f18:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f1b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f1f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f22:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f25:	7e b9                	jle    ee0 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f27:	e9 b9 00 00 00       	jmp    fe5 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f2c:	8b 45 0c             	mov    0xc(%ebp),%eax
     f2f:	2b 45 14             	sub    0x14(%ebp),%eax
     f32:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f35:	db 45 b0             	fildl  -0x50(%ebp)
     f38:	8b 45 10             	mov    0x10(%ebp),%eax
     f3b:	2b 45 18             	sub    0x18(%ebp),%eax
     f3e:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f41:	db 45 b0             	fildl  -0x50(%ebp)
     f44:	de f9                	fdivrp %st,%st(1)
     f46:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f49:	8b 45 10             	mov    0x10(%ebp),%eax
     f4c:	3b 45 18             	cmp    0x18(%ebp),%eax
     f4f:	7e 0e                	jle    f5f <APDrawLine+0x238>
    {
        s = y2;
     f51:	8b 45 18             	mov    0x18(%ebp),%eax
     f54:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f57:	8b 45 10             	mov    0x10(%ebp),%eax
     f5a:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f5d:	eb 0c                	jmp    f6b <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f5f:	8b 45 10             	mov    0x10(%ebp),%eax
     f62:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f65:	8b 45 18             	mov    0x18(%ebp),%eax
     f68:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f6b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f6f:	79 07                	jns    f78 <APDrawLine+0x251>
     f71:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f78:	8b 45 08             	mov    0x8(%ebp),%eax
     f7b:	8b 40 04             	mov    0x4(%eax),%eax
     f7e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f81:	7f 0c                	jg     f8f <APDrawLine+0x268>
     f83:	8b 45 08             	mov    0x8(%ebp),%eax
     f86:	8b 40 04             	mov    0x4(%eax),%eax
     f89:	83 e8 01             	sub    $0x1,%eax
     f8c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     f8f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f92:	89 45 e0             	mov    %eax,-0x20(%ebp)
     f95:	eb 3f                	jmp    fd6 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     f97:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f9a:	2b 45 10             	sub    0x10(%ebp),%eax
     f9d:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fa0:	db 45 b0             	fildl  -0x50(%ebp)
     fa3:	dc 4d c0             	fmull  -0x40(%ebp)
     fa6:	db 45 0c             	fildl  0xc(%ebp)
     fa9:	de c1                	faddp  %st,%st(1)
     fab:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fae:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fb2:	b4 0c                	mov    $0xc,%ah
     fb4:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fb8:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fbb:	db 5d bc             	fistpl -0x44(%ebp)
     fbe:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     fc1:	ff 75 e0             	pushl  -0x20(%ebp)
     fc4:	ff 75 bc             	pushl  -0x44(%ebp)
     fc7:	ff 75 08             	pushl  0x8(%ebp)
     fca:	e8 75 fc ff ff       	call   c44 <APDrawPoint>
     fcf:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     fd2:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     fd6:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fd9:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fdc:	7e b9                	jle    f97 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     fde:	90                   	nop
     fdf:	eb 04                	jmp    fe5 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     fe1:	90                   	nop
     fe2:	eb 01                	jmp    fe5 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     fe4:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     fe5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fe8:	c9                   	leave  
     fe9:	c3                   	ret    

00000fea <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     fea:	55                   	push   %ebp
     feb:	89 e5                	mov    %esp,%ebp
     fed:	53                   	push   %ebx
     fee:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
     ff1:	8b 55 10             	mov    0x10(%ebp),%edx
     ff4:	8b 45 18             	mov    0x18(%ebp),%eax
     ff7:	01 d0                	add    %edx,%eax
     ff9:	83 e8 01             	sub    $0x1,%eax
     ffc:	83 ec 04             	sub    $0x4,%esp
     fff:	50                   	push   %eax
    1000:	ff 75 0c             	pushl  0xc(%ebp)
    1003:	ff 75 10             	pushl  0x10(%ebp)
    1006:	ff 75 0c             	pushl  0xc(%ebp)
    1009:	ff 75 08             	pushl  0x8(%ebp)
    100c:	e8 16 fd ff ff       	call   d27 <APDrawLine>
    1011:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1014:	8b 55 0c             	mov    0xc(%ebp),%edx
    1017:	8b 45 14             	mov    0x14(%ebp),%eax
    101a:	01 d0                	add    %edx,%eax
    101c:	83 e8 01             	sub    $0x1,%eax
    101f:	83 ec 04             	sub    $0x4,%esp
    1022:	ff 75 10             	pushl  0x10(%ebp)
    1025:	50                   	push   %eax
    1026:	ff 75 10             	pushl  0x10(%ebp)
    1029:	ff 75 0c             	pushl  0xc(%ebp)
    102c:	ff 75 08             	pushl  0x8(%ebp)
    102f:	e8 f3 fc ff ff       	call   d27 <APDrawLine>
    1034:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1037:	8b 55 10             	mov    0x10(%ebp),%edx
    103a:	8b 45 18             	mov    0x18(%ebp),%eax
    103d:	01 d0                	add    %edx,%eax
    103f:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1042:	8b 55 0c             	mov    0xc(%ebp),%edx
    1045:	8b 45 14             	mov    0x14(%ebp),%eax
    1048:	01 d0                	add    %edx,%eax
    104a:	8d 50 ff             	lea    -0x1(%eax),%edx
    104d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1050:	8b 45 14             	mov    0x14(%ebp),%eax
    1053:	01 d8                	add    %ebx,%eax
    1055:	83 e8 01             	sub    $0x1,%eax
    1058:	83 ec 04             	sub    $0x4,%esp
    105b:	51                   	push   %ecx
    105c:	52                   	push   %edx
    105d:	ff 75 10             	pushl  0x10(%ebp)
    1060:	50                   	push   %eax
    1061:	ff 75 08             	pushl  0x8(%ebp)
    1064:	e8 be fc ff ff       	call   d27 <APDrawLine>
    1069:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    106c:	8b 55 10             	mov    0x10(%ebp),%edx
    106f:	8b 45 18             	mov    0x18(%ebp),%eax
    1072:	01 d0                	add    %edx,%eax
    1074:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1077:	8b 55 0c             	mov    0xc(%ebp),%edx
    107a:	8b 45 14             	mov    0x14(%ebp),%eax
    107d:	01 d0                	add    %edx,%eax
    107f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1082:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1085:	8b 45 18             	mov    0x18(%ebp),%eax
    1088:	01 d8                	add    %ebx,%eax
    108a:	83 e8 01             	sub    $0x1,%eax
    108d:	83 ec 04             	sub    $0x4,%esp
    1090:	51                   	push   %ecx
    1091:	52                   	push   %edx
    1092:	50                   	push   %eax
    1093:	ff 75 0c             	pushl  0xc(%ebp)
    1096:	ff 75 08             	pushl  0x8(%ebp)
    1099:	e8 89 fc ff ff       	call   d27 <APDrawLine>
    109e:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10a1:	8b 55 0c             	mov    0xc(%ebp),%edx
    10a4:	8b 45 14             	mov    0x14(%ebp),%eax
    10a7:	01 d0                	add    %edx,%eax
    10a9:	8d 50 ff             	lea    -0x1(%eax),%edx
    10ac:	8b 45 08             	mov    0x8(%ebp),%eax
    10af:	8b 40 0c             	mov    0xc(%eax),%eax
    10b2:	89 c1                	mov    %eax,%ecx
    10b4:	c1 e9 1f             	shr    $0x1f,%ecx
    10b7:	01 c8                	add    %ecx,%eax
    10b9:	d1 f8                	sar    %eax
    10bb:	29 c2                	sub    %eax,%edx
    10bd:	89 d0                	mov    %edx,%eax
    10bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10c2:	8b 55 10             	mov    0x10(%ebp),%edx
    10c5:	8b 45 18             	mov    0x18(%ebp),%eax
    10c8:	01 d0                	add    %edx,%eax
    10ca:	8d 50 ff             	lea    -0x1(%eax),%edx
    10cd:	8b 45 08             	mov    0x8(%ebp),%eax
    10d0:	8b 40 0c             	mov    0xc(%eax),%eax
    10d3:	89 c1                	mov    %eax,%ecx
    10d5:	c1 e9 1f             	shr    $0x1f,%ecx
    10d8:	01 c8                	add    %ecx,%eax
    10da:	d1 f8                	sar    %eax
    10dc:	29 c2                	sub    %eax,%edx
    10de:	89 d0                	mov    %edx,%eax
    10e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    10e3:	8b 45 08             	mov    0x8(%ebp),%eax
    10e6:	8b 40 0c             	mov    0xc(%eax),%eax
    10e9:	89 c2                	mov    %eax,%edx
    10eb:	c1 ea 1f             	shr    $0x1f,%edx
    10ee:	01 d0                	add    %edx,%eax
    10f0:	d1 f8                	sar    %eax
    10f2:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    10f5:	8b 45 08             	mov    0x8(%ebp),%eax
    10f8:	8b 40 0c             	mov    0xc(%eax),%eax
    10fb:	89 c2                	mov    %eax,%edx
    10fd:	c1 ea 1f             	shr    $0x1f,%edx
    1100:	01 d0                	add    %edx,%eax
    1102:	d1 f8                	sar    %eax
    1104:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1107:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    110b:	0f 88 d8 00 00 00    	js     11e9 <APDrawRect+0x1ff>
    1111:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1115:	0f 88 ce 00 00 00    	js     11e9 <APDrawRect+0x1ff>
    111b:	8b 45 08             	mov    0x8(%ebp),%eax
    111e:	8b 00                	mov    (%eax),%eax
    1120:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1123:	0f 8e c0 00 00 00    	jle    11e9 <APDrawRect+0x1ff>
    1129:	8b 45 08             	mov    0x8(%ebp),%eax
    112c:	8b 40 04             	mov    0x4(%eax),%eax
    112f:	3b 45 10             	cmp    0x10(%ebp),%eax
    1132:	0f 8e b1 00 00 00    	jle    11e9 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1138:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    113c:	79 07                	jns    1145 <APDrawRect+0x15b>
    113e:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1145:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1149:	79 07                	jns    1152 <APDrawRect+0x168>
    114b:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1152:	8b 45 08             	mov    0x8(%ebp),%eax
    1155:	8b 00                	mov    (%eax),%eax
    1157:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    115a:	7f 0b                	jg     1167 <APDrawRect+0x17d>
    115c:	8b 45 08             	mov    0x8(%ebp),%eax
    115f:	8b 00                	mov    (%eax),%eax
    1161:	83 e8 01             	sub    $0x1,%eax
    1164:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1167:	8b 45 08             	mov    0x8(%ebp),%eax
    116a:	8b 40 04             	mov    0x4(%eax),%eax
    116d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1170:	7f 0c                	jg     117e <APDrawRect+0x194>
    1172:	8b 45 08             	mov    0x8(%ebp),%eax
    1175:	8b 40 04             	mov    0x4(%eax),%eax
    1178:	83 e8 01             	sub    $0x1,%eax
    117b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    117e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1185:	8b 45 0c             	mov    0xc(%ebp),%eax
    1188:	89 45 ec             	mov    %eax,-0x14(%ebp)
    118b:	eb 52                	jmp    11df <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    118d:	8b 45 10             	mov    0x10(%ebp),%eax
    1190:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1193:	eb 3e                	jmp    11d3 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1195:	83 ec 04             	sub    $0x4,%esp
    1198:	ff 75 e8             	pushl  -0x18(%ebp)
    119b:	ff 75 ec             	pushl  -0x14(%ebp)
    119e:	ff 75 08             	pushl  0x8(%ebp)
    11a1:	e8 c0 f6 ff ff       	call   866 <APGetIndex>
    11a6:	83 c4 10             	add    $0x10,%esp
    11a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11ac:	8b 45 08             	mov    0x8(%ebp),%eax
    11af:	8b 48 18             	mov    0x18(%eax),%ecx
    11b2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11b5:	89 d0                	mov    %edx,%eax
    11b7:	01 c0                	add    %eax,%eax
    11b9:	01 d0                	add    %edx,%eax
    11bb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11be:	8b 45 08             	mov    0x8(%ebp),%eax
    11c1:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11c5:	66 89 0a             	mov    %cx,(%edx)
    11c8:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    11cc:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    11cf:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11d6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11d9:	7e ba                	jle    1195 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11db:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    11df:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11e2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11e5:	7e a6                	jle    118d <APDrawRect+0x1a3>
    11e7:	eb 01                	jmp    11ea <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    11e9:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    11ea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11ed:	c9                   	leave  
    11ee:	c3                   	ret    

000011ef <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    11ef:	55                   	push   %ebp
    11f0:	89 e5                	mov    %esp,%ebp
    11f2:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    11f5:	83 ec 0c             	sub    $0xc,%esp
    11f8:	ff 75 0c             	pushl  0xc(%ebp)
    11fb:	e8 c1 ee ff ff       	call   c1 <strlen>
    1200:	83 c4 10             	add    $0x10,%esp
    1203:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1206:	8b 45 08             	mov    0x8(%ebp),%eax
    1209:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    120d:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1211:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1215:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1218:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    121f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1226:	e9 bc 00 00 00       	jmp    12e7 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    122b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    122e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1231:	01 d0                	add    %edx,%eax
    1233:	0f b6 00             	movzbl (%eax),%eax
    1236:	0f be c0             	movsbl %al,%eax
    1239:	83 e8 20             	sub    $0x20,%eax
    123c:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    123f:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1243:	0f 87 9a 00 00 00    	ja     12e3 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1249:	8b 45 08             	mov    0x8(%ebp),%eax
    124c:	8b 00                	mov    (%eax),%eax
    124e:	0f af 45 14          	imul   0x14(%ebp),%eax
    1252:	89 c2                	mov    %eax,%edx
    1254:	8b 45 10             	mov    0x10(%ebp),%eax
    1257:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    125a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    125d:	89 d0                	mov    %edx,%eax
    125f:	c1 e0 03             	shl    $0x3,%eax
    1262:	01 d0                	add    %edx,%eax
    1264:	01 c8                	add    %ecx,%eax
    1266:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1269:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1270:	eb 6b                	jmp    12dd <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1272:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1279:	eb 50                	jmp    12cb <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    127b:	8b 55 ec             	mov    -0x14(%ebp),%edx
    127e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1281:	89 d0                	mov    %edx,%eax
    1283:	c1 e0 03             	shl    $0x3,%eax
    1286:	01 d0                	add    %edx,%eax
    1288:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    128e:	01 c2                	add    %eax,%edx
    1290:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1293:	01 d0                	add    %edx,%eax
    1295:	05 c0 2a 00 00       	add    $0x2ac0,%eax
    129a:	0f b6 00             	movzbl (%eax),%eax
    129d:	84 c0                	test   %al,%al
    129f:	74 26                	je     12c7 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    12a1:	8b 45 08             	mov    0x8(%ebp),%eax
    12a4:	8b 50 18             	mov    0x18(%eax),%edx
    12a7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    12aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12ad:	01 c8                	add    %ecx,%eax
    12af:	89 c1                	mov    %eax,%ecx
    12b1:	89 c8                	mov    %ecx,%eax
    12b3:	01 c0                	add    %eax,%eax
    12b5:	01 c8                	add    %ecx,%eax
    12b7:	01 d0                	add    %edx,%eax
    12b9:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    12bd:	66 89 10             	mov    %dx,(%eax)
    12c0:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    12c4:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    12c7:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12cb:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    12cf:	7e aa                	jle    127b <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    12d1:	8b 45 08             	mov    0x8(%ebp),%eax
    12d4:	8b 00                	mov    (%eax),%eax
    12d6:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    12d9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    12dd:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    12e1:	7e 8f                	jle    1272 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    12e3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    12e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12ea:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    12ed:	0f 82 38 ff ff ff    	jb     122b <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    12f3:	90                   	nop
    12f4:	c9                   	leave  
    12f5:	c3                   	ret    

000012f6 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    12f6:	55                   	push   %ebp
    12f7:	89 e5                	mov    %esp,%ebp
    12f9:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    12fc:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1300:	0f 88 8e 01 00 00    	js     1494 <APDcCopy+0x19e>
    1306:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    130a:	0f 88 84 01 00 00    	js     1494 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1310:	8b 55 0c             	mov    0xc(%ebp),%edx
    1313:	8b 45 20             	mov    0x20(%ebp),%eax
    1316:	01 d0                	add    %edx,%eax
    1318:	89 45 fc             	mov    %eax,-0x4(%ebp)
    131b:	8b 55 10             	mov    0x10(%ebp),%edx
    131e:	8b 45 24             	mov    0x24(%ebp),%eax
    1321:	01 d0                	add    %edx,%eax
    1323:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1326:	8b 55 18             	mov    0x18(%ebp),%edx
    1329:	8b 45 20             	mov    0x20(%ebp),%eax
    132c:	01 d0                	add    %edx,%eax
    132e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1331:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1334:	8b 45 24             	mov    0x24(%ebp),%eax
    1337:	01 d0                	add    %edx,%eax
    1339:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    133c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1340:	0f 88 51 01 00 00    	js     1497 <APDcCopy+0x1a1>
    1346:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    134a:	0f 88 47 01 00 00    	js     1497 <APDcCopy+0x1a1>
    1350:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1354:	0f 88 3d 01 00 00    	js     1497 <APDcCopy+0x1a1>
    135a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    135e:	0f 88 33 01 00 00    	js     1497 <APDcCopy+0x1a1>
    1364:	8b 45 14             	mov    0x14(%ebp),%eax
    1367:	8b 00                	mov    (%eax),%eax
    1369:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    136c:	0f 8c 25 01 00 00    	jl     1497 <APDcCopy+0x1a1>
    1372:	8b 45 14             	mov    0x14(%ebp),%eax
    1375:	8b 40 04             	mov    0x4(%eax),%eax
    1378:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    137b:	0f 8c 16 01 00 00    	jl     1497 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1381:	8b 45 08             	mov    0x8(%ebp),%eax
    1384:	8b 00                	mov    (%eax),%eax
    1386:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1389:	7f 0b                	jg     1396 <APDcCopy+0xa0>
    138b:	8b 45 08             	mov    0x8(%ebp),%eax
    138e:	8b 00                	mov    (%eax),%eax
    1390:	83 e8 01             	sub    $0x1,%eax
    1393:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1396:	8b 45 08             	mov    0x8(%ebp),%eax
    1399:	8b 40 04             	mov    0x4(%eax),%eax
    139c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    139f:	7f 0c                	jg     13ad <APDcCopy+0xb7>
    13a1:	8b 45 08             	mov    0x8(%ebp),%eax
    13a4:	8b 40 04             	mov    0x4(%eax),%eax
    13a7:	83 e8 01             	sub    $0x1,%eax
    13aa:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    13ad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    13b4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    13bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13c2:	e9 bc 00 00 00       	jmp    1483 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    13c7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ca:	8b 00                	mov    (%eax),%eax
    13cc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13cf:	8b 55 10             	mov    0x10(%ebp),%edx
    13d2:	01 ca                	add    %ecx,%edx
    13d4:	0f af d0             	imul   %eax,%edx
    13d7:	8b 45 0c             	mov    0xc(%ebp),%eax
    13da:	01 d0                	add    %edx,%eax
    13dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    13df:	8b 45 14             	mov    0x14(%ebp),%eax
    13e2:	8b 00                	mov    (%eax),%eax
    13e4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13e7:	8b 55 1c             	mov    0x1c(%ebp),%edx
    13ea:	01 ca                	add    %ecx,%edx
    13ec:	0f af d0             	imul   %eax,%edx
    13ef:	8b 45 18             	mov    0x18(%ebp),%eax
    13f2:	01 d0                	add    %edx,%eax
    13f4:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    13f7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13fe:	eb 74                	jmp    1474 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1400:	8b 45 14             	mov    0x14(%ebp),%eax
    1403:	8b 50 18             	mov    0x18(%eax),%edx
    1406:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1409:	8b 45 f0             	mov    -0x10(%ebp),%eax
    140c:	01 c8                	add    %ecx,%eax
    140e:	89 c1                	mov    %eax,%ecx
    1410:	89 c8                	mov    %ecx,%eax
    1412:	01 c0                	add    %eax,%eax
    1414:	01 c8                	add    %ecx,%eax
    1416:	01 d0                	add    %edx,%eax
    1418:	0f b7 10             	movzwl (%eax),%edx
    141b:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    141f:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1423:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1426:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    142a:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    142e:	38 c2                	cmp    %al,%dl
    1430:	75 18                	jne    144a <APDcCopy+0x154>
    1432:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1436:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    143a:	38 c2                	cmp    %al,%dl
    143c:	75 0c                	jne    144a <APDcCopy+0x154>
    143e:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1442:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1446:	38 c2                	cmp    %al,%dl
    1448:	74 26                	je     1470 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    144a:	8b 45 08             	mov    0x8(%ebp),%eax
    144d:	8b 50 18             	mov    0x18(%eax),%edx
    1450:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1453:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1456:	01 c8                	add    %ecx,%eax
    1458:	89 c1                	mov    %eax,%ecx
    145a:	89 c8                	mov    %ecx,%eax
    145c:	01 c0                	add    %eax,%eax
    145e:	01 c8                	add    %ecx,%eax
    1460:	01 d0                	add    %edx,%eax
    1462:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1466:	66 89 10             	mov    %dx,(%eax)
    1469:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    146d:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1470:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1474:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1477:	2b 45 0c             	sub    0xc(%ebp),%eax
    147a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    147d:	7d 81                	jge    1400 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    147f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1483:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1486:	2b 45 10             	sub    0x10(%ebp),%eax
    1489:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    148c:	0f 8d 35 ff ff ff    	jge    13c7 <APDcCopy+0xd1>
    1492:	eb 04                	jmp    1498 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1494:	90                   	nop
    1495:	eb 01                	jmp    1498 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1497:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1498:	c9                   	leave  
    1499:	c3                   	ret    

0000149a <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    149a:	55                   	push   %ebp
    149b:	89 e5                	mov    %esp,%ebp
    149d:	83 ec 1c             	sub    $0x1c,%esp
    14a0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    14a3:	8b 55 10             	mov    0x10(%ebp),%edx
    14a6:	8b 45 14             	mov    0x14(%ebp),%eax
    14a9:	88 4d ec             	mov    %cl,-0x14(%ebp)
    14ac:	88 55 e8             	mov    %dl,-0x18(%ebp)
    14af:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    14b2:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    14b6:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    14b9:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    14bd:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    14c0:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    14c4:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    14c7:	8b 45 08             	mov    0x8(%ebp),%eax
    14ca:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    14ce:	66 89 10             	mov    %dx,(%eax)
    14d1:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    14d5:	88 50 02             	mov    %dl,0x2(%eax)
}
    14d8:	8b 45 08             	mov    0x8(%ebp),%eax
    14db:	c9                   	leave  
    14dc:	c2 04 00             	ret    $0x4

000014df <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    14df:	55                   	push   %ebp
    14e0:	89 e5                	mov    %esp,%ebp
    14e2:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    14e5:	8b 45 08             	mov    0x8(%ebp),%eax
    14e8:	8b 00                	mov    (%eax),%eax
    14ea:	83 ec 08             	sub    $0x8,%esp
    14ed:	8d 55 0c             	lea    0xc(%ebp),%edx
    14f0:	52                   	push   %edx
    14f1:	50                   	push   %eax
    14f2:	e8 34 ee ff ff       	call   32b <sendMessage>
    14f7:	83 c4 10             	add    $0x10,%esp
}
    14fa:	90                   	nop
    14fb:	c9                   	leave  
    14fc:	c3                   	ret    

000014fd <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    14fd:	55                   	push   %ebp
    14fe:	89 e5                	mov    %esp,%ebp
    1500:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1503:	83 ec 0c             	sub    $0xc,%esp
    1506:	68 98 00 00 00       	push   $0x98
    150b:	e8 f5 f1 ff ff       	call   705 <malloc>
    1510:	83 c4 10             	add    $0x10,%esp
    1513:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1516:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    151a:	75 15                	jne    1531 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    151c:	83 ec 04             	sub    $0x4,%esp
    151f:	ff 75 08             	pushl  0x8(%ebp)
    1522:	68 b8 23 00 00       	push   $0x23b8
    1527:	6a 01                	push   $0x1
    1529:	e8 04 ef ff ff       	call   432 <printf>
    152e:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1531:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1534:	05 84 00 00 00       	add    $0x84,%eax
    1539:	83 ec 08             	sub    $0x8,%esp
    153c:	ff 75 08             	pushl  0x8(%ebp)
    153f:	50                   	push   %eax
    1540:	e8 0d eb ff ff       	call   52 <strcpy>
    1545:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1548:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154b:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1552:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1555:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    155c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155f:	8b 40 3c             	mov    0x3c(%eax),%eax
    1562:	89 c2                	mov    %eax,%edx
    1564:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1567:	8b 40 40             	mov    0x40(%eax),%eax
    156a:	0f af d0             	imul   %eax,%edx
    156d:	89 d0                	mov    %edx,%eax
    156f:	01 c0                	add    %eax,%eax
    1571:	01 d0                	add    %edx,%eax
    1573:	83 ec 0c             	sub    $0xc,%esp
    1576:	50                   	push   %eax
    1577:	e8 89 f1 ff ff       	call   705 <malloc>
    157c:	83 c4 10             	add    $0x10,%esp
    157f:	89 c2                	mov    %eax,%edx
    1581:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1584:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1587:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158a:	8b 40 54             	mov    0x54(%eax),%eax
    158d:	85 c0                	test   %eax,%eax
    158f:	75 15                	jne    15a6 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1591:	83 ec 04             	sub    $0x4,%esp
    1594:	ff 75 08             	pushl  0x8(%ebp)
    1597:	68 d8 23 00 00       	push   $0x23d8
    159c:	6a 01                	push   $0x1
    159e:	e8 8f ee ff ff       	call   432 <printf>
    15a3:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a9:	8b 40 3c             	mov    0x3c(%eax),%eax
    15ac:	89 c2                	mov    %eax,%edx
    15ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b1:	8b 40 40             	mov    0x40(%eax),%eax
    15b4:	0f af d0             	imul   %eax,%edx
    15b7:	89 d0                	mov    %edx,%eax
    15b9:	01 c0                	add    %eax,%eax
    15bb:	01 c2                	add    %eax,%edx
    15bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c0:	8b 40 54             	mov    0x54(%eax),%eax
    15c3:	83 ec 04             	sub    $0x4,%esp
    15c6:	52                   	push   %edx
    15c7:	68 ff ff ff 00       	push   $0xffffff
    15cc:	50                   	push   %eax
    15cd:	e8 16 eb ff ff       	call   e8 <memset>
    15d2:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    15d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d8:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    15df:	e8 1f ed ff ff       	call   303 <getpid>
    15e4:	89 c2                	mov    %eax,%edx
    15e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e9:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    15ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ef:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    15f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f9:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1600:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1603:	8b 40 58             	mov    0x58(%eax),%eax
    1606:	89 c2                	mov    %eax,%edx
    1608:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160b:	8b 40 5c             	mov    0x5c(%eax),%eax
    160e:	0f af d0             	imul   %eax,%edx
    1611:	89 d0                	mov    %edx,%eax
    1613:	01 c0                	add    %eax,%eax
    1615:	01 d0                	add    %edx,%eax
    1617:	83 ec 0c             	sub    $0xc,%esp
    161a:	50                   	push   %eax
    161b:	e8 e5 f0 ff ff       	call   705 <malloc>
    1620:	83 c4 10             	add    $0x10,%esp
    1623:	89 c2                	mov    %eax,%edx
    1625:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1628:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    162b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162e:	8b 40 70             	mov    0x70(%eax),%eax
    1631:	85 c0                	test   %eax,%eax
    1633:	75 15                	jne    164a <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1635:	83 ec 04             	sub    $0x4,%esp
    1638:	ff 75 08             	pushl  0x8(%ebp)
    163b:	68 fc 23 00 00       	push   $0x23fc
    1640:	6a 01                	push   $0x1
    1642:	e8 eb ed ff ff       	call   432 <printf>
    1647:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    164a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164d:	8b 40 3c             	mov    0x3c(%eax),%eax
    1650:	89 c2                	mov    %eax,%edx
    1652:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1655:	8b 40 40             	mov    0x40(%eax),%eax
    1658:	0f af d0             	imul   %eax,%edx
    165b:	89 d0                	mov    %edx,%eax
    165d:	01 c0                	add    %eax,%eax
    165f:	01 c2                	add    %eax,%edx
    1661:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1664:	8b 40 54             	mov    0x54(%eax),%eax
    1667:	83 ec 04             	sub    $0x4,%esp
    166a:	52                   	push   %edx
    166b:	68 ff 00 00 00       	push   $0xff
    1670:	50                   	push   %eax
    1671:	e8 72 ea ff ff       	call   e8 <memset>
    1676:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1679:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167c:	8b 55 0c             	mov    0xc(%ebp),%edx
    167f:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1682:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1686:	74 49                	je     16d1 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1688:	8b 45 10             	mov    0x10(%ebp),%eax
    168b:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1691:	83 ec 0c             	sub    $0xc,%esp
    1694:	50                   	push   %eax
    1695:	e8 6b f0 ff ff       	call   705 <malloc>
    169a:	83 c4 10             	add    $0x10,%esp
    169d:	89 c2                	mov    %eax,%edx
    169f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a2:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    16a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a8:	8b 55 10             	mov    0x10(%ebp),%edx
    16ab:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    16ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b1:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    16b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16bb:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    16c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c5:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    16cc:	e9 8d 00 00 00       	jmp    175e <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    16d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d4:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    16db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16de:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e8:	8b 40 20             	mov    0x20(%eax),%eax
    16eb:	89 c2                	mov    %eax,%edx
    16ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f0:	8b 40 24             	mov    0x24(%eax),%eax
    16f3:	0f af d0             	imul   %eax,%edx
    16f6:	89 d0                	mov    %edx,%eax
    16f8:	01 c0                	add    %eax,%eax
    16fa:	01 d0                	add    %edx,%eax
    16fc:	83 ec 0c             	sub    $0xc,%esp
    16ff:	50                   	push   %eax
    1700:	e8 00 f0 ff ff       	call   705 <malloc>
    1705:	83 c4 10             	add    $0x10,%esp
    1708:	89 c2                	mov    %eax,%edx
    170a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170d:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1710:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1713:	8b 40 38             	mov    0x38(%eax),%eax
    1716:	85 c0                	test   %eax,%eax
    1718:	75 15                	jne    172f <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    171a:	83 ec 04             	sub    $0x4,%esp
    171d:	ff 75 08             	pushl  0x8(%ebp)
    1720:	68 24 24 00 00       	push   $0x2424
    1725:	6a 01                	push   $0x1
    1727:	e8 06 ed ff ff       	call   432 <printf>
    172c:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    172f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1732:	8b 40 20             	mov    0x20(%eax),%eax
    1735:	89 c2                	mov    %eax,%edx
    1737:	8b 45 f4             	mov    -0xc(%ebp),%eax
    173a:	8b 40 24             	mov    0x24(%eax),%eax
    173d:	0f af d0             	imul   %eax,%edx
    1740:	89 d0                	mov    %edx,%eax
    1742:	01 c0                	add    %eax,%eax
    1744:	01 c2                	add    %eax,%edx
    1746:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1749:	8b 40 38             	mov    0x38(%eax),%eax
    174c:	83 ec 04             	sub    $0x4,%esp
    174f:	52                   	push   %edx
    1750:	68 ff ff ff 00       	push   $0xffffff
    1755:	50                   	push   %eax
    1756:	e8 8d e9 ff ff       	call   e8 <memset>
    175b:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    175e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1761:	c9                   	leave  
    1762:	c3                   	ret    

00001763 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1763:	55                   	push   %ebp
    1764:	89 e5                	mov    %esp,%ebp
    1766:	57                   	push   %edi
    1767:	56                   	push   %esi
    1768:	53                   	push   %ebx
    1769:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    176c:	8b 45 0c             	mov    0xc(%ebp),%eax
    176f:	83 f8 03             	cmp    $0x3,%eax
    1772:	74 02                	je     1776 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1774:	eb 7c                	jmp    17f2 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1776:	8b 45 08             	mov    0x8(%ebp),%eax
    1779:	8b 58 1c             	mov    0x1c(%eax),%ebx
    177c:	8b 45 08             	mov    0x8(%ebp),%eax
    177f:	8b 48 18             	mov    0x18(%eax),%ecx
    1782:	8b 45 08             	mov    0x8(%ebp),%eax
    1785:	8b 50 5c             	mov    0x5c(%eax),%edx
    1788:	8b 45 08             	mov    0x8(%ebp),%eax
    178b:	8b 40 58             	mov    0x58(%eax),%eax
    178e:	8b 75 08             	mov    0x8(%ebp),%esi
    1791:	83 c6 58             	add    $0x58,%esi
    1794:	83 ec 04             	sub    $0x4,%esp
    1797:	53                   	push   %ebx
    1798:	51                   	push   %ecx
    1799:	6a 00                	push   $0x0
    179b:	52                   	push   %edx
    179c:	50                   	push   %eax
    179d:	6a 00                	push   $0x0
    179f:	6a 00                	push   $0x0
    17a1:	56                   	push   %esi
    17a2:	6a 00                	push   $0x0
    17a4:	6a 00                	push   $0x0
    17a6:	ff 75 08             	pushl  0x8(%ebp)
    17a9:	e8 75 eb ff ff       	call   323 <paintWindow>
    17ae:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    17b1:	8b 45 08             	mov    0x8(%ebp),%eax
    17b4:	8b 70 1c             	mov    0x1c(%eax),%esi
    17b7:	8b 45 08             	mov    0x8(%ebp),%eax
    17ba:	8b 58 18             	mov    0x18(%eax),%ebx
    17bd:	8b 45 08             	mov    0x8(%ebp),%eax
    17c0:	8b 48 08             	mov    0x8(%eax),%ecx
    17c3:	8b 45 08             	mov    0x8(%ebp),%eax
    17c6:	8b 50 40             	mov    0x40(%eax),%edx
    17c9:	8b 45 08             	mov    0x8(%ebp),%eax
    17cc:	8b 40 3c             	mov    0x3c(%eax),%eax
    17cf:	8b 7d 08             	mov    0x8(%ebp),%edi
    17d2:	83 c7 3c             	add    $0x3c,%edi
    17d5:	83 ec 04             	sub    $0x4,%esp
    17d8:	56                   	push   %esi
    17d9:	53                   	push   %ebx
    17da:	51                   	push   %ecx
    17db:	52                   	push   %edx
    17dc:	50                   	push   %eax
    17dd:	6a 00                	push   $0x0
    17df:	6a 00                	push   $0x0
    17e1:	57                   	push   %edi
    17e2:	6a 32                	push   $0x32
    17e4:	6a 00                	push   $0x0
    17e6:	ff 75 08             	pushl  0x8(%ebp)
    17e9:	e8 35 eb ff ff       	call   323 <paintWindow>
    17ee:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    17f1:	90                   	nop
        default: break;
            
            
    }
    return False;
    17f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
    17f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    17fa:	5b                   	pop    %ebx
    17fb:	5e                   	pop    %esi
    17fc:	5f                   	pop    %edi
    17fd:	5d                   	pop    %ebp
    17fe:	c3                   	ret    

000017ff <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    17ff:	55                   	push   %ebp
    1800:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1802:	8b 45 0c             	mov    0xc(%ebp),%eax
    1805:	8b 50 08             	mov    0x8(%eax),%edx
    1808:	8b 45 08             	mov    0x8(%ebp),%eax
    180b:	8b 00                	mov    (%eax),%eax
    180d:	39 c2                	cmp    %eax,%edx
    180f:	74 07                	je     1818 <APPreJudge+0x19>
        return False;
    1811:	b8 00 00 00 00       	mov    $0x0,%eax
    1816:	eb 05                	jmp    181d <APPreJudge+0x1e>
    return True;
    1818:	b8 01 00 00 00       	mov    $0x1,%eax
}
    181d:	5d                   	pop    %ebp
    181e:	c3                   	ret    

0000181f <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    181f:	55                   	push   %ebp
    1820:	89 e5                	mov    %esp,%ebp
    1822:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1825:	8b 45 08             	mov    0x8(%ebp),%eax
    1828:	8b 55 0c             	mov    0xc(%ebp),%edx
    182b:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1831:	83 ec 0c             	sub    $0xc,%esp
    1834:	ff 75 08             	pushl  0x8(%ebp)
    1837:	e8 ff ea ff ff       	call   33b <registWindow>
    183c:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    183f:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1846:	8b 45 08             	mov    0x8(%ebp),%eax
    1849:	8b 00                	mov    (%eax),%eax
    184b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    184e:	ff 75 f4             	pushl  -0xc(%ebp)
    1851:	ff 75 f0             	pushl  -0x10(%ebp)
    1854:	ff 75 ec             	pushl  -0x14(%ebp)
    1857:	ff 75 08             	pushl  0x8(%ebp)
    185a:	e8 80 fc ff ff       	call   14df <APSendMessage>
    185f:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1862:	83 ec 0c             	sub    $0xc,%esp
    1865:	ff 75 08             	pushl  0x8(%ebp)
    1868:	e8 c6 ea ff ff       	call   333 <getMessage>
    186d:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1870:	8b 45 08             	mov    0x8(%ebp),%eax
    1873:	83 c0 74             	add    $0x74,%eax
    1876:	83 ec 08             	sub    $0x8,%esp
    1879:	50                   	push   %eax
    187a:	ff 75 08             	pushl  0x8(%ebp)
    187d:	e8 7d ff ff ff       	call   17ff <APPreJudge>
    1882:	83 c4 10             	add    $0x10,%esp
    1885:	84 c0                	test   %al,%al
    1887:	74 1b                	je     18a4 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1889:	8b 45 08             	mov    0x8(%ebp),%eax
    188c:	ff 70 7c             	pushl  0x7c(%eax)
    188f:	ff 70 78             	pushl  0x78(%eax)
    1892:	ff 70 74             	pushl  0x74(%eax)
    1895:	ff 75 08             	pushl  0x8(%ebp)
    1898:	8b 45 0c             	mov    0xc(%ebp),%eax
    189b:	ff d0                	call   *%eax
    189d:	83 c4 10             	add    $0x10,%esp
    18a0:	84 c0                	test   %al,%al
    18a2:	75 0c                	jne    18b0 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    18a4:	8b 45 08             	mov    0x8(%ebp),%eax
    18a7:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    18ae:	eb b2                	jmp    1862 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    18b0:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    18b1:	90                   	nop
    18b2:	c9                   	leave  
    18b3:	c3                   	ret    

000018b4 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    18b4:	55                   	push   %ebp
    18b5:	89 e5                	mov    %esp,%ebp
    18b7:	57                   	push   %edi
    18b8:	56                   	push   %esi
    18b9:	53                   	push   %ebx
    18ba:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    18bd:	a1 04 67 00 00       	mov    0x6704,%eax
    18c2:	85 c0                	test   %eax,%eax
    18c4:	0f 85 2c 02 00 00    	jne    1af6 <APGridPaint+0x242>
    {
        iconReady = 1;
    18ca:	c7 05 04 67 00 00 01 	movl   $0x1,0x6704
    18d1:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    18d4:	8d 45 88             	lea    -0x78(%ebp),%eax
    18d7:	83 ec 08             	sub    $0x8,%esp
    18da:	68 4b 24 00 00       	push   $0x244b
    18df:	50                   	push   %eax
    18e0:	e8 d3 ef ff ff       	call   8b8 <APLoadBitmap>
    18e5:	83 c4 0c             	add    $0xc,%esp
    18e8:	8b 45 88             	mov    -0x78(%ebp),%eax
    18eb:	a3 28 67 00 00       	mov    %eax,0x6728
    18f0:	8b 45 8c             	mov    -0x74(%ebp),%eax
    18f3:	a3 2c 67 00 00       	mov    %eax,0x672c
    18f8:	8b 45 90             	mov    -0x70(%ebp),%eax
    18fb:	a3 30 67 00 00       	mov    %eax,0x6730
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1900:	83 ec 04             	sub    $0x4,%esp
    1903:	ff 35 30 67 00 00    	pushl  0x6730
    1909:	ff 35 2c 67 00 00    	pushl  0x672c
    190f:	ff 35 28 67 00 00    	pushl  0x6728
    1915:	e8 d8 f1 ff ff       	call   af2 <APCreateCompatibleDCFromBitmap>
    191a:	83 c4 10             	add    $0x10,%esp
    191d:	a3 34 67 00 00       	mov    %eax,0x6734
        grid_river = APLoadBitmap ("grid_river.bmp");
    1922:	8d 45 88             	lea    -0x78(%ebp),%eax
    1925:	83 ec 08             	sub    $0x8,%esp
    1928:	68 59 24 00 00       	push   $0x2459
    192d:	50                   	push   %eax
    192e:	e8 85 ef ff ff       	call   8b8 <APLoadBitmap>
    1933:	83 c4 0c             	add    $0xc,%esp
    1936:	8b 45 88             	mov    -0x78(%ebp),%eax
    1939:	a3 64 67 00 00       	mov    %eax,0x6764
    193e:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1941:	a3 68 67 00 00       	mov    %eax,0x6768
    1946:	8b 45 90             	mov    -0x70(%ebp),%eax
    1949:	a3 6c 67 00 00       	mov    %eax,0x676c
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    194e:	83 ec 04             	sub    $0x4,%esp
    1951:	ff 35 6c 67 00 00    	pushl  0x676c
    1957:	ff 35 68 67 00 00    	pushl  0x6768
    195d:	ff 35 64 67 00 00    	pushl  0x6764
    1963:	e8 8a f1 ff ff       	call   af2 <APCreateCompatibleDCFromBitmap>
    1968:	83 c4 10             	add    $0x10,%esp
    196b:	a3 54 67 00 00       	mov    %eax,0x6754
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1970:	8d 45 88             	lea    -0x78(%ebp),%eax
    1973:	83 ec 08             	sub    $0x8,%esp
    1976:	68 68 24 00 00       	push   $0x2468
    197b:	50                   	push   %eax
    197c:	e8 37 ef ff ff       	call   8b8 <APLoadBitmap>
    1981:	83 c4 0c             	add    $0xc,%esp
    1984:	8b 45 88             	mov    -0x78(%ebp),%eax
    1987:	a3 58 67 00 00       	mov    %eax,0x6758
    198c:	8b 45 8c             	mov    -0x74(%ebp),%eax
    198f:	a3 5c 67 00 00       	mov    %eax,0x675c
    1994:	8b 45 90             	mov    -0x70(%ebp),%eax
    1997:	a3 60 67 00 00       	mov    %eax,0x6760
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    199c:	83 ec 04             	sub    $0x4,%esp
    199f:	ff 35 60 67 00 00    	pushl  0x6760
    19a5:	ff 35 5c 67 00 00    	pushl  0x675c
    19ab:	ff 35 58 67 00 00    	pushl  0x6758
    19b1:	e8 3c f1 ff ff       	call   af2 <APCreateCompatibleDCFromBitmap>
    19b6:	83 c4 10             	add    $0x10,%esp
    19b9:	a3 08 67 00 00       	mov    %eax,0x6708
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    19be:	8d 45 88             	lea    -0x78(%ebp),%eax
    19c1:	83 ec 08             	sub    $0x8,%esp
    19c4:	68 77 24 00 00       	push   $0x2477
    19c9:	50                   	push   %eax
    19ca:	e8 e9 ee ff ff       	call   8b8 <APLoadBitmap>
    19cf:	83 c4 0c             	add    $0xc,%esp
    19d2:	8b 45 88             	mov    -0x78(%ebp),%eax
    19d5:	a3 3c 67 00 00       	mov    %eax,0x673c
    19da:	8b 45 8c             	mov    -0x74(%ebp),%eax
    19dd:	a3 40 67 00 00       	mov    %eax,0x6740
    19e2:	8b 45 90             	mov    -0x70(%ebp),%eax
    19e5:	a3 44 67 00 00       	mov    %eax,0x6744
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    19ea:	83 ec 04             	sub    $0x4,%esp
    19ed:	ff 35 44 67 00 00    	pushl  0x6744
    19f3:	ff 35 40 67 00 00    	pushl  0x6740
    19f9:	ff 35 3c 67 00 00    	pushl  0x673c
    19ff:	e8 ee f0 ff ff       	call   af2 <APCreateCompatibleDCFromBitmap>
    1a04:	83 c4 10             	add    $0x10,%esp
    1a07:	a3 70 67 00 00       	mov    %eax,0x6770
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1a0c:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a0f:	83 ec 08             	sub    $0x8,%esp
    1a12:	68 85 24 00 00       	push   $0x2485
    1a17:	50                   	push   %eax
    1a18:	e8 9b ee ff ff       	call   8b8 <APLoadBitmap>
    1a1d:	83 c4 0c             	add    $0xc,%esp
    1a20:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a23:	a3 18 67 00 00       	mov    %eax,0x6718
    1a28:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a2b:	a3 1c 67 00 00       	mov    %eax,0x671c
    1a30:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a33:	a3 20 67 00 00       	mov    %eax,0x6720
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1a38:	83 ec 04             	sub    $0x4,%esp
    1a3b:	ff 35 20 67 00 00    	pushl  0x6720
    1a41:	ff 35 1c 67 00 00    	pushl  0x671c
    1a47:	ff 35 18 67 00 00    	pushl  0x6718
    1a4d:	e8 a0 f0 ff ff       	call   af2 <APCreateCompatibleDCFromBitmap>
    1a52:	83 c4 10             	add    $0x10,%esp
    1a55:	a3 38 67 00 00       	mov    %eax,0x6738
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1a5a:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a5d:	83 ec 08             	sub    $0x8,%esp
    1a60:	68 95 24 00 00       	push   $0x2495
    1a65:	50                   	push   %eax
    1a66:	e8 4d ee ff ff       	call   8b8 <APLoadBitmap>
    1a6b:	83 c4 0c             	add    $0xc,%esp
    1a6e:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a71:	a3 0c 67 00 00       	mov    %eax,0x670c
    1a76:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a79:	a3 10 67 00 00       	mov    %eax,0x6710
    1a7e:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a81:	a3 14 67 00 00       	mov    %eax,0x6714
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1a86:	83 ec 04             	sub    $0x4,%esp
    1a89:	ff 35 14 67 00 00    	pushl  0x6714
    1a8f:	ff 35 10 67 00 00    	pushl  0x6710
    1a95:	ff 35 0c 67 00 00    	pushl  0x670c
    1a9b:	e8 52 f0 ff ff       	call   af2 <APCreateCompatibleDCFromBitmap>
    1aa0:	83 c4 10             	add    $0x10,%esp
    1aa3:	a3 24 67 00 00       	mov    %eax,0x6724
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1aa8:	8d 45 88             	lea    -0x78(%ebp),%eax
    1aab:	83 ec 08             	sub    $0x8,%esp
    1aae:	68 a7 24 00 00       	push   $0x24a7
    1ab3:	50                   	push   %eax
    1ab4:	e8 ff ed ff ff       	call   8b8 <APLoadBitmap>
    1ab9:	83 c4 0c             	add    $0xc,%esp
    1abc:	8b 45 88             	mov    -0x78(%ebp),%eax
    1abf:	a3 48 67 00 00       	mov    %eax,0x6748
    1ac4:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1ac7:	a3 4c 67 00 00       	mov    %eax,0x674c
    1acc:	8b 45 90             	mov    -0x70(%ebp),%eax
    1acf:	a3 50 67 00 00       	mov    %eax,0x6750
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1ad4:	83 ec 04             	sub    $0x4,%esp
    1ad7:	ff 35 50 67 00 00    	pushl  0x6750
    1add:	ff 35 4c 67 00 00    	pushl  0x674c
    1ae3:	ff 35 48 67 00 00    	pushl  0x6748
    1ae9:	e8 04 f0 ff ff       	call   af2 <APCreateCompatibleDCFromBitmap>
    1aee:	83 c4 10             	add    $0x10,%esp
    1af1:	a3 74 67 00 00       	mov    %eax,0x6774
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1af6:	8b 45 08             	mov    0x8(%ebp),%eax
    1af9:	8b 40 08             	mov    0x8(%eax),%eax
    1afc:	85 c0                	test   %eax,%eax
    1afe:	75 17                	jne    1b17 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1b00:	83 ec 08             	sub    $0x8,%esp
    1b03:	68 b8 24 00 00       	push   $0x24b8
    1b08:	6a 01                	push   $0x1
    1b0a:	e8 23 e9 ff ff       	call   432 <printf>
    1b0f:	83 c4 10             	add    $0x10,%esp
        return;
    1b12:	e9 07 05 00 00       	jmp    201e <APGridPaint+0x76a>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1b17:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1a:	8b 40 10             	mov    0x10(%eax),%eax
    1b1d:	85 c0                	test   %eax,%eax
    1b1f:	7e 10                	jle    1b31 <APGridPaint+0x27d>
    1b21:	8b 45 08             	mov    0x8(%ebp),%eax
    1b24:	8b 50 14             	mov    0x14(%eax),%edx
    1b27:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2a:	8b 40 10             	mov    0x10(%eax),%eax
    1b2d:	39 c2                	cmp    %eax,%edx
    1b2f:	7c 17                	jl     1b48 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1b31:	83 ec 08             	sub    $0x8,%esp
    1b34:	68 de 24 00 00       	push   $0x24de
    1b39:	6a 01                	push   $0x1
    1b3b:	e8 f2 e8 ff ff       	call   432 <printf>
    1b40:	83 c4 10             	add    $0x10,%esp
        return;
    1b43:	e9 d6 04 00 00       	jmp    201e <APGridPaint+0x76a>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1b48:	8b 45 08             	mov    0x8(%ebp),%eax
    1b4b:	8b 40 14             	mov    0x14(%eax),%eax
    1b4e:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1b54:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1b57:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1b5a:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1b5d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1b64:	e9 96 03 00 00       	jmp    1eff <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1b69:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1b70:	e9 7c 03 00 00       	jmp    1ef1 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1b75:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b78:	c1 e0 04             	shl    $0x4,%eax
    1b7b:	89 c2                	mov    %eax,%edx
    1b7d:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b80:	01 c2                	add    %eax,%edx
    1b82:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b85:	01 d0                	add    %edx,%eax
    1b87:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1b8a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b8d:	8b 40 0c             	mov    0xc(%eax),%eax
    1b90:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1b93:	c1 e2 02             	shl    $0x2,%edx
    1b96:	01 d0                	add    %edx,%eax
    1b98:	8b 00                	mov    (%eax),%eax
    1b9a:	83 f8 07             	cmp    $0x7,%eax
    1b9d:	0f 87 49 03 00 00    	ja     1eec <APGridPaint+0x638>
    1ba3:	8b 04 85 f4 24 00 00 	mov    0x24f4(,%eax,4),%eax
    1baa:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bac:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1baf:	6a 0c                	push   $0xc
    1bb1:	6a 0c                	push   $0xc
    1bb3:	6a 0c                	push   $0xc
    1bb5:	50                   	push   %eax
    1bb6:	e8 df f8 ff ff       	call   149a <RGB>
    1bbb:	83 c4 0c             	add    $0xc,%esp
    1bbe:	8b 1d 34 67 00 00    	mov    0x6734,%ebx
    1bc4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bc7:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bca:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bcd:	6b c0 32             	imul   $0x32,%eax,%eax
    1bd0:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1bd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd6:	8d 78 3c             	lea    0x3c(%eax),%edi
    1bd9:	83 ec 0c             	sub    $0xc,%esp
    1bdc:	83 ec 04             	sub    $0x4,%esp
    1bdf:	89 e0                	mov    %esp,%eax
    1be1:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1be5:	66 89 30             	mov    %si,(%eax)
    1be8:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1bec:	88 50 02             	mov    %dl,0x2(%eax)
    1bef:	6a 32                	push   $0x32
    1bf1:	6a 32                	push   $0x32
    1bf3:	6a 00                	push   $0x0
    1bf5:	6a 00                	push   $0x0
    1bf7:	53                   	push   %ebx
    1bf8:	51                   	push   %ecx
    1bf9:	ff 75 84             	pushl  -0x7c(%ebp)
    1bfc:	57                   	push   %edi
    1bfd:	e8 f4 f6 ff ff       	call   12f6 <APDcCopy>
    1c02:	83 c4 30             	add    $0x30,%esp
                    break;
    1c05:	e9 e3 02 00 00       	jmp    1eed <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1c0a:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c0d:	6a 69                	push   $0x69
    1c0f:	6a 69                	push   $0x69
    1c11:	6a 69                	push   $0x69
    1c13:	50                   	push   %eax
    1c14:	e8 81 f8 ff ff       	call   149a <RGB>
    1c19:	83 c4 0c             	add    $0xc,%esp
    1c1c:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1c20:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1c24:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1c28:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1c2b:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1c32:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c35:	6a 69                	push   $0x69
    1c37:	6a 69                	push   $0x69
    1c39:	6a 69                	push   $0x69
    1c3b:	50                   	push   %eax
    1c3c:	e8 59 f8 ff ff       	call   149a <RGB>
    1c41:	83 c4 0c             	add    $0xc,%esp
    1c44:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1c48:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1c4c:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1c50:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1c53:	8b 45 08             	mov    0x8(%ebp),%eax
    1c56:	8d 50 3c             	lea    0x3c(%eax),%edx
    1c59:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c5c:	ff 75 ac             	pushl  -0x54(%ebp)
    1c5f:	ff 75 a8             	pushl  -0x58(%ebp)
    1c62:	52                   	push   %edx
    1c63:	50                   	push   %eax
    1c64:	e8 1e ef ff ff       	call   b87 <APSetPen>
    1c69:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1c6c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c6f:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1c72:	8d 55 88             	lea    -0x78(%ebp),%edx
    1c75:	83 ec 04             	sub    $0x4,%esp
    1c78:	83 ec 04             	sub    $0x4,%esp
    1c7b:	89 e0                	mov    %esp,%eax
    1c7d:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1c81:	66 89 08             	mov    %cx,(%eax)
    1c84:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    1c88:	88 48 02             	mov    %cl,0x2(%eax)
    1c8b:	53                   	push   %ebx
    1c8c:	52                   	push   %edx
    1c8d:	e8 2e ef ff ff       	call   bc0 <APSetBrush>
    1c92:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1c95:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c98:	6b d0 32             	imul   $0x32,%eax,%edx
    1c9b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c9e:	6b c0 32             	imul   $0x32,%eax,%eax
    1ca1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1ca4:	83 c1 3c             	add    $0x3c,%ecx
    1ca7:	83 ec 0c             	sub    $0xc,%esp
    1caa:	6a 32                	push   $0x32
    1cac:	6a 32                	push   $0x32
    1cae:	52                   	push   %edx
    1caf:	50                   	push   %eax
    1cb0:	51                   	push   %ecx
    1cb1:	e8 34 f3 ff ff       	call   fea <APDrawRect>
    1cb6:	83 c4 20             	add    $0x20,%esp
                    break;
    1cb9:	e9 2f 02 00 00       	jmp    1eed <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cbe:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1cc1:	6a 0c                	push   $0xc
    1cc3:	6a 0c                	push   $0xc
    1cc5:	6a 0c                	push   $0xc
    1cc7:	50                   	push   %eax
    1cc8:	e8 cd f7 ff ff       	call   149a <RGB>
    1ccd:	83 c4 0c             	add    $0xc,%esp
    1cd0:	8b 1d 74 67 00 00    	mov    0x6774,%ebx
    1cd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cd9:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cdc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cdf:	6b c0 32             	imul   $0x32,%eax,%eax
    1ce2:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1ce5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce8:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ceb:	83 ec 0c             	sub    $0xc,%esp
    1cee:	83 ec 04             	sub    $0x4,%esp
    1cf1:	89 e0                	mov    %esp,%eax
    1cf3:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1cf7:	66 89 30             	mov    %si,(%eax)
    1cfa:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1cfe:	88 50 02             	mov    %dl,0x2(%eax)
    1d01:	6a 32                	push   $0x32
    1d03:	6a 32                	push   $0x32
    1d05:	6a 00                	push   $0x0
    1d07:	6a 00                	push   $0x0
    1d09:	53                   	push   %ebx
    1d0a:	51                   	push   %ecx
    1d0b:	ff 75 84             	pushl  -0x7c(%ebp)
    1d0e:	57                   	push   %edi
    1d0f:	e8 e2 f5 ff ff       	call   12f6 <APDcCopy>
    1d14:	83 c4 30             	add    $0x30,%esp
                    break;
    1d17:	e9 d1 01 00 00       	jmp    1eed <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d1c:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1d1f:	6a 0c                	push   $0xc
    1d21:	6a 0c                	push   $0xc
    1d23:	6a 0c                	push   $0xc
    1d25:	50                   	push   %eax
    1d26:	e8 6f f7 ff ff       	call   149a <RGB>
    1d2b:	83 c4 0c             	add    $0xc,%esp
    1d2e:	8b 1d 54 67 00 00    	mov    0x6754,%ebx
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
    1d51:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1d55:	66 89 30             	mov    %si,(%eax)
    1d58:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1d5c:	88 50 02             	mov    %dl,0x2(%eax)
    1d5f:	6a 32                	push   $0x32
    1d61:	6a 32                	push   $0x32
    1d63:	6a 00                	push   $0x0
    1d65:	6a 00                	push   $0x0
    1d67:	53                   	push   %ebx
    1d68:	51                   	push   %ecx
    1d69:	ff 75 84             	pushl  -0x7c(%ebp)
    1d6c:	57                   	push   %edi
    1d6d:	e8 84 f5 ff ff       	call   12f6 <APDcCopy>
    1d72:	83 c4 30             	add    $0x30,%esp
                    break;
    1d75:	e9 73 01 00 00       	jmp    1eed <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d7a:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1d7d:	6a 0c                	push   $0xc
    1d7f:	6a 0c                	push   $0xc
    1d81:	6a 0c                	push   $0xc
    1d83:	50                   	push   %eax
    1d84:	e8 11 f7 ff ff       	call   149a <RGB>
    1d89:	83 c4 0c             	add    $0xc,%esp
    1d8c:	8b 1d 38 67 00 00    	mov    0x6738,%ebx
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
    1daf:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1db3:	66 89 30             	mov    %si,(%eax)
    1db6:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1dba:	88 50 02             	mov    %dl,0x2(%eax)
    1dbd:	6a 32                	push   $0x32
    1dbf:	6a 32                	push   $0x32
    1dc1:	6a 00                	push   $0x0
    1dc3:	6a 00                	push   $0x0
    1dc5:	53                   	push   %ebx
    1dc6:	51                   	push   %ecx
    1dc7:	ff 75 84             	pushl  -0x7c(%ebp)
    1dca:	57                   	push   %edi
    1dcb:	e8 26 f5 ff ff       	call   12f6 <APDcCopy>
    1dd0:	83 c4 30             	add    $0x30,%esp
                    break;
    1dd3:	e9 15 01 00 00       	jmp    1eed <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dd8:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1ddb:	6a 0c                	push   $0xc
    1ddd:	6a 0c                	push   $0xc
    1ddf:	6a 0c                	push   $0xc
    1de1:	50                   	push   %eax
    1de2:	e8 b3 f6 ff ff       	call   149a <RGB>
    1de7:	83 c4 0c             	add    $0xc,%esp
    1dea:	8b 1d 70 67 00 00    	mov    0x6770,%ebx
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
    1e0d:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1e11:	66 89 30             	mov    %si,(%eax)
    1e14:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1e18:	88 50 02             	mov    %dl,0x2(%eax)
    1e1b:	6a 32                	push   $0x32
    1e1d:	6a 32                	push   $0x32
    1e1f:	6a 00                	push   $0x0
    1e21:	6a 00                	push   $0x0
    1e23:	53                   	push   %ebx
    1e24:	51                   	push   %ecx
    1e25:	ff 75 84             	pushl  -0x7c(%ebp)
    1e28:	57                   	push   %edi
    1e29:	e8 c8 f4 ff ff       	call   12f6 <APDcCopy>
    1e2e:	83 c4 30             	add    $0x30,%esp
                    break;
    1e31:	e9 b7 00 00 00       	jmp    1eed <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e36:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1e39:	6a 0c                	push   $0xc
    1e3b:	6a 0c                	push   $0xc
    1e3d:	6a 0c                	push   $0xc
    1e3f:	50                   	push   %eax
    1e40:	e8 55 f6 ff ff       	call   149a <RGB>
    1e45:	83 c4 0c             	add    $0xc,%esp
    1e48:	8b 1d 08 67 00 00    	mov    0x6708,%ebx
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
    1e6b:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1e6f:	66 89 30             	mov    %si,(%eax)
    1e72:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1e76:	88 50 02             	mov    %dl,0x2(%eax)
    1e79:	6a 32                	push   $0x32
    1e7b:	6a 32                	push   $0x32
    1e7d:	6a 00                	push   $0x0
    1e7f:	6a 00                	push   $0x0
    1e81:	53                   	push   %ebx
    1e82:	51                   	push   %ecx
    1e83:	ff 75 84             	pushl  -0x7c(%ebp)
    1e86:	57                   	push   %edi
    1e87:	e8 6a f4 ff ff       	call   12f6 <APDcCopy>
    1e8c:	83 c4 30             	add    $0x30,%esp
                    break;
    1e8f:	eb 5c                	jmp    1eed <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e91:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1e94:	6a 0c                	push   $0xc
    1e96:	6a 0c                	push   $0xc
    1e98:	6a 0c                	push   $0xc
    1e9a:	50                   	push   %eax
    1e9b:	e8 fa f5 ff ff       	call   149a <RGB>
    1ea0:	83 c4 0c             	add    $0xc,%esp
    1ea3:	8b 1d 24 67 00 00    	mov    0x6724,%ebx
    1ea9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1eac:	6b c8 32             	imul   $0x32,%eax,%ecx
    1eaf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1eb2:	6b c0 32             	imul   $0x32,%eax,%eax
    1eb5:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1eb8:	8b 45 08             	mov    0x8(%ebp),%eax
    1ebb:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ebe:	83 ec 0c             	sub    $0xc,%esp
    1ec1:	83 ec 04             	sub    $0x4,%esp
    1ec4:	89 e0                	mov    %esp,%eax
    1ec6:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1eca:	66 89 30             	mov    %si,(%eax)
    1ecd:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1ed1:	88 50 02             	mov    %dl,0x2(%eax)
    1ed4:	6a 32                	push   $0x32
    1ed6:	6a 32                	push   $0x32
    1ed8:	6a 00                	push   $0x0
    1eda:	6a 00                	push   $0x0
    1edc:	53                   	push   %ebx
    1edd:	51                   	push   %ecx
    1ede:	ff 75 84             	pushl  -0x7c(%ebp)
    1ee1:	57                   	push   %edi
    1ee2:	e8 0f f4 ff ff       	call   12f6 <APDcCopy>
    1ee7:	83 c4 30             	add    $0x30,%esp
                    break;
    1eea:	eb 01                	jmp    1eed <APGridPaint+0x639>
                default: break;
    1eec:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1eed:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1ef1:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1ef5:	0f 8e 7a fc ff ff    	jle    1b75 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1efb:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1eff:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1f03:	0f 8e 60 fc ff ff    	jle    1b69 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1f09:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f0c:	68 cd 00 00 00       	push   $0xcd
    1f11:	6a 74                	push   $0x74
    1f13:	6a 18                	push   $0x18
    1f15:	50                   	push   %eax
    1f16:	e8 7f f5 ff ff       	call   149a <RGB>
    1f1b:	83 c4 0c             	add    $0xc,%esp
    1f1e:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1f22:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1f26:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1f2a:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1f2d:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1f34:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f37:	68 cd 00 00 00       	push   $0xcd
    1f3c:	6a 74                	push   $0x74
    1f3e:	6a 18                	push   $0x18
    1f40:	50                   	push   %eax
    1f41:	e8 54 f5 ff ff       	call   149a <RGB>
    1f46:	83 c4 0c             	add    $0xc,%esp
    1f49:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1f4d:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1f51:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1f55:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1f58:	8b 45 08             	mov    0x8(%ebp),%eax
    1f5b:	8d 50 58             	lea    0x58(%eax),%edx
    1f5e:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f61:	ff 75 bc             	pushl  -0x44(%ebp)
    1f64:	ff 75 b8             	pushl  -0x48(%ebp)
    1f67:	52                   	push   %edx
    1f68:	50                   	push   %eax
    1f69:	e8 19 ec ff ff       	call   b87 <APSetPen>
    1f6e:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1f71:	8b 45 08             	mov    0x8(%ebp),%eax
    1f74:	8d 58 58             	lea    0x58(%eax),%ebx
    1f77:	8d 55 88             	lea    -0x78(%ebp),%edx
    1f7a:	83 ec 04             	sub    $0x4,%esp
    1f7d:	83 ec 04             	sub    $0x4,%esp
    1f80:	89 e0                	mov    %esp,%eax
    1f82:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1f86:	66 89 08             	mov    %cx,(%eax)
    1f89:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1f8d:	88 48 02             	mov    %cl,0x2(%eax)
    1f90:	53                   	push   %ebx
    1f91:	52                   	push   %edx
    1f92:	e8 29 ec ff ff       	call   bc0 <APSetBrush>
    1f97:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1f9a:	8b 45 08             	mov    0x8(%ebp),%eax
    1f9d:	83 c0 58             	add    $0x58,%eax
    1fa0:	83 ec 0c             	sub    $0xc,%esp
    1fa3:	6a 32                	push   $0x32
    1fa5:	68 20 03 00 00       	push   $0x320
    1faa:	6a 00                	push   $0x0
    1fac:	6a 00                	push   $0x0
    1fae:	50                   	push   %eax
    1faf:	e8 36 f0 ff ff       	call   fea <APDrawRect>
    1fb4:	83 c4 20             	add    $0x20,%esp
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    1fb7:	8d 45 88             	lea    -0x78(%ebp),%eax
    1fba:	6a 08                	push   $0x8
    1fbc:	6a 08                	push   $0x8
    1fbe:	6a 08                	push   $0x8
    1fc0:	50                   	push   %eax
    1fc1:	e8 d4 f4 ff ff       	call   149a <RGB>
    1fc6:	83 c4 0c             	add    $0xc,%esp
    1fc9:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1fcd:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    1fd1:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1fd5:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    1fd8:	8b 45 08             	mov    0x8(%ebp),%eax
    1fdb:	8d 58 58             	lea    0x58(%eax),%ebx
    1fde:	8d 55 88             	lea    -0x78(%ebp),%edx
    1fe1:	83 ec 04             	sub    $0x4,%esp
    1fe4:	83 ec 04             	sub    $0x4,%esp
    1fe7:	89 e0                	mov    %esp,%eax
    1fe9:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    1fed:	66 89 08             	mov    %cx,(%eax)
    1ff0:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    1ff4:	88 48 02             	mov    %cl,0x2(%eax)
    1ff7:	53                   	push   %ebx
    1ff8:	52                   	push   %edx
    1ff9:	e8 04 ec ff ff       	call   c02 <APSetFont>
    1ffe:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    2001:	8b 45 08             	mov    0x8(%ebp),%eax
    2004:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    200a:	8b 45 08             	mov    0x8(%ebp),%eax
    200d:	83 c0 58             	add    $0x58,%eax
    2010:	6a 14                	push   $0x14
    2012:	6a 14                	push   $0x14
    2014:	52                   	push   %edx
    2015:	50                   	push   %eax
    2016:	e8 d4 f1 ff ff       	call   11ef <APDrawText>
    201b:	83 c4 10             	add    $0x10,%esp
}
    201e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2021:	5b                   	pop    %ebx
    2022:	5e                   	pop    %esi
    2023:	5f                   	pop    %edi
    2024:	5d                   	pop    %ebp
    2025:	c3                   	ret    

00002026 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2026:	55                   	push   %ebp
    2027:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2029:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    202d:	7e 08                	jle    2037 <random+0x11>
{
rand_num = seed;
    202f:	8b 45 08             	mov    0x8(%ebp),%eax
    2032:	a3 e0 66 00 00       	mov    %eax,0x66e0
}
rand_num *= 3;
    2037:	8b 15 e0 66 00 00    	mov    0x66e0,%edx
    203d:	89 d0                	mov    %edx,%eax
    203f:	01 c0                	add    %eax,%eax
    2041:	01 d0                	add    %edx,%eax
    2043:	a3 e0 66 00 00       	mov    %eax,0x66e0
if (rand_num < 0)
    2048:	a1 e0 66 00 00       	mov    0x66e0,%eax
    204d:	85 c0                	test   %eax,%eax
    204f:	79 0c                	jns    205d <random+0x37>
{
rand_num *= (-1);
    2051:	a1 e0 66 00 00       	mov    0x66e0,%eax
    2056:	f7 d8                	neg    %eax
    2058:	a3 e0 66 00 00       	mov    %eax,0x66e0
}
return rand_num % 997;
    205d:	8b 0d e0 66 00 00    	mov    0x66e0,%ecx
    2063:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2068:	89 c8                	mov    %ecx,%eax
    206a:	f7 ea                	imul   %edx
    206c:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    206f:	c1 f8 09             	sar    $0x9,%eax
    2072:	89 c2                	mov    %eax,%edx
    2074:	89 c8                	mov    %ecx,%eax
    2076:	c1 f8 1f             	sar    $0x1f,%eax
    2079:	29 c2                	sub    %eax,%edx
    207b:	89 d0                	mov    %edx,%eax
    207d:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2083:	29 c1                	sub    %eax,%ecx
    2085:	89 c8                	mov    %ecx,%eax
}
    2087:	5d                   	pop    %ebp
    2088:	c3                   	ret    

00002089 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2089:	55                   	push   %ebp
    208a:	89 e5                	mov    %esp,%ebp
    208c:	53                   	push   %ebx
    208d:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2090:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2097:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    209b:	74 17                	je     20b4 <sprintint+0x2b>
    209d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    20a1:	79 11                	jns    20b4 <sprintint+0x2b>
        neg = 1;
    20a3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    20aa:	8b 45 10             	mov    0x10(%ebp),%eax
    20ad:	f7 d8                	neg    %eax
    20af:	89 45 f0             	mov    %eax,-0x10(%ebp)
    20b2:	eb 06                	jmp    20ba <sprintint+0x31>
    } else {
        x = xx;
    20b4:	8b 45 10             	mov    0x10(%ebp),%eax
    20b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    20ba:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    20c1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    20c4:	8d 41 01             	lea    0x1(%ecx),%eax
    20c7:	89 45 f8             	mov    %eax,-0x8(%ebp)
    20ca:	8b 5d 14             	mov    0x14(%ebp),%ebx
    20cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20d0:	ba 00 00 00 00       	mov    $0x0,%edx
    20d5:	f7 f3                	div    %ebx
    20d7:	89 d0                	mov    %edx,%eax
    20d9:	0f b6 80 e4 66 00 00 	movzbl 0x66e4(%eax),%eax
    20e0:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    20e4:	8b 5d 14             	mov    0x14(%ebp),%ebx
    20e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20ea:	ba 00 00 00 00       	mov    $0x0,%edx
    20ef:	f7 f3                	div    %ebx
    20f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    20f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    20f8:	75 c7                	jne    20c1 <sprintint+0x38>
    if(neg)
    20fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    20fe:	74 0e                	je     210e <sprintint+0x85>
        buf[i++] = '-';
    2100:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2103:	8d 50 01             	lea    0x1(%eax),%edx
    2106:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2109:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    210e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2111:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2114:	eb 1b                	jmp    2131 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2116:	8b 45 0c             	mov    0xc(%ebp),%eax
    2119:	8b 00                	mov    (%eax),%eax
    211b:	8d 48 01             	lea    0x1(%eax),%ecx
    211e:	8b 55 0c             	mov    0xc(%ebp),%edx
    2121:	89 0a                	mov    %ecx,(%edx)
    2123:	89 c2                	mov    %eax,%edx
    2125:	8b 45 08             	mov    0x8(%ebp),%eax
    2128:	01 d0                	add    %edx,%eax
    212a:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    212d:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2131:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2135:	7f df                	jg     2116 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2137:	eb 21                	jmp    215a <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2139:	8b 45 0c             	mov    0xc(%ebp),%eax
    213c:	8b 00                	mov    (%eax),%eax
    213e:	8d 48 01             	lea    0x1(%eax),%ecx
    2141:	8b 55 0c             	mov    0xc(%ebp),%edx
    2144:	89 0a                	mov    %ecx,(%edx)
    2146:	89 c2                	mov    %eax,%edx
    2148:	8b 45 08             	mov    0x8(%ebp),%eax
    214b:	01 c2                	add    %eax,%edx
    214d:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2150:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2153:	01 c8                	add    %ecx,%eax
    2155:	0f b6 00             	movzbl (%eax),%eax
    2158:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    215a:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    215e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2162:	79 d5                	jns    2139 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2164:	90                   	nop
    2165:	83 c4 20             	add    $0x20,%esp
    2168:	5b                   	pop    %ebx
    2169:	5d                   	pop    %ebp
    216a:	c3                   	ret    

0000216b <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    216b:	55                   	push   %ebp
    216c:	89 e5                	mov    %esp,%ebp
    216e:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2171:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2178:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    217f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2186:	8d 45 0c             	lea    0xc(%ebp),%eax
    2189:	83 c0 04             	add    $0x4,%eax
    218c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    218f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2196:	e9 d9 01 00 00       	jmp    2374 <sprintf+0x209>
        c = fmt[i] & 0xff;
    219b:	8b 55 0c             	mov    0xc(%ebp),%edx
    219e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    21a1:	01 d0                	add    %edx,%eax
    21a3:	0f b6 00             	movzbl (%eax),%eax
    21a6:	0f be c0             	movsbl %al,%eax
    21a9:	25 ff 00 00 00       	and    $0xff,%eax
    21ae:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    21b1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    21b5:	75 2c                	jne    21e3 <sprintf+0x78>
            if(c == '%'){
    21b7:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    21bb:	75 0c                	jne    21c9 <sprintf+0x5e>
                state = '%';
    21bd:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    21c4:	e9 a7 01 00 00       	jmp    2370 <sprintf+0x205>
            } else {
                dst[j++] = c;
    21c9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21cc:	8d 50 01             	lea    0x1(%eax),%edx
    21cf:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21d2:	89 c2                	mov    %eax,%edx
    21d4:	8b 45 08             	mov    0x8(%ebp),%eax
    21d7:	01 d0                	add    %edx,%eax
    21d9:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21dc:	88 10                	mov    %dl,(%eax)
    21de:	e9 8d 01 00 00       	jmp    2370 <sprintf+0x205>
            }
        } else if(state == '%'){
    21e3:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    21e7:	0f 85 83 01 00 00    	jne    2370 <sprintf+0x205>
            if(c == 'd'){
    21ed:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    21f1:	75 4c                	jne    223f <sprintf+0xd4>
                buf[bi] = '\0';
    21f3:	8d 55 ce             	lea    -0x32(%ebp),%edx
    21f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21f9:	01 d0                	add    %edx,%eax
    21fb:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    21fe:	83 ec 0c             	sub    $0xc,%esp
    2201:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2204:	50                   	push   %eax
    2205:	e8 e7 df ff ff       	call   1f1 <atoi>
    220a:	83 c4 10             	add    $0x10,%esp
    220d:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2210:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2217:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    221a:	8b 00                	mov    (%eax),%eax
    221c:	83 ec 08             	sub    $0x8,%esp
    221f:	ff 75 d8             	pushl  -0x28(%ebp)
    2222:	6a 01                	push   $0x1
    2224:	6a 0a                	push   $0xa
    2226:	50                   	push   %eax
    2227:	8d 45 c8             	lea    -0x38(%ebp),%eax
    222a:	50                   	push   %eax
    222b:	ff 75 08             	pushl  0x8(%ebp)
    222e:	e8 56 fe ff ff       	call   2089 <sprintint>
    2233:	83 c4 20             	add    $0x20,%esp
                ap++;
    2236:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    223a:	e9 2a 01 00 00       	jmp    2369 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    223f:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2243:	74 06                	je     224b <sprintf+0xe0>
    2245:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2249:	75 4c                	jne    2297 <sprintf+0x12c>
                buf[bi] = '\0';
    224b:	8d 55 ce             	lea    -0x32(%ebp),%edx
    224e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2251:	01 d0                	add    %edx,%eax
    2253:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2256:	83 ec 0c             	sub    $0xc,%esp
    2259:	8d 45 ce             	lea    -0x32(%ebp),%eax
    225c:	50                   	push   %eax
    225d:	e8 8f df ff ff       	call   1f1 <atoi>
    2262:	83 c4 10             	add    $0x10,%esp
    2265:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2268:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    226f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2272:	8b 00                	mov    (%eax),%eax
    2274:	83 ec 08             	sub    $0x8,%esp
    2277:	ff 75 dc             	pushl  -0x24(%ebp)
    227a:	6a 00                	push   $0x0
    227c:	6a 10                	push   $0x10
    227e:	50                   	push   %eax
    227f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2282:	50                   	push   %eax
    2283:	ff 75 08             	pushl  0x8(%ebp)
    2286:	e8 fe fd ff ff       	call   2089 <sprintint>
    228b:	83 c4 20             	add    $0x20,%esp
                ap++;
    228e:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2292:	e9 d2 00 00 00       	jmp    2369 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2297:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    229b:	75 46                	jne    22e3 <sprintf+0x178>
                s = (char*)*ap;
    229d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22a0:	8b 00                	mov    (%eax),%eax
    22a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    22a5:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    22a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    22ad:	75 25                	jne    22d4 <sprintf+0x169>
                    s = "(null)";
    22af:	c7 45 f4 14 25 00 00 	movl   $0x2514,-0xc(%ebp)
                while(*s != 0){
    22b6:	eb 1c                	jmp    22d4 <sprintf+0x169>
                    dst[j++] = *s;
    22b8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22bb:	8d 50 01             	lea    0x1(%eax),%edx
    22be:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22c1:	89 c2                	mov    %eax,%edx
    22c3:	8b 45 08             	mov    0x8(%ebp),%eax
    22c6:	01 c2                	add    %eax,%edx
    22c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22cb:	0f b6 00             	movzbl (%eax),%eax
    22ce:	88 02                	mov    %al,(%edx)
                    s++;
    22d0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    22d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22d7:	0f b6 00             	movzbl (%eax),%eax
    22da:	84 c0                	test   %al,%al
    22dc:	75 da                	jne    22b8 <sprintf+0x14d>
    22de:	e9 86 00 00 00       	jmp    2369 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    22e3:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    22e7:	75 1d                	jne    2306 <sprintf+0x19b>
                dst[j++] = *ap;
    22e9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22ec:	8d 50 01             	lea    0x1(%eax),%edx
    22ef:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22f2:	89 c2                	mov    %eax,%edx
    22f4:	8b 45 08             	mov    0x8(%ebp),%eax
    22f7:	01 c2                	add    %eax,%edx
    22f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22fc:	8b 00                	mov    (%eax),%eax
    22fe:	88 02                	mov    %al,(%edx)
                ap++;
    2300:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2304:	eb 63                	jmp    2369 <sprintf+0x1fe>
            } else if(c == '%'){
    2306:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    230a:	75 17                	jne    2323 <sprintf+0x1b8>
                dst[j++] = c;
    230c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    230f:	8d 50 01             	lea    0x1(%eax),%edx
    2312:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2315:	89 c2                	mov    %eax,%edx
    2317:	8b 45 08             	mov    0x8(%ebp),%eax
    231a:	01 d0                	add    %edx,%eax
    231c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    231f:	88 10                	mov    %dl,(%eax)
    2321:	eb 46                	jmp    2369 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2323:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2327:	7e 18                	jle    2341 <sprintf+0x1d6>
    2329:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    232d:	7f 12                	jg     2341 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    232f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2332:	8d 50 01             	lea    0x1(%eax),%edx
    2335:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2338:	8b 55 e0             	mov    -0x20(%ebp),%edx
    233b:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    233f:	eb 2f                	jmp    2370 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2341:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2344:	8d 50 01             	lea    0x1(%eax),%edx
    2347:	89 55 c8             	mov    %edx,-0x38(%ebp)
    234a:	89 c2                	mov    %eax,%edx
    234c:	8b 45 08             	mov    0x8(%ebp),%eax
    234f:	01 d0                	add    %edx,%eax
    2351:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2354:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2357:	8d 50 01             	lea    0x1(%eax),%edx
    235a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    235d:	89 c2                	mov    %eax,%edx
    235f:	8b 45 08             	mov    0x8(%ebp),%eax
    2362:	01 d0                	add    %edx,%eax
    2364:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2367:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2369:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2370:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2374:	8b 55 0c             	mov    0xc(%ebp),%edx
    2377:	8b 45 ec             	mov    -0x14(%ebp),%eax
    237a:	01 d0                	add    %edx,%eax
    237c:	0f b6 00             	movzbl (%eax),%eax
    237f:	84 c0                	test   %al,%al
    2381:	0f 85 14 fe ff ff    	jne    219b <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2387:	8b 45 c8             	mov    -0x38(%ebp),%eax
    238a:	8d 50 01             	lea    0x1(%eax),%edx
    238d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2390:	89 c2                	mov    %eax,%edx
    2392:	8b 45 08             	mov    0x8(%ebp),%eax
    2395:	01 d0                	add    %edx,%eax
    2397:	c6 00 00             	movb   $0x0,(%eax)
}
    239a:	90                   	nop
    239b:	c9                   	leave  
    239c:	c3                   	ret    
