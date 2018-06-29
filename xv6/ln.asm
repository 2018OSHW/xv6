
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
      19:	68 3c 22 00 00       	push   $0x223c
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
      60:	68 4f 22 00 00       	push   $0x224f
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
     416:	0f b6 80 38 29 00 00 	movzbl 0x2938(%eax),%eax
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
     554:	c7 45 f4 63 22 00 00 	movl   $0x2263,-0xc(%ebp)
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
     61a:	a1 6c 29 00 00       	mov    0x296c,%eax
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
     6e5:	a3 6c 29 00 00       	mov    %eax,0x296c
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
     746:	a1 6c 29 00 00       	mov    0x296c,%eax
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
     762:	a1 6c 29 00 00       	mov    0x296c,%eax
     767:	89 45 f0             	mov    %eax,-0x10(%ebp)
     76a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     76e:	75 23                	jne    793 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     770:	c7 45 f0 64 29 00 00 	movl   $0x2964,-0x10(%ebp)
     777:	8b 45 f0             	mov    -0x10(%ebp),%eax
     77a:	a3 6c 29 00 00       	mov    %eax,0x296c
     77f:	a1 6c 29 00 00       	mov    0x296c,%eax
     784:	a3 64 29 00 00       	mov    %eax,0x2964
    base.s.size = 0;
     789:	c7 05 68 29 00 00 00 	movl   $0x0,0x2968
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
     7e6:	a3 6c 29 00 00       	mov    %eax,0x296c
      return (void*)(p + 1);
     7eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ee:	83 c0 08             	add    $0x8,%eax
     7f1:	eb 3b                	jmp    82e <malloc+0xe1>
    }
    if(p == freep)
     7f3:	a1 6c 29 00 00       	mov    0x296c,%eax
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
     939:	68 6a 22 00 00       	push   $0x226a
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

00000c4a <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c4a:	55                   	push   %ebp
     c4b:	89 e5                	mov    %esp,%ebp
     c4d:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c50:	8b 45 08             	mov    0x8(%ebp),%eax
     c53:	8b 40 0c             	mov    0xc(%eax),%eax
     c56:	89 c2                	mov    %eax,%edx
     c58:	c1 ea 1f             	shr    $0x1f,%edx
     c5b:	01 d0                	add    %edx,%eax
     c5d:	d1 f8                	sar    %eax
     c5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c62:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c65:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c69:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c6c:	8b 45 10             	mov    0x10(%ebp),%eax
     c6f:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c72:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c75:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c79:	0f 89 98 00 00 00    	jns    d17 <APDrawPoint+0xcd>
        i = 0;
     c7f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c86:	e9 8c 00 00 00       	jmp    d17 <APDrawPoint+0xcd>
    {
        j = x - off;
     c8b:	8b 45 0c             	mov    0xc(%ebp),%eax
     c8e:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c91:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     c94:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     c98:	79 69                	jns    d03 <APDrawPoint+0xb9>
            j = 0;
     c9a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     ca1:	eb 60                	jmp    d03 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     ca3:	ff 75 fc             	pushl  -0x4(%ebp)
     ca6:	ff 75 f8             	pushl  -0x8(%ebp)
     ca9:	ff 75 08             	pushl  0x8(%ebp)
     cac:	e8 fd fb ff ff       	call   8ae <APGetIndex>
     cb1:	83 c4 0c             	add    $0xc,%esp
     cb4:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     cb7:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cbb:	74 55                	je     d12 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cbd:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     cc1:	74 67                	je     d2a <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     cc3:	ff 75 10             	pushl  0x10(%ebp)
     cc6:	ff 75 0c             	pushl  0xc(%ebp)
     cc9:	ff 75 fc             	pushl  -0x4(%ebp)
     ccc:	ff 75 f8             	pushl  -0x8(%ebp)
     ccf:	e8 a1 fb ff ff       	call   875 <distance_2>
     cd4:	83 c4 10             	add    $0x10,%esp
     cd7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     cda:	7f 23                	jg     cff <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     cdc:	8b 45 08             	mov    0x8(%ebp),%eax
     cdf:	8b 48 18             	mov    0x18(%eax),%ecx
     ce2:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ce5:	89 d0                	mov    %edx,%eax
     ce7:	01 c0                	add    %eax,%eax
     ce9:	01 d0                	add    %edx,%eax
     ceb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     cee:	8b 45 08             	mov    0x8(%ebp),%eax
     cf1:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     cf5:	66 89 0a             	mov    %cx,(%edx)
     cf8:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     cfc:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     cff:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d03:	8b 55 0c             	mov    0xc(%ebp),%edx
     d06:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d09:	01 d0                	add    %edx,%eax
     d0b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d0e:	7d 93                	jge    ca3 <APDrawPoint+0x59>
     d10:	eb 01                	jmp    d13 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d12:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d13:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d17:	8b 55 10             	mov    0x10(%ebp),%edx
     d1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d1d:	01 d0                	add    %edx,%eax
     d1f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d22:	0f 8d 63 ff ff ff    	jge    c8b <APDrawPoint+0x41>
     d28:	eb 01                	jmp    d2b <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d2a:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d2b:	c9                   	leave  
     d2c:	c3                   	ret    

00000d2d <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d2d:	55                   	push   %ebp
     d2e:	89 e5                	mov    %esp,%ebp
     d30:	53                   	push   %ebx
     d31:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d34:	8b 45 0c             	mov    0xc(%ebp),%eax
     d37:	3b 45 14             	cmp    0x14(%ebp),%eax
     d3a:	0f 85 80 00 00 00    	jne    dc0 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d40:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d44:	0f 88 9d 02 00 00    	js     fe7 <APDrawLine+0x2ba>
     d4a:	8b 45 08             	mov    0x8(%ebp),%eax
     d4d:	8b 00                	mov    (%eax),%eax
     d4f:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d52:	0f 8e 8f 02 00 00    	jle    fe7 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d58:	8b 45 10             	mov    0x10(%ebp),%eax
     d5b:	3b 45 18             	cmp    0x18(%ebp),%eax
     d5e:	7e 12                	jle    d72 <APDrawLine+0x45>
        {
            int tmp = y2;
     d60:	8b 45 18             	mov    0x18(%ebp),%eax
     d63:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d66:	8b 45 10             	mov    0x10(%ebp),%eax
     d69:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d6c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d6f:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d72:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d76:	79 07                	jns    d7f <APDrawLine+0x52>
     d78:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d7f:	8b 45 08             	mov    0x8(%ebp),%eax
     d82:	8b 40 04             	mov    0x4(%eax),%eax
     d85:	3b 45 18             	cmp    0x18(%ebp),%eax
     d88:	7d 0c                	jge    d96 <APDrawLine+0x69>
     d8a:	8b 45 08             	mov    0x8(%ebp),%eax
     d8d:	8b 40 04             	mov    0x4(%eax),%eax
     d90:	83 e8 01             	sub    $0x1,%eax
     d93:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     d96:	8b 45 10             	mov    0x10(%ebp),%eax
     d99:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d9c:	eb 15                	jmp    db3 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     d9e:	ff 75 f4             	pushl  -0xc(%ebp)
     da1:	ff 75 0c             	pushl  0xc(%ebp)
     da4:	ff 75 08             	pushl  0x8(%ebp)
     da7:	e8 9e fe ff ff       	call   c4a <APDrawPoint>
     dac:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     daf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     db3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     db6:	3b 45 18             	cmp    0x18(%ebp),%eax
     db9:	7e e3                	jle    d9e <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     dbb:	e9 2b 02 00 00       	jmp    feb <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     dc0:	8b 45 10             	mov    0x10(%ebp),%eax
     dc3:	3b 45 18             	cmp    0x18(%ebp),%eax
     dc6:	75 7f                	jne    e47 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     dc8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dcc:	0f 88 18 02 00 00    	js     fea <APDrawLine+0x2bd>
     dd2:	8b 45 08             	mov    0x8(%ebp),%eax
     dd5:	8b 40 04             	mov    0x4(%eax),%eax
     dd8:	3b 45 10             	cmp    0x10(%ebp),%eax
     ddb:	0f 8e 09 02 00 00    	jle    fea <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     de1:	8b 45 0c             	mov    0xc(%ebp),%eax
     de4:	3b 45 14             	cmp    0x14(%ebp),%eax
     de7:	7e 12                	jle    dfb <APDrawLine+0xce>
        {
            int tmp = x2;
     de9:	8b 45 14             	mov    0x14(%ebp),%eax
     dec:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     def:	8b 45 0c             	mov    0xc(%ebp),%eax
     df2:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     df5:	8b 45 d8             	mov    -0x28(%ebp),%eax
     df8:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     dfb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     dff:	79 07                	jns    e08 <APDrawLine+0xdb>
     e01:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e08:	8b 45 08             	mov    0x8(%ebp),%eax
     e0b:	8b 00                	mov    (%eax),%eax
     e0d:	3b 45 14             	cmp    0x14(%ebp),%eax
     e10:	7d 0b                	jge    e1d <APDrawLine+0xf0>
     e12:	8b 45 08             	mov    0x8(%ebp),%eax
     e15:	8b 00                	mov    (%eax),%eax
     e17:	83 e8 01             	sub    $0x1,%eax
     e1a:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e1d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e20:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e23:	eb 15                	jmp    e3a <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e25:	ff 75 10             	pushl  0x10(%ebp)
     e28:	ff 75 f0             	pushl  -0x10(%ebp)
     e2b:	ff 75 08             	pushl  0x8(%ebp)
     e2e:	e8 17 fe ff ff       	call   c4a <APDrawPoint>
     e33:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e36:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e3d:	3b 45 14             	cmp    0x14(%ebp),%eax
     e40:	7e e3                	jle    e25 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e42:	e9 a4 01 00 00       	jmp    feb <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e47:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e4e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e55:	8b 45 0c             	mov    0xc(%ebp),%eax
     e58:	2b 45 14             	sub    0x14(%ebp),%eax
     e5b:	50                   	push   %eax
     e5c:	e8 3d fa ff ff       	call   89e <abs_int>
     e61:	83 c4 04             	add    $0x4,%esp
     e64:	89 c3                	mov    %eax,%ebx
     e66:	8b 45 10             	mov    0x10(%ebp),%eax
     e69:	2b 45 18             	sub    0x18(%ebp),%eax
     e6c:	50                   	push   %eax
     e6d:	e8 2c fa ff ff       	call   89e <abs_int>
     e72:	83 c4 04             	add    $0x4,%esp
     e75:	39 c3                	cmp    %eax,%ebx
     e77:	0f 8e b5 00 00 00    	jle    f32 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e7d:	8b 45 10             	mov    0x10(%ebp),%eax
     e80:	2b 45 18             	sub    0x18(%ebp),%eax
     e83:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e86:	db 45 b0             	fildl  -0x50(%ebp)
     e89:	8b 45 0c             	mov    0xc(%ebp),%eax
     e8c:	2b 45 14             	sub    0x14(%ebp),%eax
     e8f:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e92:	db 45 b0             	fildl  -0x50(%ebp)
     e95:	de f9                	fdivrp %st,%st(1)
     e97:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     e9a:	8b 45 14             	mov    0x14(%ebp),%eax
     e9d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ea0:	7e 0e                	jle    eb0 <APDrawLine+0x183>
        {
            s = x1;
     ea2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea5:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     ea8:	8b 45 14             	mov    0x14(%ebp),%eax
     eab:	89 45 e8             	mov    %eax,-0x18(%ebp)
     eae:	eb 0c                	jmp    ebc <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     eb0:	8b 45 14             	mov    0x14(%ebp),%eax
     eb3:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     eb6:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb9:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     ebc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ec0:	79 07                	jns    ec9 <APDrawLine+0x19c>
     ec2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     ec9:	8b 45 08             	mov    0x8(%ebp),%eax
     ecc:	8b 00                	mov    (%eax),%eax
     ece:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ed1:	7f 0b                	jg     ede <APDrawLine+0x1b1>
     ed3:	8b 45 08             	mov    0x8(%ebp),%eax
     ed6:	8b 00                	mov    (%eax),%eax
     ed8:	83 e8 01             	sub    $0x1,%eax
     edb:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     ede:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ee1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     ee4:	eb 3f                	jmp    f25 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     ee6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ee9:	2b 45 0c             	sub    0xc(%ebp),%eax
     eec:	89 45 b0             	mov    %eax,-0x50(%ebp)
     eef:	db 45 b0             	fildl  -0x50(%ebp)
     ef2:	dc 4d d0             	fmull  -0x30(%ebp)
     ef5:	db 45 10             	fildl  0x10(%ebp)
     ef8:	de c1                	faddp  %st,%st(1)
     efa:	d9 7d b6             	fnstcw -0x4a(%ebp)
     efd:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f01:	b4 0c                	mov    $0xc,%ah
     f03:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f07:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f0a:	db 5d cc             	fistpl -0x34(%ebp)
     f0d:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f10:	ff 75 cc             	pushl  -0x34(%ebp)
     f13:	ff 75 e4             	pushl  -0x1c(%ebp)
     f16:	ff 75 08             	pushl  0x8(%ebp)
     f19:	e8 2c fd ff ff       	call   c4a <APDrawPoint>
     f1e:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f21:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f25:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f28:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f2b:	7e b9                	jle    ee6 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f2d:	e9 b9 00 00 00       	jmp    feb <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f32:	8b 45 0c             	mov    0xc(%ebp),%eax
     f35:	2b 45 14             	sub    0x14(%ebp),%eax
     f38:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f3b:	db 45 b0             	fildl  -0x50(%ebp)
     f3e:	8b 45 10             	mov    0x10(%ebp),%eax
     f41:	2b 45 18             	sub    0x18(%ebp),%eax
     f44:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f47:	db 45 b0             	fildl  -0x50(%ebp)
     f4a:	de f9                	fdivrp %st,%st(1)
     f4c:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f4f:	8b 45 10             	mov    0x10(%ebp),%eax
     f52:	3b 45 18             	cmp    0x18(%ebp),%eax
     f55:	7e 0e                	jle    f65 <APDrawLine+0x238>
    {
        s = y2;
     f57:	8b 45 18             	mov    0x18(%ebp),%eax
     f5a:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f5d:	8b 45 10             	mov    0x10(%ebp),%eax
     f60:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f63:	eb 0c                	jmp    f71 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f65:	8b 45 10             	mov    0x10(%ebp),%eax
     f68:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f6b:	8b 45 18             	mov    0x18(%ebp),%eax
     f6e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f71:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f75:	79 07                	jns    f7e <APDrawLine+0x251>
     f77:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f7e:	8b 45 08             	mov    0x8(%ebp),%eax
     f81:	8b 40 04             	mov    0x4(%eax),%eax
     f84:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f87:	7f 0c                	jg     f95 <APDrawLine+0x268>
     f89:	8b 45 08             	mov    0x8(%ebp),%eax
     f8c:	8b 40 04             	mov    0x4(%eax),%eax
     f8f:	83 e8 01             	sub    $0x1,%eax
     f92:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     f95:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f98:	89 45 e0             	mov    %eax,-0x20(%ebp)
     f9b:	eb 3f                	jmp    fdc <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     f9d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fa0:	2b 45 10             	sub    0x10(%ebp),%eax
     fa3:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fa6:	db 45 b0             	fildl  -0x50(%ebp)
     fa9:	dc 4d c0             	fmull  -0x40(%ebp)
     fac:	db 45 0c             	fildl  0xc(%ebp)
     faf:	de c1                	faddp  %st,%st(1)
     fb1:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fb4:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fb8:	b4 0c                	mov    $0xc,%ah
     fba:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fbe:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fc1:	db 5d bc             	fistpl -0x44(%ebp)
     fc4:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     fc7:	ff 75 e0             	pushl  -0x20(%ebp)
     fca:	ff 75 bc             	pushl  -0x44(%ebp)
     fcd:	ff 75 08             	pushl  0x8(%ebp)
     fd0:	e8 75 fc ff ff       	call   c4a <APDrawPoint>
     fd5:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     fd8:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     fdc:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fdf:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fe2:	7e b9                	jle    f9d <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     fe4:	90                   	nop
     fe5:	eb 04                	jmp    feb <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     fe7:	90                   	nop
     fe8:	eb 01                	jmp    feb <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     fea:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     feb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fee:	c9                   	leave  
     fef:	c3                   	ret    

00000ff0 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     ff0:	55                   	push   %ebp
     ff1:	89 e5                	mov    %esp,%ebp
     ff3:	53                   	push   %ebx
     ff4:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
     ff7:	8b 55 10             	mov    0x10(%ebp),%edx
     ffa:	8b 45 18             	mov    0x18(%ebp),%eax
     ffd:	01 d0                	add    %edx,%eax
     fff:	83 e8 01             	sub    $0x1,%eax
    1002:	83 ec 04             	sub    $0x4,%esp
    1005:	50                   	push   %eax
    1006:	ff 75 0c             	pushl  0xc(%ebp)
    1009:	ff 75 10             	pushl  0x10(%ebp)
    100c:	ff 75 0c             	pushl  0xc(%ebp)
    100f:	ff 75 08             	pushl  0x8(%ebp)
    1012:	e8 16 fd ff ff       	call   d2d <APDrawLine>
    1017:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    101a:	8b 55 0c             	mov    0xc(%ebp),%edx
    101d:	8b 45 14             	mov    0x14(%ebp),%eax
    1020:	01 d0                	add    %edx,%eax
    1022:	83 e8 01             	sub    $0x1,%eax
    1025:	83 ec 04             	sub    $0x4,%esp
    1028:	ff 75 10             	pushl  0x10(%ebp)
    102b:	50                   	push   %eax
    102c:	ff 75 10             	pushl  0x10(%ebp)
    102f:	ff 75 0c             	pushl  0xc(%ebp)
    1032:	ff 75 08             	pushl  0x8(%ebp)
    1035:	e8 f3 fc ff ff       	call   d2d <APDrawLine>
    103a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    103d:	8b 55 10             	mov    0x10(%ebp),%edx
    1040:	8b 45 18             	mov    0x18(%ebp),%eax
    1043:	01 d0                	add    %edx,%eax
    1045:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1048:	8b 55 0c             	mov    0xc(%ebp),%edx
    104b:	8b 45 14             	mov    0x14(%ebp),%eax
    104e:	01 d0                	add    %edx,%eax
    1050:	8d 50 ff             	lea    -0x1(%eax),%edx
    1053:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1056:	8b 45 14             	mov    0x14(%ebp),%eax
    1059:	01 d8                	add    %ebx,%eax
    105b:	83 e8 01             	sub    $0x1,%eax
    105e:	83 ec 04             	sub    $0x4,%esp
    1061:	51                   	push   %ecx
    1062:	52                   	push   %edx
    1063:	ff 75 10             	pushl  0x10(%ebp)
    1066:	50                   	push   %eax
    1067:	ff 75 08             	pushl  0x8(%ebp)
    106a:	e8 be fc ff ff       	call   d2d <APDrawLine>
    106f:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1072:	8b 55 10             	mov    0x10(%ebp),%edx
    1075:	8b 45 18             	mov    0x18(%ebp),%eax
    1078:	01 d0                	add    %edx,%eax
    107a:	8d 48 ff             	lea    -0x1(%eax),%ecx
    107d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1080:	8b 45 14             	mov    0x14(%ebp),%eax
    1083:	01 d0                	add    %edx,%eax
    1085:	8d 50 ff             	lea    -0x1(%eax),%edx
    1088:	8b 5d 10             	mov    0x10(%ebp),%ebx
    108b:	8b 45 18             	mov    0x18(%ebp),%eax
    108e:	01 d8                	add    %ebx,%eax
    1090:	83 e8 01             	sub    $0x1,%eax
    1093:	83 ec 04             	sub    $0x4,%esp
    1096:	51                   	push   %ecx
    1097:	52                   	push   %edx
    1098:	50                   	push   %eax
    1099:	ff 75 0c             	pushl  0xc(%ebp)
    109c:	ff 75 08             	pushl  0x8(%ebp)
    109f:	e8 89 fc ff ff       	call   d2d <APDrawLine>
    10a4:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10a7:	8b 55 0c             	mov    0xc(%ebp),%edx
    10aa:	8b 45 14             	mov    0x14(%ebp),%eax
    10ad:	01 d0                	add    %edx,%eax
    10af:	8d 50 ff             	lea    -0x1(%eax),%edx
    10b2:	8b 45 08             	mov    0x8(%ebp),%eax
    10b5:	8b 40 0c             	mov    0xc(%eax),%eax
    10b8:	89 c1                	mov    %eax,%ecx
    10ba:	c1 e9 1f             	shr    $0x1f,%ecx
    10bd:	01 c8                	add    %ecx,%eax
    10bf:	d1 f8                	sar    %eax
    10c1:	29 c2                	sub    %eax,%edx
    10c3:	89 d0                	mov    %edx,%eax
    10c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10c8:	8b 55 10             	mov    0x10(%ebp),%edx
    10cb:	8b 45 18             	mov    0x18(%ebp),%eax
    10ce:	01 d0                	add    %edx,%eax
    10d0:	8d 50 ff             	lea    -0x1(%eax),%edx
    10d3:	8b 45 08             	mov    0x8(%ebp),%eax
    10d6:	8b 40 0c             	mov    0xc(%eax),%eax
    10d9:	89 c1                	mov    %eax,%ecx
    10db:	c1 e9 1f             	shr    $0x1f,%ecx
    10de:	01 c8                	add    %ecx,%eax
    10e0:	d1 f8                	sar    %eax
    10e2:	29 c2                	sub    %eax,%edx
    10e4:	89 d0                	mov    %edx,%eax
    10e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    10e9:	8b 45 08             	mov    0x8(%ebp),%eax
    10ec:	8b 40 0c             	mov    0xc(%eax),%eax
    10ef:	89 c2                	mov    %eax,%edx
    10f1:	c1 ea 1f             	shr    $0x1f,%edx
    10f4:	01 d0                	add    %edx,%eax
    10f6:	d1 f8                	sar    %eax
    10f8:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    10fb:	8b 45 08             	mov    0x8(%ebp),%eax
    10fe:	8b 40 0c             	mov    0xc(%eax),%eax
    1101:	89 c2                	mov    %eax,%edx
    1103:	c1 ea 1f             	shr    $0x1f,%edx
    1106:	01 d0                	add    %edx,%eax
    1108:	d1 f8                	sar    %eax
    110a:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    110d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1111:	0f 88 d8 00 00 00    	js     11ef <APDrawRect+0x1ff>
    1117:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    111b:	0f 88 ce 00 00 00    	js     11ef <APDrawRect+0x1ff>
    1121:	8b 45 08             	mov    0x8(%ebp),%eax
    1124:	8b 00                	mov    (%eax),%eax
    1126:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1129:	0f 8e c0 00 00 00    	jle    11ef <APDrawRect+0x1ff>
    112f:	8b 45 08             	mov    0x8(%ebp),%eax
    1132:	8b 40 04             	mov    0x4(%eax),%eax
    1135:	3b 45 10             	cmp    0x10(%ebp),%eax
    1138:	0f 8e b1 00 00 00    	jle    11ef <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    113e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1142:	79 07                	jns    114b <APDrawRect+0x15b>
    1144:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    114b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    114f:	79 07                	jns    1158 <APDrawRect+0x168>
    1151:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1158:	8b 45 08             	mov    0x8(%ebp),%eax
    115b:	8b 00                	mov    (%eax),%eax
    115d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1160:	7f 0b                	jg     116d <APDrawRect+0x17d>
    1162:	8b 45 08             	mov    0x8(%ebp),%eax
    1165:	8b 00                	mov    (%eax),%eax
    1167:	83 e8 01             	sub    $0x1,%eax
    116a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    116d:	8b 45 08             	mov    0x8(%ebp),%eax
    1170:	8b 40 04             	mov    0x4(%eax),%eax
    1173:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1176:	7f 0c                	jg     1184 <APDrawRect+0x194>
    1178:	8b 45 08             	mov    0x8(%ebp),%eax
    117b:	8b 40 04             	mov    0x4(%eax),%eax
    117e:	83 e8 01             	sub    $0x1,%eax
    1181:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1184:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    118b:	8b 45 0c             	mov    0xc(%ebp),%eax
    118e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1191:	eb 52                	jmp    11e5 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1193:	8b 45 10             	mov    0x10(%ebp),%eax
    1196:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1199:	eb 3e                	jmp    11d9 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    119b:	83 ec 04             	sub    $0x4,%esp
    119e:	ff 75 e8             	pushl  -0x18(%ebp)
    11a1:	ff 75 ec             	pushl  -0x14(%ebp)
    11a4:	ff 75 08             	pushl  0x8(%ebp)
    11a7:	e8 02 f7 ff ff       	call   8ae <APGetIndex>
    11ac:	83 c4 10             	add    $0x10,%esp
    11af:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11b2:	8b 45 08             	mov    0x8(%ebp),%eax
    11b5:	8b 48 18             	mov    0x18(%eax),%ecx
    11b8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11bb:	89 d0                	mov    %edx,%eax
    11bd:	01 c0                	add    %eax,%eax
    11bf:	01 d0                	add    %edx,%eax
    11c1:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11c4:	8b 45 08             	mov    0x8(%ebp),%eax
    11c7:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11cb:	66 89 0a             	mov    %cx,(%edx)
    11ce:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    11d2:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    11d5:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11d9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11dc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11df:	7e ba                	jle    119b <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11e1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    11e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11e8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11eb:	7e a6                	jle    1193 <APDrawRect+0x1a3>
    11ed:	eb 01                	jmp    11f0 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    11ef:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    11f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11f3:	c9                   	leave  
    11f4:	c3                   	ret    

000011f5 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    11f5:	55                   	push   %ebp
    11f6:	89 e5                	mov    %esp,%ebp
}
    11f8:	90                   	nop
    11f9:	5d                   	pop    %ebp
    11fa:	c3                   	ret    

000011fb <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    11fb:	55                   	push   %ebp
    11fc:	89 e5                	mov    %esp,%ebp
    11fe:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1201:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1205:	0f 88 8e 01 00 00    	js     1399 <APDcCopy+0x19e>
    120b:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    120f:	0f 88 84 01 00 00    	js     1399 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1215:	8b 55 0c             	mov    0xc(%ebp),%edx
    1218:	8b 45 20             	mov    0x20(%ebp),%eax
    121b:	01 d0                	add    %edx,%eax
    121d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1220:	8b 55 10             	mov    0x10(%ebp),%edx
    1223:	8b 45 24             	mov    0x24(%ebp),%eax
    1226:	01 d0                	add    %edx,%eax
    1228:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    122b:	8b 55 18             	mov    0x18(%ebp),%edx
    122e:	8b 45 20             	mov    0x20(%ebp),%eax
    1231:	01 d0                	add    %edx,%eax
    1233:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1236:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1239:	8b 45 24             	mov    0x24(%ebp),%eax
    123c:	01 d0                	add    %edx,%eax
    123e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1241:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1245:	0f 88 51 01 00 00    	js     139c <APDcCopy+0x1a1>
    124b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    124f:	0f 88 47 01 00 00    	js     139c <APDcCopy+0x1a1>
    1255:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1259:	0f 88 3d 01 00 00    	js     139c <APDcCopy+0x1a1>
    125f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1263:	0f 88 33 01 00 00    	js     139c <APDcCopy+0x1a1>
    1269:	8b 45 14             	mov    0x14(%ebp),%eax
    126c:	8b 00                	mov    (%eax),%eax
    126e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1271:	0f 8c 25 01 00 00    	jl     139c <APDcCopy+0x1a1>
    1277:	8b 45 14             	mov    0x14(%ebp),%eax
    127a:	8b 40 04             	mov    0x4(%eax),%eax
    127d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1280:	0f 8c 16 01 00 00    	jl     139c <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1286:	8b 45 08             	mov    0x8(%ebp),%eax
    1289:	8b 00                	mov    (%eax),%eax
    128b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    128e:	7f 0b                	jg     129b <APDcCopy+0xa0>
    1290:	8b 45 08             	mov    0x8(%ebp),%eax
    1293:	8b 00                	mov    (%eax),%eax
    1295:	83 e8 01             	sub    $0x1,%eax
    1298:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    129b:	8b 45 08             	mov    0x8(%ebp),%eax
    129e:	8b 40 04             	mov    0x4(%eax),%eax
    12a1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12a4:	7f 0c                	jg     12b2 <APDcCopy+0xb7>
    12a6:	8b 45 08             	mov    0x8(%ebp),%eax
    12a9:	8b 40 04             	mov    0x4(%eax),%eax
    12ac:	83 e8 01             	sub    $0x1,%eax
    12af:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    12b2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12b9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    12c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12c7:	e9 bc 00 00 00       	jmp    1388 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12cc:	8b 45 08             	mov    0x8(%ebp),%eax
    12cf:	8b 00                	mov    (%eax),%eax
    12d1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12d4:	8b 55 10             	mov    0x10(%ebp),%edx
    12d7:	01 ca                	add    %ecx,%edx
    12d9:	0f af d0             	imul   %eax,%edx
    12dc:	8b 45 0c             	mov    0xc(%ebp),%eax
    12df:	01 d0                	add    %edx,%eax
    12e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    12e4:	8b 45 14             	mov    0x14(%ebp),%eax
    12e7:	8b 00                	mov    (%eax),%eax
    12e9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12ec:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12ef:	01 ca                	add    %ecx,%edx
    12f1:	0f af d0             	imul   %eax,%edx
    12f4:	8b 45 18             	mov    0x18(%ebp),%eax
    12f7:	01 d0                	add    %edx,%eax
    12f9:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    12fc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1303:	eb 74                	jmp    1379 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1305:	8b 45 14             	mov    0x14(%ebp),%eax
    1308:	8b 50 18             	mov    0x18(%eax),%edx
    130b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    130e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1311:	01 c8                	add    %ecx,%eax
    1313:	89 c1                	mov    %eax,%ecx
    1315:	89 c8                	mov    %ecx,%eax
    1317:	01 c0                	add    %eax,%eax
    1319:	01 c8                	add    %ecx,%eax
    131b:	01 d0                	add    %edx,%eax
    131d:	0f b7 10             	movzwl (%eax),%edx
    1320:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1324:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1328:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    132b:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    132f:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1333:	38 c2                	cmp    %al,%dl
    1335:	75 18                	jne    134f <APDcCopy+0x154>
    1337:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    133b:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    133f:	38 c2                	cmp    %al,%dl
    1341:	75 0c                	jne    134f <APDcCopy+0x154>
    1343:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1347:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    134b:	38 c2                	cmp    %al,%dl
    134d:	74 26                	je     1375 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    134f:	8b 45 08             	mov    0x8(%ebp),%eax
    1352:	8b 50 18             	mov    0x18(%eax),%edx
    1355:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1358:	8b 45 f0             	mov    -0x10(%ebp),%eax
    135b:	01 c8                	add    %ecx,%eax
    135d:	89 c1                	mov    %eax,%ecx
    135f:	89 c8                	mov    %ecx,%eax
    1361:	01 c0                	add    %eax,%eax
    1363:	01 c8                	add    %ecx,%eax
    1365:	01 d0                	add    %edx,%eax
    1367:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    136b:	66 89 10             	mov    %dx,(%eax)
    136e:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1372:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1375:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1379:	8b 45 fc             	mov    -0x4(%ebp),%eax
    137c:	2b 45 0c             	sub    0xc(%ebp),%eax
    137f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1382:	7d 81                	jge    1305 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1384:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1388:	8b 45 f8             	mov    -0x8(%ebp),%eax
    138b:	2b 45 10             	sub    0x10(%ebp),%eax
    138e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1391:	0f 8d 35 ff ff ff    	jge    12cc <APDcCopy+0xd1>
    1397:	eb 04                	jmp    139d <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1399:	90                   	nop
    139a:	eb 01                	jmp    139d <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    139c:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    139d:	c9                   	leave  
    139e:	c3                   	ret    

0000139f <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    139f:	55                   	push   %ebp
    13a0:	89 e5                	mov    %esp,%ebp
    13a2:	83 ec 1c             	sub    $0x1c,%esp
    13a5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    13a8:	8b 55 10             	mov    0x10(%ebp),%edx
    13ab:	8b 45 14             	mov    0x14(%ebp),%eax
    13ae:	88 4d ec             	mov    %cl,-0x14(%ebp)
    13b1:	88 55 e8             	mov    %dl,-0x18(%ebp)
    13b4:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    13b7:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13bb:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13be:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13c2:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13c5:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13c9:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13cc:	8b 45 08             	mov    0x8(%ebp),%eax
    13cf:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13d3:	66 89 10             	mov    %dx,(%eax)
    13d6:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13da:	88 50 02             	mov    %dl,0x2(%eax)
}
    13dd:	8b 45 08             	mov    0x8(%ebp),%eax
    13e0:	c9                   	leave  
    13e1:	c2 04 00             	ret    $0x4

000013e4 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    13e4:	55                   	push   %ebp
    13e5:	89 e5                	mov    %esp,%ebp
    13e7:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13ea:	8b 45 08             	mov    0x8(%ebp),%eax
    13ed:	8b 00                	mov    (%eax),%eax
    13ef:	83 ec 08             	sub    $0x8,%esp
    13f2:	8d 55 0c             	lea    0xc(%ebp),%edx
    13f5:	52                   	push   %edx
    13f6:	50                   	push   %eax
    13f7:	e8 77 ef ff ff       	call   373 <sendMessage>
    13fc:	83 c4 10             	add    $0x10,%esp
}
    13ff:	90                   	nop
    1400:	c9                   	leave  
    1401:	c3                   	ret    

00001402 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1402:	55                   	push   %ebp
    1403:	89 e5                	mov    %esp,%ebp
    1405:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1408:	83 ec 0c             	sub    $0xc,%esp
    140b:	68 98 00 00 00       	push   $0x98
    1410:	e8 38 f3 ff ff       	call   74d <malloc>
    1415:	83 c4 10             	add    $0x10,%esp
    1418:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    141b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    141f:	75 15                	jne    1436 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1421:	83 ec 04             	sub    $0x4,%esp
    1424:	ff 75 08             	pushl  0x8(%ebp)
    1427:	68 7c 22 00 00       	push   $0x227c
    142c:	6a 01                	push   $0x1
    142e:	e8 47 f0 ff ff       	call   47a <printf>
    1433:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1436:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1439:	05 84 00 00 00       	add    $0x84,%eax
    143e:	83 ec 08             	sub    $0x8,%esp
    1441:	ff 75 08             	pushl  0x8(%ebp)
    1444:	50                   	push   %eax
    1445:	e8 50 ec ff ff       	call   9a <strcpy>
    144a:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    144d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1450:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1457:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145a:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1461:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1464:	8b 40 3c             	mov    0x3c(%eax),%eax
    1467:	89 c2                	mov    %eax,%edx
    1469:	8b 45 f4             	mov    -0xc(%ebp),%eax
    146c:	8b 40 40             	mov    0x40(%eax),%eax
    146f:	0f af d0             	imul   %eax,%edx
    1472:	89 d0                	mov    %edx,%eax
    1474:	01 c0                	add    %eax,%eax
    1476:	01 d0                	add    %edx,%eax
    1478:	83 ec 0c             	sub    $0xc,%esp
    147b:	50                   	push   %eax
    147c:	e8 cc f2 ff ff       	call   74d <malloc>
    1481:	83 c4 10             	add    $0x10,%esp
    1484:	89 c2                	mov    %eax,%edx
    1486:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1489:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    148c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    148f:	8b 40 54             	mov    0x54(%eax),%eax
    1492:	85 c0                	test   %eax,%eax
    1494:	75 15                	jne    14ab <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1496:	83 ec 04             	sub    $0x4,%esp
    1499:	ff 75 08             	pushl  0x8(%ebp)
    149c:	68 9c 22 00 00       	push   $0x229c
    14a1:	6a 01                	push   $0x1
    14a3:	e8 d2 ef ff ff       	call   47a <printf>
    14a8:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ae:	8b 40 3c             	mov    0x3c(%eax),%eax
    14b1:	89 c2                	mov    %eax,%edx
    14b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b6:	8b 40 40             	mov    0x40(%eax),%eax
    14b9:	0f af d0             	imul   %eax,%edx
    14bc:	89 d0                	mov    %edx,%eax
    14be:	01 c0                	add    %eax,%eax
    14c0:	01 c2                	add    %eax,%edx
    14c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c5:	8b 40 54             	mov    0x54(%eax),%eax
    14c8:	83 ec 04             	sub    $0x4,%esp
    14cb:	52                   	push   %edx
    14cc:	68 ff ff ff 00       	push   $0xffffff
    14d1:	50                   	push   %eax
    14d2:	e8 59 ec ff ff       	call   130 <memset>
    14d7:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14dd:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    14e4:	e8 62 ee ff ff       	call   34b <getpid>
    14e9:	89 c2                	mov    %eax,%edx
    14eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ee:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f4:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14fe:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1505:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1508:	8b 40 58             	mov    0x58(%eax),%eax
    150b:	89 c2                	mov    %eax,%edx
    150d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1510:	8b 40 5c             	mov    0x5c(%eax),%eax
    1513:	0f af d0             	imul   %eax,%edx
    1516:	89 d0                	mov    %edx,%eax
    1518:	01 c0                	add    %eax,%eax
    151a:	01 d0                	add    %edx,%eax
    151c:	83 ec 0c             	sub    $0xc,%esp
    151f:	50                   	push   %eax
    1520:	e8 28 f2 ff ff       	call   74d <malloc>
    1525:	83 c4 10             	add    $0x10,%esp
    1528:	89 c2                	mov    %eax,%edx
    152a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152d:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1530:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1533:	8b 40 70             	mov    0x70(%eax),%eax
    1536:	85 c0                	test   %eax,%eax
    1538:	75 15                	jne    154f <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    153a:	83 ec 04             	sub    $0x4,%esp
    153d:	ff 75 08             	pushl  0x8(%ebp)
    1540:	68 c0 22 00 00       	push   $0x22c0
    1545:	6a 01                	push   $0x1
    1547:	e8 2e ef ff ff       	call   47a <printf>
    154c:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    154f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1552:	8b 40 3c             	mov    0x3c(%eax),%eax
    1555:	89 c2                	mov    %eax,%edx
    1557:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155a:	8b 40 40             	mov    0x40(%eax),%eax
    155d:	0f af d0             	imul   %eax,%edx
    1560:	89 d0                	mov    %edx,%eax
    1562:	01 c0                	add    %eax,%eax
    1564:	01 c2                	add    %eax,%edx
    1566:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1569:	8b 40 54             	mov    0x54(%eax),%eax
    156c:	83 ec 04             	sub    $0x4,%esp
    156f:	52                   	push   %edx
    1570:	68 ff 00 00 00       	push   $0xff
    1575:	50                   	push   %eax
    1576:	e8 b5 eb ff ff       	call   130 <memset>
    157b:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    157e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1581:	8b 55 0c             	mov    0xc(%ebp),%edx
    1584:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1587:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    158b:	74 49                	je     15d6 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    158d:	8b 45 10             	mov    0x10(%ebp),%eax
    1590:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1596:	83 ec 0c             	sub    $0xc,%esp
    1599:	50                   	push   %eax
    159a:	e8 ae f1 ff ff       	call   74d <malloc>
    159f:	83 c4 10             	add    $0x10,%esp
    15a2:	89 c2                	mov    %eax,%edx
    15a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a7:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    15aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ad:	8b 55 10             	mov    0x10(%ebp),%edx
    15b0:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    15b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b6:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    15bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c0:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    15c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ca:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    15d1:	e9 8d 00 00 00       	jmp    1663 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d9:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e3:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ed:	8b 40 20             	mov    0x20(%eax),%eax
    15f0:	89 c2                	mov    %eax,%edx
    15f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f5:	8b 40 24             	mov    0x24(%eax),%eax
    15f8:	0f af d0             	imul   %eax,%edx
    15fb:	89 d0                	mov    %edx,%eax
    15fd:	01 c0                	add    %eax,%eax
    15ff:	01 d0                	add    %edx,%eax
    1601:	83 ec 0c             	sub    $0xc,%esp
    1604:	50                   	push   %eax
    1605:	e8 43 f1 ff ff       	call   74d <malloc>
    160a:	83 c4 10             	add    $0x10,%esp
    160d:	89 c2                	mov    %eax,%edx
    160f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1612:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1615:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1618:	8b 40 38             	mov    0x38(%eax),%eax
    161b:	85 c0                	test   %eax,%eax
    161d:	75 15                	jne    1634 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    161f:	83 ec 04             	sub    $0x4,%esp
    1622:	ff 75 08             	pushl  0x8(%ebp)
    1625:	68 e8 22 00 00       	push   $0x22e8
    162a:	6a 01                	push   $0x1
    162c:	e8 49 ee ff ff       	call   47a <printf>
    1631:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1634:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1637:	8b 40 20             	mov    0x20(%eax),%eax
    163a:	89 c2                	mov    %eax,%edx
    163c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163f:	8b 40 24             	mov    0x24(%eax),%eax
    1642:	0f af d0             	imul   %eax,%edx
    1645:	89 d0                	mov    %edx,%eax
    1647:	01 c0                	add    %eax,%eax
    1649:	01 c2                	add    %eax,%edx
    164b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164e:	8b 40 38             	mov    0x38(%eax),%eax
    1651:	83 ec 04             	sub    $0x4,%esp
    1654:	52                   	push   %edx
    1655:	68 ff ff ff 00       	push   $0xffffff
    165a:	50                   	push   %eax
    165b:	e8 d0 ea ff ff       	call   130 <memset>
    1660:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1663:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1666:	c9                   	leave  
    1667:	c3                   	ret    

00001668 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1668:	55                   	push   %ebp
    1669:	89 e5                	mov    %esp,%ebp
    166b:	57                   	push   %edi
    166c:	56                   	push   %esi
    166d:	53                   	push   %ebx
    166e:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1671:	8b 45 0c             	mov    0xc(%ebp),%eax
    1674:	83 f8 03             	cmp    $0x3,%eax
    1677:	74 02                	je     167b <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1679:	eb 7c                	jmp    16f7 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    167b:	8b 45 08             	mov    0x8(%ebp),%eax
    167e:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1681:	8b 45 08             	mov    0x8(%ebp),%eax
    1684:	8b 48 18             	mov    0x18(%eax),%ecx
    1687:	8b 45 08             	mov    0x8(%ebp),%eax
    168a:	8b 50 5c             	mov    0x5c(%eax),%edx
    168d:	8b 45 08             	mov    0x8(%ebp),%eax
    1690:	8b 40 58             	mov    0x58(%eax),%eax
    1693:	8b 75 08             	mov    0x8(%ebp),%esi
    1696:	83 c6 58             	add    $0x58,%esi
    1699:	83 ec 04             	sub    $0x4,%esp
    169c:	53                   	push   %ebx
    169d:	51                   	push   %ecx
    169e:	6a 00                	push   $0x0
    16a0:	52                   	push   %edx
    16a1:	50                   	push   %eax
    16a2:	6a 00                	push   $0x0
    16a4:	6a 00                	push   $0x0
    16a6:	56                   	push   %esi
    16a7:	6a 00                	push   $0x0
    16a9:	6a 00                	push   $0x0
    16ab:	ff 75 08             	pushl  0x8(%ebp)
    16ae:	e8 b8 ec ff ff       	call   36b <paintWindow>
    16b3:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    16b6:	8b 45 08             	mov    0x8(%ebp),%eax
    16b9:	8b 70 1c             	mov    0x1c(%eax),%esi
    16bc:	8b 45 08             	mov    0x8(%ebp),%eax
    16bf:	8b 58 18             	mov    0x18(%eax),%ebx
    16c2:	8b 45 08             	mov    0x8(%ebp),%eax
    16c5:	8b 48 08             	mov    0x8(%eax),%ecx
    16c8:	8b 45 08             	mov    0x8(%ebp),%eax
    16cb:	8b 50 40             	mov    0x40(%eax),%edx
    16ce:	8b 45 08             	mov    0x8(%ebp),%eax
    16d1:	8b 40 3c             	mov    0x3c(%eax),%eax
    16d4:	8b 7d 08             	mov    0x8(%ebp),%edi
    16d7:	83 c7 3c             	add    $0x3c,%edi
    16da:	83 ec 04             	sub    $0x4,%esp
    16dd:	56                   	push   %esi
    16de:	53                   	push   %ebx
    16df:	51                   	push   %ecx
    16e0:	52                   	push   %edx
    16e1:	50                   	push   %eax
    16e2:	6a 00                	push   $0x0
    16e4:	6a 00                	push   $0x0
    16e6:	57                   	push   %edi
    16e7:	6a 32                	push   $0x32
    16e9:	6a 00                	push   $0x0
    16eb:	ff 75 08             	pushl  0x8(%ebp)
    16ee:	e8 78 ec ff ff       	call   36b <paintWindow>
    16f3:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    16f6:	90                   	nop
        default: break;
            
            
    }
    return False;
    16f7:	b8 00 00 00 00       	mov    $0x0,%eax
}
    16fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16ff:	5b                   	pop    %ebx
    1700:	5e                   	pop    %esi
    1701:	5f                   	pop    %edi
    1702:	5d                   	pop    %ebp
    1703:	c3                   	ret    

00001704 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1704:	55                   	push   %ebp
    1705:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1707:	8b 45 0c             	mov    0xc(%ebp),%eax
    170a:	8b 50 08             	mov    0x8(%eax),%edx
    170d:	8b 45 08             	mov    0x8(%ebp),%eax
    1710:	8b 00                	mov    (%eax),%eax
    1712:	39 c2                	cmp    %eax,%edx
    1714:	74 07                	je     171d <APPreJudge+0x19>
        return False;
    1716:	b8 00 00 00 00       	mov    $0x0,%eax
    171b:	eb 05                	jmp    1722 <APPreJudge+0x1e>
    return True;
    171d:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1722:	5d                   	pop    %ebp
    1723:	c3                   	ret    

00001724 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1724:	55                   	push   %ebp
    1725:	89 e5                	mov    %esp,%ebp
    1727:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    172a:	8b 45 08             	mov    0x8(%ebp),%eax
    172d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1730:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1736:	83 ec 0c             	sub    $0xc,%esp
    1739:	ff 75 08             	pushl  0x8(%ebp)
    173c:	e8 42 ec ff ff       	call   383 <registWindow>
    1741:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1744:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    174b:	8b 45 08             	mov    0x8(%ebp),%eax
    174e:	8b 00                	mov    (%eax),%eax
    1750:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1753:	ff 75 f4             	pushl  -0xc(%ebp)
    1756:	ff 75 f0             	pushl  -0x10(%ebp)
    1759:	ff 75 ec             	pushl  -0x14(%ebp)
    175c:	ff 75 08             	pushl  0x8(%ebp)
    175f:	e8 80 fc ff ff       	call   13e4 <APSendMessage>
    1764:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1767:	83 ec 0c             	sub    $0xc,%esp
    176a:	ff 75 08             	pushl  0x8(%ebp)
    176d:	e8 09 ec ff ff       	call   37b <getMessage>
    1772:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1775:	8b 45 08             	mov    0x8(%ebp),%eax
    1778:	83 c0 74             	add    $0x74,%eax
    177b:	83 ec 08             	sub    $0x8,%esp
    177e:	50                   	push   %eax
    177f:	ff 75 08             	pushl  0x8(%ebp)
    1782:	e8 7d ff ff ff       	call   1704 <APPreJudge>
    1787:	83 c4 10             	add    $0x10,%esp
    178a:	84 c0                	test   %al,%al
    178c:	74 1b                	je     17a9 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    178e:	8b 45 08             	mov    0x8(%ebp),%eax
    1791:	ff 70 7c             	pushl  0x7c(%eax)
    1794:	ff 70 78             	pushl  0x78(%eax)
    1797:	ff 70 74             	pushl  0x74(%eax)
    179a:	ff 75 08             	pushl  0x8(%ebp)
    179d:	8b 45 0c             	mov    0xc(%ebp),%eax
    17a0:	ff d0                	call   *%eax
    17a2:	83 c4 10             	add    $0x10,%esp
    17a5:	84 c0                	test   %al,%al
    17a7:	75 0c                	jne    17b5 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    17a9:	8b 45 08             	mov    0x8(%ebp),%eax
    17ac:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    17b3:	eb b2                	jmp    1767 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    17b5:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    17b6:	90                   	nop
    17b7:	c9                   	leave  
    17b8:	c3                   	ret    

000017b9 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    17b9:	55                   	push   %ebp
    17ba:	89 e5                	mov    %esp,%ebp
    17bc:	57                   	push   %edi
    17bd:	56                   	push   %esi
    17be:	53                   	push   %ebx
    17bf:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    17c2:	a1 70 29 00 00       	mov    0x2970,%eax
    17c7:	85 c0                	test   %eax,%eax
    17c9:	0f 85 2c 02 00 00    	jne    19fb <APGridPaint+0x242>
    {
        iconReady = 1;
    17cf:	c7 05 70 29 00 00 01 	movl   $0x1,0x2970
    17d6:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    17d9:	8d 45 98             	lea    -0x68(%ebp),%eax
    17dc:	83 ec 08             	sub    $0x8,%esp
    17df:	68 0f 23 00 00       	push   $0x230f
    17e4:	50                   	push   %eax
    17e5:	e8 16 f1 ff ff       	call   900 <APLoadBitmap>
    17ea:	83 c4 0c             	add    $0xc,%esp
    17ed:	8b 45 98             	mov    -0x68(%ebp),%eax
    17f0:	a3 94 29 00 00       	mov    %eax,0x2994
    17f5:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17f8:	a3 98 29 00 00       	mov    %eax,0x2998
    17fd:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1800:	a3 9c 29 00 00       	mov    %eax,0x299c
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1805:	83 ec 04             	sub    $0x4,%esp
    1808:	ff 35 9c 29 00 00    	pushl  0x299c
    180e:	ff 35 98 29 00 00    	pushl  0x2998
    1814:	ff 35 94 29 00 00    	pushl  0x2994
    181a:	e8 1b f3 ff ff       	call   b3a <APCreateCompatibleDCFromBitmap>
    181f:	83 c4 10             	add    $0x10,%esp
    1822:	a3 a0 29 00 00       	mov    %eax,0x29a0
        grid_river = APLoadBitmap ("grid_river.bmp");
    1827:	8d 45 98             	lea    -0x68(%ebp),%eax
    182a:	83 ec 08             	sub    $0x8,%esp
    182d:	68 1d 23 00 00       	push   $0x231d
    1832:	50                   	push   %eax
    1833:	e8 c8 f0 ff ff       	call   900 <APLoadBitmap>
    1838:	83 c4 0c             	add    $0xc,%esp
    183b:	8b 45 98             	mov    -0x68(%ebp),%eax
    183e:	a3 d0 29 00 00       	mov    %eax,0x29d0
    1843:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1846:	a3 d4 29 00 00       	mov    %eax,0x29d4
    184b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    184e:	a3 d8 29 00 00       	mov    %eax,0x29d8
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1853:	83 ec 04             	sub    $0x4,%esp
    1856:	ff 35 d8 29 00 00    	pushl  0x29d8
    185c:	ff 35 d4 29 00 00    	pushl  0x29d4
    1862:	ff 35 d0 29 00 00    	pushl  0x29d0
    1868:	e8 cd f2 ff ff       	call   b3a <APCreateCompatibleDCFromBitmap>
    186d:	83 c4 10             	add    $0x10,%esp
    1870:	a3 c0 29 00 00       	mov    %eax,0x29c0
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1875:	8d 45 98             	lea    -0x68(%ebp),%eax
    1878:	83 ec 08             	sub    $0x8,%esp
    187b:	68 2c 23 00 00       	push   $0x232c
    1880:	50                   	push   %eax
    1881:	e8 7a f0 ff ff       	call   900 <APLoadBitmap>
    1886:	83 c4 0c             	add    $0xc,%esp
    1889:	8b 45 98             	mov    -0x68(%ebp),%eax
    188c:	a3 c4 29 00 00       	mov    %eax,0x29c4
    1891:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1894:	a3 c8 29 00 00       	mov    %eax,0x29c8
    1899:	8b 45 a0             	mov    -0x60(%ebp),%eax
    189c:	a3 cc 29 00 00       	mov    %eax,0x29cc
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    18a1:	83 ec 04             	sub    $0x4,%esp
    18a4:	ff 35 cc 29 00 00    	pushl  0x29cc
    18aa:	ff 35 c8 29 00 00    	pushl  0x29c8
    18b0:	ff 35 c4 29 00 00    	pushl  0x29c4
    18b6:	e8 7f f2 ff ff       	call   b3a <APCreateCompatibleDCFromBitmap>
    18bb:	83 c4 10             	add    $0x10,%esp
    18be:	a3 74 29 00 00       	mov    %eax,0x2974
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    18c3:	8d 45 98             	lea    -0x68(%ebp),%eax
    18c6:	83 ec 08             	sub    $0x8,%esp
    18c9:	68 3b 23 00 00       	push   $0x233b
    18ce:	50                   	push   %eax
    18cf:	e8 2c f0 ff ff       	call   900 <APLoadBitmap>
    18d4:	83 c4 0c             	add    $0xc,%esp
    18d7:	8b 45 98             	mov    -0x68(%ebp),%eax
    18da:	a3 a8 29 00 00       	mov    %eax,0x29a8
    18df:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18e2:	a3 ac 29 00 00       	mov    %eax,0x29ac
    18e7:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18ea:	a3 b0 29 00 00       	mov    %eax,0x29b0
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    18ef:	83 ec 04             	sub    $0x4,%esp
    18f2:	ff 35 b0 29 00 00    	pushl  0x29b0
    18f8:	ff 35 ac 29 00 00    	pushl  0x29ac
    18fe:	ff 35 a8 29 00 00    	pushl  0x29a8
    1904:	e8 31 f2 ff ff       	call   b3a <APCreateCompatibleDCFromBitmap>
    1909:	83 c4 10             	add    $0x10,%esp
    190c:	a3 dc 29 00 00       	mov    %eax,0x29dc
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1911:	8d 45 98             	lea    -0x68(%ebp),%eax
    1914:	83 ec 08             	sub    $0x8,%esp
    1917:	68 49 23 00 00       	push   $0x2349
    191c:	50                   	push   %eax
    191d:	e8 de ef ff ff       	call   900 <APLoadBitmap>
    1922:	83 c4 0c             	add    $0xc,%esp
    1925:	8b 45 98             	mov    -0x68(%ebp),%eax
    1928:	a3 84 29 00 00       	mov    %eax,0x2984
    192d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1930:	a3 88 29 00 00       	mov    %eax,0x2988
    1935:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1938:	a3 8c 29 00 00       	mov    %eax,0x298c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    193d:	83 ec 04             	sub    $0x4,%esp
    1940:	ff 35 8c 29 00 00    	pushl  0x298c
    1946:	ff 35 88 29 00 00    	pushl  0x2988
    194c:	ff 35 84 29 00 00    	pushl  0x2984
    1952:	e8 e3 f1 ff ff       	call   b3a <APCreateCompatibleDCFromBitmap>
    1957:	83 c4 10             	add    $0x10,%esp
    195a:	a3 a4 29 00 00       	mov    %eax,0x29a4
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    195f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1962:	83 ec 08             	sub    $0x8,%esp
    1965:	68 59 23 00 00       	push   $0x2359
    196a:	50                   	push   %eax
    196b:	e8 90 ef ff ff       	call   900 <APLoadBitmap>
    1970:	83 c4 0c             	add    $0xc,%esp
    1973:	8b 45 98             	mov    -0x68(%ebp),%eax
    1976:	a3 78 29 00 00       	mov    %eax,0x2978
    197b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    197e:	a3 7c 29 00 00       	mov    %eax,0x297c
    1983:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1986:	a3 80 29 00 00       	mov    %eax,0x2980
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    198b:	83 ec 04             	sub    $0x4,%esp
    198e:	ff 35 80 29 00 00    	pushl  0x2980
    1994:	ff 35 7c 29 00 00    	pushl  0x297c
    199a:	ff 35 78 29 00 00    	pushl  0x2978
    19a0:	e8 95 f1 ff ff       	call   b3a <APCreateCompatibleDCFromBitmap>
    19a5:	83 c4 10             	add    $0x10,%esp
    19a8:	a3 90 29 00 00       	mov    %eax,0x2990
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    19ad:	8d 45 98             	lea    -0x68(%ebp),%eax
    19b0:	83 ec 08             	sub    $0x8,%esp
    19b3:	68 6b 23 00 00       	push   $0x236b
    19b8:	50                   	push   %eax
    19b9:	e8 42 ef ff ff       	call   900 <APLoadBitmap>
    19be:	83 c4 0c             	add    $0xc,%esp
    19c1:	8b 45 98             	mov    -0x68(%ebp),%eax
    19c4:	a3 b4 29 00 00       	mov    %eax,0x29b4
    19c9:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19cc:	a3 b8 29 00 00       	mov    %eax,0x29b8
    19d1:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19d4:	a3 bc 29 00 00       	mov    %eax,0x29bc
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    19d9:	83 ec 04             	sub    $0x4,%esp
    19dc:	ff 35 bc 29 00 00    	pushl  0x29bc
    19e2:	ff 35 b8 29 00 00    	pushl  0x29b8
    19e8:	ff 35 b4 29 00 00    	pushl  0x29b4
    19ee:	e8 47 f1 ff ff       	call   b3a <APCreateCompatibleDCFromBitmap>
    19f3:	83 c4 10             	add    $0x10,%esp
    19f6:	a3 e0 29 00 00       	mov    %eax,0x29e0
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    19fb:	8b 45 08             	mov    0x8(%ebp),%eax
    19fe:	8b 40 08             	mov    0x8(%eax),%eax
    1a01:	85 c0                	test   %eax,%eax
    1a03:	75 17                	jne    1a1c <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1a05:	83 ec 08             	sub    $0x8,%esp
    1a08:	68 7c 23 00 00       	push   $0x237c
    1a0d:	6a 01                	push   $0x1
    1a0f:	e8 66 ea ff ff       	call   47a <printf>
    1a14:	83 c4 10             	add    $0x10,%esp
        return;
    1a17:	e9 a0 04 00 00       	jmp    1ebc <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1a1c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1f:	8b 40 10             	mov    0x10(%eax),%eax
    1a22:	85 c0                	test   %eax,%eax
    1a24:	7e 10                	jle    1a36 <APGridPaint+0x27d>
    1a26:	8b 45 08             	mov    0x8(%ebp),%eax
    1a29:	8b 50 14             	mov    0x14(%eax),%edx
    1a2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2f:	8b 40 10             	mov    0x10(%eax),%eax
    1a32:	39 c2                	cmp    %eax,%edx
    1a34:	7c 17                	jl     1a4d <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1a36:	83 ec 08             	sub    $0x8,%esp
    1a39:	68 a2 23 00 00       	push   $0x23a2
    1a3e:	6a 01                	push   $0x1
    1a40:	e8 35 ea ff ff       	call   47a <printf>
    1a45:	83 c4 10             	add    $0x10,%esp
        return;
    1a48:	e9 6f 04 00 00       	jmp    1ebc <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1a4d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a50:	8b 40 14             	mov    0x14(%eax),%eax
    1a53:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a59:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a5c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a5f:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a62:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a69:	e9 96 03 00 00       	jmp    1e04 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a6e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a75:	e9 7c 03 00 00       	jmp    1df6 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a7a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a7d:	c1 e0 04             	shl    $0x4,%eax
    1a80:	89 c2                	mov    %eax,%edx
    1a82:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a85:	01 c2                	add    %eax,%edx
    1a87:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a8a:	01 d0                	add    %edx,%eax
    1a8c:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a92:	8b 40 0c             	mov    0xc(%eax),%eax
    1a95:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a98:	c1 e2 02             	shl    $0x2,%edx
    1a9b:	01 d0                	add    %edx,%eax
    1a9d:	8b 00                	mov    (%eax),%eax
    1a9f:	83 f8 07             	cmp    $0x7,%eax
    1aa2:	0f 87 49 03 00 00    	ja     1df1 <APGridPaint+0x638>
    1aa8:	8b 04 85 b8 23 00 00 	mov    0x23b8(,%eax,4),%eax
    1aaf:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ab1:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1ab4:	6a 0c                	push   $0xc
    1ab6:	6a 0c                	push   $0xc
    1ab8:	6a 0c                	push   $0xc
    1aba:	50                   	push   %eax
    1abb:	e8 df f8 ff ff       	call   139f <RGB>
    1ac0:	83 c4 0c             	add    $0xc,%esp
    1ac3:	8b 1d a0 29 00 00    	mov    0x29a0,%ebx
    1ac9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1acc:	6b c8 32             	imul   $0x32,%eax,%ecx
    1acf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ad2:	6b c0 32             	imul   $0x32,%eax,%eax
    1ad5:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ad8:	8b 45 08             	mov    0x8(%ebp),%eax
    1adb:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ade:	83 ec 0c             	sub    $0xc,%esp
    1ae1:	83 ec 04             	sub    $0x4,%esp
    1ae4:	89 e0                	mov    %esp,%eax
    1ae6:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1aea:	66 89 30             	mov    %si,(%eax)
    1aed:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1af1:	88 50 02             	mov    %dl,0x2(%eax)
    1af4:	6a 32                	push   $0x32
    1af6:	6a 32                	push   $0x32
    1af8:	6a 00                	push   $0x0
    1afa:	6a 00                	push   $0x0
    1afc:	53                   	push   %ebx
    1afd:	51                   	push   %ecx
    1afe:	ff 75 94             	pushl  -0x6c(%ebp)
    1b01:	57                   	push   %edi
    1b02:	e8 f4 f6 ff ff       	call   11fb <APDcCopy>
    1b07:	83 c4 30             	add    $0x30,%esp
                    break;
    1b0a:	e9 e3 02 00 00       	jmp    1df2 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1b0f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b12:	6a 69                	push   $0x69
    1b14:	6a 69                	push   $0x69
    1b16:	6a 69                	push   $0x69
    1b18:	50                   	push   %eax
    1b19:	e8 81 f8 ff ff       	call   139f <RGB>
    1b1e:	83 c4 0c             	add    $0xc,%esp
    1b21:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b25:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1b29:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b2d:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1b30:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1b37:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b3a:	6a 69                	push   $0x69
    1b3c:	6a 69                	push   $0x69
    1b3e:	6a 69                	push   $0x69
    1b40:	50                   	push   %eax
    1b41:	e8 59 f8 ff ff       	call   139f <RGB>
    1b46:	83 c4 0c             	add    $0xc,%esp
    1b49:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b4d:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1b51:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b55:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b58:	8b 45 08             	mov    0x8(%ebp),%eax
    1b5b:	8d 50 3c             	lea    0x3c(%eax),%edx
    1b5e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b61:	ff 75 b0             	pushl  -0x50(%ebp)
    1b64:	ff 75 ac             	pushl  -0x54(%ebp)
    1b67:	52                   	push   %edx
    1b68:	50                   	push   %eax
    1b69:	e8 61 f0 ff ff       	call   bcf <APSetPen>
    1b6e:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b71:	8b 45 08             	mov    0x8(%ebp),%eax
    1b74:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1b77:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b7a:	83 ec 04             	sub    $0x4,%esp
    1b7d:	83 ec 04             	sub    $0x4,%esp
    1b80:	89 e0                	mov    %esp,%eax
    1b82:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1b86:	66 89 08             	mov    %cx,(%eax)
    1b89:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1b8d:	88 48 02             	mov    %cl,0x2(%eax)
    1b90:	53                   	push   %ebx
    1b91:	52                   	push   %edx
    1b92:	e8 71 f0 ff ff       	call   c08 <APSetBrush>
    1b97:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b9a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b9d:	6b d0 32             	imul   $0x32,%eax,%edx
    1ba0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ba3:	6b c0 32             	imul   $0x32,%eax,%eax
    1ba6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1ba9:	83 c1 3c             	add    $0x3c,%ecx
    1bac:	83 ec 0c             	sub    $0xc,%esp
    1baf:	6a 32                	push   $0x32
    1bb1:	6a 32                	push   $0x32
    1bb3:	52                   	push   %edx
    1bb4:	50                   	push   %eax
    1bb5:	51                   	push   %ecx
    1bb6:	e8 35 f4 ff ff       	call   ff0 <APDrawRect>
    1bbb:	83 c4 20             	add    $0x20,%esp
                    break;
    1bbe:	e9 2f 02 00 00       	jmp    1df2 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bc3:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1bc6:	6a 0c                	push   $0xc
    1bc8:	6a 0c                	push   $0xc
    1bca:	6a 0c                	push   $0xc
    1bcc:	50                   	push   %eax
    1bcd:	e8 cd f7 ff ff       	call   139f <RGB>
    1bd2:	83 c4 0c             	add    $0xc,%esp
    1bd5:	8b 1d e0 29 00 00    	mov    0x29e0,%ebx
    1bdb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bde:	6b c8 32             	imul   $0x32,%eax,%ecx
    1be1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1be4:	6b c0 32             	imul   $0x32,%eax,%eax
    1be7:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bea:	8b 45 08             	mov    0x8(%ebp),%eax
    1bed:	8d 78 3c             	lea    0x3c(%eax),%edi
    1bf0:	83 ec 0c             	sub    $0xc,%esp
    1bf3:	83 ec 04             	sub    $0x4,%esp
    1bf6:	89 e0                	mov    %esp,%eax
    1bf8:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1bfc:	66 89 30             	mov    %si,(%eax)
    1bff:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1c03:	88 50 02             	mov    %dl,0x2(%eax)
    1c06:	6a 32                	push   $0x32
    1c08:	6a 32                	push   $0x32
    1c0a:	6a 00                	push   $0x0
    1c0c:	6a 00                	push   $0x0
    1c0e:	53                   	push   %ebx
    1c0f:	51                   	push   %ecx
    1c10:	ff 75 94             	pushl  -0x6c(%ebp)
    1c13:	57                   	push   %edi
    1c14:	e8 e2 f5 ff ff       	call   11fb <APDcCopy>
    1c19:	83 c4 30             	add    $0x30,%esp
                    break;
    1c1c:	e9 d1 01 00 00       	jmp    1df2 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c21:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1c24:	6a 0c                	push   $0xc
    1c26:	6a 0c                	push   $0xc
    1c28:	6a 0c                	push   $0xc
    1c2a:	50                   	push   %eax
    1c2b:	e8 6f f7 ff ff       	call   139f <RGB>
    1c30:	83 c4 0c             	add    $0xc,%esp
    1c33:	8b 1d c0 29 00 00    	mov    0x29c0,%ebx
    1c39:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c3c:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c3f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c42:	6b c0 32             	imul   $0x32,%eax,%eax
    1c45:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c48:	8b 45 08             	mov    0x8(%ebp),%eax
    1c4b:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c4e:	83 ec 0c             	sub    $0xc,%esp
    1c51:	83 ec 04             	sub    $0x4,%esp
    1c54:	89 e0                	mov    %esp,%eax
    1c56:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1c5a:	66 89 30             	mov    %si,(%eax)
    1c5d:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c61:	88 50 02             	mov    %dl,0x2(%eax)
    1c64:	6a 32                	push   $0x32
    1c66:	6a 32                	push   $0x32
    1c68:	6a 00                	push   $0x0
    1c6a:	6a 00                	push   $0x0
    1c6c:	53                   	push   %ebx
    1c6d:	51                   	push   %ecx
    1c6e:	ff 75 94             	pushl  -0x6c(%ebp)
    1c71:	57                   	push   %edi
    1c72:	e8 84 f5 ff ff       	call   11fb <APDcCopy>
    1c77:	83 c4 30             	add    $0x30,%esp
                    break;
    1c7a:	e9 73 01 00 00       	jmp    1df2 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c7f:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c82:	6a 0c                	push   $0xc
    1c84:	6a 0c                	push   $0xc
    1c86:	6a 0c                	push   $0xc
    1c88:	50                   	push   %eax
    1c89:	e8 11 f7 ff ff       	call   139f <RGB>
    1c8e:	83 c4 0c             	add    $0xc,%esp
    1c91:	8b 1d a4 29 00 00    	mov    0x29a4,%ebx
    1c97:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c9a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c9d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ca0:	6b c0 32             	imul   $0x32,%eax,%eax
    1ca3:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ca6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca9:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cac:	83 ec 0c             	sub    $0xc,%esp
    1caf:	83 ec 04             	sub    $0x4,%esp
    1cb2:	89 e0                	mov    %esp,%eax
    1cb4:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1cb8:	66 89 30             	mov    %si,(%eax)
    1cbb:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1cbf:	88 50 02             	mov    %dl,0x2(%eax)
    1cc2:	6a 32                	push   $0x32
    1cc4:	6a 32                	push   $0x32
    1cc6:	6a 00                	push   $0x0
    1cc8:	6a 00                	push   $0x0
    1cca:	53                   	push   %ebx
    1ccb:	51                   	push   %ecx
    1ccc:	ff 75 94             	pushl  -0x6c(%ebp)
    1ccf:	57                   	push   %edi
    1cd0:	e8 26 f5 ff ff       	call   11fb <APDcCopy>
    1cd5:	83 c4 30             	add    $0x30,%esp
                    break;
    1cd8:	e9 15 01 00 00       	jmp    1df2 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cdd:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1ce0:	6a 0c                	push   $0xc
    1ce2:	6a 0c                	push   $0xc
    1ce4:	6a 0c                	push   $0xc
    1ce6:	50                   	push   %eax
    1ce7:	e8 b3 f6 ff ff       	call   139f <RGB>
    1cec:	83 c4 0c             	add    $0xc,%esp
    1cef:	8b 1d dc 29 00 00    	mov    0x29dc,%ebx
    1cf5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cf8:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cfb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cfe:	6b c0 32             	imul   $0x32,%eax,%eax
    1d01:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d04:	8b 45 08             	mov    0x8(%ebp),%eax
    1d07:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d0a:	83 ec 0c             	sub    $0xc,%esp
    1d0d:	83 ec 04             	sub    $0x4,%esp
    1d10:	89 e0                	mov    %esp,%eax
    1d12:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1d16:	66 89 30             	mov    %si,(%eax)
    1d19:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1d1d:	88 50 02             	mov    %dl,0x2(%eax)
    1d20:	6a 32                	push   $0x32
    1d22:	6a 32                	push   $0x32
    1d24:	6a 00                	push   $0x0
    1d26:	6a 00                	push   $0x0
    1d28:	53                   	push   %ebx
    1d29:	51                   	push   %ecx
    1d2a:	ff 75 94             	pushl  -0x6c(%ebp)
    1d2d:	57                   	push   %edi
    1d2e:	e8 c8 f4 ff ff       	call   11fb <APDcCopy>
    1d33:	83 c4 30             	add    $0x30,%esp
                    break;
    1d36:	e9 b7 00 00 00       	jmp    1df2 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d3b:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1d3e:	6a 0c                	push   $0xc
    1d40:	6a 0c                	push   $0xc
    1d42:	6a 0c                	push   $0xc
    1d44:	50                   	push   %eax
    1d45:	e8 55 f6 ff ff       	call   139f <RGB>
    1d4a:	83 c4 0c             	add    $0xc,%esp
    1d4d:	8b 1d 74 29 00 00    	mov    0x2974,%ebx
    1d53:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d56:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d59:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d5c:	6b c0 32             	imul   $0x32,%eax,%eax
    1d5f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d62:	8b 45 08             	mov    0x8(%ebp),%eax
    1d65:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d68:	83 ec 0c             	sub    $0xc,%esp
    1d6b:	83 ec 04             	sub    $0x4,%esp
    1d6e:	89 e0                	mov    %esp,%eax
    1d70:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d74:	66 89 30             	mov    %si,(%eax)
    1d77:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d7b:	88 50 02             	mov    %dl,0x2(%eax)
    1d7e:	6a 32                	push   $0x32
    1d80:	6a 32                	push   $0x32
    1d82:	6a 00                	push   $0x0
    1d84:	6a 00                	push   $0x0
    1d86:	53                   	push   %ebx
    1d87:	51                   	push   %ecx
    1d88:	ff 75 94             	pushl  -0x6c(%ebp)
    1d8b:	57                   	push   %edi
    1d8c:	e8 6a f4 ff ff       	call   11fb <APDcCopy>
    1d91:	83 c4 30             	add    $0x30,%esp
                    break;
    1d94:	eb 5c                	jmp    1df2 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d96:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d99:	6a 0c                	push   $0xc
    1d9b:	6a 0c                	push   $0xc
    1d9d:	6a 0c                	push   $0xc
    1d9f:	50                   	push   %eax
    1da0:	e8 fa f5 ff ff       	call   139f <RGB>
    1da5:	83 c4 0c             	add    $0xc,%esp
    1da8:	8b 1d 90 29 00 00    	mov    0x2990,%ebx
    1dae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1db1:	6b c8 32             	imul   $0x32,%eax,%ecx
    1db4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1db7:	6b c0 32             	imul   $0x32,%eax,%eax
    1dba:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dbd:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc0:	8d 78 3c             	lea    0x3c(%eax),%edi
    1dc3:	83 ec 0c             	sub    $0xc,%esp
    1dc6:	83 ec 04             	sub    $0x4,%esp
    1dc9:	89 e0                	mov    %esp,%eax
    1dcb:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1dcf:	66 89 30             	mov    %si,(%eax)
    1dd2:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1dd6:	88 50 02             	mov    %dl,0x2(%eax)
    1dd9:	6a 32                	push   $0x32
    1ddb:	6a 32                	push   $0x32
    1ddd:	6a 00                	push   $0x0
    1ddf:	6a 00                	push   $0x0
    1de1:	53                   	push   %ebx
    1de2:	51                   	push   %ecx
    1de3:	ff 75 94             	pushl  -0x6c(%ebp)
    1de6:	57                   	push   %edi
    1de7:	e8 0f f4 ff ff       	call   11fb <APDcCopy>
    1dec:	83 c4 30             	add    $0x30,%esp
                    break;
    1def:	eb 01                	jmp    1df2 <APGridPaint+0x639>
                default: break;
    1df1:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1df2:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1df6:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1dfa:	0f 8e 7a fc ff ff    	jle    1a7a <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e00:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e04:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1e08:	0f 8e 60 fc ff ff    	jle    1a6e <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1e0e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e11:	68 cd 00 00 00       	push   $0xcd
    1e16:	6a 74                	push   $0x74
    1e18:	6a 18                	push   $0x18
    1e1a:	50                   	push   %eax
    1e1b:	e8 7f f5 ff ff       	call   139f <RGB>
    1e20:	83 c4 0c             	add    $0xc,%esp
    1e23:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e27:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1e2b:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e2f:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1e32:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1e39:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e3c:	68 cd 00 00 00       	push   $0xcd
    1e41:	6a 74                	push   $0x74
    1e43:	6a 18                	push   $0x18
    1e45:	50                   	push   %eax
    1e46:	e8 54 f5 ff ff       	call   139f <RGB>
    1e4b:	83 c4 0c             	add    $0xc,%esp
    1e4e:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e52:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1e56:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e5a:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1e5d:	8b 45 08             	mov    0x8(%ebp),%eax
    1e60:	8d 50 58             	lea    0x58(%eax),%edx
    1e63:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e66:	ff 75 bc             	pushl  -0x44(%ebp)
    1e69:	ff 75 b8             	pushl  -0x48(%ebp)
    1e6c:	52                   	push   %edx
    1e6d:	50                   	push   %eax
    1e6e:	e8 5c ed ff ff       	call   bcf <APSetPen>
    1e73:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1e76:	8b 45 08             	mov    0x8(%ebp),%eax
    1e79:	8d 58 58             	lea    0x58(%eax),%ebx
    1e7c:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e7f:	83 ec 04             	sub    $0x4,%esp
    1e82:	83 ec 04             	sub    $0x4,%esp
    1e85:	89 e0                	mov    %esp,%eax
    1e87:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1e8b:	66 89 08             	mov    %cx,(%eax)
    1e8e:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1e92:	88 48 02             	mov    %cl,0x2(%eax)
    1e95:	53                   	push   %ebx
    1e96:	52                   	push   %edx
    1e97:	e8 6c ed ff ff       	call   c08 <APSetBrush>
    1e9c:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1e9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea2:	83 c0 58             	add    $0x58,%eax
    1ea5:	83 ec 0c             	sub    $0xc,%esp
    1ea8:	6a 32                	push   $0x32
    1eaa:	68 20 03 00 00       	push   $0x320
    1eaf:	6a 00                	push   $0x0
    1eb1:	6a 00                	push   $0x0
    1eb3:	50                   	push   %eax
    1eb4:	e8 37 f1 ff ff       	call   ff0 <APDrawRect>
    1eb9:	83 c4 20             	add    $0x20,%esp
}
    1ebc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1ebf:	5b                   	pop    %ebx
    1ec0:	5e                   	pop    %esi
    1ec1:	5f                   	pop    %edi
    1ec2:	5d                   	pop    %ebp
    1ec3:	c3                   	ret    

00001ec4 <random>:
//

#include "APLib.h"

int random(int seed)
{
    1ec4:	55                   	push   %ebp
    1ec5:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1ec7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1ecb:	7e 08                	jle    1ed5 <random+0x11>
{
rand_num = seed;
    1ecd:	8b 45 08             	mov    0x8(%ebp),%eax
    1ed0:	a3 4c 29 00 00       	mov    %eax,0x294c
}
rand_num *= 3;
    1ed5:	8b 15 4c 29 00 00    	mov    0x294c,%edx
    1edb:	89 d0                	mov    %edx,%eax
    1edd:	01 c0                	add    %eax,%eax
    1edf:	01 d0                	add    %edx,%eax
    1ee1:	a3 4c 29 00 00       	mov    %eax,0x294c
if (rand_num < 0)
    1ee6:	a1 4c 29 00 00       	mov    0x294c,%eax
    1eeb:	85 c0                	test   %eax,%eax
    1eed:	79 0c                	jns    1efb <random+0x37>
{
rand_num *= (-1);
    1eef:	a1 4c 29 00 00       	mov    0x294c,%eax
    1ef4:	f7 d8                	neg    %eax
    1ef6:	a3 4c 29 00 00       	mov    %eax,0x294c
}
return rand_num % 997;
    1efb:	8b 0d 4c 29 00 00    	mov    0x294c,%ecx
    1f01:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1f06:	89 c8                	mov    %ecx,%eax
    1f08:	f7 ea                	imul   %edx
    1f0a:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1f0d:	c1 f8 09             	sar    $0x9,%eax
    1f10:	89 c2                	mov    %eax,%edx
    1f12:	89 c8                	mov    %ecx,%eax
    1f14:	c1 f8 1f             	sar    $0x1f,%eax
    1f17:	29 c2                	sub    %eax,%edx
    1f19:	89 d0                	mov    %edx,%eax
    1f1b:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1f21:	29 c1                	sub    %eax,%ecx
    1f23:	89 c8                	mov    %ecx,%eax
}
    1f25:	5d                   	pop    %ebp
    1f26:	c3                   	ret    

00001f27 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1f27:	55                   	push   %ebp
    1f28:	89 e5                	mov    %esp,%ebp
    1f2a:	53                   	push   %ebx
    1f2b:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1f2e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1f35:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1f39:	74 17                	je     1f52 <sprintint+0x2b>
    1f3b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1f3f:	79 11                	jns    1f52 <sprintint+0x2b>
        neg = 1;
    1f41:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1f48:	8b 45 10             	mov    0x10(%ebp),%eax
    1f4b:	f7 d8                	neg    %eax
    1f4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f50:	eb 06                	jmp    1f58 <sprintint+0x31>
    } else {
        x = xx;
    1f52:	8b 45 10             	mov    0x10(%ebp),%eax
    1f55:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1f58:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1f5f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1f62:	8d 41 01             	lea    0x1(%ecx),%eax
    1f65:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1f68:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f6e:	ba 00 00 00 00       	mov    $0x0,%edx
    1f73:	f7 f3                	div    %ebx
    1f75:	89 d0                	mov    %edx,%eax
    1f77:	0f b6 80 50 29 00 00 	movzbl 0x2950(%eax),%eax
    1f7e:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1f82:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f85:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f88:	ba 00 00 00 00       	mov    $0x0,%edx
    1f8d:	f7 f3                	div    %ebx
    1f8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f92:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f96:	75 c7                	jne    1f5f <sprintint+0x38>
    if(neg)
    1f98:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f9c:	74 0e                	je     1fac <sprintint+0x85>
        buf[i++] = '-';
    1f9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fa1:	8d 50 01             	lea    0x1(%eax),%edx
    1fa4:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1fa7:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1fac:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1faf:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1fb2:	eb 1b                	jmp    1fcf <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1fb4:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fb7:	8b 00                	mov    (%eax),%eax
    1fb9:	8d 48 01             	lea    0x1(%eax),%ecx
    1fbc:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fbf:	89 0a                	mov    %ecx,(%edx)
    1fc1:	89 c2                	mov    %eax,%edx
    1fc3:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc6:	01 d0                	add    %edx,%eax
    1fc8:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1fcb:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1fcf:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1fd3:	7f df                	jg     1fb4 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fd5:	eb 21                	jmp    1ff8 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1fd7:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fda:	8b 00                	mov    (%eax),%eax
    1fdc:	8d 48 01             	lea    0x1(%eax),%ecx
    1fdf:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fe2:	89 0a                	mov    %ecx,(%edx)
    1fe4:	89 c2                	mov    %eax,%edx
    1fe6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe9:	01 c2                	add    %eax,%edx
    1feb:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1fee:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ff1:	01 c8                	add    %ecx,%eax
    1ff3:	0f b6 00             	movzbl (%eax),%eax
    1ff6:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1ff8:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1ffc:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2000:	79 d5                	jns    1fd7 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2002:	90                   	nop
    2003:	83 c4 20             	add    $0x20,%esp
    2006:	5b                   	pop    %ebx
    2007:	5d                   	pop    %ebp
    2008:	c3                   	ret    

00002009 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2009:	55                   	push   %ebp
    200a:	89 e5                	mov    %esp,%ebp
    200c:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    200f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2016:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    201d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2024:	8d 45 0c             	lea    0xc(%ebp),%eax
    2027:	83 c0 04             	add    $0x4,%eax
    202a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    202d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2034:	e9 d9 01 00 00       	jmp    2212 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2039:	8b 55 0c             	mov    0xc(%ebp),%edx
    203c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    203f:	01 d0                	add    %edx,%eax
    2041:	0f b6 00             	movzbl (%eax),%eax
    2044:	0f be c0             	movsbl %al,%eax
    2047:	25 ff 00 00 00       	and    $0xff,%eax
    204c:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    204f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2053:	75 2c                	jne    2081 <sprintf+0x78>
            if(c == '%'){
    2055:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2059:	75 0c                	jne    2067 <sprintf+0x5e>
                state = '%';
    205b:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2062:	e9 a7 01 00 00       	jmp    220e <sprintf+0x205>
            } else {
                dst[j++] = c;
    2067:	8b 45 c8             	mov    -0x38(%ebp),%eax
    206a:	8d 50 01             	lea    0x1(%eax),%edx
    206d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2070:	89 c2                	mov    %eax,%edx
    2072:	8b 45 08             	mov    0x8(%ebp),%eax
    2075:	01 d0                	add    %edx,%eax
    2077:	8b 55 e0             	mov    -0x20(%ebp),%edx
    207a:	88 10                	mov    %dl,(%eax)
    207c:	e9 8d 01 00 00       	jmp    220e <sprintf+0x205>
            }
        } else if(state == '%'){
    2081:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2085:	0f 85 83 01 00 00    	jne    220e <sprintf+0x205>
            if(c == 'd'){
    208b:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    208f:	75 4c                	jne    20dd <sprintf+0xd4>
                buf[bi] = '\0';
    2091:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2094:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2097:	01 d0                	add    %edx,%eax
    2099:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    209c:	83 ec 0c             	sub    $0xc,%esp
    209f:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20a2:	50                   	push   %eax
    20a3:	e8 91 e1 ff ff       	call   239 <atoi>
    20a8:	83 c4 10             	add    $0x10,%esp
    20ab:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    20ae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    20b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20b8:	8b 00                	mov    (%eax),%eax
    20ba:	83 ec 08             	sub    $0x8,%esp
    20bd:	ff 75 d8             	pushl  -0x28(%ebp)
    20c0:	6a 01                	push   $0x1
    20c2:	6a 0a                	push   $0xa
    20c4:	50                   	push   %eax
    20c5:	8d 45 c8             	lea    -0x38(%ebp),%eax
    20c8:	50                   	push   %eax
    20c9:	ff 75 08             	pushl  0x8(%ebp)
    20cc:	e8 56 fe ff ff       	call   1f27 <sprintint>
    20d1:	83 c4 20             	add    $0x20,%esp
                ap++;
    20d4:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    20d8:	e9 2a 01 00 00       	jmp    2207 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    20dd:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    20e1:	74 06                	je     20e9 <sprintf+0xe0>
    20e3:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    20e7:	75 4c                	jne    2135 <sprintf+0x12c>
                buf[bi] = '\0';
    20e9:	8d 55 ce             	lea    -0x32(%ebp),%edx
    20ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20ef:	01 d0                	add    %edx,%eax
    20f1:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    20f4:	83 ec 0c             	sub    $0xc,%esp
    20f7:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20fa:	50                   	push   %eax
    20fb:	e8 39 e1 ff ff       	call   239 <atoi>
    2100:	83 c4 10             	add    $0x10,%esp
    2103:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2106:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    210d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2110:	8b 00                	mov    (%eax),%eax
    2112:	83 ec 08             	sub    $0x8,%esp
    2115:	ff 75 dc             	pushl  -0x24(%ebp)
    2118:	6a 00                	push   $0x0
    211a:	6a 10                	push   $0x10
    211c:	50                   	push   %eax
    211d:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2120:	50                   	push   %eax
    2121:	ff 75 08             	pushl  0x8(%ebp)
    2124:	e8 fe fd ff ff       	call   1f27 <sprintint>
    2129:	83 c4 20             	add    $0x20,%esp
                ap++;
    212c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2130:	e9 d2 00 00 00       	jmp    2207 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2135:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2139:	75 46                	jne    2181 <sprintf+0x178>
                s = (char*)*ap;
    213b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    213e:	8b 00                	mov    (%eax),%eax
    2140:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2143:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2147:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    214b:	75 25                	jne    2172 <sprintf+0x169>
                    s = "(null)";
    214d:	c7 45 f4 d8 23 00 00 	movl   $0x23d8,-0xc(%ebp)
                while(*s != 0){
    2154:	eb 1c                	jmp    2172 <sprintf+0x169>
                    dst[j++] = *s;
    2156:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2159:	8d 50 01             	lea    0x1(%eax),%edx
    215c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    215f:	89 c2                	mov    %eax,%edx
    2161:	8b 45 08             	mov    0x8(%ebp),%eax
    2164:	01 c2                	add    %eax,%edx
    2166:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2169:	0f b6 00             	movzbl (%eax),%eax
    216c:	88 02                	mov    %al,(%edx)
                    s++;
    216e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2172:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2175:	0f b6 00             	movzbl (%eax),%eax
    2178:	84 c0                	test   %al,%al
    217a:	75 da                	jne    2156 <sprintf+0x14d>
    217c:	e9 86 00 00 00       	jmp    2207 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2181:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2185:	75 1d                	jne    21a4 <sprintf+0x19b>
                dst[j++] = *ap;
    2187:	8b 45 c8             	mov    -0x38(%ebp),%eax
    218a:	8d 50 01             	lea    0x1(%eax),%edx
    218d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2190:	89 c2                	mov    %eax,%edx
    2192:	8b 45 08             	mov    0x8(%ebp),%eax
    2195:	01 c2                	add    %eax,%edx
    2197:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    219a:	8b 00                	mov    (%eax),%eax
    219c:	88 02                	mov    %al,(%edx)
                ap++;
    219e:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    21a2:	eb 63                	jmp    2207 <sprintf+0x1fe>
            } else if(c == '%'){
    21a4:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    21a8:	75 17                	jne    21c1 <sprintf+0x1b8>
                dst[j++] = c;
    21aa:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21ad:	8d 50 01             	lea    0x1(%eax),%edx
    21b0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21b3:	89 c2                	mov    %eax,%edx
    21b5:	8b 45 08             	mov    0x8(%ebp),%eax
    21b8:	01 d0                	add    %edx,%eax
    21ba:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21bd:	88 10                	mov    %dl,(%eax)
    21bf:	eb 46                	jmp    2207 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    21c1:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    21c5:	7e 18                	jle    21df <sprintf+0x1d6>
    21c7:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    21cb:	7f 12                	jg     21df <sprintf+0x1d6>
            {
                buf[bi++] = c;
    21cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21d0:	8d 50 01             	lea    0x1(%eax),%edx
    21d3:	89 55 f0             	mov    %edx,-0x10(%ebp)
    21d6:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21d9:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    21dd:	eb 2f                	jmp    220e <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    21df:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21e2:	8d 50 01             	lea    0x1(%eax),%edx
    21e5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21e8:	89 c2                	mov    %eax,%edx
    21ea:	8b 45 08             	mov    0x8(%ebp),%eax
    21ed:	01 d0                	add    %edx,%eax
    21ef:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    21f2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21f5:	8d 50 01             	lea    0x1(%eax),%edx
    21f8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21fb:	89 c2                	mov    %eax,%edx
    21fd:	8b 45 08             	mov    0x8(%ebp),%eax
    2200:	01 d0                	add    %edx,%eax
    2202:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2205:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2207:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    220e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2212:	8b 55 0c             	mov    0xc(%ebp),%edx
    2215:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2218:	01 d0                	add    %edx,%eax
    221a:	0f b6 00             	movzbl (%eax),%eax
    221d:	84 c0                	test   %al,%al
    221f:	0f 85 14 fe ff ff    	jne    2039 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2225:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2228:	8d 50 01             	lea    0x1(%eax),%edx
    222b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    222e:	89 c2                	mov    %eax,%edx
    2230:	8b 45 08             	mov    0x8(%ebp),%eax
    2233:	01 d0                	add    %edx,%eax
    2235:	c6 00 00             	movb   $0x0,(%eax)
}
    2238:	90                   	nop
    2239:	c9                   	leave  
    223a:	c3                   	ret    
