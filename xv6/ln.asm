
_ln：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	53                   	push   %ebx
       e:	51                   	push   %ecx
       f:	89 cb                	mov    %ecx,%ebx
  if(argc != 3){
      11:	83 3b 03             	cmpl   $0x3,(%ebx)
      14:	74 17                	je     2d <main+0x2d>
    printf(2, "Usage: ln old new\n");
      16:	83 ec 08             	sub    $0x8,%esp
      19:	68 2c 22 00 00       	push   $0x222c
      1e:	6a 02                	push   $0x2
      20:	e8 45 04 00 00       	call   46a <printf>
      25:	83 c4 10             	add    $0x10,%esp
    exit();
      28:	e8 9e 02 00 00       	call   2cb <exit>
  }
  if(link(argv[1], argv[2]) < 0)
      2d:	8b 43 04             	mov    0x4(%ebx),%eax
      30:	83 c0 08             	add    $0x8,%eax
      33:	8b 10                	mov    (%eax),%edx
      35:	8b 43 04             	mov    0x4(%ebx),%eax
      38:	83 c0 04             	add    $0x4,%eax
      3b:	8b 00                	mov    (%eax),%eax
      3d:	83 ec 08             	sub    $0x8,%esp
      40:	52                   	push   %edx
      41:	50                   	push   %eax
      42:	e8 e4 02 00 00       	call   32b <link>
      47:	83 c4 10             	add    $0x10,%esp
      4a:	85 c0                	test   %eax,%eax
      4c:	79 21                	jns    6f <main+0x6f>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
      4e:	8b 43 04             	mov    0x4(%ebx),%eax
      51:	83 c0 08             	add    $0x8,%eax
      54:	8b 10                	mov    (%eax),%edx
      56:	8b 43 04             	mov    0x4(%ebx),%eax
      59:	83 c0 04             	add    $0x4,%eax
      5c:	8b 00                	mov    (%eax),%eax
      5e:	52                   	push   %edx
      5f:	50                   	push   %eax
      60:	68 3f 22 00 00       	push   $0x223f
      65:	6a 02                	push   $0x2
      67:	e8 fe 03 00 00       	call   46a <printf>
      6c:	83 c4 10             	add    $0x10,%esp
  exit();
      6f:	e8 57 02 00 00       	call   2cb <exit>

00000074 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
      74:	55                   	push   %ebp
      75:	89 e5                	mov    %esp,%ebp
      77:	57                   	push   %edi
      78:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      79:	8b 4d 08             	mov    0x8(%ebp),%ecx
      7c:	8b 55 10             	mov    0x10(%ebp),%edx
      7f:	8b 45 0c             	mov    0xc(%ebp),%eax
      82:	89 cb                	mov    %ecx,%ebx
      84:	89 df                	mov    %ebx,%edi
      86:	89 d1                	mov    %edx,%ecx
      88:	fc                   	cld    
      89:	f3 aa                	rep stos %al,%es:(%edi)
      8b:	89 ca                	mov    %ecx,%edx
      8d:	89 fb                	mov    %edi,%ebx
      8f:	89 5d 08             	mov    %ebx,0x8(%ebp)
      92:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      95:	90                   	nop
      96:	5b                   	pop    %ebx
      97:	5f                   	pop    %edi
      98:	5d                   	pop    %ebp
      99:	c3                   	ret    

0000009a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      9a:	55                   	push   %ebp
      9b:	89 e5                	mov    %esp,%ebp
      9d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      a0:	8b 45 08             	mov    0x8(%ebp),%eax
      a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      a6:	90                   	nop
      a7:	8b 45 08             	mov    0x8(%ebp),%eax
      aa:	8d 50 01             	lea    0x1(%eax),%edx
      ad:	89 55 08             	mov    %edx,0x8(%ebp)
      b0:	8b 55 0c             	mov    0xc(%ebp),%edx
      b3:	8d 4a 01             	lea    0x1(%edx),%ecx
      b6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
      b9:	0f b6 12             	movzbl (%edx),%edx
      bc:	88 10                	mov    %dl,(%eax)
      be:	0f b6 00             	movzbl (%eax),%eax
      c1:	84 c0                	test   %al,%al
      c3:	75 e2                	jne    a7 <strcpy+0xd>
    ;
  return os;
      c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      c8:	c9                   	leave  
      c9:	c3                   	ret    

000000ca <strcmp>:

int
strcmp(const char *p, const char *q)
{
      ca:	55                   	push   %ebp
      cb:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      cd:	eb 08                	jmp    d7 <strcmp+0xd>
    p++, q++;
      cf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      d3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
      d7:	8b 45 08             	mov    0x8(%ebp),%eax
      da:	0f b6 00             	movzbl (%eax),%eax
      dd:	84 c0                	test   %al,%al
      df:	74 10                	je     f1 <strcmp+0x27>
      e1:	8b 45 08             	mov    0x8(%ebp),%eax
      e4:	0f b6 10             	movzbl (%eax),%edx
      e7:	8b 45 0c             	mov    0xc(%ebp),%eax
      ea:	0f b6 00             	movzbl (%eax),%eax
      ed:	38 c2                	cmp    %al,%dl
      ef:	74 de                	je     cf <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
      f1:	8b 45 08             	mov    0x8(%ebp),%eax
      f4:	0f b6 00             	movzbl (%eax),%eax
      f7:	0f b6 d0             	movzbl %al,%edx
      fa:	8b 45 0c             	mov    0xc(%ebp),%eax
      fd:	0f b6 00             	movzbl (%eax),%eax
     100:	0f b6 c0             	movzbl %al,%eax
     103:	29 c2                	sub    %eax,%edx
     105:	89 d0                	mov    %edx,%eax
}
     107:	5d                   	pop    %ebp
     108:	c3                   	ret    

00000109 <strlen>:

uint
strlen(char *s)
{
     109:	55                   	push   %ebp
     10a:	89 e5                	mov    %esp,%ebp
     10c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     10f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     116:	eb 04                	jmp    11c <strlen+0x13>
     118:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     11c:	8b 55 fc             	mov    -0x4(%ebp),%edx
     11f:	8b 45 08             	mov    0x8(%ebp),%eax
     122:	01 d0                	add    %edx,%eax
     124:	0f b6 00             	movzbl (%eax),%eax
     127:	84 c0                	test   %al,%al
     129:	75 ed                	jne    118 <strlen+0xf>
    ;
  return n;
     12b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     12e:	c9                   	leave  
     12f:	c3                   	ret    

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     133:	8b 45 10             	mov    0x10(%ebp),%eax
     136:	50                   	push   %eax
     137:	ff 75 0c             	pushl  0xc(%ebp)
     13a:	ff 75 08             	pushl  0x8(%ebp)
     13d:	e8 32 ff ff ff       	call   74 <stosb>
     142:	83 c4 0c             	add    $0xc,%esp
  return dst;
     145:	8b 45 08             	mov    0x8(%ebp),%eax
}
     148:	c9                   	leave  
     149:	c3                   	ret    

0000014a <strchr>:

char*
strchr(const char *s, char c)
{
     14a:	55                   	push   %ebp
     14b:	89 e5                	mov    %esp,%ebp
     14d:	83 ec 04             	sub    $0x4,%esp
     150:	8b 45 0c             	mov    0xc(%ebp),%eax
     153:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     156:	eb 14                	jmp    16c <strchr+0x22>
    if(*s == c)
     158:	8b 45 08             	mov    0x8(%ebp),%eax
     15b:	0f b6 00             	movzbl (%eax),%eax
     15e:	3a 45 fc             	cmp    -0x4(%ebp),%al
     161:	75 05                	jne    168 <strchr+0x1e>
      return (char*)s;
     163:	8b 45 08             	mov    0x8(%ebp),%eax
     166:	eb 13                	jmp    17b <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     168:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     16c:	8b 45 08             	mov    0x8(%ebp),%eax
     16f:	0f b6 00             	movzbl (%eax),%eax
     172:	84 c0                	test   %al,%al
     174:	75 e2                	jne    158 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     176:	b8 00 00 00 00       	mov    $0x0,%eax
}
     17b:	c9                   	leave  
     17c:	c3                   	ret    

0000017d <gets>:

char*
gets(char *buf, int max)
{
     17d:	55                   	push   %ebp
     17e:	89 e5                	mov    %esp,%ebp
     180:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     183:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     18a:	eb 42                	jmp    1ce <gets+0x51>
    cc = read(0, &c, 1);
     18c:	83 ec 04             	sub    $0x4,%esp
     18f:	6a 01                	push   $0x1
     191:	8d 45 ef             	lea    -0x11(%ebp),%eax
     194:	50                   	push   %eax
     195:	6a 00                	push   $0x0
     197:	e8 47 01 00 00       	call   2e3 <read>
     19c:	83 c4 10             	add    $0x10,%esp
     19f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     1a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1a6:	7e 33                	jle    1db <gets+0x5e>
      break;
    buf[i++] = c;
     1a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1ab:	8d 50 01             	lea    0x1(%eax),%edx
     1ae:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1b1:	89 c2                	mov    %eax,%edx
     1b3:	8b 45 08             	mov    0x8(%ebp),%eax
     1b6:	01 c2                	add    %eax,%edx
     1b8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1bc:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1be:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1c2:	3c 0a                	cmp    $0xa,%al
     1c4:	74 16                	je     1dc <gets+0x5f>
     1c6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1ca:	3c 0d                	cmp    $0xd,%al
     1cc:	74 0e                	je     1dc <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1d1:	83 c0 01             	add    $0x1,%eax
     1d4:	3b 45 0c             	cmp    0xc(%ebp),%eax
     1d7:	7c b3                	jl     18c <gets+0xf>
     1d9:	eb 01                	jmp    1dc <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     1db:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     1dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
     1df:	8b 45 08             	mov    0x8(%ebp),%eax
     1e2:	01 d0                	add    %edx,%eax
     1e4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     1e7:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1ea:	c9                   	leave  
     1eb:	c3                   	ret    

000001ec <stat>:

int
stat(char *n, struct stat *st)
{
     1ec:	55                   	push   %ebp
     1ed:	89 e5                	mov    %esp,%ebp
     1ef:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     1f2:	83 ec 08             	sub    $0x8,%esp
     1f5:	6a 00                	push   $0x0
     1f7:	ff 75 08             	pushl  0x8(%ebp)
     1fa:	e8 0c 01 00 00       	call   30b <open>
     1ff:	83 c4 10             	add    $0x10,%esp
     202:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     205:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     209:	79 07                	jns    212 <stat+0x26>
    return -1;
     20b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     210:	eb 25                	jmp    237 <stat+0x4b>
  r = fstat(fd, st);
     212:	83 ec 08             	sub    $0x8,%esp
     215:	ff 75 0c             	pushl  0xc(%ebp)
     218:	ff 75 f4             	pushl  -0xc(%ebp)
     21b:	e8 03 01 00 00       	call   323 <fstat>
     220:	83 c4 10             	add    $0x10,%esp
     223:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     226:	83 ec 0c             	sub    $0xc,%esp
     229:	ff 75 f4             	pushl  -0xc(%ebp)
     22c:	e8 c2 00 00 00       	call   2f3 <close>
     231:	83 c4 10             	add    $0x10,%esp
  return r;
     234:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     237:	c9                   	leave  
     238:	c3                   	ret    

00000239 <atoi>:

int
atoi(const char *s)
{
     239:	55                   	push   %ebp
     23a:	89 e5                	mov    %esp,%ebp
     23c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     23f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     246:	eb 25                	jmp    26d <atoi+0x34>
    n = n*10 + *s++ - '0';
     248:	8b 55 fc             	mov    -0x4(%ebp),%edx
     24b:	89 d0                	mov    %edx,%eax
     24d:	c1 e0 02             	shl    $0x2,%eax
     250:	01 d0                	add    %edx,%eax
     252:	01 c0                	add    %eax,%eax
     254:	89 c1                	mov    %eax,%ecx
     256:	8b 45 08             	mov    0x8(%ebp),%eax
     259:	8d 50 01             	lea    0x1(%eax),%edx
     25c:	89 55 08             	mov    %edx,0x8(%ebp)
     25f:	0f b6 00             	movzbl (%eax),%eax
     262:	0f be c0             	movsbl %al,%eax
     265:	01 c8                	add    %ecx,%eax
     267:	83 e8 30             	sub    $0x30,%eax
     26a:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     26d:	8b 45 08             	mov    0x8(%ebp),%eax
     270:	0f b6 00             	movzbl (%eax),%eax
     273:	3c 2f                	cmp    $0x2f,%al
     275:	7e 0a                	jle    281 <atoi+0x48>
     277:	8b 45 08             	mov    0x8(%ebp),%eax
     27a:	0f b6 00             	movzbl (%eax),%eax
     27d:	3c 39                	cmp    $0x39,%al
     27f:	7e c7                	jle    248 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     281:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     284:	c9                   	leave  
     285:	c3                   	ret    

00000286 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     286:	55                   	push   %ebp
     287:	89 e5                	mov    %esp,%ebp
     289:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     28c:	8b 45 08             	mov    0x8(%ebp),%eax
     28f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     292:	8b 45 0c             	mov    0xc(%ebp),%eax
     295:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     298:	eb 17                	jmp    2b1 <memmove+0x2b>
    *dst++ = *src++;
     29a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     29d:	8d 50 01             	lea    0x1(%eax),%edx
     2a0:	89 55 fc             	mov    %edx,-0x4(%ebp)
     2a3:	8b 55 f8             	mov    -0x8(%ebp),%edx
     2a6:	8d 4a 01             	lea    0x1(%edx),%ecx
     2a9:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     2ac:	0f b6 12             	movzbl (%edx),%edx
     2af:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     2b1:	8b 45 10             	mov    0x10(%ebp),%eax
     2b4:	8d 50 ff             	lea    -0x1(%eax),%edx
     2b7:	89 55 10             	mov    %edx,0x10(%ebp)
     2ba:	85 c0                	test   %eax,%eax
     2bc:	7f dc                	jg     29a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     2be:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2c1:	c9                   	leave  
     2c2:	c3                   	ret    

000002c3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2c3:	b8 01 00 00 00       	mov    $0x1,%eax
     2c8:	cd 40                	int    $0x40
     2ca:	c3                   	ret    

000002cb <exit>:
SYSCALL(exit)
     2cb:	b8 02 00 00 00       	mov    $0x2,%eax
     2d0:	cd 40                	int    $0x40
     2d2:	c3                   	ret    

000002d3 <wait>:
SYSCALL(wait)
     2d3:	b8 03 00 00 00       	mov    $0x3,%eax
     2d8:	cd 40                	int    $0x40
     2da:	c3                   	ret    

000002db <pipe>:
SYSCALL(pipe)
     2db:	b8 04 00 00 00       	mov    $0x4,%eax
     2e0:	cd 40                	int    $0x40
     2e2:	c3                   	ret    

000002e3 <read>:
SYSCALL(read)
     2e3:	b8 05 00 00 00       	mov    $0x5,%eax
     2e8:	cd 40                	int    $0x40
     2ea:	c3                   	ret    

000002eb <write>:
SYSCALL(write)
     2eb:	b8 10 00 00 00       	mov    $0x10,%eax
     2f0:	cd 40                	int    $0x40
     2f2:	c3                   	ret    

000002f3 <close>:
SYSCALL(close)
     2f3:	b8 15 00 00 00       	mov    $0x15,%eax
     2f8:	cd 40                	int    $0x40
     2fa:	c3                   	ret    

000002fb <kill>:
SYSCALL(kill)
     2fb:	b8 06 00 00 00       	mov    $0x6,%eax
     300:	cd 40                	int    $0x40
     302:	c3                   	ret    

00000303 <exec>:
SYSCALL(exec)
     303:	b8 07 00 00 00       	mov    $0x7,%eax
     308:	cd 40                	int    $0x40
     30a:	c3                   	ret    

0000030b <open>:
SYSCALL(open)
     30b:	b8 0f 00 00 00       	mov    $0xf,%eax
     310:	cd 40                	int    $0x40
     312:	c3                   	ret    

00000313 <mknod>:
SYSCALL(mknod)
     313:	b8 11 00 00 00       	mov    $0x11,%eax
     318:	cd 40                	int    $0x40
     31a:	c3                   	ret    

0000031b <unlink>:
SYSCALL(unlink)
     31b:	b8 12 00 00 00       	mov    $0x12,%eax
     320:	cd 40                	int    $0x40
     322:	c3                   	ret    

00000323 <fstat>:
SYSCALL(fstat)
     323:	b8 08 00 00 00       	mov    $0x8,%eax
     328:	cd 40                	int    $0x40
     32a:	c3                   	ret    

0000032b <link>:
SYSCALL(link)
     32b:	b8 13 00 00 00       	mov    $0x13,%eax
     330:	cd 40                	int    $0x40
     332:	c3                   	ret    

00000333 <mkdir>:
SYSCALL(mkdir)
     333:	b8 14 00 00 00       	mov    $0x14,%eax
     338:	cd 40                	int    $0x40
     33a:	c3                   	ret    

0000033b <chdir>:
SYSCALL(chdir)
     33b:	b8 09 00 00 00       	mov    $0x9,%eax
     340:	cd 40                	int    $0x40
     342:	c3                   	ret    

00000343 <dup>:
SYSCALL(dup)
     343:	b8 0a 00 00 00       	mov    $0xa,%eax
     348:	cd 40                	int    $0x40
     34a:	c3                   	ret    

0000034b <getpid>:
SYSCALL(getpid)
     34b:	b8 0b 00 00 00       	mov    $0xb,%eax
     350:	cd 40                	int    $0x40
     352:	c3                   	ret    

00000353 <sbrk>:
SYSCALL(sbrk)
     353:	b8 0c 00 00 00       	mov    $0xc,%eax
     358:	cd 40                	int    $0x40
     35a:	c3                   	ret    

0000035b <sleep>:
SYSCALL(sleep)
     35b:	b8 0d 00 00 00       	mov    $0xd,%eax
     360:	cd 40                	int    $0x40
     362:	c3                   	ret    

00000363 <uptime>:
SYSCALL(uptime)
     363:	b8 0e 00 00 00       	mov    $0xe,%eax
     368:	cd 40                	int    $0x40
     36a:	c3                   	ret    

0000036b <paintWindow>:

SYSCALL(paintWindow)
     36b:	b8 16 00 00 00       	mov    $0x16,%eax
     370:	cd 40                	int    $0x40
     372:	c3                   	ret    

00000373 <sendMessage>:
SYSCALL(sendMessage)
     373:	b8 17 00 00 00       	mov    $0x17,%eax
     378:	cd 40                	int    $0x40
     37a:	c3                   	ret    

0000037b <getMessage>:
SYSCALL(getMessage)
     37b:	b8 19 00 00 00       	mov    $0x19,%eax
     380:	cd 40                	int    $0x40
     382:	c3                   	ret    

00000383 <registWindow>:
SYSCALL(registWindow)
     383:	b8 18 00 00 00       	mov    $0x18,%eax
     388:	cd 40                	int    $0x40
     38a:	c3                   	ret    

0000038b <changePosition>:
SYSCALL(changePosition)
     38b:	b8 1a 00 00 00       	mov    $0x1a,%eax
     390:	cd 40                	int    $0x40
     392:	c3                   	ret    

00000393 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     393:	55                   	push   %ebp
     394:	89 e5                	mov    %esp,%ebp
     396:	83 ec 18             	sub    $0x18,%esp
     399:	8b 45 0c             	mov    0xc(%ebp),%eax
     39c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     39f:	83 ec 04             	sub    $0x4,%esp
     3a2:	6a 01                	push   $0x1
     3a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3a7:	50                   	push   %eax
     3a8:	ff 75 08             	pushl  0x8(%ebp)
     3ab:	e8 3b ff ff ff       	call   2eb <write>
     3b0:	83 c4 10             	add    $0x10,%esp
}
     3b3:	90                   	nop
     3b4:	c9                   	leave  
     3b5:	c3                   	ret    

000003b6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3b6:	55                   	push   %ebp
     3b7:	89 e5                	mov    %esp,%ebp
     3b9:	53                   	push   %ebx
     3ba:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3bd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3c4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3c8:	74 17                	je     3e1 <printint+0x2b>
     3ca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3ce:	79 11                	jns    3e1 <printint+0x2b>
    neg = 1;
     3d0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3d7:	8b 45 0c             	mov    0xc(%ebp),%eax
     3da:	f7 d8                	neg    %eax
     3dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3df:	eb 06                	jmp    3e7 <printint+0x31>
  } else {
    x = xx;
     3e1:	8b 45 0c             	mov    0xc(%ebp),%eax
     3e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3ee:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3f1:	8d 41 01             	lea    0x1(%ecx),%eax
     3f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3f7:	8b 5d 10             	mov    0x10(%ebp),%ebx
     3fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3fd:	ba 00 00 00 00       	mov    $0x0,%edx
     402:	f7 f3                	div    %ebx
     404:	89 d0                	mov    %edx,%eax
     406:	0f b6 80 28 29 00 00 	movzbl 0x2928(%eax),%eax
     40d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     411:	8b 5d 10             	mov    0x10(%ebp),%ebx
     414:	8b 45 ec             	mov    -0x14(%ebp),%eax
     417:	ba 00 00 00 00       	mov    $0x0,%edx
     41c:	f7 f3                	div    %ebx
     41e:	89 45 ec             	mov    %eax,-0x14(%ebp)
     421:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     425:	75 c7                	jne    3ee <printint+0x38>
  if(neg)
     427:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     42b:	74 2d                	je     45a <printint+0xa4>
    buf[i++] = '-';
     42d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     430:	8d 50 01             	lea    0x1(%eax),%edx
     433:	89 55 f4             	mov    %edx,-0xc(%ebp)
     436:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     43b:	eb 1d                	jmp    45a <printint+0xa4>
    putc(fd, buf[i]);
     43d:	8d 55 dc             	lea    -0x24(%ebp),%edx
     440:	8b 45 f4             	mov    -0xc(%ebp),%eax
     443:	01 d0                	add    %edx,%eax
     445:	0f b6 00             	movzbl (%eax),%eax
     448:	0f be c0             	movsbl %al,%eax
     44b:	83 ec 08             	sub    $0x8,%esp
     44e:	50                   	push   %eax
     44f:	ff 75 08             	pushl  0x8(%ebp)
     452:	e8 3c ff ff ff       	call   393 <putc>
     457:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     45a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     45e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     462:	79 d9                	jns    43d <printint+0x87>
    putc(fd, buf[i]);
}
     464:	90                   	nop
     465:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     468:	c9                   	leave  
     469:	c3                   	ret    

0000046a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     46a:	55                   	push   %ebp
     46b:	89 e5                	mov    %esp,%ebp
     46d:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     470:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     477:	8d 45 0c             	lea    0xc(%ebp),%eax
     47a:	83 c0 04             	add    $0x4,%eax
     47d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     480:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     487:	e9 59 01 00 00       	jmp    5e5 <printf+0x17b>
    c = fmt[i] & 0xff;
     48c:	8b 55 0c             	mov    0xc(%ebp),%edx
     48f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     492:	01 d0                	add    %edx,%eax
     494:	0f b6 00             	movzbl (%eax),%eax
     497:	0f be c0             	movsbl %al,%eax
     49a:	25 ff 00 00 00       	and    $0xff,%eax
     49f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4a2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4a6:	75 2c                	jne    4d4 <printf+0x6a>
      if(c == '%'){
     4a8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4ac:	75 0c                	jne    4ba <printf+0x50>
        state = '%';
     4ae:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4b5:	e9 27 01 00 00       	jmp    5e1 <printf+0x177>
      } else {
        putc(fd, c);
     4ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4bd:	0f be c0             	movsbl %al,%eax
     4c0:	83 ec 08             	sub    $0x8,%esp
     4c3:	50                   	push   %eax
     4c4:	ff 75 08             	pushl  0x8(%ebp)
     4c7:	e8 c7 fe ff ff       	call   393 <putc>
     4cc:	83 c4 10             	add    $0x10,%esp
     4cf:	e9 0d 01 00 00       	jmp    5e1 <printf+0x177>
      }
    } else if(state == '%'){
     4d4:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4d8:	0f 85 03 01 00 00    	jne    5e1 <printf+0x177>
      if(c == 'd'){
     4de:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4e2:	75 1e                	jne    502 <printf+0x98>
        printint(fd, *ap, 10, 1);
     4e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4e7:	8b 00                	mov    (%eax),%eax
     4e9:	6a 01                	push   $0x1
     4eb:	6a 0a                	push   $0xa
     4ed:	50                   	push   %eax
     4ee:	ff 75 08             	pushl  0x8(%ebp)
     4f1:	e8 c0 fe ff ff       	call   3b6 <printint>
     4f6:	83 c4 10             	add    $0x10,%esp
        ap++;
     4f9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4fd:	e9 d8 00 00 00       	jmp    5da <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     502:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     506:	74 06                	je     50e <printf+0xa4>
     508:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     50c:	75 1e                	jne    52c <printf+0xc2>
        printint(fd, *ap, 16, 0);
     50e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     511:	8b 00                	mov    (%eax),%eax
     513:	6a 00                	push   $0x0
     515:	6a 10                	push   $0x10
     517:	50                   	push   %eax
     518:	ff 75 08             	pushl  0x8(%ebp)
     51b:	e8 96 fe ff ff       	call   3b6 <printint>
     520:	83 c4 10             	add    $0x10,%esp
        ap++;
     523:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     527:	e9 ae 00 00 00       	jmp    5da <printf+0x170>
      } else if(c == 's'){
     52c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     530:	75 43                	jne    575 <printf+0x10b>
        s = (char*)*ap;
     532:	8b 45 e8             	mov    -0x18(%ebp),%eax
     535:	8b 00                	mov    (%eax),%eax
     537:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     53a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     53e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     542:	75 25                	jne    569 <printf+0xff>
          s = "(null)";
     544:	c7 45 f4 53 22 00 00 	movl   $0x2253,-0xc(%ebp)
        while(*s != 0){
     54b:	eb 1c                	jmp    569 <printf+0xff>
          putc(fd, *s);
     54d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     550:	0f b6 00             	movzbl (%eax),%eax
     553:	0f be c0             	movsbl %al,%eax
     556:	83 ec 08             	sub    $0x8,%esp
     559:	50                   	push   %eax
     55a:	ff 75 08             	pushl  0x8(%ebp)
     55d:	e8 31 fe ff ff       	call   393 <putc>
     562:	83 c4 10             	add    $0x10,%esp
          s++;
     565:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     569:	8b 45 f4             	mov    -0xc(%ebp),%eax
     56c:	0f b6 00             	movzbl (%eax),%eax
     56f:	84 c0                	test   %al,%al
     571:	75 da                	jne    54d <printf+0xe3>
     573:	eb 65                	jmp    5da <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     575:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     579:	75 1d                	jne    598 <printf+0x12e>
        putc(fd, *ap);
     57b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     57e:	8b 00                	mov    (%eax),%eax
     580:	0f be c0             	movsbl %al,%eax
     583:	83 ec 08             	sub    $0x8,%esp
     586:	50                   	push   %eax
     587:	ff 75 08             	pushl  0x8(%ebp)
     58a:	e8 04 fe ff ff       	call   393 <putc>
     58f:	83 c4 10             	add    $0x10,%esp
        ap++;
     592:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     596:	eb 42                	jmp    5da <printf+0x170>
      } else if(c == '%'){
     598:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     59c:	75 17                	jne    5b5 <printf+0x14b>
        putc(fd, c);
     59e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5a1:	0f be c0             	movsbl %al,%eax
     5a4:	83 ec 08             	sub    $0x8,%esp
     5a7:	50                   	push   %eax
     5a8:	ff 75 08             	pushl  0x8(%ebp)
     5ab:	e8 e3 fd ff ff       	call   393 <putc>
     5b0:	83 c4 10             	add    $0x10,%esp
     5b3:	eb 25                	jmp    5da <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5b5:	83 ec 08             	sub    $0x8,%esp
     5b8:	6a 25                	push   $0x25
     5ba:	ff 75 08             	pushl  0x8(%ebp)
     5bd:	e8 d1 fd ff ff       	call   393 <putc>
     5c2:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5c8:	0f be c0             	movsbl %al,%eax
     5cb:	83 ec 08             	sub    $0x8,%esp
     5ce:	50                   	push   %eax
     5cf:	ff 75 08             	pushl  0x8(%ebp)
     5d2:	e8 bc fd ff ff       	call   393 <putc>
     5d7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5e1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5e5:	8b 55 0c             	mov    0xc(%ebp),%edx
     5e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5eb:	01 d0                	add    %edx,%eax
     5ed:	0f b6 00             	movzbl (%eax),%eax
     5f0:	84 c0                	test   %al,%al
     5f2:	0f 85 94 fe ff ff    	jne    48c <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     5f8:	90                   	nop
     5f9:	c9                   	leave  
     5fa:	c3                   	ret    

000005fb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     5fb:	55                   	push   %ebp
     5fc:	89 e5                	mov    %esp,%ebp
     5fe:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     601:	8b 45 08             	mov    0x8(%ebp),%eax
     604:	83 e8 08             	sub    $0x8,%eax
     607:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     60a:	a1 5c 29 00 00       	mov    0x295c,%eax
     60f:	89 45 fc             	mov    %eax,-0x4(%ebp)
     612:	eb 24                	jmp    638 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     614:	8b 45 fc             	mov    -0x4(%ebp),%eax
     617:	8b 00                	mov    (%eax),%eax
     619:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     61c:	77 12                	ja     630 <free+0x35>
     61e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     621:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     624:	77 24                	ja     64a <free+0x4f>
     626:	8b 45 fc             	mov    -0x4(%ebp),%eax
     629:	8b 00                	mov    (%eax),%eax
     62b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     62e:	77 1a                	ja     64a <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     630:	8b 45 fc             	mov    -0x4(%ebp),%eax
     633:	8b 00                	mov    (%eax),%eax
     635:	89 45 fc             	mov    %eax,-0x4(%ebp)
     638:	8b 45 f8             	mov    -0x8(%ebp),%eax
     63b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     63e:	76 d4                	jbe    614 <free+0x19>
     640:	8b 45 fc             	mov    -0x4(%ebp),%eax
     643:	8b 00                	mov    (%eax),%eax
     645:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     648:	76 ca                	jbe    614 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     64a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     64d:	8b 40 04             	mov    0x4(%eax),%eax
     650:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     657:	8b 45 f8             	mov    -0x8(%ebp),%eax
     65a:	01 c2                	add    %eax,%edx
     65c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     65f:	8b 00                	mov    (%eax),%eax
     661:	39 c2                	cmp    %eax,%edx
     663:	75 24                	jne    689 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     665:	8b 45 f8             	mov    -0x8(%ebp),%eax
     668:	8b 50 04             	mov    0x4(%eax),%edx
     66b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66e:	8b 00                	mov    (%eax),%eax
     670:	8b 40 04             	mov    0x4(%eax),%eax
     673:	01 c2                	add    %eax,%edx
     675:	8b 45 f8             	mov    -0x8(%ebp),%eax
     678:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     67b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67e:	8b 00                	mov    (%eax),%eax
     680:	8b 10                	mov    (%eax),%edx
     682:	8b 45 f8             	mov    -0x8(%ebp),%eax
     685:	89 10                	mov    %edx,(%eax)
     687:	eb 0a                	jmp    693 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     689:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68c:	8b 10                	mov    (%eax),%edx
     68e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     691:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     693:	8b 45 fc             	mov    -0x4(%ebp),%eax
     696:	8b 40 04             	mov    0x4(%eax),%eax
     699:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a3:	01 d0                	add    %edx,%eax
     6a5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6a8:	75 20                	jne    6ca <free+0xcf>
    p->s.size += bp->s.size;
     6aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ad:	8b 50 04             	mov    0x4(%eax),%edx
     6b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b3:	8b 40 04             	mov    0x4(%eax),%eax
     6b6:	01 c2                	add    %eax,%edx
     6b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6bb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6be:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c1:	8b 10                	mov    (%eax),%edx
     6c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c6:	89 10                	mov    %edx,(%eax)
     6c8:	eb 08                	jmp    6d2 <free+0xd7>
  } else
    p->s.ptr = bp;
     6ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cd:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6d0:	89 10                	mov    %edx,(%eax)
  freep = p;
     6d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d5:	a3 5c 29 00 00       	mov    %eax,0x295c
}
     6da:	90                   	nop
     6db:	c9                   	leave  
     6dc:	c3                   	ret    

000006dd <morecore>:

static Header*
morecore(uint nu)
{
     6dd:	55                   	push   %ebp
     6de:	89 e5                	mov    %esp,%ebp
     6e0:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6e3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6ea:	77 07                	ja     6f3 <morecore+0x16>
    nu = 4096;
     6ec:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     6f3:	8b 45 08             	mov    0x8(%ebp),%eax
     6f6:	c1 e0 03             	shl    $0x3,%eax
     6f9:	83 ec 0c             	sub    $0xc,%esp
     6fc:	50                   	push   %eax
     6fd:	e8 51 fc ff ff       	call   353 <sbrk>
     702:	83 c4 10             	add    $0x10,%esp
     705:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     708:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     70c:	75 07                	jne    715 <morecore+0x38>
    return 0;
     70e:	b8 00 00 00 00       	mov    $0x0,%eax
     713:	eb 26                	jmp    73b <morecore+0x5e>
  hp = (Header*)p;
     715:	8b 45 f4             	mov    -0xc(%ebp),%eax
     718:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     71b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     71e:	8b 55 08             	mov    0x8(%ebp),%edx
     721:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     724:	8b 45 f0             	mov    -0x10(%ebp),%eax
     727:	83 c0 08             	add    $0x8,%eax
     72a:	83 ec 0c             	sub    $0xc,%esp
     72d:	50                   	push   %eax
     72e:	e8 c8 fe ff ff       	call   5fb <free>
     733:	83 c4 10             	add    $0x10,%esp
  return freep;
     736:	a1 5c 29 00 00       	mov    0x295c,%eax
}
     73b:	c9                   	leave  
     73c:	c3                   	ret    

0000073d <malloc>:

void*
malloc(uint nbytes)
{
     73d:	55                   	push   %ebp
     73e:	89 e5                	mov    %esp,%ebp
     740:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     743:	8b 45 08             	mov    0x8(%ebp),%eax
     746:	83 c0 07             	add    $0x7,%eax
     749:	c1 e8 03             	shr    $0x3,%eax
     74c:	83 c0 01             	add    $0x1,%eax
     74f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     752:	a1 5c 29 00 00       	mov    0x295c,%eax
     757:	89 45 f0             	mov    %eax,-0x10(%ebp)
     75a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     75e:	75 23                	jne    783 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     760:	c7 45 f0 54 29 00 00 	movl   $0x2954,-0x10(%ebp)
     767:	8b 45 f0             	mov    -0x10(%ebp),%eax
     76a:	a3 5c 29 00 00       	mov    %eax,0x295c
     76f:	a1 5c 29 00 00       	mov    0x295c,%eax
     774:	a3 54 29 00 00       	mov    %eax,0x2954
    base.s.size = 0;
     779:	c7 05 58 29 00 00 00 	movl   $0x0,0x2958
     780:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     783:	8b 45 f0             	mov    -0x10(%ebp),%eax
     786:	8b 00                	mov    (%eax),%eax
     788:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     78b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     78e:	8b 40 04             	mov    0x4(%eax),%eax
     791:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     794:	72 4d                	jb     7e3 <malloc+0xa6>
      if(p->s.size == nunits)
     796:	8b 45 f4             	mov    -0xc(%ebp),%eax
     799:	8b 40 04             	mov    0x4(%eax),%eax
     79c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     79f:	75 0c                	jne    7ad <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a4:	8b 10                	mov    (%eax),%edx
     7a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7a9:	89 10                	mov    %edx,(%eax)
     7ab:	eb 26                	jmp    7d3 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b0:	8b 40 04             	mov    0x4(%eax),%eax
     7b3:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7b6:	89 c2                	mov    %eax,%edx
     7b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7bb:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7be:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c1:	8b 40 04             	mov    0x4(%eax),%eax
     7c4:	c1 e0 03             	shl    $0x3,%eax
     7c7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7cd:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7d0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d6:	a3 5c 29 00 00       	mov    %eax,0x295c
      return (void*)(p + 1);
     7db:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7de:	83 c0 08             	add    $0x8,%eax
     7e1:	eb 3b                	jmp    81e <malloc+0xe1>
    }
    if(p == freep)
     7e3:	a1 5c 29 00 00       	mov    0x295c,%eax
     7e8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7eb:	75 1e                	jne    80b <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7ed:	83 ec 0c             	sub    $0xc,%esp
     7f0:	ff 75 ec             	pushl  -0x14(%ebp)
     7f3:	e8 e5 fe ff ff       	call   6dd <morecore>
     7f8:	83 c4 10             	add    $0x10,%esp
     7fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
     7fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     802:	75 07                	jne    80b <malloc+0xce>
        return 0;
     804:	b8 00 00 00 00       	mov    $0x0,%eax
     809:	eb 13                	jmp    81e <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     80b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     811:	8b 45 f4             	mov    -0xc(%ebp),%eax
     814:	8b 00                	mov    (%eax),%eax
     816:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     819:	e9 6d ff ff ff       	jmp    78b <malloc+0x4e>
}
     81e:	c9                   	leave  
     81f:	c3                   	ret    

00000820 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     820:	55                   	push   %ebp
     821:	89 e5                	mov    %esp,%ebp
     823:	83 ec 1c             	sub    $0x1c,%esp
     826:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     829:	8b 55 10             	mov    0x10(%ebp),%edx
     82c:	8b 45 14             	mov    0x14(%ebp),%eax
     82f:	88 4d ec             	mov    %cl,-0x14(%ebp)
     832:	88 55 e8             	mov    %dl,-0x18(%ebp)
     835:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     838:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     83c:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     83f:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     843:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     846:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     84a:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     84d:	8b 45 08             	mov    0x8(%ebp),%eax
     850:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     854:	66 89 10             	mov    %dx,(%eax)
     857:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     85b:	88 50 02             	mov    %dl,0x2(%eax)
}
     85e:	8b 45 08             	mov    0x8(%ebp),%eax
     861:	c9                   	leave  
     862:	c2 04 00             	ret    $0x4

00000865 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     865:	55                   	push   %ebp
     866:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     868:	8b 45 08             	mov    0x8(%ebp),%eax
     86b:	2b 45 10             	sub    0x10(%ebp),%eax
     86e:	89 c2                	mov    %eax,%edx
     870:	8b 45 08             	mov    0x8(%ebp),%eax
     873:	2b 45 10             	sub    0x10(%ebp),%eax
     876:	0f af d0             	imul   %eax,%edx
     879:	8b 45 0c             	mov    0xc(%ebp),%eax
     87c:	2b 45 14             	sub    0x14(%ebp),%eax
     87f:	89 c1                	mov    %eax,%ecx
     881:	8b 45 0c             	mov    0xc(%ebp),%eax
     884:	2b 45 14             	sub    0x14(%ebp),%eax
     887:	0f af c1             	imul   %ecx,%eax
     88a:	01 d0                	add    %edx,%eax
}
     88c:	5d                   	pop    %ebp
     88d:	c3                   	ret    

0000088e <abs_int>:

static inline int abs_int(int x)
{
     88e:	55                   	push   %ebp
     88f:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     891:	8b 45 08             	mov    0x8(%ebp),%eax
     894:	99                   	cltd   
     895:	89 d0                	mov    %edx,%eax
     897:	33 45 08             	xor    0x8(%ebp),%eax
     89a:	29 d0                	sub    %edx,%eax
}
     89c:	5d                   	pop    %ebp
     89d:	c3                   	ret    

0000089e <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     89e:	55                   	push   %ebp
     89f:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     8a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8a5:	79 07                	jns    8ae <APGetIndex+0x10>
        return X_SMALLER;
     8a7:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8ac:	eb 40                	jmp    8ee <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8ae:	8b 45 08             	mov    0x8(%ebp),%eax
     8b1:	8b 00                	mov    (%eax),%eax
     8b3:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8b6:	7f 07                	jg     8bf <APGetIndex+0x21>
        return X_BIGGER;
     8b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8bd:	eb 2f                	jmp    8ee <APGetIndex+0x50>
    if (y < 0)
     8bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8c3:	79 07                	jns    8cc <APGetIndex+0x2e>
        return Y_SMALLER;
     8c5:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8ca:	eb 22                	jmp    8ee <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8cc:	8b 45 08             	mov    0x8(%ebp),%eax
     8cf:	8b 40 04             	mov    0x4(%eax),%eax
     8d2:	3b 45 10             	cmp    0x10(%ebp),%eax
     8d5:	7f 07                	jg     8de <APGetIndex+0x40>
        return Y_BIGGER;
     8d7:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8dc:	eb 10                	jmp    8ee <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8de:	8b 45 08             	mov    0x8(%ebp),%eax
     8e1:	8b 00                	mov    (%eax),%eax
     8e3:	0f af 45 10          	imul   0x10(%ebp),%eax
     8e7:	89 c2                	mov    %eax,%edx
     8e9:	8b 45 0c             	mov    0xc(%ebp),%eax
     8ec:	01 d0                	add    %edx,%eax
}
     8ee:	5d                   	pop    %ebp
     8ef:	c3                   	ret    

000008f0 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     8f0:	55                   	push   %ebp
     8f1:	89 e5                	mov    %esp,%ebp
     8f3:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     8f6:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     8fd:	8b 45 cc             	mov    -0x34(%ebp),%eax
     900:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     903:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     90a:	83 ec 08             	sub    $0x8,%esp
     90d:	6a 00                	push   $0x0
     90f:	ff 75 0c             	pushl  0xc(%ebp)
     912:	e8 f4 f9 ff ff       	call   30b <open>
     917:	83 c4 10             	add    $0x10,%esp
     91a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     91d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     921:	79 2e                	jns    951 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     923:	83 ec 04             	sub    $0x4,%esp
     926:	ff 75 0c             	pushl  0xc(%ebp)
     929:	68 5a 22 00 00       	push   $0x225a
     92e:	6a 01                	push   $0x1
     930:	e8 35 fb ff ff       	call   46a <printf>
     935:	83 c4 10             	add    $0x10,%esp
        return bmp;
     938:	8b 45 08             	mov    0x8(%ebp),%eax
     93b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     93e:	89 10                	mov    %edx,(%eax)
     940:	8b 55 cc             	mov    -0x34(%ebp),%edx
     943:	89 50 04             	mov    %edx,0x4(%eax)
     946:	8b 55 d0             	mov    -0x30(%ebp),%edx
     949:	89 50 08             	mov    %edx,0x8(%eax)
     94c:	e9 d2 01 00 00       	jmp    b23 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     951:	83 ec 04             	sub    $0x4,%esp
     954:	6a 0e                	push   $0xe
     956:	8d 45 ba             	lea    -0x46(%ebp),%eax
     959:	50                   	push   %eax
     95a:	ff 75 ec             	pushl  -0x14(%ebp)
     95d:	e8 81 f9 ff ff       	call   2e3 <read>
     962:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     965:	83 ec 04             	sub    $0x4,%esp
     968:	6a 28                	push   $0x28
     96a:	8d 45 92             	lea    -0x6e(%ebp),%eax
     96d:	50                   	push   %eax
     96e:	ff 75 ec             	pushl  -0x14(%ebp)
     971:	e8 6d f9 ff ff       	call   2e3 <read>
     976:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     979:	8b 45 96             	mov    -0x6a(%ebp),%eax
     97c:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     97f:	8b 45 9a             	mov    -0x66(%ebp),%eax
     982:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     985:	8b 55 c8             	mov    -0x38(%ebp),%edx
     988:	8b 45 cc             	mov    -0x34(%ebp),%eax
     98b:	0f af d0             	imul   %eax,%edx
     98e:	89 d0                	mov    %edx,%eax
     990:	01 c0                	add    %eax,%eax
     992:	01 d0                	add    %edx,%eax
     994:	83 ec 0c             	sub    $0xc,%esp
     997:	50                   	push   %eax
     998:	e8 a0 fd ff ff       	call   73d <malloc>
     99d:	83 c4 10             	add    $0x10,%esp
     9a0:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9a3:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9a7:	0f b7 c0             	movzwl %ax,%eax
     9aa:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9ad:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9b3:	0f af c2             	imul   %edx,%eax
     9b6:	83 c0 1f             	add    $0x1f,%eax
     9b9:	c1 e8 05             	shr    $0x5,%eax
     9bc:	c1 e0 02             	shl    $0x2,%eax
     9bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9c2:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9c8:	0f af c2             	imul   %edx,%eax
     9cb:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9d1:	83 ec 0c             	sub    $0xc,%esp
     9d4:	50                   	push   %eax
     9d5:	e8 63 fd ff ff       	call   73d <malloc>
     9da:	83 c4 10             	add    $0x10,%esp
     9dd:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9e0:	83 ec 04             	sub    $0x4,%esp
     9e3:	ff 75 e0             	pushl  -0x20(%ebp)
     9e6:	ff 75 dc             	pushl  -0x24(%ebp)
     9e9:	ff 75 ec             	pushl  -0x14(%ebp)
     9ec:	e8 f2 f8 ff ff       	call   2e3 <read>
     9f1:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     9f4:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9f8:	66 c1 e8 03          	shr    $0x3,%ax
     9fc:	0f b7 c0             	movzwl %ax,%eax
     9ff:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a09:	e9 e5 00 00 00       	jmp    af3 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a0e:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a11:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a14:	29 c2                	sub    %eax,%edx
     a16:	89 d0                	mov    %edx,%eax
     a18:	8d 50 ff             	lea    -0x1(%eax),%edx
     a1b:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a1e:	0f af c2             	imul   %edx,%eax
     a21:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a24:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a2b:	e9 b1 00 00 00       	jmp    ae1 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a30:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a33:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a36:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a39:	01 c8                	add    %ecx,%eax
     a3b:	89 c1                	mov    %eax,%ecx
     a3d:	89 c8                	mov    %ecx,%eax
     a3f:	01 c0                	add    %eax,%eax
     a41:	01 c8                	add    %ecx,%eax
     a43:	01 c2                	add    %eax,%edx
     a45:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a48:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a4c:	89 c1                	mov    %eax,%ecx
     a4e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a51:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a55:	01 c1                	add    %eax,%ecx
     a57:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a5a:	01 c8                	add    %ecx,%eax
     a5c:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a5f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a62:	01 c8                	add    %ecx,%eax
     a64:	0f b6 00             	movzbl (%eax),%eax
     a67:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a6a:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a6d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a70:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a73:	01 c8                	add    %ecx,%eax
     a75:	89 c1                	mov    %eax,%ecx
     a77:	89 c8                	mov    %ecx,%eax
     a79:	01 c0                	add    %eax,%eax
     a7b:	01 c8                	add    %ecx,%eax
     a7d:	01 c2                	add    %eax,%edx
     a7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a82:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a86:	89 c1                	mov    %eax,%ecx
     a88:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a8b:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a8f:	01 c1                	add    %eax,%ecx
     a91:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a94:	01 c8                	add    %ecx,%eax
     a96:	8d 48 fe             	lea    -0x2(%eax),%ecx
     a99:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a9c:	01 c8                	add    %ecx,%eax
     a9e:	0f b6 00             	movzbl (%eax),%eax
     aa1:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     aa4:	8b 55 d0             	mov    -0x30(%ebp),%edx
     aa7:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     aaa:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aad:	01 c8                	add    %ecx,%eax
     aaf:	89 c1                	mov    %eax,%ecx
     ab1:	89 c8                	mov    %ecx,%eax
     ab3:	01 c0                	add    %eax,%eax
     ab5:	01 c8                	add    %ecx,%eax
     ab7:	01 c2                	add    %eax,%edx
     ab9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     abc:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ac0:	89 c1                	mov    %eax,%ecx
     ac2:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ac5:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ac9:	01 c1                	add    %eax,%ecx
     acb:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ace:	01 c8                	add    %ecx,%eax
     ad0:	8d 48 fd             	lea    -0x3(%eax),%ecx
     ad3:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ad6:	01 c8                	add    %ecx,%eax
     ad8:	0f b6 00             	movzbl (%eax),%eax
     adb:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     add:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ae1:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ae4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ae7:	39 c2                	cmp    %eax,%edx
     ae9:	0f 87 41 ff ff ff    	ja     a30 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     aef:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     af3:	8b 55 cc             	mov    -0x34(%ebp),%edx
     af6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af9:	39 c2                	cmp    %eax,%edx
     afb:	0f 87 0d ff ff ff    	ja     a0e <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b01:	83 ec 0c             	sub    $0xc,%esp
     b04:	ff 75 ec             	pushl  -0x14(%ebp)
     b07:	e8 e7 f7 ff ff       	call   2f3 <close>
     b0c:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b0f:	8b 45 08             	mov    0x8(%ebp),%eax
     b12:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b15:	89 10                	mov    %edx,(%eax)
     b17:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b1a:	89 50 04             	mov    %edx,0x4(%eax)
     b1d:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b20:	89 50 08             	mov    %edx,0x8(%eax)
}
     b23:	8b 45 08             	mov    0x8(%ebp),%eax
     b26:	c9                   	leave  
     b27:	c2 04 00             	ret    $0x4

00000b2a <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b2a:	55                   	push   %ebp
     b2b:	89 e5                	mov    %esp,%ebp
     b2d:	53                   	push   %ebx
     b2e:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b31:	83 ec 0c             	sub    $0xc,%esp
     b34:	6a 1c                	push   $0x1c
     b36:	e8 02 fc ff ff       	call   73d <malloc>
     b3b:	83 c4 10             	add    $0x10,%esp
     b3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b41:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b44:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b4b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b4e:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b51:	6a 0c                	push   $0xc
     b53:	6a 0c                	push   $0xc
     b55:	6a 0c                	push   $0xc
     b57:	50                   	push   %eax
     b58:	e8 c3 fc ff ff       	call   820 <RGB>
     b5d:	83 c4 0c             	add    $0xc,%esp
     b60:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b64:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b68:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b6c:	88 43 15             	mov    %al,0x15(%ebx)
     b6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b72:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b75:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b79:	66 89 48 10          	mov    %cx,0x10(%eax)
     b7d:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b81:	88 50 12             	mov    %dl,0x12(%eax)
     b84:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b87:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b8a:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     b8e:	66 89 48 08          	mov    %cx,0x8(%eax)
     b92:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     b96:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     b99:	8b 45 08             	mov    0x8(%ebp),%eax
     b9c:	89 c2                	mov    %eax,%edx
     b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba1:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     ba3:	8b 45 0c             	mov    0xc(%ebp),%eax
     ba6:	89 c2                	mov    %eax,%edx
     ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bab:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bae:	8b 55 10             	mov    0x10(%ebp),%edx
     bb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb4:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     bb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bbd:	c9                   	leave  
     bbe:	c3                   	ret    

00000bbf <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     bbf:	55                   	push   %ebp
     bc0:	89 e5                	mov    %esp,%ebp
     bc2:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     bc5:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc8:	8b 50 08             	mov    0x8(%eax),%edx
     bcb:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bce:	8b 40 0c             	mov    0xc(%eax),%eax
     bd1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     bd4:	8b 45 0c             	mov    0xc(%ebp),%eax
     bd7:	8b 55 10             	mov    0x10(%ebp),%edx
     bda:	89 50 08             	mov    %edx,0x8(%eax)
     bdd:	8b 55 14             	mov    0x14(%ebp),%edx
     be0:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     be3:	8b 45 08             	mov    0x8(%ebp),%eax
     be6:	8b 55 f8             	mov    -0x8(%ebp),%edx
     be9:	89 10                	mov    %edx,(%eax)
     beb:	8b 55 fc             	mov    -0x4(%ebp),%edx
     bee:	89 50 04             	mov    %edx,0x4(%eax)
}
     bf1:	8b 45 08             	mov    0x8(%ebp),%eax
     bf4:	c9                   	leave  
     bf5:	c2 04 00             	ret    $0x4

00000bf8 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     bf8:	55                   	push   %ebp
     bf9:	89 e5                	mov    %esp,%ebp
     bfb:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     bfe:	8b 45 0c             	mov    0xc(%ebp),%eax
     c01:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c05:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c09:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c0d:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c10:	8b 45 0c             	mov    0xc(%ebp),%eax
     c13:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c17:	66 89 50 10          	mov    %dx,0x10(%eax)
     c1b:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c1f:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c22:	8b 45 08             	mov    0x8(%ebp),%eax
     c25:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c29:	66 89 10             	mov    %dx,(%eax)
     c2c:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c30:	88 50 02             	mov    %dl,0x2(%eax)
}
     c33:	8b 45 08             	mov    0x8(%ebp),%eax
     c36:	c9                   	leave  
     c37:	c2 04 00             	ret    $0x4

00000c3a <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c3a:	55                   	push   %ebp
     c3b:	89 e5                	mov    %esp,%ebp
     c3d:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c40:	8b 45 08             	mov    0x8(%ebp),%eax
     c43:	8b 40 0c             	mov    0xc(%eax),%eax
     c46:	89 c2                	mov    %eax,%edx
     c48:	c1 ea 1f             	shr    $0x1f,%edx
     c4b:	01 d0                	add    %edx,%eax
     c4d:	d1 f8                	sar    %eax
     c4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c52:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c55:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c59:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c5c:	8b 45 10             	mov    0x10(%ebp),%eax
     c5f:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c62:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c65:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c69:	0f 89 98 00 00 00    	jns    d07 <APDrawPoint+0xcd>
        i = 0;
     c6f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c76:	e9 8c 00 00 00       	jmp    d07 <APDrawPoint+0xcd>
    {
        j = x - off;
     c7b:	8b 45 0c             	mov    0xc(%ebp),%eax
     c7e:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c81:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     c84:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     c88:	79 69                	jns    cf3 <APDrawPoint+0xb9>
            j = 0;
     c8a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     c91:	eb 60                	jmp    cf3 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     c93:	ff 75 fc             	pushl  -0x4(%ebp)
     c96:	ff 75 f8             	pushl  -0x8(%ebp)
     c99:	ff 75 08             	pushl  0x8(%ebp)
     c9c:	e8 fd fb ff ff       	call   89e <APGetIndex>
     ca1:	83 c4 0c             	add    $0xc,%esp
     ca4:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     ca7:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cab:	74 55                	je     d02 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cad:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     cb1:	74 67                	je     d1a <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     cb3:	ff 75 10             	pushl  0x10(%ebp)
     cb6:	ff 75 0c             	pushl  0xc(%ebp)
     cb9:	ff 75 fc             	pushl  -0x4(%ebp)
     cbc:	ff 75 f8             	pushl  -0x8(%ebp)
     cbf:	e8 a1 fb ff ff       	call   865 <distance_2>
     cc4:	83 c4 10             	add    $0x10,%esp
     cc7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     cca:	7f 23                	jg     cef <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     ccc:	8b 45 08             	mov    0x8(%ebp),%eax
     ccf:	8b 48 18             	mov    0x18(%eax),%ecx
     cd2:	8b 55 ec             	mov    -0x14(%ebp),%edx
     cd5:	89 d0                	mov    %edx,%eax
     cd7:	01 c0                	add    %eax,%eax
     cd9:	01 d0                	add    %edx,%eax
     cdb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     cde:	8b 45 08             	mov    0x8(%ebp),%eax
     ce1:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     ce5:	66 89 0a             	mov    %cx,(%edx)
     ce8:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     cec:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     cef:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     cf3:	8b 55 0c             	mov    0xc(%ebp),%edx
     cf6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf9:	01 d0                	add    %edx,%eax
     cfb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     cfe:	7d 93                	jge    c93 <APDrawPoint+0x59>
     d00:	eb 01                	jmp    d03 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d02:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d03:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d07:	8b 55 10             	mov    0x10(%ebp),%edx
     d0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d0d:	01 d0                	add    %edx,%eax
     d0f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d12:	0f 8d 63 ff ff ff    	jge    c7b <APDrawPoint+0x41>
     d18:	eb 01                	jmp    d1b <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d1a:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d1b:	c9                   	leave  
     d1c:	c3                   	ret    

00000d1d <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d1d:	55                   	push   %ebp
     d1e:	89 e5                	mov    %esp,%ebp
     d20:	53                   	push   %ebx
     d21:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d24:	8b 45 0c             	mov    0xc(%ebp),%eax
     d27:	3b 45 14             	cmp    0x14(%ebp),%eax
     d2a:	0f 85 80 00 00 00    	jne    db0 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d30:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d34:	0f 88 9d 02 00 00    	js     fd7 <APDrawLine+0x2ba>
     d3a:	8b 45 08             	mov    0x8(%ebp),%eax
     d3d:	8b 00                	mov    (%eax),%eax
     d3f:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d42:	0f 8e 8f 02 00 00    	jle    fd7 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d48:	8b 45 10             	mov    0x10(%ebp),%eax
     d4b:	3b 45 18             	cmp    0x18(%ebp),%eax
     d4e:	7e 12                	jle    d62 <APDrawLine+0x45>
        {
            int tmp = y2;
     d50:	8b 45 18             	mov    0x18(%ebp),%eax
     d53:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d56:	8b 45 10             	mov    0x10(%ebp),%eax
     d59:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d5c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d5f:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d62:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d66:	79 07                	jns    d6f <APDrawLine+0x52>
     d68:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d6f:	8b 45 08             	mov    0x8(%ebp),%eax
     d72:	8b 40 04             	mov    0x4(%eax),%eax
     d75:	3b 45 18             	cmp    0x18(%ebp),%eax
     d78:	7d 0c                	jge    d86 <APDrawLine+0x69>
     d7a:	8b 45 08             	mov    0x8(%ebp),%eax
     d7d:	8b 40 04             	mov    0x4(%eax),%eax
     d80:	83 e8 01             	sub    $0x1,%eax
     d83:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     d86:	8b 45 10             	mov    0x10(%ebp),%eax
     d89:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d8c:	eb 15                	jmp    da3 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     d8e:	ff 75 f4             	pushl  -0xc(%ebp)
     d91:	ff 75 0c             	pushl  0xc(%ebp)
     d94:	ff 75 08             	pushl  0x8(%ebp)
     d97:	e8 9e fe ff ff       	call   c3a <APDrawPoint>
     d9c:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     d9f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     da3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da6:	3b 45 18             	cmp    0x18(%ebp),%eax
     da9:	7e e3                	jle    d8e <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     dab:	e9 2b 02 00 00       	jmp    fdb <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     db0:	8b 45 10             	mov    0x10(%ebp),%eax
     db3:	3b 45 18             	cmp    0x18(%ebp),%eax
     db6:	75 7f                	jne    e37 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     db8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dbc:	0f 88 18 02 00 00    	js     fda <APDrawLine+0x2bd>
     dc2:	8b 45 08             	mov    0x8(%ebp),%eax
     dc5:	8b 40 04             	mov    0x4(%eax),%eax
     dc8:	3b 45 10             	cmp    0x10(%ebp),%eax
     dcb:	0f 8e 09 02 00 00    	jle    fda <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     dd1:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd4:	3b 45 14             	cmp    0x14(%ebp),%eax
     dd7:	7e 12                	jle    deb <APDrawLine+0xce>
        {
            int tmp = x2;
     dd9:	8b 45 14             	mov    0x14(%ebp),%eax
     ddc:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     ddf:	8b 45 0c             	mov    0xc(%ebp),%eax
     de2:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     de5:	8b 45 d8             	mov    -0x28(%ebp),%eax
     de8:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     deb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     def:	79 07                	jns    df8 <APDrawLine+0xdb>
     df1:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     df8:	8b 45 08             	mov    0x8(%ebp),%eax
     dfb:	8b 00                	mov    (%eax),%eax
     dfd:	3b 45 14             	cmp    0x14(%ebp),%eax
     e00:	7d 0b                	jge    e0d <APDrawLine+0xf0>
     e02:	8b 45 08             	mov    0x8(%ebp),%eax
     e05:	8b 00                	mov    (%eax),%eax
     e07:	83 e8 01             	sub    $0x1,%eax
     e0a:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e0d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e10:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e13:	eb 15                	jmp    e2a <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e15:	ff 75 10             	pushl  0x10(%ebp)
     e18:	ff 75 f0             	pushl  -0x10(%ebp)
     e1b:	ff 75 08             	pushl  0x8(%ebp)
     e1e:	e8 17 fe ff ff       	call   c3a <APDrawPoint>
     e23:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e26:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e2d:	3b 45 14             	cmp    0x14(%ebp),%eax
     e30:	7e e3                	jle    e15 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e32:	e9 a4 01 00 00       	jmp    fdb <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e37:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e3e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e45:	8b 45 0c             	mov    0xc(%ebp),%eax
     e48:	2b 45 14             	sub    0x14(%ebp),%eax
     e4b:	50                   	push   %eax
     e4c:	e8 3d fa ff ff       	call   88e <abs_int>
     e51:	83 c4 04             	add    $0x4,%esp
     e54:	89 c3                	mov    %eax,%ebx
     e56:	8b 45 10             	mov    0x10(%ebp),%eax
     e59:	2b 45 18             	sub    0x18(%ebp),%eax
     e5c:	50                   	push   %eax
     e5d:	e8 2c fa ff ff       	call   88e <abs_int>
     e62:	83 c4 04             	add    $0x4,%esp
     e65:	39 c3                	cmp    %eax,%ebx
     e67:	0f 8e b5 00 00 00    	jle    f22 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e6d:	8b 45 10             	mov    0x10(%ebp),%eax
     e70:	2b 45 18             	sub    0x18(%ebp),%eax
     e73:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e76:	db 45 b0             	fildl  -0x50(%ebp)
     e79:	8b 45 0c             	mov    0xc(%ebp),%eax
     e7c:	2b 45 14             	sub    0x14(%ebp),%eax
     e7f:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e82:	db 45 b0             	fildl  -0x50(%ebp)
     e85:	de f9                	fdivrp %st,%st(1)
     e87:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     e8a:	8b 45 14             	mov    0x14(%ebp),%eax
     e8d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e90:	7e 0e                	jle    ea0 <APDrawLine+0x183>
        {
            s = x1;
     e92:	8b 45 0c             	mov    0xc(%ebp),%eax
     e95:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     e98:	8b 45 14             	mov    0x14(%ebp),%eax
     e9b:	89 45 e8             	mov    %eax,-0x18(%ebp)
     e9e:	eb 0c                	jmp    eac <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ea0:	8b 45 14             	mov    0x14(%ebp),%eax
     ea3:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     ea6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea9:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     eac:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     eb0:	79 07                	jns    eb9 <APDrawLine+0x19c>
     eb2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     eb9:	8b 45 08             	mov    0x8(%ebp),%eax
     ebc:	8b 00                	mov    (%eax),%eax
     ebe:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ec1:	7f 0b                	jg     ece <APDrawLine+0x1b1>
     ec3:	8b 45 08             	mov    0x8(%ebp),%eax
     ec6:	8b 00                	mov    (%eax),%eax
     ec8:	83 e8 01             	sub    $0x1,%eax
     ecb:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     ece:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ed1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     ed4:	eb 3f                	jmp    f15 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     ed6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ed9:	2b 45 0c             	sub    0xc(%ebp),%eax
     edc:	89 45 b0             	mov    %eax,-0x50(%ebp)
     edf:	db 45 b0             	fildl  -0x50(%ebp)
     ee2:	dc 4d d0             	fmull  -0x30(%ebp)
     ee5:	db 45 10             	fildl  0x10(%ebp)
     ee8:	de c1                	faddp  %st,%st(1)
     eea:	d9 7d b6             	fnstcw -0x4a(%ebp)
     eed:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     ef1:	b4 0c                	mov    $0xc,%ah
     ef3:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     ef7:	d9 6d b4             	fldcw  -0x4c(%ebp)
     efa:	db 5d cc             	fistpl -0x34(%ebp)
     efd:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f00:	ff 75 cc             	pushl  -0x34(%ebp)
     f03:	ff 75 e4             	pushl  -0x1c(%ebp)
     f06:	ff 75 08             	pushl  0x8(%ebp)
     f09:	e8 2c fd ff ff       	call   c3a <APDrawPoint>
     f0e:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f11:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f15:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f18:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f1b:	7e b9                	jle    ed6 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f1d:	e9 b9 00 00 00       	jmp    fdb <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f22:	8b 45 0c             	mov    0xc(%ebp),%eax
     f25:	2b 45 14             	sub    0x14(%ebp),%eax
     f28:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f2b:	db 45 b0             	fildl  -0x50(%ebp)
     f2e:	8b 45 10             	mov    0x10(%ebp),%eax
     f31:	2b 45 18             	sub    0x18(%ebp),%eax
     f34:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f37:	db 45 b0             	fildl  -0x50(%ebp)
     f3a:	de f9                	fdivrp %st,%st(1)
     f3c:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f3f:	8b 45 10             	mov    0x10(%ebp),%eax
     f42:	3b 45 18             	cmp    0x18(%ebp),%eax
     f45:	7e 0e                	jle    f55 <APDrawLine+0x238>
    {
        s = y2;
     f47:	8b 45 18             	mov    0x18(%ebp),%eax
     f4a:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f4d:	8b 45 10             	mov    0x10(%ebp),%eax
     f50:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f53:	eb 0c                	jmp    f61 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f55:	8b 45 10             	mov    0x10(%ebp),%eax
     f58:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f5b:	8b 45 18             	mov    0x18(%ebp),%eax
     f5e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f61:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f65:	79 07                	jns    f6e <APDrawLine+0x251>
     f67:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f6e:	8b 45 08             	mov    0x8(%ebp),%eax
     f71:	8b 40 04             	mov    0x4(%eax),%eax
     f74:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f77:	7f 0c                	jg     f85 <APDrawLine+0x268>
     f79:	8b 45 08             	mov    0x8(%ebp),%eax
     f7c:	8b 40 04             	mov    0x4(%eax),%eax
     f7f:	83 e8 01             	sub    $0x1,%eax
     f82:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     f85:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f88:	89 45 e0             	mov    %eax,-0x20(%ebp)
     f8b:	eb 3f                	jmp    fcc <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     f8d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f90:	2b 45 10             	sub    0x10(%ebp),%eax
     f93:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f96:	db 45 b0             	fildl  -0x50(%ebp)
     f99:	dc 4d c0             	fmull  -0x40(%ebp)
     f9c:	db 45 0c             	fildl  0xc(%ebp)
     f9f:	de c1                	faddp  %st,%st(1)
     fa1:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fa4:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fa8:	b4 0c                	mov    $0xc,%ah
     faa:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fae:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fb1:	db 5d bc             	fistpl -0x44(%ebp)
     fb4:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     fb7:	ff 75 e0             	pushl  -0x20(%ebp)
     fba:	ff 75 bc             	pushl  -0x44(%ebp)
     fbd:	ff 75 08             	pushl  0x8(%ebp)
     fc0:	e8 75 fc ff ff       	call   c3a <APDrawPoint>
     fc5:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     fc8:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     fcc:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fcf:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fd2:	7e b9                	jle    f8d <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     fd4:	90                   	nop
     fd5:	eb 04                	jmp    fdb <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     fd7:	90                   	nop
     fd8:	eb 01                	jmp    fdb <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     fda:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     fdb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fde:	c9                   	leave  
     fdf:	c3                   	ret    

00000fe0 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	53                   	push   %ebx
     fe4:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
     fe7:	8b 55 10             	mov    0x10(%ebp),%edx
     fea:	8b 45 18             	mov    0x18(%ebp),%eax
     fed:	01 d0                	add    %edx,%eax
     fef:	83 e8 01             	sub    $0x1,%eax
     ff2:	83 ec 04             	sub    $0x4,%esp
     ff5:	50                   	push   %eax
     ff6:	ff 75 0c             	pushl  0xc(%ebp)
     ff9:	ff 75 10             	pushl  0x10(%ebp)
     ffc:	ff 75 0c             	pushl  0xc(%ebp)
     fff:	ff 75 08             	pushl  0x8(%ebp)
    1002:	e8 16 fd ff ff       	call   d1d <APDrawLine>
    1007:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    100a:	8b 55 0c             	mov    0xc(%ebp),%edx
    100d:	8b 45 14             	mov    0x14(%ebp),%eax
    1010:	01 d0                	add    %edx,%eax
    1012:	83 e8 01             	sub    $0x1,%eax
    1015:	83 ec 04             	sub    $0x4,%esp
    1018:	ff 75 10             	pushl  0x10(%ebp)
    101b:	50                   	push   %eax
    101c:	ff 75 10             	pushl  0x10(%ebp)
    101f:	ff 75 0c             	pushl  0xc(%ebp)
    1022:	ff 75 08             	pushl  0x8(%ebp)
    1025:	e8 f3 fc ff ff       	call   d1d <APDrawLine>
    102a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    102d:	8b 55 10             	mov    0x10(%ebp),%edx
    1030:	8b 45 18             	mov    0x18(%ebp),%eax
    1033:	01 d0                	add    %edx,%eax
    1035:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1038:	8b 55 0c             	mov    0xc(%ebp),%edx
    103b:	8b 45 14             	mov    0x14(%ebp),%eax
    103e:	01 d0                	add    %edx,%eax
    1040:	8d 50 ff             	lea    -0x1(%eax),%edx
    1043:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1046:	8b 45 14             	mov    0x14(%ebp),%eax
    1049:	01 d8                	add    %ebx,%eax
    104b:	83 e8 01             	sub    $0x1,%eax
    104e:	83 ec 04             	sub    $0x4,%esp
    1051:	51                   	push   %ecx
    1052:	52                   	push   %edx
    1053:	ff 75 10             	pushl  0x10(%ebp)
    1056:	50                   	push   %eax
    1057:	ff 75 08             	pushl  0x8(%ebp)
    105a:	e8 be fc ff ff       	call   d1d <APDrawLine>
    105f:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1062:	8b 55 10             	mov    0x10(%ebp),%edx
    1065:	8b 45 18             	mov    0x18(%ebp),%eax
    1068:	01 d0                	add    %edx,%eax
    106a:	8d 48 ff             	lea    -0x1(%eax),%ecx
    106d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1070:	8b 45 14             	mov    0x14(%ebp),%eax
    1073:	01 d0                	add    %edx,%eax
    1075:	8d 50 ff             	lea    -0x1(%eax),%edx
    1078:	8b 5d 10             	mov    0x10(%ebp),%ebx
    107b:	8b 45 18             	mov    0x18(%ebp),%eax
    107e:	01 d8                	add    %ebx,%eax
    1080:	83 e8 01             	sub    $0x1,%eax
    1083:	83 ec 04             	sub    $0x4,%esp
    1086:	51                   	push   %ecx
    1087:	52                   	push   %edx
    1088:	50                   	push   %eax
    1089:	ff 75 0c             	pushl  0xc(%ebp)
    108c:	ff 75 08             	pushl  0x8(%ebp)
    108f:	e8 89 fc ff ff       	call   d1d <APDrawLine>
    1094:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1097:	8b 55 0c             	mov    0xc(%ebp),%edx
    109a:	8b 45 14             	mov    0x14(%ebp),%eax
    109d:	01 d0                	add    %edx,%eax
    109f:	8d 50 ff             	lea    -0x1(%eax),%edx
    10a2:	8b 45 08             	mov    0x8(%ebp),%eax
    10a5:	8b 40 0c             	mov    0xc(%eax),%eax
    10a8:	89 c1                	mov    %eax,%ecx
    10aa:	c1 e9 1f             	shr    $0x1f,%ecx
    10ad:	01 c8                	add    %ecx,%eax
    10af:	d1 f8                	sar    %eax
    10b1:	29 c2                	sub    %eax,%edx
    10b3:	89 d0                	mov    %edx,%eax
    10b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10b8:	8b 55 10             	mov    0x10(%ebp),%edx
    10bb:	8b 45 18             	mov    0x18(%ebp),%eax
    10be:	01 d0                	add    %edx,%eax
    10c0:	8d 50 ff             	lea    -0x1(%eax),%edx
    10c3:	8b 45 08             	mov    0x8(%ebp),%eax
    10c6:	8b 40 0c             	mov    0xc(%eax),%eax
    10c9:	89 c1                	mov    %eax,%ecx
    10cb:	c1 e9 1f             	shr    $0x1f,%ecx
    10ce:	01 c8                	add    %ecx,%eax
    10d0:	d1 f8                	sar    %eax
    10d2:	29 c2                	sub    %eax,%edx
    10d4:	89 d0                	mov    %edx,%eax
    10d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    10d9:	8b 45 08             	mov    0x8(%ebp),%eax
    10dc:	8b 40 0c             	mov    0xc(%eax),%eax
    10df:	89 c2                	mov    %eax,%edx
    10e1:	c1 ea 1f             	shr    $0x1f,%edx
    10e4:	01 d0                	add    %edx,%eax
    10e6:	d1 f8                	sar    %eax
    10e8:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    10eb:	8b 45 08             	mov    0x8(%ebp),%eax
    10ee:	8b 40 0c             	mov    0xc(%eax),%eax
    10f1:	89 c2                	mov    %eax,%edx
    10f3:	c1 ea 1f             	shr    $0x1f,%edx
    10f6:	01 d0                	add    %edx,%eax
    10f8:	d1 f8                	sar    %eax
    10fa:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    10fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1101:	0f 88 d8 00 00 00    	js     11df <APDrawRect+0x1ff>
    1107:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    110b:	0f 88 ce 00 00 00    	js     11df <APDrawRect+0x1ff>
    1111:	8b 45 08             	mov    0x8(%ebp),%eax
    1114:	8b 00                	mov    (%eax),%eax
    1116:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1119:	0f 8e c0 00 00 00    	jle    11df <APDrawRect+0x1ff>
    111f:	8b 45 08             	mov    0x8(%ebp),%eax
    1122:	8b 40 04             	mov    0x4(%eax),%eax
    1125:	3b 45 10             	cmp    0x10(%ebp),%eax
    1128:	0f 8e b1 00 00 00    	jle    11df <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    112e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1132:	79 07                	jns    113b <APDrawRect+0x15b>
    1134:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    113b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    113f:	79 07                	jns    1148 <APDrawRect+0x168>
    1141:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1148:	8b 45 08             	mov    0x8(%ebp),%eax
    114b:	8b 00                	mov    (%eax),%eax
    114d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1150:	7f 0b                	jg     115d <APDrawRect+0x17d>
    1152:	8b 45 08             	mov    0x8(%ebp),%eax
    1155:	8b 00                	mov    (%eax),%eax
    1157:	83 e8 01             	sub    $0x1,%eax
    115a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    115d:	8b 45 08             	mov    0x8(%ebp),%eax
    1160:	8b 40 04             	mov    0x4(%eax),%eax
    1163:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1166:	7f 0c                	jg     1174 <APDrawRect+0x194>
    1168:	8b 45 08             	mov    0x8(%ebp),%eax
    116b:	8b 40 04             	mov    0x4(%eax),%eax
    116e:	83 e8 01             	sub    $0x1,%eax
    1171:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1174:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    117b:	8b 45 0c             	mov    0xc(%ebp),%eax
    117e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1181:	eb 52                	jmp    11d5 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1183:	8b 45 10             	mov    0x10(%ebp),%eax
    1186:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1189:	eb 3e                	jmp    11c9 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    118b:	83 ec 04             	sub    $0x4,%esp
    118e:	ff 75 e8             	pushl  -0x18(%ebp)
    1191:	ff 75 ec             	pushl  -0x14(%ebp)
    1194:	ff 75 08             	pushl  0x8(%ebp)
    1197:	e8 02 f7 ff ff       	call   89e <APGetIndex>
    119c:	83 c4 10             	add    $0x10,%esp
    119f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11a2:	8b 45 08             	mov    0x8(%ebp),%eax
    11a5:	8b 48 18             	mov    0x18(%eax),%ecx
    11a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11ab:	89 d0                	mov    %edx,%eax
    11ad:	01 c0                	add    %eax,%eax
    11af:	01 d0                	add    %edx,%eax
    11b1:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11b4:	8b 45 08             	mov    0x8(%ebp),%eax
    11b7:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11bb:	66 89 0a             	mov    %cx,(%edx)
    11be:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    11c2:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    11c5:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11cc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11cf:	7e ba                	jle    118b <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11d1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    11d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11d8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11db:	7e a6                	jle    1183 <APDrawRect+0x1a3>
    11dd:	eb 01                	jmp    11e0 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    11df:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    11e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11e3:	c9                   	leave  
    11e4:	c3                   	ret    

000011e5 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    11e5:	55                   	push   %ebp
    11e6:	89 e5                	mov    %esp,%ebp
}
    11e8:	90                   	nop
    11e9:	5d                   	pop    %ebp
    11ea:	c3                   	ret    

000011eb <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    11eb:	55                   	push   %ebp
    11ec:	89 e5                	mov    %esp,%ebp
    11ee:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    11f1:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    11f5:	0f 88 8e 01 00 00    	js     1389 <APDcCopy+0x19e>
    11fb:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    11ff:	0f 88 84 01 00 00    	js     1389 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1205:	8b 55 0c             	mov    0xc(%ebp),%edx
    1208:	8b 45 20             	mov    0x20(%ebp),%eax
    120b:	01 d0                	add    %edx,%eax
    120d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1210:	8b 55 10             	mov    0x10(%ebp),%edx
    1213:	8b 45 24             	mov    0x24(%ebp),%eax
    1216:	01 d0                	add    %edx,%eax
    1218:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    121b:	8b 55 18             	mov    0x18(%ebp),%edx
    121e:	8b 45 20             	mov    0x20(%ebp),%eax
    1221:	01 d0                	add    %edx,%eax
    1223:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1226:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1229:	8b 45 24             	mov    0x24(%ebp),%eax
    122c:	01 d0                	add    %edx,%eax
    122e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1231:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1235:	0f 88 51 01 00 00    	js     138c <APDcCopy+0x1a1>
    123b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    123f:	0f 88 47 01 00 00    	js     138c <APDcCopy+0x1a1>
    1245:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1249:	0f 88 3d 01 00 00    	js     138c <APDcCopy+0x1a1>
    124f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1253:	0f 88 33 01 00 00    	js     138c <APDcCopy+0x1a1>
    1259:	8b 45 14             	mov    0x14(%ebp),%eax
    125c:	8b 00                	mov    (%eax),%eax
    125e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1261:	0f 8c 25 01 00 00    	jl     138c <APDcCopy+0x1a1>
    1267:	8b 45 14             	mov    0x14(%ebp),%eax
    126a:	8b 40 04             	mov    0x4(%eax),%eax
    126d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1270:	0f 8c 16 01 00 00    	jl     138c <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1276:	8b 45 08             	mov    0x8(%ebp),%eax
    1279:	8b 00                	mov    (%eax),%eax
    127b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    127e:	7f 0b                	jg     128b <APDcCopy+0xa0>
    1280:	8b 45 08             	mov    0x8(%ebp),%eax
    1283:	8b 00                	mov    (%eax),%eax
    1285:	83 e8 01             	sub    $0x1,%eax
    1288:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    128b:	8b 45 08             	mov    0x8(%ebp),%eax
    128e:	8b 40 04             	mov    0x4(%eax),%eax
    1291:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1294:	7f 0c                	jg     12a2 <APDcCopy+0xb7>
    1296:	8b 45 08             	mov    0x8(%ebp),%eax
    1299:	8b 40 04             	mov    0x4(%eax),%eax
    129c:	83 e8 01             	sub    $0x1,%eax
    129f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    12a2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12a9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    12b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12b7:	e9 bc 00 00 00       	jmp    1378 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12bc:	8b 45 08             	mov    0x8(%ebp),%eax
    12bf:	8b 00                	mov    (%eax),%eax
    12c1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12c4:	8b 55 10             	mov    0x10(%ebp),%edx
    12c7:	01 ca                	add    %ecx,%edx
    12c9:	0f af d0             	imul   %eax,%edx
    12cc:	8b 45 0c             	mov    0xc(%ebp),%eax
    12cf:	01 d0                	add    %edx,%eax
    12d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    12d4:	8b 45 14             	mov    0x14(%ebp),%eax
    12d7:	8b 00                	mov    (%eax),%eax
    12d9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12dc:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12df:	01 ca                	add    %ecx,%edx
    12e1:	0f af d0             	imul   %eax,%edx
    12e4:	8b 45 18             	mov    0x18(%ebp),%eax
    12e7:	01 d0                	add    %edx,%eax
    12e9:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    12ec:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12f3:	eb 74                	jmp    1369 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    12f5:	8b 45 14             	mov    0x14(%ebp),%eax
    12f8:	8b 50 18             	mov    0x18(%eax),%edx
    12fb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1301:	01 c8                	add    %ecx,%eax
    1303:	89 c1                	mov    %eax,%ecx
    1305:	89 c8                	mov    %ecx,%eax
    1307:	01 c0                	add    %eax,%eax
    1309:	01 c8                	add    %ecx,%eax
    130b:	01 d0                	add    %edx,%eax
    130d:	0f b7 10             	movzwl (%eax),%edx
    1310:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1314:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1318:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    131b:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    131f:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1323:	38 c2                	cmp    %al,%dl
    1325:	75 18                	jne    133f <APDcCopy+0x154>
    1327:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    132b:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    132f:	38 c2                	cmp    %al,%dl
    1331:	75 0c                	jne    133f <APDcCopy+0x154>
    1333:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1337:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    133b:	38 c2                	cmp    %al,%dl
    133d:	74 26                	je     1365 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    133f:	8b 45 08             	mov    0x8(%ebp),%eax
    1342:	8b 50 18             	mov    0x18(%eax),%edx
    1345:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1348:	8b 45 f0             	mov    -0x10(%ebp),%eax
    134b:	01 c8                	add    %ecx,%eax
    134d:	89 c1                	mov    %eax,%ecx
    134f:	89 c8                	mov    %ecx,%eax
    1351:	01 c0                	add    %eax,%eax
    1353:	01 c8                	add    %ecx,%eax
    1355:	01 d0                	add    %edx,%eax
    1357:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    135b:	66 89 10             	mov    %dx,(%eax)
    135e:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1362:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1365:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1369:	8b 45 fc             	mov    -0x4(%ebp),%eax
    136c:	2b 45 0c             	sub    0xc(%ebp),%eax
    136f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1372:	7d 81                	jge    12f5 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1374:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1378:	8b 45 f8             	mov    -0x8(%ebp),%eax
    137b:	2b 45 10             	sub    0x10(%ebp),%eax
    137e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1381:	0f 8d 35 ff ff ff    	jge    12bc <APDcCopy+0xd1>
    1387:	eb 04                	jmp    138d <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1389:	90                   	nop
    138a:	eb 01                	jmp    138d <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    138c:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    138d:	c9                   	leave  
    138e:	c3                   	ret    

0000138f <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    138f:	55                   	push   %ebp
    1390:	89 e5                	mov    %esp,%ebp
    1392:	83 ec 1c             	sub    $0x1c,%esp
    1395:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1398:	8b 55 10             	mov    0x10(%ebp),%edx
    139b:	8b 45 14             	mov    0x14(%ebp),%eax
    139e:	88 4d ec             	mov    %cl,-0x14(%ebp)
    13a1:	88 55 e8             	mov    %dl,-0x18(%ebp)
    13a4:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    13a7:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13ab:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13ae:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13b2:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13b5:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13b9:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13bc:	8b 45 08             	mov    0x8(%ebp),%eax
    13bf:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13c3:	66 89 10             	mov    %dx,(%eax)
    13c6:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13ca:	88 50 02             	mov    %dl,0x2(%eax)
}
    13cd:	8b 45 08             	mov    0x8(%ebp),%eax
    13d0:	c9                   	leave  
    13d1:	c2 04 00             	ret    $0x4

000013d4 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    13d4:	55                   	push   %ebp
    13d5:	89 e5                	mov    %esp,%ebp
    13d7:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13da:	8b 45 08             	mov    0x8(%ebp),%eax
    13dd:	8b 00                	mov    (%eax),%eax
    13df:	83 ec 08             	sub    $0x8,%esp
    13e2:	8d 55 0c             	lea    0xc(%ebp),%edx
    13e5:	52                   	push   %edx
    13e6:	50                   	push   %eax
    13e7:	e8 87 ef ff ff       	call   373 <sendMessage>
    13ec:	83 c4 10             	add    $0x10,%esp
}
    13ef:	90                   	nop
    13f0:	c9                   	leave  
    13f1:	c3                   	ret    

000013f2 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    13f2:	55                   	push   %ebp
    13f3:	89 e5                	mov    %esp,%ebp
    13f5:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    13f8:	83 ec 0c             	sub    $0xc,%esp
    13fb:	68 98 00 00 00       	push   $0x98
    1400:	e8 38 f3 ff ff       	call   73d <malloc>
    1405:	83 c4 10             	add    $0x10,%esp
    1408:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    140b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    140f:	75 15                	jne    1426 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1411:	83 ec 04             	sub    $0x4,%esp
    1414:	ff 75 08             	pushl  0x8(%ebp)
    1417:	68 6c 22 00 00       	push   $0x226c
    141c:	6a 01                	push   $0x1
    141e:	e8 47 f0 ff ff       	call   46a <printf>
    1423:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1426:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1429:	05 84 00 00 00       	add    $0x84,%eax
    142e:	83 ec 08             	sub    $0x8,%esp
    1431:	ff 75 08             	pushl  0x8(%ebp)
    1434:	50                   	push   %eax
    1435:	e8 60 ec ff ff       	call   9a <strcpy>
    143a:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    143d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1440:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1447:	8b 45 f4             	mov    -0xc(%ebp),%eax
    144a:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1451:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1454:	8b 40 3c             	mov    0x3c(%eax),%eax
    1457:	89 c2                	mov    %eax,%edx
    1459:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145c:	8b 40 40             	mov    0x40(%eax),%eax
    145f:	0f af d0             	imul   %eax,%edx
    1462:	89 d0                	mov    %edx,%eax
    1464:	01 c0                	add    %eax,%eax
    1466:	01 d0                	add    %edx,%eax
    1468:	83 ec 0c             	sub    $0xc,%esp
    146b:	50                   	push   %eax
    146c:	e8 cc f2 ff ff       	call   73d <malloc>
    1471:	83 c4 10             	add    $0x10,%esp
    1474:	89 c2                	mov    %eax,%edx
    1476:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1479:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    147c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    147f:	8b 40 54             	mov    0x54(%eax),%eax
    1482:	85 c0                	test   %eax,%eax
    1484:	75 15                	jne    149b <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1486:	83 ec 04             	sub    $0x4,%esp
    1489:	ff 75 08             	pushl  0x8(%ebp)
    148c:	68 8c 22 00 00       	push   $0x228c
    1491:	6a 01                	push   $0x1
    1493:	e8 d2 ef ff ff       	call   46a <printf>
    1498:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    149b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149e:	8b 40 3c             	mov    0x3c(%eax),%eax
    14a1:	89 c2                	mov    %eax,%edx
    14a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a6:	8b 40 40             	mov    0x40(%eax),%eax
    14a9:	0f af d0             	imul   %eax,%edx
    14ac:	89 d0                	mov    %edx,%eax
    14ae:	01 c0                	add    %eax,%eax
    14b0:	01 c2                	add    %eax,%edx
    14b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b5:	8b 40 54             	mov    0x54(%eax),%eax
    14b8:	83 ec 04             	sub    $0x4,%esp
    14bb:	52                   	push   %edx
    14bc:	68 ff ff ff 00       	push   $0xffffff
    14c1:	50                   	push   %eax
    14c2:	e8 69 ec ff ff       	call   130 <memset>
    14c7:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cd:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    14d4:	e8 72 ee ff ff       	call   34b <getpid>
    14d9:	89 c2                	mov    %eax,%edx
    14db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14de:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e4:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ee:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    14f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f8:	8b 40 58             	mov    0x58(%eax),%eax
    14fb:	89 c2                	mov    %eax,%edx
    14fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1500:	8b 40 5c             	mov    0x5c(%eax),%eax
    1503:	0f af d0             	imul   %eax,%edx
    1506:	89 d0                	mov    %edx,%eax
    1508:	01 c0                	add    %eax,%eax
    150a:	01 d0                	add    %edx,%eax
    150c:	83 ec 0c             	sub    $0xc,%esp
    150f:	50                   	push   %eax
    1510:	e8 28 f2 ff ff       	call   73d <malloc>
    1515:	83 c4 10             	add    $0x10,%esp
    1518:	89 c2                	mov    %eax,%edx
    151a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151d:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1520:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1523:	8b 40 70             	mov    0x70(%eax),%eax
    1526:	85 c0                	test   %eax,%eax
    1528:	75 15                	jne    153f <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    152a:	83 ec 04             	sub    $0x4,%esp
    152d:	ff 75 08             	pushl  0x8(%ebp)
    1530:	68 b0 22 00 00       	push   $0x22b0
    1535:	6a 01                	push   $0x1
    1537:	e8 2e ef ff ff       	call   46a <printf>
    153c:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    153f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1542:	8b 40 3c             	mov    0x3c(%eax),%eax
    1545:	89 c2                	mov    %eax,%edx
    1547:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154a:	8b 40 40             	mov    0x40(%eax),%eax
    154d:	0f af d0             	imul   %eax,%edx
    1550:	89 d0                	mov    %edx,%eax
    1552:	01 c0                	add    %eax,%eax
    1554:	01 c2                	add    %eax,%edx
    1556:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1559:	8b 40 54             	mov    0x54(%eax),%eax
    155c:	83 ec 04             	sub    $0x4,%esp
    155f:	52                   	push   %edx
    1560:	68 ff 00 00 00       	push   $0xff
    1565:	50                   	push   %eax
    1566:	e8 c5 eb ff ff       	call   130 <memset>
    156b:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    156e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1571:	8b 55 0c             	mov    0xc(%ebp),%edx
    1574:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1577:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    157b:	74 49                	je     15c6 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    157d:	8b 45 10             	mov    0x10(%ebp),%eax
    1580:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1586:	83 ec 0c             	sub    $0xc,%esp
    1589:	50                   	push   %eax
    158a:	e8 ae f1 ff ff       	call   73d <malloc>
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
        r->pos_x = 0;
    15ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b0:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    15b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ba:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    15c1:	e9 8d 00 00 00       	jmp    1653 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c9:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d3:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15dd:	8b 40 20             	mov    0x20(%eax),%eax
    15e0:	89 c2                	mov    %eax,%edx
    15e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e5:	8b 40 24             	mov    0x24(%eax),%eax
    15e8:	0f af d0             	imul   %eax,%edx
    15eb:	89 d0                	mov    %edx,%eax
    15ed:	01 c0                	add    %eax,%eax
    15ef:	01 d0                	add    %edx,%eax
    15f1:	83 ec 0c             	sub    $0xc,%esp
    15f4:	50                   	push   %eax
    15f5:	e8 43 f1 ff ff       	call   73d <malloc>
    15fa:	83 c4 10             	add    $0x10,%esp
    15fd:	89 c2                	mov    %eax,%edx
    15ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1602:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1605:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1608:	8b 40 38             	mov    0x38(%eax),%eax
    160b:	85 c0                	test   %eax,%eax
    160d:	75 15                	jne    1624 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    160f:	83 ec 04             	sub    $0x4,%esp
    1612:	ff 75 08             	pushl  0x8(%ebp)
    1615:	68 d8 22 00 00       	push   $0x22d8
    161a:	6a 01                	push   $0x1
    161c:	e8 49 ee ff ff       	call   46a <printf>
    1621:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1624:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1627:	8b 40 20             	mov    0x20(%eax),%eax
    162a:	89 c2                	mov    %eax,%edx
    162c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162f:	8b 40 24             	mov    0x24(%eax),%eax
    1632:	0f af d0             	imul   %eax,%edx
    1635:	89 d0                	mov    %edx,%eax
    1637:	01 c0                	add    %eax,%eax
    1639:	01 c2                	add    %eax,%edx
    163b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163e:	8b 40 38             	mov    0x38(%eax),%eax
    1641:	83 ec 04             	sub    $0x4,%esp
    1644:	52                   	push   %edx
    1645:	68 ff ff ff 00       	push   $0xffffff
    164a:	50                   	push   %eax
    164b:	e8 e0 ea ff ff       	call   130 <memset>
    1650:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1653:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1656:	c9                   	leave  
    1657:	c3                   	ret    

00001658 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1658:	55                   	push   %ebp
    1659:	89 e5                	mov    %esp,%ebp
    165b:	57                   	push   %edi
    165c:	56                   	push   %esi
    165d:	53                   	push   %ebx
    165e:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1661:	8b 45 0c             	mov    0xc(%ebp),%eax
    1664:	83 f8 03             	cmp    $0x3,%eax
    1667:	74 02                	je     166b <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1669:	eb 7c                	jmp    16e7 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    166b:	8b 45 08             	mov    0x8(%ebp),%eax
    166e:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1671:	8b 45 08             	mov    0x8(%ebp),%eax
    1674:	8b 48 18             	mov    0x18(%eax),%ecx
    1677:	8b 45 08             	mov    0x8(%ebp),%eax
    167a:	8b 50 5c             	mov    0x5c(%eax),%edx
    167d:	8b 45 08             	mov    0x8(%ebp),%eax
    1680:	8b 40 58             	mov    0x58(%eax),%eax
    1683:	8b 75 08             	mov    0x8(%ebp),%esi
    1686:	83 c6 58             	add    $0x58,%esi
    1689:	83 ec 04             	sub    $0x4,%esp
    168c:	53                   	push   %ebx
    168d:	51                   	push   %ecx
    168e:	6a 00                	push   $0x0
    1690:	52                   	push   %edx
    1691:	50                   	push   %eax
    1692:	6a 00                	push   $0x0
    1694:	6a 00                	push   $0x0
    1696:	56                   	push   %esi
    1697:	6a 00                	push   $0x0
    1699:	6a 00                	push   $0x0
    169b:	ff 75 08             	pushl  0x8(%ebp)
    169e:	e8 c8 ec ff ff       	call   36b <paintWindow>
    16a3:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    16a6:	8b 45 08             	mov    0x8(%ebp),%eax
    16a9:	8b 70 1c             	mov    0x1c(%eax),%esi
    16ac:	8b 45 08             	mov    0x8(%ebp),%eax
    16af:	8b 58 18             	mov    0x18(%eax),%ebx
    16b2:	8b 45 08             	mov    0x8(%ebp),%eax
    16b5:	8b 48 08             	mov    0x8(%eax),%ecx
    16b8:	8b 45 08             	mov    0x8(%ebp),%eax
    16bb:	8b 50 40             	mov    0x40(%eax),%edx
    16be:	8b 45 08             	mov    0x8(%ebp),%eax
    16c1:	8b 40 3c             	mov    0x3c(%eax),%eax
    16c4:	8b 7d 08             	mov    0x8(%ebp),%edi
    16c7:	83 c7 3c             	add    $0x3c,%edi
    16ca:	83 ec 04             	sub    $0x4,%esp
    16cd:	56                   	push   %esi
    16ce:	53                   	push   %ebx
    16cf:	51                   	push   %ecx
    16d0:	52                   	push   %edx
    16d1:	50                   	push   %eax
    16d2:	6a 00                	push   $0x0
    16d4:	6a 00                	push   $0x0
    16d6:	57                   	push   %edi
    16d7:	6a 32                	push   $0x32
    16d9:	6a 00                	push   $0x0
    16db:	ff 75 08             	pushl  0x8(%ebp)
    16de:	e8 88 ec ff ff       	call   36b <paintWindow>
    16e3:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    16e6:	90                   	nop
        default: break;
            
            
    }
    return False;
    16e7:	b8 00 00 00 00       	mov    $0x0,%eax
}
    16ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16ef:	5b                   	pop    %ebx
    16f0:	5e                   	pop    %esi
    16f1:	5f                   	pop    %edi
    16f2:	5d                   	pop    %ebp
    16f3:	c3                   	ret    

000016f4 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    16f4:	55                   	push   %ebp
    16f5:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    16f7:	8b 45 0c             	mov    0xc(%ebp),%eax
    16fa:	8b 50 08             	mov    0x8(%eax),%edx
    16fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1700:	8b 00                	mov    (%eax),%eax
    1702:	39 c2                	cmp    %eax,%edx
    1704:	74 07                	je     170d <APPreJudge+0x19>
        return False;
    1706:	b8 00 00 00 00       	mov    $0x0,%eax
    170b:	eb 05                	jmp    1712 <APPreJudge+0x1e>
    return True;
    170d:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1712:	5d                   	pop    %ebp
    1713:	c3                   	ret    

00001714 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1714:	55                   	push   %ebp
    1715:	89 e5                	mov    %esp,%ebp
    1717:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    171a:	8b 45 08             	mov    0x8(%ebp),%eax
    171d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1720:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1726:	83 ec 0c             	sub    $0xc,%esp
    1729:	ff 75 08             	pushl  0x8(%ebp)
    172c:	e8 52 ec ff ff       	call   383 <registWindow>
    1731:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1734:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    173b:	8b 45 08             	mov    0x8(%ebp),%eax
    173e:	8b 00                	mov    (%eax),%eax
    1740:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1743:	ff 75 f4             	pushl  -0xc(%ebp)
    1746:	ff 75 f0             	pushl  -0x10(%ebp)
    1749:	ff 75 ec             	pushl  -0x14(%ebp)
    174c:	ff 75 08             	pushl  0x8(%ebp)
    174f:	e8 80 fc ff ff       	call   13d4 <APSendMessage>
    1754:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1757:	83 ec 0c             	sub    $0xc,%esp
    175a:	ff 75 08             	pushl  0x8(%ebp)
    175d:	e8 19 ec ff ff       	call   37b <getMessage>
    1762:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1765:	8b 45 08             	mov    0x8(%ebp),%eax
    1768:	83 c0 74             	add    $0x74,%eax
    176b:	83 ec 08             	sub    $0x8,%esp
    176e:	50                   	push   %eax
    176f:	ff 75 08             	pushl  0x8(%ebp)
    1772:	e8 7d ff ff ff       	call   16f4 <APPreJudge>
    1777:	83 c4 10             	add    $0x10,%esp
    177a:	84 c0                	test   %al,%al
    177c:	74 1b                	je     1799 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    177e:	8b 45 08             	mov    0x8(%ebp),%eax
    1781:	ff 70 7c             	pushl  0x7c(%eax)
    1784:	ff 70 78             	pushl  0x78(%eax)
    1787:	ff 70 74             	pushl  0x74(%eax)
    178a:	ff 75 08             	pushl  0x8(%ebp)
    178d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1790:	ff d0                	call   *%eax
    1792:	83 c4 10             	add    $0x10,%esp
    1795:	84 c0                	test   %al,%al
    1797:	75 0c                	jne    17a5 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1799:	8b 45 08             	mov    0x8(%ebp),%eax
    179c:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    17a3:	eb b2                	jmp    1757 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    17a5:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    17a6:	90                   	nop
    17a7:	c9                   	leave  
    17a8:	c3                   	ret    

000017a9 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    17a9:	55                   	push   %ebp
    17aa:	89 e5                	mov    %esp,%ebp
    17ac:	57                   	push   %edi
    17ad:	56                   	push   %esi
    17ae:	53                   	push   %ebx
    17af:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    17b2:	a1 60 29 00 00       	mov    0x2960,%eax
    17b7:	85 c0                	test   %eax,%eax
    17b9:	0f 85 2c 02 00 00    	jne    19eb <APGridPaint+0x242>
    {
        iconReady = 1;
    17bf:	c7 05 60 29 00 00 01 	movl   $0x1,0x2960
    17c6:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    17c9:	8d 45 98             	lea    -0x68(%ebp),%eax
    17cc:	83 ec 08             	sub    $0x8,%esp
    17cf:	68 ff 22 00 00       	push   $0x22ff
    17d4:	50                   	push   %eax
    17d5:	e8 16 f1 ff ff       	call   8f0 <APLoadBitmap>
    17da:	83 c4 0c             	add    $0xc,%esp
    17dd:	8b 45 98             	mov    -0x68(%ebp),%eax
    17e0:	a3 84 29 00 00       	mov    %eax,0x2984
    17e5:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17e8:	a3 88 29 00 00       	mov    %eax,0x2988
    17ed:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17f0:	a3 8c 29 00 00       	mov    %eax,0x298c
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    17f5:	83 ec 04             	sub    $0x4,%esp
    17f8:	ff 35 8c 29 00 00    	pushl  0x298c
    17fe:	ff 35 88 29 00 00    	pushl  0x2988
    1804:	ff 35 84 29 00 00    	pushl  0x2984
    180a:	e8 1b f3 ff ff       	call   b2a <APCreateCompatibleDCFromBitmap>
    180f:	83 c4 10             	add    $0x10,%esp
    1812:	a3 90 29 00 00       	mov    %eax,0x2990
        grid_river = APLoadBitmap ("grid_river.bmp");
    1817:	8d 45 98             	lea    -0x68(%ebp),%eax
    181a:	83 ec 08             	sub    $0x8,%esp
    181d:	68 0d 23 00 00       	push   $0x230d
    1822:	50                   	push   %eax
    1823:	e8 c8 f0 ff ff       	call   8f0 <APLoadBitmap>
    1828:	83 c4 0c             	add    $0xc,%esp
    182b:	8b 45 98             	mov    -0x68(%ebp),%eax
    182e:	a3 c0 29 00 00       	mov    %eax,0x29c0
    1833:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1836:	a3 c4 29 00 00       	mov    %eax,0x29c4
    183b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    183e:	a3 c8 29 00 00       	mov    %eax,0x29c8
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1843:	83 ec 04             	sub    $0x4,%esp
    1846:	ff 35 c8 29 00 00    	pushl  0x29c8
    184c:	ff 35 c4 29 00 00    	pushl  0x29c4
    1852:	ff 35 c0 29 00 00    	pushl  0x29c0
    1858:	e8 cd f2 ff ff       	call   b2a <APCreateCompatibleDCFromBitmap>
    185d:	83 c4 10             	add    $0x10,%esp
    1860:	a3 b0 29 00 00       	mov    %eax,0x29b0
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1865:	8d 45 98             	lea    -0x68(%ebp),%eax
    1868:	83 ec 08             	sub    $0x8,%esp
    186b:	68 1c 23 00 00       	push   $0x231c
    1870:	50                   	push   %eax
    1871:	e8 7a f0 ff ff       	call   8f0 <APLoadBitmap>
    1876:	83 c4 0c             	add    $0xc,%esp
    1879:	8b 45 98             	mov    -0x68(%ebp),%eax
    187c:	a3 b4 29 00 00       	mov    %eax,0x29b4
    1881:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1884:	a3 b8 29 00 00       	mov    %eax,0x29b8
    1889:	8b 45 a0             	mov    -0x60(%ebp),%eax
    188c:	a3 bc 29 00 00       	mov    %eax,0x29bc
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1891:	83 ec 04             	sub    $0x4,%esp
    1894:	ff 35 bc 29 00 00    	pushl  0x29bc
    189a:	ff 35 b8 29 00 00    	pushl  0x29b8
    18a0:	ff 35 b4 29 00 00    	pushl  0x29b4
    18a6:	e8 7f f2 ff ff       	call   b2a <APCreateCompatibleDCFromBitmap>
    18ab:	83 c4 10             	add    $0x10,%esp
    18ae:	a3 64 29 00 00       	mov    %eax,0x2964
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    18b3:	8d 45 98             	lea    -0x68(%ebp),%eax
    18b6:	83 ec 08             	sub    $0x8,%esp
    18b9:	68 2b 23 00 00       	push   $0x232b
    18be:	50                   	push   %eax
    18bf:	e8 2c f0 ff ff       	call   8f0 <APLoadBitmap>
    18c4:	83 c4 0c             	add    $0xc,%esp
    18c7:	8b 45 98             	mov    -0x68(%ebp),%eax
    18ca:	a3 98 29 00 00       	mov    %eax,0x2998
    18cf:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18d2:	a3 9c 29 00 00       	mov    %eax,0x299c
    18d7:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18da:	a3 a0 29 00 00       	mov    %eax,0x29a0
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    18df:	83 ec 04             	sub    $0x4,%esp
    18e2:	ff 35 a0 29 00 00    	pushl  0x29a0
    18e8:	ff 35 9c 29 00 00    	pushl  0x299c
    18ee:	ff 35 98 29 00 00    	pushl  0x2998
    18f4:	e8 31 f2 ff ff       	call   b2a <APCreateCompatibleDCFromBitmap>
    18f9:	83 c4 10             	add    $0x10,%esp
    18fc:	a3 cc 29 00 00       	mov    %eax,0x29cc
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1901:	8d 45 98             	lea    -0x68(%ebp),%eax
    1904:	83 ec 08             	sub    $0x8,%esp
    1907:	68 39 23 00 00       	push   $0x2339
    190c:	50                   	push   %eax
    190d:	e8 de ef ff ff       	call   8f0 <APLoadBitmap>
    1912:	83 c4 0c             	add    $0xc,%esp
    1915:	8b 45 98             	mov    -0x68(%ebp),%eax
    1918:	a3 74 29 00 00       	mov    %eax,0x2974
    191d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1920:	a3 78 29 00 00       	mov    %eax,0x2978
    1925:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1928:	a3 7c 29 00 00       	mov    %eax,0x297c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    192d:	83 ec 04             	sub    $0x4,%esp
    1930:	ff 35 7c 29 00 00    	pushl  0x297c
    1936:	ff 35 78 29 00 00    	pushl  0x2978
    193c:	ff 35 74 29 00 00    	pushl  0x2974
    1942:	e8 e3 f1 ff ff       	call   b2a <APCreateCompatibleDCFromBitmap>
    1947:	83 c4 10             	add    $0x10,%esp
    194a:	a3 94 29 00 00       	mov    %eax,0x2994
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    194f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1952:	83 ec 08             	sub    $0x8,%esp
    1955:	68 49 23 00 00       	push   $0x2349
    195a:	50                   	push   %eax
    195b:	e8 90 ef ff ff       	call   8f0 <APLoadBitmap>
    1960:	83 c4 0c             	add    $0xc,%esp
    1963:	8b 45 98             	mov    -0x68(%ebp),%eax
    1966:	a3 68 29 00 00       	mov    %eax,0x2968
    196b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    196e:	a3 6c 29 00 00       	mov    %eax,0x296c
    1973:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1976:	a3 70 29 00 00       	mov    %eax,0x2970
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    197b:	83 ec 04             	sub    $0x4,%esp
    197e:	ff 35 70 29 00 00    	pushl  0x2970
    1984:	ff 35 6c 29 00 00    	pushl  0x296c
    198a:	ff 35 68 29 00 00    	pushl  0x2968
    1990:	e8 95 f1 ff ff       	call   b2a <APCreateCompatibleDCFromBitmap>
    1995:	83 c4 10             	add    $0x10,%esp
    1998:	a3 80 29 00 00       	mov    %eax,0x2980
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    199d:	8d 45 98             	lea    -0x68(%ebp),%eax
    19a0:	83 ec 08             	sub    $0x8,%esp
    19a3:	68 5b 23 00 00       	push   $0x235b
    19a8:	50                   	push   %eax
    19a9:	e8 42 ef ff ff       	call   8f0 <APLoadBitmap>
    19ae:	83 c4 0c             	add    $0xc,%esp
    19b1:	8b 45 98             	mov    -0x68(%ebp),%eax
    19b4:	a3 a4 29 00 00       	mov    %eax,0x29a4
    19b9:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19bc:	a3 a8 29 00 00       	mov    %eax,0x29a8
    19c1:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19c4:	a3 ac 29 00 00       	mov    %eax,0x29ac
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    19c9:	83 ec 04             	sub    $0x4,%esp
    19cc:	ff 35 ac 29 00 00    	pushl  0x29ac
    19d2:	ff 35 a8 29 00 00    	pushl  0x29a8
    19d8:	ff 35 a4 29 00 00    	pushl  0x29a4
    19de:	e8 47 f1 ff ff       	call   b2a <APCreateCompatibleDCFromBitmap>
    19e3:	83 c4 10             	add    $0x10,%esp
    19e6:	a3 d0 29 00 00       	mov    %eax,0x29d0
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    19eb:	8b 45 08             	mov    0x8(%ebp),%eax
    19ee:	8b 40 08             	mov    0x8(%eax),%eax
    19f1:	85 c0                	test   %eax,%eax
    19f3:	75 17                	jne    1a0c <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    19f5:	83 ec 08             	sub    $0x8,%esp
    19f8:	68 6c 23 00 00       	push   $0x236c
    19fd:	6a 01                	push   $0x1
    19ff:	e8 66 ea ff ff       	call   46a <printf>
    1a04:	83 c4 10             	add    $0x10,%esp
        return;
    1a07:	e9 a0 04 00 00       	jmp    1eac <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1a0c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0f:	8b 40 10             	mov    0x10(%eax),%eax
    1a12:	85 c0                	test   %eax,%eax
    1a14:	7e 10                	jle    1a26 <APGridPaint+0x27d>
    1a16:	8b 45 08             	mov    0x8(%ebp),%eax
    1a19:	8b 50 14             	mov    0x14(%eax),%edx
    1a1c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1f:	8b 40 10             	mov    0x10(%eax),%eax
    1a22:	39 c2                	cmp    %eax,%edx
    1a24:	7c 17                	jl     1a3d <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1a26:	83 ec 08             	sub    $0x8,%esp
    1a29:	68 92 23 00 00       	push   $0x2392
    1a2e:	6a 01                	push   $0x1
    1a30:	e8 35 ea ff ff       	call   46a <printf>
    1a35:	83 c4 10             	add    $0x10,%esp
        return;
    1a38:	e9 6f 04 00 00       	jmp    1eac <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1a3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a40:	8b 40 14             	mov    0x14(%eax),%eax
    1a43:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a49:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a4c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a4f:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a52:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a59:	e9 96 03 00 00       	jmp    1df4 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a5e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a65:	e9 7c 03 00 00       	jmp    1de6 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a6a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a6d:	c1 e0 04             	shl    $0x4,%eax
    1a70:	89 c2                	mov    %eax,%edx
    1a72:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a75:	01 c2                	add    %eax,%edx
    1a77:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a7a:	01 d0                	add    %edx,%eax
    1a7c:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a82:	8b 40 0c             	mov    0xc(%eax),%eax
    1a85:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a88:	c1 e2 02             	shl    $0x2,%edx
    1a8b:	01 d0                	add    %edx,%eax
    1a8d:	8b 00                	mov    (%eax),%eax
    1a8f:	83 f8 07             	cmp    $0x7,%eax
    1a92:	0f 87 49 03 00 00    	ja     1de1 <APGridPaint+0x638>
    1a98:	8b 04 85 a8 23 00 00 	mov    0x23a8(,%eax,4),%eax
    1a9f:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1aa1:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1aa4:	6a 0c                	push   $0xc
    1aa6:	6a 0c                	push   $0xc
    1aa8:	6a 0c                	push   $0xc
    1aaa:	50                   	push   %eax
    1aab:	e8 df f8 ff ff       	call   138f <RGB>
    1ab0:	83 c4 0c             	add    $0xc,%esp
    1ab3:	8b 1d 90 29 00 00    	mov    0x2990,%ebx
    1ab9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1abc:	6b c8 32             	imul   $0x32,%eax,%ecx
    1abf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ac2:	6b c0 32             	imul   $0x32,%eax,%eax
    1ac5:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ac8:	8b 45 08             	mov    0x8(%ebp),%eax
    1acb:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ace:	83 ec 0c             	sub    $0xc,%esp
    1ad1:	83 ec 04             	sub    $0x4,%esp
    1ad4:	89 e0                	mov    %esp,%eax
    1ad6:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1ada:	66 89 30             	mov    %si,(%eax)
    1add:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1ae1:	88 50 02             	mov    %dl,0x2(%eax)
    1ae4:	6a 32                	push   $0x32
    1ae6:	6a 32                	push   $0x32
    1ae8:	6a 00                	push   $0x0
    1aea:	6a 00                	push   $0x0
    1aec:	53                   	push   %ebx
    1aed:	51                   	push   %ecx
    1aee:	ff 75 94             	pushl  -0x6c(%ebp)
    1af1:	57                   	push   %edi
    1af2:	e8 f4 f6 ff ff       	call   11eb <APDcCopy>
    1af7:	83 c4 30             	add    $0x30,%esp
                    break;
    1afa:	e9 e3 02 00 00       	jmp    1de2 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1aff:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b02:	6a 69                	push   $0x69
    1b04:	6a 69                	push   $0x69
    1b06:	6a 69                	push   $0x69
    1b08:	50                   	push   %eax
    1b09:	e8 81 f8 ff ff       	call   138f <RGB>
    1b0e:	83 c4 0c             	add    $0xc,%esp
    1b11:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b15:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1b19:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b1d:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1b20:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1b27:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b2a:	6a 69                	push   $0x69
    1b2c:	6a 69                	push   $0x69
    1b2e:	6a 69                	push   $0x69
    1b30:	50                   	push   %eax
    1b31:	e8 59 f8 ff ff       	call   138f <RGB>
    1b36:	83 c4 0c             	add    $0xc,%esp
    1b39:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b3d:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1b41:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b45:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b48:	8b 45 08             	mov    0x8(%ebp),%eax
    1b4b:	8d 50 3c             	lea    0x3c(%eax),%edx
    1b4e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b51:	ff 75 b0             	pushl  -0x50(%ebp)
    1b54:	ff 75 ac             	pushl  -0x54(%ebp)
    1b57:	52                   	push   %edx
    1b58:	50                   	push   %eax
    1b59:	e8 61 f0 ff ff       	call   bbf <APSetPen>
    1b5e:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b61:	8b 45 08             	mov    0x8(%ebp),%eax
    1b64:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1b67:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b6a:	83 ec 04             	sub    $0x4,%esp
    1b6d:	83 ec 04             	sub    $0x4,%esp
    1b70:	89 e0                	mov    %esp,%eax
    1b72:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1b76:	66 89 08             	mov    %cx,(%eax)
    1b79:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1b7d:	88 48 02             	mov    %cl,0x2(%eax)
    1b80:	53                   	push   %ebx
    1b81:	52                   	push   %edx
    1b82:	e8 71 f0 ff ff       	call   bf8 <APSetBrush>
    1b87:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b8a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b8d:	6b d0 32             	imul   $0x32,%eax,%edx
    1b90:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b93:	6b c0 32             	imul   $0x32,%eax,%eax
    1b96:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b99:	83 c1 3c             	add    $0x3c,%ecx
    1b9c:	83 ec 0c             	sub    $0xc,%esp
    1b9f:	6a 32                	push   $0x32
    1ba1:	6a 32                	push   $0x32
    1ba3:	52                   	push   %edx
    1ba4:	50                   	push   %eax
    1ba5:	51                   	push   %ecx
    1ba6:	e8 35 f4 ff ff       	call   fe0 <APDrawRect>
    1bab:	83 c4 20             	add    $0x20,%esp
                    break;
    1bae:	e9 2f 02 00 00       	jmp    1de2 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bb3:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1bb6:	6a 0c                	push   $0xc
    1bb8:	6a 0c                	push   $0xc
    1bba:	6a 0c                	push   $0xc
    1bbc:	50                   	push   %eax
    1bbd:	e8 cd f7 ff ff       	call   138f <RGB>
    1bc2:	83 c4 0c             	add    $0xc,%esp
    1bc5:	8b 1d d0 29 00 00    	mov    0x29d0,%ebx
    1bcb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bce:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bd4:	6b c0 32             	imul   $0x32,%eax,%eax
    1bd7:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bda:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdd:	8d 78 3c             	lea    0x3c(%eax),%edi
    1be0:	83 ec 0c             	sub    $0xc,%esp
    1be3:	83 ec 04             	sub    $0x4,%esp
    1be6:	89 e0                	mov    %esp,%eax
    1be8:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1bec:	66 89 30             	mov    %si,(%eax)
    1bef:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1bf3:	88 50 02             	mov    %dl,0x2(%eax)
    1bf6:	6a 32                	push   $0x32
    1bf8:	6a 32                	push   $0x32
    1bfa:	6a 00                	push   $0x0
    1bfc:	6a 00                	push   $0x0
    1bfe:	53                   	push   %ebx
    1bff:	51                   	push   %ecx
    1c00:	ff 75 94             	pushl  -0x6c(%ebp)
    1c03:	57                   	push   %edi
    1c04:	e8 e2 f5 ff ff       	call   11eb <APDcCopy>
    1c09:	83 c4 30             	add    $0x30,%esp
                    break;
    1c0c:	e9 d1 01 00 00       	jmp    1de2 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c11:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1c14:	6a 0c                	push   $0xc
    1c16:	6a 0c                	push   $0xc
    1c18:	6a 0c                	push   $0xc
    1c1a:	50                   	push   %eax
    1c1b:	e8 6f f7 ff ff       	call   138f <RGB>
    1c20:	83 c4 0c             	add    $0xc,%esp
    1c23:	8b 1d b0 29 00 00    	mov    0x29b0,%ebx
    1c29:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c2c:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c2f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c32:	6b c0 32             	imul   $0x32,%eax,%eax
    1c35:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c38:	8b 45 08             	mov    0x8(%ebp),%eax
    1c3b:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c3e:	83 ec 0c             	sub    $0xc,%esp
    1c41:	83 ec 04             	sub    $0x4,%esp
    1c44:	89 e0                	mov    %esp,%eax
    1c46:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1c4a:	66 89 30             	mov    %si,(%eax)
    1c4d:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c51:	88 50 02             	mov    %dl,0x2(%eax)
    1c54:	6a 32                	push   $0x32
    1c56:	6a 32                	push   $0x32
    1c58:	6a 00                	push   $0x0
    1c5a:	6a 00                	push   $0x0
    1c5c:	53                   	push   %ebx
    1c5d:	51                   	push   %ecx
    1c5e:	ff 75 94             	pushl  -0x6c(%ebp)
    1c61:	57                   	push   %edi
    1c62:	e8 84 f5 ff ff       	call   11eb <APDcCopy>
    1c67:	83 c4 30             	add    $0x30,%esp
                    break;
    1c6a:	e9 73 01 00 00       	jmp    1de2 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c6f:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c72:	6a 0c                	push   $0xc
    1c74:	6a 0c                	push   $0xc
    1c76:	6a 0c                	push   $0xc
    1c78:	50                   	push   %eax
    1c79:	e8 11 f7 ff ff       	call   138f <RGB>
    1c7e:	83 c4 0c             	add    $0xc,%esp
    1c81:	8b 1d 94 29 00 00    	mov    0x2994,%ebx
    1c87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c8a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c8d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c90:	6b c0 32             	imul   $0x32,%eax,%eax
    1c93:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c96:	8b 45 08             	mov    0x8(%ebp),%eax
    1c99:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c9c:	83 ec 0c             	sub    $0xc,%esp
    1c9f:	83 ec 04             	sub    $0x4,%esp
    1ca2:	89 e0                	mov    %esp,%eax
    1ca4:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1ca8:	66 89 30             	mov    %si,(%eax)
    1cab:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1caf:	88 50 02             	mov    %dl,0x2(%eax)
    1cb2:	6a 32                	push   $0x32
    1cb4:	6a 32                	push   $0x32
    1cb6:	6a 00                	push   $0x0
    1cb8:	6a 00                	push   $0x0
    1cba:	53                   	push   %ebx
    1cbb:	51                   	push   %ecx
    1cbc:	ff 75 94             	pushl  -0x6c(%ebp)
    1cbf:	57                   	push   %edi
    1cc0:	e8 26 f5 ff ff       	call   11eb <APDcCopy>
    1cc5:	83 c4 30             	add    $0x30,%esp
                    break;
    1cc8:	e9 15 01 00 00       	jmp    1de2 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ccd:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1cd0:	6a 0c                	push   $0xc
    1cd2:	6a 0c                	push   $0xc
    1cd4:	6a 0c                	push   $0xc
    1cd6:	50                   	push   %eax
    1cd7:	e8 b3 f6 ff ff       	call   138f <RGB>
    1cdc:	83 c4 0c             	add    $0xc,%esp
    1cdf:	8b 1d cc 29 00 00    	mov    0x29cc,%ebx
    1ce5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ce8:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ceb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cee:	6b c0 32             	imul   $0x32,%eax,%eax
    1cf1:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cf4:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf7:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cfa:	83 ec 0c             	sub    $0xc,%esp
    1cfd:	83 ec 04             	sub    $0x4,%esp
    1d00:	89 e0                	mov    %esp,%eax
    1d02:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1d06:	66 89 30             	mov    %si,(%eax)
    1d09:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1d0d:	88 50 02             	mov    %dl,0x2(%eax)
    1d10:	6a 32                	push   $0x32
    1d12:	6a 32                	push   $0x32
    1d14:	6a 00                	push   $0x0
    1d16:	6a 00                	push   $0x0
    1d18:	53                   	push   %ebx
    1d19:	51                   	push   %ecx
    1d1a:	ff 75 94             	pushl  -0x6c(%ebp)
    1d1d:	57                   	push   %edi
    1d1e:	e8 c8 f4 ff ff       	call   11eb <APDcCopy>
    1d23:	83 c4 30             	add    $0x30,%esp
                    break;
    1d26:	e9 b7 00 00 00       	jmp    1de2 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d2b:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1d2e:	6a 0c                	push   $0xc
    1d30:	6a 0c                	push   $0xc
    1d32:	6a 0c                	push   $0xc
    1d34:	50                   	push   %eax
    1d35:	e8 55 f6 ff ff       	call   138f <RGB>
    1d3a:	83 c4 0c             	add    $0xc,%esp
    1d3d:	8b 1d 64 29 00 00    	mov    0x2964,%ebx
    1d43:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d46:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d49:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d4c:	6b c0 32             	imul   $0x32,%eax,%eax
    1d4f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d52:	8b 45 08             	mov    0x8(%ebp),%eax
    1d55:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d58:	83 ec 0c             	sub    $0xc,%esp
    1d5b:	83 ec 04             	sub    $0x4,%esp
    1d5e:	89 e0                	mov    %esp,%eax
    1d60:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d64:	66 89 30             	mov    %si,(%eax)
    1d67:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d6b:	88 50 02             	mov    %dl,0x2(%eax)
    1d6e:	6a 32                	push   $0x32
    1d70:	6a 32                	push   $0x32
    1d72:	6a 00                	push   $0x0
    1d74:	6a 00                	push   $0x0
    1d76:	53                   	push   %ebx
    1d77:	51                   	push   %ecx
    1d78:	ff 75 94             	pushl  -0x6c(%ebp)
    1d7b:	57                   	push   %edi
    1d7c:	e8 6a f4 ff ff       	call   11eb <APDcCopy>
    1d81:	83 c4 30             	add    $0x30,%esp
                    break;
    1d84:	eb 5c                	jmp    1de2 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d86:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d89:	6a 0c                	push   $0xc
    1d8b:	6a 0c                	push   $0xc
    1d8d:	6a 0c                	push   $0xc
    1d8f:	50                   	push   %eax
    1d90:	e8 fa f5 ff ff       	call   138f <RGB>
    1d95:	83 c4 0c             	add    $0xc,%esp
    1d98:	8b 1d 80 29 00 00    	mov    0x2980,%ebx
    1d9e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1da1:	6b c8 32             	imul   $0x32,%eax,%ecx
    1da4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1da7:	6b c0 32             	imul   $0x32,%eax,%eax
    1daa:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dad:	8b 45 08             	mov    0x8(%ebp),%eax
    1db0:	8d 78 3c             	lea    0x3c(%eax),%edi
    1db3:	83 ec 0c             	sub    $0xc,%esp
    1db6:	83 ec 04             	sub    $0x4,%esp
    1db9:	89 e0                	mov    %esp,%eax
    1dbb:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1dbf:	66 89 30             	mov    %si,(%eax)
    1dc2:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1dc6:	88 50 02             	mov    %dl,0x2(%eax)
    1dc9:	6a 32                	push   $0x32
    1dcb:	6a 32                	push   $0x32
    1dcd:	6a 00                	push   $0x0
    1dcf:	6a 00                	push   $0x0
    1dd1:	53                   	push   %ebx
    1dd2:	51                   	push   %ecx
    1dd3:	ff 75 94             	pushl  -0x6c(%ebp)
    1dd6:	57                   	push   %edi
    1dd7:	e8 0f f4 ff ff       	call   11eb <APDcCopy>
    1ddc:	83 c4 30             	add    $0x30,%esp
                    break;
    1ddf:	eb 01                	jmp    1de2 <APGridPaint+0x639>
                default: break;
    1de1:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1de2:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1de6:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1dea:	0f 8e 7a fc ff ff    	jle    1a6a <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1df0:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1df4:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1df8:	0f 8e 60 fc ff ff    	jle    1a5e <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1dfe:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e01:	68 cd 00 00 00       	push   $0xcd
    1e06:	6a 74                	push   $0x74
    1e08:	6a 18                	push   $0x18
    1e0a:	50                   	push   %eax
    1e0b:	e8 7f f5 ff ff       	call   138f <RGB>
    1e10:	83 c4 0c             	add    $0xc,%esp
    1e13:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e17:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1e1b:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e1f:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1e22:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1e29:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e2c:	68 cd 00 00 00       	push   $0xcd
    1e31:	6a 74                	push   $0x74
    1e33:	6a 18                	push   $0x18
    1e35:	50                   	push   %eax
    1e36:	e8 54 f5 ff ff       	call   138f <RGB>
    1e3b:	83 c4 0c             	add    $0xc,%esp
    1e3e:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e42:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1e46:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e4a:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1e4d:	8b 45 08             	mov    0x8(%ebp),%eax
    1e50:	8d 50 58             	lea    0x58(%eax),%edx
    1e53:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e56:	ff 75 bc             	pushl  -0x44(%ebp)
    1e59:	ff 75 b8             	pushl  -0x48(%ebp)
    1e5c:	52                   	push   %edx
    1e5d:	50                   	push   %eax
    1e5e:	e8 5c ed ff ff       	call   bbf <APSetPen>
    1e63:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1e66:	8b 45 08             	mov    0x8(%ebp),%eax
    1e69:	8d 58 58             	lea    0x58(%eax),%ebx
    1e6c:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e6f:	83 ec 04             	sub    $0x4,%esp
    1e72:	83 ec 04             	sub    $0x4,%esp
    1e75:	89 e0                	mov    %esp,%eax
    1e77:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1e7b:	66 89 08             	mov    %cx,(%eax)
    1e7e:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1e82:	88 48 02             	mov    %cl,0x2(%eax)
    1e85:	53                   	push   %ebx
    1e86:	52                   	push   %edx
    1e87:	e8 6c ed ff ff       	call   bf8 <APSetBrush>
    1e8c:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1e8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e92:	83 c0 58             	add    $0x58,%eax
    1e95:	83 ec 0c             	sub    $0xc,%esp
    1e98:	6a 32                	push   $0x32
    1e9a:	68 20 03 00 00       	push   $0x320
    1e9f:	6a 00                	push   $0x0
    1ea1:	6a 00                	push   $0x0
    1ea3:	50                   	push   %eax
    1ea4:	e8 37 f1 ff ff       	call   fe0 <APDrawRect>
    1ea9:	83 c4 20             	add    $0x20,%esp
}
    1eac:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1eaf:	5b                   	pop    %ebx
    1eb0:	5e                   	pop    %esi
    1eb1:	5f                   	pop    %edi
    1eb2:	5d                   	pop    %ebp
    1eb3:	c3                   	ret    

00001eb4 <random>:
//

#include "APLib.h"

int random(int seed)
{
    1eb4:	55                   	push   %ebp
    1eb5:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1eb7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1ebb:	7e 08                	jle    1ec5 <random+0x11>
{
rand_num = seed;
    1ebd:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec0:	a3 3c 29 00 00       	mov    %eax,0x293c
}
rand_num *= 3;
    1ec5:	8b 15 3c 29 00 00    	mov    0x293c,%edx
    1ecb:	89 d0                	mov    %edx,%eax
    1ecd:	01 c0                	add    %eax,%eax
    1ecf:	01 d0                	add    %edx,%eax
    1ed1:	a3 3c 29 00 00       	mov    %eax,0x293c
if (rand_num < 0)
    1ed6:	a1 3c 29 00 00       	mov    0x293c,%eax
    1edb:	85 c0                	test   %eax,%eax
    1edd:	79 0c                	jns    1eeb <random+0x37>
{
rand_num *= (-1);
    1edf:	a1 3c 29 00 00       	mov    0x293c,%eax
    1ee4:	f7 d8                	neg    %eax
    1ee6:	a3 3c 29 00 00       	mov    %eax,0x293c
}
return rand_num % 997;
    1eeb:	8b 0d 3c 29 00 00    	mov    0x293c,%ecx
    1ef1:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1ef6:	89 c8                	mov    %ecx,%eax
    1ef8:	f7 ea                	imul   %edx
    1efa:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1efd:	c1 f8 09             	sar    $0x9,%eax
    1f00:	89 c2                	mov    %eax,%edx
    1f02:	89 c8                	mov    %ecx,%eax
    1f04:	c1 f8 1f             	sar    $0x1f,%eax
    1f07:	29 c2                	sub    %eax,%edx
    1f09:	89 d0                	mov    %edx,%eax
    1f0b:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1f11:	29 c1                	sub    %eax,%ecx
    1f13:	89 c8                	mov    %ecx,%eax
}
    1f15:	5d                   	pop    %ebp
    1f16:	c3                   	ret    

00001f17 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1f17:	55                   	push   %ebp
    1f18:	89 e5                	mov    %esp,%ebp
    1f1a:	53                   	push   %ebx
    1f1b:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1f1e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1f25:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1f29:	74 17                	je     1f42 <sprintint+0x2b>
    1f2b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1f2f:	79 11                	jns    1f42 <sprintint+0x2b>
        neg = 1;
    1f31:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1f38:	8b 45 10             	mov    0x10(%ebp),%eax
    1f3b:	f7 d8                	neg    %eax
    1f3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f40:	eb 06                	jmp    1f48 <sprintint+0x31>
    } else {
        x = xx;
    1f42:	8b 45 10             	mov    0x10(%ebp),%eax
    1f45:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1f48:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1f4f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1f52:	8d 41 01             	lea    0x1(%ecx),%eax
    1f55:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1f58:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f5e:	ba 00 00 00 00       	mov    $0x0,%edx
    1f63:	f7 f3                	div    %ebx
    1f65:	89 d0                	mov    %edx,%eax
    1f67:	0f b6 80 40 29 00 00 	movzbl 0x2940(%eax),%eax
    1f6e:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1f72:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f75:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f78:	ba 00 00 00 00       	mov    $0x0,%edx
    1f7d:	f7 f3                	div    %ebx
    1f7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f82:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f86:	75 c7                	jne    1f4f <sprintint+0x38>
    if(neg)
    1f88:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f8c:	74 0e                	je     1f9c <sprintint+0x85>
        buf[i++] = '-';
    1f8e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f91:	8d 50 01             	lea    0x1(%eax),%edx
    1f94:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1f97:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1f9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f9f:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1fa2:	eb 1b                	jmp    1fbf <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1fa4:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fa7:	8b 00                	mov    (%eax),%eax
    1fa9:	8d 48 01             	lea    0x1(%eax),%ecx
    1fac:	8b 55 0c             	mov    0xc(%ebp),%edx
    1faf:	89 0a                	mov    %ecx,(%edx)
    1fb1:	89 c2                	mov    %eax,%edx
    1fb3:	8b 45 08             	mov    0x8(%ebp),%eax
    1fb6:	01 d0                	add    %edx,%eax
    1fb8:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1fbb:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1fbf:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1fc3:	7f df                	jg     1fa4 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fc5:	eb 21                	jmp    1fe8 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1fc7:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fca:	8b 00                	mov    (%eax),%eax
    1fcc:	8d 48 01             	lea    0x1(%eax),%ecx
    1fcf:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fd2:	89 0a                	mov    %ecx,(%edx)
    1fd4:	89 c2                	mov    %eax,%edx
    1fd6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fd9:	01 c2                	add    %eax,%edx
    1fdb:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1fde:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fe1:	01 c8                	add    %ecx,%eax
    1fe3:	0f b6 00             	movzbl (%eax),%eax
    1fe6:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fe8:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1fec:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1ff0:	79 d5                	jns    1fc7 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1ff2:	90                   	nop
    1ff3:	83 c4 20             	add    $0x20,%esp
    1ff6:	5b                   	pop    %ebx
    1ff7:	5d                   	pop    %ebp
    1ff8:	c3                   	ret    

00001ff9 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1ff9:	55                   	push   %ebp
    1ffa:	89 e5                	mov    %esp,%ebp
    1ffc:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1fff:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2006:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    200d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2014:	8d 45 0c             	lea    0xc(%ebp),%eax
    2017:	83 c0 04             	add    $0x4,%eax
    201a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    201d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2024:	e9 d9 01 00 00       	jmp    2202 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2029:	8b 55 0c             	mov    0xc(%ebp),%edx
    202c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    202f:	01 d0                	add    %edx,%eax
    2031:	0f b6 00             	movzbl (%eax),%eax
    2034:	0f be c0             	movsbl %al,%eax
    2037:	25 ff 00 00 00       	and    $0xff,%eax
    203c:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    203f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2043:	75 2c                	jne    2071 <sprintf+0x78>
            if(c == '%'){
    2045:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2049:	75 0c                	jne    2057 <sprintf+0x5e>
                state = '%';
    204b:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2052:	e9 a7 01 00 00       	jmp    21fe <sprintf+0x205>
            } else {
                dst[j++] = c;
    2057:	8b 45 c8             	mov    -0x38(%ebp),%eax
    205a:	8d 50 01             	lea    0x1(%eax),%edx
    205d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2060:	89 c2                	mov    %eax,%edx
    2062:	8b 45 08             	mov    0x8(%ebp),%eax
    2065:	01 d0                	add    %edx,%eax
    2067:	8b 55 e0             	mov    -0x20(%ebp),%edx
    206a:	88 10                	mov    %dl,(%eax)
    206c:	e9 8d 01 00 00       	jmp    21fe <sprintf+0x205>
            }
        } else if(state == '%'){
    2071:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2075:	0f 85 83 01 00 00    	jne    21fe <sprintf+0x205>
            if(c == 'd'){
    207b:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    207f:	75 4c                	jne    20cd <sprintf+0xd4>
                buf[bi] = '\0';
    2081:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2084:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2087:	01 d0                	add    %edx,%eax
    2089:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    208c:	83 ec 0c             	sub    $0xc,%esp
    208f:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2092:	50                   	push   %eax
    2093:	e8 a1 e1 ff ff       	call   239 <atoi>
    2098:	83 c4 10             	add    $0x10,%esp
    209b:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    209e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    20a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20a8:	8b 00                	mov    (%eax),%eax
    20aa:	83 ec 08             	sub    $0x8,%esp
    20ad:	ff 75 d8             	pushl  -0x28(%ebp)
    20b0:	6a 01                	push   $0x1
    20b2:	6a 0a                	push   $0xa
    20b4:	50                   	push   %eax
    20b5:	8d 45 c8             	lea    -0x38(%ebp),%eax
    20b8:	50                   	push   %eax
    20b9:	ff 75 08             	pushl  0x8(%ebp)
    20bc:	e8 56 fe ff ff       	call   1f17 <sprintint>
    20c1:	83 c4 20             	add    $0x20,%esp
                ap++;
    20c4:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    20c8:	e9 2a 01 00 00       	jmp    21f7 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    20cd:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    20d1:	74 06                	je     20d9 <sprintf+0xe0>
    20d3:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    20d7:	75 4c                	jne    2125 <sprintf+0x12c>
                buf[bi] = '\0';
    20d9:	8d 55 ce             	lea    -0x32(%ebp),%edx
    20dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20df:	01 d0                	add    %edx,%eax
    20e1:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    20e4:	83 ec 0c             	sub    $0xc,%esp
    20e7:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20ea:	50                   	push   %eax
    20eb:	e8 49 e1 ff ff       	call   239 <atoi>
    20f0:	83 c4 10             	add    $0x10,%esp
    20f3:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    20f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    20fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2100:	8b 00                	mov    (%eax),%eax
    2102:	83 ec 08             	sub    $0x8,%esp
    2105:	ff 75 dc             	pushl  -0x24(%ebp)
    2108:	6a 00                	push   $0x0
    210a:	6a 10                	push   $0x10
    210c:	50                   	push   %eax
    210d:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2110:	50                   	push   %eax
    2111:	ff 75 08             	pushl  0x8(%ebp)
    2114:	e8 fe fd ff ff       	call   1f17 <sprintint>
    2119:	83 c4 20             	add    $0x20,%esp
                ap++;
    211c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2120:	e9 d2 00 00 00       	jmp    21f7 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2125:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2129:	75 46                	jne    2171 <sprintf+0x178>
                s = (char*)*ap;
    212b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    212e:	8b 00                	mov    (%eax),%eax
    2130:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2133:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2137:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    213b:	75 25                	jne    2162 <sprintf+0x169>
                    s = "(null)";
    213d:	c7 45 f4 c8 23 00 00 	movl   $0x23c8,-0xc(%ebp)
                while(*s != 0){
    2144:	eb 1c                	jmp    2162 <sprintf+0x169>
                    dst[j++] = *s;
    2146:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2149:	8d 50 01             	lea    0x1(%eax),%edx
    214c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    214f:	89 c2                	mov    %eax,%edx
    2151:	8b 45 08             	mov    0x8(%ebp),%eax
    2154:	01 c2                	add    %eax,%edx
    2156:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2159:	0f b6 00             	movzbl (%eax),%eax
    215c:	88 02                	mov    %al,(%edx)
                    s++;
    215e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2162:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2165:	0f b6 00             	movzbl (%eax),%eax
    2168:	84 c0                	test   %al,%al
    216a:	75 da                	jne    2146 <sprintf+0x14d>
    216c:	e9 86 00 00 00       	jmp    21f7 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2171:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2175:	75 1d                	jne    2194 <sprintf+0x19b>
                dst[j++] = *ap;
    2177:	8b 45 c8             	mov    -0x38(%ebp),%eax
    217a:	8d 50 01             	lea    0x1(%eax),%edx
    217d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2180:	89 c2                	mov    %eax,%edx
    2182:	8b 45 08             	mov    0x8(%ebp),%eax
    2185:	01 c2                	add    %eax,%edx
    2187:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    218a:	8b 00                	mov    (%eax),%eax
    218c:	88 02                	mov    %al,(%edx)
                ap++;
    218e:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2192:	eb 63                	jmp    21f7 <sprintf+0x1fe>
            } else if(c == '%'){
    2194:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2198:	75 17                	jne    21b1 <sprintf+0x1b8>
                dst[j++] = c;
    219a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    219d:	8d 50 01             	lea    0x1(%eax),%edx
    21a0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21a3:	89 c2                	mov    %eax,%edx
    21a5:	8b 45 08             	mov    0x8(%ebp),%eax
    21a8:	01 d0                	add    %edx,%eax
    21aa:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21ad:	88 10                	mov    %dl,(%eax)
    21af:	eb 46                	jmp    21f7 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    21b1:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    21b5:	7e 18                	jle    21cf <sprintf+0x1d6>
    21b7:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    21bb:	7f 12                	jg     21cf <sprintf+0x1d6>
            {
                buf[bi++] = c;
    21bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21c0:	8d 50 01             	lea    0x1(%eax),%edx
    21c3:	89 55 f0             	mov    %edx,-0x10(%ebp)
    21c6:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21c9:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    21cd:	eb 2f                	jmp    21fe <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    21cf:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21d2:	8d 50 01             	lea    0x1(%eax),%edx
    21d5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21d8:	89 c2                	mov    %eax,%edx
    21da:	8b 45 08             	mov    0x8(%ebp),%eax
    21dd:	01 d0                	add    %edx,%eax
    21df:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    21e2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21e5:	8d 50 01             	lea    0x1(%eax),%edx
    21e8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21eb:	89 c2                	mov    %eax,%edx
    21ed:	8b 45 08             	mov    0x8(%ebp),%eax
    21f0:	01 d0                	add    %edx,%eax
    21f2:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21f5:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    21f7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    21fe:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2202:	8b 55 0c             	mov    0xc(%ebp),%edx
    2205:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2208:	01 d0                	add    %edx,%eax
    220a:	0f b6 00             	movzbl (%eax),%eax
    220d:	84 c0                	test   %al,%al
    220f:	0f 85 14 fe ff ff    	jne    2029 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2215:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2218:	8d 50 01             	lea    0x1(%eax),%edx
    221b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    221e:	89 c2                	mov    %eax,%edx
    2220:	8b 45 08             	mov    0x8(%ebp),%eax
    2223:	01 d0                	add    %edx,%eax
    2225:	c6 00 00             	movb   $0x0,(%eax)
}
    2228:	90                   	nop
    2229:	c9                   	leave  
    222a:	c3                   	ret    
