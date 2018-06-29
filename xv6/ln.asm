
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
      19:	68 e8 23 00 00       	push   $0x23e8
      1e:	6a 02                	push   $0x2
      20:	e8 55 04 00 00       	call   47a <printf>
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
      60:	68 fb 23 00 00       	push   $0x23fb
      65:	6a 02                	push   $0x2
      67:	e8 0e 04 00 00       	call   47a <printf>
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

00000393 <setupTimer>:
SYSCALL(setupTimer)
     393:	b8 1b 00 00 00       	mov    $0x1b,%eax
     398:	cd 40                	int    $0x40
     39a:	c3                   	ret    

0000039b <deleteTimer>:
SYSCALL(deleteTimer)
     39b:	b8 1c 00 00 00       	mov    $0x1c,%eax
     3a0:	cd 40                	int    $0x40
     3a2:	c3                   	ret    

000003a3 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3a3:	55                   	push   %ebp
     3a4:	89 e5                	mov    %esp,%ebp
     3a6:	83 ec 18             	sub    $0x18,%esp
     3a9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ac:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3af:	83 ec 04             	sub    $0x4,%esp
     3b2:	6a 01                	push   $0x1
     3b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3b7:	50                   	push   %eax
     3b8:	ff 75 08             	pushl  0x8(%ebp)
     3bb:	e8 2b ff ff ff       	call   2eb <write>
     3c0:	83 c4 10             	add    $0x10,%esp
}
     3c3:	90                   	nop
     3c4:	c9                   	leave  
     3c5:	c3                   	ret    

000003c6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3c6:	55                   	push   %ebp
     3c7:	89 e5                	mov    %esp,%ebp
     3c9:	53                   	push   %ebx
     3ca:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3cd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3d4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3d8:	74 17                	je     3f1 <printint+0x2b>
     3da:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3de:	79 11                	jns    3f1 <printint+0x2b>
    neg = 1;
     3e0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3e7:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ea:	f7 d8                	neg    %eax
     3ec:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3ef:	eb 06                	jmp    3f7 <printint+0x31>
  } else {
    x = xx;
     3f1:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3f7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3fe:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     401:	8d 41 01             	lea    0x1(%ecx),%eax
     404:	89 45 f4             	mov    %eax,-0xc(%ebp)
     407:	8b 5d 10             	mov    0x10(%ebp),%ebx
     40a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     40d:	ba 00 00 00 00       	mov    $0x0,%edx
     412:	f7 f3                	div    %ebx
     414:	89 d0                	mov    %edx,%eax
     416:	0f b6 80 20 2b 00 00 	movzbl 0x2b20(%eax),%eax
     41d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     421:	8b 5d 10             	mov    0x10(%ebp),%ebx
     424:	8b 45 ec             	mov    -0x14(%ebp),%eax
     427:	ba 00 00 00 00       	mov    $0x0,%edx
     42c:	f7 f3                	div    %ebx
     42e:	89 45 ec             	mov    %eax,-0x14(%ebp)
     431:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     435:	75 c7                	jne    3fe <printint+0x38>
  if(neg)
     437:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     43b:	74 2d                	je     46a <printint+0xa4>
    buf[i++] = '-';
     43d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     440:	8d 50 01             	lea    0x1(%eax),%edx
     443:	89 55 f4             	mov    %edx,-0xc(%ebp)
     446:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     44b:	eb 1d                	jmp    46a <printint+0xa4>
    putc(fd, buf[i]);
     44d:	8d 55 dc             	lea    -0x24(%ebp),%edx
     450:	8b 45 f4             	mov    -0xc(%ebp),%eax
     453:	01 d0                	add    %edx,%eax
     455:	0f b6 00             	movzbl (%eax),%eax
     458:	0f be c0             	movsbl %al,%eax
     45b:	83 ec 08             	sub    $0x8,%esp
     45e:	50                   	push   %eax
     45f:	ff 75 08             	pushl  0x8(%ebp)
     462:	e8 3c ff ff ff       	call   3a3 <putc>
     467:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     46a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     46e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     472:	79 d9                	jns    44d <printint+0x87>
    putc(fd, buf[i]);
}
     474:	90                   	nop
     475:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     478:	c9                   	leave  
     479:	c3                   	ret    

0000047a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     47a:	55                   	push   %ebp
     47b:	89 e5                	mov    %esp,%ebp
     47d:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     480:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     487:	8d 45 0c             	lea    0xc(%ebp),%eax
     48a:	83 c0 04             	add    $0x4,%eax
     48d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     490:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     497:	e9 59 01 00 00       	jmp    5f5 <printf+0x17b>
    c = fmt[i] & 0xff;
     49c:	8b 55 0c             	mov    0xc(%ebp),%edx
     49f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4a2:	01 d0                	add    %edx,%eax
     4a4:	0f b6 00             	movzbl (%eax),%eax
     4a7:	0f be c0             	movsbl %al,%eax
     4aa:	25 ff 00 00 00       	and    $0xff,%eax
     4af:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4b2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4b6:	75 2c                	jne    4e4 <printf+0x6a>
      if(c == '%'){
     4b8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4bc:	75 0c                	jne    4ca <printf+0x50>
        state = '%';
     4be:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4c5:	e9 27 01 00 00       	jmp    5f1 <printf+0x177>
      } else {
        putc(fd, c);
     4ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4cd:	0f be c0             	movsbl %al,%eax
     4d0:	83 ec 08             	sub    $0x8,%esp
     4d3:	50                   	push   %eax
     4d4:	ff 75 08             	pushl  0x8(%ebp)
     4d7:	e8 c7 fe ff ff       	call   3a3 <putc>
     4dc:	83 c4 10             	add    $0x10,%esp
     4df:	e9 0d 01 00 00       	jmp    5f1 <printf+0x177>
      }
    } else if(state == '%'){
     4e4:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4e8:	0f 85 03 01 00 00    	jne    5f1 <printf+0x177>
      if(c == 'd'){
     4ee:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4f2:	75 1e                	jne    512 <printf+0x98>
        printint(fd, *ap, 10, 1);
     4f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4f7:	8b 00                	mov    (%eax),%eax
     4f9:	6a 01                	push   $0x1
     4fb:	6a 0a                	push   $0xa
     4fd:	50                   	push   %eax
     4fe:	ff 75 08             	pushl  0x8(%ebp)
     501:	e8 c0 fe ff ff       	call   3c6 <printint>
     506:	83 c4 10             	add    $0x10,%esp
        ap++;
     509:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     50d:	e9 d8 00 00 00       	jmp    5ea <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     512:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     516:	74 06                	je     51e <printf+0xa4>
     518:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     51c:	75 1e                	jne    53c <printf+0xc2>
        printint(fd, *ap, 16, 0);
     51e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     521:	8b 00                	mov    (%eax),%eax
     523:	6a 00                	push   $0x0
     525:	6a 10                	push   $0x10
     527:	50                   	push   %eax
     528:	ff 75 08             	pushl  0x8(%ebp)
     52b:	e8 96 fe ff ff       	call   3c6 <printint>
     530:	83 c4 10             	add    $0x10,%esp
        ap++;
     533:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     537:	e9 ae 00 00 00       	jmp    5ea <printf+0x170>
      } else if(c == 's'){
     53c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     540:	75 43                	jne    585 <printf+0x10b>
        s = (char*)*ap;
     542:	8b 45 e8             	mov    -0x18(%ebp),%eax
     545:	8b 00                	mov    (%eax),%eax
     547:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     54a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     54e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     552:	75 25                	jne    579 <printf+0xff>
          s = "(null)";
     554:	c7 45 f4 0f 24 00 00 	movl   $0x240f,-0xc(%ebp)
        while(*s != 0){
     55b:	eb 1c                	jmp    579 <printf+0xff>
          putc(fd, *s);
     55d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     560:	0f b6 00             	movzbl (%eax),%eax
     563:	0f be c0             	movsbl %al,%eax
     566:	83 ec 08             	sub    $0x8,%esp
     569:	50                   	push   %eax
     56a:	ff 75 08             	pushl  0x8(%ebp)
     56d:	e8 31 fe ff ff       	call   3a3 <putc>
     572:	83 c4 10             	add    $0x10,%esp
          s++;
     575:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     579:	8b 45 f4             	mov    -0xc(%ebp),%eax
     57c:	0f b6 00             	movzbl (%eax),%eax
     57f:	84 c0                	test   %al,%al
     581:	75 da                	jne    55d <printf+0xe3>
     583:	eb 65                	jmp    5ea <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     585:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     589:	75 1d                	jne    5a8 <printf+0x12e>
        putc(fd, *ap);
     58b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     58e:	8b 00                	mov    (%eax),%eax
     590:	0f be c0             	movsbl %al,%eax
     593:	83 ec 08             	sub    $0x8,%esp
     596:	50                   	push   %eax
     597:	ff 75 08             	pushl  0x8(%ebp)
     59a:	e8 04 fe ff ff       	call   3a3 <putc>
     59f:	83 c4 10             	add    $0x10,%esp
        ap++;
     5a2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5a6:	eb 42                	jmp    5ea <printf+0x170>
      } else if(c == '%'){
     5a8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5ac:	75 17                	jne    5c5 <printf+0x14b>
        putc(fd, c);
     5ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5b1:	0f be c0             	movsbl %al,%eax
     5b4:	83 ec 08             	sub    $0x8,%esp
     5b7:	50                   	push   %eax
     5b8:	ff 75 08             	pushl  0x8(%ebp)
     5bb:	e8 e3 fd ff ff       	call   3a3 <putc>
     5c0:	83 c4 10             	add    $0x10,%esp
     5c3:	eb 25                	jmp    5ea <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5c5:	83 ec 08             	sub    $0x8,%esp
     5c8:	6a 25                	push   $0x25
     5ca:	ff 75 08             	pushl  0x8(%ebp)
     5cd:	e8 d1 fd ff ff       	call   3a3 <putc>
     5d2:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5d8:	0f be c0             	movsbl %al,%eax
     5db:	83 ec 08             	sub    $0x8,%esp
     5de:	50                   	push   %eax
     5df:	ff 75 08             	pushl  0x8(%ebp)
     5e2:	e8 bc fd ff ff       	call   3a3 <putc>
     5e7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5ea:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5f1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5f5:	8b 55 0c             	mov    0xc(%ebp),%edx
     5f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5fb:	01 d0                	add    %edx,%eax
     5fd:	0f b6 00             	movzbl (%eax),%eax
     600:	84 c0                	test   %al,%al
     602:	0f 85 94 fe ff ff    	jne    49c <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     608:	90                   	nop
     609:	c9                   	leave  
     60a:	c3                   	ret    

0000060b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     60b:	55                   	push   %ebp
     60c:	89 e5                	mov    %esp,%ebp
     60e:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     611:	8b 45 08             	mov    0x8(%ebp),%eax
     614:	83 e8 08             	sub    $0x8,%eax
     617:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     61a:	a1 80 67 00 00       	mov    0x6780,%eax
     61f:	89 45 fc             	mov    %eax,-0x4(%ebp)
     622:	eb 24                	jmp    648 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     624:	8b 45 fc             	mov    -0x4(%ebp),%eax
     627:	8b 00                	mov    (%eax),%eax
     629:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     62c:	77 12                	ja     640 <free+0x35>
     62e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     631:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     634:	77 24                	ja     65a <free+0x4f>
     636:	8b 45 fc             	mov    -0x4(%ebp),%eax
     639:	8b 00                	mov    (%eax),%eax
     63b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     63e:	77 1a                	ja     65a <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     640:	8b 45 fc             	mov    -0x4(%ebp),%eax
     643:	8b 00                	mov    (%eax),%eax
     645:	89 45 fc             	mov    %eax,-0x4(%ebp)
     648:	8b 45 f8             	mov    -0x8(%ebp),%eax
     64b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     64e:	76 d4                	jbe    624 <free+0x19>
     650:	8b 45 fc             	mov    -0x4(%ebp),%eax
     653:	8b 00                	mov    (%eax),%eax
     655:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     658:	76 ca                	jbe    624 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     65a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     65d:	8b 40 04             	mov    0x4(%eax),%eax
     660:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     667:	8b 45 f8             	mov    -0x8(%ebp),%eax
     66a:	01 c2                	add    %eax,%edx
     66c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66f:	8b 00                	mov    (%eax),%eax
     671:	39 c2                	cmp    %eax,%edx
     673:	75 24                	jne    699 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     675:	8b 45 f8             	mov    -0x8(%ebp),%eax
     678:	8b 50 04             	mov    0x4(%eax),%edx
     67b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67e:	8b 00                	mov    (%eax),%eax
     680:	8b 40 04             	mov    0x4(%eax),%eax
     683:	01 c2                	add    %eax,%edx
     685:	8b 45 f8             	mov    -0x8(%ebp),%eax
     688:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     68b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68e:	8b 00                	mov    (%eax),%eax
     690:	8b 10                	mov    (%eax),%edx
     692:	8b 45 f8             	mov    -0x8(%ebp),%eax
     695:	89 10                	mov    %edx,(%eax)
     697:	eb 0a                	jmp    6a3 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     699:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69c:	8b 10                	mov    (%eax),%edx
     69e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a1:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a6:	8b 40 04             	mov    0x4(%eax),%eax
     6a9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b3:	01 d0                	add    %edx,%eax
     6b5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6b8:	75 20                	jne    6da <free+0xcf>
    p->s.size += bp->s.size;
     6ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6bd:	8b 50 04             	mov    0x4(%eax),%edx
     6c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c3:	8b 40 04             	mov    0x4(%eax),%eax
     6c6:	01 c2                	add    %eax,%edx
     6c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6d1:	8b 10                	mov    (%eax),%edx
     6d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d6:	89 10                	mov    %edx,(%eax)
     6d8:	eb 08                	jmp    6e2 <free+0xd7>
  } else
    p->s.ptr = bp;
     6da:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6dd:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6e0:	89 10                	mov    %edx,(%eax)
  freep = p;
     6e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e5:	a3 80 67 00 00       	mov    %eax,0x6780
}
     6ea:	90                   	nop
     6eb:	c9                   	leave  
     6ec:	c3                   	ret    

000006ed <morecore>:

static Header*
morecore(uint nu)
{
     6ed:	55                   	push   %ebp
     6ee:	89 e5                	mov    %esp,%ebp
     6f0:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6f3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6fa:	77 07                	ja     703 <morecore+0x16>
    nu = 4096;
     6fc:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     703:	8b 45 08             	mov    0x8(%ebp),%eax
     706:	c1 e0 03             	shl    $0x3,%eax
     709:	83 ec 0c             	sub    $0xc,%esp
     70c:	50                   	push   %eax
     70d:	e8 41 fc ff ff       	call   353 <sbrk>
     712:	83 c4 10             	add    $0x10,%esp
     715:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     718:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     71c:	75 07                	jne    725 <morecore+0x38>
    return 0;
     71e:	b8 00 00 00 00       	mov    $0x0,%eax
     723:	eb 26                	jmp    74b <morecore+0x5e>
  hp = (Header*)p;
     725:	8b 45 f4             	mov    -0xc(%ebp),%eax
     728:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     72b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     72e:	8b 55 08             	mov    0x8(%ebp),%edx
     731:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     734:	8b 45 f0             	mov    -0x10(%ebp),%eax
     737:	83 c0 08             	add    $0x8,%eax
     73a:	83 ec 0c             	sub    $0xc,%esp
     73d:	50                   	push   %eax
     73e:	e8 c8 fe ff ff       	call   60b <free>
     743:	83 c4 10             	add    $0x10,%esp
  return freep;
     746:	a1 80 67 00 00       	mov    0x6780,%eax
}
     74b:	c9                   	leave  
     74c:	c3                   	ret    

0000074d <malloc>:

void*
malloc(uint nbytes)
{
     74d:	55                   	push   %ebp
     74e:	89 e5                	mov    %esp,%ebp
     750:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     753:	8b 45 08             	mov    0x8(%ebp),%eax
     756:	83 c0 07             	add    $0x7,%eax
     759:	c1 e8 03             	shr    $0x3,%eax
     75c:	83 c0 01             	add    $0x1,%eax
     75f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     762:	a1 80 67 00 00       	mov    0x6780,%eax
     767:	89 45 f0             	mov    %eax,-0x10(%ebp)
     76a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     76e:	75 23                	jne    793 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     770:	c7 45 f0 78 67 00 00 	movl   $0x6778,-0x10(%ebp)
     777:	8b 45 f0             	mov    -0x10(%ebp),%eax
     77a:	a3 80 67 00 00       	mov    %eax,0x6780
     77f:	a1 80 67 00 00       	mov    0x6780,%eax
     784:	a3 78 67 00 00       	mov    %eax,0x6778
    base.s.size = 0;
     789:	c7 05 7c 67 00 00 00 	movl   $0x0,0x677c
     790:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     793:	8b 45 f0             	mov    -0x10(%ebp),%eax
     796:	8b 00                	mov    (%eax),%eax
     798:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     79b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     79e:	8b 40 04             	mov    0x4(%eax),%eax
     7a1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7a4:	72 4d                	jb     7f3 <malloc+0xa6>
      if(p->s.size == nunits)
     7a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a9:	8b 40 04             	mov    0x4(%eax),%eax
     7ac:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7af:	75 0c                	jne    7bd <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b4:	8b 10                	mov    (%eax),%edx
     7b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7b9:	89 10                	mov    %edx,(%eax)
     7bb:	eb 26                	jmp    7e3 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c0:	8b 40 04             	mov    0x4(%eax),%eax
     7c3:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7c6:	89 c2                	mov    %eax,%edx
     7c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7cb:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d1:	8b 40 04             	mov    0x4(%eax),%eax
     7d4:	c1 e0 03             	shl    $0x3,%eax
     7d7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7da:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7dd:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7e0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e6:	a3 80 67 00 00       	mov    %eax,0x6780
      return (void*)(p + 1);
     7eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ee:	83 c0 08             	add    $0x8,%eax
     7f1:	eb 3b                	jmp    82e <malloc+0xe1>
    }
    if(p == freep)
     7f3:	a1 80 67 00 00       	mov    0x6780,%eax
     7f8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7fb:	75 1e                	jne    81b <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7fd:	83 ec 0c             	sub    $0xc,%esp
     800:	ff 75 ec             	pushl  -0x14(%ebp)
     803:	e8 e5 fe ff ff       	call   6ed <morecore>
     808:	83 c4 10             	add    $0x10,%esp
     80b:	89 45 f4             	mov    %eax,-0xc(%ebp)
     80e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     812:	75 07                	jne    81b <malloc+0xce>
        return 0;
     814:	b8 00 00 00 00       	mov    $0x0,%eax
     819:	eb 13                	jmp    82e <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     81b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     81e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     821:	8b 45 f4             	mov    -0xc(%ebp),%eax
     824:	8b 00                	mov    (%eax),%eax
     826:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     829:	e9 6d ff ff ff       	jmp    79b <malloc+0x4e>
}
     82e:	c9                   	leave  
     82f:	c3                   	ret    

00000830 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     830:	55                   	push   %ebp
     831:	89 e5                	mov    %esp,%ebp
     833:	83 ec 1c             	sub    $0x1c,%esp
     836:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     839:	8b 55 10             	mov    0x10(%ebp),%edx
     83c:	8b 45 14             	mov    0x14(%ebp),%eax
     83f:	88 4d ec             	mov    %cl,-0x14(%ebp)
     842:	88 55 e8             	mov    %dl,-0x18(%ebp)
     845:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     848:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     84c:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     84f:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     853:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     856:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     85a:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     85d:	8b 45 08             	mov    0x8(%ebp),%eax
     860:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     864:	66 89 10             	mov    %dx,(%eax)
     867:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     86b:	88 50 02             	mov    %dl,0x2(%eax)
}
     86e:	8b 45 08             	mov    0x8(%ebp),%eax
     871:	c9                   	leave  
     872:	c2 04 00             	ret    $0x4

00000875 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     875:	55                   	push   %ebp
     876:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     878:	8b 45 08             	mov    0x8(%ebp),%eax
     87b:	2b 45 10             	sub    0x10(%ebp),%eax
     87e:	89 c2                	mov    %eax,%edx
     880:	8b 45 08             	mov    0x8(%ebp),%eax
     883:	2b 45 10             	sub    0x10(%ebp),%eax
     886:	0f af d0             	imul   %eax,%edx
     889:	8b 45 0c             	mov    0xc(%ebp),%eax
     88c:	2b 45 14             	sub    0x14(%ebp),%eax
     88f:	89 c1                	mov    %eax,%ecx
     891:	8b 45 0c             	mov    0xc(%ebp),%eax
     894:	2b 45 14             	sub    0x14(%ebp),%eax
     897:	0f af c1             	imul   %ecx,%eax
     89a:	01 d0                	add    %edx,%eax
}
     89c:	5d                   	pop    %ebp
     89d:	c3                   	ret    

0000089e <abs_int>:

static inline int abs_int(int x)
{
     89e:	55                   	push   %ebp
     89f:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     8a1:	8b 45 08             	mov    0x8(%ebp),%eax
     8a4:	99                   	cltd   
     8a5:	89 d0                	mov    %edx,%eax
     8a7:	33 45 08             	xor    0x8(%ebp),%eax
     8aa:	29 d0                	sub    %edx,%eax
}
     8ac:	5d                   	pop    %ebp
     8ad:	c3                   	ret    

000008ae <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     8ae:	55                   	push   %ebp
     8af:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     8b1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8b5:	79 07                	jns    8be <APGetIndex+0x10>
        return X_SMALLER;
     8b7:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8bc:	eb 40                	jmp    8fe <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8be:	8b 45 08             	mov    0x8(%ebp),%eax
     8c1:	8b 00                	mov    (%eax),%eax
     8c3:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8c6:	7f 07                	jg     8cf <APGetIndex+0x21>
        return X_BIGGER;
     8c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8cd:	eb 2f                	jmp    8fe <APGetIndex+0x50>
    if (y < 0)
     8cf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8d3:	79 07                	jns    8dc <APGetIndex+0x2e>
        return Y_SMALLER;
     8d5:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8da:	eb 22                	jmp    8fe <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8dc:	8b 45 08             	mov    0x8(%ebp),%eax
     8df:	8b 40 04             	mov    0x4(%eax),%eax
     8e2:	3b 45 10             	cmp    0x10(%ebp),%eax
     8e5:	7f 07                	jg     8ee <APGetIndex+0x40>
        return Y_BIGGER;
     8e7:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8ec:	eb 10                	jmp    8fe <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8ee:	8b 45 08             	mov    0x8(%ebp),%eax
     8f1:	8b 00                	mov    (%eax),%eax
     8f3:	0f af 45 10          	imul   0x10(%ebp),%eax
     8f7:	89 c2                	mov    %eax,%edx
     8f9:	8b 45 0c             	mov    0xc(%ebp),%eax
     8fc:	01 d0                	add    %edx,%eax
}
     8fe:	5d                   	pop    %ebp
     8ff:	c3                   	ret    

00000900 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     900:	55                   	push   %ebp
     901:	89 e5                	mov    %esp,%ebp
     903:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     906:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     90d:	8b 45 cc             	mov    -0x34(%ebp),%eax
     910:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     913:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     91a:	83 ec 08             	sub    $0x8,%esp
     91d:	6a 00                	push   $0x0
     91f:	ff 75 0c             	pushl  0xc(%ebp)
     922:	e8 e4 f9 ff ff       	call   30b <open>
     927:	83 c4 10             	add    $0x10,%esp
     92a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     92d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     931:	79 2e                	jns    961 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     933:	83 ec 04             	sub    $0x4,%esp
     936:	ff 75 0c             	pushl  0xc(%ebp)
     939:	68 16 24 00 00       	push   $0x2416
     93e:	6a 01                	push   $0x1
     940:	e8 35 fb ff ff       	call   47a <printf>
     945:	83 c4 10             	add    $0x10,%esp
        return bmp;
     948:	8b 45 08             	mov    0x8(%ebp),%eax
     94b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     94e:	89 10                	mov    %edx,(%eax)
     950:	8b 55 cc             	mov    -0x34(%ebp),%edx
     953:	89 50 04             	mov    %edx,0x4(%eax)
     956:	8b 55 d0             	mov    -0x30(%ebp),%edx
     959:	89 50 08             	mov    %edx,0x8(%eax)
     95c:	e9 d2 01 00 00       	jmp    b33 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     961:	83 ec 04             	sub    $0x4,%esp
     964:	6a 0e                	push   $0xe
     966:	8d 45 ba             	lea    -0x46(%ebp),%eax
     969:	50                   	push   %eax
     96a:	ff 75 ec             	pushl  -0x14(%ebp)
     96d:	e8 71 f9 ff ff       	call   2e3 <read>
     972:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     975:	83 ec 04             	sub    $0x4,%esp
     978:	6a 28                	push   $0x28
     97a:	8d 45 92             	lea    -0x6e(%ebp),%eax
     97d:	50                   	push   %eax
     97e:	ff 75 ec             	pushl  -0x14(%ebp)
     981:	e8 5d f9 ff ff       	call   2e3 <read>
     986:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     989:	8b 45 96             	mov    -0x6a(%ebp),%eax
     98c:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     98f:	8b 45 9a             	mov    -0x66(%ebp),%eax
     992:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     995:	8b 55 c8             	mov    -0x38(%ebp),%edx
     998:	8b 45 cc             	mov    -0x34(%ebp),%eax
     99b:	0f af d0             	imul   %eax,%edx
     99e:	89 d0                	mov    %edx,%eax
     9a0:	01 c0                	add    %eax,%eax
     9a2:	01 d0                	add    %edx,%eax
     9a4:	83 ec 0c             	sub    $0xc,%esp
     9a7:	50                   	push   %eax
     9a8:	e8 a0 fd ff ff       	call   74d <malloc>
     9ad:	83 c4 10             	add    $0x10,%esp
     9b0:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9b3:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9b7:	0f b7 c0             	movzwl %ax,%eax
     9ba:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9bd:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9c0:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9c3:	0f af c2             	imul   %edx,%eax
     9c6:	83 c0 1f             	add    $0x1f,%eax
     9c9:	c1 e8 05             	shr    $0x5,%eax
     9cc:	c1 e0 02             	shl    $0x2,%eax
     9cf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9d2:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9d8:	0f af c2             	imul   %edx,%eax
     9db:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9de:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9e1:	83 ec 0c             	sub    $0xc,%esp
     9e4:	50                   	push   %eax
     9e5:	e8 63 fd ff ff       	call   74d <malloc>
     9ea:	83 c4 10             	add    $0x10,%esp
     9ed:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9f0:	83 ec 04             	sub    $0x4,%esp
     9f3:	ff 75 e0             	pushl  -0x20(%ebp)
     9f6:	ff 75 dc             	pushl  -0x24(%ebp)
     9f9:	ff 75 ec             	pushl  -0x14(%ebp)
     9fc:	e8 e2 f8 ff ff       	call   2e3 <read>
     a01:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a04:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a08:	66 c1 e8 03          	shr    $0x3,%ax
     a0c:	0f b7 c0             	movzwl %ax,%eax
     a0f:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a12:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a19:	e9 e5 00 00 00       	jmp    b03 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a1e:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a21:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a24:	29 c2                	sub    %eax,%edx
     a26:	89 d0                	mov    %edx,%eax
     a28:	8d 50 ff             	lea    -0x1(%eax),%edx
     a2b:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a2e:	0f af c2             	imul   %edx,%eax
     a31:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a34:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a3b:	e9 b1 00 00 00       	jmp    af1 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a40:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a43:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a46:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a49:	01 c8                	add    %ecx,%eax
     a4b:	89 c1                	mov    %eax,%ecx
     a4d:	89 c8                	mov    %ecx,%eax
     a4f:	01 c0                	add    %eax,%eax
     a51:	01 c8                	add    %ecx,%eax
     a53:	01 c2                	add    %eax,%edx
     a55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a58:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a5c:	89 c1                	mov    %eax,%ecx
     a5e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a61:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a65:	01 c1                	add    %eax,%ecx
     a67:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a6a:	01 c8                	add    %ecx,%eax
     a6c:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a6f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a72:	01 c8                	add    %ecx,%eax
     a74:	0f b6 00             	movzbl (%eax),%eax
     a77:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a7a:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a7d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a80:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a83:	01 c8                	add    %ecx,%eax
     a85:	89 c1                	mov    %eax,%ecx
     a87:	89 c8                	mov    %ecx,%eax
     a89:	01 c0                	add    %eax,%eax
     a8b:	01 c8                	add    %ecx,%eax
     a8d:	01 c2                	add    %eax,%edx
     a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a92:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a96:	89 c1                	mov    %eax,%ecx
     a98:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a9b:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a9f:	01 c1                	add    %eax,%ecx
     aa1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aa4:	01 c8                	add    %ecx,%eax
     aa6:	8d 48 fe             	lea    -0x2(%eax),%ecx
     aa9:	8b 45 dc             	mov    -0x24(%ebp),%eax
     aac:	01 c8                	add    %ecx,%eax
     aae:	0f b6 00             	movzbl (%eax),%eax
     ab1:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     ab4:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ab7:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     aba:	8b 45 f0             	mov    -0x10(%ebp),%eax
     abd:	01 c8                	add    %ecx,%eax
     abf:	89 c1                	mov    %eax,%ecx
     ac1:	89 c8                	mov    %ecx,%eax
     ac3:	01 c0                	add    %eax,%eax
     ac5:	01 c8                	add    %ecx,%eax
     ac7:	01 c2                	add    %eax,%edx
     ac9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     acc:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ad0:	89 c1                	mov    %eax,%ecx
     ad2:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ad5:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ad9:	01 c1                	add    %eax,%ecx
     adb:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ade:	01 c8                	add    %ecx,%eax
     ae0:	8d 48 fd             	lea    -0x3(%eax),%ecx
     ae3:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ae6:	01 c8                	add    %ecx,%eax
     ae8:	0f b6 00             	movzbl (%eax),%eax
     aeb:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     aed:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     af1:	8b 55 c8             	mov    -0x38(%ebp),%edx
     af4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     af7:	39 c2                	cmp    %eax,%edx
     af9:	0f 87 41 ff ff ff    	ja     a40 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     aff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b03:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b06:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b09:	39 c2                	cmp    %eax,%edx
     b0b:	0f 87 0d ff ff ff    	ja     a1e <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b11:	83 ec 0c             	sub    $0xc,%esp
     b14:	ff 75 ec             	pushl  -0x14(%ebp)
     b17:	e8 d7 f7 ff ff       	call   2f3 <close>
     b1c:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b1f:	8b 45 08             	mov    0x8(%ebp),%eax
     b22:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b25:	89 10                	mov    %edx,(%eax)
     b27:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b2a:	89 50 04             	mov    %edx,0x4(%eax)
     b2d:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b30:	89 50 08             	mov    %edx,0x8(%eax)
}
     b33:	8b 45 08             	mov    0x8(%ebp),%eax
     b36:	c9                   	leave  
     b37:	c2 04 00             	ret    $0x4

00000b3a <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b3a:	55                   	push   %ebp
     b3b:	89 e5                	mov    %esp,%ebp
     b3d:	53                   	push   %ebx
     b3e:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b41:	83 ec 0c             	sub    $0xc,%esp
     b44:	6a 1c                	push   $0x1c
     b46:	e8 02 fc ff ff       	call   74d <malloc>
     b4b:	83 c4 10             	add    $0x10,%esp
     b4e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b51:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b54:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b5b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b5e:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b61:	6a 0c                	push   $0xc
     b63:	6a 0c                	push   $0xc
     b65:	6a 0c                	push   $0xc
     b67:	50                   	push   %eax
     b68:	e8 c3 fc ff ff       	call   830 <RGB>
     b6d:	83 c4 0c             	add    $0xc,%esp
     b70:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b74:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b78:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b7c:	88 43 15             	mov    %al,0x15(%ebx)
     b7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b82:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b85:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b89:	66 89 48 10          	mov    %cx,0x10(%eax)
     b8d:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b91:	88 50 12             	mov    %dl,0x12(%eax)
     b94:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b97:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b9a:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     b9e:	66 89 48 08          	mov    %cx,0x8(%eax)
     ba2:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     ba6:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     ba9:	8b 45 08             	mov    0x8(%ebp),%eax
     bac:	89 c2                	mov    %eax,%edx
     bae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb1:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     bb3:	8b 45 0c             	mov    0xc(%ebp),%eax
     bb6:	89 c2                	mov    %eax,%edx
     bb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bbb:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bbe:	8b 55 10             	mov    0x10(%ebp),%edx
     bc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc4:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     bc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bcd:	c9                   	leave  
     bce:	c3                   	ret    

00000bcf <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     bcf:	55                   	push   %ebp
     bd0:	89 e5                	mov    %esp,%ebp
     bd2:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     bd5:	8b 45 0c             	mov    0xc(%ebp),%eax
     bd8:	8b 50 08             	mov    0x8(%eax),%edx
     bdb:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bde:	8b 40 0c             	mov    0xc(%eax),%eax
     be1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     be4:	8b 45 0c             	mov    0xc(%ebp),%eax
     be7:	8b 55 10             	mov    0x10(%ebp),%edx
     bea:	89 50 08             	mov    %edx,0x8(%eax)
     bed:	8b 55 14             	mov    0x14(%ebp),%edx
     bf0:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     bf3:	8b 45 08             	mov    0x8(%ebp),%eax
     bf6:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bf9:	89 10                	mov    %edx,(%eax)
     bfb:	8b 55 fc             	mov    -0x4(%ebp),%edx
     bfe:	89 50 04             	mov    %edx,0x4(%eax)
}
     c01:	8b 45 08             	mov    0x8(%ebp),%eax
     c04:	c9                   	leave  
     c05:	c2 04 00             	ret    $0x4

00000c08 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c08:	55                   	push   %ebp
     c09:	89 e5                	mov    %esp,%ebp
     c0b:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c0e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c11:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c15:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c19:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c1d:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c20:	8b 45 0c             	mov    0xc(%ebp),%eax
     c23:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c27:	66 89 50 10          	mov    %dx,0x10(%eax)
     c2b:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c2f:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c32:	8b 45 08             	mov    0x8(%ebp),%eax
     c35:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c39:	66 89 10             	mov    %dx,(%eax)
     c3c:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c40:	88 50 02             	mov    %dl,0x2(%eax)
}
     c43:	8b 45 08             	mov    0x8(%ebp),%eax
     c46:	c9                   	leave  
     c47:	c2 04 00             	ret    $0x4

00000c4a <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     c4a:	55                   	push   %ebp
     c4b:	89 e5                	mov    %esp,%ebp
     c4d:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     c50:	8b 45 0c             	mov    0xc(%ebp),%eax
     c53:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     c57:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c5b:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     c5f:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     c62:	8b 45 0c             	mov    0xc(%ebp),%eax
     c65:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c69:	66 89 50 13          	mov    %dx,0x13(%eax)
     c6d:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c71:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     c74:	8b 45 08             	mov    0x8(%ebp),%eax
     c77:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c7b:	66 89 10             	mov    %dx,(%eax)
     c7e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c82:	88 50 02             	mov    %dl,0x2(%eax)
}
     c85:	8b 45 08             	mov    0x8(%ebp),%eax
     c88:	c9                   	leave  
     c89:	c2 04 00             	ret    $0x4

00000c8c <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c8c:	55                   	push   %ebp
     c8d:	89 e5                	mov    %esp,%ebp
     c8f:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c92:	8b 45 08             	mov    0x8(%ebp),%eax
     c95:	8b 40 0c             	mov    0xc(%eax),%eax
     c98:	89 c2                	mov    %eax,%edx
     c9a:	c1 ea 1f             	shr    $0x1f,%edx
     c9d:	01 d0                	add    %edx,%eax
     c9f:	d1 f8                	sar    %eax
     ca1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     ca4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca7:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     cab:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     cae:	8b 45 10             	mov    0x10(%ebp),%eax
     cb1:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cb4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     cb7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     cbb:	0f 89 98 00 00 00    	jns    d59 <APDrawPoint+0xcd>
        i = 0;
     cc1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     cc8:	e9 8c 00 00 00       	jmp    d59 <APDrawPoint+0xcd>
    {
        j = x - off;
     ccd:	8b 45 0c             	mov    0xc(%ebp),%eax
     cd0:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cd3:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     cd6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     cda:	79 69                	jns    d45 <APDrawPoint+0xb9>
            j = 0;
     cdc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     ce3:	eb 60                	jmp    d45 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     ce5:	ff 75 fc             	pushl  -0x4(%ebp)
     ce8:	ff 75 f8             	pushl  -0x8(%ebp)
     ceb:	ff 75 08             	pushl  0x8(%ebp)
     cee:	e8 bb fb ff ff       	call   8ae <APGetIndex>
     cf3:	83 c4 0c             	add    $0xc,%esp
     cf6:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     cf9:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cfd:	74 55                	je     d54 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cff:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d03:	74 67                	je     d6c <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d05:	ff 75 10             	pushl  0x10(%ebp)
     d08:	ff 75 0c             	pushl  0xc(%ebp)
     d0b:	ff 75 fc             	pushl  -0x4(%ebp)
     d0e:	ff 75 f8             	pushl  -0x8(%ebp)
     d11:	e8 5f fb ff ff       	call   875 <distance_2>
     d16:	83 c4 10             	add    $0x10,%esp
     d19:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d1c:	7f 23                	jg     d41 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d1e:	8b 45 08             	mov    0x8(%ebp),%eax
     d21:	8b 48 18             	mov    0x18(%eax),%ecx
     d24:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d27:	89 d0                	mov    %edx,%eax
     d29:	01 c0                	add    %eax,%eax
     d2b:	01 d0                	add    %edx,%eax
     d2d:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d30:	8b 45 08             	mov    0x8(%ebp),%eax
     d33:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d37:	66 89 0a             	mov    %cx,(%edx)
     d3a:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d3e:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d41:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d45:	8b 55 0c             	mov    0xc(%ebp),%edx
     d48:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d4b:	01 d0                	add    %edx,%eax
     d4d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d50:	7d 93                	jge    ce5 <APDrawPoint+0x59>
     d52:	eb 01                	jmp    d55 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d54:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d55:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d59:	8b 55 10             	mov    0x10(%ebp),%edx
     d5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d5f:	01 d0                	add    %edx,%eax
     d61:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d64:	0f 8d 63 ff ff ff    	jge    ccd <APDrawPoint+0x41>
     d6a:	eb 01                	jmp    d6d <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d6c:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d6d:	c9                   	leave  
     d6e:	c3                   	ret    

00000d6f <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d6f:	55                   	push   %ebp
     d70:	89 e5                	mov    %esp,%ebp
     d72:	53                   	push   %ebx
     d73:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d76:	8b 45 0c             	mov    0xc(%ebp),%eax
     d79:	3b 45 14             	cmp    0x14(%ebp),%eax
     d7c:	0f 85 80 00 00 00    	jne    e02 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d82:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d86:	0f 88 9d 02 00 00    	js     1029 <APDrawLine+0x2ba>
     d8c:	8b 45 08             	mov    0x8(%ebp),%eax
     d8f:	8b 00                	mov    (%eax),%eax
     d91:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d94:	0f 8e 8f 02 00 00    	jle    1029 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d9a:	8b 45 10             	mov    0x10(%ebp),%eax
     d9d:	3b 45 18             	cmp    0x18(%ebp),%eax
     da0:	7e 12                	jle    db4 <APDrawLine+0x45>
        {
            int tmp = y2;
     da2:	8b 45 18             	mov    0x18(%ebp),%eax
     da5:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     da8:	8b 45 10             	mov    0x10(%ebp),%eax
     dab:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     dae:	8b 45 dc             	mov    -0x24(%ebp),%eax
     db1:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     db4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     db8:	79 07                	jns    dc1 <APDrawLine+0x52>
     dba:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     dc1:	8b 45 08             	mov    0x8(%ebp),%eax
     dc4:	8b 40 04             	mov    0x4(%eax),%eax
     dc7:	3b 45 18             	cmp    0x18(%ebp),%eax
     dca:	7d 0c                	jge    dd8 <APDrawLine+0x69>
     dcc:	8b 45 08             	mov    0x8(%ebp),%eax
     dcf:	8b 40 04             	mov    0x4(%eax),%eax
     dd2:	83 e8 01             	sub    $0x1,%eax
     dd5:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     dd8:	8b 45 10             	mov    0x10(%ebp),%eax
     ddb:	89 45 f4             	mov    %eax,-0xc(%ebp)
     dde:	eb 15                	jmp    df5 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     de0:	ff 75 f4             	pushl  -0xc(%ebp)
     de3:	ff 75 0c             	pushl  0xc(%ebp)
     de6:	ff 75 08             	pushl  0x8(%ebp)
     de9:	e8 9e fe ff ff       	call   c8c <APDrawPoint>
     dee:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     df1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     df5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df8:	3b 45 18             	cmp    0x18(%ebp),%eax
     dfb:	7e e3                	jle    de0 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     dfd:	e9 2b 02 00 00       	jmp    102d <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e02:	8b 45 10             	mov    0x10(%ebp),%eax
     e05:	3b 45 18             	cmp    0x18(%ebp),%eax
     e08:	75 7f                	jne    e89 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e0a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e0e:	0f 88 18 02 00 00    	js     102c <APDrawLine+0x2bd>
     e14:	8b 45 08             	mov    0x8(%ebp),%eax
     e17:	8b 40 04             	mov    0x4(%eax),%eax
     e1a:	3b 45 10             	cmp    0x10(%ebp),%eax
     e1d:	0f 8e 09 02 00 00    	jle    102c <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e23:	8b 45 0c             	mov    0xc(%ebp),%eax
     e26:	3b 45 14             	cmp    0x14(%ebp),%eax
     e29:	7e 12                	jle    e3d <APDrawLine+0xce>
        {
            int tmp = x2;
     e2b:	8b 45 14             	mov    0x14(%ebp),%eax
     e2e:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e31:	8b 45 0c             	mov    0xc(%ebp),%eax
     e34:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e37:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e3a:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e3d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e41:	79 07                	jns    e4a <APDrawLine+0xdb>
     e43:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e4a:	8b 45 08             	mov    0x8(%ebp),%eax
     e4d:	8b 00                	mov    (%eax),%eax
     e4f:	3b 45 14             	cmp    0x14(%ebp),%eax
     e52:	7d 0b                	jge    e5f <APDrawLine+0xf0>
     e54:	8b 45 08             	mov    0x8(%ebp),%eax
     e57:	8b 00                	mov    (%eax),%eax
     e59:	83 e8 01             	sub    $0x1,%eax
     e5c:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e5f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e62:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e65:	eb 15                	jmp    e7c <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e67:	ff 75 10             	pushl  0x10(%ebp)
     e6a:	ff 75 f0             	pushl  -0x10(%ebp)
     e6d:	ff 75 08             	pushl  0x8(%ebp)
     e70:	e8 17 fe ff ff       	call   c8c <APDrawPoint>
     e75:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e78:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e7f:	3b 45 14             	cmp    0x14(%ebp),%eax
     e82:	7e e3                	jle    e67 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e84:	e9 a4 01 00 00       	jmp    102d <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e89:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e90:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e97:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9a:	2b 45 14             	sub    0x14(%ebp),%eax
     e9d:	50                   	push   %eax
     e9e:	e8 fb f9 ff ff       	call   89e <abs_int>
     ea3:	83 c4 04             	add    $0x4,%esp
     ea6:	89 c3                	mov    %eax,%ebx
     ea8:	8b 45 10             	mov    0x10(%ebp),%eax
     eab:	2b 45 18             	sub    0x18(%ebp),%eax
     eae:	50                   	push   %eax
     eaf:	e8 ea f9 ff ff       	call   89e <abs_int>
     eb4:	83 c4 04             	add    $0x4,%esp
     eb7:	39 c3                	cmp    %eax,%ebx
     eb9:	0f 8e b5 00 00 00    	jle    f74 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     ebf:	8b 45 10             	mov    0x10(%ebp),%eax
     ec2:	2b 45 18             	sub    0x18(%ebp),%eax
     ec5:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ec8:	db 45 b0             	fildl  -0x50(%ebp)
     ecb:	8b 45 0c             	mov    0xc(%ebp),%eax
     ece:	2b 45 14             	sub    0x14(%ebp),%eax
     ed1:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ed4:	db 45 b0             	fildl  -0x50(%ebp)
     ed7:	de f9                	fdivrp %st,%st(1)
     ed9:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     edc:	8b 45 14             	mov    0x14(%ebp),%eax
     edf:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ee2:	7e 0e                	jle    ef2 <APDrawLine+0x183>
        {
            s = x1;
     ee4:	8b 45 0c             	mov    0xc(%ebp),%eax
     ee7:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     eea:	8b 45 14             	mov    0x14(%ebp),%eax
     eed:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ef0:	eb 0c                	jmp    efe <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ef2:	8b 45 14             	mov    0x14(%ebp),%eax
     ef5:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     ef8:	8b 45 0c             	mov    0xc(%ebp),%eax
     efb:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     efe:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f02:	79 07                	jns    f0b <APDrawLine+0x19c>
     f04:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f0b:	8b 45 08             	mov    0x8(%ebp),%eax
     f0e:	8b 00                	mov    (%eax),%eax
     f10:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f13:	7f 0b                	jg     f20 <APDrawLine+0x1b1>
     f15:	8b 45 08             	mov    0x8(%ebp),%eax
     f18:	8b 00                	mov    (%eax),%eax
     f1a:	83 e8 01             	sub    $0x1,%eax
     f1d:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f20:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f23:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f26:	eb 3f                	jmp    f67 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f2b:	2b 45 0c             	sub    0xc(%ebp),%eax
     f2e:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f31:	db 45 b0             	fildl  -0x50(%ebp)
     f34:	dc 4d d0             	fmull  -0x30(%ebp)
     f37:	db 45 10             	fildl  0x10(%ebp)
     f3a:	de c1                	faddp  %st,%st(1)
     f3c:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f3f:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f43:	b4 0c                	mov    $0xc,%ah
     f45:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f49:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f4c:	db 5d cc             	fistpl -0x34(%ebp)
     f4f:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f52:	ff 75 cc             	pushl  -0x34(%ebp)
     f55:	ff 75 e4             	pushl  -0x1c(%ebp)
     f58:	ff 75 08             	pushl  0x8(%ebp)
     f5b:	e8 2c fd ff ff       	call   c8c <APDrawPoint>
     f60:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f63:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f67:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f6a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f6d:	7e b9                	jle    f28 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f6f:	e9 b9 00 00 00       	jmp    102d <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f74:	8b 45 0c             	mov    0xc(%ebp),%eax
     f77:	2b 45 14             	sub    0x14(%ebp),%eax
     f7a:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f7d:	db 45 b0             	fildl  -0x50(%ebp)
     f80:	8b 45 10             	mov    0x10(%ebp),%eax
     f83:	2b 45 18             	sub    0x18(%ebp),%eax
     f86:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f89:	db 45 b0             	fildl  -0x50(%ebp)
     f8c:	de f9                	fdivrp %st,%st(1)
     f8e:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f91:	8b 45 10             	mov    0x10(%ebp),%eax
     f94:	3b 45 18             	cmp    0x18(%ebp),%eax
     f97:	7e 0e                	jle    fa7 <APDrawLine+0x238>
    {
        s = y2;
     f99:	8b 45 18             	mov    0x18(%ebp),%eax
     f9c:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f9f:	8b 45 10             	mov    0x10(%ebp),%eax
     fa2:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fa5:	eb 0c                	jmp    fb3 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     fa7:	8b 45 10             	mov    0x10(%ebp),%eax
     faa:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     fad:	8b 45 18             	mov    0x18(%ebp),%eax
     fb0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     fb3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fb7:	79 07                	jns    fc0 <APDrawLine+0x251>
     fb9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     fc0:	8b 45 08             	mov    0x8(%ebp),%eax
     fc3:	8b 40 04             	mov    0x4(%eax),%eax
     fc6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fc9:	7f 0c                	jg     fd7 <APDrawLine+0x268>
     fcb:	8b 45 08             	mov    0x8(%ebp),%eax
     fce:	8b 40 04             	mov    0x4(%eax),%eax
     fd1:	83 e8 01             	sub    $0x1,%eax
     fd4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     fd7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fda:	89 45 e0             	mov    %eax,-0x20(%ebp)
     fdd:	eb 3f                	jmp    101e <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     fdf:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fe2:	2b 45 10             	sub    0x10(%ebp),%eax
     fe5:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fe8:	db 45 b0             	fildl  -0x50(%ebp)
     feb:	dc 4d c0             	fmull  -0x40(%ebp)
     fee:	db 45 0c             	fildl  0xc(%ebp)
     ff1:	de c1                	faddp  %st,%st(1)
     ff3:	d9 7d b6             	fnstcw -0x4a(%ebp)
     ff6:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     ffa:	b4 0c                	mov    $0xc,%ah
     ffc:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1000:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1003:	db 5d bc             	fistpl -0x44(%ebp)
    1006:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1009:	ff 75 e0             	pushl  -0x20(%ebp)
    100c:	ff 75 bc             	pushl  -0x44(%ebp)
    100f:	ff 75 08             	pushl  0x8(%ebp)
    1012:	e8 75 fc ff ff       	call   c8c <APDrawPoint>
    1017:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    101a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    101e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1021:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1024:	7e b9                	jle    fdf <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1026:	90                   	nop
    1027:	eb 04                	jmp    102d <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1029:	90                   	nop
    102a:	eb 01                	jmp    102d <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    102c:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    102d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1030:	c9                   	leave  
    1031:	c3                   	ret    

00001032 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1032:	55                   	push   %ebp
    1033:	89 e5                	mov    %esp,%ebp
    1035:	53                   	push   %ebx
    1036:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1039:	8b 55 10             	mov    0x10(%ebp),%edx
    103c:	8b 45 18             	mov    0x18(%ebp),%eax
    103f:	01 d0                	add    %edx,%eax
    1041:	83 e8 01             	sub    $0x1,%eax
    1044:	83 ec 04             	sub    $0x4,%esp
    1047:	50                   	push   %eax
    1048:	ff 75 0c             	pushl  0xc(%ebp)
    104b:	ff 75 10             	pushl  0x10(%ebp)
    104e:	ff 75 0c             	pushl  0xc(%ebp)
    1051:	ff 75 08             	pushl  0x8(%ebp)
    1054:	e8 16 fd ff ff       	call   d6f <APDrawLine>
    1059:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    105c:	8b 55 0c             	mov    0xc(%ebp),%edx
    105f:	8b 45 14             	mov    0x14(%ebp),%eax
    1062:	01 d0                	add    %edx,%eax
    1064:	83 e8 01             	sub    $0x1,%eax
    1067:	83 ec 04             	sub    $0x4,%esp
    106a:	ff 75 10             	pushl  0x10(%ebp)
    106d:	50                   	push   %eax
    106e:	ff 75 10             	pushl  0x10(%ebp)
    1071:	ff 75 0c             	pushl  0xc(%ebp)
    1074:	ff 75 08             	pushl  0x8(%ebp)
    1077:	e8 f3 fc ff ff       	call   d6f <APDrawLine>
    107c:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    107f:	8b 55 10             	mov    0x10(%ebp),%edx
    1082:	8b 45 18             	mov    0x18(%ebp),%eax
    1085:	01 d0                	add    %edx,%eax
    1087:	8d 48 ff             	lea    -0x1(%eax),%ecx
    108a:	8b 55 0c             	mov    0xc(%ebp),%edx
    108d:	8b 45 14             	mov    0x14(%ebp),%eax
    1090:	01 d0                	add    %edx,%eax
    1092:	8d 50 ff             	lea    -0x1(%eax),%edx
    1095:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1098:	8b 45 14             	mov    0x14(%ebp),%eax
    109b:	01 d8                	add    %ebx,%eax
    109d:	83 e8 01             	sub    $0x1,%eax
    10a0:	83 ec 04             	sub    $0x4,%esp
    10a3:	51                   	push   %ecx
    10a4:	52                   	push   %edx
    10a5:	ff 75 10             	pushl  0x10(%ebp)
    10a8:	50                   	push   %eax
    10a9:	ff 75 08             	pushl  0x8(%ebp)
    10ac:	e8 be fc ff ff       	call   d6f <APDrawLine>
    10b1:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10b4:	8b 55 10             	mov    0x10(%ebp),%edx
    10b7:	8b 45 18             	mov    0x18(%ebp),%eax
    10ba:	01 d0                	add    %edx,%eax
    10bc:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10bf:	8b 55 0c             	mov    0xc(%ebp),%edx
    10c2:	8b 45 14             	mov    0x14(%ebp),%eax
    10c5:	01 d0                	add    %edx,%eax
    10c7:	8d 50 ff             	lea    -0x1(%eax),%edx
    10ca:	8b 5d 10             	mov    0x10(%ebp),%ebx
    10cd:	8b 45 18             	mov    0x18(%ebp),%eax
    10d0:	01 d8                	add    %ebx,%eax
    10d2:	83 e8 01             	sub    $0x1,%eax
    10d5:	83 ec 04             	sub    $0x4,%esp
    10d8:	51                   	push   %ecx
    10d9:	52                   	push   %edx
    10da:	50                   	push   %eax
    10db:	ff 75 0c             	pushl  0xc(%ebp)
    10de:	ff 75 08             	pushl  0x8(%ebp)
    10e1:	e8 89 fc ff ff       	call   d6f <APDrawLine>
    10e6:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10e9:	8b 55 0c             	mov    0xc(%ebp),%edx
    10ec:	8b 45 14             	mov    0x14(%ebp),%eax
    10ef:	01 d0                	add    %edx,%eax
    10f1:	8d 50 ff             	lea    -0x1(%eax),%edx
    10f4:	8b 45 08             	mov    0x8(%ebp),%eax
    10f7:	8b 40 0c             	mov    0xc(%eax),%eax
    10fa:	89 c1                	mov    %eax,%ecx
    10fc:	c1 e9 1f             	shr    $0x1f,%ecx
    10ff:	01 c8                	add    %ecx,%eax
    1101:	d1 f8                	sar    %eax
    1103:	29 c2                	sub    %eax,%edx
    1105:	89 d0                	mov    %edx,%eax
    1107:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    110a:	8b 55 10             	mov    0x10(%ebp),%edx
    110d:	8b 45 18             	mov    0x18(%ebp),%eax
    1110:	01 d0                	add    %edx,%eax
    1112:	8d 50 ff             	lea    -0x1(%eax),%edx
    1115:	8b 45 08             	mov    0x8(%ebp),%eax
    1118:	8b 40 0c             	mov    0xc(%eax),%eax
    111b:	89 c1                	mov    %eax,%ecx
    111d:	c1 e9 1f             	shr    $0x1f,%ecx
    1120:	01 c8                	add    %ecx,%eax
    1122:	d1 f8                	sar    %eax
    1124:	29 c2                	sub    %eax,%edx
    1126:	89 d0                	mov    %edx,%eax
    1128:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    112b:	8b 45 08             	mov    0x8(%ebp),%eax
    112e:	8b 40 0c             	mov    0xc(%eax),%eax
    1131:	89 c2                	mov    %eax,%edx
    1133:	c1 ea 1f             	shr    $0x1f,%edx
    1136:	01 d0                	add    %edx,%eax
    1138:	d1 f8                	sar    %eax
    113a:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    113d:	8b 45 08             	mov    0x8(%ebp),%eax
    1140:	8b 40 0c             	mov    0xc(%eax),%eax
    1143:	89 c2                	mov    %eax,%edx
    1145:	c1 ea 1f             	shr    $0x1f,%edx
    1148:	01 d0                	add    %edx,%eax
    114a:	d1 f8                	sar    %eax
    114c:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    114f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1153:	0f 88 d8 00 00 00    	js     1231 <APDrawRect+0x1ff>
    1159:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    115d:	0f 88 ce 00 00 00    	js     1231 <APDrawRect+0x1ff>
    1163:	8b 45 08             	mov    0x8(%ebp),%eax
    1166:	8b 00                	mov    (%eax),%eax
    1168:	3b 45 0c             	cmp    0xc(%ebp),%eax
    116b:	0f 8e c0 00 00 00    	jle    1231 <APDrawRect+0x1ff>
    1171:	8b 45 08             	mov    0x8(%ebp),%eax
    1174:	8b 40 04             	mov    0x4(%eax),%eax
    1177:	3b 45 10             	cmp    0x10(%ebp),%eax
    117a:	0f 8e b1 00 00 00    	jle    1231 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1180:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1184:	79 07                	jns    118d <APDrawRect+0x15b>
    1186:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    118d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1191:	79 07                	jns    119a <APDrawRect+0x168>
    1193:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    119a:	8b 45 08             	mov    0x8(%ebp),%eax
    119d:	8b 00                	mov    (%eax),%eax
    119f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11a2:	7f 0b                	jg     11af <APDrawRect+0x17d>
    11a4:	8b 45 08             	mov    0x8(%ebp),%eax
    11a7:	8b 00                	mov    (%eax),%eax
    11a9:	83 e8 01             	sub    $0x1,%eax
    11ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    11af:	8b 45 08             	mov    0x8(%ebp),%eax
    11b2:	8b 40 04             	mov    0x4(%eax),%eax
    11b5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11b8:	7f 0c                	jg     11c6 <APDrawRect+0x194>
    11ba:	8b 45 08             	mov    0x8(%ebp),%eax
    11bd:	8b 40 04             	mov    0x4(%eax),%eax
    11c0:	83 e8 01             	sub    $0x1,%eax
    11c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    11c6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11cd:	8b 45 0c             	mov    0xc(%ebp),%eax
    11d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11d3:	eb 52                	jmp    1227 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    11d5:	8b 45 10             	mov    0x10(%ebp),%eax
    11d8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11db:	eb 3e                	jmp    121b <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    11dd:	83 ec 04             	sub    $0x4,%esp
    11e0:	ff 75 e8             	pushl  -0x18(%ebp)
    11e3:	ff 75 ec             	pushl  -0x14(%ebp)
    11e6:	ff 75 08             	pushl  0x8(%ebp)
    11e9:	e8 c0 f6 ff ff       	call   8ae <APGetIndex>
    11ee:	83 c4 10             	add    $0x10,%esp
    11f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11f4:	8b 45 08             	mov    0x8(%ebp),%eax
    11f7:	8b 48 18             	mov    0x18(%eax),%ecx
    11fa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11fd:	89 d0                	mov    %edx,%eax
    11ff:	01 c0                	add    %eax,%eax
    1201:	01 d0                	add    %edx,%eax
    1203:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1206:	8b 45 08             	mov    0x8(%ebp),%eax
    1209:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    120d:	66 89 0a             	mov    %cx,(%edx)
    1210:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1214:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1217:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    121b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    121e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1221:	7e ba                	jle    11dd <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1223:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1227:	8b 45 ec             	mov    -0x14(%ebp),%eax
    122a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    122d:	7e a6                	jle    11d5 <APDrawRect+0x1a3>
    122f:	eb 01                	jmp    1232 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1231:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1232:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1235:	c9                   	leave  
    1236:	c3                   	ret    

00001237 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1237:	55                   	push   %ebp
    1238:	89 e5                	mov    %esp,%ebp
    123a:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    123d:	83 ec 0c             	sub    $0xc,%esp
    1240:	ff 75 0c             	pushl  0xc(%ebp)
    1243:	e8 c1 ee ff ff       	call   109 <strlen>
    1248:	83 c4 10             	add    $0x10,%esp
    124b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    124e:	8b 45 08             	mov    0x8(%ebp),%eax
    1251:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1255:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1259:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    125d:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1260:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1267:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    126e:	e9 bc 00 00 00       	jmp    132f <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1273:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1276:	8b 45 0c             	mov    0xc(%ebp),%eax
    1279:	01 d0                	add    %edx,%eax
    127b:	0f b6 00             	movzbl (%eax),%eax
    127e:	0f be c0             	movsbl %al,%eax
    1281:	83 e8 20             	sub    $0x20,%eax
    1284:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1287:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    128b:	0f 87 9a 00 00 00    	ja     132b <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1291:	8b 45 08             	mov    0x8(%ebp),%eax
    1294:	8b 00                	mov    (%eax),%eax
    1296:	0f af 45 14          	imul   0x14(%ebp),%eax
    129a:	89 c2                	mov    %eax,%edx
    129c:	8b 45 10             	mov    0x10(%ebp),%eax
    129f:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    12a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12a5:	89 d0                	mov    %edx,%eax
    12a7:	c1 e0 03             	shl    $0x3,%eax
    12aa:	01 d0                	add    %edx,%eax
    12ac:	01 c8                	add    %ecx,%eax
    12ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    12b1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    12b8:	eb 6b                	jmp    1325 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    12ba:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    12c1:	eb 50                	jmp    1313 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    12c3:	8b 55 ec             	mov    -0x14(%ebp),%edx
    12c6:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12c9:	89 d0                	mov    %edx,%eax
    12cb:	c1 e0 03             	shl    $0x3,%eax
    12ce:	01 d0                	add    %edx,%eax
    12d0:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    12d6:	01 c2                	add    %eax,%edx
    12d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12db:	01 d0                	add    %edx,%eax
    12dd:	05 40 2b 00 00       	add    $0x2b40,%eax
    12e2:	0f b6 00             	movzbl (%eax),%eax
    12e5:	84 c0                	test   %al,%al
    12e7:	74 26                	je     130f <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    12e9:	8b 45 08             	mov    0x8(%ebp),%eax
    12ec:	8b 50 18             	mov    0x18(%eax),%edx
    12ef:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    12f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12f5:	01 c8                	add    %ecx,%eax
    12f7:	89 c1                	mov    %eax,%ecx
    12f9:	89 c8                	mov    %ecx,%eax
    12fb:	01 c0                	add    %eax,%eax
    12fd:	01 c8                	add    %ecx,%eax
    12ff:	01 d0                	add    %edx,%eax
    1301:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1305:	66 89 10             	mov    %dx,(%eax)
    1308:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    130c:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    130f:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1313:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1317:	7e aa                	jle    12c3 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1319:	8b 45 08             	mov    0x8(%ebp),%eax
    131c:	8b 00                	mov    (%eax),%eax
    131e:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1321:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1325:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1329:	7e 8f                	jle    12ba <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    132b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    132f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1332:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1335:	0f 82 38 ff ff ff    	jb     1273 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    133b:	90                   	nop
    133c:	c9                   	leave  
    133d:	c3                   	ret    

0000133e <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    133e:	55                   	push   %ebp
    133f:	89 e5                	mov    %esp,%ebp
    1341:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1344:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1348:	0f 88 8e 01 00 00    	js     14dc <APDcCopy+0x19e>
    134e:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1352:	0f 88 84 01 00 00    	js     14dc <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1358:	8b 55 0c             	mov    0xc(%ebp),%edx
    135b:	8b 45 20             	mov    0x20(%ebp),%eax
    135e:	01 d0                	add    %edx,%eax
    1360:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1363:	8b 55 10             	mov    0x10(%ebp),%edx
    1366:	8b 45 24             	mov    0x24(%ebp),%eax
    1369:	01 d0                	add    %edx,%eax
    136b:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    136e:	8b 55 18             	mov    0x18(%ebp),%edx
    1371:	8b 45 20             	mov    0x20(%ebp),%eax
    1374:	01 d0                	add    %edx,%eax
    1376:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1379:	8b 55 1c             	mov    0x1c(%ebp),%edx
    137c:	8b 45 24             	mov    0x24(%ebp),%eax
    137f:	01 d0                	add    %edx,%eax
    1381:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1384:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1388:	0f 88 51 01 00 00    	js     14df <APDcCopy+0x1a1>
    138e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1392:	0f 88 47 01 00 00    	js     14df <APDcCopy+0x1a1>
    1398:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    139c:	0f 88 3d 01 00 00    	js     14df <APDcCopy+0x1a1>
    13a2:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    13a6:	0f 88 33 01 00 00    	js     14df <APDcCopy+0x1a1>
    13ac:	8b 45 14             	mov    0x14(%ebp),%eax
    13af:	8b 00                	mov    (%eax),%eax
    13b1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13b4:	0f 8c 25 01 00 00    	jl     14df <APDcCopy+0x1a1>
    13ba:	8b 45 14             	mov    0x14(%ebp),%eax
    13bd:	8b 40 04             	mov    0x4(%eax),%eax
    13c0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    13c3:	0f 8c 16 01 00 00    	jl     14df <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    13c9:	8b 45 08             	mov    0x8(%ebp),%eax
    13cc:	8b 00                	mov    (%eax),%eax
    13ce:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    13d1:	7f 0b                	jg     13de <APDcCopy+0xa0>
    13d3:	8b 45 08             	mov    0x8(%ebp),%eax
    13d6:	8b 00                	mov    (%eax),%eax
    13d8:	83 e8 01             	sub    $0x1,%eax
    13db:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    13de:	8b 45 08             	mov    0x8(%ebp),%eax
    13e1:	8b 40 04             	mov    0x4(%eax),%eax
    13e4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13e7:	7f 0c                	jg     13f5 <APDcCopy+0xb7>
    13e9:	8b 45 08             	mov    0x8(%ebp),%eax
    13ec:	8b 40 04             	mov    0x4(%eax),%eax
    13ef:	83 e8 01             	sub    $0x1,%eax
    13f2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    13f5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    13fc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1403:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    140a:	e9 bc 00 00 00       	jmp    14cb <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    140f:	8b 45 08             	mov    0x8(%ebp),%eax
    1412:	8b 00                	mov    (%eax),%eax
    1414:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1417:	8b 55 10             	mov    0x10(%ebp),%edx
    141a:	01 ca                	add    %ecx,%edx
    141c:	0f af d0             	imul   %eax,%edx
    141f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1422:	01 d0                	add    %edx,%eax
    1424:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1427:	8b 45 14             	mov    0x14(%ebp),%eax
    142a:	8b 00                	mov    (%eax),%eax
    142c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    142f:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1432:	01 ca                	add    %ecx,%edx
    1434:	0f af d0             	imul   %eax,%edx
    1437:	8b 45 18             	mov    0x18(%ebp),%eax
    143a:	01 d0                	add    %edx,%eax
    143c:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    143f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1446:	eb 74                	jmp    14bc <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1448:	8b 45 14             	mov    0x14(%ebp),%eax
    144b:	8b 50 18             	mov    0x18(%eax),%edx
    144e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1451:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1454:	01 c8                	add    %ecx,%eax
    1456:	89 c1                	mov    %eax,%ecx
    1458:	89 c8                	mov    %ecx,%eax
    145a:	01 c0                	add    %eax,%eax
    145c:	01 c8                	add    %ecx,%eax
    145e:	01 d0                	add    %edx,%eax
    1460:	0f b7 10             	movzwl (%eax),%edx
    1463:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1467:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    146b:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    146e:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1472:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1476:	38 c2                	cmp    %al,%dl
    1478:	75 18                	jne    1492 <APDcCopy+0x154>
    147a:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    147e:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1482:	38 c2                	cmp    %al,%dl
    1484:	75 0c                	jne    1492 <APDcCopy+0x154>
    1486:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    148a:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    148e:	38 c2                	cmp    %al,%dl
    1490:	74 26                	je     14b8 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1492:	8b 45 08             	mov    0x8(%ebp),%eax
    1495:	8b 50 18             	mov    0x18(%eax),%edx
    1498:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    149b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    149e:	01 c8                	add    %ecx,%eax
    14a0:	89 c1                	mov    %eax,%ecx
    14a2:	89 c8                	mov    %ecx,%eax
    14a4:	01 c0                	add    %eax,%eax
    14a6:	01 c8                	add    %ecx,%eax
    14a8:	01 d0                	add    %edx,%eax
    14aa:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    14ae:	66 89 10             	mov    %dx,(%eax)
    14b1:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    14b5:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    14b8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14bf:	2b 45 0c             	sub    0xc(%ebp),%eax
    14c2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14c5:	7d 81                	jge    1448 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    14c7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14ce:	2b 45 10             	sub    0x10(%ebp),%eax
    14d1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14d4:	0f 8d 35 ff ff ff    	jge    140f <APDcCopy+0xd1>
    14da:	eb 04                	jmp    14e0 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    14dc:	90                   	nop
    14dd:	eb 01                	jmp    14e0 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    14df:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    14e0:	c9                   	leave  
    14e1:	c3                   	ret    

000014e2 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    14e2:	55                   	push   %ebp
    14e3:	89 e5                	mov    %esp,%ebp
    14e5:	83 ec 1c             	sub    $0x1c,%esp
    14e8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    14eb:	8b 55 10             	mov    0x10(%ebp),%edx
    14ee:	8b 45 14             	mov    0x14(%ebp),%eax
    14f1:	88 4d ec             	mov    %cl,-0x14(%ebp)
    14f4:	88 55 e8             	mov    %dl,-0x18(%ebp)
    14f7:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    14fa:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    14fe:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1501:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1505:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1508:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    150c:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    150f:	8b 45 08             	mov    0x8(%ebp),%eax
    1512:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1516:	66 89 10             	mov    %dx,(%eax)
    1519:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    151d:	88 50 02             	mov    %dl,0x2(%eax)
}
    1520:	8b 45 08             	mov    0x8(%ebp),%eax
    1523:	c9                   	leave  
    1524:	c2 04 00             	ret    $0x4

00001527 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1527:	55                   	push   %ebp
    1528:	89 e5                	mov    %esp,%ebp
    152a:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    152d:	8b 45 08             	mov    0x8(%ebp),%eax
    1530:	8b 00                	mov    (%eax),%eax
    1532:	83 ec 08             	sub    $0x8,%esp
    1535:	8d 55 0c             	lea    0xc(%ebp),%edx
    1538:	52                   	push   %edx
    1539:	50                   	push   %eax
    153a:	e8 34 ee ff ff       	call   373 <sendMessage>
    153f:	83 c4 10             	add    $0x10,%esp
}
    1542:	90                   	nop
    1543:	c9                   	leave  
    1544:	c3                   	ret    

00001545 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1545:	55                   	push   %ebp
    1546:	89 e5                	mov    %esp,%ebp
    1548:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    154b:	83 ec 0c             	sub    $0xc,%esp
    154e:	68 98 00 00 00       	push   $0x98
    1553:	e8 f5 f1 ff ff       	call   74d <malloc>
    1558:	83 c4 10             	add    $0x10,%esp
    155b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    155e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1562:	75 15                	jne    1579 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1564:	83 ec 04             	sub    $0x4,%esp
    1567:	ff 75 08             	pushl  0x8(%ebp)
    156a:	68 28 24 00 00       	push   $0x2428
    156f:	6a 01                	push   $0x1
    1571:	e8 04 ef ff ff       	call   47a <printf>
    1576:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1579:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157c:	05 84 00 00 00       	add    $0x84,%eax
    1581:	83 ec 08             	sub    $0x8,%esp
    1584:	ff 75 08             	pushl  0x8(%ebp)
    1587:	50                   	push   %eax
    1588:	e8 0d eb ff ff       	call   9a <strcpy>
    158d:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1590:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1593:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    159a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159d:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a7:	8b 40 3c             	mov    0x3c(%eax),%eax
    15aa:	89 c2                	mov    %eax,%edx
    15ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15af:	8b 40 40             	mov    0x40(%eax),%eax
    15b2:	0f af d0             	imul   %eax,%edx
    15b5:	89 d0                	mov    %edx,%eax
    15b7:	01 c0                	add    %eax,%eax
    15b9:	01 d0                	add    %edx,%eax
    15bb:	83 ec 0c             	sub    $0xc,%esp
    15be:	50                   	push   %eax
    15bf:	e8 89 f1 ff ff       	call   74d <malloc>
    15c4:	83 c4 10             	add    $0x10,%esp
    15c7:	89 c2                	mov    %eax,%edx
    15c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cc:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    15cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d2:	8b 40 54             	mov    0x54(%eax),%eax
    15d5:	85 c0                	test   %eax,%eax
    15d7:	75 15                	jne    15ee <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    15d9:	83 ec 04             	sub    $0x4,%esp
    15dc:	ff 75 08             	pushl  0x8(%ebp)
    15df:	68 48 24 00 00       	push   $0x2448
    15e4:	6a 01                	push   $0x1
    15e6:	e8 8f ee ff ff       	call   47a <printf>
    15eb:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f1:	8b 40 3c             	mov    0x3c(%eax),%eax
    15f4:	89 c2                	mov    %eax,%edx
    15f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f9:	8b 40 40             	mov    0x40(%eax),%eax
    15fc:	0f af d0             	imul   %eax,%edx
    15ff:	89 d0                	mov    %edx,%eax
    1601:	01 c0                	add    %eax,%eax
    1603:	01 c2                	add    %eax,%edx
    1605:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1608:	8b 40 54             	mov    0x54(%eax),%eax
    160b:	83 ec 04             	sub    $0x4,%esp
    160e:	52                   	push   %edx
    160f:	68 ff ff ff 00       	push   $0xffffff
    1614:	50                   	push   %eax
    1615:	e8 16 eb ff ff       	call   130 <memset>
    161a:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    161d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1620:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1627:	e8 1f ed ff ff       	call   34b <getpid>
    162c:	89 c2                	mov    %eax,%edx
    162e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1631:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1634:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1637:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    163e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1641:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1648:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164b:	8b 40 58             	mov    0x58(%eax),%eax
    164e:	89 c2                	mov    %eax,%edx
    1650:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1653:	8b 40 5c             	mov    0x5c(%eax),%eax
    1656:	0f af d0             	imul   %eax,%edx
    1659:	89 d0                	mov    %edx,%eax
    165b:	01 c0                	add    %eax,%eax
    165d:	01 d0                	add    %edx,%eax
    165f:	83 ec 0c             	sub    $0xc,%esp
    1662:	50                   	push   %eax
    1663:	e8 e5 f0 ff ff       	call   74d <malloc>
    1668:	83 c4 10             	add    $0x10,%esp
    166b:	89 c2                	mov    %eax,%edx
    166d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1670:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1673:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1676:	8b 40 70             	mov    0x70(%eax),%eax
    1679:	85 c0                	test   %eax,%eax
    167b:	75 15                	jne    1692 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    167d:	83 ec 04             	sub    $0x4,%esp
    1680:	ff 75 08             	pushl  0x8(%ebp)
    1683:	68 6c 24 00 00       	push   $0x246c
    1688:	6a 01                	push   $0x1
    168a:	e8 eb ed ff ff       	call   47a <printf>
    168f:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1692:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1695:	8b 40 3c             	mov    0x3c(%eax),%eax
    1698:	89 c2                	mov    %eax,%edx
    169a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169d:	8b 40 40             	mov    0x40(%eax),%eax
    16a0:	0f af d0             	imul   %eax,%edx
    16a3:	89 d0                	mov    %edx,%eax
    16a5:	01 c0                	add    %eax,%eax
    16a7:	01 c2                	add    %eax,%edx
    16a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ac:	8b 40 54             	mov    0x54(%eax),%eax
    16af:	83 ec 04             	sub    $0x4,%esp
    16b2:	52                   	push   %edx
    16b3:	68 ff 00 00 00       	push   $0xff
    16b8:	50                   	push   %eax
    16b9:	e8 72 ea ff ff       	call   130 <memset>
    16be:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    16c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c4:	8b 55 0c             	mov    0xc(%ebp),%edx
    16c7:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    16ca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16ce:	74 49                	je     1719 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    16d0:	8b 45 10             	mov    0x10(%ebp),%eax
    16d3:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    16d9:	83 ec 0c             	sub    $0xc,%esp
    16dc:	50                   	push   %eax
    16dd:	e8 6b f0 ff ff       	call   74d <malloc>
    16e2:	83 c4 10             	add    $0x10,%esp
    16e5:	89 c2                	mov    %eax,%edx
    16e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ea:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    16ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f0:	8b 55 10             	mov    0x10(%ebp),%edx
    16f3:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    16f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f9:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1700:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1703:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    170a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1714:	e9 8d 00 00 00       	jmp    17a6 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1719:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171c:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1723:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1726:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    172d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1730:	8b 40 20             	mov    0x20(%eax),%eax
    1733:	89 c2                	mov    %eax,%edx
    1735:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1738:	8b 40 24             	mov    0x24(%eax),%eax
    173b:	0f af d0             	imul   %eax,%edx
    173e:	89 d0                	mov    %edx,%eax
    1740:	01 c0                	add    %eax,%eax
    1742:	01 d0                	add    %edx,%eax
    1744:	83 ec 0c             	sub    $0xc,%esp
    1747:	50                   	push   %eax
    1748:	e8 00 f0 ff ff       	call   74d <malloc>
    174d:	83 c4 10             	add    $0x10,%esp
    1750:	89 c2                	mov    %eax,%edx
    1752:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1755:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1758:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175b:	8b 40 38             	mov    0x38(%eax),%eax
    175e:	85 c0                	test   %eax,%eax
    1760:	75 15                	jne    1777 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1762:	83 ec 04             	sub    $0x4,%esp
    1765:	ff 75 08             	pushl  0x8(%ebp)
    1768:	68 94 24 00 00       	push   $0x2494
    176d:	6a 01                	push   $0x1
    176f:	e8 06 ed ff ff       	call   47a <printf>
    1774:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1777:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177a:	8b 40 20             	mov    0x20(%eax),%eax
    177d:	89 c2                	mov    %eax,%edx
    177f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1782:	8b 40 24             	mov    0x24(%eax),%eax
    1785:	0f af d0             	imul   %eax,%edx
    1788:	89 d0                	mov    %edx,%eax
    178a:	01 c0                	add    %eax,%eax
    178c:	01 c2                	add    %eax,%edx
    178e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1791:	8b 40 38             	mov    0x38(%eax),%eax
    1794:	83 ec 04             	sub    $0x4,%esp
    1797:	52                   	push   %edx
    1798:	68 ff ff ff 00       	push   $0xffffff
    179d:	50                   	push   %eax
    179e:	e8 8d e9 ff ff       	call   130 <memset>
    17a3:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    17a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    17a9:	c9                   	leave  
    17aa:	c3                   	ret    

000017ab <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    17ab:	55                   	push   %ebp
    17ac:	89 e5                	mov    %esp,%ebp
    17ae:	57                   	push   %edi
    17af:	56                   	push   %esi
    17b0:	53                   	push   %ebx
    17b1:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    17b4:	8b 45 0c             	mov    0xc(%ebp),%eax
    17b7:	83 f8 03             	cmp    $0x3,%eax
    17ba:	74 02                	je     17be <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    17bc:	eb 7c                	jmp    183a <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    17be:	8b 45 08             	mov    0x8(%ebp),%eax
    17c1:	8b 58 1c             	mov    0x1c(%eax),%ebx
    17c4:	8b 45 08             	mov    0x8(%ebp),%eax
    17c7:	8b 48 18             	mov    0x18(%eax),%ecx
    17ca:	8b 45 08             	mov    0x8(%ebp),%eax
    17cd:	8b 50 5c             	mov    0x5c(%eax),%edx
    17d0:	8b 45 08             	mov    0x8(%ebp),%eax
    17d3:	8b 40 58             	mov    0x58(%eax),%eax
    17d6:	8b 75 08             	mov    0x8(%ebp),%esi
    17d9:	83 c6 58             	add    $0x58,%esi
    17dc:	83 ec 04             	sub    $0x4,%esp
    17df:	53                   	push   %ebx
    17e0:	51                   	push   %ecx
    17e1:	6a 00                	push   $0x0
    17e3:	52                   	push   %edx
    17e4:	50                   	push   %eax
    17e5:	6a 00                	push   $0x0
    17e7:	6a 00                	push   $0x0
    17e9:	56                   	push   %esi
    17ea:	6a 00                	push   $0x0
    17ec:	6a 00                	push   $0x0
    17ee:	ff 75 08             	pushl  0x8(%ebp)
    17f1:	e8 75 eb ff ff       	call   36b <paintWindow>
    17f6:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    17f9:	8b 45 08             	mov    0x8(%ebp),%eax
    17fc:	8b 70 1c             	mov    0x1c(%eax),%esi
    17ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1802:	8b 58 18             	mov    0x18(%eax),%ebx
    1805:	8b 45 08             	mov    0x8(%ebp),%eax
    1808:	8b 48 08             	mov    0x8(%eax),%ecx
    180b:	8b 45 08             	mov    0x8(%ebp),%eax
    180e:	8b 50 40             	mov    0x40(%eax),%edx
    1811:	8b 45 08             	mov    0x8(%ebp),%eax
    1814:	8b 40 3c             	mov    0x3c(%eax),%eax
    1817:	8b 7d 08             	mov    0x8(%ebp),%edi
    181a:	83 c7 3c             	add    $0x3c,%edi
    181d:	83 ec 04             	sub    $0x4,%esp
    1820:	56                   	push   %esi
    1821:	53                   	push   %ebx
    1822:	51                   	push   %ecx
    1823:	52                   	push   %edx
    1824:	50                   	push   %eax
    1825:	6a 00                	push   $0x0
    1827:	6a 00                	push   $0x0
    1829:	57                   	push   %edi
    182a:	6a 32                	push   $0x32
    182c:	6a 00                	push   $0x0
    182e:	ff 75 08             	pushl  0x8(%ebp)
    1831:	e8 35 eb ff ff       	call   36b <paintWindow>
    1836:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1839:	90                   	nop
        default: break;
            
            
    }
    return False;
    183a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    183f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1842:	5b                   	pop    %ebx
    1843:	5e                   	pop    %esi
    1844:	5f                   	pop    %edi
    1845:	5d                   	pop    %ebp
    1846:	c3                   	ret    

00001847 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1847:	55                   	push   %ebp
    1848:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    184a:	8b 45 0c             	mov    0xc(%ebp),%eax
    184d:	8b 50 08             	mov    0x8(%eax),%edx
    1850:	8b 45 08             	mov    0x8(%ebp),%eax
    1853:	8b 00                	mov    (%eax),%eax
    1855:	39 c2                	cmp    %eax,%edx
    1857:	74 07                	je     1860 <APPreJudge+0x19>
        return False;
    1859:	b8 00 00 00 00       	mov    $0x0,%eax
    185e:	eb 05                	jmp    1865 <APPreJudge+0x1e>
    return True;
    1860:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1865:	5d                   	pop    %ebp
    1866:	c3                   	ret    

00001867 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1867:	55                   	push   %ebp
    1868:	89 e5                	mov    %esp,%ebp
    186a:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    186d:	8b 45 08             	mov    0x8(%ebp),%eax
    1870:	8b 55 0c             	mov    0xc(%ebp),%edx
    1873:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1879:	83 ec 0c             	sub    $0xc,%esp
    187c:	ff 75 08             	pushl  0x8(%ebp)
    187f:	e8 ff ea ff ff       	call   383 <registWindow>
    1884:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1887:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    188e:	8b 45 08             	mov    0x8(%ebp),%eax
    1891:	8b 00                	mov    (%eax),%eax
    1893:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1896:	ff 75 f4             	pushl  -0xc(%ebp)
    1899:	ff 75 f0             	pushl  -0x10(%ebp)
    189c:	ff 75 ec             	pushl  -0x14(%ebp)
    189f:	ff 75 08             	pushl  0x8(%ebp)
    18a2:	e8 80 fc ff ff       	call   1527 <APSendMessage>
    18a7:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    18aa:	83 ec 0c             	sub    $0xc,%esp
    18ad:	ff 75 08             	pushl  0x8(%ebp)
    18b0:	e8 c6 ea ff ff       	call   37b <getMessage>
    18b5:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    18b8:	8b 45 08             	mov    0x8(%ebp),%eax
    18bb:	83 c0 74             	add    $0x74,%eax
    18be:	83 ec 08             	sub    $0x8,%esp
    18c1:	50                   	push   %eax
    18c2:	ff 75 08             	pushl  0x8(%ebp)
    18c5:	e8 7d ff ff ff       	call   1847 <APPreJudge>
    18ca:	83 c4 10             	add    $0x10,%esp
    18cd:	84 c0                	test   %al,%al
    18cf:	74 1b                	je     18ec <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    18d1:	8b 45 08             	mov    0x8(%ebp),%eax
    18d4:	ff 70 7c             	pushl  0x7c(%eax)
    18d7:	ff 70 78             	pushl  0x78(%eax)
    18da:	ff 70 74             	pushl  0x74(%eax)
    18dd:	ff 75 08             	pushl  0x8(%ebp)
    18e0:	8b 45 0c             	mov    0xc(%ebp),%eax
    18e3:	ff d0                	call   *%eax
    18e5:	83 c4 10             	add    $0x10,%esp
    18e8:	84 c0                	test   %al,%al
    18ea:	75 0c                	jne    18f8 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    18ec:	8b 45 08             	mov    0x8(%ebp),%eax
    18ef:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    18f6:	eb b2                	jmp    18aa <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    18f8:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    18f9:	90                   	nop
    18fa:	c9                   	leave  
    18fb:	c3                   	ret    

000018fc <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    18fc:	55                   	push   %ebp
    18fd:	89 e5                	mov    %esp,%ebp
    18ff:	57                   	push   %edi
    1900:	56                   	push   %esi
    1901:	53                   	push   %ebx
    1902:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    1905:	a1 84 67 00 00       	mov    0x6784,%eax
    190a:	85 c0                	test   %eax,%eax
    190c:	0f 85 2c 02 00 00    	jne    1b3e <APGridPaint+0x242>
    {
        iconReady = 1;
    1912:	c7 05 84 67 00 00 01 	movl   $0x1,0x6784
    1919:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    191c:	8d 45 88             	lea    -0x78(%ebp),%eax
    191f:	83 ec 08             	sub    $0x8,%esp
    1922:	68 bb 24 00 00       	push   $0x24bb
    1927:	50                   	push   %eax
    1928:	e8 d3 ef ff ff       	call   900 <APLoadBitmap>
    192d:	83 c4 0c             	add    $0xc,%esp
    1930:	8b 45 88             	mov    -0x78(%ebp),%eax
    1933:	a3 a8 67 00 00       	mov    %eax,0x67a8
    1938:	8b 45 8c             	mov    -0x74(%ebp),%eax
    193b:	a3 ac 67 00 00       	mov    %eax,0x67ac
    1940:	8b 45 90             	mov    -0x70(%ebp),%eax
    1943:	a3 b0 67 00 00       	mov    %eax,0x67b0
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1948:	83 ec 04             	sub    $0x4,%esp
    194b:	ff 35 b0 67 00 00    	pushl  0x67b0
    1951:	ff 35 ac 67 00 00    	pushl  0x67ac
    1957:	ff 35 a8 67 00 00    	pushl  0x67a8
    195d:	e8 d8 f1 ff ff       	call   b3a <APCreateCompatibleDCFromBitmap>
    1962:	83 c4 10             	add    $0x10,%esp
    1965:	a3 b4 67 00 00       	mov    %eax,0x67b4
        grid_river = APLoadBitmap ("grid_river.bmp");
    196a:	8d 45 88             	lea    -0x78(%ebp),%eax
    196d:	83 ec 08             	sub    $0x8,%esp
    1970:	68 c9 24 00 00       	push   $0x24c9
    1975:	50                   	push   %eax
    1976:	e8 85 ef ff ff       	call   900 <APLoadBitmap>
    197b:	83 c4 0c             	add    $0xc,%esp
    197e:	8b 45 88             	mov    -0x78(%ebp),%eax
    1981:	a3 e4 67 00 00       	mov    %eax,0x67e4
    1986:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1989:	a3 e8 67 00 00       	mov    %eax,0x67e8
    198e:	8b 45 90             	mov    -0x70(%ebp),%eax
    1991:	a3 ec 67 00 00       	mov    %eax,0x67ec
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1996:	83 ec 04             	sub    $0x4,%esp
    1999:	ff 35 ec 67 00 00    	pushl  0x67ec
    199f:	ff 35 e8 67 00 00    	pushl  0x67e8
    19a5:	ff 35 e4 67 00 00    	pushl  0x67e4
    19ab:	e8 8a f1 ff ff       	call   b3a <APCreateCompatibleDCFromBitmap>
    19b0:	83 c4 10             	add    $0x10,%esp
    19b3:	a3 d4 67 00 00       	mov    %eax,0x67d4
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    19b8:	8d 45 88             	lea    -0x78(%ebp),%eax
    19bb:	83 ec 08             	sub    $0x8,%esp
    19be:	68 d8 24 00 00       	push   $0x24d8
    19c3:	50                   	push   %eax
    19c4:	e8 37 ef ff ff       	call   900 <APLoadBitmap>
    19c9:	83 c4 0c             	add    $0xc,%esp
    19cc:	8b 45 88             	mov    -0x78(%ebp),%eax
    19cf:	a3 d8 67 00 00       	mov    %eax,0x67d8
    19d4:	8b 45 8c             	mov    -0x74(%ebp),%eax
    19d7:	a3 dc 67 00 00       	mov    %eax,0x67dc
    19dc:	8b 45 90             	mov    -0x70(%ebp),%eax
    19df:	a3 e0 67 00 00       	mov    %eax,0x67e0
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    19e4:	83 ec 04             	sub    $0x4,%esp
    19e7:	ff 35 e0 67 00 00    	pushl  0x67e0
    19ed:	ff 35 dc 67 00 00    	pushl  0x67dc
    19f3:	ff 35 d8 67 00 00    	pushl  0x67d8
    19f9:	e8 3c f1 ff ff       	call   b3a <APCreateCompatibleDCFromBitmap>
    19fe:	83 c4 10             	add    $0x10,%esp
    1a01:	a3 88 67 00 00       	mov    %eax,0x6788
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1a06:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a09:	83 ec 08             	sub    $0x8,%esp
    1a0c:	68 e7 24 00 00       	push   $0x24e7
    1a11:	50                   	push   %eax
    1a12:	e8 e9 ee ff ff       	call   900 <APLoadBitmap>
    1a17:	83 c4 0c             	add    $0xc,%esp
    1a1a:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a1d:	a3 bc 67 00 00       	mov    %eax,0x67bc
    1a22:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a25:	a3 c0 67 00 00       	mov    %eax,0x67c0
    1a2a:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a2d:	a3 c4 67 00 00       	mov    %eax,0x67c4
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1a32:	83 ec 04             	sub    $0x4,%esp
    1a35:	ff 35 c4 67 00 00    	pushl  0x67c4
    1a3b:	ff 35 c0 67 00 00    	pushl  0x67c0
    1a41:	ff 35 bc 67 00 00    	pushl  0x67bc
    1a47:	e8 ee f0 ff ff       	call   b3a <APCreateCompatibleDCFromBitmap>
    1a4c:	83 c4 10             	add    $0x10,%esp
    1a4f:	a3 f0 67 00 00       	mov    %eax,0x67f0
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1a54:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a57:	83 ec 08             	sub    $0x8,%esp
    1a5a:	68 f5 24 00 00       	push   $0x24f5
    1a5f:	50                   	push   %eax
    1a60:	e8 9b ee ff ff       	call   900 <APLoadBitmap>
    1a65:	83 c4 0c             	add    $0xc,%esp
    1a68:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a6b:	a3 98 67 00 00       	mov    %eax,0x6798
    1a70:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a73:	a3 9c 67 00 00       	mov    %eax,0x679c
    1a78:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a7b:	a3 a0 67 00 00       	mov    %eax,0x67a0
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1a80:	83 ec 04             	sub    $0x4,%esp
    1a83:	ff 35 a0 67 00 00    	pushl  0x67a0
    1a89:	ff 35 9c 67 00 00    	pushl  0x679c
    1a8f:	ff 35 98 67 00 00    	pushl  0x6798
    1a95:	e8 a0 f0 ff ff       	call   b3a <APCreateCompatibleDCFromBitmap>
    1a9a:	83 c4 10             	add    $0x10,%esp
    1a9d:	a3 b8 67 00 00       	mov    %eax,0x67b8
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1aa2:	8d 45 88             	lea    -0x78(%ebp),%eax
    1aa5:	83 ec 08             	sub    $0x8,%esp
    1aa8:	68 05 25 00 00       	push   $0x2505
    1aad:	50                   	push   %eax
    1aae:	e8 4d ee ff ff       	call   900 <APLoadBitmap>
    1ab3:	83 c4 0c             	add    $0xc,%esp
    1ab6:	8b 45 88             	mov    -0x78(%ebp),%eax
    1ab9:	a3 8c 67 00 00       	mov    %eax,0x678c
    1abe:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1ac1:	a3 90 67 00 00       	mov    %eax,0x6790
    1ac6:	8b 45 90             	mov    -0x70(%ebp),%eax
    1ac9:	a3 94 67 00 00       	mov    %eax,0x6794
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1ace:	83 ec 04             	sub    $0x4,%esp
    1ad1:	ff 35 94 67 00 00    	pushl  0x6794
    1ad7:	ff 35 90 67 00 00    	pushl  0x6790
    1add:	ff 35 8c 67 00 00    	pushl  0x678c
    1ae3:	e8 52 f0 ff ff       	call   b3a <APCreateCompatibleDCFromBitmap>
    1ae8:	83 c4 10             	add    $0x10,%esp
    1aeb:	a3 a4 67 00 00       	mov    %eax,0x67a4
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1af0:	8d 45 88             	lea    -0x78(%ebp),%eax
    1af3:	83 ec 08             	sub    $0x8,%esp
    1af6:	68 17 25 00 00       	push   $0x2517
    1afb:	50                   	push   %eax
    1afc:	e8 ff ed ff ff       	call   900 <APLoadBitmap>
    1b01:	83 c4 0c             	add    $0xc,%esp
    1b04:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b07:	a3 c8 67 00 00       	mov    %eax,0x67c8
    1b0c:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b0f:	a3 cc 67 00 00       	mov    %eax,0x67cc
    1b14:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b17:	a3 d0 67 00 00       	mov    %eax,0x67d0
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1b1c:	83 ec 04             	sub    $0x4,%esp
    1b1f:	ff 35 d0 67 00 00    	pushl  0x67d0
    1b25:	ff 35 cc 67 00 00    	pushl  0x67cc
    1b2b:	ff 35 c8 67 00 00    	pushl  0x67c8
    1b31:	e8 04 f0 ff ff       	call   b3a <APCreateCompatibleDCFromBitmap>
    1b36:	83 c4 10             	add    $0x10,%esp
    1b39:	a3 f4 67 00 00       	mov    %eax,0x67f4
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1b3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b41:	8b 40 08             	mov    0x8(%eax),%eax
    1b44:	85 c0                	test   %eax,%eax
    1b46:	75 17                	jne    1b5f <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1b48:	83 ec 08             	sub    $0x8,%esp
    1b4b:	68 28 25 00 00       	push   $0x2528
    1b50:	6a 01                	push   $0x1
    1b52:	e8 23 e9 ff ff       	call   47a <printf>
    1b57:	83 c4 10             	add    $0x10,%esp
        return;
    1b5a:	e9 07 05 00 00       	jmp    2066 <APGridPaint+0x76a>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1b5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b62:	8b 40 10             	mov    0x10(%eax),%eax
    1b65:	85 c0                	test   %eax,%eax
    1b67:	7e 10                	jle    1b79 <APGridPaint+0x27d>
    1b69:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6c:	8b 50 14             	mov    0x14(%eax),%edx
    1b6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b72:	8b 40 10             	mov    0x10(%eax),%eax
    1b75:	39 c2                	cmp    %eax,%edx
    1b77:	7c 17                	jl     1b90 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1b79:	83 ec 08             	sub    $0x8,%esp
    1b7c:	68 4e 25 00 00       	push   $0x254e
    1b81:	6a 01                	push   $0x1
    1b83:	e8 f2 e8 ff ff       	call   47a <printf>
    1b88:	83 c4 10             	add    $0x10,%esp
        return;
    1b8b:	e9 d6 04 00 00       	jmp    2066 <APGridPaint+0x76a>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1b90:	8b 45 08             	mov    0x8(%ebp),%eax
    1b93:	8b 40 14             	mov    0x14(%eax),%eax
    1b96:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1b9c:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1b9f:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1ba2:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1ba5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1bac:	e9 96 03 00 00       	jmp    1f47 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1bb1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1bb8:	e9 7c 03 00 00       	jmp    1f39 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1bbd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bc0:	c1 e0 04             	shl    $0x4,%eax
    1bc3:	89 c2                	mov    %eax,%edx
    1bc5:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1bc8:	01 c2                	add    %eax,%edx
    1bca:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bcd:	01 d0                	add    %edx,%eax
    1bcf:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1bd2:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd5:	8b 40 0c             	mov    0xc(%eax),%eax
    1bd8:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1bdb:	c1 e2 02             	shl    $0x2,%edx
    1bde:	01 d0                	add    %edx,%eax
    1be0:	8b 00                	mov    (%eax),%eax
    1be2:	83 f8 07             	cmp    $0x7,%eax
    1be5:	0f 87 49 03 00 00    	ja     1f34 <APGridPaint+0x638>
    1beb:	8b 04 85 64 25 00 00 	mov    0x2564(,%eax,4),%eax
    1bf2:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bf4:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1bf7:	6a 0c                	push   $0xc
    1bf9:	6a 0c                	push   $0xc
    1bfb:	6a 0c                	push   $0xc
    1bfd:	50                   	push   %eax
    1bfe:	e8 df f8 ff ff       	call   14e2 <RGB>
    1c03:	83 c4 0c             	add    $0xc,%esp
    1c06:	8b 1d b4 67 00 00    	mov    0x67b4,%ebx
    1c0c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c0f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c12:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c15:	6b c0 32             	imul   $0x32,%eax,%eax
    1c18:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1c1b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c1e:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c21:	83 ec 0c             	sub    $0xc,%esp
    1c24:	83 ec 04             	sub    $0x4,%esp
    1c27:	89 e0                	mov    %esp,%eax
    1c29:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1c2d:	66 89 30             	mov    %si,(%eax)
    1c30:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1c34:	88 50 02             	mov    %dl,0x2(%eax)
    1c37:	6a 32                	push   $0x32
    1c39:	6a 32                	push   $0x32
    1c3b:	6a 00                	push   $0x0
    1c3d:	6a 00                	push   $0x0
    1c3f:	53                   	push   %ebx
    1c40:	51                   	push   %ecx
    1c41:	ff 75 84             	pushl  -0x7c(%ebp)
    1c44:	57                   	push   %edi
    1c45:	e8 f4 f6 ff ff       	call   133e <APDcCopy>
    1c4a:	83 c4 30             	add    $0x30,%esp
                    break;
    1c4d:	e9 e3 02 00 00       	jmp    1f35 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1c52:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c55:	6a 69                	push   $0x69
    1c57:	6a 69                	push   $0x69
    1c59:	6a 69                	push   $0x69
    1c5b:	50                   	push   %eax
    1c5c:	e8 81 f8 ff ff       	call   14e2 <RGB>
    1c61:	83 c4 0c             	add    $0xc,%esp
    1c64:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1c68:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1c6c:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1c70:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1c73:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1c7a:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c7d:	6a 69                	push   $0x69
    1c7f:	6a 69                	push   $0x69
    1c81:	6a 69                	push   $0x69
    1c83:	50                   	push   %eax
    1c84:	e8 59 f8 ff ff       	call   14e2 <RGB>
    1c89:	83 c4 0c             	add    $0xc,%esp
    1c8c:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1c90:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1c94:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1c98:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1c9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c9e:	8d 50 3c             	lea    0x3c(%eax),%edx
    1ca1:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ca4:	ff 75 ac             	pushl  -0x54(%ebp)
    1ca7:	ff 75 a8             	pushl  -0x58(%ebp)
    1caa:	52                   	push   %edx
    1cab:	50                   	push   %eax
    1cac:	e8 1e ef ff ff       	call   bcf <APSetPen>
    1cb1:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1cb4:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb7:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1cba:	8d 55 88             	lea    -0x78(%ebp),%edx
    1cbd:	83 ec 04             	sub    $0x4,%esp
    1cc0:	83 ec 04             	sub    $0x4,%esp
    1cc3:	89 e0                	mov    %esp,%eax
    1cc5:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1cc9:	66 89 08             	mov    %cx,(%eax)
    1ccc:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    1cd0:	88 48 02             	mov    %cl,0x2(%eax)
    1cd3:	53                   	push   %ebx
    1cd4:	52                   	push   %edx
    1cd5:	e8 2e ef ff ff       	call   c08 <APSetBrush>
    1cda:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1cdd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ce0:	6b d0 32             	imul   $0x32,%eax,%edx
    1ce3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ce6:	6b c0 32             	imul   $0x32,%eax,%eax
    1ce9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1cec:	83 c1 3c             	add    $0x3c,%ecx
    1cef:	83 ec 0c             	sub    $0xc,%esp
    1cf2:	6a 32                	push   $0x32
    1cf4:	6a 32                	push   $0x32
    1cf6:	52                   	push   %edx
    1cf7:	50                   	push   %eax
    1cf8:	51                   	push   %ecx
    1cf9:	e8 34 f3 ff ff       	call   1032 <APDrawRect>
    1cfe:	83 c4 20             	add    $0x20,%esp
                    break;
    1d01:	e9 2f 02 00 00       	jmp    1f35 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d06:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1d09:	6a 0c                	push   $0xc
    1d0b:	6a 0c                	push   $0xc
    1d0d:	6a 0c                	push   $0xc
    1d0f:	50                   	push   %eax
    1d10:	e8 cd f7 ff ff       	call   14e2 <RGB>
    1d15:	83 c4 0c             	add    $0xc,%esp
    1d18:	8b 1d f4 67 00 00    	mov    0x67f4,%ebx
    1d1e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d21:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d24:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d27:	6b c0 32             	imul   $0x32,%eax,%eax
    1d2a:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1d2d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d30:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d33:	83 ec 0c             	sub    $0xc,%esp
    1d36:	83 ec 04             	sub    $0x4,%esp
    1d39:	89 e0                	mov    %esp,%eax
    1d3b:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1d3f:	66 89 30             	mov    %si,(%eax)
    1d42:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1d46:	88 50 02             	mov    %dl,0x2(%eax)
    1d49:	6a 32                	push   $0x32
    1d4b:	6a 32                	push   $0x32
    1d4d:	6a 00                	push   $0x0
    1d4f:	6a 00                	push   $0x0
    1d51:	53                   	push   %ebx
    1d52:	51                   	push   %ecx
    1d53:	ff 75 84             	pushl  -0x7c(%ebp)
    1d56:	57                   	push   %edi
    1d57:	e8 e2 f5 ff ff       	call   133e <APDcCopy>
    1d5c:	83 c4 30             	add    $0x30,%esp
                    break;
    1d5f:	e9 d1 01 00 00       	jmp    1f35 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d64:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1d67:	6a 0c                	push   $0xc
    1d69:	6a 0c                	push   $0xc
    1d6b:	6a 0c                	push   $0xc
    1d6d:	50                   	push   %eax
    1d6e:	e8 6f f7 ff ff       	call   14e2 <RGB>
    1d73:	83 c4 0c             	add    $0xc,%esp
    1d76:	8b 1d d4 67 00 00    	mov    0x67d4,%ebx
    1d7c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d7f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d82:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d85:	6b c0 32             	imul   $0x32,%eax,%eax
    1d88:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1d8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d8e:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d91:	83 ec 0c             	sub    $0xc,%esp
    1d94:	83 ec 04             	sub    $0x4,%esp
    1d97:	89 e0                	mov    %esp,%eax
    1d99:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1d9d:	66 89 30             	mov    %si,(%eax)
    1da0:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1da4:	88 50 02             	mov    %dl,0x2(%eax)
    1da7:	6a 32                	push   $0x32
    1da9:	6a 32                	push   $0x32
    1dab:	6a 00                	push   $0x0
    1dad:	6a 00                	push   $0x0
    1daf:	53                   	push   %ebx
    1db0:	51                   	push   %ecx
    1db1:	ff 75 84             	pushl  -0x7c(%ebp)
    1db4:	57                   	push   %edi
    1db5:	e8 84 f5 ff ff       	call   133e <APDcCopy>
    1dba:	83 c4 30             	add    $0x30,%esp
                    break;
    1dbd:	e9 73 01 00 00       	jmp    1f35 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dc2:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1dc5:	6a 0c                	push   $0xc
    1dc7:	6a 0c                	push   $0xc
    1dc9:	6a 0c                	push   $0xc
    1dcb:	50                   	push   %eax
    1dcc:	e8 11 f7 ff ff       	call   14e2 <RGB>
    1dd1:	83 c4 0c             	add    $0xc,%esp
    1dd4:	8b 1d b8 67 00 00    	mov    0x67b8,%ebx
    1dda:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ddd:	6b c8 32             	imul   $0x32,%eax,%ecx
    1de0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1de3:	6b c0 32             	imul   $0x32,%eax,%eax
    1de6:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1de9:	8b 45 08             	mov    0x8(%ebp),%eax
    1dec:	8d 78 3c             	lea    0x3c(%eax),%edi
    1def:	83 ec 0c             	sub    $0xc,%esp
    1df2:	83 ec 04             	sub    $0x4,%esp
    1df5:	89 e0                	mov    %esp,%eax
    1df7:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1dfb:	66 89 30             	mov    %si,(%eax)
    1dfe:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1e02:	88 50 02             	mov    %dl,0x2(%eax)
    1e05:	6a 32                	push   $0x32
    1e07:	6a 32                	push   $0x32
    1e09:	6a 00                	push   $0x0
    1e0b:	6a 00                	push   $0x0
    1e0d:	53                   	push   %ebx
    1e0e:	51                   	push   %ecx
    1e0f:	ff 75 84             	pushl  -0x7c(%ebp)
    1e12:	57                   	push   %edi
    1e13:	e8 26 f5 ff ff       	call   133e <APDcCopy>
    1e18:	83 c4 30             	add    $0x30,%esp
                    break;
    1e1b:	e9 15 01 00 00       	jmp    1f35 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e20:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1e23:	6a 0c                	push   $0xc
    1e25:	6a 0c                	push   $0xc
    1e27:	6a 0c                	push   $0xc
    1e29:	50                   	push   %eax
    1e2a:	e8 b3 f6 ff ff       	call   14e2 <RGB>
    1e2f:	83 c4 0c             	add    $0xc,%esp
    1e32:	8b 1d f0 67 00 00    	mov    0x67f0,%ebx
    1e38:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e3b:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e3e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e41:	6b c0 32             	imul   $0x32,%eax,%eax
    1e44:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e47:	8b 45 08             	mov    0x8(%ebp),%eax
    1e4a:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e4d:	83 ec 0c             	sub    $0xc,%esp
    1e50:	83 ec 04             	sub    $0x4,%esp
    1e53:	89 e0                	mov    %esp,%eax
    1e55:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1e59:	66 89 30             	mov    %si,(%eax)
    1e5c:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1e60:	88 50 02             	mov    %dl,0x2(%eax)
    1e63:	6a 32                	push   $0x32
    1e65:	6a 32                	push   $0x32
    1e67:	6a 00                	push   $0x0
    1e69:	6a 00                	push   $0x0
    1e6b:	53                   	push   %ebx
    1e6c:	51                   	push   %ecx
    1e6d:	ff 75 84             	pushl  -0x7c(%ebp)
    1e70:	57                   	push   %edi
    1e71:	e8 c8 f4 ff ff       	call   133e <APDcCopy>
    1e76:	83 c4 30             	add    $0x30,%esp
                    break;
    1e79:	e9 b7 00 00 00       	jmp    1f35 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e7e:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1e81:	6a 0c                	push   $0xc
    1e83:	6a 0c                	push   $0xc
    1e85:	6a 0c                	push   $0xc
    1e87:	50                   	push   %eax
    1e88:	e8 55 f6 ff ff       	call   14e2 <RGB>
    1e8d:	83 c4 0c             	add    $0xc,%esp
    1e90:	8b 1d 88 67 00 00    	mov    0x6788,%ebx
    1e96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e99:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e9c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e9f:	6b c0 32             	imul   $0x32,%eax,%eax
    1ea2:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1ea5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea8:	8d 78 3c             	lea    0x3c(%eax),%edi
    1eab:	83 ec 0c             	sub    $0xc,%esp
    1eae:	83 ec 04             	sub    $0x4,%esp
    1eb1:	89 e0                	mov    %esp,%eax
    1eb3:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1eb7:	66 89 30             	mov    %si,(%eax)
    1eba:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1ebe:	88 50 02             	mov    %dl,0x2(%eax)
    1ec1:	6a 32                	push   $0x32
    1ec3:	6a 32                	push   $0x32
    1ec5:	6a 00                	push   $0x0
    1ec7:	6a 00                	push   $0x0
    1ec9:	53                   	push   %ebx
    1eca:	51                   	push   %ecx
    1ecb:	ff 75 84             	pushl  -0x7c(%ebp)
    1ece:	57                   	push   %edi
    1ecf:	e8 6a f4 ff ff       	call   133e <APDcCopy>
    1ed4:	83 c4 30             	add    $0x30,%esp
                    break;
    1ed7:	eb 5c                	jmp    1f35 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ed9:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1edc:	6a 0c                	push   $0xc
    1ede:	6a 0c                	push   $0xc
    1ee0:	6a 0c                	push   $0xc
    1ee2:	50                   	push   %eax
    1ee3:	e8 fa f5 ff ff       	call   14e2 <RGB>
    1ee8:	83 c4 0c             	add    $0xc,%esp
    1eeb:	8b 1d a4 67 00 00    	mov    0x67a4,%ebx
    1ef1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ef4:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ef7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1efa:	6b c0 32             	imul   $0x32,%eax,%eax
    1efd:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f00:	8b 45 08             	mov    0x8(%ebp),%eax
    1f03:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f06:	83 ec 0c             	sub    $0xc,%esp
    1f09:	83 ec 04             	sub    $0x4,%esp
    1f0c:	89 e0                	mov    %esp,%eax
    1f0e:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1f12:	66 89 30             	mov    %si,(%eax)
    1f15:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1f19:	88 50 02             	mov    %dl,0x2(%eax)
    1f1c:	6a 32                	push   $0x32
    1f1e:	6a 32                	push   $0x32
    1f20:	6a 00                	push   $0x0
    1f22:	6a 00                	push   $0x0
    1f24:	53                   	push   %ebx
    1f25:	51                   	push   %ecx
    1f26:	ff 75 84             	pushl  -0x7c(%ebp)
    1f29:	57                   	push   %edi
    1f2a:	e8 0f f4 ff ff       	call   133e <APDcCopy>
    1f2f:	83 c4 30             	add    $0x30,%esp
                    break;
    1f32:	eb 01                	jmp    1f35 <APGridPaint+0x639>
                default: break;
    1f34:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1f35:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1f39:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1f3d:	0f 8e 7a fc ff ff    	jle    1bbd <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1f43:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1f47:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1f4b:	0f 8e 60 fc ff ff    	jle    1bb1 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1f51:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f54:	68 cd 00 00 00       	push   $0xcd
    1f59:	6a 74                	push   $0x74
    1f5b:	6a 18                	push   $0x18
    1f5d:	50                   	push   %eax
    1f5e:	e8 7f f5 ff ff       	call   14e2 <RGB>
    1f63:	83 c4 0c             	add    $0xc,%esp
    1f66:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1f6a:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1f6e:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1f72:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1f75:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1f7c:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f7f:	68 cd 00 00 00       	push   $0xcd
    1f84:	6a 74                	push   $0x74
    1f86:	6a 18                	push   $0x18
    1f88:	50                   	push   %eax
    1f89:	e8 54 f5 ff ff       	call   14e2 <RGB>
    1f8e:	83 c4 0c             	add    $0xc,%esp
    1f91:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1f95:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1f99:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1f9d:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1fa0:	8b 45 08             	mov    0x8(%ebp),%eax
    1fa3:	8d 50 58             	lea    0x58(%eax),%edx
    1fa6:	8d 45 88             	lea    -0x78(%ebp),%eax
    1fa9:	ff 75 bc             	pushl  -0x44(%ebp)
    1fac:	ff 75 b8             	pushl  -0x48(%ebp)
    1faf:	52                   	push   %edx
    1fb0:	50                   	push   %eax
    1fb1:	e8 19 ec ff ff       	call   bcf <APSetPen>
    1fb6:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1fb9:	8b 45 08             	mov    0x8(%ebp),%eax
    1fbc:	8d 58 58             	lea    0x58(%eax),%ebx
    1fbf:	8d 55 88             	lea    -0x78(%ebp),%edx
    1fc2:	83 ec 04             	sub    $0x4,%esp
    1fc5:	83 ec 04             	sub    $0x4,%esp
    1fc8:	89 e0                	mov    %esp,%eax
    1fca:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1fce:	66 89 08             	mov    %cx,(%eax)
    1fd1:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1fd5:	88 48 02             	mov    %cl,0x2(%eax)
    1fd8:	53                   	push   %ebx
    1fd9:	52                   	push   %edx
    1fda:	e8 29 ec ff ff       	call   c08 <APSetBrush>
    1fdf:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1fe2:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe5:	83 c0 58             	add    $0x58,%eax
    1fe8:	83 ec 0c             	sub    $0xc,%esp
    1feb:	6a 32                	push   $0x32
    1fed:	68 20 03 00 00       	push   $0x320
    1ff2:	6a 00                	push   $0x0
    1ff4:	6a 00                	push   $0x0
    1ff6:	50                   	push   %eax
    1ff7:	e8 36 f0 ff ff       	call   1032 <APDrawRect>
    1ffc:	83 c4 20             	add    $0x20,%esp
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    1fff:	8d 45 88             	lea    -0x78(%ebp),%eax
    2002:	6a 08                	push   $0x8
    2004:	6a 08                	push   $0x8
    2006:	6a 08                	push   $0x8
    2008:	50                   	push   %eax
    2009:	e8 d4 f4 ff ff       	call   14e2 <RGB>
    200e:	83 c4 0c             	add    $0xc,%esp
    2011:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2015:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    2019:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    201d:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    2020:	8b 45 08             	mov    0x8(%ebp),%eax
    2023:	8d 58 58             	lea    0x58(%eax),%ebx
    2026:	8d 55 88             	lea    -0x78(%ebp),%edx
    2029:	83 ec 04             	sub    $0x4,%esp
    202c:	83 ec 04             	sub    $0x4,%esp
    202f:	89 e0                	mov    %esp,%eax
    2031:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    2035:	66 89 08             	mov    %cx,(%eax)
    2038:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    203c:	88 48 02             	mov    %cl,0x2(%eax)
    203f:	53                   	push   %ebx
    2040:	52                   	push   %edx
    2041:	e8 04 ec ff ff       	call   c4a <APSetFont>
    2046:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    2049:	8b 45 08             	mov    0x8(%ebp),%eax
    204c:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    2052:	8b 45 08             	mov    0x8(%ebp),%eax
    2055:	83 c0 58             	add    $0x58,%eax
    2058:	6a 14                	push   $0x14
    205a:	6a 14                	push   $0x14
    205c:	52                   	push   %edx
    205d:	50                   	push   %eax
    205e:	e8 d4 f1 ff ff       	call   1237 <APDrawText>
    2063:	83 c4 10             	add    $0x10,%esp
}
    2066:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2069:	5b                   	pop    %ebx
    206a:	5e                   	pop    %esi
    206b:	5f                   	pop    %edi
    206c:	5d                   	pop    %ebp
    206d:	c3                   	ret    

0000206e <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    206e:	55                   	push   %ebp
    206f:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2071:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2075:	7e 08                	jle    207f <random+0x11>
{
rand_num = seed;
    2077:	8b 45 08             	mov    0x8(%ebp),%eax
    207a:	a3 60 67 00 00       	mov    %eax,0x6760
}
rand_num *= 3;
    207f:	8b 15 60 67 00 00    	mov    0x6760,%edx
    2085:	89 d0                	mov    %edx,%eax
    2087:	01 c0                	add    %eax,%eax
    2089:	01 d0                	add    %edx,%eax
    208b:	a3 60 67 00 00       	mov    %eax,0x6760
if (rand_num < 0)
    2090:	a1 60 67 00 00       	mov    0x6760,%eax
    2095:	85 c0                	test   %eax,%eax
    2097:	79 0c                	jns    20a5 <random+0x37>
{
rand_num *= (-1);
    2099:	a1 60 67 00 00       	mov    0x6760,%eax
    209e:	f7 d8                	neg    %eax
    20a0:	a3 60 67 00 00       	mov    %eax,0x6760
}
return rand_num % 997;
    20a5:	8b 0d 60 67 00 00    	mov    0x6760,%ecx
    20ab:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    20b0:	89 c8                	mov    %ecx,%eax
    20b2:	f7 ea                	imul   %edx
    20b4:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    20b7:	c1 f8 09             	sar    $0x9,%eax
    20ba:	89 c2                	mov    %eax,%edx
    20bc:	89 c8                	mov    %ecx,%eax
    20be:	c1 f8 1f             	sar    $0x1f,%eax
    20c1:	29 c2                	sub    %eax,%edx
    20c3:	89 d0                	mov    %edx,%eax
    20c5:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    20cb:	29 c1                	sub    %eax,%ecx
    20cd:	89 c8                	mov    %ecx,%eax
}
    20cf:	5d                   	pop    %ebp
    20d0:	c3                   	ret    

000020d1 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    20d1:	55                   	push   %ebp
    20d2:	89 e5                	mov    %esp,%ebp
    20d4:	53                   	push   %ebx
    20d5:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    20d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    20df:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    20e3:	74 17                	je     20fc <sprintint+0x2b>
    20e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    20e9:	79 11                	jns    20fc <sprintint+0x2b>
        neg = 1;
    20eb:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    20f2:	8b 45 10             	mov    0x10(%ebp),%eax
    20f5:	f7 d8                	neg    %eax
    20f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    20fa:	eb 06                	jmp    2102 <sprintint+0x31>
    } else {
        x = xx;
    20fc:	8b 45 10             	mov    0x10(%ebp),%eax
    20ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2102:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2109:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    210c:	8d 41 01             	lea    0x1(%ecx),%eax
    210f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2112:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2115:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2118:	ba 00 00 00 00       	mov    $0x0,%edx
    211d:	f7 f3                	div    %ebx
    211f:	89 d0                	mov    %edx,%eax
    2121:	0f b6 80 64 67 00 00 	movzbl 0x6764(%eax),%eax
    2128:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    212c:	8b 5d 14             	mov    0x14(%ebp),%ebx
    212f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2132:	ba 00 00 00 00       	mov    $0x0,%edx
    2137:	f7 f3                	div    %ebx
    2139:	89 45 f0             	mov    %eax,-0x10(%ebp)
    213c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2140:	75 c7                	jne    2109 <sprintint+0x38>
    if(neg)
    2142:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2146:	74 0e                	je     2156 <sprintint+0x85>
        buf[i++] = '-';
    2148:	8b 45 f8             	mov    -0x8(%ebp),%eax
    214b:	8d 50 01             	lea    0x1(%eax),%edx
    214e:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2151:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2156:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2159:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    215c:	eb 1b                	jmp    2179 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    215e:	8b 45 0c             	mov    0xc(%ebp),%eax
    2161:	8b 00                	mov    (%eax),%eax
    2163:	8d 48 01             	lea    0x1(%eax),%ecx
    2166:	8b 55 0c             	mov    0xc(%ebp),%edx
    2169:	89 0a                	mov    %ecx,(%edx)
    216b:	89 c2                	mov    %eax,%edx
    216d:	8b 45 08             	mov    0x8(%ebp),%eax
    2170:	01 d0                	add    %edx,%eax
    2172:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2175:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2179:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    217d:	7f df                	jg     215e <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    217f:	eb 21                	jmp    21a2 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2181:	8b 45 0c             	mov    0xc(%ebp),%eax
    2184:	8b 00                	mov    (%eax),%eax
    2186:	8d 48 01             	lea    0x1(%eax),%ecx
    2189:	8b 55 0c             	mov    0xc(%ebp),%edx
    218c:	89 0a                	mov    %ecx,(%edx)
    218e:	89 c2                	mov    %eax,%edx
    2190:	8b 45 08             	mov    0x8(%ebp),%eax
    2193:	01 c2                	add    %eax,%edx
    2195:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2198:	8b 45 f8             	mov    -0x8(%ebp),%eax
    219b:	01 c8                	add    %ecx,%eax
    219d:	0f b6 00             	movzbl (%eax),%eax
    21a0:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    21a2:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    21a6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    21aa:	79 d5                	jns    2181 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    21ac:	90                   	nop
    21ad:	83 c4 20             	add    $0x20,%esp
    21b0:	5b                   	pop    %ebx
    21b1:	5d                   	pop    %ebp
    21b2:	c3                   	ret    

000021b3 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    21b3:	55                   	push   %ebp
    21b4:	89 e5                	mov    %esp,%ebp
    21b6:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    21b9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    21c0:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    21c7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    21ce:	8d 45 0c             	lea    0xc(%ebp),%eax
    21d1:	83 c0 04             	add    $0x4,%eax
    21d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    21d7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    21de:	e9 d9 01 00 00       	jmp    23bc <sprintf+0x209>
        c = fmt[i] & 0xff;
    21e3:	8b 55 0c             	mov    0xc(%ebp),%edx
    21e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    21e9:	01 d0                	add    %edx,%eax
    21eb:	0f b6 00             	movzbl (%eax),%eax
    21ee:	0f be c0             	movsbl %al,%eax
    21f1:	25 ff 00 00 00       	and    $0xff,%eax
    21f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    21f9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    21fd:	75 2c                	jne    222b <sprintf+0x78>
            if(c == '%'){
    21ff:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2203:	75 0c                	jne    2211 <sprintf+0x5e>
                state = '%';
    2205:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    220c:	e9 a7 01 00 00       	jmp    23b8 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2211:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2214:	8d 50 01             	lea    0x1(%eax),%edx
    2217:	89 55 c8             	mov    %edx,-0x38(%ebp)
    221a:	89 c2                	mov    %eax,%edx
    221c:	8b 45 08             	mov    0x8(%ebp),%eax
    221f:	01 d0                	add    %edx,%eax
    2221:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2224:	88 10                	mov    %dl,(%eax)
    2226:	e9 8d 01 00 00       	jmp    23b8 <sprintf+0x205>
            }
        } else if(state == '%'){
    222b:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    222f:	0f 85 83 01 00 00    	jne    23b8 <sprintf+0x205>
            if(c == 'd'){
    2235:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2239:	75 4c                	jne    2287 <sprintf+0xd4>
                buf[bi] = '\0';
    223b:	8d 55 ce             	lea    -0x32(%ebp),%edx
    223e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2241:	01 d0                	add    %edx,%eax
    2243:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2246:	83 ec 0c             	sub    $0xc,%esp
    2249:	8d 45 ce             	lea    -0x32(%ebp),%eax
    224c:	50                   	push   %eax
    224d:	e8 e7 df ff ff       	call   239 <atoi>
    2252:	83 c4 10             	add    $0x10,%esp
    2255:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2258:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    225f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2262:	8b 00                	mov    (%eax),%eax
    2264:	83 ec 08             	sub    $0x8,%esp
    2267:	ff 75 d8             	pushl  -0x28(%ebp)
    226a:	6a 01                	push   $0x1
    226c:	6a 0a                	push   $0xa
    226e:	50                   	push   %eax
    226f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2272:	50                   	push   %eax
    2273:	ff 75 08             	pushl  0x8(%ebp)
    2276:	e8 56 fe ff ff       	call   20d1 <sprintint>
    227b:	83 c4 20             	add    $0x20,%esp
                ap++;
    227e:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2282:	e9 2a 01 00 00       	jmp    23b1 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2287:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    228b:	74 06                	je     2293 <sprintf+0xe0>
    228d:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2291:	75 4c                	jne    22df <sprintf+0x12c>
                buf[bi] = '\0';
    2293:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2296:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2299:	01 d0                	add    %edx,%eax
    229b:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    229e:	83 ec 0c             	sub    $0xc,%esp
    22a1:	8d 45 ce             	lea    -0x32(%ebp),%eax
    22a4:	50                   	push   %eax
    22a5:	e8 8f df ff ff       	call   239 <atoi>
    22aa:	83 c4 10             	add    $0x10,%esp
    22ad:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    22b0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    22b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22ba:	8b 00                	mov    (%eax),%eax
    22bc:	83 ec 08             	sub    $0x8,%esp
    22bf:	ff 75 dc             	pushl  -0x24(%ebp)
    22c2:	6a 00                	push   $0x0
    22c4:	6a 10                	push   $0x10
    22c6:	50                   	push   %eax
    22c7:	8d 45 c8             	lea    -0x38(%ebp),%eax
    22ca:	50                   	push   %eax
    22cb:	ff 75 08             	pushl  0x8(%ebp)
    22ce:	e8 fe fd ff ff       	call   20d1 <sprintint>
    22d3:	83 c4 20             	add    $0x20,%esp
                ap++;
    22d6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    22da:	e9 d2 00 00 00       	jmp    23b1 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    22df:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    22e3:	75 46                	jne    232b <sprintf+0x178>
                s = (char*)*ap;
    22e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22e8:	8b 00                	mov    (%eax),%eax
    22ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    22ed:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    22f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    22f5:	75 25                	jne    231c <sprintf+0x169>
                    s = "(null)";
    22f7:	c7 45 f4 84 25 00 00 	movl   $0x2584,-0xc(%ebp)
                while(*s != 0){
    22fe:	eb 1c                	jmp    231c <sprintf+0x169>
                    dst[j++] = *s;
    2300:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2303:	8d 50 01             	lea    0x1(%eax),%edx
    2306:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2309:	89 c2                	mov    %eax,%edx
    230b:	8b 45 08             	mov    0x8(%ebp),%eax
    230e:	01 c2                	add    %eax,%edx
    2310:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2313:	0f b6 00             	movzbl (%eax),%eax
    2316:	88 02                	mov    %al,(%edx)
                    s++;
    2318:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    231c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    231f:	0f b6 00             	movzbl (%eax),%eax
    2322:	84 c0                	test   %al,%al
    2324:	75 da                	jne    2300 <sprintf+0x14d>
    2326:	e9 86 00 00 00       	jmp    23b1 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    232b:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    232f:	75 1d                	jne    234e <sprintf+0x19b>
                dst[j++] = *ap;
    2331:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2334:	8d 50 01             	lea    0x1(%eax),%edx
    2337:	89 55 c8             	mov    %edx,-0x38(%ebp)
    233a:	89 c2                	mov    %eax,%edx
    233c:	8b 45 08             	mov    0x8(%ebp),%eax
    233f:	01 c2                	add    %eax,%edx
    2341:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2344:	8b 00                	mov    (%eax),%eax
    2346:	88 02                	mov    %al,(%edx)
                ap++;
    2348:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    234c:	eb 63                	jmp    23b1 <sprintf+0x1fe>
            } else if(c == '%'){
    234e:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2352:	75 17                	jne    236b <sprintf+0x1b8>
                dst[j++] = c;
    2354:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2357:	8d 50 01             	lea    0x1(%eax),%edx
    235a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    235d:	89 c2                	mov    %eax,%edx
    235f:	8b 45 08             	mov    0x8(%ebp),%eax
    2362:	01 d0                	add    %edx,%eax
    2364:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2367:	88 10                	mov    %dl,(%eax)
    2369:	eb 46                	jmp    23b1 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    236b:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    236f:	7e 18                	jle    2389 <sprintf+0x1d6>
    2371:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2375:	7f 12                	jg     2389 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2377:	8b 45 f0             	mov    -0x10(%ebp),%eax
    237a:	8d 50 01             	lea    0x1(%eax),%edx
    237d:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2380:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2383:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2387:	eb 2f                	jmp    23b8 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2389:	8b 45 c8             	mov    -0x38(%ebp),%eax
    238c:	8d 50 01             	lea    0x1(%eax),%edx
    238f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2392:	89 c2                	mov    %eax,%edx
    2394:	8b 45 08             	mov    0x8(%ebp),%eax
    2397:	01 d0                	add    %edx,%eax
    2399:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    239c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    239f:	8d 50 01             	lea    0x1(%eax),%edx
    23a2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23a5:	89 c2                	mov    %eax,%edx
    23a7:	8b 45 08             	mov    0x8(%ebp),%eax
    23aa:	01 d0                	add    %edx,%eax
    23ac:	8b 55 e0             	mov    -0x20(%ebp),%edx
    23af:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    23b1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    23b8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    23bc:	8b 55 0c             	mov    0xc(%ebp),%edx
    23bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23c2:	01 d0                	add    %edx,%eax
    23c4:	0f b6 00             	movzbl (%eax),%eax
    23c7:	84 c0                	test   %al,%al
    23c9:	0f 85 14 fe ff ff    	jne    21e3 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    23cf:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23d2:	8d 50 01             	lea    0x1(%eax),%edx
    23d5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23d8:	89 c2                	mov    %eax,%edx
    23da:	8b 45 08             	mov    0x8(%ebp),%eax
    23dd:	01 d0                	add    %edx,%eax
    23df:	c6 00 00             	movb   $0x0,(%eax)
}
    23e2:	90                   	nop
    23e3:	c9                   	leave  
    23e4:	c3                   	ret    
