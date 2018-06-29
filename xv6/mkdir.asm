
_mkdir：     文件格式 elf32-i386


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
       f:	83 ec 10             	sub    $0x10,%esp
      12:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
      14:	83 3b 01             	cmpl   $0x1,(%ebx)
      17:	7f 17                	jg     30 <main+0x30>
    printf(2, "Usage: mkdir files...\n");
      19:	83 ec 08             	sub    $0x8,%esp
      1c:	68 dc 25 00 00       	push   $0x25dc
      21:	6a 02                	push   $0x2
      23:	e8 7e 04 00 00       	call   4a6 <printf>
      28:	83 c4 10             	add    $0x10,%esp
    exit();
      2b:	e8 b7 02 00 00       	call   2e7 <exit>
  }

  for(i = 1; i < argc; i++){
      30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      37:	eb 4b                	jmp    84 <main+0x84>
    if(mkdir(argv[i]) < 0){
      39:	8b 45 f4             	mov    -0xc(%ebp),%eax
      3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      43:	8b 43 04             	mov    0x4(%ebx),%eax
      46:	01 d0                	add    %edx,%eax
      48:	8b 00                	mov    (%eax),%eax
      4a:	83 ec 0c             	sub    $0xc,%esp
      4d:	50                   	push   %eax
      4e:	e8 fc 02 00 00       	call   34f <mkdir>
      53:	83 c4 10             	add    $0x10,%esp
      56:	85 c0                	test   %eax,%eax
      58:	79 26                	jns    80 <main+0x80>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
      5d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      64:	8b 43 04             	mov    0x4(%ebx),%eax
      67:	01 d0                	add    %edx,%eax
      69:	8b 00                	mov    (%eax),%eax
      6b:	83 ec 04             	sub    $0x4,%esp
      6e:	50                   	push   %eax
      6f:	68 f3 25 00 00       	push   $0x25f3
      74:	6a 02                	push   $0x2
      76:	e8 2b 04 00 00       	call   4a6 <printf>
      7b:	83 c4 10             	add    $0x10,%esp
      break;
      7e:	eb 0b                	jmp    8b <main+0x8b>
  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
      80:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      84:	8b 45 f4             	mov    -0xc(%ebp),%eax
      87:	3b 03                	cmp    (%ebx),%eax
      89:	7c ae                	jl     39 <main+0x39>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
      8b:	e8 57 02 00 00       	call   2e7 <exit>

00000090 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
      90:	55                   	push   %ebp
      91:	89 e5                	mov    %esp,%ebp
      93:	57                   	push   %edi
      94:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      95:	8b 4d 08             	mov    0x8(%ebp),%ecx
      98:	8b 55 10             	mov    0x10(%ebp),%edx
      9b:	8b 45 0c             	mov    0xc(%ebp),%eax
      9e:	89 cb                	mov    %ecx,%ebx
      a0:	89 df                	mov    %ebx,%edi
      a2:	89 d1                	mov    %edx,%ecx
      a4:	fc                   	cld    
      a5:	f3 aa                	rep stos %al,%es:(%edi)
      a7:	89 ca                	mov    %ecx,%edx
      a9:	89 fb                	mov    %edi,%ebx
      ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
      ae:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      b1:	90                   	nop
      b2:	5b                   	pop    %ebx
      b3:	5f                   	pop    %edi
      b4:	5d                   	pop    %ebp
      b5:	c3                   	ret    

000000b6 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      b6:	55                   	push   %ebp
      b7:	89 e5                	mov    %esp,%ebp
      b9:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      bc:	8b 45 08             	mov    0x8(%ebp),%eax
      bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      c2:	90                   	nop
      c3:	8b 45 08             	mov    0x8(%ebp),%eax
      c6:	8d 50 01             	lea    0x1(%eax),%edx
      c9:	89 55 08             	mov    %edx,0x8(%ebp)
      cc:	8b 55 0c             	mov    0xc(%ebp),%edx
      cf:	8d 4a 01             	lea    0x1(%edx),%ecx
      d2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
      d5:	0f b6 12             	movzbl (%edx),%edx
      d8:	88 10                	mov    %dl,(%eax)
      da:	0f b6 00             	movzbl (%eax),%eax
      dd:	84 c0                	test   %al,%al
      df:	75 e2                	jne    c3 <strcpy+0xd>
    ;
  return os;
      e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      e4:	c9                   	leave  
      e5:	c3                   	ret    

000000e6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      e6:	55                   	push   %ebp
      e7:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      e9:	eb 08                	jmp    f3 <strcmp+0xd>
    p++, q++;
      eb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      ef:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
      f3:	8b 45 08             	mov    0x8(%ebp),%eax
      f6:	0f b6 00             	movzbl (%eax),%eax
      f9:	84 c0                	test   %al,%al
      fb:	74 10                	je     10d <strcmp+0x27>
      fd:	8b 45 08             	mov    0x8(%ebp),%eax
     100:	0f b6 10             	movzbl (%eax),%edx
     103:	8b 45 0c             	mov    0xc(%ebp),%eax
     106:	0f b6 00             	movzbl (%eax),%eax
     109:	38 c2                	cmp    %al,%dl
     10b:	74 de                	je     eb <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     10d:	8b 45 08             	mov    0x8(%ebp),%eax
     110:	0f b6 00             	movzbl (%eax),%eax
     113:	0f b6 d0             	movzbl %al,%edx
     116:	8b 45 0c             	mov    0xc(%ebp),%eax
     119:	0f b6 00             	movzbl (%eax),%eax
     11c:	0f b6 c0             	movzbl %al,%eax
     11f:	29 c2                	sub    %eax,%edx
     121:	89 d0                	mov    %edx,%eax
}
     123:	5d                   	pop    %ebp
     124:	c3                   	ret    

00000125 <strlen>:

uint
strlen(char *s)
{
     125:	55                   	push   %ebp
     126:	89 e5                	mov    %esp,%ebp
     128:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     12b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     132:	eb 04                	jmp    138 <strlen+0x13>
     134:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     138:	8b 55 fc             	mov    -0x4(%ebp),%edx
     13b:	8b 45 08             	mov    0x8(%ebp),%eax
     13e:	01 d0                	add    %edx,%eax
     140:	0f b6 00             	movzbl (%eax),%eax
     143:	84 c0                	test   %al,%al
     145:	75 ed                	jne    134 <strlen+0xf>
    ;
  return n;
     147:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     14a:	c9                   	leave  
     14b:	c3                   	ret    

0000014c <memset>:

void*
memset(void *dst, int c, uint n)
{
     14c:	55                   	push   %ebp
     14d:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     14f:	8b 45 10             	mov    0x10(%ebp),%eax
     152:	50                   	push   %eax
     153:	ff 75 0c             	pushl  0xc(%ebp)
     156:	ff 75 08             	pushl  0x8(%ebp)
     159:	e8 32 ff ff ff       	call   90 <stosb>
     15e:	83 c4 0c             	add    $0xc,%esp
  return dst;
     161:	8b 45 08             	mov    0x8(%ebp),%eax
}
     164:	c9                   	leave  
     165:	c3                   	ret    

00000166 <strchr>:

char*
strchr(const char *s, char c)
{
     166:	55                   	push   %ebp
     167:	89 e5                	mov    %esp,%ebp
     169:	83 ec 04             	sub    $0x4,%esp
     16c:	8b 45 0c             	mov    0xc(%ebp),%eax
     16f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     172:	eb 14                	jmp    188 <strchr+0x22>
    if(*s == c)
     174:	8b 45 08             	mov    0x8(%ebp),%eax
     177:	0f b6 00             	movzbl (%eax),%eax
     17a:	3a 45 fc             	cmp    -0x4(%ebp),%al
     17d:	75 05                	jne    184 <strchr+0x1e>
      return (char*)s;
     17f:	8b 45 08             	mov    0x8(%ebp),%eax
     182:	eb 13                	jmp    197 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     184:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     188:	8b 45 08             	mov    0x8(%ebp),%eax
     18b:	0f b6 00             	movzbl (%eax),%eax
     18e:	84 c0                	test   %al,%al
     190:	75 e2                	jne    174 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     192:	b8 00 00 00 00       	mov    $0x0,%eax
}
     197:	c9                   	leave  
     198:	c3                   	ret    

00000199 <gets>:

char*
gets(char *buf, int max)
{
     199:	55                   	push   %ebp
     19a:	89 e5                	mov    %esp,%ebp
     19c:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     19f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     1a6:	eb 42                	jmp    1ea <gets+0x51>
    cc = read(0, &c, 1);
     1a8:	83 ec 04             	sub    $0x4,%esp
     1ab:	6a 01                	push   $0x1
     1ad:	8d 45 ef             	lea    -0x11(%ebp),%eax
     1b0:	50                   	push   %eax
     1b1:	6a 00                	push   $0x0
     1b3:	e8 47 01 00 00       	call   2ff <read>
     1b8:	83 c4 10             	add    $0x10,%esp
     1bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     1be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1c2:	7e 33                	jle    1f7 <gets+0x5e>
      break;
    buf[i++] = c;
     1c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1c7:	8d 50 01             	lea    0x1(%eax),%edx
     1ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1cd:	89 c2                	mov    %eax,%edx
     1cf:	8b 45 08             	mov    0x8(%ebp),%eax
     1d2:	01 c2                	add    %eax,%edx
     1d4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1d8:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1da:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1de:	3c 0a                	cmp    $0xa,%al
     1e0:	74 16                	je     1f8 <gets+0x5f>
     1e2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1e6:	3c 0d                	cmp    $0xd,%al
     1e8:	74 0e                	je     1f8 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1ed:	83 c0 01             	add    $0x1,%eax
     1f0:	3b 45 0c             	cmp    0xc(%ebp),%eax
     1f3:	7c b3                	jl     1a8 <gets+0xf>
     1f5:	eb 01                	jmp    1f8 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     1f7:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     1f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     1fb:	8b 45 08             	mov    0x8(%ebp),%eax
     1fe:	01 d0                	add    %edx,%eax
     200:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     203:	8b 45 08             	mov    0x8(%ebp),%eax
}
     206:	c9                   	leave  
     207:	c3                   	ret    

00000208 <stat>:

int
stat(char *n, struct stat *st)
{
     208:	55                   	push   %ebp
     209:	89 e5                	mov    %esp,%ebp
     20b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     20e:	83 ec 08             	sub    $0x8,%esp
     211:	6a 00                	push   $0x0
     213:	ff 75 08             	pushl  0x8(%ebp)
     216:	e8 0c 01 00 00       	call   327 <open>
     21b:	83 c4 10             	add    $0x10,%esp
     21e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     221:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     225:	79 07                	jns    22e <stat+0x26>
    return -1;
     227:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     22c:	eb 25                	jmp    253 <stat+0x4b>
  r = fstat(fd, st);
     22e:	83 ec 08             	sub    $0x8,%esp
     231:	ff 75 0c             	pushl  0xc(%ebp)
     234:	ff 75 f4             	pushl  -0xc(%ebp)
     237:	e8 03 01 00 00       	call   33f <fstat>
     23c:	83 c4 10             	add    $0x10,%esp
     23f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     242:	83 ec 0c             	sub    $0xc,%esp
     245:	ff 75 f4             	pushl  -0xc(%ebp)
     248:	e8 c2 00 00 00       	call   30f <close>
     24d:	83 c4 10             	add    $0x10,%esp
  return r;
     250:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     253:	c9                   	leave  
     254:	c3                   	ret    

00000255 <atoi>:

int
atoi(const char *s)
{
     255:	55                   	push   %ebp
     256:	89 e5                	mov    %esp,%ebp
     258:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     25b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     262:	eb 25                	jmp    289 <atoi+0x34>
    n = n*10 + *s++ - '0';
     264:	8b 55 fc             	mov    -0x4(%ebp),%edx
     267:	89 d0                	mov    %edx,%eax
     269:	c1 e0 02             	shl    $0x2,%eax
     26c:	01 d0                	add    %edx,%eax
     26e:	01 c0                	add    %eax,%eax
     270:	89 c1                	mov    %eax,%ecx
     272:	8b 45 08             	mov    0x8(%ebp),%eax
     275:	8d 50 01             	lea    0x1(%eax),%edx
     278:	89 55 08             	mov    %edx,0x8(%ebp)
     27b:	0f b6 00             	movzbl (%eax),%eax
     27e:	0f be c0             	movsbl %al,%eax
     281:	01 c8                	add    %ecx,%eax
     283:	83 e8 30             	sub    $0x30,%eax
     286:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     289:	8b 45 08             	mov    0x8(%ebp),%eax
     28c:	0f b6 00             	movzbl (%eax),%eax
     28f:	3c 2f                	cmp    $0x2f,%al
     291:	7e 0a                	jle    29d <atoi+0x48>
     293:	8b 45 08             	mov    0x8(%ebp),%eax
     296:	0f b6 00             	movzbl (%eax),%eax
     299:	3c 39                	cmp    $0x39,%al
     29b:	7e c7                	jle    264 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     29d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     2a0:	c9                   	leave  
     2a1:	c3                   	ret    

000002a2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     2a2:	55                   	push   %ebp
     2a3:	89 e5                	mov    %esp,%ebp
     2a5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     2a8:	8b 45 08             	mov    0x8(%ebp),%eax
     2ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     2ae:	8b 45 0c             	mov    0xc(%ebp),%eax
     2b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     2b4:	eb 17                	jmp    2cd <memmove+0x2b>
    *dst++ = *src++;
     2b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     2b9:	8d 50 01             	lea    0x1(%eax),%edx
     2bc:	89 55 fc             	mov    %edx,-0x4(%ebp)
     2bf:	8b 55 f8             	mov    -0x8(%ebp),%edx
     2c2:	8d 4a 01             	lea    0x1(%edx),%ecx
     2c5:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     2c8:	0f b6 12             	movzbl (%edx),%edx
     2cb:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     2cd:	8b 45 10             	mov    0x10(%ebp),%eax
     2d0:	8d 50 ff             	lea    -0x1(%eax),%edx
     2d3:	89 55 10             	mov    %edx,0x10(%ebp)
     2d6:	85 c0                	test   %eax,%eax
     2d8:	7f dc                	jg     2b6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     2da:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2dd:	c9                   	leave  
     2de:	c3                   	ret    

000002df <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2df:	b8 01 00 00 00       	mov    $0x1,%eax
     2e4:	cd 40                	int    $0x40
     2e6:	c3                   	ret    

000002e7 <exit>:
SYSCALL(exit)
     2e7:	b8 02 00 00 00       	mov    $0x2,%eax
     2ec:	cd 40                	int    $0x40
     2ee:	c3                   	ret    

000002ef <wait>:
SYSCALL(wait)
     2ef:	b8 03 00 00 00       	mov    $0x3,%eax
     2f4:	cd 40                	int    $0x40
     2f6:	c3                   	ret    

000002f7 <pipe>:
SYSCALL(pipe)
     2f7:	b8 04 00 00 00       	mov    $0x4,%eax
     2fc:	cd 40                	int    $0x40
     2fe:	c3                   	ret    

000002ff <read>:
SYSCALL(read)
     2ff:	b8 05 00 00 00       	mov    $0x5,%eax
     304:	cd 40                	int    $0x40
     306:	c3                   	ret    

00000307 <write>:
SYSCALL(write)
     307:	b8 10 00 00 00       	mov    $0x10,%eax
     30c:	cd 40                	int    $0x40
     30e:	c3                   	ret    

0000030f <close>:
SYSCALL(close)
     30f:	b8 15 00 00 00       	mov    $0x15,%eax
     314:	cd 40                	int    $0x40
     316:	c3                   	ret    

00000317 <kill>:
SYSCALL(kill)
     317:	b8 06 00 00 00       	mov    $0x6,%eax
     31c:	cd 40                	int    $0x40
     31e:	c3                   	ret    

0000031f <exec>:
SYSCALL(exec)
     31f:	b8 07 00 00 00       	mov    $0x7,%eax
     324:	cd 40                	int    $0x40
     326:	c3                   	ret    

00000327 <open>:
SYSCALL(open)
     327:	b8 0f 00 00 00       	mov    $0xf,%eax
     32c:	cd 40                	int    $0x40
     32e:	c3                   	ret    

0000032f <mknod>:
SYSCALL(mknod)
     32f:	b8 11 00 00 00       	mov    $0x11,%eax
     334:	cd 40                	int    $0x40
     336:	c3                   	ret    

00000337 <unlink>:
SYSCALL(unlink)
     337:	b8 12 00 00 00       	mov    $0x12,%eax
     33c:	cd 40                	int    $0x40
     33e:	c3                   	ret    

0000033f <fstat>:
SYSCALL(fstat)
     33f:	b8 08 00 00 00       	mov    $0x8,%eax
     344:	cd 40                	int    $0x40
     346:	c3                   	ret    

00000347 <link>:
SYSCALL(link)
     347:	b8 13 00 00 00       	mov    $0x13,%eax
     34c:	cd 40                	int    $0x40
     34e:	c3                   	ret    

0000034f <mkdir>:
SYSCALL(mkdir)
     34f:	b8 14 00 00 00       	mov    $0x14,%eax
     354:	cd 40                	int    $0x40
     356:	c3                   	ret    

00000357 <chdir>:
SYSCALL(chdir)
     357:	b8 09 00 00 00       	mov    $0x9,%eax
     35c:	cd 40                	int    $0x40
     35e:	c3                   	ret    

0000035f <dup>:
SYSCALL(dup)
     35f:	b8 0a 00 00 00       	mov    $0xa,%eax
     364:	cd 40                	int    $0x40
     366:	c3                   	ret    

00000367 <getpid>:
SYSCALL(getpid)
     367:	b8 0b 00 00 00       	mov    $0xb,%eax
     36c:	cd 40                	int    $0x40
     36e:	c3                   	ret    

0000036f <sbrk>:
SYSCALL(sbrk)
     36f:	b8 0c 00 00 00       	mov    $0xc,%eax
     374:	cd 40                	int    $0x40
     376:	c3                   	ret    

00000377 <sleep>:
SYSCALL(sleep)
     377:	b8 0d 00 00 00       	mov    $0xd,%eax
     37c:	cd 40                	int    $0x40
     37e:	c3                   	ret    

0000037f <uptime>:
SYSCALL(uptime)
     37f:	b8 0e 00 00 00       	mov    $0xe,%eax
     384:	cd 40                	int    $0x40
     386:	c3                   	ret    

00000387 <paintWindow>:

SYSCALL(paintWindow)
     387:	b8 16 00 00 00       	mov    $0x16,%eax
     38c:	cd 40                	int    $0x40
     38e:	c3                   	ret    

0000038f <sendMessage>:
SYSCALL(sendMessage)
     38f:	b8 17 00 00 00       	mov    $0x17,%eax
     394:	cd 40                	int    $0x40
     396:	c3                   	ret    

00000397 <getMessage>:
SYSCALL(getMessage)
     397:	b8 19 00 00 00       	mov    $0x19,%eax
     39c:	cd 40                	int    $0x40
     39e:	c3                   	ret    

0000039f <registWindow>:
SYSCALL(registWindow)
     39f:	b8 18 00 00 00       	mov    $0x18,%eax
     3a4:	cd 40                	int    $0x40
     3a6:	c3                   	ret    

000003a7 <changePosition>:
SYSCALL(changePosition)
     3a7:	b8 1a 00 00 00       	mov    $0x1a,%eax
     3ac:	cd 40                	int    $0x40
     3ae:	c3                   	ret    

000003af <setupTimer>:
SYSCALL(setupTimer)
     3af:	b8 1b 00 00 00       	mov    $0x1b,%eax
     3b4:	cd 40                	int    $0x40
     3b6:	c3                   	ret    

000003b7 <deleteTimer>:
SYSCALL(deleteTimer)
     3b7:	b8 1c 00 00 00       	mov    $0x1c,%eax
     3bc:	cd 40                	int    $0x40
     3be:	c3                   	ret    

000003bf <getCurrentTime>:
SYSCALL(getCurrentTime)
     3bf:	b8 1d 00 00 00       	mov    $0x1d,%eax
     3c4:	cd 40                	int    $0x40
     3c6:	c3                   	ret    

000003c7 <removeWindow>:
SYSCALL(removeWindow)
     3c7:	b8 1e 00 00 00       	mov    $0x1e,%eax
     3cc:	cd 40                	int    $0x40
     3ce:	c3                   	ret    

000003cf <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3cf:	55                   	push   %ebp
     3d0:	89 e5                	mov    %esp,%ebp
     3d2:	83 ec 18             	sub    $0x18,%esp
     3d5:	8b 45 0c             	mov    0xc(%ebp),%eax
     3d8:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3db:	83 ec 04             	sub    $0x4,%esp
     3de:	6a 01                	push   $0x1
     3e0:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3e3:	50                   	push   %eax
     3e4:	ff 75 08             	pushl  0x8(%ebp)
     3e7:	e8 1b ff ff ff       	call   307 <write>
     3ec:	83 c4 10             	add    $0x10,%esp
}
     3ef:	90                   	nop
     3f0:	c9                   	leave  
     3f1:	c3                   	ret    

000003f2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3f2:	55                   	push   %ebp
     3f3:	89 e5                	mov    %esp,%ebp
     3f5:	53                   	push   %ebx
     3f6:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3f9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     400:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     404:	74 17                	je     41d <printint+0x2b>
     406:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     40a:	79 11                	jns    41d <printint+0x2b>
    neg = 1;
     40c:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     413:	8b 45 0c             	mov    0xc(%ebp),%eax
     416:	f7 d8                	neg    %eax
     418:	89 45 ec             	mov    %eax,-0x14(%ebp)
     41b:	eb 06                	jmp    423 <printint+0x31>
  } else {
    x = xx;
     41d:	8b 45 0c             	mov    0xc(%ebp),%eax
     420:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     423:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     42a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     42d:	8d 41 01             	lea    0x1(%ecx),%eax
     430:	89 45 f4             	mov    %eax,-0xc(%ebp)
     433:	8b 5d 10             	mov    0x10(%ebp),%ebx
     436:	8b 45 ec             	mov    -0x14(%ebp),%eax
     439:	ba 00 00 00 00       	mov    $0x0,%edx
     43e:	f7 f3                	div    %ebx
     440:	89 d0                	mov    %edx,%eax
     442:	0f b6 80 60 2d 00 00 	movzbl 0x2d60(%eax),%eax
     449:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     44d:	8b 5d 10             	mov    0x10(%ebp),%ebx
     450:	8b 45 ec             	mov    -0x14(%ebp),%eax
     453:	ba 00 00 00 00       	mov    $0x0,%edx
     458:	f7 f3                	div    %ebx
     45a:	89 45 ec             	mov    %eax,-0x14(%ebp)
     45d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     461:	75 c7                	jne    42a <printint+0x38>
  if(neg)
     463:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     467:	74 2d                	je     496 <printint+0xa4>
    buf[i++] = '-';
     469:	8b 45 f4             	mov    -0xc(%ebp),%eax
     46c:	8d 50 01             	lea    0x1(%eax),%edx
     46f:	89 55 f4             	mov    %edx,-0xc(%ebp)
     472:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     477:	eb 1d                	jmp    496 <printint+0xa4>
    putc(fd, buf[i]);
     479:	8d 55 dc             	lea    -0x24(%ebp),%edx
     47c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     47f:	01 d0                	add    %edx,%eax
     481:	0f b6 00             	movzbl (%eax),%eax
     484:	0f be c0             	movsbl %al,%eax
     487:	83 ec 08             	sub    $0x8,%esp
     48a:	50                   	push   %eax
     48b:	ff 75 08             	pushl  0x8(%ebp)
     48e:	e8 3c ff ff ff       	call   3cf <putc>
     493:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     496:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     49a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     49e:	79 d9                	jns    479 <printint+0x87>
    putc(fd, buf[i]);
}
     4a0:	90                   	nop
     4a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4a4:	c9                   	leave  
     4a5:	c3                   	ret    

000004a6 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     4a6:	55                   	push   %ebp
     4a7:	89 e5                	mov    %esp,%ebp
     4a9:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     4ac:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     4b3:	8d 45 0c             	lea    0xc(%ebp),%eax
     4b6:	83 c0 04             	add    $0x4,%eax
     4b9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     4bc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4c3:	e9 59 01 00 00       	jmp    621 <printf+0x17b>
    c = fmt[i] & 0xff;
     4c8:	8b 55 0c             	mov    0xc(%ebp),%edx
     4cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4ce:	01 d0                	add    %edx,%eax
     4d0:	0f b6 00             	movzbl (%eax),%eax
     4d3:	0f be c0             	movsbl %al,%eax
     4d6:	25 ff 00 00 00       	and    $0xff,%eax
     4db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4de:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4e2:	75 2c                	jne    510 <printf+0x6a>
      if(c == '%'){
     4e4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4e8:	75 0c                	jne    4f6 <printf+0x50>
        state = '%';
     4ea:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4f1:	e9 27 01 00 00       	jmp    61d <printf+0x177>
      } else {
        putc(fd, c);
     4f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4f9:	0f be c0             	movsbl %al,%eax
     4fc:	83 ec 08             	sub    $0x8,%esp
     4ff:	50                   	push   %eax
     500:	ff 75 08             	pushl  0x8(%ebp)
     503:	e8 c7 fe ff ff       	call   3cf <putc>
     508:	83 c4 10             	add    $0x10,%esp
     50b:	e9 0d 01 00 00       	jmp    61d <printf+0x177>
      }
    } else if(state == '%'){
     510:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     514:	0f 85 03 01 00 00    	jne    61d <printf+0x177>
      if(c == 'd'){
     51a:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     51e:	75 1e                	jne    53e <printf+0x98>
        printint(fd, *ap, 10, 1);
     520:	8b 45 e8             	mov    -0x18(%ebp),%eax
     523:	8b 00                	mov    (%eax),%eax
     525:	6a 01                	push   $0x1
     527:	6a 0a                	push   $0xa
     529:	50                   	push   %eax
     52a:	ff 75 08             	pushl  0x8(%ebp)
     52d:	e8 c0 fe ff ff       	call   3f2 <printint>
     532:	83 c4 10             	add    $0x10,%esp
        ap++;
     535:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     539:	e9 d8 00 00 00       	jmp    616 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     53e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     542:	74 06                	je     54a <printf+0xa4>
     544:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     548:	75 1e                	jne    568 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     54a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     54d:	8b 00                	mov    (%eax),%eax
     54f:	6a 00                	push   $0x0
     551:	6a 10                	push   $0x10
     553:	50                   	push   %eax
     554:	ff 75 08             	pushl  0x8(%ebp)
     557:	e8 96 fe ff ff       	call   3f2 <printint>
     55c:	83 c4 10             	add    $0x10,%esp
        ap++;
     55f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     563:	e9 ae 00 00 00       	jmp    616 <printf+0x170>
      } else if(c == 's'){
     568:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     56c:	75 43                	jne    5b1 <printf+0x10b>
        s = (char*)*ap;
     56e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     571:	8b 00                	mov    (%eax),%eax
     573:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     576:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     57a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     57e:	75 25                	jne    5a5 <printf+0xff>
          s = "(null)";
     580:	c7 45 f4 0f 26 00 00 	movl   $0x260f,-0xc(%ebp)
        while(*s != 0){
     587:	eb 1c                	jmp    5a5 <printf+0xff>
          putc(fd, *s);
     589:	8b 45 f4             	mov    -0xc(%ebp),%eax
     58c:	0f b6 00             	movzbl (%eax),%eax
     58f:	0f be c0             	movsbl %al,%eax
     592:	83 ec 08             	sub    $0x8,%esp
     595:	50                   	push   %eax
     596:	ff 75 08             	pushl  0x8(%ebp)
     599:	e8 31 fe ff ff       	call   3cf <putc>
     59e:	83 c4 10             	add    $0x10,%esp
          s++;
     5a1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     5a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5a8:	0f b6 00             	movzbl (%eax),%eax
     5ab:	84 c0                	test   %al,%al
     5ad:	75 da                	jne    589 <printf+0xe3>
     5af:	eb 65                	jmp    616 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     5b1:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     5b5:	75 1d                	jne    5d4 <printf+0x12e>
        putc(fd, *ap);
     5b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5ba:	8b 00                	mov    (%eax),%eax
     5bc:	0f be c0             	movsbl %al,%eax
     5bf:	83 ec 08             	sub    $0x8,%esp
     5c2:	50                   	push   %eax
     5c3:	ff 75 08             	pushl  0x8(%ebp)
     5c6:	e8 04 fe ff ff       	call   3cf <putc>
     5cb:	83 c4 10             	add    $0x10,%esp
        ap++;
     5ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5d2:	eb 42                	jmp    616 <printf+0x170>
      } else if(c == '%'){
     5d4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5d8:	75 17                	jne    5f1 <printf+0x14b>
        putc(fd, c);
     5da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5dd:	0f be c0             	movsbl %al,%eax
     5e0:	83 ec 08             	sub    $0x8,%esp
     5e3:	50                   	push   %eax
     5e4:	ff 75 08             	pushl  0x8(%ebp)
     5e7:	e8 e3 fd ff ff       	call   3cf <putc>
     5ec:	83 c4 10             	add    $0x10,%esp
     5ef:	eb 25                	jmp    616 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5f1:	83 ec 08             	sub    $0x8,%esp
     5f4:	6a 25                	push   $0x25
     5f6:	ff 75 08             	pushl  0x8(%ebp)
     5f9:	e8 d1 fd ff ff       	call   3cf <putc>
     5fe:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     601:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     604:	0f be c0             	movsbl %al,%eax
     607:	83 ec 08             	sub    $0x8,%esp
     60a:	50                   	push   %eax
     60b:	ff 75 08             	pushl  0x8(%ebp)
     60e:	e8 bc fd ff ff       	call   3cf <putc>
     613:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     616:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     61d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     621:	8b 55 0c             	mov    0xc(%ebp),%edx
     624:	8b 45 f0             	mov    -0x10(%ebp),%eax
     627:	01 d0                	add    %edx,%eax
     629:	0f b6 00             	movzbl (%eax),%eax
     62c:	84 c0                	test   %al,%al
     62e:	0f 85 94 fe ff ff    	jne    4c8 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     634:	90                   	nop
     635:	c9                   	leave  
     636:	c3                   	ret    

00000637 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     637:	55                   	push   %ebp
     638:	89 e5                	mov    %esp,%ebp
     63a:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     63d:	8b 45 08             	mov    0x8(%ebp),%eax
     640:	83 e8 08             	sub    $0x8,%eax
     643:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     646:	a1 c0 69 00 00       	mov    0x69c0,%eax
     64b:	89 45 fc             	mov    %eax,-0x4(%ebp)
     64e:	eb 24                	jmp    674 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     650:	8b 45 fc             	mov    -0x4(%ebp),%eax
     653:	8b 00                	mov    (%eax),%eax
     655:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     658:	77 12                	ja     66c <free+0x35>
     65a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     65d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     660:	77 24                	ja     686 <free+0x4f>
     662:	8b 45 fc             	mov    -0x4(%ebp),%eax
     665:	8b 00                	mov    (%eax),%eax
     667:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     66a:	77 1a                	ja     686 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     66c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66f:	8b 00                	mov    (%eax),%eax
     671:	89 45 fc             	mov    %eax,-0x4(%ebp)
     674:	8b 45 f8             	mov    -0x8(%ebp),%eax
     677:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     67a:	76 d4                	jbe    650 <free+0x19>
     67c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67f:	8b 00                	mov    (%eax),%eax
     681:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     684:	76 ca                	jbe    650 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     686:	8b 45 f8             	mov    -0x8(%ebp),%eax
     689:	8b 40 04             	mov    0x4(%eax),%eax
     68c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     693:	8b 45 f8             	mov    -0x8(%ebp),%eax
     696:	01 c2                	add    %eax,%edx
     698:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69b:	8b 00                	mov    (%eax),%eax
     69d:	39 c2                	cmp    %eax,%edx
     69f:	75 24                	jne    6c5 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     6a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a4:	8b 50 04             	mov    0x4(%eax),%edx
     6a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6aa:	8b 00                	mov    (%eax),%eax
     6ac:	8b 40 04             	mov    0x4(%eax),%eax
     6af:	01 c2                	add    %eax,%edx
     6b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b4:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ba:	8b 00                	mov    (%eax),%eax
     6bc:	8b 10                	mov    (%eax),%edx
     6be:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c1:	89 10                	mov    %edx,(%eax)
     6c3:	eb 0a                	jmp    6cf <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     6c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c8:	8b 10                	mov    (%eax),%edx
     6ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6cd:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d2:	8b 40 04             	mov    0x4(%eax),%eax
     6d5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6df:	01 d0                	add    %edx,%eax
     6e1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6e4:	75 20                	jne    706 <free+0xcf>
    p->s.size += bp->s.size;
     6e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e9:	8b 50 04             	mov    0x4(%eax),%edx
     6ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ef:	8b 40 04             	mov    0x4(%eax),%eax
     6f2:	01 c2                	add    %eax,%edx
     6f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f7:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6fd:	8b 10                	mov    (%eax),%edx
     6ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
     702:	89 10                	mov    %edx,(%eax)
     704:	eb 08                	jmp    70e <free+0xd7>
  } else
    p->s.ptr = bp;
     706:	8b 45 fc             	mov    -0x4(%ebp),%eax
     709:	8b 55 f8             	mov    -0x8(%ebp),%edx
     70c:	89 10                	mov    %edx,(%eax)
  freep = p;
     70e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     711:	a3 c0 69 00 00       	mov    %eax,0x69c0
}
     716:	90                   	nop
     717:	c9                   	leave  
     718:	c3                   	ret    

00000719 <morecore>:

static Header*
morecore(uint nu)
{
     719:	55                   	push   %ebp
     71a:	89 e5                	mov    %esp,%ebp
     71c:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     71f:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     726:	77 07                	ja     72f <morecore+0x16>
    nu = 4096;
     728:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     72f:	8b 45 08             	mov    0x8(%ebp),%eax
     732:	c1 e0 03             	shl    $0x3,%eax
     735:	83 ec 0c             	sub    $0xc,%esp
     738:	50                   	push   %eax
     739:	e8 31 fc ff ff       	call   36f <sbrk>
     73e:	83 c4 10             	add    $0x10,%esp
     741:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     744:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     748:	75 07                	jne    751 <morecore+0x38>
    return 0;
     74a:	b8 00 00 00 00       	mov    $0x0,%eax
     74f:	eb 26                	jmp    777 <morecore+0x5e>
  hp = (Header*)p;
     751:	8b 45 f4             	mov    -0xc(%ebp),%eax
     754:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     757:	8b 45 f0             	mov    -0x10(%ebp),%eax
     75a:	8b 55 08             	mov    0x8(%ebp),%edx
     75d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     760:	8b 45 f0             	mov    -0x10(%ebp),%eax
     763:	83 c0 08             	add    $0x8,%eax
     766:	83 ec 0c             	sub    $0xc,%esp
     769:	50                   	push   %eax
     76a:	e8 c8 fe ff ff       	call   637 <free>
     76f:	83 c4 10             	add    $0x10,%esp
  return freep;
     772:	a1 c0 69 00 00       	mov    0x69c0,%eax
}
     777:	c9                   	leave  
     778:	c3                   	ret    

00000779 <malloc>:

void*
malloc(uint nbytes)
{
     779:	55                   	push   %ebp
     77a:	89 e5                	mov    %esp,%ebp
     77c:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     77f:	8b 45 08             	mov    0x8(%ebp),%eax
     782:	83 c0 07             	add    $0x7,%eax
     785:	c1 e8 03             	shr    $0x3,%eax
     788:	83 c0 01             	add    $0x1,%eax
     78b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     78e:	a1 c0 69 00 00       	mov    0x69c0,%eax
     793:	89 45 f0             	mov    %eax,-0x10(%ebp)
     796:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     79a:	75 23                	jne    7bf <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     79c:	c7 45 f0 b8 69 00 00 	movl   $0x69b8,-0x10(%ebp)
     7a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7a6:	a3 c0 69 00 00       	mov    %eax,0x69c0
     7ab:	a1 c0 69 00 00       	mov    0x69c0,%eax
     7b0:	a3 b8 69 00 00       	mov    %eax,0x69b8
    base.s.size = 0;
     7b5:	c7 05 bc 69 00 00 00 	movl   $0x0,0x69bc
     7bc:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7c2:	8b 00                	mov    (%eax),%eax
     7c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ca:	8b 40 04             	mov    0x4(%eax),%eax
     7cd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7d0:	72 4d                	jb     81f <malloc+0xa6>
      if(p->s.size == nunits)
     7d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d5:	8b 40 04             	mov    0x4(%eax),%eax
     7d8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7db:	75 0c                	jne    7e9 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e0:	8b 10                	mov    (%eax),%edx
     7e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e5:	89 10                	mov    %edx,(%eax)
     7e7:	eb 26                	jmp    80f <malloc+0x96>
      else {
        p->s.size -= nunits;
     7e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ec:	8b 40 04             	mov    0x4(%eax),%eax
     7ef:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7f2:	89 c2                	mov    %eax,%edx
     7f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7fd:	8b 40 04             	mov    0x4(%eax),%eax
     800:	c1 e0 03             	shl    $0x3,%eax
     803:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     806:	8b 45 f4             	mov    -0xc(%ebp),%eax
     809:	8b 55 ec             	mov    -0x14(%ebp),%edx
     80c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     80f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     812:	a3 c0 69 00 00       	mov    %eax,0x69c0
      return (void*)(p + 1);
     817:	8b 45 f4             	mov    -0xc(%ebp),%eax
     81a:	83 c0 08             	add    $0x8,%eax
     81d:	eb 3b                	jmp    85a <malloc+0xe1>
    }
    if(p == freep)
     81f:	a1 c0 69 00 00       	mov    0x69c0,%eax
     824:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     827:	75 1e                	jne    847 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     829:	83 ec 0c             	sub    $0xc,%esp
     82c:	ff 75 ec             	pushl  -0x14(%ebp)
     82f:	e8 e5 fe ff ff       	call   719 <morecore>
     834:	83 c4 10             	add    $0x10,%esp
     837:	89 45 f4             	mov    %eax,-0xc(%ebp)
     83a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     83e:	75 07                	jne    847 <malloc+0xce>
        return 0;
     840:	b8 00 00 00 00       	mov    $0x0,%eax
     845:	eb 13                	jmp    85a <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     847:	8b 45 f4             	mov    -0xc(%ebp),%eax
     84a:	89 45 f0             	mov    %eax,-0x10(%ebp)
     84d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     850:	8b 00                	mov    (%eax),%eax
     852:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     855:	e9 6d ff ff ff       	jmp    7c7 <malloc+0x4e>
}
     85a:	c9                   	leave  
     85b:	c3                   	ret    

0000085c <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     85c:	55                   	push   %ebp
     85d:	89 e5                	mov    %esp,%ebp
     85f:	83 ec 1c             	sub    $0x1c,%esp
     862:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     865:	8b 55 10             	mov    0x10(%ebp),%edx
     868:	8b 45 14             	mov    0x14(%ebp),%eax
     86b:	88 4d ec             	mov    %cl,-0x14(%ebp)
     86e:	88 55 e8             	mov    %dl,-0x18(%ebp)
     871:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     874:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     878:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     87b:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     87f:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     882:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     886:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     889:	8b 45 08             	mov    0x8(%ebp),%eax
     88c:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     890:	66 89 10             	mov    %dx,(%eax)
     893:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     897:	88 50 02             	mov    %dl,0x2(%eax)
}
     89a:	8b 45 08             	mov    0x8(%ebp),%eax
     89d:	c9                   	leave  
     89e:	c2 04 00             	ret    $0x4

000008a1 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     8a1:	55                   	push   %ebp
     8a2:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     8a4:	8b 45 08             	mov    0x8(%ebp),%eax
     8a7:	2b 45 10             	sub    0x10(%ebp),%eax
     8aa:	89 c2                	mov    %eax,%edx
     8ac:	8b 45 08             	mov    0x8(%ebp),%eax
     8af:	2b 45 10             	sub    0x10(%ebp),%eax
     8b2:	0f af d0             	imul   %eax,%edx
     8b5:	8b 45 0c             	mov    0xc(%ebp),%eax
     8b8:	2b 45 14             	sub    0x14(%ebp),%eax
     8bb:	89 c1                	mov    %eax,%ecx
     8bd:	8b 45 0c             	mov    0xc(%ebp),%eax
     8c0:	2b 45 14             	sub    0x14(%ebp),%eax
     8c3:	0f af c1             	imul   %ecx,%eax
     8c6:	01 d0                	add    %edx,%eax
}
     8c8:	5d                   	pop    %ebp
     8c9:	c3                   	ret    

000008ca <abs_int>:

static inline int abs_int(int x)
{
     8ca:	55                   	push   %ebp
     8cb:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     8cd:	8b 45 08             	mov    0x8(%ebp),%eax
     8d0:	99                   	cltd   
     8d1:	89 d0                	mov    %edx,%eax
     8d3:	33 45 08             	xor    0x8(%ebp),%eax
     8d6:	29 d0                	sub    %edx,%eax
}
     8d8:	5d                   	pop    %ebp
     8d9:	c3                   	ret    

000008da <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     8da:	55                   	push   %ebp
     8db:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     8dd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8e1:	79 07                	jns    8ea <APGetIndex+0x10>
        return X_SMALLER;
     8e3:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8e8:	eb 40                	jmp    92a <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8ea:	8b 45 08             	mov    0x8(%ebp),%eax
     8ed:	8b 00                	mov    (%eax),%eax
     8ef:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8f2:	7f 07                	jg     8fb <APGetIndex+0x21>
        return X_BIGGER;
     8f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8f9:	eb 2f                	jmp    92a <APGetIndex+0x50>
    if (y < 0)
     8fb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8ff:	79 07                	jns    908 <APGetIndex+0x2e>
        return Y_SMALLER;
     901:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     906:	eb 22                	jmp    92a <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     908:	8b 45 08             	mov    0x8(%ebp),%eax
     90b:	8b 40 04             	mov    0x4(%eax),%eax
     90e:	3b 45 10             	cmp    0x10(%ebp),%eax
     911:	7f 07                	jg     91a <APGetIndex+0x40>
        return Y_BIGGER;
     913:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     918:	eb 10                	jmp    92a <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     91a:	8b 45 08             	mov    0x8(%ebp),%eax
     91d:	8b 00                	mov    (%eax),%eax
     91f:	0f af 45 10          	imul   0x10(%ebp),%eax
     923:	89 c2                	mov    %eax,%edx
     925:	8b 45 0c             	mov    0xc(%ebp),%eax
     928:	01 d0                	add    %edx,%eax
}
     92a:	5d                   	pop    %ebp
     92b:	c3                   	ret    

0000092c <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     92c:	55                   	push   %ebp
     92d:	89 e5                	mov    %esp,%ebp
     92f:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     932:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     939:	8b 45 cc             	mov    -0x34(%ebp),%eax
     93c:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     93f:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     946:	83 ec 08             	sub    $0x8,%esp
     949:	6a 00                	push   $0x0
     94b:	ff 75 0c             	pushl  0xc(%ebp)
     94e:	e8 d4 f9 ff ff       	call   327 <open>
     953:	83 c4 10             	add    $0x10,%esp
     956:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     959:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     95d:	79 2e                	jns    98d <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     95f:	83 ec 04             	sub    $0x4,%esp
     962:	ff 75 0c             	pushl  0xc(%ebp)
     965:	68 16 26 00 00       	push   $0x2616
     96a:	6a 01                	push   $0x1
     96c:	e8 35 fb ff ff       	call   4a6 <printf>
     971:	83 c4 10             	add    $0x10,%esp
        return bmp;
     974:	8b 45 08             	mov    0x8(%ebp),%eax
     977:	8b 55 c8             	mov    -0x38(%ebp),%edx
     97a:	89 10                	mov    %edx,(%eax)
     97c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     97f:	89 50 04             	mov    %edx,0x4(%eax)
     982:	8b 55 d0             	mov    -0x30(%ebp),%edx
     985:	89 50 08             	mov    %edx,0x8(%eax)
     988:	e9 d2 01 00 00       	jmp    b5f <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     98d:	83 ec 04             	sub    $0x4,%esp
     990:	6a 0e                	push   $0xe
     992:	8d 45 ba             	lea    -0x46(%ebp),%eax
     995:	50                   	push   %eax
     996:	ff 75 ec             	pushl  -0x14(%ebp)
     999:	e8 61 f9 ff ff       	call   2ff <read>
     99e:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     9a1:	83 ec 04             	sub    $0x4,%esp
     9a4:	6a 28                	push   $0x28
     9a6:	8d 45 92             	lea    -0x6e(%ebp),%eax
     9a9:	50                   	push   %eax
     9aa:	ff 75 ec             	pushl  -0x14(%ebp)
     9ad:	e8 4d f9 ff ff       	call   2ff <read>
     9b2:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     9b5:	8b 45 96             	mov    -0x6a(%ebp),%eax
     9b8:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     9bb:	8b 45 9a             	mov    -0x66(%ebp),%eax
     9be:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     9c1:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9c4:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9c7:	0f af d0             	imul   %eax,%edx
     9ca:	89 d0                	mov    %edx,%eax
     9cc:	01 c0                	add    %eax,%eax
     9ce:	01 d0                	add    %edx,%eax
     9d0:	83 ec 0c             	sub    $0xc,%esp
     9d3:	50                   	push   %eax
     9d4:	e8 a0 fd ff ff       	call   779 <malloc>
     9d9:	83 c4 10             	add    $0x10,%esp
     9dc:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9df:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9e3:	0f b7 c0             	movzwl %ax,%eax
     9e6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9e9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9ef:	0f af c2             	imul   %edx,%eax
     9f2:	83 c0 1f             	add    $0x1f,%eax
     9f5:	c1 e8 05             	shr    $0x5,%eax
     9f8:	c1 e0 02             	shl    $0x2,%eax
     9fb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9fe:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a04:	0f af c2             	imul   %edx,%eax
     a07:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     a0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a0d:	83 ec 0c             	sub    $0xc,%esp
     a10:	50                   	push   %eax
     a11:	e8 63 fd ff ff       	call   779 <malloc>
     a16:	83 c4 10             	add    $0x10,%esp
     a19:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a1c:	83 ec 04             	sub    $0x4,%esp
     a1f:	ff 75 e0             	pushl  -0x20(%ebp)
     a22:	ff 75 dc             	pushl  -0x24(%ebp)
     a25:	ff 75 ec             	pushl  -0x14(%ebp)
     a28:	e8 d2 f8 ff ff       	call   2ff <read>
     a2d:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a30:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a34:	66 c1 e8 03          	shr    $0x3,%ax
     a38:	0f b7 c0             	movzwl %ax,%eax
     a3b:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a3e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a45:	e9 e5 00 00 00       	jmp    b2f <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a4a:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a50:	29 c2                	sub    %eax,%edx
     a52:	89 d0                	mov    %edx,%eax
     a54:	8d 50 ff             	lea    -0x1(%eax),%edx
     a57:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a5a:	0f af c2             	imul   %edx,%eax
     a5d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a60:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a67:	e9 b1 00 00 00       	jmp    b1d <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
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
     a98:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a9b:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a9e:	01 c8                	add    %ecx,%eax
     aa0:	0f b6 00             	movzbl (%eax),%eax
     aa3:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     aa6:	8b 55 d0             	mov    -0x30(%ebp),%edx
     aa9:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     aac:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aaf:	01 c8                	add    %ecx,%eax
     ab1:	89 c1                	mov    %eax,%ecx
     ab3:	89 c8                	mov    %ecx,%eax
     ab5:	01 c0                	add    %eax,%eax
     ab7:	01 c8                	add    %ecx,%eax
     ab9:	01 c2                	add    %eax,%edx
     abb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     abe:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ac2:	89 c1                	mov    %eax,%ecx
     ac4:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ac7:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     acb:	01 c1                	add    %eax,%ecx
     acd:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ad0:	01 c8                	add    %ecx,%eax
     ad2:	8d 48 fe             	lea    -0x2(%eax),%ecx
     ad5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ad8:	01 c8                	add    %ecx,%eax
     ada:	0f b6 00             	movzbl (%eax),%eax
     add:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     ae0:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ae3:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ae6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ae9:	01 c8                	add    %ecx,%eax
     aeb:	89 c1                	mov    %eax,%ecx
     aed:	89 c8                	mov    %ecx,%eax
     aef:	01 c0                	add    %eax,%eax
     af1:	01 c8                	add    %ecx,%eax
     af3:	01 c2                	add    %eax,%edx
     af5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af8:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     afc:	89 c1                	mov    %eax,%ecx
     afe:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b01:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b05:	01 c1                	add    %eax,%ecx
     b07:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b0a:	01 c8                	add    %ecx,%eax
     b0c:	8d 48 fd             	lea    -0x3(%eax),%ecx
     b0f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b12:	01 c8                	add    %ecx,%eax
     b14:	0f b6 00             	movzbl (%eax),%eax
     b17:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     b19:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b1d:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b20:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b23:	39 c2                	cmp    %eax,%edx
     b25:	0f 87 41 ff ff ff    	ja     a6c <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b2b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b2f:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b32:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b35:	39 c2                	cmp    %eax,%edx
     b37:	0f 87 0d ff ff ff    	ja     a4a <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b3d:	83 ec 0c             	sub    $0xc,%esp
     b40:	ff 75 ec             	pushl  -0x14(%ebp)
     b43:	e8 c7 f7 ff ff       	call   30f <close>
     b48:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b4b:	8b 45 08             	mov    0x8(%ebp),%eax
     b4e:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b51:	89 10                	mov    %edx,(%eax)
     b53:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b56:	89 50 04             	mov    %edx,0x4(%eax)
     b59:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b5c:	89 50 08             	mov    %edx,0x8(%eax)
}
     b5f:	8b 45 08             	mov    0x8(%ebp),%eax
     b62:	c9                   	leave  
     b63:	c2 04 00             	ret    $0x4

00000b66 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b66:	55                   	push   %ebp
     b67:	89 e5                	mov    %esp,%ebp
     b69:	53                   	push   %ebx
     b6a:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b6d:	83 ec 0c             	sub    $0xc,%esp
     b70:	6a 1c                	push   $0x1c
     b72:	e8 02 fc ff ff       	call   779 <malloc>
     b77:	83 c4 10             	add    $0x10,%esp
     b7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b80:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b87:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b8a:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b8d:	6a 0c                	push   $0xc
     b8f:	6a 0c                	push   $0xc
     b91:	6a 0c                	push   $0xc
     b93:	50                   	push   %eax
     b94:	e8 c3 fc ff ff       	call   85c <RGB>
     b99:	83 c4 0c             	add    $0xc,%esp
     b9c:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     ba0:	66 89 43 13          	mov    %ax,0x13(%ebx)
     ba4:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     ba8:	88 43 15             	mov    %al,0x15(%ebx)
     bab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bae:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bb1:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     bb5:	66 89 48 10          	mov    %cx,0x10(%eax)
     bb9:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     bbd:	88 50 12             	mov    %dl,0x12(%eax)
     bc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc3:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bc6:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     bca:	66 89 48 08          	mov    %cx,0x8(%eax)
     bce:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     bd2:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     bd5:	8b 45 08             	mov    0x8(%ebp),%eax
     bd8:	89 c2                	mov    %eax,%edx
     bda:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bdd:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     bdf:	8b 45 0c             	mov    0xc(%ebp),%eax
     be2:	89 c2                	mov    %eax,%edx
     be4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     be7:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bea:	8b 55 10             	mov    0x10(%ebp),%edx
     bed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bf0:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     bf3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bf6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bf9:	c9                   	leave  
     bfa:	c3                   	ret    

00000bfb <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     bfb:	55                   	push   %ebp
     bfc:	89 e5                	mov    %esp,%ebp
     bfe:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     c01:	8b 45 0c             	mov    0xc(%ebp),%eax
     c04:	8b 50 08             	mov    0x8(%eax),%edx
     c07:	89 55 f8             	mov    %edx,-0x8(%ebp)
     c0a:	8b 40 0c             	mov    0xc(%eax),%eax
     c0d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     c10:	8b 45 0c             	mov    0xc(%ebp),%eax
     c13:	8b 55 10             	mov    0x10(%ebp),%edx
     c16:	89 50 08             	mov    %edx,0x8(%eax)
     c19:	8b 55 14             	mov    0x14(%ebp),%edx
     c1c:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c1f:	8b 45 08             	mov    0x8(%ebp),%eax
     c22:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c25:	89 10                	mov    %edx,(%eax)
     c27:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c2a:	89 50 04             	mov    %edx,0x4(%eax)
}
     c2d:	8b 45 08             	mov    0x8(%ebp),%eax
     c30:	c9                   	leave  
     c31:	c2 04 00             	ret    $0x4

00000c34 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c34:	55                   	push   %ebp
     c35:	89 e5                	mov    %esp,%ebp
     c37:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c3a:	8b 45 0c             	mov    0xc(%ebp),%eax
     c3d:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c41:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c45:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c49:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c4c:	8b 45 0c             	mov    0xc(%ebp),%eax
     c4f:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c53:	66 89 50 10          	mov    %dx,0x10(%eax)
     c57:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c5b:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c5e:	8b 45 08             	mov    0x8(%ebp),%eax
     c61:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c65:	66 89 10             	mov    %dx,(%eax)
     c68:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c6c:	88 50 02             	mov    %dl,0x2(%eax)
}
     c6f:	8b 45 08             	mov    0x8(%ebp),%eax
     c72:	c9                   	leave  
     c73:	c2 04 00             	ret    $0x4

00000c76 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     c76:	55                   	push   %ebp
     c77:	89 e5                	mov    %esp,%ebp
     c79:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     c7c:	8b 45 0c             	mov    0xc(%ebp),%eax
     c7f:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     c83:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c87:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     c8b:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     c8e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c91:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c95:	66 89 50 13          	mov    %dx,0x13(%eax)
     c99:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c9d:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     ca0:	8b 45 08             	mov    0x8(%ebp),%eax
     ca3:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     ca7:	66 89 10             	mov    %dx,(%eax)
     caa:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     cae:	88 50 02             	mov    %dl,0x2(%eax)
}
     cb1:	8b 45 08             	mov    0x8(%ebp),%eax
     cb4:	c9                   	leave  
     cb5:	c2 04 00             	ret    $0x4

00000cb8 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     cb8:	55                   	push   %ebp
     cb9:	89 e5                	mov    %esp,%ebp
     cbb:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     cbe:	8b 45 08             	mov    0x8(%ebp),%eax
     cc1:	8b 40 0c             	mov    0xc(%eax),%eax
     cc4:	89 c2                	mov    %eax,%edx
     cc6:	c1 ea 1f             	shr    $0x1f,%edx
     cc9:	01 d0                	add    %edx,%eax
     ccb:	d1 f8                	sar    %eax
     ccd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     cd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cd3:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     cd7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     cda:	8b 45 10             	mov    0x10(%ebp),%eax
     cdd:	2b 45 f4             	sub    -0xc(%ebp),%eax
     ce0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     ce3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     ce7:	0f 89 98 00 00 00    	jns    d85 <APDrawPoint+0xcd>
        i = 0;
     ced:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     cf4:	e9 8c 00 00 00       	jmp    d85 <APDrawPoint+0xcd>
    {
        j = x - off;
     cf9:	8b 45 0c             	mov    0xc(%ebp),%eax
     cfc:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cff:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d02:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d06:	79 69                	jns    d71 <APDrawPoint+0xb9>
            j = 0;
     d08:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d0f:	eb 60                	jmp    d71 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d11:	ff 75 fc             	pushl  -0x4(%ebp)
     d14:	ff 75 f8             	pushl  -0x8(%ebp)
     d17:	ff 75 08             	pushl  0x8(%ebp)
     d1a:	e8 bb fb ff ff       	call   8da <APGetIndex>
     d1f:	83 c4 0c             	add    $0xc,%esp
     d22:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d25:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d29:	74 55                	je     d80 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d2b:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d2f:	74 67                	je     d98 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d31:	ff 75 10             	pushl  0x10(%ebp)
     d34:	ff 75 0c             	pushl  0xc(%ebp)
     d37:	ff 75 fc             	pushl  -0x4(%ebp)
     d3a:	ff 75 f8             	pushl  -0x8(%ebp)
     d3d:	e8 5f fb ff ff       	call   8a1 <distance_2>
     d42:	83 c4 10             	add    $0x10,%esp
     d45:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d48:	7f 23                	jg     d6d <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d4a:	8b 45 08             	mov    0x8(%ebp),%eax
     d4d:	8b 48 18             	mov    0x18(%eax),%ecx
     d50:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d53:	89 d0                	mov    %edx,%eax
     d55:	01 c0                	add    %eax,%eax
     d57:	01 d0                	add    %edx,%eax
     d59:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d5c:	8b 45 08             	mov    0x8(%ebp),%eax
     d5f:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d63:	66 89 0a             	mov    %cx,(%edx)
     d66:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d6a:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d6d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d71:	8b 55 0c             	mov    0xc(%ebp),%edx
     d74:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d77:	01 d0                	add    %edx,%eax
     d79:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d7c:	7d 93                	jge    d11 <APDrawPoint+0x59>
     d7e:	eb 01                	jmp    d81 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d80:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d81:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d85:	8b 55 10             	mov    0x10(%ebp),%edx
     d88:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d8b:	01 d0                	add    %edx,%eax
     d8d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d90:	0f 8d 63 ff ff ff    	jge    cf9 <APDrawPoint+0x41>
     d96:	eb 01                	jmp    d99 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d98:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d99:	c9                   	leave  
     d9a:	c3                   	ret    

00000d9b <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d9b:	55                   	push   %ebp
     d9c:	89 e5                	mov    %esp,%ebp
     d9e:	53                   	push   %ebx
     d9f:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     da2:	8b 45 0c             	mov    0xc(%ebp),%eax
     da5:	3b 45 14             	cmp    0x14(%ebp),%eax
     da8:	0f 85 80 00 00 00    	jne    e2e <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     dae:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     db2:	0f 88 9d 02 00 00    	js     1055 <APDrawLine+0x2ba>
     db8:	8b 45 08             	mov    0x8(%ebp),%eax
     dbb:	8b 00                	mov    (%eax),%eax
     dbd:	3b 45 0c             	cmp    0xc(%ebp),%eax
     dc0:	0f 8e 8f 02 00 00    	jle    1055 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     dc6:	8b 45 10             	mov    0x10(%ebp),%eax
     dc9:	3b 45 18             	cmp    0x18(%ebp),%eax
     dcc:	7e 12                	jle    de0 <APDrawLine+0x45>
        {
            int tmp = y2;
     dce:	8b 45 18             	mov    0x18(%ebp),%eax
     dd1:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     dd4:	8b 45 10             	mov    0x10(%ebp),%eax
     dd7:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     dda:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ddd:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     de0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     de4:	79 07                	jns    ded <APDrawLine+0x52>
     de6:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     ded:	8b 45 08             	mov    0x8(%ebp),%eax
     df0:	8b 40 04             	mov    0x4(%eax),%eax
     df3:	3b 45 18             	cmp    0x18(%ebp),%eax
     df6:	7d 0c                	jge    e04 <APDrawLine+0x69>
     df8:	8b 45 08             	mov    0x8(%ebp),%eax
     dfb:	8b 40 04             	mov    0x4(%eax),%eax
     dfe:	83 e8 01             	sub    $0x1,%eax
     e01:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e04:	8b 45 10             	mov    0x10(%ebp),%eax
     e07:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e0a:	eb 15                	jmp    e21 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e0c:	ff 75 f4             	pushl  -0xc(%ebp)
     e0f:	ff 75 0c             	pushl  0xc(%ebp)
     e12:	ff 75 08             	pushl  0x8(%ebp)
     e15:	e8 9e fe ff ff       	call   cb8 <APDrawPoint>
     e1a:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e1d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e21:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e24:	3b 45 18             	cmp    0x18(%ebp),%eax
     e27:	7e e3                	jle    e0c <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e29:	e9 2b 02 00 00       	jmp    1059 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e2e:	8b 45 10             	mov    0x10(%ebp),%eax
     e31:	3b 45 18             	cmp    0x18(%ebp),%eax
     e34:	75 7f                	jne    eb5 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e36:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e3a:	0f 88 18 02 00 00    	js     1058 <APDrawLine+0x2bd>
     e40:	8b 45 08             	mov    0x8(%ebp),%eax
     e43:	8b 40 04             	mov    0x4(%eax),%eax
     e46:	3b 45 10             	cmp    0x10(%ebp),%eax
     e49:	0f 8e 09 02 00 00    	jle    1058 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e4f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e52:	3b 45 14             	cmp    0x14(%ebp),%eax
     e55:	7e 12                	jle    e69 <APDrawLine+0xce>
        {
            int tmp = x2;
     e57:	8b 45 14             	mov    0x14(%ebp),%eax
     e5a:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e5d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e60:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e63:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e66:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e69:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e6d:	79 07                	jns    e76 <APDrawLine+0xdb>
     e6f:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e76:	8b 45 08             	mov    0x8(%ebp),%eax
     e79:	8b 00                	mov    (%eax),%eax
     e7b:	3b 45 14             	cmp    0x14(%ebp),%eax
     e7e:	7d 0b                	jge    e8b <APDrawLine+0xf0>
     e80:	8b 45 08             	mov    0x8(%ebp),%eax
     e83:	8b 00                	mov    (%eax),%eax
     e85:	83 e8 01             	sub    $0x1,%eax
     e88:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e8b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e91:	eb 15                	jmp    ea8 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e93:	ff 75 10             	pushl  0x10(%ebp)
     e96:	ff 75 f0             	pushl  -0x10(%ebp)
     e99:	ff 75 08             	pushl  0x8(%ebp)
     e9c:	e8 17 fe ff ff       	call   cb8 <APDrawPoint>
     ea1:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     ea4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ea8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     eab:	3b 45 14             	cmp    0x14(%ebp),%eax
     eae:	7e e3                	jle    e93 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     eb0:	e9 a4 01 00 00       	jmp    1059 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     eb5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     ebc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     ec3:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec6:	2b 45 14             	sub    0x14(%ebp),%eax
     ec9:	50                   	push   %eax
     eca:	e8 fb f9 ff ff       	call   8ca <abs_int>
     ecf:	83 c4 04             	add    $0x4,%esp
     ed2:	89 c3                	mov    %eax,%ebx
     ed4:	8b 45 10             	mov    0x10(%ebp),%eax
     ed7:	2b 45 18             	sub    0x18(%ebp),%eax
     eda:	50                   	push   %eax
     edb:	e8 ea f9 ff ff       	call   8ca <abs_int>
     ee0:	83 c4 04             	add    $0x4,%esp
     ee3:	39 c3                	cmp    %eax,%ebx
     ee5:	0f 8e b5 00 00 00    	jle    fa0 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     eeb:	8b 45 10             	mov    0x10(%ebp),%eax
     eee:	2b 45 18             	sub    0x18(%ebp),%eax
     ef1:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ef4:	db 45 b0             	fildl  -0x50(%ebp)
     ef7:	8b 45 0c             	mov    0xc(%ebp),%eax
     efa:	2b 45 14             	sub    0x14(%ebp),%eax
     efd:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f00:	db 45 b0             	fildl  -0x50(%ebp)
     f03:	de f9                	fdivrp %st,%st(1)
     f05:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f08:	8b 45 14             	mov    0x14(%ebp),%eax
     f0b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f0e:	7e 0e                	jle    f1e <APDrawLine+0x183>
        {
            s = x1;
     f10:	8b 45 0c             	mov    0xc(%ebp),%eax
     f13:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f16:	8b 45 14             	mov    0x14(%ebp),%eax
     f19:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f1c:	eb 0c                	jmp    f2a <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f1e:	8b 45 14             	mov    0x14(%ebp),%eax
     f21:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f24:	8b 45 0c             	mov    0xc(%ebp),%eax
     f27:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f2a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f2e:	79 07                	jns    f37 <APDrawLine+0x19c>
     f30:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f37:	8b 45 08             	mov    0x8(%ebp),%eax
     f3a:	8b 00                	mov    (%eax),%eax
     f3c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f3f:	7f 0b                	jg     f4c <APDrawLine+0x1b1>
     f41:	8b 45 08             	mov    0x8(%ebp),%eax
     f44:	8b 00                	mov    (%eax),%eax
     f46:	83 e8 01             	sub    $0x1,%eax
     f49:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f4f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f52:	eb 3f                	jmp    f93 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f54:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f57:	2b 45 0c             	sub    0xc(%ebp),%eax
     f5a:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f5d:	db 45 b0             	fildl  -0x50(%ebp)
     f60:	dc 4d d0             	fmull  -0x30(%ebp)
     f63:	db 45 10             	fildl  0x10(%ebp)
     f66:	de c1                	faddp  %st,%st(1)
     f68:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f6b:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f6f:	b4 0c                	mov    $0xc,%ah
     f71:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f75:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f78:	db 5d cc             	fistpl -0x34(%ebp)
     f7b:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f7e:	ff 75 cc             	pushl  -0x34(%ebp)
     f81:	ff 75 e4             	pushl  -0x1c(%ebp)
     f84:	ff 75 08             	pushl  0x8(%ebp)
     f87:	e8 2c fd ff ff       	call   cb8 <APDrawPoint>
     f8c:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f8f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f93:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f96:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f99:	7e b9                	jle    f54 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f9b:	e9 b9 00 00 00       	jmp    1059 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     fa0:	8b 45 0c             	mov    0xc(%ebp),%eax
     fa3:	2b 45 14             	sub    0x14(%ebp),%eax
     fa6:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fa9:	db 45 b0             	fildl  -0x50(%ebp)
     fac:	8b 45 10             	mov    0x10(%ebp),%eax
     faf:	2b 45 18             	sub    0x18(%ebp),%eax
     fb2:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fb5:	db 45 b0             	fildl  -0x50(%ebp)
     fb8:	de f9                	fdivrp %st,%st(1)
     fba:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     fbd:	8b 45 10             	mov    0x10(%ebp),%eax
     fc0:	3b 45 18             	cmp    0x18(%ebp),%eax
     fc3:	7e 0e                	jle    fd3 <APDrawLine+0x238>
    {
        s = y2;
     fc5:	8b 45 18             	mov    0x18(%ebp),%eax
     fc8:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     fcb:	8b 45 10             	mov    0x10(%ebp),%eax
     fce:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fd1:	eb 0c                	jmp    fdf <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     fd3:	8b 45 10             	mov    0x10(%ebp),%eax
     fd6:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     fd9:	8b 45 18             	mov    0x18(%ebp),%eax
     fdc:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     fdf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fe3:	79 07                	jns    fec <APDrawLine+0x251>
     fe5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     fec:	8b 45 08             	mov    0x8(%ebp),%eax
     fef:	8b 40 04             	mov    0x4(%eax),%eax
     ff2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ff5:	7f 0c                	jg     1003 <APDrawLine+0x268>
     ff7:	8b 45 08             	mov    0x8(%ebp),%eax
     ffa:	8b 40 04             	mov    0x4(%eax),%eax
     ffd:	83 e8 01             	sub    $0x1,%eax
    1000:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1003:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1006:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1009:	eb 3f                	jmp    104a <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    100b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    100e:	2b 45 10             	sub    0x10(%ebp),%eax
    1011:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1014:	db 45 b0             	fildl  -0x50(%ebp)
    1017:	dc 4d c0             	fmull  -0x40(%ebp)
    101a:	db 45 0c             	fildl  0xc(%ebp)
    101d:	de c1                	faddp  %st,%st(1)
    101f:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1022:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1026:	b4 0c                	mov    $0xc,%ah
    1028:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    102c:	d9 6d b4             	fldcw  -0x4c(%ebp)
    102f:	db 5d bc             	fistpl -0x44(%ebp)
    1032:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1035:	ff 75 e0             	pushl  -0x20(%ebp)
    1038:	ff 75 bc             	pushl  -0x44(%ebp)
    103b:	ff 75 08             	pushl  0x8(%ebp)
    103e:	e8 75 fc ff ff       	call   cb8 <APDrawPoint>
    1043:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1046:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    104a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    104d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1050:	7e b9                	jle    100b <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1052:	90                   	nop
    1053:	eb 04                	jmp    1059 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1055:	90                   	nop
    1056:	eb 01                	jmp    1059 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1058:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1059:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    105c:	c9                   	leave  
    105d:	c3                   	ret    

0000105e <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    105e:	55                   	push   %ebp
    105f:	89 e5                	mov    %esp,%ebp
    1061:	53                   	push   %ebx
    1062:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1065:	8b 55 10             	mov    0x10(%ebp),%edx
    1068:	8b 45 18             	mov    0x18(%ebp),%eax
    106b:	01 d0                	add    %edx,%eax
    106d:	83 e8 01             	sub    $0x1,%eax
    1070:	83 ec 04             	sub    $0x4,%esp
    1073:	50                   	push   %eax
    1074:	ff 75 0c             	pushl  0xc(%ebp)
    1077:	ff 75 10             	pushl  0x10(%ebp)
    107a:	ff 75 0c             	pushl  0xc(%ebp)
    107d:	ff 75 08             	pushl  0x8(%ebp)
    1080:	e8 16 fd ff ff       	call   d9b <APDrawLine>
    1085:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1088:	8b 55 0c             	mov    0xc(%ebp),%edx
    108b:	8b 45 14             	mov    0x14(%ebp),%eax
    108e:	01 d0                	add    %edx,%eax
    1090:	83 e8 01             	sub    $0x1,%eax
    1093:	83 ec 04             	sub    $0x4,%esp
    1096:	ff 75 10             	pushl  0x10(%ebp)
    1099:	50                   	push   %eax
    109a:	ff 75 10             	pushl  0x10(%ebp)
    109d:	ff 75 0c             	pushl  0xc(%ebp)
    10a0:	ff 75 08             	pushl  0x8(%ebp)
    10a3:	e8 f3 fc ff ff       	call   d9b <APDrawLine>
    10a8:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    10ab:	8b 55 10             	mov    0x10(%ebp),%edx
    10ae:	8b 45 18             	mov    0x18(%ebp),%eax
    10b1:	01 d0                	add    %edx,%eax
    10b3:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10b6:	8b 55 0c             	mov    0xc(%ebp),%edx
    10b9:	8b 45 14             	mov    0x14(%ebp),%eax
    10bc:	01 d0                	add    %edx,%eax
    10be:	8d 50 ff             	lea    -0x1(%eax),%edx
    10c1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10c4:	8b 45 14             	mov    0x14(%ebp),%eax
    10c7:	01 d8                	add    %ebx,%eax
    10c9:	83 e8 01             	sub    $0x1,%eax
    10cc:	83 ec 04             	sub    $0x4,%esp
    10cf:	51                   	push   %ecx
    10d0:	52                   	push   %edx
    10d1:	ff 75 10             	pushl  0x10(%ebp)
    10d4:	50                   	push   %eax
    10d5:	ff 75 08             	pushl  0x8(%ebp)
    10d8:	e8 be fc ff ff       	call   d9b <APDrawLine>
    10dd:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10e0:	8b 55 10             	mov    0x10(%ebp),%edx
    10e3:	8b 45 18             	mov    0x18(%ebp),%eax
    10e6:	01 d0                	add    %edx,%eax
    10e8:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10eb:	8b 55 0c             	mov    0xc(%ebp),%edx
    10ee:	8b 45 14             	mov    0x14(%ebp),%eax
    10f1:	01 d0                	add    %edx,%eax
    10f3:	8d 50 ff             	lea    -0x1(%eax),%edx
    10f6:	8b 5d 10             	mov    0x10(%ebp),%ebx
    10f9:	8b 45 18             	mov    0x18(%ebp),%eax
    10fc:	01 d8                	add    %ebx,%eax
    10fe:	83 e8 01             	sub    $0x1,%eax
    1101:	83 ec 04             	sub    $0x4,%esp
    1104:	51                   	push   %ecx
    1105:	52                   	push   %edx
    1106:	50                   	push   %eax
    1107:	ff 75 0c             	pushl  0xc(%ebp)
    110a:	ff 75 08             	pushl  0x8(%ebp)
    110d:	e8 89 fc ff ff       	call   d9b <APDrawLine>
    1112:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1115:	8b 55 0c             	mov    0xc(%ebp),%edx
    1118:	8b 45 14             	mov    0x14(%ebp),%eax
    111b:	01 d0                	add    %edx,%eax
    111d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1120:	8b 45 08             	mov    0x8(%ebp),%eax
    1123:	8b 40 0c             	mov    0xc(%eax),%eax
    1126:	89 c1                	mov    %eax,%ecx
    1128:	c1 e9 1f             	shr    $0x1f,%ecx
    112b:	01 c8                	add    %ecx,%eax
    112d:	d1 f8                	sar    %eax
    112f:	29 c2                	sub    %eax,%edx
    1131:	89 d0                	mov    %edx,%eax
    1133:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1136:	8b 55 10             	mov    0x10(%ebp),%edx
    1139:	8b 45 18             	mov    0x18(%ebp),%eax
    113c:	01 d0                	add    %edx,%eax
    113e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1141:	8b 45 08             	mov    0x8(%ebp),%eax
    1144:	8b 40 0c             	mov    0xc(%eax),%eax
    1147:	89 c1                	mov    %eax,%ecx
    1149:	c1 e9 1f             	shr    $0x1f,%ecx
    114c:	01 c8                	add    %ecx,%eax
    114e:	d1 f8                	sar    %eax
    1150:	29 c2                	sub    %eax,%edx
    1152:	89 d0                	mov    %edx,%eax
    1154:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1157:	8b 45 08             	mov    0x8(%ebp),%eax
    115a:	8b 40 0c             	mov    0xc(%eax),%eax
    115d:	89 c2                	mov    %eax,%edx
    115f:	c1 ea 1f             	shr    $0x1f,%edx
    1162:	01 d0                	add    %edx,%eax
    1164:	d1 f8                	sar    %eax
    1166:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1169:	8b 45 08             	mov    0x8(%ebp),%eax
    116c:	8b 40 0c             	mov    0xc(%eax),%eax
    116f:	89 c2                	mov    %eax,%edx
    1171:	c1 ea 1f             	shr    $0x1f,%edx
    1174:	01 d0                	add    %edx,%eax
    1176:	d1 f8                	sar    %eax
    1178:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    117b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    117f:	0f 88 d8 00 00 00    	js     125d <APDrawRect+0x1ff>
    1185:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1189:	0f 88 ce 00 00 00    	js     125d <APDrawRect+0x1ff>
    118f:	8b 45 08             	mov    0x8(%ebp),%eax
    1192:	8b 00                	mov    (%eax),%eax
    1194:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1197:	0f 8e c0 00 00 00    	jle    125d <APDrawRect+0x1ff>
    119d:	8b 45 08             	mov    0x8(%ebp),%eax
    11a0:	8b 40 04             	mov    0x4(%eax),%eax
    11a3:	3b 45 10             	cmp    0x10(%ebp),%eax
    11a6:	0f 8e b1 00 00 00    	jle    125d <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    11ac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11b0:	79 07                	jns    11b9 <APDrawRect+0x15b>
    11b2:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    11b9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    11bd:	79 07                	jns    11c6 <APDrawRect+0x168>
    11bf:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    11c6:	8b 45 08             	mov    0x8(%ebp),%eax
    11c9:	8b 00                	mov    (%eax),%eax
    11cb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11ce:	7f 0b                	jg     11db <APDrawRect+0x17d>
    11d0:	8b 45 08             	mov    0x8(%ebp),%eax
    11d3:	8b 00                	mov    (%eax),%eax
    11d5:	83 e8 01             	sub    $0x1,%eax
    11d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    11db:	8b 45 08             	mov    0x8(%ebp),%eax
    11de:	8b 40 04             	mov    0x4(%eax),%eax
    11e1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11e4:	7f 0c                	jg     11f2 <APDrawRect+0x194>
    11e6:	8b 45 08             	mov    0x8(%ebp),%eax
    11e9:	8b 40 04             	mov    0x4(%eax),%eax
    11ec:	83 e8 01             	sub    $0x1,%eax
    11ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    11f2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    11fc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11ff:	eb 52                	jmp    1253 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1201:	8b 45 10             	mov    0x10(%ebp),%eax
    1204:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1207:	eb 3e                	jmp    1247 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1209:	83 ec 04             	sub    $0x4,%esp
    120c:	ff 75 e8             	pushl  -0x18(%ebp)
    120f:	ff 75 ec             	pushl  -0x14(%ebp)
    1212:	ff 75 08             	pushl  0x8(%ebp)
    1215:	e8 c0 f6 ff ff       	call   8da <APGetIndex>
    121a:	83 c4 10             	add    $0x10,%esp
    121d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1220:	8b 45 08             	mov    0x8(%ebp),%eax
    1223:	8b 48 18             	mov    0x18(%eax),%ecx
    1226:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1229:	89 d0                	mov    %edx,%eax
    122b:	01 c0                	add    %eax,%eax
    122d:	01 d0                	add    %edx,%eax
    122f:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1232:	8b 45 08             	mov    0x8(%ebp),%eax
    1235:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1239:	66 89 0a             	mov    %cx,(%edx)
    123c:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1240:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1243:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1247:	8b 45 e8             	mov    -0x18(%ebp),%eax
    124a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    124d:	7e ba                	jle    1209 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    124f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1253:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1256:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1259:	7e a6                	jle    1201 <APDrawRect+0x1a3>
    125b:	eb 01                	jmp    125e <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    125d:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    125e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1261:	c9                   	leave  
    1262:	c3                   	ret    

00001263 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1263:	55                   	push   %ebp
    1264:	89 e5                	mov    %esp,%ebp
    1266:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    1269:	83 ec 0c             	sub    $0xc,%esp
    126c:	ff 75 0c             	pushl  0xc(%ebp)
    126f:	e8 b1 ee ff ff       	call   125 <strlen>
    1274:	83 c4 10             	add    $0x10,%esp
    1277:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    127a:	8b 45 08             	mov    0x8(%ebp),%eax
    127d:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1281:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1285:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1289:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    128c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1293:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    129a:	e9 bc 00 00 00       	jmp    135b <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    129f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12a2:	8b 45 0c             	mov    0xc(%ebp),%eax
    12a5:	01 d0                	add    %edx,%eax
    12a7:	0f b6 00             	movzbl (%eax),%eax
    12aa:	0f be c0             	movsbl %al,%eax
    12ad:	83 e8 20             	sub    $0x20,%eax
    12b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    12b3:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    12b7:	0f 87 9a 00 00 00    	ja     1357 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    12bd:	8b 45 08             	mov    0x8(%ebp),%eax
    12c0:	8b 00                	mov    (%eax),%eax
    12c2:	0f af 45 14          	imul   0x14(%ebp),%eax
    12c6:	89 c2                	mov    %eax,%edx
    12c8:	8b 45 10             	mov    0x10(%ebp),%eax
    12cb:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    12ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12d1:	89 d0                	mov    %edx,%eax
    12d3:	c1 e0 03             	shl    $0x3,%eax
    12d6:	01 d0                	add    %edx,%eax
    12d8:	01 c8                	add    %ecx,%eax
    12da:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    12dd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    12e4:	eb 6b                	jmp    1351 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    12e6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    12ed:	eb 50                	jmp    133f <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    12ef:	8b 55 ec             	mov    -0x14(%ebp),%edx
    12f2:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12f5:	89 d0                	mov    %edx,%eax
    12f7:	c1 e0 03             	shl    $0x3,%eax
    12fa:	01 d0                	add    %edx,%eax
    12fc:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    1302:	01 c2                	add    %eax,%edx
    1304:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1307:	01 d0                	add    %edx,%eax
    1309:	05 80 2d 00 00       	add    $0x2d80,%eax
    130e:	0f b6 00             	movzbl (%eax),%eax
    1311:	84 c0                	test   %al,%al
    1313:	74 26                	je     133b <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    1315:	8b 45 08             	mov    0x8(%ebp),%eax
    1318:	8b 50 18             	mov    0x18(%eax),%edx
    131b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    131e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1321:	01 c8                	add    %ecx,%eax
    1323:	89 c1                	mov    %eax,%ecx
    1325:	89 c8                	mov    %ecx,%eax
    1327:	01 c0                	add    %eax,%eax
    1329:	01 c8                	add    %ecx,%eax
    132b:	01 d0                	add    %edx,%eax
    132d:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1331:	66 89 10             	mov    %dx,(%eax)
    1334:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1338:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    133b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    133f:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1343:	7e aa                	jle    12ef <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1345:	8b 45 08             	mov    0x8(%ebp),%eax
    1348:	8b 00                	mov    (%eax),%eax
    134a:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    134d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1351:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1355:	7e 8f                	jle    12e6 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    1357:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    135b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    135e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1361:	0f 82 38 ff ff ff    	jb     129f <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1367:	90                   	nop
    1368:	c9                   	leave  
    1369:	c3                   	ret    

0000136a <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    136a:	55                   	push   %ebp
    136b:	89 e5                	mov    %esp,%ebp
    136d:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1370:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1374:	0f 88 8e 01 00 00    	js     1508 <APDcCopy+0x19e>
    137a:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    137e:	0f 88 84 01 00 00    	js     1508 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1384:	8b 55 0c             	mov    0xc(%ebp),%edx
    1387:	8b 45 20             	mov    0x20(%ebp),%eax
    138a:	01 d0                	add    %edx,%eax
    138c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    138f:	8b 55 10             	mov    0x10(%ebp),%edx
    1392:	8b 45 24             	mov    0x24(%ebp),%eax
    1395:	01 d0                	add    %edx,%eax
    1397:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    139a:	8b 55 18             	mov    0x18(%ebp),%edx
    139d:	8b 45 20             	mov    0x20(%ebp),%eax
    13a0:	01 d0                	add    %edx,%eax
    13a2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13a5:	8b 55 1c             	mov    0x1c(%ebp),%edx
    13a8:	8b 45 24             	mov    0x24(%ebp),%eax
    13ab:	01 d0                	add    %edx,%eax
    13ad:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    13b0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13b4:	0f 88 51 01 00 00    	js     150b <APDcCopy+0x1a1>
    13ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    13be:	0f 88 47 01 00 00    	js     150b <APDcCopy+0x1a1>
    13c4:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    13c8:	0f 88 3d 01 00 00    	js     150b <APDcCopy+0x1a1>
    13ce:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    13d2:	0f 88 33 01 00 00    	js     150b <APDcCopy+0x1a1>
    13d8:	8b 45 14             	mov    0x14(%ebp),%eax
    13db:	8b 00                	mov    (%eax),%eax
    13dd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13e0:	0f 8c 25 01 00 00    	jl     150b <APDcCopy+0x1a1>
    13e6:	8b 45 14             	mov    0x14(%ebp),%eax
    13e9:	8b 40 04             	mov    0x4(%eax),%eax
    13ec:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    13ef:	0f 8c 16 01 00 00    	jl     150b <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    13f5:	8b 45 08             	mov    0x8(%ebp),%eax
    13f8:	8b 00                	mov    (%eax),%eax
    13fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    13fd:	7f 0b                	jg     140a <APDcCopy+0xa0>
    13ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1402:	8b 00                	mov    (%eax),%eax
    1404:	83 e8 01             	sub    $0x1,%eax
    1407:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    140a:	8b 45 08             	mov    0x8(%ebp),%eax
    140d:	8b 40 04             	mov    0x4(%eax),%eax
    1410:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1413:	7f 0c                	jg     1421 <APDcCopy+0xb7>
    1415:	8b 45 08             	mov    0x8(%ebp),%eax
    1418:	8b 40 04             	mov    0x4(%eax),%eax
    141b:	83 e8 01             	sub    $0x1,%eax
    141e:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1421:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1428:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    142f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1436:	e9 bc 00 00 00       	jmp    14f7 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    143b:	8b 45 08             	mov    0x8(%ebp),%eax
    143e:	8b 00                	mov    (%eax),%eax
    1440:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1443:	8b 55 10             	mov    0x10(%ebp),%edx
    1446:	01 ca                	add    %ecx,%edx
    1448:	0f af d0             	imul   %eax,%edx
    144b:	8b 45 0c             	mov    0xc(%ebp),%eax
    144e:	01 d0                	add    %edx,%eax
    1450:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1453:	8b 45 14             	mov    0x14(%ebp),%eax
    1456:	8b 00                	mov    (%eax),%eax
    1458:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    145b:	8b 55 1c             	mov    0x1c(%ebp),%edx
    145e:	01 ca                	add    %ecx,%edx
    1460:	0f af d0             	imul   %eax,%edx
    1463:	8b 45 18             	mov    0x18(%ebp),%eax
    1466:	01 d0                	add    %edx,%eax
    1468:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    146b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1472:	eb 74                	jmp    14e8 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1474:	8b 45 14             	mov    0x14(%ebp),%eax
    1477:	8b 50 18             	mov    0x18(%eax),%edx
    147a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    147d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1480:	01 c8                	add    %ecx,%eax
    1482:	89 c1                	mov    %eax,%ecx
    1484:	89 c8                	mov    %ecx,%eax
    1486:	01 c0                	add    %eax,%eax
    1488:	01 c8                	add    %ecx,%eax
    148a:	01 d0                	add    %edx,%eax
    148c:	0f b7 10             	movzwl (%eax),%edx
    148f:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1493:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1497:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    149a:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    149e:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    14a2:	38 c2                	cmp    %al,%dl
    14a4:	75 18                	jne    14be <APDcCopy+0x154>
    14a6:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    14aa:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    14ae:	38 c2                	cmp    %al,%dl
    14b0:	75 0c                	jne    14be <APDcCopy+0x154>
    14b2:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    14b6:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    14ba:	38 c2                	cmp    %al,%dl
    14bc:	74 26                	je     14e4 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    14be:	8b 45 08             	mov    0x8(%ebp),%eax
    14c1:	8b 50 18             	mov    0x18(%eax),%edx
    14c4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    14c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14ca:	01 c8                	add    %ecx,%eax
    14cc:	89 c1                	mov    %eax,%ecx
    14ce:	89 c8                	mov    %ecx,%eax
    14d0:	01 c0                	add    %eax,%eax
    14d2:	01 c8                	add    %ecx,%eax
    14d4:	01 d0                	add    %edx,%eax
    14d6:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    14da:	66 89 10             	mov    %dx,(%eax)
    14dd:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    14e1:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    14e4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14eb:	2b 45 0c             	sub    0xc(%ebp),%eax
    14ee:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14f1:	7d 81                	jge    1474 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    14f3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14fa:	2b 45 10             	sub    0x10(%ebp),%eax
    14fd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1500:	0f 8d 35 ff ff ff    	jge    143b <APDcCopy+0xd1>
    1506:	eb 04                	jmp    150c <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1508:	90                   	nop
    1509:	eb 01                	jmp    150c <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    150b:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    150c:	c9                   	leave  
    150d:	c3                   	ret    

0000150e <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    150e:	55                   	push   %ebp
    150f:	89 e5                	mov    %esp,%ebp
    1511:	83 ec 1c             	sub    $0x1c,%esp
    1514:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1517:	8b 55 10             	mov    0x10(%ebp),%edx
    151a:	8b 45 14             	mov    0x14(%ebp),%eax
    151d:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1520:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1523:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1526:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    152a:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    152d:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1531:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1534:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1538:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    153b:	8b 45 08             	mov    0x8(%ebp),%eax
    153e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1542:	66 89 10             	mov    %dx,(%eax)
    1545:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1549:	88 50 02             	mov    %dl,0x2(%eax)
}
    154c:	8b 45 08             	mov    0x8(%ebp),%eax
    154f:	c9                   	leave  
    1550:	c2 04 00             	ret    $0x4

00001553 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1553:	55                   	push   %ebp
    1554:	89 e5                	mov    %esp,%ebp
    1556:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1559:	8b 45 08             	mov    0x8(%ebp),%eax
    155c:	8b 00                	mov    (%eax),%eax
    155e:	83 ec 08             	sub    $0x8,%esp
    1561:	8d 55 0c             	lea    0xc(%ebp),%edx
    1564:	52                   	push   %edx
    1565:	50                   	push   %eax
    1566:	e8 24 ee ff ff       	call   38f <sendMessage>
    156b:	83 c4 10             	add    $0x10,%esp
}
    156e:	90                   	nop
    156f:	c9                   	leave  
    1570:	c3                   	ret    

00001571 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1571:	55                   	push   %ebp
    1572:	89 e5                	mov    %esp,%ebp
    1574:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1577:	83 ec 0c             	sub    $0xc,%esp
    157a:	68 9c 00 00 00       	push   $0x9c
    157f:	e8 f5 f1 ff ff       	call   779 <malloc>
    1584:	83 c4 10             	add    $0x10,%esp
    1587:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    158a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    158e:	75 15                	jne    15a5 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1590:	83 ec 04             	sub    $0x4,%esp
    1593:	ff 75 08             	pushl  0x8(%ebp)
    1596:	68 28 26 00 00       	push   $0x2628
    159b:	6a 01                	push   $0x1
    159d:	e8 04 ef ff ff       	call   4a6 <printf>
    15a2:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    15a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a8:	05 88 00 00 00       	add    $0x88,%eax
    15ad:	83 ec 08             	sub    $0x8,%esp
    15b0:	ff 75 08             	pushl  0x8(%ebp)
    15b3:	50                   	push   %eax
    15b4:	e8 fd ea ff ff       	call   b6 <strcpy>
    15b9:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    15bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bf:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    15c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c9:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d3:	8b 40 3c             	mov    0x3c(%eax),%eax
    15d6:	89 c2                	mov    %eax,%edx
    15d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15db:	8b 40 40             	mov    0x40(%eax),%eax
    15de:	0f af d0             	imul   %eax,%edx
    15e1:	89 d0                	mov    %edx,%eax
    15e3:	01 c0                	add    %eax,%eax
    15e5:	01 d0                	add    %edx,%eax
    15e7:	83 ec 0c             	sub    $0xc,%esp
    15ea:	50                   	push   %eax
    15eb:	e8 89 f1 ff ff       	call   779 <malloc>
    15f0:	83 c4 10             	add    $0x10,%esp
    15f3:	89 c2                	mov    %eax,%edx
    15f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f8:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    15fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15fe:	8b 40 54             	mov    0x54(%eax),%eax
    1601:	85 c0                	test   %eax,%eax
    1603:	75 15                	jne    161a <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1605:	83 ec 04             	sub    $0x4,%esp
    1608:	ff 75 08             	pushl  0x8(%ebp)
    160b:	68 48 26 00 00       	push   $0x2648
    1610:	6a 01                	push   $0x1
    1612:	e8 8f ee ff ff       	call   4a6 <printf>
    1617:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    161a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161d:	8b 40 3c             	mov    0x3c(%eax),%eax
    1620:	89 c2                	mov    %eax,%edx
    1622:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1625:	8b 40 40             	mov    0x40(%eax),%eax
    1628:	0f af d0             	imul   %eax,%edx
    162b:	89 d0                	mov    %edx,%eax
    162d:	01 c0                	add    %eax,%eax
    162f:	01 c2                	add    %eax,%edx
    1631:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1634:	8b 40 54             	mov    0x54(%eax),%eax
    1637:	83 ec 04             	sub    $0x4,%esp
    163a:	52                   	push   %edx
    163b:	68 ff ff ff 00       	push   $0xffffff
    1640:	50                   	push   %eax
    1641:	e8 06 eb ff ff       	call   14c <memset>
    1646:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1649:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164c:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1653:	e8 0f ed ff ff       	call   367 <getpid>
    1658:	89 c2                	mov    %eax,%edx
    165a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165d:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1660:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1663:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    166a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166d:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1674:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1677:	8b 40 58             	mov    0x58(%eax),%eax
    167a:	89 c2                	mov    %eax,%edx
    167c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167f:	8b 40 5c             	mov    0x5c(%eax),%eax
    1682:	0f af d0             	imul   %eax,%edx
    1685:	89 d0                	mov    %edx,%eax
    1687:	01 c0                	add    %eax,%eax
    1689:	01 d0                	add    %edx,%eax
    168b:	83 ec 0c             	sub    $0xc,%esp
    168e:	50                   	push   %eax
    168f:	e8 e5 f0 ff ff       	call   779 <malloc>
    1694:	83 c4 10             	add    $0x10,%esp
    1697:	89 c2                	mov    %eax,%edx
    1699:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169c:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    169f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a2:	8b 40 70             	mov    0x70(%eax),%eax
    16a5:	85 c0                	test   %eax,%eax
    16a7:	75 15                	jne    16be <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    16a9:	83 ec 04             	sub    $0x4,%esp
    16ac:	ff 75 08             	pushl  0x8(%ebp)
    16af:	68 6c 26 00 00       	push   $0x266c
    16b4:	6a 01                	push   $0x1
    16b6:	e8 eb ed ff ff       	call   4a6 <printf>
    16bb:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    16be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c1:	8b 40 3c             	mov    0x3c(%eax),%eax
    16c4:	89 c2                	mov    %eax,%edx
    16c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c9:	8b 40 40             	mov    0x40(%eax),%eax
    16cc:	0f af d0             	imul   %eax,%edx
    16cf:	89 d0                	mov    %edx,%eax
    16d1:	01 c0                	add    %eax,%eax
    16d3:	01 c2                	add    %eax,%edx
    16d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d8:	8b 40 54             	mov    0x54(%eax),%eax
    16db:	83 ec 04             	sub    $0x4,%esp
    16de:	52                   	push   %edx
    16df:	68 ff 00 00 00       	push   $0xff
    16e4:	50                   	push   %eax
    16e5:	e8 62 ea ff ff       	call   14c <memset>
    16ea:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    16ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f0:	8b 55 0c             	mov    0xc(%ebp),%edx
    16f3:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    16f6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16fa:	74 49                	je     1745 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    16fc:	8b 45 10             	mov    0x10(%ebp),%eax
    16ff:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1705:	83 ec 0c             	sub    $0xc,%esp
    1708:	50                   	push   %eax
    1709:	e8 6b f0 ff ff       	call   779 <malloc>
    170e:	83 c4 10             	add    $0x10,%esp
    1711:	89 c2                	mov    %eax,%edx
    1713:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1716:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1719:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171c:	8b 55 10             	mov    0x10(%ebp),%edx
    171f:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1722:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1725:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    172c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172f:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1736:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1739:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1740:	e9 8d 00 00 00       	jmp    17d2 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1745:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1748:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    174f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1752:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1759:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175c:	8b 40 20             	mov    0x20(%eax),%eax
    175f:	89 c2                	mov    %eax,%edx
    1761:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1764:	8b 40 24             	mov    0x24(%eax),%eax
    1767:	0f af d0             	imul   %eax,%edx
    176a:	89 d0                	mov    %edx,%eax
    176c:	01 c0                	add    %eax,%eax
    176e:	01 d0                	add    %edx,%eax
    1770:	83 ec 0c             	sub    $0xc,%esp
    1773:	50                   	push   %eax
    1774:	e8 00 f0 ff ff       	call   779 <malloc>
    1779:	83 c4 10             	add    $0x10,%esp
    177c:	89 c2                	mov    %eax,%edx
    177e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1781:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1784:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1787:	8b 40 38             	mov    0x38(%eax),%eax
    178a:	85 c0                	test   %eax,%eax
    178c:	75 15                	jne    17a3 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    178e:	83 ec 04             	sub    $0x4,%esp
    1791:	ff 75 08             	pushl  0x8(%ebp)
    1794:	68 94 26 00 00       	push   $0x2694
    1799:	6a 01                	push   $0x1
    179b:	e8 06 ed ff ff       	call   4a6 <printf>
    17a0:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    17a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a6:	8b 40 20             	mov    0x20(%eax),%eax
    17a9:	89 c2                	mov    %eax,%edx
    17ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ae:	8b 40 24             	mov    0x24(%eax),%eax
    17b1:	0f af d0             	imul   %eax,%edx
    17b4:	89 d0                	mov    %edx,%eax
    17b6:	01 c0                	add    %eax,%eax
    17b8:	01 c2                	add    %eax,%edx
    17ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bd:	8b 40 38             	mov    0x38(%eax),%eax
    17c0:	83 ec 04             	sub    $0x4,%esp
    17c3:	52                   	push   %edx
    17c4:	68 ff ff ff 00       	push   $0xffffff
    17c9:	50                   	push   %eax
    17ca:	e8 7d e9 ff ff       	call   14c <memset>
    17cf:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    17d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    17d5:	c9                   	leave  
    17d6:	c3                   	ret    

000017d7 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    17d7:	55                   	push   %ebp
    17d8:	89 e5                	mov    %esp,%ebp
    17da:	57                   	push   %edi
    17db:	56                   	push   %esi
    17dc:	53                   	push   %ebx
    17dd:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    17e0:	8b 45 0c             	mov    0xc(%ebp),%eax
    17e3:	83 f8 03             	cmp    $0x3,%eax
    17e6:	74 0e                	je     17f6 <APWndProc+0x1f>
    17e8:	83 f8 0a             	cmp    $0xa,%eax
    17eb:	0f 84 82 00 00 00    	je     1873 <APWndProc+0x9c>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            break;
        default: break;
    17f1:	e9 cb 00 00 00       	jmp    18c1 <APWndProc+0xea>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    17f6:	8b 45 08             	mov    0x8(%ebp),%eax
    17f9:	8b 58 1c             	mov    0x1c(%eax),%ebx
    17fc:	8b 45 08             	mov    0x8(%ebp),%eax
    17ff:	8b 48 18             	mov    0x18(%eax),%ecx
    1802:	8b 45 08             	mov    0x8(%ebp),%eax
    1805:	8b 50 5c             	mov    0x5c(%eax),%edx
    1808:	8b 45 08             	mov    0x8(%ebp),%eax
    180b:	8b 40 58             	mov    0x58(%eax),%eax
    180e:	8b 75 08             	mov    0x8(%ebp),%esi
    1811:	83 c6 58             	add    $0x58,%esi
    1814:	83 ec 04             	sub    $0x4,%esp
    1817:	53                   	push   %ebx
    1818:	51                   	push   %ecx
    1819:	6a 00                	push   $0x0
    181b:	52                   	push   %edx
    181c:	50                   	push   %eax
    181d:	6a 00                	push   $0x0
    181f:	6a 00                	push   $0x0
    1821:	56                   	push   %esi
    1822:	6a 00                	push   $0x0
    1824:	6a 00                	push   $0x0
    1826:	ff 75 08             	pushl  0x8(%ebp)
    1829:	e8 59 eb ff ff       	call   387 <paintWindow>
    182e:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1831:	8b 45 08             	mov    0x8(%ebp),%eax
    1834:	8b 70 1c             	mov    0x1c(%eax),%esi
    1837:	8b 45 08             	mov    0x8(%ebp),%eax
    183a:	8b 58 18             	mov    0x18(%eax),%ebx
    183d:	8b 45 08             	mov    0x8(%ebp),%eax
    1840:	8b 48 08             	mov    0x8(%eax),%ecx
    1843:	8b 45 08             	mov    0x8(%ebp),%eax
    1846:	8b 50 40             	mov    0x40(%eax),%edx
    1849:	8b 45 08             	mov    0x8(%ebp),%eax
    184c:	8b 40 3c             	mov    0x3c(%eax),%eax
    184f:	8b 7d 08             	mov    0x8(%ebp),%edi
    1852:	83 c7 3c             	add    $0x3c,%edi
    1855:	83 ec 04             	sub    $0x4,%esp
    1858:	56                   	push   %esi
    1859:	53                   	push   %ebx
    185a:	51                   	push   %ecx
    185b:	52                   	push   %edx
    185c:	50                   	push   %eax
    185d:	6a 00                	push   $0x0
    185f:	6a 00                	push   $0x0
    1861:	57                   	push   %edi
    1862:	6a 32                	push   $0x32
    1864:	6a 00                	push   $0x0
    1866:	ff 75 08             	pushl  0x8(%ebp)
    1869:	e8 19 eb ff ff       	call   387 <paintWindow>
    186e:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1871:	eb 4e                	jmp    18c1 <APWndProc+0xea>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
    1873:	8b 45 18             	mov    0x18(%ebp),%eax
    1876:	83 ec 08             	sub    $0x8,%esp
    1879:	50                   	push   %eax
    187a:	ff 75 08             	pushl  0x8(%ebp)
    187d:	e8 c5 08 00 00       	call   2147 <updateword>
    1882:	83 c4 10             	add    $0x10,%esp
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1885:	8b 45 08             	mov    0x8(%ebp),%eax
    1888:	8b 58 1c             	mov    0x1c(%eax),%ebx
    188b:	8b 45 08             	mov    0x8(%ebp),%eax
    188e:	8b 48 18             	mov    0x18(%eax),%ecx
    1891:	8b 45 08             	mov    0x8(%ebp),%eax
    1894:	8b 50 5c             	mov    0x5c(%eax),%edx
    1897:	8b 45 08             	mov    0x8(%ebp),%eax
    189a:	8b 40 58             	mov    0x58(%eax),%eax
    189d:	8b 75 08             	mov    0x8(%ebp),%esi
    18a0:	83 c6 58             	add    $0x58,%esi
    18a3:	83 ec 04             	sub    $0x4,%esp
    18a6:	53                   	push   %ebx
    18a7:	51                   	push   %ecx
    18a8:	6a 00                	push   $0x0
    18aa:	52                   	push   %edx
    18ab:	50                   	push   %eax
    18ac:	6a 00                	push   $0x0
    18ae:	6a 00                	push   $0x0
    18b0:	56                   	push   %esi
    18b1:	6a 00                	push   $0x0
    18b3:	6a 00                	push   $0x0
    18b5:	ff 75 08             	pushl  0x8(%ebp)
    18b8:	e8 ca ea ff ff       	call   387 <paintWindow>
    18bd:	83 c4 30             	add    $0x30,%esp
            break;
    18c0:	90                   	nop
        default: break;
            
            
    }
    return False;
    18c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
    18c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
    18c9:	5b                   	pop    %ebx
    18ca:	5e                   	pop    %esi
    18cb:	5f                   	pop    %edi
    18cc:	5d                   	pop    %ebp
    18cd:	c3                   	ret    

000018ce <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    18ce:	55                   	push   %ebp
    18cf:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    18d1:	8b 45 0c             	mov    0xc(%ebp),%eax
    18d4:	8b 50 08             	mov    0x8(%eax),%edx
    18d7:	8b 45 08             	mov    0x8(%ebp),%eax
    18da:	8b 00                	mov    (%eax),%eax
    18dc:	39 c2                	cmp    %eax,%edx
    18de:	74 07                	je     18e7 <APPreJudge+0x19>
        return False;
    18e0:	b8 00 00 00 00       	mov    $0x0,%eax
    18e5:	eb 05                	jmp    18ec <APPreJudge+0x1e>
    return True;
    18e7:	b8 01 00 00 00       	mov    $0x1,%eax
}
    18ec:	5d                   	pop    %ebp
    18ed:	c3                   	ret    

000018ee <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    18ee:	55                   	push   %ebp
    18ef:	89 e5                	mov    %esp,%ebp
    18f1:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    18f4:	8b 45 08             	mov    0x8(%ebp),%eax
    18f7:	8b 55 0c             	mov    0xc(%ebp),%edx
    18fa:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
    //--------add window to list
    registWindow(hwnd);
    1900:	83 ec 0c             	sub    $0xc,%esp
    1903:	ff 75 08             	pushl  0x8(%ebp)
    1906:	e8 94 ea ff ff       	call   39f <registWindow>
    190b:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    190e:	c7 45 e8 02 00 00 00 	movl   $0x2,-0x18(%ebp)
    msg.wndID = hwnd->id;
    1915:	8b 45 08             	mov    0x8(%ebp),%eax
    1918:	8b 00                	mov    (%eax),%eax
    191a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    APSendMessage(hwnd,msg);
    191d:	83 ec 0c             	sub    $0xc,%esp
    1920:	ff 75 f4             	pushl  -0xc(%ebp)
    1923:	ff 75 f0             	pushl  -0x10(%ebp)
    1926:	ff 75 ec             	pushl  -0x14(%ebp)
    1929:	ff 75 e8             	pushl  -0x18(%ebp)
    192c:	ff 75 08             	pushl  0x8(%ebp)
    192f:	e8 1f fc ff ff       	call   1553 <APSendMessage>
    1934:	83 c4 20             	add    $0x20,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1937:	83 ec 0c             	sub    $0xc,%esp
    193a:	ff 75 08             	pushl  0x8(%ebp)
    193d:	e8 55 ea ff ff       	call   397 <getMessage>
    1942:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1945:	8b 45 08             	mov    0x8(%ebp),%eax
    1948:	83 c0 74             	add    $0x74,%eax
    194b:	83 ec 08             	sub    $0x8,%esp
    194e:	50                   	push   %eax
    194f:	ff 75 08             	pushl  0x8(%ebp)
    1952:	e8 77 ff ff ff       	call   18ce <APPreJudge>
    1957:	83 c4 10             	add    $0x10,%esp
    195a:	84 c0                	test   %al,%al
    195c:	74 24                	je     1982 <APWndExec+0x94>
            if (wndProc(hwnd, hwnd->msg))
    195e:	83 ec 0c             	sub    $0xc,%esp
    1961:	8b 45 08             	mov    0x8(%ebp),%eax
    1964:	ff b0 80 00 00 00    	pushl  0x80(%eax)
    196a:	ff 70 7c             	pushl  0x7c(%eax)
    196d:	ff 70 78             	pushl  0x78(%eax)
    1970:	ff 70 74             	pushl  0x74(%eax)
    1973:	ff 75 08             	pushl  0x8(%ebp)
    1976:	8b 45 0c             	mov    0xc(%ebp),%eax
    1979:	ff d0                	call   *%eax
    197b:	83 c4 20             	add    $0x20,%esp
    197e:	84 c0                	test   %al,%al
    1980:	75 0c                	jne    198e <APWndExec+0xa0>
                break;
        hwnd->msg.type = MSG_NULL;
    1982:	8b 45 08             	mov    0x8(%ebp),%eax
    1985:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    198c:	eb a9                	jmp    1937 <APWndExec+0x49>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    198e:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    198f:	90                   	nop
    1990:	c9                   	leave  
    1991:	c3                   	ret    

00001992 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1992:	55                   	push   %ebp
    1993:	89 e5                	mov    %esp,%ebp
    1995:	57                   	push   %edi
    1996:	56                   	push   %esi
    1997:	53                   	push   %ebx
    1998:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    199b:	a1 c4 69 00 00       	mov    0x69c4,%eax
    19a0:	85 c0                	test   %eax,%eax
    19a2:	0f 85 c8 02 00 00    	jne    1c70 <APGridPaint+0x2de>
    {
        iconReady = 1;
    19a8:	c7 05 c4 69 00 00 01 	movl   $0x1,0x69c4
    19af:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    19b2:	8d 45 98             	lea    -0x68(%ebp),%eax
    19b5:	83 ec 08             	sub    $0x8,%esp
    19b8:	68 bb 26 00 00       	push   $0x26bb
    19bd:	50                   	push   %eax
    19be:	e8 69 ef ff ff       	call   92c <APLoadBitmap>
    19c3:	83 c4 0c             	add    $0xc,%esp
    19c6:	8b 45 98             	mov    -0x68(%ebp),%eax
    19c9:	a3 f4 69 00 00       	mov    %eax,0x69f4
    19ce:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19d1:	a3 f8 69 00 00       	mov    %eax,0x69f8
    19d6:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19d9:	a3 fc 69 00 00       	mov    %eax,0x69fc
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    19de:	83 ec 04             	sub    $0x4,%esp
    19e1:	ff 35 fc 69 00 00    	pushl  0x69fc
    19e7:	ff 35 f8 69 00 00    	pushl  0x69f8
    19ed:	ff 35 f4 69 00 00    	pushl  0x69f4
    19f3:	e8 6e f1 ff ff       	call   b66 <APCreateCompatibleDCFromBitmap>
    19f8:	83 c4 10             	add    $0x10,%esp
    19fb:	a3 00 6a 00 00       	mov    %eax,0x6a00
        grid_river = APLoadBitmap ("grid_river.bmp");
    1a00:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a03:	83 ec 08             	sub    $0x8,%esp
    1a06:	68 c9 26 00 00       	push   $0x26c9
    1a0b:	50                   	push   %eax
    1a0c:	e8 1b ef ff ff       	call   92c <APLoadBitmap>
    1a11:	83 c4 0c             	add    $0xc,%esp
    1a14:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a17:	a3 40 6a 00 00       	mov    %eax,0x6a40
    1a1c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a1f:	a3 44 6a 00 00       	mov    %eax,0x6a44
    1a24:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a27:	a3 48 6a 00 00       	mov    %eax,0x6a48
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1a2c:	83 ec 04             	sub    $0x4,%esp
    1a2f:	ff 35 48 6a 00 00    	pushl  0x6a48
    1a35:	ff 35 44 6a 00 00    	pushl  0x6a44
    1a3b:	ff 35 40 6a 00 00    	pushl  0x6a40
    1a41:	e8 20 f1 ff ff       	call   b66 <APCreateCompatibleDCFromBitmap>
    1a46:	83 c4 10             	add    $0x10,%esp
    1a49:	a3 30 6a 00 00       	mov    %eax,0x6a30
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1a4e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a51:	83 ec 08             	sub    $0x8,%esp
    1a54:	68 d8 26 00 00       	push   $0x26d8
    1a59:	50                   	push   %eax
    1a5a:	e8 cd ee ff ff       	call   92c <APLoadBitmap>
    1a5f:	83 c4 0c             	add    $0xc,%esp
    1a62:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a65:	a3 34 6a 00 00       	mov    %eax,0x6a34
    1a6a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a6d:	a3 38 6a 00 00       	mov    %eax,0x6a38
    1a72:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a75:	a3 3c 6a 00 00       	mov    %eax,0x6a3c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1a7a:	83 ec 04             	sub    $0x4,%esp
    1a7d:	ff 35 3c 6a 00 00    	pushl  0x6a3c
    1a83:	ff 35 38 6a 00 00    	pushl  0x6a38
    1a89:	ff 35 34 6a 00 00    	pushl  0x6a34
    1a8f:	e8 d2 f0 ff ff       	call   b66 <APCreateCompatibleDCFromBitmap>
    1a94:	83 c4 10             	add    $0x10,%esp
    1a97:	a3 c8 69 00 00       	mov    %eax,0x69c8
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1a9c:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a9f:	83 ec 08             	sub    $0x8,%esp
    1aa2:	68 e7 26 00 00       	push   $0x26e7
    1aa7:	50                   	push   %eax
    1aa8:	e8 7f ee ff ff       	call   92c <APLoadBitmap>
    1aad:	83 c4 0c             	add    $0xc,%esp
    1ab0:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ab3:	a3 cc 69 00 00       	mov    %eax,0x69cc
    1ab8:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1abb:	a3 d0 69 00 00       	mov    %eax,0x69d0
    1ac0:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ac3:	a3 d4 69 00 00       	mov    %eax,0x69d4
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1ac8:	83 ec 04             	sub    $0x4,%esp
    1acb:	ff 35 d4 69 00 00    	pushl  0x69d4
    1ad1:	ff 35 d0 69 00 00    	pushl  0x69d0
    1ad7:	ff 35 cc 69 00 00    	pushl  0x69cc
    1add:	e8 84 f0 ff ff       	call   b66 <APCreateCompatibleDCFromBitmap>
    1ae2:	83 c4 10             	add    $0x10,%esp
    1ae5:	a3 f0 69 00 00       	mov    %eax,0x69f0
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1aea:	8d 45 98             	lea    -0x68(%ebp),%eax
    1aed:	83 ec 08             	sub    $0x8,%esp
    1af0:	68 f9 26 00 00       	push   $0x26f9
    1af5:	50                   	push   %eax
    1af6:	e8 31 ee ff ff       	call   92c <APLoadBitmap>
    1afb:	83 c4 0c             	add    $0xc,%esp
    1afe:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b01:	a3 0c 6a 00 00       	mov    %eax,0x6a0c
    1b06:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b09:	a3 10 6a 00 00       	mov    %eax,0x6a10
    1b0e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b11:	a3 14 6a 00 00       	mov    %eax,0x6a14
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1b16:	83 ec 04             	sub    $0x4,%esp
    1b19:	ff 35 14 6a 00 00    	pushl  0x6a14
    1b1f:	ff 35 10 6a 00 00    	pushl  0x6a10
    1b25:	ff 35 0c 6a 00 00    	pushl  0x6a0c
    1b2b:	e8 36 f0 ff ff       	call   b66 <APCreateCompatibleDCFromBitmap>
    1b30:	83 c4 10             	add    $0x10,%esp
    1b33:	a3 50 6a 00 00       	mov    %eax,0x6a50
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1b38:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b3b:	83 ec 08             	sub    $0x8,%esp
    1b3e:	68 07 27 00 00       	push   $0x2707
    1b43:	50                   	push   %eax
    1b44:	e8 e3 ed ff ff       	call   92c <APLoadBitmap>
    1b49:	83 c4 0c             	add    $0xc,%esp
    1b4c:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b4f:	a3 e4 69 00 00       	mov    %eax,0x69e4
    1b54:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b57:	a3 e8 69 00 00       	mov    %eax,0x69e8
    1b5c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b5f:	a3 ec 69 00 00       	mov    %eax,0x69ec
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1b64:	83 ec 04             	sub    $0x4,%esp
    1b67:	ff 35 ec 69 00 00    	pushl  0x69ec
    1b6d:	ff 35 e8 69 00 00    	pushl  0x69e8
    1b73:	ff 35 e4 69 00 00    	pushl  0x69e4
    1b79:	e8 e8 ef ff ff       	call   b66 <APCreateCompatibleDCFromBitmap>
    1b7e:	83 c4 10             	add    $0x10,%esp
    1b81:	a3 04 6a 00 00       	mov    %eax,0x6a04
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1b86:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b89:	83 ec 08             	sub    $0x8,%esp
    1b8c:	68 17 27 00 00       	push   $0x2717
    1b91:	50                   	push   %eax
    1b92:	e8 95 ed ff ff       	call   92c <APLoadBitmap>
    1b97:	83 c4 0c             	add    $0xc,%esp
    1b9a:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b9d:	a3 24 6a 00 00       	mov    %eax,0x6a24
    1ba2:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1ba5:	a3 28 6a 00 00       	mov    %eax,0x6a28
    1baa:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bad:	a3 2c 6a 00 00       	mov    %eax,0x6a2c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1bb2:	83 ec 04             	sub    $0x4,%esp
    1bb5:	ff 35 2c 6a 00 00    	pushl  0x6a2c
    1bbb:	ff 35 28 6a 00 00    	pushl  0x6a28
    1bc1:	ff 35 24 6a 00 00    	pushl  0x6a24
    1bc7:	e8 9a ef ff ff       	call   b66 <APCreateCompatibleDCFromBitmap>
    1bcc:	83 c4 10             	add    $0x10,%esp
    1bcf:	a3 54 6a 00 00       	mov    %eax,0x6a54
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    1bd4:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bd7:	83 ec 08             	sub    $0x8,%esp
    1bda:	68 26 27 00 00       	push   $0x2726
    1bdf:	50                   	push   %eax
    1be0:	e8 47 ed ff ff       	call   92c <APLoadBitmap>
    1be5:	83 c4 0c             	add    $0xc,%esp
    1be8:	8b 45 98             	mov    -0x68(%ebp),%eax
    1beb:	a3 18 6a 00 00       	mov    %eax,0x6a18
    1bf0:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1bf3:	a3 1c 6a 00 00       	mov    %eax,0x6a1c
    1bf8:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bfb:	a3 20 6a 00 00       	mov    %eax,0x6a20
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    1c00:	83 ec 04             	sub    $0x4,%esp
    1c03:	ff 35 20 6a 00 00    	pushl  0x6a20
    1c09:	ff 35 1c 6a 00 00    	pushl  0x6a1c
    1c0f:	ff 35 18 6a 00 00    	pushl  0x6a18
    1c15:	e8 4c ef ff ff       	call   b66 <APCreateCompatibleDCFromBitmap>
    1c1a:	83 c4 10             	add    $0x10,%esp
    1c1d:	a3 4c 6a 00 00       	mov    %eax,0x6a4c
        grid_tower = APLoadBitmap ("grid_tower.bmp");
    1c22:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c25:	83 ec 08             	sub    $0x8,%esp
    1c28:	68 35 27 00 00       	push   $0x2735
    1c2d:	50                   	push   %eax
    1c2e:	e8 f9 ec ff ff       	call   92c <APLoadBitmap>
    1c33:	83 c4 0c             	add    $0xc,%esp
    1c36:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c39:	a3 d8 69 00 00       	mov    %eax,0x69d8
    1c3e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c41:	a3 dc 69 00 00       	mov    %eax,0x69dc
    1c46:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c49:	a3 e0 69 00 00       	mov    %eax,0x69e0
        g_tower = APCreateCompatibleDCFromBitmap(grid_tower);
    1c4e:	83 ec 04             	sub    $0x4,%esp
    1c51:	ff 35 e0 69 00 00    	pushl  0x69e0
    1c57:	ff 35 dc 69 00 00    	pushl  0x69dc
    1c5d:	ff 35 d8 69 00 00    	pushl  0x69d8
    1c63:	e8 fe ee ff ff       	call   b66 <APCreateCompatibleDCFromBitmap>
    1c68:	83 c4 10             	add    $0x10,%esp
    1c6b:	a3 08 6a 00 00       	mov    %eax,0x6a08
   
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1c70:	8b 45 08             	mov    0x8(%ebp),%eax
    1c73:	8b 40 08             	mov    0x8(%eax),%eax
    1c76:	85 c0                	test   %eax,%eax
    1c78:	75 17                	jne    1c91 <APGridPaint+0x2ff>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1c7a:	83 ec 08             	sub    $0x8,%esp
    1c7d:	68 44 27 00 00       	push   $0x2744
    1c82:	6a 01                	push   $0x1
    1c84:	e8 1d e8 ff ff       	call   4a6 <printf>
    1c89:	83 c4 10             	add    $0x10,%esp
        return;
    1c8c:	e9 ae 04 00 00       	jmp    213f <APGridPaint+0x7ad>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1c91:	8b 45 08             	mov    0x8(%ebp),%eax
    1c94:	8b 40 10             	mov    0x10(%eax),%eax
    1c97:	85 c0                	test   %eax,%eax
    1c99:	7e 10                	jle    1cab <APGridPaint+0x319>
    1c9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c9e:	8b 50 14             	mov    0x14(%eax),%edx
    1ca1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca4:	8b 40 10             	mov    0x10(%eax),%eax
    1ca7:	39 c2                	cmp    %eax,%edx
    1ca9:	7c 17                	jl     1cc2 <APGridPaint+0x330>
    {
        printf(1,"Grid mode page error!");
    1cab:	83 ec 08             	sub    $0x8,%esp
    1cae:	68 6a 27 00 00       	push   $0x276a
    1cb3:	6a 01                	push   $0x1
    1cb5:	e8 ec e7 ff ff       	call   4a6 <printf>
    1cba:	83 c4 10             	add    $0x10,%esp
        return;
    1cbd:	e9 7d 04 00 00       	jmp    213f <APGridPaint+0x7ad>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1cc2:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc5:	8b 40 14             	mov    0x14(%eax),%eax
    1cc8:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1cce:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1cd1:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1cd4:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1cd7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1cde:	e9 52 04 00 00       	jmp    2135 <APGridPaint+0x7a3>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1ce3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1cea:	e9 38 04 00 00       	jmp    2127 <APGridPaint+0x795>
        {
            index = start + GRID_W_NUMBER * j + i;
    1cef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cf2:	c1 e0 04             	shl    $0x4,%eax
    1cf5:	89 c2                	mov    %eax,%edx
    1cf7:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1cfa:	01 c2                	add    %eax,%edx
    1cfc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cff:	01 d0                	add    %edx,%eax
    1d01:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1d04:	8b 45 08             	mov    0x8(%ebp),%eax
    1d07:	8b 40 0c             	mov    0xc(%eax),%eax
    1d0a:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1d0d:	c1 e2 02             	shl    $0x2,%edx
    1d10:	01 d0                	add    %edx,%eax
    1d12:	8b 00                	mov    (%eax),%eax
    1d14:	83 f8 0b             	cmp    $0xb,%eax
    1d17:	0f 87 05 04 00 00    	ja     2122 <APGridPaint+0x790>
    1d1d:	8b 04 85 80 27 00 00 	mov    0x2780(,%eax,4),%eax
    1d24:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d26:	8d 45 bd             	lea    -0x43(%ebp),%eax
    1d29:	6a 0c                	push   $0xc
    1d2b:	6a 0c                	push   $0xc
    1d2d:	6a 0c                	push   $0xc
    1d2f:	50                   	push   %eax
    1d30:	e8 d9 f7 ff ff       	call   150e <RGB>
    1d35:	83 c4 0c             	add    $0xc,%esp
    1d38:	8b 1d 00 6a 00 00    	mov    0x6a00,%ebx
    1d3e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d41:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d44:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d47:	6b c0 32             	imul   $0x32,%eax,%eax
    1d4a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d4d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d50:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d53:	83 ec 0c             	sub    $0xc,%esp
    1d56:	83 ec 04             	sub    $0x4,%esp
    1d59:	89 e0                	mov    %esp,%eax
    1d5b:	0f b7 75 bd          	movzwl -0x43(%ebp),%esi
    1d5f:	66 89 30             	mov    %si,(%eax)
    1d62:	0f b6 55 bf          	movzbl -0x41(%ebp),%edx
    1d66:	88 50 02             	mov    %dl,0x2(%eax)
    1d69:	6a 32                	push   $0x32
    1d6b:	6a 32                	push   $0x32
    1d6d:	6a 00                	push   $0x0
    1d6f:	6a 00                	push   $0x0
    1d71:	53                   	push   %ebx
    1d72:	51                   	push   %ecx
    1d73:	ff 75 94             	pushl  -0x6c(%ebp)
    1d76:	57                   	push   %edi
    1d77:	e8 ee f5 ff ff       	call   136a <APDcCopy>
    1d7c:	83 c4 30             	add    $0x30,%esp
                    break;
    1d7f:	e9 9f 03 00 00       	jmp    2123 <APGridPaint+0x791>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1d84:	8d 45 98             	lea    -0x68(%ebp),%eax
    1d87:	6a 69                	push   $0x69
    1d89:	6a 69                	push   $0x69
    1d8b:	6a 69                	push   $0x69
    1d8d:	50                   	push   %eax
    1d8e:	e8 7b f7 ff ff       	call   150e <RGB>
    1d93:	83 c4 0c             	add    $0xc,%esp
    1d96:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1d9a:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1d9e:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1da2:	88 45 b6             	mov    %al,-0x4a(%ebp)
                    pen.size = 1;
    1da5:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1dac:	8d 45 98             	lea    -0x68(%ebp),%eax
    1daf:	6a 69                	push   $0x69
    1db1:	6a 69                	push   $0x69
    1db3:	6a 69                	push   $0x69
    1db5:	50                   	push   %eax
    1db6:	e8 53 f7 ff ff       	call   150e <RGB>
    1dbb:	83 c4 0c             	add    $0xc,%esp
    1dbe:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1dc2:	66 89 45 b1          	mov    %ax,-0x4f(%ebp)
    1dc6:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1dca:	88 45 b3             	mov    %al,-0x4d(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1dcd:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd0:	8d 50 3c             	lea    0x3c(%eax),%edx
    1dd3:	8d 45 98             	lea    -0x68(%ebp),%eax
    1dd6:	ff 75 b8             	pushl  -0x48(%ebp)
    1dd9:	ff 75 b4             	pushl  -0x4c(%ebp)
    1ddc:	52                   	push   %edx
    1ddd:	50                   	push   %eax
    1dde:	e8 18 ee ff ff       	call   bfb <APSetPen>
    1de3:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1de6:	8b 45 08             	mov    0x8(%ebp),%eax
    1de9:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1dec:	8d 55 98             	lea    -0x68(%ebp),%edx
    1def:	83 ec 04             	sub    $0x4,%esp
    1df2:	83 ec 04             	sub    $0x4,%esp
    1df5:	89 e0                	mov    %esp,%eax
    1df7:	0f b7 4d b1          	movzwl -0x4f(%ebp),%ecx
    1dfb:	66 89 08             	mov    %cx,(%eax)
    1dfe:	0f b6 4d b3          	movzbl -0x4d(%ebp),%ecx
    1e02:	88 48 02             	mov    %cl,0x2(%eax)
    1e05:	53                   	push   %ebx
    1e06:	52                   	push   %edx
    1e07:	e8 28 ee ff ff       	call   c34 <APSetBrush>
    1e0c:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1e0f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e12:	6b d0 32             	imul   $0x32,%eax,%edx
    1e15:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e18:	6b c0 32             	imul   $0x32,%eax,%eax
    1e1b:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1e1e:	83 c1 3c             	add    $0x3c,%ecx
    1e21:	83 ec 0c             	sub    $0xc,%esp
    1e24:	6a 32                	push   $0x32
    1e26:	6a 32                	push   $0x32
    1e28:	52                   	push   %edx
    1e29:	50                   	push   %eax
    1e2a:	51                   	push   %ecx
    1e2b:	e8 2e f2 ff ff       	call   105e <APDrawRect>
    1e30:	83 c4 20             	add    $0x20,%esp
                    break;
    1e33:	e9 eb 02 00 00       	jmp    2123 <APGridPaint+0x791>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e38:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1e3b:	6a 0c                	push   $0xc
    1e3d:	6a 0c                	push   $0xc
    1e3f:	6a 0c                	push   $0xc
    1e41:	50                   	push   %eax
    1e42:	e8 c7 f6 ff ff       	call   150e <RGB>
    1e47:	83 c4 0c             	add    $0xc,%esp
    1e4a:	8b 1d 54 6a 00 00    	mov    0x6a54,%ebx
    1e50:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e53:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e56:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e59:	6b c0 32             	imul   $0x32,%eax,%eax
    1e5c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e62:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e65:	83 ec 0c             	sub    $0xc,%esp
    1e68:	83 ec 04             	sub    $0x4,%esp
    1e6b:	89 e0                	mov    %esp,%eax
    1e6d:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    1e71:	66 89 30             	mov    %si,(%eax)
    1e74:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    1e78:	88 50 02             	mov    %dl,0x2(%eax)
    1e7b:	6a 32                	push   $0x32
    1e7d:	6a 32                	push   $0x32
    1e7f:	6a 00                	push   $0x0
    1e81:	6a 00                	push   $0x0
    1e83:	53                   	push   %ebx
    1e84:	51                   	push   %ecx
    1e85:	ff 75 94             	pushl  -0x6c(%ebp)
    1e88:	57                   	push   %edi
    1e89:	e8 dc f4 ff ff       	call   136a <APDcCopy>
    1e8e:	83 c4 30             	add    $0x30,%esp
                    break;
    1e91:	e9 8d 02 00 00       	jmp    2123 <APGridPaint+0x791>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e96:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1e99:	6a 0c                	push   $0xc
    1e9b:	6a 0c                	push   $0xc
    1e9d:	6a 0c                	push   $0xc
    1e9f:	50                   	push   %eax
    1ea0:	e8 69 f6 ff ff       	call   150e <RGB>
    1ea5:	83 c4 0c             	add    $0xc,%esp
    1ea8:	8b 1d 30 6a 00 00    	mov    0x6a30,%ebx
    1eae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1eb1:	6b c8 32             	imul   $0x32,%eax,%ecx
    1eb4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1eb7:	6b c0 32             	imul   $0x32,%eax,%eax
    1eba:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ebd:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec0:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ec3:	83 ec 0c             	sub    $0xc,%esp
    1ec6:	83 ec 04             	sub    $0x4,%esp
    1ec9:	89 e0                	mov    %esp,%eax
    1ecb:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1ecf:	66 89 30             	mov    %si,(%eax)
    1ed2:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1ed6:	88 50 02             	mov    %dl,0x2(%eax)
    1ed9:	6a 32                	push   $0x32
    1edb:	6a 32                	push   $0x32
    1edd:	6a 00                	push   $0x0
    1edf:	6a 00                	push   $0x0
    1ee1:	53                   	push   %ebx
    1ee2:	51                   	push   %ecx
    1ee3:	ff 75 94             	pushl  -0x6c(%ebp)
    1ee6:	57                   	push   %edi
    1ee7:	e8 7e f4 ff ff       	call   136a <APDcCopy>
    1eec:	83 c4 30             	add    $0x30,%esp
                    break;
    1eef:	e9 2f 02 00 00       	jmp    2123 <APGridPaint+0x791>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ef4:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1ef7:	6a 0c                	push   $0xc
    1ef9:	6a 0c                	push   $0xc
    1efb:	6a 0c                	push   $0xc
    1efd:	50                   	push   %eax
    1efe:	e8 0b f6 ff ff       	call   150e <RGB>
    1f03:	83 c4 0c             	add    $0xc,%esp
    1f06:	8b 1d 04 6a 00 00    	mov    0x6a04,%ebx
    1f0c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f0f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f12:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f15:	6b c0 32             	imul   $0x32,%eax,%eax
    1f18:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f1b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f1e:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f21:	83 ec 0c             	sub    $0xc,%esp
    1f24:	83 ec 04             	sub    $0x4,%esp
    1f27:	89 e0                	mov    %esp,%eax
    1f29:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1f2d:	66 89 30             	mov    %si,(%eax)
    1f30:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1f34:	88 50 02             	mov    %dl,0x2(%eax)
    1f37:	6a 32                	push   $0x32
    1f39:	6a 32                	push   $0x32
    1f3b:	6a 00                	push   $0x0
    1f3d:	6a 00                	push   $0x0
    1f3f:	53                   	push   %ebx
    1f40:	51                   	push   %ecx
    1f41:	ff 75 94             	pushl  -0x6c(%ebp)
    1f44:	57                   	push   %edi
    1f45:	e8 20 f4 ff ff       	call   136a <APDcCopy>
    1f4a:	83 c4 30             	add    $0x30,%esp
                    break;
    1f4d:	e9 d1 01 00 00       	jmp    2123 <APGridPaint+0x791>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f52:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1f55:	6a 0c                	push   $0xc
    1f57:	6a 0c                	push   $0xc
    1f59:	6a 0c                	push   $0xc
    1f5b:	50                   	push   %eax
    1f5c:	e8 ad f5 ff ff       	call   150e <RGB>
    1f61:	83 c4 0c             	add    $0xc,%esp
    1f64:	8b 1d 50 6a 00 00    	mov    0x6a50,%ebx
    1f6a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f6d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f70:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f73:	6b c0 32             	imul   $0x32,%eax,%eax
    1f76:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f79:	8b 45 08             	mov    0x8(%ebp),%eax
    1f7c:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f7f:	83 ec 0c             	sub    $0xc,%esp
    1f82:	83 ec 04             	sub    $0x4,%esp
    1f85:	89 e0                	mov    %esp,%eax
    1f87:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1f8b:	66 89 30             	mov    %si,(%eax)
    1f8e:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1f92:	88 50 02             	mov    %dl,0x2(%eax)
    1f95:	6a 32                	push   $0x32
    1f97:	6a 32                	push   $0x32
    1f99:	6a 00                	push   $0x0
    1f9b:	6a 00                	push   $0x0
    1f9d:	53                   	push   %ebx
    1f9e:	51                   	push   %ecx
    1f9f:	ff 75 94             	pushl  -0x6c(%ebp)
    1fa2:	57                   	push   %edi
    1fa3:	e8 c2 f3 ff ff       	call   136a <APDcCopy>
    1fa8:	83 c4 30             	add    $0x30,%esp
                    break;
    1fab:	e9 73 01 00 00       	jmp    2123 <APGridPaint+0x791>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fb0:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1fb3:	6a 0c                	push   $0xc
    1fb5:	6a 0c                	push   $0xc
    1fb7:	6a 0c                	push   $0xc
    1fb9:	50                   	push   %eax
    1fba:	e8 4f f5 ff ff       	call   150e <RGB>
    1fbf:	83 c4 0c             	add    $0xc,%esp
    1fc2:	8b 1d c8 69 00 00    	mov    0x69c8,%ebx
    1fc8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fcb:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fce:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fd1:	6b c0 32             	imul   $0x32,%eax,%eax
    1fd4:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1fd7:	8b 45 08             	mov    0x8(%ebp),%eax
    1fda:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fdd:	83 ec 0c             	sub    $0xc,%esp
    1fe0:	83 ec 04             	sub    $0x4,%esp
    1fe3:	89 e0                	mov    %esp,%eax
    1fe5:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1fe9:	66 89 30             	mov    %si,(%eax)
    1fec:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1ff0:	88 50 02             	mov    %dl,0x2(%eax)
    1ff3:	6a 32                	push   $0x32
    1ff5:	6a 32                	push   $0x32
    1ff7:	6a 00                	push   $0x0
    1ff9:	6a 00                	push   $0x0
    1ffb:	53                   	push   %ebx
    1ffc:	51                   	push   %ecx
    1ffd:	ff 75 94             	pushl  -0x6c(%ebp)
    2000:	57                   	push   %edi
    2001:	e8 64 f3 ff ff       	call   136a <APDcCopy>
    2006:	83 c4 30             	add    $0x30,%esp
                    break;
    2009:	e9 15 01 00 00       	jmp    2123 <APGridPaint+0x791>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    200e:	8d 45 cf             	lea    -0x31(%ebp),%eax
    2011:	6a 0c                	push   $0xc
    2013:	6a 0c                	push   $0xc
    2015:	6a 0c                	push   $0xc
    2017:	50                   	push   %eax
    2018:	e8 f1 f4 ff ff       	call   150e <RGB>
    201d:	83 c4 0c             	add    $0xc,%esp
    2020:	8b 1d f0 69 00 00    	mov    0x69f0,%ebx
    2026:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2029:	6b c8 32             	imul   $0x32,%eax,%ecx
    202c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    202f:	6b c0 32             	imul   $0x32,%eax,%eax
    2032:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2035:	8b 45 08             	mov    0x8(%ebp),%eax
    2038:	8d 78 3c             	lea    0x3c(%eax),%edi
    203b:	83 ec 0c             	sub    $0xc,%esp
    203e:	83 ec 04             	sub    $0x4,%esp
    2041:	89 e0                	mov    %esp,%eax
    2043:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    2047:	66 89 30             	mov    %si,(%eax)
    204a:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    204e:	88 50 02             	mov    %dl,0x2(%eax)
    2051:	6a 32                	push   $0x32
    2053:	6a 32                	push   $0x32
    2055:	6a 00                	push   $0x0
    2057:	6a 00                	push   $0x0
    2059:	53                   	push   %ebx
    205a:	51                   	push   %ecx
    205b:	ff 75 94             	pushl  -0x6c(%ebp)
    205e:	57                   	push   %edi
    205f:	e8 06 f3 ff ff       	call   136a <APDcCopy>
    2064:	83 c4 30             	add    $0x30,%esp
                    break;
    2067:	e9 b7 00 00 00       	jmp    2123 <APGridPaint+0x791>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    206c:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    206f:	6a 0c                	push   $0xc
    2071:	6a 0c                	push   $0xc
    2073:	6a 0c                	push   $0xc
    2075:	50                   	push   %eax
    2076:	e8 93 f4 ff ff       	call   150e <RGB>
    207b:	83 c4 0c             	add    $0xc,%esp
    207e:	8b 1d 4c 6a 00 00    	mov    0x6a4c,%ebx
    2084:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2087:	6b c8 32             	imul   $0x32,%eax,%ecx
    208a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    208d:	6b c0 32             	imul   $0x32,%eax,%eax
    2090:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2093:	8b 45 08             	mov    0x8(%ebp),%eax
    2096:	8d 78 3c             	lea    0x3c(%eax),%edi
    2099:	83 ec 0c             	sub    $0xc,%esp
    209c:	83 ec 04             	sub    $0x4,%esp
    209f:	89 e0                	mov    %esp,%eax
    20a1:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    20a5:	66 89 30             	mov    %si,(%eax)
    20a8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    20ac:	88 50 02             	mov    %dl,0x2(%eax)
    20af:	6a 32                	push   $0x32
    20b1:	6a 32                	push   $0x32
    20b3:	6a 00                	push   $0x0
    20b5:	6a 00                	push   $0x0
    20b7:	53                   	push   %ebx
    20b8:	51                   	push   %ecx
    20b9:	ff 75 94             	pushl  -0x6c(%ebp)
    20bc:	57                   	push   %edi
    20bd:	e8 a8 f2 ff ff       	call   136a <APDcCopy>
    20c2:	83 c4 30             	add    $0x30,%esp
                    break;
    20c5:	eb 5c                	jmp    2123 <APGridPaint+0x791>
                case GRID_PROGRAM_TOWER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_tower,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    20c7:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    20ca:	6a 0c                	push   $0xc
    20cc:	6a 0c                	push   $0xc
    20ce:	6a 0c                	push   $0xc
    20d0:	50                   	push   %eax
    20d1:	e8 38 f4 ff ff       	call   150e <RGB>
    20d6:	83 c4 0c             	add    $0xc,%esp
    20d9:	8b 1d 08 6a 00 00    	mov    0x6a08,%ebx
    20df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20e2:	6b c8 32             	imul   $0x32,%eax,%ecx
    20e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    20e8:	6b c0 32             	imul   $0x32,%eax,%eax
    20eb:	89 45 94             	mov    %eax,-0x6c(%ebp)
    20ee:	8b 45 08             	mov    0x8(%ebp),%eax
    20f1:	8d 78 3c             	lea    0x3c(%eax),%edi
    20f4:	83 ec 0c             	sub    $0xc,%esp
    20f7:	83 ec 04             	sub    $0x4,%esp
    20fa:	89 e0                	mov    %esp,%eax
    20fc:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2100:	66 89 30             	mov    %si,(%eax)
    2103:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2107:	88 50 02             	mov    %dl,0x2(%eax)
    210a:	6a 32                	push   $0x32
    210c:	6a 32                	push   $0x32
    210e:	6a 00                	push   $0x0
    2110:	6a 00                	push   $0x0
    2112:	53                   	push   %ebx
    2113:	51                   	push   %ecx
    2114:	ff 75 94             	pushl  -0x6c(%ebp)
    2117:	57                   	push   %edi
    2118:	e8 4d f2 ff ff       	call   136a <APDcCopy>
    211d:	83 c4 30             	add    $0x30,%esp
                    break;
    2120:	eb 01                	jmp    2123 <APGridPaint+0x791>
                default: break;
    2122:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2123:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2127:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    212b:	0f 8e be fb ff ff    	jle    1cef <APGridPaint+0x35d>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2131:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2135:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2139:	0f 8e a4 fb ff ff    	jle    1ce3 <APGridPaint+0x351>
                    break;
                default: break;
            }
        }
    }
}
    213f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2142:	5b                   	pop    %ebx
    2143:	5e                   	pop    %esi
    2144:	5f                   	pop    %edi
    2145:	5d                   	pop    %ebp
    2146:	c3                   	ret    

00002147 <updateword>:


void updateword(AHwnd hwnd,char* str)
{
    2147:	55                   	push   %ebp
    2148:	89 e5                	mov    %esp,%ebp
    214a:	53                   	push   %ebx
    214b:	83 ec 24             	sub    $0x24,%esp
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    214e:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2151:	68 cd 00 00 00       	push   $0xcd
    2156:	6a 74                	push   $0x74
    2158:	6a 18                	push   $0x18
    215a:	50                   	push   %eax
    215b:	e8 ae f3 ff ff       	call   150e <RGB>
    2160:	83 c4 0c             	add    $0xc,%esp
    2163:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2167:	66 89 45 f0          	mov    %ax,-0x10(%ebp)
    216b:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    216f:	88 45 f2             	mov    %al,-0xe(%ebp)
    pen.size = 1;
    2172:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2179:	8d 45 d8             	lea    -0x28(%ebp),%eax
    217c:	68 cd 00 00 00       	push   $0xcd
    2181:	6a 74                	push   $0x74
    2183:	6a 18                	push   $0x18
    2185:	50                   	push   %eax
    2186:	e8 83 f3 ff ff       	call   150e <RGB>
    218b:	83 c4 0c             	add    $0xc,%esp
    218e:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2192:	66 89 45 ed          	mov    %ax,-0x13(%ebp)
    2196:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    219a:	88 45 ef             	mov    %al,-0x11(%ebp)
    APSetPen(&hwnd->TitleDc,pen);
    219d:	8b 45 08             	mov    0x8(%ebp),%eax
    21a0:	8d 50 58             	lea    0x58(%eax),%edx
    21a3:	8d 45 d8             	lea    -0x28(%ebp),%eax
    21a6:	ff 75 f4             	pushl  -0xc(%ebp)
    21a9:	ff 75 f0             	pushl  -0x10(%ebp)
    21ac:	52                   	push   %edx
    21ad:	50                   	push   %eax
    21ae:	e8 48 ea ff ff       	call   bfb <APSetPen>
    21b3:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&hwnd->TitleDc,brush);
    21b6:	8b 45 08             	mov    0x8(%ebp),%eax
    21b9:	8d 58 58             	lea    0x58(%eax),%ebx
    21bc:	8d 55 d8             	lea    -0x28(%ebp),%edx
    21bf:	83 ec 04             	sub    $0x4,%esp
    21c2:	83 ec 04             	sub    $0x4,%esp
    21c5:	89 e0                	mov    %esp,%eax
    21c7:	0f b7 4d ed          	movzwl -0x13(%ebp),%ecx
    21cb:	66 89 08             	mov    %cx,(%eax)
    21ce:	0f b6 4d ef          	movzbl -0x11(%ebp),%ecx
    21d2:	88 48 02             	mov    %cl,0x2(%eax)
    21d5:	53                   	push   %ebx
    21d6:	52                   	push   %edx
    21d7:	e8 58 ea ff ff       	call   c34 <APSetBrush>
    21dc:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&hwnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    21df:	8b 45 08             	mov    0x8(%ebp),%eax
    21e2:	83 c0 58             	add    $0x58,%eax
    21e5:	83 ec 0c             	sub    $0xc,%esp
    21e8:	6a 32                	push   $0x32
    21ea:	68 20 03 00 00       	push   $0x320
    21ef:	6a 00                	push   $0x0
    21f1:	6a 00                	push   $0x0
    21f3:	50                   	push   %eax
    21f4:	e8 65 ee ff ff       	call   105e <APDrawRect>
    21f9:	83 c4 20             	add    $0x20,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    21fc:	8d 45 d8             	lea    -0x28(%ebp),%eax
    21ff:	6a 08                	push   $0x8
    2201:	6a 08                	push   $0x8
    2203:	6a 08                	push   $0x8
    2205:	50                   	push   %eax
    2206:	e8 03 f3 ff ff       	call   150e <RGB>
    220b:	83 c4 0c             	add    $0xc,%esp
    220e:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2212:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    2216:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    221a:	88 45 ec             	mov    %al,-0x14(%ebp)
    APSetFont(&hwnd->TitleDc,font);
    221d:	8b 45 08             	mov    0x8(%ebp),%eax
    2220:	8d 58 58             	lea    0x58(%eax),%ebx
    2223:	8d 55 d8             	lea    -0x28(%ebp),%edx
    2226:	83 ec 04             	sub    $0x4,%esp
    2229:	83 ec 04             	sub    $0x4,%esp
    222c:	89 e0                	mov    %esp,%eax
    222e:	0f b7 4d ea          	movzwl -0x16(%ebp),%ecx
    2232:	66 89 08             	mov    %cx,(%eax)
    2235:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
    2239:	88 48 02             	mov    %cl,0x2(%eax)
    223c:	53                   	push   %ebx
    223d:	52                   	push   %edx
    223e:	e8 33 ea ff ff       	call   c76 <APSetFont>
    2243:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&hwnd->TitleDc,str,10,20);
    2246:	8b 45 08             	mov    0x8(%ebp),%eax
    2249:	83 c0 58             	add    $0x58,%eax
    224c:	6a 14                	push   $0x14
    224e:	6a 0a                	push   $0xa
    2250:	ff 75 0c             	pushl  0xc(%ebp)
    2253:	50                   	push   %eax
    2254:	e8 0a f0 ff ff       	call   1263 <APDrawText>
    2259:	83 c4 10             	add    $0x10,%esp
}
    225c:	90                   	nop
    225d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2260:	c9                   	leave  
    2261:	c3                   	ret    

00002262 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2262:	55                   	push   %ebp
    2263:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2265:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2269:	7e 08                	jle    2273 <random+0x11>
{
rand_num = seed;
    226b:	8b 45 08             	mov    0x8(%ebp),%eax
    226e:	a3 a0 69 00 00       	mov    %eax,0x69a0
}
rand_num *= 3;
    2273:	8b 15 a0 69 00 00    	mov    0x69a0,%edx
    2279:	89 d0                	mov    %edx,%eax
    227b:	01 c0                	add    %eax,%eax
    227d:	01 d0                	add    %edx,%eax
    227f:	a3 a0 69 00 00       	mov    %eax,0x69a0
if (rand_num < 0)
    2284:	a1 a0 69 00 00       	mov    0x69a0,%eax
    2289:	85 c0                	test   %eax,%eax
    228b:	79 0c                	jns    2299 <random+0x37>
{
rand_num *= (-1);
    228d:	a1 a0 69 00 00       	mov    0x69a0,%eax
    2292:	f7 d8                	neg    %eax
    2294:	a3 a0 69 00 00       	mov    %eax,0x69a0
}
return rand_num % 997;
    2299:	8b 0d a0 69 00 00    	mov    0x69a0,%ecx
    229f:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    22a4:	89 c8                	mov    %ecx,%eax
    22a6:	f7 ea                	imul   %edx
    22a8:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    22ab:	c1 f8 09             	sar    $0x9,%eax
    22ae:	89 c2                	mov    %eax,%edx
    22b0:	89 c8                	mov    %ecx,%eax
    22b2:	c1 f8 1f             	sar    $0x1f,%eax
    22b5:	29 c2                	sub    %eax,%edx
    22b7:	89 d0                	mov    %edx,%eax
    22b9:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    22bf:	29 c1                	sub    %eax,%ecx
    22c1:	89 c8                	mov    %ecx,%eax
}
    22c3:	5d                   	pop    %ebp
    22c4:	c3                   	ret    

000022c5 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    22c5:	55                   	push   %ebp
    22c6:	89 e5                	mov    %esp,%ebp
    22c8:	53                   	push   %ebx
    22c9:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    22cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    22d3:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    22d7:	74 17                	je     22f0 <sprintint+0x2b>
    22d9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    22dd:	79 11                	jns    22f0 <sprintint+0x2b>
        neg = 1;
    22df:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    22e6:	8b 45 10             	mov    0x10(%ebp),%eax
    22e9:	f7 d8                	neg    %eax
    22eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    22ee:	eb 06                	jmp    22f6 <sprintint+0x31>
    } else {
        x = xx;
    22f0:	8b 45 10             	mov    0x10(%ebp),%eax
    22f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    22f6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    22fd:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2300:	8d 41 01             	lea    0x1(%ecx),%eax
    2303:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2306:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2309:	8b 45 f0             	mov    -0x10(%ebp),%eax
    230c:	ba 00 00 00 00       	mov    $0x0,%edx
    2311:	f7 f3                	div    %ebx
    2313:	89 d0                	mov    %edx,%eax
    2315:	0f b6 80 a4 69 00 00 	movzbl 0x69a4(%eax),%eax
    231c:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2320:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2323:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2326:	ba 00 00 00 00       	mov    $0x0,%edx
    232b:	f7 f3                	div    %ebx
    232d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2330:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2334:	75 c7                	jne    22fd <sprintint+0x38>
    if(neg)
    2336:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    233a:	74 0e                	je     234a <sprintint+0x85>
        buf[i++] = '-';
    233c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    233f:	8d 50 01             	lea    0x1(%eax),%edx
    2342:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2345:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    234a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    234d:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2350:	eb 1b                	jmp    236d <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2352:	8b 45 0c             	mov    0xc(%ebp),%eax
    2355:	8b 00                	mov    (%eax),%eax
    2357:	8d 48 01             	lea    0x1(%eax),%ecx
    235a:	8b 55 0c             	mov    0xc(%ebp),%edx
    235d:	89 0a                	mov    %ecx,(%edx)
    235f:	89 c2                	mov    %eax,%edx
    2361:	8b 45 08             	mov    0x8(%ebp),%eax
    2364:	01 d0                	add    %edx,%eax
    2366:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2369:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    236d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2371:	7f df                	jg     2352 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2373:	eb 21                	jmp    2396 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2375:	8b 45 0c             	mov    0xc(%ebp),%eax
    2378:	8b 00                	mov    (%eax),%eax
    237a:	8d 48 01             	lea    0x1(%eax),%ecx
    237d:	8b 55 0c             	mov    0xc(%ebp),%edx
    2380:	89 0a                	mov    %ecx,(%edx)
    2382:	89 c2                	mov    %eax,%edx
    2384:	8b 45 08             	mov    0x8(%ebp),%eax
    2387:	01 c2                	add    %eax,%edx
    2389:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    238c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    238f:	01 c8                	add    %ecx,%eax
    2391:	0f b6 00             	movzbl (%eax),%eax
    2394:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2396:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    239a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    239e:	79 d5                	jns    2375 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    23a0:	90                   	nop
    23a1:	83 c4 20             	add    $0x20,%esp
    23a4:	5b                   	pop    %ebx
    23a5:	5d                   	pop    %ebp
    23a6:	c3                   	ret    

000023a7 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    23a7:	55                   	push   %ebp
    23a8:	89 e5                	mov    %esp,%ebp
    23aa:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    23ad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    23b4:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    23bb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    23c2:	8d 45 0c             	lea    0xc(%ebp),%eax
    23c5:	83 c0 04             	add    $0x4,%eax
    23c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    23cb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    23d2:	e9 d9 01 00 00       	jmp    25b0 <sprintf+0x209>
        c = fmt[i] & 0xff;
    23d7:	8b 55 0c             	mov    0xc(%ebp),%edx
    23da:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23dd:	01 d0                	add    %edx,%eax
    23df:	0f b6 00             	movzbl (%eax),%eax
    23e2:	0f be c0             	movsbl %al,%eax
    23e5:	25 ff 00 00 00       	and    $0xff,%eax
    23ea:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    23ed:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    23f1:	75 2c                	jne    241f <sprintf+0x78>
            if(c == '%'){
    23f3:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    23f7:	75 0c                	jne    2405 <sprintf+0x5e>
                state = '%';
    23f9:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2400:	e9 a7 01 00 00       	jmp    25ac <sprintf+0x205>
            } else {
                dst[j++] = c;
    2405:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2408:	8d 50 01             	lea    0x1(%eax),%edx
    240b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    240e:	89 c2                	mov    %eax,%edx
    2410:	8b 45 08             	mov    0x8(%ebp),%eax
    2413:	01 d0                	add    %edx,%eax
    2415:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2418:	88 10                	mov    %dl,(%eax)
    241a:	e9 8d 01 00 00       	jmp    25ac <sprintf+0x205>
            }
        } else if(state == '%'){
    241f:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2423:	0f 85 83 01 00 00    	jne    25ac <sprintf+0x205>
            if(c == 'd'){
    2429:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    242d:	75 4c                	jne    247b <sprintf+0xd4>
                buf[bi] = '\0';
    242f:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2432:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2435:	01 d0                	add    %edx,%eax
    2437:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    243a:	83 ec 0c             	sub    $0xc,%esp
    243d:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2440:	50                   	push   %eax
    2441:	e8 0f de ff ff       	call   255 <atoi>
    2446:	83 c4 10             	add    $0x10,%esp
    2449:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    244c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2453:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2456:	8b 00                	mov    (%eax),%eax
    2458:	83 ec 08             	sub    $0x8,%esp
    245b:	ff 75 d8             	pushl  -0x28(%ebp)
    245e:	6a 01                	push   $0x1
    2460:	6a 0a                	push   $0xa
    2462:	50                   	push   %eax
    2463:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2466:	50                   	push   %eax
    2467:	ff 75 08             	pushl  0x8(%ebp)
    246a:	e8 56 fe ff ff       	call   22c5 <sprintint>
    246f:	83 c4 20             	add    $0x20,%esp
                ap++;
    2472:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2476:	e9 2a 01 00 00       	jmp    25a5 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    247b:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    247f:	74 06                	je     2487 <sprintf+0xe0>
    2481:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2485:	75 4c                	jne    24d3 <sprintf+0x12c>
                buf[bi] = '\0';
    2487:	8d 55 ce             	lea    -0x32(%ebp),%edx
    248a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    248d:	01 d0                	add    %edx,%eax
    248f:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2492:	83 ec 0c             	sub    $0xc,%esp
    2495:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2498:	50                   	push   %eax
    2499:	e8 b7 dd ff ff       	call   255 <atoi>
    249e:	83 c4 10             	add    $0x10,%esp
    24a1:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    24a4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    24ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24ae:	8b 00                	mov    (%eax),%eax
    24b0:	83 ec 08             	sub    $0x8,%esp
    24b3:	ff 75 dc             	pushl  -0x24(%ebp)
    24b6:	6a 00                	push   $0x0
    24b8:	6a 10                	push   $0x10
    24ba:	50                   	push   %eax
    24bb:	8d 45 c8             	lea    -0x38(%ebp),%eax
    24be:	50                   	push   %eax
    24bf:	ff 75 08             	pushl  0x8(%ebp)
    24c2:	e8 fe fd ff ff       	call   22c5 <sprintint>
    24c7:	83 c4 20             	add    $0x20,%esp
                ap++;
    24ca:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    24ce:	e9 d2 00 00 00       	jmp    25a5 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    24d3:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    24d7:	75 46                	jne    251f <sprintf+0x178>
                s = (char*)*ap;
    24d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24dc:	8b 00                	mov    (%eax),%eax
    24de:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    24e1:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    24e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    24e9:	75 25                	jne    2510 <sprintf+0x169>
                    s = "(null)";
    24eb:	c7 45 f4 b0 27 00 00 	movl   $0x27b0,-0xc(%ebp)
                while(*s != 0){
    24f2:	eb 1c                	jmp    2510 <sprintf+0x169>
                    dst[j++] = *s;
    24f4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24f7:	8d 50 01             	lea    0x1(%eax),%edx
    24fa:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24fd:	89 c2                	mov    %eax,%edx
    24ff:	8b 45 08             	mov    0x8(%ebp),%eax
    2502:	01 c2                	add    %eax,%edx
    2504:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2507:	0f b6 00             	movzbl (%eax),%eax
    250a:	88 02                	mov    %al,(%edx)
                    s++;
    250c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2510:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2513:	0f b6 00             	movzbl (%eax),%eax
    2516:	84 c0                	test   %al,%al
    2518:	75 da                	jne    24f4 <sprintf+0x14d>
    251a:	e9 86 00 00 00       	jmp    25a5 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    251f:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2523:	75 1d                	jne    2542 <sprintf+0x19b>
                dst[j++] = *ap;
    2525:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2528:	8d 50 01             	lea    0x1(%eax),%edx
    252b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    252e:	89 c2                	mov    %eax,%edx
    2530:	8b 45 08             	mov    0x8(%ebp),%eax
    2533:	01 c2                	add    %eax,%edx
    2535:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2538:	8b 00                	mov    (%eax),%eax
    253a:	88 02                	mov    %al,(%edx)
                ap++;
    253c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2540:	eb 63                	jmp    25a5 <sprintf+0x1fe>
            } else if(c == '%'){
    2542:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2546:	75 17                	jne    255f <sprintf+0x1b8>
                dst[j++] = c;
    2548:	8b 45 c8             	mov    -0x38(%ebp),%eax
    254b:	8d 50 01             	lea    0x1(%eax),%edx
    254e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2551:	89 c2                	mov    %eax,%edx
    2553:	8b 45 08             	mov    0x8(%ebp),%eax
    2556:	01 d0                	add    %edx,%eax
    2558:	8b 55 e0             	mov    -0x20(%ebp),%edx
    255b:	88 10                	mov    %dl,(%eax)
    255d:	eb 46                	jmp    25a5 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    255f:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2563:	7e 18                	jle    257d <sprintf+0x1d6>
    2565:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2569:	7f 12                	jg     257d <sprintf+0x1d6>
            {
                buf[bi++] = c;
    256b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    256e:	8d 50 01             	lea    0x1(%eax),%edx
    2571:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2574:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2577:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    257b:	eb 2f                	jmp    25ac <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    257d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2580:	8d 50 01             	lea    0x1(%eax),%edx
    2583:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2586:	89 c2                	mov    %eax,%edx
    2588:	8b 45 08             	mov    0x8(%ebp),%eax
    258b:	01 d0                	add    %edx,%eax
    258d:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2590:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2593:	8d 50 01             	lea    0x1(%eax),%edx
    2596:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2599:	89 c2                	mov    %eax,%edx
    259b:	8b 45 08             	mov    0x8(%ebp),%eax
    259e:	01 d0                	add    %edx,%eax
    25a0:	8b 55 e0             	mov    -0x20(%ebp),%edx
    25a3:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    25a5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    25ac:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    25b0:	8b 55 0c             	mov    0xc(%ebp),%edx
    25b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    25b6:	01 d0                	add    %edx,%eax
    25b8:	0f b6 00             	movzbl (%eax),%eax
    25bb:	84 c0                	test   %al,%al
    25bd:	0f 85 14 fe ff ff    	jne    23d7 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    25c3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    25c6:	8d 50 01             	lea    0x1(%eax),%edx
    25c9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    25cc:	89 c2                	mov    %eax,%edx
    25ce:	8b 45 08             	mov    0x8(%ebp),%eax
    25d1:	01 d0                	add    %edx,%eax
    25d3:	c6 00 00             	movb   $0x0,(%eax)
}
    25d6:	90                   	nop
    25d7:	c9                   	leave  
    25d8:	c3                   	ret    
