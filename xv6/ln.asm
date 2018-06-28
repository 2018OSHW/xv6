
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
      19:	68 ac 1e 00 00       	push   $0x1eac
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
      60:	68 bf 1e 00 00       	push   $0x1ebf
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
     406:	0f b6 80 44 25 00 00 	movzbl 0x2544(%eax),%eax
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
     544:	c7 45 f4 d3 1e 00 00 	movl   $0x1ed3,-0xc(%ebp)
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
     60a:	a1 74 25 00 00       	mov    0x2574,%eax
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
     6d5:	a3 74 25 00 00       	mov    %eax,0x2574
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
     736:	a1 74 25 00 00       	mov    0x2574,%eax
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
     752:	a1 74 25 00 00       	mov    0x2574,%eax
     757:	89 45 f0             	mov    %eax,-0x10(%ebp)
     75a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     75e:	75 23                	jne    783 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     760:	c7 45 f0 6c 25 00 00 	movl   $0x256c,-0x10(%ebp)
     767:	8b 45 f0             	mov    -0x10(%ebp),%eax
     76a:	a3 74 25 00 00       	mov    %eax,0x2574
     76f:	a1 74 25 00 00       	mov    0x2574,%eax
     774:	a3 6c 25 00 00       	mov    %eax,0x256c
    base.s.size = 0;
     779:	c7 05 70 25 00 00 00 	movl   $0x0,0x2570
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
     7d6:	a3 74 25 00 00       	mov    %eax,0x2574
      return (void*)(p + 1);
     7db:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7de:	83 c0 08             	add    $0x8,%eax
     7e1:	eb 3b                	jmp    81e <malloc+0xe1>
    }
    if(p == freep)
     7e3:	a1 74 25 00 00       	mov    0x2574,%eax
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
     8f3:	56                   	push   %esi
     8f4:	53                   	push   %ebx
     8f5:	83 ec 70             	sub    $0x70,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     8f8:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     8ff:	8b 45 cc             	mov    -0x34(%ebp),%eax
     902:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     905:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     90c:	83 ec 08             	sub    $0x8,%esp
     90f:	6a 00                	push   $0x0
     911:	ff 75 0c             	pushl  0xc(%ebp)
     914:	e8 f2 f9 ff ff       	call   30b <open>
     919:	83 c4 10             	add    $0x10,%esp
     91c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     91f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     923:	79 2e                	jns    953 <APLoadBitmap+0x63>
    {
        printf(1, "Cannot open %s\n", filename);
     925:	83 ec 04             	sub    $0x4,%esp
     928:	ff 75 0c             	pushl  0xc(%ebp)
     92b:	68 dc 1e 00 00       	push   $0x1edc
     930:	6a 01                	push   $0x1
     932:	e8 33 fb ff ff       	call   46a <printf>
     937:	83 c4 10             	add    $0x10,%esp
        return bmp;
     93a:	8b 45 08             	mov    0x8(%ebp),%eax
     93d:	8b 55 c8             	mov    -0x38(%ebp),%edx
     940:	89 10                	mov    %edx,(%eax)
     942:	8b 55 cc             	mov    -0x34(%ebp),%edx
     945:	89 50 04             	mov    %edx,0x4(%eax)
     948:	8b 55 d0             	mov    -0x30(%ebp),%edx
     94b:	89 50 08             	mov    %edx,0x8(%eax)
     94e:	e9 1b 02 00 00       	jmp    b6e <APLoadBitmap+0x27e>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     953:	83 ec 04             	sub    $0x4,%esp
     956:	6a 10                	push   $0x10
     958:	8d 45 b8             	lea    -0x48(%ebp),%eax
     95b:	50                   	push   %eax
     95c:	ff 75 ec             	pushl  -0x14(%ebp)
     95f:	e8 7f f9 ff ff       	call   2e3 <read>
     964:	83 c4 10             	add    $0x10,%esp
    printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
     967:	0f b7 45 c2          	movzwl -0x3e(%ebp),%eax
     96b:	0f b7 f0             	movzwl %ax,%esi
     96e:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
     972:	0f b7 d8             	movzwl %ax,%ebx
     975:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
     978:	8b 55 bc             	mov    -0x44(%ebp),%edx
     97b:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
     97f:	0f b7 c0             	movzwl %ax,%eax
     982:	83 ec 04             	sub    $0x4,%esp
     985:	56                   	push   %esi
     986:	53                   	push   %ebx
     987:	51                   	push   %ecx
     988:	52                   	push   %edx
     989:	50                   	push   %eax
     98a:	68 ec 1e 00 00       	push   $0x1eec
     98f:	6a 01                	push   $0x1
     991:	e8 d4 fa ff ff       	call   46a <printf>
     996:	83 c4 20             	add    $0x20,%esp
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     999:	83 ec 04             	sub    $0x4,%esp
     99c:	6a 28                	push   $0x28
     99e:	8d 45 90             	lea    -0x70(%ebp),%eax
     9a1:	50                   	push   %eax
     9a2:	ff 75 ec             	pushl  -0x14(%ebp)
     9a5:	e8 39 f9 ff ff       	call   2e3 <read>
     9aa:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     9ad:	8b 45 94             	mov    -0x6c(%ebp),%eax
     9b0:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     9b3:	8b 45 98             	mov    -0x68(%ebp),%eax
     9b6:	89 45 cc             	mov    %eax,-0x34(%ebp)
    printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
     9b9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9bc:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9bf:	52                   	push   %edx
     9c0:	50                   	push   %eax
     9c1:	68 fc 1e 00 00       	push   $0x1efc
     9c6:	6a 01                	push   $0x1
     9c8:	e8 9d fa ff ff       	call   46a <printf>
     9cd:	83 c4 10             	add    $0x10,%esp
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     9d0:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9d3:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9d6:	0f af d0             	imul   %eax,%edx
     9d9:	89 d0                	mov    %edx,%eax
     9db:	01 c0                	add    %eax,%eax
     9dd:	01 d0                	add    %edx,%eax
     9df:	83 ec 0c             	sub    $0xc,%esp
     9e2:	50                   	push   %eax
     9e3:	e8 55 fd ff ff       	call   73d <malloc>
     9e8:	83 c4 10             	add    $0x10,%esp
     9eb:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9ee:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     9f2:	0f b7 c0             	movzwl %ax,%eax
     9f5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9f8:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9fe:	0f af c2             	imul   %edx,%eax
     a01:	83 c0 1f             	add    $0x1f,%eax
     a04:	c1 e8 05             	shr    $0x5,%eax
     a07:	c1 e0 02             	shl    $0x2,%eax
     a0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     a0d:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a10:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a13:	0f af c2             	imul   %edx,%eax
     a16:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     a19:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a1c:	83 ec 0c             	sub    $0xc,%esp
     a1f:	50                   	push   %eax
     a20:	e8 18 fd ff ff       	call   73d <malloc>
     a25:	83 c4 10             	add    $0x10,%esp
     a28:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a2b:	83 ec 04             	sub    $0x4,%esp
     a2e:	ff 75 e0             	pushl  -0x20(%ebp)
     a31:	ff 75 dc             	pushl  -0x24(%ebp)
     a34:	ff 75 ec             	pushl  -0x14(%ebp)
     a37:	e8 a7 f8 ff ff       	call   2e3 <read>
     a3c:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a3f:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     a43:	66 c1 e8 03          	shr    $0x3,%ax
     a47:	0f b7 c0             	movzwl %ax,%eax
     a4a:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a4d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a54:	e9 e5 00 00 00       	jmp    b3e <APLoadBitmap+0x24e>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a59:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a5f:	29 c2                	sub    %eax,%edx
     a61:	89 d0                	mov    %edx,%eax
     a63:	8d 50 ff             	lea    -0x1(%eax),%edx
     a66:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a69:	0f af c2             	imul   %edx,%eax
     a6c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a6f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a76:	e9 b1 00 00 00       	jmp    b2c <APLoadBitmap+0x23c>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a7b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a7e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a81:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a84:	01 c8                	add    %ecx,%eax
     a86:	89 c1                	mov    %eax,%ecx
     a88:	89 c8                	mov    %ecx,%eax
     a8a:	01 c0                	add    %eax,%eax
     a8c:	01 c8                	add    %ecx,%eax
     a8e:	01 c2                	add    %eax,%edx
     a90:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a93:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a97:	89 c1                	mov    %eax,%ecx
     a99:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a9c:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     aa0:	01 c1                	add    %eax,%ecx
     aa2:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aa5:	01 c8                	add    %ecx,%eax
     aa7:	8d 48 ff             	lea    -0x1(%eax),%ecx
     aaa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     aad:	01 c8                	add    %ecx,%eax
     aaf:	0f b6 00             	movzbl (%eax),%eax
     ab2:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     ab5:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ab8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     abb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     abe:	01 c8                	add    %ecx,%eax
     ac0:	89 c1                	mov    %eax,%ecx
     ac2:	89 c8                	mov    %ecx,%eax
     ac4:	01 c0                	add    %eax,%eax
     ac6:	01 c8                	add    %ecx,%eax
     ac8:	01 c2                	add    %eax,%edx
     aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     acd:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ad1:	89 c1                	mov    %eax,%ecx
     ad3:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ad6:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ada:	01 c1                	add    %eax,%ecx
     adc:	8b 45 d8             	mov    -0x28(%ebp),%eax
     adf:	01 c8                	add    %ecx,%eax
     ae1:	8d 48 fe             	lea    -0x2(%eax),%ecx
     ae4:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ae7:	01 c8                	add    %ecx,%eax
     ae9:	0f b6 00             	movzbl (%eax),%eax
     aec:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     aef:	8b 55 d0             	mov    -0x30(%ebp),%edx
     af2:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     af5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     af8:	01 c8                	add    %ecx,%eax
     afa:	89 c1                	mov    %eax,%ecx
     afc:	89 c8                	mov    %ecx,%eax
     afe:	01 c0                	add    %eax,%eax
     b00:	01 c8                	add    %ecx,%eax
     b02:	01 c2                	add    %eax,%edx
     b04:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b07:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b0b:	89 c1                	mov    %eax,%ecx
     b0d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b10:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b14:	01 c1                	add    %eax,%ecx
     b16:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b19:	01 c8                	add    %ecx,%eax
     b1b:	8d 48 fd             	lea    -0x3(%eax),%ecx
     b1e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b21:	01 c8                	add    %ecx,%eax
     b23:	0f b6 00             	movzbl (%eax),%eax
     b26:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     b28:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b2c:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b32:	39 c2                	cmp    %eax,%edx
     b34:	0f 87 41 ff ff ff    	ja     a7b <APLoadBitmap+0x18b>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b3a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b3e:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b41:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b44:	39 c2                	cmp    %eax,%edx
     b46:	0f 87 0d ff ff ff    	ja     a59 <APLoadBitmap+0x169>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b4c:	83 ec 0c             	sub    $0xc,%esp
     b4f:	ff 75 ec             	pushl  -0x14(%ebp)
     b52:	e8 9c f7 ff ff       	call   2f3 <close>
     b57:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b5a:	8b 45 08             	mov    0x8(%ebp),%eax
     b5d:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b60:	89 10                	mov    %edx,(%eax)
     b62:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b65:	89 50 04             	mov    %edx,0x4(%eax)
     b68:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b6b:	89 50 08             	mov    %edx,0x8(%eax)
}
     b6e:	8b 45 08             	mov    0x8(%ebp),%eax
     b71:	8d 65 f8             	lea    -0x8(%ebp),%esp
     b74:	5b                   	pop    %ebx
     b75:	5e                   	pop    %esi
     b76:	5d                   	pop    %ebp
     b77:	c2 04 00             	ret    $0x4

00000b7a <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b7a:	55                   	push   %ebp
     b7b:	89 e5                	mov    %esp,%ebp
     b7d:	53                   	push   %ebx
     b7e:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b81:	83 ec 0c             	sub    $0xc,%esp
     b84:	6a 1c                	push   $0x1c
     b86:	e8 b2 fb ff ff       	call   73d <malloc>
     b8b:	83 c4 10             	add    $0x10,%esp
     b8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b91:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b94:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b9b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b9e:	8d 45 d8             	lea    -0x28(%ebp),%eax
     ba1:	6a 0c                	push   $0xc
     ba3:	6a 0c                	push   $0xc
     ba5:	6a 0c                	push   $0xc
     ba7:	50                   	push   %eax
     ba8:	e8 73 fc ff ff       	call   820 <RGB>
     bad:	83 c4 0c             	add    $0xc,%esp
     bb0:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     bb4:	66 89 43 13          	mov    %ax,0x13(%ebx)
     bb8:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     bbc:	88 43 15             	mov    %al,0x15(%ebx)
     bbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc2:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bc5:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     bc9:	66 89 48 10          	mov    %cx,0x10(%eax)
     bcd:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     bd1:	88 50 12             	mov    %dl,0x12(%eax)
     bd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd7:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bda:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     bde:	66 89 48 08          	mov    %cx,0x8(%eax)
     be2:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     be6:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     be9:	8b 45 08             	mov    0x8(%ebp),%eax
     bec:	89 c2                	mov    %eax,%edx
     bee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bf1:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     bf3:	8b 45 0c             	mov    0xc(%ebp),%eax
     bf6:	89 c2                	mov    %eax,%edx
     bf8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bfb:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bfe:	8b 55 10             	mov    0x10(%ebp),%edx
     c01:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c04:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "%d %d\n", hdc->size.cx, hdc->size.cy);
    return hdc;
     c07:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c0d:	c9                   	leave  
     c0e:	c3                   	ret    

00000c0f <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     c0f:	55                   	push   %ebp
     c10:	89 e5                	mov    %esp,%ebp
     c12:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     c15:	8b 45 0c             	mov    0xc(%ebp),%eax
     c18:	8b 50 08             	mov    0x8(%eax),%edx
     c1b:	89 55 f8             	mov    %edx,-0x8(%ebp)
     c1e:	8b 40 0c             	mov    0xc(%eax),%eax
     c21:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     c24:	8b 45 0c             	mov    0xc(%ebp),%eax
     c27:	8b 55 10             	mov    0x10(%ebp),%edx
     c2a:	89 50 08             	mov    %edx,0x8(%eax)
     c2d:	8b 55 14             	mov    0x14(%ebp),%edx
     c30:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c33:	8b 45 08             	mov    0x8(%ebp),%eax
     c36:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c39:	89 10                	mov    %edx,(%eax)
     c3b:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c3e:	89 50 04             	mov    %edx,0x4(%eax)
}
     c41:	8b 45 08             	mov    0x8(%ebp),%eax
     c44:	c9                   	leave  
     c45:	c2 04 00             	ret    $0x4

00000c48 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c48:	55                   	push   %ebp
     c49:	89 e5                	mov    %esp,%ebp
     c4b:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c4e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c51:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c55:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c59:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c5d:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c60:	8b 45 0c             	mov    0xc(%ebp),%eax
     c63:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c67:	66 89 50 10          	mov    %dx,0x10(%eax)
     c6b:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c6f:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c72:	8b 45 08             	mov    0x8(%ebp),%eax
     c75:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c79:	66 89 10             	mov    %dx,(%eax)
     c7c:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c80:	88 50 02             	mov    %dl,0x2(%eax)
}
     c83:	8b 45 08             	mov    0x8(%ebp),%eax
     c86:	c9                   	leave  
     c87:	c2 04 00             	ret    $0x4

00000c8a <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c8a:	55                   	push   %ebp
     c8b:	89 e5                	mov    %esp,%ebp
     c8d:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c90:	8b 45 08             	mov    0x8(%ebp),%eax
     c93:	8b 40 0c             	mov    0xc(%eax),%eax
     c96:	89 c2                	mov    %eax,%edx
     c98:	c1 ea 1f             	shr    $0x1f,%edx
     c9b:	01 d0                	add    %edx,%eax
     c9d:	d1 f8                	sar    %eax
     c9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     ca2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca5:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     ca9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     cac:	8b 45 10             	mov    0x10(%ebp),%eax
     caf:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cb2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     cb5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     cb9:	0f 89 98 00 00 00    	jns    d57 <APDrawPoint+0xcd>
        i = 0;
     cbf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     cc6:	e9 8c 00 00 00       	jmp    d57 <APDrawPoint+0xcd>
    {
        j = x - off;
     ccb:	8b 45 0c             	mov    0xc(%ebp),%eax
     cce:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cd1:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     cd4:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     cd8:	79 69                	jns    d43 <APDrawPoint+0xb9>
            j = 0;
     cda:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     ce1:	eb 60                	jmp    d43 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     ce3:	ff 75 fc             	pushl  -0x4(%ebp)
     ce6:	ff 75 f8             	pushl  -0x8(%ebp)
     ce9:	ff 75 08             	pushl  0x8(%ebp)
     cec:	e8 ad fb ff ff       	call   89e <APGetIndex>
     cf1:	83 c4 0c             	add    $0xc,%esp
     cf4:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     cf7:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cfb:	74 55                	je     d52 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cfd:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d01:	74 67                	je     d6a <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d03:	ff 75 10             	pushl  0x10(%ebp)
     d06:	ff 75 0c             	pushl  0xc(%ebp)
     d09:	ff 75 fc             	pushl  -0x4(%ebp)
     d0c:	ff 75 f8             	pushl  -0x8(%ebp)
     d0f:	e8 51 fb ff ff       	call   865 <distance_2>
     d14:	83 c4 10             	add    $0x10,%esp
     d17:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d1a:	7f 23                	jg     d3f <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d1c:	8b 45 08             	mov    0x8(%ebp),%eax
     d1f:	8b 48 18             	mov    0x18(%eax),%ecx
     d22:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d25:	89 d0                	mov    %edx,%eax
     d27:	01 c0                	add    %eax,%eax
     d29:	01 d0                	add    %edx,%eax
     d2b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d2e:	8b 45 08             	mov    0x8(%ebp),%eax
     d31:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d35:	66 89 0a             	mov    %cx,(%edx)
     d38:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d3c:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d3f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d43:	8b 55 0c             	mov    0xc(%ebp),%edx
     d46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d49:	01 d0                	add    %edx,%eax
     d4b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d4e:	7d 93                	jge    ce3 <APDrawPoint+0x59>
     d50:	eb 01                	jmp    d53 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d52:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d53:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d57:	8b 55 10             	mov    0x10(%ebp),%edx
     d5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d5d:	01 d0                	add    %edx,%eax
     d5f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d62:	0f 8d 63 ff ff ff    	jge    ccb <APDrawPoint+0x41>
     d68:	eb 01                	jmp    d6b <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d6a:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d6b:	c9                   	leave  
     d6c:	c3                   	ret    

00000d6d <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d6d:	55                   	push   %ebp
     d6e:	89 e5                	mov    %esp,%ebp
     d70:	53                   	push   %ebx
     d71:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d74:	8b 45 0c             	mov    0xc(%ebp),%eax
     d77:	3b 45 14             	cmp    0x14(%ebp),%eax
     d7a:	0f 85 80 00 00 00    	jne    e00 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d80:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d84:	0f 88 9d 02 00 00    	js     1027 <APDrawLine+0x2ba>
     d8a:	8b 45 08             	mov    0x8(%ebp),%eax
     d8d:	8b 00                	mov    (%eax),%eax
     d8f:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d92:	0f 8e 8f 02 00 00    	jle    1027 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d98:	8b 45 10             	mov    0x10(%ebp),%eax
     d9b:	3b 45 18             	cmp    0x18(%ebp),%eax
     d9e:	7e 12                	jle    db2 <APDrawLine+0x45>
        {
            int tmp = y2;
     da0:	8b 45 18             	mov    0x18(%ebp),%eax
     da3:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     da6:	8b 45 10             	mov    0x10(%ebp),%eax
     da9:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     dac:	8b 45 dc             	mov    -0x24(%ebp),%eax
     daf:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     db2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     db6:	79 07                	jns    dbf <APDrawLine+0x52>
     db8:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     dbf:	8b 45 08             	mov    0x8(%ebp),%eax
     dc2:	8b 40 04             	mov    0x4(%eax),%eax
     dc5:	3b 45 18             	cmp    0x18(%ebp),%eax
     dc8:	7d 0c                	jge    dd6 <APDrawLine+0x69>
     dca:	8b 45 08             	mov    0x8(%ebp),%eax
     dcd:	8b 40 04             	mov    0x4(%eax),%eax
     dd0:	83 e8 01             	sub    $0x1,%eax
     dd3:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     dd6:	8b 45 10             	mov    0x10(%ebp),%eax
     dd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ddc:	eb 15                	jmp    df3 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     dde:	ff 75 f4             	pushl  -0xc(%ebp)
     de1:	ff 75 0c             	pushl  0xc(%ebp)
     de4:	ff 75 08             	pushl  0x8(%ebp)
     de7:	e8 9e fe ff ff       	call   c8a <APDrawPoint>
     dec:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     def:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     df3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df6:	3b 45 18             	cmp    0x18(%ebp),%eax
     df9:	7e e3                	jle    dde <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     dfb:	e9 2b 02 00 00       	jmp    102b <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e00:	8b 45 10             	mov    0x10(%ebp),%eax
     e03:	3b 45 18             	cmp    0x18(%ebp),%eax
     e06:	75 7f                	jne    e87 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e08:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e0c:	0f 88 18 02 00 00    	js     102a <APDrawLine+0x2bd>
     e12:	8b 45 08             	mov    0x8(%ebp),%eax
     e15:	8b 40 04             	mov    0x4(%eax),%eax
     e18:	3b 45 10             	cmp    0x10(%ebp),%eax
     e1b:	0f 8e 09 02 00 00    	jle    102a <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e21:	8b 45 0c             	mov    0xc(%ebp),%eax
     e24:	3b 45 14             	cmp    0x14(%ebp),%eax
     e27:	7e 12                	jle    e3b <APDrawLine+0xce>
        {
            int tmp = x2;
     e29:	8b 45 14             	mov    0x14(%ebp),%eax
     e2c:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e2f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e32:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e35:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e38:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e3b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e3f:	79 07                	jns    e48 <APDrawLine+0xdb>
     e41:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e48:	8b 45 08             	mov    0x8(%ebp),%eax
     e4b:	8b 00                	mov    (%eax),%eax
     e4d:	3b 45 14             	cmp    0x14(%ebp),%eax
     e50:	7d 0b                	jge    e5d <APDrawLine+0xf0>
     e52:	8b 45 08             	mov    0x8(%ebp),%eax
     e55:	8b 00                	mov    (%eax),%eax
     e57:	83 e8 01             	sub    $0x1,%eax
     e5a:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e5d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e60:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e63:	eb 15                	jmp    e7a <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e65:	ff 75 10             	pushl  0x10(%ebp)
     e68:	ff 75 f0             	pushl  -0x10(%ebp)
     e6b:	ff 75 08             	pushl  0x8(%ebp)
     e6e:	e8 17 fe ff ff       	call   c8a <APDrawPoint>
     e73:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e76:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e7d:	3b 45 14             	cmp    0x14(%ebp),%eax
     e80:	7e e3                	jle    e65 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e82:	e9 a4 01 00 00       	jmp    102b <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e87:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e8e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e95:	8b 45 0c             	mov    0xc(%ebp),%eax
     e98:	2b 45 14             	sub    0x14(%ebp),%eax
     e9b:	50                   	push   %eax
     e9c:	e8 ed f9 ff ff       	call   88e <abs_int>
     ea1:	83 c4 04             	add    $0x4,%esp
     ea4:	89 c3                	mov    %eax,%ebx
     ea6:	8b 45 10             	mov    0x10(%ebp),%eax
     ea9:	2b 45 18             	sub    0x18(%ebp),%eax
     eac:	50                   	push   %eax
     ead:	e8 dc f9 ff ff       	call   88e <abs_int>
     eb2:	83 c4 04             	add    $0x4,%esp
     eb5:	39 c3                	cmp    %eax,%ebx
     eb7:	0f 8e b5 00 00 00    	jle    f72 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     ebd:	8b 45 10             	mov    0x10(%ebp),%eax
     ec0:	2b 45 18             	sub    0x18(%ebp),%eax
     ec3:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ec6:	db 45 b0             	fildl  -0x50(%ebp)
     ec9:	8b 45 0c             	mov    0xc(%ebp),%eax
     ecc:	2b 45 14             	sub    0x14(%ebp),%eax
     ecf:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ed2:	db 45 b0             	fildl  -0x50(%ebp)
     ed5:	de f9                	fdivrp %st,%st(1)
     ed7:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     eda:	8b 45 14             	mov    0x14(%ebp),%eax
     edd:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ee0:	7e 0e                	jle    ef0 <APDrawLine+0x183>
        {
            s = x1;
     ee2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ee5:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     ee8:	8b 45 14             	mov    0x14(%ebp),%eax
     eeb:	89 45 e8             	mov    %eax,-0x18(%ebp)
     eee:	eb 0c                	jmp    efc <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ef0:	8b 45 14             	mov    0x14(%ebp),%eax
     ef3:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     ef6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef9:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     efc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f00:	79 07                	jns    f09 <APDrawLine+0x19c>
     f02:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f09:	8b 45 08             	mov    0x8(%ebp),%eax
     f0c:	8b 00                	mov    (%eax),%eax
     f0e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f11:	7f 0b                	jg     f1e <APDrawLine+0x1b1>
     f13:	8b 45 08             	mov    0x8(%ebp),%eax
     f16:	8b 00                	mov    (%eax),%eax
     f18:	83 e8 01             	sub    $0x1,%eax
     f1b:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f21:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f24:	eb 3f                	jmp    f65 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f29:	2b 45 0c             	sub    0xc(%ebp),%eax
     f2c:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f2f:	db 45 b0             	fildl  -0x50(%ebp)
     f32:	dc 4d d0             	fmull  -0x30(%ebp)
     f35:	db 45 10             	fildl  0x10(%ebp)
     f38:	de c1                	faddp  %st,%st(1)
     f3a:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f3d:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f41:	b4 0c                	mov    $0xc,%ah
     f43:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f47:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f4a:	db 5d cc             	fistpl -0x34(%ebp)
     f4d:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f50:	ff 75 cc             	pushl  -0x34(%ebp)
     f53:	ff 75 e4             	pushl  -0x1c(%ebp)
     f56:	ff 75 08             	pushl  0x8(%ebp)
     f59:	e8 2c fd ff ff       	call   c8a <APDrawPoint>
     f5e:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f61:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f65:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f68:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f6b:	7e b9                	jle    f26 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f6d:	e9 b9 00 00 00       	jmp    102b <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f72:	8b 45 0c             	mov    0xc(%ebp),%eax
     f75:	2b 45 14             	sub    0x14(%ebp),%eax
     f78:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f7b:	db 45 b0             	fildl  -0x50(%ebp)
     f7e:	8b 45 10             	mov    0x10(%ebp),%eax
     f81:	2b 45 18             	sub    0x18(%ebp),%eax
     f84:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f87:	db 45 b0             	fildl  -0x50(%ebp)
     f8a:	de f9                	fdivrp %st,%st(1)
     f8c:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f8f:	8b 45 10             	mov    0x10(%ebp),%eax
     f92:	3b 45 18             	cmp    0x18(%ebp),%eax
     f95:	7e 0e                	jle    fa5 <APDrawLine+0x238>
    {
        s = y2;
     f97:	8b 45 18             	mov    0x18(%ebp),%eax
     f9a:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f9d:	8b 45 10             	mov    0x10(%ebp),%eax
     fa0:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fa3:	eb 0c                	jmp    fb1 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     fa5:	8b 45 10             	mov    0x10(%ebp),%eax
     fa8:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     fab:	8b 45 18             	mov    0x18(%ebp),%eax
     fae:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     fb1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fb5:	79 07                	jns    fbe <APDrawLine+0x251>
     fb7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     fbe:	8b 45 08             	mov    0x8(%ebp),%eax
     fc1:	8b 40 04             	mov    0x4(%eax),%eax
     fc4:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fc7:	7f 0c                	jg     fd5 <APDrawLine+0x268>
     fc9:	8b 45 08             	mov    0x8(%ebp),%eax
     fcc:	8b 40 04             	mov    0x4(%eax),%eax
     fcf:	83 e8 01             	sub    $0x1,%eax
     fd2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     fd5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fd8:	89 45 e0             	mov    %eax,-0x20(%ebp)
     fdb:	eb 3f                	jmp    101c <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     fdd:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fe0:	2b 45 10             	sub    0x10(%ebp),%eax
     fe3:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fe6:	db 45 b0             	fildl  -0x50(%ebp)
     fe9:	dc 4d c0             	fmull  -0x40(%ebp)
     fec:	db 45 0c             	fildl  0xc(%ebp)
     fef:	de c1                	faddp  %st,%st(1)
     ff1:	d9 7d b6             	fnstcw -0x4a(%ebp)
     ff4:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     ff8:	b4 0c                	mov    $0xc,%ah
     ffa:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     ffe:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1001:	db 5d bc             	fistpl -0x44(%ebp)
    1004:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1007:	ff 75 e0             	pushl  -0x20(%ebp)
    100a:	ff 75 bc             	pushl  -0x44(%ebp)
    100d:	ff 75 08             	pushl  0x8(%ebp)
    1010:	e8 75 fc ff ff       	call   c8a <APDrawPoint>
    1015:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1018:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    101c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    101f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1022:	7e b9                	jle    fdd <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1024:	90                   	nop
    1025:	eb 04                	jmp    102b <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1027:	90                   	nop
    1028:	eb 01                	jmp    102b <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    102a:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    102b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    102e:	c9                   	leave  
    102f:	c3                   	ret    

00001030 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	53                   	push   %ebx
    1034:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1037:	8b 55 10             	mov    0x10(%ebp),%edx
    103a:	8b 45 18             	mov    0x18(%ebp),%eax
    103d:	01 d0                	add    %edx,%eax
    103f:	83 e8 01             	sub    $0x1,%eax
    1042:	83 ec 04             	sub    $0x4,%esp
    1045:	50                   	push   %eax
    1046:	ff 75 0c             	pushl  0xc(%ebp)
    1049:	ff 75 10             	pushl  0x10(%ebp)
    104c:	ff 75 0c             	pushl  0xc(%ebp)
    104f:	ff 75 08             	pushl  0x8(%ebp)
    1052:	e8 16 fd ff ff       	call   d6d <APDrawLine>
    1057:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    105a:	8b 55 0c             	mov    0xc(%ebp),%edx
    105d:	8b 45 14             	mov    0x14(%ebp),%eax
    1060:	01 d0                	add    %edx,%eax
    1062:	83 e8 01             	sub    $0x1,%eax
    1065:	83 ec 04             	sub    $0x4,%esp
    1068:	ff 75 10             	pushl  0x10(%ebp)
    106b:	50                   	push   %eax
    106c:	ff 75 10             	pushl  0x10(%ebp)
    106f:	ff 75 0c             	pushl  0xc(%ebp)
    1072:	ff 75 08             	pushl  0x8(%ebp)
    1075:	e8 f3 fc ff ff       	call   d6d <APDrawLine>
    107a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    107d:	8b 55 10             	mov    0x10(%ebp),%edx
    1080:	8b 45 18             	mov    0x18(%ebp),%eax
    1083:	01 d0                	add    %edx,%eax
    1085:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1088:	8b 55 0c             	mov    0xc(%ebp),%edx
    108b:	8b 45 14             	mov    0x14(%ebp),%eax
    108e:	01 d0                	add    %edx,%eax
    1090:	8d 50 ff             	lea    -0x1(%eax),%edx
    1093:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1096:	8b 45 14             	mov    0x14(%ebp),%eax
    1099:	01 d8                	add    %ebx,%eax
    109b:	83 e8 01             	sub    $0x1,%eax
    109e:	83 ec 04             	sub    $0x4,%esp
    10a1:	51                   	push   %ecx
    10a2:	52                   	push   %edx
    10a3:	ff 75 10             	pushl  0x10(%ebp)
    10a6:	50                   	push   %eax
    10a7:	ff 75 08             	pushl  0x8(%ebp)
    10aa:	e8 be fc ff ff       	call   d6d <APDrawLine>
    10af:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10b2:	8b 55 10             	mov    0x10(%ebp),%edx
    10b5:	8b 45 18             	mov    0x18(%ebp),%eax
    10b8:	01 d0                	add    %edx,%eax
    10ba:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10bd:	8b 55 0c             	mov    0xc(%ebp),%edx
    10c0:	8b 45 14             	mov    0x14(%ebp),%eax
    10c3:	01 d0                	add    %edx,%eax
    10c5:	8d 50 ff             	lea    -0x1(%eax),%edx
    10c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    10cb:	8b 45 18             	mov    0x18(%ebp),%eax
    10ce:	01 d8                	add    %ebx,%eax
    10d0:	83 e8 01             	sub    $0x1,%eax
    10d3:	83 ec 04             	sub    $0x4,%esp
    10d6:	51                   	push   %ecx
    10d7:	52                   	push   %edx
    10d8:	50                   	push   %eax
    10d9:	ff 75 0c             	pushl  0xc(%ebp)
    10dc:	ff 75 08             	pushl  0x8(%ebp)
    10df:	e8 89 fc ff ff       	call   d6d <APDrawLine>
    10e4:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10e7:	8b 55 0c             	mov    0xc(%ebp),%edx
    10ea:	8b 45 14             	mov    0x14(%ebp),%eax
    10ed:	01 d0                	add    %edx,%eax
    10ef:	8d 50 ff             	lea    -0x1(%eax),%edx
    10f2:	8b 45 08             	mov    0x8(%ebp),%eax
    10f5:	8b 40 0c             	mov    0xc(%eax),%eax
    10f8:	89 c1                	mov    %eax,%ecx
    10fa:	c1 e9 1f             	shr    $0x1f,%ecx
    10fd:	01 c8                	add    %ecx,%eax
    10ff:	d1 f8                	sar    %eax
    1101:	29 c2                	sub    %eax,%edx
    1103:	89 d0                	mov    %edx,%eax
    1105:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1108:	8b 55 10             	mov    0x10(%ebp),%edx
    110b:	8b 45 18             	mov    0x18(%ebp),%eax
    110e:	01 d0                	add    %edx,%eax
    1110:	8d 50 ff             	lea    -0x1(%eax),%edx
    1113:	8b 45 08             	mov    0x8(%ebp),%eax
    1116:	8b 40 0c             	mov    0xc(%eax),%eax
    1119:	89 c1                	mov    %eax,%ecx
    111b:	c1 e9 1f             	shr    $0x1f,%ecx
    111e:	01 c8                	add    %ecx,%eax
    1120:	d1 f8                	sar    %eax
    1122:	29 c2                	sub    %eax,%edx
    1124:	89 d0                	mov    %edx,%eax
    1126:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1129:	8b 45 08             	mov    0x8(%ebp),%eax
    112c:	8b 40 0c             	mov    0xc(%eax),%eax
    112f:	89 c2                	mov    %eax,%edx
    1131:	c1 ea 1f             	shr    $0x1f,%edx
    1134:	01 d0                	add    %edx,%eax
    1136:	d1 f8                	sar    %eax
    1138:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    113b:	8b 45 08             	mov    0x8(%ebp),%eax
    113e:	8b 40 0c             	mov    0xc(%eax),%eax
    1141:	89 c2                	mov    %eax,%edx
    1143:	c1 ea 1f             	shr    $0x1f,%edx
    1146:	01 d0                	add    %edx,%eax
    1148:	d1 f8                	sar    %eax
    114a:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    114d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1151:	0f 88 d8 00 00 00    	js     122f <APDrawRect+0x1ff>
    1157:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    115b:	0f 88 ce 00 00 00    	js     122f <APDrawRect+0x1ff>
    1161:	8b 45 08             	mov    0x8(%ebp),%eax
    1164:	8b 00                	mov    (%eax),%eax
    1166:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1169:	0f 8e c0 00 00 00    	jle    122f <APDrawRect+0x1ff>
    116f:	8b 45 08             	mov    0x8(%ebp),%eax
    1172:	8b 40 04             	mov    0x4(%eax),%eax
    1175:	3b 45 10             	cmp    0x10(%ebp),%eax
    1178:	0f 8e b1 00 00 00    	jle    122f <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    117e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1182:	79 07                	jns    118b <APDrawRect+0x15b>
    1184:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    118b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    118f:	79 07                	jns    1198 <APDrawRect+0x168>
    1191:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1198:	8b 45 08             	mov    0x8(%ebp),%eax
    119b:	8b 00                	mov    (%eax),%eax
    119d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11a0:	7f 0b                	jg     11ad <APDrawRect+0x17d>
    11a2:	8b 45 08             	mov    0x8(%ebp),%eax
    11a5:	8b 00                	mov    (%eax),%eax
    11a7:	83 e8 01             	sub    $0x1,%eax
    11aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    11ad:	8b 45 08             	mov    0x8(%ebp),%eax
    11b0:	8b 40 04             	mov    0x4(%eax),%eax
    11b3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11b6:	7f 0c                	jg     11c4 <APDrawRect+0x194>
    11b8:	8b 45 08             	mov    0x8(%ebp),%eax
    11bb:	8b 40 04             	mov    0x4(%eax),%eax
    11be:	83 e8 01             	sub    $0x1,%eax
    11c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    11c4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11cb:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ce:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11d1:	eb 52                	jmp    1225 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    11d3:	8b 45 10             	mov    0x10(%ebp),%eax
    11d6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11d9:	eb 3e                	jmp    1219 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    11db:	83 ec 04             	sub    $0x4,%esp
    11de:	ff 75 e8             	pushl  -0x18(%ebp)
    11e1:	ff 75 ec             	pushl  -0x14(%ebp)
    11e4:	ff 75 08             	pushl  0x8(%ebp)
    11e7:	e8 b2 f6 ff ff       	call   89e <APGetIndex>
    11ec:	83 c4 10             	add    $0x10,%esp
    11ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11f2:	8b 45 08             	mov    0x8(%ebp),%eax
    11f5:	8b 48 18             	mov    0x18(%eax),%ecx
    11f8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11fb:	89 d0                	mov    %edx,%eax
    11fd:	01 c0                	add    %eax,%eax
    11ff:	01 d0                	add    %edx,%eax
    1201:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1204:	8b 45 08             	mov    0x8(%ebp),%eax
    1207:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    120b:	66 89 0a             	mov    %cx,(%edx)
    120e:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1212:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1215:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1219:	8b 45 e8             	mov    -0x18(%ebp),%eax
    121c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    121f:	7e ba                	jle    11db <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1221:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1225:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1228:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    122b:	7e a6                	jle    11d3 <APDrawRect+0x1a3>
    122d:	eb 01                	jmp    1230 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    122f:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1230:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1233:	c9                   	leave  
    1234:	c3                   	ret    

00001235 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1235:	55                   	push   %ebp
    1236:	89 e5                	mov    %esp,%ebp
    1238:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    123b:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    123f:	0f 88 8e 01 00 00    	js     13d3 <APDcCopy+0x19e>
    1245:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1249:	0f 88 84 01 00 00    	js     13d3 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    124f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1252:	8b 45 20             	mov    0x20(%ebp),%eax
    1255:	01 d0                	add    %edx,%eax
    1257:	89 45 fc             	mov    %eax,-0x4(%ebp)
    125a:	8b 55 10             	mov    0x10(%ebp),%edx
    125d:	8b 45 24             	mov    0x24(%ebp),%eax
    1260:	01 d0                	add    %edx,%eax
    1262:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w, y_r = y + h;
    1265:	8b 55 18             	mov    0x18(%ebp),%edx
    1268:	8b 45 20             	mov    0x20(%ebp),%eax
    126b:	01 d0                	add    %edx,%eax
    126d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1270:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1273:	8b 45 24             	mov    0x24(%ebp),%eax
    1276:	01 d0                	add    %edx,%eax
    1278:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
    127b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    127f:	0f 88 51 01 00 00    	js     13d6 <APDcCopy+0x1a1>
    1285:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1289:	0f 88 47 01 00 00    	js     13d6 <APDcCopy+0x1a1>
    128f:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1293:	0f 88 3d 01 00 00    	js     13d6 <APDcCopy+0x1a1>
    1299:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    129d:	0f 88 33 01 00 00    	js     13d6 <APDcCopy+0x1a1>
    12a3:	8b 45 14             	mov    0x14(%ebp),%eax
    12a6:	8b 00                	mov    (%eax),%eax
    12a8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    12ab:	0f 8e 25 01 00 00    	jle    13d6 <APDcCopy+0x1a1>
    12b1:	8b 45 14             	mov    0x14(%ebp),%eax
    12b4:	8b 40 04             	mov    0x4(%eax),%eax
    12b7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12ba:	0f 8e 16 01 00 00    	jle    13d6 <APDcCopy+0x1a1>
        return;
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    12c0:	8b 45 08             	mov    0x8(%ebp),%eax
    12c3:	8b 00                	mov    (%eax),%eax
    12c5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    12c8:	7d 0b                	jge    12d5 <APDcCopy+0xa0>
    12ca:	8b 45 08             	mov    0x8(%ebp),%eax
    12cd:	8b 00                	mov    (%eax),%eax
    12cf:	83 e8 01             	sub    $0x1,%eax
    12d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    12d5:	8b 45 08             	mov    0x8(%ebp),%eax
    12d8:	8b 40 04             	mov    0x4(%eax),%eax
    12db:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12de:	7d 0c                	jge    12ec <APDcCopy+0xb7>
    12e0:	8b 45 08             	mov    0x8(%ebp),%eax
    12e3:	8b 40 04             	mov    0x4(%eax),%eax
    12e6:	83 e8 01             	sub    $0x1,%eax
    12e9:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    12ec:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12f3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j < wy_r - wy; j++)
    12fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1301:	e9 bc 00 00 00       	jmp    13c2 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1306:	8b 45 08             	mov    0x8(%ebp),%eax
    1309:	8b 00                	mov    (%eax),%eax
    130b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    130e:	8b 55 10             	mov    0x10(%ebp),%edx
    1311:	01 ca                	add    %ecx,%edx
    1313:	0f af d0             	imul   %eax,%edx
    1316:	8b 45 0c             	mov    0xc(%ebp),%eax
    1319:	01 d0                	add    %edx,%eax
    131b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    131e:	8b 45 14             	mov    0x14(%ebp),%eax
    1321:	8b 00                	mov    (%eax),%eax
    1323:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1326:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1329:	01 ca                	add    %ecx,%edx
    132b:	0f af d0             	imul   %eax,%edx
    132e:	8b 45 18             	mov    0x18(%ebp),%eax
    1331:	01 d0                	add    %edx,%eax
    1333:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i < wx_r - wx; i++)
    1336:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    133d:	eb 74                	jmp    13b3 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    133f:	8b 45 14             	mov    0x14(%ebp),%eax
    1342:	8b 50 18             	mov    0x18(%eax),%edx
    1345:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1348:	8b 45 f0             	mov    -0x10(%ebp),%eax
    134b:	01 c8                	add    %ecx,%eax
    134d:	89 c1                	mov    %eax,%ecx
    134f:	89 c8                	mov    %ecx,%eax
    1351:	01 c0                	add    %eax,%eax
    1353:	01 c8                	add    %ecx,%eax
    1355:	01 d0                	add    %edx,%eax
    1357:	0f b7 10             	movzwl (%eax),%edx
    135a:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    135e:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1362:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1365:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1369:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    136d:	38 c2                	cmp    %al,%dl
    136f:	75 18                	jne    1389 <APDcCopy+0x154>
    1371:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1375:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1379:	38 c2                	cmp    %al,%dl
    137b:	75 0c                	jne    1389 <APDcCopy+0x154>
    137d:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1381:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1385:	38 c2                	cmp    %al,%dl
    1387:	74 26                	je     13af <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1389:	8b 45 08             	mov    0x8(%ebp),%eax
    138c:	8b 50 18             	mov    0x18(%eax),%edx
    138f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1392:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1395:	01 c8                	add    %ecx,%eax
    1397:	89 c1                	mov    %eax,%ecx
    1399:	89 c8                	mov    %ecx,%eax
    139b:	01 c0                	add    %eax,%eax
    139d:	01 c8                	add    %ecx,%eax
    139f:	01 d0                	add    %edx,%eax
    13a1:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    13a5:	66 89 10             	mov    %dx,(%eax)
    13a8:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13ac:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i < wx_r - wx; i++)
    13af:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    13b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13b6:	2b 45 0c             	sub    0xc(%ebp),%eax
    13b9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    13bc:	7f 81                	jg     133f <APDcCopy+0x10a>
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    13be:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    13c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13c5:	2b 45 10             	sub    0x10(%ebp),%eax
    13c8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    13cb:	0f 8f 35 ff ff ff    	jg     1306 <APDcCopy+0xd1>
    13d1:	eb 04                	jmp    13d7 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    13d3:	90                   	nop
    13d4:	eb 01                	jmp    13d7 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w, y_r = y + h;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
        return;
    13d6:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    13d7:	c9                   	leave  
    13d8:	c3                   	ret    

000013d9 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    13d9:	55                   	push   %ebp
    13da:	89 e5                	mov    %esp,%ebp
    13dc:	83 ec 1c             	sub    $0x1c,%esp
    13df:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    13e2:	8b 55 10             	mov    0x10(%ebp),%edx
    13e5:	8b 45 14             	mov    0x14(%ebp),%eax
    13e8:	88 4d ec             	mov    %cl,-0x14(%ebp)
    13eb:	88 55 e8             	mov    %dl,-0x18(%ebp)
    13ee:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    13f1:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13f5:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13f8:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13fc:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13ff:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1403:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1406:	8b 45 08             	mov    0x8(%ebp),%eax
    1409:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    140d:	66 89 10             	mov    %dx,(%eax)
    1410:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1414:	88 50 02             	mov    %dl,0x2(%eax)
}
    1417:	8b 45 08             	mov    0x8(%ebp),%eax
    141a:	c9                   	leave  
    141b:	c2 04 00             	ret    $0x4

0000141e <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    141e:	55                   	push   %ebp
    141f:	89 e5                	mov    %esp,%ebp
    1421:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1424:	8b 45 08             	mov    0x8(%ebp),%eax
    1427:	8b 00                	mov    (%eax),%eax
    1429:	83 ec 08             	sub    $0x8,%esp
    142c:	8d 55 0c             	lea    0xc(%ebp),%edx
    142f:	52                   	push   %edx
    1430:	50                   	push   %eax
    1431:	e8 45 ef ff ff       	call   37b <sendMessage>
    1436:	83 c4 10             	add    $0x10,%esp
}
    1439:	90                   	nop
    143a:	c9                   	leave  
    143b:	c3                   	ret    

0000143c <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    143c:	55                   	push   %ebp
    143d:	89 e5                	mov    %esp,%ebp
    143f:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1442:	83 ec 0c             	sub    $0xc,%esp
    1445:	68 90 00 00 00       	push   $0x90
    144a:	e8 ee f2 ff ff       	call   73d <malloc>
    144f:	83 c4 10             	add    $0x10,%esp
    1452:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1455:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1459:	75 15                	jne    1470 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    145b:	83 ec 04             	sub    $0x4,%esp
    145e:	ff 75 08             	pushl  0x8(%ebp)
    1461:	68 20 1f 00 00       	push   $0x1f20
    1466:	6a 01                	push   $0x1
    1468:	e8 fd ef ff ff       	call   46a <printf>
    146d:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1470:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1473:	83 c0 7c             	add    $0x7c,%eax
    1476:	83 ec 08             	sub    $0x8,%esp
    1479:	ff 75 08             	pushl  0x8(%ebp)
    147c:	50                   	push   %eax
    147d:	e8 18 ec ff ff       	call   9a <strcpy>
    1482:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1485:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1488:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    148f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1492:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1499:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149c:	8b 40 34             	mov    0x34(%eax),%eax
    149f:	89 c2                	mov    %eax,%edx
    14a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a4:	8b 40 38             	mov    0x38(%eax),%eax
    14a7:	0f af d0             	imul   %eax,%edx
    14aa:	89 d0                	mov    %edx,%eax
    14ac:	01 c0                	add    %eax,%eax
    14ae:	01 d0                	add    %edx,%eax
    14b0:	83 ec 0c             	sub    $0xc,%esp
    14b3:	50                   	push   %eax
    14b4:	e8 84 f2 ff ff       	call   73d <malloc>
    14b9:	83 c4 10             	add    $0x10,%esp
    14bc:	89 c2                	mov    %eax,%edx
    14be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c1:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    14c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c7:	8b 40 4c             	mov    0x4c(%eax),%eax
    14ca:	85 c0                	test   %eax,%eax
    14cc:	75 15                	jne    14e3 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    14ce:	83 ec 04             	sub    $0x4,%esp
    14d1:	ff 75 08             	pushl  0x8(%ebp)
    14d4:	68 40 1f 00 00       	push   $0x1f40
    14d9:	6a 01                	push   $0x1
    14db:	e8 8a ef ff ff       	call   46a <printf>
    14e0:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e6:	8b 40 34             	mov    0x34(%eax),%eax
    14e9:	89 c2                	mov    %eax,%edx
    14eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ee:	8b 40 38             	mov    0x38(%eax),%eax
    14f1:	0f af d0             	imul   %eax,%edx
    14f4:	89 d0                	mov    %edx,%eax
    14f6:	01 c0                	add    %eax,%eax
    14f8:	01 c2                	add    %eax,%edx
    14fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14fd:	8b 40 4c             	mov    0x4c(%eax),%eax
    1500:	83 ec 04             	sub    $0x4,%esp
    1503:	52                   	push   %edx
    1504:	68 ff ff ff 00       	push   $0xffffff
    1509:	50                   	push   %eax
    150a:	e8 21 ec ff ff       	call   130 <memset>
    150f:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1512:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1515:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    151c:	e8 2a ee ff ff       	call   34b <getpid>
    1521:	89 c2                	mov    %eax,%edx
    1523:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1526:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1529:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152c:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1533:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1536:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    153d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1540:	8b 40 50             	mov    0x50(%eax),%eax
    1543:	89 c2                	mov    %eax,%edx
    1545:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1548:	8b 40 54             	mov    0x54(%eax),%eax
    154b:	0f af d0             	imul   %eax,%edx
    154e:	89 d0                	mov    %edx,%eax
    1550:	01 c0                	add    %eax,%eax
    1552:	01 d0                	add    %edx,%eax
    1554:	83 ec 0c             	sub    $0xc,%esp
    1557:	50                   	push   %eax
    1558:	e8 e0 f1 ff ff       	call   73d <malloc>
    155d:	83 c4 10             	add    $0x10,%esp
    1560:	89 c2                	mov    %eax,%edx
    1562:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1565:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    1568:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156b:	8b 40 68             	mov    0x68(%eax),%eax
    156e:	85 c0                	test   %eax,%eax
    1570:	75 15                	jne    1587 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1572:	83 ec 04             	sub    $0x4,%esp
    1575:	ff 75 08             	pushl  0x8(%ebp)
    1578:	68 64 1f 00 00       	push   $0x1f64
    157d:	6a 01                	push   $0x1
    157f:	e8 e6 ee ff ff       	call   46a <printf>
    1584:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1587:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158a:	8b 40 34             	mov    0x34(%eax),%eax
    158d:	89 c2                	mov    %eax,%edx
    158f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1592:	8b 40 38             	mov    0x38(%eax),%eax
    1595:	0f af d0             	imul   %eax,%edx
    1598:	89 d0                	mov    %edx,%eax
    159a:	01 c0                	add    %eax,%eax
    159c:	01 c2                	add    %eax,%edx
    159e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a1:	8b 40 4c             	mov    0x4c(%eax),%eax
    15a4:	83 ec 04             	sub    $0x4,%esp
    15a7:	52                   	push   %edx
    15a8:	68 ff 00 00 00       	push   $0xff
    15ad:	50                   	push   %eax
    15ae:	e8 7d eb ff ff       	call   130 <memset>
    15b3:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    15b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b9:	8b 55 0c             	mov    0xc(%ebp),%edx
    15bc:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    15bf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    15c3:	74 35                	je     15fa <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    15c5:	8b 45 10             	mov    0x10(%ebp),%eax
    15c8:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    15ce:	83 ec 0c             	sub    $0xc,%esp
    15d1:	50                   	push   %eax
    15d2:	e8 66 f1 ff ff       	call   73d <malloc>
    15d7:	83 c4 10             	add    $0x10,%esp
    15da:	89 c2                	mov    %eax,%edx
    15dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15df:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    15e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e5:	8b 55 10             	mov    0x10(%ebp),%edx
    15e8:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    15eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ee:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    15f5:	e9 8d 00 00 00       	jmp    1687 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15fd:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1604:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1607:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    160e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1611:	8b 40 18             	mov    0x18(%eax),%eax
    1614:	89 c2                	mov    %eax,%edx
    1616:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1619:	8b 40 1c             	mov    0x1c(%eax),%eax
    161c:	0f af d0             	imul   %eax,%edx
    161f:	89 d0                	mov    %edx,%eax
    1621:	01 c0                	add    %eax,%eax
    1623:	01 d0                	add    %edx,%eax
    1625:	83 ec 0c             	sub    $0xc,%esp
    1628:	50                   	push   %eax
    1629:	e8 0f f1 ff ff       	call   73d <malloc>
    162e:	83 c4 10             	add    $0x10,%esp
    1631:	89 c2                	mov    %eax,%edx
    1633:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1636:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    1639:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163c:	8b 40 30             	mov    0x30(%eax),%eax
    163f:	85 c0                	test   %eax,%eax
    1641:	75 15                	jne    1658 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1643:	83 ec 04             	sub    $0x4,%esp
    1646:	ff 75 08             	pushl  0x8(%ebp)
    1649:	68 8c 1f 00 00       	push   $0x1f8c
    164e:	6a 01                	push   $0x1
    1650:	e8 15 ee ff ff       	call   46a <printf>
    1655:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1658:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165b:	8b 40 18             	mov    0x18(%eax),%eax
    165e:	89 c2                	mov    %eax,%edx
    1660:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1663:	8b 40 1c             	mov    0x1c(%eax),%eax
    1666:	0f af d0             	imul   %eax,%edx
    1669:	89 d0                	mov    %edx,%eax
    166b:	01 c0                	add    %eax,%eax
    166d:	01 c2                	add    %eax,%edx
    166f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1672:	8b 40 30             	mov    0x30(%eax),%eax
    1675:	83 ec 04             	sub    $0x4,%esp
    1678:	52                   	push   %edx
    1679:	68 ff ff ff 00       	push   $0xffffff
    167e:	50                   	push   %eax
    167f:	e8 ac ea ff ff       	call   130 <memset>
    1684:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1687:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    168a:	c9                   	leave  
    168b:	c3                   	ret    

0000168c <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    168c:	55                   	push   %ebp
    168d:	89 e5                	mov    %esp,%ebp
    168f:	53                   	push   %ebx
    1690:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1693:	8b 45 0c             	mov    0xc(%ebp),%eax
    1696:	83 f8 03             	cmp    $0x3,%eax
    1699:	74 02                	je     169d <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    169b:	eb 33                	jmp    16d0 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    169d:	8b 45 08             	mov    0x8(%ebp),%eax
    16a0:	8b 48 08             	mov    0x8(%eax),%ecx
    16a3:	8b 45 08             	mov    0x8(%ebp),%eax
    16a6:	8b 50 38             	mov    0x38(%eax),%edx
    16a9:	8b 45 08             	mov    0x8(%ebp),%eax
    16ac:	8b 40 34             	mov    0x34(%eax),%eax
    16af:	8b 5d 08             	mov    0x8(%ebp),%ebx
    16b2:	83 c3 34             	add    $0x34,%ebx
    16b5:	83 ec 0c             	sub    $0xc,%esp
    16b8:	51                   	push   %ecx
    16b9:	52                   	push   %edx
    16ba:	50                   	push   %eax
    16bb:	6a 00                	push   $0x0
    16bd:	6a 00                	push   $0x0
    16bf:	53                   	push   %ebx
    16c0:	6a 32                	push   $0x32
    16c2:	6a 00                	push   $0x0
    16c4:	ff 75 08             	pushl  0x8(%ebp)
    16c7:	e8 9f ec ff ff       	call   36b <paintWindow>
    16cc:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    16cf:	90                   	nop
        default: break;
            
            
    }
    return False;
    16d0:	b8 00 00 00 00       	mov    $0x0,%eax
}
    16d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    16d8:	c9                   	leave  
    16d9:	c3                   	ret    

000016da <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    16da:	55                   	push   %ebp
    16db:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    16dd:	8b 45 0c             	mov    0xc(%ebp),%eax
    16e0:	8b 50 08             	mov    0x8(%eax),%edx
    16e3:	8b 45 08             	mov    0x8(%ebp),%eax
    16e6:	8b 00                	mov    (%eax),%eax
    16e8:	39 c2                	cmp    %eax,%edx
    16ea:	74 07                	je     16f3 <APPreJudge+0x19>
        return False;
    16ec:	b8 00 00 00 00       	mov    $0x0,%eax
    16f1:	eb 05                	jmp    16f8 <APPreJudge+0x1e>
    return True;
    16f3:	b8 01 00 00 00       	mov    $0x1,%eax
}
    16f8:	5d                   	pop    %ebp
    16f9:	c3                   	ret    

000016fa <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    16fa:	55                   	push   %ebp
    16fb:	89 e5                	mov    %esp,%ebp
    16fd:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1700:	8b 45 08             	mov    0x8(%ebp),%eax
    1703:	8b 55 0c             	mov    0xc(%ebp),%edx
    1706:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    1709:	83 ec 0c             	sub    $0xc,%esp
    170c:	ff 75 08             	pushl  0x8(%ebp)
    170f:	e8 77 ec ff ff       	call   38b <registWindow>
    1714:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1717:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    171e:	8b 45 08             	mov    0x8(%ebp),%eax
    1721:	8b 00                	mov    (%eax),%eax
    1723:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1726:	ff 75 f4             	pushl  -0xc(%ebp)
    1729:	ff 75 f0             	pushl  -0x10(%ebp)
    172c:	ff 75 ec             	pushl  -0x14(%ebp)
    172f:	ff 75 08             	pushl  0x8(%ebp)
    1732:	e8 e7 fc ff ff       	call   141e <APSendMessage>
    1737:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    173a:	83 ec 0c             	sub    $0xc,%esp
    173d:	ff 75 08             	pushl  0x8(%ebp)
    1740:	e8 3e ec ff ff       	call   383 <getMessage>
    1745:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1748:	8b 45 08             	mov    0x8(%ebp),%eax
    174b:	83 c0 6c             	add    $0x6c,%eax
    174e:	83 ec 08             	sub    $0x8,%esp
    1751:	50                   	push   %eax
    1752:	ff 75 08             	pushl  0x8(%ebp)
    1755:	e8 80 ff ff ff       	call   16da <APPreJudge>
    175a:	83 c4 10             	add    $0x10,%esp
    175d:	84 c0                	test   %al,%al
    175f:	74 1b                	je     177c <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    1761:	8b 45 08             	mov    0x8(%ebp),%eax
    1764:	ff 70 74             	pushl  0x74(%eax)
    1767:	ff 70 70             	pushl  0x70(%eax)
    176a:	ff 70 6c             	pushl  0x6c(%eax)
    176d:	ff 75 08             	pushl  0x8(%ebp)
    1770:	8b 45 0c             	mov    0xc(%ebp),%eax
    1773:	ff d0                	call   *%eax
    1775:	83 c4 10             	add    $0x10,%esp
    1778:	84 c0                	test   %al,%al
    177a:	75 0c                	jne    1788 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    177c:	8b 45 08             	mov    0x8(%ebp),%eax
    177f:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1786:	eb b2                	jmp    173a <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1788:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1789:	90                   	nop
    178a:	c9                   	leave  
    178b:	c3                   	ret    

0000178c <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    178c:	55                   	push   %ebp
    178d:	89 e5                	mov    %esp,%ebp
    178f:	57                   	push   %edi
    1790:	56                   	push   %esi
    1791:	53                   	push   %ebx
    1792:	83 ec 4c             	sub    $0x4c,%esp
    if (!iconReady)
    1795:	a1 78 25 00 00       	mov    0x2578,%eax
    179a:	85 c0                	test   %eax,%eax
    179c:	75 7c                	jne    181a <APGridPaint+0x8e>
    {
        iconReady = 1;
    179e:	c7 05 78 25 00 00 01 	movl   $0x1,0x2578
    17a5:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("Snake.bmp");
    17a8:	8d 45 b8             	lea    -0x48(%ebp),%eax
    17ab:	83 ec 08             	sub    $0x8,%esp
    17ae:	68 b3 1f 00 00       	push   $0x1fb3
    17b3:	50                   	push   %eax
    17b4:	e8 37 f1 ff ff       	call   8f0 <APLoadBitmap>
    17b9:	83 c4 0c             	add    $0xc,%esp
    17bc:	8b 45 b8             	mov    -0x48(%ebp),%eax
    17bf:	a3 7c 25 00 00       	mov    %eax,0x257c
    17c4:	8b 45 bc             	mov    -0x44(%ebp),%eax
    17c7:	a3 80 25 00 00       	mov    %eax,0x2580
    17cc:	8b 45 c0             	mov    -0x40(%ebp),%eax
    17cf:	a3 84 25 00 00       	mov    %eax,0x2584
        printf(1,"bitmap loaded!\n");
    17d4:	83 ec 08             	sub    $0x8,%esp
    17d7:	68 bd 1f 00 00       	push   $0x1fbd
    17dc:	6a 01                	push   $0x1
    17de:	e8 87 ec ff ff       	call   46a <printf>
    17e3:	83 c4 10             	add    $0x10,%esp
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    17e6:	83 ec 04             	sub    $0x4,%esp
    17e9:	ff 35 84 25 00 00    	pushl  0x2584
    17ef:	ff 35 80 25 00 00    	pushl  0x2580
    17f5:	ff 35 7c 25 00 00    	pushl  0x257c
    17fb:	e8 7a f3 ff ff       	call   b7a <APCreateCompatibleDCFromBitmap>
    1800:	83 c4 10             	add    $0x10,%esp
    1803:	a3 88 25 00 00       	mov    %eax,0x2588
        printf(1,"bitmap DC created!\n");
    1808:	83 ec 08             	sub    $0x8,%esp
    180b:	68 cd 1f 00 00       	push   $0x1fcd
    1810:	6a 01                	push   $0x1
    1812:	e8 53 ec ff ff       	call   46a <printf>
    1817:	83 c4 10             	add    $0x10,%esp
    }
    
    if (!wnd->is_grid)
    181a:	8b 45 08             	mov    0x8(%ebp),%eax
    181d:	8b 40 08             	mov    0x8(%eax),%eax
    1820:	85 c0                	test   %eax,%eax
    1822:	75 17                	jne    183b <APGridPaint+0xaf>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1824:	83 ec 08             	sub    $0x8,%esp
    1827:	68 e4 1f 00 00       	push   $0x1fe4
    182c:	6a 01                	push   $0x1
    182e:	e8 37 ec ff ff       	call   46a <printf>
    1833:	83 c4 10             	add    $0x10,%esp
        return;
    1836:	e9 55 03 00 00       	jmp    1b90 <APGridPaint+0x404>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    183b:	8b 45 08             	mov    0x8(%ebp),%eax
    183e:	8b 40 10             	mov    0x10(%eax),%eax
    1841:	85 c0                	test   %eax,%eax
    1843:	7e 10                	jle    1855 <APGridPaint+0xc9>
    1845:	8b 45 08             	mov    0x8(%ebp),%eax
    1848:	8b 50 14             	mov    0x14(%eax),%edx
    184b:	8b 45 08             	mov    0x8(%ebp),%eax
    184e:	8b 40 10             	mov    0x10(%eax),%eax
    1851:	39 c2                	cmp    %eax,%edx
    1853:	7c 17                	jl     186c <APGridPaint+0xe0>
    {
        printf(1,"Grid mode page error!");
    1855:	83 ec 08             	sub    $0x8,%esp
    1858:	68 0a 20 00 00       	push   $0x200a
    185d:	6a 01                	push   $0x1
    185f:	e8 06 ec ff ff       	call   46a <printf>
    1864:	83 c4 10             	add    $0x10,%esp
        return;
    1867:	e9 24 03 00 00       	jmp    1b90 <APGridPaint+0x404>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    186c:	8b 45 08             	mov    0x8(%ebp),%eax
    186f:	8b 40 14             	mov    0x14(%eax),%eax
    1872:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1878:	89 45 dc             	mov    %eax,-0x24(%ebp)
    187b:	8b 45 dc             	mov    -0x24(%ebp),%eax
    187e:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1881:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1888:	e9 f9 02 00 00       	jmp    1b86 <APGridPaint+0x3fa>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    188d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1894:	e9 df 02 00 00       	jmp    1b78 <APGridPaint+0x3ec>
        {
            index = start + GRID_W_NUMBER * j + i;
    1899:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    189c:	c1 e0 04             	shl    $0x4,%eax
    189f:	89 c2                	mov    %eax,%edx
    18a1:	8b 45 d8             	mov    -0x28(%ebp),%eax
    18a4:	01 c2                	add    %eax,%edx
    18a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    18a9:	01 d0                	add    %edx,%eax
    18ab:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    18ae:	8b 45 08             	mov    0x8(%ebp),%eax
    18b1:	8b 40 0c             	mov    0xc(%eax),%eax
    18b4:	8b 55 dc             	mov    -0x24(%ebp),%edx
    18b7:	c1 e2 02             	shl    $0x2,%edx
    18ba:	01 d0                	add    %edx,%eax
    18bc:	8b 00                	mov    (%eax),%eax
    18be:	83 f8 01             	cmp    $0x1,%eax
    18c1:	0f 84 83 00 00 00    	je     194a <APGridPaint+0x1be>
    18c7:	83 f8 01             	cmp    $0x1,%eax
    18ca:	7f 09                	jg     18d5 <APGridPaint+0x149>
    18cc:	85 c0                	test   %eax,%eax
    18ce:	74 1c                	je     18ec <APGridPaint+0x160>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    18d0:	e9 9f 02 00 00       	jmp    1b74 <APGridPaint+0x3e8>
        for (int i = 0; i < GRID_W_NUMBER;i++)
        {
            index = start + GRID_W_NUMBER * j + i;
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    18d5:	83 f8 02             	cmp    $0x2,%eax
    18d8:	0f 84 20 01 00 00    	je     19fe <APGridPaint+0x272>
    18de:	83 f8 03             	cmp    $0x3,%eax
    18e1:	0f 84 d1 01 00 00    	je     1ab8 <APGridPaint+0x32c>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    18e7:	e9 88 02 00 00       	jmp    1b74 <APGridPaint+0x3e8>
                    pen.size = 1;
                    brush.color = RGB(0xd2,0x69,0x1e);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);*/
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    18ec:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    18ef:	6a 0c                	push   $0xc
    18f1:	6a 0c                	push   $0xc
    18f3:	6a 0c                	push   $0xc
    18f5:	50                   	push   %eax
    18f6:	e8 de fa ff ff       	call   13d9 <RGB>
    18fb:	83 c4 0c             	add    $0xc,%esp
    18fe:	8b 1d 88 25 00 00    	mov    0x2588,%ebx
    1904:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1907:	6b c8 32             	imul   $0x32,%eax,%ecx
    190a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    190d:	6b c0 32             	imul   $0x32,%eax,%eax
    1910:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    1913:	8b 45 08             	mov    0x8(%ebp),%eax
    1916:	8d 78 34             	lea    0x34(%eax),%edi
    1919:	83 ec 0c             	sub    $0xc,%esp
    191c:	83 ec 04             	sub    $0x4,%esp
    191f:	89 e0                	mov    %esp,%eax
    1921:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1925:	66 89 30             	mov    %si,(%eax)
    1928:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    192c:	88 50 02             	mov    %dl,0x2(%eax)
    192f:	6a 32                	push   $0x32
    1931:	6a 32                	push   $0x32
    1933:	6a 00                	push   $0x0
    1935:	6a 00                	push   $0x0
    1937:	53                   	push   %ebx
    1938:	51                   	push   %ecx
    1939:	ff 75 b4             	pushl  -0x4c(%ebp)
    193c:	57                   	push   %edi
    193d:	e8 f3 f8 ff ff       	call   1235 <APDcCopy>
    1942:	83 c4 30             	add    $0x30,%esp
                    break;
    1945:	e9 2a 02 00 00       	jmp    1b74 <APGridPaint+0x3e8>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    194a:	8d 45 b8             	lea    -0x48(%ebp),%eax
    194d:	6a 69                	push   $0x69
    194f:	6a 69                	push   $0x69
    1951:	6a 69                	push   $0x69
    1953:	50                   	push   %eax
    1954:	e8 80 fa ff ff       	call   13d9 <RGB>
    1959:	83 c4 0c             	add    $0xc,%esp
    195c:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1960:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1964:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1968:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    196b:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1972:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1975:	6a 69                	push   $0x69
    1977:	6a 69                	push   $0x69
    1979:	6a 69                	push   $0x69
    197b:	50                   	push   %eax
    197c:	e8 58 fa ff ff       	call   13d9 <RGB>
    1981:	83 c4 0c             	add    $0xc,%esp
    1984:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1988:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    198c:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1990:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1993:	8b 45 08             	mov    0x8(%ebp),%eax
    1996:	8d 50 34             	lea    0x34(%eax),%edx
    1999:	8d 45 b8             	lea    -0x48(%ebp),%eax
    199c:	ff 75 d0             	pushl  -0x30(%ebp)
    199f:	ff 75 cc             	pushl  -0x34(%ebp)
    19a2:	52                   	push   %edx
    19a3:	50                   	push   %eax
    19a4:	e8 66 f2 ff ff       	call   c0f <APSetPen>
    19a9:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    19ac:	8b 45 08             	mov    0x8(%ebp),%eax
    19af:	8d 58 34             	lea    0x34(%eax),%ebx
    19b2:	8d 55 b8             	lea    -0x48(%ebp),%edx
    19b5:	83 ec 04             	sub    $0x4,%esp
    19b8:	83 ec 04             	sub    $0x4,%esp
    19bb:	89 e0                	mov    %esp,%eax
    19bd:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    19c1:	66 89 08             	mov    %cx,(%eax)
    19c4:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    19c8:	88 48 02             	mov    %cl,0x2(%eax)
    19cb:	53                   	push   %ebx
    19cc:	52                   	push   %edx
    19cd:	e8 76 f2 ff ff       	call   c48 <APSetBrush>
    19d2:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    19d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19d8:	6b d0 32             	imul   $0x32,%eax,%edx
    19db:	8b 45 e0             	mov    -0x20(%ebp),%eax
    19de:	6b c0 32             	imul   $0x32,%eax,%eax
    19e1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19e4:	83 c1 34             	add    $0x34,%ecx
    19e7:	83 ec 0c             	sub    $0xc,%esp
    19ea:	6a 32                	push   $0x32
    19ec:	6a 32                	push   $0x32
    19ee:	52                   	push   %edx
    19ef:	50                   	push   %eax
    19f0:	51                   	push   %ecx
    19f1:	e8 3a f6 ff ff       	call   1030 <APDrawRect>
    19f6:	83 c4 20             	add    $0x20,%esp
                    break;
    19f9:	e9 76 01 00 00       	jmp    1b74 <APGridPaint+0x3e8>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    pen.color = RGB(0x00,0x80,0x00);
    19fe:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a01:	6a 00                	push   $0x0
    1a03:	68 80 00 00 00       	push   $0x80
    1a08:	6a 00                	push   $0x0
    1a0a:	50                   	push   %eax
    1a0b:	e8 c9 f9 ff ff       	call   13d9 <RGB>
    1a10:	83 c4 0c             	add    $0xc,%esp
    1a13:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1a17:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1a1b:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1a1f:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1a22:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0x80,0x00);
    1a29:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a2c:	6a 00                	push   $0x0
    1a2e:	68 80 00 00 00       	push   $0x80
    1a33:	6a 00                	push   $0x0
    1a35:	50                   	push   %eax
    1a36:	e8 9e f9 ff ff       	call   13d9 <RGB>
    1a3b:	83 c4 0c             	add    $0xc,%esp
    1a3e:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1a42:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1a46:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1a4a:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1a4d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a50:	8d 50 34             	lea    0x34(%eax),%edx
    1a53:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a56:	ff 75 d0             	pushl  -0x30(%ebp)
    1a59:	ff 75 cc             	pushl  -0x34(%ebp)
    1a5c:	52                   	push   %edx
    1a5d:	50                   	push   %eax
    1a5e:	e8 ac f1 ff ff       	call   c0f <APSetPen>
    1a63:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1a66:	8b 45 08             	mov    0x8(%ebp),%eax
    1a69:	8d 58 34             	lea    0x34(%eax),%ebx
    1a6c:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1a6f:	83 ec 04             	sub    $0x4,%esp
    1a72:	83 ec 04             	sub    $0x4,%esp
    1a75:	89 e0                	mov    %esp,%eax
    1a77:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1a7b:	66 89 08             	mov    %cx,(%eax)
    1a7e:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1a82:	88 48 02             	mov    %cl,0x2(%eax)
    1a85:	53                   	push   %ebx
    1a86:	52                   	push   %edx
    1a87:	e8 bc f1 ff ff       	call   c48 <APSetBrush>
    1a8c:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1a8f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a92:	6b d0 32             	imul   $0x32,%eax,%edx
    1a95:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a98:	6b c0 32             	imul   $0x32,%eax,%eax
    1a9b:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a9e:	83 c1 34             	add    $0x34,%ecx
    1aa1:	83 ec 0c             	sub    $0xc,%esp
    1aa4:	6a 32                	push   $0x32
    1aa6:	6a 32                	push   $0x32
    1aa8:	52                   	push   %edx
    1aa9:	50                   	push   %eax
    1aaa:	51                   	push   %ecx
    1aab:	e8 80 f5 ff ff       	call   1030 <APDrawRect>
    1ab0:	83 c4 20             	add    $0x20,%esp
                    break;
    1ab3:	e9 bc 00 00 00       	jmp    1b74 <APGridPaint+0x3e8>
                case GRID_RIVER:
                    //printf(1,"Grid_River");
                    pen.color = RGB(0x00,0xbf,0xff);
    1ab8:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1abb:	68 ff 00 00 00       	push   $0xff
    1ac0:	68 bf 00 00 00       	push   $0xbf
    1ac5:	6a 00                	push   $0x0
    1ac7:	50                   	push   %eax
    1ac8:	e8 0c f9 ff ff       	call   13d9 <RGB>
    1acd:	83 c4 0c             	add    $0xc,%esp
    1ad0:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1ad4:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1ad8:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1adc:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1adf:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0xbf,0xff);
    1ae6:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1ae9:	68 ff 00 00 00       	push   $0xff
    1aee:	68 bf 00 00 00       	push   $0xbf
    1af3:	6a 00                	push   $0x0
    1af5:	50                   	push   %eax
    1af6:	e8 de f8 ff ff       	call   13d9 <RGB>
    1afb:	83 c4 0c             	add    $0xc,%esp
    1afe:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1b02:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1b06:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1b0a:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b0d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b10:	8d 50 34             	lea    0x34(%eax),%edx
    1b13:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b16:	ff 75 d0             	pushl  -0x30(%ebp)
    1b19:	ff 75 cc             	pushl  -0x34(%ebp)
    1b1c:	52                   	push   %edx
    1b1d:	50                   	push   %eax
    1b1e:	e8 ec f0 ff ff       	call   c0f <APSetPen>
    1b23:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b26:	8b 45 08             	mov    0x8(%ebp),%eax
    1b29:	8d 58 34             	lea    0x34(%eax),%ebx
    1b2c:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1b2f:	83 ec 04             	sub    $0x4,%esp
    1b32:	83 ec 04             	sub    $0x4,%esp
    1b35:	89 e0                	mov    %esp,%eax
    1b37:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1b3b:	66 89 08             	mov    %cx,(%eax)
    1b3e:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1b42:	88 48 02             	mov    %cl,0x2(%eax)
    1b45:	53                   	push   %ebx
    1b46:	52                   	push   %edx
    1b47:	e8 fc f0 ff ff       	call   c48 <APSetBrush>
    1b4c:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
    1b4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b52:	6b d0 32             	imul   $0x32,%eax,%edx
    1b55:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b58:	6b c0 32             	imul   $0x32,%eax,%eax
    1b5b:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b5e:	83 c1 34             	add    $0x34,%ecx
    1b61:	83 ec 0c             	sub    $0xc,%esp
    1b64:	6a 32                	push   $0x32
    1b66:	6a 32                	push   $0x32
    1b68:	52                   	push   %edx
    1b69:	50                   	push   %eax
    1b6a:	51                   	push   %ecx
    1b6b:	e8 c0 f4 ff ff       	call   1030 <APDrawRect>
    1b70:	83 c4 20             	add    $0x20,%esp
                    break;
    1b73:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1b74:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1b78:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1b7c:	0f 8e 17 fd ff ff    	jle    1899 <APGridPaint+0x10d>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1b82:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1b86:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1b8a:	0f 8e fd fc ff ff    	jle    188d <APGridPaint+0x101>
                    break;
                default: break;
            }
        }
    }
}
    1b90:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b93:	5b                   	pop    %ebx
    1b94:	5e                   	pop    %esi
    1b95:	5f                   	pop    %edi
    1b96:	5d                   	pop    %ebp
    1b97:	c3                   	ret    

00001b98 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1b98:	55                   	push   %ebp
    1b99:	89 e5                	mov    %esp,%ebp
    1b9b:	53                   	push   %ebx
    1b9c:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1b9f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1ba6:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1baa:	74 17                	je     1bc3 <sprintint+0x2b>
    1bac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1bb0:	79 11                	jns    1bc3 <sprintint+0x2b>
        neg = 1;
    1bb2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1bb9:	8b 45 10             	mov    0x10(%ebp),%eax
    1bbc:	f7 d8                	neg    %eax
    1bbe:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1bc1:	eb 06                	jmp    1bc9 <sprintint+0x31>
    } else {
        x = xx;
    1bc3:	8b 45 10             	mov    0x10(%ebp),%eax
    1bc6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1bc9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1bd0:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1bd3:	8d 41 01             	lea    0x1(%ecx),%eax
    1bd6:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1bd9:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1bdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bdf:	ba 00 00 00 00       	mov    $0x0,%edx
    1be4:	f7 f3                	div    %ebx
    1be6:	89 d0                	mov    %edx,%eax
    1be8:	0f b6 80 58 25 00 00 	movzbl 0x2558(%eax),%eax
    1bef:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1bf3:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1bf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bf9:	ba 00 00 00 00       	mov    $0x0,%edx
    1bfe:	f7 f3                	div    %ebx
    1c00:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1c03:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1c07:	75 c7                	jne    1bd0 <sprintint+0x38>
    if(neg)
    1c09:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1c0d:	74 0e                	je     1c1d <sprintint+0x85>
        buf[i++] = '-';
    1c0f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c12:	8d 50 01             	lea    0x1(%eax),%edx
    1c15:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1c18:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1c1d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c20:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1c23:	eb 1b                	jmp    1c40 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1c25:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c28:	8b 00                	mov    (%eax),%eax
    1c2a:	8d 48 01             	lea    0x1(%eax),%ecx
    1c2d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c30:	89 0a                	mov    %ecx,(%edx)
    1c32:	89 c2                	mov    %eax,%edx
    1c34:	8b 45 08             	mov    0x8(%ebp),%eax
    1c37:	01 d0                	add    %edx,%eax
    1c39:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1c3c:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1c40:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1c44:	7f df                	jg     1c25 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1c46:	eb 21                	jmp    1c69 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1c48:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c4b:	8b 00                	mov    (%eax),%eax
    1c4d:	8d 48 01             	lea    0x1(%eax),%ecx
    1c50:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c53:	89 0a                	mov    %ecx,(%edx)
    1c55:	89 c2                	mov    %eax,%edx
    1c57:	8b 45 08             	mov    0x8(%ebp),%eax
    1c5a:	01 c2                	add    %eax,%edx
    1c5c:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1c5f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c62:	01 c8                	add    %ecx,%eax
    1c64:	0f b6 00             	movzbl (%eax),%eax
    1c67:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1c69:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1c6d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1c71:	79 d5                	jns    1c48 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1c73:	90                   	nop
    1c74:	83 c4 20             	add    $0x20,%esp
    1c77:	5b                   	pop    %ebx
    1c78:	5d                   	pop    %ebp
    1c79:	c3                   	ret    

00001c7a <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1c7a:	55                   	push   %ebp
    1c7b:	89 e5                	mov    %esp,%ebp
    1c7d:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1c80:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1c87:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1c8e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1c95:	8d 45 0c             	lea    0xc(%ebp),%eax
    1c98:	83 c0 04             	add    $0x4,%eax
    1c9b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1c9e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1ca5:	e9 d9 01 00 00       	jmp    1e83 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1caa:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cad:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1cb0:	01 d0                	add    %edx,%eax
    1cb2:	0f b6 00             	movzbl (%eax),%eax
    1cb5:	0f be c0             	movsbl %al,%eax
    1cb8:	25 ff 00 00 00       	and    $0xff,%eax
    1cbd:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1cc0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1cc4:	75 2c                	jne    1cf2 <sprintf+0x78>
            if(c == '%'){
    1cc6:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1cca:	75 0c                	jne    1cd8 <sprintf+0x5e>
                state = '%';
    1ccc:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1cd3:	e9 a7 01 00 00       	jmp    1e7f <sprintf+0x205>
            } else {
                dst[j++] = c;
    1cd8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1cdb:	8d 50 01             	lea    0x1(%eax),%edx
    1cde:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1ce1:	89 c2                	mov    %eax,%edx
    1ce3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce6:	01 d0                	add    %edx,%eax
    1ce8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1ceb:	88 10                	mov    %dl,(%eax)
    1ced:	e9 8d 01 00 00       	jmp    1e7f <sprintf+0x205>
            }
        } else if(state == '%'){
    1cf2:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1cf6:	0f 85 83 01 00 00    	jne    1e7f <sprintf+0x205>
            if(c == 'd'){
    1cfc:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1d00:	75 4c                	jne    1d4e <sprintf+0xd4>
                buf[bi] = '\0';
    1d02:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1d05:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d08:	01 d0                	add    %edx,%eax
    1d0a:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1d0d:	83 ec 0c             	sub    $0xc,%esp
    1d10:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1d13:	50                   	push   %eax
    1d14:	e8 20 e5 ff ff       	call   239 <atoi>
    1d19:	83 c4 10             	add    $0x10,%esp
    1d1c:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1d1f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1d26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d29:	8b 00                	mov    (%eax),%eax
    1d2b:	83 ec 08             	sub    $0x8,%esp
    1d2e:	ff 75 d8             	pushl  -0x28(%ebp)
    1d31:	6a 01                	push   $0x1
    1d33:	6a 0a                	push   $0xa
    1d35:	50                   	push   %eax
    1d36:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1d39:	50                   	push   %eax
    1d3a:	ff 75 08             	pushl  0x8(%ebp)
    1d3d:	e8 56 fe ff ff       	call   1b98 <sprintint>
    1d42:	83 c4 20             	add    $0x20,%esp
                ap++;
    1d45:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1d49:	e9 2a 01 00 00       	jmp    1e78 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1d4e:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1d52:	74 06                	je     1d5a <sprintf+0xe0>
    1d54:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1d58:	75 4c                	jne    1da6 <sprintf+0x12c>
                buf[bi] = '\0';
    1d5a:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1d5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d60:	01 d0                	add    %edx,%eax
    1d62:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1d65:	83 ec 0c             	sub    $0xc,%esp
    1d68:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1d6b:	50                   	push   %eax
    1d6c:	e8 c8 e4 ff ff       	call   239 <atoi>
    1d71:	83 c4 10             	add    $0x10,%esp
    1d74:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1d77:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1d7e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d81:	8b 00                	mov    (%eax),%eax
    1d83:	83 ec 08             	sub    $0x8,%esp
    1d86:	ff 75 dc             	pushl  -0x24(%ebp)
    1d89:	6a 00                	push   $0x0
    1d8b:	6a 10                	push   $0x10
    1d8d:	50                   	push   %eax
    1d8e:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1d91:	50                   	push   %eax
    1d92:	ff 75 08             	pushl  0x8(%ebp)
    1d95:	e8 fe fd ff ff       	call   1b98 <sprintint>
    1d9a:	83 c4 20             	add    $0x20,%esp
                ap++;
    1d9d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1da1:	e9 d2 00 00 00       	jmp    1e78 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1da6:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1daa:	75 46                	jne    1df2 <sprintf+0x178>
                s = (char*)*ap;
    1dac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1daf:	8b 00                	mov    (%eax),%eax
    1db1:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1db4:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1db8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1dbc:	75 25                	jne    1de3 <sprintf+0x169>
                    s = "(null)";
    1dbe:	c7 45 f4 20 20 00 00 	movl   $0x2020,-0xc(%ebp)
                while(*s != 0){
    1dc5:	eb 1c                	jmp    1de3 <sprintf+0x169>
                    dst[j++] = *s;
    1dc7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1dca:	8d 50 01             	lea    0x1(%eax),%edx
    1dcd:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1dd0:	89 c2                	mov    %eax,%edx
    1dd2:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd5:	01 c2                	add    %eax,%edx
    1dd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dda:	0f b6 00             	movzbl (%eax),%eax
    1ddd:	88 02                	mov    %al,(%edx)
                    s++;
    1ddf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    1de3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1de6:	0f b6 00             	movzbl (%eax),%eax
    1de9:	84 c0                	test   %al,%al
    1deb:	75 da                	jne    1dc7 <sprintf+0x14d>
    1ded:	e9 86 00 00 00       	jmp    1e78 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    1df2:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    1df6:	75 1d                	jne    1e15 <sprintf+0x19b>
                dst[j++] = *ap;
    1df8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1dfb:	8d 50 01             	lea    0x1(%eax),%edx
    1dfe:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e01:	89 c2                	mov    %eax,%edx
    1e03:	8b 45 08             	mov    0x8(%ebp),%eax
    1e06:	01 c2                	add    %eax,%edx
    1e08:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e0b:	8b 00                	mov    (%eax),%eax
    1e0d:	88 02                	mov    %al,(%edx)
                ap++;
    1e0f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1e13:	eb 63                	jmp    1e78 <sprintf+0x1fe>
            } else if(c == '%'){
    1e15:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1e19:	75 17                	jne    1e32 <sprintf+0x1b8>
                dst[j++] = c;
    1e1b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e1e:	8d 50 01             	lea    0x1(%eax),%edx
    1e21:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e24:	89 c2                	mov    %eax,%edx
    1e26:	8b 45 08             	mov    0x8(%ebp),%eax
    1e29:	01 d0                	add    %edx,%eax
    1e2b:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1e2e:	88 10                	mov    %dl,(%eax)
    1e30:	eb 46                	jmp    1e78 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    1e32:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    1e36:	7e 18                	jle    1e50 <sprintf+0x1d6>
    1e38:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    1e3c:	7f 12                	jg     1e50 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    1e3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e41:	8d 50 01             	lea    0x1(%eax),%edx
    1e44:	89 55 f0             	mov    %edx,-0x10(%ebp)
    1e47:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1e4a:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    1e4e:	eb 2f                	jmp    1e7f <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    1e50:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e53:	8d 50 01             	lea    0x1(%eax),%edx
    1e56:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e59:	89 c2                	mov    %eax,%edx
    1e5b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e5e:	01 d0                	add    %edx,%eax
    1e60:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    1e63:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e66:	8d 50 01             	lea    0x1(%eax),%edx
    1e69:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e6c:	89 c2                	mov    %eax,%edx
    1e6e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e71:	01 d0                	add    %edx,%eax
    1e73:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1e76:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    1e78:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    1e7f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1e83:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e86:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e89:	01 d0                	add    %edx,%eax
    1e8b:	0f b6 00             	movzbl (%eax),%eax
    1e8e:	84 c0                	test   %al,%al
    1e90:	0f 85 14 fe ff ff    	jne    1caa <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    1e96:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e99:	8d 50 01             	lea    0x1(%eax),%edx
    1e9c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e9f:	89 c2                	mov    %eax,%edx
    1ea1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea4:	01 d0                	add    %edx,%eax
    1ea6:	c6 00 00             	movb   $0x0,(%eax)
}
    1ea9:	90                   	nop
    1eaa:	c9                   	leave  
    1eab:	c3                   	ret    
