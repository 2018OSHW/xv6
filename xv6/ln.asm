
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
      19:	68 18 21 00 00       	push   $0x2118
      1e:	6a 02                	push   $0x2
      20:	e8 4d 04 00 00       	call   472 <printf>
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
      60:	68 2b 21 00 00       	push   $0x212b
      65:	6a 02                	push   $0x2
      67:	e8 06 04 00 00       	call   472 <printf>
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

00000373 <initStringFigure>:
SYSCALL(initStringFigure)
     373:	b8 17 00 00 00       	mov    $0x17,%eax
     378:	cd 40                	int    $0x40
     37a:	c3                   	ret    

0000037b <sendMessage>:
SYSCALL(sendMessage)
     37b:	b8 18 00 00 00       	mov    $0x18,%eax
     380:	cd 40                	int    $0x40
     382:	c3                   	ret    

00000383 <getMessage>:
SYSCALL(getMessage)
     383:	b8 1a 00 00 00       	mov    $0x1a,%eax
     388:	cd 40                	int    $0x40
     38a:	c3                   	ret    

0000038b <registWindow>:
SYSCALL(registWindow)
     38b:	b8 19 00 00 00       	mov    $0x19,%eax
     390:	cd 40                	int    $0x40
     392:	c3                   	ret    

00000393 <changePosition>:
SYSCALL(changePosition)
     393:	b8 1b 00 00 00       	mov    $0x1b,%eax
     398:	cd 40                	int    $0x40
     39a:	c3                   	ret    

0000039b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     39b:	55                   	push   %ebp
     39c:	89 e5                	mov    %esp,%ebp
     39e:	83 ec 18             	sub    $0x18,%esp
     3a1:	8b 45 0c             	mov    0xc(%ebp),%eax
     3a4:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3a7:	83 ec 04             	sub    $0x4,%esp
     3aa:	6a 01                	push   $0x1
     3ac:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3af:	50                   	push   %eax
     3b0:	ff 75 08             	pushl  0x8(%ebp)
     3b3:	e8 33 ff ff ff       	call   2eb <write>
     3b8:	83 c4 10             	add    $0x10,%esp
}
     3bb:	90                   	nop
     3bc:	c9                   	leave  
     3bd:	c3                   	ret    

000003be <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3be:	55                   	push   %ebp
     3bf:	89 e5                	mov    %esp,%ebp
     3c1:	53                   	push   %ebx
     3c2:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3c5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3cc:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3d0:	74 17                	je     3e9 <printint+0x2b>
     3d2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3d6:	79 11                	jns    3e9 <printint+0x2b>
    neg = 1;
     3d8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3df:	8b 45 0c             	mov    0xc(%ebp),%eax
     3e2:	f7 d8                	neg    %eax
     3e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3e7:	eb 06                	jmp    3ef <printint+0x31>
  } else {
    x = xx;
     3e9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ec:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3ef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3f6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3f9:	8d 41 01             	lea    0x1(%ecx),%eax
     3fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3ff:	8b 5d 10             	mov    0x10(%ebp),%ebx
     402:	8b 45 ec             	mov    -0x14(%ebp),%eax
     405:	ba 00 00 00 00       	mov    $0x0,%edx
     40a:	f7 f3                	div    %ebx
     40c:	89 d0                	mov    %edx,%eax
     40e:	0f b6 80 ec 27 00 00 	movzbl 0x27ec(%eax),%eax
     415:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     419:	8b 5d 10             	mov    0x10(%ebp),%ebx
     41c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     41f:	ba 00 00 00 00       	mov    $0x0,%edx
     424:	f7 f3                	div    %ebx
     426:	89 45 ec             	mov    %eax,-0x14(%ebp)
     429:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     42d:	75 c7                	jne    3f6 <printint+0x38>
  if(neg)
     42f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     433:	74 2d                	je     462 <printint+0xa4>
    buf[i++] = '-';
     435:	8b 45 f4             	mov    -0xc(%ebp),%eax
     438:	8d 50 01             	lea    0x1(%eax),%edx
     43b:	89 55 f4             	mov    %edx,-0xc(%ebp)
     43e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     443:	eb 1d                	jmp    462 <printint+0xa4>
    putc(fd, buf[i]);
     445:	8d 55 dc             	lea    -0x24(%ebp),%edx
     448:	8b 45 f4             	mov    -0xc(%ebp),%eax
     44b:	01 d0                	add    %edx,%eax
     44d:	0f b6 00             	movzbl (%eax),%eax
     450:	0f be c0             	movsbl %al,%eax
     453:	83 ec 08             	sub    $0x8,%esp
     456:	50                   	push   %eax
     457:	ff 75 08             	pushl  0x8(%ebp)
     45a:	e8 3c ff ff ff       	call   39b <putc>
     45f:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     462:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     466:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     46a:	79 d9                	jns    445 <printint+0x87>
    putc(fd, buf[i]);
}
     46c:	90                   	nop
     46d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     470:	c9                   	leave  
     471:	c3                   	ret    

00000472 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     472:	55                   	push   %ebp
     473:	89 e5                	mov    %esp,%ebp
     475:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     478:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     47f:	8d 45 0c             	lea    0xc(%ebp),%eax
     482:	83 c0 04             	add    $0x4,%eax
     485:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     488:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     48f:	e9 59 01 00 00       	jmp    5ed <printf+0x17b>
    c = fmt[i] & 0xff;
     494:	8b 55 0c             	mov    0xc(%ebp),%edx
     497:	8b 45 f0             	mov    -0x10(%ebp),%eax
     49a:	01 d0                	add    %edx,%eax
     49c:	0f b6 00             	movzbl (%eax),%eax
     49f:	0f be c0             	movsbl %al,%eax
     4a2:	25 ff 00 00 00       	and    $0xff,%eax
     4a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4aa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4ae:	75 2c                	jne    4dc <printf+0x6a>
      if(c == '%'){
     4b0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4b4:	75 0c                	jne    4c2 <printf+0x50>
        state = '%';
     4b6:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4bd:	e9 27 01 00 00       	jmp    5e9 <printf+0x177>
      } else {
        putc(fd, c);
     4c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4c5:	0f be c0             	movsbl %al,%eax
     4c8:	83 ec 08             	sub    $0x8,%esp
     4cb:	50                   	push   %eax
     4cc:	ff 75 08             	pushl  0x8(%ebp)
     4cf:	e8 c7 fe ff ff       	call   39b <putc>
     4d4:	83 c4 10             	add    $0x10,%esp
     4d7:	e9 0d 01 00 00       	jmp    5e9 <printf+0x177>
      }
    } else if(state == '%'){
     4dc:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4e0:	0f 85 03 01 00 00    	jne    5e9 <printf+0x177>
      if(c == 'd'){
     4e6:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4ea:	75 1e                	jne    50a <printf+0x98>
        printint(fd, *ap, 10, 1);
     4ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4ef:	8b 00                	mov    (%eax),%eax
     4f1:	6a 01                	push   $0x1
     4f3:	6a 0a                	push   $0xa
     4f5:	50                   	push   %eax
     4f6:	ff 75 08             	pushl  0x8(%ebp)
     4f9:	e8 c0 fe ff ff       	call   3be <printint>
     4fe:	83 c4 10             	add    $0x10,%esp
        ap++;
     501:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     505:	e9 d8 00 00 00       	jmp    5e2 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     50a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     50e:	74 06                	je     516 <printf+0xa4>
     510:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     514:	75 1e                	jne    534 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     516:	8b 45 e8             	mov    -0x18(%ebp),%eax
     519:	8b 00                	mov    (%eax),%eax
     51b:	6a 00                	push   $0x0
     51d:	6a 10                	push   $0x10
     51f:	50                   	push   %eax
     520:	ff 75 08             	pushl  0x8(%ebp)
     523:	e8 96 fe ff ff       	call   3be <printint>
     528:	83 c4 10             	add    $0x10,%esp
        ap++;
     52b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     52f:	e9 ae 00 00 00       	jmp    5e2 <printf+0x170>
      } else if(c == 's'){
     534:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     538:	75 43                	jne    57d <printf+0x10b>
        s = (char*)*ap;
     53a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     53d:	8b 00                	mov    (%eax),%eax
     53f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     542:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     546:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     54a:	75 25                	jne    571 <printf+0xff>
          s = "(null)";
     54c:	c7 45 f4 3f 21 00 00 	movl   $0x213f,-0xc(%ebp)
        while(*s != 0){
     553:	eb 1c                	jmp    571 <printf+0xff>
          putc(fd, *s);
     555:	8b 45 f4             	mov    -0xc(%ebp),%eax
     558:	0f b6 00             	movzbl (%eax),%eax
     55b:	0f be c0             	movsbl %al,%eax
     55e:	83 ec 08             	sub    $0x8,%esp
     561:	50                   	push   %eax
     562:	ff 75 08             	pushl  0x8(%ebp)
     565:	e8 31 fe ff ff       	call   39b <putc>
     56a:	83 c4 10             	add    $0x10,%esp
          s++;
     56d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     571:	8b 45 f4             	mov    -0xc(%ebp),%eax
     574:	0f b6 00             	movzbl (%eax),%eax
     577:	84 c0                	test   %al,%al
     579:	75 da                	jne    555 <printf+0xe3>
     57b:	eb 65                	jmp    5e2 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     57d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     581:	75 1d                	jne    5a0 <printf+0x12e>
        putc(fd, *ap);
     583:	8b 45 e8             	mov    -0x18(%ebp),%eax
     586:	8b 00                	mov    (%eax),%eax
     588:	0f be c0             	movsbl %al,%eax
     58b:	83 ec 08             	sub    $0x8,%esp
     58e:	50                   	push   %eax
     58f:	ff 75 08             	pushl  0x8(%ebp)
     592:	e8 04 fe ff ff       	call   39b <putc>
     597:	83 c4 10             	add    $0x10,%esp
        ap++;
     59a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     59e:	eb 42                	jmp    5e2 <printf+0x170>
      } else if(c == '%'){
     5a0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5a4:	75 17                	jne    5bd <printf+0x14b>
        putc(fd, c);
     5a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5a9:	0f be c0             	movsbl %al,%eax
     5ac:	83 ec 08             	sub    $0x8,%esp
     5af:	50                   	push   %eax
     5b0:	ff 75 08             	pushl  0x8(%ebp)
     5b3:	e8 e3 fd ff ff       	call   39b <putc>
     5b8:	83 c4 10             	add    $0x10,%esp
     5bb:	eb 25                	jmp    5e2 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5bd:	83 ec 08             	sub    $0x8,%esp
     5c0:	6a 25                	push   $0x25
     5c2:	ff 75 08             	pushl  0x8(%ebp)
     5c5:	e8 d1 fd ff ff       	call   39b <putc>
     5ca:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5d0:	0f be c0             	movsbl %al,%eax
     5d3:	83 ec 08             	sub    $0x8,%esp
     5d6:	50                   	push   %eax
     5d7:	ff 75 08             	pushl  0x8(%ebp)
     5da:	e8 bc fd ff ff       	call   39b <putc>
     5df:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5e2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5e9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5ed:	8b 55 0c             	mov    0xc(%ebp),%edx
     5f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5f3:	01 d0                	add    %edx,%eax
     5f5:	0f b6 00             	movzbl (%eax),%eax
     5f8:	84 c0                	test   %al,%al
     5fa:	0f 85 94 fe ff ff    	jne    494 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     600:	90                   	nop
     601:	c9                   	leave  
     602:	c3                   	ret    

00000603 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     603:	55                   	push   %ebp
     604:	89 e5                	mov    %esp,%ebp
     606:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     609:	8b 45 08             	mov    0x8(%ebp),%eax
     60c:	83 e8 08             	sub    $0x8,%eax
     60f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     612:	a1 20 28 00 00       	mov    0x2820,%eax
     617:	89 45 fc             	mov    %eax,-0x4(%ebp)
     61a:	eb 24                	jmp    640 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     61c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     61f:	8b 00                	mov    (%eax),%eax
     621:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     624:	77 12                	ja     638 <free+0x35>
     626:	8b 45 f8             	mov    -0x8(%ebp),%eax
     629:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     62c:	77 24                	ja     652 <free+0x4f>
     62e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     631:	8b 00                	mov    (%eax),%eax
     633:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     636:	77 1a                	ja     652 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     638:	8b 45 fc             	mov    -0x4(%ebp),%eax
     63b:	8b 00                	mov    (%eax),%eax
     63d:	89 45 fc             	mov    %eax,-0x4(%ebp)
     640:	8b 45 f8             	mov    -0x8(%ebp),%eax
     643:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     646:	76 d4                	jbe    61c <free+0x19>
     648:	8b 45 fc             	mov    -0x4(%ebp),%eax
     64b:	8b 00                	mov    (%eax),%eax
     64d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     650:	76 ca                	jbe    61c <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     652:	8b 45 f8             	mov    -0x8(%ebp),%eax
     655:	8b 40 04             	mov    0x4(%eax),%eax
     658:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     65f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     662:	01 c2                	add    %eax,%edx
     664:	8b 45 fc             	mov    -0x4(%ebp),%eax
     667:	8b 00                	mov    (%eax),%eax
     669:	39 c2                	cmp    %eax,%edx
     66b:	75 24                	jne    691 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     66d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     670:	8b 50 04             	mov    0x4(%eax),%edx
     673:	8b 45 fc             	mov    -0x4(%ebp),%eax
     676:	8b 00                	mov    (%eax),%eax
     678:	8b 40 04             	mov    0x4(%eax),%eax
     67b:	01 c2                	add    %eax,%edx
     67d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     680:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     683:	8b 45 fc             	mov    -0x4(%ebp),%eax
     686:	8b 00                	mov    (%eax),%eax
     688:	8b 10                	mov    (%eax),%edx
     68a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     68d:	89 10                	mov    %edx,(%eax)
     68f:	eb 0a                	jmp    69b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     691:	8b 45 fc             	mov    -0x4(%ebp),%eax
     694:	8b 10                	mov    (%eax),%edx
     696:	8b 45 f8             	mov    -0x8(%ebp),%eax
     699:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69e:	8b 40 04             	mov    0x4(%eax),%eax
     6a1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ab:	01 d0                	add    %edx,%eax
     6ad:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6b0:	75 20                	jne    6d2 <free+0xcf>
    p->s.size += bp->s.size;
     6b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b5:	8b 50 04             	mov    0x4(%eax),%edx
     6b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6bb:	8b 40 04             	mov    0x4(%eax),%eax
     6be:	01 c2                	add    %eax,%edx
     6c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c9:	8b 10                	mov    (%eax),%edx
     6cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ce:	89 10                	mov    %edx,(%eax)
     6d0:	eb 08                	jmp    6da <free+0xd7>
  } else
    p->s.ptr = bp;
     6d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d5:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6d8:	89 10                	mov    %edx,(%eax)
  freep = p;
     6da:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6dd:	a3 20 28 00 00       	mov    %eax,0x2820
}
     6e2:	90                   	nop
     6e3:	c9                   	leave  
     6e4:	c3                   	ret    

000006e5 <morecore>:

static Header*
morecore(uint nu)
{
     6e5:	55                   	push   %ebp
     6e6:	89 e5                	mov    %esp,%ebp
     6e8:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6eb:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6f2:	77 07                	ja     6fb <morecore+0x16>
    nu = 4096;
     6f4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     6fb:	8b 45 08             	mov    0x8(%ebp),%eax
     6fe:	c1 e0 03             	shl    $0x3,%eax
     701:	83 ec 0c             	sub    $0xc,%esp
     704:	50                   	push   %eax
     705:	e8 49 fc ff ff       	call   353 <sbrk>
     70a:	83 c4 10             	add    $0x10,%esp
     70d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     710:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     714:	75 07                	jne    71d <morecore+0x38>
    return 0;
     716:	b8 00 00 00 00       	mov    $0x0,%eax
     71b:	eb 26                	jmp    743 <morecore+0x5e>
  hp = (Header*)p;
     71d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     720:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     723:	8b 45 f0             	mov    -0x10(%ebp),%eax
     726:	8b 55 08             	mov    0x8(%ebp),%edx
     729:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     72c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     72f:	83 c0 08             	add    $0x8,%eax
     732:	83 ec 0c             	sub    $0xc,%esp
     735:	50                   	push   %eax
     736:	e8 c8 fe ff ff       	call   603 <free>
     73b:	83 c4 10             	add    $0x10,%esp
  return freep;
     73e:	a1 20 28 00 00       	mov    0x2820,%eax
}
     743:	c9                   	leave  
     744:	c3                   	ret    

00000745 <malloc>:

void*
malloc(uint nbytes)
{
     745:	55                   	push   %ebp
     746:	89 e5                	mov    %esp,%ebp
     748:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     74b:	8b 45 08             	mov    0x8(%ebp),%eax
     74e:	83 c0 07             	add    $0x7,%eax
     751:	c1 e8 03             	shr    $0x3,%eax
     754:	83 c0 01             	add    $0x1,%eax
     757:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     75a:	a1 20 28 00 00       	mov    0x2820,%eax
     75f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     762:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     766:	75 23                	jne    78b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     768:	c7 45 f0 18 28 00 00 	movl   $0x2818,-0x10(%ebp)
     76f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     772:	a3 20 28 00 00       	mov    %eax,0x2820
     777:	a1 20 28 00 00       	mov    0x2820,%eax
     77c:	a3 18 28 00 00       	mov    %eax,0x2818
    base.s.size = 0;
     781:	c7 05 1c 28 00 00 00 	movl   $0x0,0x281c
     788:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     78b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     78e:	8b 00                	mov    (%eax),%eax
     790:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     793:	8b 45 f4             	mov    -0xc(%ebp),%eax
     796:	8b 40 04             	mov    0x4(%eax),%eax
     799:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     79c:	72 4d                	jb     7eb <malloc+0xa6>
      if(p->s.size == nunits)
     79e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a1:	8b 40 04             	mov    0x4(%eax),%eax
     7a4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7a7:	75 0c                	jne    7b5 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ac:	8b 10                	mov    (%eax),%edx
     7ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7b1:	89 10                	mov    %edx,(%eax)
     7b3:	eb 26                	jmp    7db <malloc+0x96>
      else {
        p->s.size -= nunits;
     7b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b8:	8b 40 04             	mov    0x4(%eax),%eax
     7bb:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7be:	89 c2                	mov    %eax,%edx
     7c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c9:	8b 40 04             	mov    0x4(%eax),%eax
     7cc:	c1 e0 03             	shl    $0x3,%eax
     7cf:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d5:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7d8:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7db:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7de:	a3 20 28 00 00       	mov    %eax,0x2820
      return (void*)(p + 1);
     7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e6:	83 c0 08             	add    $0x8,%eax
     7e9:	eb 3b                	jmp    826 <malloc+0xe1>
    }
    if(p == freep)
     7eb:	a1 20 28 00 00       	mov    0x2820,%eax
     7f0:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7f3:	75 1e                	jne    813 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7f5:	83 ec 0c             	sub    $0xc,%esp
     7f8:	ff 75 ec             	pushl  -0x14(%ebp)
     7fb:	e8 e5 fe ff ff       	call   6e5 <morecore>
     800:	83 c4 10             	add    $0x10,%esp
     803:	89 45 f4             	mov    %eax,-0xc(%ebp)
     806:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     80a:	75 07                	jne    813 <malloc+0xce>
        return 0;
     80c:	b8 00 00 00 00       	mov    $0x0,%eax
     811:	eb 13                	jmp    826 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     813:	8b 45 f4             	mov    -0xc(%ebp),%eax
     816:	89 45 f0             	mov    %eax,-0x10(%ebp)
     819:	8b 45 f4             	mov    -0xc(%ebp),%eax
     81c:	8b 00                	mov    (%eax),%eax
     81e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     821:	e9 6d ff ff ff       	jmp    793 <malloc+0x4e>
}
     826:	c9                   	leave  
     827:	c3                   	ret    

00000828 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     828:	55                   	push   %ebp
     829:	89 e5                	mov    %esp,%ebp
     82b:	83 ec 1c             	sub    $0x1c,%esp
     82e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     831:	8b 55 10             	mov    0x10(%ebp),%edx
     834:	8b 45 14             	mov    0x14(%ebp),%eax
     837:	88 4d ec             	mov    %cl,-0x14(%ebp)
     83a:	88 55 e8             	mov    %dl,-0x18(%ebp)
     83d:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     840:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     844:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     847:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     84b:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     84e:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     852:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     855:	8b 45 08             	mov    0x8(%ebp),%eax
     858:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     85c:	66 89 10             	mov    %dx,(%eax)
     85f:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     863:	88 50 02             	mov    %dl,0x2(%eax)
}
     866:	8b 45 08             	mov    0x8(%ebp),%eax
     869:	c9                   	leave  
     86a:	c2 04 00             	ret    $0x4

0000086d <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     86d:	55                   	push   %ebp
     86e:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     870:	8b 45 08             	mov    0x8(%ebp),%eax
     873:	2b 45 10             	sub    0x10(%ebp),%eax
     876:	89 c2                	mov    %eax,%edx
     878:	8b 45 08             	mov    0x8(%ebp),%eax
     87b:	2b 45 10             	sub    0x10(%ebp),%eax
     87e:	0f af d0             	imul   %eax,%edx
     881:	8b 45 0c             	mov    0xc(%ebp),%eax
     884:	2b 45 14             	sub    0x14(%ebp),%eax
     887:	89 c1                	mov    %eax,%ecx
     889:	8b 45 0c             	mov    0xc(%ebp),%eax
     88c:	2b 45 14             	sub    0x14(%ebp),%eax
     88f:	0f af c1             	imul   %ecx,%eax
     892:	01 d0                	add    %edx,%eax
}
     894:	5d                   	pop    %ebp
     895:	c3                   	ret    

00000896 <abs_int>:

static inline int abs_int(int x)
{
     896:	55                   	push   %ebp
     897:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     899:	8b 45 08             	mov    0x8(%ebp),%eax
     89c:	99                   	cltd   
     89d:	89 d0                	mov    %edx,%eax
     89f:	33 45 08             	xor    0x8(%ebp),%eax
     8a2:	29 d0                	sub    %edx,%eax
}
     8a4:	5d                   	pop    %ebp
     8a5:	c3                   	ret    

000008a6 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     8a6:	55                   	push   %ebp
     8a7:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     8a9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8ad:	79 07                	jns    8b6 <APGetIndex+0x10>
        return X_SMALLER;
     8af:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8b4:	eb 40                	jmp    8f6 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8b6:	8b 45 08             	mov    0x8(%ebp),%eax
     8b9:	8b 00                	mov    (%eax),%eax
     8bb:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8be:	7f 07                	jg     8c7 <APGetIndex+0x21>
        return X_BIGGER;
     8c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8c5:	eb 2f                	jmp    8f6 <APGetIndex+0x50>
    if (y < 0)
     8c7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8cb:	79 07                	jns    8d4 <APGetIndex+0x2e>
        return Y_SMALLER;
     8cd:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8d2:	eb 22                	jmp    8f6 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8d4:	8b 45 08             	mov    0x8(%ebp),%eax
     8d7:	8b 40 04             	mov    0x4(%eax),%eax
     8da:	3b 45 10             	cmp    0x10(%ebp),%eax
     8dd:	7f 07                	jg     8e6 <APGetIndex+0x40>
        return Y_BIGGER;
     8df:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8e4:	eb 10                	jmp    8f6 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8e6:	8b 45 08             	mov    0x8(%ebp),%eax
     8e9:	8b 00                	mov    (%eax),%eax
     8eb:	0f af 45 10          	imul   0x10(%ebp),%eax
     8ef:	89 c2                	mov    %eax,%edx
     8f1:	8b 45 0c             	mov    0xc(%ebp),%eax
     8f4:	01 d0                	add    %edx,%eax
}
     8f6:	5d                   	pop    %ebp
     8f7:	c3                   	ret    

000008f8 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     8f8:	55                   	push   %ebp
     8f9:	89 e5                	mov    %esp,%ebp
     8fb:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     8fe:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     905:	8b 45 cc             	mov    -0x34(%ebp),%eax
     908:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     90b:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     912:	83 ec 08             	sub    $0x8,%esp
     915:	6a 00                	push   $0x0
     917:	ff 75 0c             	pushl  0xc(%ebp)
     91a:	e8 ec f9 ff ff       	call   30b <open>
     91f:	83 c4 10             	add    $0x10,%esp
     922:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     925:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     929:	79 2e                	jns    959 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     92b:	83 ec 04             	sub    $0x4,%esp
     92e:	ff 75 0c             	pushl  0xc(%ebp)
     931:	68 46 21 00 00       	push   $0x2146
     936:	6a 01                	push   $0x1
     938:	e8 35 fb ff ff       	call   472 <printf>
     93d:	83 c4 10             	add    $0x10,%esp
        return bmp;
     940:	8b 45 08             	mov    0x8(%ebp),%eax
     943:	8b 55 c8             	mov    -0x38(%ebp),%edx
     946:	89 10                	mov    %edx,(%eax)
     948:	8b 55 cc             	mov    -0x34(%ebp),%edx
     94b:	89 50 04             	mov    %edx,0x4(%eax)
     94e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     951:	89 50 08             	mov    %edx,0x8(%eax)
     954:	e9 d2 01 00 00       	jmp    b2b <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     959:	83 ec 04             	sub    $0x4,%esp
     95c:	6a 0e                	push   $0xe
     95e:	8d 45 ba             	lea    -0x46(%ebp),%eax
     961:	50                   	push   %eax
     962:	ff 75 ec             	pushl  -0x14(%ebp)
     965:	e8 79 f9 ff ff       	call   2e3 <read>
     96a:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     96d:	83 ec 04             	sub    $0x4,%esp
     970:	6a 28                	push   $0x28
     972:	8d 45 92             	lea    -0x6e(%ebp),%eax
     975:	50                   	push   %eax
     976:	ff 75 ec             	pushl  -0x14(%ebp)
     979:	e8 65 f9 ff ff       	call   2e3 <read>
     97e:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     981:	8b 45 96             	mov    -0x6a(%ebp),%eax
     984:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     987:	8b 45 9a             	mov    -0x66(%ebp),%eax
     98a:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     98d:	8b 55 c8             	mov    -0x38(%ebp),%edx
     990:	8b 45 cc             	mov    -0x34(%ebp),%eax
     993:	0f af d0             	imul   %eax,%edx
     996:	89 d0                	mov    %edx,%eax
     998:	01 c0                	add    %eax,%eax
     99a:	01 d0                	add    %edx,%eax
     99c:	83 ec 0c             	sub    $0xc,%esp
     99f:	50                   	push   %eax
     9a0:	e8 a0 fd ff ff       	call   745 <malloc>
     9a5:	83 c4 10             	add    $0x10,%esp
     9a8:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9ab:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9af:	0f b7 c0             	movzwl %ax,%eax
     9b2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9b5:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9b8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9bb:	0f af c2             	imul   %edx,%eax
     9be:	83 c0 1f             	add    $0x1f,%eax
     9c1:	c1 e8 05             	shr    $0x5,%eax
     9c4:	c1 e0 02             	shl    $0x2,%eax
     9c7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9ca:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9d0:	0f af c2             	imul   %edx,%eax
     9d3:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9d9:	83 ec 0c             	sub    $0xc,%esp
     9dc:	50                   	push   %eax
     9dd:	e8 63 fd ff ff       	call   745 <malloc>
     9e2:	83 c4 10             	add    $0x10,%esp
     9e5:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9e8:	83 ec 04             	sub    $0x4,%esp
     9eb:	ff 75 e0             	pushl  -0x20(%ebp)
     9ee:	ff 75 dc             	pushl  -0x24(%ebp)
     9f1:	ff 75 ec             	pushl  -0x14(%ebp)
     9f4:	e8 ea f8 ff ff       	call   2e3 <read>
     9f9:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     9fc:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a00:	66 c1 e8 03          	shr    $0x3,%ax
     a04:	0f b7 c0             	movzwl %ax,%eax
     a07:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a0a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a11:	e9 e5 00 00 00       	jmp    afb <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a16:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a19:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a1c:	29 c2                	sub    %eax,%edx
     a1e:	89 d0                	mov    %edx,%eax
     a20:	8d 50 ff             	lea    -0x1(%eax),%edx
     a23:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a26:	0f af c2             	imul   %edx,%eax
     a29:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a2c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a33:	e9 b1 00 00 00       	jmp    ae9 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a38:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a3b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a41:	01 c8                	add    %ecx,%eax
     a43:	89 c1                	mov    %eax,%ecx
     a45:	89 c8                	mov    %ecx,%eax
     a47:	01 c0                	add    %eax,%eax
     a49:	01 c8                	add    %ecx,%eax
     a4b:	01 c2                	add    %eax,%edx
     a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a50:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a54:	89 c1                	mov    %eax,%ecx
     a56:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a59:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a5d:	01 c1                	add    %eax,%ecx
     a5f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a62:	01 c8                	add    %ecx,%eax
     a64:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a67:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a6a:	01 c8                	add    %ecx,%eax
     a6c:	0f b6 00             	movzbl (%eax),%eax
     a6f:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a72:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a75:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a78:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a7b:	01 c8                	add    %ecx,%eax
     a7d:	89 c1                	mov    %eax,%ecx
     a7f:	89 c8                	mov    %ecx,%eax
     a81:	01 c0                	add    %eax,%eax
     a83:	01 c8                	add    %ecx,%eax
     a85:	01 c2                	add    %eax,%edx
     a87:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a8a:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a8e:	89 c1                	mov    %eax,%ecx
     a90:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a93:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a97:	01 c1                	add    %eax,%ecx
     a99:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a9c:	01 c8                	add    %ecx,%eax
     a9e:	8d 48 fe             	lea    -0x2(%eax),%ecx
     aa1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     aa4:	01 c8                	add    %ecx,%eax
     aa6:	0f b6 00             	movzbl (%eax),%eax
     aa9:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     aac:	8b 55 d0             	mov    -0x30(%ebp),%edx
     aaf:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ab2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ab5:	01 c8                	add    %ecx,%eax
     ab7:	89 c1                	mov    %eax,%ecx
     ab9:	89 c8                	mov    %ecx,%eax
     abb:	01 c0                	add    %eax,%eax
     abd:	01 c8                	add    %ecx,%eax
     abf:	01 c2                	add    %eax,%edx
     ac1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac4:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ac8:	89 c1                	mov    %eax,%ecx
     aca:	8b 45 d8             	mov    -0x28(%ebp),%eax
     acd:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ad1:	01 c1                	add    %eax,%ecx
     ad3:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ad6:	01 c8                	add    %ecx,%eax
     ad8:	8d 48 fd             	lea    -0x3(%eax),%ecx
     adb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ade:	01 c8                	add    %ecx,%eax
     ae0:	0f b6 00             	movzbl (%eax),%eax
     ae3:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     ae5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ae9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     aec:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aef:	39 c2                	cmp    %eax,%edx
     af1:	0f 87 41 ff ff ff    	ja     a38 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     af7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     afb:	8b 55 cc             	mov    -0x34(%ebp),%edx
     afe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b01:	39 c2                	cmp    %eax,%edx
     b03:	0f 87 0d ff ff ff    	ja     a16 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b09:	83 ec 0c             	sub    $0xc,%esp
     b0c:	ff 75 ec             	pushl  -0x14(%ebp)
     b0f:	e8 df f7 ff ff       	call   2f3 <close>
     b14:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b17:	8b 45 08             	mov    0x8(%ebp),%eax
     b1a:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b1d:	89 10                	mov    %edx,(%eax)
     b1f:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b22:	89 50 04             	mov    %edx,0x4(%eax)
     b25:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b28:	89 50 08             	mov    %edx,0x8(%eax)
}
     b2b:	8b 45 08             	mov    0x8(%ebp),%eax
     b2e:	c9                   	leave  
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
     b3e:	e8 02 fc ff ff       	call   745 <malloc>
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
     b60:	e8 c3 fc ff ff       	call   828 <RGB>
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
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
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
     ca4:	e8 fd fb ff ff       	call   8a6 <APGetIndex>
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
     cc7:	e8 a1 fb ff ff       	call   86d <distance_2>
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
     e54:	e8 3d fa ff ff       	call   896 <abs_int>
     e59:	83 c4 04             	add    $0x4,%esp
     e5c:	89 c3                	mov    %eax,%ebx
     e5e:	8b 45 10             	mov    0x10(%ebp),%eax
     e61:	2b 45 18             	sub    0x18(%ebp),%eax
     e64:	50                   	push   %eax
     e65:	e8 2c fa ff ff       	call   896 <abs_int>
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
    119f:	e8 02 f7 ff ff       	call   8a6 <APGetIndex>
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
    int x_r = x + w , y_r = y + h ;
    121d:	8b 55 18             	mov    0x18(%ebp),%edx
    1220:	8b 45 20             	mov    0x20(%ebp),%eax
    1223:	01 d0                	add    %edx,%eax
    1225:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1228:	8b 55 1c             	mov    0x1c(%ebp),%edx
    122b:	8b 45 24             	mov    0x24(%ebp),%eax
    122e:	01 d0                	add    %edx,%eax
    1230:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
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
    1263:	0f 8c 25 01 00 00    	jl     138e <APDcCopy+0x1a1>
    1269:	8b 45 14             	mov    0x14(%ebp),%eax
    126c:	8b 40 04             	mov    0x4(%eax),%eax
    126f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1272:	0f 8c 16 01 00 00    	jl     138e <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1278:	8b 45 08             	mov    0x8(%ebp),%eax
    127b:	8b 00                	mov    (%eax),%eax
    127d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1280:	7f 0b                	jg     128d <APDcCopy+0xa0>
    1282:	8b 45 08             	mov    0x8(%ebp),%eax
    1285:	8b 00                	mov    (%eax),%eax
    1287:	83 e8 01             	sub    $0x1,%eax
    128a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    128d:	8b 45 08             	mov    0x8(%ebp),%eax
    1290:	8b 40 04             	mov    0x4(%eax),%eax
    1293:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1296:	7f 0c                	jg     12a4 <APDcCopy+0xb7>
    1298:	8b 45 08             	mov    0x8(%ebp),%eax
    129b:	8b 40 04             	mov    0x4(%eax),%eax
    129e:	83 e8 01             	sub    $0x1,%eax
    12a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    12a4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12ab:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
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
        for (int i = 0; i <=  wx_r - wx; i++)
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
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1367:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    136b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    136e:	2b 45 0c             	sub    0xc(%ebp),%eax
    1371:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1374:	7d 81                	jge    12f7 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1376:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    137a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    137d:	2b 45 10             	sub    0x10(%ebp),%eax
    1380:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1383:	0f 8d 35 ff ff ff    	jge    12be <APDcCopy+0xd1>
    1389:	eb 04                	jmp    138f <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    138b:	90                   	nop
    138c:	eb 01                	jmp    138f <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
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
    13e9:	e8 8d ef ff ff       	call   37b <sendMessage>
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
    1402:	e8 3e f3 ff ff       	call   745 <malloc>
    1407:	83 c4 10             	add    $0x10,%esp
    140a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    140d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1411:	75 15                	jne    1428 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1413:	83 ec 04             	sub    $0x4,%esp
    1416:	ff 75 08             	pushl  0x8(%ebp)
    1419:	68 58 21 00 00       	push   $0x2158
    141e:	6a 01                	push   $0x1
    1420:	e8 4d f0 ff ff       	call   472 <printf>
    1425:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1428:	8b 45 f4             	mov    -0xc(%ebp),%eax
    142b:	83 c0 7c             	add    $0x7c,%eax
    142e:	83 ec 08             	sub    $0x8,%esp
    1431:	ff 75 08             	pushl  0x8(%ebp)
    1434:	50                   	push   %eax
    1435:	e8 60 ec ff ff       	call   9a <strcpy>
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
    146c:	e8 d4 f2 ff ff       	call   745 <malloc>
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
    148c:	68 78 21 00 00       	push   $0x2178
    1491:	6a 01                	push   $0x1
    1493:	e8 da ef ff ff       	call   472 <printf>
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
    14c2:	e8 69 ec ff ff       	call   130 <memset>
    14c7:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cd:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    14d4:	e8 72 ee ff ff       	call   34b <getpid>
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
    1510:	e8 30 f2 ff ff       	call   745 <malloc>
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
    1530:	68 9c 21 00 00       	push   $0x219c
    1535:	6a 01                	push   $0x1
    1537:	e8 36 ef ff ff       	call   472 <printf>
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
    1566:	e8 c5 eb ff ff       	call   130 <memset>
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
    158a:	e8 b6 f1 ff ff       	call   745 <malloc>
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
    15e1:	e8 5f f1 ff ff       	call   745 <malloc>
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
    1601:	68 c4 21 00 00       	push   $0x21c4
    1606:	6a 01                	push   $0x1
    1608:	e8 65 ee ff ff       	call   472 <printf>
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
    1637:	e8 f4 ea ff ff       	call   130 <memset>
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
    167f:	e8 e7 ec ff ff       	call   36b <paintWindow>
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
    16c7:	e8 bf ec ff ff       	call   38b <registWindow>
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
    16f8:	e8 86 ec ff ff       	call   383 <getMessage>
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
    174a:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    174d:	a1 24 28 00 00       	mov    0x2824,%eax
    1752:	85 c0                	test   %eax,%eax
    1754:	0f 85 2c 02 00 00    	jne    1986 <APGridPaint+0x242>
    {
        iconReady = 1;
    175a:	c7 05 24 28 00 00 01 	movl   $0x1,0x2824
    1761:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1764:	8d 45 98             	lea    -0x68(%ebp),%eax
    1767:	83 ec 08             	sub    $0x8,%esp
    176a:	68 eb 21 00 00       	push   $0x21eb
    176f:	50                   	push   %eax
    1770:	e8 83 f1 ff ff       	call   8f8 <APLoadBitmap>
    1775:	83 c4 0c             	add    $0xc,%esp
    1778:	8b 45 98             	mov    -0x68(%ebp),%eax
    177b:	a3 48 28 00 00       	mov    %eax,0x2848
    1780:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1783:	a3 4c 28 00 00       	mov    %eax,0x284c
    1788:	8b 45 a0             	mov    -0x60(%ebp),%eax
    178b:	a3 50 28 00 00       	mov    %eax,0x2850
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1790:	83 ec 04             	sub    $0x4,%esp
    1793:	ff 35 50 28 00 00    	pushl  0x2850
    1799:	ff 35 4c 28 00 00    	pushl  0x284c
    179f:	ff 35 48 28 00 00    	pushl  0x2848
    17a5:	e8 88 f3 ff ff       	call   b32 <APCreateCompatibleDCFromBitmap>
    17aa:	83 c4 10             	add    $0x10,%esp
    17ad:	a3 54 28 00 00       	mov    %eax,0x2854
        grid_river = APLoadBitmap ("grid_river.bmp");
    17b2:	8d 45 98             	lea    -0x68(%ebp),%eax
    17b5:	83 ec 08             	sub    $0x8,%esp
    17b8:	68 f9 21 00 00       	push   $0x21f9
    17bd:	50                   	push   %eax
    17be:	e8 35 f1 ff ff       	call   8f8 <APLoadBitmap>
    17c3:	83 c4 0c             	add    $0xc,%esp
    17c6:	8b 45 98             	mov    -0x68(%ebp),%eax
    17c9:	a3 84 28 00 00       	mov    %eax,0x2884
    17ce:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17d1:	a3 88 28 00 00       	mov    %eax,0x2888
    17d6:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17d9:	a3 8c 28 00 00       	mov    %eax,0x288c
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    17de:	83 ec 04             	sub    $0x4,%esp
    17e1:	ff 35 8c 28 00 00    	pushl  0x288c
    17e7:	ff 35 88 28 00 00    	pushl  0x2888
    17ed:	ff 35 84 28 00 00    	pushl  0x2884
    17f3:	e8 3a f3 ff ff       	call   b32 <APCreateCompatibleDCFromBitmap>
    17f8:	83 c4 10             	add    $0x10,%esp
    17fb:	a3 74 28 00 00       	mov    %eax,0x2874
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1800:	8d 45 98             	lea    -0x68(%ebp),%eax
    1803:	83 ec 08             	sub    $0x8,%esp
    1806:	68 08 22 00 00       	push   $0x2208
    180b:	50                   	push   %eax
    180c:	e8 e7 f0 ff ff       	call   8f8 <APLoadBitmap>
    1811:	83 c4 0c             	add    $0xc,%esp
    1814:	8b 45 98             	mov    -0x68(%ebp),%eax
    1817:	a3 78 28 00 00       	mov    %eax,0x2878
    181c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    181f:	a3 7c 28 00 00       	mov    %eax,0x287c
    1824:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1827:	a3 80 28 00 00       	mov    %eax,0x2880
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    182c:	83 ec 04             	sub    $0x4,%esp
    182f:	ff 35 80 28 00 00    	pushl  0x2880
    1835:	ff 35 7c 28 00 00    	pushl  0x287c
    183b:	ff 35 78 28 00 00    	pushl  0x2878
    1841:	e8 ec f2 ff ff       	call   b32 <APCreateCompatibleDCFromBitmap>
    1846:	83 c4 10             	add    $0x10,%esp
    1849:	a3 28 28 00 00       	mov    %eax,0x2828
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    184e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1851:	83 ec 08             	sub    $0x8,%esp
    1854:	68 17 22 00 00       	push   $0x2217
    1859:	50                   	push   %eax
    185a:	e8 99 f0 ff ff       	call   8f8 <APLoadBitmap>
    185f:	83 c4 0c             	add    $0xc,%esp
    1862:	8b 45 98             	mov    -0x68(%ebp),%eax
    1865:	a3 5c 28 00 00       	mov    %eax,0x285c
    186a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    186d:	a3 60 28 00 00       	mov    %eax,0x2860
    1872:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1875:	a3 64 28 00 00       	mov    %eax,0x2864
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    187a:	83 ec 04             	sub    $0x4,%esp
    187d:	ff 35 64 28 00 00    	pushl  0x2864
    1883:	ff 35 60 28 00 00    	pushl  0x2860
    1889:	ff 35 5c 28 00 00    	pushl  0x285c
    188f:	e8 9e f2 ff ff       	call   b32 <APCreateCompatibleDCFromBitmap>
    1894:	83 c4 10             	add    $0x10,%esp
    1897:	a3 90 28 00 00       	mov    %eax,0x2890
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    189c:	8d 45 98             	lea    -0x68(%ebp),%eax
    189f:	83 ec 08             	sub    $0x8,%esp
    18a2:	68 25 22 00 00       	push   $0x2225
    18a7:	50                   	push   %eax
    18a8:	e8 4b f0 ff ff       	call   8f8 <APLoadBitmap>
    18ad:	83 c4 0c             	add    $0xc,%esp
    18b0:	8b 45 98             	mov    -0x68(%ebp),%eax
    18b3:	a3 38 28 00 00       	mov    %eax,0x2838
    18b8:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18bb:	a3 3c 28 00 00       	mov    %eax,0x283c
    18c0:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18c3:	a3 40 28 00 00       	mov    %eax,0x2840
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    18c8:	83 ec 04             	sub    $0x4,%esp
    18cb:	ff 35 40 28 00 00    	pushl  0x2840
    18d1:	ff 35 3c 28 00 00    	pushl  0x283c
    18d7:	ff 35 38 28 00 00    	pushl  0x2838
    18dd:	e8 50 f2 ff ff       	call   b32 <APCreateCompatibleDCFromBitmap>
    18e2:	83 c4 10             	add    $0x10,%esp
    18e5:	a3 58 28 00 00       	mov    %eax,0x2858
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    18ea:	8d 45 98             	lea    -0x68(%ebp),%eax
    18ed:	83 ec 08             	sub    $0x8,%esp
    18f0:	68 35 22 00 00       	push   $0x2235
    18f5:	50                   	push   %eax
    18f6:	e8 fd ef ff ff       	call   8f8 <APLoadBitmap>
    18fb:	83 c4 0c             	add    $0xc,%esp
    18fe:	8b 45 98             	mov    -0x68(%ebp),%eax
    1901:	a3 2c 28 00 00       	mov    %eax,0x282c
    1906:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1909:	a3 30 28 00 00       	mov    %eax,0x2830
    190e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1911:	a3 34 28 00 00       	mov    %eax,0x2834
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1916:	83 ec 04             	sub    $0x4,%esp
    1919:	ff 35 34 28 00 00    	pushl  0x2834
    191f:	ff 35 30 28 00 00    	pushl  0x2830
    1925:	ff 35 2c 28 00 00    	pushl  0x282c
    192b:	e8 02 f2 ff ff       	call   b32 <APCreateCompatibleDCFromBitmap>
    1930:	83 c4 10             	add    $0x10,%esp
    1933:	a3 44 28 00 00       	mov    %eax,0x2844
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1938:	8d 45 98             	lea    -0x68(%ebp),%eax
    193b:	83 ec 08             	sub    $0x8,%esp
    193e:	68 47 22 00 00       	push   $0x2247
    1943:	50                   	push   %eax
    1944:	e8 af ef ff ff       	call   8f8 <APLoadBitmap>
    1949:	83 c4 0c             	add    $0xc,%esp
    194c:	8b 45 98             	mov    -0x68(%ebp),%eax
    194f:	a3 68 28 00 00       	mov    %eax,0x2868
    1954:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1957:	a3 6c 28 00 00       	mov    %eax,0x286c
    195c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    195f:	a3 70 28 00 00       	mov    %eax,0x2870
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1964:	83 ec 04             	sub    $0x4,%esp
    1967:	ff 35 70 28 00 00    	pushl  0x2870
    196d:	ff 35 6c 28 00 00    	pushl  0x286c
    1973:	ff 35 68 28 00 00    	pushl  0x2868
    1979:	e8 b4 f1 ff ff       	call   b32 <APCreateCompatibleDCFromBitmap>
    197e:	83 c4 10             	add    $0x10,%esp
    1981:	a3 94 28 00 00       	mov    %eax,0x2894
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1986:	8b 45 08             	mov    0x8(%ebp),%eax
    1989:	8b 40 08             	mov    0x8(%eax),%eax
    198c:	85 c0                	test   %eax,%eax
    198e:	75 17                	jne    19a7 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1990:	83 ec 08             	sub    $0x8,%esp
    1993:	68 58 22 00 00       	push   $0x2258
    1998:	6a 01                	push   $0x1
    199a:	e8 d3 ea ff ff       	call   472 <printf>
    199f:	83 c4 10             	add    $0x10,%esp
        return;
    19a2:	e9 f2 03 00 00       	jmp    1d99 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    19a7:	8b 45 08             	mov    0x8(%ebp),%eax
    19aa:	8b 40 10             	mov    0x10(%eax),%eax
    19ad:	85 c0                	test   %eax,%eax
    19af:	7e 10                	jle    19c1 <APGridPaint+0x27d>
    19b1:	8b 45 08             	mov    0x8(%ebp),%eax
    19b4:	8b 50 14             	mov    0x14(%eax),%edx
    19b7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ba:	8b 40 10             	mov    0x10(%eax),%eax
    19bd:	39 c2                	cmp    %eax,%edx
    19bf:	7c 17                	jl     19d8 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    19c1:	83 ec 08             	sub    $0x8,%esp
    19c4:	68 7e 22 00 00       	push   $0x227e
    19c9:	6a 01                	push   $0x1
    19cb:	e8 a2 ea ff ff       	call   472 <printf>
    19d0:	83 c4 10             	add    $0x10,%esp
        return;
    19d3:	e9 c1 03 00 00       	jmp    1d99 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    19d8:	8b 45 08             	mov    0x8(%ebp),%eax
    19db:	8b 40 14             	mov    0x14(%eax),%eax
    19de:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    19e4:	89 45 dc             	mov    %eax,-0x24(%ebp)
    19e7:	8b 45 dc             	mov    -0x24(%ebp),%eax
    19ea:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    19ed:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    19f4:	e9 96 03 00 00       	jmp    1d8f <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    19f9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a00:	e9 7c 03 00 00       	jmp    1d81 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a05:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a08:	c1 e0 04             	shl    $0x4,%eax
    1a0b:	89 c2                	mov    %eax,%edx
    1a0d:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a10:	01 c2                	add    %eax,%edx
    1a12:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a15:	01 d0                	add    %edx,%eax
    1a17:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1d:	8b 40 0c             	mov    0xc(%eax),%eax
    1a20:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a23:	c1 e2 02             	shl    $0x2,%edx
    1a26:	01 d0                	add    %edx,%eax
    1a28:	8b 00                	mov    (%eax),%eax
    1a2a:	83 f8 07             	cmp    $0x7,%eax
    1a2d:	0f 87 49 03 00 00    	ja     1d7c <APGridPaint+0x638>
    1a33:	8b 04 85 94 22 00 00 	mov    0x2294(,%eax,4),%eax
    1a3a:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1a3c:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1a3f:	6a 0c                	push   $0xc
    1a41:	6a 0c                	push   $0xc
    1a43:	6a 0c                	push   $0xc
    1a45:	50                   	push   %eax
    1a46:	e8 46 f9 ff ff       	call   1391 <RGB>
    1a4b:	83 c4 0c             	add    $0xc,%esp
    1a4e:	8b 1d 54 28 00 00    	mov    0x2854,%ebx
    1a54:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a57:	6b c8 32             	imul   $0x32,%eax,%ecx
    1a5a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a5d:	6b c0 32             	imul   $0x32,%eax,%eax
    1a60:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1a63:	8b 45 08             	mov    0x8(%ebp),%eax
    1a66:	8d 78 34             	lea    0x34(%eax),%edi
    1a69:	83 ec 0c             	sub    $0xc,%esp
    1a6c:	83 ec 04             	sub    $0x4,%esp
    1a6f:	89 e0                	mov    %esp,%eax
    1a71:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1a75:	66 89 30             	mov    %si,(%eax)
    1a78:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1a7c:	88 50 02             	mov    %dl,0x2(%eax)
    1a7f:	6a 32                	push   $0x32
    1a81:	6a 32                	push   $0x32
    1a83:	6a 00                	push   $0x0
    1a85:	6a 00                	push   $0x0
    1a87:	53                   	push   %ebx
    1a88:	51                   	push   %ecx
    1a89:	ff 75 94             	pushl  -0x6c(%ebp)
    1a8c:	57                   	push   %edi
    1a8d:	e8 5b f7 ff ff       	call   11ed <APDcCopy>
    1a92:	83 c4 30             	add    $0x30,%esp
                    break;
    1a95:	e9 e3 02 00 00       	jmp    1d7d <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1a9a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a9d:	6a 69                	push   $0x69
    1a9f:	6a 69                	push   $0x69
    1aa1:	6a 69                	push   $0x69
    1aa3:	50                   	push   %eax
    1aa4:	e8 e8 f8 ff ff       	call   1391 <RGB>
    1aa9:	83 c4 0c             	add    $0xc,%esp
    1aac:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ab0:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1ab4:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ab8:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1abb:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1ac2:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ac5:	6a 69                	push   $0x69
    1ac7:	6a 69                	push   $0x69
    1ac9:	6a 69                	push   $0x69
    1acb:	50                   	push   %eax
    1acc:	e8 c0 f8 ff ff       	call   1391 <RGB>
    1ad1:	83 c4 0c             	add    $0xc,%esp
    1ad4:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ad8:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1adc:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ae0:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1ae3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae6:	8d 50 34             	lea    0x34(%eax),%edx
    1ae9:	8d 45 98             	lea    -0x68(%ebp),%eax
    1aec:	ff 75 bc             	pushl  -0x44(%ebp)
    1aef:	ff 75 b8             	pushl  -0x48(%ebp)
    1af2:	52                   	push   %edx
    1af3:	50                   	push   %eax
    1af4:	e8 ce f0 ff ff       	call   bc7 <APSetPen>
    1af9:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1afc:	8b 45 08             	mov    0x8(%ebp),%eax
    1aff:	8d 58 34             	lea    0x34(%eax),%ebx
    1b02:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b05:	83 ec 04             	sub    $0x4,%esp
    1b08:	83 ec 04             	sub    $0x4,%esp
    1b0b:	89 e0                	mov    %esp,%eax
    1b0d:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1b11:	66 89 08             	mov    %cx,(%eax)
    1b14:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1b18:	88 48 02             	mov    %cl,0x2(%eax)
    1b1b:	53                   	push   %ebx
    1b1c:	52                   	push   %edx
    1b1d:	e8 de f0 ff ff       	call   c00 <APSetBrush>
    1b22:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b25:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b28:	6b d0 32             	imul   $0x32,%eax,%edx
    1b2b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b2e:	6b c0 32             	imul   $0x32,%eax,%eax
    1b31:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b34:	83 c1 34             	add    $0x34,%ecx
    1b37:	83 ec 0c             	sub    $0xc,%esp
    1b3a:	6a 32                	push   $0x32
    1b3c:	6a 32                	push   $0x32
    1b3e:	52                   	push   %edx
    1b3f:	50                   	push   %eax
    1b40:	51                   	push   %ecx
    1b41:	e8 a2 f4 ff ff       	call   fe8 <APDrawRect>
    1b46:	83 c4 20             	add    $0x20,%esp
                    break;
    1b49:	e9 2f 02 00 00       	jmp    1d7d <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b4e:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1b51:	6a 0c                	push   $0xc
    1b53:	6a 0c                	push   $0xc
    1b55:	6a 0c                	push   $0xc
    1b57:	50                   	push   %eax
    1b58:	e8 34 f8 ff ff       	call   1391 <RGB>
    1b5d:	83 c4 0c             	add    $0xc,%esp
    1b60:	8b 1d 94 28 00 00    	mov    0x2894,%ebx
    1b66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b69:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b6c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b6f:	6b c0 32             	imul   $0x32,%eax,%eax
    1b72:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b75:	8b 45 08             	mov    0x8(%ebp),%eax
    1b78:	8d 78 34             	lea    0x34(%eax),%edi
    1b7b:	83 ec 0c             	sub    $0xc,%esp
    1b7e:	83 ec 04             	sub    $0x4,%esp
    1b81:	89 e0                	mov    %esp,%eax
    1b83:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1b87:	66 89 30             	mov    %si,(%eax)
    1b8a:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1b8e:	88 50 02             	mov    %dl,0x2(%eax)
    1b91:	6a 32                	push   $0x32
    1b93:	6a 32                	push   $0x32
    1b95:	6a 00                	push   $0x0
    1b97:	6a 00                	push   $0x0
    1b99:	53                   	push   %ebx
    1b9a:	51                   	push   %ecx
    1b9b:	ff 75 94             	pushl  -0x6c(%ebp)
    1b9e:	57                   	push   %edi
    1b9f:	e8 49 f6 ff ff       	call   11ed <APDcCopy>
    1ba4:	83 c4 30             	add    $0x30,%esp
                    break;
    1ba7:	e9 d1 01 00 00       	jmp    1d7d <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bac:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1baf:	6a 0c                	push   $0xc
    1bb1:	6a 0c                	push   $0xc
    1bb3:	6a 0c                	push   $0xc
    1bb5:	50                   	push   %eax
    1bb6:	e8 d6 f7 ff ff       	call   1391 <RGB>
    1bbb:	83 c4 0c             	add    $0xc,%esp
    1bbe:	8b 1d 74 28 00 00    	mov    0x2874,%ebx
    1bc4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bc7:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bca:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bcd:	6b c0 32             	imul   $0x32,%eax,%eax
    1bd0:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd6:	8d 78 34             	lea    0x34(%eax),%edi
    1bd9:	83 ec 0c             	sub    $0xc,%esp
    1bdc:	83 ec 04             	sub    $0x4,%esp
    1bdf:	89 e0                	mov    %esp,%eax
    1be1:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1be5:	66 89 30             	mov    %si,(%eax)
    1be8:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1bec:	88 50 02             	mov    %dl,0x2(%eax)
    1bef:	6a 32                	push   $0x32
    1bf1:	6a 32                	push   $0x32
    1bf3:	6a 00                	push   $0x0
    1bf5:	6a 00                	push   $0x0
    1bf7:	53                   	push   %ebx
    1bf8:	51                   	push   %ecx
    1bf9:	ff 75 94             	pushl  -0x6c(%ebp)
    1bfc:	57                   	push   %edi
    1bfd:	e8 eb f5 ff ff       	call   11ed <APDcCopy>
    1c02:	83 c4 30             	add    $0x30,%esp
                    break;
    1c05:	e9 73 01 00 00       	jmp    1d7d <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c0a:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c0d:	6a 0c                	push   $0xc
    1c0f:	6a 0c                	push   $0xc
    1c11:	6a 0c                	push   $0xc
    1c13:	50                   	push   %eax
    1c14:	e8 78 f7 ff ff       	call   1391 <RGB>
    1c19:	83 c4 0c             	add    $0xc,%esp
    1c1c:	8b 1d 58 28 00 00    	mov    0x2858,%ebx
    1c22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c25:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c28:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c2b:	6b c0 32             	imul   $0x32,%eax,%eax
    1c2e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c31:	8b 45 08             	mov    0x8(%ebp),%eax
    1c34:	8d 78 34             	lea    0x34(%eax),%edi
    1c37:	83 ec 0c             	sub    $0xc,%esp
    1c3a:	83 ec 04             	sub    $0x4,%esp
    1c3d:	89 e0                	mov    %esp,%eax
    1c3f:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1c43:	66 89 30             	mov    %si,(%eax)
    1c46:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1c4a:	88 50 02             	mov    %dl,0x2(%eax)
    1c4d:	6a 32                	push   $0x32
    1c4f:	6a 32                	push   $0x32
    1c51:	6a 00                	push   $0x0
    1c53:	6a 00                	push   $0x0
    1c55:	53                   	push   %ebx
    1c56:	51                   	push   %ecx
    1c57:	ff 75 94             	pushl  -0x6c(%ebp)
    1c5a:	57                   	push   %edi
    1c5b:	e8 8d f5 ff ff       	call   11ed <APDcCopy>
    1c60:	83 c4 30             	add    $0x30,%esp
                    break;
    1c63:	e9 15 01 00 00       	jmp    1d7d <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c68:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1c6b:	6a 0c                	push   $0xc
    1c6d:	6a 0c                	push   $0xc
    1c6f:	6a 0c                	push   $0xc
    1c71:	50                   	push   %eax
    1c72:	e8 1a f7 ff ff       	call   1391 <RGB>
    1c77:	83 c4 0c             	add    $0xc,%esp
    1c7a:	8b 1d 90 28 00 00    	mov    0x2890,%ebx
    1c80:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c83:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c86:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c89:	6b c0 32             	imul   $0x32,%eax,%eax
    1c8c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c92:	8d 78 34             	lea    0x34(%eax),%edi
    1c95:	83 ec 0c             	sub    $0xc,%esp
    1c98:	83 ec 04             	sub    $0x4,%esp
    1c9b:	89 e0                	mov    %esp,%eax
    1c9d:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1ca1:	66 89 30             	mov    %si,(%eax)
    1ca4:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1ca8:	88 50 02             	mov    %dl,0x2(%eax)
    1cab:	6a 32                	push   $0x32
    1cad:	6a 32                	push   $0x32
    1caf:	6a 00                	push   $0x0
    1cb1:	6a 00                	push   $0x0
    1cb3:	53                   	push   %ebx
    1cb4:	51                   	push   %ecx
    1cb5:	ff 75 94             	pushl  -0x6c(%ebp)
    1cb8:	57                   	push   %edi
    1cb9:	e8 2f f5 ff ff       	call   11ed <APDcCopy>
    1cbe:	83 c4 30             	add    $0x30,%esp
                    break;
    1cc1:	e9 b7 00 00 00       	jmp    1d7d <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cc6:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1cc9:	6a 0c                	push   $0xc
    1ccb:	6a 0c                	push   $0xc
    1ccd:	6a 0c                	push   $0xc
    1ccf:	50                   	push   %eax
    1cd0:	e8 bc f6 ff ff       	call   1391 <RGB>
    1cd5:	83 c4 0c             	add    $0xc,%esp
    1cd8:	8b 1d 28 28 00 00    	mov    0x2828,%ebx
    1cde:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ce1:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ce4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ce7:	6b c0 32             	imul   $0x32,%eax,%eax
    1cea:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ced:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf0:	8d 78 34             	lea    0x34(%eax),%edi
    1cf3:	83 ec 0c             	sub    $0xc,%esp
    1cf6:	83 ec 04             	sub    $0x4,%esp
    1cf9:	89 e0                	mov    %esp,%eax
    1cfb:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1cff:	66 89 30             	mov    %si,(%eax)
    1d02:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d06:	88 50 02             	mov    %dl,0x2(%eax)
    1d09:	6a 32                	push   $0x32
    1d0b:	6a 32                	push   $0x32
    1d0d:	6a 00                	push   $0x0
    1d0f:	6a 00                	push   $0x0
    1d11:	53                   	push   %ebx
    1d12:	51                   	push   %ecx
    1d13:	ff 75 94             	pushl  -0x6c(%ebp)
    1d16:	57                   	push   %edi
    1d17:	e8 d1 f4 ff ff       	call   11ed <APDcCopy>
    1d1c:	83 c4 30             	add    $0x30,%esp
                    break;
    1d1f:	eb 5c                	jmp    1d7d <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d21:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d24:	6a 0c                	push   $0xc
    1d26:	6a 0c                	push   $0xc
    1d28:	6a 0c                	push   $0xc
    1d2a:	50                   	push   %eax
    1d2b:	e8 61 f6 ff ff       	call   1391 <RGB>
    1d30:	83 c4 0c             	add    $0xc,%esp
    1d33:	8b 1d 44 28 00 00    	mov    0x2844,%ebx
    1d39:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d3c:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d3f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d42:	6b c0 32             	imul   $0x32,%eax,%eax
    1d45:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d48:	8b 45 08             	mov    0x8(%ebp),%eax
    1d4b:	8d 78 34             	lea    0x34(%eax),%edi
    1d4e:	83 ec 0c             	sub    $0xc,%esp
    1d51:	83 ec 04             	sub    $0x4,%esp
    1d54:	89 e0                	mov    %esp,%eax
    1d56:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1d5a:	66 89 30             	mov    %si,(%eax)
    1d5d:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1d61:	88 50 02             	mov    %dl,0x2(%eax)
    1d64:	6a 32                	push   $0x32
    1d66:	6a 32                	push   $0x32
    1d68:	6a 00                	push   $0x0
    1d6a:	6a 00                	push   $0x0
    1d6c:	53                   	push   %ebx
    1d6d:	51                   	push   %ecx
    1d6e:	ff 75 94             	pushl  -0x6c(%ebp)
    1d71:	57                   	push   %edi
    1d72:	e8 76 f4 ff ff       	call   11ed <APDcCopy>
    1d77:	83 c4 30             	add    $0x30,%esp
                    break;
    1d7a:	eb 01                	jmp    1d7d <APGridPaint+0x639>
                default: break;
    1d7c:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d7d:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1d81:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1d85:	0f 8e 7a fc ff ff    	jle    1a05 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d8b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1d8f:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1d93:	0f 8e 60 fc ff ff    	jle    19f9 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1d99:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1d9c:	5b                   	pop    %ebx
    1d9d:	5e                   	pop    %esi
    1d9e:	5f                   	pop    %edi
    1d9f:	5d                   	pop    %ebp
    1da0:	c3                   	ret    

00001da1 <random>:
//

#include "APLib.h"

int random(int seed)
{
    1da1:	55                   	push   %ebp
    1da2:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1da4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1da8:	7e 08                	jle    1db2 <random+0x11>
{
rand_num = seed;
    1daa:	8b 45 08             	mov    0x8(%ebp),%eax
    1dad:	a3 00 28 00 00       	mov    %eax,0x2800
}
rand_num *= 3;
    1db2:	8b 15 00 28 00 00    	mov    0x2800,%edx
    1db8:	89 d0                	mov    %edx,%eax
    1dba:	01 c0                	add    %eax,%eax
    1dbc:	01 d0                	add    %edx,%eax
    1dbe:	a3 00 28 00 00       	mov    %eax,0x2800
if (rand_num < 0)
    1dc3:	a1 00 28 00 00       	mov    0x2800,%eax
    1dc8:	85 c0                	test   %eax,%eax
    1dca:	79 0c                	jns    1dd8 <random+0x37>
{
rand_num *= (-1);
    1dcc:	a1 00 28 00 00       	mov    0x2800,%eax
    1dd1:	f7 d8                	neg    %eax
    1dd3:	a3 00 28 00 00       	mov    %eax,0x2800
}
return rand_num % 997;
    1dd8:	8b 0d 00 28 00 00    	mov    0x2800,%ecx
    1dde:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1de3:	89 c8                	mov    %ecx,%eax
    1de5:	f7 ea                	imul   %edx
    1de7:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1dea:	c1 f8 09             	sar    $0x9,%eax
    1ded:	89 c2                	mov    %eax,%edx
    1def:	89 c8                	mov    %ecx,%eax
    1df1:	c1 f8 1f             	sar    $0x1f,%eax
    1df4:	29 c2                	sub    %eax,%edx
    1df6:	89 d0                	mov    %edx,%eax
    1df8:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1dfe:	29 c1                	sub    %eax,%ecx
    1e00:	89 c8                	mov    %ecx,%eax
}
    1e02:	5d                   	pop    %ebp
    1e03:	c3                   	ret    

00001e04 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1e04:	55                   	push   %ebp
    1e05:	89 e5                	mov    %esp,%ebp
    1e07:	53                   	push   %ebx
    1e08:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1e0b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1e12:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1e16:	74 17                	je     1e2f <sprintint+0x2b>
    1e18:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e1c:	79 11                	jns    1e2f <sprintint+0x2b>
        neg = 1;
    1e1e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1e25:	8b 45 10             	mov    0x10(%ebp),%eax
    1e28:	f7 d8                	neg    %eax
    1e2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e2d:	eb 06                	jmp    1e35 <sprintint+0x31>
    } else {
        x = xx;
    1e2f:	8b 45 10             	mov    0x10(%ebp),%eax
    1e32:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1e35:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1e3c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1e3f:	8d 41 01             	lea    0x1(%ecx),%eax
    1e42:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1e45:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e48:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e4b:	ba 00 00 00 00       	mov    $0x0,%edx
    1e50:	f7 f3                	div    %ebx
    1e52:	89 d0                	mov    %edx,%eax
    1e54:	0f b6 80 04 28 00 00 	movzbl 0x2804(%eax),%eax
    1e5b:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1e5f:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e62:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e65:	ba 00 00 00 00       	mov    $0x0,%edx
    1e6a:	f7 f3                	div    %ebx
    1e6c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e6f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e73:	75 c7                	jne    1e3c <sprintint+0x38>
    if(neg)
    1e75:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e79:	74 0e                	je     1e89 <sprintint+0x85>
        buf[i++] = '-';
    1e7b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e7e:	8d 50 01             	lea    0x1(%eax),%edx
    1e81:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1e84:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1e89:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e8c:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1e8f:	eb 1b                	jmp    1eac <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1e91:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e94:	8b 00                	mov    (%eax),%eax
    1e96:	8d 48 01             	lea    0x1(%eax),%ecx
    1e99:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e9c:	89 0a                	mov    %ecx,(%edx)
    1e9e:	89 c2                	mov    %eax,%edx
    1ea0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea3:	01 d0                	add    %edx,%eax
    1ea5:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1ea8:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1eac:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1eb0:	7f df                	jg     1e91 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1eb2:	eb 21                	jmp    1ed5 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1eb4:	8b 45 0c             	mov    0xc(%ebp),%eax
    1eb7:	8b 00                	mov    (%eax),%eax
    1eb9:	8d 48 01             	lea    0x1(%eax),%ecx
    1ebc:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ebf:	89 0a                	mov    %ecx,(%edx)
    1ec1:	89 c2                	mov    %eax,%edx
    1ec3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec6:	01 c2                	add    %eax,%edx
    1ec8:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1ecb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ece:	01 c8                	add    %ecx,%eax
    1ed0:	0f b6 00             	movzbl (%eax),%eax
    1ed3:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1ed5:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1ed9:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1edd:	79 d5                	jns    1eb4 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1edf:	90                   	nop
    1ee0:	83 c4 20             	add    $0x20,%esp
    1ee3:	5b                   	pop    %ebx
    1ee4:	5d                   	pop    %ebp
    1ee5:	c3                   	ret    

00001ee6 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1ee6:	55                   	push   %ebp
    1ee7:	89 e5                	mov    %esp,%ebp
    1ee9:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1eec:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1ef3:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1efa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1f01:	8d 45 0c             	lea    0xc(%ebp),%eax
    1f04:	83 c0 04             	add    $0x4,%eax
    1f07:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1f0a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1f11:	e9 d9 01 00 00       	jmp    20ef <sprintf+0x209>
        c = fmt[i] & 0xff;
    1f16:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f19:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f1c:	01 d0                	add    %edx,%eax
    1f1e:	0f b6 00             	movzbl (%eax),%eax
    1f21:	0f be c0             	movsbl %al,%eax
    1f24:	25 ff 00 00 00       	and    $0xff,%eax
    1f29:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1f2c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1f30:	75 2c                	jne    1f5e <sprintf+0x78>
            if(c == '%'){
    1f32:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1f36:	75 0c                	jne    1f44 <sprintf+0x5e>
                state = '%';
    1f38:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1f3f:	e9 a7 01 00 00       	jmp    20eb <sprintf+0x205>
            } else {
                dst[j++] = c;
    1f44:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f47:	8d 50 01             	lea    0x1(%eax),%edx
    1f4a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f4d:	89 c2                	mov    %eax,%edx
    1f4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1f52:	01 d0                	add    %edx,%eax
    1f54:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f57:	88 10                	mov    %dl,(%eax)
    1f59:	e9 8d 01 00 00       	jmp    20eb <sprintf+0x205>
            }
        } else if(state == '%'){
    1f5e:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1f62:	0f 85 83 01 00 00    	jne    20eb <sprintf+0x205>
            if(c == 'd'){
    1f68:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1f6c:	75 4c                	jne    1fba <sprintf+0xd4>
                buf[bi] = '\0';
    1f6e:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f71:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f74:	01 d0                	add    %edx,%eax
    1f76:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f79:	83 ec 0c             	sub    $0xc,%esp
    1f7c:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f7f:	50                   	push   %eax
    1f80:	e8 b4 e2 ff ff       	call   239 <atoi>
    1f85:	83 c4 10             	add    $0x10,%esp
    1f88:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1f8b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1f92:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f95:	8b 00                	mov    (%eax),%eax
    1f97:	83 ec 08             	sub    $0x8,%esp
    1f9a:	ff 75 d8             	pushl  -0x28(%ebp)
    1f9d:	6a 01                	push   $0x1
    1f9f:	6a 0a                	push   $0xa
    1fa1:	50                   	push   %eax
    1fa2:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1fa5:	50                   	push   %eax
    1fa6:	ff 75 08             	pushl  0x8(%ebp)
    1fa9:	e8 56 fe ff ff       	call   1e04 <sprintint>
    1fae:	83 c4 20             	add    $0x20,%esp
                ap++;
    1fb1:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1fb5:	e9 2a 01 00 00       	jmp    20e4 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1fba:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1fbe:	74 06                	je     1fc6 <sprintf+0xe0>
    1fc0:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1fc4:	75 4c                	jne    2012 <sprintf+0x12c>
                buf[bi] = '\0';
    1fc6:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1fc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1fcc:	01 d0                	add    %edx,%eax
    1fce:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1fd1:	83 ec 0c             	sub    $0xc,%esp
    1fd4:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1fd7:	50                   	push   %eax
    1fd8:	e8 5c e2 ff ff       	call   239 <atoi>
    1fdd:	83 c4 10             	add    $0x10,%esp
    1fe0:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1fe3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1fea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fed:	8b 00                	mov    (%eax),%eax
    1fef:	83 ec 08             	sub    $0x8,%esp
    1ff2:	ff 75 dc             	pushl  -0x24(%ebp)
    1ff5:	6a 00                	push   $0x0
    1ff7:	6a 10                	push   $0x10
    1ff9:	50                   	push   %eax
    1ffa:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1ffd:	50                   	push   %eax
    1ffe:	ff 75 08             	pushl  0x8(%ebp)
    2001:	e8 fe fd ff ff       	call   1e04 <sprintint>
    2006:	83 c4 20             	add    $0x20,%esp
                ap++;
    2009:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    200d:	e9 d2 00 00 00       	jmp    20e4 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2012:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2016:	75 46                	jne    205e <sprintf+0x178>
                s = (char*)*ap;
    2018:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    201b:	8b 00                	mov    (%eax),%eax
    201d:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2020:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2024:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2028:	75 25                	jne    204f <sprintf+0x169>
                    s = "(null)";
    202a:	c7 45 f4 b4 22 00 00 	movl   $0x22b4,-0xc(%ebp)
                while(*s != 0){
    2031:	eb 1c                	jmp    204f <sprintf+0x169>
                    dst[j++] = *s;
    2033:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2036:	8d 50 01             	lea    0x1(%eax),%edx
    2039:	89 55 c8             	mov    %edx,-0x38(%ebp)
    203c:	89 c2                	mov    %eax,%edx
    203e:	8b 45 08             	mov    0x8(%ebp),%eax
    2041:	01 c2                	add    %eax,%edx
    2043:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2046:	0f b6 00             	movzbl (%eax),%eax
    2049:	88 02                	mov    %al,(%edx)
                    s++;
    204b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    204f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2052:	0f b6 00             	movzbl (%eax),%eax
    2055:	84 c0                	test   %al,%al
    2057:	75 da                	jne    2033 <sprintf+0x14d>
    2059:	e9 86 00 00 00       	jmp    20e4 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    205e:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2062:	75 1d                	jne    2081 <sprintf+0x19b>
                dst[j++] = *ap;
    2064:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2067:	8d 50 01             	lea    0x1(%eax),%edx
    206a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    206d:	89 c2                	mov    %eax,%edx
    206f:	8b 45 08             	mov    0x8(%ebp),%eax
    2072:	01 c2                	add    %eax,%edx
    2074:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2077:	8b 00                	mov    (%eax),%eax
    2079:	88 02                	mov    %al,(%edx)
                ap++;
    207b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    207f:	eb 63                	jmp    20e4 <sprintf+0x1fe>
            } else if(c == '%'){
    2081:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2085:	75 17                	jne    209e <sprintf+0x1b8>
                dst[j++] = c;
    2087:	8b 45 c8             	mov    -0x38(%ebp),%eax
    208a:	8d 50 01             	lea    0x1(%eax),%edx
    208d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2090:	89 c2                	mov    %eax,%edx
    2092:	8b 45 08             	mov    0x8(%ebp),%eax
    2095:	01 d0                	add    %edx,%eax
    2097:	8b 55 e0             	mov    -0x20(%ebp),%edx
    209a:	88 10                	mov    %dl,(%eax)
    209c:	eb 46                	jmp    20e4 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    209e:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    20a2:	7e 18                	jle    20bc <sprintf+0x1d6>
    20a4:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    20a8:	7f 12                	jg     20bc <sprintf+0x1d6>
            {
                buf[bi++] = c;
    20aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20ad:	8d 50 01             	lea    0x1(%eax),%edx
    20b0:	89 55 f0             	mov    %edx,-0x10(%ebp)
    20b3:	8b 55 e0             	mov    -0x20(%ebp),%edx
    20b6:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    20ba:	eb 2f                	jmp    20eb <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    20bc:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20bf:	8d 50 01             	lea    0x1(%eax),%edx
    20c2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20c5:	89 c2                	mov    %eax,%edx
    20c7:	8b 45 08             	mov    0x8(%ebp),%eax
    20ca:	01 d0                	add    %edx,%eax
    20cc:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    20cf:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20d2:	8d 50 01             	lea    0x1(%eax),%edx
    20d5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20d8:	89 c2                	mov    %eax,%edx
    20da:	8b 45 08             	mov    0x8(%ebp),%eax
    20dd:	01 d0                	add    %edx,%eax
    20df:	8b 55 e0             	mov    -0x20(%ebp),%edx
    20e2:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    20e4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    20eb:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    20ef:	8b 55 0c             	mov    0xc(%ebp),%edx
    20f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    20f5:	01 d0                	add    %edx,%eax
    20f7:	0f b6 00             	movzbl (%eax),%eax
    20fa:	84 c0                	test   %al,%al
    20fc:	0f 85 14 fe ff ff    	jne    1f16 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2102:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2105:	8d 50 01             	lea    0x1(%eax),%edx
    2108:	89 55 c8             	mov    %edx,-0x38(%ebp)
    210b:	89 c2                	mov    %eax,%edx
    210d:	8b 45 08             	mov    0x8(%ebp),%eax
    2110:	01 d0                	add    %edx,%eax
    2112:	c6 00 00             	movb   $0x0,(%eax)
}
    2115:	90                   	nop
    2116:	c9                   	leave  
    2117:	c3                   	ret    
